`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:20:06 11/21/2015 
// Design Name: 
// Module Name:    muxA 
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
module muxA(MuxAtoALU, PCtoMem, AtoMux, numzero,ALUSrcA);
input [31:0] AtoMux, PCtoMem, numzero;
input [1:0]ALUSrcA;
output reg [31:0] MuxAtoALU;

always @ (AtoMux, PCtoMem, ALUSrcA)
begin
case (ALUSrcA)
	0: MuxAtoALU <= PCtoMem;
	1: MuxAtoALU <= AtoMux;
	2: MuxAtoALU <= numzero;
endcase
end

endmodule
