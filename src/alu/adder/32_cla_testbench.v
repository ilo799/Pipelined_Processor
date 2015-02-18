/*
module test4bit;

    reg [0:3] inA, inB;
    reg cin;
    wire [0:3] sum;
    wire cout, pg, gg;

    CLA4bit testLCA4bit(inA, inB, sum, cin, cout, pg, gg);

    initial begin
        inA = 0;
        inB = 0;
        cin = 0;
        #100;

        inA=4'b0001;inB=4'b0000;cin=1'b0;
    #20 inA=4'b0100;inB=4'b0011;cin=1'b0;
    #20 inA=4'b1101;inB=4'b1010;cin=1'b1;
    #20 inA=4'b1010;inB=4'b1100;cin=1'b1;
    #20 inA=4'b1111;inB=4'b1100;cin=1'b0;
    end 

    initial begin
        $monitor("A=%b B=%b Cin=%b : Sum=%b cout=%b pg=%b gg=%b",inA, inB, cin, sum, cout, pg, gg);
    end
endmodule
*/

/*
module test16bit;
    reg [0:15] inA, inB;
    reg cin;
    wire [0:15] sum;
    wire cout, pg, gg;

    LCU16bit testLCU16bit(inA, inB, sum, cin, pg, gg, cout);

    initial begin
        inA = 0;
        inB = 0;
        cin = 0;
        #100

        inA=16'h0001; inB=16'h0000; cin=1'b0;
#50     inA=16'h0011; inB=16'h0033; cin=1'b0;
#50     inA=16'hFFFF; inB=16'hFFFF; cin=1'b1;
#50     inA=16'hAAAA; inB=16'hEEEE; cin=1'b0;
#50     inA=16'hDEAD; inB=16'hBEEF; cin=1'b0;
    end

    initial begin
        $monitor("A=%b B=%b Cin=%b : Sum=%b cout=%b pg=%b gg=%b",inA, inB, cin, sum, cout, pg, gg);
    end
endmodule
*/

module test16bit;
    reg [0:31] inA, inB;
    reg cin;
    wire [0:31] sum;
    wire cout, pg, gg;

    LCU32bit testLCU32bit(inA, inB, sum, cin, pg, gg, cout);

    initial begin
        inA = 0;
        inB = 0;
        cin = 0;
        #100

        inA=32'h00000001; inB=32'h00000000; cin=1'b0;
#50     inA=32'hDEADBEEF; inB=32'hBAADBEEF; cin=1'b0;
#50     inA=32'hFFFFFFFF; inB=32'hFFFFFFFF; cin=1'b1;
#50     inA=32'hAAAAAAAA; inB=32'hEEEEEEEE; cin=1'b0;
#50     inA=32'hDEFA1078; inB=32'h78548294; cin=1'b0;
    end

    initial begin
        $monitor("A=%b B=%b Cin=%b : Sum=%b cout=%b pg=%b gg=%b",inA, inB, cin, sum, cout, pg, gg);
    end
endmodule
