// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module mipi_csi2_rx (
  mipi_phy_if_0_clk_hs_n,
  mipi_phy_if_0_clk_hs_p,
  mipi_phy_if_0_clk_lp_n,
  mipi_phy_if_0_clk_lp_p,
  mipi_phy_if_0_data_hs_n,
  mipi_phy_if_0_data_hs_p,
  mipi_phy_if_0_data_lp_n,
  mipi_phy_if_0_data_lp_p,
  clk_100MHz,
  done,
  done_1,
  reset_rtl_0,
  rxbyteclkhs,
  status,
  status_1,
  video_out_tdata,
  video_out_tdest,
  video_out_tlast,
  video_out_tvalid,
  video_out_tuser_0
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_HS_N" *)
  (* X_INTERFACE_MODE = "slave mipi_phy_if_0" *)
  input mipi_phy_if_0_clk_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_HS_P" *)
  input mipi_phy_if_0_clk_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_LP_N" *)
  input mipi_phy_if_0_clk_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 CLK_LP_P" *)
  input mipi_phy_if_0_clk_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_HS_N" *)
  input [3:0]mipi_phy_if_0_data_hs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_HS_P" *)
  input [3:0]mipi_phy_if_0_data_hs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_LP_N" *)
  input [3:0]mipi_phy_if_0_data_lp_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mipi_phy:1.0 mipi_phy_if_0 DATA_LP_P" *)
  input [3:0]mipi_phy_if_0_data_lp_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_100MHZ CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.CLK_100MHZ" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_100MHZ, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN mipi_csi2_rx_clk_100MHz, INSERT_VIP 0" *)
  input clk_100MHz;
  (* X_INTERFACE_IGNORE = "true" *)
  output done;
  (* X_INTERFACE_IGNORE = "true" *)
  output done_1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_RTL_0 RST" *)
  (* X_INTERFACE_MODE = "slave RST.RESET_RTL_0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_RTL_0, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input reset_rtl_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.RXBYTECLKHS CLK" *)
  (* X_INTERFACE_MODE = "master CLK.RXBYTECLKHS" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.RXBYTECLKHS, FREQ_HZ 50000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_62e9_phy_0_rxbyteclkhs, INSERT_VIP 0" *)
  output rxbyteclkhs;
  (* X_INTERFACE_IGNORE = "true" *)
  output [31:0]status;
  (* X_INTERFACE_IGNORE = "true" *)
  output [31:0]status_1;
  (* X_INTERFACE_IGNORE = "true" *)
  output [31:0]video_out_tdata;
  (* X_INTERFACE_IGNORE = "true" *)
  output [9:0]video_out_tdest;
  (* X_INTERFACE_IGNORE = "true" *)
  output video_out_tlast;
  (* X_INTERFACE_IGNORE = "true" *)
  output video_out_tvalid;
  (* X_INTERFACE_IGNORE = "true" *)
  output [0:0]video_out_tuser_0;

  // stub module has no contents

endmodule
