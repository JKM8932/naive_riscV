module ins_identify (

    input   logic[31:0]             ins,
    output  logic[6:0]              opcode,
    output  logic[4:0]              rsd_addr,
    output  logic[4:0]              rs1_addr,
    output  logic[4:0]              rs2_addr,
    output  logic[2:0]              funct3,
    output  logic[6:0]              funct7,
    output  logic[4:0]              imms_5,
    output  logic[6:0]              imms_7,
    output  logic[11:0]             imms_12,
    output  logic[19:0]             imms_20,
);


// refer to RISC-V 32-bit ISA
always_comb begin

    opcode   = ins[6:0];

    rsd_addr = ins[11:7];
    rs1_addr = ins[19:15];
    rs2_addr = ins[24:20];

    funct3   = ins[14:12];
    funct7   = ins[31:25];

    imms_5   = ins[11:7];
    imms_7   = ins[31:25];
    imms_12  = ins[31:20];
    imms_20  = ins[31:12];
    
end


endmodule