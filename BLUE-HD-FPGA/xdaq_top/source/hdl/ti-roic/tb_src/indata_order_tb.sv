//==============================================================================
// Project      : TI-ROIC
// File         : indata_order_tb.sv
// Author       : drake.lee
// Create Date  : 2025-05-12
// Description  : Testbench for the indata_order module.
//                Simulates the module and verifies its functionality.
//==============================================================================

`timescale 1ns / 1ps

module indata_order_tb;
    // Parameters
    parameter CLK_PERIOD = 10;  // 10ns (100MHz)
    parameter SIM_TIME = 10000; // 10us
    parameter BUFFER_SIZE = 256;
    parameter PATTERN_STEP = 64;      // Pattern step (0,64,128,192,1,65,...)
    parameter PATTERN_GROUPS = 4;     // Number of pattern groups (0,64,128,192)
    
    // Signals
    logic        clk;
    logic        reset;
    logic        data_valid;
    logic        out_en;
    logic [23:0] outdata;
    
    // Test-related variables
    int output_count;
    int error_count;
    logic [23:0] expected_data [BUFFER_SIZE];
    logic [23:0] original_data [BUFFER_SIZE];
    /* synthesis translate_off */
    string line; // For simulation only
    /* synthesis translate_on */
    
    // DUT instance
    indata_order dut (
        .clk(clk),
        .reset(reset),
        .data_valid(data_valid),
        .out_en(out_en),
        .outdata(outdata)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Test scenario
    initial begin
        // Initialization
        reset = 1;
        data_valid = 0;
        output_count = 0;
        error_count = 0;
        
        // Generate expected data and prepare for verification
        generate_expected_data();
        
        // Release reset
        repeat(5) @(posedge clk);
        reset = 0;
        repeat(2) @(posedge clk);
        
        // Provide time for the module to read and process the file
        repeat(20) @(posedge clk);
        
        // Generate data_valid signal
        data_valid = 1;
        @(posedge clk);
        data_valid = 0;
        
        // Wait until all data is output or simulation time limit is reached
        wait_for_outputs();
        
        // Report results
        report_results();
        
        // Verify output file - independent of clock, only verifies the file
        verify_output_file();
          
        // End simulation
        #100 $finish;
    end
    
    // Task to monitor outputs - simply counts the output data
    task wait_for_outputs();
        fork
            // Output monitoring process
            begin
                while (1) begin
                    @(posedge clk);
                    if (out_en) begin
                        // Increment output count
                        output_count++;
                    end
                end
            end
            
            // Check for timeout or completion of all data output
            begin
                fork
                    #SIM_TIME;  // Maximum simulation time
                    
                    // Periodically check if the module has completed outputting all data
                    begin
                        automatic int last_count = 0;
                        automatic int stable_count = 0;
                        
                        while (stable_count < 100) begin  // Considered complete if no change for 100 clock cycles
                            #(CLK_PERIOD*10);  // Check every 10 clocks
                            
                            if (last_count == output_count)
                                stable_count += 10;
                            else begin
                                last_count = output_count;
                                stable_count = 0;
                            end
                        end
                    end
                join_any
                disable fork;
            end
        join_any
        disable fork;
    endtask
    
    // Task to generate expected data
    task generate_expected_data();
        automatic int file_in;
        automatic int read_count = 0;
        automatic logic [23:0] temp_value;
        automatic int out_idx;
        automatic int base;
        automatic int group;
        automatic int index;
        
        // First, read the original data
        file_in = $fopen("f:/github_work/ti-roic/roic_top/tb_src/input_data.txt", "r");
        if (file_in == 0) begin
            $display("Error: Cannot open input_data.txt for reading");
            $finish;
        end
        
        // Read data from file
        while ($fgets(line, file_in) && read_count < BUFFER_SIZE) begin
            // Skip comments
            if (line.substr(0, 1) == "/") continue;
            
            // Read hexadecimal data
            if ($sscanf(line, "%h", temp_value) == 1) begin
                original_data[read_count] = temp_value;
                read_count++;
            end
        end
        $fclose(file_in);
        
        // Exit if no data was read
        if (read_count == 0) begin
            $display("Error: No data read from input file");
            $finish;
        end
        
        // Generate expected data according to the reordering pattern (0,64,128,192,1,65,...)
        out_idx = 0;
        for (base = 0; base < PATTERN_STEP; base++) begin
            for (group = 0; group < PATTERN_GROUPS; group++) begin
                index = base + (group * PATTERN_STEP);
                if (index < read_count) begin
                    expected_data[out_idx] = original_data[index];
                    out_idx++;
                end
            end
        end
    endtask
    
    // Task to verify output file (independent of clock/simulation signals, only verifies the file)
    task verify_output_file();
        automatic int file_out;
        automatic int read_count = 0;
        automatic int pass = 1;
        automatic logic [23:0] temp_value;

        file_out = $fopen("f:/github_work/ti-roic/roic_top/tb_src/output_reordered_data.txt", "r");
        if (file_out == 0) begin
            $display("Error: Cannot open output_reordered_data.txt for verification");
            error_count++;
            return;
        end

        $display("\n=== Verifying output_reordered_data.txt ===");

        while ($fgets(line, file_out) && read_count < BUFFER_SIZE) begin
            // Skip comments
            if (line.substr(0, 1) == "/") continue;

            // Read hexadecimal data
            if ($sscanf(line, "%h", temp_value) == 1) begin
                // Compare with expected data
                if (temp_value != expected_data[read_count]) begin
                    $display("Error at index %0d - Expected %h, Got %h", 
                            read_count, expected_data[read_count], temp_value);
                    error_count++;
                    pass = 0;
                end
                read_count++;
            end
        end
        $fclose(file_out);

        if (read_count < BUFFER_SIZE) begin
            $display("Error: Output file contains fewer entries than expected (%0d/%0d)", 
                    read_count, BUFFER_SIZE);
            error_count++;
            pass = 0;
        end

        if (pass) begin
            $display("Output file verification: PASSED - All %0d entries match expected pattern", read_count);
        end else begin
            $display("Output file verification: FAILED - %0d errors found", error_count);
        end
    endtask
    
    // Task to report results
    task report_results();
        $display("\n=== Test Results ===");
        $display("Output data count: %0d", output_count);
        
        if (output_count > 0 && error_count == 0) begin
            $display("Test completed: Module successfully processed and output data.");
        end else if (output_count > 0 && error_count > 0) begin
            $display("Test completed with %0d errors.", error_count);
        end else begin
            $display("Test failed: No output data!");
            error_count++;
        end
    endtask
    // Output data verification is integrated in the wait_for_outputs task
    
endmodule
