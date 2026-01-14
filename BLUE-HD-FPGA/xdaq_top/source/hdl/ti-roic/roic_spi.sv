`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        [Your Company Name]
// Engineer:       [Your Name]
// 
// Create Date:    [Creation Date, e.g., 04/18/2025]
// Design Name:    roic_spi
// Module Name:    roic_spi
// Project Name:   [Project Name, e.g., TI-ROIC Synchronization]
// Target Devices: [Target FPGA/ASIC, e.g., Xilinx, Intel FPGA]
// Tool Versions:  [Tool Version, e.g., Vivado 2023.1]
// 
// Description: 
// This testbench verifies the functionality of the `roic_spi` modules.
// It applies various input conditions and observes the outputs to ensure correct behavior.
// 
// Dependencies: 
// - roic_spi.sv
// 
// Revision History:
// Revision 0.01 - File Created
// Revision 0.02 - Added support for `roic_spi` module testing
// Revision 0.03 - 
// 
// Additional Comments:
// - Ensure that the clock frequency matches the target design requirements.
// - Modify the test cases as needed to cover additional scenarios.
// 
//////////////////////////////////////////////////////////////////////////////////

module roic_spi (
    input  logic        reset,                      // Reset signal (active high)
    input  logic        clk,                        // Clock signal
    input  logic [7:0]  address,                    // Address input for SPI communication
    input  logic [15:0] data,                       // Data input for SPI communication
    input  logic        DUT_EN,                     // Enable signal for SPI communication
    input  logic        spiReady,                   // SPI ready signal (indicates readiness for transaction)
    input  logic [11:0] DUT_SDOUT,                  // Serial data output from DUT
    output logic        DUT_SCLK,                   // Serial clock output to DUT
    output logic [0:0] DUT_SDATA,                  // Serial data output to DUT
//    output logic [11:0] DUT_SDATA,                  // Serial data output to DUT
    output logic        DUT_SEN,                    // Chip select signal for DUT
    output logic [191:0] sdoutWord                  // Combined output word from SPI transactions
);

    // State machine states
    typedef enum logic [1:0] {waitForReady, transmitSPI} state_type;
    state_type state = waitForReady;                // Current state of the state machine

    // Internal signals
    localparam int WORD_SIZE = 24;                  // SPI word size (address + data)
    localparam logic [4:0] COUNTER_INIT = 5'd24;    // Initial counter value (24)
    logic [4:0] wordCounter ; // = COUNTER_INIT;         // Counter for SPI word transmission
    logic [WORD_SIZE-1:0] spiWord ; // = '0;             // SPI word to be transmitted
    logic [191:0] int_sdoutWord ; // = '0;               // Internal storage for output word
    logic rxSEN, deviceSDATA;           // Internal signals for SPI control
    logic [3:0] spiReadyDly ; // = 4'b0;                 // Delayed versions of the spiReady signal for edge detection

    // Generate the SPI clock signal
    assign DUT_SCLK = (state == transmitSPI) ? ~clk : 1'b0;

    // Main process for SPI state machine
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all signals to their initial states
            rxSEN <= 1'b1;                          // Deassert chip select
            deviceSDATA <= 1'b0;                    // Clear data output
            state <= waitForReady;                  // Set initial state
            spiWord <= 24'd0;                          // Clear SPI word
            wordCounter <= COUNTER_INIT;            // Initialize word counter
            spiReadyDly <= 4'd0;
        end else begin
            // Shift the spiReady signal for edge detection
            spiReadyDly <= {spiReadyDly[2:0], spiReady};

            case (state)
                waitForReady: begin
                    // Wait for the rising edge of spiReady
                    if (spiReadyDly[2] == 1'b0 && spiReadyDly[3] == 1'b1) begin
                        state <= transmitSPI;       // Transition to transmit state
                        wordCounter <= COUNTER_INIT; // Reset word counter
                        spiWord <= {address, data}; // Load address and data into SPI word
                    end else begin
                        rxSEN <= 1'b1;              // Deassert chip select
                        deviceSDATA <= 1'b0;        // Clear data output
                    end
                end

                transmitSPI: begin
                    rxSEN <= 1'b0;                  // Assert chip select
                    if (wordCounter == 5'd0) begin
                        // Transmission complete
                        state <= waitForReady;      // Return to waitForReady state
                        deviceSDATA <= 1'b0;        // Clear data output
                        rxSEN <= 1'b1;              // Deassert chip select
                    end else begin
                        // Transmit the next bit
                        wordCounter <= wordCounter - 1'b1; // Decrement word counter
                        deviceSDATA <= spiWord[WORD_SIZE-1]; // Output the MSB
                        spiWord <= {spiWord[WORD_SIZE-2:0], 1'b0}; // Shift left and append 0
                    end
                end
            endcase
        end
    end

    // Process for capturing SPI output data
    always_ff @(negedge clk or posedge reset) begin
        if (reset) begin
            // Reset output word
            sdoutWord <= '0;
            int_sdoutWord <= '0;
        end else if (state == transmitSPI) begin
            // Capture data from DUT_SDOUT into int_sdoutWord
            for (int i = 0; i < 12; i++) begin
                int_sdoutWord[(i+1)*16-1 -: 16] <= {int_sdoutWord[(i+1)*16-2 -: 15], DUT_SDOUT[i]};
            end
        end else begin
            // Update the output word
            sdoutWord <= int_sdoutWord;
        end
    end

    // Assign outputs
//    assign DUT_SDATA = {12{deviceSDATA & DUT_EN}};   // Enable data output
    assign DUT_SDATA[0] = {deviceSDATA & DUT_EN};   // Enable data output
    assign DUT_SEN = ~DUT_EN | rxSEN;               // Generate chip select signal

endmodule