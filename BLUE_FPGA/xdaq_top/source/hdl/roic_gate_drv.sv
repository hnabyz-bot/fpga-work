// ---------------------------------------------------------------------------------
//   Title      :  ROIC Data Latch Module
//              :  
//   Purpose    :  Writing the synthesisable verilog RTL code for
//              :  the ROIC Data Latch Module
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
//      v1.0        01/28/2022      initial release
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

module roic_gate_drv(
	fsm_clk						, //i, 100MHz
	fsm_drv_rst					, //i
	rst							, //i
	
	row_cnt						, //i, [15:0], from ctrl_FSM
	col_cnt						, //i, [15:0], from ctrl_FSM
	// image_height				, //i, [15:0], from reg_map
	aed_read_image_height		, //i, [15:0], from reg_map
	gate_size					, //i, [15:0], from reg_map
	fsm_back_bias_index			, //i, from ctrl_FSM
	fsm_flush_index				, //i, from ctrl_FSM
	fsm_aed_read_index			, //i, from ctrl_FSM
	fsm_read_index				, //i, from ctrl_FSM
	col_end						, //i, from ctrl_FSM
	disable_aed_read_xao		, //i, from ctrl_AED
	up_back_bias				, //i, [15:0], from reg_map
	dn_back_bias				, //i, [15:0], from reg_map
	up_back_bias_opr			, //i, [15:0], from reg_map
	dn_back_bias_opr			, //i, [15:0], from reg_map
	up_gate_stv1				, //i, [15:0], from reg_map
	dn_gate_stv1				, //i, [15:0], from reg_map
	up_gate_stv2				, //i, [15:0], from reg_map
	dn_gate_stv2				, //i, [15:0], from reg_map
	up_gate_cpv1				, //i, [15:0], from reg_map
	dn_gate_cpv1				, //i, [15:0], from reg_map
	up_gate_cpv2				, //i, [15:0], from reg_map
	dn_gate_cpv2				, //i, [15:0], from reg_map
	up_gate_oe1					, //i, [15:0], from reg_map
	dn_gate_oe1					, //i, [15:0], from reg_map
	up_gate_oe2					, //i, [15:0], from reg_map
	dn_gate_oe2					, //i, [15:0], from reg_map
	up_aed_gate_xao_0			, //i, [15:0], from reg_map
	dn_aed_gate_xao_0			, //i, [15:0], from reg_map
	up_aed_gate_xao_1			, //i, [15:0], from reg_map
	dn_aed_gate_xao_1			, //i, [15:0], from reg_map
	up_aed_gate_xao_2			, //i, [15:0], from reg_map
	dn_aed_gate_xao_2			, //i, [15:0], from reg_map
	up_aed_gate_xao_3			, //i, [15:0], from reg_map
	dn_aed_gate_xao_3			, //i, [15:0], from reg_map
	up_aed_gate_xao_4			, //i, [15:0], from reg_map
	dn_aed_gate_xao_4			, //i, [15:0], from reg_map
	up_aed_gate_xao_5			, //i, [15:0], from reg_map
	dn_aed_gate_xao_5			, //i, [15:0], from reg_map
	up_roic_sync				, //i, [15:0], from reg_map
	up_roic_aclk_0				, //i, [15:0], from reg_map
	up_roic_aclk_1				, //i, [15:0], from reg_map
	up_roic_aclk_2				, //i, [15:0], from reg_map
	up_roic_aclk_3				, //i, [15:0], from reg_map
	up_roic_aclk_4				, //i, [15:0], from reg_map
	up_roic_aclk_5				, //i, [15:0], from reg_map
	up_roic_aclk_6				, //i, [15:0], from reg_map
	up_roic_aclk_7				, //i, [15:0], from reg_map
	up_roic_aclk_8				, //i, [15:0], from reg_map
	up_roic_aclk_9				, //i, [15:0], from reg_map
	up_roic_aclk_10				, //i, [15:0], from reg_map
	burst_break_pt_0			, //i, [15:0], from reg_map, pipe line êµ¬ì¡°?ï¿½ï¿½?ï¿½ï¿½ CDS1, 2 ì£¼ï¿½???ï¿½ï¿½ DCLK ?ï¿½ï¿½ active ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½ break point ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½
	burst_break_pt_1			, //i, [15:0], from reg_map
	burst_break_pt_2			, //i, [15:0], from reg_map
	burst_break_pt_3			, //i, [15:0], from reg_map
	aed_detect_line_0			, //i, [15:0], from reg_map
	aed_detect_line_1			, //i, [15:0], from reg_map
	aed_detect_line_2			, //i, [15:0], from reg_map
	aed_detect_line_3			, //i, [15:0], from reg_map
	aed_detect_line_4			, //i, [15:0], from reg_map
	aed_detect_line_5			, //i, [15:0], from reg_map


	back_bias					, //o
	gate_stv_1_1				, //o
//	gate_stv_2_1				, //o, not use
//	gate_stv_3_1				, //o, not use
//	gate_stv_4_1				, //o, not use
//	gate_stv_5_1				, //o, not use
//	gate_stv_6_1				, //o, not use
//	gate_stv_1_2				, //o, not use
//	gate_stv_2_2				, //o, not use
//	gate_stv_3_2				, //o, not use
//	gate_stv_4_2				, //o, not use
//	gate_stv_5_2				, //o, not use
//	gate_stv_6_2				, //o, not use
	gate_cpv					, //o
	gate_oe1					, //o
	gate_oe2					, //o
	gate_xao_0					, //o
	gate_xao_1					, //o
	gate_xao_2					, //o
	gate_xao_3					, //o
	gate_xao_4					, //o
	gate_xao_5					, //o
	roic_sync					, //o
	roic_aclk					, //o
	valid_aed_read_skip			, //o
	roic_data_read_index		, //o
	valid_read_out			 	  //o
);

//----------------------------------------
// Signal declaration 
//----------------------------------------

	input						fsm_clk						; //i, 25MHz
	input						fsm_drv_rst					; //i
	input						rst							; //i

	input			[15:0]		row_cnt						; //i, [15:0], from ctrl_FSM
	input			[15:0]		col_cnt						; //i, [15:0], from ctrl_FSM
	// input			[15:0]		image_height				; //i, [15:0], from reg_map
	input			[15:0]		aed_read_image_height		; //i, [15:0], from reg_map
	input			[15:0]		gate_size					; //i, [15:0], from reg_map
	input						fsm_back_bias_index			; //i, from ctrl_FSM
	input						fsm_flush_index				; //i, from ctrl_FSM
	input						fsm_aed_read_index			; //i, from ctrl_FSM
	input						fsm_read_index				; //i, from ctrl_FSM
	input						col_end						; //i, from ctrl_FSM
	input						disable_aed_read_xao		; //i, from ctrl_AED
	input			[15:0]		up_back_bias				; //i, [15:0], from reg_map
	input			[15:0]		dn_back_bias				; //i, [15:0], from reg_map
	input			[15:0]		up_back_bias_opr			; //i, [15:0], from reg_map
	input			[15:0]		dn_back_bias_opr			; //i, [15:0], from reg_map
	input			[15:0]		up_gate_stv1				; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_stv1				; //i, [15:0], from reg_map
	input			[15:0]		up_gate_stv2				; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_stv2				; //i, [15:0], from reg_map
	input			[15:0]		up_gate_cpv1				; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_cpv1				; //i, [15:0], from reg_map
	input			[15:0]		up_gate_cpv2				; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_cpv2				; //i, [15:0], from reg_map
	input			[15:0]		up_gate_oe1					; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_oe1					; //i, [15:0], from reg_map
	input			[15:0]		up_gate_oe2					; //i, [15:0], from reg_map
	input			[15:0]		dn_gate_oe2					; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_0			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_0			; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_1			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_1			; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_2			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_2			; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_3			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_3			; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_4			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_4			; //i, [15:0], from reg_map
	input			[15:0]		up_aed_gate_xao_5			; //i, [15:0], from reg_map
	input			[15:0]		dn_aed_gate_xao_5			; //i, [15:0], from reg_map
	input			[15:0]		up_roic_sync				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_0				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_1				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_2				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_3				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_4				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_5				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_6				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_7				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_8				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_9				; //i, [15:0], from reg_map
	input			[15:0]		up_roic_aclk_10				; //i, [15:0], from reg_map
// pipe line êµ¬ì¡°?ï¿½ï¿½?ï¿½ï¿½ CDS1, 2 ì£¼ï¿½???ï¿½ï¿½ DCLK ?ï¿½ï¿½ active ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½ break point ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½
// Refer to ROIC data sheet 18page, figure 23.
// break point1 : SYNC
// break point2 : INTRST OPEN
// break point3 : CDS1 OPEN 
// break point4 : CDS2 OPEN
	input			[15:0]		burst_break_pt_0			; //i, [15:0], from reg_map, 
	input			[15:0]		burst_break_pt_1			; //i, [15:0], from reg_map
	input			[15:0]		burst_break_pt_2			; //i, [15:0], from reg_map
	input			[15:0]		burst_break_pt_3			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_0			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_1			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_2			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_3			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_4			; //i, [15:0], from reg_map
	input			[15:0]		aed_detect_line_5			; //i, [15:0], from reg_map

	output	reg					back_bias					; //o
	output	reg					gate_stv_1_1				; //o
	output	wire				gate_cpv					; //o
	output	reg					gate_oe1					; //o
	output	reg					gate_oe2					; //o
	output	reg					gate_xao_0					; //o
	output	reg					gate_xao_1					; //o
	output	reg					gate_xao_2					; //o
	output	reg					gate_xao_3					; //o
	output	reg					gate_xao_4					; //o
	output	reg					gate_xao_5					; //o
	output	reg					roic_sync					; //o
	output	wire				roic_aclk					; //o
	output	wire				valid_aed_read_skip			; //o
	output	reg					roic_data_read_index		; //o
	output	wire				valid_read_out				; //o

//----------------------------------------
// Wire/Reg declaration
//----------------------------------------

	wire	[15:0]	aed_read_drv_gate_end_line				; // 16'd244	; // aed_read_image_height - 1

	wire	[15:0]	aed_read_skip_start_line0 				; // 16'd7		; // aed_gate_oe_end_line0 + 1
	wire	[15:0]	aed_read_skip_end_line0					; // 16'd20		; // aed_gate_oe_start_line1 - 1
	wire	[15:0]	aed_read_skip_start_line1 				; // 16'd24		; // aed_gate_oe_end_line1 + 1
	wire	[15:0]	aed_read_skip_end_line1					; // 16'd30		; // aed_gate_oe_start_line2 - 1
	wire	[15:0]	aed_read_skip_start_line2 				; // 16'd34		; // aed_gate_oe_end_line2 + 1
	wire	[15:0]	aed_read_skip_end_line2					; // 16'd40		; // aed_gate_oe_start_line3 - 1
	wire	[15:0]	aed_read_skip_start_line3 				; // 16'd44		; // aed_gate_oe_end_line3 + 1
	wire	[15:0]	aed_read_skip_end_line3					; // 16'd50		; // aed_gate_oe_start_line3 - 1
	wire	[15:0]	aed_read_skip_start_line4 				; // 16'd54		; // aed_gate_oe_end_line4 + 1
	wire	[15:0]	aed_read_skip_end_line4					; // 16'd60		; // aed_gate_oe_start_line4 - 1
	wire	[15:0]	aed_read_skip_start_line5 				; // 16'd64		; // aed_gate_oe_end_line5 + 1
	wire	[15:0]	aed_read_skip_end_line5					; // 16'd70		; // aed_gate_oe_start_line5 - 1
	wire	[15:0]	aed_read_skip_start_line6 				; // 16'd74		; // aed_gate_oe_end_line6 + 1
	wire	[15:0]	aed_read_skip_end_line6					; // 16'd237	; 
	// 16'd237, aed_read_image_height : 245, aed_read_image_height - 5

	wire	[15:0]	aed_gate_oe_start_line0					; // 16'd1		;
	wire	[15:0]	aed_gate_oe_end_line0					; // 16'd6		;
	wire	[15:0]	aed_gate_oe_start_line1					; // 16'd21		; // AED_DETECT_LINE_0
	wire	[15:0]	aed_gate_oe_end_line1					; // 16'd23		; // AED_DETECT_LINE_0 + 2
	wire	[15:0]	aed_gate_oe_start_line2					; // 16'd31		; // AED_DETECT_LINE_1
	wire	[15:0]	aed_gate_oe_end_line2					; // 16'd33		; // AED_DETECT_LINE_1 + 2
	wire	[15:0]	aed_gate_oe_start_line3					; // 16'd41		; // AED_DETECT_LINE_2
	wire	[15:0]	aed_gate_oe_end_line3					; // 16'd43		; // AED_DETECT_LINE_2 + 2
	wire	[15:0]	aed_gate_oe_start_line4					; // 16'd51		; // AED_DETECT_LINE_3
	wire	[15:0]	aed_gate_oe_end_line4					; // 16'd53		; // AED_DETECT_LINE_3 + 2
	wire	[15:0]	aed_gate_oe_start_line5					; // 16'd61		; // AED_DETECT_LINE_4
	wire	[15:0]	aed_gate_oe_end_line5					; // 16'd63		; // AED_DETECT_LINE_4 + 2
	wire	[15:0]	aed_gate_oe_start_line6					; // 16'd71		; // AED_DETECT_LINE_5
	wire	[15:0]	aed_gate_oe_end_line6					; // 16'd73		; // AED_DETECT_LINE_5 + 2
	wire	[15:0]	aed_gate_oe_start_line7					; // 16'd236	; // aed_read_image_height - 6, AED_DETECT_LINE6 
	wire	[15:0]	aed_gate_oe_end_line7					; // 16'd244	; // aed_read_image_height - 1, AED_DETECT_LINE6 + 2

	wire	[15:0]	aed_data_out_start_line0				; // 16'd3		; // aed_gate_oe_start_line0 + 2
	wire	[15:0]	aed_data_out_end_line0					; // 16'd8		; // aed_gate_oe_end_line0 + 2
	wire	[15:0]	aed_data_out_start_line1				; // 16'd23		; // aed_gate_oe_start_line1 + 2
	wire	[15:0]	aed_data_out_end_line1					; // 16'd25		; // aed_gate_oe_end_line1 + 2
	wire	[15:0]	aed_data_out_start_line2				; // 16'd33		; // aed_gate_oe_start_line2 + 2
	wire	[15:0]	aed_data_out_end_line2					; // 16'd35		; // aed_gate_oe_end_line2 + 2
	wire	[15:0]	aed_data_out_start_line3				; // 16'd43		; // aed_gate_oe_start_line3 + 2
	wire	[15:0]	aed_data_out_end_line3					; // 16'd45		; // aed_gate_oe_end_line3 + 2
	wire	[15:0]	aed_data_out_start_line4				; // 16'd53		; // aed_gate_oe_start_line4 + 2
	wire	[15:0]	aed_data_out_end_line4					; // 16'd55		; // aed_gate_oe_end_line4 + 2
	wire	[15:0]	aed_data_out_start_line5				; // 16'd63		; // aed_gate_oe_start_line5 + 2
	wire	[15:0]	aed_data_out_end_line5					; // 16'd65		; // aed_gate_oe_end_line5 + 2
	wire	[15:0]	aed_data_out_start_line6				; // 16'd73		; // aed_gate_oe_start_line6 + 2
	wire	[15:0]	aed_data_out_end_line6					; // 16'd75		; // aed_gate_oe_end_line6 + 2
	wire	[15:0]	aed_data_out_start_line7				; // 16'd238	; // aed_gate_oe_start_line7 + 2
	wire	[15:0]	aed_data_out_end_line7					; // 16'd246	; // aed_gate_oe_end_line7 + 2

	wire			aed_read_skip_index						;
	wire			aed_read_skip_index0					;
	wire			aed_read_skip_index1					;
	wire			aed_read_skip_index2					;
	wire			aed_read_skip_index3					;
	wire			aed_read_skip_index4					;
	wire			aed_read_skip_index5					;
	wire			aed_read_skip_index6					;

	wire			enable_drv_gate_oe_tmp0					;
	wire			enable_drv_gate_oe_tmp1					;
	wire			enable_drv_gate_oe_tmp2					;
	wire			enable_drv_gate_oe_tmp3					;
	wire			enable_drv_gate_oe_tmp4					;
	wire			enable_drv_gate_oe_tmp5					;
	wire			enable_drv_gate_oe_tmp6					;
	wire			enable_drv_gate_oe_tmp7					;

	wire			valid_read_out_tmp0						; // line trigger
	wire			valid_read_out_tmp1						; // AED trigger
	wire			valid_read_out_tmp2						; // AED trigger
	wire			valid_read_out_tmp3						; // AED trigger
	wire			valid_read_out_tmp4						; // AED trigger
	wire			valid_read_out_tmp5						; // AED trigger
	wire			valid_read_out_tmp6						; // AED trigger
	wire			valid_read_out_tmp7						; // AED trigger
	wire			valid_read_out_tmp8						; // AED trigger

	wire			drv_roic_out							;
	wire			tmp_enable_drv_roic						;
	reg				enable_drv_roic							;
	wire			tmp_enable_drv_gate						;
	reg				enable_drv_gate							;
	wire			tmp_enable_drv_gate_oe					;
	reg				enable_drv_gate_oe						;
	wire			tmp_enable_drv_roic_sync				;
	reg				enable_drv_roic_sync					;
	reg		[15:0]	up_roic_data_read_0						;
	reg		[15:0]	dn_roic_data_read_0						;
	reg		[15:0]	up_roic_data_read_1						;
	reg		[15:0]	dn_roic_data_read_1						;
	reg		[15:0]	up_roic_data_read_2						;
	reg		[15:0]	dn_roic_data_read_2						;
	wire			hi_roic_data_read_0						;
	wire			lo_roic_data_read_0						;
	wire			hi_roic_data_read_1						;
	wire			lo_roic_data_read_1						;
	wire			hi_roic_data_read_2						;
	wire			lo_roic_data_read_2						;
	wire			hi_roic_data_read						;
	wire			lo_roic_data_read						;
	wire			hi_roic_aclk_0							;
	wire			hi_roic_aclk_1							;
	wire			hi_roic_aclk_2							;
	wire			hi_roic_aclk_3							;
	wire			hi_roic_aclk_4							;
	wire			hi_roic_aclk_5							;
	wire			hi_roic_aclk_6							;
	wire			hi_roic_aclk_7							;
	wire			hi_roic_aclk_8							;
	wire			hi_roic_aclk_9							;
	wire			hi_roic_aclk_10							;
	reg				roic_aclk_0								;
	reg				roic_aclk_1								;
	reg				roic_aclk_2								;
	reg				roic_aclk_3								;
	reg				roic_aclk_4								;
	reg				roic_aclk_5								;
	reg				roic_aclk_6								;
	reg				roic_aclk_7								;
	reg				roic_aclk_8								;
	reg				roic_aclk_9								;
	reg				roic_aclk_10							;
	wire			hi_roic_sync							;

	wire			hi_gate_oe1								;
	wire			lo_gate_oe1								;
	wire			hi_gate_oe2								;
	wire			lo_gate_oe2								;
	wire			lo_aed_gate_xao_0						;
	wire			lo_aed_gate_xao_1						;
	wire			lo_aed_gate_xao_2						;
	wire			lo_aed_gate_xao_3						;
	wire			lo_aed_gate_xao_4						;
	wire			lo_aed_gate_xao_5						;
	wire			hi_aed_gate_xao_0						;
	wire			hi_aed_gate_xao_1						;
	wire			hi_aed_gate_xao_2						;
	wire			hi_aed_gate_xao_3						;
	wire			hi_aed_gate_xao_4						;
	wire			hi_aed_gate_xao_5						;
	wire			hi_gate_cpv1							;
	wire			lo_gate_cpv1							;
	wire			hi_gate_cpv2							;
	wire			lo_gate_cpv2							;
	reg				gate_cpv1								;
	reg				gate_cpv2								;
	wire			hi_gate_stv_1_1							;
	wire			lo_gate_stv_1_1							;

	reg		[15:0]	back_bias_cnt							;
	wire			hi_back_bias_opr						;
	wire			lo_back_bias_opr						;
	reg				back_bias_opr							;
	wire			hi_back_bias							;
	wire			lo_back_bias							;
	wire			enable_aed_sig							;

	wire			aed_read_enable_drv_gate				;

	wire	[15:0]	aed_read_xao_line1						;
	wire	[15:0]	aed_read_xao_line2						;
	wire	[15:0]	aed_read_xao_line3						;
	wire			aed_read_xao_valid_tmp					;
	reg				aed_read_xao_valid						;

//----------------------------------------
// for AED Mode
//----------------------------------------

	assign	aed_read_drv_gate_end_line			= aed_read_image_height - 16'd1		;

	assign	aed_read_skip_start_line0 			= `AED_READ_SKIP_START_LINE_0		;// 16'd7	; // 16'd7		; 
	assign	aed_read_skip_end_line0				= aed_gate_oe_start_line1 - 16'd1	;// 16'd9	; // 16'd1300	; 
	assign	aed_read_skip_start_line1 			= aed_gate_oe_end_line1 + 16'd1		;// 16'd13	; // 16'd1304	; 
	assign	aed_read_skip_end_line1				= aed_gate_oe_start_line2 - 16'd1	;// 16'd15	; // 16'd1400	; 
	assign	aed_read_skip_start_line2 			= aed_gate_oe_end_line2 + 16'd1		;// 16'd19	; // 16'd1404	; 
	assign	aed_read_skip_end_line2				= aed_gate_oe_start_line3 - 16'd1	;// 16'd21	; // 16'd1500	; 
	assign	aed_read_skip_start_line3 			= aed_gate_oe_end_line3 + 16'd1		;// 16'd25	; // 16'd1504	; 
	assign	aed_read_skip_end_line3				= aed_gate_oe_start_line4 - 16'd1	;// 16'd27	; // 16'd1600	; 
	assign	aed_read_skip_start_line4 			= aed_gate_oe_end_line4 + 16'd1		;// 16'd31	; // 16'd1604	; 
	assign	aed_read_skip_end_line4				= aed_gate_oe_start_line5 - 16'd1	;// 16'd33	; // 16'd1700	; 
	assign	aed_read_skip_start_line5 			= aed_gate_oe_end_line5 + 16'd1		;// 16'd37	; // 16'd1704	; 
	assign	aed_read_skip_end_line5				= aed_gate_oe_start_line6 - 16'd1	;// 16'd39	; // 16'd1800	; 
	assign	aed_read_skip_start_line6 			= aed_gate_oe_end_line6 + 16'd1		;// 16'd43	; // 16'd1804	; 
	assign	aed_read_skip_end_line6				= aed_gate_oe_start_line7 + 16'd1	;// 16'd47	; // 16'd3069	;

	assign	aed_gate_oe_start_line0				= `AED_GATE_OE_START_LINE_0			;// 16'd1	; // 16'd1		;
	assign	aed_gate_oe_end_line0				= `AED_GATE_OE_END_LINE_0			;// 16'd6	; // 16'd6		;
	assign	aed_gate_oe_start_line1				= aed_detect_line_0					;// 16'd10	; // 16'd1301	;
	assign	aed_gate_oe_end_line1				= aed_detect_line_0 + 16'd2			;// 16'd12	; // 16'd1303	;
	assign	aed_gate_oe_start_line2				= aed_detect_line_1					;// 16'd16	; // 16'd1401	;
	assign	aed_gate_oe_end_line2				= aed_detect_line_1 + 16'd2			;// 16'd18	; // 16'd1403	;
	assign	aed_gate_oe_start_line3				= aed_detect_line_2					;// 16'd22	; // 16'd1501	;
	assign	aed_gate_oe_end_line3				= aed_detect_line_2 + 16'd2			;// 16'd24	; // 16'd1503	;
	assign	aed_gate_oe_start_line4				= aed_detect_line_3					;// 16'd28	; // 16'd1601	;
	assign	aed_gate_oe_end_line4				= aed_detect_line_3 + 16'd2			;// 16'd30	; // 16'd1603	;
	assign	aed_gate_oe_start_line5				= aed_detect_line_4					;// 16'd34	; // 16'd1701	;
	assign	aed_gate_oe_end_line5				= aed_detect_line_4 + 16'd2			;// 16'd36	; // 16'd1703	;
	assign	aed_gate_oe_start_line6				= aed_detect_line_5					;// 16'd40	; // 16'd1801	;
	assign	aed_gate_oe_end_line6				= aed_detect_line_5 + 16'd2			;// 16'd42	; // 16'd1803	;
//	assign	aed_gate_oe_start_line7				= aed_read_drv_gate_end_line - 16'd5;// 16'd46	; // 16'd3068	; // AED last line 4EA
	assign	aed_gate_oe_start_line7				= aed_read_drv_gate_end_line - 16'd3;// 16'd46	; // 16'd3068	; // AED last line 2EA
	assign	aed_gate_oe_end_line7				= aed_read_drv_gate_end_line		;// 16'd51  ; // 16'd3073	;

	assign	aed_data_out_start_line0			= `AED_DATA_OUT_START_LINE_0		;// 16'd3	; // 16'd3		;
	assign	aed_data_out_end_line0				= `AED_DATA_OUT_END_LINE_0			;// 16'd8	; // 16'd8		;
	assign	aed_data_out_start_line1			= aed_gate_oe_end_line1				;// 16'd12	; // 16'd1303	;
	assign	aed_data_out_end_line1				= aed_gate_oe_end_line1 + 16'd2  	;// 16'd14	; // 16'd1305	;
	assign	aed_data_out_start_line2			= aed_gate_oe_end_line2				;// 16'd18	; // 16'd1403	;
	assign	aed_data_out_end_line2				= aed_gate_oe_end_line2 + 16'd2  	;// 16'd20	; // 16'd1405	;
	assign	aed_data_out_start_line3			= aed_gate_oe_end_line3				;// 16'd24	; // 16'd1503	;
	assign	aed_data_out_end_line3				= aed_gate_oe_end_line3 + 16'd2  	;// 16'd26	; // 16'd1505	;
	assign	aed_data_out_start_line4			= aed_gate_oe_end_line4				;// 16'd30	; // 16'd1603	;
	assign	aed_data_out_end_line4				= aed_gate_oe_end_line4 + 16'd2  	;// 16'd32	; // 16'd1605	;
	assign	aed_data_out_start_line5			= aed_gate_oe_end_line5				;// 16'd36	; // 16'd1703	;
	assign	aed_data_out_end_line5				= aed_gate_oe_end_line5 + 16'd2  	;// 16'd38	; // 16'd1705	;
	assign	aed_data_out_start_line6			= aed_gate_oe_end_line6				;// 16'd40	; // 16'd1803	;
	assign	aed_data_out_end_line6				= aed_gate_oe_end_line6 + 16'd2  	;// 16'd44	; // 16'd1805	;
	assign	aed_data_out_start_line7			= aed_gate_oe_start_line7 + 16'd2	;// 16'd48	; // 16'd3070	;
	assign	aed_data_out_end_line7				= aed_gate_oe_end_line7 + 16'd2  	;// 16'd50	; // 16'd3075	;

//----------------------------------------
// AED Read skip line signals
//----------------------------------------

	assign enable_aed_sig		= ((row_cnt < aed_data_out_end_line7) && 
							 	   (fsm_aed_read_index)) ? 1'b1 : 1'b0;

	assign aed_read_skip_index0 = (((row_cnt > aed_read_skip_start_line0	) &&
								   (row_cnt < aed_read_skip_end_line0		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index1 = (((row_cnt > aed_read_skip_start_line1	) &&
		 						   (row_cnt < aed_read_skip_end_line1		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index2 = (((row_cnt > aed_read_skip_start_line2	) &&
		 						   (row_cnt < aed_read_skip_end_line2		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index3 = (((row_cnt > aed_read_skip_start_line3	) &&
		 						   (row_cnt < aed_read_skip_end_line3		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index4 = (((row_cnt > aed_read_skip_start_line4	) &&
		 						   (row_cnt < aed_read_skip_end_line4		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index5 = (((row_cnt > aed_read_skip_start_line5	) &&
		 						   (row_cnt < aed_read_skip_end_line5		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign aed_read_skip_index6 = (((row_cnt > aed_read_skip_start_line6	) &&
		 						   (row_cnt < aed_read_skip_end_line6		)) &&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;

	assign aed_read_skip_index	= aed_read_skip_index0 | aed_read_skip_index1 |
								  aed_read_skip_index2 | aed_read_skip_index3 |
								  aed_read_skip_index4 | aed_read_skip_index5 |
								  aed_read_skip_index6;

	//always @(posedge fsm_clk or negedge rst) begin
	//	if (!rst)	valid_aed_read_skip <= 1'b0;
	//	else			valid_aed_read_skip <= aed_read_skip_index;
	//end
	assign valid_aed_read_skip = aed_read_skip_index; // original ver 

//----------------------------------------
// Drive ROIC and Gate signals
//----------------------------------------

	assign enable_drv_gate_oe_tmp0	= ((row_cnt > aed_gate_oe_start_line0	) &&
									   (row_cnt < aed_gate_oe_end_line0		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp1	= ((row_cnt > aed_gate_oe_start_line1	) &&
									   (row_cnt < aed_gate_oe_end_line1		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp2	= ((row_cnt > aed_gate_oe_start_line2	) &&
									   (row_cnt < aed_gate_oe_end_line2		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp3	= ((row_cnt > aed_gate_oe_start_line3	) &&
									   (row_cnt < aed_gate_oe_end_line3		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp4	= ((row_cnt > aed_gate_oe_start_line4	) &&
									   (row_cnt < aed_gate_oe_end_line4	) 	  &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp5	= ((row_cnt > aed_gate_oe_start_line5	) &&
									   (row_cnt < aed_gate_oe_end_line5		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp6	= ((row_cnt > aed_gate_oe_start_line6	) &&
									   (row_cnt < aed_gate_oe_end_line6		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign enable_drv_gate_oe_tmp7	= ((row_cnt > aed_gate_oe_start_line7	) &&
									   (row_cnt < aed_gate_oe_end_line7		) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;

	assign aed_read_enable_drv_gate	= ((row_cnt < aed_read_drv_gate_end_line) &&
									   (fsm_aed_read_index)) ? 1'b1 : 1'b0;

	assign tmp_enable_drv_roic		= ((fsm_flush_index) | 
									   ((fsm_aed_read_index) & (!aed_read_skip_index) & (enable_aed_sig)) |
									   (fsm_read_index));
	assign tmp_enable_drv_roic_sync	= ((fsm_flush_index) | 
									   ((fsm_aed_read_index) & (!aed_read_skip_index)) |
									   (fsm_read_index));
	assign tmp_enable_drv_gate_oe	= ((fsm_flush_index) | 
									   (enable_drv_gate_oe_tmp0) | (enable_drv_gate_oe_tmp1) |
									   (enable_drv_gate_oe_tmp2) | (enable_drv_gate_oe_tmp3) |
									   (enable_drv_gate_oe_tmp4) | (enable_drv_gate_oe_tmp5) |
									   (enable_drv_gate_oe_tmp6) | (enable_drv_gate_oe_tmp7) |
									   (fsm_read_index));
	assign tmp_enable_drv_gate		= ((fsm_flush_index)			|
									   (aed_read_enable_drv_gate)	|
									   (fsm_read_index));

	always @(posedge fsm_clk or negedge rst) begin
		if (!rst) begin
			enable_drv_roic			<= 1'b0;
			enable_drv_roic_sync	<= 1'b0;
			enable_drv_gate_oe		<= 1'b0;
			enable_drv_gate			<= 1'b0;
		end
		else begin
			enable_drv_roic			<= tmp_enable_drv_roic			;
			enable_drv_roic_sync	<= tmp_enable_drv_roic_sync		;
			enable_drv_gate_oe		<= tmp_enable_drv_gate_oe		;
			enable_drv_gate			<= tmp_enable_drv_gate			;
		end
	end

//----------------------------------------
// ROIC Data Out Enable Signals
//----------------------------------------

	assign drv_roic_out			= (((fsm_aed_read_index) & (!aed_read_skip_index)) |
								   (fsm_read_index));

	assign valid_read_out_tmp0	= ((row_cnt > `READ_DATA_OUT_START_LINE	)	&&
								   (fsm_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp1	= (((row_cnt > aed_data_out_start_line0	)	&&
								    (row_cnt < aed_data_out_end_line0	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp2	= (((row_cnt > aed_data_out_start_line1	)	&&
								    (row_cnt < aed_data_out_end_line1	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp3	= (((row_cnt > aed_data_out_start_line2	)	&&
								    (row_cnt < aed_data_out_end_line2	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp4	= (((row_cnt > aed_data_out_start_line3	)	&&
								   	(row_cnt < aed_data_out_end_line3	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp5	= (((row_cnt > aed_data_out_start_line4	)	&&
								   	(row_cnt < aed_data_out_end_line4	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp6	= (((row_cnt > aed_data_out_start_line5	)	&&
								   	(row_cnt < aed_data_out_end_line5	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp7	= (((row_cnt > aed_data_out_start_line6	)	&&
								   	(row_cnt < aed_data_out_end_line6	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;
	assign valid_read_out_tmp8	= (((row_cnt > aed_data_out_start_line7	)	&&
								   	(row_cnt < aed_data_out_end_line7	))	&&
								   (fsm_aed_read_index)) ? 1'b1 : 1'b0;

	assign valid_read_out		= (valid_read_out_tmp0) | (valid_read_out_tmp1) |
								  (valid_read_out_tmp2) | (valid_read_out_tmp3) |
								  (valid_read_out_tmp4) | (valid_read_out_tmp5) |
								  (valid_read_out_tmp6) | (valid_read_out_tmp7) |
								  (valid_read_out_tmp8);

//----------------------------------------
// Back_Bias Signals
//----------------------------------------
	
	assign hi_back_bias = ((row_cnt == up_back_bias) && (fsm_back_bias_index) && (col_end)) ? 1'b1 : 1'b0;
	assign lo_back_bias = ((row_cnt == dn_back_bias) && (fsm_back_bias_index) && (col_end)) ? 1'b1 : 1'b0;
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			back_bias <= 1'b0;
		else begin
			if (lo_back_bias)		back_bias <= 1'b0;
			else if (hi_back_bias)	back_bias <= 1'b1;
		end
	end

	assign hi_back_bias_opr = ((row_cnt == up_back_bias_opr) && (fsm_back_bias_index) && (col_end)) ? 1'b1 : 1'b0;
	assign lo_back_bias_opr = ((row_cnt == dn_back_bias_opr) && (fsm_back_bias_index) && (col_end)) ? 1'b1 : 1'b0;
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			back_bias_opr <= 1'b0;
		else begin
			if (lo_back_bias_opr)		back_bias_opr <= 1'b0;
			else if (hi_back_bias_opr)	back_bias_opr <= 1'b1;
		end
	end

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if (!fsm_drv_rst)
			back_bias_cnt <= 16'd1;
		else begin
			if ((back_bias_opr) && (col_end))
				back_bias_cnt <= back_bias_cnt + 16'd1;
			else if (!back_bias_opr)
				back_bias_cnt <= 16'd1;
		end
	end

//----------------------------------------
// Gate stv, cpv, oe
//----------------------------------------

	assign hi_gate_stv_1_1 = ((((back_bias_cnt == 16'd1) && (back_bias_opr)) || ((row_cnt == 16'd1) && (enable_drv_gate))) &&
							  (col_cnt == up_gate_stv1)) ? 1'b1 : 1'b0;
	assign lo_gate_stv_1_1 = ((((back_bias_cnt == 16'd1) && (back_bias_opr)) || ((row_cnt == 16'd1) && (enable_drv_gate))) &&
							  (col_cnt == dn_gate_stv1)) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_stv_1_1 <= 1'b0;
		else begin
			if (lo_gate_stv_1_1)		gate_stv_1_1 <= 1'b0;
			else if (hi_gate_stv_1_1)	gate_stv_1_1 <= 1'b1;
		end
	end

	assign hi_gate_cpv1 = ((col_cnt == up_gate_cpv1) && ((enable_drv_gate) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign lo_gate_cpv1 = ((col_cnt == dn_gate_cpv1) && ((enable_drv_gate) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign hi_gate_cpv2 = ((col_cnt == up_gate_cpv2) && ((enable_drv_gate) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign lo_gate_cpv2 = ((col_cnt == dn_gate_cpv2) && ((enable_drv_gate) || (back_bias_opr))) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_cpv1 <= 1'b0;
		else begin
			if(lo_gate_cpv1)
				gate_cpv1 <= 1'b0;
			else if (hi_gate_cpv1)
				gate_cpv1 <= 1'b1;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_cpv2 <= 1'b0;
		else begin
			if(lo_gate_cpv2)
				gate_cpv2 <= 1'b0;
			else if (hi_gate_cpv2)
				gate_cpv2 <= 1'b1;
		end
	end

	assign gate_cpv = gate_cpv1 | gate_cpv2;

	assign hi_gate_oe1 = ((col_cnt == up_gate_oe1) && ((enable_drv_gate_oe) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign lo_gate_oe1 = ((col_cnt == dn_gate_oe1) && ((enable_drv_gate_oe) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign hi_gate_oe2 = ((col_cnt == up_gate_oe2) && ((enable_drv_gate_oe) || (back_bias_opr))) ? 1'b1 : 1'b0;
	assign lo_gate_oe2 = ((col_cnt == dn_gate_oe2) && ((enable_drv_gate_oe) || (back_bias_opr))) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_oe1 <= 1'b1;
		else begin
			if(hi_gate_oe1)
				gate_oe1 <= 1'b1;
			else if (lo_gate_oe1)
				gate_oe1 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_oe2 <= 1'b1;
		else begin
			if(hi_gate_oe2)
				gate_oe2 <= 1'b1;
			else if (lo_gate_oe2)
				gate_oe2 <= 1'b0;
		end
	end

//----------------------------------------
// ROIC Sync, Aclk, Data Read Enable
//----------------------------------------

	assign hi_roic_sync = ((col_cnt == up_roic_sync) && ((back_bias_opr) || (enable_drv_roic_sync))) ? 1'b1 : 1'b0;
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_sync <= 1'b0;
		else begin
			if (hi_roic_sync)
				roic_sync <= 1'b1;
			else
				roic_sync <= 1'b0;
		end
	end

	assign hi_roic_aclk_0	= ((col_cnt == up_roic_aclk_0 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_1	= ((col_cnt == up_roic_aclk_1 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_2	= ((col_cnt == up_roic_aclk_2 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_3	= ((col_cnt == up_roic_aclk_3 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_4	= ((col_cnt == up_roic_aclk_4 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_5	= ((col_cnt == up_roic_aclk_5 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_6	= ((col_cnt == up_roic_aclk_6 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_7	= ((col_cnt == up_roic_aclk_7 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_8	= ((col_cnt == up_roic_aclk_8 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_9	= ((col_cnt == up_roic_aclk_9 ) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;
	assign hi_roic_aclk_10	= ((col_cnt == up_roic_aclk_10) && ((back_bias_opr) || (enable_drv_roic))) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_0	<= 1'b0;
		else begin
			if (hi_roic_aclk_0)
				roic_aclk_0 <= 1'b1;
			else
				roic_aclk_0 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_1	<= 1'b0;
		else begin
			if (hi_roic_aclk_1)
				roic_aclk_1 <= 1'b1;
			else
				roic_aclk_1 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_2	<= 1'b0;
		else begin
			if (hi_roic_aclk_2)
				roic_aclk_2 <= 1'b1;
			else
				roic_aclk_2 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_3	<= 1'b0;
		else begin
			if (hi_roic_aclk_3)
				roic_aclk_3 <= 1'b1;
			else
				roic_aclk_3 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_4	<= 1'b0;
		else begin
			if (hi_roic_aclk_4)
				roic_aclk_4 <= 1'b1;
			else
				roic_aclk_4 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_5	<= 1'b0;
		else begin
			if (hi_roic_aclk_5)
				roic_aclk_5 <= 1'b1;
			else
				roic_aclk_5 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_6	<= 1'b0;
		else begin
			if (hi_roic_aclk_6)
				roic_aclk_6 <= 1'b1;
			else
				roic_aclk_6 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_7	<= 1'b0;
		else begin
			if (hi_roic_aclk_7)
				roic_aclk_7 <= 1'b1;
			else
				roic_aclk_7 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_8	<= 1'b0;
		else begin
			if (hi_roic_aclk_8)
				roic_aclk_8 <= 1'b1;
			else
				roic_aclk_8 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_9	<= 1'b0;
		else begin
			if (hi_roic_aclk_9)
				roic_aclk_9 <= 1'b1;
			else
				roic_aclk_9 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			roic_aclk_10 <= 1'b0;
		else begin
			if (hi_roic_aclk_10)
				roic_aclk_10 <= 1'b1;
			else
				roic_aclk_10 <= 1'b0;
		end
	end

	assign roic_aclk = roic_aclk_0 | roic_aclk_1 | roic_aclk_2 | roic_aclk_3 |
					   roic_aclk_4 | roic_aclk_5 | roic_aclk_6 | roic_aclk_7 |
					   roic_aclk_8 | roic_aclk_9 | roic_aclk_10;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst) begin
			up_roic_data_read_0 <= 16'd0;
			dn_roic_data_read_0 <= 16'd0;
			up_roic_data_read_1 <= 16'd0;
			dn_roic_data_read_1 <= 16'd0;
			up_roic_data_read_2 <= 16'd0;
			dn_roic_data_read_2 <= 16'd0;
		end
		else begin
			up_roic_data_read_0 <= burst_break_pt_0 + 16'd14; // default burst_break_pt_0 : 2
			dn_roic_data_read_0 <= burst_break_pt_1 - 16'd32; // default burst_break_pt_1 : 360, INTRST Close
			up_roic_data_read_1 <= burst_break_pt_1 + 16'd14; 
			dn_roic_data_read_1 <= burst_break_pt_2 - 16'd32; // default burst_break_pt_2 : 985, CDS1 Close
			up_roic_data_read_2 <= burst_break_pt_2 + 16'd14;
			dn_roic_data_read_2 <= burst_break_pt_3 - 16'd32; // default burst_break_pt_3 : 3505, CDS2 Close
		end
	end

	assign hi_roic_data_read_0 = ((col_cnt == up_roic_data_read_0) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;
	assign hi_roic_data_read_1 = ((col_cnt == up_roic_data_read_1) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;
	assign hi_roic_data_read_2 = ((col_cnt == up_roic_data_read_2) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;
	assign lo_roic_data_read_0 = ((col_cnt == dn_roic_data_read_0) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;
	assign lo_roic_data_read_1 = ((col_cnt == dn_roic_data_read_1) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;
	assign lo_roic_data_read_2 = ((col_cnt == dn_roic_data_read_2) && ((fsm_read_index) || (fsm_aed_read_index))) ? 1'b1 : 1'b0;

	assign hi_roic_data_read = hi_roic_data_read_0 | hi_roic_data_read_1 | hi_roic_data_read_2;
//	assign lo_roic_data_read = lo_roic_data_read_0 | lo_roic_data_read_1 | lo_roic_data_read_2;
	assign lo_roic_data_read = lo_roic_data_read_0 | lo_roic_data_read_1 | lo_roic_data_read_2 | col_end;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if (!fsm_drv_rst)
			roic_data_read_index <= 1'b0;
		else begin
			if (!drv_roic_out)
				roic_data_read_index <= 1'b0;
			else begin
				if (lo_roic_data_read)
					roic_data_read_index <= 1'b0;
				else if (hi_roic_data_read)
					roic_data_read_index <= 1'b1;
			end
		end
	end

//----------------------------------------
// AED Gate XAO Function
//----------------------------------------

	assign aed_read_xao_line1 = aed_read_image_height + 16'd1;
	assign aed_read_xao_line2 = aed_read_image_height + 16'd2;
	assign aed_read_xao_line3 = aed_read_image_height + 16'd3;
//	assign aed_read_xao_line2 = 16'd0;
//	assign aed_read_xao_line3 = 16'd0;

	assign aed_read_xao_valid_tmp = (((row_cnt == aed_read_xao_line1 || row_cnt == aed_read_xao_line2 || 
									   row_cnt == aed_read_xao_line3)) && 
									 (fsm_aed_read_index) && (!disable_aed_read_xao)) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if (!fsm_drv_rst)	aed_read_xao_valid <= 1'b0;
		else			aed_read_xao_valid <= aed_read_xao_valid_tmp;
	end

	assign lo_aed_gate_xao_0 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_0)) ? 1'b1 : 1'b0;
	assign lo_aed_gate_xao_1 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_1)) ? 1'b1 : 1'b0;
	assign lo_aed_gate_xao_2 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_2)) ? 1'b1 : 1'b0;
	assign lo_aed_gate_xao_3 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_3)) ? 1'b1 : 1'b0;
	assign lo_aed_gate_xao_4 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_4)) ? 1'b1 : 1'b0;
	assign lo_aed_gate_xao_5 = ((aed_read_xao_valid) && (col_cnt == dn_aed_gate_xao_5)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_0 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_0)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_1 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_1)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_2 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_2)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_3 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_3)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_4 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_4)) ? 1'b1 : 1'b0;
	assign hi_aed_gate_xao_5 = ((aed_read_xao_valid) && (col_cnt == up_aed_gate_xao_5)) ? 1'b1 : 1'b0;

	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_0 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_0)		gate_xao_0 <= 1'b1;
			else if (lo_aed_gate_xao_0)	gate_xao_0 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_1 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_1)		gate_xao_1 <= 1'b1;
			else if (lo_aed_gate_xao_1)	gate_xao_1 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_2 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_2)		gate_xao_2 <= 1'b1;
			else if (lo_aed_gate_xao_2)	gate_xao_2 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_3 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_3)		gate_xao_3 <= 1'b1;
			else if (lo_aed_gate_xao_3)	gate_xao_3 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_4 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_4)		gate_xao_4 <= 1'b1;
			else if (lo_aed_gate_xao_4)	gate_xao_4 <= 1'b0;
		end
	end
	always @(posedge fsm_clk or negedge fsm_drv_rst) begin
		if(!fsm_drv_rst)
			gate_xao_5 <= 1'b1;
		else begin
			if (hi_aed_gate_xao_5)		gate_xao_5 <= 1'b1;
			else if (lo_aed_gate_xao_5)	gate_xao_5 <= 1'b0;
		end
	end

//----------------------------------------
//----------------------------------------

endmodule
