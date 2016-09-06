`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:23 11/23/2015
// Design Name:   datapath
// Module Name:   /mnt/nokrb/nadyarq/finalproject/datapath_tb.v
// Project Name:  finalproject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module datapath_tb;

	// Inputs
	reg clk;
	reg reset;
	
	reg [1:0] ALUSrcA;
	reg [1:0] ALUSrcB;
	reg [5:0] ALUOp;
	reg [1:0] PCSource;
	reg [1:0] PCWrite;
	reg [1:0] MemtoReg;
	reg [1:0] IRWrite;
	reg [1:0] PCWriteCond;
	
   	reg BranchSel;
	reg RegWrite;
	reg MemRead;
	reg MemWrite;

	// Outputs
	wire [31:0] ALUOut;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.ALUOut(ALUOut), 
		.clk(clk), 
		.reset(reset),
		.ALUSrcA(ALUSrcA),
		.ALUSrcB(ALUSrcB),
		.ALUOp(ALUOp),
		.PCSource(PCSource),
		.PCWrite(PCWrite),
		.MemtoReg(MemtoReg),
		.IRWrite(IRWrite),
		.PCWriteCond(PCWriteCond),
		.BranchSel(BranchSel),
		.RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

	// instruction fetch
	MemRead <= 0;
	ALUSrcA = 0;
						
	IRWrite = 2'b01; 
	ALUSrcB <= 2'b01;
	ALUOp <= 6'b00;
	PCWrite <= 2'b00;
	PCSource <= 2'b00;
	MemtoReg <= 2'b00;
	PCWriteCond <= 2'b00;
	BranchSel <= 0;
	RegWrite <= 0;
	MemWrite <= 0;

	// Wait 100 ns for global reset to finish
	#100;
    reset = 0;
        
	// Add stimulus here
	#10 clk = ~clk;
	ALUSrcA <= 0;
	ALUSrcB <= 2'b11;
	ALUOp <= 6'b00;
	
	#20
	ALUSrcA <= 1;
	
	#20
	 MemRead <=1;
		
      end
endmodule

