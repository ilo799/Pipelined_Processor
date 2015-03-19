module Execute (
  // Out
  DInSrc, RegWE, RegWAddr, //WB
  MEMSize, MEMWE, ExtMEM, //MEM 
  ALUOut, FPUOut, //Data created by this stage 
  RegB, Opcode, Funct, PCPlusFour, Immediate, //Forwarded Data
  Rs1, Rs2, AluSrc,

  // In
  clk, reset, stall,
 
  NextRegA, NextRegB, NextImmediate, NextOpcode, NextFunction, NextPCPlusFour, //Data
  NextRs1, NextRs2,

  // Forwarding
  ASrc, BSrc,
  MemData, WBData,

  //Control
  NextDInSrc, NextRegWE, NextRegWAddr, //WB
  NextALUOp, NextFPUOp, NextALUCruft, NextALUSrc, NextExtImm, //EXE
  NextMEMSize, NextMEMWE, NextExtMEM,  //MEM
   
);

  input clk, reset, stall;
  
  input [0:31] NextRegA, NextRegB, NextPCPlusFour;
  input [0:15] NextImmediate;
  input [0:5] NextFunction;
  input [0:5] NextOpcode; 

  input [0:1] NextDInSrc;
  input NextRegWE;
  input [0:5] NextRegWAddr;
  input [0:2] NextALUOp;
  input [0:2] NextFPUOp;
  input [0:1] NextALUCruft;
  input NextALUSrc;
  input NextExtImm;
  input [0:1] NextMEMSize;
  input NextMEMWE;
  input NextExtMEM;
  input [0:5] NextRs1, NextRs2;
  input [0:1] ASrc, BSrc;
  input [0:31] MemData, WBData;

  output [0:31] ALUOut, FPUOut;
  
  output [0:1] DInSrc;
  output RegWE;
  output [0:5] RegWAddr;
  output [0:1] MEMSize;
  output MEMWE;
  output ExtMEM;

  output [0:31] RegB, PCPlusFour;
  output [0:5] Funct;
  output [0:5] Opcode;
  output [0:15] Immediate;

  output [0:5] Rs1;
  output [0:5] Rs2;
  output AluSrc;

  reg [0:31] reg_a, reg_b, pc_plus_four;
  reg  [0:15] immediate;
  reg [0:5] funct;
  reg [0:5] opcode;

  reg [0:1] din_src;
  reg reg_we;
  reg [0:5] reg_w_addr;
  reg [0:2] alu_op;
  reg [0:2] fpu_op;
  reg [0:1] alu_cruft;
  reg alu_src;
  reg ext_imm;
  reg [0:1] mem_size;
  reg mem_we;
  reg ext_mem;

  reg [0:5] rs1, rs2;

  assign RegB = reg_b;
  assign PCPlusFour = pc_plus_four; 
  assign Funct = funct;
  assign Opcode = opcode;
  assign DInSrc = din_src;
  assign RegWE = reg_we;
  assign RegWAddr = reg_w_addr;
  assign MEMSize = mem_size;
  assign MEMWE = mem_we; 
  assign ExtMEM = ext_mem;
  assign Immediate = immediate;  
  assign Rs1 = rs1;
  assign Rs2 = rs2;
  assign AluSrc = alu_src;

  always @(posedge clk, posedge reset) begin
    if (reset) begin      
      reg_a <= 0;
      reg_b <= 0;
      pc_plus_four <= 0;
      immediate <= 16'b0;
      funct <= 6'h15;
      opcode <= 6'b0;

      din_src <= 2'b0;
      reg_we <= 1'b0;
      reg_w_addr <= 6'b0;
      alu_op <= 3'b0;
      fpu_op <= 3'b0;
      alu_cruft <= 2'b0;
      alu_src <= 1'b0;
      ext_imm <= 1'b0;
      mem_size <= 2'b0;
      mem_we <= 1'b0;
      ext_mem <= 1'b0;

      rs1 <= 6'b0;
      rs2 <= 6'b0;
    end else begin
      reg_a <= NextRegA;
      reg_b <= NextRegB;
      pc_plus_four <= NextPCPlusFour;
      immediate <= NextImmediate;
      funct <= NextFunction;
      opcode <= NextOpcode;

      din_src <= NextDInSrc;
      reg_we <= NextRegWE;
      reg_w_addr <= NextRegWAddr;
      alu_op <= NextALUOp;
      fpu_op <= NextFPUOp;
      alu_cruft <= NextALUCruft;
      alu_src <= NextALUSrc;
      ext_imm <= NextExtImm;
      mem_size <= NextMEMSize;
      mem_we <= NextMEMWE;
      ext_mem <= NextExtMEM;

      rs1 <= NextRs1;
      rs2 <= NextRs2;
    end
  end

  wire[0:31] alu_immd, alu_a, alu_b, fpu_a, fpu_b;

  MUX2_n #(16) ext_mux (alu_immd[0:15], 16'b0, {16{immediate[0]}}, ext_imm);
  assign alu_immd[16:31] = immediate;
  MUX4_n #(32) alu_a_mux (alu_a, reg_a, 32'bX, MemData, WBData, ASrc);
  MUX4_n #(32) alu_b_mux (alu_b, reg_b, alu_immd, MemData, WBData, BSrc);
  ALU alu (ALUOut, alu_a, alu_b, alu_op, alu_cruft);

  assign fpu_a = reg_a;
  assign fpu_b = reg_b;
  fpu fpu (FPUOut, fpu_a, fpu_b, fpu_op);
  
endmodule
