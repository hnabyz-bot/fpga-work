module fifo_1b #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 16
) (
    input  logic                  rst,
    input  logic                  clk,
    input  logic                  wr_en,
    input  logic                  rd_en,
    input  logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout,
    output logic                  full,
    output logic                  empty
);

    (* ram_style = "distributed" *) 
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [$clog2(DEPTH):0] wr_ptr, rd_ptr, count;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    // always_ff @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //         wr_ptr <= 0;
    //         rd_ptr <= 0;
    //         count  <= 0;
    //     end else begin
    //         // Write
    //         if (wr_en && !full) begin
    //             mem[wr_ptr] <= din;
    //             wr_ptr <= wr_ptr + 1;
    //             count  <= count + 1;
    //         end
    //         // Read
    //         if (rd_en && !empty) begin
    //             dout <= mem[rd_ptr];
    //             rd_ptr <= rd_ptr + 1;
    //             count  <= count - 1;
    //         end
    //     end
    // end

    logic wr_en_internal, rd_en_internal;
    assign wr_en_internal = wr_en && !full;
    assign rd_en_internal = rd_en && !empty;

    // Memory write (no reset needed for RAM)
    always_ff @(posedge clk) begin
        if (wr_en_internal) begin
            mem[wr_ptr] <= din;
        end
    end

    // Pointer and count management
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
        end else begin
            case ({wr_en_internal, rd_en_internal})
                2'b10: begin  // write only
                    wr_ptr <= wr_ptr + 1'b1;
                    count  <= count + 1'b1;
                end
                2'b01: begin  // read only
                    rd_ptr <= rd_ptr + 1'b1;
                    count  <= count - 1'b1;
                end
                2'b11: begin  // simultaneous read/write
                    wr_ptr <= wr_ptr + 1'b1;
                    rd_ptr <= rd_ptr + 1'b1;
                    // count unchanged
                end
            endcase
        end
    end

    // Read data output
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            dout <= '0;
        end else if (rd_en_internal) begin
            dout <= mem[rd_ptr];
        end
    end

endmodule