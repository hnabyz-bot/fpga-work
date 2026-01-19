-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
-- Date        : Fri Jan 16 15:13:26 2026
-- Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top mipi_csi2_tx_subsys -prefix
--               mipi_csi2_tx_subsys_ mipi_csi2_tx_subsys_stub.vhdl
-- Design      : mipi_csi2_tx_subsys
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mipi_csi2_tx_subsys is
  Port ( 
    s_axis_aclk : in STD_LOGIC;
    s_axis_aresetn : in STD_LOGIC;
    dphy_clk_200M : in STD_LOGIC;
    txclkesc_out : out STD_LOGIC;
    oserdes_clk_out : out STD_LOGIC;
    oserdes_clk90_out : out STD_LOGIC;
    txbyteclkhs : out STD_LOGIC;
    oserdes_clkdiv_out : out STD_LOGIC;
    system_rst_out : out STD_LOGIC;
    mmcm_lock_out : out STD_LOGIC;
    cl_tst_clk_out : out STD_LOGIC;
    dl_tst_clk_out : out STD_LOGIC;
    interrupt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tuser : in STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axis_tvalid : in STD_LOGIC;
    mipi_phy_if_clk_hs_n : out STD_LOGIC;
    mipi_phy_if_clk_hs_p : out STD_LOGIC;
    mipi_phy_if_clk_lp_n : out STD_LOGIC;
    mipi_phy_if_clk_lp_p : out STD_LOGIC;
    mipi_phy_if_data_hs_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mipi_phy_if_data_hs_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mipi_phy_if_data_lp_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mipi_phy_if_data_lp_p : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of mipi_csi2_tx_subsys : entity is "mipi_csi2_tx_subsys,bd_26df,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of mipi_csi2_tx_subsys : entity is "mipi_csi2_tx_subsys,bd_26df,{x_ipProduct=Vivado 2024.2.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mipi_csi2_tx_subsystem,x_ipVersion=2.2,x_ipCoreRevision=15,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_OOC_VID_CLK=6.666,C_EN_CTS_TX=false,C_EN_DBG_TX=false,DPHY_PRESET=None,C_EN_SSC=false,C_CSI_MAX_BPC=8,C_CSI_XMIT_INITIAL_DESKEW=false,C_CSI_XMIT_PERIODIC_DESKEW=false,C_CSI_XMIT_ALT_DESKEW_SEQ=false,C_CSI_INIT_DESKEW_PATRN_LEN=4096,C_CSI_PERIODIC_PATRN_LEN=1024,C_CSI_PERIODIC_CNTR_WIDTH=32,C_CSI_PERIODIC_TIME=5000,C_CLK_IO_SWAP=false,C_DL0_IO_SWAP=false,C_DL1_IO_SWAP=false,C_DL2_IO_SWAP=false,C_DL3_IO_SWAP=false,C_CLK_LP_IO_SWAP=false,C_DL0_LP_IO_SWAP=false,C_DL1_LP_IO_SWAP=false,C_DL2_LP_IO_SWAP=false,C_DL3_LP_IO_SWAP=false,C_EN_DEBUG_REGS=false,C_CSI_CLK_PRE=1,C_CSI_LANES=4,C_EN_7S_LINERATE_CHECK=false,C_EXDES_CONFIG=1Lane_RGB888_1Pixel_Mode,C_EN_REG_BASED_FE_GEN=false,C_DPHY_LANES=4,C_CSI_DATATYPE=RAW8,C_CSI_PIXEL_MODE=2,C_CSI_AXIS_TDATA_WIDTH=48,C_CSI_LINE_BUFR_DEPTH=8192,C_CSI_VID_INTERFACE=AXI4S,C_CSI_CRC_ENABLE=true,C_CSI_EN_ACTIVELANES=false,C_STRETCH_LINE_RATE=2500,C_HS_LINE_RATE=400,C_DPHY_MODE=MASTER,DPHY_LPX_PERIOD=50,DPHY_ESC_CLK_PERIOD=20.000,DPHY_HS_TIMEOUT=65541,DPHY_ESC_TIMEOUT=25600,C_DPHY_EN_REG_IF=true,Component_Name=mipi_csi2_tx_subsys,HP_IO_BANK_SELECTION=46,CLK_LANE_IO_LOC=None,DATA_LANE0_IO_LOC=None,DATA_LANE1_IO_LOC=None,DATA_LANE2_IO_LOC=None,DATA_LANE3_IO_LOC=None,DATA_LANE0_BYTE=Same_Byte,DATA_LANE1_BYTE=Same_Byte,DATA_LANE2_BYTE=Same_Byte,DATA_LANE3_BYTE=Same_Byte,CLK_LANE_IO_LOC_NAME=None,DATA_LANE0_IO_LOC_NAME=None,DATA_LANE1_IO_LOC_NAME=None,DATA_LANE2_IO_LOC_NAME=None,DATA_LANE3_IO_LOC_NAME=None,SupportLevel=1,C_CLK_LANE_IO_POSITION=0,C_DATA_LANE0_IO_POSITION=2,C_DATA_LANE1_IO_POSITION=4,C_DATA_LANE2_IO_POSITION=6,C_DATA_LANE3_IO_POSITION=8,CMN_PROJ_FAMILY=0,C_IS_7SERIES=true,C_IS_VERSAL=false,C_EN_HS_OBUFTDS=true,C_INC_PHY=true}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of mipi_csi2_tx_subsys : entity is "yes";
end mipi_csi2_tx_subsys;

architecture stub of mipi_csi2_tx_subsys is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "s_axis_aclk,s_axis_aresetn,dphy_clk_200M,txclkesc_out,oserdes_clk_out,oserdes_clk90_out,txbyteclkhs,oserdes_clkdiv_out,system_rst_out,mmcm_lock_out,cl_tst_clk_out,dl_tst_clk_out,interrupt,s_axi_awaddr[12:0],s_axi_awprot[2:0],s_axi_awvalid[0:0],s_axi_awready[0:0],s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid[0:0],s_axi_wready[0:0],s_axi_bresp[1:0],s_axi_bvalid[0:0],s_axi_bready[0:0],s_axi_araddr[12:0],s_axi_arprot[2:0],s_axi_arvalid[0:0],s_axi_arready[0:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid[0:0],s_axi_rready[0:0],s_axis_tdata[47:0],s_axis_tdest[1:0],s_axis_tkeep[5:0],s_axis_tlast,s_axis_tready,s_axis_tuser[95:0],s_axis_tvalid,mipi_phy_if_clk_hs_n,mipi_phy_if_clk_hs_p,mipi_phy_if_clk_lp_n,mipi_phy_if_clk_lp_p,mipi_phy_if_data_hs_n[3:0],mipi_phy_if_data_hs_p[3:0],mipi_phy_if_data_lp_n[3:0],mipi_phy_if_data_lp_p[3:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s_axis_aclk : signal is "xilinx.com:signal:clock:1.0 CLK.s_axis_aclk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of s_axis_aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s_axis_aclk : signal is "XIL_INTERFACENAME CLK.s_axis_aclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, ASSOCIATED_BUSIF s_axi:s_axis, ASSOCIATED_RESET s_axis_aresetn, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 RST.s_axis_aresetn RST";
  attribute X_INTERFACE_MODE of s_axis_aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axis_aresetn : signal is "XIL_INTERFACENAME RST.s_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0, TYPE INTERCONNECT";
  attribute X_INTERFACE_INFO of dphy_clk_200M : signal is "xilinx.com:signal:clock:1.0 CLK.dphy_clk_200M CLK";
  attribute X_INTERFACE_MODE of dphy_clk_200M : signal is "slave";
  attribute X_INTERFACE_PARAMETER of dphy_clk_200M : signal is "XIL_INTERFACENAME CLK.dphy_clk_200M, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_dphy_clk_200M, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of txclkesc_out : signal is "xilinx.com:signal:clock:1.0 CLK.txclkesc_out CLK";
  attribute X_INTERFACE_MODE of txclkesc_out : signal is "master";
  attribute X_INTERFACE_PARAMETER of txclkesc_out : signal is "XIL_INTERFACENAME CLK.txclkesc_out, FREQ_HZ 10000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txclkesc_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of oserdes_clk_out : signal is "xilinx.com:signal:clock:1.0 CLK.oserdes_clk_out CLK";
  attribute X_INTERFACE_MODE of oserdes_clk_out : signal is "master";
  attribute X_INTERFACE_PARAMETER of oserdes_clk_out : signal is "XIL_INTERFACENAME CLK.oserdes_clk_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of oserdes_clk90_out : signal is "xilinx.com:signal:clock:1.0 CLK.oserdes_clk90_out CLK";
  attribute X_INTERFACE_MODE of oserdes_clk90_out : signal is "master";
  attribute X_INTERFACE_PARAMETER of oserdes_clk90_out : signal is "XIL_INTERFACENAME CLK.oserdes_clk90_out, FREQ_HZ 400000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clk90_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of txbyteclkhs : signal is "xilinx.com:signal:clock:1.0 CLK.txbyteclkhs CLK";
  attribute X_INTERFACE_MODE of txbyteclkhs : signal is "master";
  attribute X_INTERFACE_PARAMETER of txbyteclkhs : signal is "XIL_INTERFACENAME CLK.txbyteclkhs, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_txbyteclkhs, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of oserdes_clkdiv_out : signal is "xilinx.com:signal:clock:1.0 CLK.oserdes_clkdiv_out CLK";
  attribute X_INTERFACE_MODE of oserdes_clkdiv_out : signal is "master";
  attribute X_INTERFACE_PARAMETER of oserdes_clkdiv_out : signal is "XIL_INTERFACENAME CLK.oserdes_clkdiv_out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_26df_mipi_dphy_0_0_oserdes_clkdiv_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of interrupt : signal is "xilinx.com:signal:interrupt:1.0 INTR.interrupt INTERRUPT";
  attribute X_INTERFACE_MODE of interrupt : signal is "master";
  attribute X_INTERFACE_PARAMETER of interrupt : signal is "XIL_INTERFACENAME INTR.interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_MODE of s_axi_awaddr : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axi_awaddr : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 13, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 s_axi AWPROT";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 s_axi ARPROT";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_INFO of s_axis_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis TDATA";
  attribute X_INTERFACE_MODE of s_axis_tdata : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axis_tdata : signal is "XIL_INTERFACENAME s_axis, TDATA_NUM_BYTES 6, TDEST_WIDTH 2, TID_WIDTH 0, TUSER_WIDTH 96, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tdest : signal is "xilinx.com:interface:axis:1.0 s_axis TDEST";
  attribute X_INTERFACE_INFO of s_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 s_axis TKEEP";
  attribute X_INTERFACE_INFO of s_axis_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis TLAST";
  attribute X_INTERFACE_INFO of s_axis_tready : signal is "xilinx.com:interface:axis:1.0 s_axis TREADY";
  attribute X_INTERFACE_INFO of s_axis_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis TUSER";
  attribute X_INTERFACE_INFO of s_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis TVALID";
  attribute X_INTERFACE_INFO of mipi_phy_if_clk_hs_n : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_N";
  attribute X_INTERFACE_MODE of mipi_phy_if_clk_hs_n : signal is "master";
  attribute X_INTERFACE_INFO of mipi_phy_if_clk_hs_p : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_HS_P";
  attribute X_INTERFACE_INFO of mipi_phy_if_clk_lp_n : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_N";
  attribute X_INTERFACE_INFO of mipi_phy_if_clk_lp_p : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if CLK_LP_P";
  attribute X_INTERFACE_INFO of mipi_phy_if_data_hs_n : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_N";
  attribute X_INTERFACE_INFO of mipi_phy_if_data_hs_p : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_HS_P";
  attribute X_INTERFACE_INFO of mipi_phy_if_data_lp_n : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_N";
  attribute X_INTERFACE_INFO of mipi_phy_if_data_lp_p : signal is "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if DATA_LP_P";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "bd_26df,Vivado 2024.2.2";
begin
end;
