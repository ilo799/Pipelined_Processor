module Fetch (
  OpCode, Function, PCPlusFour, PCPlusEight,
  Rs1, Rs2, Rd, Immediate,
  clk, reset, stall,
  JumpType, BranchCond, CondSrc, ALUOut, FPSR, JumpReg, IAR
);

  input clk, reset, stall;
  input [0:1] JumpType;
  input BranchCond, CondSrc;
  input [0:31] ALUOut, FPSR, JumpReg, IAR;

  output [0:5] OpCode, Function;
  output [0:31] PCPlusFour, PCPlusEight;
  output [0:4] Rs1, Rs2, Rd;
  output [0:15] Immediate;

  InstructionFetch ifetch(
    OpCode, Function, PCPlusFour, PCPlusEight,
    Rs1, Rs2, Rd, Immediate,
    clk, reset, stall,
    JumpType, BranchCond, CondSrc, ALUOut, FPSR, JumpReg, IAR
  );

endmodule
