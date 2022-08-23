module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[A] & (~in) | state[C] & (~in);
    assign next_state[B] = state[A] & in | state[B] & in | state[D] & in;
    assign next_state[C] = state[B] & (~in) | state[D] & (~in);
    assign next_state[D] = state[C] & (in);

    // 注意，如下寫法是錯的：
    always @(*) begin
        case(state)
            4'b0001: next_state <= in ? B : A;
            4'b0010: next_state <= in ? B : C;
            4'b0100: next_state <= in ? D : A;
            4'b1000: next_state <= in ? B : C;
        endcase
    end

    // Output logic: 
    assign out = (state[D] == 1);

endmodule
