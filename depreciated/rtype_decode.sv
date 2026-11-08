module rtype_decode (
    input   logic                       flagR,
    input   logic[6:0]                  opcode,
    input   logic[2:0]                  funct3,
    input   logic[6:0]                  funct7,
    input   logic[31:0]                 rs1,
    input   logic[31:0]                 rs2,
    output  logic[31:0]                 dout
);

logic[4:0]                              funct5;             // Atomic

logic signed [31:0]                     rs1_signed;
assign rs1_signed = rs1;

logic signed [31:0]                     rs2_signed;
assign rs2_signed = rs2;

always_comb begin

    dout = 0;

    if (flagR) begin

        case(opcode)

            // Base Integer Instructions & Extensions
            7'b011_0011: begin

                case(funct3)

                    // Add & Sub   | Mul
                    3'h0: begin

                        case (funct7)
                            7'h00:     dout = rs1_signed + rs2_signed;
                            7'h20:     dout = rs1_signed - rs2_signed;
                            // 7'h01
                        endcase

                    end

                    // Shift Left  | Mul HIGH
                    3'h1: begin

                        case (funct7)
                            7'h00: dout = rs1 << rs2[4:0];                      // [4:0] is a range of 0 to 31 bit shifts
                            // 7'h01
                        endcase
                    
                    end

                    // Signed Set Less Than
                    3'h2: begin

                        case (funct7)
                            7'h00: dout = (rs1_signed < rs2_signed) ? 32'b1 : 32'b0;
                            // 7'h01
                        endcase

                    end

                    // Unsigned Set Less Than
                    3'h3: begin

                        case (funct7)
                            7'h00: dout = (rs1 < rs2) ? 32'b1: 32'b0;
                            // 7'h01
                        endcase

                    end

                    // Bitwise XOR | Div
                    3'h4: begin

                        case (funct7)
                            7'h00: dout = rs1 ^ rs2;
                            // 7'h01
                        endcase

                    end

                    // Shift Right | DivU
                    3'h5: begin

                        case (funct7)
                            7'h00: dout = rs1  >> rs2[4:0];                      // [4:0] is a range of 0 to 31 bit shifts
                            7'h20: dout = rs1_signed >>> rs2[4:0];               // >>> is arithmetic shift, signed is needed
                        endcase

                    end

                    // Bitwise OR  | Remainder
                    3'h6: begin

                        case (funct7)
                            7'h00: dout = rs1 | rs2;
                            // 7'h01
                        endcase

                    end

                    // Bitwise AND | RemainderU
                    3'h7: begin

                        case (funct7)
                            7'h00: dout = rs1 & rs2;
                            // 7'h01
                        endcase

                    end

                endcase

            end

            // Atomic Extension
            7'b010_1111: begin

                funct5 = funct7[6:2];
                if (funct3 == 3'h2) begin
                    case(funct5)
                /*
                    5'h01:
                    5'h02:
                    5'h03:
                    5'h04:
                    5'h0A:
                    5'h0C:
                    5'h10:
                    5'h14:
                */
                    endcase
                end
            end

        endcase

    end

end

endmodule

