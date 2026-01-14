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

entity read_data_tx is
	port
	(
	sys_clk                      : in std_logic;
	sys_rst                      : in std_logic;

	eim_clk                      : in std_logic;
	eim_rst                      : in std_logic;

	dual_readout                 : in std_logic;
	dummy_get_image              : in std_logic;
	exist_get_image              : out std_logic;
	burst_get_image              : in std_logic;

	get_dark                     : in std_logic;
	get_bright                   : in std_logic;

	dsp_image_height             : in std_logic_vector(15 downto 0);
	max_v_count		             : in std_logic_vector(15 downto 0);
	max_h_count		             : in std_logic_vector(15 downto 0);

	en_test_pattern_col          : in std_logic;
	en_test_pattern_row          : in std_logic;

	FSM_aed_read_index           : in std_logic;
	FSM_read_index               : in std_logic;

	valid_roic_data              : in std_logic;
	roic_data_in_1               : in std_logic_vector(31 downto 0);
	roic_data_in_2               : in std_logic_vector(31 downto 0);
	roic_data_in_3               : in std_logic_vector(31 downto 0);
	roic_data_in_4               : in std_logic_vector(31 downto 0);
	roic_data_in_5               : in std_logic_vector(31 downto 0);
	roic_data_in_6               : in std_logic_vector(31 downto 0);
	roic_data_in_7               : in std_logic_vector(31 downto 0);
	roic_data_in_8               : in std_logic_vector(31 downto 0);
	roic_data_in_9               : in std_logic_vector(31 downto 0);
	roic_data_in_10              : in std_logic_vector(31 downto 0);
	roic_data_in_11              : in std_logic_vector(31 downto 0);
	roic_data_in_12              : in std_logic_vector(31 downto 0);
	
	valid_read_mem               : in std_logic;

	read_axis_tready             : in std_logic;
	read_axis_tlast	             : out std_logic;
	read_data_valid              : out std_logic;
	read_data_out                : out std_logic_vector(31 downto 0);
	read_frame_start			 : out std_logic;
	read_frame_reset			 : out std_logic;
	read_addr_cnt                : out std_logic_vector(7 downto 0);
		
	read_vsync                   : out std_logic;
	read_hsync                   : out std_logic
	);
end read_data_tx;

architecture Behavioral of read_data_tx is	
	

    component roic_data_bmem IS
		PORT (
			clka    : IN STD_LOGIC;
			wea     : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- addra   : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			addra   : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			dina    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			
			clkb : IN STD_LOGIC;
			-- addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			addrb : IN STD_LOGIC_VECTOR(8 downto 0);
			doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
    END component;

	CONSTANT VALID_NUM_ROIC_BURST : STD_LOGIC_VECTOR(15 DOWNTO 0) :=x"0020";


	CONSTANT NUM_ROIC_CHANNEL : STD_LOGIC_VECTOR(7 DOWNTO 0) :="01111111";
	-- CONSTANT MEM_HEIGHT : STD_LOGIC_VECTOR(9 DOWNTO 0) :="1011111111";
	CONSTANT MEM_HEIGHT : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0011111111";


	CONSTANT UP_1XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0001111100";
	CONSTANT DN_1XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0001111111";

	CONSTANT UP_2XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0011111100";
	CONSTANT DN_2XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0011111111";

	CONSTANT UP_3XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0101111100";
	CONSTANT DN_3XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0101111111";

	CONSTANT UP_4XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0111111100";
	CONSTANT DN_4XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="0111111111";

	CONSTANT UP_5XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="1001111100";
	CONSTANT DN_5XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="1001111111";

	CONSTANT UP_6XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="1011111100";
	CONSTANT DN_6XROIC_SIZE : STD_LOGIC_VECTOR(9 DOWNTO 0) :="1011111111";



	signal valid_read_roic_data : std_logic :='0';
	
	signal enable_mem_wr : std_logic :='0';
	signal write_mem_addr    : std_logic_vector(9 downto 0) :=(others=>'0');

	signal write_mem_data_1  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_2  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_3  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_4  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_5  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_6  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_7  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_8  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_9  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_10 : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_11 : std_logic_vector(31 downto 0) :=(others=>'0');
	signal write_mem_data_12 : std_logic_vector(31 downto 0) :=(others=>'0');

	signal read_mem_addr_offset : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_offset_1d : std_logic_vector(7 downto 0) :=(others=>'0');
	signal read_mem_addr_offset_2d : std_logic_vector(7 downto 0) :=(others=>'0');
	signal s_max_read_mem_addr_offset : std_logic_vector(9 downto 0) :=(others=>'0');

	signal read_mem_addr_1  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_2  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_3  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_4  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_5  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_6  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_7  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_8  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_9  : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_10 : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_11 : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_mem_addr_12 : std_logic_vector(9 downto 0) :=(others=>'0');

	signal s_read_data_out	  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal s_read_mem_data_1  : std_logic_vector(31 downto 0) :=(others=>'0');

	signal read_mem_data_1  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_2  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_3  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_4  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_5  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_6  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_7  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_8  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_9  : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_10 : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_11 : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_mem_data_12 : std_logic_vector(31 downto 0) :=(others=>'0');

	signal FSM_read_index_sys_1d : std_logic :='0';
	signal FSM_read_index_sys_2d : std_logic :='0';

	signal FSM_read_index_eim_1d : std_logic :='0';
	signal FSM_read_index_eim_2d : std_logic :='0';
	signal FSM_read_index_eim_3d : std_logic :='0';
	signal FSM_read_index_eim_4d : std_logic :='0';
	signal FSM_read_index_eim_5d : std_logic :='0';

	signal get_image : std_logic :='0';
	signal get_image_sys_1d : std_logic :='0';
	signal get_image_eim_1d : std_logic :='0';

	signal tx_sys_rst : std_logic :='1';
	signal tx_eim_rst : std_logic :='1';

	signal valid_roic_data_sys_1d : std_logic :='0';
	signal valid_roic_data_sys_2d : std_logic :='0';

	signal inc_roic_burst_cnt_sys : std_logic :='0';
	signal rst_roic_burst_cnt_sys : std_logic :='0';
	signal roic_burst_cnt_sys : std_logic_vector(7 downto 0) :=x"01";

	signal test_pattern_col_1_1  : std_logic_vector(15 downto 0) :=x"0001";
	signal test_pattern_col_2_1  : std_logic_vector(15 downto 0) :=x"0101";
	signal test_pattern_col_3_1  : std_logic_vector(15 downto 0) :=x"0201";
	signal test_pattern_col_4_1  : std_logic_vector(15 downto 0) :=x"0301";
	signal test_pattern_col_5_1  : std_logic_vector(15 downto 0) :=x"0401";
	signal test_pattern_col_6_1  : std_logic_vector(15 downto 0) :=x"0501";
	signal test_pattern_col_7_1  : std_logic_vector(15 downto 0) :=x"0601";
	signal test_pattern_col_8_1  : std_logic_vector(15 downto 0) :=x"0701";
	signal test_pattern_col_9_1  : std_logic_vector(15 downto 0) :=x"0801";
	signal test_pattern_col_10_1 : std_logic_vector(15 downto 0) :=x"0901";
	signal test_pattern_col_11_1 : std_logic_vector(15 downto 0) :=x"0a01";
	signal test_pattern_col_12_1 : std_logic_vector(15 downto 0) :=x"0b01";

	signal test_pattern_col_1_2  : std_logic_vector(15 downto 0) :=x"0002";
	signal test_pattern_col_2_2  : std_logic_vector(15 downto 0) :=x"0102";
	signal test_pattern_col_3_2  : std_logic_vector(15 downto 0) :=x"0202";
	signal test_pattern_col_4_2  : std_logic_vector(15 downto 0) :=x"0302";
	signal test_pattern_col_5_2  : std_logic_vector(15 downto 0) :=x"0402";
	signal test_pattern_col_6_2  : std_logic_vector(15 downto 0) :=x"0502";
	signal test_pattern_col_7_2  : std_logic_vector(15 downto 0) :=x"0602";
	signal test_pattern_col_8_2  : std_logic_vector(15 downto 0) :=x"0702";
	signal test_pattern_col_9_2  : std_logic_vector(15 downto 0) :=x"0802";
	signal test_pattern_col_10_2 : std_logic_vector(15 downto 0) :=x"0902";
	signal test_pattern_col_11_2 : std_logic_vector(15 downto 0) :=x"0a02";
	signal test_pattern_col_12_2 : std_logic_vector(15 downto 0) :=x"0b02";

	signal test_pattern_row 	: std_logic_vector(31 downto 0) :=x"00010001";

	signal pattern_offset 		: std_logic_vector(15 downto 0) :=x"0001";

	signal line_offset 			: std_logic_vector(15 downto 0) :=x"0000";

	signal flag_1 : std_logic :='0';
	signal flag_2 : std_logic :='0';
	signal flag_3 : std_logic :='0';
	signal flag_4 : std_logic :='0';
	signal flag_5 : std_logic :='0';
	signal flag_6 : std_logic :='0';

	signal hi_flag_1 : std_logic :='0';
	signal hi_flag_2 : std_logic :='0';
	signal hi_flag_3 : std_logic :='0';
	signal hi_flag_4 : std_logic :='0';
	signal hi_flag_5 : std_logic :='0';
	signal hi_flag_6 : std_logic :='0';

	signal lo_flag_1 : std_logic :='0';
	signal lo_flag_2 : std_logic :='0';
	signal lo_flag_3 : std_logic :='0';
	signal lo_flag_4 : std_logic :='0';
	signal lo_flag_5 : std_logic :='0';
	signal lo_flag_6 : std_logic :='0';

	signal lo_flag_1_tmp1 : std_logic :='0';
	signal lo_flag_2_tmp1 : std_logic :='0';
	signal lo_flag_3_tmp1 : std_logic :='0';
	signal lo_flag_4_tmp1 : std_logic :='0';
	signal lo_flag_5_tmp1 : std_logic :='0';
	signal lo_flag_6_tmp1 : std_logic :='0';

	signal lo_flag_1_tmp2 : std_logic :='0';
	signal lo_flag_2_tmp2 : std_logic :='0';
	signal lo_flag_3_tmp2 : std_logic :='0';
	signal lo_flag_4_tmp2 : std_logic :='0';
	signal lo_flag_5_tmp2 : std_logic :='0';
	signal lo_flag_6_tmp2 : std_logic :='0';

	signal hsync_delay_start_1 : std_logic :='0';
	signal hsync_delay_start_2 : std_logic :='0';
	signal hsync_delay_start_3 : std_logic :='0';
	signal hsync_delay_start_4 : std_logic :='0';
	signal hsync_delay_start_5 : std_logic :='0';
	signal hsync_delay_start_6 : std_logic :='0';

	signal hsync_delay_start_1_1d : std_logic :='0';
	signal hsync_delay_start_2_1d : std_logic :='0';
	signal hsync_delay_start_3_1d : std_logic :='0';
	signal hsync_delay_start_4_1d : std_logic :='0';
	signal hsync_delay_start_5_1d : std_logic :='0';
	signal hsync_delay_start_6_1d : std_logic :='0';

	signal hsync_delay_start_1_2d : std_logic :='0';
	signal hsync_delay_start_2_2d : std_logic :='0';
	signal hsync_delay_start_3_2d : std_logic :='0';
	signal hsync_delay_start_4_2d : std_logic :='0';
	signal hsync_delay_start_5_2d : std_logic :='0';
	signal hsync_delay_start_6_2d : std_logic :='0';

	signal hsync_delay_1 : std_logic :='0';
	signal hsync_delay_2 : std_logic :='0';
	signal hsync_delay_3 : std_logic :='0';
	signal hsync_delay_4 : std_logic :='0';
	signal hsync_delay_5 : std_logic :='0';
	signal hsync_delay_6 : std_logic :='0';

	signal hsync_delay_cnt_1 : std_logic_vector(7 downto 0) :="00000000";
	signal hsync_delay_cnt_2 : std_logic_vector(7 downto 0) :="00000000";
	signal hsync_delay_cnt_3 : std_logic_vector(7 downto 0) :="00000000";
	signal hsync_delay_cnt_4 : std_logic_vector(7 downto 0) :="00000000";
	signal hsync_delay_cnt_5 : std_logic_vector(7 downto 0) :="00000000";
	signal hsync_delay_cnt_6 : std_logic_vector(7 downto 0) :="00000000";

	signal hi_hsync_delay_1_tmp1 : std_logic :='0';
	signal hi_hsync_delay_2_tmp1 : std_logic :='0';
	signal hi_hsync_delay_3_tmp1 : std_logic :='0';
	signal hi_hsync_delay_4_tmp1 : std_logic :='0';
	signal hi_hsync_delay_5_tmp1 : std_logic :='0';
	signal hi_hsync_delay_6_tmp1 : std_logic :='0';

	signal hi_hsync_delay_1_tmp2 : std_logic :='0';
	signal hi_hsync_delay_2_tmp2 : std_logic :='0';
	signal hi_hsync_delay_3_tmp2 : std_logic :='0';
	signal hi_hsync_delay_4_tmp2 : std_logic :='0';
	signal hi_hsync_delay_5_tmp2 : std_logic :='0';
	signal hi_hsync_delay_6_tmp2 : std_logic :='0';

	signal hi_hsync_delay_1 : std_logic :='0';
	signal hi_hsync_delay_2 : std_logic :='0';
	signal hi_hsync_delay_3 : std_logic :='0';
	signal hi_hsync_delay_4 : std_logic :='0';
	signal hi_hsync_delay_5 : std_logic :='0';
	signal hi_hsync_delay_6 : std_logic :='0';

	signal lo_hsync_delay_1 : std_logic :='0';
	signal lo_hsync_delay_2 : std_logic :='0';
	signal lo_hsync_delay_3 : std_logic :='0';
	signal lo_hsync_delay_4 : std_logic :='0';
	signal lo_hsync_delay_5 : std_logic :='0';
	signal lo_hsync_delay_6 : std_logic :='0';

	signal hi_hsync_1 : std_logic :='0';
	signal hi_hsync_2 : std_logic :='0';
	signal hi_hsync_3 : std_logic :='0';
	signal hi_hsync_4 : std_logic :='0';
	signal hi_hsync_5 : std_logic :='0';
	signal hi_hsync_6 : std_logic :='0';
	
	signal hi_hsync : std_logic :='0';
	signal lo_hsync : std_logic :='0';

	signal hsync_1 : std_logic :='0';
	signal hsync_2 : std_logic :='0';
	signal hsync_3 : std_logic :='0';
	signal hsync_4 : std_logic :='0';
	signal hsync_5 : std_logic :='0';
	signal hsync_6 : std_logic :='0';
	signal sig_hsync : std_logic :='0';

	signal up_hsync_keep_hi 	: std_logic :='0';
	signal down_hsync_keep_hi 	: std_logic :='0';
	signal hsync_keep_hi 		: std_logic :='0';
	signal hsync_keep_hi_cnt 	: std_logic_vector(3 downto 0) :="0000";
	
	signal sig_hsync_1d 		: std_logic :='0';
	signal sig_hsync_2d 		: std_logic :='0';

	signal rst_hsync_cnt 		: std_logic :='0';
	signal rst_hsync_cnt_dly 	: std_logic :='0';
	signal inc_hsync_cnt 		: std_logic :='0';
	signal hsync_cnt 			: std_logic_vector(11 downto 0) :=x"000";

	signal up_vsync_keep_hi 	: std_logic :='0';
	signal down_vsync_keep_hi 	: std_logic :='0';
	signal vsync_keep_hi 		: std_logic :='0';
	signal vsync_keep_hi_cnt 	: std_logic_vector(3 downto 0) :="0000";
	
	signal hi_vsync 			: std_logic :='0';
	signal lo_vsync 			: std_logic :='0';

	signal sig_vsync 			: std_logic :='0';

	signal read_mem_index 		: std_logic :='0';

	signal start_read_mem_1  : std_logic :='0';
	signal start_read_mem_2  : std_logic :='0';
	signal start_read_mem_3  : std_logic :='0';
	signal start_read_mem_4  : std_logic :='0';
	signal start_read_mem_5  : std_logic :='0';
	signal start_read_mem_6  : std_logic :='0';
	signal start_read_mem_7  : std_logic :='0';
	signal start_read_mem_8  : std_logic :='0';
	signal start_read_mem_9  : std_logic :='0';
	signal start_read_mem_10 : std_logic :='0';
	signal start_read_mem_11 : std_logic :='0';
	signal start_read_mem_12 : std_logic :='0';

	signal end_read_mem_1  : std_logic :='0';
	signal end_read_mem_2  : std_logic :='0';
	signal end_read_mem_3  : std_logic :='0';
	signal end_read_mem_4  : std_logic :='0';
	signal end_read_mem_5  : std_logic :='0';
	signal end_read_mem_6  : std_logic :='0';
	signal end_read_mem_7  : std_logic :='0';
	signal end_read_mem_8  : std_logic :='0';
	signal end_read_mem_9  : std_logic :='0';
	signal end_read_mem_10 : std_logic :='0';
	signal end_read_mem_11 : std_logic :='0';
	signal end_read_mem_12 : std_logic :='0';

	signal read_mem_1  : std_logic :='0';
	signal read_mem_2  : std_logic :='0';
	signal read_mem_3  : std_logic :='0';
	signal read_mem_4  : std_logic :='0';
	signal read_mem_5  : std_logic :='0';
	signal read_mem_6  : std_logic :='0';
	signal read_mem_7  : std_logic :='0';
	signal read_mem_8  : std_logic :='0';
	signal read_mem_9  : std_logic :='0';
	signal read_mem_10 : std_logic :='0';
	signal read_mem_11 : std_logic :='0';
	signal read_mem_12 : std_logic :='0';

	signal read_mem_1_1d  : std_logic :='0';
	signal read_mem_2_1d  : std_logic :='0';
	signal read_mem_3_1d  : std_logic :='0';
	signal read_mem_4_1d  : std_logic :='0';
	signal read_mem_5_1d  : std_logic :='0';
	signal read_mem_6_1d  : std_logic :='0';
	signal read_mem_7_1d  : std_logic :='0';
	signal read_mem_8_1d  : std_logic :='0';
	signal read_mem_9_1d  : std_logic :='0';
	signal read_mem_10_1d : std_logic :='0';
	signal read_mem_11_1d : std_logic :='0';
	signal read_mem_12_1d : std_logic :='0';

	signal read_mem_1_2d  : std_logic :='0';
	signal read_mem_2_2d  : std_logic :='0';
	signal read_mem_3_2d  : std_logic :='0';
	signal read_mem_4_2d  : std_logic :='0';
	signal read_mem_5_2d  : std_logic :='0';
	signal read_mem_6_2d  : std_logic :='0';
	signal read_mem_7_2d  : std_logic :='0';
	signal read_mem_8_2d  : std_logic :='0';
	signal read_mem_9_2d  : std_logic :='0';
	signal read_mem_10_2d : std_logic :='0';
	signal read_mem_11_2d : std_logic :='0';
	signal read_mem_12_2d : std_logic :='0';

	signal s_valid_read_mem		: std_logic :='0';
	signal s_read_frame_start	: std_logic :='0';
	signal s_axis_tvalid	: std_logic :='0';
	signal s_axis_tvalid_1d	: std_logic :='0';
	signal s_axis_tvalid_2d	: std_logic :='0';
	signal s_axis_tvalid_3d	: std_logic :='0';
	signal s_read_axis_tready	: std_logic :='0';

	signal s_axis_tlast		: std_logic :='0';
	signal s_axis_tlast_1d	: std_logic :='0';
	signal s_axis_tlast_2d	: std_logic :='0';
	signal s_axis_tlast_3d	: std_logic :='0';

	signal s_tuser_0		: std_logic :='0';
	signal s_tuser_0_dly	: std_logic_vector(15 downto 0) := x"0000";
	signal s_tuser_0_cnt	: std_logic_vector(3 downto 0) := x"0";
	signal s_v_sync			: std_logic :='0';
	signal s_h_sync			: std_logic :='0';
	signal s_sync_gen_en	: std_logic :='0';
	signal s_v_count		: std_logic_vector(15 downto 0) := x"0000";
	signal s_h_count		: std_logic_vector(15 downto 0) := x"0000";

	signal s_max_h_count	: std_logic_vector(15 downto 0) := x"0300";	-- 768
	signal s_max_v_count	: std_logic_vector(15 downto 0) := x"0400"; -- 1024
	
	signal s_dummy_read_index 	: std_logic :='0';
	signal s_dummy_get_image_1d : std_logic :='0';
	signal s_dummy_get_image_2d : std_logic :='0';
	signal s_dummy_start 		: std_logic :='0';
	signal s_dummy_end 			: std_logic :='0';
	signal s_exist_get_image	: std_logic :='0';
	signal s_dummy_valid	 	: std_logic :='0';
	signal s_dummy_valid_count	: std_logic_vector(15 downto 0);


	-- component ila_rd_tx is
    --     port (
    --         clk     : in std_logic;
    --         probe0  : in std_logic;
    --         probe1  : in std_logic;
    --         probe2  : in std_logic_vector(15 downto 0);
    --         probe3  : in std_logic_vector(15 downto 0);
    --         probe4  : in std_logic_vector(3 downto 0);
    --         probe5  : in std_logic_vector(11 downto 0);
    --         probe6  : in std_logic
    --     );
    -- end component;

begin


	mem_u1 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_1 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_1(8 downto 0)  ,
        doutb		    => read_mem_data_1  
	);

	mem_u2 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_2 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_2(8 downto 0)  ,
        doutb		    => read_mem_data_2  
	);

	mem_u3 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_3 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_3(8 downto 0)  ,
        doutb		    => read_mem_data_3  
	);

	mem_u4 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_4 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_4(8 downto 0)  ,
        doutb		    => read_mem_data_4  
	);

	mem_u5 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_5 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_5(8 downto 0)  ,
        doutb		    => read_mem_data_5  
	);

	mem_u6 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_6 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_6(8 downto 0)  ,
        doutb		    => read_mem_data_6  
	);

	mem_u7 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_7 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_7(8 downto 0)  ,
        doutb		    => read_mem_data_7
	);

	mem_u8 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_8 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_8(8 downto 0)  ,
        doutb		    => read_mem_data_8
	);

	mem_u9 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_9 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_9(8 downto 0)  ,
        doutb		    => read_mem_data_9
	);

	mem_u10 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_10 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_10(8 downto 0)  ,
        doutb		    => read_mem_data_10
	);

	mem_u11 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_11 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_11(8 downto 0)  ,
        doutb		    => read_mem_data_11
	);

	mem_u12 : roic_data_bmem
	port map
	(
		wea(0)          => enable_mem_wr    ,
        clka            => sys_clk          ,
        addra           => write_mem_addr(8 downto 0)   ,
        dina      		=> write_mem_data_12 ,

		clkb	        => eim_clk          ,
        addrb 		    => read_mem_addr_12(8 downto 0)  ,
        doutb		    => read_mem_data_12
	);


	valid_read_roic_data <= valid_roic_data and FSM_read_index;

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, sys_rst)
	begin
		if sys_rst='0' then
			FSM_read_index_sys_1d <= '0';
			FSM_read_index_sys_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			FSM_read_index_sys_1d <= FSM_read_index;
			FSM_read_index_sys_2d <= FSM_read_index_sys_1d;
		end if;
	end process;

	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			FSM_read_index_eim_1d <= '0';
			FSM_read_index_eim_2d <= '0';
			FSM_read_index_eim_3d <= '0';
			FSM_read_index_eim_4d <= '0';
			FSM_read_index_eim_5d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			FSM_read_index_eim_1d <= FSM_read_index;
			FSM_read_index_eim_2d <= FSM_read_index_eim_1d;
			FSM_read_index_eim_3d <= FSM_read_index_eim_2d;
			FSM_read_index_eim_4d <= FSM_read_index_eim_3d;
			FSM_read_index_eim_5d <= FSM_read_index_eim_4d;
		end if;
	end process;

---------------------------------------------------------------------
---------------------------------------------------------------------
	get_image <= '1' when (get_dark='1' or get_bright='1') and s_dummy_valid='0' else '0';

	process(sys_clk, sys_rst)
	begin
		if sys_rst='0' then
			get_image_sys_1d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			get_image_sys_1d <= get_image;
		end if;
	end process;

	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			get_image_eim_1d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			get_image_eim_1d <= get_image;
		end if;
	end process;

	-- tx_sys_rst <= get_image_sys_1d and not (FSM_read_index_sys_1d and not FSM_read_index_sys_2d) and not FSM_aed_read_index;
	-- tx_eim_rst <= get_image_eim_1d and not (FSM_read_index_eim_1d and not FSM_read_index_eim_2d) and not FSM_aed_read_index;

	tx_sys_rst <= '0' when FSM_read_index_sys_1d='1' and FSM_read_index_sys_2d='0' and FSM_aed_read_index='0' else '1';
	tx_eim_rst <= '0' when FSM_read_index_eim_1d='1' and FSM_read_index_eim_2d='0' and FSM_aed_read_index='0' else '1';


---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			enable_mem_wr <= '0';
		elsif sys_clk'event and sys_clk='1' then
			enable_mem_wr <= valid_read_roic_data;
		end if;
	end process;

	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			write_mem_addr <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if enable_mem_wr='1' then
				if write_mem_addr=MEM_HEIGHT then
					write_mem_addr <= (others=>'0');
				else
					write_mem_addr <= write_mem_addr + 1;
				end if;
			end if;
		end if;
	end process;

--------------------------------------------------
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			write_mem_data_1  <= (others=>'0');
			write_mem_data_2  <= (others=>'0');
			write_mem_data_3  <= (others=>'0');
			write_mem_data_4  <= (others=>'0');
			write_mem_data_5  <= (others=>'0');
			write_mem_data_6  <= (others=>'0');
			write_mem_data_7  <= (others=>'0');
			write_mem_data_8  <= (others=>'0');
			write_mem_data_9  <= (others=>'0');
			write_mem_data_10 <= (others=>'0');
			write_mem_data_11 <= (others=>'0');
			write_mem_data_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if valid_read_roic_data='0' then
				write_mem_data_1  <= (others=>'0');
				write_mem_data_2  <= (others=>'0');
				write_mem_data_3  <= (others=>'0');
				write_mem_data_4  <= (others=>'0');
				write_mem_data_5  <= (others=>'0');
				write_mem_data_6  <= (others=>'0');
				write_mem_data_7  <= (others=>'0');
				write_mem_data_8  <= (others=>'0');
				write_mem_data_9  <= (others=>'0');
				write_mem_data_10 <= (others=>'0');
				write_mem_data_11 <= (others=>'0');
				write_mem_data_12 <= (others=>'0');
			elsif valid_read_roic_data='1' then
				if en_test_pattern_row='1' and en_test_pattern_col='0' then
					write_mem_data_1  <= test_pattern_row;
					write_mem_data_2  <= test_pattern_row;
					write_mem_data_3  <= test_pattern_row;
					write_mem_data_4  <= test_pattern_row;
					write_mem_data_5  <= test_pattern_row;
					write_mem_data_6  <= test_pattern_row;
					write_mem_data_7  <= test_pattern_row;
					write_mem_data_8  <= test_pattern_row;
					write_mem_data_9  <= test_pattern_row;
					write_mem_data_10 <= test_pattern_row;
					write_mem_data_11 <= test_pattern_row;
					write_mem_data_12 <= test_pattern_row;
				elsif en_test_pattern_row='0' and en_test_pattern_col='1' then
					write_mem_data_1  <= test_pattern_col_1_1&test_pattern_col_1_2 ;
					write_mem_data_2  <= test_pattern_col_2_1&test_pattern_col_2_2 ;
					write_mem_data_3  <= test_pattern_col_3_1&test_pattern_col_3_2 ;
					write_mem_data_4  <= test_pattern_col_4_1&test_pattern_col_4_2 ;
					write_mem_data_5  <= test_pattern_col_5_1&test_pattern_col_5_2 ;
					write_mem_data_6  <= test_pattern_col_6_1&test_pattern_col_6_2 ;
					write_mem_data_7  <= test_pattern_col_7_1&test_pattern_col_7_2 ;
					write_mem_data_8  <= test_pattern_col_8_1&test_pattern_col_8_2 ;
					write_mem_data_9  <= test_pattern_col_9_1&test_pattern_col_9_2 ;
					write_mem_data_10 <= test_pattern_col_10_1&test_pattern_col_10_2;
					write_mem_data_11 <= test_pattern_col_11_1&test_pattern_col_11_2;
					write_mem_data_12 <= test_pattern_col_12_1&test_pattern_col_12_2;
				elsif en_test_pattern_row='1' and en_test_pattern_col='1' then
					write_mem_data_1  <= s_tuser_0_cnt & hsync_cnt & line_offset ;
					write_mem_data_2  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_3  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_4  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_5  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_6  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_7  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_8  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_9  <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_10 <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_11 <= s_tuser_0_cnt & hsync_cnt & line_offset;
					write_mem_data_12 <= s_tuser_0_cnt & hsync_cnt & line_offset;
				else
					write_mem_data_1  <= roic_data_in_1 ;
					write_mem_data_2  <= roic_data_in_2 ;
					write_mem_data_3  <= roic_data_in_3 ;
					write_mem_data_4  <= roic_data_in_4 ;
					write_mem_data_5  <= roic_data_in_5 ;
					write_mem_data_6  <= roic_data_in_6 ;
					write_mem_data_7  <= roic_data_in_7 ;
					write_mem_data_8  <= roic_data_in_8 ;
					write_mem_data_9  <= roic_data_in_9 ;
					write_mem_data_10 <= roic_data_in_10;
					write_mem_data_11 <= roic_data_in_11;
					write_mem_data_12 <= roic_data_in_12;
				end if;
			end if;
		end if;
	end process;

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			valid_roic_data_sys_1d <= '0';
			valid_roic_data_sys_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			valid_roic_data_sys_1d <= valid_read_roic_data;
			valid_roic_data_sys_2d <= valid_roic_data_sys_1d;
		end if;
	end process;
	
	inc_roic_burst_cnt_sys <= not valid_roic_data_sys_1d and valid_roic_data_sys_2d;
	rst_roic_burst_cnt_sys <= '1' when inc_roic_burst_cnt_sys='1' and roic_burst_cnt_sys=VALID_NUM_ROIC_BURST else '0';

	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			roic_burst_cnt_sys <= x"01";
		elsif sys_clk'event and sys_clk='1' then
			if rst_roic_burst_cnt_sys='1' then
				roic_burst_cnt_sys <= x"01";
			elsif inc_roic_burst_cnt_sys='1' then
				roic_burst_cnt_sys <= roic_burst_cnt_sys + 1;
			end if;
		end if;
	end process;


--------------------------------------------------
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			pattern_offset <= x"0001";
			line_offset    <= x"0000";

			test_pattern_col_1_1  <= x"0001";
			test_pattern_col_2_1  <= x"0101";
			test_pattern_col_3_1  <= x"0201";
			test_pattern_col_4_1  <= x"0301";
			test_pattern_col_5_1  <= x"0401";
			test_pattern_col_6_1  <= x"0501";
			test_pattern_col_7_1  <= x"0601";
			test_pattern_col_8_1  <= x"0701";
			test_pattern_col_9_1  <= x"0801";
			test_pattern_col_10_1 <= x"0901";
			test_pattern_col_11_1 <= x"0a01";
			test_pattern_col_12_1 <= x"0b01";

			test_pattern_col_1_2  <= x"0002";
            test_pattern_col_2_2  <= x"0102";
            test_pattern_col_3_2  <= x"0202";
            test_pattern_col_4_2  <= x"0302";
            test_pattern_col_5_2  <= x"0402";
            test_pattern_col_6_2  <= x"0502";
            test_pattern_col_7_2  <= x"0602";
            test_pattern_col_8_2  <= x"0702";
            test_pattern_col_9_2  <= x"0802";
            test_pattern_col_10_2 <= x"0902";
            test_pattern_col_11_2 <= x"0a02";
            test_pattern_col_12_2 <= x"0b02";
		elsif sys_clk'event and sys_clk='1' then
			if en_test_pattern_col='0' then
				pattern_offset <= x"0001";
				line_offset    <= x"0000";

				test_pattern_col_1_1  <= x"0001";
				test_pattern_col_2_1  <= x"0101";
				test_pattern_col_3_1  <= x"0201";
				test_pattern_col_4_1  <= x"0301";
				test_pattern_col_5_1  <= x"0401";
				test_pattern_col_6_1  <= x"0501";
				test_pattern_col_7_1  <= x"0601";
				test_pattern_col_8_1  <= x"0701";
				test_pattern_col_9_1  <= x"0801";
				test_pattern_col_10_1 <= x"0901";
				test_pattern_col_11_1 <= x"0a01";
				test_pattern_col_12_1 <= x"0b01";

				test_pattern_col_1_2  <= x"0002";
                test_pattern_col_2_2  <= x"0102";
                test_pattern_col_3_2  <= x"0202";
                test_pattern_col_4_2  <= x"0302";
                test_pattern_col_5_2  <= x"0402";
                test_pattern_col_6_2  <= x"0502";
                test_pattern_col_7_2  <= x"0602";
                test_pattern_col_8_2  <= x"0702";
                test_pattern_col_9_2  <= x"0802";
                test_pattern_col_10_2 <= x"0902";
                test_pattern_col_11_2 <= x"0a02";
                test_pattern_col_12_2 <= x"0b02";
			else
				if valid_read_roic_data='1' then
					if pattern_offset = x"0001" then
						pattern_offset        <= pattern_offset + 1;
						
						test_pattern_col_1_1  <= x"0001" + line_offset;
						test_pattern_col_2_1  <= x"0101" + line_offset;
						test_pattern_col_3_1  <= x"0201" + line_offset;	
						test_pattern_col_4_1  <= x"0301" + line_offset;
						test_pattern_col_5_1  <= x"0401" + line_offset;
						test_pattern_col_6_1  <= x"0501" + line_offset;
						test_pattern_col_7_1  <= x"0601" + line_offset;
						test_pattern_col_8_1  <= x"0701" + line_offset;
						test_pattern_col_9_1  <= x"0801" + line_offset;
						test_pattern_col_10_1 <= x"0901" + line_offset;
						test_pattern_col_11_1 <= x"0a01" + line_offset;
						test_pattern_col_12_1 <= x"0b01" + line_offset;
                                                        
						test_pattern_col_1_2  <= x"0002" + line_offset;
                        test_pattern_col_2_2  <= x"0102" + line_offset;
                        test_pattern_col_3_2  <= x"0202" + line_offset;
                        test_pattern_col_4_2  <= x"0302" + line_offset;
                        test_pattern_col_5_2  <= x"0402" + line_offset;
                        test_pattern_col_6_2  <= x"0502" + line_offset;
                        test_pattern_col_7_2  <= x"0602" + line_offset;
                        test_pattern_col_8_2  <= x"0702" + line_offset;
                        test_pattern_col_9_2  <= x"0802" + line_offset;
                        test_pattern_col_10_2 <= x"0902" + line_offset;
                        test_pattern_col_11_2 <= x"0a02" + line_offset;
                        test_pattern_col_12_2 <= x"0b02" + line_offset;

					elsif pattern_offset=x"0080" then
						pattern_offset <= x"0001";

						line_offset <= line_offset + 1;
					else
						pattern_offset        <= pattern_offset + 1;

						test_pattern_col_1_1  <= test_pattern_col_1_1  + 2;
						test_pattern_col_2_1  <= test_pattern_col_2_1  + 2;
						test_pattern_col_3_1  <= test_pattern_col_3_1  + 2;
						test_pattern_col_4_1  <= test_pattern_col_4_1  + 2;
						test_pattern_col_5_1  <= test_pattern_col_5_1  + 2;
						test_pattern_col_6_1  <= test_pattern_col_6_1  + 2;
						test_pattern_col_7_1  <= test_pattern_col_7_1  + 2;
						test_pattern_col_8_1  <= test_pattern_col_8_1  + 2;
						test_pattern_col_9_1  <= test_pattern_col_9_1  + 2;
						test_pattern_col_10_1 <= test_pattern_col_10_1 + 2;
						test_pattern_col_11_1 <= test_pattern_col_11_1 + 2;
						test_pattern_col_12_1 <= test_pattern_col_12_1 + 2;

						test_pattern_col_1_2  <= test_pattern_col_1_2  + 2;
                        test_pattern_col_2_2  <= test_pattern_col_2_2  + 2;
                        test_pattern_col_3_2  <= test_pattern_col_3_2  + 2;
                        test_pattern_col_4_2  <= test_pattern_col_4_2  + 2;
                        test_pattern_col_5_2  <= test_pattern_col_5_2  + 2;
                        test_pattern_col_6_2  <= test_pattern_col_6_2  + 2;
                        test_pattern_col_7_2  <= test_pattern_col_7_2  + 2;
                        test_pattern_col_8_2  <= test_pattern_col_8_2  + 2;
                        test_pattern_col_9_2  <= test_pattern_col_9_2  + 2;
                        test_pattern_col_10_2 <= test_pattern_col_10_2 + 2;
                        test_pattern_col_11_2 <= test_pattern_col_11_2 + 2;
                        test_pattern_col_12_2 <= test_pattern_col_12_2 + 2;
					end if;
				end if;
			end if;
		end if;
	end process;


	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			test_pattern_row <= x"00010001";
		elsif sys_clk'event and sys_clk='1' then
			if en_test_pattern_row='0' then
				test_pattern_row <= x"00010001";
			else
				if rst_roic_burst_cnt_sys='1' then
					if test_pattern_row=x"ffffffff" then
						test_pattern_row <= x"00010001";
					else
						test_pattern_row(31 downto 16) <= test_pattern_row(31 downto 16) + 1;
						test_pattern_row(15 downto 0)  <= test_pattern_row(15 downto 0)  + 1;
					end if;
				end if;
			end if;
		end if;
	end process;

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_1 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_1XROIC_SIZE then
				hsync_delay_start_1 <= '0';
			elsif write_mem_addr=UP_1XROIC_SIZE then
				hsync_delay_start_1 <= '1';
			end if;
		end if;
	end process;
	
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_2 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_2XROIC_SIZE then
				hsync_delay_start_2 <= '0';
			elsif write_mem_addr=UP_2XROIC_SIZE then
				hsync_delay_start_2 <= '1';
			end if;
		end if;
	end process;
	
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_3 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_3XROIC_SIZE then
				hsync_delay_start_3 <= '0';
			elsif write_mem_addr=UP_3XROIC_SIZE then
				hsync_delay_start_3 <= '1';
			end if;
		end if;
	end process;
	
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_4 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_4XROIC_SIZE then
				hsync_delay_start_4 <= '0';
			elsif write_mem_addr=UP_4XROIC_SIZE then
				hsync_delay_start_4 <= '1';
			end if;
		end if;
	end process;
	
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_5 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_5XROIC_SIZE then
				hsync_delay_start_5 <= '0';
			elsif write_mem_addr=UP_5XROIC_SIZE then
				hsync_delay_start_5 <= '1';
			end if;
		end if;
	end process;
	
	process(sys_clk, sys_rst, tx_sys_rst)
	begin
		if sys_rst='0' or tx_sys_rst='0' then
			hsync_delay_start_6 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if write_mem_addr=DN_6XROIC_SIZE then
				hsync_delay_start_6 <= '0';
			elsif write_mem_addr=UP_6XROIC_SIZE then
				hsync_delay_start_6 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_1_1d <= '0';
			hsync_delay_start_1_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_1_1d <= hsync_delay_start_1;
			hsync_delay_start_1_2d <= hsync_delay_start_1_1d;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_2_1d <= '0';
			hsync_delay_start_2_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_2_1d <= hsync_delay_start_2;
			hsync_delay_start_2_2d <= hsync_delay_start_2_1d;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_3_1d <= '0';
			hsync_delay_start_3_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_3_1d <= hsync_delay_start_3;
			hsync_delay_start_3_2d <= hsync_delay_start_3_1d;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_4_1d <= '0';
			hsync_delay_start_4_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_4_1d <= hsync_delay_start_4;
			hsync_delay_start_4_2d <= hsync_delay_start_4_1d;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_5_1d <= '0';
			hsync_delay_start_5_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_5_1d <= hsync_delay_start_5;
			hsync_delay_start_5_2d <= hsync_delay_start_5_1d;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_start_6_1d <= '0';
			hsync_delay_start_6_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			hsync_delay_start_6_1d <= hsync_delay_start_6;
			hsync_delay_start_6_2d <= hsync_delay_start_6_1d;
		end if;
	end process;

--------------------------------------------------
	hi_flag_1 <= hsync_delay_start_1_1d and not hsync_delay_start_1_2d and not flag_1;
	hi_flag_2 <= hsync_delay_start_2_1d and not hsync_delay_start_2_2d and not flag_2;
	hi_flag_3 <= hsync_delay_start_3_1d and not hsync_delay_start_3_2d and not flag_3;
	hi_flag_4 <= hsync_delay_start_4_1d and not hsync_delay_start_4_2d and not flag_4;
	hi_flag_5 <= hsync_delay_start_5_1d and not hsync_delay_start_5_2d and not flag_5;
	hi_flag_6 <= hsync_delay_start_6_1d and not hsync_delay_start_6_2d and not flag_6;


	lo_flag_1_tmp1 <= lo_hsync and hsync_1 and not flag_2;
	lo_flag_2_tmp1 <= lo_hsync and hsync_2 and not flag_3;
	lo_flag_3_tmp1 <= lo_hsync and hsync_3 and not flag_4;
	lo_flag_4_tmp1 <= lo_hsync and hsync_4 and not flag_5;
	lo_flag_5_tmp1 <= lo_hsync and hsync_5 and not flag_6;
	lo_flag_6_tmp1 <= lo_hsync and hsync_6 and not flag_1;
 
	lo_flag_1_tmp2 <= lo_hsync_delay_2 and flag_1 and flag_2;
	lo_flag_2_tmp2 <= lo_hsync_delay_3 and flag_2 and flag_3;
	lo_flag_3_tmp2 <= lo_hsync_delay_4 and flag_3 and flag_4;
	lo_flag_4_tmp2 <= lo_hsync_delay_5 and flag_4 and flag_5;
	lo_flag_5_tmp2 <= lo_hsync_delay_6 and flag_5 and flag_6;
	lo_flag_6_tmp2 <= lo_hsync_delay_1 and flag_6 and flag_1;

	lo_flag_1 <= lo_flag_1_tmp1 or lo_flag_1_tmp2;
	lo_flag_2 <= lo_flag_2_tmp1 or lo_flag_2_tmp2;
	lo_flag_3 <= lo_flag_3_tmp1 or lo_flag_3_tmp2;
	lo_flag_4 <= lo_flag_4_tmp1 or lo_flag_4_tmp2;
	lo_flag_5 <= lo_flag_5_tmp1 or lo_flag_5_tmp2;
	lo_flag_6 <= lo_flag_6_tmp1 or lo_flag_6_tmp2;


	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_1 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_1='1' then
				flag_1 <= '0';
			elsif hi_flag_1='1' then
				flag_1 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_2 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_2='1' then
				flag_2 <= '0';
			elsif hi_flag_2='1' then
				flag_2 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_3 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_3='1' then
				flag_3 <= '0';
			elsif hi_flag_3='1' then
				flag_3 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_4 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_4='1' then
				flag_4 <= '0';
			elsif hi_flag_4='1' then
				flag_4 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_5 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_5='1' then
				flag_5 <= '0';
			elsif hi_flag_5='1' then
				flag_5 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			flag_6 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_flag_6='1' then
				flag_6 <= '0';
			elsif hi_flag_6='1' then
				flag_6 <= '1';
			end if;
		end if;
	end process;


--------------------------------------------------
	hi_hsync_delay_1_tmp1 <= (hsync_delay_start_1_1d and not hsync_delay_start_1_2d) and not flag_6;
	hi_hsync_delay_1_tmp2 <= lo_hsync and hsync_6 and flag_1;

	hi_hsync_delay_1      <= hi_hsync_delay_1_tmp1 or hi_hsync_delay_1_tmp2;
	lo_hsync_delay_1      <= '1'  when hsync_delay_cnt_1="11111111" and hsync_delay_1='1' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_1 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_1='1' then
				hsync_delay_1 <= '0';
			elsif hi_hsync_delay_1='1' then
				hsync_delay_1 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_1 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_1='0' then
				hsync_delay_cnt_1 <= "00000000";
			elsif hsync_delay_1='1' then
				hsync_delay_cnt_1 <= hsync_delay_cnt_1 + 1;
			end if;
		end if;
	end process;

	hi_hsync_delay_2_tmp1 <= (hsync_delay_start_2_1d and not hsync_delay_start_2_2d) and not flag_1;
	hi_hsync_delay_2_tmp2 <= lo_hsync and hsync_1 and flag_2;

	hi_hsync_delay_2      <= hi_hsync_delay_2_tmp1 or hi_hsync_delay_2_tmp2;
	lo_hsync_delay_2      <= '1'  when hsync_delay_cnt_2="11111111" and hsync_delay_2='1' else '0';
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_2 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_2='1' then
				hsync_delay_2 <= '0';
			elsif hi_hsync_delay_2='1' then
				hsync_delay_2 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_2 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_2='0' then
				hsync_delay_cnt_2 <= "00000000";
			elsif hsync_delay_2='1' then
				hsync_delay_cnt_2 <= hsync_delay_cnt_2 + 1;
			end if;
		end if;
	end process;


	hi_hsync_delay_3_tmp1 <= (hsync_delay_start_3_1d and not hsync_delay_start_3_2d) and not flag_2;
	hi_hsync_delay_3_tmp2 <= lo_hsync and hsync_2 and flag_3;

	hi_hsync_delay_3      <= hi_hsync_delay_3_tmp1 or hi_hsync_delay_3_tmp2;
	lo_hsync_delay_3      <= '1'  when hsync_delay_cnt_3="11111111" and hsync_delay_3='1' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_3 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_3='1' then
				hsync_delay_3 <= '0';
			elsif hi_hsync_delay_3='1' then
				hsync_delay_3 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_3 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_3='0' then
				hsync_delay_cnt_3 <= "00000000";
			elsif hsync_delay_3='1' then
				hsync_delay_cnt_3 <= hsync_delay_cnt_3 + 1;
			end if;
		end if;
	end process;


	hi_hsync_delay_4_tmp1 <= (hsync_delay_start_4_1d and not hsync_delay_start_4_2d) and not flag_3;
	hi_hsync_delay_4_tmp2 <= lo_hsync and hsync_3 and flag_4;

	hi_hsync_delay_4      <= hi_hsync_delay_4_tmp1 or hi_hsync_delay_4_tmp2;
	lo_hsync_delay_4      <= '1'  when hsync_delay_cnt_4="11111111" and hsync_delay_4='1' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_4 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_4='1' then
				hsync_delay_4 <= '0';
			elsif hi_hsync_delay_4='1' then
				hsync_delay_4 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_4 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_4='0' then
				hsync_delay_cnt_4 <= "00000000";
			elsif hsync_delay_4='1' then
				hsync_delay_cnt_4 <= hsync_delay_cnt_4 + 1;
			end if;
		end if;
	end process;


	hi_hsync_delay_5_tmp1 <= (hsync_delay_start_5_1d and not hsync_delay_start_5_2d) and not flag_4;
	hi_hsync_delay_5_tmp2 <= lo_hsync and hsync_4 and flag_5;

	hi_hsync_delay_5      <= hi_hsync_delay_5_tmp1 or hi_hsync_delay_5_tmp2;
	lo_hsync_delay_5      <= '1'  when hsync_delay_cnt_5="11111111" and hsync_delay_5='1' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_5 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_5='1' then
				hsync_delay_5 <= '0';
			elsif hi_hsync_delay_5='1' then
				hsync_delay_5 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_5 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_5='0' then
				hsync_delay_cnt_5 <= "00000000";
			elsif hsync_delay_5='1' then
				hsync_delay_cnt_5 <= hsync_delay_cnt_5 + 1;
			end if;
		end if;
	end process;


	hi_hsync_delay_6_tmp1 <= (hsync_delay_start_6_1d and not hsync_delay_start_6_2d) and not flag_5;
	hi_hsync_delay_6_tmp2 <= lo_hsync and hsync_5 and flag_6;

	hi_hsync_delay_6      <= hi_hsync_delay_6_tmp1 or hi_hsync_delay_6_tmp2;
	lo_hsync_delay_6      <= '1'  when hsync_delay_cnt_6="11111111" and hsync_delay_6='1' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_6 <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync_delay_6='1' then
				hsync_delay_6 <= '0';
			elsif hi_hsync_delay_6='1' then
				hsync_delay_6 <= '1';
			end if;
		end if;
	end process;

	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_delay_cnt_6 <= "00000000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_delay_6='0' then
				hsync_delay_cnt_6 <= "00000000";
			elsif hsync_delay_6='1' then
				hsync_delay_cnt_6 <= hsync_delay_cnt_6 + 1;
			end if;
		end if;
	end process;


	hi_hsync_1 <= lo_hsync_delay_1;
	hi_hsync_2 <= lo_hsync_delay_2;
	hi_hsync_3 <= lo_hsync_delay_3;
	hi_hsync_4 <= lo_hsync_delay_4;
	hi_hsync_5 <= lo_hsync_delay_5;
	hi_hsync_6 <= lo_hsync_delay_6;

	hi_hsync <= hi_hsync_1 or hi_hsync_2 or hi_hsync_3 or hi_hsync_4 or hi_hsync_5 or hi_hsync_6;

--------------------------------------------------
	up_hsync_keep_hi   <= end_read_mem_12;
	down_hsync_keep_hi <= '1' when sig_hsync='1' and hsync_keep_hi='1' and hsync_keep_hi_cnt="0101" else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_keep_hi <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if down_hsync_keep_hi='1' then
				hsync_keep_hi <= '0';
			elsif up_hsync_keep_hi='1' then
				hsync_keep_hi <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_keep_hi_cnt <= "0000";
		elsif eim_clk'event and eim_clk='1' then
			if hsync_keep_hi='0' then
				hsync_keep_hi_cnt <= "0000";
			elsif hsync_keep_hi='1' then
				hsync_keep_hi_cnt <= hsync_keep_hi_cnt + 1;
			end if;
		end if;
	end process;


	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			lo_hsync <= '0';
		elsif eim_clk'event and eim_clk='1' then
			lo_hsync <= down_hsync_keep_hi;
		end if;
	end process;


--------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_1 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_1 <= '0';
			elsif hi_hsync_1='1' then
				hsync_1 <= '1';
			end if;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_2 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_2 <= '0';
			elsif hi_hsync_2='1' then
				hsync_2 <= '1';
			end if;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_3 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_3 <= '0';
			elsif hi_hsync_3='1' then
				hsync_3 <= '1';
			end if;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_4 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_4 <= '0';
			elsif hi_hsync_4='1' then
				hsync_4 <= '1';
			end if;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_5 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_5 <= '0';
			elsif hi_hsync_5='1' then
				hsync_5 <= '1';
			end if;
		end if;
	end process;
	
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_6 <='0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_hsync='1' then
				hsync_6 <= '0';
			elsif hi_hsync_6='1' then
				hsync_6 <= '1';
			end if;
		end if;
	end process;

	sig_hsync  <= hsync_1 or hsync_2 or hsync_3 or hsync_4 or hsync_5 or hsync_6;
	
	read_hsync <= sig_hsync;

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			sig_hsync_1d <= '0';
			sig_hsync_2d <= '0';
			rst_hsync_cnt_dly <= '0';
		elsif eim_clk'event and eim_clk='1' then
			sig_hsync_1d <= sig_hsync;
			sig_hsync_2d <= sig_hsync_1d;
			rst_hsync_cnt_dly <= rst_hsync_cnt;
		end if;
	end process;

	rst_hsync_cnt <= '1' when inc_hsync_cnt='1' and hsync_cnt=(dsp_image_height(11 downto 0)-1) else '0'; 
	inc_hsync_cnt <= not sig_hsync_1d and sig_hsync_2d;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			hsync_cnt <= x"000";
		elsif eim_clk'event and eim_clk='1' then
			if rst_hsync_cnt_dly='1' then
				hsync_cnt <= x"000";
			elsif inc_hsync_cnt='1' then
				hsync_cnt <= hsync_cnt + 1;
			end if;
		end if;
	end process;


--------------------------------------------------
	up_vsync_keep_hi   <= rst_hsync_cnt_dly;
	down_vsync_keep_hi <= '1' when sig_vsync='1' and vsync_keep_hi='1' and vsync_keep_hi_cnt="1111" else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			vsync_keep_hi <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if down_vsync_keep_hi='1' then
				vsync_keep_hi <= '0';
			elsif up_vsync_keep_hi='1' then
				vsync_keep_hi <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			vsync_keep_hi_cnt <= "0000";
		elsif eim_clk'event and eim_clk='1' then
			if vsync_keep_hi='0' then
				vsync_keep_hi_cnt <= "0000";
			elsif vsync_keep_hi='1' then
				vsync_keep_hi_cnt <= vsync_keep_hi_cnt + 1;
			end if;
		end if;
	end process;


	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			lo_vsync <= '0';
		elsif eim_clk'event and eim_clk='1' then
			lo_vsync <= down_vsync_keep_hi;
		end if;
	end process;


--------------------------------------------------
	hi_vsync <= (FSM_read_index_eim_4d and not FSM_read_index_eim_5d) and get_image;

--------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			sig_vsync <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if lo_vsync='1' then
				sig_vsync <= '0';
			elsif hi_vsync='1' then
				sig_vsync <= '1';
			end if;
		end if;
	end process;

	read_vsync <= sig_vsync;

	s_valid_read_mem <= '1' when s_axis_tvalid='1' and s_read_axis_tready='1' and valid_read_mem='1' else '0';

---------------------------------------------------------------------
---------------------------------------------------------------------
	s_max_read_mem_addr_offset <= ("0110000000"+NUM_ROIC_CHANNEL);

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_offset <= (others=>'0');
			read_mem_addr_offset_1d <= (others=>'0');
			read_mem_addr_offset_2d <= (others=>'0');
			read_addr_cnt <= (others=>'0');
			elsif eim_clk'event and eim_clk='1' then
			if read_mem_index='0' then
				read_mem_addr_offset <= (others=>'0');
			elsif read_mem_index='1' and s_valid_read_mem='1' then
				if read_mem_addr_offset = s_max_read_mem_addr_offset then
					read_mem_addr_offset <= (others=>'0');
				else
					read_mem_addr_offset <= read_mem_addr_offset + 1;
				end if;
			end if;
			read_mem_addr_offset_1d(7 downto 0) <= read_mem_addr_offset(7 downto 0);
			read_mem_addr_offset_2d <= read_mem_addr_offset_1d(7 downto 0);
			read_addr_cnt <= read_mem_addr_offset_2d(7 downto 0);
		end if;
	end process;

	
	start_read_mem_1  <= hi_hsync ;
	start_read_mem_2  <= end_read_mem_1 	and s_read_axis_tready;
	start_read_mem_3  <= end_read_mem_2 	and s_read_axis_tready;
	start_read_mem_4  <= end_read_mem_3 	and s_read_axis_tready;
	start_read_mem_5  <= end_read_mem_4 	and s_read_axis_tready;
	start_read_mem_6  <= end_read_mem_5 	and s_read_axis_tready;
	start_read_mem_7  <= end_read_mem_6 	and s_read_axis_tready;
	start_read_mem_8  <= end_read_mem_7 	and s_read_axis_tready;
	start_read_mem_9  <= end_read_mem_8 	and s_read_axis_tready;
	start_read_mem_10 <= end_read_mem_9 	and s_read_axis_tready;
	start_read_mem_11 <= end_read_mem_10	and s_read_axis_tready;
	start_read_mem_12 <= end_read_mem_11	and s_read_axis_tready;

	end_read_mem_1  <= '1' when s_h_count(0)='1' and read_mem_1 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_2  <= '1' when s_h_count(0)='1' and read_mem_2 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_3  <= '1' when s_h_count(0)='1' and read_mem_3 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_4  <= '1' when s_h_count(0)='1' and read_mem_4 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_5  <= '1' when s_h_count(0)='1' and read_mem_5 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_6  <= '1' when s_h_count(0)='1' and read_mem_6 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_7  <= '1' when s_h_count(0)='1' and read_mem_7 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_8  <= '1' when s_h_count(0)='1' and read_mem_8 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_9  <= '1' when s_h_count(0)='1' and read_mem_9 ='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_10 <= '1' when s_h_count(0)='1' and read_mem_10='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_11 <= '1' when s_h_count(0)='1' and read_mem_11='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';
	end_read_mem_12 <= '1' when s_h_count(0)='1' and read_mem_12='1' and (s_valid_read_mem='1' and ('0'& read_mem_addr_offset(6 downto 0))=NUM_ROIC_CHANNEL) else '0';

--------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_1  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_1='1' then
				read_mem_1 <= '0';
			elsif start_read_mem_1='1' then
				read_mem_1 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_2  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_2='1' then
				read_mem_2 <= '0';
			elsif start_read_mem_2='1' then
				read_mem_2 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_3  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_3='1' then
				read_mem_3 <= '0';
			elsif start_read_mem_3='1' then
				read_mem_3 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_4  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_4='1' then
				read_mem_4 <= '0';
			elsif start_read_mem_4='1' then
				read_mem_4 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_5  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_5='1' then
				read_mem_5 <= '0';
			elsif start_read_mem_5='1' then
				read_mem_5 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_6  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_6='1' then
				read_mem_6 <= '0';
			elsif start_read_mem_6='1' then
				read_mem_6 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_7  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_7='1' then
				read_mem_7 <= '0';
			elsif start_read_mem_7='1' then
				read_mem_7 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_8  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_8='1' then
				read_mem_8 <= '0';
			elsif start_read_mem_8='1' then
				read_mem_8 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_9  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_9='1' then
				read_mem_9 <= '0';
			elsif start_read_mem_9='1' then
				read_mem_9 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_10  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_10='1' then
				read_mem_10 <= '0';
			elsif start_read_mem_10='1' then
				read_mem_10 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_11  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_11='1' then
				read_mem_11 <= '0';
			elsif start_read_mem_11='1' then
				read_mem_11 <= '1';
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_12  <= '0';
		elsif eim_clk'event and eim_clk='1' then
			if end_read_mem_12='1' then
				read_mem_12 <= '0';
			elsif start_read_mem_12='1' then
				read_mem_12 <= '1';
			end if;
		end if;
	end process;


	read_mem_index <= read_mem_1 or read_mem_2 or read_mem_3 or read_mem_4 or read_mem_5 or read_mem_6 or read_mem_7
					or read_mem_8 or read_mem_9 or read_mem_10 or read_mem_11 or read_mem_12;

--------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_1 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_1='1' and s_valid_read_mem='1' then
				if read_mem_addr_1=MEM_HEIGHT then
					read_mem_addr_1 <= (others=>'0');
				else
					read_mem_addr_1 <= read_mem_addr_1 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_2 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_2='1' and s_valid_read_mem='1' then
				if read_mem_addr_2=MEM_HEIGHT then
					read_mem_addr_2 <= (others=>'0');
				else
					read_mem_addr_2 <= read_mem_addr_2 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_3 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_3='1' and s_valid_read_mem='1' then
				if read_mem_addr_3=MEM_HEIGHT then
					read_mem_addr_3 <= (others=>'0');
				else
					read_mem_addr_3 <= read_mem_addr_3 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_4 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_4='1' and s_valid_read_mem='1' then
				if read_mem_addr_4=MEM_HEIGHT then
					read_mem_addr_4 <= (others=>'0');
				else
					read_mem_addr_4 <= read_mem_addr_4 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_5 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_5='1' and s_valid_read_mem='1' then
				if read_mem_addr_5=MEM_HEIGHT then
					read_mem_addr_5 <= (others=>'0');
				else
					read_mem_addr_5 <= read_mem_addr_5 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_6 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_6='1' and s_valid_read_mem='1' then
				if read_mem_addr_6=MEM_HEIGHT then
					read_mem_addr_6 <= (others=>'0');
				else
					read_mem_addr_6 <= read_mem_addr_6 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_7 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_7='1' and s_valid_read_mem='1' then
				if read_mem_addr_7=MEM_HEIGHT then
					read_mem_addr_7 <= (others=>'0');
				else
					read_mem_addr_7 <= read_mem_addr_7 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_8 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_8='1' and s_valid_read_mem='1' then
				if read_mem_addr_8=MEM_HEIGHT then
					read_mem_addr_8 <= (others=>'0');
				else
					read_mem_addr_8 <= read_mem_addr_8 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_9 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_9='1' and s_valid_read_mem='1' then
				if read_mem_addr_9=MEM_HEIGHT then
					read_mem_addr_9 <= (others=>'0');
				else
					read_mem_addr_9 <= read_mem_addr_9 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_10 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_10='1' and s_valid_read_mem='1' then
				if read_mem_addr_10=MEM_HEIGHT then
					read_mem_addr_10 <= (others=>'0');
				else
					read_mem_addr_10 <= read_mem_addr_10 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_11 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_11='1' and s_valid_read_mem='1' then
				if read_mem_addr_11=MEM_HEIGHT then
					read_mem_addr_11 <= (others=>'0');
				else
					read_mem_addr_11 <= read_mem_addr_11 + 1;
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_addr_12 <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			if read_mem_12='1' and s_valid_read_mem='1' then
				if read_mem_addr_12=MEM_HEIGHT then
					read_mem_addr_12 <= (others=>'0');
				else
					read_mem_addr_12 <= read_mem_addr_12 + 1;
				end if;
			end if;
		end if;
	end process;


--------------------------------------------------
	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		if eim_rst='0' or tx_eim_rst='0' then
			read_mem_1_1d  <= '0';
			read_mem_2_1d  <= '0';
			read_mem_3_1d  <= '0';
			read_mem_4_1d  <= '0';
			read_mem_5_1d  <= '0';
			read_mem_6_1d  <= '0';
			read_mem_7_1d  <= '0';
			read_mem_8_1d  <= '0';
			read_mem_9_1d  <= '0';
			read_mem_10_1d <= '0';
			read_mem_11_1d <= '0';
			read_mem_12_1d <= '0';

			read_mem_1_1d  <= '0';
			read_mem_2_1d  <= '0';
			read_mem_3_1d  <= '0';
			read_mem_4_1d  <= '0';
			read_mem_5_1d  <= '0';
			read_mem_6_1d  <= '0';
			read_mem_7_1d  <= '0';
			read_mem_8_1d  <= '0';
			read_mem_9_1d  <= '0';
			read_mem_10_1d <= '0';
			read_mem_11_1d <= '0';
			read_mem_12_1d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			read_mem_1_1d  <= read_mem_1 ;
			read_mem_2_1d  <= read_mem_2 ;
			read_mem_3_1d  <= read_mem_3 ;
			read_mem_4_1d  <= read_mem_4 ;
			read_mem_5_1d  <= read_mem_5 ;
			read_mem_6_1d  <= read_mem_6 ;
			read_mem_7_1d  <= read_mem_7 ;
			read_mem_8_1d  <= read_mem_8 ;
			read_mem_9_1d  <= read_mem_9 ;
			read_mem_10_1d <= read_mem_10;
			read_mem_11_1d <= read_mem_11;
			read_mem_12_1d <= read_mem_12;

			read_mem_1_2d  <= read_mem_1_1d ;
			read_mem_2_2d  <= read_mem_2_1d ;
			read_mem_3_2d  <= read_mem_3_1d ;
			read_mem_4_2d  <= read_mem_4_1d ;
			read_mem_5_2d  <= read_mem_5_1d ;
			read_mem_6_2d  <= read_mem_6_1d ;
			read_mem_7_2d  <= read_mem_7_1d ;
			read_mem_8_2d  <= read_mem_8_1d ;
			read_mem_9_2d  <= read_mem_9_1d ;
			read_mem_10_2d <= read_mem_10_1d;
			read_mem_11_2d <= read_mem_11_1d;
			read_mem_12_2d <= read_mem_12_1d;
		end if;
	end process;

	process(eim_clk, eim_rst, lo_vsync)
	begin
		if eim_rst='0' or lo_vsync='1' then
			s_read_data_out <= (others=>'0');
			s_tuser_0_dly <= (others=>'0');
			s_tuser_0_cnt <= (others=>'0');
			read_frame_reset <= '0';
			s_read_frame_start <= '0';
			s_axis_tvalid_1d <= '0';
			s_axis_tvalid_2d <= '0';
			s_axis_tvalid_3d <= '0';
			read_data_valid <= '0';
			s_axis_tlast_1d <= '0';
			s_axis_tlast_2d <= '0';
			s_axis_tlast_3d <= '0';
			read_axis_tlast <= '0';
		elsif eim_clk'event and eim_clk='1' then

			if read_mem_1_2d='1' then
				s_read_data_out <= read_mem_data_1;
			elsif read_mem_2_2d='1' then
				s_read_data_out <= read_mem_data_2;
			elsif read_mem_3_2d='1' then
				s_read_data_out <= read_mem_data_3;
			elsif read_mem_4_2d='1' then
				s_read_data_out <= read_mem_data_4;
			elsif read_mem_5_2d='1' then
				s_read_data_out <= read_mem_data_5;
			elsif read_mem_6_2d='1' then
				s_read_data_out <= read_mem_data_6;
			elsif read_mem_7_2d='1' then
				s_read_data_out <= read_mem_data_7;
			elsif read_mem_8_2d='1' then
				s_read_data_out <= read_mem_data_8;
			elsif read_mem_9_2d='1' then
				s_read_data_out <= read_mem_data_9;
			elsif read_mem_10_2d='1' then
				s_read_data_out <= read_mem_data_10;
			elsif read_mem_11_2d='1' then
				s_read_data_out <= read_mem_data_11;
			elsif read_mem_12_2d='1' then
				s_read_data_out <= read_mem_data_12;
			end if;

			read_frame_reset <= hi_vsync;
			s_tuser_0_dly <= s_tuser_0_dly(14 downto 0) & s_tuser_0;
			s_read_frame_start <= s_tuser_0_dly(11);

			s_axis_tvalid_1d <= s_axis_tvalid;
			s_axis_tvalid_2d <= s_axis_tvalid_1d;
			s_axis_tvalid_3d <= s_axis_tvalid_2d;
			read_data_valid <= s_axis_tvalid_3d;

			s_axis_tlast_1d <= s_axis_tlast;
			s_axis_tlast_2d <= s_axis_tlast_1d;
			s_axis_tlast_3d <= s_axis_tlast_2d;
			read_axis_tlast <= s_axis_tlast_3d;
			
			if hi_vsync = '1' then
				s_tuser_0_cnt <= (others => '0');
			elsif s_tuser_0 = '1' then
				s_tuser_0_cnt <= s_tuser_0_cnt + '1';
			end if;

		end if;
	end process;

	read_frame_start <= s_read_frame_start;

	read_data_out <= s_read_data_out;

	s_read_axis_tready <= read_axis_tready;

	s_sync_gen_en <= '1' when (read_mem_index='1' or s_dummy_read_index='1') 
								and s_read_axis_tready='1' else '0';
	
	s_axis_tvalid <= '1' when (s_sync_gen_en='1' and s_axis_tlast='0' and s_h_count=x"0000") else
							'1' when (s_sync_gen_en='1' and s_h_sync='1') else '0';

	s_tuser_0 <= '1' when (s_sync_gen_en='1' and s_h_count=x"0000" and s_v_count="0000") else '0';

	s_v_sync <= '1' when (s_v_count > x"0000" and s_v_count <= s_max_v_count) else '0';
	s_h_sync <= '1' when (s_h_count > x"0000" and s_h_count <= s_max_h_count) else '0';
	
	s_max_v_count <= max_v_count;
	s_max_h_count <= max_h_count;

	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			s_axis_tlast <= '0';
		elsif rising_edge(eim_clk) then
			if (s_read_axis_tready = '1') then
				if s_h_count = (s_max_h_count - "10") then
					s_axis_tlast <= '1';
				elsif s_h_count = x"0000" then
					s_axis_tlast <= '0';
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, rst_hsync_cnt_dly, hi_vsync)
	begin
		if eim_rst='0' or rst_hsync_cnt_dly='1' or hi_vsync='1' then
					s_h_count <= x"0000";
			s_v_count <= x"0000";
		elsif eim_clk'event and eim_clk = '1' then
			if (s_axis_tvalid='1' and s_read_axis_tready='1') then
				if (s_h_count = s_max_h_count-'1') then
					if (s_v_count = s_max_v_count-'1') then
						s_h_count <= x"0000";
						s_v_count <= x"0000";
					else
						s_h_count <= x"0000";
						s_v_count <= s_v_count + '1';
					end if;
				else
					s_h_count <= s_h_count + '1';
				end if;
			end if;
		end if;
	end process;

	process(eim_clk, eim_rst, hi_vsync)
	begin
		if eim_rst='0' or hi_vsync='1' then
			s_dummy_valid <= '0';
			s_dummy_valid_count <= (others=>'0');
		elsif rising_edge(eim_clk) then
			if s_dummy_start='1' then
				s_dummy_valid <= '1';
			elsif (s_v_count = (s_max_v_count-'1')) and (s_h_count = (s_max_h_count-'1')) then
				s_dummy_valid <= '0';
			end if;

			if s_dummy_valid = '1' then
				s_dummy_valid_count <= s_dummy_valid_count + '1';
			end if;
		end if;
	end process;

	s_dummy_read_index <= s_dummy_valid when s_dummy_valid_count(11)='0' or  
										(s_dummy_valid_count(11)='1' and s_h_count > x"0000" and s_h_count <= (s_max_h_count-'1'))  else '0';

	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			s_dummy_get_image_1d <= '0';
			s_dummy_get_image_2d <= '0';
		elsif rising_edge(eim_clk) then
			s_dummy_get_image_1d <= dummy_get_image;
			s_dummy_get_image_2d <= s_dummy_get_image_1d;
		end if;
	end process;

	s_dummy_start <= '1' when s_dummy_get_image_1d='1' and s_dummy_get_image_2d='0' else '0';
	s_dummy_end <= '1' when s_dummy_get_image_1d='0' and s_dummy_get_image_2d='1' else '0';
	
	s_exist_get_image <= '1' when s_dummy_valid='1' else '0';
	exist_get_image <= s_exist_get_image;

	-- ila_read_data_tx : ila_rd_tx
	-- port map (
	-- 	clk		=>	eim_clk,
	-- 	probe0	=>	s_h_sync,
	-- 	probe1	=>	s_v_sync,
	-- 	probe2	=>	s_h_count_2d,
	-- 	probe3	=>	s_v_count_2d,
	-- 	probe4	=>	s_tuser_0_cnt,
	-- 	probe5	=>	hsync_cnt,
	-- 	probe6	=>	s_tuser_0
	-- 	);

end Behavioral;


