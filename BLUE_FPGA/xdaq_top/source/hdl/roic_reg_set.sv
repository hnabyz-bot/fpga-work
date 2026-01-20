// ---------------------------------------------------------------------------------
//   Title      :  ROIC Register Setting Module
//              :  
//   Purpose    :  Writing the synthesisable verilog RTL code for
//              :  the ROIC Register Setting Module
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
//      v1.0        01/27/2022      initial release
//
// ---------------------------------------------------------------------------------
//  Descripitions   :
//
//		Refer to ROIC Data Spec Sheet 15page Figure.19
//
//
//
// ---------------------------------------------------------------------------------
`include	"./p_define.sv"
`timescale 1ns/1ps

module roic_reg_set(
	sys_clk					, //i, 100MHz
	sys_rst					, //i

	fsm_rst_index			, //i
	org_reset_fsm			, //i
	roic_reg_set_0  		, //i, [15:0]
	roic_reg_set_1  		, //i, [15:0]
	roic_reg_set_1_dual     , //i, [15:0]
	roic_reg_set_2  		, //i, [15:0]
	roic_reg_set_3  		, //i, [15:0]
	roic_reg_set_4  		, //i, [15:0]
	roic_reg_set_5  		, //i, [15:0]
	roic_reg_set_6  		, //i, [15:0]
	roic_reg_set_7  		, //i, [15:0]
	roic_reg_set_8  		, //i, [15:0]
	roic_reg_set_9 			, //i, [15:0]
	roic_reg_set_10			, //i, [15:0]
	roic_reg_set_11			, //i, [15:0]
	roic_reg_set_12			, //i, [15:0]
	roic_reg_set_13			, //i, [15:0]
	roic_reg_set_14			, //i, [15:0]
	roic_reg_set_15			, //i, [15:0]

	roic_cs0				, //o
	roic_sck				, //o, 3.125MHz, From 100MHz divided to 32.
	roic_sdo				, //o
	roic_sdo_dual			, //o
	roic_sdi				, //i
	roic_sdi_dual			, //i
	ack_tx_end				  //o
);

//----------------------------------------
// Signal declaration 
//----------------------------------------

	input					sys_clk					; //i, 100MHz
	input					sys_rst					; //i

	input					fsm_rst_index			; //i
	input					org_reset_fsm			; //i
	input	[15:0]			roic_reg_set_0 			; //i, [15:0]
	input	[15:0]			roic_reg_set_1  		; //i, [15:0]
	input	[15:0]			roic_reg_set_1_dual  		; //i, [15:0]
	input	[15:0]			roic_reg_set_2  		; //i, [15:0]
	input	[15:0]			roic_reg_set_3  		; //i, [15:0]
	input	[15:0]			roic_reg_set_4  		; //i, [15:0]
	input	[15:0]			roic_reg_set_5  		; //i, [15:0]
	input	[15:0]			roic_reg_set_6  		; //i, [15:0]
	input	[15:0]			roic_reg_set_7  		; //i, [15:0]
	input	[15:0]			roic_reg_set_8  		; //i, [15:0]
	input	[15:0]			roic_reg_set_9  		; //i, [15:0]
	input	[15:0]			roic_reg_set_10 		; //i, [15:0]
	input	[15:0]			roic_reg_set_11 		; //i, [15:0]
	input	[15:0]			roic_reg_set_12 		; //i, [15:0]
	input	[15:0]			roic_reg_set_13 		; //i, [15:0]
	input	[15:0]			roic_reg_set_14 		; //i, [15:0]
	input	[15:0]			roic_reg_set_15			; //i, [15:0]

	output	wire			roic_cs0				; //o
	output	wire			roic_sck				; //o, 3.125MHz, From 100MHz divided to 32.
	output	wire			roic_sdo				; //o
	output	wire			roic_sdo_dual			; //o
	input					roic_sdi				; //i
	input					roic_sdi_dual				; //i
	output	wire			ack_tx_end				; //o

//----------------------------------------
//----------------------------------------

	wire			reset_roic				;
	reg				reset_roic_1d 			;
	reg				reset_roic_2d 			;

	reg				sys_clk_div16			;
	reg				sys_clk_div8			;
	reg				sys_clk_div4			;
	reg				sys_clk_div2			;
	reg				sys_clk_div				;
//	wire			sys_clk_div				;

	reg				roic_reg_wr				;
	reg				roic_reg_wr_1d			;
	reg				roic_reg_wr_2d			;
	wire			start_roic_reg_wr		;
	wire			end_roic_reg_wr			;

	reg	[ 7:0]		spi_width_cnt			;
	wire			end_spi_width			;

	reg	[ 7:0]		cs_cnt					;
	wire			end_roic_wr_cycle		;

	reg	[ 7:0]		num_roic_cnt			;

	reg				sig_cs					;
	wire			hi_cs					;
	wire			lo_cs					;

	reg				valid_spi_clk			;
	reg				valid_spi_clk_1d		;
	wire			hi_valid_spi_clk		;
	wire			lo_valid_spi_clk		;

	reg				sig_roic_sdo			;
	reg				sig_roic_sdo_dual		;

	wire			dump_roic_reg_data		;
	reg				dump_roic_reg_data_1d	;
	reg	[15:0]		buf_roic_reg_data		;
	reg	[15:0]		roic_reg_data			;

	reg	[15:0]		buf_roic_reg_data_dual	;
	reg	[15:0]		roic_reg_data_dual			;

	reg				sig_sys_clk_div			; // rev8, 220617, kkh

//----------------------------------------
// Generate SCK
//----------------------------------------

	always @(posedge sys_clk or negedge sys_rst) begin
		if (!sys_rst) begin
			sys_clk_div2	<= 0;
		end
		else begin
			sys_clk_div2	<= ~sys_clk_div2;
		end
	end

	always @(posedge sys_clk_div2 or negedge sys_rst) begin
		if (!sys_rst) begin
			sys_clk_div4	<= 0;
		end
		else begin
			sys_clk_div4	<= ~sys_clk_div4;
		end
	end

	always @(posedge sys_clk_div4 or negedge sys_rst) begin
		if (!sys_rst) begin
			sys_clk_div8	<= 0;
		end
		else begin
			sys_clk_div8	<= ~sys_clk_div8;
		end
	end

	always @(posedge sys_clk_div8 or negedge sys_rst) begin
		if (!sys_rst) begin
			sys_clk_div16	<= 0;
		end
		else begin
			sys_clk_div16	<= ~sys_clk_div16;
		end
	end
/*
	always @(posedge sys_clk_div16 or negedge sys_rst) begin
		if (!sys_rst) begin
//			sig_sys_clk_div		<= 0;
			sys_clk_div		<= 0;
		end
		else begin
//			sig_sys_clk_div		<= ~sig_sys_clk_div;
			sys_clk_div		<= ~sys_clk_div;
		end
	end
*/
	// rev8, 220617, kkh
	always @(posedge sys_clk_div16 or negedge sys_rst) begin
		if (!sys_rst) begin
			sig_sys_clk_div		<= 0;
		end
		else begin
			sig_sys_clk_div		<= ~sig_sys_clk_div;
		end
	end
	always @(posedge sig_sys_clk_div or negedge sys_rst) begin
		if (!sys_rst) begin
			sys_clk_div		<= 0;
		end
		else begin
			sys_clk_div		<= ~sys_clk_div;
		end
	end

//	global u_sys_clk_div( .in(( sig_sys_clk_div )), .out ( sys_clk_div ) );

//----------------------------------------
// SPI width counter, It is used to generate CS and SPI Clock.
//----------------------------------------

	assign end_spi_width = (spi_width_cnt == `CS_END_DELAY) ? 1'b1 : 1'b0;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			spi_width_cnt <= 8'd0;
		else begin
			if (!roic_reg_wr) // Total roic register writing enable signal
				spi_width_cnt <= 8'd0;
			else begin
				if (end_spi_width)
					spi_width_cnt <= 8'd0;
				else
					spi_width_cnt <= spi_width_cnt + 8'd1;
			end
		end
	end

//----------------------------------------
// Counting the number of Read/Write roic registers
//----------------------------------------

	assign end_roic_wr_cycle = ((cs_cnt == `NUM_SPI_WR) && end_spi_width && roic_reg_wr) ? 1'b1 : 1'b0;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if (!sys_rst)
			cs_cnt <= 8'd0;
		else begin
			if (!roic_reg_wr)
				cs_cnt <= 8'd0; 
			else begin
				if (roic_reg_wr)
					if (end_roic_wr_cycle)
						cs_cnt <= 8'd0;
					else if (end_spi_width)
						cs_cnt <= cs_cnt + 8'd1;
			end
		end
	end

//----------------------------------------
// Counting the number of ROIC to write the registers
//----------------------------------------

	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			num_roic_cnt <= 8'd0;
		else begin
			if (!roic_reg_wr)
				num_roic_cnt <= 8'd0;
			else begin
				if (end_roic_reg_wr)
					num_roic_cnt <= 8'd0;
				else if (end_roic_wr_cycle)
					num_roic_cnt <= num_roic_cnt + 8'd1;
			end
		end
	end

//----------------------------------------
// Generating ROIC register write index
//----------------------------------------

	assign reset_roic = fsm_rst_index & org_reset_fsm;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst) begin
			reset_roic_1d <= 1'b0;
			reset_roic_2d <= 1'b0;
		end
		else begin
			reset_roic_1d <= reset_roic;
			reset_roic_2d <= reset_roic_1d;
		end
	end

	assign start_roic_reg_wr	= (!reset_roic_1d) & reset_roic_2d;
	assign end_roic_reg_wr		= ((num_roic_cnt == `NUM_ROIC) && end_roic_wr_cycle) ? 1'b1 : 1'b0;
	// assign end_roic_reg_wr		= ((num_roic_cnt == 8'd1) && end_roic_wr_cycle) ? 1'b1 : 1'b0;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			roic_reg_wr <= 1'b0;
		else begin
			if (end_roic_reg_wr)
				roic_reg_wr <= 1'b0;
			else if (start_roic_reg_wr)
				roic_reg_wr <= 1'b1;
		end
	end

//----------------------------------------
// Generationg SPI CS signal
//----------------------------------------

	assign hi_cs = (spi_width_cnt == `CS_START_DELAY) ? 1'b1 : 1'b0;
	assign lo_cs = (spi_width_cnt == `CLK2CS_DELAY) ? 1'b1 : 1'b0;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			sig_cs <= 1'b0;
		else begin
			if (lo_cs) sig_cs <= 1'b0;
			else if(hi_cs) sig_cs <= 1'b1;
		end
	end

	assign roic_cs0		= sig_cs;

	// assign roic_cs0		= (num_roic_cnt == 8'd0	) ? sig_cs : 1'b0;

//----------------------------------------
// Generating SPI Clock
//----------------------------------------

	assign hi_valid_spi_clk	= (spi_width_cnt == `CS2CLK_DELAY) ? 1'b1 : 1'b0;
	assign lo_valid_spi_clk	= (spi_width_cnt == `VALID_CLK_WIDTH) ? 1'b1 : 1'b0;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if (!sys_rst) begin
			valid_spi_clk		<= 1'b0;
		end
		else begin
			if(lo_valid_spi_clk) valid_spi_clk <= 1'b0;
			else if (hi_valid_spi_clk) valid_spi_clk <= 1'b1;
		end
	end

	always @(posedge sys_clk_div or negedge sys_rst) begin
		if (!sys_rst) begin
			valid_spi_clk_1d <= 1'b0;
		end
		else begin
			valid_spi_clk_1d <= valid_spi_clk;
		end
	end

	reg sig_roic_sck;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			sig_roic_sck <= 1'b0;
		else begin
			if (!valid_spi_clk) sig_roic_sck <= 1'b0;
			else sig_roic_sck <= ~sig_roic_sck;
		end
	end

	assign roic_sck = sig_roic_sck & roic_reg_wr;

//----------------------------------------
// Writing register data on SPI SDO
//----------------------------------------

	assign dump_roic_reg_data = hi_cs;
	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst)
			dump_roic_reg_data_1d <= 1'b0;
		else
			dump_roic_reg_data_1d <= dump_roic_reg_data;
	end	

	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst) begin
			buf_roic_reg_data		<= 16'd0;
			buf_roic_reg_data_dual	<= 16'd0;
		end
		else begin
			if (roic_reg_wr && dump_roic_reg_data) begin
				case (cs_cnt)
					8'd0 : begin
						buf_roic_reg_data[15:10] <= 6'b100000;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_0[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100000;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_0[9:0];
					end
					8'd1 : begin
						buf_roic_reg_data[15:10] <= 6'b100001;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_1[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100001;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_1_dual[9:0];
					end
					8'd2 : begin
						buf_roic_reg_data[15:10] <= 6'b100010;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_2[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100010;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_2[9:0];
					end
					8'd3 : begin
						buf_roic_reg_data[15:10] <= 6'b100011;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_3[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100011;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_3[9:0];
					end
					8'd4 : begin
						buf_roic_reg_data[15:10] <= 6'b100100;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_4[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100100;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_4[9:0];
					end
					8'd5 : begin
						buf_roic_reg_data[15:10] <= 6'b100101;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_5[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100101;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_5[9:0];
					end
					8'd6 : begin
						buf_roic_reg_data[15:10] <= 6'b100110;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_6[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100110;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_6[9:0];
					end
					8'd7 : begin
						buf_roic_reg_data[15:10] <= 6'b100111;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_7[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b100111;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_7[9:0];
					end
					8'd8 : begin
						buf_roic_reg_data[15:10] <= 6'b101000;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_8[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101000;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_8[9:0];
					end
					8'd9 : begin
						buf_roic_reg_data[15:10] <= 6'b101001;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_9[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101001;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_9[9:0];
					end
					8'd10 : begin
						buf_roic_reg_data[15:10] <= 6'b101010;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_10[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101010;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_10[9:0];
					end
					8'd11 : begin
						buf_roic_reg_data[15:10] <= 6'b101011;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_11[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101011;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_11[9:0];
					end
					8'd12 : begin
						buf_roic_reg_data[15:10] <= 6'b101100;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_12[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101100;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_12[9:0];
					end
					8'd13 : begin
						buf_roic_reg_data[15:10] <= 6'b101101;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_13[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101101;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_13[9:0];
					end
					8'd14 : begin
						buf_roic_reg_data[15:10] <= 6'b101110;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_14[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101110;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_14[9:0];
					end
					8'd15 : begin
						buf_roic_reg_data[15:10] <= 6'b101111;
						buf_roic_reg_data[9 : 0] <= roic_reg_set_15[9:0];
						buf_roic_reg_data_dual[15:10] <= 6'b101111;
						buf_roic_reg_data_dual[9 : 0] <= roic_reg_set_15[9:0];
					end
				endcase
			end
		end
	end

	always @(posedge sys_clk_div or negedge sys_rst) begin
		if(!sys_rst) begin
			roic_reg_data <= 16'd0;
			sig_roic_sdo <= 1'b0;
			roic_reg_data_dual <= 16'd0;
			sig_roic_sdo_dual <= 1'b0;
		end
		else begin
			if (dump_roic_reg_data_1d && (!valid_spi_clk)) begin
				roic_reg_data <= buf_roic_reg_data;
				sig_roic_sdo <= 1'b0;
				roic_reg_data_dual <= buf_roic_reg_data_dual;
				sig_roic_sdo_dual <= 1'b0;
			end
			else if (valid_spi_clk && spi_width_cnt[0]) begin
				roic_reg_data[15:1] <= roic_reg_data[14:0];
				sig_roic_sdo <= roic_reg_data[15];
				roic_reg_data_dual[15:1] <= roic_reg_data_dual[14:0];
				sig_roic_sdo_dual <= roic_reg_data_dual[15];
			end
		end
	end

	// assign roic_sdo	= sig_roic_sdo & valid_spi_clk_1d;
	// holee num_roic_cnt == 0 �϶��� ���, Daisy-chain
	assign roic_sdo	= (valid_spi_clk_1d && num_roic_cnt== 8'd0) ? sig_roic_sdo : 1'b0;
	assign roic_sdo_dual	= (valid_spi_clk_1d && num_roic_cnt== 8'd0) ? sig_roic_sdo_dual : 1'b0;

	always @(posedge sys_clk_div or negedge sys_rst) begin
		if (!sys_rst) begin
			roic_reg_wr_1d	<= 1'b0;
			roic_reg_wr_2d	<= 1'b0;
		end
		else begin
			roic_reg_wr_1d	<= roic_reg_wr;
			roic_reg_wr_2d	<= roic_reg_wr_1d;
		end
	end

	assign ack_tx_end	= (!roic_reg_wr_1d) & roic_reg_wr_2d;

//----------------------------------------
endmodule
