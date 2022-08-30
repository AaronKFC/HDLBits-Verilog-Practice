// Solution1 (My implementation)
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	
    wire q_tmp;
    assign q_tmp = LEDR[1] ^ LEDR[2];
    muxdff md1(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[0]), .q_in(LEDR[2]), .Q(LEDR[0]));
    muxdff md2(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[1]), .q_in(LEDR[0]), .Q(LEDR[1]));
    muxdff md3(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[2]), .q_in(q_tmp), .Q(LEDR[2]));
endmodule

module muxdff(
	input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q);
    
    always @(posedge clk) begin
        Q <= L ? r_in : q_in;
    end
endmodule

////////////////////////////////////////////////////
// Solution2
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output reg [2:0] LEDR);  // Q

    wire clk = KEY[0];
    wire l = KEY[1];
    wire [2:0] d = l ? SW : {LEDR[1]^LEDR[2],LEDR[0],LEDR[2]};
    
    always @(posedge clk)begin
            LEDR <=	d;
    end

endmodule


///////////////////////////////////////////////////
// Solution3
module top_module (
    input [2:0] SW,      // R
    input [1:0] KEY,     // L and clk
    output [2:0] LEDR);  // Q
    
    wire clk, L;
    wire [2:0] R;
    reg [2:0] Q;
    assign clk = KEY[0];
    assign L = KEY[1];
    assign R = SW;

    always @(posedge clk) begin
        Q <= {(L) ? R[2] : (Q[1] ^ Q[2]), (L) ? R[1] : Q[0], (L) ? R[0] : Q[2]};
    end
    
    assign LEDR = Q;

endmodule
