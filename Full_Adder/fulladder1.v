module fulladder1(
    input x,
    input y,
    input z,
    output s,
    output c
    );

    wire c1, c2, a1;

    HA HA1(x, y, c1, a1);
    HA HA2(z, a1, c2, s);
    or(c, c1, c2);

endmodule


module HA(a, b, c, s);

    input a, b;
    output wire c, s;

    xor(s, a, b);
    and(c, a, b);

endmodule
