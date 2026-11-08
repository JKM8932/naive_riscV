module mult_ext(
    input   logic                           flagR,
    input   logic[6:0]                      opcode,
    input   logic[2:0]                      funct3,
    input   logic[6:0]                      funct7,
    input   logic[31:0]                     rs1,
    input   logic[31:0]                     rs2,
    output  logic[31:0]                     rd
);

logic signed [63:0]                         rs1s_ext;
assign rs1s_ext = {32{rs1[31]},rs1};

logic signed [63:0]                         rs2s_ext;
assign rs2s_ext = {32{rs2[31]},rs2};

logic signed [63:0]                         rs1u_ext;
assign rs1u_ext = {32{1'b0},rs1};

logic signed [63:0]                         rs2u_ext;
assign rs2u_ext = {32{1'b0},rs2};

always_comb

    if (opcode == 7'b011_0011 && funct7 == 7'h01 && flagR == 1'b1) begin

        case(funct3)
            3'h0: rd = (rs1s_ext*rs2s_ext)[31:0];                          // MULT (normal) (signed/unsigned)
            3'h1: rd = (rs1s_ext*rs2s_ext)[63:32];                         // MULT (high) (signed)
            3'h2: rd = (rs1s_ext*rs2u_ext)[63:32];                         // MULT (high) (signed * unsigned)
            3'h3: rd = (rs1u_ext*rs2u_ext)[63:32];                         // MULT (high) (unsigned)

            3'h4: rd = (signed'(rs1) / signed'(rs2));                      // DIV (signed)
            3'h5: rd = (rs1 / rs2);                                        // DIV (unsigned)
            3'h6: rd = (signed'(rs1) % signed'(rs2));                      // REM (signed)
            3'h7: rd = (rs1 % rs2);                                        // REM (unsigned)
            default rd = 32'b0;
        endcase

    end
    
    else rd = 32'b0;


endmodule
