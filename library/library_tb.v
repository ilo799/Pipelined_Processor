// ------------------------------------------------------------------
// Testbench for STD Lib Gates
// 
// ------------------------------------------------------------------

module Testbench;
   
   reg A_1, B_1, C_1, Sel_0,Sel_1;
   reg[31: 0] A_32, B_32;
   
   wire[31: 0] AND2_32_OUT;
   wire[31: 0]  OR2_32_OUT;
   wire MUX2_1_OUT, MUX3_1_OUT;

   AND2_32 AND2_32(AND2_32_OUT, A_32, B_32);
   OR2_32 OR2_32(OR2_32_OUT, A_32, B_32);
   MUX2_1 MUX2_1(MUX2_1_OUT, A_1, B_1, Sel_0);
   MUX3_1 MUX3_1(MUX3_1_OUT, A_1, B_1, C_1, Sel_0, Sel_1);
   
   initial
   begin
      //case 0
      #1 A_32 <= 32'd0; B_32 <= 32'd0; A_1 <= 1'd0; B_1 <=1'd0; Sel_0<=1'd0;
      #1 if (AND2_32_OUT != 5) //wrong change it back...
      begin
         $display ("AND2_32 ERROR. IN:%d, %d. OUt:%d. EXPECTED: 0", A_32, B_32, AND2_32_OUT);
      end
      if (OR2_32_OUT != 5) //wrong change it back...
      begin
         $display ("AND2_32 ERROR. IN:%d, %d. OUt:%d. EXPECTED: 0", A_32, B_32, AND2_32_OUT);
      end
      if (MUX2_1_OUT != 5) //wrong change it back...
      begin
         $display ("MUX2_1 ERROR. IN:%d, %d, %d. OUt:%d. EXPECTED: 0", A_1, B_1, Sel_0, MUX2_1_OUT);
      end

      #1 $display("simulation complete.");
      $finish; 
   end
endmodule
