module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    // Solution1 (Mine)
    assign q = c | ~c&b;

    // Solution2 
    assign q = (b || c); // Fix me

endmodule
