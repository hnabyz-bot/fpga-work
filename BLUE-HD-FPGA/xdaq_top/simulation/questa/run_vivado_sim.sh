#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Vivado-Free Simulation Runner
#==============================================================================
# Usage: ./run_vivado_sim.sh [OPTIONS]
#
# This script runs Questa simulation using the Vivado project's
# pre-configured environment, ensuring Vivado-free operation.
#
# Options:
#   -h, --help       Show this help message
#   -b, --batch      Run simulation in batch mode
#   -g, --gui        Run simulation with GUI (default)
#   -c, --compile    Compile only (no simulation)
#   --clean          Clean work directory before compile
#
# Examples:
#   ./run_vivado_sim.sh              # GUI simulation
#   ./run_vivado_sim.sh -b           # Batch simulation
#   ./run_vivado_sim.sh -c           # Compile only
#==============================================================================

#------------------------------------------------------------------------------
# Script directory and project root
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Vivado simulation directory (with working modelsim.ini)
VIVADO_SIM_DIR="$PROJECT_ROOT/build/xdaq_top.sim/sim_1/behav/questa"

# Questa bin path (from Vivado project)
QUESTA_BIN_PATH="/home/holee/TOOLS/QuestaBase_2024.3/questa_base/bin"

#------------------------------------------------------------------------------
# Default options
#------------------------------------------------------------------------------
COMPILE_ONLY=false
BATCH_MODE=false
CLEAN_FIRST=false

#------------------------------------------------------------------------------
# Parse options
#------------------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "============================================================"
            echo " BLUE-HD-FPGA Vivado-Free Simulation Runner"
            echo "============================================================"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -h, --help       Show this help message"
            echo "  -b, --batch      Run simulation in batch mode"
            echo "  -g, --gui        Run simulation with GUI (default)"
            echo "  -c, --compile    Compile only (no simulation)"
            echo "  --clean          Clean work directory before compile"
            echo ""
            echo "Examples:"
            echo "  $0                          # GUI simulation"
            echo "  $0 -b                       # Batch simulation"
            echo "  $0 -c                       # Compile only"
            echo ""
            echo "Note: This script uses the Vivado project's pre-configured"
            echo "      simulation environment with working library mappings."
            echo "============================================================"
            exit 0
            ;;
        -b|--batch)
            BATCH_MODE=true
            shift
            ;;
        -g|--gui)
            BATCH_MODE=false
            shift
            ;;
        -c|--compile)
            COMPILE_ONLY=true
            shift
            ;;
        --clean)
            CLEAN_FIRST=true
            shift
            ;;
        *)
            echo "ERROR: Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

#------------------------------------------------------------------------------
# Color output
#------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

#------------------------------------------------------------------------------
# Header
#------------------------------------------------------------------------------
echo "============================================================"
echo " BLUE-HD-FPGA Vivado-Free Simulation Runner"
echo "============================================================"
echo ""
info "Project Root: $PROJECT_ROOT"
info "Vivado Sim Dir: $VIVADO_SIM_DIR"
echo ""

#------------------------------------------------------------------------------
# Verify Vivado simulation directory exists
#------------------------------------------------------------------------------
if [ ! -d "$VIVADO_SIM_DIR" ]; then
    error "Vivado simulation directory not found!"
    echo "Expected: $VIVADO_SIM_DIR"
    echo ""
    echo "Please run Vivado simulation once to generate the directory:"
    echo "  1. Open Vivado project: $PROJECT_ROOT/xdaq_top.xpr"
    echo "  2. Run Simulation (Questa)"
    echo "  3. Directory will be created automatically"
    exit 1
fi

#------------------------------------------------------------------------------
# Clean if requested
#------------------------------------------------------------------------------
if [ "$CLEAN_FIRST" = true ]; then
    info "Cleaning work directories..."
    # Clean local work directory
    rm -rf work transcript vsim.wlf *.log 2>/dev/null
    # Clean Vivado simulation directory
    rm -rf "$VIVADO_SIM_DIR/work" "$VIVADO_SIM_DIR/transcript" "$VIVADO_SIM_DIR/vsim.wlf" "$VIVADO_SIM_DIR/*.log" 2>/dev/null
    success "Clean complete"
    echo ""
fi

#------------------------------------------------------------------------------
# Compile
#------------------------------------------------------------------------------
info "Compiling using Vivado project's compile script..."
cd "$VIVADO_SIM_DIR"

# Execute compile script directly
bash "$VIVADO_SIM_DIR/compile.sh"
COMP_STATUS=$?

# Return to script directory
cd "$SCRIPT_DIR"

if [ $COMP_STATUS -ne 0 ]; then
    error "Compilation failed"
    exit 1
fi

success "Compilation complete"

#------------------------------------------------------------------------------
# Compile only mode
#------------------------------------------------------------------------------
if [ "$COMPILE_ONLY" = true ]; then
    echo ""
    success "Compile complete. To run simulation:"
    echo "  $0              # GUI mode"
    echo "  $0 -b           # Batch mode"
    echo "============================================================"
    exit 0
fi

#------------------------------------------------------------------------------
# Simulation
#------------------------------------------------------------------------------
echo ""
if [ "$BATCH_MODE" = true ]; then
    info "Running simulation in BATCH mode..."
    echo ""

    # Run vsim directly from Vivado simulation directory
    cd "$VIVADO_SIM_DIR"
    # Use Vivado's modelsim.ini and run simulation
    "$QUESTA_BIN_PATH/vsim" -c -modelsimini modelsim.ini -do "run 1000ns; quit -f" -l simulate_batch.log
    SIM_STATUS=$?
    cd "$SCRIPT_DIR"

    if [ $SIM_STATUS -ne 0 ]; then
        error "Simulation failed"
        echo ""
        echo "Checking simulate_batch.log:"
        tail -20 "$VIVADO_SIM_DIR/simulate_batch.log" 2>/dev/null || echo "No log file found"
        exit 1
    fi

    echo ""
    success "Batch simulation completed!"
    echo ""
    echo "Results:"
    echo "  - $VIVADO_SIM_DIR/simulate_batch.log: Simulation log"
    echo "  - Check log for any warnings or errors"
else
    info "Running simulation in GUI mode..."
    echo ""
    echo "Launching Questa GUI..."
    echo ""

    # Launch GUI from Vivado directory
    cd "$VIVADO_SIM_DIR"
    "$QUESTA_BIN_PATH/vsim" -64 -modelsimini modelsim.ini &
    cd "$SCRIPT_DIR"
fi

echo ""
echo "============================================================"
echo "Simulation Complete!"
echo "============================================================"
