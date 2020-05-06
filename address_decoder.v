`timescale 1ns / 1ps
//****************************************************************//
//  This document contains information proprietary to the         //
//  CSULB student that created the file - any reuse without       //
//  adequate approval and documentation is prohibited             //
//                                                                //
//  Class: CECS 460												            //
//  Project name: LAB 2												         //
//  File name: address_decoder.v                                  //
//                                                                //
//  Created by Harrison Fitch on 10/7/17.                         //
//  Copyright © 2017 Harrison Fitch. All rights reserved.         //
//                                                                //
//  Abstract: This a address decoder module. It selects the       //
//  address to be output on the out_port of the tramelblaze.		//
//																						//
//  Edit history: 																//
//	 10/7/17 Now outputs reads and writes based on port_id			//
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
module address_decoder(w_s, r_s, p_id, reads, writes);
	input 			 w_s, r_s;
	input			[5:0] p_id;
	output reg 	[63:0] reads, writes;
	
	//reads and writes gets the r_s or w_s if at current port_id
	always@(*)begin
		reads = 64'b0;
		writes = 64'b0;
		reads[p_id] = r_s;
		writes[p_id] = w_s;
	end
	
endmodule
