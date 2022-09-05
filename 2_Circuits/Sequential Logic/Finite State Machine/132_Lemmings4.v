// Solution1 (My implementation)
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5, SP=6;
    reg [2:0] state, next;
    reg [31:0] cnt;  注意如果持续掉落，计数器就一直加大，因此cnt位宽要设置的足够大！（否则会发生相位截断错误）
    
    always @(*) begin
        case(state)
            L:  next = ~ground ? FL : (dig ? DL : (bump_left ? R:L));
            R:  next = ~ground ? FR : (dig ? DR : (bump_right ? L:R));
            FL: next = ~ground ? FL : (cnt>19 ? SP : L);
            FR: next = ~ground ? FR : (cnt>19 ? SP : R);
            DL: next = ~ground ? FL : DL;
            DR: next = ~ground ? FR : DR;
            SP: next = SP;
        endcase
    end

    
    always @(posedge clk or posedge areset) begin
        if(areset) state <= L;
        else state <= next;
    end
    
    always @(posedge clk) begin
        if(areset) cnt <= 0;
        else begin
            case(state)
                FL: cnt <= cnt+1;
                FR: cnt <= cnt+1;
                default: cnt <= 0;
            endcase
        end
    end
    
    always @(*) begin
        case(state)
            L:  {walk_left, walk_right, aaah, digging} = 4'b1000;
            R:  {walk_left, walk_right, aaah, digging} = 4'b0100;
            FL: {walk_left, walk_right, aaah, digging} = 4'b0010;
            FR: {walk_left, walk_right, aaah, digging} = 4'b0010;
            DL: {walk_left, walk_right, aaah, digging} = 4'b0001;
            DR: {walk_left, walk_right, aaah, digging} = 4'b0001;
            SP: {walk_left, walk_right, aaah, digging} = 4'b0000;
            default: {walk_left, walk_right, aaah, digging} = 4'b0000;
        endcase
    end
    
endmodule

// Solution2 (cnt>20時，就設成flag，不再加1)
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
parameter L=0,R=1,FL=2,FR=3,DL=4,DR=5,S=6;
    reg [2:0]state,next;
    int cnt;
    reg s_flag;
    always@(posedge clk,posedge areset)begin
          if(areset)
            cnt<=0;
        else if(ground==0)
            cnt<=cnt+1;
        else if(cnt>20)
            cnt<=cnt;
        else cnt<=0;
    end
    assign s_flag=(cnt>20);
    always@(*)begin
        case(state)
            L:next=ground?(dig?DL:(bump_left?R:L)):FL;
            R:next=ground?(dig?DR:(bump_right?L:R)):FR;   
            FL:next=ground?(s_flag?S:L):FL;
            FR:next=ground?(s_flag?S:R):FR;
            DL:next=ground?DL:FL;
            DR:next=ground?DR:FR;
            S:next=S;
        endcase
    end
    always@(posedge clk,posedge areset)begin
        if(areset)
            state<=L;
        else
            state<=next;
    end
    assign walk_left=!(state==S)&&(state==L);
    assign walk_right=!(state==S)&&(state==R);
    assign aaah=!(state==S)&&((state==FL)||(state==FR));
    assign digging=!(state==S)&&((state==DL)||(state==DR));
endmodule


//////////////////////////////////////////////
// Solution3
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter left=3'd0, right=3'd1, falll=3'd2, fallr=3'd3, digl=3'd4, digr=3'd5, splat=3'd6;
    reg [2:0] state, next_state;
    reg [31:0] count;

    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= left;
        else if(state == falll || state == fallr) begin
            state <= next_state;
            count <= count + 1;
        end
        else begin
            state <= next_state;
            count <= 0;
        end
    end

    always@(*) begin
        case(state)
            left: begin
                if(~ground)         next_state = falll;
                else if(dig)        next_state = digl;
                else if(bump_left)  next_state = right;
                else                next_state = left;
            end
            right: begin
                if(~ground)         next_state = fallr;
                else if(dig)        next_state = digr;
                else if(bump_right) next_state = left;
                else                next_state = right;
            end
            falll: begin
                if(ground) begin
                    if(count>19)    next_state = splat;
                    else            next_state = left;
                end
                else                next_state = falll;
            end
            fallr: begin
                if(ground) begin
                    if(count>19)    next_state = splat;
                    else            next_state = right;
                end
                else                next_state = fallr;
            end
            digl: begin
                if(ground)  next_state = digl;
                else        next_state = falll;
            end
            digr: begin
                if(ground)  next_state = digr;
                else        next_state = fallr;
            end
            splat: begin
                next_state = splat;
            end
        endcase
    end

    assign  walk_left = (state == left);
    assign  walk_right = (state == right);
    assign  aaah = (state == falll || state == fallr);
    assign  digging = (state == digl || state == digr);

endmodule
