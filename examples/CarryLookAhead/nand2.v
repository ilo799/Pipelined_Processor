// nand2.v
// 2-input, 1 bit NAND gate

`timescale 1ns / 1ps

module nand2
(input A, B, 
 output reg F);

   always @ (A or B)
   begin
      F <= ~(A & B);
   end

endmodule


