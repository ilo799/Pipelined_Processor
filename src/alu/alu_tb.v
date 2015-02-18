module Testbench;
  reg [0:31] A, B;
  reg [0:2] ALUOp;
  reg [0:1] ALUCruft;
  wire [0:31] R;

  ALU alu(R, A, B, ALUOp, ALUCruft);

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars;
    $display("A\t\tB\t\tOp\tCruft\tR");
    $monitor("%h\t%h\t%h\t%h\t%h", A, B, ALUOp, ALUCruft, R);

    A = 1;
    B = 2;
    ALUOp = 3'b000;
    ALUCruft = 3'b00;

    #5

    // AND
    A = 9;
    B = 7;
    ALUOp = 3'b001;

    #5

    // OR
    ALUOp = 3'b010;

    #5

    // XOR
    ALUOp = 3'b011;

    #5

    // ADD
    ALUOp = 3'b100;

    #5

    // SUB
    ALUCruft = 3'b10;

    #5

    // SEQ
    ALUCruft = 3'b10;
    ALUOp = 3'b101;

    #5

    // SEQ
    A = 7;

    #5

    // SNE
    ALUCruft = 3'b00;

    #5

    // SNE
    A = 9;

    #5

    // SLT
    ALUOp = 3'b110;
    ALUCruft = 2'b10;

    #5

    // SGE
    ALUCruft = 2'b00;

    #5

    // SGT
    ALUOp = 3'b111;
    ALUCruft = 2'b10;

    #5

    // SLE
    ALUCruft = 2'b00;

  end
endmodule
