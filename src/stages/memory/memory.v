module Memory (
  // Out
  MEMDout, ALUOut, FPUOut, Opcode, Funct, PCPlusFour, Immediate, //Data
  WBData,
  DInSrc, RegWE, RegWAddr , //WB Control

  // In
  clk, reset, stall,
  NextDInSrc, NextRegWE, NextRegWAddr, NextMEMSize, NextMEMWE, NextExtMEM,
  NextALUOut, NextFPUOut, NextRegB, NextOpcode, NextFunct, NextPCPlusFour, NextImmediate,
  RegBSrc, WBRegB,
);

  input clk, reset, stall;
  input [0:31] NextALUOut, NextFPUOut, NextRegB;
  input [0:5] NextFunct;
  input [0:5] NextOpcode;
  input [0:31] NextPCPlusFour;
  input [0:15] NextImmediate;

  input [0:1] NextDInSrc;
  input NextRegWE;
  input [0:5] NextRegWAddr;
  input [0:1] NextMEMSize;
  input NextMEMWE;
  input NextExtMEM;

  input RegBSrc;
  input [0:31] WBRegB;

  output [0:31] MEMDout;
  output [0:31] ALUOut, FPUOut;

  output [0:1] DInSrc;
  output RegWE;
  output [0:5] RegWAddr;

  output [0:31] PCPlusFour;
  output [0:5] Funct;
  output [0:5] Opcode;
  output [0:15] Immediate; 
  output [0:31] WBData;

  reg [0:31] alu_out, fpu_out, reg_b;
  reg [0:5] funct;
  reg [0:5] opcode;
  reg [0:31] pc_plus_four;
  reg [0:15] immediate;

  reg [0:1] din_src;
  reg reg_we;
  reg [0:5] reg_w_addr;
  reg [0:1] mem_size;
  reg mem_we;
  reg  ext_mem;

  //Forward data
  assign FPUOut = fpu_out;
  assign ALUOut = alu_out;
  assign Funct = funct;
  assign Opcode = opcode;
  assign PCPlusFour = pc_plus_four;
  assign Immediate = immediate;

  assign DInSrc = din_src;
  assign RegWAddr = reg_w_addr;
  assign RegWE = reg_we;

  wire [0:31] write_data;
 
  always @(posedge clk or posedge reset) begin
  
  if (reset) begin
      alu_out <= 0;
      fpu_out <= 0;
      reg_b <= 0;
      funct <= 6'h15;
      opcode <= 6'b0;
      pc_plus_four <= 0;
      immediate <= 16'b0;

      din_src <= 2'b0;
      reg_w_addr <= 6'b0;
      reg_we <= 1'b0;
      mem_size <= 2'b0;
      mem_we <= 1'b0;
      ext_mem <= 1'b0;
  end
  else begin
      alu_out <= NextALUOut;
      fpu_out <= NextFPUOut;
      reg_b <= NextRegB;
      funct <= NextFunct;
      opcode <= NextOpcode;
      pc_plus_four <= NextPCPlusFour;
      immediate <= NextImmediate; 

      din_src <= NextDInSrc;
      reg_w_addr <= NextRegWAddr;
      reg_we <= NextRegWE;
      mem_size <= NextMEMSize;
      mem_we <= NextMEMWE;
      ext_mem <= NextExtMEM;
    end
  end

  wire we;
  assign we = mem_we & !stall;

  MUX2_n #(32) write_data_mux(write_data, reg_b, WBRegB, RegBSrc);

  dmem mem (.addr(alu_out),.wData(write_data), .writeEnable(we), .dsize(mem_size),.dsign(ext_mem), .clk(clk), .rData_out(MEMDout));

  MUX4_n #(32) reg_din_mux (.F(WBData),.A(pc_plus_four), .B(alu_out), .C(fpu_out), .D(32'bX), .Sel(din_src));

endmodule
