# SPEC-QUESTA-001: Questa 독립 시뮬레이션 환경 구축

## TAG BLOCK

```
SPEC_ID: SPEC-QUESTA-001
TITLE: Questa 독립 시뮬레이션 환경 구축
STATUS: Planned
PRIORITY: High
ASSIGNED: Alfred
CREATED: 2026-01-21
DOMAIN: Simulation
LIFECYCLE: spec-first
```

---

## 환경 (Environment)

### 현재 상황

- **프로젝트**: BLUE-HD-FPGA 이미지 데이터 수집 시스템
- **시뮬레이터**: Questa Advanced Simulator 2024.3+
- **현재 상태**: Vivado에서 Questa 시뮬레이션은 성공적으로 실행됨
- **문제점**: 시뮬레이션 실행 시 Vivado 라이선스 및 환경 변수 의존성 존재

### 기존 환경 구성

```
simulation/questa/
├── Makefile               # 메인 빌드 스크립트
├── compile.do             # 컴파일 스크립트
├── simulate.do            # 시뮬레이션 실행 스크립트
├── setup_env.sh           # 환경 설정 스크립트 (Vivado 의존)
└── run_*.sh               # 실행 스크립트
```

### Vivado 의존성 분석

1. **setup_env.sh**:
   - `XILINX_VIVADO` 환경 변수 설정 (line 57)
   - Vivado 2023.2 경로 하드코딩 (line 53)

2. **compile.do**:
   - Xilinx 시뮬레이션 라이브러리 주석 (line 26-30)
   - `compile_simlib` 사용 가이드 언급

3. **IP netlist 파일**:
   - `clk_ctrl_sim_netlist.v`
   - `seq_lut_sim_netlist.v`
   - `indata_ram_sim_netlist.v`
   - MIPI CSI-2 IP netlist 파일들

---

## 가정 (Assumptions)

### 기술적 가정

1. **Questa 설치**: Questa Advanced Simulator 2024.3+가 시스템에 설치됨
2. **IP Netlist**: Vivado로 생성된 IP netlist 파일들은 이미 존재함
3. **Xilinx 라이브러리**: UNISIM/SIMPRIM 라이브러리는 Questa에서 독립적으로 컴파일 가능

### 검증 필요 가정

1. **라이선스 독립성**: Questa 실행 시 Vivado 라이선스가 필요하지 않음
2. **기능 동등성**: 독립 환경에서의 시뮬레이션 결과는 Vivado 환경과 동등함

---

## 요구사항 (Requirements) - EARS Format

### Ubiquitous Requirements (항상 활성)

**REQ-U-001**: 시스템은 항상 Questa 시뮬레이터만으로 시뮬레이션을 실행할 수 있어야 한다.

**REQ-U-002**: 시스템은 항상 Vivado 라이선스 검증을 우회해야 한다.

**REQ-U-003**: 시스템은 항상 Xilinx 프리미티브 라이브러리를 포함해야 한다.

### Event-Driven Requirements (이벤트-응답)

**REQ-E-001**: WHEN 사용자가 `make compile`을 실행하면, 시스템은 Vivado 환경 변수 없이 모든 소스를 컴파일해야 한다.

**REQ-E-002**: WHEN 사용자가 `source setup_env.sh`를 실행하면, 시스템은 Questa 환경만 설정하고 Vivado 경로는 설정하지 않아야 한다.

**REQ-E-003**: WHEN IP netlist 파일이 누락되면, 시스템은 명확한 에러 메시지를 표시하고 해결 방법을 안내해야 한다.

**REQ-E-004**: WHEN Xilinx 라이브러리가 없으면, 시스템은 자동으로 라이브러리를 컴파일해야 한다.

### State-Driven Requirements (상태-조건)

**REQ-S-001**: IF Questa 실행 파일이 PATH에 없으면, 시스템은 에러를 표시하고 설치 경로를 안내해야 한다.

**REQ-S-002**: IF IP netlist 파일들이 존재하면, 시스템은 해당 파일들을 사용하여 컴파일해야 한다.

**REQ-S-003**: IF Vivado가 설치되어 있지 않아도, 시스템은 정상적으로 시뮬레이션을 실행해야 한다.

### Unwanted Requirements (바람직하지 않은 동작)

**REQ-UW-001**: 시스템은 Vivado 라이선스 서버 연결을 시도해서는 안 된다.

**REQ-UW-002**: 시스템은 `source setup_env.sh` 실행 시 Vivado 경로를 설정해서는 안 된다.

**REQ-UW-003**: 시스템은 Xilinx 라이브러리가 없을 때 컴파일을 실패해서는 안 된다.

### Optional Requirements (선택적 기능)

**REQ-O-001**: 가능하면, 시스템은 Docker 컨테이너에서 실행 가능해야 한다.

**REQ-O-002**: 가능하면, 시스템은 CI/CD 파이프라인에 통합 가능해야 한다.

---

## 상세 사양 (Specifications)

### SP-001: Xilinx 라이브러리 독립화

**목적**: UNISIM/SIMPRIM 라이브러리를 Vivado 없이 Questa에서 직접 컴파일

**구현 방법**:
1. Xilinx 7-series 프리미티브 라이브러리 소스 확보
2. Questa 전용 라이브러리 컴파일 스크립트 작성
3. 컴파일된 라이브러리를 프로젝트 내 저장

**기술적 세부사항**:
- 라이브러리 위치: `$BLUE_HD_ROOT/simulation/questa_lib/xilinx`
- 컴파일 명령: `vlog -work unisim -sv <Xilinx source>`
- glbl.v 파일 포함: 글로벌 초기화 netlist

### SP-002: 환경 설정 스크립트 개선

**목적**: setup_env.sh에서 Vivado 의존성 제거

**변경사항**:
1. Vivado 경로 설정 코드 제거 (line 53-68)
2. Xilinx 라이브러리 경로만 환경 변수로 설정
3. 라이브러리 존재 확인 로직 추가

**수정 후 구조**:
```bash
# Xilinx Simulation Libraries (Questa compiled)
export XILINX_QUESTA_LIB="$BLUE_HD_SIM_LIB/xilinx"

# Verify libraries
if [ ! -d "$XILINX_QUESTA_LIB" ]; then
    echo "[WARN] Xilinx libraries not found."
    echo "[INFO] Run 'make compile_xilinx_lib' to generate."
fi
```

### SP-003: Makefile 타겟 추가

**목적**: 독립 실행을 위한 새로운 타겟 추가

**새로운 타겟**:
1. `make compile_xilinx_lib`: Xilinx 라이브러리 컴파일
2. `make check_libs`: 라이브러리 존재 확인
3. `make env_check`: Vivado 없는 환경 확인

### SP-004: compile.do 개선

**목적**: Vivado 의존성 주석 제거 및 독립 실행 로직 추가

**변경사항**:
1. Xilinx 라이브러리 컴파일 명령 추가
2. 라이브러리 자동 감지 로직
3. 실패 시 명확한 에러 메시지

### SP-005: 문서화

**목적**: 진행 상황 기록 및 재개 가이드

**문서 구조**:
1. 진행 체크리스트 (tasks.md)
2. 기술 노트 (tech-notes.md)
3. 문제 해결 가이드 (troubleshooting.md)

---

## 추적성 (Traceability)

### 관련 SPEC

- **SPEC-SIM-001**: BLUE-HD-FPGA 시뮬레이션 환경 기본 설정

### 관련 파일

| 파일 | 경로 | 변경 유형 |
|------|------|----------|
| setup_env.sh | simulation/questa/ | 수정 |
| Makefile | simulation/questa/ | 수정 |
| compile.do | simulation/questa/ | 수정 |
| tech-notes.md | .moai/specs/SPEC-QUESTA-001/ | 신규 |
| tasks.md | .moai/specs/SPEC-QUESTA-001/ | 신규 |

### 의존성

- **Xilinx 7-series 라이브러리 소스**: Vivado 설치 디렉토리 또는 Xilinx 다운로드
- **IP netlist 파일**: 기존 Vivado 프로젝트에서 이미 생성됨

---

## 정의 (Definitions)

| 용어 | 정의 |
|------|------|
| **독립 시뮬레이션** | Vivado 라이선스/설치 없이 Questa만으로 실행 가능한 환경 |
| **Xilinx 라이브러리** | UNISIM, SIMPRIM, XilinxCoreLib 등 Xilinx 프리미티브 모델 |
| **IP netlist** | Vivado IP 코어의 시뮬레이션용 게이트레벨 모델 |
| **glbl.v** | Xilinx 글로벌 초기화 netlist 파일 |

---

## 참고 문헌

- Siemens EDA: "Questa Advanced Simulator User Guide"
- Xilinx UG900: "Vivado Design Suite User Guide - Simulation"
- Xilinx UG953: "Vivado Design Suite User Guide"
- project/product.md: 프로젝트 개요
- project/tech.md: 기술 스택 및 개발 환경

---

*SPEC 생성: 2026-01-21*
*마지막 수정: 2026-01-21*
*버전: 1.0.0*
