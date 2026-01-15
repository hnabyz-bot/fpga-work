# SPEC-ROIC-004: Deserializer Single Lane Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-004
Title: Deserializer Single Lane - ISERDESE2-Based 8:1 Deserialization
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Interface
Related: SPEC-ROIC-001, SPEC-ROIC-003
Module: deser_single.sv
Lines: 215
```

---

## 1. 개요 (Overview)

### 1.1 목적

Deserializer Single Lane 모듈은 Xilinx ISERDESE2 프리미티브를 사용하여 고속 LVDS 데이터를 병렬 데이터로 변환합니다. 8:1 디시리얼라이징 비율로 2.34MHz LVDS 입력을 처리합니다.

### 1.2 주요 기능

- LVDS differential input buffering (IBUFDS)
- 8:1 디시리얼라이징 (ISERDESE2)
- DDR (Double Data Rate) 수신
- 프레임 클록 기반 워드 캡처
- CDC (Clock Domain Crossing) 처리

### 1.3 데이터 경로

```
LVDS Input (2.34MHz) → IBUFDS → ISERDESE2 (8:1) → 3 bytes → 24-bit word
```

---

## 2. 인터페이스 (Interface)

### 2.1 LVDS 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| data_in_from_pins_p | Input | logic | LVDS 양성 입력 |
| data_in_from_pins_n | Input | logic | LVDS 음성 입력 |

### 2.2 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk_in_int_buf | Input | logic | 고속 비트 클록 (200MHz) |
| clk_div | Input | logic | 분주 클록 (50MHz) |
| rst | Input | logic | 비동기 리셋 |
| fclk_out | Input | logic | 프레임 클록 출력 |

### 2.3 데이터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| data_in_to_device | Output | logic [23:0] | 24비트 병렬 출력 데이터 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 LVDS Input Buffering 요구사항

- **FR-DESER-001**: 시스템은 **항상** IBUFDS 프리미티브를 사용하여 LVDS differential 입력을 단일 엔디드 신호로 변환해야 한다

- **FR-DESER-002**: 시스템은 **항상** 지정된 IOSTANDARD("LVDS_25")를 사용해야 한다

- **FR-DESER-003**: IBUFDS는 **항상** DIFF_TERM="FALSE", IBUF_LOW_PWR="FALSE" 설정을 사용해야 한다

### 3.2 ISERDESE2 디시리얼라이징 요구사항

- **FR-DESER-004**: 시스템은 **항상** ISERDESE2 프리미티브를 사용하여 8:1 디시리얼라이징을 수행해야 한다

- **FR-DESER-005**: ISERDESE2는 **항상** DDR (Double Data Rate) 모드로 구성되어야 한다

- **FR-DESER-006**: ISERDESE2는 **항상** NETWORKING 인터페이스 타입을 사용해야 한다

- **FR-DESER-007**: ISERDESE2는 **항상** SERDES_MODE="MASTER"로 구성되어야 한다

- **FR-DESER-008**: ISERDESE2는 **항상** IOBDELAY="IFD" 모드를 사용해야 한다

### 3.3 클킹 요구사항

- **FR-DESER-009**: 시스템은 **항상** clk_in_int_buf(200MHz)를 비트 클록으로 사용해야 한다

- **FR-DESER-010**: 시스템은 **항상** clk_div(50MHz)을 분주 클록으로 사용해야 한다

- **FR-DESER-011**: 시스템은 **항상** clk_in_int_buf의 반전 클록(clk_in_int_inv)을 CLKB 포트에 제공해야 한다

### 3.4 워드 조립 요구사항

- **FR-DESER-012**: 시스템은 **항상** 3개의 연속적인 8비트 디시리얼라이징 결과를 조립하여 24비트 워드를 생성해야 한다
  - temp_word[23:16]: iserdes_q_d2 (가장 오래된 바이트)
  - temp_word[15:8]: iserdes_q_d1 (중간 바이트)
  - temp_word[7:0]: iserdes_q (최신 바이트)

- **FR-DESER-013**: 시스템은 **항상** clk_div 도메인에서 iserdes_q 신호를 2단계 동기화해야 한다
  - iserdes_q_d1: 1단계 동기화
  - iserdes_q_d2: 2단계 동기화

- **FR-DESER-014**: 시스템은 **항상** temp_word를 조합하여 24비트 워드를 생성해야 한다

### 3.5 프레임 동기화 요구사항

- **FR-DESER-015**: 시스템은 **항상** fclk_out 신호를 사용하여 프레임 동기화를 수행해야 한다

- **FR-DESER-016**: 시스템은 **항상** fclk_in 레지스터를 사용하여 fclk_out 에지를 검출해야 한다

- **FR-DESER-017**: **WHEN** fclk_hi_edge(fclk_in이 2'b01로 전이)가 검출되면 **THEN** 시스템은 temp_word를 temp_word_d1에 캡처해야 한다

- **FR-DESER-018**: 시스템은 **항상** temp_word_d1을 fclk_out 도메인으로 전송하여 temp_word_d2를 생성해야 한다

### 3.6 CDC 처리 요구사항

- **FR-DESER-019**: 시스템은 **항상** clk_div 도메인(50MHz)에서 fclk_out 도메인으로 안전하게 데이터를 전송해야 한다

- **FR-DESER-020**: 시스템은 **항상** 최소 2단계 플립플롭 동기화를 사용해야 한다

### 3.7 리셋 요구사항

- **FR-DESER-021**: **WHEN** rst가 assertion되면 **THEN** 시스템은 모든 내부 레지스터를 0으로 초기화해야 한다
  - iserdes_q_d1/d2 = 0
  - temp_word_d1/d2 = 0
  - fclk_in = 0

### 3.8 파라미터 검증 요구사항

- **FR-DESER-022**: DEV_W 파라미터는 **항상** 8이어야 한다

- **FR-DESER-023**: WORD_SIZE 파라미터는 8의 배수여야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 클록 | 주파수 | 주기 | 설명 |
|------|--------|------|------|
| clk_in_int_buf | 200 | MHz | 고속 비트 클록 |
| clk_div | 50 | MHz | 분주 클록 (1/4) |
| fclk_out | 2.34 | MHz | 프레임 클록 |

### 4.2 데이터 레이트

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| LVDS 비트 레이트 | 18.72 | Mbps | 8 x 2.34MHz |
| DDR 비트 레이트 | 200 | Mbps | ISERDESE2 클록 |

### 4.3 셋업/홀드 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| LVDS 셋업 | 0.5 | - | ns | 데이터 전 클록 |
| LVDS 홀드 | 0.5 | - | ns | 데이터 후 클록 |

### 4.4 CDC 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 동기화 지연 | 2 | 3 | 클록 | 2단계 플립플롭 |
| 안정화 시간 | - | 40 | ns | 최대 2 클록 @ 50MHz |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-DESER-001**: LVDS 입력이 정상적으로 단일 엔디드 신호로 변환되어야 한다
- **V-DESER-002**: 8:1 디시리얼라이징이 정확히 수행되어야 한다
- **V-DESER-003**: 24비트 워드 조립이 올바르게 수행되어야 한다
- **V-DESER-004**: 프레임 동기화가 fclk_out 에지에서 정확히 트리거되어야 한다
- **V-DESER-005**: CDC가 메타-스터블 없이 동작해야 한다

### 5.2 타이밍 검증

- **V-DESER-006**: ISERDESE2가 200MHz DDR 타이밍을 만족해야 한다
- **V-DESER-007**: 모든 데이터 경로가 타이밍 제약조건을 만족해야 한다

### 5.3 엣지 케이스 검증

- **V-DESER-008**: 리셋 시 모든 출력이 0이어야 한다
- **V-DESER-009**: 최대 데이터 레이트에서 데이터가 정확히 수신되어야 한다
- **V-DESER-010**: fclk_out 에지가 없을 때도 데이터가 계속 조립되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 Xilinx 프리미티브

- IBUFDS: LVDS differential input buffer
- ISERDESE2: 8:1 input serdes

### 6.2 파라미터

- DEV_W: 8 (디시리얼라이징 폭)
- WORD_SIZE: 24 (출력 워드 크기)
- IOSTANDARD: "LVDS_25"
- REFCLK_FREQ: 200.0 MHz

### 6.3 연관 모듈

- bit_clock_module: 클록 생성
- bit_align: 비트 정렬
- first_ch_detector: 첫 채널 검출

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 디시리얼라이징 시나리오

**Given**: LVDS 입력에 0~255 순차 데이터가 입력됨
**When**: fclk_out 에지가 발생함
**Then**: 24비트 워드가 정확히 조립되어 출력됨

### 7.2 CDC 동작 시나리오

**Given**: clk_div 도메인에서 3바이트 데이터가 조립됨
**When**: fclk_out 에지가 발생함
**Then**: 데이터가 안전하게 fclk_out 도메인으로 전송됨

### 7.3 리셋 시나리오

**Given**: 시스템이 동작 중
**When**: rst=1이 입력됨
**Then**: 모든 레지스터가 0으로 초기화됨
**And** 출력 데이터가 0이 됨

### 7.4 고속 데이터 시나리오

**Given**: 최대 데이터 레이트(18.72Mbps)로 입력됨
**When**: 연속 데이터가 입력됨
**Then**: 데이터가 손실 없이 정확히 디시리얼라이징됨

---

## 8. 제약사항 (Constraints)

### 8.1 하드웨어 제약사항

- IOSTANDARD: LVDS_25 (Artix-7)
- ISERDESE2 DATA_WIDTH: 8 (고정)
- ISERDESE2 INTERFACE_TYPE: NETWORKING

### 8.2 타이밍 제약사항

- 모든 경로는 타이밍 클로저를 만족해야 함
- CDC 경로는 2단계 이상 동기화가 필요함

### 8.3 리소스 제약사항

- ISERDESE2: 1개 (채널당)
- IBUFDS: 1개
- I/O 리소스: 3개 (data_in_p/n, clk_in_p/n)

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Interface Team*
