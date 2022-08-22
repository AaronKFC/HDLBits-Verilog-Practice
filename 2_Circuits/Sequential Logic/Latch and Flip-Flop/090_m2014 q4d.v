module top_module (
    input clk,
    input in, 
    output out);
    
    // 寫法一
    always @(posedge clk) begin
        out <= out ^ in;
    end

    //寫法二 (My implementation)
    wire w1;
    assign w1 = in ^ out;
    always @(posedge clk) begin
        out <= w1;
    end

endmodule
