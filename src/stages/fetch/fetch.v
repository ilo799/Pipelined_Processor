module Fetch (
//synopsis template 
  //Out
  OpCode, Function, PCPlusFour, 
  Rs1, Rs2, Rd, Immediate,

  //In
  clk, reset, stall,
  JumpType, BranchCond, CondSrc, BranchResult, FPSR, JumpReg, IAR, 
  DecodeRd, DecodePCPlusFour, DecodeOpCode
);

  parameter InitAddress = 0;
  parameter MemFile = "../../class_examples/fibExample/instr.hex";

  input clk, reset, stall;
  
  //From Decode Stage (async)
  input [0:1] JumpType;
  input BranchCond, CondSrc, BranchResult;
  input [0:5] DecodeRd;
  input [0:31] DecodePCPlusFour, FPSR, JumpReg, IAR; 
  input [0:5] DecodeOpCode;


  output [0:5] OpCode, Function;
  output [0:31] PCPlusFour;
  output [0:4] Rs1, Rs2, Rd;
  output [0:15] Immediate;

  wire[0:5] op_code, funct;
  wire fp_src;
 
  // FPSrc
  // -----
  // 0 - GPR
  // 1 - FPR
  assign fp_src = (op_code == 6'h00 & (funct >= 6'h32 & funct <= 6'h34))
    | (op_code == 6'h01 & ((funct >= 6'h00 & funct <= 6'h0b)|(funct >= 6'h0e & funct <= 6'h1d)|(funct >= 6'h18 & funct <= 6'h1d)))
    | (op_code == 6'h2e) | (op_code == 6'h2f);

  wire [0:5] rs1, rs2;
  assign rs1 = {fp_src, Rs1};
  assign rs2 = {fp_src, Rs2};

    wire pc_stall, need_nop;
  //Add .decode_op from decode stage.. 
  hazard hazard0 (
    .decode_rd(DecodeRd), .fetch_op(op_code), .decode_op(DecodeOpCode), .fetch_pc_plus_4(PCPlusFour), 
    .fetch_rs1(rs1), .fetch_rs2(rs2), .decode_pc_plus_4(DecodePCPlusFour), 
    .need_nop(need_nop), .pc_stall(pc_stall));

   MUX2_n #(6) mux1(OpCode, op_code, 6'h00, need_nop);
   MUX2_n #(6) mux2(Function, funct, 6'h15, need_nop);

  //try this hack, 
   wire[0:31] pc_plus_four; 
   MUX2_n #(32) mux3(PCPlusFour, pc_plus_four, 32'bX, hazard0.branch_hazard);


  InstructionFetch #(.MemFile(MemFile), .InitAddress(InitAddress))  ifetch(
    op_code, funct, pc_plus_four, 
    Rs1, Rs2, Rd, Immediate,
    clk, reset, pc_stall,
    JumpType, BranchCond, CondSrc, BranchResult, FPSR, JumpReg, IAR
  );
endmodule
