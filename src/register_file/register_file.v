`timescale 1ns / 1ns

module regfile64by32bit(clk, regwe, reset, Rw, Ra, Rb, Din, regout1, regout2);
    input clk, regwe, reset;
    input [0:5] Rw, Ra, Rb;
    input [0:31] Din;
    output [0:31] regout1, regout2;

    reg [0:31]  regfile [0:63];

    assign regout1 = regfile[Ra];
    assign regout2 = regfile[Rb];

    integer i;
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            for (i=0; i<63; i=i+1) begin
                regfile[i] <= 0;
            end
        end else begin
            if (regwe) regfile[Rw] <= Din;
        end
    end
endmodule
