`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 3												         //
//  File name: Receive_Datapath.v	                              //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Datapath for Receive Engine. This datapath contains	//
//  a shift register for the Received bits, a REMAP net that right//
//	 justifies the shifted in bits, and the logic to produce the 	//
//	 status flags. The possible error flags are framing error, 		//
//	 overflow error, parity error, and RXRDY. These are outputs, in//
//	 addition to the data received.											//
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
module Receive_Datapath(clk, rst, BTU, START, EIGHT, PEN, DONE, RX, EVEN, RXRDY, PERR, FERR, OVF, reads, DATA);
	input					clk, rst, EIGHT, PEN, BTU, START, RX, EVEN, DONE;
	input		 [63:0]	reads;
	output				RXRDY, PERR, FERR, OVF;
	output reg [7:0]	DATA;
	
	wire			SH, P_GEN, P_BIT, STOP_BIT, Ev_Od, perr, ferr, ovf, RXRDY, PERR, FERR, OVF;;
	wire	[9:0] REMAP;
	reg	[9:0]	SRR;
	
	RS_flop		rxrdy_rs(.r(reads[0]), .s(DONE), .clk(clk), .rst(rst), .q(RXRDY));
	
	
	RS_flop		perr_rs(.r(reads[0]), .s(perr), .clk(clk), .rst(rst), .q(PERR));
	
	RS_flop		ferr_rs(.r(reads[0]), .s(ferr), .clk(clk), .rst(rst), .q(FERR));
	
	RS_flop		ovf_rs(.r(reads[0]), .s(ovf), .clk(clk), .rst(rst), .q(OVF));
	
	//Shift in once start is low and Bit Time Up is high
	assign SH = (BTU && ~START);
	
	//REMAP combo logic, right justify the bits from the shift register
	assign REMAP = ({EIGHT, PEN} == 2'b00) ? {3'b0,	SRR[9:2]}:
						({EIGHT, PEN} == 2'b01) ? {2'b0,	SRR[9:1]}:
						({EIGHT, PEN} == 2'b10) ? {2'b0, SRR[9:1]}:
																	SRR[9:0];
	//Parity generation MUX
	assign P_GEN = (EIGHT)	?	REMAP[7]:
											 1'b0;
	//Parity Bit select MUX											
	assign P_BIT = (EIGHT)	?	REMAP[8]:
										REMAP[7];
	//Stop Bit MUX
	assign STOP_BIT =	({EIGHT, PEN} == 2'b00)	?	REMAP[7]:
							({EIGHT, PEN} == 2'b01)	?	REMAP[8]:
							({EIGHT, PEN} == 2'b10)	?	REMAP[8]:
																REMAP[9];
	
	//even or odd parity mux														
	assign Ev_Od = (~EVEN)	?	^{P_GEN, REMAP[6:0]}:
									 ~(^{P_GEN, REMAP[6:0]});
	
	//and gate to detect parity error
	assign perr = PEN && (P_BIT ^ Ev_Od) && DONE;
	
	//and gate to detect framing error
	assign ferr = DONE && ~STOP_BIT;
	
	//and gate to detect overflow error
	assign ovf = DONE && START;
	
	
	always @(posedge clk, posedge rst)begin
		if(rst)begin
			SRR <= 10'h0;
			end
		else begin
			//shift in register
			if(SH)begin
				SRR[9] <= RX;//shift in RX input
				SRR[8:0] <= SRR[9:1];
			end
			//shift out bits
			else 
				SRR <= SRR;
		end
	end
	
	//assign out data
	always @(*)begin
		DATA = (EIGHT) ? REMAP[7:0]: {1'b0, REMAP[6:0]};
	end
	
	

endmodule
