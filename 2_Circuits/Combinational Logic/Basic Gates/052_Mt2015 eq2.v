module top_module ( input [1:0] A, input [1:0] B, output z ); 
    // Solution1
    always @(*) begin
    if(A == B)
        z = 1;
    else
        z = 0;
    end

    // Solution2 (from HDLBits)
    assign z = (A[1:0]==B[1:0]);	// Comparisons produce a 1 or 0 result.
    assign z = A==B;  //此寫法也可以
	
	// Another option is to use a 16-entry truth table ( {A,B} is 4 bits, with 16 combinations ).
	// There are 4 rows with a 1 result.  0000, 0101, 1010, and 1111.
endmodule
