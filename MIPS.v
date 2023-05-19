`timescale 1ns/1ns

module MIPS (
    input CLK
);

wire [31:0] MuxtoPc, PctoAddMem, AddtoAdd, Inst, JumpAdd, MemtoRegtoMem, MemtoAlu, MemtoAluMux, SEOut, SltoAdd, AluMuxtoAlu, AddtoMux, AlutoMemRegtoMem, AddMuxtoMux, MemtoMemtoReg;
wire [4:0] MuxtoBR;
wire [3:0] AluControltoAlu;
wire [2:0] UctoAlucontrol;
wire UctoBr, UctoMem1, UctoMem2, UctoMemToReg, UctoJumpMux, UctoBRMux, UctoAluMux, UctoAnd, AlutoAnd, AndtoAddMux;


PC pc(.clk(CLK), .pcadd(MuxtoPc), .pc(PctoAddMem));
Sum sum(.pc(PctoAddMem), .inc(32'd4), .pcsum(AddtoAdd));
MemInst meminst(.pc(PctoAddMem), .inst(Inst));
Shiftleft sljump(.datoE(Inst[25:0]), .datoS(JumpAdd[27:0]));
assign JumpAdd[31:28] = AddtoAdd[3:0];
UC uc(.Op(Inst[31:26]), .RegWrite(UctoBr), .MemtoReg(UctoMemToReg), .MemRead(UctoMem1), .MemWrite(UctoMem2), .ALUop(UctoAlucontrol), .J(UctoJumpMux), .RegDst(UctoBRMux), .Branch(UctoAnd), .AluSrc(UctoAluMux));
mux5b brmux(.a(Inst[20:16]), .b(Inst[15:11]), .sel(UctoBRMux), .R(MuxtoBR));
BR br(.RR1(Inst[25:21]), .RR2(Inst[20:16]), .WR(MuxtoBR), .DW(MemtoRegtoMem), .RegEn(UctoBr), .DR1(MemtoAlu), .DR2(MemtoAluMux));
sign_extend se(.in(Inst[15:0]), .out(SEOut));
Shiftleft sl(.datoE(SEOut), .datoS(SltoAdd));
Mux32b alumux(.Sel(UctoAluMux), .Data1(SEOut), .Data0(MemtoAluMux), .OutputData(AluMuxtoAlu));
ALUControl alucontrol(.Funct(Inst[5:0]), .ALUop(UctoAlucontrol), .ALUSel(AluControltoAlu));
Sum addsum(.pc(AddtoAdd), .inc(SltoAdd), .pcsum(AddtoMux));
ALU alu(.Op1(MemtoAlu), .Op2(AluMuxtoAlu), .Sel(AluControltoAlu), .C(AlutoMemRegtoMem), .Z(AlutoAnd));
And aop(.dato1(UctoAnd), .dato2(AlutoAnd), .datoS(AndtoAddMux));
DataMem datamemory(.Add(AlutoMemRegtoMem), .DataIn(AlutoMemRegtoMem), .MemRead(UctoMem1), .MemWrite(UctoMem2), .DataOut(MemtoMemtoReg));
Mux32b addmux(.Sel(AndtoAddMux), .Data1(AddtoMux), .Data0(AddtoAdd), .OutputData(AddMuxtoMux));
Mux32b jumomux(.Sel(UctoJumpMux), .Data1(JumpAdd), .Data0(AddMuxtoMux), .OutputData(MuxtoPc));
Mux32b memtoreg(.Sel(UctoMemToReg), .Data1(MemtoMemtoReg), .Data0(AlutoMemRegtoMem), .OutputData(MemtoRegtoMem));
    
endmodule