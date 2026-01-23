#!/bin/bash
#==============================================================================
# Xilinx Library Compilation Wrapper Script
#==============================================================================
# Usage: ./scripts/compile_xilinx_lib.sh
#
# This script compiles Xilinx simulation libraries for Questa without
# requiring Vivado to be installed.
#
# Prerequisites:
#   1. Questa Simulator installed and in PATH
#   2. XILINX_LIB_SRC environment variable set, OR
#      Vivado installation accessible (for library sources)
#==============================================================================

#------------------------------------------------------------------------------
# Script directory and project root
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

#------------------------------------------------------------------------------
# Xilinx library source location
#------------------------------------------------------------------------------

# Check if XILINX_LIB_SRC is set
if [ -z "$XILINX_LIB_SRC" ]; then
    echo "============================================================"
    echo "XILINX_LIB_SRC environment variable not set."
    echo "============================================================"
    echo ""
    echo "Please set the path to Xilinx library sources:"
    echo ""
    echo "Option 1: From Vivado installation"
    echo "  export XILINX_LIB_SRC=/tools/Xilinx/Vivado/2024.2/data/verilog/src"
    echo ""
    echo "Option 2: Copied sources (for Vivado-free setup)"
    echo "  export XILINX_LIB_SRC=$PROJECT_ROOT/simulation/xilinx_lib_src"
    echo ""
    echo "Then run this script again."
    echo "============================================================"
    exit 1
fi

# Verify source directory exists
if [ ! -d "$XILINX_LIB_SRC" ]; then
    echo "ERROR: Xilinx library source not found: $XILINX_LIB_SRC"
    exit 1
fi

#------------------------------------------------------------------------------
# Verify Questa installation
#------------------------------------------------------------------------------
if ! command -v vsim >/dev/null 2>&1; then
    echo "ERROR: vsim not found in PATH!"
    echo "Please source Questa environment first."
    exit 1
fi

#------------------------------------------------------------------------------
# Display configuration
#------------------------------------------------------------------------------
echo "============================================================"
echo "Xilinx Library Compilation for Questa"
echo "============================================================"
echo "Project Root:    $PROJECT_ROOT"
echo "Source Location: $XILINX_LIB_SRC"
echo "Output Location: $PROJECT_ROOT/simulation/questa_lib/xilinx"
echo "Questa Version:  $(vsim -version 2>/dev/null | head -1)"
echo "============================================================"
echo ""

#------------------------------------------------------------------------------
# Run TCL compilation script
#------------------------------------------------------------------------------
cd "$SCRIPT_DIR"
vsim -c -do "source compile_xilinx_lib.tcl"

#------------------------------------------------------------------------------
# Exit status
#------------------------------------------------------------------------------
EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "============================================================"
    echo "Compilation completed successfully!"
    echo "Run 'make check_libs' to verify."
    echo "============================================================"
else
    echo ""
    echo "============================================================"
    echo "Compilation failed with exit code: $EXIT_CODE"
    echo "============================================================"
fi

exit $EXIT_CODE
