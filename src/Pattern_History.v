module Pattern_History (
    Br_Dectected,
    Br_Comp_Result,
    clk,
    Br_PredictedBit
);
/****************** Decleration ******************/
    parameter WIDTH_PATERN_LENGTH = 8;
    parameter BHB_DEPTH = 1<<8;
    input Br_Dectected;
    input Br_Comp_Result;
    input clk;
    output reg Br_PredictedBit;

    reg [WIDTH_PATERN_LENGTH -1:0] GHR;
    reg [1:0]BHB[0:BHB_DEPTH - 1]; 
/****************** Initialize ******************/  
    integer i;
    initial begin
        for (i = 0; i < BHB_DEPTH; i = i + 1) begin
            BHB[i] = 32'h0;
        end
        GHR = 8'b0;
    end

    assign Br_PredictedBit = BHB[GHR][1];
/****************** Always function ******************/  
    always @(posedge clk ) begin
        if(Br_Dectected) begin
            GHR = {Br_Comp_Result, GHR[7:1]};
        end
    end
endmodule