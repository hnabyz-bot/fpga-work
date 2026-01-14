`timescale 1ns / 1ps

/**
 * @file roic_spi_tb.sv
 * @brief Testbench for the roic_spi module.
 * 
 * This testbench verifies the functionality of the `roic_spi` module by performing
 * various test cases, including basic SPI transactions, reset behavior, and file-based
 * input testing using a CSV file.
 */

module roic_spi_tb;

    // Testbench signals
    /** @brief Reset signal (active high). */
    logic reset;

    /** @brief Clock signal. */
    logic clk;

    /** @brief Address input for SPI communication. */
    logic [7:0] address;

    /** @brief Data input for SPI communication. */
    logic [15:0] data;

    /** @brief Enable signal for SPI communication. */
    logic DUT_EN;

    /** @brief SPI ready signal (indicates readiness for transaction). */
    logic spiReady;

    /** @brief Serial data output from DUT. */
    logic [11:0] DUT_SDOUT;

    /** @brief Serial clock output to DUT. */
    logic DUT_SCLK;

    /** @brief Serial data output to DUT. */
    logic [11:0] DUT_SDATA;

    /** @brief Chip select signal for DUT. */
    logic DUT_SEN;

    /** @brief Combined output word from SPI transactions. */
    logic [191:0] sdoutWord;

    /**
     * @brief Clock generation process.
     * 
     * Generates a 100MHz clock signal with a 10ns period.
     */
    initial begin
        clk = 0;
        forever #50 clk = ~clk; // 100ns clock period (10MHz)
    end

    /**
     * @brief Instantiate the Device Under Test (DUT).
     */
    roic_spi master (
        .reset(reset),
        .clk(clk),
        .address(address),
        .data(data),
        .DUT_EN(DUT_EN),
        .spiReady(spiReady),
        .DUT_SDOUT(DUT_SDOUT),
        .DUT_SCLK(DUT_SCLK),
        .DUT_SDATA(DUT_SDATA),
        .DUT_SEN(DUT_SEN),
        .sdoutWord(sdoutWord)
    );

    /**
     * @brief Instantiate the SPI Slave (slave_spi).
     */
    roic_slave_spi slave (
        .reset(reset),
        .clk(DUT_SCLK),        // Connect to master's clock
        .SEN(DUT_SEN),         // Connect to master's chip select
        .SDATA(DUT_SDATA[0]),     // Connect to master's data output
        .SDOUT(DUT_SDOUT[0])      // Connect to master's data input
    );


    /**
     * @brief Perform a write operation.
     * 
     * @param addr Address to write to.
     * @param dat Data to write.
     */
    task write_task(input logic [7:0] addr, input logic [15:0] dat);
        begin
            $display("Time: %0t | Performing WRITE: Address = 0x%0h, Data = 0x%0h", $time, addr, dat);
            address = addr;         // Set the address
            data = dat;             // Set the data
            DUT_EN = 1;             // Enable the DUT
            #10 spiReady = 1;       // Trigger SPI transaction
            #10 spiReady = 0;       // Deassert spiReady
            #300;                   // Wait for transaction to complete
        end
    endtask

    /**
     * @brief Perform a read operation.
     * 
     * @param read_data Captures the output word from the DUT.
     */
    task read_task(output logic [191:0] read_data);
        begin
            $display("Time: %0t | Performing READ", $time);
            read_data = sdoutWord;  // Capture the output word
            $display("Time: %0t | READ Data = 0x%0h", $time, read_data);
        end
    endtask

    /**
     * @brief Perform transactions based on a CSV file.
     * 
     * Reads address and data pairs from a CSV file and performs write and read operations.
     * 
     * @param filename Name of the CSV file containing address and data pairs.
     */
    task csv_based_test(input string filename);
        integer file;
        string line;
        logic [7:0] csv_address;
        logic [15:0] csv_data;

        begin
            file = $fopen(filename, "r"); // Open the file in read mode
            if (file == 0) begin
                $display("ERROR: Unable to open file: %s", filename);
                $finish;
            end

            $display("INFO: Starting CSV-based test using file: %s", filename);
            while (!$feof(file)) begin
                line = "";
                void'($fgets(line, file)); // Read a line from the file
                if (line != "") begin
                    if ($sscanf(line, "%h,%h", csv_address, csv_data) == 2) begin
                        write_task(csv_address, csv_data); // Perform write operation
                        read_task(sdoutWord);             // Perform read operation
                    end else begin
                        $display("ERROR: Invalid data format in file: %s", filename);
                        $finish;
                    end
                end
            end

            $fclose(file); // Close the file
            $display("INFO: CSV-based test completed.");
        end
    endtask

    /**
     * @brief Testbench stimulus.
     * 
     * Executes various test cases, including basic SPI transactions, reset behavior,
     * and file-based input testing.
     */
    initial begin
        // Initialize signals
        reset = 1;
        address = 8'h00;
        data = 16'h0000;
        DUT_EN = 0;
        spiReady = 0;
        // DUT_SDOUT = 12'h000;

        // Apply reset
        #20 reset = 0;

        // Test case 1: Basic SPI transaction
        write_task(8'hA5, 16'h1234); // Write Address: 0xA5, Data: 0x1234
        read_task(sdoutWord);        // Read back the data

        // Test case 2: Another SPI transaction
        write_task(8'h5A, 16'h5678); // Write Address: 0x5A, Data: 0x5678
        read_task(sdoutWord);        // Read back the data

        // Test case 3: Reset during operation
        #50 reset = 1;
        #20 reset = 0;

        // Test case 4: Additional SPI transaction
        write_task(8'hFF, 16'hABCD); // Write Address: 0xFF, Data: 0xABCD
        read_task(sdoutWord);        // Read back the data

        // Test case 5: CSV-based test
        csv_based_test("test_data.csv"); // Provide the CSV file name containing address and data pairs

        // End simulation
        #500 $finish;
    end

    /**
     * @brief Monitor outputs.
     * 
     * Continuously monitors and displays the state of key signals during simulation.
     */
    initial begin
        $monitor("Time: %0t | reset: %b | DUT_EN: %b | spiReady: %b | DUT_SCLK: %b | DUT_SDATA: %h | DUT_SEN: %b | sdoutWord: %h",
                 $time, reset, DUT_EN, spiReady, DUT_SCLK, DUT_SDATA, DUT_SEN, sdoutWord);
    end

endmodule