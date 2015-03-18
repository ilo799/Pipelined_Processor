// Floating Pt Unit
//Copyright: Northwestern EECS 362 Team Senioritis 


module fpu (F, A, B, FPUOp);
  input [0 : 31] A, B;
  input [0:2] FPUOp;
  output [0 : 31] F;

  Multiplier Multiplier0(.F(F), .A(A), .B(B));


endmodule  


