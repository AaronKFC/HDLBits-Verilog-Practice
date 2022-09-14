module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

    always @(posedge clk or posedge ar) begin  
        if(ar) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
    
endmodule

// 这是个异步高电平复位，大家注意，异步信号在always中连接可以用or或者逗号（,），通常大家习惯使用or。