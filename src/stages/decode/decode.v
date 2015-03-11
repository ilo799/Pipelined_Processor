module Decode (
  // Out
  RegWE, RegWAddr, DInSrc, //WB
  JumpType, CondSrc, BranchCond, //IF 
  ALUOp, FPUOp, ALUCruft, ALUSrc, ExtImm, //Exe 
  MEMSize, MEMWE, ExtMEM, //Mem
  RegOut1, RegOut2, OpCode, Funct, PCPlusFour, Immediate,  //Data

  // In:
  clk, reset, stall,
  RegWBWE, RegWBAddr, RegWBData, //From WB
  NextOpCode, NextFunct, NextPCPlusFour, //FROM IF
  NextRs1, NextRs2, NextRd, NextImmd  
);
  
  input clk, reset, stall;
 
  //From WB stage (async) 
  input RegWBWE;
  input [0:5] RegWBAddr;
  input [0:31] RegWBData;
  
  //From Ifetch Stage (clocked)
  input [0:31] NextPCPlusFour;
  input [0:5] NextOpCode, NextFunct;
  input [0:4] NextRs1, NextRs2, NextRd;
  input [0:15] NextImmd; 

  // Control For WB
  output RegWE;
  output [0:5] RegWAddr;
  output [0:1] DInSrc;

  // Control For Ifetch
  output[0:1] JumpType; 
  output BranchCond, CondSrc;

  // Control For Exe
  output [0:2] ALUOp, FPUOp;
  output [0:1] ALUCruft;
  output ALUSrc, ExtImm; 
  
  // Control for Mem 
  output [0:1] MEMSize;
  output MEMWE, ExtMEM;

  // Values to forward
  output [0:15] Immediate;
  output [0:31] RegOut1, RegOut2;
  output [0:31] PCPlusFour;
  output [0:5] OpCode;
  output [0:5] Funct;

  //Ifetch -> Decode Pipe Reg

  reg [0:5] op_code;
  // Verilog doesn't like 'function'
  reg [0:5] funct;
  reg [0:31] pc_plus_four;
  reg [0:15] immd; 
  reg [0:4] rs1, rs2, rd;


  always @(posedge clk, posedge reset) begin
    if (reset) begin
      op_code <= 6'b0;
      funct <= 6'b0;
      pc_plus_four <= 0;
      immd <= 16'b0;
      rs1 <=  5'b0;
      rs2 <=  5'b0;
      rd <=  5'b0;
    end else begin
      op_code <= NextOpCode;
      funct <= NextFunct;
      pc_plus_four <= NextPCPlusFour;
      immd <= NextImmd;
      rs1 <= NextRs1;
      rs2 <= NextRs2;
      rd <= NextRd;
    end
  end

  //Forward
  assign Immediate = immd;
  assign OpCode = op_code;
  assign Funct = funct;
  assign PCPlusFour = pc_plus_four;
 
  wire fpdest;
  wire[0:1] regdest;

  //Decode Write Address and forward
  MUX3_n #(6) reg_w_mux (RegWAddr, {fpdest, rs2}, {fpdest, rd}, 6'd31, regdest);

  //Reg File
  wire we;
  wire [0:5] reg_a_addr, reg_b_addr; 

  assign reg_a_addr = {FPSrc, rs1};
  assign reg_b_addr = {FPSrc, rs2};
  assign we = RegWBWE & !stall;
 
  regfile64by32bit regfile (.clk(clk), .regwe(we), .reset(reset), .Rw(RegWBAddr), .Ra(reg_a_addr), .Rb(reg_b_addr), .Din(RegWBData) , .regout1(RegOut1), .regout2(RegOut2));
 
  //Control Unit
  Control control(.DInSrc(DInSrc), .RegWE(RegWE), .FPDest(fpdest), .RegDest(regdest), .JumpType(JumpType) , .CondSrc(CondSrc) , .BranchCond(BranchCond),
  .FPSrc(FPSrc) , .ALUOp(ALUOp) , .FPUOp(FPUOp) , .ALUCruft(ALUCruft), .ALUSrc(ALUSrc), .ExtImm(ExtImm), .MEMSize(MEMSize), .MEMWE(MEMWE), .ExtMEM(ExtMEM),
  .OpCode(op_code), .Function(funct)
);

endmodule
