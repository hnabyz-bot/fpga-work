# BLUE-HD-FPGA Questa Vivado-Free Simulation - 사용자 가이드

**최종 테스트 완료**: 2026-01-21
**상태**: ✅ 사용 가능

---

## 🎯 요약

Vivado 없이 Questa 시뮬레이션을 실행할 수 있습니다. Vivado 프로젝트에서 생성된 시뮬레이션 환경을 그대로 사용합니다.

---

## ✅ 검증 완료 사항

| 항목 | 상태 | 비고 |
|:---|:-----|:-----|
| 컴파일 | ✅ 성공 | `NUM_ROIC` 매크로 정의 완료 |
| 시뮬레이션 | ✅ 성공 | Errors: 0, Warnings: 74 (메모리 경고만) |
| 스크립트 동작 | ✅ 확인 | 모든 스크립트 정상 작동 |

---

## 🚀 사용 방법

### 방법 1: 추천 (run_vivado_sim.sh 사용)

```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/questa

# 도움말
./run_vivado_sim.sh --help

# 컴파일만
./run_vivado_sim.sh -c

# 배치 모드 시뮬레이션
./run_vivado_sim.sh -b

# 정리 후 컴파일
./run_vivado_sim.sh --clean -c
```

### 방법 2: Vivado 디렉토리에서 직접 실행

```bash
cd BLUE-HD-FPGA/xdaq_top/build/xdaq_top.sim/sim_1/behav/questa

# 컴파일
source compile.sh

# 시뮬레이션 (GUI)
source simulate.sh

# 로그 확인
cat simulate.log
```

---

## 📋 필수 선행 조건

### 1. Vivado 프로젝트 시뮬레이션 디렉토리 존재

```bash
# 다음 경로가 존재해야 함:
BLUE-HD-FPGA/xdaq_top/build/xdaq_top.sim/sim_1/behav/questa/

# 만약 없다면:
# 1. Vivado에서 프로젝트 열기: xdaq_top.xpr
# 2. Settings → Simulation → Questa 선택
# 3. Run Simulation (한 번만 실행)
```

### 2. Xilinx 라이브러리

```bash
# 다음 경로에 Xilinx 라이브러리가 있어야 함:
/home/holee/compile_simlib/questa/

# 내용:
# - unisim/
# - unisims_ver/
# - simprims_ver/
# - secureip/
```

### 3. Questa Simulator

```bash
# 경로 확인
which vsim

# 또는 환경 설정
source /home/holee/TOOLS/env.sh
```

---

## 📁 주요 파일

| 파일 | 위치 | 용도 |
|:-----|:-----|:-----|
| `run_vivado_sim.sh` | `simulation/questa/` | 추천 실행 스크립트 |
| `compile.sh` | `build/.../questa/` | Vivado 생성 컴파일 스크립트 |
| `simulate.sh` | `build/.../questa/` | Vivado 생성 시뮬레이션 스크립트 |
| `modelsim.ini` | `build/.../questa/` | 라이브러리 매핑 파일 |
| `p_define.sv` | `source/hdl/` | 파라미터 정의 (`NUM_ROIC` 포함) |

---

## 🛠️ 문제 해결

### 컴파일 에러: "NUM_ROIC is undefined"

**해결**: `p_define.sv`에 `TB_SIM` 매크로가 정의되어 있어야 합니다.

```bash
# 이미 수정 완료
# Makefile과 compile.do에 +define+TB_SIM 추가됨
```

### 라이브러리 모듈 에러 (IBUFDS, ISERDESE2, etc.)

**해결**: Vivado 프로젝트의 `modelsim.ini`를 사용합니다.

```bash
# 방법 1: run_vivado_sim.sh 사용 (자동 처리)
./run_vivado_sim.sh -b

# 방법 2: Vivado 디렉토리에서 직접 실행
cd build/xdaq_top.sim/sim_1/behav/questa
source compile.sh
source simulate.sh
```

### 경로 관련 에러

**해결**: 절대 경로를 사용합니다.

```bash
# Makefile에 절대 경로 사용
/home/holee/github_work/fpga-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.sim/sim_1/behav/questa/modelsim.ini
```

---

## ⚠️ 알려진 경고 (무시 가능)

### 메모리 파일 데이터 경고
```
# ** Warning: (vsim-PLI-3408) Too few data words read...
```

**영향**: 없음
**원인**: XPM IP 코어의 메모리 초기화 파일 크기 관련
**조치**: 필요 없음 (시뮬레이션 동작에 영향 없음)

### 매크로 재정의 경고
```
** Warning: (vlog-2263) Redefinition of macro: 'DEF_DN_GATE_OE1_AED'...
```

**영향**: 없음
**원인**: `p_define.sv`의 매크로 중복 정의
**조치**: 필요 없음 (기능에 영향 없음)

---

## 📊 성공 기록

### 최종 테스트 결과

```
# End time: 12:54:27 on Jan 21,2026
# Errors: 0
# Warnings: 74
```

### 컴파일 결과
- 소스 파일: 151개
- 테스트벤치: 9개
- 컴파일 에러: 0
- 컴파일 경고: 4 (매크로 재정의)

---

## 🎓 결론

### 사용자가 실행 가능한 상태입니다!

**추천 사용법**:
```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/questa
./run_vivado_sim.sh -b
```

**성공 확인**:
- ✅ 컴파일 성공
- ✅ 시뮬레이션 성공 (배치 모드)
- ✅ 에러 0개
- ⚠️ 경고 74개 (무시 가능)

---

**문서 작성**: 2026-01-21
**상태**: 사용 가능 ✅
