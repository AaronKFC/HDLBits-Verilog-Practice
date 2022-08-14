// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    
    always @(*) begin
        left = 0; down = 0; right = 0; up = 0;
        case(scancode)
            16'he06b : left = 1;
            16'he072 : down = 1;
            16'he074 : right = 1;
            16'he075 : up = 1;
            default : ;   //因為有將四個方向均設值0，所以default變得可有可無。
        endcase
    end

endmodule
