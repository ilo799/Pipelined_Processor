module MUX2_1(F,A,B, Sel);

  input  A, B, Sel;
  output F;
  wire Not_Sel, Wire1, Wire2;

  not (Not_Sel, Sel);
  and(Wire1, A, Not_Sel); //choose if Sel == 0
  and (Wire2, B, Not_Sel); //choose if Sel == 1
  or (F, Wire1, Wire2);

endmodule  
