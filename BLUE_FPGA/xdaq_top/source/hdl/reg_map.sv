// ---------------------------------------------------------------------------------
//   Title      :  Register Map Module
//              :
//   Purpose    :  Writing the synthesisable verilog RTL code for
//              :  the Register Map Module
//              :
//   Designer   :  Kihyun Kim  (kkh@abyzr.com)
//				:  drake.lee 	(holee9@gmail.com)
//              :
//   Company    :  H&abyz Inc.
//              :
//
// ---------------------------------------------------------------------------------
//   Modification history : 
//
//   version:   |   mod. date:  |   changes made:
//      v0.0        02/11/2022      initial release
//      v0.1		15/04/2024		for CSI2 interface test
//
// ---------------------------------------------------------------------------------
//  Descripitions   :
//
//
//
//
// ---------------------------------------------------------------------------------
`include	"./p_define.sv"
`timescale 1ns/1ps

module reg_map(
	eim_clk						, //i, 66MHz
	eim_rst						, //i

	fsm_clk						, //i, 25MHz
	rst							, //i

	sys_clk						, //i, 100MHz, To read the ROIC register value
	sys_rst						, //i

	prep_req						, //i
	exp_req						, //i

	row_cnt						, //i, [15:0]
	col_cnt						, //i, [15:0]

	row_end						, //i

	fsm_rst_index				, //i
	fsm_init_index				, //i
	fsm_back_bias_index			, //i
	fsm_flush_index				, //i
	fsm_aed_read_index			, //i
	fsm_exp_index				, //i
	fsm_read_index				, //i

	//i2c
	gate_gpio_data				,  //240703 data����
    ///// 

	ready_to_get_image			, //i
	valid_aed_read_skip			, //i
	aed_ready_done				, //i

	panel_stable_exist			, //i
	exp_read_exist				, //i


	ack_tx_end					, //i

	up_roic_reg					, //i

	roic_temperature			, //i, [15:0]
	roic_reg_in_a				, //i, [63:0]
	roic_reg_in_b				, //i, [63:0]

	l_roic_temperature			, //i, [15:0]
	l_roic_reg_in_a				, //i, [63:0]
	l_roic_reg_in_b				, //i, [63:0]

	reg_read_index				, //i

	reg_addr					, //i, [15:0]
	reg_data					, //i, [15:0]
	reg_addr_index				, //i
	reg_data_index				, //i
	// frame_count					, //i, [ 7:0]

	reg_read_out				, //o, [15:0]
	read_data_en				, //o,

	en_pwr_dwn					, //o
	en_pwr_off					, //o

	system_rst					, //o

	reset_fsm					, //o
	org_reset_fsm				, //o
	dummy_get_image				, //o
	exist_get_image				, //i
	burst_get_image				, //o
	get_dark					, //o
	get_bright					, //o
	cmd_get_bright				, //o

	en_aed						, //o

	aed_th						, //o, [15:0]
	nega_aed_th					, //o, [15:0]
	posi_aed_th					, //o, [15:0]
	sel_aed_roic				, //o, [15:0]
	num_trigger					, //o, [15:0]
	sel_aed_test_roic			, //o, [15:0]

	ready_aed_read				, //o, [15:0]
	aed_dark_delay				, //o,

	en_back_bias				, //o
	en_flush					, //o
	en_panel_stable				, //o

	cycle_width					, //o, [23:0]
	mux_image_height			, //o, [15:0]
	dsp_image_height			, //o, [15:0]
	aed_read_image_height		, //o, [15:0]
	frame_rpt					, //o, [ 7:0]
	saturation_flush_repeat		, //o, [ 7:0]
	readout_count				, //o, [15:0]
	max_v_count 				, //o, [15:0]
	max_h_count 				, //o, [15:0]
	csi2_word_count				, //o, [15:0]
	
	roic_burst_cycle			, //o, [15:0]
	start_roic_burst_clk		, //o, [15:0]
	end_roic_burst_clk			, //o, [15:0]

	gate_mode1					, //o
	gate_mode2					, //o

	gate_cs1					, //o
	gate_cs2					, //o

	gate_sel					, //o

	gate_ud						, //o

	gate_stv_mode				, //o

	gate_oepsn					, //o

	gate_lr1						, //o
	gate_lr2						, //o
	stv_sel_h						, //o
	stv_sel_l1						, //o
	stv_sel_r1						, //o
	stv_sel_l2						, //o
	stv_sel_r2						, //o

	up_back_bias				, //o, [15:0]
	dn_back_bias				, //o, [15:0]
	up_back_bias_opr			, //o, [15:0]
	dn_back_bias_opr			, //o, [15:0]

	up_gate_stv1				, //o, [15:0]
	dn_gate_stv1				, //o, [15:0]

	up_gate_stv2				, //o, [15:0]
	dn_gate_stv2				, //o, [15:0]

	up_gate_cpv1				, //o, [15:0]
	dn_gate_cpv1				, //o, [15:0]

	up_gate_cpv2				, //o, [15:0]
	dn_gate_cpv2				, //o, [15:0]

	up_gate_oe1					, //o, [15:0]
	dn_gate_oe1					, //o, [15:0]

	up_gate_oe2					, //o, [15:0]
	dn_gate_oe2					, //o, [15:0]
	// differ
	dn_aed_gate_xao_0			, //o, [15:0] 
	dn_aed_gate_xao_1			, //o, [15:0] 
	dn_aed_gate_xao_2			, //o, [15:0] 
	dn_aed_gate_xao_3			, //o, [15:0] 
	dn_aed_gate_xao_4			, //o, [15:0] 
	dn_aed_gate_xao_5			, //o, [15:0] 
	up_aed_gate_xao_0			, //o, [15:0] 
	up_aed_gate_xao_1			, //o, [15:0] 
	up_aed_gate_xao_2			, //o, [15:0] 
	up_aed_gate_xao_3			, //o, [15:0] 
	up_aed_gate_xao_4			, //o, [15:0] 
	up_aed_gate_xao_5			, //o, [15:0] 
	aed_detect_line_0			, //o, [15:0]
	aed_detect_line_1			, //o, [15:0]
	aed_detect_line_2			, //o, [15:0]
	aed_detect_line_3			, //o, [15:0]
	aed_detect_line_4			, //o, [15:0]
	aed_detect_line_5			, //o, [15:0]

	up_roic_sync				, //o. [15:0]

	up_roic_aclk_0				, //o, [15:0]
	up_roic_aclk_1				, //o, [15:0]
	up_roic_aclk_2				, //o, [15:0]
	up_roic_aclk_3				, //o, [15:0]
	up_roic_aclk_4				, //o, [15:0]
	up_roic_aclk_5				, //o, [15:0]
	up_roic_aclk_6				, //o, [15:0]
	up_roic_aclk_7				, //o, [15:0]
	up_roic_aclk_8				, //o, [15:0]
	up_roic_aclk_9				, //o, [15:0]
	up_roic_aclk_10				, //o, [15:0]

	burst_break_pt_0			, //o, [15:0]
	burst_break_pt_1			, //o, [15:0]
	burst_break_pt_2			, //o, [15:0]
	burst_break_pt_3			, //o, [15:0]

	roic_reg_set_0 				, //o, [15:0]
	roic_reg_set_1 				, //o, [15:0]
	roic_reg_set_1_dual 		, //o, [15:0]
	roic_reg_set_2 				, //o, [15:0]
	roic_reg_set_3 				, //o, [15:0]
	roic_reg_set_4 				, //o, [15:0]
	roic_reg_set_5 				, //o, [15:0]
	roic_reg_set_6 				, //o, [15:0]
	roic_reg_set_7 				, //o, [15:0]
	roic_reg_set_8 				, //o, [15:0]
	roic_reg_set_9 				, //o, [15:0]
	roic_reg_set_10				, //o, [15:0]
	roic_reg_set_11				, //o, [15:0]
	roic_reg_set_12				, //o, [15:0]
	roic_reg_set_13				, //o, [15:0]
	roic_reg_set_14				, //o, [15:0]
	roic_reg_set_15				, //o, [15:0]

	ld_io_delay_tab				, //o, 
	io_delay_tab				, //o, [ 4:0]
	sel_roic_reg				, //o, [ 7:0]

	gate_size					, //o, [15:0]

	en_16bit_adc				, //o

	en_test_pattern_col			, //o
	en_test_pattern_row			, //o

	en_test_roic_col			, //o
	en_test_roic_row			, //o

	aed_test_mode1				, //o
	aed_test_mode2				, //o

	exp_ack						  //o
);

//----------------------------------------
//----------------------------------------
    //i2c
	output          [15:0]  gate_gpio_data              ;  //240703 data����
    /////
	input					eim_clk						; //i, 66MHz
	input					eim_rst						; //i
	input					fsm_clk						; //i, 25MHz
	input					rst							; //i
	input					sys_clk						; //i, 100MHz, To read the ROIC register value
	input					sys_rst						; //i

	input					prep_req						; //i
	input					exp_req						; //i
	input			[15:0]	row_cnt						; //i, [15:0]
	input			[15:0]	col_cnt						; //i, [15:0]
	input					row_end						; //i
	input					fsm_rst_index				; //i
	input					fsm_init_index				; //i
	input					fsm_back_bias_index			; //i
	input					fsm_flush_index				; //i
	input					fsm_aed_read_index			; //i
	input					fsm_exp_index				; //i
	input					fsm_read_index				; //i
	input					ready_to_get_image			; //i
	input					valid_aed_read_skip			; //i
	input					aed_ready_done				; //i
	input					panel_stable_exist			; //i
	input					exp_read_exist				; //i
	input					ack_tx_end					; //i
	input					up_roic_reg					; //i
	input			[15:0]	roic_temperature			; //i, [15:0]
	input			[63:0]	roic_reg_in_a				; //i, [63:0]
	input			[63:0]	roic_reg_in_b				; //i, [63:0]
	input			[15:0]	l_roic_temperature			; //i, [15:0]
	input			[63:0]	l_roic_reg_in_a				; //i, [63:0]
	input			[63:0]	l_roic_reg_in_b				; //i, [63:0]
	input					reg_read_index				; //i
	input			[15:0]	reg_addr					; //i, [15:0]
	input			[15:0]	reg_data					; //i, [15:0]
	input					reg_addr_index				; //i
	input					reg_data_index				; //i
	// input			[ 7:0]	frame_count					; //i, [ 7:0]

	output	reg		[15:0]	reg_read_out				; //o, [15:0]
	output  logic			read_data_en				; //o,
	output	wire			en_pwr_dwn					; //o
	output	wire			en_pwr_off					; //o
	output	wire			system_rst					; //o
	output	reg				reset_fsm					; //o
	output	wire			org_reset_fsm				; //o
	output	wire			dummy_get_image				; //o
	input					exist_get_image				; //i
	output	wire			burst_get_image				; //o
	output	wire			get_dark					; //o
	output	wire			get_bright					; //o
	output	wire			cmd_get_bright				; //o
	output	wire			en_aed						; //o
	output	reg		[15:0]	aed_th						; //o, [15:0]
	output	reg		[15:0]	nega_aed_th					; //o, [15:0]
	output	reg		[15:0]	posi_aed_th					; //o, [15:0]
	output	reg		[15:0]	sel_aed_roic				; //o, [15:0]
	output	reg		[15:0]	num_trigger					; //o, [15:0]
	output	reg		[15:0]	sel_aed_test_roic			; //o, [15:0]
	output	reg		[15:0]	ready_aed_read				; //o, [15:0]
	output	reg		[15:0]	aed_dark_delay				; //o,
	output	wire			en_back_bias				; //o
	output	wire			en_flush					; //o
	output	wire			en_panel_stable				; //o
	output	wire	[23:0]	cycle_width					; //o, [23:0]
	output	wire	[15:0]	mux_image_height			; //o, [15:0]
	output	reg		[15:0]	dsp_image_height			; //o, [15:0]
	output	wire	[15:0]	aed_read_image_height		; //o, [15:0]
	output	wire	[ 7:0]	frame_rpt					; //o, [ 7:0]
	output	wire	[ 7:0]	saturation_flush_repeat		; //o, [ 7:0]
	output	wire	[15:0]	readout_count				; //o, [15:0]
	output	logic	[15:0]	max_v_count					; //o, [15:0]
	output	logic	[15:0]	max_h_count					; //o, [15:0]
	output	logic	[15:0]	csi2_word_count				; //o, [15:0]
	output	reg		[15:0]	roic_burst_cycle			; //o, [15:0]
	output	reg		[15:0]	start_roic_burst_clk		; //o, [15:0]
	output	reg		[15:0]	end_roic_burst_clk			; //o, [15:0]
	output	wire			gate_mode1					; //o
	output	wire			gate_mode2					; //o
	output	wire			gate_cs1					; //o
	output	wire			gate_cs2					; //o
	output	wire			gate_sel					; //o
	output	wire			gate_ud						; //o
	output	wire			gate_stv_mode				; //o
	output	wire			gate_oepsn					; //o
	output	wire			gate_lr1						; //o
	output	wire			gate_lr2						; //o
	output	wire			stv_sel_h						; //o
	output	wire			stv_sel_l1						; //o
	output	wire			stv_sel_r1						; //o
	output	wire			stv_sel_l2						; //o
	output	wire			stv_sel_r2						; //o

	output	reg		[15:0]	up_back_bias				; //o, [15:0]
	output	reg		[15:0]	dn_back_bias				; //o, [15:0]
	output	reg		[15:0]	up_back_bias_opr			; //o, [15:0]
	output	reg		[15:0]	dn_back_bias_opr			; //o, [15:0]
	output	wire	[15:0]	up_gate_stv1				; //o, [15:0]
	output	wire	[15:0]	dn_gate_stv1				; //o, [15:0]
	output	wire	[15:0]	up_gate_stv2				; //o, [15:0]
	output	wire	[15:0]	dn_gate_stv2				; //o, [15:0]
	output	wire	[15:0]	up_gate_cpv1				; //o, [15:0]
	output	wire	[15:0]	dn_gate_cpv1				; //o, [15:0]
	output	wire	[15:0]	up_gate_cpv2				; //o, [15:0]
	output	wire	[15:0]	dn_gate_cpv2				; //o, [15:0]
	output	wire	[15:0]	up_gate_oe1					; //o, [15:0]
	output	wire	[15:0]	dn_gate_oe1					; //o, [15:0]
	output	wire	[15:0]	up_gate_oe2					; //o, [15:0]
	output	wire	[15:0]	dn_gate_oe2					; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_0			; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_1			; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_2			; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_3			; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_4			; //o, [15:0]
	output	reg		[15:0]	dn_aed_gate_xao_5			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_0			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_1			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_2			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_3			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_4			; //o, [15:0]
	output	reg		[15:0]	up_aed_gate_xao_5			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_0			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_1			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_2			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_3			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_4			; //o, [15:0]
	output	reg		[15:0]	aed_detect_line_5			; //o, [15:0]

	output	reg		[15:0]	up_roic_sync				; //o. [15:0]
	output	wire	[15:0]	up_roic_aclk_0				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_1				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_2				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_3				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_4				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_5				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_6				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_7				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_8				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_9				; //o, [15:0]
	output	wire	[15:0]	up_roic_aclk_10				; //o, [15:0]
	output	reg		[15:0]	burst_break_pt_0			; //o, [15:0]
	output	reg		[15:0]	burst_break_pt_1			; //o, [15:0]
	output	reg		[15:0]	burst_break_pt_2			; //o, [15:0]
	output	reg		[15:0]	burst_break_pt_3			; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_0 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_1 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_1_dual			; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_2 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_3 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_4 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_5 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_6 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_7 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_8 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_9 				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_10				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_11				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_12				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_13				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_14				; //o, [15:0]
	output	reg		[15:0]	roic_reg_set_15				; //o, [15:0]
	output	wire			ld_io_delay_tab				; //o, 
	output	wire	[ 4:0]	io_delay_tab				; //o, [ 4:0]
	output	wire	[ 7:0]	sel_roic_reg				; //o, [ 7:0]
	output	reg		[15:0]	gate_size					; //o, [15:0]
	output	wire			en_16bit_adc				; //o
	output	wire			en_test_pattern_col			; //o
	output	wire			en_test_pattern_row			; //o
	output	wire			en_test_roic_col			; //o
	output	wire			en_test_roic_row			; //o
	output	wire			aed_test_mode1				; //o
	output	wire			aed_test_mode2				; //o
	output	reg				exp_ack						; //o

//----------------------------------------
//----------------------------------------

    reg             up_gate_gpio_reg            ;   //i2c
	reg				up_sys_cmd_reg				;
	reg				up_op_mode_reg				;
	reg				up_set_gate					;
	reg				up_gate_size				;
	reg				up_pwr_off_dwn				;
	reg				up_readout_count			;
	reg				up_expose_size				;
	reg				up_back_bias_size			;
	reg				up_image_height				;
	reg				up_max_v_count				;
	reg				up_max_h_count				;
	reg				up_csi2_word_count			;
	reg				up_cycle_width_flush		;
	reg				up_cycle_width_aed			;
	reg				up_cycle_width_read			;
	reg				up_repeat_back_bias			;
	reg				up_repeat_flush				;
	reg				up_saturation_flush_repeat	;
	reg				up_exp_delay				;
	reg				up_ready_delay				;
	reg				up_pre_delay				;
	reg				up_post_delay				;
	reg				up_up_back_bias				;
	reg				up_dn_back_bias				;
	reg				up_up_back_bias_opr			;
	reg				up_dn_back_bias_opr			;
	reg				up_up_gate_stv1_read		;
	reg				up_dn_gate_stv1_read		;
	reg				up_up_gate_stv2_read		;
	reg				up_dn_gate_stv2_read		;
	reg				up_up_gate_cpv1_read		;
	reg				up_dn_gate_cpv1_read		;
	reg				up_up_gate_cpv2_read		;
	reg				up_dn_gate_cpv2_read		;
	reg				up_dn_gate_oe1_read			;
	reg				up_up_gate_oe1_read			;
	reg				up_dn_gate_oe2_read			;
	reg				up_up_gate_oe2_read			;
	reg				up_up_gate_stv1_aed			;
	reg				up_dn_gate_stv1_aed			;
	reg				up_up_gate_stv2_aed			;
	reg				up_dn_gate_stv2_aed			;
	reg				up_up_gate_cpv1_aed			;
	reg				up_dn_gate_cpv1_aed			;
	reg				up_up_gate_cpv2_aed			;
	reg				up_dn_gate_cpv2_aed			;
	reg				up_dn_gate_oe1_aed			;
	reg				up_up_gate_oe1_aed			;
	reg				up_dn_gate_oe2_aed			;
	reg				up_up_gate_oe2_aed			;
	reg				up_up_gate_stv1_flush		;
	reg				up_dn_gate_stv1_flush		;
	reg				up_up_gate_stv2_flush		;
	reg				up_dn_gate_stv2_flush		;
	reg				up_up_gate_cpv1_flush		;
	reg				up_dn_gate_cpv1_flush		;
	reg				up_up_gate_cpv2_flush		;
	reg				up_dn_gate_cpv2_flush		;
	reg				up_dn_gate_oe1_flush		;
	reg				up_up_gate_oe1_flush		;
	reg				up_dn_gate_oe2_flush		;
	reg				up_up_gate_oe2_flush		;
	reg				up_up_roic_sync				;
	reg				up_up_roic_aclk_0_read		;
	reg				up_up_roic_aclk_1_read		;
	reg				up_up_roic_aclk_2_read		;
	reg				up_up_roic_aclk_3_read		;
	reg				up_up_roic_aclk_4_read		;
	reg				up_up_roic_aclk_5_read		;
	reg				up_up_roic_aclk_6_read		;
	reg				up_up_roic_aclk_7_read		;
	reg				up_up_roic_aclk_8_read		;
	reg				up_up_roic_aclk_9_read		;
	reg				up_up_roic_aclk_10_read		;
	reg				up_up_roic_aclk_0_aed		;
	reg				up_up_roic_aclk_1_aed		;
	reg				up_up_roic_aclk_2_aed		;
	reg				up_up_roic_aclk_3_aed		;
	reg				up_up_roic_aclk_4_aed		;
	reg				up_up_roic_aclk_5_aed		;
	reg				up_up_roic_aclk_6_aed		;
	reg				up_up_roic_aclk_7_aed		;
	reg				up_up_roic_aclk_8_aed		;
	reg				up_up_roic_aclk_9_aed		;
	reg				up_up_roic_aclk_10_aed		;
	reg				up_up_roic_aclk_0_flush		;
	reg				up_up_roic_aclk_1_flush		;
	reg				up_up_roic_aclk_2_flush		;
	reg				up_up_roic_aclk_3_flush		;
	reg				up_up_roic_aclk_4_flush		;
	reg				up_up_roic_aclk_5_flush		;
	reg				up_up_roic_aclk_6_flush		;
	reg				up_up_roic_aclk_7_flush		;
	reg				up_up_roic_aclk_8_flush		;
	reg				up_up_roic_aclk_9_flush		;
	reg				up_up_roic_aclk_10_flush	;
	reg				up_roic_reg_set_0			;
	reg				up_roic_reg_set_1			;
	reg				up_roic_reg_set_1_dual		;
	reg				up_roic_reg_set_2			;
	reg				up_roic_reg_set_3			;
	reg				up_roic_reg_set_4			;
	reg				up_roic_reg_set_5			;
	reg				up_roic_reg_set_6			;
	reg				up_roic_reg_set_7			;
	reg				up_roic_reg_set_8			;
	reg				up_roic_reg_set_9			;
	reg				up_roic_reg_set_10			;
	reg				up_roic_reg_set_11			;
	reg				up_roic_reg_set_12			;
	reg				up_roic_reg_set_13			;
	reg				up_roic_reg_set_14			;
	reg				up_roic_reg_set_15			;
	reg				up_roic_burst_cycle			;
	reg				up_start_roic_burst_clk		;
	reg				up_end_roic_burst_clk		;
	reg				up_io_delay_tab				;
	reg				up_sel_roic_reg				;
	reg				up_dn_aed_gate_xao_0		;
	reg				up_dn_aed_gate_xao_1		;
	reg				up_dn_aed_gate_xao_2		;
	reg				up_dn_aed_gate_xao_3		;
	reg				up_dn_aed_gate_xao_4		;
	reg				up_dn_aed_gate_xao_5		;
	reg				up_up_aed_gate_xao_0		;
	reg				up_up_aed_gate_xao_1		;
	reg				up_up_aed_gate_xao_2		;
	reg				up_up_aed_gate_xao_3		;
	reg				up_up_aed_gate_xao_4		;
	reg				up_up_aed_gate_xao_5		;
	reg				up_ready_aed_read			;
	reg				up_aed_th					;
	reg				up_sel_aed_roic				;
	reg				up_num_trigger				;
	reg				up_sel_aed_test_roic		;
	reg				up_aed_cmd					;
	reg				up_nega_aed_th				;
	reg				up_posi_aed_th				;
	reg				up_aed_dark_delay			;
	reg				up_aed_detect_line_0		;
	reg				up_aed_detect_line_1		;
	reg				up_aed_detect_line_2		;
	reg				up_aed_detect_line_3		;
	reg				up_aed_detect_line_4		;
	reg				up_aed_detect_line_5		;

	logic			up_test_reg_9		;

    reg             dn_gate_gpio_reg            ; //i2c
	reg				dn_fsm_reg					;
	reg				dn_sys_cmd_reg				;
	reg				dn_op_mode_reg				;
	reg				dn_set_gate					;
	reg				dn_gate_size				;
	reg				dn_pwr_off_dwn				;
	reg				dn_readout_count			;
	reg				dn_expose_size				;
	reg				dn_back_bias_size			;
	reg				dn_image_height				;
	reg				dn_max_v_count				;
	reg				dn_max_h_count				;
	reg				dn_csi2_word_count			;
	reg				dn_cycle_width_flush		;
	reg				dn_cycle_width_aed			;
	reg				dn_cycle_width_read			;
	reg				dn_repeat_back_bias			;
	reg				dn_repeat_flush				;
	reg				dn_saturation_flush_repeat	;
	reg				dn_exp_delay				;
	reg				dn_ready_delay				;
	reg				dn_pre_delay				;
	reg				dn_post_delay				;
	reg				dn_io_delay_tab				;
	// reg				dn_frame_count				;
	reg				dn_up_back_bias				;
	reg				dn_dn_back_bias				;
	reg				dn_up_back_bias_opr			;
	reg				dn_dn_back_bias_opr			;
	reg				dn_up_gate_stv1_read		;
	reg				dn_dn_gate_stv1_read		;
	reg				dn_up_gate_stv2_read		;
	reg				dn_dn_gate_stv2_read		;
	reg				dn_up_gate_cpv1_read		;
	reg				dn_dn_gate_cpv1_read		;
	reg				dn_up_gate_cpv2_read		;
	reg				dn_dn_gate_cpv2_read		;
	reg				dn_dn_gate_oe1_read			;
	reg				dn_up_gate_oe1_read			;
	reg				dn_dn_gate_oe2_read			;
	reg				dn_up_gate_oe2_read			;
	reg				dn_up_gate_stv1_aed			;
	reg				dn_dn_gate_stv1_aed			;
	reg				dn_up_gate_stv2_aed			;
	reg				dn_dn_gate_stv2_aed			;
	reg				dn_up_gate_cpv1_aed			;
	reg				dn_dn_gate_cpv1_aed			;
	reg				dn_up_gate_cpv2_aed			;
	reg				dn_dn_gate_cpv2_aed			;
	reg				dn_dn_gate_oe1_aed			;
	reg				dn_up_gate_oe1_aed			;
	reg				dn_dn_gate_oe2_aed			;
	reg				dn_up_gate_oe2_aed			;
	reg				dn_up_gate_stv1_flush		;
	reg				dn_dn_gate_stv1_flush		;
	reg				dn_up_gate_stv2_flush		;
	reg				dn_dn_gate_stv2_flush		;
	reg				dn_up_gate_cpv1_flush		;
	reg				dn_dn_gate_cpv1_flush		;
	reg				dn_up_gate_cpv2_flush		;
	reg				dn_dn_gate_cpv2_flush		;
	reg				dn_dn_gate_oe1_flush		;
	reg				dn_up_gate_oe1_flush		;
	reg				dn_dn_gate_oe2_flush		;
	reg				dn_up_gate_oe2_flush		;
	reg				dn_up_roic_sync				;
	reg				dn_up_roic_aclk_0_read		;
	reg				dn_up_roic_aclk_1_read		;
	reg				dn_up_roic_aclk_2_read		;
	reg				dn_up_roic_aclk_3_read		;
	reg				dn_up_roic_aclk_4_read		;
	reg				dn_up_roic_aclk_5_read		;
	reg				dn_up_roic_aclk_6_read		;
	reg				dn_up_roic_aclk_7_read		;
	reg				dn_up_roic_aclk_8_read		;
	reg				dn_up_roic_aclk_9_read		;
	reg				dn_up_roic_aclk_10_read		;
	reg				dn_up_roic_aclk_0_aed		;
	reg				dn_up_roic_aclk_1_aed		;
	reg				dn_up_roic_aclk_2_aed		;
	reg				dn_up_roic_aclk_3_aed		;
	reg				dn_up_roic_aclk_4_aed		;
	reg				dn_up_roic_aclk_5_aed		;
	reg				dn_up_roic_aclk_6_aed		;
	reg				dn_up_roic_aclk_7_aed		;
	reg				dn_up_roic_aclk_8_aed		;
	reg				dn_up_roic_aclk_9_aed		;
	reg				dn_up_roic_aclk_10_aed		;
	reg				dn_up_roic_aclk_0_flush		;
	reg				dn_up_roic_aclk_1_flush		;
	reg				dn_up_roic_aclk_2_flush		;
	reg				dn_up_roic_aclk_3_flush		;
	reg				dn_up_roic_aclk_4_flush		;
	reg				dn_up_roic_aclk_5_flush		;
	reg				dn_up_roic_aclk_6_flush		;
	reg				dn_up_roic_aclk_7_flush		;
	reg				dn_up_roic_aclk_8_flush		;
	reg				dn_up_roic_aclk_9_flush		;
	reg				dn_up_roic_aclk_10_flush	;
	reg				dn_roic_reg_set_0			;
	reg				dn_roic_reg_set_1			;
	reg				dn_roic_reg_set_1_dual		;
	reg				dn_roic_reg_set_2			;
	reg				dn_roic_reg_set_3			;
	reg				dn_roic_reg_set_4			;
	reg				dn_roic_reg_set_5			;
	reg				dn_roic_reg_set_6			;
	reg				dn_roic_reg_set_7			;
	reg				dn_roic_reg_set_8			;
	reg				dn_roic_reg_set_9			;
	reg				dn_roic_reg_set_10			;
	reg				dn_roic_reg_set_11			;
	reg				dn_roic_reg_set_12			;
	reg				dn_roic_reg_set_13			;
	reg				dn_roic_reg_set_14			;
	reg				dn_roic_reg_set_15			;
	reg				dn_roic_temperature			;
	reg				dn_roic_burst_cycle			;
	reg				dn_start_roic_burst_clk		;
	reg				dn_end_roic_burst_clk		;
	reg				dn_dn_aed_gate_xao_0		;
	reg				dn_dn_aed_gate_xao_1		;
	reg				dn_dn_aed_gate_xao_2		;
	reg				dn_dn_aed_gate_xao_3		;
	reg				dn_dn_aed_gate_xao_4		;
	reg				dn_dn_aed_gate_xao_5		;
	reg				dn_up_aed_gate_xao_0		;
	reg				dn_up_aed_gate_xao_1		;
	reg				dn_up_aed_gate_xao_2		;
	reg				dn_up_aed_gate_xao_3		;
	reg				dn_up_aed_gate_xao_4		;
	reg				dn_up_aed_gate_xao_5		;
	reg				dn_ready_aed_read			;
	reg				dn_aed_th					;
	reg				dn_sel_aed_roic				;
	reg				dn_num_trigger				;
	reg				dn_sel_aed_test_roic		;
	reg				dn_aed_cmd					;
	reg				dn_nega_aed_th				;
	reg				dn_posi_aed_th				;
	reg				dn_aed_dark_delay			;
//	reg				dn_test_reg_a				;
//	reg				dn_test_reg_b				;
//	reg				dn_test_reg_c				;
//	reg				dn_test_reg_d				;
	reg				dn_aed_detect_line_0		;
	reg				dn_aed_detect_line_1		;
	reg				dn_aed_detect_line_2		;
	reg				dn_aed_detect_line_3		;
	reg				dn_aed_detect_line_4		;
	reg				dn_aed_detect_line_5		;
	reg				dn_fpga_ver_h				;
	reg				dn_fpga_ver_l				;
	reg				dn_roic_vendor				;
	reg				dn_purpose					;
	reg				dn_size_1					;
	reg				dn_size_2					;
	reg				dn_major_rev				;
	reg				dn_minor_rev				;
	reg				dn_test_reg_0				;
//	reg				dn_test_reg_1				;
//	reg				dn_test_reg_2				;
//	reg				dn_test_reg_3				;
//	reg				dn_test_reg_4				;
//	reg				dn_test_reg_5				;
//	reg				dn_test_reg_6				;
//	reg				dn_test_reg_7				;
//	reg				dn_test_reg_8				;
	reg				dn_test_reg_9				;

//	logic	[15:0]	s_test_reg_a				;
//	logic	[15:0]	s_test_reg_b				;
//	logic	[15:0]	s_test_reg_c				;
//	logic	[15:0]	s_test_reg_d				;
//	logic	[15:0]	s_test_reg_1				;
//	logic	[15:0]	s_test_reg_2				;
//	logic	[15:0]	s_test_reg_3				;
//	logic	[15:0]	s_test_reg_4				;
//	logic	[15:0]	s_test_reg_5				;
//	logic	[15:0]	s_test_reg_6				;
//	logic	[15:0]	s_test_reg_7				;
//	logic	[15:0]	s_test_reg_8				;
	logic	[15:0]	s_test_reg_9				;

	logic	[15:0]	buf_test_reg_9		;
	
    reg     [15:0]  reg_gate_gpio_reg           ; //i2c
	reg		[15:0]	reg_sys_cmd_reg				;
	reg		[15:0]	reg_op_mode_reg				;
	reg		[15:0]	reg_set_gate				;
	reg		[15:0]	reg_pwr_off_dwn				;
	reg		[15:0]	reg_readout_count			;
	reg 	[17:0]	tmp_expose_size				;
	reg		[15:0]	reg_expose_size				;
	reg		[15:0]	reg_back_bias_size			;
	reg		[15:0]	reg_image_height			;
	reg		[15:0]	reg_max_v_count			;
	reg		[15:0]	reg_max_h_count			;
	reg		[15:0]	reg_csi2_word_count			;
	reg		[15:0]	reg_aed_read_height			;
	reg		[15:0]	reg_cycle_width_flush		;
	reg		[15:0]	reg_cycle_width_aed			;
	reg		[15:0]	reg_cycle_width_read		;
	wire	[15:0]	rd_cycle_width_flush		;
	wire	[15:0]	rd_cycle_width_aed			;
	wire	[15:0]	rd_cycle_width_read			;
	reg		[15:0]	reg_repeat_back_bias		;
	reg		[15:0]	reg_repeat_flush			;
	wire	[15:0]	tmp_repeat_back_bias		;
	wire	[15:0]	tmp_repeat_flush			;
	reg		[15:0]	reg_saturation_flush_repeat	;

	reg		[15:0]	exp_delay					;
	reg		[15:0]	reg_exp_delay				;
	reg		[15:0]	reg_ready_delay				;
	reg		[15:0]	reg_pre_delay				;
	reg		[15:0]	reg_post_delay				;

	reg		[15:0]	reg_up_roic_aclk_0_read		;
	reg		[15:0]	reg_up_roic_aclk_1_read		;
	reg		[15:0]	reg_up_roic_aclk_2_read		;
	reg		[15:0]	reg_up_roic_aclk_3_read		;
	reg		[15:0]	reg_up_roic_aclk_4_read		;
	reg		[15:0]	reg_up_roic_aclk_5_read		;
	reg		[15:0]	reg_up_roic_aclk_6_read		;
	reg		[15:0]	reg_up_roic_aclk_7_read		;
	reg		[15:0]	reg_up_roic_aclk_8_read		;
	reg		[15:0]	reg_up_roic_aclk_9_read		;
	reg		[15:0]	reg_up_roic_aclk_10_read	;
	reg		[15:0]	reg_up_roic_aclk_0_aed		;
	reg		[15:0]	reg_up_roic_aclk_1_aed		;
	reg		[15:0]	reg_up_roic_aclk_2_aed		;
	reg		[15:0]	reg_up_roic_aclk_3_aed		;
	reg		[15:0]	reg_up_roic_aclk_4_aed		;
	reg		[15:0]	reg_up_roic_aclk_5_aed		;
	reg		[15:0]	reg_up_roic_aclk_6_aed		;
	reg		[15:0]	reg_up_roic_aclk_7_aed		;
	reg		[15:0]	reg_up_roic_aclk_8_aed		;
	reg		[15:0]	reg_up_roic_aclk_9_aed		;
	reg		[15:0]	reg_up_roic_aclk_10_aed		;
	reg		[15:0]	reg_up_roic_aclk_0_flush	;
	reg		[15:0]	reg_up_roic_aclk_1_flush	;
	reg		[15:0]	reg_up_roic_aclk_2_flush	;
	reg		[15:0]	reg_up_roic_aclk_3_flush	;
	reg		[15:0]	reg_up_roic_aclk_4_flush	;
	reg		[15:0]	reg_up_roic_aclk_5_flush	;
	reg		[15:0]	reg_up_roic_aclk_6_flush	;
	reg		[15:0]	reg_up_roic_aclk_7_flush	;
	reg		[15:0]	reg_up_roic_aclk_8_flush	;
	reg		[15:0]	reg_up_roic_aclk_9_flush	;
	reg		[15:0]	reg_up_roic_aclk_10_flush	;
	reg		[15:0]	reg_ready_aed_read			;
	reg		[15:0]	reg_num_trigger				;
	reg		[15:0]	reg_aed_cmd					;
	reg		[15:0]	reg_aed_dark_delay			;

	reg		[15:0]	up_gate_stv1_read			;
	reg		[15:0]	dn_gate_stv1_read			;
	reg		[15:0]	up_gate_stv2_read			;
	reg		[15:0]	dn_gate_stv2_read			;
	reg		[15:0]	up_gate_cpv1_read			;
	reg		[15:0]	dn_gate_cpv1_read			;
	reg		[15:0]	up_gate_cpv2_read			;
	reg		[15:0]	dn_gate_cpv2_read			;
	reg		[15:0]	dn_gate_oe1_read			;
	reg		[15:0]	up_gate_oe1_read			;
	reg		[15:0]	dn_gate_oe2_read			;
	reg		[15:0]	up_gate_oe2_read			;
	reg		[15:0]	up_gate_stv1_aed			;
	reg		[15:0]	dn_gate_stv1_aed			;
	reg		[15:0]	up_gate_stv2_aed			;
	reg		[15:0]	dn_gate_stv2_aed			;
	reg		[15:0]	up_gate_cpv1_aed			;
	reg		[15:0]	dn_gate_cpv1_aed			;
	reg		[15:0]	up_gate_cpv2_aed			;
	reg		[15:0]	dn_gate_cpv2_aed			;
	reg		[15:0]	dn_gate_oe1_aed				;
	reg		[15:0]	up_gate_oe1_aed				;
	reg		[15:0]	dn_gate_oe2_aed				;
	reg		[15:0]	up_gate_oe2_aed				;
	reg		[15:0]	up_gate_stv1_flush			;
	reg		[15:0]	dn_gate_stv1_flush			;
	reg		[15:0]	up_gate_stv2_flush			;
	reg		[15:0]	dn_gate_stv2_flush			;
	reg		[15:0]	up_gate_cpv1_flush			;
	reg		[15:0]	dn_gate_cpv1_flush			;
	reg		[15:0]	up_gate_cpv2_flush			;
	reg		[15:0]	dn_gate_cpv2_flush			;
	reg		[15:0]	dn_gate_oe1_flush			;
	reg		[15:0]	up_gate_oe1_flush			;
	reg		[15:0]	dn_gate_oe2_flush			;
	reg		[15:0]	up_gate_oe2_flush			;
	
    reg     [15:0]  buf_gate_gpio_reg           ; //i2c
	reg		[15:0]	buf_sys_cmd_reg				;
	reg		[15:0]	buf_op_mode_reg				;
	reg		[15:0]	buf_set_gate				;
	reg		[15:0]	buf_gate_size				;
	reg		[15:0]	buf_pwr_off_dwn				;
	reg		[15:0]	buf_readout_count			;
	reg		[15:0]	buf_expose_size				;
	reg		[15:0]	buf_back_bias_size			;
	reg		[15:0]	buf_image_height			;
	reg		[15:0]	buf_max_v_count			;
	reg		[15:0]	buf_max_h_count			;
	reg		[15:0]	buf_csi2_word_count			;
	reg		[15:0]	buf_cycle_width_flush		;
	reg		[15:0]	buf_cycle_width_aed			;
	reg		[15:0]	buf_cycle_width_read		;
	reg		[15:0]	buf_repeat_back_bias		;
	reg		[15:0]	buf_repeat_flush			;
	reg		[15:0]	buf_saturation_flush_repeat	;

	reg		[15:0]	buf_exp_delay				;
	reg		[15:0]	buf_ready_delay				;
	reg		[15:0]	buf_pre_delay				;
	reg		[15:0]	buf_post_delay				;

	reg		[15:0]	buf_up_back_bias			;
	reg		[15:0]	buf_dn_back_bias			;
	reg		[15:0]	buf_up_back_bias_opr		;
	reg		[15:0]	buf_dn_back_bias_opr		;
	reg		[15:0]	buf_up_gate_stv1_read		;
	reg		[15:0]	buf_dn_gate_stv1_read		;
	reg		[15:0]	buf_up_gate_stv2_read		;
	reg		[15:0]	buf_dn_gate_stv2_read		;
	reg		[15:0]	buf_up_gate_cpv1_read		;
	reg		[15:0]	buf_dn_gate_cpv1_read		;
	reg		[15:0]	buf_up_gate_cpv2_read		;
	reg		[15:0]	buf_dn_gate_cpv2_read		;
	reg		[15:0]	buf_up_gate_oe1_read		;
	reg		[15:0]	buf_dn_gate_oe1_read		;
	reg		[15:0]	buf_up_gate_oe2_read		;
	reg		[15:0]	buf_dn_gate_oe2_read		;
	reg		[15:0]	buf_up_gate_stv1_aed		;
	reg		[15:0]	buf_dn_gate_stv1_aed		;
	reg		[15:0]	buf_up_gate_stv2_aed		;
	reg		[15:0]	buf_dn_gate_stv2_aed		;
	reg		[15:0]	buf_up_gate_cpv1_aed		;
	reg		[15:0]	buf_dn_gate_cpv1_aed		;
	reg		[15:0]	buf_up_gate_cpv2_aed		;
	reg		[15:0]	buf_dn_gate_cpv2_aed		;
	reg		[15:0]	buf_up_gate_oe1_aed			;
	reg		[15:0]	buf_dn_gate_oe1_aed			;
	reg		[15:0]	buf_up_gate_oe2_aed			;
	reg		[15:0]	buf_dn_gate_oe2_aed			;
	reg		[15:0]	buf_up_gate_stv1_flush		;
	reg		[15:0]	buf_dn_gate_stv1_flush		;
	reg		[15:0]	buf_up_gate_stv2_flush		;
	reg		[15:0]	buf_dn_gate_stv2_flush		;
	reg		[15:0]	buf_up_gate_cpv1_flush		;
	reg		[15:0]	buf_dn_gate_cpv1_flush		;
	reg		[15:0]	buf_up_gate_cpv2_flush		;
	reg		[15:0]	buf_dn_gate_cpv2_flush		;
	reg		[15:0]	buf_up_gate_oe1_flush		;
	reg		[15:0]	buf_dn_gate_oe1_flush		;
	reg		[15:0]	buf_up_gate_oe2_flush		;
	reg		[15:0]	buf_dn_gate_oe2_flush		;

	reg		[15:0]	buf_up_roic_sync			;
	reg		[15:0]	buf_up_roic_aclk_0_read		;
	reg		[15:0]	buf_up_roic_aclk_1_read		;
	reg		[15:0]	buf_up_roic_aclk_2_read		;
	reg		[15:0]	buf_up_roic_aclk_3_read		;
	reg		[15:0]	buf_up_roic_aclk_4_read		;
	reg		[15:0]	buf_up_roic_aclk_5_read		;
	reg		[15:0]	buf_up_roic_aclk_6_read		;
	reg		[15:0]	buf_up_roic_aclk_7_read		;
	reg		[15:0]	buf_up_roic_aclk_8_read		;
	reg		[15:0]	buf_up_roic_aclk_9_read		;
	reg		[15:0]	buf_up_roic_aclk_10_read	;
	reg		[15:0]	buf_up_roic_aclk_0_aed		;
	reg		[15:0]	buf_up_roic_aclk_1_aed		;
	reg		[15:0]	buf_up_roic_aclk_2_aed		;
	reg		[15:0]	buf_up_roic_aclk_3_aed		;
	reg		[15:0]	buf_up_roic_aclk_4_aed		;
	reg		[15:0]	buf_up_roic_aclk_5_aed		;
	reg		[15:0]	buf_up_roic_aclk_6_aed		;
	reg		[15:0]	buf_up_roic_aclk_7_aed		;
	reg		[15:0]	buf_up_roic_aclk_8_aed		;
	reg		[15:0]	buf_up_roic_aclk_9_aed		;
	reg		[15:0]	buf_up_roic_aclk_10_aed		;
	reg		[15:0]	buf_up_roic_aclk_0_flush	;
	reg		[15:0]	buf_up_roic_aclk_1_flush	;
	reg		[15:0]	buf_up_roic_aclk_2_flush	;
	reg		[15:0]	buf_up_roic_aclk_3_flush	;
	reg		[15:0]	buf_up_roic_aclk_4_flush	;
	reg		[15:0]	buf_up_roic_aclk_5_flush	;
	reg		[15:0]	buf_up_roic_aclk_6_flush	;
	reg		[15:0]	buf_up_roic_aclk_7_flush	;
	reg		[15:0]	buf_up_roic_aclk_8_flush	;
	reg		[15:0]	buf_up_roic_aclk_9_flush	;
	reg		[15:0]	buf_up_roic_aclk_10_flush	;
	reg		[15:0]	buf_roic_burst_cycle		;
	reg		[15:0]	buf_start_roic_burst_clk	;
	reg		[15:0]	buf_end_roic_burst_clk		;
	reg		[15:0]	buf_dn_aed_gate_xao_0		;
	reg		[15:0]	buf_dn_aed_gate_xao_1		;
	reg		[15:0]	buf_dn_aed_gate_xao_2		;
	reg		[15:0]	buf_dn_aed_gate_xao_3		;
	reg		[15:0]	buf_dn_aed_gate_xao_4		;
	reg		[15:0]	buf_dn_aed_gate_xao_5		;
	reg		[15:0]	buf_up_aed_gate_xao_0		;
	reg		[15:0]	buf_up_aed_gate_xao_1		;
	reg		[15:0]	buf_up_aed_gate_xao_2		;
	reg		[15:0]	buf_up_aed_gate_xao_3		;
	reg		[15:0]	buf_up_aed_gate_xao_4		;
	reg		[15:0]	buf_up_aed_gate_xao_5		;
	reg		[15:0]	buf_ready_aed_read			;
	reg		[15:0]	buf_aed_th					;
	reg		[15:0]	buf_sel_aed_roic			;
	reg		[15:0]	buf_num_trigger				;
	reg		[15:0]	buf_sel_aed_test_roic		;
	reg		[15:0]	buf_aed_cmd					;
	reg		[15:0]	buf_nega_aed_th				;
	reg		[15:0]	buf_posi_aed_th				;
	reg		[15:0]	buf_aed_dark_delay			;
	reg		[15:0]	buf_aed_detect_line_0		;
	reg		[15:0]	buf_aed_detect_line_1		;
	reg		[15:0]	buf_aed_detect_line_2		;
	reg		[15:0]	buf_aed_detect_line_3		;
	reg		[15:0]	buf_aed_detect_line_4		;
	reg		[15:0]	buf_aed_detect_line_5		;
	reg		[15:0]	buf_roic_reg_set_0			;
	reg		[15:0]	buf_roic_reg_set_1			;
	reg		[15:0]	buf_roic_reg_set_1_dual		;
	reg		[15:0]	buf_roic_reg_set_2			;
	reg		[15:0]	buf_roic_reg_set_3			;
	reg		[15:0]	buf_roic_reg_set_4			;
	reg		[15:0]	buf_roic_reg_set_5			;
	reg		[15:0]	buf_roic_reg_set_6			;
	reg		[15:0]	buf_roic_reg_set_7			;
	reg		[15:0]	buf_roic_reg_set_8			;
	reg		[15:0]	buf_roic_reg_set_9			;
	reg		[15:0]	buf_roic_reg_set_10			;
	reg		[15:0]	buf_roic_reg_set_11			;
	reg		[15:0]	buf_roic_reg_set_12			;
	reg		[15:0]	buf_roic_reg_set_13			;
	reg		[15:0]	buf_roic_reg_set_14			;
	reg		[15:0]	buf_roic_reg_set_15			;
	reg		[15:0]	rd_roic_reg_set_0			;
	reg		[15:0]	rd_roic_reg_set_1			;
	// reg		[15:0]	rd_roic_reg_set_0_dual		;
	reg		[15:0]	rd_roic_reg_set_1_dual		;
	reg		[15:0]	rd_roic_reg_set_2			;
	reg		[15:0]	rd_roic_reg_set_3			;
	reg		[15:0]	rd_roic_reg_set_4			;
	reg		[15:0]	rd_roic_reg_set_5			;
	reg		[15:0]	rd_roic_reg_set_6			;
	reg		[15:0]	rd_roic_reg_set_7			;
	reg		[15:0]	rd_roic_reg_set_8			;
	reg		[15:0]	rd_roic_reg_set_9			;
	reg		[15:0]	rd_roic_reg_set_10			;
	reg		[15:0]	rd_roic_reg_set_11			;
	reg		[15:0]	rd_roic_reg_set_12			;
	reg		[15:0]	rd_roic_reg_set_13			;
	reg		[15:0]	rd_roic_reg_set_14			;
	reg		[15:0]	rd_roic_reg_set_15			;

	reg		[15:0]	rd_roic_temperature			;

	// reg				ld_io_delay_tab				;
	reg		[ 4:0]	buf_io_delay_tab			;
	reg		[ 7:0]	buf_sel_roic_reg			;

	reg		[ 7:0]	fsm_reg						;

	reg				sig_reset_fsm_1d			;
//	reg				sig_reset_fsm_2d			;
//	reg				sig_reset_fsm_3d			;
//	reg				sig_reset_fsm_4d			;
//	reg				sig_reset_fsm_5d			;
//	reg				sig_reset_fsm_6d			;
//	reg				sig_reset_fsm_7d			;
//	reg				sig_reset_fsm_8d			;
//	reg				sig_reset_fsm_9d			;

	wire			hi_reset_fsm				;
	wire			lo_reset_fsm				;

	reg				ack_tx_end_1d				;
	reg				ack_tx_end_2d				;

	wire			sig_get_bright				;
	wire			soft_trigger				;
	wire			en_full_flush				;
	wire			flush_operation				;
	// (* mark_debug="true" *) wire			flush_operation				;

	wire			sig_exp_req					;
	reg				exp_ack_start				;	
	wire	[15:0]	exp_ack_end_cnt				;

	wire			tmp_trigger					;
	reg				tmp_trigger_1d				;
	reg				tmp_trigger_2d				;

	reg				sig_trigger					;

	wire			start_rdy_dly_cnt			;
	wire			end_rdy_dly_cnt				;
	reg				valid_rdy_dly_cnt			;
	reg		[23:0]	sub_rdy_dly_cnt				;
	reg		[15:0]	main_rdy_dly_cnt			;

	reg		[15:0]	reg_out_tmp_0				;
	reg		[15:0]	reg_out_tmp_1				;
	reg		[15:0]	reg_out_tmp_2				;
	wire	[15:0]	sig_reg_addr				;

	wire			reg_read_thr_spi			;
	wire	[15:0]	rd_image_height			;
	wire	[15:0]	rd_max_v_count			;
	wire	[15:0]	rd_max_h_count			;
	wire	[15:0]	rd_csi2_word_count		;

	logic			CFGCLK			;
	logic			DATAVALID			;
	logic	[31:0]	FPGA_VER_DATA			;
	logic	[31:0]	s_fpga_ver_data			;


	assign			sig_reg_addr	= reg_addr[15:0];

//----------------------------------------
//	exposure ready done
//----------------------------------------

	assign sig_exp_req = ~exp_req;
//	assign tmp_trigger = (sig_get_bright & (sig_exp_req | soft_trigger)); -- for line trigger 
	assign tmp_trigger = (sig_get_bright & soft_trigger);
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			tmp_trigger_1d <= 1'b0;
			tmp_trigger_2d <= 1'b0;
		end
		else begin
			tmp_trigger_1d <= tmp_trigger;
			tmp_trigger_2d <= tmp_trigger_1d;
		end
	end

	assign start_rdy_dly_cnt  = (tmp_trigger_1d && (~tmp_trigger_2d)) ? 1'b1 : 1'b0;
	assign end_rdy_dly_cnt	= ((main_rdy_dly_cnt == reg_ready_delay) && (sub_rdy_dly_cnt == `FULL_CYCLE_WIDTH)) ? 1'b1 : 1'b0;
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			valid_rdy_dly_cnt <= 1'b0;
		end
		else begin
			if (end_rdy_dly_cnt || (!sig_get_bright))
				valid_rdy_dly_cnt <= 1'b0;
			else if (start_rdy_dly_cnt)
				valid_rdy_dly_cnt <= 1'b1;
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			sub_rdy_dly_cnt		<= 24'd1;
			main_rdy_dly_cnt 	<= 16'd1;
		end
		else begin
			if (!valid_rdy_dly_cnt) begin
				sub_rdy_dly_cnt		<= 24'd1;
				main_rdy_dly_cnt 	<= 16'd1;
			end
			else if (valid_rdy_dly_cnt) begin
				if (sub_rdy_dly_cnt == `FULL_CYCLE_WIDTH) begin
					sub_rdy_dly_cnt		<= 24'd1;
					main_rdy_dly_cnt 	<= main_rdy_dly_cnt + 16'd1;
				end
				else begin
					sub_rdy_dly_cnt	<= sub_rdy_dly_cnt + 24'd1;
				end
			end
		end
	end

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			sig_trigger <= 1'b0;
		end
		else begin
			if (!sig_get_bright)
				sig_trigger <= 1'b0;
			else if (tmp_trigger && end_rdy_dly_cnt)
				sig_trigger <= 1'b1;
		end
	end

	assign get_bright		= (sig_trigger & (~en_aed)) | (sig_get_bright & en_aed);
	// assign cmd_get_bright 	= sig_get_bright & ((~sig_exp_req) & (~soft_trigger));
	assign cmd_get_bright 	= sig_get_bright & soft_trigger;

//----------------------------------------
//	exposure ready done
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			exp_ack_start <= 1'b0;
		end
		else begin
			if (fsm_exp_index && (col_cnt == 16'd3) && (row_cnt == exp_delay) && sig_trigger)
				exp_ack_start <= 1'b1;
			else
				exp_ack_start <= 1'b0;
		end
	end

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			exp_ack <= 1'b0;
		end
		else begin
			if (((row_cnt == exp_ack_end_cnt) && (col_cnt == 16'd3) && fsm_exp_index) || (!fsm_exp_index))
				exp_ack <= 1'b0;
			else if (exp_ack_start)
				exp_ack <= 1'b1;
		end
	end

//----------------------------------------
// register upload
//----------------------------------------

// Read Only Registers

//	wire [2:0] fsm_state = (fsm_rst_index		) ? 3'b000 :
//						   (fsm_init_index		) ? 3'b001 :
//						   (fsm_back_bias_index	) ? 3'b010 :
//						   (fsm_flush_index		) ? 3'b011 :
//						   (fsm_aed_read_index	) ? 3'b100 :
//						   (fsm_exp_index		) ? 3'b101 :
//						   (fsm_read_index		) ? 3'b110 : 3'b000;
//
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			fsm_reg <= 8'd0;
		end
		else begin
			// fsm_reg[7:5] <= 3'd0;
			fsm_reg[7] <= 1'd0;
			fsm_reg[6] <= panel_stable_exist;
			fsm_reg[5] <= exp_read_exist;
			fsm_reg[4] <= aed_ready_done;
			fsm_reg[3] <= ready_to_get_image;

//			fsm_reg[2:0] <= fsm_state;
			if (fsm_rst_index)
				fsm_reg[2:0] <= 3'b000;
			else if (fsm_init_index)
				fsm_reg[2:0] <= 3'b001;
			else if (fsm_back_bias_index)
				fsm_reg[2:0] <= 3'b010;
			else if (fsm_flush_index)
				fsm_reg[2:0] <= 3'b011;
			else if (fsm_aed_read_index)
				fsm_reg[2:0] <= 3'b100;
			else if (fsm_exp_index)
				fsm_reg[2:0] <= 3'b101;
			else if (fsm_read_index)
				fsm_reg[2:0] <= 3'b110;
		end
	end

// Read Registers

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_fsm_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_FSM_REG) && reg_read_index)
				dn_fsm_reg <= 1'b1;
			else
				dn_fsm_reg <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_sys_cmd_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SYS_CMD_REG) && reg_read_index)
				dn_sys_cmd_reg <= 1'b1;
			else
				dn_sys_cmd_reg <= 1'b0;
	end
	
	//i2c
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_gate_gpio_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_GATE_GPIO_REG) && reg_read_index)
				dn_gate_gpio_reg <= 1'b1;
			else
				dn_gate_gpio_reg <= 1'b0;
	end
	/////
	
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_op_mode_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_OP_MODE_REG) && reg_read_index)
				dn_op_mode_reg <= 1'b1;
			else
				dn_op_mode_reg <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_set_gate <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SET_GATE) && reg_read_index)
				dn_set_gate <= 1'b1;
			else
				dn_set_gate <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_gate_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_GATE_SIZE) && reg_read_index)
				dn_gate_size <= 1'b1;
			else
				dn_gate_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_pwr_off_dwn <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_PWR_OFF_DWN) && reg_read_index)
				dn_pwr_off_dwn <= 1'b1;
			else
				dn_pwr_off_dwn <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_readout_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READOUT_COUNT) && reg_read_index)
				dn_readout_count <= 1'b1;
			else
				dn_readout_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_expose_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_EXPOSE_SIZE) && reg_read_index)
				dn_expose_size <= 1'b1;
			else
				dn_expose_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_back_bias_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_BACK_BIAS_SIZE) && reg_read_index)
				dn_back_bias_size <= 1'b1;
			else
				dn_back_bias_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_image_height <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_IMAGE_HEIGHT) && reg_read_index)
				dn_image_height <= 1'b1;
			else
				dn_image_height <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_max_v_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MAX_V_COUNT) && reg_read_index)
				dn_max_v_count <= 1'b1;
			else
				dn_max_v_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_max_h_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MAX_H_COUNT) && reg_read_index)
				dn_max_h_count <= 1'b1;
			else
				dn_max_h_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_csi2_word_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CSI2_WORD_COUNT) && reg_read_index)
				dn_csi2_word_count <= 1'b1;
			else
				dn_csi2_word_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_cycle_width_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_FLUSH) && reg_read_index)
				dn_cycle_width_flush <= 1'b1;
			else
				dn_cycle_width_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_cycle_width_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_AED) && reg_read_index)
				dn_cycle_width_aed <= 1'b1;
			else
				dn_cycle_width_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_cycle_width_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_READ) && reg_read_index)
				dn_cycle_width_read <= 1'b1;
			else
				dn_cycle_width_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_repeat_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_REPEAT_BACK_BIAS) && reg_read_index)
				dn_repeat_back_bias <= 1'b1;
			else
				dn_repeat_back_bias <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_repeat_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_REPEAT_FLUSH) && reg_read_index)
				dn_repeat_flush <= 1'b1;
			else
				dn_repeat_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_saturation_flush_repeat <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SATURATION_FLUSH_REPEAT) && reg_read_index)
				dn_saturation_flush_repeat <= 1'b1;
			else
				dn_saturation_flush_repeat <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_exp_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_EXP_DELAY) && reg_read_index)
				dn_exp_delay <= 1'b1;
			else
				dn_exp_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_ready_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READY_DELAY) && reg_read_index)
				dn_ready_delay <= 1'b1;
			else
				dn_ready_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_pre_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_PRE_DELAY) && reg_read_index)
				dn_pre_delay <= 1'b1;
			else
				dn_pre_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_post_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_POST_DELAY) && reg_read_index)
				dn_post_delay <= 1'b1;
			else
				dn_post_delay <= 1'b0;
	end

	// always @(posedge eim_clk or negedge eim_rst) begin
	// 	if (!eim_rst)
	// 		dn_frame_count <= 1'b0;
	// 	else
	// 		if ((sig_reg_addr == `ADDR_FRAME_COUNT) && reg_read_index)
	// 			dn_frame_count <= 1'b1;
	// 		else
	// 			dn_frame_count <= 1'b0;
	// end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_io_delay_tab <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_IO_DELAY_TAB) && reg_read_index)
				dn_io_delay_tab <= 1'b1;
			else
				dn_io_delay_tab <= 1'b0;
	end


	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_BACK_BIAS) && reg_read_index)
				dn_up_back_bias <= 1'b1;
			else
				dn_up_back_bias <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_BACK_BIAS) && reg_read_index)
				dn_dn_back_bias <= 1'b1;
			else
				dn_dn_back_bias <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_back_bias_opr <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_BACK_BIAS_OPR) && reg_read_index)
				dn_up_back_bias_opr <= 1'b1;
			else
				dn_up_back_bias_opr <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_back_bias_opr <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_BACK_BIAS_OPR) && reg_read_index)
				dn_dn_back_bias_opr <= 1'b1;
			else
				dn_dn_back_bias_opr <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_READ) && reg_read_index)
				dn_up_gate_stv1_read <= 1'b1;
			else
				dn_up_gate_stv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_READ) && reg_read_index)
				dn_dn_gate_stv1_read <= 1'b1;
			else
				dn_dn_gate_stv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_READ) && reg_read_index)
				dn_up_gate_stv2_read <= 1'b1;
			else
				dn_up_gate_stv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_READ) && reg_read_index)
				dn_dn_gate_stv2_read <= 1'b1;
			else
				dn_dn_gate_stv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_READ) && reg_read_index)
				dn_up_gate_cpv1_read <= 1'b1;
			else
				dn_up_gate_cpv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_READ) && reg_read_index)
				dn_dn_gate_cpv1_read <= 1'b1;
			else
				dn_dn_gate_cpv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_READ) && reg_read_index)
				dn_up_gate_cpv2_read <= 1'b1;
			else
				dn_up_gate_cpv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_READ) && reg_read_index)
				dn_dn_gate_cpv2_read <= 1'b1;
			else
				dn_dn_gate_cpv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_READ) && reg_read_index)
				dn_up_gate_oe1_read <= 1'b1;
			else
				dn_up_gate_oe1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_READ) && reg_read_index)
				dn_dn_gate_oe1_read <= 1'b1;
			else
				dn_dn_gate_oe1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_READ) && reg_read_index)
				dn_up_gate_oe2_read <= 1'b1;
			else
				dn_up_gate_oe2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_READ) && reg_read_index)
				dn_dn_gate_oe2_read <= 1'b1;
			else
				dn_dn_gate_oe2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_AED) && reg_read_index)
				dn_up_gate_stv1_aed <= 1'b1;
			else
				dn_up_gate_stv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_AED) && reg_read_index)
				dn_dn_gate_stv1_aed <= 1'b1;
			else
				dn_dn_gate_stv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_AED) && reg_read_index)
				dn_up_gate_stv2_aed <= 1'b1;
			else
				dn_up_gate_stv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_AED) && reg_read_index)
				dn_dn_gate_stv2_aed <= 1'b1;
			else
				dn_dn_gate_stv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_AED) && reg_read_index)
				dn_up_gate_cpv1_aed <= 1'b1;
			else
				dn_up_gate_cpv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_AED) && reg_read_index)
				dn_dn_gate_cpv1_aed <= 1'b1;
			else
				dn_dn_gate_cpv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_AED) && reg_read_index)
				dn_up_gate_cpv2_aed <= 1'b1;
			else
				dn_up_gate_cpv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_AED) && reg_read_index)
				dn_dn_gate_cpv2_aed <= 1'b1;
			else
				dn_dn_gate_cpv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_AED) && reg_read_index)
				dn_up_gate_oe1_aed <= 1'b1;
			else
				dn_up_gate_oe1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_AED) && reg_read_index)
				dn_dn_gate_oe1_aed <= 1'b1;
			else
				dn_dn_gate_oe1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_AED) && reg_read_index)
				dn_up_gate_oe2_aed <= 1'b1;
			else
				dn_up_gate_oe2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_AED) && reg_read_index)
				dn_dn_gate_oe2_aed <= 1'b1;
			else
				dn_dn_gate_oe2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_FLUSH) && reg_read_index)
				dn_up_gate_stv1_flush <= 1'b1;
			else
				dn_up_gate_stv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_FLUSH) && reg_read_index)
				dn_dn_gate_stv1_flush <= 1'b1;
			else
				dn_dn_gate_stv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_stv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_FLUSH) && reg_read_index)
				dn_up_gate_stv2_flush <= 1'b1;
			else
				dn_up_gate_stv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_stv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_FLUSH) && reg_read_index)
				dn_dn_gate_stv2_flush <= 1'b1;
			else
				dn_dn_gate_stv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_FLUSH) && reg_read_index)
				dn_up_gate_cpv1_flush <= 1'b1;
			else
				dn_up_gate_cpv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_FLUSH) && reg_read_index)
				dn_dn_gate_cpv1_flush <= 1'b1;
			else
				dn_dn_gate_cpv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_cpv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_FLUSH) && reg_read_index)
				dn_up_gate_cpv2_flush <= 1'b1;
			else
				dn_up_gate_cpv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_cpv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_FLUSH) && reg_read_index)
				dn_dn_gate_cpv2_flush <= 1'b1;
			else
				dn_dn_gate_cpv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_FLUSH) && reg_read_index)
				dn_up_gate_oe1_flush <= 1'b1;
			else
				dn_up_gate_oe1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_FLUSH) && reg_read_index)
				dn_dn_gate_oe1_flush <= 1'b1;
			else
				dn_dn_gate_oe1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_gate_oe2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_FLUSH) && reg_read_index)
				dn_up_gate_oe2_flush <= 1'b1;
			else
				dn_up_gate_oe2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_gate_oe2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_FLUSH) && reg_read_index)
				dn_dn_gate_oe2_flush <= 1'b1;
			else
				dn_dn_gate_oe2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_sync <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_SYNC) && reg_read_index)
				dn_up_roic_sync <= 1'b1;
			else
				dn_up_roic_sync <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_0_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_READ) && reg_read_index)
				dn_up_roic_aclk_0_read <= 1'b1;
			else
				dn_up_roic_aclk_0_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_READ) && reg_read_index)
				dn_up_roic_aclk_1_read <= 1'b1;
			else
				dn_up_roic_aclk_1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_READ) && reg_read_index)
				dn_up_roic_aclk_2_read <= 1'b1;
			else
				dn_up_roic_aclk_2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_3_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_READ) && reg_read_index)
				dn_up_roic_aclk_3_read <= 1'b1;
			else
				dn_up_roic_aclk_3_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_4_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_READ) && reg_read_index)
				dn_up_roic_aclk_4_read <= 1'b1;
			else
				dn_up_roic_aclk_4_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_5_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_READ) && reg_read_index)
				dn_up_roic_aclk_5_read <= 1'b1;
			else
				dn_up_roic_aclk_5_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_6_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_READ) && reg_read_index)
				dn_up_roic_aclk_6_read <= 1'b1;
			else
				dn_up_roic_aclk_6_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_7_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_READ) && reg_read_index)
				dn_up_roic_aclk_7_read <= 1'b1;
			else
				dn_up_roic_aclk_7_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_8_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_READ) && reg_read_index)
				dn_up_roic_aclk_8_read <= 1'b1;
			else
				dn_up_roic_aclk_8_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_9_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_READ) && reg_read_index)
				dn_up_roic_aclk_9_read <= 1'b1;
			else
				dn_up_roic_aclk_9_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_10_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_READ) && reg_read_index)
				dn_up_roic_aclk_10_read <= 1'b1;
			else
				dn_up_roic_aclk_10_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_0_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_AED) && reg_read_index)
				dn_up_roic_aclk_0_aed <= 1'b1;
			else
				dn_up_roic_aclk_0_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_AED) && reg_read_index)
				dn_up_roic_aclk_1_aed <= 1'b1;
			else
				dn_up_roic_aclk_1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_AED) && reg_read_index)
				dn_up_roic_aclk_2_aed <= 1'b1;
			else
				dn_up_roic_aclk_2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_3_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_AED) && reg_read_index)
				dn_up_roic_aclk_3_aed <= 1'b1;
			else
				dn_up_roic_aclk_3_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_4_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_AED) && reg_read_index)
				dn_up_roic_aclk_4_aed <= 1'b1;
			else
				dn_up_roic_aclk_4_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_5_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_AED) && reg_read_index)
				dn_up_roic_aclk_5_aed <= 1'b1;
			else
				dn_up_roic_aclk_5_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_6_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_AED) && reg_read_index)
				dn_up_roic_aclk_6_aed <= 1'b1;
			else
				dn_up_roic_aclk_6_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_7_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_AED) && reg_read_index)
				dn_up_roic_aclk_7_aed <= 1'b1;
			else
				dn_up_roic_aclk_7_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_8_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_AED) && reg_read_index)
				dn_up_roic_aclk_8_aed <= 1'b1;
			else
				dn_up_roic_aclk_8_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_9_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_AED) && reg_read_index)
				dn_up_roic_aclk_9_aed <= 1'b1;
			else
				dn_up_roic_aclk_9_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_10_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_AED) && reg_read_index)
				dn_up_roic_aclk_10_aed <= 1'b1;
			else
				dn_up_roic_aclk_10_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_0_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_FLUSH) && reg_read_index)
				dn_up_roic_aclk_0_flush <= 1'b1;
			else
				dn_up_roic_aclk_0_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_FLUSH) && reg_read_index)
				dn_up_roic_aclk_1_flush <= 1'b1;
			else
				dn_up_roic_aclk_1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_FLUSH) && reg_read_index)
				dn_up_roic_aclk_2_flush <= 1'b1;
			else
				dn_up_roic_aclk_2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_3_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_FLUSH) && reg_read_index)
				dn_up_roic_aclk_3_flush <= 1'b1;
			else
				dn_up_roic_aclk_3_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_4_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_FLUSH) && reg_read_index)
				dn_up_roic_aclk_4_flush <= 1'b1;
			else
				dn_up_roic_aclk_4_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_5_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_FLUSH) && reg_read_index)
				dn_up_roic_aclk_5_flush <= 1'b1;
			else
				dn_up_roic_aclk_5_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_6_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_FLUSH) && reg_read_index)
				dn_up_roic_aclk_6_flush <= 1'b1;
			else
				dn_up_roic_aclk_6_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_7_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_FLUSH) && reg_read_index)
				dn_up_roic_aclk_7_flush <= 1'b1;
			else
				dn_up_roic_aclk_7_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_8_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_FLUSH) && reg_read_index)
				dn_up_roic_aclk_8_flush <= 1'b1;
			else
				dn_up_roic_aclk_8_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_9_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_FLUSH) && reg_read_index)
				dn_up_roic_aclk_9_flush <= 1'b1;
			else
				dn_up_roic_aclk_9_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_roic_aclk_10_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_FLUSH) && reg_read_index)
				dn_up_roic_aclk_10_flush <= 1'b1;
			else
				dn_up_roic_aclk_10_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_0) && reg_read_index)
				dn_roic_reg_set_0 <= 1'b1;
			else
				dn_roic_reg_set_0 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_1) && reg_read_index)
				dn_roic_reg_set_1 <= 1'b1;
			else
				dn_roic_reg_set_1 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_1_dual <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_1_dual) && reg_read_index)
				dn_roic_reg_set_1_dual <= 1'b1;
			else
				dn_roic_reg_set_1_dual <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_2) && reg_read_index)
				dn_roic_reg_set_2 <= 1'b1;
			else
				dn_roic_reg_set_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_3) && reg_read_index)
				dn_roic_reg_set_3 <= 1'b1;
			else
				dn_roic_reg_set_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_4) && reg_read_index)
				dn_roic_reg_set_4<= 1'b1;
			else
				dn_roic_reg_set_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_5) && reg_read_index)
				dn_roic_reg_set_5<= 1'b1;
			else
				dn_roic_reg_set_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_6 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_6) && reg_read_index)
				dn_roic_reg_set_6<= 1'b1;
			else
				dn_roic_reg_set_6 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_7 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_7) && reg_read_index)
				dn_roic_reg_set_7<= 1'b1;
			else
				dn_roic_reg_set_7 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_8 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_8) && reg_read_index)
				dn_roic_reg_set_8<= 1'b1;
			else
				dn_roic_reg_set_8 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_9 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_9) && reg_read_index)
				dn_roic_reg_set_9<= 1'b1;
			else
				dn_roic_reg_set_9 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_10 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_10) && reg_read_index)
				dn_roic_reg_set_10<= 1'b1;
			else
				dn_roic_reg_set_10 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_11 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_11) && reg_read_index)
				dn_roic_reg_set_11<= 1'b1;
			else
				dn_roic_reg_set_11 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_12 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_12) && reg_read_index)
				dn_roic_reg_set_12<= 1'b1;
			else
				dn_roic_reg_set_12 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_13 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_13) && reg_read_index)
				dn_roic_reg_set_13<= 1'b1;
			else
				dn_roic_reg_set_13 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_14 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_14) && reg_read_index)
				dn_roic_reg_set_14<= 1'b1;
			else
				dn_roic_reg_set_14 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_reg_set_15 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_15) && reg_read_index)
				dn_roic_reg_set_15<= 1'b1;
			else
				dn_roic_reg_set_15 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_temperature <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_TEMPERATURE) && reg_read_index)
				dn_roic_temperature <= 1'b1;
			else
				dn_roic_temperature <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_burst_cycle <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_BURST_CYCLE) && reg_read_index)
				dn_roic_burst_cycle<= 1'b1;
			else
				dn_roic_burst_cycle <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_start_roic_burst_clk <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_START_ROIC_BURST_CLK) && reg_read_index)
				dn_start_roic_burst_clk<= 1'b1;
			else
				dn_start_roic_burst_clk <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_end_roic_burst_clk <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_END_ROIC_BURST_CLK) && reg_read_index)
				dn_end_roic_burst_clk<= 1'b1;
			else
				dn_end_roic_burst_clk <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_0) && reg_read_index)
				dn_dn_aed_gate_xao_0<= 1'b1;
			else
				dn_dn_aed_gate_xao_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_1) && reg_read_index)
				dn_dn_aed_gate_xao_1<= 1'b1;
			else
				dn_dn_aed_gate_xao_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_2) && reg_read_index)
				dn_dn_aed_gate_xao_2<= 1'b1;
			else
				dn_dn_aed_gate_xao_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_3) && reg_read_index)
				dn_dn_aed_gate_xao_3<= 1'b1;
			else
				dn_dn_aed_gate_xao_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_4) && reg_read_index)
				dn_dn_aed_gate_xao_4<= 1'b1;
			else
				dn_dn_aed_gate_xao_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_dn_aed_gate_xao_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_5) && reg_read_index)
				dn_dn_aed_gate_xao_5<= 1'b1;
			else
				dn_dn_aed_gate_xao_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_0) && reg_read_index)
				dn_up_aed_gate_xao_0<= 1'b1;
			else
				dn_up_aed_gate_xao_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_1) && reg_read_index)
				dn_up_aed_gate_xao_1<= 1'b1;
			else
				dn_up_aed_gate_xao_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_2) && reg_read_index)
				dn_up_aed_gate_xao_2<= 1'b1;
			else
				dn_up_aed_gate_xao_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_3) && reg_read_index)
				dn_up_aed_gate_xao_3<= 1'b1;
			else
				dn_up_aed_gate_xao_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_4) && reg_read_index)
				dn_up_aed_gate_xao_4<= 1'b1;
			else
				dn_up_aed_gate_xao_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_up_aed_gate_xao_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_5) && reg_read_index)
				dn_up_aed_gate_xao_5<= 1'b1;
			else
				dn_up_aed_gate_xao_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_ready_aed_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READY_AED_READ) && reg_read_index)
				dn_ready_aed_read<= 1'b1;
			else
				dn_ready_aed_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_TH) && reg_read_index)
				dn_aed_th<= 1'b1;
			else
				dn_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_sel_aed_roic <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SEL_AED_ROIC) && reg_read_index)
				dn_sel_aed_roic<= 1'b1;
			else
				dn_sel_aed_roic <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_num_trigger <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_NUM_TRIGGER) && reg_read_index)
				dn_num_trigger<= 1'b1;
			else
				dn_num_trigger <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_sel_aed_test_roic <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SEL_AED_TEST_ROIC) && reg_read_index)
				dn_sel_aed_test_roic<= 1'b1;
			else
				dn_sel_aed_test_roic <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_cmd <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_CMD) && reg_read_index)
				dn_aed_cmd<= 1'b1;
			else
				dn_aed_cmd <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_nega_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_NEGA_AED_TH) && reg_read_index)
				dn_nega_aed_th<= 1'b1;
			else
				dn_nega_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_posi_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_POSI_AED_TH) && reg_read_index)
				dn_posi_aed_th<= 1'b1;
			else
				dn_posi_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_dark_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DARK_DELAY) && reg_read_index)
				dn_aed_dark_delay<= 1'b1;
			else
				dn_aed_dark_delay <= 1'b0;
	end
	
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_a <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_A) && reg_read_index)
//				dn_test_reg_a<= 1'b1;
//			else
//				dn_test_reg_a <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_b <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_B) && reg_read_index)
//				dn_test_reg_b<= 1'b1;
//			else
//				dn_test_reg_b <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_c <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_C) && reg_read_index)
//				dn_test_reg_c<= 1'b1;
//			else
//				dn_test_reg_c <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_d <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_D) && reg_read_index)
//				dn_test_reg_d<= 1'b1;
//			else
//				dn_test_reg_d <= 1'b0;
//	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_0) && reg_read_index)
				dn_aed_detect_line_0<= 1'b1;
			else
				dn_aed_detect_line_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_1) && reg_read_index)
				dn_aed_detect_line_1<= 1'b1;
			else
				dn_aed_detect_line_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_2) && reg_read_index)
				dn_aed_detect_line_2<= 1'b1;
			else
				dn_aed_detect_line_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_3) && reg_read_index)
				dn_aed_detect_line_3<= 1'b1;
			else
				dn_aed_detect_line_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_4) && reg_read_index)
				dn_aed_detect_line_4<= 1'b1;
			else
				dn_aed_detect_line_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_aed_detect_line_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_5) && reg_read_index)
				dn_aed_detect_line_5<= 1'b1;
			else
				dn_aed_detect_line_5 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_roic_vendor <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_VENDOR) && reg_read_index)
				dn_roic_vendor <= 1'b1;
			else
				dn_roic_vendor <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_purpose <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_PURPOSE) && reg_read_index)
				dn_purpose <= 1'b1;
			else
				dn_purpose <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_size_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SIZE_1) && reg_read_index)
				dn_size_1 <= 1'b1;
			else
				dn_size_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_size_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SIZE_2) && reg_read_index)
				dn_size_2<= 1'b1;
			else
				dn_size_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_major_rev <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MAJOR_REV) && reg_read_index)
				dn_major_rev<= 1'b1;
			else
				dn_major_rev <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_minor_rev <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MINOR_REV) && reg_read_index)
				dn_minor_rev<= 1'b1;
			else
				dn_minor_rev <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_test_reg_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_TEST_REG_0) && reg_read_index)
				dn_test_reg_0<= 1'b1;
			else
				dn_test_reg_0 <= 1'b0;
	end
	
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_1 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_1) && reg_read_index)
//				dn_test_reg_1<= 1'b1;
//			else
//				dn_test_reg_1 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_2 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_2) && reg_read_index)
//				dn_test_reg_2<= 1'b1;
//			else
//				dn_test_reg_2 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_3 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_3) && reg_read_index)
//				dn_test_reg_3<= 1'b1;
//			else
//				dn_test_reg_3 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_4 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_4) && reg_read_index)
//				dn_test_reg_4<= 1'b1;
//			else
//				dn_test_reg_4 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_5 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_5) && reg_read_index)
//				dn_test_reg_5<= 1'b1;
//			else
//				dn_test_reg_5 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_6 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_6) && reg_read_index)
//				dn_test_reg_6<= 1'b1;
//			else
//				dn_test_reg_6 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_7 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_7) && reg_read_index)
//				dn_test_reg_7<= 1'b1;
//			else
//				dn_test_reg_7 <= 1'b0;
//	end
//	always @(posedge eim_clk or negedge eim_rst) begin
//		if (!eim_rst)
//			dn_test_reg_8 <= 1'b0;
//		else
//			if ((sig_reg_addr == `ADDR_TEST_REG_8) && reg_read_index)
//				dn_test_reg_8<= 1'b1;
//			else
//				dn_test_reg_8 <= 1'b0;
//	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_test_reg_9 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_TEST_REG_9) && reg_read_index)
				dn_test_reg_9 <= 1'b1;
			else
				dn_test_reg_9 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if(!eim_rst) begin
			reg_out_tmp_0 <= 16'd0;
		end
		else begin
			if		(dn_fsm_reg					) reg_out_tmp_0[7:0]	<= fsm_reg							;
			else if (dn_gate_gpio_reg			) reg_out_tmp_0			<= reg_gate_gpio_reg			    ; //i2c
			else if (dn_sys_cmd_reg				) reg_out_tmp_0			<= reg_sys_cmd_reg					;
			else if (dn_op_mode_reg				) reg_out_tmp_0			<= reg_op_mode_reg					;
			else if (dn_set_gate				) reg_out_tmp_0			<= reg_set_gate						;
			else if (dn_gate_size				) reg_out_tmp_0			<= gate_size						;
			else if (dn_pwr_off_dwn				) reg_out_tmp_0			<= reg_pwr_off_dwn					;
			else if (dn_readout_count			) reg_out_tmp_0			<= reg_readout_count				;
			else if (dn_expose_size				) reg_out_tmp_0			<= reg_expose_size					;
			else if (dn_back_bias_size			) reg_out_tmp_0			<= reg_back_bias_size				;
			else if (dn_image_height			) reg_out_tmp_0			<= rd_image_height					;
			else if (dn_max_v_count				) reg_out_tmp_0			<= rd_max_v_count					;
			else if (dn_max_h_count				) reg_out_tmp_0			<= rd_max_h_count					;
			else if (dn_csi2_word_count			) reg_out_tmp_0			<= rd_csi2_word_count					;
			else if (dn_cycle_width_flush		) reg_out_tmp_0			<= rd_cycle_width_flush				;
			else if (dn_cycle_width_aed			) reg_out_tmp_0			<= rd_cycle_width_aed				;
			else if (dn_cycle_width_read		) reg_out_tmp_0			<= rd_cycle_width_read				;
			else if (dn_repeat_back_bias		) reg_out_tmp_0			<= reg_repeat_back_bias				;
			else if (dn_repeat_flush			) reg_out_tmp_0			<= reg_repeat_flush					;
			else if (dn_saturation_flush_repeat	) reg_out_tmp_0			<= reg_saturation_flush_repeat		;
			else if (dn_exp_delay				) reg_out_tmp_0			<= reg_exp_delay					;
			else if (dn_ready_delay				) reg_out_tmp_0			<= reg_ready_delay					;
			else if (dn_pre_delay				) reg_out_tmp_0			<= reg_pre_delay					;
			else if (dn_post_delay				) reg_out_tmp_0			<= reg_post_delay					;
			// else if (dn_frame_count				) reg_out_tmp_0			<= frame_count						;
			else if (dn_io_delay_tab			) reg_out_tmp_0[4:0]	<= buf_io_delay_tab						;
			else if (dn_up_back_bias			) reg_out_tmp_0			<= up_back_bias						;
			else if (dn_dn_back_bias			) reg_out_tmp_0			<= dn_back_bias						;
			else if (dn_up_back_bias_opr		) reg_out_tmp_0			<= up_back_bias_opr					;
			else if (dn_dn_back_bias_opr		) reg_out_tmp_0			<= dn_back_bias_opr					;
			else if (dn_up_gate_stv1_read		) reg_out_tmp_0			<= up_gate_stv1_read				;
			else if (dn_dn_gate_stv1_read		) reg_out_tmp_0			<= dn_gate_stv1_read				;
			else if (dn_up_gate_stv2_read		) reg_out_tmp_0			<= up_gate_stv2_read				;
			else if (dn_dn_gate_stv2_read		) reg_out_tmp_0			<= dn_gate_stv2_read				;
			else if (dn_up_gate_cpv1_read		) reg_out_tmp_0			<= up_gate_cpv1_read				;
			else if (dn_dn_gate_cpv1_read		) reg_out_tmp_0			<= dn_gate_cpv1_read				;
			else if (dn_up_gate_cpv2_read		) reg_out_tmp_0			<= up_gate_cpv2_read				;
			else if (dn_dn_gate_cpv2_read		) reg_out_tmp_0			<= dn_gate_cpv2_read				;
			else if (dn_up_gate_oe1_read		) reg_out_tmp_0			<= up_gate_oe1_read					;
			else if (dn_dn_gate_oe1_read		) reg_out_tmp_0			<= dn_gate_oe1_read					;
			else if (dn_up_gate_oe2_read		) reg_out_tmp_0			<= up_gate_oe2_read					;
			else if (dn_dn_gate_oe2_read		) reg_out_tmp_0			<= dn_gate_oe2_read					;
			else								  reg_out_tmp_0			<= 16'd0;
		end
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if(!eim_rst) begin
			reg_out_tmp_1 <= 16'd0;
		end
		else begin
			if		(dn_up_gate_stv1_aed		) reg_out_tmp_1			<= up_gate_stv1_aed					;
			else if (dn_dn_gate_stv1_aed		) reg_out_tmp_1			<= dn_gate_stv1_aed					;
			else if (dn_up_gate_stv2_aed		) reg_out_tmp_1			<= up_gate_stv2_aed					;
			else if (dn_dn_gate_stv2_aed		) reg_out_tmp_1			<= dn_gate_stv2_aed					;
			else if (dn_up_gate_cpv1_aed		) reg_out_tmp_1			<= up_gate_cpv1_aed					;
			else if (dn_dn_gate_cpv1_aed		) reg_out_tmp_1			<= dn_gate_cpv1_aed					;
			else if (dn_up_gate_cpv2_aed		) reg_out_tmp_1			<= up_gate_cpv2_aed					;
			else if (dn_dn_gate_cpv2_aed		) reg_out_tmp_1			<= dn_gate_cpv2_aed					;
			else if (dn_dn_gate_oe1_aed			) reg_out_tmp_1			<= dn_gate_oe1_aed					;
			else if (dn_up_gate_oe1_aed			) reg_out_tmp_1			<= up_gate_oe1_aed					;
			else if (dn_dn_gate_oe2_aed			) reg_out_tmp_1			<= dn_gate_oe2_aed					;
			else if (dn_up_gate_oe2_aed			) reg_out_tmp_1			<= up_gate_oe2_aed					;
			else if (dn_up_gate_stv1_flush		) reg_out_tmp_1			<= up_gate_stv1_flush				;
			else if (dn_dn_gate_stv1_flush		) reg_out_tmp_1			<= dn_gate_stv1_flush				;
			else if (dn_up_gate_stv2_flush		) reg_out_tmp_1			<= up_gate_stv2_flush				;
			else if (dn_dn_gate_stv2_flush		) reg_out_tmp_1			<= dn_gate_stv2_flush				;
			else if (dn_up_gate_cpv1_flush		) reg_out_tmp_1			<= up_gate_cpv1_flush				;
			else if (dn_dn_gate_cpv1_flush		) reg_out_tmp_1			<= dn_gate_cpv1_flush				;
			else if (dn_up_gate_cpv2_flush		) reg_out_tmp_1			<= up_gate_cpv2_flush				;
			else if (dn_dn_gate_cpv2_flush		) reg_out_tmp_1			<= dn_gate_cpv2_flush				;
			else if (dn_dn_gate_oe1_flush		) reg_out_tmp_1			<= dn_gate_oe1_flush				;
			else if (dn_up_gate_oe1_flush		) reg_out_tmp_1			<= up_gate_oe1_flush				;
			else if (dn_dn_gate_oe2_flush		) reg_out_tmp_1			<= dn_gate_oe2_flush				;
			else if (dn_up_gate_oe2_flush		) reg_out_tmp_1			<= up_gate_oe2_flush				;
			else if (dn_up_roic_sync			) reg_out_tmp_1			<= up_roic_sync						;
			else if (dn_up_roic_aclk_0_read		) reg_out_tmp_1			<= reg_up_roic_aclk_0_read			;
			else if (dn_up_roic_aclk_1_read		) reg_out_tmp_1			<= reg_up_roic_aclk_1_read			;
			else if (dn_up_roic_aclk_2_read		) reg_out_tmp_1			<= reg_up_roic_aclk_2_read			;
			else if (dn_up_roic_aclk_3_read		) reg_out_tmp_1			<= reg_up_roic_aclk_3_read			;
			else if (dn_up_roic_aclk_4_read		) reg_out_tmp_1			<= reg_up_roic_aclk_4_read			;
			else if (dn_up_roic_aclk_5_read		) reg_out_tmp_1			<= reg_up_roic_aclk_5_read			;
			else if (dn_up_roic_aclk_6_read		) reg_out_tmp_1			<= reg_up_roic_aclk_6_read			;
			else if (dn_up_roic_aclk_7_read		) reg_out_tmp_1			<= reg_up_roic_aclk_7_read			;
			else if (dn_up_roic_aclk_8_read		) reg_out_tmp_1			<= reg_up_roic_aclk_8_read			;
			else if (dn_up_roic_aclk_9_read		) reg_out_tmp_1			<= reg_up_roic_aclk_9_read			;
			else if (dn_up_roic_aclk_10_read	) reg_out_tmp_1			<= reg_up_roic_aclk_10_read			;
			else if (dn_up_roic_aclk_0_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_0_aed			;
			else if (dn_up_roic_aclk_1_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_1_aed			;
			else if (dn_up_roic_aclk_2_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_2_aed			;
			else if (dn_up_roic_aclk_3_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_3_aed			;
			else if (dn_up_roic_aclk_4_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_4_aed			;
			else if (dn_up_roic_aclk_5_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_5_aed			;
			else if (dn_up_roic_aclk_6_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_6_aed			;
			else if (dn_up_roic_aclk_7_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_7_aed			;
			else if (dn_up_roic_aclk_8_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_8_aed			;
			else if (dn_up_roic_aclk_9_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_9_aed			;
			else if (dn_up_roic_aclk_10_aed		) reg_out_tmp_1			<= reg_up_roic_aclk_10_aed			;
			else								  reg_out_tmp_1			<= 16'd0;
		end
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if(!eim_rst) begin
			reg_out_tmp_2 <= 16'd0;
		end
		else begin
			if 		(dn_up_roic_aclk_0_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_0_flush   		;
			else if (dn_up_roic_aclk_1_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_1_flush   		;
			else if (dn_up_roic_aclk_2_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_2_flush   		;
			else if (dn_up_roic_aclk_3_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_3_flush   		;
			else if (dn_up_roic_aclk_4_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_4_flush   		;
			else if (dn_up_roic_aclk_5_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_5_flush   		;
			else if (dn_up_roic_aclk_6_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_6_flush   		;
			else if (dn_up_roic_aclk_7_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_7_flush   		;
			else if (dn_up_roic_aclk_8_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_8_flush   		;
			else if (dn_up_roic_aclk_9_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_9_flush   		;
			else if (dn_up_roic_aclk_10_flush	) reg_out_tmp_2			<= reg_up_roic_aclk_10_flush		;
			else if (dn_roic_reg_set_0			) reg_out_tmp_2			<= rd_roic_reg_set_0    			;
			else if (dn_roic_reg_set_1			) reg_out_tmp_2			<= rd_roic_reg_set_1    			;
			else if (dn_roic_reg_set_1_dual		) reg_out_tmp_2			<= rd_roic_reg_set_1_dual 			;
			else if (dn_roic_reg_set_2			) reg_out_tmp_2			<= rd_roic_reg_set_2    			;
			else if (dn_roic_reg_set_3			) reg_out_tmp_2			<= rd_roic_reg_set_3    			;
			else if (dn_roic_reg_set_4			) reg_out_tmp_2			<= rd_roic_reg_set_4    			;
			else if (dn_roic_reg_set_5			) reg_out_tmp_2			<= rd_roic_reg_set_5    			;
			else if (dn_roic_reg_set_6			) reg_out_tmp_2			<= rd_roic_reg_set_6    			;
			else if (dn_roic_reg_set_7  		) reg_out_tmp_2			<= rd_roic_reg_set_7    			;
			else if (dn_roic_reg_set_8  		) reg_out_tmp_2			<= rd_roic_reg_set_8    			;
			else if (dn_roic_reg_set_9  		) reg_out_tmp_2			<= rd_roic_reg_set_9    			;
			else if (dn_roic_reg_set_10  		) reg_out_tmp_2			<= rd_roic_reg_set_10   			;
			else if (dn_roic_reg_set_11  		) reg_out_tmp_2			<= rd_roic_reg_set_11   			;
			else if (dn_roic_reg_set_12  		) reg_out_tmp_2			<= rd_roic_reg_set_12   			;
			else if (dn_roic_reg_set_13			) reg_out_tmp_2			<= rd_roic_reg_set_13				;
			else if (dn_roic_reg_set_14			) reg_out_tmp_2			<= rd_roic_reg_set_14				;
			else if (dn_roic_reg_set_15			) reg_out_tmp_2			<= rd_roic_reg_set_15				;
			else if (dn_roic_temperature		) reg_out_tmp_2			<= rd_roic_temperature				;
			else if (dn_roic_burst_cycle		) reg_out_tmp_2			<= roic_burst_cycle					;
			else if (dn_start_roic_burst_clk	) reg_out_tmp_2			<= start_roic_burst_clk				;
			else if (dn_end_roic_burst_clk		) reg_out_tmp_2			<= end_roic_burst_clk				;
			else if (dn_dn_aed_gate_xao_0 		) reg_out_tmp_2			<= dn_aed_gate_xao_0				;
			else if (dn_dn_aed_gate_xao_1 		) reg_out_tmp_2			<= dn_aed_gate_xao_1				;
			else if (dn_dn_aed_gate_xao_2 		) reg_out_tmp_2			<= dn_aed_gate_xao_2				;
			else if (dn_dn_aed_gate_xao_3 		) reg_out_tmp_2			<= dn_aed_gate_xao_3				;
			else if (dn_dn_aed_gate_xao_4 		) reg_out_tmp_2			<= dn_aed_gate_xao_4				;
			else if (dn_dn_aed_gate_xao_5 		) reg_out_tmp_2			<= dn_aed_gate_xao_5				;
			else if (dn_up_aed_gate_xao_0 		) reg_out_tmp_2			<= up_aed_gate_xao_0				;
			else if (dn_up_aed_gate_xao_1 		) reg_out_tmp_2			<= up_aed_gate_xao_1				;
			else if (dn_up_aed_gate_xao_2 		) reg_out_tmp_2			<= up_aed_gate_xao_2				;
			else if (dn_up_aed_gate_xao_3		) reg_out_tmp_2			<= up_aed_gate_xao_3				;
			else if (dn_up_aed_gate_xao_4		) reg_out_tmp_2			<= up_aed_gate_xao_4				;
			else if (dn_up_aed_gate_xao_5		) reg_out_tmp_2			<= up_aed_gate_xao_5				;
			else if (dn_ready_aed_read			) reg_out_tmp_2			<= reg_ready_aed_read	 			;
			else if (dn_aed_th					) reg_out_tmp_2			<= aed_th			 				;
			else if (dn_sel_aed_roic			) reg_out_tmp_2			<= sel_aed_roic	 					;
			else if (dn_num_trigger				) reg_out_tmp_2			<= reg_num_trigger		 			;
			else if (dn_sel_aed_test_roic		) reg_out_tmp_2			<= sel_aed_test_roic				;
			else if (dn_aed_cmd					) reg_out_tmp_2			<= reg_aed_cmd			 			;
			else if (dn_nega_aed_th				) reg_out_tmp_2			<= nega_aed_th		 				;
			else if (dn_posi_aed_th				) reg_out_tmp_2			<= posi_aed_th		 				;
			else if (dn_aed_dark_delay			) reg_out_tmp_2			<= reg_aed_dark_delay	 			;
//			else if (dn_test_reg_a		 		) reg_out_tmp_2			<= s_test_reg_a	 					;
//			else if (dn_test_reg_b		 		) reg_out_tmp_2			<= s_test_reg_b		 					;
//			else if (dn_test_reg_c		 		) reg_out_tmp_2			<= s_test_reg_c		 					;
//			else if (dn_test_reg_d		 		) reg_out_tmp_2			<= s_test_reg_d		 					;
			else if (dn_aed_detect_line_0	 	) reg_out_tmp_2			<= aed_detect_line_0				;
			else if (dn_aed_detect_line_1	 	) reg_out_tmp_2			<= aed_detect_line_1				;
			else if (dn_aed_detect_line_2	 	) reg_out_tmp_2			<= aed_detect_line_2				;
			else if (dn_aed_detect_line_3	 	) reg_out_tmp_2			<= aed_detect_line_3				;
			else if (dn_aed_detect_line_4	 	) reg_out_tmp_2			<= aed_detect_line_4				;
			else if (dn_aed_detect_line_5		) reg_out_tmp_2			<= aed_detect_line_5				;
			else if (dn_fpga_ver_h				) reg_out_tmp_2			<= s_fpga_ver_data[31:16]						;
			else if (dn_fpga_ver_l				) reg_out_tmp_2			<= s_fpga_ver_data[15:0]						;
			else if (dn_roic_vendor				) reg_out_tmp_2			<= `ROIC_VENDOR							;
			else if (dn_purpose					) reg_out_tmp_2			<= `PURPOSE							;
			else if (dn_size_1					) reg_out_tmp_2			<= `SIZE_1							;
			else if (dn_size_2					) reg_out_tmp_2			<= `SIZE_2							;
			else if (dn_major_rev				) reg_out_tmp_2			<= `MAJOR_REV						;
			else if (dn_minor_rev				) reg_out_tmp_2			<= `MINOR_REV						;
			else if (dn_test_reg_0				) reg_out_tmp_2			<= {6'd0,get_bright,get_dark,reg_sys_cmd_reg[5],reg_sys_cmd_reg[4],
																			reg_sys_cmd_reg[0],en_flush,en_back_bias,
																			fsm_reg[2:0]};	
//			else if (dn_test_reg_1				) reg_out_tmp_2			<= s_test_reg_1							;
//			else if (dn_test_reg_2				) reg_out_tmp_2			<= s_test_reg_2							;
//			else if (dn_test_reg_3				) reg_out_tmp_2			<= s_test_reg_3							;
//			else if (dn_test_reg_4				) reg_out_tmp_2			<= s_test_reg_4							;
//			else if (dn_test_reg_5				) reg_out_tmp_2			<= s_test_reg_5							;
//			else if (dn_test_reg_6				) reg_out_tmp_2			<= s_test_reg_6							;
//			else if (dn_test_reg_7				) reg_out_tmp_2			<= s_test_reg_7							;
//			else if (dn_test_reg_8				) reg_out_tmp_2			<= s_test_reg_8							;
			else if (dn_test_reg_9				) reg_out_tmp_2			<= s_test_reg_9							;
			else								  reg_out_tmp_2			<= 16'h0;
		end
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if(!eim_rst) begin
			reg_read_out <= 16'd0;
			read_data_en <= 1'b0;
		end
		else begin
			reg_read_out <= reg_out_tmp_0 | reg_out_tmp_1 | reg_out_tmp_2;
			read_data_en <= reg_read_index;
		end
	end

//----------------------------------------
// register update
//----------------------------------------

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_sys_cmd_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SYS_CMD_REG) && reg_addr_index)
				up_sys_cmd_reg <= 1'b1;
			else
				up_sys_cmd_reg <= 1'b0;
	end
	
	//i2c
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_gate_gpio_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_GATE_GPIO_REG) && reg_addr_index)
				up_gate_gpio_reg <= 1'b1;
			else
				up_gate_gpio_reg <= 1'b0;
	end	
	/////
	
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_op_mode_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_OP_MODE_REG) && reg_addr_index)
				up_op_mode_reg <= 1'b1;
			else
				up_op_mode_reg <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_set_gate <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SET_GATE) && reg_addr_index)
				up_set_gate <= 1'b1;
			else
				up_set_gate <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_gate_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_GATE_SIZE) && reg_addr_index)
				up_gate_size <= 1'b1;
			else
				up_gate_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_pwr_off_dwn <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_PWR_OFF_DWN) && reg_addr_index)
				up_pwr_off_dwn <= 1'b1;
			else
				up_pwr_off_dwn <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_readout_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READOUT_COUNT) && reg_addr_index)
				up_readout_count <= 1'b1;
			else
				up_readout_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_expose_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_EXPOSE_SIZE) && reg_addr_index)
				up_expose_size <= 1'b1;
			else
				up_expose_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_back_bias_size <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_BACK_BIAS_SIZE) && reg_addr_index)
				up_back_bias_size <= 1'b1;
			else
				up_back_bias_size <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_image_height <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_IMAGE_HEIGHT) && reg_addr_index)
				up_image_height <= 1'b1;
			else
				up_image_height <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_max_v_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MAX_V_COUNT) && reg_addr_index)
				up_max_v_count <= 1'b1;
			else
				up_max_v_count <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_max_h_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_MAX_H_COUNT) && reg_addr_index)
				up_max_h_count <= 1'b1;
			else
				up_max_h_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_csi2_word_count <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CSI2_WORD_COUNT) && reg_addr_index)
				up_csi2_word_count <= 1'b1;
			else
				up_csi2_word_count <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_cycle_width_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_FLUSH) && reg_addr_index)
				up_cycle_width_flush <= 1'b1;
			else
				up_cycle_width_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_cycle_width_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_AED) && reg_addr_index)
				up_cycle_width_aed <= 1'b1;
			else
				up_cycle_width_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_cycle_width_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_CYCLE_WIDTH_READ) && reg_addr_index)
				up_cycle_width_read <= 1'b1;
			else
				up_cycle_width_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_repeat_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_REPEAT_BACK_BIAS) && reg_addr_index)
				up_repeat_back_bias <= 1'b1;
			else
				up_repeat_back_bias <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_repeat_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_REPEAT_FLUSH) && reg_addr_index)
				up_repeat_flush <= 1'b1;
			else
				up_repeat_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_saturation_flush_repeat <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SATURATION_FLUSH_REPEAT) && reg_addr_index)
				up_saturation_flush_repeat <= 1'b1;
			else
				up_saturation_flush_repeat <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_exp_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_EXP_DELAY) && reg_addr_index)
				up_exp_delay <= 1'b1;
			else
				up_exp_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_ready_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READY_DELAY) && reg_addr_index)
				up_ready_delay <= 1'b1;
			else
				up_ready_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_pre_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_PRE_DELAY) && reg_addr_index)
				up_pre_delay <= 1'b1;
			else
				up_pre_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_post_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_POST_DELAY) && reg_addr_index)
				up_post_delay <= 1'b1;
			else
				up_post_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_BACK_BIAS) && reg_addr_index)
				up_up_back_bias <= 1'b1;
			else
				up_up_back_bias <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_back_bias <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_BACK_BIAS) && reg_addr_index)
				up_dn_back_bias <= 1'b1;
			else
				up_dn_back_bias <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_back_bias_opr <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_BACK_BIAS_OPR) && reg_addr_index)
				up_up_back_bias_opr <= 1'b1;
			else
				up_up_back_bias_opr <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_back_bias_opr <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_BACK_BIAS_OPR) && reg_addr_index)
				up_dn_back_bias_opr <= 1'b1;
			else
				up_dn_back_bias_opr <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_READ) && reg_addr_index)
				up_up_gate_stv1_read <= 1'b1;
			else
				up_up_gate_stv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_READ) && reg_addr_index)
				up_dn_gate_stv1_read <= 1'b1;
			else
				up_dn_gate_stv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_READ) && reg_addr_index)
				up_up_gate_stv2_read <= 1'b1;
			else
				up_up_gate_stv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_READ) && reg_addr_index)
				up_dn_gate_stv2_read <= 1'b1;
			else
				up_dn_gate_stv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_READ) && reg_addr_index)
				up_up_gate_cpv1_read <= 1'b1;
			else
				up_up_gate_cpv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_READ) && reg_addr_index)
				up_dn_gate_cpv1_read <= 1'b1;
			else
				up_dn_gate_cpv1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_READ) && reg_addr_index)
				up_up_gate_cpv2_read <= 1'b1;
			else
				up_up_gate_cpv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_READ) && reg_addr_index)
				up_dn_gate_cpv2_read <= 1'b1;
			else
				up_dn_gate_cpv2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_READ) && reg_addr_index)
				up_up_gate_oe1_read <= 1'b1;
			else
				up_up_gate_oe1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_READ) && reg_addr_index)
				up_dn_gate_oe1_read <= 1'b1;
			else
				up_dn_gate_oe1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_READ) && reg_addr_index)
				up_up_gate_oe2_read <= 1'b1;
			else
				up_up_gate_oe2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_READ) && reg_addr_index)
				up_dn_gate_oe2_read <= 1'b1;
			else
				up_dn_gate_oe2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_AED) && reg_addr_index)
				up_up_gate_stv1_aed <= 1'b1;
			else
				up_up_gate_stv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_AED) && reg_addr_index)
				up_dn_gate_stv1_aed <= 1'b1;
			else
				up_dn_gate_stv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_AED) && reg_addr_index)
				up_up_gate_stv2_aed <= 1'b1;
			else
				up_up_gate_stv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_AED) && reg_addr_index)
				up_dn_gate_stv2_aed <= 1'b1;
			else
				up_dn_gate_stv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_AED) && reg_addr_index)
				up_up_gate_cpv1_aed <= 1'b1;
			else
				up_up_gate_cpv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_AED) && reg_addr_index)
				up_dn_gate_cpv1_aed <= 1'b1;
			else
				up_dn_gate_cpv1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_AED) && reg_addr_index)
				up_up_gate_cpv2_aed <= 1'b1;
			else
				up_up_gate_cpv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_AED) && reg_addr_index)
				up_dn_gate_cpv2_aed <= 1'b1;
			else
				up_dn_gate_cpv2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_AED) && reg_addr_index)
				up_up_gate_oe1_aed <= 1'b1;
			else
				up_up_gate_oe1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_AED) && reg_addr_index)
				up_dn_gate_oe1_aed <= 1'b1;
			else
				up_dn_gate_oe1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_AED) && reg_addr_index)
				up_up_gate_oe2_aed <= 1'b1;
			else
				up_up_gate_oe2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_AED) && reg_addr_index)
				up_dn_gate_oe2_aed <= 1'b1;
			else
				up_dn_gate_oe2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV1_FLUSH) && reg_addr_index)
				up_up_gate_stv1_flush <= 1'b1;
			else
				up_up_gate_stv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV1_FLUSH) && reg_addr_index)
				up_dn_gate_stv1_flush <= 1'b1;
			else
				up_dn_gate_stv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_stv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_STV2_FLUSH) && reg_addr_index)
				up_up_gate_stv2_flush <= 1'b1;
			else
				up_up_gate_stv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_stv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_STV2_FLUSH) && reg_addr_index)
				up_dn_gate_stv2_flush <= 1'b1;
			else
				up_dn_gate_stv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV1_FLUSH) && reg_addr_index)
				up_up_gate_cpv1_flush <= 1'b1;
			else
				up_up_gate_cpv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV1_FLUSH) && reg_addr_index)
				up_dn_gate_cpv1_flush <= 1'b1;
			else
				up_dn_gate_cpv1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_cpv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_CPV2_FLUSH) && reg_addr_index)
				up_up_gate_cpv2_flush <= 1'b1;
			else
				up_up_gate_cpv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_cpv2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_CPV2_FLUSH) && reg_addr_index)
				up_dn_gate_cpv2_flush <= 1'b1;
			else
				up_dn_gate_cpv2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE1_FLUSH) && reg_addr_index)
				up_up_gate_oe1_flush <= 1'b1;
			else
				up_up_gate_oe1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE1_FLUSH) && reg_addr_index)
				up_dn_gate_oe1_flush <= 1'b1;
			else
				up_dn_gate_oe1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_gate_oe2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_GATE_OE2_FLUSH) && reg_addr_index)
				up_up_gate_oe2_flush <= 1'b1;
			else
				up_up_gate_oe2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_gate_oe2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_GATE_OE2_FLUSH) && reg_addr_index)
				up_dn_gate_oe2_flush <= 1'b1;
			else
				up_dn_gate_oe2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_sync <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_SYNC) && reg_addr_index)
				up_up_roic_sync <= 1'b1;
			else
				up_up_roic_sync <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_0_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_READ) && reg_addr_index)
				up_up_roic_aclk_0_read <= 1'b1;
			else
				up_up_roic_aclk_0_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_1_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_READ) && reg_addr_index)
				up_up_roic_aclk_1_read <= 1'b1;
			else
				up_up_roic_aclk_1_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_2_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_READ) && reg_addr_index)
				up_up_roic_aclk_2_read <= 1'b1;
			else
				up_up_roic_aclk_2_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_3_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_READ) && reg_addr_index)
				up_up_roic_aclk_3_read <= 1'b1;
			else
				up_up_roic_aclk_3_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_4_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_READ) && reg_addr_index)
				up_up_roic_aclk_4_read <= 1'b1;
			else
				up_up_roic_aclk_4_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_5_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_READ) && reg_addr_index)
				up_up_roic_aclk_5_read <= 1'b1;
			else
				up_up_roic_aclk_5_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_6_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_READ) && reg_addr_index)
				up_up_roic_aclk_6_read <= 1'b1;
			else
				up_up_roic_aclk_6_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_7_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_READ) && reg_addr_index)
				up_up_roic_aclk_7_read <= 1'b1;
			else
				up_up_roic_aclk_7_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_8_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_READ) && reg_addr_index)
				up_up_roic_aclk_8_read <= 1'b1;
			else
				up_up_roic_aclk_8_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_9_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_READ) && reg_addr_index)
				up_up_roic_aclk_9_read <= 1'b1;
			else
				up_up_roic_aclk_9_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_10_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_READ) && reg_addr_index)
				up_up_roic_aclk_10_read <= 1'b1;
			else
				up_up_roic_aclk_10_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_0_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_AED) && reg_addr_index)
				up_up_roic_aclk_0_aed <= 1'b1;
			else
				up_up_roic_aclk_0_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_1_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_AED) && reg_addr_index)
				up_up_roic_aclk_1_aed <= 1'b1;
			else
				up_up_roic_aclk_1_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_2_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_AED) && reg_addr_index)
				up_up_roic_aclk_2_aed <= 1'b1;
			else
				up_up_roic_aclk_2_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_3_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_AED) && reg_addr_index)
				up_up_roic_aclk_3_aed <= 1'b1;
			else
				up_up_roic_aclk_3_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_4_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_AED) && reg_addr_index)
				up_up_roic_aclk_4_aed <= 1'b1;
			else
				up_up_roic_aclk_4_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_5_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_AED) && reg_addr_index)
				up_up_roic_aclk_5_aed <= 1'b1;
			else
				up_up_roic_aclk_5_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_6_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_AED) && reg_addr_index)
				up_up_roic_aclk_6_aed <= 1'b1;
			else
				up_up_roic_aclk_6_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_7_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_AED) && reg_addr_index)
				up_up_roic_aclk_7_aed <= 1'b1;
			else
				up_up_roic_aclk_7_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_8_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_AED) && reg_addr_index)
				up_up_roic_aclk_8_aed <= 1'b1;
			else
				up_up_roic_aclk_8_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_9_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_AED) && reg_addr_index)
				up_up_roic_aclk_9_aed <= 1'b1;
			else
				up_up_roic_aclk_9_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_10_aed <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_AED) && reg_addr_index)
				up_up_roic_aclk_10_aed <= 1'b1;
			else
				up_up_roic_aclk_10_aed <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_0_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_0_FLUSH) && reg_addr_index)
				up_up_roic_aclk_0_flush <= 1'b1;
			else
				up_up_roic_aclk_0_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_1_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_1_FLUSH) && reg_addr_index)
				up_up_roic_aclk_1_flush <= 1'b1;
			else
				up_up_roic_aclk_1_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_2_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_2_FLUSH) && reg_addr_index)
				up_up_roic_aclk_2_flush <= 1'b1;
			else
				up_up_roic_aclk_2_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_3_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_3_FLUSH) && reg_addr_index)
				up_up_roic_aclk_3_flush <= 1'b1;
			else
				up_up_roic_aclk_3_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_4_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_4_FLUSH) && reg_addr_index)
				up_up_roic_aclk_4_flush <= 1'b1;
			else
				up_up_roic_aclk_4_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_5_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_5_FLUSH) && reg_addr_index)
				up_up_roic_aclk_5_flush <= 1'b1;
			else
				up_up_roic_aclk_5_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_6_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_6_FLUSH) && reg_addr_index)
				up_up_roic_aclk_6_flush <= 1'b1;
			else
				up_up_roic_aclk_6_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_7_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_7_FLUSH) && reg_addr_index)
				up_up_roic_aclk_7_flush <= 1'b1;
			else
				up_up_roic_aclk_7_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_8_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_8_FLUSH) && reg_addr_index)
				up_up_roic_aclk_8_flush <= 1'b1;
			else
				up_up_roic_aclk_8_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_9_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_9_FLUSH) && reg_addr_index)
				up_up_roic_aclk_9_flush <= 1'b1;
			else
				up_up_roic_aclk_9_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_roic_aclk_10_flush <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_ROIC_ACLK_10_FLUSH) && reg_addr_index)
				up_up_roic_aclk_10_flush <= 1'b1;
			else
				up_up_roic_aclk_10_flush <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_0) && reg_addr_index)
				up_roic_reg_set_0 <= 1'b1;
			else
				up_roic_reg_set_0 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_1) && reg_addr_index)
				up_roic_reg_set_1 <= 1'b1;
			else
				up_roic_reg_set_1 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_1_dual <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_1_dual) && reg_addr_index)
				up_roic_reg_set_1_dual <= 1'b1;
			else
				up_roic_reg_set_1_dual <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_2) && reg_addr_index)
				up_roic_reg_set_2 <= 1'b1;
			else
				up_roic_reg_set_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_3) && reg_addr_index)
				up_roic_reg_set_3 <= 1'b1;
			else
				up_roic_reg_set_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_4) && reg_addr_index)
				up_roic_reg_set_4<= 1'b1;
			else
				up_roic_reg_set_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_5) && reg_addr_index)
				up_roic_reg_set_5<= 1'b1;
			else
				up_roic_reg_set_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_6 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_6) && reg_addr_index)
				up_roic_reg_set_6<= 1'b1;
			else
				up_roic_reg_set_6 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_7 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_7) && reg_addr_index)
				up_roic_reg_set_7<= 1'b1;
			else
				up_roic_reg_set_7 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_8 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_8) && reg_addr_index)
				up_roic_reg_set_8<= 1'b1;
			else
				up_roic_reg_set_8 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_9 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_9) && reg_addr_index)
				up_roic_reg_set_9<= 1'b1;
			else
				up_roic_reg_set_9 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_10 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_10) && reg_addr_index)
				up_roic_reg_set_10<= 1'b1;
			else
				up_roic_reg_set_10 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_11 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_11) && reg_addr_index)
				up_roic_reg_set_11<= 1'b1;
			else
				up_roic_reg_set_11 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_12 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_12) && reg_addr_index)
				up_roic_reg_set_12<= 1'b1;
			else
				up_roic_reg_set_12 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_13 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_13) && reg_addr_index)
				up_roic_reg_set_13<= 1'b1;
			else
				up_roic_reg_set_13 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_14 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_14) && reg_addr_index)
				up_roic_reg_set_14<= 1'b1;
			else
				up_roic_reg_set_14 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_reg_set_15 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_REG_SET_15) && reg_addr_index)
				up_roic_reg_set_15<= 1'b1;
			else
				up_roic_reg_set_15 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_roic_burst_cycle <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_ROIC_BURST_CYCLE) && reg_addr_index)
				up_roic_burst_cycle<= 1'b1;
			else
				up_roic_burst_cycle <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_start_roic_burst_clk <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_START_ROIC_BURST_CLK) && reg_addr_index)
				up_start_roic_burst_clk<= 1'b1;
			else
				up_start_roic_burst_clk <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_end_roic_burst_clk <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_END_ROIC_BURST_CLK) && reg_addr_index)
				up_end_roic_burst_clk<= 1'b1;
			else
				up_end_roic_burst_clk <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_io_delay_tab <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_IO_DELAY_TAB) && reg_addr_index)
				up_io_delay_tab<= 1'b1;
			else
				up_io_delay_tab <= 1'b0;
	end

	assign ld_io_delay_tab = up_io_delay_tab;

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_sel_roic_reg <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SEL_ROIC_REG) && reg_addr_index)
				up_sel_roic_reg<= 1'b1;
			else
				up_sel_roic_reg <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_0) && reg_addr_index)
				up_dn_aed_gate_xao_0<= 1'b1;
			else
				up_dn_aed_gate_xao_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_1) && reg_addr_index)
				up_dn_aed_gate_xao_1<= 1'b1;
			else
				up_dn_aed_gate_xao_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_2) && reg_addr_index)
				up_dn_aed_gate_xao_2<= 1'b1;
			else
				up_dn_aed_gate_xao_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_3) && reg_addr_index)
				up_dn_aed_gate_xao_3<= 1'b1;
			else
				up_dn_aed_gate_xao_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_4) && reg_addr_index)
				up_dn_aed_gate_xao_4<= 1'b1;
			else
				up_dn_aed_gate_xao_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_dn_aed_gate_xao_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_DN_AED_GATE_XAO_5) && reg_addr_index)
				up_dn_aed_gate_xao_5<= 1'b1;
			else
				up_dn_aed_gate_xao_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_0) && reg_addr_index)
				up_up_aed_gate_xao_0<= 1'b1;
			else
				up_up_aed_gate_xao_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_1) && reg_addr_index)
				up_up_aed_gate_xao_1<= 1'b1;
			else
				up_up_aed_gate_xao_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_2) && reg_addr_index)
				up_up_aed_gate_xao_2<= 1'b1;
			else
				up_up_aed_gate_xao_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_3) && reg_addr_index)
				up_up_aed_gate_xao_3<= 1'b1;
			else
				up_up_aed_gate_xao_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_4) && reg_addr_index)
				up_up_aed_gate_xao_4<= 1'b1;
			else
				up_up_aed_gate_xao_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_up_aed_gate_xao_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_UP_AED_GATE_XAO_5) && reg_addr_index)
				up_up_aed_gate_xao_5<= 1'b1;
			else
				up_up_aed_gate_xao_5 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_ready_aed_read <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_READY_AED_READ) && reg_addr_index)
				up_ready_aed_read<= 1'b1;
			else
				up_ready_aed_read <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_TH) && reg_addr_index)
				up_aed_th<= 1'b1;
			else
				up_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_sel_aed_roic <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SEL_AED_ROIC) && reg_addr_index)
				up_sel_aed_roic<= 1'b1;
			else
				up_sel_aed_roic <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_num_trigger <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_NUM_TRIGGER) && reg_addr_index)
				up_num_trigger<= 1'b1;
			else
				up_num_trigger <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_sel_aed_test_roic <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_SEL_AED_TEST_ROIC) && reg_addr_index)
				up_sel_aed_test_roic<= 1'b1;
			else
				up_sel_aed_test_roic <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_cmd <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_CMD) && reg_addr_index)
				up_aed_cmd<= 1'b1;
			else
				up_aed_cmd <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_nega_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_NEGA_AED_TH) && reg_addr_index)
				up_nega_aed_th<= 1'b1;
			else
				up_nega_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_posi_aed_th <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_POSI_AED_TH) && reg_addr_index)
				up_posi_aed_th<= 1'b1;
			else
				up_posi_aed_th <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_dark_delay <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DARK_DELAY) && reg_addr_index)
				up_aed_dark_delay<= 1'b1;
			else
				up_aed_dark_delay <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_0 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_0) && reg_addr_index)
				up_aed_detect_line_0<= 1'b1;
			else
				up_aed_detect_line_0 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_1 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_1) && reg_addr_index)
				up_aed_detect_line_1<= 1'b1;
			else
				up_aed_detect_line_1 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_2 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_2) && reg_addr_index)
				up_aed_detect_line_2<= 1'b1;
			else
				up_aed_detect_line_2 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_3 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_3) && reg_addr_index)
				up_aed_detect_line_3<= 1'b1;
			else
				up_aed_detect_line_3 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_4 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_4) && reg_addr_index)
				up_aed_detect_line_4<= 1'b1;
			else
				up_aed_detect_line_4 <= 1'b0;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_aed_detect_line_5 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_AED_DETECT_LINE_5) && reg_addr_index)
				up_aed_detect_line_5<= 1'b1;
			else
				up_aed_detect_line_5 <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			up_test_reg_9 <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_TEST_REG_9) && reg_addr_index)
				up_test_reg_9 <= 1'b1;
			else
				up_test_reg_9 <= 1'b0;
	end

// reigster buffer

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_sys_cmd_reg <= `DEF_SYS_CMD_REG;
		else
			if (up_sys_cmd_reg && reg_data_index)
				buf_sys_cmd_reg <= reg_data;
	end
	
	//i2c
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_gate_gpio_reg <= `DEF_GATE_GPIO_REG;
		else
			if (up_gate_gpio_reg && reg_data_index)
				buf_gate_gpio_reg <= reg_data;
	end	
	/////
		
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_op_mode_reg <= `DEF_OP_MODE_REG;
		else
			if (up_op_mode_reg && reg_data_index)
				buf_op_mode_reg <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_set_gate <= `DEF_SET_GATE;
		else
			if (up_set_gate && reg_data_index)
				buf_set_gate <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_gate_size <= `DEF_GATE_SIZE;
		else
			if (up_gate_size && reg_data_index)
				buf_gate_size <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_pwr_off_dwn <= `DEF_PWR_OFF_DWN;
		else
			if (up_pwr_off_dwn && reg_data_index)
				buf_pwr_off_dwn <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_expose_size <= `DEF_EXPOSE_SIZE;
		else
			if (up_expose_size && reg_data_index)
				buf_expose_size <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_readout_count <= `DEF_READOUT_COUNT;
		else
			if (up_readout_count && reg_data_index)
				buf_readout_count <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_back_bias_size <= `DEF_BACK_BIAS_SIZE;
		else
			if (up_back_bias_size && reg_data_index)
				buf_back_bias_size <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_image_height <= `DEF_IMAGE_HEIGHT;
		else
			if (up_image_height && reg_data_index)
				buf_image_height <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_max_v_count <= `DEF_MAX_V_COUNT;
		else
			if (up_max_v_count && reg_data_index)
				buf_max_v_count <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_max_h_count <= `DEF_MAX_H_COUNT;
		else
			if (up_max_h_count && reg_data_index)
				buf_max_h_count <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_csi2_word_count <= `DEF_CSI2_WORD_COUNT;
		else
			if (up_csi2_word_count && reg_data_index)
				buf_csi2_word_count <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_cycle_width_flush <= `DEF_CYCLE_WIDTH_FLUSH;
		else
			if (up_cycle_width_flush && reg_data_index)
				buf_cycle_width_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_cycle_width_aed <= `DEF_CYCLE_WIDTH_AED;
		else
			if (up_cycle_width_aed && reg_data_index)
				buf_cycle_width_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_cycle_width_read <= `DEF_CYCLE_WIDTH_READ;
		else
			if (up_cycle_width_read && reg_data_index)
				buf_cycle_width_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_repeat_back_bias <= `DEF_REPEAT_BACK_BIAS;
		else
			if (up_repeat_back_bias && reg_data_index)
				buf_repeat_back_bias <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_repeat_flush <= `DEF_REPEAT_FLUSH;
		else
			if (up_repeat_flush && reg_data_index)
				buf_repeat_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_saturation_flush_repeat <= `DEF_SATURATION_FLUSH_REPEAT;
		else
			if (up_saturation_flush_repeat && reg_data_index)
				buf_saturation_flush_repeat <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_exp_delay <= `DEF_EXP_DELAY;
		else
			if (up_exp_delay && reg_data_index)
				buf_exp_delay <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_ready_delay <= `DEF_READY_DELAY;
		else
			if (up_ready_delay && reg_data_index)
				buf_ready_delay <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_pre_delay <= `DEF_PRE_DELAY;
		else
			if (up_pre_delay && reg_data_index)
				buf_pre_delay <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_post_delay <= `DEF_POST_DELAY;
		else
			if (up_post_delay && reg_data_index)
				buf_post_delay <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_back_bias <= `DEF_UP_BACK_BIAS;
		else
			if (up_up_back_bias && reg_data_index)
				buf_up_back_bias <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_back_bias <= `DEF_DN_BACK_BIAS;
		else
			if (up_dn_back_bias && reg_data_index)
				buf_dn_back_bias <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_back_bias_opr <= `DEF_UP_BACK_BIAS_OPR;
		else
			if (up_up_back_bias_opr && reg_data_index)
				buf_up_back_bias_opr <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_back_bias_opr <= `DEF_DN_BACK_BIAS_OPR;
		else
			if (up_dn_back_bias_opr && reg_data_index)
				buf_dn_back_bias_opr <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv1_read <= `DEF_UP_GATE_STV1_READ;
		else
			if (up_up_gate_stv1_read && reg_data_index)
				buf_up_gate_stv1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv1_read <= `DEF_DN_GATE_STV1_READ;
		else
			if (up_dn_gate_stv1_read && reg_data_index)
				buf_dn_gate_stv1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv2_read <= `DEF_UP_GATE_STV2_READ;
		else
			if (up_up_gate_stv2_read && reg_data_index)
				buf_up_gate_stv2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv2_read <= `DEF_DN_GATE_STV2_READ;
		else
			if (up_dn_gate_stv2_read && reg_data_index)
				buf_dn_gate_stv2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv1_read <= `DEF_UP_GATE_CPV1_READ;
		else
			if (up_up_gate_cpv1_read && reg_data_index)
				buf_up_gate_cpv1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv1_read <= `DEF_DN_GATE_CPV1_READ;
		else
			if (up_dn_gate_cpv1_read && reg_data_index)
				buf_dn_gate_cpv1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv2_read <= `DEF_UP_GATE_CPV2_READ;
		else
			if (up_up_gate_cpv2_read && reg_data_index)
				buf_up_gate_cpv2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv2_read <= `DEF_DN_GATE_CPV2_READ;
		else
			if (up_dn_gate_cpv2_read && reg_data_index)
				buf_dn_gate_cpv2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe1_read <= `DEF_UP_GATE_OE1_READ;
		else
			if (up_up_gate_oe1_read && reg_data_index)
				buf_up_gate_oe1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe1_read <= `DEF_DN_GATE_OE1_READ;
		else
			if (up_dn_gate_oe1_read && reg_data_index)
				buf_dn_gate_oe1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe2_read <= `DEF_UP_GATE_OE2_READ;
		else
			if (up_up_gate_oe2_read && reg_data_index)
				buf_up_gate_oe2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe2_read <= `DEF_DN_GATE_OE2_READ;
		else
			if (up_dn_gate_oe2_read && reg_data_index)
				buf_dn_gate_oe2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv1_aed <= `DEF_UP_GATE_STV1_AED;
		else
			if (up_up_gate_stv1_aed && reg_data_index)
				buf_up_gate_stv1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv1_aed <= `DEF_DN_GATE_STV1_AED;
		else
			if (up_dn_gate_stv1_aed && reg_data_index)
				buf_dn_gate_stv1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv2_aed <= `DEF_UP_GATE_STV2_AED;
		else
			if (up_up_gate_stv2_aed && reg_data_index)
				buf_up_gate_stv2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv2_aed <= `DEF_DN_GATE_STV2_AED;
		else
			if (up_dn_gate_stv2_aed && reg_data_index)
				buf_dn_gate_stv2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv1_aed <= `DEF_UP_GATE_CPV1_AED;
		else
			if (up_up_gate_cpv1_aed && reg_data_index)
				buf_up_gate_cpv1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv1_aed <= `DEF_DN_GATE_CPV1_AED;
		else
			if (up_dn_gate_cpv1_aed && reg_data_index)
				buf_dn_gate_cpv1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv2_aed <= `DEF_UP_GATE_CPV2_AED;
		else
			if (up_up_gate_cpv2_aed && reg_data_index)
				buf_up_gate_cpv2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv2_aed <= `DEF_DN_GATE_CPV2_AED;
		else
			if (up_dn_gate_cpv2_aed && reg_data_index)
				buf_dn_gate_cpv2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe1_aed <= `DEF_UP_GATE_OE1_AED;
		else
			if (up_up_gate_oe1_aed && reg_data_index)
				buf_up_gate_oe1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe1_aed <= `DEF_DN_GATE_OE1_AED;
		else
			if (up_dn_gate_oe1_aed && reg_data_index)
				buf_dn_gate_oe1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe2_aed <= `DEF_UP_GATE_OE2_AED;
		else
			if (up_up_gate_oe2_aed && reg_data_index)
				buf_up_gate_oe2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe2_aed <= `DEF_DN_GATE_OE2_AED;
		else
			if (up_dn_gate_oe2_aed && reg_data_index)
				buf_dn_gate_oe2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv1_flush <= `DEF_UP_GATE_STV1_FLUSH;
		else
			if (up_up_gate_stv1_flush && reg_data_index)
				buf_up_gate_stv1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv1_flush <= `DEF_DN_GATE_STV1_FLUSH;
		else
			if (up_dn_gate_stv1_flush && reg_data_index)
				buf_dn_gate_stv1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_stv2_flush <= `DEF_UP_GATE_STV2_FLUSH;
		else
			if (up_up_gate_stv2_flush && reg_data_index)
				buf_up_gate_stv2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_stv2_flush <= `DEF_DN_GATE_STV2_FLUSH;
		else
			if (up_dn_gate_stv2_flush && reg_data_index)
				buf_dn_gate_stv2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv1_flush <= `DEF_UP_GATE_CPV1_FLUSH;
		else
			if (up_up_gate_cpv1_flush && reg_data_index)
				buf_up_gate_cpv1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv1_flush <= `DEF_DN_GATE_CPV1_FLUSH;
		else
			if (up_dn_gate_cpv1_flush && reg_data_index)
				buf_dn_gate_cpv1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_cpv2_flush <= `DEF_UP_GATE_CPV2_FLUSH;
		else
			if (up_up_gate_cpv2_flush && reg_data_index)
				buf_up_gate_cpv2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_cpv2_flush <= `DEF_DN_GATE_CPV2_FLUSH;
		else
			if (up_dn_gate_cpv2_flush && reg_data_index)
				buf_dn_gate_cpv2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe1_flush <= `DEF_UP_GATE_OE1_FLUSH;
		else
			if (up_up_gate_oe1_flush && reg_data_index)
				buf_up_gate_oe1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe1_flush <= `DEF_DN_GATE_OE1_FLUSH;
		else
			if (up_dn_gate_oe1_flush && reg_data_index)
				buf_dn_gate_oe1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_gate_oe2_flush <= `DEF_UP_GATE_OE2_FLUSH;
		else
			if (up_up_gate_oe2_flush && reg_data_index)
				buf_up_gate_oe2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_gate_oe2_flush <= `DEF_DN_GATE_OE2_FLUSH;
		else
			if (up_dn_gate_oe2_flush && reg_data_index)
				buf_dn_gate_oe2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_sync <= `DEF_UP_ROIC_SYNC;
		else
			if (up_up_roic_sync && reg_data_index)
				buf_up_roic_sync <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_0_read <= `DEF_UP_ROIC_ACLK_0_READ;
		else
			if (up_up_roic_aclk_0_read && reg_data_index)
				buf_up_roic_aclk_0_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_1_read <= `DEF_UP_ROIC_ACLK_1_READ;
		else
			if (up_up_roic_aclk_1_read && reg_data_index)
				buf_up_roic_aclk_1_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_2_read <= `DEF_UP_ROIC_ACLK_2_READ;
		else
			if (up_up_roic_aclk_2_read && reg_data_index)
				buf_up_roic_aclk_2_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_3_read <= `DEF_UP_ROIC_ACLK_3_READ;
		else
			if (up_up_roic_aclk_3_read && reg_data_index)
				buf_up_roic_aclk_3_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_4_read <= `DEF_UP_ROIC_ACLK_4_READ;
		else
			if (up_up_roic_aclk_4_read && reg_data_index)
				buf_up_roic_aclk_4_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_5_read <= `DEF_UP_ROIC_ACLK_5_READ;
		else
			if (up_up_roic_aclk_5_read && reg_data_index)
				buf_up_roic_aclk_5_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_6_read <= `DEF_UP_ROIC_ACLK_6_READ;
		else
			if (up_up_roic_aclk_6_read && reg_data_index)
				buf_up_roic_aclk_6_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_7_read <= `DEF_UP_ROIC_ACLK_7_READ;
		else
			if (up_up_roic_aclk_7_read && reg_data_index)
				buf_up_roic_aclk_7_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_8_read <= `DEF_UP_ROIC_ACLK_8_READ;
		else
			if (up_up_roic_aclk_8_read && reg_data_index)
				buf_up_roic_aclk_8_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_9_read <= `DEF_UP_ROIC_ACLK_9_READ;
		else
			if (up_up_roic_aclk_9_read && reg_data_index)
				buf_up_roic_aclk_9_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_10_read <= `DEF_UP_ROIC_ACLK_10_READ;
		else
			if (up_up_roic_aclk_10_read && reg_data_index)
				buf_up_roic_aclk_10_read <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_0_aed <= `DEF_UP_ROIC_ACLK_0_AED;
		else
			if (up_up_roic_aclk_0_aed && reg_data_index)
				buf_up_roic_aclk_0_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_1_aed <= `DEF_UP_ROIC_ACLK_1_AED;
		else
			if (up_up_roic_aclk_1_aed && reg_data_index)
				buf_up_roic_aclk_1_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_2_aed <= `DEF_UP_ROIC_ACLK_2_AED;
		else
			if (up_up_roic_aclk_2_aed && reg_data_index)
				buf_up_roic_aclk_2_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_3_aed <= `DEF_UP_ROIC_ACLK_3_AED;
		else
			if (up_up_roic_aclk_3_aed && reg_data_index)
				buf_up_roic_aclk_3_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_4_aed <= `DEF_UP_ROIC_ACLK_4_AED;
		else
			if (up_up_roic_aclk_4_aed && reg_data_index)
				buf_up_roic_aclk_4_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_5_aed <= `DEF_UP_ROIC_ACLK_5_AED;
		else
			if (up_up_roic_aclk_5_aed && reg_data_index)
				buf_up_roic_aclk_5_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_6_aed <= `DEF_UP_ROIC_ACLK_6_AED;
		else
			if (up_up_roic_aclk_6_aed && reg_data_index)
				buf_up_roic_aclk_6_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_7_aed <= `DEF_UP_ROIC_ACLK_7_AED;
		else
			if (up_up_roic_aclk_7_aed && reg_data_index)
				buf_up_roic_aclk_7_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_8_aed <= `DEF_UP_ROIC_ACLK_8_AED;
		else
			if (up_up_roic_aclk_8_aed && reg_data_index)
				buf_up_roic_aclk_8_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_9_aed <= `DEF_UP_ROIC_ACLK_9_AED;
		else
			if (up_up_roic_aclk_9_aed && reg_data_index)
				buf_up_roic_aclk_9_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_10_aed <= `DEF_UP_ROIC_ACLK_10_AED;
		else
			if (up_up_roic_aclk_10_aed && reg_data_index)
				buf_up_roic_aclk_10_aed <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_0_flush <= `DEF_UP_ROIC_ACLK_0_FLUSH;
		else
			if (up_up_roic_aclk_0_flush && reg_data_index)
				buf_up_roic_aclk_0_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_1_flush <= `DEF_UP_ROIC_ACLK_1_FLUSH;
		else
			if (up_up_roic_aclk_1_flush && reg_data_index)
				buf_up_roic_aclk_1_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_2_flush <= `DEF_UP_ROIC_ACLK_2_FLUSH;
		else
			if (up_up_roic_aclk_2_flush && reg_data_index)
				buf_up_roic_aclk_2_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_3_flush <= `DEF_UP_ROIC_ACLK_3_FLUSH;
		else
			if (up_up_roic_aclk_3_flush && reg_data_index)
				buf_up_roic_aclk_3_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_4_flush <= `DEF_UP_ROIC_ACLK_4_FLUSH;
		else
			if (up_up_roic_aclk_4_flush && reg_data_index)
				buf_up_roic_aclk_4_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_5_flush <= `DEF_UP_ROIC_ACLK_5_FLUSH;
		else
			if (up_up_roic_aclk_5_flush && reg_data_index)
				buf_up_roic_aclk_5_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_6_flush <= `DEF_UP_ROIC_ACLK_6_FLUSH;
		else
			if (up_up_roic_aclk_6_flush && reg_data_index)
				buf_up_roic_aclk_6_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_7_flush <= `DEF_UP_ROIC_ACLK_7_FLUSH;
		else
			if (up_up_roic_aclk_7_flush && reg_data_index)
				buf_up_roic_aclk_7_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_8_flush <= `DEF_UP_ROIC_ACLK_8_FLUSH;
		else
			if (up_up_roic_aclk_8_flush && reg_data_index)
				buf_up_roic_aclk_8_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_9_flush <= `DEF_UP_ROIC_ACLK_9_FLUSH;
		else
			if (up_up_roic_aclk_9_flush && reg_data_index)
				buf_up_roic_aclk_9_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_roic_aclk_10_flush <= `DEF_UP_ROIC_ACLK_10_FLUSH;
		else
			if (up_up_roic_aclk_10_flush && reg_data_index)
				buf_up_roic_aclk_10_flush <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_0 <= `DEF_ROIC_REG_SET_0;
		else
			if (up_roic_reg_set_0 && reg_data_index)
				buf_roic_reg_set_0 <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_1 <= `DEF_ROIC_REG_SET_1;
		else
			if (up_roic_reg_set_1 && reg_data_index)
				buf_roic_reg_set_1 <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_1_dual <= `DEF_ROIC_REG_SET_1_dual;
		else
			if (up_roic_reg_set_1_dual && reg_data_index)
				buf_roic_reg_set_1_dual <= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_2 <= `DEF_ROIC_REG_SET_2;
		else
			if (up_roic_reg_set_2 && reg_data_index)
				buf_roic_reg_set_2 <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_3 <= `DEF_ROIC_REG_SET_3;
		else
			if (up_roic_reg_set_3 && reg_data_index)
				buf_roic_reg_set_3 <= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_4 <= `DEF_ROIC_REG_SET_4;
		else
			if (up_roic_reg_set_4 && reg_data_index)
				buf_roic_reg_set_4<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_5 <= `DEF_ROIC_REG_SET_5;
		else
			if (up_roic_reg_set_5 && reg_data_index)
				buf_roic_reg_set_5<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_6 <= `DEF_ROIC_REG_SET_6;
		else
			if (up_roic_reg_set_6 && reg_data_index)
				buf_roic_reg_set_6<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_7 <= `DEF_ROIC_REG_SET_7;
		else
			if (up_roic_reg_set_7 && reg_data_index)
				buf_roic_reg_set_7<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_8 <= `DEF_ROIC_REG_SET_8;
		else
			if (up_roic_reg_set_8 && reg_data_index)
				buf_roic_reg_set_8<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_9 <= `DEF_ROIC_REG_SET_9;
		else
			if (up_roic_reg_set_9 && reg_data_index)
				buf_roic_reg_set_9<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_10 <= `DEF_ROIC_REG_SET_10;
		else
			if (up_roic_reg_set_10 && reg_data_index)
				buf_roic_reg_set_10<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_11 <= `DEF_ROIC_REG_SET_11;
		else
			if (up_roic_reg_set_11 && reg_data_index)
				buf_roic_reg_set_11<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_12 <= `DEF_ROIC_REG_SET_12;
		else
			if (up_roic_reg_set_12 && reg_data_index)
				buf_roic_reg_set_12<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_13 <= `DEF_ROIC_REG_SET_13;
		else
			if (up_roic_reg_set_13 && reg_data_index)
				buf_roic_reg_set_13<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_14 <= `DEF_ROIC_REG_SET_14;
		else
			if (up_roic_reg_set_14 && reg_data_index)
				buf_roic_reg_set_14<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_reg_set_15 <= `DEF_ROIC_REG_SET_15;
		else
			if (up_roic_reg_set_15 && reg_data_index)
				buf_roic_reg_set_15<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_roic_burst_cycle <= `DEF_ROIC_BURST_CYCLE;
		else
			if (up_roic_burst_cycle && reg_data_index)
				buf_roic_burst_cycle<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_start_roic_burst_clk <= `DEF_START_ROIC_BURST_CLK;
		else
			if (up_start_roic_burst_clk && reg_data_index)
				buf_start_roic_burst_clk<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_end_roic_burst_clk <= `DEF_END_ROIC_BURST_CLK;
		else
			if (up_end_roic_burst_clk && reg_data_index)
				buf_end_roic_burst_clk<= reg_data;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_io_delay_tab <= `DEF_IO_DELAY_TAB;
		else
			if (up_io_delay_tab && reg_data_index)
				buf_io_delay_tab<= reg_data[4:0];
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_sel_roic_reg <= `DEF_SEL_ROIC_REG;
		else
			if (up_sel_roic_reg && reg_data_index)
				buf_sel_roic_reg<= reg_data[7:0];
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_0 <= `DEF_DN_AED_GATE_XAO_0;
		else
			if (up_dn_aed_gate_xao_0 && reg_data_index)
				buf_dn_aed_gate_xao_0<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_1 <= `DEF_DN_AED_GATE_XAO_1;
		else
			if (up_dn_aed_gate_xao_1 && reg_data_index)
				buf_dn_aed_gate_xao_1<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_2 <= `DEF_DN_AED_GATE_XAO_2;
		else
			if (up_dn_aed_gate_xao_2 && reg_data_index)
				buf_dn_aed_gate_xao_2<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_3 <= `DEF_DN_AED_GATE_XAO_3;
		else
			if (up_dn_aed_gate_xao_3 && reg_data_index)
				buf_dn_aed_gate_xao_3<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_4 <= `DEF_DN_AED_GATE_XAO_4;
		else
			if (up_dn_aed_gate_xao_4 && reg_data_index)
				buf_dn_aed_gate_xao_4<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_dn_aed_gate_xao_5 <= `DEF_DN_AED_GATE_XAO_5;
		else
			if (up_dn_aed_gate_xao_5 && reg_data_index)
				buf_dn_aed_gate_xao_5<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_0 <= `DEF_UP_AED_GATE_XAO_0;
		else
			if (up_up_aed_gate_xao_0 && reg_data_index)
				buf_up_aed_gate_xao_0<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_1 <= `DEF_UP_AED_GATE_XAO_1;
		else
			if (up_up_aed_gate_xao_1 && reg_data_index)
				buf_up_aed_gate_xao_1<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_2 <= `DEF_UP_AED_GATE_XAO_2;
		else
			if (up_up_aed_gate_xao_2 && reg_data_index)
				buf_up_aed_gate_xao_2<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_3 <= `DEF_UP_AED_GATE_XAO_3;
		else
			if (up_up_aed_gate_xao_3 && reg_data_index)
				buf_up_aed_gate_xao_3<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_4 <= `DEF_UP_AED_GATE_XAO_4;
		else
			if (up_up_aed_gate_xao_4 && reg_data_index)
				buf_up_aed_gate_xao_4<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_up_aed_gate_xao_5 <= `DEF_UP_AED_GATE_XAO_5;
		else
			if (up_up_aed_gate_xao_5 && reg_data_index)
				buf_up_aed_gate_xao_5<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_ready_aed_read <= `DEF_READY_AED_READ;
		else
			if (up_ready_aed_read && reg_data_index)
				buf_ready_aed_read<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_th <= `DEF_AED_TH;
		else
			if (up_aed_th && reg_data_index)
				buf_aed_th<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_sel_aed_roic <= `DEF_SEL_AED_ROIC;
		else
			if (up_sel_aed_roic && reg_data_index)
				buf_sel_aed_roic<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_num_trigger <= `DEF_NUM_TRIGGER;
		else
			if (up_num_trigger && reg_data_index)
				buf_num_trigger<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_sel_aed_test_roic <= `DEF_SEL_AED_TEST_ROIC;
		else
			if (up_sel_aed_test_roic && reg_data_index)
				buf_sel_aed_test_roic<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_cmd <= `DEF_AED_CMD;
		else
			if (up_aed_cmd && reg_data_index)
				buf_aed_cmd<= reg_data; 
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_nega_aed_th <= `DEF_NEGA_AED_TH;
		else
			if (up_nega_aed_th && reg_data_index)
				buf_nega_aed_th<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_posi_aed_th <= `DEF_POSI_AED_TH;
		else
			if (up_posi_aed_th && reg_data_index)
				buf_posi_aed_th<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_dark_delay <= `DEF_AED_DARK_DELAY;
		else
			if (up_aed_dark_delay && reg_data_index)
				buf_aed_dark_delay<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_0 <= `DEF_AED_DETECT_LINE_0;
		else
			if (up_aed_detect_line_0 && reg_data_index)
				buf_aed_detect_line_0<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_1 <= `DEF_AED_DETECT_LINE_1;
		else
			if (up_aed_detect_line_1 && reg_data_index)
				buf_aed_detect_line_1<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_2 <= `DEF_AED_DETECT_LINE_2;
		else
			if (up_aed_detect_line_2 && reg_data_index)
				buf_aed_detect_line_2<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_3 <= `DEF_AED_DETECT_LINE_3;
		else
			if (up_aed_detect_line_3 && reg_data_index)
				buf_aed_detect_line_3<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_4 <= `DEF_AED_DETECT_LINE_4;
		else
			if (up_aed_detect_line_4 && reg_data_index)
				buf_aed_detect_line_4<= reg_data;
	end
	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			buf_aed_detect_line_5 <= `DEF_AED_DETECT_LINE_5;
		else
			if (up_aed_detect_line_5 && reg_data_index)
				buf_aed_detect_line_5<= reg_data;
	end

	always @(posedge eim_clk , negedge eim_rst) begin
		if (!eim_rst)
			buf_test_reg_9 <= 16'h0;
		else
			if (up_test_reg_9 && reg_data_index)
				buf_test_reg_9 <= reg_data;
	end

	assign s_test_reg_9 = buf_test_reg_9;
	
//----------------------------------------
// System setting
//----------------------------------------
	assign io_delay_tab = buf_io_delay_tab;
	assign sel_roic_reg = buf_sel_roic_reg;

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_sys_cmd_reg <= `DEF_SYS_CMD_REG;
		end
		else begin
			reg_sys_cmd_reg <= buf_sys_cmd_reg;
		end
	end

	assign org_reset_fsm	= reg_sys_cmd_reg[0];
	assign get_dark			= reg_sys_cmd_reg[1];
	assign sig_get_bright	= reg_sys_cmd_reg[2];
	assign soft_trigger		= reg_sys_cmd_reg[3];
	assign system_rst		= reg_sys_cmd_reg[4];
	assign dummy_get_image	= reg_sys_cmd_reg[8];

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			sig_reset_fsm_1d <= 1'b0;
//			sig_reset_fsm_2d <= 1'b0;
//			sig_reset_fsm_3d <= 1'b0;
//			sig_reset_fsm_4d <= 1'b0;
//			sig_reset_fsm_5d <= 1'b0;
//			sig_reset_fsm_6d <= 1'b0;
//			sig_reset_fsm_7d <= 1'b0;
//			sig_reset_fsm_8d <= 1'b0;
//			sig_reset_fsm_9d <= 1'b0;
		end
		else begin
			sig_reset_fsm_1d <= org_reset_fsm;
		end
	end

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			ack_tx_end_1d <= 1'b0;
			ack_tx_end_2d <= 1'b0;
		end
		else begin
			ack_tx_end_1d <= ack_tx_end;
			ack_tx_end_2d <= ack_tx_end_1d;
		end
	end

	assign hi_reset_fsm = org_reset_fsm & (~sig_reset_fsm_1d);
	assign lo_reset_fsm = ((~ack_tx_end_1d) & ack_tx_end_2d) & (~org_reset_fsm);
//	assign lo_reset_fsm = (~sig_reset_fsm_8d) & sig_reset_fsm_9d; // for sensonia roic

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reset_fsm <= 1'b1;
		end
		else begin
			if (lo_reset_fsm)
				reset_fsm <= 1'b0;
			else if (hi_reset_fsm)
				reset_fsm <= 1'b1;
		end
	end

//i2c
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_gate_gpio_reg <= `DEF_GATE_GPIO_REG;
		end
		else begin
			if (fsm_rst_index)
				reg_gate_gpio_reg <= buf_gate_gpio_reg;
		end
	end

//	assign data1             	= reg_gate_gpio_reg[7:0];
//	assign data2           		= reg_gate_gpio_reg[15:8];
	assign gate_gpio_data       = reg_gate_gpio_reg[15:0]; // 240703 data����
/////

//----------------------------------------
// OP mode setting
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_op_mode_reg <= `DEF_OP_MODE_REG;
		end
		else begin
			if (fsm_rst_index)
				reg_op_mode_reg <= buf_op_mode_reg;
		end
	end

	assign en_full_flush		= reg_op_mode_reg[0];
	assign en_panel_stable		= reg_op_mode_reg[1];
	assign en_16bit_adc			= reg_op_mode_reg[2];
	assign en_test_pattern_col	= reg_op_mode_reg[3];
	assign en_test_pattern_row	= reg_op_mode_reg[4];
	assign en_test_roic_col		= reg_op_mode_reg[5];
	assign en_test_roic_row		= reg_op_mode_reg[6];
	assign burst_get_image		= reg_op_mode_reg[8];

//----------------------------------------
// Gate Setting
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_set_gate <= `DEF_SET_GATE;
		end
		else begin
			if (fsm_rst_index)
				reg_set_gate <= buf_set_gate;
		end
	end

	assign gate_mode1			= reg_set_gate[0];
	assign gate_mode2			= reg_set_gate[1];
	assign gate_cs1				= reg_set_gate[2];
	assign gate_cs2				= reg_set_gate[3];
	assign gate_sel				= reg_set_gate[4];
	assign gate_ud				= reg_set_gate[5];
	assign gate_stv_mode		= reg_set_gate[6];
	assign gate_oepsn			= reg_set_gate[7];
	assign gate_lr1				= reg_set_gate[8];
	assign gate_lr2				= reg_set_gate[9];
	// assign 				= reg_set_gate[10];
	assign stv_sel_h				= reg_set_gate[11];
	assign stv_sel_l1				= reg_set_gate[12];
	assign stv_sel_r1				= reg_set_gate[13];
	assign stv_sel_l2				= reg_set_gate[14];
	assign stv_sel_r2				= reg_set_gate[15];

//----------------------------------------
// Gate IC Size
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			gate_size <= `DEF_GATE_SIZE;
		end
		else begin
			if(fsm_rst_index)
				gate_size <= buf_gate_size;
		end
	end

//----------------------------------------
// Power OFF & Down
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_pwr_off_dwn <= `DEF_PWR_OFF_DWN;
		end
		else begin
			if(fsm_rst_index)
				reg_pwr_off_dwn <= buf_pwr_off_dwn;
		end
	end

	assign en_pwr_dwn			= reg_pwr_off_dwn[0];
	assign en_pwr_off			= reg_pwr_off_dwn[1];

//----------------------------------------
// Readout counut
//----------------------------------------
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_readout_count <= `DEF_READOUT_COUNT;
		end
		else begin
			if(fsm_rst_index) begin
				reg_readout_count <= buf_readout_count;
			end
		end
	end
	assign readout_count 		= reg_readout_count[15:0];

//----------------------------------------
// Expose Size
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_expose_size <= `DEF_EXPOSE_SIZE;
			tmp_expose_size <= 18'd0;
		end
		else begin
			if(!fsm_exp_index) begin
				if (buf_expose_size == 16'd0) begin
					reg_expose_size <= 16'd1;
				end
				else begin
					reg_expose_size <= buf_expose_size;
				end
				tmp_expose_size <= {2'b00,reg_expose_size} + {2'b00,reg_pre_delay} + {2'b00,reg_post_delay};
			end
		end
	end

//----------------------------------------
// Ready Delay
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_ready_delay <= `DEF_READY_DELAY;
		end
		else begin
			if (!fsm_exp_index) begin
				if (buf_ready_delay == 16'd0)
					reg_ready_delay <= 16'd1;
				else
					reg_ready_delay <= buf_ready_delay;
			end
		end
	end

//----------------------------------------
// Pre-Delay
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_pre_delay <= `DEF_PRE_DELAY;
		end
		else begin
			if(!fsm_exp_index)
				reg_pre_delay <= buf_pre_delay;
		end
	end

//----------------------------------------
// Post-Delay
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_post_delay <= `DEF_POST_DELAY;
		end
		else begin
			reg_post_delay <= buf_post_delay;
		end
	end

//----------------------------------------
// Exp Ready rising point
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_exp_delay <= `DEF_EXP_DELAY;
			exp_delay <= 16'd0;
		end
		else begin
			if(fsm_rst_index) begin
				if (buf_exp_delay == 16'd0) begin
					reg_exp_delay <= 16'd1;
				end
				else begin
					reg_exp_delay <= buf_exp_delay;
				end
				exp_delay <= reg_exp_delay + reg_pre_delay;
			end
		end
	end

	assign exp_ack_end_cnt = reg_pre_delay + reg_expose_size;

//----------------------------------------
// Back Bias Size
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_back_bias_size <= `DEF_BACK_BIAS_SIZE;
		end
		else begin
			if(fsm_rst_index)
				reg_back_bias_size <= buf_back_bias_size;
		end
	end

//----------------------------------------
// Image Height
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_image_height		<= `DEF_IMAGE_HEIGHT;
			reg_aed_read_height		<= `DEF_IMAGE_HEIGHT;
			dsp_image_height		<= `DEF_IMAGE_HEIGHT;
		end
		else begin
			if(fsm_rst_index) begin
				reg_image_height		<= buf_image_height + 16'd2;
				reg_aed_read_height		<= buf_image_height + `AED_READ_ADDED_LINES;
				dsp_image_height		<= buf_image_height;
			end
		end
	end

//----------------------------------------
// CSI2 FRAME SIZE 1024 x 768
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_max_v_count			<= `DEF_MAX_V_COUNT;
			reg_max_h_count			<= `DEF_MAX_H_COUNT;
			reg_csi2_word_count		<= `DEF_CSI2_WORD_COUNT;
		end
		else begin
			reg_max_v_count			<= buf_max_v_count;
			reg_max_h_count			<= buf_max_h_count;
			reg_csi2_word_count		<= buf_csi2_word_count;
		end
	end

	assign rd_max_v_count = reg_max_v_count;
	assign rd_max_h_count = reg_max_h_count;
	assign rd_csi2_word_count = reg_csi2_word_count;
	assign max_v_count = reg_max_v_count;
	assign max_h_count = reg_max_h_count;
	assign csi2_word_count = reg_csi2_word_count;

	assign mux_image_height 	 = (fsm_back_bias_index	) ? reg_back_bias_size	: 
							  	   (fsm_aed_read_index	) ? reg_aed_read_height	: 
							  	   (fsm_exp_index		) ? tmp_expose_size[15:0]		: reg_image_height;

	assign aed_read_image_height = reg_image_height;
	assign rd_image_height = reg_image_height - 16'd2;

//----------------------------------------
// Cycle Width
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_cycle_width_flush	<= `DEF_CYCLE_WIDTH_FLUSH;
			reg_cycle_width_aed		<= `DEF_CYCLE_WIDTH_AED;
			reg_cycle_width_read	<= `DEF_CYCLE_WIDTH_READ;
		end
		else begin
			if(fsm_rst_index) begin
				reg_cycle_width_flush	<= buf_cycle_width_flush - 16'd3;
				reg_cycle_width_aed		<= buf_cycle_width_aed - 16'd3;
				reg_cycle_width_read	<= buf_cycle_width_read - 16'd3;
			end
		end
	end

	// assign cycle_width = (fsm_exp_index) 												? `FULL_CYCLE_WIDTH				: 
	assign cycle_width = (fsm_exp_index) 												? `MIN_UNIT				: 
						 (fsm_back_bias_index || (fsm_flush_index && (!en_full_flush))) ? {8'd0,reg_cycle_width_flush}	:
						 (fsm_flush_index && en_full_flush) 							? {8'd0,reg_cycle_width_read}	: 
						 (fsm_aed_read_index && (!valid_aed_read_skip)) 				? {8'd0,reg_cycle_width_aed}	:
						 (fsm_aed_read_index && valid_aed_read_skip) 					? {8'd0,reg_cycle_width_flush}	: 
						 																  {8'd0,reg_cycle_width_read}	;
	assign rd_cycle_width_flush		= reg_cycle_width_flush + 16'd3;
	assign rd_cycle_width_aed		= reg_cycle_width_aed + 16'd3;
	assign rd_cycle_width_read		= reg_cycle_width_read + 16'd3;

//----------------------------------------
// Frame repeatition
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_repeat_back_bias	<= `DEF_REPEAT_BACK_BIAS;
			reg_repeat_flush		<= `DEF_REPEAT_FLUSH;
		end
		else begin
			if(fsm_rst_index) begin
				reg_repeat_back_bias	<= buf_repeat_back_bias;
				reg_repeat_flush		<= buf_repeat_flush;
			end
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_saturation_flush_repeat <= `DEF_SATURATION_FLUSH_REPEAT;
		end
		else begin
			if(fsm_rst_index) begin
				reg_saturation_flush_repeat <= buf_saturation_flush_repeat;
			end
		end
	end

	assign saturation_flush_repeat	= reg_saturation_flush_repeat[7:0];
	assign tmp_repeat_back_bias 	= (reg_repeat_back_bias == 16'd0) ? 16'd1 : reg_repeat_back_bias;
	assign tmp_repeat_flush			= (reg_repeat_flush == 16'd0) ? 16'd1 : reg_repeat_flush;

	assign frame_rpt				= (fsm_back_bias_index) ? tmp_repeat_back_bias[7:0] : 
					   				  (fsm_flush_index) ? tmp_repeat_flush[7:0] : 8'd1;

	assign en_back_bias				= (reg_repeat_back_bias == 16'd0) ? 1'b0 : 1'b1;
	assign en_flush					= (reg_repeat_flush == 16'd0) ? 1'b0 : 1'b1;

//----------------------------------------
// Back bias Driving
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_back_bias	<= `DEF_UP_BACK_BIAS;
			dn_back_bias	<= `DEF_DN_BACK_BIAS;
		end
		else begin
			if(fsm_rst_index) begin
				up_back_bias <= buf_up_back_bias;
				dn_back_bias <= buf_dn_back_bias;
			end
		end
	end

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_back_bias_opr	<= `DEF_UP_BACK_BIAS_OPR;
			dn_back_bias_opr	<= `DEF_DN_BACK_BIAS_OPR;
		end
		else begin
			if(fsm_rst_index) begin
				up_back_bias_opr <= buf_up_back_bias_opr;
				dn_back_bias_opr <= buf_dn_back_bias_opr;
			end
		end
	end

//----------------------------------------
// Gate STV Driving
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_gate_stv1_aed	<= `DEF_UP_GATE_STV1_AED	;
			dn_gate_stv1_aed	<= `DEF_DN_GATE_STV1_AED	;
			up_gate_stv1_flush	<= `DEF_UP_GATE_STV1_FLUSH	;
			dn_gate_stv1_flush	<= `DEF_DN_GATE_STV1_FLUSH	;
			up_gate_stv1_read	<= `DEF_UP_GATE_STV1_READ	;
			dn_gate_stv1_read	<= `DEF_DN_GATE_STV1_READ	;
			up_gate_stv2_aed	<= `DEF_UP_GATE_STV2_AED	;
			dn_gate_stv2_aed	<= `DEF_DN_GATE_STV2_AED	;
			up_gate_stv2_flush	<= `DEF_UP_GATE_STV2_FLUSH	;
			dn_gate_stv2_flush	<= `DEF_DN_GATE_STV2_FLUSH	;
			up_gate_stv2_read	<= `DEF_UP_GATE_STV2_READ	;
			dn_gate_stv2_read	<= `DEF_DN_GATE_STV2_READ	;
		end
		else begin
			if(fsm_rst_index) begin
				up_gate_stv1_aed	<= buf_up_gate_stv1_aed		;
				dn_gate_stv1_aed	<= buf_dn_gate_stv1_aed		;
				up_gate_stv1_flush	<= buf_up_gate_stv1_flush	;
				dn_gate_stv1_flush	<= buf_dn_gate_stv1_flush	;
				up_gate_stv1_read	<= buf_up_gate_stv1_read	;
				dn_gate_stv1_read	<= buf_dn_gate_stv1_read	;
				up_gate_stv2_aed	<= buf_up_gate_stv2_aed		;
				dn_gate_stv2_aed	<= buf_dn_gate_stv2_aed		;
				up_gate_stv2_flush	<= buf_up_gate_stv2_flush	;
				dn_gate_stv2_flush	<= buf_dn_gate_stv2_flush	;
				up_gate_stv2_read	<= buf_up_gate_stv2_read	;
				dn_gate_stv2_read	<= buf_dn_gate_stv2_read	;
			end
		end
	end

	assign flush_operation 	= fsm_back_bias_index						|
							 (fsm_flush_index & (~en_full_flush))		|
							 (fsm_aed_read_index & valid_aed_read_skip)	;

	assign up_gate_stv1		= (flush_operation		) ? up_gate_stv1_flush	: 
							  (fsm_aed_read_index	) ? up_gate_stv1_aed	:
							  							up_gate_stv1_read	;
	assign dn_gate_stv1		= (flush_operation		) ? dn_gate_stv1_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_stv1_aed	:
							  							dn_gate_stv1_read	;
	assign up_gate_stv2		= (flush_operation		) ? up_gate_stv2_flush	: 
							  (fsm_aed_read_index	) ? up_gate_stv2_aed	:
							  							up_gate_stv2_read	;
	assign dn_gate_stv2		= (flush_operation		) ? dn_gate_stv2_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_stv2_aed	:
							  							dn_gate_stv2_read	;

//----------------------------------------
// Gate Cpv Driving
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_gate_cpv1_aed	<= `DEF_UP_GATE_CPV1_AED	;
			dn_gate_cpv1_aed	<= `DEF_DN_GATE_CPV1_AED	;
			up_gate_cpv1_flush	<= `DEF_UP_GATE_CPV1_FLUSH	;
			dn_gate_cpv1_flush	<= `DEF_DN_GATE_CPV1_FLUSH	;
			up_gate_cpv1_read	<= `DEF_UP_GATE_CPV1_READ	;
			dn_gate_cpv1_read	<= `DEF_DN_GATE_CPV1_READ	;
			up_gate_cpv2_aed	<= `DEF_UP_GATE_CPV2_AED	;
			dn_gate_cpv2_aed	<= `DEF_DN_GATE_CPV2_AED	;
			up_gate_cpv2_flush	<= `DEF_UP_GATE_CPV2_FLUSH	;
			dn_gate_cpv2_flush	<= `DEF_DN_GATE_CPV2_FLUSH	;
			up_gate_cpv2_read	<= `DEF_UP_GATE_CPV2_READ	;
			dn_gate_cpv2_read	<= `DEF_DN_GATE_CPV2_READ	;
		end
		else begin
			if(fsm_rst_index) begin
				up_gate_cpv1_aed	<= buf_up_gate_cpv1_aed		;
				dn_gate_cpv1_aed	<= buf_dn_gate_cpv1_aed		;
				up_gate_cpv1_flush	<= buf_up_gate_cpv1_flush	;
				dn_gate_cpv1_flush	<= buf_dn_gate_cpv1_flush	;
				up_gate_cpv1_read	<= buf_up_gate_cpv1_read	;
				dn_gate_cpv1_read	<= buf_dn_gate_cpv1_read	;
				up_gate_cpv2_aed	<= buf_up_gate_cpv2_aed		;
				dn_gate_cpv2_aed	<= buf_dn_gate_cpv2_aed		;
				up_gate_cpv2_flush	<= buf_up_gate_cpv2_flush	;
				dn_gate_cpv2_flush	<= buf_dn_gate_cpv2_flush	;
				up_gate_cpv2_read	<= buf_up_gate_cpv2_read	;
				dn_gate_cpv2_read	<= buf_dn_gate_cpv2_read	;
			end
		end
	end

	assign up_gate_cpv1		= (flush_operation		) ? up_gate_cpv1_flush	: 
							  (fsm_aed_read_index	) ? up_gate_cpv1_aed	:
							  							up_gate_cpv1_read	;
	assign dn_gate_cpv1		= (flush_operation		) ? dn_gate_cpv1_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_cpv1_aed	:
							  							dn_gate_cpv1_read	;
	assign up_gate_cpv2		= (flush_operation		) ? up_gate_cpv2_flush	: 
							  (fsm_aed_read_index	) ? up_gate_cpv2_aed	:
							  							up_gate_cpv2_read	;
	assign dn_gate_cpv2		= (flush_operation		) ? dn_gate_cpv2_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_cpv2_aed	:
							  							dn_gate_cpv2_read	;

//----------------------------------------
// Gate OE Driving
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_gate_oe1_aed		<= `DEF_UP_GATE_OE1_AED		;
			dn_gate_oe1_aed		<= `DEF_DN_GATE_OE1_AED		;
			up_gate_oe1_flush	<= `DEF_UP_GATE_OE1_FLUSH	;
			dn_gate_oe1_flush	<= `DEF_DN_GATE_OE1_FLUSH	;
			up_gate_oe1_read	<= `DEF_UP_GATE_OE1_READ	;
			dn_gate_oe1_read	<= `DEF_DN_GATE_OE1_READ	;
			up_gate_oe2_aed		<= `DEF_UP_GATE_OE2_AED		;
			dn_gate_oe2_aed		<= `DEF_DN_GATE_OE2_AED		;
			up_gate_oe2_flush	<= `DEF_UP_GATE_OE2_FLUSH	;
			dn_gate_oe2_flush	<= `DEF_DN_GATE_OE2_FLUSH	;
			up_gate_oe2_read	<= `DEF_UP_GATE_OE2_READ	;
			dn_gate_oe2_read	<= `DEF_DN_GATE_OE2_READ	;
		end
		else begin
			if(fsm_rst_index) begin
				up_gate_oe1_aed		<= buf_up_gate_oe1_aed		;
				dn_gate_oe1_aed		<= buf_dn_gate_oe1_aed		;
				up_gate_oe1_flush	<= buf_up_gate_oe1_flush	;
				dn_gate_oe1_flush	<= buf_dn_gate_oe1_flush	;
				up_gate_oe1_read	<= buf_up_gate_oe1_read		;
				dn_gate_oe1_read	<= buf_dn_gate_oe1_read		;
				up_gate_oe2_aed		<= buf_up_gate_oe2_aed		;
				dn_gate_oe2_aed		<= buf_dn_gate_oe2_aed		;
				up_gate_oe2_flush	<= buf_up_gate_oe2_flush	;
				dn_gate_oe2_flush	<= buf_dn_gate_oe2_flush	;
				up_gate_oe2_read	<= buf_up_gate_oe2_read		;
				dn_gate_oe2_read	<= buf_dn_gate_oe2_read		;
			end
		end
	end

	assign up_gate_oe1		= (flush_operation		) ? up_gate_oe1_flush	: 
							  (fsm_aed_read_index	) ? up_gate_oe1_aed		:
							  							up_gate_oe1_read	;
	assign dn_gate_oe1		= (flush_operation		) ? dn_gate_oe1_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_oe1_aed		:
							  							dn_gate_oe1_read	;
	assign up_gate_oe2		= (flush_operation		) ? up_gate_oe2_flush	: 
							  (fsm_aed_read_index	) ? up_gate_oe2_aed		:
							  							up_gate_oe2_read	;
	assign dn_gate_oe2		= (flush_operation		) ? dn_gate_oe2_flush	: 
							  (fsm_aed_read_index	) ? dn_gate_oe2_aed		:
							  							dn_gate_oe2_read	;

//----------------------------------------
// Gate XAO Driving
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			dn_aed_gate_xao_0	<= `DEF_DN_AED_GATE_XAO_0;
			dn_aed_gate_xao_1	<= `DEF_DN_AED_GATE_XAO_1;
			dn_aed_gate_xao_2	<= `DEF_DN_AED_GATE_XAO_2;
			dn_aed_gate_xao_3	<= `DEF_DN_AED_GATE_XAO_3;
			dn_aed_gate_xao_4	<= `DEF_DN_AED_GATE_XAO_4;
			dn_aed_gate_xao_5	<= `DEF_DN_AED_GATE_XAO_5;
			up_aed_gate_xao_0	<= `DEF_UP_AED_GATE_XAO_0;
			up_aed_gate_xao_1	<= `DEF_UP_AED_GATE_XAO_1;
			up_aed_gate_xao_2	<= `DEF_UP_AED_GATE_XAO_2;
			up_aed_gate_xao_3	<= `DEF_UP_AED_GATE_XAO_3;
			up_aed_gate_xao_4	<= `DEF_UP_AED_GATE_XAO_4;
			up_aed_gate_xao_5	<= `DEF_UP_AED_GATE_XAO_5;
		end
		else begin
			if(fsm_rst_index) begin
				dn_aed_gate_xao_0	<= buf_dn_aed_gate_xao_0;
				dn_aed_gate_xao_1	<= buf_dn_aed_gate_xao_1;
				dn_aed_gate_xao_2	<= buf_dn_aed_gate_xao_2;
				dn_aed_gate_xao_3	<= buf_dn_aed_gate_xao_3;
				dn_aed_gate_xao_4	<= buf_dn_aed_gate_xao_4;
				dn_aed_gate_xao_5	<= buf_dn_aed_gate_xao_5;
				up_aed_gate_xao_0	<= buf_up_aed_gate_xao_0;
				up_aed_gate_xao_1	<= buf_up_aed_gate_xao_1;
				up_aed_gate_xao_2	<= buf_up_aed_gate_xao_2;
				up_aed_gate_xao_3	<= buf_up_aed_gate_xao_3;
				up_aed_gate_xao_4	<= buf_up_aed_gate_xao_4;
				up_aed_gate_xao_5	<= buf_up_aed_gate_xao_5;
			end
		end
	end
//----------------------------------------
// AED Detect line 
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			aed_detect_line_0			<= `DEF_AED_DETECT_LINE_0;
			aed_detect_line_1   		<= `DEF_AED_DETECT_LINE_1;
			aed_detect_line_2   		<= `DEF_AED_DETECT_LINE_2;
			aed_detect_line_3   		<= `DEF_AED_DETECT_LINE_3;
			aed_detect_line_4   		<= `DEF_AED_DETECT_LINE_4;
			aed_detect_line_5   		<= `DEF_AED_DETECT_LINE_5;
		end
		else begin
			if(fsm_rst_index) begin
				aed_detect_line_0	<= buf_aed_detect_line_0;
				aed_detect_line_1	<= buf_aed_detect_line_1;
				aed_detect_line_2	<= buf_aed_detect_line_2;
				aed_detect_line_3	<= buf_aed_detect_line_3;
				aed_detect_line_4	<= buf_aed_detect_line_4;
				aed_detect_line_5	<= buf_aed_detect_line_5;
			end
		end
	end

//----------------------------------------
// ROIC Sync
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			up_roic_sync <= `DEF_UP_ROIC_SYNC;
		end
		else begin
			if(fsm_rst_index)
				up_roic_sync <= buf_up_roic_sync;
		end
	end

//----------------------------------------
// ROIC ACLK
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_up_roic_aclk_0_read		<= `DEF_UP_ROIC_ACLK_0_READ		;
			reg_up_roic_aclk_1_read		<= `DEF_UP_ROIC_ACLK_1_READ		;
			reg_up_roic_aclk_2_read		<= `DEF_UP_ROIC_ACLK_2_READ		;
			reg_up_roic_aclk_3_read		<= `DEF_UP_ROIC_ACLK_3_READ		;
			reg_up_roic_aclk_4_read		<= `DEF_UP_ROIC_ACLK_4_READ		;
			reg_up_roic_aclk_5_read		<= `DEF_UP_ROIC_ACLK_5_READ		;
			reg_up_roic_aclk_6_read		<= `DEF_UP_ROIC_ACLK_6_READ		;
			reg_up_roic_aclk_7_read		<= `DEF_UP_ROIC_ACLK_7_READ		;
			reg_up_roic_aclk_8_read		<= `DEF_UP_ROIC_ACLK_8_READ		;
			reg_up_roic_aclk_9_read		<= `DEF_UP_ROIC_ACLK_9_READ		;
			reg_up_roic_aclk_10_read	<= `DEF_UP_ROIC_ACLK_10_READ	;
			reg_up_roic_aclk_0_aed		<= `DEF_UP_ROIC_ACLK_0_AED		;
			reg_up_roic_aclk_1_aed		<= `DEF_UP_ROIC_ACLK_1_AED		;
			reg_up_roic_aclk_2_aed		<= `DEF_UP_ROIC_ACLK_2_AED		;
			reg_up_roic_aclk_3_aed		<= `DEF_UP_ROIC_ACLK_3_AED		;
			reg_up_roic_aclk_4_aed		<= `DEF_UP_ROIC_ACLK_4_AED		;
			reg_up_roic_aclk_5_aed		<= `DEF_UP_ROIC_ACLK_5_AED		;
			reg_up_roic_aclk_6_aed		<= `DEF_UP_ROIC_ACLK_6_AED		;
			reg_up_roic_aclk_7_aed		<= `DEF_UP_ROIC_ACLK_7_AED		;
			reg_up_roic_aclk_8_aed		<= `DEF_UP_ROIC_ACLK_8_AED		;
			reg_up_roic_aclk_9_aed		<= `DEF_UP_ROIC_ACLK_9_AED		;
			reg_up_roic_aclk_10_aed		<= `DEF_UP_ROIC_ACLK_10_AED		;
			reg_up_roic_aclk_0_flush	<= `DEF_UP_ROIC_ACLK_0_FLUSH	;
			reg_up_roic_aclk_1_flush	<= `DEF_UP_ROIC_ACLK_1_FLUSH	;
			reg_up_roic_aclk_2_flush	<= `DEF_UP_ROIC_ACLK_2_FLUSH	;
			reg_up_roic_aclk_3_flush	<= `DEF_UP_ROIC_ACLK_3_FLUSH	;
			reg_up_roic_aclk_4_flush	<= `DEF_UP_ROIC_ACLK_4_FLUSH	;
			reg_up_roic_aclk_5_flush	<= `DEF_UP_ROIC_ACLK_5_FLUSH	;
			reg_up_roic_aclk_6_flush	<= `DEF_UP_ROIC_ACLK_6_FLUSH	;
			reg_up_roic_aclk_7_flush	<= `DEF_UP_ROIC_ACLK_7_FLUSH	;
			reg_up_roic_aclk_8_flush	<= `DEF_UP_ROIC_ACLK_8_FLUSH	;
			reg_up_roic_aclk_9_flush	<= `DEF_UP_ROIC_ACLK_9_FLUSH	;
			reg_up_roic_aclk_10_flush	<= `DEF_UP_ROIC_ACLK_10_FLUSH	;
		end
		else begin
			if(fsm_rst_index) begin
				reg_up_roic_aclk_0_read		<= buf_up_roic_aclk_0_read		;
				reg_up_roic_aclk_1_read		<= buf_up_roic_aclk_1_read		;
				reg_up_roic_aclk_2_read		<= buf_up_roic_aclk_2_read		;
				reg_up_roic_aclk_3_read		<= buf_up_roic_aclk_3_read		;
				reg_up_roic_aclk_4_read		<= buf_up_roic_aclk_4_read		;
				reg_up_roic_aclk_5_read		<= buf_up_roic_aclk_5_read		;
				reg_up_roic_aclk_6_read		<= buf_up_roic_aclk_6_read		;
				reg_up_roic_aclk_7_read		<= buf_up_roic_aclk_7_read		;
				reg_up_roic_aclk_8_read		<= buf_up_roic_aclk_8_read		;
				reg_up_roic_aclk_9_read		<= buf_up_roic_aclk_9_read		;
				reg_up_roic_aclk_10_read	<= buf_up_roic_aclk_10_read		;
				reg_up_roic_aclk_0_aed		<= buf_up_roic_aclk_0_aed		;
				reg_up_roic_aclk_1_aed		<= buf_up_roic_aclk_1_aed		;
				reg_up_roic_aclk_2_aed		<= buf_up_roic_aclk_2_aed		;
				reg_up_roic_aclk_3_aed		<= buf_up_roic_aclk_3_aed		;
				reg_up_roic_aclk_4_aed		<= buf_up_roic_aclk_4_aed		;
				reg_up_roic_aclk_5_aed		<= buf_up_roic_aclk_5_aed		;
				reg_up_roic_aclk_6_aed		<= buf_up_roic_aclk_6_aed		;
				reg_up_roic_aclk_7_aed		<= buf_up_roic_aclk_7_aed		;
				reg_up_roic_aclk_8_aed		<= buf_up_roic_aclk_8_aed		;
				reg_up_roic_aclk_9_aed		<= buf_up_roic_aclk_9_aed		;
				reg_up_roic_aclk_10_aed		<= buf_up_roic_aclk_10_aed		;
				reg_up_roic_aclk_0_flush	<= buf_up_roic_aclk_0_flush		;
				reg_up_roic_aclk_1_flush	<= buf_up_roic_aclk_1_flush		;
				reg_up_roic_aclk_2_flush	<= buf_up_roic_aclk_2_flush		;
				reg_up_roic_aclk_3_flush	<= buf_up_roic_aclk_3_flush		;
				reg_up_roic_aclk_4_flush	<= buf_up_roic_aclk_4_flush		;
				reg_up_roic_aclk_5_flush	<= buf_up_roic_aclk_5_flush		;
				reg_up_roic_aclk_6_flush	<= buf_up_roic_aclk_6_flush		;
				reg_up_roic_aclk_7_flush	<= buf_up_roic_aclk_7_flush		;
				reg_up_roic_aclk_8_flush	<= buf_up_roic_aclk_8_flush		;
				reg_up_roic_aclk_9_flush	<= buf_up_roic_aclk_9_flush		;
				reg_up_roic_aclk_10_flush	<= buf_up_roic_aclk_10_flush	;
			end
		end
	end

	assign up_roic_aclk_0		=	(flush_operation		) ? reg_up_roic_aclk_0_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_0_aed		:
																reg_up_roic_aclk_0_read		;
	assign up_roic_aclk_1		=	(flush_operation		) ? reg_up_roic_aclk_1_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_1_aed		:
																reg_up_roic_aclk_1_read		;
	assign up_roic_aclk_2		=	(flush_operation		) ? reg_up_roic_aclk_2_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_2_aed		:
																reg_up_roic_aclk_2_read		;
	assign up_roic_aclk_3		=	(flush_operation		) ? reg_up_roic_aclk_3_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_3_aed		:
																reg_up_roic_aclk_3_read		;
	assign up_roic_aclk_4		=	(flush_operation		) ? reg_up_roic_aclk_4_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_4_aed		:
																reg_up_roic_aclk_4_read		;
	assign up_roic_aclk_5		=	(flush_operation		) ? reg_up_roic_aclk_5_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_5_aed		:
																reg_up_roic_aclk_5_read		;
	assign up_roic_aclk_6		=	(flush_operation		) ? reg_up_roic_aclk_6_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_6_aed		:
																reg_up_roic_aclk_6_read		;
	assign up_roic_aclk_7		=	(flush_operation		) ? reg_up_roic_aclk_7_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_7_aed		:
																reg_up_roic_aclk_7_read		;
	assign up_roic_aclk_8		=	(flush_operation		) ? reg_up_roic_aclk_8_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_8_aed		:
																reg_up_roic_aclk_8_read		;
	assign up_roic_aclk_9		=	(flush_operation		) ? reg_up_roic_aclk_9_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_9_aed		:
																reg_up_roic_aclk_9_read		;
	assign up_roic_aclk_10		=	(flush_operation		) ? reg_up_roic_aclk_10_flush	:
									(fsm_aed_read_index		) ? reg_up_roic_aclk_10_aed		:
																reg_up_roic_aclk_10_read	;

//----------------------------------------
// ROIC Register
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			roic_reg_set_0	<= `DEF_ROIC_REG_SET_0 ;
			roic_reg_set_1	<= `DEF_ROIC_REG_SET_1 ;
			roic_reg_set_1_dual	<= `DEF_ROIC_REG_SET_1_dual ;
			roic_reg_set_2	<= `DEF_ROIC_REG_SET_2 ;
			roic_reg_set_3	<= `DEF_ROIC_REG_SET_3 ;
			roic_reg_set_4	<= `DEF_ROIC_REG_SET_4 ;
			roic_reg_set_5	<= `DEF_ROIC_REG_SET_5 ;
			roic_reg_set_6	<= `DEF_ROIC_REG_SET_6 ;
			roic_reg_set_7	<= `DEF_ROIC_REG_SET_7 ;
			roic_reg_set_8	<= `DEF_ROIC_REG_SET_8 ;
			roic_reg_set_9	<= `DEF_ROIC_REG_SET_9 ;
			roic_reg_set_10	<= `DEF_ROIC_REG_SET_10;
			roic_reg_set_11	<= `DEF_ROIC_REG_SET_11;
			roic_reg_set_12	<= `DEF_ROIC_REG_SET_12;
			roic_reg_set_13	<= `DEF_ROIC_REG_SET_13;
			roic_reg_set_14	<= `DEF_ROIC_REG_SET_14;
			roic_reg_set_15	<= `DEF_ROIC_REG_SET_15;
		end
		else begin
			if(fsm_rst_index) begin
				roic_reg_set_0	<= buf_roic_reg_set_0 ;
				roic_reg_set_1	<= buf_roic_reg_set_1 ;
				roic_reg_set_1_dual	<= buf_roic_reg_set_1_dual ;
				roic_reg_set_2	<= buf_roic_reg_set_2 ;
				roic_reg_set_3	<= buf_roic_reg_set_3 ;
				roic_reg_set_4	<= buf_roic_reg_set_4 ;
				roic_reg_set_5	<= buf_roic_reg_set_5 ;
				roic_reg_set_6	<= buf_roic_reg_set_6 ;
				roic_reg_set_7	<= buf_roic_reg_set_7 ;
				roic_reg_set_8	<= buf_roic_reg_set_8 ;
				roic_reg_set_9	<= buf_roic_reg_set_9 ;
				roic_reg_set_10	<= buf_roic_reg_set_10;
				roic_reg_set_11	<= buf_roic_reg_set_11;
				roic_reg_set_12	<= buf_roic_reg_set_12;
				roic_reg_set_13	<= buf_roic_reg_set_13;
				roic_reg_set_14	<= buf_roic_reg_set_14;
				roic_reg_set_15	<= buf_roic_reg_set_15;
			end
		end
	end

	assign reg_read_thr_spi = (buf_sel_roic_reg == 8'd0) ? 1'b1 : 1'b0;

	always @(posedge sys_clk or negedge sys_rst) begin
		if(!sys_rst) begin
			rd_roic_reg_set_0	<= `DEF_ROIC_REG_SET_0 ;
			rd_roic_reg_set_1	<= `DEF_ROIC_REG_SET_1 ;
			rd_roic_reg_set_1_dual	<= `DEF_ROIC_REG_SET_1_dual ;
			rd_roic_reg_set_2	<= `DEF_ROIC_REG_SET_2 ;
			rd_roic_reg_set_3	<= `DEF_ROIC_REG_SET_3 ;
			rd_roic_reg_set_4	<= `DEF_ROIC_REG_SET_4 ;
			rd_roic_reg_set_5	<= `DEF_ROIC_REG_SET_5 ;
			rd_roic_reg_set_6	<= `DEF_ROIC_REG_SET_6 ;
			rd_roic_reg_set_7	<= `DEF_ROIC_REG_SET_7 ;
			rd_roic_reg_set_8	<= `DEF_ROIC_REG_SET_8 ;
			rd_roic_reg_set_9	<= `DEF_ROIC_REG_SET_9 ;
			rd_roic_reg_set_10	<= `DEF_ROIC_REG_SET_10;
			rd_roic_reg_set_11	<= `DEF_ROIC_REG_SET_11;
			rd_roic_reg_set_12	<= `DEF_ROIC_REG_SET_12;
			rd_roic_reg_set_13	<= `DEF_ROIC_REG_SET_13;
			rd_roic_reg_set_14	<= `DEF_ROIC_REG_SET_14;
			rd_roic_reg_set_15	<= `DEF_ROIC_REG_SET_15;
		end
		else begin
			if (up_roic_reg && (!reg_read_thr_spi)) begin
				rd_roic_reg_set_0	<= roic_reg_in_a[63:48]	;
				rd_roic_reg_set_1	<= roic_reg_in_b[63:48]	;
				// rd_roic_reg_set_0_dual	<= l_roic_reg_in_a[63:48]	;
				rd_roic_reg_set_1_dual	<= l_roic_reg_in_b[63:48]	;
				rd_roic_reg_set_2	<= roic_reg_in_a[47:32]	;
				rd_roic_reg_set_3	<= roic_reg_in_b[47:32]	;
				rd_roic_reg_set_4	<= roic_reg_in_a[31:16]	;
				rd_roic_reg_set_5	<= roic_reg_in_b[31:16]	;
				rd_roic_reg_set_6	<= roic_reg_in_a[15: 0]	;
				rd_roic_reg_set_7	<= roic_reg_in_b[15: 0]	;
				rd_roic_reg_set_8	<= roic_reg_set_8		;
				rd_roic_reg_set_9	<= roic_reg_set_9		;
				rd_roic_reg_set_10	<= roic_reg_set_10		;
				rd_roic_reg_set_11	<= roic_reg_set_11		;
				rd_roic_reg_set_12	<= roic_reg_set_12		;
				rd_roic_reg_set_13	<= roic_reg_set_13		;
				rd_roic_reg_set_14	<= roic_reg_set_14		;
				rd_roic_reg_set_15	<= roic_reg_set_15		;
			end
			else if (reg_read_thr_spi) begin
				rd_roic_reg_set_0	<= roic_reg_set_0		;
				rd_roic_reg_set_1	<= roic_reg_set_1		;
				rd_roic_reg_set_1_dual	<= roic_reg_set_1_dual		;
				rd_roic_reg_set_2	<= roic_reg_set_2		;
				rd_roic_reg_set_3	<= roic_reg_set_3		;
				rd_roic_reg_set_4	<= roic_reg_set_4		;
				rd_roic_reg_set_5	<= roic_reg_set_5		;
				rd_roic_reg_set_6	<= roic_reg_set_6		;
				rd_roic_reg_set_7	<= roic_reg_set_7		;
				rd_roic_reg_set_8	<= roic_reg_set_8		;
				rd_roic_reg_set_9	<= roic_reg_set_9		;
				rd_roic_reg_set_10	<= roic_reg_set_10		;
				rd_roic_reg_set_11	<= roic_reg_set_11		;
				rd_roic_reg_set_12	<= roic_reg_set_12		;
				rd_roic_reg_set_13	<= roic_reg_set_13		;
				rd_roic_reg_set_14	<= roic_reg_set_14		;
				rd_roic_reg_set_15	<= roic_reg_set_15		;
			end
		end
	end

//----------------------------------------
// ROIC Data Out Tx Index
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			burst_break_pt_0 <= `DEF_BURST_BREAK_PT_0;
		end
		else begin
			burst_break_pt_0 <= up_roic_sync;
		end
	end

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			burst_break_pt_1 <= `DEF_BURST_BREAK_PT_1;
		end
		else begin
			case(roic_reg_set_4[3:0])
				4'd1 : burst_break_pt_1 <= reg_up_roic_aclk_1_read;
				4'd2 : burst_break_pt_1 <= reg_up_roic_aclk_2_read;
				4'd3 : burst_break_pt_1 <= reg_up_roic_aclk_3_read;
				4'd4 : burst_break_pt_1 <= reg_up_roic_aclk_4_read;
				4'd5 : burst_break_pt_1 <= reg_up_roic_aclk_5_read;
				4'd6 : burst_break_pt_1 <= reg_up_roic_aclk_6_read;
				4'd7 : burst_break_pt_1 <= reg_up_roic_aclk_7_read;
				4'd8 : burst_break_pt_1 <= reg_up_roic_aclk_8_read;
				4'd9 : burst_break_pt_1 <= reg_up_roic_aclk_9_read;
			endcase
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			burst_break_pt_2 <= `DEF_BURST_BREAK_PT_2;
		end
		else begin
			case(roic_reg_set_5[3:0])
				4'd1 : burst_break_pt_2 <= reg_up_roic_aclk_1_read;
				4'd2 : burst_break_pt_2 <= reg_up_roic_aclk_2_read;
				4'd3 : burst_break_pt_2 <= reg_up_roic_aclk_3_read;
				4'd4 : burst_break_pt_2 <= reg_up_roic_aclk_4_read;
				4'd5 : burst_break_pt_2 <= reg_up_roic_aclk_5_read;
				4'd6 : burst_break_pt_2 <= reg_up_roic_aclk_6_read;
				4'd7 : burst_break_pt_2 <= reg_up_roic_aclk_7_read;
				4'd8 : burst_break_pt_2 <= reg_up_roic_aclk_8_read;
				4'd9 : burst_break_pt_2 <= reg_up_roic_aclk_9_read;
			endcase
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			burst_break_pt_3 <= `DEF_BURST_BREAK_PT_3;
		end
		else begin
			case(roic_reg_set_6[3:0])
				4'd1 : burst_break_pt_3 <= reg_up_roic_aclk_1_read;
				4'd2 : burst_break_pt_3 <= reg_up_roic_aclk_2_read;
				4'd3 : burst_break_pt_3 <= reg_up_roic_aclk_3_read;
				4'd4 : burst_break_pt_3 <= reg_up_roic_aclk_4_read;
				4'd5 : burst_break_pt_3 <= reg_up_roic_aclk_5_read;
				4'd6 : burst_break_pt_3 <= reg_up_roic_aclk_6_read;
				4'd7 : burst_break_pt_3 <= reg_up_roic_aclk_7_read;
				4'd8 : burst_break_pt_3 <= reg_up_roic_aclk_8_read;
				4'd9 : burst_break_pt_3 <= reg_up_roic_aclk_9_read;
			endcase
		end
	end

//----------------------------------------
// ROIC SPI Set
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			roic_burst_cycle		<= `DEF_ROIC_BURST_CYCLE		;
			start_roic_burst_clk	<= `DEF_START_ROIC_BURST_CLK	;
			end_roic_burst_clk		<= `DEF_END_ROIC_BURST_CLK		;
		end
		else begin
			if(fsm_rst_index) begin
				roic_burst_cycle		<= buf_roic_burst_cycle			;
				start_roic_burst_clk	<= buf_start_roic_burst_clk		;
				end_roic_burst_clk		<= buf_end_roic_burst_clk		;
			end
		end
	end

//----------------------------------------
// AED Setting
//----------------------------------------

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			reg_ready_aed_read		<= `DEF_READY_AED_READ			;
			reg_aed_dark_delay		<= `DEF_AED_DARK_DELAY			;
			sel_aed_roic			<= `DEF_SEL_AED_ROIC			;
			aed_th					<= `DEF_AED_TH					;
			nega_aed_th				<= `DEF_NEGA_AED_TH				;
			posi_aed_th				<= `DEF_POSI_AED_TH				;
			reg_num_trigger			<= `DEF_NUM_TRIGGER				;
			reg_aed_cmd				<= `DEF_AED_CMD					;
			sel_aed_test_roic		<= `DEF_SEL_AED_TEST_ROIC		;
		end
		else begin
			if(fsm_rst_index) begin
				reg_ready_aed_read		<= buf_ready_aed_read		;
				reg_aed_dark_delay		<= buf_aed_dark_delay		;
				sel_aed_roic			<= buf_sel_aed_roic			;
				// aed_th					<= buf_aed_th				;
				// nega_aed_th				<= buf_nega_aed_th			;
				// posi_aed_th				<= buf_posi_aed_th			;
				reg_num_trigger			<= buf_num_trigger			;
				reg_aed_cmd				<= buf_aed_cmd				;
				sel_aed_test_roic		<= buf_sel_aed_test_roic	;
			end
			aed_th					<= buf_aed_th				;
			nega_aed_th				<= buf_nega_aed_th			;
			posi_aed_th				<= buf_posi_aed_th			;
		end
	end

	// always @(posedge fsm_clk or negedge rst) begin
	// 	if(!rst) begin
	// 		aed_th					<= `DEF_AED_TH					;
	// 		nega_aed_th				<= `DEF_NEGA_AED_TH				;
	// 		posi_aed_th				<= `DEF_POSI_AED_TH				;
	// 	end
	// 	else begin
	// 		aed_th					<= buf_aed_th				;
	// 		nega_aed_th				<= buf_nega_aed_th			;
	// 		posi_aed_th				<= buf_posi_aed_th			;
	// 	end
	// end

	assign en_aed			= reg_aed_cmd[0];
	assign aed_test_mode1	= reg_aed_cmd[1];
	assign aed_test_mode2	= reg_aed_cmd[2];

	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			ready_aed_read <= `DEF_READY_AED_READ;
		end
		else begin
			if(reg_ready_aed_read == 16'd0)
				ready_aed_read <= 16'd1;
			else
				ready_aed_read <= reg_ready_aed_read;
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			aed_dark_delay <= `DEF_AED_DARK_DELAY;
		end
		else begin
			if((reg_aed_dark_delay == 16'd0) || reg_aed_dark_delay)
				aed_dark_delay <= 16'd1;
			else
				aed_dark_delay <= reg_aed_dark_delay - 16'd1;
		end
	end
	always @(posedge fsm_clk or negedge rst) begin
		if(!rst) begin
			num_trigger <= `DEF_NUM_TRIGGER;
		end
		else begin
			if(reg_num_trigger == 16'd0)
				num_trigger <= 16'd0;
			else
				num_trigger <= reg_num_trigger - 16'd1;
		end
	end

//----------------------------------------
//----------------------------------------
 //USR_ACCESSE2:ConfigurationDataAccess
 // 7Series
 //XilinxHDLLibrariesGuide,version2013.1
	USR_ACCESSE2 USR_ACCESSE2_inst(
 		.CFGCLK		(CFGCLK), 			//1-bit output:ConfigurationClockoutput
		.DATA     	(FPGA_VER_DATA), 	//32-bit output:ConfigurationDataoutput
 		.DATAVALID	(DATAVALID) 		//1-bit output:Activehighdatavalidoutput
	);
 //EndofUSR_ACCESSE2_instinstantiation
	
	assign s_fpga_ver_data = FPGA_VER_DATA;

	// ila_usr_access ila_usr_a(
	// 	.clk	(sys_clk),
	// 	.probe0	(CFGCLK),
	// 	.probe1	(FPGA_VER_DATA),
	// 	.probe2	(DATAVALID)
	// );

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_fpga_ver_h <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_FPGA_VER_H) && reg_read_index)
				dn_fpga_ver_h <= 1'b1;
			else
				dn_fpga_ver_h <= 1'b0;
	end

	always @(posedge eim_clk or negedge eim_rst) begin
		if (!eim_rst)
			dn_fpga_ver_l <= 1'b0;
		else
			if ((sig_reg_addr == `ADDR_FPGA_VER_L) && reg_read_index)
				dn_fpga_ver_l <= 1'b1;
			else
				dn_fpga_ver_l <= 1'b0;
	end

	// assign rd_roic_temperature = ({l_roic_temperature,roic_temperature});
	assign rd_roic_temperature = roic_temperature;

endmodule
