// Solution1
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~(a | b);
endmodule

// Solution2
module top_module( 
    input a, 
    input b, 
    output out );
    nor no1(out,a,b);   // 注意：與 「 or o1(~out,a,b); 」不等價
endmodule

