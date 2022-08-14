// Solution1
module top_module( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = a ^ b ^ cin;
    assign cout = a & b | a & cin | b & cin;

endmodule



// Solution2
module top_module( 
    input a, b, cin,
    output cout, sum );
    
    assign {cout, sum} = a + b + cin;

endmodule