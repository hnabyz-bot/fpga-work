//-----------------------------------------------------------------------------
// Project      : FPGA Sequencer FSM
// File         : sequencer_fsm.sv
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
//   - 0.1 : Added LUT RAM initialization and state transition logic.
// -----------------------------------------------------------------------------
// Description  : 
//   - FPGA finite state machine for sequence control.
//   - Executes command sequences from LUT RAM.
//   - Supports repeat, timer, and exit signal handling.
//   - Used for wait, bias, flush, expose, readout, and AED control.
//-----------------------------------------------------------------------------

`timescale 1ns / 1ps

// Sequencer FSM Module
// - Controls sequence execution based on LUT RAM commands
// - Supports repeat, timer, and exit signal handling
// - LUT RAM read/write in RST state
// - State transitions based on command completion and internal timer

module sequencer_fsm (
    // Clock and Reset
    input  logic                    clk,
    input  logic                    reset_i,                    // Active high reset

    // LUT RAM Interface (RST state only)
    input  logic                    config_done_i,              // Configuration done signal
    input  logic [7:0]              lut_addr_i,
    input  logic                    lut_wen_i,                  // LUT Write Enable
    input  logic [63:0]             lut_write_data_i,           // Data to write to LUT RAM
//    input  logic                    lut_rden_i,                 // LUT Read Enable
    output logic [63:0]             lut_read_data_o,            // Data read from LUT RAM

    // Control Signals
    input  logic [2:0]              acq_mode_i,                 // Acquisition mode set
    input  logic [31:0]             expose_size_i,
    input  logic                    exit_signal_i,              // Exit signal to stop sequence
    // input  logic [15:0]             iterate_count_i,            // Iterate count for current command

    input  logic                    roic_even_odd_i,            // ROIC even/odd signal
    output logic                    readout_wait,               // Readout start signal
    output logic                    state_exit_flag_o,          // Exit state signal
    output logic                    aed_detect_skip_oe_o,       // AED detect skip output enable

    // FSM State and Status Outputs
    output logic [3:0]              current_state_o,            // Current FSM state
    output logic                    busy_o,                     // FSM busy indicator
    output logic                    sequence_done_o,            // Sequence completion flag

    // Command Enable Outputs
    output logic                    reset_state_o,              // Reset state enable
    output logic                    wait_o,                     // Wait state enable
    output logic                    bias_enable_o,              // Back bias state enable
    output logic                    flush_enable_o,             // Flush state enable
    output logic                    expose_enable_o,            // Expose time state enable
    output logic                    readout_enable_o,           // Readout state enable
    output logic                    aed_enable_o,               // AED detect state enable
    output logic                    stv_mask_o,                 // stv mask enable active hign
    output logic                    csi_mask_o,                 // csi mask enable active low
    output logic                    panel_stable_o,             // panel stable signal active high
    output logic                    iterate_exist_o,            // Indicate if iterate command exists
    output logic                    idle_elable_o,              // Idle state enable

    // Current Command Parameters
    output logic [2:0]              acq_mode_o,
    output logic [31:0]             expose_size_o,
    output logic [31:0]             active_repeat_count_o,     // Current repeat count
    output logic [31:0]             current_repeat_count_o,     // Current repeat count
    output logic [18:0]             current_data_length_o,      // Current data length
    output logic                    current_eof_o,              // Current EOF flag
    output logic                    current_sof_o               // Current SOF flag
);

    // State machine states (4-bit enum to match external state bus width)
    typedef enum logic [3:0] {
        RST        = 4'd0,
        WAIT       = 4'd1,
        BACK_BIAS  = 4'd2,
        FLUSH      = 4'd3,
        AED_DETECT = 4'd4,
        EXPOSE_TIME= 4'd5,
        READOUT    = 4'd6,
        IDLE       = 4'd7
    } state_type;
    state_type state = IDLE;                // Current state of the state machine

//    // FSM State Definitions
//    localparam logic [2:0] RST          = 3'd0;     // Reset state
//    localparam logic [2:0] WAIT         = 3'd1;     // Wait state
//    localparam logic [2:0] BACK_BIAS    = 3'd2;     // Back bias state
//    localparam logic [2:0] FLUSH        = 3'd3;     // Flush state
//    localparam logic [2:0] AED_DETECT   = 3'd4;     // AED detect state
//    localparam logic [2:0] EXPOSE_TIME  = 3'd5;     // Expose time state
//    localparam logic [2:0] READOUT      = 3'd6;     // Readout state
//    localparam logic [2:0] IDLE         = 3'd7;     // Idle state

    // internal signal latch
    logic [7:0]     s_lut_addr_i;
    logic           s_lut_wen_i;                  // LUT Write Enable
    logic [51:0]    s_lut_write_data_i;           // Data to write to LUT RAM
    logic [51:0]    s_lut_write_data_i_1d;           // Data to write to LUT RAM
//    logic           s_lut_rden_i;                 // LUT Read Enable
    logic [63:0]    s_lut_read_data_o;            // Data read from LUT RAM

    logic           s_config_done_i;              // Configuration done signal
    logic [1:0]     s_config_done_dly;            // Configuration done signal
    logic           s_config_done_hi;             // Config done rising edge detector

    // (* mark_debug="true" *) 
    logic           s_exit_signal_i;              // Exit signal to stop sequence
    logic           s_iterate_exit_flag;          // Exit flag for iterate command
    logic           s_state_exit_mux;             // Exit mux for current state
    logic           s_state_exit_flag;            // Exit flag for current state

    logic [31:0]    s_expose_size_i;
    logic [2:0]     s_acq_mode_i;

    logic           s_readout_wait;
    logic           s_idle_wait;

    // FSM Internal Registers
    logic           fsm_rst;                     // FSM reset signal
    logic           s_lut_addr_rst;

    state_type      current_state_reg;           // Current state register (enum)
    // logic [7:0]     lut_addr_reg;                // LUT address register
    logic [7:0]     s_lut_wr_addr_reg;            // LUT write address register
    logic [7:0]     s_lut_rd_addr_reg;            // LUT read address register

    logic [7:0]     read_addr_reg;                // LUT address register
    logic [7:0]     next_addr_reg;               // Next address register
    logic [31:0]    active_repeat_count;         // Active repeat counter
    logic [31:0]    current_repeat_count;         // Active repeat counter
    logic [18:0]    data_length_reg;             // Data length register
    logic [18:0]    data_length_timer;           // Data length timer
    logic           sequence_done_reg;           // Sequence done register
    logic [0:0]     current_sof_reg;             // Current SOF register
    logic [0:0]     current_eof_reg;             // Current EOF register

//    logic           data_length_timer_end;        // Data length timer end flag

    logic [11:0]    s_iterate_count;              // Iterate count register
    logic [11:0]    s_iterate_count_selected;        // Selected iterate count
    logic [11:0]    s_iterate_count_index[3:0];  // Iterate count index for each command
    logic           s_iterate_count_zero;

    // LUT RAM Read Data Fields
    logic [1:0]     read_iterate_index;
    logic [0:0]     read_iterate;
    logic [1:0]     s_read_iterate_dly;
    logic [0:0]     read_panel_stable;
    logic [0:0]     read_csi_mask;
    logic [0:0]     read_stv_mask;
    logic [3:0]     read_next_state;             // Next state from LUT
    logic [31:0]    read_repeat_count;           // Repeat count from LUT
    logic [18:0]    read_data_length;            // Data length from LUT
    logic [0:0]     read_sof;                    // SOF flag from LUT
    logic [0:0]     read_eof;                    // EOF flag from LUT
    logic [7:0]     read_next_address;           // Next address from LUT
    logic [51:0]    lut_read_data_int;           // Internal LUT read data

    // LUT RAM control signals
    logic [7:0]     s_lut_wr_addr;
    logic [7:0]     s_lut_rd_addr;
    logic [51:0]    s_lut_rd_data;
    logic [51:0]    s_lut_wr_data;
    logic           s_lut_wr_enable;
    logic [1:0]     s_lut_wen_dly;
//    logic [1:0]     s_lut_rden_dly;

    logic s_state_rst;
    logic s_state_wait;
    logic s_state_back_bias;
    logic s_state_flush;
    logic s_state_aed_detect;
    logic s_state_expose_time;
    logic s_state_readout;
    logic s_state_idle;

    
    // LUT RAM Field Assignments

    assign read_iterate_index   = lut_read_data_int[51:50];
    assign read_iterate         = lut_read_data_int[49];
    assign read_panel_stable    = lut_read_data_int[48];
    assign read_csi_mask        = lut_read_data_int[47];
    assign read_stv_mask        = lut_read_data_int[46];
    assign read_sof             = lut_read_data_int[45];
    assign read_eof             = lut_read_data_int[44];
    assign read_next_state      = lut_read_data_int[43:40];
    assign read_next_address    = {s_acq_mode_i,lut_read_data_int[36:32]};
    assign read_repeat_count    = (read_next_state==EXPOSE_TIME) ? s_expose_size_i : {16'd0,lut_read_data_int[31:16]};
    assign read_data_length     = (read_next_state==EXPOSE_TIME) ? {lut_read_data_int[15:0],3'd0} : {3'd0,lut_read_data_int[15:0]};

    // Output Assignments
    assign current_state_o          = current_state_reg;
    assign busy_o                   = (current_state_reg != RST && current_state_reg != IDLE) ? 1'b1 : 1'b0;
    assign current_repeat_count_o   = current_repeat_count;
    assign active_repeat_count_o    = active_repeat_count;
    assign current_data_length_o    = data_length_timer;
    assign acq_mode_o               = s_acq_mode_i;
    assign expose_size_o            = s_expose_size_i;

    // State Enable Outputs
    assign s_state_rst          = (current_state_reg == RST)            ? 1'b1 : 1'b0;
    assign s_state_wait         = (current_state_reg == WAIT)           ? 1'b1 : 1'b0;
    assign s_state_back_bias    = (current_state_reg == BACK_BIAS)      ? 1'b1 : 1'b0;
    assign s_state_flush        = (current_state_reg == FLUSH)          ? 1'b1 : 1'b0;
    assign s_state_expose_time  = (current_state_reg == EXPOSE_TIME)    ? 1'b1 : 1'b0;
    assign s_state_readout      = (current_state_reg == READOUT)        ? 1'b1 : 1'b0;
    assign s_state_aed_detect   = (current_state_reg == AED_DETECT)     ? 1'b1 : 1'b0;
    assign s_state_idle         = (current_state_reg == IDLE)           ? 1'b1 : 1'b0;

    // FSM Reset Logic
    // assign fsm_rst = (reset_i || (s_config_done_dly == 2'b01))  ? 1'b1 : 1'b0;
    assign fsm_rst              = (reset_i || (s_config_done_dly[0]))  ? 1'b1 : 1'b0;
    assign s_config_done_hi     = (s_config_done_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_lut_addr_rst       = (reset_i || s_config_done_hi) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or posedge reset_i) begin
        if (reset_i) begin
            reset_state_o           <= 1'b0;
            wait_o                  <= 1'b0;
            bias_enable_o           <= 1'b0;
            flush_enable_o          <= 1'b0;
            expose_enable_o         <= 1'b0;
            readout_enable_o        <= 1'b0;
            aed_enable_o            <= 1'b0;
            idle_elable_o           <= 1'b0;
        end else begin
            reset_state_o           <= s_state_rst;
            wait_o                  <= s_state_wait;
            bias_enable_o           <= s_state_back_bias;
            flush_enable_o          <= s_state_flush;
            expose_enable_o         <= s_state_expose_time;
            readout_enable_o        <= s_state_readout;
            aed_enable_o            <= s_state_aed_detect;
            idle_elable_o           <= s_state_idle;
        end
    end

    always_ff @(posedge clk or posedge reset_i) begin
        if (reset_i) begin
            s_lut_wen_i             <= 1'b0;
//            s_lut_rden_i            <= 1'b0;
            s_lut_addr_i            <= '0;
            s_lut_write_data_i      <= '0;
            s_lut_write_data_i_1d   <= '0;
            s_config_done_i         <= 1'b0;
            s_expose_size_i         <= '0;
            s_acq_mode_i            <= 3'b111;
            // output
            lut_read_data_o         <= '0;
            sequence_done_o         <= 1'b0;
            current_eof_o           <= 1'b0;
            current_sof_o           <= 1'b0;
            s_config_done_dly       <= 2'b0;
//            s_lut_rden_dly          <= 2'b0;
            s_lut_wen_dly           <= 2'b0;
            //
            s_read_iterate_dly      <= 2'b0;
        end else begin
            s_lut_addr_i            <= lut_addr_i;
            s_lut_wen_i             <= lut_wen_i;
//            s_lut_rden_i            <= lut_rden_i;
            s_lut_write_data_i      <= lut_write_data_i[51:0];
            s_lut_write_data_i_1d   <= s_lut_write_data_i;
            // output
            lut_read_data_o         <= s_lut_read_data_o;            
            sequence_done_o         <= sequence_done_reg;
            current_eof_o           <= current_eof_reg[0];
            current_sof_o           <= current_sof_reg[0];
            s_config_done_dly       <= {s_config_done_dly[0],s_config_done_i};
//            s_lut_rden_dly          <= {s_lut_rden_dly[0],s_lut_rden_i};
            s_lut_wen_dly           <= {s_lut_wen_dly[0],s_lut_wen_i};

            s_read_iterate_dly      <= {s_read_iterate_dly[0],read_iterate};

            s_config_done_i         <= config_done_i;
            
            if (s_config_done_dly == 2'b11) begin
                s_acq_mode_i        <= acq_mode_i;
            end
            
            s_expose_size_i     <= expose_size_i;
        end
    end

    // Main FSM State Machine
    always_ff @(posedge clk or posedge fsm_rst) begin
        if (fsm_rst) begin
            current_state_reg       <= RST;
            current_repeat_count     <= 32'd0;
            active_repeat_count     <= 32'd0;
            data_length_reg         <= 19'd0;
            data_length_timer       <= 19'd0;
//            data_length_timer_end   <= 1'b0;
            s_readout_wait         <= 1'b0;
            stv_mask_o              <= 1'b0;
            csi_mask_o              <= 1'b0;
            panel_stable_o          <= 1'b0;
            iterate_exist_o         <= 1'b0;
        end else begin
            // Decrement data length timer in command states
            if ((current_state_reg != RST && current_state_reg != IDLE) && 
                data_length_timer > 0) begin
                data_length_timer   <= data_length_timer - 1;
            end

            // FSM State Transitions
            case (current_state_reg)
                RST: begin
                    // Stay in RST until config_done_i is asserted
                    // if (s_config_done_i) begin
                    if (s_config_done_dly[0]) begin
                        current_state_reg <= RST;
                    end else if (data_length_timer == 0) begin
                        current_state_reg <= IDLE;
                    end else begin
                        data_length_timer <= data_length_timer - 1;
                    end
                end

                // Command States: Handle repeat and timer
                WAIT, BACK_BIAS, FLUSH, AED_DETECT, EXPOSE_TIME, READOUT: begin
                    if (data_length_timer == 0) begin
                        if (active_repeat_count > 0) begin
                            // Repeat current command
                            active_repeat_count <= active_repeat_count - 1;
                            data_length_timer   <= data_length_reg;
                        end else begin
                            // Command complete, go to IDLE
                            current_state_reg <= IDLE;
                        end
                        
//                        data_length_timer_end <= 1'b1;
//                    end else begin
//                        data_length_timer_end <= 1'b0;
                    end
                end

                IDLE: begin

                    if (read_next_state == READOUT && roic_even_odd_i == 1'b0) begin
                        current_state_reg       <= current_state_reg;
                        current_repeat_count    <= current_repeat_count;
                        active_repeat_count     <= active_repeat_count;
                        data_length_reg         <= data_length_reg;
                        data_length_timer       <= data_length_timer;
//                        data_length_timer_end   <= data_length_timer_end;
                        stv_mask_o             <= stv_mask_o;
                        csi_mask_o             <= csi_mask_o;
                        panel_stable_o         <= panel_stable_o;
                        iterate_exist_o        <= iterate_exist_o;
                        s_readout_wait         <= 1'b1;
                    end else begin
                        // Stay in IDLE, update address for next command
                        current_state_reg       <= state_type'(read_next_state);
                        current_repeat_count    <= read_repeat_count;
                        active_repeat_count     <= read_repeat_count;
                        data_length_reg         <= read_data_length;
                        data_length_timer       <= read_data_length;
//                        data_length_timer_end   <= 1'b0;
                        stv_mask_o             <= read_stv_mask;
                        csi_mask_o             <= read_csi_mask;
                        panel_stable_o         <= read_panel_stable;
                        iterate_exist_o        <= read_iterate;
                        s_readout_wait         <= 1'b0;
                    end
                end

                default: begin
                    // Invalid state, go to IDLE
                    current_state_reg   <= IDLE;
                end
            endcase
        end
    end

    always_ff @(posedge clk or posedge fsm_rst) begin
        if (fsm_rst) begin
            s_iterate_exit_flag <= 1'b0;
            s_iterate_count   <= 12'd0;
        end else begin
            if (!read_iterate) begin
                s_iterate_exit_flag   <= 1'b0;
            end else if (current_state_reg == IDLE && !s_idle_wait) begin
                if (current_sof_reg && s_iterate_count == 12'd0) begin
                    s_iterate_exit_flag <= 1'b1;
                end
            end

            if (!s_read_iterate_dly[0]) begin
                s_iterate_count  <= s_iterate_count_selected;
            end else if (current_state_reg == IDLE && !s_idle_wait) begin
                if (current_eof_reg && s_iterate_count > 12'd0) begin
                    s_iterate_count       <= s_iterate_count - 1'b1;
                end
            end

        end
    end

    assign s_idle_wait = s_readout_wait;

    always_ff @(posedge clk or posedge fsm_rst) begin
        if (fsm_rst) begin
            current_eof_reg     <= 1'b0;
            current_sof_reg     <= 1'b0;
            next_addr_reg       <= 8'd0;
            sequence_done_reg   <= 1'b0;
            s_exit_signal_i     <= 1'b0;
            s_state_exit_flag   <= 1'b0;
        end else begin
            
            s_exit_signal_i     <= (exit_signal_i & !panel_stable_o);

            // if (current_state_reg == IDLE) begin
            if (current_state_reg == IDLE && !s_idle_wait) begin
                if (current_eof_reg) begin
                    if (s_state_exit_flag) begin
                        // Exit signal active: increment address and assert sequence_done
                        next_addr_reg       <= next_addr_reg + 1'b1;
                        // sequence_done_reg   <= 1'b1;
                        s_state_exit_flag     <= 1'b0;
                    end else begin
                        // Normal operation: use next_address from LUT
                        next_addr_reg       <= read_next_address;
                        // sequence_done_reg   <= 1'b0;
                    end
                
                end else if (s_idle_wait) begin
                    next_addr_reg   <= next_addr_reg;
                end else begin
                    next_addr_reg   <= read_next_address;
                end

                current_eof_reg     <= read_eof;
                current_sof_reg     <= read_sof;

            end else begin
                s_state_exit_flag     <= s_state_exit_mux;
            end

            if (current_sof_reg) begin
                sequence_done_reg   <= 1'b1;
            end else if (current_eof_reg) begin
                sequence_done_reg   <= 1'b0;
            end
            
        end
    end

    assign s_state_exit_mux = (s_exit_signal_i || s_iterate_exit_flag) ? 1'b1 : 1'b0;
    assign state_exit_flag_o    = s_iterate_count_zero;
    assign s_iterate_count_zero = (s_iterate_count == 12'd0) ? 1'b1 : 1'b0;
    assign aed_detect_skip_oe_o  = (current_state_reg == AED_DETECT && s_exit_signal_i) ? 1'b1 : 1'b0;

    // LUT RAM Write/Read Control (RST state only)
    always_ff @(posedge clk or posedge s_lut_addr_rst) begin
        if (s_lut_addr_rst) begin
            s_lut_wr_addr_reg    <= ({s_acq_mode_i,5'h1F});
            read_addr_reg   <= 8'd0;
        end else begin
            if (s_config_done_dly[0] && current_state_reg == RST) begin
                s_lut_wr_addr_reg    <= s_lut_addr_i;
            end else if (s_idle_wait==1'b0) begin
                read_addr_reg    <= next_addr_reg;
            end
        end
    end

    assign s_lut_rd_addr_reg = (s_config_done_dly==2'b10) ? ({s_acq_mode_i,5'h1F}) : s_lut_wr_addr_reg;

    seq_lut seq_table_inst (
    .a          (s_lut_wr_addr),
    .d          (s_lut_wr_data),
    .dpra       (s_lut_rd_addr),
    .clk        (clk),
    .we         (s_lut_wr_enable),
    .dpo        (s_lut_rd_data)
    );
    
    assign s_lut_wr_addr        = (s_config_done_dly[1]) ? s_lut_wr_addr_reg : 8'hFF;
    assign s_lut_rd_addr        = (s_config_done_dly[1]) ? s_lut_rd_addr_reg : read_addr_reg;

    assign s_lut_wr_enable      = ((s_config_done_i) && s_lut_wen_dly == 2'b10) ? 1'b1 : 1'b0;
    assign s_lut_wr_data        = s_lut_write_data_i_1d;

//    assign s_lut_read_data_o    = (s_config_done_i) ? {12'd0,s_lut_rd_data[51:0]} : 64'd0;
    assign s_lut_read_data_o    = (s_config_done_i) ? {lut_write_data_i[63:52],s_lut_rd_data[51:0]} : 64'd0;
    

   // LUT RAM Read Data Assignment
    assign lut_read_data_int = s_lut_rd_data;

    // debug output
    assign readout_wait = s_readout_wait;

    always_ff @(posedge clk or posedge reset_i) begin
        if (reset_i) begin
            s_iterate_count_index <= '{4{12'd0}};
        end else begin
            if (s_config_done_dly == 2'd2) begin
                s_iterate_count_index[3] <= s_lut_rd_data[47:36];
                s_iterate_count_index[2] <= s_lut_rd_data[35:24];
                s_iterate_count_index[1] <= s_lut_rd_data[23:12];
                s_iterate_count_index[0] <= s_lut_rd_data[11:0];
            end
        end
    end

    always_ff @(posedge clk or posedge fsm_rst) begin
        if (fsm_rst) begin
            s_iterate_count_selected <= 12'd0;
        end else begin
            if (current_state_reg==WAIT && !read_iterate) begin
                case (read_iterate_index)
                    2'd0: begin s_iterate_count_selected <= s_iterate_count_index[0]; end
                    2'd1: begin s_iterate_count_selected <= s_iterate_count_index[1]; end
                    2'd2: begin s_iterate_count_selected <= s_iterate_count_index[2]; end
                    2'd3: begin s_iterate_count_selected <= s_iterate_count_index[3]; end
                    default: begin s_iterate_count_selected <= 12'd0; end
                endcase
            end
        end
    end

    // // for debug whith ila
    // (* mark_debug="true" *) logic [3:0]     dbg_current_state_reg;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count_selected;
    // (* mark_debug="true" *) logic [1:0]     dbg_read_iterate_index;
    // (* mark_debug="true" *) logic [7:0]     dbg_lut_addr_reg;
    // (* mark_debug="true" *) logic [11:0]    dbg_lut_rd_data;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count_index0;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count_index1;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count_index2;
    // (* mark_debug="true" *) logic [11:0]    dbg_iterate_count_index3;

    // assign dbg_current_state_reg = current_state_reg;
    // assign dbg_iterate_count     = s_iterate_count;
    // assign dbg_iterate_count_selected = s_iterate_count_selected;
    // assign dbg_read_iterate_index = read_iterate_index;
    // assign dbg_lut_addr_reg       = s_lut_rd_addr;
    // assign dbg_lut_rd_data        = s_lut_rd_data[11:0];
    // assign dbg_iterate_count_index0 = s_iterate_count_index[0];
    // assign dbg_iterate_count_index1 = s_iterate_count_index[1];
    // assign dbg_iterate_count_index2 = s_iterate_count_index[2];
    // assign dbg_iterate_count_index3 = s_iterate_count_index[3];


    // FSM State Definitions
    always_comb begin : state_label
        case (current_state_reg)
            4'd0 : begin state <= RST           ; end
            4'd1 : begin state <= WAIT  ; end
            4'd2 : begin state <= BACK_BIAS     ; end
            4'd3 : begin state <= FLUSH         ; end
            4'd4 : begin state <= AED_DETECT    ; end
            4'd5 : begin state <= EXPOSE_TIME   ; end
            4'd6 : begin state <= READOUT       ; end
            4'd7 : begin state <= IDLE          ; end
//            default : begin state <= UNKOWN8    ; end
        endcase
    end
    
endmodule