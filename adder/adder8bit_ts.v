`timescale 1ns / 1ps

module add_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg cin;

    // Outputs
    wire [7:0] s;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    adder uut (
        .s(s),
        .cout(cout),
        .a(a),
        .b(b),
        .cin(cin)
    );

    initial begin

        // Test Case 1: 8 + 7 + 0 = 15
        a = 8'd8;
        b = 8'd7;
        cin = 0;

        #100;

        // Test Case 2: 16 + 9 + 1 = 26
        a = 8'd16;
        b = 8'd9;
        cin = 1;

        #100;

        // Test Case 3: 20 + 6 + 1 = 27
        a = 8'd20;
        b = 8'd6;
        cin = 1;

        #100;

    end

endmodule
