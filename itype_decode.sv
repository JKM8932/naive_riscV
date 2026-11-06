module itype_decode (
    input   logic                       flagR,
    input   logic[6:0]                  opcode,
    input   logic[2:0]                  funct3,
    input   logic[31:0]                 imm_12_ext,
    input   logic[31:0]                 rs1,
    output  logic[31:0]                 dout
);

logic signed [31:0]                     rs1_signed;
assign rs1_signed = rs1;

always_comb begin

    case(opcode)

        // Base Integer Arithmetic
        7'b001_0011: 
            case(funct3)

                // Add
                3'h0: dout = rs1_signed + imm_12_ext;

                // Shift Left
                3'h1: dout = rs1_signed << imm_12_ext[4:0];

                // Set Less Than
                3'h2: dout = (rs1_signed < imm_12_ext) ? 1 : 0;

                // Set Less Than (unsigned)
                3'h3: dout = (rs1 < imm_12_ext) ? 1 : 0;

                // Bitwise XOR
                3'h4: dout = rs1 ^ imm_12_ext;

                // Shift Right(s)
                3'h5: case(imm_12_ext[11:5])
                    7'h00: dout = rs1        >>  imm_12_ext[4:0];
                    7'h20: dout = rs1_signed >>> imm_12_ext[4:0];
                endcase

                // Bitwise OR
                3'h6: dout = rs1 | imm_12_ext;

                // Bitwise AND
                3'h7: dout = rs1 & imm_12_ext;

            endcase
        
        // Base Integer Memory Manipulation
        7'b000_0011:
            case(funct3):

            // 3'h0: Load byte, dout = mem[rs1 + imm_12_ext][7:0]; (requires signed extension)
            // 3'h1: Load half, dout = mem[rs1 + imm_12_ext][15:0]; (requires signed extension)
            // 3'h2: Load word, dout = mem[rs1+imm_12_ext][31:0];
            // 3'h4: Load byte unsigned, dout = {24'b0, mem[rs1 + imm_12_ext][7:0]};
            // 3'h5: Load half unsigned, dout = {16'b0, mem[rs1+imm_12_ext][7:0]};

            endcase

    endcase
end

endmodule
