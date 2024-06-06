module uart_tx_ctl(
    input 			clock,
    input 			reset,
    input 			tx_clock_bps,
    input	[7:0]	tx_data,
    input 			tx_buf_not_empty,
    
    output	reg 	tx_band_sig,
    output	reg 	tx_pin_out,
    output	reg		tx_read_buf
);

localparam [3:0] IDLE  = 4'd0, 	BEGIN = 4'd1,  
				 DATA0 = 4'd2,  DATA1 = 4'd3, DATA2 = 4'd4, DATA3 = 4'd5, DATA4 = 4'd6, DATA5 = 4'd7, DATA6 = 4'd8, DATA7 = 4'd9, 
				 END   = 4'd10, BFREE = 4'd11; 
                 
reg [3:0] pos;
always@(posedge clock) begin
    if(reset) begin
        pos <= IDLE;
    end
    else begin
        case(pos)
            IDLE	: pos <= tx_buf_not_empty 	? (pos + 1'b1) : pos;
            BEGIN	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA0	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA1	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA2	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA3	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA4	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA5	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA6	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			DATA7	: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
            END		: pos <= tx_clock_bps 		? (pos + 1'b1) : pos;
			BFREE	: pos <= tx_clock_bps 		? IDLE : pos;
        endcase
	end
end

always@(posedge clock) begin
    if(reset) begin
        tx_band_sig <= 1'b0;
    end
    else begin
        case(pos)
            IDLE	: tx_band_sig <= tx_buf_not_empty 	? 1'b1 : tx_band_sig;
            END		: tx_band_sig <= tx_clock_bps 		? 1'b0 : tx_band_sig;
        endcase
	end
end

always@(posedge clock) begin
    if(reset) begin
		tx_read_buf <= 1'b0;
    end
    else begin
        case(pos)
            IDLE	: tx_read_buf <= tx_buf_not_empty 	? 1'b1 : tx_read_buf;
            BEGIN	: tx_read_buf <= 1'b0;
        endcase
	end
end

always@(posedge clock) begin
    if(reset) begin
        tx_pin_out <= 1'b1;
    end
    else begin
        case(pos)
            BEGIN	: tx_pin_out <= tx_clock_bps 		? 1'b0 		 : tx_pin_out;
			DATA0	: tx_pin_out <= tx_clock_bps 		? tx_data[0] : tx_pin_out;
			DATA1	: tx_pin_out <= tx_clock_bps 		? tx_data[1] : tx_pin_out;
			DATA2	: tx_pin_out <= tx_clock_bps 		? tx_data[2] : tx_pin_out;
			DATA3	: tx_pin_out <= tx_clock_bps 		? tx_data[3] : tx_pin_out;
			DATA4	: tx_pin_out <= tx_clock_bps 		? tx_data[4] : tx_pin_out;
			DATA5	: tx_pin_out <= tx_clock_bps 		? tx_data[5] : tx_pin_out;
			DATA6	: tx_pin_out <= tx_clock_bps 		? tx_data[6] : tx_pin_out;
			DATA7	: tx_pin_out <= tx_clock_bps 		? tx_data[7] : tx_pin_out;
            END		: tx_pin_out <= tx_clock_bps 		? 1'b1 		 : tx_pin_out;
        endcase
	end
end



endmodule
