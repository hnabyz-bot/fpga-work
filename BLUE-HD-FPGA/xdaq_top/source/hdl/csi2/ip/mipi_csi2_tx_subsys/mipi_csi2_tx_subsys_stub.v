// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Jan 27 14:13:28 2026
// Host        : work-dev running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top mipi_csi2_tx_subsys -prefix
//               mipi_csi2_tx_subsys_ mipi_csi2_tx_subsys_stub.v
// Design      : mipi_csi2_tx_subsys
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "mipi_csi2_tx_subsys,bd_26df,{}" *) (* CORE_GENERATION_INFO = "mipi_csi2_tx_subsys,bd_26df,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mipi_csi2_tx_subsystem,x_ipVersion=2.2,x_ipCoreRevision=18,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_OOC_VID_CLK=6.666,C_EN_CTS_TX=false,C_EN_DBG_TX=false,DPHY_PRESET=None,C_EN_SSC=false,C_CSI_MAX_BPC=8,C_CSI_XMIT_INITIAL_DESKEW=false,C_CSI_XMIT_PERIODIC_DESKEW=false,C_CSI_XMIT_ALT_DESKEW_SEQ=false,C_CSI_INIT_DESKEW_PATRN_LEN=4096,C_CSI_PERIODIC_PATRN_LEN=1024,C_CSI_PERIODIC_CNTR_WIDTH=32,C_CSI_PERIODIC_TIME=5000,C_CLK_IO_SWAP=false,C_DL0_IO_SWAP=false,C_DL1_IO_SWAP=false,C_DL2_IO_SWAP=false,C_DL3_IO_SWAP=false,C_CLK_LP_IO_SWAP=false,C_DL0_LP_IO_SWAP=false,C_DL1_LP_IO_SWAP=false,C_DL2_LP_IO_SWAP=false,C_DL3_LP_IO_SWAP=false,C_EN_DEBUG_REGS=false,C_CSI_CLK_PRE=1,C_CSI_LANES=4,C_EN_7S_LINERATE_CHECK=false,C_EXDES_CONFIG=1Lane_RGB888_1Pixel_Mode,C_EN_REG_BASED_FE_GEN=false,C_DPHY_LANES=4,C_CSI_DATATYPE=RAW8,C_CSI_PIXEL_MODE=2,C_CSI_AXIS_TDATA_WIDTH=48,C_CSI_LINE_BUFR_DEPTH=8192,C_CSI_VID_INTERFACE=AXI4S,C_CSI_CRC_ENABLE=true,C_CSI_EN_ACTIVELANES=false,C_STRETCH_LINE_RATE=2500,C_HS_LINE_RATE=400,C_DPHY_MODE=MASTER,DPHY_LPX_PERIOD=50,DPHY_ESC_CLK_PERIOD=20.000,DPHY_HS_TIMEOUT=65541,DPHY_ESC_TIMEOUT=25600,C_DPHY_EN_REG_IF=true,Component_Name=mipi_csi2_tx_subsys,HP_IO_BANK_SELECTION=46,CLK_LANE_IO_LOC=None,DATA_LANE0_IO_LOC=None,DATA_LANE1_IO_LOC=None,DATA_LANE2_IO_LOC=None,DATA_LANE3_IO_LOC=None,DATA_LANE0_BYTE=Same_Byte,DATA_LANE1_BYTE=Same_Byte,DATA_LANE2_BYTE=Same_Byte,DATA_LANE3_BYTE=Same_Byte,CLK_LANE_IO_LOC_NAME=None,DATA_LANE0_IO_LOC_NAME=None,DATA_LANE1_IO_LOC_NAME=None,DATA_LANE2_IO_LOC_NAME=None,DATA_LANE3_IO_LOC_NAME=None,SupportLevel=1,C_CLK_LANE_IO_POSITION=0,C_DATA_LANE0_IO_POSITION=2,C_DATA_LANE1_IO_POSITION=4,C_DATA_LANE2_IO_POSITION=6,C_DATA_LANE3_IO_POSITION=8,CMN_PROJ_FAMILY=0,C_IS_7SERIES=true,C_IS_VERSAL=false,C_EN_HS_OBUFTDS=true,C_INC_PHY=true}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* X_CORE_INFO = "bd_26df,Vivado 2025.2" *) 
module mipi_csi2_tx_subsys(s_axis_aclk, s_axis_aresetn, dphy_clk_200M, 
  txclkesc_out, oserdes_clk_out, oserdes_clk90_out, txbyteclkhs, oserdes_clkdiv_out, 
  system_rst_out, mmcm_lock_out, cl_tst_clk_out, dl_tst_clk_out, interrupt, s_axi_awaddr, 
  s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, 
  s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_araddr, s_axi_arprot, 
  s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready, 
  s_axis_tdata, s_axis_tdest, s_axis_tkeep, s_axis_tlast, s_axis_tready, s_axis_tuser, 
  s_axis_tvalid, mipi_phy_if_clk_hs_n, mipi_phy_if_clk_hs_p, mipi_phy_if_clk_lp_n, 
  mipi_phy_if_clk_lp_p, mipi_phy_if_data_hs_n, mipi_phy_if_data_hs_p, 
  mipi_phy_if_data_lp_n, mipi_phy_if_data_lp_p)
/* synthesis syn_black_box black_box_pad_pin="s_axis_aclk,s_axis_aresetn,dphy_clk_200M,txclkesc_out,oserdes_clk_out,oserdes_clk90_out,txbyteclkhs,oserdes_clkdiv_out,system_rst_out,mmcm_lock_out,cl_tst_clk_out,dl_tst_clk_out,interrupt,s_axi_awaddr[16:0],s_axi_awprot[2:0],s_axi_awvalid[0:0],s_axi_awready[0:0],s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid[0:0],s_axi_wready[0:0],s_axi_bresp[1:0],s_axi_bvalid[0:0],s_axi_bready[0:0],s_axi_araddr[16:0],s_axi_arprot[2:0],s_axi_arvalid[0:0],s_axi_arready[0:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid[0:0],s_axi_rready[0:0],s_axis_tdata[47:0],s_axis_tdest[1:0],s_axis_tkeep[5:0],s_axis_tlast,s_axis_tready,s_axis_tuser[95:0],s_axis_tvalid,mipi_phy_if_clk_hs_n,mipi_phy_if_clk_hs_p,mipi_phy_if_clk_lp_n,mipi_phy_if_clk_lp_p,mipi_phy_if_data_hs_n[3:0],mipi_phy_if_data_hs_p[3:0],mipi_phy_if_data_lp_n[3:0],mipi_phy_if_data_lp_p[3:0]" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.s_axis_aclk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.s_axis_aclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, ASSOCIATED_BUSIF s_axi:s_axis, ASSOCIATED_RESET s_axis_aresetn, INSERT_VIP 0, ASSOCIATED_CLKEN s_sc_aclken" *) input s_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.s_axis_aresetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.s_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.dphy_clk_200M CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.dphy_clk_200M, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_dphy_clk_200M, INSERT_VIP 0" *) input dphy_clk_200M;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txclkesc_out CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txclkesc_out, FREQ_HZ 10000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txclkesc_out, INSERT_VIP 0" *) output txclkesc_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clk_out CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clk_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk_out, INSERT_VIP 0" *) output oserdes_clk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clk90_out CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clk90_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk90_out, INSERT_VIP 0" *) output oserdes_clk90_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.txbyteclkhs CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.txbyteclkhs, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txbyteclkhs, INSERT_VIP 0" *) output txbyteclkhs;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.oserdes_clkdiv_out CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.oserdes_clkdiv_out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clkdiv_out, INSERT_VIP 0" *) output oserdes_clkdiv_out;
  output system_rst_out;
  output mmcm_lock_out;
  output cl_tst_clk_out;
  output dl_tst_clk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.interrupt INTERRUPT" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 17, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [16:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *) input [2:0]s_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input [0:0]s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output [0:0]s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input [0:0]s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output [0:0]s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output [0:0]s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input [0:0]s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [16:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input [0:0]s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output [0:0]s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output [0:0]s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input [0:0]s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis, TDATA_NUM_BYTES 6, TDEST_WIDTH 2, TID_WIDTH 0, TUSER_WIDTH 96, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, LAYERED_METADATA undef, INSERT_VIP 0" *) input [47:0]s_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDEST" *) input [1:0]s_axis_tdest;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TKEEP" *) input [5:0]s_axis_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TLAST" *) input s_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TREADY" *) output s_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TUSER" *) input [95:0]s_axis_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TVALID" *) input s_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_N" *) (* X_INTERFACE_MODE = "master" *) output mipi_phy_if_clk_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_P" *) output mipi_phy_if_clk_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_N" *) output mipi_phy_if_clk_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_P" *) output mipi_phy_if_clk_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_N" *) output [3:0]mipi_phy_if_data_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_P" *) output [3:0]mipi_phy_if_data_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_N" *) output [3:0]mipi_phy_if_data_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_P" *) output [3:0]mipi_phy_if_data_lp_p;
endmodule
