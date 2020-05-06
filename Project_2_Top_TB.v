`timescale 1ns / 1ps

//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 2												         //
//  File name: Project_2_Top.v	                                 //
//                                                                //
//  Created by Harrison Fitch on 10/7/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Testbench for the top level. Tests the design 		//
//	 using the code in ROM to output data to the LEDs and 			//
//  the terminal.																	//
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

module Project_2_Top_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg eight;
	reg pen;
	reg ohel;

	// Outputs
	wire TX;
	wire [15:0] LEDs;

	// Instantiate the Unit Under Test (UUT)
	Project_2_Top uut (
		.clk(clk), 
		.rst(rst), 
		.baud(baud), 
		.eight(eight), 
		.pen(pen), 
		.ohel(ohel), 
		.TX(TX), 
		.LEDs(LEDs)
	);

	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		baud = 0;
		eight = 0;
		pen = 0;
		ohel = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;		
		eight = 1;
		pen = 1;
		ohel = 0;
		baud = 4'hb;

		// Add stimulus here

	end
      
endmodule

