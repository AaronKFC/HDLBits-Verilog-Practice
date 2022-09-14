module top_module (
    input d, 
    input ena,
    output q);
    
    // 寫法一
    always @(*) begin
        if(ena) begin
            q = d;
            // q <= d; 如左奕可
        end
    end

    //寫法二
    always @(*) begin
        if(ena)
            q=d;
        else
            q=q;  // 所以像寫法一把這行省略也可以。
    end

endmodule


// 对于组合逻辑，if没有补全else，case条件不完全，
// 可能会产生latch，但是如果中间的信号有初值，那就不会产生latch。
// 所以我们建议组合逻辑尽可能不要产生latch，latch对于时序危害很大。