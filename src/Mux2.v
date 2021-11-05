module Mux2 (
    input   sel_port,
    input   [31:0] port_in_0,
    input   [31:0] port_in_1,
    output reg [31:0] port_out
    );
    always @(*) begin
        if (sel_port == 1) begin
            port_out <= port_in_1;
        end
        else begin
            port_out <= port_in_0;
        end
    end
endmodule 
