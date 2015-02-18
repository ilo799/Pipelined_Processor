module Testbench;
  reg clk, reset;
  reg [0:1] JumpType;
  reg BranchCond, CondSrc;
  reg [0:31] JumpReg, IAR, ALUOut, FPSR;

  wire [0:5] OpCode, Function;
  wire [0:31] PCPlusFour;
  wire [0:4] Rs1, Rs2, Rd;
  wire [0:15] Immediate;

  InstructionFetch ifetch(
    .OpCode(OpCode),
    .Function(Function),
    .PCPlusFour(PCPlusFour),
    .Rs1(Rs1),
    .Rs2(Rs2),
    .Rd(Rd),
    .Immediate(Immediate),
    .clk(clk),
    .reset(reset),
    .JumpType(JumpType),
    .BranchCond(BranchCond),
    .CondSrc(CondSrc),
    .ALUOut(ALUOut),
    .FPSR(FPSR),
    .JumpReg(JumpReg),
    .IAR(IAR)
  );

  initial begin
    $dumpfile("ifetch.vcd");
    $dumpvars;

    $display("PC\t\tOp\tFn\tRs1\tRs2\tRd\tImm");
    $monitor("%h\t%h\t%h\t%h\t%h\t%h\t%h", ifetch.PC, OpCode, Function, Rs1, Rs2, Rd, Immediate);

    clk = 0;
    JumpType = 0;
    BranchCond = 0;
    CondSrc = 0;
    ALUOut = 0;
    FPSR = 0;
    JumpReg = 0;
    IAR = 0;

    reset = 1;
    #5 reset = 0;
    #730 $finish;
  end

  always begin
    #5 clk = !clk;
  end
endmodule
