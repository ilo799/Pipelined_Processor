// and2gate.v

// 2-input AND gate

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps

module AND2gate(A, B, F);

   input A;
   input B;
   output F;
   reg F;

   always @ (A or B)
   begin
   
      F <= A & B;
   end

endmodule
