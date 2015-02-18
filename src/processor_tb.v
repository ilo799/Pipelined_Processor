module Testbench;

  reg clk;
  reg reset;

  Processor Processor0 (.clk(clk), .reset(reset));

  initial begin
    $dumpfile("processor.vcd");
    $dumpvars;
    $readmemh("../inputs/data.hex", Processor0.mem.mem);
    clk = 0;
    reset = 1;
    #1 reset = 0;
  end

  always begin
    #1 clk <= !clk;
  end
endmodule

