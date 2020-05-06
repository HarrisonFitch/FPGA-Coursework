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
//  Abstract: Testbench for the transmit engine. Tests 1 sequence //
//	 of data to output through the transmit engine.						//
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

module Transmit_Engine_TB;

	// Inputs
	reg clk;
	reg rst;
	reg load;
	reg [7:0] data;
	reg eight;
	reg pen;
	reg ohel;
	reg [3:0] baud;

	// Outputs
	wire TXRDY;
	wire TX;

	// Instantiate the Unit Under Test (UUT)
	Transmit_Engine uut (
		.clk(clk), 
		.rst(rst), 
		.load(load), 
		.data(data), 
		.eight(eight), 
		.pen(pen), 
		.ohel(ohel), 
		.baud(baud), 
		.TXRDY(TXRDY), 
		.TX(TX)
	);
	integer i;
	
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		i = 0;
		clk = 0;
		rst = 1;
		load = 0;
		data = 0;
		eight = 0;
		pen = 0;
		ohel = 0;
		baud = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		
		
		data = 8'h55;
		eight = 1;
		pen = 1;
		ohel = 0;
		baud = 4'hb;
		#20
		load = 1;
		#10
		load = 0;
		
		
        
		// Add stimulus here

	end
      
endmodule

