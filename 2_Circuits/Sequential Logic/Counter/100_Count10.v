// Solution1 (HDLBits)
module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk)
		if (reset || q == 9)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
			q <= 0;
		else
			q <= q+1;
	
endmodule



// Solution2 
module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if(reset) begin
            q <= 0;
        end
        else begin
            if(q == 9) begin
                q <= 0;
            end
            else begin
                q <= q + 1;
            end
        end
    end
    
endmodule
