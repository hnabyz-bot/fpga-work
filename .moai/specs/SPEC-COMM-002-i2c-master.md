# SPEC-COMM-002: I2C Master Module

## 태그 블록

```yaml
SPEC_ID: SPEC-COMM-002
Title: I2C Master Module - I2C Bus Master Controller
Created: 2026-01-15
Status: Implemented
Priority: Medium
Assigned: Communication Interface
Related: SPEC-SYS-001
Module: i2c_master.sv
Lines: 186
```

---

## 1. 개요 (Overview)

### 1.1 목적

I2C Master 모듈은 I2C 버스 마스터 기능을 제공하여 외부 I2C 슬레이브 디바이스와 통신합니다. 주로 게이트 드라이브 IC 제어용으로 사용됩니다.

### 1.2 주요 기능

- I2C 마스터 프로토콜 구현
- START/STOP 조건 생성
- 슬레이브 주소 지정
- 데이터 송수신
- ACK 비트 처리

### 1.3 I2C 버스 사양

| 파라미터 | 값 | 설명 |
|----------|-----|------|
| SLAVE_ADDR | 0xE8 | 7비트 슬레이브 주소 |
| SCL 주파수 | ~25 kHz | 저속 I2C |

---

## 2. 인터페이스 (Interface)

### 2.1 클록 및 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| s_clk_25mhz | Input | logic | 25MHz 시스템 클록 |
| gate_gpio_data | Input | logic [15:0] | 게이트 GPIO 데이터 |

### 2.2 I2C 버스 신호

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| scl_out | Output | wire | I2C 클록 출력 |
| sda | Inout | wire | I2C 데이터 (bidirectional) |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 I2C 클록 생성 요구사항

- **FR-I2C-001**: 시스템은 **항상** s_clk_25mhz를 사용하여 I2C SCL 클록을 생성해야 한다

- **FR-I2C-002**: 시스템은 **항상** scl_count를 사용하여 SCL 주파수를 제어해야 다
  - scl_count=10: SCL=1 (High)
  - scl_count=20: SCL=0 (Low)
  - scl_count=0: 클리어 및 재시작

- **FR-I2C-003**: 시스템은 **항상** scl_sel 신호를 사용하여 SCL 출력을 제어해야 한다

- **FR-I2C-004**: 시스템은 **항상** scl_h 신호를 사용하여 SCL High 상태를 제어해야 한다

### 3.2 상태 머신 요구사항

- **FR-I2C-005**: 시스템은 **항상** 다음 상태를 순환해야 한다
  - IDLE → START → WRITE_ADDR → WRITE_DATA → ACK → STOP/DELAY → IDLE

- **FR-I2C-006**: **WHEN** state=IDLE이고 busy=0이면 **THEN** 시스템은 START 상태로 전이해야 한다

- **FR-I2C-007**: **WHEN** state=START이면 **THEN** 시스템은 I2C START 조건을 생성해야 한다
  - sda_dir=1 (출력)
  - sda_out=0 (High→Low)

### 3.3 슬레이브 주소 지정 요구사항

- **FR-I2C-008**: **WHEN** state=WRITE_ADDR이면 **THEN** 시스템은 슬레이브 주소를 전송해야 한다

- **FR-I2C-009**: 시스템은 **항상** SLAVE_ADDR(0xE8)를 비트 시프트하여 전송해야 한다

- **FR-I2C-010**: 시스템은 **항상** 8비트 주소를 비트별로 전송해야 한다

### 3.4 데이터 전송 요구사항

- **FR-I2C-011**: **WHEN** state=WRITE_DATA이면 **THEN** 시스템은 데이터를 전송해야 한다

- **FR-I2C-012**: 시스템은 **항상** data_to_slave 또는 data_to_slave2를 전송해야 한다

- **FR-I2C-013**: 시스템은 **항상** 8비트 데이터를 비트별로 전송해야 한다

### 3.5 ACK 처리 요구사항

- **FR-I2C-014**: **WHEN** state=ACK이면 **THEN** 시스템은 sda_dir=0로 설정하여 슬레이브 ACK를 수신해야 한다

- **FR-I2C-015**: **WHEN** sda_in=0(ACK 수신)이면 **THEN** 시스템은 다음 상태로 진행해야 한다

- **FR-I2C-016**: **WHEN** sda_in=1(NACK)이면 **THEN** 시스템은 IDLE 상태로 복귀해야 한다

### 3.6 STOP 조건 생성 요구사항

- **FR-I2C-017**: **WHEN** state=STOP이면 **THEN** 시스템은 I2C STOP 조건을 생성해야 한다
  - sda_dir=1 (출력)
  - sda_out=1 (Low→High)

### 3.7 DELAY 상태 요구사항

- **FR-I2C-018**: **WHEN** state=DELAY이면 **THEN** 시스템은 delay_counter를 감소시켜야 한다

- **FR-I2C-019**: **WHEN** delay_counter=0이면 **THEN** 시스템은 다음 명령을 처리해야 한다

- **FR-I2C-020**: 시스템은 **항상** write_counter를 사용하여 전송할 데이터 수를 추적해야 한다

### 3.8 제어 데이터 설정 요구사항

- **FR-I2C-021**: **WHEN** write_counter=0이면 **THEN** 시스템은 다음 데이터를 설정해야 한다
  - slave_address = SLAVE_ADDR
  - data_to_slave = 0x06 (첫 번째 명령)

- **FR-I2C-022**: **WHEN** write_counter=1이면 **THEN** 시스템은 gate_gpio_data[7:0]을 전송해야 한다

- **FR-I2C-023**: **WHEN** write_counter=2이면 **THEN** 시스템은 0x02 명령과 gate_gpio_data[15:8]을 전송해야 한다

- **FR-I2C-024**: **WHEN** write_counter=3이면 **THEN** 시스템은 0x03 명령을 전송해야 한다

### 3.9 버스 방향 제어 요구사항

- **FR-I2C-025**: sda는 **항상** inout 포트로 구현되어야 한다

- **FR-I2C-026**: sda_dir=1일 때 sda는 **항상** 출력 모드여야 한다

- **FR-I2C-027**: sda_dir=0일 때 sda는 **항상** 입력 모드여야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| s_clk_25mhz | 25 | MHz | 시스템 클록 |
| SCL 주파수 | ~25 | kHz | I2C 클록 |
| SCL 주기 | ~40 | us | I2C 클록 주기 |

### 4.2 I2C 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| SCL Low 시간 | 4.7 | - | us | Standard mode |
| SCL High 시간 | 4.0 | - | us | Standard mode |
| SDA 셋업 | 250 | - | ns | SCL falling 전 |
| SDA 홀드 | 0 | - | ns | SCL rising 후 |
| START hold | 4.0 | - | us | Repeated START |
| STOP setup | 4.0 | - | us | STOP condition |

### 4.3 상태 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| DELAY_2MS | 100 | - | 2ms 지연 상수 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-I2C-001**: I2C START 조건이 정확히 생성되어야 한다
- **V-I2C-002**: I2C STOP 조건이 정확히 생성되어야 한다
- **V-I2C-003**: 슬레이브 주소가 정확히 전송되어야 한다
- **V-I2C-004**: 데이터가 정확히 전송되어야 한다
- **V-I2C-005**: ACK가 정확히 수신되어야 한다

### 5.2 타이밍 검증

- **V-I2C-006**: SCL 클록이 25kHz 타이밍을 만족해야 한다
- **V-I2C-007**: 모든 I2C 타이밍 파라미터를 준수해야 한다

### 5.3 엣지 케이스 검증

- **V-I2C-008**: 슬레이브가 응답 없으면(NACK) 타임아웃 처리가 되어야 한다
- **V-I2C-009**: 버스 충돌 시 정상적으로 복구되어야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 입력 신호

- s_clk_25mhz: 25MHz 시스템 클록
- gate_gpio_data: 16비트 게이트 데이터

### 6.2 파라미터

- SLAVE_ADDR: 8'hE8 (슬레이브 주소)

### 6.3 연관 모듈

- roic_gate_drv.sv: 게이트 드라이브 제어
- 외부 I2C 슬레이브 디바이스

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 I2C 전송 시나리오

**Given**: I2C 마스터가 IDLE 상태
**When**: busy=0로 시작됨
**Then**: START → WRITE_ADDR → WRITE_DATA → ACK → STOP 순서로 동작함
**And** 모든 데이터가 정확히 전송됨

### 7.2 ACK 수신 시나리오

**Given**: WRITE_ADDR 상태에서 주소 전송 완료
**When**: 슬레이브가 ACK(0)를 보냄
**Then**: ACK 상태에서 다음 상태(WRITE_DATA)로 진행함

### 7.3 NACK 수신 시나리오

**Given**: WRITE_ADDR 상태에서 주소 전송 완료
**When**: 슬레이브가 NACK(1)를 보냄
**Then**: ACK 상태에서 IDLE로 복귀함

### 7.4 다중 데이터 전송 시나리오

**Given**: write_counter가 0~3까지 순차적으로 증가
**When**: 각 데이터 전송이 완료됨
**Then**: 4개의 데이터가 순차적으로 전송됨

---

## 8. 제약사항 (Constraints)

### 8.1 I2C 모드 제약사항

- Standard mode (100kHz) 이하
- 7비트 주소 모드
- START/STOP 조건 지원

### 8.2 타이밍 제약사항

- SCL 최소 Low/High 시간 준수
- 셋업/홀드 시간 준수

### 8.3 리소스 제약사항

- 상태 머신: 레지스터 기반
- 카운터: 최소화

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: Communication Interface Team*
