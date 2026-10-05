`timescale 1ns / 1ps
module alu_8bit(
    input [7:0] A,
    input [7:0] B,
    input [3:0] ALU_Sel,
    output reg [7:0] Result
    );
always @(*) begin
    case(ALU_Sel) 
      4'b0000: Result = A + B;
      4'b0001: Result = A - B;
      4'b0010: Result = A * B;
      4'b0011: Result = A / B;
      4'b0100: Result = A & B;
		4'b0101: Result = A | B;
		4'b0110: Result = A ^ B;
		4'b0111: Result = ~A ;
		4'b1000: Result = A << 1;
		4'b1001: Result = A >> 1;
		4'b1010: Result = A == B;
		4'b1011: Result = A > B;
		4'b1100: Result = A < B;
		default: Result = 8'b00000000;
	endcase
end	
		
endmodule
