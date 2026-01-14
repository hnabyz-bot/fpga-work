//-----------------------------------------------------------------------------
// Project      : FPGA Sequencer FSM
// File         : sequencer_fsm_tb.sv
// Author       : [drake.lee]
// Reviewer     : [holee]
// Company      : [H&abyz]
// Department   : [DR device development]
// Created      : [2025-05-20]
// Version      : 0.1
// Tool Version : [vivado 2023.1]
// ------------------------------------------------------------------------------
// Revision History :
//   - 0.0 : Initial version.
//   - 0.1 : Added testbench for sequencer_fsm module
// -----------------------------------------------------------------------------
// Description  : 
//   - Testbench for sequencer_fsm module.
//   - Verifies state transitions, LUT RAM operation, repeat/timer/exit logic.
//   - Monitors sequence_done and state outputs.
//-----------------------------------------------------------------------------

`timescale 1ns / 1ps

// Sequencer FSM Testbench
// - Tests FSM state transitions, LUT RAM operations, and sequence execution
// - Verifies repeat, timer, and exit signal handling
// - Monitors state changes and sequence completion

module sequencer_fsm_tb();

    // Clock period definition
    localparam CLOCK_PERIOD = 10;

    // DUT Interface Signals
    // Clock and Reset
    logic                   clk;
    logic                   reset_i;

    // LUT RAM Interface
    logic                   config_done_i;
    logic [7:0]             lut_addr_i;
    logic                   lut_wen_i;
    logic [47:0]            lut_write_data_i;
    logic                   lut_rden_i;
    wire  [47:0]            lut_read_data_o;

    // Control Signals
    logic [2:0]             acq_mode_i;
    logic [31:0]            expose_size_i;
    logic                   exit_signal_i;

    // FSM Status Outputs
    wire  [3:0]             current_state_o;
    wire  logic             busy_o;
    wire  logic             sequence_done_o;

    // Command Enable Outputs
    wire  logic             panel_enable_o;
    wire  logic             bias_enable_o;
    wire  logic             flush_enable_o;
    wire  logic             expose_enable_o;
    wire  logic             readout_enable_o;
    wire  logic             aed_enable_o;
    logic                  reserved1_o;
    logic                  reserved2_o;


    // Current Command Parameters
    wire  [15:0]            current_repeat_count_o;
    wire  [15:0]            current_data_length_o;
    wire               current_eof_o;
    wire               current_sof_o;

    logic [47:0]            lut_wr_data;
    logic [47:0]            lut_rd_data;
    logic [7:0]             lut_addr;

    // FSM State Definitions
    localparam logic [3:0] RST          = 4'd0;     // Reset state
    localparam logic [3:0] PANEL_STABLE = 4'd1;     // Panel stable state
    localparam logic [3:0] BACK_BIAS    = 4'd2;     // Back bias state
    localparam logic [3:0] FLUSH        = 4'd3;     // Flush state
    localparam logic [3:0] AED_DETECT   = 4'd4;     // AED detect state
    localparam logic [3:0] EXPOSE_TIME  = 4'd5;     // Expose time state
    localparam logic [3:0] READOUT      = 4'd6;     // Readout state
    localparam logic [3:0] IDLE         = 4'd7;     // Idle state

    // Instantiate DUT
    sequencer_fsm dut (
        .clk                    (clk),
        .reset_i                (reset_i),
        .config_done_i          (config_done_i),
        .lut_addr_i             (lut_addr_i),
        .lut_wen_i              (lut_wen_i),
        .lut_write_data_i       (lut_write_data_i),
        .lut_rden_i             (lut_rden_i),
        .acq_mode_i             (acq_mode_i),
        .expose_size_i          (expose_size_i),
        .exit_signal_i          (exit_signal_i),
        .lut_read_data_o        (lut_read_data_o),
        .current_state_o        (current_state_o),
        .busy_o                 (busy_o),
        .sequence_done_o        (sequence_done_o),
        .panel_enable_o         (panel_enable_o),
        .bias_enable_o          (bias_enable_o),
        .flush_enable_o         (flush_enable_o),
        .expose_enable_o        (expose_enable_o),
        .readout_enable_o       (readout_enable_o),
        .aed_enable_o           (aed_enable_o),
        .reserved1_o            (reserved1_o),
        .reserved2_o            (reserved2_o),
        .current_repeat_count_o (current_repeat_count_o),
        .current_data_length_o  (current_data_length_o),
        .current_eof_o          (current_eof_o),
        .current_sof_o          (current_sof_o)
    );

    // Clock generation
    always #(CLOCK_PERIOD / 2) clk = ~clk;


    // Main test sequence
    initial begin
        // Initialize signals
        string msg;

        lut_addr = 8'd0;
        lut_wr_data = 48'd0;
        clk = 1'b0;
        reset_i = 1'b0;
        lut_addr_i = 8'd0;
        lut_wen_i = 1'b0;
        lut_write_data_i = 48'd0;
        lut_rden_i = 1'b0;
        config_done_i = 1'b0;
        exit_signal_i = 1'b0;
        expose_size_i = 32'd2;
        acq_mode_i = 3'd0; // Normal mode
        // Wait for reset
        // repeat(2) @(posedge clk);
        // #4 reset_i = 1'b0;
        // @(posedge clk);

        // // Enter RST state for LUT RAM configuration
        // #4 reset_i = 1'b1;
        // repeat(4) @(posedge clk);
        // // config_done_i = 1'b0;

        // #4 reset_i = 1'b0;
        // @(posedge clk);

        #1000;
        cmd_reset();
        #100;

        acq_mode_i = 3'd7; // Wakeup , Power on mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
        #100;

        #20000;
        wait (sequence_done_o == 1'b0);
        #100;
        repeat(10) @(posedge clk);
        config_done_i = 1'b1;
        repeat(10) @(posedge clk);

            //                Format: reservd,   state,        repeat,  length,  sof,    eof,   next_addr
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  PANEL_STABLE,     16'd0,   16'd5,  1'b0,   1'b0,   8'd1);  // 0
        lut_addr = 8'hC0 + 8'd0;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  BACK_BIAS,        16'd3,   16'd10, 1'b0,   1'b0,   8'd2);  // 1
        lut_addr = 8'hC0 + 8'd01;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  FLUSH,            16'd2,   16'd20, 1'b0,   1'b0,   8'd3);  // 2
        lut_addr = 8'hC0 + 8'd02;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  BACK_BIAS,        16'd3,   16'd10, 1'b0,   1'b0,   8'd4);  // 3
        lut_addr = 8'hC0 + 8'd03;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  FLUSH,            16'd2,   16'd20, 1'b0,   1'b0,   8'd5);  // 4
        lut_addr = 8'hC0 + 8'd04;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  EXPOSE_TIME,      16'd0,   16'd50, 1'b1,   1'b0,   8'd6);  // 5
        lut_addr = 8'hC0 + 8'd05;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  READOUT,          16'd0,   16'd40, 1'b0,   1'b1,   8'd7);  // 6 
        lut_addr = 8'hC0 + 8'd06;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  IDLE,             16'd1,   16'd1,  1'b0,   1'b0,   8'd5);  // 7
        lut_addr = 8'hC0 + 8'd07;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  EXPOSE_TIME,      16'd1,   16'd50, 1'b0,   1'b0,   8'd9);  // 8
        lut_addr = 8'hC0 + 8'd08;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  READOUT,          16'd0,   16'd40, 1'b0,   1'b0,   8'd10); // 9
        lut_addr = 8'hC0 + 8'd09;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  BACK_BIAS,        16'd0,   16'd10, 1'b1,   1'b0,   8'd11); // 10
        lut_addr = 8'hC0 + 8'd10;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  FLUSH,            16'd1,   16'd20, 1'b0,   1'b1,   8'd12); // 11
        lut_addr = 8'hC0 + 8'd11;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  IDLE,             16'd1,   16'd1,  1'b0,   1'b0,   8'd10); // 12
        lut_addr = 8'hC0 + 8'd12;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  EXPOSE_TIME,      16'd2,   16'd50, 1'b1,   1'b0,   8'd14); // 13
        lut_addr = 8'hC0 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd3,  IDLE,             16'd255,   16'd255, 1'b1,   1'b1,   8'd15); // 15
        lut_addr = 8'hE0 + 8'd06;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd0,  READOUT,          16'd0,   16'd40, 1'b0,   1'b1,   8'd10); // 14
        lut_addr = 8'hC0 + 8'd14;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd3,  IDLE,             16'd255,   16'd255, 1'b1,   1'b1,   8'd15); // 15
        lut_addr = 8'hE0 + 8'd15;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd3,  IDLE,             16'd255,   16'd255, 1'b1,   1'b1,   8'd15); // 15
        lut_addr = 8'hC0 + 8'd15;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // AED 0 mode entries (0x80 - 0x9F)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd13); // 12
        lut_addr = 8'h80 + 8'd12;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd14); // 13
        lut_addr = 8'h80 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // Normal 0 mode entries (0x00 - 0x1F)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd12); // 11
        lut_addr = 8'h00 + 8'd11;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd13); // 12
        lut_addr = 8'h00 + 8'd12;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // Normal 1 mode entries (0x20 - 0x3F)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd12); // 11
        lut_addr = 8'h20 + 8'd11;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd13); // 12
        lut_addr = 8'h20 + 8'd12;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd14); // 13
        lut_addr = 8'h20 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd15); // 14
        lut_addr = 8'h20 + 8'd14;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // Normal 2 mode entries (0x40 - 0x5F)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd11); // 10
        lut_addr = 8'h40 + 8'd10;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b1,   8'd12); // 11
        lut_addr = 8'h40 + 8'd11;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd14); // 13
        lut_addr = 8'h40 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd15); // 14
        lut_addr = 8'h40 + 8'd14;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // Normal 3 mode entries (0x60 - 0x7F)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd11); // 10
        lut_addr = 8'h60 + 8'd10;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b1,   8'd12); // 11
        lut_addr = 8'h60 + 8'd11;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd14); // 13
        lut_addr = 8'h60 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd15); // 14
        lut_addr = 8'h60 + 8'd14;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd16); // 15
        lut_addr = 8'h60 + 8'd15;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd17); // 16
        lut_addr = 8'h60 + 8'd16;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd18); // 17
        lut_addr = 8'h60 + 8'd17;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        // AED 2 mode entries (0xA0 - 0xBF)
        @(posedge clk);
        lut_wr_data = pack_lut_entry(  2'd2,  EXPOSE_TIME,      16'd3,      16'd100, 1'b1,   1'b0,   8'd13); // 12
        lut_addr = 8'hA0 + 8'd12;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd1,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd14); // 13
        lut_addr = 8'hA0 + 8'd13;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd15); // 14
        lut_addr = 8'hA0 + 8'd14;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd16); // 15
        lut_addr = 8'hA0 + 8'd15;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);

        lut_wr_data = pack_lut_entry(  2'd3,  READOUT,          16'd0,      16'd80, 1'b0,   1'b0,   8'd17); // 16
        lut_addr = 8'hA0 + 8'd16;        lut_write(lut_addr, lut_wr_data); save_lut_entry_to_mem(lut_wr_data);


        repeat(10) @(posedge clk);
        config_done_i = 1'b0;
        repeat(10) @(posedge clk);

        wait (sequence_done_o == 1'b0);
        #10000;

    // ===============================================================================================
    // Simulation mode test
    // ===============================================================================================

        $display("%0t\ Starting Simulation mode test" , $time);

        acq_mode_i = 3'd6; // Simulation mode
        #100;
        $display("%0t\ Acqisition mode : %0d" , $time, acq_mode_i);

        cmd_reset();
        #100;

        // lut_wen_i = 1'b0;
        repeat(2) @(posedge clk);

        // config_done_i = 1'b1;
        #1000;

        wait (sequence_done_o == 1'b0);
        #100;

        // Wait for sequence execution
        #1000;

        // Wait for sequence execution
        #20000;


        msg = "Simulation 6 , test case 1";
        exit_signal(msg);

        expose_size_i = 32'd5;
        #1000;
        
        msg = "Simulation 6 , test case 2";
        exit_signal(msg);

        #25000;
        expose_size_i = 32'd10;
        #1000;

        msg = "Simulation 6 , test case 3";
        exit_signal(msg);


        wait (sequence_done_o == 1'b0);
        #100;
        expose_size_i = 32'd1;
        #1000;
        
        #30000;
        msg = "Simulation 6 , test case 4";
        exit_signal(msg);

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #25000;

        msg = "Simulation 6 , test case 5";
        exit_signal(msg);

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #25000;

    // ===============================================================================================
    // AED mode simulation test
    // ===============================================================================================
        acq_mode_i = 3'd4; // AED 0 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       
        // Continue monitoring
        #25000;

        repeat(10) @(posedge clk);
        config_done_i = 1'b1;
        repeat(10) @(posedge clk);

        lut_read(8'd0, lut_rd_data);
        $display("lut read data = %h", lut_rd_data);
        #100;

        repeat(10) @(posedge clk);
        config_done_i = 1'b0;
        repeat(10) @(posedge clk);

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #25000;

        msg = "AED 4 , test case 1";
        exit_signal(msg);

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #5000;

        msg = "AED 4 , test case 2";
        exit_signal(msg);

        #270000;
        msg = "AED 4 , test case 3";
        exit_signal(msg);

        #232000;
        msg = "AED 4 , test case 4";
        exit_signal(msg);


    // ===============================================================================================
    // Norral mode simulation test
    // ===============================================================================================
        #30000;
        acq_mode_i = 3'd0; // Normal 0 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #25000;

        msg = "Normal 0 , test case 1";
        exit_signal(msg);

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #5000;

        msg = "Normal 0 , test case 2";
        exit_signal(msg);

        #270000;
        msg = "Normal 0 , test case 3";
        exit_signal(msg);

        #232000;
        msg = "Normal 0 , test case 4";
        exit_signal(msg);

    // ===============================================================================================
    // AED mode simulation test
    // ===============================================================================================
        acq_mode_i = 3'd5; // AED 1 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #85000;

        msg = "AED 5 , test case 1";
        exit_signal(msg);


    // ===============================================================================================
    // Norral mode simulation test
    // ===============================================================================================
        #90000;
        acq_mode_i = 3'd1; // Normal 1 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #65000;

        msg = "Normal 1 , test case 1";
        exit_signal(msg);

    // ===============================================================================================
    // Norral mode simulation test
    // ===============================================================================================
        #300000;
        acq_mode_i = 3'd2; // Normal 2 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #55000;

        msg = "Normal 2 , test case 1";
        exit_signal(msg);

    // ===============================================================================================
    // Norral mode simulation test
    // ===============================================================================================
        #150000;
        acq_mode_i = 3'd3; // Normal 3 mode
        #100;
        cmd_reset();
        #100;

        wait (sequence_done_o == 1'b0);
       // Continue monitoring
        #25000;

        msg = "Normal 3 , test case 1";
        exit_signal(msg);

        // ===============================================================================================

        #200000;
        repeat(50000) @(posedge clk);
        $finish;
    end

//===============================================================================================
    task automatic cmd_reset();
        begin
            #110;
            reset_i = 1'b1;
            repeat(20) @(posedge clk);
            reset_i = 1'b0;
            repeat(20) @(posedge clk);
            #220;
            $display("%0t\ Command reset processed \n", $time);
        end
    endtask

    task automatic exit_signal(input string msg);
        begin
            wait (sequence_done_o == 1'b0);
            #100;
            exit_signal_i = 1'b1;
            repeat(4) @(posedge clk);
            wait (sequence_done_o == 1'b1);
            $display("%0t\ Exit signal processed : %s", $time, msg);
            repeat(4) @(posedge clk);
            exit_signal_i = 1'b0;
            #100;        
        end
    endtask


    // Task: Write one entry to LUT RAM
    task automatic lut_write(
        input logic [7:0] addr,
        input logic [47:0] data
    );
        begin
            repeat(10) @(posedge clk);
            lut_wen_i        = 1'b1;
            lut_write_data_i = data;
            lut_addr_i = addr;
            repeat(10) @(posedge clk);
            lut_wen_i        = 1'b0;
            // lut_write_data_i = 48'd0;
            repeat(10) @(posedge clk);
            $display("LUT Write: Addr=%0d, Data=%h \n", addr, data);
        end
    endtask

    // Task: Read one entry from LUT RAM
    task automatic lut_read(
        input logic [7:0] addr,
        output logic [47:0] data
    );
        begin
            repeat(10) @(posedge clk);
            lut_rden_i = 1'b1;
            lut_addr_i = addr;
            repeat(10) @(posedge clk);
            data = lut_read_data_o;
            repeat(10) @(posedge clk);
            lut_rden_i = 1'b0;
            repeat(10) @(posedge clk);
            $display("LUT Read: Addr=%0d, Data=%h \n", addr, data);
        end
    endtask

//===============================================================================================

    // Helper function to pack LUT entry data
    function automatic logic [47:0] pack_lut_entry(
        input logic [1:0] reservd_in,
        input logic [3:0] next_state_in,
        input logic [15:0] repeat_count_in,
        input logic [15:0] data_length_in,
        input logic [0:0] sof_in,
        input logic [0:0] eof_in,
        input logic [7:0] next_address_in
    );
        pack_lut_entry = 
                        (reservd_in      << 46) |
                        (sof_in          << 45) |
                        (eof_in          << 44) |
                        (next_state_in   << 40) |
                        (next_address_in << 32) |
                        (repeat_count_in << 16) |
                        (data_length_in  << 0);
        $display("Packed LUT Entry: %h", pack_lut_entry);
        return pack_lut_entry;

    endfunction

    // Helper function to convert state encoding to string
    function string state_to_str(input logic [3:0] state);
        case (state)
            4'd0: state_to_str = "RST";
            4'd1: state_to_str = "PANEL_STABLE";
            4'd2: state_to_str = "BACK_BIAS";
            4'd3: state_to_str = "FLUSH";
            4'd4: state_to_str = "AED_DETECT";
            4'd5: state_to_str = "EXPOSE_TIME";
            4'd6: state_to_str = "READOUT";
            4'd7: state_to_str = "IDLE";
            default: state_to_str = "UNKOWN";
        endcase
    endfunction

// ===============================================================================================
    task automatic save_lut_entry_to_mem(
        input logic [47:0] lut_entry
    );
        int file;
        file = $fopen("F:/github_work/fpga_dev/fsm_auto/test/init.mem", "a");
        $fwrite(file, "%012x\n", lut_entry);
        $fclose(file);
    endtask
// ================================================================================================

initial begin
    // Clear init.mem file before writing LUT entries
    int file;
    file = $fopen("F:/github_work/fpga_dev/fsm_auto/test/init.mem", "w");
    $fclose(file);
end

// ================================================================================================


    // Monitor state changes and command parameters
    // initial begin
    //     $display("Time\tState\tRepeat\tLen\tEOF\tSOF");
    //     forever begin
    //         @(posedge clk);
    //         $display("%0t\t%s\t%0d\t%0d\t%b\t%b",
    //             $time,
    //             state_to_str(current_state_o),
    //             current_repeat_count_o,
    //             current_data_length_o,
    //             current_eof_o,
    //             current_sof_o
    //         );
    //     end
    // end


//    // Waveform dump setup
//    initial begin
//        $dumpfile("sequencer_fsm_tb.vcd");
//        $dumpvars(0, sequencer_fsm_tb);
//        $display("Time\tState\tBusy\tSeqDone\tAddr\tRptCnt\tDataLen\tEOF\tSOF");
//        $monitor("%0t\t%h\t%b\t%b\t%h\t%d\t%d\t%b\t%b",
//                 $time, current_state_o, busy_o, sequence_done_o,
//                 dut.lut_addr_reg, current_repeat_count_o, current_data_length_o,
//                 current_eof_o, current_sof_o);
//    end

//    // Verify LUT RAM initialization
//    initial begin
//        $display("Checking LUT RAM initial values:");
//        for (int i = 0; i < 6; i++) begin
//            $display("LUT RAM[%0d] = %h", i, dut.internal_lut_ram[i]);
//        end
//    end

endmodule