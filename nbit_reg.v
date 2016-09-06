`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:05 11/21/2015 
// Design Name: 
// Module Name:    nbit_reg 
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
//n bit register

module nbit_reg(nD,    // Register Input
                nQ,    // Register Output
				Write, // Only accept input when this is set
				Reset, // Synchronous Reset
				Clk);  // Clock

// Specifies the register data width
parameter DATA_WIDTH = 32;
	
//-------------Input Ports-----------------------------
input [DATA_WIDTH-1:0] nD;
input Write;
input Reset;
input Clk;

//-------------Output Ports----------------------------
output [DATA_WIDTH-1:0] nQ;

//-------------Wires-----------------------------------

//-------------Other-----------------------------------

//------------Code Starts Here-------------------------
DFF DFFs[DATA_WIDTH-1:0] (nD, nQ, Write, Reset, Clk);

endmodule
