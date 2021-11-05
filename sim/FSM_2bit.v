module FSM_2bit (x, state_old, rst, state);
    input x;
    input rst;
    input [1:0] state_old;
    output reg [1:0] state;
    parameter NTS=2'b00, NTW=2'b01, TW=2'b10, TS=2'b11;

always @(*) begin
    if (rst) 
    state <= NTS;
    else
    begin
    case (state_old)
    NTS: if (x) state <= NTW;
        else state <= NTS;
    NTW: if (x) state <= TS;
        else state <= NTS;
    TW: if (x) state <= TS;
        else state <= NTS;
    TS: if (x) state <= TS;
        else state <= TW;
    endcase
    end 
end
endmodule