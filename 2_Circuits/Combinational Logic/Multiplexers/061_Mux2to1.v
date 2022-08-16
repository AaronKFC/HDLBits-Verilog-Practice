module top_module( 
    input a, b, sel,
    output out ); 

    // 寫法一
    assign out = sel ? b : a;
    
    // 寫法二
    assign out = (sel & b) | (~sel & a);	// Mux expressed as AND and OR

    // 寫法三
    always @(*) begin
        if(sel)
            out = b;
        else
            out = a;
    end

endmodule
