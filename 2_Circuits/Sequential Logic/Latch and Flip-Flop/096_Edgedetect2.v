// Solution1
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] d_last;
    always @(posedge clk) begin
        d_last <= in;
        anyedge <= in ^ d_last;
    end
    
endmodule


// Solution2
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    
    integer i;
    reg [7:0] in_tmp;
    always @(posedge clk) begin
        for(i = 0; i < 8; i = i + 1) begin
            if(in_tmp[i] != in[i]) begin
                anyedge[i] = 1;
            end
            else begin
                anyedge[i] = 0;
            end
            in_tmp[i] = in[i];
        end
    end

endmodule
