// ---------------------------------------------------------------------------------
//   Title      :  Test Bench Module
//              :  
//   Purpose    :  Writing the synthesisable verilog RTL code for
//              :  the Test bench
//              :
//   Designer   :  Kihyun Kim  (kkh@abyzr.com)
//              :
//   Company    :  H&abyz Inc.
//              :
//
// ---------------------------------------------------------------------------------
//   Modification history : 
//
//   version:   |   mod. date:  |   changes made:
//      v1.0        03/18/2022      initial release
//
// ---------------------------------------------------------------------------------
//  Descripitions   :
//
//
//
//
// ---------------------------------------------------------------------------------
`include	"../../source/hdl/p_define.sv"
`timescale 1ns/1ps

module test_bench();

	parameter mipi_lane = 4;

	wire			nRST					;
	reg				MCLK_50M_p				;
	reg				MCLK_50M_n				;
	wire			mipi_phy_if_clk_hs_p	;
	wire			mipi_phy_if_clk_hs_n	;
	wire			mipi_phy_if_clk_lp_p	;
	wire			mipi_phy_if_clk_lp_n	;
	wire	[mipi_lane-1:0]	mipi_phy_if_data_hs_p	;
	wire	[mipi_lane-1:0]	mipi_phy_if_data_hs_n	;
	wire	[mipi_lane-1:0]	mipi_phy_if_data_lp_p	;
	wire	[mipi_lane-1:0]	mipi_phy_if_data_lp_n	;
	wire			SCLK					;
	wire			SSB						;
	wire			MOSI					;
	wire			MISO					;
	wire			ROIC_RESET_R 			;
	wire			ROIC_SYNC_R  			;
	wire			ROIC_ACLK_R  			;
	wire			ROIC_RESET_L 			;
	wire			ROIC_SYNC_L  			;
	wire			ROIC_ACLK_L  			;
	wire			DCLK_R        			;
	wire	[11:0]	R_ROIC_DCLKo_p			;
	wire	[11:0]	R_ROIC_DCLKo_n			;
	wire	[11:0]	R_DOUTA_H				;
	wire	[11:0]	R_DOUTA_L				;
	wire	[11:0]	R_DOUTB_H				;
	wire	[11:0]	R_DOUTB_L				;
	wire			DCLK_L        			;
	wire	[11:0] 	L_ROIC_DCLKo_p			;
	wire	[11:0] 	L_ROIC_DCLKo_n			;
	wire	[11:0] 	L_DOUTA_H				;
	wire	[11:0] 	L_DOUTA_L				;
	wire	[11:0] 	L_DOUTB_H				;
	wire	[11:0] 	L_DOUTB_L				;
	wire			STV_SEL_L1  				;
	wire			STV_SEL_R1  				;
	wire			STV_SEL_L2  				;
	wire			STV_SEL_R2  				;
	wire			STV_SEL_H  				;
	wire			GF_STV_L   				;
	wire			GF_STV_LR2 				;
	wire			GF_STV_LR3 				;
	wire			GF_STV_LR4 				;
	wire			GF_STV_LR5 				;
	wire			GF_STV_LR6 				;
	wire			GF_STV_LR7 				;
	wire			GF_STV_LR8 				;
	wire			GF_STV_R   				;
	wire			GF_CPV    				;
	wire			GF_OE	   				;
	wire			GF_LR1					;
	wire			GF_LR2					;
	wire			GF_CS1					;
	wire			GF_CS2					;
	wire			GF_XAO_1				;
	wire			GF_XAO_2				;
	wire			GF_XAO_3				;
	wire			GF_XAO_4				;
	wire			GF_XAO_5				;
	wire			GF_XAO_6				;
	wire			GF_XAO_7				;
	wire			GF_XAO_8				;
	reg				eim_clk_in  			;
	wire			R_SW_BIAS   			;
	wire			L_SW_BIAS   			;
	wire			RF_SPI_CS_1 			;
	wire			RF_SPI_CS_2 			;
	wire			RF_SPI_SCK_1			;
	wire			RF_SPI_SDI_1			;
	wire			RF_SPI_SDO_1			;
	wire			RF_SPI_SCK_2			;
	wire			RF_SPI_SDI_2			;
	wire			RF_SPI_SDO_2			;
	wire			pwr_bbv     			;
	wire			R_SW_AVDDI				;
	wire			L_SW_AVDDI				;
	wire			prep_req         	= 1'b0	;
	wire			exp_req          	= 1'b0	;
	wire			prep_ack         		;
	wire			exp_ack          		;
	wire			cancel_req       		;
	wire			led_0            		;
	wire			led_1            		;
	wire			led_2            		;
	wire			led_3            		;
	wire			led_4            		;
	wire			led_5            		;
	wire			led_6            		;
	wire			led_7            		;

// 	// org
	reg					osc_clk					;
// 	wire				roic_reset				;
// 	wire				roic_sync				;
// 	wire				roic_aclk				;
// 	wire				dclk					;
// 	wire				dclk_out0				;
// 	wire				dclk_out1				;
// 	wire				dclk_out2				;
// 	wire				dclk_out3				;
// 	wire				dclk_out4				;
// 	wire				dclk_out5				;
// 	wire				dclk_out6				;
// 	wire				dclk_out7				;
// 	wire				dclk_out8				;
// 	wire				dclk_out9				;
// 	wire				dclk_out10				;
// 	wire				dclk_out11				;
// 	wire				douta0					;
// 	wire				douta1					;
// 	wire				douta2					;
// 	wire				douta3					;
// 	wire				douta4					;
// 	wire				douta5					;
// 	wire				douta6					;
// 	wire				douta7					;
// 	wire				douta8					;
// 	wire				douta9					;
// 	wire				douta10					;
// 	wire				douta11					;
// 	wire				doutb0					;
// 	wire				doutb1					;
// 	wire				doutb2					;
// 	wire				doutb3					;
// 	wire				doutb4					;
// 	wire				doutb5					;
// 	wire				doutb6					;
// 	wire				doutb7					;
// 	wire				doutb8					;
// 	wire				doutb9					;
// 	wire				doutb10					;
// 	wire				doutb11					;
// 	wire				gate_stv1_l				;
// 	wire				gate_stv1_r				;
// 	wire				gate_stv2_l				;
// 	wire				gate_stv2_r				;
// 	wire				gate_stv3_l				;
// 	wire				gate_stv3_r				;
// 	wire				gate_stv4_l				;
// 	wire				gate_stv4_r				;
// 	wire				gate_stv5_l				;
// 	wire				gate_stv5_r				;
// 	wire				gate_stv6_l				;
// 	wire				gate_stv6_r				;
// 	wire				gate_cpv				;
// 	wire				gate_oe1				;
// 	wire				gate_oe2				;
// 	wire				gate_xao				;
// 	wire				gate_cs1				;
// 	wire				gate_cs2				;
// 	wire				gate_lr					;
// 	reg					eim_clk					;
// 	wire				eim_cs0					;
// 	wire				eim_cs1					;
// 	wire				eim_oe_oeb				;
// 	wire				eim_rw_web				;
// 	wire				eim_a16					;
// 	wire				eim_a17					;
// 	wire				eim_a18					;
// 	wire				eim_a19					;
// 	wire				eim_a20					;
// 	wire				eim_a21					;
// 	wire				eim_a22					;
// 	wire				eim_a23					;
// 	wire				eim_a24					;
// 	wire				eim_a25					;
// 	wire	[15:0]		eim_d					;
// 	wire	[15:0]		eim_da					;
// `ifdef TB_SIM
// 	wire				sim_eim_rst				;
// `endif
// 	wire				back_bias				;
// 	wire				fpga_int0				;
// 	wire				fpga_int1				;
// 	wire				fpga_int2				;
// 	wire				roic_cs0				;
// 	wire				roic_cs1				;
// 	wire				roic_cs2				;
// 	wire				roic_cs3				;
// 	wire				roic_cs4				;
// 	wire				roic_cs5				;
// 	wire				roic_cs6				;
// 	wire				roic_cs7				;
// 	wire				roic_cs8				;
// 	wire				roic_cs9				;
// 	wire				roic_cs10				;
// 	wire				roic_cs11				;
// 	wire				roic_sck				;
// 	wire				roic_sdo				;
// 	wire				roic_sdi				;
// 	wire				pwr_bbv					;
// 	wire				vgl_ctrl				;
// 	wire				vgh_ctrl				;
// 	wire				roic_pwr_on_1			;
// 	wire				roic_pwr_on_2			;
// 	wire				lvl_shift_ctrl			;
// 	wire				prep_req				;
// 	wire				exp_req					;
// 	wire				prep_ack				;
// 	wire				exp_ack					;
// 	wire				cancel_req				;

// 	wire				led_0					;
// 	wire				led_1					;
// 	wire				led_2					;
// 	wire				led_3					;
// 	wire				led_4					;
// 	wire				led_5					;
// 	wire				led_6					;
// 	wire				led_7					;

// 	wire				model_valid_write		;
// 	wire				model_valid_read		;
// 	wire	[15:0]		model_dsp_data			;
// 	wire	[ 7:0]		model_dsp_addr			;

	reg					roic_data_clk			;
// 	reg					eim_oe_dly				;
// 	integer				tEim_Da					;
// 	integer				tEim_D					;

	logic		reset;
	logic 		m_sclk_in;

	parameter	real	sclk_period				= (10**3)/5;	// time unit : ns
	parameter	real	clk_50M_period			= (10**3)/50;	// time unit : ns
	parameter	real	osc_clk_period			= (10**3)/33;	// time unit : ns
	parameter	real	roic_data_clk_period	= (10**3)/100;	// time unit : ns
	parameter	real	eim_clk_period			= (10**3)/66;	// time unit : ns

	// clock signal intialization
	initial begin
		MCLK_50M_p 		= 1'b1;
		m_sclk_in 		= 1'b1;
		osc_clk 		= 1'b1;
		eim_clk_in 		= 1'b1;
		#4 roic_data_clk 	= 1'b1;
	end

	// clock generation
	always #(sclk_period/2)				m_sclk_in = ~m_sclk_in;
	always #(clk_50M_period/2)			MCLK_50M_p = ~MCLK_50M_p;
	always #(osc_clk_period/2)			osc_clk = ~osc_clk;
	always #(roic_data_clk_period/2)	roic_data_clk = ~roic_data_clk;
	always #(eim_clk_period/2)			eim_clk_in = ~eim_clk_in;

	assign MCLK_50M_n = ~MCLK_50M_p;

	assign nRST = ~reset;

	// Reset
	initial begin
		// @(posedge test_bench.uut.rst);
		@(negedge test_bench.uut.nRST);
		$display("-R- %0t =>", $realtime); // dispaly * 0.001 = ns
		$display("[SYS] : System Reset de-asserted!");
		$display("\n");
	end

	//
	initial begin
		//wait (test_bench.uut.init_rst);
		rst();

		#100;
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);
		@(posedge osc_clk);

	#100
	$display($time, " << spi_write >>");
	// do_mspi_write(2'b10 , {2'b00, 12'h0_01}, 16'h00_01);
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);

	#200
	$display($time, " << spi_read >>");
	// do_mspi_read(2'b01, `ADDR_SYS_CMD_REG);
	do_mspi_read(2'b00, `ADDR_SYS_CMD_REG);

	// #300
	// $display($time, " << spi_write >>");
	// do_mspi_write(2'b10 , {2'b00, 12'h0_03}, 16'h01_04);

	// #200
	// $display($time, " << spi_read >>");
	// do_mspi_read(2'b01, {2'b00, 12'h0_03});

	#5000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);
	#100;
	do_mspi_write(2'b10 , `ADDR_SET_GATE, 16'h00_03);
	#100;
	do_mspi_write(2'b10 , `ADDR_GATE_SIZE, 16'h00_04);
	#100;
	do_mspi_write(2'b10 , `ADDR_BACK_BIAS_SIZE, 16'h00_64);
	#100;
	do_mspi_write(2'b10 , `ADDR_EXPOSE_SIZE, 16'd20); // test pattern , bit4: row bit3: col
	$display($time, " << expose size 20 >>");


	// 10 line
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	// 1536 line
	// do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'h06_00);
	#100;
	do_mspi_write(2'b10 , `ADDR_MAX_V_COUNT, 16'd30);
	// do_mspi_write(2'b10 , `ADDR_MAX_V_COUNT, 16'd1024);
	#100;
	do_mspi_write(2'b10 , `ADDR_MAX_H_COUNT, 16'd256);
	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'd0);
	#100;
	// do_mspi_write(2'b10 , `ADDR_CSI2_WORD_COUNT, 16'd2048);
	do_mspi_write(2'b10 , `ADDR_CSI2_WORD_COUNT, 16'd1024);
	#100;
	do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_FLUSH, 16'd100);
	#100;
	do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_AED, 16'd3660);
	#100;
	do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_READ, 16'd4160);
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_04);
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	#100;
	do_mspi_write(2'b10 , `ADDR_UP_BACK_BIAS, 16'h00_02);
	#100;
	do_mspi_write(2'b10 , `ADDR_DN_BACK_BIAS, 16'h00_32);

	#100;
	do_mspi_write(2'b10 , `ADDR_UP_BACK_BIAS_OPR, 16'h00_19);
	#100;
	do_mspi_write(2'b10 , `ADDR_DN_BACK_BIAS_OPR, 16'h00_32);
	#100;

	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_0, 16'h00_14);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_1, 16'h01_A8);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_2, 16'h00_07);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_3, 16'h00_14);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_4, 16'h00_A2);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_5, 16'h00_14);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_6, 16'h00_58);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_7, 16'h00_37);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_8, 16'h00_69);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_9, 16'h00_07);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_10, 16'h00_00);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_11, 16'h00_18);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_12, 16'h00_02);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_13, 16'h00_23);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_14, 16'h00_2B);
	#100;
	do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_15, 16'h00_08);

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_03);
	#100;
	do_mspi_write(2'b10 , `ADDR_AED_TH, 16'h00_04);
	#100;
	// do_mspi_write(2'b10 , `ADDR_SEL_AED_ROIC, 16'h00_01);
	do_mspi_write(2'b10 , `ADDR_SEL_AED_ROIC, 16'h05_6A);
	#100;
	do_mspi_write(2'b10 , `ADDR_NUM_TRIGGER, 16'h00_01);
	#100;
	do_mspi_write(2'b10 , `ADDR_SEL_AED_TEST_ROIC, 16'h00_01);
	#100;
	do_mspi_write(2'b10 , `ADDR_NEGA_AED_TH, 16'h00_02);
	#100;
	do_mspi_write(2'b10 , `ADDR_POSI_AED_TH, 16'h00_03);
	#100;
	do_mspi_write(2'b10 , `ADDR_AED_DARK_DELAY, 16'h00_02);
	#100;

	$display($time, " << Test start >>");


	#100;
	fsm_test_task(1, 16'h00_00);

	$display($time, " << Wait time 1msec >>");
	#1000000;	// 1msec 


// #################################
//  Test 11
//  Line mode test , 
//	BackBias on , 
//	Flush off
//  PANEL Stable off 
// #################################
	$display($time, " << Test 11 , Line , BB on , Flush off , Flush on Panel stable off >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_00);
	$display($time, " << Test 11 AED CMD Off>>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 11 Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 11 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_02);
	$display($time, " << Test 11 Back Bias 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 11 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_01);
	$display($time, " << Test 11 Saturation Repeat  1 >>");

	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00); // test pattern , bit4: row bit3: col
	$display($time, " << Test 11 disable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	$display($time, " << Test 11 MAGE_HEIGHT 10 >>");


	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 11 FSM reset >>");

	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 11 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 11 SYS CMD 0 , deassert >>");

	$display($time, " << Test 11 Wait time 3msec start >>");
	#3000000;	// 3msec 

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	// #5000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);
	$display($time, " << Test 11 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);


	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_18); 
	$display($time, " << Test 11 set test pattern 0 >>");

	$display($time, " << Test 11 wait time 2msec start >>");
	#2000000;	//2msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
	$display($time, " << Test 11 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close bright 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);

	$display($time, " << Test 11 1msec Wait start >>");
	#1000000;	// 1msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	// #2000000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 11 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close dark 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 11 complete >>");

	$display($time, " << Test 11 2msec Wait start >>");
	#2000000;	// 2msec


// #################################
//  Test 0
//  Line mode test , 
//	BackBias on , 
//	Flush on
//  PANEL Stable on 
// #################################
	$display($time, " << Test 0 , Line , BB on , Flush on , Panel stable on >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 0Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 0 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	$display($time, " << Test 0 Back Bias 1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_02);
	$display($time, " << Test 0 FLUSH 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	
	$display($time, " << Test 0 Saturation Repeat  2 >>");
	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 0 enable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	$display($time, " << Test 0 MAGE_HEIGHT 10 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 0 FSM reset >>");

	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 0 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 0 SYS CMD 0 >>");

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 0 assert drv reset 2 >>");

	$display($time, " << Test 0 Wait time 3msec start >>");
	#3000000;	// 3msec 

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 0 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose , readout close >>");
	
	// #5000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);
	$display($time, " << Test 0 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose start 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 readout close 1 >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << Test 0 panel stable start >>");
	// #100000;	//100usec

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);


	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_1A); 
	$display($time, " << Test 0 set test pattern 0 >>");

	$display($time, " << Test 0 wait time 5msec start >>");
	#5000000;	//5msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 0 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose , readout close >>");
	
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
	$display($time, " << Test 0 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 readout close bright 1 >>");

	wait (test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 0 panel stable start >>");
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);

	$display($time, " << Test 0 3msec Wait start >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 0 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose , readout close >>");
	
	// #2000000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 0 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 0 readout close dark 2 >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << Test 0 panel stable start >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 0 complete >>");

	$display($time, " << Test 0 2msec Wait start >>");
	#2000000;	// 2msec


// #################################
//  Test 01
//  Line mode test , 
//	BackBias on , 
//	Flush off
//  PANEL Stable on 
// #################################
	$display($time, " << Test 1 , Line , BB on , Flush off , Panel stable on >>");

	$display($time, " << Test 1 1msec Wait start >>");
	#1000000;	//1msec
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_02);
	$display($time, " << Test 1 Read out Repeat  2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 1 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	$display($time, " << Test 1 Back Bias 1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 1 FLUSH 0>>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	$display($time, " << Test 1 Saturation Repeat  2 >>");
	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 1 enble panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	$display($time, " << Test 1 IMAGE_HEIGHT 10 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 1 FSM reset >>");

	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 1 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 1 SYS CMD 0 , deassert >>");

	$display($time, " << Test 1 Wait time 3msec start >>");
	#3000000;	// 3msec

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 1 assert drv reset 2 >>");

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 1 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose , readout close >>");
	
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 1 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose start dark 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 readout close dark 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 1 SYS CMD 0 >>");

	$display($time, " << Test 1 Wait time 3msec start >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 1 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose , readout close >>");
	
	// #3000000;	// 3msec
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);	// get dark
	$display($time, " << Test 1 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 readout close bright 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 1 SYS CMD 0 >>");
	$display($time, " << Test 1 complete >>");

	$display($time, " << Test 1 wait time 2msec >>");
	#2000000;	// 2msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 1 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose , readout close >>");
	
	$display($time, " << Test 1 Wait time 3msec start >>");
	#3000000;	// 3msec

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 1 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 1 readout close dark 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 1 SYS CMD 0 >>");

	$display($time, " << Test 1 Wait time 3msec start >>");
	#3000000;	// 3msec

// #################################
//  Test 02
//  Line mode test , 
//	BackBias off , 
//	Flush off
//  PANEL Stable on 
// #################################
	$display($time, " << Test 2 , Line , BB off , Flush off Panel stable on >>");

	$display($time, " << Test 2 1msec Wait start >>");
	#1000000;	//1msec
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 2 Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 2 FSM reset >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_00);
	$display($time, " << Test 2 Back Bias 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 2 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	$display($time, " << Test 2 Saturation Repeat  2 >>");

	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 2 enble panel stable >>");
	
	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd5);
	$display($time, " << Test 2 IMAGE_HEIGHT 5 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 2 FSM reset >>");

	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 2 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 2 SYS CMD 0 , deassert >>");

	$display($time, " << Test 2 Wait time 3msec start >>");
	#3000000;	// 3msec

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 2 assert drv reset 2 >>");

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 2 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose , readout close >>");
	
	// #3000000;	// 3msec
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);	// get dark
	$display($time, " << Test 2 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 readout close bright 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 2 SYS CMD 0 >>");
	$display($time, " << Test 2 complete >>");

	$display($time, " << Test 2 Wait time 3msec start >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 2 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose , readout close >>");
	
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 2 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose start dark 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 readout close dark 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 2 SYS CMD 0 >>");

	$display($time, " << Test 2 Wait time 3msec start >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 2 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose , readout close >>");
	
	// #3000000;	// 3msec
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);	// get dark
	$display($time, " << Test 2 get bright 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 expose start bright 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 2 readout close bright 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 2 SYS CMD 0 >>");
	$display($time, " << Test 2 complete >>");


	$display($time, " << Test 2 wait time 2msec >>");
	#2000000;	// 2msec

// #################################
//  Test 03
//  Line mode test , 
//	BackBias off , 
//	Flush off
//  PANEL Stable off 
// #################################
	$display($time, " << Test 3 , Line , BB off , Flush off Panel stable off >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_03);
	$display($time, " << Test 3 Read out Repeat  3 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_00);
	$display($time, " << Test 3 Back Bias 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 3 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	$display($time, " << Test 3 Saturation Repeat  2 >>");

	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00);
	// test pattern , bit4: row bit3: col
	$display($time, " << Test 3 disable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd5);
	$display($time, " << Test 3 IMAGE_HEIGHT 5 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_EXPOSE_SIZE, 16'd20); // test pattern , bit4: row bit3: col
	$display($time, " << Test 3 expose size 40 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 3 FSM Reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 3 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 3 SYS CMD 0 >>");

	$display($time, " << Test 3 Wait time 4msec start >>");
    #4000000;   // 4msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 3 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h01_00);	// dummy get image
	$display($time, " << Test 3 dummy get image 3 , deassert panel stable >>");

	#500000;    // 500usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 3 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose start dark 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 readout close dark 1 >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << panel stable start >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 3 SYS CMD 0 >>");

	$display($time, " << Test 3 wait time 3msec >>");
	#3000000;   //3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 3 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose , readout close >>");

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
	$display($time, " << Test 3 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 readout close bright 1 >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << panel stable start >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 3 SYS CMD 0 >>");

	$display($time, " << Test 3 wait time 2msec >>");
	#2000000;   //2msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 3 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose , readout close >>");

	#5000;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 3 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 3 readout close dark 2 >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << panel stable start >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 3 SYS CMD 0 >>");
	$display($time, " << Test 3 complete >>");

	$display($time, " << Test 3 Wait time 3msec >>");
	#3000000;	// 3msec
	

// #################################
//  Test 04
//  AED mode test , 
//	BackBias on , 
//	Flush on
//  PANEL Stable on 
// #################################
	$display($time, " << Test 4 , AED , BB on , Flush on , Panel stable on >>");

	$display($time, " << Test 4 1msec Wait start >>");
	#1000000;	//1msec
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_02);
	$display($time, " << Test 4 Read out Repeat  2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 4 READY AED READ 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	$display($time, " << Test 4 Back Bias 1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_02);
	$display($time, " << Test 4 FLUSH 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	$display($time, " << Test 4 Saturation Repeat  2 >>");

	// 50 line for AED test
	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd50);
	$display($time, " << Test 4 IMAGE_HEIGHT 50 >>");

	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 4 enable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_01);
	$display($time, " << Test 4 AED CMD On >>");

	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 4 FSM Reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 4 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 4 SYS CMD 0 >>");

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 4 assert drv reset 1 >>");

	$display($time, " << Test 4 Wait time 3msec >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 4 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 4 AED 1 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 1 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 1 dark readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 4 SYS CMD 0 >>");

	$display($time, " << Test 4 Wait time 1msec >>");
	#1000000; // 1ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 4 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 expose , readout close >>");

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04); // get bright
	$display($time, " << Test 4 AED 1 get bright >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 1 bright expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 1 bright readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 4 SYS CMD 0 >>");

	$display($time, " << Test 4 Wait time 2msec >>");
	#2000000; // 2ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 4 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 4 get AED 2 dark  >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 2 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 4 AED 2 dark readout complete >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << Test 4 panel stable start >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 4 SYS CMD 0 >>");
	$display($time, " << Test 4 complete >>");

	$display($time, " << Test 4 Wait time 2msec >>");
	#2000000;	//2msec

// #################################
//  Test 05
//  AED mode test , 
//	BackBias on , 
//	Flush off
//  PANEL Stable on 
// #################################
	$display($time, " << Test 5 , AED , BB on , Flush off , Panel stable on >>");

	$display($time, " << Test 5 1msec Wait start >>");
	#1000000;	//1msec
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 5 Read out Repeat  1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 5 READY AED READ 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	$display($time, " << Test 5 Back Bias 1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 5 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
	$display($time, " << Test 5 Saturation Repeat  2 >>");

	// 50 line for AED test
	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd50);
	$display($time, " << Test 5 IMAGE_HEIGHT 50 >>");

	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 5 enable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_01);
	$display($time, " << Test 5 AED CMD On >>");

	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 5 FSM Reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 5 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 5 SYS CMD 0 >>");

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 5 assert drv reset 1 >>");

	$display($time, " << Test 5 Wait time 3msec >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 5 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 5 AED 1 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 1 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 1 dark readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 5 SYS CMD 0 >>");

	$display($time, " << Test 5 Wait time 1msec >>");
	#1000000; // 1ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 5 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 expose , readout close >>");

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04); // get bright
	$display($time, " << Test 5 get AED 1 bright >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 1 bright expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 1 bright readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 5 SYS CMD 0 >>");

	$display($time, " << Test 5 Wait time 2msec >>");
	#2000000; // 2ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 5 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 5 get AED 2 dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 2 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 5 AED 2 dark readout complete >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << Test 5 panel stable start >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 5 SYS CMD 0 >>");
	$display($time, " << Test 5 complete >>");

	$display($time, " << Test 5 Wait time 2msec >>");
	#2000000;	//2msec

// #################################
//  Test 06
//  AED mode test , 
//	BackBias off , 
//	Flush off
//  PANEL Stable on 
// #################################
	$display($time, " << Test 6 , AED , BB off , Flush off , Panel stable on >>");

	$display($time, " << Test 6 1msec Wait start >>");
	#1000000;	//1msec
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 6 Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 6 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_00);
	$display($time, " << Test 6 Back Bias 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 6 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_01);
	$display($time, " << Test 6 Saturation Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_01);
	$display($time, " << Test 6 AED CMD On >>");
	// 50 line for AED test
	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd50);
	$display($time, " << Test 6 IMAGE_HEIGHT 50 >>");

	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_02); // test pattern , bit4: row bit3: col
	$display($time, " << Test 6 enable panel stable >>");

	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 6 FSM Reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 6 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 6 SYS CMD 0 >>");

	// wait (test_bench.uut.drv_rst);
	// $display($time, " << Test 6 assert drv reset 1 >>");

	$display($time, " << Test 6 Wait time 3msec >>");
	#3000000;	// 3msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 6 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 6 AED 1 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 1 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 1 dark readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 6 SYS CMD 0 >>");

	$display($time, " << Test 6 Wait time 1msec >>");
	#1000000; // 1ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 6 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 expose , readout close >>");

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04); // get bright
	$display($time, " << Test 6 AED 1 get bright >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 1 bright expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 1 bright readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 6 SYS CMD 0 >>");

	$display($time, " << Test 6 Wait time 2msec >>");
	#2000000; // 2ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 6 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 6 AED 2 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 2 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 6 AED 2 dark readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 6 SYS CMD 0 >>");
	$display($time, " << Test 6 complete >>");

	$display($time, " << Test 6 Wait time 2msec >>");
	#2000000;	//2msec


// #################################
//  Test 07
//  AED mode test , 
//	BackBias off , 
//	Flush off
//  PANEL Stable off 
// #################################
	$display($time, " << Test 7 , AED , BB off , Flush off , Panel stable off >>");

	$display($time, " << Test 7 1msec Wait start >>");
	#1000000;	//1msec

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 7 Read out Repeat  1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 7 READY AED READ 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_00);
	$display($time, " << Test 7 Back Bias 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 7 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_00);
	$display($time, " << Test 7 Saturation Repeat 0 >>");

	// 50 line for AED test
	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd50);
	$display($time, " << Test 7 IMAGE_HEIGHT 50 >>");

	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00); // test pattern , bit4: row bit3: col
	$display($time, " << Test 7 disable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_01);
	$display($time, " << Test 7 AED CMD On >>");

	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 7 FSM Reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 7 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 7 SYS CMD 0 >>");

	$display($time, " << Test 7 Wait time 5msec >>");
	#5000000;	// 5msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 7 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 7 AED 1 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 1 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 1 dark readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 7 SYS CMD 0 >>");

	$display($time, " << Test 7 Wait time 1msec >>");
	#1000000; // 1ms

	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04); // get bright
	$display($time, " << Test 7 AED 1 get bright >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 1 bright expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 1 bright readout complete >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 7 SYS CMD 0 >>");

	$display($time, " << Test 7 Wait time 2msec >>");
	#2000000; // 2ms

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 7 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 expose , readout close >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02); // get dark
	$display($time, " << Test 7 AED 2 get dark >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 2 dark expose start >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 7 AED 2 dark readout complete >>");

	// wait (test_bench.uut.U4.s_panel_stable_exist);
	// $display($time, " << Test 7 panel stable start >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 7 SYS CMD 0 >>");
	$display($time, " << Test 7 complete >>");

	$display($time, " << Test 7 Wait time 2msec >>");
	#2000000;	//2msec

// #################################
//  Test 10
//  Line mode test , 
//	BackBias on , 
//	Flush on
//  PANEL Stable off 
// #################################
	$display($time, " << Test 10 , Line , BB on , Flush on , Panel stable off >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_00);
	$display($time, " << Test 10 AED CMD Off>>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 10 Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 10 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
	$display($time, " << Test 10 Back Bias 1 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_02);
	$display($time, " << Test 10 FLUSH 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_01);
	$display($time, " << Test 10 Saturation Repeat  1 >>");

	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00); // test pattern , bit4: row bit3: col
	$display($time, " << Test 10 disable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	$display($time, " << Test 10 IMAGE_HEIGHT 10 >>");


	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 10 FSM reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 10 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 10 SYS CMD 0 , deassert >>");

	$display($time, " << Test 10 Wait time 1msec start >>");
	#1000000;	// 1msec 

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 10 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose , readout close >>");
	
	// #5000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);
	$display($time, " << Test 10 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose start 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 readout close 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);


	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_18); 
	$display($time, " << Test 10 set test pattern 0 >>");

	$display($time, " << Test 10 wait time 2msec start >>");
	#2000000;	//2msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 10 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose , readout close >>");
	
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
	$display($time, " << Test 10 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 readout close bright 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);

	$display($time, " << Test 10 1msec Wait start >>");
	#1000000;	// 1msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 10 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose , readout close >>");
	
	// #2000000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 10 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 10 readout close dark 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 10 complete >>");

	$display($time, " << Test 10 2msec Wait start >>");
	#2000000;	// 2msec

// #################################
//  Test 11
//  Line mode test , 
//	BackBias on , 
//	Flush off
//  PANEL Stable off 
// #################################
	$display($time, " << Test 11 , Line , BB on , Flush off , Flush on Panel stable off >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_AED_CMD, 16'h00_00);
	$display($time, " << Test 11 AED CMD Off>>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
	$display($time, " << Test 11 Read out Repeat  1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
	$display($time, " << Test 1 READY AED READ 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_02);
	$display($time, " << Test 11 Back Bias 2 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
	$display($time, " << Test 11 FLUSH 0 >>");
	#100;
	do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_01);
	$display($time, " << Test 11 Saturation Repeat  1 >>");

	#100;
	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00); // test pattern , bit4: row bit3: col
	$display($time, " << Test 11 disable panel stable >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
	$display($time, " << Test 11 MAGE_HEIGHT 10 >>");


	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
	$display($time, " << Test 11 FSM reset >>");
	wait (test_bench.uut.FSM_rst_index);
	$display($time, " << Test 11 FSM rst start >>");
	#100000;	//100usec
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 11 SYS CMD 0 >>");

	$display($time, " << Test 11 Wait time 2msec start >>");
	#2000000;	// 2msec 

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	// #5000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);
	$display($time, " << Test 11 get dark 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);


	// burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
	#100;
	do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_18); 
	$display($time, " << Test 11 set test pattern 0 >>");

	$display($time, " << Test 11 wait time 2msec start >>");
	#2000000;	//2msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
	$display($time, " << Test 11 get bright 1 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start bright 1 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close bright 1 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);

	$display($time, " << Test 11 1msec Wait start >>");
	#1000000;	// 1msec

	wait (!test_bench.uut.U4.s_panel_stable_exist);
	$display($time, " << Test 11 panel stable close >>");
	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose , readout close >>");
	
	// #2000000;
	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
	$display($time, " << Test 11 get dark 2 >>");

	wait (test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 expose start dark 2 >>");

	wait (!test_bench.uut.U4.s_exp_read_exist);
	$display($time, " << Test 11 readout close dark 2 >>");

	#100;
	do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
	$display($time, " << Test 11 complete >>");

	$display($time, " << Test 11 2msec Wait start >>");
	#2000000;	// 2msec


	$display($time, " << Wait time 15msec start >>");
	#15000000;	// 15msec
	$display($time, " << simulation stop >>");

	$stop;

	end

	logic 					m_SCLK;
	logic 					m_MOSI;
	logic 					m_MISO;
	logic [2:0]				m_CS;


	top uut(
		.nRST						(nRST					),
		.MCLK_50M_p					(MCLK_50M_p				),
		.MCLK_50M_n					(MCLK_50M_n				),
		.mipi_phy_if_clk_hs_p		(mipi_phy_if_clk_hs_p	),
		.mipi_phy_if_clk_hs_n		(mipi_phy_if_clk_hs_n	),
		.mipi_phy_if_clk_lp_p		(mipi_phy_if_clk_lp_p	),
		.mipi_phy_if_clk_lp_n		(mipi_phy_if_clk_lp_n	),
		.mipi_phy_if_data_hs_p		(mipi_phy_if_data_hs_p	),
		.mipi_phy_if_data_hs_n		(mipi_phy_if_data_hs_n	),
		.mipi_phy_if_data_lp_p		(mipi_phy_if_data_lp_p	),
		.mipi_phy_if_data_lp_n		(mipi_phy_if_data_lp_n	),
		.SCLK						(m_SCLK					),
		.SSB						(m_CS[0]				),
		.MOSI						(m_MOSI					),
		.MISO						(m_MISO					),
		.ROIC_RESET_R 				(ROIC_RESET_R 			),
		.ROIC_SYNC_R  				(ROIC_SYNC_R  			),
		.ROIC_ACLK_R  				(ROIC_ACLK_R  			),
		// .ROIC_RESET_L 				(ROIC_RESET_L 			),
		// .ROIC_SYNC_L  				(ROIC_SYNC_L  			),
		// .ROIC_ACLK_L  				(ROIC_ACLK_L  			),
		.DCLK_R        				(DCLK_R        			),
		.R_ROIC_DCLKo_p				(R_ROIC_DCLKo_p			),
		.R_ROIC_DCLKo_n				(R_ROIC_DCLKo_n			),
		.R_DOUTA_H					(R_DOUTA_H				),
		.R_DOUTA_L					(R_DOUTA_L				),
		.R_DOUTB_H					(R_DOUTB_H				),
		.R_DOUTB_L					(R_DOUTB_L				),
		// .DCLK_L        				(DCLK_L        			),
		// .L_ROIC_DCLKo_p				(L_ROIC_DCLKo_p			),
		// .L_ROIC_DCLKo_n				(L_ROIC_DCLKo_n			),
		// .L_DOUTA_H					(L_DOUTA_H				),
		// .L_DOUTA_L					(L_DOUTA_L				),
		// .L_DOUTB_H					(L_DOUTB_H				),
		// .L_DOUTB_L					(L_DOUTB_L				),
		// .STV_SEL_L1  				(STV_SEL_L1  			),
		// .STV_SEL_R1  				(STV_SEL_R1  			),
		// .STV_SEL_L2  				(STV_SEL_L2  			),
		// .STV_SEL_R2  				(STV_SEL_R2  			),
		// .STV_SEL_H  				(STV_SEL_H  			),
		.GF_STV_L   				(GF_STV_L   			),
		.GF_STV_LR2 				(GF_STV_LR2 			),
		.GF_STV_LR3 				(GF_STV_LR3 			),
		.GF_STV_LR4 				(GF_STV_LR4 			),
		.GF_STV_LR5 				(GF_STV_LR5 			),
		.GF_STV_LR6 				(GF_STV_LR6 			),
		.GF_STV_LR7 				(GF_STV_LR7 			),
		.GF_STV_LR8 				(GF_STV_LR8 			),
		.GF_STV_R   				(GF_STV_R   			),
		.GF_CPV    					(GF_CPV    				),
		.GF_OE	   					(GF_OE	   				),
		// .GF_LR1						(GF_LR1					),
		// .GF_LR2						(GF_LR2					),
		// .GF_CS1						(GF_CS1					),
		// .GF_CS2						(GF_CS2					),
		.GF_XAO_1					(GF_XAO_1				),
		.GF_XAO_2					(GF_XAO_2				),
		.GF_XAO_3					(GF_XAO_3				),
		.GF_XAO_4					(GF_XAO_4				),
		.GF_XAO_5					(GF_XAO_5				),
		.GF_XAO_6					(GF_XAO_6				),
		.GF_XAO_7					(GF_XAO_7				),
		.GF_XAO_8					(GF_XAO_8				),
		// .eim_clk_in  				(eim_clk_in  			),
		.R_SW_BIAS   				(R_SW_BIAS   			),
		// .L_SW_BIAS   				(L_SW_BIAS   			),
		.RF_SPI_CS_1 				(RF_SPI_CS_1 			),
		// .RF_SPI_CS_2 				(RF_SPI_CS_2 			),
		.RF_SPI_SCK_1				(RF_SPI_SCK_1			),
		.RF_SPI_SDI_1				(RF_SPI_SDI_1			),
		.RF_SPI_SDO_1				(RF_SPI_SDO_1			),
		// .RF_SPI_SCK_2				(RF_SPI_SCK_2			),
		// .RF_SPI_SDI_2				(RF_SPI_SDI_2			),
		// .RF_SPI_SDO_2				(RF_SPI_SDO_2			),
		// .pwr_bbv     				(pwr_bbv     			),
		.R_SW_AVDDI					(R_SW_AVDDI				),
		// .L_SW_AVDDI					(L_SW_AVDDI				),
		.prep_req         			(prep_req         		),
		.exp_req          			(exp_req          		),
		.prep_ack         			(prep_ack         		),
		.exp_ack          			(exp_ack          		),
		// .cancel_req       			(cancel_req       		),
		// .F_SPARE_00        			(led_0            		),
		// .F_SPARE_01      			(led_1            		),
		// .F_SPARE_02        			(led_2            		),
		// .F_SPARE_03        			(led_3            		),
		// .F_SPARE_04        			(led_4            		),
		// .F_SPARE_05        			(led_5            		),
		// .F_SPARE_06        			(led_6            		),
		.STATE_LED1       			(            			),
		.STATE_LED2       			(led_7            		)
	);

	assign		R_DOUTA_L =  ~R_DOUTA_H;
	assign		R_DOUTB_L =  ~R_DOUTB_H;
	
	// assign		L_DOUTA_L =  ~L_DOUTA_H;
	// assign		L_DOUTB_L =  ~L_DOUTB_H;
	
	assign		R_ROIC_DCLKo_n =  ~R_ROIC_DCLKo_p;
	// assign		L_ROIC_DCLKo_n =  ~L_ROIC_DCLKo_p;


	roic_model u_roic_model_R
		(
			.roic_sync				(ROIC_SYNC_R			),
			.roic_data_clk			(roic_data_clk			),
			.dclk					(DCLK_R					),
			.led_4					(test_bench.uut.FSM_aed_read_index					),
			.led_5					(test_bench.uut.FSM_read_index),

			.dclk_out0				(R_ROIC_DCLKo_p[0] 	),
			.dclk_out1				(R_ROIC_DCLKo_p[1] 	),
			.dclk_out2				(R_ROIC_DCLKo_p[2] 	),
			.dclk_out3				(R_ROIC_DCLKo_p[3] 	),
			.dclk_out4				(R_ROIC_DCLKo_p[4] 	),
			.dclk_out5				(R_ROIC_DCLKo_p[5] 	),
			.dclk_out6				(R_ROIC_DCLKo_p[6] 	),
			.dclk_out7				(R_ROIC_DCLKo_p[7] 	),
			.dclk_out8				(R_ROIC_DCLKo_p[8] 	),
			.dclk_out9				(R_ROIC_DCLKo_p[9] 	),
			.dclk_out10				(R_ROIC_DCLKo_p[10]	),
			.dclk_out11				(R_ROIC_DCLKo_p[11]	),

			.douta0					(R_DOUTA_H[0]      	),
			.douta1					(R_DOUTA_H[1]      	),
			.douta2					(R_DOUTA_H[2]      	),
			.douta3					(R_DOUTA_H[3]      	),
			.douta4					(R_DOUTA_H[4]      	),
			.douta5					(R_DOUTA_H[5]      	),
			.douta6					(R_DOUTA_H[6]      	),
			.douta7					(R_DOUTA_H[7]      	),
			.douta8					(R_DOUTA_H[8]      	),
			.douta9					(R_DOUTA_H[9]      	),
			.douta10				(R_DOUTA_H[10]     	),
			.douta11				(R_DOUTA_H[11]     	),

			.doutb0					(R_DOUTB_H[0]      	),
			.doutb1					(R_DOUTB_H[1]      	),
			.doutb2					(R_DOUTB_H[2]      	),
			.doutb3					(R_DOUTB_H[3]      	),
			.doutb4					(R_DOUTB_H[4]      	),
			.doutb5					(R_DOUTB_H[5]      	),
			.doutb6					(R_DOUTB_H[6]      	),
			.doutb7					(R_DOUTB_H[7]      	),
			.doutb8					(R_DOUTB_H[8]      	),
			.doutb9					(R_DOUTB_H[9]      	),
			.doutb10				(R_DOUTB_H[10]     	),
			.doutb11				(R_DOUTB_H[11]     	)
		);

	// roic_model u_roic_model_L
	// 	(
	// 		.roic_sync				(ROIC_SYNC_L				),
	// 		.roic_data_clk			(roic_data_clk			),
	// 		.dclk					(DCLK_L					),
	// 		.led_4					(led_3					),
	// 		.led_5					(led_5					),

	// 		.dclk_out0				(L_ROIC_DCLKo_p[0] 	),
	// 		.dclk_out1				(L_ROIC_DCLKo_p[1] 	),
	// 		.dclk_out2				(L_ROIC_DCLKo_p[2] 	),
	// 		.dclk_out3				(L_ROIC_DCLKo_p[3] 	),
	// 		.dclk_out4				(L_ROIC_DCLKo_p[4] 	),
	// 		.dclk_out5				(L_ROIC_DCLKo_p[5] 	),
	// 		.dclk_out6				(L_ROIC_DCLKo_p[6] 	),
	// 		.dclk_out7				(L_ROIC_DCLKo_p[7] 	),
	// 		.dclk_out8				(L_ROIC_DCLKo_p[8] 	),
	// 		.dclk_out9				(L_ROIC_DCLKo_p[9] 	),
	// 		.dclk_out10				(L_ROIC_DCLKo_p[10]	),
	// 		.dclk_out11				(L_ROIC_DCLKo_p[11]	),

	// 		.douta0					(L_DOUTA_H[0]      	),
	// 		.douta1					(L_DOUTA_H[1]      	),
	// 		.douta2					(L_DOUTA_H[2]      	),
	// 		.douta3					(L_DOUTA_H[3]      	),
	// 		.douta4					(L_DOUTA_H[4]      	),
	// 		.douta5					(L_DOUTA_H[5]      	),
	// 		.douta6					(L_DOUTA_H[6]      	),
	// 		.douta7					(L_DOUTA_H[7]      	),
	// 		.douta8					(L_DOUTA_H[8]      	),
	// 		.douta9					(L_DOUTA_H[9]      	),
	// 		.douta10				(L_DOUTA_H[10]     	),
	// 		.douta11				(L_DOUTA_H[11]     	),

	// 		.doutb0					(L_DOUTB_H[0]      	),
	// 		.doutb1					(L_DOUTB_H[1]      	),
	// 		.doutb2					(L_DOUTB_H[2]      	),
	// 		.doutb3					(L_DOUTB_H[3]      	),
	// 		.doutb4					(L_DOUTB_H[4]      	),
	// 		.doutb5					(L_DOUTB_H[5]      	),
	// 		.doutb6					(L_DOUTB_H[6]      	),
	// 		.doutb7					(L_DOUTB_H[7]      	),
	// 		.doutb8					(L_DOUTB_H[8]      	),
	// 		.doutb9					(L_DOUTB_H[9]      	),
	// 		.doutb10				(L_DOUTB_H[10]     	),
	// 		.doutb11				(L_DOUTB_H[11]     	)
	// 	);



// mipi csi2 Rx module
	reg					clk_100MHz			;
	assign clk_100MHz = roic_data_clk;

mipi_csi2_rx_wrapper ex_mipi_csi2_rx
  (
    .clk_100MHz                 (clk_100MHz),
    .done                       (),
    .done_1                     (),
    .mipi_phy_if_0_clk_hs_p     (mipi_phy_if_clk_hs_p),
    .mipi_phy_if_0_clk_hs_n     (mipi_phy_if_clk_hs_n),
    .mipi_phy_if_0_clk_lp_p     (mipi_phy_if_clk_lp_p),
    .mipi_phy_if_0_clk_lp_n     (mipi_phy_if_clk_lp_n),
    .mipi_phy_if_0_data_hs_p    (mipi_phy_if_data_hs_p),
    .mipi_phy_if_0_data_hs_n    (mipi_phy_if_data_hs_n),
    .mipi_phy_if_0_data_lp_p    (mipi_phy_if_data_lp_p),
    .mipi_phy_if_0_data_lp_n    (mipi_phy_if_data_lp_n),
    .reset_rtl_0                (reset),
    .rxbyteclkhs                (),
    .status                     (),
    .status_1                   (),
    .video_out_tdata            (),
    .video_out_tdest            (),
    .video_out_tlast            (),
    .video_out_tvalid           ()
    );
    

	// spi master task
	localparam header   = 2;		// size of header , wr:rd 2bit
	localparam payload  = 16;       // size of payload or data size
	localparam addrsz   = 14;		// size of SPI Address Space
	localparam pktsz    = header + addrsz + payload;		// size of SPI packet

		
	logic 					m_start = 1'b0;
	logic [1:0] 			slaveselect = 2'b00;
	logic [header-1:0] 		masterHeader;
	logic [addrsz-1:0]  	masterAddrToSend;
	logic [payload-1:0]  	masterDataToSend;
	logic [payload-1:0] 	masterDataReceived;

	spi_master #(
		.pktsz   		( pktsz ),
		.header  		( header ),
		.payload 		( payload ),
		.addrsz  		( addrsz )
		)
	spi_master_inst  (
		.clk     			(MCLK_50M_p),
		.reset 				(reset),
		.start				(m_start),
		.slaveselect		(slaveselect),
		.masterHeader 		(masterHeader),
		.masterAddrToSend	(masterAddrToSend),
		.masterDataToSend	(masterDataToSend),

		.masterDataReceived	(masterDataReceived),
		.SCLK	   			(m_SCLK),
		.CS					(m_CS),
		.MOSI				(m_MOSI),
		.MISO				(m_MISO)
		);


// task module
    task rst();
        begin
            reset = 1'b1;
            #50;
            reset = 1'b0;
        end
    endtask

// spi task

	task do_mspi_write;
		input [header-1:0] 	from_header;
		// input [addrsz-1:0] 	from_addr;
		input [16-1:0] 	from_addr;
		input [payload-1:0] from_data;

		int i;

		begin
			@(posedge m_sclk_in);
				// #(sclk_period) m_start =1'b0;
				masterHeader = from_header;
				masterAddrToSend = from_addr[addrsz-1:0];
				masterDataToSend = from_data;
				#1;
				#(sclk_period) m_start =1'b1;
				#(sclk_period) m_start =1'b0;
		end

		for (i=0;i<pktsz;i++)
			begin
				#(sclk_period);
			end

	endtask

	task do_mspi_read;
		input [header-1:0] 	from_header;
		// input [addrsz-1:0] 	from_addr;
		input [16-1:0] 	from_addr;
		
		int i;
		
		begin
			@(posedge m_sclk_in);
				// #(sclk_period) m_start =1'b0;
				masterHeader = from_header;
				masterAddrToSend = from_addr[addrsz-1:0];
				#1;
				#(sclk_period) m_start =1'b1;
				#(sclk_period) m_start =1'b0;
		end

		for (i=0;i<pktsz;i++)
			begin
				#(sclk_period);
			end

	endtask

	// FSM test task
	task fsm_test_task;
		input test_no;	
		input [15:0] aed_cmd;

		// input [header-1:0] 	from_header;
		// // input [addrsz-1:0] 	from_addr;
		// input [16-1:0] 	from_addr;
		// input [payload-1:0] from_data;

		// int i;

		begin
			$display($time, " << Test %d Start >>" , test_no);
			
			#100;
			do_mspi_write(2'b10 , `ADDR_AED_CMD, aed_cmd);
			$display($time, " << Test %d AED CMD Off>>" , test_no);

			// #100;
			// do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'h00_01);
			// $display($time, " << Test 11 Read out Repeat  1 >>");

			// #100;
			// do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_02);
			// $display($time, " << Test 4 READY AED READ 2 >>");
			// #100;
			// do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_02);
			// $display($time, " << Test 11 Back Bias 2 >>");
			// #100;
			// do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_00);
			// $display($time, " << Test 11 FLUSH 0 >>");
			// #100;
			// do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_01);
			// $display($time, " << Test 11 Saturation Repeat  1 >>");

			// #100;
			// // burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
			// do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_00); // test pattern , bit4: row bit3: col
			// $display($time, " << Test 11 disable panel stable >>");

			// #100;
			// do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
			// $display($time, " << Test 11 MAGE_HEIGHT 10 >>");


			// #100000;	//100usec
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);	//fsm reset
			// $display($time, " << Test 11 FSM reset >>");
			// wait (test_bench.uut.FSM_rst_index);
			// $display($time, " << Test 11 FSM rst start >>");
			// #100000;	//100usec
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
			// $display($time, " << Test 11 SYS CMD 0 >>");

			// $display($time, " << Test 11 Wait time 1msec start >>");
			// #1000000;	// 1msec 

			// wait (!test_bench.uut.U4.s_panel_stable_exist);
			// $display($time, " << Test 11 panel stable close >>");
			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose , readout close >>");
			
			// // #5000;
			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);
			// $display($time, " << Test 11 get dark 1 >>");

			// wait (test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose start 1 >>");

			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 readout close 1 >>");

			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);


			// // burst_get[8] , test pattern row[4] col[3], en_panel_stable[1] , en_full_flush[0]
			// #100;
			// do_mspi_write(2'b10 , `ADDR_OP_MODE_REG, 16'h00_18); 
			// $display($time, " << Test 11 set test pattern 0 >>");

			// $display($time, " << Test 11 wait time 2msec start >>");
			// #2000000;	//2msec

			// wait (!test_bench.uut.U4.s_panel_stable_exist);
			// $display($time, " << Test 11 panel stable close >>");
			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose , readout close >>");
			
			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_04);  // get bright
			// $display($time, " << Test 11 get bright 1 >>");

			// wait (test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose start bright 1 >>");

			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 readout close bright 1 >>");

			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);

			// $display($time, " << Test 11 1msec Wait start >>");
			// #1000000;	// 1msec

			// wait (!test_bench.uut.U4.s_panel_stable_exist);
			// $display($time, " << Test 11 panel stable close >>");
			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose , readout close >>");
			
			// // #2000000;
			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_02);	// get dark
			// $display($time, " << Test 11 get dark 2 >>");

			// wait (test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 expose start dark 2 >>");

			// wait (!test_bench.uut.U4.s_exp_read_exist);
			// $display($time, " << Test 11 readout close dark 2 >>");

			// #100;
			// do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
			// $display($time, " << Test 11 complete >>");
		end
	endtask


endmodule

