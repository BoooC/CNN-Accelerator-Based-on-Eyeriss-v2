module uart_top_ctrl(
    input 		clock,
    input 		reset,
    
    input 		en,
    
    input 		rx_read,
    
    output	reg	reset_en_ctl,
    output 		rx_read_buf
);

reg en_reg;

reg [3:0] cnt;


assign rx_read_buf 	= rx_read & en_reg;

always@(posedge clock) begin
    if(reset) begin
        en_reg <= 1'b0;
	end
    else if(cnt == 4'd15) begin
		en_reg <= en;
	end
end
        
always@(posedge clock) begin
    if(reset) begin
        cnt <= 4'd0;
	end
    else if(cnt != 4'd15) begin
        cnt <= cnt + 1'b1;
	end
end
		
endmodule
