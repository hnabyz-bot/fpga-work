`timescale 1ns / 1ps

/**
 * @file slave_spi.sv
 * @brief SPI Slave module for testing roic_spi.
 * 
 * This module emulates the behavior of a slave SPI device, such as TI's AFE2256.
 * It receives SPI commands from the master (roic_spi) and responds with predefined data.
 */

module roic_slave_spi (
    input  logic        reset,          // Reset signal (active high)
    input  logic        clk,            // Clock signal (from SPI master)
    input  logic        SEN,            // Chip select signal (active low)
    input  logic        SDATA,          // Serial data input from SPI master
    output logic        SDOUT           // Serial data output to SPI master
);

    // Internal signals
    logic [23:0] shift_register;        // Shift register for SPI data
    logic [7:0] response_addr;         // Predefined response data
    logic [15:0] response_data;         // Predefined response data
    logic [4:0] bit_counter;            // Counter for tracking SPI bits


    // SPI Slave behavior
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all internal signals
            shift_register <= 24'b0;
            bit_counter <= 5'd0;
            SDOUT <= 1'b0;
        end else if (!SEN) begin
            // SPI transaction active (SEN is active low)
            shift_register <= {shift_register[22:0], SDATA}; // Shift in data
            bit_counter <= bit_counter + 1;

        //     if (bit_counter == 5'd23) begin
        //         // Full word received (24 bits)
        //         // bit_counter <= 5'd0;
        //    end
        end else begin
            // SPI transaction inactive
            bit_counter <= 5'd0;
        end
    end

    assign response_addr = (bit_counter == 5'd24) ? shift_register[23:16] : response_addr;    // address check
    assign response_data = (bit_counter == 5'd24) ? shift_register[15:0] : response_data;    // address check

    assign SDOUT = shift_register[0];                         // Output the response data

endmodule