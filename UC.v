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
        6'd0: begin //TIPO R
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
	6'b100011: begin //lw
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
	6'b101011: begin //SW
	    AluSrc <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b1;
            ALUop <= 3'b000;
            RegWrite <= 1'b0;
	    Branch <= 1'b0;
	    J <= 1'b0;
	end
	6'b000100: begin //BEQ
	    AluSrc <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUop <= 3'b010;
            RegWrite <= 1'b0;
	    Branch <= 1'b1;
	    J <= 1'b0;
	end
	6'b001000: begin //ADDI
            RegDst <= 1'b0;
	    AluSrc <= 1'b1;
            MemtoReg <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            ALUop <= 3'b000;
            RegWrite <= 1'b1;
	    Branch <= 1'b0;
	    J <= 1'b0;
	end
	6'b000010: begin //JUMP
	    AluSrc <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            RegWrite <= 1'b0;
	    Branch <= 1'b0;
	    J <= 1'b1;
	end
        default: begin
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
        end
    endcase
end
    
endmodule