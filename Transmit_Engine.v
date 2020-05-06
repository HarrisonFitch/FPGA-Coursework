`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 2												         //
//  File name: Transmit_Engine.v	                                 //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Top level for the Transmit Engine of the UART.  	   //
//  The transmitter has the configuration inputs eight, pen, ohel //
//	 and baud. The outputs are tx_out and tx_outRDY. tx_out is the data being  //
//	 transmitted while tx_outRDY is a flag to tell when the data is 	//
//	 ready to be transmitted.													//
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
module Transmit_Engine(clk, rst, load, data, eight, pen, ohel, baud, tx_outRDY, tx_out);
	input 			clk, rst, load, eight, pen, ohel;
	input	[3:0]		baud;
	input	[7:0]		data;
	output			tx_outRDY;
	output			tx_out;
	
	reg				DONE_D1;
	reg	[3:0]		BC;
	reg	[18:0]	BTC;
	wire				BTU, DOIT, DONE, LOAD_D1;
	wire	[18:0]	rate;
	
	TX_Shift_Reg	shift_reg(.clk(clk), .rst(rst), .load(load), .data(data),
										.BTU(BTU), .PEN(pen), .OHEL(ohel), .BIT8(eight),
										.SRR_Out(tx_out), .ld_r(LOAD_D1));
	TX_RS_flop		txrdy_rs(.r(load), .s(DONE_D1), .clk(clk), .rst(rst), .q(tx_outRDY));
	
	RS_flop		doit_rs(.r(DONE_D1), .s(LOAD_D1), .clk(clk), .rst(rst), .q(DOIT));
	
	
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
											
	//Bit Time Counter and Bit Counter block
	//Bit Time Counter: The amount of time between each bit to fit the baud rate.
	//Bit Counter: The current amount of bits sent.
	always @(posedge clk, posedge rst)begin
		if(rst)begin
			BC <= 4'b0;
			BTC <= 19'b0;
			DONE_D1 <= 1'b0;
		end
		else begin
		//MUX for Bit Time Counter and Bit Counter
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
			endcase
			DONE_D1 <= DONE;
		end
	end
	//If baud rate count is reached BTU			
	assign BTU	= (rate == BTC) ? 1'b1:
										1'b0;
	//If bit count is reached DONE
	assign DONE = (4'd11 == BC) ? 1'b1:
										1'b0;

endmodule
