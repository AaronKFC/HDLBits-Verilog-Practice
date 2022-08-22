module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    // Solution1 (My implementation1)
    wire cout1, cout2, cout3;
    bcd_fadd bcd1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout1), .sum(sum[3:0]));
    bcd_fadd bcd2(.a(a[7:4]), .b(b[7:4]), .cin(cout1), .cout(cout2), .sum(sum[7:4]));
    bcd_fadd bcd3(.a(a[11:8]), .b(b[11:8]), .cin(cout2), .cout(cout3), .sum(sum[11:8]));
    bcd_fadd bcd4(.a(a[15:12]), .b(b[15:12]), .cin(cout3), .cout(cout), .sum(sum[15:12]));

    // Solution2 (My implementation2)
    wire [3:0] cout_tmp;
    bcd_fadd fadd(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout_tmp[0]), .sum(sum[3:0]));
    assign cout = cout_tmp[3];
    generate
	    genvar i;
        for (i=4; i<16; i+=4) begin:adder
            bcd_fadd fadd(.a(a[i+3:i]), .b(b[i+3:i]), .cin(cout_tmp[i/4-1]), .cout(cout_tmp[i/4]), .sum(sum[i+3:i]));
        end
    endgenerate
    
    // Solution3
    wire [15:0] cout_tmp;
    bcd_fadd fadd(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout_tmp[0]), .sum(sum[3:0]));
    assign cout = cout_tmp[12];
    generate
        genvar i;
        for(i = 4; i < 16; i = i + 4) begin:adder
            bcd_fadd fadd(.a(a[i + 3:i]), .b(b[i + 3:i]), .cin(cout_tmp[i-4]), .cout(cout_tmp[i]), .sum(sum[i + 3:i]));
        end
    endgenerate

endmodule

// Below solution is designed by @Lysias-1998

// module top_module( 
//     input [15:0] a, b,
//     input cin,
//     output cout,
//     output [15:0] sum );
    
//     wire [4:0] c;
    
//     assign c[0] = cin;
//     assign cout = c[4];
//     generate
//         genvar i;
//         for (i = 0; i < 4; i = i + 1) begin : adders
//             bcd_fadd the_bcd_fadders ( 
//                 .a(a[i*4+3 : i*4]), 
//                 .b(b[i*4+3 : i*4]), 
//                 .cin(c[i]), 
//                 .cout(c[i+1]), 
//                 .sum(sum[i*4+3 : i*4]) 
//             );
//         end
//     endgenerate

// endmodule
