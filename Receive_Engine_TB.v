`timescale 1ns / 1ps

//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 3												         //
//  File name: Receive_Engine_TB.v		                           //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Tests Receive Engine by sending stimulus through the//
//  Transmit Engine. The TX is tied to the RX, transmitting data	//
//  to then be received as the same data on the Receive output.	//
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

module Receive_Engine_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg EIGHT;
	reg PEN;
	reg OHEL;
	reg [63:0] reads;
	reg load;
	reg [7:0] data;

	// Outputs
	wire TXRDY;
	wire TX;
	wire [3:0] RX_STATUS;
	wire [7:0] R_DATA;

	// Instantiate the Unit Under Test (UUT)
	Receive_Engine uut (
		.clk(clk), 
		.rst(rst), 
		.baud(baud), 
		.RX(TX), 
		.EIGHT(EIGHT), 
		.PEN(PEN), 
		.OHEL(OHEL), 
		.RX_STATUS(RX_STATUS), 
		.R_DATA(R_DATA), 
		.reads(reads)
	);
	
	Transmit_Engine transmit(
		.clk(clk),
		.rst(rst),
		.load(load),
		.data(data), 
		.eight(EIGHT),
		.pen(PEN),
		.ohel(OHEL),
		.baud(baud),
		.TXRDY(TXRDY),
		.TX(TX)
		);
	
	task Tramelblaze_write(reg [7:0]x); begin
			@(negedge clk)
				data = x;
				load = 1;
			@(negedge clk)
				load = 0;
			@(negedge clk)begin
				data = 0;
			end
		end
	endtask
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		baud = 0;
		load = 0;
		OHEL = 0;
		baud = 4'hB;
		EIGHT = 1;
		PEN = 1;
		reads = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		
		#100;
		Tramelblaze_write(8'h55);
		#100;
		@(posedge RX_STATUS[0])
		#100000;
		rst = 1;
		OHEL = 1;
		EIGHT = 0;
		PEN = 0;
		reads = 1;
		#100;
		rst = 0;
		reads = 0;
		#100;
		Tramelblaze_write(8'h72);
		// Add stimulus here

	end
      
endmodule

