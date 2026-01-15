#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Individual Testbench Runner
#==============================================================================
# Usage: ./run_test.sh [testbench_name] [mode]
#   testbench_name: Name of testbench module (without .sv extension)
#   mode: gui (default) | batch | compile
#
# Examples:
#   ./run_test.sh test_bench gui       - Run main testbench with GUI
#   ./run_test.sh sequencer_fsm_tb batch - Run sequencer FSM testbench in batch
#   ./run_test.sh tb_reg_map           - Run register map testbench with GUI
#==============================================================================

set -e

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Source environment
if [ -f "./setup_env.sh" ]; then
    source ./setup_env.sh
else
    source /home/holee/TOOLS/env.sh
fi

#------------------------------------------------------------------------------
# Available Testbenches
#------------------------------------------------------------------------------
declare -A TESTBENCHES=(
    ["test_bench"]="Main system testbench (full integration)"
    ["sequencer_fsm_tb"]="Sequencer FSM unit test"
    ["tb_reg_map"]="Register map unit test"
    ["tb_ctrl_fsm_sg"]="Control FSM unit test"
    ["tb_roic_gate_drv_compare"]="ROIC gate driver comparison test"
    ["bit_align_tb"]="TI-ROIC bit alignment test"
    ["deser_single_tb"]="TI-ROIC deserializer test"
    ["indata_reorder_tb"]="TI-ROIC data reorder test"
    ["roic_spi_tb"]="TI-ROIC SPI interface test"
)

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------
print_usage() {
    echo "============================================================"
    echo " BLUE-HD-FPGA Testbench Runner"
    echo "============================================================"
    echo ""
    echo "Usage: $0 [testbench_name] [mode]"
    echo ""
    echo "Modes:"
    echo "  gui     - Run with QuestaSim GUI (default)"
    echo "  batch   - Run in batch mode (no GUI)"
    echo "  compile - Compile only, don't run"
    echo ""
    echo "Available Testbenches:"
    for tb in "${!TESTBENCHES[@]}"; do
        printf "  %-25s - %s\n" "$tb" "${TESTBENCHES[$tb]}"
    done
    echo ""
    echo "Examples:"
    echo "  $0 test_bench gui"
    echo "  $0 sequencer_fsm_tb batch"
    echo "============================================================"
}

compile_sources() {
    local tb_name=$1
    echo "[INFO] Compiling sources for testbench: $tb_name"

    # Create work library
    if [ -d "work" ]; then
        rm -rf work
    fi
    vlib work
    vmap work work

    # Compile common files
    local INCLUDE_PATH="+incdir+../../source/hdl"
    local SV_OPTS="-sv $INCLUDE_PATH"

    echo "[INFO] Compiling parameter definitions..."
    vlog $SV_OPTS ../../source/hdl/p_define.sv

    echo "[INFO] Compiling IP simulation models..."
    vlog ../../source/ip/clk_ctrl/clk_ctrl_sim_netlist.v 2>/dev/null || echo "[WARN] clk_ctrl not found"
    vlog ../../source/ip/seq_lut/seq_lut_sim_netlist.v 2>/dev/null || echo "[WARN] seq_lut not found"
    vlog ../../source/ip/indata_ram/indata_ram_sim_netlist.v 2>/dev/null || echo "[WARN] indata_ram not found"

    echo "[INFO] Compiling TI-ROIC modules..."
    vlog $SV_OPTS ../../source/hdl/ti-roic/bit_clock_module.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/deser_single.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/bit_align.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/first_ch_detector.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/indata_reorder.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/roic_spi.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/ti_roic_tg.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/ti_roic_top.sv

    echo "[INFO] Compiling common modules..."
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

    echo "[INFO] Compiling MIPI CSI-2 modules..."
    vlog $SV_OPTS ../../source/hdl/csi2/mipi_csi2_tx_bd.sv 2>/dev/null || true
    vlog $SV_OPTS ../../source/hdl/csi2/mipi_csi2_tx_top.sv 2>/dev/null || true

    echo "[INFO] Compiling top module..."
    vlog $SV_OPTS ../../source/hdl/blue_hd_top.sv

    echo "[INFO] Compiling testbench support..."
    vlog $SV_OPTS ../tb_src/spi_master.sv
    vlog $SV_OPTS ../../source/hdl/ti-roic/tb_src/roic_emul.sv 2>/dev/null || true

    # Compile specific testbench
    echo "[INFO] Compiling testbench: $tb_name..."
    if [ -f "../tb_src/${tb_name}.sv" ]; then
        vlog $SV_OPTS ../tb_src/${tb_name}.sv
    elif [ -f "../../source/hdl/ti-roic/tb_src/${tb_name}.sv" ]; then
        vlog $SV_OPTS ../../source/hdl/ti-roic/tb_src/${tb_name}.sv
    else
        echo "[ERROR] Testbench not found: $tb_name"
        return 1
    fi

    echo "[INFO] Compilation complete!"
}

run_simulation() {
    local tb_name=$1
    local mode=$2
    local sim_time="${3:-100us}"

    case $mode in
        "gui")
            echo "[INFO] Starting GUI simulation..."
            vsim -t 1ps -voptargs="+acc" work.$tb_name -do "do wave.do; run $sim_time"
            ;;
        "batch")
            echo "[INFO] Starting batch simulation..."
            vsim -c -t 1ps -voptargs="+acc" work.$tb_name -do "run $sim_time; quit -f"
            ;;
        *)
            echo "[ERROR] Unknown mode: $mode"
            return 1
            ;;
    esac
}

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
TB_NAME="${1:-test_bench}"
MODE="${2:-gui}"

# Show help if requested
if [ "$TB_NAME" == "-h" ] || [ "$TB_NAME" == "--help" ]; then
    print_usage
    exit 0
fi

# Validate testbench name
if [ -z "${TESTBENCHES[$TB_NAME]}" ]; then
    echo "[WARN] Unknown testbench: $TB_NAME"
    echo "[INFO] Attempting to run anyway..."
fi

echo "============================================================"
echo " BLUE-HD-FPGA Testbench Runner"
echo "============================================================"
echo " Testbench : $TB_NAME"
echo " Mode      : $MODE"
echo "============================================================"

# Compile
compile_sources "$TB_NAME"

# Run simulation (unless compile-only)
if [ "$MODE" != "compile" ]; then
    run_simulation "$TB_NAME" "$MODE"
fi

echo ""
echo "============================================================"
echo " Simulation Complete!"
echo "============================================================"
