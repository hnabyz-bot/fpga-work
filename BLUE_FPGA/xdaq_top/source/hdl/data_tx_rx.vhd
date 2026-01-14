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

entity data_tx_rx is
	port
	(
	sys_clk                      : in std_logic;
	sys_rst                      : in std_logic;

	-- axi_clk                      : in std_logic;
	eim_clk                      : in std_logic;
	eim_rst                      : in std_logic;

	dual_readout                 : in std_logic;
	dummy_get_image              : in std_logic;
	exist_get_image              : out std_logic;
	burst_get_image              : in std_logic;

	read_axis_tready             : in std_logic;
	read_axis_tlast	             : out std_logic;
	read_data_valid              : out std_logic;
	read_rx_data_a      		 : out std_logic_vector(23 downto 0);
	read_rx_data_b      		 : out std_logic_vector(23 downto 0);
	read_frame_start             : out std_logic;
	read_frame_reset			 : out std_logic;
	
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

	aed_test_mode1               : in std_logic;
	aed_test_mode2               : in std_logic;

	valid_aed_test_data          : in std_logic;
	trigger_data_1               : in std_logic_vector(15 downto 0);
	trigger_data_2               : in std_logic_vector(15 downto 0);
	trigger_data_3               : in std_logic_vector(15 downto 0);

	vsync                        : out std_logic;
	hsync                        : out std_logic
	);
end data_tx_rx;

architecture Behavioral of data_tx_rx is
	
	component read_data_tx
	port(
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
	end component;

	component aed_read_data_tx
	port(
		sys_clk                      : in std_logic;
		sys_rst                      : in std_logic;

		eim_clk                      : in std_logic;
		eim_rst                      : in std_logic;

		get_dark                     : in std_logic;
		get_bright                   : in std_logic;

		dsp_image_height             : in std_logic_vector(15 downto 0);
		max_v_count		             : in std_logic_vector(15 downto 0);
		max_h_count		             : in std_logic_vector(15 downto 0);

		FSM_aed_read_index           : in std_logic;
		FSM_read_index               : in std_logic;
		
		valid_aed_test_data          : in std_logic;
		trigger_data_1               : in std_logic_vector(15 downto 0);
		trigger_data_2               : in std_logic_vector(15 downto 0);
		trigger_data_3               : in std_logic_vector(15 downto 0);
	
		valid_read_mem               : in std_logic;

		aed_read_data_out            : out std_logic_vector(31 downto 0);
			
		aed_read_vsync               : out std_logic;
		aed_read_hsync               : out std_logic
		);
	end component;


	CONSTANT  BURST_SIZE : STD_LOGIC_VECTOR(7 downto 0) :=x"08";

	signal tx_eim_rst : std_logic :='0';

	signal get_image : std_logic :='0';
	signal get_image_eim_1d : std_logic :='0';

	signal FSM_read_index_eim_1d : std_logic :='0';
	signal FSM_read_index_eim_2d : std_logic :='0';

	signal read_vsync : std_logic :='0';
	signal read_hsync : std_logic :='0';

	signal aed_read_vsync : std_logic :='0';
	signal aed_read_hsync : std_logic :='0';
	
	signal s_read_axis_tlast : std_logic :='0';
	signal s_read_axis_tlast_1d : std_logic :='0';
	signal s_read_data_valid : std_logic :='0';
	signal s_read_frame_start : std_logic :='0';
	signal s_read_frame_reset : std_logic :='0';
	signal s_read_data_out : std_logic_vector(31 downto 0) :=(others=>'0');
	signal s_read_data_out_1d : std_logic_vector(31 downto 0) :=(others=>'0');
	signal read_addr_cnt : std_logic_vector(7 downto 0) :=(others=>'0');
	signal aed_read_data_out : std_logic_vector(31 downto 0) :=(others=>'0');

	signal image_data_out : std_logic_vector(31 downto 0) :=(others=>'0');
    -- attribute keep : string;
    -- attribute keep of image_data_out : signal is "TRUE";
    
	signal valid_read_mem : std_logic :='0';

begin

		
	U1 : read_data_tx
	port map
	(
		sys_clk                      => sys_clk                      ,
		sys_rst                      => sys_rst                      ,

		eim_clk                      => eim_clk                      ,
		eim_rst                      => eim_rst                      ,

		dual_readout                 => dual_readout                      ,
		dummy_get_image				 => dummy_get_image	,
		exist_get_image				 => exist_get_image	,
		burst_get_image				 => burst_get_image	,

		get_dark                     => get_dark                     ,
		get_bright                   => get_bright                   ,

		dsp_image_height             => dsp_image_height             ,
		max_v_count		             => max_v_count             ,
		max_h_count		             => max_h_count             ,

		en_test_pattern_col          => en_test_pattern_col          ,
		en_test_pattern_row          => en_test_pattern_row          ,

		FSM_aed_read_index           => FSM_aed_read_index           ,
		FSM_read_index               => FSM_read_index               ,

		valid_roic_data              => valid_roic_data              ,
		roic_data_in_1               => roic_data_in_1               ,
		roic_data_in_2               => roic_data_in_2               ,
		roic_data_in_3               => roic_data_in_3               ,
		roic_data_in_4               => roic_data_in_4               ,
		roic_data_in_5               => roic_data_in_5               ,
		roic_data_in_6               => roic_data_in_6               ,
		roic_data_in_7               => roic_data_in_7               ,
		roic_data_in_8               => roic_data_in_8               ,
		roic_data_in_9               => roic_data_in_9               ,
		roic_data_in_10              => roic_data_in_10              ,
		roic_data_in_11              => roic_data_in_11              ,
		roic_data_in_12              => roic_data_in_12              ,

		valid_read_mem               => valid_read_mem               ,
				
		read_axis_tready              => read_axis_tready                ,
		read_data_valid              => s_read_data_valid                ,
		read_axis_tlast              => s_read_axis_tlast                ,
		read_data_out                => s_read_data_out                ,
		read_addr_cnt                => read_addr_cnt                ,
		read_frame_start             => s_read_frame_start                ,
		read_frame_reset             => s_read_frame_reset                ,

		read_vsync                   => read_vsync                   ,
		read_hsync                   => read_hsync
	);
	
	-- U2 : aed_read_data_tx
	-- port map
	-- (
	-- 	sys_clk                      => sys_clk                      ,
	-- 	sys_rst                      => sys_rst                      ,

	-- 	eim_clk                      => eim_clk                      ,
	-- 	eim_rst                      => eim_rst                      ,

	-- 	get_dark                     => get_dark                     ,
	-- 	get_bright                   => get_bright                   ,

	-- 	dsp_image_height             => dsp_image_height             ,
	-- max_v_count		             => max_v_count             ,
	-- max_h_count		             => max_h_count             ,
	
	-- 	FSM_aed_read_index           => FSM_aed_read_index           ,
	-- 	FSM_read_index               => FSM_read_index               ,

	-- 	valid_aed_test_data          => valid_aed_test_data          ,
	-- 	trigger_data_1               => trigger_data_1               ,
	-- 	trigger_data_2               => trigger_data_2               ,
	-- 	trigger_data_3               => trigger_data_3               ,

	-- 	valid_read_mem               => valid_read_mem               ,

	-- 	aed_read_data_out            => aed_read_data_out            ,

	-- 	aed_read_vsync               => aed_read_vsync               ,
	-- 	aed_read_hsync               => aed_read_hsync
	-- );
	

	vsync <= read_vsync when aed_test_mode1='0' and aed_test_mode2='0' else aed_read_vsync;
	hsync <= read_hsync when aed_test_mode1='0' and aed_test_mode2='0' else aed_read_hsync;

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			FSM_read_index_eim_1d <= '0';
			FSM_read_index_eim_2d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			FSM_read_index_eim_1d <= FSM_read_index;
			FSM_read_index_eim_2d <= FSM_read_index_eim_1d;
		end if;
	end process;


	get_image <= get_dark or get_bright;

	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			get_image_eim_1d <= '0';
		elsif eim_clk'event and eim_clk='1' then
			get_image_eim_1d <= get_image;
		end if;
	end process;

	-- tx_eim_rst <= get_image_eim_1d and not (FSM_read_index and not FSM_read_index_eim_2d) and not FSM_aed_read_index;
	tx_eim_rst <= '1' when FSM_read_index='1' and FSM_read_index_eim_2d='0' and FSM_aed_read_index='0' else '0';

	process(eim_clk, eim_rst, tx_eim_rst)
	begin
		-- if eim_rst='0' or tx_eim_rst='0' then
		if eim_rst='0' or tx_eim_rst='1' then
			valid_read_mem <= '0';
		elsif eim_clk'event and eim_clk='1' then
			valid_read_mem <= '1';
		end if;
	end process;

	-- process (axi_clk, eim_rst)
	-- begin
	-- 	if eim_rst='0' then
	-- 		s_read_data_out_1d <= (others => '0');
	-- 	elsif rising_edge(axi_clk) then
	-- 		s_read_data_out_1d <= s_read_data_out;
	-- 	end if;
	-- end process;

---------------------------------------------------------------------
---------------------------------------------------------------------
	image_data_out <= s_read_data_out when aed_test_mode1='0' and aed_test_mode2='0' else aed_read_data_out;


	process(eim_clk, eim_rst)
	begin
		if eim_rst='0' then
			read_rx_data_a  <= (others=>'0');
			read_rx_data_b  <= (others=>'0');
		elsif eim_clk'event and eim_clk='1' then
			read_rx_data_b <= image_data_out(7 downto 3)&"000"&image_data_out(12 downto 8)&"000"
							&image_data_out(2 downto 0)&image_data_out(15 downto 13)&"00";
			read_rx_data_a <= image_data_out(23 downto 19)&"000"&image_data_out(28 downto 24)&"000"
							&image_data_out(18 downto 16)&image_data_out(31 downto 29)&"00";
		end if;
	end process;

	read_axis_tlast <= s_read_axis_tlast;
	read_data_valid <= s_read_data_valid;
	read_frame_reset <= s_read_frame_reset;
	read_frame_start <= s_read_frame_start;


end Behavioral;


