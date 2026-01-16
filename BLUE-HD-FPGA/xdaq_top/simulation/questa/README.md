# BLUE-HD-FPGA Questa Simulation Environment

## Overview

BLUE-HD-FPGA 프로젝트를 위한 Questa 시뮬레이션 환경입니다.

## Requirements

- **Questa Base 2024.3** 이상
- **Xilinx Vivado 2023.2** (IP 시뮬레이션 모델용)
- **License**: Siemens EDA License

## Quick Start

### 1. 환경 설정

```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/questa
source setup_env.sh
```

### 2. 컴파일 및 시뮬레이션

```bash
# 컴파일만
make compile

# GUI 시뮬레이션
make sim

# 배치 시뮬레이션
make sim_batch
```

## Directory Structure

```
simulation/
├── questa/
│   ├── Makefile           # 메인 빌드 스크립트
│   ├── setup_env.sh       # 환경 설정 스크립트
│   ├── compile.do         # Questa 컴파일 스크립트
│   ├── simulate.do        # Questa 시뮬레이션 스크립트
│   ├── wave.do            # 파형 설정
│   ├── run_sim.sh         # 간단한 실행 스크립트
│   ├── run_test.sh        # 개별 테스트벤치 실행
│   └── run_regression.sh  # 회귀 테스트 실행
└── tb_src/
    ├── test_bench.sv      # 메인 테스트벤치
    ├── spi_master.sv      # SPI 마스터 모델
    └── ...                # 기타 테스트벤치
```

## Available Make Targets

| Target | Description |
|--------|-------------|
| `make help` | 사용 가능한 타겟 표시 |
| `make compile` | 모든 소스 컴파일 |
| `make sim` | GUI 모드 시뮬레이션 |
| `make sim_batch` | 배치 모드 시뮬레이션 |
| `make sim TB=<name>` | 특정 테스트벤치 실행 |
| `make wave` | 파형 뷰어 열기 |
| `make regression` | 전체 회귀 테스트 |
| `make regression_quick` | 빠른 회귀 테스트 |
| `make clean` | 작업 디렉토리 정리 |
| `make check_env` | 환경 설정 확인 |

## Available Testbenches

| Testbench | Description |
|-----------|-------------|
| `test_bench` | 메인 시스템 테스트벤치 (전체 통합) |
| `sequencer_fsm_tb` | 시퀀서 FSM 단위 테스트 |
| `tb_reg_map` | 레지스터 맵 단위 테스트 |
| `tb_ctrl_fsm_sg` | 제어 FSM 단위 테스트 |
| `tb_roic_gate_drv_compare` | ROIC 게이트 드라이버 비교 테스트 |
| `bit_align_tb` | TI-ROIC 비트 정렬 테스트 |
| `deser_single_tb` | TI-ROIC 역직렬화 테스트 |
| `indata_reorder_tb` | TI-ROIC 데이터 재정렬 테스트 |
| `roic_spi_tb` | TI-ROIC SPI 인터페이스 테스트 |

## Usage Examples

### 특정 테스트벤치 실행

```bash
# GUI 모드
make sim TB=sequencer_fsm_tb

# 배치 모드
make sim_batch TB=tb_reg_map SIM_TIME=500us
```

### 개별 테스트 스크립트 사용

```bash
# 사용법 확인
./run_test.sh --help

# 특정 테스트벤치 실행
./run_test.sh sequencer_fsm_tb gui
./run_test.sh test_bench batch
```

### 개별 모듈 시뮬레이션 (Vivado GUI 없이)

Vivado GUI 연동 없이 Questa GUI만으로 개별 모듈을 시뮬레이션할 수 있습니다.

#### 방법 1: 범용 스크립트 사용 (권장)

```bash
# 환경 설정
source /home/holee/TOOLS/env.sh

# init 모듈 시뮬레이션
./run_module.sh init

# sequencer_fsm 모듈 시뮬레이션
./run_module.sh sequencer_fsm

# 배치 모드로 실행
./run_module.sh init -batch

# 사용 가능한 모듈 목록
./run_module.sh
```

#### 방법 2: 모듈별 전용 스크립트 사용

```bash
# init 모듈
./run_init.sh          # GUI 모드
./run_init.sh -batch   # 배치 모드

# sequencer_fsm 모듈
./run_sequencer_fsm.sh          # GUI 모드
./run_sequencer_fsm.sh -batch   # 배치 모드
```

#### 지원되는 모듈

| 모듈명 | 설명 | 테스트벤치 |
|--------|------|-----------|
| `init` | 초기화 파워 시퀀스 | `init_tb.sv` |
| `sequencer_fsm` | 시퀀서 FSM 상태 머신 | `sequencer_fsm_tb.sv` |
| `fifo_1b` | 1비트 FIFO | 준비 중 |
| `async_fifo_1b` | 비동기 1비트 FIFO | 준비 중 |
| `spi_slave` | SPI 슬레이브 | 준비 중 |
| `i2c_master` | I2C 마스터 | 준비 중 |

### 회귀 테스트 실행

```bash
# 전체 테스트
./run_regression.sh --all

# 빠른 테스트 (주요 테스트만)
./run_regression.sh --quick
```

## Simulation Tips

### 시뮬레이션 시간 조정

```bash
make sim SIM_TIME=1ms
```

### 파형 저장 및 보기

시뮬레이션 후 `vsim.wlf` 파일이 생성됩니다:

```bash
make wave
```

### 디버깅

Questa 콘솔에서 사용 가능한 명령:

```tcl
# 시뮬레이션 재시작
restart -f

# 특정 시간까지 실행
run 10us

# 브레이크포인트 설정
bp /test_bench/DUT/seq_fsm_inst/current_state

# 신호 값 확인
examine /test_bench/DUT/reg_map_inst/reg_data
```

## Troubleshooting

### vsim not found

```bash
# 환경 설정 다시 로드
source setup_env.sh
```

### License Error

라이센스 파일 경로 확인:

```bash
echo $LM_LICENSE_FILE
```

### IP Simulation Models Not Found

Vivado에서 시뮬레이션 모델을 export해야 합니다:

```tcl
# Vivado TCL Console
export_simulation -simulator questa -directory ./sim_export
```

## Contact

- **Project**: BLUE-HD-FPGA
- **Author**: holee
- **Last Updated**: 2026-01-16
