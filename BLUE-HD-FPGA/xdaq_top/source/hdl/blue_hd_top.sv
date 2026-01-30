`timescale 1ns / 1ps
`include "./p_define.sv"

//==============================================================================
// Module: blue_hd_top
// Description: BLUE-HD FPGA Top Module - SystemVerilog Implementation
// Designer: drake.lee
// Date: 2025.05.19
// Target: BLUE-HD Board (Cyan HD, 100um design)
// FPGA: XC7A35T-FGG484 (Artix-7)
// Vivado: 2025.2
//
// Revision History:
//    2025.05.19 - Initial conversion from VHDL to SystemVerilog
//    2026.01.15 - Refactored: removed magic numbers, added constants, extracted functions
//    2026.01.29 - Updated for 14-channel ROIC (Cyan board)
//
// Description:
//   Top-level module for BLUE-HD FPGA project integrating:
//   - 14-channel TI ROIC LVDS interface (2.34 MHz)
//   - MIPI CSI-2 TX output (4-lane, D-PHY)
//   - Gate drive control (8x XAO, 10x STV signals)
//   - SPI slave interface for register access
//   - Sequencer FSM for image acquisition control
//   - Multi-clock domain system (100MHz, 200MHz, 20MHz, 5MHz, 1MHz)
//
//==============================================================================


module blue_hd_top (
    //==========================================================================
    // System Signals
    //==========================================================================
    input   logic        nRST,                // Global reset (active low)
    input   logic        MCLK_50M_p,          // 50MHz LVDS clock (positive)
    input   logic        MCLK_50M_n,          // 50MHz LVDS clock (negative)

    //==========================================================================
    // MIPI CSI-2 Interface (4-lane TX)
    //==========================================================================
    output  logic        mipi_phy_if_clk_hs_p,   // MIPI HS clock (positive)
    output  logic        mipi_phy_if_clk_hs_n,   // MIPI HS clock (negative)
    output  logic        mipi_phy_if_clk_lp_p,   // MIPI LP clock (positive)
    output  logic        mipi_phy_if_clk_lp_n,   // MIPI LP clock (negative)
    output  logic [3:0]  mipi_phy_if_data_hs_p,  // MIPI HS data [3:0] (positive)
    output  logic [3:0]  mipi_phy_if_data_hs_n,  // MIPI HS data [3:0] (negative)
    output  logic [3:0]  mipi_phy_if_data_lp_p,  // MIPI LP data [3:0] (positive)
    output  logic [3:0]  mipi_phy_if_data_lp_n,  // MIPI LP data [3:0] (negative)

    //==========================================================================
    // CPU SPI Interface (Control/Register Access)
    //==========================================================================
    input   logic        SCLK,                // SPI clock
    input   logic        SSB,                 // SPI slave select
    input   logic        MOSI,                // SPI master out slave in
    output  logic        MISO,                // SPI master in slave out

    //==========================================================================
    // ROIC Control Signals
    //==========================================================================
    output  logic        ROIC_TP_SEL,         // ROIC test pattern select
    output  logic        ROIC_SYNC,            // ROIC sync signal
    output  logic        ROIC_MCLK0,           // ROIC clock output 0 (20MHz)
    output  logic        ROIC_MCLK1,           // ROIC clock output 1 (20MHz)

    //==========================================================================
    // ROIC SPI Interface (NUM_ROIC channels for chip enable)
    //==========================================================================
    output  logic        ROIC_SPI_SCK,         // ROIC SPI clock
    output  logic        ROIC_SPI_SDI,         // ROIC SPI data in
    input   logic        ROIC_SPI_SDO,         // ROIC SPI data out
    output  logic [`NUM_ROIC-1:0] ROIC_SPI_SEN_N,  // ROIC SPI chip enable [`NUM_ROIC-1:0]

    //==========================================================================
    // TI ROIC LVDS Channels (NUM_ROIC channels from p_define.sv)
    //==========================================================================
    // Data Clock (DCLK) - Differential pairs
    input   logic [`NUM_ROIC-1:0]  DCLKP,      // DCLK positive [`NUM_ROIC-1:0]
    input   logic [`NUM_ROIC-1:0]  DCLKN,      // DCLK negative [`NUM_ROIC-1:0]

    // Frame Clock (FCLK) - Differential pairs
    input   logic [`NUM_ROIC-1:0]  FCLKP,      // FCLK positive [`NUM_ROIC-1:0]
    input   logic [`NUM_ROIC-1:0]  FCLKN,      // FCLK negative [`NUM_ROIC-1:0]

    // Data Output (DOUT) - Differential pairs
    input   logic [`NUM_ROIC-1:0]  DOUTP,      // DOUT positive [`NUM_ROIC-1:0]
    input   logic [`NUM_ROIC-1:0]  DOUTN,      // DOUT negative [`NUM_ROIC-1:0]

    //==========================================================================
    // Gate Drive Signals
    //==========================================================================
    // STV (Scan Timing Vertical) signals
    output  logic        GF_STV_L,             // Gate STV Left
    output  logic        GF_STV_LR1, GF_STV_LR2, GF_STV_LR3, GF_STV_LR4,  // STV LR [1:4]
    output  logic        GF_STV_LR5, GF_STV_LR6, GF_STV_LR7, GF_STV_LR8,  // STV LR [5:8]
    output  logic        GF_STV_R,             // Gate STV Right

    // XAO (X-Axis Output) phase control signals (8 channels, numbered 1-8)
    output  logic        GF_XAO_1, GF_XAO_2, GF_XAO_3, GF_XAO_4,  // XAO [1:4]
    output  logic        GF_XAO_5, GF_XAO_6, GF_XAO_7, GF_XAO_8,  // XAO [5:8]

    // Gate drive control
    output  logic        GF_CPV,               // Gate pulse voltage
    output  logic        GF_OE,                // Output enable

    //==========================================================================
    // ROIC Power Control
    //==========================================================================
    output  logic        ROIC_AVDD1,           // ROIC AVDD1 power control
    output  logic        ROIC_AVDD2,           // ROIC AVDD2 power control

    //==========================================================================
    // Trigger Signals
    //==========================================================================
    input   logic        PREP_REQ,             // Prepare request
    input   logic        EXP_REQ,              // Expose request
    output  logic        PREP_ACK,             // Prepare acknowledge
    output  logic        EXP_ACK,              // Expose acknowledge

    //==========================================================================
    // Debug & Status Signals
    //==========================================================================
    output  logic [3:0]  DEBUG_SiG,            // Debug signals [3:0]
    output  logic        STATE_LED1,           // Status LED 1
    output  logic        STATE_LED2            // Status LED 2

);


    //==========================================================================
    // Localparam Constants - Replacing magic numbers
    //==========================================================================

    // SPI Packet Parameters
    localparam int SPI_HEADER     = 2;                           // SPI header size
    localparam int SPI_PAYLOAD    = 16;                          // SPI payload size (bits)
    localparam int SPI_ADDRSZ     = 14;                          // SPI address size (bits)
    localparam int SPI_PKTSZ      = 32;                          // Total packet size (header + addr + payload)

    // Timing and Synchronization Constants
    localparam int SYNC_DELAY_THRESHOLD     = 3;                 // Sync delay threshold
    localparam int XAO_PHASE_COUNT          = 6;                 // Number of XAO phases
    localparam int COLUMN_END_ZERO          = 0;                 // Column end detection value
    localparam int COLUMN_MAX_COUNT         = 1024;              // Maximum column count

    // TI ROIC Parameters
    localparam int TI_ROIC_WORD_SIZE     = 24;                   // 24-bit data word width
    localparam real TI_ROIC_REFCLK_FREQ   = 200.0;               // Reference clock frequency (MHz)

    // Alignment Patterns for bit synchronization
    localparam logic [23:0] TI_ROIC_PATTERN_1 = 24'hFFF000;      // First alignment pattern
    localparam logic [23:0] TI_ROIC_PATTERN_2 = 24'hFF0000;      // Second alignment pattern

    //==========================================================================
    // Clock Domain Signals
    //==========================================================================
    logic s_clk_100mhz;                          // 100MHz system clock
    logic s_dphy_clk_200M;                       // 200MHz DPHY clock
    logic s_clk_20mhz;                           // 20MHz FSM clock
    logic s_clk_5mhz;                            // 5MHz SPI clock
    logic s_clk_1mhz;                            // 1MHz reference clock

    //==========================================================================
    // Reset and Control Signals
    //==========================================================================
    logic s_reset;                               // Global reset (from nRST)
    logic s_csi2_reset;                          // MIPI CSI-2 reset
    logic rst;                                   // Main system reset
    logic sys_rst;                               // System reset (100MHz domain)
    logic eim_rst;                               // EIM clock domain reset
    logic fsm_drv_rst;                           // FSM driver reset
    logic init_rst;                              // Initialization reset
    logic s_roic_reset;                          // ROIC reset
    logic deser_reset;                           // Deserializer reset

    //==========================================================================
    // System Control Signals
    //==========================================================================
    logic en_pwr_off;                            // Power off enable
    logic en_pwr_dwn;                            // Power down enable
    logic system_rst;                             // System reset request
    logic reset_FSM;                             // FSM reset
    logic org_reset_FSM;                         // Original FSM reset

    //==========================================================================
    // Power Initialization Sequence
    //==========================================================================
    logic s_pwr_init_step1;                      // Power init step 1
    logic s_pwr_init_step2;                      // Power init step 2
    logic s_pwr_init_step3;                      // Power init step 3
    logic s_pwr_init_step4;                      // Power init step 4
    logic s_pwr_init_step5;                      // Power init step 5
    logic s_pwr_init_step6;                      // Power init step 6

    //==========================================================================
    // ROIC Control Signals
    //==========================================================================
    logic s_roic_tp_sel;                         // ROIC test pattern select
    logic s_roic_sync_in;                        // ROIC sync input
    logic s_roic_sync_out;                       // ROIC sync output
    logic s_roic_a_bz;                           // ROIC active blanking
    logic s_roic_sdio;                           // ROIC SPI data I/O (single bidirectional)

    //==========================================================================
    // FSM Index Signals
    //==========================================================================
    logic FSM_rst_index;                         // FSM reset state index
    logic FSM_wait_index;                        // FSM wait state index
    logic FSM_back_bias_index;                   // FSM back bias state index
    logic FSM_flush_index;                       // FSM flush state index
    logic FSM_aed_read_index;                    // FSM AED read state index
    logic FSM_exp_index;                         // FSM expose state index
    logic FSM_read_index;                        // FSM readout state index
    logic FSM_idle_index;                        // FSM idle state index
    logic FSM_index_all;                         // FSM all index

    //==========================================================================
    // Image Acquisition Control
    //==========================================================================
    logic ready_to_get_image;                    // Ready to acquire image
    logic aed_ready_done;                        // AED ready done
    logic aed_ready_done_dark;                   // AED ready done (dark)
    logic panel_stable_o;                        // Panel stable output
    logic s_exp_read_exist;                      // Expose read exists

    logic dummy_get_image;                       // Dummy image acquisition
    logic burst_get_image;                       // Burst image acquisition
    logic get_dark;                              // Get dark frame
    logic get_bright;                            // Get bright frame
    logic cmd_get_bright;                        // Command get bright
    logic s_get_bright;                          // Synchronous get bright

    //==========================================================================
    // Counter and Timing Signals
    //==========================================================================
    logic [15:0] row_cnt;                        // Row counter
    logic [15:0] col_cnt;                        // Column counter
    logic [15:0] s_sync_col_cnt;                 // Sync column counter
    logic [15:0] tg_row_cnt;                     // Timing generator row counter
    logic [10:0] tg_col_cnt;                     // Timing generator column counter

    logic col_end;                               // Column end flag

    //==========================================================================
    // Gate Drive Control Signals
    //==========================================================================
    logic [15:0] up_back_bias;                   // Upper back bias
    logic [15:0] down_back_bias;                 // Lower back bias
    logic [15:0] dn_aed_gate_xao [0:5];          // Down AED gate XAO [5:0]
    logic [15:0] up_aed_gate_xao [0:5];          // Up AED gate XAO [5:0]
    logic s_back_bias;                           // Back bias signal

    logic gate_xao;                              // Gate XAO [5]
    logic gate_xao_0;                            // Gate XAO [0]
    logic gate_xao_1;                            // Gate XAO [1]
    logic gate_xao_2;                            // Gate XAO [2]
    logic gate_xao_3;                            // Gate XAO [3]
    logic gate_xao_4;                            // Gate XAO [4]

    //==========================================================================
    // Timing Generator Signals
    //==========================================================================
    logic s_tg_stv;                              // TG STV signal
    logic s_tg_cpv;                              // TG CPV signal
    logic s_tg_oe;                               // TG OE signal
    logic s_mask_stv;                            // Masked STV signal

    //==========================================================================
    // Data Validation Signals
    //==========================================================================
    logic valid_roic_out;                        // Valid ROIC output
    logic valid_roic_burst_clk;                  // Valid ROIC burst clock
    logic valid_roic_reg_out;                    // Valid ROIC register output
    logic valid_roic_header_out;                 // Valid ROIC header output
    logic valid_roic_data;                       // Valid ROIC data
    logic valid_aed_test_data;                   // Valid AED test data
    logic s_valid_readout;                       // Synchronous valid readout

    //==========================================================================
    // SPI Slave Interface Signals
    //==========================================================================
    logic s_spi_start_flag;                      // SPI start flag
    logic s_addr_dv;                             // Address data valid
    logic s_rw_out;                              // Read/write output
    logic s_reg_read_index;                      // Register read index

    logic [SPI_ADDRSZ-1:0] s_reg_addr;           // Register address
    logic [SPI_PAYLOAD-1:0] s_reg_data;          // Register data
    logic s_reg_addr_index;                      // Register address index
    logic s_reg_data_index;                      // Register data index

    logic [15:0] reg_read_out;                    // Register read output
    logic read_data_en;                          // Read data enable
    logic [15:0] s_reg_read_out_old;              // Old register read output
    logic [15:0] s_reg_read_out_new;              // New register read output
    logic s_read_data_en;                        // Synchronous read data enable
    logic [15:0] s_reg_address;                   // Register address (extended)

    //==========================================================================
    // MIPI CSI-2 Interface Signals
    //==========================================================================
    logic s_clk_lock;                            // Clock locked flag
    logic s_csi_done;                            // CSI done flag
    logic s_read_frame_start;                    // Read frame start
    logic s_read_frame_reset;                    // Read frame reset
    logic s_read_axis_tready;                    // Read AXI stream ready
    logic s_read_axis_tlast;                     // Read AXI stream last
    logic s_read_axis_tvalid;                    // Read AXI stream valid
    logic [0:0] s_axis_video_tuser;               // AXI video user signal
    logic [23:0] s_axis_tdata_a;                 // AXI data A channel
    logic [23:0] s_axis_tdata_b;                 // AXI data B channel
    logic [23:0] s_read_rx_data_a;                // Read RX data A
    logic [23:0] s_read_rx_data_b;                // Read RX data B

    //==========================================================================
    // Sequencer FSM Signals
    //==========================================================================
    logic s_seq_reset;                           // Sequencer reset
    logic [7:0] seq_lut_addr;                    // Sequence LUT address
    logic [63:0] seq_lut_data;                   // Sequence LUT data
    logic seq_lut_wr_en;                         // Sequence LUT write enable
    logic [63:0] seq_lut_read_data;              // Sequence LUT read data
    logic [15:0] seq_state_read;                 // Sequence state read
    logic seq_lut_config_done;                   // Sequence LUT config done
    logic [15:0] seq_lut_control;                // Sequence LUT control
    logic [2:0] acq_mode;                        // Acquisition mode
    logic [31:0] acq_expose_size;                 // Acquisition expose size
    logic [2:0] acq_mode_o;                      // Acquisition mode output
    logic [31:0] expose_size_o;                  // Expose size output

    logic s_config_done_i;                       // Config done input
    logic s_sync_config_done;                    // Sync config done
    logic exit_signal_i;                         // Exit signal input
    logic s_state_exit_flag;                     // State exit flag

    //==========================================================================
    // Sequencer FSM State Outputs
    //==========================================================================
    logic [3:0] current_state_o;                 // Current state output
    logic busy_o;                                // Busy output
    logic sequence_done_o;                       // Sequence done output
    logic reset_state_o;                         // Reset state output
    logic wait_o;                                // Wait output
    logic bias_enable_o;                         // Bias enable output
    logic flush_enable_o;                        // Flush enable output
    logic expose_enable_o;                       // Expose enable output
    logic readout_enable_o;                      // Readout enable output
    logic aed_enable_o;                          // AED enable output
    logic stv_mask_o;                            // STV mask output
    logic csi_mask_o;                            // CSI mask output
    logic idle_elable_o;                         // Idle enable output
    logic iterate_exist_o;                       // Iterate exist output

    //==========================================================================
    // Sequencer Frame Signals
    //==========================================================================
    logic current_sof_o;                         // Current start of frame
    logic current_eof_o;                         // Current end of frame
    logic [31:0] active_repeat_count_o;          // Active repeat count output
    logic [31:0] current_repeat_count_o;         // Current repeat count output
    logic [31:0] valid_repeat_count_o;           // Valid repeat count output
    logic [18:0] current_data_length_o;           // Current data length output

    //==========================================================================
    // Sync Control Signals
    //==========================================================================
    logic s_wait_sync;                           // Wait sync
    logic [2:0] s_wait_sync_dly;                  // Wait sync delay
    logic s_wait_tp_sel;                         // Wait TP select
    logic s_wait_roic_sync;                      // Wait ROIC sync
    logic s_sync_xao_enable;                     // Sync XAO enable
    logic s_sync_fsm_read_index;                 // Sync FSM read index
    logic s_sync_fsm_flush_index;                // Sync FSM flush index
    logic s_sync_fsm_back_bias_index;            // Sync FSM back bias index
    logic s_sync_stv_mask_o;                     // Sync STV mask output
    logic s_sync_csi_mask_o;                     // Sync CSI mask output
    logic [31:0] s_sync_current_repeat_count_o; // Sync current repeat count output
    logic [31:0] s_sync_repeat_cnt;               // Sync repeat count
    logic [2:0] s_sync_repeat_cnt_mod;            // Sync repeat count modulo

    //==========================================================================
    // Delay Registers
    //==========================================================================
    logic [1:0] s_get_dark_dly;                  // Get dark delay
    logic [1:0] s_get_bright_dly;                 // Get bright delay
    logic [1:0] s_get_aed_trig_dly;               // Get AED trigger delay
    logic [1:0] s_sequence_done_dly;              // Sequence done delay
    logic s_get_dark_hi;                         // Get dark high
    logic s_get_bright_hi;                       // Get bright high
    logic s_get_aed_trig_hi;                     // Get AED trigger high
    logic s_sequence_done_hi;                    // Sequence done high

    //==========================================================================
    // Exit Signal State Machine
    //==========================================================================
    logic s_exit_signal_dark;                    // Exit signal dark
    logic s_exit_signal_bright;                   // Exit signal bright
    logic s_exit_signal_aed;                     // Exit signal AED
    logic s_aed_mode_exist;                      // AED mode exists

    //==========================================================================
    // AED Control
    //==========================================================================
    logic en_aed;                                // Enable AED
    logic s_aed_trig;                            // AED trigger
    logic s_aed_trig_i;                          // AED trigger input
    logic en_panel_stable;                       // Enable panel stable
    logic s_readout_wait;                        // Readout wait
    logic s_read_data_start;                     // Read data start
    logic s_aed_detect_skip_oe_o;               // AED detect skip OE output

    //==========================================================================
    // Test Pattern Control
    //==========================================================================
    logic en_16bit_adc;                          // Enable 16-bit ADC
    logic en_test_pattern_col;                   // Enable test pattern column
    logic en_test_pattern_row;                   // Enable test pattern row
    logic en_test_roic_col;                      // Enable test ROIC column
    logic en_test_roic_row;                      // Enable test ROIC row

    //==========================================================================
    // Gate Control Signals
    //==========================================================================
    logic sig_gate_lr1;                         // Signal gate LR1
    logic sig_gate_lr2;                         // Signal gate LR2

    //==========================================================================
    // Display Parameters
    //==========================================================================
    logic [15:0] dsp_image_height;               // Display image height
    logic [15:0] max_h_count;                     // Maximum horizontal count
    logic [15:0] max_v_count;                     // Maximum vertical count
    logic [15:0] csi2_word_count;                 // CSI-2 word count

    //==========================================================================
    // Test and Debug Signals
    //==========================================================================
    logic [15:0] trigger_data_1;                 // Trigger data 1
    logic [15:0] trigger_data_2;                 // Trigger data 2
    logic [15:0] trigger_data_3;                 // Trigger data 3
    logic [23:0] s_test_cnt;                      // Test counter
    logic [7:0] s_state_led_ctr;                  // State LED counter
    logic s_reg_map_sel;                         // Register map select

    //==========================================================================
    // TI ROIC Register Interface
    //==========================================================================
    logic s_reg_tp_sel;                          // Register TP select
    logic s_reg_roic_sync;                       // Register ROIC sync
    logic ti_roic_sync;                          // TI ROIC sync
    logic ti_roic_tp_sel;                        // TI ROIC TP select
    logic [1:0] ti_roic_str;                     // TI ROIC strobe
    logic [15:0] ti_roic_reg_addr;               // TI ROIC register address
    logic [15:0] ti_roic_reg_data;               // TI ROIC register data
    logic gen_sync_start;                        // Generate sync start
    logic [1:0] s_gen_sync_start_dly;             // Generate sync start delay
    logic s_gen_sync_start_rise;                 // Generate sync start rise

    //==========================================================================
    // TI ROIC Deserializer Signals
    //==========================================================================
    logic ti_roic_deser_reset;                   // TI ROIC deserializer reset
    logic ti_roic_deser_dly_tap_ld;              // Delay tap load
    logic [4:0] ti_roic_deser_dly_tap_in;        // Delay tap input
    logic ti_roic_deser_dly_data_ce;             // Delay data clock enable
    logic ti_roic_deser_dly_data_inc;            // Delay data increment
    logic ti_roic_deser_align_mode;             // Align mode
    logic ti_roic_deser_align_start;            // Align start
    logic [4:0] ti_roic_deser_shift_set[`NUM_ROIC-1:0];      // Shift set [13:0]
    logic [4:0] ti_roic_deser_align_shift[`NUM_ROIC-1:0];     // Align shift [13:0]
    logic [`NUM_ROIC-1:0] ti_roic_deser_align_done;             // Align done [13:0]

    //==========================================================================
    // Clock and Reset Assignment
    //==========================================================================
    logic eim_clk;                               // EIM clock (100MHz)

    //==========================================================================
    // Helper Functions - Extracted complex logic for better readability
    //==========================================================================

    /**
     * @brief Determines if valid readout should occur
     * @return 1 if readout conditions are met, 0 otherwise
     *
     * Readout is valid when:
     * - CSI mask is disabled (not masked)
     * - FSM is in read index state
     * - Valid repeat count exceeds current sync repeat count
     */
    function automatic logic get_valid_readout(
        input logic sync_csi_mask_o,
        input logic sync_fsm_read_index,
        input logic [31:0] valid_repeat_count,
        input logic [31:0] sync_repeat_cnt
    );
        return (~sync_csi_mask_o) && sync_fsm_read_index && (valid_repeat_count > sync_repeat_cnt);
    endfunction


    //==========================================================================
    // Module Instantiation: Clock Control (Clock Wizard)
    //==========================================================================
    clk_ctrl clk_inst0 (
        .reset          (1'b0),
        .clk_in1_p      (MCLK_50M_p),
        .clk_in1_n      (MCLK_50M_n),
        .locked         (s_clk_lock),
        .dphy_clk       (s_dphy_clk_200M),       // 200MHz output
        .c0             (s_clk_100mhz),           // 100MHz output
        .c1             (s_clk_20mhz)             // 20MHz output
    );

    assign eim_clk = s_clk_100mhz;               // Use 100MHz for EIM interface

    //==========================================================================
    // Module Instantiation: MIPI CSI-2 TX
    //==========================================================================
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
        .s_axis_tstrb           (3'b000),             // All bits active
        .s_axis_tkeep           (3'b111),             // All bits kept
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

    //==========================================================================
    // Module Instantiation: Initialization
    //==========================================================================
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

    //==========================================================================
    // Module Instantiation: SPI Slave (Host Interface)
    //==========================================================================
    spi_slave #(
        .header     (SPI_HEADER),
        .payload    (SPI_PAYLOAD),
        .addrsz     (SPI_ADDRSZ),
        .pktsz      (SPI_PKTSZ)
    )
    host_if_inst (
        .clk               (s_clk_100mhz),
        .reset             (s_reset),
        .SCLK              (SCLK),
        .SSB               (SSB),
        .MOSI              (MOSI),
        .MISO              (s_miso),
        .spi_start_flag    (s_spi_start_flag),
        .read_data         (reg_read_out[SPI_PAYLOAD-1:0]),
        .read_en           (s_read_data_en),
        .reg_addr          (s_reg_addr[SPI_ADDRSZ-1:0]),
        .addr_valid        (s_addr_dv),
        .wr_data           (s_reg_data[SPI_PAYLOAD-1:0]),
        .wr_data_valid     (s_reg_data_index),
        .rw_out            (s_rw_out)
    );

    // Register address mapping
    assign s_reg_address = ({2'b00, s_reg_addr[SPI_ADDRSZ-1:0]});
    assign reg_read_out = s_reg_read_out_new;

    //==========================================================================
    // Module Instantiation: Register Map
    //==========================================================================
    reg_map reg_map_inst (
        // Clock and reset
        .eim_clk                    (s_clk_100mhz),
        .eim_rst                    (eim_rst),
        .fsm_clk                    (s_clk_20mhz),
        .rst                        (rst),

        // Trigger inputs
        .exp_req                    (EXP_REQ),

        // FSM index inputs
        .fsm_rst_index              (FSM_rst_index),
        .fsm_init_index             (FSM_wait_index),
        .fsm_back_bias_index        (FSM_back_bias_index),
        .fsm_flush_index            (FSM_flush_index),
        .fsm_aed_read_index         (FSM_aed_read_index),
        .fsm_exp_index              (FSM_exp_index),
        .fsm_read_index             (FSM_read_index),
        .fsm_idle_index             (FSM_idle_index),

        // Status inputs
        .ready_to_get_image         (ready_to_get_image),
        .aed_ready_done             (aed_ready_done),
        .panel_stable_exist         (panel_stable_o),
        .exp_read_exist             (s_exp_read_exist),

        // Register interface
        .reg_read_index             (s_reg_read_index),
        .reg_addr                   (s_reg_address),
        .reg_data                   (s_reg_data),
        .reg_data_index             (s_reg_data_index),
        .reg_read_out               (s_reg_read_out_new),
        .read_data_en               (s_read_data_en),

        // Power control
        .en_pwr_dwn                 (en_pwr_dwn),
        .en_pwr_off                 (en_pwr_off),
        .system_rst                 (system_rst),
        .reset_fsm                  (reset_FSM),
        .org_reset_fsm              (org_reset_FSM),

        // Image acquisition
        .dummy_get_image            (dummy_get_image),
        .burst_get_image            (burst_get_image),
        .get_dark                   (get_dark),
        .get_bright                 (get_bright),
        .cmd_get_bright             (cmd_get_bright),
        .en_panel_stable            (en_panel_stable),

        // Display parameters
        .dsp_image_height           (dsp_image_height),
        .max_v_count                (max_v_count),
        .max_h_count                (max_h_count),
        .csi2_word_count            (csi2_word_count),

        // Gate control outputs (unused)
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

        // Back bias control
        .up_back_bias               (up_back_bias),
        .dn_back_bias               (down_back_bias),

        // Sequence table interface
        .seq_lut_addr               (seq_lut_addr),
        .seq_lut_data               (seq_lut_data),
        .seq_lut_wr_en              (seq_lut_wr_en),
        .seq_lut_read_data          (seq_lut_read_data),
        .seq_lut_control            (seq_lut_control),
        .seq_lut_config_done        (seq_lut_config_done),
        .acq_mode                   (acq_mode),
        .acq_expose_size            (acq_expose_size),
        .seq_state_read             (seq_state_read),

        // TI-ROIC register interface
        .ti_roic_sync               (s_reg_roic_sync),
        .ti_roic_tp_sel             (s_reg_tp_sel),
        .ti_roic_str                (ti_roic_str),
        .ti_roic_reg_addr           (ti_roic_reg_addr),
        .ti_roic_reg_data           (ti_roic_reg_data),

        // TI-ROIC deserializer interface
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

        // Test pattern control
        .en_16bit_adc               (en_16bit_adc),
        .en_test_pattern_col        (en_test_pattern_col),
        .en_test_pattern_row        (en_test_pattern_row),
        .en_test_roic_col           (en_test_roic_col),
        .en_test_roic_row           (en_test_roic_row),

        // Acknowledge output
        .exp_ack                    (EXP_ACK),

        // AED gate control
        .dn_aed_gate_xao            (dn_aed_gate_xao),
        .up_aed_gate_xao            (up_aed_gate_xao),

        // LED control
        .state_led_ctr              (s_state_led_ctr)
    );

    //==========================================================================
    // Module Instantiation: ROIC Gate Drive
    //==========================================================================
    roic_gate_drv roic_gate_drv_inst (
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

    //==========================================================================
    // FSM Index Assignments
    //==========================================================================
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

    // ROIC even/odd output signals (14 channels)
    logic [`NUM_ROIC-1:0] s_roic_even_odd_out;

    //==========================================================================
    // Module Instantiation: Sequencer FSM
    //==========================================================================
    sequencer_fsm seq_fsm_inst (
        .clk                        (s_clk_20mhz),
        .reset_i                    (s_seq_reset),
        .config_done_i              (s_sync_config_done),
        .lut_addr_i                 (seq_lut_addr),
        .lut_wen_i                  (seq_lut_wr_en),
        .lut_write_data_i           (seq_lut_data),
        .lut_read_data_o            (seq_lut_read_data),
        .acq_mode_i                 (acq_mode),
        .expose_size_i              (acq_expose_size),
        .exit_signal_i              (exit_signal_i),
        .roic_even_odd_i            (s_roic_even_odd_out[0]),
        .readout_wait               (s_readout_wait),
        .state_exit_flag_o          (s_state_exit_flag),
        .current_state_o            (current_state_o),
        .busy_o                     (busy_o),
        .sequence_done_o            (sequence_done_o),
        .reset_state_o              (reset_state_o),
        .wait_o                     (wait_o),
        .bias_enable_o              (bias_enable_o),
        .flush_enable_o             (flush_enable_o),
        .expose_enable_o            (expose_enable_o),
        .readout_enable_o           (readout_enable_o),
        .aed_enable_o               (aed_enable_o),
        .stv_mask_o                 (stv_mask_o),
        .csi_mask_o                 (csi_mask_o),
        .panel_stable_o             (panel_stable_o),
        .iterate_exist_o            (iterate_exist_o),
        .idle_elable_o              (idle_elable_o),
        .current_sof_o              (current_sof_o),
        .current_eof_o              (current_eof_o),
        .acq_mode_o                 (acq_mode_o),
        .expose_size_o              (expose_size_o),
        .current_repeat_count_o     (current_repeat_count_o),
        .active_repeat_count_o     (active_repeat_count_o),
        .current_data_length_o      (current_data_length_o)
    );

    //==========================================================================
    // Sync and Wait Control Logic
    //==========================================================================
    assign s_wait_tp_sel = (wait_o && current_eof_o) ? 1'b1 : 1'b0;
    assign s_wait_sync   = (wait_o && current_sof_o) ? 1'b1 : 1'b0;
    assign s_wait_roic_sync = (s_wait_sync_dly == SYNC_DELAY_THRESHOLD) ? 1'b1 : 1'b0;

    assign s_seq_reset = (~rst) ? 1'b1 : 1'b0;
    assign valid_repeat_count_o = s_sync_current_repeat_count_o - 32'd2;

    // Use helper function for better readability
    assign s_valid_readout = get_valid_readout(
        s_sync_csi_mask_o,
        s_sync_fsm_read_index,
        valid_repeat_count_o,
        s_sync_repeat_cnt
    );

    assign s_read_data_start = (tg_col_cnt == COLUMN_MAX_COUNT && s_valid_readout) ? 1'b1 : 1'b0;

    assign seq_state_read = {wait_o, bias_enable_o, flush_enable_o, expose_enable_o,
                             readout_enable_o, aed_enable_o, current_sof_o, current_eof_o,
                             stv_mask_o, csi_mask_o, sequence_done_o, busy_o,
                             current_state_o};

    //==========================================================================
    // Delay Registers (Edge Detection)
    //==========================================================================
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
            s_wait_sync_dly <= {s_wait_sync_dly[1:0], s_wait_sync};
        end
    end

    //==========================================================================
    // Mode Detection and Trigger Logic
    //==========================================================================
    assign s_get_bright = (s_aed_mode_exist == 1'b0 && (cmd_get_bright || get_bright)) ? 1'b1 : 1'b0;
    assign s_aed_mode_exist = (acq_mode_o == 3'd4 || acq_mode_o == 3'd5) ? 1'b1 : 1'b0;
    assign aed_ready_done = aed_enable_o;
    assign s_aed_trig_i = (s_aed_mode_exist) ? s_aed_trig : 1'b0;

    // Edge detection signals
    assign s_get_dark_hi = (s_get_dark_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_get_bright_hi = (s_get_bright_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_get_aed_trig_hi = (s_get_aed_trig_dly == 2'b01) ? 1'b1 : 1'b0;
    assign s_sequence_done_hi = (s_sequence_done_dly == 2'b01) ? 1'b1 : 1'b0;

    assign exit_signal_i = (s_exit_signal_dark || s_exit_signal_bright || s_exit_signal_aed) ? 1'b1 : 1'b0;
    assign ready_to_get_image = exit_signal_i;

    //==========================================================================
    // Exit Signal State Machine
    //==========================================================================
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

    //==========================================================================
    // Read RX Data Processing
    //==========================================================================
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

    //==========================================================================
    // Output Assignments
    //==========================================================================
    assign MISO = s_miso;
    assign s_axis_video_tuser[0] = s_read_frame_start;

    assign s_reg_addr_index = (s_rw_out == 1'b0 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;
    assign s_reg_read_index = (s_rw_out == 1'b1 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;
    assign s_mask_stv = (s_sync_stv_mask_o == 1'b1) ? s_tg_stv : 1'b0;

    //==========================================================================
    // Gate Drive Signal Assignments
    //==========================================================================
    assign GF_CPV = s_tg_cpv;
    assign GF_STV_R = (sig_gate_lr1 == 1'b0) ? s_mask_stv : 1'bz;
    assign GF_STV_L = (sig_gate_lr1 == 1'b1) ? s_mask_stv : 1'bz;
    assign GF_OE = s_tg_oe;

    //==========================================================================
    // GF_STV_LR1~8 Assignments (Reserved for future use)
    //==========================================================================
    // NOTE: These signals are set to high-impedance (1'bz) for the following reasons:
    // 1. Cyan board has separate GF_STV_LR1~8 pins that are not currently used
    // 2. GF_STV_L and GF_STV_R already provide left/right gate drive control
    // 3. These signals may be reserved for future expansion
    assign GF_STV_LR1 = 1'bz;
    assign GF_STV_LR2 = 1'bz;
    assign GF_STV_LR3 = 1'bz;
    assign GF_STV_LR4 = 1'bz;
    assign GF_STV_LR5 = 1'bz;
    assign GF_STV_LR6 = 1'bz;
    assign GF_STV_LR7 = 1'bz;
    assign GF_STV_LR8 = 1'bz;

    //==========================================================================
    // GF_XAO Phase Control Assignments
    //==========================================================================
    // XAO signals control the gate drive timing sequence (6 phases)
    // Phase mapping: GF_XAO_1 (phase 0) through GF_XAO_6 (phase 5)
    // GF_XAO_7 and GF_XAO_8 are currently inactive
    assign s_sync_repeat_cnt_mod = s_sync_repeat_cnt % XAO_PHASE_COUNT;
    assign s_sync_xao_enable = (s_sync_fsm_flush_index || s_sync_fsm_back_bias_index) ? 1'b1 : 1'b0;

    assign GF_XAO_6 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd5) ? gate_xao_0 : 1'b1;
    assign GF_XAO_5 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd4) ? gate_xao_1 : 1'b1;
    assign GF_XAO_4 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd3) ? gate_xao_2 : 1'b1;
    assign GF_XAO_3 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd2) ? gate_xao_3 : 1'b1;
    assign GF_XAO_2 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd1) ? gate_xao_4 : 1'b1;
    assign GF_XAO_1 = (s_sync_xao_enable && s_sync_repeat_cnt_mod == 32'd0) ? gate_xao   : 1'b1;
    assign GF_XAO_7 = 1'b1;
    assign GF_XAO_8 = 1'b1;

    //==========================================================================
    // LVDS Channel Mapping (Physical pins to internal arrays)
    //==========================================================================
    // LVDS input ports are now arrays, direct mapping to internal signals
    logic [`NUM_ROIC-1:0] R_ROIC_DCLKo_p = DCLKP;
    logic [`NUM_ROIC-1:0] R_ROIC_DCLKo_n = DCLKN;
    logic [`NUM_ROIC-1:0] R_ROIC_FCLKo_p = FCLKP;
    logic [`NUM_ROIC-1:0] R_ROIC_FCLKo_n = FCLKN;
    logic [`NUM_ROIC-1:0] R_DOUTA_H = DOUTP;
    logic [`NUM_ROIC-1:0] R_DOUTA_L = DOUTN;

    //==========================================================================
    // Reset Generation
    //==========================================================================
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

    //==========================================================================
    // ROIC Output Assignments
    //==========================================================================
    assign ROIC_TP_SEL = ti_roic_tp_sel;
    assign ROIC_MCLK0  = s_clk_20mhz;
    assign ROIC_MCLK1  = s_clk_20mhz;
    assign ROIC_SYNC   = ti_roic_sync;
    assign ROIC_AVDD1 = s_pwr_init_step1;
    assign ROIC_AVDD2 = s_pwr_init_step2;

    //==========================================================================
    // TI ROIC Interface Signals
    //==========================================================================

    // Data path signals
    logic [`NUM_ROIC-1:0] data_read_req;
    logic [`NUM_ROIC-1:0] valid_read_enable;
    logic [23:0] reordered_data_a [`NUM_ROIC-1:0];
    logic [23:0] reordered_data_b [`NUM_ROIC-1:0];
    logic [`NUM_ROIC-1:0] reordered_valid;
    logic [`NUM_ROIC-1:0] channel_detected;
    logic [23:0] detected_data_out [`NUM_ROIC-1:0];
    logic valid_read_mem;
    logic [23:0] roic_read_data;

    // Debug signals
    logic [`NUM_ROIC-1:0] s_even_odd_toggle_out;
    logic dbg_even_odd_toggle_out;
    logic dbg_channel_detected;
    logic dbg_roic_even_odd;
    logic dbg_roic_1st_channel;

    // SPI and control signals
    logic s_spidut_en_1d;
    logic s_spidut_en_2d;
    logic s_spiReady;
    logic s_rf_spi_sen;
    logic [191:0] sdoutWord;

    // Bit alignment signals
    logic [4:0] extra_shift [`NUM_ROIC-1:0];
    logic [4:0] shift_out [`NUM_ROIC-1:0];
    logic [`NUM_ROIC-1:0] align_done;
    logic align_to_fclk;
    logic align_start;

    // Timing generator signals
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

    //==========================================================================
    // Module Instantiation: TI ROIC SPI (Register Access)
    //==========================================================================
    roic_spi ti_roic_spi_inst (
        .reset      (deser_reset),
        .clk        (s_clk_5mhz),
        .address    (ti_roic_reg_addr[7:0]),
        .data       (ti_roic_reg_data),
        .DUT_EN     (ti_roic_reg_addr[15]),
        .spiReady   (s_spiReady),
        .DUT_SDOUT  (s_roic_sdio),
        .DUT_SCLK   (ROIC_SPI_SCK),
        .DUT_SDATA  (ROIC_SPI_SDI),
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

    //==========================================================================
    // Module Instantiation: TI ROIC Timing Generator
    //==========================================================================
    ti_roic_tg roic_tg_gen_int (
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

    //==========================================================================
    // TI ROIC Deserializer Alignment State Generation
    //==========================================================================
    generate
        always_ff @(posedge eim_clk or posedge s_reset) begin
            if (s_reset) begin
                for (int i = 0; i < `NUM_ROIC; i++) begin
                    extra_shift[i] <= 4'd0;
                    ti_roic_deser_align_shift[i] <= 4'd0;
                    ti_roic_deser_align_done[i] <= 1'b0;
                end
            end else begin
                for (int i = 0; i < `NUM_ROIC; i++) begin
                    extra_shift[i] <= ti_roic_deser_shift_set[i];
                    ti_roic_deser_align_shift[i] <= shift_out[i];
                    ti_roic_deser_align_done[i] <= align_done[i];
                end
            end
        end
    endgenerate

    //==========================================================================
    // TI ROIC LVDS Channel Instantiation (14 channels)
    //==========================================================================
    genvar i;
    generate
        for (i = 0; i < `NUM_ROIC; i++) begin : gen_ti_roic_top
            ti_roic_top #(
                .DATA_WIDTH    (TI_ROIC_WORD_SIZE),     // 24-bit data width
                .IOSTANDARD    ("LVDS_25"),             // LVDS electrical standard
                .REFCLK_FREQ   (TI_ROIC_REFCLK_FREQ),   // 200MHz reference
                .PATTERN_1     (TI_ROIC_PATTERN_1),      // First pattern
                .PATTERN_2     (TI_ROIC_PATTERN_2)       // Second pattern
            ) ti_roic_top_inst (
                // Control and reset
                .clk_reset          (s_reset),
                .data_reset         (deser_reset),

                // LVDS inputs
                .fclk_in_p          (R_ROIC_FCLKo_p[i]),
                .fclk_in_n          (R_ROIC_FCLKo_n[i]),
                .clk_in_p           (R_ROIC_DCLKo_p[i]),
                .clk_in_n           (R_ROIC_DCLKo_n[i]),
                .data_in_p          (R_DOUTA_H[i]),
                .data_in_n          (R_DOUTA_L[i]),

                // Bit alignment
                .align_to_fclk      (align_to_fclk),
                .align_start        (align_start),
                .extra_shift        (extra_shift[i]),

                // Test pattern
                .en_test_pattern_col(en_test_pattern_col),
                .en_test_pattern_row(en_test_pattern_row),

                // Data reordering
                .sync               (s_roic_sync_out),
                .data_read_req      (data_read_req[i]),
                .data_read_clk      (s_dphy_clk_200M),

                // Debug outputs
                .even_odd_toggle_out(s_even_odd_toggle_out[i]),
                .roic_even_odd_out  (s_roic_even_odd_out[i]),

                // Outputs
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

    //==========================================================================
    // Module Instantiation: Read Data MUX
    //==========================================================================
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

    //==========================================================================
    // Trigger Acknowledge
    //==========================================================================
    assign PREP_ACK = PREP_REQ;
    assign s_config_done_i = (seq_lut_config_done || s_reg_roic_sync) ? 1'b1 : 1'b0;

    //==========================================================================
    // Test Counter
    //==========================================================================
    always_ff @(posedge s_clk_20mhz or negedge rst) begin
        if (~rst) begin
            s_test_cnt <= '0;
        end else begin
            s_test_cnt <= s_test_cnt + 1'b1;
        end
    end

    //==========================================================================
    // Module Instantiation: DC-DC Clock Generator
    //==========================================================================
    dcdc_clk dcdc_clk_inst (
        .clk        (s_clk_20mhz),
        .reset_n    (sys_rst),
        .clk_1M_o   (s_clk_1mhz),
        .clk_5M_o   (s_clk_5mhz)
    );

    //==========================================================================
    // ROIC SPI Control
    //==========================================================================
    assign s_roic_sdio = ROIC_SPI_SDO;
    assign ROIC_SPI_SEN_N = {`NUM_ROIC{s_rf_spi_sen}};

    //==========================================================================
    // ROIC Sync Control
    //==========================================================================
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

    //==========================================================================
    // Sync Control Logic
    //==========================================================================
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

    //==========================================================================
    // LED Indicator Control
    //==========================================================================
    // Maps the state LED counter value to various internal signals for debugging
    // Each value of s_state_led_ctr selects a different signal to display
    always_comb begin
        case (s_state_led_ctr)
            // Test counter (0x00)
            8'h00: STATE_LED1 = s_test_cnt[23];

            // FSM states (0x01-0x08)
            8'h01: STATE_LED1 = FSM_idle_index;
            8'h02: STATE_LED1 = FSM_read_index;
            8'h03: STATE_LED1 = FSM_exp_index;
            8'h04: STATE_LED1 = FSM_aed_read_index;
            8'h05: STATE_LED1 = s_sync_fsm_flush_index;
            8'h06: STATE_LED1 = s_sync_fsm_back_bias_index;
            8'h07: STATE_LED1 = FSM_wait_index;
            8'h08: STATE_LED1 = FSM_rst_index;

            // Data valid (0x09-0x0B)
            8'h09: STATE_LED1 = valid_roic_data;
            8'h0A: STATE_LED1 = valid_read_mem;
            8'h0B: STATE_LED1 = s_sync_fsm_read_index;

            // Channel detection (0x20-0x2B)
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

            // MIPI read signals (0x30-0x34)
            8'h30: STATE_LED1 = s_read_frame_start;
            8'h31: STATE_LED1 = s_read_frame_reset;
            8'h32: STATE_LED1 = s_read_axis_tvalid;
            8'h33: STATE_LED1 = s_read_axis_tlast;
            8'h34: STATE_LED1 = s_read_axis_tready;

            // Timing generator signals (0x40-0x4C)
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

            // ROIC signals (0x4D-0x4F)
            8'h4D: STATE_LED1 = s_roic_sdio;
            8'h4E: STATE_LED1 = s_sum_channel_detected;
            8'h4F: STATE_LED1 = gen_sync_start;

            // Trigger and mode (0x50-0x5B)
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

            // Gate drive (0x60-0x62)
            8'h60: STATE_LED1 = s_tg_stv;
            8'h61: STATE_LED1 = s_mask_stv;
            8'h62: STATE_LED1 = s_back_bias;

            // Sync control (0x63-0x6F)
            8'h63: STATE_LED1 = s_roic_sync_in;
            8'h64: STATE_LED1 = ti_roic_sync;
            8'h65: STATE_LED1 = s_readout_wait;
            8'h66: STATE_LED1 = s_valid_readout;
            8'h67: STATE_LED1 = stv_mask_o;
            8'h68: STATE_LED1 = csi_mask_o;

            // Clock monitoring (0x69-0x6A)
            8'h69: STATE_LED1 = s_clk_5mhz;
            8'h6A: STATE_LED1 = s_clk_1mhz;

            // Mode detection (0x6B-0x6F)
            8'h6B: STATE_LED1 = s_aed_mode_exist;
            8'h6C: STATE_LED1 = s_aed_trig_i;
            8'h6D: STATE_LED1 = s_get_bright;
            8'h6E: STATE_LED1 = aed_ready_done;
            8'h6F: STATE_LED1 = s_state_exit_flag;

            default: STATE_LED1 = 1'b0;
        endcase
    end

    //==========================================================================
    // Debug Output Assignment
    //==========================================================================
    assign dbg_channel_detected = channel_detected[0];
    assign dbg_roic_1st_channel = detected_data_out[0][7];
    assign dbg_roic_even_odd = detected_data_out[0][6];
    assign dbg_even_odd_toggle_out = s_IRST;

    assign DEBUG_SiG = {dbg_even_odd_toggle_out, dbg_roic_even_odd, dbg_channel_detected, dbg_roic_1st_channel};


//==============================================================================
// End of Module
//==============================================================================
endmodule
