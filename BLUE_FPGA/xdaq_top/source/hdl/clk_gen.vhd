library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity clk_gen is
	port(
		sys_clk                      : in std_logic;

		drv_rst                      : in std_logic;

		roic_data_read_index         : in std_logic;
		valid_read_out               : in std_logic;

		col_end                      : in std_logic;

		roic_burst_cycle             : in std_logic_vector(15 downto 0); 
		start_roic_burst_clk         : in std_logic_vector(15 downto 0);
		end_roic_burst_clk           : in std_logic_vector(15 downto 0); 

		valid_roic_out               : out std_logic;
		valid_roic_burst_clk         : out std_logic;

		valid_roic_reg_out           : out std_logic;
		valid_roic_header_out           : out std_logic;

		dbg_reg							  : out std_logic_vector(31 downto 0);

		dclk                         : out std_logic 
		);
		
end clk_gen;

architecture Behavioral of clk_gen is

	CONSTANT TOTAL_NUM_ROIC_BURST    : STD_LOGIC_VECTOR(15 DOWNTO 0) :=x"0022";
	CONSTANT VALID_NUM_ROIC_BURST    : STD_LOGIC_VECTOR(15 DOWNTO 0) :=x"0021";
	CONSTANT VALID_NUM_ROIC_REG_OUT  : STD_LOGIC_VECTOR(15 DOWNTO 0) :=x"0022";
	CONSTANT VALID_NUM_ROIC_HEADER_OUT  : STD_LOGIC_VECTOR(15 DOWNTO 0) :=x"0001";

	signal roic_data_read_index_1d : std_logic :='0';
	signal roic_data_read_index_2d : std_logic :='0';

	signal hi_valid_roic_burst_out : std_logic :='0';
	signal lo_valid_roic_burst_out : std_logic :='0';
	signal valid_roic_burst_out : std_logic :='0';

	signal roic_burst_bit_cnt : std_logic_vector(15 downto 0) :=x"0001";

	signal sig_valid_roic_burst_clk : std_logic :='0';

	signal inc_roic_burst_cnt : std_logic :='0';
	signal rst_roic_burst_cnt : std_logic :='0';

	signal roic_burst_cnt : std_logic_vector(15 downto 0) :=x"0001";

	signal neg_valid_roic_burst_clk : std_logic :='0';

--	signal sig_pll1_clkout : std_logic :='0';

	signal hi_valid_image_data_out : std_logic :='0';
	signal lo_valid_image_data_out : std_logic :='0';
	signal valid_image_data_out : std_logic :='0';

	signal hi_valid_roic_data_out : std_logic :='0';
	signal lo_valid_roic_data_out : std_logic :='0';
	signal valid_roic_data_out : std_logic :='0';



	signal hi_valid_reg_data_out : std_logic :='0';
	signal lo_valid_reg_data_out : std_logic :='0';
	signal valid_reg_data_out : std_logic :='0';

	signal valid_header_data_out : std_logic :='0';

begin

	

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			roic_data_read_index_1d <= '0';
			roic_data_read_index_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			roic_data_read_index_1d <= roic_data_read_index;
			roic_data_read_index_2d <= roic_data_read_index_1d;
		end if;
	end process;

	
	hi_valid_roic_burst_out <= roic_data_read_index_1d and not roic_data_read_index_2d;
	lo_valid_roic_burst_out <= '1' when roic_data_read_index_2d='0' and roic_burst_bit_cnt=roic_burst_cycle else '0';
	
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_roic_burst_out <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if lo_valid_roic_burst_out='1' then
				valid_roic_burst_out <= '0';
			elsif hi_valid_roic_burst_out='1' then
				valid_roic_burst_out <= '1';
			end if;
		end if;
	end process;



	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			roic_burst_bit_cnt <= x"0001";
		elsif sys_clk'event and sys_clk='1' then
			if valid_roic_burst_out='0' then
				roic_burst_bit_cnt <= x"0001";
			else
				if roic_burst_bit_cnt=roic_burst_cycle then
					roic_burst_bit_cnt <= x"0001";
				else
					roic_burst_bit_cnt <= roic_burst_bit_cnt + 1;
				end if;
			end if;
		end if;
	end process;





	inc_roic_burst_cnt <= '1' when valid_roic_burst_out='1' and roic_burst_bit_cnt=roic_burst_cycle else '0';
	rst_roic_burst_cnt <= col_end;

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			roic_burst_cnt <= x"0001";
		elsif sys_clk'event and sys_clk='1' then
			if rst_roic_burst_cnt ='1' then
				roic_burst_cnt <= x"0001";
			elsif inc_roic_burst_cnt ='1' then
				roic_burst_cnt <= roic_burst_cnt + 1;
			end if;
		end if;
	end process;


	dbg_reg <= "0000000000000000" & roic_burst_cnt;


	

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			sig_valid_roic_burst_clk <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if valid_roic_burst_out='0' then
				sig_valid_roic_burst_clk <= '0';
			else
				if roic_burst_bit_cnt=end_roic_burst_clk then
					sig_valid_roic_burst_clk <= '0';
				elsif roic_burst_bit_cnt=start_roic_burst_clk then
					sig_valid_roic_burst_clk <= '1';
				end if;				
			end if;
		end if;
	end process;







---------------------------------------------------------------------
---------------------------------------------------------------------
	hi_valid_image_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=1 else '0';
	lo_valid_image_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=VALID_NUM_ROIC_BURST else '0';

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_image_data_out <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if lo_valid_image_data_out='1' then
				valid_image_data_out <= '0';
			elsif hi_valid_image_data_out='1' then
				valid_image_data_out <= '1';
			end if;
		end if;
	end process;


	

	hi_valid_roic_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=1 else '0';
	lo_valid_roic_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=TOTAL_NUM_ROIC_BURST else '0';

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_roic_data_out <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if lo_valid_roic_data_out='1' then
				valid_roic_data_out <= '0';
			elsif hi_valid_roic_data_out='1' then
				valid_roic_data_out <= '1';
			end if;
		end if;
	end process;





	hi_valid_reg_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=VALID_NUM_ROIC_BURST   else '0';
	lo_valid_reg_data_out <= '1' when inc_roic_burst_cnt='1' and roic_burst_cnt=VALID_NUM_ROIC_REG_OUT else '0';

	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_reg_data_out <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if lo_valid_reg_data_out='1' then
				valid_reg_data_out <= '0';
			elsif hi_valid_reg_data_out='1' then
				valid_reg_data_out <= '1';
			end if;
		end if;
	end process;

	valid_header_data_out <= '1' when roic_burst_cnt=VALID_NUM_ROIC_HEADER_OUT else '0';

---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			valid_roic_out       <= '0';
			valid_roic_reg_out   <= '0';
			valid_roic_header_out   <= '0';
			valid_roic_burst_clk <= '0';
		elsif sys_clk'event and sys_clk='1' then
			valid_roic_out <= valid_image_data_out and valid_read_out;
			valid_roic_reg_out <= valid_reg_data_out and valid_read_out;
			valid_roic_header_out <= valid_header_data_out and valid_read_out;
			valid_roic_burst_clk <= sig_valid_roic_burst_clk and valid_roic_data_out and valid_read_out;
		end if;
	end process;
	









---------------------------------------------------------------------
---------------------------------------------------------------------
	process(sys_clk, drv_rst)
	begin
		if drv_rst='0' then
			neg_valid_roic_burst_clk <= '0';
		elsif sys_clk'event and sys_clk='0' then
			neg_valid_roic_burst_clk <= sig_valid_roic_burst_clk;
		end if;
	end process;
	

	dclk <= sys_clk when neg_valid_roic_burst_clk='1'
					and roic_burst_cnt <= TOTAL_NUM_ROIC_BURST else '0' ;


end Behavioral;
