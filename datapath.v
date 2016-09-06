`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:07 11/21/2015 
// Design Name: 
// Module Name:    datapath 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module datapath(ALUOut, CtrlOp, clk, reset, ALUSrcB, PCSource, PCWriteCond,
		BranchSel,RegWrite,MemRead, MemWrite,ALUSrcA,MemtoReg,ReadDst,PCWrite,IRWrite,ALUOp); 
	 
parameter DATA_WIDTH = 32;

input clk,reset;
input [1:0] ALUSrcB, PCSource,  PCWriteCond, ALUSrcA;
input BranchSel,RegWrite, MemRead, MemWrite, MemtoReg,ReadDst, PCWrite,IRWrite;//IRWrite
input [2:0] ALUOp;

output [31:0] ALUOut;
output [5:0] CtrlOp;

wire [31:0] MuxtoPc, PCtoMem;
wire [31:0] instruction,MemData;
wire [4:0] instrin_25_21, instrin_20_16, instrin_15_11, muxreadout;
wire [15:0] imm;
wire [31:0] SEtoMux, ZEtoMux; 
wire [25:0] inst25_0;
wire [31:0] Mux2toReg, mdrtomux;
wire [31:0] ALUResult;
wire [31:0] read_data_1, read_data_2;
wire [31:0] AtoMuxA, BtoMuxB,MuxAtoALU, MuxBtoALU;
wire andout, ORtoPC, BNE, zero, MuxtoAND;

//Program Counter
nbit_reg PC(MuxtoPc, PCtoMem, ORtoPC, reset, clk); //#(.DATA_WIDTH(16)) 

//IMEM, stores instructions
IMem IMem_1(PCtoMem, instruction);
//DMEM, stores data
DMem DMem_1(AtoMuxA,MemData,ALUOut[15:0],MemWrite,clk);

//Instruction Reg, seperates components of the instruction
//module instruction_reg(op, instrin_25_21, instrin_20_16, instrin_15_11, imm, clk, reset, IRWrite, InstrIn);
//instruction_reg IRreg(CtrlOp, instrin_25_21, instrin_20_16, instrin_15_11 , imm, clk, reset, IRWrite, instruction);
instruction_reg IRreg(CtrlOp, instrin_25_21, instrin_20_16, instrin_15_11, imm, clk, reset, IRWrite,instruction);

//Memory Data Register, holds memory data for one cc
nbit_reg MDR(MemData, mdrtomux, 1'b1, reset,clk); // #(.DATA_WIDTH(16)) 

//concatenates R1,R2, and immediate
assign inst25_0 = {instrin_25_21,instrin_20_16,imm};

//Mux2, chooses between mdr and ALUOut to choose writeData input of registers
mux2 mux21(mdrtomux, ALUOut, Mux2toReg, MemtoReg);

//module MuxRead(muxread_out, input1,input2, ReadDst);
MuxRead muxrd1(muxreadout,instrin_25_21, instrin_15_11, ReadDst);

//Registers 
//module nbit_register_file(write_data, read_data_1, read_data_2,read_sel_1, read_sel_2, write_address, RegWrite, clk);
nbit_register_file registers(Mux2toReg, read_data_1, read_data_2, instrin_20_16, muxreadout, instrin_25_21, RegWrite, clk);

//Sign extend, extend 15 bit immediate to 32 bits
sign_extend SE1(SEtoMux, imm);

//Zero extend, extend 15 bit immediate to 32 bits
zero_extend ZE1(ZEtoMux, imm);

//A register, holds contents of A for one cc
nbit_reg  A(read_data_1,AtoMuxA,1'b1,reset,clk); //#(.DATA_WIDTH(16))
//B register, holds contents of B for one cc
nbit_reg  B(read_data_2,BtoMuxB,1'b1,reset,clk); //#(.DATA_WIDTH(16))

//MUX A, chooses between PCtoMem(PCcount), and AtoMuxA
//module muxA(MuxAtoALU, PCtoMem, AtoMux, ALUSrcA);
muxA muxA1(MuxAtoALU, PCtoMem, AtoMuxA, 32'h00000000, ALUSrcA);
//MUXB, chooses between BtoMux,32'b4,SEtoMUX, and ZE imm
//module muxB(BtoMux, SEtoMux,ZEtoMux, ImmB, ALUSrcB, MuxBtoALU);
muxB mubB1(BtoMuxB, SEtoMux, ZEtoMux, imm, ALUSrcB, MuxBtoALU);

//ALU Control, chooses op of ALU based on the ALUOp
//alu_ctl alucontrol(ALUctl, CtrlOp);

//ALU, computes
alu ALU(ALUResult, zero, MuxAtoALU, MuxBtoALU, ALUOp);
//ALUOut, holds contents of ALU for one cc
nbit_reg ALUOut1(ALUResult,ALUOut, 1'b1, reset, clk);

//MUX3, chooses between ALUResult(ALUResult), isnt25_0(jumpaddress), and inst25_0
mux3 mux31(MuxtoPc, ALUResult, ALUOut, inst25_0, PCSource);

//logic
assign BNE = ~zero;
//MUX4, chooses between BNE and BEQ
mux4 mux41(BranchSel, BNE, zero, MuxtoAND);

//Logic
assign andout = MuxtoAND & PCWriteCond;
assign ORtoPC = andout | PCWrite;

endmodule
