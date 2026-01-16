# CYAN-FPGA

BLUE FPGA 파생 개발 - Wired Only TI ROIC 적용 FPGA

## 프로젝트 개요

BLUE FPGA를 기반으로 TI ROIC를 적용한 파생 프로젝트입니다.

## 주요 특징

- **ROIC Vendor**: TI (Texas Instruments)
- **타겟 보드**: CYAN 보드
- **역할**: BLUE에서 파생 개발

## BLUE 대비 변경 사항

- ROIC 제조사 변경 (ADI → TI)
- 주요 모듈 변경:
  - `reg_map` - 레지스터 맵
  - `roic_gate_drv` - 게이트 드라이버
  - `sequence_fsm` - 시퀀스 FSM
  - `p_define` - 파라미터 정의
- AED 방식 변경

## 프로젝트 관계

- **BLUE_FPGA**: 기준 설계 (원본)
- **BLUE-HD-FPGA**: 본 프로젝트의 진화된 모듈 참조
  - 현재 상태: **기본 구현 완료** (2026-01-16 기준)
  - 16개 모듈에 대한 EARS 형식 SPEC 문서 작성 완료
  - Vivado 합성/구현 빌드 성공, 시뮬레이션 환경 구축 완료

## 개발 도구

- **Vivado**: `/home/holee/tools/xilinx/Vivado/2024.2/bin/vivado`
- **Questa**: `/home/holee/TOOLS/QuestaBase_2024.3/questa_base`

## 참고

- 상세 환경 정보: [environment.md](../environment.md)
- BLUE-HD-FPGA 진행 상황: [BLUE-HD-FPGA/README.md](../BLUE-HD-FPGA/README.md)
- SPEC 문서 목차: [`.moai/specs/SPEC-INDEX.md`](../.moai/specs/SPEC-INDEX.md)

## 라이선스

내부 프로젝트
