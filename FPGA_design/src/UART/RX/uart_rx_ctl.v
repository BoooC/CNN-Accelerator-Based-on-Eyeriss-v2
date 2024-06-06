module uart_rx_ctrl(
    input 				clock,
	input				reset,
    input 				rx_pin_in,
    input 				rx_pin_H2L,
    input 				rx_clock_bps,
	
    output	reg 		rx_band_sig,
    output	reg	[7:0]	rx_data,
    output	reg 		rx_done_sig
);

localparam [3:0] IDLE  = 4'd0,	BEGIN = 4'd1, 	
				 DATA0 = 4'd2, 	DATA1 = 4'd3, DATA2 = 4'd4, DATA3 = 4'd5, DATA4 = 4'd6,	DATA5 = 4'd7, DATA6 = 4'd8, DATA7 = 4'd9,	
				 END   = 4'd10,	BFREE = 4'd11; 
				 
reg [3:0] pos;

always@(posedge clock) begin
	if(reset) begin
		pos <= 'd0;
	end
	else begin
		case(pos)
			IDLE	: pos <= rx_pin_H2L 	? (pos + 1'b1) : pos;
			BEGIN	: pos <= rx_clock_bps 	? (rx_pin_in ? IDLE : (pos + 1'b1)) : pos;
			DATA0	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA1	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA2	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA3	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA4	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA5	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA6	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			DATA7	: pos <= rx_clock_bps 	? (pos + 1'b1) : pos; 
			END		: pos <= rx_clock_bps	? (pos + 1'b1) : pos;
			BFREE	: pos <= IDLE;
			default : pos <= IDLE;
		endcase
	end
end


always@(posedge clock) begin
	if(reset) begin
		rx_band_sig <= 'd0;
	end
	else begin
		case(pos)
			IDLE	: rx_band_sig <= rx_pin_H2L ? 1'b1 : 1'b0;
			BEGIN	: rx_band_sig <= (rx_clock_bps & rx_pin_in) ? 1'b0 : 1'b1;
			END		: rx_band_sig <= rx_clock_bps ? 1'b0 : 1'b1;
		endcase
	end
end

always@(posedge clock) begin
	if(reset) begin
		rx_done_sig <= 'd0;
	end
	else begin
		case(pos)
			END		: rx_done_sig <= rx_clock_bps ? 1'b1 : 1'b0;
			BFREE	: rx_done_sig <= 1'b0;
		endcase
	end
end


always@(posedge clock) begin
	if(reset) begin
		rx_data <= 'd0;
	end
	else begin
		case(pos)
			IDLE	: rx_data	 	<= rx_pin_H2L 	? 8'd0 : rx_data;
			DATA0	: rx_data[0]	<= rx_clock_bps ? rx_pin_in : rx_data[0]; 
			DATA1	: rx_data[1]	<= rx_clock_bps ? rx_pin_in : rx_data[1]; 
			DATA2	: rx_data[2]	<= rx_clock_bps ? rx_pin_in : rx_data[2]; 
			DATA3	: rx_data[3]	<= rx_clock_bps ? rx_pin_in : rx_data[3]; 
			DATA4	: rx_data[4]	<= rx_clock_bps ? rx_pin_in : rx_data[4]; 
			DATA5	: rx_data[5]	<= rx_clock_bps ? rx_pin_in : rx_data[5]; 
			DATA6	: rx_data[6]	<= rx_clock_bps ? rx_pin_in : rx_data[6]; 
			DATA7	: rx_data[7]	<= rx_clock_bps ? rx_pin_in : rx_data[7]; 
		endcase
	end
end


endmodule
