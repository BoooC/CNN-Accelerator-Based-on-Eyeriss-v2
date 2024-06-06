module uart_rx_band_gen(
    input 		clock,
	input		reset,
    input 		band_sig,
	
    output	reg clock_bps
);

parameter SYS_RATE_DIV	= 4;
parameter SYS_RATE 		= 125_00_0000/(2**(SYS_RATE_DIV-1)); // 125 MHz
parameter BAND_RATE		= 115200;
parameter CNT_BAND 		= SYS_RATE / BAND_RATE;
parameter HALF_CNT_BAND = CNT_BAND / 2;

reg [13:0] cnt_bps;

always@(posedge clock) begin
	if(reset) begin
		cnt_bps <= HALF_CNT_BAND;
	end
	else if(!band_sig) begin
		cnt_bps <= HALF_CNT_BAND;
	end
	else if(cnt_bps == CNT_BAND) begin
		cnt_bps <= 14'd0;
	end
	else begin
		cnt_bps <= cnt_bps + 1'b1;
	end 
end

always@(posedge clock) begin
	if(reset) begin
		clock_bps <= 'd0;
	end
	else if(!band_sig) begin
		clock_bps <= 1'b0;
	end
	else if(cnt_bps == CNT_BAND) begin
		clock_bps <= 1'b1;
	end
	else  begin
		clock_bps <= 1'b0;
	end 
end

	
endmodule
