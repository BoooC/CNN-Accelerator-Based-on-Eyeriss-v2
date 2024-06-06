module interrupt_gen (
	input 				clock,
	input 				reset,
	input				rx_pin_in,
	
	output	reg			interrupt
);

reg 			count_start;
reg 	[31:0] 	delay_count;

wire 			rx_pin_H2L;
wire 			delay_count_done = delay_count == 200_0000;


H2L_detect rx_in_detect(
    .clock		(clock		),
	.reset		(reset		),
    .pin_in		(rx_pin_in	),
    .sig_H2L	(rx_pin_H2L	)
);


always@(posedge clock) begin
	if(interrupt | reset) begin
		count_start <= 'd0;
	end
	else if(delay_count_done) begin
		count_start <= 'd0;
	end
	else begin
		count_start <= rx_pin_H2L | count_start;
	end
end

always@(posedge clock) begin
	if(interrupt | reset) begin
		delay_count <= 'd0;
	end
	else if(count_start) begin
		delay_count <= delay_count_done ? 'd0 : delay_count + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		interrupt <= 'd0;
	end
	else if(interrupt) begin
		interrupt <= ~interrupt;
	end
	else if(delay_count_done) begin
		interrupt <= 'd1;
	end
end


endmodule
