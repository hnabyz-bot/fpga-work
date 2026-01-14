//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Tue Sep 19 16:55:00 2023
//Host        : DESKTOP-957T0T8 running 64-bit major release  (build 9200)
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
    video_out_tvalid);

  parameter mipi_lane = 4;

  input clk_100MHz;
  output done;
  output done_1;
  input mipi_phy_if_0_clk_hs_n;
  input mipi_phy_if_0_clk_hs_p;
  input mipi_phy_if_0_clk_lp_n;
  input mipi_phy_if_0_clk_lp_p;
  input [mipi_lane-1:0]mipi_phy_if_0_data_hs_n;
  input [mipi_lane-1:0]mipi_phy_if_0_data_hs_p;
  input [mipi_lane-1:0]mipi_phy_if_0_data_lp_n;
  input [mipi_lane-1:0]mipi_phy_if_0_data_lp_p;
  input reset_rtl_0;
  output rxbyteclkhs;
  output [31:0]status;
  output [31:0]status_1;
  output [(32)-1:0]video_out_tdata;
//  output [(24*mipi_lane)-1:0]video_out_tdata;
  output [9:0]video_out_tdest;
  output video_out_tlast;
  output video_out_tvalid;

  wire clk_100MHz;
  wire done;
  wire done_1;
  wire mipi_phy_if_0_clk_hs_n;
  wire mipi_phy_if_0_clk_hs_p;
  wire mipi_phy_if_0_clk_lp_n;
  wire mipi_phy_if_0_clk_lp_p;
  wire [mipi_lane-1:0]mipi_phy_if_0_data_hs_n;
  wire [mipi_lane-1:0]mipi_phy_if_0_data_hs_p;
  wire [mipi_lane-1:0]mipi_phy_if_0_data_lp_n;
  wire [mipi_lane-1:0]mipi_phy_if_0_data_lp_p;
  wire reset_rtl_0;
  wire rxbyteclkhs;
  wire [31:0]status;
  wire [31:0]status_1;
  wire [(32)-1:0]video_out_tdata;
//  wire [(64)-1:0]video_out_tdata;
  wire [9:0]video_out_tdest;
  wire video_out_tlast;
  wire video_out_tvalid;
  wire [15:0]video_out_0;
  wire [15:0]video_out_1;
  wire [15:0]video_out_2;
  wire [15:0]video_out_3;
  wire video_frame_start;
  wire [0:0] video_out_tuser_0;

  wire [15:0]RGB565_0;
  wire [15:0]RGB565_1;
  wire [15:0]RGB565_2;
  wire [15:0]RGB565_3;

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
        .video_out_tuser_0(video_out_tuser_0),
        .status_1(status_1),
        .video_out_tdata(video_out_tdata),
        .video_out_tdest(video_out_tdest),
        .video_out_tlast(video_out_tlast),
        .video_out_tvalid(video_out_tvalid));

  assign video_out_0 = video_out_tdata[15:0];
  assign video_out_1 = video_out_tdata[31:16];
//  assign video_out_2 = video_out_tdata[47:32];
//  assign video_out_3 = video_out_tdata[63:48];
  
  assign RGB565_0 = ({video_out_0[15:11],video_out_0[5:0],video_out_0[10:6]});
  assign RGB565_1 = ({video_out_1[15:11],video_out_1[5:0],video_out_1[10:6]});
//  assign RGB565_2 = ({video_out_2[15:11],video_out_2[5:0],video_out_2[10:6]});
//  assign RGB565_3 = ({video_out_3[15:11],video_out_3[5:0],video_out_3[10:6]});
  
  assign video_frame_start = video_out_tuser_0;

endmodule
