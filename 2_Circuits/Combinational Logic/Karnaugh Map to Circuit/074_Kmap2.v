module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    // My Solution
    assign out = (~b & ~c) | (~a & ~d) | (c & d & (a |(~a&b)));

    // HDLBits

    assign out = (~a&~b&~c) | (~a&~c&~d) | (a&~b&~c) | (b&c&d) | (a&c&d) | (~a&b&c) | (~a&c&~d);

endmodule
