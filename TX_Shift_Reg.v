`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 2												         //
//  File name: TX_Shift_Register.v	                              //
//                                                                //
//  Created by Harrison Fitch on 10/8/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: Shift Register file for Transmit Engine. Contains 	//
//  the Shift Register, Load Register, and Data Register used in  //
//	 the transmitter. If load, the data being transmitted is loaded//
//	 into the shift register. In addition the configuration bits	//
//	 are used to create the 2-msb's and concatenated to the data.	//
//	 the sequence 2'b01 is concatenated to the LSB, creating the 	//
//	 transmitted data sequence.												//
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
module TX_Shift_Reg(clk, rst, load, data, BTU, PEN, OHEL, BIT8, SRR_Out, ld_r);
	input			clk, rst, load, BTU, PEN, OHEL, BIT8;
	input	[7:0]	data;
	output		SRR_Out;
	output reg  ld_r;
	
	reg [7:0]	data_r;
	reg [10:0]	SRR;
	
	wire	[1:0]	fx;
	
	//MSB data assignment based on configuration bits BIT8, OHEL, and PEN
	assign fx =	({BIT8, PEN, OHEL} == 3'd0)	?					2'b11:
					({BIT8, PEN, OHEL} == 3'd1)	?					2'b11:
					({BIT8, PEN, OHEL} == 3'd2)	?	 	 {1'b1, ^data_r[6:0]}:
					({BIT8, PEN, OHEL} == 3'd3)	?		{1'b1, ~^data_r[6:0]}:
					({BIT8, PEN, OHEL} == 3'd4)	? 	  {1'b1, data_r[7]}:
					({BIT8, PEN, OHEL} == 3'd5)	? 	  {1'b1, data_r[7]}:
					({BIT8, PEN, OHEL} == 3'd6)	?	 {^data_r, data_r[7]}:
					({BIT8, PEN, OHEL} == 3'd7)	?	{~^data_r, data_r[7]}:
																				2'b11;
	//Shift Out Bit
	assign SRR_Out = SRR[0];
	
	always @(posedge clk, posedge rst)begin
		if(rst)begin
			ld_r <= 1'b0;
			data_r <= 8'b0;
			SRR <= 11'h7FF;
			end
		else begin
			//load register
			ld_r <= load;
			//data register
			if(load)
				data_r <= data;
			//load data into the shift register
			if(ld_r)
				SRR <= {fx, data[6:0], 2'b01};
			//shift out bits
			else if(BTU)
				SRR <= {1'b1, SRR} >> 1;
		end
	end
	
endmodule
