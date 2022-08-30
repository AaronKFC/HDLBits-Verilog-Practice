// Solution1 (無counter，純FSM實作，但較易理解)
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    //定义状态
    parameter [3:0] IDLE  = 4'd0;
    parameter [3:0] START = 4'd1;
    parameter [3:0] BIT1  = 4'd2;
    parameter [3:0] BIT2  = 4'd3;
    parameter [3:0] BIT3  = 4'd4;
    parameter [3:0] BIT4  = 4'd5;
    parameter [3:0] BIT5  = 4'd6;
    parameter [3:0] BIT6  = 4'd7;
    parameter [3:0] BIT7  = 4'd8;
    parameter [3:0] BIT8  = 4'd9;
    parameter [3:0] STOP  = 4'd10;
    parameter [3:0] ERROR  = 4'd11;
    reg [3:0] state,nstate;
    reg [7:0] data_r;
    //状态转移
    always @(posedge clk)begin
        if(reset)begin
            state <= IDLE;
        end
        else begin
           state <= nstate; 
        end
    end
    
    always @(*)begin
       nstate = IDLE;
        case(state)
            IDLE: nstate = in? IDLE:START;
            START:nstate = BIT1;
            BIT1: nstate = BIT2;
            BIT2: nstate = BIT3;
            BIT3: nstate = BIT4;
            BIT4: nstate = BIT5;
            BIT5: nstate = BIT6;
            BIT6: nstate = BIT7;
            BIT7: nstate = BIT8;
            BIT8: nstate = in? STOP:ERROR;
            STOP: nstate = in? IDLE:START;
            ERROR: nstate = in? IDLE:ERROR;
            default: nstate = IDLE;
        endcase
    end
    //寄存输入数据
    always @(posedge clk)begin
        case(nstate)
            BIT1: data_r <= {in,data_r[7:1]};
            BIT2: data_r <= {in,data_r[7:1]};
            BIT3: data_r <= {in,data_r[7:1]};
            BIT4: data_r <= {in,data_r[7:1]};
            BIT5: data_r <= {in,data_r[7:1]};
            BIT6: data_r <= {in,data_r[7:1]};
            BIT7: data_r <= {in,data_r[7:1]};
            BIT8: data_r <= {in,data_r[7:1]}; 
        endcase
    end
    //输出
    assign done = (state == STOP);
    assign out_byte = (state == STOP)? data_r:0;

endmodule


//////////////////////////////////////////////////////////////
// Solution2  (結合counter)
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter  idle=0, start=1, data=2, stop=3, error=4;
    reg  [2: 0] state, next_state;
    reg  [3: 0] count;
    reg  [7: 0] store;
    // Use FSM from Fsm_serial
    always @(*)
        begin
            case(state)
                idle:  next_state = in ? idle: start;
                start: next_state = data;
                data:  next_state = count == 4'd8 ? ( in ? stop: error): data;
                stop:  next_state = in ? idle: start;
                error: next_state = in ? idle: error;
            endcase
        end
    
    always @(posedge clk)
        begin
            if (reset)
                begin
                    state <= 3'b0;
                    count <= 4'b0;
                    store <= 8'b0;
                end
            else
                begin
                    state <= next_state;
                    count <= 4'b0;
                    done  <= 1'b0;
                    if(next_state == data)
                        begin
                            count <= count +1'b1;
                            store <= {in, store[7:1]};
                        end
               
                    if(next_state == stop)
                        begin
                            done <= 1'b1;
                            out_byte <= store;
                        end
          
                end
        end
    // New: Datapath to latch input bits.

endmodule


/////////////////////////////////////////////////////////////
// Solution3
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    reg [3:0] i;
    parameter rc = 0, rd = 1, dn = 2, err = 3;
    reg [2:0] state, next_state;
    reg [7:0] date;

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
                    date[i] <= in;
                end
            end
            dn: begin
                next_state <= in ? rd : rc;
                out_byte <= date;
            end
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
            else if ((state == dn)) begin
                i <= 0;
            end
            else if (state == err) begin
                i <= 0;
            end
            state <= next_state;
        end
    end

    // New: Datapath to latch input bits.
    assign done = (state == dn);

endmodule
