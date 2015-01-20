//CLA16TB.v
//16 bit Carry Lookahead Adder TestBench

`timescale 1ns / 1ps 

module CLA16TB;

reg C_in;
reg[15:0] A, B;
wire C_out;
wire[15:0] S;

 CarryLookAhead16 CLA16_1(.C_in(C_in), .A(A), .B(B), .S(S), .C_out(C_out));
 
 initial
 begin

  //case 1    
  A<=0; B<=0; C_in<=1;
  
  //case 1    
  #1 A<=6; B<=5; C_in<=0;
  
  //case 2    
  #1 A<=5; B<=5; C_in<=0;
  
  //case 3    
  #1 A<=7; B<=1; C_in<=1;
  
  //case 3    
  #1 A<=8; B<=8; C_in<=0;
  
   //case 3    
  #1 A<=15; B<=15; C_in<=0;
  
  //case 3    
  #1 A<=15; B<=15; C_in<=1;
  
    //case 3    
  #1 A<=500; B<=500; C_in<=1;
  
  
  
  

 end
 endmodule
