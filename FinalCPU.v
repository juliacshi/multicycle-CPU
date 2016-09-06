`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:28 11/23/2015 
// Design Name: 
// Module Name:    FinalCPU 
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
module FinalCPU(clk, reset);//, InstrIn,state

input clk, reset;
//input [31:0] InstrIn; 
wire [3:0] state;

wire bs, mtr, mr, rw, mw,rd1,irw,pcw;
wire [1:0] srca, srcb, pcsrc, pcwc;
wire [5:0] op;
wire [31:0] ALUOut;
wire [2:0] aop; //ALUcontrol;

	datapath datapath1(
		.ALUOut(ALUOut), 
		.CtrlOp(op), 	// output from datapath to controller
		.clk(clk), 
		.reset(reset), 
		.ALUSrcB(srcb), 
		.PCSource(pcsrc), 
		.PCWriteCond(pcwc),
		.BranchSel(bs),
		.RegWrite(rw),
		.MemRead(mr), 
		.MemWrite(mw),
		.ALUSrcA(srca),
		.MemtoReg(mtr),
		.ReadDst(rd1),
		.PCWrite(pcw),
		.IRWrite(irw),
		.ALUOp(aop) 	// input from controller to datapath
	); 


	controller controller1(
		.Opcode(op), 	//	input from datapath to controller
		.clk(clk), 
		.Reset(reset), 
		.State(state), 
		.ALUSrcB(srcb), 
		.PCSource(pcsrc),
		.PCWriteCond(pcwc), 
		.ALUSrcA(srca),
		.BranchSel(bs),
		.RegWrite(rw),
		.MemRead(mr),
		.MemWrite(mw),  
		.MemtoReg(mtr), 
		.ReadDst(rd1), 
		.PCWrite(pcw),
		.IRWrite(irw),
		.ALUOp(aop) 	// output from controller to datapath
	);

endmodule
