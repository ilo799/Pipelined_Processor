module InstructionFetch(
  OpCode, Function, PCPlusEight,
  Rs1, Rs2, Rd, Immediate,
  clk, reset,
  JumpType, BranchCond, CondSrc, ALUOut, FPSR, JumpReg, IAR
);

  parameter InitAddress = 0;
  parameter MemFile = "../../inputs/instr.hex";

  input clk, reset;
  input [0:1] JumpType;
  input BranchCond, CondSrc;
  input [0:31] ALUOut, FPSR, JumpReg, IAR;

  output [0:5] OpCode, Function;
  output [0:31] PCPlusEight;
  output [0:4] Rs1, Rs2, Rd;
  output [0:15] Immediate;

  reg [0:31] PC;
  wire [0:31] inst, next_pc, pc_plus_4, imm16, imm26, imm16_plus_pc4, imm26_plus_pc4, jump_pc;
  wire [0:5] op_code, fn, alu_function, fpu_function;
  wire should_jump, should_jump1, should_jump2, should_jump3, eq_j, eq_jr, eq_jal, eq_jalr;
  wire should_branch, branch_inst, branch_val, branch_inst1;

  LCU32bit pc_adder(
    .inA(PC),
    .inB(4),
    .sum(pc_plus_4),
    .c0(0)
  );
  LCU32bit pc8_adder(
    .inA(pc_plus_4),
    .inB(4),
    .sum(PCPlusEight),
    .c0(0)
  );

  assign OpCode = op_code;
  assign Function = fn;

  imem imem(.addr(PC), .instr(inst));

  assign op_code = inst[0:5];

  assign alu_function = inst[26:31];
  assign fpu_function = {1'b0, inst[27:31]};

  assign imm16[16:31] = inst[16:31];
  assign imm16[0:15] = imm16[16];
  assign imm26[6:31] = inst[6:31];
  assign imm26[0:5] = imm16[6];
  LCU32bit imm16_adder(
    .inA(pc_plus_4),
    .inB(imm16),
    .sum(imm16_plus_pc4),
    .c0(0)
  );
  LCU32bit imm26_adder(
    .inA(pc_plus_4),
    .inB(imm26),
    .sum(imm26_plus_pc4),
    .c0(0)
  );

  assign Rs1 = inst[6:10];
  assign Rs2 = inst[11:15];
  assign Rd = inst[16:20];
  assign Immediate = inst[16:31];

  MUX2_n #(6) fn_mux (
    .F(fn),
    .A(alu_function),
    .B(fpu_function),
    .Sel(op_code[5])
  );

  MUX4_n #(32) jump_pc_mux (
    .F(jump_pc),
    .A(JumpReg),
    .B(imm16_plus_pc4),
    .C(imm26_plus_pc4),
    .D(IAR),
    .Sel(JumpType)
  );

  MUX2_n #(32) next_pc_mux (
    .F(next_pc),
    .A(pc_plus_4),
    .B(jump_pc),
    .Sel(should_jump)
  );

  EQ2_n #(6) j_eq(eq_j, OpCode, 6'h02);
  EQ2_n #(6) jal_eq(eq_jal, OpCode, 6'h03);
  EQ2_n #(6) jr_eq(eq_jr, OpCode, 6'h12);
  EQ2_n #(6) jalr_eq(eq_jalr, OpCode, 6'h13);

  EQ2_n #(3) branch_eq1(branch_inst1, op_code[0:2], 0);
  AND2_n #(1) branch_inst_and(branch_inst, branch_inst1, op_code[3]);
  MUX2_n #(1) branch_val_mux(branch_val, FPSR[31], ALUOut[31], CondSrc);
  AND2_n #(1) should_branch_and(should_branch, branch_inst, branch_val);

  OR2_n #(1) should_jump1_or(should_jump1, eq_j, eq_jal);
  OR2_n #(1) should_jump2_or(should_jump2, eq_jr, eq_jalr);
  OR2_n #(1) should_jump3_or(should_jump3, should_jump1, should_jump2);
  OR2_n #(1) should_jump_or(should_jump, should_jump3, should_branch);

  initial begin
    $readmemh(MemFile, imem.mem);
  end

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      PC <= InitAddress;
    end else begin
      PC <= next_pc;
    end
  end

endmodule
