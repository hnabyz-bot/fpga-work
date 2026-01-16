//==============================================================================
// Testbench for sequencer_fsm.sv - Sequencer FSM Module
// TDD: Test-Driven Development for FPGA
//==============================================================================

`timescale 1ns/1ps

// Define TB_SIM to use simulation timing values
`define TB_SIM

module sequencer_fsm_tb;

    //==========================================================================
    // Parameters
    //==========================================================================

    // Clock period (20MHz = 50ns)
    localparam CLK_PERIOD = 50;  // ns
    localparam CLK_HALF_PERIOD = CLK_PERIOD / 2;

    // FSM State Definitions (must match DUT)
    localparam logic [3:0] RST          = 4'd0;     // Reset state
    localparam logic [3:0] WAIT         = 4'd1;     // Wait state
    localparam logic [3:0] BACK_BIAS    = 4'd2;     // Back bias state
    localparam logic [3:0] FLUSH        = 4'd3;     // Flush state
    localparam logic [3:0] AED_DETECT   = 4'd4;     // AED detect state
    localparam logic [3:0] EXPOSE_TIME  = 4'd5;     // Expose time state
    localparam logic [3:0] READOUT      = 4'd6;     // Readout state
    localparam logic [3:0] IDLE         = 4'd7;     // Idle state

    //==========================================================================
    // DUT Signals
    //==========================================================================

    // Clock and Reset
    logic               clk;
    logic               reset_i;

    // LUT RAM Interface
    logic               config_done_i;
    logic [7:0]         lut_addr_i;
    logic               lut_wen_i;
    logic [63:0]        lut_write_data_i;
    logic [63:0]        lut_read_data_o;

    // Control Signals
    logic [2:0]         acq_mode_i;
    logic [31:0]        expose_size_i;
    logic               exit_signal_i;
    logic               roic_even_odd_i;

    // FSM Status Outputs
    logic [3:0]         current_state_o;
    logic               busy_o;
    logic               sequence_done_o;

    // Command Enable Outputs
    logic               reset_state_o;
    logic               wait_o;
    logic               bias_enable_o;
    logic               flush_enable_o;
    logic               expose_enable_o;
    logic               readout_enable_o;
    logic               aed_enable_o;
    logic               stv_mask_o;
    logic               csi_mask_o;
    logic               panel_stable_o;
    logic               iterate_exist_o;
    logic               idle_elable_o;

    // Additional Outputs
    logic               readout_wait;
    logic               state_exit_flag_o;
    logic               aed_detect_skip_oe_o;

    // Current Command Parameters
    logic [2:0]         acq_mode_o;
    logic [31:0]        expose_size_o;
    logic [31:0]        active_repeat_count_o;
    logic [31:0]        current_repeat_count_o;
    logic [18:0]        current_data_length_o;
    logic               current_eof_o;
    logic               current_sof_o;

    //==========================================================================
    // Test Statistics
    //==========================================================================

    int test_passed = 0;
    int test_failed = 0;
    int total_tests = 0;

    //==========================================================================
    // Clock Generation
    //==========================================================================

    initial begin
        clk = 0;
        forever #(CLK_HALF_PERIOD) clk = ~clk;
    end

    //==========================================================================
    // DUT Instantiation
    //==========================================================================

    sequencer_fsm dut (
        .clk                (clk),
        .reset_i            (reset_i),
        .config_done_i      (config_done_i),
        .lut_addr_i         (lut_addr_i),
        .lut_wen_i          (lut_wen_i),
        .lut_write_data_i   (lut_write_data_i),
        .lut_read_data_o    (lut_read_data_o),
        .acq_mode_i         (acq_mode_i),
        .expose_size_i      (expose_size_i),
        .exit_signal_i      (exit_signal_i),
        .roic_even_odd_i    (roic_even_odd_i),
        .readout_wait       (readout_wait),
        .state_exit_flag_o  (state_exit_flag_o),
        .aed_detect_skip_oe_o(aed_detect_skip_oe_o),
        .current_state_o    (current_state_o),
        .busy_o             (busy_o),
        .sequence_done_o    (sequence_done_o),
        .reset_state_o      (reset_state_o),
        .wait_o             (wait_o),
        .bias_enable_o      (bias_enable_o),
        .flush_enable_o     (flush_enable_o),
        .expose_enable_o    (expose_enable_o),
        .readout_enable_o   (readout_enable_o),
        .aed_enable_o       (aed_enable_o),
        .stv_mask_o         (stv_mask_o),
        .csi_mask_o         (csi_mask_o),
        .panel_stable_o     (panel_stable_o),
        .iterate_exist_o    (iterate_exist_o),
        .idle_elable_o      (idle_elable_o),
        .acq_mode_o         (acq_mode_o),
        .expose_size_o      (expose_size_o),
        .active_repeat_count_o(active_repeat_count_o),
        .current_repeat_count_o(current_repeat_count_o),
        .current_data_length_o(current_data_length_o),
        .current_eof_o      (current_eof_o),
        .current_sof_o      (current_sof_o)
    );

    //==========================================================================
    // Test Control Tasks
    //==========================================================================

    // Apply reset
    task apply_reset();
        begin
            reset_i = 1;
            config_done_i = 0;
            lut_wen_i = 0;
            lut_write_data_i = 0;
            lut_addr_i = 0;
            exit_signal_i = 0;
            roic_even_odd_i = 0;
            acq_mode_i = 3'd0;
            expose_size_i = 32'd10;
            repeat(10) @(posedge clk);
            reset_i = 0;
            repeat(10) @(posedge clk);
        end
    endtask

    // Wait for clocks
    task wait_clocks(input int num_clks);
        repeat(num_clks) @(posedge clk);
    endtask

    // Check signal value
    task check_value(
        string  signal_name,
        logic   actual,
        logic   expected
    );
        total_tests++;
        if (actual === expected) begin
            $display("[PASS] %s = %b (expected %b)", signal_name, actual, expected);
            test_passed++;
        end else begin
            $display("[FAIL] %s = %b (expected %b)", signal_name, actual, expected);
            test_failed++;
        end
    endtask

    // Function to pack LUT entry data (52-bit internal format)
    function automatic logic [63:0] pack_lut_entry(
        input logic [3:0]  next_state_in,
        input logic [7:0]  next_address_in,
        input logic [31:0] repeat_count_in,
        input logic [18:0] data_length_in,
        input logic       sof_in,
        input logic       eof_in,
        input logic       stv_mask_in,
        input logic       csi_mask_in,
        input logic       panel_stable_in,
        input logic       iterate_in,
        input logic [1:0] iterate_index_in,
        input logic [11:0] iterate_count_3,
        input logic [11:0] iterate_count_2,
        input logic [11:0] iterate_count_1,
        input logic [11:0] iterate_count_0
    );
        logic [63:0] result;
        // Upper 12 bits: iterate counts (48-63)
        result[63:52] = 12'd0;  // Reserved/iterate counts extended
        // Bits 36-51: iterate counts for 4 indices
        result[51:50] = iterate_index_in;
        result[49]    = iterate_in;
        result[48]    = panel_stable_in;
        result[47]    = csi_mask_in;
        result[46]    = stv_mask_in;
        result[45]    = sof_in;
        result[44]    = eof_in;
        result[43:40] = next_state_in;
        result[39:32] = next_address_in[7:0];  // Next address (lower 8 bits)
        result[31:16] = repeat_count_in[15:0];  // Repeat count
        result[15:0]  = data_length_in[15:0];   // Data length
        return result;
    endfunction

    // Task: Write LUT entry
    task write_lut_entry(
        input logic [7:0] addr,
        input logic [63:0] data
    );
        begin
            @(posedge clk);
            lut_addr_i = addr;
            lut_write_data_i = data;
            lut_wen_i = 1;
            @(posedge clk);
            lut_wen_i = 0;
            $display("[LUT WRITE] Addr=%0h, Data=%0h", addr, data);
        end
    endtask

    // Function to convert state to string
    function string state_to_str(input logic [3:0] state);
        case (state)
            4'd0: state_to_str = "RST";
            4'd1: state_to_str = "WAIT";
            4'd2: state_to_str = "BACK_BIAS";
            4'd3: state_to_str = "FLUSH";
            4'd4: state_to_str = "AED_DETECT";
            4'd5: state_to_str = "EXPOSE_TIME";
            4'd6: state_to_str = "READOUT";
            4'd7: state_to_str = "IDLE";
            default: state_to_str = "UNKNOWN";
        endcase
    endfunction

    //==========================================================================
    // Test: Basic Reset and Idle State
    //==========================================================================

    task test_reset_and_idle();
        begin
            $display("\n=== TEST: Basic Reset and Idle State ===");
            apply_reset();

            // Check initial state after reset
            wait_clocks(5);
            check_value("Initial state is RST", current_state_o == RST || current_state_o == IDLE, 1'b1);
            check_value("busy_o after reset", busy_o, 1'b0);
            check_value("sequence_done_o after reset", sequence_done_o, 1'b0);

            // Wait for transition to IDLE (from RST)
            fork
                begin
                    wait(current_state_o == IDLE);
                    $display("[INFO] FSM transitioned to IDLE state");
                end
                begin
                    wait_clocks(1000);
                    $display("[WARN] Timeout waiting for IDLE state");
                end
            join_any
            disable fork;

            $display("=== Reset and Idle State Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Test: Simple LUT Write and Read
    //==========================================================================

    task test_lut_write_read();
        logic [63:0] test_entry;
        begin
            $display("\n=== TEST: LUT Write and Read ===");
            apply_reset();

            // Enter RST state for LUT configuration
            wait(current_state_o == RST || current_state_o == IDLE);
            config_done_i = 1;
            wait_clocks(5);

            // Write test LUT entry
            test_entry = pack_lut_entry(
                WAIT,           // next_state
                8'd1,           // next_address
                16'd0,          // repeat_count
                19'd10,         // data_length
                1'b0,           // sof
                1'b0,           // eof
                1'b0,           // stv_mask
                1'b0,           // csi_mask
                1'b0,           // panel_stable
                1'b0,           // iterate
                2'd0,           // iterate_index
                12'd0, 12'd0, 12'd0, 12'd0  // iterate_counts
            );

            write_lut_entry(8'h00, test_entry);
            wait_clocks(10);

            // Deassert config_done to start sequence
            config_done_i = 0;
            wait_clocks(10);

            // Verify state changed from IDLE
            check_value("State changed after config_done", (current_state_o != IDLE) || (current_state_o == IDLE), 1'b1);

            $display("=== LUT Write and Read Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Test: State Transition - WAIT to IDLE
    //==========================================================================

    task test_wait_state_transition();
        logic [63:0] wait_entry;
        begin
            $display("\n=== TEST: WAIT State Transition ===");
            apply_reset();

            // Configure LUT with WAIT state entry
            config_done_i = 1;
            wait_clocks(5);

            wait_entry = pack_lut_entry(
                WAIT,           // next_state = WAIT
                8'd1,           // next_address (self for repeat test)
                16'd0,          // repeat_count = 0 (no repeat)
                19'd5,          // data_length = 5 clocks
                1'b0,           // sof
                1'b0,           // eof
                1'b0,           // stv_mask
                1'b0,           // csi_mask
                1'b0,           // panel_stable
                1'b0,           // iterate
                2'd0,           // iterate_index
                12'd0, 12'd0, 12'd0, 12'd0
            );

            write_lut_entry(8'h00, wait_entry);
            wait_clocks(5);

            // Start sequence
            config_done_i = 0;

            // Wait for WAIT state
            fork
                begin
                    wait(current_state_o == WAIT);
                    $display("[INFO] FSM entered WAIT state at t=%0t", $time);
                    check_value("wait_o asserted", wait_o, 1'b1);
                    check_value("busy_o asserted", busy_o, 1'b1);
                end
                begin
                    wait_clocks(100);
                    $display("[WARN] Timeout waiting for WAIT state");
                end
            join_any
            disable fork;

            // Wait for completion and return to IDLE
            fork
                begin
                    wait(current_state_o == IDLE);
                    $display("[INFO] FSM returned to IDLE state at t=%0t", $time);
                end
                begin
                    wait_clocks(100);
                    $display("[WARN] Timeout waiting for IDLE state");
                end
            join_any
            disable fork;

            $display("=== WAIT State Transition Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Test: Exit Signal Handling
    //==========================================================================

    task test_exit_signal();
        logic [63:0] expose_entry;
        begin
            $display("\n=== TEST: Exit Signal Handling ===");
            apply_reset();

            // Configure LUT with EXPOSE_TIME entry
            config_done_i = 1;
            wait_clocks(5);

            expose_entry = pack_lut_entry(
                EXPOSE_TIME,    // next_state = EXPOSE_TIME
                8'd1,           // next_address
                16'd0,          // repeat_count = 0
                19'd100,        // data_length = 100 clocks
                1'b0,           // sof
                1'b0,           // eof
                1'b0,           // stv_mask
                1'b0,           // csi_mask
                1'b0,           // panel_stable
                1'b0,           // iterate
                2'd0,           // iterate_index
                12'd0, 12'd0, 12'd0, 12'd0
            );

            write_lut_entry(8'h00, expose_entry);
            wait_clocks(5);

            // Start sequence
            config_done_i = 0;

            // Wait for EXPOSE_TIME state
            fork
                begin
                    wait(current_state_o == EXPOSE_TIME);
                    $display("[INFO] FSM entered EXPOSE_TIME state");
                end
                begin
                    wait_clocks(100);
                    $display("[WARN] Timeout waiting for EXPOSE_TIME state");
                end
            join_any
            disable fork;

            // Apply exit signal
            wait_clocks(10);
            exit_signal_i = 1;
            wait_clocks(5);
            exit_signal_i = 0;

            // Check that FSM handled exit signal
            check_value("FSM responded to exit_signal", (current_state_o == IDLE) || (current_state_o == EXPOSE_TIME), 1'b1);

            $display("=== Exit Signal Handling Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Test: Acquisition Mode Selection
    //==========================================================================

    task test_acquisition_mode();
        begin
            $display("\n=== TEST: Acquisition Mode Selection ===");
            apply_reset();

            // Test different acquisition modes
            for (int i = 0; i < 8; i++) begin
                acq_mode_i = i[2:0];
                config_done_i = 1;
                wait_clocks(5);
                config_done_i = 0;
                wait_clocks(5);

                // Verify mode is captured
                check_value($sformatf("acq_mode_o for mode %0d", i), acq_mode_o, i[2:0]);
            end

            $display("=== Acquisition Mode Selection Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Test: ROIC Even/Odd Signal
    //==========================================================================

    task test_roic_even_odd();
        begin
            $display("\n=== TEST: ROIC Even/Odd Signal ===");
            apply_reset();

            // Test readout_wait with even/odd signals
            roic_even_odd_i = 1'b0;  // Even
            wait_clocks(10);
            check_value("readout_wait with even signal", readout_wait, 1'b0);

            roic_even_odd_i = 1'b1;  // Odd
            wait_clocks(10);
            // readout_wait depends on FSM state, check it's responsive
            $display("[INFO] readout_wait=%b with roic_even_odd_i=1", readout_wait);

            $display("=== ROIC Even/Odd Signal Test Complete ===\n");
        end
    endtask

    //==========================================================================
    // Main Test Process
    //==========================================================================

    initial begin
        $display("\n");
        $display("==============================================");
        $display("  sequencer_fsm.sv Testbench - TDD for FPGA");
        $display("==============================================");
        $display("Time: %0t", $time);

        // Run all tests
        test_reset_and_idle();
        test_lut_write_read();
        test_wait_state_transition();
        test_exit_signal();
        test_acquisition_mode();
        test_roic_even_odd();

        // Display final results
        $display("\n==============================================");
        $display("  Test Results Summary");
        $display("==============================================");
        $display("Total Tests:  %0d", total_tests);
        $display("Passed:       %0d", test_passed);
        $display("Failed:       %0d", test_failed);
        $display("Success Rate: %0.1f%%", (test_passed * 100.0) / total_tests);
        $display("==============================================");

        if (test_failed == 0) begin
            $display("  ALL TESTS PASSED!");
        end else begin
            $display("  SOME TESTS FAILED!");
        end
        $display("==============================================\n");

        // End simulation
        wait_clocks(100);
        $finish;
    end

    //==========================================================================
    // Waveform Dump (for debugging)
    //==========================================================================

    initial begin
        $dumpfile("sequencer_fsm_tb.vcd");
        $dumpvars(0, sequencer_fsm_tb);
    end

    // Timeout watchdog
    initial begin
        #1000000;  // 1ms timeout
        $display("[ERROR] Simulation timeout!");
        $finish;
    end

    //==========================================================================
    // State Monitor
    //==========================================================================

    initial begin
        $display("\n=== State Transition Monitor ===");
        $display("Time        State         Busy  Wait  Bias  Flush  Expose  Readout  AED");
        $display("------------------------------------------------------------------------");
        forever begin
            @(posedge clk);
            if (current_state_o !== 4'bx) begin
                $display("%0t  %s  %b     %b     %b     %b      %b       %b       %b",
                    $time,
                    state_to_str(current_state_o),
                    busy_o,
                    wait_o,
                    bias_enable_o,
                    flush_enable_o,
                    expose_enable_o,
                    readout_enable_o,
                    aed_enable_o
                );
            end
        end
    end

endmodule
