`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 1												         //
//  File name: pulse_maker_PED.v                                  //
//                                                                //
//  Created by Harrison Fitch on 2/11/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: This is a positive edge detect. It detects a rising //
//  edge on the input d.                                          //
//                                                                //
//  Edit history: 9/10/17 updated for 460									//
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
module pulse_maker_PED(
	input clk, rst, d,
	output q
    );
reg ok1, ok2;

//Create a PED pulse by AND-ing the 1st flop output
//with the negation of the 2nd flop's output.
assign q = (ok1 & ~ok2);

always @ (posedge clk, posedge rst)
	if (rst)
		{ok1, ok2} <= {1'b0, 1'b0};
	else
		{ok1, ok2} <= {d, ok1};

endmodule
