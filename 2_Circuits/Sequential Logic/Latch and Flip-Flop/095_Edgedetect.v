// Solution1 (HDLBits)
module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;			// Remember the state of the previous cycle
		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
	end
	
endmodule


// Solution2
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    integer i;
    reg [7:0] in_tmp;
    always @(posedge clk) begin
        for(i = 0; i < 8; i = i + 1) begin
            if(in_tmp[i] != in[i] && in[i] == 1) begin
                pedge[i] = 1;
            end
            else begin
                pedge[i] = 0;
            end
            in_tmp[i] = in[i];
        end
    end

endmodule
