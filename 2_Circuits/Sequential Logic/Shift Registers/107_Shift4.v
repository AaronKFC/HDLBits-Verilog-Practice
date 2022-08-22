module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    // Asynchronous reset: Notice the sensitivity list.
	// The shift register has four modes:
	//   reset
	//   load
	//   enable shift
	//   idle -- preserve q (i.e., DFFs)

    // Solution1 (HDLBits)
	always @(posedge clk, posedge areset) begin
		if(areset) q <= 0;
        else if(load) q <= data;
        
        // ena的部分有三種參考寫法，如下：
		else if(ena) q <= q[3:1];	// 寫法一：Use vector part select to express a shift.
        else if(ena) q <= q >> 1;   // 寫法二
        else if(ena) q <= {1'b0, q[3:1]};  // 寫法三
            
	end


    
    // Solution2
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            q <= 0;
        end
        else begin
            if(load == 1) begin
                q <= data;  
            end
            else begin
                if(ena == 1) begin
                    /*q[0] = q[1];
                    q[1] = q[2];
                    q[2] = q[3];
                    q[3] = 0;*/
                    q = q >> 1;
                end
            end
        end
    end
    
endmodule
