module Testbench;

   reg [31:0] A_t, B_t;
   wire [31:0] F_t;

   AND32 AND32(F_t, A_t, B_t);
  
   initial
   begin

   $display("And32 Test Bench");
   $monitor("A is %h, B is %h, F_t is %h.", A_t, B_t, F_t);
      
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
