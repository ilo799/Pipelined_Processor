//16-bit carry look ahead adder

module CarryLookAhead16
(
 input C_in, 
 input [15:0] A, B,  
 output [15:0] S,
 output C_out, PG, GG);
 
 wire P0, P1, P2, P3, G0, G1, G2, G3, C1, C2, C3 ;
 CarryLookAhead4 Add4_1 (.C_in(C_in), .A(A[3:0]), .B(B[3:0]), .S(S[3:0]), .PG(P0), .GG(G0));
 CarryLookAhead4 Add4_2 (.C_in(C1), .A(A[7:4]), .B(B[7:4]), .S(S[7:4]), .PG(P1), .GG(G1));
 CarryLookAhead4 Add4_3 (.C_in(C2), .A(A[11:8]), .B(B[11:8]), .S(S[11:8]), .PG(P2), .GG(G2));
 CarryLookAhead4 Add4_4 (.C_in(C3), .A(A[15:12]), .B(B[15:12]), .S(S[15:12]), .PG(P3), .GG(G3));
 
 CLA_4 CLA_4_1 (.C0(C_in), .P0(P0), .P1(P1), .P2(P2), .P3(P3),.G0(G0), .G1(G1), .G2(G2), .G3(G3), .C1(C1), .C2(C2), .C3(C3), .C4(C_out), .PG(PG), .GG(GG));

endmodule