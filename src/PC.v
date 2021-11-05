module PC(
    input [31:0] port_in,
    input clock,
    output reg [31:0] port_out
);
initial begin
  port_out = 32'h0000_0000;
end
always @(posedge clock) begin
  port_out <= port_in;
end
endmodule
