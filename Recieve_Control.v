`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 3												         //
//  File name: Receive_Control.v	                                 //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Control unit of the Receive Engine. This control  	//
//  module creates the control signals BTU, DONE, START and the 	//
//	 bit time for the receive engine, including the half bit time. //
//	 Once it has received a start bit, based on the configuration, //
//	 it will receive the total amount of bits the DONE signal is 	//
//	 asserted. The START signal is asserted at the start bit.		//
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
module Recieve_Control(clk, rst, baud, START, DONE, BTU, RX, EIGHT, PEN);
	input 			clk, rst, RX, EIGHT, PEN;
	input	[3:0]		baud;
	
	output 			BTU;
	output reg	 	DONE, START;
	
	reg				start, doit;
	wire	[18:0]	rate, rate_sel;
	wire	[3:0]		e_p; 
	reg	[3:0]		BC;
	reg	[18:0]	BTC;
	reg				DOIT;
	reg	[1:0]		p_s, n_s;
	
	//baud rate assignment
	assign rate =	(baud == 4'h0) ? 19'd333333:
						(baud == 4'h1) ? 19'd83333:
						(baud == 4'h2) ? 19'd41667:
						(baud == 4'h3) ? 19'd20833:
						(baud == 4'h4) ? 19'd10417:
						(baud == 4'h5) ? 19'd5208:
						(baud == 4'h6) ? 19'd2604:
						(baud == 4'h7) ? 19'd1736:
						(baud == 4'h8) ? 19'd868:
						(baud == 4'h9) ? 19'd434:
						(baud == 4'hA) ? 19'd217:
						(baud == 4'hB) ? 19'd109:
											  19'd333333;
											  
	//e_p assignment for DONE signal, based on eight and pen
	assign e_p =	({EIGHT, PEN} == 2'b01)	?	4'd10:
						({EIGHT, PEN} == 2'b10)	?	4'd10:
						({EIGHT, PEN} == 2'b11)	?	4'd11:
															4'd9;
	//rate assignment based upon receiving start signal
	assign rate_sel = (START)	?	rate >> 1:	//half bit time for detecting start bit
												  rate;
	//If baud rate count is reached BTU			
	assign BTU	= (rate_sel == BTC) ? 1'b1:
											1'b0;

	//Bit counter and Bit Time Up counter, also present state
	always @(posedge clk, posedge rst)begin
		if(rst) begin
			BC <= 4'b0;
			BTC <= 19'b0;
			p_s <= 2'b0;
			DONE <= 1'b0;
			START <= 1'b0;
			end
		else begin
			case({DOIT, BTU})
				2'h0: begin
						BC <= 4'b0;
						BTC <= 19'b0;
						end
				2'h1: begin
						BC <= 4'b0;
						BTC <= 19'b0;
						end
				2'h2:	begin
						BC <= BC;
						BTC <= BTC + 19'b1;
						end
				2'h3: begin
						BC <= BC + 4'b1;
						BTC <= 19'b0;
						end
				default:	begin
						BC <= 4'b0;
						BTC <= 19'b0;
						end
			endcase
			{p_s, DOIT, START} <= {n_s, doit, start};
			DONE <= (e_p == BC)	?	1'b1:
											1'b0;
		end
	end
	
	//state logic
	always @(*)begin
		case(p_s)
			2'b00:	begin
						//idle state waiting for start bit
						n_s = (RX)	?	2'b00:
											2'b01;
						start = 0;
						doit = 0;
						end
			2'b01:	begin
						//received start bit, start processing
						n_s = (RX)				?	2'b00:
								(~RX && BTU)	?	2'b10:
								(~RX && ~BTU)	?	2'b01:
														2'b00;
						start = 1;
						doit = 1;
						end
			2'b10:	begin
						//finishup processing state
						n_s = (DONE)	?	2'b00:
												2'b10;
						start = 0;
						doit = 1;		
						end
		endcase
	end
		
endmodule
