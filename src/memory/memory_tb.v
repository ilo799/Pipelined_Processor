//Test-bench for Memory taken from vol/eecs362/examples adapted for Team Senoritis

module Testbench();
    parameter IMEMFILE = "../../inputs/instr.hex";
    parameter DMEMFILE = "../../inputs/data.hex";
    reg [8*80-1:0] filename;
    reg [0:31] iaddr, daddr, dwdata;
    wire [0:31] instr, drdata;
    wire flag;
    reg dwrite;
    reg [0:1] dsize;
    reg dsign;
    reg clk;

    integer dfileobj, dmaddr, r, k, i;

    imem #(.SIZE(1024)) IMEM(.addr(iaddr), .instr(instr));
    dmem #(.SIZE(16384)) DMEM(.addr(daddr), .rData_out(drdata), .wData(dwdata), .writeEnable(dwrite), .dsize(dsize), .dsign(dsign), .clk(clk), .error_flag(flag));

    initial begin
        // Clear DMEM
        for (i = 0; i < DMEM.SIZE; i = i+1)
            DMEM.mem[i] = 8'h0;

        // Load IMEM from file
        if (!$value$plusargs("instrfile=%s", filename)) begin
            filename = IMEMFILE;
        end
        $readmemh(filename, IMEM.mem);
        // Load DMEM from file
        if (!$value$plusargs("datafile=%s", filename)) begin
            filename = DMEMFILE;
        end
        $readmemh(filename, DMEM.mem);

        //// Debug: dump memory
        // $writememh("imem", IMEM.mem);
        // $writememh("dmem", DMEM.mem);

        // Read out some values. Note clock ticks between setting values
        // & reading values in tests.
        // - First two instructions
        iaddr = 32'h0;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
        iaddr = 32'h4;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
        // - Some Data values
        // 'monitor' follows signals automatically as they change
 

       $monitor("addr= %x data = %x flag = %b dsign = %b dsize = %b WE = %b", daddr, drdata, flag, dsign, dsize, dwrite);
       
       // Check Reads
 
       //Read Word
       // Check Misalignment errors: 
       #1 dsign <= 1'b0; dsize <= 2'b11; dwrite <= 1'b0; daddr = 32'h2001;
       #1 daddr <= 32'h2002;
       // Valid
       #1 daddr <= 32'h2000;
       #1 daddr <= 32'h2004;

       //Read HWord
       // Check Misalignment errors: 
       #1 dsign <= 1'b0; dsize <= 2'b01; dwrite <= 1'b0; daddr = 32'h2001;
       // Valid
       #1 daddr <= 32'h2000;
       #1 dsign <= 1'b1;
       #1 daddr <= 32'h2002;
       #1 daddr <= 32'h2022; 

       //Read Byte
       #1 dsize <= 2'b00; dwrite <= 1'b0; daddr <= 32'h2000;
       #1 daddr <= 32'h2001;


       //Check Writes
       #1 dsize <= 2'b11; dwrite <= 1'b1; daddr <= 32'h2002; dwdata <= 32'hbeef; //Misalligned
       clk <= 1;
       clk <= 0;
       clk <= 1;   
       #1 dsize <= 2'b01; daddr <= 32'h2021; dwdata <= 32'hbeef; //Misalligned
       clk <= 1;
       clk <= 0;
       clk <= 1;
       #1 dsize <= 2'b00; daddr <= 32'h2000; dwdata <= 8'hef;
       clk <= 1;
       clk <= 0;
       clk <= 1;
       #1 daddr <= 32'h2001; dwdata <= 8'hbe;
       clk <= 1;
       clk <= 0;
       clk <= 1;
       #1 dsize <= 2'b01; daddr <= 32'h2002; dwdata <= 16'hdead;
       clk <= 1;
       clk <= 0;
       clk <= 1;
       #1 dsize <= 2'b11; dwrite <= 1'b0; daddr <= 32'h2000; //should read "deadbeef"
       clk <= 1;
       clk <= 0;
       clk <= 1;
    
  end // initial
endmodule

