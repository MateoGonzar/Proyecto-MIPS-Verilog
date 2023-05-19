`timescale 1ns/1ns

module Shiftleft (
    input [31:0]datoE,
    output [31:0]datoS
);

assign datoS = datoE << 2;

endmodule