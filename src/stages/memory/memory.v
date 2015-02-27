module Memory (
  // Out
  MEMDout,

  // In
  clk, reset, stall,
  NextDIn, NextRegB, NextDInSrc, NextRegWE, NextRegWBAddr, NextJumpType, NextCondSrc,
  NextBranchCond, NextMEMSize, NextMEMWE, NextExtMEM
);

  input clk, reset, stall;
  input [0:31] NextDIn, NextRegB;
  input [0:1] NextDInSrc;
  input NextRegWE;
  input [0:5] NextRegWBAddr;
  input [0:1] NextJumpType;
  input NextCondSrc, NextBranchCond;
  input [0:1] NextMEMSize;
  input NextMEMWE;
  input NextExtMEM;

  output [0:31] MEMDout;

  reg [0:31] DIn, RegB;
  reg [0:1] DinSrc;
  reg RegWE;
  reg [0:5] RegWBAddr;
  reg [0:1] JumpType;
  reg CondSrc, BranchCond;
  reg ExtImm;
  reg [0:1] MEMSize;
  reg MEMWE;
  reg ExtMEM;

  always @(posedge clk) begin
    if (!stall) begin
      DIn <= NextDIn;
      RegB <= NextRegB;
      DinSrc <= NextDinSrc;
      RegWE <= NextRegWE;
      RegWBAddr <= NextRegWBAddr;
      JumpType <= NextJumpType;
      CondSrc <= NextCondSrc;
      BranchConde <= NextBranchCond;
      ExtImm <= NextExtImm;
      MEMSize <= NextMEMSize;
      MEMWE <= NextMEMWE;
      ExtMEM <= NextExtMEM;
    end
  end

endmodule
