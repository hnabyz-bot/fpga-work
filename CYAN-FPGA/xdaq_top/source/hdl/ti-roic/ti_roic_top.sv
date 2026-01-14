`timescale 1ns / 1ps

// ==============================================================================
// Project      : TI-ROIC
// File         : ti_roic_top.sv
// Module Name  : ti_roic_top
// Author       : drake.lee / H&abyz
// Create Date  : 2025-05-08
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Top-level module integrating ROIC processing components.
//              : Connects bit_clock_module, deser_single_lane, and bit_align modules.
//
// Dependencies : bit_clock_module.sv, deser_single.sv, bit_align.sv, indata_reorder.sv
//
// ==============================================================================
// Revision History:
// Version | Date       | Author        | Description
// ---------|------------|---------------|---------------------------------------
// 0.00     | 2025-05-08 | drake.lee     | Initial creation
// 0.01     | 2025-05-13 | drake.lee     | Added first channel detection
// 0.02     | 2025-05-13 | drake.lee     | Added data reordering functionality
// ==============================================================================

module ti_roic_top #(
    parameter int DATA_WIDTH = 24,       // Width of data path
    parameter string IOSTANDARD = "LVDS_25", // IO standard for LVDS
    parameter real REFCLK_FREQ = 200.0,  // Reference clock frequency (MHz)
    parameter bit [23:0] PATTERN_1 = 24'hFFF000,  // First alignment pattern
    parameter bit [23:0] PATTERN_2 = 24'hFF0000   // Second alignment pattern
) (
    // Control and reset inputs
    input  logic clk_reset,        // Master reset for all clock domains
    input  logic data_reset,       // Data domain reset
    
    // LVDS differential inputs
    input  logic fclk_in_p,         // Clock input positive (LVDS)
    input  logic fclk_in_n,         // Clock input negative (LVDS)
    // LVDS differential inputs
    input  logic clk_in_p,         // Clock input positive (LVDS)
    input  logic clk_in_n,         // Clock input negative (LVDS)
    input  logic data_in_p,        // Data input positive (LVDS)
    input  logic data_in_n,        // Data input negative (LVDS)
    
    // Delay control interface
    // input  logic ld_dly_tap,       // Load delay tap value (pulse)
    // input  logic delay_data_ce,    // Delay clock enable
    // input  logic delay_data_inc,   // Delay increment (1) or decrement (0)
    // input  logic [4:0] delay_tap_in, // Delay tap value input (0-31)
    // output logic [4:0] delay_tap_out, // Delay tap value output for monitoring
    
    // Bit alignment control
    input  logic align_to_fclk,    // Alignment mode: 0=pattern detection, 1=manual
    input  logic align_start,      // Start alignment process
    input  logic [4:0] extra_shift, // Manual shift value (used when align_to_fclk=1)
    
    input  logic en_test_pattern_col, // Enable test pattern for column
    input  logic en_test_pattern_row, // Enable test pattern for row

    input  logic sync,
    // Data reordering control
    input  logic data_read_req,    // Request to read reordered data

    input logic data_read_clk, // Output clock for data reordering 240Mhz , for 12.8us line time
    
    // for debug
    output logic even_odd_toggle_out, // for debug
    output logic roic_even_odd_out,    // for debug
        
    // Output signals
    output logic [4:0] shift_out,  // Applied shift amount
    output logic align_done,       // Alignment status flag
    output logic valid_read_enable, // Enable signal for reading reordered data
    output logic [DATA_WIDTH-1:0] reordered_data_a, // Final reordered data output
    output logic [DATA_WIDTH-1:0] reordered_data_b, // Final reordered data output
    output logic reordered_valid,   // Reordered data valid flag
    output logic [DATA_WIDTH-1:0] detected_data_out,
    output logic channel_detected  // First channel detection flag
);

    //--------------------------------------------------------------------------
    // Internal signals
    //--------------------------------------------------------------------------
    logic fclk_out;
    logic bit_clk;
    logic clk_div_out;

    logic [DATA_WIDTH-1:0] deser_data;   // Data after deserialization, before alignment
    logic [DATA_WIDTH-1:0] aligned_data; // Aligned data output
    logic [DATA_WIDTH-1:0] detected_data; // Data output from first_channel_detector
    logic s_channel_detected;              // Channel detection flag from first_channel_detector
    logic detect_data_valid;            // Data valid flag from first_channel_detector


    //--------------------------------------------------------------------------
    // Clock Generator Instance
    //--------------------------------------------------------------------------
    bit_clock_module #(
        .IOSTANDARD     (IOSTANDARD),
        .REFCLK_FREQ    (REFCLK_FREQ),
        .DIV1_RATIO     (4),            // First divider (÷4)
        .DIV2_RATIO     (3)             // Second divider (÷3)
    ) bit_clock_gen (
        // Control inputs
        .clk_reset      (clk_reset),
        // .ld_dly_tap     (ld_dly_tap),
        
        // Differential clock input
        .fclk_in_p       (fclk_in_p),
        .fclk_in_n       (fclk_in_n),
        // Differential clock input
        .clk_in_p       (clk_in_p),
        .clk_in_n       (clk_in_n),
        
        // Clock outputs
        .bit_clk        (bit_clk),
        .clk_div_out    (clk_div_out),
        .fclk_out       (fclk_out)
    );

    //--------------------------------------------------------------------------
    // Deserializer Instance
    //--------------------------------------------------------------------------
    deser_single_lane #(
        .DEV_W                  (8),                 // 8-bit deserialization
        .WORD_SIZE              (DATA_WIDTH),    // 24-bit output word
        .IOSTANDARD             (IOSTANDARD),
        .REFCLK_FREQ            (REFCLK_FREQ)
    ) deserializer (
        // Input differential pairs
        .data_in_from_pins_p    (data_in_p),
        .data_in_from_pins_n    (data_in_n),
        
        // Clocks and reset
        .clk_in_int_buf         (bit_clk),

        .clk_div                (clk_div_out),
        .rst                    (data_reset),
        .fclk_out               (fclk_out),
        
        // // Delay control interface
        // .ld_dly_tap             (ld_dly_tap),
        // .in_delay_data_ce       (delay_data_ce),
        // .in_delay_data_inc      (delay_data_inc),
        // .in_delay_tap_in        (delay_tap_in),
        // .in_delay_tap_out       (delay_tap_out),
        
        .data_in_to_device      (deser_data)
    );
    
    //--------------------------------------------------------------------------
    // Bit Alignment Instance
    //--------------------------------------------------------------------------
    bit_align #(
        .DATA_WIDTH     (DATA_WIDTH),
        .PATTERN_1      (PATTERN_1),
        .PATTERN_2      (PATTERN_2)
        // .MAX_SHIFT      (23)            // Maximum bits to shift (0-23)
    ) aligner (
        // Control and reset inputs
        // .clk_rst        (clk_reset),
        .data_rst       (data_reset),
        .clk            (fclk_out), // Use the high-speed clock for alignment
        
        // Data and control inputs
        .din            (deser_data),
        .extra_shift    (extra_shift),
        .align_to_fclk  (align_to_fclk),
        .align_start    (align_start),
        
        // Output signals
        .shift_out      (shift_out),
        .dout           (aligned_data),          // Updated name for clarity
        .align_done     (align_done)
    );    
    
    //--------------------------------------------------------------------------
    // First Channel Detector Instance
    //--------------------------------------------------------------------------
    first_channel_detector channel_detector (
        // Inputs
        .clk                    (fclk_out),        // Use the divided clock
        .rst                    (data_reset),      // Reset signal
        .aligned_data_in        (aligned_data),       // Input from bit_align
        .detect_data_valid      (detect_data_valid), // Valid signal from bit_align
        .first_sample_pulse     (s_channel_detected),
        .word_data_out          (detected_data)          // Updated name for clarity
    );

    //--------------------------------------------------------------------------
    // Data Reordering Instance
    //--------------------------------------------------------------------------
    indata_reorder #(
        .DATA_WIDTH         (DATA_WIDTH),  // Match the data width parameter
        .BUFFER_DEPTH       (256)        // Default buffer depth
    ) data_reorder (
        // Control inputs
        .clk                (fclk_out),         // Use the divided clock
        .rst                (data_reset),         // Reset signal
        .sync               (sync),               // Synchronization signal
        .read_req           (data_read_req), // External read request signal
        
        .en_test_pattern_col    (en_test_pattern_col),
        .en_test_pattern_row    (en_test_pattern_row),
        
        // Data inputs
        .data_in            (detected_data),  // Input from first_channel_detector
        .valid_in           (detect_data_valid), // Valid signal from first_channel_detector
        .channel_detected   (s_channel_detected), // Channel detection signal
        
        .out_clk            (data_read_clk), // Clock for data reordering

        //for debug
        .even_odd_toggle_out(even_odd_toggle_out), // for debug
        .roic_even_odd_out  (roic_even_odd_out), // for debug

        // Data outputs
        .valid_read_enable  (valid_read_enable), // Enable signal for reading reordered data
        .data_out_a         (reordered_data_a), // Final reordered data
        .data_out_b         (reordered_data_b), // Final reordered data
        .valid_out          (reordered_valid) // Reordered data valid flag
    );

    assign detected_data_out = detected_data;
    assign channel_detected = s_channel_detected; // Assign the channel detection flag
    
endmodule