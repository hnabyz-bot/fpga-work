# 프로젝트 개요
- FPGA 설계 프로젝트
- tools : vivado , modelsim questa
 
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

# 검증 사항
- blue_hd_fpga 기본 구현을 위한 code 반영
- vivado 빌드 오류 없을때 까지 반복 검증
- blue_hd_fpga 전용 questa simulation 환경 셋팅

# tools 환경

- vivado : /home/holee/tools/xilinx/Vivado/2024.2/bin/vivado
- questa : /home/holee/TOOLS/QuestaBase_2024.3/questa_base
  . Questa simulation 실행 전 "source /home/holee/TOOLS/env.sh" 실행 필요
  . "You chose questa_base_2024.3" 메세지 확인
  . License 파일: /home/ednc/license.txt
  