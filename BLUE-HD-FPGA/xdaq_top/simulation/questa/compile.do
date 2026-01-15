#==============================================================================
# BLUE-HD-FPGA Questa Compilation Script
#==============================================================================
# Usage: vsim -do compile.do
# Or: source compile.do (from vsim prompt)
#==============================================================================

puts "============================================================"
puts "BLUE-HD-FPGA Compilation Script"
puts "============================================================"

# Create work library
if {[file exists work]} {
    vdel -lib work -all
}
vlib work
vmap work work

# Set include path
set INCLUDE_PATH "+incdir+../../source/hdl"
set SV_OPTS "-sv $INCLUDE_PATH"

puts "\n--- Compiling Parameter Definitions ---"
vlog $SV_OPTS ../../source/hdl/p_define.sv

puts "\n--- Compiling Xilinx Simulation Libraries ---"
# Xilinx primitive library (glbl.v)
# Note: Requires Xilinx simulation library compiled with compile_simlib
# If not available, use the following command in Vivado:
#   compile_simlib -simulator questa -directory <path> -library all

puts "\n--- Compiling IP Core Simulation Models ---"
vlog ../../source/ip/clk_ctrl/clk_ctrl_sim_netlist.v
vlog ../../source/ip/seq_lut/seq_lut_sim_netlist.v
vlog ../../source/ip/indata_ram/indata_ram_sim_netlist.v

puts "\n--- Compiling TI ROIC Interface Modules ---"
vlog $SV_OPTS ../../source/hdl/ti-roic/bit_clock_module.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/deser_single.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/bit_align.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/first_ch_detector.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/indata_reorder.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/roic_spi.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/ti_roic_tg.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/ti_roic_top.sv

puts "\n--- Compiling Common Modules ---"
vlog $SV_OPTS ../../source/hdl/fifo_1b.sv
vlog $SV_OPTS ../../source/hdl/async_fifo_1b.sv
vlog $SV_OPTS ../../source/hdl/dcdc_clk.sv
vlog $SV_OPTS ../../source/hdl/spi_slave.sv
vlog $SV_OPTS ../../source/hdl/i2c_master.sv
vlog $SV_OPTS ../../source/hdl/init.sv
vlog $SV_OPTS ../../source/hdl/reg_map.sv
vlog $SV_OPTS ../../source/hdl/sequencer_fsm.sv
vlog $SV_OPTS ../../source/hdl/roic_gate_drv.sv
vlog $SV_OPTS ../../source/hdl/read_data_mux.sv

puts "\n--- Compiling MIPI CSI-2 Modules ---"
vlog $SV_OPTS ../../source/hdl/csi2/mipi_csi2_tx_bd.sv
vlog $SV_OPTS ../../source/hdl/csi2/mipi_csi2_tx_top.sv
vlog ../../source/hdl/csi2/ip/mipi_csi2_tx_subsys/mipi_csi2_tx_subsys_sim_netlist.v
vlog ../../source/hdl/csi2/ip/mipi_init_gen/mipi_init_gen_sim_netlist.v
vlog ../../source/hdl/csi2/ip/axis_data_fifo_0/axis_data_fifo_0_sim_netlist.v
vlog ../../source/hdl/csi2/ip/rst_clk_200M/rst_clk_200M_sim_netlist.v

puts "\n--- Compiling Top Module ---"
vlog $SV_OPTS ../../source/hdl/blue_hd_top.sv

puts "\n--- Compiling Testbench Support ---"
vlog $SV_OPTS ../tb_src/spi_master.sv
vlog $SV_OPTS ../../source/hdl/ti-roic/tb_src/roic_emul.sv

puts "\n--- Compiling Main Testbench ---"
vlog $SV_OPTS ../tb_src/test_bench.sv

puts "\n============================================================"
puts "Compilation Complete!"
puts "============================================================"
puts "To run simulation: vsim -do simulate.do"
puts "============================================================"
