// CB.v

// 1 bit Carry Block

`timescale 1ns / 1ps

module CB
(input G, P, C_in,
 output C_out);
 
 wire t0;

and2 and2_1(.A(P), .B(C_in), .F(t0));
or2 or2_1(.A(G), .B(t0), .F(C_out));

endmodule

