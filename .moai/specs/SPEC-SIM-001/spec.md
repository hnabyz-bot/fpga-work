# SPEC-SIM-001: Questa 시뮬레이션 스크립트 개발

## 메타데이터

| 항목 | 값 |
|------|------|
| **SPEC ID** | SPEC-SIM-001 |
| **제목** | Questa 시뮬레이션 스크립트 검증 및 완성 |
| **생성일** | 2026-01-15 |
| **상태** | In Progress |
| **우선순위** | High |
| **담당자** | holee |
| **라이프사이클** | spec-anchored |

---

## 개요

BLUE-HD-FPGA 프로젝트의 Questa Advanced Simulator 환경에서 동작하는 자동화된 시뮬레이션 스크립트 시스템을 개발합니다. 이 시스템은 환경 설정, 단일 테스트 실행, 회귀 테스트 자동화, 포괄적인 문서화 기능을 제공합니다.

---

## 환경

### 하드웨어 환경

- **타겟 FPGA**: Xilinx Artix-7 xc7a35tfgg484
- **시뮬레이터**: Questa Advanced Simulator 2024.3+
- **개발 호스트**: Linux x86_64

### 소프트웨어 환경

- **HDL 언어**: SystemVerilog (IEEE 1800-2017)
- **스크립팅**: Bash 4.0+
- **빌드 도구**: GNU Make 3.81+
- **IP 모델**: Xilinx Vivado 2023.2

### 프로젝트 구조

```
BLUE-HD-FPGA/xdaq_top/
├── source/hdl/           # RTL 소스 코드
├── source/ip/            # Xilinx IP 코어
├── simulation/
│   ├── questa/           # Questa 시뮬레이션 환경
│   └── tb_src/           # 테스트벤치 소스
├── build/                # Vivado 빌드 결과
├── output/               # 비트스트림 출력
└── reports/              # 빌드 리포트
```

---

## 가정

### 기술적 가정

1. **Questa 라이선스**: Siemens EDA 라이선스가 정상적으로 설치되어 있음
2. **Vivado IP**: Xilinx IP 시뮬레이션 모델이 export_simulation으로 생성됨
3. **경로 의존성**: Questa와 Vivado가 표준 경로(/tools, /opt)에 설치됨

### 검증 필요 가정

1. **호환성**: Questasim 2024.3+에서 모든 SystemVerilog 기능이 지원됨
2. **성능**: 컴파일 시간이 5분 이내, 시뮬레이션 로드 시간이 30초 이내
3. **메모리**: work 라이브러리가 500MB 이하로 유지됨

---

## 요구사항 (EARS 형식)

### Ubiquitous Requirements (항상 활성)

- **UR-001**: 시스템은 **항상** 유효한 Questa 환경 변수를 검증해야 한다
- **UR-002**: 시스템은 **항상** 시뮬레이션 실행 전 소스 코드 컴파일 완료를 보장해야 한다
- **UR-003**: 시스템은 **항상** 실행 로그를 타임스탬프와 함께 저장해야 한다
- **UR-004**: 시스템은 **항상** 스크립트 실행 오류를 명확한 에러 메시지로 보고해야 한다

### Event-Driven Requirements (이벤트-응답)

- **ER-001**: **WHEN** 사용자가 `source setup_env.sh`를 실행하면, 시스템은 **SHALL** Questa 환경 변수를 로드하고 프로젝트 경로를 설정한다
- **ER-002**: **WHEN** 사용자가 `make compile`을 실행하면, 시스템은 **SHALL** 모든 RTL 소스와 테스트벤치를 컴파�하고 work 라이브러리를 생성한다
- **ER-003**: **WHEN** 사용자가 `./run_test.sh <tb_name> gui`를 실행하면, 시스템은 **SHALL** 지정된 테스트벤치를 GUI 모드로 실행한다
- **ER-004**: **WHEN** 사용자가 `./run_regression.sh --all`을 실행하면, 시스템은 **SHALL** 모든 테스트벤치를 순차적으로 실행하고 결과 리포트를 생성한다
- **ER-005**: **WHEN** 컴파일 오류가 발생하면, 시스템은 **SHALL** 오류 파일과 줄 번호를 표시하고 종료 코드 1을 반환한다

### State-Driven Requirements (상태-조건)

- **SR-001**: **IF** vsim 실행 파일이 PATH에 없으면, 시스템은 **SHALL** 환경 설정 실패 메시지를 표시한다
- **SR-002**: **IF** IP 시뮬레이션 모델이 존재하지 않으면, 시스템은 **SHALL** 경고 메시지를 출력하고 컴파일을 계속한다
- **SR-003**: **IF** 테스트가 실패하면, 시스템은 **SHALL** 실패한 테스트의 로그 파일을 보존하고 FAIL 상태를 리포트에 기록한다
- **SR-004**: **IF** 회귀 테스트 중 하나라도 실패하면, 시스템은 **SHALL** 종료 코드 1을 반환한다

### Unwanted Behavior Requirements (금지 동작)

- **WR-001**: 시스템은 **SHALL NOT** 환경 설정 없이 시뮬레이션을 실행하지 않는다
- **WR-002**: 시스템은 **SHALL NOT** 컴파일되지 않은 소스로 시뮬레이션을 시도하지 않는다
- **WR-003**: 시스템은 **SHALL NOT** 존재하지 않는 테스트벤치 실행을 시도하지 않는다
- **WR-004**: 시스템은 **SHALL NOT** 이전 회귀 테스트 결과를 덮어쓰지 않는다 (타임스탬프로 구분)

### Optional Requirements (선택 기능)

- **OR-001**: **가능하면** 시스템은 시뮬레이션 실행 시간을 예측하는 기능을 제공해야 한다
- **OR-002**: **가능하면** 시스템은 병렬 테스트 실행을 지원해야 한다 (향후 확장성)
- **OR-003**: **가능하면** 시스템은 커버리지 리포트 생성을 지원해야 한다

---

## 상세 요구사항

### 1. 환경 설정 스크립트 (setup_env.sh)

#### 기능

- Questa 시뮬레이션 환경 변수 로드
- 프로젝트 경로 자동 설정
- Vivado IP 라이브러리 경로 설정
- 환경 검증 및 진단

#### 인터페이스

```bash
source setup_env.sh  # 반드시 source로 실행
```

#### 환경 변수

| 변수 | 설명 | 예시 |
|------|------|------|
| `BLUE_HD_ROOT` | 프로젝트 루트 경로 | `/path/to/BLUE-HD-FPGA/xdaq_top` |
| `BLUE_HD_SRC` | 소스 코드 경로 | `$BLUE_HD_ROOT/source/hdl` |
| `BLUE_HD_TB` | 테스트벤치 경로 | `$BLUE_HD_ROOT/simulation/tb_src` |
| `BLUE_HD_SIM_DIR` | 시뮬레이션 경로 | `$BLUE_HD_ROOT/simulation/questa` |

---

### 2. 개별 테스트 실행 스크립트 (run_test.sh)

#### 기능

- 지정된 테스트벤치 컴파일 및 실행
- GUI/Batch 모드 지원
- 자동 소스 의존성 해결
- 실행 로그 저장

#### 인터페이스

```bash
./run_test.sh [testbench_name] [mode]

# testbench_name: test_bench, sequencer_fsm_tb, tb_reg_map, etc.
# mode: gui (default), batch, compile
```

#### 사용 가능한 테스트벤치

| 테스트벤치 | 설명 |
|-----------|------|
| `test_bench` | 메인 시스템 테스트벤치 (전체 통합) |
| `sequencer_fsm_tb` | 시퀀서 FSM 단위 테스트 |
| `tb_reg_map` | 레지스터 맵 단위 테스트 |
| `tb_ctrl_fsm_sg` | 제어 FSM 단위 테스트 |
| `tb_roic_gate_drv_compare` | ROIC 게이트 드라이버 비교 테스트 |
| `bit_align_tb` | TI-ROIC 비트 정렬 테스트 |
| `deser_single_tb` | TI-ROIC 역직렬화 테스트 |
| `indata_reorder_tb` | TI-ROIC 데이터 재정렬 테스트 |
| `roic_spi_tb` | TI-ROIC SPI 인터페이스 테스트 |

---

### 3. 회귀 테스트 스크립트 (run_regression.sh)

#### 기능

- 전체 또는 빠른 회귀 테스트 실행
- 자동 패스/패일 판정
- 타임스탬프별 결과 저장
- HTML/텍스트 리포트 생성

#### 인터페이스

```bash
./run_regression.sh [options]

# Options:
#   -a, --all      : 모든 테스트벤치 실행
#   -q, --quick    : 빠른 회귀 테스트 (주요 테스트만)
#   -v, --verbose  : 상세 출력
#   -h, --help     : 도움말 표시
```

#### 테스트 그룹

**빠른 회귀 테스트 (QUICK_TESTS)**:
- test_bench
- sequencer_fsm_tb
- tb_reg_map

**전체 회귀 테스트 (ALL_TESTS)**:
- test_bench
- sequencer_fsm_tb
- tb_reg_map
- tb_ctrl_fsm_sg
- tb_roic_gate_drv_compare
- bit_align_tb
- deser_single_tb
- indata_reorder_tb
- roic_spi_tb

---

### 4. Makefile 빌드 시스템

#### 제공 타겟

| 타겟 | 설명 |
|------|------|
| `make help` | 사용 가능한 타겟 표시 |
| `make lib` | work 라이브러리만 생성 |
| `make compile` | 모든 소스 컴파일 |
| `make sim` | GUI 모드 시뮬레이션 |
| `make sim_batch` | 배치 모드 시뮬레이션 |
| `make sim TB=<name>` | 특정 테스트벤치 실행 |
| `make wave` | 파형 뷰어 열기 |
| `make regression` | 전체 회귀 테스트 |
| `make regression_quick` | 빠른 회귀 테스트 |
| `make clean` | 작업 디렉토리 정리 |
| `make check_env` | 환경 설정 확인 |

#### 변수

| 변수 | 기본값 | 설명 |
|------|--------|------|
| `TB` | test_bench | 테스트벤치 이름 |
| `SIM_TIME` | 100us | 시뮬레이션 시간 |
| `SIM_OPTS` | -t 1ps -voptargs="+acc" | 시뮬레이션 옵션 |

---

### 5. 문서화 (README.md)

#### 포함 내용

- 개요 및 요구사항
- 빠른 시작 가이드
- 디렉토리 구조 설명
- 사용 가능한 Makefile 타겟
- 테스트벤치 목록 및 설명
- 사용 예시
- 디버깅 팁
- 문제 해결 가이드
- 연락처 정보

---

## 제약사항

### 기술적 제약사항

1. **Questa 버전**: 2024.3 이상 필요 (SystemVerilog 1800-2017 완전 지원)
2. **라이선스**: Siemens EDA 라이선스 필요
3. **디스크 공간**: work 라이브러리당 최대 500MB, 회귀 테스트 결과당 50MB
4. **메모리**: 시뮬레이션 실행 시 최소 4GB RAM 권장

### 운영 제약사항

1. **실행 순서**: 환경 설정 → 컴파일 → 시뮬레이션 순서 준수
2. **경로 의존성**: 스크립트는 프로젝트 루트에서 상대 경로로 실행
3. **로그 관리**: 30일 이상 된 로그는 자동 삭제 권장

---

## 추적 가능성 (Traceability)

### 요구사항-테스트 매핑

| 요구사항 | 테스트 시나리오 | 검증 방법 |
|---------|---------------|----------|
| UR-001 | setup_env.sh 실행 | vsim 명령 존재 확인 |
| ER-001 | 환경 설정 후 변수 확인 | echo $BLUE_HD_ROOT |
| ER-002 | make compile 실행 | work 라이브러리 생성 확인 |
| ER-003 | run_test.sh gui 실행 | GUI 창 열림 확인 |
| ER-004 | run_regression.sh --all 실행 | 모든 테스트 실행 및 리포트 생성 |
| SR-001 | PATH 없이 환경 설정 | 에러 메시지 확인 |
| SR-003 | 실패하는 테스트 실행 | 로그 보존 및 FAIL 리포트 확인 |
| WR-001 | 환경 설정 없이 시뮬레이션 | 실행 거부 확인 |

### 파일 매핑

| 구현 파일 | 연결 요구사항 |
|---------|-------------|
| setup_env.sh | UR-001, ER-001, SR-001 |
| run_test.sh | ER-003, SR-003, WR-003 |
| run_regression.sh | ER-004, SR-003, SR-004 |
| Makefile | ER-002, UR-002 |
| README.md | UR-004, OR-001 |

---

*마지막 업데이트: 2026-01-15*
*버전: 1.0.0*
