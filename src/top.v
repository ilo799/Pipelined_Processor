module Processor (clk, reset);
  
  parameter InstructionFile = "../inputs/instr.hex";

  input clk, reset;

  reg [0:31] IAR;

  // Control Signals
  wire [0:1] DInSrc;
  wire RegWE, FPDest;
  wire [0:1] RegDest;
  wire [0:1] JumpType;
  wire CondSrc, BranchCond;
  wire FPSrc;
  wire [0:2] ALUOp;
  wire [0:1] ALUCruft;
  wire [0:2] FPUOp;
  wire ALUSrc, ExtImm;
  wire [0:1] MEMSize;
  wire MEMWE, ExtMEM;

  // Instruction Signals
  wire [0:5] OpCode, Function;
  wire [0:31] PCPlusEight;
  wire [0:4] Rs1, Rs2, Rd;
  wire [0:15] Immediate;
  wire [0:31] jump_reg;

  wire [0:31] sext_immd;

  // ALU Signals
  wire [0:31] ALUOut, alu_a, alu_b;

  // FPU Signals
  wire [0:31] FPUOut, fpu_a, fpu_b;
  reg FPSR;

  // MEM Signals
  wire [0:31] mem_din, MEMDout, mem_addr;

  // Regfile signals
  wire [0:31] RegAOut, RegBOut, reg_din;
  wire [0:5] reg_a_addr, reg_b_addr, reg_w_addr;

  MUX2_n #(16) sext_mux (sext_immd[0:15], 1'b0, {16{Immediate[0]}}, ExtImm);
  assign sext_immd[16:31] = Immediate;

  assign alu_a = RegAOut;
  MUX2_n #(32) alu_b_mux (alu_b, RegBOut, sext_immd, ALUSrc);
  ALU alu (ALUOut, alu_a, alu_b, ALUOp, ALUCruft);

  assign fpu_a = RegAOut;
  assign fpu_b = alu_b;
  fpu fpu (FPUOut, fpu_a, fpu_b, FPUOp);

  assign jump_reg = RegAOut;
  InstructionFetch #(.MemFile(InstructionFile)) ifetch (
    .OpCode(OpCode),
    .Function(Function),
    .PCPlusEight(PCPlusEight),
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
    .FPSR({31'b0, FPSR}),
    .JumpReg(jump_reg),
    .IAR(IAR)
  );

  Control control (
    DInSrc, RegWE, FPDest, RegDest, JumpType, CondSrc, BranchCond, 
    FPSrc, ALUOp, FPUOp, ALUCruft, ALUSrc, ExtImm, MEMSize, MEMWE, ExtMEM,
    OpCode, Function
  );

  assign mem_din = RegBOut;
  LCU32bit mem_addr_adder (
    .inA(RegAOut),
    .inB({{16{Immediate[0]}}, Immediate}),
    .sum(mem_addr),
    .c0(1'b0),
    .pg(),
    .gg(),
    .c32()
  );
  dmem mem (
    .addr(mem_addr),
    .wData(mem_din),
    .writeEnable(MEMWE),
    .dsize(MEMSize),
    .dsign(ExtMEM),
    .clk(clk),
    .rData_out(MEMDout)
  );

  MUX4_n #(32) reg_din_mux (
    .F(reg_din),
    .A(PCPlusEight),
    .B(ALUOut),
    .C(FPUOut),
    .D(MEMDout),
    .Sel(DInSrc)
  );
  assign reg_a_addr = {FPSrc, Rs1};
  assign reg_b_addr = {FPSrc, Rs2};
  MUX3_n #(6) reg_w_mux (reg_w_addr, {FPDest, Rs2}, {FPDest, Rd}, 6'd31, RegDest);

  regfile64by32bit regfile (
    .clk(clk),
    .regwe(RegWE),
    .reset(reset),
    .Rw(reg_w_addr),
    .Ra(reg_a_addr),
    .Rb(reg_b_addr),
    .Din(reg_din),
    .regout1(RegAOut),
    .regout2(RegBOut)
  );

  always @(posedge reset) begin
    IAR <= 0;
    FPSR <= 0;
  end
endmodule
