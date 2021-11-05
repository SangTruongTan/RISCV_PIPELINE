module PC_Control (
    Br_Result,
    Br_Dectected,
    Br_Dectected_Ex,
    Br_PredictedBit,
    PC_Sel
);
/****************** Decleration ******************/
    input [1:0] Br_Result;
    input Br_Dectected;
    input Br_Dectected_Ex;
    input Br_PredictedBit;
    output reg [1:0]PC_Sel;
    reg temp;

/****************** Always function ******************/  
    always @(*) begin
        temp = 1'b0;
        if (Br_Dectected_Ex) begin          //Predicted previous cycle
            case (Br_Result)
                2'b00: PC_Sel = 2'b10;      //PC_ALU
                2'b01: begin 
                        PC_Sel = 2'b00;      //Right Predicted => PC_New + 4\
                        temp = 1'b1;
                end
                2'b10: PC_Sel = 2'b11;      //PC_old + 4
                2'b11: PC_Sel = 2'b10;      //PC_ALU
            endcase
        end 
        if((!Br_Dectected_Ex & Br_Dectected == 1'b1) | (temp == 1'b1 & Br_Dectected)) begin     //Predicted current cycle
            if (Br_PredictedBit == 1'b1) begin
                PC_Sel = 2'b01;             //PC_Predicted
            end else begin
                PC_Sel = 2'b00;             //PC_New + 4
            end     
        end 
        if(!Br_Dectected_Ex & !Br_Dectected) begin                      //Branch not dectected
            PC_Sel = 2'b00;                 //PC_New + 4
        end
    end
endmodule