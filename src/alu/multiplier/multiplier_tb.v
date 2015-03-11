module Testbench;

  wire [0:31] R;
  wire Ready;

  reg clk, Start, Signed;
  reg [0:31] A, B;

  Multiplier mult(
    .R(R), .Ready(Ready), 
    .clk(clk), .Start(Start), .Signed(Signed),
    .A(A), .B(B)
  );

  initial
  begin
    $dumpfile("mult.vcd");
    $dumpvars;
    $display("\tA\t\tB\tStart\tSigned\t\tR\t\tReady");
    $monitor("%d\t%d\t%d\t%d\t%d\t%d", A, B, Start, Signed, R, Ready);
    
    clk <= 0;
    Signed <= 0;
    Start <= 1;

    // 3 * 5 = 15
    A <= 32'h3;
    B <= 32'h5;

    #5 Start <= 0;

    // 7 * 9 = 63
    wait (Ready == 1) #5 A <= 32'h7;
    B <= 32'h9;
    Start <= 1;

    #5 Start <= 0;

    // -4 * 8 = -32
    wait (Ready == 1) #5 Signed <= 1;
    A <= -4;
    B <= 8;
    Start <= 1;

    #5 Start <= 0;

    // 5 * -2 = -10
    wait (Ready == 1) #5 Signed <= 1;
    A <= 5;
    B <= -2;
    Start <= 1;

    #5 Start <= 0;

    // -15 * -12 = 180
    wait (Ready == 1) #5 Signed <= 1;
    A <= -15;
    B <= -12;
    Start <= 1;

    #5 Start <= 0;

    #5 wait (Ready == 1) #5 $finish;
  end

  always
  begin
    #5 clk <= !clk;
  end

endmodule
