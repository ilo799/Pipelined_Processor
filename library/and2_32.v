//2-input 32-bit AND gate 
//Copyright: Northwestern EECS 362 Team Senioritis 

module AND2_32(F,A,B);

  input [31: 0] A, B; 
  output[31: 0] F;

  and (F[0], A[0],  B[0]);
  and (F[1], A[1],  B[1]);
  and (F[2], A[2],  B[2]);
  and (F[3], A[3],  B[3]);
  and (F[4], A[4],  B[4]);
  and (F[5], A[5],  B[5]);
  and (F[6], A[6],  B[6]);
  and (F[7], A[7],  B[7]); 

  and (F[8], A[8],  B[8]);
  and (F[9], A[9],  B[9]);
  and (F[10], A[10],  B[10]);
  and (F[11], A[11],  B[11]);
  and (F[12], A[12],  B[12]);
  and (F[13], A[13],  B[13]);
  and (F[14], A[14],  B[14]);
  and (F[15], A[15],  B[15]);

  and (F[16], A[16],  B[16]);
  and (F[17], A[17],  B[17]);
  and (F[18], A[18],  B[18]);
  and (F[19], A[19],  B[19]);
  and (F[20], A[20],  B[20]);
  and (F[21], A[21],  B[21]);
  and (F[22], A[22],  B[22]);
  and (F[23], A[23],  B[23]);

  and (F[24], A[24],  B[24]);
  and (F[25], A[25],  B[25]);
  and (F[26], A[26],  B[26]);
  and (F[27], A[27],  B[27]);
  and (F[28], A[28],  B[28]);
  and (F[29], A[29],  B[29]);
  and (F[30], A[30],  B[30]);
  and (F[31], A[31],  B[31]);

endmodule
