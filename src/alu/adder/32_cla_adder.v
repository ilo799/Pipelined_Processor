`timescale 1ns / 1ps

module CLA4bit(inA, inB, sum, carryIn, carryOut, pg, gg);
    input [0:3] inA;
    input [0:3] inB;
    input carryIn;
    output [0:3] sum;
    output carryOut;
    output pg;
    output gg;

    wire [0:3] g;
    wire [0:3] p;
    wire [0:3] c;

    assign g = inA & inB;
    assign p = inA ^ inB;
    assign c[3] = carryIn;
    assign c[2] = g[3] | (p[3] & c[3]);
    assign c[1] = g[2] | (p[2] & g[3]) | (p[2] & p[3] & c[3]);
    assign c[0] = g[1] | (p[1] & g[2]) | (p[1] & p[2] & g[3]) | (p[1] & p[2] & p[3] & c[3]);
    assign carryOut = g[0] | (p[0] & g[1]) | (p[0] & p[1] & g[2]) | (p[0] & p[1] & p[2] & g[3]) | (p[0] & p[1] & p[2] & p[3] & c[3]);
    assign sum = p ^ c;

    assign pg = p[0] & p[1] & p[2] & p[3];
    assign gg = g[0] | (p[0] & g[1]) | (p[0] & p[1] & g[2]) | (p[0] & p[1] & p[2] & g[3]);
endmodule

module LCU16bit(inA, inB, sum, c0, pg, gg, c16);
    input [0:15] inA, inB;
    output [0:15] sum;
    output pg, gg, c16;
    
    input c0;
    wire p0, g0, p4, g4, c4, p8, g8, c8, p12, g12, c12;

    wire junk0, junk1, junk2, junk3;
    
    assign c4 = g0 | (p0 & c0);
    assign c8 = g4 | (g0 & p4) | (c0 & p0 & p4);
    assign c12 = g8 | (g4 & p8) | (g0 & p4 & p8) | (c0 & p0 & p4 & p8);
    assign c16 = g12 | (g8 & p12) | (g4 & p8 & p12) | (g0 & p4 & p8 & p12) | (c0 & p0 & p4 & p8 & p12);

    CLA4bit CLA4bit1(inA[12:15], inB[12:15], sum[12:15], c0, junk0, p0, g0);
    CLA4bit CLA4bit2(inA[8:11], inB[8:11], sum[8:11], c4, junk1, p4, g4);
    CLA4bit CLA4bit3(inA[4:7], inB[4:7], sum[4:7], c8, junk2, p8, g8);
    CLA4bit CLA4bit4(inA[0:3], inB[0:3], sum[0:3], c12, junk3, p12, g12);

    assign pg = p0 & p4 & p8 & p12;
    assign gg = c16;
endmodule

module LCU32bit(inA, inB, sum, c0, pg, gg, c32);
    input [0:31] inA, inB;
    output [0:31] sum;
    input c0;
    output pg, gg, c32;

    wire p0, g0, p16, g16;
    wire junk0, junk1;

    assign c16 = g0 | (p0 & c0);
    assign c32 = g16 | (g0 & p16) | (c0 & p0 & g16);
    
    LCU16bit LCU16bit1(inA[16:31], inB[16:31], sum[16:31], c0, p0, g0, junk0);
    LCU16bit LCU16bit2(inA[0:15], inB[0:15], sum[0:15], c16, p16, g16, junk1);

    assign pg = p0 & p16;
    assign gg = c32;
endmodule
