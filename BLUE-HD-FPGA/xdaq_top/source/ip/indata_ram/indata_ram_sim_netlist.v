// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
// Date        : Fri Jan 16 15:13:06 2026
// Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top indata_ram -prefix
//               indata_ram_ indata_ram_sim_netlist.v
// Design      : indata_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "indata_ram,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.2" *) 
(* NotValidForBitStream *)
module indata_ram
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    rstb,
    enb,
    addrb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [23:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [7:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [23:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [7:0]addra;
  wire [7:0]addrb;
  wire clka;
  wire clkb;
  wire [23:0]dina;
  wire [23:0]doutb;
  wire ena;
  wire enb;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [23:0]NLW_U0_douta_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [23:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
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
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.5419 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "indata_ram.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "24" *) 
  (* C_READ_WIDTH_B = "24" *) 
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
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "24" *) 
  (* C_WRITE_WIDTH_B = "24" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  indata_ram_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[23:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[23:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 26992)
`pragma protect data_block
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
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
