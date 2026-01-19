// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
// Date        : Fri Jan 16 15:13:06 2026
// Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/source/ip/indata_ram/indata_ram_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27280)
`pragma protect data_block
x+BtrXF+Evc0taK+qgDHAuA2bdC1V8WFBE1jwniV5LIkFjl06uqRsoCY09Im/yGM4eQmUsJQoW/9
Ra2sew8OUkHPi7hfziNffxvmjNSSZvVdPs8Phz8tAyfUrkSl9Okx4DugLrMz+eDjxTOO1hHOqveb
alif8ASPpzS8EHZZ936M8slrozuqAybegIJgNr22pAbb2Aj1ZgWbQ/cXVRaga4dwQIvgTbWiXkCI
kZW7vbJqVi+W3zg75htb+LsM0rviVV84761dOYjbAi4+5lW/4iiM/pMsq5HNphVPsrV5O/B6Tm4t
9sAjE9ERqGRPh2A4LLdIvIFDSjJwxMqZ9YRas29uZ4aufKjKr+EvIvW3Gakg3lnr/CLrEIO8GJx/
gw4cNAp5IENTBNIQfUORwLxXfS5IlXrIYfpMXl46K8dTIyljjbRA7Ll5Mr6u56cBj9CYqQykmuTX
tgnuIwZHxJybjweCnIdXDGBgojCYpIPwPwvuwIMEBGy/eu2Jh1BdnDNA+jucHkhby4bOIcY1PJ0P
uFEJUUhuAzwXPs3VIOB1glYXg8j/RuU+S+cGazlRtS8pt0KlhLVAUD6OMVggOpZlCGYlGDrLtZJj
NK/UD5qg+IJTAPz/W6ehNV7d7e2CICRdG6LMDhYZ5et0S5CWzw+tKUfL2VQRfCoj3dczVadAjpO5
fwMcT44zYlrjV/aZyBI82mSVQha6iIdw6Zty/ZZdxa7jrN9daXzMeo0ONQzrXgwZNbwl+70OaTY3
ktN9bz56SoL/wKe0bVeT/y91/2OGs1XyKYMdCJDqWrl/2HjEI7OpU0xCD4O3ZUKsU5/yn0+7fd/I
xhURRrvaGhgh5/A6YccgBaHLon96zXN3ZruV9M5w17YWXDWjExH0H6XX2dpqPMwJoz0GAte8az4G
t/kJpPZUV27aU5TJlzGDw6hJap0g8bO9RrwxEUcx982sTfSV2j+WHLJk9mfA+zFNklRQ8vdfPDhV
FdpcO6gZ3KUTNut9ZfPPwzZ4lHgiRNmwfq3AuHXXagzQNbkNJCLk0UZXpwVzXVugxgArpGIGeskk
Q1QpsX5u6nYTt7EYWFuOd6ek4Wx7dO7zQXNGTPrRnMQuEoRyv9zzGtUYPZV6BCNdLWGOiCVmcIvS
YQ9bp0Vb8p5coWiA1GtPED1DopfwTgwxuZJkIYOV3uMSMAKoPfK7WUNZSeAYuOjB5JSE2WTQhZsI
AoIjvxr3QloMIyeTd7qy04c3JLQoA/cW8b672Fj9OZlIOefhk45Ts6JeboSDv/qP9uRKW2PHKLfd
K5gpIzXwRKIr+r9TfTnSuVA0wkY6ayJjQ0NRnwTL+DL0VoyCUOkT4y1x5cW6fq3IIgjas880tg4b
IL0QTgij0+nR84GCbxYF0WjFKnKSvgUe57PN3FSxdmf3ZhaI67qII84+z1+kqs+B4/xY03VZ9BET
olI/RuJo+ojmJrSz4bi1A7T6Htaxgk4WiYvALZa1e7+tiSJ/WMN0tPghi1nlKBlDvWujEw4ngW9t
lOfhgPd6T2yenRv8kB7K9MDZzaIgF7xaRxAzBJ2grvRx4bV9uJaSxk0QaDyPVexGxX5fUbbEmB/e
7/j7icC8bre4TxjEhMGdbyV4pJIvlNheCYCzbdwigiRS8Rp13Jl87Y/Zl6ojm+oDIzmeiixCcrdX
8sfIshOvy6EzVvEVJ1mGa1WEx/NKQuA2v77/l2HtYTd/Yq8iE2yw6NT6DvodyHP5Z12gbHrEjcPb
Wzla9H8hB5MEEgLFrBpRPdBRNuUkZ3H0h43GytHLvSmxWpbNwrn7EzsEq9y35eZGpO3rnTPS7Kwo
NXuQz+prWIIHuaepIMXJQtWpe6QcnbbaI8QJ4flZey4pjSHl1CMGb6PO8Mf3BqPZt2ys2kDMeR2f
B/ylAQQfAwJw7RpOy7leUnT+js04JjbuF3j1oDlXCZdjd+jtvM+gG3fuZ1rD9/K/ccLv18iMg/cl
hsgtMFYhCf+OziiHk82EF9xoEUnV3r1mi001Ah4khkrDYxDCD6gH6xEQSzAKTqC6V7p2KrX0JIDx
tVeRMjj7BiPRhTmc/4Ay9sJQYVxvusyYWVJABlof6IjFG9dYf745wxkyYl/ZsFfPqMKhK4pWSs9F
/LAux8I6RafqWwrbOyDHMcEwcGLzpCcJ49wxpHPGYoZVM2ky56F5xCoUQUPJafWvlzt9k6e/+7IH
TZd2NKHh1XFYp1P5fRdQZoZx9jZuUq9+9JAmbZb3oalsTtz9YTs/txM1cOz/nI+po9enyC0ii64q
gulxM06FTIPHWq22Nx8I3hAlY+DY0AwNXkZ0cCvxos7P8uwHkptEAl5KMZbgcwAbLJztQdBPND9S
0ZbeDcOvQy27FIBDA+xANu6s2tgZEk+UNd/8X4tHKXzq+8HDqfevKmARfY2EWeeGyVvQd394upg2
hGeUC10Nh9oMqwPxOfttSQOz1BzbaVPYjLSXyHFwZO+rlT6ajiRBlP03bEvZWmZx7vzRh4wQsLLP
A0UVCUlP+V7K6bAYkHRpRxQnV2Pf6SHgeobnMErv70Dp22suAORGgHAA22ohvJSaT+X2iig5KHbp
H8YDOqZbaJkDHPPXRKksNunC+n7iMdYM0QHmgjbm/sEU/r++BI04Y+T5lk/rxNOYhxF2hEmV4sn+
bGw7EqN63X+Dbcsub7Y53CiLtg6iZm7KbeuzhmgAPiw0QunBhgzuDxCjw2bzS4Zqx45a9TxmiH32
4GA6J2WFcDkjmBJWwyMdDs7Dgf/3RS1VWHBrp+/VsqBmaui86y7QAEtkbTNteyKm9BITo1O7XJUL
g9UbJV4vV0ldx8Obdgq6rAheF55MPMYR4T1JwT+pN0lL8oJSFZSt3vb73CkJp+eKa/QUqkGeuntQ
Y9Cf9wCHdmNOW0J6IaYR+8khgZxx0cFeBBGgt7ZjsvI/hjt6qCXXGLsPe8gLso86MAnh/X4I6GUm
x4HHDqyfBQyHGdwH9fODCOy6sBHGk/De525Nydb1UqDmuw3pHKR50bSvDSx/7UEaxtBv1lcFTSou
AMPybhBchcRL5aUE9QdATvaSDc1pgYnBv4UcJR8FjFztHNT59ptZjpZ5AMPBz2E5ILO7x8+BO5X4
qWhG4iJzN5u511HRm0+qN1AaGhZKHGKJKziBwa5LpraFi9wGfbeL0AULi/sReCLfDGEf6r2+LHLJ
0ZRYoEbxXxY8kzFDNfsPNSlC+RCFBuuqtjNgB5q0GGtTdRwH2M8TJgQMbr6ckc4Np9hDh7DXfmjc
0SnLWbyIOaN646Jfc7YQD29drPP24gDPfAKKUcCZ++Pn1TVP9+KdkKGq3t4CLZebTHUwAPy6Xo5B
wVhKTJJtzBC/nC8Ymy0fGT1+bQN+FQLPaOgKizb5WuRXxgcrNgx2/7nTKqDB8VcaMAeqXFYPyLMO
BB2GpCngBu+I0m0MzIWOgtzC6q95Pk2OU/Lc2f2iTVLLe9FC2bsmQHORyJT0tm6j6vS+VGEcP0Zb
/zR9EUkmdGNXXzU0ZPQPpuLYVO/MHzVEYZb8qAKfrgao1fCkPcgccNYImM6rzzFj9WHhF+df4QdY
ynCaF6K2X1PxFIkA9koiyTzIDfoOSXt9KID+jeAc+TPK5QKd8QzNU+oQJ54y0iIAt2Rp1GvpJvJf
X8aqbJVVNlEAHgGm8480suJh9g4zjSnCi+Qw51ZYAYuir5ORpM/I8UESSrcdIuyhcVE7PpUueRtX
63YGGsNSCIn1+XPIVfDKk37wZSCQOkxSQyAKcyT2ylYmi0LIRqZiAzCQ4a4PZNL2freQDbwEamrk
RPfSVXqsZvv6lFZdgi5CWAdWttgMLeLJrprAfsLiRYgEAEmX/ouO4XLdufsm9VHPMFTwQfe8AqYr
hzCh8arMF8xsVxsqSK8Z/aJAsDUOH6oQR0Jefv+uO6WlArYNIqWg1S7sCt252k6f7fPVOu6rjEFU
UIKH/QHLnY+X9sFooFOaPwf2F9DDTxKsA0nyyw0juQncxWyF+i8BKCz5V9rLYQyhMqovSft01m5q
CAytdirw5G01K5DKyhYhMCRkqshRkq+ZMbd0X7lpBNTeUhzoiAQlGtE2ybENGuMfeOAMIA8LBNBK
2449kxPlnJ+az00Ww5Hf4I2+Y+Se6fZdbH33FIJeSf9OzL0Cuyk3EP+Uqb6m434eFxuOAfTJj1w6
bl/ZsebQH2tiS7jY/vQ45yYYwPA2kudaeM/XoKMYm6MOMBmV7QTcnRlgnWR9Ed2CaClz7crOK54d
g7ZzZP8IGZOoGz7EAUJZ/NMavaAMvDsdgVV8YcbT4hHUvYgjSuudktMoIS5b+SxeBmh90MaUgqMT
3e+jfUSMIbhaiLwPtYXfATzAYo7mBIfhxnGO3uzcbWLkEH/k8vvU4u3xBxuThnENN5zcSV1ojJmH
SxnvQMqMHlG3R74W+hLdUx2BOM5XndDqaNkzd+8JE5ujpIE/WRbwLtodkH2hx716Dq6ncGGkrera
age/+K5fDrSRxTsF0n3rwTdeVuqwDxz4/BaaX9Wg/auJ+7wOZWiSCOEHeHse1A44nSi5664eYmZV
/ZiHYGWccRQbFHHtu/D1oijYUkBmD7ie9fpJ/d/pJVnYo0nySnGu/zkLQCL3jodvbJ47NQTCQN0V
wubGGDSWO+F10FzfU69RuLc4TyF5Q6wFCpywW/2tw8J96SSWsd1TXyA8O52dF25DpuX1867jtHiz
4OxEgLiDW76tXZjRoeHsinvZ6uG1bCSV4rTwdBBXsdFS8n5QwdrBf5QWwFP5SIKwS+a9JDjLRClK
Cc9Oxt5j7zfcGwebphMyQpS9sp0Ty/4zPbuKkP5ZXfuXmvhxjb0Qcmt2g/Ts6TcER81SBLW/vSQ1
g81lUiWwZfry7dIJ3mLkJLFEZT8ZQtRuOtU0+MuIHpviEOIXLNxM7Zh7GnYu1tOJiWlw1lz+G4+r
j+KF3KuLRtbr2/iLfga6vPludLD2zRV8Svopme7qr1pZKmgKZ8pfthbapz1/Qb0ziol0c+OJy3Xo
d4xnN2+qzOQQXxZGRWle09a6qIVRBTYH5lOlZ6g49mQyzd0cvjR9u52zB/OBtw9ZUm+VsqyToTLx
IRFwDli/n8bA8ASp6q101Q5n0FXeF9wR/Lxx2Ud7v3Nr6HgjZhu1FAlHER76jOYImxAI8F6Vx8IF
TswU/++6NiBrR4YR7Ns0gv7u0yscxB2M92f7a2Cda3xy5hO3qjS0oS8vZtm3oHMtkCunRRqKfJX7
RN4c9KqHPUkKlbs7rrb/P9juCDyD8sQ/Ikkl0Gq82K01vCgNydT3uZPEmqNuKCski3oiKzZ2lSXL
Lxhdg9JPMkrmZrNPcKaxeqmSaLX0xEZvcLLpUWSRCqrq89uCU/J0SFK9tcL7HYhbYLf4TUFOlcHw
K1J8LazILnGdemVtrr8UYTCXrJL+0iKDfGeyILLEgM2JBw0dUhW9lz/bR5So9KfTGbYeESWHW+Ju
uLyB1Kwmz8h5SP/PjAn1+Rh0MfpZuTR+P10wVVQkf93xA7mQWFibIOzrWq1x8dotv8sEOQ/qcUcR
pSkg64cXAF7MuHxv08YPKLo7wXOvIzD8U2kS/AHqFYJazrijtdN0k+ZXTCnb4ae8r/ABBPAY6FUQ
rc9b0kYFe9CNPPSpw7+CR+3WruPdN3xMTcox8nUsOit7uY/Su202Q4sCrLMyt94nYqA4UZQAd6AO
315budqFcwFXEbYN1yAtPTWR0iPxIId/xH+/UGOvgkkaUyvsDu06wuKtMgvLvqPf4J+K6JaX4UaU
vrBsuizy9zjT18TN4lBBbO05veJPelr1aXibg2lFemI+fYASOLOEVg6HvFDGJquXs7MjC6C53KGA
k8vvn09Tfd5o/v77qLwTSe0esvkogL20Po5QZ29WwSyiVtX1ikfYp4V+BgzKYpY+sxM30qKMBAB8
G9olpnJmxEyx1N0PTppEpRZLlNBrjn0mc1kOBC5IPiSsxZTJ0R9a/edKq5O1ReBcq5m+r16hGNtl
xAX/u8KgaJ3HKTYhGb72XJGqC5Sn1Ref8Fit3m+Je2Y2pvsYjoYSIu5tY2waCHrDg3DdWz2vASkp
hRHbdTr16Z23s/7TH6vnVi+NMKqXd1D9VR9t+cuBZJxByvM3+R1sKj1c9vZFQOi/R4lhO/iuxoDd
CZPMrqcocO5PpOISnZpHsBDxO7OHk8YxqtiSI1a6bPvxs8C44rMlpq9vxz7d21aDFVkkZmV+z456
BQ2exC1fZMimPV2MfiXtngMynHbjm+FriYvGBj84QjcBuod2Bbf3vIfWhrm/885XC3GRnYnuVem9
Za+EhY6vqT71IZD3FO7KjtdH0n8ni/PdLz3xk6uslgdccKzPvXv45PCUx6BgVoJYe4L7Fcv1dbni
j9CqR2RbLAK6JzzzXjT8e0ohQQF3JEBquvCjLv/Ls3vgFIMuivPax1l9kzMSHflJAhxM9egfFB/C
v8Qrppq2lk/2xBT5B3KabyOWepfn6F9R5f0lSPlHD3Rq9UlLgWqP1zesspCakhFqFr9anWJkpHQ4
RsSQh9sSeT66nOZR1mGrjW7wb+5+q1K4zd+HKD9+P8VMye462Uub5aeau3Lo4PjYtLmNQMAxzHz5
FHM8OeX/2lk0VREXNy/WTXYKWXeQuiAbywprwMHuGo1E35rXT7do443Aa2U+I4ZLKYfVKa1Gd73G
WLEk3txHhgoevh9KdDrrxGj8x9Ea0t9p1PSVa0kmWmL39ba1c8tnSgLGDDi68XlSm//u0M5GV3MN
GzUdvgTwsVXWbg7UC4z709juX1dMYO183BA012eXoOBf927eJUTWRy9C6WLRIMUgB1D+7yS+w4eF
pbwD4yLANJeFhWPnxkaDzLjtyxgt2L1UJzNPZEGxdFyAzMSZLzPBTw0Nq3SQ03gusSD1/ugS2J3C
0FcfruMzv9cKCFa7Mehj0G6JBcKtDm9XHX5e8k7h9ebkqkNgierh3Unym4xAvLW2o8Ee695gWkBL
r21DagYFrklHXTAYXd4TaAPubPiqXSE0MynHsxTExZAm90vG5GMVeb4cjnfEpyUHaE0UVmZrgU3L
48WKaotmbZVX0BBYAyXXHWa/mAxHjEuIMUTShBJbYwMrbQcOG2c98qiCOWcaKcWOFZ4SqKvf7k0X
fHhMKSdKTJVI6OFUk5xuvWB06rozKKBY6f3eNV/JCdOJ3imCrNCfRng+2xk/mWvfNeUF4pAUv84r
h9WKu81AFR9pxdd3aDgCiC8MTyevpp6/o30ng6pnb2GqPGiPYEcu56fWethOCnlx3dIDUeO0bO0A
4aoIHHjpSjp7JSRMRYjBpLl1Vb73QkzgOB58UO/RzK7Cfgi0/cSOvNTcBiiWLKVQe82N953Hwf7Q
0HI1JrHFru7yMcB4aE7E8ueRD/7Mvu884cYsf3PxEjosQSpwBwzlrZyPau3Dn95AS5UT80FauQWz
BxntX/c9uTEc9JHZLe9QHO4KeKkPzXdPAPZ72UtnT5EFaaTRmUREUFVjgvg6yKjjYMuSpIfhu7XY
YdxBaJNwJHge4G8udQl1zBLr+qIoPL53IYyrtu0UUu1w2nxyrjxyQ7qDEa5CjCPmOLS2Qe/LzjGD
9vkMmLJsF792GC162gmD7MfG5Mx15XEUfXTd9Eq8nk4eKmBaPAPzwBj4LFtUcSj4Qo1BMhXZZRsv
p/zTb7ohpND0TBuTm0toVr2ULG9zOLyd1NjOIwpkzPHWuynz05f1sRqkIZ5DLIsC4ZngXk08ZOlt
XevI4xKsBZnBaPtjVc7CtjsgO94qk+sU8T8qIuelshWk4cfkdNDf3yN00SAvokUMxABKNckp6uSd
gilM5D/Qo8H8FUZGohICxJmRIpvlQ38hs4frmD/z0ydcW3XMdv6Q5YBHD/R970pJAXtof6DEdCD0
KtYm+usb1xyLdDfzbuZs3d1/tRr+bUY8T9EE9svel+KQZQmjXaGmBmxHJkwtEMRqb/VlKNB57L3A
3hD9UYMAF/c8jJMyXcWtKlOLaHoXqfmO0biYnKk27BJsS7ow9Cx2sxOUHMp/BQoQ9imBWNRZ58wY
j05s1eCDjygEk6WE7hVkW8YV5Sg0B2WRB8uBBOM6Cl4cIuKdZ360eovXstD9sem/J9xaf60LipW8
Zlt2l+TatTJ8CCM4FINaxrbW4N5KVgC9WHrtcy8pKxrwi2D6GYo1+WXJEF5Q/BT2UErQvuB4B0NT
1LDT16VIzDZam7qQcTIdKQhcSRj7NC0o3EXpWxUWbVjt8PBSmq9qyS1GRxXB/Z23hmaL4T6tWrdC
R0VZKaAe7w0gi0rv9p45n3QQv7WLreneUvp60TILwgELvNdrDq6gAvMxwXW3/wHwzO69y8K2v4EK
GpBXmXYReagPb2lHHANcTIIKI6UY4m4x2MBxWZwR2f778Gq4nV5RyZ0vEwxtdiA4ioq0n9p50KhC
jtYqacQP27zxpuzjnNEOSULd2sOkRHP8cVZ4Vp7y59gW5V4GAjafPnRpE46YZLPrKku1LROXw4Pz
K+41exApT2hHlWtO34152jdTP9VjnDOJ1/a+3CA0X0+Knh8zEUFPlH+jCJuKYFg9sQVaW08KtRmw
0FcTSb7AVLrtsYabVz6iLN6VA+sHp/eQ+w4pK7Zm+HOmnMF87RBz3dYzRoYwLNGCIe1p6JXqAejH
Wa0T/r8gppvL8Xj9NC/HzJ1jh2bt2W/S24f3Paog+ROrM4OJFquJ5wLUlc/qpfbtL5P1dylRRupC
oe1QKgExrJz0r/gzDwF+pHC2zTTQoS0hrMFFSVwx+3fhHLDTZetgp5/INAf2Rw5NAt/LhHGxYs74
p0R/e6lzOF02SZ5QRKnlkoZvCO1IbWObSMr7USyNtS6DzW9pNxFLCUYtb2vSdyVsiWsIoaeYrQjv
HXN/WuS/45bEQlaC9EOBfkkbJBVdDrtuf57miEIJk2xsdvA2d5J0mwI0ppbU34tFCTCxD14inNYC
pUeWXJeoybNqoGlMJg2Z7cIk71utNsQ7v3rFEkmw007dw+34r96HNwe1om3i23wmDE79HGhEII1u
n4K30lLXPjF0NT8pa+xNxvRiaURdY3aUbxGGgdEyAedAt7I6FDiXmszdduCULB5d/RpOEmU9tQtn
mf3vEbbJoHKJhJxtNVemCc+omSFSsT3/Ard9uRID6acMkWQgbdFTPJ/GlrcyV8LJrXGRkY+F4yWi
uDFWTbbFNORVkz5YkYsFbj1lhcPqpoTWUWxwQIjkegG51nqJBeVlnsDTaNWWhPH1wwFl1uRIFVgT
Jkhvo1uaALsl2Rpo2bQZPeAoXIPgX31G5fd1WpvgIQiUvxDcB+LbNHU03T9R/lXjfY3ARmiEFol2
yDP5y7zzoiJw6ut13Z9rQgNyyTPcU+37Znql2gHEnkAncBVbkaz0AHbNqOVDcvkGyuADI+4RWCPR
X1lg0XINXVKAHUbhls2KOX2rffbV6HJ2Jt4qm0yEHW1oFLOYPskq5QI5V1WzK9NKWFxtjqB2ng+X
wFEErmdU+ojsrV0UwjqspQtsRyUv4EDgr6Yc8Pj+IRZVtmKfVZx+uH1yjYxjqe8/XLtHv0b3NzH5
mspS+G2gZae7MHcJDBGE/xJEgp++5SzHRFg7XaM3QaL1oW/314fyftvQyJRLdGrnxR9DGPS8Z9A4
gb5ZIDHUc4X+GCTNclKs3IU0alCQpv2uPl4jV3lYs5JUOU/YYedL75Xg5aDbbpB8ylPuRhQK12uT
fXz66W5kI6RdpgXrxIcqoTc8xyixq90S1KB6MG9S5J3Ohm28UrCQg1S+wQCqyQphAV0SVj68pTNE
su9pa+jDL1q+65RWluUaBiM8Xtnmzp8oN/2MJeGsyE8zSwUBHyxSgqymAOC2gVGnx4vDIy6rcPMU
EtDcTjbqpVXmg3SLaWitveWPMXyxfiV05W41CAYUlhayjMA/A+biZ7AzUED6csjKC74rWW2FAXOg
Paz+e4TLiiJ0085ejbkolTp5eop7NzIt8AJxId2GqfsJ+/4vbzNEJHu2Qtoesh52qCXg2oyzOjO4
8lSBBS0Goq37NGTsdrvSZeAwiP0RKMWttesRDyGO94MikTZLfnoRR86GfzsyXXGK0b9+1lrE71+t
KJ5Q6NY8pwvlv1QHSaMqUsmd4qjM4GErU2psx4sXdiL/w3HCuToEVZZq2jF7THa8mHeZN8xlXIHI
yJ+ZXKmx4UjAxRqEykZVE9g7nbE1uWOXpH0uc06anF6SWpGaMWBycLkZDLq8jPWiqTNDaG2iBJ4A
pahudLkHh4j2ZS8SPMMRP0jQshFoQqjbuT5zpYmNjmharyYaGfxoZNlRsfO8QNL5JQR9z1ygWt9/
mCtKBNz+IdRNLTC9LmPjssVetCExNgdFtI9WD8nFPR+AhUQvbjGYcf+4lcLLcXcGFImcVJwUKqmx
PdX0QJZkr8NrlYsoSTKjXfJQycJ4UiIOCmJxs4+LMVZoDdzjmehJJIO6TnY9dGZ0/XnTrnuNB9dT
38ee59dbRYObPpIC2QztOr105km/7LYhqw9OAWykpa78xuukoNt/WhKWimffWUwJsohZJwaJpMmq
Qa88ZNwSClbccFPRnbexQuuZ6y9B1vmpQHbRNh5kJa5lUXvr0uKLvy7WEfuCcirRGJ2GFHiEEG9/
KJoW80BI+MPsQM6HLU+AqqfSspiYH9Z70LA37ixJyeN0+kR0YCJAnzJ5SOFJgHPVdV3uarXRBynK
zviB6mcIdZziDw8w4C/4nIRcWm75LHtnvDXN7h5CN+mTYuiAlsDvqPEfuQuwTPfdFzdUeLKPtOIT
W6U3w+IlYRtiDvf3fWWYQgCagTe2fW9+MF3c0oWI8maYkiX030GqMdBPaCboEeZ8JZ8KAP1cPuvC
0Z8epjMK/vJrzEMd9bZqgV49ckY2D0WN7/Klz9KvY3/mc6+Ck1GHwtH8r2f/I/QJyUicekuom8Nu
x4TJB5OWu7j9xjAqgMzWakwG51nOSTQ6SlsgDVgl0KwRcbNJG7s3WipVLdpihAXCxCBvAgfF9wjH
BHF9baJGsY6jHLh05m3FN3WPbsyLfPzwBD/Kgu+LQpBs6fRP7LdgHuk2uOVGJz1Gq23EEYAO5x7v
GNfHGbsoqIw0hJktjkp+mdgUoNF4cizioXZ3bnojlVJQCLJajCU/On5HyBBucqsZ0KABSScM896P
zRw880XMOboM5z1cQltazSTzFmwmFEPe8SoMRz5+OlUtjseYy24ah0Dc/tdstJdpGGY8PSxRC4Wi
b5Xc01GglIqIJ2GKq+UhFNNlvNTRYr60xrsL9Ua4QNkYbdBb/ECsnJ9h+YCRCXFFMtYSGUiq0Qqr
VaZU9p0fNneLESd9aqTzso1qBWdKbjLmL1u4YXRJ1nXcoB22xz4zkSPfLe8BHInvrYHjttNlzv+x
looZ96RoLDMN0rYQS0K7pZmayLk9tL2nEsjnBxhRr5GN90/9CylasaSi3bJom5HuQiu7KLRNjF08
T2/UOQ86oCBHJBYqwcFe37Cj+3rm54RFEMHpWEhE3/+M+rKy2XaCvnFjR/rFGaKJskP/7eBSlMKX
O7oeztayVeKirxoOIGx3vDWP6Ugk9RnaIgFY3tiR1trcCPcYfNhZGJ7FOuixHT1mqYQUDzXiPJ/o
XTN4h4p+04RV8259k/lBLZ4craTiWenT5MP75Hz2UbpFM0SIjUp+1hYNUdukPgyN1cF3+vAS2atY
Lmb6eEscjoYUVLUlrnFeH8E/QWS/mUk1hKPleAd+NI00LwBv/2Gdog3AROteP4CnrWSCDmcZ8DOY
cu9OvHuA3ydBP8IMQysBXOytnqD2yjr/xDAm2miTwlajWnXg6OmQRK+SxyeG/eQIqi9EfUHvkb08
SSp10QB+/VyFIFlqcZngsVh3/781kmSquL9KEgV/yy7SJTvx+Ew27PV4cCKTBp+Fho2PVKU8BJCg
kdXQQMJeDzLtnRnL87RH1HywH/r+Q4ee849NvvJQ8gc08KAG6CH8r586k5eLizhU+5dLNB0bEMPK
O4wbydWYFNabJxv8d7FiEiJq5y5+PlJcYWOyI2/CyZgHZMgozDqf9qmjINfb2mymBblqK6EwCGQG
ostBlliLvOEJh2/bHRYjfU7FtJ8pHg2MLkdH5qdfnCyM6s6tTCtzqbpB6Z0Vnqo6Lt5UxL3SnjtX
GlzG78XbeNPIOKqdUCbPfcMmPytyzC90DiJ4PIXg6nUA0oWedvrC/ysPn9Ful8LUuKqPfN8idH+w
nj+JeEww5Uow6Q0tF0WT2et6/paJUpuV1HmJYnQahqLLcMWJas5fgzunSTZa8Ttx/65WNbHqisd/
UBl3QqJrmhMQxfHv6RX45FPW7dOygzzuIAX2+lC5Xa4T7XYDdFjkKdcyCfZhXHKyZZcc9nTk7yEN
yR0LUIyVCvepAVU+Cc91EcdWfyP6c08OakgtspCBPvp2X4NiLNxMaPRO+THqP2ptADAon30idCJH
dS2iOuUHFTxIevXC6jBFnlLpE+9DVfg4f51NzA76PTAkJbcAl7/b/i1ZMmBEJGSSurHEUAHktwdX
9OmrctpVRwn5kYwnFi0nZwKD0ed0v53wRGJOQD1H656a7c6ltYx0Q5fS29Hw5z526VfdSx2pmf2U
XoZdLuRF8ye+DL9bGgKmP3WhQ2BaQTttovVWgAotcRv2jCh2JpBd3hPPcqFQChto3bxX0u1gnihY
ZpGURwLNjQKux9e0yZVsC8CHU8RonZJfvE0JRtmugIK46S/zDtujNWm5pP3W2jwTWXJtjEs8bTM7
FV+aidyNj/k+LGDM5by1qUZHVh61+3gz0M8Rtyk+iVp+BE8Ouc+pitm3isvzecErRlwHoMJ8ripJ
MZhvyIbmRDang4mKsh11VH9Jytzezd8qTe3kgFCZ4CslQyeLZkq3p2h/rfr/cdVc9AD+Oxch9Lk6
HYV2EBpV2U7N5fv8abeUanjUTDjqzPeYj/wGbVFylpdX4+sxnjK1VB2Ufio19E9nG50bsZkF4ZAz
bJBG/DhK2VYHEiwrGdPDNOm+FuREFTkrYDjVer9uxHOEr1+81555xA+XzfFWJb7ePrMm7MQIXMKf
TbQ9m8rFRWl4zQITKINxXkT5glCWrxoOVxXMrXI7pHOinHHcky2ufno2Z8gGbU+kRsBKGcOCOjqq
TNE18IvdTYWRrrRuUHCO6akdckdqvB9KVQAqnRpWtvVak+DYbZW1axUG32O4AI06HWhh6vc8oQbK
BL58qNMNLOlbkNxOpI5tZFy4kpCEh6AWfut0svbYTCaRAoPWaiMw4lztbvbuo3w+xHl5EprNk8eW
tggeAJovnBE6c6FOa3GAR0cb15MqyXaxTRy8/o4D9tBS4ptkCzGIPTGhJ9OUm8OzPaVLPTV5V1uN
jOlJw3dgycpIR7S6p8oN3B63XK8/ckjniny4SuVKiEkCZp24ARRFfgftJyV3do3J2OCQFKi3VMbj
3XADeaSqjIl9MJYzIitV85VCQymJf/dUb+xcX2nTmdHQdufQOzfZozXi2FlW+VqgVvpNTKiPwAyD
nYn0+UQp24Pvv1FueFWjVayd0NOeDyVqoUurisuQ5oFJrzRHO5XZddC1mvyWP/dlt1/qUSmcd39K
QOQHdPjPzvgVxBHauVmbghXtpc7cQ5S9wkmWALeQ4BPu/1zhH+wAiE1R1nA7jaGahnj/9MFVR0DV
7MHcSsKDm7/ES4XudQmS9N+Qdhx13ZadtlVGQ6ZVWTPYog8IBDNvetG7YUruzcHgxovkRTt2a9f1
IJuIrGSXhVVdUIBJCDG+cjD0E/9D5SjcebxqgJbV06TJrDJXOocKR6qGHrmSKRtMpf9WNaItmy0f
SBUVBiNWnT6rJ1HDIN5uutkneMwqvlgNaP9Obw0G5SbTDdSVJwajeqoWt5jYpvXvtQoX10UzZI8P
t+w610JZueeAOGQwXpQhxlvu6ppUchcEwZYLmbBLvd/j63pgz8PM7hD2nU9O6/qXKixSC9YTRQcu
fu27aK2bzV053oIhWu9w1A02lxeP0A5qbovEH2qHC8K1P/uNAM8c5dSXIuNFss3M9q0rDwoDUYbY
147hAFTZNqcacaUlsqu8uXFpuIKRv6Zrhx1R2KYCCPIwjQbseYLnp8frKXd29+5psxiA/CB7oF32
ZpVD948kOQ19gPGIhVo4SyY6llz7xd5AADrY7sAXUbsFZSozwUTE8RwZLMHLlKFb4QsA3pghYn0e
arogpZ8umqO60GIM3QFVG//xOvFDapQ2Dol1jRKdFxrNOzN/1o3OQiub1wlcxWko4ngEkCfn6dpI
gVuwazIRPslbsxZluh/Jfm8cstIPQErgBofgOJvEpJ0WWE+5v+qmXZOwVpxxaZxJal15My7qMCnF
SJvm3B06RrS9yfcJDbo9M8fetkbWKbN499NNXthM5NMP6ayW9VyBODz321fG4KPcX91QtYusRhaZ
McIjE5KD//3N3BpYwWIR1r6piPF+cv2Jkdx53Obj1EFJtBGYfYxW6rZ9zPRqJX7KPZPmivQTev5M
hQ3nuZMQweYg2s1WtssFOOkSccaWFVsNcViL3dtLsb8V+Cr2EHFRRhpVCGdRET8RRUrJu92IcH+8
f+lNauD61ui3Ot6Q1tRp8PsBD6ZzLxN0grGGNqwMEKaBkbjuRnKDY9rdUM+wPVhvcQ6bMWrhFo63
NBQOGuOCjvvQQ61xDATuoNSh39uSUP5shmY3/VP4uHv8AJ2xA3v+8nvU6pJtqvEalRgHLIdw44rZ
/mWBAbrVLcAA3nfd49ORtAK+TfWZI0ud2GWUx21L8e8IJOb++j0UlDKTfudGfc4Ry7C/V0jEJ9C6
mxbnGip5S5QDazXqHUYe2wrvRz1Un9Wf/bwf8sAzMi+6uPn0zteDXSRu3ymNRjCZX96nHJt3FsGt
uif9L1k5VdkWtW6Wx5Rx0nPg1YMO13IqKSHN6tt33c0XCds2/HBqa3QQgZI08vqsb7GBvImIfW0x
d5dHtC4wVOYzKugigdImzJqC77KCu38XORqhGxXCOXgiNmMdyBlYXklDFU5D0cCDObyYYe6cWtf4
4l7Z8KFi5W3sfL8JaJ1xdBaCzqs1A65oxYBNjI4mmMk2VegJOjCpOTvPP50jrRGJnVrNKvZzCyEG
0QwDlyE5KitH2aqaAqU2wu2FwUEEZXdDEwI4EdiUEQRojCAVgCmmpOviGCUe1S/XNRBfNXkTwYXS
rm2VP5bf89Cp57/uFpUMY0rZw2uNviNAqAlr4aRPKHu6NwKFIXgi+i2ZRMzG04wW2avNBnJjFORA
3rZln/Ow68dr7Wd2I3OZDnneiowuFir2/AMgQtcee2pdzENi8tNTQ0JrNyDcDwBMt46xpUGL4IPR
G+E9G6GpiQvrtMi3khx6MBnaw9mgUWL3EoosY7gOJuLh9zEPJ7nc2SslbgHrDz08PHtPXMUsttG0
kGKVARME9OQQOV4E5r2IgYaWXiuq9g6KbHbvC/zkbwsDlQUA0d3bmlSRWKqla61uW4HdSbHgffxj
2513rjvVMaisX7OiaP588TwRn0clTo0uJWWLnZyYzw/qRzhvPfpJBSj9RynG48l8YdzK0H1ff2+f
atNUNfKII6AXXUfnyZr8cW+LXlsVTtOkkZ13VZ+XVYlH7a2LWm0LgUwa+kh4sKxlXpeskXv6xBQb
xqaOck29g8KXDKXzyQD/SdzNvkwKd3zvquzMlVU+fnj6XuYJgrTMrrA6UkgIK3fEEPxJH/+8+QGy
S6wQ7VrQJSmLiotfjjcaPdiaAXOe5e1Jx4hIakGixvq4FiaAx4GnmLZFdH/D/Yz578y07fMdKJjl
Ot2bdgCoS1IsVoO8yRpJo9ZvMvws5ms+BH9SoZuyShW1sOqYZaOoT3XnmFyNLx4Rzl8QyxhrvyCX
K9o4HvCkFXm+jq4nKW78YDitf0x07e86mPUZs5n/0TD2rSyt/OxBVzoafvdngmxGrG9SEf3u2gpJ
L8B6ChPFdKg5uCYThksPPTvjcyeldSvEd4qLv0Zfjaynj41daNnZzxoLedwJl30W0aKB4te8wJOF
1BIwq/+FIAF9QfVY/kxu4nv/7wb/G/CAy4fLY4E8mJdGs4u0GgUGEasxyfsMfAUbm5uSapIJV+/q
bPwo+XLfV8kisDHOi6P+FKXAowl7C7i6t6ljoHBm4kGv8WXp5TJfj6jgeQ7c4TF/s9bJjBppb8yG
lkXDdLL7SjNPMpXvLvSn+Is7xkbNdhA4Q/6rYjSH+PEl98l1L8+sT1PjGuiU6nMxxAbfAKd4Skdc
mRinCTDU3Hvw+GCeIy5H1b9BrCgBhvYRkrt8FvesbamITuA2pwFRrAEDC6thv7zSYOCnNXYD7Nv4
ddyiDjDGoPEmolNtZ8GvZtv3Z62Zc75GY4IAFU+dRdybFtw3x0G3KTmKyFFrQ1Cv7hXV5mnzcCUI
w2Zpzhv85pluC4uIbScXiVY2zBTgqUJkU+BrmYJNPudVYRoKEvWTh7kJyP5CI3etfz81wbOXPPE3
ZjbOb/uCrJ8Yp4+axdZSyYk7lsTl63t27YmorGNwQ8VnEiUP8S7mPRxXuM7hvSb4jo4r4bJfrYZT
IC5Btxe7OTt7gpXxumV0gF8d9q+ME68fKBaQGMn+5DNqxgLTAk//DGNzoZdKl2QC6q/0Xi86o/gK
Mwmi3ONsUgV/APwGQuJhe0lb4uMQUIjwV95BNe3F8F79RCeFHlvavKEzxAWcCL0Hofdu797WTpsG
UhAVt0sa4gxwqPlSQZUZ1oVxfW/GW4VGO4jN1467szyHMP101kbNqeFwJFvVXwzm7QcsEdhpmSA+
UcvdJGAKR5DLpW1tnhrWG9LZJe/k3xVcmyY0KEom62lZ6E8vXlC+WRHb9NKudqwqHdGhtLXefLfZ
MDnPDTbfuzNMfsAn2hGMKpkGoLYAwmQ/eP4Fqktms2zEGvQMOjX3pCMmV+4DN38vD/Yazr/E2MZg
/Yzba9mVW58Jnxxp+c1DFC/mS7KLD4dQHiAvvT74NMPf+6kQeqd1c+VT3qrH0Gnpl61iHeg1nW9u
MQLUalWlybyMVxbYHcll8THb37XcPVmy1+NJKPjqn0m+scYk9dO6HMYA2dcDjNqLFZWnkTQa2hTz
CHY/7d5qSY+wJ/geiTiOeG8dbqMts9+ITozLCYS/q5jYN31Wx6AZH1Spny6JxjcdVbyzWArXnTD3
Gp6qEX+RTjTebAul8etSUAr7DEHibH1cug7sUhrkdGRmY4aBL6+Aizs7uIzMZQ3h2ZQvmNM58oic
+ixntyM7QCGLR4iV/iU5EFsr+YOzsxZbaOONCxEis7B06jqRc/JyJXn/LgCMIDazbopGFVC7129B
kvdUPAEahejXqr5nyOTs2iRWQKLNPe3g3GLMcwhMxCvnt+t+IiI01lqCAaW20LU3r3Vo/3y9Gi2x
f9V8TXoiqJ9YEA0grPOgUhV1KSjaCOFm0OtIoZKnwJv8d1AWKC6fv4YoPENHR9d4w3YLa6W4XCKV
BFmgQE/f/Rw2dnA9jCMLjpwhYwDzTQcU2n8XS27EtrW4UJcFI3ELxCvDoToaKLuFre8+qMSBIOlu
RpdMIfmTUOICbZkttTsvWUoFEzbVspKFw1DgKpUjndq+wy8qhMg7KuClI0sbAqyBMGGmXFw/hDNh
QQhzfLAFc/rtPj4WlbfgG1QCM3sSfiVwMiGBtQMNaMmrkrcH/MFKtaFebvbZ7kH4C2uIYrJUc/PG
Zv7OqyojBPxyqa59zmH3IvoaG+SUBUfMhNQOXoK5iGnnl8VVgkg/EjIZAXRa1gs5S9nOiLiuSKqL
WEKmoQhCWTBZjhDl4AWRSHTcqRdxCrnvKTSokXwqE+oKwfq9YNxAEoWr2hSxjmcWrS0NuE7qaWAz
lYjCVOeR+3IGR6d0L85buvwX6eiylc1XYfOCb1p8Dg6Qim+8+HknHGmHThrilohOZ6GG/wJJGg2W
ynX3U9A6mpIwMIbS4CvbJvyQ7qmuBoxZLsrrbt1MMjqPbmonUC8OvvmePXf/wvE3gxQsKs/ByGpv
p9KNuqw2WrjfsmPmPQP9cJg4LetnyoQlsrJmAs0fyztvQNjNTSZ2wLLfRHyiNa93zZM57F9CdDWW
3nkvPeHFwj4DM7nvThD5mSpkxbk0WhLhsJgm8ElUAefHWp76SD9Csp/hA9/Z6+cVJugv8vC+5WZj
rUzyYyYA1q+JTDZWWiiea7rB68cp7NhuuGaHb2uP9LAj6Q+blCHUYB4A4J8W0R5HbDAfnFJNSFeO
FarRD4XShtPuP+eHttwnoAhdvZfNkVXxU0RKIiSxr8j3uBhB8zMZQdHkNX5e+f3oLd2fnG2T6xYs
0tJsxW3KHKoNK+IF+Wtm28Hh4xOSVd6rBgrjRyZaMfgkbK5EbFrvaavCEcY1JmaPuVqSoPCifTfT
PsTPkb9gZyXKsaXAHHv3LoQBu6yOHCYLtaQeXRRJbyrYP0iY77NNlO8jp5zPWCgeLZHZO79LSMnF
gZ8h9dDtDbwgNEh4jV8rp9VbVIqYY8NyiBeyQS8eLBnN1rztwnCIvTdVIY1bP7YZWbab6hDAc4lZ
9pnNs9CBExvJujCLTqFXxyVa4aYQ11WUccvSJ7nJ+d09ak0tDf0YbcqXrfLNPy+I4/hzUWBH9ybZ
mH3+rzcM96fhek9+V4tsGjYZ520JdAReS3zR2heAlt5gDkMePDvvYr+8mq1DUo8AmdDnzLCwL2kg
ib/Ue5bRXo/8K1Q3UNZ05zOBKckcs165d7btWRbNyw0CgKNIwd4zUgRLL1DQIgnh3oRuoyPCIltp
AEF9LypgTnfCPsMZwZBJjzE8sdd62eckPHrqK6Bv8TLRxBHqq9RvDiQf30y6X0epDbHR0CesGuOn
WCWxKthOpT0ee7PPYHuXGQ5KXFEFC5sOgfM9vgEiDhYtY543YK1fNFdtj9SELgyHi5veZjjmNAYk
LaP/Gqs8t00qpYxENATuBa0S3GJVG/oSgRzAbsbWDWIrF5CLuAPuboRkAfQbIZurhFBh0qZAGQYZ
ByhEfeGxWLA/VP/jmGEr9djPfYGPPIqZHvOb8W/DFV9vmjfD0BRaeq0TDoOijJ41+Ndy4XYUsuAc
9ogb2EgaxAxuAttk0ieBYXmJEZp6pCg7RH5OS6shQye0EM7xAkjvsei5jbJ78H985md+XfnGxuHk
gc24MwrZk7jFyCmhTCp0N9bZO+r4mQbjy9wxgL4qRg4huRHt1ZxiwqOBEhzhAiTm4xT6iljP1O4E
2WeM++XAvc5TXgtS4BRKc6hV7DbG63gkI7bWH6p4naDpanTC3hKF4kKZNun45c3+d4TYeqAvxRP3
4OeSni45BTS5J/rLsB5NypXh40HM5J+HaN3vuutiKjOAT8SkyQjkYx28WaSUinO/g0dnn98QtBBn
e0s+I2+gTlLgoFaIy50geJWW76RJgL51MRb30NG8u4TF6zz/jurD7VHg8iZd8tisppIsNgwzWTWl
9QwL4cLkQ5ObCBDgtnUIhL120tNjOIDQUhLEk4CbD63HuVczU6nWXvXgRjh44r+mzNYpVW0aTk7+
DlcicN+DuFT8wqmHduptW660EYJNFmX6ks9iPvTZ2t4WJerGFMFtlFJg0DyVulwZCViZbhyLWKEV
zRRGQglUYPIN2H9/NSPU47OwWlj9RPNX78ABB3zel5L3GuO5G7vLYkmkzG7ka1BeGOvWoNBcaOcM
xZ5E/rrtG+uOZ2hBTxckQuahF12vcy4TV1FAhkAhkAMOPbByqA0f3zZi9iTYYPe6T8SCxsRLsad5
9uLyWNiS0L69JBtlVAa+UOOM51mUXta6IoARQPKDSigY6CH7K0+eUvPcs3T3qOFezRY6oOmBJW4K
jnkXc8s2ytCEMmQl4FiA4tRpY4WXH0zBdMFpZ1WvwMxvQlDNYFW0FZB2C/d058u4yDp+grkW0UsZ
J4wOBeSCJnfJBZANRKWY8Auez/Yz4w/Jv2yNVFQuZNKPhUAksDR3Y7n1f6M5FXAu2du1kpUXRlL2
TQXTZHlXcG4qkojlIlXwqnn5OFGtZ3xseP7VTcoVXZo/JmMxbU7k6x91bl5ojUkwvr6yi2aVrqZp
aspEBdZH/V/L8c63UrG72rcJShu/S4V/FjmYxwhC5w+cg2wFgjeQJMH4WT+lxxVTiXL05j6ZbqEa
px8ZMz/Q236Gy3XDN6jwE8/0zeMWVMAzpgx+fbTok3utmP9mJPwzRpXvCyDfRdQg+/z1Q1Vc2H90
EznvQybNymxzAkQpHvj7K/01XETA5NbMSPNGVyylDOsnXOgC65g2uc9N6VyNjEc+ZBBF/ztH5t/5
o7CPMSgqIz2vIPZfnGuiNoTRFYrmoK6NvttOsXhOmiVLTr7a25BL1b03omx/PCT8BliGL0q8WiMp
o5w8CCCBkaUe0EVHXm+u6fSDy4C7kx7S3of8YlWASe/+7ClvT4GXXWQhjYOzL6Q/fOvZYytaTx37
BGAl8ivWk86PSAe0LcmlcVzebC39OPYnRQ0ffRMHfRNnRf9a5Vhj6PPoarvIKKG0xvnqRYUDBHTh
am6ExAbJqckBMiYojv32oHigVbT1GCNPdBrsEgUOpaSRm6KwpzScHKwkngKcBs4yZEtoKWJAVZQ0
oubGWX5Pt8YRicAoOdDJkVXLJ68lAZTy4xQEnUVq2AlUgTJQSIs+s7vJyiqK6dzZfQQhmlS1ZgoU
+pbKuAWRWrp5Ux2vlexV6z8/P2DWiUUcSBPWxOUzOf8EaqptIheLfeJCBM8oQQ8Ea91OJe6zXc72
5p6RwEmYiEyCv34qagJ28Amp1mOnRSqk8vfNphMxIRDtQM/QffdcJBTz+BEiUWJqhtO+d77qy1a9
87A9JJfeTRNB3p3e/mq+WVPp9s/uHYFKGPktcckUFUwyxxQq/G3CprlVVRibpQvhI5dPdHEa5OnP
jAGC4onnUHCc5qlj/Qj9UePlpYk+9PrsgxlulCPflDpZmU5JOPzo9sBo9b/xjZpkdFO3DcOnfcnG
S9EG7Ml5kuITAjeSqnQRkcYcrFoh8R8wrr8yKxmouwEXvjR0s49gRAZ2nxxeijGPRdsuFE5ytO+U
AN1ehVyvuUWuSgmWsQchsHp0mNJNzROwnWjWoOjD3CR5UYe+D1T4my7F/9JfCR6mdHbdNYb+FqSV
FXLXQBRKd39zXrHx/+gqaWjxc8nxNGVYhHnN6+nJ7AVNmK0k2tFxXYyKmM5kmelaYJ/bcdQUzLgP
m/WQdafvpNCvt/ZKECqGi54MQH60cY6rlRElN8SdacXrf+Mhg78WPiTt6zO19iiYvvcFDH/k0fAg
IkY+oQrYoJP+z6rMVQoR4n595FCC2YSp877PbeyfHeKg7Cs1JuMTngLry+xSXyVTHU2hBjTbyb1o
jXl9tZP6/c1QZSq9itEZhQSRaGgbohx/NxPsg4vTr32FDF1qH9TS7vK7ZxSO91ZP+MokC3zAtUSv
sZCQx3sAEiw7G5g2Skc1g7Vl98X6ZYtEi43A9iKtwFdR1VU9EGN01/mXVrsJHS8inXH3hbZcMpoj
tJ65QtW9owSp1Q6fPmhA+re5wnfXntlPC03BSZeY+k4UoafN3h61yEjdQjM0rdcraHFH5b/Upv91
8I81U/pHQBJGZK6Au8cbrnyI0hlltY7jmesyddCSuDjXytV405h48lv2SYOVpXMVdeE16X77OIX1
edEuoTvmKkrchA6zUsh1wTcP/3eRSCkQHRX8fFqaqeOOArRY58phOvccYu3Ocue3uf1xRoUdzYvh
bEfJLr6Xh8BtQG+28igel8B7C6ebuDaiRk/s18qxoSm8y20Qw4RflkpSVC+LnCCVI5R15J+1Cr6w
fC6GbSvVf3dJbHj6Gzjg35e0HCMhLWCskBxzNqsiQEWIdj2dc5N1d5Z6BEneL4cVLs167lhgi5Sv
pDJZbYslJGGBs0iGdLdYkEgE/dDxTmdtygOv7NdAjtz6eJT6ZX7Ovjtg9N8kEXWpd6v5qYonqOKn
UkJflLBNmdgrs599q/u6YC5dg72hLIGAFqihZ98MpC9haDt9mYyDnOBbezlZEt9DfBospbV14Yvm
z+4gkXFj70ogmwVTwxZw+EOK6RYf39ltTapSBsbaubjIkggfkf8wKepDfRv7rXmgGBw8AzOJLlMB
IByFeF73GVAGtsmPqt2kZO6gAFqxAyrFvNLlpKWPdJ6T0lYeC5wV+qKWYvQxS9g78mf7MpJazpLj
rplDh30xl/ojr/gwj/s2DJ0GtWocAXeDB0zi2tpPVF7ZhdP7S5Rhu3DsS+LMsCG99Cc2F3D1TfYU
lpdMB7SBz8bLhkr3Geb1hM4JWnQHdRh2LBr9weWJRkDfXKKzTi00R5HDhbmWYz0o1M5ZLoyNVShB
+CSUvFKDV+pOFFytrbnbOsQZPQ3dGb+WIXBqNYpobo2RMh9/xYAS5kSMMIYcGiuwom0vPryrUmx1
dHxiIv96uXXzN7u8LXL61SrjqJDMSDwv0JacpHJx3rGzVc5ljQ8MHiRsjWy0MLnySAwnGWxcB3Gv
LEnZDIkiCgVgHlsr2cftLU4KSSXu/KIiMlBpfjeMntxjKaWa7kGfLEcJRjKu3wo3L5D0mdCakivk
oNj08ixrAKtZuimFp2KHvQxUoY75IvnXLKF9EWW7cNbIDrnG2/AOIHGikJmQi+70Q3BEuUPr0eBD
6zZz1p427pLX9ClnJTYI0x3Do5hVewK7F5iv6G5c+ARotIGqUNwepbyi3e7t3d5zpWIvlO0rXXLH
7lfAbuVv8m0OZTeS9ZS5zXgWPbFrAOgyp6siyydJk2R53YW/ewv9Jqqc99pPr81zrqMLaUnPaZpK
i+55rboqm8+RJ4Z4z4CWePR3FeqBMTRSO58ZB6PGRzkM0BvrghBjg10IR8q018GRsnsoX+MRK6Pu
Gyuy5fOND6p4ZjybLiptO4kQLT5dCFe1FdJ3gSG+v93JcQf3H0obv+CJigl9LZ8hbRmo5BbnrKTi
znyLOa0kgD5QyV3bFzm0lMLuxip0UxxQIiYDP2XBPX+wqGODRysX5myh9EhZFJS8UPUSMNbn3OEG
LWZhhnz2XK/3DEFpv8xEJq71EjwEldMAyMPqhAUUD9T91+ALxFuFIl8l+qIZDWlRFKmxgXzgg9Ue
SnbE/XblyjnLZ1l6wrepNan2+xr5DydhqO2tmRmRcgrXppC3TjtY3/aUWms9wconuYMvp1C6172J
w8P6mXZ8jxFy+O5f1U4eSxkW2tNzg2mHgkYgvDjCwsT5BGlSIZYJBpEFSRFKlPeQR1PttG9ivx/o
LWdX+s9K+cpFiN9VcX7wNed989N5sR041KR+rQ8OXlhFnnHWseYnWpPjN7CxMyGOD9hlAshqZnkZ
oWKhZG9GwgGnCFc1M/8FlTFTedeXBoFC48a+miWZEDpgfSDuesnK4IWR+PCjvcPKC0Y9uMqwIIaR
t5Cr5hPRxNiXUDQ3xsRdDO4tK4mXRKfKTXpJoJ5wcF/+ofro1Dd9lDd3ALx1RmoE7d1MMR6QekP8
XYadO6A55xTnsD30wFe+bQyRBeLRdnkT/5VWbGnQOFEZgbWOjr/A9pc4w1NRljTjpd4zMQfZy9dV
ncUslpngp6X44jZcBTFMjIXfuUyjojERam5y5piWDB6RT2JJXlGn6r0JsssHEJhOBSipVXF1tEia
DHOXkKmxUL+wzLYtK02dYG0xZyuUiOhIrW1pyd76L4WfvhJpXARgC8poA0cpwytzTj1A+imemY5Y
jB/Mui4QnHOP5xZQJMy84d99wHx64NP+6tTabGMhc3F08F1Xx1B28rj7FX/o96DOL2CEmD3MqxuY
P+XLN14gglKjLzJj7TG3XIEQormEu53JeNK+uGrgj4qiWd9oCO1QcPhgrFxS0hOcJvhdHY/mxFPx
7yh/xvrUvfBfOlOCF1sQHNTJeGnVuTTsKXKspFYWIy4RHrf3k1FHT+JvPQm+P3yWhZCxaKeN4NFF
+yfro5UUwH5QYVzfD2r2tUE8n/bgTUjONrUNZa1Ze3D2OI+HKoFgQzZJaQPhrbiSnWJwmIVaVbA8
QOV4JQ0dXHj3MYkD9G6u8pcjW27f3qQJ5UcwRgsmfTjh+ADKLsoqvRH/ZnGKbZ+cxoZN8efI43o8
Qx1yE5i2EdLLWpxFvVAJrTV2m4vXL9ZhquBSpQPwLZCP7iZlZQA+1GxR93B6Aq8w4c0sW2fxXW4Y
flrVxw1EK0cUuz2JT3vu+Nb5TGxUDrXVeXfR1FhLpj1UYTK5R/Enh5dMUUB9/2xQMuNqXvWEcUtV
VsXq3/BYnD/fYFrZfo9bRTpMG7CIoC8l1xZtDIraBDAAnX1cVEzjnslvVvTVL2HOlU++euEj4QMe
7gC/VwtZXJVUsA6pm1uHlyE5ZrDoQ1UIIbx7us8xTRme2SGqqgWnglp5abPl7Y7rdurmYBxVpiGQ
k1NTPb5YVnANA4qFv6aX/0PMWbzCGb//kIi4+ZCoEmuH62BJ+NqjazRBxb1mBRcCNqKfG5vrcutp
AyF32OxEDOVE+5XwA7FiOSCTjzqXj70/2XXymRJaypPLDX985Nr2+LRK/Ga/hpYg1NclEpc5pmhq
wQSrwPMPE4P3uG+1EEJgLE30pTBXKzdlNpkgYMXKcPPi4UYykb9a352qGT3hsrLKdEmZfwVVMsND
q+ksPbH7MwHP8scH9kBszD6cV8RBBu0wuj6GCMAO1ucuqLuSCdMG2jOEy+4Ot/a7YWdXpoUh5CKr
1TS8W30BY9wFQ5dThC4s2RJ3tx27zElotT0eadDOPC8N4TrT/JJJQo9waLKfGonnkpDmjg5Fmctm
vCEkGL0rl2cIiGtb/yo/STi2vBuGZ4dVbQ5m/LtHY5VNzWwn/gxxGKvvizqHq+So0FQ7x6iP3MSB
4OH38ynMZc8K8XQ8ofQm/O91FfAwSXc4MxPGQ73kEkOikrND+8B4da0ZIW0t6eS1OjEW8eqlB8Vq
2kwx2aOeIRuNWgtN0m+XFSsq6FaDzdTSzG3JHt4GdsPw6b5HoHAHiUxnSARZxtiI3OmQKvsnnOrm
bfF6DrX79Yli1ni1eQ+ZvpnA8dsNwXSQ5J0e3ID8cLp+yvonCPwViifttUgFi+1sBSwU9fqJ0k8R
bzGrvPg7FeRA6tRv0UdoZkh7mrnnruBQJ4rqS8+oBc4WsOB92TZlasnpGfAhNRmBverrFTCoxnBH
KYCHPd0F4MAeEF0F5Uvx/CDshfXxRB3blilMl0T7w0t39Cs0f2KSmzmNJsfi+1pKGOCpFvUg0sCR
2Y1z9QqqdKcVQg62TPuc4HNHANXjv4ZzT6SGr10954fIRMJWGIvpHZQv+ayETmZJAtkQMtnj16zZ
sFoikSqjKErjw8K87s6l0N+rDGcB0cg+rhX5nnHSLDLdDLfAg6vwM13hUs8xDztVG8JJECVPntIt
ElVwoZHFO4/oAZi3uhF+lpAVD+h5CDV6dGO4H7X5E+74M6mrOnWDWXvnF/GFa/H7idKhXonLfXL9
uXADxPKcYvfB+LEU4XS40QW0H2D3/wtBQ1+wu6gEBoqWbqPxx0YBZaty0t7MTABeFu1+zBy3WzFZ
cqq9AVc6jeRUUdlDbkpLQKMJgnvkR/hIFWmBZKg8wTsoWxi3i6uoVVK4J/p9byBj8CjXUOvcL0xV
B83BbWrKMTwO32KLoJJOYXGVJ9rOXh9JirFIr9v5Vps2EKhyzF3Q9Fme+4p3weUk43mV1qxSqj18
U4nEPK5nGLZINlLqf+SdDWv1jdxzXblDYPdczO6NoGkN4zh80HiZefu8agySlZF0DVydaxqQRsOh
KxHavktGLivNOLtf7ZdAURzE+fL8I/8K52VVuRsl9jmX3KeFMyRhUZM/eBf09INnKr+WfgICzomq
kzzzG8WgOpWtm0Dc0BC78FKOtkviAHmT4sa8Xf0QAJs1zpksHULkhZX/2VHP7bjPcvDEbrF7doRz
TmeEMIm10PaV32mVswUPThTEksqUossrQPS40qptIC/woNOpknRm3lAidkR/fnxVOULdStktwm4q
pGZHKDUv98ssETrOx5+9BddNJP3Go60hnJQmwrUknRhTPfGSOlKepk5HNOQy2Pdy51jXvl46fuF3
rsFoBWPqR8bgLPk5KyWCGXvtnytBO9gjCAt7yWaiwoQGDBt6XvnGdUTvpIRRO9Bm1OMpm9iQHdrr
CxvrD4kZKT+pLgf18bDQSqhUfUtPEFZ2NkTXRf6FNveL9Y/xCqxgYbSU8TtMFBmIbrDNQ2zc7bhL
ZaM/kAPAIemAHFJNmUh/WVmZYZkiMCAtSEvUZ6hIlcA6eyFgikZFo7DeYij4cQXVyw1M6niMu3/p
pctskePLSRPSjVuQOK4eoVLXHwzhR16GcWWtNDB/Gs8HHSPvnHvwzwAx6kAkcDBjBIWNkRlLIkAh
RFV80kch60Y6ETxmpd0yZ/RDpM/l7aC0p1OON4ZV7gTNqqYp4DPArandM+peFqvFH0c6sYqZ5Mx5
xT5NuOWcbhhQRRvrTnY9z4gJeLQ1XN59PlLr4xuBMVCIW/rJorEmK07/SQ00xUNg5z41vcxHbi/k
gZnGOw1w4mbMq4dLoAFE/Byz+ue7K4UPZHpasR2hRHepbkxuIfYQFzj6MTJw9h/LzOjouVpPxPIj
VccxrarJ8pwmMKca/vJChCszO9jlOHaY5PdfZCYa4vKvaWRWUhc6h9q9WpVt82adCjgJtpTghTDA
zUCWsw6SbQ6LKmmzF42qfDwSTVrtS+mU+0nNipN/t7ouhiINJ0Krg6aCzjUzfqGeTv4+v4LTlUQp
RZfnc1/0GO0QS51nMnQ+wa+43rMiWSZhcBJu1Z1cnD5fQibRr/PuTilRPWoWN6V/2TQ3tY7JFpTs
Wkgj7h1v3sXluKpsWwZWWpFwkm6D3jD/OfKqiYKxfvtgC2VS6Hp1v+IgPmrusl+rYbTAd4xpz/Z9
iH8RQFpRyfUeZZGFbAXUkH5EYGSkYfYJGtATaDGneR1D4k2sSMuVtgdz3ChPtNl9oKmN7mLD+a0R
YLi0dch7krT+k/nQ6dGMzKkLoCMQVr+YkpMz6dT9Ii8pk/R0h4LRaf3N2kD6ux/WRr7wrK9Ix73q
35tQ6wCTvOKbMIliITOyl0KH+F2ufgJNCspVWmzA1fekZbnUAMxcNktwCGe5VhWJeT5QRaqxL3tm
rebANgZJPrgozhY96EsefKuTcSYc8miR8Cduf/2jomnWgVXvwErIjbB8aNX38jAxvU87SQhxEI3u
oMqtwsUKosbhsmAMOkBbhY1l5Uxj4z0HhcGs7z+loECzRihfPKsk4LRelX6lnq5EfM59ZhZdcjfQ
IuoN6/XVneOLVV66UjDI0aZn8q6/9fDqBShGfL59ATF3QaXwjsedGkO4JwdBXP+jaka030KAzuzZ
f7uDkE+vcNhsGAX6esj9qwxcdOL/bZ30GXaP1soawsXnJbgKAPd1pyu2mTYq8CbIFurmgahEPXIW
aq/bAWPZ2T0z8F4QxvE+Qky3NERbHj3G32JE985w8Jph0/vn0UsmjSUdjfFVOOqO+EwP1LLwKMLd
/+rENBNj5mp3wpxUpd6JB2FI3nScVC0O3MU5YKR4YXIaUwH7rRxOGI8XnEB/VlDFquxlyV/fjbHI
gVB8B1ECi8bt00v3bfr5nFiW4KuoNiVTuhTpf280jcPSCSabjFGN3sqvIoSNT1YsRIjIKu8wSv68
mPwqiLSeA77B44zEYzKZOI30u/nbOh6JpfD2GWvJMElzstrYsqqtNmokkKTE2VlQ/De2vTzzHtKd
JuGc/xEHczl2W5gdSgA3KOvtlbpXJ+aVsoOgstOAiVoWmgXm/Y4xvQJ34GX/qLMo0JoopA9mDbMV
otSawb9Yo+RyazErZ/UR0BBBcCUTGXt2hTSY13lkvw6rUR/0G/t+g6eosUPBeueC8O7/5r12xe4a
tw86g369ktHLeEQSJnZgLvR8AE49VCnVP6KWlvy4ggevUKwnzv0/blux5A6pWmM2PjQiDGpX0Tpg
m+WrOuuW8F7SolGCFfe9h2pvGO06QUwJ7aCNKib/Rse1oLpls8MWEQ0lmiTkwigjLltnc37NVB7h
Co3KGahBd8JZOe+8F7Npa/6yFActRPZU+HdiZbNeqUCCLTnlrhH0PaB5QS/wi9kkSrB2zH7vjb0p
H8I7l24u6G5qqdGXFTwIPDcB3z2PJe2ONTtpDAyBZ5GPQ9ELTKQ6U6v0eU9nrnuQvIpyHla/3PNT
aX0xRfjDtN+otIoU5izQ9iYqfmK0bouLOjJapcfaYu/YrY0dSHAcqaChbZg+rUsojR7Vrh2Iy6kB
sRjPJDJl8pGkFIAIUkdA7sfA3WOJ+5/qw0dfXbuGbCjr3TYN1xTuQ+VAUpyeXeqhS5KUVVtmNskq
guh9Je7VV83UFke0fXo/4qg984H23ZWFJ6oCIwxAjsrqS2CSJuQtEQWl3J8XoQ+CH8qh9xljmZxW
RvmcZ7u2NLAODq1MJq6SFfe/VUqnkRJQbPoniBFQJnBTBKcarcClhcnXl0Qc7dyOcjR28mVdrRgP
vwU00pHpsGRkpMFZyNnZ4nhqQwO+JYTIEKL+GflPOgWBAYsf+/EdxakJQe2tnF2tOvDRPy9eWll5
uJz6ydtHhMkbF3hQEb3/ZvQvif7XqcpZislMbx+PPTIozCHEE8ZLK25ZxB6NSD/5vD4k2E93dOEi
2OvINO3COiEXslfp9jWx9xnPjPm3M8LTXxp6oQvS5v1qZgJUvJ89tJvGoupRJLluqa7DribO/s0V
FBsY5Sl5vM7zpJIW4WJP2KKp7VrVpLkhl3NWgouSdlmfRINu1WNnocwl0T0Lj32W4gLKb3kf3PvV
iWflZHe9YNF5JpiT201+vXeOiSwKGm2ufl29iv1/hqd2Cb4TRkE5YyisiVEKvH8yab3o0rpRxwiR
fMfvEcw+CAn2w5BxktrYXhXEwMe9AMv/7cvc1lAz4dblZVLUh6FS/a6ppO/pXUrdIOZdaQdvEIiM
5dXcBjTNcrmwO9/l2EtahQUWwR975S4a0upTSs0W9KNV+k2FySmP/iBgtlFmUxKZ14YYfDj1jclO
9LkfYxmcdEsdWaFf8sLb2Py4cTg8hkBD7+eXONZwc9pI8m0hVwYkELFolLIJBVALMjXNSScZj46b
Np5UCCj8h65oVH6iEAgC65nHqqc19Kt+3QRPydRVuKYc07PA/VYLNqwcyaApB5dz0QlZMTUK3SrU
yDT/4qaMsM2vHl5SSuC8m53cmO1Yj6Fk2VA+Zw3Bcwe39K1vGdQRh9ACWwoOWxcdTE0HCpBDYmnf
FmbKRWn5kVCpk5FrIuOQkRk5Xp0WkZ3d/4fHkivfBRAHtxK7zDNVwirc+Vi1DQ1fdUWcsQQKv2ot
/zZmxaML9CjB5Lm2nsIBFExX0YOl47Nn/PHnF88ccZ7L6VA0qAccYlp8rl+fubIMkVS8tUTO59f+
eh0jQPZAEzTdyvACAXW4GMv4BpTSufS7Ddz82/qnxqSN7mCmo5gvxkZOR/+T+SbBZ6rfjF1EgdZV
mjXhhZJXSO3yuX1v3CA+mHiOmItXfU3VA7/Vniqjo+tKJUPTtpcFqO2GbULXsh/E+hA980acw83A
gcpgmDZWG/cgMVDJiAA6K1PcQXI3rk34rueUhRi6jFhH/mVNYmmVROQoLd0NpkF/hWJG01XLbTLH
Mx8OurApcx7SiZo+qX17m4aJQrtDkZTrocDFImmtDUmdJKTse4PxAQjXryBwhfY8ZNKofLiypgVv
6g6b8/RXZhdfpYYnf0qkzRTg35YuopnhHODyVBekAE/ujBXy/MdzN+PYYBwp9humYjlH1ZS+7DaW
fKfE11s0OtEyx8dDSjxVVPqN1A1WRbZS9xSYEpdWd+hdHaR0n+/U3pZ6ZldWJCMgKDqsbEpSDtel
5r6wTR9SuFGEQxsUNWWL7WUbB6RKEwRBypAkuraklXMz7bjxrC+QrKCI3/UoUHyvc/zY0GizzR/x
0vt7bk6zy2+PU3gIFao7248TsUI8MPTMbmTgNjShfs+1gH2DeFsLzVNmsicBVjzQaM5tWQ8K8TQt
mtDndg2+Ficxld6vhKd48hQQs0ywY4eHUuU8NSPAgTkhWFHUc+Vewauj0mML321LE8BK2k/fbIXL
vkqvm/XwA/ZXFpnoYMhCJfoXpSJqbmXQoYzemi4JYuQsFThpoh0Z/NRv5ntYshIaVnuwW/NKFgm+
3NeSF9v9ZEH2VBgvAtg5CADWlbb68CP4rGWH7Ye309BjAjZNCd+YfXW7ViTKjtbIcDt1DFkkSddG
nb7cxVj4+VFiGC5j94jOw8maO6RnTBBUIPR+Bf8tZJC4nsqF+MGPIWyXpM2/y4rkHyONNXP5u2io
StIi7dYSn/2iSZ6N7HzhOyrdPtRrByDyLDyxJRpO2HETAdSFzkQlbYKavMA4VaspXR/mZpEf6hxi
Q2urYb8Qq7ljC+33EPo+pZh4Y91Z0Wnj6XUQq82oQqpkcUIsKAQ3/CzCmu+NQv789gcaT0cqqoSS
8bNE/58sjikhFRTJOdqNuGvyviutpKzM+7LdWQSpZ9monICFM93OWR7nWe1m6TpusFyNnhnIYQTb
r+saaY6ukU1izCqthBRX3rYaAGEaqo1NAviOxzrtbf3PPVkbuiEXMPhUFaakdoVI5emG7alVXxFn
Nqc8Zn7Dqnvq93S/Z4DpuIL/552bQrYShibPsnyv7cAN2V7Shj+6IwmRFmPYVWyB5DNzQ99OTgSU
gtRdIl/0C67/vu98QY7IzWxfFgDpolZ27MvbEHnCCkLRXFkidTptbzNdOUEryOhNKhwk+K06tLGE
VeQXeGOc7GgSJYmpXN/Q4mhCkQzpg98fYKCE/dbbTgdif/jIRTyLQFcVa/vtZSANj3U/FPnjzuvO
NrrczigUwLb0uLw5aZaPSBhE6YgIj3riidQZpLIOBhhutuBkoB1cQn5Uky1wUQ9UgfxVK0kdRjpm
qHM7s1PfuDCZAING/YyCwJuWDv6BVX95P8SVINuvbL4XhQ+sZ6jyXUKdWGHcBj78vnVU2pFSLTM8
ygj12DipqCxg1Uc4kYkouB560SlKgxqoDmAmEO6iF3LdMxvb3ScHqCcs58zvmtIwTHkhJoCB2OCp
z5aFGZhS8uqwqYeBnw9+D/DxRAuEqNlJaSGFfBE1irjKPpwpkNCi3I+3Vg1tamkgOdRI8LjZZBqi
pkBAE/6lcG/l0zkH9Eu0MjsB0niGdUmYXDtbwn6y5EI1NLwgmr/WBAdkRNw8AuFp1a98IA6MZE4T
FYGWKp2ZPFHRhSCxnou77ug0abLiINCxaauIf145akaFwQK58NVWhD+c3chM1MmGTMJ8BBGKkhvZ
bZGHUWpDlkwD+qTKA23YR5v2bRYsZYK/DJpRrNMH0ve7ehRLDPeWOoMBtMgqJEI9ipuTPXka7iGj
N5BlkYT7UnZl0y/FcYZ6xyzsVq2Ey8sHkMDgEa/MOKdrsAd0l8e6ASpnKUwr84C5VYVXYE+TM8RT
hUjzVjcQllz2UoshIsskfGeZorNY1hJSGOQPSvHo/am37MhqI896hm3WPYc6Yg6E1GGuOm9xfKap
rV+A37p19W/2hgpgPKggPff13MGQ+IwNyEpRLinF8RMJ9OPIQ5JMkkTpboOX+6LUmNmDJfrzljz1
dt3pKPUfbR1Gw1uc61ekJIvYx+e9RV3V3NcUWv4fW9oLN6+O4uQHeMG67uHSt9j4lxsv7DejKC52
vhG3LcI9bn5lfpsDmGT1Dsxc3YBaHuOIyotnzOckAnRBXh69Q0ovRDbz8RorPRFekFIs2k7wBsD1
BsqlWM2si9JI/aXZqVdeCPDTMB6O0Vjx9jS4SsFhvOzMUPASyXTrnAA+G1CRDcrFDznz0QwICLUt
C09GQmVt0WmkCUqCTWeHIDMaj/TxiuCKfUiXTGem2YS+3SHQlSpjls2iMCZNOnoQlDrFQJQc7wFx
Ey8p48vpaXv28zCrPZRphKZtDHtnBNbSyB9Snx8rqoQh+0DdVZDNv2OGCxgizBmf+0NmZGZr8+K8
pkFdOldPIUXKRBsYScWx/sAkOiMkX1/ibFzpGWnGUZRULLITe+5tRx/RS6Ajv4pEwdlzeWqoZ7ag
uO3uBwWyuxn4N3/Xx3LbyqPyiln0X/6bMXVOzbfk9wF/T0Yrv4xHqrciQRU/yEcGeTFzZOtWBCOb
Nbkwym/hEqYisf9aiNlElS6+aTx3qY8PQV9fjCFebhHAu4CFV26lgKksMs2Ea8TvGCSPYt7FPoq9
tk9JOPC3G89KBbgF/APdKzeZIpJkEHa40S7PeS/pAARiE/2pVNMQ0jfxgbD5GyJCzPxmvSiFg/MG
OxSZ10ab3KqM+Z768EGdGpZqh+mTYdvC45En/NDvfhEKpi2Ph9MouG89ecBbDfdKhPl683yAl8Js
l2HHsrZXLzZ+vpHH4QBB5njvAeHlCw+3b2UHbh5zS1finw6sfxk89r8po3GYzS6mwdyuEBDo9Pde
K9axyUHoLKVU/fGG+Q20Lko1cFHrjksX14CmiRmLOkVDgmolP5QPx/3PfHIDWtnMO85J8rycj26R
G2L+KzH9AWsr86k+hMdG/zPjqKB/eneYviBiuzgUHUTdUMCutmkOG4hKiyWYCz6YoORCCAo76yuD
6QeR8+fHgWiG5AtMCH71MjnJUyE07hu/TWaVtvzCF/OgEaWyYZsnZ7oG2g7m5p3ttjSfev8TVuyd
MB+HwYTHHWp1kXbCQekUAmeTD+BTUqW5EqjYw/j2aMgXD7qBAN45KKqnlg8TkTV8lZ4XdMZeTP7J
h0zmzgU8hTkfy3ngHcSaIvOMydN93rVFPVWRKcs/X/yc1wr3cd4+wJT4Obk9Z7CT2EEYHw0Gu/G2
hs+ddnM4azvmQ3XP723HEhyy5c12Xy5Iv35wTYfC5AXky0TMg4XStb6XImnJPDh90cT2ytsf93Uq
RNNqQFjhZuBzJLeBF4hmGQ0Qr2/nTfkyr7wnUCkiFshxZY8SuKZxZog6APmAhEN46sP1c0Q4TLT+
9jNojgeMTIQL1aztzVZGpe94rfLv06aNo2kKF3PRtmWYtC8b/88u/qc7e7pTpoFFLMb2p5WkrGp5
mY9+989alrc4uhnhGL+LfLD63i/mRoZVut3rSu21IcFbyNDOGpEmmlJ+FKoMvF2S0LuJlAITAgbo
gswwlWM08RT0kPhOiyH3+Ux8znW/+47qz1i+zG28cq3ZVTCZmZHY7OSpEZw2W3hIdCdx5HSF+71G
7wFuZZdsneBcQaOrZ1N8bWtg0PbMksVx7+NQta/tBZzzdwnxFH3RAvmvyDtfvXtoCjWzx5qih/Jn
wYOdXJCJHYAfaBZpjnzI3KxkQzVm36SpDPA3Vkl60tZ0LesJ2NGORt7epUfbiRLJoDDGrNIbbo2N
XlsKYkBxALSIMPku18KuFiANGTw0vNIKV/+f/Vb2RLGjIMRPThhD726DFewjSBzA7Xo2T9yjFh5L
IWUX1RDRhA5OzRVX+KJj7eDX2WVHFI8T47CuPJI1bi/p5nwsdUvX2iasxCIr4OZ1NamBTq3KTGFs
reJjNwqM7MEm+Hj3bS54L7I8/25LAjh/uaFzKcLwRUrVh8kQmCVg3hMztcSlCktJ3mO9i3JG7Fsc
Mjv2l2b+N1quDM09GisLNvuSLe2+thnba/B78SPyUyoZwxMlflKv3cDEAi0IspizWmH2un//Pjd1
/zxgoTKa/el5FP1JJYBd64iEuNGZBsT7Mo+kgcZNLRJyES7g/aFxE9omdDCk/iJQ2R3367PDc0+o
1RPuMwaKqSYUFbMncWTu0hqbX8wVHYkBtEq0oT+ahzKQ1UWxodW/0bAPcunO2ip7kgdAR0hFBMn2
4JSj2qXcsG4qvzOGUsoQh4/Uj8zuKf2StP333mBv20gbVTKpWL9bMx57lCEguQYznVhxSBfLWqJ9
i+JD8X0vRPJBkX6gFBzkplPucI14EqmQUa2vshbc29HEUuzw+tdhGe+6g8oxVYYyuEdXNe3wn/xT
rFh8rQlp4VU1LkTd7smUuYSN28tOVUpCmeVl4iXA1i9gcVFdeC3ZfqDvynKdW+8dOR/tLCcK8Ttr
j7pyvSc3DmkYXeoy09JddNO+a4VlYq14a/mddR5OQ5sfUVebivJNNGojCh+xTVIQqtNoTHi1o91R
aCKU1ot9ygHYJO8LDgtdw6aufQZRpB4a2TElI6pasj5mMwYA/ecSgeDYNonAfCXwDHsWOP+X9hJA
CUzJEzDoXGHGkTJX47IuWERW4Tw4x79Wp8FESgEyFn7nyMSW3bFk5UJkWLAcUSkrmnFrnTX+7HWB
2fssJDCncNoKUQu3mnym4bp/LkQM0DIvKJDTkF+GiDy6nIu/mMPfEhp+KLWH+yjWUm4UGhC7GMW/
kgg3NWpksnPiCzRJ9PbgBUni6THJseZ/P53MSe1pfrDzlasUSlMm6tXGD10pEYm/yZoqcDDzLTd4
fbCRaD6HaOhlhPMu0YZo/jLtlwCzO/8JfL0SQaW+o9JMay3fob7H3HNGOCNby7y2JMbkBjOxOdO9
9pOn4kRhxi49t59ZKZOn4C0KvR8claT/KxSSNyn8LvPgYOyAecC0SsWBke84cW3wY3XVL+Oup0RZ
yu7J19dT1bxWtCAUdhkJFP+p8lqXEyK8YLI1MDvH6hI+C1GSfTlobGvCSwwaclsHTg5HUzbe/0Dd
zQIk7v317UtDoQQs4SoV9GZjr5PEeXKc/xbs0vdDFoWKkx6N5jLvEr27BBofR7DUIeJ+rP3beiZ1
5nJ//cFrkQSgnmkriJgepBV7N3lhgrXzizL+0H1whBAoZS1alhgvYWuAtGLG6APbn0P5zwFu7BTc
Nfr4L3sylNRb6/p6H5L28+XkN7wbNasUd4ml021OIJS4ed0bos69R2m9/VoHn8+vxOoezAELzrVP
TWb5JFEcRIqXFK6XopUNTKGIZtcmjegvpI1fSWj46pRA/IGB9f6MzfT1hxmxHrL3eV3qQyICemHx
r2c6adBz5gyFr9cyp1fISBPAEW0MbBm6cCEjW5/obQ/lVqTTw4LTARocKMng9SGwBr1tlKp2noKZ
2AGla50GS1BMYiElFrBMCp/hMJEgqfbdkjqwHF9tjB0i5xQrP7YZyFr6izXEIm0oPiK8+ZbaIY8e
5Yq/k/HbIQJP9ReUVE//7LO+kviQHwZVRz9X1OCgQT5VBCVZ9/1zapcAG+2/5wfW4jixJMXq2a/v
g5auoMbu7fC/qyyrkIP7jwYaDrOBfIht6cRh5B4IsbpR711KUehmNpqtQVGjg68831Wn1NCY35Ay
7h92/t4cjxQB8uUImQZS5P6vnk1EnCj1eiOcCTJFSetMK0v11NmlJrB5WmheCQV2aT9QdrCRwwg3
x796E7wDu9IEEpj2tqh3qPc8lBRHwEd9WyAhyv2AI2QQtjF7UA6IRkhVePUCIo3BeTsqz3YSSXaB
L2GpYHn2R5ePWt/wDlSSyDjxFr9HtG29mbf015l/pfOY9UTLXMCPsKyJNwS9C4+3l7F5VAbe3PWa
GRXFmvCG8u+Do7gU+cbsDIcPuaUAX3QTgF3/+IOf8o3x6heTpnM3KGnFJNmqdpERwfpLQdgso5tf
PFc+EpPlb4iIxfg/V4D9jjc6UQzvlblXZ2hdm/y6rimH9po8T+/BCCwUFAUtHnYTx+KiBrImwwFr
+1uN45/OEzgwIJ6AWXIto0L5BQy88fF0t9PV19kU/BzdFIZD+KY28TDNBhh6D/cn6uI+/XwwSlKH
vckfz7jjtgKl7XLnBxpxnE+46WxmyiOEwIpPyMeyrshUEV0H989HCKe0hEezt+N1ogM+TY5lxEXK
MvrIObgA6dBf0nbfBJEomURFGYycltWeLhBVrFB0BNeQQGeyr8OVxmbor6CPu3FSeDhs/0lAyEGF
KjvSgF9Vt8I1ueFLTfHgx52XZAvTZf3fuuO/p07ybzASUL6sHiTBFF+Y+NWQWbxy3I/1z9evP1rY
tlnJN3zf/7oZh4xKVnyRzTL/U9cT43cR/jtXxN2aqg0H27jsPvV9MlzUtTKHN+6nV7dhBPsdtoJJ
zUlqAv0Bkbl+en3mDzTslKb+dJm90GBPfhG2PipoGGrjJRDR0GS5D1O93r9PDX4m+mwJbZRdJBh7
wusHgG/Uw3Be9I3SX5YzipnhkF6vFMiYWY3OK/7ATgMYjilepg3FYq80RFWINBRPci+V8mC2KNo5
QvW2ZXv78xKj7aFonEcC467r/0OiamB4PagqP67VqoM1f7TMAabMssQ08ojlkria+VKiceZqBplp
EngL7egFv3jj3fFAPy/2enSFqX1xjcmQ00lEugOaMkjgGhnrlNjT4+la9jtPUf2DcXIuyYBwBrSr
rBaCman3Z340P9kN/uZUYcEpM7MB7tjdTa5tVz3joctQVw==
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
