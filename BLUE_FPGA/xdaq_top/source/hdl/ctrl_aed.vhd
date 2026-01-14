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


entity ctrl_aed is
	port(
		sys_clk                      : in std_logic;
		drv_rst                      : in std_logic;

		cmd_get_bright               : in std_logic;

		FSM_aed_read_index           : in std_logic;

		aed_ready_done               : in std_logic;
		aed_ready_done_dark			  : in std_logic; -- 2021.05.21 ver29

		valid_posi_flag              : in std_logic;
		valid_nega_flag              : in std_logic;

		row_cnt                      : in std_logic_vector(15 downto 0);

		col_end                      : in std_logic;
		row_end                      : in std_logic;
		
		aed_read_image_height        : in std_logic_vector(15 downto 0);
		dsp_image_height             : in std_logic_vector(15 downto 0);

		aed_th                       : in std_logic_vector(15 downto 0);
		nega_aed_th                  : in std_logic_vector(15 downto 0);
		posi_aed_th                  : in std_logic_vector(15 downto 0);
		sel_aed_roic                 : in std_logic_vector(15 downto 0);
		num_trigger                  : in std_logic_vector(15 downto 0);
		sel_aed_test_roic            : in std_logic_vector(15 downto 0);

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

		valid_aed_test_data          : out std_logic;
		trigger_data_1               : out std_logic_vector(15 downto 0);
		trigger_data_2               : out std_logic_vector(15 downto 0);
		trigger_data_3               : out std_logic_vector(15 downto 0);

		chk_reg_0							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_1							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_2							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_3							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_4							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_5							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_6							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_7							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_8							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_9							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_A							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_B							: out std_logic_vector(31 downto 0); -- just for check, 191125, kkh
		chk_reg_C							: out std_logic_vector(15 downto 0); -- just for check, 191125, kkh
		chk_reg_D							: out std_logic_vector(15 downto 0); -- just for check, 191125, kkh
		chk_reg_E							: out std_logic_vector(15 downto 0); -- just for check, 191125, kkh
		chk_reg_F							: out std_logic_vector(15 downto 0); -- just for check, 191125, kkh

		disable_aed_read_xao         : out std_logic;
		on_aed_dark_trigger			  : out std_logic; -- 2021.05.24 ver38
		on_aed_trigger               : out std_logic
		);
	
end ctrl_aed;


architecture Behavioral of ctrl_aed is

	-- CONSTANT STOP_SUM : std_logic_vector(3 DOWNTO 0) :="0011";
	CONSTANT STOP_SUM : std_logic_vector(4 DOWNTO 0) :="11111";

	signal aed_drv_rst : std_logic :='0';

	signal trigger_judge_line : std_logic :='0';
 
	signal col_end_1d : std_logic :='0';
	signal col_end_2d : std_logic :='0';
	signal col_end_sys : std_logic :='0';
	
	signal row_end_1d : std_logic :='0';
	signal row_end_2d : std_logic :='0';
	signal row_end_sys : std_logic :='0';

	signal valid_aed_read : std_logic :='0';
	
	signal inc_roic_burst_cnt : std_logic :='0';
	signal rst_roic_burst_cnt : std_logic :='0';
	-- signal roic_burst_cnt : std_logic_vector(3 downto 0) :="0000";
	signal roic_burst_cnt : std_logic_vector(4 downto 0) :="00000";

	signal valid_roic_data_1d : std_logic :='0';
	signal valid_roic_data_2d : std_logic :='0';

	signal invalid_sum : std_logic :='0';
	signal hi_invalid_sum : std_logic :='0';
	signal lo_invalid_sum : std_logic :='0';

	signal end_sum : std_logic :='0';
	signal end_sum_1d : std_logic :='0';
	signal end_sum_2d : std_logic :='0';
	signal end_sum_3d : std_logic :='0';
	signal end_sum_4d : std_logic :='0';
	signal end_sum_5d : std_logic :='0';
	signal end_sum_6d : std_logic :='0';
	
	signal s_divid_data 	: std_logic_vector(3 downto 0) := "0000";

	signal divid_data : std_logic :='0';
	signal judge_xray_shot_step1 : std_logic :='0'; 
	signal judge_xray_shot_step2 : std_logic :='0'; 

	signal cal_nega_posi_th : std_logic :='0'; 
	signal judge_dump_data_step1 : std_logic :='0'; 
	signal judge_dump_data_step2 : std_logic :='0'; 

	signal dump_data : std_logic :='0';
	signal rst_buf : std_logic :='0';


	signal valid_roic_data_1  : std_logic :='0';
	signal valid_roic_data_2  : std_logic :='0';
	signal valid_roic_data_3  : std_logic :='0';
	signal valid_roic_data_4  : std_logic :='0';
	signal valid_roic_data_5  : std_logic :='0';
	signal valid_roic_data_6  : std_logic :='0';
	signal valid_roic_data_7  : std_logic :='0';
	signal valid_roic_data_8  : std_logic :='0';
	signal valid_roic_data_9  : std_logic :='0';
	signal valid_roic_data_10 : std_logic :='0';
	signal valid_roic_data_11 : std_logic :='0';
	signal valid_roic_data_12 : std_logic :='0';

	signal sum_buf_1  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_2  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_3  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_4  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_5  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_6  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_7  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_8  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_9  : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_10 : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_11 : std_logic_vector(23 downto 0) :=(others=>'0');
	signal sum_buf_12 : std_logic_vector(23 downto 0) :=(others=>'0');

	signal div_buf_1  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_2  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_3  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_4  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_5  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_6  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_7  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_8  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_9  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_10 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_11 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal div_buf_12 : std_logic_vector(15 downto 0) :=(others=>'0');

	signal pre_trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'1');
	signal pre_trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'1');

	signal trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'1');

	signal trigger_th_2_1					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_2					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_3					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_4					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_5					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_6					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_7					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_8					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_9					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_10					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_11					: std_logic_vector(15 downto 0) :=(others=>'1');
	signal trigger_th_2_12					: std_logic_vector(15 downto 0) :=(others=>'1');

	signal judge_trigger_step1 : std_logic :='0';
	signal judge_trigger_step2 : std_logic :='0';

	signal on_trigger_1  : std_logic :='0';
	signal on_trigger_2  : std_logic :='0';
	signal on_trigger_3  : std_logic :='0';
	signal on_trigger_4  : std_logic :='0';
	signal on_trigger_5  : std_logic :='0';
	signal on_trigger_6  : std_logic :='0';
	signal on_trigger_7  : std_logic :='0';
	signal on_trigger_8  : std_logic :='0';
	signal on_trigger_9  : std_logic :='0';
	signal on_trigger_10 : std_logic :='0';
	signal on_trigger_11 : std_logic :='0';
	signal on_trigger_12 : std_logic :='0';

	signal tmp_on_trigger_1  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_3  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_4  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_5  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_6  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_7  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_8  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_9  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_10 : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_11 : std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_12 : std_logic_vector(3 downto 0) :="0000";

	signal num_on_trigger : std_logic_vector(3 downto 0) :=(others=>'0');

	signal nega_trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal nega_trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'0');

	signal posi_trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal posi_trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'0');

	signal nega_flag_1  : std_logic :='0';
	signal nega_flag_2  : std_logic :='0';
	signal nega_flag_3  : std_logic :='0';
	signal nega_flag_4  : std_logic :='0';
	signal nega_flag_5  : std_logic :='0';
	signal nega_flag_6  : std_logic :='0';
	signal nega_flag_7  : std_logic :='0';
	signal nega_flag_8  : std_logic :='0';
	signal nega_flag_9  : std_logic :='0';
	signal nega_flag_10 : std_logic :='0';
	signal nega_flag_11 : std_logic :='0';
	signal nega_flag_12 : std_logic :='0';

	signal posi_flag_1  : std_logic :='0';
	signal posi_flag_2  : std_logic :='0';
	signal posi_flag_3  : std_logic :='0';
	signal posi_flag_4  : std_logic :='0';
	signal posi_flag_5  : std_logic :='0';
	signal posi_flag_6  : std_logic :='0';
	signal posi_flag_7  : std_logic :='0';
	signal posi_flag_8  : std_logic :='0';
	signal posi_flag_9  : std_logic :='0';
	signal posi_flag_10 : std_logic :='0';
	signal posi_flag_11 : std_logic :='0';
	signal posi_flag_12 : std_logic :='0';

	signal on_trigger_step1 : std_logic :='0';
	signal on_trigger : std_logic :='0';

	signal tmp_posi_flag_1  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_2  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_3  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_4  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_5  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_6  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_7  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_8  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_9  : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_10 : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_11 : std_logic_vector(3 downto 0) :="0000";
	signal tmp_posi_flag_12 : std_logic_vector(3 downto 0) :="0000";

	signal num_posi_flag : std_logic_vector(3 downto 0) :="0000";

	signal posi_flag : std_logic :='0';

	signal on_trigger_2_1					: std_logic :='0';
	signal on_trigger_2_2					: std_logic :='0';
	signal on_trigger_2_3					: std_logic :='0';
	signal on_trigger_2_4					: std_logic :='0';
	signal on_trigger_2_5					: std_logic :='0';
	signal on_trigger_2_6					: std_logic :='0';
	signal on_trigger_2_7					: std_logic :='0';
	signal on_trigger_2_8					: std_logic :='0';
	signal on_trigger_2_9					: std_logic :='0';
	signal on_trigger_2_10					: std_logic :='0';
	signal on_trigger_2_11					: std_logic :='0';
	signal on_trigger_2_12					: std_logic :='0';

	signal tmp_on_trigger_2_1				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_2				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_3				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_4				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_5				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_6				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_7				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_8				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_9				: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_10			: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_11			: std_logic_vector(3 downto 0) :="0000";
	signal tmp_on_trigger_2_12			: std_logic_vector(3 downto 0) :="0000";

	signal num_on_trigger_2				: std_logic_vector(3 downto 0) :=(others=>'0');
	


	signal FSM_aed_read_index_1d : std_logic :='0';
	signal FSM_aed_read_index_2d : std_logic :='0';

	signal start_aed_test_mode1 : std_logic :='0';
	signal end_aed_test_mode1 : std_logic :='0';
	signal valid_aed_test_mode1 : std_logic :='0';

	signal mode1_line_cnt : std_logic_vector(15 downto 0) :="0000000000000001";
	signal mode2_line_cnt : std_logic_vector(15 downto 0) :="0000000000000001";
	signal tmp_aed_line_cnt : std_logic_vector(15 downto 0) :=(others=>'0');
	signal aed_line_cnt : std_logic_vector(15 downto 0) :=(others=>'0');

	signal valid_aed_test_mode2 : std_logic :='0';
	
	signal buf1_trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf1_trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'0');

	signal buf2_trigger_th_1  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_2  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_3  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_4  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_5  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_6  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_7  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_8  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_9  : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_10 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_11 : std_logic_vector(15 downto 0) :=(others=>'0');
	signal buf2_trigger_th_12 : std_logic_vector(15 downto 0) :=(others=>'0');

	signal sig_on_aed_dark_trigger : std_logic; -- 2021.05.24 ver38
	signal judge_dark_trigger_step1 : std_logic; -- 2021.05.24 ver39
	signal dark_flag						: std_logic; -- 2021.05.24 ver41

	signal s_cmd_get_bright					: std_logic;

    attribute MARK_DEBUG : string;
    -- Marks an internal wire for debug in Vivado hardware manager 

	-- attribute MARK_DEBUG of judge_trigger_step1 : signal is "TRUE";
    -- attribute MARK_DEBUG of judge_trigger_step2 : signal is "TRUE";
	-- attribute MARK_DEBUG of col_end_sys : signal is "TRUE";
    -- attribute MARK_DEBUG of on_trigger_step1 : signal is "TRUE";

    -- attribute MARK_DEBUG of on_trigger : signal is "TRUE";
    -- attribute MARK_DEBUG of aed_ready_done : signal is "TRUE";
    -- attribute MARK_DEBUG of posi_flag : signal is "TRUE";
    -- attribute MARK_DEBUG of nega_flag_all : signal is "TRUE";


begin



	aed_drv_rst <= drv_rst and FSM_aed_read_index;



	--trigger_judge_line <= '1' when row_cnt=aed_read_image_height and FSM_aed_read_index='1' and valid_aed_read='1' else '0';
	trigger_judge_line <= '1' when row_cnt=aed_read_image_height and FSM_aed_read_index='1' else '0';


	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			col_end_1d <= '0';
			col_end_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			col_end_1d <= col_end and trigger_judge_line;
			col_end_2d <= col_end_1d;
		end if;
	end process;

	col_end_sys <= not col_end_1d and col_end_2d;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			row_end_1d <= '0';
			row_end_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			row_end_1d <= row_end and FSM_aed_read_index;
			row_end_2d <= row_end_1d;
		end if;
	end process;

	row_end_sys <= not row_end_1d and row_end_2d;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			valid_aed_read <='0';
		elsif sys_clk'event and sys_clk='1' then
			if FSM_aed_read_index='0' then
				valid_aed_read <= '0';
			else
				if row_end_sys='1' then
--					if judge_trigger_step1='1' or judge_trigger_step2='1' then
--					if aed_ready_done='1' then -- 190826, kkh, for collimation
					if aed_ready_done='1' or aed_ready_done_dark='1' then -- 2021.05.21 ver29, ver39
						valid_aed_read <= '1';
					else
						valid_aed_read <= not valid_aed_read;
					end if;
				end if;
			end if;
		end if;
	end process;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			valid_roic_data_1d <= '0';
			valid_roic_data_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			valid_roic_data_1d <= valid_roic_data and valid_aed_read;
			valid_roic_data_2d <= valid_roic_data_1d;
		end if;
	end process;

	inc_roic_burst_cnt <= not valid_roic_data_1d and valid_roic_data_2d;
	rst_roic_burst_cnt <= inc_roic_burst_cnt when roic_burst_cnt=STOP_SUM else '0';

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			roic_burst_cnt <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if invalid_sum='1' or on_trigger='1' then
				roic_burst_cnt <= (others=>'0');
			else
				if rst_roic_burst_cnt='1' then
					roic_burst_cnt <= (others=>'0');
				elsif inc_roic_burst_cnt='1' then
					roic_burst_cnt <= roic_burst_cnt + 1;
				end if;
			end if;
		end if;
	end process;

	hi_invalid_sum <= rst_roic_burst_cnt;
	lo_invalid_sum <= col_end;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			invalid_sum <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' then
				invalid_sum <= '0';
			elsif lo_invalid_sum='1' then
				invalid_sum <= '0';
			elsif hi_invalid_sum='1' then
				invalid_sum <= '1';
			end if;
		end if;
	end process;

	-- When the AED mode starts, cpu sets the value to 'd4095.
	
	valid_roic_data_1  <= sel_aed_roic(0)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_2  <= sel_aed_roic(1)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_3  <= sel_aed_roic(2)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_4  <= sel_aed_roic(3)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_5  <= sel_aed_roic(4)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_6  <= sel_aed_roic(5)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_7  <= sel_aed_roic(6)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_8  <= sel_aed_roic(7)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_9  <= sel_aed_roic(8)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_10 <= sel_aed_roic(9)  and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_11 <= sel_aed_roic(10) and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;
	valid_roic_data_12 <= sel_aed_roic(11) and valid_roic_data and FSM_aed_read_index and valid_aed_read and not invalid_sum;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			end_sum   <= '0';
			end_sum_1d <= '0';
			end_sum_2d <= '0';
			end_sum_3d <= '0';
			end_sum_4d <= '0';
			end_sum_5d <= '0';
			end_sum_6d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			end_sum    <= rst_roic_burst_cnt and trigger_judge_line;
			end_sum_1d <= end_sum;
			end_sum_2d <= end_sum_1d;
			end_sum_3d <= end_sum_2d;
			end_sum_4d <= end_sum_3d;
			end_sum_5d <= end_sum_4d;
			end_sum_6d <= end_sum_5d;
		end if;
	end process;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			s_divid_data <= "0000";
		elsif sys_clk'event and sys_clk='1' then
			s_divid_data(0) <= end_sum;
			s_divid_data(3 downto 1) <= s_divid_data(2 downto 0);
		end if;
	end process;

	divid_data            <= end_sum;
	judge_xray_shot_step1 <= end_sum_1d;
	judge_xray_shot_step2 <= end_sum_3d;
	
	
	cal_nega_posi_th      <= end_sum;
	judge_dump_data_step1 <= end_sum_1d;
	judge_dump_data_step2 <= end_sum_3d;


	dump_data             <= end_sum_5d;
	rst_buf               <= end_sum_6d;

------------------------------------------------------------------------------------
--------------------------------- judge Trigger ------------------------------------
------------------------------------------------------------------------------------

--------------------------- image data Sum & Averaging -----------------------------
------------------------------------------------------------------------------------

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			sum_buf_1  <= (others=>'0');
			sum_buf_2  <= (others=>'0');
			sum_buf_3  <= (others=>'0');
			sum_buf_4  <= (others=>'0');
			sum_buf_5  <= (others=>'0');
			sum_buf_6  <= (others=>'0');
			sum_buf_7  <= (others=>'0');
			sum_buf_8  <= (others=>'0');
			sum_buf_9  <= (others=>'0');
			sum_buf_10 <= (others=>'0');
			sum_buf_11 <= (others=>'0');
			sum_buf_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if rst_buf='1' then
				sum_buf_1 <= (others=>'0');
			elsif valid_roic_data_1='1' then
				sum_buf_1 <= sum_buf_1 + roic_data_in_1(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_2 <= (others=>'0');
			elsif valid_roic_data_2='1' then
				sum_buf_2 <= sum_buf_2 + roic_data_in_2(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_3 <= (others=>'0');
			elsif valid_roic_data_3='1' then
				sum_buf_3 <= sum_buf_3 + roic_data_in_3(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_4 <= (others=>'0');
			elsif valid_roic_data_4='1' then
				sum_buf_4 <= sum_buf_4 + roic_data_in_4(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_5 <= (others=>'0');
			elsif valid_roic_data_5='1' then
				sum_buf_5 <= sum_buf_5 + roic_data_in_5(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_6 <= (others=>'0');
			elsif valid_roic_data_6='1' then
				sum_buf_6 <= sum_buf_6 + roic_data_in_6(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_7 <= (others=>'0');
			elsif valid_roic_data_7='1' then
				sum_buf_7 <= sum_buf_7 + roic_data_in_7(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_8 <= (others=>'0');
			elsif valid_roic_data_8='1' then
				sum_buf_8 <= sum_buf_8 + roic_data_in_8(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_9 <= (others=>'0');
			elsif valid_roic_data_9='1' then
				sum_buf_9 <= sum_buf_9 + roic_data_in_9(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_10 <= (others=>'0');
			elsif valid_roic_data_10='1' then
				sum_buf_10 <= sum_buf_10 + roic_data_in_10(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_11 <= (others=>'0');
			elsif valid_roic_data_11='1' then
				sum_buf_11 <= sum_buf_11 + roic_data_in_11(31 downto 16);
			end if;
			if rst_buf='1' then
				sum_buf_12 <= (others=>'0');
			elsif valid_roic_data_12='1' then
				sum_buf_12 <= sum_buf_12 + roic_data_in_12(31 downto 16);
			end if;
		end if;
	end process;
			


	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			div_buf_1  <= (others=>'0');
			div_buf_2  <= (others=>'0');
			div_buf_3  <= (others=>'0');
			div_buf_4  <= (others=>'0');
			div_buf_5  <= (others=>'0');
			div_buf_6  <= (others=>'0');
			div_buf_7  <= (others=>'0');
			div_buf_8  <= (others=>'0');
			div_buf_9  <= (others=>'0');
			div_buf_10 <= (others=>'0');
			div_buf_11 <= (others=>'0');
			div_buf_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if rst_buf='1' then
				div_buf_1  <= (others=>'0');
				div_buf_2  <= (others=>'0');
				div_buf_3  <= (others=>'0');
				div_buf_4  <= (others=>'0');
				div_buf_5  <= (others=>'0');
				div_buf_6  <= (others=>'0');
				div_buf_7  <= (others=>'0');
				div_buf_8  <= (others=>'0');
				div_buf_9  <= (others=>'0');
				div_buf_10 <= (others=>'0');
				div_buf_11 <= (others=>'0');
				div_buf_12 <= (others=>'0');
			elsif divid_data='1' then
				div_buf_1  <= sum_buf_1(23 downto 8);
				div_buf_2  <= sum_buf_2(23 downto 8);
				div_buf_3  <= sum_buf_3(23 downto 8);
				div_buf_4  <= sum_buf_4(23 downto 8);
				div_buf_5  <= sum_buf_5(23 downto 8);
				div_buf_6  <= sum_buf_6(23 downto 8);
				div_buf_7  <= sum_buf_7(23 downto 8);
				div_buf_8  <= sum_buf_8(23 downto 8);
				div_buf_9  <= sum_buf_9(23 downto 8);
				div_buf_10 <= sum_buf_10(23 downto 8);
				div_buf_11 <= sum_buf_11(23 downto 8);
				div_buf_12 <= sum_buf_12(23 downto 8);
			end if;
		end if;
	end process;








------------------------- calibration current trigger th ---------------------------
------------------------------------------------------------------------------------

	---------- generation trigger th -----------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			trigger_th_1  <= (others=>'1');
			trigger_th_2  <= (others=>'1');
			trigger_th_3  <= (others=>'1');
			trigger_th_4  <= (others=>'1');
			trigger_th_5  <= (others=>'1');
			trigger_th_6  <= (others=>'1');
			trigger_th_7  <= (others=>'1');
			trigger_th_8  <= (others=>'1');
			trigger_th_9  <= (others=>'1');
			trigger_th_10 <= (others=>'1');
			trigger_th_11 <= (others=>'1');
			trigger_th_12 <= (others=>'1');
		elsif sys_clk'event and sys_clk='1' then
			if rst_buf='1' then
				trigger_th_1  <= (others=>'1');
				trigger_th_2  <= (others=>'1');
				trigger_th_3  <= (others=>'1');
				trigger_th_4  <= (others=>'1');
				trigger_th_5  <= (others=>'1');
				trigger_th_6  <= (others=>'1');
				trigger_th_7  <= (others=>'1');
				trigger_th_8  <= (others=>'1');
				trigger_th_9  <= (others=>'1');
				trigger_th_10 <= (others=>'1');
				trigger_th_11 <= (others=>'1');
				trigger_th_12 <= (others=>'1');
			elsif divid_data='1' then
				trigger_th_1  <= pre_trigger_th_1  + aed_th;
				trigger_th_2  <= pre_trigger_th_2  + aed_th;
				trigger_th_3  <= pre_trigger_th_3  + aed_th;
				trigger_th_4  <= pre_trigger_th_4  + aed_th;
				trigger_th_5  <= pre_trigger_th_5  + aed_th;
				trigger_th_6  <= pre_trigger_th_6  + aed_th;
				trigger_th_7  <= pre_trigger_th_7  + aed_th;
				trigger_th_8  <= pre_trigger_th_8  + aed_th;
				trigger_th_9  <= pre_trigger_th_9  + aed_th;
				trigger_th_10 <= pre_trigger_th_10 + aed_th;
				trigger_th_11 <= pre_trigger_th_11 + aed_th;
				trigger_th_12 <= pre_trigger_th_12 + aed_th;
			end if;
		end if;
	end process;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			trigger_th_2_1	<= (others=>'1');
			trigger_th_2_2	<= (others=>'1');
			trigger_th_2_3	<= (others=>'1');
			trigger_th_2_4	<= (others=>'1');
			trigger_th_2_5	<= (others=>'1');
			trigger_th_2_6	<= (others=>'1');
			trigger_th_2_7	<= (others=>'1');
			trigger_th_2_8	<= (others=>'1');
			trigger_th_2_9	<= (others=>'1');
			trigger_th_2_10	<= (others=>'1');
			trigger_th_2_11	<= (others=>'1');
			trigger_th_2_12	<= (others=>'1');
		elsif sys_clk'event and sys_clk='1' then
			if rst_buf='1' then
				trigger_th_2_1		<= (others=>'1');
				trigger_th_2_2		<= (others=>'1');
				trigger_th_2_3		<= (others=>'1');
				trigger_th_2_4		<= (others=>'1');
				trigger_th_2_5		<= (others=>'1');
				trigger_th_2_6		<= (others=>'1');
				trigger_th_2_7		<= (others=>'1');
				trigger_th_2_8		<= (others=>'1');
				trigger_th_2_9		<= (others=>'1');
				trigger_th_2_10	<= (others=>'1');
				trigger_th_2_11	<= (others=>'1');
				trigger_th_2_12	<= (others=>'1');
			elsif divid_data='1' then
--			if divid_data='1' then
				-- "0000000001001111"; -- 79
				-- "0000000001010011"; -- 83
				-- "0000000001011001"; -- 89
				-- "0000000001011011"; -- 91
				-- "0000000001011101"; -- 93
				trigger_th_2_1		<= pre_trigger_th_1  - "0000000001011011";
				trigger_th_2_2		<= pre_trigger_th_2  - "0000000001011011";
				trigger_th_2_3		<= pre_trigger_th_3  - "0000000001011011";
				trigger_th_2_4		<= pre_trigger_th_4  - "0000000001011011";
				trigger_th_2_5		<= pre_trigger_th_5  - "0000000001011011";
				trigger_th_2_6		<= pre_trigger_th_6  - "0000000001011011";
				trigger_th_2_7		<= pre_trigger_th_7  - "0000000001011011";
				trigger_th_2_8		<= pre_trigger_th_8  - "0000000001011011";
				trigger_th_2_9		<= pre_trigger_th_9  - "0000000001011011";
				trigger_th_2_10	<= pre_trigger_th_10 - "0000000001011011";
				trigger_th_2_11	<= pre_trigger_th_11 - "0000000001011011";
				trigger_th_2_12	<= pre_trigger_th_12 - "0000000001011011";
			end if;
		end if;
	end process;







	-------- generation posi & nega th ---------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			posi_trigger_th_1  <= (others=>'0');
			posi_trigger_th_2  <= (others=>'0');
			posi_trigger_th_3  <= (others=>'0');
			posi_trigger_th_4  <= (others=>'0');
			posi_trigger_th_5  <= (others=>'0');
			posi_trigger_th_6  <= (others=>'0');
			posi_trigger_th_7  <= (others=>'0');
			posi_trigger_th_8  <= (others=>'0');
			posi_trigger_th_9  <= (others=>'0');
			posi_trigger_th_10 <= (others=>'0');
			posi_trigger_th_11 <= (others=>'0');
			posi_trigger_th_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' or valid_posi_flag='0' then
				posi_trigger_th_1  <= (others=>'0');
				posi_trigger_th_2  <= (others=>'0');
				posi_trigger_th_3  <= (others=>'0');
				posi_trigger_th_4  <= (others=>'0');
				posi_trigger_th_5  <= (others=>'0');
				posi_trigger_th_6  <= (others=>'0');
				posi_trigger_th_7  <= (others=>'0');
				posi_trigger_th_8  <= (others=>'0');
				posi_trigger_th_9  <= (others=>'0');
				posi_trigger_th_10 <= (others=>'0');
				posi_trigger_th_11 <= (others=>'0');
				posi_trigger_th_12 <= (others=>'0');
			else
				if rst_buf='1' then
					posi_trigger_th_1  <= (others=>'0');
					posi_trigger_th_2  <= (others=>'0');
					posi_trigger_th_3  <= (others=>'0');
					posi_trigger_th_4  <= (others=>'0');
					posi_trigger_th_5  <= (others=>'0');
					posi_trigger_th_6  <= (others=>'0');
					posi_trigger_th_7  <= (others=>'0');
					posi_trigger_th_8  <= (others=>'0');
					posi_trigger_th_9  <= (others=>'0');
					posi_trigger_th_10 <= (others=>'0');
					posi_trigger_th_11 <= (others=>'0');
					posi_trigger_th_12 <= (others=>'0');
				elsif cal_nega_posi_th='1' then
					posi_trigger_th_1  <= pre_trigger_th_1  + posi_aed_th;
					posi_trigger_th_2  <= pre_trigger_th_2  + posi_aed_th;
					posi_trigger_th_3  <= pre_trigger_th_3  + posi_aed_th;
					posi_trigger_th_4  <= pre_trigger_th_4  + posi_aed_th;
					posi_trigger_th_5  <= pre_trigger_th_5  + posi_aed_th;
					posi_trigger_th_6  <= pre_trigger_th_6  + posi_aed_th;
					posi_trigger_th_7  <= pre_trigger_th_7  + posi_aed_th;
					posi_trigger_th_8  <= pre_trigger_th_8  + posi_aed_th;
					posi_trigger_th_9  <= pre_trigger_th_9  + posi_aed_th;
					posi_trigger_th_10 <= pre_trigger_th_10 + posi_aed_th;
					posi_trigger_th_11 <= pre_trigger_th_11 + posi_aed_th;
					posi_trigger_th_12 <= pre_trigger_th_12 + posi_aed_th;
				end if; 
			end if;
		end if;
	end process;

				




	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			nega_trigger_th_1  <= (others=>'0');
			nega_trigger_th_2  <= (others=>'0');
			nega_trigger_th_3  <= (others=>'0');
			nega_trigger_th_4  <= (others=>'0');
			nega_trigger_th_5  <= (others=>'0');
			nega_trigger_th_6  <= (others=>'0');
			nega_trigger_th_7  <= (others=>'0');
			nega_trigger_th_8  <= (others=>'0');
			nega_trigger_th_9  <= (others=>'0');
			nega_trigger_th_10 <= (others=>'0');
			nega_trigger_th_11 <= (others=>'0');
			nega_trigger_th_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' or valid_nega_flag='0' then
				nega_trigger_th_1  <= (others=>'0');
				nega_trigger_th_2  <= (others=>'0');
				nega_trigger_th_3  <= (others=>'0');
				nega_trigger_th_4  <= (others=>'0');
				nega_trigger_th_5  <= (others=>'0');
				nega_trigger_th_6  <= (others=>'0');
				nega_trigger_th_7  <= (others=>'0');
				nega_trigger_th_8  <= (others=>'0');
				nega_trigger_th_9  <= (others=>'0');
				nega_trigger_th_10 <= (others=>'0');
				nega_trigger_th_11 <= (others=>'0');
				nega_trigger_th_12 <= (others=>'0');
			else
				if rst_buf='1' then
					nega_trigger_th_1  <= (others=>'0');
					nega_trigger_th_2  <= (others=>'0');
					nega_trigger_th_3  <= (others=>'0');
					nega_trigger_th_4  <= (others=>'0');
					nega_trigger_th_5  <= (others=>'0');
					nega_trigger_th_6  <= (others=>'0');
					nega_trigger_th_7  <= (others=>'0');
					nega_trigger_th_8  <= (others=>'0');
					nega_trigger_th_9  <= (others=>'0');
					nega_trigger_th_10 <= (others=>'0');
					nega_trigger_th_11 <= (others=>'0');
					nega_trigger_th_12 <= (others=>'0');
				elsif cal_nega_posi_th='1' then
					nega_trigger_th_1  <= pre_trigger_th_1  - nega_aed_th;
					nega_trigger_th_2  <= pre_trigger_th_2  - nega_aed_th;
					nega_trigger_th_3  <= pre_trigger_th_3  - nega_aed_th;
					nega_trigger_th_4  <= pre_trigger_th_4  - nega_aed_th;
					nega_trigger_th_5  <= pre_trigger_th_5  - nega_aed_th;
					nega_trigger_th_6  <= pre_trigger_th_6  - nega_aed_th;
					nega_trigger_th_7  <= pre_trigger_th_7  - nega_aed_th;
					nega_trigger_th_8  <= pre_trigger_th_8  - nega_aed_th;
					nega_trigger_th_9  <= pre_trigger_th_9  - nega_aed_th;
					nega_trigger_th_10 <= pre_trigger_th_10 - nega_aed_th;
					nega_trigger_th_11 <= pre_trigger_th_11 - nega_aed_th;
					nega_trigger_th_12 <= pre_trigger_th_12 - nega_aed_th;
				end if; 
			end if;
		end if;
	end process;








---------------------- generation nagative & positive flag -------------------------
------------------------------------------------------------------------------------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			nega_flag_1  <= '0';	
            nega_flag_2  <= '0';
            nega_flag_3  <= '0';
            nega_flag_4  <= '0';
            nega_flag_5  <= '0';
            nega_flag_6  <= '0';
            nega_flag_7  <= '0';
            nega_flag_8  <= '0';
            nega_flag_9  <= '0';
            nega_flag_10 <= '0';
            nega_flag_11 <= '0';
            nega_flag_12 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' or valid_nega_flag='0' then
				nega_flag_1  <= '0';	
            	nega_flag_2  <= '0';
            	nega_flag_3  <= '0';
            	nega_flag_4  <= '0';
            	nega_flag_5  <= '0';
            	nega_flag_6  <= '0';
            	nega_flag_7  <= '0';
            	nega_flag_8  <= '0';
            	nega_flag_9  <= '0';
            	nega_flag_10 <= '0';
            	nega_flag_11 <= '0';
            	nega_flag_12 <= '0';
			else
				if col_end_sys='1' then
					nega_flag_1  <= '0';	
            		nega_flag_2  <= '0';
            		nega_flag_3  <= '0';
            		nega_flag_4  <= '0';
            		nega_flag_5  <= '0';
            		nega_flag_6  <= '0';
            		nega_flag_7  <= '0';
            		nega_flag_8  <= '0';
            		nega_flag_9  <= '0';
            		nega_flag_10 <= '0';
            		nega_flag_11 <= '0';
            		nega_flag_12 <= '0';
				elsif judge_dump_data_step1='1' then
					if div_buf_1<nega_trigger_th_1 then
						nega_flag_1 <= '1';
					else
						nega_flag_1 <= '0';
					end if;
            	
					if div_buf_2<nega_trigger_th_2 then
						nega_flag_2 <= '1';
					else
						nega_flag_2 <= '0';
					end if;
            	
					if div_buf_3<nega_trigger_th_3 then
						nega_flag_3 <= '1';
					else
						nega_flag_3 <= '0';
					end if;
            	
					if div_buf_4<nega_trigger_th_4 then
						nega_flag_4 <= '1';
					else
						nega_flag_4 <= '0';
					end if;
            	
					if div_buf_5<nega_trigger_th_5 then
						nega_flag_5 <= '1';
					else
						nega_flag_5 <= '0';
					end if;
            	
					if div_buf_6<nega_trigger_th_6 then
						nega_flag_6 <= '1';
					else
						nega_flag_6 <= '0';
					end if;
            	
					if div_buf_7<nega_trigger_th_7 then
						nega_flag_7 <= '1';
					else
						nega_flag_7 <= '0';
					end if;
            	
					if div_buf_8<nega_trigger_th_8 then
						nega_flag_8 <= '1';
					else
						nega_flag_8 <= '0';
					end if;
            	
					if div_buf_9<nega_trigger_th_9 then
						nega_flag_9 <= '1';
					else
						nega_flag_9 <= '0';
					end if;
            	
					if div_buf_10<nega_trigger_th_10 then
						nega_flag_10 <= '1';
					else
						nega_flag_10 <= '0';
					end if;
            	
					if div_buf_11<nega_trigger_th_11 then
						nega_flag_11 <= '1';
					else
						nega_flag_11 <= '0';
					end if;
            	
					if div_buf_12<nega_trigger_th_12 then
						nega_flag_12 <= '1';
					else
						nega_flag_12 <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;




				



	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			posi_flag_1  <= '0';	
            posi_flag_2  <= '0';
            posi_flag_3  <= '0';
            posi_flag_4  <= '0';
            posi_flag_5  <= '0';
            posi_flag_6  <= '0';
            posi_flag_7  <= '0';
            posi_flag_8  <= '0';
            posi_flag_9  <= '0';
            posi_flag_10 <= '0';
            posi_flag_11 <= '0';
            posi_flag_12 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' or valid_posi_flag='0' then
				posi_flag_1  <= '0';	
				posi_flag_2  <= '0';
				posi_flag_3  <= '0';
				posi_flag_4  <= '0';
				posi_flag_5  <= '0';
				posi_flag_6  <= '0';
				posi_flag_7  <= '0';
				posi_flag_8  <= '0';
            	posi_flag_9  <= '0';
            	posi_flag_10 <= '0';
            	posi_flag_11 <= '0';
            	posi_flag_12 <= '0';
			else
				if col_end_sys='1' then
					posi_flag_1  <= '0';	
            		posi_flag_2  <= '0';
            		posi_flag_3  <= '0';
            		posi_flag_4  <= '0';
            		posi_flag_5  <= '0';
            		posi_flag_6  <= '0';
            		posi_flag_7  <= '0';
            		posi_flag_8  <= '0';
            		posi_flag_9  <= '0';
            		posi_flag_10 <= '0';
            		posi_flag_11 <= '0';
            		posi_flag_12 <= '0';
				elsif judge_dump_data_step1='1' then
					if div_buf_1>posi_trigger_th_1 then
						posi_flag_1 <= '1';
					else
						posi_flag_1 <= '0';
					end if;

					if div_buf_2>posi_trigger_th_2 then
						posi_flag_2 <= '1';
					else
						posi_flag_2 <= '0';
					end if;

					if div_buf_3>posi_trigger_th_3 then
						posi_flag_3 <= '1';
					else
						posi_flag_3 <= '0';
					end if;

					if div_buf_4>posi_trigger_th_4 then
						posi_flag_4 <= '1';
					else
						posi_flag_4 <= '0';
					end if;

					if div_buf_5>posi_trigger_th_5 then
						posi_flag_5 <= '1';
					else
						posi_flag_5 <= '0';
					end if;

					if div_buf_6>posi_trigger_th_6 then
						posi_flag_6 <= '1';
					else
						posi_flag_6 <= '0';
					end if;

					if div_buf_7>posi_trigger_th_7 then
						posi_flag_7 <= '1';
					else
						posi_flag_7 <= '0';
					end if;

					if div_buf_8>posi_trigger_th_8 then
						posi_flag_8 <= '1';
					else
						posi_flag_8 <= '0';
					end if;

					if div_buf_9>posi_trigger_th_9 then
						posi_flag_9 <= '1';
					else
						posi_flag_9 <= '0';
					end if;

					if div_buf_10>posi_trigger_th_10 then
						posi_flag_10 <= '1';
					else
						posi_flag_10 <= '0';
					end if;

					if div_buf_11>posi_trigger_th_11 then
						posi_flag_11 <= '1';
					else
						posi_flag_11 <= '0';
					end if;

					if div_buf_12>posi_trigger_th_12 then
						posi_flag_12 <= '1';
					else
						posi_flag_12 <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;






	tmp_posi_flag_1  <= "000"&posi_flag_1 ;
	tmp_posi_flag_2  <= "000"&posi_flag_2 ;
	tmp_posi_flag_3  <= "000"&posi_flag_3 ;
	tmp_posi_flag_4  <= "000"&posi_flag_4 ;
	tmp_posi_flag_5  <= "000"&posi_flag_5 ;
	tmp_posi_flag_6  <= "000"&posi_flag_6 ;
	tmp_posi_flag_7  <= "000"&posi_flag_7 ;
	tmp_posi_flag_8  <= "000"&posi_flag_8 ;
	tmp_posi_flag_9  <= "000"&posi_flag_9 ;
	tmp_posi_flag_10 <= "000"&posi_flag_10;
	tmp_posi_flag_11 <= "000"&posi_flag_11;
	tmp_posi_flag_12 <= "000"&posi_flag_12;


	num_posi_flag <= tmp_posi_flag_1  + tmp_posi_flag_2  + tmp_posi_flag_3  + tmp_posi_flag_4  +
				     tmp_posi_flag_5  + tmp_posi_flag_6  + tmp_posi_flag_7  + tmp_posi_flag_8  +
				     tmp_posi_flag_9  + tmp_posi_flag_10 + tmp_posi_flag_11 + tmp_posi_flag_12;	 



	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			posi_flag <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' or valid_posi_flag='0' then
				posi_flag <= '0';
			else
				if col_end_sys='1' then
					posi_flag <= '0';
				elsif judge_dump_data_step2='1' then
					if num_posi_flag > num_trigger(3 downto 0) then
						posi_flag <= '1';
					else
						posi_flag <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

				






-------------------------- Generation trigger step flags ---------------------------
------------------------------------------------------------------------------------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			judge_trigger_step1 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' or on_trigger='1' then
				judge_trigger_step1 <= '0';
			else
				if col_end_sys='1' and posi_flag='1' then
					judge_trigger_step1 <= '1';
				elsif col_end_sys='1' and judge_trigger_step1='1' then
					judge_trigger_step1 <= '0';
				end if;
			end if;
		end if;
	end process;


	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			judge_trigger_step2 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' or on_trigger='1' then
				judge_trigger_step2 <= '0';
			else
				-- if col_end_sys='1' and judge_trigger_step1='1' and on_trigger_step1='1' then
				if col_end_sys='1' and posi_flag='1' and judge_trigger_step1='1' and on_trigger_step1='1' then
					judge_trigger_step2 <= '1';
				elsif col_end_sys='1' and judge_trigger_step2='1' then
					judge_trigger_step2 <= '0';
				end if;
			end if;
		end if;
	end process;


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------ 2021.05.24 ver39


	process(sys_clk, aed_drv_rst) -- ver41
	begin
		if aed_drv_rst='0' then
			dark_flag <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if sig_on_aed_dark_trigger='1' then
				dark_flag <= '0';
			else
				if col_end_sys='1' then
					dark_flag <= '0';
				else
					if judge_dump_data_step2='1' then
						if aed_ready_done_dark='1' then
							dark_flag <= '1';
						else
							dark_flag <= '0';
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			judge_dark_trigger_step1 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done_dark='0' or sig_on_aed_dark_trigger='1' then
				judge_dark_trigger_step1 <= '0';
			else
				if col_end_sys='1' and dark_flag='1' then -- ver41
					judge_dark_trigger_step1 <= '1';
				elsif col_end_sys='1' and judge_dark_trigger_step1='1' then
					judge_dark_trigger_step1 <= '0';
				end if;
			end if;
		end if;
	end process;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			sig_on_aed_dark_trigger <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done_dark='0' then
				sig_on_aed_dark_trigger <= '0';
			else
				if row_end_sys='1' then
					sig_on_aed_dark_trigger <= '0';
				elsif judge_xray_shot_step2='1' and judge_dark_trigger_step1='1' then
					sig_on_aed_dark_trigger <= '1';
				end if;
			end if;
		end if;
	end process;
	
	on_aed_dark_trigger <= sig_on_aed_dark_trigger;


--------------------------------- judge trigger ------------------------------------
------------------------------------------------------------------------------------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			on_trigger_1  <= '0';
			on_trigger_2  <= '0';
			on_trigger_3  <= '0';
			on_trigger_4  <= '0';
			on_trigger_5  <= '0';
			on_trigger_6  <= '0';
			on_trigger_7  <= '0';
			on_trigger_8  <= '0';
			on_trigger_9  <= '0';
			on_trigger_10 <= '0';
			on_trigger_11 <= '0';
			on_trigger_12 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' or (judge_trigger_step1='0' and judge_trigger_step2='0') then
				on_trigger_1  <= '0';
				on_trigger_2  <= '0';
				on_trigger_3  <= '0';
				on_trigger_4  <= '0';
				on_trigger_5  <= '0';
				on_trigger_6  <= '0';
				on_trigger_7  <= '0';
				on_trigger_8  <= '0';
				on_trigger_9  <= '0';
				on_trigger_10 <= '0';
				on_trigger_11 <= '0';
				on_trigger_12 <= '0';
			else
				if col_end_sys='1' then
					on_trigger_1  <= '0';
					on_trigger_2  <= '0';
					on_trigger_3  <= '0';
					on_trigger_4  <= '0';
					on_trigger_5  <= '0';
					on_trigger_6  <= '0';
					on_trigger_7  <= '0';
					on_trigger_8  <= '0';
					on_trigger_9  <= '0';
					on_trigger_10 <= '0';
					on_trigger_11 <= '0';
					on_trigger_12 <= '0';
				elsif judge_xray_shot_step1='1' then
					if div_buf_1 > trigger_th_1 then
						on_trigger_1 <= '1';
					else
						on_trigger_1 <= '0';
					end if;
					if div_buf_2 > trigger_th_2 then
						on_trigger_2 <= '1';
					else
						on_trigger_2 <= '0';
					end if;
					if div_buf_3 > trigger_th_3 then
						on_trigger_3 <= '1';
					else
						on_trigger_3 <= '0';
					end if;
					if div_buf_4 > trigger_th_4 then
						on_trigger_4 <= '1';
					else
						on_trigger_4 <= '0';
					end if;
					if div_buf_5 > trigger_th_5 then
						on_trigger_5 <= '1';
					else
						on_trigger_5 <= '0';
					end if;
					if div_buf_6 > trigger_th_6 then
						on_trigger_6 <= '1';
					else
						on_trigger_6 <= '0';
					end if;
					if div_buf_7 > trigger_th_7 then
						on_trigger_7 <= '1';
					else
						on_trigger_7 <= '0';
					end if;
					if div_buf_8 > trigger_th_8 then
						on_trigger_8 <= '1';
					else
						on_trigger_8 <= '0';
					end if;
					if div_buf_9 > trigger_th_9 then
						on_trigger_9 <= '1';
					else
						on_trigger_9 <= '0';
					end if;
					if div_buf_10 > trigger_th_10 then
						on_trigger_10 <= '1';
					else
						on_trigger_10 <= '0';
					end if;
					if div_buf_11 > trigger_th_11 then
						on_trigger_11 <= '1';
					else
						on_trigger_11 <= '0';
					end if;
					if div_buf_12 > trigger_th_12 then
						on_trigger_12 <= '1';
					else
						on_trigger_12 <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;






	tmp_on_trigger_1  <= "000"&on_trigger_1 ;
	tmp_on_trigger_2  <= "000"&on_trigger_2 ;
	tmp_on_trigger_3  <= "000"&on_trigger_3 ;
	tmp_on_trigger_4  <= "000"&on_trigger_4 ;
	tmp_on_trigger_5  <= "000"&on_trigger_5 ;
	tmp_on_trigger_6  <= "000"&on_trigger_6 ;
	tmp_on_trigger_7  <= "000"&on_trigger_7 ;
	tmp_on_trigger_8  <= "000"&on_trigger_8 ;
	tmp_on_trigger_9  <= "000"&on_trigger_9 ;
	tmp_on_trigger_10 <= "000"&on_trigger_10;
	tmp_on_trigger_11 <= "000"&on_trigger_11;
	tmp_on_trigger_12 <= "000"&on_trigger_12;

	num_on_trigger <= tmp_on_trigger_1 + tmp_on_trigger_2  + tmp_on_trigger_3  + tmp_on_trigger_4 +
				      tmp_on_trigger_5 + tmp_on_trigger_6  + tmp_on_trigger_7  + tmp_on_trigger_8 +
				      tmp_on_trigger_9 + tmp_on_trigger_10 + tmp_on_trigger_11 + tmp_on_trigger_12;



------------------------------------------------------------------------------------							
							
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			on_trigger_2_1	<= '0';
			on_trigger_2_2	<= '0';
			on_trigger_2_3	<= '0';
			on_trigger_2_4	<= '0';
			on_trigger_2_5	<= '0';
			on_trigger_2_6	<= '0';
			on_trigger_2_7	<= '0';
			on_trigger_2_8	<= '0';
			on_trigger_2_9	<= '0';
			on_trigger_2_10	<= '0';
			on_trigger_2_11	<= '0';
			on_trigger_2_12	<= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' or (judge_trigger_step1='0' and judge_trigger_step2='0') then
				on_trigger_2_1	<= '0';
				on_trigger_2_2	<= '0';
				on_trigger_2_3	<= '0';
				on_trigger_2_4	<= '0';
				on_trigger_2_5	<= '0';
				on_trigger_2_6	<= '0';
				on_trigger_2_7	<= '0';
				on_trigger_2_8	<= '0';
				on_trigger_2_9	<= '0';
				on_trigger_2_10	<= '0';
				on_trigger_2_11	<= '0';
				on_trigger_2_12	<= '0';
			else
				if col_end_sys='1' then
					on_trigger_2_1	<= '0';
					on_trigger_2_2	<= '0';
					on_trigger_2_3	<= '0';
					on_trigger_2_4	<= '0';
					on_trigger_2_5	<= '0';
					on_trigger_2_6	<= '0';
					on_trigger_2_7	<= '0';
					on_trigger_2_8	<= '0';
					on_trigger_2_9	<= '0';
					on_trigger_2_10	<= '0';
					on_trigger_2_11	<= '0';
					on_trigger_2_12	<= '0';
				elsif judge_xray_shot_step1='1' then
					if div_buf_1 > trigger_th_2_1 then
						on_trigger_2_1 <= '1';
					else
						on_trigger_2_1 <= '0';
					end if;
					if div_buf_2 > trigger_th_2_2 then
						on_trigger_2_2 <= '1';
					else
						on_trigger_2_2 <= '0';
					end if;
					if div_buf_3 > trigger_th_2_3 then
						on_trigger_2_3 <= '1';
					else
						on_trigger_2_3 <= '0';
					end if;
					if div_buf_4 > trigger_th_2_4 then
						on_trigger_2_4 <= '1';
					else
						on_trigger_2_4 <= '0';
					end if;
					if div_buf_5 > trigger_th_2_5 then
						on_trigger_2_5 <= '1';
					else
						on_trigger_2_5 <= '0';
					end if;
					if div_buf_6 > trigger_th_2_6 then
						on_trigger_2_6 <= '1';
					else
						on_trigger_2_6 <= '0';
					end if;
					if div_buf_7 > trigger_th_2_7 then
						on_trigger_2_7 <= '1';
					else
						on_trigger_2_7 <= '0';
					end if;
					if div_buf_8 > trigger_th_2_8 then
						on_trigger_2_8 <= '1';
					else
						on_trigger_2_8 <= '0';
					end if;
					if div_buf_9 > trigger_th_2_9 then
						on_trigger_2_9 <= '1';
					else
						on_trigger_2_9 <= '0';
					end if;
					if div_buf_10 > trigger_th_2_10 then
						on_trigger_2_10 <= '1';
					else
						on_trigger_2_10 <= '0';
					end if;
					if div_buf_11 > trigger_th_2_11 then
						on_trigger_2_11 <= '1';
					else
						on_trigger_2_11 <= '0';
					end if;
					if div_buf_12 > trigger_th_2_12 then
						on_trigger_2_12 <= '1';
					else
						on_trigger_2_12 <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

	tmp_on_trigger_2_1		<= "000"&on_trigger_2_1 ;
	tmp_on_trigger_2_2		<= "000"&on_trigger_2_2 ;
	tmp_on_trigger_2_3		<= "000"&on_trigger_2_3 ;
	tmp_on_trigger_2_4		<= "000"&on_trigger_2_4 ;
	tmp_on_trigger_2_5		<= "000"&on_trigger_2_5 ;
	tmp_on_trigger_2_6		<= "000"&on_trigger_2_6 ;
	tmp_on_trigger_2_7		<= "000"&on_trigger_2_7 ;
	tmp_on_trigger_2_8		<= "000"&on_trigger_2_8 ;
	tmp_on_trigger_2_9		<= "000"&on_trigger_2_9 ;
	tmp_on_trigger_2_10		<= "000"&on_trigger_2_10;
	tmp_on_trigger_2_11		<= "000"&on_trigger_2_11;
	tmp_on_trigger_2_12		<= "000"&on_trigger_2_12;

	num_on_trigger_2 <= tmp_on_trigger_2_1 + tmp_on_trigger_2_2  + tmp_on_trigger_2_3  + tmp_on_trigger_2_4 +
							tmp_on_trigger_2_5 + tmp_on_trigger_2_6  + tmp_on_trigger_2_7  + tmp_on_trigger_2_8 +
							tmp_on_trigger_2_9 + tmp_on_trigger_2_10 + tmp_on_trigger_2_11 + tmp_on_trigger_2_12;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			on_trigger_step1 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' or on_trigger='1' then
				on_trigger_step1 <= '0';
			else
				if col_end_sys='1' then
					on_trigger_step1 <= '0';
				elsif judge_xray_shot_step2='1' and judge_trigger_step1='1' then
				-- elsif judge_xray_shot_step2='1' and judge_trigger_step1='1' and posi_flag='1' then
					if num_on_trigger > num_trigger(3 downto 0) then
						on_trigger_step1 <= '1';
					else
						on_trigger_step1 <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;



	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			on_trigger <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' then
				on_trigger <= '0';
			else
				if row_end_sys='1' then
					on_trigger <= '0';
				elsif judge_xray_shot_step2='1' and judge_trigger_step2='1' then
				-- elsif judge_xray_shot_step2='1' and judge_trigger_step2='1' and posi_flag='1'  then
					if num_on_trigger_2 > num_trigger(3 downto 0) then
						on_trigger <= '1';
					else
						on_trigger <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			s_cmd_get_bright <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_ready_done='0' then
				s_cmd_get_bright <= '0';
			else
				if row_end_sys='1' then
					s_cmd_get_bright <= '0';
				elsif judge_xray_shot_step2='1' and cmd_get_bright='1' then
					s_cmd_get_bright <= '1';
				end if;
			end if;
		end if;
	end process;


	-- on_aed_trigger <= on_trigger;
	on_aed_trigger <= on_trigger or s_cmd_get_bright;


-------------------------------- Dump current th -----------------------------------
------------------------------------------------------------------------------------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			pre_trigger_th_1  <= (others=>'1');
			pre_trigger_th_2  <= (others=>'1');
			pre_trigger_th_3  <= (others=>'1');
			pre_trigger_th_4  <= (others=>'1');
			pre_trigger_th_5  <= (others=>'1');
			pre_trigger_th_6  <= (others=>'1');
			pre_trigger_th_7  <= (others=>'1');
			pre_trigger_th_8  <= (others=>'1');
			pre_trigger_th_9  <= (others=>'1');
			pre_trigger_th_10 <= (others=>'1');
			pre_trigger_th_11 <= (others=>'1');
			pre_trigger_th_12 <= (others=>'1');
		elsif sys_clk'event and sys_clk='1' then
			if on_trigger='1' then
				pre_trigger_th_1  <= (others=>'1');
				pre_trigger_th_2  <= (others=>'1');
				pre_trigger_th_3  <= (others=>'1');
				pre_trigger_th_4  <= (others=>'1');
				pre_trigger_th_5  <= (others=>'1');
				pre_trigger_th_6  <= (others=>'1');
				pre_trigger_th_7  <= (others=>'1');
				pre_trigger_th_8  <= (others=>'1');
				pre_trigger_th_9  <= (others=>'1');
				pre_trigger_th_10 <= (others=>'1');
				pre_trigger_th_11 <= (others=>'1');
				pre_trigger_th_12 <= (others=>'1');
			else
				if dump_data='1' then
					if nega_flag_1 ='0' and posi_flag_1 ='0' then 
						pre_trigger_th_1  <= div_buf_1;
					else
						pre_trigger_th_1  <= pre_trigger_th_1;	
					end if;

					if nega_flag_2 ='0' and posi_flag_2 ='0' then 
						pre_trigger_th_2  <= div_buf_2; 
					else
						pre_trigger_th_2  <= pre_trigger_th_2;	
					end if;

					if nega_flag_3 ='0' and posi_flag_3 ='0' then 
						pre_trigger_th_3  <= div_buf_3; 
					else
						pre_trigger_th_3  <= pre_trigger_th_3;	
					end if;

					if nega_flag_4 ='0' and posi_flag_4 ='0' then 
						pre_trigger_th_4  <= div_buf_4; 
					else
						pre_trigger_th_4  <= pre_trigger_th_4;	
					end if;

					if nega_flag_5 ='0' and posi_flag_5 ='0' then 
						pre_trigger_th_5  <= div_buf_5; 
					else
						pre_trigger_th_5  <= pre_trigger_th_5;	
					end if;

					if nega_flag_6 ='0' and posi_flag_6 ='0' then 
						pre_trigger_th_6  <= div_buf_6; 
					else
						pre_trigger_th_6  <= pre_trigger_th_6;	
					end if;

					if nega_flag_7 ='0' and posi_flag_7 ='0' then 
						pre_trigger_th_7  <= div_buf_7; 
					else
						pre_trigger_th_7  <= pre_trigger_th_7;	
					end if;

					if nega_flag_8 ='0' and posi_flag_8 ='0' then 
						pre_trigger_th_8  <= div_buf_8; 
					else
						pre_trigger_th_8  <= pre_trigger_th_8;	
					end if;

					if nega_flag_9 ='0' and posi_flag_9 ='0' then 
						pre_trigger_th_9  <= div_buf_9; 
					else
						pre_trigger_th_9  <= pre_trigger_th_9;	
					end if;

					if nega_flag_10='0' and posi_flag_10='0' then 
						pre_trigger_th_10 <= div_buf_10; 
					else
						pre_trigger_th_10 <= pre_trigger_th_10;	
					end if;

					if nega_flag_11='0' and posi_flag_11='0' then 
						pre_trigger_th_11 <= div_buf_11; 
					else
						pre_trigger_th_11 <= pre_trigger_th_11;	
					end if;

					if nega_flag_12='0' and posi_flag_12='0' then 
						pre_trigger_th_12 <= div_buf_12; 
					else
						pre_trigger_th_12 <= pre_trigger_th_12;	
					end if;
				end if; 
			end if;
		end if;
	end process;









------------------------------------------------------------------------------------
-------------------------- Generation disable xao signal ---------------------------
------------------------------------------------------------------------------------
--	disable_aed_read_xao <= (judge_trigger_step1 or judge_trigger_step2 or on_trigger) or not valid_aed_read;
	disable_aed_read_xao <= (judge_trigger_step1 or judge_trigger_step2 or on_trigger or judge_dark_trigger_step1 or sig_on_aed_dark_trigger) or not valid_aed_read; -- 2021.05.24 ver42




	process(sys_clk, drv_rst) begin
		if drv_rst='0' then
			chk_reg_0 <= (others=>'0');
			chk_reg_1 <= (others=>'0');
			chk_reg_2 <= (others=>'0');
			chk_reg_3 <= (others=>'0');
			chk_reg_4 <= (others=>'0');
			chk_reg_5 <= (others=>'0');
			chk_reg_6 <= (others=>'0');
			chk_reg_7 <= (others=>'0');
			chk_reg_8 <= (others=>'0');
			chk_reg_9 <= (others=>'0');
			chk_reg_A <= (others=>'0');
			chk_reg_B <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
--			if on_trigger_step1='1' then
			if s_divid_data(0)='1' then
				chk_reg_0 <= div_buf_1	& trigger_th_2_1	;
				chk_reg_1 <= div_buf_2	& trigger_th_2_2	;
				chk_reg_2 <= div_buf_3	& trigger_th_2_3	;
				chk_reg_3 <= div_buf_4	& trigger_th_2_4	;
				chk_reg_4 <= div_buf_5	& trigger_th_2_5	;
				chk_reg_5 <= div_buf_6	& trigger_th_2_6	;
				chk_reg_6 <= div_buf_7	& trigger_th_2_7	;
				chk_reg_7 <= div_buf_8	& trigger_th_2_8	;
				chk_reg_8 <= div_buf_9	& trigger_th_2_9	;
				chk_reg_9 <= div_buf_10 & trigger_th_2_10;
				chk_reg_A <= div_buf_11 & trigger_th_2_11;
				chk_reg_B <= div_buf_12 & trigger_th_2_12;
				chk_reg_E	<= "000000000000" & num_on_trigger; -- [15:0], just for check, 191125, kkh
				chk_reg_F	<= "000000000000" & num_on_trigger_2		; -- [15:0], just for check, 191125, kkh
			end if;
		end if;
	end process;

	chk_reg_C	<= "000000000000" & posi_flag & on_trigger & judge_trigger_step1 &  judge_trigger_step2; -- [15:0], just for check, 191125, kkh
	chk_reg_D	<= "000000000000" & "0000"; -- [15:0], just for check, 191125, kkh
--	chk_reg_E	<= "000000000000" & num_on_trigger; -- [15:0], just for check, 191125, kkh
--	chk_reg_F	<= "000000000000" & num_on_trigger_2		; -- [15:0], just for check, 191125, kkh



------------------------------------------------------------------------------------
---------------------------------- test aed ----------------------------------------
------------------------------------------------------------------------------------


------------------------------- aed test mode1 -------------------------------------
------------------------------------------------------------------------------------
	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			FSM_aed_read_index_1d <= '0';
			FSM_aed_read_index_2d <= '0';
		elsif sys_clk'event and sys_clk='1' then
			FSM_aed_read_index_1d <= FSM_aed_read_index;
			FSM_aed_read_index_2d <= FSM_aed_read_index_1d;
		end if;
	end process;



	start_aed_test_mode1 <= FSM_aed_read_index_1d and not FSM_aed_read_index_2d;
	end_aed_test_mode1   <= col_end_sys  when (mode1_line_cnt=dsp_image_height) and valid_aed_test_mode1='1' else '0';

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			valid_aed_test_mode1 <= '0';
		elsif sys_clk'event and sys_clk='1' then
			if aed_test_mode1='0' then
				valid_aed_test_mode1 <= '0';
			elsif aed_test_mode1='1' then
				if end_aed_test_mode1='1' then
					valid_aed_test_mode1 <= '0';
				elsif start_aed_test_mode1='1' then
					valid_aed_test_mode1 <= '1';
				end if;
			end if;
		end if;
	end process;



	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			mode1_line_cnt <= "0000000000000001";
		elsif sys_clk'event and sys_clk='1' then
			if valid_aed_test_mode1='0' then
				mode1_line_cnt <= "0000000000000001";
			elsif valid_aed_test_mode1='1' then
				if col_end_sys='1' then
					if mode1_line_cnt=dsp_image_height then
						mode1_line_cnt <= "0000000000000001";
					else
						mode1_line_cnt <= mode1_line_cnt + 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	
	

	
	







------------------------------- aed test mode2 -------------------------------------
------------------------------------------------------------------------------------
	valid_aed_test_mode2 <= FSM_aed_read_index and aed_test_mode2;

	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			mode2_line_cnt <= "0000000000000001";
		elsif sys_clk'event and sys_clk='1' then
			if valid_aed_test_mode2='0' then
				mode2_line_cnt <= "0000000000000001";
			elsif valid_aed_test_mode2='1' then
				if col_end_sys='1' then
					if mode2_line_cnt=dsp_image_height then
						mode2_line_cnt <= "0000000000000001";
					else
						mode2_line_cnt <= mode2_line_cnt + 1;
					end if;
				end if;
			end if;
		end if;
	end process;







	tmp_aed_line_cnt <= mode1_line_cnt  when aed_test_mode1='1' else 
						mode2_line_cnt  when aed_test_mode2='1' else (others=>'0');




	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			aed_line_cnt <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if col_end_sys='1' then
				aed_line_cnt <= posi_flag&judge_trigger_step1&judge_trigger_step2&on_trigger_step1&valid_aed_read&tmp_aed_line_cnt(10 downto 0);
			end if;
		end if;
	end process;


	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			buf1_trigger_th_1  <= (others=>'0');
			buf1_trigger_th_2  <= (others=>'0');
			buf1_trigger_th_3  <= (others=>'0');
			buf1_trigger_th_4  <= (others=>'0');
			buf1_trigger_th_5  <= (others=>'0');
			buf1_trigger_th_6  <= (others=>'0');
			buf1_trigger_th_7  <= (others=>'0');
			buf1_trigger_th_8  <= (others=>'0');
			buf1_trigger_th_9  <= (others=>'0');
			buf1_trigger_th_10 <= (others=>'0');
			buf1_trigger_th_11 <= (others=>'0');
			buf1_trigger_th_12 <= (others=>'0');

			buf2_trigger_th_1  <= (others=>'0');
			buf2_trigger_th_2  <= (others=>'0');
			buf2_trigger_th_3  <= (others=>'0');
			buf2_trigger_th_4  <= (others=>'0');
			buf2_trigger_th_5  <= (others=>'0');
			buf2_trigger_th_6  <= (others=>'0');
			buf2_trigger_th_7  <= (others=>'0');
			buf2_trigger_th_8  <= (others=>'0');
			buf2_trigger_th_9  <= (others=>'0');
			buf2_trigger_th_10 <= (others=>'0');
			buf2_trigger_th_11 <= (others=>'0');
			buf2_trigger_th_12 <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			if judge_xray_shot_step1='1' then
				buf1_trigger_th_1  <= trigger_th_1 ;
				buf1_trigger_th_2  <= trigger_th_2 ;
				buf1_trigger_th_3  <= trigger_th_3 ;
				buf1_trigger_th_4  <= trigger_th_4 ;
				buf1_trigger_th_5  <= trigger_th_5 ;
				buf1_trigger_th_6  <= trigger_th_6 ;
				buf1_trigger_th_7  <= trigger_th_7 ;
				buf1_trigger_th_8  <= trigger_th_8 ;
				buf1_trigger_th_9  <= trigger_th_9 ;
				buf1_trigger_th_10 <= trigger_th_10;
				buf1_trigger_th_11 <= trigger_th_11;
				buf1_trigger_th_12 <= trigger_th_12;
			           
				buf2_trigger_th_1  <= div_buf_1 ;
				buf2_trigger_th_2  <= div_buf_2 ;
				buf2_trigger_th_3  <= div_buf_3 ;
				buf2_trigger_th_4  <= div_buf_4 ;
				buf2_trigger_th_5  <= div_buf_5 ;
				buf2_trigger_th_6  <= div_buf_6 ;
				buf2_trigger_th_7  <= div_buf_7 ;
				buf2_trigger_th_8  <= div_buf_8 ;
				buf2_trigger_th_9  <= div_buf_9 ;
				buf2_trigger_th_10 <= div_buf_10;
				buf2_trigger_th_11 <= div_buf_11;
				buf2_trigger_th_12 <= div_buf_12;
			end if;
		end if;
	end process;




	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			valid_aed_test_data <= '0';
		elsif sys_clk'event and sys_clk='1' then
			valid_aed_test_data <= col_end_sys and (valid_aed_test_mode1 or valid_aed_test_mode2);
		end if;
	end process;


	process(sys_clk, aed_drv_rst)
	begin
		if aed_drv_rst='0' then
			trigger_data_1  <= (others=>'0');
			trigger_data_2  <= (others=>'0');
			trigger_data_3  <= (others=>'0');
		elsif sys_clk'event and sys_clk='1' then
			trigger_data_1  <= aed_line_cnt;

			if sel_aed_test_roic="0000000000000001" then
				trigger_data_2   <= buf1_trigger_th_1;
				trigger_data_3   <= buf2_trigger_th_1;
			elsif sel_aed_test_roic="0000000000000010" then
				trigger_data_2   <= buf1_trigger_th_2;
				trigger_data_3   <= buf2_trigger_th_2;
			elsif sel_aed_test_roic="0000000000000100" then
				trigger_data_2   <= buf1_trigger_th_3;
				trigger_data_3   <= buf2_trigger_th_3;
			elsif sel_aed_test_roic="0000000000001000" then
				trigger_data_2   <= buf1_trigger_th_4;
				trigger_data_3   <= buf2_trigger_th_4;
			elsif sel_aed_test_roic="0000000000010000" then
				trigger_data_2   <= buf1_trigger_th_5;
				trigger_data_3   <= buf2_trigger_th_5;
			elsif sel_aed_test_roic="0000000000100000" then
				trigger_data_2   <= buf1_trigger_th_6;
				trigger_data_3   <= buf2_trigger_th_6;
			elsif sel_aed_test_roic="0000000001000000" then
				trigger_data_2   <= buf1_trigger_th_7;
				trigger_data_3   <= buf2_trigger_th_7;
			elsif sel_aed_test_roic="0000000010000000" then
				trigger_data_2   <= buf1_trigger_th_8;
				trigger_data_3   <= buf2_trigger_th_8;
			elsif sel_aed_test_roic="0000000100000000" then
				trigger_data_2   <= buf1_trigger_th_9;
				trigger_data_3   <= buf2_trigger_th_9;
			elsif sel_aed_test_roic="0000001000000000" then
				trigger_data_2   <= buf1_trigger_th_10;
				trigger_data_3   <= buf2_trigger_th_10;
			elsif sel_aed_test_roic="0000010000000000" then
				trigger_data_2   <= buf1_trigger_th_11;
				trigger_data_3   <= buf2_trigger_th_11;
			elsif sel_aed_test_roic="0000100000000000" then
				trigger_data_2   <= buf1_trigger_th_12;
				trigger_data_3   <= buf2_trigger_th_12;
			end if;
		end if;
	end process;
	




end Behavioral;
