`timescale 1ns/1ns

//1 inicializacion
module ALU (
    input [31:0]Op1,
    input [31:0]Op2,
    input [3:0]Sel,
    output reg [31:0]C,
    output reg Z);

//2 bloque always
always @(*)
begin
    case (Sel)
        4'b0000: C <= Op1&Op2;
        4'b0001: C <= Op1|Op2;
        4'b0010: C <= Op1+Op2;
        4'b0110: C <= Op1-Op2;
        4'b0111: C <= (Op1<Op2) ? 32'd1:32'd0;
        4'b1100: C <= ~(Op1|Op2);
        default: C <= 4'b0000;
    endcase
    if (C == 4'd0) begin
        Z <= 1'b1;
    end
end

    
endmodule