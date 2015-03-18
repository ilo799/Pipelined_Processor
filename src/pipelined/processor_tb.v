module Testbench;

  reg clk;
  reg reset;

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


