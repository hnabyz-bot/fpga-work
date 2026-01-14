// ---------------------------------------------------------------------------------
//   Title      :  ROIC Gate Driver Comparison Testbench
//   Purpose    :  Verify functional equivalence between original and refactored ROIC Gate Driver
// ---------------------------------------------------------------------------------
//   Description:
//   This testbench compares the outputs of the original roic_gate_drv.sv and the 
//   refactored roic_gate_drv_claude.sv to verify that they behave identically under
//   the same stimulus patterns.
// ---------------------------------------------------------------------------------

`timescale 1ns/1ps
`include "../../source/hdl/p_define.sv"

module tb_roic_gate_drv_compare();

// Parameters
localparam CLK_PERIOD = 40;    // 25MHz clock period (40ns)
localparam SIMULATION_TIME = 100000;  // Simulate for 100us
localparam AED_XAO_COUNT = 6;
localparam ROIC_ACLK_COUNT = 11;
localparam AED_DETECT_LINE_COUNT = 6;
localparam AED_READ_SKIP_COUNT = 7;
localparam AED_SKIP_MARGIN_BOT = 8;
localparam AED_SKIP_TAIL_START = 4;
localparam AED_SKIP_TAIL_END = 2;
localparam AED_WINDOW_SIZE = 2;
localparam READ_PIPELINE_STAGES = 2;

// Common clock and reset signals
reg         fsm_clk;
reg         fsm_drv_rst;
reg         rst;

// Common input signals
reg [15:0]  row_cnt;
reg [15:0]  col_cnt;
reg [15:0]  aed_read_image_height;
reg [15:0]  gate_size;
reg         fsm_back_bias_index;
reg         fsm_flush_index;
reg         fsm_aed_read_index;
reg         fsm_read_index;
reg         col_end;
reg         disable_aed_read_xao;

// Back bias timing inputs
reg [15:0]  up_back_bias;
reg [15:0]  dn_back_bias;
reg [15:0]  up_back_bias_opr;
reg [15:0]  dn_back_bias_opr;

// STV timing inputs
reg [15:0]  up_gate_stv1;
reg [15:0]  dn_gate_stv1;
reg [15:0]  up_gate_stv2;
reg [15:0]  dn_gate_stv2;

// CPV timing inputs  
reg [15:0]  up_gate_cpv1;
reg [15:0]  dn_gate_cpv1;
reg [15:0]  up_gate_cpv2;
reg [15:0]  dn_gate_cpv2;

// OE timing inputs
reg [15:0]  up_gate_oe1;
reg [15:0]  dn_gate_oe1;
reg [15:0]  up_gate_oe2;
reg [15:0]  dn_gate_oe2;

// AED XAO timing inputs
reg [15:0]  up_aed_gate_xao_0;
reg [15:0]  dn_aed_gate_xao_0;
reg [15:0]  up_aed_gate_xao_1;
reg [15:0]  dn_aed_gate_xao_1;
reg [15:0]  up_aed_gate_xao_2;
reg [15:0]  dn_aed_gate_xao_2;
reg [15:0]  up_aed_gate_xao_3;
reg [15:0]  dn_aed_gate_xao_3;
reg [15:0]  up_aed_gate_xao_4;
reg [15:0]  dn_aed_gate_xao_4;
reg [15:0]  up_aed_gate_xao_5;
reg [15:0]  dn_aed_gate_xao_5;

// ROIC timing inputs
reg [15:0]  up_roic_sync;
reg [15:0]  up_roic_aclk_0;
reg [15:0]  up_roic_aclk_1;
reg [15:0]  up_roic_aclk_2;
reg [15:0]  up_roic_aclk_3;
reg [15:0]  up_roic_aclk_4;
reg [15:0]  up_roic_aclk_5;
reg [15:0]  up_roic_aclk_6;
reg [15:0]  up_roic_aclk_7;
reg [15:0]  up_roic_aclk_8;
reg [15:0]  up_roic_aclk_9;
reg [15:0]  up_roic_aclk_10;

// Break points
reg [15:0]  burst_break_pt_0;
reg [15:0]  burst_break_pt_1;
reg [15:0]  burst_break_pt_2;
reg [15:0]  burst_break_pt_3;

// AED detection lines
reg [15:0]  aed_detect_line_0;
reg [15:0]  aed_detect_line_1;
reg [15:0]  aed_detect_line_2;
reg [15:0]  aed_detect_line_3;
reg [15:0]  aed_detect_line_4;
reg [15:0]  aed_detect_line_5;

// Original module outputs
wire        orig_back_bias;
wire        orig_gate_stv_1_1;
wire        orig_gate_cpv;
wire        orig_gate_oe1;
wire        orig_gate_oe2;
wire        orig_gate_xao_0;
wire        orig_gate_xao_1;
wire        orig_gate_xao_2;
wire        orig_gate_xao_3;
wire        orig_gate_xao_4;
wire        orig_gate_xao_5;
wire        orig_roic_sync;
wire        orig_roic_aclk;
wire        orig_valid_aed_read_skip;
wire        orig_roic_data_read_index;
wire        orig_valid_read_out;

// Refactored module outputs
wire        refac_back_bias;
wire        refac_gate_stv_1_1;
wire        refac_gate_cpv;
wire        refac_gate_oe1;
wire        refac_gate_oe2;
wire        refac_gate_xao_0;
wire        refac_gate_xao_1;
wire        refac_gate_xao_2;
wire        refac_gate_xao_3;
wire        refac_gate_xao_4;
wire        refac_gate_xao_5;
wire        refac_roic_sync;
wire        refac_roic_aclk;
wire        refac_valid_aed_read_skip;
wire        refac_roic_data_read_index;
wire        refac_valid_read_out;

// Comparison result tracking
integer mismatch_count = 0;
integer total_checks = 0;
reg all_signals_match;

// Instantiate the original module
roic_gate_drv original_dut (
    .fsm_clk                (fsm_clk),
    .fsm_drv_rst            (fsm_drv_rst),
    .rst                    (rst),
    .row_cnt                (row_cnt),
    .col_cnt                (col_cnt),
    .aed_read_image_height  (aed_read_image_height),
    .gate_size              (gate_size),
    .fsm_back_bias_index    (fsm_back_bias_index),
    .fsm_flush_index        (fsm_flush_index),
    .fsm_aed_read_index     (fsm_aed_read_index),
    .fsm_read_index         (fsm_read_index),
    .col_end                (col_end),
    .disable_aed_read_xao   (disable_aed_read_xao),
    .up_back_bias           (up_back_bias),
    .dn_back_bias           (dn_back_bias),
    .up_back_bias_opr       (up_back_bias_opr),
    .dn_back_bias_opr       (dn_back_bias_opr),
    .up_gate_stv1           (up_gate_stv1),
    .dn_gate_stv1           (dn_gate_stv1),
    .up_gate_stv2           (up_gate_stv2),
    .dn_gate_stv2           (dn_gate_stv2),
    .up_gate_cpv1           (up_gate_cpv1),
    .dn_gate_cpv1           (dn_gate_cpv1),
    .up_gate_cpv2           (up_gate_cpv2),
    .dn_gate_cpv2           (dn_gate_cpv2),
    .up_gate_oe1            (up_gate_oe1),
    .dn_gate_oe1            (dn_gate_oe1),
    .up_gate_oe2            (up_gate_oe2),
    .dn_gate_oe2            (dn_gate_oe2),
    .up_aed_gate_xao_0      (up_aed_gate_xao_0),
    .dn_aed_gate_xao_0      (dn_aed_gate_xao_0),
    .up_aed_gate_xao_1      (up_aed_gate_xao_1),
    .dn_aed_gate_xao_1      (dn_aed_gate_xao_1),
    .up_aed_gate_xao_2      (up_aed_gate_xao_2),
    .dn_aed_gate_xao_2      (dn_aed_gate_xao_2),
    .up_aed_gate_xao_3      (up_aed_gate_xao_3),
    .dn_aed_gate_xao_3      (dn_aed_gate_xao_3),
    .up_aed_gate_xao_4      (up_aed_gate_xao_4),
    .dn_aed_gate_xao_4      (dn_aed_gate_xao_4),
    .up_aed_gate_xao_5      (up_aed_gate_xao_5),
    .dn_aed_gate_xao_5      (dn_aed_gate_xao_5),
    .up_roic_sync           (up_roic_sync),
    .up_roic_aclk_0         (up_roic_aclk_0),
    .up_roic_aclk_1         (up_roic_aclk_1),
    .up_roic_aclk_2         (up_roic_aclk_2),
    .up_roic_aclk_3         (up_roic_aclk_3),
    .up_roic_aclk_4         (up_roic_aclk_4),
    .up_roic_aclk_5         (up_roic_aclk_5),
    .up_roic_aclk_6         (up_roic_aclk_6),
    .up_roic_aclk_7         (up_roic_aclk_7),
    .up_roic_aclk_8         (up_roic_aclk_8),
    .up_roic_aclk_9         (up_roic_aclk_9),
    .up_roic_aclk_10        (up_roic_aclk_10),
    .burst_break_pt_0       (burst_break_pt_0),
    .burst_break_pt_1       (burst_break_pt_1),
    .burst_break_pt_2       (burst_break_pt_2),
    .burst_break_pt_3       (burst_break_pt_3),
    .aed_detect_line_0      (aed_detect_line_0),
    .aed_detect_line_1      (aed_detect_line_1),
    .aed_detect_line_2      (aed_detect_line_2),
    .aed_detect_line_3      (aed_detect_line_3),
    .aed_detect_line_4      (aed_detect_line_4),
    .aed_detect_line_5      (aed_detect_line_5),
    .back_bias              (orig_back_bias),
    .gate_stv_1_1           (orig_gate_stv_1_1),
    .gate_cpv               (orig_gate_cpv),
    .gate_oe1               (orig_gate_oe1),
    .gate_oe2               (orig_gate_oe2),
    .gate_xao_0             (orig_gate_xao_0),
    .gate_xao_1             (orig_gate_xao_1),
    .gate_xao_2             (orig_gate_xao_2),
    .gate_xao_3             (orig_gate_xao_3),
    .gate_xao_4             (orig_gate_xao_4),
    .gate_xao_5             (orig_gate_xao_5),
    .roic_sync              (orig_roic_sync),
    .roic_aclk              (orig_roic_aclk),
    .valid_aed_read_skip    (orig_valid_aed_read_skip),
    .roic_data_read_index   (orig_roic_data_read_index),
    .valid_read_out         (orig_valid_read_out)
);

// Instantiate the refactored module
// Note: This module has parameters that might need adjustment to match original behavior
roic_gate_drv #(
    .AED_XAO_COUNT          (AED_XAO_COUNT),
    .ROIC_ACLK_COUNT        (ROIC_ACLK_COUNT),
    .AED_DETECT_LINE_COUNT  (AED_DETECT_LINE_COUNT),
    .AED_READ_SKIP_COUNT    (AED_READ_SKIP_COUNT),
    .AED_SKIP_MARGIN_BOT    (AED_SKIP_MARGIN_BOT),
    .AED_SKIP_TAIL_START    (AED_SKIP_TAIL_START),
    .AED_SKIP_TAIL_END      (AED_SKIP_TAIL_END),
    .AED_WINDOW_SIZE        (AED_WINDOW_SIZE),
    .READ_PIPELINE_STAGES   (READ_PIPELINE_STAGES)
) refactored_dut (
    .fsm_clk                (fsm_clk),
    .fsm_drv_rst            (fsm_drv_rst),
    .rst                    (rst),
    .row_cnt                (row_cnt),
    .col_cnt                (col_cnt),
    .aed_read_image_height  (aed_read_image_height),
    .gate_size              (gate_size),
    .fsm_back_bias_index    (fsm_back_bias_index),
    .fsm_flush_index        (fsm_flush_index),
    .fsm_aed_read_index     (fsm_aed_read_index),
    .fsm_read_index         (fsm_read_index),
    .col_end                (col_end),
    .disable_aed_read_xao   (disable_aed_read_xao),
    .up_back_bias           (up_back_bias),
    .dn_back_bias           (dn_back_bias),
    .up_back_bias_opr       (up_back_bias_opr),
    .dn_back_bias_opr       (dn_back_bias_opr),
    .up_gate_stv1           (up_gate_stv1),
    .dn_gate_stv1           (dn_gate_stv1),
    .up_gate_stv2           (up_gate_stv2),
    .dn_gate_stv2           (dn_gate_stv2),
    .up_gate_cpv1           (up_gate_cpv1),
    .dn_gate_cpv1           (dn_gate_cpv1),
    .up_gate_cpv2           (up_gate_cpv2),
    .dn_gate_cpv2           (dn_gate_cpv2),
    .up_gate_oe1            (up_gate_oe1),
    .dn_gate_oe1            (dn_gate_oe1),
    .up_gate_oe2            (up_gate_oe2),
    .dn_gate_oe2            (dn_gate_oe2),
    .up_aed_gate_xao_0      (up_aed_gate_xao_0),
    .dn_aed_gate_xao_0      (dn_aed_gate_xao_0),
    .up_aed_gate_xao_1      (up_aed_gate_xao_1),
    .dn_aed_gate_xao_1      (dn_aed_gate_xao_1),
    .up_aed_gate_xao_2      (up_aed_gate_xao_2),
    .dn_aed_gate_xao_2      (dn_aed_gate_xao_2),
    .up_aed_gate_xao_3      (up_aed_gate_xao_3),
    .dn_aed_gate_xao_3      (dn_aed_gate_xao_3),
    .up_aed_gate_xao_4      (up_aed_gate_xao_4),
    .dn_aed_gate_xao_4      (dn_aed_gate_xao_4),
    .up_aed_gate_xao_5      (up_aed_gate_xao_5),
    .dn_aed_gate_xao_5      (dn_aed_gate_xao_5),
    .up_roic_sync           (up_roic_sync),
    .up_roic_aclk_0         (up_roic_aclk_0),
    .up_roic_aclk_1         (up_roic_aclk_1),
    .up_roic_aclk_2         (up_roic_aclk_2),
    .up_roic_aclk_3         (up_roic_aclk_3),
    .up_roic_aclk_4         (up_roic_aclk_4),
    .up_roic_aclk_5         (up_roic_aclk_5),
    .up_roic_aclk_6         (up_roic_aclk_6),
    .up_roic_aclk_7         (up_roic_aclk_7),
    .up_roic_aclk_8         (up_roic_aclk_8),
    .up_roic_aclk_9         (up_roic_aclk_9),
    .up_roic_aclk_10        (up_roic_aclk_10),
    .burst_break_pt_0       (burst_break_pt_0),
    .burst_break_pt_1       (burst_break_pt_1),
    .burst_break_pt_2       (burst_break_pt_2),
    .burst_break_pt_3       (burst_break_pt_3),
    .aed_detect_line_0      (aed_detect_line_0),
    .aed_detect_line_1      (aed_detect_line_1),
    .aed_detect_line_2      (aed_detect_line_2),
    .aed_detect_line_3      (aed_detect_line_3),
    .aed_detect_line_4      (aed_detect_line_4),
    .aed_detect_line_5      (aed_detect_line_5),
    .back_bias              (refac_back_bias),
    .gate_stv_1_1           (refac_gate_stv_1_1),
    .gate_cpv               (refac_gate_cpv),
    .gate_oe1               (refac_gate_oe1),
    .gate_oe2               (refac_gate_oe2),
    .gate_xao_0             (refac_gate_xao_0),
    .gate_xao_1             (refac_gate_xao_1),
    .gate_xao_2             (refac_gate_xao_2),
    .gate_xao_3             (refac_gate_xao_3),
    .gate_xao_4             (refac_gate_xao_4),
    .gate_xao_5             (refac_gate_xao_5),
    .roic_sync              (refac_roic_sync),
    .roic_aclk              (refac_roic_aclk),
    .valid_aed_read_skip    (refac_valid_aed_read_skip),
    .roic_data_read_index   (refac_roic_data_read_index),
    .valid_read_out         (refac_valid_read_out)
);

// Clock generation
initial begin
    fsm_clk = 0;
    forever #(CLK_PERIOD/2) fsm_clk = ~fsm_clk;
end

// Initialize signals and run tests
initial begin
    // Initialize inputs
    fsm_drv_rst = 0;
    rst = 0;
    row_cnt = 0;
    col_cnt = 0;
    aed_read_image_height = 256;
    gate_size = 128;
    fsm_back_bias_index = 0;
    fsm_flush_index = 0;
    fsm_aed_read_index = 0;
    fsm_read_index = 0;
    col_end = 0;
    disable_aed_read_xao = 0;
    
    // Default timing values
    up_back_bias = 10;
    dn_back_bias = 20;
    up_back_bias_opr = 15;
    dn_back_bias_opr = 25;
    up_gate_stv1 = 30;
    dn_gate_stv1 = 40;
    up_gate_stv2 = 35;
    dn_gate_stv2 = 45;
    up_gate_cpv1 = 50;
    dn_gate_cpv1 = 60;
    up_gate_cpv2 = 55;
    dn_gate_cpv2 = 65;
    up_gate_oe1 = 70;
    dn_gate_oe1 = 80;
    up_gate_oe2 = 75;
    dn_gate_oe2 = 85;
    
    // AED XAO timing
    up_aed_gate_xao_0 = 10;
    dn_aed_gate_xao_0 = 15;
    up_aed_gate_xao_1 = 20;
    dn_aed_gate_xao_1 = 25;
    up_aed_gate_xao_2 = 30;
    dn_aed_gate_xao_2 = 35;
    up_aed_gate_xao_3 = 40;
    dn_aed_gate_xao_3 = 45;
    up_aed_gate_xao_4 = 50;
    dn_aed_gate_xao_4 = 55;
    up_aed_gate_xao_5 = 60;
    dn_aed_gate_xao_5 = 65;
    
    // ROIC timing
    up_roic_sync = 5;
    up_roic_aclk_0 = 10;
    up_roic_aclk_1 = 20;
    up_roic_aclk_2 = 30;
    up_roic_aclk_3 = 40;
    up_roic_aclk_4 = 50;
    up_roic_aclk_5 = 60;
    up_roic_aclk_6 = 70;
    up_roic_aclk_7 = 80;
    up_roic_aclk_8 = 90;
    up_roic_aclk_9 = 100;
    up_roic_aclk_10 = 110;
    
    // Break points
    burst_break_pt_0 = 15;
    burst_break_pt_1 = 25;
    burst_break_pt_2 = 35;
    burst_break_pt_3 = 45;
    
    // AED detection lines
    aed_detect_line_0 = 20;
    aed_detect_line_1 = 40;
    aed_detect_line_2 = 60;
    aed_detect_line_3 = 80;
    aed_detect_line_4 = 100;
    aed_detect_line_5 = 120;
    
    // Reset sequence
    #100 rst = 1;
    #100 fsm_drv_rst = 1;
    
    // Run various test cases
    test_back_bias_mode();
    test_flush_mode();
    test_aed_read_mode();
    test_normal_read_mode();
    
    // Print final results
    if (mismatch_count == 0)
        $display("TEST PASSED: All %0d signal comparisons matched!", total_checks);
    else
        $display("TEST FAILED: %0d mismatches detected out of %0d signal comparisons!", mismatch_count, total_checks);
        
    // End simulation
    #1000 $finish;
end

// Task to test back bias operation mode
task test_back_bias_mode();
    $display("\nTesting Back Bias Mode...");
    fsm_back_bias_index = 1;
    fsm_flush_index = 0;
    fsm_aed_read_index = 0;
    fsm_read_index = 0;
    
    // Run through a full column cycle
    for (int i = 0; i < 128; i++) begin
        col_cnt = i;
        row_cnt = 10; // arbitrary row
        #(CLK_PERIOD);
        
        // Check outputs every cycle
        check_outputs();
    end
    
    fsm_back_bias_index = 0;
    #(CLK_PERIOD);
    $display("Back Bias Mode Test Complete");
endtask

// Task to test flush operation mode
task test_flush_mode();
    $display("\nTesting Flush Mode...");
    fsm_back_bias_index = 0;
    fsm_flush_index = 1;
    fsm_aed_read_index = 0;
    fsm_read_index = 0;
    
    // Run through a full column cycle
    for (int i = 0; i < 128; i++) begin
        col_cnt = i;
        row_cnt = 10; // arbitrary row
        #(CLK_PERIOD);
        
        // Check outputs every cycle
        check_outputs();
    end
    
    fsm_flush_index = 0;
    #(CLK_PERIOD);
    $display("Flush Mode Test Complete");
endtask

// Task to test AED read operation mode
task test_aed_read_mode();
    $display("\nTesting AED Read Mode...");
    fsm_back_bias_index = 0;
    fsm_flush_index = 0;
    fsm_aed_read_index = 1;
    fsm_read_index = 0;
    
    // Test various row positions including AED detection rows
    // and rows that should be skipped
    for (int r = 0; r < 200; r += 10) begin
        row_cnt = r;
        
        // For each row, run through a column cycle
        for (int i = 0; i < 128; i++) begin
            col_cnt = i;
            #(CLK_PERIOD);
            
            // Check outputs every cycle
            check_outputs();
        end
    end
    
    // Also test with XAO disabled
    disable_aed_read_xao = 1;
    for (int i = 0; i < 128; i++) begin
        col_cnt = i;
        row_cnt = aed_detect_line_0; // Use a line that should trigger AED
        #(CLK_PERIOD);
        check_outputs();
    end
    
    fsm_aed_read_index = 0;
    disable_aed_read_xao = 0;
    #(CLK_PERIOD);
    $display("AED Read Mode Test Complete");
endtask

// Task to test normal read operation mode
task test_normal_read_mode();
    $display("\nTesting Normal Read Mode...");
    fsm_back_bias_index = 0;
    fsm_flush_index = 0;
    fsm_aed_read_index = 0;
    fsm_read_index = 1;
    
    // Run through a full column cycle
    for (int i = 0; i < 128; i++) begin
        col_cnt = i;
        row_cnt = 50; // arbitrary row
        #(CLK_PERIOD);
        
        // Check outputs every cycle
        check_outputs();
    end
    
    fsm_read_index = 0;
    #(CLK_PERIOD);
    $display("Normal Read Mode Test Complete");
endtask

// Task to compare all outputs from both modules
task check_outputs();
    all_signals_match = 1;
    
    // Compare all outputs
    check_signal("back_bias", orig_back_bias, refac_back_bias);
    check_signal("gate_stv_1_1", orig_gate_stv_1_1, refac_gate_stv_1_1);
    check_signal("gate_cpv", orig_gate_cpv, refac_gate_cpv);
    check_signal("gate_oe1", orig_gate_oe1, refac_gate_oe1);
    check_signal("gate_oe2", orig_gate_oe2, refac_gate_oe2);
    check_signal("gate_xao_0", orig_gate_xao_0, refac_gate_xao_0);
    check_signal("gate_xao_1", orig_gate_xao_1, refac_gate_xao_1);
    check_signal("gate_xao_2", orig_gate_xao_2, refac_gate_xao_2);
    check_signal("gate_xao_3", orig_gate_xao_3, refac_gate_xao_3);
    check_signal("gate_xao_4", orig_gate_xao_4, refac_gate_xao_4);
    check_signal("gate_xao_5", orig_gate_xao_5, refac_gate_xao_5);
    check_signal("roic_sync", orig_roic_sync, refac_roic_sync);
    check_signal("roic_aclk", orig_roic_aclk, refac_roic_aclk);
    check_signal("valid_aed_read_skip", orig_valid_aed_read_skip, refac_valid_aed_read_skip);
    check_signal("roic_data_read_index", orig_roic_data_read_index, refac_roic_data_read_index);
    check_signal("valid_read_out", orig_valid_read_out, refac_valid_read_out);

    // If we're at a specific known condition, report the current status
    if (col_cnt % 20 == 0) begin
        $display("Time: %0t, Mode: B:%0d F:%0d AED:%0d R:%0d, Row: %0d, Col: %0d - %s", 
                 $time, fsm_back_bias_index, fsm_flush_index, fsm_aed_read_index, fsm_read_index,
                 row_cnt, col_cnt, all_signals_match ? "MATCH" : "MISMATCH");
    end
endtask

// Helper task to check a single signal
task check_signal(input string signal_name, input bit orig, input bit refac);
    total_checks = total_checks + 1;
    
    if (orig !== refac) begin
        mismatch_count = mismatch_count + 1;
        all_signals_match = 0;
        $display("Mismatch at time %0t for signal %s: orig=%b, refac=%b (Mode: B:%0d F:%0d AED:%0d R:%0d, Row: %0d, Col: %0d)",
                 $time, signal_name, orig, refac, 
                 fsm_back_bias_index, fsm_flush_index, fsm_aed_read_index, fsm_read_index,
                 row_cnt, col_cnt);
    end
endtask

// Track waveforms
initial begin
    $dumpfile("tb_roic_gate_drv_compare.vcd");
    $dumpvars(0, tb_roic_gate_drv_compare);
end

endmodule
