# SPEC-SYS-001: BLUE-HD Top Level System Integration

## 태그 블록

```yaml
SPEC_ID: SPEC-SYS-001
Title: BLUE-HD Top Level System Integration Module
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: System Architecture
Related: SPEC-SYS-002, SPEC-SYS-003, SPEC-ROIC-001
Module: blue_hd_top.sv
Lines: 1,368
```

---

## 1. 개요 (Overview)

### 1.1 목적

BLUE-HD Top Level 모듈은 FPGA 이미지 데이터 수집 시스템의 최상위 통합 모듈입니다. 14채널 TI ROIC LVDS 인터페이스, MIPI CSI-2 출력, 시퀀스 제어, 레지스터 맵, 게이트 드라이브 등 시스템의 모든 주요 기능을 통합하고 관리합니다.

### 1.2 주요 기능

- 다중 클록 도메인 관리 (50MHz → 100MHz, 200MHz, 20MHz, 5MHz, 1MHz)
- 14채널 LVDS ROIC 인터페이스 통합
- MIPI CSI-2 4-lane 출력 인터페이스
- SPI 슬레이브 기반 레지스터 맵 제어
- FSM 기반 시퀀스 제어 통합
- 8채널 XAO, 8채널 STV_LR 게이트 드라이브 제어
- 시스템 초기화 및 리셋 관리

### 1.3 타겟 디바이스

- FPGA: Xilinx Artix-7 XC7A35T-FGG484
- 속도 등급: -1
- 패키지: FGG484

---

## 2. 인터페이스 (Interface)

### 2.1 시스템 신호

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| nRST | Input | logic | 시스템 리셋 (Active Low) |
| MCLK_50M_p/n | Input | logic | 50MHz LVDS 시스템 클록 입력 |

### 2.2 MIPI CSI-2 출력 인터페이스 (4-lane)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| mipi_phy_if_clk_hs_p/n | Output | logic | HS 모드 클록 (LVDS) |
| mipi_phy_if_clk_lp_p/n | Output | logic | LP 모드 클록 (LVDS) |
| mipi_phy_if_data_hs_p/n[3:0] | Output | logic | HS 모드 데이터 (LVDS) |
| mipi_phy_if_data_lp_p/n[3:0] | Output | logic | LP 모드 데이터 (LVDS) |

### 2.3 SPI 슬레이브 제어 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| SCLK | Input | logic | SPI 클록 |
| SSB | Input | logic | 슬레이브 선택 (Active Low) |
| MOSI | Input | logic | 마스터 아웃 슬레이브 인 |
| MISO | Output | logic | 마스터 인 슬레이브 아웃 |

### 2.4 ROIC 제어 신호

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| ROIC_TP_SEL | Output | logic | 테스트 패턴 선택 |
| ROIC_SYNC | Output | logic | ROIC 동기화 신호 |
| ROIC_MCLK0 | Output | logic | ROIC 마스터 클록 0 |
| ROIC_SPI_SCK | Output | logic | ROIC SPI 클록 |
| ROIC_SPI_SDI | Output | logic | ROIC SPI 데이터 인 |
| ROIC_SPI_SDO | Input | logic | ROIC SPI 데이터 아웃 |
| ROIC_SPI_SEN_N | Output | logic | ROIC SPI 선택 (Active Low) |

### 2.5 LVDS ROIC 채널 인터페이스 (14채널)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| DCLKP/N[0:13] | Input | logic | 데이터 클록 (LVDS, 2.34MHz) |
| FCLKP/N[0:13] | Input | logic | 프레임 클록 (LVDS, 2.34MHz) |
| DOUTP/N[0:13] | Input | logic | 데이터 출력 (LVDS) |

### 2.6 게이트 드라이브 출력

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| GF_STV_L/R | Output | logic | STV 좌/우 출력 |
| GF_STV_LR1~8 | Output | logic | STV LR 개별 출력 (8채널) |
| GF_XAO_1~8 | Output | logic | XAO 개별 출력 (8채널) |
| GF_CPV | Output | logic | CPV 제어 |
| GF_OE | Output | logic | 출력 활성화 |

### 2.7 바이어스 및 전원 제어

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| ROIC_AVDD1/2 | Output | logic | 아날로그 전원 제어 |

### 2.8 트리거 및 핸드셰이크

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| PREP_REQ | Input | logic | 준비 요청 |
| EXP_REQ | Input | logic | 노출 요청 |
| PREP_ACK | Output | logic | 준비 승인 |
| EXP_ACK | Output | logic | 노출 승인 |

### 2.9 디버그 및 상태 신호

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| DEBUG_SIG[3:0] | Output | logic | 디버그 신호 |
| STATE_LED1/2 | Output | logic | 상태 표시 LED |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 시스템 초기화 요구사항

- **FR-SYS-001**: 시스템은 **항상** 전원 적용 후 리셋 해제 시 정상적인 초기화 시퀀스를 실행해야 한다
  - 전원 안정화 대기: 100ms (시뮬레이션: 1us)
  - 클록 PLL 락 대기: 최대 10ms
  - 모든 서브모듈 초기화 완료 확인

- **FR-SYS-002**: 시스템은 **항상** 클록 리셋(nRST) 신호에 동기적으로 모든 출력을 안전한 초기 상태로 설정해야 한다
  - 모든 출력 신호 Low로 설정
  - MIPI PHY 비활성화
  - ROIC 인터페이스 비활성화

### 3.2 클록 도메인 관리 요구사항

- **FR-SYS-003**: 시스템은 **항상** 50MHz LVDS 입력 클록을 안정적으로 받아들여야 한다
  - CLK_CTRL MMCM 통해 5개 출력 클록 생성
  - 100MHz: 시스템 클록
  - 200MHz: 고속 데이터 처리
  - 20MHz: FSM 클록
  - 5MHz: SPI 클록
  - 1MHz: 저속 제어

- **FR-SYS-004**: **WHEN** MMCM 클록이 락되지 않으면 **THEN** 시스템은 모든 데이터 경로를 리셋 상태로 유지해야 한다

### 3.3 LVDS ROIC 채널 인터페이스 요구사항

- **FR-SYS-005**: 시스템은 **항상** 14개 독립적인 ROIC 채널을 병렬로 처리해야 한다
  - 각 채널 독립적 비트 정렬
  - 각 채널 독립적 디시리얼라이징
  - 각 채널 독립적 프레임 동기화

- **FR-SYS-006**: **WHEN** ROIC 채널 데이터가 유효하면 **THEN** 시스템은 해당 채널 데이터를 재정렬 버퍼에 저장해야 한다

- **FR-SYS-007**: 시스템은 **항상** 2.34MHz DCLK/FCLK 클록과 동기하여 LVDS 데이터를 수신해야 한다

### 3.4 MIPI CSI-2 출력 요구사항

- **FR-SYS-008**: 시스템은 **항상** MIPI CSI-2 4-lane 인터페이스를 통해 정렬된 이미지 데이터를 출력해야 한다
  - 데이터 레인: 4개 (HS 모드 지원)
  - 클록 레인: 1개 (HS/LP 모드 지원)
  - AXI-Stream 인터페이스 사용

- **FR-SYS-009**: **WHEN** CSI-2 출력이 활성화되면 **THEN** 시스템은 LP 모드에서 HS 모드로 정상 전환해야 한다

### 3.5 SPI 슬레이브 레지스터 인터페이스 요구사항

- **FR-SYS-010**: 시스템은 **항상** SPI 슬레이브 모드로 외부 마스터와 통신해야 한다
  - 모드: CPOL=0, CPHA=0
  - 최대 클록: 5MHz
  - 프레임 형식: [WR:1][ADDR:7][DATA:16]

- **FR-SYS-011**: **WHEN** SPI 쓰기 명령을 수신하면 **THEN** 시스템은 해당 레지스터에 데이터를 저장해야 한다

- **FR-SYS-012**: **WHEN** SPI 읽기 명령을 수신하면 **THEN** 시스템은 해당 레지스터 데이터를 MISO를 통해 전송해야 한다

### 3.6 시퀀스 FSM 제어 요구사항

- **FR-SYS-013**: 시스템은 **항상** FSM 상태에 따라 ROIC 제어 시퀀스를 실행해야 한다
  - RESET → WAIT → BACK_BIAS → FLUSH → EXPOSE → READOUT → AED → IDLE

- **FR-SYS-014**: **WHEN** FSM 상태가 FLUSH이면 **THEN** 시스템은 ROIC 플러시 동작을 수행해야 한다

- **FR-SYS-015**: **WHEN** FSM 상태가 EXPOSE이면 **THEN** 시스템은 설정된 노출 시간 동안 대기해야 한다

### 3.7 게이트 드라이브 제어 요구사항

- **FR-SYS-016**: 시스템은 **항상** FSM 상태와 레지스터 설정에 따라 게이트 신호를 생성해야 한다
  - STV (Start Vertical): 수직 스캔 시작
  - CPV (Charge Pump Vertical): 수직 전하 전송
  - OE (Output Enable): 데이터 출력 타이밍
  - XAO: AED 모드 타이밍

- **FR-SYS-017**: **WHEN** FSM 상태가 READOUT이면 **THEN** 시스템은 READ 모드 게이트 타이밍을 사용해야 한다

- **FR-SYS-018**: **WHEN** FSM 상태가 AED이면 **THEN** 시스템은 AED 모드 게이트 타이밍을 사용해야 한다

### 3.8 데이터 멀티플렉싱 요구사항

- **FR-SYS-019**: 시스템은 **항상** 14채널 ROIC 데이터를 순차적으로 선택하여 MIPI CSI-2로 출력해야 한다

- **FR-SYS-020**: **WHEN** 채널 선택 신호가 변경되면 **THEN** 시스템은 해당 채널 데이터를 출력해야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 클록 도메인 | 주파수 | 주기 | 허용 오차 |
|-------------|--------|------|----------|
| MCLK_50M | 50 MHz | 20.000 ns | ±100 ppm |
| clk_100m | 100 MHz | 10.000 ns | ±50 ppm |
| clk_200m | 200 MHz | 5.000 ns | ±50 ppm |
| clk_20m | 20 MHz | 50.000 ns | ±100 ppm |
| clk_5m | 5 MHz | 200.000 ns | ±200 ppm |
| clk_1m | 1 MHz | 1.000 us | ±500 ppm |

### 4.2 LVDS 인터페이스 타이밍

| 파라미터 | 값 | 단위 |
|----------|-----|------|
| DCLK/FCLK 주파수 | 2.34 | MHz |
| DCLK/FCLK 주기 | 427.35 | ns |
| 채널 간 스크 허용 | ±10 | ns |

### 4.3 SPI 인터페이스 타이밍

| 파라미터 | 최소 | 최대 | 단위 |
|----------|------|------|------|
| SCLK 주파수 | - | 5 | MHz |
| SSB 셋업 시간 | 10 | - | ns |
| SSB 홀드 시간 | 10 | - | ns |
| MOSI 셋업 시간 | 10 | - | ns |
| MOSI 홀드 시간 | 10 | - | ns |

### 4.4 MIPI CSI-2 타이밍

| 파라미터 | 값 | 단위 |
|----------|-----|------|
| 데이터 레인 속도 | 최대 1.5 | Gbps/lane |
| HS 준비 시간 | 최대 100 | ns |
| LP에서 HS 전환 시간 | 최대 50 | ns |

### 4.5 시스템 초기화 타이밍

| 단계 | 시간 | 설명 |
|------|------|------|
| 전원 안정화 | 100 ms | 시뮬레이션: 1 us |
| PLL 띱 | 10 ms | 최대 |
| 모듈 초기화 | 10 ms | 총 초기화 시간 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-SYS-001**: 50MHz 입력 클록이 정상적으로 MMCM을 통해 5개 출력 클록으로 변환되어야 한다
- **V-SYS-002**: 14채널 LVDS 입력이 독립적으로 정렬 및 디시리얼라이징되어야 한다
- **V-SYS-003**: SPI 슬레이브 인터페이스가 레지스터 읽기/쓰기를 정상적으로 처리해야 한다
- **V-SYS-004**: FSM이 모든 상태를 정상적으로 전이해야 한다
- **V-SYS-005**: MIPI CSI-2 출력이 정상적인 패킷 형식으로 데이터를 출력해야 한다

### 5.2 타이밍 검증

- **V-SYS-006**: 모든 클록 도메인이 타이밍 제약조건을 만족해야 한다 (WNS > 0)
- **V-SYS-007**: CDC (Clock Domain Crossing) 경로가 적절하게 동기화되어야 한다
- **V-SYS-008**: SPI 인터페이스가 최대 5MHz 클록에서 정상 동작해야 한다

### 5.3 통합 검증

- **V-SYS-009**: 전체 시스템이 전원 온 시퀀스 이후 정상적으로 초기화되어야 한다
- **V-SYS-010**: ROIC 데이터 경로가 LVDS 입력부터 MIPI 출력까지 정상적으로 동작해야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 필수 Xilinx IP 코어

- clk_ctrl: Clocking Wizard v6.0 (MMCM)
- mipi_csi2_tx_subsys: MIPI CSI-2 TX Subsystem v5.3
- axis_data_fifo: AXI4-Stream Data FIFO v2.0

### 6.2 내부 서브모듈

- init.sv: 시스템 초기화 (477 lines)
- sequencer_fsm.sv: 시퀀스 FSM (577 lines)
- reg_map.sv: 레지스터 맵 (1,008 lines)
- ti_roic_top.sv: ROIC 채널 (229 lines) x 14
- mipi_csi2_tx_top.sv: MIPI CSI-2 TX
- spi_slave.sv: SPI 슬레이브 (242 lines)
- i2c_master.sv: I2C 마스터 (186 lines)
- roic_gate_drv.sv: 게이트 드라이브 (122 lines)
- read_data_mux.sv: 데이터 멀티플렉서 (910 lines)

### 6.3 외부 인터페이스

- TI ROIC: 14채널 LVDS 인터페이스
- MIPI CSI-2 Receiver: 4-lane CSI-2 호환 디바이스
- SPI Master: 외부 MCU/프로세서

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 동작 시나리오

**Given**: 시스템이 정상적으로 전원 공급되고 리셋이 해제됨
**When**: SPI를 통해 시스템 시작 명령이 전달됨
**Then**: FSM이 IDLE → WAIT → BACK_BIAS → FLUSH → EXPOSE → READOUT 순서로 상태 전이함
**And**: MIPI CSI-2 출력이 정상적으로 이미지 데이터를 전송함

### 7.2 채널 오류 시나리오

**Given**: 시스템이 READOUT 상태에서 동작 중
**When**: 특정 ROIC 채널에서 데이터 신호가 소실됨
**Then**: 해당 채널만 오류 플래그를 설정하고 나머지 채널은 정상 동작 계속함

### 7.3 SPI 통신 오류 시나리오

**Given**: 시스템이 정상 동작 중
**When**: SPI 인터페이스에서 잘못된 CRC 또는 타임아웃 발생
**Then**: SPI 트랜잭션을 무시하고 다음 명령 대기함

---

## 8. 제약사항 (Constraints)

### 8.1 하드웨어 제약사항

- FPGA 리소스: LUT ≤ 33,280 (60% 사용률 목표)
- Block RAM: 50개 x 36Kb (50% 사용률 목표)
- 전력 소비: 2W 이하

### 8.2 타이밍 제약사항

- 모든 클록 도메인: WNS > 0, WHS > 0
- CDC 경로: 최대 2 사이클 레이턴시
- 인터클락 도메인: 최소 2단계 플립플롭 동기화

### 8.3 설계 제약사항

- 모든 출력은 리셋 시 정의된 안전한 상태여야 함
- 모듈 간 인터페이스는 명확한 프로토콜을 따라야 함
- CDC 경로는 명시적으로 동기화되어야 함

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: System Architecture Team*
