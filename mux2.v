`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:10 11/21/2015 
// Design Name: 
// Module Name:    mux2 
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
module mux2(MDRtoMux2,ALUOut,Mux2toReg, MemtoReg);
input[31:0] MDRtoMux2;
input[31:0] ALUOut;
input MemtoReg;
output reg [31:0] Mux2toReg;

always @ (MDRtoMux2, ALUOut, MemtoReg)
begin
case (MemtoReg)
	0: Mux2toReg <= ALUOut;
	1: Mux2toReg<= MDRtoMux2;
endcase
end

endmodule
