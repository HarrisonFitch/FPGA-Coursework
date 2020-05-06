`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 4												         //
//  File name: CECS_460_Top.v		                                 //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Top Level Module instantiating TSI and the Core. 	//
//	 The TSI buffers all of the inputs and outputs from and to the //
//	 Core module.																	//
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
module CECS_460_Top(clk, rst, baud, eight, pen, ohel, rx, tx_out, LEDs);
	input 				clk, rst, eight, pen, ohel, rx;
	input	 [3:0] 		baud;
	output 				tx_out;	
	output [7:0] 		LEDs;
	
	wire					RX, EIGHT, PEN, OHEL, tx, clock, reset;
	wire	 [3:0]		BAUD;
	wire	 [7:0]		leds;
	
	TSI_Block			tsi(.clk(clk), .rst(rst), .baud(baud), .eight(eight), .pen(pen),
								.ohel(ohel), .rx(rx), .RX(RX), .tx(tx), .tx_out(tx_out), .LEDS(LEDs),
								.clock(clock), .reset(reset), .EIGHT(EIGHT), .PEN(PEN), 
								.OHEL(OHEL), .leds(leds), .BAUD(BAUD) );
	UART_Top_Level		core(.clk(clock), .rst(reset), .baud(BAUD), .eight(EIGHT), 
									.pen(PEN), .ohel(OHEL), .RX(RX), .tx_out(tx), .LEDs(leds));


endmodule
