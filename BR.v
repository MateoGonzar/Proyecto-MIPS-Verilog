`timescale 1ns/1ns

 module BR (
    input [4:0]RR1,
    input [4:0]RR2,
    input [4:0]WR,
    input [31:0]DW,
    input RegEn,
    output reg [31:0]DR1,
    output reg [31:0]DR2
 );
    
reg [31:0]Bank[0:31];

initial begin
    $readmemb("br.txt",Bank);
end

always @(*) begin
    if(RegEn)
    begin
        Bank[WR] <= DW;
    end
end

assign DR1 = Bank[RR1];
assign DR2 = Bank[RR2];


 endmodule