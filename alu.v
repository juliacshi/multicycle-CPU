`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:44 11/22/2015 
// Design Name: 
// Module Name:    alu 
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
module alu(ALUResult, zero, R2, R3, op);

input[31:0] R2, R3;
input[2:0] op;
output reg [31:0] ALUResult;
output reg zero;

always @(op,R2,R3) 
	begin
		case (op)
		3'b000: ALUResult = R2; //mov
		3'b001: ALUResult = ~R2; //not
		3'b010: ALUResult = (R2+R3); //add
		3'b011: ALUResult = (R2-R3); //sub
		3'b100: ALUResult = (R2 | R3); //or
		3'b101: ALUResult = (R2 & R3); //and
		3'b110: ALUResult = (R2 < R3) ? 1:0; //slt
		default: ALUResult = 32'b0;
	endcase

		if (ALUResult == 32'b0)
			begin
			zero = 1'b1;
			end
		else
			begin
			zero = 1'b0;
			end
	
end

endmodule
