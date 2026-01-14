// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.2 (win64) Build 6060944 Thu Mar 06 19:10:01 MST 2025
// Date        : Mon Jun  2 13:07:29 2025
// Host        : WS-DRAKE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top roic_data_bmem -prefix
//               roic_data_bmem_ roic_data_bmem_sim_netlist.v
// Design      : roic_data_bmem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "roic_data_bmem,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.2" *) 
(* NotValidForBitStream *)
module roic_data_bmem
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]doutb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "1" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "1" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.68295 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "roic_data_bmem.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  roic_data_bmem_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[31:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Vo/CdCry+4XqWyOAGIjJkQxiiFmxV56JJA9+DRAoA73w3PX/VB2Q5+hs51IJHJDQpfz8b+RkWiDc
wzwfz369ViGuppNv4dXlNznLJnJnC7EiskELf02DdJnWWoSZpu+OHK3OSBEQ/zsd9Jo2Fo1W/rmW
MGZUU/6yH18wHS4h1Ks=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
0wk1VmWYpT58dDId4XJkh8egEYIlbnZZOGeyGy5kRkRnXHqDOWQ+oylx90YDv9xCL7Hk4eMKPCF2
m4MOF7S4hVPD0/sWpEA8P8FAe8xJ87dKWSVL4jsUlHtRrOJgD7GALPmxmP7Si18wN1nhP/Em10F8
/dLfzgj1xP3Zf5H9fEp2GcwX2TuABOVnDWshUVbBokKz/60SbCSepujD00YwhBntPBKLjT63NlmT
RTSjuWX0rpXlxj6VOXIYSdG7RSLBcpnJy64tUezG1b35R+o5DxZXCqjet77d6quzpY0zZZt9Ulht
JmIAuDRf34NavmVAN7Mtd0cnmfoh7ogGicjKvQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
F/wTwmHmqba+ezt7048nG7m9PFcFX8+e1ugB8tNrzJbpZSuJRRd6CQfWgrFM6z3Lt+Xnv27fU91W
7UPwQzlK1jnTliJBxoAq1fE2EHH6Meu6+HJfRVpgJ7fg13fbfZIfHUvNXIsh98f9heu0jLNI6weE
/vvav4FblngbAAYUgd0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PMW8encF5gzdNpDYeC/r8ImvAQhXqmTUs6jwRDNtn48A6Ujylle4R1SCnyZkY+FJKwRrbwQYM5xZ
q0WAIHjuqQu9pP4jSz77dIgvrGNt/Jq52Ez+a8pAE/wAoX0RiMsIeHFJYKfkmGjaCqeRtGDmk3BV
9+dy4HcmsDt9Uh4xvFjdpggdkLbiE5tjHgzwTlr5njpIBBM3Mc6IQE9aae7pv8wKGZh0ty66qFAn
4S9+ebhRZxOoWu/Dy19sbR1RkcJRag8MPJw9oRctKzduV4AF5TwH1waH32OTyX1p1716Vo25yin9
+rz315JRpqTLSkZJDH0UVGxiqyJ73W6GTzGjvQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Y9dtFDZe/9fosnZUVejOdy+XS5PuLJ0yXHKg9fuNlibvaa70MDgcUmFI1aUQMIXkh/nyrlAYhEOw
ZYwLUiCgGX9gv4rJdGQtx6W5YHqEqKc6ojSRxBAaLdRpzdYB0DpW8oIbjnXFf7e1yx+LS0ZeRvga
Fh2UzEgqmwMNRgmnJM4j2rvUiRrhCjtiaXlkc9pB80ojbMz6j5O0jOYRDx8scLtA39zyl6jlHXkZ
0NhLqQuJbbWjmec6JRtGnaM5QouDbk+MW/fNkDY31kIbegNsEOLQpMNJ83TJH5kTnsHlY9l+0XJ4
tN8eHqmH3rYC3OGyXe7Fa8ZFq6ms3GQKGeMfhA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cxjMtMSESPI2+yc8BX2YuZW6C3RMyKfgTvyd4r8Gx1wWxH8i+oZbwjGEFrD70y8NIz21xljoxFEk
JmtYWVokBQDW3gKLSJSvxmzp0T6nMPTGtNrpUDalO3XojGO7PY5zxMgZP7ntyQop50FaRZncfqcN
5w5hYNWywr3sHm14iUZQvYkjfpfI/X0gHmaRZTUBwZnVc3yZYPKpIi/5HdJ0+dh3SqEErHU3sVTy
bnAyZkhEZ9ZbLjELJ9twQdIRF4MiHKefy97m/3WdDg2YAmsDhwVJqEDSQRrhJ1qxyCHTjvccibuz
u7FvVmHfh6hk1tUEJgfJBY2OFz8zJE//prc5iA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ez5C57juA3+sjvTiTimQXL3ngWJqcGkQ5hv2jVBj+qRGyMllvIQOBQlpQ+bYLkOWnTv/S8+6PSxT
jUx6SYCJfbiumC5jC3z/QW4c0ZC4XzIFAgVdN4am8yXHRSI8ApBLYsSyfpVsI2zGpgVek+1s684p
Gx2VLV1Wwf3TcgyHHu6+yizJ+IJrkFjBOqaNptlbq1bdEtVxRkNyJiuKh3hzbPmt386lGeCpCmeS
Ci/w6goqagrSZZ7CwRDpp6J+IHjwRIUheUuNWzxQKdW+FCjw9qNPCND4sELBajCtfBQzY23j6RZD
kUanS7/EEh2ctRvZ6ckx/Y0zFNJYqHo8Lc56aA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HJCYSjhpgL6sqdTzuctiBLPlx6fhwuFI2l891REPcV2cKYvrbMCYI17hADRbvcxNH4paQ5/fmqeb
rE9BqB08LRASMx7jlAdSCYKA99cNcVMsByGT1l32kX7+Gtt27iKAIwVTu34+moPXqCCM4c6jUBzB
+UAJGBtS2wc0k+kTtXp6dCXiyjYXC2UFEDt8w9CU1qb2TXkPpgxXcfR4skit7umjdS0NxiP88l7x
PvAeoTea8Nw3NyDr9766x8Q1W1rRkuRmL+1VM37vp+BJsf6MNpeE5FNpkrhdCjc0D3dtRQVsCStO
scOhLAnzS45HjTjy9siiiNpJhXtCEr+5PWuEXVj4OC+yevy5VFcClOy11RiGXUho3zn1YnCjvFUJ
HO4BCq9TThOthuOExIiymQlqo0juTKNFELWCzlCbbJMDntY4twIW1uyY76cuBTeqq0r6SuzbelbH
iF1J/Ai1WoG1NEn6/Ld8lGm+aTPi/mRUvBbdYq6Xx0I1hJ/lrwpbbvpZ

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
i2BfTRuoHRFB8ZXhJCQrSS5Kh/ofOKU6mrd8mOrx1SgmsHKu6td+g6cqGS2nIDZbr1QjP33k7Zjp
xKd5lImYtNz1lFR34XzdVY1YY4Mz0QRDBjsP/kAJr7DZAqZjrJAO3md/zSG8f5SaAh8iTo+EBM+6
afCMZ6ich+nq02odtxrZ5Uhzoa2vt9DW4DcnXj+tuoKWUoRKcWxCrh31TNiwS2b4E/El43/B29XG
FxzmoEh4GH3ZaiuU113Ld+/xkQRsMLFn1JubodEkM9sNeTHfppPAGwjUgCzk8/2hXirRJu/XaML9
VWT5S7x5yGlmti7sQnP9kzJJRUcjTTJzgE5KOQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FexSVDj1WIebhRipXI5Gh3YLSX845WpAldeuElSHB0huSoXz+Np2tkseCkkF2eCCt8CNhVExuuEr
7/KHUlFqvHa9DLpKIOLmNFWiy8Ay2iuzmmxyL/MPPn/teKD2VjFeD6ssY8l2BwKbCD73MswOuiCc
spGmyJ2i3k6JMBpL+zswzmIpKJ3j76vYQF+o5HgmDtaakOUGTD1nQNPMyZ1ZBD9AvAC9J3eY8qZS
1Wdw7OXuMZ5CZutq7JXBHnLE0i4Zgcf2nWCg+gKKgvBZXlGpEkhs30/caJ4SGThuIkRNEUsnHcfp
jA52TVN8H4BdzJH3hCTxAhB1e5lNWlKwQ+gYEw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Lu5hRxSLFQyLllOA9u5s1HixJJG7j3i4H09yHKiH8Dp26PhhohxwUADFKakrM7CdHL8s7BqigcX0
gERo4eIo8tMf2dBC9mu7P36rm9gCwpvvyiCA52BzF7pay+3P1pMoTC4HhwPNE6jjh2wytbNC11dG
Vy58tmmu3wmLHagXe6TbdJpcYT31yQaqmU4KGKa1xKkiI3FyGRm/MzXZcSfTCQjCiqGXQH1Lnapo
2W3GdrN+nv+SFjJe5j5+T3lxn/fmOusE1hz0LsLbVXEY8ARKrO1m0K91l+AQO9q+hPuF5pSAyHKv
VzZ6TlJOmIhHrqSknN1Au5CIrbyauNSDELtQiw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19952)
`pragma protect data_block
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
gDA=
`pragma protect end_protected
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
