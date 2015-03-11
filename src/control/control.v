// Control signals for single-cycle DLX Architecture

module Control(
  // Out
  DInSrc, RegWE, FPDest, RegDest, JumpType, CondSrc, BranchCond, 
  FPSrc, ALUOp, FPUOp, ALUCruft, ALUSrc, ExtImm, MEMSize, MEMWE, ExtMEM,

  // In
  OpCode, Function
);

  input [0:5] OpCode;
  input [0:5] Function;

  // WB Control
  output [0:1] DInSrc;
  output RegWE, FPDest;
  output [0:1] RegDest;

  // IFetch Control
  output [0:1] JumpType;
  output CondSrc, BranchCond;

  // Reg/Decode Control
  output FPSrc;

  // EXE Control
  output [0:2] ALUOp;
  output [0:1] ALUCruft;
  output [0:2] FPUOp;
  output ALUSrc, ExtImm;

  // MEM Control
  output [0:1] MEMSize;
  output MEMWE, ExtMEM;

  wire RType, IType, JType;
  wire ALUInst, FPUInst, MEMInst, NotRegWE;

  // Instruction Type
  assign RType = (OpCode == 6'h00) | (OpCode == 6'h01);
  assign IType = (OpCode >= 6'h04 & OpCode <= 6'h0f) | (OpCode >= 6'h12 & OpCode <= 6'h2f);
  assign JType = (OpCode == 6'h02) | (OpCode == 6'h03) | (OpCode == 6'h10) | (OpCode == 6'h11);

  // DInSrc
  // -----------
  // 00 - PC + 4
  // 01 - ALUOut
  // 10 - FPUOut
  // 11 - MEMOut
  assign ALUInst = (OpCode == 6'h00 & ((Function >= 6'h04 & Function <= 6'h2d)|(Function >= 6'h35 & Function <= 6'h37))) 
    | (OpCode == 6'h01 & (Function == 6'h0e | Function == 6'h0f | Function == 6'h16 | Function == 6'h17))
    | (OpCode >= 6'h08 & OpCode <= 6'h0f) | (OpCode >= 6'h14 & OpCode <= 6'h1d);
  assign FPUInst = (OpCode == 6'h00 & (Function >= 6'h32 & Function <= 6'h34))
    | (OpCode == 6'h01 & ((Function >= 6'h00 & Function <= 6'h0d)|(Function >= 6'h10 & Function <= 6'h15)|(Function >= 6'h18 & Function <= 6'h1d)));
  assign MEMInst = (OpCode >= 6'h20 & OpCode <= 6'h27);
  assign DInSrc[0] = FPUInst | MEMInst;
  assign DInSrc[1] = ALUInst | MEMInst;

  // RegWE
  assign NotRegWE = (OpCode == 6'h02) | (OpCode == 6'h04) | (OpCode == 6'h05) | (OpCode == 6'h06)
    | (OpCode == 6'h07) | (OpCode == 6'h10) | (OpCode == 6'h11) | (OpCode == 6'h12) | (OpCode == 6'h04) | (OpCode >= 6'h28)
    | (OpCode == 6'h00 & Function == 6'h15)
    | (OpCode == 6'h01 & ((Function >= 6'h10 & Function <= 6'h15) | (Function >= 6'h18 & Function <= 6'h1d)));
  not (RegWE, NotRegWE);

  // FPDest
  assign FPDest = (OpCode == 6'h00 & (Function == 6'h32 | Function == 6'h33 | Function == 6'h35))
    | (OpCode == 6'h01 & ((Function >= 6'h00 & Function <= 6'h08) | (Function == 6'h0a) | (Function >= 6'h0c & Function <= 6'h0f)))
    | (OpCode == 6'h01 & (Function == 6'h16 | Function == 6'h17))
    | (OpCode == 6'h26 | OpCode == 6'h27);

  // RegDest
  // -------
  // 00 - Rs2 (I-type)
  // 01 - Rd  (R-type)
  // 10 - 0x31 (for JAL)
  assign RegDest[0] = (OpCode == 6'h03) | (OpCode == 6'h13);
  assign RegDest[1] = RType;

  // JumpType
  // --------
  // 00 - JumpReg
  // 01 - Imm16
  // 10 - Imm26
  // 11 - IAR
  assign JumpType[0] = (OpCode == 6'h10) | (OpCode == 6'h11) | (OpCode == 6'h02) | (OpCode == 6'h03);
  assign JumpType[1] = (OpCode == 6'h10) | (OpCode >= 6'h04 & OpCode <= 6'h07);

  // CondSrc
  // -------
  // 0 - FPSR
  // 1 - ALUOut
  assign CondSrc = (OpCode >= 6'h04 & OpCode <= 6'h05);

  // BranchCond
  // ----------
  // 0 - BNEQZ, BFPF
  // 1 - BEQZ, BFPT
  assign BranchCond = (OpCode == 6'h04 | OpCode == 6'h06);

  // FPSrc
  // -----
  // 0 - GPR
  // 1 - FPR
  assign FPSrc = (OpCode == 6'h00 & (Function >= 6'h32 & Function <= 6'h34))
    | (OpCode == 6'h01 & ((Function >= 6'h00 & Function <= 6'h0b)|(Function >= 6'h0e & Function <= 6'h1d)|(Function >= 6'h18 & Function <= 6'h1d)))
    | (OpCode == 6'h2e) | (OpCode == 6'h2f);

  // ALUOp
  // -----
  // 000 - Shift
  // 001 - AND
  // 010 - OR
  // 011 - XOR
  // 100 - ADD
  // 101 - SEQ/SNE
  // 110 - SLT/SGE
  // 111 - SGT/SLE

  // ADD/LW/SUB/SEQ/SNE/SLT/SGE/SGT/SLE
  assign ALUOp[0] = (OpCode == 6'h00 & ((Function >= 6'h20 & Function <= 6'h23) | (Function >= 6'h28 & Function <= 6'h2d) | (Function == 6'h35)))
    | (OpCode >= 6'h08 & OpCode <= 6'h0b) | (OpCode == 6'h0f) | (OpCode >= 6'h18 & OpCode <= 6'h1d) | OpCode == 6'h23;

  // OR/XOR/LT/GT/LTE/GTE
  assign ALUOp[1] = (OpCode == 6'h00 & (Function == 6'h25 | Function == 6'h26 | (Function >= 6'h2a & Function <= 6'h2d)))
    | (OpCode == 6'h0d) | (OpCode == 6'h0e) | (OpCode >= 6'h1a & OpCode <= 6'h1d);

  // AND/XOR/SEQ/SNE/SGT/SLE
  assign ALUOp[2] = (OpCode == 6'h00 & (Function == 6'h24 | Function == 6'h26 | Function == 6'h28 | Function == 6'h29 | Function == 6'h2b | Function == 6'h2c))
    | (OpCode == 6'h0c) | (OpCode == 6'h0e) | (OpCode == 6'h18) | (OpCode == 6'h19) | (OpCode == 6'h1b) | (OpCode == 6'h1c);
  
  // ALUCruft
  // --------
  // [0] 0 Add/Left/Invert
  //     1 Sub/Right/NoInvert
  // [1] 0 Signed/Logical
  //     1 Unsigned/Arith

  // SRL/SRA/SUB/SUBU/SEQ/SLT/SGT
  assign ALUCruft[0] = (OpCode == 6'h00 & (Function == 6'h06 | Function == 6'h07 | Function == 6'h22 | Function == 6'h23 | Function == 6'h28 | Function == 6'h2a | Function == 6'h2b))
    | (OpCode == 6'h0a) | (OpCode == 6'h0b) | (OpCode == 6'h16) | (OpCode == 6'h17) | (OpCode == 6'h18) | (OpCode == 6'h1a) | (OpCode == 6'h1b);

  // ADDU/SUBU/SRA
  assign ALUCruft[1] = (OpCode == 6'h00 & (Function == 6'h07 | Function == 6'h21 | Function == 6'h23))
    | (OpCode == 6'h09) | (OpCode == 6'h0b) | (OpCode == 6'h17);

  // ALUSrc
  // ------
  // 0 - Reg B
  // 1 - Immediate
  assign ALUSrc = (OpCode != 6'h00);

  // ExtImm
  // ------
  // 0 - Zero
  // 1 - Sign
  assign ExtImm = (OpCode == 6'h09) | (OpCode == 6'h0b);

  // MEMSize
  // 00 - Byte
  // 01 - Half-word
  // 11 - Word
  assign MEMSize[0] = (OpCode == 6'h23) | (OpCode == 6'h26) | (OpCode == 6'h27)
    | (OpCode == 6'h2b) | (OpCode == 6'h2e) | (OpCode == 6'h2f);
  assign MEMSize[1] = (OpCode == 6'h21) | (OpCode == 6'h23) | (OpCode == 6'h25)
    | (OpCode == 6'h26) | (OpCode == 6'h27) | (OpCode == 6'h29)
    | (OpCode == 6'h2b) | (OpCode == 6'h2e) | (OpCode == 6'h2f);

  // MEMWE
  assign MEMWE = (OpCode >= 6'h28 & OpCode <= 6'h2f);

  // ExtMEM
  // 0 - Sign
  // 1 - Zero
  assign ExtMEM = (OpCode != 6'h24) & (OpCode != 6'h25);
endmodule
