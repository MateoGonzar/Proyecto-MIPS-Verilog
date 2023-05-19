`timescale 1ns/1ns

module UC (
    input[5:0]Op,
    output reg RegWrite,
    output reg MemtoReg,
    output reg MemRead,
    output reg MemWrite,
    output reg [2:0]ALUop,
    output reg J,
    output reg RegDst,
    output reg Branch,
    output reg AluSrc
);

always @(Op) begin
    case(Op)
        6'd0: begin
	    RegDst <= 1'b1;
	    AluSrc <= 1'b0;
            MemtoReg <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUop <= 3'b001;
            RegWrite <= 1'b1;
	    Branch <= 1'b0;
	    J <= 1'b0;
        end
	6'b100011: begin
            RegDst <= 1'b0;
	    AluSrc <= 1'b1;
            MemtoReg <= 1'b1;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
            ALUop <= 3'b000;
            RegWrite <= 1'b1;
	    Branch <= 1'b0;
	    J <= 1'b0;
	end
	6'b101011: begin
            RegDst <= 1'b0;
	    AluSrc <= 1'b1;
            MemtoReg <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b1;
            ALUop <= 3'b000;
            RegWrite <= 1'b0;
	    Branch <= 1'b0;
	    J <= 1'b0;
	end
	6'b000100: begin
            RegDst <= 1'b0;
	    AluSrc <= 1'b0;
            MemtoReg <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUop <= 3'b001;
            RegWrite <= 1'b0;
	    Branch <= 1'b1;
	    J <= 1'b0;
	end //ADDI->001000 y Jump->000010
        default: begin
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
        end
    endcase
end
    
endmodule