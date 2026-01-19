// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
// Date        : Fri Jan 16 15:13:49 2026
// Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top mipi_init_gen -prefix
//               mipi_init_gen_ mipi_init_gen_sim_netlist.v
// Design      : mipi_init_gen
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* dont_touch = "true" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff
   (data,
    clk,
    reset,
    q);
  input data;
  input clk;
  input reset;
  (* INIT = "0" *) (* async_reg = "true" *) output q;

  wire clk;
  wire data;
  (* INIT = "0" *) (* async_reg = "true" *) wire q;
  wire reset;

  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE #(
    .INIT(1'b0)) 
    q_reg
       (.C(clk),
        .CE(1'b1),
        .D(data),
        .PRE(reset),
        .Q(q));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_asynch_rst_ff" *) (* dont_touch = "true" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__1
   (data,
    clk,
    reset,
    q);
  input data;
  input clk;
  input reset;
  (* INIT = "0" *) (* async_reg = "true" *) output q;

  wire clk;
  wire data;
  (* INIT = "0" *) (* async_reg = "true" *) wire q;
  wire reset;

  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE #(
    .INIT(1'b0)) 
    q_reg
       (.C(clk),
        .CE(1'b1),
        .D(data),
        .PRE(reset),
        .Q(q));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_asynch_rst_ff" *) (* dont_touch = "true" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__2
   (data,
    clk,
    reset,
    q);
  input data;
  input clk;
  input reset;
  (* INIT = "0" *) (* async_reg = "true" *) output q;

  wire clk;
  wire data;
  (* INIT = "0" *) (* async_reg = "true" *) wire q;
  wire reset;

  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE #(
    .INIT(1'b0)) 
    q_reg
       (.C(clk),
        .CE(1'b1),
        .D(data),
        .PRE(reset),
        .Q(q));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_asynch_rst_ff" *) (* dont_touch = "true" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__3
   (data,
    clk,
    reset,
    q);
  input data;
  input clk;
  input reset;
  (* INIT = "0" *) (* async_reg = "true" *) output q;

  wire clk;
  wire data;
  (* INIT = "0" *) (* async_reg = "true" *) wire q;
  wire reset;

  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE #(
    .INIT(1'b0)) 
    q_reg
       (.C(clk),
        .CE(1'b1),
        .D(data),
        .PRE(reset),
        .Q(q));
endmodule

module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg
   (douta,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ,
    DI,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ,
    \m_axi_lite_ch1_rdata[9] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ,
    \m_axi_lite_ch1_rdata[21] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ,
    S,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ,
    \m_axi_lite_ch1_rdata[27] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ,
    addra,
    rd_check1_carry__2_i_1,
    m_axi_lite_ch1_rdata,
    rom_eof0,
    \rd_check2_inferred__0/i__carry__1 );
  output [31:0]douta;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ;
  output [0:0]DI;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ;
  output [0:0]\m_axi_lite_ch1_rdata[9] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ;
  output [0:0]\m_axi_lite_ch1_rdata[21] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ;
  output [0:0]S;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ;
  output [0:0]\m_axi_lite_ch1_rdata[27] ;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  input [7:0]addra;
  input [16:0]rd_check1_carry__2_i_1;
  input [16:0]m_axi_lite_ch1_rdata;
  input rom_eof0;
  input \rd_check2_inferred__0/i__carry__1 ;

  wire [0:0]DI;
  wire [0:0]S;
  wire [7:0]addra;
  wire [31:0]douta;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ;
  wire [16:0]m_axi_lite_ch1_rdata;
  wire [0:0]\m_axi_lite_ch1_rdata[21] ;
  wire [0:0]\m_axi_lite_ch1_rdata[27] ;
  wire [0:0]\m_axi_lite_ch1_rdata[9] ;
  wire [16:0]rd_check1_carry__2_i_1;
  wire \rd_check2_inferred__0/i__carry__1 ;
  wire rom_eof0;
  wire s_axi_aclk;

  mipi_init_gen_xpm_memory_spram xpm_memory_spram_inst
       (.DI(DI),
        .S(S),
        .addra(addra),
        .douta(douta),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata),
        .\m_axi_lite_ch1_rdata[21] (\m_axi_lite_ch1_rdata[21] ),
        .\m_axi_lite_ch1_rdata[27] (\m_axi_lite_ch1_rdata[27] ),
        .\m_axi_lite_ch1_rdata[9] (\m_axi_lite_ch1_rdata[9] ),
        .rd_check1_carry__2_i_1(rd_check1_carry__2_i_1),
        .\rd_check2_inferred__0/i__carry__1 (\rd_check2_inferred__0/i__carry__1 ),
        .rom_eof0(rom_eof0),
        .s_axi_aclk(s_axi_aclk));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_systeminit_dmg" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized0
   (douta,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ,
    m_axi_lite_ch1_rresp_0_sp_1,
    D,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ,
    addra,
    CO,
    cur_trn_status_reg,
    m_axi_lite_ch1_rresp,
    cur_trn_status_reg_0,
    cur_trn_status_reg_1,
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] );
  output [1:0]douta;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  output m_axi_lite_ch1_rresp_0_sp_1;
  output [7:0]D;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ;
  input [7:0]addra;
  input [0:0]CO;
  input cur_trn_status_reg;
  input [0:0]m_axi_lite_ch1_rresp;
  input [0:0]cur_trn_status_reg_0;
  input [0:0]cur_trn_status_reg_1;
  input \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ;

  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ;
  wire [0:0]CO;
  wire [7:0]D;
  wire [7:0]addra;
  wire cur_trn_status_reg;
  wire [0:0]cur_trn_status_reg_0;
  wire [0:0]cur_trn_status_reg_1;
  wire [1:0]douta;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ;
  wire [0:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rresp_0_sn_1;
  wire s_axi_aclk;

  assign m_axi_lite_ch1_rresp_0_sp_1 = m_axi_lite_ch1_rresp_0_sn_1;
  mipi_init_gen_xpm_memory_spram__parameterized0 xpm_memory_spram_inst
       (.\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] (\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .CO(CO),
        .D(D),
        .addra(addra),
        .cur_trn_status_reg(cur_trn_status_reg),
        .cur_trn_status_reg_0(cur_trn_status_reg_0),
        .cur_trn_status_reg_1(cur_trn_status_reg_1),
        .douta(douta),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp),
        .m_axi_lite_ch1_rresp_0_sp_1(m_axi_lite_ch1_rresp_0_sn_1),
        .s_axi_aclk(s_axi_aclk));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_systeminit_dmg" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized1
   (douta,
    rom_eof0,
    rready_m_reg,
    s_axi_aresetn_0,
    b_complete,
    bready_m_reg,
    r_complete,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ,
    m_axi_lite_ch1_rdata_6_sp_1,
    m_axi_lite_ch1_rdata_2_sp_1,
    m_axi_lite_ch1_rdata_0_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ,
    \m_axi_lite_ch1_rdata[14] ,
    m_axi_lite_ch1_rdata_12_sp_1,
    m_axi_lite_ch1_rdata_8_sp_1,
    m_axi_lite_ch1_rdata_20_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ,
    m_axi_lite_ch1_rdata_18_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    \m_axi_lite_ch1_rdata[30] ,
    \m_axi_lite_ch1_rdata[26] ,
    \m_axi_lite_ch1_rdata[24] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ,
    \m_axi_lite_ch1_rdata[14]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ,
    addra,
    bready_m,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_bresp,
    cur_trn_status_reg,
    s_axi_aresetn,
    cur_trn_status_reg_0,
    cur_trn_status_reg_1,
    m_axi_lite_ch1_rresp,
    m_axi_lite_ch1_rvalid,
    rready_m,
    i__carry__1_i_1,
    i__carry__1_i_1_0,
    m_axi_lite_ch1_rdata,
    rd_check1_carry__0,
    rd_check1_carry__2);
  output [31:0]douta;
  output rom_eof0;
  output rready_m_reg;
  output s_axi_aresetn_0;
  output b_complete;
  output bready_m_reg;
  output r_complete;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ;
  output m_axi_lite_ch1_rdata_6_sp_1;
  output m_axi_lite_ch1_rdata_2_sp_1;
  output m_axi_lite_ch1_rdata_0_sp_1;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ;
  output [0:0]\m_axi_lite_ch1_rdata[14] ;
  output m_axi_lite_ch1_rdata_12_sp_1;
  output m_axi_lite_ch1_rdata_8_sp_1;
  output m_axi_lite_ch1_rdata_20_sp_1;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ;
  output m_axi_lite_ch1_rdata_18_sp_1;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  output [0:0]\m_axi_lite_ch1_rdata[30] ;
  output \m_axi_lite_ch1_rdata[26] ;
  output \m_axi_lite_ch1_rdata[24] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ;
  output [0:0]\m_axi_lite_ch1_rdata[14]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  input [7:0]addra;
  input bready_m;
  input m_axi_lite_ch1_bvalid;
  input [0:0]m_axi_lite_ch1_bresp;
  input [0:0]cur_trn_status_reg;
  input s_axi_aresetn;
  input cur_trn_status_reg_0;
  input cur_trn_status_reg_1;
  input [0:0]m_axi_lite_ch1_rresp;
  input m_axi_lite_ch1_rvalid;
  input rready_m;
  input [17:0]i__carry__1_i_1;
  input [21:0]i__carry__1_i_1_0;
  input [21:0]m_axi_lite_ch1_rdata;
  input rd_check1_carry__0;
  input rd_check1_carry__2;

  wire [7:0]addra;
  wire b_complete;
  wire bready_m;
  wire bready_m_reg;
  wire [0:0]cur_trn_status_reg;
  wire cur_trn_status_reg_0;
  wire cur_trn_status_reg_1;
  wire [31:0]douta;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ;
  wire [17:0]i__carry__1_i_1;
  wire [21:0]i__carry__1_i_1_0;
  wire [0:0]m_axi_lite_ch1_bresp;
  wire m_axi_lite_ch1_bvalid;
  wire [21:0]m_axi_lite_ch1_rdata;
  wire [0:0]\m_axi_lite_ch1_rdata[14] ;
  wire [0:0]\m_axi_lite_ch1_rdata[14]_0 ;
  wire \m_axi_lite_ch1_rdata[24] ;
  wire \m_axi_lite_ch1_rdata[26] ;
  wire [0:0]\m_axi_lite_ch1_rdata[30] ;
  wire m_axi_lite_ch1_rdata_0_sn_1;
  wire m_axi_lite_ch1_rdata_12_sn_1;
  wire m_axi_lite_ch1_rdata_18_sn_1;
  wire m_axi_lite_ch1_rdata_20_sn_1;
  wire m_axi_lite_ch1_rdata_2_sn_1;
  wire m_axi_lite_ch1_rdata_6_sn_1;
  wire m_axi_lite_ch1_rdata_8_sn_1;
  wire [0:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rvalid;
  wire r_complete;
  wire rd_check1_carry__0;
  wire rd_check1_carry__2;
  wire rom_eof0;
  wire rready_m;
  wire rready_m_reg;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;

  assign m_axi_lite_ch1_rdata_0_sp_1 = m_axi_lite_ch1_rdata_0_sn_1;
  assign m_axi_lite_ch1_rdata_12_sp_1 = m_axi_lite_ch1_rdata_12_sn_1;
  assign m_axi_lite_ch1_rdata_18_sp_1 = m_axi_lite_ch1_rdata_18_sn_1;
  assign m_axi_lite_ch1_rdata_20_sp_1 = m_axi_lite_ch1_rdata_20_sn_1;
  assign m_axi_lite_ch1_rdata_2_sp_1 = m_axi_lite_ch1_rdata_2_sn_1;
  assign m_axi_lite_ch1_rdata_6_sp_1 = m_axi_lite_ch1_rdata_6_sn_1;
  assign m_axi_lite_ch1_rdata_8_sp_1 = m_axi_lite_ch1_rdata_8_sn_1;
  mipi_init_gen_xpm_memory_spram__parameterized1 xpm_memory_spram_inst
       (.addra(addra),
        .b_complete(b_complete),
        .bready_m(bready_m),
        .bready_m_reg(bready_m_reg),
        .cur_trn_status_reg(cur_trn_status_reg),
        .cur_trn_status_reg_0(cur_trn_status_reg_0),
        .cur_trn_status_reg_1(cur_trn_status_reg_1),
        .douta(douta),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] (rom_eof0),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ),
        .i__carry__1_i_1(i__carry__1_i_1),
        .i__carry__1_i_1_0(i__carry__1_i_1_0),
        .m_axi_lite_ch1_bresp(m_axi_lite_ch1_bresp),
        .m_axi_lite_ch1_bvalid(m_axi_lite_ch1_bvalid),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata),
        .\m_axi_lite_ch1_rdata[14] (\m_axi_lite_ch1_rdata[14] ),
        .\m_axi_lite_ch1_rdata[14]_0 (\m_axi_lite_ch1_rdata[14]_0 ),
        .\m_axi_lite_ch1_rdata[24] (\m_axi_lite_ch1_rdata[24] ),
        .\m_axi_lite_ch1_rdata[26] (\m_axi_lite_ch1_rdata[26] ),
        .\m_axi_lite_ch1_rdata[30] (\m_axi_lite_ch1_rdata[30] ),
        .m_axi_lite_ch1_rdata_0_sp_1(m_axi_lite_ch1_rdata_0_sn_1),
        .m_axi_lite_ch1_rdata_12_sp_1(m_axi_lite_ch1_rdata_12_sn_1),
        .m_axi_lite_ch1_rdata_18_sp_1(m_axi_lite_ch1_rdata_18_sn_1),
        .m_axi_lite_ch1_rdata_20_sp_1(m_axi_lite_ch1_rdata_20_sn_1),
        .m_axi_lite_ch1_rdata_2_sp_1(m_axi_lite_ch1_rdata_2_sn_1),
        .m_axi_lite_ch1_rdata_6_sp_1(m_axi_lite_ch1_rdata_6_sn_1),
        .m_axi_lite_ch1_rdata_8_sp_1(m_axi_lite_ch1_rdata_8_sn_1),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp),
        .m_axi_lite_ch1_rvalid(m_axi_lite_ch1_rvalid),
        .r_complete(r_complete),
        .rd_check1_carry__0(rd_check1_carry__0),
        .rd_check1_carry__2(rd_check1_carry__2),
        .rready_m(rready_m),
        .rready_m_reg(rready_m_reg),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(s_axi_aresetn_0));
endmodule

(* ORIG_REF_NAME = "axi_traffic_gen_v3_0_20_systeminit_dmg" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized2
   (douta,
    \m_axi_lite_ch1_rdata[11] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ,
    DI,
    \m_axi_lite_ch1_rdata[5] ,
    \m_axi_lite_ch1_rdata[23] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ,
    \m_axi_lite_ch1_rdata[11]_0 ,
    \m_axi_lite_ch1_rdata[22] ,
    \m_axi_lite_ch1_rdata[23]_0 ,
    \m_axi_lite_ch1_rdata[23]_1 ,
    \m_axi_lite_ch1_rdata[29] ,
    \m_axi_lite_ch1_rdata[28] ,
    \m_axi_lite_ch1_rdata[29]_0 ,
    \m_axi_lite_ch1_rdata[29]_1 ,
    S,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ,
    \m_axi_lite_ch1_rdata[22]_0 ,
    \m_axi_lite_ch1_rdata[28]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    addra,
    rom_eof0,
    m_axi_lite_ch1_rdata,
    rd_check2_carry__2,
    \rd_check2_inferred__0/i__carry ,
    \rd_check2_inferred__0/i__carry_0 ,
    rd_check1_carry,
    rd_check2_carry,
    \rd_check2_inferred__0/i__carry_1 ,
    \rd_check2_inferred__0/i__carry__0 ,
    \rd_check2_inferred__0/i__carry_2 ,
    rd_check1_carry__0,
    rd_check2_carry__0,
    \rd_check2_inferred__0/i__carry__0_0 ,
    rd_check1_carry__1,
    rd_check2_carry__1,
    \rd_check2_inferred__0/i__carry__0_1 ,
    rd_check1_carry__1_0,
    \rd_check2_inferred__0/i__carry__1 ,
    rd_check1_carry__2,
    rd_check2_carry__2_0,
    \rd_check2_inferred__0/i__carry__1_0 );
  output [31:0]douta;
  output [3:0]\m_axi_lite_ch1_rdata[11] ;
  output [3:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ;
  output [3:0]DI;
  output [0:0]\m_axi_lite_ch1_rdata[5] ;
  output [3:0]\m_axi_lite_ch1_rdata[23] ;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ;
  output [0:0]\m_axi_lite_ch1_rdata[11]_0 ;
  output [3:0]\m_axi_lite_ch1_rdata[22] ;
  output [3:0]\m_axi_lite_ch1_rdata[23]_0 ;
  output [1:0]\m_axi_lite_ch1_rdata[23]_1 ;
  output [1:0]\m_axi_lite_ch1_rdata[29] ;
  output [2:0]\m_axi_lite_ch1_rdata[28] ;
  output [2:0]\m_axi_lite_ch1_rdata[29]_0 ;
  output [0:0]\m_axi_lite_ch1_rdata[29]_1 ;
  output [3:0]S;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ;
  output [3:0]\m_axi_lite_ch1_rdata[22]_0 ;
  output [2:0]\m_axi_lite_ch1_rdata[28]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  input [7:0]addra;
  input rom_eof0;
  input [29:0]m_axi_lite_ch1_rdata;
  input [29:0]rd_check2_carry__2;
  input \rd_check2_inferred__0/i__carry ;
  input \rd_check2_inferred__0/i__carry_0 ;
  input rd_check1_carry;
  input rd_check2_carry;
  input \rd_check2_inferred__0/i__carry_1 ;
  input \rd_check2_inferred__0/i__carry__0 ;
  input \rd_check2_inferred__0/i__carry_2 ;
  input rd_check1_carry__0;
  input rd_check2_carry__0;
  input \rd_check2_inferred__0/i__carry__0_0 ;
  input rd_check1_carry__1;
  input rd_check2_carry__1;
  input \rd_check2_inferred__0/i__carry__0_1 ;
  input rd_check1_carry__1_0;
  input \rd_check2_inferred__0/i__carry__1 ;
  input rd_check1_carry__2;
  input rd_check2_carry__2_0;
  input \rd_check2_inferred__0/i__carry__1_0 ;

  wire [3:0]DI;
  wire [3:0]S;
  wire [7:0]addra;
  wire [31:0]douta;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire [3:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ;
  wire [29:0]m_axi_lite_ch1_rdata;
  wire [3:0]\m_axi_lite_ch1_rdata[11] ;
  wire [0:0]\m_axi_lite_ch1_rdata[11]_0 ;
  wire [3:0]\m_axi_lite_ch1_rdata[22] ;
  wire [3:0]\m_axi_lite_ch1_rdata[22]_0 ;
  wire [3:0]\m_axi_lite_ch1_rdata[23] ;
  wire [3:0]\m_axi_lite_ch1_rdata[23]_0 ;
  wire [1:0]\m_axi_lite_ch1_rdata[23]_1 ;
  wire [2:0]\m_axi_lite_ch1_rdata[28] ;
  wire [2:0]\m_axi_lite_ch1_rdata[28]_0 ;
  wire [1:0]\m_axi_lite_ch1_rdata[29] ;
  wire [2:0]\m_axi_lite_ch1_rdata[29]_0 ;
  wire [0:0]\m_axi_lite_ch1_rdata[29]_1 ;
  wire [0:0]\m_axi_lite_ch1_rdata[5] ;
  wire rd_check1_carry;
  wire rd_check1_carry__0;
  wire rd_check1_carry__1;
  wire rd_check1_carry__1_0;
  wire rd_check1_carry__2;
  wire rd_check2_carry;
  wire rd_check2_carry__0;
  wire rd_check2_carry__1;
  wire [29:0]rd_check2_carry__2;
  wire rd_check2_carry__2_0;
  wire \rd_check2_inferred__0/i__carry ;
  wire \rd_check2_inferred__0/i__carry_0 ;
  wire \rd_check2_inferred__0/i__carry_1 ;
  wire \rd_check2_inferred__0/i__carry_2 ;
  wire \rd_check2_inferred__0/i__carry__0 ;
  wire \rd_check2_inferred__0/i__carry__0_0 ;
  wire \rd_check2_inferred__0/i__carry__0_1 ;
  wire \rd_check2_inferred__0/i__carry__1 ;
  wire \rd_check2_inferred__0/i__carry__1_0 ;
  wire rom_eof0;
  wire s_axi_aclk;

  mipi_init_gen_xpm_memory_spram__parameterized2 xpm_memory_spram_inst
       (.DI(DI),
        .S(S),
        .addra(addra),
        .douta(douta),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] (\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata),
        .\m_axi_lite_ch1_rdata[11] (\m_axi_lite_ch1_rdata[11] ),
        .\m_axi_lite_ch1_rdata[11]_0 (\m_axi_lite_ch1_rdata[11]_0 ),
        .\m_axi_lite_ch1_rdata[22] (\m_axi_lite_ch1_rdata[22] ),
        .\m_axi_lite_ch1_rdata[22]_0 (\m_axi_lite_ch1_rdata[22]_0 ),
        .\m_axi_lite_ch1_rdata[23] (\m_axi_lite_ch1_rdata[23] ),
        .\m_axi_lite_ch1_rdata[23]_0 (\m_axi_lite_ch1_rdata[23]_0 ),
        .\m_axi_lite_ch1_rdata[23]_1 (\m_axi_lite_ch1_rdata[23]_1 ),
        .\m_axi_lite_ch1_rdata[28] (\m_axi_lite_ch1_rdata[28] ),
        .\m_axi_lite_ch1_rdata[28]_0 (\m_axi_lite_ch1_rdata[28]_0 ),
        .\m_axi_lite_ch1_rdata[29] (\m_axi_lite_ch1_rdata[29] ),
        .\m_axi_lite_ch1_rdata[29]_0 (\m_axi_lite_ch1_rdata[29]_0 ),
        .\m_axi_lite_ch1_rdata[29]_1 (\m_axi_lite_ch1_rdata[29]_1 ),
        .\m_axi_lite_ch1_rdata[5] (\m_axi_lite_ch1_rdata[5] ),
        .rd_check1_carry(rd_check1_carry),
        .rd_check1_carry__0(rd_check1_carry__0),
        .rd_check1_carry__1(rd_check1_carry__1),
        .rd_check1_carry__1_0(rd_check1_carry__1_0),
        .rd_check1_carry__2(rd_check1_carry__2),
        .rd_check2_carry(rd_check2_carry),
        .rd_check2_carry__0(rd_check2_carry__0),
        .rd_check2_carry__1(rd_check2_carry__1),
        .rd_check2_carry__2(rd_check2_carry__2),
        .rd_check2_carry__2_0(rd_check2_carry__2_0),
        .\rd_check2_inferred__0/i__carry (\rd_check2_inferred__0/i__carry ),
        .\rd_check2_inferred__0/i__carry_0 (\rd_check2_inferred__0/i__carry_0 ),
        .\rd_check2_inferred__0/i__carry_1 (\rd_check2_inferred__0/i__carry_1 ),
        .\rd_check2_inferred__0/i__carry_2 (\rd_check2_inferred__0/i__carry_2 ),
        .\rd_check2_inferred__0/i__carry__0 (\rd_check2_inferred__0/i__carry__0 ),
        .\rd_check2_inferred__0/i__carry__0_0 (\rd_check2_inferred__0/i__carry__0_0 ),
        .\rd_check2_inferred__0/i__carry__0_1 (\rd_check2_inferred__0/i__carry__0_1 ),
        .\rd_check2_inferred__0/i__carry__1 (\rd_check2_inferred__0/i__carry__1 ),
        .\rd_check2_inferred__0/i__carry__1_0 (\rd_check2_inferred__0/i__carry__1_0 ),
        .rom_eof0(rom_eof0),
        .s_axi_aclk(s_axi_aclk));
endmodule

module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_mrdwr
   (s_axi_aresetn_0,
    done,
    \m_axi_lite_ch1_rdata[30] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,
    CO,
    rready_m,
    bready_m,
    cur_trn_status_reg_0,
    m_axi_lite_ch1_awaddr,
    m_axi_lite_ch1_araddr,
    m_axi_lite_ch1_awvalid,
    m_axi_lite_ch1_wvalid,
    m_axi_lite_ch1_bready,
    m_axi_lite_ch1_arvalid,
    m_axi_lite_ch1_rready,
    addra,
    m_axi_lite_ch1_wdata,
    status,
    s_axi_aresetn,
    s_axi_aclk,
    r_complete,
    b_complete,
    DI,
    S,
    rd_check2_carry__1_0,
    rd_check2_carry__1_1,
    rd_check2_carry__2_0,
    rd_check2_carry__2_1,
    cur_trn_status_i_4,
    cur_trn_status_i_4_0,
    rd_check1_carry__0_0,
    rd_check1_carry__0_1,
    rd_check1_carry__1_0,
    rd_check1_carry__1_1,
    rd_check1_carry__2_0,
    rd_check1_carry__2_1,
    cur_trn_status_i_4_1,
    cur_trn_status_i_4_2,
    \rd_check2_inferred__0/i__carry__0_0 ,
    \rd_check2_inferred__0/i__carry__1_0 ,
    cur_trn_status_i_3,
    cur_trn_status_reg_1,
    m_axi_lite_ch1_awready,
    rom_eof0,
    m_axi_lite_ch1_arready,
    m_axi_lite_ch1_wready,
    \max_retry_cntr_reg[31]_0 ,
    \max_retry_cntr_reg[31]_1 ,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_rvalid,
    douta,
    D,
    \wdata_m_reg[31]_0 ,
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 );
  output s_axi_aresetn_0;
  output done;
  output [0:0]\m_axi_lite_ch1_rdata[30] ;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  output [0:0]CO;
  output rready_m;
  output bready_m;
  output cur_trn_status_reg_0;
  output [31:0]m_axi_lite_ch1_awaddr;
  output [31:0]m_axi_lite_ch1_araddr;
  output m_axi_lite_ch1_awvalid;
  output m_axi_lite_ch1_wvalid;
  output m_axi_lite_ch1_bready;
  output m_axi_lite_ch1_arvalid;
  output m_axi_lite_ch1_rready;
  output [7:0]addra;
  output [31:0]m_axi_lite_ch1_wdata;
  output [25:0]status;
  input s_axi_aresetn;
  input s_axi_aclk;
  input r_complete;
  input b_complete;
  input [3:0]DI;
  input [3:0]S;
  input [3:0]rd_check2_carry__1_0;
  input [3:0]rd_check2_carry__1_1;
  input [3:0]rd_check2_carry__2_0;
  input [3:0]rd_check2_carry__2_1;
  input [3:0]cur_trn_status_i_4;
  input [3:0]cur_trn_status_i_4_0;
  input [3:0]rd_check1_carry__0_0;
  input [3:0]rd_check1_carry__0_1;
  input [3:0]rd_check1_carry__1_0;
  input [3:0]rd_check1_carry__1_1;
  input [3:0]rd_check1_carry__2_0;
  input [3:0]rd_check1_carry__2_1;
  input [3:0]cur_trn_status_i_4_1;
  input [3:0]cur_trn_status_i_4_2;
  input [3:0]\rd_check2_inferred__0/i__carry__0_0 ;
  input [3:0]\rd_check2_inferred__0/i__carry__1_0 ;
  input [2:0]cur_trn_status_i_3;
  input cur_trn_status_reg_1;
  input m_axi_lite_ch1_awready;
  input rom_eof0;
  input m_axi_lite_ch1_arready;
  input m_axi_lite_ch1_wready;
  input \max_retry_cntr_reg[31]_0 ;
  input \max_retry_cntr_reg[31]_1 ;
  input m_axi_lite_ch1_bvalid;
  input m_axi_lite_ch1_rvalid;
  input [1:0]douta;
  input [31:0]D;
  input [31:0]\wdata_m_reg[31]_0 ;
  input [7:0]\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 ;

  wire [7:0]\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[0] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[1] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[2] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[3] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[4] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[5] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[6] ;
  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[7] ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr[0]_i_3_n_0 ;
  wire [15:0]\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_7 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_0 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_1 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_2 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_3 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_4 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_5 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_6 ;
  wire \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_7 ;
  wire [31:16]\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 ;
  wire [0:0]CO;
  wire [31:0]D;
  wire [3:0]DI;
  wire [3:0]S;
  wire [7:0]addra;
  wire arvalid_m;
  wire arvalid_m_i_1_n_0;
  wire \awaddr_m[31]_i_10_n_0 ;
  wire \awaddr_m[31]_i_11_n_0 ;
  wire \awaddr_m[31]_i_12_n_0 ;
  wire \awaddr_m[31]_i_13_n_0 ;
  wire \awaddr_m[31]_i_14_n_0 ;
  wire \awaddr_m[31]_i_15_n_0 ;
  wire \awaddr_m[31]_i_16_n_0 ;
  wire \awaddr_m[31]_i_17_n_0 ;
  wire \awaddr_m[31]_i_18_n_0 ;
  wire \awaddr_m[31]_i_19_n_0 ;
  wire \awaddr_m[31]_i_20_n_0 ;
  wire \awaddr_m[31]_i_21_n_0 ;
  wire \awaddr_m[31]_i_22_n_0 ;
  wire \awaddr_m[31]_i_23_n_0 ;
  wire \awaddr_m[31]_i_3_n_0 ;
  wire \awaddr_m[31]_i_4_n_0 ;
  wire \awaddr_m[31]_i_5_n_0 ;
  wire \awaddr_m[31]_i_6_n_0 ;
  wire \awaddr_m[31]_i_7_n_0 ;
  wire \awaddr_m[31]_i_8_n_0 ;
  wire \awaddr_m[31]_i_9_n_0 ;
  wire awvalid_m;
  wire awvalid_m_i_1_n_0;
  wire b_complete;
  wire b_complete_2ff;
  wire b_complete_3ff;
  wire b_complete_ff;
  wire bready_m;
  wire bready_m_i_1_n_0;
  wire bready_m_i_2_n_0;
  wire [31:0]cur_trn_addr;
  wire cur_trn_addr_0;
  wire cur_trn_done;
  wire [2:0]cur_trn_status_i_3;
  wire [3:0]cur_trn_status_i_4;
  wire [3:0]cur_trn_status_i_4_0;
  wire [3:0]cur_trn_status_i_4_1;
  wire [3:0]cur_trn_status_i_4_2;
  wire cur_trn_status_reg_0;
  wire cur_trn_status_reg_1;
  wire \cur_trn_type[0]_i_1_n_0 ;
  wire \cur_trn_type[1]_i_1_n_0 ;
  wire \cur_trn_type_reg_n_0_[0] ;
  wire \cur_trn_type_reg_n_0_[1] ;
  wire done;
  wire done_i;
  wire done_i_i_1_n_0;
  wire done_i_i_2_n_0;
  wire done_i_i_3_n_0;
  wire [1:0]douta;
  wire first_tran_done;
  wire first_tran_done_i_1_n_0;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  wire launch_new_rd;
  wire launch_new_wr;
  wire [31:0]m_axi_lite_ch1_araddr;
  wire m_axi_lite_ch1_arready;
  wire m_axi_lite_ch1_arvalid;
  wire [31:0]m_axi_lite_ch1_awaddr;
  wire m_axi_lite_ch1_awready;
  wire m_axi_lite_ch1_awvalid;
  wire m_axi_lite_ch1_bready;
  wire m_axi_lite_ch1_bvalid;
  wire [0:0]\m_axi_lite_ch1_rdata[30] ;
  wire m_axi_lite_ch1_rready;
  wire m_axi_lite_ch1_rvalid;
  wire [31:0]m_axi_lite_ch1_wdata;
  wire m_axi_lite_ch1_wready;
  wire m_axi_lite_ch1_wvalid;
  wire max_retry_cntr0;
  wire max_retry_cntr2_carry__0_i_1_n_0;
  wire max_retry_cntr2_carry__0_i_2_n_0;
  wire max_retry_cntr2_carry__0_i_3_n_0;
  wire max_retry_cntr2_carry__0_i_4_n_0;
  wire max_retry_cntr2_carry__0_n_0;
  wire max_retry_cntr2_carry__0_n_1;
  wire max_retry_cntr2_carry__0_n_2;
  wire max_retry_cntr2_carry__0_n_3;
  wire max_retry_cntr2_carry__1_i_1_n_0;
  wire max_retry_cntr2_carry__1_i_2_n_0;
  wire max_retry_cntr2_carry__1_i_3_n_0;
  wire max_retry_cntr2_carry__1_n_1;
  wire max_retry_cntr2_carry__1_n_2;
  wire max_retry_cntr2_carry__1_n_3;
  wire max_retry_cntr2_carry_i_1_n_0;
  wire max_retry_cntr2_carry_i_2_n_0;
  wire max_retry_cntr2_carry_i_3_n_0;
  wire max_retry_cntr2_carry_i_4_n_0;
  wire max_retry_cntr2_carry_n_0;
  wire max_retry_cntr2_carry_n_1;
  wire max_retry_cntr2_carry_n_2;
  wire max_retry_cntr2_carry_n_3;
  wire \max_retry_cntr[0]_i_1_n_0 ;
  wire \max_retry_cntr[0]_i_4_n_0 ;
  wire \max_retry_cntr[0]_i_5_n_0 ;
  wire \max_retry_cntr[0]_i_6_n_0 ;
  wire [31:0]max_retry_cntr_reg;
  wire \max_retry_cntr_reg[0]_i_3_n_0 ;
  wire \max_retry_cntr_reg[0]_i_3_n_1 ;
  wire \max_retry_cntr_reg[0]_i_3_n_2 ;
  wire \max_retry_cntr_reg[0]_i_3_n_3 ;
  wire \max_retry_cntr_reg[0]_i_3_n_4 ;
  wire \max_retry_cntr_reg[0]_i_3_n_5 ;
  wire \max_retry_cntr_reg[0]_i_3_n_6 ;
  wire \max_retry_cntr_reg[0]_i_3_n_7 ;
  wire \max_retry_cntr_reg[12]_i_1_n_0 ;
  wire \max_retry_cntr_reg[12]_i_1_n_1 ;
  wire \max_retry_cntr_reg[12]_i_1_n_2 ;
  wire \max_retry_cntr_reg[12]_i_1_n_3 ;
  wire \max_retry_cntr_reg[12]_i_1_n_4 ;
  wire \max_retry_cntr_reg[12]_i_1_n_5 ;
  wire \max_retry_cntr_reg[12]_i_1_n_6 ;
  wire \max_retry_cntr_reg[12]_i_1_n_7 ;
  wire \max_retry_cntr_reg[16]_i_1_n_0 ;
  wire \max_retry_cntr_reg[16]_i_1_n_1 ;
  wire \max_retry_cntr_reg[16]_i_1_n_2 ;
  wire \max_retry_cntr_reg[16]_i_1_n_3 ;
  wire \max_retry_cntr_reg[16]_i_1_n_4 ;
  wire \max_retry_cntr_reg[16]_i_1_n_5 ;
  wire \max_retry_cntr_reg[16]_i_1_n_6 ;
  wire \max_retry_cntr_reg[16]_i_1_n_7 ;
  wire \max_retry_cntr_reg[20]_i_1_n_0 ;
  wire \max_retry_cntr_reg[20]_i_1_n_1 ;
  wire \max_retry_cntr_reg[20]_i_1_n_2 ;
  wire \max_retry_cntr_reg[20]_i_1_n_3 ;
  wire \max_retry_cntr_reg[20]_i_1_n_4 ;
  wire \max_retry_cntr_reg[20]_i_1_n_5 ;
  wire \max_retry_cntr_reg[20]_i_1_n_6 ;
  wire \max_retry_cntr_reg[20]_i_1_n_7 ;
  wire \max_retry_cntr_reg[24]_i_1_n_0 ;
  wire \max_retry_cntr_reg[24]_i_1_n_1 ;
  wire \max_retry_cntr_reg[24]_i_1_n_2 ;
  wire \max_retry_cntr_reg[24]_i_1_n_3 ;
  wire \max_retry_cntr_reg[24]_i_1_n_4 ;
  wire \max_retry_cntr_reg[24]_i_1_n_5 ;
  wire \max_retry_cntr_reg[24]_i_1_n_6 ;
  wire \max_retry_cntr_reg[24]_i_1_n_7 ;
  wire \max_retry_cntr_reg[28]_i_1_n_1 ;
  wire \max_retry_cntr_reg[28]_i_1_n_2 ;
  wire \max_retry_cntr_reg[28]_i_1_n_3 ;
  wire \max_retry_cntr_reg[28]_i_1_n_4 ;
  wire \max_retry_cntr_reg[28]_i_1_n_5 ;
  wire \max_retry_cntr_reg[28]_i_1_n_6 ;
  wire \max_retry_cntr_reg[28]_i_1_n_7 ;
  wire \max_retry_cntr_reg[31]_0 ;
  wire \max_retry_cntr_reg[31]_1 ;
  wire \max_retry_cntr_reg[4]_i_1_n_0 ;
  wire \max_retry_cntr_reg[4]_i_1_n_1 ;
  wire \max_retry_cntr_reg[4]_i_1_n_2 ;
  wire \max_retry_cntr_reg[4]_i_1_n_3 ;
  wire \max_retry_cntr_reg[4]_i_1_n_4 ;
  wire \max_retry_cntr_reg[4]_i_1_n_5 ;
  wire \max_retry_cntr_reg[4]_i_1_n_6 ;
  wire \max_retry_cntr_reg[4]_i_1_n_7 ;
  wire \max_retry_cntr_reg[8]_i_1_n_0 ;
  wire \max_retry_cntr_reg[8]_i_1_n_1 ;
  wire \max_retry_cntr_reg[8]_i_1_n_2 ;
  wire \max_retry_cntr_reg[8]_i_1_n_3 ;
  wire \max_retry_cntr_reg[8]_i_1_n_4 ;
  wire \max_retry_cntr_reg[8]_i_1_n_5 ;
  wire \max_retry_cntr_reg[8]_i_1_n_6 ;
  wire \max_retry_cntr_reg[8]_i_1_n_7 ;
  wire \max_test_time_cntr[0]_i_1_n_0 ;
  wire \max_test_time_cntr[0]_i_3_n_0 ;
  wire [31:0]max_test_time_cntr_reg;
  wire \max_test_time_cntr_reg[0]_i_2_n_0 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_1 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_2 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_3 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_4 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_5 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_6 ;
  wire \max_test_time_cntr_reg[0]_i_2_n_7 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[12]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[16]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[20]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[24]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[28]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[4]_i_1_n_7 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_0 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_1 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_2 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_3 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_4 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_5 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_6 ;
  wire \max_test_time_cntr_reg[8]_i_1_n_7 ;
  wire [31:0]new_trn_addr;
  wire \new_trn_addr[31]_i_1_n_0 ;
  wire \new_trn_addr_reg_n_0_[0] ;
  wire \new_trn_addr_reg_n_0_[10] ;
  wire \new_trn_addr_reg_n_0_[11] ;
  wire \new_trn_addr_reg_n_0_[12] ;
  wire \new_trn_addr_reg_n_0_[13] ;
  wire \new_trn_addr_reg_n_0_[14] ;
  wire \new_trn_addr_reg_n_0_[15] ;
  wire \new_trn_addr_reg_n_0_[16] ;
  wire \new_trn_addr_reg_n_0_[17] ;
  wire \new_trn_addr_reg_n_0_[18] ;
  wire \new_trn_addr_reg_n_0_[19] ;
  wire \new_trn_addr_reg_n_0_[1] ;
  wire \new_trn_addr_reg_n_0_[20] ;
  wire \new_trn_addr_reg_n_0_[21] ;
  wire \new_trn_addr_reg_n_0_[22] ;
  wire \new_trn_addr_reg_n_0_[23] ;
  wire \new_trn_addr_reg_n_0_[24] ;
  wire \new_trn_addr_reg_n_0_[25] ;
  wire \new_trn_addr_reg_n_0_[26] ;
  wire \new_trn_addr_reg_n_0_[27] ;
  wire \new_trn_addr_reg_n_0_[28] ;
  wire \new_trn_addr_reg_n_0_[29] ;
  wire \new_trn_addr_reg_n_0_[2] ;
  wire \new_trn_addr_reg_n_0_[30] ;
  wire \new_trn_addr_reg_n_0_[31] ;
  wire \new_trn_addr_reg_n_0_[3] ;
  wire \new_trn_addr_reg_n_0_[4] ;
  wire \new_trn_addr_reg_n_0_[5] ;
  wire \new_trn_addr_reg_n_0_[6] ;
  wire \new_trn_addr_reg_n_0_[7] ;
  wire \new_trn_addr_reg_n_0_[8] ;
  wire \new_trn_addr_reg_n_0_[9] ;
  wire [1:0]new_trn_type;
  wire \new_trn_type[0]_i_1_n_0 ;
  wire \new_trn_type[1]_i_1_n_0 ;
  wire [1:0]p_1_in;
  wire r_complete;
  wire r_complete_2ff;
  wire r_complete_3ff;
  wire r_complete_ff;
  wire [3:0]rd_check1_carry__0_0;
  wire [3:0]rd_check1_carry__0_1;
  wire rd_check1_carry__0_n_0;
  wire rd_check1_carry__0_n_1;
  wire rd_check1_carry__0_n_2;
  wire rd_check1_carry__0_n_3;
  wire [3:0]rd_check1_carry__1_0;
  wire [3:0]rd_check1_carry__1_1;
  wire rd_check1_carry__1_n_0;
  wire rd_check1_carry__1_n_1;
  wire rd_check1_carry__1_n_2;
  wire rd_check1_carry__1_n_3;
  wire [3:0]rd_check1_carry__2_0;
  wire [3:0]rd_check1_carry__2_1;
  wire rd_check1_carry__2_n_1;
  wire rd_check1_carry__2_n_2;
  wire rd_check1_carry__2_n_3;
  wire rd_check1_carry_n_0;
  wire rd_check1_carry_n_1;
  wire rd_check1_carry_n_2;
  wire rd_check1_carry_n_3;
  wire rd_check2_carry__0_n_0;
  wire rd_check2_carry__0_n_1;
  wire rd_check2_carry__0_n_2;
  wire rd_check2_carry__0_n_3;
  wire [3:0]rd_check2_carry__1_0;
  wire [3:0]rd_check2_carry__1_1;
  wire rd_check2_carry__1_n_0;
  wire rd_check2_carry__1_n_1;
  wire rd_check2_carry__1_n_2;
  wire rd_check2_carry__1_n_3;
  wire [3:0]rd_check2_carry__2_0;
  wire [3:0]rd_check2_carry__2_1;
  wire rd_check2_carry__2_n_1;
  wire rd_check2_carry__2_n_2;
  wire rd_check2_carry__2_n_3;
  wire rd_check2_carry_n_0;
  wire rd_check2_carry_n_1;
  wire rd_check2_carry_n_2;
  wire rd_check2_carry_n_3;
  wire [3:0]\rd_check2_inferred__0/i__carry__0_0 ;
  wire \rd_check2_inferred__0/i__carry__0_n_0 ;
  wire \rd_check2_inferred__0/i__carry__0_n_1 ;
  wire \rd_check2_inferred__0/i__carry__0_n_2 ;
  wire \rd_check2_inferred__0/i__carry__0_n_3 ;
  wire [3:0]\rd_check2_inferred__0/i__carry__1_0 ;
  wire \rd_check2_inferred__0/i__carry__1_n_2 ;
  wire \rd_check2_inferred__0/i__carry__1_n_3 ;
  wire \rd_check2_inferred__0/i__carry_n_0 ;
  wire \rd_check2_inferred__0/i__carry_n_1 ;
  wire \rd_check2_inferred__0/i__carry_n_2 ;
  wire \rd_check2_inferred__0/i__carry_n_3 ;
  wire rom_eof;
  wire rom_eof0;
  wire rom_eof_i_1_n_0;
  wire [7:0]rom_ptr_ff;
  wire \rom_ptr_ff[0]_i_1_n_0 ;
  wire \rom_ptr_ff[1]_i_1_n_0 ;
  wire \rom_ptr_ff[2]_i_1_n_0 ;
  wire \rom_ptr_ff[3]_i_1_n_0 ;
  wire \rom_ptr_ff[4]_i_1_n_0 ;
  wire \rom_ptr_ff[5]_i_1_n_0 ;
  wire \rom_ptr_ff[6]_i_1_n_0 ;
  wire \rom_ptr_ff[7]_i_1_n_0 ;
  wire rready_m;
  wire rready_m_i_1_n_0;
  wire rready_m_i_2_n_0;
  wire rst_l_2ff;
  wire rst_l_3ff;
  wire rst_l_ff;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire start_retry_check;
  wire start_retry_check_i_1_n_0;
  wire [25:0]status;
  wire \status[0]_i_10_n_0 ;
  wire \status[0]_i_2_n_0 ;
  wire \status[0]_i_3_n_0 ;
  wire \status[0]_i_4_n_0 ;
  wire \status[0]_i_5_n_0 ;
  wire \status[0]_i_6_n_0 ;
  wire \status[0]_i_7_n_0 ;
  wire \status[0]_i_8_n_0 ;
  wire \status[0]_i_9_n_0 ;
  wire \status[1]_i_10_n_0 ;
  wire \status[1]_i_11_n_0 ;
  wire \status[1]_i_12_n_0 ;
  wire \status[1]_i_13_n_0 ;
  wire \status[1]_i_2_n_0 ;
  wire \status[1]_i_3_n_0 ;
  wire \status[1]_i_4_n_0 ;
  wire \status[1]_i_5_n_0 ;
  wire \status[1]_i_6_n_0 ;
  wire \status[1]_i_7_n_0 ;
  wire \status[1]_i_8_n_0 ;
  wire \status[1]_i_9_n_0 ;
  wire \status[31]_i_1_n_0 ;
  wire test_err_cntr;
  wire [31:0]\wdata_m_reg[31]_0 ;
  wire wvalid_m;
  wire wvalid_m_i_1_n_0;
  wire [3:3]\NLW_ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_max_retry_cntr2_carry_O_UNCONNECTED;
  wire [3:0]NLW_max_retry_cntr2_carry__0_O_UNCONNECTED;
  wire [3:3]NLW_max_retry_cntr2_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_max_retry_cntr2_carry__1_O_UNCONNECTED;
  wire [3:3]\NLW_max_retry_cntr_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_max_test_time_cntr_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_rd_check1_carry_O_UNCONNECTED;
  wire [3:0]NLW_rd_check1_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_rd_check1_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_rd_check1_carry__2_O_UNCONNECTED;
  wire [3:0]NLW_rd_check2_carry_O_UNCONNECTED;
  wire [3:0]NLW_rd_check2_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_rd_check2_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_rd_check2_carry__2_O_UNCONNECTED;
  wire [3:0]\NLW_rd_check2_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:0]\NLW_rd_check2_inferred__0/i__carry__0_O_UNCONNECTED ;
  wire [3:3]\NLW_rd_check2_inferred__0/i__carry__1_CO_UNCONNECTED ;
  wire [3:0]\NLW_rd_check2_inferred__0/i__carry__1_O_UNCONNECTED ;

  LUT2 #(
    .INIT(4'hE)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[7]_i_1 
       (.I0(r_complete_ff),
        .I1(b_complete_ff),
        .O(cur_trn_done));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [0]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[0] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[1] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [1]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[1] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[2] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [2]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[2] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[3] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [3]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[3] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[4] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [4]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[4] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[5] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [5]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[5] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[6] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [6]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[6] ),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7] 
       (.C(s_axi_aclk),
        .CE(cur_trn_done),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 [7]),
        .Q(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[7] ),
        .R(s_axi_aresetn_0));
  LUT4 #(
    .INIT(16'h8880)) 
    \ATG_SYSTEST_NXT_PTR.test_err_cntr[0]_i_1 
       (.I0(douta[1]),
        .I1(cur_trn_status_reg_0),
        .I2(b_complete_ff),
        .I3(r_complete_ff),
        .O(test_err_cntr));
  LUT1 #(
    .INIT(2'h1)) 
    \ATG_SYSTEST_NXT_PTR.test_err_cntr[0]_i_3 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [0]),
        .O(\ATG_SYSTEST_NXT_PTR.test_err_cntr[0]_i_3_n_0 ));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [0]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_7 }),
        .S({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [3:1],\ATG_SYSTEST_NXT_PTR.test_err_cntr[0]_i_3_n_0 }));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[10] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [10]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[11] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [11]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [12]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [15:12]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[13] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [13]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[14] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [14]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[15] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [15]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [16]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[12]_i_1_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [19:16]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[17] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [17]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[18] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [18]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[19] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [19]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[1] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [1]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [20]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[16]_i_1_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [23:20]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[21] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [21]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[22] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [22]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[23] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [23]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [24]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[20]_i_1_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [27:24]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[25] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [25]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[26] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [26]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[27] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [27]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [28]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[24]_i_1_n_0 ),
        .CO({\NLW_ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_CO_UNCONNECTED [3],\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [31:28]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[29] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [29]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[2] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [2]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[30] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [30]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[31] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[28]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [31]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[3] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [3]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [4]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[0]_i_2_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [7:4]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[5] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [5]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[6] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_5 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [6]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[7] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_4 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [7]),
        .R(s_axi_aresetn_0));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_7 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [8]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1 
       (.CI(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[4]_i_1_n_0 ),
        .CO({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_0 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_1 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_2 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_4 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_5 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_6 ,\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_7 }),
        .S(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [11:8]));
  FDRE \ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[9] 
       (.C(s_axi_aclk),
        .CE(test_err_cntr),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg[8]_i_1_n_6 ),
        .Q(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [9]),
        .R(s_axi_aresetn_0));
  LUT4 #(
    .INIT(16'h0001)) 
    \araddr_m[31]_i_1 
       (.I0(\awaddr_m[31]_i_3_n_0 ),
        .I1(\awaddr_m[31]_i_4_n_0 ),
        .I2(douta[0]),
        .I3(rom_eof0),
        .O(launch_new_rd));
  FDRE \araddr_m_reg[0] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[0]),
        .Q(m_axi_lite_ch1_araddr[0]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[10] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[10]),
        .Q(m_axi_lite_ch1_araddr[10]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[11] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[11]),
        .Q(m_axi_lite_ch1_araddr[11]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[12] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[12]),
        .Q(m_axi_lite_ch1_araddr[12]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[13] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[13]),
        .Q(m_axi_lite_ch1_araddr[13]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[14] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[14]),
        .Q(m_axi_lite_ch1_araddr[14]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[15] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[15]),
        .Q(m_axi_lite_ch1_araddr[15]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[16] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[16]),
        .Q(m_axi_lite_ch1_araddr[16]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[17] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[17]),
        .Q(m_axi_lite_ch1_araddr[17]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[18] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[18]),
        .Q(m_axi_lite_ch1_araddr[18]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[19] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[19]),
        .Q(m_axi_lite_ch1_araddr[19]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[1] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[1]),
        .Q(m_axi_lite_ch1_araddr[1]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[20] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[20]),
        .Q(m_axi_lite_ch1_araddr[20]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[21] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[21]),
        .Q(m_axi_lite_ch1_araddr[21]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[22] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[22]),
        .Q(m_axi_lite_ch1_araddr[22]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[23] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[23]),
        .Q(m_axi_lite_ch1_araddr[23]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[24] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[24]),
        .Q(m_axi_lite_ch1_araddr[24]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[25] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[25]),
        .Q(m_axi_lite_ch1_araddr[25]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[26] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[26]),
        .Q(m_axi_lite_ch1_araddr[26]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[27] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[27]),
        .Q(m_axi_lite_ch1_araddr[27]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[28] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[28]),
        .Q(m_axi_lite_ch1_araddr[28]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[29] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[29]),
        .Q(m_axi_lite_ch1_araddr[29]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[2] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[2]),
        .Q(m_axi_lite_ch1_araddr[2]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[30] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[30]),
        .Q(m_axi_lite_ch1_araddr[30]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[31] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[31]),
        .Q(m_axi_lite_ch1_araddr[31]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[3] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[3]),
        .Q(m_axi_lite_ch1_araddr[3]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[4] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[4]),
        .Q(m_axi_lite_ch1_araddr[4]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[5] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[5]),
        .Q(m_axi_lite_ch1_araddr[5]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[6] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[6]),
        .Q(m_axi_lite_ch1_araddr[6]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[7] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[7]),
        .Q(m_axi_lite_ch1_araddr[7]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[8] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[8]),
        .Q(m_axi_lite_ch1_araddr[8]),
        .R(s_axi_aresetn_0));
  FDRE \araddr_m_reg[9] 
       (.C(s_axi_aclk),
        .CE(launch_new_rd),
        .D(D[9]),
        .Q(m_axi_lite_ch1_araddr[9]),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hAAAA00AA00000808)) 
    arvalid_m_i_1
       (.I0(s_axi_aresetn),
        .I1(rready_m_i_2_n_0),
        .I2(\awaddr_m[31]_i_3_n_0 ),
        .I3(m_axi_lite_ch1_arready),
        .I4(rom_eof0),
        .I5(arvalid_m),
        .O(arvalid_m_i_1_n_0));
  FDRE arvalid_m_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(arvalid_m_i_1_n_0),
        .Q(arvalid_m),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \awaddr_m[31]_i_1 
       (.I0(s_axi_aresetn),
        .O(s_axi_aresetn_0));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_10 
       (.I0(max_retry_cntr_reg[27]),
        .I1(max_retry_cntr_reg[26]),
        .I2(max_retry_cntr_reg[25]),
        .I3(max_retry_cntr_reg[24]),
        .O(\awaddr_m[31]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_11 
       (.I0(max_retry_cntr_reg[23]),
        .I1(max_retry_cntr_reg[22]),
        .I2(max_retry_cntr_reg[21]),
        .I3(max_retry_cntr_reg[20]),
        .O(\awaddr_m[31]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_12 
       (.I0(max_retry_cntr_reg[11]),
        .I1(max_retry_cntr_reg[10]),
        .I2(max_retry_cntr_reg[9]),
        .I3(max_retry_cntr_reg[8]),
        .O(\awaddr_m[31]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_13 
       (.I0(max_retry_cntr_reg[5]),
        .I1(max_retry_cntr_reg[4]),
        .I2(max_retry_cntr_reg[7]),
        .I3(max_retry_cntr_reg[6]),
        .O(\awaddr_m[31]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_14 
       (.I0(max_retry_cntr_reg[15]),
        .I1(max_retry_cntr_reg[14]),
        .I2(max_retry_cntr_reg[13]),
        .I3(max_retry_cntr_reg[12]),
        .O(\awaddr_m[31]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_15 
       (.I0(max_retry_cntr_reg[19]),
        .I1(max_retry_cntr_reg[18]),
        .I2(max_retry_cntr_reg[17]),
        .I3(max_retry_cntr_reg[16]),
        .O(\awaddr_m[31]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_16 
       (.I0(max_test_time_cntr_reg[9]),
        .I1(max_test_time_cntr_reg[8]),
        .I2(max_test_time_cntr_reg[7]),
        .I3(max_test_time_cntr_reg[6]),
        .O(\awaddr_m[31]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_17 
       (.I0(max_test_time_cntr_reg[3]),
        .I1(max_test_time_cntr_reg[1]),
        .I2(max_test_time_cntr_reg[5]),
        .I3(max_test_time_cntr_reg[4]),
        .O(\awaddr_m[31]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_18 
       (.I0(max_test_time_cntr_reg[13]),
        .I1(max_test_time_cntr_reg[12]),
        .I2(max_test_time_cntr_reg[11]),
        .I3(max_test_time_cntr_reg[10]),
        .O(\awaddr_m[31]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_19 
       (.I0(max_test_time_cntr_reg[17]),
        .I1(max_test_time_cntr_reg[16]),
        .I2(max_test_time_cntr_reg[15]),
        .I3(max_test_time_cntr_reg[14]),
        .O(\awaddr_m[31]_i_19_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \awaddr_m[31]_i_2 
       (.I0(\awaddr_m[31]_i_3_n_0 ),
        .I1(douta[0]),
        .I2(\awaddr_m[31]_i_4_n_0 ),
        .I3(rom_eof0),
        .O(launch_new_wr));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_20 
       (.I0(max_test_time_cntr_reg[23]),
        .I1(max_test_time_cntr_reg[22]),
        .I2(max_test_time_cntr_reg[21]),
        .I3(max_test_time_cntr_reg[20]),
        .O(\awaddr_m[31]_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    \awaddr_m[31]_i_21 
       (.I0(max_test_time_cntr_reg[2]),
        .I1(max_test_time_cntr_reg[0]),
        .I2(max_test_time_cntr_reg[19]),
        .I3(max_test_time_cntr_reg[18]),
        .O(\awaddr_m[31]_i_21_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_22 
       (.I0(max_test_time_cntr_reg[27]),
        .I1(max_test_time_cntr_reg[26]),
        .I2(max_test_time_cntr_reg[25]),
        .I3(max_test_time_cntr_reg[24]),
        .O(\awaddr_m[31]_i_22_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_23 
       (.I0(max_test_time_cntr_reg[31]),
        .I1(max_test_time_cntr_reg[30]),
        .I2(max_test_time_cntr_reg[29]),
        .I3(max_test_time_cntr_reg[28]),
        .O(\awaddr_m[31]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF80FF80FF80)) 
    \awaddr_m[31]_i_3 
       (.I0(\awaddr_m[31]_i_5_n_0 ),
        .I1(\awaddr_m[31]_i_6_n_0 ),
        .I2(\awaddr_m[31]_i_7_n_0 ),
        .I3(rom_eof),
        .I4(\awaddr_m[31]_i_8_n_0 ),
        .I5(\awaddr_m[31]_i_9_n_0 ),
        .O(\awaddr_m[31]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h1101)) 
    \awaddr_m[31]_i_4 
       (.I0(b_complete_3ff),
        .I1(r_complete_3ff),
        .I2(rst_l_2ff),
        .I3(rst_l_3ff),
        .O(\awaddr_m[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \awaddr_m[31]_i_5 
       (.I0(max_retry_cntr_reg[28]),
        .I1(max_retry_cntr_reg[29]),
        .I2(max_retry_cntr_reg[30]),
        .I3(max_retry_cntr_reg[31]),
        .I4(\awaddr_m[31]_i_10_n_0 ),
        .O(\awaddr_m[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \awaddr_m[31]_i_6 
       (.I0(max_retry_cntr_reg[2]),
        .I1(max_retry_cntr_reg[3]),
        .I2(max_retry_cntr_reg[0]),
        .I3(max_retry_cntr_reg[1]),
        .I4(\awaddr_m[31]_i_11_n_0 ),
        .O(\awaddr_m[31]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_7 
       (.I0(\awaddr_m[31]_i_12_n_0 ),
        .I1(\awaddr_m[31]_i_13_n_0 ),
        .I2(\awaddr_m[31]_i_14_n_0 ),
        .I3(\awaddr_m[31]_i_15_n_0 ),
        .O(\awaddr_m[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_8 
       (.I0(\awaddr_m[31]_i_16_n_0 ),
        .I1(\awaddr_m[31]_i_17_n_0 ),
        .I2(\awaddr_m[31]_i_18_n_0 ),
        .I3(\awaddr_m[31]_i_19_n_0 ),
        .O(\awaddr_m[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \awaddr_m[31]_i_9 
       (.I0(\awaddr_m[31]_i_20_n_0 ),
        .I1(\awaddr_m[31]_i_21_n_0 ),
        .I2(\awaddr_m[31]_i_22_n_0 ),
        .I3(\awaddr_m[31]_i_23_n_0 ),
        .O(\awaddr_m[31]_i_9_n_0 ));
  FDRE \awaddr_m_reg[0] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[0]),
        .Q(m_axi_lite_ch1_awaddr[0]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[10] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[10]),
        .Q(m_axi_lite_ch1_awaddr[10]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[11] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[11]),
        .Q(m_axi_lite_ch1_awaddr[11]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[12] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[12]),
        .Q(m_axi_lite_ch1_awaddr[12]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[13] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[13]),
        .Q(m_axi_lite_ch1_awaddr[13]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[14] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[14]),
        .Q(m_axi_lite_ch1_awaddr[14]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[15] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[15]),
        .Q(m_axi_lite_ch1_awaddr[15]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[16] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[16]),
        .Q(m_axi_lite_ch1_awaddr[16]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[17] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[17]),
        .Q(m_axi_lite_ch1_awaddr[17]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[18] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[18]),
        .Q(m_axi_lite_ch1_awaddr[18]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[19] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[19]),
        .Q(m_axi_lite_ch1_awaddr[19]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[1] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[1]),
        .Q(m_axi_lite_ch1_awaddr[1]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[20] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[20]),
        .Q(m_axi_lite_ch1_awaddr[20]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[21] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[21]),
        .Q(m_axi_lite_ch1_awaddr[21]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[22] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[22]),
        .Q(m_axi_lite_ch1_awaddr[22]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[23] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[23]),
        .Q(m_axi_lite_ch1_awaddr[23]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[24] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[24]),
        .Q(m_axi_lite_ch1_awaddr[24]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[25] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[25]),
        .Q(m_axi_lite_ch1_awaddr[25]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[26] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[26]),
        .Q(m_axi_lite_ch1_awaddr[26]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[27] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[27]),
        .Q(m_axi_lite_ch1_awaddr[27]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[28] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[28]),
        .Q(m_axi_lite_ch1_awaddr[28]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[29] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[29]),
        .Q(m_axi_lite_ch1_awaddr[29]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[2] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[2]),
        .Q(m_axi_lite_ch1_awaddr[2]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[30] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[30]),
        .Q(m_axi_lite_ch1_awaddr[30]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[31] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[31]),
        .Q(m_axi_lite_ch1_awaddr[31]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[3] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[3]),
        .Q(m_axi_lite_ch1_awaddr[3]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[4] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[4]),
        .Q(m_axi_lite_ch1_awaddr[4]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[5] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[5]),
        .Q(m_axi_lite_ch1_awaddr[5]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[6] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[6]),
        .Q(m_axi_lite_ch1_awaddr[6]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[7] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[7]),
        .Q(m_axi_lite_ch1_awaddr[7]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[8] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[8]),
        .Q(m_axi_lite_ch1_awaddr[8]),
        .R(s_axi_aresetn_0));
  FDRE \awaddr_m_reg[9] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(D[9]),
        .Q(m_axi_lite_ch1_awaddr[9]),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hAA00AAAA00080008)) 
    awvalid_m_i_1
       (.I0(s_axi_aresetn),
        .I1(bready_m_i_2_n_0),
        .I2(\awaddr_m[31]_i_3_n_0 ),
        .I3(rom_eof0),
        .I4(m_axi_lite_ch1_awready),
        .I5(awvalid_m),
        .O(awvalid_m_i_1_n_0));
  FDRE awvalid_m_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(awvalid_m_i_1_n_0),
        .Q(awvalid_m),
        .R(1'b0));
  FDRE b_complete_2ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(b_complete_ff),
        .Q(b_complete_2ff),
        .R(s_axi_aresetn_0));
  FDRE b_complete_3ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(b_complete_2ff),
        .Q(b_complete_3ff),
        .R(s_axi_aresetn_0));
  FDRE b_complete_ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(b_complete),
        .Q(b_complete_ff),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hAAAA00AA00000808)) 
    bready_m_i_1
       (.I0(s_axi_aresetn),
        .I1(bready_m_i_2_n_0),
        .I2(\awaddr_m[31]_i_3_n_0 ),
        .I3(m_axi_lite_ch1_bvalid),
        .I4(rom_eof0),
        .I5(bready_m),
        .O(bready_m_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hAAAAAA20)) 
    bready_m_i_2
       (.I0(douta[0]),
        .I1(rst_l_3ff),
        .I2(rst_l_2ff),
        .I3(r_complete_3ff),
        .I4(b_complete_3ff),
        .O(bready_m_i_2_n_0));
  FDRE bready_m_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bready_m_i_1_n_0),
        .Q(bready_m),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h000000000F080808)) 
    \cur_trn_addr[31]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(arvalid_m),
        .I4(m_axi_lite_ch1_arready),
        .I5(first_tran_done),
        .O(cur_trn_addr_0));
  FDRE \cur_trn_addr_reg[0] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[0]),
        .Q(cur_trn_addr[0]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[10] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[10]),
        .Q(cur_trn_addr[10]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[11] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[11]),
        .Q(cur_trn_addr[11]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[12] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[12]),
        .Q(cur_trn_addr[12]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[13] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[13]),
        .Q(cur_trn_addr[13]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[14] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[14]),
        .Q(cur_trn_addr[14]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[15] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[15]),
        .Q(cur_trn_addr[15]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[16] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[16]),
        .Q(cur_trn_addr[16]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[17] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[17]),
        .Q(cur_trn_addr[17]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[18] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[18]),
        .Q(cur_trn_addr[18]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[19] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[19]),
        .Q(cur_trn_addr[19]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[1] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[1]),
        .Q(cur_trn_addr[1]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[20] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[20]),
        .Q(cur_trn_addr[20]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[21] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[21]),
        .Q(cur_trn_addr[21]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[22] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[22]),
        .Q(cur_trn_addr[22]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[23] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[23]),
        .Q(cur_trn_addr[23]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[24] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[24]),
        .Q(cur_trn_addr[24]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[25] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[25]),
        .Q(cur_trn_addr[25]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[26] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[26]),
        .Q(cur_trn_addr[26]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[27] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[27]),
        .Q(cur_trn_addr[27]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[28] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[28]),
        .Q(cur_trn_addr[28]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[29] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[29]),
        .Q(cur_trn_addr[29]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[2] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[2]),
        .Q(cur_trn_addr[2]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[30] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[30]),
        .Q(cur_trn_addr[30]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[31] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[31]),
        .Q(cur_trn_addr[31]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[3] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[3]),
        .Q(cur_trn_addr[3]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[4] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[4]),
        .Q(cur_trn_addr[4]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[5] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[5]),
        .Q(cur_trn_addr[5]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[6] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[6]),
        .Q(cur_trn_addr[6]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[7] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[7]),
        .Q(cur_trn_addr[7]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[8] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[8]),
        .Q(cur_trn_addr[8]),
        .R(s_axi_aresetn_0));
  FDRE \cur_trn_addr_reg[9] 
       (.C(s_axi_aclk),
        .CE(cur_trn_addr_0),
        .D(new_trn_addr[9]),
        .Q(cur_trn_addr[9]),
        .R(s_axi_aresetn_0));
  FDRE cur_trn_status_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(cur_trn_status_reg_1),
        .Q(cur_trn_status_reg_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h08FF000008000000)) 
    \cur_trn_type[0]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(cur_trn_addr_0),
        .I4(s_axi_aresetn),
        .I5(\cur_trn_type_reg_n_0_[0] ),
        .O(\cur_trn_type[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF7FF0000F7000000)) 
    \cur_trn_type[1]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(cur_trn_addr_0),
        .I4(s_axi_aresetn),
        .I5(\cur_trn_type_reg_n_0_[1] ),
        .O(\cur_trn_type[1]_i_1_n_0 ));
  FDRE \cur_trn_type_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\cur_trn_type[0]_i_1_n_0 ),
        .Q(\cur_trn_type_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \cur_trn_type_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\cur_trn_type[1]_i_1_n_0 ),
        .Q(\cur_trn_type_reg_n_0_[1] ),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFFEA)) 
    done_i_i_1
       (.I0(\status[1]_i_4_n_0 ),
        .I1(done_i_i_2_n_0),
        .I2(done_i_i_3_n_0),
        .I3(done_i),
        .O(done_i_i_1_n_0));
  LUT5 #(
    .INIT(32'h00000001)) 
    done_i_i_2
       (.I0(rready_m),
        .I1(bready_m),
        .I2(wvalid_m),
        .I3(arvalid_m),
        .I4(awvalid_m),
        .O(done_i_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hEAAAAAAA)) 
    done_i_i_3
       (.I0(rom_eof),
        .I1(\status[1]_i_9_n_0 ),
        .I2(\status[1]_i_8_n_0 ),
        .I3(\awaddr_m[31]_i_6_n_0 ),
        .I4(\awaddr_m[31]_i_5_n_0 ),
        .O(done_i_i_3_n_0));
  FDRE done_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(done_i_i_1_n_0),
        .Q(done_i),
        .R(s_axi_aresetn_0));
  FDRE done_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(done_i),
        .Q(done),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hF0F7F7F70F080808)) 
    first_tran_done_i_1
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(arvalid_m),
        .I4(m_axi_lite_ch1_arready),
        .I5(first_tran_done),
        .O(first_tran_done_i_1_n_0));
  FDRE first_tran_done_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(first_tran_done_i_1_n_0),
        .Q(first_tran_done),
        .R(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    m_axi_lite_ch1_arvalid_INST_0
       (.I0(arvalid_m),
        .I1(rom_eof0),
        .O(m_axi_lite_ch1_arvalid));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    m_axi_lite_ch1_awvalid_INST_0
       (.I0(awvalid_m),
        .I1(rom_eof0),
        .O(m_axi_lite_ch1_awvalid));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    m_axi_lite_ch1_bready_INST_0
       (.I0(bready_m),
        .I1(rom_eof0),
        .O(m_axi_lite_ch1_bready));
  LUT2 #(
    .INIT(4'h2)) 
    m_axi_lite_ch1_rready_INST_0
       (.I0(rready_m),
        .I1(rom_eof0),
        .O(m_axi_lite_ch1_rready));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    m_axi_lite_ch1_wvalid_INST_0
       (.I0(wvalid_m),
        .I1(rom_eof0),
        .O(m_axi_lite_ch1_wvalid));
  CARRY4 max_retry_cntr2_carry
       (.CI(1'b0),
        .CO({max_retry_cntr2_carry_n_0,max_retry_cntr2_carry_n_1,max_retry_cntr2_carry_n_2,max_retry_cntr2_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_max_retry_cntr2_carry_O_UNCONNECTED[3:0]),
        .S({max_retry_cntr2_carry_i_1_n_0,max_retry_cntr2_carry_i_2_n_0,max_retry_cntr2_carry_i_3_n_0,max_retry_cntr2_carry_i_4_n_0}));
  CARRY4 max_retry_cntr2_carry__0
       (.CI(max_retry_cntr2_carry_n_0),
        .CO({max_retry_cntr2_carry__0_n_0,max_retry_cntr2_carry__0_n_1,max_retry_cntr2_carry__0_n_2,max_retry_cntr2_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_max_retry_cntr2_carry__0_O_UNCONNECTED[3:0]),
        .S({max_retry_cntr2_carry__0_i_1_n_0,max_retry_cntr2_carry__0_i_2_n_0,max_retry_cntr2_carry__0_i_3_n_0,max_retry_cntr2_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__0_i_1
       (.I0(cur_trn_addr[22]),
        .I1(\new_trn_addr_reg_n_0_[22] ),
        .I2(cur_trn_addr[21]),
        .I3(\new_trn_addr_reg_n_0_[21] ),
        .I4(cur_trn_addr[23]),
        .I5(\new_trn_addr_reg_n_0_[23] ),
        .O(max_retry_cntr2_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__0_i_2
       (.I0(cur_trn_addr[18]),
        .I1(\new_trn_addr_reg_n_0_[18] ),
        .I2(cur_trn_addr[20]),
        .I3(\new_trn_addr_reg_n_0_[20] ),
        .I4(cur_trn_addr[19]),
        .I5(\new_trn_addr_reg_n_0_[19] ),
        .O(max_retry_cntr2_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__0_i_3
       (.I0(cur_trn_addr[16]),
        .I1(\new_trn_addr_reg_n_0_[16] ),
        .I2(cur_trn_addr[15]),
        .I3(\new_trn_addr_reg_n_0_[15] ),
        .I4(cur_trn_addr[17]),
        .I5(\new_trn_addr_reg_n_0_[17] ),
        .O(max_retry_cntr2_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__0_i_4
       (.I0(cur_trn_addr[13]),
        .I1(\new_trn_addr_reg_n_0_[13] ),
        .I2(cur_trn_addr[12]),
        .I3(\new_trn_addr_reg_n_0_[12] ),
        .I4(cur_trn_addr[14]),
        .I5(\new_trn_addr_reg_n_0_[14] ),
        .O(max_retry_cntr2_carry__0_i_4_n_0));
  CARRY4 max_retry_cntr2_carry__1
       (.CI(max_retry_cntr2_carry__0_n_0),
        .CO({NLW_max_retry_cntr2_carry__1_CO_UNCONNECTED[3],max_retry_cntr2_carry__1_n_1,max_retry_cntr2_carry__1_n_2,max_retry_cntr2_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_max_retry_cntr2_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,max_retry_cntr2_carry__1_i_1_n_0,max_retry_cntr2_carry__1_i_2_n_0,max_retry_cntr2_carry__1_i_3_n_0}));
  LUT4 #(
    .INIT(16'h9009)) 
    max_retry_cntr2_carry__1_i_1
       (.I0(cur_trn_addr[31]),
        .I1(\new_trn_addr_reg_n_0_[31] ),
        .I2(cur_trn_addr[30]),
        .I3(\new_trn_addr_reg_n_0_[30] ),
        .O(max_retry_cntr2_carry__1_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__1_i_2
       (.I0(cur_trn_addr[28]),
        .I1(\new_trn_addr_reg_n_0_[28] ),
        .I2(cur_trn_addr[27]),
        .I3(\new_trn_addr_reg_n_0_[27] ),
        .I4(cur_trn_addr[29]),
        .I5(\new_trn_addr_reg_n_0_[29] ),
        .O(max_retry_cntr2_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry__1_i_3
       (.I0(cur_trn_addr[25]),
        .I1(\new_trn_addr_reg_n_0_[25] ),
        .I2(cur_trn_addr[24]),
        .I3(\new_trn_addr_reg_n_0_[24] ),
        .I4(cur_trn_addr[26]),
        .I5(\new_trn_addr_reg_n_0_[26] ),
        .O(max_retry_cntr2_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry_i_1
       (.I0(cur_trn_addr[10]),
        .I1(\new_trn_addr_reg_n_0_[10] ),
        .I2(cur_trn_addr[9]),
        .I3(\new_trn_addr_reg_n_0_[9] ),
        .I4(cur_trn_addr[11]),
        .I5(\new_trn_addr_reg_n_0_[11] ),
        .O(max_retry_cntr2_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry_i_2
       (.I0(cur_trn_addr[7]),
        .I1(\new_trn_addr_reg_n_0_[7] ),
        .I2(cur_trn_addr[6]),
        .I3(\new_trn_addr_reg_n_0_[6] ),
        .I4(cur_trn_addr[8]),
        .I5(\new_trn_addr_reg_n_0_[8] ),
        .O(max_retry_cntr2_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry_i_3
       (.I0(cur_trn_addr[3]),
        .I1(\new_trn_addr_reg_n_0_[3] ),
        .I2(cur_trn_addr[5]),
        .I3(\new_trn_addr_reg_n_0_[5] ),
        .I4(cur_trn_addr[4]),
        .I5(\new_trn_addr_reg_n_0_[4] ),
        .O(max_retry_cntr2_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    max_retry_cntr2_carry_i_4
       (.I0(cur_trn_addr[0]),
        .I1(\new_trn_addr_reg_n_0_[0] ),
        .I2(cur_trn_addr[2]),
        .I3(\new_trn_addr_reg_n_0_[2] ),
        .I4(cur_trn_addr[1]),
        .I5(\new_trn_addr_reg_n_0_[1] ),
        .O(max_retry_cntr2_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'hFDDDFFDDFFDDFDDD)) 
    \max_retry_cntr[0]_i_1 
       (.I0(s_axi_aresetn),
        .I1(\max_retry_cntr[0]_i_4_n_0 ),
        .I2(\max_retry_cntr[0]_i_5_n_0 ),
        .I3(max_retry_cntr0),
        .I4(\cur_trn_type_reg_n_0_[0] ),
        .I5(new_trn_type[0]),
        .O(\max_retry_cntr[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00F8008800000000)) 
    \max_retry_cntr[0]_i_2 
       (.I0(bready_m),
        .I1(m_axi_lite_ch1_bvalid),
        .I2(rready_m),
        .I3(rom_eof0),
        .I4(m_axi_lite_ch1_rvalid),
        .I5(start_retry_check),
        .O(max_retry_cntr0));
  LUT6 #(
    .INIT(64'h002F2F2F00000000)) 
    \max_retry_cntr[0]_i_4 
       (.I0(\cur_trn_type_reg_n_0_[1] ),
        .I1(new_trn_type[1]),
        .I2(max_retry_cntr2_carry__1_n_1),
        .I3(\max_retry_cntr_reg[31]_0 ),
        .I4(\max_retry_cntr_reg[31]_1 ),
        .I5(start_retry_check),
        .O(\max_retry_cntr[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \max_retry_cntr[0]_i_5 
       (.I0(new_trn_type[1]),
        .I1(\cur_trn_type_reg_n_0_[1] ),
        .O(\max_retry_cntr[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \max_retry_cntr[0]_i_6 
       (.I0(max_retry_cntr_reg[0]),
        .O(\max_retry_cntr[0]_i_6_n_0 ));
  FDRE \max_retry_cntr_reg[0] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[0]_i_3_n_7 ),
        .Q(max_retry_cntr_reg[0]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\max_retry_cntr_reg[0]_i_3_n_0 ,\max_retry_cntr_reg[0]_i_3_n_1 ,\max_retry_cntr_reg[0]_i_3_n_2 ,\max_retry_cntr_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\max_retry_cntr_reg[0]_i_3_n_4 ,\max_retry_cntr_reg[0]_i_3_n_5 ,\max_retry_cntr_reg[0]_i_3_n_6 ,\max_retry_cntr_reg[0]_i_3_n_7 }),
        .S({max_retry_cntr_reg[3:1],\max_retry_cntr[0]_i_6_n_0 }));
  FDRE \max_retry_cntr_reg[10] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[8]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[10]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[11] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[8]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[11]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[12] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[12]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[12]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[12]_i_1 
       (.CI(\max_retry_cntr_reg[8]_i_1_n_0 ),
        .CO({\max_retry_cntr_reg[12]_i_1_n_0 ,\max_retry_cntr_reg[12]_i_1_n_1 ,\max_retry_cntr_reg[12]_i_1_n_2 ,\max_retry_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[12]_i_1_n_4 ,\max_retry_cntr_reg[12]_i_1_n_5 ,\max_retry_cntr_reg[12]_i_1_n_6 ,\max_retry_cntr_reg[12]_i_1_n_7 }),
        .S(max_retry_cntr_reg[15:12]));
  FDRE \max_retry_cntr_reg[13] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[12]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[13]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[14] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[12]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[14]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[15] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[12]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[15]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[16] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[16]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[16]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[16]_i_1 
       (.CI(\max_retry_cntr_reg[12]_i_1_n_0 ),
        .CO({\max_retry_cntr_reg[16]_i_1_n_0 ,\max_retry_cntr_reg[16]_i_1_n_1 ,\max_retry_cntr_reg[16]_i_1_n_2 ,\max_retry_cntr_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[16]_i_1_n_4 ,\max_retry_cntr_reg[16]_i_1_n_5 ,\max_retry_cntr_reg[16]_i_1_n_6 ,\max_retry_cntr_reg[16]_i_1_n_7 }),
        .S(max_retry_cntr_reg[19:16]));
  FDRE \max_retry_cntr_reg[17] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[16]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[17]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[18] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[16]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[18]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[19] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[16]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[19]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[1] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[0]_i_3_n_6 ),
        .Q(max_retry_cntr_reg[1]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[20] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[20]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[20]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[20]_i_1 
       (.CI(\max_retry_cntr_reg[16]_i_1_n_0 ),
        .CO({\max_retry_cntr_reg[20]_i_1_n_0 ,\max_retry_cntr_reg[20]_i_1_n_1 ,\max_retry_cntr_reg[20]_i_1_n_2 ,\max_retry_cntr_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[20]_i_1_n_4 ,\max_retry_cntr_reg[20]_i_1_n_5 ,\max_retry_cntr_reg[20]_i_1_n_6 ,\max_retry_cntr_reg[20]_i_1_n_7 }),
        .S(max_retry_cntr_reg[23:20]));
  FDRE \max_retry_cntr_reg[21] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[20]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[21]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[22] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[20]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[22]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[23] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[20]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[23]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[24] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[24]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[24]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[24]_i_1 
       (.CI(\max_retry_cntr_reg[20]_i_1_n_0 ),
        .CO({\max_retry_cntr_reg[24]_i_1_n_0 ,\max_retry_cntr_reg[24]_i_1_n_1 ,\max_retry_cntr_reg[24]_i_1_n_2 ,\max_retry_cntr_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[24]_i_1_n_4 ,\max_retry_cntr_reg[24]_i_1_n_5 ,\max_retry_cntr_reg[24]_i_1_n_6 ,\max_retry_cntr_reg[24]_i_1_n_7 }),
        .S(max_retry_cntr_reg[27:24]));
  FDRE \max_retry_cntr_reg[25] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[24]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[25]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[26] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[24]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[26]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[27] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[24]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[27]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[28] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[28]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[28]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[28]_i_1 
       (.CI(\max_retry_cntr_reg[24]_i_1_n_0 ),
        .CO({\NLW_max_retry_cntr_reg[28]_i_1_CO_UNCONNECTED [3],\max_retry_cntr_reg[28]_i_1_n_1 ,\max_retry_cntr_reg[28]_i_1_n_2 ,\max_retry_cntr_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[28]_i_1_n_4 ,\max_retry_cntr_reg[28]_i_1_n_5 ,\max_retry_cntr_reg[28]_i_1_n_6 ,\max_retry_cntr_reg[28]_i_1_n_7 }),
        .S(max_retry_cntr_reg[31:28]));
  FDRE \max_retry_cntr_reg[29] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[28]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[29]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[2] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[0]_i_3_n_5 ),
        .Q(max_retry_cntr_reg[2]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[30] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[28]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[30]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[31] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[28]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[31]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[3] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[0]_i_3_n_4 ),
        .Q(max_retry_cntr_reg[3]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[4] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[4]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[4]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[4]_i_1 
       (.CI(\max_retry_cntr_reg[0]_i_3_n_0 ),
        .CO({\max_retry_cntr_reg[4]_i_1_n_0 ,\max_retry_cntr_reg[4]_i_1_n_1 ,\max_retry_cntr_reg[4]_i_1_n_2 ,\max_retry_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[4]_i_1_n_4 ,\max_retry_cntr_reg[4]_i_1_n_5 ,\max_retry_cntr_reg[4]_i_1_n_6 ,\max_retry_cntr_reg[4]_i_1_n_7 }),
        .S(max_retry_cntr_reg[7:4]));
  FDRE \max_retry_cntr_reg[5] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[4]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[5]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[6] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[4]_i_1_n_5 ),
        .Q(max_retry_cntr_reg[6]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[7] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[4]_i_1_n_4 ),
        .Q(max_retry_cntr_reg[7]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  FDRE \max_retry_cntr_reg[8] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[8]_i_1_n_7 ),
        .Q(max_retry_cntr_reg[8]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_retry_cntr_reg[8]_i_1 
       (.CI(\max_retry_cntr_reg[4]_i_1_n_0 ),
        .CO({\max_retry_cntr_reg[8]_i_1_n_0 ,\max_retry_cntr_reg[8]_i_1_n_1 ,\max_retry_cntr_reg[8]_i_1_n_2 ,\max_retry_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_retry_cntr_reg[8]_i_1_n_4 ,\max_retry_cntr_reg[8]_i_1_n_5 ,\max_retry_cntr_reg[8]_i_1_n_6 ,\max_retry_cntr_reg[8]_i_1_n_7 }),
        .S(max_retry_cntr_reg[11:8]));
  FDRE \max_retry_cntr_reg[9] 
       (.C(s_axi_aclk),
        .CE(max_retry_cntr0),
        .D(\max_retry_cntr_reg[8]_i_1_n_6 ),
        .Q(max_retry_cntr_reg[9]),
        .R(\max_retry_cntr[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \max_test_time_cntr[0]_i_1 
       (.I0(\awaddr_m[31]_i_3_n_0 ),
        .O(\max_test_time_cntr[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \max_test_time_cntr[0]_i_3 
       (.I0(max_test_time_cntr_reg[0]),
        .O(\max_test_time_cntr[0]_i_3_n_0 ));
  FDRE \max_test_time_cntr_reg[0] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[0]_i_2_n_7 ),
        .Q(max_test_time_cntr_reg[0]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\max_test_time_cntr_reg[0]_i_2_n_0 ,\max_test_time_cntr_reg[0]_i_2_n_1 ,\max_test_time_cntr_reg[0]_i_2_n_2 ,\max_test_time_cntr_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\max_test_time_cntr_reg[0]_i_2_n_4 ,\max_test_time_cntr_reg[0]_i_2_n_5 ,\max_test_time_cntr_reg[0]_i_2_n_6 ,\max_test_time_cntr_reg[0]_i_2_n_7 }),
        .S({max_test_time_cntr_reg[3:1],\max_test_time_cntr[0]_i_3_n_0 }));
  FDRE \max_test_time_cntr_reg[10] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[8]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[10]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[11] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[8]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[11]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[12] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[12]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[12]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[12]_i_1 
       (.CI(\max_test_time_cntr_reg[8]_i_1_n_0 ),
        .CO({\max_test_time_cntr_reg[12]_i_1_n_0 ,\max_test_time_cntr_reg[12]_i_1_n_1 ,\max_test_time_cntr_reg[12]_i_1_n_2 ,\max_test_time_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[12]_i_1_n_4 ,\max_test_time_cntr_reg[12]_i_1_n_5 ,\max_test_time_cntr_reg[12]_i_1_n_6 ,\max_test_time_cntr_reg[12]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[15:12]));
  FDRE \max_test_time_cntr_reg[13] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[12]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[13]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[14] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[12]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[14]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[15] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[12]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[15]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[16] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[16]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[16]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[16]_i_1 
       (.CI(\max_test_time_cntr_reg[12]_i_1_n_0 ),
        .CO({\max_test_time_cntr_reg[16]_i_1_n_0 ,\max_test_time_cntr_reg[16]_i_1_n_1 ,\max_test_time_cntr_reg[16]_i_1_n_2 ,\max_test_time_cntr_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[16]_i_1_n_4 ,\max_test_time_cntr_reg[16]_i_1_n_5 ,\max_test_time_cntr_reg[16]_i_1_n_6 ,\max_test_time_cntr_reg[16]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[19:16]));
  FDRE \max_test_time_cntr_reg[17] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[16]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[17]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[18] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[16]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[18]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[19] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[16]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[19]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[1] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[0]_i_2_n_6 ),
        .Q(max_test_time_cntr_reg[1]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[20] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[20]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[20]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[20]_i_1 
       (.CI(\max_test_time_cntr_reg[16]_i_1_n_0 ),
        .CO({\max_test_time_cntr_reg[20]_i_1_n_0 ,\max_test_time_cntr_reg[20]_i_1_n_1 ,\max_test_time_cntr_reg[20]_i_1_n_2 ,\max_test_time_cntr_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[20]_i_1_n_4 ,\max_test_time_cntr_reg[20]_i_1_n_5 ,\max_test_time_cntr_reg[20]_i_1_n_6 ,\max_test_time_cntr_reg[20]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[23:20]));
  FDRE \max_test_time_cntr_reg[21] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[20]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[21]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[22] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[20]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[22]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[23] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[20]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[23]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[24] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[24]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[24]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[24]_i_1 
       (.CI(\max_test_time_cntr_reg[20]_i_1_n_0 ),
        .CO({\max_test_time_cntr_reg[24]_i_1_n_0 ,\max_test_time_cntr_reg[24]_i_1_n_1 ,\max_test_time_cntr_reg[24]_i_1_n_2 ,\max_test_time_cntr_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[24]_i_1_n_4 ,\max_test_time_cntr_reg[24]_i_1_n_5 ,\max_test_time_cntr_reg[24]_i_1_n_6 ,\max_test_time_cntr_reg[24]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[27:24]));
  FDRE \max_test_time_cntr_reg[25] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[24]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[25]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[26] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[24]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[26]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[27] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[24]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[27]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[28] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[28]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[28]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[28]_i_1 
       (.CI(\max_test_time_cntr_reg[24]_i_1_n_0 ),
        .CO({\NLW_max_test_time_cntr_reg[28]_i_1_CO_UNCONNECTED [3],\max_test_time_cntr_reg[28]_i_1_n_1 ,\max_test_time_cntr_reg[28]_i_1_n_2 ,\max_test_time_cntr_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[28]_i_1_n_4 ,\max_test_time_cntr_reg[28]_i_1_n_5 ,\max_test_time_cntr_reg[28]_i_1_n_6 ,\max_test_time_cntr_reg[28]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[31:28]));
  FDRE \max_test_time_cntr_reg[29] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[28]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[29]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[2] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[0]_i_2_n_5 ),
        .Q(max_test_time_cntr_reg[2]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[30] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[28]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[30]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[31] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[28]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[31]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[3] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[0]_i_2_n_4 ),
        .Q(max_test_time_cntr_reg[3]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[4] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[4]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[4]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[4]_i_1 
       (.CI(\max_test_time_cntr_reg[0]_i_2_n_0 ),
        .CO({\max_test_time_cntr_reg[4]_i_1_n_0 ,\max_test_time_cntr_reg[4]_i_1_n_1 ,\max_test_time_cntr_reg[4]_i_1_n_2 ,\max_test_time_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[4]_i_1_n_4 ,\max_test_time_cntr_reg[4]_i_1_n_5 ,\max_test_time_cntr_reg[4]_i_1_n_6 ,\max_test_time_cntr_reg[4]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[7:4]));
  FDRE \max_test_time_cntr_reg[5] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[4]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[5]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[6] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[4]_i_1_n_5 ),
        .Q(max_test_time_cntr_reg[6]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[7] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[4]_i_1_n_4 ),
        .Q(max_test_time_cntr_reg[7]),
        .R(s_axi_aresetn_0));
  FDRE \max_test_time_cntr_reg[8] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[8]_i_1_n_7 ),
        .Q(max_test_time_cntr_reg[8]),
        .R(s_axi_aresetn_0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \max_test_time_cntr_reg[8]_i_1 
       (.CI(\max_test_time_cntr_reg[4]_i_1_n_0 ),
        .CO({\max_test_time_cntr_reg[8]_i_1_n_0 ,\max_test_time_cntr_reg[8]_i_1_n_1 ,\max_test_time_cntr_reg[8]_i_1_n_2 ,\max_test_time_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\max_test_time_cntr_reg[8]_i_1_n_4 ,\max_test_time_cntr_reg[8]_i_1_n_5 ,\max_test_time_cntr_reg[8]_i_1_n_6 ,\max_test_time_cntr_reg[8]_i_1_n_7 }),
        .S(max_test_time_cntr_reg[11:8]));
  FDRE \max_test_time_cntr_reg[9] 
       (.C(s_axi_aclk),
        .CE(\max_test_time_cntr[0]_i_1_n_0 ),
        .D(\max_test_time_cntr_reg[8]_i_1_n_6 ),
        .Q(max_test_time_cntr_reg[9]),
        .R(s_axi_aresetn_0));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[0]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[0]),
        .I4(m_axi_lite_ch1_araddr[0]),
        .O(new_trn_addr[0]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[10]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[10]),
        .I4(m_axi_lite_ch1_araddr[10]),
        .O(new_trn_addr[10]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[11]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[11]),
        .I4(m_axi_lite_ch1_araddr[11]),
        .O(new_trn_addr[11]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[12]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[12]),
        .I4(m_axi_lite_ch1_araddr[12]),
        .O(new_trn_addr[12]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[13]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[13]),
        .I4(m_axi_lite_ch1_araddr[13]),
        .O(new_trn_addr[13]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[14]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[14]),
        .I4(m_axi_lite_ch1_araddr[14]),
        .O(new_trn_addr[14]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[15]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[15]),
        .I4(m_axi_lite_ch1_araddr[15]),
        .O(new_trn_addr[15]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[16]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[16]),
        .I4(m_axi_lite_ch1_araddr[16]),
        .O(new_trn_addr[16]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[17]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[17]),
        .I4(m_axi_lite_ch1_araddr[17]),
        .O(new_trn_addr[17]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[18]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[18]),
        .I4(m_axi_lite_ch1_araddr[18]),
        .O(new_trn_addr[18]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[19]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[19]),
        .I4(m_axi_lite_ch1_araddr[19]),
        .O(new_trn_addr[19]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[1]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[1]),
        .I4(m_axi_lite_ch1_araddr[1]),
        .O(new_trn_addr[1]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[20]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[20]),
        .I4(m_axi_lite_ch1_araddr[20]),
        .O(new_trn_addr[20]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[21]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[21]),
        .I4(m_axi_lite_ch1_araddr[21]),
        .O(new_trn_addr[21]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[22]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[22]),
        .I4(m_axi_lite_ch1_araddr[22]),
        .O(new_trn_addr[22]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[23]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[23]),
        .I4(m_axi_lite_ch1_araddr[23]),
        .O(new_trn_addr[23]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[24]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[24]),
        .I4(m_axi_lite_ch1_araddr[24]),
        .O(new_trn_addr[24]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[25]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[25]),
        .I4(m_axi_lite_ch1_araddr[25]),
        .O(new_trn_addr[25]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[26]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[26]),
        .I4(m_axi_lite_ch1_araddr[26]),
        .O(new_trn_addr[26]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[27]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[27]),
        .I4(m_axi_lite_ch1_araddr[27]),
        .O(new_trn_addr[27]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[28]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[28]),
        .I4(m_axi_lite_ch1_araddr[28]),
        .O(new_trn_addr[28]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[29]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[29]),
        .I4(m_axi_lite_ch1_araddr[29]),
        .O(new_trn_addr[29]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[2]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[2]),
        .I4(m_axi_lite_ch1_araddr[2]),
        .O(new_trn_addr[2]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[30]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[30]),
        .I4(m_axi_lite_ch1_araddr[30]),
        .O(new_trn_addr[30]));
  LUT6 #(
    .INIT(64'h0F08080800000000)) 
    \new_trn_addr[31]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(arvalid_m),
        .I4(m_axi_lite_ch1_arready),
        .I5(first_tran_done),
        .O(\new_trn_addr[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[31]_i_2 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[31]),
        .I4(m_axi_lite_ch1_araddr[31]),
        .O(new_trn_addr[31]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[3]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[3]),
        .I4(m_axi_lite_ch1_araddr[3]),
        .O(new_trn_addr[3]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[4]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[4]),
        .I4(m_axi_lite_ch1_araddr[4]),
        .O(new_trn_addr[4]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[5]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[5]),
        .I4(m_axi_lite_ch1_araddr[5]),
        .O(new_trn_addr[5]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[6]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[6]),
        .I4(m_axi_lite_ch1_araddr[6]),
        .O(new_trn_addr[6]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[7]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[7]),
        .I4(m_axi_lite_ch1_araddr[7]),
        .O(new_trn_addr[7]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[8]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[8]),
        .I4(m_axi_lite_ch1_araddr[8]),
        .O(new_trn_addr[8]));
  LUT5 #(
    .INIT(32'hFFF70800)) 
    \new_trn_addr[9]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_awaddr[9]),
        .I4(m_axi_lite_ch1_araddr[9]),
        .O(new_trn_addr[9]));
  FDRE \new_trn_addr_reg[0] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[0]),
        .Q(\new_trn_addr_reg_n_0_[0] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[10] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[10]),
        .Q(\new_trn_addr_reg_n_0_[10] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[11] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[11]),
        .Q(\new_trn_addr_reg_n_0_[11] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[12] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[12]),
        .Q(\new_trn_addr_reg_n_0_[12] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[13] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[13]),
        .Q(\new_trn_addr_reg_n_0_[13] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[14] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[14]),
        .Q(\new_trn_addr_reg_n_0_[14] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[15] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[15]),
        .Q(\new_trn_addr_reg_n_0_[15] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[16] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[16]),
        .Q(\new_trn_addr_reg_n_0_[16] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[17] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[17]),
        .Q(\new_trn_addr_reg_n_0_[17] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[18] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[18]),
        .Q(\new_trn_addr_reg_n_0_[18] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[19] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[19]),
        .Q(\new_trn_addr_reg_n_0_[19] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[1] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[1]),
        .Q(\new_trn_addr_reg_n_0_[1] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[20] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[20]),
        .Q(\new_trn_addr_reg_n_0_[20] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[21] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[21]),
        .Q(\new_trn_addr_reg_n_0_[21] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[22] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[22]),
        .Q(\new_trn_addr_reg_n_0_[22] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[23] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[23]),
        .Q(\new_trn_addr_reg_n_0_[23] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[24] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[24]),
        .Q(\new_trn_addr_reg_n_0_[24] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[25] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[25]),
        .Q(\new_trn_addr_reg_n_0_[25] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[26] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[26]),
        .Q(\new_trn_addr_reg_n_0_[26] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[27] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[27]),
        .Q(\new_trn_addr_reg_n_0_[27] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[28] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[28]),
        .Q(\new_trn_addr_reg_n_0_[28] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[29] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[29]),
        .Q(\new_trn_addr_reg_n_0_[29] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[2] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[2]),
        .Q(\new_trn_addr_reg_n_0_[2] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[30] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[30]),
        .Q(\new_trn_addr_reg_n_0_[30] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[31] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[31]),
        .Q(\new_trn_addr_reg_n_0_[31] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[3] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[3]),
        .Q(\new_trn_addr_reg_n_0_[3] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[4] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[4]),
        .Q(\new_trn_addr_reg_n_0_[4] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[5] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[5]),
        .Q(\new_trn_addr_reg_n_0_[5] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[6] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[6]),
        .Q(\new_trn_addr_reg_n_0_[6] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[7] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[7]),
        .Q(\new_trn_addr_reg_n_0_[7] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[8] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[8]),
        .Q(\new_trn_addr_reg_n_0_[8] ),
        .R(s_axi_aresetn_0));
  FDRE \new_trn_addr_reg[9] 
       (.C(s_axi_aclk),
        .CE(\new_trn_addr[31]_i_1_n_0 ),
        .D(new_trn_addr[9]),
        .Q(\new_trn_addr_reg_n_0_[9] ),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'h08FF000008000000)) 
    \new_trn_type[0]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(\new_trn_addr[31]_i_1_n_0 ),
        .I4(s_axi_aresetn),
        .I5(new_trn_type[0]),
        .O(\new_trn_type[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF7FF0000F7000000)) 
    \new_trn_type[1]_i_1 
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(\new_trn_addr[31]_i_1_n_0 ),
        .I4(s_axi_aresetn),
        .I5(new_trn_type[1]),
        .O(\new_trn_type[1]_i_1_n_0 ));
  FDRE \new_trn_type_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\new_trn_type[0]_i_1_n_0 ),
        .Q(new_trn_type[0]),
        .R(1'b0));
  FDRE \new_trn_type_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\new_trn_type[1]_i_1_n_0 ),
        .Q(new_trn_type[1]),
        .R(1'b0));
  FDRE r_complete_2ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(r_complete_ff),
        .Q(r_complete_2ff),
        .R(s_axi_aresetn_0));
  FDRE r_complete_3ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(r_complete_2ff),
        .Q(r_complete_3ff),
        .R(s_axi_aresetn_0));
  FDRE r_complete_ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(r_complete),
        .Q(r_complete_ff),
        .R(s_axi_aresetn_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check1_carry
       (.CI(1'b0),
        .CO({rd_check1_carry_n_0,rd_check1_carry_n_1,rd_check1_carry_n_2,rd_check1_carry_n_3}),
        .CYINIT(1'b0),
        .DI(rd_check1_carry__0_0),
        .O(NLW_rd_check1_carry_O_UNCONNECTED[3:0]),
        .S(rd_check1_carry__0_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check1_carry__0
       (.CI(rd_check1_carry_n_0),
        .CO({rd_check1_carry__0_n_0,rd_check1_carry__0_n_1,rd_check1_carry__0_n_2,rd_check1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(rd_check1_carry__1_0),
        .O(NLW_rd_check1_carry__0_O_UNCONNECTED[3:0]),
        .S(rd_check1_carry__1_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check1_carry__1
       (.CI(rd_check1_carry__0_n_0),
        .CO({rd_check1_carry__1_n_0,rd_check1_carry__1_n_1,rd_check1_carry__1_n_2,rd_check1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(rd_check1_carry__2_0),
        .O(NLW_rd_check1_carry__1_O_UNCONNECTED[3:0]),
        .S(rd_check1_carry__2_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check1_carry__2
       (.CI(rd_check1_carry__1_n_0),
        .CO({\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,rd_check1_carry__2_n_1,rd_check1_carry__2_n_2,rd_check1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI(cur_trn_status_i_4_1),
        .O(NLW_rd_check1_carry__2_O_UNCONNECTED[3:0]),
        .S(cur_trn_status_i_4_2));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check2_carry
       (.CI(1'b0),
        .CO({rd_check2_carry_n_0,rd_check2_carry_n_1,rd_check2_carry_n_2,rd_check2_carry_n_3}),
        .CYINIT(1'b0),
        .DI(DI),
        .O(NLW_rd_check2_carry_O_UNCONNECTED[3:0]),
        .S(S));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check2_carry__0
       (.CI(rd_check2_carry_n_0),
        .CO({rd_check2_carry__0_n_0,rd_check2_carry__0_n_1,rd_check2_carry__0_n_2,rd_check2_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(rd_check2_carry__1_0),
        .O(NLW_rd_check2_carry__0_O_UNCONNECTED[3:0]),
        .S(rd_check2_carry__1_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check2_carry__1
       (.CI(rd_check2_carry__0_n_0),
        .CO({rd_check2_carry__1_n_0,rd_check2_carry__1_n_1,rd_check2_carry__1_n_2,rd_check2_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(rd_check2_carry__2_0),
        .O(NLW_rd_check2_carry__1_O_UNCONNECTED[3:0]),
        .S(rd_check2_carry__2_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 rd_check2_carry__2
       (.CI(rd_check2_carry__1_n_0),
        .CO({\m_axi_lite_ch1_rdata[30] ,rd_check2_carry__2_n_1,rd_check2_carry__2_n_2,rd_check2_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI(cur_trn_status_i_4),
        .O(NLW_rd_check2_carry__2_O_UNCONNECTED[3:0]),
        .S(cur_trn_status_i_4_0));
  CARRY4 \rd_check2_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\rd_check2_inferred__0/i__carry_n_0 ,\rd_check2_inferred__0/i__carry_n_1 ,\rd_check2_inferred__0/i__carry_n_2 ,\rd_check2_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_rd_check2_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S(\rd_check2_inferred__0/i__carry__0_0 ));
  CARRY4 \rd_check2_inferred__0/i__carry__0 
       (.CI(\rd_check2_inferred__0/i__carry_n_0 ),
        .CO({\rd_check2_inferred__0/i__carry__0_n_0 ,\rd_check2_inferred__0/i__carry__0_n_1 ,\rd_check2_inferred__0/i__carry__0_n_2 ,\rd_check2_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_rd_check2_inferred__0/i__carry__0_O_UNCONNECTED [3:0]),
        .S(\rd_check2_inferred__0/i__carry__1_0 ));
  CARRY4 \rd_check2_inferred__0/i__carry__1 
       (.CI(\rd_check2_inferred__0/i__carry__0_n_0 ),
        .CO({\NLW_rd_check2_inferred__0/i__carry__1_CO_UNCONNECTED [3],CO,\rd_check2_inferred__0/i__carry__1_n_2 ,\rd_check2_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_rd_check2_inferred__0/i__carry__1_O_UNCONNECTED [3:0]),
        .S({1'b0,cur_trn_status_i_3}));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    rom_eof_i_1
       (.I0(rom_eof0),
        .I1(rst_l_2ff),
        .I2(rom_eof),
        .O(rom_eof_i_1_n_0));
  FDRE rom_eof_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rom_eof_i_1_n_0),
        .Q(rom_eof),
        .R(s_axi_aresetn_0));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[0]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[0] ),
        .I1(rom_ptr_ff[0]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[1]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[1] ),
        .I1(rom_ptr_ff[1]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[2]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[2] ),
        .I1(rom_ptr_ff[2]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[3]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[3] ),
        .I1(rom_ptr_ff[3]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[4]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[4] ),
        .I1(rom_ptr_ff[4]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[5]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[5] ),
        .I1(rom_ptr_ff[5]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[6]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[6] ),
        .I1(rom_ptr_ff[6]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0A0C0)) 
    \rom_ptr_ff[7]_i_1 
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[7] ),
        .I1(rom_ptr_ff[7]),
        .I2(s_axi_aresetn),
        .I3(r_complete_2ff),
        .I4(b_complete_2ff),
        .O(\rom_ptr_ff[7]_i_1_n_0 ));
  FDRE \rom_ptr_ff_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[0]_i_1_n_0 ),
        .Q(rom_ptr_ff[0]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[1]_i_1_n_0 ),
        .Q(rom_ptr_ff[1]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[2]_i_1_n_0 ),
        .Q(rom_ptr_ff[2]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[3]_i_1_n_0 ),
        .Q(rom_ptr_ff[3]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[4]_i_1_n_0 ),
        .Q(rom_ptr_ff[4]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[5]_i_1_n_0 ),
        .Q(rom_ptr_ff[5]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[6]_i_1_n_0 ),
        .Q(rom_ptr_ff[6]),
        .R(1'b0));
  FDRE \rom_ptr_ff_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rom_ptr_ff[7]_i_1_n_0 ),
        .Q(rom_ptr_ff[7]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAA00AA00000808)) 
    rready_m_i_1
       (.I0(s_axi_aresetn),
        .I1(rready_m_i_2_n_0),
        .I2(\awaddr_m[31]_i_3_n_0 ),
        .I3(m_axi_lite_ch1_rvalid),
        .I4(rom_eof0),
        .I5(rready_m),
        .O(rready_m_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h0000FFF4)) 
    rready_m_i_2
       (.I0(rst_l_3ff),
        .I1(rst_l_2ff),
        .I2(r_complete_3ff),
        .I3(b_complete_3ff),
        .I4(douta[0]),
        .O(rready_m_i_2_n_0));
  FDRE rready_m_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rready_m_i_1_n_0),
        .Q(rready_m),
        .R(1'b0));
  FDRE rst_l_2ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rst_l_ff),
        .Q(rst_l_2ff),
        .R(1'b0));
  FDRE rst_l_3ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rst_l_2ff),
        .Q(rst_l_3ff),
        .R(1'b0));
  FDRE rst_l_ff_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_aresetn),
        .Q(rst_l_ff),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFF0F080808)) 
    start_retry_check_i_1
       (.I0(awvalid_m),
        .I1(m_axi_lite_ch1_awready),
        .I2(rom_eof0),
        .I3(arvalid_m),
        .I4(m_axi_lite_ch1_arready),
        .I5(start_retry_check),
        .O(start_retry_check_i_1_n_0));
  FDRE start_retry_check_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(start_retry_check_i_1_n_0),
        .Q(start_retry_check),
        .R(s_axi_aresetn_0));
  LUT4 #(
    .INIT(16'hFEEE)) 
    \status[0]_i_1 
       (.I0(\status[1]_i_4_n_0 ),
        .I1(\status[1]_i_3_n_0 ),
        .I2(\status[0]_i_2_n_0 ),
        .I3(\status[0]_i_3_n_0 ),
        .O(p_1_in[0]));
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_10 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [23]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [20]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [18]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [17]),
        .O(\status[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \status[0]_i_2 
       (.I0(\status[0]_i_4_n_0 ),
        .I1(\status[0]_i_5_n_0 ),
        .I2(\status[0]_i_6_n_0 ),
        .I3(\status[0]_i_7_n_0 ),
        .O(\status[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \status[0]_i_3 
       (.I0(\status[0]_i_8_n_0 ),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [7]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [3]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [9]),
        .I4(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [8]),
        .I5(\status[0]_i_9_n_0 ),
        .O(\status[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_4 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [13]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [10]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [6]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [5]),
        .O(\status[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_5 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [1]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [0]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [4]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [2]),
        .O(\status[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_6 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [22]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [21]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [19]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [15]),
        .O(\status[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_7 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [29]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [28]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [27]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [25]),
        .O(\status[0]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \status[0]_i_8 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [12]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [11]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [16]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [14]),
        .O(\status[0]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \status[0]_i_9 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [24]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [26]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [30]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [31]),
        .I4(\status[0]_i_10_n_0 ),
        .O(\status[0]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \status[1]_i_1 
       (.I0(\status[1]_i_2_n_0 ),
        .I1(\status[1]_i_3_n_0 ),
        .I2(\status[1]_i_4_n_0 ),
        .I3(\status[1]_i_5_n_0 ),
        .I4(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [31]),
        .I5(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [7]),
        .O(p_1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \status[1]_i_10 
       (.I0(max_test_time_cntr_reg[28]),
        .I1(max_test_time_cntr_reg[29]),
        .I2(max_test_time_cntr_reg[30]),
        .I3(max_test_time_cntr_reg[31]),
        .I4(\awaddr_m[31]_i_22_n_0 ),
        .O(\status[1]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00080000)) 
    \status[1]_i_11 
       (.I0(max_test_time_cntr_reg[18]),
        .I1(max_test_time_cntr_reg[19]),
        .I2(max_test_time_cntr_reg[0]),
        .I3(max_test_time_cntr_reg[2]),
        .I4(\awaddr_m[31]_i_20_n_0 ),
        .O(\status[1]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \status[1]_i_12 
       (.I0(max_test_time_cntr_reg[14]),
        .I1(max_test_time_cntr_reg[15]),
        .I2(max_test_time_cntr_reg[16]),
        .I3(max_test_time_cntr_reg[17]),
        .I4(\awaddr_m[31]_i_18_n_0 ),
        .O(\status[1]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \status[1]_i_13 
       (.I0(max_test_time_cntr_reg[4]),
        .I1(max_test_time_cntr_reg[5]),
        .I2(max_test_time_cntr_reg[1]),
        .I3(max_test_time_cntr_reg[3]),
        .I4(\awaddr_m[31]_i_16_n_0 ),
        .O(\status[1]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    \status[1]_i_2 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [26]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [3]),
        .I2(\status[0]_i_2_n_0 ),
        .I3(\status[1]_i_6_n_0 ),
        .I4(\status[1]_i_7_n_0 ),
        .O(\status[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \status[1]_i_3 
       (.I0(\awaddr_m[31]_i_5_n_0 ),
        .I1(\awaddr_m[31]_i_6_n_0 ),
        .I2(\status[1]_i_8_n_0 ),
        .I3(\status[1]_i_9_n_0 ),
        .O(\status[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \status[1]_i_4 
       (.I0(\status[1]_i_10_n_0 ),
        .I1(\status[1]_i_11_n_0 ),
        .I2(\status[1]_i_12_n_0 ),
        .I3(\status[1]_i_13_n_0 ),
        .O(\status[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \status[1]_i_5 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [14]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [16]),
        .O(\status[1]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \status[1]_i_6 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [18]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [12]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [9]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [11]),
        .O(\status[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \status[1]_i_7 
       (.I0(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [17]),
        .I1(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [23]),
        .I2(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [8]),
        .I3(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [20]),
        .I4(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [30]),
        .I5(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg__0 [24]),
        .O(\status[1]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \status[1]_i_8 
       (.I0(max_retry_cntr_reg[16]),
        .I1(max_retry_cntr_reg[17]),
        .I2(max_retry_cntr_reg[18]),
        .I3(max_retry_cntr_reg[19]),
        .I4(\awaddr_m[31]_i_14_n_0 ),
        .O(\status[1]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \status[1]_i_9 
       (.I0(max_retry_cntr_reg[6]),
        .I1(max_retry_cntr_reg[7]),
        .I2(max_retry_cntr_reg[4]),
        .I3(max_retry_cntr_reg[5]),
        .I4(\awaddr_m[31]_i_12_n_0 ),
        .O(\status[1]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \status[31]_i_1 
       (.I0(\awaddr_m[31]_i_3_n_0 ),
        .I1(done_i),
        .O(\status[31]_i_1_n_0 ));
  FDRE \status_reg[0] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(status[0]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[16] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [0]),
        .Q(status[10]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[17] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [1]),
        .Q(status[11]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[18] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [2]),
        .Q(status[12]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[19] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [3]),
        .Q(status[13]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[1] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(status[1]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[20] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [4]),
        .Q(status[14]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[21] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [5]),
        .Q(status[15]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[22] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [6]),
        .Q(status[16]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[23] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [7]),
        .Q(status[17]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[24] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [8]),
        .Q(status[18]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[25] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [9]),
        .Q(status[19]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[26] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [10]),
        .Q(status[20]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[27] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [11]),
        .Q(status[21]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[28] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [12]),
        .Q(status[22]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[29] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [13]),
        .Q(status[23]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[2] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[0] ),
        .Q(status[2]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[30] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [14]),
        .Q(status[24]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[31] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.test_err_cntr_reg [15]),
        .Q(status[25]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[3] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[1] ),
        .Q(status[3]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[4] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[2] ),
        .Q(status[4]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[5] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[3] ),
        .Q(status[5]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[6] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[4] ),
        .Q(status[6]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[7] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[5] ),
        .Q(status[7]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[8] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[6] ),
        .Q(status[8]),
        .R(s_axi_aresetn_0));
  FDRE \status_reg[9] 
       (.C(s_axi_aclk),
        .CE(\status[31]_i_1_n_0 ),
        .D(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[7] ),
        .Q(status[9]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[0] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [0]),
        .Q(m_axi_lite_ch1_wdata[0]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[10] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [10]),
        .Q(m_axi_lite_ch1_wdata[10]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[11] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [11]),
        .Q(m_axi_lite_ch1_wdata[11]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[12] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [12]),
        .Q(m_axi_lite_ch1_wdata[12]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[13] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [13]),
        .Q(m_axi_lite_ch1_wdata[13]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[14] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [14]),
        .Q(m_axi_lite_ch1_wdata[14]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[15] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [15]),
        .Q(m_axi_lite_ch1_wdata[15]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[16] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [16]),
        .Q(m_axi_lite_ch1_wdata[16]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[17] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [17]),
        .Q(m_axi_lite_ch1_wdata[17]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[18] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [18]),
        .Q(m_axi_lite_ch1_wdata[18]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[19] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [19]),
        .Q(m_axi_lite_ch1_wdata[19]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[1] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [1]),
        .Q(m_axi_lite_ch1_wdata[1]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[20] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [20]),
        .Q(m_axi_lite_ch1_wdata[20]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[21] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [21]),
        .Q(m_axi_lite_ch1_wdata[21]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[22] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [22]),
        .Q(m_axi_lite_ch1_wdata[22]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[23] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [23]),
        .Q(m_axi_lite_ch1_wdata[23]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[24] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [24]),
        .Q(m_axi_lite_ch1_wdata[24]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[25] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [25]),
        .Q(m_axi_lite_ch1_wdata[25]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[26] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [26]),
        .Q(m_axi_lite_ch1_wdata[26]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[27] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [27]),
        .Q(m_axi_lite_ch1_wdata[27]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[28] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [28]),
        .Q(m_axi_lite_ch1_wdata[28]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[29] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [29]),
        .Q(m_axi_lite_ch1_wdata[29]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[2] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [2]),
        .Q(m_axi_lite_ch1_wdata[2]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[30] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [30]),
        .Q(m_axi_lite_ch1_wdata[30]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[31] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [31]),
        .Q(m_axi_lite_ch1_wdata[31]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[3] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [3]),
        .Q(m_axi_lite_ch1_wdata[3]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[4] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [4]),
        .Q(m_axi_lite_ch1_wdata[4]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[5] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [5]),
        .Q(m_axi_lite_ch1_wdata[5]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[6] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [6]),
        .Q(m_axi_lite_ch1_wdata[6]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[7] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [7]),
        .Q(m_axi_lite_ch1_wdata[7]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[8] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [8]),
        .Q(m_axi_lite_ch1_wdata[8]),
        .R(s_axi_aresetn_0));
  FDRE \wdata_m_reg[9] 
       (.C(s_axi_aclk),
        .CE(launch_new_wr),
        .D(\wdata_m_reg[31]_0 [9]),
        .Q(m_axi_lite_ch1_wdata[9]),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hAAAA00AA00000808)) 
    wvalid_m_i_1
       (.I0(s_axi_aresetn),
        .I1(bready_m_i_2_n_0),
        .I2(\awaddr_m[31]_i_3_n_0 ),
        .I3(m_axi_lite_ch1_wready),
        .I4(rom_eof0),
        .I5(wvalid_m),
        .O(wvalid_m_i_1_n_0));
  FDRE wvalid_m_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(wvalid_m_i_1_n_0),
        .Q(wvalid_m),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_1
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[7] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[7]),
        .O(addra[7]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_2
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[6] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[6]),
        .O(addra[6]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_3
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[5] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[5]),
        .O(addra[5]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_4
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[4] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[4]),
        .O(addra[4]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_5
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[3] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[3]),
        .O(addra[3]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_6
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[2] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[2]),
        .O(addra[2]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_7
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[1] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[1]),
        .O(addra[1]));
  LUT4 #(
    .INIT(16'hABA8)) 
    xpm_memory_base_inst_i_8
       (.I0(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg_n_0_[0] ),
        .I1(b_complete_2ff),
        .I2(r_complete_2ff),
        .I3(rom_ptr_ff[0]),
        .O(addra[0]));
endmodule

module mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_top
   (m_axi_lite_ch1_awaddr,
    m_axi_lite_ch1_araddr,
    m_axi_lite_ch1_wdata,
    done,
    status,
    m_axi_lite_ch1_awvalid,
    m_axi_lite_ch1_wvalid,
    m_axi_lite_ch1_bready,
    m_axi_lite_ch1_arvalid,
    m_axi_lite_ch1_rready,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_bresp,
    m_axi_lite_ch1_rdata,
    m_axi_lite_ch1_awready,
    s_axi_aresetn,
    s_axi_aclk,
    m_axi_lite_ch1_arready,
    m_axi_lite_ch1_wready,
    m_axi_lite_ch1_rvalid,
    m_axi_lite_ch1_rresp);
  output [31:0]m_axi_lite_ch1_awaddr;
  output [31:0]m_axi_lite_ch1_araddr;
  output [31:0]m_axi_lite_ch1_wdata;
  output done;
  output [25:0]status;
  output m_axi_lite_ch1_awvalid;
  output m_axi_lite_ch1_wvalid;
  output m_axi_lite_ch1_bready;
  output m_axi_lite_ch1_arvalid;
  output m_axi_lite_ch1_rready;
  input m_axi_lite_ch1_bvalid;
  input [0:0]m_axi_lite_ch1_bresp;
  input [31:0]m_axi_lite_ch1_rdata;
  input m_axi_lite_ch1_awready;
  input s_axi_aresetn;
  input s_axi_aclk;
  input m_axi_lite_ch1_arready;
  input m_axi_lite_ch1_wready;
  input m_axi_lite_ch1_rvalid;
  input [1:0]m_axi_lite_ch1_rresp;

  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_10 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_11 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_2 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_3 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_4 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_5 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_6 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_7 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_8 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_9 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_32 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_33 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_34 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_35 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_36 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_37 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_38 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_39 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_40 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_41 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_42 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_43 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_44 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_45 ;
  wire \ATG_SYSINIT_DMG.systeminit_dmg_mask_n_46 ;
  wire b_complete;
  wire bready_m;
  wire done;
  wire [31:0]m_axi_lite_ch1_araddr;
  wire m_axi_lite_ch1_arready;
  wire m_axi_lite_ch1_arvalid;
  wire [31:0]m_axi_lite_ch1_awaddr;
  wire m_axi_lite_ch1_awready;
  wire m_axi_lite_ch1_awvalid;
  wire m_axi_lite_ch1_bready;
  wire [0:0]m_axi_lite_ch1_bresp;
  wire m_axi_lite_ch1_bvalid;
  wire [31:0]m_axi_lite_ch1_rdata;
  wire m_axi_lite_ch1_rready;
  wire [1:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rvalid;
  wire [31:0]m_axi_lite_ch1_wdata;
  wire m_axi_lite_ch1_wready;
  wire m_axi_lite_ch1_wvalid;
  wire r_complete;
  wire rd_check1;
  wire rd_check2;
  wire [31:0]rom_addr;
  wire [17:16]rom_ctrl;
  wire [31:0]rom_data;
  wire [7:0]rom_data_ptr_ff;
  wire rom_eof0;
  wire [31:0]rom_mask;
  wire rready_m;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire static_mrdwr_n_0;
  wire static_mrdwr_n_2;
  wire static_mrdwr_n_7;
  wire [25:0]status;
  wire systeminit_dmg_addr_n_33;
  wire systeminit_dmg_addr_n_34;
  wire systeminit_dmg_addr_n_36;
  wire systeminit_dmg_addr_n_38;
  wire systeminit_dmg_addr_n_39;
  wire systeminit_dmg_addr_n_40;
  wire systeminit_dmg_addr_n_41;
  wire systeminit_dmg_addr_n_42;
  wire systeminit_dmg_addr_n_43;
  wire systeminit_dmg_addr_n_44;
  wire systeminit_dmg_addr_n_45;
  wire systeminit_dmg_addr_n_46;
  wire systeminit_dmg_addr_n_47;
  wire systeminit_dmg_addr_n_48;
  wire systeminit_dmg_addr_n_49;
  wire systeminit_dmg_addr_n_50;
  wire systeminit_dmg_addr_n_51;
  wire systeminit_dmg_addr_n_52;
  wire systeminit_dmg_addr_n_53;
  wire systeminit_dmg_addr_n_54;
  wire systeminit_dmg_addr_n_55;
  wire systeminit_dmg_addr_n_56;
  wire systeminit_dmg_addr_n_57;
  wire systeminit_dmg_addr_n_58;
  wire systeminit_dmg_addr_n_59;
  wire systeminit_dmg_addr_n_60;
  wire systeminit_dmg_addr_n_61;
  wire systeminit_dmg_data_n_32;
  wire systeminit_dmg_data_n_33;
  wire systeminit_dmg_data_n_34;
  wire systeminit_dmg_data_n_35;
  wire systeminit_dmg_data_n_36;
  wire systeminit_dmg_data_n_37;
  wire systeminit_dmg_data_n_38;
  wire systeminit_dmg_data_n_39;
  wire systeminit_dmg_data_n_40;
  wire systeminit_dmg_data_n_41;
  wire systeminit_dmg_data_n_42;
  wire systeminit_dmg_data_n_43;
  wire systeminit_dmg_data_n_44;
  wire systeminit_dmg_data_n_45;
  wire systeminit_dmg_data_n_46;
  wire systeminit_dmg_data_n_47;
  wire systeminit_dmg_data_n_48;
  wire systeminit_dmg_data_n_49;
  wire systeminit_dmg_data_n_50;
  wire systeminit_dmg_data_n_51;
  wire systeminit_dmg_data_n_52;
  wire systeminit_dmg_data_n_53;
  wire systeminit_dmg_data_n_54;
  wire systeminit_dmg_data_n_55;
  wire systeminit_dmg_data_n_56;
  wire systeminit_dmg_data_n_57;
  wire systeminit_dmg_data_n_58;
  wire systeminit_dmg_data_n_59;
  wire systeminit_dmg_data_n_60;
  wire systeminit_dmg_data_n_61;
  wire systeminit_dmg_data_n_62;
  wire systeminit_dmg_data_n_63;
  wire systeminit_dmg_data_n_64;
  wire systeminit_dmg_data_n_65;
  wire systeminit_dmg_data_n_66;
  wire systeminit_dmg_data_n_67;
  wire systeminit_dmg_data_n_68;
  wire systeminit_dmg_data_n_69;
  wire systeminit_dmg_data_n_70;
  wire systeminit_dmg_data_n_71;
  wire systeminit_dmg_data_n_72;
  wire systeminit_dmg_data_n_73;
  wire systeminit_dmg_data_n_74;
  wire systeminit_dmg_data_n_75;
  wire systeminit_dmg_data_n_76;
  wire systeminit_dmg_data_n_77;
  wire systeminit_dmg_data_n_78;
  wire systeminit_dmg_data_n_79;
  wire systeminit_dmg_data_n_80;
  wire systeminit_dmg_data_n_81;
  wire systeminit_dmg_data_n_82;
  wire systeminit_dmg_data_n_83;
  wire systeminit_dmg_data_n_84;
  wire systeminit_dmg_data_n_85;
  wire systeminit_dmg_data_n_86;
  wire systeminit_dmg_data_n_87;
  wire systeminit_dmg_data_n_88;

  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized0 \ATG_SYSINIT_DMG.systeminit_dmg_ctrl 
       (.\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] (static_mrdwr_n_7),
        .CO(rd_check2),
        .D({\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_4 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_5 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_6 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_7 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_8 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_9 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_10 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_11 }),
        .addra(rom_data_ptr_ff),
        .cur_trn_status_reg(systeminit_dmg_addr_n_33),
        .cur_trn_status_reg_0(rd_check1),
        .cur_trn_status_reg_1(static_mrdwr_n_2),
        .douta(rom_ctrl),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] (\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_2 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 (static_mrdwr_n_0),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp[0]),
        .m_axi_lite_ch1_rresp_0_sp_1(\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_3 ),
        .s_axi_aclk(s_axi_aclk));
  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg \ATG_SYSINIT_DMG.systeminit_dmg_mask 
       (.DI(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_33 ),
        .S(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_41 ),
        .addra(rom_data_ptr_ff),
        .douta(rom_mask),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_36 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_34 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_35 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_40 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_38 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_43 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_45 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_46 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_42 ),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 (static_mrdwr_n_0),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_32 ),
        .m_axi_lite_ch1_rdata({m_axi_lite_ch1_rdata[31:29],m_axi_lite_ch1_rdata[27:26],m_axi_lite_ch1_rdata[23],m_axi_lite_ch1_rdata[21:20],m_axi_lite_ch1_rdata[17],m_axi_lite_ch1_rdata[15:14],m_axi_lite_ch1_rdata[11],m_axi_lite_ch1_rdata[9:8],m_axi_lite_ch1_rdata[5],m_axi_lite_ch1_rdata[3:2]}),
        .\m_axi_lite_ch1_rdata[21] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_39 ),
        .\m_axi_lite_ch1_rdata[27] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_44 ),
        .\m_axi_lite_ch1_rdata[9] (\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_37 ),
        .rd_check1_carry__2_i_1({rom_data[31:29],rom_data[27:26],rom_data[23],rom_data[21:20],rom_data[17],rom_data[15:14],rom_data[11],rom_data[9:8],rom_data[5],rom_data[3:2]}),
        .\rd_check2_inferred__0/i__carry__1 (systeminit_dmg_addr_n_53),
        .rom_eof0(rom_eof0),
        .s_axi_aclk(s_axi_aclk));
  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_mrdwr static_mrdwr
       (.\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[7]_0 ({\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_4 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_5 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_6 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_7 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_8 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_9 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_10 ,\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_11 }),
        .CO(rd_check2),
        .D(rom_addr),
        .DI({systeminit_dmg_data_n_40,systeminit_dmg_data_n_41,systeminit_dmg_data_n_42,systeminit_dmg_data_n_43}),
        .S({systeminit_dmg_data_n_75,systeminit_dmg_data_n_76,systeminit_dmg_data_n_77,systeminit_dmg_data_n_78}),
        .addra(rom_data_ptr_ff),
        .b_complete(b_complete),
        .bready_m(bready_m),
        .cur_trn_status_i_3({\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_41 ,systeminit_dmg_data_n_66,systeminit_dmg_data_n_67}),
        .cur_trn_status_i_4({systeminit_dmg_addr_n_54,systeminit_dmg_data_n_71,systeminit_dmg_data_n_72,systeminit_dmg_data_n_73}),
        .cur_trn_status_i_4_0({\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_45 ,systeminit_dmg_data_n_86,systeminit_dmg_data_n_87,systeminit_dmg_data_n_88}),
        .cur_trn_status_i_4_1({systeminit_dmg_addr_n_51,systeminit_dmg_data_n_74,\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_44 ,systeminit_dmg_addr_n_52}),
        .cur_trn_status_i_4_2({\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_46 ,systeminit_dmg_data_n_68,systeminit_dmg_data_n_69,systeminit_dmg_data_n_70}),
        .cur_trn_status_reg_0(static_mrdwr_n_7),
        .cur_trn_status_reg_1(systeminit_dmg_addr_n_34),
        .done(done),
        .douta(rom_ctrl),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] (rd_check1),
        .m_axi_lite_ch1_araddr(m_axi_lite_ch1_araddr),
        .m_axi_lite_ch1_arready(m_axi_lite_ch1_arready),
        .m_axi_lite_ch1_arvalid(m_axi_lite_ch1_arvalid),
        .m_axi_lite_ch1_awaddr(m_axi_lite_ch1_awaddr),
        .m_axi_lite_ch1_awready(m_axi_lite_ch1_awready),
        .m_axi_lite_ch1_awvalid(m_axi_lite_ch1_awvalid),
        .m_axi_lite_ch1_bready(m_axi_lite_ch1_bready),
        .m_axi_lite_ch1_bvalid(m_axi_lite_ch1_bvalid),
        .\m_axi_lite_ch1_rdata[30] (static_mrdwr_n_2),
        .m_axi_lite_ch1_rready(m_axi_lite_ch1_rready),
        .m_axi_lite_ch1_rvalid(m_axi_lite_ch1_rvalid),
        .m_axi_lite_ch1_wdata(m_axi_lite_ch1_wdata),
        .m_axi_lite_ch1_wready(m_axi_lite_ch1_wready),
        .m_axi_lite_ch1_wvalid(m_axi_lite_ch1_wvalid),
        .\max_retry_cntr_reg[31]_0 (systeminit_dmg_addr_n_36),
        .\max_retry_cntr_reg[31]_1 (systeminit_dmg_addr_n_33),
        .r_complete(r_complete),
        .rd_check1_carry__0_0({systeminit_dmg_addr_n_38,systeminit_dmg_data_n_44,\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_33 ,systeminit_dmg_addr_n_39}),
        .rd_check1_carry__0_1({systeminit_dmg_data_n_36,systeminit_dmg_data_n_37,systeminit_dmg_data_n_38,systeminit_dmg_data_n_39}),
        .rd_check1_carry__1_0({systeminit_dmg_addr_n_43,systeminit_dmg_addr_n_44,systeminit_dmg_data_n_55,\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_37 }),
        .rd_check1_carry__1_1({systeminit_dmg_addr_n_45,systeminit_dmg_data_n_49,systeminit_dmg_data_n_50,systeminit_dmg_data_n_51}),
        .rd_check1_carry__2_0({systeminit_dmg_data_n_64,\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_39 ,systeminit_dmg_addr_n_49,systeminit_dmg_data_n_65}),
        .rd_check1_carry__2_1({systeminit_dmg_data_n_56,systeminit_dmg_data_n_57,systeminit_dmg_data_n_58,systeminit_dmg_data_n_59}),
        .rd_check2_carry__1_0({\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_34 ,systeminit_dmg_data_n_52,systeminit_dmg_data_n_53,systeminit_dmg_data_n_54}),
        .rd_check2_carry__1_1({systeminit_dmg_addr_n_61,systeminit_dmg_data_n_79,systeminit_dmg_data_n_80,systeminit_dmg_data_n_81}),
        .rd_check2_carry__2_0({systeminit_dmg_data_n_60,systeminit_dmg_data_n_61,systeminit_dmg_data_n_62,systeminit_dmg_data_n_63}),
        .rd_check2_carry__2_1({systeminit_dmg_data_n_82,systeminit_dmg_data_n_83,systeminit_dmg_data_n_84,systeminit_dmg_data_n_85}),
        .\rd_check2_inferred__0/i__carry__0_0 ({systeminit_dmg_data_n_32,systeminit_dmg_data_n_33,systeminit_dmg_data_n_34,systeminit_dmg_data_n_35}),
        .\rd_check2_inferred__0/i__carry__1_0 ({systeminit_dmg_data_n_45,systeminit_dmg_data_n_46,systeminit_dmg_data_n_47,systeminit_dmg_data_n_48}),
        .rom_eof0(rom_eof0),
        .rready_m(rready_m),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(static_mrdwr_n_0),
        .status(status),
        .\wdata_m_reg[31]_0 (rom_data));
  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized1 systeminit_dmg_addr
       (.addra(rom_data_ptr_ff),
        .b_complete(b_complete),
        .bready_m(bready_m),
        .bready_m_reg(systeminit_dmg_addr_n_36),
        .cur_trn_status_reg(rom_ctrl[16]),
        .cur_trn_status_reg_0(\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_2 ),
        .cur_trn_status_reg_1(\ATG_SYSINIT_DMG.systeminit_dmg_ctrl_n_3 ),
        .douta(rom_addr),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ({systeminit_dmg_addr_n_43,systeminit_dmg_addr_n_44}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] (systeminit_dmg_addr_n_49),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] (systeminit_dmg_addr_n_58),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] (systeminit_dmg_addr_n_57),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ({systeminit_dmg_addr_n_51,systeminit_dmg_addr_n_52}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (systeminit_dmg_addr_n_53),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 (static_mrdwr_n_0),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] (systeminit_dmg_addr_n_60),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ({systeminit_dmg_addr_n_38,systeminit_dmg_addr_n_39}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] (systeminit_dmg_addr_n_59),
        .i__carry__1_i_1({rom_data[31:30],rom_data[27],rom_data[25:24],rom_data[21],rom_data[19:18],rom_data[15:12],rom_data[9],rom_data[7:6],rom_data[3],rom_data[1:0]}),
        .i__carry__1_i_1_0({rom_mask[31:30],rom_mask[27:24],rom_mask[21:18],rom_mask[15:12],rom_mask[9:6],rom_mask[3:0]}),
        .m_axi_lite_ch1_bresp(m_axi_lite_ch1_bresp),
        .m_axi_lite_ch1_bvalid(m_axi_lite_ch1_bvalid),
        .m_axi_lite_ch1_rdata({m_axi_lite_ch1_rdata[31:30],m_axi_lite_ch1_rdata[27:24],m_axi_lite_ch1_rdata[21:18],m_axi_lite_ch1_rdata[15:12],m_axi_lite_ch1_rdata[9:6],m_axi_lite_ch1_rdata[3:0]}),
        .\m_axi_lite_ch1_rdata[14] (systeminit_dmg_addr_n_45),
        .\m_axi_lite_ch1_rdata[14]_0 (systeminit_dmg_addr_n_61),
        .\m_axi_lite_ch1_rdata[24] (systeminit_dmg_addr_n_56),
        .\m_axi_lite_ch1_rdata[26] (systeminit_dmg_addr_n_55),
        .\m_axi_lite_ch1_rdata[30] (systeminit_dmg_addr_n_54),
        .m_axi_lite_ch1_rdata_0_sp_1(systeminit_dmg_addr_n_42),
        .m_axi_lite_ch1_rdata_12_sp_1(systeminit_dmg_addr_n_46),
        .m_axi_lite_ch1_rdata_18_sp_1(systeminit_dmg_addr_n_50),
        .m_axi_lite_ch1_rdata_20_sp_1(systeminit_dmg_addr_n_48),
        .m_axi_lite_ch1_rdata_2_sp_1(systeminit_dmg_addr_n_41),
        .m_axi_lite_ch1_rdata_6_sp_1(systeminit_dmg_addr_n_40),
        .m_axi_lite_ch1_rdata_8_sp_1(systeminit_dmg_addr_n_47),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp[1]),
        .m_axi_lite_ch1_rvalid(m_axi_lite_ch1_rvalid),
        .r_complete(r_complete),
        .rd_check1_carry__0(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_35 ),
        .rd_check1_carry__2(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_42 ),
        .rom_eof0(rom_eof0),
        .rready_m(rready_m),
        .rready_m_reg(systeminit_dmg_addr_n_33),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(systeminit_dmg_addr_n_34));
  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_dmg__parameterized2 systeminit_dmg_data
       (.DI({systeminit_dmg_data_n_40,systeminit_dmg_data_n_41,systeminit_dmg_data_n_42,systeminit_dmg_data_n_43}),
        .S({systeminit_dmg_data_n_75,systeminit_dmg_data_n_76,systeminit_dmg_data_n_77,systeminit_dmg_data_n_78}),
        .addra(rom_data_ptr_ff),
        .douta(rom_data),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ({systeminit_dmg_data_n_49,systeminit_dmg_data_n_50,systeminit_dmg_data_n_51}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ({systeminit_dmg_data_n_79,systeminit_dmg_data_n_80,systeminit_dmg_data_n_81}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ({systeminit_dmg_data_n_52,systeminit_dmg_data_n_53,systeminit_dmg_data_n_54}),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] (static_mrdwr_n_0),
        .\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ({systeminit_dmg_data_n_36,systeminit_dmg_data_n_37,systeminit_dmg_data_n_38,systeminit_dmg_data_n_39}),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata[29:0]),
        .\m_axi_lite_ch1_rdata[11] ({systeminit_dmg_data_n_32,systeminit_dmg_data_n_33,systeminit_dmg_data_n_34,systeminit_dmg_data_n_35}),
        .\m_axi_lite_ch1_rdata[11]_0 (systeminit_dmg_data_n_55),
        .\m_axi_lite_ch1_rdata[22] ({systeminit_dmg_data_n_56,systeminit_dmg_data_n_57,systeminit_dmg_data_n_58,systeminit_dmg_data_n_59}),
        .\m_axi_lite_ch1_rdata[22]_0 ({systeminit_dmg_data_n_82,systeminit_dmg_data_n_83,systeminit_dmg_data_n_84,systeminit_dmg_data_n_85}),
        .\m_axi_lite_ch1_rdata[23] ({systeminit_dmg_data_n_45,systeminit_dmg_data_n_46,systeminit_dmg_data_n_47,systeminit_dmg_data_n_48}),
        .\m_axi_lite_ch1_rdata[23]_0 ({systeminit_dmg_data_n_60,systeminit_dmg_data_n_61,systeminit_dmg_data_n_62,systeminit_dmg_data_n_63}),
        .\m_axi_lite_ch1_rdata[23]_1 ({systeminit_dmg_data_n_64,systeminit_dmg_data_n_65}),
        .\m_axi_lite_ch1_rdata[28] ({systeminit_dmg_data_n_68,systeminit_dmg_data_n_69,systeminit_dmg_data_n_70}),
        .\m_axi_lite_ch1_rdata[28]_0 ({systeminit_dmg_data_n_86,systeminit_dmg_data_n_87,systeminit_dmg_data_n_88}),
        .\m_axi_lite_ch1_rdata[29] ({systeminit_dmg_data_n_66,systeminit_dmg_data_n_67}),
        .\m_axi_lite_ch1_rdata[29]_0 ({systeminit_dmg_data_n_71,systeminit_dmg_data_n_72,systeminit_dmg_data_n_73}),
        .\m_axi_lite_ch1_rdata[29]_1 (systeminit_dmg_data_n_74),
        .\m_axi_lite_ch1_rdata[5] (systeminit_dmg_data_n_44),
        .rd_check1_carry(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_32 ),
        .rd_check1_carry__0(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_36 ),
        .rd_check1_carry__1(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_38 ),
        .rd_check1_carry__1_0(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_40 ),
        .rd_check1_carry__2(\ATG_SYSINIT_DMG.systeminit_dmg_mask_n_43 ),
        .rd_check2_carry(systeminit_dmg_addr_n_41),
        .rd_check2_carry__0(systeminit_dmg_addr_n_47),
        .rd_check2_carry__1(systeminit_dmg_addr_n_48),
        .rd_check2_carry__2(rom_mask[29:0]),
        .rd_check2_carry__2_0(systeminit_dmg_addr_n_55),
        .\rd_check2_inferred__0/i__carry (systeminit_dmg_addr_n_40),
        .\rd_check2_inferred__0/i__carry_0 (systeminit_dmg_addr_n_60),
        .\rd_check2_inferred__0/i__carry_1 (systeminit_dmg_addr_n_42),
        .\rd_check2_inferred__0/i__carry_2 (systeminit_dmg_addr_n_59),
        .\rd_check2_inferred__0/i__carry__0 (systeminit_dmg_addr_n_46),
        .\rd_check2_inferred__0/i__carry__0_0 (systeminit_dmg_addr_n_58),
        .\rd_check2_inferred__0/i__carry__0_1 (systeminit_dmg_addr_n_50),
        .\rd_check2_inferred__0/i__carry__1 (systeminit_dmg_addr_n_57),
        .\rd_check2_inferred__0/i__carry__1_0 (systeminit_dmg_addr_n_56),
        .rom_eof0(rom_eof0),
        .s_axi_aclk(s_axi_aclk));
endmodule

(* ATG_VERSAL_400 = "0" *) (* C_ADDR_F = "mipi_init_gen_default_addrram.mem" *) (* C_ATG_AXIS_DATA_GEN_TYPE = "0" *) 
(* C_ATG_BASIC_AXI4 = "0" *) (* C_ATG_HLTP_MODE = "0" *) (* C_ATG_MIF_ADDR_BITS = "8" *) 
(* C_ATG_MIF_DATA_DEPTH = "256" *) (* C_ATG_REPEAT_TYPE = "0" *) (* C_ATG_SLAVE_ONLY = "0" *) 
(* C_ATG_STATIC = "0" *) (* C_ATG_STATIC_EN_READ = "1" *) (* C_ATG_STATIC_EN_WRITE = "1" *) 
(* C_ATG_STATIC_FREE_RUN = "1" *) (* C_ATG_STATIC_INCR = "0" *) (* C_ATG_STATIC_LENGTH = "16" *) 
(* C_ATG_STATIC_RD_ADDRESS = "64'b0000000000000000000000000000000000010011101000000000000000000000" *) (* C_ATG_STATIC_RD_HIGH_ADDRESS = "64'b0000000000000000000000000000000000010011101000000000111111111111" *) (* C_ATG_STATIC_RD_PIPELINE = "3" *) 
(* C_ATG_STATIC_TRANGAP = "0" *) (* C_ATG_STATIC_WR_ADDRESS = "64'b0000000000000000000000000000000000010010101000000000000000000000" *) (* C_ATG_STATIC_WR_HIGH_ADDRESS = "64'b0000000000000000000000000000000000010010101000000000111111111111" *) 
(* C_ATG_STATIC_WR_PIPELINE = "3" *) (* C_ATG_STREAMING = "0" *) (* C_ATG_STREAMING_MAX_LEN_BITS = "16" *) 
(* C_ATG_STREAMING_MEM_FILE = "no_mem_file_loaded" *) (* C_ATG_STREAMING_MST_LPBK = "0" *) (* C_ATG_STREAMING_MST_ONLY = "1" *) 
(* C_ATG_STREAMING_SLV_LPBK = "0" *) (* C_ATG_SYSTEM_CH1_HIGH = "1151533055" *) (* C_ATG_SYSTEM_CH1_LOW = "1151336448" *) 
(* C_ATG_SYSTEM_CH2_HIGH = "511" *) (* C_ATG_SYSTEM_CH2_LOW = "256" *) (* C_ATG_SYSTEM_CH3_HIGH = "767" *) 
(* C_ATG_SYSTEM_CH3_LOW = "512" *) (* C_ATG_SYSTEM_CH4_HIGH = "1023" *) (* C_ATG_SYSTEM_CH4_LOW = "768" *) 
(* C_ATG_SYSTEM_CH5_HIGH = "1279" *) (* C_ATG_SYSTEM_CH5_LOW = "1024" *) (* C_ATG_SYSTEM_CMD_MAX_RETRY = "-16" *) 
(* C_ATG_SYSTEM_INIT = "0" *) (* C_ATG_SYSTEM_INIT_ADDR_MIF = "mipi_init_gen_addr.mem" *) (* C_ATG_SYSTEM_INIT_CTRL_MIF = "mipi_init_gen_ctrl.mem" *) 
(* C_ATG_SYSTEM_INIT_DATA_MIF = "mipi_init_gen_data.mem" *) (* C_ATG_SYSTEM_INIT_MASK_MIF = "mipi_init_gen_mask.mem" *) (* C_ATG_SYSTEM_MAX_CHANNELS = "1" *) 
(* C_ATG_SYSTEM_TEST = "1" *) (* C_ATG_SYSTEM_TEST_MAX_CLKS = "-6" *) (* C_AXIS1_HAS_TKEEP = "1" *) 
(* C_AXIS1_HAS_TSTRB = "1" *) (* C_AXIS2_HAS_TKEEP = "0" *) (* C_AXIS2_HAS_TSTRB = "0" *) 
(* C_AXIS_SPARSE_EN = "1" *) (* C_AXIS_TDATA_WIDTH = "32" *) (* C_AXIS_TDEST_WIDTH = "8" *) 
(* C_AXIS_TID_WIDTH = "8" *) (* C_AXIS_TUSER_WIDTH = "8" *) (* C_AXI_RD_ADDR_SEED = "16'b0101101001011010" *) 
(* C_AXI_WR_ADDR_SEED = "16'b0111110010011011" *) (* C_BASEADDR = "0" *) (* C_CMDRAM_F = "mipi_init_gen_default_cmdram.mem" *) 
(* C_FAMILY = "artix7" *) (* C_HIGHADDR = "65535" *) (* C_M_AXI_ADDR_WIDTH = "32" *) 
(* C_M_AXI_ARUSER_WIDTH = "8" *) (* C_M_AXI_AWUSER_WIDTH = "8" *) (* C_M_AXI_DATA_WIDTH = "32" *) 
(* C_M_AXI_THREAD_ID_WIDTH = "1" *) (* C_NO_EXCL = "0" *) (* C_PRAM_F = "mipi_init_gen_default_prmram.mem" *) 
(* C_RAMINIT_ADDRRAM0_F = "mipi_init_gen_default_addrram.mem" *) (* C_RAMINIT_CMDRAM0_F = "mipi_init_gen_default_cmdram.mem" *) (* C_RAMINIT_CMDRAM1_F = "NONE" *) 
(* C_RAMINIT_CMDRAM2_F = "NONE" *) (* C_RAMINIT_CMDRAM3_F = "NONE" *) (* C_RAMINIT_PARAMRAM0_F = "mipi_init_gen_default_prmram.mem" *) 
(* C_RAMINIT_SRAM0_F = "mipi_init_gen_default_mstram.mem" *) (* C_READ_ONLY = "0" *) (* C_REPEAT_COUNT = "254" *) 
(* C_SRAM_F = "mipi_init_gen_default_mstram.mem" *) (* C_STRM_DATA_SEED = "16'b1010101111001101" *) (* C_S_AXI_ARUSER_WIDTH = "8" *) 
(* C_S_AXI_AWUSER_WIDTH = "8" *) (* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_ID_WIDTH = "1" *) 
(* C_WRITE_ONLY = "0" *) (* C_ZERO_INVALID = "1" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
module mipi_init_gen_axi_traffic_gen_v3_0_20_top
   (s_axi_aclk,
    s_axi_aresetn,
    core_ext_start,
    core_ext_stop,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awqos,
    s_axi_awuser,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wlast,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arqos,
    s_axi_aruser,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rlast,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_awid,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awqos,
    m_axi_awuser,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wlast,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_bready,
    m_axi_arid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arqos,
    m_axi_aruser,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rid,
    m_axi_rlast,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rvalid,
    m_axi_rready,
    m_axis_1_tready,
    m_axis_1_tvalid,
    m_axis_1_tlast,
    m_axis_1_tdata,
    m_axis_1_tstrb,
    m_axis_1_tkeep,
    m_axis_1_tuser,
    m_axis_1_tid,
    m_axis_1_tdest,
    s_axis_1_tready,
    s_axis_1_tvalid,
    s_axis_1_tlast,
    s_axis_1_tdata,
    s_axis_1_tstrb,
    s_axis_1_tkeep,
    s_axis_1_tuser,
    s_axis_1_tid,
    s_axis_1_tdest,
    axis_err_count,
    s_axis_2_tready,
    s_axis_2_tvalid,
    s_axis_2_tlast,
    s_axis_2_tdata,
    s_axis_2_tstrb,
    s_axis_2_tkeep,
    s_axis_2_tuser,
    s_axis_2_tid,
    s_axis_2_tdest,
    m_axis_2_tready,
    m_axis_2_tvalid,
    m_axis_2_tlast,
    m_axis_2_tdata,
    m_axis_2_tstrb,
    m_axis_2_tkeep,
    m_axis_2_tuser,
    m_axis_2_tid,
    m_axis_2_tdest,
    irq_out,
    err_out,
    m_axi_lite_ch1_awaddr,
    m_axi_lite_ch1_awprot,
    m_axi_lite_ch1_awvalid,
    m_axi_lite_ch1_awready,
    m_axi_lite_ch1_wdata,
    m_axi_lite_ch1_wstrb,
    m_axi_lite_ch1_wvalid,
    m_axi_lite_ch1_wready,
    m_axi_lite_ch1_bresp,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_bready,
    m_axi_lite_ch1_araddr,
    m_axi_lite_ch1_arvalid,
    m_axi_lite_ch1_arready,
    m_axi_lite_ch1_rdata,
    m_axi_lite_ch1_rvalid,
    m_axi_lite_ch1_rresp,
    m_axi_lite_ch1_rready,
    m_axi_lite_ch2_awaddr,
    m_axi_lite_ch2_awprot,
    m_axi_lite_ch2_awvalid,
    m_axi_lite_ch2_awready,
    m_axi_lite_ch2_wdata,
    m_axi_lite_ch2_wstrb,
    m_axi_lite_ch2_wvalid,
    m_axi_lite_ch2_wready,
    m_axi_lite_ch2_bresp,
    m_axi_lite_ch2_bvalid,
    m_axi_lite_ch2_bready,
    m_axi_lite_ch2_araddr,
    m_axi_lite_ch2_arvalid,
    m_axi_lite_ch2_arready,
    m_axi_lite_ch2_rdata,
    m_axi_lite_ch2_rvalid,
    m_axi_lite_ch2_rresp,
    m_axi_lite_ch2_rready,
    m_axi_lite_ch3_awaddr,
    m_axi_lite_ch3_awprot,
    m_axi_lite_ch3_awvalid,
    m_axi_lite_ch3_awready,
    m_axi_lite_ch3_wdata,
    m_axi_lite_ch3_wstrb,
    m_axi_lite_ch3_wvalid,
    m_axi_lite_ch3_wready,
    m_axi_lite_ch3_bresp,
    m_axi_lite_ch3_bvalid,
    m_axi_lite_ch3_bready,
    m_axi_lite_ch3_araddr,
    m_axi_lite_ch3_arvalid,
    m_axi_lite_ch3_arready,
    m_axi_lite_ch3_rdata,
    m_axi_lite_ch3_rvalid,
    m_axi_lite_ch3_rresp,
    m_axi_lite_ch3_rready,
    m_axi_lite_ch4_awaddr,
    m_axi_lite_ch4_awprot,
    m_axi_lite_ch4_awvalid,
    m_axi_lite_ch4_awready,
    m_axi_lite_ch4_wdata,
    m_axi_lite_ch4_wstrb,
    m_axi_lite_ch4_wvalid,
    m_axi_lite_ch4_wready,
    m_axi_lite_ch4_bresp,
    m_axi_lite_ch4_bvalid,
    m_axi_lite_ch4_bready,
    m_axi_lite_ch4_araddr,
    m_axi_lite_ch4_arvalid,
    m_axi_lite_ch4_arready,
    m_axi_lite_ch4_rdata,
    m_axi_lite_ch4_rvalid,
    m_axi_lite_ch4_rresp,
    m_axi_lite_ch4_rready,
    m_axi_lite_ch5_awaddr,
    m_axi_lite_ch5_awprot,
    m_axi_lite_ch5_awvalid,
    m_axi_lite_ch5_awready,
    m_axi_lite_ch5_wdata,
    m_axi_lite_ch5_wstrb,
    m_axi_lite_ch5_wvalid,
    m_axi_lite_ch5_wready,
    m_axi_lite_ch5_bresp,
    m_axi_lite_ch5_bvalid,
    m_axi_lite_ch5_bready,
    m_axi_lite_ch5_araddr,
    m_axi_lite_ch5_arvalid,
    m_axi_lite_ch5_arready,
    m_axi_lite_ch5_rdata,
    m_axi_lite_ch5_rvalid,
    m_axi_lite_ch5_rresp,
    m_axi_lite_ch5_rready,
    done,
    status);
  input s_axi_aclk;
  input s_axi_aresetn;
  input core_ext_start;
  input core_ext_stop;
  input [0:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awqos;
  input [7:0]s_axi_awuser;
  input s_axi_awvalid;
  output s_axi_awready;
  input s_axi_wlast;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [0:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arqos;
  input [7:0]s_axi_aruser;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output s_axi_rlast;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  output [0:0]m_axi_awid;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [0:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output [3:0]m_axi_awqos;
  output [7:0]m_axi_awuser;
  output m_axi_awvalid;
  input m_axi_awready;
  output m_axi_wlast;
  output [31:0]m_axi_wdata;
  output [3:0]m_axi_wstrb;
  output m_axi_wvalid;
  input m_axi_wready;
  input [0:0]m_axi_bid;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  output m_axi_bready;
  output [0:0]m_axi_arid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [0:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output [3:0]m_axi_arqos;
  output [7:0]m_axi_aruser;
  output m_axi_arvalid;
  input m_axi_arready;
  input [0:0]m_axi_rid;
  input m_axi_rlast;
  input [31:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rvalid;
  output m_axi_rready;
  input m_axis_1_tready;
  output m_axis_1_tvalid;
  output m_axis_1_tlast;
  output [31:0]m_axis_1_tdata;
  output [3:0]m_axis_1_tstrb;
  output [3:0]m_axis_1_tkeep;
  output [7:0]m_axis_1_tuser;
  output [7:0]m_axis_1_tid;
  output [7:0]m_axis_1_tdest;
  output s_axis_1_tready;
  input s_axis_1_tvalid;
  input s_axis_1_tlast;
  input [31:0]s_axis_1_tdata;
  input [3:0]s_axis_1_tstrb;
  input [3:0]s_axis_1_tkeep;
  input [7:0]s_axis_1_tuser;
  input [7:0]s_axis_1_tid;
  input [7:0]s_axis_1_tdest;
  output [15:0]axis_err_count;
  output s_axis_2_tready;
  input s_axis_2_tvalid;
  input s_axis_2_tlast;
  input [31:0]s_axis_2_tdata;
  input [3:0]s_axis_2_tstrb;
  input [3:0]s_axis_2_tkeep;
  input [7:0]s_axis_2_tuser;
  input [7:0]s_axis_2_tid;
  input [7:0]s_axis_2_tdest;
  input m_axis_2_tready;
  output m_axis_2_tvalid;
  output m_axis_2_tlast;
  output [31:0]m_axis_2_tdata;
  output [3:0]m_axis_2_tstrb;
  output [3:0]m_axis_2_tkeep;
  output [7:0]m_axis_2_tuser;
  output [7:0]m_axis_2_tid;
  output [7:0]m_axis_2_tdest;
  output irq_out;
  output err_out;
  output [31:0]m_axi_lite_ch1_awaddr;
  output [2:0]m_axi_lite_ch1_awprot;
  output m_axi_lite_ch1_awvalid;
  input m_axi_lite_ch1_awready;
  output [31:0]m_axi_lite_ch1_wdata;
  output [3:0]m_axi_lite_ch1_wstrb;
  output m_axi_lite_ch1_wvalid;
  input m_axi_lite_ch1_wready;
  input [1:0]m_axi_lite_ch1_bresp;
  input m_axi_lite_ch1_bvalid;
  output m_axi_lite_ch1_bready;
  output [31:0]m_axi_lite_ch1_araddr;
  output m_axi_lite_ch1_arvalid;
  input m_axi_lite_ch1_arready;
  input [31:0]m_axi_lite_ch1_rdata;
  input m_axi_lite_ch1_rvalid;
  input [1:0]m_axi_lite_ch1_rresp;
  output m_axi_lite_ch1_rready;
  output [31:0]m_axi_lite_ch2_awaddr;
  output [2:0]m_axi_lite_ch2_awprot;
  output m_axi_lite_ch2_awvalid;
  input m_axi_lite_ch2_awready;
  output [31:0]m_axi_lite_ch2_wdata;
  output [3:0]m_axi_lite_ch2_wstrb;
  output m_axi_lite_ch2_wvalid;
  input m_axi_lite_ch2_wready;
  input [1:0]m_axi_lite_ch2_bresp;
  input m_axi_lite_ch2_bvalid;
  output m_axi_lite_ch2_bready;
  output [31:0]m_axi_lite_ch2_araddr;
  output m_axi_lite_ch2_arvalid;
  input m_axi_lite_ch2_arready;
  input [31:0]m_axi_lite_ch2_rdata;
  input m_axi_lite_ch2_rvalid;
  input [1:0]m_axi_lite_ch2_rresp;
  output m_axi_lite_ch2_rready;
  output [31:0]m_axi_lite_ch3_awaddr;
  output [2:0]m_axi_lite_ch3_awprot;
  output m_axi_lite_ch3_awvalid;
  input m_axi_lite_ch3_awready;
  output [31:0]m_axi_lite_ch3_wdata;
  output [3:0]m_axi_lite_ch3_wstrb;
  output m_axi_lite_ch3_wvalid;
  input m_axi_lite_ch3_wready;
  input [1:0]m_axi_lite_ch3_bresp;
  input m_axi_lite_ch3_bvalid;
  output m_axi_lite_ch3_bready;
  output [31:0]m_axi_lite_ch3_araddr;
  output m_axi_lite_ch3_arvalid;
  input m_axi_lite_ch3_arready;
  input [31:0]m_axi_lite_ch3_rdata;
  input m_axi_lite_ch3_rvalid;
  input [1:0]m_axi_lite_ch3_rresp;
  output m_axi_lite_ch3_rready;
  output [31:0]m_axi_lite_ch4_awaddr;
  output [2:0]m_axi_lite_ch4_awprot;
  output m_axi_lite_ch4_awvalid;
  input m_axi_lite_ch4_awready;
  output [31:0]m_axi_lite_ch4_wdata;
  output [3:0]m_axi_lite_ch4_wstrb;
  output m_axi_lite_ch4_wvalid;
  input m_axi_lite_ch4_wready;
  input [1:0]m_axi_lite_ch4_bresp;
  input m_axi_lite_ch4_bvalid;
  output m_axi_lite_ch4_bready;
  output [31:0]m_axi_lite_ch4_araddr;
  output m_axi_lite_ch4_arvalid;
  input m_axi_lite_ch4_arready;
  input [31:0]m_axi_lite_ch4_rdata;
  input m_axi_lite_ch4_rvalid;
  input [1:0]m_axi_lite_ch4_rresp;
  output m_axi_lite_ch4_rready;
  output [31:0]m_axi_lite_ch5_awaddr;
  output [2:0]m_axi_lite_ch5_awprot;
  output m_axi_lite_ch5_awvalid;
  input m_axi_lite_ch5_awready;
  output [31:0]m_axi_lite_ch5_wdata;
  output [3:0]m_axi_lite_ch5_wstrb;
  output m_axi_lite_ch5_wvalid;
  input m_axi_lite_ch5_wready;
  input [1:0]m_axi_lite_ch5_bresp;
  input m_axi_lite_ch5_bvalid;
  output m_axi_lite_ch5_bready;
  output [31:0]m_axi_lite_ch5_araddr;
  output m_axi_lite_ch5_arvalid;
  input m_axi_lite_ch5_arready;
  input [31:0]m_axi_lite_ch5_rdata;
  input m_axi_lite_ch5_rvalid;
  input [1:0]m_axi_lite_ch5_rresp;
  output m_axi_lite_ch5_rready;
  output done;
  output [31:0]status;

  wire \<const0> ;
  wire core_ext_start;
  wire core_ext_stop;
  wire done;
  wire flop_fi_out;
  wire flop_ze_out;
  wire [31:0]m_axi_lite_ch1_araddr;
  wire m_axi_lite_ch1_arready;
  wire m_axi_lite_ch1_arvalid;
  wire [31:0]m_axi_lite_ch1_awaddr;
  wire m_axi_lite_ch1_awready;
  wire m_axi_lite_ch1_awvalid;
  wire m_axi_lite_ch1_bready;
  wire [1:0]m_axi_lite_ch1_bresp;
  wire m_axi_lite_ch1_bvalid;
  wire [31:0]m_axi_lite_ch1_rdata;
  wire m_axi_lite_ch1_rready;
  wire [1:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rvalid;
  wire [31:0]m_axi_lite_ch1_wdata;
  wire m_axi_lite_ch1_wready;
  wire m_axi_lite_ch1_wvalid;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire st_flop_fi_out;
  wire st_flop_ze_out;
  wire [31:0]\^status ;

  assign axis_err_count[15] = \<const0> ;
  assign axis_err_count[14] = \<const0> ;
  assign axis_err_count[13] = \<const0> ;
  assign axis_err_count[12] = \<const0> ;
  assign axis_err_count[11] = \<const0> ;
  assign axis_err_count[10] = \<const0> ;
  assign axis_err_count[9] = \<const0> ;
  assign axis_err_count[8] = \<const0> ;
  assign axis_err_count[7] = \<const0> ;
  assign axis_err_count[6] = \<const0> ;
  assign axis_err_count[5] = \<const0> ;
  assign axis_err_count[4] = \<const0> ;
  assign axis_err_count[3] = \<const0> ;
  assign axis_err_count[2] = \<const0> ;
  assign axis_err_count[1] = \<const0> ;
  assign axis_err_count[0] = \<const0> ;
  assign err_out = \<const0> ;
  assign irq_out = \<const0> ;
  assign m_axi_araddr[31] = \<const0> ;
  assign m_axi_araddr[30] = \<const0> ;
  assign m_axi_araddr[29] = \<const0> ;
  assign m_axi_araddr[28] = \<const0> ;
  assign m_axi_araddr[27] = \<const0> ;
  assign m_axi_araddr[26] = \<const0> ;
  assign m_axi_araddr[25] = \<const0> ;
  assign m_axi_araddr[24] = \<const0> ;
  assign m_axi_araddr[23] = \<const0> ;
  assign m_axi_araddr[22] = \<const0> ;
  assign m_axi_araddr[21] = \<const0> ;
  assign m_axi_araddr[20] = \<const0> ;
  assign m_axi_araddr[19] = \<const0> ;
  assign m_axi_araddr[18] = \<const0> ;
  assign m_axi_araddr[17] = \<const0> ;
  assign m_axi_araddr[16] = \<const0> ;
  assign m_axi_araddr[15] = \<const0> ;
  assign m_axi_araddr[14] = \<const0> ;
  assign m_axi_araddr[13] = \<const0> ;
  assign m_axi_araddr[12] = \<const0> ;
  assign m_axi_araddr[11] = \<const0> ;
  assign m_axi_araddr[10] = \<const0> ;
  assign m_axi_araddr[9] = \<const0> ;
  assign m_axi_araddr[8] = \<const0> ;
  assign m_axi_araddr[7] = \<const0> ;
  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5] = \<const0> ;
  assign m_axi_araddr[4] = \<const0> ;
  assign m_axi_araddr[3] = \<const0> ;
  assign m_axi_araddr[2] = \<const0> ;
  assign m_axi_araddr[1] = \<const0> ;
  assign m_axi_araddr[0] = \<const0> ;
  assign m_axi_arburst[1] = \<const0> ;
  assign m_axi_arburst[0] = \<const0> ;
  assign m_axi_arcache[3] = \<const0> ;
  assign m_axi_arcache[2] = \<const0> ;
  assign m_axi_arcache[1] = \<const0> ;
  assign m_axi_arcache[0] = \<const0> ;
  assign m_axi_arid[0] = \<const0> ;
  assign m_axi_arlen[7] = \<const0> ;
  assign m_axi_arlen[6] = \<const0> ;
  assign m_axi_arlen[5] = \<const0> ;
  assign m_axi_arlen[4] = \<const0> ;
  assign m_axi_arlen[3] = \<const0> ;
  assign m_axi_arlen[2] = \<const0> ;
  assign m_axi_arlen[1] = \<const0> ;
  assign m_axi_arlen[0] = \<const0> ;
  assign m_axi_arlock[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_arqos[3] = \<const0> ;
  assign m_axi_arqos[2] = \<const0> ;
  assign m_axi_arqos[1] = \<const0> ;
  assign m_axi_arqos[0] = \<const0> ;
  assign m_axi_arsize[2] = \<const0> ;
  assign m_axi_arsize[1] = \<const0> ;
  assign m_axi_arsize[0] = \<const0> ;
  assign m_axi_aruser[7] = \<const0> ;
  assign m_axi_aruser[6] = \<const0> ;
  assign m_axi_aruser[5] = \<const0> ;
  assign m_axi_aruser[4] = \<const0> ;
  assign m_axi_aruser[3] = \<const0> ;
  assign m_axi_aruser[2] = \<const0> ;
  assign m_axi_aruser[1] = \<const0> ;
  assign m_axi_aruser[0] = \<const0> ;
  assign m_axi_arvalid = \<const0> ;
  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const0> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \<const0> ;
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const0> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awid[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awqos[3] = \<const0> ;
  assign m_axi_awqos[2] = \<const0> ;
  assign m_axi_awqos[1] = \<const0> ;
  assign m_axi_awqos[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \<const0> ;
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_awuser[7] = \<const0> ;
  assign m_axi_awuser[6] = \<const0> ;
  assign m_axi_awuser[5] = \<const0> ;
  assign m_axi_awuser[4] = \<const0> ;
  assign m_axi_awuser[3] = \<const0> ;
  assign m_axi_awuser[2] = \<const0> ;
  assign m_axi_awuser[1] = \<const0> ;
  assign m_axi_awuser[0] = \<const0> ;
  assign m_axi_awvalid = \<const0> ;
  assign m_axi_bready = \<const0> ;
  assign m_axi_lite_ch1_awprot[2] = \<const0> ;
  assign m_axi_lite_ch1_awprot[1] = \<const0> ;
  assign m_axi_lite_ch1_awprot[0] = \<const0> ;
  assign m_axi_lite_ch1_wstrb[3] = \<const0> ;
  assign m_axi_lite_ch1_wstrb[2] = \<const0> ;
  assign m_axi_lite_ch1_wstrb[1] = \<const0> ;
  assign m_axi_lite_ch1_wstrb[0] = \<const0> ;
  assign m_axi_lite_ch2_araddr[31] = \<const0> ;
  assign m_axi_lite_ch2_araddr[30] = \<const0> ;
  assign m_axi_lite_ch2_araddr[29] = \<const0> ;
  assign m_axi_lite_ch2_araddr[28] = \<const0> ;
  assign m_axi_lite_ch2_araddr[27] = \<const0> ;
  assign m_axi_lite_ch2_araddr[26] = \<const0> ;
  assign m_axi_lite_ch2_araddr[25] = \<const0> ;
  assign m_axi_lite_ch2_araddr[24] = \<const0> ;
  assign m_axi_lite_ch2_araddr[23] = \<const0> ;
  assign m_axi_lite_ch2_araddr[22] = \<const0> ;
  assign m_axi_lite_ch2_araddr[21] = \<const0> ;
  assign m_axi_lite_ch2_araddr[20] = \<const0> ;
  assign m_axi_lite_ch2_araddr[19] = \<const0> ;
  assign m_axi_lite_ch2_araddr[18] = \<const0> ;
  assign m_axi_lite_ch2_araddr[17] = \<const0> ;
  assign m_axi_lite_ch2_araddr[16] = \<const0> ;
  assign m_axi_lite_ch2_araddr[15] = \<const0> ;
  assign m_axi_lite_ch2_araddr[14] = \<const0> ;
  assign m_axi_lite_ch2_araddr[13] = \<const0> ;
  assign m_axi_lite_ch2_araddr[12] = \<const0> ;
  assign m_axi_lite_ch2_araddr[11] = \<const0> ;
  assign m_axi_lite_ch2_araddr[10] = \<const0> ;
  assign m_axi_lite_ch2_araddr[9] = \<const0> ;
  assign m_axi_lite_ch2_araddr[8] = \<const0> ;
  assign m_axi_lite_ch2_araddr[7] = \<const0> ;
  assign m_axi_lite_ch2_araddr[6] = \<const0> ;
  assign m_axi_lite_ch2_araddr[5] = \<const0> ;
  assign m_axi_lite_ch2_araddr[4] = \<const0> ;
  assign m_axi_lite_ch2_araddr[3] = \<const0> ;
  assign m_axi_lite_ch2_araddr[2] = \<const0> ;
  assign m_axi_lite_ch2_araddr[1] = \<const0> ;
  assign m_axi_lite_ch2_araddr[0] = \<const0> ;
  assign m_axi_lite_ch2_arvalid = \<const0> ;
  assign m_axi_lite_ch2_awaddr[31] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[30] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[29] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[28] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[27] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[26] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[25] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[24] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[23] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[22] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[21] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[20] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[19] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[18] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[17] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[16] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[15] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[14] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[13] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[12] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[11] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[10] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[9] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[8] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[7] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[6] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[5] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[4] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[3] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[2] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[1] = \<const0> ;
  assign m_axi_lite_ch2_awaddr[0] = \<const0> ;
  assign m_axi_lite_ch2_awprot[2] = \<const0> ;
  assign m_axi_lite_ch2_awprot[1] = \<const0> ;
  assign m_axi_lite_ch2_awprot[0] = \<const0> ;
  assign m_axi_lite_ch2_awvalid = \<const0> ;
  assign m_axi_lite_ch2_bready = \<const0> ;
  assign m_axi_lite_ch2_rready = \<const0> ;
  assign m_axi_lite_ch2_wdata[31] = \<const0> ;
  assign m_axi_lite_ch2_wdata[30] = \<const0> ;
  assign m_axi_lite_ch2_wdata[29] = \<const0> ;
  assign m_axi_lite_ch2_wdata[28] = \<const0> ;
  assign m_axi_lite_ch2_wdata[27] = \<const0> ;
  assign m_axi_lite_ch2_wdata[26] = \<const0> ;
  assign m_axi_lite_ch2_wdata[25] = \<const0> ;
  assign m_axi_lite_ch2_wdata[24] = \<const0> ;
  assign m_axi_lite_ch2_wdata[23] = \<const0> ;
  assign m_axi_lite_ch2_wdata[22] = \<const0> ;
  assign m_axi_lite_ch2_wdata[21] = \<const0> ;
  assign m_axi_lite_ch2_wdata[20] = \<const0> ;
  assign m_axi_lite_ch2_wdata[19] = \<const0> ;
  assign m_axi_lite_ch2_wdata[18] = \<const0> ;
  assign m_axi_lite_ch2_wdata[17] = \<const0> ;
  assign m_axi_lite_ch2_wdata[16] = \<const0> ;
  assign m_axi_lite_ch2_wdata[15] = \<const0> ;
  assign m_axi_lite_ch2_wdata[14] = \<const0> ;
  assign m_axi_lite_ch2_wdata[13] = \<const0> ;
  assign m_axi_lite_ch2_wdata[12] = \<const0> ;
  assign m_axi_lite_ch2_wdata[11] = \<const0> ;
  assign m_axi_lite_ch2_wdata[10] = \<const0> ;
  assign m_axi_lite_ch2_wdata[9] = \<const0> ;
  assign m_axi_lite_ch2_wdata[8] = \<const0> ;
  assign m_axi_lite_ch2_wdata[7] = \<const0> ;
  assign m_axi_lite_ch2_wdata[6] = \<const0> ;
  assign m_axi_lite_ch2_wdata[5] = \<const0> ;
  assign m_axi_lite_ch2_wdata[4] = \<const0> ;
  assign m_axi_lite_ch2_wdata[3] = \<const0> ;
  assign m_axi_lite_ch2_wdata[2] = \<const0> ;
  assign m_axi_lite_ch2_wdata[1] = \<const0> ;
  assign m_axi_lite_ch2_wdata[0] = \<const0> ;
  assign m_axi_lite_ch2_wstrb[3] = \<const0> ;
  assign m_axi_lite_ch2_wstrb[2] = \<const0> ;
  assign m_axi_lite_ch2_wstrb[1] = \<const0> ;
  assign m_axi_lite_ch2_wstrb[0] = \<const0> ;
  assign m_axi_lite_ch2_wvalid = \<const0> ;
  assign m_axi_lite_ch3_araddr[31] = \<const0> ;
  assign m_axi_lite_ch3_araddr[30] = \<const0> ;
  assign m_axi_lite_ch3_araddr[29] = \<const0> ;
  assign m_axi_lite_ch3_araddr[28] = \<const0> ;
  assign m_axi_lite_ch3_araddr[27] = \<const0> ;
  assign m_axi_lite_ch3_araddr[26] = \<const0> ;
  assign m_axi_lite_ch3_araddr[25] = \<const0> ;
  assign m_axi_lite_ch3_araddr[24] = \<const0> ;
  assign m_axi_lite_ch3_araddr[23] = \<const0> ;
  assign m_axi_lite_ch3_araddr[22] = \<const0> ;
  assign m_axi_lite_ch3_araddr[21] = \<const0> ;
  assign m_axi_lite_ch3_araddr[20] = \<const0> ;
  assign m_axi_lite_ch3_araddr[19] = \<const0> ;
  assign m_axi_lite_ch3_araddr[18] = \<const0> ;
  assign m_axi_lite_ch3_araddr[17] = \<const0> ;
  assign m_axi_lite_ch3_araddr[16] = \<const0> ;
  assign m_axi_lite_ch3_araddr[15] = \<const0> ;
  assign m_axi_lite_ch3_araddr[14] = \<const0> ;
  assign m_axi_lite_ch3_araddr[13] = \<const0> ;
  assign m_axi_lite_ch3_araddr[12] = \<const0> ;
  assign m_axi_lite_ch3_araddr[11] = \<const0> ;
  assign m_axi_lite_ch3_araddr[10] = \<const0> ;
  assign m_axi_lite_ch3_araddr[9] = \<const0> ;
  assign m_axi_lite_ch3_araddr[8] = \<const0> ;
  assign m_axi_lite_ch3_araddr[7] = \<const0> ;
  assign m_axi_lite_ch3_araddr[6] = \<const0> ;
  assign m_axi_lite_ch3_araddr[5] = \<const0> ;
  assign m_axi_lite_ch3_araddr[4] = \<const0> ;
  assign m_axi_lite_ch3_araddr[3] = \<const0> ;
  assign m_axi_lite_ch3_araddr[2] = \<const0> ;
  assign m_axi_lite_ch3_araddr[1] = \<const0> ;
  assign m_axi_lite_ch3_araddr[0] = \<const0> ;
  assign m_axi_lite_ch3_arvalid = \<const0> ;
  assign m_axi_lite_ch3_awaddr[31] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[30] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[29] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[28] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[27] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[26] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[25] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[24] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[23] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[22] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[21] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[20] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[19] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[18] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[17] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[16] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[15] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[14] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[13] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[12] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[11] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[10] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[9] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[8] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[7] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[6] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[5] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[4] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[3] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[2] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[1] = \<const0> ;
  assign m_axi_lite_ch3_awaddr[0] = \<const0> ;
  assign m_axi_lite_ch3_awprot[2] = \<const0> ;
  assign m_axi_lite_ch3_awprot[1] = \<const0> ;
  assign m_axi_lite_ch3_awprot[0] = \<const0> ;
  assign m_axi_lite_ch3_awvalid = \<const0> ;
  assign m_axi_lite_ch3_bready = \<const0> ;
  assign m_axi_lite_ch3_rready = \<const0> ;
  assign m_axi_lite_ch3_wdata[31] = \<const0> ;
  assign m_axi_lite_ch3_wdata[30] = \<const0> ;
  assign m_axi_lite_ch3_wdata[29] = \<const0> ;
  assign m_axi_lite_ch3_wdata[28] = \<const0> ;
  assign m_axi_lite_ch3_wdata[27] = \<const0> ;
  assign m_axi_lite_ch3_wdata[26] = \<const0> ;
  assign m_axi_lite_ch3_wdata[25] = \<const0> ;
  assign m_axi_lite_ch3_wdata[24] = \<const0> ;
  assign m_axi_lite_ch3_wdata[23] = \<const0> ;
  assign m_axi_lite_ch3_wdata[22] = \<const0> ;
  assign m_axi_lite_ch3_wdata[21] = \<const0> ;
  assign m_axi_lite_ch3_wdata[20] = \<const0> ;
  assign m_axi_lite_ch3_wdata[19] = \<const0> ;
  assign m_axi_lite_ch3_wdata[18] = \<const0> ;
  assign m_axi_lite_ch3_wdata[17] = \<const0> ;
  assign m_axi_lite_ch3_wdata[16] = \<const0> ;
  assign m_axi_lite_ch3_wdata[15] = \<const0> ;
  assign m_axi_lite_ch3_wdata[14] = \<const0> ;
  assign m_axi_lite_ch3_wdata[13] = \<const0> ;
  assign m_axi_lite_ch3_wdata[12] = \<const0> ;
  assign m_axi_lite_ch3_wdata[11] = \<const0> ;
  assign m_axi_lite_ch3_wdata[10] = \<const0> ;
  assign m_axi_lite_ch3_wdata[9] = \<const0> ;
  assign m_axi_lite_ch3_wdata[8] = \<const0> ;
  assign m_axi_lite_ch3_wdata[7] = \<const0> ;
  assign m_axi_lite_ch3_wdata[6] = \<const0> ;
  assign m_axi_lite_ch3_wdata[5] = \<const0> ;
  assign m_axi_lite_ch3_wdata[4] = \<const0> ;
  assign m_axi_lite_ch3_wdata[3] = \<const0> ;
  assign m_axi_lite_ch3_wdata[2] = \<const0> ;
  assign m_axi_lite_ch3_wdata[1] = \<const0> ;
  assign m_axi_lite_ch3_wdata[0] = \<const0> ;
  assign m_axi_lite_ch3_wstrb[3] = \<const0> ;
  assign m_axi_lite_ch3_wstrb[2] = \<const0> ;
  assign m_axi_lite_ch3_wstrb[1] = \<const0> ;
  assign m_axi_lite_ch3_wstrb[0] = \<const0> ;
  assign m_axi_lite_ch3_wvalid = \<const0> ;
  assign m_axi_lite_ch4_araddr[31] = \<const0> ;
  assign m_axi_lite_ch4_araddr[30] = \<const0> ;
  assign m_axi_lite_ch4_araddr[29] = \<const0> ;
  assign m_axi_lite_ch4_araddr[28] = \<const0> ;
  assign m_axi_lite_ch4_araddr[27] = \<const0> ;
  assign m_axi_lite_ch4_araddr[26] = \<const0> ;
  assign m_axi_lite_ch4_araddr[25] = \<const0> ;
  assign m_axi_lite_ch4_araddr[24] = \<const0> ;
  assign m_axi_lite_ch4_araddr[23] = \<const0> ;
  assign m_axi_lite_ch4_araddr[22] = \<const0> ;
  assign m_axi_lite_ch4_araddr[21] = \<const0> ;
  assign m_axi_lite_ch4_araddr[20] = \<const0> ;
  assign m_axi_lite_ch4_araddr[19] = \<const0> ;
  assign m_axi_lite_ch4_araddr[18] = \<const0> ;
  assign m_axi_lite_ch4_araddr[17] = \<const0> ;
  assign m_axi_lite_ch4_araddr[16] = \<const0> ;
  assign m_axi_lite_ch4_araddr[15] = \<const0> ;
  assign m_axi_lite_ch4_araddr[14] = \<const0> ;
  assign m_axi_lite_ch4_araddr[13] = \<const0> ;
  assign m_axi_lite_ch4_araddr[12] = \<const0> ;
  assign m_axi_lite_ch4_araddr[11] = \<const0> ;
  assign m_axi_lite_ch4_araddr[10] = \<const0> ;
  assign m_axi_lite_ch4_araddr[9] = \<const0> ;
  assign m_axi_lite_ch4_araddr[8] = \<const0> ;
  assign m_axi_lite_ch4_araddr[7] = \<const0> ;
  assign m_axi_lite_ch4_araddr[6] = \<const0> ;
  assign m_axi_lite_ch4_araddr[5] = \<const0> ;
  assign m_axi_lite_ch4_araddr[4] = \<const0> ;
  assign m_axi_lite_ch4_araddr[3] = \<const0> ;
  assign m_axi_lite_ch4_araddr[2] = \<const0> ;
  assign m_axi_lite_ch4_araddr[1] = \<const0> ;
  assign m_axi_lite_ch4_araddr[0] = \<const0> ;
  assign m_axi_lite_ch4_arvalid = \<const0> ;
  assign m_axi_lite_ch4_awaddr[31] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[30] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[29] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[28] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[27] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[26] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[25] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[24] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[23] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[22] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[21] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[20] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[19] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[18] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[17] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[16] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[15] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[14] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[13] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[12] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[11] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[10] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[9] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[8] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[7] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[6] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[5] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[4] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[3] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[2] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[1] = \<const0> ;
  assign m_axi_lite_ch4_awaddr[0] = \<const0> ;
  assign m_axi_lite_ch4_awprot[2] = \<const0> ;
  assign m_axi_lite_ch4_awprot[1] = \<const0> ;
  assign m_axi_lite_ch4_awprot[0] = \<const0> ;
  assign m_axi_lite_ch4_awvalid = \<const0> ;
  assign m_axi_lite_ch4_bready = \<const0> ;
  assign m_axi_lite_ch4_rready = \<const0> ;
  assign m_axi_lite_ch4_wdata[31] = \<const0> ;
  assign m_axi_lite_ch4_wdata[30] = \<const0> ;
  assign m_axi_lite_ch4_wdata[29] = \<const0> ;
  assign m_axi_lite_ch4_wdata[28] = \<const0> ;
  assign m_axi_lite_ch4_wdata[27] = \<const0> ;
  assign m_axi_lite_ch4_wdata[26] = \<const0> ;
  assign m_axi_lite_ch4_wdata[25] = \<const0> ;
  assign m_axi_lite_ch4_wdata[24] = \<const0> ;
  assign m_axi_lite_ch4_wdata[23] = \<const0> ;
  assign m_axi_lite_ch4_wdata[22] = \<const0> ;
  assign m_axi_lite_ch4_wdata[21] = \<const0> ;
  assign m_axi_lite_ch4_wdata[20] = \<const0> ;
  assign m_axi_lite_ch4_wdata[19] = \<const0> ;
  assign m_axi_lite_ch4_wdata[18] = \<const0> ;
  assign m_axi_lite_ch4_wdata[17] = \<const0> ;
  assign m_axi_lite_ch4_wdata[16] = \<const0> ;
  assign m_axi_lite_ch4_wdata[15] = \<const0> ;
  assign m_axi_lite_ch4_wdata[14] = \<const0> ;
  assign m_axi_lite_ch4_wdata[13] = \<const0> ;
  assign m_axi_lite_ch4_wdata[12] = \<const0> ;
  assign m_axi_lite_ch4_wdata[11] = \<const0> ;
  assign m_axi_lite_ch4_wdata[10] = \<const0> ;
  assign m_axi_lite_ch4_wdata[9] = \<const0> ;
  assign m_axi_lite_ch4_wdata[8] = \<const0> ;
  assign m_axi_lite_ch4_wdata[7] = \<const0> ;
  assign m_axi_lite_ch4_wdata[6] = \<const0> ;
  assign m_axi_lite_ch4_wdata[5] = \<const0> ;
  assign m_axi_lite_ch4_wdata[4] = \<const0> ;
  assign m_axi_lite_ch4_wdata[3] = \<const0> ;
  assign m_axi_lite_ch4_wdata[2] = \<const0> ;
  assign m_axi_lite_ch4_wdata[1] = \<const0> ;
  assign m_axi_lite_ch4_wdata[0] = \<const0> ;
  assign m_axi_lite_ch4_wstrb[3] = \<const0> ;
  assign m_axi_lite_ch4_wstrb[2] = \<const0> ;
  assign m_axi_lite_ch4_wstrb[1] = \<const0> ;
  assign m_axi_lite_ch4_wstrb[0] = \<const0> ;
  assign m_axi_lite_ch4_wvalid = \<const0> ;
  assign m_axi_lite_ch5_araddr[31] = \<const0> ;
  assign m_axi_lite_ch5_araddr[30] = \<const0> ;
  assign m_axi_lite_ch5_araddr[29] = \<const0> ;
  assign m_axi_lite_ch5_araddr[28] = \<const0> ;
  assign m_axi_lite_ch5_araddr[27] = \<const0> ;
  assign m_axi_lite_ch5_araddr[26] = \<const0> ;
  assign m_axi_lite_ch5_araddr[25] = \<const0> ;
  assign m_axi_lite_ch5_araddr[24] = \<const0> ;
  assign m_axi_lite_ch5_araddr[23] = \<const0> ;
  assign m_axi_lite_ch5_araddr[22] = \<const0> ;
  assign m_axi_lite_ch5_araddr[21] = \<const0> ;
  assign m_axi_lite_ch5_araddr[20] = \<const0> ;
  assign m_axi_lite_ch5_araddr[19] = \<const0> ;
  assign m_axi_lite_ch5_araddr[18] = \<const0> ;
  assign m_axi_lite_ch5_araddr[17] = \<const0> ;
  assign m_axi_lite_ch5_araddr[16] = \<const0> ;
  assign m_axi_lite_ch5_araddr[15] = \<const0> ;
  assign m_axi_lite_ch5_araddr[14] = \<const0> ;
  assign m_axi_lite_ch5_araddr[13] = \<const0> ;
  assign m_axi_lite_ch5_araddr[12] = \<const0> ;
  assign m_axi_lite_ch5_araddr[11] = \<const0> ;
  assign m_axi_lite_ch5_araddr[10] = \<const0> ;
  assign m_axi_lite_ch5_araddr[9] = \<const0> ;
  assign m_axi_lite_ch5_araddr[8] = \<const0> ;
  assign m_axi_lite_ch5_araddr[7] = \<const0> ;
  assign m_axi_lite_ch5_araddr[6] = \<const0> ;
  assign m_axi_lite_ch5_araddr[5] = \<const0> ;
  assign m_axi_lite_ch5_araddr[4] = \<const0> ;
  assign m_axi_lite_ch5_araddr[3] = \<const0> ;
  assign m_axi_lite_ch5_araddr[2] = \<const0> ;
  assign m_axi_lite_ch5_araddr[1] = \<const0> ;
  assign m_axi_lite_ch5_araddr[0] = \<const0> ;
  assign m_axi_lite_ch5_arvalid = \<const0> ;
  assign m_axi_lite_ch5_awaddr[31] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[30] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[29] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[28] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[27] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[26] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[25] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[24] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[23] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[22] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[21] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[20] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[19] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[18] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[17] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[16] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[15] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[14] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[13] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[12] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[11] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[10] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[9] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[8] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[7] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[6] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[5] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[4] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[3] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[2] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[1] = \<const0> ;
  assign m_axi_lite_ch5_awaddr[0] = \<const0> ;
  assign m_axi_lite_ch5_awprot[2] = \<const0> ;
  assign m_axi_lite_ch5_awprot[1] = \<const0> ;
  assign m_axi_lite_ch5_awprot[0] = \<const0> ;
  assign m_axi_lite_ch5_awvalid = \<const0> ;
  assign m_axi_lite_ch5_bready = \<const0> ;
  assign m_axi_lite_ch5_rready = \<const0> ;
  assign m_axi_lite_ch5_wdata[31] = \<const0> ;
  assign m_axi_lite_ch5_wdata[30] = \<const0> ;
  assign m_axi_lite_ch5_wdata[29] = \<const0> ;
  assign m_axi_lite_ch5_wdata[28] = \<const0> ;
  assign m_axi_lite_ch5_wdata[27] = \<const0> ;
  assign m_axi_lite_ch5_wdata[26] = \<const0> ;
  assign m_axi_lite_ch5_wdata[25] = \<const0> ;
  assign m_axi_lite_ch5_wdata[24] = \<const0> ;
  assign m_axi_lite_ch5_wdata[23] = \<const0> ;
  assign m_axi_lite_ch5_wdata[22] = \<const0> ;
  assign m_axi_lite_ch5_wdata[21] = \<const0> ;
  assign m_axi_lite_ch5_wdata[20] = \<const0> ;
  assign m_axi_lite_ch5_wdata[19] = \<const0> ;
  assign m_axi_lite_ch5_wdata[18] = \<const0> ;
  assign m_axi_lite_ch5_wdata[17] = \<const0> ;
  assign m_axi_lite_ch5_wdata[16] = \<const0> ;
  assign m_axi_lite_ch5_wdata[15] = \<const0> ;
  assign m_axi_lite_ch5_wdata[14] = \<const0> ;
  assign m_axi_lite_ch5_wdata[13] = \<const0> ;
  assign m_axi_lite_ch5_wdata[12] = \<const0> ;
  assign m_axi_lite_ch5_wdata[11] = \<const0> ;
  assign m_axi_lite_ch5_wdata[10] = \<const0> ;
  assign m_axi_lite_ch5_wdata[9] = \<const0> ;
  assign m_axi_lite_ch5_wdata[8] = \<const0> ;
  assign m_axi_lite_ch5_wdata[7] = \<const0> ;
  assign m_axi_lite_ch5_wdata[6] = \<const0> ;
  assign m_axi_lite_ch5_wdata[5] = \<const0> ;
  assign m_axi_lite_ch5_wdata[4] = \<const0> ;
  assign m_axi_lite_ch5_wdata[3] = \<const0> ;
  assign m_axi_lite_ch5_wdata[2] = \<const0> ;
  assign m_axi_lite_ch5_wdata[1] = \<const0> ;
  assign m_axi_lite_ch5_wdata[0] = \<const0> ;
  assign m_axi_lite_ch5_wstrb[3] = \<const0> ;
  assign m_axi_lite_ch5_wstrb[2] = \<const0> ;
  assign m_axi_lite_ch5_wstrb[1] = \<const0> ;
  assign m_axi_lite_ch5_wstrb[0] = \<const0> ;
  assign m_axi_lite_ch5_wvalid = \<const0> ;
  assign m_axi_rready = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6] = \<const0> ;
  assign m_axi_wdata[5] = \<const0> ;
  assign m_axi_wdata[4] = \<const0> ;
  assign m_axi_wdata[3] = \<const0> ;
  assign m_axi_wdata[2] = \<const0> ;
  assign m_axi_wdata[1] = \<const0> ;
  assign m_axi_wdata[0] = \<const0> ;
  assign m_axi_wlast = \<const0> ;
  assign m_axi_wstrb[3] = \<const0> ;
  assign m_axi_wstrb[2] = \<const0> ;
  assign m_axi_wstrb[1] = \<const0> ;
  assign m_axi_wstrb[0] = \<const0> ;
  assign m_axi_wvalid = \<const0> ;
  assign m_axis_1_tdata[31] = \<const0> ;
  assign m_axis_1_tdata[30] = \<const0> ;
  assign m_axis_1_tdata[29] = \<const0> ;
  assign m_axis_1_tdata[28] = \<const0> ;
  assign m_axis_1_tdata[27] = \<const0> ;
  assign m_axis_1_tdata[26] = \<const0> ;
  assign m_axis_1_tdata[25] = \<const0> ;
  assign m_axis_1_tdata[24] = \<const0> ;
  assign m_axis_1_tdata[23] = \<const0> ;
  assign m_axis_1_tdata[22] = \<const0> ;
  assign m_axis_1_tdata[21] = \<const0> ;
  assign m_axis_1_tdata[20] = \<const0> ;
  assign m_axis_1_tdata[19] = \<const0> ;
  assign m_axis_1_tdata[18] = \<const0> ;
  assign m_axis_1_tdata[17] = \<const0> ;
  assign m_axis_1_tdata[16] = \<const0> ;
  assign m_axis_1_tdata[15] = \<const0> ;
  assign m_axis_1_tdata[14] = \<const0> ;
  assign m_axis_1_tdata[13] = \<const0> ;
  assign m_axis_1_tdata[12] = \<const0> ;
  assign m_axis_1_tdata[11] = \<const0> ;
  assign m_axis_1_tdata[10] = \<const0> ;
  assign m_axis_1_tdata[9] = \<const0> ;
  assign m_axis_1_tdata[8] = \<const0> ;
  assign m_axis_1_tdata[7] = \<const0> ;
  assign m_axis_1_tdata[6] = \<const0> ;
  assign m_axis_1_tdata[5] = \<const0> ;
  assign m_axis_1_tdata[4] = \<const0> ;
  assign m_axis_1_tdata[3] = \<const0> ;
  assign m_axis_1_tdata[2] = \<const0> ;
  assign m_axis_1_tdata[1] = \<const0> ;
  assign m_axis_1_tdata[0] = \<const0> ;
  assign m_axis_1_tdest[7] = \<const0> ;
  assign m_axis_1_tdest[6] = \<const0> ;
  assign m_axis_1_tdest[5] = \<const0> ;
  assign m_axis_1_tdest[4] = \<const0> ;
  assign m_axis_1_tdest[3] = \<const0> ;
  assign m_axis_1_tdest[2] = \<const0> ;
  assign m_axis_1_tdest[1] = \<const0> ;
  assign m_axis_1_tdest[0] = \<const0> ;
  assign m_axis_1_tid[7] = \<const0> ;
  assign m_axis_1_tid[6] = \<const0> ;
  assign m_axis_1_tid[5] = \<const0> ;
  assign m_axis_1_tid[4] = \<const0> ;
  assign m_axis_1_tid[3] = \<const0> ;
  assign m_axis_1_tid[2] = \<const0> ;
  assign m_axis_1_tid[1] = \<const0> ;
  assign m_axis_1_tid[0] = \<const0> ;
  assign m_axis_1_tkeep[3] = \<const0> ;
  assign m_axis_1_tkeep[2] = \<const0> ;
  assign m_axis_1_tkeep[1] = \<const0> ;
  assign m_axis_1_tkeep[0] = \<const0> ;
  assign m_axis_1_tlast = \<const0> ;
  assign m_axis_1_tstrb[3] = \<const0> ;
  assign m_axis_1_tstrb[2] = \<const0> ;
  assign m_axis_1_tstrb[1] = \<const0> ;
  assign m_axis_1_tstrb[0] = \<const0> ;
  assign m_axis_1_tuser[7] = \<const0> ;
  assign m_axis_1_tuser[6] = \<const0> ;
  assign m_axis_1_tuser[5] = \<const0> ;
  assign m_axis_1_tuser[4] = \<const0> ;
  assign m_axis_1_tuser[3] = \<const0> ;
  assign m_axis_1_tuser[2] = \<const0> ;
  assign m_axis_1_tuser[1] = \<const0> ;
  assign m_axis_1_tuser[0] = \<const0> ;
  assign m_axis_1_tvalid = \<const0> ;
  assign m_axis_2_tdata[31] = \<const0> ;
  assign m_axis_2_tdata[30] = \<const0> ;
  assign m_axis_2_tdata[29] = \<const0> ;
  assign m_axis_2_tdata[28] = \<const0> ;
  assign m_axis_2_tdata[27] = \<const0> ;
  assign m_axis_2_tdata[26] = \<const0> ;
  assign m_axis_2_tdata[25] = \<const0> ;
  assign m_axis_2_tdata[24] = \<const0> ;
  assign m_axis_2_tdata[23] = \<const0> ;
  assign m_axis_2_tdata[22] = \<const0> ;
  assign m_axis_2_tdata[21] = \<const0> ;
  assign m_axis_2_tdata[20] = \<const0> ;
  assign m_axis_2_tdata[19] = \<const0> ;
  assign m_axis_2_tdata[18] = \<const0> ;
  assign m_axis_2_tdata[17] = \<const0> ;
  assign m_axis_2_tdata[16] = \<const0> ;
  assign m_axis_2_tdata[15] = \<const0> ;
  assign m_axis_2_tdata[14] = \<const0> ;
  assign m_axis_2_tdata[13] = \<const0> ;
  assign m_axis_2_tdata[12] = \<const0> ;
  assign m_axis_2_tdata[11] = \<const0> ;
  assign m_axis_2_tdata[10] = \<const0> ;
  assign m_axis_2_tdata[9] = \<const0> ;
  assign m_axis_2_tdata[8] = \<const0> ;
  assign m_axis_2_tdata[7] = \<const0> ;
  assign m_axis_2_tdata[6] = \<const0> ;
  assign m_axis_2_tdata[5] = \<const0> ;
  assign m_axis_2_tdata[4] = \<const0> ;
  assign m_axis_2_tdata[3] = \<const0> ;
  assign m_axis_2_tdata[2] = \<const0> ;
  assign m_axis_2_tdata[1] = \<const0> ;
  assign m_axis_2_tdata[0] = \<const0> ;
  assign m_axis_2_tdest[7] = \<const0> ;
  assign m_axis_2_tdest[6] = \<const0> ;
  assign m_axis_2_tdest[5] = \<const0> ;
  assign m_axis_2_tdest[4] = \<const0> ;
  assign m_axis_2_tdest[3] = \<const0> ;
  assign m_axis_2_tdest[2] = \<const0> ;
  assign m_axis_2_tdest[1] = \<const0> ;
  assign m_axis_2_tdest[0] = \<const0> ;
  assign m_axis_2_tid[7] = \<const0> ;
  assign m_axis_2_tid[6] = \<const0> ;
  assign m_axis_2_tid[5] = \<const0> ;
  assign m_axis_2_tid[4] = \<const0> ;
  assign m_axis_2_tid[3] = \<const0> ;
  assign m_axis_2_tid[2] = \<const0> ;
  assign m_axis_2_tid[1] = \<const0> ;
  assign m_axis_2_tid[0] = \<const0> ;
  assign m_axis_2_tkeep[3] = \<const0> ;
  assign m_axis_2_tkeep[2] = \<const0> ;
  assign m_axis_2_tkeep[1] = \<const0> ;
  assign m_axis_2_tkeep[0] = \<const0> ;
  assign m_axis_2_tlast = \<const0> ;
  assign m_axis_2_tstrb[3] = \<const0> ;
  assign m_axis_2_tstrb[2] = \<const0> ;
  assign m_axis_2_tstrb[1] = \<const0> ;
  assign m_axis_2_tstrb[0] = \<const0> ;
  assign m_axis_2_tuser[7] = \<const0> ;
  assign m_axis_2_tuser[6] = \<const0> ;
  assign m_axis_2_tuser[5] = \<const0> ;
  assign m_axis_2_tuser[4] = \<const0> ;
  assign m_axis_2_tuser[3] = \<const0> ;
  assign m_axis_2_tuser[2] = \<const0> ;
  assign m_axis_2_tuser[1] = \<const0> ;
  assign m_axis_2_tuser[0] = \<const0> ;
  assign m_axis_2_tvalid = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign s_axis_1_tready = \<const0> ;
  assign s_axis_2_tready = \<const0> ;
  assign status[31:16] = \^status [31:16];
  assign status[15] = \<const0> ;
  assign status[14] = \<const0> ;
  assign status[13] = \<const0> ;
  assign status[12] = \<const0> ;
  assign status[11] = \<const0> ;
  assign status[10] = \<const0> ;
  assign status[9:0] = \^status [9:0];
  mipi_init_gen_axi_traffic_gen_v3_0_20_systeminit_top \ATG_MODE_SYSTEM_INIT_TEST.systeminit_top 
       (.done(done),
        .m_axi_lite_ch1_araddr(m_axi_lite_ch1_araddr),
        .m_axi_lite_ch1_arready(m_axi_lite_ch1_arready),
        .m_axi_lite_ch1_arvalid(m_axi_lite_ch1_arvalid),
        .m_axi_lite_ch1_awaddr(m_axi_lite_ch1_awaddr),
        .m_axi_lite_ch1_awready(m_axi_lite_ch1_awready),
        .m_axi_lite_ch1_awvalid(m_axi_lite_ch1_awvalid),
        .m_axi_lite_ch1_bready(m_axi_lite_ch1_bready),
        .m_axi_lite_ch1_bresp(m_axi_lite_ch1_bresp[0]),
        .m_axi_lite_ch1_bvalid(m_axi_lite_ch1_bvalid),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata),
        .m_axi_lite_ch1_rready(m_axi_lite_ch1_rready),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp),
        .m_axi_lite_ch1_rvalid(m_axi_lite_ch1_rvalid),
        .m_axi_lite_ch1_wdata(m_axi_lite_ch1_wdata),
        .m_axi_lite_ch1_wready(m_axi_lite_ch1_wready),
        .m_axi_lite_ch1_wvalid(m_axi_lite_ch1_wvalid),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .status({\^status [31:16],\^status [9:0]}));
  GND GND
       (.G(\<const0> ));
  (* DONT_TOUCH *) 
  mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__3 ext_st_sync_flop_0
       (.clk(s_axi_aclk),
        .data(1'b0),
        .q(st_flop_ze_out),
        .reset(core_ext_stop));
  (* DONT_TOUCH *) 
  mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff ext_st_sync_flop_1
       (.clk(s_axi_aclk),
        .data(st_flop_ze_out),
        .q(st_flop_fi_out),
        .reset(core_ext_stop));
  (* DONT_TOUCH *) 
  mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__1 ext_sync_flop_0
       (.clk(s_axi_aclk),
        .data(1'b0),
        .q(flop_ze_out),
        .reset(core_ext_start));
  (* DONT_TOUCH *) 
  mipi_init_gen_axi_traffic_gen_v3_0_20_asynch_rst_ff__2 ext_sync_flop_1
       (.clk(s_axi_aclk),
        .data(flop_ze_out),
        .q(flop_fi_out),
        .reset(core_ext_start));
endmodule

(* CHECK_LICENSE_TYPE = "mipi_init_gen,axi_traffic_gen_v3_0_20_top,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "axi_traffic_gen_v3_0_20_top,Vivado 2024.2.2" *) 
(* NotValidForBitStream *)
module mipi_init_gen
   (s_axi_aclk,
    s_axi_aresetn,
    m_axi_lite_ch1_awaddr,
    m_axi_lite_ch1_awprot,
    m_axi_lite_ch1_awvalid,
    m_axi_lite_ch1_awready,
    m_axi_lite_ch1_wdata,
    m_axi_lite_ch1_wstrb,
    m_axi_lite_ch1_wvalid,
    m_axi_lite_ch1_wready,
    m_axi_lite_ch1_bresp,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_bready,
    m_axi_lite_ch1_araddr,
    m_axi_lite_ch1_arvalid,
    m_axi_lite_ch1_arready,
    m_axi_lite_ch1_rdata,
    m_axi_lite_ch1_rvalid,
    m_axi_lite_ch1_rresp,
    m_axi_lite_ch1_rready,
    done,
    status);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clock CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clock, ASSOCIATED_BUSIF S_AXI:M_AXI:M_AXIS_MASTER:S_AXIS_MASTER:M_AXIS_SLAVE:S_AXIS_SLAVE:M_AXI_LITE_CH1:M_AXI_LITE_CH2:M_AXI_LITE_CH3:M_AXI_LITE_CH4:M_AXI_LITE_CH5, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_LITE_CH1, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]m_axi_lite_ch1_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 AWPROT" *) output [2:0]m_axi_lite_ch1_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 AWVALID" *) output m_axi_lite_ch1_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 AWREADY" *) input m_axi_lite_ch1_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 WDATA" *) output [31:0]m_axi_lite_ch1_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 WSTRB" *) output [3:0]m_axi_lite_ch1_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 WVALID" *) output m_axi_lite_ch1_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 WREADY" *) input m_axi_lite_ch1_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 BRESP" *) input [1:0]m_axi_lite_ch1_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 BVALID" *) input m_axi_lite_ch1_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 BREADY" *) output m_axi_lite_ch1_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 ARADDR" *) output [31:0]m_axi_lite_ch1_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 ARVALID" *) output m_axi_lite_ch1_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 ARREADY" *) input m_axi_lite_ch1_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 RDATA" *) input [31:0]m_axi_lite_ch1_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 RVALID" *) input m_axi_lite_ch1_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 RRESP" *) input [1:0]m_axi_lite_ch1_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_LITE_CH1 RREADY" *) output m_axi_lite_ch1_rready;
  output done;
  output [31:0]status;

  wire \<const0> ;
  wire \<const1> ;
  wire done;
  wire [31:0]m_axi_lite_ch1_araddr;
  wire m_axi_lite_ch1_arready;
  wire m_axi_lite_ch1_arvalid;
  wire [31:0]m_axi_lite_ch1_awaddr;
  wire m_axi_lite_ch1_awready;
  wire m_axi_lite_ch1_awvalid;
  wire m_axi_lite_ch1_bready;
  wire [1:0]m_axi_lite_ch1_bresp;
  wire m_axi_lite_ch1_bvalid;
  wire [31:0]m_axi_lite_ch1_rdata;
  wire m_axi_lite_ch1_rready;
  wire [1:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rvalid;
  wire [31:0]m_axi_lite_ch1_wdata;
  wire m_axi_lite_ch1_wready;
  wire m_axi_lite_ch1_wvalid;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire [31:0]\^status ;
  wire NLW_inst_err_out_UNCONNECTED;
  wire NLW_inst_irq_out_UNCONNECTED;
  wire NLW_inst_m_axi_arvalid_UNCONNECTED;
  wire NLW_inst_m_axi_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_bready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch2_arvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch2_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch2_bready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch2_rready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch2_wvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch3_arvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch3_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch3_bready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch3_rready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch3_wvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch4_arvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch4_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch4_bready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch4_rready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch4_wvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch5_arvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch5_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch5_bready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch5_rready_UNCONNECTED;
  wire NLW_inst_m_axi_lite_ch5_wvalid_UNCONNECTED;
  wire NLW_inst_m_axi_rready_UNCONNECTED;
  wire NLW_inst_m_axi_wlast_UNCONNECTED;
  wire NLW_inst_m_axi_wvalid_UNCONNECTED;
  wire NLW_inst_m_axis_1_tlast_UNCONNECTED;
  wire NLW_inst_m_axis_1_tvalid_UNCONNECTED;
  wire NLW_inst_m_axis_2_tlast_UNCONNECTED;
  wire NLW_inst_m_axis_2_tvalid_UNCONNECTED;
  wire NLW_inst_s_axi_arready_UNCONNECTED;
  wire NLW_inst_s_axi_awready_UNCONNECTED;
  wire NLW_inst_s_axi_bvalid_UNCONNECTED;
  wire NLW_inst_s_axi_rlast_UNCONNECTED;
  wire NLW_inst_s_axi_rvalid_UNCONNECTED;
  wire NLW_inst_s_axi_wready_UNCONNECTED;
  wire NLW_inst_s_axis_1_tready_UNCONNECTED;
  wire NLW_inst_s_axis_2_tready_UNCONNECTED;
  wire [15:0]NLW_inst_axis_err_count_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_arqos_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_arsize_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_awqos_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_awsize_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_awuser_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_lite_ch1_awprot_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_lite_ch1_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch2_araddr_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch2_awaddr_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_lite_ch2_awprot_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch2_wdata_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_lite_ch2_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch3_araddr_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch3_awaddr_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_lite_ch3_awprot_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch3_wdata_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_lite_ch3_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch4_araddr_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch4_awaddr_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_lite_ch4_awprot_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch4_wdata_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_lite_ch4_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch5_araddr_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch5_awaddr_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_lite_ch5_awprot_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_lite_ch5_wdata_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_lite_ch5_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_wdata_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_wstrb_UNCONNECTED;
  wire [31:0]NLW_inst_m_axis_1_tdata_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_1_tdest_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_1_tid_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_1_tkeep_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_1_tstrb_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_1_tuser_UNCONNECTED;
  wire [31:0]NLW_inst_m_axis_2_tdata_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_2_tdest_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_2_tid_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_2_tkeep_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_2_tstrb_UNCONNECTED;
  wire [7:0]NLW_inst_m_axis_2_tuser_UNCONNECTED;
  wire [0:0]NLW_inst_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_inst_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_inst_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_rresp_UNCONNECTED;
  wire [15:10]NLW_inst_status_UNCONNECTED;

  assign m_axi_lite_ch1_awprot[2] = \<const0> ;
  assign m_axi_lite_ch1_awprot[1] = \<const0> ;
  assign m_axi_lite_ch1_awprot[0] = \<const0> ;
  assign m_axi_lite_ch1_wstrb[3] = \<const1> ;
  assign m_axi_lite_ch1_wstrb[2] = \<const1> ;
  assign m_axi_lite_ch1_wstrb[1] = \<const1> ;
  assign m_axi_lite_ch1_wstrb[0] = \<const1> ;
  assign status[31:16] = \^status [31:16];
  assign status[15] = \<const0> ;
  assign status[14] = \<const0> ;
  assign status[13] = \<const0> ;
  assign status[12] = \<const0> ;
  assign status[11] = \<const0> ;
  assign status[10] = \<const0> ;
  assign status[9:0] = \^status [9:0];
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* ATG_VERSAL_400 = "0" *) 
  (* C_ADDR_F = "mipi_init_gen_default_addrram.mem" *) 
  (* C_ATG_AXIS_DATA_GEN_TYPE = "0" *) 
  (* C_ATG_BASIC_AXI4 = "0" *) 
  (* C_ATG_HLTP_MODE = "0" *) 
  (* C_ATG_MIF_ADDR_BITS = "8" *) 
  (* C_ATG_MIF_DATA_DEPTH = "256" *) 
  (* C_ATG_REPEAT_TYPE = "0" *) 
  (* C_ATG_SLAVE_ONLY = "0" *) 
  (* C_ATG_STATIC = "0" *) 
  (* C_ATG_STATIC_EN_READ = "1" *) 
  (* C_ATG_STATIC_EN_WRITE = "1" *) 
  (* C_ATG_STATIC_FREE_RUN = "1" *) 
  (* C_ATG_STATIC_INCR = "0" *) 
  (* C_ATG_STATIC_LENGTH = "16" *) 
  (* C_ATG_STATIC_RD_ADDRESS = "64'b0000000000000000000000000000000000010011101000000000000000000000" *) 
  (* C_ATG_STATIC_RD_HIGH_ADDRESS = "64'b0000000000000000000000000000000000010011101000000000111111111111" *) 
  (* C_ATG_STATIC_RD_PIPELINE = "3" *) 
  (* C_ATG_STATIC_TRANGAP = "0" *) 
  (* C_ATG_STATIC_WR_ADDRESS = "64'b0000000000000000000000000000000000010010101000000000000000000000" *) 
  (* C_ATG_STATIC_WR_HIGH_ADDRESS = "64'b0000000000000000000000000000000000010010101000000000111111111111" *) 
  (* C_ATG_STATIC_WR_PIPELINE = "3" *) 
  (* C_ATG_STREAMING = "0" *) 
  (* C_ATG_STREAMING_MAX_LEN_BITS = "16" *) 
  (* C_ATG_STREAMING_MEM_FILE = "no_mem_file_loaded" *) 
  (* C_ATG_STREAMING_MST_LPBK = "0" *) 
  (* C_ATG_STREAMING_MST_ONLY = "1" *) 
  (* C_ATG_STREAMING_SLV_LPBK = "0" *) 
  (* C_ATG_SYSTEM_CH1_HIGH = "1151533055" *) 
  (* C_ATG_SYSTEM_CH1_LOW = "1151336448" *) 
  (* C_ATG_SYSTEM_CH2_HIGH = "511" *) 
  (* C_ATG_SYSTEM_CH2_LOW = "256" *) 
  (* C_ATG_SYSTEM_CH3_HIGH = "767" *) 
  (* C_ATG_SYSTEM_CH3_LOW = "512" *) 
  (* C_ATG_SYSTEM_CH4_HIGH = "1023" *) 
  (* C_ATG_SYSTEM_CH4_LOW = "768" *) 
  (* C_ATG_SYSTEM_CH5_HIGH = "1279" *) 
  (* C_ATG_SYSTEM_CH5_LOW = "1024" *) 
  (* C_ATG_SYSTEM_CMD_MAX_RETRY = "-16" *) 
  (* C_ATG_SYSTEM_INIT = "0" *) 
  (* C_ATG_SYSTEM_INIT_ADDR_MIF = "mipi_init_gen_addr.mem" *) 
  (* C_ATG_SYSTEM_INIT_CTRL_MIF = "mipi_init_gen_ctrl.mem" *) 
  (* C_ATG_SYSTEM_INIT_DATA_MIF = "mipi_init_gen_data.mem" *) 
  (* C_ATG_SYSTEM_INIT_MASK_MIF = "mipi_init_gen_mask.mem" *) 
  (* C_ATG_SYSTEM_MAX_CHANNELS = "1" *) 
  (* C_ATG_SYSTEM_TEST = "1" *) 
  (* C_ATG_SYSTEM_TEST_MAX_CLKS = "-6" *) 
  (* C_AXIS1_HAS_TKEEP = "1" *) 
  (* C_AXIS1_HAS_TSTRB = "1" *) 
  (* C_AXIS2_HAS_TKEEP = "0" *) 
  (* C_AXIS2_HAS_TSTRB = "0" *) 
  (* C_AXIS_SPARSE_EN = "1" *) 
  (* C_AXIS_TDATA_WIDTH = "32" *) 
  (* C_AXIS_TDEST_WIDTH = "8" *) 
  (* C_AXIS_TID_WIDTH = "8" *) 
  (* C_AXIS_TUSER_WIDTH = "8" *) 
  (* C_AXI_RD_ADDR_SEED = "16'b0101101001011010" *) 
  (* C_AXI_WR_ADDR_SEED = "16'b0111110010011011" *) 
  (* C_BASEADDR = "0" *) 
  (* C_CMDRAM_F = "mipi_init_gen_default_cmdram.mem" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HIGHADDR = "65535" *) 
  (* C_M_AXI_ADDR_WIDTH = "32" *) 
  (* C_M_AXI_ARUSER_WIDTH = "8" *) 
  (* C_M_AXI_AWUSER_WIDTH = "8" *) 
  (* C_M_AXI_DATA_WIDTH = "32" *) 
  (* C_M_AXI_THREAD_ID_WIDTH = "1" *) 
  (* C_NO_EXCL = "0" *) 
  (* C_PRAM_F = "mipi_init_gen_default_prmram.mem" *) 
  (* C_RAMINIT_ADDRRAM0_F = "mipi_init_gen_default_addrram.mem" *) 
  (* C_RAMINIT_CMDRAM0_F = "mipi_init_gen_default_cmdram.mem" *) 
  (* C_RAMINIT_CMDRAM1_F = "NONE" *) 
  (* C_RAMINIT_CMDRAM2_F = "NONE" *) 
  (* C_RAMINIT_CMDRAM3_F = "NONE" *) 
  (* C_RAMINIT_PARAMRAM0_F = "mipi_init_gen_default_prmram.mem" *) 
  (* C_RAMINIT_SRAM0_F = "mipi_init_gen_default_mstram.mem" *) 
  (* C_READ_ONLY = "0" *) 
  (* C_REPEAT_COUNT = "254" *) 
  (* C_SRAM_F = "mipi_init_gen_default_mstram.mem" *) 
  (* C_STRM_DATA_SEED = "16'b1010101111001101" *) 
  (* C_S_AXI_ARUSER_WIDTH = "8" *) 
  (* C_S_AXI_AWUSER_WIDTH = "8" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_ID_WIDTH = "1" *) 
  (* C_WRITE_ONLY = "0" *) 
  (* C_ZERO_INVALID = "1" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  mipi_init_gen_axi_traffic_gen_v3_0_20_top inst
       (.axis_err_count(NLW_inst_axis_err_count_UNCONNECTED[15:0]),
        .core_ext_start(1'b0),
        .core_ext_stop(1'b0),
        .done(done),
        .err_out(NLW_inst_err_out_UNCONNECTED),
        .irq_out(NLW_inst_irq_out_UNCONNECTED),
        .m_axi_araddr(NLW_inst_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_inst_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_inst_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_inst_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_inst_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_inst_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_inst_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_inst_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arsize(NLW_inst_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_inst_m_axi_aruser_UNCONNECTED[7:0]),
        .m_axi_arvalid(NLW_inst_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_inst_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_inst_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_inst_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_inst_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_inst_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_inst_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_inst_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_inst_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awsize(NLW_inst_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_inst_m_axi_awuser_UNCONNECTED[7:0]),
        .m_axi_awvalid(NLW_inst_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_inst_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_bvalid(1'b0),
        .m_axi_lite_ch1_araddr(m_axi_lite_ch1_araddr),
        .m_axi_lite_ch1_arready(m_axi_lite_ch1_arready),
        .m_axi_lite_ch1_arvalid(m_axi_lite_ch1_arvalid),
        .m_axi_lite_ch1_awaddr(m_axi_lite_ch1_awaddr),
        .m_axi_lite_ch1_awprot(NLW_inst_m_axi_lite_ch1_awprot_UNCONNECTED[2:0]),
        .m_axi_lite_ch1_awready(m_axi_lite_ch1_awready),
        .m_axi_lite_ch1_awvalid(m_axi_lite_ch1_awvalid),
        .m_axi_lite_ch1_bready(m_axi_lite_ch1_bready),
        .m_axi_lite_ch1_bresp({1'b0,m_axi_lite_ch1_bresp[0]}),
        .m_axi_lite_ch1_bvalid(m_axi_lite_ch1_bvalid),
        .m_axi_lite_ch1_rdata(m_axi_lite_ch1_rdata),
        .m_axi_lite_ch1_rready(m_axi_lite_ch1_rready),
        .m_axi_lite_ch1_rresp(m_axi_lite_ch1_rresp),
        .m_axi_lite_ch1_rvalid(m_axi_lite_ch1_rvalid),
        .m_axi_lite_ch1_wdata(m_axi_lite_ch1_wdata),
        .m_axi_lite_ch1_wready(m_axi_lite_ch1_wready),
        .m_axi_lite_ch1_wstrb(NLW_inst_m_axi_lite_ch1_wstrb_UNCONNECTED[3:0]),
        .m_axi_lite_ch1_wvalid(m_axi_lite_ch1_wvalid),
        .m_axi_lite_ch2_araddr(NLW_inst_m_axi_lite_ch2_araddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch2_arready(1'b0),
        .m_axi_lite_ch2_arvalid(NLW_inst_m_axi_lite_ch2_arvalid_UNCONNECTED),
        .m_axi_lite_ch2_awaddr(NLW_inst_m_axi_lite_ch2_awaddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch2_awprot(NLW_inst_m_axi_lite_ch2_awprot_UNCONNECTED[2:0]),
        .m_axi_lite_ch2_awready(1'b0),
        .m_axi_lite_ch2_awvalid(NLW_inst_m_axi_lite_ch2_awvalid_UNCONNECTED),
        .m_axi_lite_ch2_bready(NLW_inst_m_axi_lite_ch2_bready_UNCONNECTED),
        .m_axi_lite_ch2_bresp({1'b0,1'b0}),
        .m_axi_lite_ch2_bvalid(1'b0),
        .m_axi_lite_ch2_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_lite_ch2_rready(NLW_inst_m_axi_lite_ch2_rready_UNCONNECTED),
        .m_axi_lite_ch2_rresp({1'b0,1'b0}),
        .m_axi_lite_ch2_rvalid(1'b0),
        .m_axi_lite_ch2_wdata(NLW_inst_m_axi_lite_ch2_wdata_UNCONNECTED[31:0]),
        .m_axi_lite_ch2_wready(1'b0),
        .m_axi_lite_ch2_wstrb(NLW_inst_m_axi_lite_ch2_wstrb_UNCONNECTED[3:0]),
        .m_axi_lite_ch2_wvalid(NLW_inst_m_axi_lite_ch2_wvalid_UNCONNECTED),
        .m_axi_lite_ch3_araddr(NLW_inst_m_axi_lite_ch3_araddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch3_arready(1'b0),
        .m_axi_lite_ch3_arvalid(NLW_inst_m_axi_lite_ch3_arvalid_UNCONNECTED),
        .m_axi_lite_ch3_awaddr(NLW_inst_m_axi_lite_ch3_awaddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch3_awprot(NLW_inst_m_axi_lite_ch3_awprot_UNCONNECTED[2:0]),
        .m_axi_lite_ch3_awready(1'b0),
        .m_axi_lite_ch3_awvalid(NLW_inst_m_axi_lite_ch3_awvalid_UNCONNECTED),
        .m_axi_lite_ch3_bready(NLW_inst_m_axi_lite_ch3_bready_UNCONNECTED),
        .m_axi_lite_ch3_bresp({1'b0,1'b0}),
        .m_axi_lite_ch3_bvalid(1'b0),
        .m_axi_lite_ch3_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_lite_ch3_rready(NLW_inst_m_axi_lite_ch3_rready_UNCONNECTED),
        .m_axi_lite_ch3_rresp({1'b0,1'b0}),
        .m_axi_lite_ch3_rvalid(1'b0),
        .m_axi_lite_ch3_wdata(NLW_inst_m_axi_lite_ch3_wdata_UNCONNECTED[31:0]),
        .m_axi_lite_ch3_wready(1'b0),
        .m_axi_lite_ch3_wstrb(NLW_inst_m_axi_lite_ch3_wstrb_UNCONNECTED[3:0]),
        .m_axi_lite_ch3_wvalid(NLW_inst_m_axi_lite_ch3_wvalid_UNCONNECTED),
        .m_axi_lite_ch4_araddr(NLW_inst_m_axi_lite_ch4_araddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch4_arready(1'b0),
        .m_axi_lite_ch4_arvalid(NLW_inst_m_axi_lite_ch4_arvalid_UNCONNECTED),
        .m_axi_lite_ch4_awaddr(NLW_inst_m_axi_lite_ch4_awaddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch4_awprot(NLW_inst_m_axi_lite_ch4_awprot_UNCONNECTED[2:0]),
        .m_axi_lite_ch4_awready(1'b0),
        .m_axi_lite_ch4_awvalid(NLW_inst_m_axi_lite_ch4_awvalid_UNCONNECTED),
        .m_axi_lite_ch4_bready(NLW_inst_m_axi_lite_ch4_bready_UNCONNECTED),
        .m_axi_lite_ch4_bresp({1'b0,1'b0}),
        .m_axi_lite_ch4_bvalid(1'b0),
        .m_axi_lite_ch4_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_lite_ch4_rready(NLW_inst_m_axi_lite_ch4_rready_UNCONNECTED),
        .m_axi_lite_ch4_rresp({1'b0,1'b0}),
        .m_axi_lite_ch4_rvalid(1'b0),
        .m_axi_lite_ch4_wdata(NLW_inst_m_axi_lite_ch4_wdata_UNCONNECTED[31:0]),
        .m_axi_lite_ch4_wready(1'b0),
        .m_axi_lite_ch4_wstrb(NLW_inst_m_axi_lite_ch4_wstrb_UNCONNECTED[3:0]),
        .m_axi_lite_ch4_wvalid(NLW_inst_m_axi_lite_ch4_wvalid_UNCONNECTED),
        .m_axi_lite_ch5_araddr(NLW_inst_m_axi_lite_ch5_araddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch5_arready(1'b0),
        .m_axi_lite_ch5_arvalid(NLW_inst_m_axi_lite_ch5_arvalid_UNCONNECTED),
        .m_axi_lite_ch5_awaddr(NLW_inst_m_axi_lite_ch5_awaddr_UNCONNECTED[31:0]),
        .m_axi_lite_ch5_awprot(NLW_inst_m_axi_lite_ch5_awprot_UNCONNECTED[2:0]),
        .m_axi_lite_ch5_awready(1'b0),
        .m_axi_lite_ch5_awvalid(NLW_inst_m_axi_lite_ch5_awvalid_UNCONNECTED),
        .m_axi_lite_ch5_bready(NLW_inst_m_axi_lite_ch5_bready_UNCONNECTED),
        .m_axi_lite_ch5_bresp({1'b0,1'b0}),
        .m_axi_lite_ch5_bvalid(1'b0),
        .m_axi_lite_ch5_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_lite_ch5_rready(NLW_inst_m_axi_lite_ch5_rready_UNCONNECTED),
        .m_axi_lite_ch5_rresp({1'b0,1'b0}),
        .m_axi_lite_ch5_rvalid(1'b0),
        .m_axi_lite_ch5_wdata(NLW_inst_m_axi_lite_ch5_wdata_UNCONNECTED[31:0]),
        .m_axi_lite_ch5_wready(1'b0),
        .m_axi_lite_ch5_wstrb(NLW_inst_m_axi_lite_ch5_wstrb_UNCONNECTED[3:0]),
        .m_axi_lite_ch5_wvalid(NLW_inst_m_axi_lite_ch5_wvalid_UNCONNECTED),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_inst_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_inst_m_axi_wdata_UNCONNECTED[31:0]),
        .m_axi_wlast(NLW_inst_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_inst_m_axi_wstrb_UNCONNECTED[3:0]),
        .m_axi_wvalid(NLW_inst_m_axi_wvalid_UNCONNECTED),
        .m_axis_1_tdata(NLW_inst_m_axis_1_tdata_UNCONNECTED[31:0]),
        .m_axis_1_tdest(NLW_inst_m_axis_1_tdest_UNCONNECTED[7:0]),
        .m_axis_1_tid(NLW_inst_m_axis_1_tid_UNCONNECTED[7:0]),
        .m_axis_1_tkeep(NLW_inst_m_axis_1_tkeep_UNCONNECTED[3:0]),
        .m_axis_1_tlast(NLW_inst_m_axis_1_tlast_UNCONNECTED),
        .m_axis_1_tready(1'b1),
        .m_axis_1_tstrb(NLW_inst_m_axis_1_tstrb_UNCONNECTED[3:0]),
        .m_axis_1_tuser(NLW_inst_m_axis_1_tuser_UNCONNECTED[7:0]),
        .m_axis_1_tvalid(NLW_inst_m_axis_1_tvalid_UNCONNECTED),
        .m_axis_2_tdata(NLW_inst_m_axis_2_tdata_UNCONNECTED[31:0]),
        .m_axis_2_tdest(NLW_inst_m_axis_2_tdest_UNCONNECTED[7:0]),
        .m_axis_2_tid(NLW_inst_m_axis_2_tid_UNCONNECTED[7:0]),
        .m_axis_2_tkeep(NLW_inst_m_axis_2_tkeep_UNCONNECTED[3:0]),
        .m_axis_2_tlast(NLW_inst_m_axis_2_tlast_UNCONNECTED),
        .m_axis_2_tready(1'b1),
        .m_axis_2_tstrb(NLW_inst_m_axis_2_tstrb_UNCONNECTED[3:0]),
        .m_axis_2_tuser(NLW_inst_m_axis_2_tuser_UNCONNECTED[7:0]),
        .m_axis_2_tvalid(NLW_inst_m_axis_2_tvalid_UNCONNECTED),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_inst_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_inst_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_inst_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_inst_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_inst_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_inst_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_inst_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_inst_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_inst_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_inst_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_inst_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .s_axis_1_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_1_tdest({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_1_tid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_1_tkeep({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_1_tlast(1'b0),
        .s_axis_1_tready(NLW_inst_s_axis_1_tready_UNCONNECTED),
        .s_axis_1_tstrb({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_1_tuser({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_1_tvalid(1'b0),
        .s_axis_2_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_2_tdest({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_2_tid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_2_tkeep({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_2_tlast(1'b0),
        .s_axis_2_tready(NLW_inst_s_axis_2_tready_UNCONNECTED),
        .s_axis_2_tstrb({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_2_tuser({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_2_tvalid(1'b0),
        .status(\^status ));
endmodule

(* ADDR_WIDTH_A = "8" *) (* ADDR_WIDTH_B = "8" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "8" *) (* BYTE_WRITE_WIDTH_B = "32" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "0" *) (* ECC_BIT_RANGE = "[7:0]" *) (* ECC_MODE = "0" *) 
(* ECC_TYPE = "NONE" *) (* IGNORE_INIT_SYNTH = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "mipi_init_gen_mask.mem" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "1" *) (* MEMORY_SIZE = "8192" *) (* MEMORY_TYPE = "0" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* P_ECC_MODE = "0" *) 
(* P_ENABLE_BYTE_WRITE_A = "1" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) (* P_MAX_DEPTH_DATA = "256" *) 
(* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "0" *) (* P_MIN_WIDTH_DATA = "32" *) 
(* P_MIN_WIDTH_DATA_A = "32" *) (* P_MIN_WIDTH_DATA_B = "32" *) (* P_MIN_WIDTH_DATA_ECC = "32" *) 
(* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "32" *) (* P_NUM_COLS_WRITE_A = "4" *) 
(* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) (* P_NUM_ROWS_READ_B = "1" *) 
(* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) (* P_SDP_WRITE_MODE = "yes" *) 
(* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "8" *) (* P_WIDTH_ADDR_READ_B = "8" *) 
(* P_WIDTH_ADDR_WRITE_A = "8" *) (* P_WIDTH_ADDR_WRITE_B = "8" *) (* P_WIDTH_COL_WRITE_A = "8" *) 
(* P_WIDTH_COL_WRITE_B = "32" *) (* RAM_DECOMP = "auto" *) (* READ_DATA_WIDTH_A = "32" *) 
(* READ_DATA_WIDTH_B = "32" *) (* READ_LATENCY_A = "1" *) (* READ_LATENCY_B = "1" *) 
(* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) (* RST_MODE_A = "SYNC" *) 
(* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) (* USE_EMBEDDED_CONSTRAINT = "0" *) 
(* USE_MEM_INIT = "1" *) (* USE_MEM_INIT_MMI = "0" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "32" *) (* WRITE_DATA_WIDTH_B = "32" *) 
(* WRITE_MODE_A = "1" *) (* WRITE_MODE_B = "1" *) (* WRITE_PROTECT = "1" *) 
(* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) (* rsta_loop_iter = "32" *) 
(* rstb_loop_iter = "32" *) 
module mipi_init_gen_xpm_memory_base
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [3:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [31:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [31:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [31:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [7:0]addra;
  wire clka;
  wire [31:0]douta;
  wire [31:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 ;
  wire rsta;
  wire sleep;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .Q(douta[0]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .Q(douta[10]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .Q(douta[11]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .Q(douta[12]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .Q(douta[13]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .Q(douta[14]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .Q(douta[15]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[16] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .Q(douta[16]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .Q(douta[17]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[18] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .Q(douta[18]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .Q(douta[19]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .Q(douta[1]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[20] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .Q(douta[20]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .Q(douta[21]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[22] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .Q(douta[22]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .Q(douta[23]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[24] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .Q(douta[24]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[25] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .Q(douta[25]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[26] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .Q(douta[26]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .Q(douta[27]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .Q(douta[28]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .Q(douta[29]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .Q(douta[2]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .Q(douta[30]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .Q(douta[31]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .Q(douta[3]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .Q(douta[4]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .Q(douta[5]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .Q(douta[6]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .Q(douta[7]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .Q(douta[8]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .Q(douta[9]),
        .R(rsta));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_0_0 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_10_10 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_11_11 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_12_12 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_13_13 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_14_14 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_15_15 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_16_16 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_17_17 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_18_18 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_19_19 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_1_1 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_20_20 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_21_21 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_22_22 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_23_23 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_24_24 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_25_25 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_26_26 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_27_27 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_28_28 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_29_29 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h200003FFFFFFFFE0000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_2_2 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_30_30 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_31_31 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_3_3 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_4_4 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_5_5 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_6_6 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_7_7 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_8_8 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_9_9 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .WCLK(clka),
        .WE(1'b0));
endmodule

(* ADDR_WIDTH_A = "8" *) (* ADDR_WIDTH_B = "8" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "8" *) (* BYTE_WRITE_WIDTH_B = "32" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "0" *) (* ECC_BIT_RANGE = "[7:0]" *) (* ECC_MODE = "0" *) 
(* ECC_TYPE = "NONE" *) (* IGNORE_INIT_SYNTH = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "mipi_init_gen_ctrl.mem" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "1" *) (* MEMORY_SIZE = "8192" *) (* MEMORY_TYPE = "0" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* ORIG_REF_NAME = "xpm_memory_base" *) 
(* P_ECC_MODE = "0" *) (* P_ENABLE_BYTE_WRITE_A = "1" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) 
(* P_MAX_DEPTH_DATA = "256" *) (* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "0" *) 
(* P_MIN_WIDTH_DATA = "32" *) (* P_MIN_WIDTH_DATA_A = "32" *) (* P_MIN_WIDTH_DATA_B = "32" *) 
(* P_MIN_WIDTH_DATA_ECC = "32" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
(* P_NUM_COLS_WRITE_A = "4" *) (* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) 
(* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) 
(* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "8" *) 
(* P_WIDTH_ADDR_READ_B = "8" *) (* P_WIDTH_ADDR_WRITE_A = "8" *) (* P_WIDTH_ADDR_WRITE_B = "8" *) 
(* P_WIDTH_COL_WRITE_A = "8" *) (* P_WIDTH_COL_WRITE_B = "32" *) (* RAM_DECOMP = "auto" *) 
(* READ_DATA_WIDTH_A = "32" *) (* READ_DATA_WIDTH_B = "32" *) (* READ_LATENCY_A = "1" *) 
(* READ_LATENCY_B = "1" *) (* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) 
(* RST_MODE_A = "SYNC" *) (* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) 
(* USE_EMBEDDED_CONSTRAINT = "0" *) (* USE_MEM_INIT = "1" *) (* USE_MEM_INIT_MMI = "0" *) 
(* VERSION = "0" *) (* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "32" *) 
(* WRITE_DATA_WIDTH_B = "32" *) (* WRITE_MODE_A = "1" *) (* WRITE_MODE_B = "1" *) 
(* WRITE_PROTECT = "1" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) 
(* rsta_loop_iter = "32" *) (* rstb_loop_iter = "32" *) 
module mipi_init_gen_xpm_memory_base__parameterized0
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [3:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [31:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [31:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [31:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [7:0]addra;
  wire clka;
  wire [21:0]\^douta ;
  wire [21:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 ;
  wire rsta;
  wire sleep;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign douta[31] = \<const0> ;
  assign douta[30] = \<const0> ;
  assign douta[29] = \<const0> ;
  assign douta[28] = \<const0> ;
  assign douta[27] = \<const0> ;
  assign douta[26] = \<const0> ;
  assign douta[25] = \<const0> ;
  assign douta[24] = \<const0> ;
  assign douta[23] = \<const0> ;
  assign douta[22] = \<const0> ;
  assign douta[21:20] = \^douta [21:20];
  assign douta[19] = \<const0> ;
  assign douta[18] = \<const0> ;
  assign douta[17:0] = \^douta [17:0];
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .Q(\^douta [0]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .Q(\^douta [10]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .Q(\^douta [11]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .Q(\^douta [12]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .Q(\^douta [13]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .Q(\^douta [14]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .Q(\^douta [15]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[16] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .Q(\^douta [16]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .Q(\^douta [17]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .Q(\^douta [1]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[20] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .Q(\^douta [20]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .Q(\^douta [21]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .Q(\^douta [2]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .Q(\^douta [3]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .Q(\^douta [4]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .Q(\^douta [5]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .Q(\^douta [6]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .Q(\^douta [7]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .Q(\^douta [8]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .Q(\^douta [9]),
        .R(rsta));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_0_0 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h3878787878787878787878787878787878787878787878787878787878787878)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_10_10 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h3F807F807F807F807F807F807F807F807F807F807F807F807F807F807F807F80)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_11_11 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h3FFF80007FFF80007FFF80007FFF80007FFF80007FFF80007FFF80007FFF8000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_12_12 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFF800000007FFFFFFF800000007FFFFFFF800000007FFFFFFF80000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_13_13 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFF80000000000000007FFFFFFFFFFFFFFF8000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_14_14 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_15_15 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000010000000000000000000000000000000000000000001F00000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_16_16 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_17_17 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_1_1 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_20_20 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_21_21 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h30F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_2_2 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h3F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_3_3 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h3FFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_4_4 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_5_5 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_6_6 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_7_7 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h3555555555555555555555555555555555555555555555555555555555555555)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_8_8 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h2666666666666666666666666666666666666666666666666666666666666666)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_9_9 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .WCLK(clka),
        .WE(1'b0));
endmodule

(* ADDR_WIDTH_A = "8" *) (* ADDR_WIDTH_B = "8" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "8" *) (* BYTE_WRITE_WIDTH_B = "32" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "0" *) (* ECC_BIT_RANGE = "[7:0]" *) (* ECC_MODE = "0" *) 
(* ECC_TYPE = "NONE" *) (* IGNORE_INIT_SYNTH = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "mipi_init_gen_addr.mem" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "1" *) (* MEMORY_SIZE = "8192" *) (* MEMORY_TYPE = "0" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* ORIG_REF_NAME = "xpm_memory_base" *) 
(* P_ECC_MODE = "0" *) (* P_ENABLE_BYTE_WRITE_A = "1" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) 
(* P_MAX_DEPTH_DATA = "256" *) (* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "0" *) 
(* P_MIN_WIDTH_DATA = "32" *) (* P_MIN_WIDTH_DATA_A = "32" *) (* P_MIN_WIDTH_DATA_B = "32" *) 
(* P_MIN_WIDTH_DATA_ECC = "32" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
(* P_NUM_COLS_WRITE_A = "4" *) (* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) 
(* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) 
(* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "8" *) 
(* P_WIDTH_ADDR_READ_B = "8" *) (* P_WIDTH_ADDR_WRITE_A = "8" *) (* P_WIDTH_ADDR_WRITE_B = "8" *) 
(* P_WIDTH_COL_WRITE_A = "8" *) (* P_WIDTH_COL_WRITE_B = "32" *) (* RAM_DECOMP = "auto" *) 
(* READ_DATA_WIDTH_A = "32" *) (* READ_DATA_WIDTH_B = "32" *) (* READ_LATENCY_A = "1" *) 
(* READ_LATENCY_B = "1" *) (* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) 
(* RST_MODE_A = "SYNC" *) (* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) 
(* USE_EMBEDDED_CONSTRAINT = "0" *) (* USE_MEM_INIT = "1" *) (* USE_MEM_INIT_MMI = "0" *) 
(* VERSION = "0" *) (* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "32" *) 
(* WRITE_DATA_WIDTH_B = "32" *) (* WRITE_MODE_A = "1" *) (* WRITE_MODE_B = "1" *) 
(* WRITE_PROTECT = "1" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) 
(* rsta_loop_iter = "32" *) (* rstb_loop_iter = "32" *) 
module mipi_init_gen_xpm_memory_base__parameterized1
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [3:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [31:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [31:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [31:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [7:0]addra;
  wire clka;
  wire [31:0]douta;
  wire [31:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 ;
  wire rsta;
  wire sleep;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .Q(douta[0]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .Q(douta[10]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .Q(douta[11]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .Q(douta[12]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .Q(douta[13]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .Q(douta[14]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .Q(douta[15]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[16] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .Q(douta[16]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .Q(douta[17]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[18] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .Q(douta[18]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .Q(douta[19]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .Q(douta[1]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[20] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .Q(douta[20]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .Q(douta[21]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[22] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .Q(douta[22]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .Q(douta[23]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[24] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .Q(douta[24]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[25] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .Q(douta[25]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[26] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .Q(douta[26]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .Q(douta[27]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .Q(douta[28]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .Q(douta[29]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .Q(douta[2]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .Q(douta[30]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .Q(douta[31]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .Q(douta[3]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .Q(douta[4]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .Q(douta[5]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .Q(douta[6]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .Q(douta[7]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .Q(douta[8]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .Q(douta[9]),
        .R(rsta));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_0_0 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_10_10 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_11_11 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_12_12 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_13_13 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_14_14 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_15_15 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_16_16 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_17_17 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_18_18 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_19_19 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_1_1 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_20_20 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_21_21 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_22_22 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_23_23 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_24_24 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_25_25 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_26_26 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_27_27 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_28_28 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_29_29 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000A00000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_2_2 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_30_30 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_31_31 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001C00000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_3_3 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_4_4 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_5_5 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000F00000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_6_6 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_7_7 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_8_8 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_9_9 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .WCLK(clka),
        .WE(1'b0));
endmodule

(* ADDR_WIDTH_A = "8" *) (* ADDR_WIDTH_B = "8" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "8" *) (* BYTE_WRITE_WIDTH_B = "32" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "0" *) (* ECC_BIT_RANGE = "[7:0]" *) (* ECC_MODE = "0" *) 
(* ECC_TYPE = "NONE" *) (* IGNORE_INIT_SYNTH = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "mipi_init_gen_data.mem" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "1" *) (* MEMORY_SIZE = "8192" *) (* MEMORY_TYPE = "0" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* ORIG_REF_NAME = "xpm_memory_base" *) 
(* P_ECC_MODE = "0" *) (* P_ENABLE_BYTE_WRITE_A = "1" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) 
(* P_MAX_DEPTH_DATA = "256" *) (* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "0" *) 
(* P_MIN_WIDTH_DATA = "32" *) (* P_MIN_WIDTH_DATA_A = "32" *) (* P_MIN_WIDTH_DATA_B = "32" *) 
(* P_MIN_WIDTH_DATA_ECC = "32" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
(* P_NUM_COLS_WRITE_A = "4" *) (* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) 
(* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) 
(* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "8" *) 
(* P_WIDTH_ADDR_READ_B = "8" *) (* P_WIDTH_ADDR_WRITE_A = "8" *) (* P_WIDTH_ADDR_WRITE_B = "8" *) 
(* P_WIDTH_COL_WRITE_A = "8" *) (* P_WIDTH_COL_WRITE_B = "32" *) (* RAM_DECOMP = "auto" *) 
(* READ_DATA_WIDTH_A = "32" *) (* READ_DATA_WIDTH_B = "32" *) (* READ_LATENCY_A = "1" *) 
(* READ_LATENCY_B = "1" *) (* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) 
(* RST_MODE_A = "SYNC" *) (* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) 
(* USE_EMBEDDED_CONSTRAINT = "0" *) (* USE_MEM_INIT = "1" *) (* USE_MEM_INIT_MMI = "0" *) 
(* VERSION = "0" *) (* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "32" *) 
(* WRITE_DATA_WIDTH_B = "32" *) (* WRITE_MODE_A = "1" *) (* WRITE_MODE_B = "1" *) 
(* WRITE_PROTECT = "1" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) 
(* rsta_loop_iter = "32" *) (* rstb_loop_iter = "32" *) 
module mipi_init_gen_xpm_memory_base__parameterized2
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [3:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [31:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [31:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [31:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [7:0]addra;
  wire clka;
  wire [31:0]douta;
  wire [31:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 ;
  wire rsta;
  wire sleep;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .Q(douta[0]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .Q(douta[10]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .Q(douta[11]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .Q(douta[12]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .Q(douta[13]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .Q(douta[14]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .Q(douta[15]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[16] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .Q(douta[16]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .Q(douta[17]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[18] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .Q(douta[18]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .Q(douta[19]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .Q(douta[1]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[20] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .Q(douta[20]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .Q(douta[21]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[22] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .Q(douta[22]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .Q(douta[23]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[24] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .Q(douta[24]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[25] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .Q(douta[25]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[26] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .Q(douta[26]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .Q(douta[27]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .Q(douta[28]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .Q(douta[29]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .Q(douta[2]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .Q(douta[30]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .Q(douta[31]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .Q(douta[3]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .Q(douta[4]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .Q(douta[5]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .Q(douta[6]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .Q(douta[7]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .Q(douta[8]),
        .R(rsta));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .Q(douta[9]),
        .R(rsta));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h2000040000000010000000000000000000000000000000000000000000000080)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_0_0 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [0]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_10_10 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [10]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_11_11 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [11]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_12_12 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [12]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_13_13 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [13]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_14_14 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [14]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_15_15 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [15]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_16_16 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [16]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_17_17 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [17]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_18_18 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [18]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_19_19 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [19]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_1_1 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [1]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_20_20 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [20]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_21_21 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [21]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_22_22 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [22]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_23_23 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [23]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_24_24 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [24]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_25_25 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [25]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_26_26 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [26]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_27_27 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [27]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_28_28 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [28]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_29_29 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [29]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h200003FFFFFFFFE0000000000000000000000000000000000000000000F00000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_2_2 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [2]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_30_30 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [30]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_31_31 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [31]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000004)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_3_3 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [3]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000010000000000000000000000000000000000000000000000014)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_4_4 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [4]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001000008)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_5_5 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [5]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000001000004)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_6_6 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [6]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h2000040000000000000000000000000000000000000000000000000001000000)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_7_7 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [7]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h2000000000000000000000000000000000000000000000000000000000000008)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_8_8 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [8]),
        .WCLK(clka),
        .WE(1'b0));
  (* RTL_RAM_BITS = "8192" *) 
  (* RTL_RAM_NAME = "xpm_memory_base/gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h200000000000000000000000000000000000000000000000000000000100000C)) 
    \gen_wr_a.gen_byte_narrow.for_mem_cols[1].mem_reg_0_255_9_9 
       (.A(addra),
        .D(1'b0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg0 [9]),
        .WCLK(clka),
        .WE(1'b0));
endmodule

module mipi_init_gen_xpm_memory_spram
   (douta,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ,
    DI,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ,
    \m_axi_lite_ch1_rdata[9] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ,
    \m_axi_lite_ch1_rdata[21] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ,
    S,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ,
    \m_axi_lite_ch1_rdata[27] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ,
    addra,
    rd_check1_carry__2_i_1,
    m_axi_lite_ch1_rdata,
    rom_eof0,
    \rd_check2_inferred__0/i__carry__1 );
  output [31:0]douta;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ;
  output [0:0]DI;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ;
  output [0:0]\m_axi_lite_ch1_rdata[9] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ;
  output [0:0]\m_axi_lite_ch1_rdata[21] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ;
  output [0:0]S;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ;
  output [0:0]\m_axi_lite_ch1_rdata[27] ;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  input [7:0]addra;
  input [16:0]rd_check1_carry__2_i_1;
  input [16:0]m_axi_lite_ch1_rdata;
  input rom_eof0;
  input \rd_check2_inferred__0/i__carry__1 ;

  wire [0:0]DI;
  wire [0:0]S;
  wire [7:0]addra;
  wire [31:0]douta;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ;
  wire [16:0]m_axi_lite_ch1_rdata;
  wire [0:0]\m_axi_lite_ch1_rdata[21] ;
  wire [0:0]\m_axi_lite_ch1_rdata[27] ;
  wire [0:0]\m_axi_lite_ch1_rdata[9] ;
  wire rd_check1_carry__0_i_10_n_0;
  wire rd_check1_carry__1_i_10_n_0;
  wire [16:0]rd_check1_carry__2_i_1;
  wire rd_check1_carry__2_i_10_n_0;
  wire rd_check1_carry_i_10_n_0;
  wire rd_check2_carry__0_i_9_n_0;
  wire \rd_check2_inferred__0/i__carry__1 ;
  wire rom_eof0;
  wire s_axi_aclk;
  wire NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED;
  wire [31:0]NLW_xpm_memory_base_inst_doutb_UNCONNECTED;

  LUT6 #(
    .INIT(64'h0888088888080888)) 
    i__carry__1_i_1
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .I1(\rd_check2_inferred__0/i__carry__1 ),
        .I2(douta[30]),
        .I3(rd_check1_carry__2_i_1[15]),
        .I4(m_axi_lite_ch1_rdata[15]),
        .I5(rom_eof0),
        .O(S));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h08)) 
    rd_check1_carry__0_i_10
       (.I0(douta[8]),
        .I1(m_axi_lite_ch1_rdata[3]),
        .I2(rom_eof0),
        .O(rd_check1_carry__0_i_10_n_0));
  LUT6 #(
    .INIT(64'h0000300020AABAAA)) 
    rd_check1_carry__0_i_4
       (.I0(rd_check1_carry__0_i_10_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[4]),
        .I3(douta[9]),
        .I4(rd_check1_carry__2_i_1[4]),
        .I5(rd_check1_carry__2_i_1[3]),
        .O(\m_axi_lite_ch1_rdata[9] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h08)) 
    rd_check1_carry__1_i_10
       (.I0(douta[20]),
        .I1(m_axi_lite_ch1_rdata[9]),
        .I2(rom_eof0),
        .O(rd_check1_carry__1_i_10_n_0));
  LUT6 #(
    .INIT(64'h0000300020AABAAA)) 
    rd_check1_carry__1_i_2
       (.I0(rd_check1_carry__1_i_10_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[10]),
        .I3(douta[21]),
        .I4(rd_check1_carry__2_i_1[10]),
        .I5(rd_check1_carry__2_i_1[9]),
        .O(\m_axi_lite_ch1_rdata[21] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h08)) 
    rd_check1_carry__2_i_10
       (.I0(douta[26]),
        .I1(m_axi_lite_ch1_rdata[12]),
        .I2(rom_eof0),
        .O(rd_check1_carry__2_i_10_n_0));
  LUT6 #(
    .INIT(64'h0000300020AABAAA)) 
    rd_check1_carry__2_i_3
       (.I0(rd_check1_carry__2_i_10_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[13]),
        .I3(douta[27]),
        .I4(rd_check1_carry__2_i_1[13]),
        .I5(rd_check1_carry__2_i_1[12]),
        .O(\m_axi_lite_ch1_rdata[27] ));
  LUT6 #(
    .INIT(64'h0888088888080888)) 
    rd_check1_carry__2_i_5
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .I1(\rd_check2_inferred__0/i__carry__1 ),
        .I2(douta[30]),
        .I3(rd_check1_carry__2_i_1[15]),
        .I4(m_axi_lite_ch1_rdata[15]),
        .I5(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h08)) 
    rd_check1_carry_i_10
       (.I0(douta[2]),
        .I1(m_axi_lite_ch1_rdata[0]),
        .I2(rom_eof0),
        .O(rd_check1_carry_i_10_n_0));
  LUT6 #(
    .INIT(64'h0000300020AABAAA)) 
    rd_check1_carry_i_3
       (.I0(rd_check1_carry_i_10_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[1]),
        .I3(douta[3]),
        .I4(rd_check1_carry__2_i_1[1]),
        .I5(rd_check1_carry__2_i_1[0]),
        .O(DI));
  LUT5 #(
    .INIT(32'hD551D5D5)) 
    rd_check2_carry__0_i_1
       (.I0(rd_check2_carry__0_i_9_n_0),
        .I1(douta[15]),
        .I2(rd_check1_carry__2_i_1[7]),
        .I3(rom_eof0),
        .I4(m_axi_lite_ch1_rdata[7]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15] ));
  LUT4 #(
    .INIT(16'h7F77)) 
    rd_check2_carry__0_i_14
       (.I0(douta[15]),
        .I1(rd_check1_carry__2_i_1[7]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[7]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[15]_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    rd_check2_carry__0_i_16
       (.I0(douta[11]),
        .I1(rd_check1_carry__2_i_1[5]),
        .I2(m_axi_lite_ch1_rdata[5]),
        .I3(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[11] ));
  LUT4 #(
    .INIT(16'h77F7)) 
    rd_check2_carry__0_i_9
       (.I0(douta[14]),
        .I1(rd_check1_carry__2_i_1[6]),
        .I2(m_axi_lite_ch1_rdata[6]),
        .I3(rom_eof0),
        .O(rd_check2_carry__0_i_9_n_0));
  LUT4 #(
    .INIT(16'hFFDF)) 
    rd_check2_carry__1_i_13
       (.I0(douta[23]),
        .I1(rd_check1_carry__2_i_1[11]),
        .I2(m_axi_lite_ch1_rdata[11]),
        .I3(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[23] ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    rd_check2_carry__1_i_17
       (.I0(douta[17]),
        .I1(rd_check1_carry__2_i_1[8]),
        .I2(m_axi_lite_ch1_rdata[8]),
        .I3(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[17] ));
  LUT4 #(
    .INIT(16'h7F77)) 
    rd_check2_carry__2_i_10
       (.I0(douta[31]),
        .I1(rd_check1_carry__2_i_1[16]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[16]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    rd_check2_carry__2_i_14
       (.I0(douta[29]),
        .I1(rd_check1_carry__2_i_1[14]),
        .I2(m_axi_lite_ch1_rdata[14]),
        .I3(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[29] ));
  LUT6 #(
    .INIT(64'h0888088888080888)) 
    rd_check2_carry__2_i_5
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .I1(\rd_check2_inferred__0/i__carry__1 ),
        .I2(douta[30]),
        .I3(rd_check1_carry__2_i_1[15]),
        .I4(m_axi_lite_ch1_rdata[15]),
        .I5(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    rd_check2_carry_i_14
       (.I0(douta[5]),
        .I1(rd_check1_carry__2_i_1[2]),
        .I2(m_axi_lite_ch1_rdata[2]),
        .I3(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[5] ));
  (* ADDR_WIDTH_A = "8" *) 
  (* ADDR_WIDTH_B = "8" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "8" *) 
  (* BYTE_WRITE_WIDTH_B = "32" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "0" *) 
  (* ECC_BIT_RANGE = "[7:0]" *) 
  (* ECC_MODE = "0" *) 
  (* ECC_TYPE = "NONE" *) 
  (* IGNORE_INIT_SYNTH = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* MEMORY_INIT_FILE = "mipi_init_gen_mask.mem" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "1" *) 
  (* MEMORY_SIZE = "8192" *) 
  (* MEMORY_TYPE = "0" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "1" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "256" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "distributed" *) 
  (* P_MIN_WIDTH_DATA = "32" *) 
  (* P_MIN_WIDTH_DATA_A = "32" *) 
  (* P_MIN_WIDTH_DATA_B = "32" *) 
  (* P_MIN_WIDTH_DATA_ECC = "32" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
  (* P_NUM_COLS_WRITE_A = "4" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "8" *) 
  (* P_WIDTH_ADDR_READ_B = "8" *) 
  (* P_WIDTH_ADDR_WRITE_A = "8" *) 
  (* P_WIDTH_ADDR_WRITE_B = "8" *) 
  (* P_WIDTH_COL_WRITE_A = "8" *) 
  (* P_WIDTH_COL_WRITE_B = "32" *) 
  (* RAM_DECOMP = "auto" *) 
  (* READ_DATA_WIDTH_A = "32" *) 
  (* READ_DATA_WIDTH_B = "32" *) 
  (* READ_LATENCY_A = "1" *) 
  (* READ_LATENCY_B = "1" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "1" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "32" *) 
  (* WRITE_DATA_WIDTH_B = "32" *) 
  (* WRITE_MODE_A = "1" *) 
  (* WRITE_MODE_B = "1" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "32" *) 
  (* rstb_loop_iter = "32" *) 
  mipi_init_gen_xpm_memory_base xpm_memory_base_inst
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(s_axi_aclk),
        .clkb(1'b0),
        .dbiterra(NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED),
        .dbiterrb(NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_xpm_memory_base_inst_doutb_UNCONNECTED[31:0]),
        .ena(1'b1),
        .enb(1'b0),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b1),
        .regceb(1'b0),
        .rsta(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ),
        .rstb(1'b0),
        .sbiterra(NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED),
        .sbiterrb(NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_memory_spram" *) 
module mipi_init_gen_xpm_memory_spram__parameterized0
   (douta,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ,
    m_axi_lite_ch1_rresp_0_sp_1,
    D,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ,
    addra,
    CO,
    cur_trn_status_reg,
    m_axi_lite_ch1_rresp,
    cur_trn_status_reg_0,
    cur_trn_status_reg_1,
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] );
  output [1:0]douta;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  output m_axi_lite_ch1_rresp_0_sp_1;
  output [7:0]D;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ;
  input [7:0]addra;
  input [0:0]CO;
  input cur_trn_status_reg;
  input [0:0]m_axi_lite_ch1_rresp;
  input [0:0]cur_trn_status_reg_0;
  input [0:0]cur_trn_status_reg_1;
  input \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ;

  wire \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ;
  wire [0:0]CO;
  wire [7:0]D;
  wire [7:0]addra;
  wire cur_trn_status_reg;
  wire [0:0]cur_trn_status_reg_0;
  wire [0:0]cur_trn_status_reg_1;
  wire [1:0]douta;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ;
  wire [0:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rresp_0_sn_1;
  wire [21:0]rom_ctrl;
  wire s_axi_aclk;
  wire NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED;
  wire [31:18]NLW_xpm_memory_base_inst_douta_UNCONNECTED;
  wire [31:0]NLW_xpm_memory_base_inst_doutb_UNCONNECTED;

  assign m_axi_lite_ch1_rresp_0_sp_1 = m_axi_lite_ch1_rresp_0_sn_1;
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[0]_i_1 
       (.I0(rom_ctrl[0]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[8]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[1]_i_1 
       (.I0(rom_ctrl[1]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[9]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[2]_i_1 
       (.I0(rom_ctrl[2]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[10]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[3]_i_1 
       (.I0(rom_ctrl[3]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[11]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[4]_i_1 
       (.I0(rom_ctrl[4]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[12]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[5]_i_1 
       (.I0(rom_ctrl[5]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[13]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[6]_i_1 
       (.I0(rom_ctrl[6]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[14]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \ATG_SYSTEST_NXT_PTR.nxt_rom_ptr[7]_i_2 
       (.I0(rom_ctrl[7]),
        .I1(\ATG_SYSTEST_NXT_PTR.nxt_rom_ptr_reg[0] ),
        .I2(rom_ctrl[15]),
        .O(D[7]));
  LUT5 #(
    .INIT(32'hFFFFFFC1)) 
    cur_trn_status_i_3
       (.I0(CO),
        .I1(rom_ctrl[21]),
        .I2(rom_ctrl[20]),
        .I3(cur_trn_status_reg),
        .I4(douta[0]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ));
  LUT5 #(
    .INIT(32'hAEFFAEAE)) 
    cur_trn_status_i_4
       (.I0(m_axi_lite_ch1_rresp),
        .I1(rom_ctrl[21]),
        .I2(cur_trn_status_reg_0),
        .I3(cur_trn_status_reg_1),
        .I4(rom_ctrl[20]),
        .O(m_axi_lite_ch1_rresp_0_sn_1));
  (* ADDR_WIDTH_A = "8" *) 
  (* ADDR_WIDTH_B = "8" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "8" *) 
  (* BYTE_WRITE_WIDTH_B = "32" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "0" *) 
  (* ECC_BIT_RANGE = "[7:0]" *) 
  (* ECC_MODE = "0" *) 
  (* ECC_TYPE = "NONE" *) 
  (* IGNORE_INIT_SYNTH = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* MEMORY_INIT_FILE = "mipi_init_gen_ctrl.mem" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "1" *) 
  (* MEMORY_SIZE = "8192" *) 
  (* MEMORY_TYPE = "0" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "1" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "256" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "distributed" *) 
  (* P_MIN_WIDTH_DATA = "32" *) 
  (* P_MIN_WIDTH_DATA_A = "32" *) 
  (* P_MIN_WIDTH_DATA_B = "32" *) 
  (* P_MIN_WIDTH_DATA_ECC = "32" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
  (* P_NUM_COLS_WRITE_A = "4" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "8" *) 
  (* P_WIDTH_ADDR_READ_B = "8" *) 
  (* P_WIDTH_ADDR_WRITE_A = "8" *) 
  (* P_WIDTH_ADDR_WRITE_B = "8" *) 
  (* P_WIDTH_COL_WRITE_A = "8" *) 
  (* P_WIDTH_COL_WRITE_B = "32" *) 
  (* RAM_DECOMP = "auto" *) 
  (* READ_DATA_WIDTH_A = "32" *) 
  (* READ_DATA_WIDTH_B = "32" *) 
  (* READ_LATENCY_A = "1" *) 
  (* READ_LATENCY_B = "1" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "1" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "32" *) 
  (* WRITE_DATA_WIDTH_B = "32" *) 
  (* WRITE_MODE_A = "1" *) 
  (* WRITE_MODE_B = "1" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "32" *) 
  (* rstb_loop_iter = "32" *) 
  mipi_init_gen_xpm_memory_base__parameterized0 xpm_memory_base_inst
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(s_axi_aclk),
        .clkb(1'b0),
        .dbiterra(NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED),
        .dbiterrb(NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta({NLW_xpm_memory_base_inst_douta_UNCONNECTED[31:22],rom_ctrl[21:18],douta,rom_ctrl[15:0]}),
        .doutb(NLW_xpm_memory_base_inst_doutb_UNCONNECTED[31:0]),
        .ena(1'b1),
        .enb(1'b0),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b1),
        .regceb(1'b0),
        .rsta(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21]_0 ),
        .rstb(1'b0),
        .sbiterra(NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED),
        .sbiterrb(NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_memory_spram" *) 
module mipi_init_gen_xpm_memory_spram__parameterized1
   (douta,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ,
    rready_m_reg,
    s_axi_aresetn_0,
    b_complete,
    bready_m_reg,
    r_complete,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ,
    m_axi_lite_ch1_rdata_6_sp_1,
    m_axi_lite_ch1_rdata_2_sp_1,
    m_axi_lite_ch1_rdata_0_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ,
    \m_axi_lite_ch1_rdata[14] ,
    m_axi_lite_ch1_rdata_12_sp_1,
    m_axi_lite_ch1_rdata_8_sp_1,
    m_axi_lite_ch1_rdata_20_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ,
    m_axi_lite_ch1_rdata_18_sp_1,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    \m_axi_lite_ch1_rdata[30] ,
    \m_axi_lite_ch1_rdata[26] ,
    \m_axi_lite_ch1_rdata[24] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ,
    \m_axi_lite_ch1_rdata[14]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ,
    addra,
    bready_m,
    m_axi_lite_ch1_bvalid,
    m_axi_lite_ch1_bresp,
    cur_trn_status_reg,
    s_axi_aresetn,
    cur_trn_status_reg_0,
    cur_trn_status_reg_1,
    m_axi_lite_ch1_rresp,
    m_axi_lite_ch1_rvalid,
    rready_m,
    i__carry__1_i_1,
    i__carry__1_i_1_0,
    m_axi_lite_ch1_rdata,
    rd_check1_carry__0,
    rd_check1_carry__2);
  output [31:0]douta;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ;
  output rready_m_reg;
  output s_axi_aresetn_0;
  output b_complete;
  output bready_m_reg;
  output r_complete;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ;
  output m_axi_lite_ch1_rdata_6_sp_1;
  output m_axi_lite_ch1_rdata_2_sp_1;
  output m_axi_lite_ch1_rdata_0_sp_1;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ;
  output [0:0]\m_axi_lite_ch1_rdata[14] ;
  output m_axi_lite_ch1_rdata_12_sp_1;
  output m_axi_lite_ch1_rdata_8_sp_1;
  output m_axi_lite_ch1_rdata_20_sp_1;
  output [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ;
  output m_axi_lite_ch1_rdata_18_sp_1;
  output [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  output [0:0]\m_axi_lite_ch1_rdata[30] ;
  output \m_axi_lite_ch1_rdata[26] ;
  output \m_axi_lite_ch1_rdata[24] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ;
  output \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ;
  output [0:0]\m_axi_lite_ch1_rdata[14]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  input [7:0]addra;
  input bready_m;
  input m_axi_lite_ch1_bvalid;
  input [0:0]m_axi_lite_ch1_bresp;
  input [0:0]cur_trn_status_reg;
  input s_axi_aresetn;
  input cur_trn_status_reg_0;
  input cur_trn_status_reg_1;
  input [0:0]m_axi_lite_ch1_rresp;
  input m_axi_lite_ch1_rvalid;
  input rready_m;
  input [17:0]i__carry__1_i_1;
  input [21:0]i__carry__1_i_1_0;
  input [21:0]m_axi_lite_ch1_rdata;
  input rd_check1_carry__0;
  input rd_check1_carry__2;

  wire [7:0]addra;
  wire b_complete;
  wire bready_m;
  wire bready_m_reg;
  wire cur_trn_status_i_2_n_0;
  wire [0:0]cur_trn_status_reg;
  wire cur_trn_status_reg_0;
  wire cur_trn_status_reg_1;
  wire [31:0]douta;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] ;
  wire [0:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ;
  wire [1:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ;
  wire [17:0]i__carry__1_i_1;
  wire [21:0]i__carry__1_i_1_0;
  wire m_axi_lite_ch1_awvalid_INST_0_i_2_n_0;
  wire m_axi_lite_ch1_awvalid_INST_0_i_3_n_0;
  wire [0:0]m_axi_lite_ch1_bresp;
  wire m_axi_lite_ch1_bvalid;
  wire [21:0]m_axi_lite_ch1_rdata;
  wire [0:0]\m_axi_lite_ch1_rdata[14] ;
  wire [0:0]\m_axi_lite_ch1_rdata[14]_0 ;
  wire \m_axi_lite_ch1_rdata[24] ;
  wire \m_axi_lite_ch1_rdata[26] ;
  wire [0:0]\m_axi_lite_ch1_rdata[30] ;
  wire m_axi_lite_ch1_rdata_0_sn_1;
  wire m_axi_lite_ch1_rdata_12_sn_1;
  wire m_axi_lite_ch1_rdata_18_sn_1;
  wire m_axi_lite_ch1_rdata_20_sn_1;
  wire m_axi_lite_ch1_rdata_2_sn_1;
  wire m_axi_lite_ch1_rdata_6_sn_1;
  wire m_axi_lite_ch1_rdata_8_sn_1;
  wire [0:0]m_axi_lite_ch1_rresp;
  wire m_axi_lite_ch1_rvalid;
  wire \max_retry_cntr[0]_i_9_n_0 ;
  wire r_complete;
  wire rd_check1_carry__0;
  wire rd_check1_carry__2;
  wire rd_check2_carry__0_i_13_n_0;
  wire rd_check2_carry__0_i_21_n_0;
  wire rd_check2_carry__1_i_21_n_0;
  wire rd_check2_carry__2_i_20_n_0;
  wire rd_check2_carry_i_21_n_0;
  wire rd_check2_carry_i_22_n_0;
  wire rd_check2_carry_i_23_n_0;
  wire rd_check2_carry_i_24_n_0;
  wire rd_check2_carry_i_25_n_0;
  wire rready_m;
  wire rready_m_reg;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED;
  wire [31:0]NLW_xpm_memory_base_inst_doutb_UNCONNECTED;

  assign m_axi_lite_ch1_rdata_0_sp_1 = m_axi_lite_ch1_rdata_0_sn_1;
  assign m_axi_lite_ch1_rdata_12_sp_1 = m_axi_lite_ch1_rdata_12_sn_1;
  assign m_axi_lite_ch1_rdata_18_sp_1 = m_axi_lite_ch1_rdata_18_sn_1;
  assign m_axi_lite_ch1_rdata_20_sp_1 = m_axi_lite_ch1_rdata_20_sn_1;
  assign m_axi_lite_ch1_rdata_2_sp_1 = m_axi_lite_ch1_rdata_2_sn_1;
  assign m_axi_lite_ch1_rdata_6_sp_1 = m_axi_lite_ch1_rdata_6_sn_1;
  assign m_axi_lite_ch1_rdata_8_sp_1 = m_axi_lite_ch1_rdata_8_sn_1;
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h20)) 
    b_complete_ff_i_1
       (.I0(m_axi_lite_ch1_bvalid),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(bready_m),
        .O(b_complete));
  LUT6 #(
    .INIT(64'h0000888800008880)) 
    cur_trn_status_i_1
       (.I0(cur_trn_status_i_2_n_0),
        .I1(s_axi_aresetn),
        .I2(cur_trn_status_reg_0),
        .I3(cur_trn_status_reg_1),
        .I4(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I5(m_axi_lite_ch1_rresp),
        .O(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'h200020000000FFFF)) 
    cur_trn_status_i_2
       (.I0(bready_m),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(m_axi_lite_ch1_bvalid),
        .I3(m_axi_lite_ch1_bresp),
        .I4(rready_m_reg),
        .I5(cur_trn_status_reg),
        .O(cur_trn_status_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    m_axi_lite_ch1_awvalid_INST_0_i_1
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(douta[28]),
        .I2(douta[29]),
        .I3(douta[24]),
        .I4(douta[27]),
        .I5(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFDDDFFFF)) 
    m_axi_lite_ch1_awvalid_INST_0_i_2
       (.I0(douta[26]),
        .I1(douta[25]),
        .I2(douta[16]),
        .I3(douta[17]),
        .I4(douta[30]),
        .I5(douta[19]),
        .O(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
    m_axi_lite_ch1_awvalid_INST_0_i_3
       (.I0(douta[23]),
        .I1(douta[21]),
        .I2(douta[31]),
        .I3(douta[20]),
        .I4(douta[18]),
        .I5(douta[22]),
        .O(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0));
  LUT5 #(
    .INIT(32'hFFFDFFFF)) 
    \max_retry_cntr[0]_i_7 
       (.I0(bready_m),
        .I1(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I2(\max_retry_cntr[0]_i_9_n_0 ),
        .I3(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I4(m_axi_lite_ch1_bvalid),
        .O(bready_m_reg));
  LUT5 #(
    .INIT(32'hFFFDFFFF)) 
    \max_retry_cntr[0]_i_8 
       (.I0(rready_m),
        .I1(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I2(\max_retry_cntr[0]_i_9_n_0 ),
        .I3(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I4(m_axi_lite_ch1_rvalid),
        .O(rready_m_reg));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \max_retry_cntr[0]_i_9 
       (.I0(douta[28]),
        .I1(douta[29]),
        .I2(douta[24]),
        .I3(douta[27]),
        .O(\max_retry_cntr[0]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h20)) 
    r_complete_ff_i_1
       (.I0(m_axi_lite_ch1_rvalid),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(rready_m),
        .O(r_complete));
  LUT6 #(
    .INIT(64'h5555755500000000)) 
    rd_check1_carry__0_i_1
       (.I0(rd_check2_carry__0_i_13_n_0),
        .I1(i__carry__1_i_1[8]),
        .I2(i__carry__1_i_1_0[10]),
        .I3(m_axi_lite_ch1_rdata[10]),
        .I4(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I5(rd_check1_carry__0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] [1]));
  LUT5 #(
    .INIT(32'h000077F7)) 
    rd_check1_carry__0_i_2
       (.I0(i__carry__1_i_1[7]),
        .I1(i__carry__1_i_1_0[9]),
        .I2(m_axi_lite_ch1_rdata[9]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(m_axi_lite_ch1_rdata_12_sn_1),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[14] [0]));
  LUT6 #(
    .INIT(64'h0800808888888888)) 
    rd_check1_carry__0_i_5
       (.I0(rd_check2_carry__0_i_13_n_0),
        .I1(rd_check1_carry__0),
        .I2(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I3(m_axi_lite_ch1_rdata[10]),
        .I4(i__carry__1_i_1[8]),
        .I5(i__carry__1_i_1_0[10]),
        .O(\m_axi_lite_ch1_rdata[14] ));
  LUT5 #(
    .INIT(32'h000077F7)) 
    rd_check1_carry__1_i_3
       (.I0(i__carry__1_i_1[11]),
        .I1(i__carry__1_i_1_0[13]),
        .I2(m_axi_lite_ch1_rdata[13]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(m_axi_lite_ch1_rdata_18_sn_1),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[19] ));
  LUT6 #(
    .INIT(64'h55555D5500000000)) 
    rd_check1_carry__2_i_1
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .I1(i__carry__1_i_1_0[20]),
        .I2(i__carry__1_i_1[16]),
        .I3(m_axi_lite_ch1_rdata[20]),
        .I4(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I5(rd_check1_carry__2),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] [1]));
  LUT5 #(
    .INIT(32'h000077F7)) 
    rd_check1_carry__2_i_4
       (.I0(i__carry__1_i_1[14]),
        .I1(i__carry__1_i_1_0[17]),
        .I2(m_axi_lite_ch1_rdata[17]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(\m_axi_lite_ch1_rdata[24] ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[30] [0]));
  LUT5 #(
    .INIT(32'h000077F7)) 
    rd_check1_carry_i_1
       (.I0(i__carry__1_i_1[4]),
        .I1(i__carry__1_i_1_0[5]),
        .I2(m_axi_lite_ch1_rdata[5]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(m_axi_lite_ch1_rdata_6_sn_1),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] [1]));
  LUT5 #(
    .INIT(32'h000077F7)) 
    rd_check1_carry_i_4
       (.I0(i__carry__1_i_1[1]),
        .I1(i__carry__1_i_1_0[1]),
        .I2(m_axi_lite_ch1_rdata[1]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(m_axi_lite_ch1_rdata_0_sn_1),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[7] [0]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    rd_check2_carry__0_i_12
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(m_axi_lite_ch1_rdata[6]),
        .I2(i__carry__1_i_1_0[6]),
        .O(m_axi_lite_ch1_rdata_8_sn_1));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry__0_i_13
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(i__carry__1_i_1[9]),
        .I2(m_axi_lite_ch1_rdata[11]),
        .I3(i__carry__1_i_1_0[11]),
        .O(rd_check2_carry__0_i_13_n_0));
  LUT5 #(
    .INIT(32'hFFDF0000)) 
    rd_check2_carry__0_i_15
       (.I0(m_axi_lite_ch1_rdata[8]),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(i__carry__1_i_1_0[8]),
        .I3(i__carry__1_i_1[6]),
        .I4(rd_check2_carry__0_i_21_n_0),
        .O(m_axi_lite_ch1_rdata_12_sn_1));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry__0_i_18
       (.I0(rd_check2_carry_i_22_n_0),
        .I1(i__carry__1_i_1[5]),
        .I2(i__carry__1_i_1_0[7]),
        .I3(m_axi_lite_ch1_rdata[7]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[9] ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    rd_check2_carry__0_i_21
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(\max_retry_cntr[0]_i_9_n_0 ),
        .I2(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I3(i__carry__1_i_1[7]),
        .I4(m_axi_lite_ch1_rdata[9]),
        .I5(i__carry__1_i_1_0[9]),
        .O(rd_check2_carry__0_i_21_n_0));
  LUT6 #(
    .INIT(64'h0800808888888888)) 
    rd_check2_carry__0_i_5
       (.I0(rd_check2_carry__0_i_13_n_0),
        .I1(rd_check1_carry__0),
        .I2(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I3(m_axi_lite_ch1_rdata[10]),
        .I4(i__carry__1_i_1[8]),
        .I5(i__carry__1_i_1_0[10]),
        .O(\m_axi_lite_ch1_rdata[14]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    rd_check2_carry__1_i_10
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(m_axi_lite_ch1_rdata[14]),
        .I2(i__carry__1_i_1_0[14]),
        .O(m_axi_lite_ch1_rdata_20_sn_1));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry__1_i_15
       (.I0(rd_check2_carry_i_22_n_0),
        .I1(i__carry__1_i_1[12]),
        .I2(i__carry__1_i_1_0[15]),
        .I3(m_axi_lite_ch1_rdata[15]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[21] ));
  LUT5 #(
    .INIT(32'hFFDF0000)) 
    rd_check2_carry__1_i_16
       (.I0(m_axi_lite_ch1_rdata[12]),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(i__carry__1_i_1_0[12]),
        .I3(i__carry__1_i_1[10]),
        .I4(rd_check2_carry__1_i_21_n_0),
        .O(m_axi_lite_ch1_rdata_18_sn_1));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    rd_check2_carry__1_i_21
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(\max_retry_cntr[0]_i_9_n_0 ),
        .I2(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I3(i__carry__1_i_1[11]),
        .I4(m_axi_lite_ch1_rdata[13]),
        .I5(i__carry__1_i_1_0[13]),
        .O(rd_check2_carry__1_i_21_n_0));
  LUT6 #(
    .INIT(64'hAA2A222222222222)) 
    rd_check2_carry__2_i_1
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .I1(rd_check1_carry__2),
        .I2(m_axi_lite_ch1_rdata[20]),
        .I3(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I4(i__carry__1_i_1[16]),
        .I5(i__carry__1_i_1_0[20]),
        .O(\m_axi_lite_ch1_rdata[30] ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    rd_check2_carry__2_i_12
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(m_axi_lite_ch1_rdata[18]),
        .I2(i__carry__1_i_1_0[18]),
        .O(\m_axi_lite_ch1_rdata[26] ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry__2_i_16
       (.I0(rd_check2_carry_i_22_n_0),
        .I1(i__carry__1_i_1[15]),
        .I2(i__carry__1_i_1_0[19]),
        .I3(m_axi_lite_ch1_rdata[19]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[27] ));
  LUT5 #(
    .INIT(32'hFFDF0000)) 
    rd_check2_carry__2_i_17
       (.I0(m_axi_lite_ch1_rdata[16]),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(i__carry__1_i_1_0[16]),
        .I3(i__carry__1_i_1[13]),
        .I4(rd_check2_carry__2_i_20_n_0),
        .O(\m_axi_lite_ch1_rdata[24] ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    rd_check2_carry__2_i_20
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(\max_retry_cntr[0]_i_9_n_0 ),
        .I2(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I3(i__carry__1_i_1[14]),
        .I4(m_axi_lite_ch1_rdata[17]),
        .I5(i__carry__1_i_1_0[17]),
        .O(rd_check2_carry__2_i_20_n_0));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry__2_i_9
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(i__carry__1_i_1[17]),
        .I2(m_axi_lite_ch1_rdata[21]),
        .I3(i__carry__1_i_1_0[21]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    rd_check2_carry_i_11
       (.I0(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I1(m_axi_lite_ch1_rdata[2]),
        .I2(i__carry__1_i_1_0[2]),
        .O(m_axi_lite_ch1_rdata_2_sn_1));
  LUT5 #(
    .INIT(32'hFFDF0000)) 
    rd_check2_carry_i_13
       (.I0(m_axi_lite_ch1_rdata[4]),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(i__carry__1_i_1_0[4]),
        .I3(i__carry__1_i_1[3]),
        .I4(rd_check2_carry_i_21_n_0),
        .O(m_axi_lite_ch1_rdata_6_sn_1));
  LUT4 #(
    .INIT(16'hEFFF)) 
    rd_check2_carry_i_16
       (.I0(rd_check2_carry_i_22_n_0),
        .I1(i__carry__1_i_1[2]),
        .I2(i__carry__1_i_1_0[3]),
        .I3(m_axi_lite_ch1_rdata[3]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[3] ));
  LUT5 #(
    .INIT(32'hFFDF0000)) 
    rd_check2_carry_i_17
       (.I0(m_axi_lite_ch1_rdata[0]),
        .I1(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[28] ),
        .I2(i__carry__1_i_1_0[0]),
        .I3(i__carry__1_i_1[0]),
        .I4(rd_check2_carry_i_23_n_0),
        .O(m_axi_lite_ch1_rdata_0_sn_1));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    rd_check2_carry_i_21
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(\max_retry_cntr[0]_i_9_n_0 ),
        .I2(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I3(i__carry__1_i_1[4]),
        .I4(m_axi_lite_ch1_rdata[5]),
        .I5(i__carry__1_i_1_0[5]),
        .O(rd_check2_carry_i_21_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFD)) 
    rd_check2_carry_i_22
       (.I0(douta[26]),
        .I1(douta[25]),
        .I2(douta[28]),
        .I3(douta[29]),
        .I4(rd_check2_carry_i_24_n_0),
        .I5(rd_check2_carry_i_25_n_0),
        .O(rd_check2_carry_i_22_n_0));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    rd_check2_carry_i_23
       (.I0(m_axi_lite_ch1_awvalid_INST_0_i_2_n_0),
        .I1(\max_retry_cntr[0]_i_9_n_0 ),
        .I2(m_axi_lite_ch1_awvalid_INST_0_i_3_n_0),
        .I3(i__carry__1_i_1[1]),
        .I4(m_axi_lite_ch1_rdata[1]),
        .I5(i__carry__1_i_1_0[1]),
        .O(rd_check2_carry_i_23_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFFFFFF)) 
    rd_check2_carry_i_24
       (.I0(douta[27]),
        .I1(douta[22]),
        .I2(douta[31]),
        .I3(douta[23]),
        .I4(douta[21]),
        .I5(douta[18]),
        .O(rd_check2_carry_i_24_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEEEFFFF)) 
    rd_check2_carry_i_25
       (.I0(douta[19]),
        .I1(douta[20]),
        .I2(douta[16]),
        .I3(douta[17]),
        .I4(douta[30]),
        .I5(douta[24]),
        .O(rd_check2_carry_i_25_n_0));
  (* ADDR_WIDTH_A = "8" *) 
  (* ADDR_WIDTH_B = "8" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "8" *) 
  (* BYTE_WRITE_WIDTH_B = "32" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "0" *) 
  (* ECC_BIT_RANGE = "[7:0]" *) 
  (* ECC_MODE = "0" *) 
  (* ECC_TYPE = "NONE" *) 
  (* IGNORE_INIT_SYNTH = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* MEMORY_INIT_FILE = "mipi_init_gen_addr.mem" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "1" *) 
  (* MEMORY_SIZE = "8192" *) 
  (* MEMORY_TYPE = "0" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "1" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "256" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "distributed" *) 
  (* P_MIN_WIDTH_DATA = "32" *) 
  (* P_MIN_WIDTH_DATA_A = "32" *) 
  (* P_MIN_WIDTH_DATA_B = "32" *) 
  (* P_MIN_WIDTH_DATA_ECC = "32" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
  (* P_NUM_COLS_WRITE_A = "4" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "8" *) 
  (* P_WIDTH_ADDR_READ_B = "8" *) 
  (* P_WIDTH_ADDR_WRITE_A = "8" *) 
  (* P_WIDTH_ADDR_WRITE_B = "8" *) 
  (* P_WIDTH_COL_WRITE_A = "8" *) 
  (* P_WIDTH_COL_WRITE_B = "32" *) 
  (* RAM_DECOMP = "auto" *) 
  (* READ_DATA_WIDTH_A = "32" *) 
  (* READ_DATA_WIDTH_B = "32" *) 
  (* READ_LATENCY_A = "1" *) 
  (* READ_LATENCY_B = "1" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "1" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "32" *) 
  (* WRITE_DATA_WIDTH_B = "32" *) 
  (* WRITE_MODE_A = "1" *) 
  (* WRITE_MODE_B = "1" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "32" *) 
  (* rstb_loop_iter = "32" *) 
  mipi_init_gen_xpm_memory_base__parameterized1 xpm_memory_base_inst
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(s_axi_aclk),
        .clkb(1'b0),
        .dbiterra(NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED),
        .dbiterrb(NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_xpm_memory_base_inst_doutb_UNCONNECTED[31:0]),
        .ena(1'b1),
        .enb(1'b0),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b1),
        .regceb(1'b0),
        .rsta(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31]_0 ),
        .rstb(1'b0),
        .sbiterra(NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED),
        .sbiterrb(NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_memory_spram" *) 
module mipi_init_gen_xpm_memory_spram__parameterized2
   (douta,
    \m_axi_lite_ch1_rdata[11] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ,
    DI,
    \m_axi_lite_ch1_rdata[5] ,
    \m_axi_lite_ch1_rdata[23] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ,
    \m_axi_lite_ch1_rdata[11]_0 ,
    \m_axi_lite_ch1_rdata[22] ,
    \m_axi_lite_ch1_rdata[23]_0 ,
    \m_axi_lite_ch1_rdata[23]_1 ,
    \m_axi_lite_ch1_rdata[29] ,
    \m_axi_lite_ch1_rdata[28] ,
    \m_axi_lite_ch1_rdata[29]_0 ,
    \m_axi_lite_ch1_rdata[29]_1 ,
    S,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ,
    \m_axi_lite_ch1_rdata[22]_0 ,
    \m_axi_lite_ch1_rdata[28]_0 ,
    s_axi_aclk,
    \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ,
    addra,
    rom_eof0,
    m_axi_lite_ch1_rdata,
    rd_check2_carry__2,
    \rd_check2_inferred__0/i__carry ,
    \rd_check2_inferred__0/i__carry_0 ,
    rd_check1_carry,
    rd_check2_carry,
    \rd_check2_inferred__0/i__carry_1 ,
    \rd_check2_inferred__0/i__carry__0 ,
    \rd_check2_inferred__0/i__carry_2 ,
    rd_check1_carry__0,
    rd_check2_carry__0,
    \rd_check2_inferred__0/i__carry__0_0 ,
    rd_check1_carry__1,
    rd_check2_carry__1,
    \rd_check2_inferred__0/i__carry__0_1 ,
    rd_check1_carry__1_0,
    \rd_check2_inferred__0/i__carry__1 ,
    rd_check1_carry__2,
    rd_check2_carry__2_0,
    \rd_check2_inferred__0/i__carry__1_0 );
  output [31:0]douta;
  output [3:0]\m_axi_lite_ch1_rdata[11] ;
  output [3:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ;
  output [3:0]DI;
  output [0:0]\m_axi_lite_ch1_rdata[5] ;
  output [3:0]\m_axi_lite_ch1_rdata[23] ;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ;
  output [0:0]\m_axi_lite_ch1_rdata[11]_0 ;
  output [3:0]\m_axi_lite_ch1_rdata[22] ;
  output [3:0]\m_axi_lite_ch1_rdata[23]_0 ;
  output [1:0]\m_axi_lite_ch1_rdata[23]_1 ;
  output [1:0]\m_axi_lite_ch1_rdata[29] ;
  output [2:0]\m_axi_lite_ch1_rdata[28] ;
  output [2:0]\m_axi_lite_ch1_rdata[29]_0 ;
  output [0:0]\m_axi_lite_ch1_rdata[29]_1 ;
  output [3:0]S;
  output [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ;
  output [3:0]\m_axi_lite_ch1_rdata[22]_0 ;
  output [2:0]\m_axi_lite_ch1_rdata[28]_0 ;
  input s_axi_aclk;
  input \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  input [7:0]addra;
  input rom_eof0;
  input [29:0]m_axi_lite_ch1_rdata;
  input [29:0]rd_check2_carry__2;
  input \rd_check2_inferred__0/i__carry ;
  input \rd_check2_inferred__0/i__carry_0 ;
  input rd_check1_carry;
  input rd_check2_carry;
  input \rd_check2_inferred__0/i__carry_1 ;
  input \rd_check2_inferred__0/i__carry__0 ;
  input \rd_check2_inferred__0/i__carry_2 ;
  input rd_check1_carry__0;
  input rd_check2_carry__0;
  input \rd_check2_inferred__0/i__carry__0_0 ;
  input rd_check1_carry__1;
  input rd_check2_carry__1;
  input \rd_check2_inferred__0/i__carry__0_1 ;
  input rd_check1_carry__1_0;
  input \rd_check2_inferred__0/i__carry__1 ;
  input rd_check1_carry__2;
  input rd_check2_carry__2_0;
  input \rd_check2_inferred__0/i__carry__1_0 ;

  wire [3:0]DI;
  wire [3:0]S;
  wire [7:0]addra;
  wire [31:0]douta;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] ;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 ;
  wire [2:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] ;
  wire \gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ;
  wire [3:0]\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] ;
  wire [29:0]m_axi_lite_ch1_rdata;
  wire [3:0]\m_axi_lite_ch1_rdata[11] ;
  wire [0:0]\m_axi_lite_ch1_rdata[11]_0 ;
  wire [3:0]\m_axi_lite_ch1_rdata[22] ;
  wire [3:0]\m_axi_lite_ch1_rdata[22]_0 ;
  wire [3:0]\m_axi_lite_ch1_rdata[23] ;
  wire [3:0]\m_axi_lite_ch1_rdata[23]_0 ;
  wire [1:0]\m_axi_lite_ch1_rdata[23]_1 ;
  wire [2:0]\m_axi_lite_ch1_rdata[28] ;
  wire [2:0]\m_axi_lite_ch1_rdata[28]_0 ;
  wire [1:0]\m_axi_lite_ch1_rdata[29] ;
  wire [2:0]\m_axi_lite_ch1_rdata[29]_0 ;
  wire [0:0]\m_axi_lite_ch1_rdata[29]_1 ;
  wire [0:0]\m_axi_lite_ch1_rdata[5] ;
  wire rd_check1_carry;
  wire rd_check1_carry__0;
  wire rd_check1_carry__0_i_11_n_0;
  wire rd_check1_carry__0_i_9_n_0;
  wire rd_check1_carry__1;
  wire rd_check1_carry__1_0;
  wire rd_check1_carry__1_i_11_n_0;
  wire rd_check1_carry__1_i_12_n_0;
  wire rd_check1_carry__1_i_13_n_0;
  wire rd_check1_carry__1_i_9_n_0;
  wire rd_check1_carry__2;
  wire rd_check1_carry__2_i_11_n_0;
  wire rd_check1_carry__2_i_9_n_0;
  wire rd_check1_carry_i_11_n_0;
  wire rd_check1_carry_i_9_n_0;
  wire rd_check2_carry;
  wire rd_check2_carry__0;
  wire rd_check2_carry__0_i_10_n_0;
  wire rd_check2_carry__0_i_11_n_0;
  wire rd_check2_carry__0_i_17_n_0;
  wire rd_check2_carry__0_i_19_n_0;
  wire rd_check2_carry__0_i_20_n_0;
  wire rd_check2_carry__1;
  wire rd_check2_carry__1_i_11_n_0;
  wire rd_check2_carry__1_i_12_n_0;
  wire rd_check2_carry__1_i_14_n_0;
  wire rd_check2_carry__1_i_18_n_0;
  wire rd_check2_carry__1_i_19_n_0;
  wire rd_check2_carry__1_i_20_n_0;
  wire rd_check2_carry__1_i_9_n_0;
  wire [29:0]rd_check2_carry__2;
  wire rd_check2_carry__2_0;
  wire rd_check2_carry__2_i_11_n_0;
  wire rd_check2_carry__2_i_13_n_0;
  wire rd_check2_carry__2_i_15_n_0;
  wire rd_check2_carry__2_i_18_n_0;
  wire rd_check2_carry__2_i_19_n_0;
  wire rd_check2_carry_i_10_n_0;
  wire rd_check2_carry_i_12_n_0;
  wire rd_check2_carry_i_15_n_0;
  wire rd_check2_carry_i_18_n_0;
  wire rd_check2_carry_i_19_n_0;
  wire rd_check2_carry_i_20_n_0;
  wire rd_check2_carry_i_9_n_0;
  wire \rd_check2_inferred__0/i__carry ;
  wire \rd_check2_inferred__0/i__carry_0 ;
  wire \rd_check2_inferred__0/i__carry_1 ;
  wire \rd_check2_inferred__0/i__carry_2 ;
  wire \rd_check2_inferred__0/i__carry__0 ;
  wire \rd_check2_inferred__0/i__carry__0_0 ;
  wire \rd_check2_inferred__0/i__carry__0_1 ;
  wire \rd_check2_inferred__0/i__carry__1 ;
  wire \rd_check2_inferred__0/i__carry__1_0 ;
  wire rom_eof0;
  wire s_axi_aclk;
  wire NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED;
  wire NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED;
  wire [31:0]NLW_xpm_memory_base_inst_doutb_UNCONNECTED;

  LUT4 #(
    .INIT(16'h0400)) 
    i__carry__0_i_1
       (.I0(rd_check1_carry__1_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry__0_0 ),
        .I2(rd_check2_carry__1_i_14_n_0),
        .I3(rd_check2_carry__1_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[23] [3]));
  LUT6 #(
    .INIT(64'h65FF000000000000)) 
    i__carry__0_i_2
       (.I0(douta[20]),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[20]),
        .I3(rd_check2_carry__2[20]),
        .I4(rd_check2_carry__1_i_11_n_0),
        .I5(\rd_check2_inferred__0/i__carry__0_1 ),
        .O(\m_axi_lite_ch1_rdata[23] [2]));
  LUT6 #(
    .INIT(64'h0451555500000000)) 
    i__carry__0_i_3
       (.I0(rd_check1_carry__1_i_11_n_0),
        .I1(m_axi_lite_ch1_rdata[15]),
        .I2(rom_eof0),
        .I3(douta[15]),
        .I4(rd_check2_carry__2[15]),
        .I5(rd_check2_carry__1_i_12_n_0),
        .O(\m_axi_lite_ch1_rdata[23] [1]));
  LUT6 #(
    .INIT(64'h20AA8AAA00000000)) 
    i__carry__0_i_4
       (.I0(rd_check2_carry__0_i_10_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[14]),
        .I3(rd_check2_carry__2[14]),
        .I4(douta[14]),
        .I5(\rd_check2_inferred__0/i__carry__0 ),
        .O(\m_axi_lite_ch1_rdata[23] [0]));
  LUT4 #(
    .INIT(16'h0400)) 
    i__carry__1_i_2
       (.I0(rd_check1_carry__2_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry__1 ),
        .I2(rd_check2_carry__2_i_15_n_0),
        .I3(rd_check2_carry__2_i_11_n_0),
        .O(\m_axi_lite_ch1_rdata[29] [1]));
  LUT6 #(
    .INIT(64'h65FF000000000000)) 
    i__carry__1_i_3
       (.I0(douta[26]),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[26]),
        .I3(rd_check2_carry__2[26]),
        .I4(rd_check2_carry__2_i_13_n_0),
        .I5(\rd_check2_inferred__0/i__carry__1_0 ),
        .O(\m_axi_lite_ch1_rdata[29] [0]));
  LUT4 #(
    .INIT(16'h0400)) 
    i__carry_i_1
       (.I0(rd_check1_carry__0_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry_2 ),
        .I2(rd_check2_carry__0_i_17_n_0),
        .I3(rd_check2_carry__0_i_11_n_0),
        .O(\m_axi_lite_ch1_rdata[11] [3]));
  LUT6 #(
    .INIT(64'h65FF000000000000)) 
    i__carry_i_2
       (.I0(douta[8]),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[8]),
        .I3(rd_check2_carry__2[8]),
        .I4(rd_check2_carry_i_9_n_0),
        .I5(\rd_check2_inferred__0/i__carry ),
        .O(\m_axi_lite_ch1_rdata[11] [2]));
  LUT4 #(
    .INIT(16'h0400)) 
    i__carry_i_3
       (.I0(rd_check1_carry_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry_0 ),
        .I2(rd_check2_carry_i_15_n_0),
        .I3(rd_check2_carry_i_10_n_0),
        .O(\m_axi_lite_ch1_rdata[11] [1]));
  LUT6 #(
    .INIT(64'h65FF000000000000)) 
    i__carry_i_4
       (.I0(douta[2]),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[2]),
        .I3(rd_check2_carry__2[2]),
        .I4(rd_check2_carry_i_12_n_0),
        .I5(\rd_check2_inferred__0/i__carry_1 ),
        .O(\m_axi_lite_ch1_rdata[11] [0]));
  LUT3 #(
    .INIT(8'h40)) 
    rd_check1_carry__0_i_11
       (.I0(douta[10]),
        .I1(rd_check2_carry__2[10]),
        .I2(m_axi_lite_ch1_rdata[10]),
        .O(rd_check1_carry__0_i_11_n_0));
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    rd_check1_carry__0_i_3
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[11]),
        .I2(douta[11]),
        .I3(rd_check2_carry__2[11]),
        .I4(rd_check1_carry__0_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[11]_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check1_carry__0_i_6
       (.I0(rd_check2_carry__0_i_10_n_0),
        .I1(\rd_check2_inferred__0/i__carry__0 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] [2]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check1_carry__0_i_7
       (.I0(rd_check2_carry__0_i_11_n_0),
        .I1(rd_check1_carry__0),
        .I2(m_axi_lite_ch1_rdata[10]),
        .I3(rd_check2_carry__2[10]),
        .I4(douta[10]),
        .I5(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] [1]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check1_carry__0_i_8
       (.I0(rd_check2_carry__0_i_17_n_0),
        .I1(douta[8]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[8]),
        .I4(rd_check2_carry__2[8]),
        .I5(\rd_check2_inferred__0/i__carry_2 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12] [0]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h22322222)) 
    rd_check1_carry__0_i_9
       (.I0(rd_check1_carry__0_i_11_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[11]),
        .I3(douta[11]),
        .I4(rd_check2_carry__2[11]),
        .O(rd_check1_carry__0_i_9_n_0));
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    rd_check1_carry__1_i_1
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[23]),
        .I2(douta[23]),
        .I3(rd_check2_carry__2[23]),
        .I4(rd_check1_carry__1_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[23]_1 [1]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h22322222)) 
    rd_check1_carry__1_i_11
       (.I0(rd_check1_carry__1_i_13_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[17]),
        .I3(douta[17]),
        .I4(rd_check2_carry__2[17]),
        .O(rd_check1_carry__1_i_11_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    rd_check1_carry__1_i_12
       (.I0(douta[22]),
        .I1(rd_check2_carry__2[22]),
        .I2(m_axi_lite_ch1_rdata[22]),
        .O(rd_check1_carry__1_i_12_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    rd_check1_carry__1_i_13
       (.I0(douta[16]),
        .I1(rd_check2_carry__2[16]),
        .I2(m_axi_lite_ch1_rdata[16]),
        .O(rd_check1_carry__1_i_13_n_0));
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    rd_check1_carry__1_i_4
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[17]),
        .I2(douta[17]),
        .I3(rd_check2_carry__2[17]),
        .I4(rd_check1_carry__1_i_11_n_0),
        .O(\m_axi_lite_ch1_rdata[23]_1 [0]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check1_carry__1_i_5
       (.I0(rd_check2_carry__1_i_9_n_0),
        .I1(rd_check1_carry__1),
        .I2(m_axi_lite_ch1_rdata[22]),
        .I3(rd_check2_carry__2[22]),
        .I4(douta[22]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[22] [3]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check1_carry__1_i_6
       (.I0(rd_check2_carry__1_i_14_n_0),
        .I1(douta[20]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[20]),
        .I4(rd_check2_carry__2[20]),
        .I5(\rd_check2_inferred__0/i__carry__0_0 ),
        .O(\m_axi_lite_ch1_rdata[22] [2]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check1_carry__1_i_7
       (.I0(rd_check2_carry__1_i_11_n_0),
        .I1(\rd_check2_inferred__0/i__carry__0_1 ),
        .O(\m_axi_lite_ch1_rdata[22] [1]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check1_carry__1_i_8
       (.I0(rd_check2_carry__1_i_12_n_0),
        .I1(rd_check1_carry__1_0),
        .I2(m_axi_lite_ch1_rdata[16]),
        .I3(rd_check2_carry__2[16]),
        .I4(douta[16]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[22] [0]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h22322222)) 
    rd_check1_carry__1_i_9
       (.I0(rd_check1_carry__1_i_12_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[23]),
        .I3(douta[23]),
        .I4(rd_check2_carry__2[23]),
        .O(rd_check1_carry__1_i_9_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    rd_check1_carry__2_i_11
       (.I0(douta[28]),
        .I1(rd_check2_carry__2[28]),
        .I2(m_axi_lite_ch1_rdata[28]),
        .O(rd_check1_carry__2_i_11_n_0));
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    rd_check1_carry__2_i_2
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[29]),
        .I2(douta[29]),
        .I3(rd_check2_carry__2[29]),
        .I4(rd_check1_carry__2_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[29]_1 ));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check1_carry__2_i_6
       (.I0(rd_check2_carry__2_i_11_n_0),
        .I1(rd_check1_carry__2),
        .I2(m_axi_lite_ch1_rdata[28]),
        .I3(rd_check2_carry__2[28]),
        .I4(douta[28]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[28] [2]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check1_carry__2_i_7
       (.I0(rd_check2_carry__2_i_15_n_0),
        .I1(douta[26]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[26]),
        .I4(rd_check2_carry__2[26]),
        .I5(\rd_check2_inferred__0/i__carry__1 ),
        .O(\m_axi_lite_ch1_rdata[28] [1]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check1_carry__2_i_8
       (.I0(rd_check2_carry__2_i_13_n_0),
        .I1(\rd_check2_inferred__0/i__carry__1_0 ),
        .O(\m_axi_lite_ch1_rdata[28] [0]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h22322222)) 
    rd_check1_carry__2_i_9
       (.I0(rd_check1_carry__2_i_11_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[29]),
        .I3(douta[29]),
        .I4(rd_check2_carry__2[29]),
        .O(rd_check1_carry__2_i_9_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    rd_check1_carry_i_11
       (.I0(douta[4]),
        .I1(rd_check2_carry__2[4]),
        .I2(m_axi_lite_ch1_rdata[4]),
        .O(rd_check1_carry_i_11_n_0));
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    rd_check1_carry_i_2
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[5]),
        .I2(douta[5]),
        .I3(rd_check2_carry__2[5]),
        .I4(rd_check1_carry_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[5] ));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check1_carry_i_5
       (.I0(rd_check2_carry_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] [3]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check1_carry_i_6
       (.I0(rd_check2_carry_i_10_n_0),
        .I1(rd_check1_carry),
        .I2(m_axi_lite_ch1_rdata[4]),
        .I3(rd_check2_carry__2[4]),
        .I4(douta[4]),
        .I5(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] [2]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check1_carry_i_7
       (.I0(rd_check2_carry_i_15_n_0),
        .I1(douta[2]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[2]),
        .I4(rd_check2_carry__2[2]),
        .I5(\rd_check2_inferred__0/i__carry_0 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] [1]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check1_carry_i_8
       (.I0(rd_check2_carry_i_12_n_0),
        .I1(\rd_check2_inferred__0/i__carry_1 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[6] [0]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h22322222)) 
    rd_check1_carry_i_9
       (.I0(rd_check1_carry_i_11_n_0),
        .I1(rom_eof0),
        .I2(m_axi_lite_ch1_rdata[5]),
        .I3(douta[5]),
        .I4(rd_check2_carry__2[5]),
        .O(rd_check1_carry_i_9_n_0));
  LUT6 #(
    .INIT(64'h7777FF770000F070)) 
    rd_check2_carry__0_i_10
       (.I0(rd_check2_carry__2[12]),
        .I1(douta[12]),
        .I2(m_axi_lite_ch1_rdata[13]),
        .I3(m_axi_lite_ch1_rdata[12]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__0_i_19_n_0),
        .O(rd_check2_carry__0_i_10_n_0));
  LUT6 #(
    .INIT(64'h7777F7F70000F700)) 
    rd_check2_carry__0_i_11
       (.I0(rd_check2_carry__2[10]),
        .I1(douta[10]),
        .I2(m_axi_lite_ch1_rdata[10]),
        .I3(m_axi_lite_ch1_rdata[11]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__0_i_20_n_0),
        .O(rd_check2_carry__0_i_11_n_0));
  LUT4 #(
    .INIT(16'h8808)) 
    rd_check2_carry__0_i_17
       (.I0(douta[9]),
        .I1(rd_check2_carry__2[9]),
        .I2(m_axi_lite_ch1_rdata[9]),
        .I3(rom_eof0),
        .O(rd_check2_carry__0_i_17_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__0_i_19
       (.I0(douta[13]),
        .I1(rd_check2_carry__2[13]),
        .O(rd_check2_carry__0_i_19_n_0));
  LUT5 #(
    .INIT(32'h0000FFF7)) 
    rd_check2_carry__0_i_2
       (.I0(rd_check2_carry__2[13]),
        .I1(m_axi_lite_ch1_rdata[13]),
        .I2(douta[13]),
        .I3(rom_eof0),
        .I4(rd_check2_carry__0_i_10_n_0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] [2]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__0_i_20
       (.I0(douta[11]),
        .I1(rd_check2_carry__2[11]),
        .O(rd_check2_carry__0_i_20_n_0));
  LUT5 #(
    .INIT(32'h0000FBFF)) 
    rd_check2_carry__0_i_3
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[11]),
        .I2(douta[11]),
        .I3(rd_check2_carry__2[11]),
        .I4(rd_check2_carry__0_i_11_n_0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] [1]));
  LUT6 #(
    .INIT(64'hF2FF222220222222)) 
    rd_check2_carry__0_i_4
       (.I0(douta[8]),
        .I1(rd_check2_carry__0),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[9]),
        .I4(rd_check2_carry__2[9]),
        .I5(douta[9]),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[13] [0]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check2_carry__0_i_6
       (.I0(rd_check2_carry__0_i_10_n_0),
        .I1(\rd_check2_inferred__0/i__carry__0 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 [2]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check2_carry__0_i_7
       (.I0(rd_check2_carry__0_i_11_n_0),
        .I1(rd_check1_carry__0),
        .I2(m_axi_lite_ch1_rdata[10]),
        .I3(rd_check2_carry__2[10]),
        .I4(douta[10]),
        .I5(rom_eof0),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 [1]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check2_carry__0_i_8
       (.I0(rd_check2_carry__0_i_17_n_0),
        .I1(douta[8]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[8]),
        .I4(rd_check2_carry__2[8]),
        .I5(\rd_check2_inferred__0/i__carry_2 ),
        .O(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[12]_0 [0]));
  LUT5 #(
    .INIT(32'h0000FBFF)) 
    rd_check2_carry__1_i_1
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[23]),
        .I2(douta[23]),
        .I3(rd_check2_carry__2[23]),
        .I4(rd_check2_carry__1_i_9_n_0),
        .O(\m_axi_lite_ch1_rdata[23]_0 [3]));
  LUT6 #(
    .INIT(64'h7777FF770000F070)) 
    rd_check2_carry__1_i_11
       (.I0(rd_check2_carry__2[18]),
        .I1(douta[18]),
        .I2(m_axi_lite_ch1_rdata[19]),
        .I3(m_axi_lite_ch1_rdata[18]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__1_i_19_n_0),
        .O(rd_check2_carry__1_i_11_n_0));
  LUT6 #(
    .INIT(64'h7777F7F70000F700)) 
    rd_check2_carry__1_i_12
       (.I0(rd_check2_carry__2[16]),
        .I1(douta[16]),
        .I2(m_axi_lite_ch1_rdata[16]),
        .I3(m_axi_lite_ch1_rdata[17]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__1_i_20_n_0),
        .O(rd_check2_carry__1_i_12_n_0));
  LUT4 #(
    .INIT(16'h8808)) 
    rd_check2_carry__1_i_14
       (.I0(douta[21]),
        .I1(rd_check2_carry__2[21]),
        .I2(m_axi_lite_ch1_rdata[21]),
        .I3(rom_eof0),
        .O(rd_check2_carry__1_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__1_i_18
       (.I0(douta[23]),
        .I1(rd_check2_carry__2[23]),
        .O(rd_check2_carry__1_i_18_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__1_i_19
       (.I0(douta[19]),
        .I1(rd_check2_carry__2[19]),
        .O(rd_check2_carry__1_i_19_n_0));
  LUT6 #(
    .INIT(64'hF2FF222220222222)) 
    rd_check2_carry__1_i_2
       (.I0(douta[20]),
        .I1(rd_check2_carry__1),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[21]),
        .I4(rd_check2_carry__2[21]),
        .I5(douta[21]),
        .O(\m_axi_lite_ch1_rdata[23]_0 [2]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__1_i_20
       (.I0(douta[17]),
        .I1(rd_check2_carry__2[17]),
        .O(rd_check2_carry__1_i_20_n_0));
  LUT5 #(
    .INIT(32'h0000FFF7)) 
    rd_check2_carry__1_i_3
       (.I0(rd_check2_carry__2[19]),
        .I1(m_axi_lite_ch1_rdata[19]),
        .I2(douta[19]),
        .I3(rom_eof0),
        .I4(rd_check2_carry__1_i_11_n_0),
        .O(\m_axi_lite_ch1_rdata[23]_0 [1]));
  LUT5 #(
    .INIT(32'h0000FBFF)) 
    rd_check2_carry__1_i_4
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[17]),
        .I2(douta[17]),
        .I3(rd_check2_carry__2[17]),
        .I4(rd_check2_carry__1_i_12_n_0),
        .O(\m_axi_lite_ch1_rdata[23]_0 [0]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check2_carry__1_i_5
       (.I0(rd_check2_carry__1_i_9_n_0),
        .I1(rd_check1_carry__1),
        .I2(m_axi_lite_ch1_rdata[22]),
        .I3(rd_check2_carry__2[22]),
        .I4(douta[22]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[22]_0 [3]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check2_carry__1_i_6
       (.I0(rd_check2_carry__1_i_14_n_0),
        .I1(douta[20]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[20]),
        .I4(rd_check2_carry__2[20]),
        .I5(\rd_check2_inferred__0/i__carry__0_0 ),
        .O(\m_axi_lite_ch1_rdata[22]_0 [2]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check2_carry__1_i_7
       (.I0(rd_check2_carry__1_i_11_n_0),
        .I1(\rd_check2_inferred__0/i__carry__0_1 ),
        .O(\m_axi_lite_ch1_rdata[22]_0 [1]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check2_carry__1_i_8
       (.I0(rd_check2_carry__1_i_12_n_0),
        .I1(rd_check1_carry__1_0),
        .I2(m_axi_lite_ch1_rdata[16]),
        .I3(rd_check2_carry__2[16]),
        .I4(douta[16]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[22]_0 [0]));
  LUT6 #(
    .INIT(64'h7777F7F70000F700)) 
    rd_check2_carry__1_i_9
       (.I0(rd_check2_carry__2[22]),
        .I1(douta[22]),
        .I2(m_axi_lite_ch1_rdata[22]),
        .I3(m_axi_lite_ch1_rdata[23]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__1_i_18_n_0),
        .O(rd_check2_carry__1_i_9_n_0));
  LUT6 #(
    .INIT(64'h7777F7F70000F700)) 
    rd_check2_carry__2_i_11
       (.I0(rd_check2_carry__2[28]),
        .I1(douta[28]),
        .I2(m_axi_lite_ch1_rdata[28]),
        .I3(m_axi_lite_ch1_rdata[29]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__2_i_18_n_0),
        .O(rd_check2_carry__2_i_11_n_0));
  LUT6 #(
    .INIT(64'h7777FF770000F070)) 
    rd_check2_carry__2_i_13
       (.I0(rd_check2_carry__2[24]),
        .I1(douta[24]),
        .I2(m_axi_lite_ch1_rdata[25]),
        .I3(m_axi_lite_ch1_rdata[24]),
        .I4(rom_eof0),
        .I5(rd_check2_carry__2_i_19_n_0),
        .O(rd_check2_carry__2_i_13_n_0));
  LUT4 #(
    .INIT(16'h8808)) 
    rd_check2_carry__2_i_15
       (.I0(douta[27]),
        .I1(rd_check2_carry__2[27]),
        .I2(m_axi_lite_ch1_rdata[27]),
        .I3(rom_eof0),
        .O(rd_check2_carry__2_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__2_i_18
       (.I0(douta[29]),
        .I1(rd_check2_carry__2[29]),
        .O(rd_check2_carry__2_i_18_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry__2_i_19
       (.I0(douta[25]),
        .I1(rd_check2_carry__2[25]),
        .O(rd_check2_carry__2_i_19_n_0));
  LUT5 #(
    .INIT(32'h0000FBFF)) 
    rd_check2_carry__2_i_2
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[29]),
        .I2(douta[29]),
        .I3(rd_check2_carry__2[29]),
        .I4(rd_check2_carry__2_i_11_n_0),
        .O(\m_axi_lite_ch1_rdata[29]_0 [2]));
  LUT6 #(
    .INIT(64'hF2FF222220222222)) 
    rd_check2_carry__2_i_3
       (.I0(douta[26]),
        .I1(rd_check2_carry__2_0),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[27]),
        .I4(rd_check2_carry__2[27]),
        .I5(douta[27]),
        .O(\m_axi_lite_ch1_rdata[29]_0 [1]));
  LUT5 #(
    .INIT(32'h0000FFF7)) 
    rd_check2_carry__2_i_4
       (.I0(rd_check2_carry__2[25]),
        .I1(m_axi_lite_ch1_rdata[25]),
        .I2(douta[25]),
        .I3(rom_eof0),
        .I4(rd_check2_carry__2_i_13_n_0),
        .O(\m_axi_lite_ch1_rdata[29]_0 [0]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check2_carry__2_i_6
       (.I0(rd_check2_carry__2_i_11_n_0),
        .I1(rd_check1_carry__2),
        .I2(m_axi_lite_ch1_rdata[28]),
        .I3(rd_check2_carry__2[28]),
        .I4(douta[28]),
        .I5(rom_eof0),
        .O(\m_axi_lite_ch1_rdata[28]_0 [2]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check2_carry__2_i_7
       (.I0(rd_check2_carry__2_i_15_n_0),
        .I1(douta[26]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[26]),
        .I4(rd_check2_carry__2[26]),
        .I5(\rd_check2_inferred__0/i__carry__1 ),
        .O(\m_axi_lite_ch1_rdata[28]_0 [1]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check2_carry__2_i_8
       (.I0(rd_check2_carry__2_i_13_n_0),
        .I1(\rd_check2_inferred__0/i__carry__1_0 ),
        .O(\m_axi_lite_ch1_rdata[28]_0 [0]));
  LUT5 #(
    .INIT(32'h0000FFF7)) 
    rd_check2_carry_i_1
       (.I0(rd_check2_carry__2[7]),
        .I1(m_axi_lite_ch1_rdata[7]),
        .I2(douta[7]),
        .I3(rom_eof0),
        .I4(rd_check2_carry_i_9_n_0),
        .O(DI[3]));
  LUT6 #(
    .INIT(64'h7777F7F70000F700)) 
    rd_check2_carry_i_10
       (.I0(rd_check2_carry__2[4]),
        .I1(douta[4]),
        .I2(m_axi_lite_ch1_rdata[4]),
        .I3(m_axi_lite_ch1_rdata[5]),
        .I4(rom_eof0),
        .I5(rd_check2_carry_i_19_n_0),
        .O(rd_check2_carry_i_10_n_0));
  LUT6 #(
    .INIT(64'h7777FF770000F070)) 
    rd_check2_carry_i_12
       (.I0(rd_check2_carry__2[0]),
        .I1(douta[0]),
        .I2(m_axi_lite_ch1_rdata[1]),
        .I3(m_axi_lite_ch1_rdata[0]),
        .I4(rom_eof0),
        .I5(rd_check2_carry_i_20_n_0),
        .O(rd_check2_carry_i_12_n_0));
  LUT4 #(
    .INIT(16'h8808)) 
    rd_check2_carry_i_15
       (.I0(douta[3]),
        .I1(rd_check2_carry__2[3]),
        .I2(m_axi_lite_ch1_rdata[3]),
        .I3(rom_eof0),
        .O(rd_check2_carry_i_15_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry_i_18
       (.I0(douta[7]),
        .I1(rd_check2_carry__2[7]),
        .O(rd_check2_carry_i_18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry_i_19
       (.I0(douta[5]),
        .I1(rd_check2_carry__2[5]),
        .O(rd_check2_carry_i_19_n_0));
  LUT5 #(
    .INIT(32'h0000FBFF)) 
    rd_check2_carry_i_2
       (.I0(rom_eof0),
        .I1(m_axi_lite_ch1_rdata[5]),
        .I2(douta[5]),
        .I3(rd_check2_carry__2[5]),
        .I4(rd_check2_carry_i_10_n_0),
        .O(DI[2]));
  LUT2 #(
    .INIT(4'h7)) 
    rd_check2_carry_i_20
       (.I0(douta[1]),
        .I1(rd_check2_carry__2[1]),
        .O(rd_check2_carry_i_20_n_0));
  LUT6 #(
    .INIT(64'hF2FF222220222222)) 
    rd_check2_carry_i_3
       (.I0(douta[2]),
        .I1(rd_check2_carry),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[3]),
        .I4(rd_check2_carry__2[3]),
        .I5(douta[3]),
        .O(DI[1]));
  LUT5 #(
    .INIT(32'h0000FFF7)) 
    rd_check2_carry_i_4
       (.I0(rd_check2_carry__2[1]),
        .I1(m_axi_lite_ch1_rdata[1]),
        .I2(douta[1]),
        .I3(rom_eof0),
        .I4(rd_check2_carry_i_12_n_0),
        .O(DI[0]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check2_carry_i_5
       (.I0(rd_check2_carry_i_9_n_0),
        .I1(\rd_check2_inferred__0/i__carry ),
        .O(S[3]));
  LUT6 #(
    .INIT(64'h8888888888880888)) 
    rd_check2_carry_i_6
       (.I0(rd_check2_carry_i_10_n_0),
        .I1(rd_check1_carry),
        .I2(m_axi_lite_ch1_rdata[4]),
        .I3(rd_check2_carry__2[4]),
        .I4(douta[4]),
        .I5(rom_eof0),
        .O(S[2]));
  LUT6 #(
    .INIT(64'h1411555500000000)) 
    rd_check2_carry_i_7
       (.I0(rd_check2_carry_i_15_n_0),
        .I1(douta[2]),
        .I2(rom_eof0),
        .I3(m_axi_lite_ch1_rdata[2]),
        .I4(rd_check2_carry__2[2]),
        .I5(\rd_check2_inferred__0/i__carry_0 ),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h8)) 
    rd_check2_carry_i_8
       (.I0(rd_check2_carry_i_12_n_0),
        .I1(\rd_check2_inferred__0/i__carry_1 ),
        .O(S[0]));
  LUT6 #(
    .INIT(64'h7777FF770000F070)) 
    rd_check2_carry_i_9
       (.I0(rd_check2_carry__2[6]),
        .I1(douta[6]),
        .I2(m_axi_lite_ch1_rdata[7]),
        .I3(m_axi_lite_ch1_rdata[6]),
        .I4(rom_eof0),
        .I5(rd_check2_carry_i_18_n_0),
        .O(rd_check2_carry_i_9_n_0));
  (* ADDR_WIDTH_A = "8" *) 
  (* ADDR_WIDTH_B = "8" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "8" *) 
  (* BYTE_WRITE_WIDTH_B = "32" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "0" *) 
  (* ECC_BIT_RANGE = "[7:0]" *) 
  (* ECC_MODE = "0" *) 
  (* ECC_TYPE = "NONE" *) 
  (* IGNORE_INIT_SYNTH = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* MEMORY_INIT_FILE = "mipi_init_gen_data.mem" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "1" *) 
  (* MEMORY_SIZE = "8192" *) 
  (* MEMORY_TYPE = "0" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "1" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "256" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "distributed" *) 
  (* P_MIN_WIDTH_DATA = "32" *) 
  (* P_MIN_WIDTH_DATA_A = "32" *) 
  (* P_MIN_WIDTH_DATA_B = "32" *) 
  (* P_MIN_WIDTH_DATA_ECC = "32" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "32" *) 
  (* P_NUM_COLS_WRITE_A = "4" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "8" *) 
  (* P_WIDTH_ADDR_READ_B = "8" *) 
  (* P_WIDTH_ADDR_WRITE_A = "8" *) 
  (* P_WIDTH_ADDR_WRITE_B = "8" *) 
  (* P_WIDTH_COL_WRITE_A = "8" *) 
  (* P_WIDTH_COL_WRITE_B = "32" *) 
  (* RAM_DECOMP = "auto" *) 
  (* READ_DATA_WIDTH_A = "32" *) 
  (* READ_DATA_WIDTH_B = "32" *) 
  (* READ_LATENCY_A = "1" *) 
  (* READ_LATENCY_B = "1" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "1" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "32" *) 
  (* WRITE_DATA_WIDTH_B = "32" *) 
  (* WRITE_MODE_A = "1" *) 
  (* WRITE_MODE_B = "1" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "32" *) 
  (* rstb_loop_iter = "32" *) 
  mipi_init_gen_xpm_memory_base__parameterized2 xpm_memory_base_inst
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(s_axi_aclk),
        .clkb(1'b0),
        .dbiterra(NLW_xpm_memory_base_inst_dbiterra_UNCONNECTED),
        .dbiterrb(NLW_xpm_memory_base_inst_dbiterrb_UNCONNECTED),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_xpm_memory_base_inst_doutb_UNCONNECTED[31:0]),
        .ena(1'b1),
        .enb(1'b0),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b1),
        .regceb(1'b0),
        .rsta(\gen_rd_a.gen_rd_a_synth_template.gen_rf_narrow_reg.douta_reg_reg[31] ),
        .rstb(1'b0),
        .sbiterra(NLW_xpm_memory_base_inst_sbiterra_UNCONNECTED),
        .sbiterrb(NLW_xpm_memory_base_inst_sbiterrb_UNCONNECTED),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
