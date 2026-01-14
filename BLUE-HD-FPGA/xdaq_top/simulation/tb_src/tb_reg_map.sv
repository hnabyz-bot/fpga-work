`timescale 1ns/1ps

`include "p_define.sv"

module tb_reg_map;

    // Parameters
    localparam CLK_PERIOD_SPI = (10**3)/5;	// time unit : ns
    localparam CLK_PERIOD_50M = (10**3)/50;	// time unit : ns
    localparam CLK_PERIOD_EIM = 15.15ns; // 66MHz
    localparam CLK_PERIOD_FSM = 40ns;    // 25MHz
    localparam CLK_PERIOD_SYS = 10ns;    // 100MHz
    localparam RESET_TIME = 100ns;

    // Inputs
    logic m_sclk_in;
    logic MCLK_50M_p;

    reg eim_clk;
    reg eim_rst;
    reg fsm_clk;
    reg rst;
    reg sys_clk;
    reg sys_rst;
    reg prep_req;
    reg exp_req;
    reg [15:0] row_cnt;
    reg [15:0] col_cnt;
    reg row_end;
    reg fsm_rst_index;
    reg fsm_init_index;
    reg fsm_back_bias_index;
    reg fsm_flush_index;
    reg fsm_aed_read_index;
    reg fsm_exp_index;
    reg fsm_read_index;
    reg [15:0] gate_gpio_data_in; // Renamed to avoid conflict with output
    reg ready_to_get_image;
    reg valid_aed_read_skip;
    reg aed_ready_done;
    reg panel_stable_exist;
    reg exp_read_exist;
    reg ack_tx_end;
    reg up_roic_reg;
    reg [15:0] roic_temperature;
    reg [63:0] roic_reg_in_a;
    reg [63:0] roic_reg_in_b;
    reg [15:0] l_roic_temperature;
    reg [63:0] l_roic_reg_in_a;
    reg [63:0] l_roic_reg_in_b;

    reg s_addr_dv;
    reg s_rw_out;
    reg [15:0] s_reg_addr;
    reg [15:0] s_reg_data;
    reg s_reg_read_index;
    reg s_reg_addr_index;
    reg s_reg_data_index;

    reg exist_get_image;

    // Outputs
    wire [15:0] reg_read_out;
    wire read_data_en;
    wire en_pwr_dwn;
    wire en_pwr_off;
    wire system_rst_out; // Renamed to avoid conflict with input reg
    wire reset_fsm;
    wire org_reset_fsm;
    wire dummy_get_image;
    wire burst_get_image;
    wire get_dark;
    wire get_bright;
    wire cmd_get_bright;
    wire en_aed;
    wire [15:0] aed_th;
    wire [15:0] nega_aed_th;
    wire [15:0] posi_aed_th;
    wire [15:0] sel_aed_roic;
    wire [15:0] num_trigger;
    wire [15:0] sel_aed_test_roic;
    wire [15:0] ready_aed_read;
    wire [15:0] aed_dark_delay;
    wire en_back_bias;
    wire en_flush;
    wire en_panel_stable;
    wire [23:0] cycle_width;
    wire [15:0] mux_image_height;
    wire [15:0] dsp_image_height;
    wire [15:0] aed_read_image_height;
    wire [7:0] frame_rpt;
    wire [7:0] saturation_flush_repeat;
    wire [15:0] readout_count;
    wire [15:0] max_v_count;
    wire [15:0] max_h_count;
    wire [15:0] csi2_word_count;
    wire [15:0] roic_burst_cycle;
    wire [15:0] start_roic_burst_clk;
    wire [15:0] end_roic_burst_clk;
    wire gate_mode1;
    wire gate_mode2;
    wire gate_cs1;
    wire gate_cs2;
    wire gate_sel;
    wire gate_ud;
    wire gate_stv_mode;
    wire gate_oepsn;
    wire gate_lr1;
    wire gate_lr2;
    wire stv_sel_h;
    wire stv_sel_l1;
    wire stv_sel_r1;
    wire stv_sel_l2;
    wire stv_sel_r2;
    wire [15:0] up_back_bias;
    wire [15:0] dn_back_bias;
    wire [15:0] up_back_bias_opr;
    wire [15:0] dn_back_bias_opr;
    wire [15:0] up_gate_stv1;
    wire [15:0] dn_gate_stv1;
    wire [15:0] up_gate_stv2;
    wire [15:0] dn_gate_stv2;
    wire [15:0] up_gate_cpv1;
    wire [15:0] dn_gate_cpv1;
    wire [15:0] up_gate_cpv2;
    wire [15:0] dn_gate_cpv2;
    wire [15:0] up_gate_oe1;
    wire [15:0] dn_gate_oe1;
    wire [15:0] up_gate_oe2;
    wire [15:0] dn_gate_oe2;
    wire [15:0] dn_aed_gate_xao_0;
    wire [15:0] dn_aed_gate_xao_1;
    wire [15:0] dn_aed_gate_xao_2;
    wire [15:0] dn_aed_gate_xao_3;
    wire [15:0] dn_aed_gate_xao_4;
    wire [15:0] dn_aed_gate_xao_5;
    wire [15:0] up_aed_gate_xao_0;
    wire [15:0] up_aed_gate_xao_1;
    wire [15:0] up_aed_gate_xao_2;
    wire [15:0] up_aed_gate_xao_3;
    wire [15:0] up_aed_gate_xao_4;
    wire [15:0] up_aed_gate_xao_5;
    wire [15:0] aed_detect_line_0;
    wire [15:0] aed_detect_line_1;
    wire [15:0] aed_detect_line_2;
    wire [15:0] aed_detect_line_3;
    wire [15:0] aed_detect_line_4;
    wire [15:0] aed_detect_line_5;
    wire [15:0] up_roic_sync;
    wire [15:0] up_roic_aclk_0;
    wire [15:0] up_roic_aclk_1;
    wire [15:0] up_roic_aclk_2;
    wire [15:0] up_roic_aclk_3;
    wire [15:0] up_roic_aclk_4;
    wire [15:0] up_roic_aclk_5;
    wire [15:0] up_roic_aclk_6;
    wire [15:0] up_roic_aclk_7;
    wire [15:0] up_roic_aclk_8;
    wire [15:0] up_roic_aclk_9;
    wire [15:0] up_roic_aclk_10;
    wire [15:0] burst_break_pt_0;
    wire [15:0] burst_break_pt_1;
    wire [15:0] burst_break_pt_2;
    wire [15:0] burst_break_pt_3;
    wire [15:0] roic_reg_set_0;
    wire [15:0] roic_reg_set_1;
    wire [15:0] roic_reg_set_1_dual;
    wire [15:0] roic_reg_set_2;
    wire [15:0] roic_reg_set_3;
    wire [15:0] roic_reg_set_4;
    wire [15:0] roic_reg_set_5;
    wire [15:0] roic_reg_set_6;
    wire [15:0] roic_reg_set_7;
    wire [15:0] roic_reg_set_8;
    wire [15:0] roic_reg_set_9;
    wire [15:0] roic_reg_set_10;
    wire [15:0] roic_reg_set_11;
    wire [15:0] roic_reg_set_12;
    wire [15:0] roic_reg_set_13;
    wire [15:0] roic_reg_set_14;
    wire [15:0] roic_reg_set_15;
    wire ld_io_delay_tab;
    wire [4:0] io_delay_tab;
    wire [7:0] sel_roic_reg;
    wire [15:0] gate_size;
    wire en_16bit_adc;
    wire en_test_pattern_col;
    wire en_test_pattern_row;
    wire en_test_roic_col;
    wire en_test_roic_row;
    wire aed_test_mode1;
    wire aed_test_mode2;
    wire exp_ack;


    // Instantiate the Unit Under Test (UUT)
    reg_map uut (
        .eim_clk(eim_clk),
        .eim_rst(eim_rst),
        .fsm_clk(fsm_clk),
        .rst(rst),
        .sys_clk(sys_clk),
        .sys_rst(sys_rst),
        .prep_req(prep_req),
        .exp_req(exp_req),
        .row_cnt(row_cnt),
        .col_cnt(col_cnt),
        .row_end(row_end),
        .fsm_rst_index(fsm_rst_index),
        .fsm_init_index(fsm_init_index),
        .fsm_back_bias_index(fsm_back_bias_index),
        .fsm_flush_index(fsm_flush_index),
        .fsm_aed_read_index(fsm_aed_read_index),
        .fsm_exp_index(fsm_exp_index),
        .fsm_read_index(fsm_read_index),
        .gate_gpio_data(gate_gpio_data_in), // Connect to input
        .ready_to_get_image(ready_to_get_image),
        .valid_aed_read_skip(valid_aed_read_skip),
        .aed_ready_done(aed_ready_done),
        .panel_stable_exist(panel_stable_exist),
        .exp_read_exist(exp_read_exist),
        .ack_tx_end(ack_tx_end),
        .up_roic_reg(up_roic_reg),
        .roic_temperature(roic_temperature),
        .roic_reg_in_a(roic_reg_in_a),
        .roic_reg_in_b(roic_reg_in_b),
        .l_roic_temperature(l_roic_temperature),
        .l_roic_reg_in_a(l_roic_reg_in_a),
        .l_roic_reg_in_b(l_roic_reg_in_b),

        .reg_read_index(s_reg_read_index),
        .reg_addr({2'b00,s_reg_addr[14-1:0]}),
        .reg_data(s_reg_data),
        .reg_addr_index(s_reg_addr_index),
        .reg_data_index(s_reg_data_index),

        .exist_get_image(exist_get_image),

        .reg_read_out(reg_read_out),
        .read_data_en(read_data_en),
        .en_pwr_dwn(en_pwr_dwn),
        .en_pwr_off(en_pwr_off),
        .system_rst(system_rst_out), // Connect to output
        .reset_fsm(reset_fsm),
        .org_reset_fsm(org_reset_fsm),
        .dummy_get_image(dummy_get_image),
        .burst_get_image(burst_get_image),
        .get_dark(get_dark),
        .get_bright(get_bright),
        .cmd_get_bright(cmd_get_bright),
        .en_aed(en_aed),
        .aed_th(aed_th),
        .nega_aed_th(nega_aed_th),
        .posi_aed_th(posi_aed_th),
        .sel_aed_roic(sel_aed_roic),
        .num_trigger(num_trigger),
        .sel_aed_test_roic(sel_aed_test_roic),
        .ready_aed_read(ready_aed_read),
        .aed_dark_delay(aed_dark_delay),
        .en_back_bias(en_back_bias),
        .en_flush(en_flush),
        .en_panel_stable(en_panel_stable),
        .cycle_width(cycle_width),
        .mux_image_height(mux_image_height),
        .dsp_image_height(dsp_image_height),
        .aed_read_image_height(aed_read_image_height),
        .frame_rpt(frame_rpt),
        .saturation_flush_repeat(saturation_flush_repeat),
        .readout_count(readout_count),
        .max_v_count(max_v_count),
        .max_h_count(max_h_count),
        .csi2_word_count(csi2_word_count),
        .roic_burst_cycle(roic_burst_cycle),
        .start_roic_burst_clk(start_roic_burst_clk),
        .end_roic_burst_clk(end_roic_burst_clk),
        .gate_mode1(gate_mode1),
        .gate_mode2(gate_mode2),
        .gate_cs1(gate_cs1),
        .gate_cs2(gate_cs2),
        .gate_sel(gate_sel),
        .gate_ud(gate_ud),
        .gate_stv_mode(gate_stv_mode),
        .gate_oepsn(gate_oepsn),
        .gate_lr1(gate_lr1),
        .gate_lr2(gate_lr2),
        .stv_sel_h(stv_sel_h),
        .stv_sel_l1(stv_sel_l1),
        .stv_sel_r1(stv_sel_r1),
        .stv_sel_l2(stv_sel_l2),
        .stv_sel_r2(stv_sel_r2),
        .up_back_bias(up_back_bias),
        .dn_back_bias(dn_back_bias),
        .up_back_bias_opr(up_back_bias_opr),
        .dn_back_bias_opr(dn_back_bias_opr),
        .up_gate_stv1(up_gate_stv1),
        .dn_gate_stv1(dn_gate_stv1),
        .up_gate_stv2(up_gate_stv2),
        .dn_gate_stv2(dn_gate_stv2),
        .up_gate_cpv1(up_gate_cpv1),
        .dn_gate_cpv1(dn_gate_cpv1),
        .up_gate_cpv2(up_gate_cpv2),
        .dn_gate_cpv2(dn_gate_cpv2),
        .up_gate_oe1(up_gate_oe1),
        .dn_gate_oe1(dn_gate_oe1),
        .up_gate_oe2(up_gate_oe2),
        .dn_gate_oe2(dn_gate_oe2),
        .dn_aed_gate_xao_0(dn_aed_gate_xao_0),
        .dn_aed_gate_xao_1(dn_aed_gate_xao_1),
        .dn_aed_gate_xao_2(dn_aed_gate_xao_2),
        .dn_aed_gate_xao_3(dn_aed_gate_xao_3),
        .dn_aed_gate_xao_4(dn_aed_gate_xao_4),
        .dn_aed_gate_xao_5(dn_aed_gate_xao_5),
        .up_aed_gate_xao_0(up_aed_gate_xao_0),
        .up_aed_gate_xao_1(up_aed_gate_xao_1),
        .up_aed_gate_xao_2(up_aed_gate_xao_2),
        .up_aed_gate_xao_3(up_aed_gate_xao_3),
        .up_aed_gate_xao_4(up_aed_gate_xao_4),
        .up_aed_gate_xao_5(up_aed_gate_xao_5),
        .aed_detect_line_0(aed_detect_line_0),
        .aed_detect_line_1(aed_detect_line_1),
        .aed_detect_line_2(aed_detect_line_2),
        .aed_detect_line_3(aed_detect_line_3),
        .aed_detect_line_4(aed_detect_line_4),
        .aed_detect_line_5(aed_detect_line_5),
        .up_roic_sync(up_roic_sync),
        .up_roic_aclk_0(up_roic_aclk_0),
        .up_roic_aclk_1(up_roic_aclk_1),
        .up_roic_aclk_2(up_roic_aclk_2),
        .up_roic_aclk_3(up_roic_aclk_3),
        .up_roic_aclk_4(up_roic_aclk_4),
        .up_roic_aclk_5(up_roic_aclk_5),
        .up_roic_aclk_6(up_roic_aclk_6),
        .up_roic_aclk_7(up_roic_aclk_7),
        .up_roic_aclk_8(up_roic_aclk_8),
        .up_roic_aclk_9(up_roic_aclk_9),
        .up_roic_aclk_10(up_roic_aclk_10),
        .burst_break_pt_0(burst_break_pt_0),
        .burst_break_pt_1(burst_break_pt_1),
        .burst_break_pt_2(burst_break_pt_2),
        .burst_break_pt_3(burst_break_pt_3),
        .roic_reg_set_0(roic_reg_set_0),
        .roic_reg_set_1(roic_reg_set_1),
        .roic_reg_set_1_dual(roic_reg_set_1_dual),
        .roic_reg_set_2(roic_reg_set_2),
        .roic_reg_set_3(roic_reg_set_3),
        .roic_reg_set_4(roic_reg_set_4),
        .roic_reg_set_5(roic_reg_set_5),
        .roic_reg_set_6(roic_reg_set_6),
        .roic_reg_set_7(roic_reg_set_7),
        .roic_reg_set_8(roic_reg_set_8),
        .roic_reg_set_9(roic_reg_set_9),
        .roic_reg_set_10(roic_reg_set_10),
        .roic_reg_set_11(roic_reg_set_11),
        .roic_reg_set_12(roic_reg_set_12),
        .roic_reg_set_13(roic_reg_set_13),
        .roic_reg_set_14(roic_reg_set_14),
        .roic_reg_set_15(roic_reg_set_15),
        .ld_io_delay_tab(ld_io_delay_tab),
        .io_delay_tab(io_delay_tab),
        .sel_roic_reg(sel_roic_reg),
        .gate_size(gate_size),
        .en_16bit_adc(en_16bit_adc),
        .en_test_pattern_col(en_test_pattern_col),
        .en_test_pattern_row(en_test_pattern_row),
        .en_test_roic_col(en_test_roic_col),
        .en_test_roic_row(en_test_roic_row),
        .aed_test_mode1(aed_test_mode1),
        .aed_test_mode2(aed_test_mode2),
        .exp_ack(exp_ack)
    );

    // Clock Generation
    always #(CLK_PERIOD_SPI / 2) m_sclk_in = ~m_sclk_in;
    always #(CLK_PERIOD_50M / 2) MCLK_50M_p = ~MCLK_50M_p;
    always #(CLK_PERIOD_EIM / 2) eim_clk = ~eim_clk;
    always #(CLK_PERIOD_FSM / 2) fsm_clk = ~fsm_clk;
    always #(CLK_PERIOD_SYS / 2) sys_clk = ~sys_clk;


    integer i;
   
    // Test Scenario
    initial begin
        // Initialize inputs
        eim_clk = 1'b0;
        eim_rst = 1'b1; // Active low reset
        fsm_clk = 1'b0;
        m_sclk_in = 1'b0;
        MCLK_50M_p = 1'b0;
        rst = 1'b1;     // Active low reset
        sys_clk = 1'b0;
        sys_rst = 1'b1; // Active low reset

        prep_req = 1'b0;
        exp_req = 1'b0;
        row_cnt = 16'd0;
        col_cnt = 16'd0;
        row_end = 1'b0;

        fsm_rst_index = 1'b0;
        fsm_init_index = 1'b0;
        fsm_back_bias_index = 1'b0;
        fsm_flush_index = 1'b0;
        fsm_aed_read_index = 1'b0;
        fsm_exp_index = 1'b0;
        fsm_read_index = 1'b0;

        gate_gpio_data_in = 16'h0000;
        ready_to_get_image = 1'b0;
        valid_aed_read_skip = 1'b0;
        aed_ready_done = 1'b0;
        panel_stable_exist = 1'b0;
        exp_read_exist = 1'b0;
        ack_tx_end = 1'b0;

        up_roic_reg = 1'b0;
        roic_temperature = 16'd0;
        roic_reg_in_a = 64'd0;
        roic_reg_in_b = 64'd0;
        l_roic_temperature = 16'd0;
        l_roic_reg_in_a = 64'd0;
        l_roic_reg_in_b = 64'd0;

        exist_get_image = 1'b0;

        // Apply reset
        eim_rst = 1'b0;
        sys_rst = 1'b0;
        #(RESET_TIME);
        eim_rst = 1'b1;
        sys_rst = 1'b1;
        #100ns;

        $display("--- Start Test Scenario ---");
		rst_task();

		#100;
		$display("[SYS] : Wait osc clock!");
		@(posedge sys_clk);
		$display("[SYS] : OK osc clock!");

		@(posedge sys_clk);
		@(posedge sys_clk);

        for (i = 0; i < 512; i = i + 1) begin
            do_mspi_write(2'b10, i, 16'd0);
            #100;
        end
        #1000;
        
	    // Apply reset
        eim_rst = 1'b0;
        sys_rst = 1'b0;
        #(RESET_TIME);
        eim_rst = 1'b1;
        sys_rst = 1'b1;
        #100ns;
    	rst_task();

        #100
        $display($time, " << spi_write >>");
        do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);

        #200
        $display($time, " << spi_read >>");
        do_mspi_read(2'b00, `ADDR_SYS_CMD_REG);

        #5000;
        #100;
        do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_01);
        #100;
        do_mspi_write(2'b10 , `ADDR_SET_GATE, 16'h00_03);
        #100;
        do_mspi_write(2'b10 , `ADDR_GATE_SIZE, 16'h00_04);
        #100;
        do_mspi_write(2'b10 , `ADDR_BACK_BIAS_SIZE, 16'h00_64);
        #100;
        do_mspi_write(2'b10 , `ADDR_EXPOSE_SIZE, 16'd20); // test pattern , bit4: row bit3: col
        $display($time, " << expose size 20 >>");


        // 10 line
        do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'd10);
        // 1536 line
        // do_mspi_write(2'b10 , `ADDR_IMAGE_HEIGHT, 16'h06_00);
        #100;
        do_mspi_write(2'b10 , `ADDR_MAX_V_COUNT, 16'd30);
        // do_mspi_write(2'b10 , `ADDR_MAX_V_COUNT, 16'd1024);
        #100;
        do_mspi_write(2'b10 , `ADDR_MAX_H_COUNT, 16'd256);
        #100;
        do_mspi_write(2'b10 , `ADDR_READOUT_COUNT, 16'd0);
        #100;
        // do_mspi_write(2'b10 , `ADDR_CSI2_WORD_COUNT, 16'd2048);
        do_mspi_write(2'b10 , `ADDR_CSI2_WORD_COUNT, 16'd1024);
        #100;
        do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_FLUSH, 16'd100);
        #100;
        do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_AED, 16'd3660);
        #100;
        do_mspi_write(2'b10 , `ADDR_CYCLE_WIDTH_READ, 16'd4160);
        #100;
        do_mspi_write(2'b10 , `ADDR_REPEAT_FLUSH, 16'h00_04);
        #100;
        do_mspi_write(2'b10 , `ADDR_REPEAT_BACK_BIAS, 16'h00_01);
        #100;
        do_mspi_write(2'b10 , `ADDR_SATURATION_FLUSH_REPEAT, 16'h00_02);
        #100;
        do_mspi_write(2'b10 , `ADDR_UP_BACK_BIAS, 16'h00_02);
        #100;
        do_mspi_write(2'b10 , `ADDR_DN_BACK_BIAS, 16'h00_32);

        #100;
        do_mspi_write(2'b10 , `ADDR_UP_BACK_BIAS_OPR, 16'h00_20);
        #100;
        do_mspi_write(2'b10 , `ADDR_DN_BACK_BIAS_OPR, 16'h00_32);
        #100;

        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_0, 16'h00_14);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_1, 16'h01_A8);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_2, 16'h00_07);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_3, 16'h00_14);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_4, 16'h00_A2);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_5, 16'h00_14);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_6, 16'h00_58);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_7, 16'h00_37);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_8, 16'h00_69);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_9, 16'h00_07);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_10, 16'h00_00);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_11, 16'h00_18);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_12, 16'h00_02);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_13, 16'h00_23);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_14, 16'h00_2B);
        #100;
        do_mspi_write(2'b10 , `ADDR_ROIC_REG_SET_15, 16'h00_08);

        #100;
        do_mspi_write(2'b10 , `ADDR_READY_AED_READ, 16'h00_03);
        #100;
        do_mspi_write(2'b10 , `ADDR_AED_TH, 16'h00_04);
        #100;
        // do_mspi_write(2'b10 , `ADDR_SEL_AED_ROIC, 16'h00_01);
        do_mspi_write(2'b10 , `ADDR_SEL_AED_ROIC, 16'h05_6A);
        #100;
        do_mspi_write(2'b10 , `ADDR_NUM_TRIGGER, 16'h00_01);
        #100;
        do_mspi_write(2'b10 , `ADDR_SEL_AED_TEST_ROIC, 16'h00_01);
        #100;
        do_mspi_write(2'b10 , `ADDR_NEGA_AED_TH, 16'h00_02);
        #100;
        do_mspi_write(2'b10 , `ADDR_POSI_AED_TH, 16'h00_03);
        #100;
        do_mspi_write(2'b10 , `ADDR_AED_DARK_DELAY, 16'h00_02);
        #100;

        do_mspi_write(2'b10 , `ADDR_UP_GATE_OE1_FLUSH, 16'd40);
        #100;

        do_mspi_write(2'b10 , `ADDR_UP_GATE_OE2_FLUSH, 16'd40);
        #100;

        do_mspi_write(2'b10 , `ADDR_SEL_ROIC_REG, 16'd0);
        #100;

        do_mspi_write(2'b10 , `ADDR_SYS_CMD_REG, 16'h00_00);
        $display($time, " << Test 4 SYS CMD 0 >>");
        #1000;


        $display($time, " << Test start >>");


        #100;
        fsm_test_task(1, 16'h00_00);

        $display($time, " << Wait time 1msec >>");
        #1000000;



        $display("\n--- End Test Scenario ---");
        $finish;
    end

    // Dump waves
    initial begin
        $dumpfile("reg_map.vcd");
        $dumpvars(0, tb_reg_map);
    end


	// spi master task
	localparam header   = 2;		// size of header , wr:rd 2bit
	localparam payload  = 16;       // size of payload or data size
	localparam addrsz   = 14;		// size of SPI Address Space
	localparam pktsz    = header + addrsz + payload;		// size of SPI packet

		
	logic 					m_start = 1'b0;
	logic [1:0] 			slaveselect = 2'b00;
	logic [header-1:0] 		masterHeader;
	logic [addrsz-1:0]  	masterAddrToSend;
	logic [payload-1:0]  	masterDataToSend;
	logic [payload-1:0] 	masterDataReceived;

	spi_master #(
		.pktsz   		( pktsz ),
		.header  		( header ),
		.payload 		( payload ),
		.addrsz  		( addrsz )
		)
	spi_master_inst  (
		.clk     			(MCLK_50M_p),
		.reset 				(rst),
		.start				(m_start),
		.slaveselect		(slaveselect),
		.masterHeader 		(masterHeader),
		.masterAddrToSend	(masterAddrToSend),
		.masterDataToSend	(masterDataToSend),

		.masterDataReceived	(masterDataReceived),
		.SCLK	   			(m_SCLK),
		.CS					(m_CS),
		.MOSI				(m_MOSI),
		.MISO				(m_MISO)
		);

    // SPI slave instantiation 
    // Note: Placeholder, actual implementation needs to be provided    
    spi_slave #(
        .header(header),
        .payload(payload),
        .addrsz(addrsz),
        .pktsz(pktsz)
    )
    host_if_inst (
        .clk               (sys_clk),
        .reset             (rst),
        .SCLK              (m_SCLK),
        .SSB               (m_CS),
        .MOSI              (m_MOSI),
        .MISO              (m_MISO),
        .spi_start_flag    (),
        .read_data         (reg_read_out[payload-1:0]),
        .read_en           (read_data_en),
        .reg_addr          (s_reg_addr[addrsz-1:0]),
        .addr_valid        (s_addr_dv),
        .wr_data           (s_reg_data[payload-1:0]),
        .wr_data_valid     (s_reg_data_index),
        .rw_out            (s_rw_out)
    );

    assign s_reg_addr_index = (s_rw_out == 1'b0 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;
    assign s_reg_read_index = (s_rw_out == 1'b1 && s_addr_dv == 1'b1) ? 1'b1 : 1'b0;
    


// task module
    task rst_task();
        begin
            rst = 1'b1;
            #50;
            rst = 1'b0;
        end
    endtask

// spi task

	task do_mspi_write;
		input [header-1:0] 	from_header;
		// input [addrsz-1:0] 	from_addr;
		input [16-1:0] 	from_addr;
		input [payload-1:0] from_data;

		int i;

		begin
			@(posedge m_sclk_in);
				// #(CLK_PERIOD_SPI) m_start =1'b0;
				masterHeader = from_header;
				masterAddrToSend = from_addr[addrsz-1:0];
				masterDataToSend = from_data;
				#1;
				#(CLK_PERIOD_SPI) m_start =1'b1;
				#(CLK_PERIOD_SPI) m_start =1'b0;
		end

		for (i=0;i<pktsz;i++)
			begin
				#(CLK_PERIOD_SPI);
			end

	endtask

	task do_mspi_read;
		input [header-1:0] 	from_header;
		// input [addrsz-1:0] 	from_addr;
		input [16-1:0] 	from_addr;
		
		int i;
		
		begin
			@(posedge m_sclk_in);
				// #(CLK_PERIOD_SPI) m_start =1'b0;
				masterHeader = from_header;
				masterAddrToSend = from_addr[addrsz-1:0];
				#1;
				#(CLK_PERIOD_SPI) m_start =1'b1;
				#(CLK_PERIOD_SPI) m_start =1'b0;
		end

		for (i=0;i<pktsz;i++)
			begin
				#(CLK_PERIOD_SPI);
			end

	endtask

	// FSM test task
	task fsm_test_task;
		input test_no;	
		input [15:0] aed_cmd;

		begin
			$display($time, " << Test %d Start >>" , test_no);
			
			#100;
			do_mspi_write(2'b10 , `ADDR_AED_CMD, aed_cmd);
			$display($time, " << Test %d AED CMD Off>>" , test_no);

		end
	endtask


endmodule