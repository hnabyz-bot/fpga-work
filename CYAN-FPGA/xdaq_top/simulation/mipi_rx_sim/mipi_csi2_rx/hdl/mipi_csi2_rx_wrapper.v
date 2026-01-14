//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2.2 (win64) Build 6060944 Thu Mar 06 19:10:01 MST 2025
//Date        : Mon Jun  2 13:26:57 2025
//Host        : WS-DRAKE running 64-bit major release  (build 9200)
//Command     : generate_target mipi_csi2_rx_wrapper.bd
//Design      : mipi_csi2_rx_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mipi_csi2_rx_wrapper
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
  input clk_100MHz;
  output done;
  output done_1;
  input mipi_phy_if_0_clk_hs_n;
  input mipi_phy_if_0_clk_hs_p;
  input mipi_phy_if_0_clk_lp_n;
  input mipi_phy_if_0_clk_lp_p;
  input [3:0]mipi_phy_if_0_data_hs_n;
  input [3:0]mipi_phy_if_0_data_hs_p;
  input [3:0]mipi_phy_if_0_data_lp_n;
  input [3:0]mipi_phy_if_0_data_lp_p;
  input reset_rtl_0;
  output rxbyteclkhs;
  output [31:0]status;
  output [31:0]status_1;
  output [31:0]video_out_tdata;
  output [9:0]video_out_tdest;
  output video_out_tlast;
  output [0:0]video_out_tuser_0;
  output video_out_tvalid;

  wire clk_100MHz;
  wire done;
  wire done_1;
  wire mipi_phy_if_0_clk_hs_n;
  wire mipi_phy_if_0_clk_hs_p;
  wire mipi_phy_if_0_clk_lp_n;
  wire mipi_phy_if_0_clk_lp_p;
  wire [3:0]mipi_phy_if_0_data_hs_n;
  wire [3:0]mipi_phy_if_0_data_hs_p;
  wire [3:0]mipi_phy_if_0_data_lp_n;
  wire [3:0]mipi_phy_if_0_data_lp_p;
  wire reset_rtl_0;
  wire rxbyteclkhs;
  wire [31:0]status;
  wire [31:0]status_1;
  wire [31:0]video_out_tdata;
  wire [9:0]video_out_tdest;
  wire video_out_tlast;
  wire [0:0]video_out_tuser_0;
  wire video_out_tvalid;

  mipi_csi2_rx mipi_csi2_rx_i
       (.clk_100MHz(clk_100MHz),
        .done(done),
        .done_1(done_1),
        .mipi_phy_if_0_clk_hs_n(mipi_phy_if_0_clk_hs_n),
        .mipi_phy_if_0_clk_hs_p(mipi_phy_if_0_clk_hs_p),
        .mipi_phy_if_0_clk_lp_n(mipi_phy_if_0_clk_lp_n),
        .mipi_phy_if_0_clk_lp_p(mipi_phy_if_0_clk_lp_p),
        .mipi_phy_if_0_data_hs_n(mipi_phy_if_0_data_hs_n),
        .mipi_phy_if_0_data_hs_p(mipi_phy_if_0_data_hs_p),
        .mipi_phy_if_0_data_lp_n(mipi_phy_if_0_data_lp_n),
        .mipi_phy_if_0_data_lp_p(mipi_phy_if_0_data_lp_p),
        .reset_rtl_0(reset_rtl_0),
        .rxbyteclkhs(rxbyteclkhs),
        .status(status),
        .status_1(status_1),
        .video_out_tdata(video_out_tdata),
        .video_out_tdest(video_out_tdest),
        .video_out_tlast(video_out_tlast),
        .video_out_tuser_0(video_out_tuser_0),
        .video_out_tvalid(video_out_tvalid));
endmodule
