// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Jan 27 14:12:21 2026
// Host        : work-dev running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/indata_ram/indata_ram_sim_netlist.v
// Design      : indata_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "indata_ram,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
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
  indata_ram_blk_mem_gen_v8_4_12 U0
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
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28672)
`pragma protect data_block
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
Qw==
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
