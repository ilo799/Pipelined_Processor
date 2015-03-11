module TwosComplement (R, A);
  output [0:31] R;
  input [0:31] A;

  wire [0:31] not_a;

  NOT_n #(32) not_gate(not_a, A);
  LCU32bit plus_one(.inA(not_a), .inB(32'd1), .sum(R), .c0(0));
endmodule
