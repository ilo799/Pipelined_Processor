module test16bit;
    reg clk, regwe, reset;
    reg [0:5] Rw, Ra, Rb;
    reg [0:31] Din;
    wire [0:31] regout1, regout2; 

    regfile64by32bit test(clk, regwe, reset, Rw, Ra, Rb, Din, regout1, regout2);

    initial begin
#100
#20     clk=0; regwe=1; reset=1; Rw=6'b00000; Ra=6'b00000; Rb=6'b00000; Din=32'h00000000;
#20     clk=1;
#20     clk=0; regwe=1; reset=0; Rw=6'b00001; Ra=6'b00001; Rb=6'b00000; Din=32'hDEADBEEF;
#20     clk=1;
#20     clk=0; regwe=0; reset=0; Rw=6'b00001; Ra=6'b00010; Rb=6'b00001; Din=32'hBAADBEEF;
#20     clk=1;
#20     clk=0; regwe=1; reset=0; Rw=6'b00001; Ra=6'b00010; Rb=6'b00001; Din=32'hBAADBEEF;
#20     clk=1;
#20     clk=0; regwe=1; reset=0; Rw=6'b00010; Ra=6'b00010; Rb=6'b00001; Din=32'hDEADBEEF;
#20     clk=1;
    end

    initial begin
        $monitor("clk=%b regwe=%b rst=%b Rw=%b Ra=%b Rb=%b Din=%h regout1=%h regout2=%h",clk,regwe,reset,Rw,Ra,Rb,Din,regout1,regout2);
    end
endmodule
