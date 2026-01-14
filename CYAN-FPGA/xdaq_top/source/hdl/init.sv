
// `include "./p_define.sv"
`include	"./p_define_refacto.sv"
`timescale 1ns/1ps

typedef enum logic [2:0] {
    IDLE        = 3'b000,
    POWER_ON    = 3'b001,
    STEP1       = 3'b010,
    STEP2       = 3'b011,
    STEP3       = 3'b100,
    STEP4       = 3'b101,
    STEP5       = 3'b110,
    STEP6       = 3'b111
} power_state_t;

`define POWER_ON_DELAY    25'd1000
`define STEP_DELAY       25'd2000
`define STEP5_DELAY      25'd3000

module init(
	fsm_clk					, //i,
	reset 					, //i,
	en_pwr_off				, //i,
	en_pwr_dwn				, //i,

	init_rst				, //o,
	pwr_init_step1			, //o,
	pwr_init_step2			, //o,
	pwr_init_step3			, //o,
	pwr_init_step4			, //o,
	pwr_init_step5			, //o,
	pwr_init_step6			, //o,
	roic_reset				  //o
);

//----------------------------------------
// Signal declaration 
//----------------------------------------

	input				fsm_clk					; //i,
	input				reset 					; //i,
	input				en_pwr_off				; //i,
	input				en_pwr_dwn				; //i,

	output	reg			init_rst				; //o,
	output	wire		pwr_init_step1			; //o,
	output	wire		pwr_init_step2			; //o,
	output	wire		pwr_init_step3			; //o,
	output	wire		pwr_init_step4			; //o,
	output	wire		pwr_init_step5			; //o,
	output	wire		pwr_init_step6			; //o,
	output	wire		roic_reset				; //o

//----------------------------------------
//----------------------------------------
	
	reg				en_pwr_off_1d				;
	reg				en_pwr_off_2d				;
	initial			en_pwr_off_1d				= 1'b0;
	initial			en_pwr_off_2d				= 1'b0;

	wire			start_pwr_off				;
	wire			start_pwr_on				;

	reg				pwr_off						;
	reg				pwr_on 						;
	initial			pwr_off						= 1'b0;
	initial			pwr_on						= 1'b1;

	reg				init_step1					;
	reg				init_step2					;
	reg				init_step3					;
	reg				init_step4					;
	reg				init_step5					;
	reg				init_step6					;
	initial			init_step1					= 1'b0;
	initial			init_step2					= 1'b0;
	initial			init_step3					= 1'b0;
	initial			init_step4					= 1'b0;
	initial			init_step5					= 1'b0;
	initial			init_step6					= 1'b0;

	reg				init_step6_1d				;
	reg				init_step6_2d				;
	initial			init_step6_1d				= 1'b0;
	initial			init_step6_2d				= 1'b0;

	reg				en_pwr_dwn_1d				;
	reg				en_pwr_dwn_2d				;
	initial			en_pwr_dwn_1d				= 1'b0;
	initial			en_pwr_dwn_2d				= 1'b0;

	wire			start_pwr_dwn_off			;
	wire			start_pwr_dwn_on 			;

	reg				pwr_dwn_off					;
	reg				pwr_dwn_on 					;
	initial			pwr_dwn_off					= 1'b0;
	initial			pwr_dwn_on 					= 1'b0;

	reg				pwr_dwn_step1				;
	reg				pwr_dwn_step2				;
	reg				pwr_dwn_step3				;
	reg				pwr_dwn_step4				;
	reg				pwr_dwn_step5				;
	initial			pwr_dwn_step1				= 1'b1;
	initial			pwr_dwn_step2				= 1'b1;
	initial			pwr_dwn_step3				= 1'b1;
	initial			pwr_dwn_step4				= 1'b1;
	initial			pwr_dwn_step5				= 1'b1;

	wire			hi_init_rst 				;

	logic			sig_init_rst				= 1'b1;

	reg				step_delay					;
	reg				step_delay_1d				;
	reg				step_delay_2d				;
	reg				step_delay_3d				;
	reg				step_delay_4d				;
	initial			step_delay					= 1'b0;
	initial			step_delay_1d				= 1'b0;
	initial			step_delay_2d				= 1'b0;
	initial			step_delay_3d				= 1'b0;
	initial			step_delay_4d				= 1'b0;

	reg	[24:0]		counter1					;
	reg	[24:0]		counter2					;
	initial			counter1					= 25'd0;
	initial			counter2					= 25'd0;

//----------------------------------------
// power init step signals 
//----------------------------------------

	assign pwr_init_step1	= init_step1 & pwr_dwn_step1;
	assign pwr_init_step2	= init_step2 & pwr_dwn_step2;
	assign pwr_init_step3	= init_step3 & pwr_dwn_step3;
	assign pwr_init_step4	= init_step4 & pwr_dwn_step4;
	assign pwr_init_step5	= init_step5 & pwr_dwn_step5;
	assign pwr_init_step6	= init_step6;

//----------------------------------------
// Power On/Off sequence
//----------------------------------------

	always @(posedge fsm_clk or posedge reset) begin
		if (reset) begin
			en_pwr_off_1d <= 1'b0;
			en_pwr_off_2d <= 1'b0;
		end else begin
			en_pwr_off_1d <= en_pwr_off;
			en_pwr_off_2d <= en_pwr_off_1d;
		end
	end

	// generate trigger signal
	assign start_pwr_off 	= en_pwr_off_1d & (!en_pwr_off_2d) & init_step6;
	assign start_pwr_on		= (~en_pwr_off_1d) & en_pwr_off_2d & (~init_step1);

	always @(posedge fsm_clk) begin
		if (start_pwr_on) begin
			pwr_off <= 1'b0;
			pwr_on <= 1'b1;
		end
		else if (start_pwr_off) begin
			pwr_off <= 1'b1;
			pwr_on <= 1'b0;
		end
	end

	always @(posedge fsm_clk) begin
		if ((!pwr_off) && pwr_on) begin
			if (!init_step1) begin
				if (counter1 == `INIT_DELAY) begin
					init_step1 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step1	<= init_step1;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if (init_step1 && (!init_step2)) begin
				if (counter1 == `INIT_DELAY) begin
					init_step2 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step2	<= init_step2;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if (init_step2 && (!init_step3)) begin
				if (counter1 == `INIT_DELAY) begin
					init_step3 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step3	<= init_step3;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if (init_step3 && (!init_step4)) begin
				if (counter1 == `INIT_DELAY) begin
					init_step4 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step4	<= init_step4;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if (init_step4 && (!init_step5)) begin
				if (counter1 == `MORE_DELAY) begin
					init_step5 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step5	<= init_step5;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if (init_step5 && (!init_step6)) begin
				if (counter1 == `INIT_DELAY) begin
					init_step6 	<= 1'b1;
					counter1 	<= 25'd0;
				end
				else begin
					init_step6	<= init_step6;
					counter1	<= counter1 + 25'd1;
				end
			end
		end
		else if (pwr_off && (!pwr_on)) begin
			if (init_step6) begin
				if (counter1 == `INIT_DELAY) begin
					init_step6 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step6	<= init_step6;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if ((!init_step6) && init_step5) begin
				if (counter1 == `INIT_DELAY) begin
					init_step5 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step5	<= init_step5;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if ((!init_step5) && init_step4) begin
				if (counter1 == `INIT_DELAY) begin
					init_step4 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step4	<= init_step4;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if ((!init_step4) && init_step3) begin
				if (counter1 == `INIT_DELAY) begin
					init_step3 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step3	<= init_step3;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if ((!init_step3) && init_step2) begin
				if (counter1 == `INIT_DELAY) begin
					init_step2 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step2	<= init_step2;
					counter1	<= counter1 + 25'd1;
				end
			end
			else if ((!init_step2) && init_step1) begin
				if (counter1 == `INIT_DELAY) begin
					init_step1 	<= 1'b0;
					counter1 	<= 25'd0;
				end
				else begin
					init_step1	<= init_step1;
					counter1	<= counter1 + 25'd1;
				end
			end
		end
	end
//----------------------------------------
// Power Down sequence
//----------------------------------------

	always @(posedge fsm_clk or posedge reset) begin
		if (reset) begin
			en_pwr_dwn_1d <= 1'b0;
			en_pwr_dwn_2d <= 1'b0;
		end else begin
			en_pwr_dwn_1d <= en_pwr_dwn;
			en_pwr_dwn_2d <= en_pwr_dwn_1d;
		end
	end

	assign start_pwr_dwn_on		= en_pwr_dwn_1d & (!en_pwr_dwn_2d) & pwr_dwn_step5;
	assign start_pwr_dwn_off	= (!en_pwr_dwn_1d) & en_pwr_dwn_2d & (!pwr_dwn_step1);

	always @(posedge fsm_clk) begin
		if (start_pwr_dwn_on) begin
			pwr_dwn_off <= 1'b0;
			pwr_dwn_on	<= 1'b1;
		end
		else if (start_pwr_dwn_off) begin
			pwr_dwn_off <= 1'b1;
			pwr_dwn_on	<= 1'b0;
		end
	end

	always @(posedge fsm_clk) begin
		if ((!pwr_dwn_off) && pwr_dwn_on) begin
			if (pwr_dwn_step5) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step5 	<= 1'b0;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step5	<= pwr_dwn_step5;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if ((!pwr_dwn_step5) && pwr_dwn_step4) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step4 	<= 1'b0;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step4	<= pwr_dwn_step4;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if ((!pwr_dwn_step4) && pwr_dwn_step3) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step3 	<= 1'b0;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step3	<= pwr_dwn_step3;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if ((!pwr_dwn_step3) && pwr_dwn_step2) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step2 	<= 1'b0;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step2	<= pwr_dwn_step2;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if ((!pwr_dwn_step2) && pwr_dwn_step1) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step1 	<= 1'b0;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step1	<= pwr_dwn_step1;
					counter2		<= counter2 + 25'd1;
				end
			end
		end
		else if (pwr_dwn_off && (!pwr_dwn_on)) begin
			if (!pwr_dwn_step1) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step1 	<= 1'b1;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step1	<= pwr_dwn_step1;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if (pwr_dwn_step1 && (!pwr_dwn_step2)) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step2 	<= 1'b1;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step2	<= pwr_dwn_step2;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if (pwr_dwn_step2 && (!pwr_dwn_step3)) begin
				if (counter2 == `INIT_DELAY) begin
					pwr_dwn_step3 	<= 1'b1;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step3	<= pwr_dwn_step3;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if (pwr_dwn_step3 && (!pwr_dwn_step4)) begin
				if (counter2 == `MORE_DELAY) begin
					pwr_dwn_step4 	<= 1'b1;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step4	<= pwr_dwn_step4;
					counter2		<= counter2 + 25'd1;
				end
			end
			else if (pwr_dwn_step4 && (!pwr_dwn_step5)) begin
				if (counter2 == `MORE_DELAY) begin
					pwr_dwn_step5 	<= 1'b1;
					counter2 		<= 25'd0;
				end
				else begin
					pwr_dwn_step5	<= pwr_dwn_step5;
					counter2		<= counter2 + 25'd1;
				end
			end
		end
	end

//----------------------------------------
// System Reset
//----------------------------------------

	always @(posedge fsm_clk or posedge reset) begin
		if (reset) begin
			init_step6_1d <= 1'b0;
			init_step6_2d <= 1'b0;
		end else begin
			init_step6_1d <= init_step6;
			init_step6_2d <= init_step6_1d;
		end
	end

	assign hi_init_rst = init_step6_1d & (!init_step6_2d);

	always @(posedge fsm_clk) begin
		if (hi_init_rst) begin
			sig_init_rst <= 1'b0;
		end
	end

	assign init_rst = sig_init_rst;
	
//----------------------------------------
// ROIC Reset
//----------------------------------------
	
	always @(posedge fsm_clk) begin
		step_delay		<= init_step5 & pwr_init_step5	;
		step_delay_1d	<= step_delay		;
		step_delay_2d	<= step_delay_1d	;
		step_delay_3d	<= step_delay_2d	;
		step_delay_4d	<= step_delay_3d	;
	end

	assign roic_reset = step_delay & (!step_delay_4d);

//----------------------------------------
//----------------------------------------
//----------------------------------------
//----------------------------------------

endmodule
