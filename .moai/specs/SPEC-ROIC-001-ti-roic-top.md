# SPEC-ROIC-001: TI ROIC Top Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-001
Title: TI ROIC Top Module - Single Channel LVDS Interface
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Interface
Related: SPEC-ROIC-002, SPEC-ROIC-003, SPEC-ROIC-004
Module: ti_roic_top.sv
Lines: 229
```

---

## 1. 개요 (Overview)

### 1.1 목적

TI ROIC Top 모듈은 단일 채널 LVDS ROIC(Readout Integrated Circuit) 인터페이스의 최상위 모듈입니다. TI ROIC에서 출력되는 고속 LVDS 데이터를 수신, 정렬, 디시리얼라이징, 재정렬하여 처리 가능한 병렬 데이터로 변환합니다.

### 1.2 주요 기능

- LVDS 데이터/프레임 클록 수신 및 버퍼링
- 8:1 비트 디시리얼라이징 (ISERDESE2 기반)
- 패턴 기반 비트 정렬 (IDELAYE2 기반)
- 첫 채널 검출 및 프레임 동기화
- 24비트 데이터 재정렬 및 버퍼링
- 테스트 패턴 생성 지원
- 짝수/홀수 프레임 처리

### 1.3 데이터 경로

```
LVDS Input → IBUFDS → ISERDESE2 → Bit Align → First Channel Detect → Data Reorder → Output
  (DCLK)      (2.34MHz)    (8:1)        (24-bit)       (Frame Sync)         (24-bit x2)
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk_reset | Input | logic | 클록 도메인 리셋 (마스터) |
| data_reset | Input | logic | 데이터 도메인 리셋 |

### 2.2 LVDS 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| fclk_in_p/n | Input | logic | 프레임 클록 입력 (LVDS, 2.34MHz) |
| clk_in_p/n | Input | logic | 데이터 클록 입력 (LVDS, 2.34MHz) |
| data_in_p/n | Input | logic | 데이터 입력 (LVDS) |

### 2.3 정렬 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| align_to_fclk | Input | logic | 정렬 모드 (0=패턴, 1=수동) |
| align_start | Input | logic | 정렬 시작 |
| extra_shift | Input | logic [4:0] | 수동 시프트 값 |

### 2.4 테스트 패턴 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| en_test_pattern_col | Input | logic | 컬럼 테스트 패턴 활성화 |
| en_test_pattern_row | Input | logic | 로우 테스트 패턴 활성화 |
| sync | Input | logic | 동기화 신호 |

### 2.5 데이터 읽기 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| data_read_req | Input | logic | 데이터 읽기 요청 |
| data_read_clk | Input | logic | 데이터 읽기 클록 (240MHz) |

### 2.6 정렬 상태 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| shift_out | Output | logic [4:0] | 적용된 시프트 양 |
| align_done | Output | logic | 정렬 완료 플래그 |
| channel_detected | Output | logic | 첫 채널 검출 플래그 |

### 2.7 데이터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| valid_read_enable | Output | logic | 읽기 데이터 활성화 |
| reordered_data_a | Output | logic [23:0] | 재정렬된 데이터 A |
| reordered_data_b | Output | logic [23:0] | 재정렬된 데이터 B |
| reordered_valid | Output | logic | 재정렬 데이터 유효 |
| detected_data_out | Output | logic [23:0] | 검출된 데이터 출력 |

### 2.8 디버그 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| even_odd_toggle_out | Output | logic | 짝수/홀수 토글 출력 |
| roic_even_odd_out | Output | logic | ROIC 짝수/홀수 출력 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 LVDS 입력 처리 요구사항

- **FR-ROIC-001**: 시스템은 **항상** LVDS 입력 신호를 differential buffer(IBUFDS)를 통해 단일 엔디드 신호로 변환해야 한다

- **FR-ROIC-002**: 시스템은 **항상** 2.34MHz LVDS 클록(fclk_in, clk_in)을 안정적으로 수신해야 한다

- **FR-ROIC-003**: 시스템은 **항상** LVDS 입력 신호에 맞는 IOSTANDARD("LVDS_25")를 사용해야 한다

### 3.2 비트 클록 생성 요구사항

- **FR-ROIC-004**: bit_clock_module은 **항상** 입력 LVDS 클록을 적절한 내부 클록으로 변환해야 한다
  - fclk_out: 프레임 클록 (추출됨)
  - bit_clk: 고속 비트 클록 (ISERDESE2용)
  - clk_div_out: 분주 클록 (디시리얼라이징용)

### 3.3 디시리얼라이징 요구사항

- **FR-ROIC-005**: deser_single_lane 모듈은 **항상** 8:1 비트 디시리얼라이징을 수행해야 한다

- **FR-ROIC-006**: 시스템은 **항상** ISERDESE2 프리미티브를 사용하여 고속 LVDS 데이터를 병렬 데이터로 변환해야 한다

- **FR-ROIC-007**: 시스템은 **항상** 3개의 8비트 디시리얼라이징 결과를 조합하여 24비트 워드를 생성해야 한다

- **FR-ROIC-008**: 시스템은 **항상** 프레임 클록(fclk_out) 에지에서 24비트 워드를 캡처해야 한다

### 3.4 비트 정렬 요구사항

- **FR-ROIC-009**: bit_align 모듈은 **항상** 입력 데이터의 비트 경계를 정렬해야 한다

- **FR-ROIC-010**: **WHEN** align_to_fclk=0(패턴 모드)이면 **THEN** 시스템은 PATTERN_1(0xFFF000) 또는 PATTERN_2(0xFF0000)을 검색하여 비트 정렬을 수행해야 한다

- **FR-ROIC-011**: **WHEN** align_to_fclk=1(수동 모드)이면 **THEN** 시스템은 extra_shift 입력값을 사용하여 비트 시프트를 수행해야 한다

- **FR-ROIC-012**: 시스템은 **항상** 정렬된 비트 위치를 shift_out 출력으로 제공해야 한다

- **FR-ROIC-013**: 시스템은 **항상** 정렬 완료 시 align_done을 assertion해야 한다

### 3.5 첫 채널 검출 요구사항

- **FR-ROIC-014**: first_channel_detector 모듈은 **항상** 입력 데이터의 하위 8비트에서 특정 패턴(0xB8 또는 0xF8)을 검출해야 한다

- **FR-ROIC-015**: **WHEN** 4개의 연속된 유효 패턴이 검출되면 **THEN** 시스템은 channel_detected를 assertion해야 한다

- **FR-ROIC-016**: 시스템은 **항상** 검출된 첫 채널 위치에서 데이터 출력을 시작해야 한다

### 3.6 데이터 재정렬 요구사항

- **FR-ROIC-017**: indata_reorder 모듈은 **항상** 입력 데이터를 짝수/홀수 프레임별로 버퍼링해야 한다

- **FR-ROIC-018**: **WHEN** data_read_req가 assertion되면 **THEN** 시스템은 재정렬된 데이터를 출력해야 한다

- **FR-ROIC-019**: 시스템은 **항상** 240MHz data_read_clk에 동기하여 데이터를 출력해야 한다

- **FR-ROIC-020**: 시스템은 **항상** reordered_data_a와 reordered_data_b 두 개의 데이터 경로를 제공해야 한다

### 3.7 테스트 패턴 요구사항

- **FR-ROIC-021**: **WHEN** en_test_pattern_col=1이면 **THEN** 시스템은 컬럼 테스트 패턴을 생성해야 한다

- **FR-ROIC-022**: **WHEN** en_test_pattern_row=1이면 **THEN** 시스템은 로우 테스트 패턴을 생성해야 한다

### 3.8 리셋 요구사항

- **FR-ROIC-023**: **WHEN** clk_reset 또는 data_reset이 assertion되면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다

- **FR-ROIC-024**: 시스템은 **항상** 리셋 시 모든 출력을 0으로 설정해야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 LVDS 입력 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| DCLK/FCLK 주파수 | 2.34 | MHz | 데이터/프레임 클록 |
| DCLK/FCLK 주기 | 427.35 | ns | 클록 주기 |
| 셋업 시간 | 10 | ns | 최소 |
| 홀드 시간 | 10 | ns | 최소 |

### 4.2 디시리얼라이징 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| 비트 레이트 | 18.72 | Mbps | 8 x 2.34MHz |
| 디시리얼라이징 비율 | 8:1 | - | 8비트 → 1바이트 |
| 워드 조합 시간 | 3 x 427.35 | ns | 24비트 워드 |

### 4.3 정렬 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 정렬 시작 지연 | - | 1 | us | 패턴 검색 시간 |
| 시프트 범위 | 0 | 23 | 비트 | 최대 시프트 |

### 4.4 데이터 출력 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| data_read_clk | 240 | MHz | 출력 클록 |
| 출력 데이터 유효 | - | 4.17 | ns | 1/240MHz |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-ROIC-001**: LVDS 입력이 정상적으로 디시리얼라이징되어야 한다
- **V-ROIC-002**: 비트 정렬이 패턴 검출을 통해 정확하게 수행되어야 한다
- **V-ROIC-003**: 첫 채널 검출이 4개 연속 패턴에서 정확히 트리거되어야 한다
- **V-ROIC-004**: 데이터 재정렬이 짝수/홀수 프레임별로 올바르게 수행되어야 한다
- **V-ROIC-005**: 테스트 패턴이 정상적으로 생성되어야 한다

### 5.2 타이밍 검증

- **V-ROIC-006**: LVDS 입력이 2.34MHz 클록 타이밍을 만족해야 한다
- **V-ROIC-007**: 디시리얼라이징이 18.72Mbps 비트 레이트를 처리해야 한다
- **V-ROIC-008**: 데이터 출력이 240MHz 클록 타이밍을 만족해야 한다

### 5.3 엣지 케이스 검증

- **V-ROIC-009**: 최대 시프트(23비트)에서도 정상적으로 정렬되어야 한다
- **V-ROIC-010**: 패턴이 없는 입력 데이터에서 타임아웃 처리가 되어야 한다
- **V-ROIC-011**: 리셋 중 모든 출력이 안전한 상태여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 내부 서브모듈

- bit_clock_module: 클록 생성 및 분주
- deser_single_lane: 8:1 디시리얼라이징
- bit_align: 비트 정렬
- first_channel_detector: 첫 채널 검출
- indata_reorder: 데이터 재정렬

### 6.2 Xilinx 프리미티브

- IBUFDS: LVDS differential input buffer
- ISERDESE2: Input serdes primitive
- IDELAYE2: Adjustable delay primitive

### 6.3 파라미터

- DATA_WIDTH: 24 (데이터 경로 폭)
- IOSTANDARD: "LVDS_25"
- REFCLK_FREQ: 200.0 MHz
- PATTERN_1: 24'hFFF000 (첫 번째 정렬 패턴)
- PATTERN_2: 24'hFF0000 (두 번째 정렬 패턴)

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 데이터 수신 시나리오

**Given**: LVDS 입력이 정상적으로 공급됨
**When**: align_start=1로 정렬 시작
**Then**: 시스템이 PATTERN_1 또는 PATTERN_2를 검출하여 비트 정렬 수행
**And**: 첫 채널 검출 후 데이터가 정상적으로 재정렬되어 출력됨

### 7.2 수동 정렬 시나리오

**Given**: align_to_fclk=1(수동 모드)
**When**: extra_shift=5, align_start=1
**Then**: 시스템이 5비트 시프트를 적용하여 데이터 정렬 수행

### 7.3 테스트 패턴 시나리오

**Given**: en_test_pattern_col=1
**When**: 데이터가 요청됨
**Then**: 컬럼 테스트 패턴이 출력 데이터로 생성됨

### 7.4 프레임 동기화 시나리오

**Given**: 입력 데이터에 4개의 연속된 0xB8 패턴이 존재
**When**: first_channel_detector가 패턴을 검출
**Then**: channel_detected=1로 assertion되고 데이터 출력 시작

---

## 8. 제약사항 (Constraints)

### 8.1 하드웨어 제약사항

- IOSTANDARD: LVDS_25 (Artix-7)
- 최대 LVDS 입력 주파수: 2.34MHz
- 최대 출력 클록: 240MHz

### 8.2 타이밍 제약사항

- 모든 LVDS 입력은 CDC를 통해 동기화되어야 함
- 디시리얼라이징 경로는 200MHz 클록을 타이밍 참조로 사용해야 함

### 8.3 리소스 제약사항

- ISERDESE2: 1개 (채널당)
- IBUFDS: 3개 (fclk, clk, data)
- IDELAYE2: 1개 (data 경로)

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Interface Team*
