#set_false_path -from [get_pins {}] -to [get_pins {}]
#set_false_path -from [get_pins {}] -to [get_pins {}]

#set_false_path -from [get_pins {}] -to [get_pins {}]
#set_false_path -from [get_pins {}] -to [get_pins {}]

#set_false_path -from [get_pins {roic_tg_gen_int/DF_SM4_fall_reg[6]/C}] -to [get_pins roic_tg_gen_int/DF_SM4_reg/D]
#set_false_path -from [get_pins {roic_tg_gen_int/LPF2_rise_reg[6]/C}] -to [get_pins roic_tg_gen_int/LPF2_reg/D]
#set_false_path -from [get_pins {seq_fsm_inst/current_repeat_count_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/D}]
#set_false_path -from [get_pins {seq_fsm_inst/active_repeat_count_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/D}]
#set_false_path -from [get_pins {reg_map_inst/reg_max_h_count_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/D}]
#set_false_path -from [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/even_odd_toggle_2d_reg/C}] -to [get_pins {read_data_mux_inst/read_data_out_b_reg[*]/D}]
set_false_path -from [get_pins {s_sync_current_repeat_count_o_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/D}]

set_false_path -from [get_pins {roic_tg_gen_int/counter_reg[*]/C}] -to [get_pins {gen_ti_roic_top[*].ti_roic_top_inst/data_reorder/read_req_dly_reg[*]/CLR}]

# set_false_path -from [get_pins {}] -to [get_pins {}]
#set_false_path -from [get_pins {}] -to [get_pins {}]
#set_false_path -from [get_pins {}] -to [get_pins {}]

