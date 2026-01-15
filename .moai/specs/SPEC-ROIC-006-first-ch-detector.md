# SPEC-ROIC-006: First Channel Detector Module

## 태그 블록

```yaml
SPEC_ID: SPEC-ROIC-006
Title: First Channel Detector - Frame Synchronization Pattern Detection
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: ROIC Interface
Related: SPEC-ROIC-001, SPEC-ROIC-005
Module: first_ch_detector.sv
Lines: 322
```

---

## 1. 개요 (Overview)

### 1.1 목적

First Channel Detector 모듈은 입력 데이터 스트림에서 특정 패턴(0xB8 또는 0xF8)을 검출하여 프레임 동기화를 제공합니다. 4개의 연속된 패턴 검출 시 1클록 펄스를 생성합니다.

### 1.2 주요 기능

- 하위 8비트 패턴 검출 (0xB8, 0xF8)
- 슬라이딩 시프트 레지스터 기반 데이터 버퍼링
- 4회 연속 매칭 카운터
- 1클록 펄스 생성
- 데이터 레이턴시 보상

### 1.3 검출 패턴

| 패턴 | 값 | 설명 |
|------|-----|------|
| 0xB8 | 10111000 | 첫 번째 채널 패턴 |
| 0xF8 | 11111000 | 두 번째 채널 패턴 |

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 클록 신호 |
| rst | Input | logic | 리셋 (Active High) |

### 2.2 데이터 입력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| aligned_data_in | Input | logic [23:0] | 정렬된 24비트 입력 데이터 |

### 2.3 검출 상태 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| detect_data_valid | Output | logic | 데이터 유효 플래그 |
| first_sample_pulse | Output | logic | 첫 샘플 펄스 (1클록) |

### 2.4 데이터 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| word_data_out | Output | logic [23:0] | 동기화된 출력 데이터 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 패턴 검출 요구사항

- **FR-DET-001**: 시스템은 **항상** aligned_data_in의 하위 8비트 aligned_data_in[7:0]에서 패턴을 검출해야 한다

- **FR-DET-002**: 시스템은 **항상** 0xB8 또는 0xF8 패턴을 유효한 패턴으로 간주해야 한다

- **FR-DET-003**: is_valid_pattern 신호는 **항상** (aligned_data_in[7:0] == 8'hB8) OR (aligned_data_in[7:0] == 8'hF8)이어야 한다

### 3.2 슬라이딩 시프트 레지스터 요구사항

- **FR-DET-004**: 시스템은 **항상** 3개의 24비트 시프트 레지스터를 유지해야 한다
  - data_shift_reg0: 최신 데이터
  - data_shift_reg1: 1클록 전 데이터
  - data_shift_reg2: 2클록 전 데이터

- **FR-DET-005**: 시스템은 **항상** 각 클록 사이클마다 데이터를 시프트해야 한다
  - data_shift_reg2 ← data_shift_reg1
  - data_shift_reg1 ← data_shift_reg0
  - data_shift_reg0 ← aligned_data_in

- **FR-DET-006**: **WHEN** rst=1이면 **THEN** 시스템은 모든 시프트 레지스터를 0으로 클리어해야 한다

### 3.3 매칭 카운터 요구사항

- **FR-DET-007**: 시스템은 **항상** match_count를 사용하여 연속된 유효 패턴 수를 추적해야 한다

- **FR-DET-008**: **WHEN** is_valid_pattern=1이면 **THEN** 시스템은 match_count를 증가시켜야 한다

- **FR-DET-009**: **WHEN** is_valid_pattern=0이면 **THEN** 시스템은 match_count를 0으로 리셋해야 한다

- **FR-DET-010**: match_count는 **항상** 0~3 범위를 가져야 한다

### 3.4 첫 샘플 펄스 생성 요구사항

- **FR-DET-011**: **WHEN** match_count가 3이 되면(4번째 연속 매칭) **THEN** 시스템은 first_sample_pulse를 1클록 펄스로 assertion해야 한다

- **FR-DET-012**: first_sample_pulse는 **항상** 정확히 1클록 동안만 High여야 한다

- **FR-DET-013**: **WHEN** first_sample_pulse가 assertion되면 **THEN** 시스템은 match_count를 0으로 리셋해야 한다

### 3.5 데이터 유효 플래그 요구사항

- **FR-DET-014**: 시스템은 **항상** detect_data_valid를 사용하여 유효한 데이터를 표시해야 한다

- **FR-DET-015**: **WHEN** match_count가 3이 되면 **THEN** 시스템은 detect_data_valid를 assertion해야 한다

- **FR-DET-016**: detect_data_valid는 **항상** 첫 샘플 펄스와 동기되어야 한다

### 3.6 데이터 레이턴시 보상 요구사항

- **FR-DET-017**: 시스템은 **항상** word_data_out으로 data_shift_reg2를 출력해야 한다

- **FR-DET-018**: word_data_out는 **항상** aligned_data_in보다 2클록 지연되어야 한다

- **FR-DET-019**: 2클록 지연은 first_sample_pulse와 데이터를 정렬하기 위함

### 3.7 리셋 요구사항

- **FR-DET-020**: **WHEN** rst=1이면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다
  - match_count = 0
  - first_sample_pulse = 0
  - word_data_out = 0
  - detect_data_valid = 0
  - 모든 시프트 레지스터 = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk 주파수 | 200 | MHz (최대) | 시스템 클록 |
| clk 주기 | 5 | ns | 사이클 시간 |

### 4.2 검출 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 패턴 검출 지연 | - | 1 | 클록 | aligned_data_in 후 |
| 펄스 폭 | 1 | 1 | 클록 | first_sample_pulse |
| 데이터 레이턴시 | 2 | 2 | 클록 | aligned_data_in → word_data_out |

### 4.3 연속 매칭 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| 매칭 요구 수 | 4 | 회 | 연속 패턴 |
| 최대 검출 시간 | 20 | ns | 4클록 @ 200MHz |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-DET-001**: 0xB8 패턴이 정확히 검출되어야 한다
- **V-DET-002**: 0xF8 패턴이 정확히 검출되어야 한다
- **V-DET-003**: 4개의 연속된 패턴이 검출되어야 한다
- **V-DET-004**: first_sample_pulse가 정확히 1클록 펄스로 생성되어야 한다
- **V-DET-005**: 패턴이 중간에 끊어지면 카운터가 리셋되어야 한다

### 5.2 타이밍 검증

- **V-DET-006**: 패턴 검출이 1클록 내에 완료되어야 한다
- **V-DET-007**: 펄스 폭이 정확히 1클록이어야 한다
- **V-DET-008**: 데이터 레이턴시가 2클록이어야 한다

### 5.3 엣지 케이스 검증

- **V-DET-009**: 패턴이 없는 입력에서 펄스가 생성되지 않아야 한다
- **V-DET-010**: 리셋 시 모든 출력이 0이어야 한다
- **V-DET-011**: 최대 데이터 레이트에서도 정확히 검출되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 시스템 클록
- rst: 리셋
- aligned_data_in: 24비트 정렬된 데이터

### 6.2 연관 모듈

- bit_align.sv: 정렬된 데이터 제공
- indata_reorder.sv: 검출 신호 수신

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 패턴 검출 시나리오

**Given**: 입력 데이터에 4개의 연속된 0xB8 패턴이 존재
**When**: 4번째 패턴이 입력됨
**Then**: first_sample_pulse=1, detect_data_valid=1
**And** match_count가 0으로 리셋됨

### 7.2 패턴 중단 시나리오

**Given**: 2개의 0xB8 패턴 후에 다른 데이터(0x00)가 입력됨
**When**: 패턴이 중단됨
**Then**: match_count=0으로 리셋됨
**And** first_sample_pulse=0

### 7.3 혼합 패턴 시나리오

**Given**: 0xB8, 0xF8이 교대로 입력됨
**When**: 4개의 연속된 패턴이 검출됨
**Then**: first_sample_pulse=1로 assertion됨
**And** 양 패턴 모두 유효한 것으로 간주됨

### 7.4 리셋 시나리오

**Given**: 시스템이 동작 중
**When**: rst=1이 입력됨
**Then**: 모든 상태가 초기화됨
**And** 모든 출력이 0이 됨

---

## 8. 제약사항 (Constraints)

### 8.1 패턴 제약사항

- 검출 패턴은 하위 8비트로 제한됨
- 패턴은 0xB8 또는 0xF8로 고정됨

### 8.2 카운터 제약사항

- match_count는 2비트 (0~3)
- 4개 연속 매칭 필요

### 8.3 타이밍 제약사항

- 모든 경로는 200MHz 클록 타이밍을 만족해야 함
- 조합 논리는 최소화되어야 함

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: ROIC Interface Team*
