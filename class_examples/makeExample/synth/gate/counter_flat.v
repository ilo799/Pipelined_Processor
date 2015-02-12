
module counter ( clk, rst, count );
  output [0:31] count;
  input clk, rst;
  wire   n95, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n87, n88, n89, n90, n91, n92, n94;
  wire   [0:30] next;

  DFFR_X1 ACCUM_REG_out_reg_28_ ( .D(next[28]), .CK(clk), .RN(rst), .Q(
        count[28]), .QN(n76) );
  DFFR_X1 ACCUM_REG_out_reg_27_ ( .D(next[27]), .CK(clk), .RN(rst), .Q(
        count[27]), .QN(n82) );
  DFFR_X1 ACCUM_REG_out_reg_26_ ( .D(next[26]), .CK(clk), .RN(rst), .Q(
        count[26]) );
  DFFR_X1 ACCUM_REG_out_reg_25_ ( .D(next[25]), .CK(clk), .RN(rst), .Q(
        count[25]) );
  DFFR_X1 ACCUM_REG_out_reg_24_ ( .D(next[24]), .CK(clk), .RN(rst), .Q(
        count[24]), .QN(n77) );
  DFFR_X1 ACCUM_REG_out_reg_23_ ( .D(next[23]), .CK(clk), .RN(rst), .Q(
        count[23]), .QN(n80) );
  DFFR_X1 ACCUM_REG_out_reg_22_ ( .D(next[22]), .CK(clk), .RN(rst), .Q(
        count[22]) );
  DFFR_X1 ACCUM_REG_out_reg_21_ ( .D(next[21]), .CK(clk), .RN(rst), .Q(
        count[21]) );
  DFFR_X1 ACCUM_REG_out_reg_20_ ( .D(next[20]), .CK(clk), .RN(rst), .Q(
        count[20]), .QN(n75) );
  DFFR_X1 ACCUM_REG_out_reg_19_ ( .D(next[19]), .CK(clk), .RN(rst), .Q(
        count[19]), .QN(n83) );
  DFFR_X1 ACCUM_REG_out_reg_18_ ( .D(next[18]), .CK(clk), .RN(rst), .Q(
        count[18]) );
  DFFR_X1 ACCUM_REG_out_reg_17_ ( .D(next[17]), .CK(clk), .RN(rst), .Q(
        count[17]) );
  DFFR_X1 ACCUM_REG_out_reg_16_ ( .D(next[16]), .CK(clk), .RN(rst), .Q(
        count[16]), .QN(n78) );
  DFFR_X1 ACCUM_REG_out_reg_15_ ( .D(next[15]), .CK(clk), .RN(rst), .Q(
        count[15]), .QN(n84) );
  DFFR_X1 ACCUM_REG_out_reg_14_ ( .D(next[14]), .CK(clk), .RN(rst), .Q(
        count[14]) );
  DFFR_X1 ACCUM_REG_out_reg_13_ ( .D(next[13]), .CK(clk), .RN(rst), .Q(
        count[13]) );
  DFFR_X1 ACCUM_REG_out_reg_12_ ( .D(next[12]), .CK(clk), .RN(rst), .Q(
        count[12]), .QN(n79) );
  DFFR_X1 ACCUM_REG_out_reg_11_ ( .D(next[11]), .CK(clk), .RN(rst), .Q(
        count[11]), .QN(n85) );
  DFFR_X1 ACCUM_REG_out_reg_10_ ( .D(next[10]), .CK(clk), .RN(rst), .Q(
        count[10]) );
  DFFR_X1 ACCUM_REG_out_reg_9_ ( .D(next[9]), .CK(clk), .RN(rst), .Q(count[9])
         );
  DFFR_X1 ACCUM_REG_out_reg_8_ ( .D(next[8]), .CK(clk), .RN(rst), .Q(count[8])
         );
  DFFR_X1 ACCUM_REG_out_reg_7_ ( .D(next[7]), .CK(clk), .RN(rst), .Q(count[7])
         );
  DFFR_X1 ACCUM_REG_out_reg_6_ ( .D(next[6]), .CK(clk), .RN(rst), .Q(count[6])
         );
  DFFR_X1 ACCUM_REG_out_reg_5_ ( .D(next[5]), .CK(clk), .RN(rst), .Q(count[5])
         );
  DFFR_X1 ACCUM_REG_out_reg_4_ ( .D(next[4]), .CK(clk), .RN(rst), .Q(count[4])
         );
  DFFR_X1 ACCUM_REG_out_reg_3_ ( .D(next[3]), .CK(clk), .RN(rst), .Q(count[3])
         );
  DFFR_X1 ACCUM_REG_out_reg_2_ ( .D(next[2]), .CK(clk), .RN(rst), .Q(count[2])
         );
  DFFR_X1 ACCUM_REG_out_reg_1_ ( .D(next[1]), .CK(clk), .RN(rst), .Q(count[1]), 
        .QN(n81) );
  DFFR_X1 ACCUM_REG_out_reg_0_ ( .D(next[0]), .CK(clk), .RN(rst), .Q(count[0])
         );
  XNOR2_X2 U3 ( .A(count[9]), .B(n45), .ZN(next[9]) );
  XOR2_X2 U5 ( .A(count[8]), .B(n47), .Z(next[8]) );
  XOR2_X2 U6 ( .A(count[7]), .B(n48), .Z(next[7]) );
  AND2_X2 U7 ( .A1(count[8]), .A2(n47), .ZN(n48) );
  XOR2_X2 U8 ( .A(count[6]), .B(n91), .Z(next[6]) );
  XNOR2_X2 U9 ( .A(count[5]), .B(n50), .ZN(next[5]) );
  NAND2_X2 U10 ( .A1(n91), .A2(count[6]), .ZN(n50) );
  XOR2_X2 U11 ( .A(count[4]), .B(n51), .Z(next[4]) );
  XOR2_X2 U12 ( .A(count[3]), .B(n52), .Z(next[3]) );
  AND2_X2 U13 ( .A1(count[4]), .A2(n51), .ZN(n52) );
  XOR2_X2 U15 ( .A(count[2]), .B(n87), .Z(next[2]) );
  XOR2_X2 U19 ( .A(count[27]), .B(n56), .Z(next[27]) );
  XNOR2_X2 U22 ( .A(count[25]), .B(n58), .ZN(next[25]) );
  XOR2_X2 U25 ( .A(count[23]), .B(n60), .Z(next[23]) );
  XNOR2_X2 U28 ( .A(count[21]), .B(n62), .ZN(next[21]) );
  XOR2_X2 U30 ( .A(n75), .B(n90), .Z(next[20]) );
  XOR2_X2 U32 ( .A(count[19]), .B(n65), .Z(next[19]) );
  XNOR2_X2 U35 ( .A(count[17]), .B(n67), .ZN(next[17]) );
  XOR2_X2 U38 ( .A(count[15]), .B(n69), .Z(next[15]) );
  XNOR2_X2 U41 ( .A(count[13]), .B(n71), .ZN(next[13]) );
  XOR2_X2 U44 ( .A(count[11]), .B(n73), .Z(next[11]) );
  XOR2_X2 U47 ( .A(count[0]), .B(n74), .Z(next[0]) );
  AND3_X2 U50 ( .A1(n51), .A2(count[4]), .A3(count[3]), .ZN(n53) );
  AND3_X2 U52 ( .A1(n47), .A2(count[8]), .A3(count[7]), .ZN(n49) );
  NOR3_X4 U54 ( .A1(n85), .A2(n72), .A3(n79), .ZN(n46) );
  NOR3_X4 U56 ( .A1(n68), .A2(n84), .A3(n78), .ZN(n70) );
  NOR3_X4 U58 ( .A1(n83), .A2(n63), .A3(n75), .ZN(n66) );
  NOR3_X4 U60 ( .A1(n59), .A2(n80), .A3(n77), .ZN(n61) );
  DFFR_X2 ACCUM_REG_out_reg_29_ ( .D(next[29]), .CK(clk), .RN(rst), .Q(
        count[29]) );
  DFFR_X1 ACCUM_REG_out_reg_30_ ( .D(next[30]), .CK(clk), .RN(rst), .Q(
        count[30]), .QN(n88) );
  DFFR_X2 ACCUM_REG_out_reg_31_ ( .D(n94), .CK(clk), .RN(rst), .Q(n95), .QN(
        n94) );
  NOR3_X4 U76 ( .A1(n82), .A2(n55), .A3(n76), .ZN(n57) );
  NAND3_X4 U77 ( .A1(count[29]), .A2(n95), .A3(n89), .ZN(n55) );
  NAND2_X2 U78 ( .A1(n53), .A2(count[2]), .ZN(n64) );
  BUF_X4 U79 ( .A(n57), .Z(n92) );
  NOR2_X2 U80 ( .A1(n81), .A2(n64), .ZN(n74) );
  NOR2_X2 U81 ( .A1(n90), .A2(n75), .ZN(n65) );
  NAND3_X4 U82 ( .A1(count[13]), .A2(n70), .A3(count[14]), .ZN(n72) );
  NAND3_X2 U83 ( .A1(count[21]), .A2(n61), .A3(count[22]), .ZN(n63) );
  NAND3_X4 U84 ( .A1(n57), .A2(count[25]), .A3(count[26]), .ZN(n59) );
  INV_X4 U85 ( .A(n94), .ZN(count[31]) );
  AND3_X4 U86 ( .A1(n51), .A2(count[4]), .A3(count[3]), .ZN(n87) );
  AND3_X4 U87 ( .A1(n49), .A2(count[6]), .A3(count[5]), .ZN(n51) );
  INV_X4 U88 ( .A(n88), .ZN(n89) );
  BUF_X32 U89 ( .A(n63), .Z(n90) );
  AND3_X4 U90 ( .A1(n47), .A2(count[8]), .A3(count[7]), .ZN(n91) );
  XNOR2_X1 U91 ( .A(count[29]), .B(n54), .ZN(next[29]) );
  NAND2_X1 U92 ( .A1(count[22]), .A2(n61), .ZN(n62) );
  XOR2_X1 U93 ( .A(count[22]), .B(n61), .Z(next[22]) );
  XOR2_X1 U94 ( .A(count[18]), .B(n66), .Z(next[18]) );
  XOR2_X1 U95 ( .A(n77), .B(n59), .Z(next[24]) );
  XOR2_X1 U96 ( .A(n76), .B(n55), .Z(next[28]) );
  NAND2_X1 U97 ( .A1(count[18]), .A2(n66), .ZN(n67) );
  NOR2_X1 U98 ( .A1(n59), .A2(n77), .ZN(n60) );
  NOR2_X1 U99 ( .A1(n55), .A2(n76), .ZN(n56) );
  XOR2_X1 U100 ( .A(n78), .B(n68), .Z(next[16]) );
  NOR2_X1 U101 ( .A1(n68), .A2(n78), .ZN(n69) );
  NAND3_X2 U102 ( .A1(count[17]), .A2(n66), .A3(count[18]), .ZN(n68) );
  XOR2_X1 U103 ( .A(n81), .B(n64), .Z(next[1]) );
  NOR2_X1 U104 ( .A1(n72), .A2(n79), .ZN(n73) );
  XOR2_X1 U105 ( .A(n79), .B(n72), .Z(next[12]) );
  XOR2_X1 U106 ( .A(count[10]), .B(n46), .Z(next[10]) );
  XOR2_X1 U107 ( .A(count[26]), .B(n92), .Z(next[26]) );
  XOR2_X1 U108 ( .A(count[14]), .B(n70), .Z(next[14]) );
  NAND2_X1 U109 ( .A1(count[10]), .A2(n46), .ZN(n45) );
  XOR2_X1 U110 ( .A(count[31]), .B(n89), .Z(next[30]) );
  NAND2_X1 U111 ( .A1(count[14]), .A2(n70), .ZN(n71) );
  NAND2_X1 U112 ( .A1(count[26]), .A2(n92), .ZN(n58) );
  NAND2_X1 U113 ( .A1(count[30]), .A2(n95), .ZN(n54) );
  AND3_X4 U114 ( .A1(count[10]), .A2(n46), .A3(count[9]), .ZN(n47) );
endmodule

