//2-input 1-bit MUX  
//Copyright: Northwestern EECS 362 Team Senioritis 

//A=0
//B=1

module MUX2_1(F,A,B, Sel);

  input  A, B, Sel;
  output F;
  wire Not_Sel, Wire1, Wire2;

  not (Not_Sel, Sel);
  and(Wire1, A, Not_Sel); //choose if Sel == 0
  and (Wire2, B, Sel); //choose if Sel == 1
  or (F, Wire1, Wire2);

endmodule  
