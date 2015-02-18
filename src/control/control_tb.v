// ------------------------------------------------------------------
// Testbench for Control Module
//-------------------------------------------------------------------- 

module Testbench;
  reg [0:5] OpCodes[0:91];
  reg [0:5] Functions[0:91];
  reg [0:1] DInSrcs[0:91];
  reg RegWEs[0:91];
  reg FPDests[0:91];
  reg [0:1] RegDests[0:91];
  reg [0:1] JumpTypes[0:91];
  reg CondSrcs[0:91];
  reg BranchConds[0:91];
  reg FPSrcs[0:91];
  reg [0:2] ALUOps[0:91];
  reg [0:1] ALUCrufts[0:91];
  reg ALUSrcs[0:91];
  reg ExtImms[0:91];
  reg [0:1] MEMSizes[0:91];
  reg MEMWEs[0:91];
  reg ExtMEMs[0:91];

  integer i;

  reg [0:5] OpCode;
  reg [0:5] Function;

  wire Test;

  // WB Control
  wire [0:1] DInSrc;
  wire RegWE, FPDest;
  wire [0:1] RegDest;

  // IFetch Control
  wire [0:1] JumpType;
  wire CondSrc, BranchCond;

  // Reg/Decode Control
  wire FPSrc;

  // EXE Control
  wire [0:2] ALUOp;
  wire [0:1] ALUCruft;
  wire [0:2] FPUOp;
  wire ALUSrc, ExtImm;

  // MEM Control
  wire [0:1] MEMSize;
  wire MEMWE, ExtMEM;

  Control ctrl(
    .OpCode(OpCode),
    .Function(Function),
    .DInSrc(DInSrc),
    .RegWE(RegWE),
    .FPDest(FPDest),
    .RegDest(RegDest),
    .JumpType(JumpType),
    .CondSrc(CondSrc),
    .BranchCond(BranchCond),
    .FPSrc(FPSrc),
    .ALUOp(ALUOp),
    .ALUCruft(ALUCruft),
    .FPUOp(FPUOp),
    .ALUSrc(ALUSrc),
    .ExtImm(ExtImm),
    .MEMSize(MEMSize),
    .MEMWE(MEMWE),
    .ExtMEM(ExtMEM)
  );

  initial begin
    $readmemh("test_data/OpCode.list", OpCodes);
    $readmemh("test_data/Function.list", Functions);
    $readmemb("test_data/DInSrc.list", DInSrcs);
    $readmemb("test_data/RegWE.list", RegWEs);
    $readmemb("test_data/FPDest.list", FPDests);
    $readmemb("test_data/RegDest.list", RegDests);
    $readmemb("test_data/JumpType.list", JumpTypes);
    $readmemb("test_data/CondSrc.list", CondSrcs);
    $readmemb("test_data/BranchCond.list", BranchConds);
    $readmemb("test_data/FPSrc.list", FPSrcs);
    $readmemb("test_data/ALUOp.list", ALUOps);
    $readmemb("test_data/ALUCruft.list", ALUCrufts);
    $readmemb("test_data/ALUSrc.list", ALUSrcs);
    $readmemb("test_data/ExtImm.list", ExtImms);
    $readmemb("test_data/MEMSize.list", MEMSizes);
    $readmemb("test_data/MEMWE.list", MEMWEs);
    $readmemb("test_data/ExtMEM.list", ExtMEMs);

    $dumpfile("control.vcd");
    $dumpvars;

    $display("\t\ttime,\tOp,\tFn,\tDInSrc");
    $monitor("%d,\t%h,\t%h\t%b", $time, OpCode, Function, DInSrc);

    for (i = 0; i < 92; i = i+1)
    begin
      OpCode = OpCodes[i]; Function = Functions[i];

      #5

      if (DInSrc != DInSrcs[i])
      begin
        $display("ERROR(DInSrc): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, DInSrcs[i], DInSrc);
      end

      if (RegWE != RegWEs[i])
      begin
        $display("ERROR(RegWE): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, RegWEs[i], RegWE);
      end

      if (FPDest != FPDests[i])
      begin
        $display("ERROR(FPDest): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, FPDests[i], FPDest);
      end

      if (RegDest != RegDests[i])
      begin
        $display("ERROR(RegDests): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, RegDests[i], RegDest);
      end

      if (JumpType != JumpTypes[i])
      begin
        $display("ERROR(JumpType): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, JumpTypes[i], JumpType);
      end

      if (CondSrc != CondSrcs[i])
      begin
        $display("ERROR(CondSrc): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, CondSrcs[i], CondSrc);
      end

      if (BranchCond != BranchConds[i])
      begin
        $display("ERROR(BranchCond): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, BranchConds[i], BranchCond);
      end

      if (FPSrc != FPSrcs[i])
      begin
        $display("ERROR(FPSrc): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, FPSrcs[i], FPSrc);
      end

      if (ALUOp != ALUOps[i])
      begin
        $display("ERROR(ALUOp): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, ALUOps[i], ALUOp);
      end

      if (ALUCruft != ALUCrufts[i])
      begin
        $display("ERROR(ALUCruft): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, ALUCrufts[i], ALUCruft);
      end

      if (ALUSrc != ALUSrcs[i])
      begin
        $display("ERROR(ALUSrc): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, ALUSrcs[i], ALUSrc);
      end

      if (ExtImm != ExtImms[i])
      begin
        $display("ERROR(ExtImm): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, ExtImms[i], ExtImm);
      end

      if (MEMSize != MEMSizes[i])
      begin
        $display("ERROR(MEMSize): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, MEMSizes[i], MEMSize);
      end

      if (MEMWE != MEMWEs[i])
      begin
        $display("ERROR(MEMWE): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, MEMWEs[i], MEMWE);
      end

      if (ExtMEM != ExtMEMs[i])
      begin
        $display("ERROR(ExtMEM): OpCode: %h, Function: %h, expected %b, got %b", OpCode, Function, ExtMEMs[i], ExtMEM);
      end
    end
  end
endmodule
