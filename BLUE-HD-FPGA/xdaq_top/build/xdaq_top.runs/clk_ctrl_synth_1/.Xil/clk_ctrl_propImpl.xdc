set_property SRC_FILE_INFO {cfile:d:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/clk_ctrl/clk_ctrl.xdc rfile:../../../../source/ip/clk_ctrl/clk_ctrl.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.200
