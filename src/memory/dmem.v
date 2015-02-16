module dmem(addr, wData, writeEnable, dsize, dsign, clk, rData_out, error_flag);
    parameter SIZE=32768;

    input [0:31] addr, wData;
    input writeEnable, clk;
    input [0:1] dsize; // equivalent to bytes-1 ( 3=Word, 1=Halfword, 0=Byte)
    input dsign; //0 = unsigned load, 1 = signed load
    output [0:31] rData_out;
    output error_flag;

    reg [0:7] mem[0:(SIZE-1)]; //array of regs (use this syntax for reg file)


    reg [0:31] rData;
    reg flag;


    assign rData_out = rData;
    assign error_flag = flag;

    
    always @ (posedge clk) begin
        if (writeEnable) begin
            $display("writing to mem at %x val %x size %2d", addr, wData, dsize);
            case (dsize)
              2'b11: begin // word
                 if (addr[30:31] != 2'b00) begin //check alignment
	 	    $display("Misaligned word access @: %x", addr); 
                    flag <= 1'b1;
                 end
		 else begin
                    //Big Endian: MSB => highest address
                    {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]} <= wData[0:31];
                    flag <= 1'b0;
                 end
	      end
              2'b10: begin //invalid size
                 $display("Invalid dsize: %x", dsize);
                 flag <= 1'b1;
              end
              2'b01: begin // halfword
		 if (addr[31] != 1'b0) begin  //check alignment
                    $display("Misaligned word access @: %x", addr);
                    flag <= 1'b1;
                 end
                 else begin
                    {mem[addr+1], mem[addr]} <= wData[16:31];
                    flag <= 1'b0;
                 end
              end
              2'b00: begin // byte
                 mem[addr] <= wData[24:31];
                 flag <= 1'b0;
              end
              default: begin
              $display("Invalid dsize: %x", dsize);
              flag <= 1'b1;
              end
            endcase
        end
    end


    // Read
    //FIXME:  Will this always statement ensure async reads from memory???
    always @ (addr or dsize or dsign or writeEnable or wData) begin
            case (dsize)
              2'b11: begin // word
                 if (addr[30:31] != 2'b00) begin //check alignment
                    $display("Misaligned word access @: %x", addr);
                    flag <= 1'b1;
                    rData <= 32'b0;
                 end
                 else begin
                    //Big Endian: highest address => MSB
                    rData <= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
                    flag <= 1'b0;
                 end
              end
              2'b10: begin //invalid size
                 $display("Invalid dsize: %x", dsize);
                 flag <= 1'b1;
                 rData <= 32'b0;
              end
              2'b01: begin // halfword
                 if (addr[31] != 1'b0) begin //check alignment
                    $display("Misaligned half word access @: %x", addr);
                    flag <= 1'b1;
                    rData <= 32'b0;
                 end
                 else begin
                    if (dsign == 1) begin
                       rData <= {{16{mem[addr+1][0]}}, mem[addr+1], mem[addr]};
                    end else 
                    begin
                       rData <= {{16{1'b0}}, mem[addr+1], mem[addr]};
                    end
                    flag <= 1'b0;
                 end
              end
              2'b00: begin // byte
                   if (dsign == 1) begin
                      rData <= {{24{mem[addr][0]}}, mem[addr]};
                   end else
                   begin 
                      rData <= {{24{1'b0}}, mem[addr]};
                   end
                   flag <= 1'b0;
              end
              default: begin
               $display("Invalid dsize: %x", dsize);
               flag <= 1'b1; 
               rData <= 32'b0;
               end  
          endcase
    end
endmodule // dmem
