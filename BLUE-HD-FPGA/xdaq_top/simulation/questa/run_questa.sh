#!/usr/bin/env bash
# Questa GUI 실행 스크립트
# Vivado GUI에서 이미 확인된 설정 사용

cd "$(dirname "$0")"

# 환경 설정 로드
if [ -f setup_env.sh ]; then
    source setup_env.sh
elif [ -f ../../../build/xdaq_top.sim/sim_1/behav/questa/setup_env.sh ]; then
    source ../../../build/xdaq_top.sim/sim_1/behav/questa/setup_env.sh
fi

# Vivado 컴파일된 라이브러리 경로
VIVADO_LIB="../../../build/xdaq_top.sim/sim_1/behav/questa/questa_lib/msim"

# Xilinx 전역 라이브러리
GLOBAL_LIB="/home/holee/compile_simlib/questa"

# Vivado modelsim.ini 사용 (현재 디렉토리에 복사됨)
VIVADO_MODELSIM_INI="modelsim.ini"

# 라이브러리 옵션 (Vivado test_bench_elaborate.do에서 추출)
LIB_OPTS="-L xil_defaultlib -L xilinx_vip -L xpm \
    -L dist_mem_gen_v8_0_16 -L blk_mem_gen_v8_4_10 -L lib_bmg_v1_0_19 -L lib_cdc_v1_0_3 \
    -L axi_traffic_gen_v3_0_20 -L axis_infrastructure_v1_1_1 -L axis_data_fifo_v2_0_16 \
    -L mipi_csi2_tx_ctrl_v1_0_6 -L mipi_dphy_v4_3_14 -L generic_baseblocks_v2_1_2 \
    -L axi_infrastructure_v1_1_0 -L axi_register_slice_v2_1_34 -L fifo_generator_v13_2_12 \
    -L axi_data_fifo_v2_1_34 -L axi_crossbar_v2_1_36 -L proc_sys_reset_v5_0_16 \
    -L mipi_csi2_rx_ctrl_v1_0_12 -L axis_register_slice_v1_1_34 -L axis_dwidth_converter_v1_1_33 \
    -L axis_switch_v1_1_34 -L vfb_v1_0_28 -L xlconstant_v1_1_9 -L smartconnect_v1_0 \
    -L axi_vip_v1_1_20 -L xlconcat_v2_1_6 -L unisims_ver -L unimacro_ver -L secureip"

# GUI 실행
vsim -t 1ps -voptargs="+acc" $LIB_OPTS -modelsimini "$VIVADO_MODELSIM_INI" \
    xil_defaultlib.test_bench xil_defaultlib.glbl
