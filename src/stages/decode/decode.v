module Decode (
  // Out
  DInSrc, RegWE, FPDest, RegDest, JumpType, CondSrc, BranchCond, 
  FPSrc, ALUOp, FPUOp, ALUCruft, ALUSrc, ExtImm, MEMSize, MEMWE, ExtMEM,
  Rd, RegOut1, RegOut2, Opcode, Funct, PC_plus_four, Immediate,  

  // In
  clk, reset, stall,
  RegWBWE, RegWBAddr, RegWBData,
  NextOpCode, NextFunction, NextPCPlusFour,
  NextRs1, NextRs2, NextRd, NextImmd  
);
  
  input clk, reset, stall;
  
  //I think this goes in WB stage
  input RegWBWE;
  input [0:4] RegWBAddr;
  input [0:31] RegWBData;
  
  input [0:31] NextPCPlusFour;
  input [0:5] NextOpCode, NextFunction;
  input [0:4] NextRs1, NextRs2, NextRd;
  input [0:15] NextImmd; 

  // Control For WB
  output[0:1] DInSrc;
  output RegWE, FPDest, FPSrc, RegDest;

  // Control For Ifetch
  output[0:1] JumpType; 
  output BranchCond, CondSrc;

  // Control For Exe
  output [0:2] ALUOp, FPUOp;
  output [0:1] ALUCruft;
  output ALUSrc, ExtImm; 
  
  // Control for Mem 
  output [0:1] MemSize;
  output MEMWE, ExtMem;

  // Other Values to forward

  output [0:15] Immediate;
  output [0:31] RegOut1, RegOut2;
  output [0:4] Rd;
  output [0:31] PC_plus_four;
  output [0:5] OpCode, Funct;

  //Ifetch -> Decode Pipe Reg

  reg [0:5] op_code;
  // Verilog doesn't like 'function'
  reg [0:5] fn;
  reg [0:31] pc_plus_four;
  reg [0:15] immd; 
  reg [0:4] rs1, rs2, rd;
   
  always @(posedge clk) begin
    if (!stall) begin
      op_code <= NextOpCode;
      fn <= NextFunction;
      pc_plus_four <= NextPCPlusFour;
      immd <= NextImmed;
      rs1 <= NextRs1;
      rs2 <= NextRs2;
      rd <= NextRd;
    end
  end


  // Subunits 

  //Register File
  regfile64by32bit regfile (.clk(clk), .regwe(RegWBWE), .reset(reset), .Rw(RegWBAddr), .Ra(rs1), .Rb(rs2), .Din(RegWBData) , .regout1(RegOut1), .regout2(RegOut2));
 
  //Control Unit
  Control control(.DInSrc(DInSrc), .RegWE(RegWE), .FPDest(FPDest), .RegDest(RegDest), .JumpType(JumpType) , .CondSrc(CondSrc) , .BranchCond(BranchCond),
  .FPSrc(FPSrc) , .ALUOp(ALUOp) , .FPUOp(FPUOp) , .ALUCruft(ALUCruft), .ALUSrc(ALUSrc), .ExtImm(ExtImm), .MEMSize(MEMSize), .MEMWE(MEMWE), .ExtMEM(ExtMEM),
  .OpCode(op_code), .Function(fn)
);

 //Things to forward
 assign Rd = rd;
 assign Immediate = immd;
 assign OpCode = op_code;
 assign Funct = funct;
 assign PC_plus_four = pc_plus_four;

endmodule
