#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Questa Environment Setup Script
#==============================================================================
# Usage: source setup_env.sh
# This script must be sourced, not executed
#==============================================================================

# Check if script is being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "ERROR: This script must be sourced, not executed."
    echo "Usage: source setup_env.sh"
    exit 1
fi

#------------------------------------------------------------------------------
# Project Root Detection
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export BLUE_HD_SIM_DIR="$SCRIPT_DIR"
export BLUE_HD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
export BLUE_HD_SRC="$BLUE_HD_ROOT/source"
export BLUE_HD_TB="$BLUE_HD_ROOT/simulation/tb_src"

#------------------------------------------------------------------------------
# Questa Environment
#------------------------------------------------------------------------------
QUESTA_ENV="/home/holee/TOOLS/env.sh"

if [ -f "$QUESTA_ENV" ]; then
    source "$QUESTA_ENV"
    echo "[INFO] Questa environment loaded from: $QUESTA_ENV"
else
    echo "[WARN] Questa environment file not found: $QUESTA_ENV"
    echo "[WARN] Please set QUESTABASE_HOME and update PATH manually."
fi

#------------------------------------------------------------------------------
# Verify Questa Installation
#------------------------------------------------------------------------------
if command -v vsim >/dev/null 2>&1; then
    VSIM_VERSION=$(vsim -version 2>/dev/null | head -1)
    echo "[INFO] Questa found: $VSIM_VERSION"
else
    echo "[ERROR] vsim not found in PATH!"
    echo "[ERROR] Please check Questa installation."
    return 1
fi

#------------------------------------------------------------------------------
# Vivado Environment (for IP simulation models)
#------------------------------------------------------------------------------
VIVADO_ENV="/tools/Xilinx/Vivado/2023.2/settings64.sh"

if [ -f "$VIVADO_ENV" ]; then
    # Only set XILINX_VIVADO, don't source entire settings
    export XILINX_VIVADO="/tools/Xilinx/Vivado/2023.2"
    echo "[INFO] Xilinx Vivado path set: $XILINX_VIVADO"
else
    # Try alternative paths
    for vivado_path in /opt/Xilinx/Vivado/*/settings64.sh /tools/Xilinx/Vivado/*/settings64.sh; do
        if [ -f "$vivado_path" ]; then
            export XILINX_VIVADO="$(dirname "$vivado_path")"
            echo "[INFO] Xilinx Vivado found: $XILINX_VIVADO"
            break
        fi
    done
fi

#------------------------------------------------------------------------------
# Simulation Library Path
#------------------------------------------------------------------------------
export QUESTA_SIM_LIB="$HOME/compile_simlib/questa"

if [ -d "$QUESTA_SIM_LIB" ]; then
    echo "[INFO] Xilinx simulation library: $QUESTA_SIM_LIB"
    # Add library to vsim library path
    export VSIM_LIBRARY_PATH="$QUESTA_SIM_LIB"
else
    echo "[WARN] Simulation library not found: $QUESTA_SIM_LIB"
    echo "[WARN] Please compile Xilinx simulation libraries using Vivado."
fi

#------------------------------------------------------------------------------
# Display Summary
#------------------------------------------------------------------------------
echo ""
echo "============================================================"
echo " BLUE-HD-FPGA Simulation Environment"
echo "============================================================"
echo " Project Root  : $BLUE_HD_ROOT"
echo " Source Dir    : $BLUE_HD_SRC"
echo " Testbench Dir : $BLUE_HD_TB"
echo " Simulation Dir: $BLUE_HD_SIM_DIR"
echo "============================================================"
echo ""
echo "Available commands:"
echo "  make help      - Show available make targets"
echo "  make compile   - Compile all sources"
echo "  make sim       - Run simulation with GUI"
echo "  make sim_batch - Run simulation in batch mode"
echo "  ./run_test.sh  - Run specific testbench"
echo "============================================================"
