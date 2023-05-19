`timescale 1ns/1ns

module Sum(
    input[31:0] pc,
    input[31:0] inc,
    output reg [31:0]pcsum
);


assign pcsum=pc+inc;

endmodule