module fifo_1b #(
    parameter int DATA_WIDTH = 8,
    parameter int DEPTH = 16   // MUST be a power of two
) (
    input  logic                  wr_clk,   // write clock domain
    input  logic                  wr_rst,   // write domain reset (active high)
    input  logic                  rd_clk,   // read clock domain
    input  logic                  rd_rst,   // read domain reset (active high)
    input  logic                  wr_en,
    input  logic                  rd_en,
    input  logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout,
    output logic                  full,
    output logic                  empty
);

    // address width for DEPTH entries
    localparam int ADDR_W = $clog2(DEPTH);
    // memory storage
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // write domain pointers (binary + gray)
    logic [ADDR_W:0] wr_bin, wr_bin_next;
    logic [ADDR_W:0] wr_gray, wr_gray_next;
    logic [ADDR_W-1:0] wr_addr;

    // read domain pointers (binary + gray)
    logic [ADDR_W:0] rd_bin, rd_bin_next;
    logic [ADDR_W:0] rd_gray, rd_gray_next;
    logic [ADDR_W-1:0] rd_addr;

    // synchronizers for cross-domain pointer transfer
    logic [ADDR_W:0] rd_gray_sync_w1, rd_gray_sync_w2; // rd -> wr
    logic [ADDR_W:0] wr_gray_sync_r1, wr_gray_sync_r2; // wr -> rd

    // read data register
    logic [DATA_WIDTH-1:0] dout_reg;

    // binary to gray
    function automatic logic [ADDR_W:0] bin2gray(input logic [ADDR_W:0] b);
        bin2gray = b ^ (b >> 1);
    endfunction

    // ---------- write side ----------
    always_comb begin
        wr_bin_next  = wr_bin + ((wr_en && !full) ? 1 : 0);
        wr_gray_next = bin2gray(wr_bin_next);
    end

    assign wr_addr = wr_bin[ADDR_W-1:0];

    // synchronize read pointer into write domain and update write pointer
    always_ff @(posedge wr_clk or posedge wr_rst) begin
        if (wr_rst) begin
            wr_bin        <= '0;
            wr_gray       <= '0;
            rd_gray_sync_w1 <= '0;
            rd_gray_sync_w2 <= '0;
        end else begin
            // two-stage synchronizer for rd_gray -> wr domain
            rd_gray_sync_w1 <= rd_gray;
            rd_gray_sync_w2 <= rd_gray_sync_w1;

            // update write pointers
            wr_bin  <= wr_bin_next;
            wr_gray <= wr_gray_next;
        end
    end

    // write to memory on write clock
    always_ff @(posedge wr_clk) begin
        if (!wr_rst) begin
            if (wr_en && !full) mem[wr_addr] <= din;
        end
    end

    // full detection (compare next write gray with inverted MSBs of synced rd_gray)
    logic [ADDR_W:0] rd_gray_sync_w2_local;
    assign rd_gray_sync_w2_local = rd_gray_sync_w2;
    logic [ADDR_W:0] rd_gray_invmsb;
    assign rd_gray_invmsb = {~rd_gray_sync_w2_local[ADDR_W], ~rd_gray_sync_w2_local[ADDR_W-1], rd_gray_sync_w2_local[ADDR_W-2:0]};
    assign full = (wr_gray_next == rd_gray_invmsb);

    // ---------- read side ----------
    always_comb begin
        rd_bin_next  = rd_bin + ((rd_en && !empty) ? 1 : 0);
        rd_gray_next = bin2gray(rd_bin_next);
    end

    assign rd_addr = rd_bin[ADDR_W-1:0];

    // synchronize write pointer into read domain and update read pointer + dout
    always_ff @(posedge rd_clk or posedge rd_rst) begin
        if (rd_rst) begin
            rd_bin         <= '0;
            rd_gray        <= '0;
            wr_gray_sync_r1 <= '0;
            wr_gray_sync_r2 <= '0;
            dout_reg       <= '0;
        end else begin
            // two-stage synchronizer for wr_gray -> rd domain
            wr_gray_sync_r1 <= wr_gray;
            wr_gray_sync_r2 <= wr_gray_sync_r1;

            // update read pointers
            rd_bin  <= rd_bin_next;
            rd_gray <= rd_gray_next;

            // read data (registered)
            if (rd_en && !empty) dout_reg <= mem[rd_addr];
        end
    end

    // empty detection (in read domain)
    assign empty = (rd_gray == wr_gray_sync_r2);
    assign dout  = dout_reg;

endmodule