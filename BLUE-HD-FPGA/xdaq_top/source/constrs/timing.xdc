#==============================================================================
# Additional Timing Constraints for BLUE-HD-FPGA
#==============================================================================

#------------------------------------------------------------------------------
# Internal Generated Clocks - False Paths
#------------------------------------------------------------------------------
# These clocks are generated from flip-flops and are asynchronous to main clock

## DC-DC Clock (5 MHz derived from system clock)
#set_false_path -from [get_pins dcdc_clk_inst/clk_5M_o_reg/Q]

## Bit Clock Module generated clocks (14 channels)
## mod_clkdiv4 is a clock divider output used for deserializer timing
#set_false_path -from [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/bit_clock_gen/mod_clkdiv4_reg[*]/Q}]

## Reset synchronizer
#set_false_path -from [get_pins rst_reg/Q]

## Sequencer FSM async signals
#set_false_path -from [get_pins {seq_fsm_inst/s_acq_mode_i_reg[*]/Q}]
#set_false_path -from [get_pins {seq_fsm_inst/s_config_done_dly_reg[*]/Q}]

#------------------------------------------------------------------------------
# Cross-Clock Domain Paths
#------------------------------------------------------------------------------
# Sync register chain paths
set_false_path -from [get_pins {s_sync_current_repeat_count_o_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/D}]

# ROIC timing generator to data reorder
set_false_path -from [get_pins {roic_tg_gen_int/counter_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/CLR}]

##------------------------------------------------------------------------------
## Input/Output Delays (for ports without false_path)
##------------------------------------------------------------------------------
## SPI Interface (quasi-static, slow signals)
#set_input_delay -clock [get_clocks MCLK_50M] -min 2.0 [get_ports SSB]
#set_input_delay -clock [get_clocks MCLK_50M] -max 8.0 [get_ports SSB]
#set_input_delay -clock [get_clocks MCLK_50M] -min 2.0 [get_ports SCLK]
#set_input_delay -clock [get_clocks MCLK_50M] -max 8.0 [get_ports SCLK]
#set_input_delay -clock [get_clocks MCLK_50M] -min 2.0 [get_ports MOSI]
#set_input_delay -clock [get_clocks MCLK_50M] -max 8.0 [get_ports MOSI]

#set_output_delay -clock [get_clocks MCLK_50M] -min 2.0 [get_ports MISO]
#set_output_delay -clock [get_clocks MCLK_50M] -max 8.0 [get_ports MISO]

