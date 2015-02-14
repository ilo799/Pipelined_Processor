// ------------------------------------------------------------------
// Testbench for General Purpose Shifer
//-------------------------------------------------------------------- 

module Testbench;
 
  //32-bit SIGNED input: (A reg is unsigned)
  integer  A_32; 

  //Shifter Output
  wire[31:0] SHIFT_LL;
  wire[31:0] SHIFT_LA;
  wire[31:0] SHIFT_RL;
  wire[31:0] SHIFT_RA;

  //Verilog Operator Outputs
  wire[31:0] SLL;
  wire[31:0] SLA;
  wire[31:0] SRL; 
  wire[31:0] SRA;

  reg[4:0] Shamt;

  Shifter Shifter_LL(SHIFT_LL, A_32 , Shamt, 1'b0, 1'b0);
  Shifter Shifter_LA(SHIFT_LA, A_32 , Shamt, 1'b0, 1'b1);
  Shifter Shifter_RL(SHIFT_RL, A_32 , Shamt, 1'b1, 1'b0);
  Shifter Shifter_RA(SHIFT_RA, A_32 , Shamt, 1'b1, 1'b1);

  assign SLL = A_32 << Shamt;
  assign SLA = A_32 <<< Shamt;
  assign SRL = A_32 >> Shamt;
  assign SRA = A_32 >>> Shamt;

  initial
  begin
  
    Shamt <= 5'd0;
  
    repeat(300) begin
      #1 A_32 <= -200; //Test w/ pos and neg
      repeat (32) begin //Test all shifts from 0-32
        if (SHIFT_LL !== SLL) begin
          $display ("Error SLL Mismatch: In =%b, shamt =%d, SLL =%b, SHIFT_LL =%b", A_32, Shamt, SLL, SHIFT_LL);
        end
        if (SHIFT_LA !== SLA) begin
          $display ("Error SLA Mismatch: In=%b, shat= %d, SLA =%b, SHIFT_LA =%b", A_32, Shamt, SLA, SHIFT_LA);
        end

        if (SHIFT_RL !== SRL) begin
          $display ("Error SRL Mismatch: In =%b, shamt =%d, SRL =%b, SHIFT_RL =%b", A_32, Shamt, SRL, SHIFT_RL);
        end

        if (SHIFT_RA !== SRA) begin
          $display ("Error SRA Mismatch: In =%b, shamt =%d SRA =%b, SHIFT_RA =%b", A_32, Shamt, SRA, SHIFT_RA);
        end
        Shamt <= Shamt + 1;
      end
    end
    
    //Display Sanity for Checks:
    #1 A_32 = 150959864;
    #1 Shamt <= 5'd18;
    #1 $display ("For input = %d, Shamt = %d, SLL = %d/%d, SLA = %d/%d, SRL = %d/%d, SRA = %d/%d", A_32, 
               Shamt, SHIFT_LL, SLL, SHIFT_LA, SLA, SHIFT_RL, SRL, SHIFT_RA, SRA);
  end
endmodule
