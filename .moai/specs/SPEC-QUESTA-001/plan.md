# SPEC-QUESTA-001: 구현 계획

## TAG BLOCK

```
SPEC_ID: SPEC-QUESTA-001
RELATED_SPEC: spec.md
DOCUMENT_TYPE: Implementation Plan
STATUS: Active
```

---

## 구현 개요

이 문서는 SPEC-QUESTA-001의 구현 계획을 정의합니다. Vivado 의존성을 제거하고 Questa 독립 시뮬레이션 환경을 구축하기 위한 단계별 접근 방식을 제공합니다.

---

## 마일스톤 (Milestones)

### Priority High (1단계: 핵심 기능)

**M1-H1**: Xilinx 라이브러리 독립화
- UNISIM/SIMPRIM 라이브러리 컴파일 스크립트 작성
- 라이브러리 저장소 구조 생성

**M1-H2**: 환경 설정 스크립트 개선
- setup_env.sh에서 Vivado 의존성 제거
- Xilinx 라이브러리 경로 설정 추가

**M1-H3**: 기본 동작 검증
- Vivado 없이 `make compile` 실행 성공
- 간단한 테스트벤치 시뮬레이션 성공

### Priority Medium (2단계: 안정화)

**M2-M1**: Makefile 개선
- 독립 실행 타겟 추가
- 라이브러리 확인 타겟 추가

**M2-M2**: compile.do 개선
- 자동 라이브러리 감지
- 명확한 에러 메시지 추가

**M2-M3**: 회귀 테스트 실행
- 모든 테스트벤치 시뮬레이션 성공
- Vivado 환경과 결과 비교

### Priority Low (3단계: 최적화)

**M3-L1**: Docker 컨테이너화
- Dockerfile 작성
- 컨테이너 내에서 시뮬레이션 실행

**M3-L2**: CI/CD 통합
- GitHub Actions 워크플로우 작성
- 자동화된 회귀 테스트

---

## 기술 접근 방식 (Technical Approach)

### 1. Xilinx 라이브러리 독립화

#### 1.1 라이브러리 소스 확보

**옵션 A: Vivado 설치 디렉토리에서 복사**
```bash
# Vivado 데이터 디렉토리
$VIVADO_DIR/data/verilog/src/
├── unisims/
├── unimacro/
└── simprims/
```

**옵션 B: Xilinx 웹사이트에서 다운로드**
- Xilinx Simulation Libraries 패키지 다운로드
- 별도 라이선스 불필요 (일반적으로)

#### 1.2 라이브러리 컴파일 스크립트

**파일**: `simulation/questa/scripts/compile_xilinx_lib.tcl`

```tcl
# Xilinx 라이브러리 컴파일 스크립트
# Questa 전용

# 라이브러리 생성
vlib unisim
vlib unimacro
vlib simprim
vlib xilinxcorelib

# 라이브러리 매핑
vmap unisim unisim
vmap unimacro unimacro
vmap simprim simprim
vmap xilinxcorelib xilinxcorelib

# UNISIM 컴파일
vlog -work unisim -sv +incdir+<source_dir> \
    <source_dir>/unisims/*.v

# UNIMACRO 컴파일
vlog -work unimacro -sv +incdir+<source_dir> \
    <source_dir>/unimacro/*.v

# SIMPRIM 컴파일 (타이밍 시뮬레이션용)
vlog -work simprim -sv +incdir+<source_dir> \
    <source_dir>/simprims/*.v

# glbl.v 컴파일 (글로벌 초기화)
vlog -work unisim <source_dir>/glbl.v
```

#### 1.3 라이브러리 저장 구조

```
simulation/questa_lib/
├── xilinx/
│   ├── unisim/
│   ├── unimacro/
│   ├── simprim/
│   └── xilinxcorelib/
└── README.md
```

### 2. 환경 설정 스크립트 개선

#### 2.1 setup_env.sh 수정

**제거할 코드**:
```bash
# Line 51-68: Vivado Environment 섹션 전체 제거
VIVADO_ENV="/tools/Xilinx/Vivado/2023.2/settings64.sh"
# ... 모든 Vivado 관련 코드
```

**추가할 코드**:
```bash
#------------------------------------------------------------------------------
# Xilinx Simulation Libraries (Questa compiled)
#------------------------------------------------------------------------------
export XILINX_QUESTA_LIB="$BLUE_HD_ROOT/simulation/questa_lib/xilinx"

if [ -d "$XILINX_QUESTA_LIB/unisim" ]; then
    echo "[INFO] Xilinx simulation libraries found."
else
    echo "[WARN] Xilinx simulation libraries not found."
    echo "[INFO] Run 'make compile_xilinx_lib' to generate."
fi
```

#### 2.2 환경 변수 정의

| 환경 변수 | 용도 | 예시 |
|-----------|------|------|
| `QUESTA_SIM_LIB` | 시뮬레이션 라이브러리 루트 | `.../questa_lib` |
| `XILINX_QUESTA_LIB` | Xilinx 라이브러리 경로 | `.../questa_lib/xilinx` |

### 3. Makefile 개선

#### 3.1 새로운 타겟 추가

**compile_xilinx_lib 타겟**:
```makefile
compile_xilinx_lib:
	@echo "Compiling Xilinx simulation libraries..."
	@./scripts/compile_xilinx_lib.sh
```

**check_libs 타겟**:
```makefile
check_libs:
	@echo "Checking simulation libraries..."
	@test -d "$(XILINX_QUESTA_LIB)/unisim" || \
	    (echo "ERROR: unisim library not found" && exit 1)
	@echo "  unisim: OK"
	@test -d "$(XILINX_QUESTA_LIB)/unimacro" || \
	    (echo "ERROR: unimacro library not found" && exit 1)
	@echo "  unimacro: OK"
	@echo "All libraries present."
```

**env_check 타겟**:
```makefile
env_check:
	@echo "Checking Vivado-free environment..."
	@echo "  VIVADO: $${XILINX_VIVADO:-<not set>}"
	@test -z "$$XILINX_VIVADO" || \
	    (echo "WARNING: XILINX_VIVADO is set!" && exit 1)
	@echo "  XILINX_QUESTA_LIB: $$XILINX_QUESTA_LIB"
	@echo "Environment check passed."
```

#### 3.2 compile 타겟 수정

```makefile
compile: check_libs lib
	@echo "============================================================"
	@echo "Compiling BLUE-HD-FPGA..."
	@echo "============================================================"
	# ... 기존 컴파일 로직
```

### 4. compile.do 개선

#### 4.1 라이브러리 자동 감지

```tcl
# Xilinx 라이브러리 확인
set XILINX_LIB_PATH "$BLUE_HD_ROOT/simulation/questa_lib/xilinx"

if {![file exists "$XILINX_LIB_PATH/unisim"]} {
    puts "ERROR: Xilinx UNISIM library not found!"
    puts "Please run 'make compile_xilinx_lib' first."
    exit 1
}

# 라이브러리 매핑
vmap unisim $XILINX_LIB_PATH/unisim
vmap unimacro $XILINX_LIB_PATH/unimacro
vmap simprim $XILINX_LIB_PATH/simprim
```

#### 4.2 에러 메시지 개선

```tcl
# IP netlist 확인
set IP_FILES {
    "../../source/ip/clk_ctrl/clk_ctrl_sim_netlist.v"
    "../../source/ip/seq_lut/seq_lut_sim_netlist.v"
    "../../source/ip/indata_ram/indata_ram_sim_netlist.v"
}

foreach ip_file $IP_FILES {
    if {![file exists $ip_file]} {
        puts "ERROR: IP netlist not found: $ip_file"
        puts "Please generate from Vivado or copy from existing project."
        exit 1
    }
}
```

---

## 위험 및 완화 계획 (Risks and Mitigation)

### 위험 1: Xilinx 라이브러리 소스 미확보

**확률**: Medium
**영향**: High

**완화 계획**:
1. Vivado 설치된 시스템에서 소스 복사 (1차)
2. Xilinx GitHub에서 오픈 소스 라이브러리 확인 (2차)
3. 최소 프리미티브만 직접 구현 (3차)

### 위험 2: IP netlist 버전 불일치

**확률**: Medium
**영향**: Medium

**완화 계획**:
1. IP netlist 버전 관리
2. Vivado 버전 명시
3. netlist 재생성 가이드 제공

### 위험 3: 시뮬레이션 결과 불일치

**확률**: Low
**영향**: High

**완화 계획**:
1. 기존 Vivado 환경과 결과 비교
2. 회귀 테스트 실행
3. 파형 비교 자동화

### 위험 4: Docker 이미지 크기

**확률**: Low
**영향**: Low

**완화 계획**:
1. Multi-stage 빌드 사용
2. 라이브러리만 레이어로 분리
3. 필요 최소한의 도구만 포함

---

## 성공 기준 (Success Criteria)

### 1단계 기준 (M1)

- [ ] `source setup_env.sh` 실행 시 Vivado 경로 미설정 확인
- [ ] `make compile` 실행 시 컴파일 성공
- [ ] `make env_check` 통과
- [ ] 간단한 테스트벤치 시뮬레이션 성공

### 2단계 기준 (M2)

- [ ] 모든 테스트벤치 컴파일 성공
- [ ] 회귀 테스트 통과
- [ ] Vivado 환경과 시뮬레이션 결과 일치

### 3단계 기준 (M3)

- [ ] Docker 이미지 빌드 성공
- [ ] 컨테이너 내 시뮬레이션 실행 성공
- [ ] CI/CD 파이프라인 통합

---

## 다음 단계 (Next Steps)

### 즉시 실행

1. **tasks.md** 작업 항목 확인
2. **Xilinx 라이브러리 소스 확보** (M1-H1)
3. **setup_env.sh 수정** (M1-H2)

### 단계별 진행

1. **1주차**: Xilinx 라이브러리 컴파일 및 검증
2. **2주차**: 스크립트 개선 및 테스트
3. **3주차**: 회귀 테스트 및 문서화

---

## 의존성 관리

### 외부 의존성

| 항목 | 버전 | 용도 | 독립화 가능 여부 |
|------|------|------|------------------|
| Questa Simulator | 2024.3+ | 시뮬레이션 | No (필수) |
| Xilinx 라이브러리 소스 | - | 프리미티브 모델 | Yes (복사) |
| IP netlist 파일 | Vivado 2024.2 | IP 모델 | Partial (재생성 필요) |

### 내부 의존성

- **SPEC-SIM-001**: 기존 시뮬레이션 환경 설정
- **project/tech.md**: 기술 스택 문서

---

## 참고 문헌

- Xilinx UG900: "Vivado Simulation Library Compilation"
- Siemens EDA: "Questa Simulator Command Reference"
- Docker Documentation: "Multi-stage builds"

---

*계획 생성: 2026-01-21*
*마지막 수정: 2026-01-21*
*버전: 1.0.0*
