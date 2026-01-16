#==============================================================================
# BLUE-HD-FPGA Questa Simulation Makefile
#==============================================================================
# Usage:
#   make help           - Show all available targets
#   make compile        - Compile all sources
#   make sim            - Run simulation with GUI
#   make sim_batch      - Run simulation in batch mode
#   make regression     - Run regression tests
#   make clean          - Clean work directory
#==============================================================================

#------------------------------------------------------------------------------
# Tool Configuration
#------------------------------------------------------------------------------
VLIB  = vlib
VMAP  = vmap
VLOG  = vlog
VCOM  = vcom
VSIM  = vsim

#------------------------------------------------------------------------------
# Directory Configuration
#------------------------------------------------------------------------------
WORK_DIR    = work
SRC_DIR     = ../../source/hdl
TB_DIR      = ../tb_src
IP_DIR      = ../../source/ip
CSI2_IP_DIR = $(SRC_DIR)/csi2/ip
ROIC_TB_DIR = $(SRC_DIR)/ti-roic/tb_src

#------------------------------------------------------------------------------
# Simulation Options
#------------------------------------------------------------------------------
SIM_TIME     = 100us
SIM_OPTS     = -t 1ps -voptargs="+acc"
INCLUDE_PATH = +incdir+$(SRC_DIR)
SV_OPTS      = -sv $(INCLUDE_PATH)

#------------------------------------------------------------------------------
# Default Testbench
#------------------------------------------------------------------------------
TB_TOP = test_bench

#------------------------------------------------------------------------------
# Phony Targets
#------------------------------------------------------------------------------
.PHONY: all compile sim sim_batch clean help lib \
        regression regression_quick check_env wave

#------------------------------------------------------------------------------
# Help Target
#------------------------------------------------------------------------------
help:
	@echo "============================================================"
	@echo " BLUE-HD-FPGA Questa Simulation Makefile"
	@echo "============================================================"
	@echo ""
	@echo "Environment Setup:"
	@echo "  source setup_env.sh   - Load Questa environment"
	@echo ""
	@echo "Build Targets:"
	@echo "  make lib              - Create work library only"
	@echo "  make compile          - Compile all sources"
	@echo ""
	@echo "Simulation Targets:"
	@echo "  make sim              - Run simulation with GUI"
	@echo "  make sim_batch        - Run simulation in batch mode"
	@echo "  make sim TB=<name>    - Run specific testbench"
	@echo "  make wave             - Open waveform viewer"
	@echo ""
	@echo "Regression Targets:"
	@echo "  make regression       - Run all regression tests"
	@echo "  make regression_quick - Run quick regression tests"
	@echo ""
	@echo "Utility Targets:"
	@echo "  make clean            - Clean work directory"
	@echo "  make check_env        - Check environment setup"
	@echo "  make help             - Show this help"
	@echo ""
	@echo "Variables:"
	@echo "  TB=<testbench>        - Testbench module name"
	@echo "  SIM_TIME=<time>       - Simulation time (default: 100us)"
	@echo ""
	@echo "Examples:"
	@echo "  make sim TB=sequencer_fsm_tb"
	@echo "  make sim_batch SIM_TIME=500us"
	@echo "============================================================"

#------------------------------------------------------------------------------
# Environment Check
#------------------------------------------------------------------------------
check_env:
	@echo "Checking Questa environment..."
	@which vsim > /dev/null 2>&1 || (echo "ERROR: vsim not found. Run 'source setup_env.sh' first." && exit 1)
	@echo "  vsim: $$(which vsim)"
	@echo "  Version: $$(vsim -version 2>/dev/null | head -1)"
	@echo "Environment OK."

#------------------------------------------------------------------------------
# Library Creation
#------------------------------------------------------------------------------
lib:
	@echo "Creating work library..."
	@if [ -d $(WORK_DIR) ]; then rm -rf $(WORK_DIR); fi
	$(VLIB) $(WORK_DIR)
	$(VMAP) work $(WORK_DIR)

#------------------------------------------------------------------------------
# Compilation
#------------------------------------------------------------------------------
compile: lib
	@echo "============================================================"
	@echo "Compiling BLUE-HD-FPGA..."
	@echo "============================================================"

	@echo "\n--- Compiling Parameter Definitions ---"
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/p_define.sv

	@echo "\n--- Compiling IP Core Simulation Models ---"
	-$(VLOG) $(IP_DIR)/clk_ctrl/clk_ctrl_sim_netlist.v
	-$(VLOG) $(IP_DIR)/seq_lut/seq_lut_sim_netlist.v
	-$(VLOG) $(IP_DIR)/indata_ram/indata_ram_sim_netlist.v

	@echo "\n--- Compiling TI ROIC Interface Modules ---"
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/bit_clock_module.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/deser_single.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/bit_align.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/first_ch_detector.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/indata_reorder.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/roic_spi.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/ti_roic_tg.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/ti-roic/ti_roic_top.sv

	@echo "\n--- Compiling Common Modules ---"
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/fifo_1b.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/async_fifo_1b.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/dcdc_clk.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/spi_slave.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/i2c_master.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/init.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/reg_map.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/sequencer_fsm.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/roic_gate_drv.sv
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/read_data_mux.sv

	@echo "\n--- Compiling MIPI CSI-2 Modules ---"
	-$(VLOG) $(SV_OPTS) $(SRC_DIR)/csi2/mipi_csi2_tx_bd.sv
	-$(VLOG) $(SV_OPTS) $(SRC_DIR)/csi2/mipi_csi2_tx_top.sv
	-$(VLOG) $(CSI2_IP_DIR)/mipi_csi2_tx_subsys/mipi_csi2_tx_subsys_sim_netlist.v
	-$(VLOG) $(CSI2_IP_DIR)/mipi_init_gen/mipi_init_gen_sim_netlist.v
	-$(VLOG) $(CSI2_IP_DIR)/axis_data_fifo_0/axis_data_fifo_0_sim_netlist.v
	-$(VLOG) $(CSI2_IP_DIR)/rst_clk_200M/rst_clk_200M_sim_netlist.v

	@echo "\n--- Compiling Top Module ---"
	$(VLOG) $(SV_OPTS) $(SRC_DIR)/blue_hd_top.sv

	@echo "\n--- Compiling Testbench Support ---"
	$(VLOG) $(SV_OPTS) $(TB_DIR)/spi_master.sv
	-$(VLOG) $(SV_OPTS) $(ROIC_TB_DIR)/roic_emul.sv
	-$(VLOG) $(SV_OPTS) $(ROIC_TB_DIR)/slave_spi.sv

	@echo "\n--- Compiling Testbenches ---"
	$(VLOG) $(SV_OPTS) $(TB_DIR)/test_bench.sv
	-$(VLOG) $(SV_OPTS) $(TB_DIR)/sequencer_fsm_tb.sv
	-$(VLOG) $(SV_OPTS) $(TB_DIR)/tb_reg_map.sv
	-$(VLOG) $(SV_OPTS) $(TB_DIR)/tb_ctrl_fsm_sg.sv
	-$(VLOG) $(SV_OPTS) $(TB_DIR)/tb_roic_gate_drv_compare.sv

	@echo "\n============================================================"
	@echo "Compilation Complete!"
	@echo "============================================================"

#------------------------------------------------------------------------------
# Simulation Targets
#------------------------------------------------------------------------------
XSIM_LIB ?= $(HOME)/compile_simlib/questa

sim: compile
	@echo "============================================================"
	@echo "Running Simulation (GUI mode)..."
	@echo "Testbench: $(TB_TOP)"
	@echo "============================================================"
	$(VSIM) $(SIM_OPTS) -L $(XSIM_LIB)/unisim -L $(XSIM_LIB)/unisims_ver -L $(XSIM_LIB)/secureip work.$(TB_TOP) -do "do wave.do; run $(SIM_TIME)"

sim_batch: compile
	@echo "============================================================"
	@echo "Running Simulation (Batch mode)..."
	@echo "Testbench: $(TB_TOP)"
	@echo "Time: $(SIM_TIME)"
	@echo "============================================================"
	$(VSIM) -c $(SIM_OPTS) -L $(XSIM_LIB)/unisim -L $(XSIM_LIB)/unisims_ver -L $(XSIM_LIB)/secureip work.$(TB_TOP) -do "run $(SIM_TIME); quit -f"

# Allow TB override
ifdef TB
TB_TOP = $(TB)
endif

#------------------------------------------------------------------------------
# Waveform Viewer
#------------------------------------------------------------------------------
wave:
	@if [ -f vsim.wlf ]; then \
		$(VSIM) -view vsim.wlf -do wave.do; \
	else \
		echo "No waveform file found. Run simulation first."; \
	fi

#------------------------------------------------------------------------------
# Regression Tests
#------------------------------------------------------------------------------
regression:
	@echo "Running full regression tests..."
	./run_regression.sh --all

regression_quick:
	@echo "Running quick regression tests..."
	./run_regression.sh --quick

#------------------------------------------------------------------------------
# Clean Target
#------------------------------------------------------------------------------
clean:
	@echo "Cleaning work directory..."
	rm -rf $(WORK_DIR)
	rm -rf transcript
	rm -rf vsim.wlf
	rm -rf *.log
	rm -rf modelsim.ini
	rm -rf regression_results
	@echo "Clean complete."

#------------------------------------------------------------------------------
# All Target
#------------------------------------------------------------------------------
all: clean compile sim
