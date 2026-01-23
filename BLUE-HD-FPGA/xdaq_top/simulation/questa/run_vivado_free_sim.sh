#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Vivado-Free Simulation Runner
#==============================================================================
# Usage: ./run_vivado_free_sim.sh [OPTIONS]
#
# This script provides a convenient way to run Questa simulation
# without requiring Vivado GUI.
#
# Options:
#   -h, --help       Show this help message
#   -c, --compile    Compile only (no simulation)
#   -b, --batch      Run simulation in batch mode
#   -g, --gui        Run simulation with GUI (default)
#   -t, --test TB    Run specific testbench
#   -T TIME          Set simulation time (default: 100us)
#   --clean          Clean work directory before compile
#   --check          Check environment and libraries only
#
# Examples:
#   ./run_vivado_free_sim.sh              # GUI simulation
#   ./run_vivado_free_sim.sh -b           # Batch simulation
#   ./run_vivado_free_sim.sh -t sequencer_fsm_tb  # Specific testbench
#   ./run_vivado_free_sim.sh -c           # Compile only
#==============================================================================

#------------------------------------------------------------------------------
# Script directory
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

#------------------------------------------------------------------------------
# Default options
#------------------------------------------------------------------------------
COMPILE_ONLY=false
BATCH_MODE=false
TESTBENCH=""
SIM_TIME="100us"
CLEAN_FIRST=false
CHECK_ONLY=false

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
            echo "  -c, --compile    Compile only (no simulation)"
            echo "  -b, --batch      Run simulation in batch mode"
            echo "  -g, --gui        Run simulation with GUI (default)"
            echo "  -t, --test TB    Run specific testbench"
            echo "  -T TIME          Set simulation time (default: 100us)"
            echo "  --clean          Clean work directory before compile"
            echo "  --check          Check environment and libraries only"
            echo ""
            echo "Examples:"
            echo "  $0                          # GUI simulation"
            echo "  $0 -b                       # Batch simulation"
            echo "  $0 -t sequencer_fsm_tb      # Specific testbench"
            echo "  $0 -c                       # Compile only"
            echo "  $0 -b -T 500us              # Batch mode with 500us"
            echo ""
            echo "Make targets (advanced):"
            echo "  make compile                # Compile sources"
            echo "  make sim                    # GUI simulation"
            echo "  make sim_batch              # Batch simulation"
            echo "  make check_libs             # Check libraries"
            echo "  make env_check              # Check environment"
            echo ""
            echo "============================================================"
            exit 0
            ;;
        -c|--compile)
            COMPILE_ONLY=true
            shift
            ;;
        -b|--batch)
            BATCH_MODE=true
            shift
            ;;
        -g|--gui)
            BATCH_MODE=false
            shift
            ;;
        -t|--test)
            TESTBENCH="$2"
            shift 2
            ;;
        -T)
            SIM_TIME="$2"
            shift 2
            ;;
        --clean)
            CLEAN_FIRST=true
            shift
            ;;
        --check)
            CHECK_ONLY=true
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
echo " BLUE-HD-FPGA Vivado-Free Simulation"
echo "============================================================"
echo ""

#------------------------------------------------------------------------------
# Check only mode
#------------------------------------------------------------------------------
if [ "$CHECK_ONLY" = true ]; then
    info "Checking environment..."
    source setup_env.sh

    echo ""
    info "Checking libraries..."
    make check_libs

    echo ""
    info "Environment check complete!"
    echo ""
    echo "Ready to run simulation:"
    echo "  $0              # GUI mode"
    echo "  $0 -b           # Batch mode"
    echo "============================================================"
    exit 0
fi

#------------------------------------------------------------------------------
# Clean if requested
#------------------------------------------------------------------------------
if [ "$CLEAN_FIRST" = true ]; then
    info "Cleaning work directory..."
    make clean
    echo ""
fi

#------------------------------------------------------------------------------
# Source environment
#------------------------------------------------------------------------------
info "Loading environment..."
if ! source setup_env.sh; then
    error "Failed to source environment"
    exit 1
fi
echo ""

#------------------------------------------------------------------------------
# Compile
#------------------------------------------------------------------------------
info "Compiling sources..."
COMPILE_CMD="make compile"
if [ -n "$TESTBENCH" ]; then
    COMPILE_CMD="$COMPILE_CMD TB=$TESTBENCH"
fi

if ! $COMPILE_CMD; then
    error "Compilation failed"
    exit 1
fi
success "Compilation complete"
echo ""

#------------------------------------------------------------------------------
# Compile only mode
#------------------------------------------------------------------------------
if [ "$COMPILE_ONLY" = true ]; then
    success "Compile complete. To run simulation:"
    echo "  $0              # GUI mode"
    echo "  $0 -b           # Batch mode"
    if [ -n "$TESTBENCH" ]; then
        echo "  $0 -t $TESTBENCH   # With testbench"
    fi
    echo "============================================================"
    exit 0
fi

#------------------------------------------------------------------------------
# Simulation
#------------------------------------------------------------------------------
if [ "$BATCH_MODE" = true ]; then
    info "Running simulation in BATCH mode..."
    echo "  Testbench: ${TESTBENCH:-test_bench}"
    echo "  Time: $SIM_TIME"
    echo ""

    SIM_CMD="make sim_batch SIM_TIME=$SIM_TIME"
    if [ -n "$TESTBENCH" ]; then
        SIM_CMD="$SIM_CMD TB=$TESTBENCH"
    fi

    if $SIM_CMD; then
        success "Simulation completed successfully"
        echo ""
        echo "Results:"
        echo "  - transcript: Simulation log"
        echo "  - vsim.wlf: Waveform file (view with 'make wave')"
    else
        error "Simulation failed"
        exit 1
    fi
else
    info "Running simulation in GUI mode..."
    echo "  Testbench: ${TESTBENCH:-test_bench}"
    echo "  Time: $SIM_TIME"
    echo ""
    echo "Launching Questa GUI..."
    echo ""

    SIM_CMD="make sim SIM_TIME=$SIM_TIME"
    if [ -n "$TESTBENCH" ]; then
        SIM_CMD="$SIM_CMD TB=$TESTBENCH"
    fi

    $SIM_CMD
fi

echo ""
echo "============================================================"
echo "Simulation Complete!"
echo "============================================================"
