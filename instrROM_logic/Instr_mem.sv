module Instr_mem #(
    parameter PC_WIDTH = 32,
              ADDR_SCALE = 8,
              BYTE_WIDTH = 8
)(
    input   logic[PC_WIDTH-1:0]                PC,
    output  logic[PC_WIDTH-1:0]                instr
);

// Setting ROM memory for byte addressing
logic[BYTE_WIDTH-1:0]                               mem[2**ADDR_SCALE-1:0];     // each address (256) holds a byte (8 bits)
logic[ADDR_SCALE-1:0]                               rom_addr;                   // initialise an 8-bit index for addressing

// Take Lowest Significant Byte of input PC
assign rom_addr = PC[ADDR_SCALE-1:0];

// Read from file "program.hex", and copy to all addresses in mem
initial begin
    $readmemh("program.hex", mem);
end

// Asynchronous Read (Little-Endian) - MSB on the left, LSB on the right
// Concatenate output instr using rom_addr to index 4 bytes from mem at a time
assign instr = {mem[rom_addr + 8'd3], mem[rom_addr + 8'd2], mem[rom_addr + 8'd1], mem[rom_addr]};

endmodule
