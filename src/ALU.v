module ALU (
    DataA,
    DataB,
    ALUSel,
    DataOut
);
/****************** Decleration ******************/
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_ALUSEL_LENGTH = 4;
    input [WIDTH_DATA_LENGTH - 1:0] DataA;
    input [WIDTH_DATA_LENGTH - 1:0] DataB;
    input [WIDTH_ALUSEL_LENGTH - 1:0] ALUSel;
    output reg [WIDTH_DATA_LENGTH - 1:0] DataOut;

/****************** Always function ******************/  
    always @(*) begin
        case (ALUSel)
            4'b0000: DataOut = DataA + DataB;   //ADD
            4'b0001: DataOut = DataA - DataB;   //SUB
            4'b0010: DataOut = DataA << DataB;  //SLL
            4'b0011: DataOut = ($signed(DataA) < $signed(DataB)) ? 32'd1 : 32'd0; //SLT
            4'b0100: DataOut = (DataA < DataB) ? 32'd1: 32'd0;  //SLTU
            4'b0101: DataOut = DataA ^ DataB;   //XOR
            4'b0110: DataOut = DataA >> DataB;  //SRL
            4'b0111: DataOut = $signed(DataA) >>> DataB; //SRA
            4'b1000: DataOut = DataA | DataB;   //OR
            4'b1001: DataOut = DataA & DataB;   //AND
            4'b1110: DataOut = DataA + DataB + 32'd4;           //A + B + 4
            4'b1111: DataOut = DataB;           //SEL B
            default: ;
        endcase
    end
endmodule