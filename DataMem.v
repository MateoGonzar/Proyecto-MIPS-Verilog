module DataMem (
  input [31:0] Add,
  input [31:0] DataIn,
  input MemWrite,
  input MemRead,
  output reg [31:0] DataOut
);

reg [31:0] DataMemory [0:255];
always @(*) begin
    if (MemWrite) begin
        Memory[Add] <= DataIn;
    end

    if (MemRead) begin
        DataOut <= Memory[Address];
    end
end



endmodule