`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:23 12/03/2015 
// Design Name: 
// Module Name:    MuxRead 
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
module MuxRead(muxread_out, input1,input2, ReadDst);
input[4:0] input1,input2;
input ReadDst;
output reg [4:0] muxread_out;

always @ (input1,input2, ReadDst)
begin
case (ReadDst)
	0: muxread_out <= input1;
	1: muxread_out <= input2;
endcase
end

endmodule



