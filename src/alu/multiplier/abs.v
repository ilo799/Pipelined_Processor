module Abs(R, A);
  
  output [0:31] R;
  input [0:31] A;

  wire [0:31] twos_a;

  TwosComplement twos_comp(twos_a, A);

  MUX2_n #(32) out_mux(R, A, twos_a, A[0]);

endmodule
