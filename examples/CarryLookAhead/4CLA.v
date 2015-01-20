//4-bit carry look ahead adder

module CarryLookAhead4
(
 input C_in, 
 input [3:0] A, B,  
 output [3:0]S,
 output PG, GG);
 
 wire P0, P1, P2, P3, G0, G1, G2, G3, C1, C2, C3 ;
 
 FA FA_1 (.A(A[0]), .B(B[0]), .C_in(C_in), .G(G0), .P(P0), .S(S[0]));
 FA FA_2 (.A(A[1]), .B(B[1]), .C_in(C1), .G(G1), .P(P1), .S(S[1]));
 FA FA_3 (.A(A[2]), .B(B[2]), .C_in(C2), .G(G2), .P(P2), .S(S[2]));
 FA FA_4 (.A(A[3]), .B(B[3]), .C_in(C3), .G(G3), .P(P3), .S(S[3]));
 CLA_4 CLA_4_1 (.C0(C_in), .P0(P0), .P1(P1), .P2(P2), .P3(P3),.G0(G0), .G1(G1), .G2(G2), .G3(G3), .C1(C1), .C2(C2), .C3(C3), .C4(C_out), .PG(PG), .GG(GG));

endmodule


