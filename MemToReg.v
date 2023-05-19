module Mux32b (
  input Sel,
  input [31:0] Data1,
  input [31:0] Data0,
  output reg [31:0] OutputData
);


  always @(*) begin
    case (Sel)
        1'b0: OutputData <= Data0;
        1'b1: OutputData <= Data1;
        default: OutputData <= 0;
    endcase
  end

endmodule