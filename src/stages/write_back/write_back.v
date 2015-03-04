module WriteBack (
  // Out
  // TODO
  
  // In
  clk, reset, stall,
  NextRegWE, NextRegWBAddr, NextJumpType, NextCondSrc, NextBranchCond
);

  input clk, reset, stall;
  input NextRegWE;
  input [0:5] NextRegWBAddr;
  input [0:1] NextJumpType;
  input NextCondSrc, NextBranchCond;

  reg RegWE;
  reg [0:5] RegWBAddr;
  reg [0:1] NextJumpType;
  reg NextCondSrc, NextBranchCond;

  always @(posedge clk) begin
    if (!stall) begin
      RegWE <= NextRegWE;
      RegWBAddr <= NextRegWBAddr;
      NextJumpType <= NextNextJumpType;
      NextCondSrc <= NextNextCondSrc;
      NextBranchCond <= NextNextBranchCond;
    end
  end
endmodule
