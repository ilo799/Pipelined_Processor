// ------------------------------------------------------------------
// Testbench for FPU
//-------------------------------------------------------------------- 

module Testbench;

  //32-bit input
  integer A_32, B_32;
  reg[0:2] FPUOp;
   
  wire[0:31] F_32;

  fpu fpu0(.F(F_32), .A(A_32), .B(B_32), .FPUOp(FPUOp));


  initial
  begin
   
    //Use for debug...
    $monitor({ "A_32 = %d, B_32 = %d. F_32 = %d. \n"},  
               A_32, B_32, F_32);


    #1  A_32 <= 678; B_32 <= 4293; FPUOp<=3'b0;
    #1  A_32 <= -67; B_32 <= -93;
    #1  A_32 <= 7; B_32 <= -7; //2s-comp


    end

   //Add more tests.
endmodule
