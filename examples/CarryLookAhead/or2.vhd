// and2.v

// 2-input, 1 bit OR gate

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps
//compiler directive to specify the unit for the delays
//`timescale <time unit>/<time precision>

module or2
(input A, B, 
 output reg F);

   //**always** (sensitivity list)
   always @ (A or B)
   begin
      F <= A | B;
   end

endmodule


