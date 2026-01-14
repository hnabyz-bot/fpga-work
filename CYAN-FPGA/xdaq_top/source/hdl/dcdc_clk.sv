module dcdc_clk (
    input   logic   clk,
    input   logic   reset_n,
    output  logic   clk_1M_o,
    output  logic   clk_5M_o
);

    localparam int WIDTH = 5;
    logic [WIDTH-1:0] count_1m;
    logic [WIDTH-4:0] count_5m;

    localparam int PERIOD_1M = 10;
    localparam int PERIOD_5M = 2;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            count_1m <= 0;
            count_5m <= 0;
            clk_1M_o <= 0;
            clk_5M_o <= 0;
        end else begin
            if (count_1m == PERIOD_1M - 1) begin 
                clk_1M_o <= ~clk_1M_o;
                count_1m <= 0;
            end else begin
                count_1m <= count_1m + 1;
            end

            if (count_5m == PERIOD_5M - 1) begin 
                clk_5M_o <= ~clk_5M_o;
                count_5m <= 0;
            end else begin
                count_5m <= count_5m + 1;
            end
        end
    end

endmodule