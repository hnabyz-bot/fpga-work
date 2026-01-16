# BLUE_FPGA

GEN2 과제를 위한 FPGA 소스 관리 - Blue Project FPGA

## 프로젝트 개요

이미지 센서 ROIC 데이터 수신을 위한 기준 FPGA 설계입니다.

## 주요 특징

- **ROIC Vendor**: ADI (Analog Devices)
- **타겟 보드**: BLUE FPGA 보드
- **역할**: 기준 설계 (Base Design)

## 프로젝트 관계

- 본 프로젝트를 기반으로 **CYAN-FPGA** 파생 개발
- **BLUE-HD-FPGA**는 본 보드를 사용하되 TI ROIC 적용
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
