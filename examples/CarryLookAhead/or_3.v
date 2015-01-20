// or3.v
// 3-input, 1 bit OR gate
`timescale 1ns / 1ps

module or3
  (input A, B, C, 
   output F);

wire t0;

or2 or2_1 (.A(A), .B(B), .F(t0));
or2 or2_2 (.A(t0),.B(C), .F(F));

endmodule


