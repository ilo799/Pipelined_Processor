module Hazard_Detect (
  //In 
  //RegWrAddr_Dec, RegWrAddr_Exe, RegWrAddr_Mem, RegWrAddr_WB,
  Rs1, Rs2, OpCode_In, Function_In, clk, reset,

  //Out
  OpCode, Function, PC_stall
);

  //input[0:5] RegWrAddr_Dec, RegWrAddr_Exe, RegWrAddr_Mem, RegWrAddr_WB;
  input[0:5] OpCode_In, Function_In; 
  input[0:4] Rs1, Rs2; 
  input clk, reset; 
  
  output [0:5] OpCode, Function;
  output PC_stall;

  reg[0:31] stall_counter; //just make it really big so it doesn't overflow...

  //Dummy Hazard Detect: Stall for 4 cycles after every instruction
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      stall_counter <= 0;
    end
    else begin
      stall_counter <= stall_counter + 1; 
    end
  end

    wire pc_stall;
    assign PC_stall = pc_stall; 
    assign pc_stall = (stall_counter%5 != 0);
    MUX2_n #(6) mux1(OpCode, OpCode_In, 6'h00, pc_stall);
    MUX2_n #(6) mux2(Function, Function_In, 6'h15, pc_stall);

endmodule
