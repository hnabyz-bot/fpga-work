---------------------------------------------------------------------
-- Date					: 
-- Designer				: 
-- File name			: 
-- Description			: 
-- Revision History	: 
---------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ctrl_FSM is
port(
		fsm_clk                      : in std_logic;
		rst                          : in std_logic;
		fsm_drv_rst							: in std_logic;
	
		reset_FSM                    : in std_logic;
	
		-- dummy_get_image              : in std_logic;
		burst_get_image              : in std_logic;
		get_dark                     : in std_logic;
		get_bright                   : in std_logic;
		cmd_get_bright               : in std_logic;

		cycle_width                  : in std_logic_vector(23 downto 0);
		image_height                 : in std_logic_vector(15 downto 0);
		dsp_image_height             : in std_logic_vector(15 downto 0);
		frame_rpt                    : in std_logic_vector(7 downto 0);
		saturation_flush_repeat      : in std_logic_vector(7 downto 0);
		ready_aed_read               : in std_logic_vector(15 downto 0);
		aed_dark_delay               : in std_logic_vector(15 downto 0);
		readout_count				: in std_logic_vector(15 downto 0);

		en_aed						: in std_logic;

		aed_read_image_height		: in std_logic_vector(15 downto 0);
		disable_aed_read_xao		: in std_logic;
		on_aed_dark_trigger			: in std_logic; -- 2021.05.24 ver38
		on_aed_trigger               : in std_logic;

		en_back_bias                 : in std_logic;
		en_flush                     : in std_logic;
		en_panel_stable              : in std_logic;

		col_end                      : out std_logic;
		row_end                      : out std_logic;

		FSM_rst_index                : out std_logic;
		FSM_init_index               : out std_logic;
		FSM_back_bias_index          : out std_logic;
		FSM_flush_index              : out std_logic;
		FSM_aed_read_index           : out std_logic;
		FSM_exp_index                : out std_logic;
		FSM_read_index               : out std_logic;

		ready_to_get_image           : out std_logic;

		aed_ready_done				: out std_logic;
		aed_ready_done_dark			: out std_logic; -- 2021.05.21 ver29

		panel_stable_exist			: out std_logic;
		exp_read_exist				: out std_logic;

		valid_posi_flag				: out std_logic;
		valid_nega_flag				: out std_logic;

		row_cnt						: out std_logic_vector(15 downto 0);
		col_cnt						: out std_logic_vector(15 downto 0);

		-- gate_xao					: out std_logic; --191011, kkh
		-- gate_xao_0					: out std_logic; --191014, kkh
		-- gate_xao_1					: out std_logic; --191014, kkh
		-- gate_xao_2					: out std_logic; --191014, kkh
		-- gate_xao_3					: out std_logic; --191014, kkh
		-- gate_xao_4					: out std_logic; --191014, kkh
		gate_cpv_init				: out std_logic
); end ctrl_FSM;


architecture Behavioral of ctrl_FSM is

	-- ---------------------------------------------------------------------------------------- for configuration 

	constant FSM_rst							: std_logic_vector (2 downto 0) := "000";
	constant FSM_init							: std_logic_vector (2 downto 0) := "001";
	constant FSM_back_bias						: std_logic_vector (2 downto 0) := "010";
	constant FSM_flush							: std_logic_vector (2 downto 0) := "011";
	constant FSM_aed_read						: std_logic_vector (2 downto 0) := "100";
	constant FSM_exp							: std_logic_vector (2 downto 0) := "101";
	constant FSM_read							: std_logic_vector (2 downto 0) := "110";

	CONSTANT INIT_CYCLE_WIDTH 					: STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"0030"; -- 'd48
	CONSTANT INIT_HALF_CYCLE_WIDTH 				: STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"0018"; -- 'd24

	CONSTANT DN_AED_GATE_XAO_0					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0002"; -- 2
	CONSTANT DN_AED_GATE_XAO_1					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"005A"; -- 90
	CONSTANT DN_AED_GATE_XAO_2					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"00B4"; -- 180
	CONSTANT DN_AED_GATE_XAO_3					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"010E"; -- 270
	CONSTANT DN_AED_GATE_XAO_4					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0168"; -- 360
	CONSTANT DN_AED_GATE_XAO_5					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"01C2"; -- 450

	CONSTANT UP_AED_GATE_XAO_0					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0C86"; -- 3206
	CONSTANT UP_AED_GATE_XAO_1					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0CE0"; -- 3296
	CONSTANT UP_AED_GATE_XAO_2					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0D3A"; -- 3386
	CONSTANT UP_AED_GATE_XAO_3					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0D94"; -- 3476
	CONSTANT UP_AED_GATE_XAO_4					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0DEE"; -- 3566
	CONSTANT UP_AED_GATE_XAO_5					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0E49"; -- 3657

	signal FSM_state  							: std_logic_vector(2 downto 0) :="000";

--------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------- for simulation

	-- type Status is (
	-- 	FSM_rst			,
	-- 	FSM_init		,
	-- 	FSM_back_bias	,
	-- 	FSM_flush		,
	-- 	FSM_aed_read	,
	-- 	FSM_exp			,
	-- 	FSM_read
	-- );
	
	-- signal FSM_state  : Status;

	-- CONSTANT INIT_CYCLE_WIDTH 					: STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"000A"; -- 'd48
	-- CONSTANT INIT_HALF_CYCLE_WIDTH 				: STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"0005"; -- 'd24

	-- CONSTANT DN_AED_GATE_XAO_0					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0002"; -- 2
	-- CONSTANT DN_AED_GATE_XAO_1					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0005"; -- 5
	-- CONSTANT DN_AED_GATE_XAO_2					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0008"; -- 8
	-- CONSTANT DN_AED_GATE_XAO_3					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"000B"; -- 11
	-- CONSTANT DN_AED_GATE_XAO_4					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"000E"; -- 14
	-- CONSTANT DN_AED_GATE_XAO_5					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0011"; -- 17

	-- CONSTANT UP_AED_GATE_XAO_0					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0055"; -- 85
	-- CONSTANT UP_AED_GATE_XAO_1					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0058"; -- 88
	-- CONSTANT UP_AED_GATE_XAO_2					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"005B"; -- 91
	-- CONSTANT UP_AED_GATE_XAO_3					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"005E"; -- 94
	-- CONSTANT UP_AED_GATE_XAO_4					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0061"; -- 97
	-- CONSTANT UP_AED_GATE_XAO_5					: STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0064"; -- 100

--------------------------------------------------------------------------------------------

	signal sig_FSM_rst_index : std_logic :='0';
	signal sig_FSM_init_index : std_logic :='0';
	signal sig_FSM_back_bias_index : std_logic :='0';
	signal sig_FSM_flush_index : std_logic :='0';
	signal sig_FSM_aed_read_index : std_logic :='0';
	signal sig_FSM_exp_index : std_logic :='0';
	signal sig_FSM_read_index : std_logic :='0';

	signal static_rst : std_logic :='1';
	signal aed_rst : std_logic :='0';

	signal init_gate : std_logic :='0';
	signal hi_init_gate : std_logic :='0';
	signal lo_init_gate : std_logic :='0';

	signal gate_cpv : std_logic :='0';

	signal init_col_cnt : std_logic_vector(15 downto 0) :="0000000000000001";
	signal init_row_cnt : std_logic_vector(15 downto 0) :="0000000000000001";

	signal fsm_rst_end_tmp1 : std_logic :='0';
	signal fsm_rst_end_tmp2 : std_logic :='0';
	signal fsm_rst_end : std_logic :='0';
	signal fsm_init_end : std_logic :='0';
	signal fsm_back_bias_end : std_logic :='0';
	signal fsm_flush_end : std_logic :='0';
	signal fsm_flush_end_1d : std_logic :='0';
	signal fsm_aed_read_end : std_logic :='0';
	signal fsm_exp_end : std_logic :='0';
	signal fsm_read_end : std_logic :='0';
	signal fsm_read_end_1d : std_logic :='0';

	signal fsm_exp_end_tmp1 : std_logic :='0';
	signal fsm_exp_end_tmp2 : std_logic :='0';
	
	signal fsm_exp_end_pre : std_logic :='0';
	signal fsm_exp_end_dly : std_logic :='0';

	signal inc_repeat_cnt_modify : std_logic :='0';
	signal inc_repeat_cnt : std_logic :='0';
	signal inc_frame_cnt : std_logic :='0';
	signal inc_row_cnt   : std_logic :='0';
	signal inc_col_cnt   : std_logic :='0';

	signal rst_repeat_cnt_modify 	: std_logic :='0';
	signal rst_repeat_cnt_modify_1d : std_logic :='0';
	signal rst_repeat_cnt : std_logic :='0';
	signal rst_frame_cnt : std_logic :='0';
	signal rst_row_cnt   : std_logic :='0';
	signal rst_col_cnt   : std_logic :='0';

	signal repeat_cnt : std_logic_vector(7 downto 0)  :="00000001";
	signal sig_frame_cnt : std_logic_vector(7 downto 0)  :="00000001";
	signal sig_row_cnt   : std_logic_vector(15 downto 0) :="0000000000000001";
	signal sig_col_cnt   : std_logic_vector(23 downto 0) :="000000000000000000000001";

	signal col_end_pre1 : std_logic :='0';
	signal col_end_pre2 : std_logic :='0';
	signal col_end_pre3 : std_logic :='0';
	signal sig_col_end : std_logic :='0';
	signal row_end_pre1 : std_logic :='0';
	signal row_end_pre2 : std_logic :='0';
	signal sig_row_end : std_logic :='0';
	signal frame_end_pre1 : std_logic :='0';
	signal frame_end : std_logic :='0';
	signal saturation_flush_end_pre1 : std_logic :='0';
	signal saturation_flush_end : std_logic :='0';
	signal saturation_flush_end_1d : std_logic :='0';

	signal reset_FSM_1d : std_logic :='0';
	signal reset_FSM_2d : std_logic :='0';
	signal up_go_rst : std_logic :='0';
	signal go_rst : std_logic :='0';

	signal s_get_image : std_logic :='0';
	signal s_get_image_1d : std_logic :='0';
	signal s_get_image_2d : std_logic :='0';
	signal get_image : std_logic :='0';
	signal get_image_1d : std_logic :='0';
	signal get_image_2d : std_logic :='0';

	signal pending_get_dark : std_logic :='0';

	signal AED_get_dark_delay_1d : std_logic :='0';
	signal AED_get_dark_delay_2d : std_logic :='0';

	signal valid_get_ORG_image : std_logic :='0';
	signal lo_valid_get_ORG_image_1 : std_logic :='0';
	signal lo_valid_get_ORG_image_2 : std_logic :='0';
	signal lo_valid_get_ORG_image_3 : std_logic :='0';

	signal ORG_fsm_rst_start   : std_logic :='0';
	signal ORG_fsm_init_start  : std_logic :='0';
	signal ORG_fsm_back_bias_start : std_logic :='0';
	signal ORG_fsm_flush_start : std_logic :='0';
	signal ORG_fsm_exp_start   : std_logic :='0';
	signal ORG_fsm_read_start  : std_logic :='0';

	signal ORG_fsm_back_bias_start_pre1 : std_logic :='0';
	signal ORG_fsm_back_bias_start_pre2 : std_logic :='0';

	signal ORG_fsm_flush_start_pre1 : std_logic :='0';
	signal ORG_fsm_flush_start_pre2 : std_logic :='0';

	signal ORG_fsm_exp_start_pre1 : std_logic :='0';
	signal ORG_fsm_exp_start_pre2 : std_logic :='0';

	signal ORG_fsm_rst_start_tmp1 : std_logic :='0';
	signal ORG_fsm_rst_start_tmp2 : std_logic :='0';
	signal ORG_fsm_rst_start_tmp3 : std_logic :='0';
	signal ORG_fsm_back_bias_start_tmp1 : std_logic :='0';
	signal ORG_fsm_back_bias_start_tmp2 : std_logic :='0';
	signal ORG_fsm_back_bias_start_tmp3 : std_logic :='0';
	signal ORG_fsm_back_bias_start_tmp4 : std_logic :='0';
	signal ORG_fsm_flush_start_tmp1 : std_logic :='0';
	signal ORG_fsm_flush_start_tmp2 : std_logic :='0';
	signal ORG_fsm_flush_start_tmp3 : std_logic :='0';
	signal ORG_fsm_flush_start_tmp4 : std_logic :='0';
	signal ORG_fsm_exp_start_tmp1 : std_logic :='0';
	signal ORG_fsm_exp_start_tmp2 : std_logic :='0';
	signal ORG_fsm_exp_start_tmp3 : std_logic :='0';
	signal ORG_fsm_exp_start_tmp4 : std_logic :='0';

	signal valid_get_PSm_image : std_logic :='0';
	signal lo_valid_get_PSm_image_1 : std_logic :='0';
	signal lo_valid_get_PSm_image_2 : std_logic :='0';
	signal lo_valid_get_PSm_image_3 : std_logic :='0';
	signal lo_valid_get_PSm_image_4 : std_logic :='0';

	signal PSm_fsm_rst_start   : std_logic :='0';
	signal PSm_fsm_init_start  : std_logic :='0';
	signal PSm_fsm_back_bias_start : std_logic :='0';
	signal PSm_fsm_flush_start : std_logic :='0';
	signal PSm_fsm_exp_start   : std_logic :='0';
	signal PSm_fsm_read_start  : std_logic :='0';

	signal PSm_fsm_back_bias_start_pre1 : std_logic :='0';
	signal PSm_fsm_back_bias_start_pre2 : std_logic :='0';

	signal PSm_fsm_flush_start_pre1 : std_logic :='0';
	signal PSm_fsm_flush_start_pre2 : std_logic :='0';

	signal PSm_fsm_exp_start_pre1 : std_logic :='0';
	signal PSm_fsm_exp_start_pre2 : std_logic :='0';

	signal PSm_fsm_rst_start_tmp1 : std_logic :='0';
	signal PSm_fsm_back_bias_start_tmp1 : std_logic :='0';
	signal PSm_fsm_back_bias_start_tmp2 : std_logic :='0';
	signal PSm_fsm_back_bias_start_tmp3 : std_logic :='0';
	signal PSm_fsm_back_bias_start_tmp4 : std_logic :='0';
	signal PSm_fsm_back_bias_start_tmp5 : std_logic :='0';
	signal PSm_fsm_flush_start_tmp1 : std_logic :='0';
	signal PSm_fsm_flush_start_tmp2 : std_logic :='0';
	signal PSm_fsm_flush_start_tmp3 : std_logic :='0';
	signal PSm_fsm_flush_start_tmp4 : std_logic :='0';
	signal PSm_fsm_flush_start_tmp5 : std_logic :='0';
	signal PSm_fsm_exp_start_tmp1 : std_logic :='0';
	signal PSm_fsm_exp_start_tmp2 : std_logic :='0';
	signal PSm_fsm_exp_start_tmp3 : std_logic :='0';
	signal PSm_fsm_exp_start_tmp4 : std_logic :='0';
	signal PSm_fsm_exp_start_tmp5 : std_logic :='0';

	signal PSm_fsm_read_start_tmp1 : std_logic :='0';
	signal PSm_fsm_read_start_tmp2 : std_logic :='0';
	signal PSm_fsm_read_start_tmp3 : std_logic :='0';
	signal PSm_fsm_read_start_tmp4 : std_logic :='0';

	signal aed_ready_cnt : std_logic_vector(15 downto 0) :="0000000000000001";

	signal aed_prepare_delay : std_logic_vector(15 downto 0) :="0000000000000001";
	signal s_ready_aed_read : std_logic_vector(15 downto 0) :="0000000000000001";
	

	signal valid_aed_read : std_logic :='0';

	signal valid_get_dark : std_logic :='0';

	signal AED_fsm_rst_start : std_logic :='0';
	signal AED_fsm_init_start : std_logic :='0';
	signal AED_fsm_back_bias_start : std_logic :='0';
	signal AED_fsm_flush_start : std_logic :='0';
	signal AED_fsm_aed_read_start : std_logic :='0';
	signal AED_fsm_exp_start : std_logic :='0';
	signal AED_fsm_read_start : std_logic :='0';

	signal AED_fsm_rst_start_tmp1 : std_logic :='0';
	signal AED_fsm_back_bias_start_tmp1 : std_logic :='0';
	signal AED_fsm_back_bias_start_tmp2 : std_logic :='0';
	signal AED_fsm_back_bias_start_tmp3 : std_logic :='0';
	signal AED_fsm_back_bias_start_tmp4 : std_logic :='0';
	signal AED_fsm_flush_start_tmp1 : std_logic :='0';
	signal AED_fsm_flush_start_tmp2 : std_logic :='0';
	signal AED_fsm_flush_start_tmp3 : std_logic :='0';
	signal AED_fsm_flush_start_tmp4 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp1 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp2 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp3 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp4 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp5 : std_logic :='0';
	signal AED_fsm_aed_read_start_tmp6 : std_logic :='0';
	signal AED_fsm_exp_start_tmp1 : std_logic :='0';
	signal AED_fsm_exp_start_tmp2 : std_logic :='0';
	signal AED_fsm_read_start_tmp1 : std_logic :='0';
	signal AED_fsm_read_start_tmp2 : std_logic :='0';
	signal AED_fsm_read_start_tmp3 : std_logic :='0';
	signal AED_fsm_read_start_tmp4 : std_logic :='0';

	signal AED_fsm_aed_read_start_pre1 : std_logic :='0';
	signal AED_fsm_aed_read_start_pre2 : std_logic :='0';

	signal fsm_rst_start   : std_logic :='0';
	signal fsm_init_start  : std_logic :='0';
	signal fsm_init_start_1d : std_logic :='0';
	signal fsm_init_start_2d : std_logic :='0';
	signal fsm_back_bias_start : std_logic :='0';
	signal fsm_flush_start : std_logic :='0';
	signal fsm_aed_read_start : std_logic :='0';
	signal fsm_exp_start   : std_logic :='0';
	signal fsm_read_start  : std_logic :='0';

	signal aed_read_xao_line1					: std_logic_vector(15 downto 0) :=(others=>'0');
	signal aed_read_xao_line2					: std_logic_vector(15 downto 0) :=(others=>'0');
	signal aed_read_xao_line3					: std_logic_vector(15 downto 0) :=(others=>'0');

	signal aed_read_xao_valid_tmp				: std_logic := '0';
	signal aed_read_xao_valid					: std_logic := '0';

	signal lo_aed_gate_xao_0					: std_logic := '0';
	signal lo_aed_gate_xao_1					: std_logic := '0';
	signal lo_aed_gate_xao_2					: std_logic := '0';
	signal lo_aed_gate_xao_3					: std_logic := '0';
	signal lo_aed_gate_xao_4					: std_logic := '0';
	signal lo_aed_gate_xao_5					: std_logic := '0';

	signal hi_aed_gate_xao_0					: std_logic := '0';
	signal hi_aed_gate_xao_1					: std_logic := '0';
	signal hi_aed_gate_xao_2					: std_logic := '0';
	signal hi_aed_gate_xao_3					: std_logic := '0';
	signal hi_aed_gate_xao_4					: std_logic := '0';
	signal hi_aed_gate_xao_5					: std_logic := '0';

	signal s_back_bias_flush_exist		: std_logic := '0';
	signal s_last_repeat_cnt			: std_logic := '0';
	signal s_panel_stable_exist			: std_logic := '0';
	signal s_exp_read_exist				: std_logic := '0';
	signal s_inc_multi_readout_cnt		: std_logic := '0';
	signal s_multi_readout_exist		: std_logic := '0';
	signal s_multi_readout_exist_1d		: std_logic := '0';
	signal s_multi_readout_count		: std_logic_vector(15 downto 0) := X"0000";

	attribute MARK_DEBUG : string;
--    -- Marks an internal wire for debug in Vivado hardware manager 
	-- attribute MARK_DEBUG of FSM_state : signal is "TRUE";


begin

	process(fsm_clk, rst)
	begin
		if rst='0' then
			ready_to_get_image <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if en_aed='1' then
				ready_to_get_image <= '0';
			elsif en_panel_stable='1' then
				ready_to_get_image <= (sig_FSM_back_bias_index or sig_FSM_flush_index) and cmd_get_bright;
			elsif en_panel_stable='0' then
				ready_to_get_image <= (sig_FSM_rst_index and not reset_FSM) and cmd_get_bright;
			end if;
		end if;
	end process;

------------------------------------------------------------------------------------
-------------- Gate init CPV generation , CPV : clock signal -----------------------
------------------------------------------------------------------------------------
	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_init_start_1d <= '0';
			fsm_init_start_2d <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			fsm_init_start_1d <= fsm_init_start;
			fsm_init_start_2d <= fsm_init_start_1d;
		end if;
	end process;


	hi_init_gate <= '1' when fsm_init_start_2d='1' else '0';
	lo_init_gate <= '1' when init_gate='1' and init_col_cnt=INIT_CYCLE_WIDTH and init_row_cnt=dsp_image_height else '0';
	process(fsm_clk, rst)
	begin
		if rst='0' then
			init_gate <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if lo_init_gate='1' then
				init_gate <= '0';
			elsif hi_init_gate='1' then
				init_gate <= '1';
			end if;
		end if;
	end process;

	process(fsm_clk, rst)
	begin
		if rst='0' then
			init_col_cnt <= "0000000000000001";
			init_row_cnt <= "0000000000000001";
		elsif fsm_clk'event and fsm_clk='1' then
			if init_gate='0' then 
				init_col_cnt <= "0000000000000001";
				init_row_cnt <= "0000000000000001";
			elsif init_gate='1' then
				if init_col_cnt=INIT_CYCLE_WIDTH then
					init_col_cnt <= "0000000000000001";
					init_row_cnt <= init_row_cnt + 1;
				else
					init_col_cnt <= init_col_cnt + 1;
				end if;				
			end if;				
		end if;
	end process;

	process(fsm_clk, rst)
	begin
		if rst='0' then
			gate_cpv <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if init_gate='0' then
				gate_cpv <= '0';
			elsif init_col_cnt=INIT_HALF_CYCLE_WIDTH or init_col_cnt=INIT_CYCLE_WIDTH then 
				gate_cpv <= not gate_cpv;
			end if;				
		end if;
	end process;

	gate_cpv_init <= gate_cpv;

------------------------------------------------------------------------------------
---------------------------------- ctrl FSM ----------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

---------------- FSM reset condition ------------------
-------------------------------------------------------
	process(fsm_clk, rst)
	begin
		if rst='0' then
			reset_FSM_1d <= '0';
			reset_FSM_2d <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			reset_FSM_1d <= reset_FSM;
			reset_FSM_2d <= reset_FSM_1d;
		end if;
	end process;

	up_go_rst   <= '1' when sig_FSM_rst_index='0' and reset_FSM_1d='1' and reset_FSM_2d='0' else '0';

	process(fsm_clk, rst)
	begin
		if rst='0' then
			go_rst <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if sig_FSM_rst_index='1' then
				go_rst <= '0';
			elsif up_go_rst='1' then
				go_rst <= '1';
			end if;
		end if;
	end process;

------------------------------------------------------------------------------------
---------------------------------- cnt_end -----------------------------------------
------------------------------------------------------------------------------------
	col_end_pre3	<= '1' when (sig_col_cnt=cycle_width) and 
										(FSM_state=FSM_back_bias or 
										FSM_state=FSM_flush or 
										FSM_state=FSM_aed_read or 
										FSM_state=FSM_exp or 
										FSM_state=FSM_read) else '0';

    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		col_end_pre2 <= '0';
    		col_end_pre1 <= '0';
    		sig_col_end      <= '0';
    	elsif fsm_clk'event and fsm_clk='1' then
    		col_end_pre2 <= col_end_pre3;
    		col_end_pre1 <= col_end_pre2;
    		sig_col_end  <= col_end_pre1;
    	end if;
    end process;
	col_end <= sig_col_end;

	row_end_pre2   <= '1' when col_end_pre2='1' and sig_row_cnt=image_height else '0';
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		row_end_pre1 <= '0';
    		sig_row_end  <= '0';
    	elsif fsm_clk'event and fsm_clk='1' then
    		row_end_pre1 <= row_end_pre2;
    		sig_row_end  <= row_end_pre1;
    	end if;
    end process;
	row_end <= sig_row_end;

	frame_end_pre1 <= '1' when row_end_pre1='1' and sig_frame_cnt=frame_rpt  else '0';
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		frame_end      <= '0';
    	elsif fsm_clk'event and fsm_clk='1' then
    		frame_end      <= frame_end_pre1;
    	end if;
    end process;

	saturation_flush_end_pre1 <= '1' when frame_end_pre1='1' and (sig_FSM_flush_index='1' or (sig_FSM_back_bias_index='1' and en_flush='0')) and repeat_cnt=saturation_flush_repeat else '0';
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		saturation_flush_end      <= '0';
    		saturation_flush_end_1d   <= '0';
    	elsif fsm_clk'event and fsm_clk='1' then
    		saturation_flush_end      <= saturation_flush_end_pre1;
    		saturation_flush_end_1d   <= saturation_flush_end;
    	end if;
    end process;

------------------------------------------------------------------------------------
---------------------------------- COUNTER -----------------------------------------
------------------------------------------------------------------------------------

    ----------------------- COUNTER increase condition -----------------------------
    --- repeat counter ---
    inc_repeat_cnt <= '1'	when frame_end ='1' and (sig_FSM_flush_index='1' or (sig_FSM_back_bias_index='1' and en_flush='0')) else '0';
    -- inc_repeat_cnt_modify <= '1'	when s_panel_stable_exist='1' and frame_end_pre1 ='1' 
	-- 									and (sig_FSM_read_index='1' or sig_FSM_flush_index='1' or (sig_FSM_back_bias_index='1' and en_flush='0')) else '0';
    inc_repeat_cnt_modify <= '1'	when frame_end_pre1 ='1' 
										and (sig_FSM_read_index='1' or sig_FSM_flush_index='1' or (sig_FSM_back_bias_index='1' and en_flush='0')) else '0';
    ---- frame counter ---
    inc_frame_cnt <= '1'	when sig_row_end ='1' else '0';
    ----  row counter  ---
    inc_row_cnt <= '1'	    when sig_col_end ='1'	else '0';
    --- column counter ---
    inc_col_cnt <= '1'	    when FSM_state = FSM_back_bias or FSM_state = FSM_flush or FSM_state=FSM_aed_read or FSM_state = FSM_exp or FSM_state = FSM_read
    			   		    else '0';

    ------------------------ COUNTER reset condition -------------------------------
    --- repeat counter ---
    rst_repeat_cnt <= '1'	when saturation_flush_end='1' or (sig_FSM_back_bias_index='0' and sig_FSM_flush_index='0') or sig_FSM_aed_read_index='1' else '0';
    rst_repeat_cnt_modify <= '1'	when FSM_state = FSM_rst or 
									(s_multi_readout_exist='0' and s_exp_read_exist='1' and fsm_read_end='1' and sig_FSM_read_index='1') else '0';
    ---- frame counter ---
    rst_frame_cnt <= '1'	when FSM_state = FSM_rst or frame_end ='1'   or fsm_exp_end_dly = '1' else '0';
    ----  row counter  ---
    rst_row_cnt <= '1'      when FSM_state = FSM_rst or sig_row_end ='1' or fsm_exp_end_dly = '1' else '0';
    --- column counter ---
    rst_col_cnt <= '1'      when FSM_state = FSM_rst or sig_col_end ='1' or fsm_exp_end_dly = '1' else '0';

    ---------------------------- REPEAT COUNTER ------------------------------------
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		repeat_cnt <= "00000001";
			rst_repeat_cnt_modify_1d <= '0';
    	elsif fsm_clk'event and fsm_clk='1' then
    		if rst_repeat_cnt_modify='1' then
    			repeat_cnt <= "00000001";
    		elsif inc_repeat_cnt_modify='1' then
    			repeat_cnt <= repeat_cnt + 1;
    		end if;
			rst_repeat_cnt_modify_1d <= rst_repeat_cnt_modify;
    	end if;
    end process;

    ---------------------------- FRAME COUNTER -------------------------------------
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		sig_frame_cnt <= "00000001";
    	elsif fsm_clk'event and fsm_clk='1' then
    		if rst_frame_cnt='1' then
    			sig_frame_cnt <= "00000001";
    		elsif inc_frame_cnt='1' then
    			sig_frame_cnt <= sig_frame_cnt + 1;
    		end if;
    	end if;
    end process;
    
    ---------------------------- ROW COUNTER ---------------------------------------
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		sig_row_cnt <= "0000000000000001";
    	elsif fsm_clk'event and fsm_clk='1' then
    		if rst_row_cnt='1' then
    			sig_row_cnt <= "0000000000000001";
    		elsif inc_row_cnt='1' then
    			sig_row_cnt <= sig_row_cnt + 1;
    		end if;
    	end if;
    end process;
    	
    --------------------------- COLUMN COUNTER -------------------------------------
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		sig_col_cnt <= "000000000000000000000001";
    	elsif fsm_clk'event and fsm_clk='1' then
    		if rst_col_cnt='1' then
    			sig_col_cnt <= "000000000000000000000001";
    		elsif inc_col_cnt='1' then
    			sig_col_cnt <= sig_col_cnt + 1;
    		end if;
    	end if;
    end process;

	col_cnt   <= sig_col_cnt(15 downto 0);
	row_cnt   <= sig_row_cnt;

------------------------------------------------------------------------------------
----------------------------- FSM end generation -----------------------------------
------------------------------------------------------------------------------------
	-- s_get_image <= get_dark or get_bright;
	s_get_image <= get_dark or get_bright when reset_FSM='0' else '0';

	process(fsm_clk, rst)
	begin
		if rst='0' then
			get_image <= '0';
			get_image_1d <= '0';
			get_image_2d <= '0';
			s_get_image_1d <= '0';
			s_get_image_2d <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if s_last_repeat_cnt='1' and fsm_back_bias_end='1' then
				get_image <= s_get_image;
			elsif s_last_repeat_cnt='0' and s_panel_stable_exist='1' then
				get_image <= '0';
			end if;
			get_image_1d <= get_image;
			get_image_2d <= get_image_1d;
			--
			s_get_image_1d <= s_get_image;
			s_get_image_2d <= s_get_image_1d;
		end if;
	end process;

	fsm_rst_end_tmp1   <= s_get_image_1d and not s_get_image_2d   when FSM_state=FSM_rst and reset_FSM='0' and en_aed='0' and en_panel_stable='0' else '0';
	fsm_rst_end_tmp2   <= not reset_FSM_1d and reset_FSM_2d   when FSM_state=FSM_rst and (en_aed='1' or en_panel_stable='1') else '0';

	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_rst_end <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			fsm_rst_end <= fsm_rst_end_tmp1 or fsm_rst_end_tmp2;
		end if;
	end process;

	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_init_end <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			fsm_init_end <= lo_init_gate and sig_FSM_init_index;
		end if;
	end process;
	
	fsm_back_bias_end <= frame_end_pre1 when FSM_state=FSM_back_bias else '0';
	fsm_flush_end     <= frame_end_pre1 when FSM_state=FSM_flush     else '0';
	fsm_aed_read_end  <= frame_end_pre1 when FSM_state=FSM_aed_read else '0';
	-- fsm_exp_end       <= frame_end_pre1 or fsm_exp_end_pre when FSM_state=FSM_exp       else '0';
	fsm_exp_end       <= frame_end_pre1 when FSM_state=FSM_exp       else '0';
	fsm_read_end      <= frame_end_pre1 when FSM_state=FSM_read      else '0';


	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_exp_end_tmp1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			fsm_exp_end_tmp1 <= not get_image_1d and get_image_2d and sig_FSM_exp_index;
		end if;
	end process;

	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_exp_end_tmp2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			fsm_exp_end_tmp2 <= get_image_1d and not get_image_2d and sig_FSM_exp_index;
		end if;
	end process;
	process(fsm_clk, rst)
	begin
		if rst='0' then
			fsm_exp_end_pre <= '0';
			fsm_exp_end_dly <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			-- fsm_exp_end_pre <= fsm_exp_end_tmp1 or fsm_exp_end_tmp2;
			fsm_exp_end_pre <= fsm_exp_end_tmp2;
			fsm_exp_end_dly <= fsm_exp_end_pre;
		end if;
	end process;

------------------------------------------------------------------------------------
-------------------------------- Static FSM ----------------------------------------
------------------------------------------------------------------------------------
	static_rst <= not en_aed and rst;


-------------------------------- Origin Mode ---------------------------------------
------------------------------------------------------------------------------------
	lo_valid_get_ORG_image_1 <= saturation_flush_end_pre1;
	lo_valid_get_ORG_image_2 <= fsm_init_end and not en_back_bias and not en_flush;
	lo_valid_get_ORG_image_3 <= not s_get_image_1d and s_get_image_2d;

	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			valid_get_ORG_image <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if fsm_rst_start='1' or en_panel_stable='1' then
				valid_get_ORG_image <= '0';
			elsif s_get_image_1d='1' and s_get_image_2d='0' then
				valid_get_ORG_image <= '1';
			elsif valid_get_ORG_image='1' then
				if lo_valid_get_ORG_image_1='1' or lo_valid_get_ORG_image_2='1' or lo_valid_get_ORG_image_3='1' then
					valid_get_ORG_image <= '0';
				end if;
			end if;
		end if;
	end process;

	------ fsm rst start ------
	---------------------------
	ORG_fsm_rst_start_tmp3  <= fsm_exp_end and not valid_get_ORG_image and not s_get_image;
	ORG_fsm_rst_start_tmp2  <= (fsm_back_bias_end or fsm_flush_end or fsm_read_end) and not s_multi_readout_exist;
	-- ORG_fsm_rst_start_tmp2  <= (fsm_read_end);
	ORG_fsm_rst_start_tmp1  <= (fsm_init_end or fsm_back_bias_end or fsm_flush_end or fsm_exp_end or fsm_read_end) and go_rst;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_rst_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_rst_start <= ORG_fsm_rst_start_tmp1 or ORG_fsm_rst_start_tmp2 or ORG_fsm_rst_start_tmp3;
		end if;
	end process;

	------ fsm init start -----
	---------------------------
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_init_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_init_start <= fsm_rst_end and not en_panel_stable;
		end if;
	end process;


	--- fsm back_bias start ---
	---------------------------
	ORG_fsm_back_bias_start_tmp4 <= fsm_init_end                                      when en_back_bias='1' else '0';
	ORG_fsm_back_bias_start_tmp3 <= fsm_back_bias_end                                 when en_back_bias='1' and en_flush='0' and repeat_cnt/=saturation_flush_repeat else '0';
	ORG_fsm_back_bias_start_tmp2 <= fsm_flush_end                                     when en_back_bias='1' and en_flush='1' and repeat_cnt/=saturation_flush_repeat else '0';
	ORG_fsm_back_bias_start_tmp1 <= fsm_read_end and valid_get_ORG_image              when en_back_bias='1' else '0';
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_back_bias_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_back_bias_start_pre1 <= ORG_fsm_back_bias_start_tmp1 or ORG_fsm_back_bias_start_tmp2;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_back_bias_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_back_bias_start_pre2 <= ORG_fsm_back_bias_start_tmp3 or ORG_fsm_back_bias_start_tmp4;
		end if;
	end process;
	ORG_fsm_back_bias_start <= ORG_fsm_back_bias_start_pre1 or ORG_fsm_back_bias_start_pre2;


	----- fsm flush start -----
	---------------------------
	ORG_fsm_flush_start_tmp4 <= fsm_init_end                                          when en_back_bias='0' and en_flush='1' else '0';
	ORG_fsm_flush_start_tmp3 <= fsm_back_bias_end                                     when en_flush='1' else '0';
	ORG_fsm_flush_start_tmp2 <= fsm_flush_end                                         when en_back_bias='0' and en_flush='1' and repeat_cnt/=saturation_flush_repeat else '0';
	ORG_fsm_flush_start_tmp1 <= fsm_read_end and valid_get_ORG_image                  when en_back_bias='0' and en_flush='1' else '0';
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_flush_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_flush_start_pre1 <= ORG_fsm_flush_start_tmp1 or ORG_fsm_flush_start_tmp2;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_flush_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_flush_start_pre2 <=  ORG_fsm_flush_start_tmp3 or ORG_fsm_flush_start_tmp4;
		end if;
	end process;
	ORG_fsm_flush_start <= ORG_fsm_flush_start_pre1 or ORG_fsm_flush_start_pre2;


	------ fsm exp start ------
	---------------------------
	ORG_fsm_exp_start_tmp4 <= fsm_init_end                                            when en_back_bias='0' and en_flush='0' else '0';
	ORG_fsm_exp_start_tmp3 <= fsm_back_bias_end and valid_get_ORG_image               when en_back_bias='1' and en_flush='0' and repeat_cnt=saturation_flush_repeat else '0';
	ORG_fsm_exp_start_tmp2 <= fsm_flush_end and valid_get_ORG_image                   when en_flush='1' and repeat_cnt=saturation_flush_repeat else '0';
	ORG_fsm_exp_start_tmp1 <= fsm_read_end and valid_get_ORG_image                    when en_back_bias='0' and en_flush='0' else '0';
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_exp_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_exp_start_pre1 <= ORG_fsm_exp_start_tmp1 or ORG_fsm_exp_start_tmp2;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_exp_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_exp_start_pre2 <= ORG_fsm_exp_start_tmp3 or ORG_fsm_exp_start_tmp4;
		end if;
	end process;
	ORG_fsm_exp_start <= ORG_fsm_exp_start_pre1 or ORG_fsm_exp_start_pre2;


	------ fsm read start -----
	---------------------------
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			ORG_fsm_read_start<= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			ORG_fsm_read_start <= fsm_exp_end and not valid_get_ORG_image and s_get_image;
		end if;
	end process;

	
------------------------------ Panel Stable Mode -----------------------------------
------------------------------------------------------------------------------------
	lo_valid_get_PSm_image_1 <= fsm_back_bias_end and en_back_bias and not en_flush;
	lo_valid_get_PSm_image_2 <= fsm_flush_end and en_flush;
	lo_valid_get_PSm_image_3 <= fsm_exp_end and not en_back_bias and not en_flush;
	-- lo_valid_get_PSm_image_3 <= fsm_init_end and not en_back_bias and not en_flush;
	lo_valid_get_PSm_image_4 <= not get_image_1d and get_image_2d;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			valid_get_PSm_image <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if fsm_rst_start='1' and en_panel_stable='0' then
				valid_get_PSm_image <= '0';
			elsif get_image_1d='1' and get_image_2d='0' then
				valid_get_PSm_image <= '1';
			elsif valid_get_PSm_image='1' then
				if lo_valid_get_PSm_image_1='1' or lo_valid_get_PSm_image_2='1' or lo_valid_get_PSm_image_3='1' or lo_valid_get_PSm_image_4='1' then
					valid_get_PSm_image <= '0';
				end if;
			end if;
		end if;
	end process;

	------ fsm rst start ------
	---------------------------
	PSm_fsm_rst_start_tmp1  <= (fsm_init_end or fsm_back_bias_end or fsm_flush_end or fsm_exp_end or fsm_read_end) and go_rst;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_rst_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_rst_start <= PSm_fsm_rst_start_tmp1;
		end if;
	end process;


	------ fsm init start -----
	---------------------------
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_init_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_init_start <= fsm_rst_end and en_panel_stable;
		end if;
	end process;


	--- fsm back_bias start ---
	---------------------------
	PSm_fsm_back_bias_start_tmp5 <= fsm_init_end                                                   when en_back_bias='1' else '0';
	PSm_fsm_back_bias_start_tmp4 <= fsm_read_end when (s_multi_readout_exist='0' and s_panel_stable_exist='0' and s_exp_read_exist='1' and en_back_bias='1') else '0';

	PSm_fsm_back_bias_start_tmp3 <= fsm_exp_end and not valid_get_PSm_image and not s_get_image      when (en_back_bias='1' and s_panel_stable_exist='0') else '0';

	PSm_fsm_back_bias_start_tmp2 <= s_back_bias_flush_exist and fsm_back_bias_end and not valid_get_PSm_image                  when en_back_bias='1' and en_flush='0' else '0'; -- not use
	PSm_fsm_back_bias_start_tmp1 <= s_back_bias_flush_exist and fsm_flush_end and not valid_get_PSm_image                      when en_back_bias='1' and en_flush='1' else '0';

	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_back_bias_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_back_bias_start_pre1 <= PSm_fsm_back_bias_start_tmp1 or PSm_fsm_back_bias_start_tmp2;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_back_bias_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_back_bias_start_pre2 <= PSm_fsm_back_bias_start_tmp3 or PSm_fsm_back_bias_start_tmp4 or PSm_fsm_back_bias_start_tmp5;
		end if;
	end process;
	PSm_fsm_back_bias_start <= PSm_fsm_back_bias_start_pre1 or PSm_fsm_back_bias_start_pre2;


	----- fsm flush start -----
	---------------------------
	PSm_fsm_flush_start_tmp5 <= fsm_init_end                                                   when en_back_bias='0' and en_flush='1' else '0'; -- not use
	PSm_fsm_flush_start_tmp4 <= fsm_read_end                                                   when en_back_bias='0' and en_flush='1' else '0'; -- not use
	PSm_fsm_flush_start_tmp3 <= fsm_exp_end and not valid_get_PSm_image and not get_image      when en_back_bias='0' and en_flush='1' else '0'; -- not use
	PSm_fsm_flush_start_tmp2 <= fsm_back_bias_end                                              when en_flush='1' else '0';
	PSm_fsm_flush_start_tmp1 <= fsm_flush_end and not valid_get_PSm_image                      when en_back_bias='0' and en_flush='1' else '0'; -- not use
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_flush_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_flush_start_pre1 <= PSm_fsm_flush_start_tmp1 or PSm_fsm_flush_start_tmp2 or PSm_fsm_flush_start_tmp3;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_flush_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_flush_start_pre2 <= PSm_fsm_flush_start_tmp4 or PSm_fsm_flush_start_tmp5;
		end if;
	end process;
	PSm_fsm_flush_start <= PSm_fsm_flush_start_pre1 or PSm_fsm_flush_start_pre2;


	------ fsm exp start ------
	---------------------------
	PSm_fsm_exp_start_tmp5 <= fsm_read_end                                 					when (s_get_image='1' and s_panel_stable_exist='0' and s_exp_read_exist='0') else '0'; 
	PSm_fsm_exp_start_tmp4 <= fsm_init_end or fsm_read_end                                 	when en_back_bias='0' and en_flush='0' else '0'; -- not use
	PSm_fsm_exp_start_tmp3 <= fsm_back_bias_end and valid_get_PSm_image						when en_back_bias='1' and en_flush='0' else '0'; -- not use
	PSm_fsm_exp_start_tmp2 <= fsm_flush_end and valid_get_PSm_image                        	when en_flush='1' else '0';
	PSm_fsm_exp_start_tmp1 <= fsm_exp_end and not valid_get_PSm_image and not s_get_image	when en_back_bias='0' and en_flush='0' else '0'; -- not use
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_exp_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_exp_start_pre1 <= PSm_fsm_exp_start_tmp1 or PSm_fsm_exp_start_tmp2;
		end if;
	end process;
	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_exp_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			-- PSm_fsm_exp_start_pre2 <= PSm_fsm_exp_start_tmp3 or PSm_fsm_exp_start_tmp4;
			PSm_fsm_exp_start_pre2 <= PSm_fsm_exp_start_tmp3  or PSm_fsm_exp_start_tmp5;
		end if;
	end process;
	
	PSm_fsm_exp_start <= PSm_fsm_exp_start_pre1 or PSm_fsm_exp_start_pre2;

	------ fsm read start -----
	---------------------------
	PSm_fsm_read_start_tmp1 <= '1' when fsm_init_end='1' and en_back_bias='0' and en_flush='0' else '0';
	PSm_fsm_read_start_tmp2 <= '1' when fsm_back_bias_end='1' and s_last_repeat_cnt='1' and en_back_bias='1' and en_flush='0' else '0';
	PSm_fsm_read_start_tmp3 <= '1' when fsm_flush_end='1' and repeat_cnt = saturation_flush_repeat and s_exp_read_exist='0' else '0';
	PSm_fsm_read_start_tmp4 <= '1' when fsm_exp_end='1' and s_exp_read_exist='1' else '0';


	process(fsm_clk, static_rst)
	begin
		if static_rst='0' then
			PSm_fsm_read_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			PSm_fsm_read_start <= PSm_fsm_read_start_tmp1 or PSm_fsm_read_start_tmp2 or PSm_fsm_read_start_tmp3 or PSm_fsm_read_start_tmp4; 
		end if;
	end process;


------------------------------------------------------------------------------------
---------------------------------- AED FSM -----------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
	aed_rst <= en_aed and rst;

	s_ready_aed_read <= (x"00"& saturation_flush_repeat) + ready_aed_read;
	aed_prepare_delay <= aed_dark_delay + s_ready_aed_read;

	process(fsm_clk, aed_rst, rst_repeat_cnt_modify_1d)
	begin
		if aed_rst='0' or rst_repeat_cnt_modify_1d='1' then
			aed_ready_cnt <= "0000000000000001";
		elsif fsm_clk'event and fsm_clk='1' then
			if s_exp_read_exist='0' and frame_end_pre1='1' then
				if sig_FSM_read_index='1' or sig_FSM_aed_read_index='1' then
					aed_ready_cnt <= aed_ready_cnt + 1;
				end if;
			end if;
		end if;
	end process;



	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			valid_aed_read <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if sig_FSM_aed_read_index='0' or s_panel_stable_exist='1' then
				valid_aed_read <= '0';
			elsif sig_FSM_aed_read_index='1' and aed_ready_cnt=s_ready_aed_read then
				valid_aed_read <= frame_end_pre1;
			else
				valid_aed_read <= valid_aed_read;
			end if;
		end if;
	end process;

	aed_ready_done  <= valid_aed_read and get_bright;

	valid_posi_flag <= valid_aed_read;

	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			valid_get_dark <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if sig_FSM_aed_read_index='0' or s_panel_stable_exist='1' then
				valid_get_dark <= '0';
			elsif sig_FSM_aed_read_index='1' and aed_ready_cnt=aed_prepare_delay then
				valid_get_dark <= frame_end_pre1;
			else
				valid_get_dark <= valid_get_dark;
			end if;
		end if;
	end process;

	aed_ready_done_dark <= valid_get_dark and get_dark; 
	valid_nega_flag <= valid_get_dark;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	------ fsm rst start ------
	---------------------------
	AED_fsm_rst_start_tmp1  <= (fsm_init_end or fsm_back_bias_end or fsm_flush_end or fsm_aed_read_end or fsm_exp_end or fsm_read_end) and go_rst;
	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_rst_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_rst_start <= AED_fsm_rst_start_tmp1;
		end if;
	end process;


	------ fsm init start -----
	---------------------------
	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_init_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_init_start <= fsm_rst_end;
		end if;
	end process;


	--- fsm back_bias start ---
	---------------------------
	AED_fsm_back_bias_start_tmp1 <= fsm_init_end           							when en_back_bias='1'  else '0';
	-- AED_fsm_back_bias_start_tmp2 <= fsm_flush_end_1d and s_panel_stable_exist       when en_back_bias='1' and en_flush='1' else '0';
	AED_fsm_back_bias_start_tmp2 <= fsm_flush_end 									when s_panel_stable_exist='1' and s_last_repeat_cnt='0' and en_back_bias='1' and en_flush='1' else '0';
	AED_fsm_back_bias_start_tmp3 <= fsm_back_bias_end								when s_panel_stable_exist='1' and en_back_bias='1' and en_flush='0' else '0';
	
	-- after expose
	AED_fsm_back_bias_start_tmp4 <= fsm_read_end          							when s_multi_readout_exist='0' and (en_back_bias='1' and aed_ready_cnt > ready_aed_read) else '0';
	
	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_back_bias_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_back_bias_start <= AED_fsm_back_bias_start_tmp1 or AED_fsm_back_bias_start_tmp2 or AED_fsm_back_bias_start_tmp3 or AED_fsm_back_bias_start_tmp4;
		end if;
	end process;


	----- fsm flush start -----
	---------------------------
	AED_fsm_flush_start_tmp1 <= fsm_init_end				              	when en_back_bias='0' and en_flush='1' else '0';
	AED_fsm_flush_start_tmp2 <= fsm_flush_end and s_panel_stable_exist 		when en_back_bias='0' and en_flush='1' else '0';
	AED_fsm_flush_start_tmp3 <= fsm_back_bias_end and s_panel_stable_exist	when en_back_bias='1' and en_flush='1' else '0';
	AED_fsm_flush_start_tmp4 <= fsm_read_end								when en_back_bias='0' and en_flush='1' and (s_multi_readout_exist='0' and aed_ready_cnt > ready_aed_read) else '0';

	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_flush_start <= '0';
			fsm_flush_end_1d <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_flush_start <= AED_fsm_flush_start_tmp1 or AED_fsm_flush_start_tmp2 or AED_fsm_flush_start_tmp3 or AED_fsm_flush_start_tmp4;
			fsm_flush_end_1d <= fsm_flush_end;
		end if;
	end process;


	----- fsm aed_read start -----
	------------------------------
	AED_fsm_aed_read_start_tmp1 <= fsm_init_end							when (en_back_bias='0' and en_flush='0') else '0';
	AED_fsm_aed_read_start_tmp2 <= fsm_back_bias_end					when (en_back_bias='1' and en_flush='0' and repeat_cnt=saturation_flush_repeat) else '0';
	AED_fsm_aed_read_start_tmp3 <= fsm_flush_end						when (en_back_bias='0' and en_flush='1' and repeat_cnt=saturation_flush_repeat) else '0';
	-- AED_fsm_aed_read_start_tmp4 <= fsm_read_end_1d						when (s_panel_stable_exist='0' and aed_ready_cnt=ready_aed_read) else '0';
	AED_fsm_aed_read_start_tmp4 <= fsm_read_end							when (s_panel_stable_exist='0' and aed_ready_cnt=ready_aed_read) else '0';
	AED_fsm_aed_read_start_tmp5 <= fsm_aed_read_end						when get_dark='0' and on_aed_trigger='0' else '0';
	AED_fsm_aed_read_start_tmp6 <= fsm_read_end							when s_multi_readout_exist='0' and en_back_bias='0' and en_flush='0' else '0';

	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_aed_read_start_pre1 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_aed_read_start_pre1 <= AED_fsm_aed_read_start_tmp1 or AED_fsm_aed_read_start_tmp2 or AED_fsm_aed_read_start_tmp3;
		end if;
	end process;
	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_aed_read_start_pre2 <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_aed_read_start_pre2 <= AED_fsm_aed_read_start_tmp4 or AED_fsm_aed_read_start_tmp5 or AED_fsm_aed_read_start_tmp6;
		end if;
	end process;
	AED_fsm_aed_read_start <= AED_fsm_aed_read_start_pre1 or AED_fsm_aed_read_start_pre2;


	------ fsm exp start ------
	---------------------------
	AED_fsm_exp_start_tmp1 <= fsm_aed_read_end                            when on_aed_dark_trigger='1' and valid_get_dark='1' else '0';
	AED_fsm_exp_start_tmp2 <= fsm_aed_read_end                            when on_aed_trigger='1'     and valid_aed_read='1' else '0';

	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_exp_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_exp_start <= AED_fsm_exp_start_tmp1 or AED_fsm_exp_start_tmp2;
		end if;
	end process;


	------ fsm read start -----
	---------------------------
	AED_fsm_read_start_tmp1 <= fsm_init_end 		when (en_back_bias='0' and en_flush='0') else '0';
	AED_fsm_read_start_tmp2 <= fsm_back_bias_end 	when (en_back_bias='1' and en_flush='0' and s_panel_stable_exist='0') else '0';
	-- AED_fsm_read_start_tmp3 <= fsm_flush_end_1d 	when (en_flush='1' and s_panel_stable_exist='0') else '0';
	AED_fsm_read_start_tmp3 <= fsm_flush_end	 	when (en_flush='1' and s_panel_stable_exist='0') else '0';
	AED_fsm_read_start_tmp4 <= '1' 					when fsm_exp_end='1' and s_get_image='1' else '0';


	process(fsm_clk, aed_rst)
	begin
		if aed_rst='0' then
			AED_fsm_read_start <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			AED_fsm_read_start <= AED_fsm_read_start_tmp1 or AED_fsm_read_start_tmp2 or AED_fsm_read_start_tmp3 or AED_fsm_read_start_tmp4;
		end if;
	end process;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
	fsm_rst_start       <= 	AED_fsm_rst_start        when en_aed='1'           else
							PSm_fsm_rst_start        when en_panel_stable='1'  else
							ORG_fsm_rst_start;
	
	fsm_init_start      <= 	AED_fsm_init_start       when en_aed='1'           else
							PSm_fsm_init_start       when en_panel_stable='1'  else
							ORG_fsm_init_start;

	fsm_back_bias_start <= 	AED_fsm_back_bias_start  when en_aed='1'           else
							PSm_fsm_back_bias_start  when en_panel_stable='1'  else
							ORG_fsm_back_bias_start;

	fsm_flush_start     <= 	AED_fsm_flush_start      when en_aed='1'           else
							PSm_fsm_flush_start      when en_panel_stable='1'  else
							ORG_fsm_flush_start;

	fsm_aed_read_start  <= 	AED_fsm_aed_read_start   when en_aed='1'           else
							'0';

	fsm_exp_start       <= 	AED_fsm_exp_start        when en_aed='1'           else
							PSm_fsm_exp_start        when en_panel_stable='1'  else
							ORG_fsm_exp_start;

	fsm_read_start      <= 	AED_fsm_read_start       when en_aed='1'           else
							PSm_fsm_read_start       when en_panel_stable='1'  else
							ORG_fsm_read_start;

------------------------------------------------------------------------------------
--------------------------------- MAIN FSM -----------------------------------------
------------------------------------------------------------------------------------
	process(fsm_clk, rst)
	begin
		if rst='0' then
			FSM_state <= FSM_rst;
		elsif fsm_clk'event and fsm_clk='1' then
			case FSM_state is

     ------- FSM_rst --------------------------------------------------------
        	when FSM_rst => 
        		if fsm_init_start='1' then
        			FSM_state <= FSM_init;
        		end if;

     ------- FSM_init -------------------------------------------------------
        	when FSM_init => 
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_back_bias_start='1' then
					FSM_state <= FSM_back_bias;
				elsif fsm_flush_start='1' then
					FSM_state <= FSM_flush;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
				elsif fsm_exp_start='1' then
					FSM_state <= FSM_exp;
				elsif fsm_read_start='1' then
					FSM_state <= FSM_read;
				end if;

     ------- FSM_back_bias --------------------------------------------------
        	when FSM_back_bias =>
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_back_bias_start='1' then
					FSM_state <= FSM_back_bias;
				elsif fsm_flush_start='1' then
					FSM_state <= FSM_flush;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
				elsif fsm_exp_start='1' then
					FSM_state <= FSM_exp;
				elsif fsm_read_start='1' then
					FSM_state <= FSM_read;
				end if;

     ------- FSM_flush ------------------------------------------------------
        	when FSM_flush =>
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_back_bias_start='1' then
					FSM_state <= FSM_back_bias;
				elsif fsm_flush_start='1' then
					FSM_state <= FSM_flush;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
        		elsif fsm_exp_start='1' then
        			FSM_state <= FSM_exp;
				elsif fsm_read_start='1' then
					FSM_state <= FSM_read;
        		end if;

     ------- FSM_aed_read ---------------------------------------------------
        	when FSM_aed_read =>
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
        		elsif fsm_exp_start='1' then
        			FSM_state <= FSM_exp;
        		end if;

     ------- FSM_exp --------------------------------------------------------
        	when FSM_exp =>
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_back_bias_start='1' then
					FSM_state <= FSM_back_bias;
				elsif fsm_flush_start='1' then
					FSM_state <= FSM_flush;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
				elsif fsm_exp_start='1' then
					FSM_state <= FSM_exp;
				elsif fsm_read_start='1' then
					FSM_state <= FSM_read;
        		end if;

     ------- FSM_read -------------------------------------------------------
        	when FSM_read =>
        		if fsm_rst_start='1' then
					FSM_state <= FSM_rst;
				elsif fsm_back_bias_start='1' then
					FSM_state <= FSM_back_bias;
				elsif fsm_flush_start='1' then
					FSM_state <= FSM_flush;
				elsif fsm_aed_read_start='1' then
					FSM_state <= FSM_aed_read;
				elsif fsm_exp_start='1' then
					FSM_state <= FSM_exp;
				elsif fsm_read_start='1' then
					FSM_state <= FSM_read;
				end if;

     ------------------------------------------------------------------------					
			when others => FSM_state <= FSM_rst;
			end case;

		end if;
	end process;

	sig_FSM_rst_index        <= '1' when FSM_state=FSM_rst       else '0';
	sig_FSM_init_index       <= '1' when FSM_state=FSM_init      else '0';
	sig_FSM_back_bias_index  <= '1' when FSM_state=FSM_back_bias else '0';
	sig_FSM_flush_index      <= '1' when FSM_state=FSM_flush     else '0';
	sig_FSM_aed_read_index   <= '1' when FSM_state=FSM_aed_read  else '0';
	sig_FSM_exp_index        <= '1' when FSM_state=FSM_exp       else '0';
	sig_FSM_read_index       <= '1' when FSM_state=FSM_read and frame_end='0'     else '0';

	FSM_rst_index       <= sig_FSM_rst_index      ;
	FSM_init_index      <= sig_FSM_init_index     ;
	FSM_back_bias_index <= sig_FSM_back_bias_index;
	FSM_flush_index     <= sig_FSM_flush_index    ;
	FSM_aed_read_index  <= sig_FSM_aed_read_index ;
	FSM_exp_index       <= sig_FSM_exp_index      ;
	FSM_read_index      <= sig_FSM_read_index     ;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	-- aed_read_xao_line1				<= aed_read_image_height + 1; --190822, kkh, 3075
	-- aed_read_xao_line2				<= aed_read_image_height + 2; --190822, kkh, 3076
	-- aed_read_xao_line3				<= aed_read_image_height + 3; --190822, kkh, 3077

	-- aed_read_xao_valid_tmp			<= '1' when (sig_row_cnt=aed_read_xao_line1 or sig_row_cnt=aed_read_xao_line2 or sig_row_cnt=aed_read_xao_line3) and 
	-- 														sig_FSM_aed_read_index='1' and
	-- 														(disable_aed_read_xao='0') -- 2021.05.24 ver34 , ver45 , ver46
															
	-- 												 else '0';

	-- process(fsm_clk, rst) begin
	-- 	if rst='0' then
	-- 		aed_read_xao_valid <= '0';
	-- 	elsif fsm_clk'event and fsm_clk='1' then 
	-- 		aed_read_xao_valid <= aed_read_xao_valid_tmp;
	-- 	end if;
	-- end process;

	-- lo_aed_gate_xao_0					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_0 else '0';
	-- lo_aed_gate_xao_1					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_1 else '0';
	-- lo_aed_gate_xao_2					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_2 else '0';
	-- lo_aed_gate_xao_3					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_3 else '0';
	-- lo_aed_gate_xao_4					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_4 else '0';
	-- lo_aed_gate_xao_5					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=DN_AED_GATE_XAO_5 else '0';

	-- hi_aed_gate_xao_0					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_0 else '0';
	-- hi_aed_gate_xao_1					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_1 else '0';
	-- hi_aed_gate_xao_2					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_2 else '0';
	-- hi_aed_gate_xao_3					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_3 else '0';
	-- hi_aed_gate_xao_4					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_4 else '0';
	-- hi_aed_gate_xao_5					<= '1' when (aed_read_xao_valid='1') and sig_col_cnt=UP_AED_GATE_XAO_5 else '0';

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao_0 <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_0='1' then
	-- 			gate_xao_0 <= '1';
	-- 		elsif lo_aed_gate_xao_0='1' then
	-- 			gate_xao_0 <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao_1 <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_1='1' then
	-- 			gate_xao_1 <= '1';
	-- 		elsif lo_aed_gate_xao_1='1' then
	-- 			gate_xao_1 <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao_2 <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_2='1' then
	-- 			gate_xao_2 <= '1';
	-- 		elsif lo_aed_gate_xao_2='1' then
	-- 			gate_xao_2 <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao_3 <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_3='1' then
	-- 			gate_xao_3 <= '1';
	-- 		elsif lo_aed_gate_xao_3='1' then
	-- 			gate_xao_3 <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao_4 <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_4='1' then
	-- 			gate_xao_4 <= '1';
	-- 		elsif lo_aed_gate_xao_4='1' then
	-- 			gate_xao_4 <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(fsm_clk, fsm_drv_rst) begin
	-- 	if fsm_drv_rst='0' then
	-- 		gate_xao <= '1';
	-- 	elsif fsm_clk'event and fsm_clk='1' then
	-- 		if hi_aed_gate_xao_5='1' then
	-- 			gate_xao <= '1';
	-- 		elsif lo_aed_gate_xao_5='1' then
	-- 			gate_xao <= '0';
	-- 		end if;
	-- 	end if;
	-- end process;


------------------------------------------------------------------------------------
	s_back_bias_flush_exist <= '1' when (repeat_cnt < saturation_flush_repeat) and (en_back_bias='1' or en_flush='1') else '0';
	s_last_repeat_cnt 		<= '1' when repeat_cnt = saturation_flush_repeat and (en_back_bias='1' or en_flush='1') else '0';
	s_panel_stable_exist 	<= '1' when en_panel_stable='1' and (s_back_bias_flush_exist='1' or s_last_repeat_cnt='1') else '0';

	process(fsm_clk, fsm_drv_rst) begin
		if fsm_drv_rst='0' then
			s_exp_read_exist <= '0';
			fsm_read_end_1d <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			if fsm_exp_start='1' then
				s_exp_read_exist <= '1';
			elsif (s_multi_readout_exist='0' and fsm_read_end='1') or fsm_back_bias_start='1' then
				s_exp_read_exist <= '0';
			end if;
			fsm_read_end_1d <= fsm_read_end;
		end if;
	end process;

	process(fsm_clk, fsm_drv_rst) begin
		if fsm_drv_rst='0' then
			panel_stable_exist <= '0';
			exp_read_exist <= '0';
		elsif fsm_clk'event and fsm_clk='1' then
			panel_stable_exist <= s_panel_stable_exist;
			exp_read_exist <= s_exp_read_exist;
		end if;
	end process;

    ---------------------------- REPEAT Readout COUNTER ------------------------------------
    process(fsm_clk, rst)
    begin
    	if rst='0' then
    		s_multi_readout_count <= x"0000";
    	elsif fsm_clk'event and fsm_clk='1' then
    		if rst_repeat_cnt_modify='1' then
    			s_multi_readout_count <= x"0000";
    		elsif s_inc_multi_readout_cnt='1' then
    			s_multi_readout_count <= s_multi_readout_count + 1;
    		end if;
    	end if;
    end process;

	s_inc_multi_readout_cnt <= '1' when s_exp_read_exist='1' and fsm_read_end='1' else '0';
	s_multi_readout_exist <= '1' when s_multi_readout_count < readout_count else '0';

------------------------------------------------------------------------------------


end Behavioral;


