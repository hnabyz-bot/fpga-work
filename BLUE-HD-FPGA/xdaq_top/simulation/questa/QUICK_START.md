# BLUE-HD-FPGA Questa Vivado-Free Simulation

빠른 시작 가이드 - Vivado 없이 Questa 시뮬레이션 실행하기

---

## 빠른 시작

### 1. GUI 모드 시뮬레이션
```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/questa
./run_vivado_free_sim.sh
```

### 2. 배치 모드 시뮬레이션
```bash
./run_vivado_free_sim.sh -b
```

### 3. 특정 테스트벤치 실행
```bash
./run_vivado_free_sim.sh -t sequencer_fsm_tb
```

### 4. 환경 확인만 하기
```bash
./run_vivado_free_sim.sh --check
```

---

## 스크립트 옵션

| 옵션 | 설명 |
|:-----|:-----|
| `-h, --help` | 도움말 표시 |
| `-c, --compile` | 컴파일만 수행 |
| `-b, --batch` | 배치 모드 실행 |
| `-g, --gui` | GUI 모드 실행 (기본값) |
| `-t, --test TB` | 특정 테스트벤치 지정 |
| `-T TIME` | 시뮬레이션 시간 설정 (기본값: 100us) |
| `--clean` | 컴파일 전 work 디렉토리 정리 |
| `--check` | 환경과 라이브러리 확인만 수행 |

---

## 사용 예제

### 기본 사용
```bash
# GUI 모드로 시뮬레이션 실행
./run_vivado_free_sim.sh

# 배치 모드로 실행
./run_vivado_free_sim.sh -b

# 컴파일만 하기
./run_vivado_free_sim.sh -c
```

### 고급 옵션
```bash
# 정리 후 컴파일 및 배치 실행
./run_vivado_free_sim.sh --clean -b

# 500us 동안 배치 모드 실행
./run_vivado_free_sim.sh -b -T 500us

# 특정 테스트벤치 배치 실행
./run_vivado_free_sim.sh -b -t sequencer_fsm_tb
```

---

## Make 직접 사용 (고급)

```bash
# 환경 설정
source setup_env.sh

# 컴파일
make compile

# GUI 시뮬레이션
make sim

# 배치 시뮬레이션
make sim_batch

# 특정 테스트벤치
make sim TB=sequencer_fsm_tb
```

---

## 환경 점검

```bash
# 전체 환경 확인
./run_vivado_free_sim.sh --check

# 또는
make env_check

# 라이브러리 확인
make check_libs
```

---

## 문제 해결

### Questa 를 찾을 수 없음
```bash
# Questa 환경 파일 경로 확인
ls /home/holee/TOOLS/env.sh

# setup_env.sh에서 경로 수정 (필요시)
```

### 라이브러리 누락
```bash
# Vivado 프로젝트에서 라이브러리 확인
ls build/xdaq_top.sim/sim_1/behav/questa/questa_lib/msim
```

### 컴파일 에러
```bash
# work 디렉토리 정리 후 다시 시도
./run_vivado_free_sim.sh --clean
```

---

## 파일 구조

```
simulation/questa/
├── run_vivado_free_sim.sh    # 메인 실행 스크립트
├── setup_env.sh               # 환경 설정
├── Makefile                   # 빌드 설정
├── compile.do                 # 컴파일 스크립트
├── simulate.do                # 시뮬레이션 스크립트
└── wave.do                    # 파형 설정
```

---

## 추가 정보

- **진행 문서**: `QUESTA_VIVADO_FREE_PROGRESS.md`
- **SPEC 문서**: `.moai/specs/SPEC-QUESTA-001/`
- **Make 도움말**: `make help`
