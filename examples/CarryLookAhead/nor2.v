// nor2.v

// 2-input, 1 bit NOR2 gate

`timescale 1ns / 1ps

module nor2
(input A, B, 
 output reg F);

   //**always** (sensitivity list)
   always @ (A or B)
   begin
      F <= ~(A | B);
   end

endmodule


