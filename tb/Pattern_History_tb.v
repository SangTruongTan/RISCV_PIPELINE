`timescale 1ns/1ps
module Pattern_History_tb;


    parameter WIDTH_PATERN_LENGTH = 8;
    parameter BHB_DEPTH = 1<<8;
    reg Br_Detected;
    reg Br_Comp_Result;
    reg clk;
    reg Stall_Detected;
    wire Br_PredictedBit;

Pattern_History parttern_his (.clk(clk),
                              .Br_Detected(Br_Detected),
                              .Br_Comp_Result(Br_Comp_Result),
                              .Br_PredictedBit(Br_PredictedBit),
                              .Stall_Detected(Stall_Detected));
    
    initial begin
       #0 clk = 1'b0;
            Br_Detected = 1'b0;
            Br_Comp_Result = 1'b1;
        #20 Br_Detected = 1'b1;
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