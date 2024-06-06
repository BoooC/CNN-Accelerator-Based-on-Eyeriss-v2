module TOP_interface (
	input						clock,
	input						reset,
		
	input						system_enable,
	
	input				[7:0]	DRAM_data_in,	// ifmap
			
	output						DRAM_read_en,
	output				[9:0]	DRAM_read_addr,	// 0 ~ 783
	
	output				[3:0]	final_out,		// 0 ~ 9
	output						final_out_valid
);


wire	signed	[7:0]	iact_in;
reg						iact_in_valid;
wire	signed	[7:0]	weight_addr_in;
reg						weight_addr_in_valid;
wire	signed	[12:0]	weight_data_in;
reg						weight_data_in_valid;

wire					MEM_read_en;
wire			[15:0]	MEM_read_addr;

wire			[15:0]	ROM_data_out;	// weight
wire					ROM_read_en;
wire			[15:0]	ROM_read_addr;	// ~40000

// weight end addr LUT
parameter IACT_DATA_END 				= 'd784;

parameter ROM_WEIGHT_ADDR_1_END 		 = 'd7		;
parameter ROM_WEIGHT_DATA_1_END 		 = 'd97 	;
parameter ROM_WEIGHT_ADDR_2_FORMER_END 	 = 'd151 	;
parameter ROM_WEIGHT_DATA_2_FORMER_END 	 = 'd760 	;
parameter ROM_WEIGHT_ADDR_2_LATER_END 	 = 'd814 	;
parameter ROM_WEIGHT_DATA_2_LATER_END 	 = 'd1351 	;
parameter ROM_WEIGHT_ADDR_3_END 		 = 'd9511 	;
parameter ROM_WEIGHT_DATA_3_END 		 = 'd25090 	;
parameter ROM_WEIGHT_ADDR_4_END 		 = 'd27736 	;
parameter ROM_WEIGHT_DATA_4_END 		 = 'd32974 	;
parameter ROM_WEIGHT_ADDR_5_END 		 = 'd33238 	;
parameter ROM_WEIGHT_DATA_5_END 		 = 'd33722 	;


TOP # (
	.WEIGHT_DATA_3_END(ROM_WEIGHT_DATA_3_END + 'd784),
	.WEIGHT_DATA_4_END(ROM_WEIGHT_DATA_4_END + 'd784),
	.WEIGHT_DATA_5_END(ROM_WEIGHT_DATA_5_END + 'd784)
) 
TOP_inst(
	.clock					(clock					),
	.reset                  (reset                  ),
	.iact_in                (iact_in                ),
	.iact_in_valid          (iact_in_valid          ),
	.weight_addr_in         (weight_addr_in         ),
	.weight_addr_in_valid   (weight_addr_in_valid   ),
	.weight_data_in         (weight_data_in         ),
	.weight_data_in_valid   (weight_data_in_valid   ),
	.system_enable          (system_enable          ),
	//.state					(state					),
	.final_out              (final_out              ),
	.final_out_valid        (final_out_valid        ),
	.MEM_read_en           	(MEM_read_en           	),
	.MEM_read_addr		    (MEM_read_addr		    )
);


// ROM stored weights
ROM_sparse_weight ROM_weight_inst (	// ROM_weight, ROM_sparse_weight
    .clka	(clock			),
	.ena	(ROM_read_en	),
	.addra	(ROM_read_addr 	),
	.douta	(ROM_data_out	)
);


wire DRAM_iact_data				= DRAM_read_addr < IACT_DATA_END;

wire ROM_weight_addr_1 			= ROM_read_addr >= 'd0							& ROM_read_addr < ROM_WEIGHT_ADDR_1_END;		// ROM_read_addr >= 'd784 	& ROM_read_addr < 'd791;
wire ROM_weight_data_1 			= ROM_read_addr >= ROM_WEIGHT_ADDR_1_END 		& ROM_read_addr < ROM_WEIGHT_DATA_1_END;		// ROM_read_addr >= 'd791 	& ROM_read_addr < 'd909;
wire ROM_weight_addr_2_former 	= ROM_read_addr >= ROM_WEIGHT_DATA_1_END 		& ROM_read_addr < ROM_WEIGHT_ADDR_2_FORMER_END; // ROM_read_addr >= 'd909 	& ROM_read_addr < 'd963;
wire ROM_weight_data_2_former 	= ROM_read_addr >= ROM_WEIGHT_ADDR_2_FORMER_END & ROM_read_addr < ROM_WEIGHT_DATA_2_FORMER_END; // ROM_read_addr >= 'd963 	& ROM_read_addr < 'd1752;
wire ROM_weight_addr_2_later 	= ROM_read_addr >= ROM_WEIGHT_DATA_2_FORMER_END & ROM_read_addr < ROM_WEIGHT_ADDR_2_LATER_END; 	// ROM_read_addr >= 'd1752 	& ROM_read_addr < 'd1806;
wire ROM_weight_data_2_later 	= ROM_read_addr >= ROM_WEIGHT_ADDR_2_LATER_END 	& ROM_read_addr < ROM_WEIGHT_DATA_2_LATER_END; 	// ROM_read_addr >= 'd1806 	& ROM_read_addr < 'd2597;
wire ROM_weight_addr_3 			= ROM_read_addr >= ROM_WEIGHT_DATA_2_LATER_END 	& ROM_read_addr < ROM_WEIGHT_ADDR_3_END; 		// ROM_read_addr >= 'd2597 	& ROM_read_addr < 'd10757;
wire ROM_weight_data_3 			= ROM_read_addr >= ROM_WEIGHT_ADDR_3_END 		& ROM_read_addr < ROM_WEIGHT_DATA_3_END; 		// ROM_read_addr >= 'd10757 & ROM_read_addr < 'd30619;
wire ROM_weight_addr_4 			= ROM_read_addr >= ROM_WEIGHT_DATA_3_END 		& ROM_read_addr < ROM_WEIGHT_ADDR_4_END; 		// ROM_read_addr >= 'd30619 & ROM_read_addr < 'd33265;
wire ROM_weight_data_4 			= ROM_read_addr >= ROM_WEIGHT_ADDR_4_END 		& ROM_read_addr < ROM_WEIGHT_DATA_4_END; 		// ROM_read_addr >= 'd33265 & ROM_read_addr < 'd39877;
wire ROM_weight_addr_5 			= ROM_read_addr >= ROM_WEIGHT_DATA_4_END 		& ROM_read_addr < ROM_WEIGHT_ADDR_5_END; 		// ROM_read_addr >= 'd39877 & ROM_read_addr < 'd40141;
wire ROM_weight_data_5 			= ROM_read_addr >= ROM_WEIGHT_ADDR_5_END 		& ROM_read_addr < ROM_WEIGHT_DATA_5_END; 		// ROM_read_addr >= 'd40141 & ROM_read_addr < 'd40762;

wire ROM_weight_data_flag = ROM_weight_addr_1 | ROM_weight_addr_2_former | ROM_weight_addr_2_later | ROM_weight_addr_3 | ROM_weight_addr_4 | ROM_weight_addr_5;
wire ROM_weight_addr_flag = ROM_weight_data_1 | ROM_weight_data_2_former | ROM_weight_data_2_later | ROM_weight_data_3 | ROM_weight_data_4 | ROM_weight_data_5;

assign DRAM_read_en 	= MEM_read_en & (MEM_read_addr < IACT_DATA_END);
assign ROM_read_en 		= MEM_read_en & (MEM_read_addr >= IACT_DATA_END);

assign DRAM_read_addr 	= (MEM_read_addr < IACT_DATA_END) 	? MEM_read_addr 				: 'd0;
assign ROM_read_addr 	= (MEM_read_addr >= IACT_DATA_END)	? MEM_read_addr-IACT_DATA_END 	: 'd0;

assign iact_in			= (DRAM_iact_data) 					? DRAM_data_in 		: 'd0;
assign weight_addr_in	= (ROM_weight_data_flag) 			? ROM_data_out[7:0] : 'd0;
assign weight_data_in	= (ROM_weight_addr_flag) 			? ROM_data_out[12:0]: 'd0;


always@(posedge clock) begin
	if(reset)begin
		iact_in_valid <= 'd0;
	end
	else if(DRAM_read_en & DRAM_iact_data)begin
		iact_in_valid <= 'd1;
	end
	else begin
		iact_in_valid <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset)begin
		weight_addr_in_valid <= 'd0;
	end
	else if(ROM_read_en & ROM_weight_data_flag)begin
		weight_addr_in_valid <= 'd1;
	end
	else begin
		weight_addr_in_valid <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset)begin
		weight_data_in_valid <= 'd0;
	end
	else if(ROM_read_en & ROM_weight_addr_flag)begin
		weight_data_in_valid <= 'd1;
	end
	else begin
		weight_data_in_valid <= 'd0;
	end
end


endmodule
