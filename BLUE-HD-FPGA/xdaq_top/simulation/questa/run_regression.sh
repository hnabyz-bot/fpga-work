#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA Regression Test Runner
#==============================================================================
# Usage: ./run_regression.sh [options]
#   -a, --all      Run all testbenches
#   -q, --quick    Run quick regression (main tests only)
#   -v, --verbose  Verbose output
#   -h, --help     Show help
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

# Results directory
RESULTS_DIR="$SCRIPT_DIR/regression_results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_DIR="$RESULTS_DIR/$TIMESTAMP"

#------------------------------------------------------------------------------
# Testbench Lists
#------------------------------------------------------------------------------
QUICK_TESTS=(
    "test_bench"
    "sequencer_fsm_tb"
    "tb_reg_map"
)

ALL_TESTS=(
    "test_bench"
    "sequencer_fsm_tb"
    "tb_reg_map"
    "tb_ctrl_fsm_sg"
    "tb_roic_gate_drv_compare"
    "bit_align_tb"
    "deser_single_tb"
    "indata_reorder_tb"
    "roic_spi_tb"
)

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------
print_usage() {
    echo "============================================================"
    echo " BLUE-HD-FPGA Regression Test Runner"
    echo "============================================================"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -a, --all      Run all testbenches"
    echo "  -q, --quick    Run quick regression (main tests only)"
    echo "  -v, --verbose  Verbose output"
    echo "  -h, --help     Show this help"
    echo ""
    echo "Quick tests: ${QUICK_TESTS[*]}"
    echo "All tests: ${ALL_TESTS[*]}"
    echo "============================================================"
}

run_test() {
    local tb_name=$1
    local log_file="$LOG_DIR/${tb_name}.log"

    echo -n "  Running $tb_name... "

    # Run test and capture result
    if ./run_test.sh "$tb_name" batch > "$log_file" 2>&1; then
        echo "PASS"
        return 0
    else
        echo "FAIL"
        return 1
    fi
}

generate_report() {
    local passed=$1
    local failed=$2
    local total=$3
    local report_file="$LOG_DIR/regression_report.txt"

    {
        echo "============================================================"
        echo " BLUE-HD-FPGA Regression Test Report"
        echo "============================================================"
        echo " Date     : $(date)"
        echo " Total    : $total"
        echo " Passed   : $passed"
        echo " Failed   : $failed"
        echo " Pass Rate: $(echo "scale=1; $passed * 100 / $total" | bc)%"
        echo "============================================================"
        echo ""
        echo "Individual Results:"
        echo "-----------------------------------------------------------"

        for log_file in "$LOG_DIR"/*.log; do
            tb_name=$(basename "$log_file" .log)
            if grep -q "Error\|FAIL\|error" "$log_file"; then
                echo "  [FAIL] $tb_name"
            else
                echo "  [PASS] $tb_name"
            fi
        done

        echo ""
        echo "============================================================"
    } > "$report_file"

    cat "$report_file"
}

#------------------------------------------------------------------------------
# Parse Arguments
#------------------------------------------------------------------------------
MODE="quick"
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            MODE="all"
            shift
            ;;
        -q|--quick)
            MODE="quick"
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "[ERROR] Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
echo "============================================================"
echo " BLUE-HD-FPGA Regression Test"
echo "============================================================"
echo " Mode     : $MODE"
echo " Results  : $LOG_DIR"
echo "============================================================"

# Create results directory
mkdir -p "$LOG_DIR"

# Select test list
if [ "$MODE" == "all" ]; then
    TESTS=("${ALL_TESTS[@]}")
else
    TESTS=("${QUICK_TESTS[@]}")
fi

# Run tests
PASSED=0
FAILED=0
TOTAL=${#TESTS[@]}

echo ""
echo "Running $TOTAL tests..."
echo "-----------------------------------------------------------"

for tb in "${TESTS[@]}"; do
    if run_test "$tb"; then
        ((PASSED++))
    else
        ((FAILED++))
    fi
done

echo "-----------------------------------------------------------"
echo ""

# Generate report
generate_report $PASSED $FAILED $TOTAL

# Exit with failure if any tests failed
if [ $FAILED -gt 0 ]; then
    exit 1
fi
