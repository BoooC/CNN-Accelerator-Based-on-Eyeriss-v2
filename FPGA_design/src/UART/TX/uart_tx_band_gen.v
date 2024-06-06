module uart_tx_band_gen(
    input 		clock,
    input 		reset,
    input 		band_sig,
    output	reg clock_bps
);

parameter SYS_RATE 	= 100000000;
parameter BAND_RATE = 921600;
parameter CNT_BAND 	= SYS_RATE / BAND_RATE;

reg [13:0]	cnt_bps;

always@(posedge clock) begin
    if(reset) begin
        cnt_bps <= CNT_BAND - 1'b1;
    end
    else if(!band_sig) begin
        cnt_bps <= CNT_BAND - 1'b1;
    end
    else if(cnt_bps == CNT_BAND) begin
        cnt_bps <= 14'd0;
    end
    else  begin
        cnt_bps <= cnt_bps + 1'b1;
    end    
end

always@(posedge clock) begin
    if(reset) begin
        clock_bps <= 1'b0;
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
