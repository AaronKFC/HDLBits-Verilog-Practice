// Solution1 (My implementation)
module top_module (input x, input y, output z);
wire za1, za2, zb1, zb2;
wire w1, w2;

IA IA1(.x(x), .y(y), .z(za1));
IA IA2(.x(x), .y(y), .z(za2));
IB IB1(.x(x), .y(y), .z(zb1));
IB IB2(.x(x), .y(y), .z(zb2));

assign w1 = za1 | zb1;
assign w2 = za2 & zb2;
assign z = w1 ^ w2;

endmodule


module IA (input x, input y, output z);
assign z = (x^y) & x;
endmodule

module IB ( input x, input y, output z );
assign z = ~(x ^ y);
endmodule


////////////////////////////////////////////////////////////////
// Solution2
module top_module(input x,	input y, output z);

	wire o1, o2, o3, o4;
	A ia1 (x, y, o1);
	B ib1 (x, y, o2);
	A ia2 (x, y, o3);
	B ib2 (x, y, o4);
	
	assign z = (o1 | o2) ^ (o3 & o4);
	// Or you could simplify the circuit including the sub-modules:
	// assign z = x|~y;
endmodule

module A (input x, input y,	output z);
	assign z = (x^y) & x;
endmodule

module B (input x, input y,	output z);
	assign z = ~(x^y);
endmodule



////////////////////////////////////////////////////////////////
// Solution3 
module top_module (input x, input y, output z);
    wire [3:0] z_tmp;
    
    task A;
        input x,y;
        output z;
        begin
            z = (x ^ y) & x;
        end
    endtask
    
    task B;
        input x,y;
        output z;
        begin
            if(x == y)
                z = 1;
            else
                z = 0;
        end
    endtask
    
    always @(*) begin
        A(x,y,z_tmp[0]);
        B(x,y,z_tmp[1]);
        A(x,y,z_tmp[2]);
        B(x,y,z_tmp[3]);
    end
    
    assign z = (z_tmp[0] | z_tmp[1]) ^ (z_tmp[2] & z_tmp[3]);
    
endmodule
