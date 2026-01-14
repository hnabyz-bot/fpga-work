`timescale 1ns / 1ps

//==============================================================================
// Project      : TI-ROIC
// File         : bit_clock_module.sv
// Module Name  : bit_clock_module
// Author       : drake.lee / H&abyz
// Create Date  : 2025-04-03
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Optimized clock generation and division module for high-speed deserializer.
//              : Converts LVDS input clock to three synchronized output clocks.
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


module bit_clock_module #(
    // Module parameters
    parameter IOSTANDARD = "LVDS_25",   // IO standard for differential inputs
    parameter REFCLK_FREQ = 200.0,      // Reference clock frequency in MHz
    parameter DIV1_RATIO = 4,           // First divider ratio (must be power of 2)
    parameter DIV2_RATIO = 3            // Second divider ratio
) (
    // Control inputs
    input  logic clk_reset,      // Asynchronous reset for all clock domains
    // input  logic ld_dly_tap,     // Load delay tap value signal (pulse)
    
    // Differential clock input
    input  logic fclk_in_p,       // Clock input positive (LVDS)
    input  logic fclk_in_n,       // Clock input negative (LVDS)
    // Differential clock input
    input  logic clk_in_p,       // Clock input positive (LVDS)
    input  logic clk_in_n,       // Clock input negative (LVDS)
    
    // Clock outputs
    output logic bit_clk,        // High-speed bit clock (direct from input)
    output logic clk_div_out,    // Divided clock (÷4) for byte alignment
    output logic fclk_out        // High-speed clock output (from bit_clock_module)
);

    logic fclk_in_int;          // Internal clock input (unbuffered)
    logic clk_div;               // Divided clock internal (unbuffered)
    logic clk_in_int;            // LVDS buffer output before delay
    
    IBUFDS #(
        .DIFF_TERM      ("FALSE"),
        .IBUF_LOW_PWR   ("FALSE"),
        .IOSTANDARD     (IOSTANDARD)  // Configurable LVDS standard
    ) adc_fclk_inst (
        .I          (fclk_in_p),   // Positive differential input
        .IB         (fclk_in_n),   // Negative differential input
        .O          (fclk_in_int)  // Single-ended output
        // .O          (fclk_out)  // Single-ended output
    );

    assign fclk_out = fclk_in_int;  // Direct assignment for optimization

    IBUFDS #(
        .DIFF_TERM      ("FALSE"),
        .IBUF_LOW_PWR   ("FALSE"),
        .IOSTANDARD     (IOSTANDARD)  // Configurable LVDS standard
    ) adc_dclk_inst (
        .I          (clk_in_p),   // Positive differential input
        .IB         (clk_in_n),   // Negative differential input
        .O          (clk_in_int)  // Single-ended output
    );

    logic [1:0] mod_clkdiv4;
    
    always_ff @(posedge clk_in_int or posedge clk_reset) begin
        if (clk_reset)
            mod_clkdiv4 <= 2'b00;  // Initialize to specific value for alignment
        else
            mod_clkdiv4 <= mod_clkdiv4 + 1'b1;  // Increment counter
    end
    
    assign clk_div = mod_clkdiv4[1];  // Use MSB for 50% duty cycle

    //========================================================================
    // Output Assignments
    //========================================================================
    
    assign clk_div_out = clk_div;         // Expose first divided clock
    assign bit_clk = clk_in_int;      // Expose high-speed bit clock

endmodule