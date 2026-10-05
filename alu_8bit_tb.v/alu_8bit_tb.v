`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:25:20 10/05/2026
// Design Name:   alu_8bit
// Module Name:   /home/ise/alu_8bit/alu_8bit_tb.v
// Project Name:  alu_8bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_8bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_8bit_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [3:0] ALU_Sel;

	// Outputs
	wire [7:0] Result;

	// Instantiate the Unit Under Test (UUT)
	alu_8bit uut (
		.A(A), 
		.B(B), 
		.ALU_Sel(ALU_Sel), 
		.Result(Result)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		ALU_Sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 8'd16;
		B = 8'd8;
		ALU_Sel = 4'b0000; #100;
		ALU_Sel = 4'b0001; #100;
		ALU_Sel = 4'b0010; #100;
		ALU_Sel = 4'b0011; #100;
		ALU_Sel = 4'b0100; #100;
		ALU_Sel = 4'b0101; #100;
		ALU_Sel = 4'b0110; #100;
		ALU_Sel = 4'b0111; #100;
		ALU_Sel = 4'b1000; #100;
		ALU_Sel = 4'b1001; #100;
		ALU_Sel = 4'b1010; #100;
		ALU_Sel = 4'b1011; #100;
		ALU_Sel = 4'b1100; #100;
		end
		endmodule


