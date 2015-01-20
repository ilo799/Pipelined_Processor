// and3.v
// 3-input, 1 bit AND gate
`timescale 1ns / 1ps

module and3
  (input A, B, C, 
   output F);

wire t0;

and2 and2_1 (.A(A), .B(B), .F(t0));
and2 and2_2 (.A(t0),.B(C), .F(F));

endmodule
