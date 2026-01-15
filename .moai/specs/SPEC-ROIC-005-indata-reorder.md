# SPEC-ROIC-005: Data Reorder Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-005
Title: Data Reorder Module - Frame Data Buffering and Reordering
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Interface
Related: SPEC-ROIC-001, SPEC-ROIC-006
Module: indata_reorder.sv
Lines: 339
```

---

## 1. 개요 (Overview)

### 1.1 목적

Data Reorder 모듈은 ROIC 채널에서 수신된 24비트 데이터를 짝수/홀수 프레임별로 버퍼링하고 재정렬합니다. 듀얼포트 RAM을 사용하여 안정적인 데이터 저장 및 출력을 제공합니다.

### 1.2 주요 기능

- 듀얼포트 RAM 기반 데이터 버퍼링
- 짝수/홀수 프레임 분리 처리
- 채널 검출 기반 쓰기 제어
- 외부 읽기 요청 기반 출력
- 테스트 패턴 생성 지원
- 256 샘플 블록 단위 처리

### 1.3 데이터 경로

```
Detected Data → Channel Detect → Even/Odd Buffer → RAM → Read Request → Output Data A/B
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 입력 클록 (fclk_out) |
| rst | Input | logic | 리셋 (Active High) |
| sync | Input | logic | 동기화 신호 |
| out_clk | Input | logic | 출력 클록 (240MHz) |

### 2.2 제어 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| read_req | Input | logic | 읽기 요청 |
| en_test_pattern_col | Input | logic | 컬럼 테스트 패턴 활성화 |
| en_test_pattern_row | Input | logic | 로우 테스트 패턴 활성화 |

### 2.3 데이터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| data_in | Input | logic [23:0] | 입력 데이터 |
| valid_in | Input | logic | 입력 데이터 유효 |
| channel_detected | Input | logic | 채널 검출 신호 |

### 2.4 디버그 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| even_odd_toggle_out | Output | logic | 짝수/홀수 토글 출력 |
| roic_even_odd_out | Output | logic | ROIC 짝수/홀수 출력 |

### 2.5 데이터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| valid_read_enable | Output | logic | 읽기 데이터 활성화 |
| data_out_a | Output | logic [23:0] | 출력 데이터 A |
| data_out_b | Output | logic [23:0] | 출력 데이터 B |
| valid_out | Output | logic | 출력 데이터 유효 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 데이터 쓰기 제어 요구사항

- **FR-REORDER-001**: 시스템은 **항상** valid_in=1일 때 data_in을 버퍼에 써야 한다

- **FR-REORDER-002**: **WHEN** channel_detected=1이면 **THEN** 시스템은 첫 번째 채널로 간주하고 쓰기 카운트를 시작해야 한다

- **FR-REORDER-003**: 시스템은 **항상** first_channel 플래그를 사용하여 첫 채널 검출을 관리해야 한다

- **FR-REORDER-004**: 시스템은 **항상** 쓰기 주소(wr_addr)를 증가시키며 데이터를 순차적으로 저장해야 한다

- **FR-REORDER-005**: 시스템은 **항상** 256 샘플 단위로 블록 카운트(wr_block_count)를 관리해야 한다

### 3.2 짝수/홀수 프레임 처리 요구사항

- **FR-REORDER-006**: 시스템은 **항상** even_odd_toggle 신호를 사용하여 짝수/홀수 프레임을 교대로 처리해야 한다

- **FR-REORDER-007**: 시스템은 **항상** 짝수 프레임 데이터를 ram_write_enable_even 포트에 써야 한다

- **FR-REORDER-008**: 시스템은 **항상** 홀수 프레임 데이터를 ram_write_enable_odd 포트에 써야 한다

- **FR-REORDER-009**: 시스템은 **항상** roic_even_odd 신호를 사용하여 현재 프레임 타입을 표시해야 한다

### 3.3 RAM 버퍼 관리 요구사항

- **FR-REORDER-010**: 시스템은 **항상** 듀얼포트 RAM을 사용하여 독립적인 읽기/쓰기 동작을 지원해야 한다

- **FR-REORDER-011**: 시스템은 **항상** BUFFER_DEPTH(256)만큼의 데이터를 저장할 수 있어야 한다

- **FR-REORDER-012**: **WHEN** wr_addr이 BUFFER_DEPTH-1에 도달하면 **THEN** 시스템은 주소를 0으로 랩핑해야 한다

- **FR-REORDER-013**: 시스템은 **항상** wr_count를 사용하여 현재 저장된 데이터 수를 추적해야 한다

### 3.4 데이터 읽기 제어 요구사항

- **FR-REORDER-014**: **WHEN** read_req=1이면 **THEN** 시스템은 저장된 데이터를 출력해야 한다

- **FR-REORDER-015**: 시스템은 **항상** 읽기 주소(rd_addr)를 사용하여 순차적으로 데이터를 읽어야 한다

- **FR-REORDER-016**: 시스템은 **항상** out_clk(240MHz)에 동기하여 데이터를 출력해야 한다

- **FR-REORDER-017**: 시스템은 **항상** data_out_a와 data_out_b 두 개의 데이터 경로를 제공해야 한다

### 3.5 테스트 패턴 요구사항

- **FR-REORDER-018**: **WHEN** en_test_pattern_col=1이면 **THEN** 시스템은 컬럼 테스트 패턴을 생성해야 한다

- **FR-REORDER-019**: **WHEN** en_test_pattern_row=1이면 **THEN** 시스템은 로우 테스트 패턴을 생성해야 한다

- **FR-REORDER-020**: 테스트 패턴 데이터는 **항상** {wr_count[7:0], s_test_even_odd, wr_count[6:0], 8'd0} 형식이어야 한다

### 3.6 동기화 요구사항

- **FR-REORDER-021**: **WHEN** sync=1이면 **THEN** 시스템은 모든 카운터와 상태를 리셋해야 한다

- **FR-REORDER-022**: sync_rst는 **항상** rst와 sync의 OR로 생성되어야 한다

### 3.7 쓰기 완료 요구사항

- **FR-REORDER-023**: 시스템은 **항상** wr_end_flag를 사용하여 쓰기 완료를 표시해야 한다

- **FR-REORDER-024**: 시스템은 **항상** rd_end_flag를 사용하여 읽기 완료를 표시해야 한다

### 3.8 리셋 요구사항

- **FR-REORDER-025**: **WHEN** sync_rst=1이면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다
  - wr_addr = 0
  - s_wr_count = 0
  - first_channel = 1
  - even_odd_toggle = 0
  - roic_even_odd = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 클록 | 주파수 | 주기 | 설명 |
|------|--------|------|------|
| clk (fclk_out) | 16.67 | MHz | 입력 클록 (최대) |
| out_clk | 240 | MHz | 출력 클록 |

### 4.2 버퍼 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| BUFFER_DEPTH | 256 | - | 버퍼 깊이 |
| 블록 크기 | 256 | 샘플 | 블록 단위 |

### 4.3 쓰기 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| valid_in 펄스 폭 | 1 | - | 클록 | 최소 |
| 쓰기 속도 | - | 16.67 | Msps | 최대 |

### 4.4 읽기 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| read_req 펄스 폭 | 1 | - | 클록 | 최소 |
| 읽기 데이터 유효 | - | 4.17 | ns | 1/240MHz |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-REORDER-001**: valid_in=1인 모든 데이터가 버퍼에 저장되어야 한다
- **V-REORDER-002**: 짝수/홀수 프레임이 올바르게 분리되어야 한다
- **V-REORDER-003**: read_req=1일 때 저장된 데이터가 순차적으로 출력되어야 한다
- **V-REORDER-004**: 테스트 패턴이 정상적으로 생성되어야 한다
- **V-REORDER-005**: 256 샘플 블록이 올바르게 처리되어야 한다

### 5.2 타이밍 검증

- **V-REORDER-006**: 쓰기 동작이 16.67MHz 클록 타이밍을 만족해야 한다
- **V-REORDER-007**: 읽기 동작이 240MHz 클록 타이밍을 만족해야 한다
- **V-REORDER-008**: CDC 경로가 안전하게 동작해야 한다

### 5.3 엣지 케이스 검증

- **V-REORDER-009**: 버퍼 오버플로우 시 주소가 정상적으로 랩핑되어야 한다
- **V-REORDER-010**: sync=1 시 모든 상태가 초기화되어야 한다
- **V-REORDER-011**: 채널 검출 없는 입력이 무시되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 입력 클록
- out_clk: 출력 클록
- rst: 리셋
- sync: 동기화

### 6.2 파라미터

- DATA_WIDTH: 24 (데이터 경로 폭)
- BUFFER_DEPTH: 256 (버퍼 깊이)

### 6.3 연관 모듈

- first_ch_detector.sv: 채널 검출 신호 제공
- ti_roic_top.sv: 상위 모듈

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 데이터 저장 시나리오

**Given**: valid_in=1, channel_detected=1
**When**: data_in이 입력됨
**Then**: 데이터가 버퍼에 저장됨
**And** wr_addr가 증가함

### 7.2 짝수/홀수 프레임 처리 시나리오

**Given**: 짝수 프레임 데이터가 입력됨
**When**: even_odd_toggle=0
**Then**: 데이터가 ram_write_enable_even 포트에 저장됨

### 7.3 읽기 요청 시나리오

**Given**: 버퍼에 데이터가 저장됨
**When**: read_req=1
**Then**: 저장된 데이터가 data_out_a/b로 출력됨
**And** valid_out=1이 됨

### 7.4 테스트 패턴 시나리오

**Given**: en_test_pattern_row=1
**When**: 데이터가 저장됨
**Then**: 테스트 패턴 데이터가 생성됨

---

## 8. 제약사항 (Constraints)

### 8.1 버퍼 제약사항

- BUFFER_DEPTH는 2의 거듭제곱이어야 함
- RAM은 듀얼포트여야 함

### 8.2 타이밍 제약사항

- 모든 경로는 타이밍 클로저를 만족해야 함
- CDC 경로는 안전하게 동기화되어야 함

### 8.3 리소스 제약사항

- BRAM: 1개 (256x24 듀얼포트)
- 플립플롭: 최소화

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Interface Team*
