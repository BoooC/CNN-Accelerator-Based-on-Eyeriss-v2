module TOP_integration_rom (
	input				clock,
	input 				reset,
	
	//output		[3:0]	state
	output		[3:0]	result
);


reg [5:0] clk_count=0;
wire clk_de = clk_count[4];
always@(posedge clock) begin
	clk_count <= clk_count + 'd1;
end


reg				ifmap_BRAM_wr_in;
wire	[7:0]	ifmap_BRAM_dina_in;
	
wire			ROM_read_en;
reg		[9:0]	ROM_read_addr;
wire	[7:0]	ROM_data_out;

reg ROM_read_done;
/*
wire clk_de;
processing_system7_0 processing_system7_0 (
  .FCLK_CLK0(clk_de)
);
*/
//wire[5:0] state_wire;
//assign state = {state_wire[5], state_wire[3],state_wire[2],state_wire[0]};
TOP_integration TOP_integration_inst (
	.clock				(clk_de				),
	.reset              (reset         		),
	.ifmap_BRAM_wr_in   (ifmap_BRAM_wr_in   ),
	.ifmap_BRAM_dina_in (ifmap_BRAM_dina_in ),
	//.state				(state_wire			),
	.result             (result             )
);  

// ROM stored ifmap
ROM_ifmap ROM_ifmap_inst (
    .clka	(clk_de			),
	.ena	(ROM_read_en	),
	.addra	(ROM_read_addr 	),
	.douta	(ROM_data_out	)
);


assign ifmap_BRAM_dina_in 	= ROM_data_out;
assign ROM_read_en 			= 'd1;


reg [11:0] wait_count;
reg system_start;
always@(posedge clk_de) begin
	if(reset) begin
		wait_count <= 'd0;
	end
	else begin	
		wait_count <= system_start ? 'd0 : (wait_count + 'd1);
	end
end

always@(posedge clk_de) begin
	if(reset) begin
		system_start <= 'd0;
	end
	else if(wait_count == 'd4095) begin	
		system_start <= 'd1;
	end
end

always@(posedge clk_de) begin
	if(reset) begin
		ROM_read_addr <= 'd0;
	end
	else if(~ROM_read_done & system_start) begin	
		ROM_read_addr <= (ROM_read_addr == 'd783) ? 'd0 : (ROM_read_addr + 'd1);
	end
end

always@(posedge clk_de) begin
	if(reset) begin
		ROM_read_done <= 'd0;
	end
	else if(ROM_read_addr == 'd783 & system_start) begin
		ROM_read_done <= 'd1;
	end
end

always@(posedge clk_de) begin
	if(reset) begin
		ifmap_BRAM_wr_in <= 'd0;
	end
	else if(ROM_read_done & system_start) begin	
		ifmap_BRAM_wr_in <= 'd0;
	end
	else if(system_start) begin	
		ifmap_BRAM_wr_in <= 'd1;
	end
end


endmodule
