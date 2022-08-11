// Solution1
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~(a ^ b);
endmodule


module top_module( 
    input a, 
    input b, 
    output out );
    xnor xno1(out, a, b);  //注意：與「 xor xo1(~out, a, b); 」 不等價。
endmodule
