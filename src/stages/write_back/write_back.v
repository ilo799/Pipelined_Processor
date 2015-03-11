module WriteBack (
  // Out
  RegWBWE, RegWBAddr, RegWBData,

  //In
  clk, reset, stall,
  NextMEMDout, NextALUOut, NextFPUOut, 
  NextOpcode, NextFunct, NextPCPlusFour, NextImmediate,  
  NextDInSrc, NextRegWE, NextRegWAddr
);


  input clk, reset, stall;
  input [0:31] NextALUOut, NextFPUOut, NextMEMDout;

  input [0:5] NextFunct;
  input [0:5] NextOpcode;
  input [0:31] NextPCPlusFour;
  input [0:15] NextImmediate;

  input [0:1] NextDInSrc;
  input NextRegWE;
  input [0:5] NextRegWAddr;
 
  output [0:5] RegWBAddr;
  output RegWBWE;
  output [0:31] RegWBData;

  reg [0:31] alu_out, fpu_out, mem_out;
  reg [0:5] funct;
  reg [0:5] opcode;
  reg [0:31] pc_plus_four;
  reg [0:15] immediate;

  reg [0:1] din_src;
  reg reg_we;
  reg [0:1] reg_w_addr;

  //Forward data
  assign RegWBWE = reg_we;
  assign RegWBAddr = reg_w_addr; 

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      alu_out <= 0;
      fpu_out <= 0;
      mem_out <= 0;
      funct <= 6'b0;
      opcode <= 6'b0;
      pc_plus_four <= 0;
      immediate <= 16'b0;

      din_src <= 2'b0;
      reg_we <= 1'b0;
      reg_w_addr<= 6'b0;
    end
    else begin
      alu_out <= NextALUOut;
      fpu_out <= NextFPUOut;
      mem_out <= NextMEMDout; 
      funct <= NextFunct;
      opcode <= NextOpcode;
      pc_plus_four <= NextPCPlusFour;
      immediate <= NextImmediate;

      din_src <= NextDInSrc;
      reg_we <= NextRegWE;
      reg_w_addr<= NextRegWAddr;
    end
  end

  MUX4_n #(32) reg_din_mux (.F(RegWBData),.A(pc_plus_four), .B(alu_out), .C(fpu_out), .D(mem_out), .Sel(din_src));

endmodule
