//Test bench for pipelined processor

`timescale 1ns/1ps

module Testbench;

  //some debug flags 
  parameter debug = 1;   //gives state @ every stage and every cycle
  parameter memdump_start = 8192; //start address for memdump as a decimal (give a neg. number to avoid dumping mem)
  parameter memdump_end = 8292; //end address for memdump as a decimal

  reg clk;
  reg[0:31] cycle; 
  reg reset;
  
  //String representation of instructions
  reg[9*8:0] decode; 
  reg[9*8:0] exe; 
  reg[9*8:0] memory; 
  reg[9*8:0] write; 

  //file handles
  integer pipe_fh;
  integer mem_fh;
  integer index;

  wire[0:31] mem_w_data;
  wire mem_we;
  wire [0:1] mem_size; 
  wire mem_ext;
  wire [0:31] dmem_dout; 
  wire [0:31] mem_addr;

  Processor #(.InstructionFile("../../class_examples/qsort/qsort_instr.hex")) Processor0 (.clk(clk), .reset(reset),  
  //Outputs
  .MemWData(mem_w_data), .MemWE(mem_we), .MemSize(mem_size), .MemExt(mem_ext), .MemAddr(mem_addr),
  ////Inputs
  .DMEM_Dout(dmem_dout));


  dmem mem (.addr(mem_addr), .wData(mem_w_data), .writeEnable(mem_we),.dsize(mem_size),.dsign(mem_ext), .clk(clk), .rData_out(dmem_dout));

  initial begin
    $dumpfile("processor.vcd");
    $dumpvars;
    $readmemh("../../class_examples/qsort/qsort_data.hex", mem.mem);
    //$display("MemWAddr\tMemDin");
    //$monitor("%h\t%h", Processor0.memory.mem.addr, Processor0.memory.mem.wData);
    
    pipe_fh = $fopen("pipestage.log");
    mem_fh =  $fopen("mem.log");

    //dump mem. inital state
    $fdisplay(mem_fh, "-------------------------- Initial - ------------------- \n \n");
    if (memdump_start >= 0) begin
       for(index = memdump_start; index < memdump_end; index = index + 1) begin
              $fdisplay(mem_fh, "@%h %h \n", index, mem.mem[index]);
       end
    end

    $fdisplay(pipe_fh, "-------------------------- Pipestage Log ------------------- \n \n"); 

    clk = 0;
    reset = 1;
   
    decode = "XXXX";
    exe = "XXXX";
    memory = "XXXX";
    write = "XXXX";

    #1 clk = 1;
    #1 clk = 0;
    #1 reset = 0;
    #1 cycle = 0; 
  end

  always begin
    #1 clk <= !clk;
    if (Processor0.write_back.opcode == 6'h11)
    begin

    //dump mem. final state
    $fdisplay(mem_fh, "-------------------------- Final -------------------- \n \n");
    if (memdump_start >= 0) begin
       for(index = memdump_start; index <= memdump_end; index = index + 1) begin
              $fdisplay(mem_fh, "@%h %d \n", index, mem.mem[index]);
       end
    end
    $finish;
    end
  end

//Debug
//For debugging 

  always @(posedge clk, posedge reset) begin
   if (debug) begin
     if (reset) begin
      $fdisplay (pipe_fh, "------------------- RESET ------------------");
     end else begin
      cycle = cycle + 1;   
      $fdisplay(pipe_fh, "Cycle %d: \n", cycle);
      $fdisplay (pipe_fh, "Stage:           |------IFetch------||------Decode------||------Execut------||------Memory------||------WriteB------|");
      $fdisplay (pipe_fh, "PCplus4:         |%d        ||%d        ||%d        ||%d        ||%d        |", Processor0.ifetch.ifetch.pc_plus_4, Processor0.pc_plus_four_fd, Processor0.pc_plus_four_de, Processor0.pc_plus_four_em, Processor0.pc_plus_four_mw);
      $fdisplay (pipe_fh, "Instruction:     |%s        ||%s        ||%s        ||%s        ||%s        |\n", "      ????", decode, exe, memory, write);
      $fdisplay (pipe_fh, "WriteBackR :     |%s        ||%s        ||        %d        ||        %d        ||        %d        |", "      ????", "      ????", Processor0.reg_w_addr_de, Processor0.reg_w_addr_em, Processor0.reg_w_addr_mw);
      $fdisplay (pipe_fh, "Rs1        :     |%s        ||        %d        ||        %d        ||%s        ||%s        |", "      ????", Processor0.rs1_fd, Processor0.rs1_de, "      XXXX", "      XXXX");
      $fdisplay (pipe_fh, "Rs2        :     |%s        ||        %d        ||        %d        ||%s        ||%s        |", "      ????", Processor0.rs2_fd, Processor0.rs2_de, "      XXXX", "      XXXX");
      $fdisplay (pipe_fh, "Immed.     :     |%s        ||      %d        ||      %d       ||      %d        ||      %d        |", "      ????", Processor0.immediate_fd, Processor0.immediate_de, Processor0.immediate_em, Processor0.immediate_mw);
    end
   end
  end


////////////////////////////////////////////////////////////////////////////////////////////////

 always @(Processor0.opcode_fd or Processor0.function_fd)  begin
  case (Processor0.opcode_fd) 
      6'h00 : 
        case (Processor0.function_fd)
        6'h04 : decode = "SLL"; 
        6'h06 : decode = "SRL";
        6'h07 : decode = "SRA";
        6'h15 : decode = "NOP";
        6'h20 : decode = "ADD";
        6'h21 : decode = "ADDU";
        6'h22 : decode = "SUB";
        6'h23 : decode = "SUBU";
        6'h24 : decode = "AND";
        6'h25 : decode = "OR";
        6'h26 : decode = "XOR";
        6'h28 : decode = "SEQ";
        6'h29 : decode = "SNE";
        6'h2a : decode = "SLT";
        6'h2b : decode = "SGT";
        6'h2c : decode = "SLE";
        6'h2d : decode = "SGE";
        6'h32 : decode = "MOVF";
        6'h33 : decode = "MOVD";
        6'h34 : decode = "MOVFP2I";
        6'h35 : decode = "MOVI2FP";
        6'h36 : decode = "MOVI2S";
        6'h37 : decode = "MOVS2I";
        default: decode = "UNKNOW";
        endcase
      6'h01 : decode = "FP_TYPE"; 
      6'h02 : decode = "J"; 
      6'h03 : decode = "JAL"; 
      6'h04 : decode = "BEQZ";
      6'h05 : decode = "BNEZ";
      6'h06 : decode = "BFPT";     
      6'h07 : decode = "BFPF";  
      6'h08 : decode = "ADDI";
      6'h09 : decode = "ADDUI";
      6'h0A : decode = "SUBI";
      6'h0B : decode = "SUBUI";
      6'h0C : decode = "ANDI";
      6'h0D : decode = "ORI";
      6'h0E : decode = "XORI";
      6'h0F : decode = "LHI";
      6'h10 : decode = "RFE";     
      6'h11 : decode = "TRAP";  
      6'h12 : decode = "JR";
      6'h13 : decode = "JALR";
      6'h14 : decode = "SLLI";  
      6'h16 : decode = "SRLI";
      6'h17 : decode = "SRAI";
      6'h18 : decode = "SEQI";
      6'h19 : decode = "SNEI"; 
      6'h1A : decode = "SLTI";
      6'h1B : decode = "SGTI";
      6'h1C : decode = "SLEI";
      6'h1D : decode = "SGEI";
      6'h20 : decode = "LB";
      6'h21 : decode = "LH";
      6'h23 : decode = "LW";
      6'h24 : decode = "LBU";
      6'h25 : decode = "LHU";   
      6'h26 : decode = "LF"; 
      6'h27 : decode = "LD";
      6'h28 : decode = "SB";
      6'h29 : decode = "SH";
      6'h2B : decode = "SW";
      6'h2E : decode = "SF";
      6'h2F : decode = "JD";
      default : decode = "UNKNOWN"; 
  endcase
end

always @(Processor0.opcode_de or Processor0.function_de)  begin
  case (Processor0.opcode_de)
      6'h00 :
        case (Processor0.function_de)
        6'h04 : exe = "SLL";
        6'h06 : exe = "SRL";
        6'h07 : exe = "SRA";
        6'h15 : exe = "NOP";
        6'h20 : exe = "ADD";
        6'h21 : exe = "ADDU";
        6'h22 : exe = "SUB";
        6'h23 : exe = "SUBU";
        6'h24 : exe = "AND";
        6'h25 : exe = "OR";
        6'h26 : exe = "XOR";
        6'h28 : exe = "SEQ";
        6'h29 : exe = "SNE";
        6'h2a : exe = "SLT";
        6'h2b : exe = "SGT";
        6'h2c : exe = "SLE";
        6'h2d : exe = "SGE";
        6'h32 : exe = "MOVF";
        6'h33 : exe = "MOVD";
        6'h34 : exe = "MOVFP2I";
        6'h35 : exe = "MOVI2FP";
        6'h36 : exe = "MOVI2S";
        6'h37 : exe = "MOVS2I";
        default: exe = "UNKNOW";
        endcase
      6'h01 : exe = "FP_TYPE";
      6'h02 : exe = "J";
      6'h03 : exe = "JAL";
      6'h04 : exe = "BEQZ";
      6'h05 : exe = "BNEZ";
      6'h06 : exe = "BFPT";
      6'h07 : exe = "BFPF";
      6'h08 : exe = "ADDI";
      6'h09 : exe = "ADDUI";
      6'h0A : exe = "SUBI";
      6'h0B : exe = "SUBUI";
      6'h0C : exe = "ANDI";
      6'h0D : exe = "ORI";
      6'h0E : exe = "XORI";
      6'h0F : exe = "LHI";
      6'h10 : exe = "RFE";
      6'h11 : exe = "TRAP";
      6'h12 : exe = "JR";
      6'h13 : exe = "JALR";
      6'h14 : exe = "SLLI";
      6'h16 : exe = "SRLI";
      6'h17 : exe = "SRAI";
      6'h18 : exe = "SEQI";
      6'h19 : exe = "SNEI";
      6'h1A : exe = "SLTI";
      6'h1B : exe = "SGTI";
      6'h1C : exe = "SLEI";
      6'h1D : exe = "SGEI";
      6'h20 : exe = "LB";
      6'h21 : exe = "LH";
      6'h23 : exe = "LW";
      6'h24 : exe = "LBU";
      6'h25 : exe = "LHU";
      6'h26 : exe = "LF";
      6'h27 : exe = "LD";
      6'h28 : exe = "SB";
      6'h29 : exe = "SH";
      6'h2B : exe = "SW";
      6'h2E : exe = "SF";
      6'h2F : exe = "JD";
      default : exe = "UNKNOWN";
  endcase
end

always @(Processor0.opcode_em or Processor0.function_em)  begin
  case (Processor0.opcode_em)
      6'h00 :
        case (Processor0.function_em)
        6'h04 : memory = "SLL";
        6'h06 : memory = "SRL";
        6'h07 : memory = "SRA";
        6'h15 : memory = "NOP";
        6'h20 : memory = "ADD";
        6'h21 : memory = "ADDU";
        6'h22 : memory = "SUB";
        6'h23 : memory = "SUBU";
        6'h24 : memory = "AND";
        6'h25 : memory = "OR";
        6'h26 : memory = "XOR";
        6'h28 : memory = "SEQ";
        6'h29 : memory = "SNE";
        6'h2a : memory = "SLT";
        6'h2b : memory = "SGT";
        6'h2c : memory = "SLE";
        6'h2d : memory = "SGE";
        6'h32 : memory = "MOVF";
        6'h33 : memory = "MOVD";
        6'h34 : memory = "MOVFP2I";
        6'h35 : memory = "MOVI2FP";
        6'h36 : memory = "MOVI2S";
        6'h37 : memory = "MOVS2I";
        default: memory = "UNKNOW";
        endcase 
      6'h01 : memory = "FP_TYPE";
      6'h02 : memory = "J"; 
      6'h03 : memory = "JAL";
      6'h04 : memory = "BEQZ";
      6'h05 : memory = "BNEZ";
      6'h06 : memory = "BFPT";
      6'h07 : memory = "BFPF";
      6'h08 : memory = "ADDI";
      6'h09 : memory = "ADDUI";
      6'h0A : memory = "SUBI";
      6'h0B : memory = "SUBUI";
      6'h0C : memory = "ANDI";
      6'h0D : memory = "ORI";
      6'h0E : memory = "XORI";
      6'h0F : memory = "LHI";
      6'h10 : memory = "RFE";   
      6'h11 : memory = "TRAP"; 
      6'h12 : memory = "JR";
      6'h13 : memory = "JALR";
      6'h14 : memory = "SLLI";
      6'h16 : memory = "SRLI";
      6'h17 : memory = "SRAI";
      6'h18 : memory = "SEQI";
      6'h19 : memory = "SNEI";
      6'h1A : memory = "SLTI";
      6'h1B : memory = "SGTI";
      6'h1C : memory = "SLEI";
      6'h1D : memory = "SGEI";
      6'h20 : memory = "LB";
      6'h21 : memory = "LH";
      6'h23 : memory = "LW";
      6'h24 : memory = "LBU";
      6'h25 : memory = "LHU";
      6'h26 : memory = "LF";
      6'h27 : memory = "LD";
      6'h28 : memory = "SB";
      6'h29 : memory = "SH";
      6'h2B : memory = "SW";
      6'h2E : memory = "SF";
      6'h2F : memory = "JD";
      default : memory = "UNKNOWN";
  endcase
end

always @(Processor0.opcode_mw or Processor0.function_mw)  begin
  case (Processor0.opcode_mw)
      6'h00 :
        case (Processor0.function_mw)
        6'h04 : write = "SLL";
        6'h06 : write = "SRL";
        6'h07 : write = "SRA";
        6'h15 : write = "NOP";
        6'h20 : write = "ADD";
        6'h21 : write = "ADDU";
        6'h22 : write = "SUB";
        6'h23 : write = "SUBU";
        6'h24 : write = "AND";
        6'h25 : write = "OR";
        6'h26 : write = "XOR";
        6'h28 : write = "SEQ";
        6'h29 : write = "SNE";
        6'h2a : write = "SLT";
        6'h2b : write = "SGT";
        6'h2c : write = "SLE";
        6'h2d : write = "SGE"; 
        6'h32 : write = "MOVF";
        6'h33 : write = "MOVD";
        6'h34 : write = "MOVFP2I";
        6'h35 : write = "MOVI2FP";
        6'h36 : write = "MOVI2S";
        6'h37 : write = "MOVS2I";
        default: write = "UNKNOW";
        endcase 
      6'h01 : write = "FP_TYPE";
      6'h02 : write = "J"; 
      6'h03 : write = "JAL"; 
      6'h04 : write = "BEQZ";
      6'h05 : write = "BNEZ";
      6'h06 : write = "BFPT";  
      6'h07 : write = "BFPF";  
      6'h08 : write = "ADDI";
      6'h09 : write = "ADDUI";
      6'h0A : write = "SUBI";
      6'h0B : write = "SUBUI";
      6'h0C : write = "ANDI";
      6'h0D : write = "ORI";
      6'h0E : write = "XORI";
      6'h0F : write = "LHI";
      6'h10 : write = "RFE";     
      6'h11 : write = "TRAP";  
      6'h12 : write = "JR";
      6'h13 : write = "JALR";
      6'h14 : write = "SLLI";
      6'h16 : write = "SRLI";
      6'h17 : write = "SRAI";
      6'h18 : write = "SEQI";
      6'h19 : write = "SNEI";
      6'h1A : write = "SLTI";
      6'h1B : write = "SGTI";
      6'h1C : write = "SLEI";
      6'h1D : write = "SGEI";
      6'h20 : write = "LB";
      6'h21 : write = "LH";
      6'h23 : write = "LW";
      6'h24 : write = "LBU";
      6'h25 : write = "LHU";
      6'h26 : write = "LF";
      6'h27 : write = "LD";
      6'h28 : write = "SB";
      6'h29 : write = "SH";
      6'h2B : write = "SW";
      6'h2E : write = "SF";
      6'h2F : write = "JD";
      default : write = "UNKNOWN";
  endcase
end

endmodule
