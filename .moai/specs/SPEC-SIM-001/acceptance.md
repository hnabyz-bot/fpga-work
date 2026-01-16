# SPEC-SIM-001: 수용 기준

## 메타데이터

| 항목 | 값 |
|------|------|
| **SPEC ID** | SPEC-SIM-001 |
| **검증 방식** | Given-When-Then (Gherkin) |
| **품질 게이트** | TRUST 5 프레임워크 |

---

## 테스트 시나리오 (Given-When-Then)

### AC-001: 환경 설정 스크립트 검증

#### 시나리오 1: 정상 환경 설정

**Given** 사용자가 프로젝트 시뮬레이션 디렉토리에 있고
**Given** Questa가 표준 경로에 설치되어 있고
**When** 사용자가 `source setup_env.sh`를 실행하면
**Then** 환경 변수 $BLUE_HD_ROOT가 프로젝트 루트를 가리키고
**Then** 환경 변수 $BLUE_HD_SRC가 소스 디렉토리를 가리키고
**Then** vsim 명령이 PATH에서 발견되고
**Then** 사용 가능한 명령어 목록이 표시된다

#### 시나리오 2: Questa 미설치 환경

**Given** 사용자가 시스템에 Questa가 설치되어 있지 않고
**When** 사용자가 `source setup_env.sh`를 실행하면
**Then** "vsim not found" 에러 메시지가 표시되고
**Then** 환경 설정 실패를 알리는 메시지가 표시되고
**Then** 종료 코드 1이 반환된다

#### 시나리오 3: 스크립트 직접 실행 방지

**Given** 사용자가 setup_env.sh를 source 대신 직접 실행하려고 하고
**When** 사용자가 `./setup_env.sh`를 실행하면
**Then** "must be sourced, not executed" 에러가 표시되고
**Then** 올바른 사용법이 안내된다

---

### AC-002: Makefile 빌드 시스템

#### 시나리오 1: 전체 컴파일

**Given** 사용자가 환경 설정을 완료하고
**Given** 모든 소스 파일이 존재하고
**When** 사용자가 `make compile`을 실행하면
**Then** work 라이브러리가 생성되고
**Then** 모든 SystemVerilog 소스가 컴파일되고
**Then** 모든 테스트벤치가 컴파일되고
**Then** "Compilation Complete!" 메시지가 표시된다

#### 시나리오 2: GUI 시뮬레이션 실행

**Given** 사용자가 소스를 컴파일했고
**When** 사용자가 `make sim`을 실행하면
**Then** QuestaSim GUI가 열리고
**Then** wave.do가 자동으로 로드되고
**Then** 시뮬레이션이 100us 동안 실행된다

#### 시나리오 3: 배치 시뮬레이션 실행

**Given** 사용자가 소스를 컴파일했고
**When** 사용자가 `make sim_batch`를 실행하면
**Then** 시뮬레이션이 배치 모드로 실행되고
**Then** GUI 없이 실행이 완료되고
**Then** 종료 코드 0이 반환된다

#### 시나리오 4: 특정 테스트벤치 실행

**Given** 사용자가 소스를 컴파일했고
**When** 사용자가 `make sim TB=sequencer_fsm_tb`를 실행하면
**Then** sequencer_fsm_tb 테스트벤치가 실행되고
**Then** GUI에서 해당 테스트만 로드된다

---

### AC-003: 단일 테스트 실행 스크립트

#### 시나리오 1: GUI 모드 실행

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**When** 사용자가 `./run_test.sh test_bench gui`를 실행하면
**Then** 소스가 자동으로 컴파일되고
**Then** test_bench가 GUI 모드로 실행되고
**Then** "Simulation Complete!" 메시지가 표시된다

#### 시나리오 2: 배치 모드 실행

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**When** 사용자가 `./run_test.sh tb_reg_map batch`를 실행하면
**Then** tb_reg_map 테스트벤치가 배치 모드로 실행되고
**Then** 실행 완료 후 종료 코드가 반환된다

#### 시나리오 3: 존재하지 않는 테스트벤치

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**When** 사용자가 `./run_test.sh nonexistent_tb gui`를 실행하면
**Then** "Unknown testbench" 경고가 표시되고
**Then** 실행이 시도되지만 실패하고
**Then** 에러 메시지가 표시된다

#### 시나리오 4: 도움말 표시

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**When** 사용자가 `./run_test.sh --help`를 실행하면
**Then** 사용법이 표시되고
**Then** 사용 가능한 테스트벤치 목록이 표시되고
**Then** 사용 예시가 표시된다

---

### AC-004: 회귀 테스트 스크립트

#### 시나리오 1: 빠른 회귀 테스트

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**Given** 모든 테스트벤치가 컴파일되어 있고
**When** 사용자가 `./run_regression.sh --quick`를 실행하면
**Then** 3개의 주요 테스트가 순차적으로 실행되고
**Then** 각 테스트 결과가 PASS/FAIL로 표시되고
**Then** regression_results/YYYYMMDD_HHMMSS/ 디렉토리가 생성되고
**Then** regression_report.txt가 생성되고
**Then** 테스트 요약이 표시된다

#### 시나리오 2: 전체 회귀 테스트

**Given** 사용자가 시뮬레이션 디렉토리에 있고
**Given** 모든 테스트벤치가 컴파일되어 있고
**When** 사용자가 `./run_regression.sh --all`를 실행하면
**Then** 9개의 모든 테스트가 순차적으로 실행되고
**Then** 개별 로그 파일이 각 테스트별로 생성되고
**Then** 리포트에 전체 결과가 요약되고
**Then** 패스율이 백분율로 계산된다

#### 시나리오 3: 실패한 테스트 처리

**Given** 하나 이상의 테스트가 실패하고
**When** 회귀 테스트가 실행되면
**Then** 실패한 테스트가 "FAIL"로 표시되고
**Then** 실패한 테스트의 로그 파일이 보존되고
**Then** 리포트에 실패 테스트가 표시되고
**Then** 종료 코드 1이 반환된다

#### 시나리오 4: 상세 출력 모드

**Given** 사용자가 디버깅을 위해 상세 정보를 원하고
**When** 사용자가 `./run_regression.sh --verbose`를 실행하면
**Then** 각 테스트 실행에 대한 상세 정보가 표시된다

---

### AC-005: 문서화 검증

#### 시나리오 1: README.md 구조 검증

**Given** README.md 파일이 존재하고
**When** 사용자가 README.md를 열면
**Then** "Overview" 섹션이 있고
**Then** "Requirements" 섹션이 있고
**Then** "Quick Start" 섹션이 있고
**Then** "Available Testbenches" 목록이 있고
**Then** "Troubleshooting" 섹션이 있다

#### 시나리오 2: 문서 명령어 실행 가능성

**Given** README.md에 예시 명령어가 있고
**When** 사용자가 예시 명령어를 복사하여 실행하면
**Then** 모든 명령어가 에러 없이 실행된다

---

## 품질 게이트 (TRUST 5)

### Tested (테스트 주도)

- [ ] 모든 시나리오가 Given-When-Then 형식으로 정의됨
- [ ] 각 요구사항이 하나 이상의 테스트 시나리오로 커버됨
- [ ] 자동화된 회귀 테스트가 모든 주요 경로를 검증함

### Readable (가독성)

- [ ] Bash 스크립트에 명확한 주석이 포함됨
- [ ] 함수 이름이 기능을 명확히 설명함 (print_usage, compile_sources, run_simulation)
- [ ] 에러 메시지가 사용자 친화적임

### Unified (통일성)

- [ ] 모든 스크립트가 일관된 에러 처리 패턴을 따름
- [ ] 로그 형식이 통일됨 ([INFO], [WARN], [ERROR] 접두사)
- [ ] 코드 스타일이 일관됨 (들여쓰기, 변수 명명)

### Secured (보안)

- [ ] 스크립트가 set -e로 에러 propagation을 방지함
- [ ] 사용자 입력이 적절히 검증됨
- [ ] 민감한 정보가 로그에 포함되지 않음

### Trackable (추적 가능성)

- [ ] 각 스크립트가 생성된 타임스탬프 로그를 남김
- [ ] 회귀 테스트 결과가 타임스탬프로 구분됨
- [ ] 컴파일 오류가 파일과 줄 번호를 명확히 표시함

---

## Definition of Done

### 기능 완료 기준

- [ ] 모든 Given-When-Then 시나리오가 통과함
- [ ] 9개 테스트벤치가 모두 실행 가능함
- [ ] 회귀 테스트가 자동으로 전체 실행됨
- [ ] README.md가 모든 필수 섹션을 포함함

### 품질 완료 기준

- [ ] ShellCheck가 경고 없이 통과함
- [ ] 모든 에러 조건이 적절히 처리됨
- [ ] 사용자 피드백이 명확하고 친절함

### 문서화 완료 기준

- [ ] README.md가 새로운 사용자에게 충분한 정보 제공
- [ ] 모든 스크립트에 인라인 주석이 포함됨
- [ ] 예시 명령어가 실제로 동작함

### 검증 완료 기준

- [ ] 빠른 회귀 테스트 (3개)가 모두 PASS
- [ ] 전체 회귀 테스트 (9개)가 모두 PASS
- [ ] GUI 및 배치 모드가 모두 정상 작동

---

## 검증 방법

### 자동화된 검증

```bash
# 1. 환경 검증
source setup_env.sh
make check_env

# 2. 컴파일 검증
make clean
make compile

# 3. 단일 테스트 검증
./run_test.sh test_bench batch
./run_test.sh sequencer_fsm_tb batch
./run_test.sh tb_reg_map batch

# 4. 회귀 테스트 검증
./run_regression.sh --quick
./run_regression.sh --all
```

### 수동 검증 체크리스트

- [ ] GUI가 정상적으로 열리고 파형이 표시됨
- [ ] README.md의 예시가 실제로 동작함
- [ ] 에러 메시지가 명확하고 조치 가능함
- [ ] 로그 파일이 적절한 위치에 생성됨

---

## 성공 측정 지표

| 지표 | 목표 | 측정 방법 |
|------|------|----------|
| 컴파일 시간 | < 5분 | time make compile |
| 단일 테스트 로드 | < 30초 | time ./run_test.sh test_bench batch |
| 회귀 테스트 완료 | < 30분 | time ./run_regression.sh --all |
| 테스트 통과율 | 100% | regression_report.txt |
| ShellCheck 경고 | 0 | shellcheck *.sh |

---

*마지막 업데이트: 2026-01-15*
*버전: 1.0.0*
