#==============================================================================
# BLUE-HD-FPGA Questa Simulation Makefile
#==============================================================================
# Usage:
#   make compile   - Compile all sources
#   make sim       - Run simulation with GUI
#   make sim_batch - Run simulation in batch mode
#   make clean     - Clean work directory
#   make all       - Clean, compile, and simulate
#==============================================================================

# Questa commands
VLIB = vlib
VMAP = vmap
VLOG = vlog
VCOM = vcom
VSIM = vsim

# Directories
WORK_DIR = work
SRC_DIR = ../../source/hdl
TB_DIR = ../tb_src
IP_DIR = ../../source/ip

# Simulation options
SIM_TIME = 100us
SIM_OPTS = -t 1ps -voptargs="+acc"

.PHONY: all compile sim sim_batch clean help

help:
	@echo "============================================================"
	@echo "BLUE-HD-FPGA Questa Simulation Makefile"
	@echo "============================================================"
	@echo "Available targets:"
	@echo "  make compile   - Compile all sources"
	@echo "  make sim       - Run simulation with GUI"
	@echo "  make sim_batch - Run simulation in batch mode"
	@echo "  make clean     - Clean work directory"
	@echo "  make all       - Clean, compile, and simulate"
	@echo "============================================================"

all: clean compile sim

compile:
	@echo "============================================================"
	@echo "Compiling BLUE-HD-FPGA..."
	@echo "============================================================"
	$(VSIM) -c -do "do compile.do; quit"

sim: compile
	@echo "============================================================"
	@echo "Running Simulation (GUI mode)..."
	@echo "============================================================"
	$(VSIM) -do simulate.do

sim_batch: compile
	@echo "============================================================"
	@echo "Running Simulation (Batch mode)..."
	@echo "============================================================"
	$(VSIM) -c -do "do compile.do; vsim $(SIM_OPTS) work.test_bench; run $(SIM_TIME); quit"

clean:
	@echo "Cleaning work directory..."
	rm -rf $(WORK_DIR)
	rm -rf transcript
	rm -rf vsim.wlf
	rm -rf *.log
	@echo "Clean complete."
