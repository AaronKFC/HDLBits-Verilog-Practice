module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );
    
    assign out = sel ? b : a;
    
    // The following doesn't work. Why?
	assign out = (sel & b) | (~sel & a);
    // Because sel is one bit, we need to change the sel to a 100 bits bus
    wire [99:0] bus;
    assign bus = {100{sel}};
    assign out = (bus & b) | (~bus & a);
    

endmodule
