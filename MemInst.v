`timescale 1ns/1ns

module MemInst(
    input [31:0]pc, //Ubicacion de las instruciones
    output reg [31:0]inst); //Instrucciones

reg [7:0]instruction_memory[0:255];

always @(*) begin
    assign inst = {instruction_memory[pc], instruction_memory[pc+1], instruction_memory[pc+2], instruction_memory[pc+3]};
end



endmodule