`timescale 1ps/1ps

//==============================================================================
// Project      : TI-ROIC
// File         : deser_single.sv
// Module Name  : deser_single_lane
// Author       : drake.lee / H&abyz
// Create Date  : 2025-04-03
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Single-lane deserializer module using ISERDESE2 primitive.
//              : Converts high-speed LVDS data stream to parallel output.
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

module deser_single_lane #(
    parameter int DEV_W = 8,          // Deserialization factor for ISERDES (must be 8 for now)
    parameter int WORD_SIZE = 24,     // Size of the deserialized output word (must be multiple of 8)
    parameter string IOSTANDARD = "LVDS_25", // IO standard for differential inputs
    parameter real REFCLK_FREQ = 200.0 // Reference clock frequency in MHz
) (
    // Input differential pairs
    input  logic data_in_from_pins_p,    // Positive LVDS input
    input  logic data_in_from_pins_n,    // Negative LVDS input
    
    // Clocks and reset
    input  logic clk_in_int_buf,        // High-speed bit clock (typically 200MHz)
    input  logic clk_div,               // Divided clock for ISERDES (typically 50MHz)
    input  logic rst,                   // Asynchronous reset
    // input  logic refclk_200m,           // Reference clock for IDELAYCTRL (200MHz)
    input  logic fclk_out,              // Frame clock output for synchronization
    
    // // Delay control interface
    // input  logic ld_dly_tap,            // Load delay tap value (pulse)
    // input  logic in_delay_data_ce,      // Delay clock enable
    // input  logic in_delay_data_inc,     // Delay increment (1) or decrement (0)
    // input  logic [4:0] in_delay_tap_in, // Delay tap value input (0-31)
    // output logic [4:0] in_delay_tap_out,// Delay tap value output for monitoring
    
    // Data output
    output logic [WORD_SIZE-1:0] data_in_to_device // Parallel output data
);

    // Validate parameters
    initial begin
        if (DEV_W != 8)
            $error("Parameter DEV_W must be 8 for current implementation");
        if (WORD_SIZE % 8 != 0)
            $error("Parameter WORD_SIZE must be a multiple of 8");
    end

    logic [1:0] fclk_in;
    logic fclk_hi_edge;

    // Data path signals
    logic data_in_from_pins_int;    // Single-ended data after IBUFDS
    logic data_in_from_pins_delay;  // Data after IDELAYE2
    // Deserialization signals
    logic [7:0] iserdes_q;          // ISERDESE2 output byte
    logic [7:0] iserdes_q_d1;       // First stage CDC register
    logic [7:0] iserdes_q_d2;       // Second stage CDC register

    // Word assembly signals
    logic [WORD_SIZE-1:0] temp_word;     // Word being built in clk_div domain
    logic [WORD_SIZE-1:0] temp_word_d1;  // First capture register (clk_div domain)
    // (* mark_debug="true" *) 
    logic [WORD_SIZE-1:0] temp_word_d2;  // Second capture register (fclk_p domain)

    //========================================================================
    // Signal assignments 
    //========================================================================
    assign clock_enable = 1'b1;                     // ISERDESE2 always enabled
    assign clk_in_int_inv = ~clk_in_int_buf;        // Generate inverted clock for DDR

    IBUFDS #(
        .DIFF_TERM      ("FALSE"),
        .IBUF_LOW_PWR   ("FALSE"),          
        .IOSTANDARD     (IOSTANDARD)      // Use specified IO standard
    ) ibufds_inst (
        .I              (data_in_from_pins_p),   // Positive input
        .IB             (data_in_from_pins_n),   // Negative input
        .O              (data_in_from_pins_int)  // Single-ended output
    );

    assign data_in_from_pins_delay = data_in_from_pins_int; // Output delayed data

    ISERDESE2 #(
        .DATA_RATE          ("DDR"),          // Double data rate
        .DATA_WIDTH         (DEV_W),          // 8-bit deserialization
        .INTERFACE_TYPE     ("NETWORKING"),   // Networking mode
        .NUM_CE             (2),              // Use both CE inputs
        .DYN_CLKDIV_INV_EN  ("FALSE"),        // No dynamic clock inversion
        .DYN_CLK_INV_EN     ("FALSE"),        // No dynamic clock inversion
        .SERDES_MODE        ("MASTER"),       // Primary deserializer
        .OFB_USED           ("FALSE"),        // No feedback
        .IOBDELAY           ("IFD")           // Use input delay
        // .IOBDELAY           ("NONE")           // Use input delay
    ) iserdese2_master (
        // Data outputs (8-bit)
        .Q1                 (iserdes_q[0]),    // LSB output first
        .Q2                 (iserdes_q[1]),
        .Q3                 (iserdes_q[2]),
        .Q4                 (iserdes_q[3]),
        .Q5                 (iserdes_q[4]),
        .Q6                 (iserdes_q[5]),
        .Q7                 (iserdes_q[6]),
        .Q8                 (iserdes_q[7]),    // MSB output last
        
        // Control inputs
        .BITSLIP            (1'b0),           // No bit slip correction
        .CE1                (clock_enable),    // Clock enable
        .CE2                (clock_enable),    // Clock enable
        
        // Clock inputs
        .CLK                (clk_in_int_buf), // High-speed bit clock
        .CLKB               (clk_in_int_inv), // Inverted bit clock
        .CLKDIV             (clk_div),        // Divided clock
        .CLKDIVP            (1'b0),           // No phase shifted clock
        
        // Data inputs
       .D                  (1'b0),           // Not used (using DDLY)
       .DDLY               (data_in_from_pins_delay), // Delayed input
        // .D                  (data_in_from_pins_delay),           // Not used (using DDLY)
        // .DDLY               (1'b0), // Delayed input
        
        // Reset and control
        .RST                (rst),            // Asynchronous reset
        
        // Unused ports
        // .O                  (data_in_from_pins_out),
        .O                  (),
        .SHIFTOUT1          (),
        .SHIFTOUT2          (),
        .SHIFTIN1           (1'b0),
        .SHIFTIN2           (1'b0),
        .DYNCLKDIVSEL       (1'b0),
        .DYNCLKSEL          (1'b0),
        .OFB                (1'b0),
        .OCLK               (1'b0),
        .OCLKB              (1'b0)
    );


    //========================================================================
    // Stage 3: Word Assembly and Clock Domain Crossing
    //========================================================================
    // Combine multiple deserializer bytes into complete data word
    // This implements a shift register to assemble the complete WORD_SIZE word

    // always_ff @(posedge clk_div or posedge rst) begin
    //     if (rst) begin
    //         temp_word <= '0;  // Clear word on reset
    //     end else begin
    //         // MSB-to-LSB shift register - newest byte in LSB position
    //         // temp_word[23:16] <= temp_word[15:8];  // Shift high byte
    //         // temp_word[15:8] <= temp_word[7:0];    // Shift middle byte
    //         // temp_word[7:0] <= iserdes_q;          // Insert new byte
    //         temp_word <= {temp_word[WORD_SIZE-9:0], iserdes_q}; // Shift and insert new byte
    //     end
    // end
    
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            iserdes_q_d1 <= '0;
            iserdes_q_d2 <= '0;
        end else begin
            iserdes_q_d1 <= iserdes_q;  // First stage CDC
            iserdes_q_d2 <= iserdes_q_d1; // Second stage CDC
        end
    end

    assign temp_word = {iserdes_q_d2, iserdes_q_d1, iserdes_q}; // Assemble 24-bit word

    always_ff @(posedge clk_in_int_buf or posedge rst) begin
        if (rst) begin
            fclk_in <= '0;  // Clear word on reset
        end else begin
            fclk_in <= {fclk_in[0], fclk_out};  // Capture assembled word
        end
    end

    assign fclk_hi_edge = (fclk_in == 2'b01) ? 1'b1 : 1'b0; // Detect rising edge

    always_ff @(posedge clk_in_int_buf or posedge rst) begin
        if (rst) begin
            temp_word_d1 <= '0;
        end else if (fclk_hi_edge) begin// Capture on frame clock edge
            temp_word_d1 <= temp_word;
        end
    end

    always_ff @(posedge fclk_out or posedge rst) begin
        if (rst) begin
            temp_word_d2 <= '0;
        end else begin
            temp_word_d2 <= temp_word_d1;  // Stable transfer across domains
        end
    end

    // Output assignment
    assign data_in_to_device = temp_word_d2;
    // assign data_temp_word = temp_word;
    
endmodule