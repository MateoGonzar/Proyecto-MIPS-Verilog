`timescale 1ns/1ns

module UC (
    input[5:0]Op,
    output reg RegWrite,
    output reg MemtoReg,
    output reg MemRead,
    output reg MemWrite,
    output reg [2:0]ALUop
);

always @(Op) begin
    case(op):
        5'd0: begin
            MemtoReg <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUop <= 3'b001;
            RegWrite <= 1'b1;
        end
        default: begin
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
        end
    endcase
end
    
endmodule