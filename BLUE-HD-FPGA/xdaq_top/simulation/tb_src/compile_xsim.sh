#!/bin/bash

# Clean
rm -rf xsim.dir .Xil *.log *.wdb

# Compile Xilinx simulation library
echo "Compiling Xilinx simulation library..."
xvlog -work unisims_ver /home/holee/tools/xilinx/Vivado/2024.2/data/verilog/src/unisims/*.v 2>&1 | grep -E "ERROR" | head -10 || echo "OK"

# Compile glbl
echo "Compiling glbl..."
xvlog -work work /home/holee/tools/xilinx/Vivado/2024.2/data/verilog/src/glbl.v 2>&1 | grep -E "ERROR" || echo "OK"

# Compile p_define
echo "Compiling p_define..."
xvlog -work work /home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/source/hdl/p_define.sv 2>&1 | grep -E "ERROR" || echo "OK"

# Compile init
echo "Compiling init..."
xvlog -work work -sv /home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/source/hdl/init.sv 2>&1 | grep -E "ERROR" || echo "OK"

# Compile seq_lut IP with library reference
echo "Compiling seq_lut IP..."
xvlog -work work -L unisims_ver /home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/source/ip/seq_lut/seq_lut_sim_netlist.v 2>&1 | grep -E "ERROR" | head -10 || echo "OK"

# Compile sequencer_fsm
echo "Compiling sequencer_fsm..."
xvlog -work work -sv /home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/source/hdl/sequencer_fsm.sv 2>&1 | grep -E "ERROR" || echo "OK"

# Compile testbench
echo "Compiling testbench..."
xvlog -work work -sv sequencer_fsm_tb.sv 2>&1 | grep -E "ERROR" || echo "OK"

echo "Done"
