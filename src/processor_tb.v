module Testbench;

  reg clk;
  reg reset;

  Processor #(.InstructionFile("../class_examples/fibExample/instr.hex")) Processor0 (.clk(clk), .reset(reset));

  initial begin
    #1 clk<=0; reset<=1;
    #1 reset<=0;

    $dumpfile("processor.vcd");
    $dumpvars;
    $readmemh("../class_examples/fibExample/data.hex", Processor0.mem.mem);
    $display("MemWAddr\tMemDin");
    $monitor("%h\t%h", Processor0.mem_addr, Processor0.mem_din);
    clk = 0;
    reset = 1;
    #1 reset = 0;
  end

  always begin
    #1 clk <= !clk;
  end
endmodule

