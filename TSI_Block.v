`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 4												         //
//  File name: TSI.v		   			                              //
//                                                                //
//  Created by Harrison Fitch on 12/12/17.                        //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Technology Specific Instantiation Block.				//
//	 Instantiates each buffer for input and output. Also buffers	//
//	 the clock and reset signals.												//
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
module TSI_Block(clk, rst, baud, eight, pen, ohel, rx, RX, tx, tx_out, LEDS, clock, reset,
						EIGHT, PEN, OHEL, leds, BAUD);
	input 			clk, rst, eight, pen, ohel, rx, tx;
	input	 [3:0] 	baud;
	input	 [7:0]	leds;
	output 			tx_out, clock, reset, EIGHT, PEN, OHEL, RX;	
	output [3:0]	BAUD;
	output [7:0] 	LEDS;
	
	
	
	//clock
	BUFG clock_buf (
		.O(clock), // 1-bit output: Clock buffer output
		.I(clk) // 1-bit input: Clock buffer input
	);
	//reset
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_reset (
		.O(reset), // Buffer output
		.I(rst) // Buffer input (connect directly to top-level port)
	);
	
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_eight (
		.O(EIGHT), // Buffer output
		.I(eight) // Buffer input (connect directly to top-level port)
	);
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_pen (
		.O(PEN), // Buffer output
		.I(pen) // Buffer input (connect directly to top-level port)
	);
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_ohel (
		.O(OHEL), // Buffer output
		.I(ohel) // Buffer input (connect directly to top-level port)
	);
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_rx (
		.O(RX), // Buffer output
		.I(rx) // Buffer input (connect directly to top-level port)
	);
	IBUF #(
	.IOSTANDARD("DEFAULT") // Specify the input I/O standard
	)IBUF_baud [3:0](
		.O(BAUD[3:0]), // Buffer output
		.I(baud[3:0]) // Buffer input (connect directly to top-level port)
	);
	
	
	OBUF #(
		.DRIVE(12), // Specify the output drive strength
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("SLOW") // Specify the output slew rate
	) OBUF_led [7:0](
		.O(LEDS[7:0]), // Buffer output (connect directly to top-level port)
		.I(leds[7:0]) // Buffer input
	);
	OBUF #(
		.DRIVE(12), // Specify the output drive strength
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("FAST") // Specify the output slew rate
	) OBUF_tx(
		.O(tx_out), // Buffer output (connect directly to top-level port)
		.I(tx) // Buffer input
	);

endmodule
