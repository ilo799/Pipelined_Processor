module Execute (
  // Out
  ALUOut, FPUOut,

  // In
  clk, reset, stall,
  NextRegB, NextDInSrc, NextRegWE, NextRegWBAddr, NextJumpType, NextCondSrc, NextBranchCond,
  NextALUOp, NextFPUOp, NextALUCruft, NextALUSrc, NextExtImm, NextMEMSize, NextMEMWE, NextExtMEM,
);

  input clk, reset, stall;
  input [0:31] NextRegB;
  input [0:1] NextDInSrc;
  input NextRegWE;
  input [0:5] NextRegWBAddr;
  input [0:1] NextJumpType;
  input NextCondSrc, NextBranchCond;
  input [0:2] NextALUOp;
  input [0:2] NextFPUOp;
  input [0:1] NextALUCruft;
  input NextALUSrc;
  input NextExtImm;
  input [0:1] NextMEMSize;
  input NextMEMWE;
  input NextExtMEM;

  output [0:31] ALUOut, FPUOut;

  reg [0:31] RegB;
  reg [0:1] DinSrc;
  reg RegWE;
  reg [0:5] RegWBAddr;
  reg [0:1] JumpType;
  reg CondSrc, BranchCond;
  reg [0:2] ALUOp;
  reg [0:2] FPUOp;
  reg [0:1] ALUCruft;
  reg ALUSrc;
  reg ExtImm;
  reg [0:1] MEMSize;
  reg MEMWE;
  reg ExtMEM;

  always @(posedge clk) begin
    if (!stall) begin
      RegB <= NextRegB;
      DinSrc <= NextDinSrc;
      RegWE <= NextRegWE;
      RegWBAddr <= NextRegWBAddr;
      JumpType <= NextJumpType;
      CondSrc <= NextCondSrc;
      BranchCond <= NextBranchCond;
      ALUOp <= NextALUOp;
      FPUOp <= NextFPUOp;
      ALUCruft <= NextALUCruft;
      ALUSrc <= NextALUSrc;
      ExtImm <= NextExtImm;
      MEMSize <= NextMEMSize;
      MEMWE <= NextMEMWE;
      ExtMEM <= NextExtMEM;
    end
  end

endmodule
