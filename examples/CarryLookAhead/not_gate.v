// not_gate.v

// 1-input, 1 bit NOT gate

`timescale 1ns / 1ps

module not_gate
(input A,
 output reg F);

   always @ (A)
   begin
      F <= ~A;
   end

endmodule
