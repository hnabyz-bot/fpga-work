#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Questa Simulation Runner (Linux)
#==============================================================================

# Load Questa environment
echo "Loading Questa environment..."
source /home/holee/TOOLS/env.sh

# Check if Questa is available
if ! command -v vsim &> /dev/null; then
    echo "ERROR: vsim not found. Please check Questa installation."
    exit 1
fi

# Change to simulation directory
cd "$(dirname "$0")"
SIM_DIR=$(pwd)

echo "============================================================"
echo "BLUE-HD-FPGA Questa Simulation"
echo "Simulation Directory: $SIM_DIR"
echo "============================================================"

# Parse arguments
MODE="gui"
if [ "$1" == "batch" ]; then
    MODE="batch"
elif [ "$1" == "compile" ]; then
    MODE="compile"
fi

case $MODE in
    "compile")
        echo "Compiling only..."
        vsim -c -do "do compile.do; quit"
        ;;
    "batch")
        echo "Running batch simulation..."
        vsim -c -do "do compile.do; vsim -t 1ps -voptargs=+acc work.test_bench; run 100us; quit"
        ;;
    "gui")
        echo "Running GUI simulation..."
        vsim -do "do compile.do; do simulate.do"
        ;;
esac

echo ""
echo "============================================================"
echo "Simulation Complete!"
echo "============================================================"
