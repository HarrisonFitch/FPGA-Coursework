`timescale 1ns / 1ps

//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 3												         //
//  File name: RS_flop.v	                                       //
//                                                                //
//  Created by Harrison Fitch on 9/10/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: This a RS_Flop. It outputs based upon the truth 	   //
//  table of an RS_Flop.																//
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
module RS_flop(
	input r, s, clk, rst,
	output reg q
   );
	//initialize q and q1, initialize flop

	always @(posedge clk, posedge rst) begin
		if(rst)
			q <= 1'b0;
		//case statement for flop logic
		else begin
			q <=		({s,r} == 2'b00) ? 	 q: 
						({s,r} == 2'b01) ? 1'b0:
						({s,r} == 2'b10) ? 1'b1:
												 1'b0;
		end
	end
endmodule
