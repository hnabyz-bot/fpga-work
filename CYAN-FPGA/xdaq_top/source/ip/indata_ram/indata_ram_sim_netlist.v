// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.2 (lin64) Build 6060944 Thu Mar 06 19:10:09 MST 2025
// Date        : Fri Oct  3 09:03:48 2025
// Host        : drlinux running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/holee/fpga/git_work/CYAN-FPGA/xdaq_top/source/ip/indata_ram/indata_ram_sim_netlist.v
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
