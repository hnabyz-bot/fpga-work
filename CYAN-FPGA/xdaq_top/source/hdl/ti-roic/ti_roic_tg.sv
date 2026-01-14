`timescale 1ns / 1ps
`include	"./p_define_refacto.sv"
//==============================================================================
// Project      : TI-ROIC
// File         : ti_roic_tg.sv
// Module Name  : ti_roic_tg
// Author       : drake.lee / H&abyz
// Create Date  : 2025-06-19
// Encoding     : UTF-8
//
// Target Device: Xilinx Artix-7 XC7A35T
// Tool Version : Vivado 2023.2
//
// Description  : TI ROIC timing generator module based on start/end values
//              : Generates pulse signal based on counter values
//
// Dependencies : None
//
//==============================================================================
// Revision History:
// Version | Date       | Author        | Description
//---------|------------|---------------|---------------------------------------
// 0.00    | 2025-06-19 | drake.lee     | Initial creation
//==============================================================================

/**
 * @file pulse_generator.sv
 * @brief Pulse signal generator based on start and end boundaries
 * 
 * This module generates a pulse signal that is active between the specified
 * start and end values. The module uses an internal counter and compares it
 * with the input start/end values to determine when to assert the output signal.
 */

module ti_roic_tg (
    // Clock and reset
    input  logic        clk,       // System clock
    input  logic        rst,       // Active high reset signal
    
    input  logic [1:0]  str,   // scan time range
    input  logic        sync_in,
    input  logic        tp_sel,
    input  logic        aed_detect_skip_oe,

    input  logic        fsm_read_index, // FSM read index for synchronization
    // input  logic channel_detected, // Detected channel flag for synchronization
//    input  logic        gate_on_in,


    // Control inputs
    input  logic        reg_en,      // Register enable signal
    input  logic [7:0]  reg_addr,     
    input  logic [15:0] reg_data,
    
    output logic        sync_start,
    output logic [10:0] readout_width,
    output logic [15:0] tg_row_cnt,
    output logic [10:0] tg_col_cnt,
    output logic        roic_sync_out,
    output logic        roic_a_bz,

    output logic        tg_stv,
    output logic        tg_cpv,
    output logic        tg_oe,
    output logic        v_sync,

    // Output signal
    output logic        IRST,
    output logic        SHR,
    output logic        SHS,
    output logic        LPF1,
    output logic        LPF2,
    output logic        TDEF,
    output logic        GATE_ON,
    output logic        DF_SM0,
    output logic        DF_SM1,
    output logic        DF_SM2,
    output logic        DF_SM3,
    output logic        DF_SM4,
    output logic        DF_SM5
);

    // Internal counter
    logic sig_mclk;

    logic s_gate_on;
    logic s_cpv;

    logic s_reg_en;
    logic [7:0] s_reg_addr;
    logic [15:0] s_reg_data;

    logic [2:0] str_clk_count; // Counter for scan time resolution
    logic [10:0] counter; // Internal counter for pulse generation
    logic [7:0] str_counter; // Counter for scan time resolution
    logic [10:0] max_count; // Maximum count value (255)

    // TI RIIC Timing Generator Control Signals a and b
    logic [7:0] IRST_rise_a   ; // = 8'd1; 
    logic [7:0] IRST_fall_a   ; // = 8'd5; 
    logic [7:0] SHR_rise_a    ; // = 8'd6; 
    logic [7:0] SHR_fall_a    ; // = 8'd40; 
    logic [7:0] SHS_rise_a    ; // = 8'd41; 
    logic [7:0] SHS_fall_a    ; // = 8'd254; 
    logic [7:0] LPF1_rise_a   ; // = 8'd16; 
    logic [7:0] LPF1_fall_a   ; // = 8'd41; 
    logic [7:0] LPF2_rise_a   ; // = 8'd229; 
    logic [7:0] LPF2_fall_a   ; // = 8'd255; 
    logic [7:0] TDEF_rise_a   ; // = 8'd128; 
    logic [7:0] TDEF_fall_a   ; // = 8'd255; 
    logic [7:0] GATE_rise_a   ; // = 8'd128; 
    logic [7:0] GATE_fall_a   ; // = 8'd255; 
    logic [7:0] DF_SM0_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM0_fall_a ; // = 8'd255; 
    logic [7:0] DF_SM1_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM1_fall_a ; // = 8'd255; 
    logic [7:0] DF_SM2_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM2_fall_a ; // = 8'd255; 
    logic [7:0] DF_SM3_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM3_fall_a ; // = 8'd255; 
    logic [7:0] DF_SM4_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM4_fall_a ; // = 8'd255; 
    logic [7:0] DF_SM5_rise_a ; // = 8'd128; 
    logic [7:0] DF_SM5_fall_a ; // = 8'd255; 

    logic [7:0] IRST_rise_b   ; // = 8'd1; 
    logic [7:0] IRST_fall_b   ; // = 8'd5; 
    logic [7:0] SHR_rise_b    ; // = 8'd6; 
    logic [7:0] SHR_fall_b    ; // = 8'd40; 
    logic [7:0] SHS_rise_b    ; // = 8'd41; 
    logic [7:0] SHS_fall_b    ; // = 8'd254; 
    logic [7:0] LPF1_rise_b   ; // = 8'd16; 
    logic [7:0] LPF1_fall_b   ; // = 8'd41; 
    logic [7:0] LPF2_rise_b   ; // = 8'd229; 
    logic [7:0] LPF2_fall_b   ; // = 8'd255; 
    logic [7:0] TDEF_rise_b   ; // = 8'd128; 
    logic [7:0] TDEF_fall_b   ; // = 8'd255; 
    logic [7:0] GATE_rise_b   ; // = 8'd128; 
    logic [7:0] GATE_fall_b   ; // = 8'd255; 
    logic [7:0] DF_SM0_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM0_fall_b ; // = 8'd255; 
    logic [7:0] DF_SM1_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM1_fall_b ; // = 8'd255; 
    logic [7:0] DF_SM2_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM2_fall_b ; // = 8'd255; 
    logic [7:0] DF_SM3_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM3_fall_b ; // = 8'd255; 
    logic [7:0] DF_SM4_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM4_fall_b ; // = 8'd255; 
    logic [7:0] DF_SM5_rise_b ; // = 8'd128; 
    logic [7:0] DF_SM5_fall_b ; // = 8'd255; 

    logic [7:0] IRST_rise   ; // = 8'd1; 
    logic [7:0] IRST_fall   ; // = 8'd5; 
    logic [7:0] SHR_rise    ; // = 8'd6; 
    logic [7:0] SHR_fall    ; // = 8'd40; 
    logic [7:0] SHS_rise    ; // = 8'd41; 
    logic [7:0] SHS_fall    ; // = 8'd254; 
    logic [7:0] LPF1_rise   ; // = 8'd16; 
    logic [7:0] LPF1_fall   ; // = 8'd41; 
    logic [7:0] LPF2_rise   ; // = 8'd229; 
    logic [7:0] LPF2_fall   ; // = 8'd255; 
    logic [7:0] TDEF_rise   ; // = 8'd128; 
    logic [7:0] TDEF_fall   ; // = 8'd255; 
    logic [7:0] GATE_rise   ; // = 8'd128; 
    logic [7:0] GATE_fall   ; // = 8'd255; 
    logic [7:0] DF_SM0_rise ; // = 8'd128; 
    logic [7:0] DF_SM0_fall ; // = 8'd255; 
    logic [7:0] DF_SM1_rise ; // = 8'd128; 
    logic [7:0] DF_SM1_fall ; // = 8'd255; 
    logic [7:0] DF_SM2_rise ; // = 8'd128; 
    logic [7:0] DF_SM2_fall ; // = 8'd255; 
    logic [7:0] DF_SM3_rise ; // = 8'd128; 
    logic [7:0] DF_SM3_fall ; // = 8'd255; 
    logic [7:0] DF_SM4_rise ; // = 8'd128; 
    logic [7:0] DF_SM4_fall ; // = 8'd255; 
    logic [7:0] DF_SM5_rise ; // = 8'd128; 
    logic [7:0] DF_SM5_fall ; // = 8'd255; 

    // ===============================================================================
    logic hi_FSM_read_index; // High index for FSM read operation
    logic FSM_read_index_1d; // Delayed FSM read index
    logic FSM_read_index_2d; // Further delayed FSM read index
    // logic [2:0] s_channel_detected_dly; // Delayed channel detected signal
    logic [15:0] s_hsync_count;
    logic s_hsync_en;
    logic s_sync_rst;
//    logic s_hsync;
    logic s_vsync;
    logic s_sync_valid;

    logic s_count_end;
    logic s_roic_sync_gen;
    logic s_roic_a_bz;

    // logic s_fifo_in;
    // logic s_fifo_out;
    logic s_fifo_wen;
    logic s_fifo_ren;

    logic s_fifo_empty;
    logic s_fifo_full;


    assign v_sync = s_vsync;
    
    // ------------------------------------------------------------------------------
    // Pulse signal generation logic
    // ------------------------------------------------------------------------------
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            FSM_read_index_1d <= 1'b0; // Reset delayed FSM read index
            FSM_read_index_2d <= 1'b0; // Reset further delayed FSM read
        end else begin
            FSM_read_index_1d <= fsm_read_index;
            FSM_read_index_2d <= FSM_read_index_1d;
        end
    end

    assign hi_FSM_read_index = ~FSM_read_index_2d & FSM_read_index_1d;

    // always_ff @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //         s_channel_detected_dly <= 3'b000; // Reset channel detected delay
    //     end else begin
    //         s_channel_detected_dly <= {s_channel_detected_dly[1:0], channel_detected};
    //     end
    // end

    // assign s_hsync_en = (s_channel_detected_dly == 3'b001) ? 1'b1 : 1'b0; // Enable horizontal sync when channel detected
    assign s_sync_rst = (rst || hi_FSM_read_index) ? 1'b1 : 1'b0; // Reset sync signal on reset or high FSM read index
    
    assign s_count_end = (counter == (max_count - 1'b1)) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or posedge s_sync_rst) begin
        if (s_sync_rst) begin
            s_hsync_count <= 16'h0000; // Reset horizontal sync count
        end else begin
            if (s_hsync_en) begin
                s_hsync_count <= s_hsync_count + 1'b1; // Increment horizontal sync count
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            s_sync_valid <= 1'b0; // Reset GATE signal
        end else begin
            if (s_hsync_en) begin
                s_sync_valid <= 1'b1;
            end 
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            tg_oe <= 1'b0;
            GATE_ON <= 1'b0;
        end else begin
            if (aed_detect_skip_oe) begin
                tg_oe <= 1'b1;
            end else begin
                tg_oe <= (~s_gate_on);
            end 
            
            GATE_ON <= s_gate_on;
        end
    end

    assign s_cpv = (str_counter >= 8'h20 && str_counter < 8'h60) ? 1'b1 : 1'b0; // Set column pulse high at start of frame 

    assign s_vsync = (s_sync_valid && s_hsync_count == 16'h0000) ? 1'b1 : 1'b0; // Set vertical sync high at start of frame
    assign tg_stv = (s_sync_valid && s_hsync_count == 16'h0001) ? 1'b1 : 1'b0;
    assign tg_cpv = s_cpv; // Assign horizontal sync to column pulse signal
    // assign tg_oe = ~s_gate_on; // Assign gate on signal to output enable
    // assign GATE_ON = s_gate_on; // Assign gate on signal

    assign tg_row_cnt = s_hsync_count;
    assign tg_col_cnt = counter[10:0];
    // ------------------------------------------------------------------------------
    assign sync_start = (str_counter[7:0] == '0) ? 1'b1 : 1'b0;
    assign readout_width = max_count; 

    always_ff @(posedge clk or posedge rst or posedge s_roic_sync_gen) begin
        if (rst || s_roic_sync_gen) begin
            str_clk_count <= 3'b000;      // Reset counter on reset signal
        end else begin
            // Increment counter, wrap around to 0 after 255
            str_clk_count <= str_clk_count + 1'b1;
        end
    end
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            max_count <= 11'd255;
            str_counter <= 8'h00;
        end else begin
            // Set maximum count based on scan time range
            case (str)
                2'b00: begin
                    max_count <= 11'd255;
                    str_counter <= counter[7:0];
                end
                2'b01: begin
                    max_count <= 11'd511;
                    str_counter <= counter[8:1];
                end
                2'b10: begin
                    max_count <= 11'd1023;
                    str_counter <= counter[9:2];
                end
                2'b11: begin
                    max_count <= 11'd2047;
                    str_counter <= counter[10:3];
                end
                default: begin
                    max_count <= 11'd255; // Default to 1us resolution
                    str_counter <= counter[7:0];
                end
            endcase
        end
    end

    always_comb
        // Select the clock signal based on scan time range
        case (str)
            2'b00: sig_mclk = clk; // 1us resolution
            2'b01: sig_mclk = str_clk_count[0]; // 2us resolution
            2'b10: sig_mclk = str_clk_count[1]; // 4us resolution
            2'b11: sig_mclk = str_clk_count[2]; // Default to 1us resolution
            default: sig_mclk = clk; // Default to 1us resolution
        endcase

    // Pulse signal generation logic
    always_ff @(posedge sig_mclk or posedge rst or posedge s_roic_sync_gen) begin
        if (rst || s_roic_sync_gen) begin
            IRST <= 1'b0;        // Reset output signal
            SHR <= 1'b0;         // Reset SHR signal
            SHS <= 1'b0;         // Reset SHS signal
            LPF1 <= 1'b0;        // Reset LPF1 signal
            LPF2 <= 1'b0;        // Reset LPF2 signal
            TDEF <= 1'b0;        // Reset TDEF signal
            s_gate_on <= 1'b0;     // Reset GATE signal
            DF_SM0 <= 1'b0;     // Reset DF_SM0 signal
            DF_SM1 <= 1'b0;     // Reset DF_SM1 signal
            DF_SM2 <= 1'b0;     // Reset DF_SM2 signal
            DF_SM3 <= 1'b0;     // Reset DF_SM3 signal
            DF_SM4 <= 1'b0;     // Reset DF_SM4 signal
            DF_SM5 <= 1'b0;     // Reset DF_SM5 signal
        end else begin
            // Set signal high when str_counter is between start and end values
            if (str_counter == IRST_rise) begin
                IRST <= 1'b1;    // Assert signal at start value
            end else if (str_counter == IRST_fall) begin
                IRST <= 1'b0;    // De-assert signal at end value
            end
            if (str_counter == SHR_rise) begin
                SHR <= 1'b1;     // Assert SHR signal at start value
            end else if (str_counter == SHR_fall) begin
                SHR <= 1'b0;     // De-assert SHR signal at end value
            end
            if (str_counter == SHS_rise) begin
                SHS <= 1'b1;     // Assert SHS signal at start value
            end else if (str_counter == SHS_fall) begin
                SHS <= 1'b0;     // De-assert SHS signal at end value
            end
            if (str_counter == LPF1_rise) begin
                LPF1 <= 1'b1;    // Assert LPF1 signal at start value
            end else if (str_counter == LPF1_fall) begin
                LPF1 <= 1'b0;    // De-assert LPF1 signal at end value
            end
            if (str_counter == LPF2_rise) begin
                LPF2 <= 1'b1;    // Assert LPF2 signal at start value
            end else if (str_counter == LPF2_fall) begin
                LPF2 <= 1'b0;    // De-assert LPF2 signal at end value
            end
            if (str_counter == TDEF_rise) begin
                TDEF <= 1'b1;    // Assert TDEF signal at start value
            end else if (str_counter == TDEF_fall) begin
                TDEF <= 1'b0;    // De-assert TDEF signal at end value
            end
            if (str_counter == GATE_rise) begin
                s_gate_on <= 1'b1; // Assert GATE signal at start value
            end else if (str_counter == GATE_fall) begin
                s_gate_on <= 1'b0; // De-assert GATE signal at end value
            end
            if (str_counter == DF_SM0_rise) begin
                DF_SM0 <= 1'b1;  // Assert DF_SM0 signal at start value
            end else if (str_counter == DF_SM0_fall) begin
                DF_SM0 <= 1'b0;  // De-assert DF_SM0 signal at end value
            end
            if (str_counter == DF_SM1_rise) begin
                DF_SM1 <= 1'b1;  // Assert DF_SM1 signal at start value
            end else if (str_counter == DF_SM1_fall) begin
                DF_SM1 <= 1'b0;  // De-assert DF_SM1 signal at end value
            end
            if (str_counter == DF_SM2_rise) begin
                DF_SM2 <= 1'b1;  // Assert DF_SM2 signal at start value
            end else if (str_counter == DF_SM2_fall) begin
                DF_SM2 <= 1'b0;  // De-assert DF_SM2 signal at end value
            end
            if (str_counter == DF_SM3_rise) begin
                DF_SM3 <= 1'b1;  // Assert DF_SM3 signal at start value
            end else if (str_counter == DF_SM3_fall) begin
                DF_SM3 <= 1'b0;  // De-assert DF_SM3 signal at end value
            end
            if (str_counter == DF_SM4_rise) begin
                DF_SM4 <= 1'b1;  // Assert DF_SM4 signal at start value
            end else if (str_counter == DF_SM4_fall) begin
                DF_SM4 <= 1'b0;  // De-assert DF_SM4 signal at end value
            end
            if (str_counter == DF_SM5_rise) begin
                DF_SM5 <= 1'b1;  // Assert DF_SM5 signal at start value
            end else if (str_counter == DF_SM5_fall) begin
                DF_SM5 <= 1'b0;  // De-assert DF_SM5 signal at end value
            end
            // Otherwise maintain current state
        end
    end

    // always_ff @(posedge clk or posedge rst or posedge sync) begin
    //     if (rst || sync) begin
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 11'h00; // Reset counter on reset signal
            s_hsync_en <= 1'b0;
        end else begin
            if (s_hsync_en) begin
                counter <= 11'h00; // Reset counter on sync signal
            end else begin
                counter <= counter + 1'b1;
            end
            s_hsync_en <= s_count_end;
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            s_reg_en <= 1'b0;
            s_reg_addr <= 8'h00;
            s_reg_data <= 16'h0000;
        end else begin
            s_reg_en <= reg_en;
            s_reg_addr <= reg_addr;
            s_reg_data <= reg_data;
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            IRST_rise_a   <= 8'd1; 
            IRST_fall_a   <= 8'd5; 
            SHR_rise_a    <= 8'd6; 
            SHR_fall_a    <= 8'd40; 
            SHS_rise_a    <= 8'd41; 
            SHS_fall_a    <= 8'd254; 
            LPF1_rise_a   <= 8'd16; 
            LPF1_fall_a   <= 8'd41; 
            LPF2_rise_a   <= 8'd229; 
            LPF2_fall_a   <= 8'd255; 
            TDEF_rise_a   <= 8'd128; 
            TDEF_fall_a   <= 8'd255; 
            GATE_rise_a   <= 8'd128; 
            GATE_fall_a   <= 8'd255; 
            DF_SM0_rise_a <= 8'd128;
            DF_SM0_fall_a <= 8'd255;
            DF_SM1_rise_a <= 8'd128; 
            DF_SM1_fall_a <= 8'd255; 
            DF_SM2_rise_a <= 8'd128; 
            DF_SM2_fall_a <= 8'd255; 
            DF_SM3_rise_a <= 8'd128; 
            DF_SM3_fall_a <= 8'd255; 
            DF_SM4_rise_a <= 8'd128; 
            DF_SM4_fall_a <= 8'd255; 
            DF_SM5_rise_a <= 8'd128; 
            DF_SM5_fall_a <= 8'd255; 
        end else begin
            if (s_reg_en && tp_sel) begin
                // Update start/end values based on register address and data
                case (s_reg_addr)
                    `DEF_IRST_ADDR: begin
                        IRST_rise_a = s_reg_data[15:8]; 
                        IRST_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SHR_ADDR: begin
                        SHR_rise_a = s_reg_data[15:8]; 
                        SHR_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SHS_ADDR: begin
                        SHS_rise_a = s_reg_data[15:8]; 
                        SHS_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_LPF1_ADDR: begin
                        LPF1_rise_a = s_reg_data[15:8]; 
                        LPF1_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_LPF2_ADDR: begin
                        LPF2_rise_a = s_reg_data[15:8]; 
                        LPF2_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_TDEF_ADDR: begin
                        TDEF_rise_a = s_reg_data[15:8]; 
                        TDEF_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_GATE_ADDR: begin
                        GATE_rise_a = s_reg_data[15:8]; 
                        GATE_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM0_ADDR: begin
                        DF_SM0_rise_a = s_reg_data[15:8]; 
                        DF_SM0_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM1_ADDR: begin
                        DF_SM1_rise_a = s_reg_data[15:8]; 
                        DF_SM1_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM2_ADDR: begin
                        DF_SM2_rise_a = s_reg_data[15:8]; 
                        DF_SM2_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM3_ADDR: begin
                        DF_SM3_rise_a = s_reg_data[15:8]; 
                        DF_SM3_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM4_ADDR: begin
                        DF_SM4_rise_a = s_reg_data[15:8]; 
                        DF_SM4_fall_a = s_reg_data[7:0]; 
                    end
                    `DEF_SM5_ADDR: begin
                        DF_SM5_rise_a = s_reg_data[15:8]; 
                        DF_SM5_fall_a = s_reg_data[7:0]; 
                    end
                endcase
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            IRST_rise_b   <= 8'd1; 
            IRST_fall_b   <= 8'd5; 
            SHR_rise_b    <= 8'd6; 
            SHR_fall_b    <= 8'd40; 
            SHS_rise_b    <= 8'd41; 
            SHS_fall_b    <= 8'd254; 
            LPF1_rise_b   <= 8'd16; 
            LPF1_fall_b   <= 8'd41; 
            LPF2_rise_b   <= 8'd229; 
            LPF2_fall_b   <= 8'd255; 
            TDEF_rise_b   <= 8'd128; 
            TDEF_fall_b   <= 8'd255; 
            GATE_rise_b   <= 8'd128; 
            GATE_fall_b   <= 8'd255; 
            DF_SM0_rise_b <= 8'd128;
            DF_SM0_fall_b <= 8'd255;
            DF_SM1_rise_b <= 8'd128; 
            DF_SM1_fall_b <= 8'd255; 
            DF_SM2_rise_b <= 8'd128; 
            DF_SM2_fall_b <= 8'd255; 
            DF_SM3_rise_b <= 8'd128; 
            DF_SM3_fall_b <= 8'd255; 
            DF_SM4_rise_b <= 8'd128; 
            DF_SM4_fall_b <= 8'd255; 
            DF_SM5_rise_b <= 8'd128; 
            DF_SM5_fall_b <= 8'd255; 
        end else begin
            if (s_reg_en && !tp_sel) begin
                // Update start/end values based on register address and data
                case (s_reg_addr)
                    `DEF_IRST_ADDR: begin
                        IRST_rise_b = s_reg_data[15:8]; 
                        IRST_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SHR_ADDR: begin
                        SHR_rise_b = s_reg_data[15:8]; 
                        SHR_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SHS_ADDR: begin
                        SHS_rise_b = s_reg_data[15:8]; 
                        SHS_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_LPF1_ADDR: begin
                        LPF1_rise_b = s_reg_data[15:8]; 
                        LPF1_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_LPF2_ADDR: begin
                        LPF2_rise_b = s_reg_data[15:8]; 
                        LPF2_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_TDEF_ADDR: begin
                        TDEF_rise_b = s_reg_data[15:8]; 
                        TDEF_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_GATE_ADDR: begin
                        GATE_rise_b = s_reg_data[15:8]; 
                        GATE_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM0_ADDR: begin
                        DF_SM0_rise_b = s_reg_data[15:8]; 
                        DF_SM0_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM1_ADDR: begin
                        DF_SM1_rise_b = s_reg_data[15:8]; 
                        DF_SM1_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM2_ADDR: begin
                        DF_SM2_rise_b = s_reg_data[15:8]; 
                        DF_SM2_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM3_ADDR: begin
                        DF_SM3_rise_b = s_reg_data[15:8]; 
                        DF_SM3_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM4_ADDR: begin
                        DF_SM4_rise_b = s_reg_data[15:8]; 
                        DF_SM4_fall_b = s_reg_data[7:0]; 
                    end
                    `DEF_SM5_ADDR: begin
                        DF_SM5_rise_b = s_reg_data[15:8]; 
                        DF_SM5_fall_b = s_reg_data[7:0]; 
                    end
                endcase
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            IRST_rise   <= 8'd1; 
            IRST_fall   <= 8'd5; 
            SHR_rise    <= 8'd6; 
            SHR_fall    <= 8'd40; 
            SHS_rise    <= 8'd41; 
            SHS_fall    <= 8'd254; 
            LPF1_rise   <= 8'd16; 
            LPF1_fall   <= 8'd41; 
            LPF2_rise   <= 8'd229; 
            LPF2_fall   <= 8'd255; 
            TDEF_rise   <= 8'd128; 
            TDEF_fall   <= 8'd255; 
            GATE_rise   <= 8'd128; 
            GATE_fall   <= 8'd255; 
            DF_SM0_rise <= 8'd128;
            DF_SM0_fall <= 8'd255;
            DF_SM1_rise <= 8'd128; 
            DF_SM1_fall <= 8'd255; 
            DF_SM2_rise <= 8'd128; 
            DF_SM2_fall <= 8'd255; 
            DF_SM3_rise <= 8'd128; 
            DF_SM3_fall <= 8'd255; 
            DF_SM4_rise <= 8'd128; 
            DF_SM4_fall <= 8'd255; 
            DF_SM5_rise <= 8'd128; 
            DF_SM5_fall <= 8'd255; 
        end else begin
            if (s_roic_sync_gen) begin
                if (tp_sel) begin
                    IRST_rise   <= IRST_rise_b; 
                    IRST_fall   <= IRST_fall_b; 
                    SHR_rise    <= SHR_rise_b;
                    SHR_fall    <= SHR_fall_b; 
                    SHS_rise    <= SHS_rise_b; 
                    SHS_fall    <= SHS_fall_b; 
                    LPF1_rise   <= LPF1_rise_b; 
                    LPF1_fall   <= LPF1_fall_b; 
                    LPF2_rise   <= LPF2_rise_b; 
                    LPF2_fall   <= LPF2_fall_b; 
                    TDEF_rise   <= TDEF_rise_b; 
                    TDEF_fall   <= TDEF_fall_b; 
                    GATE_rise   <= GATE_rise_b;
                    GATE_fall   <= GATE_fall_b; 
                    DF_SM0_rise <= DF_SM0_rise_b;
                    DF_SM0_fall <= DF_SM0_fall_b;
                    DF_SM1_rise <= DF_SM1_rise_b; 
                    DF_SM1_fall <= DF_SM1_fall_b; 
                    DF_SM2_rise <= DF_SM2_rise_b; 
                    DF_SM2_fall <= DF_SM2_fall_b; 
                    DF_SM3_rise <= DF_SM3_rise_b; 
                    DF_SM3_fall <= DF_SM3_fall_b; 
                    DF_SM4_rise <= DF_SM4_rise_b; 
                    DF_SM4_fall <= DF_SM4_fall_b; 
                    DF_SM5_rise <= DF_SM5_rise_b; 
                    DF_SM5_fall <= DF_SM5_fall_b; 
                end else begin
                    IRST_rise   <= IRST_rise_a; 
                    IRST_fall   <= IRST_fall_a; 
                    SHR_rise    <= SHR_rise_a;
                    SHR_fall    <= SHR_fall_a; 
                    SHS_rise    <= SHS_rise_a; 
                    SHS_fall    <= SHS_fall_a; 
                    LPF1_rise   <= LPF1_rise_a; 
                    LPF1_fall   <= LPF1_fall_a; 
                    LPF2_rise   <= LPF2_rise_a; 
                    LPF2_fall   <= LPF2_fall_a; 
                    TDEF_rise   <= TDEF_rise_a; 
                    TDEF_fall   <= TDEF_fall_a; 
                    GATE_rise   <= GATE_rise_a;
                    GATE_fall   <= GATE_fall_a; 
                    DF_SM0_rise <= DF_SM0_rise_a;
                    DF_SM0_fall <= DF_SM0_fall_a;
                    DF_SM1_rise <= DF_SM1_rise_a; 
                    DF_SM1_fall <= DF_SM1_fall_a; 
                    DF_SM2_rise <= DF_SM2_rise_a; 
                    DF_SM2_fall <= DF_SM2_fall_a; 
                    DF_SM3_rise <= DF_SM3_rise_a; 
                    DF_SM3_fall <= DF_SM3_fall_a; 
                    DF_SM4_rise <= DF_SM4_rise_a; 
                    DF_SM4_fall <= DF_SM4_fall_a; 
                    DF_SM5_rise <= DF_SM5_rise_a; 
                    DF_SM5_fall <= DF_SM5_fall_a; 
                end
            end
        end
    end

    // ========================================================
    // Sync processing
    // ========================================================

    fifo_1b #(
        .DATA_WIDTH    (1),
        .DEPTH         (1)
    ) fifo_sync_inst (
        .rst        (rst),
        .clk        (clk),
        .wr_en      (s_fifo_wen),
        .rd_en      (s_fifo_ren),
        .din        (1'b1),
        .dout       (),
        .full       (s_fifo_full),
        .empty      (s_fifo_empty)
    );

    assign s_fifo_wen = (sync_in && s_fifo_empty) ? 1'b1 : 1'b0;
    assign s_fifo_ren = (!s_roic_a_bz && s_count_end && s_fifo_full) ? 1'b1 : 1'b0;

    assign s_roic_sync_gen = s_fifo_ren;

    always_ff @(posedge clk or posedge rst or posedge s_roic_sync_gen) begin
        if (rst || s_roic_sync_gen) begin
            s_roic_a_bz <= 1'b0;
        end else begin
            if (s_hsync_en) begin
                s_roic_a_bz <= (~s_roic_a_bz);
            end 
        end
    end

    assign roic_sync_out = s_roic_sync_gen;
    assign roic_a_bz = s_roic_a_bz;


endmodule
