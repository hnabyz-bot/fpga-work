`timescale 1ns / 1ps
// `include	"./p_define.sv"

//==============================================================================
// Project      : TI-ROIC
// File         : indata_reorder.sv
// Module Name  : indata_reorder
// Author       : drake.lee / H&abyz
// Create Date  : 2025-05-10
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Data reordering module for the ti-roic project.
//              : Manages buffer operations with simplified direct control flow.
//
// Dependencies : None
//
//==============================================================================
// Revision History:
// Version | Date       | Author        | Description
//---------|------------|---------------|---------------------------------------
// 0.00    | 2025-05-10 | drake.lee     | Initial creation
// 0.01    | 2025-05-13 | drake.lee     | Simplified structure, removed FSM
//==============================================================================

/**
 * @file indata_reorder.sv
 * @brief Data reordering module with simplified control flow
 * 
 * This module implements a data reordering mechanism using a dual-port RAM.
 * The design uses a direct approach where:
 * 1. Write operations occur when valid_in is high, incrementing write pointer
 * 2. Read operations occur when read_req is high, incrementing read pointer
 * 
 * The module separates write and read operations into independent processes
 * that respond directly to their respective control signals, improving
 * modularity and ease of integration. It uses dedicated control signals for 
 * RAM operations, such as ram_read_enable, to enhance code clarity and 
 * maintainability. It's parameterized to allow for different data widths
 * and buffer depths.
 */


module indata_reorder #(
    parameter int DATA_WIDTH = 24,          // Width of data path
    parameter int BUFFER_DEPTH = 256        // Depth of buffer memory
)(
    input  logic clk,                       // Input clock
    input  logic rst,                       // Reset signal (active high)
    input  logic sync,
    input  logic read_req,                  // Read request signal

    input  logic en_test_pattern_col, // Enable test pattern for column
    input  logic en_test_pattern_row, // Enable test pattern for row

    input  logic [DATA_WIDTH-1:0] data_in,  // Input data
    input  logic valid_in,                  // Input data valid flag
    input  logic channel_detected,          // Channel detection signal
    input  logic out_clk,                   // Clock for data reordering (240MHz)

    // for debug
    output logic even_odd_toggle_out,       // for debug
    output logic roic_even_odd_out,            // for debug

    // Output signals
    output logic valid_read_enable,         // Read enable signal for output
    output logic [DATA_WIDTH-1:0] data_out_a, // Output data
    output logic [DATA_WIDTH-1:0] data_out_b, // Output data
    output logic valid_out                  // Output data valid flag
);
    // Calculate required address width based on buffer depth
    localparam ADDR_WIDTH = $clog2(BUFFER_DEPTH);
    
    //--------------------------------------------------------------------------
    // Internal Signals
    //--------------------------------------------------------------------------
    // Pipeline registers
    logic sync_rst;

    logic valid_in_1d;                          // Valid input - first stage pipeline
    logic [3:0] read_req_dly;                   // Delayed read request for synchronization

    logic [DATA_WIDTH-1:0] data_in_1d;          // Data input - first stage pipeline
    logic [DATA_WIDTH-1:0] data_out_even;       // Data input - first stage pipeline
    logic [DATA_WIDTH-1:0] data_out_odd;        // 
    logic [DATA_WIDTH-1:0] s_data_out;        // 
    logic [DATA_WIDTH-1:0] s_data_out_1d;        // 
    logic [ADDR_WIDTH-1:0] wr_addr;             // Write address pointer
    logic [ADDR_WIDTH-1:0] rd_addr;             // Read address pointer
    logic [ADDR_WIDTH:0] s_wr_count;            // Data wr_count currently in buffer
    logic wr_count_enabled;                     // Flag to enable counting after channel detection
    logic [7:0] wr_count_enabled_dly;           // Flag to enable counting after channel detection
    logic wr_end_flag;                          // Flag to indicate write end condition
    logic rd_end_flag;                          // Flag to indicate read end condition
//    logic wr_start_flag;                        // Flag to indicate write start condition
//    logic [3:0] wr_start_dly;                        // Flag to indicate write start condition
//    logic rd_start_flag;                        // Flag to indicate read start condition
    logic [2:0] rd_start_dly;                   // Delay for read start condition
    logic read_enable_flag;                     // Flag to indicate read enable condition

    logic roic_even_odd;
    logic s_test_even_odd;

    logic [7:0] wr_block_count;          // Counter to track 256-sample blocks
    logic first_channel;              // Flag to indicate first channel detection
    logic first_channel_1d;        // Registered channel detection signal
    
    // RAM control
//    logic sim_even_odd_toggle;               // Simulated even/odd address handling
    logic even_odd_toggle;            // Toggle for even/odd address handling
    logic even_odd_toggle_1d;            // Toggle for even/odd address handling
    logic even_odd_toggle_2d;            // Toggle for even/odd address handling
//    logic even_odd_toggle_3d;            // Toggle for even/odd address handling
    logic ram_read_enable_even;       // RAM read port enable signal
    logic ram_read_enable_odd;        // RAM read port enable signal
    logic ram_write_enable_even;      // RAM write port enable signal
    logic ram_write_enable_odd;       // RAM write port enable signal
    
    assign sync_rst = rst || sync; // Combine reset and sync signals


    //--------------------------------------------------------------------------
    // Write Address Control Logic
    //--------------------------------------------------------------------------
    // Handles write pointer updates and data wr_count tracking    
    always_ff @(posedge clk or posedge sync_rst) begin
        if (sync_rst) begin
            valid_in_1d <= 1'b0;         // Reset valid input flag
            data_in_1d <= '0;            // Reset data input
            wr_addr <= '0;      // Reset write address
            s_wr_count <= '0;     // Reset data wr_count
            wr_count_enabled <= 1'b0; // Reset count enable flag
            wr_block_count <= 8'd0; // Reset block counter
            first_channel <= 1'b1; // Set flag for first channel detection
            first_channel_1d <= 1'b0; // Reset channel detected flag
            // sim_even_odd_toggle <= 1'b0; // Reset toggle for even/odd address handling
            wr_count_enabled_dly <= 8'd0; // Reset write count enable delay
//            wr_start_flag <= 1'b0;          // Reset write start flag
//            wr_start_dly <= 4'b0000; // Reset write start delay
            roic_even_odd <= 1'b0;
        end else begin            // Process block count and check for channel detection

            valid_in_1d <= valid_in; // Register valid input signal

            if (en_test_pattern_row) begin
                data_in_1d <= {s_wr_count[7:0], s_test_even_odd, s_wr_count[6:0], 8'd0}; // Force even row for test pattern
            end else begin
                data_in_1d <= data_in;
            end

            // data_in_1d <= data_in;   // Register data input signal

            first_channel_1d <= first_channel; // Register channel detected signal
            
            if (valid_in) begin
                // Check for channel detected signal
                if (channel_detected) begin
                    // When channel is detected, reset block counter and enable counting
                    wr_block_count <= 8'd0;
                    wr_count_enabled <= 1'b1;
                    
                    // Only reset wr_count on first channel detection
                    if (first_channel) begin
                        s_wr_count <= '0;
                        first_channel <= 1'b0; // Clear first channel flag after first detection
                    end

                    s_wr_count <= s_wr_count + 1'b1;
                    
                end else if (wr_count_enabled) begin
                    // Normal counting when enabled
                    s_wr_count <= s_wr_count + 1'b1;
                    
                    // Increment block counter and check for 256 samples
                    if (wr_block_count == 8'd254) begin
                        // After 256 samples, next sample will be accepted only if channel_detected
                        wr_count_enabled <= 1'b0;  // Disable counting until next channel_detected
                    end else begin
                        wr_block_count <= wr_block_count + 8'd1;  // Continue counting in current block
                    end
                end
            end

            wr_count_enabled_dly <= {wr_count_enabled_dly[6:0], wr_count_enabled}; // Delay write count enable signal
//            wr_start_flag <= wr_count_enabled_dly == 3'b001;            // Set write start flag based on delayed signal
//            wr_start_dly <= {wr_start_dly[2:0], wr_start_flag};         // Delay write start condition

            // Update write address based on wr_count
            wr_addr <= {s_wr_count[1:0],s_wr_count[ADDR_WIDTH-1:2]};    // Ensure address width matches
//            sim_even_odd_toggle <= s_wr_count[ADDR_WIDTH];              // Toggle for even/odd address handling
            roic_even_odd <= data_in[6];
        end
    end

    assign wr_end_flag = (!wr_count_enabled && wr_count_enabled_dly[0]); // Set write end flag based on delayed signal

    // assign roic_even_odd = data_in[6];

    `ifdef TB_SIM
        assign even_odd_toggle = s_wr_count[ADDR_WIDTH]; // Use simulated toggle in testbench
        assign s_test_even_odd = s_wr_count[ADDR_WIDTH];
    `else
        assign even_odd_toggle = roic_even_odd; // Use ROIC provided toggle in hardware
        assign s_test_even_odd = data_in[6];
    `endif

    //--------------------------------------------------------------------------
    // Read Address Control Logic
    //--------------------------------------------------------------------------
    // Handles read pointer updates and output valid generation
    // always_ff @(posedge clk or posedge rst) begin
    always_ff @(posedge out_clk or posedge sync_rst) begin
        if (sync_rst) begin
            rd_addr <= '0;                  // Reset read address
            rd_start_dly <= 3'b000;         // Reset read start delay
            read_enable_flag <= 1'b0;       // Reset read start flag
//            rd_start_flag <= 1'b0;          // Reset read start flag
            rd_end_flag <= 1'b0;            // Reset read end flag
            read_req_dly <= 4'b0000; // Reset delayed read request
        end else begin

            read_req_dly <= {read_req_dly[2:0], read_req};

            // if (!read_req_dly[0]) begin
            if (!read_req_dly[1]) begin
                rd_addr <= '0; // Reset read address
            end else begin
                rd_addr <= rd_addr + 1'b1;  // Increment read address
            end

            rd_start_dly <= {rd_start_dly[1:0], wr_end_flag}; // Delay read start condition

            if (first_channel_1d || wr_count_enabled_dly == 8'h3F  || rd_end_flag) begin
                read_enable_flag <= 1'b0; // Set read start flag
            end else if (rd_start_dly == 3'b110) begin
                read_enable_flag <= 1'b1; // Clear read start flag
            end

//            if (read_enable_flag && wr_end_flag) begin
//                rd_start_flag <= 1'b1; // Set read start flag
//            end else begin
//                rd_start_flag <= 1'b0; // Reset read start flag
//            end

            rd_end_flag <= (rd_addr == 8'hFF); // Set read end flag when read address reaches 255

        end
    end

    always_ff @(posedge out_clk or posedge sync_rst) begin
        if (sync_rst) begin
            valid_out <= 1'b0;         
        end else begin
            valid_out <= read_req_dly[2]; 
        end
    end    
    
    always_ff @(posedge out_clk or posedge rst) begin
        if (rst) begin
            even_odd_toggle_1d <= 1'b0; 
            even_odd_toggle_2d <= 1'b0; 
//            even_odd_toggle_3d <= 1'b0; 
        end else begin
            even_odd_toggle_1d <= even_odd_toggle;      
            even_odd_toggle_2d <= even_odd_toggle_1d;   
//            even_odd_toggle_3d <= even_odd_toggle_2d;   
        end
    end    
    

    //--------------------------------------------------------------------------
    // RAM Read Enable Logic
    //--------------------------------------------------------------------------
    // Calculate RAM read enable signal based on read request and data availability
    always_comb begin
        // RAM read enable signal
        ram_write_enable_odd = even_odd_toggle;         // Write enable for even addresses
        ram_write_enable_even = (~even_odd_toggle);     // Write enable for odd addresses
        ram_read_enable_even = (read_req_dly[2] || read_req_dly[1]) && even_odd_toggle;
        ram_read_enable_odd =  (read_req_dly[2] || read_req_dly[1]) && (~even_odd_toggle);  // Enable reads when requested and data available
    end

    // Block RAM(XPM) for dual-port memory
    indata_ram even_ram_inst (
        .clka           (clk),
        .clkb           (out_clk),
        // .rsta           (sync_rst),
        .rstb           (sync_rst), //(rst),
        .ena            (ram_write_enable_even),
        .enb            (ram_read_enable_even),
        .wea            (valid_in_1d),
        .addra          (wr_addr),
        .addrb          (rd_addr),
        .dina           (data_in_1d),
        .rsta_busy      (),
        .rstb_busy      (),
        .doutb          (data_out_even)
    );

    indata_ram odd_ram_inst (
        .clka           (clk),
        .clkb           (out_clk),
        // .rsta           (sync_rst),
        .rstb           (sync_rst), //(rst),
        .ena            (ram_write_enable_odd),
        .enb            (ram_read_enable_odd),
        .wea            (valid_in_1d),
        .addra          (wr_addr),
        .addrb          (rd_addr),
        .dina           (data_in_1d),
        .rsta_busy      (),
        .rstb_busy      (),
        .doutb          (data_out_odd)
    );

    assign s_data_out = (even_odd_toggle_2d) ? data_out_even : data_out_odd; // Select output based on toggle
    // Assign output valid based on read request and data availability
    assign valid_read_enable = read_enable_flag;

    // always_ff @(posedge out_clk or posedge sync_rst) begin
    //     if (sync_rst) begin
    always_ff @(posedge out_clk or posedge rst) begin
        if (rst) begin
            s_data_out_1d <= '0; // Reset output data
        end else begin
            s_data_out_1d <= s_data_out; // Register output data
        end
    end    
    
    assign data_out_a = (en_test_pattern_col) ? {7'd0, ram_read_enable_even, rd_addr, 8'd0} : s_data_out_1d; // Final output data assignment
    assign data_out_b = (en_test_pattern_col) ? {7'd0, ram_read_enable_odd, rd_addr, 8'd0} : s_data_out; // Final output data assignment
    
    // for debug
    assign even_odd_toggle_out = even_odd_toggle;
    assign roic_even_odd_out = roic_even_odd;

endmodule
