//FA _tb.v
// Full Adder Testbench

`timescale 1ns / 1ps 

module FA_tb;

reg A, B, C_in;
wire G, P, S;

 FA FA_1(.A(A), .B(B), .C_in(C_in), .G(G), .P(P), .S(S));
 
 initial
 begin

  //case 1    
  A<= 0; B <= 0; C_in<=0;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
	  
  //case 2   
  A<= 0; B <= 0; C_in<=1;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 3    
  A<= 0; B <= 1; C_in<=0;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 4    
  A<= 0; B <= 1; C_in<=1;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 5   
  A<= 1; B <= 0; C_in<=0;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 6    
  A<= 1; B <= 0; C_in<=1;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 7    
  A<= 1; B <= 1; C_in<=0;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);
  
  //case 8    
  A<= 1; B <= 1; C_in<=1;
  #1 $display("Gen = %b Prop=%b Sum=%b", G, P, S);


 end
 endmodule
