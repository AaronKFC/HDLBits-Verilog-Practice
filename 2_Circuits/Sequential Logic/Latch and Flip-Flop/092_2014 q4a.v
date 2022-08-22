module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    //Solution1 (My implementation)
    always @(posedge clk) begin
        Q <= (L) ? R : (E) ? w : Q;
    end

    //Solution2 
    reg tmp;
    //not use <=
    always @(posedge clk) begin
        tmp = E ? w : Q;
        Q = L ? R : tmp;
    end

endmodule
