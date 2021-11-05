`timescale 1ns/1ps
module Pattern_History_tb;


    parameter WIDTH_PATERN_LENGTH = 8;
    parameter BHB_DEPTH = 1<<8;
    reg Br_Dectected;
    reg Br_Comp_Result;
    reg clk;
    wire Br_PredictedBit;

Pattern_History parttern_his (.clk(clk),
                              .Br_Dectected(Br_Dectected),
                              .Br_Comp_Result(Br_Comp_Result),
                              .Br_PredictedBit(Br_PredictedBit));
    
    initial begin
       #0 clk = 1'b0;
            Br_Dectected = 1'b0;
            Br_Comp_Result = 1'b1;
        #20 Br_Dectected = 1'b1;
            Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
        #10 Br_Comp_Result = 1'b1;
        #10 Br_Comp_Result = 1'b0;
    end

    always begin
        #5 clk = !clk;
    end

endmodule