`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 3												         //
//  File name: Receive_Engine.v	                                 //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Receive engine for UART. This receive engine can 	//
//  receive asynchronous data on the RX input, interpret it based //
//	 on configuration bits EIGHT, PEN and OHEL, then output the 	//
//	 corresponding data and status flags. This assumes the 			//
//	 configuration bits are the same as when the bits were sent.	//
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
module Receive_Engine(clk, rst, baud, RX, EIGHT, PEN, OHEL, RX_STATUS, R_DATA, reads);
	input 			clk, rst, RX, EIGHT, PEN, OHEL;
	input	[3:0]		baud;
	input	[63:0]	reads;
	
	//RX STATUS configuration 	0 = RXRDY
	//									1 = PERR
	//									2 = FERR
	//									3 = OVF
	output	[3:0] RX_STATUS;
	output 	[7:0]	R_DATA;
	
	wire 			BTU, START;
	
	Recieve_Control	rcu(.clk(clk), .rst(rst), .baud(baud), .START(START),
								.DONE(DONE), .BTU(BTU), .RX(RX), .EIGHT(EIGHT), .PEN(PEN));
	
	Receive_Datapath	rdp(.clk(clk), .rst(rst), .BTU(BTU), .START(START), .EIGHT(EIGHT),
								.PEN(PEN), .DONE(DONE), .RX(RX), .RXRDY(RX_STATUS[0]), .PERR(RX_STATUS[1]),
								.FERR(RX_STATUS[2]), .OVF(RX_STATUS[3]), .reads(reads), .EVEN(OHEL),
								.DATA(R_DATA));

endmodule
