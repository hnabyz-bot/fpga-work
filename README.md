# FPGA-Work

FPGA 설계 프로젝트 통합 저장소

## 프로젝트 개요

이미지 센서용 ROIC 데이터 수신 및 처리를 위한 FPGA 펌웨어 개발 프로젝트입니다.

## 프로젝트 구성

| 프로젝트 | ROIC Vendor | 보드 | 상태 |
|---------|-------------|------|------|
| [BLUE_FPGA](./BLUE_FPGA) | ADI | BLUE 보드 | 기준 설계 |
| [CYAN-FPGA](./CYAN-FPGA) | TI | CYAN 보드 | 파생 개발 |
| [BLUE-HD-FPGA](./BLUE-HD-FPGA) | TI | BLUE 보드 | **현재 개발 중** |

## 현재 개발 진행

### BLUE-HD-FPGA
- BLUE FPGA 보드 기반으로 TI ROIC 적용
- 14채널 LVDS 데이터 수신
- CYAN에서 진화된 모듈 활용 (reg_map, roic_gate_drv, sequence_fsm 등)

## 개발 도구

- **Vivado**: `/home/holee/tools/xilinx/Vivado/2024.2/bin/vivado`
- **Questa**: `/home/holee/TOOLS/QuestaBase_2024.3/questa_base`
  - 실행 전: `source /home/holee/TOOLS/env.sh`

## 상세 환경 정보

개발 환경 및 작업 계획은 [environment.md](./environment.md) 참조

## 라이선스

내부 프로젝트
