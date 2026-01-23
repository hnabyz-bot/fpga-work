# SPEC-QUESTA-001: 수용 조건

## TAG BLOCK

```
SPEC_ID: SPEC-QUESTA-001
RELATED_SPEC: spec.md, plan.md
DOCUMENT_TYPE: Acceptance Criteria
STATUS: Active
```

---

## 수용 조건 개요

이 문서는 SPEC-QUESTA-001의 수용 조건을 Gherkin 형식(Given-When-Then)으로 정의합니다. 모든 조건은 EARS 요구사항과 매핑됩니다.

---

## 기능 수용 조건 (Functional Acceptance Criteria)

### AC-001: Vivado 없는 환경 설정

**관련 요구사항**: REQ-E-002, REQ-UW-002

**Scenario 1: setup_env.sh 실행 시 Vivado 경로 미설정**

```
Given 시스템에 Vivado가 설치되어 있지 않거나 라이선스가 없음
And 사용자가 simulation/questa 디렉토리에 있음
When 사용자가 'source setup_env.sh'를 실행하면
Then Vivado 경로 관련 메시지가 표시되지 않아야 함
And XILINX_VIVADO 환경 변수가 설정되지 않아야 함
And Questa 환경만 설정되어야 함
```

**Scenario 2: Vivado 설치되어 있지만 무시**

```
Given 시스템에 Vivado가 설치되어 있음
When 사용자가 'source setup_env.sh'를 실행하면
Then Vivado settings64.sh가 source되지 않아야 함
And XILINX_QUESTA_LIB 환경 변수만 설정되어야 함
```

---

### AC-002: Xilinx 라이브러리 컴파일

**관련 요구사항**: REQ-E-004, REQ-U-003, SP-001

**Scenario 1: 라이브러리 소스 존재 시 컴파일 성공**

```
Given Xilinx 라이브러리 소스가 접근 가능한 위치에 있음
And 사용자가 'make compile_xilinx_lib'를 실행함
When 컴파일이 완료되면
Then unisim 라이브러리가 생성되어야 함
And unimacro 라이브러리가 생성되어야 함
And simprim 라이브러리가 생성되어야 함
And glbl.v가 컴파일되어야 함
```

**Scenario 2: 라이브러리 소스 미존재 시 명확한 에러**

```
Given Xilinx 라이브러리 소스가 존재하지 않음
When 사용자가 'make compile_xilinx_lib'를 실행하면
Then "소스를 찾을 수 없음" 에러 메시지가 표시되어야 함
And 소스 확보 방법이 안내되어야 함
```

---

### AC-003: 독립 컴파일 실행

**관련 요구사항**: REQ-E-001, REQ-U-001, REQ-U-002

**Scenario 1: Vivado 없이 컴파일 성공**

```
Given Vivado가 설치되어 있지 않거나 라이선스가 없음
And Xilinx 라이브러리가 이미 컴파일되어 있음
And IP netlist 파일들이 존재함
When 사용자가 'make compile'을 실행하면
Then 모든 소스 파일이 컴파일되어야 함
And Vivado 관련 에러가 발생하지 않아야 함
And work 라이브러리가 생성되어야 함
```

**Scenario 2: 라이브러리 미존재 시 컴파일 실패**

```
Given Xilinx 라이브러리가 컴파일되어 있지 않음
When 사용자가 'make compile'을 실행하면
Then "라이브러리를 찾을 수 없음" 에러가 발생해야 함
And 'make compile_xilinx_lib' 실행이 제안되어야 함
```

---

### AC-004: 시뮬레이션 실행

**관련 요구사항**: REQ-U-001, REQ-U-003

**Scenario 1: GUI 모드 시뮬레이션**

```
Given 모든 소스가 컴파일되어 있음
And Vivado가 실행되어 있지 않음
When 사용자가 'make sim'을 실행하면
Then Questa GUI가 시작되어야 함
And 시뮬레이션이 정상적으로 로드되어야 함
And Vivado 라이선스 검증이 발생하지 않아야 함
```

**Scenario 2: 배치 모드 시뮬레이션**

```
Given 모든 소스가 컴파일되어 있음
When 사용자가 'make sim_batch'를 실행하면
Then 시뮬레이션이 백그라운드에서 실행되어야 함
And 종료 코드가 0이어야 함
And transcript에 에러가 없어야 함
```

---

### AC-005: IP netlist 파일 처리

**관련 요구사항**: REQ-E-003, REQ-S-002

**Scenario 1: 모든 IP netlist 존재**

```
Given clk_ctrl_sim_netlist.v가 존재함
And seq_lut_sim_netlist.v가 존재함
And indata_ram_sim_netlist.v가 존재함
When 컴파일이 실행되면
Then 모든 IP netlist가 컴파일되어야 함
And 경고 없이 컴파일되어야 함
```

**Scenario 2: 일부 IP netlist 누락**

```
Given clk_ctrl_sim_netlist.v가 존재하지 않음
When 컴파일이 실행되면
Then "IP netlist를 찾을 수 없음" 에러가 발생해야 함
And 누락된 파일명이 명시되어야 함
And Vivado에서 재생성 방법이 안내되어야 함
```

---

## 비기능 수용 조건 (Non-Functional Acceptance Criteria)

### AC-NF-001: 환경 확인

**관련 요구사항**: REQ-S-001, REQ-S-003

**Scenario 1: Vivado 없는 환경 확인**

```
Given Vivado가 설치되어 있지 않음
When 사용자가 'make env_check'를 실행하면
Then "Vivado 없음" 상태로 확인되어야 함
And 검증이 통과되어야 함
```

**Scenario 2: Xilinx 라이브러리 확인**

```
Given Xilinx 라이브러리가 컴파일되어 있음
When 사용자가 'make check_libs'를 실행하면
Then 모든 라이브러리가 존재함이 확인되어야 함
And 각 라이브러리 상태가 표시되어야 함
```

---

### AC-NF-002: 성능

**Scenario 1: 컴파일 시간**

```
Given Xilinx 라이브러리가 이미 컴파일되어 있음
When 사용자가 'make compile'을 실행하면
Then 컴파일은 5분 이내에 완료되어야 함
```

**Scenario 2: 시뮬레이션 시작 시간**

```
Given 컴파일이 완료된 상태
When 사용자가 'make sim_batch'를 실행하면
Then 시뮬레이션은 30초 이내에 시작되어야 함
```

---

### AC-NF-003: 호환성

**Scenario 1: 기존 환경과의 동등성**

```
Given 동일한 소스와 테스트벤치
When 독립 환경과 Vivado 환경에서 시뮬레이션을 실행하면
Then 두 환경의 시뮬레이션 결과가 동일해야 함
And 타이밍 외의 동작이 일치해야 함
```

---

## 회귀 테스트 수용 조건 (Regression Test Acceptance Criteria)

### AC-RT-001: 전체 테스트벤치 실행

**Scenario 1: 모든 테스트벤치 컴파일**

```
Given Xilinx 라이브러리가 컴파일되어 있음
When 사용자가 'make regression'을 실행하면
Then 모든 테스트벤치가 컴파일되어야 함
And 컴파일 에러가 없어야 함
```

**Scenario 2: 모든 테스트벤치 실행**

```
Given 모든 테스트벤치가 컴파일되어 있음
When 사용자가 'make regression'을 실행하면
Then 모든 테스트벤치가 순차적으로 실행되어야 함
And 각 테스트 결과가 기록되어야 함
And 최종 요약이 표시되어야 함
```

---

## 문서화 수용 조건 (Documentation Acceptance Criteria)

### AC-DOC-001: 진행 상황 기록

**Scenario 1: 작업 항목 완료 표시**

```
Given 작업 항목이 정의되어 있음
When 작업이 완료되면
Then 해당 항목이 체크되어야 함
And 완료 날짜가 기록되어야 함
```

**Scenario 2: 문제 해결 기록**

```
Given 문제가 발생함
When 문제가 해결되면
Then 문제와 해결책이 기록되어야 함
And 재발 방지 가이드가 포함되어야 함
```

---

## Definition of Done

각 작업 항목은 다음 조건을 모두 충족해야 "완료"로 간주됩니다:

### 코드 완료 기준

- [ ] EARS 요구사항에 맞게 구현됨
- [ ] 단위 테스트 통과
- [ ] 코드 리뷰 완료
- [ ] 기존 기능 회귀 없음

### 문서 완료 기준

- [ ] 기술 노트 작성됨
- [ ] 사용자 가이드 업데이트됨
- [ ] 변경 로그 기록됨

### 검증 완료 기준

- [ ] Vivado 없는 환경에서 테스트 통과
- [ ] 기존 환경과 결과 동등성 확인
- [ ] 회귀 테스트 통과

---

## 품질 게이트 (Quality Gates)

### Gate 1: 1단계 완료 (M1)

- [ ] setup_env.sh에서 Vivado 의존성 제거
- [ ] Xilinx 라이브러리 컴파일 성공
- [ ] `make compile` 실행 성공
- [ ] 간단한 테스트벤치 시뮬레이션 성공

### Gate 2: 2단계 완료 (M2)

- [ ] 모든 테스트벤치 컴파일 성공
- [ ] 회귀 테스트 100% 통과
- [ ] Vivado 환경과 결과 비교 완료

### Gate 3: 3단계 완료 (M3)

- [ ] Docker 이미지 빌드 성공
- [ ] CI/CD 파이프라인 통합 완료
- [ ] 문서화 완료

---

## 검증 방법 (Verification Methods)

### 자동화된 테스트

1. **환경 확인 스크립트**: `make env_check`
2. **라이브러리 확인 스크립트**: `make check_libs`
3. **회귀 테스트**: `make regression`

### 수동 검증

1. **시각적 검사**: 파형 비교
2. **로그 검사**: transcript 확인
3. **결과 비교**: Vivado 환경과의 동등성

---

## 수용 테스트 절차 (Acceptance Test Procedure)

### 절차 1: 초기 환경 설정

```
1. Vivado 라이선스 서버 중지 (가능한 경우)
2. XILINX_VIVADO 환경 변수 미설정 확인
3. Questa 환경만 source
4. 'make env_check' 실행
```

### 절차 2: 라이브러리 컴파일

```
1. 'make compile_xilinx_lib' 실행
2. 컴파일 완료 확인
3. 'make check_libs' 실행
4. 모든 라이브러리 존재 확인
```

### 절차 3: 소스 컴파일

```
1. 'make compile' 실행
2. 컴파일 에러 없음 확인
3. work 라이브러리 생성 확인
```

### 절차 4: 시뮬레이션 실행

```
1. 'make sim_batch' 실행
2. 종료 코드 0 확인
3. transcript 검토
4. 파형 확인 (GUI 모드)
```

### 절차 5: 회귀 테스트

```
1. 'make regression' 실행
2. 모든 테스트 통과 확인
3. 결과 요약 검토
```

---

## 수용 조건 검토 체크리스트

### 기능적 요구사항

- [ ] AC-001: Vivado 없는 환경 설정 가능
- [ ] AC-002: Xilinx 라이브러리 컴파일 가능
- [ ] AC-003: 독립 컴파일 실행 가능
- [ ] AC-004: 시뮬레이션 실행 가능
- [ ] AC-005: IP netlist 파일 처리 가능

### 비기능적 요구사항

- [ ] AC-NF-001: 환경 확인 가능
- [ ] AC-NF-002: 성능 기준 충족
- [ ] AC-NF-003: 호환성 확인

### 회귀 테스트

- [ ] AC-RT-001: 전체 테스트벤치 실행 가능

### 문서화

- [ ] AC-DOC-001: 진행 상황 기록 가능

---

## 최종 수용 기준 (Final Acceptance Criteria)

이 SPEC은 다음 조건이 모두 충족될 때 "완료"로 간주됩니다:

1. Vivado가 설치되지 않은 시스템에서 시뮬레이션 실행 가능
2. 모든 테스트벤치가 컴파일 및 실행 가능
3. 기존 Vivado 환경과 시뮬레이션 결과 동등
4. 회귀 테스트 100% 통과
5. 사용자 문서가 완료되어 재현 가능

---

*수용 조건 생성: 2026-01-21*
*마지막 수정: 2026-01-21*
*버전: 1.0.0*
