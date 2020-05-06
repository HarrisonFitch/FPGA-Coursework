`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 1												         //
//  File name: AISO.v                                             //
//                                                                //
//  Created by Harrison Fitch on 2/11/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Asynchronous In Synchronous Out Module. This module //
//  takes an asynchronous reset signal and uses two registers to  //
//  synchronize the reset with the design. Using the second flop  //
//  ensures that the signal is synchronized.                      //
//                                                                //
//  Edit history: 9/10/17 updated for 460 								//
//																						//
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
module AISO(
	input clk, rst,
	output reset
    );
reg ok1, ok2;

assign reset = ~ok2;//synchronous reset

always @ (posedge clk, posedge rst)
		if (rst)
			{ok1, ok2} <= {1'b0, 1'b0};
		else
			{ok1, ok2} <= {1'b1, ok1};
			//Hard coded '1' used to make asynchronous reset
			//signal (rst)cause synchronous reset to be '1'.

endmodule
