# SPEC-SYS-002: Sequencer FSM Module

## 태그 블록

```yaml
SPEC_ID: SPEC-SYS-002
Title: Sequencer FSM Module - Programmable Sequence Control
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: Control Logic
Related: SPEC-SYS-001, SPEC-SYS-003
Module: sequencer_fsm.sv
Lines: 577
```

---

## 1. 개요 (Overview)

### 1.1 목적

Sequencer FSM 모듈은 이미지 획득 시퀀스를 제어하는 프로그래머블 상태 머신입니다. LUT(Look-Up Table) RAM에 저장된 명령어를 순차적으로 실행하여 ROIC 이미지 획득의 각 단계(초기화, 바이어스, 플러시, 노출, 리드아웃, AED)를 제어합니다.

### 1.2 주요 기능

- 8상태 FSM 기반 시퀀스 제어
- LUT RAM 기반 프로그래머블 명령어 실행
- 반복(Iterate) 명령어 지원
- 타이머 기반 지연 제어
- FSM 상태별 제어 신호 출력
- 외부 트리거(Exit Signal) 지원

### 1.3 상태 머신 구조

```
IDLE → RST → WAIT → BACK_BIAS → FLUSH → AED_DETECT → EXPOSE_TIME → READOUT → IDLE
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 시스템 클록 (20MHz) |
| reset_i | Input | logic | 리셋 (Active High) |

### 2.2 LUT RAM 인터페이스 (RST 상태만)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| config_done_i | Input | logic | 설정 완료 신호 |
| lut_addr_i | Input | logic [7:0] | LUT 주소 |
| lut_wen_i | Input | logic | LUT 쓰기 활성화 |
| lut_write_data_i | Input | logic [63:0] | LUT 쓰기 데이터 |
| lut_read_data_o | Output | logic [63:0] | LUT 읽기 데이터 |

### 2.3 제어 신호 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| acq_mode_i | Input | logic [2:0] | 획득 모드 선택 |
| expose_size_i | Input | logic [31:0] | 노출 크기 설정 |
| exit_signal_i | Input | logic | 종료 신호 |
| roic_even_odd_i | Input | logic | ROIC 짝수/홀수 신호 |

### 2.4 FSM 상태 및 상태 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| current_state_o | Output | logic [3:0] | 현재 FSM 상태 |
| busy_o | Output | logic | FSM 사용 중 표시 |
| sequence_done_o | Output | logic | 시퀀스 완료 표시 |
| readout_wait | Output | logic | 리드아웃 대기 신호 |
| state_exit_flag_o | Output | logic | 상태 종료 플래그 |
| aed_detect_skip_oe_o | Output | logic | AED OE 스킵 제어 |

### 2.5 상태별 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| reset_state_o | Output | logic | RST 상태 활성화 |
| wait_o | Output | logic | WAIT 상태 활성화 |
| bias_enable_o | Output | logic | BACK_BIAS 상태 활성화 |
| flush_enable_o | Output | logic | FLUSH 상태 활성화 |
| expose_enable_o | Output | logic | EXPOSE_TIME 상태 활성화 |
| readout_enable_o | Output | logic | READOUT 상태 활성화 |
| aed_enable_o | Output | logic | AED_DETECT 상태 활성화 |
| stv_mask_o | Output | logic | STV 마스크 (Active High) |
| csi_mask_o | Output | logic | CSI 마스크 (Active Low) |
| panel_stable_o | Output | logic | 패널 안정화 신호 |
| idle_elable_o | Output | logic | IDLE 상태 활성화 |

### 2.6 현재 명령 파라미터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| acq_mode_o | Output | logic [2:0] | 현재 획득 모드 |
| expose_size_o | Output | logic [31:0] | 현재 노출 크기 |
| active_repeat_count_o | Output | logic [31:0] | 현재 반복 횟수 |
| current_repeat_count_o | Output | logic [31:0] | 현재 반복 횟수 |
| current_data_length_o | Output | logic [18:0] | 현재 데이터 길이 |
| current_eof_o | Output | logic | 현재 EOF 플래그 |
| current_sof_o | Output | logic | 현재 SOF 플래그 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 FSM 상태 전이 요구사항

- **FR-FSM-001**: 시스템은 **항상** 정의된 8상태 머신(RST, WAIT, BACK_BIAS, FLUSH, AED_DETECT, EXPOSE_TIME, READOUT, IDLE)을 따라야 한다

- **FR-FSM-002**: **WHEN** 리셋이 해제되면 **THEN** 시스템은 IDLE 상태로 시작해야 한다

- **FR-FSM-003**: **WHEN** config_done_i 신호가 assertion되면 **THEN** 시스템은 RST 상태로 전이하여 LUT 설정을 완료해야 한다

- **FR-FSM-004**: 시스템은 **항상** LUT의 next_state 필드에 따라 다음 상태로 전이해야 한다

- **FR-FSM-005**: **WHEN** exit_signal_i가 assertion되면 **THEN** 시스템은 현재 명령을 완료 후 IDLE 상태로 전이해야 한다

### 3.2 LUT RAM 명령어 실행 요구사항

- **FR-FSM-006**: RST 상태에서 시스템은 **항상** LUT RAM에 읽기/쓰기가 가능해야 한다

- **FR-FSM-007**: RST 상태 이외의 상태에서 시스템은 **항상** LUT RAM에서 명령어를 읽어 실행해야 한다

- **FR-FSM-008**: 시스템은 **항상** LUT 데이터의 각 필드를 올바르게 해석해야 한다
  - Bit [51:50]: iterate_index (0~3)
  - Bit [49]: iterate_en
  - Bit [48]: panel_stable
  - Bit [47]: csi_mask
  - Bit [46]: stv_mask
  - Bit [45]: sof
  - Bit [44]: eof
  - Bit [43:40]: next_state (0~15)
  - Bit [39:8]: repeat_count (0~2^32-1)
  - Bit [7:0]: next_address (0~255)

### 3.3 반복(Iterate) 제어 요구사항

- **FR-FSM-009**: **WHEN** iterate_en 비트가 1이면 **THEN** 시스템은 repeat_count만큼 현재 명령을 반복해야 한다

- **FR-FSM-010**: **IF** iterate_index가 0~3 사이의 값이면 **THEN** 시스템은 해당 인덱스의 반복 카운터를 사용해야 한다

- **FR-FSM-011**: 시스템은 **항상** 각 iterate_index별로 독립적인 반복 카운터를 유지해야 한다

### 3.4 데이터 길이 타이머 요구사항

- **FR-FSM-012**: 시스템은 **항상** data_length 필드에 지정된 클록 수만큼 각 상태에서 대기해야 한다

- **FR-FSM-013**: **WHEN** data_length 타이머가 만료되면 **THEN** 시스템은 다음 상태로 전이해야 한다

### 3.5 상태별 제어 신호 출력 요구사항

- **FR-FSM-014**: 시스템은 **항상** 현재 FSM 상태에 해당하는 제어 출력만 assertion해야 한다
  - RST: reset_state_o, stv_mask_o=1
  - WAIT: wait_o, stv_mask_o=1
  - BACK_BIAS: bias_enable_o, stv_mask_o=1
  - FLUSH: flush_enable_o
  - AED_DETECT: aed_enable_o
  - EXPOSE_TIME: expose_enable_o, csi_mask_o=0
  - READOUT: readout_enable_o, csi_mask_o=0
  - IDLE: idle_elable_o, stv_mask_o=1

- **FR-FSM-015**: 시스템은 **항상** stv_mask_o와 csi_mask_o를 올바른 레벨로 제어해야 한다
  - stv_mask_o=1: STV 신호 마스크 (활성)
  - csi_mask_o=0: CSI 출력 활성화 (Active Low)

### 3.6 패널 안정화 제어 요구사항

- **FR-FSM-016**: **WHEN** panel_stable 비트가 1이면 **THEN** 시스템은 panel_stable_o를 assertion해야 한다

### 3.7 SOF/EOF 플래그 제어 요구사항

- **FR-FSM-017**: 시스템은 **항상** LUT의 sof 및 eof 플래그를 현재 상태 출력으로 전달해야 한다

- **FR-FSM-018**: 시스템은 **항상** SOF(Start of Frame)와 EOF(End of Frame) 신호를 프레임 동기에 사용해야 한다

### 3.8 획득 모드 및 노출 제어 요구사항

- **FR-FSM-019**: 시스템은 **항상** acq_mode_i 입력을 acq_mode_o 출력으로 전달해야 한다

- **FR-FSM-020**: 시스템은 **항상** expose_size_i 입력을 expose_size_o 출력으로 전달해야 한다

### 3.9 반복 존재 플래그 요구사항

- **FR-FSM-021**: 시스템은 **항상** LUT에 iterate 명령이 존재하면 iterate_exist_o를 assertion해야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk 주파수 | 20 | MHz | 시스템 클록 |
| clk 주기 | 50 | ns | 사이클 시간 |

### 4.2 상태 전이 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 상태 전이 지연 | - | 2 | 클록 | reset_i 제거 후 첫 상태 전이 |
| LUT 읽기 지연 | - | 1 | 클록 | 주소 입력 후 데이터 유효 |

### 4.3 타이머 정밀도

| 파라미터 | 해상도 | 최대 | 단위 | 설명 |
|----------|--------|------|------|------|
| data_length 타이머 | 1 | 2^19-1 | 클록 | 50ns ~ 26.2ms |

### 4.4 반복 카운터 범위

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| repeat_count | 0 | 2^32-1 | 회 | 명령 반복 횟수 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-FSM-001**: FSM이 정의된 모든 상태(RST, WAIT, BACK_BIAS, FLUSH, AED_DETECT, EXPOSE_TIME, READOUT, IDLE)를 순회할 수 있어야 한다
- **V-FSM-002**: LUT RAM의 next_state 필드에 따라 올바른 상태 전이가 발생해야 한다
- **V-FSM-003**: 반복(Iterate) 명령이 지정된 횟수만큼 실행되어야 한다
- **V-FSM-004**: exit_signal_i가 assertion될 때 FSM이 IDLE 상태로 전이해야 한다
- **V-FSM-005**: 각 상태별 제어 신호가 올바르게 assertion/deassertion되어야 한다

### 5.2 타이밍 검증

- **V-FSM-006**: FSM 상태 전이가 2 클록 이내에 완료되어야 한다
- **V-FSM-007**: data_length 타이머가 지정된 클록 수만큼 정확히 대기해야 한다
- **V-FSM-008**: 모든 출력 신호가 타이밍 제약조건을 만족해야 한다

### 5.3 엣지 케이스 검증

- **V-FSM-009**: repeat_count=0일 때 즉시 다음 상태로 전이해야 한다
- **V-FSM-010**: LUT 주소 0~255 전체 범위가 정상적으로 액세스되어야 한다
- **V-FSM-011**: reset_i 동안 모든 출력이 정의된 초기 상태여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 20MHz 시스템 클록
- reset_i: 리셋 신호
- config_done_i: LUT 설정 완료 신호
- lut_addr_i: LUT 주소 (RST 상태만)
- lut_wen_i: LUT 쓰기 활성화 (RST 상태만)
- lut_write_data_i: LUT 쓰기 데이터 (RST 상태만)

### 6.2 LUT RAM 형식

- 크기: 256 x 64비트
- 필드: [51:0] 명령어 데이터
- 주소: 0~255

### 6.3 연관 모듈

- reg_map.sv: LUT RAM 레지스터 인터페이스
- ti_roic_tg.sv: 타이밍 생성기 제어
- roic_gate_drv.sv: 게이트 드라이브 제어

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 시퀀스 실행 시나리오

**Given**: LUT가 설정되고 config_done_i가 assertion됨
**When**: FSM이 RST 상태에서 시작됨
**Then**: FSM이 WAIT → BACK_BIAS → FLUSH → EXPOSE → READOUT 순서로 상태 전이함
**And**: 각 상태에서 data_length 타이머만큼 대기함

### 7.2 반복 명령 실행 시나리오

**Given**: LUT에 iterate_en=1, repeat_count=5, next_state=현재 상태인 명령이 저장됨
**When**: FSM이 해당 명령을 실행함
**Then**: 현재 상태를 6회 반복함 (초기 1회 + 반복 5회)

### 7.3 종료 신호 처리 시나리오

**Given**: FSM이 READOUT 상태에서 동작 중
**When**: exit_signal_i가 assertion됨
**Then**: 현재 READOUT 명령을 완료 후 IDLE 상태로 전이함

### 7.4 LUT 설정 시나리오

**Given**: FSM이 RST 상태에 있음
**When**: lut_wen_i=1, lut_addr_i=0x10, lut_write_data_i=0x123456789ABCDDEF가 입력됨
**Then**: LUT 주소 0x10에 해당 데이터가 저장됨

---

## 8. 제약사항 (Constraints)

### 8.1 상태 머신 제약사항

- FSM 상태는 정의된 8개 상태로 제한됨
- 상태 전이는 LUT의 next_state 필드에 의해서만 결정됨
- 무한 루프 방지를 위해 각 상태는 타이머 만료 후 반드시 전이해야 함

### 8.2 타이머 제약사항

- data_length 최대값: 2^19-1 클록 (약 26.2ms @ 20MHz)
- repeat_count 최대값: 2^32-1 회

### 8.3 LUT 액세스 제약사항

- LUT 쓰기는 RST 상태에서만 가능
- LUT 읽기는 모든 상태에서 가능

### 8.4 출력 제약사항

- 모든 제어 출력은 reset 시 0이어야 함 (단, csi_mask_o는 1로 Active Low)
- 상태 전이 시 그룹화된 출력이 동일한 사이클에 변경되어야 함

---

## 9. 상태 전이도 (State Transition Diagram)

```
                    +---------------------+
                    |       IDLE          |
                    +---------------------+
                             | config_done_i
                             v
                    +---------------------+
                    |        RST          | <---+
                    +---------------------+     |
                             | next_state       | iterate_en=1
                             v                  | repeat_count>0
                    +---------------------+     |
                    |       WAIT          | <---+
                    +---------------------+
                             | next_state
                             v
                    +---------------------+
                    |     BACK_BIAS       |
                    +---------------------+
                             | next_state
                             v
                    +---------------------+
                    |       FLUSH         |
                    +---------------------+
                             | next_state
                             v
                    +---------------------+     +-----------------+
                    |    AED_DETECT       |<--->|   AED_DETECT    | (repeat)
                    +---------------------+     +-----------------+
                             | next_state
                             v
                    +---------------------+     +-----------------+
                    |    EXPOSE_TIME      |<--->|   EXPOSE_TIME   | (repeat)
                    +---------------------+     +-----------------+
                             | next_state
                             v
                    +---------------------+     +-----------------+
                    |      READOUT        |<--->|     READOUT     | (repeat)
                    +---------------------+     +-----------------+
                             | next_state
                             v
                    +---------------------+
                    |       IDLE          |
                    +---------------------+

Note: exit_signal_i는 언제든지 현재 명령 완료 후 IDLE로 전이 가능
```

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: Control Logic Team*
