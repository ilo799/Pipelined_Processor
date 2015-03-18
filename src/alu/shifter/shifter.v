//32 bit general purpose shifter
//Copyright: Northwestern EECS 362 Team Senioritis 

//Direction:
// 0: Left 1: Right
//Type:
// 0: Logical 1: Arithmetic

module Shifter (F,A,Shift,Direction,Type);
  input [31: 0] A;
  input  [4:0] Shift;
  input Direction; 
  input Type;
  output [31: 0] F;

  //Intermediate wires many 1-bit wire
  wire Wires[127:0];
  wire MSB;
  wire [4:0] Shamt;
  wire Dir; 
  
  MUX2_n #(1) MUX0(MSB, 1'b0,  A[31], Type);

  //Use the inverse of Shift and or Direction
  NOT_n #(5) NOT_5(Shamt, Shift);
  not(Dir, Direction);  

  genvar l, i;

  //5 levels of 32-bits... see ppt for a diagram.
  generate
  for (l = 0; l < 5; l=l+1) 
  begin : Level_l
    for (i=0; i<32; i=i+1)
    begin : Bit_i
      //Top Level Input
      if (l == 0) begin 
        //LSB
        if (i == 0) begin 
          MUX3_n #(1) MUX1(Wires[i],  A[i+1], 1'b0, A[i], {Shamt[l], Dir});
        end
        //MSB
        else if (i == 31) begin 
          MUX3_n #(1) MUX2(Wires[i], MSB, A[i-1], A[i], {Shamt[l], Dir});
        end
        //Intermediate Bits
        else begin 
          MUX3_n #(1) MUX3(Wires[i], A[i+1], A[i-1], A[i], {Shamt[l], Dir});
        end
    end
    //Bottom Level Output
      else if (l == 4) begin
        //LSM
        if (i < 2**l) begin 
          MUX3_n #(1) MUX4(F[i], Wires[(l-1)*32+i+2**l], 1'b0, Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
        //MSB
        else if (i >= 32-2**l) begin 
          MUX3_n #(1) MUX5(F[i], MSB, Wires[(l-1)*32+i-2**l], Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
        //Intermediate Bits
        else begin 
          MUX3_n #(1) MUX6(F[i], Wires[(l-1)*32+i+2**l], Wires[(l-1)*32+i-2**l], Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
      //Intermediate levels
      end
      else begin
        //LSM
        if (i < 2**l) begin 
          MUX3_n #(1) MUX7(Wires[l*32+i],  Wires[(l-1)*32+i+2**l], 1'b0, Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
        //MSB
        else if (i >= 32 - 2**l) begin 
          MUX3_n #(1) MUX8(Wires[l*32+i], MSB, Wires[(l-1)*32+i-2**l], Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
        //Intermediate Bits
        else begin 
          MUX3_n #(1) MUX9(Wires[l*32+i],  Wires[(l-1)*32+i+2**l], Wires[(l-1)*32+i-2**l], Wires[(l-1)*32+i], {Shamt[l], Dir});
        end
      end
    end
  end
  endgenerate
endmodule  


