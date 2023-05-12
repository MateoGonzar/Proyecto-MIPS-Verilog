`timescale 1ns/1ns

module Sum(
    input[31:0] pc,
    output reg [31:0]pcsum
);

reg [31:0] inc = 32'd4;

always @(*) begin
    assign suma=pc+inc;
end

endmodule