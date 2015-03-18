//32 bit integer multiplier
//Copyright: Northwestern EECS 362 Team Senioritis 

//TODO: Overflow?

module Multiplier (F,A,B);
  input [0 : 31] A, B;
  output [0 : 31] F;

  assign F = A*B;

endmodule  


