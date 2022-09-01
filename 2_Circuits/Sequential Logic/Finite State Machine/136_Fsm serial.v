// Solution1 (My implementation)
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
	parameter IDLE=0, START=1, DATA=2, STOP=3, ERROR=4;
    reg [3:0] cnt;  //要用4個bit，只用3個bit反而出錯。
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            IDLE:  next = ~in ? START:IDLE;
            START: next = DATA;
            DATA:  next = (cnt==8) ? (in ? STOP:ERROR):DATA;
            STOP:  next = ~in ? START:IDLE;
            ERROR: next = ~in ? ERROR:IDLE;
        endcase
    end
    
    always @(posedge clk) begin 
        if(reset) state <= IDLE;
        else state <= next;
    end
    
    // 注意counter的coding
    always @(posedge clk) begin
        if(reset) cnt <=0;
        else begin
            case(next)  //注意主要是看next_state，不是state
                START: cnt <= 0;
                DATA:  cnt = cnt+1;
                default: cnt <= cnt;
            endcase
        end
    end
    
    assign done = (state==STOP);
endmodule



////////////////////////////////////////////////////////////////////
// Solution2
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    localparam idle = 0;
    localparam start = 1;
    localparam data = 2;
    localparam stop =3;
    localparam error = 4;
    
    reg[2:0] state, next_state;
    reg[3:0] cnt;
    reg done_r;
    
//transition
    always@(*)begin
        case(state)
            idle:next_state=in?idle:start;
            start:next_state=data;
            data:next_state=(cnt==8)?(in?stop:error):data;
            stop:next_state=in?idle:start;
            error:next_state=in?idle:error;
        endcase
    end
    
//state
    always@(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= next_state;
    end
    
//cnt
    always@(posedge clk)begin
        if(reset)
            cnt<=0;
        else
            case(next_state)
                start:cnt<=0;
                data:cnt<=cnt+1;
                default:cnt<=cnt;
            endcase
    end
    
//done_r
    always@(posedge clk)
        case(next_state)
            stop:done_r <= 1;
            default:done_r <= 0;
        endcase
    
    assign done = done_r;
    
endmodule

///////////////////////////////////////////////////////////////////////
// Solution3
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    reg [3:0] i;
    parameter rc = 0, dn = 1, rd = 2, err = 3;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            rd: next_state <= in ? rd : rc;
            rc: begin
                if ((i == 8) & in) begin
                    next_state <= dn;
                end
                else if ((i == 8) & (~in)) begin
                    next_state <= err;
                end
                else begin
                    next_state <= rc;
                end
            end
            dn: next_state <= in ? rd : rc;
            err: next_state <= in ? rd : err;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= rd;
            i <= 0;
        end
        else begin
            if ((state == rc) && (i != 8)) begin
                i <= i + 1;
            end
            else if (state == err) begin
                i <= 0;
            end
            else if (state == dn) begin
                i <= 0;
            end
            state <= next_state;
        end
    end

    assign done = (state == dn);

endmodule
