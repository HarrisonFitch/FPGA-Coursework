`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:32:28 12/09/2017
// Design Name:   Memory_Interface_Block
// Module Name:   C:/Users/harri/Desktop/CECS 460/Projects/CECS460_Project_4/MIB_tb.v
// Project Name:  CECS460_Project_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Memory_Interface_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIB_tb;
`include "cellram_parameters.vh"
	// Inputs
	reg clk;
	reg rst;
	reg write;
	reg read;
	reg cs;
	reg [15:0] data_in;
	//reg [21:0] address;
	reg [15:0] o_p;
	reg [2:0] R_sel;

	// Outputs
	wire                 [31:0] dq;
	wire [15:0] data_out;
	wire CE;
	wire WE;
	wire OE;
	wire ADV;
	wire CRE;
	wire UB;
	wire LB;
	wire [22:0] A;
	wire o_wait;
	
	wire          [DQ_BITS-1:0] dq_in = dq;
	// dq transmit
	reg           [DQ_BITS-1:0] dq_out;
   assign                      dq = {{32-DQ_BITS{1'bz}}, dq_out};
	assign			data_out = dq_in;
	// Instantiate the Unit Under Test (UUT)
	Memory_Interface_Block uut (
		.clk(clk), 
		.rst(rst), 
		.write(write), 
		.read(read), 
		.cs(cs), 
		.data_in(data_in), 
		.data_out(data_out), 
		.o_p(o_p), 
		.CE(CE), 
		.WE(WE), 
		.OE(OE), 
		.ADV(ADV), 
		.CRE(CRE), 
		.UB(UB), 
		.LB(LB), 
		.A(A), 
		.R_sel(R_sel)
	);
	cellram ram (
        .clk    (1'b0),
        .adv_n  (ADV),
        .cre    (CRE),
        .o_wait (o_wait),
        .ce_n   (CE),
        .oe_n   (OE),
        .we_n   (WE),
        .ub_n   (UB),
        .lb_n   (LB),
        .addr   (A),
        .dq     (dq)
    );
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		write = 0;
		read = 0;
		cs = 0;
		data_in = dq_out;
		o_p = 0;
		R_sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		write = 0;
		read = 0;
		cs = 0;
		data_in = dq_out;
		o_p = 0;
		R_sel = 0;  
		
		#150000;
		@(negedge clk)begin
			R_sel = 3'b001;
		end
		@(negedge clk)begin
			o_p = 16'h4;
		end
		@(negedge clk)begin
			R_sel = 3'b010;
		end
		@(negedge clk)begin
			o_p = 16'h0;
		end
		@(negedge clk)begin
			R_sel = 3'b100;
		end
		@(negedge clk)begin
			o_p = 16'h7F;
		end
		@(negedge clk)begin
			write = 1;
		end
		@(negedge clk)begin
			write = 0;
		end
		#150;
		@(negedge clk)begin
			read = 1;
		end
		@(negedge clk)begin
			read = 0;
		end

	end
      
endmodule

