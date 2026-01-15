# SPEC-MISC-003: Read Data Multiplexer Module

## 태그 블록

```yaml
SPEC_ID: SPEC-MISC-003
Title: Read Data Multiplexer Module - Channel Data Selection
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: Data Path
Related: SPEC-SYS-001, SPEC-ROIC-001
Module: read_data_mux.sv
Lines: 910
```

---

## 1. 개요 (Overview)

### 1.1 목적

Read Data Multiplexer 모듈은 14개 ROIC 채널의 데이터를 순차적으로 선택하여 MIPI CSI-2 TX로 출력합니다. 채널별 데이터 재정렬 버퍼에서 데이터를 읽고 멀티플렉싱을 수행합니다.

### 1.2 주요 기능

- 14채널 ROIC 데이터 순차 선택
- 채널별 데이터 읽기 제어
- 프레임 동기화
- MIPI CSI-2 AXI-Stream 인터페이스

### 1.3 데이터 경로

```
ROIC[0:13] → Data Reorder → Read Mux → MIPI CSI-2 TX
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 시스템 클록 |
| reset | Input | logic | 리셋 (Active High) |

### 2.2 채널 데이터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| roic_reorder_data_a[0:13] | Input | logic [23:0] | ROIC 재정렬 데이터 A |
| roic_reorder_data_b[0:13] | Input | logic [23:0] | ROIC 재정렬 데이터 B |
| roic_reorder_valid[0:13] | Input | logic | ROIC 데이터 유효 |
| roic_read_enable[0:13] | Input | logic | ROIC 읽기 활성화 |

### 2.3 채널 선택 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| select_ch[0:13] | Input | logic | 채널 선택 신호 |
| max_v_count | Input | logic [15:0] | 최대 수직 카운트 |
| max_h_count | Input | logic [15:0] | 최대 수평 카운트 |
| csi2_word_count | Input | logic [15:0] | CSI-2 워드 카운트 |

### 2.4 MIPI CSI-2 AXI-Stream 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| m_axis_tdata | Output | logic [31:0] | AXI-Stream 데이터 |
| m_axis_tvalid | Output | logic | AXI-Stream 유효 |
| m_axis_tready | Input | logic | AXI-Stream 준비 |
| m_axis_tlast | Output | logic | AXI-Stream 마지막 |

### 2.5 제어 신호

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| en_16bit_adc | Input | logic | 16비트 ADC 모드 |
| en_test_pattern_row | Input | logic | 로우 테스트 패턴 |
| en_test_roic_col | Input | logic | ROIC 컬럼 테스트 |
| fsm_read_index | Input | logic | FSM 읽기 상태 |
| burst_get_image | Input | logic | 버스트 이미지 획득 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 채널 선택 요구사항

- **FR-MUX-001**: 시스템은 **항상** select_ch 신호에 따라 활성 채널을 선택해야 한다

- **FR-MUX-002**: 시스템은 **항상** 14개 채널 중 하나를 선택하여 데이터를 출력해야 한다

- **FR-MUX-003**: **WHEN** select_ch[i]=1이면 **THEN** 시스템은 채널 i의 데이터를 선택해야 한다

### 3.2 데이터 읽기 제어 요구사항

- **FR-MUX-004**: 시스템은 **항상** 선택된 채널의 roic_read_enable를 제어해야 한다

- **FR-MUX-005**: 시스템은 **항상** 선택된 채널의 roic_reorder_data_a/b를 읽어야 한다

- **FR-MUX-006**: 시스템은 **항상** roic_reorder_valid를 확인하여 유효한 데이터를 출력해야 한다

### 3.3 데이터 포맷팅 요구사항

- **FR-MUX-007**: 시스템은 **항상** 24비트 ROIC 데이터를 32비트 AXI-Stream 데이터로 변환해야 한다

- **FR-MUX-008**: **IF** en_16bit_adc=1이면 **THEN** 시스템은 16비트 데이터를 상위 비트에 정렬해야 한다

- **FR-MUX-009**: **IF** en_test_pattern_row=1이면 **THEN** 시스템은 테스트 패턴을 생성해야 한다

- **FR-MUX-010**: **IF** en_test_roic_col=1이면 **THEN** 시스템은 ROIC 컬럼 테스트 패턴을 생성해야 한다

### 3.4 채널 순차 처리 요구사항

- **FR-MUX-011**: 시스템은 **항상** FSM 상태에 따라 채널을 순차적으로 선택해야 한다

- **FR-MUX-012**: 시스템은 **항상** 채널 간 데이터 경계를 유지해야 한다

- **FR-MUX-013**: 시스템은 **항상** 프레임 동기화를 위해 m_axis_tlast를 적절히 설정해야 한다

### 3.5 카운터 제어 요구사항

- **FR-MUX-014**: 시스템은 **항상** max_v_count 및 max_h_count를 사용하여 출력 데이터 크기를 제어해야 한다

- **FR-MUX-015**: 시스템은 **항상** csi2_word_count를 사용하여 전송할 워드 수를 추적해야 한다

- **FR-MUX-016**: **WHEN** csi2_word_count가 max_h_count에 도달하면 **THEN** 시스템은 해당 행 전송을 완료해야 한다

### 3.6 버스트 모드 요구사항

- **FR-MUX-017**: **WHEN** burst_get_image=1이면 **THEN** 시스템은 모든 채널 데이터를 연속적으로 읽어야 한다

- **FR-MUX-018**: 버스트 모드에서 시스템은 **항상** 최소한의 지연으로 채널을 전환해야 한다

### 3.7 AXI-Stream 인터페이스 요구사항

- **FR-MUX-019**: **WHEN** m_axis_tready=1이면 **THEN** 시스템은 m_axis_tvalid를 assertion하고 데이터를 전송해야 한다

- **FR-MUX-020**: 시스템은 **항상** m_axis_tdata에 32비트 데이터를 제공해야 한다

- **FR-MUX-021**: **WHEN** 프레임 전송이 완료되면 **THEN** 시스템은 m_axis_tlast를 assertion해야 한다

### 3.8 리셋 요구사항

- **FR-MUX-022**: **WHEN** reset=1이면 **THEN** 시스템은 모든 상태를 초기화해야 한다
  - m_axis_tvalid = 0
  - m_axis_tlast = 0
  - 모든 카운터 = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk | 100 | MHz | 시스템 클록 |
| clk 주기 | 10 | ns | 사이클 시간 |

### 4.2 데이터 처리 타이밍

| 파라미터 | 최대 | 단위 | 설명 |
|----------|-----|------|------|
| 채널 전환 시간 | 10 | ns | 최대 |
| 데이터 처리 지연 | 20 | ns | 입력 → 출력 |

### 4.3 AXI-Stream 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| m_axis_tdata 셋업 | 1 | - | 클록 | m_axis_tvalid 전 |
| m_axis_tdata 홀드 | 1 | - | 클록 | m_axis_tvalid 동안 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-MUX-001**: 모든 채널 데이터가 정확히 선택되어야 한다
- **V-MUX-002**: 채널 순차 처리가 올바르게 수행되어야 한다
- **V-MUX-003**: AXI-Stream 인터페이스가 정상 동작해야 한다
- **V-MUX-004**: 테스트 패턴이 정확히 생성되어야 한다
- **V-MUX-005**: 16비트/24비트 모드 전환이 올바르게 수행되어야 한다

### 5.2 타이밍 검증

- **V-MUX-006**: 모든 경로가 100MHz 클록 타이밍을 만족해야 한다
- **V-MUX-007**: 채널 전환이 지연 제한 내에 완료되어야 한다

### 5.3 엣지 케이스 검증

- **V-MUX-008**: select_ch가 여러 개일 때 첫 번째 채널이 선택되어야 한다
- **V-MUX-009**: FIFO가 꽉 찼을 때 backpressure가 적용되어야 한다
- **V-MUX-010**: 리셋 시 모든 출력이 안전한 상태여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 100MHz 시스템 클록
- reset: 리셋
- select_ch[0:13]: 채널 선택
- roic_*: ROIC 채널 데이터

### 6.2 연관 모듈

- ti_roic_top.sv: ROIC 채널 (14개)
- mipi_csi2_tx_top.sv: MIPI CSI-2 TX
- sequencer_fsm.sv: FSM 상태

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 단일 채널 선택 시나리오

**Given**: select_ch[5]=1, 나머지 모두 0
**When**: ROIC 채널 5에 유효한 데이터가 존재
**Then**: 채널 5 데이터가 AXI-Stream으로 출력됨

### 7.2 순차 채널 처리 시나리오

**Given**: FSM이 READ 상태
**When**: 채널 0 전송 완료
**Then**: select_ch[1]이 활성화되고 채널 1 데이터 전송 시작

### 7.3 버스트 모드 시나리오

**Given**: burst_get_image=1
**When**: 14개 채널 모두에 데이터가 존재
**Then**: 모든 채널 데이터가 연속적으로 전송됨

### 7.4 16비트 모드 시나리오

**Given**: en_16bit_adc=1
**When**: 16비트 데이터가 입력됨
**Then**: 32비트 AXI-Stream 데이터로 변환됨 (상위 16비트에 정렬)

### 7.5 테스트 패턴 시나리오

**Given**: en_test_pattern_row=1
**When** en_test_roic_col=1
**Then**: 테스트 패턴이 생성되어 AXI-Stream으로 출력됨

---

## 8. 제약사항 (Constraints)

### 8.1 채널 수 제약사항

- 최대 채널 수: 14
- 동시 선택 채널 수: 1

### 8.2 타이밍 제약사항

- 모든 경로는 100MHz 클록 타이밍을 만족해야 함
- 조합 논리는 최소화되어야 함

### 8.3 리소스 제약사항

- MUX: 14:1 (24비트)
- 데이터 폭 변환: 24비트 → 32비트

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: Data Path Team*
