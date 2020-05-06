`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 4												         //
//  File name: Memory_Interface_Block.										//
//                                                                //
//  Created by Harrison Fitch on 12/12/17.                        //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Memory Interface Block designed to interface with	//
//	 the Micron RAM. This interface communicates between the 		//
//	 Tramelblaze processor and the Micron Memory. 85ns access time.//
//																						//
//  Edit history: 								 								//
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else.                                               //
//                                                                //
//  In the event other code sources are utilized I will           //
//  document which portion of code and who is the author          //
//                                                                //
// In submitting this code I acknowledge that plagiarism          //
// in student project work is subject to dismissal from the class //
//****************************************************************//
module Memory_Interface_Block(clk, rst, write, read, data_in, data_out,
										i_p, o_p, CE, WE, OE, ADV, CRE, UB, LB, A, R_sel);
	input				clk, rst, write, read, cs;
	input	 [15:0]	data_in, o_p, i_p;
	input	 [2:0]	R_sel;
	
	output			CE, WE, OE, ADV, CRE, UB, LB;
	output [15:0]	data_out;
	output [22:0]	A;
	
	reg	 [3:0]	r_count, w_count;
	reg	 [15:0]	WA_R0, WA_R1, WD_R, RD_R;
	
	
	assign data_out = WD_R;
	assign ADV = (r_count > 4'h0 || w_count > 4'h0) ?	1'b0	:	1'b1;
	assign CE  = (r_count > 4'h0 || w_count > 4'h0) ?	1'b0	:	1'b1;
	assign WE  = (w_count > 4'h4) ? 1'b0 : 1'b1;
	assign OE  = (r_count > 4'h8) ? 1'b0 : 1'b1;
	assign A   = {WA_R1, WA_R0};
	
	always@(posedge clk, posedge rst)begin
			if(rst)begin
				r_count <= 4'b0;
				w_count <= 4'b0;
				WA_R0	  <= 16'b0;
				WA_R1	  <= 16'b0;
				WD_R	  <= 16'b0;
				RD_R	  <= 16'b0;
			end
			else begin
				RD_R <= data_in;
				case(R_sel)
					3'b001:	WA_R0 <= o_p;
					3'b010:	WA_R1 <= o_p;
					3'b100:	WD_R  <= o_p;
					default: WA_R0 <= WA_R0;
				endcase
				if(read)
					r_count <= r_count + 1;//start counting read
				else if (write)
					w_count <= w_count + 1;//start counting write
				else begin
					if(r_count != 4'h0)
						r_count <= r_count + 1;//continue counting read
					else if(r_count == 4'h9)
						r_count <= 0;//reset count
					else
						r_count <= r_count;//not counting read
					if(w_count != 4'h0)
						w_count <= w_count + 1;//continue counting write
					else if(w_count == 4'h9)
						w_count <= 0;//reset count
					else
						w_count <= w_count;//not counting write
				end
			end
		end
	

endmodule
