# SPEC-SYS-003: Register Map Module

## 태그 블록

```yaml
SPEC_ID: SPEC-SYS-003
Title: Register Map Module - SPI Slave Register Interface
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: System Integration
Related: SPEC-SYS-001, SPEC-SYS-002
Module: reg_map.sv
Lines: 1,008
```

---

## 1. 개요 (Overview)

### 1.1 목적

Register Map 모듈은 SPI 슬레이브 인터페이스를 통해 외부 마스터(MCU/프로세서)와 FPGA 시스템 간의 통신을 관리합니다. BRAM 기반 레지스터 배열을 사용하여 시스템 제어, 상태 모니터링, 파라미터 설정 기능을 제공합니다.

### 1.2 주요 기능

- SPI 슬레이브 기반 레지스터 읽기/쓰기 인터페이스
- 512개의 16비트 레지스터 공간 (BRAM36 사용)
- FSM 상태별 레지스터 액세스 제어
- 시스템 제어 신호 생성
- TI ROIC 파라미터 설정
- 시퀀스 LUT 데이터 관리
- 게이트 드라이브 제어 신호 생성

### 1.3 레지스터 맵 구조

- 0x0001-0x0007: 시스템 제어 레지스터
- 0x0010-0x001E: 타이밍 제어 레지스터
- 0x0020-0x0023: 백 바이어스 레지스터
- 0x0024-0x004B: 게이트 드라이브 레지스터
- 0x0050-0x0071: ROIC ACLK 레지스터
- 0x0072-0x0081: ROIC 레지스터 세트
- 0x0082-0x00FF: 예약
- 0x0100-0x01FF: TI ROIC 디시리얼라이저 제어
- 0x0200-0x02FF: CSI-2 제어

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| eim_clk | Input | logic | 100MHz 레지스터 인터페이스 클록 |
| eim_rst | Input | logic | 레지스터 인터페이스 리셋 |
| fsm_clk | Input | logic | 20MHz FSM 도메인 클록 |
| rst | Input | logic | FSM 도메인 리셋 |

### 2.2 FSM 상태 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| fsm_rst_index | Input | logic | FSM RST 상태 인덱스 |
| fsm_init_index | Input | logic | FSM 초기화 상태 인덱스 |
| fsm_back_bias_index | Input | logic | FSM 백 바이어스 상태 인덱스 |
| fsm_flush_index | Input | logic | FSM 플러시 상태 인덱스 |
| fsm_aed_read_index | Input | logic | FSM AED 리드 상태 인덱스 |
| fsm_exp_index | Input | logic | FSM 노출 상태 인덱스 |
| fsm_read_index | Input | logic | FSM 리드아웃 상태 인덱스 |
| fsm_idle_index | Input | logic | FSM IDLE 상태 인덱스 |

### 2.3 시스템 상태 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| ready_to_get_image | Input | logic | 이미지 획득 준비 완료 |
| aed_ready_done | Input | logic | AED 준비 완료 |
| panel_stable_exist | Input | logic | 패널 안정화 상태 |
| exp_read_exist | Input | logic | 노출/리드 존재 |
| exp_req | Input | logic | 노출 요청 |

### 2.4 레지스터 액세스 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| reg_read_index | Input | logic | 읽기 활성화 |
| reg_addr | Input | logic [15:0] | 레지스터 주소 |
| reg_data | Input | logic [15:0] | 쓰기 데이터 |
| reg_data_index | Input | logic | 쓰기 스트로브 |
| reg_read_out | Output | logic [15:0] | 읽기 데이터 |
| read_data_en | Output | logic | 읽기 데이터 활성화 |

### 2.5 외부 인터페이스 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| seq_lut_read_data | Input | logic [63:0] | 시퀀스 LUT 읽기 데이터 |
| seq_state_read | Input | logic [15:0] | 시퀀스 상태 읽기 |

### 2.6 시스템 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| system_rst | Output | logic | 시스템 리셋 |
| org_reset_fsm | Output | logic | FSM 초기 리셋 |
| reset_fsm | Output | logic | FSM 리셋 |
| en_pwr_dwn | Output | logic | 전원 다운 활성화 |
| en_pwr_off | Output | logic | 전원 오프 활성화 |

### 2.7 CSI-2 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| max_v_count | Output | logic [15:0] | 최대 수직 카운트 |
| max_h_count | Output | logic [15:0] | 최대 수평 카운트 |
| csi2_word_count | Output | logic [15:0] | CSI-2 워드 카운트 |

### 2.8 TI ROIC 기본 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| ti_roic_sync | Output | logic | ROIC 동기화 |
| ti_roic_tp_sel | Output | logic | 테스트 패턴 선택 |
| ti_roic_str | Output | logic [1:0] | 스캔 타임 레인지 |
| ti_roic_reg_addr | Output | logic [15:0] | ROIC 레지스터 주소 |
| ti_roic_reg_data | Output | logic [15:0] | ROIC 레지스터 데이터 |

### 2.9 TI ROIC 디시리얼라이저 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| ti_roic_deser_reset | Output | logic | 디시리얼라이저 리셋 |
| ti_roic_deser_dly_tap_ld | Output | logic | 딜레이 탭 로드 |
| ti_roic_deser_dly_tap_in | Output | logic [4:0] | 딜레이 탭 입력 |
| ti_roic_deser_dly_data_ce | Output | logic | 딜레이 데이터 클록 활성화 |
| ti_roic_deser_dly_data_inc | Output | logic | 딜레이 데이터 증가 |
| ti_roic_deser_align_mode | Output | logic | 정렬 모드 |
| ti_roic_deser_align_start | Output | logic | 정렬 시작 |
| ti_roic_deser_shift_set | Output | logic [4:0] [13:0] | 시프트 설정 [13:0] |
| ti_roic_deser_align_shift | Input | logic [4:0] [13:0] | 정렬 시프트 [13:0] |
| ti_roic_deser_align_done | Input | logic [13:0] | 정렬 완료 [13:0] |

### 2.10 백 바이어스 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| up_back_bias | Output | logic [15:0] | 상단 바이어스 |
| dn_back_bias | Output | logic [15:0] | 하단 바이어스 |

### 2.11 시퀀스 LUT 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| seq_lut_addr | Output | logic [7:0] | LUT 주소 |
| seq_lut_data | Output | logic [63:0] | LUT 데이터 |
| seq_lut_wr_en | Output | logic | LUT 쓰기 활성화 |
| seq_lut_control | Output | logic [15:0] | LUT 제어 |
| seq_lut_config_done | Output | logic | LUT 설정 완료 |

### 2.12 획득 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| acq_mode | Output | logic [2:0] | 획득 모드 |
| acq_expose_size | Output | logic [31:0] | 획득 노출 크기 |
| dsp_image_height | Output | logic [15:0] | 표시 이미지 높이 |

### 2.13 이미지 명령 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| get_dark | Output | logic | 다크 이미지 획득 |
| get_bright | Output | logic | 밝은 이미지 획득 |
| cmd_get_bright | Output | logic | 밝은 이미지 명령 |
| dummy_get_image | Output | logic | 더미 이미지 획득 |
| burst_get_image | Output | logic | 버스트 이미지 획득 |

### 2.14 동작 모드 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| en_panel_stable | Output | logic | 패널 안정화 활성화 |
| en_16bit_adc | Output | logic | 16비트 ADC 활성화 |
| en_test_pattern_col | Output | logic | 컬럼 테스트 패턴 활성화 |
| en_test_pattern_row | Output | logic | 로우 테스트 패턴 활성화 |
| en_test_roic_col | Output | logic | ROIC 컬럼 테스트 활성화 |
| en_test_roic_row | Output | logic | ROIC 로우 테스트 활성화 |

### 2.15 노출 승인 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| exp_ack | Output | logic | 노출 승인 |

### 2.16 게이트 제어 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| gate_mode1/2 | Output | logic | 게이트 모드 1/2 |
| gate_cs1/2 | Output | logic | 게이트 칩 선택 1/2 |
| gate_sel | Output | logic | 게이트 선택 |
| gate_ud | Output | logic | 게이트 업/다운 |
| gate_stv_mode | Output | logic | STV 모드 |
| gate_oepsn | Output | logic | OE 출력 스위칭 네거티브 |
| gate_lr1/2 | Output | logic | 좌/우 1/2 |
| stv_sel_h | Output | logic | STV 선택 상단 |
| stv_sel_l1/2 | Output | logic | STV 선택 좌 1/2 |
| stv_sel_r1/2 | Output | logic | STV 선택 우 1/2 |
| dn_aed_gate_xao | Output | logic [15:0] [0:5] | 하단 AED 게이트 XAO |
| up_aed_gate_xao | Output | logic [15:0] [0:5] | 상단 AED 게이트 XAO |

### 2.17 상태 LED 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| state_led_ctr | Output | logic [7:0] | 상태 LED 카운터 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 레지스터 기본 요구사항

- **FR-REG-001**: 시스템은 **항상** 512개의 16비트 레지스터 공간을 제공해야 한다

- **FR-REG-002**: 시스템은 **항상** BRAM36을 사용하여 레지스터를 저장해야 한다 (플립플롭 대신 ~8K FF 절약)

- **FR-REG-003**: 시스템은 **항상** 전원 리셋 시 모든 레지스터를 기본값으로 초기화해야 한다

### 3.2 레지스터 읽기/쓰기 요구사항

- **FR-REG-004**: **WHEN** reg_data_index가 assertion되면 **THEN** 시스템은 reg_addr에 해당하는 레지스터에 reg_data를 써야 한다

- **FR-REG-005**: **WHEN** reg_read_index가 assertion되면 **THEN** 시스템은 reg_addr에 해당하는 레지스터 값을 reg_read_out에 출력해야 한다

- **FR-REG-006**: 시스템은 **항상** 100MHz eim_clk 도메인에서 레지스터 쓰기 동작을 수행해야 한다

- **FR-REG-007**: 시스템은 **항상** 20MHz fsm_clk 도메인에서 레지스터 읽기 동작을 수행해야 한다

### 3.3 FSM 상태별 레지스터 액세스 제어 요구사항

- **FR-REG-008**: 시스템은 **항상** FSM 상태에 따라 특정 레지스터 값을 동적으로 업데이트해야 한다
  - fsm_rst_index: SYS_CMD_REG 레지스터 상태 비트 업데이트
  - fsm_idle_index: IDLE 상태 비트 설정
  - fsm_flush_index: FLUSH 상태 게이트 레지스터 사용
  - fsm_read_index: READ 상태 게이트 레지스터 사용
  - fsm_aed_read_index: AED 상태 게이트 레지스터 사용

### 3.4 시스템 제어 레지스터 요구사항

- **FR-REG-009**: **WHEN** SYS_CMD_REG (0x0001)에 0x0001이 쓰여지면 **THEN** 시스템은 시스템 리셋을 실행해야 한다

- **FR-REG-010**: **WHEN** SYS_CMD_REG에 0x0002가 쓰여지면 **THEN** 시스템은 FSM 리셋을 실행해야 한다

### 3.5 TI ROIC 제어 레지스터 요구사항

- **FR-REG-011**: 시스템은 **항상** TI_ROIC_SYNC 레지스터에 따라 ti_roic_sync 출력을 제어해야 한다

- **FR-REG-012**: 시스템은 **항상** TI_ROIC_REG_ADDR 및 TI_ROIC_REG_DATA 레지스터를 통해 ROIC SPI 통신을 제어해야 한다

### 3.6 디시리얼라이저 제어 레지스터 요구사항

- **FR-REG-013**: 시스템은 **항상** 14개 채널 각각에 독립적인 디시리얼라이저 제어 레지스터를 제공해야 한다
  - TI_ROIC_DESER_SHIFT_SET[0~13]: 시프트 값 설정
  - TI_ROIC_DESER_ALIGN_SHIFT[0~13]: 정렬 시프트 값 읽기
  - TI_ROIC_DESER_ALIGN_DONE[0~13]: 정렬 완료 상태 읽기

### 3.7 시퀀스 LUT 제어 요구사항

- **FR-REG-014**: 시스템은 **항상** SEQ_LUT_ADDR 및 SEQ_LUT_DATA 레지스터를 통해 LUT RAM에 액세스할 수 있어야 한다

- **FR-REG-015**: 시스템은 **항상** SEQ_LUT_CONTROL 레지스터를 통해 LUT 설정을 제어해야 한다

- **FR-REG-016**: **WHEN** SEQ_LUT_CONFIG_DONE 비트가 설정되면 **THEN** 시스템은 FSM에게 LUT 설정 완료를 알려야 한다

### 3.8 게이트 드라이브 제어 레지스터 요구사항

- **FR-REG-017**: 시스템은 **항상** READ, AED, FLUSH 모드별로 독립적인 게이트 레지스터 세트를 제공해야 한다
  - UP_GATE_STV1/2: 상단 STV 타이밍
  - DN_GATE_STV1/2: 하단 STV 타이밍
  - UP_GATE_CPV1/2: 상단 CPV 타이밍
  - DN_GATE_CPV1/2: 하단 CPV 타이밍
  - DN_GATE_OE1/2: 하단 OE 타이밍
  - UP_GATE_OE1/2: 상단 OE 타이밍

- **FR-REG-018**: 시스템은 **항상** FSM 상태에 따라 해당 모드의 게이트 레지스터를 선택해야 한다

### 3.9 백 바이어스 제어 요구사항

- **FR-REG-019**: 시스템은 **항상** UP_BACK_BIAS 및 DN_BACK_BIAS 레지스터 값을 해당 출력으로 전달해야 한다

### 3.10 상태 레지스터 읽기 요구사항

- **FR-REG-020**: 시스템은 **항상** 상태 레지스터 읽기 시 현재 시스템 상태를 반환해야 한다
  - SEQ_STATE_READ: 현재 FSM 상태
  - FPGA_VER: FPGA 버전 정보
  - READY_TO_GET_IMAGE: 이미지 획득 준비 상태
  - AED_READY_DONE: AED 완료 상태

### 3.11 타이밍 제어 레지스터 요구사항

- **FR-REG-021**: 시스템은 **항상** EXPOSE_SIZE 레지스터에 따라 노출 시간을 제어해야 한다

- **FR-REG-022**: 시스템은 **항상** IMAGE_HEIGHT 레지스터에 따라 이미지 높이를 설정해야 한다

- **FR-REG-023**: 시스템은 **항상** CYCLE_WIDTH_* 레지스터에 따라 각 상태의 지연 시간을 제어해야 한다

### 3.12 전원 제어 레지스터 요구사항

- **FR-REG-024**: **WHEN** PWR_OFF_DWN 레지스터에 0x0001이 쓰여지면 **THEN** 시스템은 en_pwr_off를 assertion해야 한다

- **FR-REG-025**: **WHEN** PWR_OFF_DWN 레지스터에 0x0002가 쓰여지면 **THEN** 시스템은 en_pwr_dwn을 assertion해야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 클록 도메인 | 주파수 | 주기 | 설명 |
|-------------|--------|------|------|
| eim_clk | 100 MHz | 10.000 ns | 레지스터 쓰기 도메인 |
| fsm_clk | 20 MHz | 50.000 ns | 레지스터 읽기 도메인 |

### 4.2 레지스터 액세스 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 주소 셋업 시간 | 5 | - | ns | reg_data_index 전 |
| 데이터 셋업 시간 | 5 | - | ns | reg_data_index 전 |
| 주소 홀드 시간 | 2 | - | ns | reg_data_index 후 |
| 데이터 홀드 시간 | 2 | - | ns | reg_data_index 후 |
| 읽기 데이터 유효 지연 | - | 50 | ns | reg_read_index 후 |

### 4.3 CDC (Clock Domain Crossing) 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 쓰기-읽기 동기화 지연 | 2 | 3 | 클록 | eim_clk → fsm_clk |
| 데이터 일관성 보장 | - | 100 | ns | 쓰기 후 읽기 가능 시간 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-REG-001**: 모든 레지스터 주소(0x0000-0x01FF)가 정상적으로 읽기/쓰기 가능해야 한다
- **V-REG-002**: 쓰기 작업이 BRAM에 정상적으로 저장되어야 한다
- **V-REG-003**: 읽기 작업이 최신 쓰기 값을 반환해야 한다
- **V-REG-004**: FSM 상태별 레지스터 업데이트가 올바르게 동작해야 한다
- **V-REG-005**: 시스템 제어 레지스터 쓰기가 해당 제어 신호를 생성해야 한다

### 5.2 타이밍 검증

- **V-REG-006**: 레지스터 쓰기가 100MHz 클록 타이밍을 만족해야 한다
- **V-REG-007**: 레지스터 읽기가 20MHz 클록 타이밍을 만족해야 한다
- **V-REG-008**: CDC 경로가 메타-스터블 상태를 방지해야 한다

### 5.3 엣지 케이스 검증

- **V-REG-009**: 동일 주소에 대한 연속 쓰기가 정상 처리되어야 한다
- **V-REG-010**: 쓰기 직후 읽기가 최신 값을 반환해야 한다
- **V-REG-011**: 리셋 시 모든 레지스터가 기본값으로 복원되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- eim_clk: 100MHz 레지스터 인터페이스 클록
- fsm_clk: 20MHz FSM 도메인 클록
- FSM 상태 신호들: fsm_*_index
- 시스템 상태 신호들: ready_to_get_image, aed_ready_done 등

### 6.2 BRAM 리소스

- BRAM36: 1개 (512 x 16비트 레지스터)
- 초기화: 기본값으로 초기화

### 6.3 연관 모듈

- spi_slave.sv: SPI 슬레이브 인터페이스
- sequencer_fsm.sv: FSM 상태 입력
- ti_roic_top.sv: ROIC 제어 출력
- roic_gate_drv.sv: 게이트 드라이브 제어

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 레지스터 쓰기 시나리오

**Given**: 시스템이 정상 동작 중
**When**: reg_addr=0x0001, reg_data=0x0002, reg_data_index=1이 입력됨
**Then**: 주소 0x0001에 0x0002가 저장됨
**And**: reset_fsm 출력이 assertion됨

### 7.2 레지스터 읽기 시나리오

**Given**: 주소 0x0001에 0x0002가 저장됨
**When**: reg_addr=0x0001, reg_read_index=1이 입력됨
**Then**: reg_read_out=0x0002가 출력됨

### 7.3 FSM 상태별 레지스터 업데이트 시나리오

**Given**: FSM이 FLUSH 상태에 있음
**When**: fsm_flush_index=1이 입력됨
**Then**: FLUSH 모드 게이트 레지스터 값이 해당 출력으로 전달됨

### 7.4 TI ROIC 제어 시나리오

**Given**: 시스템이 정상 동작 중
**When**: TI_ROIC_REG_ADDR=0x0010, TI_ROIC_REG_DATA=0x0123이 쓰여짐
**Then**: ti_roic_reg_addr=0x0010, ti_roic_reg_data=0x0123이 출력됨
**And**: ROIC SPI 통신이 실행됨

---

## 8. 제약사항 (Constraints)

### 8.1 주소 공간 제약사항

- 유효 주소 범위: 0x0000-0x01FF (512개)
- 잘못된 주소 액세스는 무시되거나 0 반환

### 8.2 타이밍 제약사항

- 모든 레지스터 쓰기는 100MHz 클록 타이밍을 만족해야 함
- 모든 레지스터 읽기는 20MHz 클록 타이밍을 만족해야 함
- CDC 경로는 2단계 이상 동기화를 사용해야 함

### 8.3 리소스 제약사항

- BRAM36 사용: 1개
- 플립플롭 최소화 (BRAM 사용)

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: System Integration Team*
