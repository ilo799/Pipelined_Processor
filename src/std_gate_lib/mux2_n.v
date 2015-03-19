//2-to-1 n-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=0
//B=1
module MUX2_n #(parameter  n=32) (F,A,B, Sel); //synopsys template 
  input [0 : n-1] A, B;
  input  Sel;
  output [0 : n-1] F;
  wire [0 : n-1] Wire1, Wire2;
  wire Not_Sel;

  not (Not_Sel, Sel);
  //check if this is synth?
  AND2_n #(n) AND0(Wire1, A, {n{Not_Sel}});
  AND2_n #(n) AND1(Wire2, B, {n{Sel}});
  OR2_n #(n)  OR2_32(F, Wire1, Wire2);
endmodule  
