module riscv_pc #(
    parameter DATA_WIDTH = 32
)(
    input   logic[DATA_WIDTH-1:0]               Imm_Op,
    input   logic                               clk,
    input   logic                               rst,
    input   logic                               PCsrc,
    output  logic[DATA_WIDTH-1:0]               PC
);

logic[DATA_WIDTH-1:0]                           next_PC;
logic[DATA_WIDTH-1:0]                           PC_out;

pc_counter riscv_pc_counter(
    .PC                                         (PC_out),
    .Imm_Op                                     (Imm_Op),
    .PCsrc                                      (PCsrc),
    .next_PC                                    (next_PC)
);

pc_reg riscv_pc_reg(
    .next_PC                                    (next_PC),
    .clk                                        (clk),
    .rst                                        (rst),
    .PC                                         (PC_out)       
);

assign PC = PC_out;

endmodule
