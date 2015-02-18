module ALU(R, A, B, ALUOp, ALUCruft);
  input [0:31] A, B;
  input [0:2] ALUOp;
  input [0:1] ALUCruft;
  output [0:31] R;

  wire [0:31] shift_result, add_result, and_result, or_result, xor_result, seq_result, slt_result, sgt_result, bottom_results, top_results;
  wire [0:31] not_b, adder_a, adder_b;
  wire should_sub, add_ored;

  assign should_sub = ALUCruft[0] | (ALUOp[0] & (ALUOp[1] | ALUOp[2]));
  assign adder_cin = should_sub;

  NOT_n #(32) not_b_gate(not_b, B);
  MUX2_n #(32) adder_b_mux(adder_b, B, not_b, should_sub);

  AND2_n #(32) and_gate(and_result, A, B);
  OR2_n #(32)  or_gate(or_result, A, B);
  XOR2_n #(32) xor_gate(xor_result, A, B);
  LCU32bit adder(.inA(A), .inB(adder_b), .sum(add_result), .c0(adder_cin));
  Shifter shifter(shift_result, A, B[27:31], ALUCruft[0], ALUCruft[1]);

  assign seq_result[0:30] = 0;
  assign add_ored = |add_result;
  assign seq_result[31] = add_ored ^ ALUCruft[0];
  // MUX2_n #(1) seq_mux(seq_result[31], add_ored, !add_ored,  ALUCruft[0]);

  assign slt_result[0:30] = 0;
  // MUX2_n #(1) slt_mux(slt_result[31], !add_result[0], add_result[0], ALUCruft[0]);
  assign slt_result[31] = add_result[0] ~^ ALUCruft[0];
  
  assign sgt_result[0:30] = 0;
  // MUX2_n #(1) sgt_mux(sgt_result[31], add_result[0], !add_result[0], ALUCruft[0]);
  assign sgt_result[31] = add_result[0] ^ ALUCruft[0];

  MUX4_n #(32) bottom_mux(
    .F(bottom_results),
    .A(shift_result),
    .B(and_result),
    .C(or_result),
    .D(xor_result),
    .Sel(ALUOp[1:2])
  );

  MUX4_n #(32) top_mux(
    .F(top_results),
    .A(add_result),
    .B(seq_result),
    .C(slt_result),
    .D(sgt_result),
    .Sel(ALUOp[1:2])
  );

  MUX2_n #(32) r_mux(R, bottom_results, top_results, ALUOp[0]);
endmodule
