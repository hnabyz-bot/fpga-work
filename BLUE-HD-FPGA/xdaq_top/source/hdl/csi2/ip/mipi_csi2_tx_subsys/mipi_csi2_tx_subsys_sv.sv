// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
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

// MODULE VLNV: xilinx.com:ip:mipi_csi2_tx_subsystem:2.2

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module mipi_csi2_tx_subsys_sv (
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi" *)
  (* X_INTERFACE_MODE = "slave s_axi" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 17, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_axi4_lite_v1_0.slave s_axi,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis" *)
  (* X_INTERFACE_MODE = "slave s_axis" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis, TDATA_NUM_BYTES 6, TDEST_WIDTH 2, TID_WIDTH 0, TUSER_WIDTH 96, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN bd_26df_s_axis_aclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
  vivado_axis_v1_0.slave s_axis,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire s_axis_aclk,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire s_axis_aresetn,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire dphy_clk_200M,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire txclkesc_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire oserdes_clk_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire oserdes_clk90_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire txbyteclkhs,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire oserdes_clkdiv_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire system_rst_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire mmcm_lock_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire cl_tst_clk_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire dl_tst_clk_out,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire interrupt,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire mipi_phy_if_clk_hs_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire mipi_phy_if_clk_hs_p,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire mipi_phy_if_clk_lp_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire mipi_phy_if_clk_lp_p,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] mipi_phy_if_data_hs_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] mipi_phy_if_data_hs_p,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] mipi_phy_if_data_lp_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] mipi_phy_if_data_lp_p
);

  mipi_csi2_tx_subsys inst (
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
    .s_axi_awaddr(s_axi.AWADDR),
    .s_axi_awprot(s_axi.AWPROT),
    .s_axi_awvalid(s_axi.AWVALID),
    .s_axi_awready(s_axi.AWREADY),
    .s_axi_wdata(s_axi.WDATA),
    .s_axi_wstrb(s_axi.WSTRB),
    .s_axi_wvalid(s_axi.WVALID),
    .s_axi_wready(s_axi.WREADY),
    .s_axi_bresp(s_axi.BRESP),
    .s_axi_bvalid(s_axi.BVALID),
    .s_axi_bready(s_axi.BREADY),
    .s_axi_araddr(s_axi.ARADDR),
    .s_axi_arprot(s_axi.ARPROT),
    .s_axi_arvalid(s_axi.ARVALID),
    .s_axi_arready(s_axi.ARREADY),
    .s_axi_rdata(s_axi.RDATA),
    .s_axi_rresp(s_axi.RRESP),
    .s_axi_rvalid(s_axi.RVALID),
    .s_axi_rready(s_axi.RREADY),
    .s_axis_tdata(s_axis.TDATA),
    .s_axis_tdest(s_axis.TDEST),
    .s_axis_tkeep(s_axis.TKEEP),
    .s_axis_tlast(s_axis.TLAST),
    .s_axis_tready(s_axis.TREADY),
    .s_axis_tuser(s_axis.TUSER),
    .s_axis_tvalid(s_axis.TVALID),
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
