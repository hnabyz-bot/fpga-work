################################################################################
# blue_hd_top.xdc - Pin Constraints and Timing for BLUE-HD FPGA Project
################################################################################
# Target Board     : BLUE-HD (Cyan HD Board, 100um design)
# FPGA Device      : XC7A35T-FGG484 (Artix-7)
# Vivado Version   : 2025.2
# Description      : Converted from cyan_hd_top.xdc for blue_hd_top.sv
#
# Pin Mapping Reference: 100um_xc7a35tfgg484_Pinmap.xlsx
################################################################################

#==============================================================================
# TIMING CONSTRAINTS
#==============================================================================

#------------------------------------------------------------------------------
# System Clock (50 MHz LVDS input)
#------------------------------------------------------------------------------
# NOTE: Clock Wizard IP generates derived clocks automatically
# Primary clock is handled by Clock Wizard IP

#------------------------------------------------------------------------------
# TI ROIC LVDS Interface Clocks (14 channels)
#------------------------------------------------------------------------------
# DCLK (Data Clock)   : 2.34 MHz (427.35 ns period) from TI ROIC datasheet
# FCLK (Frame Clock)  : Same frequency as DCLK, used for frame synchronization
# NOTE: These clocks are asynchronous to main system clock domain

# DCLK Channels 0-13 (2.34 MHz = 427.35 ns period)
create_clock -period 427.350 -name DCLK_0  [get_ports {DCLKP[0]}]
create_clock -period 427.350 -name DCLK_1  [get_ports {DCLKP[1]}]
create_clock -period 427.350 -name DCLK_2  [get_ports {DCLKP[2]}]
create_clock -period 427.350 -name DCLK_3  [get_ports {DCLKP[3]}]
create_clock -period 427.350 -name DCLK_4  [get_ports {DCLKP[4]}]
create_clock -period 427.350 -name DCLK_5  [get_ports {DCLKP[5]}]
create_clock -period 427.350 -name DCLK_6  [get_ports {DCLKP[6]}]
create_clock -period 427.350 -name DCLK_7  [get_ports {DCLKP[7]}]
create_clock -period 427.350 -name DCLK_8  [get_ports {DCLKP[8]}]
create_clock -period 427.350 -name DCLK_9  [get_ports {DCLKP[9]}]
create_clock -period 427.350 -name DCLK_10 [get_ports {DCLKP[10]}]
create_clock -period 427.350 -name DCLK_11 [get_ports {DCLKP[11]}]
create_clock -period 427.350 -name DCLK_12 [get_ports {DCLKP[12]}]
create_clock -period 427.350 -name DCLK_13 [get_ports {DCLKP[13]}]

# FCLK Channels 0-13 (Frame Clock, same frequency)
create_clock -period 427.350 -name FCLK_0  [get_ports {FCLKP[0]}]
create_clock -period 427.350 -name FCLK_1  [get_ports {FCLKP[1]}]
create_clock -period 427.350 -name FCLK_2  [get_ports {FCLKP[2]}]
create_clock -period 427.350 -name FCLK_3  [get_ports {FCLKP[3]}]
create_clock -period 427.350 -name FCLK_4  [get_ports {FCLKP[4]}]
create_clock -period 427.350 -name FCLK_5  [get_ports {FCLKP[5]}]
create_clock -period 427.350 -name FCLK_6  [get_ports {FCLKP[6]}]
create_clock -period 427.350 -name FCLK_7  [get_ports {FCLKP[7]}]
create_clock -period 427.350 -name FCLK_8  [get_ports {FCLKP[8]}]
create_clock -period 427.350 -name FCLK_9  [get_ports {FCLKP[9]}]
create_clock -period 427.350 -name FCLK_10 [get_ports {FCLKP[10]}]
create_clock -period 427.350 -name FCLK_11 [get_ports {FCLKP[11]}]
create_clock -period 427.350 -name FCLK_12 [get_ports {FCLKP[12]}]
create_clock -period 427.350 -name FCLK_13 [get_ports {FCLKP[13]}]

#------------------------------------------------------------------------------
# Asynchronous Clock Groups
#------------------------------------------------------------------------------
# DCLK/FCLK channels are asynchronous to main system clock and to each other
# Uncomment below if needed for CDC analysis
#set_clock_groups -asynchronous \
#    -group [get_clocks MCLK_50M] \
#    -group [get_clocks {DCLK_0 FCLK_0}] \
#    -group [get_clocks {DCLK_1 FCLK_1}] \
#    -group [get_clocks {DCLK_2 FCLK_2}] \
#    -group [get_clocks {DCLK_3 FCLK_3}] \
#    -group [get_clocks {DCLK_4 FCLK_4}] \
#    -group [get_clocks {DCLK_5 FCLK_5}] \
#    -group [get_clocks {DCLK_6 FCLK_6}] \
#    -group [get_clocks {DCLK_7 FCLK_7}] \
#    -group [get_clocks {DCLK_8 FCLK_8}] \
#    -group [get_clocks {DCLK_9 FCLK_9}] \
#    -group [get_clocks {DCLK_10 FCLK_10}] \
#    -group [get_clocks {DCLK_11 FCLK_11}] \
#    -group [get_clocks {DCLK_12 FCLK_12}] \
#    -group [get_clocks {DCLK_13 FCLK_13}]

#------------------------------------------------------------------------------
# False Path Constraints
#------------------------------------------------------------------------------
# LVDS Data Input - data signals (not clocks)
set_false_path -from [get_ports DOUTP_*]
set_false_path -from [get_ports DOUTN_*]

# Reset signal is quasi-static
set_false_path -from [get_ports nRST]

#------------------------------------------------------------------------------
# Clock Routing Exceptions
#------------------------------------------------------------------------------
# MCLK 50M - Allow non-dedicated routing due to pin location constraints
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_inst0/inst/clk_in1_clk_ctrl]

# FCLK signals - Allow non-dedicated routing
# NOTE: FCLK pins are not on clock-capable IOs, but sampled by BUFG
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[0].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[1].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[2].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[3].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[4].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[5].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[6].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[7].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[8].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[9].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[10].ti_roic_top_inst/bit_clock_gen/fclk_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[11].ti_roic_top_inst/bit_clock_gen/fclk_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[12].ti_roic_top_inst/bit_clock_gen/fclk_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets gen_ti_roic_top[13].ti_roic_top_inst/bit_clock_gen/fclk_out]

#==============================================================================
# PIN MAPPING - SYSTEM & CONTROL SIGNALS
#==============================================================================

#------------------------------------------------------------------------------
# System Reset
#------------------------------------------------------------------------------
set_property PACKAGE_PIN T20 [get_ports nRST]
set_property IOSTANDARD LVCMOS25 [get_ports nRST]

#------------------------------------------------------------------------------
# System Clock (50 MHz LVDS input)
#------------------------------------------------------------------------------
set_property PACKAGE_PIN L3 [get_ports MCLK_50M_p]
set_property PACKAGE_PIN K3 [get_ports MCLK_50M_n]
set_property IOSTANDARD LVDS_25 [get_ports MCLK_50M_p]
set_property IOSTANDARD LVDS_25 [get_ports MCLK_50M_n]

#------------------------------------------------------------------------------
# CPU SPI Interface (Control Interface)
#------------------------------------------------------------------------------
# NOTE: Bank 35 - Must use LVCMOS25 to match MIPI HS signals (DIFF_HSTL_II_18 @ 1.8V)
set_property PACKAGE_PIN H4 [get_ports SSB]
set_property PACKAGE_PIN G4 [get_ports SCLK]
set_property PACKAGE_PIN K4 [get_ports MOSI]
set_property PACKAGE_PIN J4 [get_ports MISO]

set_property IOSTANDARD LVCMOS25 [get_ports SSB]
set_property IOSTANDARD LVCMOS25 [get_ports SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports MOSI]
set_property IOSTANDARD LVCMOS25 [get_ports MISO]

#------------------------------------------------------------------------------
# LEDs
#------------------------------------------------------------------------------
set_property PACKAGE_PIN J16 [get_ports STATE_LED1]
set_property PACKAGE_PIN M17 [get_ports STATE_LED2]
set_property IOSTANDARD LVCMOS25 [get_ports STATE_LED1]
set_property IOSTANDARD LVCMOS25 [get_ports STATE_LED2]

#------------------------------------------------------------------------------
# Debug Signals
#------------------------------------------------------------------------------
# NOTE: Bank 35 - Must use LVCMOS25 to match MIPI HS signals
set_property PACKAGE_PIN M1 [get_ports {DEBUG_SiG[0]}]
set_property PACKAGE_PIN L1 [get_ports {DEBUG_SiG[1]}]
set_property PACKAGE_PIN N2 [get_ports {DEBUG_SiG[2]}]
set_property PACKAGE_PIN M2 [get_ports {DEBUG_SiG[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {DEBUG_SiG[*]}]

#------------------------------------------------------------------------------
# Trigger Signals (Reserved)
#------------------------------------------------------------------------------
# NOTE: Bank 35 - Must use LVCMOS25 to match MIPI HS signals
set_property PACKAGE_PIN F4 [get_ports EXP_ACK]
set_property PACKAGE_PIN H3 [get_ports EXP_REQ]
set_property PACKAGE_PIN G3 [get_ports PREP_ACK]
set_property PACKAGE_PIN L6 [get_ports PREP_REQ]
set_property IOSTANDARD LVCMOS25 [get_ports EXP_ACK]
set_property IOSTANDARD LVCMOS25 [get_ports EXP_REQ]
set_property IOSTANDARD LVCMOS25 [get_ports PREP_ACK]
set_property IOSTANDARD LVCMOS25 [get_ports PREP_REQ]

#==============================================================================
# PIN MAPPING - ROIC INTERFACE
#==============================================================================

#------------------------------------------------------------------------------
# ROIC Control Signals
#------------------------------------------------------------------------------
set_property PACKAGE_PIN U21 [get_ports ROIC_TP_SEL]
set_property PACKAGE_PIN P19 [get_ports ROIC_SYNC]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_TP_SEL]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SYNC]

#------------------------------------------------------------------------------
# ROIC SPI (14 channels for chip enable)
#------------------------------------------------------------------------------
# SPI Signals
set_property PACKAGE_PIN AA20 [get_ports ROIC_SPI_SCK]
set_property PACKAGE_PIN W22  [get_ports ROIC_SPI_SDI]
set_property PACKAGE_PIN W21  [get_ports ROIC_SPI_SDO]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SPI_SCK]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SPI_SDI]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SPI_SDO]

# SPI Chip Enable Array [11:0] (12 channels active)
# Note: Channels 12-13 are commented out (not used)
set_property PACKAGE_PIN R6  [get_ports {ROIC_SPI_SEN_N[0]}]
set_property PACKAGE_PIN T6  [get_ports {ROIC_SPI_SEN_N[1]}]
set_property PACKAGE_PIN U6  [get_ports {ROIC_SPI_SEN_N[2]}]
set_property PACKAGE_PIN V5  [get_ports {ROIC_SPI_SEN_N[3]}]
set_property PACKAGE_PIN Y6  [get_ports {ROIC_SPI_SEN_N[4]}]
set_property PACKAGE_PIN AA6 [get_ports {ROIC_SPI_SEN_N[5]}]
set_property PACKAGE_PIN U3  [get_ports {ROIC_SPI_SEN_N[6]}]
set_property PACKAGE_PIN V3  [get_ports {ROIC_SPI_SEN_N[7]}]
set_property PACKAGE_PIN T5  [get_ports {ROIC_SPI_SEN_N[8]}]
set_property PACKAGE_PIN U5  [get_ports {ROIC_SPI_SEN_N[9]}]
set_property PACKAGE_PIN W2  [get_ports {ROIC_SPI_SEN_N[10]}]
set_property PACKAGE_PIN Y2  [get_ports {ROIC_SPI_SEN_N[11]}]
#set_property PACKAGE_PIN AA5 [get_ports {ROIC_SPI_SEN_N[12]}]
#set_property PACKAGE_PIN AB5 [get_ports {ROIC_SPI_SEN_N[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ROIC_SPI_SEN_N[*]}]

#------------------------------------------------------------------------------
# ROIC Power Control
#------------------------------------------------------------------------------
set_property PACKAGE_PIN T21 [get_ports ROIC_AVDD2]
set_property PACKAGE_PIN P20 [get_ports ROIC_AVDD1]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_AVDD2]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_AVDD1]

#------------------------------------------------------------------------------
# ROIC Clock Outputs
#------------------------------------------------------------------------------
set_property PACKAGE_PIN F15 [get_ports ROIC_MCLK0]
set_property PACKAGE_PIN T3  [get_ports ROIC_MCLK1]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_MCLK0]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_MCLK1]

#==============================================================================
# PIN MAPPING - GATE DRIVE
#==============================================================================

#------------------------------------------------------------------------------
# Gate Drive STV Signals (Left/Right Control)
#------------------------------------------------------------------------------
set_property PACKAGE_PIN Y18 [get_ports GF_STV_L]
set_property PACKAGE_PIN Y19 [get_ports GF_STV_LR1]
set_property PACKAGE_PIN V18 [get_ports GF_STV_LR2]
set_property PACKAGE_PIN V19 [get_ports GF_STV_LR3]
set_property PACKAGE_PIN AA19 [get_ports GF_STV_LR4]
set_property PACKAGE_PIN AB20 [get_ports GF_STV_LR5]
set_property PACKAGE_PIN V17 [get_ports GF_STV_LR6]
set_property PACKAGE_PIN W17 [get_ports GF_STV_LR7]
set_property PACKAGE_PIN AA18 [get_ports GF_STV_LR8]
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
set_property IOSTANDARD LVCMOS25 [get_ports GF_STV_R]

#------------------------------------------------------------------------------
# Gate Drive Control Signals
#------------------------------------------------------------------------------
set_property PACKAGE_PIN P16 [get_ports GF_CPV]
set_property PACKAGE_PIN N14 [get_ports GF_OE]
set_property IOSTANDARD LVCMOS25 [get_ports GF_CPV]
set_property IOSTANDARD LVCMOS25 [get_ports GF_OE]

#------------------------------------------------------------------------------
# Gate Drive XAO Signals (Phase Control)
#------------------------------------------------------------------------------
# NOTE: Signals are numbered 1-8 (no _0 or _9)
set_property PACKAGE_PIN U18 [get_ports GF_XAO_1]
set_property PACKAGE_PIN P14 [get_ports GF_XAO_2]
set_property PACKAGE_PIN R14 [get_ports GF_XAO_3]
set_property PACKAGE_PIN R18 [get_ports GF_XAO_4]
set_property PACKAGE_PIN T18 [get_ports GF_XAO_5]
set_property PACKAGE_PIN N17 [get_ports GF_XAO_6]
set_property PACKAGE_PIN P17 [get_ports GF_XAO_7]
set_property PACKAGE_PIN P15 [get_ports GF_XAO_8]

set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_1]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_2]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_3]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_4]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_5]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_6]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_7]
set_property IOSTANDARD LVCMOS25 [get_ports GF_XAO_8]

#==============================================================================
# PIN MAPPING - TI ROIC LVDS CHANNELS (14 channels: 0-13)
#==============================================================================

#------------------------------------------------------------------------------
# Channel 0
#------------------------------------------------------------------------------
set_property PACKAGE_PIN L19 [get_ports {DCLKP[0]}]
set_property PACKAGE_PIN L20 [get_ports {DCLKN[0]}]
set_property PACKAGE_PIN N20 [get_ports {FCLKP[0]}]
set_property PACKAGE_PIN M20 [get_ports {FCLKN[0]}]
set_property PACKAGE_PIN N22 [get_ports {DOUTP[0]}]
set_property PACKAGE_PIN M22 [get_ports {DOUTN[0]}]

#------------------------------------------------------------------------------
# Channel 1
#------------------------------------------------------------------------------
set_property PACKAGE_PIN J15 [get_ports {DCLKP[1]}]
set_property PACKAGE_PIN H15 [get_ports {DCLKN[1]}]
set_property PACKAGE_PIN G17 [get_ports {FCLKP[1]}]
set_property PACKAGE_PIN G18 [get_ports {FCLKN[1]}]
set_property PACKAGE_PIN G15 [get_ports {DOUTP[1]}]
set_property PACKAGE_PIN G16 [get_ports {DOUTN[1]}]

#------------------------------------------------------------------------------
# Channel 2
#------------------------------------------------------------------------------
set_property PACKAGE_PIN N18 [get_ports {DCLKP[2]}]
set_property PACKAGE_PIN N19 [get_ports {DCLKN[2]}]
set_property PACKAGE_PIN M18 [get_ports {FCLKP[2]}]
set_property PACKAGE_PIN L18 [get_ports {FCLKN[2]}]
set_property PACKAGE_PIN M21 [get_ports {DOUTP[2]}]
set_property PACKAGE_PIN L21 [get_ports {DOUTN[2]}]

#------------------------------------------------------------------------------
# Channel 3
#------------------------------------------------------------------------------
set_property PACKAGE_PIN K21 [get_ports {DCLKP[3]}]
set_property PACKAGE_PIN K22 [get_ports {DCLKN[3]}]
set_property PACKAGE_PIN J22 [get_ports {FCLKP[3]}]
set_property PACKAGE_PIN H22 [get_ports {FCLKN[3]}]
set_property PACKAGE_PIN K18 [get_ports {DOUTP[3]}]
set_property PACKAGE_PIN K19 [get_ports {DOUTN[3]}]

#------------------------------------------------------------------------------
# Channel 4
#------------------------------------------------------------------------------
set_property PACKAGE_PIN L16 [get_ports {DCLKP[4]}]
set_property PACKAGE_PIN K16 [get_ports {DCLKN[4]}]
set_property PACKAGE_PIN M15 [get_ports {FCLKP[4]}]
set_property PACKAGE_PIN M16 [get_ports {FCLKN[4]}]
set_property PACKAGE_PIN L14 [get_ports {DOUTP[4]}]
set_property PACKAGE_PIN L15 [get_ports {DOUTN[4]}]

#------------------------------------------------------------------------------
# Channel 5
#------------------------------------------------------------------------------
set_property PACKAGE_PIN M13 [get_ports {DCLKP[5]}]
set_property PACKAGE_PIN L13 [get_ports {DCLKN[5]}]
set_property PACKAGE_PIN H13 [get_ports {FCLKP[5]}]
set_property PACKAGE_PIN G13 [get_ports {FCLKN[5]}]
set_property PACKAGE_PIN K13 [get_ports {DOUTP[5]}]
set_property PACKAGE_PIN K14 [get_ports {DOUTN[5]}]

#------------------------------------------------------------------------------
# Channel 6
#------------------------------------------------------------------------------
set_property PACKAGE_PIN H17 [get_ports {DCLKP[6]}]
set_property PACKAGE_PIN H18 [get_ports {DCLKN[6]}]
set_property PACKAGE_PIN K17 [get_ports {FCLKP[6]}]
set_property PACKAGE_PIN J17 [get_ports {FCLKN[6]}]
set_property PACKAGE_PIN F19 [get_ports {DOUTP[6]}]
set_property PACKAGE_PIN F20 [get_ports {DOUTN[6]}]

#------------------------------------------------------------------------------
# Channel 7
#------------------------------------------------------------------------------
set_property PACKAGE_PIN J20 [get_ports {DCLKP[7]}]
set_property PACKAGE_PIN J21 [get_ports {DCLKN[7]}]
set_property PACKAGE_PIN J19 [get_ports {FCLKP[7]}]
set_property PACKAGE_PIN H19 [get_ports {FCLKN[7]}]
set_property PACKAGE_PIN F18 [get_ports {DOUTP[7]}]
set_property PACKAGE_PIN E18 [get_ports {DOUTN[7]}]

#------------------------------------------------------------------------------
# Channel 8
#------------------------------------------------------------------------------
set_property PACKAGE_PIN E16 [get_ports {DCLKP[8]}]
set_property PACKAGE_PIN D16 [get_ports {DCLKN[8]}]
set_property PACKAGE_PIN F13 [get_ports {FCLKP[8]}]
set_property PACKAGE_PIN F14 [get_ports {FCLKN[8]}]
set_property PACKAGE_PIN J14 [get_ports {DOUTP[8]}]
set_property PACKAGE_PIN H14 [get_ports {DOUTN[8]}]

#------------------------------------------------------------------------------
# Channel 9
#------------------------------------------------------------------------------
set_property PACKAGE_PIN G21 [get_ports {DCLKP[9]}]
set_property PACKAGE_PIN G22 [get_ports {DCLKN[9]}]
set_property PACKAGE_PIN E22 [get_ports {FCLKP[9]}]
set_property PACKAGE_PIN D22 [get_ports {FCLKN[9]}]
set_property PACKAGE_PIN H20 [get_ports {DOUTP[9]}]
set_property PACKAGE_PIN G20 [get_ports {DOUTN[9]}]

#------------------------------------------------------------------------------
# Channel 10
#------------------------------------------------------------------------------
set_property PACKAGE_PIN D20 [get_ports {DCLKP[10]}]
set_property PACKAGE_PIN C20 [get_ports {DCLKN[10]}]
set_property PACKAGE_PIN F16 [get_ports {FCLKP[10]}]
set_property PACKAGE_PIN E17 [get_ports {FCLKN[10]}]
set_property PACKAGE_PIN E21 [get_ports {DOUTP[10]}]
set_property PACKAGE_PIN D21 [get_ports {DOUTN[10]}]

#------------------------------------------------------------------------------
# Channel 11
#------------------------------------------------------------------------------
set_property PACKAGE_PIN C22 [get_ports {DCLKP[11]}]
set_property PACKAGE_PIN B22 [get_ports {DCLKN[11]}]
set_property PACKAGE_PIN E19 [get_ports {FCLKP[11]}]
set_property PACKAGE_PIN D19 [get_ports {FCLKN[11]}]
set_property PACKAGE_PIN B21 [get_ports {DOUTP[11]}]
set_property PACKAGE_PIN A21 [get_ports {DOUTN[11]}]

#------------------------------------------------------------------------------
# Channel 12
#------------------------------------------------------------------------------
set_property PACKAGE_PIN AA8 [get_ports {DCLKP[12]}]
set_property PACKAGE_PIN AB8 [get_ports {DCLKN[12]}]
set_property PACKAGE_PIN Y8  [get_ports {FCLKP[12]}]
set_property PACKAGE_PIN Y7  [get_ports {FCLKN[12]}]
set_property PACKAGE_PIN W9  [get_ports {DOUTP[12]}]
set_property PACKAGE_PIN Y9  [get_ports {DOUTN[12]}]

#------------------------------------------------------------------------------
# Channel 13
#------------------------------------------------------------------------------
set_property PACKAGE_PIN V7  [get_ports {DCLKP[13]}]
set_property PACKAGE_PIN W7  [get_ports {DCLKN[13]}]
set_property PACKAGE_PIN AB7 [get_ports {FCLKP[13]}]
set_property PACKAGE_PIN AB6 [get_ports {FCLKN[13]}]
set_property PACKAGE_PIN V9  [get_ports {DOUTP[13]}]
set_property PACKAGE_PIN V8  [get_ports {DOUTN[13]}]

#------------------------------------------------------------------------------
# LVDS IOSTANDARD (all channels)
#------------------------------------------------------------------------------
set_property IOSTANDARD LVDS_25 [get_ports DCLKP_*]
set_property IOSTANDARD LVDS_25 [get_ports DCLKN_*]
set_property IOSTANDARD LVDS_25 [get_ports FCLKP_*]
set_property IOSTANDARD LVDS_25 [get_ports FCLKN_*]
set_property IOSTANDARD LVDS_25 [get_ports DOUTP_*]
set_property IOSTANDARD LVDS_25 [get_ports DOUTN_*]

#==============================================================================
# PIN MAPPING - MIPI CSI-2 INTERFACE
#==============================================================================

#------------------------------------------------------------------------------
# MIPI D-PHY High-Speed (HS) Differential Pairs
#------------------------------------------------------------------------------
# NOTE: MIPI D-PHY IP manages HS signals automatically using OSERDES + OBUFTDS
# The IP sets IO_BUFFER_TYPE = NONE and manages differential signaling internally
# LVDS_25 IOSTANDARD is applied here for proper buffer inference

# MIPI HS Clock Pair
set_property PACKAGE_PIN B1 [get_ports mipi_phy_if_clk_hs_p]
set_property PACKAGE_PIN A1 [get_ports mipi_phy_if_clk_hs_n]
set_property IOSTANDARD LVDS_25 [get_ports mipi_phy_if_clk_hs_p]
set_property IOSTANDARD LVDS_25 [get_ports mipi_phy_if_clk_hs_n]

# MIPI HS Data Lanes [3:0] - Positive
set_property PACKAGE_PIN G1 [get_ports {mipi_phy_if_data_hs_p[0]}]
set_property PACKAGE_PIN E2 [get_ports {mipi_phy_if_data_hs_p[1]}]
set_property PACKAGE_PIN E1 [get_ports {mipi_phy_if_data_hs_p[2]}]
set_property PACKAGE_PIN C2 [get_ports {mipi_phy_if_data_hs_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {mipi_phy_if_data_hs_p[*]}]

# MIPI HS Data Lanes [3:0] - Negative
set_property PACKAGE_PIN F1 [get_ports {mipi_phy_if_data_hs_n[0]}]
set_property PACKAGE_PIN D2 [get_ports {mipi_phy_if_data_hs_n[1]}]
set_property PACKAGE_PIN D1 [get_ports {mipi_phy_if_data_hs_n[2]}]
set_property PACKAGE_PIN B2 [get_ports {mipi_phy_if_data_hs_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {mipi_phy_if_data_hs_n[*]}]

#------------------------------------------------------------------------------
# MIPI D-PHY Low-Power (LP) Single-Ended Signals
#------------------------------------------------------------------------------
# NOTE: Bank 35 - Must use LVCMOS25 to match MIPI HS signals (DIFF_HSTL_II_18 @ 1.8V)

# MIPI LP Clock Pair
set_property PACKAGE_PIN F3 [get_ports mipi_phy_if_clk_lp_p]
set_property PACKAGE_PIN E3 [get_ports mipi_phy_if_clk_lp_n]
set_property IOSTANDARD LVCMOS25 [get_ports mipi_phy_if_clk_lp_p]
set_property IOSTANDARD LVCMOS25 [get_ports mipi_phy_if_clk_lp_n]

# MIPI LP Data Lanes [3:0] - Positive
set_property PACKAGE_PIN J5 [get_ports {mipi_phy_if_data_lp_p[0]}]
set_property PACKAGE_PIN K2 [get_ports {mipi_phy_if_data_lp_p[1]}]
set_property PACKAGE_PIN H2 [get_ports {mipi_phy_if_data_lp_p[2]}]
set_property PACKAGE_PIN K1 [get_ports {mipi_phy_if_data_lp_p[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {mipi_phy_if_data_lp_p[*]}]

# MIPI LP Data Lanes [3:0] - Negative
set_property PACKAGE_PIN H5 [get_ports {mipi_phy_if_data_lp_n[0]}]
set_property PACKAGE_PIN J2 [get_ports {mipi_phy_if_data_lp_n[1]}]
set_property PACKAGE_PIN G2 [get_ports {mipi_phy_if_data_lp_n[2]}]
set_property PACKAGE_PIN J1 [get_ports {mipi_phy_if_data_lp_n[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {mipi_phy_if_data_lp_n[*]}]

#==============================================================================
# SPI FLASH CONFIGURATION
#==============================================================================

set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]

################################################################################
# END OF CONSTRAINTS FILE
################################################################################
