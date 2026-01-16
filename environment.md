# 프로젝트 개요
- FPGA 설계 프로젝트
- tools : Vivado, ModelSim Questa

# 프로젝트 구성
- blue_fpga 를 시작으로 개발 진행
  . ROIC vendor 는 ADI

- cyan-fpga 를 파생 개발
  . ROIC TI 사
  . 일부 모듈 변경 (reg_map, roic_gate_drv, sequence_fsm, p_define 등등)
  . AED 방식 변경

- blue_hd_fpga
  . blue fpga 보드를 사용
  . ROIC TI 로 변경
  . ROIC 14EA 사용

# 개발 진행 계획
- blue_hd_fpga 개발 진행
- blue fpga 보드를 사용함으로 기본 구조는 blue 와 유사함
- TI ROIC 사용에 따른 cyan 구조 참고
- cyan 에서 진화된 모듈들 사용
  . cyan 에 미반영된 blue reg_map 에 적용된 address 관련 내용 추가
- 기본 검증 완료후 추가 기능 구현 진행

# 검증 상태 (최종 업데이트: 2026-01-16)

## 완료된 항목
- [x] blue_hd_fpga 기본 구현 완료
- [x] Vivado 빌드 성공 (합성/구현 완료)
- [x] Questa 시뮬레이션 스크립트 검증 완료
- [x] 16개 모듈에 대한 SPEC 문서 작성 완료

## 진행 가능 상태
- Vivado 프로젝트: BLUE-HD-FPGA/xdaq_top/build/xdaq_top.xpr
- 합성 완료: BLUE-HD-FPGA/xdaq_top/build/xdaq_top.runs/synth_1/blue_hd_top.dcp
- 시뮬레이션 환경 구축 완료

# 시뮬레이션 환경

## 경로
- 시뮬레이션 파일 위치: `BLUE-HD-FPGA/xdaq_top/simulation/tb_src/`
- 주요 파일:
  - init_tb.sv: 초기화 테스트벤치
  - compile_xsim.sh: XSim 컴파일 스크립트
  - run_xsim.sh: XSim 실행 스크립트
  - sequencer_fsm_tb.sv: 시퀀서 FSM 테스트벤치
  - roic_model.vhd: ROIC 모델
  - test_bench.sv: 메인 테스트벤치

## 실행 방법

### XSim (Xilinx Simulator) 실행
```bash
cd BLUE-HD-FPGA/xdaq_top/simulation/tb_src
./compile_xsim.sh  # 컴파일
./run_xsim.sh      # 시뮬레이션 실행
```

### Questa Simulator 실행
```bash
# 환경 설정 먼저 실행
source /home/holee/TOOLS/env.sh
# "You chose questa_base_2024.3" 메세지 확인

# Questa GUI 실행
cd BLUE-HD-FPGA/xdaq_top/simulation/questa
vsim -do run.tcl
```

# tools 환경

- vivado : /home/holee/tools/xilinx/Vivado/2024.2/bin/vivado
- questa : /home/holee/TOOLS/QuestaBase_2024.3/questa_base
  . Questa simulation 실행 전 "source /home/holee/TOOLS/env.sh" 실행 필요
  . "You chose questa_base_2024.3" 메세지 확인
  . License 파일: /home/ednc/license.txt

# 프로젝트 문서

- SPEC 문서 위치: `.moai/specs/`
- SPEC 목차: `.moai/specs/SPEC-INDEX.md`
- 전체 16개 모듈에 대한 EARS 형식 SPEC 문서 완료

# 프로젝트 빌드 명령어

## Vivado 프로젝트 열기
```bash
cd BLUE-HD-FPGA/xdaq_top
vivado build/xdaq_top.xpr
```

## 합성 실행 (Vivado Tcl Console)
```tcl
launch_runs synth_1 -jobs 8
wait_on_run synth_1
```

## 구현 실행
```tcl
launch_runs impl_1 -jobs 8
wait_on_run impl_1
```

## 비트스트림 생성
```tcl
open_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
```

# 참고 사항

## Git 관리
- 빌드 아티팩트는 .gitignore에 추가됨
- 주요 변경사항:
  - build/xdaq_top.runs/impl_1/* (구현 결과물)
  - build/xdaq_top.runs/synth_1/* (합석 결과물)
  - *.log, *.jou, *.pb (Vivado 임시 파일)

## 브랜치 정보
- 메인 브랜치: main
- 현재 작업 브랜치: feature/blue-hd-enhancement
