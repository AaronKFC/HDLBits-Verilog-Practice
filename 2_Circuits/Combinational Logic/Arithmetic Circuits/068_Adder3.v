module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    integer i;
    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign cout[0] = a[0] & b[0] | a[0] & cin | b[0] & cin;
    always @(*) begin
        for(i = 1; i < 3; i=i+1) begin
            sum[i] = a[i] ^ b[i] ^ cout[i-1];
            cout[i] = a[i] & b[i] | a[i] & cout[i-1] | b[i] & cout[i-1];
        end
    end

endmodule


////////////////////////////////////////
// Solution2 (My implementation) 
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire sum1, sum2, sum3;
    adder1 inst1(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum1));
    adder1 inst2(.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum2));
    adder1 inst3(.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum3));
    
    assign sum = {sum3, sum2, sum1};

endmodule

module adder1(
	input a,b,cin,
	output cout, sum);
    assign sum = a ^ b ^ cin;
    assign cout = a&b | a&cin | b&cin;
endmodule
