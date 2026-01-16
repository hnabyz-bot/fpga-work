#!/bin/bash
#==============================================================================
# sequencer_fsm 모듈 Questa 개별 시뮬레이션 스크립트
#==============================================================================
# Vivado GUI 없이 Questa GUI만으로 sequencer_fsm 모듈 시뮬레이션 실행
#
# Usage:
#   ./run_sequencer_fsm.sh         # GUI 모드로 실행 (기본)
#   ./run_sequencer_fsm.sh -batch  # 배치 모드로 실행
#
# 사전 요구사항:
#   source /home/holee/TOOLS/env.sh  # 먼저 실행 필요
#==============================================================================

set -e

#------------------------------------------------------------------------------
# 경로 설정
#------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
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
# 실행 모드
#------------------------------------------------------------------------------
MODE="gui"
if [ "$1" == "-batch" ]; then
    MODE="batch"
fi

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

#------------------------------------------------------------------------------
# 환경 체크
#------------------------------------------------------------------------------
print_header "sequencer_fsm 모듈 Questa 시뮬레이션"

if ! command -v vsim &> /dev/null; then
    print_error "Questa 환경이 설정되지 않았습니다."
    print_info "먼저 다음을 실행하세요: source /home/holee/TOOLS/env.sh"
    exit 1
fi

print_info "Source directory: $SOURCE_DIR"
print_info "Testbench directory: $TB_DIR"
print_info "Mode: $MODE"

#------------------------------------------------------------------------------
# 워킹 디렉토리 정리
#------------------------------------------------------------------------------
print_info "이전 시뮬레이션 결과 정리..."
rm -rf work_fsm
rm -rf vsim.wlf
rm -rf transcript

#------------------------------------------------------------------------------
# 라이브러리 생성
#------------------------------------------------------------------------------
print_info "work_fsm 라이브러리 생성..."
$VLIB work_fsm
$VMAP work_fsm work_fsm

#------------------------------------------------------------------------------
# 컴파일 (최소 의존성만)
#------------------------------------------------------------------------------
print_header "최소 의존성만 컴파일..."

# 파라미터 정의
print_info "컴파일: p_define.sv"
$VLOG -sv +incdir+$SOURCE_DIR \
    "$SOURCE_DIR/p_define.sv" \
    -work work_fsm

# sequencer_fsm 모듈
print_info "컴파일: sequencer_fsm.sv"
$VLOG -sv +incdir+$SOURCE_DIR \
    "$SOURCE_DIR/sequencer_fsm.sv" \
    -work work_fsm

# 테스트벤치
print_info "컴파일: sequencer_fsm_tb.sv"
$VLOG -sv +incdir+$SOURCE_DIR \
    "$TB_DIR/sequencer_fsm_tb.sv" \
    -work work_fsm

print_success "컴파일 완료!"

#------------------------------------------------------------------------------
# 시뮬레이션 실행
#------------------------------------------------------------------------------
print_header "시뮬레이션 실행..."

if [ "$MODE" == "batch" ]; then
    print_info "배치 모드로 실행..."
    $VSIM -c work_fsm.sequencer_fsm_tb \
        -do "run -all; quit -f" \
        | tee simulation.log

    # 결과 확인
    if grep -q "ALL TESTS PASSED" simulation.log; then
        print_success "모든 테스트 통과!"
    else
        print_error "일부 테스트 실패"
    fi
else
    print_info "GUI 모드로 실행..."

    # TCL 스크립트 생성
    cat > run_fsm_gui.tcl << 'EOF'
#==============================================================================
# sequencer_fsm 모듈 GUI 시뮬레이션 TCL 스크립트
#==============================================================================

# 메인 윈도우 설정
quietly set PrefSource(StandardSource) 1
quietly set PrefSource(ShowSource) 1

# 파형 윈도우 열기
if {[catch {view wave}]} {
    noview wave
    view wave
}

# 신호 추가
quietly add log -recursive /*
quietly configure wave -signalnamewidth 1

# FSM 상태 심볼 디코딩
quietly radix signal sequencer_fsm_tb/dut/state_reg -unsigned
quietly radix signal sequencer_fsm_tb/current_state_o -unsigned

# 제어 신호
radix signal clk -binary
radix signal reset_i -binary
radix signal config_done_i -binary

# FSM 상태 출력
radix signal busy_o -binary
radix signal sequence_done_o -binary

# 커맨드 인에이블 출력
radix signal bias_enable_o -binary
radix signal flush_enable_o -binary
radix signal expose_enable_o -binary
radix signal readout_enable_o -binary
radix signal aed_enable_o -binary

# 파형 그룹화
quietly wave cursor active time

# 실행 시간 설정
quietly set RunTime 1ms

# 메시지 출력
echo "========================================"
echo "sequencer_fsm 모듈 시뮬레이션"
echo "========================================"
echo "클럭 주기: 50ns (20MHz)"
echo "실행 시간: $RunTime"
echo ""
echo "FSM States:"
echo "  0: RST           1: WAIT"
echo "  2: BACK_BIAS     3: FLUSH"
echo "  4: AED_DETECT    5: EXPOSE_TIME"
echo "  6: READOUT       7: IDLE"
echo ""
echo "명령어:"
echo "  run 1us       - 1us 실행"
echo "  run 10us      - 10us 실행"
echo "  run -all      - 전체 실행"
echo "  quit          - 종료"
echo "========================================"
echo ""

# 자동 실행 (필요시 주석 처리)
# run -all
EOF

    # Questa GUI 실행
    $VSIM work_fsm.sequencer_fsm_tb \
        -do run_fsm_gui.tcl \
        -do "log /* -r /*; run 1us" &

    print_success "Questa GUI가 시작되었습니다."
    print_info "GUI 내에서 'run -all' 명령으로 전체 시뮬레이션을 실행하세요."
fi

#------------------------------------------------------------------------------
# 요약
#------------------------------------------------------------------------------
print_header "요약"
print_info "모듈: sequencer_fsm_tb"
print_info "라이브러리: work_fsm"
print_info "로그 파일: simulation.log (batch mode)"

if [ "$MODE" == "gui" ]; then
    print_info "GUI 실행 중..."
fi

echo ""
print_success "완료!"
