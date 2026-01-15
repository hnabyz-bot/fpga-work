# SPEC-MISC-001: ROIC Gate Driver Module

## 태그 블록

```yaml
SPEC_ID: SPEC-MISC-001
Title: ROIC Gate Driver Module - Gate Drive Signal Generation
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Control
Related: SPEC-SYS-001, SPEC-SYS-002
Module: roic_gate_drv.sv
Lines: 122
```

---

## 1. 개요 (Overview)

### 1.1 목적

ROIC Gate Driver 모듈은 ROIC(Readout Integrated Circuit)의 게이트 드라이브 신호(XAO)를 생성합니다. FSM 상태와 레지스터 설정에 따라 백 바이어스, 플러시, AED 모드에서 다른 타이밍으로 게이트 신호를 제어합니다.

### 1.2 주요 기능

- 백 바이어스 신호 생성
- XAO 게이트 신호 생성 (6개 채널)
- FSM 상태별 게이트 타이밍 제어
- 행/열 카운터 기반 타이밍 제어

### 1.3 게이트 신호

| 신호 | 설명 |
|------|------|
| back_bias | 백 바이어스 제어 신호 |
| gate_xao_0~5 | XAO 게이트 신호 (6개 채널) |

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| fsm_clk | Input | logic | 25MHz FSM 클록 |
| fsm_drv_rst | Input | logic | FSM 드라이버 리셋 (Active Low) |

### 2.2 FSM 및 카운터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| row_cnt | Input | logic [15:0] | 현재 행 카운터 |
| col_cnt | Input | logic [15:0] | 현재 열 카운터 |
| fsm_back_bias_index | Input | logic | FSM 백 바이어스 상태 인덱스 |
| fsm_flush_index | Input | logic | FSM 플러시 상태 인덱스 |
| col_end | Input | logic | 열 끝 신호 |

### 2.3 게이트 파라미터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| up_back_bias | Input | logic [15:0] | 상단 바이어스 설정값 |
| dn_back_bias | Input | logic [15:0] | 하단 바이어스 설정값 |
| up_aed_gate_xao[0:5] | Input | logic [15:0] | 상단 AED XAO 설정값 |
| dn_aed_gate_xao[0:5] | Input | logic [15:0] | 하단 AED XAO 설정값 |

### 2.4 게이트 신호 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| back_bias | Output | logic | 백 바이어스 출력 |
| gate_xao_0 | Output | logic | XAO 게이트 0 |
| gate_xao_1 | Output | logic | XAO 게이트 1 |
| gate_xao_2 | Output | logic | XAO 게이트 2 |
| gate_xao_3 | Output | logic | XAO 게이트 3 |
| gate_xao_4 | Output | logic | XAO 게이트 4 |
| gate_xao_5 | Output | logic | XAO 게이트 5 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 백 바이어스 신호 생성 요구사항

- **FR-GATE-001**: 시스템은 **항상** up_back_bias와 dn_back_bias 설정값에 따라 백 바이어스 신호를 생성해야 한다

- **FR-GATE-002**: **WHEN** row_cnt == up_back_bias이고 fsm_back_bias_index=1이고 col_end=1이면 **THEN** 시스템은 back_bias를 1로 설정해야 한다

- **FR-GATE-003**: **WHEN** row_cnt == dn_back_bias이고 fsm_back_bias_index=1이고 col_end=1이면 **THEN** 시스템은 back_bias를 0으로 클리어해야 한다

- **FR-GATE-004**: 시스템은 **항상** fsm_clk posedge에서 back_bias를 업데이트해야 한다

- **FR-GATE-005**: **WHEN** !fsm_drv_rst(리셋)이면 **THEN** 시스템은 back_bias를 0으로 설정해야 한다

### 3.2 XAO 게이트 신호 생성 요구사항

- **FR-GATE-006**: 시스템은 **항상** 6개의 독립적인 XAO 게이트 신호를 생성해야 한다

- **FR-GATE-007**: 각 XAO 게이트는 **항상** up_aed_gate_xao[i]와 dn_aed_gate_xao[i] 설정값에 따라 제어되어야 한다

- **FR-GATE-008**: **WHEN** col_cnt == up_aed_gate_xao[i]이고 (fsm_flush_index=1 또는 fsm_back_bias_index=1)이면 **THEN** gate_xao_i를 1로 설정해야 한다

- **FR-GATE-009**: **WHEN** col_cnt == dn_aed_gate_xao[i]이고 (fsm_flush_index=1 또는 fsm_back_bias_index=1)이면 **THEN** gate_xao_i를 0으로 클리어해야 한다

- **FR-GATE-010**: 시스템은 **항상** flush_gate_xao_reg[i] 레지스터를 사용하여 gate_xao_i를 유지해야 한다

- **FR-GATE-011**: 시스템은 **항상** generate 루프를 사용하여 6개 XAO 게이트를 생성해야 한다

### 3.3 FSM 상태별 제어 요구사항

- **FR-GATE-012**: 시스템은 **항상** fsm_flush_index 또는 fsm_back_bias_index가 활성화될 때만 XAO 게이트를 제어해야 한다

- **FR-GATE-013**: 시스템은 **항상** col_end 신호를 사용하여 타이밍 제어를 동기화해야 한다

### 3.4 리셋 요구사항

- **FR-GATE-014**: **WHEN** !fsm_drv_rst(리셋)이면 **THEN** 시스템은 모든 XAO 게이트를 1로 설정해야 한다

- **FR-GATE-015**: 리셋 시 back_bias는 **항상** 0이어야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| fsm_clk | 25 | MHz | FSM 클록 |
| fsm_clk 주기 | 40 | ns | 사이클 시간 |

### 4.2 카운터 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| row_cnt | 0 | 65535 | - | 행 카운터 범위 |
| col_cnt | 0 | 2047 | - | 열 카운터 범위 (11비트) |

### 4.3 게이트 신호 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| up_back_bias~dn_back_bias 간격 | 1 | - | 행 | 최소 간격 |
| up_aed_gate_xao~dn_aed_gate_xao 간격 | 1 | - | 열 | 최소 간격 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-GATE-001**: back_bias 신호가 설정된 타이밍에 맞춰 생성되어야 한다
- **V-GATE-002**: 모든 XAO 게이트가 독립적으로 제어되어야 한다
- **V-GATE-003**: FSM 상태에 따라 게이트 타이밍이 변경되어야 한다
- **V-GATE-004**: col_end 신호에 동기하여 게이트가 제어되어야 한다

### 5.2 타이밍 검증

- **V-GATE-005**: 모든 경로가 25MHz 클록 타이밍을 만족해야 한다
- **V-GATE-006**: 카운터 비교가 정확히 수행되어야 한다

### 5.3 엣지 케이스 검증

- **V-GATE-007**: up_back_bias == dn_back_bias일 때 동작해야 한다
- **V-GATE-008**: 리셋 시 모든 게이트가 안전한 상태여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- fsm_clk: 25MHz FSM 클록
- fsm_drv_rst: FSM 리셋
- row_cnt, col_cnt: 카운터
- fsm_back_bias_index, fsm_flush_index: FSM 상태

### 6.2 파라미터

- MAX_ACLK_INDEX: 10
- NUM_AED_XAO_LINES: 6

### 6.3 연관 모듈

- sequencer_fsm.sv: FSM 상태 제공
- ti_roic_tg.sv: 타이밍 파라미터

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 백 바이어스 생성 시나리오

**Given**: up_back_bias=100, dn_back_bias=200, fsm_back_bias_index=1
**When**: row_cnt=100, col_end=1
**Then**: back_bias=1로 설정됨
**When** row_cnt=200, col_end=1
**Then**: back_bias=0으로 클리어됨

### 7.2 XAO 게이트 제어 시나리오

**Given**: up_aed_gate_xao[0]=50, dn_aed_gate_xao[0]=100, fsm_flush_index=1
**When**: col_cnt=50
**Then**: gate_xao_0=1로 설정됨
**When** col_cnt=100
**Then**: gate_xao_0=0으로 클리어됨

### 7.3 FSM 상태 전이 시나리오

**Given**: fsm_flush_index=0에서 fsm_flush_index=1로 전이
**When**: col_cnt가 up_aed_gate_xao 값에 도달
**Then**: 해당 XAO 게이트가 제어됨

### 7.4 리셋 시나리오

**Given**: 시스템이 동작 중
**When**: !fsm_drv_rst=0(리셋 활성화)
**Then**: 모든 gate_xao_i=1로 설정됨
**And** back_bias=0으로 설정됨

---

## 8. 제약사항 (Constraints)

### 8.1 카운터 제약사항

- row_cnt: 16비트
- col_cnt: 11비트 (최대 2047)

### 8.2 타이밍 제약사항

- 모든 경로는 25MHz 클록 타이밍을 만족해야 함
- 조합 논리는 최소화되어야 함

### 8.3 리소스 제약사항

- 플립플롭: 최소화
- generate 루프 사용

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Control Team*
