module DECForward (
  Src,
  MEMRd, WBRd, MEMOpCode, WBOpCode, MEMFunction, WBFunction, Rs1
);

  output [0:1] Src;
  input [0:5] MEMRd, WBRd, Rs1;
  input [0:5] MEMOpCode, WBOpCode, MEMFunction, WBFunction;

  wire rs1_eq_mem_rd, rs2_eq_mem_rd, rs1_eq_wb_rd, rs2_eq_wb_rd;
  wire mem_forwardable, wb_forwardable, mem_forward, wb_forward;

  EQ2_n #(6) rs1_mem_gate(rs1_eq_mem_rd, Rs1, MEMRd);
  EQ2_n #(6) rs1_wb_gate(rs1_eq_wb_rd, Rs1, WBRd);

  assign mem_forwardable = (MEMOpCode == 6'h00 & MEMFunction != 6'h15) | (MEMOpCode == 6'h01) | (MEMOpCode >= 6'h08 & MEMOpCode <= 6'h0f) | (MEMOpCode >= 6'h12 & MEMOpCode <= 6'h1d) | (MEMOpCode == 6'h03);
  assign wb_forwardable = (WBOpCode == 6'h00 & WBFunction != 6'h15) | (WBOpCode == 6'h01) | (WBOpCode >= 6'h08 & WBOpCode <= 6'h0f) | (WBOpCode >= 6'h12 & WBOpCode <= 6'h27) | (WBOpCode == 6'h03);

  AND2_n #(1) mem_forward_gate(mem_forward, mem_forwardable, rs1_eq_mem_rd);
  AND2_n #(1) wb_forward_gate(wb_forward, wb_forwardable, rs1_eq_wb_rd);

  // Src
  // ---
  // 00 - RegOut
  // 01 - X
  // 10 - MEM Forwarded
  // 11 - WB Forwarded

  OR2_n #(1) src_0_gate(Src[0], mem_forward, wb_forward);
  assign Src[1] = wb_forward;

endmodule
