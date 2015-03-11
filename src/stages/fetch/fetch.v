module Fetch (
  OpCode, Function, PCPlusFour, 
  Rs1, Rs2, Rd, Immediate,
  clk, reset, stall,
  JumpType, BranchCond, CondSrc, ALUOut, FPSR, JumpReg, IAR
);

  parameter InitAddress = 0;
  parameter MemFile = "../../class_examples/fibExample/instr.hex";

  input clk, reset, stall;
  
  //From Decode Stage (async)
  input [0:1] JumpType;
  input BranchCond, CondSrc;

  //From Exe Stage (asyn) 
  input [0:31] ALUOut, FPSR, JumpReg, IAR;

  output [0:5] OpCode, Function;
  output [0:31] PCPlusFour;
  output [0:4] Rs1, Rs2, Rd;
  output [0:15] Immediate;

  wire[0:5] op_code, funct;
  wire pc_stall;

  Hazard_Detect hazard_detect(
  //In 
  //  RegWrAddr_Dec, RegWrAddr_Exe, RegWrAddr_Mem, RegWrAddr_WB,
  .Rs1(Rs1), .Rs2(Rs2), .OpCode_In(op_code), .Function_In(funct), .clk(clk), .reset(reset), 
  //Out
  .OpCode(OpCode), .Function(Function), .PC_stall(pc_stall)
  );

  InstructionFetch #(.MemFile(MemFile), .InitAddress(InitAddress))  ifetch(
    op_code, funct, PCPlusFour, 
    Rs1, Rs2, Rd, Immediate,
    clk, reset, pc_stall,
    JumpType, BranchCond, CondSrc, ALUOut, FPSR, JumpReg, IAR
  );

endmodule
