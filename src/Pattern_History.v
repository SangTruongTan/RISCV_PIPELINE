module Pattern_History (
    Br_Detected,
    Br_Comp_Result,
    clk,
    Br_PredictedBit,
    Stall_Detected
);
/****************** Decleration ******************/
    parameter WIDTH_PATERN_LENGTH = 3;
    parameter BHB_DEPTH = 1<<3;
    input Br_Detected;
    input Br_Comp_Result;
    input clk;
    input Stall_Detected;
    output reg Br_PredictedBit;
    wire [1:0] temp;
    reg [WIDTH_PATERN_LENGTH -1:0] GHR;
    reg [1:0]BHB[0:BHB_DEPTH - 1]; 
/****************** Module ******************/  
FSM_2bit sm (.x(Br_Comp_Result),
             .rst(1'b0),
             .state_old(BHB[GHR]),
             .state(temp));

/****************** Initialize ******************/  
    integer i;
    initial begin
        for (i = 0; i < BHB_DEPTH; i = i + 1) begin
            BHB[i] = 32'h0;
        end
        GHR = 32'b0;
    end

    assign Br_PredictedBit = BHB[GHR][1];
/****************** Always function ******************/  
    always @(posedge clk ) begin
        if(Br_Detected & (!Stall_Detected)) begin
            BHB[GHR] = temp;
            //            GHR = {Br_Comp_Result, GHR[7:1]};
            GHR = {Br_Comp_Result, GHR[WIDTH_PATERN_LENGTH - 1:1]};
        end
    end
endmodule