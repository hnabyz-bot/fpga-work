# 기술 스택 문서

## 개요

본 프로젝트는 Xilinx FPGA 기반의 이미지 데이터 수집 시스템입니다. SystemVerilog를 주요 HDL 언어로 사용하며, Xilinx Vivado 2024.2 개발 환경에서 합성 및 구현되고, Questa Advanced Simulator 2024.3+ 환경에서 시뮬레이션됩니다.

---

## 하드웨어 플랫폼

### 타겟 FPGA

| 항목 | 사양 |
|------|------|
| 제조사 | Xilinx (AMD) |
| 패밀리 | Artix-7 |
| 디바이스 | xc7a35tfgg484 |
| 패키지 | FGG484 |
| 속도 등급 | -1 |

### 주요 리소스

| 리소스 | 수량 | 용도 |
|--------|------|------|
| Logic Cells | 33,280 | RTL 로직 |
| Block RAM | 50 x 36Kb | 데이터 버퍼, LUT |
| DSP Slices | 90 | 신호 처리 |
| MMCM | 5 | 클록 생성 |
| I/O Banks | 6 | 외부 인터페이스 |
| HP I/O | 100 | 고속 LVDS |

---

## 개발 도구

### 필수 도구

| 도구 | 버전 | 용도 |
|------|------|------|
| Xilinx Vivado | 2024.2 | 합성, 구현, 비트스트림 생성 |
| Questa Advanced Simulator | 2024.3+ | 시뮬레이션, 검증 |
| Xilinx Vitis | 2024.2 | 임베디드 개발 (선택사항) |

### 보조 도구

| 도구 | 버전 | 용도 |
|------|------|------|
| Python | 3.8+ | 유틸리티 스크립트 |
| Git | 2.x | 버전 관리 |
| VS Code | 최신 | 코드 편집 (권장) |
| Make | 3.81+ | 빌드 자동화 |

### 개발 환경 설정

```bash
# Vivado 환경 설정 (Linux)
source /opt/Xilinx/Vivado/2024.2/settings64.sh

# Questa 환경 설정 (시뮬레이션 전용)
cd BLUE-HD-FPGA/xdaq_top/simulation/questa
source setup_env.sh

# 프로젝트 열기
cd BLUE-HD-FPGA/xdaq_top/build
vivado xdaq_top.xpr
```

---

## 언어 및 표준

### HDL 언어

| 언어 | 표준 | 사용 비율 | 용도 |
|------|------|----------|------|
| SystemVerilog | IEEE 1800-2017 | 95% | 주요 RTL 설계 |
| Verilog | IEEE 1364-2005 | 4% | IP 인터페이스 |
| VHDL | IEEE 1076-2008 | 1% | 시뮬레이션 모델 |

### 코딩 스타일

- **명명 규칙**: snake_case (모듈, 신호)
- **들여쓰기**: 4 spaces
- **최대 줄 길이**: 120 characters
- **파일 확장자**: `.sv` (SystemVerilog), `.v` (Verilog), `.vhd` (VHDL)

---

## 클록 도메인

### 클록 생성 구조

```
50 MHz LVDS Input (sys_clkp/n)
    │
    └── MMCM (clk_ctrl)
        ├── clk_100m   (100 MHz) - 시스템 클록
        ├── clk_200m   (200 MHz) - 고속 처리
        ├── clk_20m    (20 MHz)  - 중간 속도
        ├── clk_5m     (5 MHz)   - SPI 클록
        └── clk_1m     (1 MHz)   - 저속 제어
```

### 클록 도메인 크로싱 (CDC)

| 소스 도메인 | 대상 도메인 | 처리 방식 |
|------------|------------|----------|
| DCLK (2.34 MHz) | clk_100m | 비동기 FIFO |
| clk_100m | MIPI TX | AXI-Stream FIFO |
| SPI CLK | clk_100m | 동기화 레지스터 |

---

## 주요 인터페이스

### 입력 인터페이스

#### LVDS 데이터 입력 (14채널)

| 신호 | 타입 | 설명 |
|------|------|------|
| DCLKP/N[0:13] | LVDS_25 | 데이터 클록 (2.34 MHz) |
| FCLKP/N[0:13] | LVDS_25 | 프레임 클록 |
| DOUTP/N[0:13] | LVDS_25 | 데이터 출력 |

#### SPI 슬레이브 (제어)

| 신호 | 방향 | 설명 |
|------|------|------|
| SSB | Input | 슬레이브 선택 (Active Low) |
| SCLK | Input | SPI 클록 |
| MOSI | Input | 마스터 출력 |
| MISO | Output | 마스터 입력 |

### 출력 인터페이스

#### MIPI CSI-2 (4-lane)

| 신호 | 타입 | 설명 |
|------|------|------|
| mipi_phy_clk_p/n | LVDS | 클록 레인 |
| mipi_phy_data_p/n[0:3] | LVDS | 데이터 레인 |

#### 게이트 드라이브

| 신호 | 개수 | 설명 |
|------|------|------|
| GF_XAO | 8 | XAO 출력 |
| GF_STV_LR | 8 | STV 좌/우 출력 |
| GF_CPV | 1 | CPV 제어 |
| GF_OE | 1 | 출력 활성화 |

---

## Xilinx IP 코어

### 사용 IP 목록 (최신)

| IP 이름 | 버전 | 용도 | 리소스 |
|---------|------|------|--------|
| Clocking Wizard | 6.0 | MMCM 클록 생성 | 1 MMCM |
| Block Memory Generator | 8.4 | 시퀀스 LUT, 데이터 RAM | 4+ BRAM |
| MIPI CSI-2 TX Subsystem | 5.3 | MIPI 출력 | ~5K LUT |
| MIPI D-PHY | 4.3 | PHY 계층 | I/O 리소스 |
| AXI4-Stream Data FIFO | 2.0 | 데이터 버퍼링 | 1 BRAM |
| AXI Crossbar | 2.1 | AXI 인터커넥트 | ~1K LUT |
| AXI Traffic Generator | 3.0 | MIPI 초기화 | ~500 LUT |

### 제거된 IP (2026-01-15)

| IP 이름 | 이유 |
|---------|------|
| ila_0 | 디버그 최적화로 제거 |
| ila_0_1 | 디버그 최적화로 제거 |
| ila_csi2 | 디버그 최적화로 제거 |
| ila_rd_tx | 디버그 최적화로 제거 |
| ila_top | 디버그 최적화로 제거 |

### IP 라이선스

- MIPI CSI-2 TX Subsystem: Xilinx 라이선스 필요
- MIPI D-PHY: Xilinx 라이선스 필요
- 기타 IP: 무료 (Vivado에 포함)

---

## 빌드 시스템

### TCL 빌드 스크립트

#### full_build.tcl

```tcl
# 전체 빌드 실행
# 1. 프로젝트 열기
# 2. 합성 실행
# 3. 구현 실행
# 4. 비트스트림 생성
```

#### post_script.tcl

```tcl
# 빌드 후 처리
# 1. 비트스트림 복사
# 2. 리포트 생성
# 3. 타이밍 분석
```

### 빌드 명령어

```bash
# GUI 모드
vivado xdaq_top.xpr

# 배치 모드 빌드
vivado -mode batch -source full_build.tcl

# 합성만 실행
vivado -mode batch -source synth_only.tcl
```

### 빌드 출력물

| 파일 | 위치 | 설명 |
|------|------|------|
| `*.bit` | output/ | 비트스트림 파일 |
| `*.bin` | output/ | 바이너리 비트스트림 |
| `*.mcs` | output/ | MCS 파일 (외부 메모리용) |
| `*.rpt` | reports/ | 타이밍/리소스 리포트 |
| `*.log` | build/ | 빌드 로그 |

---

## 시뮬레이션 시스템 (NEW)

### Questa 시뮬레이션 환경

#### 디렉토리 구조

```
simulation/questa/
├── Makefile               # 메인 빌드 스크립트
├── compile.do             # 컴파일 스크립트
├── simulate.do            # 시뮬레이션 실행 스크립트
├── wave.do                # 파형 뷰어 설정
├── README.md              # 상세 사용 가이드
├── setup_env.sh           # 환경 변수 설정
├── run_sim.sh             # 간단한 실행 스크립트
├── run_test.sh            # 개별 테스트 실행
└── run_regression.sh      # 회귀 테스트 자동화
```

#### Makefile 기반 빌드

```bash
# 환경 설정
source setup_env.sh

# 컴파일
make compile

# GUI 시뮬레이션
make sim

# 배치 시뮬레이션
make sim_batch

# 특정 테스트벤치 실행
make sim TB=sequencer_fsm_tb

# 회귀 테스트
make regression
```

#### 시뮬레이션 옵션

| 옵션 | 설명 |
|------|------|
| SIM_TIME | 시뮬레이션 시간 (기본값: 100us) |
| TB | 테스트벤치 이름 (기본값: test_bench) |
| SIM_OPTS | 시뮬레이션 옵션 (기본값: -t 1ps -voptargs="+acc") |

---

## 핵심 기술 결정

### 1. 14채널 LVDS 아키텍처

**결정 사항**: 각 채널 독립적 비트 정렬 및 디시리얼라이저

**근거**:
- 채널 간 스큐 보상
- 개별 채널 장애 격리
- 유연한 데이터 재정렬

**구현**:
- `bit_align.sv`: IDELAYE2 기반 비트 정렬
- `deser_single.sv`: ISERDESE2 기반 역직렬화
- `indata_reorder.sv`: 24비트 데이터 재정렬

### 2. MIPI CSI-2 출력 선택

**결정 사항**: 4-lane MIPI CSI-2 인터페이스

**근거**:
- 표준 카메라 인터페이스
- 높은 대역폭 (최대 6 Gbps)
- 다양한 프로세서 호환성

**구현**:
- Xilinx MIPI CSI-2 TX Subsystem IP 사용
- AXI4-Stream 데이터 인터페이스
- 자동 패킷 포매팅

### 3. 시퀀스 FSM 설계

**결정 사항**: LUT 기반 프로그래머블 시퀀스

**근거**:
- 런타임 시퀀스 변경
- 다양한 센서 모드 지원
- 유연한 타이밍 제어

**상태 머신**:
```
RESET -> WAIT -> BIAS -> FLUSH -> EXPOSE -> READOUT -> AED
```

### 4. 클록 도메인 전략

**결정 사항**: 다중 클록 도메인 분리

**근거**:
- 각 인터페이스 최적 주파수
- 전력 효율성
- 타이밍 클로저 용이

### 5. Questa 시뮬레이션 도입 (NEW)

**결정 사항**: Questa Advanced Simulator 채택

**근거**:
- 고급 디버깅 기능
- 빠른 컴파일 속도
- 우수한 파형 분석 도구
- SystemVerilog 1800-2017 완전 지원

---

## 개발 워크플로우

### 1. RTL 개발

```
1. 요구사항 분석
2. 아키텍처 설계
3. RTL 코딩 (SystemVerilog)
4. Questa 시뮬레이션 검증
5. 코드 리뷰
```

### 2. 합성 및 구현

```
1. 합성 (Synthesis)
2. 최적화 (Optimization)
3. 배치 (Placement)
4. 라우팅 (Routing)
5. 타이밍 분석
```

### 3. 검증

```
1. 기능 시뮬레이션 (Questa)
2. 회귀 테스트 자동화
3. 타이밍 시뮬레이션
4. 하드웨어 테스트
5. 시스템 통합 테스트
```

---

## 타이밍 제약조건

### 업데이트된 타이밍 제약 (2026-01-15)

#### 시스템 클록

| 클록 | 주파수 | 주기 | 설명 |
|------|--------|------|------|
| MCLK_50M | 50 MHz | 20.000 ns | 시스템 입력 클록 |
| clk_100m | 100 MHz | 10.000 ns | MMCM 생성 |
| clk_200m | 200 MHz | 5.000 ns | MMCM 생성 |

#### LVDS 클록 (14채널)

| 클록 | 주파수 | 주기 | 설명 |
|------|--------|------|------|
| DCLK_[0:13] | 2.34 MHz | 427.350 ns | TI ROIC 데이터 클록 |
| FCLK_[0:13] | 2.34 MHz | 427.350 ns | TI ROIC 프레임 클록 |

#### 타이밍 예외

```tcl
# 비동기 클록 도메인 간 경로
set_max_latency -from [get_cells DCLK*] -to [get_cells clk_100m*] 20
set_max_latency -from [get_cells clk_100m*] -to [get_cells DCLK*] 20

# 멀티사이클 경로
set_multicycle_path -setup 2 -from [get_cells spi_slave*] -to [get_cells reg_map*]
set_multicycle_path -hold 1 -from [get_cells spi_slave*] -to [get_cells reg_map*]
```

---

## 디버그 지원

### ILA 제거 및 대안 (2026-01-15)

이전 버전에서 사용된 ILA (Integrated Logic Analyzer) IP는 다음과 같이 제거되었습니다:

| 제거된 ILA | 대안 |
|-----------|------|
| ila_0 | Questa 시뮬레이션 파형 분석 |
| ila_0_1 | 외부 로직 분석기 (필요시) |
| ila_csi2 | MIPI 프로토콜 아날라이저 |
| ila_rd_tx | 시뮬레이션 검증 |
| ila_top | 시뮬레이션 검증 |

### 디버그 출력

| 신호 | 용도 |
|------|------|
| DEBUG_SIG[3:0] | 외부 디버그 핀 |
| STATE_LED1 | 상태 표시 LED |
| STATE_LED2 | 상태 표시 LED |

---

## 의존성 관리

### 외부 의존성

| 의존성 | 버전 | 용도 |
|--------|------|------|
| Xilinx Vivado | 2024.2 | 개발 환경 |
| Questa Simulator | 2024.3+ | 시뮬레이션 |
| Python | 3.8+ | 유틸리티 스크립트 |
| Make | 3.81+ | 빌드 자동화 |

### IP 의존성

모든 IP 코어는 Vivado 프로젝트에 포함되어 있으며, IP 카탈로그에서 관리됩니다.

---

## 성능 지표

### 타이밍 목표

| 클록 도메인 | 주파수 | 제약 |
|------------|--------|------|
| clk_100m | 100 MHz | WNS > 0 |
| clk_200m | 200 MHz | WNS > 0 |
| DCLK | 2.34 MHz | 인터페이스 타이밍 |
| MIPI TX | 변동 | D-PHY 사양 |

### 리소스 사용률

| 리소스 | 예상 사용률 |
|--------|------------|
| LUT | ~60% |
| FF | ~40% |
| BRAM | ~50% |
| DSP | ~10% |

---

## 참고 문서

### Xilinx 문서

- UG474: 7 Series FPGA CLB User Guide
- UG471: 7 Series FPGA SelectIO Resources
- UG953: Vivado Design Suite User Guide
- PG232: MIPI CSI-2 TX Subsystem Product Guide
- PG202: MIPI D-PHY Product Guide

### Siemens EDA 문서

- Questa Simulation User Guide
- SystemVerilog Language Reference

### 프로젝트 문서

- `BLUE-HD-FPGA/README.md`: 프로젝트 개요
- `BLUE-HD-FPGA/xdaq_top/simulation/questa/README.md`: 시뮬레이션 가이드
- 핀맵 문서: `100um_xc7a35tfgg484_Pinmap.xlsx`

---

*마지막 업데이트: 2026-01-15*
*버전: 2.0.0 (Questa 시뮬레이션 환경 추가, ILA IP 제거)*
