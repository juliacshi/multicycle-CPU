`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:13 11/21/2015 
// Design Name: 
// Module Name:    muxb 
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
module muxB(BtoMux, SEtoMux,ZEtoMux, ImmB, ALUSrcB, MuxBtoALU);
input [31:0]  SEtoMux,BtoMux,ZEtoMux;
input [15:0] ImmB;
input [1:0] ALUSrcB;
output reg [31:0] MuxBtoALU;

always @(BtoMux, SEtoMux, ImmB, ALUSrcB)
begin
case (ALUSrcB)
	0: MuxBtoALU <= BtoMux;
	1: MuxBtoALU <= 32'b1;
	2: MuxBtoALU <= SEtoMux;
	3: MuxBtoALU <= ZEtoMux;
endcase
end

endmodule
