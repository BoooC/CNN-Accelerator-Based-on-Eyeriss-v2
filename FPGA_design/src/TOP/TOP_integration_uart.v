module TOP_integration_uart (
	input 				clock,
	input 				reset,
	input				rx_pin_in,
	
	output	reg	[3:0]	result,
	
	output 		[6:0]	seg_7
	
);

reg				system_enable;
wire	[7:0]	DRAM_data_in;
wire			DRAM_read_en;
wire	[9:0]	DRAM_read_addr;
wire	[3:0]	final_out;
wire			final_out_valid;
	
wire	[9:0]	ifmap_read_addr;
wire	[7:0]	ifmap_bram_out;
wire			ifmap_bram_ready;

wire 			interrupt;
wire			clk_de;

seg7_encoder seg7_encoder_inst (
    .clock		(clk_de		),
    .reset   	(reset		),
    .in_num  	(result 	),
    .out_code	(seg_7[6:0]	)
);


TOP_interface TOP_interface_inst (
	.clock				(clk_de				),
	.reset              (reset | interrupt	),
	.system_enable      (system_enable      ),
	.DRAM_data_in       (DRAM_data_in       ),
	.DRAM_read_en		(DRAM_read_en		),
	.DRAM_read_addr     (DRAM_read_addr     ),
	.final_out          (final_out          ),
	.final_out_valid    (final_out_valid    )
);

uart_module	uart_module_inst (
    .clock				(clk_de				),
    .reset              (reset | interrupt	),
    .rx_pin_in          (rx_pin_in          ),
    .ifmap_bram_out     (ifmap_bram_out     ),
	.ifmap_read_addr    (ifmap_read_addr    ),
	.ifmap_bram_ready   (ifmap_bram_ready   )
);

interrupt_gen interrupt_gen_inst (
	.clock		(clk_de		),
	.reset    	(reset    	),
	.rx_pin_in	(rx_pin_in	),
	.interrupt	(interrupt	)
);

clock_gen clock_gen_inst (
	.clock	(clock	),
	.clk_de (clk_de )
);


assign DRAM_data_in 	= ifmap_bram_out;
assign ifmap_read_addr 	= DRAM_read_addr;

always@(posedge clk_de) begin
	if(reset) begin
		result <= 'hf;
	end
	else if(final_out_valid) begin
		result <= final_out;
	end
end


always@(posedge clk_de) begin
	if(reset | interrupt) begin
		system_enable <= 'd0;
	end
	else begin
		system_enable <= ifmap_bram_ready;
	end
end




endmodule
