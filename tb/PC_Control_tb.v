`timescale 1ns/1ps
module PC_Control_tb;


/****************** Decleration ******************/
    reg Br_Dectected;
    reg Br_Dectected_Ex;
    reg [1:0] Br_Result;
    reg Br_PredictedBit;
    wire [1:0]PC_Sel;

/****************** Module ******************/
PC_Control pc_ctrl1 (.Br_Dectected(Br_Dectected),
                     .Br_Dectected_Ex(Br_Dectected_Ex),
                     .Br_Result(Br_Result),
                     .Br_PredictedBit(Br_PredictedBit),
                     .PC_Sel(PC_Sel));


/****************** Initialize ******************/
initial begin
    #0  Br_Dectected = 1'b0;
        Br_Dectected_Ex = 1'b0;
        Br_Result = 2'b10;
        Br_PredictedBit = 1'b1;
    #50 Br_Dectected = 1'b0;
        Br_Dectected_Ex = 1'b1;
        Br_Result = 2'b00;
        Br_PredictedBit = 1'b1;
    #10 Br_Result = 2'b01;
    #10 Br_Result = 2'b10;
    #10 Br_Result = 2'b11;

    #50 Br_Dectected = 1'b1;
        Br_Dectected_Ex = 1'b0;
        Br_Result = 2'b10;
        Br_PredictedBit = 1'b1;
    #10 Br_PredictedBit = 1'b0;

    #50 Br_Dectected = 1'b1;
        Br_Dectected_Ex = 1'b1;
        Br_Result = 2'b01;
        Br_PredictedBit = 1'b1;
    #10 Br_PredictedBit = 1'b0;
    #20 Br_Result = 2'b00;
    #20 Br_Result = 2'b10;
    #20 Br_Result = 2'b11;
    
end
    
endmodule