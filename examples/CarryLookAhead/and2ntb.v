//and2n_tb.v

// 2-input n-width AND gate testbench

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps 

module and2ntb;
//Testbenches have no ports

reg[2:0] A_t, B_t;
//inputs are regs
wire[2:0] F_t;
//outputs are wires


 and2n #(.n(3)) and2n_1(.A(A_t), .B(B_t), .F(F_t));
 
 initial
 begin
 //initial block executed only once when simulation starts
 
      //case 0
      //<= "nonblocking"/concurrent/parallel assignment 
      
      A_t <= 00; B_t <= 00;
      //wait for 1 time unit, display f_t value in binary?
      #1 $display("F_t = %b", F_t);
	  
      //case 1
      A_t <= 11; B_t <= 01;
      #1 $display("F_t = %b", F_t);
	  
      //case 2
      A_t <= 10; B_t <= 01;
      #1 $display("F_t = %b", F_t);
	  
      //case 3
      A_t <= 11; B_t <= 11;
      #1 $display("F_t = %b", F_t);
 end
 endmodule

