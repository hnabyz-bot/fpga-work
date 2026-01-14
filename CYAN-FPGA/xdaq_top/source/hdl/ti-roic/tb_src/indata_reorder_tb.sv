`timescale 1ns / 1ps

//==============================================================================
// Project      : TI-ROIC
// File         : indata_reorder_tb.sv
// Module Name  : indata_reorder_tb
// Author       : drake.lee / H&abyz
// Create Date  : 2025-05-10
// Encoding     : UTF-8
//
// Description  : Testbench for indata_reorder module
//              : Automatically checks input vs output data for correctness
//              : Reports pass/fail status without requiring waveform analysis
//
//==============================================================================

module indata_reorder_tb;
    // Parameters
    localparam DATA_WIDTH = 24;
    localparam BUFFER_DEPTH = 256;
    localparam CLK_PERIOD = 10;  // 10ns (100MHz)

    // Signals
    logic clk;
    logic rst;
    logic read_req;
    logic [DATA_WIDTH-1:0] data_in;
    logic valid_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic valid_out;

    // Test variables
    int error_count;
    int data_count;
    logic [DATA_WIDTH-1:0] test_data [BUFFER_DEPTH];
    logic [DATA_WIDTH-1:0] received_data [BUFFER_DEPTH];
    int received_count;

    // DUT instance
    indata_reorder #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH)
    ) dut (.*);

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize
        rst = 1;
        read_req = 0;
        valid_in = 0;
        data_in = 0;
        error_count = 0;
        received_count = 0;

        // Initialize received_data array
        for (int i = 0; i < BUFFER_DEPTH; i++) begin
            received_data[i] = '0;
        end

        // Generate test data (simple incremental pattern)
        for (int i = 0; i < BUFFER_DEPTH; i++) begin
            test_data[i] = i;
        end

        // Reset
        repeat(5) @(posedge clk);
        rst = 0;
        repeat(2) @(posedge clk);

        // Write all data
        for (int i = 0; i < BUFFER_DEPTH; i++) begin
            @(posedge clk);
            data_in = test_data[i];
            valid_in = 1;
        end
        @(posedge clk);
        valid_in = 0;

        // Display write completion
        $display("Write done at %0d ns", $time);

        // Short delay before reading
        repeat(5) @(posedge clk);

        // Read request
        read_req = 1;
        @(posedge clk);
        read_req = 0;

        // Collect and verify data
        while (received_count < BUFFER_DEPTH) begin
            @(posedge clk);
            if (valid_out) begin
                received_data[received_count] = data_out;
                if (data_out !== test_data[received_count]) begin
                    $display("ERROR at index %0d: Expected=%h, Got=%h", 
                            received_count, test_data[received_count], data_out);
                    error_count++;
                end
                received_count++;
            end
        end

        // Report results
        $display("\n=== Test Results ===");
        $display("Total data: %0d", BUFFER_DEPTH);
        $display("Received: %0d", received_count);
        $display("Errors: %0d", error_count);
        
        if (error_count == 0 && received_count == BUFFER_DEPTH)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        // End simulation
        #(CLK_PERIOD*10);
        $finish;
    end

    // Debug monitoring - simplified
    always @(posedge clk) begin
        if (read_req)
            $display("Read request received at %0d ns", $time);
    end

endmodule
