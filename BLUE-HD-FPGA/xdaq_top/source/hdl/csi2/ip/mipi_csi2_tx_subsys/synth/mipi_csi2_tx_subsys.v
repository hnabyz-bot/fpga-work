// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:mipi_csi2_tx_subsystem:2.2
// IP Revision: 18

(* X_CORE_INFO = "bd_26df,Vivado 2025.2" *)
(* CHECK_LICENSE_TYPE = "mipi_csi2_tx_subsys,bd_26df,{}" *)
(* CORE_GENERATION_INFO = "mipi_csi2_tx_subsys,bd_26df,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mipi_csi2_tx_subsystem,x_ipVersion=2.2,x_ipCoreRevision=18,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_OOC_VID_CLK=6.666,C_EN_CTS_TX=false,C_EN_DBG_TX=false,DPHY_PRESET=None,C_EN_SSC=false,C_CSI_MAX_BPC=8,C_CSI_XMIT_INITIAL_DESKEW=false,C_CSI_XMIT_PERIODIC_DESKEW=false,C_CSI_XMIT_ALT_DESKEW_SEQ=false,C_CSI_INIT_DESKEW_PATRN_LEN=4096,C_CSI_PERIODIC_PATRN_LEN=1024,C_CSI_PERIODIC_CNTR_WIDTH=32,C_CS\
I_PERIODIC_TIME=5000,C_CLK_IO_SWAP=false,C_DL0_IO_SWAP=false,C_DL1_IO_SWAP=false,C_DL2_IO_SWAP=false,C_DL3_IO_SWAP=false,C_CLK_LP_IO_SWAP=false,C_DL0_LP_IO_SWAP=false,C_DL1_LP_IO_SWAP=false,C_DL2_LP_IO_SWAP=false,C_DL3_LP_IO_SWAP=false,C_EN_DEBUG_REGS=false,C_CSI_CLK_PRE=1,C_CSI_LANES=4,C_EN_7S_LINERATE_CHECK=false,C_EXDES_CONFIG=1Lane_RGB888_1Pixel_Mode,C_EN_REG_BASED_FE_GEN=false,C_DPHY_LANES=4,C_CSI_DATATYPE=RAW8,C_CSI_PIXEL_MODE=2,C_CSI_AXIS_TDATA_WIDTH=48,C_CSI_LINE_BUFR_DEPTH=8192,C_CSI_VI\
D_INTERFACE=AXI4S,C_CSI_CRC_ENABLE=true,C_CSI_EN_ACTIVELANES=false,C_STRETCH_LINE_RATE=2500,C_HS_LINE_RATE=400,C_DPHY_MODE=MASTER,DPHY_LPX_PERIOD=50,DPHY_ESC_CLK_PERIOD=20.000,DPHY_HS_TIMEOUT=65541,DPHY_ESC_TIMEOUT=25600,C_DPHY_EN_REG_IF=true,Component_Name=mipi_csi2_tx_subsys,HP_IO_BANK_SELECTION=46,CLK_LANE_IO_LOC=None,DATA_LANE0_IO_LOC=None,DATA_LANE1_IO_LOC=None,DATA_LANE2_IO_LOC=None,DATA_LANE3_IO_LOC=None,DATA_LANE0_BYTE=Same_Byte,DATA_LANE1_BYTE=Same_Byte,DATA_LANE2_BYTE=Same_Byte,DATA_LA\
NE3_BYTE=Same_Byte,CLK_LANE_IO_LOC_NAME=None,DATA_LANE0_IO_LOC_NAME=None,DATA_LANE1_IO_LOC_NAME=None,DATA_LANE2_IO_LOC_NAME=None,DATA_LANE3_IO_LOC_NAME=None,SupportLevel=1,C_CLK_LANE_IO_POSITION=0,C_DATA_LANE0_IO_POSITION=2,C_DATA_LANE1_IO_POSITION=4,C_DATA_LANE2_IO_POSITION=6,C_DATA_LANE3_IO_POSITION=8,CMN_PROJ_FAMILY=0,C_IS_7SERIES=true,C_IS_VERSAL=false,C_EN_HS_OBUFTDS=true,C_INC_PHY=true}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module mipi_csi2_tx_subsys (
  s_axis_aclk,
  s_axis_aresetn,
  dphy_clk_200M,
  txclkesc_out,
  oserdes_clk_out,
  oserdes_clk90_out,
  txbyteclkhs,
  oserdes_clkdiv_out,
  system_rst_out,
  mmcm_lock_out,
  cl_tst_clk_out,
  dl_tst_clk_out,
  interrupt,
  s_axi_awaddr,
  s_axi_awprot,
  s_axi_awvalid,
  s_axi_awready,
  s_axi_wdata,
  s_axi_wstrb,
  s_axi_wvalid,
  s_axi_wready,
  s_axi_bresp,
  s_axi_bvalid,
  s_axi_bready,
  s_axi_araddr,
  s_axi_arprot,
  s_axi_arvalid,
  s_axi_arready,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rvalid,
  s_axi_rready,
  s_axis_tdata,
  s_axis_tdest,
  s_axis_tkeep,
  s_axis_tlast,
  s_axis_tready,
  s_axis_tuser,
  s_axis_tvalid,
  mipi_phy_if_clk_hs_n,
  mipi_phy_if_clk_hs_p,
  mipi_phy_if_clk_lp_n,
  mipi_phy_if_clk_lp_p,
  mipi_phy_if_data_hs_n,
  mipi_phy_if_data_hs_p,
  mipi_phy_if_data_lp_n,
  mipi_phy_if_data_lp_p
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.s_axis_aclk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.s_axis_aclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, ASSOCIATED_BUSIF s_axi:s_axis, ASSOCIATED_RESET s_axis_aresetn, INSERT_VIP 0, ASSOCIATED_CLKEN s_sc_aclken" *)
input wire s_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.s_axis_aresetn RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.s_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire s_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.dphy_clk_200M CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.dphy_clk_200M, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_dphy_clk_200M, INSERT_VIP 0" *)
input wire dphy_clk_200M;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txclkesc_out CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txclkesc_out, FREQ_HZ 10000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txclkesc_out, INSERT_VIP 0" *)
output wire txclkesc_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clk_out CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clk_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk_out, INSERT_VIP 0" *)
output wire oserdes_clk_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clk90_out CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clk90_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk90_out, INSERT_VIP 0" *)
output wire oserdes_clk90_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txbyteclkhs CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txbyteclkhs, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txbyteclkhs, INSERT_VIP 0" *)
output wire txbyteclkhs;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clkdiv_out CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clkdiv_out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clkdiv_out, INSERT_VIP 0" *)
output wire oserdes_clkdiv_out;
output wire system_rst_out;
output wire mmcm_lock_out;
output wire cl_tst_clk_out;
output wire dl_tst_clk_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.interrupt INTERRUPT" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 17, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS\
 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
input wire [16 : 0] s_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *)
input wire [2 : 0] s_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *)
input wire [0 : 0] s_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *)
output wire [0 : 0] s_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *)
input wire [31 : 0] s_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *)
input wire [3 : 0] s_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *)
input wire [0 : 0] s_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *)
output wire [0 : 0] s_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *)
output wire [1 : 0] s_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *)
output wire [0 : 0] s_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *)
input wire [0 : 0] s_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *)
input wire [16 : 0] s_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *)
input wire [2 : 0] s_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *)
input wire [0 : 0] s_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *)
output wire [0 : 0] s_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *)
output wire [31 : 0] s_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *)
output wire [1 : 0] s_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *)
output wire [0 : 0] s_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *)
input wire [0 : 0] s_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis, TDATA_NUM_BYTES 6, TDEST_WIDTH 2, TID_WIDTH 0, TUSER_WIDTH 96, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
input wire [47 : 0] s_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDEST" *)
input wire [1 : 0] s_axis_tdest;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TKEEP" *)
input wire [5 : 0] s_axis_tkeep;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TLAST" *)
input wire s_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TREADY" *)
output wire s_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TUSER" *)
input wire [95 : 0] s_axis_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TVALID" *)
input wire s_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_N" *)
(* X_INTERFACE_MODE = "master" *)
output wire mipi_phy_if_clk_hs_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_P" *)
output wire mipi_phy_if_clk_hs_p;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_N" *)
output wire mipi_phy_if_clk_lp_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_P" *)
output wire mipi_phy_if_clk_lp_p;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_N" *)
output wire [3 : 0] mipi_phy_if_data_hs_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_P" *)
output wire [3 : 0] mipi_phy_if_data_hs_p;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_N" *)
output wire [3 : 0] mipi_phy_if_data_lp_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_P" *)
output wire [3 : 0] mipi_phy_if_data_lp_p;

  bd_26df inst (
    .s_axis_aclk(s_axis_aclk),
    .s_axis_aresetn(s_axis_aresetn),
    .dphy_clk_200M(dphy_clk_200M),
    .txclkesc_out(txclkesc_out),
    .oserdes_clk_out(oserdes_clk_out),
    .oserdes_clk90_out(oserdes_clk90_out),
    .txbyteclkhs(txbyteclkhs),
    .oserdes_clkdiv_out(oserdes_clkdiv_out),
    .system_rst_out(system_rst_out),
    .mmcm_lock_out(mmcm_lock_out),
    .cl_tst_clk_out(cl_tst_clk_out),
    .dl_tst_clk_out(dl_tst_clk_out),
    .interrupt(interrupt),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tdest(s_axis_tdest),
    .s_axis_tkeep(s_axis_tkeep),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tready(s_axis_tready),
    .s_axis_tuser(s_axis_tuser),
    .s_axis_tvalid(s_axis_tvalid),
    .mipi_phy_if_clk_hs_n(mipi_phy_if_clk_hs_n),
    .mipi_phy_if_clk_hs_p(mipi_phy_if_clk_hs_p),
    .mipi_phy_if_clk_lp_n(mipi_phy_if_clk_lp_n),
    .mipi_phy_if_clk_lp_p(mipi_phy_if_clk_lp_p),
    .mipi_phy_if_data_hs_n(mipi_phy_if_data_hs_n),
    .mipi_phy_if_data_hs_p(mipi_phy_if_data_hs_p),
    .mipi_phy_if_data_lp_n(mipi_phy_if_data_lp_n),
    .mipi_phy_if_data_lp_p(mipi_phy_if_data_lp_p)
  );
endmodule
