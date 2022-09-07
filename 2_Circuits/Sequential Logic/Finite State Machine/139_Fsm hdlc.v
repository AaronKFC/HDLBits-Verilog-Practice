// Solution1 (My implementation)
module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
	
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, DS=7, FL=8, ER=9;
    reg [5:0] state, next;
    
    always @(*) begin
        case(state)
            S0: next = in ? S1:S0;
            S1: next = in ? S2:S0;
            S2: next = in ? S3:S0;
            S3: next = in ? S4:S0;
            S4: next = in ? S5:S0;
            S5: next = in ? S6:DS;
            S6: next = in ? ER:FL;
            DS: next = in ? S1:S0;
            FL: next = in ? S1:S0;
            ER: next = in ? ER:S0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= S0;
        else state <= next;
    end
    
    assign disc = (state==DS);
    assign flag = (state==FL);
    assign err = (state==ER);
    
endmodule



// Solution2
module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter none=4'd0, one=4'd1, two=4'd2, three=4'd3, four=4'd4, five=4'd5, six=4'd6, error=4'd7, discard=4'd8, flagg=4'd9;
    reg [3:0]   state, next_state;
    
    always@(*) begin
        case({state, in})
            {none, 1'b0}:   next_state = none;
            {none, 1'b1}:   next_state = one;
            {one, 1'b0}:    next_state = none;
            {one, 1'b1}:    next_state = two;
            {two, 1'b0}:    next_state = none;
            {two, 1'b1}:    next_state = three;
            {three, 1'b0}:  next_state = none;
            {three, 1'b1}:  next_state = four;
            {four, 1'b0}:   next_state = none;
            {four, 1'b1}:   next_state = five;
            {five, 1'b0}:   next_state = discard;
            {five, 1'b1}:   next_state = six;
            {six, 1'b0}:    next_state = flagg;
            {six, 1'b1}:    next_state = error;
            {error, 1'b0}:  next_state = none;
            {error, 1'b1}:  next_state = error;
            {discard, 1'b0}:next_state = none;
            {discard, 1'b1}:next_state = one;
            {flagg, 1'b0}:  next_state = none;
            {flagg, 1'b1}:  next_state = one;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset)
            state <= none;
        else
            state <= next_state;
    end
    
    assign  disc = (state == discard);
    assign  flag = (state == flagg);
    assign  err = (state == error);
    
endmodule
