module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    always @(posedge clk) begin
        if(!j) begin
            Q <= k ? j : Q;
        end
        else begin
            Q <= k ? ~Q : j;
        end
    end

endmodule



// Solution2
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    always@(posedge clk)begin
        case({j, k})
            2'b00:begin
                Q <= Q;
            end
            2'b01:begin
                Q <= 1'b0;
            end
            2'b10:begin
                Q <= 1'b1;
            end
            2'b11:begin
                Q <= ~Q;
            end
        endcase
    end
 
endmodule


