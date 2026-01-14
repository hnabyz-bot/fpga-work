`timescale 1ns / 1ps

//==============================================================================
// Project      : TI-ROIC
// File         : first_ch_detector.sv
// Module Name  : first_channel_detector
// Author       : drake.lee / H&abyz
// Create Date  : 2025-05-08
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : First channel detector module for ti-roic project.
//              : Detects specific patterns in lower byte of input data stream.
//
// Dependencies : None
//
//==============================================================================
// Revision History:
// Version | Date       | Author        | Description
//---------|------------|---------------|---------------------------------------
// 1.0     | 2025-05-08 | drake.lee     | Initial creation
//==============================================================================

/**
 * @file first_ch_detector.sv
 * @brief First channel detector for synchronized data streams
 * 
 * This module detects specific patterns (0xB8 or 0xF8) in the lower 8 bits
 * of incoming 24-bit data streams. When 4 consecutive matching patterns are
 * detected, it generates a one-cycle pulse signal.
 *
 * Features:
 * - Uses a sliding shift register to track incoming data
 * - Generates first_sample_pulse when 4 consecutive valid patterns are detected
 * - All signals are synchronized to the rising edge of the clock
 * - Outputs data with appropriate latency to align with detection pulse
 * 
 * @note KEEP AS-IS: The following implementation generates a 1-clock pulse.
 *       Alternative implementations are available in the comments below for 
 *       potential future enhancements if needed.
 */

module first_channel_detector (
    input  logic         clk,
    input  logic         rst,

    input  logic [23:0]  aligned_data_in,     // 24-bit aligned ADC data
    output logic         detect_data_valid,          // Indicates valid data detected
    output logic [23:0]  word_data_out,       // Synchronized output
    output logic         first_sample_pulse   // 1-cycle pulse on first sample detection
);

    // Shift registers for 4 consecutive data samples
    logic [23:0] data_shift_reg0;  // Newest data
    logic [23:0] data_shift_reg1;
    logic [23:0] data_shift_reg2;
//    logic [23:0] data_shift_reg3;  // Oldest data
    
    // Pattern detection signals
    logic [2:0] match_count;
    logic is_valid_pattern;
    
    // Check if current input has valid pattern in lower 8 bits
    assign is_valid_pattern = (aligned_data_in[7:0] == 8'hB8 || aligned_data_in[7:0] == 8'hF8);
    
    // Main process for shifting data and detecting patterns
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers
            match_count <= 3'd0;
            first_sample_pulse <= 1'b0;
            word_data_out <= 24'd0;
            detect_data_valid <= 1'b0;
            
            // Reset shift registers
            data_shift_reg0 <= 24'd0;
            data_shift_reg1 <= 24'd0;
            data_shift_reg2 <= 24'd0;
//            data_shift_reg3 <= 24'd0;
            
        end else begin
            // Sliding shift of data (without using for loop)
//            data_shift_reg3 <= data_shift_reg2;
            data_shift_reg2 <= data_shift_reg1;
            data_shift_reg1 <= data_shift_reg0;
            data_shift_reg0 <= aligned_data_in;  // New data enters
            
            // Output data 1 clock earlier (data_shift_reg2 instead of data_shift_reg3)
            word_data_out <= data_shift_reg2;
            
            // Pattern detection logic
            if (is_valid_pattern) begin
                if (match_count == 3'd3) begin
                    // On 4th match, trigger pulse and reset counter
                    match_count <= 3'd0;
                    first_sample_pulse <= 1'b1;  // Single-cycle pulse

                    detect_data_valid <= 1'b1;  // Indicate valid data detected
                    
                    // For potential handshake enhancement
                    // valid <= 1'b1;
                end else begin
                    // Keep counting matches
                    match_count <= match_count + 1'd1;
                    first_sample_pulse <= 1'b0;
                end
            end else begin
                // Reset on pattern mismatch
                match_count <= 3'd0;
                first_sample_pulse <= 1'b0;
            end
        end
    end

endmodule

//------------------------------------------------------------------------------
// Testbench for first_channel_detector
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module first_channel_detector_tb();
    // Test signals
    logic         clk;
    logic         rst;
    logic [23:0]  aligned_data_in;
    logic [23:0]  aligned_data_d1;  // Delayed input (renamed from aligned_data_reg for clarity)
    logic [23:0]  word_data_out;
    logic         first_sample_pulse;
    
    // Parameters for test
    localparam CLK_PERIOD = 100;  // 10MHz = 100ns period
    
    // Random seed for data generation
    int seed;  // Seed for random number generation
    int detection_count = 0;  // Count actual detections for validation
    
    // Clock generation
    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Register input data to synchronize with clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            aligned_data_d1 <= 24'd0;
        end else begin
            aligned_data_d1 <= aligned_data_in;  // Delay input by 1 clock cycle
        end
    end

    // DUT instantiation - use delayed input data
    first_channel_detector dut (
        .clk(clk),
        .rst(rst),
        .aligned_data_in(aligned_data_d1),  // Use delayed input
        .word_data_out(word_data_out),
        .first_sample_pulse(first_sample_pulse)
    );
    
    // Function to generate random upper bits with fixed lower 8 bits
    function logic [23:0] gen_data_with_fixed_lower_byte(input logic [7:0] lower_byte);
        logic [15:0] random_upper;
        random_upper = $urandom();  // Generate random upper 16 bits with seed update
        return {random_upper, lower_byte};
    endfunction
    
    // Function to generate completely random data
    function logic [23:0] gen_random_data();
        return $urandom();  // Generate random data with seed update
    endfunction
    
    // Send data with consistent lower byte but random upper bytes
    task send_consistent_lower_byte(input logic [7:0] byte_value, input int count);
        for (int i = 0; i < count; i++) begin
            aligned_data_in = gen_data_with_fixed_lower_byte(byte_value);
            @(posedge clk);  // Wait for clock edge to ensure synchronization
        end
    endtask
    
    // Send completely random data
    task send_random_data(input int count);
        $display("Sending %0d random data values", count);
        for (int i = 0; i < count; i++) begin
            aligned_data_in = gen_random_data();
            @(posedge clk);  // Wait for clock edge to ensure synchronization
        end
    endtask
    
    // Check if the lower 8 bits caused a detection
    task check_detection(input string test_name, input logic expected);
        if (first_sample_pulse != expected) begin
            $display("ERROR in %s: first_sample_pulse was %b, expected %b", 
                    test_name, first_sample_pulse, expected);
        end else if (expected) begin
            $display("PASS: %s - First sample detected correctly", test_name);
            detection_count++;
        end
    endtask

    // Test sequence
    initial begin
        // Initialize signals and seed
        rst = 1'b1;
        aligned_data_in = 24'h000000;
        detection_count = 0;
        
        // Initialize seed with either a fixed value (for reproducible tests)
        // or current simulation time (for varying tests)
        // Uncomment one of the following:
        seed = 42;                 // Fixed seed for reproducible results
        // seed = $urandom();      // Random seed for varying results each run
        // seed = $time;           // Time-based seed
        
        $display("Using random seed: %0d", seed);
        
        // Reset sequence
        #(CLK_PERIOD*2);
        rst = 1'b0;
        #(CLK_PERIOD);
        
        // Test Case 1: Start with random data
        $display("\n=== Test Case 1: Initial random data ===");
        send_random_data(10);  // Send 10 random values
        
        // Test Case 2: First 0xB8 match sequence
        $display("\n=== Test Case 2: First 0xB8 match sequence ===");
        // Send one matching byte then 2 random data points to ensure we're starting fresh
        aligned_data_in = gen_data_with_fixed_lower_byte(8'hB8);
        #(CLK_PERIOD);
        send_random_data(2);
        
        // Now send the 4 consistent bytes that should trigger detection
        $display("Sending 4 consecutive data points with lower byte = 0xB8");
        send_consistent_lower_byte(8'hB8, 4);
        check_detection("Four consecutive 0xB8 patterns", 1'b1);
        
        // Immediately follow with random data to ensure pulse goes back to 0
        $display("Sending random data after detection");
        send_random_data(5);
        check_detection("After detection random data", 1'b0);
        
        // Test Case 3: Three consistent values then one different (no detection)
        $display("\n=== Test Case 3: Three consistent then break (no detection) ===");
        send_consistent_lower_byte(8'hF8, 3);
        $display("Sent 3 consecutive data points with lower byte = 0xF8");
        aligned_data_in = gen_data_with_fixed_lower_byte(8'h00); // Break the sequence
        #(CLK_PERIOD);
        $display("Sent 1 breaking data point with lower byte = 0x00");
        check_detection("Three consistent then break", 1'b0);
        
        // Mix with random data after
        send_random_data(3);
        
        // Test Case 4: One 0xF8 match sequence
        $display("\n=== Test Case 4: One 0xF8 match sequence ===");
        // Send random data before the match sequence
        send_random_data(5);
        
        // Send 4 consistent 0xF8 bytes that should trigger detection
        $display("Sending 4 consecutive data points with lower byte = 0xF8");
        send_consistent_lower_byte(8'hF8, 4);
        check_detection("Four consecutive 0xF8 patterns", 1'b1);
        
        // Continue with random data
        send_random_data(5);
        
        // Test Case 5: Second 0xB8 match sequence
        $display("\n=== Test Case 5: Second 0xB8 match sequence ===");
        // Send random data before the match sequence
        send_random_data(3);
        
        // Send 4 consistent 0xB8 bytes that should trigger detection
        $display("Sending 4 consecutive data points with lower byte = 0xB8");
        send_consistent_lower_byte(8'hB8, 4);
        check_detection("Second set of four consecutive 0xB8 patterns", 1'b1);
        
        // Continue with random data
        send_random_data(5);
        
        // Test Case 6: Invalid patterns that look similar but aren't exact matches
        $display("\n=== Test Case 6: Similar but invalid patterns ===");
        send_consistent_lower_byte(8'hB9, 4); // Similar to B8 but not a match
        check_detection("Similar invalid pattern B9", 1'b0);
        send_consistent_lower_byte(8'hF7, 4); // Similar to F8 but not a match
        check_detection("Similar invalid pattern F7", 1'b0);
        
        // End with random data
        send_random_data(5);
        
        // Verify detection happened exactly three times (twice for 0xB8, once for 0xF8)
        $display("\n=== Test Summary ===");
        $display("Total detections: %0d (Expected: 3)", detection_count);
        if (detection_count != 3) begin
            $display("ERROR: Incorrect number of detections!");
        end else begin
            $display("PASS: Correct number of detections");
        end
        
        // End simulation
        #(CLK_PERIOD*2);
        $display("\nSimulation completed successfully");
        $finish;
    end
    
    // Monitor detection
    always @(posedge clk) begin
        if (first_sample_pulse) begin
            $display("At time %t: First sample detected! Data = %h (Lower byte = %h)", 
                     $time, word_data_out, word_data_out[7:0]);
        end
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("first_channel_detector_tb.vcd");
        $dumpvars(0, first_channel_detector_tb);
    end
endmodule
