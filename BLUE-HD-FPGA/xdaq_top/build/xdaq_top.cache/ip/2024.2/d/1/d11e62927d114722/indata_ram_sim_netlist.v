// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Tue Jan 13 10:10:05 2026
// Host        : work-dev running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ indata_ram_sim_netlist.v
// Design      : indata_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "indata_ram,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_9 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27328)
`pragma protect data_block
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
hZ+JS3ThKAaVYpdty8fxNxUR0IcVg3p+zA==
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
