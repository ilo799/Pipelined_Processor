//2-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=0
//B=1
module MUX2_n #(parameter  n=32) (F,A,B, Sel);
  input [n-1: 0] A, B;
  input  Sel;
  output [n-1: 0] F;
  wire [n-1: 0] Wire1, Wire2;
  wire Not_Sel;

  not (Not_Sel, Sel);
  //check if this is synth?
  AND2_n #(32) AND0(Wire1, A, {n{Not_Sel}});
  AND2_n #(32) AND1(Wire2, B, {n{Sel}});
  OR2_n #(32)  OR2_32(F, Wire1, Wire2);
endmodule  
