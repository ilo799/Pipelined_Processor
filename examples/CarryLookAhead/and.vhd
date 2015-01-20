// and2.v
//2 input and gate 

module and2(x, y, z);
input x,y;
output z;

always@(x or y)
begin
  z <= x & y;
end

endmodule

 
