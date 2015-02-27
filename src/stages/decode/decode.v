module Decode (
  // Out
  DInSrc, RegWE, FPDest, RegDest, JumpType, CondSrc, BranchCond, 
  FPSrc, ALUOp, FPUOp, ALUCruft, ALUSrc, ExtImm, MEMSize, MEMWE, ExtMEM,
  RegOut1, RegOut2,

  // In
  clk, reset, stall,
  RegWBWE, RegWBAddr, RegWBData,
  NextOpCode, NextFunction, NextPCPlusFour
);
  input clk, reset, stall;
  input [0:1] JumpType;
  input BranchCond, CondSrc;
  input [0:31] ALUOut, FPSR, JumpReg, IAR;
  input RegWBWE;
  input [0:4] RegWBAddr;
  input [0:31] RegWBData;
  input [0:31] NextOpCode, NextFunction, NextPCPlusFour;

  output [0:31] PCPlusEight;
  output [0:4] Rs1, Rs2, Rd;
  output [0:15] Immediate;
  output [0:31] RegOut1, RegOut2;

  reg [0:5] op_code;
  // Verilog doesn't like 'function'
  reg [0:5] fn;
  reg [0:31] pc_plus_four;

  always @(posedge clk) begin
    if (!stall) begin
      op_code <= NextOpCode;
      fn <= NextFunction;
      pc_plus_four <= NextPCPlusFour;
    end
  end
endmodule
