module DMEM_ADDJ (
    DataIn,
    FormatSel,
    DataOut
);
    parameter WIDTH_DATA_LENGTH = 32;
    parameter LENGTH_MUX = 3;
    input [WIDTH_DATA_LENGTH -1:0] DataIn;
    input [LENGTH_MUX -1:0] FormatSel;
    output reg [WIDTH_DATA_LENGTH -1:0] DataOut;

    always @(FormatSel or DataIn) begin
        case (FormatSel)
            //Extend Signed Byte 
            3'b000: if (DataIn[7] == 1'b1) begin
                        DataOut = {24'hFF_FF_FF, DataIn[7:0]};
                    end else begin
                        DataOut = {24'h00_00_00, DataIn[7:0]};
                    end
            //Extend Signed Half Word
            3'b001: if (DataIn[15] == 1'b1) begin
                        DataOut = {16'hFF_FF, DataIn[15:0]};
                    end else begin
                        DataOut = {16'h00_00, DataIn[15:0]};
                    end
            //Extend Unsigned Byte
            3'b011: DataOut = {24'h00_00_00, DataIn[7:0]};
            //Extend Unsigned Half Word
            3'b100: DataOut = {16'h00_00, DataIn[15:0]};
            //Forward Word Length
            3'b010: DataOut = DataIn; 
        endcase
    end
endmodule