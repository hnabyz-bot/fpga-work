# SPEC-ROIC-002: TI ROIC Timing Generator Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-002
Title: TI ROIC Timing Generator - Pulse Signal Generation
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Control
Related: SPEC-ROIC-001, SPEC-SYS-002
Module: ti_roic_tg.sv
Lines: 754
```

---

## 1. 개요 (Overview)

### 1.1 목적

TI ROIC Timing Generator 모듈은 ROIC(Readout Integrated Circuit) 동작을 위한 다양한 타이밍 신호를 생성합니다. 레지스터에 설정된 상한/하한 값에 기반하여 카운터를 비교하고 펄스 신호(IRST, SHR, SHS, LPF1, LPF2, TDEF, GATE_ON, DF_SM)를 생성합니다.

### 1.2 주요 기능

- 레지스터 기반 타이밍 파라미터 설정
- 다중 모드(A/B) 타이밍 제어
- 프로그래머블 펄스 생성 (IRST, SHR, SHS 등)
- ROIC 동기화 신호 생성 (ROIC_SYNC)
- 수직/수평 카운터 관리
- 게이트 신호 생성 (STV, CPV, OE)
- FIFO 기반 타이밍 데이터 저장

### 1.3 타이밍 신호

| 신호 | 설명 |
|------|------|
| IRST | Integrated Reset |
| SHR | Sample and Hold Reset |
| SHS | Sample and Hold Start |
| LPF1/2 | Low Pass Filter |
| TDEF | Timing Default |
| GATE_ON | 게이트 활성화 |
| DF_SM0~5 | Data Format State Machine |

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 시스템 클록 |
| rst | Input | logic | 리셋 (Active High) |

### 2.2 제어 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| str | Input | logic [1:0] | 스캔 타임 레인지 |
| sync_in | Input | logic | 동기화 입력 |
| tp_sel | Input | logic | 테스트 패턴 선택 |
| aed_detect_skip_oe | Input | logic | AED OE 스킵 |
| fsm_read_index | Input | logic | FSM 읽기 인덱스 |

### 2.3 레지스터 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| reg_en | Input | logic | 레지스터 활성화 |
| reg_addr | Input | logic [7:0] | 레지스터 주소 |
| reg_data | Input | logic [15:0] | 레지스터 데이터 |

### 2.4 타이밍 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| sync_start | Output | logic | 동기화 시작 |
| readout_width | Output | logic [10:0] | 리드아웃 폭 |
| tg_row_cnt | Output | logic [15:0] | 타이밍 생성기 행 카운터 |
| tg_col_cnt | Output | logic [10:0] | 타이밍 생성자 컬럼 카운터 |
| roic_sync_out | Output | logic | ROIC 동기화 출력 |
| roic_a_bz | Output | logic | ROIC A/B 모드 선택 |

### 2.5 게이트 신호 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| tg_stv | Output | logic | 타이밍 생성자 STV |
| tg_cpv | Output | logic | 타이밍 생성자 CPV |
| tg_oe | Output | logic | 타이밍 생성자 OE |
| v_sync | Output | logic | 수직 동기화 |

### 2.6 타이밍 펄스 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| IRST | Output | logic | Integrated Reset 펄스 |
| SHR | Output | logic | Sample and Hold Reset 펄스 |
| SHS | Output | logic | Sample and Hold Start 펄스 |
| LPF1 | Output | logic | Low Pass Filter 1 펄스 |
| LPF2 | Output | logic | Low Pass Filter 2 펄스 |
| TDEF | Output | logic | Timing Default 펄스 |
| GATE_ON | Output | logic | 게이트 활성화 펄스 |
| DF_SM0~5 | Output | logic | Data Format State Machine 펄스 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 타이밍 파라미터 설정 요구사항

- **FR-TG-001**: 시스템은 **항상** 레지스터 인터페이스를 통해 타이밍 파라미터를 설정할 수 있어야 한다
  - IRST_rise_a/b, IRST_fall_a/b
  - SHR_rise_a/b, SHR_fall_a/b
  - SHS_rise_a/b, SHS_fall_a/b
  - LPF1_rise_a/b, LPF1_fall_a/b
  - LPF2_rise_a/b, LPF2_fall_a/b
  - TDEF_rise_a/b, TDEF_fall_a/b
  - GATE_rise_a/b, GATE_fall_a/b
  - DF_SM0~5_rise_a/b, DF_SM0~5_fall_a/b

- **FR-TG-002**: 시스템은 **항상** A/B 두 세트의 타이밍 파라미터를 유지해야 한다

- **FR-TG-003**: 시스템은 **항상** str 입력에 따라 A/B 모드를 선택해야 한다

### 3.2 펄스 생성 요구사항

- **FR-TG-004**: 시스템은 **항상** 내부 카운터를 생성하여 0~255 범위를 카운트해야 한다

- **FR-TG-005**: **WHEN** 내부 카운터가 rise_a 값과 같아지면 **THEN** 시스템은 해당 신호를 assertion해야 한다

- **FR-TG-006**: **WHEN** 내부 카운터가 fall_a 값과 같아지면 **THEN** 시스템은 해당 신호를 deassertion해야 한다

- **FR-TG-007**: 시스템은 **항상** 모든 타이밍 신호(IRST, SHR, SHS, LPF1, LPF2, TDEF, GATE_ON, DF_SM0~5)를 독립적으로 생성해야 한다

### 3.3 카운터 관리 요구사항

- **FR-TG-008**: 시스템은 **항상** str_clk_count를 사용하여 스캔 타임 해상도를 제어해야 한다
  - str=0: 1배속
  - str=1: 2배속
  - str=2: 4배속

- **FR-TG-009**: 시스템은 **항상** 행 카운터(tg_row_cnt)와 열 카운터(tg_col_cnt)를 유지해야 한다

- **FR-TG-010**: **WHEN** FSM 상태가 변경되면 **THEN** 시스템은 카운터를 리셋해야 한다

### 3.4 동기화 요구사항

- **FR-TG-011**: **WHEN** sync_in 신호가 assertion되면 **THEN** 시스템은 내부 카운터를 리셋하고 동기화해야 한다

- **FR-TG-012**: 시스템은 **항상** fsm_read_index와 동기하여 타이밍을 생성해야 한다

### 3.5 A/B 모드 선택 요구사항

- **FR-TG-013**: **IF** str 입력이 0이면 **THEN** 시스템은 A 모드 타이밍 파라미터를 사용해야 한다

- **FR-TG-014**: **IF** str 입력이 1이면 **THEN** 시스템은 B 모드 타이밍 파라미터를 사용해야 한다

- **FR-TG-015**: 시스템은 **항상** roic_a_bz 출력으로 현재 선택된 모드를 표시해야 한다

### 3.6 ROIC 동기화 출력 요구사항

- **FR-TG-016**: 시스템은 **항상** UP_ROIC_SYNC 레지스터에 따라 roic_sync_out을 생성해야 한다

### 3.7 게이트 신호 생성 요구사항

- **FR-TG-017**: 시스템은 **항상** tg_stv, tg_cpv, tg_oe 신호를 생성하여 게이트 드라이버를 제어해야 한다

- **FR-TG-018**: 시스템은 **항상** v_sync 신호를 생성하여 수직 동기화를 제공해야 한다

### 3.8 FIFO 타이밍 데이터 요구사항

- **FR-TG-019**: 시스템은 **항상** 타이밍 데이터를 FIFO에 저장하여 출력 제어에 사용해야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk 주파수 | 20 | MHz | 시스템 클록 |
| clk 주기 | 50 | ns | 사이클 시간 |

### 4.2 카운터 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 카운터 범위 | 0 | 255 | - | 8비트 카운터 |
| 스캔 타임 분해능 | 1 | 4 | - | str에 따른 배수 |

### 4.3 펄스 폭 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| rise~fall 간격 | 1 | 255 | 클록 | 펄스 폭 |
| 최소 펄스 폭 | 1 | - | 클록 | 50ns @ 20MHz |

### 4.4 레지스터 액세스 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| reg_en 셋업 | 5 | - | ns | reg_en 전 |
| reg_addr 셋업 | 5 | - | ns | reg_en 전 |
| reg_data 셋업 | 5 | - | ns | reg_en 전 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-TG-001**: 모든 타이밍 신호가 설정된 rise/fall 값에 따라 정확히 생성되어야 한다
- **V-TG-002**: A/B 모드 선택이 올바르게 동작해야 한다
- **V-TG-003**: str 입력에 따라 스캔 타임 해상도가 변경되어야 한다
- **V-TG-004**: sync_in 신호가 카운터를 정상적으로 리셋해야 한다
- **V-TG-005**: 레지스터 쓰기가 타이밍 파라미터를 정상적으로 업데이트해야 한다

### 5.2 타이밍 검증

- **V-TG-006**: 모든 펄스가 20MHz 클록 타이밍을 만족해야 한다
- **V-TG-007**: 펄스 폭이 설정된 값과 정확히 일치해야 한다
- **V-TG-008**: rise~fall 간격이 최소 1클록 이상이어야 한다

### 5.3 엣지 케이스 검증

- **V-TG-009**: rise=fall인 경우 1클록 펄스가 생성되어야 한다
- **V-TG-010**: 카운터 오버플로우 시 정상적으로 랩 어라운드되어야 한다
- **V-TG-011**: 리셋 시 모든 출력이 0으로 설정되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 20MHz 시스템 클록
- rst: 리셋 신호
- str: 스캔 타임 레인지 선택
- sync_in: 동기화 입력

### 6.2 레지스터 맵

- 0x0050: UP_ROIC_SYNC
- 0x0051~0x005B: UP_ROIC_ACLK_0~10_READ_MODE
- 0x005C~0x0066: UP_ROIC_ACLK_0~10_AED_MODE
- 0x0067~0x0071: UP_ROIC_ACLK_0~10_FLUSH_MODE

### 6.3 연관 모듈

- roic_gate_drv.sv: 게이트 드라이브 제어
- sequencer_fsm.sv: FSM 상태 입력
- ti_roic_top.sv: ROIC 인터페이스

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 펄스 생성 시나리오

**Given**: 타이밍 파라미터가 설정됨 (IRST_rise_a=1, IRST_fall_a=5)
**When**: 카운터가 0~255까지 증가함
**Then**: 카운터=1일 때 IRST=1, 카운터=5일 때 IRST=0이 됨

### 7.2 A/B 모드 전환 시나리오

**Given**: A 모드에서 동작 중
**When**: str=1로 변경됨
**Then**: B 모드 타이밍 파라미터가 사용됨
**And** roic_a_bz=1로 설정됨

### 7.3 동기화 시나리오

**Given**: 카운터가 100에서 동작 중
**When**: sync_in=1이 입력됨
**Then**: 카운터가 0으로 리셋되고 다시 시작됨

### 7.4 레지스터 업데이트 시나리오

**Given**: 시스템이 동작 중
**When**: reg_addr=0x0050, reg_data=0x0005, reg_en=1
**Then**: UP_ROIC_SYNC 레지스터가 0x0005로 업데이트됨
**And** roic_sync_out 신호가 새로운 타이밍으로 생성됨

---

## 8. 제약사항 (Constraints)

### 8.1 카운터 제약사항

- 카운터 범위: 0~255 (8비트)
- rise 값은 fall 값보다 작아야 함
- rise/fall 차이는 최소 1 이상이어야 함

### 8.2 타이밍 제약사항

- 모든 펄스는 20MHz 클록에 동기화되어야 함
- 최소 펄스 폭: 1클록 (50ns @ 20MHz)

### 8.3 모드 제약사항

- str 입력은 0~2 범위여야 함
- A/B 모드는 런타임에 전환 가능해야 함

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Control Team*
