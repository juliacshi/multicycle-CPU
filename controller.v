`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:57 11/12/2015 
// Design Name: 
// Module Name:    controller 
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
module controller(Opcode, clk, Reset, 
		State, ALUSrcB, PCSource,PCWriteCond, 
		ALUSrcA,BranchSel,RegWrite,MemRead,MemWrite,  MemtoReg, ReadDst, PCWrite,
		ALUOp,IRWrite);
 
    input [5:0] Opcode;
    input clk, Reset;
    output reg [3:0] State;
    output reg [1:0] ALUSrcA, ALUSrcB, PCSource, PCWriteCond;
    output reg BranchSel,RegWrite, MemRead, MemWrite,MemtoReg,ReadDst,PCWrite,IRWrite;
	output reg [2:0] ALUOp;
    
	reg [3:0] Next_State;
	 
    parameter LWI = 6'b111011, SWI = 6'b111100, J = 6'b000001, BEQ = 6'b100000, BNE = 6'b100001, R_type = 3'b010, I_type = 3'b110, LI= 6'b111001, NOOP = 6'b000000;
	
/*
	reg [3:0] prev_state;
	
	always @ (posedge clk)
	begin
	prev_state <= State;
	end
*/
    always @ (posedge clk or Reset)	//State or Reset
	 if (Reset)
		State <= 4'b0000;
	 else
		State <= Next_State;
		
	 
	always@(*)
    begin:    FSM
    if (Reset)
        begin
					MemRead <= 1'b0;
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b01;///01
					PCWrite <= 1'b0;
					PCSource <= 2'b00;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					PCWriteCond <= 1'b0;
					ReadDst <= 1'b1;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					
					Next_State <= 1'b0;
        end 
    else
		begin
        case (State)
			
        4'd0: 														   // instruction fetch
						begin
						MemRead <= 1'b0;
						ALUSrcA <= 2'b0;
						ALUSrcB <= 2'b01;
						PCWrite <= 1'b1;
						PCSource <= 2'b00;
						BranchSel <= 1'b0;
						MemtoReg <= 1'b0;
						RegWrite <= 1'b0;
						MemWrite <= 1'b0;
						PCWriteCond <= 1'b0;
						ReadDst <= 1'b1;
						ALUOp <= 3'b010;
						//IorD <= 0;
					IRWrite <= 1'b1; 
						
						Next_State <= 4'd1;    
						end																		
																		
        4'd1:                                                         // instruction decode/register fetch
                begin
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					if (Opcode == 6'b010000 ||Opcode == 6'b010001 ||Opcode == 6'b010010 ||Opcode == 6'b010011 ||Opcode == 6'b010100 ||Opcode == 6'b010101 ||Opcode == 6'b010111)
					begin
					ReadDst <= 1'b1;
					end
					else
					begin
					ReadDst <= 1'b0;
					end
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b10;
					ALUOp <= 3'b010;
					 
					 if ((Opcode == LWI) || (Opcode == SWI))
							begin
                    			Next_State <= 4'd2;
							end
                	else if (Opcode == 6'b010000 ||Opcode == 6'b010001 ||Opcode == 6'b010010 ||Opcode == 6'b010011 ||Opcode == 6'b010100 ||Opcode == 6'b010101 ||Opcode == 6'b010111) 
							begin
			                    Next_State <= 4'd6;
							end
			        else  if ((Opcode == BEQ) || (Opcode == BNE))
							begin
			                    Next_State <= 4'd8;
							end
			        else  if (Opcode == J)
							begin
			                    Next_State <= 4'd9;
							end
			        else  if (Opcode == LI)
							begin
			                    Next_State <= 4'd12;
							end
			        else  if (Opcode == 6'b110010 || Opcode == 6'b110011 || Opcode == 6'b110111) // SE
							begin
								Next_State <= 4'd14;
							end
					else  if (Opcode == 6'b110100 || Opcode == 6'b110101 || Opcode == 6'b111001) // ZE
							begin
								Next_State <= 4'd15;
							end
			        else  if (Opcode == NOOP) 
							begin
			                    Next_State <= 4'd0;
							end
			        else begin Next_State <= 4'd0;
							end
				end
        4'd2:                                                         // memory address computation
                begin
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b01;//10
					ALUSrcB <= 2'b11;
					ALUOp <= 3'b010;
					 
					if (Opcode == LWI)
                    	Next_State <= 4'd3;
                	else if (Opcode == SWI)
                    	Next_State <= 4'd5;
                	else Next_State <= 4'd2;
				end

        4'd3:                                                         // memory access lwi
				begin		
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					MemRead <= 1'b1;
					 
					Next_State <= 4'd4;
				end
        4'd4:    														// write back step
                begin
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					RegWrite <= 1'b1;
					MemtoReg <= 1'b1;  
					 
               		Next_State <= 4'd0;
				end
        4'd5:                                                         // memory access swi
                begin
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					MemWrite <= 1'b1;
					 
					Next_State <= 4'd0;
				end 
        4'd6:                                                         // R type execution
                begin 
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b1;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b00;
					ALUOp <= Opcode[2:0];
					
					Next_State <= 4'd7;
				end  
        4'd7:  															// R-type completion, I type completion for SE and ZE
				begin
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUOp <= 3'b000;
					RegWrite <= 1'b1;
					MemtoReg <=1'b0;
					ReadDst <= 1'b1;
					 
					Next_State <= 4'd0;
				end
        4'd8:                                                         // branch completion
                begin
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b00;
					ReadDst <= 1'b0;
					PCWriteCond <=2'b01;
					PCSource <= 2'b01;
					ALUOp <= 3'b000;
					 
					if (Opcode == BEQ)
                    	BranchSel <= 1'b0; 	//Next_State <= 4'd10;
                	else if (Opcode == BNE)
                    	BranchSel <= 1'b1; 	//Next_State <= 4'd11;
               		else BranchSel <= 1'b0; //Next_State <= 4'd0;

					Next_State <= 4'd0;
				end
        4'd9: 		                                                     // Jump completion
                begin
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b10;
					PCWriteCond <= 2'b00;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b1;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUOp <= 3'b000;
					PCWrite <= 1'b1;
					PCSource <= 2'b10;
					
					Next_State <= 4'd0;
				end
        /*4'd10:                                                         // Branch flag from BEQ
                begin
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b01;
					PCWriteCond <= 2'b01;
					PCWrite <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					BranchSel <= 1'b0;
					 
					Next_State <= 4'd0;
				end
        4'd11:                                                         // Branch  flag from BNE
				begin
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					BranchSel <= 1'b1;
					 
					Next_State <= 4'd0;
					end*/
 
        4'd12:                                                         // LI memory access computation
                begin
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					MemRead <= 1'b0;
					ALUOp <= 3'b000;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b11;

					Next_State <= 4'd13;
				end
        4'd13:                                                         // memory access
                begin
					ALUSrcA <= 2'b0;
					ALUSrcB <= 2'b00;
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b1;
					RegWrite <= 1'b1;
					MemWrite <= 1'b0;
					ReadDst <= 1'b0;
					ALUOp <= 3'b010;
					IRWrite <= 1'b0;
					MemRead <=1'b1;
					 
					Next_State <= 4'd0;
				end
        4'd14:                                                         // I-type execution ZE
                begin
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemtoReg <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b10;
					ALUOp <= Opcode[2:0];
					RegWrite <= 1'b0;
					ReadDst <= 1'b0;
					 
					Next_State <= 4'b111;
				end
        4'd15:                                                         // I-type execution SE
                begin
					PCSource <= 2'b00;
					PCWriteCond <= 2'b00;
					PCWrite <= 1'b0;
					BranchSel <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					IRWrite <= 1'b0;
					RegWrite <= 1'b1;
					MemtoReg <= 1'b0;
					ALUSrcA <= 2'b1;
					ALUSrcB <= 2'b11;
					ALUOp <= Opcode[2:0];
					ReadDst <= 1'b0;

					Next_State <= 4'd7;
				end
					 
        default: Next_State <= 4'd0;
        endcase
    end
end
endmodule 
