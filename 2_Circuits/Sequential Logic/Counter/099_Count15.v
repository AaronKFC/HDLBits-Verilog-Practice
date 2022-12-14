// Solution1 (HDLBits)
module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= q+1;		// Because q is 4 bits, it rolls over from 15 -> 0.
		// If you want a counter that counts a range different from 0 to (2^n)-1, 
		// then you need to add another rule to reset q to 0 when roll-over should occur.
	
endmodule

// Solution2
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
	
    always @(posedge clk) begin
        if(reset || q==15) q <= 0;
        else q <= q+1;
    end
    
endmodule


// Solution3
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if(reset) begin
            q <= 0;
        end
        else begin
            if(q == 15) begin
                q <= 0;
            end
            else begin
                q <= q + 1;
            end
        end
    end

endmodule
