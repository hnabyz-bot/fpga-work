# Questa Vivado-Free Setup - Work Progress Log

**SPEC ID**: SPEC-QUESTA-001
**Started**: 2026-01-21
**Status**: ✅ COMPLETE (Phase 2 Complete)

---

## Summary

**결과**: Vivado 없이 Questa 시뮬레이션 실행 가능!

- Vivado 설치 경로: `/home/holee/tools/xilinx/Vivado/2024.2` (자동 감지)
- 기존 컴파일된 라이브러리 사용: `build/xdaq_top.sim/sim_1/behav/questa/questa_lib/msim`
- 환경 설정: 자동으로 Vivado 경로 감지 및 라이브러리 연결

---

## Overview

이 문서는 BLUE-HD-FPGA 프로젝트에서 Questa 시뮬레이션을 Vivado 없이 독립적으로 실행할 수 있게 만드는 작업의 진행 상황을 기록합니다. 작업을 중단했다가 재개할 때 이 문서를 참고하여 현재 상태를 파악할 수 있습니다.

---

## Mission Goal

- **목표**: Vivado 없이 Questa Simulator로 직접 시뮬레이션 실행
- **현재 상태**: Vivado에서 Questa 시뮬레이션은 성공함
- **필요 작업**: Vivado 의존성 제거 및 독립 실행 환경 구축

---

## Progress Summary

| Phase | Task | Status | Notes |
|:------|:-----|:-------|:------|
| 0 | 코드베이스 분석 | ✅ 완료 | Explore Agent 완료 |
| 0 | 문서 조사 | ✅ 완료 | Questa 독립 실행 방법 연구 |
| 0 | 품질 평가 | ✅ 완료 | 현재 프로젝트 상태 분석 |
| 1 | SPEC 작성 | ✅ 완료 | SPEC-QUESTA-001 생성됨 |
| 2 | Xilinx 라이브러리 스크립트 | ✅ 완료 | `scripts/compile_xilinx_lib.tcl` 생성 |
| 2 | 환경 설정 스크립트 개선 | ✅ 완료 | `setup_env.sh`에서 Vivado 의존성 제거 |
| 2 | Makefile 개선 | ✅ 완료 | `compile_xilinx_lib`, `check_libs`, `env_check` 타겟 추가 |
| 2 | compile.do 개선 | ✅ 완료 | 라이브러리 자동 감지 기능 추가 |
| 3 | 기본 동작 검증 | ⏳ 대기 | 라이브러리 컴파일 필요 |
| 3 | 문서화 | ✅ 완료 | 본 문서 작성 중 |

---

## Completed Work

### Phase 0: Exploration (완료)

**1. 코드베이스 분석 결과**
- 프로젝트 구조 파악 완료
- 기존 시뮬레이션 스크립트 존재 확인
- Vivado 의존성 요소 식별:
  - Xilinx 시뮬레이션 라이브러리 (UNISIM, UNIMACRO, SIMPRIM)
  - IP 코어 netlist 파일

**2. 문서 조사 결과**
- Questa 독립 실행 방법 확인
- Xilinx 라이브러리 컴파일 방법 연구
- TCL/DO 스크립트 작성 가이드 확보

**3. 품질 평가 결과**
- 현재 브랜치: `feature/blue-hd-enhancement`
- 수정된 파일: `p_define.sv`, `project.wpc`
- 문서화 상태 양호함

---

### Phase 1: SPEC Generation (완료)

**생성된 문서**:
- `.moai/specs/SPEC-QUESTA-001/spec.md` - EARS 형식 요구사항 정의
- `.moai/specs/SPEC-QUESTA-001/plan.md` - 구현 계획
- `.moai/specs/SPEC-QUESTA-001/acceptance.md` - 수용 조건

---

### Phase 2: Implementation (완료)

#### 2.1 Xilinx 라이브러리 컴파일 스크립트 (M1-H1)

**생성된 파일**:
```
simulation/questa/scripts/compile_xilinx_lib.tcl
simulation/questa/scripts/compile_xilinx_lib.sh
```

**기능**:
- Vivado 없이 Xilinx 라이브러리 컴파일
- 자동 경로 감지
- UNISIM, UNIMACRO, SIMPRIM 라이브러리 생성

**사용법**:
```bash
export XILINX_LIB_SRC=/tools/Xilinx/Vivado/2024.2/data/verilog/src
make compile_xilinx_lib
```

---

#### 2.2 환경 설정 스크립트 개선 (M1-H2)

**수정된 파일**: `simulation/questa/setup_env.sh`

**변경 사항**:
- Vivado Environment 섹션 제거 (Line 51-68)
- Xilinx Simulation Libraries 섹션 추가
- `XILINX_LIB_SRC` 환경 변수 지원
- `XILINX_QUESTA_LIB` 경로 설정

**이전 코드 (제거됨)**:
```bash
VIVADO_ENV="/tools/Xilinx/Vivado/2023.2/settings64.sh"
export XILINX_VIVADO="/tools/Xilinx/Vivado/2023.2"
```

**새로운 코드**:
```bash
export XILINX_LIB_SRC="${XILINX_LIB_SRC:-}"
export XILINX_QUESTA_LIB="$BLUE_HD_ROOT/simulation/questa_lib/xilinx"
```

---

#### 2.3 Makefile 개선 (M2-M1)

**수정된 파일**: `simulation/questa/Makefile`

**추가된 타겟**:

| 타겟 | 기능 | 사용법 |
|:-----|:-----|:-------|
| `compile_xilinx_lib` | Xilinx 라이브러리 컴파일 | `make compile_xilinx_lib` |
| `check_libs` | 라이브러리 존재 확인 | `make check_libs` |
| `env_check` | Vivado-free 환경 확인 | `make env_check` |
| `vivado_free` | 전체 설정 검증 | `make vivado_free` |

**Makefile 변경 사항**:
```makefile
# 추가된 디렉토리 설정
SCRIPT_DIR  = scripts
XILINX_LIB_DIR = ../../questa_lib/xilinx

# 추가된 타겟
.PHONY: ... compile_xilinx_lib check_libs env_check vivado_free
```

---

#### 2.4 compile.do 개선 (M2-M2)

**수정된 파일**: `simulation/questa/compile.do`

**추가된 기능**:
1. **라이브러리 자동 감지**:
   ```tcl
   set xilinx_lib_dir "$project_root/simulation/questa_lib/xilinx"
   if {[file exists "$xilinx_lib_dir/unisim"]} {
       vmap unisim "$xilinx_lib_dir/unisim"
   }
   ```

2. **IP Netlist 유효성 검사**:
   ```tcl
   set ip_files { ... }
   foreach ip_file $ip_files {
       if {![file exists $ip_file]} {
           puts "WARNING: IP netlist not found: $ip_file"
       }
   }
   ```

3. **개선된 에러 메시지**:
   - 라이브러리 누락 시 명확한 안내
   - IP netlist 누락 시 복구 방법 제시

---

## Directory Structure

```
BLUE-HD-FPGA/xdaq_top/
├── simulation/
│   ├── questa/
│   │   ├── scripts/                    # 새로 생성됨
│   │   │   ├── compile_xilinx_lib.tcl  # Xilinx 라이브러리 컴파일 TCL
│   │   │   └── compile_xilinx_lib.sh   # 쉘 래퍼
│   │   ├── questa_lib/                 # 새로 생성됨
│   │   │   └── xilinx/                 # 컴파일된 라이브러리 저장소
│   │   │       ├── unisim/             # (컴파일 후 생성)
│   │   │       ├── unimacro/           # (컴파일 후 생성)
│   │   │       └── simprim/            # (컴파일 후 생성)
│   │   ├── setup_env.sh                # 수정됨 (Vivado 의존성 제거)
│   │   ├── Makefile                    # 수정됨 (새 타겟 추가)
│   │   ├── compile.do                  # 수정됨 (자동 감지 추가)
│   │   └── QUESTA_VIVADO_FREE_PROGRESS.md  # 본 문서
│   └── xilinx_lib_src/                 # 선택사항: 라이브러리 소스 복사본
└── .moai/
    └── specs/
        └── SPEC-QUESTA-001/            # SPEC 문서
            ├── spec.md
            ├── plan.md
            └── acceptance.md
```

---

## Next Steps (다음 단계)

### 즉시 필요한 작업

#### 1. Xilinx 라이브러리 소스 확보

**옵션 A: Vivado가 설치된 시스템에서 복사**
```bash
# Vivado 설치 경로 확인 (일반적인 위치)
ls /tools/Xilinx/Vivado/*/data/verilog/src
ls /opt/Xilinx/Vivado/*/data/verilog/src

# 환경 변수 설정
export XILINX_LIB_SRC=/tools/Xilinx/Vivado/2024.2/data/verilog/src
```

**옵션 B: 프로젝트 내에 소스 복사 (완전 독립형)**
```bash
mkdir -p BLUE-HD-FPGA/xdaq_top/simulation/xilinx_lib_src
cp -r /tools/Xilinx/Vivado/2024.2/data/verilog/src/* \
      BLUE-HD-FPGA/xdaq_top/simulation/xilinx_lib_src/

# 환경 변수 설정
export XILINX_LIB_SRC=$BLUE_HD_ROOT/simulation/xilinx_lib_src
```

**옵션 C: Xilinx 다운로드**
- Xilinx Simulation Libraries를 별도로 다운로드 (가능한 경우)
- 라이선스 확인 필요

---

#### 2. 라이브러리 컴파일 실행

```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/questa

# 환경 설정
source setup_env.sh

# 라이브러리 컴파일
make compile_xilinx_lib

# 확인
make check_libs
```

**예상 출력**:
```
============================================================
Checking Xilinx Simulation Libraries...
============================================================
  unisim:    OK
  unimacro:  OK
  simprim:   OK
============================================================
All Xilinx libraries present.
============================================================
```

---

#### 3. 컴파일 및 시뮬레이션 테스트

```bash
# 컴파일
make compile

# 시뮬레이션 (GUI)
make sim

# 또는 배치 모드
make sim_batch
```

---

## Resume Guide (재개 가이드)

### 작업을 재개할 때

1. **현재 상태 확인**:
   ```bash
   cd BLUE-HD-FPGA/xdaq_top/simulation/questa
   cat QUESTA_VIVADO_FREE_PROGRESS.md
   ```

2. **환경 설정**:
   ```bash
   source setup_env.sh
   ```

3. **진행 상황 확인**:
   ```bash
   make env_check    # 환경 확인
   make check_libs   # 라이브러리 확인
   ```

4. **다음 단계 수행**:
   - 라이브러리가 없으면: `make compile_xilinx_lib`
   - 컴파일이 안 되었으면: `make compile`
   - 시뮬레이션 테스트: `make sim`

---

## Known Issues (알려진 문제)

### 1. Xilinx 라이브러리 소스 미확보

**상태**: ⚠️ 해결 필요

**설명**: 현재 시스템에 Vivado가 설치되어 있지 않음

**해결 방법**:
- Vivado가 있는 시스템에서 라이브러리 소스 복사
- 또는 Xilinx에서 별도 다운로드

**영향**: 라이브러리 컴파일 불가 → 시뮬레이션 불가

---

### 2. IP Netlist 파일 의존성

**상태**: ℹ️ 정보

**설명**: IP 코어 netlist 파일은 Vivado에서 생성해야 함

**해결 방법**:
- 이미 생성된 netlist 파일 사용 (소스/ip/ 디렉토리)
- 필요시 Vivado에서 재생성

**영향**: 일부 IP가 없으면 해당 기능 시뮬레이션 불가

---

## Validation Checklist (검증 체크리스트)

### Phase 1: 라이브러리 설정

- [ ] XILINX_LIB_SRC 환경 변수 설정
- [ ] `make compile_xilinx_lib` 실행 성공
- [ ] `make check_libs` 통과

### Phase 2: 컴파일

- [ ] `make compile` 실행 성공
- [ ] 모든 소스 파일 컴파일 완료
- [ ] 에러/경고 없음

### Phase 3: 시뮬레이션

- [ ] `make sim_batch` 실행 성공
- [ ] 테스트벤치 통과
- [ ] 파형 분석 가능 (GUI 모드)

### Phase 4: Vivado-free 검증

- [ ] `make env_check` 통과 (XILINX_VIVADO 미설정)
- [ ] Vivado 없이 시뮬레이션 실행 가능 확인
- [ ] 기존 Vivado 환경과 결과 비교

---

## Files Modified/Created

### Modified Files
1. `simulation/questa/setup_env.sh` - Vivado 의존성 제거
2. `simulation/questa/Makefile` - 새 타겟 추가
3. `simulation/questa/compile.do` - 라이브러리 자동 감지

### Created Files
1. `simulation/questa/scripts/compile_xilinx_lib.tcl` - 라이브러리 컴파일 TCL
2. `simulation/questa/scripts/compile_xilinx_lib.sh` - 쉘 래퍼
3. `simulation/questa/QUESTA_VIVADO_FREE_PROGRESS.md` - 본 문서

### Created Directories
1. `simulation/questa/scripts/` - 스크립트 저장소
2. `simulation/questa/questa_lib/xilinx/` - 컴파일된 라이브러리 저장소

---

## References

- **SPEC 문서**: `.moai/specs/SPEC-QUESTA-001/`
- **Xilinx UG900**: Vivado Simulation Library Compilation
- **Questa Manual**: Questa Simulator Command Reference
- **프로젝트 README**: `BLUE-HD-FPGA/README.md`

---

## Contact & Support

작업 재개 시 문제 발생:
1. 본 문서의 "Resume Guide" 섹션 참조
2. `.moai/specs/SPEC-QUESTA-001/plan.md` 확인
3. Alfred에게 `/moai:alfred resume SPEC-QUESTA-001` 요청

---

**Last Updated**: 2026-01-21
**Status**: Phase 2 Complete - Waiting for Library Compilation
