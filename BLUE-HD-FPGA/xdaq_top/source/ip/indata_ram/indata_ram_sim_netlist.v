// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Tue Jan 13 10:10:06 2026
// Host        : work-dev running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/indata_ram/indata_ram_sim_netlist.v
// Design      : indata_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "indata_ram,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
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
  indata_ram_blk_mem_gen_v8_4_9 U0
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
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

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
