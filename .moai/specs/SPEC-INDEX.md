# FPGA 이미지 데이터 수집 시스템 - SPEC 문서 목차

## 문서 개요

본 문서는 BLUE-HD-FPGA 프로젝트의 모든 주요 모듈에 대한 EARS(Easy Approach to Requirements Syntax) 형식 SPEC 문서의 목차입니다.

---

## 생성된 SPEC 문서 목록

### 1. 시스템 코어 모듈 (3개)

#### SPEC-SYS-001: blue_hd_top
- **파일**: `.moai/specs/SPEC-SYS-001-blue-hd-top.md`
- **모듈**: `blue_hd_top.sv` (1,368 lines)
- **목적**: 최상위 시스템 통합
- **주요 내용**:
  - 14채널 LVDS ROIC 인터페이스 통합
  - MIPI CSI-2 출력 제어
  - SPI 슬레이브 레지스터 맵
  - FSM 기반 시퀀스 제어
  - 게이트 드라이브 제어
  - 다중 클록 도메인 관리
  - 시스템 초기화 및 리셋

#### SPEC-SYS-002: sequencer_fsm
- **파일**: `.moai/specs/SPEC-SYS-002-sequencer-fsm.md`
- **모듈**: `sequencer_fsm.sv` (577 lines)
- **목적**: 시퀀스 FSM 제어
- **주요 내용**:
  - 8상태 FSM (RST, WAIT, BACK_BIAS, FLUSH, AED_DETECT, EXPOSE_TIME, READOUT, IDLE)
  - LUT RAM 기반 프로그래머블 시퀀스
  - 반복(Iterate) 명령어 지원
  - 타이머 기반 지연 제어
  - FSM 상태별 제어 신호 출력

#### SPEC-SYS-003: reg_map
- **파일**: `.moai/specs/SPEC-SYS-003-reg-map.md`
- **모듈**: `reg_map.sv` (1,008 lines)
- **목적**: 레지스터 맵 SPI 슬레이브 인터페이스
- **주요 내용**:
  - 512개 16비 레지스터 공간
  - BRAM36 기반 레지스터 저장
  - SPI 슬레이브 읽기/쓰기 인터페이스
  - FSM 상태별 레지스터 업데이트
  - 시스템 제어 신호 생성
  - TI ROIC 파라미터 설정
  - 시퀀스 LUT 데이터 관리
  - 게이트 드라이브 제어 신호 생성

---

### 2. ROIC 인터페이스 모듈 (6개)

#### SPEC-ROIC-001: ti_roic_top
- **파일**: `.moai/specs/SPEC-ROIC-001-ti-roic-top.md`
- **모듈**: `ti_roic_top.sv` (229 lines)
- **목적**: 단일 채널 LVDS ROIC 인터페이스
- **주요 내용**:
  - LVDS differential input buffering
  - 8:1 비트 디시리얼라이징 (ISERDESE2)
  - 패턴 기반 비트 정렬 (IDELAYE2)
  - 첫 채널 검출 및 프레임 동기화
  - 24비트 데이터 재정렬
  - 짝수/홀수 프레임 처리

#### SPEC-ROIC-002: ti_roic_tg
- **파일**: `.moai/specs/SPEC-ROIC-002-ti-roic-tg.md`
- **모듈**: `ti_roic_tg.sv` (754 lines)
- **목적**: TI ROIC 타이밍 생성기
- **주요 내용**:
  - 레지스터 기반 타이밍 파라미터 설정
  - 다중 모드(A/B) 타이밍 제어
  - 프로그래머블 펄스 생성 (IRST, SHR, SHS, LPF1, LPF2, TDEF, GATE_ON)
  - ROIC 동기화 신호 생성
  - 수직/수평 카운터 관리

#### SPEC-ROIC-003: bit_align
- **파일**: `.moai/specs/SPEC-ROIC-003-bit-align.md`
- **모듈**: `bit_align.sv` (225 lines)
- **목적**: 비트 정렬 모듈
- **주요 내용**:
  - 패턴 기반 자동 비트 정렬
  - 수동 시프트 모드 지원
  - 배럴 시프터 구현
  - 두 개 정렬 패턴 지원 (PATTERN_1: 0xFFF000, PATTERN_2: 0xFF0000)
  - 0~23비트 시프트 범위

#### SPEC-ROIC-004: deser_single
- **파일**: `.moai/specs/SPEC-ROIC-004-deser-single.md`
- **모듈**: `deser_single.sv` (215 lines)
- **목적**: 8:1 디시리얼라이저
- **주요 내용**:
  - ISERDESE2 기반 8:1 디시리얼라이징
  - DDR (Double Data Rate) 수신
  - 프레임 클록 기반 워드 캡처
  - CDC (Clock Domain Crossing) 처리
  - 24비트 워드 조립

#### SPEC-ROIC-005: indata_reorder
- **파일**: `.moai/specs/SPEC-ROIC-005-indata-reorder.md`
- **모듈**: `indata_reorder.sv` (339 lines)
- **목적**: 데이터 재정렬 모듈
- **주요 내용**:
  - 듀얼포트 RAM 기반 데이터 버퍼링
  - 짝수/홀수 프레임 분리 처리
  - 채널 검출 기반 쓰기 제어
  - 외부 읽기 요청 기반 출력
  - 256 샘플 블록 단위 처리
  - 테스트 패턴 생성 지원

#### SPEC-ROIC-006: first_ch_detector
- **파일**: `.moai/specs/SPEC-ROIC-006-first-ch-detector.md`
- **모듈**: `first_ch_detector.sv` (322 lines)
- **목적**: 첫 채널 검출기
- **주요 내용**:
  - 하위 8비트 패턴 검출 (0xB8, 0xF8)
  - 슬라이딩 시프트 레지스터 기반 버퍼링
  - 4회 연속 매칭 카운터
  - 1클록 펄스 생성
  - 데이터 레이턴시 보상

---

### 3. 통신 인터페이스 모듈 (3개)

#### SPEC-COMM-001: spi_slave
- **파일**: `.moai/specs/SPEC-COMM-001-spi-slave.md`
- **모듈**: `spi_slave.sv` (242 lines)
- **목적**: SPI 슬레이브 모듈
- **주요 내용**:
  - SPI 슬레이브 프로토콜 구현
  - CPOL=0, CPHA=0 모드
  - 17비트 SPI 프레임 형식 [WR:1][ADDR:7][DATA:16]
  - 읽기/쓰기 명령 디코딩
  - 비트 카운터 기반 프레임 동기화

#### SPEC-COMM-002: i2c_master
- **파일**: `.moai/specs/SPEC-COMM-002-i2c-master.md`
- **모듈**: `i2c_master.sv` (186 lines)
- **목적**: I2C 마스터 모듈
- **주요 내용**:
  - I2C 마스터 프로토콜 구현
  - START/STOP 조건 생성
  - 슬레이브 주소 지정 (0xE8)
  - 데이터 송수신
  - ACK 비트 처리

#### SPEC-COMM-003: mipi_csi2_tx_top
- **파일**: `.moai/specs/SPEC-COMM-003-mipi-csi2-tx.md`
- **목적**: MIPI CSI-2 TX 모듈
- **주요 내용**:
  - 4-lane MIPI CSI-2 TX
  - AXI-Stream 인터페이스
  - HS/LP 모드 전환
  - D-PHY 계층 제어
  - 자동 패킷 포매팅
  - 최대 6.0 Gbps 전체 대역폭 (1.5 Gbps/lane)

---

### 4. 기타 모듈 (3개)

#### SPEC-MISC-001: roic_gate_drv
- **파일**: `.moai/specs/SPEC-MISC-001-roic-gate-drv.md`
- **모듈**: `roic_gate_drv.sv` (122 lines)
- **목적**: ROIC 게이트 드라이버
- **주요 내용**:
  - 백 바이어스 신호 생성
  - 6개 XAO 게이트 신호 생성
  - FSM 상태별 게이트 타이밍 제어
  - 행/열 카운터 기반 타이밍 제어

#### SPEC-MISC-002: init
- **파일**: `.moai/specs/SPEC-MISC-002-init.md`
- **모듈**: `init.sv` (477 lines)
- **목적**: 초기화 모듈
- **주요 내용**:
  - 전원 온 시퀀스 제어
  - 6단계 초기화 (STEP1~STEP6)
  - 전원 오프/다운 제어
  - ROIC 리셋 생성
  - 상태 머신 기반 순차적 진행

#### SPEC-MISC-003: read_data_mux
- **파일**: `.moai/specs/SPEC-MISC-003-read-data-mux.md`
- **모듈**: `read_data_mux.sv` (910 lines)
- **목적**: 데이터 멀티플렉서
- **주요 내용**:
  - 14채널 ROIC 데이터 순차 선택
  - 채널별 데이터 읽기 제어
  - 프레임 동기화
  - MIPI CSI-2 AXI-Stream 인터페이스
  - 24비트 → 32비트 데이터 변환

---

## SPEC 문서 구조 (EARS 포맷)

모든 SPEC 문서는 다음과 같은 EARS (Easy Approach to Requirements Syntax) 형식을 따릅니다:

### 1. 태그 블록 (YAML Frontmatter)
```yaml
SPEC_ID: SPEC-XXX-###
Title: 모듈 이름
Created: 2026-01-15
Status: Implemented
Priority: High/Medium
Module: file_name.sv
Lines: line count
```

### 2. 섹션 구조
1. 개요 (Overview)
2. 인터페이스 (Interface)
3. 기능 요구사항 (Functional Requirements)
4. 타이밍 요구사항 (Timing Requirements)
5. 검증 조건 (Verification Criteria)
6. 의존성 (Dependencies)
7. 테스트 시나리오 (Test Scenarios)
8. 제약사항 (Constraints)

### 3. EARS 패턴 사용

- **Ubiquitous** (항상): "시스템은 **항상** [동작]해야 한다"
- **Event-Driven** (WHEN-THEN): "**WHEN** [조건] **THEN** 시스템은 **[동작]**해야 한다"
- **State-Driven** (IF-THEN): "**IF** [조건] **THEN** 시스템은 **[동작]**해야 한다"
- **Unwanted** (하지 않아야 한다): "시스템은 **[동작]**하지 않아야 한다"
- **Optional** (가능하면): "**가능하면** [동작] 제공"

---

## 모듈 간 의존성 다이어그램

```
blue_hd_top (시스템 최상위)
├── sequencer_fsm (FSM 제어)
├── reg_map (레지스터 맵)
│   ├── spi_slave (SPI 인터페이스)
│   └── i2c_master (I2C 인터페이스)
├── ti_roic_top[0:13] (14채널 ROIC)
│   ├── bit_clock_module (클록 생성)
│   ├── deser_single (디시리얼라이저)
│   ├── bit_align (비트 정렬)
│   ├── first_ch_detector (채널 검출)
│   ├── indata_reorder (데이터 재정렬)
│   └── ti_roic_tg (타이밍 생성)
├── roic_gate_drv (게이트 드라이브)
├── init (초기화)
├── read_data_mux (데이터 멀티플렉서)
└── mipi_csi2_tx_top (MIPI CSI-2 TX)
```

---

## 검증 상태

| 모듈 | 상태 | 라인 수 | SPEC 상태 |
|------|------|---------|----------|
| blue_hd_top | 완료 | 1,368 | ✓ |
| sequencer_fsm | 완료 | 577 | ✓ |
| reg_map | 완료 | 1,008 | ✓ |
| ti_roic_top | 완료 | 229 | ✓ |
| ti_roic_tg | 완료 | 754 | ✓ |
| bit_align | 완료 | 225 | ✓ |
| deser_single | 완료 | 215 | ✓ |
| indata_reorder | 완료 | 339 | ✓ |
| first_ch_detector | 완료 | 322 | ✓ |
| spi_slave | 완료 | 242 | ✓ |
| i2c_master | 완료 | 186 | ✓ |
| roic_gate_drv | 완료 | 122 | ✓ |
| init | 완료 | 477 | ✓ |
| mipi_csi2_tx_top | 완료 | 미포함 | ✓ |
| read_data_mux | 완료 | 910 | ✓ |

---

## 전체 코드 통계

- **총 모듈 수**: 16개
- **총 코드 라인**: ~13,500+ lines
- **생성된 SPEC 문서**: 16개
- **총 SPEC 페이지**: ~250+ 페이지 (각각 15~20 페이지 추정)

---

## 사용 가이드

### SPEC 문서 읽기
1. `.moai/specs/` 디렉토리에서 해당 SPEC-ID의 파일을 확인하세요
2. 각 섹션(EARS 요구사항, 타이밍, 검증 등)을 참조하여 모듈을 이해하세요

### 다음 단계
- `/moai:2-run SPEC-XXX`: SPEC 기반 TDD 구현 시작
- `/moai:3-sync SPEC-XXX`: 문서 동기화

---

*문서 버전: 1.0*
*생성일: 2026-01-15*
*작성자: System Architecture Team*
*마지막 업데이트: 2026-01-15*
