//1-input n-bit Inverter gate 
//***32-bit by default***
//Copyright: Northwestern EECS 362 Team Senioritis 

module NOT_n #(parameter  n=32) (F, A);
  //synopsys template 
  input [0 : n-1] A; 
  output[0 : n-1] F;
  genvar i;
  generate
    for(i = 0; i < n; i = i+1)
    begin : not_gate
      not (F[i], A[i]);
    end
  endgenerate
endmodule
