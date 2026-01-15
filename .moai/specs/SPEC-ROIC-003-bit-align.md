# SPEC-ROIC-003: Bit Alignment Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-003
Title: Bit Alignment Module - Pattern-Based Data Alignment
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Interface
Related: SPEC-ROIC-001, SPEC-ROIC-004
Module: bit_align.sv
Lines: 225
```

---

## 1. 개요 (Overview)

### 1.1 목적

Bit Alignment 모듈은 디시리얼라이징된 24비트 데이터의 비트 경계를 정렬합니다. 패턴 검출 또는 수동 시프트를 통해 LVDS 전송 중 발생할 수 있는 비트 스큐를 보상합니다.

### 1.2 주요 기능

- 패턴 기반 자동 비트 정렬
- 수동 시프트 모드 지원
- 배럴 시프터 구현
- 정렬 완료 검출
- 두 개의 정렬 패턴 지원 (PATTERN_1, PATTERN_2)

### 1.3 정렬 패턴

| 패턴 | 값 | 설명 |
|------|-----|------|
| PATTERN_1 | 24'hFFF000 | 첫 번째 정렬 패턴 (12개 연속 1 + 6개 연속 0) |
| PATTERN_2 | 24'hFF0000 | 두 번째 정렬 패턴 (8개 연속 1 + 8개 연속 0) |

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| data_rst | Input | logic | 데이터 도메인 리셋 (Active High) |
| clk | Input | logic | 클록 신호 |

### 2.2 데이터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| din | Input | logic [23:0] | 정렬할 입력 데이터 |

### 2.3 정렬 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| extra_shift | Input | logic [4:0] | 수동 시프트 값 (0~23) |
| align_to_fclk | Input | logic | 정렬 모드 선택 (0=패턴, 1=수동) |
| align_start | Input | logic | 정렬 시작 |

### 2.4 정렬 상태 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| shift_out | Output | logic [4:0] | 적용된 시프트 양 |
| align_done | Output | logic | 정렬 완료 플래그 |

### 2.5 데이터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| dout | Output | logic [23:0] | 정렬된 출력 데이터 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 입력 데이터 버퍼링 요구사항

- **FR-ALIGN-001**: 시스템은 **항상** 입력 데이터 din을 48비트 시프트 레지스터(datareg)에 저장해야 한다
  - datareg[47:24]: 이전 데이터
  - datareg[23:0]: 현재 데이터

- **FR-ALIGN-002**: 시스템은 **항상** 각 클록 사이클마다 새로운 데이터를 시프트 레지스터에 로드해야 한다

- **FR-ALIGN-003**: **WHEN** data_rst가 assertion되면 **THEN** 시스템은 datareg를 0으로 클리어해야 한다

### 3.2 패턴 검출 요구사항

- **FR-ALIGN-004**: 시스템은 **항상** datareg[23:0]에서 PATTERN_1(0xFFF000)과 PATTERN_2(0xFF0000)을 검출해야 한다

- **FR-ALIGN-005**: 시스템은 **항상** 모든 가능한 비트 로테이션(0~23비트 시프트)에 대해 패턴 매칭을 수행해야 한다

- **FR-ALIGN-006**: **WHEN** PATTERN_1 또는 PATTERN_2가 검출되면 **THEN** 시스템은 해당 시프트 양(shift_int_wire)을 계산해야 한다

### 3.3 정렬 모드 선택 요구사항

- **FR-ALIGN-007**: **IF** align_to_fclk=0(패턴 모드)이면 **THEN** 시스템은 자동으로 검출된 shift_int_wire를 사용해야 한다

- **FR-ALIGN-008**: **IF** align_to_fclk=1(수동 모드)이면 **THEN** 시스템은 extra_shift 입력값을 사용해야 한다

- **FR-ALIGN-009**: 시스템은 **항상** align_start 신호에 응답하여 시프트 값을 업데이트해야 한다

### 3.4 배럴 시프터 요구사항

- **FR-ALIGN-010**: 시스템은 **항상** total_shift 값만큼 datareg를 오른쪽으로 시프트해야 한다

- **FR-ALIGN-011**: 시스템은 **항상** 24비트 시프트를 수행하여 최상위 24비트를 출력해야 한다
  - total_shift=0: datareg[23:0]
  - total_shift=1: datareg[24:1]
  - total_shift=2: datareg[25:2]
  - ...
  - total_shift=23: datareg[46:23]

- **FR-ALIGN-012**: 시스템은 **항상** 시프트된 데이터를 dout 출력으로 등록해야 한다

### 3.5 정렬 완료 검출 요구사항

- **FR-ALIGN-013**: **WHEN** align_start가 assertion되고 dout이 PATTERN_1 또는 PATTERN_2와 일치하면 **THEN** 시스템은 align_done을 assertion해야 한다

- **FR-ALIGN-014**: **WHEN** 정렬이 실패하면(패턴 불일치) **THEN** 시스템은 align_done을 deassertion해야 한다

### 3.6 시프트 값 출력 요구사항

- **FR-ALIGN-015**: 시스템은 **항상** 적용된 시프트 양을 shift_out 출력으로 제공해야 한다

- **FR-ALIGN-016**: shift_out은 0~23 범위의 값을 가져야 한다

### 3.7 리셋 요구사항

- **FR-ALIGN-017**: **WHEN** data_rst가 assertion되면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다
  - datareg = 0
  - shift_int = 0
  - align_done_reg = 0
  - dout = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk 주파수 | 200 | MHz | fclk_out (최대) |
| clk 주기 | 5 | ns | 사이클 시간 |

### 4.2 정렬 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 정렬 시작 지연 | - | 1 | 클록 | align_start 후 |
| 패턴 검출 시간 | - | 1 | 클록 | datareg 업데이트 후 |
| 시프트 적용 시간 | - | 1 | 클록 | 조합 논리 |

### 4.3 시프트 범위

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| extra_shift | 0 | 23 | 비트 | 수동 시프트 |
| 검출 시프트 | 0 | 23 | 비트 | 자동 검출 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-ALIGN-001**: 패턴 모드에서 PATTERN_1 또는 PATTERN_2가 정확히 검출되어야 한다
- **V-ALIGN-002**: 모든 시프트 값(0~23)에 대해 정확한 시프트가 수행되어야 한다
- **V-ALIGN-003**: 수동 모드에서 extra_shift 값이 정확히 적용되어야 한다
- **V-ALIGN-004**: align_done이 정확한 시점에 assertion되어야 한다
- **V-ALIGN-005**: 시프트 출력이 올바른 값을 표시해야 한다

### 5.2 타이밍 검증

- **V-ALIGN-006**: 정렬 동작이 1클록 사이클 내에 완료되어야 한다
- **V-ALIGN-007**: 모든 경로가 200MHz 클록 타이밍을 만족해야 한다

### 5.3 엣지 케이스 검증

- **V-ALIGN-008**: 시프트=0일 때 입력 데이터가 그대로 출력되어야 한다
- **V-ALIGN-009**: 시프트=23일 때 최상위 24비트가 출력되어야 한다
- **V-ALIGN-010**: 패턴이 없는 입력에서 타임아웃 처리가 되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 200MHz fclk_out
- data_rst: 리셋 신호
- din: 24비트 입력 데이터
- align_start: 정렬 시작

### 6.2 파라미터

- DATA_WIDTH: 24 (데이터 경로 폭)
- PATTERN_1: 24'hFFF000
- PATTERN_2: 24'hFF0000

### 6.3 연관 모듈

- deser_single.sv: 디시리얼라이징된 데이터 제공
- first_ch_detector.sv: 정렬된 데이터 수신

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 패턴 기반 정렬 시나리오

**Given**: align_to_fclk=0(패턴 모드), 입력 데이터=0xFFF000
**When**: align_start=1
**Then**: shift_out=0, align_done=1, dout=0xFFF000

### 7.2 수동 시프트 시나리오

**Given**: align_to_fclk=1(수동 모드), extra_shift=5
**When**: align_start=1
**Then**: shift_out=5, dout=datareg 오른쪽 5비트 시프트

### 7.3 정렬 실패 시나리오

**Given**: align_to_fclk=0, 입력 데이터=0x000000(패턴 없음)
**When**: align_start=1
**Then**: align_done=0, shift_out=0

### 7.4 최대 시프트 시나리오

**Given**: align_to_fclk=1, extra_shift=23
**When**: align_start=1
**Then**: dout=datareg[46:23], shift_out=23

---

## 8. 제약사항 (Constraints)

### 8.1 데이터 폭 제약사항

- DATA_WIDTH는 24로 고정
- 시프트 범위는 0~(DATA_WIDTH-1)

### 8.2 타이밍 제약사항

- 모든 경로는 200MHz 클록 타이밍을 만족해야 함
- 조합 논리는 최소화하여 타이밍을 개선해야 함

### 8.3 리소스 제약사항

- 시프트 레지스터: 48비트 (2 x 24)
- 패턴 매칭 로직: 조합 논리

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Interface Team*
