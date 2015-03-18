module Multiplier (
  // Out
  R, Ready,

  // In
  clk, Start, A, B, Signed
);

  output [0:31] R;
  output Ready;

  input [0:31] A, B;
  input clk, Signed, Start;

  reg [0:63] product_reg;
  reg [0:15] counter;

  wire [0:63] reg_init, shift_in, product_shifted, next_product_reg;
  wire [0:31] multiplicand_plus_prod, product_shifted_top, product_shifted_bottom;
  wire [0:31] abs_a, abs_b, multiplier, multiplicand, product, twos_product;

  wire [0:15] next_counter, counter_plus_one;

  // Abs value
  Abs abs_a_gate(abs_a, A);
  Abs abs_b_gate(abs_b, B);

  MUX2_n #(32) multiplier_mux(multiplier, B, abs_b, Signed);
  MUX2_n #(32) multiplicand_mux(multiplicand, A, abs_a, Signed);

  // Multilicand Adder
  LCU32bit adder(
    .inA(multiplicand),
    .inB(product_reg[0:31]),
    .sum(multiplicand_plus_prod),
    .c0(0)
  );

  // Counter
  LCU16bit counter_adder(
    .inA(counter),
    .inB(16'h1),
    .sum(counter_plus_one),
    .c0(0)
  );
  MUX2_n #(16) next_counter_mux(next_counter, counter_plus_one, 16'h0, Start);

  // Makeshift 64-bit shifter
  MUX2_n #(64) shift_in_mux(shift_in, product_reg, {multiplicand_plus_prod, product_reg[32:63]}, product_reg[63]);
  Shifter top_shifter(
    .F(product_shifted_top),
    .A(shift_in[0:31]),
    .Shift(5'h1),
    .Direction(1),
    .Type(0)
  );

  Shifter bottom_shifter(
    .F(product_shifted_bottom),
    .A(shift_in[32:63]),
    .Shift(5'h1),
    .Direction(1),
    .Type(0)
  );

  assign product_shifted = {product_shifted_top, shift_in[31], product_shifted_bottom[1:31]};

  MUX2_n #(64) next_product_mux(next_product_reg, product_shifted, reg_init, Start);

  // 0's for top half, multiplier for bottom half
  assign reg_init = {32'b0, multiplier};

  // Outputs
  EQ2_n #(16) ready_gate(Ready, counter, 16'd32);
  assign product = product_reg[32:63];
  TwosComplement twos_product_gate(twos_product, product);

  // S   A[0] B[0] | Neg?
  // ------------------
  // 0   X    X    | 0 
  // 1   0    0    | 0
  // 1   0    1    | 1
  // 1   1    0    | 1
  // 1   1    1    | 0
  // Neg = S & (A[0] ^ B[0])
  wire a_xor_b, should_negate;
  XOR2_n #(1) a_xor_b_gate(a_xor_b, A[0], B[0]);
  AND2_n #(1)  should_negate_gate(should_negate, Signed, a_xor_b);
  MUX2_n #(32) r_mux(R, product, twos_product, should_negate);

  always @(posedge clk) begin
    product_reg <= next_product_reg;
    counter <= next_counter;
  end

endmodule
