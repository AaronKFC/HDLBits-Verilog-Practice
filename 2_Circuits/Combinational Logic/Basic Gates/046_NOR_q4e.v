module top_module (
    input in1,
    input in2,
    output out);

    // 寫法一
    assign out = ~(in1 | in2);
    // 寫法二
    nor no1(out, in1, in2);
    
endmodule
