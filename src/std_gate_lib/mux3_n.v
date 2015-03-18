//3-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=00
//B=01
//C=1X
module MUX3_n #(parameter  n=32) (F,A,B,C,Sel);
//synopsis template 
  input [0 : n-1] A, B, C;
  input [0:1] Sel;
  output [0 : n-1] F;
  wire [0 : n-1] Wire1;

  MUX2_n #(n) MUX2_32_1(Wire1, A, B, Sel[1]);
  MUX2_n #(n) MUX2_32_2(F, Wire1, C, Sel[0]);

endmodule  
