//3-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=00
//B=01
//C=10
//D=11
module MUX4_n #(parameter  n=32) (F,A,B,C,D,Sel);
  input [0 : n-1] A, B, C, D;
  input [0:1] Sel;

  output [0 : n-1] F;

  wire [0 : n-1] ab, cd;

  MUX2_n #(n) ab_mux (ab, A, B, Sel[1]);
  MUX2_n #(n) bc_mux (cd, C, D, Sel[1]);
  MUX2_n #(n) f_mux  (F, ab, cd, Sel[0]);
endmodule
