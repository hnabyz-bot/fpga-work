#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA XSIM Test Runner
#==============================================================================
# Vivado xsim based simulation runner for individual testbenches
# Usage: ./run_xsim.sh [testbench_name]
#   testbench_name: Name of testbench module (without .sv extension)
#
# Examples:
#   ./run_xsim.sh init_tb
#   ./run_xsim.sh sequencer_fsm_tb
#==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
SOURCE_DIR="$PROJECT_ROOT/source/hdl"
TB_DIR="$SCRIPT_DIR"
IP_DIR="$PROJECT_ROOT/source/ip"

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------

XELAB="xelab"
XSIM="xsim"
XVLOG="xvlog"

# Include path for simulations
INCLUDE_PATH="+incdir+$SOURCE_DIR"
SV_OPTS="-sv $INCLUDE_PATH"

#------------------------------------------------------------------------------
# Colors for output
#------------------------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}============================================${NC}"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

#------------------------------------------------------------------------------
# Check if testbench name is provided
#------------------------------------------------------------------------------

if [ -z "$1" ]; then
    print_error "No testbench name provided"
    echo "Usage: $0 [testbench_name]"
    echo ""
    echo "Available testbenches:"
    echo "  init_tb              - Initialization module testbench"
    echo "  sequencer_fsm_tb     - Sequencer FSM testbench"
    echo ""
    echo "Example:"
    echo "  $0 sequencer_fsm_tb"
    exit 1
fi

TB_NAME="$1"
TB_FILE="$TB_DIR/${TB_NAME}.sv"

#------------------------------------------------------------------------------
# Check if testbench file exists
#------------------------------------------------------------------------------

if [ ! -f "$TB_FILE" ]; then
    print_error "Testbench file not found: $TB_FILE"
    exit 1
fi

print_header "BLUE-HD-FPGA XSIM Test Runner"
print_info "Testbench: $TB_NAME"
print_info "Source directory: $SOURCE_DIR"
print_info "Testbench directory: $TB_DIR"

#------------------------------------------------------------------------------
# Clean previous simulation results
#------------------------------------------------------------------------------

print_info "Cleaning previous simulation results..."
rm -rf ${TB_NAME}*.wdb
rm -rf xsim.dir
rm -rf .Xil
rm -rf *.log
rm -rf *.pb

#------------------------------------------------------------------------------
# Compile sources with xvlog
#------------------------------------------------------------------------------

print_header "Compiling sources..."

# Compile parameter definitions first
print_info "Compiling p_define.sv..."
$XVLOG $SV_OPTS "$SOURCE_DIR/p_define.sv" -v 2>&1 | tee xvlog_p_define.log
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    print_error "Failed to compile p_define.sv"
    exit 1
fi

# Compile IP simulation models
print_info "Compiling IP simulation models..."
for ip in clk_ctrl seq_lut indata_ram; do
    IP_FILE="$IP_DIR/${ip}/${ip}_sim_netlist.v"
    if [ -f "$IP_FILE" ]; then
        print_info "  Compiling $ip..."
        $XVLOG "$IP_FILE" 2>/dev/null || print_warn "    $ip not found (skipping)"
    else
        print_warn "  $ip simulation model not found (skipping)"
    fi
done

# Compile TI-ROIC modules
print_info "Compiling TI-ROIC modules..."
for module in bit_clock_module deser_single bit_align first_ch_detector indata_reorder roic_spi ti_roic_tg ti_roic_top; do
    MODULE_FILE="$SOURCE_DIR/ti-roic/${module}.sv"
    if [ -f "$MODULE_FILE" ]; then
        $XVLOG $SV_OPTS "$MODULE_FILE" 2>&1 | tee -a xvlog_ti_roic.log
        if [ ${PIPESTATUS[0]} -ne 0 ]; then
            print_error "Failed to compile $module"
            exit 1
        fi
    fi
done

# Compile common modules (order matters for dependencies)
print_info "Compiling common modules..."
COMMON_MODULES="fifo_1b async_fifo_1b dcdc_clk spi_slave i2c_master init"
for module in $COMMON_MODULES; do
    MODULE_FILE="$SOURCE_DIR/${module}.sv"
    if [ -f "$MODULE_FILE" ]; then
        print_info "  Compiling $module..."
        $XVLOG $SV_OPTS "$MODULE_FILE" 2>&1 | tee -a xvlog_common.log
        if [ ${PIPESTATUS[0]} -ne 0 ]; then
            print_error "Failed to compile $module"
            exit 1
        fi
    fi
done

# Compile sequencer_fsm (if needed by testbench)
if [ "$TB_NAME" == "sequencer_fsm_tb" ]; then
    print_info "Compiling sequencer_fsm.sv..."
    $XVLOG $SV_OPTS "$SOURCE_DIR/sequencer_fsm.sv" 2>&1 | tee xvlog_sequencer_fsm.log
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        print_error "Failed to compile sequencer_fsm.sv"
        exit 1
    fi
fi

# Compile additional modules as needed
for module in reg_map roic_gate_drv read_data_mux blue_hd_top; do
    MODULE_FILE="$SOURCE_DIR/${module}.sv"
    if [ -f "$MODULE_FILE" ]; then
        print_info "  Compiling $module (if needed)..."
        $XVLOG $SV_OPTS "$MODULE_FILE" 2>/dev/null || true
    fi
done

# Compile MIPI CSI-2 modules (if they exist)
print_info "Compiling MIPI CSI-2 modules (if available)..."
for module in mipi_csi2_tx_bd mipi_csi2_tx_top; do
    MODULE_FILE="$SOURCE_DIR/csi2/${module}.sv"
    if [ -f "$MODULE_FILE" ]; then
        $XVLOG $SV_OPTS "$MODULE_FILE" 2>/dev/null || print_warn "    $module compilation failed"
    fi
done

# Compile testbench support
print_info "Compiling testbench support..."
if [ -f "$TB_DIR/spi_master.sv" ]; then
    $XVLOG $SV_OPTS "$TB_DIR/spi_master.sv" 2>&1 | tee -a xvlog_support.log
fi

# Compile testbench
print_info "Compiling testbench: $TB_NAME..."
$XVLOG $SV_OPTS "$TB_FILE" 2>&1 | tee xvlog_${TB_NAME}.log
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    print_error "Failed to compile $TB_NAME"
    exit 1
fi

print_success "Compilation complete!"

#------------------------------------------------------------------------------
# Elaborate with xelab
#------------------------------------------------------------------------------

print_header "Elaborating design..."

SNAPSHOT_NAME="${TB_NAME}_snapshot"
$XELAB -debug typical +acc -snapshot $SNAPSHOT_NAME $TB_NAME \
    -log xelab.log \
    2>&1 | tee xelab_output.log

if [ ${PIPESTATUS[0]} -ne 0 ]; then
    print_error "Elaboration failed"
    print_info "Check xelab.log for details"
    exit 1
fi

print_success "Elaboration complete!"

#------------------------------------------------------------------------------
# Run simulation with xsim
#------------------------------------------------------------------------------

print_header "Running simulation..."

# Create TCL script for simulation
cat > run_sim.tcl << 'EOF'
# Set verbosity level
set msg_trace_level 5

# Run simulation
run 1000000ns

# Check if testbench signaled completion
if {[string equal [get_status -done]} true} {
    puts "Simulation completed successfully"
} else {
    puts "Simulation timeout or error"
}

# Exit
quit
EOF

# Run xsim in batch mode
$XSIM $SNAPSHOT_NAME \
    -log xsim.log \
    -run_all_commands run_sim.tcl \
    2>&1 | tee xsim_output.log

XSIM_EXIT_CODE=${PIPESTATUS[0]}

#------------------------------------------------------------------------------
# Check results
#------------------------------------------------------------------------------

print_header "Simulation Results"

# Check for timeout or errors
if grep -q "Simulation timeout" xsim_output.log 2>/dev/null; then
    print_warn "Simulation may have timed out"
fi

# Check for test results
if grep -q "ALL TESTS PASSED" xsim.log 2>/dev/null; then
    print_success "All tests passed!"
elif grep -q "SOME TESTS FAILED" xsim.log 2>/dev/null; then
    print_error "Some tests failed!"
    print_info "Check xsim.log for details"
else
    print_warn "No test results found in log"
fi

# Display test statistics if available
if grep -q "Test Results Summary" xsim.log 2>/dev/null; then
    echo ""
    echo "=== Test Statistics ==="
    grep -A 5 "Test Results Summary" xsim.log
fi

#------------------------------------------------------------------------------
# Summary
#------------------------------------------------------------------------------

print_header "Summary"
print_info "Testbench: $TB_NAME"
print_info "Snapshot: $SNAPSHOT_NAME"
print_info "Log files:"
print_info "  - xvlog_*.log (compilation logs)"
print_info "  - xelab.log (elaboration log)"
print_info "  - xsim.log (simulation log)"
print_info "  - ${TB_NAME}.vcd (waveform dump)"

if [ -f "${TB_NAME}.vcd" ]; then
    print_info "Waveform file: ${TB_NAME}.vcd"
    print_info "To view waveform: gtkwave ${TB_NAME}.vcd"
fi

echo ""
print_success "Simulation complete!"

exit $XSIM_EXIT_CODE
