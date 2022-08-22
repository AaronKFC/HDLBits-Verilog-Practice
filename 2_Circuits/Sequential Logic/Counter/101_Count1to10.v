module top_module (
    input clk,
    input reset,
    output [3:0] q);

    // Solution1 (My implementation)
    always @(posedge clk) begin
        if(reset || q==10)
            q <= 1;
        else
            q += 1;
    end


    // Solution2
    always @(posedge clk) begin
        if(reset) begin
            q <= 1;
        end
        else begin
            if(q == 10) begin
                q <= 1;
            end
            else begin
                q <= q + 1;
            end
        end
    end
    
endmodule
