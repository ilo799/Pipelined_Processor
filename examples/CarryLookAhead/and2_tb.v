// and2_tb.v

// 2-input AND gate testbench

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps 

module and2_tb;
//Testbenches have no ports

reg A_t, B_t;
//inputs are regs
wire F_t;
//outputs are wires


 and2 and2_1(.A(A_t), .B(B_t), .F(F_t));
 
 initial
 begin
 //initial block executed only once when simulation starts
 
      //case 0
      //<= "nonblocking"/concurrent/parallel assignment 
      
      A_t <= 0; B_t <= 0;
      //wait for 1 time unit, display f_t value in binary?
      #1 $display("F_t = %b", F_t);
	  
      //case 1
      A_t <= 000; B_t <= 101;
      #1 $display("F_t = %b", F_t);
	  
      //case 2
      A_t <= 1; B_t <= 0;
      #1 $display("F_t = %b", F_t);
	  
      //case 3
      A_t <= 1; B_t <= 1;
      #1 $display("F_t = %b", F_t);
 end
 endmodule