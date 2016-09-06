`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:42:46 11/30/2015
// Design Name:   FinalCPU
// Module Name:   /ad/eng/users/j/s/jshi/milestone3/finalcpu_tb.v
// Project Name:  milestone3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FinalCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module finalcpu_tb;

	// Inputs
	reg clk;
	reg reset;
	
	// Outputs

	// Instantiate the Unit Under Test (UUT)
	FinalCPU uut (
		.clk(clk), 
		.reset(reset)
	);
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#50;
        
		// Add stimulus here
		reset = 0;
		
		end
		
		always begin
		#5 clk = ~ clk;
		end
      
endmodule

