//2-input n-bit OR gate 
//***32-bit by default***
//Copyright: Northwestern EECS 362 Team Senioritis 

module OR2_n #(parameter  n=32) (F, A, B);
  input [0 : n-1] A, B; 
  output[0 : n-1] F;

  genvar i;
  generate
    for(i = 0; i < n; i = i+1)
    begin : or_gate
      or (F[i], A[i],  B[i]);
    end
  endgenerate
endmodule
