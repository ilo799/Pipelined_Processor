// or4.v
// 4-input, 1 bit OR gate
`timescale 1ns / 1ps

module or4
  (input A, B, C, D, 
   output F);

wire t0, t1;

or2 or2_1 (.A(A), .B(B), .F(t0));
or2 or2_2 (.A(C),.B(D), .F(t1));
or2 or2_3 (.A(t0), .B(t1), .F(F));

endmodule
