//==============================================================================
// Project      : TI-ROIC
// File         : indata_order.sv
// Author       : drake.lee
// Create Date  : 2025-05-12
// Description  : Module for reordering input data.
//                Processes input data and generates reordered output.
//==============================================================================

`timescale 1ns/1ps

module indata_order (
    // Inputs
    input  logic        clk,          // System clock
    input  logic        reset,        // Reset signal
    input  logic        data_valid,   // Input data valid signal
    
    // Outputs
    output logic        out_en,       // Output data valid signal
    output logic [23:0] outdata       // 24-bit output data
);
    // Parameters
    parameter BUFFER_SIZE = 256;
    parameter PATTERN_STEP = 64;      // Pattern step (0,64,128,192,1,65,...)
    parameter PATTERN_GROUPS = 4;     // Number of pattern groups (0,64,128,192)
      // Variables
    reg [23:0] data_buffer [0:BUFFER_SIZE-1]; // Data storage buffer
    int read_count;
    int data_index;
    /* synthesis translate_off */
    string line; // For simulation only
    /* synthesis translate_on */
    int file_in, file_out;
    int out_index;

    // State machine
    typedef enum {IDLE, ACTIVE} state_t;
    state_t state;    // File reading and reordering
    initial begin
        // File opening
        file_in = $fopen("f:/github_work/ti-roic/roic_top/tb_src/input_data.txt", "r");
        if (file_in == 0) begin
            $display("Error: Cannot open input_data.txt");
            $finish;
        end
        
        // Data reading
        read_count = 0;
        while ($fgets(line, file_in) && read_count < BUFFER_SIZE) begin
            // Skip comments
            if (line.substr(0, 1) == "/") continue;
              // Read hexadecimal data
            if ($sscanf(line, "%h", data_buffer[read_count]) == 1) begin
                read_count++;
            end
        end        $fclose(file_in);
        
        // Open output file
        file_out = $fopen("f:/github_work/ti-roic/roic_top/tb_src/output_reordered_data.txt", "w");
        if (file_out == 0) begin
            $display("Error: Cannot open output file");
            $finish;
        end        // Reorder and save according to index pattern (0,64,128,192,1,65,...)
        out_index = 0;
        for (int base = 0; base < PATTERN_STEP; base++) begin
            for (int group = 0; group < PATTERN_GROUPS; group++) begin
                int index = base + (group * PATTERN_STEP);
                if (index < read_count) begin
                    $fdisplay(file_out, "%h", data_buffer[index]);
                    out_index++;
                end
            end
        end
          $fclose(file_out);
    end
    
    // Clock-based operation
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_en <= 0;
            outdata <= 0;
            data_index <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (data_valid) begin
                        state <= ACTIVE;
                        data_index <= 0;
                    end
                    out_en <= 0;
                end                ACTIVE: begin
                    if (data_index < read_count) begin
                        // Convert to pattern 0,64,128,192,1,65,...
                        automatic int base = data_index % PATTERN_STEP;
                        automatic int group = data_index / PATTERN_STEP;
                        automatic int index = base + (group % PATTERN_GROUPS) * PATTERN_STEP;
                        
                        if (index < read_count) begin
                            outdata <= data_buffer[index];
                            out_en <= 1;
                        end else begin
                            out_en <= 0;
                        end
                        
                        data_index <= data_index + 1;
                    end
                    else begin
                        state <= IDLE;
                        out_en <= 0;
                    end
                end
            endcase
        end
    end
    
endmodule
