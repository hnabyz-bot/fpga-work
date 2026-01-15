# 프로젝트 구조

## 전체 디렉터리 구조

```
fpga-work/
├── BLUE-HD-FPGA/              # 주력 프로젝트 (14채널 LVDS)
│   ├── README.md              # 프로젝트 문서
│   └── xdaq_top/              # Vivado 프로젝트 루트
│       ├── build/             # 빌드 결과물
│       ├── source/            # 소스 파일
│       ├── simulation/        # 시뮬레이션 파일
│       ├── output/            # 출력 파일
│       └── reports/           # 빌드 리포트
│
├── BLUE_FPGA/                 # 레거시 버전 (12채널)
│   ├── README.md
│   └── xdaq_top/
│       ├── build/
│       ├── source/
│       └── simulation/
│
├── CYAN-FPGA/                 # Wired-only 버전
│   ├── README.md
│   └── xdaq_top/
│       ├── build/
│       ├── source/
│       └── simulation/
│
├── .moai/                     # MoAI 프로젝트 설정
│   ├── config/                # 구성 파일
│   ├── project/               # 프로젝트 문서
│   └── specs/                 # 사양 문서
│
├── .claude/                   # Claude Code 설정
│   └── skills/                # 스킬 파일
│
├── CLAUDE.md                  # Alfred 실행 지침
└── README.md                  # 프로젝트 개요
```

---

## BLUE-HD-FPGA 상세 구조

### 소스 디렉터리 (source/)

```
source/
├── hdl/                       # HDL 소스 코드
│   ├── blue_hd_top.sv         # 최상위 모듈 (1,368줄)
│   ├── sequencer_fsm.sv       # 시퀀스 FSM (577줄)
│   ├── reg_map.sv             # 레지스터 맵 (1,008줄)
│   ├── p_define.sv            # 파라미터 정의 (513줄)
│   ├── read_data_mux.sv       # 데이터 멀티플렉서 (910줄)
│   ├── roic_gate_drv.sv       # 게이트 드라이브 (122줄)
│   ├── spi_slave.sv           # SPI 슬레이브 (242줄)
│   ├── i2c_master.sv          # I2C 마스터 (186줄)
│   ├── init.sv                # 초기화 로직 (477줄)
│   ├── dcdc_clk.sv            # DC-DC 클록 (37줄)
│   ├── fifo_1b.sv             # 1비트 FIFO (87줄)
│   ├── async_fifo_1b.sv       # 비동기 FIFO (117줄)
│   │
│   ├── ti-roic/               # TI ROIC 인터페이스 모듈
│   │   ├── ti_roic_top.sv     # ROIC 최상위 (229줄)
│   │   ├── ti_roic_tg.sv      # 타이밍 생성기 (754줄)
│   │   ├── bit_align.sv       # 비트 정렬 (225줄)
│   │   ├── bit_clock_module.sv # 비트 클록 (97줄)
│   │   ├── deser_single.sv    # 디시리얼라이저 (215줄)
│   │   ├── first_ch_detector.sv # 첫 채널 검출 (322줄)
│   │   ├── indata_reorder.sv  # 데이터 재정렬 (339줄)
│   │   ├── roic_spi.sv        # ROIC SPI (129줄)
│   │   └── tb_src/            # ROIC 테스트벤치
│   │
│   └── csi2/                  # MIPI CSI-2 모듈
│       ├── mipi_csi2_tx_top.sv  # CSI-2 최상위
│       ├── mipi_csi2_tx_bd.sv   # 블록 다이어그램
│       ├── coe/               # Coefficient 파일
│       └── ip/                # Xilinx IP 코어
│           ├── axis_data_fifo_0/
│           └── mipi_csi2_tx_subsys/
│
├── constrs/                   # 제약 파일
│   ├── blue_hd_top.xdc        # 핀 매핑 및 타이밍 제약
│   ├── blue_hd_top.xdc.backup # 백업
│   └── timing.xdc             # 추가 타이밍 제약
│
└── ip/                        # Xilinx IP 코어
    ├── clk_ctrl/              # 클록 제어 IP (Clocking Wizard)
    ├── seq_lut/               # 시퀀스 LUT (Block Memory)
    ├── indata_ram/            # 입력 데이터 RAM (Block Memory)
    ├── aed_data_bmem/         # AED 데이터 블록 메모리
    ├── roic_data_bmem/        # ROIC 데이터 블록 메모리
    └── mem_init.coe           # 메모리 초기화 파일
```

### 빌드 디렉터리 (build/)

```
build/
├── xdaq_top.xpr               # Vivado 프로젝트 파일
├── full_build.tcl             # 전체 빌드 스크립트
├── post_script.tcl            # 후처리 스크립트
├── full_build*.log            # 빌드 로그
├── full_build*.jou            # 빌드 저널
│
├── xdaq_top.cache/            # IP 캐시
│   └── ip/
│       └── 2024.2/            # Vivado 2024.2 IP 캐시
│
├── xdaq_top.hw/               # 하드웨어 파일
├── xdaq_top.srcs/             # 소스 세트
└── xdaq_top.runs/             # 실행 결과
    ├── synth_1/               # 합성 결과
    ├── impl_1/                # 구현 결과
    ├── clk_ctrl_synth_1/      # 클록 IP 합성
    ├── seq_lut_synth_1/       # 시퀀스 LUT 합성
    ├── mipi_csi2_tx_subsys_synth_1/  # MIPI IP 합성
    └── ...                    # 기타 IP 합성 결과
```

### 시뮬레이션 디렉터리 (simulation/)

```
simulation/
├── questa/                    # Questa 시뮬레이션 환경 (NEW)
│   ├── Makefile               # 메인 빌드 스크립트
│   ├── compile.do             # 컴파일 스크립트
│   ├── simulate.do            # 시뮬레이션 스크립트
│   ├── wave.do                # 파형 설정
│   ├── README.md              # 시뮬레이션 가이드
│   ├── setup_env.sh           # 환경 설정 스크립트
│   ├── run_sim.sh             # 간단한 실행 스크립트
│   ├── run_test.sh            # 개별 테스트 실행
│   └── run_regression.sh      # 회귀 테스트 실행
│
├── tb_src/                    # 테스트벤치 소스
│   ├── test_bench.sv          # 메인 테스트벤치
│   ├── sequencer_fsm_tb.sv    # FSM 단위 테스트
│   ├── tb_ctrl_fsm_sg.sv      # 제어 FSM 테스트
│   ├── tb_reg_map.sv          # 레지스터 맵 테스트
│   ├── tb_roic_gate_drv_compare.sv  # 게이트 드라이브 비교 테스트
│   ├── spi_master.sv          # SPI 마스터 모델 (테스트용)
│   └── roic_model.vhd         # ROIC 모델 (VHDL)
│
└── mipi_rx_sim/               # MIPI 수신 시뮬레이션
    ├── mipi_csi2_rx_wrapper.v # RX 래퍼
    └── mipi_csi2_rx/          # RX IP
```

---

## 모듈 계층 구조

### 최상위 모듈 (blue_hd_top.sv)

```
blue_hd_top
├── clk_ctrl                   # 클록 제어 (Xilinx MMCM)
├── init                       # 초기화 모듈
├── reg_map                    # 레지스터 맵 인터페이스
├── sequencer_fsm              # 시퀀스 상태 머신
├── roic_gate_drv              # 게이트 드라이브 제어
├── spi_slave                  # SPI 슬레이브 인터페이스
├── i2c_master                 # I2C 마스터 인터페이스
├── read_data_mux              # 데이터 멀티플렉서
├── dcdc_clk                   # DC-DC 클록 생성
│
├── ti_roic_top[0:13]          # 14채널 ROIC 인터페이스
│   ├── bit_clock_module       # 비트 클록 생성
│   ├── bit_align              # 비트 정렬
│   ├── deser_single           # 디시리얼라이저
│   ├── first_ch_detector      # 첫 채널 검출
│   ├── indata_reorder         # 데이터 재정렬
│   └── ti_roic_tg             # 타이밍 생성기
│
└── mipi_csi2_tx_top           # MIPI CSI-2 출력
    ├── mipi_csi2_tx_bd        # 블록 다이어그램
    ├── axis_data_fifo         # AXI-Stream FIFO
    └── mipi_csi2_tx_subsys    # MIPI 서브시스템
```

---

## 주요 파일 위치

### 소스 파일

| 파일 유형 | 경로 |
|----------|------|
| 최상위 모듈 | `BLUE-HD-FPGA/xdaq_top/source/hdl/blue_hd_top.sv` |
| 파라미터 정의 | `BLUE-HD-FPGA/xdaq_top/source/hdl/p_define.sv` |
| 시퀀서 FSM | `BLUE-HD-FPGA/xdaq_top/source/hdl/sequencer_fsm.sv` |
| 레지스터 맵 | `BLUE-HD-FPGA/xdaq_top/source/hdl/reg_map.sv` |
| ROIC 인터페이스 | `BLUE-HD-FPGA/xdaq_top/source/hdl/ti-roic/` |
| CSI-2 모듈 | `BLUE-HD-FPGA/xdaq_top/source/hdl/csi2/` |

### 제약 파일

| 파일 유형 | 경로 |
|----------|------|
| 핀 매핑/타이밍 | `BLUE-HD-FPGA/xdaq_top/source/constrs/blue_hd_top.xdc` |
| 추가 타이밍 | `BLUE-HD-FPGA/xdaq_top/source/constrs/timing.xdc` |

### 빌드 파일

| 파일 유형 | 경로 |
|----------|------|
| Vivado 프로젝트 | `BLUE-HD-FPGA/xdaq_top/build/xdaq_top.xpr` |
| 빌드 스크립트 | `BLUE-HD-FPGA/xdaq_top/build/full_build.tcl` |
| 후처리 스크립트 | `BLUE-HD-FPGA/xdaq_top/build/post_script.tcl` |

### 시뮬레이션 파일

| 파일 유형 | 경로 |
|----------|------|
| Makefile | `BLUE-HD-FPGA/xdaq_top/simulation/questa/Makefile` |
| 시뮬레이션 README | `BLUE-HD-FPGA/xdaq_top/simulation/questa/README.md` |
| 메인 테스트벤치 | `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/test_bench.sv` |
| FSM 테스트 | `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/sequencer_fsm_tb.sv` |
| 레지스터 맵 테스트 | `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/tb_reg_map.sv` |
| 제어 FSM 테스트 | `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/tb_ctrl_fsm_sg.sv` |
| 게이트 드라이브 테스트 | `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/tb_roic_gate_drv_compare.sv` |

---

## 코드 통계

### BLUE-HD-FPGA HDL 코드

| 카테고리 | 파일 수 | 총 줄 수 |
|---------|---------|----------|
| 메인 모듈 | 12 | 5,644 |
| TI ROIC 모듈 | 8 | 2,310 |
| CSI-2 모듈 | 2 | ~600 |
| 테스트벤치 | 10+ | 5,000+ |
| **총계** | **32+** | **13,500+** |

### Xilinx IP 코어

| IP 이름 | 버전 | 용도 |
|---------|------|------|
| clk_ctrl | 6.0 | MMCM 클록 생성 |
| seq_lut | 8.4 | 시퀀스 LUT 메모리 |
| indata_ram | 8.4 | 입력 데이터 RAM |
| aed_data_bmem | 8.4 | AED 데이터 블록 메모리 |
| roic_data_bmem | 8.4 | ROIC 데이터 블록 메모리 |
| axis_data_fifo | 2.0 | AXI-Stream FIFO |
| mipi_csi2_tx_subsys | 5.3 | MIPI CSI-2 TX |
| mipi_dphy | 4.3 | MIPI D-PHY |
| axi_crossbar | 2.1 | AXI 인터커넥트 |
| mipi_init_gen | - | MIPI 초기화 생성 |

---

## Questa 시뮬레이션 환경 (NEW)

### 디렉터리 구조

```
simulation/questa/
├── Makefile                   # 메인 빌드 스크립트
├── compile.do                 # Vivado/Quest 컴파일 스크립트
├── simulate.do                # 시뮬레이션 실행 스크립트
├── wave.do                    # 파형 뷰어 설정
├── README.md                  # 상세 사용 가이드
├── setup_env.sh               # 환경 변수 설정
├── run_sim.sh                 # 간단한 실행 스크립트
├── run_test.sh                # 개별 테스트 실행
└── run_regression.sh          # 회귀 테스트 자동화
```

### 사용 가능한 테스트벤치

| 테스트벤치 | 설명 |
|-----------|------|
| `test_bench` | 메인 시스템 테스트벤치 (전체 통합) |
| `sequencer_fsm_tb` | 시퀀서 FSM 단위 테스트 |
| `tb_reg_map` | 레지스터 맵 단위 테스트 |
| `tb_ctrl_fsm_sg` | 제어 FSM 단위 테스트 |
| `tb_roic_gate_drv_compare` | ROIC 게이트 드라이브 비교 테스트 |

### Makefile 타겟

| 타겟 | 설명 |
|------|------|
| `make help` | 사용 가능한 타겟 표시 |
| `make compile` | 모든 소스 컴파일 |
| `make sim` | GUI 모드 시뮬레이션 |
| `make sim_batch` | 배치 모드 시뮬레이션 |
| `make sim TB=<name>` | 특정 테스트벤치 실행 |
| `make wave` | 파형 뷰어 열기 |
| `make regression` | 전체 회귀 테스트 |
| `make regression_quick` | 빠른 회귀 테스트 |
| `make clean` | 작업 디렉토리 정리 |
| `make check_env` | 환경 설정 확인 |

---

## 프로젝트별 차이점

| 디렉터리 | BLUE-HD | BLUE | CYAN |
|----------|---------|------|------|
| `source/hdl/` | 14채널 구성 | 12채널 구성 | 12채널 구성 |
| `source/constrs/` | HD 보드 핀맵 | BLUE 보드 핀맵 | CYAN 보드 핀맵 |
| `simulation/questa/` | 있음 (NEW) | 없음 | 없음 |
| `simulation/tb_src/` | 전체 테스트벤치 | MIPI RX 시뮬레이션 | MIPI RX 시뮬레이션 |
| `build/` | 완전한 빌드 결과 | 프로젝트 파일만 | 프로젝트 파일만 |
| `output/` | 있음 | 없음 | 없음 |
| `reports/` | 있음 | 없음 | 없음 |

---

## 변경 이력

### 2026-01-15

- **추가**: Questa Advanced Simulator 환경 (simulation/questa/)
- **추가**: 완전한 테스트벤치 프레임워크 (10개 이상)
- **추가**: 자동화된 회귀 테스트 스크립트
- **삭제**: ILA 디버그 IP (ila_0, ila_0_1, ila_csi2, ila_rd_tx, ila_top)
- **업데이트**: 타이밍 제약조건 (blue_hd_top.xdc)
- **업데이트**: 빌드 시스템 최적화

### 2026-01-14

- 초기 프로젝트 문서 생성

---

*마지막 업데이트: 2026-01-15*
*버전: 2.0.0 (Questa 시뮬레이션 환경 추가)*
