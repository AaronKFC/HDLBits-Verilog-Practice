module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); //

    // 題目 (即wrong code)
    wire mux0, mux1;
    mux2 mux0 ( sel[0],    a,    b, mux0 );
    mux2 mux1 ( sel[1],    c,    d, mux1 );
    mux2 mux2 ( sel[1], mux0, mux1,  out );

    // Solution
    wire [7:0] out0, out1;                     // error1 vector長度不對
                                               // error2 wire宣告名稱與module宣告名稱一樣。
    mux2 mux0 ( sel[0],    a,    b, out0 );    
    mux2 mux1 ( sel[0],    c,    d, out1 );    // error3 判斷bit的位置錯誤
    mux2 mux2 ( sel[1], out0, out1,  out );

endmodule
