module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    // Solution1
    reg [2:0] sum;
    assign sum = a + b + c + d;
    assign q = (sum == 1 || sum == 3) ? 0 : 1; // Fix me

    // Solution2
    assign q = ~a & ~b & ~c & ~d | ~a & ~b & c & d | ~a & b & ~c & d | ~a & b & c & ~d | 
       	 	   a & b & ~c & ~d | a & b & c & d | a & ~b & ~c & d | a & ~b & c & ~d;

endmodule
