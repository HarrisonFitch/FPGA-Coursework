`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:03 10/28/2017
// Design Name:   UART_Top_Level
// Module Name:   C:/Users/harri/Desktop/CECS 460/Projects/CECS460_Project_3/UART_Top_TB.v
// Project Name:  CECS460_Project_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Top_Level
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_Top_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg eight;
	reg pen;
	reg ohel;
	reg RX;

	// Outputs
	wire TX;
	wire [15:0] LEDs;

	// Instantiate the Unit Under Test (UUT)
	UART_Top_Level uut (
		.clk(clk), 
		.rst(rst), 
		.baud(baud), 
		.eight(eight), 
		.pen(pen), 
		.ohel(ohel), 
		.RX(RX), 
		.TX(TX), 
		.LEDs(LEDs)
	);
	integer i;
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		baud = 4'hb;
		eight = 1;
		pen = 0;
		ohel = 0;
		RX = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		for(i = 0; i <10; i = i+1)
			#1085 RX = ~RX;
        
		// Add stimulus here

	end
      
endmodule

