`timescale 1ns / 1ps

//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 2												         //
//  File name: TX_ RS_flop.v	                                    //
//                                                                //
//  Created by Harrison Fitch on 10/7/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: This a RS_Flop. It outputs based upon the truth 	   //
//  of an RS_Flop.																//
//																						//
//  Edit history:																	//
//	 10/7/17 Reset now sets 1 instead of 0 for this instance.		//
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
module TX_RS_flop(
	input r, s, clk, rst,
	output reg q
   );
	//initialize q and q1, initialize flop

	always @(posedge clk, posedge rst) begin
		if(rst)
			q <= 1'b1;
		//case statement for flop logic
		else begin
			q <=		({s,r} == 2'b00) ? 	 q: 
						({s,r} == 2'b01) ? 1'b0:
						({s,r} == 2'b10) ? 1'b1:
												 1'b0;
		end
	end
endmodule
