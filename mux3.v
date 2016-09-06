`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:20 11/21/2015 
// Design Name: 
// Module Name:    mux3 
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
module mux3(MuxtoPC, ALUResult, ALUOut, jumpaddress,PCSource);
input[31:0] ALUResult, ALUOut;
input [25:0] jumpaddress;
input [1:0] PCSource;
output reg [31:0] MuxtoPC;

always @ (ALUResult, ALUOut, jumpaddress)
begin
case (PCSource)
	0: MuxtoPC <= ALUResult;//[15:0];
	1: MuxtoPC <= ALUOut;//[15:0];
	2: MuxtoPC <= {6'b0,jumpaddress};
endcase
end

endmodule
