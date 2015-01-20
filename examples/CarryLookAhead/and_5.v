// and5.v
// 5-input, 1 bit AND gate
`timescale 1ns / 1ps

module and5
  (input A, B, C, D, E, 
   output F);

wire t0;

and4 and2_1 (.A(A), .B(B), .C(C), .D(D), .F(t0));
and2 and2_2 (.A(t0),.B(E), .F(F));

endmodule

