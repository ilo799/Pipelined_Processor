// or5.v
// 5-input, 1 bit OR gate
`timescale 1ns / 1ps

module or5
  (input A, B, C, D, E, 
   output F);

wire t0;

or4 or2_1 (.A(A), .B(B), .C(C), .D(D), .F(t0));
or2 or2_2 (.A(t0), .B(E), .F(F));

endmodule

