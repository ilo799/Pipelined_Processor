// and2n.v

// 2-input, n-bit width AND gate

`timescale 1ns / 1ps

module and2n #(parameter n=1) 
  (input[n-1:0] A, B,
   output reg [n-1:0] F);

   //**always** (sensitivity list)
   always @ (A or B)
   begin
      F <= A & B;
   end

endmodule

