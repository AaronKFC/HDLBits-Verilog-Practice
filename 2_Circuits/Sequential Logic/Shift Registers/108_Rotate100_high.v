module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    // Solution1 (My implementation)
    always @(posedge clk) begin
        if(load) q <= data;
        else begin
            if(ena==2'b01) q <= {q[0], q[99:1]};
            else if(ena==2'b10) q <= {q[98:0], q[99]};
            //else q <= q; //此行可有可無
        end
    end


    // Solution2 (HDLBits)
    // This rotator has 4 modes:
	//   load
	//   rotate left
	//   rotate right
	//   do nothing
	// I used vector part-select and concatenation to express a rotation.
	// Edge-sensitive always block: Use non-blocking assignments.
	always @(posedge clk) begin
		if (load)		// Load
			q <= data;
		else if (ena == 2'h1)	// Rotate right
			q <= {q[0], q[99:1]};
		else if (ena == 2'h2)	// Rotate left
			q <= {q[98:0], q[99]};
	end


    // Solution3
    always @(posedge clk) begin
        if(load == 1) begin
            q = data;
        end
        else begin
            if(ena[0]^ena[1]) begin
                case (ena)
                    /*right*/
                    2'b01: begin
                        q <= {q[0], q[99:1]};
                    end
                    /*left*/
                    2'b10: begin
                        q <= {q[98:0], q[99]};
                    end
                endcase
            end
        end
    end
    
endmodule
