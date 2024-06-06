module clock_gen (
	input 	clock,
	output	clk_de
);

reg 	[5:0] 	clk_count;

assign clk_de = clk_count[2];

always@(posedge clock) begin
	clk_count <= clk_count + 'd1;
end


endmodule
