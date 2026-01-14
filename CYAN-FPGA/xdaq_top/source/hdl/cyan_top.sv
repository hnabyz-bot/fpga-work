`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
// File: cyan_top.sv
// Date: 2025.05.19
// Designer: drake.lee
// Description: xdaq fpga top file - Converted from VHDL to SystemVerilog
// Revision History:
//    2025.05.19 - Initial
//
///////////////////////////////////////////////////////////////////////////////


module cyan_top (
    // system signal
    input   logic        nRST,
    input   logic        MCLK_50M_p,
    input   logic        MCLK_50M_n,

    // mipi csi2 interface
    output  logic        mipi_phy_if_clk_hs_p,
    output  logic        mipi_phy_if_clk_hs_n,
    output  logic        mipi_phy_if_clk_lp_p,
    output  logic        mipi_phy_if_clk_lp_n,
    output  logic [3:0]  mipi_phy_if_data_hs_p,
    output  logic [3:0]  mipi_phy_if_data_hs_n,
    output  logic [3:0]  mipi_phy_if_data_lp_p,
    output  logic [3:0]  mipi_phy_if_data_lp_n,

    // register map control signal
    input   logic        SCLK,
    input   logic        SSB,
    input   logic        MOSI,
    output  logic        MISO,

    // ROIC Driving Signals
    output  logic        ROIC_TP_SEL,
    output  logic        ROIC_SYNC,
    output  logic        ROIC_MCLK0,
    output  logic        ROIC_MCLK1,

    output  logic [11:0] RF_SPI_SEN,
    output  logic        RF_SPI_SCK,
    output  logic [0:0]  RF_SPI_SDI,
    input   logic [11:0] RF_SPI_SDO,

    output  logic        SWITCH_SYNC,

    input  logic         AED_TRIG,

    input   logic [11:0] R_ROIC_DCLKo_p,
    input   logic [11:0] R_ROIC_DCLKo_n,

    input   logic [11:0] R_ROIC_FCLKo_p,
    input   logic [11:0] R_ROIC_FCLKo_n,

    input   logic [11:0] R_DOUTA_H,
    input   logic [11:0] R_DOUTA_L,

    // Gate Driving Signals
    output  logic        GF_STV_L,
    output  logic        GF_STV_R,

    output  logic [5:0]  GF_XAO,

    output  logic        GF_LR,

    output  logic        GF_CPV,
    output  logic        GF_OE,

    // Bias Signals
    output  logic        ROIC_VBIAS,
    output  logic        ROIC_AVDD1,
    output  logic        ROIC_AVDD2,

    // Trigger Signals
    input   logic        PREP_REQ,
    input   logic        EXP_REQ,

    output  logic        PREP_ACK,
    output  logic        EXP_ACK,

    // debug signals
    output logic [3:0]   DEBUG_SiG,

    // Signals control
    output  logic        STATE_LED1

);

    // (* mark_debug="true" *) 

    // Clock signals
    logic s_clk_100mhz;
    logic s_dphy_clk_200M;
    logic s_clk_20mhz;
    logic s_clk_5mhz;
    logic s_clk_1mhz;

    // Module signals
    logic s_roic_reset;
    logic s_back_bias;

    logic s_roic_tp_sel;
    logic s_roic_sync_in;
    logic s_roic_sync_out;
    logic s_roic_a_bz;

    logic [11:0] s_roic_sdio;

    logic eim_clk;
    logic eim_rst;
    logic sys_rst;
    logic rst;
    logic fsm_drv_rst;

    logic col_end;

    logic FSM_rst_index;
    logic FSM_wait_index;
    logic FSM_back_bias_index;
    logic FSM_flush_index;
    logic FSM_aed_read_index;
    logic FSM_exp_index;
    logic FSM_read_index;
    logic FSM_idle_index;
    logic FSM_index_all;

    logic ready_to_get_image;
    logic aed_ready_done;
    logic aed_ready_done_dark;
    logic panel_stable_o;
    logic s_exp_read_exist;

    logic [15:0] row_cnt;
    logic [15:0] col_cnt;
    logic [15:0] s_sync_col_cnt;

    logic en_pwr_off;
    logic en_pwr_dwn;
    logic system_rst;
    logic reset_FSM;
    logic org_reset_FSM;
    logic dummy_get_image;
    logic burst_get_image;
    logic get_dark;
    logic get_bright;
    logic cmd_get_bright;
    logic s_get_bright;

    logic en_aed;

    logic s_sum_channel_detected;

    logic en_panel_stable;

    logic [15:0] dsp_image_height;
    logic [15:0] max_h_count;
    logic [15:0] max_v_count;
    logic [15:0] csi2_word_count;

    logic [15:0] up_back_bias;
    logic [15:0] down_back_bias;

    logic [15:0] dn_aed_gate_xao [0:5];
    logic [15:0] up_aed_gate_xao [0:5];

    logic en_16bit_adc;
    logic en_test_pattern_col;
    logic en_test_pattern_row;
    logic en_test_roic_col;
    logic en_test_roic_row;
    logic sig_gate_lr1;
    logic sig_gate_lr2;
    logic valid_roic_out;
    logic valid_roic_burst_clk;
    logic valid_roic_reg_out;
    logic valid_roic_header_out;
    logic valid_roic_data;

    // Array signals
    logic valid_aed_test_data;
    logic [15:0] trigger_data_1;
    logic [15:0] trigger_data_2;
    logic [15:0] trigger_data_3;

    logic s_pwr_init_step1;
    logic s_pwr_init_step2;
    logic s_pwr_init_step3;
    logic s_pwr_init_step4;
    logic s_pwr_init_step5;
    logic s_pwr_init_step6;

    logic init_rst;
    logic s_sync_fsm_read_index;
    logic s_sync_fsm_flush_index;
    logic s_sync_fsm_back_bias_index;
    logic s_sync_xao_enable;

    logic gate_xao;
    logic gate_xao_0;
    logic gate_xao_1;
    logic gate_xao_2;
    logic gate_xao_3;
    logic gate_xao_4;

    logic s_tg_stv;
    logic s_tg_cpv;
    logic s_tg_oe;
    logic s_mask_stv;

    logic [15:0] tg_row_cnt;
    logic [10:0] tg_col_cnt;

    // SPI signals
    localparam int header = 2;
    localparam int payload = 16;
    localparam int addrsz = 14;
    localparam int pktsz = 32; // (header + addrsz + payload) size of SPI packet

    logic s_spi_start_flag;
    logic s_addr_dv;
    logic s_rw_out;

    logic s_reg_read_index;

    logic [addrsz-1:0] s_reg_addr;
    logic [payload-1:0] s_reg_data;
    logic s_reg_addr_index;
    logic s_reg_data_index;

    logic [15:0] reg_read_out;
    logic read_data_en;
    logic [15:0] s_reg_read_out_old;
    logic [15:0] s_reg_read_out_new;
    logic s_read_data_en;

    logic [15:0] s_reg_address;

    logic [23:0] s_read_rx_data_a;
    logic [23:0] s_read_rx_data_b;
    logic s_read_frame_start;
    logic s_read_frame_reset;
    logic s_read_axis_tready;
    logic s_read_axis_tlast;
    logic s_read_axis_tvalid;

    logic [23:0] s_test_cnt;
    logic [7:0] s_state_led_ctr;
    logic s_reg_map_sel;

    // MIPI signals
    logic s_reset;
    logic s_csi2_reset;
    logic s_clk_lock;
    logic s_csi_done;
    logic [0:0] s_axis_video_tuser;
    logic [23:0] s_axis_tdata_a;
    logic [23:0] s_axis_tdata_b;

    logic s_reg_tp_sel;

    logic s_reg_roic_sync;

    logic ti_roic_sync;
    logic ti_roic_tp_sel;
    logic [1:0]  ti_roic_str;
    logic [15:0] ti_roic_reg_addr;
    logic [15:0] ti_roic_reg_data;
    logic gen_sync_start;
    logic [1:0] s_gen_sync_start_dly;
    logic s_gen_sync_start_rise;

    // TI ROIC deser signals
    logic ti_roic_deser_reset;
    logic ti_roic_deser_dly_tap_ld;
    logic [4:0] ti_roic_deser_dly_tap_in;
    logic ti_roic_deser_dly_data_ce;
    logic ti_roic_deser_dly_data_inc;
    logic ti_roic_deser_align_mode;
    logic ti_roic_deser_align_start;
    logic [4:0] ti_roic_deser_shift_set[11:0];
    logic [4:0] ti_roic_deser_align_shift[11:0];
    logic [11:0] ti_roic_deser_align_done;

    // Sequence table signals
    logic s_seq_reset;
    logic [7:0] seq_lut_addr;
    logic [63:0] seq_lut_data;
    logic seq_lut_wr_en;
    logic [63:0] seq_lut_read_data;
    logic [15:0] seq_state_read;
    logic seq_lut_config_done;
    logic [15:0] seq_lut_control;
    logic [ 2:0] acq_mode;
    logic [31:0] acq_expose_size;
    logic [ 2:0] acq_mode_o;
    logic [31:0] expose_size_o;

    logic s_config_done_i;
    logic s_sync_config_done;

    logic exit_signal_i;
    logic [3:0] current_state_o;
    logic busy_o;
    logic sequence_done_o;
    logic reset_state_o;
    logic wait_o;
    logic bias_enable_o;
    logic flush_enable_o;
    logic expose_enable_o;
    logic readout_enable_o;
    logic aed_enable_o;
    logic stv_mask_o;
    logic csi_mask_o;
    logic idle_elable_o;
    logic iterate_exist_o;
    logic s_wait_sync;
    logic [2:0] s_wait_sync_dly;
    logic s_wait_tp_sel;
    logic s_wait_roic_sync;

    logic s_sync_stv_mask_o;
    logic s_sync_csi_mask_o;
    logic [31:0] s_sync_current_repeat_count_o;
    logic [31:0] s_sync_repeat_cnt;
    logic [2:0] s_sync_repeat_cnt_mod;


    logic current_sof_o;
    logic current_eof_o;
    logic [31:0] active_repeat_count_o;
    logic [31:0] current_repeat_count_o;
    logic [31:0] valid_repeat_count_o;
    logic [18:0] current_data_length_o;

    logic [1:0] s_get_dark_dly;
    logic [1:0] s_get_bright_dly;
    logic [1:0] s_get_aed_trig_dly;
    logic [1:0] s_sequence_done_dly;
    logic s_get_dark_hi;
    logic s_get_bright_hi;
    logic s_get_aed_trig_hi;
    logic s_sequence_done_hi;
    logic s_exit_signal_dark;
    logic s_exit_signal_bright;
    logic s_exit_signal_aed;
    logic s_aed_mode_exist;

    logic s_aed_trig;
    logic s_aed_trig_i;
    logic s_valid_readout;
    logic s_read_data_start;
    logic s_readout_wait;
    logic s_state_exit_flag;
    logic s_aed_detect_skip_oe_o;


    // clk_ctrl module instantiation
    clk_ctrl clk_inst0 (
        .reset          (1'b0),
        .clk_in1_p      (MCLK_50M_p),
        .clk_in1_n      (MCLK_50M_n),
        .locked         (s_clk_lock),
        .dphy_clk       (s_dphy_clk_200M),  // 200MHz
        .c0             (s_clk_100mhz),     // 100MHz
        .c1             (s_clk_20mhz)      // 25MHz
    );

    assign eim_clk = s_clk_100mhz; // Use 100MHz clock for EIM

    // MIPI CSI2 TX module instantiation
    mipi_csi2_tx_top inst_mipi_csi2_tx (
        .reset                  (s_csi2_reset),
        .dphy_clk_200M          (s_dphy_clk_200M),
        .clk_100M               (s_clk_100mhz),
        .eim_clk                (eim_clk),
        .locked_i               (s_clk_lock),
        .read_frame_reset       (s_read_frame_reset),
        .s_axis_tdata_a         (s_axis_tdata_a),
        .s_axis_tdata_b         (s_axis_tdata_b),
        .s_axis_tlast           (s_read_axis_tlast),
        .s_axis_tready          (s_read_axis_tready),
        .s_axis_tvalid          (s_read_axis_tvalid),
        .s_axis_tstrb           (3'b000),            // All bits active
        .s_axis_tkeep           (3'b111),            // All bits kept
        .mipi_phy_if_clk_hs_p   (mipi_phy_if_clk_hs_p),
        .mipi_phy_if_clk_hs_n   (mipi_phy_if_clk_hs_n),
        .mipi_phy_if_clk_lp_p   (mipi_phy_if_clk_lp_p),
        .mipi_phy_if_clk_lp_n   (mipi_phy_if_clk_lp_n),
        .mipi_phy_if_data_hs_p  (mipi_phy_if_data_hs_p),
        .mipi_phy_if_data_hs_n  (mipi_phy_if_data_hs_n),
        .mipi_phy_if_data_lp_p  (mipi_phy_if_data_lp_p),
        .mipi_phy_if_data_lp_n  (mipi_phy_if_data_lp_n),
        .csi2_word_count        (csi2_word_count),
        .m_axis_video_tuser     (s_axis_video_tuser),
        .done                   (s_csi_done),
        .interrupt              (),
        .status                 (),
        .system_rst_out         ()
    );

    // init module instantiation
    init init_inst (
        .fsm_clk            (s_clk_20mhz),
        .reset              (s_reset),
        .en_pwr_off         (en_pwr_off),
        .en_pwr_dwn         (en_pwr_dwn),
        .init_rst           (init_rst),
        .pwr_init_step1     (s_pwr_init_step1),
        .pwr_init_step2     (s_pwr_init_step2),
        .pwr_init_step3     (s_pwr_init_step3),
        .pwr_init_step4     (s_pwr_init_step4),
        .pwr_init_step5     (s_pwr_init_step5),
        .pwr_init_step6     (s_pwr_init_step6),
        .roic_reset         (s_roic_reset)
    );

    // SPI slave instantiation 
    // Note: Placeholder, actual implementation needs to be provided    
    spi_slave #(
        .header     (header),
        .payload    (payload),
        .addrsz     (addrsz),
        .pktsz      (pktsz)
    )
    host_if_inst (
        .clk               (s_clk_100mhz),
        .reset             (s_reset),
        .SCLK              (SCLK),
        .SSB               (SSB),
        .MOSI              (MOSI),
        .MISO              (s_miso),
        .spi_start_flag    (s_spi_start_flag),
        .read_data         (reg_read_out[payload-1:0]),
        .read_en           (s_read_data_en),
        .reg_addr          (s_reg_addr[addrsz-1:0]),
        .addr_valid        (s_addr_dv),
        .wr_data           (s_reg_data[payload-1:0]),
        .wr_data_valid     (s_reg_data_index),
        .rw_out            (s_rw_out)
    );

    assign s_reg_address = ({2'b00,s_reg_addr[addrsz-1:0]});
    assign reg_read_out = s_reg_read_out_new;

    reg_map_refacto reg_map_refact_inst (
        .eim_clk                    (s_clk_100mhz),
        .eim_rst                    (eim_rst),
        .fsm_clk                    (s_clk_20mhz),
        .rst                        (rst),
        .exp_req                    (EXP_REQ),
        .fsm_rst_index              (FSM_rst_index),
        .fsm_init_index             (FSM_wait_index),
        .fsm_back_bias_index        (FSM_back_bias_index),
        .fsm_flush_index            (FSM_flush_index),
        .fsm_aed_read_index         (FSM_aed_read_index),
        .fsm_exp_index              (FSM_exp_index),
        .fsm_read_index             (FSM_read_index),
        .fsm_idle_index             (FSM_idle_index),
        .ready_to_get_image         (ready_to_get_image),
        .aed_ready_done             (aed_ready_done),
        .panel_stable_exist         (panel_stable_o),
        .exp_read_exist             (s_exp_read_exist),
        .reg_read_index             (s_reg_read_index),
        .reg_addr                   (s_reg_address),
        .reg_data                   (s_reg_data),
        .reg_data_index             (s_reg_data_index),
        .reg_read_out               (s_reg_read_out_new),
        .read_data_en               (s_read_data_en),
        .en_pwr_dwn                 (en_pwr_dwn),
        .en_pwr_off                 (en_pwr_off),
        .system_rst                 (system_rst),
        .reset_fsm                  (reset_FSM),
        .org_reset_fsm              (org_reset_FSM),
        .dummy_get_image            (dummy_get_image),
        .burst_get_image            (burst_get_image),
        .get_dark                   (get_dark),
        .get_bright                 (get_bright),
        .cmd_get_bright             (cmd_get_bright),
        .en_panel_stable            (en_panel_stable),
        .dsp_image_height           (dsp_image_height),
        .max_v_count                (max_v_count),
        .max_h_count                (max_h_count),
        .csi2_word_count            (csi2_word_count),
        .gate_mode1                 (),
        .gate_mode2                 (),
        .gate_cs1                   (),
        .gate_cs2                   (),
        .gate_sel                   (),
        .gate_ud                    (),
        .gate_stv_mode              (),
        .gate_oepsn                 (),
        .gate_lr1                   (sig_gate_lr1),
        .gate_lr2                   (sig_gate_lr2),
        .stv_sel_h                  (),
        .stv_sel_l1                 (),
        .stv_sel_r1                 (),
        .stv_sel_l2                 (),
        .stv_sel_r2                 (),
        .up_back_bias               (up_back_bias),
        .dn_back_bias               (down_back_bias),

        .seq_lut_addr               (seq_lut_addr),
        .seq_lut_data               (seq_lut_data),
        .seq_lut_wr_en              (seq_lut_wr_en),
        .seq_lut_read_data          (seq_lut_read_data),
        .seq_lut_control            (seq_lut_control),
        .seq_lut_config_done        (seq_lut_config_done),
        .acq_mode                   (acq_mode),
        .acq_expose_size            (acq_expose_size),
        .seq_state_read             (seq_state_read),
        // TI-ROIC Register signals
        .ti_roic_sync               (s_reg_roic_sync),
        .ti_roic_tp_sel             (s_reg_tp_sel),
        .ti_roic_str                (ti_roic_str),
        .ti_roic_reg_addr           (ti_roic_reg_addr),
        .ti_roic_reg_data           (ti_roic_reg_data),
        // TI-ROIC Deserializer signals
        .ti_roic_deser_reset        (ti_roic_deser_reset),
        .ti_roic_deser_dly_tap_ld   (ti_roic_deser_dly_tap_ld),
        .ti_roic_deser_dly_tap_in   (ti_roic_deser_dly_tap_in),
        .ti_roic_deser_dly_data_ce  (ti_roic_deser_dly_data_ce),
        .ti_roic_deser_dly_data_inc (ti_roic_deser_dly_data_inc),
        .ti_roic_deser_align_mode   (ti_roic_deser_align_mode),
        .ti_roic_deser_align_start  (ti_roic_deser_align_start),
        .ti_roic_deser_shift_set    (ti_roic_deser_shift_set),
        .ti_roic_deser_align_shift  (ti_roic_deser_align_shift),
        .ti_roic_deser_align_done   (ti_roic_deser_align_done),
        .en_16bit_adc               (en_16bit_adc),
        .en_test_pattern_col        (en_test_pattern_col),
        .en_test_pattern_row        (en_test_pattern_row),
        .en_test_roic_col           (en_test_roic_col),        
        .en_test_roic_row           (en_test_roic_row),
        .exp_ack                    (EXP_ACK),
        .dn_aed_gate_xao            (dn_aed_gate_xao),
        .up_aed_gate_xao            (up_aed_gate_xao),
        .state_led_ctr              (s_state_led_ctr)
    );

    // assign disable_aed_read_xao = 1'b1; // For Gemini, AED read XAO is always enabled

    roic_gate_drv_gemini roic_gate_drv_inst (
        .fsm_clk                (s_clk_20mhz),
        .fsm_drv_rst            (fsm_drv_rst),
        .row_cnt                (row_cnt),
        .col_cnt                (col_cnt),
        .fsm_back_bias_index    (s_sync_fsm_back_bias_index),
        .fsm_flush_index        (s_sync_fsm_flush_index),
        .col_end                (col_end),
        .up_back_bias           (up_back_bias),
        .dn_back_bias           (down_back_bias),
        .up_aed_gate_xao        (up_aed_gate_xao),
        .dn_aed_gate_xao        (dn_aed_gate_xao),
        .back_bias              (s_back_bias),
        .gate_xao_0             (gate_xao_0),
        .gate_xao_1             (gate_xao_1),
        .gate_xao_2             (gate_xao_2),
        .gate_xao_3             (gate_xao_3),
        .gate_xao_4             (gate_xao_4),
        .gate_xao_5             (gate_xao)
    );

    assign row_cnt = s_sync_repeat_cnt[15:0];
    assign col_cnt = s_sync_col_cnt[15:0];
    assign col_end = (s_sync_col_cnt == 16'd0) ? 1'b1 : 1'b0;

    assign FSM_rst_index        = reset_state_o     ? 1'b1 : 1'b0;
    assign FSM_wait_index       = wait_o            ? 1'b1 : 1'b0;
    assign FSM_aed_read_index   = aed_enable_o      ? 1'b1 : 1'b0;
    assign FSM_back_bias_index  = bias_enable_o     ? 1'b1 : 1'b0;
    assign FSM_flush_index      = flush_enable_o    ? 1'b1 : 1'b0;
    assign FSM_exp_index        = expose_enable_o   ? 1'b1 : 1'b0;
    assign FSM_read_index       = readout_enable_o  ? 1'b1 : 1'b0;
    assign FSM_idle_index       = idle_elable_o     ? 1'b1 : 1'b0;

    logic [11:0] s_roic_even_odd_out;

    // Sequence table module instantiation
    sequencer_fsm seq_fsm_inst (
        .clk                (s_clk_20mhz),
        .reset_i            (s_seq_reset),
        .config_done_i      (s_sync_config_done),
        .lut_addr_i         (seq_lut_addr),
        .lut_wen_i          (seq_lut_wr_en),
        .lut_write_data_i   (seq_lut_data),
        .lut_read_data_o    (seq_lut_read_data),
        .acq_mode_i         (acq_mode),
        .expose_size_i      (acq_expose_size),
        .exit_signal_i      (exit_signal_i),
        .roic_even_odd_i    (s_roic_even_odd_out[0]),
        .readout_wait       (s_readout_wait),
        .state_exit_flag_o  (s_state_exit_flag),
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
        .current_sof_o      (current_sof_o),
        .current_eof_o      (current_eof_o),
        .acq_mode_o         (acq_mode_o),
        .expose_size_o      (expose_size_o),
        .current_repeat_count_o (current_repeat_count_o),
        .active_repeat_count_o  (active_repeat_count_o),
        .current_data_length_o  (current_data_length_o)
    );

    assign s_wait_tp_sel = (wait_o && current_eof_o) ? 1'b1 : 1'b0;
    assign s_wait_sync   = (wait_o && current_sof_o) ? 1'b1 : 1'b0;
    assign s_wait_roic_sync = (s_wait_sync_dly == 3'd3) ? 1'b1 : 1'b0;


    assign s_seq_reset = (~rst) ? 1'b1 : 1'b0;

    assign valid_repeat_count_o = s_sync_current_repeat_count_o - 32'd2;

    assign s_valid_readout = ((~s_sync_csi_mask_o) && s_sync_fsm_read_index && (valid_repeat_count_o > s_sync_repeat_cnt)) ? 1'b1 : 1'b0;

    assign s_read_data_start = (tg_col_cnt == 11'd1024 && s_valid_readout) ? 1'b1 : 1'b0;

    assign seq_state_read = {wait_o , bias_enable_o, flush_enable_o, expose_enable_o, 
                            readout_enable_o, aed_enable_o , current_sof_o , current_eof_o,
                            stv_mask_o     , csi_mask_o  , sequence_done_o, busy_o,
                            current_state_o};

    always_ff @(posedge s_clk_20mhz or posedge s_seq_reset) begin
        if (s_seq_reset) begin
            s_get_dark_dly <= 2'b00;
            s_get_bright_dly <= 2'b00;
            s_get_aed_trig_dly <= 2'b00;
            s_sequence_done_dly <= 2'b00;
            s_aed_trig <= 1'b0;
            s_wait_sync_dly <= 3'b000;
        end else begin
            s_get_dark_dly <= {s_get_dark_dly[0], get_dark};
            s_get_bright_dly <= {s_get_bright_dly[0], s_get_bright};
            s_get_aed_trig_dly <= {s_get_aed_trig_dly[0], s_aed_trig_i};
            s_sequence_done_dly <= {s_sequence_done_dly[0], sequence_done_o};
            s_aed_trig <= AED_TRIG;
            s_wait_sync_dly <= {s_wait_sync_dly[1:0], s_wait_sync};
        end
    end

    assign s_get_bright = (s_aed_mode_exist==1'b0 && (cmd_get_bright || get_bright)) ? 1'b1 : 1'b0;

    assign s_aed_mode_exist = (acq_mode_o == 3'd4 || acq_mode_o == 3'd5) ? 1'b1 : 1'b0;
    assign aed_ready_done = aed_enable_o;

    assign s_aed_trig_i = (s_aed_mode_exist) ? s_aed_trig : 1'b0;

    assign s_get_dark_hi = (s_get_dark_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_get_bright_hi = (s_get_bright_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_get_aed_trig_hi = (s_get_aed_trig_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_sequence_done_hi = (s_sequence_done_dly == 2'b01) ? 1'b1 : 1'b0;

    assign exit_signal_i = (s_exit_signal_dark || s_exit_signal_bright || s_exit_signal_aed) ? 1'b1 : 1'b0;
    assign ready_to_get_image = exit_signal_i;

    always_ff @(posedge s_clk_20mhz or posedge s_seq_reset) begin
        if (s_seq_reset) begin
            s_exit_signal_dark <= 1'b0;
            s_exit_signal_bright <= 1'b0;
            s_exit_signal_aed <= 1'b0;
            s_exp_read_exist <= 1'b0;
        end else begin
            if (s_get_dark_hi) begin
                s_exit_signal_dark <= 1'b1;
            end else if (s_sequence_done_hi) begin
                s_exit_signal_dark <= 1'b0;
            end

            if (s_get_bright_hi) begin
                s_exit_signal_bright <= 1'b1;
            end else if (s_sequence_done_hi) begin
                s_exit_signal_bright <= 1'b0;
            end

            if (s_get_aed_trig_hi) begin
                s_exit_signal_aed <= 1'b1;
            end else if (s_sequence_done_hi) begin
                s_exit_signal_aed <= 1'b0;
            end

            if (expose_enable_o) begin
                s_exp_read_exist <= 1'b1;
            end else if (current_eof_o) begin
                s_exp_read_exist <= 1'b0;
            end
        end
    end

// ====================================================================
    // Read RX data processing
    always_ff @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            s_axis_tdata_a <= '0;
            s_axis_tdata_b <= '0;
        end else begin
            s_axis_tdata_b <= {s_read_rx_data_b[15:11], 3'b000, s_read_rx_data_b[20:16], 3'b000,
                            s_read_rx_data_b[10:8], s_read_rx_data_b[23:21], 2'b00};
            s_axis_tdata_a <= {s_read_rx_data_a[15:11], 3'b000, s_read_rx_data_a[20:16], 3'b000,
                            s_read_rx_data_a[10:8], s_read_rx_data_a[23:21], 2'b00};
        end
    end


    assign MISO = s_miso;

    assign s_axis_video_tuser[0] = s_read_frame_start;

    assign s_reg_addr_index = (s_rw_out == 1'b0 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;
    assign s_reg_read_index = (s_rw_out == 1'b1 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;

    assign s_mask_stv = (s_sync_stv_mask_o == 1'b1) ? s_tg_stv : 1'b0;

    assign GF_CPV = s_tg_cpv;
    assign GF_STV_R = (sig_gate_lr1== 1'b0) ? s_mask_stv : 1'bz;
    assign GF_STV_L = (sig_gate_lr1== 1'b1) ? s_mask_stv : 1'bz;
    assign GF_OE = s_tg_oe;

    assign GF_LR = sig_gate_lr1;

    assign s_sync_repeat_cnt_mod = s_sync_repeat_cnt % 32'd6;
    assign s_sync_xao_enable = (s_sync_fsm_flush_index || s_sync_fsm_back_bias_index) ? 1'b1 : 1'b0;

    assign GF_XAO[5] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd5) ? gate_xao_0 : 1'b1;
    assign GF_XAO[4] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd4) ? gate_xao_1 : 1'b1;
    assign GF_XAO[3] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd3) ? gate_xao_2 : 1'b1;
    assign GF_XAO[2] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd2) ? gate_xao_3 : 1'b1;
    assign GF_XAO[1] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd1) ? gate_xao_4 : 1'b1;
    assign GF_XAO[0] = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd0) ? gate_xao   : 1'b1;

    // Reset generation
    assign s_reset = !nRST;

    always_ff @(posedge s_clk_20mhz) begin
        if (system_rst == 1'b1 || init_rst == 1'b1 || s_reset == 1'b1) begin
            rst <= 1'b0;
        end else begin
            rst <= 1'b1;
        end
    end

    always_ff @(posedge s_clk_100mhz) begin
        if (system_rst == 1'b1 || s_reset == 1'b1) begin
            s_csi2_reset <= 1'b1;
        end else begin
            s_csi2_reset <= 1'b0;
        end
    end

    always_ff @(posedge s_clk_20mhz) begin
        if (FSM_rst_index == 1'b1 || ~rst) begin
            fsm_drv_rst <= 1'b0;
        end else begin
            fsm_drv_rst <= 1'b1;
        end
    end

    always_ff @(posedge s_clk_100mhz) begin
        sys_rst <= rst;
    end

    always_ff @(posedge eim_clk) begin
        eim_rst <= rst;
    end


    assign ROIC_TP_SEL  = ti_roic_tp_sel;
    assign ROIC_MCLK0   = s_clk_20mhz;
    assign ROIC_MCLK1   = s_clk_20mhz;
    assign ROIC_SYNC    = ti_roic_sync;

    assign ROIC_VBIAS = s_back_bias;
    assign ROIC_AVDD1 = s_pwr_init_step1;
    assign ROIC_AVDD2 = s_pwr_init_step2;

    // TI ROIC module interface
    //--------------------------------------------------------------------------
    // Configuration Parameters
    //--------------------------------------------------------------------------
    localparam int WORD_SIZE     = 24;     // 24-bit data word width

    //--------------------------------------------------------------------------
    // Clock and Reset Signals
    //--------------------------------------------------------------------------
    logic deser_reset;               // Deserializer reset

    // Bit Alignment Signals
    //--------------------------------------------------------------------------
    logic [4:0] extra_shift [11:0];         // Additional bit alignment shift amount
    logic align_to_fclk;             // Select mode: 0=pattern detection, 1=manual
    logic align_start;               // Start alignment process
    logic [4:0] shift_out [11:0];           // Selected shift amount output
    logic [11:0] align_done;                // Alignment completion flag

    //--------------------------------------------------------------------------
    // Internal Signals
    //--------------------------------------------------------------------------

    logic [11:0] data_read_req;             // Data read request signal

    // Output signals for data validation
    logic [11:0] valid_read_enable;         // Enable signal for reading reordered data

    logic [23:0] reordered_data_a [11:0];     // Reordered data output from ti_roic_top
    logic [23:0] reordered_data_b [11:0];     // Reordered data output from ti_roic_top
    logic [11:0] reordered_valid;           // Reordered data valid flag
    logic [11:0] channel_detected;          // First channel detection signal
    logic [23:0] detected_data_out [11:0];    // Data output at first channel detection
    logic valid_read_mem;
    logic [23:0] roic_read_data;

    logic [11:0] s_even_odd_toggle_out;

    //for debug signal
    logic dbg_even_odd_toggle_out;
    logic dbg_channel_detected;
    logic dbg_roic_even_odd;
    logic dbg_roic_1st_channel;


    logic s_rf_spi_sen;
    logic [191:0] sdoutWord;
    logic s_spiReady;
    logic s_spidut_en_1d;
    logic s_spidut_en_2d;

    assign RF_SPI_SEN = {12{s_rf_spi_sen}};

    logic s_IRST;
    logic s_SHR;
    logic s_SHS;
    logic s_LPF1;
    logic s_LPF2;
    logic s_TDEF;
    logic s_GATE_ON;
    logic s_DF_SM0;
    logic s_DF_SM1;
    logic s_DF_SM2;
    logic s_DF_SM3;
    logic s_DF_SM4;
    logic s_DF_SM5;

    /**
     * @brief TI ROIC SPI for register set .
     */
    roic_spi ti_roic_spi_inst (
        .reset      (deser_reset),
        .clk        (s_clk_5mhz),
        .address    (ti_roic_reg_addr[7:0]),
        .data       (ti_roic_reg_data),
        .DUT_EN     (ti_roic_reg_addr[15]),
        .spiReady   (s_spiReady),
        .DUT_SDOUT  (s_roic_sdio),
        .DUT_SCLK   (RF_SPI_SCK),
        .DUT_SDATA  (RF_SPI_SDI[0]),
        .DUT_SEN    (s_rf_spi_sen),
        .sdoutWord  (sdoutWord)
    );

    always_ff @(posedge s_clk_5mhz or posedge deser_reset) begin
        if (deser_reset) begin
            s_spidut_en_1d <= 1'b0;
            s_spidut_en_2d <= 1'b0;
        end else begin
            s_spidut_en_1d <= ti_roic_reg_addr[15];
            s_spidut_en_2d <= s_spidut_en_1d;
        end
    end

    assign s_spiReady = s_spidut_en_1d & ~s_spidut_en_2d;

    ti_roic_tg roic_tg_gen_int(
        .clk                (s_clk_20mhz),
        .rst                (deser_reset),
        .str                (ti_roic_str),
        .sync_in            (s_roic_sync_in),
        .tp_sel             (s_roic_tp_sel),
        .aed_detect_skip_oe (s_aed_detect_skip_oe_o),
        .fsm_read_index     (s_sync_fsm_read_index),
        .reg_en             (ti_roic_reg_addr[15]),
        .reg_addr           (ti_roic_reg_addr[7:0]),
        .reg_data           (ti_roic_reg_data),
        .sync_start         (gen_sync_start),   
        .readout_width      (),
        .tg_row_cnt         (tg_row_cnt),
        .tg_col_cnt         (tg_col_cnt),
        .roic_sync_out      (s_roic_sync_out),
        .roic_a_bz          (s_roic_a_bz),
        //
        .tg_stv             (s_tg_stv),
        .tg_cpv             (s_tg_cpv),
        .tg_oe              (s_tg_oe),
        .v_sync             (),
        .IRST               (s_IRST),
        .SHR                (s_SHR),
        .SHS                (s_SHS),
        .LPF1               (s_LPF1),
        .LPF2               (s_LPF2),
        .TDEF               (s_TDEF),
        .GATE_ON            (s_GATE_ON),
        .DF_SM0             (s_DF_SM0),
        .DF_SM1             (s_DF_SM1),
        .DF_SM2             (s_DF_SM2),
        .DF_SM3             (s_DF_SM3),
        .DF_SM4             (s_DF_SM4),
        .DF_SM5             (s_DF_SM5)
    );


    assign deser_reset = ti_roic_deser_reset;
    assign align_to_fclk = ti_roic_deser_align_mode;
    assign align_start = ti_roic_deser_align_start;

    generate
        always_ff @(posedge eim_clk or posedge s_reset) begin
            if (s_reset) begin
                for (int i = 0; i < 12; i++) begin
                    extra_shift[i] = 4'd0;
                    ti_roic_deser_align_shift[i] = 4'd0;
                    ti_roic_deser_align_done[i] = 1'b0;
                end
            end else begin
                for (int i = 0; i < 12; i++) begin
                    extra_shift[i] = ti_roic_deser_shift_set[i];
                    ti_roic_deser_align_shift[i] = shift_out[i];
                    ti_roic_deser_align_done[i] = align_done[i];
                end
            end
        end
    endgenerate

        //     ti_roic_top #(
        //         .DATA_WIDTH    (WORD_SIZE),     // 24-bit data width
        //         .IOSTANDARD    ("LVDS_25"),     // LVDS_25 standard for test environment
        //         .REFCLK_FREQ   (200.0),         // 200MHz reference clock frequency
        //         .PATTERN_1     (24'hFFF000),    // First alignment pattern
        //         .PATTERN_2     (24'hFF0000)     // Second alignment pattern
        //     ) ti_roic_top_inst_0 (
        //         // Control and reset inputs
        //         .clk_reset          (s_reset),
        //         .data_reset         (deser_reset),

        //         // LVDS differential inputs
        //         .fclk_in_p           (R_ROIC_FCLKo_p[0]),
        //         .fclk_in_n           (R_ROIC_FCLKo_n[0]),
        //         // LVDS differential inputs
        //         .clk_in_p           (R_ROIC_DCLKo_p[0]),
        //         .clk_in_n           (R_ROIC_DCLKo_n[0]),
        //         .data_in_p          (R_DOUTA_H[0]),
        //         .data_in_n          (R_DOUTA_L[0]),

        //         // Delay control interface
        //         .ld_dly_tap         (ld_dly_tap),
        //         .delay_data_ce      (in_delay_data_ce),
        //         .delay_data_inc     (in_delay_data_inc),
        //         .delay_tap_in       (in_delay_tap_in),
        //         .delay_tap_out      (in_delay_tap_out[0]),

        //         // Bit alignment control
        //         .align_to_fclk      (align_to_fclk),
        //         .align_start        (align_start),
        //         .extra_shift        (extra_shift[0]),

        //         // Data reordering control
        //         .sync               (ti_roic_sync),

        //         .data_read_req      (data_read_req[0]),

        //         .data_read_clk      (s_axi_clk_200M),

        //         // ila check
        //         .deser_data         (deser_data[0]),
        //         .aligned_data       (aligned_data[0]),

        //         .fclk_out           (s_fclk_in[0]),

        //         // Output signals
        //         .bit_clk            (bit_clk[0]),
        //         .shift_out          (shift_out[0]),
        //         .align_done         (align_done[0]),
        //         .valid_read_enable  (valid_read_enable[0]),
        //         .reordered_data_a   (reordered_data_a[0]),
        //         .reordered_data_b   (reordered_data_b[0]),
        //         .reordered_valid    (reordered_valid[0]),
        //         .channel_detected   (channel_detected[0])
        //     );


    genvar i;
    generate
        for (i = 0; i < 12; i++) begin : gen_ti_roic_top
            ti_roic_top #(
                .DATA_WIDTH    (WORD_SIZE),     // 24-bit data width
                .IOSTANDARD    ("LVDS_25"),     // LVDS_25 standard for test environment
                .REFCLK_FREQ   (200.0),         // 200MHz reference clock frequency
                .PATTERN_1     (24'hFFF000),    // First alignment pattern
                .PATTERN_2     (24'hFF0000)     // Second alignment pattern
            ) ti_roic_top_inst (
                // Control and reset inputs
                .clk_reset          (s_reset),
                .data_reset         (deser_reset),
                // LVDS differential inputs
                .fclk_in_p           (R_ROIC_FCLKo_p[i]),
                .fclk_in_n           (R_ROIC_FCLKo_n[i]),
                // LVDS differential inputs
                .clk_in_p           (R_ROIC_DCLKo_p[i]),
                .clk_in_n           (R_ROIC_DCLKo_n[i]),
                .data_in_p          (R_DOUTA_H[i]),
                .data_in_n          (R_DOUTA_L[i]),

                // Bit alignment control
                .align_to_fclk      (align_to_fclk),
                .align_start        (align_start),
                .extra_shift        (extra_shift[i]),

                // Data reordering control
                .en_test_pattern_col    (en_test_pattern_col),
                .en_test_pattern_row    (en_test_pattern_row),

                .sync               (s_roic_sync_out),

                .data_read_req      (data_read_req[i]),

                .data_read_clk      (s_dphy_clk_200M),

                //for debug signal
                .even_odd_toggle_out (s_even_odd_toggle_out[i]),
                .roic_even_odd_out  (s_roic_even_odd_out[i]),

                // Output signals
                .shift_out          (shift_out[i]),
                .align_done         (align_done[i]),
                .valid_read_enable  (valid_read_enable[i]),
                .reordered_data_a   (reordered_data_a[i]),
                .reordered_data_b   (reordered_data_b[i]),
                .reordered_valid    (reordered_valid[i]),
                .detected_data_out  (detected_data_out[i]),
                .channel_detected   (channel_detected[i])
            );
        end
    endgenerate

    assign s_sum_channel_detected = |(channel_detected & align_done);

    // //========================================================================
    // // IDELAYCTRL Instance for Deser_by8_group
    // //========================================================================
    // (* IODELAY_GROUP = "Deser_by8_group" *)
    // IDELAYCTRL idelayctrl_inst (
    //     .RDY        (),
    //     .REFCLK     (s_axi_clk_200M),
    //     .RST        (s_reset)
    // );


    // read_data_mux module instantiation
    assign valid_roic_data = |valid_read_enable;

    assign valid_read_mem = |reordered_valid;

    read_data_mux read_data_mux_inst (
        .sys_clk                (s_clk_100mhz),
        .sys_rst                (sys_rst),
        .eim_clk                (eim_clk),
        .eim_rst                (eim_rst),
        .csi_done               (s_csi_done),
        .dummy_get_image        (dummy_get_image),
        .exist_get_image        (),
        .dsp_image_height       (dsp_image_height),
        .max_v_count            (max_v_count),
        .max_h_count            (max_h_count),
        .FSM_aed_read_index     (FSM_aed_read_index),
        .read_data_start        (s_read_data_start),
        .FSM_read_index         (s_valid_readout),
        .roic_read_data_a       (reordered_data_a),
        .roic_read_data_b       (reordered_data_b),
        .valid_read_mem         (valid_read_mem),
        .read_axis_tready       (s_read_axis_tready),
        .read_axis_tlast        (s_read_axis_tlast),
        .read_data_valid        (s_read_axis_tvalid),
        .read_data_out_a        (s_read_rx_data_a),
        .read_data_out_b        (s_read_rx_data_b),
        .read_frame_start       (s_read_frame_start),
        .read_frame_reset       (s_read_frame_reset),
        .data_read_req          (data_read_req)
    );

    assign PREP_ACK = PREP_REQ;

    assign s_config_done_i = (seq_lut_config_done || s_reg_roic_sync) ? 1'b1 : 1'b0;

    always_ff @(posedge s_clk_20mhz or negedge rst) begin
        if (~rst) begin
            s_test_cnt <= '0;
        end else begin
            s_test_cnt <= s_test_cnt + 1'b1;
        end
    end

    dcdc_clk dcdc_clk_inst (
        .clk        (s_clk_20mhz),
        .reset_n    (sys_rst),
        .clk_1M_o   (s_clk_1mhz),
        .clk_5M_o   (s_clk_5mhz)
    );

    assign SWITCH_SYNC = s_clk_1mhz;

    // ========================================================
    // Controls signals
    // ========================================================

    assign s_roic_sdio = RF_SPI_SDO;

    always_ff @(posedge s_clk_20mhz or posedge deser_reset) begin
        if (deser_reset) begin
            ti_roic_sync <= 1'b0;
            ti_roic_tp_sel <= 1'b0;
            s_roic_tp_sel <= 1'b0;
            s_roic_sync_in <= 1'b0;
        end else begin
            ti_roic_sync <= s_roic_sync_out;
            ti_roic_tp_sel <= (s_reg_tp_sel | s_wait_tp_sel);  

            s_roic_tp_sel <= (s_reg_tp_sel | s_wait_tp_sel);  
            s_roic_sync_in <= (s_reg_roic_sync | s_wait_roic_sync);
        end
    end


    always_ff @(posedge s_clk_20mhz or posedge deser_reset) begin
        if (deser_reset) begin
            s_gen_sync_start_dly <= 2'd0;
            s_gen_sync_start_rise <= 1'b0;
            s_sync_repeat_cnt <= 32'd0;
            s_sync_col_cnt <= 16'd0;
            s_sync_stv_mask_o <= 1'b0;
            s_sync_csi_mask_o <= 1'b0;
            s_sync_current_repeat_count_o <= 32'd0;
            s_sync_config_done <= 1'b0;
            s_sync_fsm_read_index <= 1'b0;
            s_sync_fsm_flush_index <= 1'b0;
            s_sync_fsm_back_bias_index <= 1'b0;
        end else begin

            if (s_gen_sync_start_rise) begin
                s_sync_repeat_cnt <= active_repeat_count_o;
                s_sync_stv_mask_o <= stv_mask_o;
                s_sync_csi_mask_o <= csi_mask_o;
                s_sync_current_repeat_count_o <= current_repeat_count_o;
                s_sync_config_done <= s_config_done_i;
                s_sync_fsm_read_index <= FSM_read_index;
                s_sync_fsm_flush_index <= FSM_flush_index;
                s_sync_fsm_back_bias_index <= FSM_back_bias_index;
            end 

            if (s_gen_sync_start_rise) begin
                s_sync_col_cnt <= 16'd0;
            end else begin
                s_sync_col_cnt <= s_sync_col_cnt + 1'b1;
            end

            s_gen_sync_start_dly <= {s_gen_sync_start_dly[0], gen_sync_start};
            s_gen_sync_start_rise <= ~s_gen_sync_start_dly[1] & s_gen_sync_start_dly[0];
        end
    end

    // ========================================================
    // Sync processing
    // ========================================================
    // fifo_1b #(
    //     .DATA_WIDTH    (1),
    //     .DEPTH         (1)
    // ) fifo_sync_get_imgae_inst (
    //     .rst        (s_reset),
    //     .clk        (s_clk_20mhz),
    //     .wr_en      (s_gen_sync_start_rise),
    //     .rd_en      (s_readout_exist_rise),
    //     .din        (1'b1),
    //     .dout       (gen_sync_start),
    //     .full       (),
    //     .empty      ()
    // );


    // LED indicator for internal states

    always_comb begin
        case (s_state_led_ctr)
            8'h00: STATE_LED1 = s_test_cnt[23];
            8'h01: STATE_LED1 = FSM_idle_index;
            8'h02: STATE_LED1 = FSM_read_index;
            8'h03: STATE_LED1 = FSM_exp_index;
            8'h04: STATE_LED1 = FSM_aed_read_index;
            8'h05: STATE_LED1 = s_sync_fsm_flush_index;
            8'h06: STATE_LED1 = s_sync_fsm_back_bias_index;
            8'h07: STATE_LED1 = FSM_wait_index;
            8'h08: STATE_LED1 = FSM_rst_index;
            8'h09: STATE_LED1 = valid_roic_data;
            8'h0A: STATE_LED1 = valid_read_mem;
            8'h0B: STATE_LED1 = s_sync_fsm_read_index;
            8'h20: STATE_LED1 = channel_detected[0];
            8'h21: STATE_LED1 = channel_detected[1];
            8'h22: STATE_LED1 = channel_detected[2];
            8'h23: STATE_LED1 = channel_detected[3];
            8'h24: STATE_LED1 = channel_detected[4];
            8'h25: STATE_LED1 = channel_detected[5];
            8'h26: STATE_LED1 = channel_detected[6];
            8'h27: STATE_LED1 = channel_detected[7];
            8'h28: STATE_LED1 = channel_detected[8];
            8'h29: STATE_LED1 = channel_detected[9];
            8'h2A: STATE_LED1 = channel_detected[10];
            8'h2B: STATE_LED1 = channel_detected[11];
            8'h30: STATE_LED1 = s_read_frame_start;
            8'h31: STATE_LED1 = s_read_frame_reset;
            8'h32: STATE_LED1 = s_read_axis_tvalid;
            8'h33: STATE_LED1 = s_read_axis_tlast;
            8'h34: STATE_LED1 = s_read_axis_tready;
            8'h40: STATE_LED1 = s_IRST;
            8'h41: STATE_LED1 = s_SHR;
            8'h42: STATE_LED1 = s_SHS;
            8'h43: STATE_LED1 = s_LPF1;
            8'h44: STATE_LED1 = s_LPF2;
            8'h45: STATE_LED1 = s_TDEF;
            8'h46: STATE_LED1 = s_GATE_ON;
            8'h47: STATE_LED1 = s_DF_SM0;
            8'h48: STATE_LED1 = s_DF_SM1;
            8'h49: STATE_LED1 = s_DF_SM2;
            8'h4A: STATE_LED1 = s_DF_SM3;
            8'h4B: STATE_LED1 = s_DF_SM4;
            8'h4C: STATE_LED1 = s_DF_SM5;
            8'h4D: STATE_LED1 = s_roic_sdio[0];
            8'h4E: STATE_LED1 = s_sum_channel_detected;
            8'h4F: STATE_LED1 = gen_sync_start;
            8'h50: STATE_LED1 = s_aed_trig;
            8'h51: STATE_LED1 = exit_signal_i;
            8'h52: STATE_LED1 = panel_stable_o;
            8'h53: STATE_LED1 = s_exp_read_exist;
            8'h54: STATE_LED1 = s_get_dark_hi;
            8'h55: STATE_LED1 = s_exit_signal_dark;
            8'h56: STATE_LED1 = s_get_bright_hi;
            8'h57: STATE_LED1 = s_exit_signal_bright;
            8'h58: STATE_LED1 = s_get_aed_trig_hi;
            8'h59: STATE_LED1 = s_exit_signal_aed;
            8'h5A: STATE_LED1 = sequence_done_o;
            8'h5B: STATE_LED1 = s_sequence_done_hi;
            8'h60: STATE_LED1 = s_tg_stv;
            8'h61: STATE_LED1 = s_mask_stv;
            8'h62: STATE_LED1 = s_back_bias;
            8'h63: STATE_LED1 = s_roic_sync_in;
            8'h64: STATE_LED1 = ti_roic_sync;
            8'h65: STATE_LED1 = s_readout_wait;
            8'h66: STATE_LED1 = s_valid_readout;
            8'h67: STATE_LED1 = stv_mask_o;
            8'h68: STATE_LED1 = csi_mask_o;
            8'h69: STATE_LED1 = s_clk_5mhz;
            8'h6A: STATE_LED1 = s_clk_1mhz;
            8'h6B: STATE_LED1 = s_aed_mode_exist;
            8'h6C: STATE_LED1 = s_aed_trig_i;
            8'h6D: STATE_LED1 = s_get_bright;
            8'h6E: STATE_LED1 = aed_ready_done;
            8'h6F: STATE_LED1 = s_state_exit_flag;
            default: STATE_LED1 = 1'b0;
        endcase
    end

    // for debug purpose
    assign dbg_channel_detected = channel_detected[0];
    assign dbg_roic_1st_channel = detected_data_out[0][7];
    assign dbg_roic_even_odd = detected_data_out[0][6];
    assign dbg_even_odd_toggle_out = s_IRST;

    assign DEBUG_SiG = {dbg_even_odd_toggle_out, dbg_roic_even_odd, dbg_channel_detected, dbg_roic_1st_channel};


endmodule
