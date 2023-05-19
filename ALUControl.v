`timescale 1ns/1ns

//1 inicializacion
module ALUControl (
    input [5:0]Funct,
    input [2:0]ALUop,
    output reg [3:0]ALUSel
);

//2 bloque always
always @(*)
begin
    case (ALUop)//Lo envia la Unidad de Control
        3'b001: begin //Cuando son instrucciones tipo R
            case (Funct)
                6'b100000: ALUSel <= 4'b0010; //Add
                6'b100010: ALUSel <= 4'b0110; //Substract
                6'b101010: ALUSel <= 4'b0111; //SLT
                default: ALUSel <= 0;
            endcase
        end
	3'b000: begin //ADD
            ALUSel <= 4'b0010; //Add
        end
	3'b010: begin //SUB
            ALUSel <= 4'b0110; //Substract
        end
        default: ALUSel <= 0;
    endcase
end

    
endmodule