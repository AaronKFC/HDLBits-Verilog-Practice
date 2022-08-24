
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
module top_module ( );
	parameter time_period = 10;
    reg clock;
    initial clock=0;
    always #(time_period/2) clock=~clock;
    dut dut1(clock);
endmodule
