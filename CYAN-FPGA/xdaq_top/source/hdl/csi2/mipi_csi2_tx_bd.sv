//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Wed Sep 20 13:17:43 2023
//Host        : DESKTOP-957T0T8 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target mipi_csi2_tx.bd
//Design      : mipi_csi2_tx
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "mipi_csi2_tx,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mipi_csi2_tx,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=13,numReposBlks=13,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=2,da_board_cnt=10,da_clkrst_cnt=27,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "mipi_csi2_tx.hwdef" *) 
module mipi_csi2_tx_bd
    (
          s_axis_aclk,
          dphy_clk_200M,

          s_axi_aresetn,
          s_axis_tdata,
          s_axis_tlast,
          s_axis_tready,
          s_axis_tvalid,
          s_axis_tkeep,

          csi2_word_count,
          mipi_frame_start,
          done,
          interrupt,
          cl_tst_clk_out,
          dl_tst_clk_out,

          mipi_phy_if_clk_hs_n,
          mipi_phy_if_clk_hs_p,
          mipi_phy_if_clk_lp_n,
          mipi_phy_if_clk_lp_p,
          mipi_phy_if_data_hs_n,
          mipi_phy_if_data_hs_p,
          mipi_phy_if_data_lp_n,
          mipi_phy_if_data_lp_p,
          reset,
          status,
          system_rst_out
    );

    input s_axis_aclk, dphy_clk_200M;
    input          s_axi_aresetn;
    input [0:0]    mipi_frame_start;
    input logic [15:0]    csi2_word_count;

    output         done;

    output [31:0]  status;
    output         system_rst_out;
    
    output wire cl_tst_clk_out;
    output wire dl_tst_clk_out;

  parameter mipi_lane = 4;
  // parameter pixel_mode = 4;
  parameter pixel_mode = 2;
//  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tdata" *) (* x_interface_parameter = "xil_interfacename s_axis, freq_hz 100000000, has_tkeep 0, has_tlast 0, has_tready 1, has_tstrb 0, insert_vip 0, layered_metadata undef, phase 0.0, tdata_num_bytes 1, tdest_width 0, tid_width 0, tuser_width 0" *) input [23:0]s_axis_tdata;
  // (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tdata" *) (* x_interface_parameter = "xil_interfacename s_axis, freq_hz 200000000, has_tkeep 0, has_tlast 0, has_tready 1, has_tstrb 0, insert_vip 0, layered_metadata undef, phase 0.0, tdata_num_bytes 1, tdest_width 0, tid_width 0, tuser_width 0" *) input [23:0]s_axis_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tdata" *) (* x_interface_parameter = "xil_interfacename s_axis, freq_hz 200000000, has_tkeep 0, has_tlast 0, has_tready 1, has_tstrb 0, insert_vip 0, layered_metadata undef, phase 0.0, tdata_num_bytes 1, tdest_width 0, tid_width 0, tuser_width 0" *) input [(24*pixel_mode)-1:0]s_axis_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tlast" *) input s_axis_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tready" *) output s_axis_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tvalid" *) input s_axis_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis tkeep" *) input [2:0] s_axis_tkeep;
//   (* x_interface_info = "xilinx.com:signal:clock:1.0 clk.clk_100mhz clk" *) (* x_interface_parameter = "xil_interfacename clk.clk_100mhz, clk_domain mipi_csi2_tx_clk_100mhz, freq_hz 100000000, freq_tolerance_hz 0, insert_vip 0, phase 0.0" *) input clk_100mhz;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 intr.interrupt interrupt" *) (* x_interface_parameter = "xil_interfacename intr.interrupt, portwidth 1, sensitivity level_high" *) output interrupt;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if clk_hs_n" *) output mipi_phy_if_clk_hs_n;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if clk_hs_p" *) output mipi_phy_if_clk_hs_p;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if clk_lp_n" *) output mipi_phy_if_clk_lp_n;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if clk_lp_p" *) output mipi_phy_if_clk_lp_p;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if data_hs_n" *) output [mipi_lane-1:0]mipi_phy_if_data_hs_n;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if data_hs_p" *) output [mipi_lane-1:0]mipi_phy_if_data_hs_p;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if data_lp_n" *) output [mipi_lane-1:0]mipi_phy_if_data_lp_n;
  (* x_interface_info = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if data_lp_p" *) output [mipi_lane-1:0]mipi_phy_if_data_lp_p;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 rst.reset rst" *) (* x_interface_parameter = "xil_interfacename rst.reset, insert_vip 0, polarity active_high" *) input reset;
    
  // wire [23:0]       s_axis_1_tdata;
  // wire              s_axis_1_tlast;
  wire              s_axis_1_tready;
  wire              s_axis_1_tvalid;
  wire [5:0]        s_axis_1_tkeep;
  wire [31:0]       init_gen_m_axi_lite_ch1_araddr;
  wire              init_gen_m_axi_lite_ch1_arready;
  wire              init_gen_m_axi_lite_ch1_arvalid;
  wire [31:0]       init_gen_m_axi_lite_ch1_awaddr;
  wire [2:0]        init_gen_m_axi_lite_ch1_awprot;
  wire              init_gen_m_axi_lite_ch1_awready;
  wire              init_gen_m_axi_lite_ch1_awvalid;
  wire              init_gen_m_axi_lite_ch1_bready;
  wire [1:0]        init_gen_m_axi_lite_ch1_bresp;
  wire              init_gen_m_axi_lite_ch1_bvalid;
  wire [31:0]       init_gen_m_axi_lite_ch1_rdata;
  wire              init_gen_m_axi_lite_ch1_rready;
  wire [1:0]        init_gen_m_axi_lite_ch1_rresp;
  wire              init_gen_m_axi_lite_ch1_rvalid;
  wire [31:0]       init_gen_m_axi_lite_ch1_wdata;
  wire              init_gen_m_axi_lite_ch1_wready;
  wire [3:0]        init_gen_m_axi_lite_ch1_wstrb;
  wire              init_gen_m_axi_lite_ch1_wvalid;
  wire              init_gen_done;
  wire [31:0]       init_gen_status;

  wire [(24*pixel_mode)-1:0]       s_mipi_axis_tdata;
  // wire [47:0]       s_axis_subset_converter_m_axis_tdata;
  wire [0:0]        s_axis_subset_converter_m_axis_tdest = 0;
  wire [8:0]        s_axis_subset_converter_m_axis_tkeep = 9'b111111111;
  wire              axis_subset_converter_m_axis_tlast = 0;

  wire              s_tx_subsyst_interrupt;
  wire              s_tx_subsyst_mipi_phy_if_clk_hs_n;
  wire              s_tx_subsyst_mipi_phy_if_clk_hs_p;
  wire              s_tx_subsyst_mipi_phy_if_clk_lp_n;
  wire              s_tx_subsyst_mipi_phy_if_clk_lp_p;
  wire [mipi_lane-1:0]        s_tx_subsyst_mipi_phy_if_data_hs_n;
  wire [mipi_lane-1:0]        s_tx_subsyst_mipi_phy_if_data_hs_p;
  wire [mipi_lane-1:0]        s_tx_subsyst_mipi_phy_if_data_lp_n;
  wire [mipi_lane-1:0]        s_tx_subsyst_mipi_phy_if_data_lp_p;

  wire [12:0]       s_tx_subsyst_s_axi_araddr;
  wire [2:0]        s_tx_subsyst_s_axi_arprot;
  wire [0:0]        s_tx_subsyst_s_axi_arready;
  wire              s_tx_subsyst_s_axi_arvalid;
  wire [12:0]       s_tx_subsyst_s_axi_awaddr;
  wire [2:0]        s_tx_subsyst_s_axi_awprot;
  wire [0:0]        s_tx_subsyst_s_axi_awready;
  wire              s_tx_subsyst_s_axi_awvalid;
  wire              s_tx_subsyst_s_axi_bready;
  wire [1:0]        s_tx_subsyst_s_axi_bresp;
  wire [0:0]        s_tx_subsyst_s_axi_bvalid;
  wire [31:0]       s_tx_subsyst_s_axi_rdata;
  wire              s_tx_subsyst_s_axi_rready;
  wire [1:0]        s_tx_subsyst_s_axi_rresp;
  wire [0:0]        s_tx_subsyst_s_axi_rvalid;
  wire [31:0]       s_tx_subsyst_s_axi_wdata;
  wire [0:0]        s_tx_subsyst_s_axi_wready;
  wire [3:0]        s_tx_subsyst_s_axi_wstrb;
  wire              s_tx_subsyst_s_axi_wvalid;
  wire [95:0]       mipi_axis_tuser;

     wire [0:0]     mipi_frame_start;               // :0   frame start
    //  wire [5:0]     mipi_data_type = 6'b100100;     // 6:1  data type , 0x24 raw888 , 2a raw8
     wire [5:0]     mipi_data_type = 6'b100010;     // 6:1  data type , 0x22 RGB565
     wire [8:0]     mipi_const_15_7 = 0;            // 15:7 reserved
     wire [15:0]    mipi_const_31_16 = 0;           // 31:16 frame number
     wire [15:0]    mipi_const_47_32 = 0;           // 47:32 line number
    //  wire [15:0]    mipi_length_packet = 16'h600;   // 63:48 length of packet in bytes , 128pixel
    //  wire [15:0]    mipi_length_packet = 16'h4800;   // 63:48 length of packet in bytes , 3072pixel x 2line x 24bit / 8bit
    //  wire [15:0]    mipi_length_packet = 16'd1024;   // 63:48 length of packet in bytes , 1024pixel x 16bit / 8bit , / 2pixel 
    //  wire [15:0]    mipi_length_packet = 16'd2048;   // 63:48 length of packet in bytes , 1024pixel x 16bit / 8bit , / 2pixel 

     wire [15:0]    mipi_length_packet;   // 63:48 length of packet in bytes , 1024pixel x 16bit / 8bit , / 2pixel 
    //  wire [15:0]    mipi_length_packet = 16'd3072;   // 63:48 length of packet in bytes , 1024pixel x 16bit / 8bit , / 2pixel 
    //  wire [15:0]    mipi_length_packet = 16'd1536;   // 63:48 length of packet in bytes , 1024pixel x 16bit / 8bit , / 2pixel 

     wire [31:0]    mipi_const_95_64 = 0;           // 95:64 reserved

  assign mipi_length_packet = csi2_word_count;

  // assign s_axis_1_tlast = s_axis_tlast;
  assign s_axis_1_tvalid = s_axis_tvalid;
  assign s_axis_1_tkeep = {s_axis_tkeep,s_axis_tkeep};
  assign s_axis_tready = s_axis_1_tready;

  assign done = init_gen_done;
  assign interrupt = s_tx_subsyst_interrupt;

  assign mipi_phy_if_clk_hs_n = s_tx_subsyst_mipi_phy_if_clk_hs_n;
  assign mipi_phy_if_clk_hs_p = s_tx_subsyst_mipi_phy_if_clk_hs_p;
  assign mipi_phy_if_clk_lp_n = s_tx_subsyst_mipi_phy_if_clk_lp_n;
  assign mipi_phy_if_clk_lp_p = s_tx_subsyst_mipi_phy_if_clk_lp_p;
  assign mipi_phy_if_data_hs_n[mipi_lane-1:0] = s_tx_subsyst_mipi_phy_if_data_hs_n;
  assign mipi_phy_if_data_hs_p[mipi_lane-1:0] = s_tx_subsyst_mipi_phy_if_data_hs_p;
  assign mipi_phy_if_data_lp_n[mipi_lane-1:0] = s_tx_subsyst_mipi_phy_if_data_lp_n;
  assign mipi_phy_if_data_lp_p[mipi_lane-1:0] = s_tx_subsyst_mipi_phy_if_data_lp_p;

  assign status[31:0] = init_gen_status;


    mipi_init_gen inst_mipi_init_gen
      (
        .s_axi_aclk              (s_axis_aclk),
        .s_axi_aresetn           (s_axi_aresetn),
//
        .m_axi_lite_ch1_awaddr   (init_gen_m_axi_lite_ch1_awaddr),
        .m_axi_lite_ch1_awprot   (init_gen_m_axi_lite_ch1_awprot),
        .m_axi_lite_ch1_awready  (init_gen_m_axi_lite_ch1_awready),
        .m_axi_lite_ch1_awvalid  (init_gen_m_axi_lite_ch1_awvalid),
        .m_axi_lite_ch1_wdata    (init_gen_m_axi_lite_ch1_wdata),
        .m_axi_lite_ch1_wstrb    (init_gen_m_axi_lite_ch1_wstrb),
        .m_axi_lite_ch1_wvalid   (init_gen_m_axi_lite_ch1_wvalid),
        .m_axi_lite_ch1_wready   (init_gen_m_axi_lite_ch1_wready),
//
        .m_axi_lite_ch1_bresp    (init_gen_m_axi_lite_ch1_bresp),
        .m_axi_lite_ch1_bvalid   (init_gen_m_axi_lite_ch1_bvalid),
        .m_axi_lite_ch1_bready   (init_gen_m_axi_lite_ch1_bready),
//
        .m_axi_lite_ch1_araddr   (init_gen_m_axi_lite_ch1_araddr),
        .m_axi_lite_ch1_arvalid  (init_gen_m_axi_lite_ch1_arvalid),
        .m_axi_lite_ch1_arready  (init_gen_m_axi_lite_ch1_arready),
        .m_axi_lite_ch1_rdata    (init_gen_m_axi_lite_ch1_rdata),
        .m_axi_lite_ch1_rready   (init_gen_m_axi_lite_ch1_rready),
        .m_axi_lite_ch1_rresp    (init_gen_m_axi_lite_ch1_rresp),
        .m_axi_lite_ch1_rvalid   (init_gen_m_axi_lite_ch1_rvalid),
//
        .done                    (init_gen_done),
        .status                  (init_gen_status)
      );


    mipi_csi2_tx_subsys inst_mipi_csi2_tx_subsyst
      (
        .s_axis_aclk             (s_axis_aclk),
        .s_axis_aresetn          (s_axi_aresetn),
        .dphy_clk_200M           (dphy_clk_200M),
        .txclkesc_out            (),       //(txclkesc_out),
        .oserdes_clk_out         (),       //(oserdes_clk_out),
        .oserdes_clk90_out       (),       //(oserdes_clk90_out),
        .txbyteclkhs             (),       //(txbyteclkhs),
        .oserdes_clkdiv_out      (),       //(oserdes_clkdiv_out),

        .mmcm_lock_out           (),       //(mmcm_lock_out),
        .cl_tst_clk_out           (cl_tst_clk_out),
        .dl_tst_clk_out           (dl_tst_clk_out),

        .interrupt               (s_tx_subsyst_interrupt),
        .mipi_phy_if_clk_hs_n    (s_tx_subsyst_mipi_phy_if_clk_hs_n),
        .mipi_phy_if_clk_hs_p    (s_tx_subsyst_mipi_phy_if_clk_hs_p),
        .mipi_phy_if_clk_lp_n    (s_tx_subsyst_mipi_phy_if_clk_lp_n),
        .mipi_phy_if_clk_lp_p    (s_tx_subsyst_mipi_phy_if_clk_lp_p),
        .mipi_phy_if_data_hs_n   (s_tx_subsyst_mipi_phy_if_data_hs_n),
        .mipi_phy_if_data_hs_p   (s_tx_subsyst_mipi_phy_if_data_hs_p),
        .mipi_phy_if_data_lp_n   (s_tx_subsyst_mipi_phy_if_data_lp_n),
        .mipi_phy_if_data_lp_p   (s_tx_subsyst_mipi_phy_if_data_lp_p),
        .s_axi_araddr            (s_tx_subsyst_s_axi_araddr),
        .s_axi_arprot            (s_tx_subsyst_s_axi_arprot),
        .s_axi_arready           (s_tx_subsyst_s_axi_arready),
        .s_axi_arvalid           (s_tx_subsyst_s_axi_arvalid),
        .s_axi_awaddr            (s_tx_subsyst_s_axi_awaddr),
        .s_axi_awprot            (s_tx_subsyst_s_axi_awprot),
        .s_axi_awready           (s_tx_subsyst_s_axi_awready),
        .s_axi_awvalid           (s_tx_subsyst_s_axi_awvalid),
        .s_axi_bready            (s_tx_subsyst_s_axi_bready),
        .s_axi_bresp             (s_tx_subsyst_s_axi_bresp),
        .s_axi_bvalid            (s_tx_subsyst_s_axi_bvalid),
        .s_axi_rdata             (s_tx_subsyst_s_axi_rdata),
        .s_axi_rready            (s_tx_subsyst_s_axi_rready),
        .s_axi_rresp             (s_tx_subsyst_s_axi_rresp),
        .s_axi_rvalid            (s_tx_subsyst_s_axi_rvalid),
        .s_axi_wdata             (s_tx_subsyst_s_axi_wdata),
        .s_axi_wready            (s_tx_subsyst_s_axi_wready),
        .s_axi_wstrb             (s_tx_subsyst_s_axi_wstrb),
        .s_axi_wvalid            (s_tx_subsyst_s_axi_wvalid),
        .s_axis_tdata            (s_mipi_axis_tdata),
        .s_axis_tdest            ({1'b0,s_axis_subset_converter_m_axis_tdest}),

//        .s_axis_tkeep            ({s_axis_subset_converter_m_axis_tkeep,s_axis_1_tkeep}),
        .s_axis_tkeep            (s_axis_1_tkeep),
        .s_axis_tlast            (s_axis_tlast),

        .s_axis_tready           (s_axis_1_tready),
        .s_axis_tuser            (mipi_axis_tuser),

        .s_axis_tvalid           (s_axis_1_tvalid),
        .system_rst_out          (system_rst_out)
      );

  assign s_mipi_axis_tdata = s_axis_tdata;

  assign s_tx_subsyst_s_axi_araddr      = init_gen_m_axi_lite_ch1_araddr;
  assign s_tx_subsyst_s_axi_arprot      = ({1'b0,1'b0,1'b0});

  assign init_gen_m_axi_lite_ch1_arready     = s_tx_subsyst_s_axi_arready;
  assign s_tx_subsyst_s_axi_arvalid     = init_gen_m_axi_lite_ch1_arvalid;
  assign s_tx_subsyst_s_axi_awaddr      = init_gen_m_axi_lite_ch1_awaddr;
  assign s_tx_subsyst_s_axi_awprot      = init_gen_m_axi_lite_ch1_awprot;

  assign init_gen_m_axi_lite_ch1_awready     = s_tx_subsyst_s_axi_awready;
  assign s_tx_subsyst_s_axi_awvalid     = init_gen_m_axi_lite_ch1_awvalid;
  assign s_tx_subsyst_s_axi_bready      = init_gen_m_axi_lite_ch1_bready;

  assign init_gen_m_axi_lite_ch1_bresp       = s_tx_subsyst_s_axi_bresp;

  assign init_gen_m_axi_lite_ch1_bvalid      = s_tx_subsyst_s_axi_bvalid;

  assign init_gen_m_axi_lite_ch1_rdata       = s_tx_subsyst_s_axi_rdata;
  assign s_tx_subsyst_s_axi_rready      = init_gen_m_axi_lite_ch1_rready;

  assign init_gen_m_axi_lite_ch1_rresp       = s_tx_subsyst_s_axi_rresp;

  assign init_gen_m_axi_lite_ch1_rvalid      = s_tx_subsyst_s_axi_rvalid;
  assign s_tx_subsyst_s_axi_wdata       = init_gen_m_axi_lite_ch1_wdata;

  assign init_gen_m_axi_lite_ch1_wready      = s_tx_subsyst_s_axi_wready;
  assign s_tx_subsyst_s_axi_wstrb       = init_gen_m_axi_lite_ch1_wstrb;
  assign s_tx_subsyst_s_axi_wvalid      = init_gen_m_axi_lite_ch1_wvalid;

  assign mipi_axis_tuser = {mipi_const_95_64,mipi_length_packet,mipi_const_47_32,mipi_const_31_16,mipi_const_15_7,mipi_data_type,mipi_frame_start};


endmodule
