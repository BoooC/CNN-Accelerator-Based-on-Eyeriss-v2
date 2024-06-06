module TOP_integration(
	input 			clock,
	input 			reset,
	
	input			ifmap_BRAM_wr_in,
	input	[7:0]	ifmap_BRAM_dina_in,
	
	/*
	output	[3:0]	seg_h_an, 	// DN0 (DK 1-4) => B3, B2
	output	[7:0]	seg_h_code,
	output	[3:0]	seg_l_an, 	// DN1 (DK 5-8) => B1, B0
	output	[7:0]	seg_l_code
	*/
	output	reg	[3:0]	result
);


reg [9:0] 	ifmap_write_addr;
reg			system_enable_temp;	// delay 1 cycle

wire ifmap_write_done = ifmap_write_addr == 'd783;

reg				system_enable;
wire	[7:0]	DRAM_data_in;
wire			DRAM_read_en;
wire	[9:0]	DRAM_read_addr;
wire	[3:0]	final_out;
wire			final_out_valid;
/*
wire	[7:0] 	seg7_b3_data;
wire	[7:0] 	seg7_b2_data;
wire	[7:0] 	seg7_b1_data;
wire	[7:0] 	seg7_b0_data;
*/
wire			ifmap_BRAM_wr;
wire	[9:0]	ifmap_BRAM_addra;
wire	[7:0]	ifmap_BRAM_dina;
wire	[7:0]	ifmap_BRAM_douta;


TOP_interface TOP_interface_inst (
	.clock				(clock				),
	.reset              (reset              ),
	.system_enable      (system_enable      ),
	.DRAM_data_in       (DRAM_data_in       ),
	.DRAM_read_en       (DRAM_read_en       ),
	.DRAM_read_addr     (DRAM_read_addr     ),
	.final_out          (final_out          ),
	.final_out_valid    (final_out_valid    )
);

/*
seg7_module seg7_module_inst (
    .clock		(clock			),
    .reset      (reset      	),
    .b3_data    (seg7_b3_data	),
    .b2_data    (seg7_b2_data	),
    .b1_data    (seg7_b1_data	),
    .b0_data    (seg7_b0_data	),
    .seg_h_an   (seg_h_an   	),
    .seg_h_code (seg_h_code 	),
    .seg_l_an   (seg_l_an   	),
    .seg_l_code (seg_l_code 	)
);
*/

IP_ifmap_BRAM u0 (   	
	.clka	(clock				),    	
	.rsta	(reset				),
	.wea	(ifmap_BRAM_wr		),      	
	.addra	(ifmap_BRAM_addra	),  	
	.dina	(ifmap_BRAM_dina	),    	
	.douta	(ifmap_BRAM_douta	)  	
);


assign DRAM_data_in = ifmap_BRAM_douta;

/*
assign seg7_b3_data = 8'd0;
assign seg7_b2_data = 8'd0;
assign seg7_b1_data = 8'd0;
assign seg7_b0_data = {4'd0, result};
*/

assign ifmap_BRAM_wr	= ifmap_BRAM_wr_in;
assign ifmap_BRAM_addra = ifmap_BRAM_wr ? ifmap_write_addr : DRAM_read_addr;
assign ifmap_BRAM_dina	= ifmap_BRAM_dina_in;


always@(posedge clock) begin
	if(reset) begin
		result <= 'hf;
	end
	else if(final_out_valid) begin
		result <= final_out;
	end
end


always@(posedge clock) begin
	if(reset) begin
		ifmap_write_addr <= 'd0;
	end
	else if(ifmap_BRAM_wr) begin	// write data into ifmap BRAM
		ifmap_write_addr <= ifmap_write_done ? 'd0 : (ifmap_write_addr + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		system_enable_temp <= 'd0;
	end
	else if(ifmap_write_done) begin
		system_enable_temp <= 'd1;
	end
	else begin
		system_enable_temp <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		system_enable <= 'd0;
	end
	else begin
		system_enable <= system_enable_temp;
	end
end



endmodule
