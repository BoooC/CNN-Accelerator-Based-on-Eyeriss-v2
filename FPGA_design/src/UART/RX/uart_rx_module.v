module uart_rx_module(
    input 			clock,
	input 			reset,
    input 			rx_pin_in,
	
    output	[7:0]	rx_data_out,
    output 			rx_done
);
    
wire rx_pin_H2L;
wire rx_band_sig, clock_bps;

H2L_detect rx_in_detect(
    .clock		(clock),
	.reset		(reset),
    .pin_in		(rx_pin_in),
    .sig_H2L	(rx_pin_H2L)
);

// band signal
uart_rx_band_gen rx_band_gen(
    .clock		(clock),
	.reset		(reset),
    .band_sig	(rx_band_sig),
    .clock_bps	(clock_bps)
);

// control
uart_rx_ctrl rx_ctrl(
    .clock			(clock),
	.reset			(reset),
    .rx_pin_in		(rx_pin_in),
    .rx_pin_H2L		(rx_pin_H2L),
    .rx_band_sig	(rx_band_sig),
    .rx_clock_bps	(clock_bps),
    .rx_data		(rx_data_out),
    .rx_done_sig	(rx_done)
);

endmodule
