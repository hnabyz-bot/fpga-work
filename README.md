# FPGA-Work

FPGA 설계 프로젝트 통합 저장소

## 프로젝트 개요

이미지 센서용 ROIC 데이터 수신 및 처리를 위한 FPGA 펌웨어 개발 프로젝트입니다.

## 프로젝트 구성

| 프로젝트 | ROIC Vendor | 보드 | 상태 |
|---------|-------------|------|------|
| [BLUE_FPGA](./BLUE_FPGA) | ADI | BLUE 보드 | 기준 설계 |
| [CYAN-FPGA](./CYAN-FPGA) | TI | CYAN 보드 | 파생 개발 |
| [BLUE-HD-FPGA](./BLUE-HD-FPGA) | TI | BLUE 보드 | **기본 구현 완료** |

## 현재 개발 진행

### BLUE-HD-FPGA (2026-01-16 기준)

**완료된 항목:**
- ✅ BLUE FPGA 보드 기반 TI ROIC 적용 완료
- ✅ 14채널 LVDS 데이터 수신 구현
- ✅ Vivado 합성/구현 빌드 성공
- ✅ Questa 시뮬레이션 환경 구축 완료
- ✅ 16개 모듈에 대한 EARS 형식 SPEC 문서 작성 완료

**진행 중:**
- 🔄 시뮬레이션 검증 및 테스트
- 🔄 추가 기능 구현 계획

**참조 프로젝트:**
- CYAN에서 진화된 모듈 활용 (reg_map, roic_gate_drv, sequence_fsm 등)

## 개발 도구

- **Vivado**: `/home/holee/tools/xilinx/Vivado/2024.2/bin/vivado`
- **Questa**: `/home/holee/TOOLS/QuestaBase_2024.3/questa_base`
  - 실행 전: `source /home/holee/TOOLS/env.sh`
  - 라이선스: `/home/ednc/license.txt`

## 상세 환경 정보

- 개발 환경 및 작업 계획: [environment.md](./environment.md)
- SPEC 문서 목차: [`.moai/specs/SPEC-INDEX.md`](./.moai/specs/SPEC-INDEX.md)

## 프로젝트 문서

### BLUE-HD-FPGA SPEC 문서 (16개 모듈)

**시스템 코어 모듈:**
- [SPEC-SYS-001](./.moai/specs/SPEC-SYS-001-blue-hd-top.md): blue_hd_top
- [SPEC-SYS-002](./.moai/specs/SPEC-SYS-002-sequencer-fsm.md): sequencer_fsm
- [SPEC-SYS-003](./.moai/specs/SPEC-SYS-003-reg-map.md): reg_map

**ROIC 인터페이스 모듈:**
- [SPEC-ROIC-001](./.moai/specs/SPEC-ROIC-001-ti-roic-top.md): ti_roic_top
- [SPEC-ROIC-002](./.moai/specs/SPEC-ROIC-002-ti-roic-tg.md): ti_roic_tg
- [SPEC-ROIC-003](./.moai/specs/SPEC-ROIC-003-bit-align.md): bit_align
- [SPEC-ROIC-004](./.moai/specs/SPEC-ROIC-004-deser-single.md): deser_single
- [SPEC-ROIC-005](./.moai/specs/SPEC-ROIC-005-indata-reorder.md): indata_reorder
- [SPEC-ROIC-006](./.moai/specs/SPEC-ROIC-006-first-ch-detector.md): first_ch_detector

**통신 인터페이스 모듈:**
- [SPEC-COMM-001](./.moai/specs/SPEC-COMM-001-spi-slave.md): spi_slave
- [SPEC-COMM-002](./.moai/specs/SPEC-COMM-002-i2c-master.md): i2c_master
- [SPEC-COMM-003](./.moai/specs/SPEC-COMM-003-mipi-csi2-tx.md): mipi_csi2_tx_top

**기타 모듈:**
- [SPEC-MISC-001](./.moai/specs/SPEC-MISC-001-roic-gate-drv.md): roic_gate_drv
- [SPEC-MISC-002](./.moai/specs/SPEC-MISC-002-init.md): init
- [SPEC-MISC-003](./.moai/specs/SPEC-MISC-003-read-data-mux.md): read_data_mux

## 라이선스

내부 프로젝트
