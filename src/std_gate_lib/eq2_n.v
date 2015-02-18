//2-input n-bit Equality checker
//***32-bit by default***
//Copyright: Northwestern EECS 362 Team Senioritis 

module EQ2_n #(parameter n=32) (F, A, B);
  input [0 : n-1] A, B;
  output F;

  wire [0 : n-1] a_xor_b, a_xnor_b;

  XOR2_n #(n) xor1 (a_xor_b, A, B);
  NOT_n #(n) not1 (a_xnor_b, a_xor_b);
  assign F = &a_xnor_b;
endmodule
