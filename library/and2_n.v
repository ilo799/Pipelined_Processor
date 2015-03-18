//2-input n-bit AND gate 
//***32 bits by default*** 
//Copyright: Northwestern EECS 362 Team Senioritis 

module AND2_n #(parameter  n=32) (F, A, B); // synopsys template
  input [n-1: 0] A, B; 
  output[n-1: 0] F;

  genvar i;
  generate
    for(i = 0; i < n; i = i+1)
    begin : and_gate
      and (F[i], A[i],  B[i]);
    end
  endgenerate
endmodule
