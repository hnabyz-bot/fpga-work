# SPEC-MISC-002: Initialization Module

## 태그 블록

```yaml
SPEC_ID: SPEC-MISC-002
Title: Initialization Module - Power-On Sequence Control
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: System Integration
Related: SPEC-SYS-001, SPEC-SYS-002
Module: init.sv
Lines: 477
```

---

## 1. 개요 (Overview)

### 1.1 목적

Initialization 모듈은 FPGA 시스템의 전원 온 시퀀스를 제어합니다. 순차적인 전원 공급 및 초기화 단계를 통해 시스템이 안정적으로 시작되도록 합니다.

### 1.2 주요 기능

- 전원 온 시퀀스 제어
- 6단계 초기화 (STEP1~STEP6)
- 전원 오프/다운 제어
- ROIC 리셋 생성

### 1.3 상태 머신 구조

```
IDLE → POWER_ON → STEP1 → STEP2 → STEP3 → STEP4 → STEP5 → STEP6 → IDLE
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| fsm_clk | Input | logic | 20MHz FSM 클록 |
| reset | Input | logic | 시스템 리셋 |

### 2.2 전원 제어 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| en_pwr_off | Input | logic | 전원 오프 활성화 |
| en_pwr_dwn | Input | logic | 전원 다운 활성화 |

### 2.3 초기화 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| init_rst | Output | reg | 초기화 리셋 |
| pwr_init_step1 | Output | wire | 전원 초기화 스텝 1 |
| pwr_init_step2 | Output | wire | 전원 초기화 스텝 2 |
| pwr_init_step3 | Output | wire | 전원 초기화 스텝 3 |
| pwr_init_step4 | Output | wire | 전원 초기화 스텝 4 |
| pwr_init_step5 | Output | wire | 전원 초기화 스텝 5 |
| pwr_init_step6 | Output | wire | 전원 초기화 스텝 6 |
| roic_reset | Output | wire | ROIC 리셋 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 전원 온 시퀀스 요구사항

- **FR-INIT-001**: 시스템은 **항상** 전원 적용 후 IDLE 상태에서 POWER_ON 상태로 전이해야 한다

- **FR-INIT-002**: 시스템은 **항상** POWER_ON_DELAY(25'd1000)만큼 대기한 후 STEP1 상태로 전이해야 한다
  - 실제: 100ms @ 40ns = 2,500,000 클록
  - 시뮬레이션: 1us @ 40ns = 25 클록

- **FR-INIT-003**: 시스템은 **항상** STEP_DELAY(25'd2000)만큼 대기하며 각 초기화 스텝을 진행해야 한다
  - 실제: 100ms @ 40ns = 2,500,000 클록
  - 시뮬레이션: 2us @ 40ns = 50 클록

### 3.2 초기화 스텝 제어 요구사항

- **FR-INIT-004**: 시스템은 **항상** STEP1~STEP6 상태를 순차적으로 거쳐야 한다

- **FR-INIT-005**: 각 init_step_i 신호는 **항상** pwr_init_step_i와 pwr_dwn_step_i의 AND로 생성되어야 한다
  - pwr_init_step1 = init_step1 & pwr_dwn_step1
  - pwr_init_step2 = init_step2 & pwr_dwn_step2
  - ...

- **FR-INIT-006**: 시스템은 **항상** STEP5_DELAY(25'd3000)만큼 대기한 후 STEP6로 전이해야 한다

### 3.3 전원 오프 제어 요구사항

- **FR-INIT-007**: **WHEN** en_pwr_off가 assertion되면 **THEN** 시스템은 전원 오프 시퀀스를 시작해야 한다

- **FR-INIT-008**: 시스템은 **항상** en_pwr_off의 상승 에지를 검출하여 start_pwr_off를 생성해야 한다
  - en_pwr_off_2d=1 → en_pwr_off_1d=0일 때 start_pwr_off=1

- **FR-INIT-009**: **WHEN** start_pwr_off가 생성되면 **THEN** 시스템은 pwr_off를 1로 설정하고 초기화 단계를 역순으로 진행해야 한다

- **FR-INIT-010**: 시스템은 **항상** pwr_off=1일 때 모든 init_step_i를 0으로 설정해야 한다

### 3.4 전원 다운 제어 요구사항

- **FR-INIT-011**: **WHEN** en_pwr_dwn가 assertion되면 **THEN** 시스템은 전원 다운 시퀀스를 시작해야 한다

- **FR-INIT-012**: 시스템은 **항상** en_pwr_dwn의 상승 에지를 검출하여 start_pwr_dwn_off를 생성해야 한다
  - en_pwr_dwn_2d=1 → en_pwr_dwn_1d=0일 때 start_pwr_dwn_off=1

- **FR-INIT-013**: **WHEN** start_pwr_dwn_off가 생성되면 **THEN** 시스템은 pwr_dwn_off를 1로 설정해야 한다

- **FR-INIT-014**: 시스템은 **항상** pwr_dwn_off=1일 때 모든 pwr_dwn_step_i를 0으로 설정해야 한다

- **FR-INIT-015**: 시스템은 **항상** en_pwr_dwn의 하강 에지를 검출하여 start_pwr_dwn_on을 생성해야 한다
  - en_pwr_dwn_2d=0 → en_pwr_dwn_1d=1일 때 start_pwr_dwn_on=1

- **FR-INIT-016**: **WHEN** start_pwr_dwn_on가 생성되면 **THEN** 시스템은 pwr_dwn_on을 1로 설정하고 정상 동작을 재개해야 한다

### 3.5 init_rst 생성 요구사항

- **FR-INIT-017**: 시스템은 **항상** hi_init_rst 신호를 사용하여 init_rst를 생성해야 한다

- **FR-INIT-018**: **WHEN** init_step1~step6 중 하나가 활성화되면 **THEN** 시스템은 hi_init_rst를 assertion해야 한다

- **FR-INIT-019**: **WHEN** pwr_off=1이면 **THEN** 시스템은 hi_init_rst를 deassertion해야 한다

### 3.6 ROIC 리셋 제어 요구사항

- **FR-INIT-020**: 시스템은 **항상** init_rst를 사용하여 ROIC 리셋을 생성해야 한다

- **FR-INIT-021**: ROIC 리셋은 **항상** 초기화 시퀀스 중에만 활성화되어야 한다

### 3.7 리셋 요구사항

- **FR-INIT-022**: **WHEN** reset=1이면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다
  - 모든 init_step_i = 0
  - pwr_off = 0
  - pwr_on = 1
  - pwr_dwn_off = 0
  - pwr_dwn_on = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| fsm_clk | 20 | MHz | FSM 클록 |
| fsm_clk 주기 | 50 | ns | 사이클 시간 |

### 4.2 초기화 지연 시간

| 파라미터 | 실제 | 시뮬레이션 | 단위 | 설명 |
|----------|------|-----------|------|------|
| POWER_ON_DELAY | 100 | 1 | us/ms | 전원 안정화 |
| STEP_DELAY | 100 | 2 | us/ms | 스텝 간 지연 |
| STEP5_DELAY | 150 | 3 | us/ms | 최종 지연 |

### 4.3 상태 전이 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 상태 전이 지연 | - | 2 | 클록 | reset 해제 후 |
| 스텝 활성화 지연 | - | 1 | 클록 | counter 목표 도달 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-INIT-001**: 전원 온 시퀀스가 정확히 실행되어야 한다
- **V-INIT-002**: 모든 init_step이 순차적으로 활성화되어야 한다
- **V-INIT-003**: 전원 오프 시퀀스가 정확히 실행되어야 한다
- **V-INIT-004**: 전원 다운 시퀀스가 정확히 실행되어야 한다
- **V-INIT-005**: ROIC 리셋이 올바른 타이밍에 생성되어야 한다

### 5.2 타이밍 검증

- **V-INIT-006**: 모든 지연 타이머가 정확히 카운트되어야 한다
- **V-INIT-007**: 상태 전이가 올바른 순서로 발생해야 한다

### 5.3 엣지 케이스 검증

- **V-INIT-008**: en_pwr_off와 en_pwr_dwn가 동시에 assertion되는 경우가 처리되어야 한다
- **V-INIT-009**: reset 시 모든 상태가 초기화되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- fsm_clk: 20MHz FSM 클록
- reset: 시스템 리셋
- en_pwr_off, en_pwr_dwn: 전원 제어

### 6.2 연관 모듈

- sequencer_fsm.sv: FSM 상태
- blue_hd_top.sv: 상위 모듈

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 전원 온 시나리오

**Given**: 시스템이 리셋 상태
**When**: reset=0으로 해제됨
**Then**: IDLE → POWER_ON → STEP1~STEP6 → IDLE 순서로 진행
**And** 각 스텝에서 지연 시간만큼 대기함

### 7.2 전원 오프 시나리오

**Given**: 시스템이 정상 동작 중
**When**: en_pwr_off=1
**Then**: start_pwr_off가 생성됨
**And** pwr_off=1로 설정됨
**And** 모든 init_step이 0으로 클리어됨

### 7.3 전원 다운 시나리오

**Given**: 시스템이 정상 동작 중
**When**: en_pwr_dwn=1
**Then**: start_pwr_dwn_off가 생성됨
**And** pwr_dwn_off=1로 설정됨
**And** 모든 pwr_dwn_step이 0으로 클리어됨

### 7.4 재시작 시나리오

**Given**: 전원 다운 상태 (pwr_dwn_off=1)
**When**: en_pwr_dwn가 해제됨
**Then**: start_pwr_dwn_on이 생성됨
**And** 정상 동작이 재개됨

---

## 8. 제약사항 (Constraints)

### 8.1 상태 머신 제약사항

- IDLE → POWER_ON → STEP1~STEP6 → IDLE 순환
- 전원 오프/다운 시 언제든지 중단 가능

### 8.2 타이밍 제약사항

- 모든 카운터는 25비트 (최대 33,554,431 클록)
- 지연 해상도: 1클록 @ 20MHz = 50ns

### 8.3 리소스 제약사항

- 상태 머신: 레지스터 기반
- 카운터: 최소화

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: System Integration Team*
