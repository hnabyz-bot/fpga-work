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

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
mipi_csi2_tx_subsys your_instance_name (
  .s_axis_aclk(s_axis_aclk),                      // input wire s_axis_aclk
  .s_axis_aresetn(s_axis_aresetn),                // input wire s_axis_aresetn
  .dphy_clk_200M(dphy_clk_200M),                  // input wire dphy_clk_200M
  .txclkesc_out(txclkesc_out),                    // output wire txclkesc_out
  .oserdes_clk_out(oserdes_clk_out),              // output wire oserdes_clk_out
  .oserdes_clk90_out(oserdes_clk90_out),          // output wire oserdes_clk90_out
  .txbyteclkhs(txbyteclkhs),                      // output wire txbyteclkhs
  .oserdes_clkdiv_out(oserdes_clkdiv_out),        // output wire oserdes_clkdiv_out
  .system_rst_out(system_rst_out),                // output wire system_rst_out
  .mmcm_lock_out(mmcm_lock_out),                  // output wire mmcm_lock_out
  .cl_tst_clk_out(cl_tst_clk_out),                // output wire cl_tst_clk_out
  .dl_tst_clk_out(dl_tst_clk_out),                // output wire dl_tst_clk_out
  .interrupt(interrupt),                          // output wire interrupt
  .s_axi_awaddr(s_axi_awaddr),                    // input wire [16 : 0] s_axi_awaddr
  .s_axi_awprot(s_axi_awprot),                    // input wire [2 : 0] s_axi_awprot
  .s_axi_awvalid(s_axi_awvalid),                  // input wire [0 : 0] s_axi_awvalid
  .s_axi_awready(s_axi_awready),                  // output wire [0 : 0] s_axi_awready
  .s_axi_wdata(s_axi_wdata),                      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(s_axi_wstrb),                      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(s_axi_wvalid),                    // input wire [0 : 0] s_axi_wvalid
  .s_axi_wready(s_axi_wready),                    // output wire [0 : 0] s_axi_wready
  .s_axi_bresp(s_axi_bresp),                      // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid(s_axi_bvalid),                    // output wire [0 : 0] s_axi_bvalid
  .s_axi_bready(s_axi_bready),                    // input wire [0 : 0] s_axi_bready
  .s_axi_araddr(s_axi_araddr),                    // input wire [16 : 0] s_axi_araddr
  .s_axi_arprot(s_axi_arprot),                    // input wire [2 : 0] s_axi_arprot
  .s_axi_arvalid(s_axi_arvalid),                  // input wire [0 : 0] s_axi_arvalid
  .s_axi_arready(s_axi_arready),                  // output wire [0 : 0] s_axi_arready
  .s_axi_rdata(s_axi_rdata),                      // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp(s_axi_rresp),                      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(s_axi_rvalid),                    // output wire [0 : 0] s_axi_rvalid
  .s_axi_rready(s_axi_rready),                    // input wire [0 : 0] s_axi_rready
  .s_axis_tdata(s_axis_tdata),                    // input wire [47 : 0] s_axis_tdata
  .s_axis_tdest(s_axis_tdest),                    // input wire [1 : 0] s_axis_tdest
  .s_axis_tkeep(s_axis_tkeep),                    // input wire [5 : 0] s_axis_tkeep
  .s_axis_tlast(s_axis_tlast),                    // input wire s_axis_tlast
  .s_axis_tready(s_axis_tready),                  // output wire s_axis_tready
  .s_axis_tuser(s_axis_tuser),                    // input wire [95 : 0] s_axis_tuser
  .s_axis_tvalid(s_axis_tvalid),                  // input wire s_axis_tvalid
  .mipi_phy_if_clk_hs_n(mipi_phy_if_clk_hs_n),    // output wire mipi_phy_if_clk_hs_n
  .mipi_phy_if_clk_hs_p(mipi_phy_if_clk_hs_p),    // output wire mipi_phy_if_clk_hs_p
  .mipi_phy_if_clk_lp_n(mipi_phy_if_clk_lp_n),    // output wire mipi_phy_if_clk_lp_n
  .mipi_phy_if_clk_lp_p(mipi_phy_if_clk_lp_p),    // output wire mipi_phy_if_clk_lp_p
  .mipi_phy_if_data_hs_n(mipi_phy_if_data_hs_n),  // output wire [3 : 0] mipi_phy_if_data_hs_n
  .mipi_phy_if_data_hs_p(mipi_phy_if_data_hs_p),  // output wire [3 : 0] mipi_phy_if_data_hs_p
  .mipi_phy_if_data_lp_n(mipi_phy_if_data_lp_n),  // output wire [3 : 0] mipi_phy_if_data_lp_n
  .mipi_phy_if_data_lp_p(mipi_phy_if_data_lp_p)  // output wire [3 : 0] mipi_phy_if_data_lp_p
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file mipi_csi2_tx_subsys.v when simulating
// the core, mipi_csi2_tx_subsys. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

