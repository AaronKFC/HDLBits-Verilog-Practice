module top_module (
    input d, 
    input ena,
    output q);
    
    // 寫法一
    always @(*) begin
        if(ena) begin
            q = d;
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
