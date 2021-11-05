module Branch_Dectector (
    Inst,
    clk,
    Br_Dectected
);
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_CONTROL_LENGTH = 5;
    input clk;
    input [WIDTH_DATA_LENGTH - 1:0] Inst;
    output reg Br_Dectected;
    reg [WIDTH_CONTROL_LENGTH - 1:0] Ctrl;


    assign Ctrl = Inst[6:2];

    always @(posedge clk or Ctrl) begin
        case (Ctrl)
            8'b11000: Br_Dectected = 1'b1;
            8'b11011: Br_Dectected = 1'b1;
            8'b11001: Br_Dectected = 1'b1;
            default:  Br_Dectected = 1'b0;
        endcase
    end
endmodule