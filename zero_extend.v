`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:52 12/04/2015 
// Design Name: 
// Module Name:    zero_extend 
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
module zero_extend(ZE_imm,imm);
input [15:0] imm;
output [31:0] ZE_imm;

assign ZE_imm = {{16'b0}, imm};

endmodule
