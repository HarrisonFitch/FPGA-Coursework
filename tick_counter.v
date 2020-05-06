`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 1												         //
//  File name: tick_counter.v                                     //
//                                                                //
//  Created by Harrison Fitch on 2/11/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: This is a counter that produces a pulse every 10ms. //
//																						//
//  Edit history: 9/10/17 updated for 460 								//
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
module tick_counter(
		input clk, rst,
		output tick
		);
	reg [19:0] counter;
	
	assign tick = (counter == 999999);//if 10ms, output pulse

	//Increment counter until next pulse.
	//Reset counter to 0 if reset or tick occurs.
	always @ (posedge clk, posedge rst)
		if(rst)
			counter <= 20'b0;
		else if(tick)
			counter <= 20'b0;
		else
			counter <= counter +20'b1;
		 


endmodule
