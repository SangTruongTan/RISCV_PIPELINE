module Branch_Dectector (
    Inst,
    clk,
    Br_Detected
);
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_CONTROL_LENGTH = 5;
    input clk;
    input [WIDTH_DATA_LENGTH - 1:0] Inst;
    output reg Br_Detected;
    reg [WIDTH_CONTROL_LENGTH - 1:0] Ctrl;


    assign Ctrl = Inst[6:2];

    always @(posedge clk or Ctrl) begin
        case (Ctrl)
            5'b11000: Br_Detected = 1'b1;
            5'b11011: Br_Detected = 1'b1;
            5'b11001: Br_Detected = 1'b1;
            default:  Br_Detected = 1'b0;
        endcase
    end
endmodule