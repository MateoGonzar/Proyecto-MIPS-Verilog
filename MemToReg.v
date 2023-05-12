module MemToReg (
  input Memtoreg,
  input [31:0] DataMem,
  input [31:0] DataALU,
  output reg [31:0] DWData,
);


  always @(*) begin
    case (Memtoreg)
        1'b0: DWData <= DataALU;
        1'b1: DWData <= DataMem;
        default: DWData <= 0;
    endcase
  end

endmodule