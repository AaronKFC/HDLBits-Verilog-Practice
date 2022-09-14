
// Solution1
module top_module (
    input clk,
    input x,
    output z
); 
    reg [2:0] Q;
    initial z = 1;
    always @(posedge clk) begin
        Q[0] = Q[0] ^ x;
        Q[1] = ~Q[1] & x;
        Q[2] = ~Q[2] | x;
        z = ~(Q[0] | Q[1] | Q[2]); 
    end

endmodule


// Solution2 (My implementation) 注意此題的always block裡，要用blocking，不能用non-blocking
module top_module (
    input clk,
    input x,
    output z
); 
	wire q1, q2, q3;  //因為q不是output，所以宣告成wire亦可
    initial z=1;
    always @(posedge clk) begin
        // z=1; // wrong
        q1 = x ^ q1;
        q2 = x & ~q2;
        q3 = x | ~q3;
        //z = ~(q1 | q2 | q3);
    end
    
    assign z = ~(q1 | q2 | q3);  //寫在這裡也可以

endmodule


// Solution3 (My implementation2)
module top_module (
    input clk,
    input x,
    output z
); 
    
    reg [2:0] Q;
    always @(posedge clk) begin
        Q[0] <= Q[0] ^ x;
        Q[1] <= ~Q[1] & x;
        Q[2] <= ~Q[2] | x;
    end
    
    assign z = ~(| Q);

endmodule
