`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:43:09 11/22/2015 
// Design Name: 
// Module Name:    instruction_reg 
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
//module instruction_reg(op, instrin_25_21, instrin_20_16, instrin_15_11, imm, clk, reset,  InstrIn);
module instruction_reg(op, instrin_25_21, instrin_20_16, instrin_15_11, imm, clk, reset,IRWrite, InstrIn);
output reg[5:0] op;
output reg[4:0] instrin_25_21, instrin_20_16, instrin_15_11;
output reg[15:0] imm;

input[31:0] InstrIn;
input IRWrite;
input clk, reset;

always@(posedge clk)
	begin
	if(reset)
	begin
	op <= 6'b0;
	instrin_25_21 <= 5'b0;//r1
	imm <= 0;
	instrin_20_16 <= 5'b0;//r2
	instrin_15_11 <= 5'b0; //r3
	end
	
	else if(IRWrite)
	begin
	op <= InstrIn[31:26];
	instrin_25_21 <= InstrIn[25:21];
	imm <= InstrIn[15:0];
	instrin_20_16 <= InstrIn[20:16];
	instrin_15_11 <= InstrIn[15:11];
	end
	
end

endmodule
