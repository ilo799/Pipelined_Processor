module EXEForward(
  // Out
  EXEASrc, EXEBSrc,
  // In
  MEMRd, WBRd, MEMOpCode, WBOpCode, MEMFunction, WBFunction, Rs1, Rs2, ALUSrc
);

  output [0:1] EXEASrc, EXEBSrc;
  input [0:5] MEMRd, WBRd, Rs1, Rs2;
  input [0:5] MEMOpCode, WBOpCode, MEMFunction, WBFunction;
  input ALUSrc;

  wire rs1_eq_mem_rd, rs2_eq_mem_rd, rs1_eq_wb_rd, rs2_eq_wb_rd;
  wire mem_forwardable, wb_forwardable, mem_forward_a, mem_forward_b, wb_forward_a, wb_forward_b;

  EQ2_n #(6) rs1_mem_gate(rs1_eq_mem_rd, Rs1, MEMRd);
  EQ2_n #(6) rs2_mem_gate(rs2_eq_mem_rd, Rs2, MEMRd);
  EQ2_n #(6) rs1_wb_gate(rs1_eq_wb_rd, Rs1, WBRd);
  EQ2_n #(6) rs2_wb_gate(rs2_eq_wb_rd, Rs2, WBRd);

  assign mem_forwardable = (MEMOpCode == 6'h00 & MEMFunction != 6'h15) | (MEMOpCode == 6'h01) | (MEMOpCode >= 6'h08 & MEMOpCode <= 6'h0f) | (MEMOpCode >= 6'h12 & MEMOpCode <= 6'h1d);
  assign wb_forwardable = (WBOpCode == 6'h00 & WBFunction != 6'h15) | (WBOpCode == 6'h01) | (WBOpCode >= 6'h08 & WBOpCode <= 6'h0f) | (WBOpCode >= 6'h12 & WBOpCode <= 6'h27);

  AND2_n #(1) mem_forward_a_gate(mem_forward_a, mem_forwardable, rs1_eq_mem_rd);
  AND2_n #(1) mem_forward_b_gate(mem_forward_b, mem_forwardable, rs2_eq_mem_rd);
  AND2_n #(1) wb_forward_a_gate(wb_forward_a, wb_forwardable, rs1_eq_wb_rd);
  AND2_n #(1) wb_forward_b_gate(wb_forward_b, wb_forwardable, rs2_eq_wb_rd);

  // EXEASrc
  // -------
  // 00 - Pipeline register (register file)
  // 01 - X
  // 10 - MEM Forwarded
  // 11 - WB Forwarded
  //
  // mfa wbfa O
  // -----------
  // 0   0    00
  // 0   1    11
  // 1   0    10
  // 1   1    10
  OR2_n #(1) exe_a_src_0_gate(EXEASrc[0], mem_forward_a, wb_forward_a);
  AND2_n #(1) exe_a_src_1_gate(EXEASrc[1], !mem_forward_a, wb_forward_a);

  // EXEBSrc
  // -------
  // 00 - Pipeline register (register file)
  // 01 - Immediate value
  // 10 - MEM Forwarded
  // 11 - WB Forwarded
  //
  // ALUSrc mfa wbfa O
  // ------------------
  // 0      0   0    00
  // 0      0   1    11
  // 0      1   0    10
  // 0      1   1    10
  // 1      X   X    01
  assign EXEBSrc[0] = !ALUSrc & (mem_forward_b | wb_forward_b);
  assign EXEBSrc[1] = ALUSrc | (!mem_forward_b & wb_forward_b);

endmodule
