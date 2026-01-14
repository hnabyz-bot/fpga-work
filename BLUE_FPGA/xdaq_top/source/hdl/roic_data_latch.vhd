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

-- library altera; 
-- use altera.altera_primitives_components.all;
Library UNISIM;
use UNISIM.vcomponents.all;
use work.xpackage.all;


entity roic_data_latch is
	port
	(
	sys_clk                      : in std_logic;
    drv_rst                      : in std_logic;
	dphy_clk_200M				: in std_logic;
																		
	en_test_roic_col          : in std_logic;
	en_test_roic_row          : in std_logic;
	FSM_read_index               : in std_logic;

	valid_roic_out               : in std_logic;
	valid_roic_burst_clk         : in std_logic;

	valid_roic_reg_out           : in std_logic;
	valid_roic_header_out        : in std_logic;

	LD_IO_DELAY_TAB              : in std_logic;
	IO_DELAY_TAB                 : in std_logic_vector(4 downto 0);
	sel_roic_reg                 : in std_logic_vector(7 downto 0);

	dclk_out					: in std_logic_vector(11 downto 0);
	dclk_n_out					: in std_logic_vector(11 downto 0);

	douta						: in std_logic_vector(11 downto 0);
	dout_n_a					: in std_logic_vector(11 downto 0);
	doutb						: in std_logic_vector(11 downto 0);
	dout_n_b					: in std_logic_vector(11 downto 0);

	en_16bit_adc                 : in std_logic;

	up_roic_reg                  : out std_logic;

	roic_temperature             : out std_logic_vector(15 downto 0);
	roic_reg_in_a                : out std_logic_vector(63 downto 0);
	roic_reg_in_b                : out std_logic_vector(63 downto 0);

	valid_roic_data              : out std_logic;
    roic_data_in              	 : out array32(11 downto 0)

	);
end roic_data_latch;

architecture Behavioral of roic_data_latch is

	CONSTANT NUM_ROIC_DATA_PARALLEL : STD_LOGIC_VECTOR(3 DOWNTO 0) :="0011";

	signal buf_data_a		: array64(11 downto 0) := (others => (others =>'0'));
	signal buf_data_b		: array64(11 downto 0) := (others => (others =>'0'));
	signal data_in_a		: array64(11 downto 0) := (others => (others =>'0'));
	signal data_in_b		: array64(11 downto 0) := (others => (others =>'0'));
	signal roic_reg_in_ad	: array64(11 downto 0) := (others => (others =>'0'));
	signal roic_reg_in_bd	: array64(11 downto 0) := (others => (others =>'0'));
	signal buf_roic_data_in	: array32(11 downto 0) := (others => (others =>'0'));
	-- signal roic_header_in_ad	: array64(11 downto 0) := (others => (others =>'0'));
	-- signal roic_header_in_bd	: array64(11 downto 0) := (others => (others =>'0'));

	signal valid_burst_clk_1d : std_logic :='0';
	signal valid_burst_clk_2d : std_logic :='0';
	signal valid_burst_clk_3d : std_logic :='0';
	signal valid_burst_clk_4d : std_logic :='0';
	signal valid_burst_clk_5d : std_logic :='0';

	signal dump_roic_data : std_logic :='0';
	signal dump_roic_data_1d : std_logic :='0';
	
	signal valid_burst_clk_reg_1d : std_logic :='0';
	signal valid_burst_clk_reg_2d : std_logic :='0';
	signal valid_burst_clk_reg_3d : std_logic :='0';
	signal valid_burst_clk_reg_4d : std_logic :='0';
	signal valid_burst_clk_reg_5d : std_logic :='0';

	signal dump_roic_reg : std_logic :='0';
	signal dump_roic_reg_1d : std_logic :='0';


	signal up_valid_roic_data : std_logic :='0';
	signal down_valid_roic_data : std_logic :='0';
	signal pre_valid_roic_data : std_logic :='0';

	signal roic_data_cnt : std_logic_vector(3 downto 0) :="0000";

	signal buf_valid_roic_data : std_logic :='0';

	signal g_dclk_int	: std_logic_vector(11 downto 0);
	signal g_dclk	: std_logic_vector(11 downto 0);

	-- signal g_dclk_cnt : array16(11 downto 0);
	-- signal g_dclk_probe : std_logic_vector(11 downto 0);

	-- component adc_clk is
	-- port 
	-- 	(
	-- 		clk_in1_p		: in std_logic;
	-- 		clk_in1_n		: in std_logic;
	-- 		clk_out1		: out std_logic
	-- 	);
	-- end component;

	signal s_douta : std_logic_vector(11 downto 0);
	signal s_doutb : std_logic_vector(11 downto 0);


	signal s_valid_roic_header_out_1d : std_logic :='0';
	signal s_valid_roic_header_out_2d : std_logic :='0';

	signal s_roic_header_en : std_logic :='0';
	-- signal s_roic_header_en_1d : std_logic :='0';

	signal s_roic_fixed_pattern : std_logic_vector(7 downto 0);
	signal s_five_bit_all_low	: std_logic_vector(4 downto 0);
	signal s_factory_bit		: std_logic;
	signal s_readout_direction	: std_logic; -- start direction 1: 255ch , 0: 0ch
	signal s_cds_id				: std_logic; -- for pipe mode , 1: CDSxA , 0:CDSxB
	signal s_16bit_all_low		: std_logic_vector(15 downto 0);
	-- signal s_temperature_result : std_logic_vector(15 downto 0);
	signal s_temperature_result : array16(11 downto 0);
	signal s_vt_result			: std_logic_vector(15 downto 0);

	signal s_roic_v_cnt			: std_logic_vector(15 downto 0);

	-- component ila_data_latch is
	-- port(
	-- 	clk			: in std_logic;
	-- 	probe0		: in std_logic;
	-- 	probe1		: in std_logic_vector(7 downto 0);
	-- 	probe2		: in std_logic_vector(4 downto 0);
	-- 	probe3		: in std_logic;
	-- 	probe4		: in std_logic;
	-- 	probe5		: in std_logic;
	-- 	probe6		: in std_logic_vector(15 downto 0);
	-- 	probe7		: in std_logic_vector(15 downto 0);
	-- 	probe8		: in std_logic_vector(15 downto 0)
	-- );
	-- end component;

	component ila_lvds is
		port(
			clk			: in std_logic;
			probe0		: in std_logic;
			probe1		: in std_logic;
			probe2		: in std_logic;
			probe3		: in std_logic;
			probe4		: in std_logic;
			probe5		: in std_logic;
			probe6		: in std_logic_vector(4 downto 0)
		);
		end component;
	
	-- constant IDELAY_GROUP : STRING  := "IDELAY_LVDS";
	-- attribute IODELAY_GROUP : STRING;
	-- -- attribute IODELAY_GROUP of adc_indata_gen : label is IDELAY_GROUP;
	-- --	attribute IODELAY_GROUP of IDELAYE2 : IDATAIN is "my_delay_group";

	signal s_reset	: std_logic;
	signal dly_g_dclk	: std_logic_vector(11 downto 0);
	signal s_dly_data_a	: std_logic_vector(11 downto 0);
	signal s_dly_data_b	: std_logic_vector(11 downto 0);
	signal s_delay_tap	: std_logic_vector(4 downto 0) := "00000";

begin

		-- IDELAYCTRL_inst : IDELAYCTRL
		-- port map (
		-- 	RDY 		=> open,       		-- 1-bit output: Ready output
		-- 	REFCLK 		=> dphy_clk_200M, 	-- 1-bit input: Reference clock input
		-- 	RST 		=> s_reset        	-- 1-bit input: Active high reset input
		-- );

		-- -- IO Delay block
		-- IDELAYE2_inst : IDELAYE2
		-- generic map (
		-- 	CINVCTRL_SEL 			=> "FALSE",		-- Enable dynamic clock inversion (FALSE, TRUE)
		-- 	DELAY_SRC 				=> "IDATAIN",	-- Delay input (IDATAIN, DATAIN)
		-- 	HIGH_PERFORMANCE_MODE 	=> "FALSE", 	-- Reduced jitter ("TRUE"), Reduced power ("FALSE")
		-- 	IDELAY_TYPE 			=> "VAR_LOAD",	-- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		-- 	IDELAY_VALUE 			=> 0,			-- Input delay tap setting (0-31)
		-- 	PIPE_SEL 				=> "FALSE",		-- Select pipelined mode, FALSE, TRUE
		-- 	REFCLK_FREQUENCY 		=> 200.0,		-- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		-- 	SIGNAL_PATTERN 			=> "DATA"		-- DATA, CLOCK input signal
		-- )
		-- port map (
		-- 	CNTVALUEIN 				=> s_delay_tap,	-- 5-bit input: Counter value input
		-- 	CNTVALUEOUT 			=> open, -- 5-bit output: Counter value output
		-- 	C 						=> dphy_clk_200M,		-- 1-bit input: Clock input
		-- 	CE 						=> '1',			-- 1-bit input: Active high enable increment/decrement input
		-- 	CINVCTRL 				=> '0',	-- 1-bit input: Dynamic clock inversion input
		-- 	DATAIN 					=> '0',		-- 1-bit input: Internal delay data input
		-- 	IDATAIN 				=> dly_g_dclk(0),		-- 1-bit input: Data input from the I/O
		-- 	DATAOUT 				=> g_dclk(0),		-- 1-bit output: Delayed data output
		-- 	INC 					=> '1',			-- 1-bit input: Increment / Decrement tap delay input
		-- 	LD 						=> '1',			-- 1-bit input: Load IDELAY_VALUE input
		-- 	LDPIPEEN 				=> '0',	-- 1-bit input: Enable PIPELINE register to load data input
		-- 	REGRST 					=> s_reset		-- 1-bit input: Active-high reset tap-delay input
		-- );

	s_delay_tap <= IO_DELAY_TAB;

	adc_indata_gen: for i in 0 to 11 generate
	
		adc_clk_inst : IBUFDS
		generic map (
			DIFF_TERM => FALSE,
			IBUF_LOW_PWR => FALSE,
			IOSTANDARD => "LVDS_25")
		port map (
			I => dclk_out(i),
			IB => dclk_n_out(i),
			-- O => g_dclk(i));
			-- O => dly_g_dclk(i)); 
			O => g_dclk_int(i)); 

		BUFG_inst : BUFG
		port map (
			O => g_dclk(i), 	-- 1-bit output: Clock output (connect to I/O clock loads).
			I => g_dclk_int(i)  -- 1-bit input: Clock input (connect to an IBUF or BUFMR).
		);

		
		adc_data_inst_a : IBUFDS
		generic map (
			DIFF_TERM => FALSE,
			IBUF_LOW_PWR => FALSE,
			IOSTANDARD => "LVDS_25" 
		)
		port map (
			O => s_douta(i),   -- 1-bit output: Buffer output
			-- O => s_dly_data_a(i),   -- 1-bit output: Buffer output
			I => douta(i),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
			IB => dout_n_a(i)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
		);
	
		adc_data_inst_b : IBUFDS
		generic map (
			DIFF_TERM => FALSE,
			IBUF_LOW_PWR => FALSE,
			IOSTANDARD => "LVDS_25" 
		)
		port map (
			O => s_doutb(i),   -- 1-bit output: Buffer output
			-- O => s_dly_data_b(i),   -- 1-bit output: Buffer output
			I => doutb(i),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
			IB => dout_n_b(i)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
		);

		-- -- IO Delay block
		-- IDELAYE2_inst : IDELAYE2
		-- generic map (
		-- 	CINVCTRL_SEL 			=> "FALSE",		-- Enable dynamic clock inversion (FALSE, TRUE)
		-- 	DELAY_SRC 				=> "IDATAIN",	-- Delay input (IDATAIN, DATAIN)
		-- 	HIGH_PERFORMANCE_MODE 	=> "FALSE", 	-- Reduced jitter ("TRUE"), Reduced power ("FALSE")
		-- 	IDELAY_TYPE 			=> "VAR_LOAD",	-- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		-- 	IDELAY_VALUE 			=> 0,			-- Input delay tap setting (0-31)
		-- 	PIPE_SEL 				=> "FALSE",		-- Select pipelined mode, FALSE, TRUE
		-- 	REFCLK_FREQUENCY 		=> 200.0,		-- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		-- 	SIGNAL_PATTERN 			=> "DATA"		-- DATA, CLOCK input signal
		-- )
		-- port map (
		-- 	CNTVALUEIN 				=> s_delay_tap,	-- 5-bit input: Counter value input
		-- 	CNTVALUEOUT 			=> open, -- 5-bit output: Counter value output
		-- 	C 						=> dphy_clk_200M,		-- 1-bit input: Clock input
		-- 	CE 						=> '1',			-- 1-bit input: Active high enable increment/decrement input
		-- 	CINVCTRL 				=> '0',	-- 1-bit input: Dynamic clock inversion input
		-- 	DATAIN 					=> '0',		-- 1-bit input: Internal delay data input
		-- 	IDATAIN 				=> dly_g_dclk(i),		-- 1-bit input: Data input from the I/O
		-- 	DATAOUT 				=> g_dclk(i),		-- 1-bit output: Delayed data output
		-- 	INC 					=> '1',			-- 1-bit input: Increment / Decrement tap delay input
		-- 	LD 						=> LD_IO_DELAY_TAB,			-- 1-bit input: Load IDELAY_VALUE input
		-- 	LDPIPEEN 				=> '0',	-- 1-bit input: Enable PIPELINE register to load data input
		-- 	REGRST 					=> s_reset		-- 1-bit input: Active-high reset tap-delay input
		-- );


		-- -- IO Delay block
		-- a_IDELAYE2_inst : IDELAYE2
		-- generic map (
		-- 	CINVCTRL_SEL 			=> "FALSE",		-- Enable dynamic clock inversion (FALSE, TRUE)
		-- 	DELAY_SRC 				=> "IDATAIN",	-- Delay input (IDATAIN, DATAIN)
		-- 	HIGH_PERFORMANCE_MODE 	=> "FALSE", 	-- Reduced jitter ("TRUE"), Reduced power ("FALSE")
		-- 	IDELAY_TYPE 			=> "VAR_LOAD",	-- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		-- 	IDELAY_VALUE 			=> 0,			-- Input delay tap setting (0-31)
		-- 	PIPE_SEL 				=> "FALSE",		-- Select pipelined mode, FALSE, TRUE
		-- 	REFCLK_FREQUENCY 		=> 200.0,		-- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		-- 	SIGNAL_PATTERN 			=> "DATA"		-- DATA, CLOCK input signal
		-- )
		-- port map (
		-- 	CNTVALUEIN 				=> s_delay_tap,	-- 5-bit input: Counter value input
		-- 	CNTVALUEOUT 			=> open, -- 5-bit output: Counter value output
		-- 	C 						=> dphy_clk_200M,		-- 1-bit input: Clock input
		-- 	CE 						=> '0',			-- 1-bit input: Active high enable increment/decrement input
		-- 	CINVCTRL 				=> '0',	-- 1-bit input: Dynamic clock inversion input
		-- 	DATAIN 					=> '0',		-- 1-bit input: Internal delay data input
		-- 	IDATAIN 				=> s_dly_data_a(i),		-- 1-bit input: Data input from the I/O
		-- 	DATAOUT 				=> s_douta(i),		-- 1-bit output: Delayed data output
		-- 	INC 					=> '0',			-- 1-bit input: Increment / Decrement tap delay input
		-- 	LD 						=> LD_IO_DELAY_TAB,			-- 1-bit input: Load IDELAY_VALUE input
		-- 	LDPIPEEN 				=> '0',	-- 1-bit input: Enable PIPELINE register to load data input
		-- 	REGRST 					=> s_reset		-- 1-bit input: Active-high reset tap-delay input
		-- );

		-- -- IO Delay block
		-- b_IDELAYE2_inst : IDELAYE2
		-- generic map (
		-- 	CINVCTRL_SEL 			=> "FALSE",		-- Enable dynamic clock inversion (FALSE, TRUE)
		-- 	DELAY_SRC 				=> "IDATAIN",	-- Delay input (IDATAIN, DATAIN)
		-- 	HIGH_PERFORMANCE_MODE 	=> "FALSE", 	-- Reduced jitter ("TRUE"), Reduced power ("FALSE")
		-- 	IDELAY_TYPE 			=> "VAR_LOAD",	-- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		-- 	IDELAY_VALUE 			=> 0,			-- Input delay tap setting (0-31)
		-- 	PIPE_SEL 				=> "FALSE",		-- Select pipelined mode, FALSE, TRUE
		-- 	REFCLK_FREQUENCY 		=> 200.0,		-- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		-- 	SIGNAL_PATTERN 			=> "DATA"		-- DATA, CLOCK input signal
		-- )
		-- port map (
		-- 	CNTVALUEIN 				=> s_delay_tap,	-- 5-bit input: Counter value input
		-- 	CNTVALUEOUT 			=> open, -- 5-bit output: Counter value output
		-- 	C 						=> dphy_clk_200M,		-- 1-bit input: Clock input
		-- 	CE 						=> '0',			-- 1-bit input: Active high enable increment/decrement input
		-- 	CINVCTRL 				=> '0',	-- 1-bit input: Dynamic clock inversion input
		-- 	DATAIN 					=> '0',		-- 1-bit input: Internal delay data input
		-- 	IDATAIN 				=> s_dly_data_b(i),		-- 1-bit input: Data input from the I/O
		-- 	DATAOUT 				=> s_doutb(i),		-- 1-bit output: Delayed data output
		-- 	INC 					=> '0',			-- 1-bit input: Increment / Decrement tap delay input
		-- 	LD 						=> LD_IO_DELAY_TAB,			-- 1-bit input: Load IDELAY_VALUE input
		-- 	LDPIPEEN 				=> '0',	-- 1-bit input: Enable PIPELINE register to load data input
		-- 	REGRST 					=> s_reset		-- 1-bit input: Active-high reset tap-delay input
		-- );
		
		-- s_reset <= not drv_rst;
		-- --

		process(g_dclk(i) , drv_rst)
		begin 
			if drv_rst='0' then 
				buf_data_a(i)  <= (others=>'0'); 
				buf_data_b(i)  <= (others=>'0'); 
			elsif  g_dclk(i)'event and g_dclk(i)='0'  then 
			-- elsif  g_dclk(i)'event and g_dclk(i)='1'  then 
				buf_data_a(i)  <=  buf_data_a(i)(62 downto 0) & s_douta(i) ; 
				buf_data_b(i)  <=  buf_data_b(i)(62 downto 0) & s_doutb(i) ; 
			end if; 
		end process;
 
		process(sys_clk, drv_rst)
		begin
			if drv_rst='0' then
				data_in_a(i)  <= (others=>'0');
				data_in_b(i)  <= (others=>'0');
			elsif sys_clk'event and sys_clk='1' then
				if dump_roic_data='1' then
					data_in_a(i)  <= buf_data_a(i) ;
					data_in_b(i)  <= buf_data_b(i) ;
				end if;
			end if;
		end process;
	
		process(sys_clk, drv_rst)
		begin
			if drv_rst='0' then
				roic_reg_in_ad(i)  <= (others=>'0');
				roic_reg_in_bd(i)  <= (others=>'0');
			elsif sys_clk'event and sys_clk='1' then
				if dump_roic_reg='1' then
					roic_reg_in_ad(i)  <= buf_data_a(i) ;
					roic_reg_in_bd(i)  <= buf_data_b(i) ;
				end if;
			end if;
		end process;

		process(sys_clk, drv_rst)
		begin
			if drv_rst='0' then
				buf_roic_data_in(i) <= (others=>'0');
			elsif sys_clk'event and sys_clk='1' then
				if pre_valid_roic_data='0' then
					buf_roic_data_in(i) <= (others=>'0');
				-- else
				elsif en_test_roic_row = '1' then
					buf_roic_data_in(i) <= s_roic_v_cnt & s_roic_v_cnt;
				else
					if roic_data_cnt=0 then
						buf_roic_data_in(i) <= data_in_a(i)(63 downto 48)&data_in_b(i)(63 downto 48);
					elsif roic_data_cnt=1 then
						buf_roic_data_in(i) <= data_in_a(i)(47 downto 32)&data_in_b(i)(47 downto 32);
					elsif roic_data_cnt=2 then
						buf_roic_data_in(i) <= data_in_a(i)(31 downto 16)&data_in_b(i)(31 downto 16);
					elsif roic_data_cnt=3 then
						buf_roic_data_in(i) <= data_in_a(i)(15 downto 0)&data_in_b(i)(15 downto 0)  ;
					end if;
				end if;
			end if;
		end process;
			
		process(sys_clk, drv_rst)
		begin
			if drv_rst='0' then
				roic_data_in(i)  <= (others=>'0');
			elsif sys_clk'event and sys_clk='1' then
				if en_16bit_adc='1' then
					roic_data_in(i)  <= buf_roic_data_in(i) ;
				elsif en_16bit_adc='0' then
					roic_data_in(i)  <= "00"&buf_roic_data_in(i)(31 downto 18)&"00"&buf_roic_data_in(i)(15 downto 2);
				end if;
			end if;
		end process;

		process(sys_clk, drv_rst)
		begin
			if drv_rst='0' then
				s_temperature_result(i)  <= (others=>'0');
				-- roic_header_in_ad(i)  <= (others=>'0');
				-- roic_header_in_bd(i)  <= (others=>'0');
			elsif sys_clk'event and sys_clk='1' then
				if s_roic_header_en='1' then
					s_temperature_result(i)  <= buf_data_a(i)(31 downto 16);
					-- roic_header_in_ad(i)  <= buf_data_a(i) ;
					-- roic_header_in_bd(i)  <= buf_data_b(i) ;
				end if;
			end if;
		end process;
		
	end generate adc_indata_gen;


---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_burst_clk_1d <='0';
			valid_burst_clk_2d <='0';
			valid_burst_clk_3d <='0';
			valid_burst_clk_4d <='0';
			valid_burst_clk_5d <='0';
		elsif sys_clk'event and sys_clk='1' then
			valid_burst_clk_1d <= valid_roic_burst_clk and valid_roic_out;
			valid_burst_clk_2d <= valid_burst_clk_1d;
			valid_burst_clk_3d <= valid_burst_clk_2d;
			valid_burst_clk_4d <= valid_burst_clk_3d;
			valid_burst_clk_5d <= valid_burst_clk_4d;
		end if;
	end process;

	dump_roic_data <= not valid_burst_clk_4d and valid_burst_clk_5d;

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			dump_roic_data_1d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			dump_roic_data_1d <= dump_roic_data;
		end if;
	end process;

--------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_burst_clk_reg_1d <='0';
			valid_burst_clk_reg_2d <='0';
			valid_burst_clk_reg_3d <='0';
			valid_burst_clk_reg_4d <='0';
			valid_burst_clk_reg_5d <='0';
		elsif sys_clk'event and sys_clk='1' then
			valid_burst_clk_reg_1d <= valid_roic_burst_clk and valid_roic_reg_out;
			valid_burst_clk_reg_2d <= valid_burst_clk_reg_1d;
			valid_burst_clk_reg_3d <= valid_burst_clk_reg_2d;
			valid_burst_clk_reg_4d <= valid_burst_clk_reg_3d;
			valid_burst_clk_reg_5d <= valid_burst_clk_reg_4d;
		end if;
	end process;


	dump_roic_reg <= not valid_burst_clk_reg_4d and valid_burst_clk_reg_5d;

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			dump_roic_reg_1d <= '0';
			up_roic_reg <= '0';
		elsif sys_clk'event and sys_clk='1' then
			dump_roic_reg_1d <= dump_roic_reg;
			up_roic_reg <= dump_roic_reg_1d;
		end if;
	end process;


	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			roic_temperature  <= (others=>'0');
			roic_reg_in_a  <= (others=>'0');
			roic_reg_in_b  <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if dump_roic_reg_1d='1' then
				if sel_roic_reg=1 then
					roic_temperature <= s_temperature_result(0) ;
					roic_reg_in_a <= roic_reg_in_ad(0) ;
					roic_reg_in_b <= roic_reg_in_bd(0) ;
				elsif sel_roic_reg=2 then 
					roic_temperature <= s_temperature_result(1) ;
					roic_reg_in_a <= roic_reg_in_ad(1) ;
					roic_reg_in_b <= roic_reg_in_bd(1) ;
				elsif sel_roic_reg=3 then 
					roic_temperature <= s_temperature_result(2) ;
					roic_reg_in_a <= roic_reg_in_ad(2) ;
					roic_reg_in_b <= roic_reg_in_bd(2) ;
				elsif sel_roic_reg=4 then 
					roic_temperature <= s_temperature_result(3) ;
					roic_reg_in_a <= roic_reg_in_ad(3) ;
					roic_reg_in_b <= roic_reg_in_bd(3) ;
				elsif sel_roic_reg=5 then 
					roic_temperature <= s_temperature_result(4) ;
					roic_reg_in_a <= roic_reg_in_ad(4) ;
					roic_reg_in_b <= roic_reg_in_bd(4) ;
				elsif sel_roic_reg=6 then 
					roic_temperature <= s_temperature_result(5) ;
					roic_reg_in_a <= roic_reg_in_ad(5) ;
					roic_reg_in_b <= roic_reg_in_bd(5) ;
				elsif sel_roic_reg=7 then 
					roic_temperature <= s_temperature_result(6) ;
					roic_reg_in_a <= roic_reg_in_ad(6) ;
					roic_reg_in_b <= roic_reg_in_bd(6) ;
				elsif sel_roic_reg=8 then 
					roic_temperature <= s_temperature_result(7) ;
					roic_reg_in_a <= roic_reg_in_ad(7) ;
					roic_reg_in_b <= roic_reg_in_bd(7) ;
				elsif sel_roic_reg=9 then 
					roic_temperature <= s_temperature_result(8) ;
					roic_reg_in_a <= roic_reg_in_ad(8) ;
					roic_reg_in_b <= roic_reg_in_bd(8) ;
				elsif sel_roic_reg=10 then 
					roic_temperature <= s_temperature_result(9) ;
					roic_reg_in_a <= roic_reg_in_ad(9);
					roic_reg_in_b <= roic_reg_in_bd(9);
				elsif sel_roic_reg=11 then 
					roic_temperature <= s_temperature_result(10) ;
					roic_reg_in_a <= roic_reg_in_ad(10);
					roic_reg_in_b <= roic_reg_in_bd(10);
				elsif sel_roic_reg=12 then 
					roic_temperature <= s_temperature_result(11) ;
					roic_reg_in_a <= roic_reg_in_ad(11);
					roic_reg_in_b <= roic_reg_in_bd(11);
				else
					roic_temperature <= (others=>'0');
					roic_reg_in_a <= (others=>'0');
					roic_reg_in_b <= (others=>'0');
				end if;
			end if;
		end if;
	end process;


---------------------------------------------------------------------
---------------------------------------------------------------------
	up_valid_roic_data   <= '1' when dump_roic_data_1d='1' else '0';
	down_valid_roic_data <= '1' when pre_valid_roic_data='1'  and roic_data_cnt=NUM_ROIC_DATA_PARALLEL else '0';

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			pre_valid_roic_data <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if down_valid_roic_data='1' then
				pre_valid_roic_data <= '0';
			elsif up_valid_roic_data='1' then
				pre_valid_roic_data <= '1';
			end if;
		end if;
	end process;

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			roic_data_cnt <= "0000";
		elsif sys_clk'event and sys_clk='1' then
			if pre_valid_roic_data='0' then
				roic_data_cnt <= "0000";
			else
				if roic_data_cnt=NUM_ROIC_DATA_PARALLEL then
					roic_data_cnt <= "0000";
				else
					roic_data_cnt <= roic_data_cnt + 1;
				end if;
			end if;
		end if;
	end process;



---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			buf_valid_roic_data <= '0';
		elsif sys_clk'event and sys_clk='1' then
			buf_valid_roic_data <= pre_valid_roic_data;
		end if;
	end process;


	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_roic_data <= '0';
		elsif sys_clk'event and sys_clk='1' then
			valid_roic_data <= buf_valid_roic_data;
		end if;
	end process;


	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			s_valid_roic_header_out_1d <='0';
			s_valid_roic_header_out_2d <='0';
			-- s_roic_header_en_1d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			s_valid_roic_header_out_1d <= valid_roic_header_out;
			s_valid_roic_header_out_2d <= s_valid_roic_header_out_1d;
			-- s_roic_header_en_1d <= s_roic_header_en;
		end if;
	end process;

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			s_roic_v_cnt <= (others =>'0');
		elsif sys_clk'event and sys_clk='1' then
			if FSM_read_index = '1' then
				s_roic_v_cnt <= (others => '0');
			elsif s_roic_header_en = '1' then
				s_roic_v_cnt <= s_roic_v_cnt + '1';
			end if;
		end if;
	end process;

	s_roic_header_en <= '1' when s_valid_roic_header_out_1d='0' and s_valid_roic_header_out_2d='1' else '0';

	-- s_roic_fixed_pattern <= roic_header_in_ad(0)(63 downto 56) 	when s_roic_header_en_1d='1';
	-- s_five_bit_all_low	 <= roic_header_in_ad(0)(55 downto 51) 	when s_roic_header_en_1d='1';
	-- s_factory_bit		 <= roic_header_in_ad(0)(50) 			when s_roic_header_en_1d='1';
	-- s_readout_direction	 <= roic_header_in_ad(0)(49) 			when s_roic_header_en_1d='1';
	-- s_cds_id			 <= roic_header_in_ad(0)(48) 			when s_roic_header_en_1d='1';
	-- s_16bit_all_low		 <= roic_header_in_ad(0)(47 downto 32) 	when s_roic_header_en_1d='1';
	-- s_temperature_result <= roic_header_in_ad(0)(31 downto 16) 	when s_roic_header_en_1d='1';
	-- s_vt_result			 <= roic_header_in_ad(0)(15 downto 0) 	when s_roic_header_en_1d='1';


	-- --  debug ila
	-- ila_roic_latch : ila_data_latch
	-- port map (
	-- 	-- clk		=>	dphy_clk_200M,
	-- 	clk		=>	sys_clk,
	-- 	probe0	=>	valid_roic_header_out,
	-- 	probe1	=>	s_roic_fixed_pattern,
	-- 	probe2	=>	s_five_bit_all_low,
	-- 	probe3	=>	s_factory_bit,
	-- 	probe4	=>	s_readout_direction,
	-- 	probe5	=>	s_cds_id,
	-- 	probe6	=>	s_16bit_all_low,
	-- 	probe7	=>	s_temperature_result,
	-- 	probe8	=>	s_vt_result
	-- 	);

	-- -- --  debug ila
	-- ila_lvds_latch : ila_lvds
	-- port map (
	-- 	-- clk		=>	dphy_clk_200M,
	-- 	clk		=>	sys_clk,
	-- 	probe0	=>	buf_data_a(0)(0),
	-- 	probe1	=>	s_dly_data_a(0),
	-- 	probe2	=>	s_dly_data_b(0),
	-- 	probe3	=>	s_douta(0),
	-- 	probe4	=>	s_doutb(0),
	-- 	probe5	=>	LD_IO_DELAY_TAB,
	-- 	probe6	=>	s_delay_tap
	-- 	);

end Behavioral;
