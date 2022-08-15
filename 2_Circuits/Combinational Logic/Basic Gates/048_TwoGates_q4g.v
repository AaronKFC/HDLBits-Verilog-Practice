module top_module (
    input in1,
    input in2,
    input in3,
    output out);

    // 寫法一
    assign out = (~(in1 ^ in2)) ^ in3;

    // 寫法二
    wire w1;
    assign w1 = ~(in1 ^ in2);
    assign out = w1^in3;
    
endmodule
