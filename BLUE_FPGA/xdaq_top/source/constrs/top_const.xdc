
# timing constraints
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {U8_r/adc_indata_gen[*].adc_clk_inst_0}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U8_r/g_dclk_int_*]

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets clk_inst0/inst/clk_in1_clk_ctrl]

# pin map

#i2c
set_property PACKAGE_PIN N15 [get_ports scl_out]
set_property PACKAGE_PIN R17 [get_ports sda]
set_property IOSTANDARD LVCMOS25 [get_ports scl_out]
set_property IOSTANDARD LVCMOS25 [get_ports sda]
##

set_property PACKAGE_PIN T20 [get_ports nRST]
set_property IOSTANDARD LVCMOS25 [get_ports nRST]

#
set_property PACKAGE_PIN L3 [get_ports MCLK_50M_p]
set_property PACKAGE_PIN K3 [get_ports MCLK_50M_n]
set_property IOSTANDARD LVDS_25 [get_ports MCLK_50M_p]
set_property IOSTANDARD LVDS_25 [get_ports MCLK_50M_n]

# ROIC INTERFACE RIGHT

set_property PACKAGE_PIN U21 [get_ports ROIC_RESET_R]
set_property PACKAGE_PIN P19 [get_ports ROIC_ACLK_R]
set_property PACKAGE_PIN R19 [get_ports ROIC_SYNC_R]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_RESET_R]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_ACLK_R]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SYNC_R]

# ROIC INTERFACE RIGHT
set_property PACKAGE_PIN T19 [get_ports RF_SPI_CS_1]
set_property PACKAGE_PIN W21 [get_ports RF_SPI_SCK_1]
set_property PACKAGE_PIN W22 [get_ports RF_SPI_SDI_1]
set_property PACKAGE_PIN AA20 [get_ports RF_SPI_SDO_1]
set_property IOSTANDARD LVCMOS25 [get_ports RF_SPI_CS_1]
set_property IOSTANDARD LVCMOS25 [get_ports RF_SPI_SCK_1]
set_property IOSTANDARD LVCMOS25 [get_ports RF_SPI_SDI_1]
set_property IOSTANDARD LVCMOS25 [get_ports RF_SPI_SDO_1]

# GATE DRIVE
set_property PACKAGE_PIN Y18 [get_ports GF_STV_L]
set_property PACKAGE_PIN Y19 [get_ports GF_STV_LR1]
set_property PACKAGE_PIN V18 [get_ports GF_STV_LR2]
set_property PACKAGE_PIN V19 [get_ports GF_STV_LR3]
set_property PACKAGE_PIN AA19 [get_ports GF_STV_LR4]
set_property PACKAGE_PIN AB20 [get_ports GF_STV_LR5]
set_property PACKAGE_PIN V17 [get_ports GF_STV_LR6]
set_property PACKAGE_PIN W17 [get_ports GF_STV_LR7]
set_property PACKAGE_PIN AA18 [get_ports GF_STV_LR8]
set_property PACKAGE_PIN AB18 [get_ports GF_STV_LR9]
set_property PACKAGE_PIN U17 [get_ports GF_STV_R]

set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_L]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR1]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR2]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR3]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR4]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR5]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR6]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR7]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR8]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_LR9]
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_R]
#
set_property PACKAGE_PIN P16 [get_ports GF_CPV]
set_property PACKAGE_PIN N14 [get_ports GF_OE]
set_property IOSTANDARD LVCMOS25 [get_ports GF_CPV]
set_property IOSTANDARD LVCMOS25 [get_ports GF_OE]
#

#set_property PACKAGE_PIN U18 [get_ports GF_XAO_0]
set_property PACKAGE_PIN U18 [get_ports GF_XAO_1]
set_property PACKAGE_PIN P14 [get_ports GF_XAO_2]
set_property PACKAGE_PIN R14 [get_ports GF_XAO_3]
set_property PACKAGE_PIN R18 [get_ports GF_XAO_4]
set_property PACKAGE_PIN T18 [get_ports GF_XAO_5]
set_property PACKAGE_PIN N17 [get_ports GF_XAO_6]
set_property PACKAGE_PIN P17 [get_ports GF_XAO_7]
set_property PACKAGE_PIN P15 [get_ports GF_XAO_8]
#set_property PACKAGE_PIN R16 [get_ports GF_XAO_9]
#set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_0]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_1]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_2]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_3]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_4]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_5]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_6]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_7]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_8]
#set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_9]

set_property PACKAGE_PIN T21 [get_ports R_SW_BIAS]
set_property PACKAGE_PIN P20 [get_ports R_SW_AVDDI]
set_property IOSTANDARD LVCMOS25 [get_ports R_SW_BIAS]
set_property IOSTANDARD LVCMOS25 [get_ports R_SW_AVDDI]

# CPU TO FPGA
set_property PACKAGE_PIN H4 [get_ports SSB]
set_property PACKAGE_PIN G4 [get_ports SCLK]
set_property PACKAGE_PIN K4 [get_ports MOSI]
set_property PACKAGE_PIN J4 [get_ports MISO]

set_property IOSTANDARD LVCMOS25 [get_ports SSB]
set_property IOSTANDARD LVCMOS25 [get_ports SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports MOSI]
set_property IOSTANDARD LVCMOS25 [get_ports MISO]

#
set_property PACKAGE_PIN J16 [get_ports STATE_LED1]
#set_property PACKAGE_PIN M1 [get_ports F_SPARE_06]
#set_property PACKAGE_PIN J4 [get_ports F_SPARE_05]
#set_property PACKAGE_PIN K4 [get_ports F_SPARE_04]
#set_property PACKAGE_PIN G4 [get_ports F_SPARE_03]
#set_property PACKAGE_PIN H4 [get_ports F_SPARE_02]
#set_property PACKAGE_PIN G3 [get_ports F_SPARE_01]
#set_property PACKAGE_PIN H3 [get_ports F_SPARE_00]
set_property PACKAGE_PIN M17 [get_ports STATE_LED2]
set_property IOSTANDARD LVCMOS25 [get_ports STATE_LED1]
set_property IOSTANDARD LVCMOS25 [get_ports STATE_LED2]

# RESERVED
set_property PACKAGE_PIN F4 [get_ports exp_ack]
set_property PACKAGE_PIN H3 [get_ports exp_req]
set_property PACKAGE_PIN G3 [get_ports prep_ack]
set_property PACKAGE_PIN L6 [get_ports prep_req]
# set_property PACKAGE_PIN J4 [get_ports cancel_req]
set_property IOSTANDARD LVCMOS25 [get_ports exp_ack]
set_property IOSTANDARD LVCMOS25 [get_ports exp_req]
set_property IOSTANDARD LVCMOS25 [get_ports prep_ack]
set_property IOSTANDARD LVCMOS25 [get_ports prep_req]

# RF R
set_property PACKAGE_PIN B21 [get_ports {R_ROIC_DCLKo_p[11]}]
set_property PACKAGE_PIN E19 [get_ports {R_DOUTA_H[11]}]
set_property PACKAGE_PIN C22 [get_ports {R_DOUTB_H[11]}]

set_property PACKAGE_PIN E21 [get_ports {R_ROIC_DCLKo_p[10]}]
set_property PACKAGE_PIN F16 [get_ports {R_DOUTA_H[10]}]
set_property PACKAGE_PIN D20 [get_ports {R_DOUTB_H[10]}]

set_property PACKAGE_PIN H20 [get_ports {R_ROIC_DCLKo_p[9]}]
set_property PACKAGE_PIN E22 [get_ports {R_DOUTA_H[9]}]
set_property PACKAGE_PIN G21 [get_ports {R_DOUTB_H[9]}]

set_property PACKAGE_PIN J14 [get_ports {R_ROIC_DCLKo_p[8]}]
set_property PACKAGE_PIN F13 [get_ports {R_DOUTA_H[8]}]
set_property PACKAGE_PIN E16 [get_ports {R_DOUTB_H[8]}]

set_property PACKAGE_PIN F18 [get_ports {R_ROIC_DCLKo_p[7]}]
set_property PACKAGE_PIN J19 [get_ports {R_DOUTA_H[7]}]
set_property PACKAGE_PIN J20 [get_ports {R_DOUTB_H[7]}]

set_property PACKAGE_PIN F19 [get_ports {R_ROIC_DCLKo_p[6]}]
set_property PACKAGE_PIN K17 [get_ports {R_DOUTA_H[6]}]
set_property PACKAGE_PIN H17 [get_ports {R_DOUTB_H[6]}]

set_property PACKAGE_PIN K13 [get_ports {R_ROIC_DCLKo_p[5]}]
set_property PACKAGE_PIN H13 [get_ports {R_DOUTA_H[5]}]
set_property PACKAGE_PIN M13 [get_ports {R_DOUTB_H[5]}]

set_property PACKAGE_PIN L14 [get_ports {R_ROIC_DCLKo_p[4]}]
set_property PACKAGE_PIN M15 [get_ports {R_DOUTA_H[4]}]
set_property PACKAGE_PIN L16 [get_ports {R_DOUTB_H[4]}]

set_property PACKAGE_PIN K18 [get_ports {R_ROIC_DCLKo_p[3]}]
set_property PACKAGE_PIN J22 [get_ports {R_DOUTA_H[3]}]
set_property PACKAGE_PIN K21 [get_ports {R_DOUTB_H[3]}]

set_property PACKAGE_PIN M21 [get_ports {R_ROIC_DCLKo_p[2]}]
set_property PACKAGE_PIN M18 [get_ports {R_DOUTA_H[2]}]
set_property PACKAGE_PIN N18 [get_ports {R_DOUTB_H[2]}]

set_property PACKAGE_PIN G15 [get_ports {R_ROIC_DCLKo_p[1]}]
set_property PACKAGE_PIN G17 [get_ports {R_DOUTA_H[1]}]
set_property PACKAGE_PIN J15 [get_ports {R_DOUTB_H[1]}]

set_property PACKAGE_PIN N22 [get_ports {R_ROIC_DCLKo_p[0]}]
set_property PACKAGE_PIN N20 [get_ports {R_DOUTA_H[0]}]
set_property PACKAGE_PIN L19 [get_ports {R_DOUTB_H[0]}]

set_property PACKAGE_PIN F15 [get_ports DCLK_R]
set_property IOSTANDARD LVCMOS25 [get_ports DCLK_R]


# Set the bank voltage for IO Bank 35 to 1.8V by default.
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]]

# CSI2 MIPI pin map

# 1st
set_property PACKAGE_PIN B1 [get_ports mipi_phy_if_clk_hs_p]
set_property PACKAGE_PIN A1 [get_ports mipi_phy_if_clk_hs_n]
set_property IOSTANDARD LVDS_25 [get_ports mipi_phy_if_clk_hs_p]
set_property IOSTANDARD LVDS_25 [get_ports mipi_phy_if_clk_hs_n]

set_property PACKAGE_PIN G1 [get_ports {mipi_phy_if_data_hs_p[0]}]
set_property PACKAGE_PIN E2 [get_ports {mipi_phy_if_data_hs_p[1]}]
set_property PACKAGE_PIN E1 [get_ports {mipi_phy_if_data_hs_p[2]}]
set_property PACKAGE_PIN C2 [get_ports {mipi_phy_if_data_hs_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {mipi_phy_if_data_hs_p[*]}]

set_property PACKAGE_PIN F1 [get_ports {mipi_phy_if_data_hs_n[0]}]
set_property PACKAGE_PIN D2 [get_ports {mipi_phy_if_data_hs_n[1]}]
set_property PACKAGE_PIN D1 [get_ports {mipi_phy_if_data_hs_n[2]}]
set_property PACKAGE_PIN B2 [get_ports {mipi_phy_if_data_hs_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {mipi_phy_if_data_hs_n[*]}]

set_property PACKAGE_PIN F3 [get_ports mipi_phy_if_clk_lp_p]
set_property PACKAGE_PIN E3 [get_ports mipi_phy_if_clk_lp_n]
set_property IOSTANDARD LVCMOS25 [get_ports mipi_phy_if_clk_lp_p]
set_property IOSTANDARD LVCMOS25 [get_ports mipi_phy_if_clk_lp_n]

set_property PACKAGE_PIN J5 [get_ports {mipi_phy_if_data_lp_p[0]}]
set_property PACKAGE_PIN K2 [get_ports {mipi_phy_if_data_lp_p[1]}]
set_property PACKAGE_PIN H2 [get_ports {mipi_phy_if_data_lp_p[2]}]
set_property PACKAGE_PIN K1 [get_ports {mipi_phy_if_data_lp_p[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {mipi_phy_if_data_lp_p[*]}]

set_property PACKAGE_PIN H5 [get_ports {mipi_phy_if_data_lp_n[0]}]
set_property PACKAGE_PIN J2 [get_ports {mipi_phy_if_data_lp_n[1]}]
set_property PACKAGE_PIN G2 [get_ports {mipi_phy_if_data_lp_n[2]}]
set_property PACKAGE_PIN J1 [get_ports {mipi_phy_if_data_lp_n[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {mipi_phy_if_data_lp_n[*]}]


#SPI Flash memory set
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]

