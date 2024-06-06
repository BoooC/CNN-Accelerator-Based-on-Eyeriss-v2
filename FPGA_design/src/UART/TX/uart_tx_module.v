module uart_tx_module(
    input 			clock,
    input 			reset,
    input	[7:0]	tx_data,
    input 			tx_buf_not_empty,
    output 			tx_pin_out,
    output 			tx_read_buf
);

wire tx_band_sig, clock_bps;

// band signal
uart_tx_band_gen tx_band_gen(
    .clock		(clock),
    .reset		(reset),
    .band_sig	(tx_band_sig),
    .clock_bps	(clock_bps)
);

// control
uart_tx_ctl tx_ctl(
    .clock				(clock),
    .reset				(reset),
    .tx_clock_bps		(clock_bps),
    .tx_data			(tx_data),
    .tx_buf_not_empty	(tx_buf_not_empty),
    .tx_band_sig		(tx_band_sig),
    .tx_pin_out			(tx_pin_out),
    .tx_read_buf		(tx_read_buf)
);
    
	
endmodule
