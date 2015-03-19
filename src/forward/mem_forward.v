module MEMForward(
  // Out
  MEMRegBSrc,

  // In
  WBRd, MEMRs2, WBWE,
);

  input WBWE;
  input [0:5] WBRd, MEMRs2;

  output MEMRegBSrc;

  wire rd_eq_rs2;

  EQ2_n #(6) rd_eq_rs2_gate(rd_eq_rs2, WBRd, MEMRs2);

  // MEMRegBSrc
  // ==========
  // 0 - EX/MEM Pipeline Reg
  // 1 - Forwarded from WB Stage
  AND2_n #(1) mem_reg_b_src_gate(MEMRegBSrc, rd_eq_rs2, WBWE);

endmodule
