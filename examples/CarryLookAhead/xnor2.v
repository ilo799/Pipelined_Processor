// xnor2.v

// 2-input, 1 bit XNOR gate

`timescale 1ns / 1ps

module xnor2
(input A, B, 
 output reg F);

   //**always** (sensitivity list)
   always @ (A or B)
   begin
       F <= A ~^ B;
   end

endmodule

