//2-input 32-bit OR gate 
//Copyright: Northwestern EECS 362 Team Senioritis 


module OR2_32(F,A,B);

  input [31: 0] A, B; 
  output[31: 0] F;

  or (F[0], A[0],  B[0]);
  or (F[1], A[1],  B[1]);
  or (F[2], A[2],  B[2]);
  or (F[3], A[3],  B[3]);
  or (F[4], A[4],  B[4]);
  or (F[5], A[5],  B[5]);
  or (F[6], A[6],  B[6]);
  or (F[7], A[7],  B[7]); 

  or (F[8], A[8],  B[8]);
  or (F[9], A[9],  B[9]);
  or (F[10], A[10],  B[10]);
  or (F[11], A[11],  B[11]);
  or (F[12], A[12],  B[12]);
  or (F[13], A[13],  B[13]);
  or (F[14], A[14],  B[14]);
  or (F[15], A[15],  B[15]);

  or (F[16], A[16],  B[16]);
  or (F[17], A[17],  B[17]);
  or (F[18], A[18],  B[18]);
  or (F[19], A[19],  B[19]);
  or (F[20], A[20],  B[20]);
  or (F[21], A[21],  B[21]);
  or (F[22], A[22],  B[22]);
  or (F[23], A[23],  B[23]);

  or (F[24], A[24],  B[24]);
  or (F[25], A[25],  B[25]);
  or (F[26], A[26],  B[26]);
  or (F[27], A[27],  B[27]);
  or (F[28], A[28],  B[28]);
  or (F[29], A[29],  B[29]);
  or (F[30], A[30],  B[30]);
  or (F[31], A[31],  B[31]);

endmodule
