`timescale 1ns / 1ps

// Wave dumping control
`ifdef ENABLE_WAVES
    `define DUMP_WAVES
`endif

// Define SERIAL_PERIOD macro
`define SERIAL_PERIOD 5000

/**
 * @file deser_single_DUT_tb.sv
 * @brief Testbench for the deser_single_lane module with a serializer.
 *
 * This testbench verifies the functionality of the deser_single_lane module
 * by using a serializer to generate serial data from 24-bit parallel input.
 * Wave dumping can be enabled by defining ENABLE_WAVES.
 */

module deser_single_tb;
    // Parameters
    localparam WORD_SIZE = 24;
    localparam RESET_CYCLES = 100;     // Reset period
    localparam IDELAY_TAP = 5'h10;   // Fixed IDELAY tap value

    // Test patterns
    typedef struct {
        logic [23:0] pattern;
        string description;
    } test_pattern_t;

    test_pattern_t test_patterns[] = '{
        '{24'hAAAAAA, "Alternating pattern"},
        '{24'hFFFF00, "Constant high then low"},
        '{24'h000FF0, "Single pulse pattern"},
        '{24'h555555, "Clock-like pattern"},
        '{24'hFFF000, "Standard sync pattern"}
    };

    // Test signals
    reg [WORD_SIZE-1:0] data_in;
    reg clk;
    reg rst;
    reg ld_dly_tap;
    reg in_delay_data_ce;
    reg in_delay_data_inc;
    reg [4:0] in_delay_tap_in;

    wire [4:0] in_delay_tap_out;
    wire data_in_from_pins_p;
    wire data_in_from_pins_n;
    wire dclk_p, dclk_n;
    wire fclk_p, fclk_n;
    wire [WORD_SIZE-1:0] data_in_to_device;

    // Clock generation
    initial begin
        clk = 0;
        forever #(`SERIAL_PERIOD/2) clk = ~clk;
    end

    // Divided clock for ISERDESE2
    reg [1:0] div4_counter;
    wire clk_div;

    // Simple clock divider
    always @(posedge clk or posedge rst) begin
        if (rst)
            div4_counter <= 2'b00;
        else
            div4_counter <= div4_counter + 1;
    end

    assign clk_div = div4_counter[1];  // Divide by 4

    // Serializer instantiation
    serializer #(
        .WORD_SIZE          (WORD_SIZE)
    ) serializer_inst (
        .clk                (clk),
        .rst                (rst),
        .data_in            (data_in),
        .data_out_p         (data_in_from_pins_p),
        .data_out_n         (data_in_from_pins_n),
        .dclk_p             (dclk_p),
        .dclk_n             (dclk_n),
        .fclk_p             (fclk_p),
        .fclk_n             (fclk_n)
    );

    // DUT instantiation
    deser_single_lane #(
        .DEV_W              (8),
        .WORD_SIZE          (WORD_SIZE),
        .IOSTANDARD         ("LVDS_25"),
        .REFCLK_FREQ        (200.0)
    ) dut (
        .data_in_from_pins_p   (data_in_from_pins_p),
        .data_in_from_pins_n   (data_in_from_pins_n),
        .clk_in_int_buf       (dclk_p),         // Use dclk_p as the high-speed bit clock
        .clk_div              (clk_div),
        .fclk_p               (fclk_p),
        .rst                  (rst),
        .ld_dly_tap           (ld_dly_tap),
        .in_delay_data_ce     (in_delay_data_ce),
        .in_delay_data_inc    (in_delay_data_inc),
        .in_delay_tap_in      (in_delay_tap_in),
        .in_delay_tap_out     (in_delay_tap_out),
        .data_in_to_device     (data_in_to_device)
    );

    // Test statistics
    int total_tests = 0;
    int passed_tests = 0;
    int failed_tests = 0;

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        data_in = 0;
        ld_dly_tap = 0;
        in_delay_data_ce = 0;
        in_delay_data_inc = 0;
        in_delay_tap_in = IDELAY_TAP;

        // Reset for proper initialization
        #(`SERIAL_PERIOD * RESET_CYCLES);

        // Release reset and wait for clock stabilization
        rst = 0;
        #(`SERIAL_PERIOD * 200); // Increased stabilization time

        // IDELAY tap value setup
        ld_dly_tap = 1;
        #(`SERIAL_PERIOD * 20);
        ld_dly_tap = 0;
        #(`SERIAL_PERIOD * 200); // Increased time after IDELAY setup

        // Run all test patterns
        foreach (test_patterns[i]) begin
            $display("\n=== Testing Pattern: %s ===", test_patterns[i].description);
            data_in = test_patterns[i].pattern;
            #(`SERIAL_PERIOD * WORD_SIZE * 2 + `SERIAL_PERIOD * 500); // Wait for full serialization and deserialization

            // Monitor output after sufficient delay
            #(`SERIAL_PERIOD * WORD_SIZE * 2 + `SERIAL_PERIOD * 200);
            if (data_in_to_device == test_patterns[i].pattern) begin
                $display("SUCCESS: Pattern %h verified", test_patterns[i].pattern);
                passed_tests++;
            end else begin
                $display("FAIL: Pattern %h, expected %h, received %h", test_patterns[i].pattern, test_patterns[i].pattern, data_in_to_device);
                failed_tests++;
            end
            total_tests++;
        end

        $display("\n=== Test Summary ===");
        $display("Total Tests: %0d", total_tests);
        $display("Passed Tests: %0d", passed_tests);
        $display("Failed Tests: %0d", failed_tests);

        if (failed_tests == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end

    // Monitor data changes
    always @(data_in_to_device) begin
        $display("Time=%0t: Output data changed to %h", $time, data_in_to_device);
    end

    `ifdef DUMP_WAVES
        initial begin
            $dumpfile("deser_single_tb.vcd");
            $dumpvars(0, deser_single_tb);
            $dumpvars(0, serializer_inst);
            $dumpvars(0, dut);
        end
    `endif

endmodule

// Serializer module (unchanged from previous)
module serializer #(
    parameter WORD_SIZE = 24
)(
    input logic clk,      // High-speed bit clock (200MHz)
    input logic rst,
    input logic [WORD_SIZE-1:0] data_in,
    output logic data_out_p,
    output logic data_out_n,
    output logic dclk_p,
    output logic dclk_n,
    output logic fclk_p,
    output logic fclk_n
);
    reg [WORD_SIZE-1:0] s_current_word;
    // Counter for bit pairs (since we send two bits per clk cycle)
    // Counts from 0 to (WORD_SIZE/2 - 1)
    reg [$clog2(WORD_SIZE/2)-1:0] s_bit_pair_idx; 
    
    reg dclk_int_reg, fclk_int_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s_current_word <= '0;
            s_bit_pair_idx <= 0;
            dclk_int_reg <= 1'b0;
            fclk_int_reg <= 1'b0;
        end else begin
            dclk_int_reg <= ~dclk_int_reg; // dclk toggles every main clk cycle

            // Load new word and toggle frame clock at the start of processing pair 0
            if (s_bit_pair_idx == 0) begin 
                s_current_word <= data_in;
                fclk_int_reg <= ~fclk_int_reg;
            end

            // Advance to the next bit pair for the next clk cycle
            if (s_bit_pair_idx == (WORD_SIZE/2 - 1)) begin
                s_bit_pair_idx <= 0;
            end else begin
                s_bit_pair_idx <= s_bit_pair_idx + 1;
            end
        end
    end
    
    // Output assignments for DDR
    // s_bit_pair_idx holds the index of the PAIR whose bits are being driven in the current clk cycle's phases.
    // It updates at posedge clk for the *next* cycle, so for assign, it represents the current cycle's pair index.
    assign data_out_p = clk ? s_current_word[WORD_SIZE-1 - (s_bit_pair_idx * 2)]     // Posedge bit (first bit of the pair)
                            : s_current_word[WORD_SIZE-1 - (s_bit_pair_idx * 2 + 1)]; // Negedge bit (second bit of the pair)
    assign data_out_n = ~data_out_p;
    
    assign dclk_p = dclk_int_reg; 
    assign dclk_n = ~dclk_int_reg;

    assign fclk_p = fclk_int_reg;
    assign fclk_n = ~fclk_int_reg;


endmodule
