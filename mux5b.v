`timescale 1ns/1ns
module mux5b (
    input [4:0] a,
    input [4:0] b,
    input [1:0] sel,
    output reg [4:0] R,
);

always @(*) begin
    case(sel)
        b'00: begin R = a;
        end

        b'01: begin R = b;
        end
    endcase
end
endmodule