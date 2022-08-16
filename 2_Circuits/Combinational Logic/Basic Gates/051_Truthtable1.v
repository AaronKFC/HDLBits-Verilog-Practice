module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    wire [2:0] tmp;
    assign tmp = {x3,x2,x1};
    always @(*) begin
        case(tmp)
            2,3,5,7: begin
                f = 1;
            end
            0,1,4,6: begin
                f = 0;
            end
        endcase
    end


// 題目真的要的解法：
    module top_module (
        input x3,
        input x2,
        input x1,
        output f
    );
        // This truth table has four minterms. 
        assign f = ( ~x3 & x2 & ~x1 ) | 
                    ( ~x3 & x2 & x1 ) |
                    ( x3 & ~x2 & x1 ) |
                    ( x3 & x2 & x1 ) ;
                    
        // It can be simplified, by boolean algebra or Karnaugh maps.
        // assign f = (~x3 & x2) | (x3 & x1);
        
        // You may then notice that this is actually a 2-to-1 mux, selected by x3:
        // assign f = x3 ? x1 : x2;
        
    endmodule


endmodule
