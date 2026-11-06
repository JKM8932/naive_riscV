module cpu_reg #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)(
    input   logic                       clk,
    input   logic                       en,
    input   logic[DATA_WIDTH-1:0]       din,
    input   logic[ADDR_WIDTH-1:0]       addr1,
    input   logic[ADDR_WIDTH-1:0]       addr2,
    input   logic[ADDR_WIDTH-1:0]       addr3,
    output  logic[ADDR_WIDTH-1:0]       dout2,
    output  logic[ADDR_WIDTH-1:0]       dout3
);

logic[DATA_WIDTH-1:0]                   mem[2**DDR_WIDTH-1:0];

always_ff @(posedge clk) begin
    dout2 <= mem[addr2];
    dout3 <= mem[addr3];
    if (en) mem[addr1] <= din;
end

endmodule
