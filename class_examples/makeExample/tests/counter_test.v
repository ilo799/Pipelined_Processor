module testbench ();
    reg clk, rst;
    wire [0:3] count;

    counter #(.WIDTH(4)) COUNTER (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    initial begin
        $monitor("%d\trst=%b count=%x clk=%b", $time, rst, count, clk);
        // rst is active-low
        #0 rst=0; clk=0;
        #2 rst=1;
    end // initial

    always begin
        #1 clk = !clk;
    end // always
    initial begin
        #100 $finish;
    end
endmodule
