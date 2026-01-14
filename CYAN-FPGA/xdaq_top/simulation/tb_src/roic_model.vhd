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

use IEEE.NUMERIC_STD.ALL;


entity roic_model is
port(
		roic_sync          : in std_logic;
		
		roic_data_clk      : in std_logic;

		dclk               : in std_logic;

		led_4              : in std_logic;
		led_5              : in std_logic;

    	dclk_out0          : out std_logic;
    	dclk_out1          : out std_logic;
    	dclk_out2          : out std_logic;
    	dclk_out3          : out std_logic;
    	dclk_out4          : out std_logic;
    	dclk_out5          : out std_logic;
    	dclk_out6          : out std_logic;
    	dclk_out7          : out std_logic;
    	dclk_out8          : out std_logic;
    	dclk_out9          : out std_logic;
    	dclk_out10         : out std_logic;
    	dclk_out11         : out std_logic;

		douta0             : out std_logic;
		douta1             : out std_logic;
		douta2             : out std_logic;
		douta3             : out std_logic;
		douta4             : out std_logic;
		douta5             : out std_logic;
		douta6             : out std_logic;
		douta7             : out std_logic;
		douta8             : out std_logic;
		douta9             : out std_logic;
		douta10            : out std_logic;
		douta11            : out std_logic;
		                   
		doutb0             : out std_logic;
		doutb1             : out std_logic;
		doutb2             : out std_logic;
		doutb3             : out std_logic;
		doutb4             : out std_logic;
		doutb5             : out std_logic;
		doutb6             : out std_logic;
		doutb7             : out std_logic;
		doutb8             : out std_logic;
		doutb9             : out std_logic;
		doutb10            : out std_logic;
		doutb11            : out std_logic

		
	);
end roic_model;

architecture Behavioral of roic_model is

	signal clk : std_logic :='0';

	signal fsm_read_index : std_logic :='0';
	signal fsm_read_index_1d : std_logic :='0';

	signal fsm_aed_read_index : std_logic :='0';
	signal fsm_aed_read_index_1d : std_logic :='0';

	signal roic_sync_1d : std_logic :='0';

	signal inc_line_cnt : std_logic :='0';
	signal rst_line_cnt : std_logic :='0';

	signal line_cnt : std_logic_vector(15 downto 0) :=(others=>'0');

	signal burst_end : std_logic :='0';
	signal burst_end_1d : std_logic :='0';
	signal burst_end_2d : std_logic :='0';
	signal burst_end_3d : std_logic :='0';
	signal burst_end_4d : std_logic :='0';

	signal rst_d_cnt : std_logic :='0';

	signal d_cnt : std_logic_vector(15 downto 0) :=(others=>'0');

	signal burst_cnt : std_logic_vector(15 downto 0) :=(others=>'0');

	signal tmp_burst_cnt : std_logic_vector(15 downto 0) :=(others=>'0');
	signal tmp_line_cnt : std_logic_vector(15 downto 0) :=(others=>'0');

	signal tmp_seed_data : std_logic_vector(15 downto 0) :=(others=>'0');
	signal seed_data : std_logic_vector(15 downto 0) :=(others=>'0');

	signal pixel_data_tmp0 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp1 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp2 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp3 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp4 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp5 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp6 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal pixel_data_tmp7 : std_logic_vector(15 downto 0) :=(others=>'0');
	
	signal tmp_douta : std_logic_vector(63 downto 0) :=(others=>'0');
	signal tmp_doutb : std_logic_vector(63 downto 0) :=(others=>'0');

	signal douta : std_logic_vector(63 downto 0) :=(others=>'0');
	signal doutb : std_logic_vector(63 downto 0) :=(others=>'0');

	signal bump_tmp_data : std_logic :='0';
	signal bump_tmp_data_1d : std_logic :='0';
	signal bump_tmp_data_2d : std_logic :='0';


begin

	clk <= roic_data_clk;


	process(clk)
	begin
		if clk'event and clk='1' then
			fsm_read_index    <= led_5;
			fsm_read_index_1d <= fsm_read_index;

			fsm_aed_read_index    <= led_4;
			fsm_aed_read_index_1d <= fsm_aed_read_index;

			roic_sync_1d <= roic_sync;
		end if;
	end process;





	inc_line_cnt <= roic_sync and not roic_sync_1d and (fsm_read_index or fsm_aed_read_index);
	rst_line_cnt <= (not fsm_read_index and fsm_read_index_1d) or (not fsm_aed_read_index and fsm_aed_read_index_1d);

	process(clk)
	begin
		if clk'event and clk='1' then
			if rst_line_cnt='1' then
				line_cnt <= (others=>'0');
			elsif inc_line_cnt='1' then
				line_cnt <= line_cnt + 1;
			end if;
		end if;
	end process;


	burst_end <= '1' when d_cnt=63 or d_cnt=62 else '0';

	process(clk)
	begin
		if clk'event and clk='1' then
			burst_end_1d <= burst_end;
			burst_end_2d <= burst_end_1d;
			burst_end_3d <= burst_end_2d;
			burst_end_4d <= burst_end_3d;
		end if;
	end process;

	rst_d_cnt <= not burst_end_3d and burst_end_4d;



	process(dclk, rst_d_cnt)
	begin
		if rst_d_cnt='1' then
			d_cnt <= (others=>'0');
		elsif dclk'event and dclk='1' then
			d_cnt <= d_cnt + 1;
		end if;
	end process;



	process(clk)
	begin
		if clk'event and clk='1' then
			if inc_line_cnt='1' then
				burst_cnt <= (others=>'0');
			elsif rst_d_cnt='1' then
				burst_cnt <= burst_cnt + 1;
			end if;
		end if;
	end process;


	-- tmp_burst_cnt <= burst_cnt(12 downto 0)&"000";
	-- tmp_line_cnt <= line_cnt(13 downto 0)&"00" - 6;

	-- tmp_burst_cnt <= burst_cnt(11 downto 8)&burst_cnt(15 downto 12)&burst_cnt(7 downto 0);
	tmp_burst_cnt <= burst_cnt(2)&burst_cnt(0)&burst_cnt(3)&burst_cnt(1)&burst_cnt(11 downto 8)&burst_cnt(7 downto 0);
	-- tmp_line_cnt <= line_cnt(4)& line_cnt(5)&line_cnt(15 downto 6)&line_cnt(3 downto 0);
	tmp_line_cnt <= line_cnt(2)&line_cnt(0)&line_cnt(4)&line_cnt(1)& line_cnt(5)&line_cnt(12 downto 6)&line_cnt(3 downto 0);

	tmp_seed_data <= tmp_burst_cnt + tmp_line_cnt;

	seed_data <= tmp_seed_data when ((33>burst_cnt) and (burst_cnt>0)) and (line_cnt>2) else (others=>'0');

	pixel_data_tmp7 <= seed_data;
	pixel_data_tmp6 <= seed_data - 1;
	pixel_data_tmp5 <= seed_data - 2;
	pixel_data_tmp4 <= seed_data - 3;
	pixel_data_tmp3 <= seed_data - 4;
	pixel_data_tmp2 <= seed_data - 5;
	pixel_data_tmp1 <= seed_data - 6;
	pixel_data_tmp0 <= seed_data - 7;


	tmp_douta <= pixel_data_tmp0&pixel_data_tmp2&pixel_data_tmp4&pixel_data_tmp6;
	tmp_doutb <= pixel_data_tmp1&pixel_data_tmp3&pixel_data_tmp5&pixel_data_tmp7;





	process(clk)
	begin
		if clk'event and clk='1' then
			bump_tmp_data <= rst_d_cnt;
			bump_tmp_data_1d <= bump_tmp_data;
			bump_tmp_data_2d <= bump_tmp_data_1d;
		end if;
	end process;




	process(dclk, bump_tmp_data_2d)
	begin
		if bump_tmp_data_2d='1' then
			douta <= tmp_douta;
			doutb <= tmp_doutb;
		elsif dclk'event and dclk='1' then
			douta0  <= douta(63);
			douta1  <= douta(63);
			douta2  <= douta(63);
			douta3  <= douta(63);
			douta4  <= douta(63);
			douta5  <= douta(63);
			douta6  <= douta(63);
			douta7  <= douta(63);
			douta8  <= douta(63);
			douta9  <= douta(63);
			douta10 <= douta(63);
			douta11 <= douta(63);

			doutb0  <= doutb(63);
			doutb1  <= doutb(63);
			doutb2  <= doutb(63);
			doutb3  <= doutb(63);
			doutb4  <= doutb(63);
			doutb5  <= doutb(63);
			doutb6  <= doutb(63);
			doutb7  <= doutb(63);
			doutb8  <= doutb(63);
			doutb9  <= doutb(63);
			doutb10 <= doutb(63);
			doutb11 <= doutb(63);

			douta <= douta(62 downto 0)&'0'; 
			doutb <= doutb(62 downto 0)&'0'; 
		end if;
	end process;

	dclk_out0  <= dclk;
    dclk_out1  <= dclk;
    dclk_out2  <= dclk;
    dclk_out3  <= dclk;
    dclk_out4  <= dclk;
    dclk_out5  <= dclk;
    dclk_out6  <= dclk;
    dclk_out7  <= dclk;
    dclk_out8  <= dclk;
    dclk_out9  <= dclk;
    dclk_out10 <= dclk;
    dclk_out11 <= dclk;




end Behavioral;
