
// Solution1 
module top_module();
    reg [1:0] in;
    reg out;
    initial begin
        in = 2'b0;
        #10 in = 2'b01;
        #10 in = 2'b10;
        #10 in = 2'b11;
    end
    andgate gate1(in, out);
endmodule


// Solution2
module top_module();
	
    reg [1:0] in;   //註：in不能用wire宣告
    initial begin
        in[1]=0;
        in[0]=0;
        #10 in[0]=1;
        #10 in[1]=1;
            in[0]=0;
        #10 in[0]=1;
    end
    
    reg out;
    andgate ag(in, out);
    
endmodule

