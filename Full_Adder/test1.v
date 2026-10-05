`timescale 1ns / 1ps

module test1;

    // Inputs
    reg x;
    reg y;
    reg z;

    // Outputs
    wire s;
    wire c;

    // Instantiate the Unit Under Test (UUT)
    fulladder1 uut (
        .x(x),
        .y(y),
        .z(z),
        .s(s),
        .c(c)
    );

    initial begin

        // Initialize Inputs
        x = 0;
        y = 0;
        z = 0;

        #100;

        x = 0;
        y = 0;
        z = 1;

        #100;

        x = 0;
        y = 1;
        z = 0;

        #100;

        x = 0;
        y = 1;
        z = 1;

        #100;

        x = 1;
        y = 0;
        z = 0;

        #100;

        x = 1;
        y = 0;
        z = 1;

        #100;

        x = 1;
        y = 1;
        z = 0;

        #100;

        x = 1;
        y = 1;
        z = 1;

        #100;

    end

endmodule
