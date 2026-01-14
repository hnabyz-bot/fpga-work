`timescale 1ns / 1ps

// -------------------------------------------------------------------
// Module: read_data_mux
// Description: SystemVerilog conversion of read_data_mux
// -------------------------------------------------------------------

module read_data_mux (
    input  logic        sys_clk,
    input  logic        sys_rst,
    
    input  logic        eim_clk,
    input  logic        eim_rst,

//    input  logic        seq_reset,

    input  logic        csi_done,
    
    input  logic        dummy_get_image,
    output logic        exist_get_image,
    
//    input  logic        get_dark,
//    input  logic        get_bright,
    
    input  logic [15:0] dsp_image_height,
    input  logic [15:0] max_v_count,
    input  logic [15:0] max_h_count,
    
//    input  logic        en_test_pattern_col,
//    input  logic        en_test_pattern_row,
    
    input  logic        FSM_aed_read_index,
    input  logic        FSM_read_index,
    input  logic        read_data_start,
    
//    input  logic        valid_roic_data,
    input  wire [23:0] roic_read_data_a [11:0],
    input  wire [23:0] roic_read_data_b [11:0],
    
    input  logic        valid_read_mem,
    
    input  logic        read_axis_tready,
    output logic        read_axis_tlast,
    output logic        read_data_valid,
    output logic [23:0] read_data_out_a,
    output logic [23:0] read_data_out_b,
    output logic        read_frame_start,
    output logic        read_frame_reset,
//    output logic [7:0]  read_addr_cnt,
    output logic [11:0] data_read_req
    
//    output logic        read_vsync,
//    output logic        read_hsync
);

    // Constants
    localparam [15:0] VALID_NUM_ROIC_BURST = 16'h0020;
    localparam [7:0]  NUM_ROIC_CHANNEL = 8'b01111111;    // 127 in binary format
    localparam [9:0]  MEM_HEIGHT = 10'b0011111111;       // 255 in binary format

    // ROIC size constants
    localparam [9:0] UP_XROIC_SIZE[0:5] = '{
        10'b0001111100, 10'b0011111100, 10'b0101111100,
        10'b0111111100, 10'b1001111100, 10'b1011111100
    };
    
    localparam [9:0] DN_XROIC_SIZE[0:5] = '{
        10'b0001111111, 10'b0011111111, 10'b0101111111,
        10'b0111111111, 10'b1001111111, 10'b1011111111
    };
    
    // Internal signals
    logic        tx_eim_rst;      
    // Reset signal for tx path
//    logic        valid_read_roic_data;
    logic [15:0] s_h_count;   // Horizontal counter
    logic [15:0] s_v_count;   // Vertical counter
    logic [15:0] s_max_h_count; // Maximum horizontal count (768)
    logic [15:0] s_max_v_count; // Maximum vertical count (1024)
    
    logic s_sync_gen_en;

    // AXI-Stream interface signals
    logic        s_axis_tvalid;          // AXI Stream valid signal
    logic        s_axis_tvalid_1d;
    logic        s_axis_tvalid_2d;
    logic        s_axis_tvalid_3d;
    logic        s_read_axis_tready;     // AXI Stream ready signal
    logic        s_axis_tlast;
    logic        s_axis_tlast_1d;
    logic        s_axis_tlast_2d;
    logic        s_axis_tlast_3d;
    
//    // Burst counter signals
//    logic        valid_read_roic_data_sys_1d = 1'b0;
//    logic        valid_read_roic_data_sys_2d = 1'b0;
//    logic        inc_roic_burst_cnt_sys;
//    logic        rst_roic_burst_cnt_sys;
//    logic [7:0]  roic_burst_cnt_sys = 8'h01;
    
    // Memory interface signals
    // logic [31:0] read_mem_data [11:0];   // Memory read data (1-based indexing)
//    logic [8:0]  read_mem_addr [11:0];   // Memory read address (1-based indexing)
    logic       s_valid_read_mem;
    logic       s_dummy_read_index;
    // logic       s_dummy_end;
    logic [11:0] s_axis_read_mem;
    

    // Memory read addressing
    logic        read_mem_index; // Memory read index signal
//    logic [9:0]  read_mem_addr_offset;
//    logic [7:0]  read_mem_addr_offset_1d;
//    logic [7:0]  read_mem_addr_offset_2d;
//    logic [9:0]  s_max_read_mem_addr_offset;

    // Test pattern signals using arrays for better organization
    logic [15:0] test_pattern_col_1 [11:0] = '{
        16'h0001, 16'h0101, 16'h0201, 16'h0301, 16'h0401, 16'h0501,
        16'h0601, 16'h0701, 16'h0801, 16'h0901, 16'h0a01, 16'h0b01
    };
    
    logic [15:0] test_pattern_col_2 [11:0] = '{
        16'h0002, 16'h0102, 16'h0202, 16'h0302, 16'h0402, 16'h0502,
        16'h0602, 16'h0702, 16'h0802, 16'h0902, 16'h0a02, 16'h0b02
    };

    logic [31:0] test_pattern_row = 32'h00010001;
    logic [15:0] pattern_offset = 16'h0001;
    logic [15:0] line_offset = 16'h0000;

//    // Flag signals
//    logic [5:0] flag;         // Combines flags 1-6
//    logic [5:0] hi_flag;      // Combines hi_flags 1-6
//    logic [5:0] lo_flag;      // Combines lo_flags 1-6
    
//    logic [5:0] lo_flag_tmp1; // Combines lo_flag_X_tmp1 signals
//    logic [5:0] lo_flag_tmp2; // Combines lo_flag_X_tmp2 signals

//    // HSYNC delay signals
//    logic [5:0] hsync_delay_start;    // Bit vector for hsync_delay_start_X
//    logic [5:0] hsync_delay_start_1d; // Delayed hsync_delay_start
//    logic [5:0] hsync_delay_start_2d; // 2-cycle delayed hsync_delay_start
    
//    logic [5:0] hsync_delay;          // Bit vector for hsync_delay_X
//    logic [7:0] hsync_delay_cnt [0:5];// Array for hsync_delay_cnt_X
    
//    logic [5:0] hi_hsync_delay_tmp1;  // Combines hi_hsync_delay_X_tmp1
//    logic [5:0] hi_hsync_delay_tmp2;  // Combines hi_hsync_delay_X_tmp2
    
//    // HSYNC control signals
//    logic [5:0] hi_hsync_delay;       // Combines hi_hsync_delay_X signals
//    logic [5:0] lo_hsync_delay;       // Combines lo_hsync_delay_X signals
    
    logic [5:0] hsync;             
    logic [5:0] hi_hsync;             
    logic hi_hsync_all, lo_hsync;
    logic sig_hsync;
    logic sig_hsync_1d, sig_hsync_2d;

    logic up_hsync_keep_hi, down_hsync_keep_hi;
    logic hsync_keep_hi;
    logic [3:0] hsync_keep_hi_cnt;
    
    // HSYNC counter control
    logic rst_hsync_cnt, rst_hsync_cnt_dly;
    logic inc_hsync_cnt;
    logic [11:0] hsync_cnt;

//    logic get_image_eim_1d;
    
    logic s_read_data_start;

    // VSYNC control signals
    logic       FSM_read_index_eim_1d;
    logic       FSM_read_index_eim_2d;
    logic       FSM_read_index_eim_3d;
    logic       FSM_read_index_eim_4d;
    logic       FSM_read_index_eim_5d;
    logic       sig_vsync;
    logic       hi_vsync;
    logic       lo_vsync;
    logic       up_vsync_keep_hi;
    logic       down_vsync_keep_hi;
    logic       vsync_keep_hi;
    logic [3:0] vsync_keep_hi_cnt;

    logic FSM_read_index_sys_1d;
    logic FSM_read_index_sys_2d;
//    logic get_image_sys_1d;
    logic tx_sys_rst;
    

    // Signal to indicate if we are in image acquisition
//    logic get_image;
    
    logic s_dummy_start;
    logic s_dummy_get_image_1d;
    logic s_dummy_get_image_2d;
    logic s_dummy_valid;
    logic [15:0] s_dummy_valid_count;
//    logic [3:0] s_tuser_0_cnt;

    logic [11:0] read_mem; // Read memory flags
    logic [11:0] read_mem_1d; // Delayed read memory flags
    logic [11:0] read_mem_2d; // 2-cycle delayed read memory flags
    
    logic [11:0] end_read_mem; // End read memory flags
    logic [11:0] start_read_mem; // Start read memory flags
    
    logic [15:0] s_tuser_0_dly; // Delayed tuser signals
    logic s_v_sync;
    logic s_h_sync;

    assign s_max_h_count = max_h_count;
    assign s_max_v_count = max_v_count;

//
    always_ff @(posedge eim_clk or negedge eim_rst or posedge rst_hsync_cnt_dly or posedge hi_vsync or posedge tx_sys_rst) begin
        if (!eim_rst || rst_hsync_cnt_dly || hi_vsync || tx_sys_rst) begin
            s_h_count <= 16'h0000;
            s_v_count <= 16'h0000;
        end else if (s_axis_tvalid && s_read_axis_tready) begin
            if (s_h_count == (s_max_h_count - 1)) begin
                if (s_v_count == (s_max_v_count - 1)) begin
                    s_h_count <= 16'h0000;
                    s_v_count <= 16'h0000;
                end else begin
                    s_h_count <= 16'h0000;
                    s_v_count <= s_v_count + 1;
                end
            end else begin
                s_h_count <= s_h_count + 1;
            end
        end
    end

    // Dummy and exist_get_image control
    always_ff @(posedge eim_clk or negedge eim_rst or posedge hi_vsync) begin
        if (!eim_rst || hi_vsync) begin
            s_dummy_valid <= 1'b0;
            s_dummy_valid_count <= '0;
        end else begin
            // Control s_dummy_valid
            if (s_dummy_start) begin
                s_dummy_valid <= 1'b1;
            end else if ((s_v_count == (s_max_v_count - 1)) && (s_h_count == (s_max_h_count - 1))) begin
                s_dummy_valid <= 1'b0;
            end

            // Update dummy valid counter
            if (s_dummy_valid) begin
                s_dummy_valid_count <= s_dummy_valid_count + 1'b1;
            end
        end
    end

    // Dummy and exist_get_image control
    always_ff @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            s_dummy_get_image_1d <= 1'b0;
            s_dummy_get_image_2d <= 1'b0;
        end else begin
            // Pipeline dummy_get_image signal 
            s_dummy_get_image_1d <= dummy_get_image;
            s_dummy_get_image_2d <= s_dummy_get_image_1d;
        end
    end

   
    // Control signals
    assign s_dummy_start = s_dummy_get_image_1d && !s_dummy_get_image_2d;
    // assign s_dummy_end = !s_dummy_get_image_1d && s_dummy_get_image_2d;    // Get image control
//    assign get_image = (get_dark || get_bright) && !s_dummy_valid;
    
    // Assign the exist_get_image output
    assign exist_get_image = s_dummy_valid;

    // Dummy read index control based on counter and h_count
    assign s_dummy_read_index = (s_dummy_valid_count[11] == 0) ||
                          (s_dummy_valid_count[11] && s_h_count > 0 && s_h_count <= (max_h_count - 1)) ? 
                          s_dummy_valid : 1'b0;    // Write memory data logic for both test patterns and normal ROIC data
    

    assign tx_eim_rst = (FSM_read_index_eim_1d && !FSM_read_index_eim_2d && !FSM_aed_read_index) ? 1'b1 : 1'b0;
    assign tx_sys_rst = (FSM_read_index_sys_1d && !FSM_read_index_sys_2d && !FSM_aed_read_index) ? 1'b1 : 1'b0;

    assign s_read_data_start = read_data_start;

//    // System clock domain logic
//    always_ff @(posedge sys_clk or negedge sys_rst or posedge tx_sys_rst) begin
//        if (!sys_rst || tx_sys_rst) begin
//            valid_read_roic_data_sys_1d <= 1'b0;
//            valid_read_roic_data_sys_2d <= 1'b0;
//        end else begin
//            // Pipeline valid ROIC data signals
//            valid_read_roic_data_sys_1d <= valid_read_roic_data;
//            valid_read_roic_data_sys_2d <= valid_read_roic_data_sys_1d;
//        end
//    end
    
    always_ff @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
            FSM_read_index_sys_1d <= 1'b0;
            FSM_read_index_sys_2d <= 1'b0;
//            get_image_sys_1d <= 1'b0;
        end else begin
            // Valid ROIC data control
            FSM_read_index_sys_1d <= FSM_read_index;
            FSM_read_index_sys_2d <= FSM_read_index_sys_1d;
//            get_image_sys_1d <= get_image;
        end
    end
    
//    assign valid_read_roic_data = (valid_roic_data && FSM_read_index);

//    // Burst counter control
//    assign inc_roic_burst_cnt_sys = !valid_read_roic_data_sys_1d && valid_read_roic_data_sys_2d;
//    assign rst_roic_burst_cnt_sys = (inc_roic_burst_cnt_sys && (roic_burst_cnt_sys == VALID_NUM_ROIC_BURST)) ? 1'b1 : 1'b0;
    
//    // Burst counter
//    always_ff @(posedge sys_clk or negedge sys_rst or posedge tx_sys_rst) begin
//        if (!sys_rst || tx_sys_rst) begin
//            roic_burst_cnt_sys <= 8'h01;
//        end else begin
//            if (rst_roic_burst_cnt_sys)
//                roic_burst_cnt_sys <= 8'h01;
//            else if (inc_roic_burst_cnt_sys)
//                roic_burst_cnt_sys <= roic_burst_cnt_sys + 1'b1;
//        end
//    end    
    
    // EIM clock domain reset control
    always_ff @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            FSM_read_index_eim_1d <= 1'b0;
            FSM_read_index_eim_2d <= 1'b0;
            FSM_read_index_eim_3d <= 1'b0;
            FSM_read_index_eim_4d <= 1'b0;
            FSM_read_index_eim_5d <= 1'b0;
//            get_image_eim_1d <= 1'b0;
        end else begin
            FSM_read_index_eim_1d <= FSM_read_index;
            FSM_read_index_eim_2d <= FSM_read_index_eim_1d;
            FSM_read_index_eim_3d <= FSM_read_index_eim_2d;
            FSM_read_index_eim_4d <= FSM_read_index_eim_3d;
            FSM_read_index_eim_5d <= FSM_read_index_eim_4d;
//            get_image_eim_1d <= get_image;
            
        end
    end


//    assign s_max_read_mem_addr_offset = 10'b0110000000 + NUM_ROIC_CHANNEL;

//    // Memory read address control
//    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//        if (!eim_rst || tx_eim_rst) begin
//            read_mem_addr_offset <= '0;
//            read_mem_addr_offset_1d <= '0;
//            read_mem_addr_offset_2d <= '0;
//        end else begin
//            if (~read_mem_index)
//                read_mem_addr_offset <= '0;
//            else if (read_mem_index && valid_read_mem)
//                read_mem_addr_offset <= (read_mem_addr_offset == s_max_read_mem_addr_offset) ? '0 : read_mem_addr_offset + 1'b1;

//            read_mem_addr_offset_1d <= read_mem_addr_offset[7:0];
//            read_mem_addr_offset_2d <= read_mem_addr_offset_1d;
            
//            // Set max read address offset based on dual readout mode
//        end
//    end

    // Read address counter output
//    assign read_addr_cnt = read_mem_addr_offset_2d;

    // Memory read control signals    
    assign s_valid_read_mem = s_axis_tvalid & s_read_axis_tready & valid_read_mem;

    assign s_read_axis_tready = read_axis_tready;
    
    assign s_sync_gen_en = ((read_mem_index || s_dummy_read_index) && s_read_axis_tready) ? 1'b1 : 1'b0;

    assign s_axis_tvalid = (s_sync_gen_en && !s_axis_tlast && (s_h_count == 16'h0000)) ? 1'b1 :
                            (s_sync_gen_en && s_h_sync) ? 1'b1 : 
                            1'b0;
    
    assign s_tuser_0 = (s_sync_gen_en && s_h_count==16'h0000 && s_v_count==16'h0000) ? 1'b1 : 1'b0;

    assign s_v_sync = (s_v_count > '0 && s_v_count <= s_max_v_count) ? 1'b1 : 1'b0;
    assign s_h_sync = (s_h_count > '0 && s_h_count <= s_max_h_count) ? 1'b1 : 1'b0;

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            s_axis_tlast <= 1'b0;
        end else begin
            if (s_read_axis_tready) begin
                if (s_h_count == (s_max_h_count - 2)) begin
                    s_axis_tlast <= 1'b1; // Set last signal before the end of the line
                end else if (s_h_count == 16'h0000) begin
                    s_axis_tlast <= 1'b0; // Reset last signal at the start of the line
                end
            end
        end
    end
    

    assign read_mem_index = |read_mem;

    // Memory end control signals
    genvar i;

    generate
        for (i = 0; i < 12; i++) begin : gen_end_read_mem
            assign end_read_mem[i] = (read_mem[i] && (s_valid_read_mem && ({1'b0, s_h_count[6:0]} == NUM_ROIC_CHANNEL))) ? 1'b1 : 1'b0;
        end
    endgenerate    
    
    logic s_hsync_FSM_read_index;
    logic s_hsync_dly_FSM_read_index;

    assign s_hsync_FSM_read_index = (FSM_read_index || s_hsync_dly_FSM_read_index) ? 1'b1 : 1'b0;

    always_ff @(posedge eim_clk or negedge eim_rst) begin
        if (!eim_rst) begin
            s_hsync_dly_FSM_read_index <= 1'b0;
        end else begin
            if (lo_hsync)
                s_hsync_dly_FSM_read_index <= FSM_read_index;
        end
    end

    generate
        for (i = 0; i < 12; i++) begin : gen_start_read_mem
            assign s_axis_read_mem[i] = (s_axis_tvalid) ? read_mem[i] : 1'b0;
            assign data_read_req[i] = (csi_done && s_hsync_FSM_read_index) ? s_axis_read_mem[i] : 1'b0;
            // assign data_read_req[i] = (csi_done && s_hsync_FSM_read_index) ? read_mem[i] : 1'b0;
        end
    endgenerate


    // Memory read control for all channels
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            read_mem <= '0;
            read_mem_1d <= '0;
            read_mem_2d <= '0;
            
            // AXI-Stream signals reset
            s_axis_tvalid_1d <= 1'b0;
            s_axis_tvalid_2d <= 1'b0;
            s_axis_tvalid_3d <= 1'b0;
            
            s_axis_tlast_1d <= 1'b0;
            s_axis_tlast_2d <= 1'b0;
            s_axis_tlast_3d <= 1'b0;
            read_axis_tlast <= 1'b0;
        end else begin
            // Update read memory flags
            for (int k = 0; k < 12; k++) begin
                if (end_read_mem[k])
                    read_mem[k] <= 1'b0;
                else if (start_read_mem[k])
                    read_mem[k] <= 1'b1;
            end
            
            // Pipeline read memory flags
            read_mem_1d <= read_mem;
            read_mem_2d <= read_mem_1d;
            
            // Pipeline AXI-Stream signals
            s_axis_tvalid_1d <= s_axis_tvalid;
            s_axis_tvalid_2d <= s_axis_tvalid_1d;
            s_axis_tvalid_3d <= s_axis_tvalid_2d;
            
            s_axis_tlast_1d <= s_axis_tlast;
            s_axis_tlast_2d <= s_axis_tlast_1d;
            s_axis_tlast_3d <= s_axis_tlast_2d;
            read_axis_tlast <= s_axis_tlast_3d;
        end
    end

    // Start read operations control
    assign start_read_mem[0]  = hi_hsync_all;
    
    // genvar i;
    generate
        for (i = 1; i < 12; i++) begin : gen_start_read
            assign start_read_mem[i] = end_read_mem[i-1] && s_read_axis_tready;
        end
    endgenerate

//    // Memory read address control for all channels
//    // genvar i;
//    generate
//        for (i = 0; i < 12; i++) begin : gen_mem_addr_ctrl
//            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//                if (!eim_rst || tx_eim_rst)
//                    read_mem_addr[i] <= '0;
//                else if (read_mem[i] & s_valid_read_mem) begin
//                    if (read_mem_addr[i] == MEM_HEIGHT)
//                        read_mem_addr[i] <= '0;
//                    else
//                        read_mem_addr[i] <= read_mem_addr[i] + 1'b1;
//                end
//            end
//        end
//    endgenerate

    
    // Memory read data output multiplexing
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            read_data_out_a <= '0;
            read_data_out_b <= '0;
            read_data_valid <= 1'b0;
        end else begin
            // Use delayed valid signal to match VHDL behavior
            read_data_valid <= s_axis_tvalid_3d;
            
            if (|read_mem_2d) begin
                case (1'b1)
                    read_mem_2d[0]: begin
                                        read_data_out_a <= (roic_read_data_a[0]);
                                        read_data_out_b <= (roic_read_data_b[0]);
                                    end
                    read_mem_2d[1]: begin
                                        read_data_out_a <= (roic_read_data_a[1]);
                                        read_data_out_b <= (roic_read_data_b[1]);
                                    end
                    read_mem_2d[2]: begin
                                        read_data_out_a <= (roic_read_data_a[2]);
                                        read_data_out_b <= (roic_read_data_b[2]);
                                    end
                    read_mem_2d[3]: begin
                                        read_data_out_a <= (roic_read_data_a[3]);
                                        read_data_out_b <= (roic_read_data_b[3]);
                                    end
                    read_mem_2d[4]: begin
                                        read_data_out_a <= (roic_read_data_a[4]);
                                        read_data_out_b <= (roic_read_data_b[4]);
                                    end
                    read_mem_2d[5]: begin
                                        read_data_out_a <= (roic_read_data_a[5]);
                                        read_data_out_b <= (roic_read_data_b[5]);
                                    end
                    read_mem_2d[6]: begin
                                        read_data_out_a <= (roic_read_data_a[6]);
                                        read_data_out_b <= (roic_read_data_b[6]);
                                    end
                    read_mem_2d[7]: begin
                                        read_data_out_a <= (roic_read_data_a[7]);
                                        read_data_out_b <= (roic_read_data_b[7]);
                                    end
                    read_mem_2d[8]: begin
                                        read_data_out_a <= (roic_read_data_a[8]);
                                        read_data_out_b <= (roic_read_data_b[8]);
                                    end
                    read_mem_2d[9]: begin
                                        read_data_out_a <= (roic_read_data_a[9]);
                                        read_data_out_b <= (roic_read_data_b[9]);
                                    end
                    read_mem_2d[10]: begin
                                        read_data_out_a <= (roic_read_data_a[10]);
                                        read_data_out_b <= (roic_read_data_b[10]);
                                    end
                    read_mem_2d[11]: begin
                                        read_data_out_a <= (roic_read_data_a[11]);
                                        read_data_out_b <= (roic_read_data_b[11]);
                                    end
                    default:        begin
                                        read_data_out_a <= '0;
                                        read_data_out_b <= '0;
                                    end
                endcase
            end else begin
                read_data_out_a <= '0;
                read_data_out_b <= '0;
            end
        end
    end

    // Frame start/reset control
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            read_frame_start <= 1'b0;
            read_frame_reset <= 1'b0;
        end else begin
            read_frame_start <= s_tuser_0_dly[11];
            read_frame_reset <= hi_vsync;
        end
    end
    

    // HSYNC control logic
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (tx_eim_rst || !eim_rst) begin
            sig_hsync_1d <= 1'b0;
            sig_hsync_2d <= 1'b0;
            
            hsync_keep_hi <= 1'b0;
            hsync_keep_hi_cnt <= '0;
            
        end else begin
            // HSYNC delay signals
            sig_hsync_1d <= sig_hsync;
            sig_hsync_2d <= sig_hsync_1d;
            
            // HSYNC keep high control
            if (up_hsync_keep_hi) begin
                hsync_keep_hi <= 1'b1;
            end else if (down_hsync_keep_hi) begin
                hsync_keep_hi <= 1'b0;
            end

            // HSYNC counter
            if (!hsync_keep_hi) begin
                    hsync_keep_hi_cnt <= 4'h0;
             end else begin
                    hsync_keep_hi_cnt <= hsync_keep_hi_cnt + 1;
            end
        end
    end

    // HSYNC control signals
    assign hi_hsync_all = |hi_hsync;
    assign sig_hsync = |hsync;
    assign read_hsync = sig_hsync;
    
    // HSYNC keep hi control
    assign up_hsync_keep_hi = end_read_mem[11];
    assign down_hsync_keep_hi = sig_hsync && hsync_keep_hi && (hsync_keep_hi_cnt == 4'b0101);

   // HSYNC counter logic
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
//            hsync_cnt <= 0;
            s_tuser_0_dly <= '0;
//            s_tuser_0_cnt <= '0;
        end else begin
              
            // Update tuser_0 signals from VHDL implementation
            s_tuser_0_dly <= {s_tuser_0_dly[14:0], s_tuser_0};
            
//            if (hi_vsync) begin
//                s_tuser_0_cnt <= 4'h0;
//            end else if (s_tuser_0) begin
//                s_tuser_0_cnt <= s_tuser_0_cnt + 1'b1;
//            end
        end
    end
    
    // HSYNC counter control signals
    assign inc_hsync_cnt = !sig_hsync_1d && sig_hsync_2d;
    assign rst_hsync_cnt = (inc_hsync_cnt && hsync_cnt == (dsp_image_height[11:0] - 12'h1)) ? 1'b1 : 1'b0;

    // HSYNC counter
    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            hsync_cnt <= 12'd0;
            rst_hsync_cnt_dly <= 1'b0;
        end else begin
            if (rst_hsync_cnt_dly) begin
                hsync_cnt <= 12'd0;
            end else if (inc_hsync_cnt & sig_vsync) begin
                hsync_cnt <= hsync_cnt + 1;
            end
            rst_hsync_cnt_dly <= rst_hsync_cnt;
        end
    end


    // assign hi_vsync = (FSM_read_index_eim_4d && !FSM_read_index_eim_5d) && get_image;
    assign hi_vsync = (FSM_read_index_eim_4d && !FSM_read_index_eim_5d);

    assign up_vsync_keep_hi = rst_hsync_cnt_dly;
    assign down_vsync_keep_hi = sig_vsync && vsync_keep_hi && (vsync_keep_hi_cnt == 4'b1111);

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            vsync_keep_hi <= 1'b0;
        end
        else begin
            if (down_vsync_keep_hi)
                vsync_keep_hi <= 1'b0;
            else if (up_vsync_keep_hi)
                vsync_keep_hi <= 1'b1;
        end
    end

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            vsync_keep_hi_cnt <= 4'b0000;
        end
        else begin
            if (!vsync_keep_hi)
                vsync_keep_hi_cnt <= 4'b0000;
            else if (vsync_keep_hi)
                vsync_keep_hi_cnt <= vsync_keep_hi_cnt + 1'b1;
        end
    end

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            lo_vsync <= 1'b0;
        end
        else begin
            lo_vsync <= down_vsync_keep_hi;
        end
    end

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            sig_vsync <= 1'b0;
        end
        else begin
            if (lo_vsync)
                sig_vsync <= 1'b0;
            else if (hi_vsync)
                sig_vsync <= 1'b1;
        end
    end

//    assign read_vsync = sig_vsync;

    always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
        if (!eim_rst || tx_eim_rst) begin
            lo_hsync <= 1'b0;
        end else begin
            lo_hsync <= down_hsync_keep_hi;
        end
    end

    // Generate vector singnals

    // genvar i;
    generate
        for (i = 0; i < 6; i = i + 1) begin : hi_hsync_gen
            // assign hi_hsync[i] = lo_hsync_delay[i];
            assign hi_hsync[i] = s_read_data_start;
        end
    endgenerate

    generate
//        genvar i;
        for (i = 0; i < 6; i = i + 1) begin : hsync_gen
            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
                if (!eim_rst || tx_eim_rst) begin
                    hsync[i] <= 1'b0;
                end else if (lo_hsync) begin
                    hsync[i] <= 1'b0;
                end else if (hi_hsync[i]) begin
                    hsync[i] <= 1'b1;
                end
            end
        end
    endgenerate


//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hsync_delay_gen
//            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//                if (!eim_rst || tx_eim_rst) begin
//                    hsync_delay[i] <= 1'b0;
//                end else if (lo_hsync_delay[i]) begin
//                    hsync_delay[i] <= 1'b0;
//                end else if (hi_hsync_delay[i]) begin
//                    hsync_delay[i] <= 1'b1;
//                end
//            end
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hsync_delay_cnt_gen
//            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//                if (!eim_rst || tx_eim_rst) begin
//                    hsync_delay_cnt[i] <= 8'h00;
//                end else if (!hsync_delay[i]) begin
//                    hsync_delay_cnt[i] <= 8'h00;
//                end else if (hsync_delay[i]) begin
//                    hsync_delay_cnt[i] <= hsync_delay_cnt[i] + 1'b1;
//                end
//            end
//        end
//    endgenerate


//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hi_hsync_delay_gen
//            assign hi_hsync_delay_tmp1[i] = (hsync_delay_start_1d[i] && !hsync_delay_start_2d[i]);
//            assign hi_hsync_delay_tmp2[i] = (lo_hsync && hsync[(i + 5) % 6] && flag[i]);
//            assign hi_hsync_delay[i] = (hi_hsync_delay_tmp1[i] && !hi_hsync_delay_tmp2[i]);
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : lo_hsync_delay_gen
//            assign lo_hsync_delay[i] = (hsync_delay_cnt[i]== '1 && hsync_delay[i] == 1'b1) ? 1'b1 : 1'b0;
//        end
//    endgenerate


//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : flag_gen 
//            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//                if (!eim_rst || tx_eim_rst) begin
//                    flag[i] <= 1'b0;
//                end else if (lo_flag[i]) begin
//                    flag[i] <= 1'b0;
//                end else if (hi_flag[i]) begin
//                    flag[i] <= 1'b1;
//                end
//            end
//        end
//    endgenerate


//    generate 
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hsync_delay_start_gen
//            always_ff @(posedge sys_clk or negedge sys_rst or posedge tx_sys_rst) begin
//                if (!sys_rst || tx_sys_rst) begin
//                    hsync_delay_start[i] <= 1'b0;
//                end else if (valid_read_roic_data) begin
//                    hsync_delay_start[i] <= 1'b1;
//                end else 
//                    hsync_delay_start[i] <= 1'b0;
//            end
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hsync_delay_start_dly_gen
//            always_ff @(posedge eim_clk or negedge eim_rst or posedge tx_eim_rst) begin
//                if (!eim_rst || tx_eim_rst) begin
//                    hsync_delay_start_1d[i] <= '0;
//                    hsync_delay_start_2d[i] <= '0;
//                end else begin
//                    hsync_delay_start_1d[i] <= hsync_delay_start[i];
//                    hsync_delay_start_2d[i] <= hsync_delay_start_1d[i];
//                end
//            end
//        end
//    endgenerate


//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : hi_flag_gen
//            assign hi_flag[i] = hsync_delay_start_1d[i] && !hsync_delay_start_2d[i] && !flag[i];
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : lo_flag_tmp1_gen
//            assign lo_flag_tmp1[i] = lo_hsync && hsync[i] && !flag[(i + 1) % 6];
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i++) begin : lo_flag_tmp2_gen
//            always_comb begin
//                lo_flag_tmp2[i] = lo_hsync_delay[(i + 1) % 6] && flag[i] && flag[(i + 1) % 6];
//            end
//        end
//    endgenerate

//    generate
////        genvar i;
//        for (i = 0; i < 6; i = i + 1) begin : lo_flag_gen
//            assign lo_flag[i] = lo_flag_tmp1 || lo_flag_tmp2[i];
//        end
//    endgenerate



	// process(eim_clk, eim_rst)
	// begin
	// 	if eim_rst='0' then
	// 		read_rx_data_a  <= (others=>'0');
	// 		read_rx_data_b  <= (others=>'0');
	// 	elsif eim_clk'event and eim_clk='1' then
	// 		read_rx_data_b <= image_data_out(7 downto 3)&"000"&image_data_out(12 downto 8)&"000"
	// 						&image_data_out(2 downto 0)&image_data_out(15 downto 13)&"00";
	// 		read_rx_data_a <= image_data_out(23 downto 19)&"000"&image_data_out(28 downto 24)&"000"
	// 						&image_data_out(18 downto 16)&image_data_out(31 downto 29)&"00";
	// 	end if;
	// end process;


endmodule