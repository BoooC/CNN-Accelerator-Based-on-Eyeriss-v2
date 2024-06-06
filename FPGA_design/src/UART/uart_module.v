module uart_module(
    input 				clock,
    input 				reset,
		
    // rx pin	
    input 				rx_pin_in,
	
	input		[9:0]	ifmap_read_addr,
    output		[7:0]	ifmap_bram_out,
	output	reg			ifmap_bram_ready
);


wire [7:0]	rx_data_out;
wire 		rx_done;

reg	 [9:0]	ifmap_write_addr;

wire [9:0] ifmap_BRAM_addra = ~ifmap_bram_ready ? ifmap_write_addr : ifmap_read_addr;

IP_ifmap_BRAM u0 (   	
	.clka	(clock				),    	
	.rsta	(reset				),
	.wea	(rx_done			),      	
	.addra	(ifmap_BRAM_addra	),  	
	.dina	(rx_data_out		),    	
	.douta	(ifmap_bram_out		)  	
);


// rx
uart_rx_module uart_rx(
    .clock			(clock			),
    .reset			(reset			),
    .rx_pin_in		(rx_pin_in		),
    .rx_data_out	(rx_data_out	),
    .rx_done		(rx_done		)
);

always@(posedge clock) begin
    if(reset) begin
        ifmap_write_addr <= 'd0;
    end
    else if(rx_done) begin
        ifmap_write_addr <= (ifmap_write_addr == 'd783) ? 'd0 : (ifmap_write_addr + 'd1);
    end
end

always@(posedge clock) begin
    if(reset) begin
        ifmap_bram_ready <= 'd0;
    end
    else if(ifmap_write_addr == 'd783 & rx_done) begin
        ifmap_bram_ready <= 'd1;
    end
end


endmodule
