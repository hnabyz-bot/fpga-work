//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Wed Sep 20 13:17:43 2023
//Host        : DESKTOP-957T0T8 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target mipi_csi2_tx_wrapper.bd
//Design      : mipi_csi2_tx_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mipi_csi2_tx_top
  (
    reset,
//    axi_clk_200M,
    dphy_clk_200M,
    clk_100M,
    eim_clk,
    locked_i,

//    read_frame_start,
    read_frame_reset,
//
    s_axis_tdata_a,
    s_axis_tdata_b,
//    s_axis_tdata_c,
//    s_axis_tdata_d,
    s_axis_tlast,
    s_axis_tready,
    s_axis_tvalid,
    s_axis_tstrb,
    s_axis_tkeep,
//
    mipi_phy_if_clk_hs_n,
    mipi_phy_if_clk_hs_p,
    mipi_phy_if_clk_lp_n,
    mipi_phy_if_clk_lp_p,
    mipi_phy_if_data_hs_n,
    mipi_phy_if_data_hs_p,
    mipi_phy_if_data_lp_n,
    mipi_phy_if_data_lp_p,
//
    csi2_word_count,
    m_axis_video_tuser,
    done,
    interrupt,
    status,
    system_rst_out
    );

  parameter mipi_lane = 4;

  input           reset;
//  input             axi_clk_200M;
  input             dphy_clk_200M;
  input             clk_100M;
  input             eim_clk;
  input             locked_i;
  
//  input logic       read_frame_start;
  input logic       read_frame_reset;

//
  input [23:0]    s_axis_tdata_a;
  input [23:0]    s_axis_tdata_b;
//  input [23:0]    s_axis_tdata_c;
//  input [23:0]    s_axis_tdata_d;
  input           s_axis_tlast;
  output          s_axis_tready;
  input           s_axis_tvalid;
  input [2:0]     s_axis_tstrb;
  input [2:0]     s_axis_tkeep;

//
  output          mipi_phy_if_clk_hs_n;
  output          mipi_phy_if_clk_hs_p;
  output          mipi_phy_if_clk_lp_n;
  output          mipi_phy_if_clk_lp_p;
  output [mipi_lane-1:0]    mipi_phy_if_data_hs_n;
  output [mipi_lane-1:0]    mipi_phy_if_data_hs_p;
  output [mipi_lane-1:0]    mipi_phy_if_data_lp_n;
  output [mipi_lane-1:0]    mipi_phy_if_data_lp_p;
//
  input  logic [15:0]    csi2_word_count;
  input  [0:0]    m_axis_video_tuser;
  output          done;
  output          interrupt;
  output [31:0]   status;
  output          system_rst_out;

  wire            done;
  wire            interrupt;

  wire            cl_tst_clk_out;
  wire            dl_tst_clk_out;

  wire            mipi_phy_if_clk_hs_n;
  wire            mipi_phy_if_clk_hs_p;
  wire            mipi_phy_if_clk_lp_n;
  wire            mipi_phy_if_clk_lp_p;
  wire [mipi_lane-1:0]      mipi_phy_if_data_hs_n;
  wire [mipi_lane-1:0]      mipi_phy_if_data_hs_p;
  wire [mipi_lane-1:0]      mipi_phy_if_data_lp_n;
  wire [mipi_lane-1:0]      mipi_phy_if_data_lp_p;
  wire            reset;
  wire [31:0]     status;
  wire            system_rst_out;

  wire [0:0]      m_axis_video_tuser;

// ==========================================================================
// clock module
// ==========================================================================

  wire            locked_i;
  wire            inter_aresetn;
  wire            peri_aresetn;
//  wire            axi_clk_200M;
  wire            dphy_clk_200M;
  wire            clk_100M;
  wire            eim_clk;

  rst_clk_200M inst_rst_clk_200M
  (
    .slowest_sync_clk     ( clk_100M ),
    .ext_reset_in         ( reset ),
    .aux_reset_in         ( 1'b1 ),
    .mb_debug_sys_rst     ( 1'b0 ),
    .dcm_locked           ( locked_i ),
    .mb_reset             (  ),
    .bus_struct_reset     (  ),
    .peripheral_reset     (  ),
    .interconnect_aresetn ( inter_aresetn ),
    .peripheral_aresetn   ( peri_aresetn )
  );

// ==========================================================================

// ==========================================================================
//  out fifo module
// ==========================================================================
  // parameter   int   fifo_num = 4;
  parameter   int   fifo_num = 2;

  wire                          s_axis_tready;

  wire [fifo_num-1:0][23:0]     s_in_axis_tdata;
  wire [fifo_num-1:0]           s_in_axis_tready;
  wire                          s_axis_tlast;
  wire                          s_axis_tvalid;
  wire [2:0]                    s_axis_tstrb;
  wire [2:0]                    s_axis_tkeep;
  wire [fifo_num-1:0]           s_almost_empty;
  wire [fifo_num-1:0]           s_almost_full;

  wire                          m_axis_tready;  // input
  wire [fifo_num-1:0]           m_axis_tlast;  // output
  wire [fifo_num-1:0]           m_axis_tvalid;  // output

  wire [fifo_num-1:0][24-1:0]   m_axis_tdata;   // output
  wire [fifo_num-1:0][2:0]      m_axis_tstrb;
  wire [fifo_num-1:0][2:0]      m_axis_tkeep;

  logic [24*fifo_num-1:0]       s_mipi_tdata;

  wire                          s_ofifo_rst;  // input

  assign    s_ofifo_rst = (peri_aresetn==1'b1 && read_frame_reset==1'b0) ? 1'b1 : 1'b0;

  genvar i;
  generate 
    for (i=0 ; i < fifo_num ; i++) begin : gen_axis_fifo

      axis_data_fifo_0 inst_out_fifo
      (
        .s_axis_aresetn   ( s_ofifo_rst ),
        .s_axis_aclk      ( eim_clk ),
        .m_axis_aclk      ( clk_100M ),
        .almost_empty     ( s_almost_empty[i] ),
        .almost_full      ( s_almost_full[i] ),
        .s_axis_tready    ( s_in_axis_tready[i] ),
        .s_axis_tvalid    ( s_axis_tvalid ),
        .s_axis_tlast     ( s_axis_tlast ),
        .s_axis_tstrb     ( s_axis_tstrb ),
        .s_axis_tkeep     ( s_axis_tkeep ),
        .s_axis_tdata     ( s_in_axis_tdata[i][0+:24] ),
        .m_axis_tready    ( m_axis_tready ),
        .m_axis_tvalid    ( m_axis_tvalid[i] ),
        .m_axis_tlast     ( m_axis_tlast[i] ),
        .m_axis_tstrb     ( m_axis_tstrb[i] ),
        .m_axis_tkeep     ( m_axis_tkeep[i] ),
        .m_axis_tdata     ( m_axis_tdata[i][0+:24] )
      );

    end

  endgenerate

  assign    s_in_axis_tdata[0]  = s_axis_tdata_a;
  assign    s_in_axis_tdata[1]  = s_axis_tdata_b;
  // assign    s_in_axis_tdata[2]  = s_axis_tdata_c;
  // assign    s_in_axis_tdata[3]  = s_axis_tdata_d;
  assign    s_axis_tready = s_in_axis_tready[0];

// ==========================================================================
//  mipi csi2 interface module
// ==========================================================================
  // assign    s_mipi_tdata = ({m_axis_tdata[3],m_axis_tdata[2],m_axis_tdata[1],m_axis_tdata[0]});
  assign    s_mipi_tdata = ({m_axis_tdata[1],m_axis_tdata[0]});

  mipi_csi2_tx_bd inst_mipi_csi2_tx
    (
      .reset                  (reset),
      .s_axis_aclk            (clk_100M),
      .dphy_clk_200M          (dphy_clk_200M),
      .s_axi_aresetn          (peri_aresetn),
      //
      .s_axis_tdata           (s_mipi_tdata),
      .s_axis_tlast           (m_axis_tlast[0]),
      .s_axis_tready          (m_axis_tready),
      .s_axis_tvalid          (m_axis_tvalid[0]),
      .s_axis_tkeep           (m_axis_tkeep[0]),

      .mipi_phy_if_clk_hs_n   (mipi_phy_if_clk_hs_n),
      .mipi_phy_if_clk_hs_p   (mipi_phy_if_clk_hs_p),
      .mipi_phy_if_clk_lp_n   (mipi_phy_if_clk_lp_n),
      .mipi_phy_if_clk_lp_p   (mipi_phy_if_clk_lp_p),
      .mipi_phy_if_data_hs_n  (mipi_phy_if_data_hs_n),
      .mipi_phy_if_data_hs_p  (mipi_phy_if_data_hs_p),
      .mipi_phy_if_data_lp_n  (mipi_phy_if_data_lp_n),
      .mipi_phy_if_data_lp_p  (mipi_phy_if_data_lp_p),
      .csi2_word_count        (csi2_word_count),
      .mipi_frame_start       (m_axis_video_tuser),
      .cl_tst_clk_out         (cl_tst_clk_out),
      .dl_tst_clk_out         (dl_tst_clk_out),
      .done                   (done),
      .interrupt              (interrupt),
      .status                 (status),
      .system_rst_out         (system_rst_out)
    );


	// ila_csi2 ILA_CSI2(
	// 	.clk	  (clk_100M),
	// 	.probe0	({8'h00,m_axis_tdata[0]}),
	// 	.probe1	(m_axis_video_tuser[0]),
	// 	.probe2	(s_ofifo_rst),
	// 	.probe3	(m_axis_tvalid),
	// 	.probe4	(m_axis_tready),
	// 	.probe5	(m_axis_tlast)
	// );


endmodule
