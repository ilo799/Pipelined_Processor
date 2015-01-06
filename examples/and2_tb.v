// and2_tb.v

// 2-input AND gate testbench

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

module Testbench;

   reg A_t, B_t;
   wire F_t;

   AND2gate AND2gate_1(A_t, B_t, F_t);
   
   initial
   begin

   $display("And2 Test Bench");
   $monitor("A is %b, B is %b, F_t is %b.", A_t, B_t, F_t);
      
      //case 0
      #1 A_t <= 0; B_t <= 0;
	  
      //case 1
      #1 A_t <= 0; B_t <= 1;
	  
      //case 2
      #1 A_t <= 1; B_t <= 0;
	  
      //case 3
      #1 A_t <= 1; B_t <= 1;
      
      $finish;
  
   end
endmodule
