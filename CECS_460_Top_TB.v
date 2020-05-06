`timescale 1ns / 1ps

//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 4												         //
//  File name: CECS_460_Top_TB.v		                              //
//                                                                //
//  Created by Harrison Fitch on 12/12/17.                        //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Top Level testbench instantiating TSI and the Core. //
//	 The TSI buffers all of the inputs and outputs from and to the //
//	 Core module. Stimuli is run through the RX verifying echo.		//
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
module CECS_460_Top_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg eight;
	reg pen;
	reg ohel;
	reg rx;

	// Outputs
	wire tx;
	wire [7:0] LEDs;

	// Instantiate the Unit Under Test (UUT)
	CECS_460_Top uut (
		.clk(clk), 
		.rst(rst), 
		.baud(baud), 
		.eight(eight), 
		.pen(pen), 
		.ohel(ohel), 
		.rx(rx), 
		.tx_out(tx), 
		.LEDs(LEDs)
	);

	integer i;
	always #5 clk = ~clk;
	initial begin
		$dumpfile("Power_test.vcd");
		$dumpvars();
		// Initialize Inputs
		clk = 0;
		rst = 1;
		//baud = 4'hb;
		baud = 0;
		eight = 1;
		pen = 0;
		ohel = 0;
		rx = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		for(i = 0; i <10; i = i+1)
			#1085 rx = ~rx;
		$dumpoff;
	end
endmodule

