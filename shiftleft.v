`timescale 1ns/1ns
module shiftleft (
    input datoE,
    output datoS,
);

assign datoS = datoE << 2;

endmodule