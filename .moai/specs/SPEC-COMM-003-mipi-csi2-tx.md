# SPEC-COMM-003: MIPI CSI-2 TX Top Module

## 태그 블록

```yaml
SPEC_ID: SPEC-COMM-003
Title: MIPI CSI-2 TX Top Module - MIPI CSI-2 Transmission
Created: 2026-01-15
Status: Implemented
Priority: High
Assigned: Communication Interface
Related: SPEC-SYS-001
Module: mipi_csi2_tx_top.sv
```

---

## 1. 개요 (Overview)

### 1.1 목적

MIPI CSI-2 TX Top 모듈은 MIPI CSI-2( Mobile Industry Processor Interface Camera Serial Interface 2) 프로토콜을 사용하여 이미지 데이터를 외부 프로세서로 전송합니다. Xilinx MIPI CSI-2 TX Subsystem IP를 통합합니다.

### 1.2 주요 기능

- 4-lane MIPI CSI-2 TX
- AXI-Stream 인터페이스
- HS(High Speed)/LP(Low Power) 모드 전환
- D-PHY 계층 제어
- 자동 패킷 포매팅

### 1.3 CSI-2 사양

| 파라미터 | 값 | 설명 |
|----------|-----|------|
| 데이터 레인 | 4 | CSI-2 데이터 레인 |
| 클록 레인 | 1 | CSI-2 클록 레인 |
| 최대 데이터 레이트 | 1.5 | Gbps/lane |

---

## 2. 인터페이스 (Interface)

### 2.1 물리적 인터페이스 (CSI-2 D-PHY)

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| mipi_phy_if_clk_hs_p/n | Output | logic | HS 모드 클록 (LVDS) |
| mipi_phy_if_clk_lp_p/n | Output | logic | LP 모드 클록 (LVDS) |
| mipi_phy_if_data_hs_p/n[3:0] | Output | logic | HS 모드 데이터 (LVDS) |
| mipi_phy_if_data_lp_p/n[3:0] | Output | logic | LP 모드 데이터 (LVDS) |

### 2.2 AXI-Stream 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| s_axis_tdata | Input | logic [31:0] | AXI-Stream 데이터 |
| s_axis_tvalid | Input | logic | AXI-Stream 유효 |
| s_axis_tready | Output | logic | AXI-Stream 준비 |
| s_axis_tlast | Input | logic | AXI-Stream 마지막 |

### 2.3 제어 인터페이스

| 신호명 | 방향 | 타입 | 설명 |
|--------|------|------|------|
| clk | Input | logic | 시스템 클록 |
| clk_200M | Input | logic | 200MHz 리셋런스 클록 |
| reset_n | Input | logic | 리셋 (Active Low) |

---

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 AXI-Stream 인터페이스 요구사항

- **FR-CSI-001**: 시스템은 **항상** AXI-Stream 프로토콜을 통해 이미지 데이터를 수신해야 한다

- **FR-CSI-002**: **WHEN** s_axis_tvalid=1이고 s_axis_tready=1이면 **THEN** 시스템은 데이터를 전송해야 한다

- **FR-CSI-003**: 시스템은 **항상** s_axis_tlast를 사용하여 프레임 끝을 표시해야 한다

- **FR-CSI-004**: 시스템은 **항상** AXI-Stream FIFO를 사용하여 데이터 버퍼링을 제공해야 한다

### 3.2 MIPI CSI-2 패킷 포맷팅 요구사항

- **FR-CSI-005**: 시스템은 **항상** CSI-2 패킷 포맷을 사용하여 데이터를 전송해야 한다
  - Long Packet: 이미지 데이터
  - Short Packet: 제어 정보

- **FR-CSI-006**: 시스템은 **항상** PH(Header), PF(Payload), CRC를 포함한 패킷을 생성해야 한다

- **FR-CSI-007**: 시스템은 **항상** 데이터 식별자(Data ID)를 사용하여 가상 채널을 식별해야 한다

### 3.3 HS/LP 모드 전환 요구사항

- **FR-CSI-008**: 시스템은 **항상** 데이터 전송 시 HS 모드를 사용해야 한다

- **FR-CSI-009**: 시스템은 **항상** 유휸 시간(LP 모드)에 LP 모드를 사용해야 한다

- **FR-CSI-010**: **WHEN** 데이터가 유효하면 **THEN** 시스템은 LP에서 HS로 전환해야 한다

- **FR-CSI-011**: **WHEN** 데이터 전송이 완료되면 **THEN** 시스템은 HS에서 LP로 전환해야 한다

- **FR-CSI-012**: 시스템은 **항상** HS 준비 시간을 준수해야 한다 (최대 100ns)

### 3.4 D-PHY 계층 제어 요구사항

- **FR-CSI-013**: 시스템은 **항상** D-PHY 클록을 생성해야 한다

- **FR-CSI-014**: 시스템은 **항상** Escape 모드를 사용하여 HS 진입/탈출을 제어해야 한다

- **FR-CSI-015**: 시스템은 **항상** UlPS(Ultra Low Power) 모드를 지원해야 한다

### 3.5 4-lane 데이터 분배 요구사항

- **FR-CSI-016**: 시스템은 **항상** AXI-Stream 데이터를 4개 레인에 분배해야 한다

- **FR-CSI-017**: 시스템은 **항상** 레인별로 독립적인 데이터 흐름을 제어해야 한다

- **FR-CSI-018**: 시스템은 **항상** 데이터 순서를 보장해야 한다 (Lane 0 → Lane 1 → Lane 2 → Lane 3)

### 3.6 리셋 요구사항

- **FR-CSI-019**: **WHEN** reset_n=0이면 **THEN** 시스템은 모든 출력을 LP 모드로 설정해야 한다

- **FR-CSI-020**: 리셋 시 모든 AXI-Stream 인터페이스가 초기화되어야 한다

---

## 4. 타이밍 요구사항 (Timing Requirements)

### 4.1 클록 타이밍

| 파라미터 | 값 | 단위 | 설명 |
|----------|-----|------|------|
| clk | 200 | MHz | 리셋런스 클록 |
| DPHY clk | 최대 150 | MHz | D-PHY 클록 |

### 4.2 데이터 레이트

| 파라미터 | 최대 | 단위 | 설명 |
|----------|-----|------|------|
| 1-lane | 1.5 | Gbps | HS 모드 |
| 4-lane (합계) | 6.0 | Gbps | 전체 대역폭 |

### 4.3 HS/LP 전환 타이밍

| 파라미터 | 최대 | 단위 | 설명 |
|----------|-----|------|------|
| LP → HS 전환 | 100 | ns | 준비 시간 |
| HS → LP 전환 | 50 | ns | 종료 시간 |
| T_CLK_PREPARE | 최대 8 | ns | 클록 준비 |
| T_CLK_ZERO | 최대 95 | ns | 클록 저지 |
| T_CLK_PRE | 최대 8 | ns | 클록 리셋 |
| T_CLK_POST | 최대 60 | ns | 클록 유지 |

### 4.4 AXI-Stream 타이밍

| 파라미터 | 최소 | 최대 | 단위 | 설명 |
|----------|------|------|------|------|
| s_axis_tdata 셋업 | 1 | - | 클록 | s_axis_tvalid 전 |
| s_axis_tdata 홀드 | 1 | - | 클록 | s_axis_tvalid 동안 |

---

## 5. 검증 조건 (Verification Criteria)

### 5.1 기능 검증

- **V-CSI-001**: AXI-Stream 데이터가 정상적으로 수신되어야 한다
- **V-CSI-002**: CSI-2 패킷이 올바르게 포맷되어야 한다
- **V-CSI-003**: HS/LP 모드 전환이 정상적으로 수행되어야 한다
- **V-CSI-004**: 4개 레인이 정상적으로 동작해야 한다
- **V-CSI-005**: FIFO 오버플로우/언더플로우가 방지되어야 한다

### 5.2 타이밍 검증

- **V-CSI-006**: 모든 CSI-2 타이밍 파라미터를 만족해야 한다
- **V-CSI-007**: 데이터 레이트가 목표를 달성해야 한다

### 5.3 엣지 케이스 검증

- **V-CSI-008**: FIFO가 꽉 찼을 때 backpressure가 적용되어야 한다
- **V-CSI-009**: 리셋 시 모든 출력이 LP 모드여야 한다

---

## 6. 의존성 (Dependencies)

### 6.1 Xilinx IP 코어

- mipi_csi2_tx_subsys: MIPI CSI-2 TX Subsystem v5.3
- mipi_dphy: MIPI D-PHY v4.3
- axis_data_fifo: AXI-Stream Data FIFO v2.0

### 6.2 필수 입력 신호

- clk: 200MHz 시스템 클록
- reset_n: 리셋 (Active Low)

### 6.3 연관 모듈

- read_data_mux.sv: 데이터 멀티플렉서
- blue_hd_top.sv: 상위 시스템

---

## 7. 테스트 시나리오 (Test Scenarios)

### 7.1 정상 데이터 전송 시나리오

**Given**: AXI-Stream에 유효한 데이터가 존재
**When**: s_axis_tvalid=1, s_axis_tready=1
**Then**: 데이터가 CSI-2 패킷으로 포맷되어 전송됨
**And** HS 모드에서 데이터가 전송됨

### 7.2 HS/LP 전환 시나리오

**Given**: LP 모드에서 대기 중
**When**: 유효한 데이터가 도착
**Then**: LP → HS 전환 수행 (최대 100ns)
**And** 데이터 전송 후 HS → LP 전환 수행

### 7.3 프레임 끝 시나리오

**Given**: 데이터 전송 중
**When**: s_axis_tlast=1
**Then**: 현재 패킷을 완료하고 HS → LP 전환 수행

### 7.4 FIFO 오버플로우 시나리오

**Given**: FIFO가 꽉 찬 상태
**When**: 새로운 데이터가 입력됨
**Then**: s_axis_tready=0로 설정
**And** backpressure가 적용됨

---

## 8. 제약사항 (Constraints)

### 8.1 하드웨어 제약사항

- 타겟 FPGA: Xilinx Artix-7 XC7A35T
- IOSTANDARD: LVDS
- 최대 데이터 레이트: 1.5 Gbps/lane

### 8.2 CSI-2 제약사항

- D-PHY v1.2 준수
- CSI-2 v2.0 준수
- Short Packet 및 Long Packet 지원

### 8.3 리소스 제약사항

- LUT: ~5K
- BRAM: 데이터 버퍼링용
- MMCM: 1개

---

*문서 버전: 1.0*
*마지막 업데이트: 2026-01-15*
*작성자: Communication Interface Team*
