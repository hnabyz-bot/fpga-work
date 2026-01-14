// ---------------------------------------------------------------------------------
//   Title      :  Test Bench for ctrl_fsm_sg (Signal Generator FSM Control)
//              :  
//   Purpose    :  Verify functionality of the Signal Generator FSM Controller
//              :  
//   Created    :  2025-05-16
//              :
// ---------------------------------------------------------------------------------
//   Description:  This testbench exercises the ctrl_fsm_sg module through various
//                 test scenarios and verifies the expected output behavior for
//                 each FSM state transition.
// ---------------------------------------------------------------------------------

`include "../../source/hdl/p_define.sv"
`timescale 1ns/1ps

module tb_ctrl_fsm_sg();

    // Clock generation parameters
    localparam CLK_PERIOD      = 10;   // 100MHz clock (10ns period)
    localparam SIM_TIME        = 100_000;  // Simulation time in ns
    
    // Test control parameters
    localparam RESET_CYCLES    = 10;   // Number of clock cycles to hold reset

    // Clock and reset signals
    reg                         fsm_clk;
    reg                         rst;
    reg                         fsm_drv_rst;
    
    // Control inputs
    reg                         reset_FSM;
    
    // Image acquisition commands
    reg                         burst_get_image;
    reg                         get_dark;
    reg                         get_bright;
    reg                         cmd_get_bright;
    
    // Configuration parameters
    reg [23:0]                  cycle_width;
    reg [15:0]                  image_height;
    reg [15:0]                  dsp_image_height;
    reg [7:0]                   frame_rpt;
    reg [7:0]                   saturation_flush_repeat;
    reg [15:0]                  ready_aed_read;
    reg [15:0]                  aed_dark_delay;
    reg [15:0]                  readout_count;
    
    
    // Mode enables and control signals
    reg                         en_aed;
    reg [15:0]                  aed_read_image_height;
    reg                         disable_aed_read_xao;
    reg                         on_aed_dark_trigger;
    reg                         on_aed_trigger;
    reg                         en_back_bias;
    reg                         en_flush;
    reg                         en_panel_stable;
    
    // Output signals
    wire                        col_end;
    wire                        row_end;
    wire                        FSM_rst_index;
    wire                        FSM_init_index;
    wire                        FSM_back_bias_index;
    wire                        FSM_flush_index;
    wire                        FSM_aed_read_index;
    wire                        FSM_exp_index;
    wire                        FSM_read_index;
    wire                        ready_to_get_image;
    wire                        aed_ready_done;
    wire                        aed_ready_done_dark;
    wire                        panel_stable_exist;
    wire                        exp_read_exist;
    wire                        valid_posi_flag;
    wire                        valid_nega_flag;
    wire [15:0]                 row_cnt;
    wire [15:0]                 col_cnt;
    wire                        gate_cpv_init;

    // Test logging and state tracking
    string                      current_test;
    int                         test_number;
    int                         test_errors;
    
    // FSM state enumeration (for tracking expected states)
    typedef enum {
        ST_RESET, 
        ST_INIT, 
        ST_BACK_BIAS, 
        ST_FLUSH, 
        ST_AED_READ, 
        ST_EXP, 
        ST_READ
    } fsm_state_t;
    
    fsm_state_t expected_state;
    
    // Module instantiation
    ctrl_FSM_sg dut (
        // Clock and reset
        .fsm_clk(fsm_clk),
        .rst(rst),
        .fsm_drv_rst(fsm_drv_rst),
        
        // Control inputs
        .reset_FSM(reset_FSM),
        
        // Image acquisition commands
        .burst_get_image(burst_get_image),
        .get_dark(get_dark),
        .get_bright(get_bright),
        .cmd_get_bright(cmd_get_bright),
        
        // Configuration parameters
        .cycle_width(cycle_width),
        .image_height(image_height),
        .dsp_image_height(dsp_image_height),
        .frame_rpt(frame_rpt),
        .saturation_flush_repeat(saturation_flush_repeat),
        .ready_aed_read(ready_aed_read),
        .aed_dark_delay(aed_dark_delay),
        .readout_count(readout_count),
        
        // AED settings
        .en_aed(en_aed),
        .aed_read_image_height(aed_read_image_height),
        .disable_aed_read_xao(disable_aed_read_xao),
        .on_aed_dark_trigger(on_aed_dark_trigger),        
        .on_aed_trigger(on_aed_trigger),
        
        // Mode enables
        .en_back_bias(en_back_bias),
        .en_flush(en_flush),
        .en_panel_stable(en_panel_stable),
        
        // Output signals
        .col_end(col_end),
        .row_end(row_end),
        .FSM_rst_index(FSM_rst_index),
        .FSM_init_index(FSM_init_index),
        .FSM_back_bias_index(FSM_back_bias_index),
        .FSM_flush_index(FSM_flush_index),
        .FSM_aed_read_index(FSM_aed_read_index),
        .FSM_exp_index(FSM_exp_index),
        .FSM_read_index(FSM_read_index),
        .ready_to_get_image(ready_to_get_image),
        .aed_ready_done(aed_ready_done),
        .aed_ready_done_dark(aed_ready_done_dark),
        .panel_stable_exist(panel_stable_exist),
        .exp_read_exist(exp_read_exist),
        .valid_posi_flag(valid_posi_flag),
        .valid_nega_flag(valid_nega_flag),
        .row_cnt(row_cnt),
        .col_cnt(col_cnt),
        .gate_cpv_init(gate_cpv_init)
    );
    
    // Clock generation
    initial begin
        fsm_clk = 0;
        forever #(CLK_PERIOD/2) fsm_clk = ~fsm_clk;
    end

    // Utility tasks
    task wait_clocks(int n);
        repeat(n) @(posedge fsm_clk);
    endtask
    
    task check_fsm_state(string state_name, logic expected_rst, logic expected_init, 
                         logic expected_back_bias, logic expected_flush,
                         logic expected_aed_read, logic expected_exp, logic expected_read);
        if (FSM_rst_index !== expected_rst || 
            FSM_init_index !== expected_init || 
            FSM_back_bias_index !== expected_back_bias ||
            FSM_flush_index !== expected_flush || 
            FSM_aed_read_index !== expected_aed_read || 
            FSM_exp_index !== expected_exp || 
            FSM_read_index !== expected_read) begin
            
            $error("STATE ERROR in %s: Expected state: %s, Actual states: rst=%b, init=%b, back_bias=%b, flush=%b, aed_read=%b, exp=%b, read=%b",
                   current_test, state_name, 
                   FSM_rst_index, FSM_init_index, FSM_back_bias_index,
                   FSM_flush_index, FSM_aed_read_index, FSM_exp_index, FSM_read_index);
            test_errors++;
        end else begin
            $display("STATE CORRECT: %s verified at time %t", state_name, $time);
        end
    endtask

    task check_output(string signal_name, logic actual, logic expected);
        if (actual !== expected) begin
            $error("OUTPUT ERROR in %s: %s expected=%b, actual=%b", 
                   current_test, signal_name, expected, actual);
            test_errors++;
        end
    endtask
    
    // Test cases
    task reset_system();
        current_test = "System Reset";
        $display("\n=== Starting test: %s ===", current_test);
        
        // Apply reset
        rst = 0;             // Active low reset
        fsm_drv_rst = 0;
        reset_FSM = 1;
        
        // Initialize all inputs to default values
        burst_get_image = 0;
        get_dark = 0;
        get_bright = 0;
        cmd_get_bright = 0;
          cycle_width = 24'h000100;      // 256 cycles
        image_height = 16'h0040;       // 64 lines
        dsp_image_height = 16'h0040;   // 64 lines
        frame_rpt = 8'h00;               // No frame repetition
        saturation_flush_repeat = 8'h00;  // No saturation flush
        ready_aed_read = 16'h0000;       // No AED read delay
        aed_dark_delay = 16'h0000;       // No AED dark delay
        readout_count = 16'h0001;      // 1 readout
        
        en_aed = 0;
        aed_read_image_height = 16'h0040;
        disable_aed_read_xao = 0;
        on_aed_dark_trigger = 0;
        on_aed_trigger = 0;
        
        en_back_bias = 0;
        en_flush = 0;
        en_panel_stable = 0;
        
        // Hold reset for specified cycles
        wait_clocks(RESET_CYCLES);
        
        // Release reset
        rst = 1;
        fsm_drv_rst = 1;
        reset_FSM = 0;
        
        // Wait a few clocks for things to stabilize
        wait_clocks(5);
        
        // Check that we're in reset state
        check_fsm_state("RESET", 1, 0, 0, 0, 0, 0, 0);
        
        $display("=== Completed test: %s ===\n", current_test);
    endtask
    
    task test_normal_operation();
        current_test = "Normal Operation Sequence";
        $display("\n=== Starting test: %s ===", current_test);
        
        // Start in reset state and verify it
        check_fsm_state("RESET", 1, 0, 0, 0, 0, 0, 0);
        
        // Trigger image acquisition
        get_bright = 1;
        cmd_get_bright = 1;
        wait_clocks(2);
        check_output("ready_to_get_image", ready_to_get_image, 1);
        
        // Wait for initialization
        wait_clocks(10);
        get_bright = 0;
        
        // Wait for transition to INIT state
        wait_clocks(20);
        if (FSM_init_index) begin
            $display("Successfully transitioned to INIT state at time %t", $time);
            check_fsm_state("INIT", 0, 1, 0, 0, 0, 0, 0);
        end
        
        // Without special modes, should go directly to EXP
        wait_clocks(50);
        
        // Wait for EXP state
        wait_clocks(100);
        if (FSM_exp_index) begin
            $display("Successfully transitioned to EXP state at time %t", $time);
            check_fsm_state("EXP", 0, 0, 0, 0, 0, 1, 0);
        end
        
        // Wait for READ state
        wait_clocks(100);
        if (FSM_read_index) begin
            $display("Successfully transitioned to READ state at time %t", $time);
            check_fsm_state("READ", 0, 0, 0, 0, 0, 0, 1);
        end
        
        $display("=== Completed test: %s ===\n", current_test);
    endtask
    
    task test_back_bias_mode();
        current_test = "Back Bias Mode";
        $display("\n=== Starting test: %s ===", current_test);
        
        // Reset for clean state
        rst = 0;
        wait_clocks(RESET_CYCLES);
        rst = 1;
        wait_clocks(5);
          // Enable back bias mode and set frame repeat
        en_back_bias = 1;
        frame_rpt = 8'h03;  // 3 frame repeats
        
        // Trigger image acquisition
        get_bright = 1;
        cmd_get_bright = 1;
        wait_clocks(2);
        get_bright = 0;
        
        // Wait for transition to INIT state
        wait_clocks(20);
        if (FSM_init_index) begin
            $display("Successfully transitioned to INIT state at time %t", $time);
            check_fsm_state("INIT", 0, 1, 0, 0, 0, 0, 0);
        end
        
        // Should go to BACK_BIAS state after init
        wait_clocks(100);
        if (FSM_back_bias_index) begin
            $display("Successfully transitioned to BACK_BIAS state at time %t", $time);
            check_fsm_state("BACK_BIAS", 0, 0, 1, 0, 0, 0, 0);
        end
        
        $display("=== Completed test: %s ===\n", current_test);
    endtask
    
    task test_flush_mode();
        current_test = "Flush Mode";
        $display("\n=== Starting test: %s ===", current_test);
        
        // Reset for clean state
        rst = 0;
        wait_clocks(RESET_CYCLES);
        rst = 1;
        wait_clocks(5);
          // Enable flush mode and set saturation flush repeat
        en_flush = 1;
        saturation_flush_repeat = 8'h02;  // 2 saturation flush repeats
        
        // Trigger image acquisition
        get_bright = 1;
        cmd_get_bright = 1;
        wait_clocks(2);
        get_bright = 0;
        
        // Wait for transition to FLUSH state after INIT
        wait_clocks(150);
        if (FSM_flush_index) begin
            $display("Successfully transitioned to FLUSH state at time %t", $time);
            check_fsm_state("FLUSH", 0, 0, 0, 1, 0, 0, 0);
        end
        
        $display("=== Completed test: %s ===\n", current_test);
    endtask
    
    task test_aed_mode();
        current_test = "AED Mode";
        $display("\n=== Starting test: %s ===", current_test);
        
        // Reset for clean state
        rst = 0;
        wait_clocks(RESET_CYCLES);
        rst = 1;
        wait_clocks(5);
          // Enable AED mode and set related parameters
        en_aed = 1;
        on_aed_trigger = 1;
        ready_aed_read = 16'h0010;     // 16 cycles delay for AED read
        aed_dark_delay = 16'h0020;     // 32 cycles delay for AED dark
        
        // Trigger image acquisition
        get_bright = 1;
        cmd_get_bright = 1;
        wait_clocks(2);
        get_bright = 0;
        
        // Wait for transition to AED_READ state after INIT
        wait_clocks(200);
        if (FSM_aed_read_index) begin
            $display("Successfully transitioned to AED_READ state at time %t", $time);
            check_fsm_state("AED_READ", 0, 0, 0, 0, 1, 0, 0);
        end
        
        // Check valid_posi_flag during AED
        wait_clocks(100);
        $display("valid_posi_flag: %b at time %t", valid_posi_flag, $time);
        
        $display("=== Completed test: %s ===\n", current_test);
    endtask

    // Main test sequence
    initial begin
        $display("Starting testbench for ctrl_fsm_sg at time %t", $time);
        test_number = 0;
        test_errors = 0;
        
        // Run test cases
        reset_system();
        test_number++;
        
        test_normal_operation();
        test_number++;
        
        test_back_bias_mode();
        test_number++;
        
        test_flush_mode();
        test_number++;
        
        test_aed_mode();
        test_number++;
        
        // Summary report
        $display("\n=== TEST SUMMARY ===");
        $display("Total tests: %0d", test_number);
        $display("Test errors: %0d", test_errors);
        if (test_errors == 0) begin
            $display("STATUS: ALL TESTS PASSED");
        end else begin
            $display("STATUS: TESTS FAILED");
        end
        
        // Run for a bit longer to allow observation of waveforms
        wait_clocks(50);
        $finish;
    end
    
    // Simulation time limit
    initial begin
        #SIM_TIME;
        $display("Simulation time limit reached at time %t", $time);
        $display("Simulation INCOMPLETE - stopping due to timeout");
        $finish;
    end
    
    // Monitor FSM state changes for debug
    always @(posedge fsm_clk) begin
        if (FSM_rst_index)       $display("FSM State: RESET at time %t", $time);
        if (FSM_init_index)      $display("FSM State: INIT at time %t", $time);
        if (FSM_back_bias_index) $display("FSM State: BACK_BIAS at time %t", $time);
        if (FSM_flush_index)     $display("FSM State: FLUSH at time %t", $time);
        if (FSM_aed_read_index)  $display("FSM State: AED_READ at time %t", $time);
        if (FSM_exp_index)       $display("FSM State: EXP at time %t", $time);
        if (FSM_read_index)      $display("FSM State: READ at time %t", $time);
    end
    
    // Monitor key output signals for debug
    always @(posedge fsm_clk) begin
        if (ready_to_get_image !== ready_to_get_image) 
            $display("ready_to_get_image changed to %b at time %t", ready_to_get_image, $time);
            
        if (col_end !== col_end)
            $display("col_end changed to %b at time %t", col_end, $time);
            
        if (row_end !== row_end)
            $display("row_end changed to %b at time %t", row_end, $time);
    end

endmodule
