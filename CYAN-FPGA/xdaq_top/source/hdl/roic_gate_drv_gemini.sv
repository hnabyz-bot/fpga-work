// ---------------------------------------------------------------------------------
//   Title        : ROIC Gate Driver Module
//   Purpose      : Optimized and synthesizable SystemVerilog RTL code for
//                  the ROIC Gate Driver Module, enhancing readability and maintainability.
//                  Controls gate signals for ROIC in various operational modes.
//
//   Designer     : drake.lee
//   Company      : H&abyz Inc.
//
// ---------------------------------------------------------------------------------
//   Modification history :
//
//   version:     |   mod. date:   |   changes made:
//      v0.0            01/28/2022      Initial release
//      v0.1            05/30/2023      Refactored for SystemVerilog compliance,
//                                      improved readability, reduced redundancy,
//                                      and optimized logic
//
// ---------------------------------------------------------------------------------
//   Descriptions :
//   This module generates various gate driving signals (STV, CPV, OE, XAO, Sync, ACLK)
//   for the ROIC (Readout Integrated Circuit) based on FSM states and register map values.
//   It supports multiple operational modes:
//     * Back bias - initialization mode for detector biasing
//     * Flush - clearing detector charge prior to acquisition
//     * AED (Automatic Exposure Detection) - adaptive exposure control mode
//     * Normal read - standard readout operation
//
//   Key signals:
//     - STV (Start Vertical): Initiates vertical line scanning
//     - CPV (Charge Pump Vertical): Controls vertical charge transfer
//     - OE (Output Enable): Controls data output timing
//     - XAO (eXposure Assist Output): Controls AED mode timing
//     - SYNC: Synchronization signal for ROIC operation
//     - ACLK: Clock signals for analog readout operations
//
// ---------------------------------------------------------------------------------
// `include "./p_define.sv"
`include	"./p_define_refacto.sv"
`timescale 1ns/1ps

module roic_gate_drv_gemini #(
    // Parameters for defining array sizes and logic repetition for better scalability
    parameter int MAX_ACLK_INDEX    = 10,   // Maximum index for ROIC ACLK signals (up_roic_aclk_0 to up_roic_aclk_10)
    parameter int NUM_AED_XAO_LINES = 6     // Number of AED XAO gate signals (gate_xao_0 to gate_xao_5)
) (
    // Clock and Reset Inputs
    input  logic        fsm_clk,                 // 25MHz FSM clock
    input  logic        fsm_drv_rst,             // FSM driver reset

    // FSM and Counter Inputs
    input  logic [15:0] row_cnt,                 // Current row counter, from ctrl_FSM
    input  logic [15:0] col_cnt,                 // Current column counter, from ctrl_FSM
    input  logic        fsm_back_bias_index,     // Back bias mode flag, from ctrl_FSM
    input  logic        fsm_flush_index,         // Flush mode flag, from ctrl_FSM
    input  logic        col_end,                 // Column end signal, from ctrl_FSM

    // Gate/ROIC Parameters from reg_map (these are inputs to this module)
    input  logic [15:0] up_back_bias,            // Upper bound for back bias signal
    input  logic [15:0] dn_back_bias,            // Lower bound for back bias signal

    input  logic [15:0] up_aed_gate_xao [0:5],
    input  logic [15:0] dn_aed_gate_xao [0:5],
    
    // Output Signals
    output logic        back_bias,
    output logic        gate_xao_0,
    output logic        gate_xao_1,
    output logic        gate_xao_2,
    output logic        gate_xao_3,
    output logic        gate_xao_4,
    output logic        gate_xao_5
);

    logic gate_cpv1_reg_internal;
    logic gate_cpv2_reg_internal;

    logic hi_back_bias_internal;
    logic lo_back_bias_internal;
    
    genvar i;
     
    // Back Bias Signal Generation
    assign hi_back_bias_internal = ( (row_cnt == up_back_bias) && fsm_back_bias_index && col_end );
    assign lo_back_bias_internal = ( (row_cnt == dn_back_bias) && fsm_back_bias_index && col_end );

    always @(posedge fsm_clk or negedge fsm_drv_rst) begin
        if (!fsm_drv_rst)
            back_bias <= 1'b0;
        else begin
            if (lo_back_bias_internal)
                back_bias <= 1'b0;
            else if (hi_back_bias_internal)
                back_bias <= 1'b1;
        end
    end


    logic [5:0] flush_gate_xao_reg;
    assign {
        gate_xao_0, gate_xao_1, gate_xao_2, gate_xao_3,
        gate_xao_4, gate_xao_5
    } = {
        flush_gate_xao_reg[0], flush_gate_xao_reg[1], flush_gate_xao_reg[2], flush_gate_xao_reg[3], 
        flush_gate_xao_reg[4], flush_gate_xao_reg[5]
    };

    generate
        for (i = 0; i < NUM_AED_XAO_LINES; i = i + 1) begin : gen_flush_gate_xao
            always @(posedge fsm_clk or negedge fsm_drv_rst) begin
                if (!fsm_drv_rst) begin
                    flush_gate_xao_reg[i] <= 1'b1;
                end else begin
                    if (fsm_flush_index || fsm_back_bias_index) begin
                        if (col_cnt == up_aed_gate_xao[i]) flush_gate_xao_reg[i] <= 1'b1; 
                        else if (col_cnt == dn_aed_gate_xao[i]) flush_gate_xao_reg[i] <= 1'b0;
                    end
                end
            end
        end
    endgenerate

endmodule