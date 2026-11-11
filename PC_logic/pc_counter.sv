module pc_counter #(
    parameter DATA_WIDTH = 32
)(
    input   logic[DATA_WIDTH-1:0]                   PC,
    input   logic[DATA_WIDTH-1:0]                   Imm_Op, // This should be coming from Sign extend block
    input   logic                                   PCsrc,
    output  logic[DATA_WIDTH-1:0]                   next_PC
);

logic[DATA_WIDTH-1:0]                               inc_PC;
logic[DATA_WIDTH-1:0]                               branch_PC;

assign inc_PC    = PC + DATA_WIDTH'd4;
assign branch_PC = PC + Imm_Op;

always_comb
    if (PCsrc) next_PC = branch_PC;
    else       next_PC = inc_PC;

endmodule
