// and4.v
// 4-input, 1 bit AND gate
`timescale 1ns / 1ps

module and4
  (input A, B, C, D, 
   output F);

wire t0, t1;

and2 and2_1 (.A(A), .B(B), .F(t0));
and2 and2_2 (.A(C),.B(D), .F(t1));
and2 and2_3 (.A(t0), .B(t1), .F(F));

endmodule

