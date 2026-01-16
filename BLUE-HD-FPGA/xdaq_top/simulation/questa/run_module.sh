#!/bin/bash
#==============================================================================
# BLUE-HD-FPGA 개별 모듈 Questa 시뮬레이션 스크립트
#==============================================================================
# Vivado GUI 없이 Questa GUI만으로 개별 모듈 시뮬레이션 실행
#
# Usage:
#   ./run_module.sh <module_name>           # GUI 모드로 실행
#   ./run_module.sh <module_name> -batch    # 배치 모드로 실행
#
# Examples:
#   ./run_module.sh init
#   ./run_module.sh sequencer_fsm
#   ./run_module.sh fifo_1b -batch
#
# 사전 요구사항:
#   source /home/holee/TOOLS/env.sh  # 먼저 실행 필요
#==============================================================================

set -e

#------------------------------------------------------------------------------
# 경로 설정
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SOURCE_DIR="$PROJECT_ROOT/source/hdl"
TB_DIR="$SCRIPT_DIR/../tb_src"

#------------------------------------------------------------------------------
# 툴 설정
#------------------------------------------------------------------------------
VLIB="vlib"
VLOG="vlog"
VSIM="vsim"
VMAP="vmap"

#------------------------------------------------------------------------------
# 파라미터 처리
#------------------------------------------------------------------------------
if [ -z "$1" ]; then
    echo "========================================"
    echo " BLUE-HD-FPGA 개별 모듈 시뮬레이션"
    echo "========================================"
    echo ""
    echo "Usage: $0 <module_name> [-batch]"
    echo ""
    echo "Available modules:"
    echo "  init              - 초기화 모듈"
    echo "  sequencer_fsm     - 시퀀서 FSM"
    echo "  fifo_1b           - 1비트 FIFO"
    echo "  async_fifo_1b     - 비동기 1비트 FIFO"
    echo "  spi_slave         - SPI 슬레이브"
    echo "  i2c_master        - I2C 마스터"
    echo ""
    echo "Examples:"
    echo "  $0 init"
    echo "  $0 sequencer_fsm -batch"
    echo "========================================"
    exit 1
fi

MODULE_NAME="$1"
MODE="gui"
if [ "$2" == "-batch" ]; then
    MODE="batch"
fi

#------------------------------------------------------------------------------
# 모듈별 설정
#------------------------------------------------------------------------------
case "$MODULE_NAME" in
    "init")
        TB_NAME="init_tb"
        SOURCE_FILES="p_define.sv init.sv"
        ;;
    "sequencer_fsm")
        TB_NAME="sequencer_fsm_tb"
        SOURCE_FILES="p_define.sv sequencer_fsm.sv"
        ;;
    "fifo_1b")
        TB_NAME="fifo_1b_tb"
        SOURCE_FILES="p_define.sv fifo_1b.sv"
        ;;
    "async_fifo_1b")
        TB_NAME="async_fifo_1b_tb"
        SOURCE_FILES="p_define.sv async_fifo_1b.sv"
        ;;
    "spi_slave")
        TB_NAME="spi_slave_tb"
        SOURCE_FILES="p_define.sv spi_slave.sv"
        ;;
    "i2c_master")
        TB_NAME="i2c_master_tb"
        SOURCE_FILES="p_define.sv i2c_master.sv"
        ;;
    *)
        echo "Error: Unknown module '$MODULE_NAME'"
        echo "Available modules: init, sequencer_fsm, fifo_1b, async_fifo_1b, spi_slave, i2c_master"
        exit 1
        ;;
esac

#------------------------------------------------------------------------------
# 색상 출력
#------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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
# 환경 체크
#------------------------------------------------------------------------------
print_header "$MODULE_NAME 모듈 Questa 시뮬레이션"

if ! command -v vsim &> /dev/null; then
    print_error "Questa 환경이 설정되지 않았습니다."
    print_info "먼저 다음을 실행하세요: source /home/holee/TOOLS/env.sh"
    exit 1
fi

print_info "Source directory: $SOURCE_DIR"
print_info "Testbench directory: $TB_DIR"
print_info "Module: $MODULE_NAME"
print_info "Testbench: $TB_NAME"
print_info "Mode: $MODE"

#------------------------------------------------------------------------------
# 테스트벤치 파일 존재 확인
#------------------------------------------------------------------------------
if [ ! -f "$TB_DIR/${TB_NAME}.sv" ]; then
    print_error "테스트벤치 파일을 찾을 수 없습니다: $TB_DIR/${TB_NAME}.sv"
    print_info "테스트벤치가 아직 작성되지 않았을 수 있습니다."
    exit 1
fi

#------------------------------------------------------------------------------
# 워킹 디렉토리 정리
#------------------------------------------------------------------------------
WORK_LIB="work_${MODULE_NAME}"
print_info "이전 시뮬레이션 결과 정리..."
rm -rf $WORK_LIB
rm -rf vsim.wlf
rm -rf transcript

#------------------------------------------------------------------------------
# 라이브러리 생성
#------------------------------------------------------------------------------
print_info "$WORK_LIB 라이브러리 생성..."
$VLIB $WORK_LIB
$VMAP $WORK_LIB $WORK_LIB

#------------------------------------------------------------------------------
# 컴파일
#------------------------------------------------------------------------------
print_header "소스 컴파일..."

# 소스 파일들 컴파일
for src in $SOURCE_FILES; do
    if [ -f "$SOURCE_DIR/$src" ]; then
        print_info "컴파일: $src"
        $VLOG -sv +incdir+$SOURCE_DIR \
            "$SOURCE_DIR/$src" \
            -work $WORK_LIB
    else
        print_warn "$src를 찾을 수 없습니다 (건너뜀)"
    fi
done

# 테스트벤치 컴파일
print_info "컴파일: ${TB_NAME}.sv"
$VLOG -sv +incdir+$SOURCE_DIR \
    "$TB_DIR/${TB_NAME}.sv" \
    -work $WORK_LIB

print_success "컴파일 완료!"

#------------------------------------------------------------------------------
# 시뮬레이션 실행
#------------------------------------------------------------------------------
print_header "시뮬레이션 실행..."

if [ "$MODE" == "batch" ]; then
    print_info "배치 모드로 실행..."
    $VSIM -c ${WORK_LIB}.${TB_NAME} \
        -do "run -all; quit -f" \
        | tee simulation_${MODULE_NAME}.log

    # 결과 확인
    if grep -q "ALL TESTS PASSED" simulation_${MODULE_NAME}.log; then
        print_success "모든 테스트 통과!"
    elif grep -q "SOME TESTS FAILED" simulation_${MODULE_NAME}.log; then
        print_error "일부 테스트 실패"
    else
        print_warn "테스트 결과를 찾을 수 없습니다"
    fi
else
    print_info "GUI 모드로 실행..."

    # TCL 스크립트 생성
    cat > run_${MODULE_NAME}_gui.tcl << EOF
#==============================================================================
# ${MODULE_NAME} 모듈 GUI 시뮬레이션 TCL 스크립트
#==============================================================================

# 메인 윈도우 설정
quietly set PrefSource(StandardSource) 1
quietly set PrefSource(ShowSource) 1

# 파형 윈도우 열기
view wave

# 모든 신호를 파형 윈도우에 추가
add wave -position insertpoint sim:/${TB_NAME}/*

# 파형 윈도우 설정
configure wave -signalnamewidth 1
wave cursor active time

# 메시지 출력
echo "========================================"
echo "${MODULE_NAME} 모듈 시뮬레이션"
echo "========================================"
echo "클럭 주기: 50ns (20MHz)"
echo ""
echo "명령어:"
echo "  run 1us       - 1us 실행"
echo "  run 10us      - 10us 실행"
echo "  run -all      - 전체 실행"
echo "  quit          - 종료"
echo "========================================"
echo ""
EOF

    # Questa GUI 실행
    $VSIM -gui -voptargs="+acc" ${WORK_LIB}.${TB_NAME} \
        -do run_${MODULE_NAME}_gui.tcl \
        &

    print_success "Questa GUI가 시작되었습니다."
    print_info "GUI 내에서 'run -all' 명령으로 전체 시뮬레이션을 실행하세요."
fi

#------------------------------------------------------------------------------
# 요약
#------------------------------------------------------------------------------
print_header "요약"
print_info "모듈: $MODULE_NAME"
print_info "테스트벤치: $TB_NAME"
print_info "라이브러리: $WORK_LIB"

if [ "$MODE" == "batch" ]; then
    print_info "로그 파일: simulation_${MODULE_NAME}.log"
else
    print_info "GUI 실행 중..."
fi

echo ""
print_success "완료!"
