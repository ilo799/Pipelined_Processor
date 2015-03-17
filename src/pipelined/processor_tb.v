module Testbench;

  reg clk;
  reg reset;

  Processor #(.InstructionFile("../../class_examples/qsort/qsort_instr.hex")) Processor0 (.clk(clk), .reset(reset));

  initial begin
    $dumpfile("processor.vcd");
    $dumpvars;
    $readmemh("../../class_examples/qsort/qsort_data.hex", Processor0.memory.mem.mem);
    //$display("MemWAddr\tMemDin");
    //$monitor("%h\t%h", Processor0.memory.mem.addr, Processor0.memory.mem.wData);
    clk = 0;
    reset = 1;
    #1 clk = 1;
    #1 clk = 0;
    #1 reset = 0;
  end

  always begin
    #1 clk <= !clk;
    if (Processor0.write_back.opcode == 6'h11)
    begin
     $finish;
    end
  end
endmodule


