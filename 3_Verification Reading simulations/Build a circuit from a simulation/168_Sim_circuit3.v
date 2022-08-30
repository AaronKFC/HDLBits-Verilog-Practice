module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    // Solution1 (畫出K-map)
    assign q = (b&d) | (a&d) | (c&b) | (c&a);
    
    // Solution2
    assign q = (a || b) && (c || d); // Fix me

endmodule
