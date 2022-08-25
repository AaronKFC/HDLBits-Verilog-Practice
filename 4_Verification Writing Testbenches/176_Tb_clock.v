
// Solution1
module top_module ( );
    parameter time_period = 10;
    reg clock;
    initial begin
        clock = 0;
    end
    always begin
        #(time_period / 2) clock = ~clock;
    end
    dut dut1(clock);
endmodule


// Solution2
module top_module ();
    reg clk;
    dut dut1(clk);
    initial clk = 0;
    always #5 clk=~clk;
endmodule
