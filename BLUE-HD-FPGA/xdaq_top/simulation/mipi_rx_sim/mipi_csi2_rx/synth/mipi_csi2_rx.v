//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
//Date        : Fri Jan 16 15:10:56 2026
//Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target mipi_csi2_rx.bd
//Design      : mipi_csi2_rx
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "mipi_csi2_rx,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mipi_csi2_rx,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=9,numReposBlks=9,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=None}" *) (* HW_HANDOFF = "mipi_csi2_rx.hwdef" *) 
module mipi_csi2_rx
   (clk_100MHz,
    done,
    done_1,
    mipi_phy_if_0_clk_hs_n,
    mipi_phy_if_0_clk_hs_p,
    mipi_phy_if_0_clk_lp_n,
    mipi_phy_if_0_clk_lp_p,
    mipi_phy_if_0_data_hs_n,
    mipi_phy_if_0_data_hs_p,
    mipi_phy_if_0_data_lp_n,
    mipi_phy_if_0_data_lp_p,
    reset_rtl_0,
    rxbyteclkhs,
    status,
    status_1,
    video_out_tdata,
    video_out_tdest,
    video_out_tlast,
    video_out_tuser_0,
    video_out_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_100MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_100MHZ, CLK_DOMAIN mipi_csi2_rx_clk_100MHz, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk_100MHz;
  output done;
  output done_1;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_HS_N" *) (* X_INTERFACE_MODE = "Slave" *) input mipi_phy_if_0_clk_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_HS_P" *) input mipi_phy_if_0_clk_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_LP_N" *) input mipi_phy_if_0_clk_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_LP_P" *) input mipi_phy_if_0_clk_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_HS_N" *) input [3:0]mipi_phy_if_0_data_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_HS_P" *) input [3:0]mipi_phy_if_0_data_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_LP_N" *) input [3:0]mipi_phy_if_0_data_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_LP_P" *) input [3:0]mipi_phy_if_0_data_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_RTL_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_RTL_0, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset_rtl_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.RXBYTECLKHS CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.RXBYTECLKHS, CLK_DOMAIN bd_62e9_phy_0_rxbyteclkhs, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0" *) output rxbyteclkhs;
  output [31:0]status;
  output [31:0]status_1;
  output [31:0]video_out_tdata;
  output [9:0]video_out_tdest;
  output video_out_tlast;
  output [0:0]video_out_tuser_0;
  output video_out_tvalid;

  wire Net;
  wire [31:0]axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID;
  wire [31:0]axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR;
  wire [2:0]axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY;
  wire [1:0]axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID;
  wire [31:0]axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY;
  wire [1:0]axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID;
  wire [31:0]axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY;
  wire [3:0]axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB;
  wire axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID;
  wire [31:0]axi_traffic_gen_1_M_AXI_LITE_CH1_ARADDR;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_ARREADY;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_ARVALID;
  wire [31:0]axi_traffic_gen_1_M_AXI_LITE_CH1_AWADDR;
  wire [2:0]axi_traffic_gen_1_M_AXI_LITE_CH1_AWPROT;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_AWREADY;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_AWVALID;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_BREADY;
  wire [1:0]axi_traffic_gen_1_M_AXI_LITE_CH1_BRESP;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_BVALID;
  wire [31:0]axi_traffic_gen_1_M_AXI_LITE_CH1_RDATA;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_RREADY;
  wire [1:0]axi_traffic_gen_1_M_AXI_LITE_CH1_RRESP;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_RVALID;
  wire [31:0]axi_traffic_gen_1_M_AXI_LITE_CH1_WDATA;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_WREADY;
  wire [3:0]axi_traffic_gen_1_M_AXI_LITE_CH1_WSTRB;
  wire axi_traffic_gen_1_M_AXI_LITE_CH1_WVALID;
  wire clk_100MHz;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out4;
  wire clk_wiz_0_locked;
  wire done;
  wire done_1;
  wire mipi_csi2_rx_subsyst_0_csirxss_csi_irq;
  wire mipi_phy_if_0_clk_hs_n;
  wire mipi_phy_if_0_clk_hs_p;
  wire mipi_phy_if_0_clk_lp_n;
  wire mipi_phy_if_0_clk_lp_p;
  wire [3:0]mipi_phy_if_0_data_hs_n;
  wire [3:0]mipi_phy_if_0_data_hs_p;
  wire [3:0]mipi_phy_if_0_data_lp_n;
  wire [3:0]mipi_phy_if_0_data_lp_p;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire reset_rtl_0;
  wire [0:0]rst_clk_wiz_0_100M1_peripheral_aresetn;
  wire [0:0]rst_clk_wiz_0_100M_interconnect_aresetn;
  wire [0:0]rst_clk_wiz_0_100M_peripheral_aresetn;
  wire rxbyteclkhs;
  wire [12:0]smartconnect_0_M00_AXI_ARADDR;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire [0:0]smartconnect_0_M00_AXI_ARREADY;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [12:0]smartconnect_0_M00_AXI_AWADDR;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [0:0]smartconnect_0_M00_AXI_AWREADY;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire [0:0]smartconnect_0_M00_AXI_BVALID;
  wire [31:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire [0:0]smartconnect_0_M00_AXI_RVALID;
  wire [31:0]smartconnect_0_M00_AXI_WDATA;
  wire [0:0]smartconnect_0_M00_AXI_WREADY;
  wire [3:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [31:0]status;
  wire [31:0]status_1;
  wire [31:0]video_out_tdata;
  wire [9:0]video_out_tdest;
  wire video_out_tlast;
  wire [0:0]video_out_tuser_0;
  wire video_out_tvalid;
  wire [0:0]xlconstant_0_dout;
  wire NLW_mipi_csi2_rx_subsyst_0_frame_rcvd_pulse_out_UNCONNECTED;
  wire NLW_mipi_csi2_rx_subsyst_0_system_rst_out_UNCONNECTED;
  wire NLW_proc_sys_reset_0_mb_reset_UNCONNECTED;
  wire [0:0]NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED;
  wire [0:0]NLW_proc_sys_reset_0_interconnect_aresetn_UNCONNECTED;
  wire [0:0]NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED;
  wire NLW_rst_clk_wiz_0_100M_mb_reset_UNCONNECTED;
  wire [0:0]NLW_rst_clk_wiz_0_100M_bus_struct_reset_UNCONNECTED;
  wire [0:0]NLW_rst_clk_wiz_0_100M_peripheral_reset_UNCONNECTED;

  mipi_csi2_rx_axi_traffic_gen_0_0 axi_traffic_gen_0
       (.done(done),
        .m_axi_lite_ch1_araddr(axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR),
        .m_axi_lite_ch1_arready(axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY),
        .m_axi_lite_ch1_arvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID),
        .m_axi_lite_ch1_awaddr(axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR),
        .m_axi_lite_ch1_awprot(axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT),
        .m_axi_lite_ch1_awready(axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY),
        .m_axi_lite_ch1_awvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID),
        .m_axi_lite_ch1_bready(axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY),
        .m_axi_lite_ch1_bresp(axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP),
        .m_axi_lite_ch1_bvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID),
        .m_axi_lite_ch1_rdata(axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA),
        .m_axi_lite_ch1_rready(axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY),
        .m_axi_lite_ch1_rresp(axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP),
        .m_axi_lite_ch1_rvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID),
        .m_axi_lite_ch1_wdata(axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA),
        .m_axi_lite_ch1_wready(axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY),
        .m_axi_lite_ch1_wstrb(axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB),
        .m_axi_lite_ch1_wvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID),
        .s_axi_aclk(clk_wiz_0_clk_out1),
        .s_axi_aresetn(rst_clk_wiz_0_100M_peripheral_aresetn),
        .status(status));
  mipi_csi2_rx_axi_traffic_gen_1_0 axi_traffic_gen_1
       (.done(done_1),
        .m_axi_lite_ch1_araddr(axi_traffic_gen_1_M_AXI_LITE_CH1_ARADDR),
        .m_axi_lite_ch1_arready(axi_traffic_gen_1_M_AXI_LITE_CH1_ARREADY),
        .m_axi_lite_ch1_arvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_ARVALID),
        .m_axi_lite_ch1_awaddr(axi_traffic_gen_1_M_AXI_LITE_CH1_AWADDR),
        .m_axi_lite_ch1_awprot(axi_traffic_gen_1_M_AXI_LITE_CH1_AWPROT),
        .m_axi_lite_ch1_awready(axi_traffic_gen_1_M_AXI_LITE_CH1_AWREADY),
        .m_axi_lite_ch1_awvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_AWVALID),
        .m_axi_lite_ch1_bready(axi_traffic_gen_1_M_AXI_LITE_CH1_BREADY),
        .m_axi_lite_ch1_bresp(axi_traffic_gen_1_M_AXI_LITE_CH1_BRESP),
        .m_axi_lite_ch1_bvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_BVALID),
        .m_axi_lite_ch1_rdata(axi_traffic_gen_1_M_AXI_LITE_CH1_RDATA),
        .m_axi_lite_ch1_rready(axi_traffic_gen_1_M_AXI_LITE_CH1_RREADY),
        .m_axi_lite_ch1_rresp(axi_traffic_gen_1_M_AXI_LITE_CH1_RRESP),
        .m_axi_lite_ch1_rvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_RVALID),
        .m_axi_lite_ch1_wdata(axi_traffic_gen_1_M_AXI_LITE_CH1_WDATA),
        .m_axi_lite_ch1_wready(axi_traffic_gen_1_M_AXI_LITE_CH1_WREADY),
        .m_axi_lite_ch1_wstrb(axi_traffic_gen_1_M_AXI_LITE_CH1_WSTRB),
        .m_axi_lite_ch1_wvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_WVALID),
        .s_axi_aclk(clk_wiz_0_clk_out1),
        .s_axi_aresetn(rst_clk_wiz_0_100M1_peripheral_aresetn),
        .status(status_1));
  mipi_csi2_rx_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_100MHz),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(Net),
        .clk_out3(clk_wiz_0_clk_out4),
        .locked(clk_wiz_0_locked),
        .reset(reset_rtl_0));
  mipi_csi2_rx_mipi_csi2_rx_subsyst_0_0 mipi_csi2_rx_subsyst_0
       (.csirxss_csi_irq(mipi_csi2_rx_subsyst_0_csirxss_csi_irq),
        .csirxss_s_axi_araddr(smartconnect_0_M00_AXI_ARADDR),
        .csirxss_s_axi_arprot(smartconnect_0_M00_AXI_ARPROT),
        .csirxss_s_axi_arready(smartconnect_0_M00_AXI_ARREADY),
        .csirxss_s_axi_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .csirxss_s_axi_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .csirxss_s_axi_awprot(smartconnect_0_M00_AXI_AWPROT),
        .csirxss_s_axi_awready(smartconnect_0_M00_AXI_AWREADY),
        .csirxss_s_axi_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .csirxss_s_axi_bready(smartconnect_0_M00_AXI_BREADY),
        .csirxss_s_axi_bresp(smartconnect_0_M00_AXI_BRESP),
        .csirxss_s_axi_bvalid(smartconnect_0_M00_AXI_BVALID),
        .csirxss_s_axi_rdata(smartconnect_0_M00_AXI_RDATA),
        .csirxss_s_axi_rready(smartconnect_0_M00_AXI_RREADY),
        .csirxss_s_axi_rresp(smartconnect_0_M00_AXI_RRESP),
        .csirxss_s_axi_rvalid(smartconnect_0_M00_AXI_RVALID),
        .csirxss_s_axi_wdata(smartconnect_0_M00_AXI_WDATA),
        .csirxss_s_axi_wready(smartconnect_0_M00_AXI_WREADY),
        .csirxss_s_axi_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .csirxss_s_axi_wvalid(smartconnect_0_M00_AXI_WVALID),
        .dphy_clk_200M(Net),
        .lite_aclk(clk_wiz_0_clk_out1),
        .lite_aresetn(rst_clk_wiz_0_100M_peripheral_aresetn),
        .mipi_phy_if_clk_hs_n(mipi_phy_if_0_clk_hs_n),
        .mipi_phy_if_clk_hs_p(mipi_phy_if_0_clk_hs_p),
        .mipi_phy_if_clk_lp_n(mipi_phy_if_0_clk_lp_n),
        .mipi_phy_if_clk_lp_p(mipi_phy_if_0_clk_lp_p),
        .mipi_phy_if_data_hs_n(mipi_phy_if_0_data_hs_n),
        .mipi_phy_if_data_hs_p(mipi_phy_if_0_data_hs_p),
        .mipi_phy_if_data_lp_n(mipi_phy_if_0_data_lp_n),
        .mipi_phy_if_data_lp_p(mipi_phy_if_0_data_lp_p),
        .rxbyteclkhs(rxbyteclkhs),
        .video_aclk(clk_wiz_0_clk_out4),
        .video_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .video_out_tdata(video_out_tdata),
        .video_out_tdest(video_out_tdest),
        .video_out_tlast(video_out_tlast),
        .video_out_tready(xlconstant_0_dout),
        .video_out_tuser(video_out_tuser_0),
        .video_out_tvalid(video_out_tvalid));
  mipi_csi2_rx_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(reset_rtl_0),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(clk_wiz_0_clk_out4));
  mipi_csi2_rx_rst_clk_wiz_0_100M_0 rst_clk_wiz_0_100M
       (.aux_reset_in(1'b1),
        .dcm_locked(clk_wiz_0_locked),
        .ext_reset_in(reset_rtl_0),
        .interconnect_aresetn(rst_clk_wiz_0_100M_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_clk_wiz_0_100M_peripheral_aresetn),
        .slowest_sync_clk(clk_wiz_0_clk_out1));
  mipi_csi2_rx_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .S00_AXI_araddr(axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR),
        .S00_AXI_arprot({1'b0,1'b0,1'b0}),
        .S00_AXI_arready(axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY),
        .S00_AXI_arvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID),
        .S00_AXI_awaddr(axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR),
        .S00_AXI_awprot(axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT),
        .S00_AXI_awready(axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY),
        .S00_AXI_awvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID),
        .S00_AXI_bready(axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY),
        .S00_AXI_bresp(axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP),
        .S00_AXI_bvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID),
        .S00_AXI_rdata(axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA),
        .S00_AXI_rready(axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY),
        .S00_AXI_rresp(axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP),
        .S00_AXI_rvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID),
        .S00_AXI_wdata(axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA),
        .S00_AXI_wready(axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY),
        .S00_AXI_wstrb(axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB),
        .S00_AXI_wvalid(axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID),
        .S01_AXI_araddr(axi_traffic_gen_1_M_AXI_LITE_CH1_ARADDR),
        .S01_AXI_arprot({1'b0,1'b0,1'b0}),
        .S01_AXI_arready(axi_traffic_gen_1_M_AXI_LITE_CH1_ARREADY),
        .S01_AXI_arvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_ARVALID),
        .S01_AXI_awaddr(axi_traffic_gen_1_M_AXI_LITE_CH1_AWADDR),
        .S01_AXI_awprot(axi_traffic_gen_1_M_AXI_LITE_CH1_AWPROT),
        .S01_AXI_awready(axi_traffic_gen_1_M_AXI_LITE_CH1_AWREADY),
        .S01_AXI_awvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_AWVALID),
        .S01_AXI_bready(axi_traffic_gen_1_M_AXI_LITE_CH1_BREADY),
        .S01_AXI_bresp(axi_traffic_gen_1_M_AXI_LITE_CH1_BRESP),
        .S01_AXI_bvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_BVALID),
        .S01_AXI_rdata(axi_traffic_gen_1_M_AXI_LITE_CH1_RDATA),
        .S01_AXI_rready(axi_traffic_gen_1_M_AXI_LITE_CH1_RREADY),
        .S01_AXI_rresp(axi_traffic_gen_1_M_AXI_LITE_CH1_RRESP),
        .S01_AXI_rvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_RVALID),
        .S01_AXI_wdata(axi_traffic_gen_1_M_AXI_LITE_CH1_WDATA),
        .S01_AXI_wready(axi_traffic_gen_1_M_AXI_LITE_CH1_WREADY),
        .S01_AXI_wstrb(axi_traffic_gen_1_M_AXI_LITE_CH1_WSTRB),
        .S01_AXI_wvalid(axi_traffic_gen_1_M_AXI_LITE_CH1_WVALID),
        .aclk(clk_wiz_0_clk_out1),
        .aresetn(rst_clk_wiz_0_100M_interconnect_aresetn));
  mipi_csi2_rx_xlconcat_1_0 xlconcat_1
       (.In0(mipi_csi2_rx_subsyst_0_csirxss_csi_irq),
        .dout(rst_clk_wiz_0_100M1_peripheral_aresetn));
  mipi_csi2_rx_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
