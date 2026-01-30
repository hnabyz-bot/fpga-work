//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_26df.bd
//Design : bd_26df
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_26df,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_26df,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "mipi_csi2_tx_subsys.hwdef" *) 
module bd_26df
   (cl_tst_clk_out,
    dl_tst_clk_out,
    dphy_clk_200M,
    interrupt,
    mipi_phy_if_clk_hs_n,
    mipi_phy_if_clk_hs_p,
    mipi_phy_if_clk_lp_n,
    mipi_phy_if_clk_lp_p,
    mipi_phy_if_data_hs_n,
    mipi_phy_if_data_hs_p,
    mipi_phy_if_data_lp_n,
    mipi_phy_if_data_lp_p,
    mmcm_lock_out,
    oserdes_clk90_out,
    oserdes_clk_out,
    oserdes_clkdiv_out,
    s_axi_araddr,
    s_axi_arprot,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axis_aclk,
    s_axis_aresetn,
    s_axis_tdata,
    s_axis_tdest,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tready,
    s_axis_tuser,
    s_axis_tvalid,
    system_rst_out,
    txbyteclkhs,
    txclkesc_out);
  output cl_tst_clk_out;
  output dl_tst_clk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DPHY_CLK_200M CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DPHY_CLK_200M, CLK_DOMAIN bd_26df_dphy_clk_200M, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input dphy_clk_200M;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.INTERRUPT INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.INTERRUPT, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output interrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_N" *) (* X_INTERFACE_MODE = "Master" *) output mipi_phy_if_clk_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_P" *) output mipi_phy_if_clk_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_N" *) output mipi_phy_if_clk_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_P" *) output mipi_phy_if_clk_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_N" *) output [3:0]mipi_phy_if_data_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_P" *) output [3:0]mipi_phy_if_data_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_N" *) output [3:0]mipi_phy_if_data_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_P" *) output [3:0]mipi_phy_if_data_lp_p;
  output mmcm_lock_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.OSERDES_CLK90_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.OSERDES_CLK90_OUT, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk90_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output oserdes_clk90_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.OSERDES_CLK_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.OSERDES_CLK_OUT, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output oserdes_clk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.OSERDES_CLKDIV_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.OSERDES_CLKDIV_OUT, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clkdiv_out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output oserdes_clkdiv_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) (* X_INTERFACE_MODE = "Slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, ADDR_WIDTH 17, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN bd_26df_s_axis_aclk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [16:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [16:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *) input [2:0]s_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXIS_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXIS_ACLK, ASSOCIATED_BUSIF s_axi:s_axis, ASSOCIATED_CLKEN s_sc_aclken, ASSOCIATED_RESET s_axis_aresetn, CLK_DOMAIN bd_26df_s_axis_aclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input s_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXIS_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *) (* X_INTERFACE_MODE = "Slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis, CLK_DOMAIN bd_26df_s_axis_aclk, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 6, TDEST_WIDTH 2, TID_WIDTH 0, TUSER_WIDTH 96" *) input [47:0]s_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDEST" *) input [1:0]s_axis_tdest;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TKEEP" *) input [5:0]s_axis_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TLAST" *) input s_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TREADY" *) output s_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TUSER" *) input [95:0]s_axis_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TVALID" *) input s_axis_tvalid;
  output system_rst_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.TXBYTECLKHS CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.TXBYTECLKHS, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txbyteclkhs, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0" *) output txbyteclkhs;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.TXCLKESC_OUT CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.TXCLKESC_OUT, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txclkesc_out, FREQ_HZ 10000000.0, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0" *) output txclkesc_out;

  wire [7:0]axi_crossbar_0_M00_AXI_ARADDR;
  wire axi_crossbar_0_M00_AXI_ARREADY;
  wire axi_crossbar_0_M00_AXI_ARVALID;
  wire [7:0]axi_crossbar_0_M00_AXI_AWADDR;
  wire axi_crossbar_0_M00_AXI_AWREADY;
  wire axi_crossbar_0_M00_AXI_AWVALID;
  wire axi_crossbar_0_M00_AXI_BREADY;
  wire [1:0]axi_crossbar_0_M00_AXI_BRESP;
  wire axi_crossbar_0_M00_AXI_BVALID;
  wire [31:0]axi_crossbar_0_M00_AXI_RDATA;
  wire axi_crossbar_0_M00_AXI_RREADY;
  wire [1:0]axi_crossbar_0_M00_AXI_RRESP;
  wire axi_crossbar_0_M00_AXI_RVALID;
  wire [31:0]axi_crossbar_0_M00_AXI_WDATA;
  wire axi_crossbar_0_M00_AXI_WREADY;
  wire [3:0]axi_crossbar_0_M00_AXI_WSTRB;
  wire axi_crossbar_0_M00_AXI_WVALID;
  wire [6:0]axi_crossbar_0_M01_AXI_ARADDR;
  wire axi_crossbar_0_M01_AXI_ARREADY;
  wire axi_crossbar_0_M01_AXI_ARVALID;
  wire [6:0]axi_crossbar_0_M01_AXI_AWADDR;
  wire axi_crossbar_0_M01_AXI_AWREADY;
  wire axi_crossbar_0_M01_AXI_AWVALID;
  wire axi_crossbar_0_M01_AXI_BREADY;
  wire [1:0]axi_crossbar_0_M01_AXI_BRESP;
  wire axi_crossbar_0_M01_AXI_BVALID;
  wire [31:0]axi_crossbar_0_M01_AXI_RDATA;
  wire axi_crossbar_0_M01_AXI_RREADY;
  wire [1:0]axi_crossbar_0_M01_AXI_RRESP;
  wire axi_crossbar_0_M01_AXI_RVALID;
  wire [31:0]axi_crossbar_0_M01_AXI_WDATA;
  wire axi_crossbar_0_M01_AXI_WREADY;
  wire [3:0]axi_crossbar_0_M01_AXI_WSTRB;
  wire axi_crossbar_0_M01_AXI_WVALID;
  wire cl_tst_clk_out;
  wire dl_tst_clk_out;
  wire dphy_clk_200M;
  wire interrupt;
  wire mipi_csi2_tx_ctrl_0_master_reset_4dphy;
  wire mipi_dphy_0_cl_txclkactivehs;
  wire mipi_dphy_0_dl0_stopstate;
  wire mipi_dphy_0_init_done;
  wire mipi_dphy_0_tx_mipi_ppi_if_CL_ENABLE;
  wire mipi_dphy_0_tx_mipi_ppi_if_CL_TXREQUESTHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSCLK;
  wire mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSEXIT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_ENABLE;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_FORCETXSTOPMODE;
  wire [7:0]mipi_dphy_0_tx_mipi_ppi_if_DL0_TXDATAHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREADYHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSEXIT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL0_ULPSACTIVENOT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_ENABLE;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_FORCETXSTOPMODE;
  wire [7:0]mipi_dphy_0_tx_mipi_ppi_if_DL1_TXDATAHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREADYHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSEXIT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL1_ULPSACTIVENOT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_ENABLE;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_FORCETXSTOPMODE;
  wire [7:0]mipi_dphy_0_tx_mipi_ppi_if_DL2_TXDATAHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREADYHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSEXIT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL2_ULPSACTIVENOT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_ENABLE;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_FORCETXSTOPMODE;
  wire [7:0]mipi_dphy_0_tx_mipi_ppi_if_DL3_TXDATAHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREADYHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTHS;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSESC;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSEXIT;
  wire mipi_dphy_0_tx_mipi_ppi_if_DL3_ULPSACTIVENOT;
  wire mipi_phy_if_clk_hs_n;
  wire mipi_phy_if_clk_hs_p;
  wire mipi_phy_if_clk_lp_n;
  wire mipi_phy_if_clk_lp_p;
  wire [3:0]mipi_phy_if_data_hs_n;
  wire [3:0]mipi_phy_if_data_hs_p;
  wire [3:0]mipi_phy_if_data_lp_n;
  wire [3:0]mipi_phy_if_data_lp_p;
  wire mmcm_lock_out;
  wire oserdes_clk90_out;
  wire oserdes_clk_out;
  wire oserdes_clkdiv_out;
  wire [16:0]s_axi_araddr;
  wire [2:0]s_axi_arprot;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [16:0]s_axi_awaddr;
  wire [2:0]s_axi_awprot;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire s_axis_aclk;
  wire s_axis_aresetn;
  wire [47:0]s_axis_tdata;
  wire [1:0]s_axis_tdest;
  wire [5:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire s_axis_tready;
  wire [95:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire system_rst_out;
  wire txbyteclkhs;
  wire txclkesc_out;
  wire [2:0]NLW_axi_crossbar_0_M00_AXI_arprot_UNCONNECTED;
  wire [2:0]NLW_axi_crossbar_0_M00_AXI_awprot_UNCONNECTED;
  wire [2:0]NLW_axi_crossbar_0_M01_AXI_arprot_UNCONNECTED;
  wire [2:0]NLW_axi_crossbar_0_M01_AXI_awprot_UNCONNECTED;
  wire NLW_mipi_csi2_tx_ctrl_0_dl0_txskewcalhs_UNCONNECTED;
  wire NLW_mipi_csi2_tx_ctrl_0_dl1_txskewcalhs_UNCONNECTED;
  wire NLW_mipi_csi2_tx_ctrl_0_dl2_txskewcalhs_UNCONNECTED;
  wire NLW_mipi_csi2_tx_ctrl_0_dl3_txskewcalhs_UNCONNECTED;
  wire NLW_mipi_dphy_0_cl_stopstate_UNCONNECTED;
  wire NLW_mipi_dphy_0_cl_ulpsactivenot_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl0_txreadyesc_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl1_stopstate_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl1_txreadyesc_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl2_stopstate_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl2_txreadyesc_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl3_stopstate_UNCONNECTED;
  wire NLW_mipi_dphy_0_dl3_txreadyesc_UNCONNECTED;

  bd_26df_axi_crossbar_0_0 axi_crossbar_0
       (.M00_AXI_araddr(axi_crossbar_0_M00_AXI_ARADDR),
        .M00_AXI_arready(axi_crossbar_0_M00_AXI_ARREADY),
        .M00_AXI_arvalid(axi_crossbar_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_crossbar_0_M00_AXI_AWADDR),
        .M00_AXI_awready(axi_crossbar_0_M00_AXI_AWREADY),
        .M00_AXI_awvalid(axi_crossbar_0_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_crossbar_0_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_crossbar_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_crossbar_0_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_crossbar_0_M00_AXI_RDATA),
        .M00_AXI_rready(axi_crossbar_0_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_crossbar_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_crossbar_0_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_crossbar_0_M00_AXI_WDATA),
        .M00_AXI_wready(axi_crossbar_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_crossbar_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_crossbar_0_M00_AXI_WVALID),
        .M01_AXI_araddr(axi_crossbar_0_M01_AXI_ARADDR),
        .M01_AXI_arready(axi_crossbar_0_M01_AXI_ARREADY),
        .M01_AXI_arvalid(axi_crossbar_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(axi_crossbar_0_M01_AXI_AWADDR),
        .M01_AXI_awready(axi_crossbar_0_M01_AXI_AWREADY),
        .M01_AXI_awvalid(axi_crossbar_0_M01_AXI_AWVALID),
        .M01_AXI_bready(axi_crossbar_0_M01_AXI_BREADY),
        .M01_AXI_bresp(axi_crossbar_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(axi_crossbar_0_M01_AXI_BVALID),
        .M01_AXI_rdata(axi_crossbar_0_M01_AXI_RDATA),
        .M01_AXI_rready(axi_crossbar_0_M01_AXI_RREADY),
        .M01_AXI_rresp(axi_crossbar_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(axi_crossbar_0_M01_AXI_RVALID),
        .M01_AXI_wdata(axi_crossbar_0_M01_AXI_WDATA),
        .M01_AXI_wready(axi_crossbar_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(axi_crossbar_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(axi_crossbar_0_M01_AXI_WVALID),
        .S00_AXI_araddr(s_axi_araddr),
        .S00_AXI_arprot(s_axi_arprot),
        .S00_AXI_arready(s_axi_arready),
        .S00_AXI_arvalid(s_axi_arvalid),
        .S00_AXI_awaddr(s_axi_awaddr),
        .S00_AXI_awprot(s_axi_awprot),
        .S00_AXI_awready(s_axi_awready),
        .S00_AXI_awvalid(s_axi_awvalid),
        .S00_AXI_bready(s_axi_bready),
        .S00_AXI_bresp(s_axi_bresp),
        .S00_AXI_bvalid(s_axi_bvalid),
        .S00_AXI_rdata(s_axi_rdata),
        .S00_AXI_rready(s_axi_rready),
        .S00_AXI_rresp(s_axi_rresp),
        .S00_AXI_rvalid(s_axi_rvalid),
        .S00_AXI_wdata(s_axi_wdata),
        .S00_AXI_wready(s_axi_wready),
        .S00_AXI_wstrb(s_axi_wstrb),
        .S00_AXI_wvalid(s_axi_wvalid),
        .aclk(s_axis_aclk),
        .aresetn(s_axis_aresetn));
  bd_26df_mipi_csi2_tx_ctrl_0_0 mipi_csi2_tx_ctrl_0
       (.cl_enable(mipi_dphy_0_tx_mipi_ppi_if_CL_ENABLE),
        .cl_txclkactive(mipi_dphy_0_cl_txclkactivehs),
        .cl_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_CL_TXREQUESTHS),
        .cl_txulpsclk(mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSCLK),
        .cl_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSEXIT),
        .core_clk_in(dphy_clk_200M),
        .dl0_enable(mipi_dphy_0_tx_mipi_ppi_if_DL0_ENABLE),
        .dl0_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL0_FORCETXSTOPMODE),
        .dl0_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXDATAHS),
        .dl0_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREADYHS),
        .dl0_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTESC),
        .dl0_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTHS),
        .dl0_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSESC),
        .dl0_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSEXIT),
        .dl0_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL0_ULPSACTIVENOT),
        .dl1_enable(mipi_dphy_0_tx_mipi_ppi_if_DL1_ENABLE),
        .dl1_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL1_FORCETXSTOPMODE),
        .dl1_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXDATAHS),
        .dl1_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREADYHS),
        .dl1_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTESC),
        .dl1_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTHS),
        .dl1_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSESC),
        .dl1_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSEXIT),
        .dl1_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL1_ULPSACTIVENOT),
        .dl2_enable(mipi_dphy_0_tx_mipi_ppi_if_DL2_ENABLE),
        .dl2_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL2_FORCETXSTOPMODE),
        .dl2_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXDATAHS),
        .dl2_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREADYHS),
        .dl2_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTESC),
        .dl2_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTHS),
        .dl2_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSESC),
        .dl2_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSEXIT),
        .dl2_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL2_ULPSACTIVENOT),
        .dl3_enable(mipi_dphy_0_tx_mipi_ppi_if_DL3_ENABLE),
        .dl3_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL3_FORCETXSTOPMODE),
        .dl3_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXDATAHS),
        .dl3_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREADYHS),
        .dl3_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTESC),
        .dl3_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTHS),
        .dl3_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSESC),
        .dl3_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSEXIT),
        .dl3_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL3_ULPSACTIVENOT),
        .dl_tx_stop_st(mipi_dphy_0_dl0_stopstate),
        .dphy_init_done(mipi_dphy_0_init_done),
        .interrupt(interrupt),
        .master_reset_4dphy(mipi_csi2_tx_ctrl_0_master_reset_4dphy),
        .s_axi_araddr(axi_crossbar_0_M00_AXI_ARADDR),
        .s_axi_arready(axi_crossbar_0_M00_AXI_ARREADY),
        .s_axi_arvalid(axi_crossbar_0_M00_AXI_ARVALID),
        .s_axi_awaddr(axi_crossbar_0_M00_AXI_AWADDR),
        .s_axi_awready(axi_crossbar_0_M00_AXI_AWREADY),
        .s_axi_awvalid(axi_crossbar_0_M00_AXI_AWVALID),
        .s_axi_bready(axi_crossbar_0_M00_AXI_BREADY),
        .s_axi_bresp(axi_crossbar_0_M00_AXI_BRESP),
        .s_axi_bvalid(axi_crossbar_0_M00_AXI_BVALID),
        .s_axi_rdata(axi_crossbar_0_M00_AXI_RDATA),
        .s_axi_rready(axi_crossbar_0_M00_AXI_RREADY),
        .s_axi_rresp(axi_crossbar_0_M00_AXI_RRESP),
        .s_axi_rvalid(axi_crossbar_0_M00_AXI_RVALID),
        .s_axi_wdata(axi_crossbar_0_M00_AXI_WDATA),
        .s_axi_wready(axi_crossbar_0_M00_AXI_WREADY),
        .s_axi_wstrb(axi_crossbar_0_M00_AXI_WSTRB),
        .s_axi_wvalid(axi_crossbar_0_M00_AXI_WVALID),
        .s_axis_aclk(s_axis_aclk),
        .s_axis_aresetn(s_axis_aresetn),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tdest(s_axis_tdest),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tready(s_axis_tready),
        .s_axis_tuser(s_axis_tuser),
        .s_axis_tvalid(s_axis_tvalid),
        .txbyteclkhs(txbyteclkhs),
        .txclkesc(txclkesc_out));
  bd_26df_mipi_dphy_0_0 mipi_dphy_0
       (.cl_enable(mipi_dphy_0_tx_mipi_ppi_if_CL_ENABLE),
        .cl_tst_clk_out(cl_tst_clk_out),
        .cl_txclkactivehs(mipi_dphy_0_cl_txclkactivehs),
        .cl_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_CL_TXREQUESTHS),
        .cl_txulpsclk(mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSCLK),
        .cl_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_CL_TXULPSEXIT),
        .clk_hs_txn(mipi_phy_if_clk_hs_n),
        .clk_hs_txp(mipi_phy_if_clk_hs_p),
        .clk_lp_txn(mipi_phy_if_clk_lp_n),
        .clk_lp_txp(mipi_phy_if_clk_lp_p),
        .core_clk(dphy_clk_200M),
        .core_rst(mipi_csi2_tx_ctrl_0_master_reset_4dphy),
        .data_hs_txn(mipi_phy_if_data_hs_n),
        .data_hs_txp(mipi_phy_if_data_hs_p),
        .data_lp_txn(mipi_phy_if_data_lp_n),
        .data_lp_txp(mipi_phy_if_data_lp_p),
        .dl0_enable(mipi_dphy_0_tx_mipi_ppi_if_DL0_ENABLE),
        .dl0_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL0_FORCETXSTOPMODE),
        .dl0_stopstate(mipi_dphy_0_dl0_stopstate),
        .dl0_txdataesc({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dl0_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXDATAHS),
        .dl0_txlpdtesc(1'b0),
        .dl0_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREADYHS),
        .dl0_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTESC),
        .dl0_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXREQUESTHS),
        .dl0_txtriggeresc({1'b0,1'b0,1'b0,1'b0}),
        .dl0_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSESC),
        .dl0_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL0_TXULPSEXIT),
        .dl0_txvalidesc(1'b0),
        .dl0_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL0_ULPSACTIVENOT),
        .dl1_enable(mipi_dphy_0_tx_mipi_ppi_if_DL1_ENABLE),
        .dl1_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL1_FORCETXSTOPMODE),
        .dl1_txdataesc({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dl1_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXDATAHS),
        .dl1_txlpdtesc(1'b0),
        .dl1_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREADYHS),
        .dl1_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTESC),
        .dl1_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXREQUESTHS),
        .dl1_txtriggeresc({1'b0,1'b0,1'b0,1'b0}),
        .dl1_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSESC),
        .dl1_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL1_TXULPSEXIT),
        .dl1_txvalidesc(1'b0),
        .dl1_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL1_ULPSACTIVENOT),
        .dl2_enable(mipi_dphy_0_tx_mipi_ppi_if_DL2_ENABLE),
        .dl2_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL2_FORCETXSTOPMODE),
        .dl2_txdataesc({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dl2_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXDATAHS),
        .dl2_txlpdtesc(1'b0),
        .dl2_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREADYHS),
        .dl2_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTESC),
        .dl2_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXREQUESTHS),
        .dl2_txtriggeresc({1'b0,1'b0,1'b0,1'b0}),
        .dl2_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSESC),
        .dl2_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL2_TXULPSEXIT),
        .dl2_txvalidesc(1'b0),
        .dl2_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL2_ULPSACTIVENOT),
        .dl3_enable(mipi_dphy_0_tx_mipi_ppi_if_DL3_ENABLE),
        .dl3_forcetxstopmode(mipi_dphy_0_tx_mipi_ppi_if_DL3_FORCETXSTOPMODE),
        .dl3_txdataesc({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dl3_txdatahs(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXDATAHS),
        .dl3_txlpdtesc(1'b0),
        .dl3_txreadyhs(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREADYHS),
        .dl3_txrequestesc(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTESC),
        .dl3_txrequesths(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXREQUESTHS),
        .dl3_txtriggeresc({1'b0,1'b0,1'b0,1'b0}),
        .dl3_txulpsesc(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSESC),
        .dl3_txulpsexit(mipi_dphy_0_tx_mipi_ppi_if_DL3_TXULPSEXIT),
        .dl3_txvalidesc(1'b0),
        .dl3_ulpsactivenot(mipi_dphy_0_tx_mipi_ppi_if_DL3_ULPSACTIVENOT),
        .dl_tst_clk_out(dl_tst_clk_out),
        .init_done(mipi_dphy_0_init_done),
        .mmcm_lock_out(mmcm_lock_out),
        .oserdes_clk90_out(oserdes_clk90_out),
        .oserdes_clk_out(oserdes_clk_out),
        .oserdes_clkdiv_out(oserdes_clkdiv_out),
        .s_axi_aclk(s_axis_aclk),
        .s_axi_araddr(axi_crossbar_0_M01_AXI_ARADDR),
        .s_axi_aresetn(s_axis_aresetn),
        .s_axi_arready(axi_crossbar_0_M01_AXI_ARREADY),
        .s_axi_arvalid(axi_crossbar_0_M01_AXI_ARVALID),
        .s_axi_awaddr(axi_crossbar_0_M01_AXI_AWADDR),
        .s_axi_awready(axi_crossbar_0_M01_AXI_AWREADY),
        .s_axi_awvalid(axi_crossbar_0_M01_AXI_AWVALID),
        .s_axi_bready(axi_crossbar_0_M01_AXI_BREADY),
        .s_axi_bresp(axi_crossbar_0_M01_AXI_BRESP),
        .s_axi_bvalid(axi_crossbar_0_M01_AXI_BVALID),
        .s_axi_rdata(axi_crossbar_0_M01_AXI_RDATA),
        .s_axi_rready(axi_crossbar_0_M01_AXI_RREADY),
        .s_axi_rresp(axi_crossbar_0_M01_AXI_RRESP),
        .s_axi_rvalid(axi_crossbar_0_M01_AXI_RVALID),
        .s_axi_wdata(axi_crossbar_0_M01_AXI_WDATA),
        .s_axi_wready(axi_crossbar_0_M01_AXI_WREADY),
        .s_axi_wstrb(axi_crossbar_0_M01_AXI_WSTRB),
        .s_axi_wvalid(axi_crossbar_0_M01_AXI_WVALID),
        .system_rst_out(system_rst_out),
        .txbyteclkhs(txbyteclkhs),
        .txclkesc_out(txclkesc_out));
endmodule
