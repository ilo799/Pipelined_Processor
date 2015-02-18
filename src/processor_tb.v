module Testbench;

  reg clk;
  reg reset;

  Processor Processor0 (.clk(clk), .reset(reset));

  initial begin
    #1 clk<=0; reset<=1;
    #1 reset<=0;

    repeat(100000) begin
    #1 clk <= !clk;
    end
  end
endmodule

