`timescale 1ns / 1ps

module bit_align_tb;

    // Parameters
    localparam CLK_PERIOD = 10; // Clock period in nanoseconds (100 MHz)

    // Testbench signals
    reg clk;
    reg clk_rst;
    reg data_rst;
    reg [23:0] din;
    reg [4:0] extra_shift;
    reg align_to_fclk;
    reg align_start;

    wire [4:0] shift_out;
    wire [23:0] dout;
    wire align_done;

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Generate a 100 MHz clock
    end

    // Instantiate the DUT (Device Under Test)
    bit_align dut (
        .clk_rst        (clk_rst),      // Reset signal for the clock domain input
        .data_rst       (data_rst),     // Reset signal for the data domain input
        .clk            (clk),          // Clock signal input
        .din            (din),          // Input data to be aligned
        .extra_shift    (extra_shift),  // Additional shift value input
        .align_to_fclk  (align_to_fclk),// Select between calculated shift and extra shift input
        .align_start    (align_start),  // Start signal for alignment process input
        .shift_out      (shift_out),    // Output shift value
        .dout           (dout),         // Aligned output data
        .align_done     (align_done)    // Alignment status output
    );

    // Testbench stimulus
    initial begin
        // Initialize inputs
        clk_rst = 1;
        data_rst = 1;
        din = 24'b0;
        extra_shift = 5'b0;
        align_to_fclk = 0;
        align_start = 0;

        // Apply reset
        #20 clk_rst = 0;
        data_rst = 0;

        @(posedge clk); // Wait for the first clock edge after reset

        
        // Test case 1: Basic alignment with align_to_fclk = 0
        // din = 24'hFFF000;
        din = 24'h7FF800;
        align_to_fclk = 0; // Use calculated shift
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 1: align_to_fclk = 0 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 2: Basic alignment with align_to_fclk = 1
        // din = 24'hFFF000;
        din = 24'h3FC000;
        align_to_fclk = 1; // Use extra_shift
        extra_shift = 5'h02; // Apply an extra shift of 2
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 2: align_to_fclk = 1 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 3: Random data with align_to_fclk = 0
        din = 24'h123456; // Random data
        align_to_fclk = 0; // Use calculated shift
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 3: align_to_fclk = 0 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 4: Random data with align_to_fclk = 1
        din = 24'h123456; // Random data
        align_to_fclk = 1; // Use extra_shift
        extra_shift = 5'h03; // Apply an extra shift of 3
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 4: align_to_fclk = 1 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 5: Pattern 24'hFF0000 with align_to_fclk = 0
        // din = 24'hFFF000;
        din = 24'h00FF00;
        align_to_fclk = 0; // Use calculated shift
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 5: align_to_fclk = 0 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 6: Pattern 24'hFF0000 with align_to_fclk = 1
        din = 24'h1FE000;
        align_to_fclk = 1; // Use extra_shift
        extra_shift = 5'h03; // Apply an extra shift of 1
        align_start = 1;
        #CLK_PERIOD;
        align_start = 0;
        #100;
        $display("Test Case 6: align_to_fclk = 1 | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // Test case 7: No alignment start signal
        din = 24'h1FE000;
        align_to_fclk = 0; // Use calculated shift
        align_start = 0; // Do not start alignment
        #100;
        $display("Test Case 7: No align_start | align_done = %b, shift_out = %h, dout = %h", align_done, shift_out, dout);

        // End simulation
        #500;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | din: %h | extra_shift: %h | align_to_fclk: %b | align_start: %b | shift_out: %h | dout: %h | align_done: %b",
                 $time, din, extra_shift, align_to_fclk, align_start, shift_out, dout, align_done);
    end

endmodule