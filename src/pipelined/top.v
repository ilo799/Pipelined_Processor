module Processor (clk, reset);
  
  parameter InstructionFile = "../../class_examples/fibExample/instr.hex";
  parameter InitAddr = 0; 
  input clk, reset;

  reg [0:31] IAR;
  reg [0:31] FPSR;

  //Signals:

  //Fetch -> Decode 
  wire[0:5] opcode_fd;
  wire [0:5] function_fd;
  wire [0:31] pc_plus_four_fd;
  wire [0:4] rs1_fd, rs2_fd, rd_fd;
  wire [0:15] immediate_fd;

  //Decode -> Exe
  wire reg_we_de;
  wire[0:5] reg_w_addr_de;
  wire[0:1] din_src_de;
  wire [0:2] alu_op_de, fpu_op_de;
  wire [0:1] alu_cruft_de;
  wire alu_src_de, ext_imm_de;
  wire[0:1] mem_size_de;
  wire mem_we_de, ext_mem_de;
  wire[0:5] opcode_de;
  wire [0:5] function_de;
  wire [0:31] pc_plus_four_de, reg_out1_de, reg_out2_de ;
  wire [0:15] immediate_de;

  //Decode -> Fetch
  wire[0:1] jump_type_df;
  wire cond_src_df, branch_cond_df;
  wire[0:31] jump_reg_df;

  assign jump_reg_df = reg_out1_de; //rs1 

  //Exe -> Mem
  wire reg_we_em;
  wire[0:5] reg_w_addr_em;
  wire[0:1] din_src_em;
  wire[0:1] mem_size_em;
  wire mem_we_em, ext_mem_em;
  wire[0:5] opcode_em;
  wire [0:5] function_em;
  wire [0:31] pc_plus_four_em, alu_out_em, fpu_out_em, reg_b_em;
  wire [0:15] immediate_em;

  //Exe -> Fetch
  wire [0:31]alu_out_ef;
  assign alu_out_ef = alu_out_em; 

  //Mem -> WB
  wire reg_we_mw;
  wire[0:5] reg_w_addr_mw;
  wire[0:1] din_src_mw;
  wire[0:5] opcode_mw;
  wire [0:5] function_mw;
  wire [0:31] pc_plus_four_mw, alu_out_mw, fpu_out_mw, mem_out_mw;
  wire [0:15] immediate_mw;

  //WB -> Decode
  wire reg_we_wd;
  wire [0:5] reg_w_addr_wd;
  wire [0:31] reg_w_data_wd;


  //Top Level Hazard Detection/Forwarding Logic here.
  wire stall;
  assign stall = 1'b0; 

  //Stages

 
  Fetch  #(.MemFile(InstructionFile), .InitAddress(InitAddr))  ifetch(
  //Out:
  .OpCode(opcode_fd), .Function(function_fd), .PCPlusFour(pc_plus_four_fd), 
  .Rs1(rs1_fd), .Rs2(rs2_fd), .Rd(rd_fd), .Immediate(immediate_fd),
 
  //In
  .clk(clk), .reset(reset), .stall(stall),
  .JumpType(jump_type_df), .BranchCond(branch_cond_df), .CondSrc(cond_src_df), .ALUOut(alu_out_ef), .FPSR(FPSR), .JumpReg(jump_reg_df), .IAR(IAR)
  );

  Decode decode(
  // Out
  .RegWE(reg_we_de), .RegWAddr(reg_w_addr_de), .DInSrc(din_src_de), //WB
  .JumpType(jump_type_df), .CondSrc(cond_src_df), .BranchCond(branch_cond_df), //IF 
  .ALUOp(alu_op_de), .FPUOp(fpu_op_de), .ALUCruft(alu_cruft_de), .ALUSrc(alu_src_de), .ExtImm(ext_imm_de), //Exe 
  .MEMSize(mem_size_de), .MEMWE(mem_we_de), .ExtMEM(ext_mem_de), //Mem
  .RegOut1(reg_out1_de), .RegOut2(reg_out2_de), .OpCode(opcode_de), .Funct(function_de), .PCPlusFour(pc_plus_four_de), .Immediate(immediate_de),  //Data

  // In
  .clk(clk), .reset(reset), .stall(stall),
  .RegWBWE(reg_we_wd), .RegWBAddr(reg_w_addr_wd), .RegWBData(reg_w_data_wd), //From WB
  .NextOpCode(opcode_fd), .NextFunct(function_fd), .NextPCPlusFour(pc_plus_four_fd), //FROM IF
  .NextRs1(rs1_fd), .NextRs2(rs2_fd), .NextRd(rd_fd), .NextImmd(immediate_fd)
  );
  
  Execute execute (
  // Out
  .DInSrc(din_src_em), .RegWE(reg_we_em), .RegWAddr(reg_w_addr_em), //WB
  .MEMSize(mem_size_em), .MEMWE(mem_we_em), .ExtMEM(ext_mem_em), //MEM 
  .ALUOut(alu_out_em), .FPUOut(fpu_out_em), //Data created by this stage 
  .RegB(reg_b_em), .Opcode(opcode_em), .Funct(function_em), .PCPlusFour(pc_plus_four_em), .Immediate(immediate_em), //Forwarded Data

  // In
  .clk(clk), .reset(reset), .stall(stall),
  .NextRegA(reg_out1_de), .NextRegB(reg_out2_de), .NextImmediate(immediate_de), .NextOpcode(opcode_de), .NextFunction(function_de), .NextPCPlusFour(pc_plus_four_de), //Data
  .NextDInSrc(din_src_de), .NextRegWE(reg_we_de), .NextRegWAddr(reg_w_addr_de), //WB
  .NextALUOp(alu_op_de), .NextFPUOp(fpu_op_de), .NextALUCruft(alu_cruft_de), .NextALUSrc(alu_src_de), .NextExtImm(ext_imm_de), //EXE
  .NextMEMSize(mem_size_de), .NextMEMWE(mem_we_de), .NextExtMEM(ext_mem_de)  //MEM
  );

  Memory memory (
  // Out
  .MEMDout(mem_out_mw), .ALUOut(alu_out_mw), .FPUOut(fpu_out_mw), .Opcode(opcode_mw), .Funct(function_mw), .PCPlusFour(pc_plus_four_mw), .Immediate(immediate_mw), //Data
  .DInSrc(din_src_mw), .RegWE(reg_we_mw), .RegWAddr(reg_w_addr_mw) , //WB Control

  // In
  .clk(clk), .reset(reset), .stall(stall),
  .NextDInSrc(din_src_em), .NextRegWE(reg_we_em), .NextRegWAddr(reg_w_addr_em), .NextMEMSize(mem_size_em), .NextMEMWE(mem_we_em), .NextExtMEM(ext_mem_em),
  .NextALUOut(alu_out_em), .NextFPUOut(fpu_out_em), .NextRegB(reg_b_em), 
  .NextOpcode(opcode_em), .NextFunct(function_em), .NextPCPlusFour(pc_plus_four_em), .NextImmediate(immediate_em)
  );

  WriteBack write_back (
  // Out
  .RegWBWE(reg_we_wd), .RegWBAddr(reg_w_addr_wd), .RegWBData(reg_w_data_wd),

  //In
  .clk(clk), .reset(reset), .stall(stall),
  .NextMEMDout(mem_out_mw), .NextALUOut(alu_out_mw), .NextFPUOut(fpu_out_mw),
  .NextOpcode(opcode_mw), .NextFunct(function_mw), .NextPCPlusFour(pc_plus_four_mw), .NextImmediate(immediate_mw),
  .NextDInSrc(din_src_mw), .NextRegWE(reg_we_mw), .NextRegWAddr(reg_w_addr_mw)
  );


  always @(posedge reset) begin
    IAR <= 0;
    FPSR <= 0;
  end
endmodule
