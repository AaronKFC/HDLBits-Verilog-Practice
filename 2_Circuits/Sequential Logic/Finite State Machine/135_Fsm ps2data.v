// Solution1 (My implementation)
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter B1=1, B2=2, B3=3, Dn=4;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            B1: next = in[3] ? B2:B1;
            B2: next = B3;
            B3: next = Dn;
            Dn: next = in[3] ? B2:B1;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= B1;
        else state <= next;
    end
    
    assign done = (state==Dn);

    // New: Datapath to store incoming bytes.
    reg [23:0] data;
    always @(posedge clk) begin
        if(reset) data <= 0;
        else begin
            data[23:16] <= data[15:8];
            data[15:8] <= data[7:0];
            data[7:0] <= in;
        end
    end
    
    assign out_bytes = (done) ? data : 0;

    ////////////////////////////////////////////////
    // 以下寫法在done=1時雖輸出正確，但在done=0時，不需要輸出
    // 所以還是設一個data register來存輸出前的in bytes較佳。
    always @(posedge clk) begin
        if(reset) out_bytes <= 0;
        else begin
            case(state)
                B1: out_bytes[23:16] <= in;
                B2: out_bytes[15:8] <= in;
                B3: out_bytes[7:0] <= in;
                default: out_bytes <= 0;
            endcase
        end
    end
    ////////////////////////////////////////////////
endmodule



// Solution2
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter b1 = 1, b2 = 2, b3 = 3, dn = 4;
    reg [2:0] state, next_state;
    reg [23:0] data;

    always @(*) begin
        case ({state, in[3]})
            {b1, 1'b0}: next_state = b1;
            {b1, 1'b1}: next_state = b2;
            {b2, 1'b0}: next_state = b3;
            {b2, 1'b1}: next_state = b3;
            {b3, 1'b0}: next_state = dn;
            {b3, 1'b1}: next_state = dn;
            {dn, 1'b0}: next_state = b1;
            {dn, 1'b1}: next_state = b2;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= b1;
        end
        else begin
            state <= next_state;
        end
    end

    assign done = (state == dn);

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset) begin
            data <= 24'd0;
        end
        else begin
            data[23:16] <= data[15:8];
            data[15:8] <= data[7:0];
            data[7:0]  <= in;
        end
    end

    assign out_bytes = (done) ? data : 24'd0;

endmodule


// Solution3 (from 知乎： https://zhuanlan.zhihu.com/p/134087559)
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter IDLE  = 4'b0001;
    parameter BYTE1 = 4'b0010;
    parameter BYTE2 = 4'b0100;
    parameter BYTE3 = 4'b1000;
    reg [3:0] state, nstate;

    always @(*)begin
        nstate = 4'd0;
        case(state)
            IDLE: nstate = in[3]? BYTE1:IDLE;
            BYTE1:nstate = BYTE2;
            BYTE2:nstate = BYTE3;
            BYTE3:nstate = in[3]? BYTE1:IDLE;
            default:nstate = IDLE;
        endcase
    end

    always @(posedge clk)begin
        if(reset)begin
            state <= IDLE;
        end
        else begin
            state <= nstate;
        end
    end
    
    // Output logic
    reg [7:0] db1,db2,db3;       //db=>data_byte
    assign done = (state == BYTE3);
    always @(posedge clk)begin
        if(reset)begin
            db1 <= 8'd0;
            db2 <= 8'd0;
            db3 <= 8'd0;
        end
        else begin
            case(nstate)
                BYTE1:db1 <= in;
                BYTE2:db2 <= in;
                BYTE3:db3 <= in;
            endcase
        end
    end
    assign out_bytes = {db1,db2,db3};
endmodule