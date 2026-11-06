module opcode (

    input   logic[6:0]                       op_in,
    output  logic                            flagR,
    output  logic                            flagI,
    output  logic                            flagS,
    output  logic                            flagB,
    output  logic                            flagJ,
    output  logic                            flagU
);

always_comb begin
    flagR = 1'b0;
    flagI = 1'b0;
    flagS = 1'b0;
    flagB = 1'b0;
    flagJ = 1'b0;
    flagU = 1'b0;

    case(op_in)
        7'b011_0011: flagR = 1'b1;

        7'b001_0011,
        7'b000_0011,
        7'b110_0111,
        7'b111_0011: flagI = 1'b1;

        7'b010_0011: flagS = 1'b1;

        7'b110_0011: flagB = 1'b1;

        7'b110_1111: flagJ = 1'b1;

        7'b011_0111,
        7'b001_0111: flagU = 1'b1;

        default:                 ;
    endcase
end


endmodule