//3-input 1-bit MUX 
//Copyright: Northwestern EECS 362 Team Senioritis 

//A= 00
//B= 01
//C= 10, 11

module MUX3_1(F, A, B, C, Sel_0, Sel_1);
 
  input  A, B, C, Sel_0, Sel_1;
  output F;
  wire Mux0_out;

  MUX2_1 MUX0(Mux0_out, A, B, Sel_0);
  MUX2_1 MUX1(F, Mux0_out, C, Sel_1);
endmodule  
