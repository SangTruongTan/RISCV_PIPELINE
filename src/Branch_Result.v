module Branch_Result (
    Predicted,
    PC_Pre,
    PC_ALU,
    clk,
    Execute,
    Result,
);
    parameter WIDTH_DATA_LENGTH = 32;
    input clk;
    input [WIDTH_DATA_LENGTH - 1:0] PC_Pre;
    input [WIDTH_DATA_LENGTH - 1:0] PC_ALU;
    input Predicted;
    input Execute;
    output reg [1:0] Result;
    reg [1:0] Temp;
    assign Temp = {Execute, Predicted};

    always @(*) begin
                case (Temp)
                    2'b00: Result = 2'b01;      //Right Predicted
                    2'b01: Result = 2'b10;      //Return PC + 4
                    2'b10: Result = 2'b11;      //PC_ALU 
                    2'b11: if (PC_Pre != PC_ALU) begin
                            Result = 2'b00;          //Predicted wrong target
                        end else begin
                            Result = 2'b01;     //Right Predicted
                        end
                endcase
    end
endmodule