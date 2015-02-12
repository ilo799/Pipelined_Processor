module testbench();
    reg [0:31] A;
    reg [0:31] B;
    reg cin;
    wire [0:31] Sum;
    wire cout;

    fa_nbit #(.WIDTH(32)) FA32 (
        .A(A),
        .B(B),
        .cin(cin),
        .Sum(Sum),
        .cout(cout)
    );

    initial begin
        $monitor("A=%x B=%x cin=%b Sum=%x cout=%x", A, B, cin, Sum, cout);
        #0 A=32'h00000000; B=32'h00000000; cin=1'b0;
        #1 A=32'h00000000; B=32'h0000F000; cin=1'b0;
        #1 A=32'h0000F000; B=32'h00000000; cin=1'b0;
        #1 A=32'h0000F000; B=32'h0000F000; cin=1'b0;
        #1 A=32'hFFFFFFFE; B=32'h00000001; cin=1'b0;
        #1 A=32'hFFFFFFFD; B=32'h00000001; cin=1'b1;
        #1 A=32'hFFFFFFFF; B=32'h00000001; cin=1'b0;
        #1 A=32'hFFFFFFFF; B=32'h00000000; cin=1'b1;
        #1 A=32'hFFFFFFFE; B=32'h00000001; cin=1'b1;
    end
endmodule
