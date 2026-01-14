# BLUE-HD-FPGA

BLUE-HD 보드 기반 TI ROIC 데이터 수신 FPGA 프로젝트

## 프로젝트 개요

본 프로젝트는 이미지 데이터 수신 시스템의 FPGA 펌웨어입니다. BLUE-HD 보드를 타겟으로 14채널 LVDS 인터페이스를 통해 ROIC 데이터를 수신하고 처리합니다.

### 주요 기능

- **14채널 LVDS 데이터 수신**: TI ROIC로부터 고속 LVDS 인터페이스를 통한 데이터 수신
- **비트 정렬 및 직렬화 해제**: 각 채널별 독립적인 비트 정렬 및 디시리얼라이저
- **MIPI CSI-2 출력**: 수신된 이미지 데이터를 MIPI CSI-2 인터페이스로 출력
- **SPI 제어 인터페이스**: ROIC 설정 및 제어를 위한 SPI 마스터
- **시퀀스 FSM**: 노출, 리드아웃, 플러시 등 이미지 획득 시퀀스 제어
- **게이트 드라이브 제어**: 8채널 XAO 및 8채널 STV_LR 신호 생성

## 하드웨어 사양

### 타겟 보드
- **보드 명**: BLUE-HD
- **FPGA**: Xilinx Artix-7 xc7a35tfgg484
- **시스템 클록**: 50 MHz LVDS 입력

### 주요 인터페이스

#### ROIC LVDS 채널 (14채널)
- **데이터 클록**: DCLKP/N_0 ~ DCLKP/N_13 (2.34 MHz)
- **프레임 클록**: FCLKP/N_0 ~ FCLKP/N_13
- **데이터**: DOUTP/N_0 ~ DOUTP/N_13
- **표준**: LVDS_25

#### SPI 인터페이스
- **신호**: ROIC_SPI_SCK, ROIC_SPI_SDI, ROIC_SPI_SDO, ROIC_SPI_SEN_N
- **용도**: ROIC 레지스터 설정 및 제어

#### Gate Drive
- **XAO 신호**: GF_XAO_1 ~ GF_XAO_8 (8채널)
- **STV 신호**: GF_STV_L, GF_STV_R, GF_STV_LR1 ~ GF_STV_LR8
- **제어 신호**: GF_CPV, GF_OE

#### MIPI CSI-2 출력
- **레인**: 4-lane MIPI CSI-2
- **클록**: 고속 HS 및 저전력 LP 모드 지원

#### 기타 인터페이스
- **CPU SPI**: SSB, SCLK, MOSI, MISO (제어 인터페이스)
- **I2C**: scl_out, sda (외부 디바이스 제어)
- **트리거**: PREP_REQ/ACK, EXP_REQ/ACK
- **LED**: STATE_LED1, STATE_LED2
- **디버그**: DEBUG_SiG[3:0]

## 프로젝트 구조

```
BLUE-HD-FPGA/
├── README.md
├── xdaq_top/
│   ├── build/
│   │   └── xdaq_top.xpr              # Vivado 프로젝트 파일
│   ├── source/
│   │   ├── hdl/
│   │   │   ├── blue_hd_top.sv        # 최상위 모듈
│   │   │   ├── sequencer_fsm.sv      # 시퀀스 FSM
│   │   │   ├── reg_map.sv            # 레지스터 맵 (SPI 인터페이스)
│   │   │   ├── p_define.sv           # 파라미터 및 매크로 정의
│   │   │   ├── roic_gate_drv.sv      # 게이트 드라이브 제어
│   │   │   ├── spi_slave.sv          # SPI 슬레이브
│   │   │   ├── i2c_master.sv         # I2C 마스터
│   │   │   ├── init.sv               # 초기화 로직
│   │   │   ├── read_data_mux.sv      # 데이터 멀티플렉서
│   │   │   ├── fifo_1b.sv            # 1비트 FIFO (미사용)
│   │   │   ├── async_fifo_1b.sv      # 비동기 1비트 FIFO (미사용)
│   │   │   ├── dcdc_clk.sv           # DC-DC 클록 생성
│   │   │   ├── csi2/                 # MIPI CSI-2 모듈
│   │   │   │   ├── mipi_csi2_tx_top.sv
│   │   │   │   ├── mipi_csi2_tx_bd.sv
│   │   │   │   ├── coe/              # Coefficient 파일
│   │   │   │   └── ip/               # IP 코어
│   │   │   └── ti-roic/              # TI ROIC 인터페이스
│   │   │       ├── ti_roic_top.sv    # ROIC 최상위
│   │   │       ├── ti_roic_tg.sv     # ROIC 타이밍 생성기
│   │   │       ├── bit_align.sv      # 비트 정렬
│   │   │       ├── bit_clock_module.sv # 비트 클록 생성
│   │   │       ├── deser_single.sv   # 디시리얼라이저
│   │   │       ├── first_ch_detector.sv # 첫 채널 검출
│   │   │       ├── indata_reorder.sv # 데이터 재정렬
│   │   │       ├── roic_spi.sv       # ROIC SPI 제어
│   │   │       └── tb_src/           # 테스트벤치
│   │   ├── constrs/
│   │   │   ├── blue_hd_top.xdc       # 핀 맵핑 및 타이밍 제약
│   │   │   ├── timing.xdc            # 추가 타이밍 제약
│   │   │   └── xdc_gen.py            # XDC 생성 스크립트
│   │   └── ip/                       # Xilinx IP 코어
│   │       ├── aed_data_bmem/        # AED 데이터 블록 메모리 (미사용)
│   │       ├── clk_ctrl/             # 클록 제어
│   │       ├── ila_*/                # Integrated Logic Analyzer (미사용)
│   │       ├── indata_ram/           # 입력 데이터 RAM (미사용)
│   │       ├── roic_data_bmem/       # ROIC 데이터 블록 메모리 (미사용)
│   │       └── seq_lut/              # 시퀀스 LUT
│   ├── simulation/
│   │   ├── mipi_rx_sim/              # MIPI 수신 시뮬레이션
│   │   └── tb_src/                   # 테스트벤치
│   │       ├── test_bench.sv
│   │       ├── sequencer_fsm_tb.sv
│   │       ├── tb_ctrl_fsm_sg.sv
│   │       └── 기타 테스트벤치
│   ├── output/                       # 빌드 출력
│   ├── reports/                      # 빌드 리포트
│   └── doc/                          # 문서
├── rules/                            # AI 어시스턴트 규칙
│   ├── agentic_rules_claude.md
│   ├── agentic_rules_gemini.md
│   ├── agentic_rules_notebooklm.md
│   └── guidelines/
│       └── ai_assistant_checklist.md
```

## 주요 모듈 설명

### blue_hd_top.sv
최상위 모듈로 모든 서브모듈을 인스턴스화하고 신호를 라우팅합니다.
- 14개의 `ti_roic_top` 인스턴스 생성 (각 LVDS 채널당 1개)
- 클록 생성 (100MHz, 200MHz, 20MHz, 5MHz, 1MHz)
- 시퀀스 FSM 제어
- MIPI CSI-2 출력 처리

### ti_roic_top.sv
개별 LVDS 채널 데이터 수신 모듈
- 비트 정렬 (bit alignment)
- LVDS 디시리얼라이저
- 프레임 클록 동기화
- 24비트 데이터 재정렬

### sequencer_fsm.sv
이미지 획득 시퀀스 제어
- 리셋, 대기, 바이어스, 플러시, 노출, 리드아웃, AED 모드
- LUT 기반 시퀀스 프로그래밍
- 상태 머신 제어

### reg_map.sv
SPI 슬레이브 인터페이스를 통한 레지스터 맵
- ROIC 제어 레지스터
- 시퀀스 설정
- 상태 읽기

## 빌드 방법

### Vivado 프로젝트 열기
```bash
cd xdaq_top/build
vivado xdaq_top.xpr
```

### 합성 및 구현
1. Vivado에서 프로젝트 열기
2. "Run Synthesis" 실행
3. "Run Implementation" 실행
4. "Generate Bitstream" 실행

### 타이밍 제약 확인
- 모든 14개 DCLK 채널에 대한 타이밍 제약 적용 필요
- CDC(Clock Domain Crossing) 제약 확인

## 변경 이력

### v1.0 (2026-01-12) - Cyan Board 변환
- 12채널에서 14채널 LVDS로 확장
- 배열 포트를 개별 신호로 변환
- Cyan 보드 핀 맵핑 적용
- GF_XAO 8채널, GF_STV_LR 8채널로 확장
- ROIC_SPI 단일 신호로 변경

## TODO

### 하드웨어 검증
- [ ] GF_STV_LR1~8 실제 로직 연결 (현재 1'bz)
- [ ] GF_XAO_7, GF_XAO_8 매핑 검증
- [ ] 제거된 신호(ROIC_MCLK1, SWITCH_SYNC 등) 필요 여부 확인

### 기능 개선
- [ ] 14채널 데이터 병합 로직 최적화
- [ ] 타이밍 제약 세부 조정
- [ ] 시뮬레이션 테스트벤치 업데이트

## 참고 문서

- `100um_xc7a35tfgg484_Pinmap.xlsx`: BLUE-HD 보드 핀맵

## 라이선스

내부 프로젝트

## 연락처

Drake Lee - drake.lee@company.com