`timescale 1ns/1ns

module PC (
    input clk,//Reloj
    input [31:0]pcadd, //Registro de programa despues del incremento en Adder
    output reg [31:0]pc //Registro de programa 
);


initial begin
    pc=32'd0;
end

always @(posedge clk) begin
        pc <= pcadd;
end

    
endmodule