//==============================================================================
// reg_map.sv - Register Map Module
//==============================================================================
// BRAM-based register architecture for P&R optimization
// - 511:0x16 register_memory array using Block RAM
// - Separate write (eim_clk) and read buffer (eim_clk/fsm_clk) logic
// - Simple default case for most registers, special handling for RO/calculated
//==============================================================================

`include "./p_define.sv"
`timescale 1ns/1ps

module reg_map (
    //==========================================================================
    // Clocks & Resets
    //==========================================================================
    input  wire         eim_clk,            // 100MHz - Register interface
    input  wire         eim_rst,
    input  wire         fsm_clk,            // 20MHz - FSM domain
    input  wire         rst,

    //==========================================================================
    // FSM State Inputs
    //==========================================================================
    input  wire         fsm_rst_index,
    input  wire         fsm_init_index,
    input  wire         fsm_back_bias_index,
    input  wire         fsm_flush_index,
    input  wire         fsm_aed_read_index,
    input  wire         fsm_exp_index,
    input  wire         fsm_read_index,
    input  wire         fsm_idle_index,

    //==========================================================================
    // System Status Inputs
    //==========================================================================
    input  wire         ready_to_get_image,
    input  wire         aed_ready_done,
    input  wire         panel_stable_exist,
    input  wire         exp_read_exist,
    input  wire         exp_req,

    //==========================================================================
    // Register Access Interface
    //==========================================================================
    input  wire         reg_read_index,     // Read enable
    input  wire [15:0]  reg_addr,
    input  wire [15:0]  reg_data,
    input  wire         reg_data_index,     // Write strobe

    //==========================================================================
    // Register Read Outputs
    //==========================================================================
    output logic [15:0] reg_read_out,
    output logic        read_data_en,

    //==========================================================================
    // External Interfaces
    //==========================================================================
    input  wire [63:0]  seq_lut_read_data,
    input  wire [15:0]  seq_state_read,

    //==========================================================================
    // System Control Outputs
    //==========================================================================
    output logic        system_rst,
    output logic        org_reset_fsm,
    output logic        reset_fsm,
    output logic        en_pwr_dwn,
    output logic        en_pwr_off,

    // CSI2
    output logic [15:0] max_v_count,
    output logic [15:0] max_h_count,
    output logic [15:0] csi2_word_count,

    // TI ROIC Basic
    output logic        ti_roic_sync,
    output logic        ti_roic_tp_sel,
    output logic [1:0]  ti_roic_str,
    output logic [15:0] ti_roic_reg_addr,
    output logic [15:0] ti_roic_reg_data,

    // TI ROIC Deserializer
    output logic        ti_roic_deser_reset,
    output logic        ti_roic_deser_dly_tap_ld,
    output logic [4:0]  ti_roic_deser_dly_tap_in,
    output logic        ti_roic_deser_dly_data_ce,
    output logic        ti_roic_deser_dly_data_inc,
    output logic        ti_roic_deser_align_mode,
    output logic        ti_roic_deser_align_start,
    output logic [4:0]  ti_roic_deser_shift_set[`NUM_ROIC-1:0],
    input  wire  [4:0]  ti_roic_deser_align_shift[`NUM_ROIC-1:0],
    input  wire  [`NUM_ROIC-1:0] ti_roic_deser_align_done,

    // Back Bias
    output logic [15:0] up_back_bias,
    output logic [15:0] dn_back_bias,

    // Sequence LUT
    output logic [7:0]  seq_lut_addr,
    output logic [63:0] seq_lut_data,
    output logic        seq_lut_wr_en,
    output logic [15:0] seq_lut_control,
    output logic        seq_lut_config_done,

    // Acquisition
    output logic [2:0]  acq_mode,
    output logic [31:0] acq_expose_size,
    output logic [15:0] dsp_image_height,

    // Image Commands
    output logic        get_dark,
    output logic        get_bright,
    output logic        cmd_get_bright,
    output logic        dummy_get_image,
    output logic        burst_get_image,

    // OP_MODE_REG Bits
    output logic        en_panel_stable,
    output logic        en_16bit_adc,
    output logic        en_test_pattern_col,
    output logic        en_test_pattern_row,
    output logic        en_test_roic_col,
    output logic        en_test_roic_row,

    // Exposure Ack
    output logic        exp_ack,

    // GATE Control
    output logic        gate_mode1,
    output logic        gate_mode2,
    output logic        gate_cs1,
    output logic        gate_cs2,
    output logic        gate_sel,
    output logic        gate_ud,
    output logic        gate_stv_mode,
    output logic        gate_oepsn,
    output logic        gate_lr1,
    output logic        gate_lr2,
    output logic        stv_sel_h,
    output logic        stv_sel_l1,
    output logic        stv_sel_r1,
    output logic        stv_sel_l2,
    output logic        stv_sel_r2,
    output logic [15:0] dn_aed_gate_xao [0:5],
    output logic [15:0] up_aed_gate_xao [0:5],

    output logic [7:0]  state_led_ctr
);

    //==========================================================================
    // Internal Signals
    //==========================================================================

    // BRAM Register Memory (saves ~8K FFs, uses 1 BRAM36)
    (* ram_style = "block" *) logic [15:0] register_memory [0:`MAX_ADDR-1];

    logic [15:0] current_reg_addr;
    logic [15:0] s_reg_read_out_tmp0;

    logic [15:0] s_state_led_ctr;

    // FPGA Version
    logic [31:0] FPGA_VER_DATA, s_fpga_ver_data;
    logic        CFGCLK, DATAVALID;

    // FSM State
    logic [7:0]  fsm_reg;

    // System Control
    logic [15:0] reg_sys_cmd_reg;
    logic        sig_reset_fsm_1d, hi_reset_fsm, lo_reset_fsm;
    logic [15:0] reg_pwr_off_dwn;

    // CSI2
    logic [15:0] reg_max_v_count, reg_max_h_count, reg_csi2_word_count;

    // TI ROIC
    logic [15:0] reg_ti_roic_sync, reg_ti_roic_tp_sel, reg_ti_roic_str;
    logic [15:0] reg_ti_roic_reg_addr, reg_ti_roic_reg_data;
    logic [15:0] reg_ti_roic_deser_reset, reg_ti_roic_deser_dly_tap_ld;
    logic [15:0] reg_ti_roic_deser_dly_tap_in, reg_ti_roic_deser_dly_data_ce;
    logic [15:0] reg_ti_roic_deser_dly_data_inc, reg_ti_roic_deser_align_mode;
    logic [15:0] reg_ti_roic_deser_align_start;
    logic [15:0] reg_ti_roic_deser_shift_set[`NUM_ROIC-1:0];
    logic [15:0] reg_ti_roic_deser_align_shift[`NUM_ROIC-1:0];
    logic [15:0] reg_ti_roic_deser_align_done;

    // Sequence LUT
    logic [7:0]  reg_seq_lut_addr;
    logic [15:0] reg_seq_lut_data_0, reg_seq_lut_data_1;
    logic [15:0] reg_seq_lut_data_2, reg_seq_lut_data_3;
    logic [15:0] reg_seq_lut_control;
    logic        seq_lut_data_wr_pulse;
    logic [15:0] reg_seq_state_read;

    // Acquisition
    logic [2:0]  reg_acq_mode;
    logic [15:0] reg_expose_size;
    logic [15:0] reg_pre_delay;
    logic [15:0] reg_post_delay;
    logic [17:0] tmp_expose_size;
    logic [15:0] reg_dsp_image_height;

    // Back Bias
    logic [15:0] reg_up_back_bias, reg_dn_back_bias;

    // Image Command
    logic [15:0] reg_op_mode_reg;
    logic        sig_get_bright, soft_trigger, sig_trigger;

    // GATE Control
    logic [15:0] reg_set_gate;

    logic [15:0] dn_aed_gate_xao_0, dn_aed_gate_xao_1, dn_aed_gate_xao_2;
    logic [15:0] dn_aed_gate_xao_3, dn_aed_gate_xao_4, dn_aed_gate_xao_5;
    logic [15:0] up_aed_gate_xao_0, up_aed_gate_xao_1, up_aed_gate_xao_2;
    logic [15:0] up_aed_gate_xao_3, up_aed_gate_xao_4, up_aed_gate_xao_5;

    //==========================================================================
    // Register Memory Initialization
    //==========================================================================
    `ifndef SYNTHESIS
    initial begin
        integer i;
        for (i = 0; i < `MAX_ADDR; i = i + 1) register_memory[i] = 16'd0;
    end
    `endif

    //==========================================================================
    // Output Assignments
    //==========================================================================
    assign current_reg_addr = reg_addr[15:0];
    assign reg_read_out     = s_reg_read_out_tmp0;

    assign s_state_led_ctr  = register_memory[`ADDR_STATE_LED_CTR];
    assign state_led_ctr    = s_state_led_ctr[7:0];

    // System Control
    assign reg_sys_cmd_reg  = register_memory[`ADDR_SYS_CMD_REG];
    assign system_rst       = reg_sys_cmd_reg[4];
    assign org_reset_fsm    = reg_sys_cmd_reg[0];
    assign hi_reset_fsm     = org_reset_fsm && (~sig_reset_fsm_1d);
    assign lo_reset_fsm     = (~org_reset_fsm) && sig_reset_fsm_1d;
    assign en_pwr_dwn       = reg_pwr_off_dwn[0];
    assign en_pwr_off       = reg_pwr_off_dwn[1];

    // CSI2
    assign max_v_count      = reg_max_v_count;
    assign max_h_count      = reg_max_h_count;
    assign csi2_word_count  = reg_csi2_word_count;

    // TI ROIC Basic
    assign ti_roic_sync     = reg_ti_roic_sync[0];
    assign ti_roic_tp_sel   = reg_ti_roic_tp_sel[0];
    assign ti_roic_str      = reg_ti_roic_str[1:0];
    assign ti_roic_reg_addr = reg_ti_roic_reg_addr;
    assign ti_roic_reg_data = reg_ti_roic_reg_data;

    // Sequence LUT
    assign seq_lut_addr     = reg_seq_lut_addr;
    assign seq_lut_data     = {reg_seq_lut_data_3, reg_seq_lut_data_2,
                               reg_seq_lut_data_1, reg_seq_lut_data_0};
    assign seq_lut_wr_en    = seq_lut_data_wr_pulse;
    assign seq_lut_control  = reg_seq_lut_control;
    assign seq_lut_config_done = reg_seq_lut_control[0];

    // Acquisition
    assign acq_mode         = reg_acq_mode;
    assign acq_expose_size  = {14'd0, tmp_expose_size};
    assign dsp_image_height = reg_dsp_image_height;

    // TI ROIC Deserializer
    assign ti_roic_deser_reset          = reg_ti_roic_deser_reset[0];
    assign ti_roic_deser_dly_tap_ld     = reg_ti_roic_deser_dly_tap_ld[0];
    assign ti_roic_deser_dly_tap_in     = reg_ti_roic_deser_dly_tap_in[4:0];
    assign ti_roic_deser_dly_data_ce    = reg_ti_roic_deser_dly_data_ce[0];
    assign ti_roic_deser_dly_data_inc   = reg_ti_roic_deser_dly_data_inc[0];
    assign ti_roic_deser_align_mode     = reg_ti_roic_deser_align_mode[0];
    assign ti_roic_deser_align_start    = reg_ti_roic_deser_align_start[0];
    assign ti_roic_deser_shift_set[0]   = reg_ti_roic_deser_shift_set[0][4:0];
    assign ti_roic_deser_shift_set[1]   = reg_ti_roic_deser_shift_set[1][4:0];
    assign ti_roic_deser_shift_set[2]   = reg_ti_roic_deser_shift_set[2][4:0];
    assign ti_roic_deser_shift_set[3]   = reg_ti_roic_deser_shift_set[3][4:0];
    assign ti_roic_deser_shift_set[4]   = reg_ti_roic_deser_shift_set[4][4:0];
    assign ti_roic_deser_shift_set[5]   = reg_ti_roic_deser_shift_set[5][4:0];
    assign ti_roic_deser_shift_set[6]   = reg_ti_roic_deser_shift_set[6][4:0];
    assign ti_roic_deser_shift_set[7]   = reg_ti_roic_deser_shift_set[7][4:0];
    assign ti_roic_deser_shift_set[8]   = reg_ti_roic_deser_shift_set[8][4:0];
    assign ti_roic_deser_shift_set[9]   = reg_ti_roic_deser_shift_set[9][4:0];
    assign ti_roic_deser_shift_set[10]  = reg_ti_roic_deser_shift_set[10][4:0];
    assign ti_roic_deser_shift_set[11]  = reg_ti_roic_deser_shift_set[11][4:0];
    assign ti_roic_deser_shift_set[12]  = reg_ti_roic_deser_shift_set[12][4:0];
    assign ti_roic_deser_shift_set[13]  = reg_ti_roic_deser_shift_set[13][4:0];

    // Back Bias
    assign up_back_bias = reg_up_back_bias;
    assign dn_back_bias = reg_dn_back_bias;

    // Image Command
    assign sig_get_bright   = reg_sys_cmd_reg[2];
    assign soft_trigger     = reg_sys_cmd_reg[3];   // Bit 3: soft trigger

    // Image command outputs
    assign get_dark         = reg_sys_cmd_reg[1];   // Bit 1: Direct output
    assign dummy_get_image  = reg_sys_cmd_reg[8];   // Bit 8: Direct output
    assign burst_get_image  = reg_op_mode_reg[8];   // Bit 8 of OP_MODE_REG
    assign get_bright       = (sig_trigger & (~register_memory[`ADDR_AED_CMD][0])) |
                                (sig_get_bright & (register_memory[`ADDR_AED_CMD][0]));
    assign cmd_get_bright   = sig_get_bright & soft_trigger;

    //==========================================================================
    // OP_MODE_REG Signal Assignments
    //==========================================================================
    assign en_panel_stable      = reg_op_mode_reg[1];   // Bit 1
    assign en_16bit_adc         = reg_op_mode_reg[2];   // Bit 2
    assign en_test_pattern_col  = reg_op_mode_reg[3];   // Bit 3
    assign en_test_pattern_row  = reg_op_mode_reg[4];   // Bit 4
    assign en_test_roic_col     = reg_op_mode_reg[5];   // Bit 5
    assign en_test_roic_row     = reg_op_mode_reg[6];   // Bit 6

    //==========================================================================
    // Switch Sync Signal Assignment
    //==========================================================================
    assign exp_ack = ~exp_req;  // Simple inversion

    //==========================================================================
    // GATE Control Signal Assignments
    //==========================================================================
    assign gate_mode1       = reg_set_gate[0];
    assign gate_mode2       = reg_set_gate[1];
    assign gate_cs1         = reg_set_gate[2];
    assign gate_cs2         = reg_set_gate[3];
    assign gate_sel         = reg_set_gate[4];
    assign gate_ud          = reg_set_gate[5];
    assign gate_stv_mode    = reg_set_gate[6];
    assign gate_oepsn       = reg_set_gate[7];
    assign gate_lr1         = reg_set_gate[8];
    assign gate_lr2         = reg_set_gate[9];
    assign stv_sel_h        = reg_set_gate[11];
    assign stv_sel_l1       = reg_set_gate[12];
    assign stv_sel_r1       = reg_set_gate[13];
    assign stv_sel_l2       = reg_set_gate[14];
    assign stv_sel_r2       = reg_set_gate[15];
    // assign gate_gpio_data   = register_memory[`ADDR_GATE_GPIO_REG];

    //==========================================================================
    // AED Gate XAO Signal Assignments (eim_clk domain)
    //==========================================================================
    // assign dn_aed_gate_xao_0 = register_memory[`ADDR_DN_AED_GATE_XAO_0];
    // assign dn_aed_gate_xao_1 = register_memory[`ADDR_DN_AED_GATE_XAO_1];
    // assign dn_aed_gate_xao_2 = register_memory[`ADDR_DN_AED_GATE_XAO_2];
    // assign dn_aed_gate_xao_3 = register_memory[`ADDR_DN_AED_GATE_XAO_3];
    // assign dn_aed_gate_xao_4 = register_memory[`ADDR_DN_AED_GATE_XAO_4];
    // assign dn_aed_gate_xao_5 = register_memory[`ADDR_DN_AED_GATE_XAO_5];
    // assign up_aed_gate_xao_0 = register_memory[`ADDR_UP_AED_GATE_XAO_0];
    // assign up_aed_gate_xao_1 = register_memory[`ADDR_UP_AED_GATE_XAO_1];
    // assign up_aed_gate_xao_2 = register_memory[`ADDR_UP_AED_GATE_XAO_2];
    // assign up_aed_gate_xao_3 = register_memory[`ADDR_UP_AED_GATE_XAO_3];
    // assign up_aed_gate_xao_4 = register_memory[`ADDR_UP_AED_GATE_XAO_4];
    // assign up_aed_gate_xao_5 = register_memory[`ADDR_UP_AED_GATE_XAO_5];

    assign {
        dn_aed_gate_xao[0], dn_aed_gate_xao[1], dn_aed_gate_xao[2],
        dn_aed_gate_xao[3], dn_aed_gate_xao[4], dn_aed_gate_xao[5]
    } = {
        dn_aed_gate_xao_0, dn_aed_gate_xao_1, dn_aed_gate_xao_2,
        dn_aed_gate_xao_3, dn_aed_gate_xao_4, dn_aed_gate_xao_5
    };

    assign {
        up_aed_gate_xao[0], up_aed_gate_xao[1], up_aed_gate_xao[2],
        up_aed_gate_xao[3], up_aed_gate_xao[4], up_aed_gate_xao[5]
    } = {
        up_aed_gate_xao_0, up_aed_gate_xao_1, up_aed_gate_xao_2,
        up_aed_gate_xao_3, up_aed_gate_xao_4, up_aed_gate_xao_5
    };

    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            dn_aed_gate_xao_0 <= `DEF_DN_AED_GATE_XAO_0;
            dn_aed_gate_xao_1 <= `DEF_DN_AED_GATE_XAO_1;
            dn_aed_gate_xao_2 <= `DEF_DN_AED_GATE_XAO_2;
            dn_aed_gate_xao_3 <= `DEF_DN_AED_GATE_XAO_3;
            dn_aed_gate_xao_4 <= `DEF_DN_AED_GATE_XAO_4;
            dn_aed_gate_xao_5 <= `DEF_DN_AED_GATE_XAO_5;
            up_aed_gate_xao_0 <= `DEF_UP_AED_GATE_XAO_0;
            up_aed_gate_xao_1 <= `DEF_UP_AED_GATE_XAO_1;
            up_aed_gate_xao_2 <= `DEF_UP_AED_GATE_XAO_2;
            up_aed_gate_xao_3 <= `DEF_UP_AED_GATE_XAO_3;
            up_aed_gate_xao_4 <= `DEF_UP_AED_GATE_XAO_4;
            up_aed_gate_xao_5 <= `DEF_UP_AED_GATE_XAO_5;
        end else begin
            dn_aed_gate_xao_0 <= register_memory[`ADDR_DN_AED_GATE_XAO_0];
            dn_aed_gate_xao_1 <= register_memory[`ADDR_DN_AED_GATE_XAO_1];
            dn_aed_gate_xao_2 <= register_memory[`ADDR_DN_AED_GATE_XAO_2];
            dn_aed_gate_xao_3 <= register_memory[`ADDR_DN_AED_GATE_XAO_3];
            dn_aed_gate_xao_4 <= register_memory[`ADDR_DN_AED_GATE_XAO_4];
            dn_aed_gate_xao_5 <= register_memory[`ADDR_DN_AED_GATE_XAO_5];
            up_aed_gate_xao_0 <= register_memory[`ADDR_UP_AED_GATE_XAO_0];
            up_aed_gate_xao_1 <= register_memory[`ADDR_UP_AED_GATE_XAO_1];
            up_aed_gate_xao_2 <= register_memory[`ADDR_UP_AED_GATE_XAO_2];
            up_aed_gate_xao_3 <= register_memory[`ADDR_UP_AED_GATE_XAO_3];
            up_aed_gate_xao_4 <= register_memory[`ADDR_UP_AED_GATE_XAO_4];
            up_aed_gate_xao_5 <= register_memory[`ADDR_UP_AED_GATE_XAO_5];
        end
    end

    //==========================================================================
    // FSM State Register Update (on fsm_clk domain)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            fsm_reg <= 8'd0;
        end else begin
            // Status bits [7:3]
            fsm_reg[7] <= 1'd0;                     // Reserved
            fsm_reg[6] <= panel_stable_exist;       // Panel stable
            fsm_reg[5] <= exp_read_exist;           // Exposure/Read exist
            fsm_reg[4] <= aed_ready_done;           // AED ready done
            fsm_reg[3] <= ready_to_get_image;       // Ready to get image

            // FSM state bits [2:0]
            if      (fsm_rst_index)         fsm_reg[2:0] <= 3'b000;  // RESET
            else if (fsm_init_index)        fsm_reg[2:0] <= 3'b001;  // INIT
            else if (fsm_back_bias_index)   fsm_reg[2:0] <= 3'b010;  // BACK_BIAS
            else if (fsm_flush_index)       fsm_reg[2:0] <= 3'b011;  // FLUSH
            else if (fsm_aed_read_index)    fsm_reg[2:0] <= 3'b100;  // AED_READ
            else if (fsm_exp_index)         fsm_reg[2:0] <= 3'b101;  // EXPOSURE
            else if (fsm_read_index)        fsm_reg[2:0] <= 3'b110;  // READ
            else if (fsm_idle_index)        fsm_reg[2:0] <= 3'b111;  // IDLE
        end
    end

    //==========================================================================
    // Edge Detection for reset_fsm (on fsm_clk domain)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            sig_reset_fsm_1d <= 1'b0;
        end else begin
            sig_reset_fsm_1d <= org_reset_fsm;
        end
    end

    //==========================================================================
    // reset_fsm Register Logic (on fsm_clk domain)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            reset_fsm <= 1'b1;
        end else begin
            if (lo_reset_fsm)
                reset_fsm <= 1'b0;
            else if (hi_reset_fsm)
                reset_fsm <= 1'b1;
        end
    end

    //==========================================================================
    // PWR_OFF_DWN CDC (eim_clk -> fsm_clk)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            reg_pwr_off_dwn <= `DEF_PWR_OFF_DWN;
        end else begin
            if (fsm_rst_index)
                reg_pwr_off_dwn <= register_memory[`ADDR_PWR_OFF_DWN];
        end
    end

    //==========================================================================
    // IMAGE_HEIGHT CDC (eim_clk -> fsm_clk)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            reg_dsp_image_height <= `DEF_IMAGE_HEIGHT;
        end else begin
            if (fsm_rst_index)
                reg_dsp_image_height <= register_memory[`ADDR_IMAGE_HEIGHT];
        end
    end

    //==========================================================================
    // OP_MODE_REG CDC (eim_clk -> fsm_clk)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            reg_op_mode_reg <= `DEF_OP_MODE_REG;
        end else begin
            reg_op_mode_reg <= register_memory[`ADDR_OP_MODE_REG];
        end
    end

    //==========================================================================
    // Trigger Logic (on fsm_clk domain)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            sig_trigger <= 1'b0;
        end else begin
            if (!sig_get_bright)
                sig_trigger <= 1'b0;
            else if (sig_get_bright)  // Simplified: set when get_bright active
                sig_trigger <= 1'b1;
        end
    end

    //==========================================================================
    // CSI2 Register Buffering (eim_clk → outputs)
    //==========================================================================
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            reg_max_v_count     <= `DEF_MAX_V_COUNT;
            reg_max_h_count     <= `DEF_MAX_H_COUNT;
            reg_csi2_word_count <= `DEF_CSI2_WORD_COUNT;
        end else begin
            reg_max_v_count     <= register_memory[`ADDR_MAX_V_COUNT];
            reg_max_h_count     <= register_memory[`ADDR_MAX_H_COUNT];
            reg_csi2_word_count <= register_memory[`ADDR_CSI2_WORD_COUNT];
        end
    end

    //==========================================================================
    // TI ROIC Basic Control Register Buffering (eim_clk → outputs)
    //==========================================================================
    // Note: Original uses 2-stage buffering (buf_* on eim_clk → reg_* on fsm_clk)
    //       but ti_roic_sync/tp_sel are directly assigned from buf_* without reg_* stage.
    //       This refactored version uses 1-stage on eim_clk for consistency.
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            reg_ti_roic_sync     <= 16'd0;
            reg_ti_roic_tp_sel   <= 16'd0;
            reg_ti_roic_str      <= 16'd3;  // Default value from original
            reg_ti_roic_reg_addr <= 16'd0;
            reg_ti_roic_reg_data <= 16'd0;
        end else begin
            reg_ti_roic_sync     <= register_memory[`ADDR_TI_ROIC_SYNC];
            reg_ti_roic_tp_sel   <= register_memory[`ADDR_TI_ROIC_TP_SEL];
            reg_ti_roic_str      <= register_memory[`ADDR_TI_ROIC_STR];
            reg_ti_roic_reg_addr <= register_memory[`ADDR_TI_ROIC_REG_ADDR];
            reg_ti_roic_reg_data <= register_memory[`ADDR_TI_ROIC_REG_DATA];
        end
    end

    //==========================================================================
    // Sequence LUT Register Buffering (eim_clk → outputs)
    //==========================================================================
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            reg_seq_lut_addr    <= 8'd0;
            reg_seq_lut_data_0  <= 16'd0;
            reg_seq_lut_data_1  <= 16'd0;
            reg_seq_lut_data_2  <= 16'd0;
            reg_seq_lut_data_3  <= 16'd0;
            reg_seq_lut_control <= 16'd0;
            reg_seq_state_read  <= 16'd0;
        end else begin
            reg_seq_lut_addr    <= register_memory[`ADDR_SEQ_LUT_ADDR][7:0];
            reg_seq_lut_data_0  <= register_memory[`ADDR_SEQ_LUT_DATA_0];
            reg_seq_lut_data_1  <= register_memory[`ADDR_SEQ_LUT_DATA_1];
            reg_seq_lut_data_2  <= register_memory[`ADDR_SEQ_LUT_DATA_2];
            reg_seq_lut_data_3  <= register_memory[`ADDR_SEQ_LUT_DATA_3];
            reg_seq_lut_control <= register_memory[`ADDR_SEQ_LUT_CONTROL];
            reg_seq_state_read  <= seq_state_read;
        end
    end

    //==========================================================================
    // Acquisition Mode Register Buffering (eim_clk → outputs)
    //==========================================================================
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            reg_acq_mode     <= 3'd7;
            reg_expose_size  <= `DEF_EXPOSE_SIZE;
            reg_pre_delay    <= `DEF_PRE_DELAY;
            reg_post_delay   <= `DEF_POST_DELAY;
        end else begin
            reg_acq_mode     <= register_memory[`ADDR_ACQ_MODE][2:0];
            reg_expose_size  <= register_memory[`ADDR_EXPOSE_SIZE];
            reg_pre_delay    <= register_memory[`ADDR_PRE_DELAY];
            reg_post_delay   <= register_memory[`ADDR_POST_DELAY];
        end
    end

    assign tmp_expose_size = (reg_expose_size==16'd0) ? {2'b00,reg_pre_delay} +
                                                        {2'b00,16'd1} +
                                                        {2'b00,reg_post_delay} :
                                                        {2'b00,reg_pre_delay} +
                                                        {2'b00,reg_expose_size} +
                                                        {2'b00,reg_post_delay};

    //==========================================================================
    // TI ROIC Deserializer Control Register Buffering (eim_clk → outputs)
    //==========================================================================
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            reg_ti_roic_deser_reset      <= 16'd0;
            reg_ti_roic_deser_dly_tap_ld <= 16'd0;
            reg_ti_roic_deser_dly_tap_in <= 16'd0;
            reg_ti_roic_deser_dly_data_ce <= 16'd0;
            reg_ti_roic_deser_dly_data_inc <= 16'd0;
            reg_ti_roic_deser_align_mode <= 16'd0;
            reg_ti_roic_deser_align_start <= 16'd0;
            reg_ti_roic_deser_shift_set[0]  <= 16'd0;
            reg_ti_roic_deser_shift_set[1]  <= 16'd0;
            reg_ti_roic_deser_shift_set[2]  <= 16'd0;
            reg_ti_roic_deser_shift_set[3]  <= 16'd0;
            reg_ti_roic_deser_shift_set[4]  <= 16'd0;
            reg_ti_roic_deser_shift_set[5]  <= 16'd0;
            reg_ti_roic_deser_shift_set[6]  <= 16'd0;
            reg_ti_roic_deser_shift_set[7]  <= 16'd0;
            reg_ti_roic_deser_shift_set[8]  <= 16'd0;
            reg_ti_roic_deser_shift_set[9]  <= 16'd0;
            reg_ti_roic_deser_shift_set[10] <= 16'd0;
            reg_ti_roic_deser_shift_set[11] <= 16'd0;
            reg_ti_roic_deser_shift_set[12] <= 16'd0;
            reg_ti_roic_deser_shift_set[13] <= 16'd0;
            reg_ti_roic_deser_align_shift[0]  <= 16'd0;
            reg_ti_roic_deser_align_shift[1]  <= 16'd0;
            reg_ti_roic_deser_align_shift[2]  <= 16'd0;
            reg_ti_roic_deser_align_shift[3]  <= 16'd0;
            reg_ti_roic_deser_align_shift[4]  <= 16'd0;
            reg_ti_roic_deser_align_shift[5]  <= 16'd0;
            reg_ti_roic_deser_align_shift[6]  <= 16'd0;
            reg_ti_roic_deser_align_shift[7]  <= 16'd0;
            reg_ti_roic_deser_align_shift[8]  <= 16'd0;
            reg_ti_roic_deser_align_shift[9]  <= 16'd0;
            reg_ti_roic_deser_align_shift[10] <= 16'd0;
            reg_ti_roic_deser_align_shift[11] <= 16'd0;
            reg_ti_roic_deser_align_shift[12] <= 16'd0;
            reg_ti_roic_deser_align_shift[13] <= 16'd0;
            reg_ti_roic_deser_align_done <= 16'd0;
        end else begin
            // Control registers (write)
            reg_ti_roic_deser_reset         <= register_memory[`ADDR_TI_ROIC_DESER_RESET];
            reg_ti_roic_deser_dly_tap_ld    <= register_memory[`ADDR_TI_ROIC_DESER_DLY_TAP_LD];
            reg_ti_roic_deser_dly_tap_in    <= register_memory[`ADDR_TI_ROIC_DESER_DLY_TAP_IN];
            reg_ti_roic_deser_dly_data_ce   <= register_memory[`ADDR_TI_ROIC_DESER_DLY_DATA_CE];
            reg_ti_roic_deser_dly_data_inc  <= register_memory[`ADDR_TI_ROIC_DESER_DLY_DATA_INC];
            reg_ti_roic_deser_align_mode    <= register_memory[`ADDR_TI_ROIC_DESER_ALIGN_MODE];
            reg_ti_roic_deser_align_start   <= register_memory[`ADDR_TI_ROIC_DESER_ALIGN_START];

            // Shift set registers (write) - 0x0150~0x015D
            reg_ti_roic_deser_shift_set[0]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_0];
            reg_ti_roic_deser_shift_set[1]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_1];
            reg_ti_roic_deser_shift_set[2]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_2];
            reg_ti_roic_deser_shift_set[3]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_3];
            reg_ti_roic_deser_shift_set[4]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_4];
            reg_ti_roic_deser_shift_set[5]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_5];
            reg_ti_roic_deser_shift_set[6]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_6];
            reg_ti_roic_deser_shift_set[7]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_7];
            reg_ti_roic_deser_shift_set[8]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_8];
            reg_ti_roic_deser_shift_set[9]  <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_9];
            reg_ti_roic_deser_shift_set[10] <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_10];
            reg_ti_roic_deser_shift_set[11] <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_11];
            reg_ti_roic_deser_shift_set[12] <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_12];
            reg_ti_roic_deser_shift_set[13] <= register_memory[`ADDR_TI_ROIC_DESER_SHIFT_SET_13];

            // Align shift inputs (read-only from input ports) - 0x0140~0x014D
            reg_ti_roic_deser_align_shift[0]  <= {11'd0, ti_roic_deser_align_shift[0]};
            reg_ti_roic_deser_align_shift[1]  <= {11'd0, ti_roic_deser_align_shift[1]};
            reg_ti_roic_deser_align_shift[2]  <= {11'd0, ti_roic_deser_align_shift[2]};
            reg_ti_roic_deser_align_shift[3]  <= {11'd0, ti_roic_deser_align_shift[3]};
            reg_ti_roic_deser_align_shift[4]  <= {11'd0, ti_roic_deser_align_shift[4]};
            reg_ti_roic_deser_align_shift[5]  <= {11'd0, ti_roic_deser_align_shift[5]};
            reg_ti_roic_deser_align_shift[6]  <= {11'd0, ti_roic_deser_align_shift[6]};
            reg_ti_roic_deser_align_shift[7]  <= {11'd0, ti_roic_deser_align_shift[7]};
            reg_ti_roic_deser_align_shift[8]  <= {11'd0, ti_roic_deser_align_shift[8]};
            reg_ti_roic_deser_align_shift[9]  <= {11'd0, ti_roic_deser_align_shift[9]};
            reg_ti_roic_deser_align_shift[10] <= {11'd0, ti_roic_deser_align_shift[10]};
            reg_ti_roic_deser_align_shift[11] <= {11'd0, ti_roic_deser_align_shift[11]};
            reg_ti_roic_deser_align_shift[12] <= {11'd0, ti_roic_deser_align_shift[12]};
            reg_ti_roic_deser_align_shift[13] <= {11'd0, ti_roic_deser_align_shift[13]};

            // Align done input (read-only from input port) - 0x0137
            reg_ti_roic_deser_align_done <= {2'd0, ti_roic_deser_align_done};
        end
    end

    //==========================================================================
    // Back Bias Control (mode-dependent: aed_back_bias_index)
    //==========================================================================
    always @(posedge eim_clk or negedge rst) begin
        if (!rst) begin
            reg_up_back_bias <= `DEF_UP_BACK_BIAS;
            reg_dn_back_bias <= `DEF_DN_BACK_BIAS;
        end else begin
            reg_up_back_bias <= register_memory[`ADDR_UP_BACK_BIAS];
            reg_dn_back_bias <= register_memory[`ADDR_DN_BACK_BIAS];
        end
    end

    //==========================================================================
    // GATE Control Register (fsm_clk domain - CDC from register_memory)
    //==========================================================================
    always @(posedge fsm_clk or negedge rst) begin
        if (!rst) begin
            reg_set_gate <= `DEF_SET_GATE;
        end else begin
            reg_set_gate <= register_memory[`ADDR_SET_GATE];
        end
    end

    //==========================================================================
    // Sequence LUT Write Pulse Detection
    //==========================================================================
    // Generate write pulse when any of DATA_0~3 registers are written
    // Extended to 3-cycle pulse to ensure detection in testbench
    logic [1:0] seq_lut_wr_pulse_cnt;

    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            seq_lut_data_wr_pulse <= 1'b0;
            seq_lut_wr_pulse_cnt  <= 2'd0;
        end else begin

            // Detect write to DATA_0~3 registers
            if (reg_data_index && !reg_read_index &&
                (current_reg_addr == `ADDR_SEQ_LUT_DATA_0 ||
                 current_reg_addr == `ADDR_SEQ_LUT_DATA_1 ||
                 current_reg_addr == `ADDR_SEQ_LUT_DATA_2 ||
                 current_reg_addr == `ADDR_SEQ_LUT_DATA_3)) begin
                seq_lut_data_wr_pulse <= 1'b1;
                seq_lut_wr_pulse_cnt  <= 2'd3;  // Hold pulse for 3 cycles
            end else if (seq_lut_wr_pulse_cnt > 0) begin
                seq_lut_wr_pulse_cnt  <= seq_lut_wr_pulse_cnt - 1'b1;
                seq_lut_data_wr_pulse <= (seq_lut_wr_pulse_cnt > 1);
            end else begin
                seq_lut_data_wr_pulse <= 1'b0;
            end
        end
    end

    //==========================================================================
    // Macro for Register Initialization
    //==========================================================================
    `define INIT_REG(name) register_memory[`ADDR_``name] <= `DEF_``name

    //==========================================================================
    // Unified Register Access Logic
    //==========================================================================
    always @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin

            // Then initialize registers with non-zero defaults using macro
            `INIT_REG(STATE_LED_CTR);
            `INIT_REG(SYS_CMD_REG);
            `INIT_REG(OP_MODE_REG);
            `INIT_REG(SET_GATE);
            `INIT_REG(PWR_OFF_DWN);
            `INIT_REG(READOUT_COUNT);
            `INIT_REG(EXPOSE_SIZE);
            `INIT_REG(BACK_BIAS_SIZE);
            `INIT_REG(IMAGE_HEIGHT);
            `INIT_REG(CYCLE_WIDTH_FLUSH);
            `INIT_REG(CYCLE_WIDTH_AED);
            `INIT_REG(CYCLE_WIDTH_READ);
            `INIT_REG(REPEAT_BACK_BIAS);
            `INIT_REG(REPEAT_FLUSH);
            `INIT_REG(SATURATION_FLUSH_REPEAT);
            `INIT_REG(EXP_DELAY);
            `INIT_REG(READY_DELAY);
            `INIT_REG(PRE_DELAY);
            `INIT_REG(POST_DELAY);
            `INIT_REG(UP_BACK_BIAS);
            `INIT_REG(DN_BACK_BIAS);
            `INIT_REG(UP_BACK_BIAS_OPR);
            `INIT_REG(DN_BACK_BIAS_OPR);
            // GATE READ Mode
            `INIT_REG(UP_GATE_STV1_READ);   `INIT_REG(DN_GATE_STV1_READ);
            `INIT_REG(UP_GATE_STV2_READ);   `INIT_REG(DN_GATE_STV2_READ);
            `INIT_REG(UP_GATE_CPV1_READ);   `INIT_REG(DN_GATE_CPV1_READ);
            `INIT_REG(UP_GATE_CPV2_READ);   `INIT_REG(DN_GATE_CPV2_READ);
            `INIT_REG(DN_GATE_OE1_READ);    `INIT_REG(UP_GATE_OE1_READ);
            `INIT_REG(DN_GATE_OE2_READ);    `INIT_REG(UP_GATE_OE2_READ);
            // GATE AED Mode
            `INIT_REG(UP_GATE_STV1_AED);    `INIT_REG(DN_GATE_STV1_AED);
            `INIT_REG(UP_GATE_STV2_AED);    `INIT_REG(DN_GATE_STV2_AED);
            `INIT_REG(UP_GATE_CPV1_AED);    `INIT_REG(DN_GATE_CPV1_AED);
            `INIT_REG(UP_GATE_CPV2_AED);    `INIT_REG(DN_GATE_CPV2_AED);
            `INIT_REG(DN_GATE_OE1_AED);     `INIT_REG(UP_GATE_OE1_AED);
            `INIT_REG(DN_GATE_OE2_AED);     `INIT_REG(UP_GATE_OE2_AED);
            // GATE FLUSH Mode
            `INIT_REG(UP_GATE_STV1_FLUSH);  `INIT_REG(DN_GATE_STV1_FLUSH);
            `INIT_REG(UP_GATE_STV2_FLUSH);  `INIT_REG(DN_GATE_STV2_FLUSH);
            `INIT_REG(UP_GATE_CPV1_FLUSH);  `INIT_REG(DN_GATE_CPV1_FLUSH);
            `INIT_REG(UP_GATE_CPV2_FLUSH);  `INIT_REG(DN_GATE_CPV2_FLUSH);
            `INIT_REG(DN_GATE_OE1_FLUSH);   `INIT_REG(UP_GATE_OE1_FLUSH);
            `INIT_REG(DN_GATE_OE2_FLUSH);   `INIT_REG(UP_GATE_OE2_FLUSH);
            // ROIC Sync & ACLK READ Mode
            `INIT_REG(UP_ROIC_SYNC);
            `INIT_REG(UP_ROIC_ACLK_0_READ);  `INIT_REG(UP_ROIC_ACLK_1_READ);
            `INIT_REG(UP_ROIC_ACLK_2_READ);  `INIT_REG(UP_ROIC_ACLK_3_READ);
            `INIT_REG(UP_ROIC_ACLK_4_READ);  `INIT_REG(UP_ROIC_ACLK_5_READ);
            `INIT_REG(UP_ROIC_ACLK_6_READ);  `INIT_REG(UP_ROIC_ACLK_7_READ);
            `INIT_REG(UP_ROIC_ACLK_8_READ);  `INIT_REG(UP_ROIC_ACLK_9_READ);
            `INIT_REG(UP_ROIC_ACLK_10_READ);
            // ROIC ACLK AED Mode
            `INIT_REG(UP_ROIC_ACLK_0_AED);   `INIT_REG(UP_ROIC_ACLK_1_AED);
            `INIT_REG(UP_ROIC_ACLK_2_AED);   `INIT_REG(UP_ROIC_ACLK_3_AED);
            `INIT_REG(UP_ROIC_ACLK_4_AED);   `INIT_REG(UP_ROIC_ACLK_5_AED);
            `INIT_REG(UP_ROIC_ACLK_6_AED);   `INIT_REG(UP_ROIC_ACLK_7_AED);
            `INIT_REG(UP_ROIC_ACLK_8_AED);   `INIT_REG(UP_ROIC_ACLK_9_AED);
            `INIT_REG(UP_ROIC_ACLK_10_AED);
            // ROIC ACLK FLUSH Mode
            `INIT_REG(UP_ROIC_ACLK_0_FLUSH); `INIT_REG(UP_ROIC_ACLK_1_FLUSH);
            `INIT_REG(UP_ROIC_ACLK_2_FLUSH); `INIT_REG(UP_ROIC_ACLK_3_FLUSH);
            `INIT_REG(UP_ROIC_ACLK_4_FLUSH); `INIT_REG(UP_ROIC_ACLK_5_FLUSH);
            `INIT_REG(UP_ROIC_ACLK_6_FLUSH); `INIT_REG(UP_ROIC_ACLK_7_FLUSH);
            `INIT_REG(UP_ROIC_ACLK_8_FLUSH); `INIT_REG(UP_ROIC_ACLK_9_FLUSH);
            `INIT_REG(UP_ROIC_ACLK_10_FLUSH);
            // ROIC Register Set
            `INIT_REG(ROIC_REG_SET_0);  `INIT_REG(ROIC_REG_SET_1);
            `INIT_REG(ROIC_REG_SET_2);  `INIT_REG(ROIC_REG_SET_3);
            `INIT_REG(ROIC_REG_SET_4);  `INIT_REG(ROIC_REG_SET_5);
            `INIT_REG(ROIC_REG_SET_6);  `INIT_REG(ROIC_REG_SET_7);
            `INIT_REG(ROIC_REG_SET_8);  `INIT_REG(ROIC_REG_SET_9);
            `INIT_REG(ROIC_REG_SET_10); `INIT_REG(ROIC_REG_SET_11);
            `INIT_REG(ROIC_REG_SET_12); `INIT_REG(ROIC_REG_SET_13);
            `INIT_REG(ROIC_REG_SET_14); `INIT_REG(ROIC_REG_SET_15);
            // ROIC Burst & GPIO
            `INIT_REG(ROIC_BURST_CYCLE);
            `INIT_REG(START_ROIC_BURST_CLK);
            `INIT_REG(END_ROIC_BURST_CLK);
            `INIT_REG(GATE_GPIO_REG);
            `INIT_REG(SEL_ROIC_REG);
            // AED Control
            `INIT_REG(READY_AED_READ);      `INIT_REG(AED_TH);
            `INIT_REG(SEL_AED_ROIC);        `INIT_REG(NUM_TRIGGER);
            `INIT_REG(SEL_AED_TEST_ROIC);   `INIT_REG(AED_CMD);
            `INIT_REG(NEGA_AED_TH);         `INIT_REG(POSI_AED_TH);
            `INIT_REG(AED_DARK_DELAY);
            `INIT_REG(AED_DETECT_LINE_0);   `INIT_REG(AED_DETECT_LINE_1);
            `INIT_REG(AED_DETECT_LINE_2);   `INIT_REG(AED_DETECT_LINE_3);
            `INIT_REG(AED_DETECT_LINE_4);   `INIT_REG(AED_DETECT_LINE_5);
            // CSI2 & IO
            `INIT_REG(MAX_V_COUNT);         `INIT_REG(MAX_H_COUNT);
            `INIT_REG(CSI2_WORD_COUNT);     `INIT_REG(IO_DELAY_TAB);
            `INIT_REG(SWITCH_SYNC_UP);      `INIT_REG(SWITCH_SYNC_DN);
            // Sequence LUT
            `INIT_REG(SEQ_LUT_ADDR);        `INIT_REG(SEQ_LUT_DATA_0);
            `INIT_REG(SEQ_LUT_DATA_1);      `INIT_REG(SEQ_LUT_DATA_2);
            `INIT_REG(SEQ_LUT_DATA_3);      `INIT_REG(SEQ_LUT_CONTROL);
            // Acquisition Mode
            `INIT_REG(ACQ_MODE);
            // TI ROIC Basic Control Registers
            `INIT_REG(TI_ROIC_REG_ADDR);    `INIT_REG(TI_ROIC_REG_DATA);
            `INIT_REG(TI_ROIC_SYNC);        `INIT_REG(TI_ROIC_TP_SEL);
            `INIT_REG(TI_ROIC_STR);
            // TI ROIC Deserializer Control Registers
            `INIT_REG(TI_ROIC_DESER_RESET);
            `INIT_REG(TI_ROIC_DESER_DLY_TAP_LD);
            `INIT_REG(TI_ROIC_DESER_DLY_TAP_IN);
            `INIT_REG(TI_ROIC_DESER_DLY_DATA_CE);
            `INIT_REG(TI_ROIC_DESER_DLY_DATA_INC);
            `INIT_REG(TI_ROIC_DESER_ALIGN_MODE);
            `INIT_REG(TI_ROIC_DESER_ALIGN_START);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_0);   `INIT_REG(TI_ROIC_DESER_SHIFT_SET_1);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_2);   `INIT_REG(TI_ROIC_DESER_SHIFT_SET_3);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_4);   `INIT_REG(TI_ROIC_DESER_SHIFT_SET_5);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_6);   `INIT_REG(TI_ROIC_DESER_SHIFT_SET_7);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_8);   `INIT_REG(TI_ROIC_DESER_SHIFT_SET_9);
            `INIT_REG(TI_ROIC_DESER_SHIFT_SET_10);  `INIT_REG(TI_ROIC_DESER_SHIFT_SET_11);

            // TI ROIC Registers
            `INIT_REG(TI_ROIC_REG_00);  `INIT_REG(TI_ROIC_REG_10);
            `INIT_REG(TI_ROIC_REG_11);  `INIT_REG(TI_ROIC_REG_12);
            `INIT_REG(TI_ROIC_REG_13);  `INIT_REG(TI_ROIC_REG_16);
            `INIT_REG(TI_ROIC_REG_18);  `INIT_REG(TI_ROIC_REG_2C);
            `INIT_REG(TI_ROIC_REG_30);  `INIT_REG(TI_ROIC_REG_40);
            `INIT_REG(TI_ROIC_REG_42);  `INIT_REG(TI_ROIC_REG_43);
            `INIT_REG(TI_ROIC_REG_46);  `INIT_REG(TI_ROIC_REG_47);
            `INIT_REG(TI_ROIC_REG_4A);  `INIT_REG(TI_ROIC_REG_4B);
            `INIT_REG(TI_ROIC_REG_50);  `INIT_REG(TI_ROIC_REG_51);
            `INIT_REG(TI_ROIC_REG_52);  `INIT_REG(TI_ROIC_REG_53);
            `INIT_REG(TI_ROIC_REG_54);  `INIT_REG(TI_ROIC_REG_55);
            `INIT_REG(TI_ROIC_REG_5A);  `INIT_REG(TI_ROIC_REG_5C);
            `INIT_REG(TI_ROIC_REG_5D);  `INIT_REG(TI_ROIC_REG_5E);
            `INIT_REG(TI_ROIC_REG_61);
            `INIT_REG(DN_AED_GATE_XAO_0);  `INIT_REG(DN_AED_GATE_XAO_1);
            `INIT_REG(DN_AED_GATE_XAO_2);  `INIT_REG(DN_AED_GATE_XAO_3);
            `INIT_REG(DN_AED_GATE_XAO_4);  `INIT_REG(DN_AED_GATE_XAO_5);
            `INIT_REG(UP_AED_GATE_XAO_0);  `INIT_REG(UP_AED_GATE_XAO_1);
            `INIT_REG(UP_AED_GATE_XAO_2);  `INIT_REG(UP_AED_GATE_XAO_3);
            `INIT_REG(UP_AED_GATE_XAO_4);  `INIT_REG(UP_AED_GATE_XAO_5);
            // Initialize read data path
            s_reg_read_out_tmp0 <= 16'd0;
            read_data_en <= 1'b0;
        end else begin
            //======================================================================
            // Normal Operation: Handle Read/Write
            //======================================================================
            // read_data_en: Active when both reg_map_sel is enabled and read is requested
            read_data_en <= reg_read_index;

            if (reg_data_index && !reg_read_index) begin
                //==============================================================
                // Write Operation
                //==============================================================
                case (current_reg_addr)
                    // Read-Only Registers - Ignore writes
                    `ADDR_FSM_REG,
                    `ADDR_ROIC_TEMPERATURE,
                    `ADDR_FPGA_VER_H,
                    `ADDR_FPGA_VER_L,
                    `ADDR_ROIC_VENDOR,
                    `ADDR_PURPOSE,
                    `ADDR_SIZE_1,
                    `ADDR_SIZE_2,
                    `ADDR_MAJOR_REV,
                    `ADDR_MINOR_REV,
                    // TI ROIC Deserializer read-only registers (0x0140~0x014B, 0x0137)
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_0,  `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_1,
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_2,  `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_3,
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_4,  `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_5,
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_6,  `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_7,
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_8,  `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_9,
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_10, `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_11,
                    `ADDR_TI_ROIC_DESER_ALIGN_DONE: begin
                        // Do nothing - read-only registers
                    end

                    // Default: Write to register memory
                    default: begin
                        if (current_reg_addr < `MAX_ADDR) begin
                            register_memory[current_reg_addr] <= reg_data;
                        end
                    end
                endcase

            end else if (reg_read_index) begin
                //==============================================================
                // Read Operation
                //==============================================================
                case (current_reg_addr)
                    // Read-Only Registers with special sources

                    // FSM State Register (updated on fsm_clk domain)
                    `ADDR_FSM_REG:          s_reg_read_out_tmp0 <= {8'd0, fsm_reg};

                    // FPGA Version from USR_ACCESSE2
                    `ADDR_FPGA_VER_H:       s_reg_read_out_tmp0 <= s_fpga_ver_data[31:16];
                    `ADDR_FPGA_VER_L:       s_reg_read_out_tmp0 <= s_fpga_ver_data[15:0];

                    // Sequence LUT Read Data - Read back from external LUT
                    `ADDR_SEQ_LUT_DATA_0:   s_reg_read_out_tmp0 <= seq_lut_read_data[15:0];
                    `ADDR_SEQ_LUT_DATA_1:   s_reg_read_out_tmp0 <= seq_lut_read_data[31:16];
                    `ADDR_SEQ_LUT_DATA_2:   s_reg_read_out_tmp0 <= seq_lut_read_data[47:32];
                    `ADDR_SEQ_LUT_DATA_3:   s_reg_read_out_tmp0 <= seq_lut_read_data[63:48];

                    // Sequence State Read - Current FSM state from sequencer
                    `ADDR_SEQ_STATE_READ:   s_reg_read_out_tmp0 <= reg_seq_state_read;

                    // TI ROIC Deserializer read-only inputs
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_0:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[0];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_1:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[1];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_2:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[2];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_3:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[3];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_4:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[4];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_5:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[5];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_6:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[6];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_7:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[7];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_8:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[8];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_9:  s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[9];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_10: s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[10];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_11: s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[11];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_12: s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[12];
                    `ADDR_TI_ROIC_DESER_ALIGN_SHIFT_13: s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_shift[13];
                    `ADDR_TI_ROIC_DESER_ALIGN_DONE:     s_reg_read_out_tmp0 <= reg_ti_roic_deser_align_done;

                    // Constant values for RO registers
                    `ADDR_ROIC_VENDOR:      s_reg_read_out_tmp0 <= `ROIC_VENDOR;
                    `ADDR_PURPOSE:          s_reg_read_out_tmp0 <= `PURPOSE;
                    `ADDR_SIZE_1:           s_reg_read_out_tmp0 <= `SIZE_1;
                    `ADDR_SIZE_2:           s_reg_read_out_tmp0 <= `SIZE_2;
                    `ADDR_MAJOR_REV:        s_reg_read_out_tmp0 <= `MAJOR_REV;
                    `ADDR_MINOR_REV:        s_reg_read_out_tmp0 <= `MINOR_REV;

                    // Default: Read from register memory
                    default: begin
                        if (current_reg_addr < `MAX_ADDR) begin
                            s_reg_read_out_tmp0 <= register_memory[current_reg_addr];
                        end else begin
                            s_reg_read_out_tmp0 <= 16'h0;
                        end
                    end
                endcase
            end
        end
    end

    //==========================================================================
    // FPGA Version Access (USR_ACCESSE2)
    //==========================================================================
    // 7 Series Xilinx FPGA Configuration Data Access

    USR_ACCESSE2 USR_ACCESSE2_inst (
        .CFGCLK    (CFGCLK),           // 1-bit output: Configuration Clock
        .DATA      (FPGA_VER_DATA),    // 32-bit output: Configuration Data
        .DATAVALID (DATAVALID)         // 1-bit output: Active high data valid
    );

    assign s_fpga_ver_data = FPGA_VER_DATA;


endmodule
