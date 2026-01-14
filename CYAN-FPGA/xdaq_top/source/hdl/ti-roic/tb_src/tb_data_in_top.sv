`timescale 1ns / 1ps

//==============================================================================
// Project      : TI-ROIC
// File         : tb_data_in_top.sv
// Module Name  : tb_data_in_top
// Author       : drake.lee / H&abyz
// Create Date  : 2025-04-03
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : Testbench for ti_roic_top module with signal alignment validation.
//              : Verifies deserializer and bit alignment functionality.
//
// Dependencies : ti_roic_top.sv, roic_emul.sv
//
//==============================================================================
// Revision History:
// Version | Date       | Author        | Description
//---------|------------|---------------|---------------------------------------
// 0.00     | 2025-04-03 | drake.lee     | Initial creation
// 0.01     | 2025-05-08 | drake.lee     | Optimized comments
// 0.02     | 2025-05-08 | drake.lee     | Added roic_sim_data.txt reader
// 0.03     | 2025-05-13 | drake.lee     | Addet first channel detection
// 0.04     | 2025-05-13 | drake.lee     | Enhanced data monitoring and verification
//==============================================================================

/**
 * @file tb_data_in_top.sv
 * @brief Comprehensive testbench for ti_roic_top module with signal alignment validation
 *
 * This testbench verifies the integrated functionality of:
 * - Deserializer (deser_single_lane)
 * - Bit alignment (bit_align)
 * - Clock generation (bit_clock_module)
 * 
 * Test methodology:
 * 1. Generate test patterns using AFE2256 ROIC emulator
 * 2. Process signals through ti_roic_top module
 * 3. Verify both auto-detection and manual alignment modes
 * 4. Test system robustness with various data patterns from roic_sim_data.txt
 *
 * The testbench validates:
 * - Correct bit alignment under various conditions
 * - Clock domain crossing stability
 * - Pattern detection accuracy
 * - Mode switching between auto and manual alignment
 * - External data file integration
 */
 
module tb_data_in_top();

    //--------------------------------------------------------------------------
    // Configuration Parameters
    //--------------------------------------------------------------------------
    localparam int WORD_SIZE     = 24;     // 24-bit data word width
    localparam int CLK_PERIOD_NS = 50;     // 20MHz MCLK = 50ns period
    string roic_data_file_path = "f:/github_work/ti-roic/roic_top/tb_src/roic_sim_data_600.txt"; // Path to ROIC simulation data file
    
    //--------------------------------------------------------------------------
    // Clock and Reset Signals
    //--------------------------------------------------------------------------
    logic mclk;                      // 20MHz master clock for system
    logic mclk_sim;                  // Simulated 8.333MHz master clock for AFE
    logic dclk_sim;                  // Simulated 200MHz data clock for serialization
    logic clk_reset;                 // System clock domain reset
    logic deser_reset;               // Deserializer reset
    
    //--------------------------------------------------------------------------
    // AFE2256 Control Signals
    //--------------------------------------------------------------------------
    logic adc_data_valid;            // ADC data valid signal
    logic [WORD_SIZE-1:0] adc_data;  // 24-bit ADC data input pattern
    
    //--------------------------------------------------------------------------
    // LVDS Interface Signals
    //--------------------------------------------------------------------------
    logic dclk_p, dclk_n;            // Data clock differential pair
    logic fclk_p, fclk_n;            // Frame clock differential pair
    logic dout_p, dout_n;            // Data output differential pair
    
    //--------------------------------------------------------------------------
    // Deserializer Control Interface 
    //--------------------------------------------------------------------------
    logic ld_dly_tap;                // Load delay tap value signal
    logic in_delay_data_ce;          // Delay element clock enable
    logic in_delay_data_inc;         // Delay increment/decrement control
    logic [4:0] in_delay_tap_in;     // Delay tap value input (0-31)
    logic [4:0] in_delay_tap_out;    // Delay tap value output monitor
      //--------------------------------------------------------------------------
    // Bit Alignment Signals
    //--------------------------------------------------------------------------
    logic [4:0] extra_shift;         // Additional bit alignment shift amount
    logic align_to_fclk;             // Select mode: 0=pattern detection, 1=manual
    logic align_start;               // Start alignment process
    logic [4:0] shift_out;           // Selected shift amount output
    logic align_done;                // Alignment completion flag

    //--------------------------------------------------------------------------
    // Internal Signals
    //--------------------------------------------------------------------------
    logic bit_clk;                   // High-speed bit clock
    logic clk_div_out;               // Divided clock (÷4) 
    logic clk_div_12;                // Further divided clock (÷12)    
    
    // Output signals for data validation
    logic [23:0] reordered_data;     // Reordered data output from ti_roic_top
    logic reordered_valid;           // Reordered data valid flag
    logic data_read_req;             // Data read request signal
    logic channel_detected;          // First channel detection signal
    logic [7:0] channel_detected_dly;          // First channel detection signal
    
    // Test validation signals
    int test_pass_count;             // Counter for successful test cases
    int test_fail_count;             // Counter for failed test cases
    logic [23:0] expected_data;      // Expected data for validation

    //--------------------------------------------------------------------------
    // Clock Generation
    //--------------------------------------------------------------------------
    // Generate main system clock - 20MHz (50ns period)
    initial begin
        mclk = 1'b0;
        forever #(CLK_PERIOD_NS/2) mclk = ~mclk;
    end

    // Generate simulated AFE master clock - 4.167MHz (240ns period)
    initial begin
        mclk_sim = 1'b0;
        forever #120 mclk_sim = ~mclk_sim;
    end

    // Generate simulated data clock - 100MHz (10ns period)
    initial begin
        dclk_sim = 1'b0;
        forever #5 dclk_sim = ~dclk_sim;
    end
    
    //--------------------------------------------------------------------------
    // DUT Instantiations
    //--------------------------------------------------------------------------
    // AFE2256 emulator to generate test patterns
    afe2256_emulator #(
        .DATA_WIDTH(WORD_SIZE),
        .SIM_MODE(1),               // Enable simulation mode
        .DCLK_ALIGN(1)              // Enable DCLK alignment for better synchronization
    ) afe2256_inst (
        .mclk          (mclk),
        .mclk_sim      (mclk_sim),
        .dclk_sim      (dclk_sim),
        .reset         (clk_reset),
        .adc_data_valid(adc_data_valid),
        .adc_data      (adc_data),
        .dclk_p        (dclk_p),
        .dclk_n        (dclk_n),
        .fclk_p        (fclk_p),
        .fclk_n        (fclk_n),
        .dout_p        (dout_p),
        .dout_n        (dout_n)
    );
    
    // Main ROIC top module integration
    ti_roic_top #(
        .DATA_WIDTH    (WORD_SIZE),     // 24-bit data width
        .IOSTANDARD    ("LVDS_25"),     // LVDS_25 standard for test environment
        .REFCLK_FREQ   (200.0),         // 200MHz reference clock frequency
        .PATTERN_1     (24'hFFF000),    // First alignment pattern
        .PATTERN_2     (24'hFF0000)     // Second alignment pattern
    ) ti_roic_top_inst (
        // Control and reset inputs
        .clk_reset     (clk_reset),
        .data_reset    (deser_reset),
        
        // LVDS differential inputs
        .clk_in_p      (dclk_p),
        .clk_in_n      (dclk_n),
        .data_in_p     (dout_p),
        .data_in_n     (dout_n),
        
        // Delay control interface
        .ld_dly_tap    (ld_dly_tap),
        .delay_data_ce (in_delay_data_ce),
        .delay_data_inc(in_delay_data_inc),
        .delay_tap_in  (in_delay_tap_in),
        .delay_tap_out (in_delay_tap_out),
        
        // Bit alignment control        
        .align_to_fclk (align_to_fclk),
        .align_start   (align_start),
        .extra_shift   (extra_shift),
        
        // Data reordering control
        .data_read_req (data_read_req),
        
        // Output signals
        .bit_clk       (bit_clk),
        .clk_div_out   (clk_div_out),
        .clk_div_12    (clk_div_12),
        .shift_out     (shift_out),
        .align_done    (align_done),
        .reordered_data (reordered_data),
        .reordered_valid (reordered_valid),
        .channel_detected (channel_detected)
    );

    //--------------------------------------------------------------------------
    // Test Helper Tasks
    //--------------------------------------------------------------------------
    // Set ADC data pattern with logging
    task automatic set_adc_data(input logic [WORD_SIZE-1:0] new_adc_data);
        begin
            adc_data = new_adc_data;
            $display("[%0t ns] Setting ADC data to: 0x%h", $time, new_adc_data);
        end
    endtask
      // Task to wait for frame clock and set data
    task automatic set_data_at_fclk(input logic [WORD_SIZE-1:0] data_pattern);
        begin
            @(posedge fclk_p);
            #1; // Small delay to ensure stability
            set_adc_data(data_pattern);
            $display("[%0t ns] SET_DATA_AT_FCLK: Updated data to 0x%h on FCLK edge", 
                     $time, data_pattern);
        end
    endtask

      // Task to continuously set data at each frame clock for verification
    task automatic continuous_data_stream(input logic [WORD_SIZE-1:0] data_array[], input int delay_cycles = 0, input int repeat_count = 1);
        begin
            $display("[%0t ns] Starting continuous data stream with %0d values, repeating %0d times", 
                    $time, data_array.size(), repeat_count);
            
            for (int r = 0; r < repeat_count; r++) begin
                foreach (data_array[i]) begin
                    set_data_at_fclk(data_array[i]);
                    // Additional delay between data points if specified
                    if (delay_cycles > 0) begin
                        repeat(delay_cycles) @(posedge dclk_sim);
                    end
                end
                
                $display("[%0t ns] Finished setting continuous data stream iteration %0d of %0d", 
                        $time, r+1, repeat_count);
            end
        end
    endtask
    
    // Queue for expected data values for verification
    logic [WORD_SIZE-1:0] expected_data_queue[$];
    
    // Add expected data to queue for later verification
    task automatic queue_expected_data(input logic [WORD_SIZE-1:0] expected);
        begin
            expected_data_queue.push_back(expected);
            $display("[%0t ns] Queued expected data: 0x%h (Queue size: %0d)", 
                    $time, expected, expected_data_queue.size());
        end
    endtask

    // Continuous data verification process
    // This task will run in parallel to monitor output and verify against expected values
    task automatic start_data_verification(input int max_values = 0, input int timeout_ns = 10000);
        logic [WORD_SIZE-1:0] expected;
        logic [WORD_SIZE-1:0] last_received = 'x;
        string test_name;
        int verification_count = 0;
        int stuck_count = 0;
        time start_time;
        begin
            $display("[%0t ns] Starting continuous data verification process", $time);
            start_time = $time;
            
            // Continue monitoring until we've verified max_values (if specified) or timed out
            while ((max_values == 0 || verification_count < max_values) && 
                  ($time - start_time < timeout_ns)) begin
                // Wait for a frame clock edge to check data
                @(posedge clk_div_12);
                
                // Check if reordered data is valid
                if (reordered_valid) begin
                    // Only verify if we have expected data in the queue
                    if (expected_data_queue.size() > 0) begin
                        expected = expected_data_queue.pop_front();
                        verification_count++;
                        test_name = $sformatf("Reordered Data %0d", verification_count);
                        
                        // Compare reordered data with expected data
                        if (reordered_data === expected) begin
                            test_pass_count++;
                            $display("[%0t ns] TEST PASS: %s - Expected: 0x%h, Received: 0x%h", 
                                    $time, test_name, expected, reordered_data);
                        end else begin
                            test_fail_count++;
                            $display("[%0t ns] TEST FAIL: %s - Expected: 0x%h, Received: 0x%h", 
                                    $time, test_name, expected, reordered_data);
                        end
                    end else begin
                        // Monitor for data changes even when we don't have expected values
                        if (reordered_data !== last_received) begin
                            $display("[%0t ns] Reordered data changed without expected value: 0x%h", 
                                    $time, reordered_data);
                            stuck_count = 0;  // Reset stuck counter as data changed
                        end else begin
                            // Count how long we're stuck at same value
                            stuck_count++;
                            if (stuck_count % 10 == 0) begin  // Only log every 10th check
                                $display("[%0t ns] WARNING: Data appears stuck at 0x%h for %0d checks", 
                                        $time, reordered_data, stuck_count);
                            end
                        end
                    end

                    // Save last received value for change detection
                    last_received = reordered_data;
                end
                
                // Wait a few cycles before next check
                repeat(3) @(posedge clk_div_12);
            end
            
            $display("[%0t ns] Data verification process completed. Verified %0d values.", 
                    $time, verification_count);
        end
    endtask
    
    // Verify reordered data function
    task verify_reordered_data(input logic [23:0] expected, input string test_name = "");
        begin
            // Wait a few clock cycles for the data to propagate
            repeat(5) @(posedge clk_div_12);
            
            // Look for valid data
            fork
                begin
                    // Timeout after 1000ns
                    #1000;
                    $display("[%0t ns] TIMEOUT waiting for reordered_valid in verify_reordered_data", $time);
                    test_fail_count++;
                end
                begin
                    // Wait for valid flag or timeout
                    while (!reordered_valid) @(posedge clk_div_12);
                    
                    // Compare the data and report result
                    if (reordered_data === expected) begin
                        test_pass_count++;
                        $display("[%0t ns] TEST PASS: %s - Expected: 0x%h, Reordered: 0x%h", 
                                $time, test_name, expected, reordered_data);
                    end else begin
                        test_fail_count++;
                        $display("[%0t ns] TEST FAIL: %s - Expected: 0x%h, Reordered: 0x%h", 
                                $time, test_name, expected, reordered_data);
                    end
                    
                    disable fork;
                end
            join_any
            
        end
    endtask
    
    // Task to display test section header
    task automatic display_test_section(input string section_name);
        begin
            $display("\n=== %s ===", section_name);
        end
    endtask
    
    // Set the path to the ROIC simulation data file
    task set_data_file_path(input string path);
        begin
            roic_data_file_path = path;
            $display("[%0t ns] Updated ROIC data file path: %s", $time, roic_data_file_path);
        end
    endtask
    
    // Report test summary
    task report_test_summary();
        begin
            $display("\n====== TEST SUMMARY ======");
            $display("Total tests passed: %0d", test_pass_count);
            $display("Total tests failed: %0d", test_fail_count);
            if (test_fail_count == 0) begin
                $display("TEST RESULT: PASS - All %0d tests passed successfully", test_pass_count);
            end else begin
                $display("TEST RESULT: FAIL - %0d out of %0d tests failed", 
                         test_fail_count, (test_pass_count + test_fail_count));
            end
            $display("=======================\n");
        end
    endtask

    //--------------------------------------------------------------------------
    // Main Test Sequence
    //--------------------------------------------------------------------------
    initial begin
        // Initialize signals
        initialize_signals();
        
        // Setup and release reset
        setup_and_release_clk_reset();
        
        // Configure delay settings
        configure_delay_settings();
        
        // Start bit alignment in AUTO mode
        start_auto_alignment();
        
        // Send alignment patterns
        enable_data_transmission();
        #1000 // Wait for data to stabilize

        // Setup and release reset
        setup_and_release_deser_reset();
        
        set_alignment_mode(0); // Set to auto-detection mode
        #1000; // Wait for data to stabilize

        // Send alignment patterns
        detect_and_save_shift_value();

        set_alignment_mode(1); // Switch to manual mode
        #1000; // Wait for data to stabilize
        
        // Test data valid toggling
        test_data_valid_toggling();
        
        set_alignment_mode(0); // Set to auto-detection mode
        #1000; // Wait for data to stabilize

        // Switch to manual mode with detected shift value
        switch_to_manual_mode();
        
        set_alignment_mode(1); // Switch to manual mode
        #1000; // Wait for data to stabilize
        
        // Test data valid toggling
        test_data_valid_toggling();
        
        // Read and apply data from roic_sim_data.txt file with explicit file path
        read_and_apply_roic_data_file(roic_data_file_path);
          // Generate final test report
        report_test_summary();
        
        // End simulation
        #1000;
        $display("[%0t ns] Simulation completed successfully", $time);
        $finish;
    end
    
    //--------------------------------------------------------------------------
    // Test Initialization
    //--------------------------------------------------------------------------    // Initialize all control signals to default values
    task initialize_signals();
        begin
            // Reset control signals
            clk_reset = 1'b1;           // Assert system reset
            deser_reset = 1'b1;         // Assert deserializer reset
            adc_data_valid = 1'b0;      // Disable ADC data transmission
            adc_data = 24'h000000;      // Initialize ADC data to zeros
            
            // Delay control signals
            ld_dly_tap = 1'b0;          // Don't load delay taps yet
            in_delay_tap_in = 5'h00;    // Initial delay value = 0
            in_delay_data_ce = 1'b0;    // Disable delay control
            in_delay_data_inc = 1'b0;   // Set delay direction (not used)
            // Alignment control signals
            extra_shift = 5'h00;        // No additional bit shifting
            align_to_fclk = 1'b0;       // Use auto-detection mode initially
            align_start = 1'b0;         // Don't start alignment yet
            
            // Test validation counters
            test_pass_count = 0;        // Initialize pass counter
            test_fail_count = 0;        // Initialize fail counter
            expected_data = 24'h0;      // Initialize expected data
            
            // // Initialize file path for ROIC data
            // roic_data_file_path = "f:/github_work/ti-roic/roic_top/tb_src/roic_sim_data.txt";
            // $display("[%0t ns] ROIC data file path: %s", $time, roic_data_file_path);
        end
    endtask
    
    // Release system reset in controlled sequence
    task setup_and_release_clk_reset();
        begin
            // Hold in reset for stable initialization
            clk_reset = 1'b1;           // Ensure reset is asserted
            #200;                       // Hold reset for 200ns
            
            // Release system reset but keep deserializer in reset
            clk_reset = 1'b0;           // Release system reset
            #200;                       // Wait for system to stabilize
        end
    endtask

    // Release deserializer reset at appropriate time
    task setup_and_release_deser_reset();
        begin
            // Hold in reset for stable initialization
            deser_reset = 1'b1;         // Ensure deserializer reset is asserted
            #200;                       // Hold reset for 200ns
            
            // Release deserializer reset
            deser_reset = 1'b0;         // Release deserializer reset
            #200;                       // Wait for deserializer to stabilize
        end
    endtask

    // Start data transmission from the AFE2256 emulator
    task enable_data_transmission();
        begin
            @(posedge fclk_p);
            adc_data_valid = 1'b0;      // Disable data transmission initially
            $display("[%0t ns] Starting data transmission from AFE2256 emulator", $time);
            // Begin data pattern testing with focus on alignment patterns
            @(posedge fclk_p);         // Wait for frame clock edge
            adc_data_valid = 1'b1;     // Enable data transmission
            set_adc_data(24'h000000);  // Initial pattern (all zeros)
            
            // Starting alignment pattern test sequence
            display_test_section("ALIGNMENT PATTERN TEST (PATTERN_1: 0xFFF000) REPEATED 3 TIMES");
            
            #100;                      // Allow time for stabilization
        end
    endtask
    
    // Configure input delay tap settings for optimal timing
    task configure_delay_settings();
        begin
            // Configure delay taps for signal timing alignment
            ld_dly_tap = 1'b1;          // Enable loading of tap value
            in_delay_tap_in = 5'h00;    // Optimal tap value (determined empirically)
            #100;
            ld_dly_tap = 1'b0;          // Disable loading (value is latched)
            #100;
        end
    endtask
    
    // Set alignment mode: auto-detection (0) or manual (1)
    task set_alignment_mode(input logic mode);
        begin
            // Set alignment mode based on input parameter
            if (mode) begin
                align_to_fclk = 1'b1;   // Manual alignment mode with extra_shift value
            end else begin
                align_to_fclk = 1'b0;   // Auto-detection mode using pattern recognition
            end
        end
    endtask

    // Start automatic bit alignment process in auto-detection mode
    task start_auto_alignment();
        begin
            // Start bit alignment in AUTO mode (align_to_fclk = 0)
            display_test_section("STARTING ALIGNMENT IN AUTO-DETECTION MODE");
            align_start = 1'b0;        // Reset alignment trigger first
            #20;
            align_start = 1'b1;        // Trigger alignment process
            #200;
        end
    endtask      
    
    // Send alignment pattern and detect bit position
    task detect_and_save_shift_value();
        begin
            // Alignment pattern tests
            display_test_section("ALIGNMENT PATTERN TEST (PATTERN_1: 0xFFF000)");
            
            // Set expected data for validation
            expected_data = 24'hFFF000;
            
            // First alignment pattern - critical for align_done signal
            set_data_at_fclk(expected_data);  // Send alignment pattern for detection
            repeat(10) @(posedge dclk_sim); // Allow time for alignment detection
            
            // Wait for alignment to complete and capture shift_out value
            wait(align_done);
            #200; // Allow time for alignment to stabilize
            wait(fclk_p); // Wait for frame clock to stabilize

            // Verify detected data matches expected pattern using legacy method for initial alignment
            verify_reordered_data(expected_data, "Alignment Pattern 1");

            // Save detected shift value for manual mode
            $display("[%0t ns] Using shift value: %0d for manual alignment", $time, shift_out);
            extra_shift = shift_out;    // Store the detected shift value
            wait(fclk_p); // Wait for frame clock to stabilize
            align_start = 1'b0;        // Reset alignment trigger        
        end
    endtask
    
    // Switch from auto to manual mode using detected shift value
    task switch_to_manual_mode();
        begin
            // Switch to manual alignment mode with the detected shift value
            display_test_section("SWITCHING TO MANUAL ALIGNMENT MODE");
            align_start = 1'b0;         // First deassert alignment trigger
            #200;                       // Wait for signal to stabilize
            align_start = 1'b1;         // Restart alignment with new settings
            #200;                       // Allow time for the new setting to take effect
            
            // Verify manual mode with second pattern and set expected value
            expected_data = 24'hFF0000;
            set_data_at_fclk(expected_data);   // Second alignment pattern (PATTERN_2)
            repeat(10) @(posedge dclk_sim); // Allow time for alignment verification

            // Wait for alignment to complete and verify shift value
            wait(align_done);
            #200; // Allow time for alignment to stabilize
            
            // Verify detected data matches the expected pattern (using legacy method for initial alignment)
            verify_reordered_data(expected_data, "Manual Mode Pattern");

            wait(fclk_p); // Wait for frame clock to stabilize
            
            // Log confirmed shift value for manual mode
            $display("[%0t ns] Manual mode confirmed with shift value: %0d", $time, shift_out);
            extra_shift = shift_out;    // Store the detected shift value            wait(fclk_p); // Wait for frame clock to stabilize
            align_start = 1'b0;        // Reset alignment trigger
        end
    endtask
    
    // Test data valid signal toggling and pattern transmission with continuous streaming
    task test_data_valid_toggling();
        // Define continuous test patterns array
        logic [WORD_SIZE-1:0] test_patterns[];
        begin
            @(posedge fclk_p);
            adc_data_valid = 1'b0;      // Disable data transmission initially
            $display("[%0t ns] Starting data transmission from AFE2256 emulator", $time);

            // Toggle data valid to test state transitions
            display_test_section("TESTING DATA VALID TOGGLING WITH MULTIPLE PATTERNS (CONTINUOUS MODE)");
            
            // Resume data transmission
            @(posedge fclk_p);
            adc_data_valid = 1'b1;
            
            // Initialize test patterns array with test values
            test_patterns = new[4];
            test_patterns[0] = 24'hFFF000;  // First alignment pattern
            test_patterns[1] = 24'hFF0000;  // Second alignment pattern
            test_patterns[2] = 24'h123456;  // Random data pattern 1
            test_patterns[3] = 24'hABCDEF;  // Random data pattern 2
            
            // Queue up expected data for verification (all patterns multiple times)
            // Queue each pattern twice to ensure we can detect repeated patterns
            repeat(3) begin  // Queue patterns 3 times for verification
                foreach (test_patterns[i]) begin
                    queue_expected_data(test_patterns[i]);
                end
            end
            
            // Start verification process in the background
            fork
                // Process 1: Send continuous data stream (repeat patterns 5 times)
                continuous_data_stream(test_patterns, 5, 5);  // 5 cycles delay, 5 repetitions
                
                // Process 2: Verify data in parallel with a timeout
                start_data_verification(0, 50000);  // No max values, 50,000ns timeout
            join_any  // Only wait for one process to complete
              // Allow the verification to continue a bit longer to check for changes
            repeat(50) @(posedge dclk_sim);
            $display("[%0t ns] Data valid toggling test completed", $time);
        end
    endtask
    
    // Read and apply data from a specified data file with continuous processing
    task read_and_apply_roic_data_file(input string file_path = "");
        integer file, r, data_count, max_samples;
        logic [WORD_SIZE-1:0] file_data;
        logic [WORD_SIZE-1:0] data_array[];
        string path_to_use;
        begin
            // Determine which path to use
            if (file_path == "") begin
                path_to_use = roic_data_file_path; // Use global path setting
                $display("[%0t ns] Using default ROIC data file path: %s", $time, path_to_use);
            end else begin
                path_to_use = file_path; // Use explicitly provided path
                $display("[%0t ns] Using provided ROIC data file path: %s", $time, path_to_use);
            end
            
            // Open the specified file for reading
            file = $fopen(path_to_use, "r");
            if (file == 0) begin
                $display("Error: Could not open file: %s", path_to_use);
                test_fail_count++;
                $finish;
            end
            
            $display("[%0t ns] Successfully opened file: %s", $time, path_to_use);
            
            // First pass: Count number of valid data lines in file
            data_count = 0;
            
            while (!$feof(file)) begin
                r = $fscanf(file, "%h\n", file_data);
                if (r == 1) data_count++;
            end
            
            // Reset file pointer to beginning
            $rewind(file);
            
            $display("[%0t ns] Found %0d data values in file", $time, data_count);
            
            // Limit number of samples if file is too large
            max_samples = (data_count > 1000) ? 1000 : data_count;
            
            // Allocate array for continuous data streaming
            data_array = new[max_samples];
            
            // Second pass: Load data into array
            data_count = 0;
            display_test_section("TESTING CONTINUOUS DATA STREAM FROM FILE");
            
            while (!$feof(file) && data_count < max_samples) begin
                r = $fscanf(file, "%h\n", file_data);
                if (r == 1) begin
                    data_array[data_count] = file_data;
                    // Queue for verification
                    queue_expected_data(file_data);
                    data_count++;
                end
            end
            
            $display("[%0t ns] Loaded %0d data values from file into continuous stream buffer", 
                    $time, data_count);
            
            // Close file after reading all data
            $fclose(file);
              // Start continuous data streaming and verification in parallel
            fork
                // Process 1: Send continuous data stream
                begin
                    @(posedge fclk_p);
                    adc_data_valid = 1'b0;      // Disable data transmission initially
                    $display("[%0t ns] Starting data transmission from AFE2256 emulator", $time);
                    @(posedge fclk_p);
                    adc_data_valid = 1'b1;
                    continuous_data_stream(data_array, 2, 2);  // Small delay for stability, repeat twice
                end
                
                // Process 2: Verify data in parallel with timeout
                start_data_verification(0, 100000);  // No max values, 100,000ns timeout
            join_any  // Only wait for one process to complete
            
            // Allow verification to continue a bit longer
            repeat(50) @(posedge clk_div_12);
            
            // Test reordered data functionality
            display_test_section("TESTING INDATA_REORDER FUNCTIONALITY");
            
            // Wait for some data to be processed
            repeat(20) @(posedge clk_div_12);
            
            // Look for valid reordered data
            for (int i = 0; i < 20; i++) begin
                @(posedge clk_div_12);
                if (reordered_valid) begin
                    $display("[%0t ns] REORDERED DATA: 0x%h (valid=%b)", 
                             $time, reordered_data, reordered_valid);
                end
            end
            
            $display("[%0t ns] Deactivating data read request signal", $time);
            
            $display("[%0t ns] Finished processing continuous data stream from file: %s", 
                     $time, path_to_use);
        end
    endtask
    
    //--------------------------------------------------------------------------
    // Unified Signal Monitor
    //--------------------------------------------------------------------------
    // Comprehensive signal monitoring system for debugging and validation
    logic [WORD_SIZE-1:0] last_monitored_data = 'x;
    int data_unchanged_count = 0;
    
    // Advanced monitor to track potential stuck data issues
    always @(posedge clk_div_12) begin
        // Check for data changes and detect potential stuck conditions
        if (reordered_valid) begin
            if (reordered_data !== last_monitored_data) begin
                // Data changed, reset counter and log the change
                data_unchanged_count = 0;
                if (last_monitored_data !== 'x) begin  // Skip first change from x
                    $display("[%0t ns] DATA CHANGED: 0x%h -> 0x%h", 
                            $time, last_monitored_data, reordered_data);
                end
                last_monitored_data = reordered_data;
            end else begin
                // Data unchanged, increment counter
                data_unchanged_count++;
                // Only log stuck condition periodically to avoid flooding logs
                if (data_unchanged_count == 50) begin  // After ~50 cycles of no change
                    $display("[%0t ns] WARNING: Data stuck at 0x%h for 50 cycles", 
                            $time, reordered_data);
                end
            end
        end        // Only display crucial signal changes to reduce output clutter
        if (align_done) begin
            // Log comprehensive signal state when alignment is complete
            $display("[%0t ns] SIGNAL MONITOR: align_done=%b, shift=%0d, data=0x%h, valid=%b", 
                    $time, align_done, shift_out, reordered_data, reordered_valid);
        end
    end
    
    // Monitor alignment status changes separately (important events)
    always @(align_done) begin
        $display("[%0t ns] STATUS CHANGE: Alignment %s", 
                 $time, align_done ? "COMPLETED" : "IN PROGRESS");
    end
      // Monitor reordered data valid transitions (important events)
    always @(reordered_valid) begin
        $display("[%0t ns] DATA VALID STATUS: %s", 
                 $time, reordered_valid ? "VALID" : "NOT VALID");
    end
    
    // Monitor frame clock for debugging
    int fclk_monitor_count = 0;
    always @(posedge fclk_p) begin
        fclk_monitor_count++;
        if (fclk_monitor_count % 10 == 0) begin  // Only log every 10th FCLK
            $display("[%0t ns] FCLK MONITOR: %0d frame clocks occurred", $time, fclk_monitor_count);
        end
    end
    
    // Note: The duplicate test case initial block was removed to prevent double $finish calls

    //--------------------------------------------------------------------------
    // Data Read Request Control
    //--------------------------------------------------------------------------
    // Control data_read_req based on reset and first channel detection
    always @(posedge clk_div_12 or posedge deser_reset) begin
        if (deser_reset) begin
            // Reset data_read_req during data reset
            data_read_req <= 1'b0;
            channel_detected_dly <= '0; // Reset delayed channel detection flag
        end else if (channel_detected_dly[7]) begin
            // Set data_read_req when first sample pulse is active
            data_read_req <= 1'b1;
        end
        channel_detected_dly[7:1] <= channel_detected_dly[6:0]; // Shift left
        channel_detected_dly[0] <= channel_detected; // Capture current state

    end

    //--------------------------------------------------------------------------
    // Generate VCD file for waveform analysis
    //--------------------------------------------------------------------------
    initial begin
        $dumpfile("tb_data_in_top.vcd"); // Create VCD file for waveform viewing
        $dumpvars(0, tb_data_in_top);    // Dump all variables in this module
    end

endmodule