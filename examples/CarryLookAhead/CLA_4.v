// CLA_4.v

// 4 bit carry look ahead unit
`timescale 1ns / 1ps

module CLA_4
(input C0, P0, P1, P2, P3, G0, G1, G2, G3, 
 output C1, C2, C3, C4, PG, GG);
 
 wire[9:0] t;

//C1=G0+P0C0
and2 and2_1(.A(C0), .B(P0), .F(t[0]));
or2 or2_1(.A(G0), .B(t[0]), .F(C1)); 

//C2=G1+G0P1+P1P0C0
and3 and3_1(.A(C0), .B(P0), .C(P1), .F(t[1]));
and2 and2_2(.A(P1), .B(G0), .F(t[2]));
or3 or3_1 (.A(t[1]), .B(t[2]), .C(G1), .F(C2));

//C3=G2+G1P2+G0P2P1+P2P1P0C0
and4 and4_1(.A(C0), .B(P0), .C(P1), .D(P2), .F(t[3]));
and3 and3_2(.A(P1), .B(P2), .C(G0), .F(t[4]));
and2 and2_3(.A(P2), .B(G1), .F(t[5]));
or4 or4_1(.A(t[3]), .B(t[4]), .C(t[5]), .D(G2), .F(C3));

//C4=G3+G2P3+G1P2P3+G0P1P2P3+P3P2P1P0C0
and5 and5_1(.A(C0), .B(P0), .C(P1), .D(P2), .E(P3), .F(t[6]));
and4 and4_2(.A(P1), .B(P2), .C(P3), .D(G0), .F(t[7]));
and3 and3_3(.A(P2), .B(P3), .C(G1), .F(t[8]));
and2 and2_4(.A(P3), .B(G2), .F(t[9]));
or5 or5_1(.A(t[6]), .B(t[7]), .C(t[8]), .D(t[9]), .E(G3), .F(C4));


//**Group Propogate** PG=P0P1P2P3
and4 and4_3(.A(P0), .B(P1), .C(P2), .D(P3), .F(PG));

//**Group Generate** GG=G3+G2P3+G1P2P3+G0P1P2P3
or4 or4_2 (.A(t[7]), .B(t[8]), .C(t[9]), .D(G3), .F(GG));

endmodule


