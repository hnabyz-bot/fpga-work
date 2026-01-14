`timescale 1ns / 1ps

/**
 * @file sync_gen_tb.sv
 * @brief Testbench for the sync_gen module.
 * 
 * This testbench verifies the functionality of the sync_gen module by applying
 * various input conditions and observing the outputs.
 */

module sync_gen_tb;

    // Parameters
    localparam TLINE_CNTR_W = 14;
    localparam LINE_CNTR_W  = 4;
    localparam TP_SEL_M     = 5;
    localparam TP_SEL_N     = 5;

    // Testbench signals
    logic mclk;
    logic rst;
    logic [TLINE_CNTR_W-1:0] tline_reg;
    logic sync_trigger;
    logic sync_periodic_en;
    logic [LINE_CNTR_W-2:0] sync_period;
    logic sync_as_conv;
    logic tp_sel_mode;
    logic tp_sel_val;
    logic [TP_SEL_M-1:0] tp_sel_0_cnt;
    logic [TP_SEL_N-1:0] tp_sel_1_cnt;
    logic [TLINE_CNTR_W-1:0] shs_value;

    // Outputs
    logic sync;
    logic tp_sel;
    logic sync_chop_out;
    logic shs_duplicate;

    logic sync_rev;
    logic tp_sel_rev;
    logic sync_chop_out_rev;
    logic shs_duplicate_rev;

    // Clock generation
    initial begin
        mclk = 0;
        forever #5 mclk = ~mclk; // 10ns clock period (100MHz)
    end

    // Instantiate the DUT (Device Under Test)
    sync_gen #(
        .TLINE_CNTR_W(TLINE_CNTR_W),
        .LINE_CNTR_W(LINE_CNTR_W),
        .TP_SEL_M(TP_SEL_M),
        .TP_SEL_N(TP_SEL_N)
    ) dut (
        .mclk(mclk),
        .rst(rst),
        .tline_reg(tline_reg),
        .sync_trigger(sync_trigger),
        .sync_periodic_en(sync_periodic_en),
        .sync_period(sync_period),
        .sync_as_conv(sync_as_conv),
        .sync(sync),
        .tp_sel_mode(tp_sel_mode),
        .tp_sel_val(tp_sel_val),
        .tp_sel_0_cnt(tp_sel_0_cnt),
        .tp_sel_1_cnt(tp_sel_1_cnt),
        .tp_sel(tp_sel),
        .sync_chop_out(sync_chop_out),
        .shs_value(shs_value),
        .shs_duplicate(shs_duplicate)
    );

    // Instantiate the DUT (Device Under Test)
    sync_gen_rev #(
        .TLINE_CNTR_W(TLINE_CNTR_W),
        .LINE_CNTR_W(LINE_CNTR_W),
        .TP_SEL_M(TP_SEL_M),
        .TP_SEL_N(TP_SEL_N)
    ) dut_rev (
        .mclk(mclk),
        .rst(rst),
        .tline_reg(tline_reg),
        .sync_trigger(sync_trigger),
        .sync_periodic_en(sync_periodic_en),
        .sync_period(sync_period),
        .sync_as_conv(sync_as_conv),
        .sync(sync_rev),
        .tp_sel_mode(tp_sel_mode),
        .tp_sel_val(tp_sel_val),
        .tp_sel_0_cnt(tp_sel_0_cnt),
        .tp_sel_1_cnt(tp_sel_1_cnt),
        .tp_sel(tp_sel_rev),
        .sync_chop_out(sync_chop_out_rev),
        .shs_value(shs_value),
        .shs_duplicate(shs_duplicate_rev)
    );

    // Testbench stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        tline_reg = 14'd1000; // Example line time
        sync_trigger = 0;
        sync_periodic_en = 0;
        sync_period = 3'd4; // Example sync period
        sync_as_conv = 0;
        tp_sel_mode = 0;
        tp_sel_val = 0;
        tp_sel_0_cnt = 5'd10;
        tp_sel_1_cnt = 5'd5;
        shs_value = 14'd500;

        // Apply reset
        #20 rst = 0;

        // Test case 1: Trigger sync manually
        #10 sync_trigger = 1;
        #10 sync_trigger = 0;

        // Wait for a few clock cycles
        #100;

        // Test case 2: Enable periodic sync
        sync_periodic_en = 1;
        #500;

        // Test case 3: Test tp_sel in periodic mode
        tp_sel_mode = 1;
        #500;

        // Test case 4: Test tp_sel in static mode
        tp_sel_mode = 0;
        tp_sel_val = 1;
        #500;

        // Test case 5: Test shs_duplicate signal
        shs_value = 14'd750;
        #500;

        // End simulation
        #1000 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | rst: %b | sync: %b | tp_sel: %b | sync_chop_out: %b | shs_duplicate: %b",
                 $time, rst, sync, tp_sel, sync_chop_out, shs_duplicate);
    end

endmodule