---------------------------------------------------------------------
-- Date					: 2024.05.19
-- Designer				: drake.lee
-- File name			: top.vhd
-- Description			: xdaq fpga top file
-- Revision History		:
--							2024. 05. 19  Initiale
--                          2024. 06. 24  CSI2 2pixel , 4lane fixed 
---------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.xpackage.all;

Library UNISIM;
use UNISIM.vcomponents.all;


entity top is
port(

    --i2c
        scl_out    : out std_logic;
        sda        : inout std_logic;
        
	-- system signal
	    nRST						: in std_logic;
    
		MCLK_50M_p					: in std_logic;
		MCLK_50M_n					: in std_logic;

	-- mipi csi2 interface
		mipi_phy_if_clk_hs_p       	: out std_logic;
		mipi_phy_if_clk_hs_n       	: out std_logic;
		mipi_phy_if_clk_lp_p       	: out std_logic;
		mipi_phy_if_clk_lp_n       	: out std_logic;
		mipi_phy_if_data_hs_p    	: out std_logic_vector(3 downto 0);
		mipi_phy_if_data_hs_n    	: out std_logic_vector(3 downto 0);
		mipi_phy_if_data_lp_p    	: out std_logic_vector(3 downto 0);
		mipi_phy_if_data_lp_n    	: out std_logic_vector(3 downto 0);
    --
	-- register map control signal
		SCLK						: in std_logic;	
		SSB							: in std_logic;	
		MOSI						: in std_logic;	
		MISO						: out std_logic;

	------ ROIC Driving Signals ------
		ROIC_RESET_R  				: out std_logic;
		ROIC_SYNC_R   				: out std_logic;
		ROIC_ACLK_R   				: out std_logic;

		RF_SPI_CS_1  				: out std_logic;
		RF_SPI_SCK_1   				: out std_logic;
		RF_SPI_SDI_1   				: out std_logic;
		RF_SPI_SDO_1   				: in std_logic;


		DCLK_R        				: out std_logic;
		R_ROIC_DCLKo_p				: in std_logic_vector(11 downto 0); 
		R_ROIC_DCLKo_n				: in std_logic_vector(11 downto 0); 

		R_DOUTA_H					: in std_logic_vector(11 downto 0);
		R_DOUTA_L					: in std_logic_vector(11 downto 0);
		R_DOUTB_H					: in std_logic_vector(11 downto 0);
		R_DOUTB_L					: in std_logic_vector(11 downto 0);

	-- ==================================================================
	------ Gate Driving Signals ------
		GF_STV_L    				: out std_logic;
		GF_STV_LR1  				: out std_logic;
		GF_STV_LR2  				: out std_logic;
		GF_STV_LR3  				: out std_logic;
		GF_STV_LR4  				: out std_logic;
		GF_STV_LR5  				: out std_logic;
		GF_STV_LR6  				: out std_logic;
		GF_STV_LR7  				: out std_logic;
		GF_STV_LR8  				: out std_logic;
		GF_STV_LR9  				: out std_logic;
		GF_STV_R    				: out std_logic;
    
	--
		GF_CPV    					: out std_logic;
		GF_OE	    				: out std_logic;
	
		GF_XAO_1   					: out std_logic;
		GF_XAO_2   					: out std_logic;
		GF_XAO_3   					: out std_logic;
		GF_XAO_4   					: out std_logic;
--
		GF_XAO_5   					: out std_logic;
		GF_XAO_6   					: out std_logic;
		GF_XAO_7   					: out std_logic;
		GF_XAO_8   					: out std_logic;



	---------- Bias Signals ----------
		R_SW_BIAS   				: out std_logic;
		R_SW_AVDDI 					: out std_logic;

	--------- Signals control --------

	--------- Trigger Signals --------
		prep_req   					: in std_logic;
		exp_req    					: in std_logic;

		prep_ack   					: out std_logic;
		exp_ack    					: out std_logic;

	-- cancel_req : in std_logic;

	--------- Signals control --------
		STATE_LED1  				: out std_logic;
		STATE_LED2  				: out std_logic
	);

end top;

architecture Behavioral of top is

    --i2c
    signal gate_gpio_data : std_logic_vector(15 downto 0); --240703 data����  

    component i2c_master
        Port ( 
            scl_out    			: out std_logic;
            sda        			: inout std_logic;
            s_clk_25mhz 		: in std_logic;
            gate_gpio_data		: in std_logic_vector (15 downto 0) --240703 data����
        );
    end component;  

	component clk_ctrl
	port(
			reset                : in std_logic;
	
			clk_in1_p            : in std_logic;
			clk_in1_n            : in std_logic;

			locked               : out std_logic;
			c0                   : out std_logic;
			c1                   : out std_logic;
			axi_clk              : out std_logic;
			dphy_clk             : out std_logic
--			eim_clk	             : out std_logic
		);
	end component;

	signal s_clk_100mhz              : std_logic;
	signal s_clk_25mhz               : std_logic;
	signal s_axi_clk_200M            : std_logic;
	signal s_dphy_clk_200M           : std_logic;


	component init
	port(
		fsm_clk                      : in std_logic;
	
		en_pwr_off                   : in std_logic;
		en_pwr_dwn                   : in std_logic;

		init_rst                     : out std_logic;

		pwr_init_step1               : out std_logic;
		pwr_init_step2               : out std_logic;
		pwr_init_step3               : out std_logic;
		pwr_init_step4               : out std_logic;
		pwr_init_step5               : out std_logic;
		pwr_init_step6               : out std_logic;

		roic_reset                   : out std_logic
		);
	end component;


	component ctrl_aed
	port(
			sys_clk                      : in std_logic;
			drv_rst                      : in std_logic;

			cmd_get_bright               : in std_logic;

			FSM_aed_read_index           : in std_logic;

			aed_ready_done               : in std_logic;
			aed_ready_done_dark			 : in std_logic;

			valid_posi_flag              : in std_logic;
			valid_nega_flag              : in std_logic;

			row_cnt                      : in std_logic_vector(15 downto 0);

			col_end                      : in std_logic;
			row_end                      : in std_logic;

			aed_th                       : in std_logic_vector(15 downto 0);
			nega_aed_th                  : in std_logic_vector(15 downto 0);
			posi_aed_th                  : in std_logic_vector(15 downto 0);
			sel_aed_roic                 : in std_logic_vector(15 downto 0);
			num_trigger                  : in std_logic_vector(15 downto 0);
			sel_aed_test_roic            : in std_logic_vector(15 downto 0);

			aed_read_image_height        : in std_logic_vector(15 downto 0);
			dsp_image_height             : in std_logic_vector(15 downto 0);

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

			chk_reg_0					: out std_logic_vector(31 downto 0);
			chk_reg_1					: out std_logic_vector(31 downto 0);
			chk_reg_2					: out std_logic_vector(31 downto 0);
			chk_reg_3					: out std_logic_vector(31 downto 0);
			chk_reg_4					: out std_logic_vector(31 downto 0);
			chk_reg_5					: out std_logic_vector(31 downto 0);
			chk_reg_6					: out std_logic_vector(31 downto 0);
			chk_reg_7					: out std_logic_vector(31 downto 0);
			chk_reg_8					: out std_logic_vector(31 downto 0);
			chk_reg_9					: out std_logic_vector(31 downto 0);
			chk_reg_A					: out std_logic_vector(31 downto 0);
			chk_reg_B					: out std_logic_vector(31 downto 0);
			chk_reg_C					: out std_logic_vector(15 downto 0);
			chk_reg_D					: out std_logic_vector(15 downto 0);
			chk_reg_E					: out std_logic_vector(15 downto 0);
			chk_reg_F					: out std_logic_vector(15 downto 0);

			disable_aed_read_xao        : out std_logic;		
			on_aed_dark_trigger			: out std_logic;
			on_aed_trigger              : out std_logic
		);
	end component;

	component ctrl_FSM
	port(
			fsm_clk                     : in std_logic;
			rst                         : in std_logic;
			fsm_drv_rst                 : in std_logic;

			reset_FSM                   : in std_logic;

			burst_get_image             : in std_logic;
			get_dark                    : in std_logic;
			get_bright                  : in std_logic;
			cmd_get_bright              : in std_logic;

			cycle_width                 : in std_logic_vector(23 downto 0);
			image_height                : in std_logic_vector(15 downto 0);
			dsp_image_height            : in std_logic_vector(15 downto 0);
			frame_rpt                   : in std_logic_vector(7 downto 0);
			saturation_flush_repeat     : in std_logic_vector(7 downto 0);
			readout_count			    : in std_logic_vector(15 downto 0);

			ready_aed_read              : in std_logic_vector(15 downto 0);
			aed_dark_delay              : in std_logic_vector(15 downto 0);

			en_aed                      : in std_logic;

			aed_read_image_height		: in std_logic_vector(15 downto 0);
			disable_aed_read_xao		: in std_logic;
			on_aed_dark_trigger			: in std_logic;
			on_aed_trigger              : in std_logic;

			en_back_bias                : in std_logic;
			en_flush                    : in std_logic;
			en_panel_stable             : in std_logic;

			col_end                     : out std_logic;
			row_end                     : out std_logic;

			FSM_rst_index               : out std_logic;
			FSM_init_index              : out std_logic;
			FSM_back_bias_index         : out std_logic;
			FSM_flush_index             : out std_logic;
			FSM_aed_read_index          : out std_logic;
			FSM_exp_index               : out std_logic;
			FSM_read_index              : out std_logic;


			ready_to_get_image          : out std_logic;

			aed_ready_done              : out std_logic;
			aed_ready_done_dark			: out std_logic;

			panel_stable_exist            : out std_logic;
			exp_read_exist				  : out std_logic;

			valid_posi_flag             : out std_logic;
			valid_nega_flag             : out std_logic;

			row_cnt                     : out std_logic_vector(15 downto 0);
			col_cnt                     : out std_logic_vector(15 downto 0);

			-- gate_xao                    : out std_logic;
			-- gate_xao_0					: out std_logic;
			-- gate_xao_1					: out std_logic;
			-- gate_xao_2					: out std_logic;
			-- gate_xao_3					: out std_logic;
			-- gate_xao_4					: out std_logic;
			gate_cpv_init				: out std_logic
		);
	end component;

	component reg_map
	port(
			eim_clk                      : in std_logic;
			eim_rst                      : in std_logic;

			fsm_clk                      : in std_logic;
			rst                          : in std_logic;

			sys_clk                      : in std_logic;
			sys_rst                      : in std_logic;

			prep_req                     : in std_logic;
			exp_req                      : in std_logic;

			row_cnt                      : in std_logic_vector(15 downto 0);
			col_cnt                      : in std_logic_vector(15 downto 0);

			row_end                      : in std_logic;

        --i2c
            gate_gpio_data               : out std_logic_vector(15 downto 0); --240703 data����
       -----   

			FSM_rst_index                : in std_logic;
			FSM_init_index               : in std_logic;
			FSM_back_bias_index          : in std_logic;
			FSM_flush_index              : in std_logic;
			FSM_aed_read_index           : in std_logic;
			FSM_exp_index                : in std_logic;
			FSM_read_index               : in std_logic;

			ready_to_get_image           : in std_logic;
			aed_ready_done               : in std_logic;
			valid_aed_read_skip          : in std_logic;

			panel_stable_exist			: in std_logic;
			exp_read_exist				: in std_logic;

			ack_tx_end                   : in std_logic;

			up_roic_reg                  : in std_logic;

			roic_temperature             : in std_logic_vector(15 downto 0);
			roic_reg_in_a                : in std_logic_vector(63 downto 0);
			roic_reg_in_b                : in std_logic_vector(63 downto 0);

			l_roic_temperature           : in std_logic_vector(15 downto 0);
			l_roic_reg_in_a              : in std_logic_vector(63 downto 0);
			l_roic_reg_in_b              : in std_logic_vector(63 downto 0);

			reg_read_index               : in std_logic;

			reg_addr                     : in std_logic_vector(15 downto 0);
			reg_data                     : in std_logic_vector(15 downto 0);
			reg_addr_index               : in std_logic;
			reg_data_index               : in std_logic;

			reg_read_out                 : out std_logic_vector(15 downto 0);
			read_data_en				 : out std_logic;


			en_pwr_off                   : out std_logic;
			en_pwr_dwn                   : out std_logic;

			system_rst                   : out std_logic;

			reset_FSM                    : out std_logic;
			org_reset_FSM                : out std_logic;
			dummy_get_image              : out std_logic;
			exist_get_image              : in std_logic;
			burst_get_image              : out std_logic;
			get_dark                     : out std_logic;
			get_bright                   : out std_logic;
			cmd_get_bright               : out std_logic;

			en_aed                       : out std_logic;

			aed_th                       : out std_logic_vector(15 downto 0);
			nega_aed_th                  : out std_logic_vector(15 downto 0);
			posi_aed_th                  : out std_logic_vector(15 downto 0);
			sel_aed_roic                 : out std_logic_vector(15 downto 0);
			num_trigger                  : out std_logic_vector(15 downto 0);
			sel_aed_test_roic            : out std_logic_vector(15 downto 0);

			ready_aed_read               : out std_logic_vector(15 downto 0);
			aed_dark_delay               : out std_logic_vector(15 downto 0);	

			en_back_bias                 : out std_logic;
			en_flush                     : out std_logic;
			en_panel_stable              : out std_logic;

			cycle_width                  : out std_logic_vector(23 downto 0);
			mux_image_height             : out std_logic_vector(15 downto 0);
			dsp_image_height             : out std_logic_vector(15 downto 0);
			aed_read_image_height        : out std_logic_vector(15 downto 0);
			frame_rpt                    : out std_logic_vector(7 downto 0);
			saturation_flush_repeat      : out std_logic_vector(7 downto 0);
			max_v_count		             : out std_logic_vector(15 downto 0);
			max_h_count		             : out std_logic_vector(15 downto 0);
			csi2_word_count	             : out std_logic_vector(15 downto 0);
			readout_count			     : out std_logic_vector(15 downto 0);

			roic_burst_cycle             : out std_logic_vector(15 downto 0); --- In Reg_map, when user sets "roic_burst_cycle" register, must x 2 to the register value
			start_roic_burst_clk         : out std_logic_vector(15 downto 0);
			end_roic_burst_clk           : out std_logic_vector(15 downto 0); --- In Reg_map, when user sets "end_roic_burst_clk" register, must x 2 to the register value

			gate_mode1                   : out std_logic;
			gate_mode2                   : out std_logic;

			gate_cs1                     : out std_logic;
			gate_cs2                     : out std_logic;

			gate_sel                     : out std_logic;
			gate_ud      	             : out std_logic;
			gate_stv_mode                : out std_logic;
			gate_oepsn                   : out std_logic;
			gate_lr1	                 : out std_logic;
			gate_lr2	                 : out std_logic;
			-- stv_sel_h	                     : out std_logic; **
			-- stv_sel_l1	                     : out std_logic; **
			-- stv_sel_r1	                     : out std_logic; ** 
			-- stv_sel_l2	                     : out std_logic; **
			-- stv_sel_r2	                     : out std_logic; **

			up_back_bias                 : out std_logic_vector(15 downto 0);
			dn_back_bias               	 : out std_logic_vector(15 downto 0);
			up_back_bias_opr             : out std_logic_vector(15 downto 0);
			dn_back_bias_opr             : out std_logic_vector(15 downto 0);

			up_gate_stv1                 : out std_logic_vector(15 downto 0);
			dn_gate_stv1                 : out std_logic_vector(15 downto 0);

			up_gate_stv2                 : out std_logic_vector(15 downto 0);
			dn_gate_stv2                 : out std_logic_vector(15 downto 0);

			up_gate_cpv1                 : out std_logic_vector(15 downto 0);
			dn_gate_cpv1                 : out std_logic_vector(15 downto 0);

			up_gate_cpv2                 : out std_logic_vector(15 downto 0);
			dn_gate_cpv2                 : out std_logic_vector(15 downto 0);

			up_gate_oe1                  : out std_logic_vector(15 downto 0);
			dn_gate_oe1                  : out std_logic_vector(15 downto 0);

			up_gate_oe2                  : out std_logic_vector(15 downto 0);
			dn_gate_oe2                  : out std_logic_vector(15 downto 0);

			-- up_gate_xao                  : out std_logic_vector(15 downto 0);
			-- down_gate_xao                : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_0            : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_1            : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_2            : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_3            : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_4            : out std_logic_vector(15 downto 0);
			dn_aed_gate_xao_5            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_0            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_1            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_2            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_3            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_4            : out std_logic_vector(15 downto 0);
			up_aed_gate_xao_5            : out std_logic_vector(15 downto 0);
			aed_detect_line_0            : out std_logic_vector(15 downto 0);
			aed_detect_line_1            : out std_logic_vector(15 downto 0);
			aed_detect_line_2            : out std_logic_vector(15 downto 0);
			aed_detect_line_3            : out std_logic_vector(15 downto 0);
			aed_detect_line_4            : out std_logic_vector(15 downto 0);
			aed_detect_line_5            : out std_logic_vector(15 downto 0);


			up_roic_sync                 : out std_logic_vector(15 downto 0);

			up_roic_aclk_0               : out std_logic_vector(15 downto 0);
			up_roic_aclk_1               : out std_logic_vector(15 downto 0);
			up_roic_aclk_2               : out std_logic_vector(15 downto 0);
			up_roic_aclk_3               : out std_logic_vector(15 downto 0);
			up_roic_aclk_4               : out std_logic_vector(15 downto 0);
			up_roic_aclk_5               : out std_logic_vector(15 downto 0);
			up_roic_aclk_6               : out std_logic_vector(15 downto 0);
			up_roic_aclk_7               : out std_logic_vector(15 downto 0);
			up_roic_aclk_8               : out std_logic_vector(15 downto 0);
			up_roic_aclk_9               : out std_logic_vector(15 downto 0);
			up_roic_aclk_10              : out std_logic_vector(15 downto 0);

			burst_break_pt_0             : out std_logic_vector(15 downto 0);
			burst_break_pt_1             : out std_logic_vector(15 downto 0);
			burst_break_pt_2             : out std_logic_vector(15 downto 0);
			burst_break_pt_3             : out std_logic_vector(15 downto 0);

			roic_reg_set_0               : out std_logic_vector(15 downto 0);
			roic_reg_set_1               : out std_logic_vector(15 downto 0);
			roic_reg_set_1_dual          : out std_logic_vector(15 downto 0);
			roic_reg_set_2               : out std_logic_vector(15 downto 0);
			roic_reg_set_3               : out std_logic_vector(15 downto 0);
			roic_reg_set_4               : out std_logic_vector(15 downto 0);
			roic_reg_set_5               : out std_logic_vector(15 downto 0);
			roic_reg_set_6               : out std_logic_vector(15 downto 0);
			roic_reg_set_7               : out std_logic_vector(15 downto 0);
			roic_reg_set_8               : out std_logic_vector(15 downto 0);
			roic_reg_set_9               : out std_logic_vector(15 downto 0);
			roic_reg_set_10              : out std_logic_vector(15 downto 0);
			roic_reg_set_11              : out std_logic_vector(15 downto 0);
			roic_reg_set_12              : out std_logic_vector(15 downto 0);
			roic_reg_set_13              : out std_logic_vector(15 downto 0);
			roic_reg_set_14              : out std_logic_vector(15 downto 0);
			roic_reg_set_15              : out std_logic_vector(15 downto 0);

			LD_IO_DELAY_TAB              : out std_logic;
			IO_DELAY_TAB                 : out std_logic_vector(4 downto 0);
			sel_roic_reg                 : out std_logic_vector(7 downto 0);

			gate_size                    : out std_logic_vector(15 downto 0);

			en_16bit_adc                 : out std_logic;

			en_test_pattern_col          : out std_logic;
			en_test_pattern_row          : out std_logic;

			en_test_roic_col             : out std_logic;
			en_test_roic_row             : out std_logic;

			aed_test_mode1               : out std_logic;
			aed_test_mode2               : out std_logic;

			-- prep_ack                     : out std_logic;
			exp_ack                      : out std_logic
	
			-- cancel_req                   : in std_logic
		);
	end component;


	component roic_gate_drv
	port(
			fsm_clk                      : in std_logic;
			fsm_drv_rst                  : in std_logic;
			rst                          : in std_logic;

			row_cnt                      : in std_logic_vector(15 downto 0);
			col_cnt                      : in std_logic_vector(15 downto 0);

			-- image_height                 : in std_logic_vector(15 downto 0);
			aed_read_image_height        : in std_logic_vector(15 downto 0);

			gate_size                    : in std_logic_vector(15 downto 0);

			FSM_back_bias_index          : in std_logic;
			FSM_flush_index              : in std_logic;
			FSM_aed_read_index           : in std_logic;
			FSM_read_index               : in std_logic;

			col_end                      : in std_logic;

			disable_aed_read_xao         : in std_logic;

			up_back_bias                 : in std_logic_vector(15 downto 0);
			dn_back_bias                 : in std_logic_vector(15 downto 0);
			up_back_bias_opr             : in std_logic_vector(15 downto 0);
			dn_back_bias_opr             : in std_logic_vector(15 downto 0);

			up_gate_stv1                 : in std_logic_vector(15 downto 0);
			dn_gate_stv1                 : in std_logic_vector(15 downto 0);

			up_gate_stv2                 : in std_logic_vector(15 downto 0);
			dn_gate_stv2                 : in std_logic_vector(15 downto 0);

			up_gate_cpv1                 : in std_logic_vector(15 downto 0);
			dn_gate_cpv1                 : in std_logic_vector(15 downto 0);

			up_gate_cpv2                 : in std_logic_vector(15 downto 0);
			dn_gate_cpv2                 : in std_logic_vector(15 downto 0);

			up_gate_oe1                  : in std_logic_vector(15 downto 0);
			dn_gate_oe1                  : in std_logic_vector(15 downto 0);

			up_gate_oe2                  : in std_logic_vector(15 downto 0);
			dn_gate_oe2                  : in std_logic_vector(15 downto 0);

			up_aed_gate_xao_0            : in std_logic_vector(15 downto 0);
			up_aed_gate_xao_1            : in std_logic_vector(15 downto 0);
			up_aed_gate_xao_2            : in std_logic_vector(15 downto 0);
			up_aed_gate_xao_3            : in std_logic_vector(15 downto 0);
			up_aed_gate_xao_4            : in std_logic_vector(15 downto 0);
			up_aed_gate_xao_5            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_0            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_1            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_2            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_3            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_4            : in std_logic_vector(15 downto 0);
			dn_aed_gate_xao_5            : in std_logic_vector(15 downto 0);

			up_roic_sync                 : in std_logic_vector(15 downto 0);

			up_roic_aclk_1               : in std_logic_vector(15 downto 0);
			up_roic_aclk_2               : in std_logic_vector(15 downto 0);
			up_roic_aclk_3               : in std_logic_vector(15 downto 0);
			up_roic_aclk_4               : in std_logic_vector(15 downto 0);
			up_roic_aclk_5               : in std_logic_vector(15 downto 0);
			up_roic_aclk_6               : in std_logic_vector(15 downto 0);
			up_roic_aclk_7               : in std_logic_vector(15 downto 0);
			up_roic_aclk_8               : in std_logic_vector(15 downto 0);
			up_roic_aclk_9               : in std_logic_vector(15 downto 0);
			up_roic_aclk_10              : in std_logic_vector(15 downto 0);
			up_roic_aclk_0               : in std_logic_vector(15 downto 0);

			burst_break_pt_1             : in std_logic_vector(15 downto 0);
			burst_break_pt_2             : in std_logic_vector(15 downto 0);
			burst_break_pt_3             : in std_logic_vector(15 downto 0);
			burst_break_pt_0             : in std_logic_vector(15 downto 0);

			aed_detect_line_0            : in std_logic_vector(15 downto 0);
			aed_detect_line_1            : in std_logic_vector(15 downto 0);
			aed_detect_line_2            : in std_logic_vector(15 downto 0);
			aed_detect_line_3            : in std_logic_vector(15 downto 0);
			aed_detect_line_4            : in std_logic_vector(15 downto 0);
			aed_detect_line_5            : in std_logic_vector(15 downto 0);

			back_bias                    : out std_logic;

			gate_stv_1_1                 : out std_logic;

			gate_cpv                     : out std_logic;
			gate_oe1                     : out std_logic;
			gate_oe2                     : out std_logic;

			gate_xao_0                   : out std_logic;
			gate_xao_1                   : out std_logic;
			gate_xao_2                   : out std_logic;
			gate_xao_3                   : out std_logic;
			gate_xao_4                   : out std_logic;
			gate_xao_5                   : out std_logic;

			roic_sync                    : out std_logic;
			roic_aclk                    : out std_logic;

			valid_aed_read_skip          : out std_logic;

			roic_data_read_index         : out std_logic;
			valid_read_out               : out std_logic
		);
	end component;

signal s_roic_reset					: std_logic;
signal s_roic_aclk					: std_logic;
signal s_roic_sync					: std_logic;
signal s_gate_oe2					: std_logic;
signal s_back_bias					: std_logic;


	component clk_gen
	port(
			sys_clk                      : in std_logic;

			drv_rst                      : in std_logic;

			roic_data_read_index         : in std_logic;
			valid_read_out               : in std_logic;
			
			col_end                      : in std_logic;

			roic_burst_cycle             : in std_logic_vector(15 downto 0); --- In Reg_map, when user sets "roic_burst_cycle" register, must x 2 to the register value
			start_roic_burst_clk         : in std_logic_vector(15 downto 0);
			end_roic_burst_clk           : in std_logic_vector(15 downto 0); --- In Reg_map, when user sets "end_roic_burst_clk" register, must x 2 to the register value

			valid_roic_out               : out std_logic;
			valid_roic_burst_clk         : out std_logic;

			valid_roic_reg_out           : out std_logic;
			valid_roic_header_out        : out std_logic;

			dbg_reg						 : out std_logic_vector(31 downto 0);

			dclk                         : out std_logic
		);
	end component;

	component roic_data_latch
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
		valid_roic_header_out           : in std_logic;

		LD_IO_DELAY_TAB              : in std_logic;
		IO_DELAY_TAB                 : in std_logic_vector(4 downto 0);
		sel_roic_reg                 : in std_logic_vector(7 downto 0);

		dclk_out					: in std_logic_vector(11 downto 0);
		dclk_n_out					: in std_logic_vector(11 downto 0);

		douta						: in std_logic_vector(11 downto 0);
		dout_n_a					: in std_logic_vector(11 downto 0);
		doutb						: in std_logic_vector(11 downto 0);
		dout_n_b					: in std_logic_vector(11 downto 0);
	
		up_roic_reg                  : out std_logic;

		roic_temperature             : out std_logic_vector(15 downto 0);
		roic_reg_in_a                : out std_logic_vector(63 downto 0);
		roic_reg_in_b                : out std_logic_vector(63 downto 0);

		en_16bit_adc                 : in std_logic;

		valid_roic_data              : out std_logic;
		roic_data_in	              : out array32(11 downto 0)
	);
	end component;

	component roic_reg_set
	port
	(
		sys_clk                      : in std_logic;
		sys_rst                      : in std_logic;

		FSM_rst_index                : in std_logic;
		org_reset_FSM                : in std_logic;

		roic_reg_set_0               : in std_logic_vector(15 downto 0);
		roic_reg_set_1               : in std_logic_vector(15 downto 0);
		roic_reg_set_1_dual          : in std_logic_vector(15 downto 0);
		roic_reg_set_2               : in std_logic_vector(15 downto 0);
		roic_reg_set_3               : in std_logic_vector(15 downto 0);
		roic_reg_set_4               : in std_logic_vector(15 downto 0);
		roic_reg_set_5               : in std_logic_vector(15 downto 0);
		roic_reg_set_6               : in std_logic_vector(15 downto 0);
		roic_reg_set_7               : in std_logic_vector(15 downto 0);
		roic_reg_set_8               : in std_logic_vector(15 downto 0);
		roic_reg_set_9               : in std_logic_vector(15 downto 0);
		roic_reg_set_10              : in std_logic_vector(15 downto 0);
		roic_reg_set_11              : in std_logic_vector(15 downto 0);
		roic_reg_set_12              : in std_logic_vector(15 downto 0);
		roic_reg_set_13              : in std_logic_vector(15 downto 0);
		roic_reg_set_14              : in std_logic_vector(15 downto 0);
		roic_reg_set_15              : in std_logic_vector(15 downto 0);

		roic_cs0   					 : out std_logic;
		roic_sck   					 : out std_logic;
		roic_sdo   					 : out std_logic;
		roic_sdo_dual				 : out std_logic;
		roic_sdi   					 : in std_logic;
		roic_sdi_dual				 : in std_logic;

		ack_tx_end                   : out std_logic
	);
	end component;

	signal s_roic_cs0   	: std_logic;
	signal s_roic_cs1   	: std_logic;

	signal s_roic_sck0   	: std_logic;
	signal s_roic_sck1   	: std_logic;
	signal s_roic_sdo0   	: std_logic;
	signal s_roic_sdo1   	: std_logic;
	signal s_roic_sdi_0		: std_logic;
	signal s_roic_sdi_1   	: std_logic;

	component data_tx_rx
	port
	(
		sys_clk                      : in std_logic;
		sys_rst                      : in std_logic;

		-- axi_clk                      : in std_logic;
		eim_clk                      : in std_logic;
		eim_rst                      : in std_logic;
		
		dual_readout		   		 : in std_logic;
		dummy_get_image              : in std_logic;
		exist_get_image              : out std_logic;
		burst_get_image              : in std_logic;

		read_axis_tready             : in std_logic;
		read_axis_tlast	             : out std_logic;
		read_data_valid              : out std_logic;
		read_rx_data_a      		 : out std_logic_vector(23 downto 0);
		read_rx_data_b      		 : out std_logic_vector(23 downto 0);
		read_frame_start             : out std_logic;
		read_frame_reset             : out std_logic;

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
	end component;

	signal eim_clk               : std_logic;
	signal eim_rst               : std_logic :='0';

	signal sys_rst               : std_logic :='0';
	signal drv_rst               : std_logic :='0';
	signal rst                   : std_logic :='0';
	signal fsm_drv_rst           : std_logic :='0';

	signal sig_dclk              : std_logic :='0';

	signal col_end               : std_logic;
	signal row_end               : std_logic;

	signal FSM_rst_index         : std_logic;
	signal FSM_init_index        : std_logic;
	signal FSM_back_bias_index   : std_logic;
	signal FSM_flush_index       : std_logic;
	signal FSM_aed_read_index    : std_logic;
	signal FSM_exp_index         : std_logic;
	signal FSM_read_index        : std_logic;

	signal ready_to_get_image    : std_logic;

	signal aed_ready_done        : std_logic;
	signal aed_ready_done_dark	 : std_logic;

	signal s_panel_stable_exist	: std_logic;
	signal s_exp_read_exist		: std_logic;

	signal valid_posi_flag       : std_logic;
	signal valid_nega_flag       : std_logic;

	signal row_cnt               : std_logic_vector(15 downto 0);
	signal col_cnt               : std_logic_vector(15 downto 0);

	signal en_pwr_off            : std_logic;
	signal en_pwr_dwn            : std_logic;

	signal system_rst            : std_logic;

	signal reset_FSM             : std_logic;
	signal org_reset_FSM         : std_logic;

	signal dummy_get_image       : std_logic;
	signal exist_get_image       : std_logic;
	signal burst_get_image       : std_logic;
	signal get_dark              : std_logic;
	signal get_bright            : std_logic;
	signal cmd_get_bright        : std_logic;

	signal en_aed                : std_logic;

	signal disable_aed_read_xao		: std_logic;
	signal l_disable_aed_read_xao  	: std_logic;

	signal on_aed_trigger        	: std_logic;
	signal l_on_aed_trigger        	: std_logic;

	signal aed_th                	: std_logic_vector(15 downto 0);
	signal nega_aed_th           	: std_logic_vector(15 downto 0);
	signal posi_aed_th           	: std_logic_vector(15 downto 0);
	signal sel_aed_roic          	: std_logic_vector(15 downto 0);
	signal num_trigger           	: std_logic_vector(15 downto 0);
	signal sel_aed_test_roic     	: std_logic_vector(15 downto 0);
	
	signal ready_aed_read        	: std_logic_vector(15 downto 0);
	signal aed_dark_delay        	: std_logic_vector(15 downto 0);

	signal en_back_bias          	: std_logic;
	signal en_flush              	: std_logic;
	signal en_panel_stable       	: std_logic;

	signal cycle_width           	: std_logic_vector(23 downto 0);
	signal image_height          	: std_logic_vector(15 downto 0);
	signal dsp_image_height      	: std_logic_vector(15 downto 0);
	signal aed_read_image_height 	: std_logic_vector(15 downto 0);
	signal frame_rpt             	: std_logic_vector(7 downto 0) ;
	signal saturation_flush_repeat 	: std_logic_vector(7 downto 0);
	signal max_h_count		      	: std_logic_vector(15 downto 0);
	signal max_v_count      		: std_logic_vector(15 downto 0);
	signal csi2_word_count     		: std_logic_vector(15 downto 0);
	signal readout_count		 	: std_logic_vector(15 downto 0);

	signal gate_size             	: std_logic_vector(15 downto 0);

	signal roic_burst_cycle      	: std_logic_vector(15 downto 0);
	signal start_roic_burst_clk  	: std_logic_vector(15 downto 0);
	signal end_roic_burst_clk    	: std_logic_vector(15 downto 0);

	signal up_back_bias          	: std_logic_vector(15 downto 0);
	signal down_back_bias        	: std_logic_vector(15 downto 0);
	signal up_back_bias_opr      	: std_logic_vector(15 downto 0);
	signal down_back_bias_opr    	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_stv1          	: std_logic_vector(15 downto 0);
	signal down_gate_stv1        	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_stv2          	: std_logic_vector(15 downto 0);
	signal down_gate_stv2        	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_cpv1          	: std_logic_vector(15 downto 0);
	signal down_gate_cpv1        	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_cpv2          	: std_logic_vector(15 downto 0);
	signal down_gate_cpv2        	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_oe1           	: std_logic_vector(15 downto 0);
	signal down_gate_oe1         	: std_logic_vector(15 downto 0);
                                                                
	signal up_gate_oe2           	: std_logic_vector(15 downto 0);
	signal down_gate_oe2         	: std_logic_vector(15 downto 0);
                                                                
	-- signal up_gate_xao           : std_logic_vector(15 downto 0);
	-- signal down_gate_xao         : std_logic_vector(15 downto 0);

	signal up_roic_sync          	: std_logic_vector(15 downto 0);

	signal up_aed_gate_xao_0		: std_logic_vector(15 downto 0);
	signal up_aed_gate_xao_1		: std_logic_vector(15 downto 0);
	signal up_aed_gate_xao_2		: std_logic_vector(15 downto 0);
	signal up_aed_gate_xao_3		: std_logic_vector(15 downto 0);
	signal up_aed_gate_xao_4		: std_logic_vector(15 downto 0);
	signal up_aed_gate_xao_5		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_0		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_1		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_2		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_3		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_4		: std_logic_vector(15 downto 0);
	signal dn_aed_gate_xao_5		: std_logic_vector(15 downto 0);
	signal aed_detect_line_0		: std_logic_vector(15 downto 0);
	signal aed_detect_line_1		: std_logic_vector(15 downto 0);
	signal aed_detect_line_2		: std_logic_vector(15 downto 0);
	signal aed_detect_line_3		: std_logic_vector(15 downto 0);
	signal aed_detect_line_4		: std_logic_vector(15 downto 0);
	signal aed_detect_line_5		: std_logic_vector(15 downto 0);

	signal up_roic_aclk_1        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_2        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_3        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_4        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_5        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_6        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_7        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_8        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_9        	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_10       	: std_logic_vector(15 downto 0);
	signal up_roic_aclk_0       	: std_logic_vector(15 downto 0);
	
	signal burst_break_pt_1      	: std_logic_vector(15 downto 0);
	signal burst_break_pt_2      	: std_logic_vector(15 downto 0);
	signal burst_break_pt_3      	: std_logic_vector(15 downto 0);
	signal burst_break_pt_0      	: std_logic_vector(15 downto 0);

	signal en_16bit_adc          	: std_logic;

	signal en_test_pattern_col   	: std_logic;
	signal en_test_pattern_row   	: std_logic;

	signal en_test_roic_col   		: std_logic;
	signal en_test_roic_row   		: std_logic;

	signal aed_test_mode1        	: std_logic :='0';
	signal aed_test_mode2        	: std_logic :='0';

	signal gate_stv_1_1          : std_logic :='0';

	signal sig_gate_cpv          	: std_logic :='0';
	signal sig_gate_lr1           	: std_logic :='0';
	signal sig_gate_lr2           	: std_logic :='0';

	signal gate_cpv_init         	: std_logic :='0';

	signal s_reg_read_index        	: std_logic :='0';
	
	signal s_reg_addr              	: std_logic_vector(15 downto 0) :=(others=>'0');
	signal s_reg_data              	: std_logic_vector(15 downto 0) :=(others=>'0');
	signal s_reg_addr_index        	: std_logic :='0';
	signal s_reg_data_index        	: std_logic :='0';
	
	signal reg_read_out          	: std_logic_vector(15 downto 0);
	signal read_data_en   		 	: std_logic;

	signal valid_aed_read_skip   	: std_logic;

	signal roic_data_read_index  	: std_logic;
	signal valid_read_out        	: std_logic;

	signal valid_roic_out        	: std_logic;
	signal valid_roic_burst_clk  	: std_logic;

	signal valid_roic_reg_out    	: std_logic;
	signal valid_roic_header_out    : std_logic;

	signal exl_valid_roic_data		: std_logic;
	signal exr_valid_roic_data		: std_logic;

	signal valid_roic_data			: std_logic;
	signal roic_data_in				: array32(11 downto 0);

	signal l_valid_roic_data		: std_logic;
	signal l_roic_data_in			: array32(11 downto 0);

	signal valid_aed_test_data 		: std_logic;
	signal trigger_data_1  			: std_logic_vector(15 downto 0);
	signal trigger_data_2  			: std_logic_vector(15 downto 0);
	signal trigger_data_3  			: std_logic_vector(15 downto 0);

	signal l_valid_aed_test_data 	: std_logic;
	signal l_trigger_data_1  		: std_logic_vector(15 downto 0);
	signal l_trigger_data_2  		: std_logic_vector(15 downto 0);
	signal l_trigger_data_3  		: std_logic_vector(15 downto 0);

	signal roic_reg_set_1      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_1_dual 		: std_logic_vector(15 downto 0);
	signal roic_reg_set_2      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_3      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_4      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_5      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_6      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_7      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_8      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_9      		: std_logic_vector(15 downto 0);
	signal roic_reg_set_10     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_11     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_12     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_13     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_14     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_15     		: std_logic_vector(15 downto 0);
	signal roic_reg_set_0     		: std_logic_vector(15 downto 0);

	signal ack_tx_end          		: std_logic;

	signal up_roic_reg : std_logic 	:='0';

	signal r_roic_temperature 		: std_logic_vector(15 downto 0);
	signal r_roic_reg_in_a 			: std_logic_vector(63 downto 0);
	signal r_roic_reg_in_b 			: std_logic_vector(63 downto 0);

	signal l_roic_temperature 		: std_logic_vector(15 downto 0);
	signal l_roic_reg_in_a 			: std_logic_vector(63 downto 0);
	signal l_roic_reg_in_b 			: std_logic_vector(63 downto 0);

	
	signal roic_set_cs0  			: std_logic :='0';
	signal roic_set_cs1  			: std_logic :='0';
	signal roic_set_cs2  			: std_logic :='0';
	signal roic_set_cs3  			: std_logic :='0';
	signal roic_set_cs4  			: std_logic :='0';
	signal roic_set_cs5  			: std_logic :='0';
	signal roic_set_cs6  			: std_logic :='0';
	signal roic_set_cs7  			: std_logic :='0';
	signal roic_set_cs8  			: std_logic :='0';
	signal roic_set_cs9  			: std_logic :='0';
	signal roic_set_cs10 			: std_logic :='0';
	signal roic_set_cs11 			: std_logic :='0';
	signal roic_set_sck  			: std_logic :='0';
	signal roic_set_sdo  			: std_logic :='0';
	
	signal roic_init_cs0  			: std_logic :='0';
	signal roic_init_cs1  			: std_logic :='0';
	signal roic_init_cs2  			: std_logic :='0';
	signal roic_init_cs3  			: std_logic :='0';
	signal roic_init_cs4  			: std_logic :='0';
	signal roic_init_cs5  			: std_logic :='0';
	signal roic_init_cs6  			: std_logic :='0';
	signal roic_init_cs7  			: std_logic :='0';
	signal roic_init_cs8  			: std_logic :='0';
	signal roic_init_cs9  			: std_logic :='0';
	signal roic_init_cs10 			: std_logic :='0';
	signal roic_init_cs11 			: std_logic :='0';
	signal roic_init_sck  			: std_logic :='0';
	signal roic_init_sdo  			: std_logic :='0';

	signal LD_IO_DELAY_TAB  		: std_logic;
	signal IO_DELAY_TAB 			: std_logic_vector(4 downto 0);
	signal sel_roic_reg 			: std_logic_vector(7 downto 0);


	signal vsync 					: std_logic :='0';
	signal hsync 					: std_logic :='0';


	signal s_pwr_init_step1 		: std_logic :='0';
	signal s_pwr_init_step2 		: std_logic :='0';
	signal s_pwr_init_step3 		: std_logic :='0';
	signal s_pwr_init_step4 		: std_logic :='0';
	signal pwr_init_step5 			: std_logic :='0';
	signal pwr_init_step6 			: std_logic :='0';

	signal valid_tx_1d 				: std_logic :='0';
	signal valid_tx_2d 				: std_logic :='0';

	signal init_rst : std_logic 	:='1';


	signal FSM_read_index_1d 		: std_logic :='0';
	signal FSM_read_index_2d 		: std_logic :='0';

	signal hi_FSM_read_index 		: std_logic :='0';

	signal led_on_cnt 				: std_logic_vector(23 downto 0) :=(others=>'0');
	
	signal aed_ready_cnt_d_chk 		: std_logic_vector(15 downto 0) := (others=>'0'); -- 190822, kkh
	signal aed_ready_cnt_b_chk 		: std_logic_vector(15 downto 0) := (others=>'0'); -- 190822, kkh
	signal valid_aed_dark_get_dark 	: std_logic := '0'; -- 190822, kkh
	
	signal gate_xao			 		: std_logic := '0'; -- holee
	signal gate_xao_0			 	: std_logic := '0';
	signal gate_xao_1			 	: std_logic := '0';
	signal gate_xao_2			 	: std_logic := '0';
	signal gate_xao_3			 	: std_logic := '0';
	signal gate_xao_4			 	: std_logic := '0';
	
	signal chk_reg_0				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_1				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_2				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_3				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_4				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_5				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_6				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_7				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_8				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_9				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_A				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_B				: std_logic_vector(31 downto 0) :=(others=>'0');
	signal chk_reg_C				: std_logic_vector(15 downto 0) :=(others=>'0');
	signal chk_reg_D				: std_logic_vector(15 downto 0) :=(others=>'0');
	signal chk_reg_E				: std_logic_vector(15 downto 0) :=(others=>'0');
	signal chk_reg_F				: std_logic_vector(15 downto 0) :=(others=>'0');
	
	signal on_aed_dark_trigger 		: std_logic;
	signal l_on_aed_dark_trigger 	: std_logic;
	signal dbg_reg					: std_logic_vector(31 downto 0);

	-- local host register control siganl
	constant					header 	: integer := 2;
	constant					payload : integer := 16;
	constant					addrsz 	: integer := 14;
	constant					pktsz   : integer := 32; -- (header + addrsz + payload);		// size of SPI packet

	signal s_miso					: std_logic;
	signal s_spi_start_flag			: std_logic;
	signal s_addr_dv				: std_logic;
	signal s_rw_out					: std_logic;

	signal s_read_rx_data_a			: std_logic_vector (23 downto 0);
	signal s_read_rx_data_b			: std_logic_vector (23 downto 0);
	signal s_read_rx_data_c			: std_logic_vector (23 downto 0);
	signal s_read_rx_data_d			: std_logic_vector (23 downto 0);
	signal s_read_frame_start		: std_logic;
	signal s_read_frame_reset		: std_logic;
	signal s_read_axis_tready		: std_logic;
	signal s_read_axis_tlast		: std_logic;
	signal s_read_data_valid		: std_logic;

	component spi_slave is
		generic (
			pktsz 	: integer := 32;            --  size of SPI packet
			header 	: integer := 16;        -- size of header
			payload : integer := 16;       -- size of payload
			addrsz 	: integer := 15         -- size of SPI Address Space
			);
		port (
			clk				: in std_logic;
			reset			: in std_logic;
			--
			SCLK			: in std_logic;
			SSB				: in std_logic;
			MOSI			: in std_logic;
			MISO			: out std_logic;
			--
			spi_start_flag	: out std_logic;
			read_data		: in std_logic_vector(payload-1 downto 0);
			read_en			: in std_logic;
			reg_addr		: out std_logic_vector(addrsz-1 downto 0);
			addr_valid		: out std_logic;
			wr_data			: out std_logic_vector(payload-1 downto 0);
			wr_data_valid	: out std_logic;
			rw_out			: out std_logic
		);
	end component;

	component data_tx32b is
		port (
			io_reset				: in std_logic;
			clk_reset				: in std_logic;
			clk_in					: in std_logic;
			--
			data_out_from_device	: in std_logic_vector(31 downto 0);
			data_out_to_pins		: out std_logic_vector(3 downto 0);
			clk_div_out				: out std_logic
		);
	end component;

	signal s_clk_div_out	: std_logic;

    -- component ila_top is
    --     port (
    --         clk     : in std_logic;
    --         probe0  : in std_logic;
    --         probe1  : in std_logic;
    --         probe2  : in std_logic;
    --         probe3  : in std_logic;
    --         probe4  : in std_logic;
    --         probe5  : in std_logic_vector(15 downto 0);
    --         probe6  : in std_logic;
    --         probe7  : in std_logic
    --     );
    -- end component;

    signal s_test_cnt : std_logic_vector(23 downto 0);

    component mipi_csi2_tx_top is
        port (
	            reset           		: in std_logic;
	            axi_clk_200M       		: in std_logic;
	            dphy_clk_200M       	: in std_logic;
	            clk_100M       			: in std_logic;
	            eim_clk       			: in std_logic;
	            locked_i       			: in std_logic;
		
	            read_frame_start       	: in std_logic;
	            read_frame_reset       	: in std_logic;
				--
	            s_axis_tdata_a    		: in std_logic_vector(23 downto 0);
	            s_axis_tdata_b    		: in std_logic_vector(23 downto 0);
	            s_axis_tdata_c    		: in std_logic_vector(23 downto 0);
	            s_axis_tdata_d    		: in std_logic_vector(23 downto 0);
	            s_axis_tlast       		: in std_logic;
	            s_axis_tready       	: out std_logic;
	            s_axis_tvalid       	: in std_logic;
	            s_axis_tstrb    		: in std_logic_vector(2 downto 0);
	            s_axis_tkeep    		: in std_logic_vector(2 downto 0);
	            -- almost_empty       		: out std_logic;
	            -- almost_full       		: out std_logic;
	            --
	            mipi_phy_if_clk_hs_p	: out std_logic;
	            mipi_phy_if_clk_hs_n	: out std_logic;
	            mipi_phy_if_clk_lp_p	: out std_logic;
	            mipi_phy_if_clk_lp_n	: out std_logic;
	            mipi_phy_if_data_hs_p   : out std_logic_vector(3 downto 0);
	            mipi_phy_if_data_hs_n   : out std_logic_vector(3 downto 0);
	            mipi_phy_if_data_lp_p   : out std_logic_vector(3 downto 0);
	            mipi_phy_if_data_lp_n   : out std_logic_vector(3 downto 0);
	            --
	            csi2_word_count	    	: in std_logic_vector(15 downto 0);
	            m_axis_video_tuser    	: in std_logic_vector(0 downto 0);
	            done       				: out std_logic;
	            interrupt       		: out std_logic;
	            status    				: out std_logic_vector(31 downto 0);
	            system_rst_out       	: out std_logic
            );
        end component;
    
    signal s_reset				: std_logic;
    signal s_csi2_reset			: std_logic;
    signal s_clk_lock			: std_logic;
    signal s_axis_video_tuser   : std_logic_vector(0 downto 0) := "0";
    signal s_axis_tdata_a		: std_logic_vector (23 downto 0);
    signal s_axis_tdata_b		: std_logic_vector (23 downto 0);
    signal s_axis_tdata_c		: std_logic_vector (23 downto 0);
    signal s_axis_tdata_d		: std_logic_vector (23 downto 0);
    signal s_axis_tvalid		: std_logic;

begin

		-- debug_ila : ila_top
		-- port map (
		-- 	clk         => s_clk_25mhz,
		-- 	probe0      => FSM_rst_index,
		-- 	probe1      => FSM_init_index,
		-- 	probe2      => FSM_back_bias_index,
		-- 	probe3      => FSM_flush_index,
		-- 	probe4      => FSM_exp_index,
		-- 	probe5      => image_height,
		-- 	-- probe5      => roic_data_in(0)(15 downto 0),
		-- 	probe6      => hsync,
		-- 	probe7      => vsync
		-- 	);
	
		MISO <= s_miso;
		
		process(rst, s_clk_25mhz)
		begin
			if rst='0' then
				s_test_cnt <= (others=>'0');
        elsif rising_edge(s_clk_25mhz) then
            s_test_cnt <= s_test_cnt + '1';
        end if;
    end process;
    
         --i2c
    i2c_inst : i2c_master
        Port map (
            scl_out    			=> scl_out,
            sda        			=> sda,
            s_clk_25mhz 		=> s_clk_25mhz,
            gate_gpio_data		=> gate_gpio_data  --240703 data����
        );
 
 -----------------------------------------------------------------------
-------------------- internal reset at start --------------------------
-----------------------------------------------------------------------

    clk_inst0 : clk_ctrl
    port map
    (
        reset          => '0',
    --	locked => ,
        clk_in1_p      => MCLK_50M_p,
        clk_in1_n      => MCLK_50M_n,
    
        locked         => s_clk_lock,
        c0             => s_clk_100mhz, --100MHz
        c1             => s_clk_25mhz,  --25MHz
        axi_clk        => s_axi_clk_200M, --200MHz
        dphy_clk       => s_dphy_clk_200M  --200MHz
--        eim_clk        => eim_clk  --50MHz
    );
    
    eim_clk <= s_clk_100mhz;
    
 -- mipi_csi2 interface
    inst_mipi_csi2_tx : mipi_csi2_tx_top
        port map(
            -- reset                  => s_reset    ,
            reset                  => s_csi2_reset    ,

            axi_clk_200M           => s_axi_clk_200M    ,
            dphy_clk_200M          => s_dphy_clk_200M    ,
            clk_100M               => s_clk_100mhz    ,
            eim_clk                => eim_clk    ,
            locked_i               => s_clk_lock    ,

			read_frame_start       => s_read_frame_start    ,
			read_frame_reset       => s_read_frame_reset    ,

			s_axis_tdata_a         => s_axis_tdata_a    ,
			s_axis_tdata_b         => s_axis_tdata_b    ,
			s_axis_tdata_c         => s_axis_tdata_c    ,
			s_axis_tdata_d         => s_axis_tdata_d    ,
            s_axis_tlast           => s_read_axis_tlast    ,
            s_axis_tready          => s_read_axis_tready    ,
            s_axis_tvalid          => s_axis_tvalid, --'1'   ,
            -- s_axis_tstrb           => "111"     ,
            s_axis_tstrb           => "000"     ,
            s_axis_tkeep           => "111"     ,
            -- almost_empty           => open    ,
            -- almost_full            => open    ,

            mipi_phy_if_clk_hs_n   => mipi_phy_if_clk_hs_n     ,
            mipi_phy_if_clk_hs_p   => mipi_phy_if_clk_hs_p     ,
            mipi_phy_if_clk_lp_n   => mipi_phy_if_clk_lp_n     ,
            mipi_phy_if_clk_lp_p   => mipi_phy_if_clk_lp_p     ,
            mipi_phy_if_data_hs_n  => mipi_phy_if_data_hs_n    ,
            mipi_phy_if_data_hs_p  => mipi_phy_if_data_hs_p    ,
            mipi_phy_if_data_lp_n  => mipi_phy_if_data_lp_n    ,
            mipi_phy_if_data_lp_p  => mipi_phy_if_data_lp_p    ,

			csi2_word_count	       => csi2_word_count             ,
            m_axis_video_tuser     => s_axis_video_tuser    ,
            done                   => open    ,
            interrupt              => open    ,
            status                 => open    ,
            system_rst_out         => open
            );
    
	s_axis_video_tuser(0)	<= s_read_frame_start;
    s_axis_tvalid 		<= s_read_data_valid;
	s_axis_tdata_a 		<= s_read_rx_data_a;
	s_axis_tdata_b 		<= s_read_rx_data_b;
	-- s_axis_tdata_c 		<= s_read_rx_data_c;
	-- s_axis_tdata_d 		<= s_read_rx_data_d;
	s_axis_tdata_c 		<= s_read_rx_data_a;
	s_axis_tdata_d 		<= s_read_rx_data_b;

    s_reset <= not nRST;

	inst_host_if : spi_slave
	generic map (
		pktsz				=> pktsz,
		header				=> header,
		payload				=> payload,
		addrsz				=> addrsz
	)
	port map (
		clk					=> s_clk_100mhz,
		reset				=> s_reset,
		SCLK				=> SCLK,
		SSB					=> SSB,
		MOSI				=> MOSI,
		-- MISO				=> MISO,
		MISO				=> s_miso,
		spi_start_flag		=> s_spi_start_flag,
		read_data			=> reg_read_out,
		read_en				=> read_data_en,
		reg_addr			=> s_reg_addr(addrsz-1 downto 0),
		addr_valid			=> s_addr_dv,
		wr_data				=> s_reg_data,
		wr_data_valid		=> s_reg_data_index,
		rw_out				=> s_rw_out
	);

	s_reg_addr_index <= '1' when s_rw_out='0' and s_addr_dv='1' else '0';
	s_reg_read_index <= '1' when s_rw_out='1' and s_addr_dv='1' else '0';
	

	-- =======================================================================
	--
	DCLK_R <= sig_dclk;

	STATE_LED1 <= not FSM_read_index;
	STATE_LED2 <= s_test_cnt(23);


	process(s_clk_25mhz)
	begin
		if s_clk_25mhz'event and s_clk_25mhz='1' then
			FSM_read_index_1d <= FSM_read_index;
			FSM_read_index_2d <= FSM_read_index_1d;
		end if;
	end process;



	hi_FSM_read_index <= not FSM_read_index_1d and FSM_read_index_2d;
	-- lo_FSM_read_index <= '1' when sig_FSM_read_index='1' and led_on_cnt=x"fffff" else '0';


	GF_CPV      <= sig_gate_cpv or gate_cpv_init;
	-- GF_LR1       <= sig_gate_lr1; **
	-- GF_LR2       <= sig_gate_lr2; **

	-- GF_STV_R <= gate_stv_1_1 when sig_gate_lr2='1' else 'Z'; -- modified by holee
	GF_STV_R <= gate_stv_1_1 when sig_gate_lr1='1' else 'Z'; -- modified by holee
	GF_STV_L <= gate_stv_1_1 when sig_gate_lr1='0' else 'Z'; -- modified by holee

    GF_STV_LR1 <= gate_stv_1_1;
    GF_STV_LR2 <= gate_stv_1_1;
    GF_STV_LR3 <= gate_stv_1_1;
    GF_STV_LR4 <= gate_stv_1_1;
    GF_STV_LR5 <= gate_stv_1_1;
    GF_STV_LR6 <= 'Z';
    GF_STV_LR7 <= 'Z';
    GF_STV_LR8 <= 'Z';

	GF_STV_LR9 <= 'Z';

	-- modified by drake.lee : check gate ic scan direction
	GF_XAO_6    <= gate_xao_0 when en_aed='1' else '1';
	GF_XAO_5    <= gate_xao_1 when en_aed='1' else '1';
	GF_XAO_4    <= gate_xao_2 when en_aed='1' else '1';
	GF_XAO_3    <= gate_xao_3 when en_aed='1' else '1';
	GF_XAO_2    <= gate_xao_4 when en_aed='1' else '1';
	GF_XAO_1    <= gate_xao when en_aed='1' else '1';


	process(s_clk_25mhz)
	begin
		if s_clk_25mhz'event and s_clk_25mhz='1' then
			if system_rst='1' or init_rst='1' or s_reset='1' then
				rst <= '0';
			else
				rst <= '1';
			end if;
		end if;
	end process;

	process(s_clk_100mhz)
	begin
		if s_clk_100mhz'event and s_clk_100mhz='1' then
			if system_rst='1' or s_reset='1' then
				s_csi2_reset <= '1';
			else
				s_csi2_reset <= '0';
			end if;
		end if;
	end process;

	process(s_clk_25mhz)
	begin
		if s_clk_25mhz'event and s_clk_25mhz='1' then
			if FSM_rst_index='1' or rst='0' then
				fsm_drv_rst <= '0';
			else
				fsm_drv_rst <= '1';
			end if;
		end if;
	end process;

	process(s_clk_100mhz)
	begin
		if s_clk_100mhz'event and s_clk_100mhz='1' then
			sys_rst <= rst;
		end if;
	end process;

	process(s_clk_100mhz)
	begin
		if s_clk_100mhz'event and s_clk_100mhz='1' then
			drv_rst <= fsm_drv_rst;
		end if;
	end process;

	process(eim_clk)
	begin
		if eim_clk'event and eim_clk='1' then
			eim_rst <= rst;
		end if;
	end process;

	U2 : init
	port map
	(
		fsm_clk                       => s_clk_25mhz                       ,

		en_pwr_off                    => en_pwr_off                    ,
		en_pwr_dwn                    => en_pwr_dwn                    ,

		init_rst                      => init_rst                      ,

		pwr_init_step1                => s_pwr_init_step1                ,
		pwr_init_step2                => s_pwr_init_step2                ,
		pwr_init_step3                => s_pwr_init_step3                ,
		pwr_init_step4                => s_pwr_init_step4                ,
		pwr_init_step5                => pwr_init_step5                ,
		pwr_init_step6                => pwr_init_step6                ,

		roic_reset                    => s_roic_reset
	);


	U3 : ctrl_aed
	port map
	(
		sys_clk                       => s_clk_100mhz                       ,
		drv_rst                       => drv_rst                       ,

		cmd_get_bright				  => cmd_get_bright                ,

		FSM_aed_read_index            => FSM_aed_read_index            ,
                
		aed_ready_done                => aed_ready_done                ,
		aed_ready_done_dark				=> aed_ready_done_dark				,
        
		valid_posi_flag               => valid_posi_flag               ,
		valid_nega_flag               => valid_nega_flag               ,

		row_cnt                       => row_cnt                       ,

		col_end                       => col_end                       ,
		row_end                       => row_end                       ,

		aed_th                        => aed_th                        ,
		nega_aed_th                   => nega_aed_th                   ,
		posi_aed_th                   => posi_aed_th                   ,
		sel_aed_roic                  => sel_aed_roic                  ,
		num_trigger                   => num_trigger                   ,
		sel_aed_test_roic             => sel_aed_test_roic             ,

		aed_read_image_height         => aed_read_image_height         ,
		dsp_image_height              => dsp_image_height              ,

		valid_roic_data               => valid_roic_data               ,
        roic_data_in_1                => roic_data_in(0)               ,
        roic_data_in_2                => roic_data_in(1)               ,
        roic_data_in_3                => roic_data_in(2)               ,
        roic_data_in_4                => roic_data_in(3)               ,
        roic_data_in_5                => roic_data_in(4)               ,
        roic_data_in_6                => roic_data_in(5)               ,
        roic_data_in_7                => roic_data_in(6)               ,
        roic_data_in_8                => roic_data_in(7)               ,
        roic_data_in_9                => roic_data_in(8)               ,
        roic_data_in_10               => roic_data_in(9)               ,
        roic_data_in_11               => roic_data_in(10)               ,
        roic_data_in_12               => roic_data_in(11)               ,

		aed_test_mode1                => aed_test_mode1                ,
		aed_test_mode2                => aed_test_mode2                ,

		valid_aed_test_data           => valid_aed_test_data           ,
		trigger_data_1                => trigger_data_1                ,
		trigger_data_2                => trigger_data_2                ,
		trigger_data_3                => trigger_data_3                ,

		chk_reg_0					=> chk_reg_0					,
		chk_reg_1					=> chk_reg_1					,
		chk_reg_2					=> chk_reg_2					,
		chk_reg_3					=> chk_reg_3					,
		chk_reg_4					=> chk_reg_4					,
		chk_reg_5					=> chk_reg_5					,
		chk_reg_6					=> chk_reg_6					,
		chk_reg_7					=> chk_reg_7					,
		chk_reg_8					=> chk_reg_8					,
		chk_reg_9					=> chk_reg_9					,
		chk_reg_A					=> chk_reg_A					,
		chk_reg_B					=> chk_reg_B					,
		chk_reg_C					=> chk_reg_C					,
		chk_reg_D					=> chk_reg_D					,
		chk_reg_E					=> chk_reg_E					,
		chk_reg_F					=> chk_reg_F					,

		disable_aed_read_xao          => disable_aed_read_xao          ,
		on_aed_dark_trigger           => on_aed_dark_trigger           ,
		on_aed_trigger                => on_aed_trigger
	);

	-- =====================================================================================
	U4 : ctrl_FSM
	port map
	(
		fsm_clk                       	=> s_clk_25mhz                       ,
		rst                           	=> rst                           ,
		fsm_drv_rst                   	=> fsm_drv_rst                   ,

		reset_FSM                     	=> reset_FSM                     ,

--		dummy_get_image					=> dummy_get_image	,
		burst_get_image               	=> burst_get_image                      ,
		get_dark                      	=> get_dark                      ,
		get_bright                    	=> get_bright                    ,
		cmd_get_bright                	=> cmd_get_bright                ,

		cycle_width                   	=> cycle_width                   ,
		image_height                  	=> image_height                  ,
		dsp_image_height              	=> dsp_image_height              ,
		frame_rpt                     	=> frame_rpt                     ,
		saturation_flush_repeat       	=> saturation_flush_repeat       ,
		readout_count			       	=> readout_count       ,

		ready_aed_read                	=> ready_aed_read                ,
		aed_dark_delay                	=> aed_dark_delay                ,

		en_aed                        	=> en_aed                        ,
		
		aed_read_image_height			=> aed_read_image_height			,
		disable_aed_read_xao			=> disable_aed_read_xao				,
		on_aed_dark_trigger           	=> on_aed_dark_trigger           ,
		on_aed_trigger                	=> on_aed_trigger                ,

		en_back_bias                  	=> en_back_bias                  ,
		en_flush                      	=> en_flush                      ,
		en_panel_stable               	=> en_panel_stable               ,

		col_end                       	=> col_end                       ,
		row_end                       	=> row_end                       ,

		FSM_rst_index                 	=> FSM_rst_index                 ,
		FSM_init_index                	=> FSM_init_index                ,
		FSM_back_bias_index           	=> FSM_back_bias_index           ,
        FSM_flush_index               	=> FSM_flush_index               ,
		FSM_aed_read_index            	=> FSM_aed_read_index            ,
		FSM_exp_index                 	=> FSM_exp_index                 ,
        FSM_read_index                	=> FSM_read_index                ,
		
		ready_to_get_image            	=> ready_to_get_image            ,

		aed_ready_done                	=> aed_ready_done                ,
		aed_ready_done_dark				=> aed_ready_done_dark				,
        
		panel_stable_exist				=> s_panel_stable_exist          ,
		exp_read_exist					=> s_exp_read_exist				,
        
		valid_posi_flag               	=> valid_posi_flag               ,
		valid_nega_flag               	=> valid_nega_flag               ,

		row_cnt                       	=> row_cnt                       ,
		col_cnt                       	=> col_cnt                       ,

		-- gate_xao						=> open , --gate_xao                      ,
		-- gate_xao_0						=> open , --gate_xao_0							,
		-- gate_xao_1						=> open , --gate_xao_1							,
		-- gate_xao_2						=> open , --gate_xao_2							,
		-- gate_xao_3						=> open , --gate_xao_3							,
		-- gate_xao_4						=> open , --gate_xao_4							,
		gate_cpv_init                 	=> gate_cpv_init
	);

	U5 : reg_map
	port map
	(
	    --i2c
        gate_gpio_data                => gate_gpio_data                     , --240703 data����    
        -----
        eim_clk                       	=> s_clk_100mhz                       ,
        -- eim_clk                       => eim_clk                       ,
		eim_rst                       	=> sys_rst                       ,

		fsm_clk                       	=> s_clk_25mhz                       ,
		rst                           	=> rst                           ,

		sys_clk                       	=> s_clk_100mhz                       ,
		sys_rst                       	=> sys_rst                       ,

		prep_req                      	=> prep_req                      ,
		exp_req                       	=> exp_req                       ,

		row_cnt                       	=> row_cnt                       ,
		col_cnt                       	=> col_cnt                       ,
		
		row_end                       	=> row_end                       ,

		FSM_rst_index                 	=> FSM_rst_index                 ,
		FSM_init_index                	=> FSM_init_index                ,
		FSM_back_bias_index           	=> FSM_back_bias_index           ,
		FSM_flush_index               	=> FSM_flush_index               ,
		FSM_aed_read_index            	=> FSM_aed_read_index            ,
		FSM_exp_index                 	=> FSM_exp_index                 ,
		FSM_read_index                	=> FSM_read_index                ,
		
		ready_to_get_image            	=> ready_to_get_image            ,

		aed_ready_done                	=> aed_ready_done                ,

		panel_stable_exist				=> s_panel_stable_exist          ,
		exp_read_exist					=> s_exp_read_exist				,
        
		valid_aed_read_skip           	=> valid_aed_read_skip           ,

		ack_tx_end                    	=> ack_tx_end                    ,

		up_roic_reg                   	=> up_roic_reg                   ,

		roic_temperature              	=> r_roic_temperature                 ,
		roic_reg_in_a                 	=> r_roic_reg_in_a                 ,
		roic_reg_in_b                 	=> r_roic_reg_in_b                 ,

		l_roic_temperature              => l_roic_temperature                 ,
		l_roic_reg_in_a                 => l_roic_reg_in_a                 ,
		l_roic_reg_in_b                 => l_roic_reg_in_b                 ,

		reg_read_index                	=> s_reg_read_index                ,

		reg_addr                      	=> s_reg_addr                      ,
		reg_data                      	=> s_reg_data                      ,
		reg_addr_index                	=> s_reg_addr_index                ,
		reg_data_index                	=> s_reg_data_index                ,

		reg_read_out                  	=> reg_read_out                  ,
		read_data_en                  	=> read_data_en                  ,

		en_pwr_off                    	=> en_pwr_off                    ,
		en_pwr_dwn                    	=> en_pwr_dwn                    ,

		system_rst                    	=> system_rst                    ,

		reset_FSM                     	=> reset_FSM                     ,
		org_reset_FSM                 	=> org_reset_FSM                 ,
		dummy_get_image               	=> dummy_get_image                      ,
		exist_get_image               	=> exist_get_image                      ,
		burst_get_image               	=> burst_get_image                      ,
		get_dark                      	=> get_dark                      ,
		get_bright                    	=> get_bright                    ,
		cmd_get_bright                	=> cmd_get_bright                ,

		en_aed                        	=> en_aed                        ,

		aed_th                        	=> aed_th                        ,
		nega_aed_th                   	=> nega_aed_th                   ,
		posi_aed_th                   	=> posi_aed_th                   ,
		sel_aed_roic                  	=> sel_aed_roic                  ,
		num_trigger                   	=> num_trigger                   ,
		sel_aed_test_roic             	=> sel_aed_test_roic             ,
		
		ready_aed_read                	=> ready_aed_read                ,
		aed_dark_delay                	=> aed_dark_delay                ,

		en_back_bias                  	=> en_back_bias                  ,
		en_flush                      	=> en_flush                      ,
		en_panel_stable               	=> en_panel_stable               ,

		cycle_width                   	=> cycle_width                   ,
		mux_image_height				=> image_height                  ,
		dsp_image_height              	=> dsp_image_height              ,
		aed_read_image_height         	=> aed_read_image_height         ,
		frame_rpt                     	=> frame_rpt                     ,
		saturation_flush_repeat       	=> saturation_flush_repeat       ,
		max_v_count		              	=> max_v_count              ,
		max_h_count		              	=> max_h_count              ,
		csi2_word_count	              	=> csi2_word_count             ,
		readout_count			       	=> readout_count       ,

		roic_burst_cycle              	=> roic_burst_cycle              ,
		start_roic_burst_clk          	=> start_roic_burst_clk          ,
		end_roic_burst_clk            	=> end_roic_burst_clk            ,
        
		gate_mode1                    	=> open                   ,
		gate_mode2                    	=> open                   ,
        
		-- gate_cs1                      => GF_CS1                      , **
        -- gate_cs2                      => GF_CS2                      , **

		gate_sel             	      	=> open                  ,
		gate_ud         	          	=> open                  ,
		gate_stv_mode                 	=> open                  ,
		gate_oepsn  	              	=> open                  ,
		gate_lr1		                => sig_gate_lr1                  ,
		gate_lr2		                => sig_gate_lr2                  ,
		-- stv_sel_h		                  => s_stv_sel_h                  , **
		-- stv_sel_l1		                  => s_stv_sel_l1                  , **
		-- stv_sel_r1		                  => s_stv_sel_r1                  , **
		-- stv_sel_l2		                  => s_stv_sel_l2                  , **
		-- stv_sel_r2		                  => s_stv_sel_r2                  , **

		up_back_bias                  	=> up_back_bias                  ,
		dn_back_bias                	=> down_back_bias                ,
		up_back_bias_opr              	=> up_back_bias_opr              ,
		dn_back_bias_opr            	=> down_back_bias_opr            ,
		
		up_gate_stv1                  	=> up_gate_stv1                  ,
		dn_gate_stv1                	=> down_gate_stv1                ,
		
		up_gate_stv2                  	=> up_gate_stv2                  ,
		dn_gate_stv2                	=> down_gate_stv2                ,

		up_gate_cpv1                  	=> up_gate_cpv1                  ,
		dn_gate_cpv1                	=> down_gate_cpv1                ,

		up_gate_cpv2                  	=> up_gate_cpv2                  ,
		dn_gate_cpv2                	=> down_gate_cpv2                ,

		up_gate_oe1                   	=> up_gate_oe1                   ,
		dn_gate_oe1                 	=> down_gate_oe1                 ,

		up_gate_oe2                   	=> up_gate_oe2                   ,
		dn_gate_oe2                 	=> down_gate_oe2                 ,

		-- up_gate_xao                   => up_gate_xao                   ,
		-- down_gate_xao                 => down_gate_xao                 ,

		dn_aed_gate_xao_0               => dn_aed_gate_xao_0                  ,
		dn_aed_gate_xao_1               => dn_aed_gate_xao_1                  ,
		dn_aed_gate_xao_2               => dn_aed_gate_xao_2                  ,
		dn_aed_gate_xao_3               => dn_aed_gate_xao_3                  ,
		dn_aed_gate_xao_4               => dn_aed_gate_xao_4                  ,
		dn_aed_gate_xao_5               => dn_aed_gate_xao_5                  ,
		up_aed_gate_xao_0               => up_aed_gate_xao_0                  ,
		up_aed_gate_xao_1               => up_aed_gate_xao_1                  ,
		up_aed_gate_xao_2               => up_aed_gate_xao_2                  ,
		up_aed_gate_xao_3               => up_aed_gate_xao_3                  ,
		up_aed_gate_xao_4               => up_aed_gate_xao_4                  ,
		up_aed_gate_xao_5               => up_aed_gate_xao_5                  ,

		up_roic_sync                  	=> up_roic_sync                  ,
        
		up_roic_aclk_0               	=> up_roic_aclk_0               ,
		up_roic_aclk_1                	=> up_roic_aclk_1                ,
		up_roic_aclk_2                	=> up_roic_aclk_2                ,
        up_roic_aclk_3                	=> up_roic_aclk_3                ,
		up_roic_aclk_4                	=> up_roic_aclk_4                ,
		up_roic_aclk_5                	=> up_roic_aclk_5                ,
		up_roic_aclk_6                	=> up_roic_aclk_6                ,
		up_roic_aclk_7                	=> up_roic_aclk_7                ,
		up_roic_aclk_8                	=> up_roic_aclk_8                ,
		up_roic_aclk_9                	=> up_roic_aclk_9                ,
		up_roic_aclk_10               	=> up_roic_aclk_10               ,
		
		burst_break_pt_0              	=> burst_break_pt_0              ,
		burst_break_pt_1              	=> burst_break_pt_1              ,
		burst_break_pt_2              	=> burst_break_pt_2              ,
		burst_break_pt_3              	=> burst_break_pt_3              ,

		aed_detect_line_0               => aed_detect_line_0                  ,
		aed_detect_line_1               => aed_detect_line_1                  ,
		aed_detect_line_2               => aed_detect_line_2                  ,
		aed_detect_line_3               => aed_detect_line_3                  ,
		aed_detect_line_4               => aed_detect_line_4                  ,
		aed_detect_line_5               => aed_detect_line_5                  ,


		roic_reg_set_0                	=> roic_reg_set_0               ,
		roic_reg_set_1                	=> roic_reg_set_1                ,
		roic_reg_set_1_dual           	=> roic_reg_set_1_dual           ,
		roic_reg_set_2                	=> roic_reg_set_2                ,
		roic_reg_set_3                	=> roic_reg_set_3                ,
		roic_reg_set_4                	=> roic_reg_set_4                ,
		roic_reg_set_5                	=> roic_reg_set_5                ,
		roic_reg_set_6                	=> roic_reg_set_6                ,
		roic_reg_set_7                	=> roic_reg_set_7                ,
		roic_reg_set_8                	=> roic_reg_set_8                ,
		roic_reg_set_9                	=> roic_reg_set_9                ,
		roic_reg_set_10               	=> roic_reg_set_10               ,
		roic_reg_set_11               	=> roic_reg_set_11               ,
		roic_reg_set_12               	=> roic_reg_set_12               ,
		roic_reg_set_13               	=> roic_reg_set_13               ,
		roic_reg_set_14               	=> roic_reg_set_14               ,
		roic_reg_set_15               	=> roic_reg_set_15               ,

		LD_IO_DELAY_TAB					=> LD_IO_DELAY_TAB                  ,
		IO_DELAY_TAB                  	=> IO_DELAY_TAB                  ,
		sel_roic_reg                  	=> sel_roic_reg                  ,

		gate_size                     	=> gate_size                     ,

		en_16bit_adc                  	=> en_16bit_adc                  ,

		en_test_pattern_col           	=> en_test_pattern_col           ,
		en_test_pattern_row           	=> en_test_pattern_row           ,

		en_test_roic_col           		=> en_test_roic_col           ,
		en_test_roic_row           		=> en_test_roic_row           ,

		aed_test_mode1                	=> aed_test_mode1                ,
		aed_test_mode2                	=> aed_test_mode2                ,

		-- prep_ack                      => prep_ack                      ,
		exp_ack                       	=> exp_ack

		-- cancel_req                    => cancel_req
	);

	prep_ack <= '0';


	U6 : roic_gate_drv
	port map
	(
		fsm_clk                       	=> s_clk_25mhz                       ,
		fsm_drv_rst                   	=> fsm_drv_rst                   ,
		rst                           	=> rst                           ,

		row_cnt                       	=> row_cnt                       ,
		col_cnt                       	=> col_cnt                       ,

		-- image_height                  	=> image_height                  ,
		aed_read_image_height         	=> aed_read_image_height         ,

		gate_size                     	=> gate_size                     ,
		
        FSM_back_bias_index           	=> FSM_back_bias_index           ,
		FSM_flush_index               	=> FSM_flush_index               ,
		FSM_aed_read_index            	=> FSM_aed_read_index            ,
		FSM_read_index                	=> FSM_read_index                ,

		col_end                       	=> col_end                       ,

		disable_aed_read_xao          	=> disable_aed_read_xao          ,

		up_back_bias                  	=> up_back_bias                  ,
		dn_back_bias                	=> down_back_bias                ,
        up_back_bias_opr              	=> up_back_bias_opr              ,
		dn_back_bias_opr            	=> down_back_bias_opr            ,
		
		up_gate_stv1                  	=> up_gate_stv1                  ,
		dn_gate_stv1                	=> down_gate_stv1                ,
		
		up_gate_stv2                  	=> up_gate_stv2                  ,
		dn_gate_stv2                	=> down_gate_stv2                ,
		
		up_gate_cpv1                  	=> up_gate_cpv1                  ,
		dn_gate_cpv1                	=> down_gate_cpv1                ,
		
		up_gate_cpv2                  	=> up_gate_cpv2                  ,
		dn_gate_cpv2                	=> down_gate_cpv2                ,
		
		up_gate_oe1                   	=> up_gate_oe1                   ,
		dn_gate_oe1                 	=> down_gate_oe1                 ,
		
		up_gate_oe2                   	=> up_gate_oe2                   ,
		dn_gate_oe2                 	=> down_gate_oe2                 ,
		
		up_aed_gate_xao_0               => up_aed_gate_xao_0                  ,
		up_aed_gate_xao_1               => up_aed_gate_xao_1                  ,
		up_aed_gate_xao_2               => up_aed_gate_xao_2                  ,
		up_aed_gate_xao_3               => up_aed_gate_xao_3                  ,
		up_aed_gate_xao_4               => up_aed_gate_xao_4                  ,
		up_aed_gate_xao_5               => up_aed_gate_xao_5                  ,

		dn_aed_gate_xao_0               => dn_aed_gate_xao_0                  ,
		dn_aed_gate_xao_1               => dn_aed_gate_xao_1                  ,
		dn_aed_gate_xao_2               => dn_aed_gate_xao_2                  ,
		dn_aed_gate_xao_3               => dn_aed_gate_xao_3                  ,
		dn_aed_gate_xao_4               => dn_aed_gate_xao_4                  ,
		dn_aed_gate_xao_5               => dn_aed_gate_xao_5                  ,

		up_roic_sync                  	=> up_roic_sync                  ,
        
		up_roic_aclk_0                	=> up_roic_aclk_0               ,
		up_roic_aclk_1                	=> up_roic_aclk_1                ,
		up_roic_aclk_2                	=> up_roic_aclk_2                ,
        up_roic_aclk_3                	=> up_roic_aclk_3                ,
		up_roic_aclk_4                	=> up_roic_aclk_4                ,
		up_roic_aclk_5                	=> up_roic_aclk_5                ,
		up_roic_aclk_6                	=> up_roic_aclk_6                ,
		up_roic_aclk_7                	=> up_roic_aclk_7                ,
		up_roic_aclk_8                	=> up_roic_aclk_8                ,
		up_roic_aclk_9                	=> up_roic_aclk_9                ,
		up_roic_aclk_10               	=> up_roic_aclk_10               ,
		
		burst_break_pt_0              	=> burst_break_pt_0              ,
		burst_break_pt_1              	=> burst_break_pt_1              ,
		burst_break_pt_2              	=> burst_break_pt_2              ,
		burst_break_pt_3              	=> burst_break_pt_3              ,

		aed_detect_line_0               => aed_detect_line_0                  ,
		aed_detect_line_1               => aed_detect_line_1                  ,
		aed_detect_line_2               => aed_detect_line_2                  ,
		aed_detect_line_3               => aed_detect_line_3                  ,
		aed_detect_line_4               => aed_detect_line_4                  ,
		aed_detect_line_5               => aed_detect_line_5                  ,

		
		back_bias                     	=> s_back_bias                     ,
		
		gate_stv_1_1                  	=> gate_stv_1_1                  ,
		
		gate_cpv                      	=> sig_gate_cpv                  ,
		gate_oe1                      	=> GF_OE                      ,
        gate_oe2                      	=> s_gate_oe2                      ,
        
		gate_xao_0						=> gate_xao_0							,
		gate_xao_1						=> gate_xao_1							,
		gate_xao_2						=> gate_xao_2							,
		gate_xao_3						=> gate_xao_3							,
		gate_xao_4						=> gate_xao_4							,
		gate_xao_5                      => gate_xao                      ,

		roic_sync                     	=> s_roic_sync                     ,
        roic_aclk                     	=> s_roic_aclk                     ,

		valid_aed_read_skip           	=> valid_aed_read_skip           ,
        
		roic_data_read_index          	=> roic_data_read_index          ,
		valid_read_out                	=> valid_read_out
	);

	U7 : clk_gen
	port map
	(
		sys_clk                       	=> s_clk_100mhz                       ,

		drv_rst                       	=> drv_rst                       ,

		roic_data_read_index          	=> roic_data_read_index          ,
		valid_read_out                	=> valid_read_out                ,
		
		col_end                       	=> col_end                       ,

		roic_burst_cycle              	=> roic_burst_cycle              ,
		start_roic_burst_clk          	=> start_roic_burst_clk          ,
		end_roic_burst_clk            	=> end_roic_burst_clk            ,

		valid_roic_out                	=> valid_roic_out                ,
		valid_roic_burst_clk          	=> valid_roic_burst_clk          ,

		valid_roic_reg_out            	=> valid_roic_reg_out            ,
		valid_roic_header_out           => valid_roic_header_out            ,

		dbg_reg							=> dbg_reg								,

		dclk                          	=> sig_dclk
	);

	U8_r : roic_data_latch
	port map
	(
		sys_clk                       	=> s_clk_100mhz                       ,
		drv_rst                       	=> drv_rst                       ,
		dphy_clk_200M          			=> s_dphy_clk_200M    ,

		en_test_roic_col                => en_test_roic_col                ,
		en_test_roic_row                => en_test_roic_row                ,
        FSM_read_index                	=> hi_FSM_read_index                ,

		valid_roic_out                	=> valid_roic_out                ,
		valid_roic_burst_clk          	=> valid_roic_burst_clk          ,

		valid_roic_reg_out            	=> valid_roic_reg_out            ,
		valid_roic_header_out           => valid_roic_header_out            ,

		LD_IO_DELAY_TAB                 => LD_IO_DELAY_TAB                  ,
		IO_DELAY_TAB                  	=> IO_DELAY_TAB                  ,
		sel_roic_reg                  	=> sel_roic_reg                  ,

		dclk_out                        => R_ROIC_DCLKo_p               ,
		dclk_n_out                      => R_ROIC_DCLKo_n                      ,
		douta	                        => R_DOUTA_H                        ,
		dout_n_a                        => R_DOUTA_L                        ,
		doutb                        	=> R_DOUTB_H                        ,
		dout_n_b                        => R_DOUTB_L                        ,

		en_16bit_adc                  	=> en_16bit_adc                  ,

		up_roic_reg                   	=> up_roic_reg                   ,

		roic_temperature              	=> r_roic_temperature                 ,
		roic_reg_in_a                 	=> r_roic_reg_in_a                 ,
		roic_reg_in_b                 	=> r_roic_reg_in_b                 ,

		valid_roic_data               	=> valid_roic_data               ,
		roic_data_in               		=> roic_data_in
	);


	-- =================================================================================
	
	U9_r : roic_reg_set
	port map
	(
		sys_clk                       	=> s_clk_100mhz                       ,
		sys_rst                       	=> sys_rst                       ,

		FSM_rst_index                 	=> FSM_rst_index                 ,
		org_reset_FSM                 	=> org_reset_FSM                 ,

		roic_reg_set_0                	=> roic_reg_set_0               ,
		roic_reg_set_1                	=> roic_reg_set_1                ,
		roic_reg_set_1_dual           	=> roic_reg_set_1_dual           ,
		roic_reg_set_2                	=> roic_reg_set_2                ,
		roic_reg_set_3                	=> roic_reg_set_3                ,
		roic_reg_set_4                	=> roic_reg_set_4                ,
		roic_reg_set_5                	=> roic_reg_set_5                ,
		roic_reg_set_6                	=> roic_reg_set_6                ,
		roic_reg_set_7                	=> roic_reg_set_7                ,
		roic_reg_set_8                	=> roic_reg_set_8                ,
		roic_reg_set_9                	=> roic_reg_set_9                ,
		roic_reg_set_10               	=> roic_reg_set_10               ,
		roic_reg_set_11               	=> roic_reg_set_11               ,
		roic_reg_set_12               	=> roic_reg_set_12               ,
		roic_reg_set_13               	=> roic_reg_set_13               ,
		roic_reg_set_14               	=> roic_reg_set_14               ,
		roic_reg_set_15               	=> roic_reg_set_15               ,

		roic_cs0                      	=> s_roic_cs0                      ,
		roic_sck                      	=> s_roic_sck0                      ,
		roic_sdo                      	=> s_roic_sdo0                      ,
		roic_sdi                      	=> s_roic_sdi_0                    ,
		roic_sdo_dual                 	=> s_roic_sdo1                      ,
		roic_sdi_dual                 	=> s_roic_sdi_1                    ,

		ack_tx_end                    	=> ack_tx_end
	);


	U10_r : data_tx_rx
	port map
	(
		sys_clk							=> s_clk_100mhz                       ,
        sys_rst                       	=> sys_rst                       ,

        -- axi_clk                       	=> s_axi_clk_200M                       ,
        eim_clk                       	=> eim_clk                       ,
        eim_rst                       	=> eim_rst                       ,

		dual_readout					=> '0'	,
		dummy_get_image					=> dummy_get_image	,
		exist_get_image					=> exist_get_image	,
		burst_get_image					=> burst_get_image	,

		read_axis_tready				=> s_read_axis_tready, --'1'   ,
		read_axis_tlast					=> s_read_axis_tlast, --'1'   ,
		read_data_valid					=> s_read_data_valid, --'1'   ,
        read_rx_data_a					=> s_read_rx_data_a      				   ,
        read_rx_data_b					=> s_read_rx_data_b      				   ,
        read_frame_start				=> s_read_frame_start      				   ,
		read_frame_reset				=> s_read_frame_reset	,

		get_dark                      	=> get_dark                      ,
		get_bright                    	=> get_bright                    ,

		dsp_image_height              	=> dsp_image_height              ,
		max_v_count		              	=> max_v_count              ,
		max_h_count		              	=> max_h_count              ,

        en_test_pattern_col           	=> en_test_pattern_col           ,
        en_test_pattern_row           	=> en_test_pattern_row           ,

		FSM_aed_read_index            	=> FSM_aed_read_index            ,
        FSM_read_index                	=> FSM_read_index                ,

        valid_roic_data               	=> valid_roic_data               ,
        roic_data_in_1                	=> roic_data_in(0)               ,
        roic_data_in_2                	=> roic_data_in(1)               ,
        roic_data_in_3                	=> roic_data_in(2)               ,
        roic_data_in_4                	=> roic_data_in(3)               ,
        roic_data_in_5                	=> roic_data_in(4)               ,
        roic_data_in_6                	=> roic_data_in(5)               ,
        roic_data_in_7                	=> roic_data_in(6)               ,
        roic_data_in_8                	=> roic_data_in(7)               ,
        roic_data_in_9                	=> roic_data_in(8)               ,
        roic_data_in_10               	=> roic_data_in(9)               ,
        roic_data_in_11               	=> roic_data_in(10)               ,
        roic_data_in_12               	=> roic_data_in(11)               ,

		aed_test_mode1                	=> aed_test_mode1                ,
		aed_test_mode2                	=> aed_test_mode2                ,

		valid_aed_test_data           	=> valid_aed_test_data           ,
		trigger_data_1                	=> trigger_data_1                ,
		trigger_data_2                	=> trigger_data_2                ,
		trigger_data_3                	=> trigger_data_3                ,
		
        vsync                         	=> vsync                         ,
        hsync                         	=> hsync

	);


	-- =========================================================================================

	ROIC_RESET_R 	<= s_roic_reset;
	ROIC_ACLK_R 	<= s_roic_aclk;
	ROIC_SYNC_R 	<= s_roic_sync;

	R_SW_BIAS		<= s_back_bias;
    R_SW_AVDDI 		<= s_pwr_init_step4;

    RF_SPI_CS_1 	<= s_roic_cs0;
	RF_SPI_SCK_1 	<= s_roic_sck0;
	RF_SPI_SDI_1 	<= s_roic_sdo0;
	s_roic_sdi_0 	<= RF_SPI_SDO_1;

	exr_valid_roic_data <= valid_roic_data;
	exl_valid_roic_data <= l_valid_roic_data;
	

end Behavioral;
