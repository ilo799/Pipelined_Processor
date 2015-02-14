//3-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=00
//B=01
//C=1X
module MUX3_n #(parameter  n=32) (F,A,B,C,Sel);
  input [n-1: 0] A, B, C;
  input  [1:0] Sel;
  output [n-1: 0] F;
  wire [n-1: 0] Wire1;

  MUX2_n #(n) MUX2_32_1(Wire1, A, B, Sel[0]);
  MUX2_n #(n) MUX2_32_2(F, Wire1, C, Sel[1]);

endmodule  
