#==============================================================================
# BLUE-HD-FPGA Waveform Configuration
#==============================================================================

# System Signals
add wave -divider "System"
add wave -format Logic /test_bench/MCLK_50M_p
add wave -format Logic /test_bench/nRST

# SPI Interface
add wave -divider "CPU SPI Interface"
add wave -format Logic /test_bench/SSB
add wave -format Logic /test_bench/SCLK
add wave -format Logic /test_bench/MOSI
add wave -format Logic /test_bench/MISO

# Sequencer FSM
add wave -divider "Sequencer FSM"
add wave -format Logic /test_bench/DUT/seq_fsm_inst/current_state
add wave -format Logic /test_bench/DUT/seq_fsm_inst/exp_req_o
add wave -format Logic /test_bench/DUT/seq_fsm_inst/acq_mode_i

# ROIC Interface (Channel 0 as example)
add wave -divider "ROIC CH0 LVDS"
add wave -format Logic /test_bench/DCLKP_0
add wave -format Logic /test_bench/FCLKP_0
add wave -format Logic /test_bench/DOUTP_0

# TI ROIC Top (Channel 0)
add wave -divider "TI ROIC CH0 Internal"
add wave -format Literal -radix hexadecimal /test_bench/DUT/gen_ti_roic_top[0].ti_roic_top_inst/data_out
add wave -format Logic /test_bench/DUT/gen_ti_roic_top[0].ti_roic_top_inst/data_valid

# Gate Drive
add wave -divider "Gate Drive"
add wave -format Logic /test_bench/GF_CPV
add wave -format Logic /test_bench/GF_OE
add wave -format Logic /test_bench/GF_STV_L
add wave -format Logic /test_bench/GF_STV_R

# MIPI CSI-2 Output
add wave -divider "MIPI CSI-2"
add wave -format Logic /test_bench/mipi_phy_if_clk_hs_p
add wave -format Logic /test_bench/mipi_phy_if_clk_lp_p

# LED Status
add wave -divider "Status"
add wave -format Logic /test_bench/STATE_LED1
add wave -format Logic /test_bench/STATE_LED2

# Configure wave window
configure wave -namecolwidth 300
configure wave -valuecolwidth 100
configure wave -signalnamewidth 1
WaveRestoreZoom {0 ps} {10 us}
