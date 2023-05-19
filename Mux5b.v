`timescale 1ns/1ns
module mux5b (
    input [4:0] a,
    input [4:0] b,
    input sel,
    output reg [4:0] R
);

always @(*) begin
    case(sel)
        1'b0: R <= a;
        1'b1: R <= b;
        default: R <= 0;
    endcase
end
endmodule