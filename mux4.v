`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:27 11/22/2015 
// Design Name: 
// Module Name:    mux4 
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
module mux4(BranchSel, BNE, BEQ, MuxtoAND);
input BranchSel, BNE, BEQ;
output reg MuxtoAND;

always @ (BranchSel, BNE, BEQ)
begin
case (BranchSel)
	0: MuxtoAND = 0;
	1: MuxtoAND = 1;
endcase
end

endmodule
