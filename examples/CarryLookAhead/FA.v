// FA.v

// 1 bit Full Adder 

`timescale 1ns / 1ps

module FA
(input A, B, C_in,
 output G, P, S);
 
 wire t0;

and2 and2_1(.A(A), .B(B), .F(G));
xor2 xor2_2(.A(A), .B(B), .F(t0));
xor2 xor2_3(.A(t0), .B(C_in), .F(S));
assign{P}=t0;
 

endmodule
