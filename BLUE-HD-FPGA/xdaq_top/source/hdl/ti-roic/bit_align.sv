`timescale 1ns / 1ps

//==============================================================================
// Project      : TI-ROIC
// File         : bit_align.sv
// Module Name  : bit_align
// Author       : drake.lee / H&abyz
// Create Date  : 2025-04-03
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Bit alignment module for deserializer data streams.
//              : Detects and aligns patterns in 24-bit streams.
//
// Dependencies : None
//
//==============================================================================
// Revision History:
// Version | Date       | Author        | Description
//---------|------------|---------------|---------------------------------------
// 1.0     | 2025-04-03 | drake.lee     | Initial creation
// 1.1     | 2025-05-08 | drake.lee     | Optimized comments
// 1.2     | 2025-05-08 | drake.lee     | Further comment optimization
//==============================================================================


module bit_align #(
    parameter int DATA_WIDTH = 24,       // Width of input/output data
    parameter bit [23:0] PATTERN_1 = 24'hFFF000,  // First alignment pattern
    parameter bit [23:0] PATTERN_2 = 24'hFF0000   // Second alignment pattern
    // parameter int MAX_SHIFT = 23         // Maximum bits to shift (0-23)
) (
    // Control and reset inputs
    // input  logic        clk_rst,        // Clock domain reset (asynchronous)
    input  logic        data_rst,       // Data domain reset (asynchronous)
    input  logic        clk,            // Clock signal
    
    // Data and control inputs
    input  logic [DATA_WIDTH-1:0] din,         // Input data to be aligned
    input  logic [4:0]  extra_shift,           // Manual shift value
    input  logic        align_to_fclk,         // Select mode: 0=pattern detection, 1=manual
    input  logic        align_start,           // Start alignment process
    
    // Output signals
    output logic [4:0]  shift_out,      // Applied shift amount
    output logic [DATA_WIDTH-1:0] dout, // Aligned output data
    output logic        align_done      // Alignment status flag
);

    //========================================================================
    // Internal signals
    //========================================================================
    logic [(DATA_WIDTH*2)-1:0] datareg;     // Double-width shift register for data
    logic [DATA_WIDTH-1:0] dout_wire;     // Pre-registered output data
    logic [4:0] shift_int_wire;           // Detected shift value
    logic [4:0] shift_int;                // Selected shift value
    logic align_done_reg;                 // Internal alignment status
    logic [4:0] total_shift;              // Final shift value to apply

    //========================================================================
    // Input Buffering and Pattern Detection
    //========================================================================
    // Double buffer to hold current and previous data words
    always_ff @(posedge clk or posedge data_rst) begin
        if (data_rst) begin
            datareg <= '0;  // Clear on reset
        end else begin
            datareg <= {datareg[DATA_WIDTH-1:0], din};  // Shift in new data
        end
    end

    // Pattern detection logic for shift calculation
    // always_comb begin
    always_ff @(posedge clk or posedge data_rst) begin
        if (data_rst) begin
            shift_int_wire <= '0;  // Clear on reset
        end else begin
        // Pattern detection for PATTERN_1 (0xFFF000) and PATTERN_2 (0xFF0000)
            case (datareg[DATA_WIDTH-1:0])
                // Each case represents a pattern rotated by N bits
                // PATTERN_1 rotation cases
                24'b111111111111000000000000 : shift_int_wire = 5'h00;  // No shift
                24'b111111111110000000000001 : shift_int_wire = 5'h01;  // Shift right by 1
                24'b111111111100000000000011 : shift_int_wire = 5'h02;  // Shift right by 2
                24'b111111111000000000000111 : shift_int_wire = 5'h03;  // Shift right by 3
                24'b111111110000000000001111 : shift_int_wire = 5'h04;  // Shift right by 4
                24'b111111100000000000011111 : shift_int_wire = 5'h05;  // Shift right by 5
                24'b111111000000000000111111 : shift_int_wire = 5'h06;  // Shift right by 6
                24'b111110000000000001111111 : shift_int_wire = 5'h07;  // Shift right by 7
                24'b111100000000000011111111 : shift_int_wire = 5'h08;  // Shift right by 8
                24'b111000000000000111111111 : shift_int_wire = 5'h09;  // Shift right by 9
                24'b110000000000001111111111 : shift_int_wire = 5'h0A;  // Shift right by 10
                24'b100000000000011111111111 : shift_int_wire = 5'h0B;  // Shift right by 11
                24'b000000000000111111111111 : shift_int_wire = 5'h0C;  // Shift right by 12
                24'b000000000001111111111110 : shift_int_wire = 5'h0D;  // Shift right by 13
                24'b000000000011111111111100 : shift_int_wire = 5'h0E;  // Shift right by 14
                24'b000000000111111111111000 : shift_int_wire = 5'h0F;  // Shift right by 15
                24'b000000001111111111110000 : shift_int_wire = 5'h10;  // Shift right by 16
                24'b000000011111111111100000 : shift_int_wire = 5'h11;  // Shift right by 17
                24'b000000111111111111000000 : shift_int_wire = 5'h12;  // Shift right by 18
                24'b000001111111111110000000 : shift_int_wire = 5'h13;  // Shift right by 19
                24'b000011111111111100000000 : shift_int_wire = 5'h14;  // Shift right by 20
                24'b000111111111111000000000 : shift_int_wire = 5'h15;  // Shift right by 21
                24'b001111111111110000000000 : shift_int_wire = 5'h16;  // Shift right by 22
                24'b011111111111100000000000 : shift_int_wire = 5'h17;  // Shift right by 23

                // PATTERN_2 rotation cases
                24'b111111110000000000000000 : shift_int_wire = 5'h00;  // No shift
                24'b111111100000000000000001 : shift_int_wire = 5'h01;  // Shift right by 1
                24'b111111000000000000000011 : shift_int_wire = 5'h02;  // Shift right by 2
                24'b111110000000000000000111 : shift_int_wire = 5'h03;  // Shift right by 3
                24'b111100000000000000001111 : shift_int_wire = 5'h04;  // Shift right by 4
                24'b111000000000000000011111 : shift_int_wire = 5'h05;  // Shift right by 5
                24'b110000000000000000111111 : shift_int_wire = 5'h06;  // Shift right by 6
                24'b100000000000000001111111 : shift_int_wire = 5'h07;  // Shift right by 7
                24'b000000000000000011111111 : shift_int_wire = 5'h08;  // Shift right by 8
                24'b000000000000000111111110 : shift_int_wire = 5'h09;  // Shift right by 9
                24'b000000000000001111111100 : shift_int_wire = 5'h0A;  // Shift right by 10
                24'b000000000000011111111000 : shift_int_wire = 5'h0B;  // Shift right by 11
                24'b000000000000111111110000 : shift_int_wire = 5'h0C;  // Shift right by 12
                24'b000000000001111111100000 : shift_int_wire = 5'h0D;  // Shift right by 13
                24'b000000000011111111000000 : shift_int_wire = 5'h0E;  // Shift right by 14
                24'b000000000111111110000000 : shift_int_wire = 5'h0F;  // Shift right by 15
                24'b000000001111111100000000 : shift_int_wire = 5'h10;  // Shift right by 16
                24'b000000011111111000000000 : shift_int_wire = 5'h11;  // Shift right by 17
                24'b000000111111110000000000 : shift_int_wire = 5'h12;  // Shift right by 18
                24'b000001111111100000000000 : shift_int_wire = 5'h13;  // Shift right by 19
                24'b000011111111000000000000 : shift_int_wire = 5'h14;  // Shift right by 20
                24'b000111111110000000000000 : shift_int_wire = 5'h15;  // Shift right by 21
                24'b001111111100000000000000 : shift_int_wire = 5'h16;  // Shift right by 22
                24'b011111111000000000000000 : shift_int_wire = 5'h17;  // Shift right by 23
                //
                // default: shift_int_wire = 5'h00;  // Default case - no shift
            endcase
        end
    end

    //========================================================================
    // Shift Control Logic
    //========================================================================
    // Mode selection between auto-detection and manual shift value
    always_ff @(posedge clk or posedge data_rst) begin
        if (data_rst) begin
            shift_int <= '0;  // Clear on reset
        end else if (align_start) begin
            // When align_start is asserted, select shift source based on mode
            if (!align_to_fclk) begin
                shift_int <= shift_int_wire;  // Auto mode: Use detected shift value
            end else begin
                shift_int <= extra_shift;     // Manual mode: Use provided shift value
            end
        end
    end

    // Final shift amount assignment
    assign total_shift = shift_int;

    //========================================================================
    // Data Shifting Logic (Barrel Shifter Implementation)
    //========================================================================
    // Dynamic bit shift implementation using barrel shifter approach
    always_comb begin
        case (total_shift)
            5'h00: dout_wire = datareg[DATA_WIDTH-1:0];         // No shift
            5'h01: dout_wire = datareg[DATA_WIDTH+0:1];           // Shift by 1
            5'h02: dout_wire = datareg[DATA_WIDTH+1:2];         // Shift by 2
            5'h03: dout_wire = datareg[DATA_WIDTH+2:3];         // Shift by 3
            5'h04: dout_wire = datareg[DATA_WIDTH+3:4];         // Shift by 4
            5'h05: dout_wire = datareg[DATA_WIDTH+4:5];         // Shift by 5
            5'h06: dout_wire = datareg[DATA_WIDTH+5:6];         // Shift by 6
            5'h07: dout_wire = datareg[DATA_WIDTH+6:7];         // Shift by 7
            5'h08: dout_wire = datareg[DATA_WIDTH+7:8];         // Shift by 8
            5'h09: dout_wire = datareg[DATA_WIDTH+8:9];         // Shift by 9
            5'h0A: dout_wire = datareg[DATA_WIDTH+9:10];        // Shift by 10
            5'h0B: dout_wire = datareg[DATA_WIDTH+10:11];       // Shift by 11
            5'h0C: dout_wire = datareg[DATA_WIDTH+11:12];       // Shift by 12
            5'h0D: dout_wire = datareg[DATA_WIDTH+12:13];       // Shift by 13
            5'h0E: dout_wire = datareg[DATA_WIDTH+13:14];       // Shift by 14
            5'h0F: dout_wire = datareg[DATA_WIDTH+14:15];       // Shift by 15
            5'h10: dout_wire = datareg[DATA_WIDTH+15:16];       // Shift by 16
            5'h11: dout_wire = datareg[DATA_WIDTH+16:17];       // Shift by 17
            5'h12: dout_wire = datareg[DATA_WIDTH+17:18];       // Shift by 18
            5'h13: dout_wire = datareg[DATA_WIDTH+18:19];       // Shift by 19
            5'h14: dout_wire = datareg[DATA_WIDTH+19:20];       // Shift by 20
            5'h15: dout_wire = datareg[DATA_WIDTH+20:21];       // Shift by 21
            5'h16: dout_wire = datareg[DATA_WIDTH+21:22];       // Shift by 22
            5'h17: dout_wire = datareg[DATA_WIDTH+22:23];       // Shift by 23
            default: dout_wire = datareg[DATA_WIDTH-1:0];       // Default: no shift
        endcase
    end

    // Output data registration for improved timing
    always_ff @(posedge clk or posedge data_rst) begin
        if (data_rst) begin
            dout <= '0;  // Clear on reset
        end else begin
            dout <= dout_wire;
        end
    end

    //========================================================================
    // Alignment Status Logic
    //========================================================================
    // Pattern matching for alignment confirmation
    always_ff @(posedge clk or posedge data_rst) begin
        if (data_rst) begin
            align_done_reg <= 1'b0;  // Not aligned on reset
        end else if (align_start) begin
            // Check if output matches either pattern to confirm alignment
            if ((dout_wire == PATTERN_1) || (dout_wire == PATTERN_2)) begin
                align_done_reg <= 1'b1;  // Successful alignment
            end else begin
                align_done_reg <= 1'b0;  // Failed alignment
            end
        end
    end

    //========================================================================
    // Output Assignments
    //========================================================================
    assign align_done = align_done_reg;  // Expose alignment status
    assign shift_out = shift_int;      // Expose shift amount used

endmodule