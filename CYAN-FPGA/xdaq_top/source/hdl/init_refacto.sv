//==============================================================================
// File: init_refacto.sv
// Power Initialization Module (Refactored)
//==============================================================================

`include "./p_define_refacto.sv"
`timescale 1ns/1ps

module init_refacto(
    input  logic        fsm_clk,
    input  logic        reset,
    input  logic        en_pwr_off,
    input  logic        en_pwr_dwn,

    output logic        init_rst,
    output logic        pwr_init_step1,
    output logic        pwr_init_step2,
    output logic        pwr_init_step3,
    output logic        pwr_init_step4,
    output logic        pwr_init_step5,
    output logic        pwr_init_step6,
    output logic        roic_reset
);

    //==========================================================================
    // Internal Signals
    //==========================================================================
    
    // Power Down FSM State Definitions
    typedef enum logic [2:0] {
        DWN_IDLE    = 3'd0,
        DWN_STEP_1  = 3'd1,
        DWN_STEP_2  = 3'd2,
        DWN_STEP_3  = 3'd3,
        DWN_STEP_4  = 3'd4,
        DWN_STEP_5  = 3'd5
    } dwn_state_e;

    dwn_state_e    dwn_curr_state, dwn_next_state;
    logic [24:0]   dwn_delay;
    
    // FSM State Definitions
    typedef enum logic [2:0] {
        INIT_IDLE    = 3'd0,
        INIT_STEP_1  = 3'd1,
        INIT_STEP_2  = 3'd2,
        INIT_STEP_3  = 3'd3,
        INIT_STEP_4  = 3'd4,
        INIT_STEP_5  = 3'd5,
        INIT_STEP_6  = 3'd6
    } init_state_e;

    init_state_e init_curr_state, init_next_state;
    logic [24:0] init_delay;
    
    // Power On/Off Control
    logic [1:0]     en_pwr_off_sync;
    logic           start_pwr_off;
    logic           start_pwr_on;
    logic           pwr_direction;
    
    // Power Init Signals
    logic           init_step1;
    logic           init_step2;
    logic           init_step3;
    logic           init_step4;
    logic           init_step5;
    logic           init_step6;

    // Power Down Control
    logic [1:0]     en_pwr_dwn_sync;
    logic           start_pwr_dwn_on;
    logic           start_pwr_dwn_off;
    logic           dwn_direction;

    // Power Down Signals
    logic           pwr_dwn_step1;
    logic           pwr_dwn_step2;
    logic           pwr_dwn_step3;
    logic           pwr_dwn_step4;
    logic           pwr_dwn_step5;

    //==========================================================================
    // Power Init Step Signal Generation
    //==========================================================================
    always_comb begin
        init_step1 = (init_curr_state == INIT_STEP_1);
        init_step2 = (init_curr_state == INIT_STEP_2);
        init_step3 = (init_curr_state == INIT_STEP_3);
        init_step4 = (init_curr_state == INIT_STEP_4);
        init_step5 = (init_curr_state == INIT_STEP_5);
        init_step6 = (init_curr_state == INIT_STEP_6);
    end

    //==========================================================================
    // Power Down Step Signal Generation
    //==========================================================================
    always_comb begin
        pwr_dwn_step1 = (dwn_curr_state == DWN_STEP_1);
        pwr_dwn_step2 = (dwn_curr_state == DWN_STEP_2);
        pwr_dwn_step3 = (dwn_curr_state == DWN_STEP_3);
        pwr_dwn_step4 = (dwn_curr_state == DWN_STEP_4);
        pwr_dwn_step5 = (dwn_curr_state == DWN_STEP_5);
    end
    
    // System Reset Control
    logic [1:0]     init_step6_sync;
    logic           hi_init_rst;
    logic           sig_init_rst;
    
    // ROIC Reset Control
    logic [4:0]     step_delay_sr;

    //==========================================================================
    // Output Assignments
    //==========================================================================
    assign pwr_init_step1 = init_step1 & pwr_dwn_step1;
    assign pwr_init_step2 = init_step2 & pwr_dwn_step2;
    assign pwr_init_step3 = init_step3 & pwr_dwn_step3;
    assign pwr_init_step4 = init_step4 & pwr_dwn_step4;
    assign pwr_init_step5 = init_step5 & pwr_dwn_step5;
    assign pwr_init_step6 = init_step6;
    assign init_rst       = sig_init_rst;
    assign roic_reset     = step_delay_sr[0] & (~step_delay_sr[4]);


    //==========================================================================
    // Power On/Off Control - Edge Detection
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            en_pwr_off_sync <= 2'b0;
        else
            en_pwr_off_sync <= {en_pwr_off_sync[0], en_pwr_off};
    end

    assign start_pwr_off = en_pwr_off_sync[0] & (~en_pwr_off_sync[1]) & (init_curr_state == INIT_STEP_6);
    assign start_pwr_on  = (~en_pwr_off_sync[0]) & en_pwr_off_sync[1] & (init_curr_state == INIT_IDLE);

    //==========================================================================
    // Power On/Off Direction Control
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset) begin
            pwr_direction <= 1'b0;  // Default: Power ON
        end else if (start_pwr_on) begin
            pwr_direction <= 1'b0;  // Power ON
        end else if (start_pwr_off) begin
            pwr_direction <= 1'b1;  // Power OFF
        end
    end

    //==========================================================================
    // Power Init FSM - State Register
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            init_curr_state <= INIT_IDLE;
        else
            init_curr_state <= init_next_state;
    end

    //==========================================================================
    // Power Init FSM - Next State Logic
    //==========================================================================
    always_comb begin
        init_next_state = init_curr_state;
        
        case (init_curr_state)
            INIT_IDLE: begin
                if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_1)))
                    init_next_state = INIT_STEP_1;
            end
            
            INIT_STEP_1: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_IDLE)))
                    init_next_state = INIT_IDLE;
                else if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_2)))
                    init_next_state = INIT_STEP_2;
            end
            
            INIT_STEP_2: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_1)))
                    init_next_state = INIT_STEP_1;
                else if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_3)))
                    init_next_state = INIT_STEP_3;
            end
            
            INIT_STEP_3: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_2)))
                    init_next_state = INIT_STEP_2;
                else if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_4)))
                    init_next_state = INIT_STEP_4;
            end
            
            INIT_STEP_4: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_3)))
                    init_next_state = INIT_STEP_3;
                else if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_5)))
                    init_next_state = INIT_STEP_5;
            end
            
            INIT_STEP_5: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_4)))
                    init_next_state = INIT_STEP_4;
                else if (!pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_6)))
                    init_next_state = INIT_STEP_6;
            end
            
            INIT_STEP_6: begin
                if (pwr_direction && (init_delay >= get_init_delay(init_curr_state, INIT_STEP_5)))
                    init_next_state = INIT_STEP_5;
            end
            
            default: init_next_state = INIT_IDLE;
        endcase
    end

    //==========================================================================
    // Power Init FSM - Delay Counter
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            init_delay <= 25'd0;
        else if (init_curr_state != init_next_state)
            init_delay <= 25'd0;
        else
            init_delay <= init_delay + 25'd1;
    end

    //==========================================================================
    // Power Down Control - Edge Detection
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            en_pwr_dwn_sync <= 2'b0;
        else
            en_pwr_dwn_sync <= {en_pwr_dwn_sync[0], en_pwr_dwn};
    end

    assign start_pwr_dwn_on  = en_pwr_dwn_sync[0] & (~en_pwr_dwn_sync[1]) & (dwn_curr_state == DWN_STEP_5);
    assign start_pwr_dwn_off = (~en_pwr_dwn_sync[0]) & en_pwr_dwn_sync[1] & (dwn_curr_state == DWN_IDLE);

    //==========================================================================
    // Power Down Direction Control
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset) begin
            dwn_direction <= 1'b0;  // Default: Power down OFF
        end else if (start_pwr_dwn_off) begin
            dwn_direction <= 1'b0;  // Power down OFF (going to step 1-5)
        end else if (start_pwr_dwn_on) begin
            dwn_direction <= 1'b1;  // Power down ON (going to idle)
        end
    end

    //==========================================================================
    // Power Down FSM - State Register
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            dwn_curr_state <= DWN_STEP_5;
        else
            dwn_curr_state <= dwn_next_state;
    end

    //==========================================================================
    // Power Down FSM - Next State Logic
    //==========================================================================
    always_comb begin
        dwn_next_state = dwn_curr_state;
        
        case (dwn_curr_state)
            DWN_IDLE: begin
                if (!dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_1)))
                    dwn_next_state = DWN_STEP_1;
            end
            
            DWN_STEP_1: begin
                if (dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_IDLE)))
                    dwn_next_state = DWN_IDLE;
                else if (!dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_2)))
                    dwn_next_state = DWN_STEP_2;
            end
            
            DWN_STEP_2: begin
                if (dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_1)))
                    dwn_next_state = DWN_STEP_1;
                else if (!dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_3)))
                    dwn_next_state = DWN_STEP_3;
            end
            
            DWN_STEP_3: begin
                if (dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_2)))
                    dwn_next_state = DWN_STEP_2;
                else if (!dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_4)))
                    dwn_next_state = DWN_STEP_4;
            end
            
            DWN_STEP_4: begin
                if (dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_3)))
                    dwn_next_state = DWN_STEP_3;
                else if (!dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_5)))
                    dwn_next_state = DWN_STEP_5;
            end
            
            DWN_STEP_5: begin
                if (dwn_direction && (dwn_delay >= get_dwn_delay(dwn_curr_state, DWN_STEP_4)))
                    dwn_next_state = DWN_STEP_4;
            end
            
            default: dwn_next_state = DWN_IDLE;
        endcase
    end

    //==========================================================================
    // Power Down FSM - Delay Counter
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            dwn_delay <= 25'd0;
        else if (dwn_curr_state != dwn_next_state)
            dwn_delay <= 25'd0;
        else
            dwn_delay <= dwn_delay + 25'd1;
    end

    //==========================================================================
    // System Reset Generation
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            init_step6_sync <= 2'b0;
        else
            init_step6_sync <= {init_step6_sync[0], (init_curr_state == INIT_STEP_6)};
    end

    assign hi_init_rst = init_step6_sync[0] & (~init_step6_sync[1]);

    always_ff @(posedge fsm_clk) begin
        if (reset)
            sig_init_rst <= 1'b1;
        else if (hi_init_rst)
            sig_init_rst <= 1'b0;
    end

    //==========================================================================
    // ROIC Reset Pulse Generation
    //==========================================================================
    always_ff @(posedge fsm_clk) begin
        if (reset)
            step_delay_sr <= 5'b0;
        else
            step_delay_sr <= {step_delay_sr[3:0], ((init_curr_state == INIT_STEP_5) & pwr_init_step5)};
    end

    //==========================================================================
    // Delay Lookup Functions for FSMs
    //==========================================================================
    function automatic logic [24:0] get_init_delay(init_state_e curr, init_state_e next);
        // Example: Return different delays for each state transition
        case ({curr, next})
            {INIT_IDLE,   INIT_STEP_1}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_1, INIT_STEP_2}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_2, INIT_STEP_3}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_3, INIT_STEP_4}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_4, INIT_STEP_5}: get_init_delay = `MORE_DELAY;
            {INIT_STEP_5, INIT_STEP_6}: get_init_delay = `INIT_DELAY;
            // Power-off transitions
            {INIT_STEP_1, INIT_IDLE}:   get_init_delay = `INIT_DELAY;
            {INIT_STEP_2, INIT_STEP_1}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_3, INIT_STEP_2}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_4, INIT_STEP_3}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_5, INIT_STEP_4}: get_init_delay = `INIT_DELAY;
            {INIT_STEP_6, INIT_STEP_5}: get_init_delay = `INIT_DELAY;
            default: get_init_delay = `INIT_DELAY;
        endcase
    endfunction

    function automatic logic [24:0] get_dwn_delay(dwn_state_e curr, dwn_state_e next);
        // Example: Return different delays for each state transition
        case ({curr, next})
            {DWN_IDLE,   DWN_STEP_1}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_1, DWN_STEP_2}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_2, DWN_STEP_3}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_3, DWN_STEP_4}: get_dwn_delay = `MORE_DELAY;
            {DWN_STEP_4, DWN_STEP_5}: get_dwn_delay = `MORE_DELAY;
            // Power-up transitions
            {DWN_STEP_1, DWN_IDLE}:   get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_2, DWN_STEP_1}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_3, DWN_STEP_2}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_4, DWN_STEP_3}: get_dwn_delay = `INIT_DELAY;
            {DWN_STEP_5, DWN_STEP_4}: get_dwn_delay = `INIT_DELAY;
            default: get_dwn_delay = 25'd120;
        endcase
    endfunction

    //==========================================================================
    // Assertions for Verification
    //==========================================================================
    `ifndef SYNTHESIS
    
    // Power Init FSM assertions
    property init_state_transition;
        @(posedge fsm_clk) (init_curr_state != init_next_state) |-> (init_delay >= `INIT_DELAY);
    endproperty
    assert property (init_state_transition)
        else $error("[INIT] State transition without sufficient delay: state=%0d, delay=%0d", 
                    init_curr_state, init_delay);
    
    property init_counter_reset;
        @(posedge fsm_clk) (init_curr_state != init_next_state) |=> (init_delay == 25'd0);
    endproperty
    assert property (init_counter_reset)
        else $error("[INIT] Delay counter not reset on state change");
    
    property init_sequential_power_on;
        @(posedge fsm_clk) (!pwr_direction && init_curr_state == INIT_STEP_1) |-> 
            ##[1:$] (init_curr_state == INIT_STEP_2);
    endproperty
    
    property init_no_skip_states;
        @(posedge fsm_clk) disable iff (pwr_direction)
            (init_curr_state == INIT_STEP_2) |=> 
            (init_curr_state == INIT_STEP_2) || (init_curr_state == INIT_STEP_3) || (init_curr_state == INIT_STEP_1);
    endproperty
    assert property (init_no_skip_states)
        else $error("[INIT] Invalid state skip detected");
    
    // Power Down FSM assertions
    property dwn_state_transition;
        @(posedge fsm_clk) (dwn_curr_state != dwn_next_state) |-> (dwn_delay >= `INIT_DELAY);
    endproperty
    assert property (dwn_state_transition)
        else $error("[DWN] State transition without sufficient delay: state=%0d, delay=%0d", 
                    dwn_curr_state, dwn_delay);
    
    property dwn_counter_reset;
        @(posedge fsm_clk) (dwn_curr_state != dwn_next_state) |=> (dwn_delay == 25'd0);
    endproperty
    assert property (dwn_counter_reset)
        else $error("[DWN] Delay counter not reset on state change");
    
    // Output step assertions
    property init_step_valid;
        @(posedge fsm_clk) pwr_init_step1 || pwr_init_step2 || pwr_init_step3 || 
                           pwr_init_step4 || pwr_init_step5 || pwr_init_step6;
    endproperty
    
    property init_step_exclusive;
        @(posedge fsm_clk) $onehot0({pwr_init_step1, pwr_init_step2, pwr_init_step3, 
                                      pwr_init_step4, pwr_init_step5, pwr_init_step6});
    endproperty
    assert property (init_step_exclusive)
        else $error("[INIT] Multiple init steps active simultaneously");
    
    // Timing constraint assertions
    property init_max_delay;
        @(posedge fsm_clk) init_delay <= (`MORE_DELAY + 25'd100);
    endproperty
    assert property (init_max_delay)
        else $error("[INIT] Delay counter overflow: delay=%0d", init_delay);
    
    property dwn_max_delay;
        @(posedge fsm_clk) dwn_delay <= (`MORE_DELAY + 25'd100);
    endproperty
    assert property (dwn_max_delay)
        else $error("[DWN] Delay counter overflow: delay=%0d", dwn_delay);
    
    // ROIC reset pulse width assertion
    property roic_reset_width;
        @(posedge fsm_clk) $rose(roic_reset) |-> ##[1:5] $fell(roic_reset);
    endproperty
    assert property (roic_reset_width)
        else $error("[ROIC] Reset pulse width out of range");
    
    `endif

endmodule
