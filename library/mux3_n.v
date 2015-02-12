//3-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=00
//B=01
//C=1X
//
module MUX2_n #(parameter  n=32) (F,A,B,C Sel);
  input [n-1: 0] A, B;
  input  Sel[1:0];
  output [n-1: 0] F;
  wire [n-1: 0] Wire1;

  MUX2_n #(32) MUX2_32_1(Wire1, A, B, Sel[0]);
  MUX2_n #(32) MUX2_32_2(F, Wire1, C, Sel[1]);

endmodule  
