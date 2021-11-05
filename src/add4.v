module add4 (
    input [31:0] port_in,
    output reg [31:0] port_out
);
assign port_out = port_in + 4;
    
endmodule