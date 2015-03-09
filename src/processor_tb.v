module Testbench;

  reg clk;
  reg reset;

  Processor #(
    .InstructionFile("../examples/quicksort/qsort_instr.hex"),
    .InstructionInitAddress(0)
  ) Processor0 (.clk(clk), .reset(reset));

  initial begin
    $dumpfile("processor.vcd");
    $dumpvars;
    $readmemh("../examples/quicksort/qsort_data.hex", Processor0.mem.mem);
    $display("MemWAddr\tMemDin");
    $monitor("%h\t%h", Processor0.mem_addr, Processor0.mem_din);
    clk = 0;
    reset = 1;
    #1 reset = 0;
  end

  always begin
    #1 clk <= !clk;
  end

  always @(posedge clk) begin
    if (Processor0.OpCode == 6'h11) begin
      $finish;
    end
  end
endmodule
