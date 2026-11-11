module base_int(
    input   logic                           flagR,
    input   logic[6:0]                      opcode,
    input   logic[2:0]                      funct3,
    input   logic[6:0]                      funct7,
    input   logic[31:0]                     rs1,
    input   logic[31:0]                     rs2,
    output  logic[31:0]                     rd
)