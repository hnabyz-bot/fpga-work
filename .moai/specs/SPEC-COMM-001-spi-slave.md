# SPEC-COMM-001: SPI Slave Module

## 태그 블록

```yaml
SPEC_ID: SPEC-COMM-001
Title: SPI Slave Module - Serial Peripheral Interface Slave
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: Communication Interface
Related: SPEC-SYS-001, SPEC-SYS-003
Module: spi_slave.sv
Lines: 242
```

---

## 1. 개요 (Overview)

### 1.1 목적

SPI Slave 모듈은 표준 SPI(Serial Peripheral Interface) 슬레이브 프로토콜을 구현합니다. 외부 SPI 마스터(MCU/프로세서)와 통신하여 레지스터 읽기/쓰기 작업을 수행합니다.

### 1.2 주요 기능

- SPI 슬레이브 프로토콜 구현
- CPOL=0, CPHA=0 모드 지원
- 프레임 기반 데이터 전송
- 읽기/쓰기 명령 디코딩
- 비트 카운터 기반 프레임 동기화

### 1.3 SPI 프레임 형식

```
[WR:1][ADDR:7][DATA:16] = 17비트 SPI 프레임
- WR: 0=쓰기, 1=읽기
- ADDR: 7비트 레지스터 주소
- DATA: 16비트 데이터
```

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 리셋

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 시스템 클록 |
| reset | Input | logic | 시스템 리셋 |

### 2.2 SPI 물리적 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| SCLK | Input | logic | SPI 클록 |
| SSB | Input | logic | 슬레이브 선택 (Active Low) |
| MOSI | Input | logic | 마스터 아웃 슬레이브 인 |
| MISO | Output | logic | 마스터 인 슬레이브 아웃 |

### 2.3 프레임 동기화

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| spi_start_flag | Output | logic | SPI 프레임 시작 플래그 |

### 2.4 레지스터 인터페이스 (마스터 → 슬레이브)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| reg_addr | Output | logic [6:0] | 레지스터 주소 |
| addr_valid | Output | logic | 주소 유효 플래그 |
| wr_data | Output | logic [15:0] | 쓰기 데이터 |
| wr_data_valid | Output | logic | 쓰기 데이터 유효 |
| rw_out | Output | logic | 읽기/쓰기 방향 (1=읽기) |

### 2.5 레지스터 인터페이스 (슬레이브 → 마스터)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| read_data | Input | logic [15:0] | 읽기 데이터 |
| read_en | Input | logic | 읽기 활성화 |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 SPI 신호 동기화 요구사항

- **FR-SPI-001**: 시스템은 **항상** SCLK, SSB, MOSI 신호를 시스템 clk 도메인으로 동기화해야 한다

- **FR-SPI-002**: 시스템은 **항상** 3비트 시프트 레지스터를 사용하여 SCLK 에지를 검출해야 한다

- **FR-SPI-003**: 시스템은 **항상** 3비트 시프트 레지스터를 사용하여 SSB 에지를 검출해야 한다

- **FR-SPI-004**: 시스템은 **항상** 11비트 시프트 레지스터를 사용하여 MOSI를 안정적으로 샘플링해야 한다

### 3.2 SPI 에지 검출 요구사항

- **FR-SPI-005**: 시스템은 **항상** sclk_falling_edge와 sclk_rising_edge를 검출해야 한다
  - sclk_falling_edge: 110 → 100 전이
  - sclk_rising_edge: 001 → 011 전이

- **FR-SPI-006**: 시스템은 **항상** sclk_edge를 sclk_falling_edge로 설정해야 한다 (CPOL=0, CPHA=0)

### 3.3 SPI 프레임 동기화 요구사항

- **FR-SPI-007**: **WHEN** SSB가 1→0으로 전이되면(spi_start) **THEN** 시스템은 새로운 SPI 프레임을 시작해야 한다

- **FR-SPI-008**: **WHEN** SSB가 0→1로 전이되면(spi_end) **THEN** 시스템은 현재 SPI 프레임을 종료해야 한다

- **FR-SPI-009**: 시스템은 **항상** spi_active 신호(SSB의 반전)를 사용하여 프레임 활성 상태를 추적해야 한다

- **FR-SPI-010**: 시스템은 **항상** spi_start_flag를 출력하여 외부 모듈에 프레임 시작을 알려야 한다

### 3.4 비트 카운터 요구사항

- **FR-SPI-011**: 시스템은 **항상** bitcnt를 사용하여 수신된 비트 수를 추적해야 한다

- **FR-SPI-012**: **WHEN** spi_start가 검출되면 **THEN** 시스템은 bitcnt를 0으로 리셋해야 한다

- **FR-SPI-013**: **WHEN** spi_active=1이고 sclk_edge가 검출되면 **THEN** 시스템은 bitcnt를 증가시켜야 한다

### 3.5 읽기/쓰기 디코딩 요구사항

- **FR-SPI-014**: 시스템은 **항상** 첫 번째 비트(bitcnt=0)를 읽기/쓰기 플래그로 해석해야 한다
  - MOSI=0: 쓰기 명령
  - MOSI=1: 읽기 명령

- **FR-SPI-015**: 시스템은 **항당** rw_out 출력에 읽기/쓰기 방향을 제공해야 한다

- **FR-SPI-016**: **WHEN** 첫 번째 비트가 수신되면 **THEN** 시스템은 flag_wr 레지스터를 설정해야 한다

### 3.6 주소 디코딩 요구사항

- **FR-SPI-017**: 시스템은 **항상** 비트 1~7을 사용하여 7비트 주소를 추출해야 한다

- **FR-SPI-018**: **WHEN** 7비트 주소 수신이 완료되면(bitcnt=7) **THEN** 시스템은 reg_addr를 출력하고 addr_valid를 assertion해야 한다

### 3.7 데이터 수신 요구사항

- **FR-SPI-019**: 시스템은 **항상** 비트 8~23을 사용하여 16비트 데이터를 수신해야 한다

- **FR-SPI-020**: **WHEN** 16비트 데이터 수신이 완료되면(bitcnt=23) **THEN** 시스템은 wr_data를 출력하고 wr_data_valid를 assertion해야 한다

### 3.8 데이터 송신 요구사항

- **FR-SPI-021**: 시스템은 **항상** 읽기 명령 시 MISO를 통해 read_data를 전송해야 한다

- **FR-SPI-022**: 시스템은 **항상** sclk_rising_edge에서 MISO 데이터를 변경해야 한다

- **FR-SPI-023**: 시스템은 **항상** read_en 신호에 동기하여 read_data를 샘플링해야 한다

### 3.9 리셋 요구사항

- **FR-SPI-024**: **WHEN** reset=1이면 **THEN** 시스템은 모든 내부 상태를 초기화해야 한다
  - bitcnt = 0
  - flag_wr = 0
  - 모든 동기화 레지스터 = 0

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk 주파수 | 100 | MHz | 시스템 클록 |
| SCLK 주파수 | 최대 5 | MHz | SPI 클록 |

### 4.2 SPI 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| SCLK 주기 | 200 | - | ns | 5MHz @ 최대 |
| SSB 셋업 | 10 | - | ns | SCLK 전 |
| SSB 홀드 | 10 | - | ns | SCLK 후 |
| MOSI 셋업 | 10 | - | ns | SCLK 에지 전 |
| MOSI 홀드 | 10 | - | ns | SCLK 에지 후 |

### 4.3 프레임 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| 프레임 크기 | 17 | 비트 | [WR:1][ADDR:7][DATA:16] |
| 프레임 시간 | 3.4 | us | 최대 @ 5MHz |

### 4.4 동기화 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| 메타-스터블 방지 | 3 | - | 클록 | 동기화 레지스터 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-SPI-001**: SPI 슬레이브가 정상적으로 SCLK, SSB, MOSI를 샘플링해야 한다
- **V-SPI-002**: 쓰기 명령이 정확히 디코딩되어야 한다
- **V-SPI-003**: 읽기 명령이 정확히 디코딩되어야 한다
- **V-SPI-004**: 16비트 데이터가 정확히 수신되어야 한다
- **V-SPI-005**: 16비트 데이터가 정확히 송신되어야 한다

### 5.2 타이밍 검증

- **V-SPI-006**: 최대 5MHz SCLK에서 정상 동작해야 한다
- **V-SPI-007**: 모든 셋업/홀드 타이밍을 만족해야 한다
- **V-SPI-008**: 에지 검출이 정확히 수행되어야 한다

### 5.3 엣지 케이스 검증

- **V-SPI-009**: SSB가 중간에 해제되면 프레임이 종료되어야 한다
- **V-SPI-010**: 잘못된 주소가 무시되어야 한다
- **V-SPI-011**: 리셋 시 모든 출력이 안전한 상태여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- clk: 시스템 클록
- reset: 리셋
- SCLK, SSB, MOSI: SPI 물리적 신호

### 6.2 파라미터

- header: 2 (WR/RD 비트 크기)
- payload: 16 (데이터 크기)
- addrsz: 7 (주소 크기)
- pktsz: 25 (총 패킷 크기)

### 6.3 연관 모듈

- reg_map.sv: 레지스터 인터페이스
- spi_slave (하위): SPI 슬레이브 구현

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 쓰기 명령 시나리오

**Given**: SPI 슬레이브가 대기 상태
**When**: 마스터가 [0][0x10][0x1234] 프레임을 전송 (WR=0, ADDR=0x10, DATA=0x1234)
**Then**: wr_data=0x1234, wr_data_valid=1, reg_addr=0x10, addr_valid=1
**And** rw_out=0 (쓰기)

### 7.2 읽기 명령 시나리오

**Given**: SPI 슬레이브가 대기 상태
**When**: 마스터가 [1][0x10][0x0000] 프레임을 전송 (RD=1, ADDR=0x10)
**Then**: reg_addr=0x10, addr_valid=1
**And** rw_out=1 (읽기)
**And** MISO가 read_data를 전송함

### 7.3 프레임 중단 시나리오

**Given**: SPI 프레임이 진행 중
**When**: SSB가 0→1로 전이됨
**Then**: 현재 프레임이 종료되고 bitcnt가 리셋됨

### 7.4 최대 속도 시나리오

**Given**: SCLK=5MHz
**When**: 연속적인 프레임이 전송됨
**Then**: 모든 데이터가 정확히 수신/송신됨

---

## 8. 제약사항 (Constraints)

### 8.1 SPI 모드 제약사항

- CPOL=0 (클크 유휀 레벨 = 0)
- CPHA=0 (클럭-leading 에지에서 샘플링)

### 8.2 타이밍 제약사항

- 최대 SCLK 주파수: 5MHz
- 모든 셋업/홀드 시간 준수

### 8.3 리소스 제약사항

- 시프트 레지스터: 최소화
- 동기화 레지스터: 3단계

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: Communication Interface Team*
