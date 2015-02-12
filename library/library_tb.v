// ------------------------------------------------------------------
// Testbench for STD Lib Gates
//-------------------------------------------------------------------- 

module Testbench;

  reg[0:0] cycle, Sel;
  //32-bit input
  reg[31: 0] A_32, B_32;
  //5-bit input
  reg[4: 0] A_5, B_5;
   
  
  //LOGIC GATES

  //32-bit logic gate out  
  wire[31: 0] AND2_32_OUT;
  wire[31: 0] OR2_32_OUT;
  wire[31:0] NOT_32_OUT;
  wire[31:0] MUX_32_OUT;


  //5-bit logic gate out
  wire[4: 0] AND2_5_OUT;
  wire[4: 0] OR2_5_OUT;
  wire[4: 0] NOT_5_OUT;

  AND2_n #(32) AND2_32(AND2_32_OUT, A_32, B_32);
  OR2_n #(32)  OR2_32(OR2_32_OUT, A_32, B_32);
  NOT_n #(32) NOT_32(NOT_32_OUT, A_32);
  MUX2_n #(32) MUX2_32(MUX_32_OUT, A_32, B_32, Sel);
 
  AND2_n #(5) AND2_5(AND2_5_OUT, A_5, B_5);
  OR2_n #(5)  OR2_5(OR2_5_OUT, A_5, B_5);
  NOT_n #(5) NOT_5(NOT_5_OUT, A_5);

  initial
  begin
   
    //Use for debug...
    //FIXME_TODO: Look into a way to turn this off/on from cmd line?
    $monitor({"@%d: \n", 
              "A_32 = %h, B_32 = %h. \nAND2_32_OUT = %h, OR2_32_OUT = %h, NOT_32_OUT = %h. \n",  
              "A_5 is %h, B_5 = %h, AND2_5_OUT = %h, OR2_5_OUT = %h, NOT_5_OUT = %h \n",
              "Sel = %h, MUX2_32_OUT = %h \n\n"},  
              
              cycle, A_32, B_32, AND2_32_OUT, OR2_32_OUT, NOT_32_OUT,
              A_5, B_5, AND2_5_OUT, OR2_5_OUT, NOT_5_OUT,
              Sel, MUX_32_OUT);


    #1 cycle <= 0;
       A_32 <= 32'h00_00_00_11; B_32 <= 32'h00_00_00_00;  
       A_5 <= 5'b1_1111; B_5 <= 5'b1_1111; 
       Sel <= 0;
   end

   //Add more tests.
endmodule
