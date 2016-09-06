`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:26:31 11/21/2015 
// Design Name: 
// Module Name:    DFF 
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
////////////////////////////////////////////////////////////////////////////////////D Flip-flop
module DFF(	D,     // DFF Input
           	Q,     // DFF Output
			Write, // Only accept input when this is set
			Reset, // Synchronous Reset
			Clk);  // Clock

	//-------------Input Ports-----------------------------
	input D;
	input Write;
	input Reset;
	input Clk;

	//-------------Output Ports----------------------------
	output Q;

	//-------------Wires-----------------------------------
	
	//-------------Other-----------------------------------
	reg data;

	//------------Code Starts Here-------------------------
	assign Q= data;
	always @ (posedge Clk)
	if (Reset) begin
		data <= 1'b0;
	end  else begin
		if(Write)
			data <= D; 
	end
endmodule
