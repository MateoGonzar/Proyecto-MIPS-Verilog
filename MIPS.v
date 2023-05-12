`timescale 1ns/1ns

module MIPS (
    input CLK
);

wire [31:0] AddtoPc, PctoAddMem, Inst, MemtoRegtoMem, MemtoAlu1, MemtoAlu2, AlutoMemRegtoMem, MemtoMemtoReg;
wire [3:0] AluControltoAlu;
wire [2:0] UctoAlucontrol;
wire UctoBr, UctoMem1, UctoMem2, UctoMemToReg;

initial begin
    $readmemb("instmem.txt", instruction_memory);
end

initial begin
   $readmemb("br.txt",Bank);
end

PC pc(.clk(CLK), .pcadd(AddtoPc), .pc(PctoAddMem));
Sum sum(.pc(PctoAddMem), .pcsum(AddtoPc));
MemInst meminst(.pc(PctoAddMem), .inst(Inst));
UC uc(.Op(Inst[0:5]), .RegWrite(UctoBr), .MemToReg(UctoMemToReg), .MemRead(UctoMem1), .MemWrite(UctoMem2), .ALUop(UctoAlucontrol));
BR br(.RR1(Inst[6:10]), .RR2(Inst[11:15]), .WR(Inst[16:20]), .DW(MemtoRegtoMem), .RegEn(UctoBr), .DR1(MemtoAlu1), .DR2(MemtoAlu2));
ALUControl alucontrol(.Funct(Inst[25:31]), .ALUop(UctoAlucontrol), .ALUSel(AluControltoAlu));
ALU alu(.Op1(MemtoAlu1), .Op2(MemtoAlu2), .Sel(AluControltoAlu), .C(AlutoMemRegtoMem), .Z());
DataMemory datamemory(.Add(AlutoMemRegtoMem), .DataIn(AlutoMemRegtoMem), .MemRead(UctoMem1), .MemWrite(UctoMem2), .DataOut(MemtoMemtoReg));
MemToReg memtoreg(.Memtoreg(UctoMemToReg), .DataMem(MemtoMemtoReg), .DataALU(AlutoMemRegtoMem), .DWData(MemtoRegtoMem));
    
endmodule