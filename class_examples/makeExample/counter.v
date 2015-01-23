// N-bit counter
module counter(clk, rst, count);
    parameter WIDTH=32;
    input clk, rst;
    output [0:(WIDTH-1)] count;

    wire [0:(WIDTH-1)] prev, next;

    // Registers to store value
    // 'prev' is _output_
    // 'next' is _input_
    PipeReg #(.width(WIDTH), .init(0)) ACCUM_REG(
        .out(prev),
        .in(next),
        .clk(clk),
        .rst(rst)
    );
    // Adder to increment value
    // 'prev' is _input_
    // 'next' is _output_
    fa_nbit #(.WIDTH(WIDTH)) FA32(
        .A(prev),
        .B(32'h00000001),
        .cin(1'b0),
        .Sum(next),
        .cout()
    );
    assign count = prev;
endmodule

// Pipe register from Synopsys template
module PipeReg(out, in, clk, rst); // synopsys template
   parameter width = 32, init = 0;
   output [0:width-1] out;
   reg [0:width-1]    out;
   input [0:width-1]  in;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else
       out <= in;
endmodule // PipeReg


