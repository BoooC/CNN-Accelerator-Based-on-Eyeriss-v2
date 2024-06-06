`timescale 1ns / 1ps

module TOP_tb();

reg					clock;
reg					reset;

reg	signed	[7:0]	iact_in;
reg					iact_in_valid;

reg	signed	[7:0]	weight_addr_in;
reg					weight_addr_in_valid;
reg	signed	[12:0]	weight_data_in;
reg					weight_data_in_valid;

reg					system_enable;

wire		[3:0]	final_out;			// 0 ~ 9
wire				final_out_valid;
wire		[15:0]	MEM_read_addr;		// weight_in : 44190; iact_in : 784
wire				MEM_read_en;


parameter IACT_DATA_END 			= 'd784;

parameter WEIGHT_ADDR_1_END 		= 'd791;
parameter WEIGHT_DATA_1_END 		= 'd909;
parameter WEIGHT_ADDR_2_FORMER_END 	= 'd963;
parameter WEIGHT_DATA_2_FORMER_END 	= 'd1752;
parameter WEIGHT_ADDR_2_LATER_END 	= 'd1806;
parameter WEIGHT_DATA_2_LATER_END 	= 'd2597;
parameter WEIGHT_ADDR_3_END 		= 'd10757;
parameter WEIGHT_DATA_3_END 		= 'd30619;
parameter WEIGHT_ADDR_4_END 		= 'd33265;
parameter WEIGHT_DATA_4_END 		= 'd39877;
parameter WEIGHT_ADDR_5_END 		= 'd40141;
parameter WEIGHT_DATA_5_END 		= 'd40762;


TOP # (
	.WEIGHT_DATA_3_END(WEIGHT_DATA_3_END),
	.WEIGHT_DATA_4_END(WEIGHT_DATA_4_END),
	.WEIGHT_DATA_5_END(WEIGHT_DATA_5_END)
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
	.final_out	            (final_out	            ),
	.final_out_valid		(final_out_valid		),
	.MEM_read_en			(MEM_read_en			),
	.MEM_read_addr		    (MEM_read_addr		    )
);


// ifmap 						: 0~783
// layer_1 weight addr 			: 784 ~ 790
// layer_1 weight data 			: 791 ~ 908
// layer_2 weight addr former	: 909 ~ 962
// layer_2 weight data formeer	: 963 ~ 1751
// layer_2 weight addr later 	: 1752 ~ 1805
// layer_2 weight data later 	: 1806 ~ 2596

parameter LAYER_0_OUT_DEPTH = 'd864;	// 12*12*6=864
parameter LAYER_1_OUT_DEPTH = 'd256;	// 4*4*16=256
parameter LAYER_2_OUT_DEPTH = 'd120;	
parameter LAYER_3_OUT_DEPTH = 'd84;	
parameter LAYER_4_OUT_DEPTH = 'd10;	


reg	signed	[15:0] 	MEM				[0:50000];	
reg			[7:0] 	layer0_golden	[0:LAYER_0_OUT_DEPTH-1];	
reg			[7:0] 	layer1_golden	[0:LAYER_1_OUT_DEPTH-1];
reg			[7:0] 	layer2_golden	[0:LAYER_2_OUT_DEPTH-1];
reg			[7:0] 	layer3_golden	[0:LAYER_3_OUT_DEPTH-1];
reg	signed	[20:0] 	layer4_golden	[0:LAYER_4_OUT_DEPTH-1];

reg 		[3:0] 	result;

initial begin 	  
	$readmemh("test/tb/TOP_test/layer0/MEM.txt", MEM);
	$readmemh("test/tb/TOP_test/layer0/layer0_golden.txt", layer0_golden);
	$readmemh("test/tb/TOP_test/layer0/layer1_golden.txt", layer1_golden);
	$readmemh("test/tb/TOP_test/layer0/layer2_golden.txt", layer2_golden);
	$readmemh("test/tb/TOP_test/layer0/layer3_golden.txt", layer3_golden);
	$readmemh("test/tb/TOP_test/layer0/layer4_golden.txt", layer4_golden);
end


initial begin
	clock = 'd0;
	reset = 'd0;
	system_enable = 1'b0;
end

always #5 clock = ~clock; 


parameter  IDLE 				= 'd0;
parameter  LAYER0_LOAD_IFMAP 	= 'd1;	// data processing and load GLB
parameter  LAYER0_LOAD_GLB		= 'd2;
parameter  LAYER0_LOAD_PE		= 'd3;
parameter  LAYER0_CAL 			= 'd4;
parameter  LAYER0_PSUM_ACC 		= 'd5;
parameter  LAYER0_READ_OUT_PSUM = 'd6;
parameter  LAYER0_POOLING		= 'd7;
parameter  LAYER0_DONE			= 'd8;
parameter  LAYER1_LOAD_GLB		= 'd9;
parameter  LAYER1_LOAD_PE		= 'd10;
parameter  LAYER1_CAL 			= 'd11;
parameter  LAYER1_PSUM_ACC 		= 'd12;
parameter  LAYER1_READ_OUT_PSUM = 'd13;
parameter  LAYER1_POOLING		= 'd14;
parameter  LAYER1_DONE			= 'd15;
parameter  LAYER2_LOAD_GLB		= 'd16;
parameter  LAYER2_LOAD_PE		= 'd17;
parameter  LAYER2_CAL 			= 'd18;
parameter  LAYER2_PSUM_ACC 		= 'd19;
parameter  LAYER2_READ_OUT_PSUM = 'd20;
parameter  LAYER2_DONE			= 'd21;
parameter  LAYER3_LOAD_GLB		= 'd22;
parameter  LAYER3_LOAD_PE		= 'd23;
parameter  LAYER3_CAL 			= 'd24;
parameter  LAYER3_PSUM_ACC 		= 'd25;
parameter  LAYER3_READ_OUT_PSUM = 'd26;
parameter  LAYER3_DONE			= 'd27;
parameter  LAYER4_LOAD_GLB		= 'd28;
parameter  LAYER4_LOAD_PE		= 'd29;
parameter  LAYER4_CAL 			= 'd30;
parameter  LAYER4_PSUM_ACC 		= 'd31;
parameter  LAYER4_READ_OUT_PSUM = 'd32;
parameter  LAYER4_DONE			= 'd33;
parameter  DONE					= 'd63;


integer L0_CAL_CYCLES 	= 0;
integer L1_CAL_CYCLES 	= 0;
integer L2_CAL_CYCLES 	= 0;
integer L3_CAL_CYCLES 	= 0;
integer L4_CAL_CYCLES 	= 0;
integer L0_LOAD_CYCLES 	= 0;
integer L1_LOAD_CYCLES 	= 0;
integer L2_LOAD_CYCLES 	= 0;
integer L3_LOAD_CYCLES 	= 0;
integer L4_LOAD_CYCLES 	= 0;
integer TOTAL_CYCLES	= 0;

wire [20:0] TOTAL_CAL_CYCLES	= L0_CAL_CYCLES  + L1_CAL_CYCLES  + L2_CAL_CYCLES  + L3_CAL_CYCLES  + L4_CAL_CYCLES;
wire [20:0] TOTAL_LOAD_CYCLES	= L0_LOAD_CYCLES + L1_LOAD_CYCLES + L2_LOAD_CYCLES + L3_LOAD_CYCLES + L4_LOAD_CYCLES;

integer layer0_idx = 0;
integer layer1_idx = 0;
integer layer2_idx = 0;
integer layer3_idx = 0;
integer layer4_idx = 0;


integer layer0_error = 0;
integer layer1_error = 0;
integer layer2_error = 0;
integer layer3_error = 0;
integer layer4_error = 0;

initial begin
	repeat(1)@(posedge clock); reset = 1'b1;
	repeat(1)@(posedge clock); reset = 1'b0;
	repeat(1)@(posedge clock); system_enable = 1'b1;
	repeat(1)@(posedge clock); system_enable = 1'b0;
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Start layer 0 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("=======================================================");
	$display("==================== Start layer 0 ====================");
	$display("=======================================================");
	repeat(3)@(posedge clock);
	wait(TOP_inst.TOP_controller.state == LAYER0_LOAD_IFMAP);
	$display("------------- Start to load ifmap         -------------");	wait(TOP_inst.TOP_controller.state == LAYER0_LOAD_GLB);
	$display("------------- Load ifmap finish           -------------");	wait(TOP_inst.TOP_controller.state == LAYER0_LOAD_PE);
	$display("------------- Start to load PE            -------------");	wait(TOP_inst.TOP_controller.state == LAYER0_CAL);
	$display("------------- PE calculation start        -------------");	wait(TOP_inst.TOP_controller.state == LAYER0_READ_OUT_PSUM);
	$display("------------- PE all calculation finish   -------------");	wait(TOP_inst.TOP_controller.state == LAYER0_POOLING);		
	$display("------------- Layer 0 ReLU & pooling      -------------");
	/*
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Check layer 0 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	wait(TOP_inst.TOP_controller.state == LAYER0_DONE);			
	$display("------------- Layer 0 finish              -------------");
	$display("-------------------------------------------------------");
	for (layer0_idx = 0; layer0_idx <= LAYER_0_OUT_DEPTH-1; layer0_idx = layer0_idx + 1) begin
		if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer0_idx] != layer0_golden[layer0_idx]) begin
			$display("Rearrange_Buffer[%3d]: %3d, The golden value[%3d]: %3d", layer0_idx, TOP_inst.psum_rearrange.Rearrange_Buffer[layer0_idx], layer0_idx, layer0_golden[layer0_idx]);
			// The maximun error allowable range is 2
			if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer0_idx] - layer0_golden[layer0_idx] > 2 & TOP_inst.psum_rearrange.Rearrange_Buffer[layer0_idx] - layer0_golden[layer0_idx] < -2) begin
				layer0_error = layer0_error + 1;
			end
		end
	end
	if(layer0_error == 0) begin
		$display("=======================================================");
		$display("============= Simulation pass in layer 0 ==============");
		$display("=======================================================");
	end
	else begin
		$display("-------------------------------------------------------");
		$display("---------- The total error in layer 0 : %3d -----------", layer0_error);
		$display("-------------------------------------------------------");
	end
	*/
	$display("\n");
	
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Start layer 1 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("=======================================================");
	$display("-------------------- Start layer 1 --------------------");
	$display("=======================================================");	wait(TOP_inst.TOP_controller.state == LAYER1_LOAD_GLB); 	
	$display("------------- Start to load iact & weight -------------");	wait(TOP_inst.TOP_controller.state == LAYER1_LOAD_PE); 		
	$display("------------- Start to load PE            -------------");	wait(TOP_inst.TOP_controller.state == LAYER1_CAL); 			
	$display("------------- PE calculation start        -------------");	wait(TOP_inst.TOP_controller.state == LAYER1_READ_OUT_PSUM);
	$display("------------- PE all calculation finish   -------------");	wait(TOP_inst.TOP_controller.state == LAYER1_POOLING);		
	$display("------------- Layer 1 ReLU & pooling      -------------");
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= check layer 1 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	wait(TOP_inst.TOP_controller.state == LAYER1_DONE);			
	$display("------------- Layer 1 finish              -------------");
	$display("-------------------------------------------------------");
	/*
	for (layer1_idx = 0; layer1_idx <= LAYER_1_OUT_DEPTH-1; layer1_idx = layer1_idx + 1) begin
		if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer1_idx] != layer1_golden[layer1_idx]) begin
			$display("Rearrange_Buffer[%3d]: %3d, The golden value[%3d]: %3d", layer1_idx, TOP_inst.psum_rearrange.Rearrange_Buffer[layer1_idx], layer1_idx, layer1_golden[layer1_idx]);
			// The maximun error allowable range is 2
			if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer1_idx] - layer1_golden[layer1_idx] > 2 & TOP_inst.psum_rearrange.Rearrange_Buffer[layer1_idx] - layer1_golden[layer1_idx] < -2) begin
				layer1_error = layer1_error + 1;
			end
		end
	end
	if(layer1_error == 0) begin
		$display("=======================================================");
		$display("============= Simulation pass in layer 1 ==============");
		$display("=======================================================");
	end
	else begin
		$display("-------------------------------------------------------");
		$display("---------- The total error in layer 1 : %3d -----------", layer1_error);
		$display("-------------------------------------------------------");
	end
	*/
	$display("\n");
	
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Start layer 2 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("=======================================================");
	$display("-------------------- Start layer 2 --------------------");
	$display("=======================================================");	wait(TOP_inst.TOP_controller.state == LAYER2_LOAD_GLB); 	
	$display("------------- Start to load iact & weight -------------");	wait(TOP_inst.TOP_controller.state == LAYER2_LOAD_PE); 		
	$display("------------- Start to load PE            -------------");	wait(TOP_inst.TOP_controller.state == LAYER2_CAL); 			
	$display("------------- PE calculation start        -------------");	wait(TOP_inst.TOP_controller.state == LAYER2_READ_OUT_PSUM);
	$display("------------- PE all calculation finish   -------------");	
	$display("------------- Layer 2 ReLU                -------------");	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= check layer 2 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	wait(TOP_inst.TOP_controller.state == LAYER2_DONE);			
	repeat(4)@(posedge clock);
	$display("------------- Layer 2 finish              -------------");
	$display("-------------------------------------------------------");
	/*
	for (layer2_idx = 0; layer2_idx <= LAYER_2_OUT_DEPTH-1; layer2_idx = layer2_idx + 1) begin
		if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer2_idx] != layer2_golden[layer2_idx]) begin
			$display("Rearrange_Buffer[%3d]: %3d, The golden value[%3d]: %3d", layer2_idx, TOP_inst.psum_rearrange.Rearrange_Buffer[layer2_idx], layer2_idx, layer2_golden[layer2_idx]);
			// The maximun error allowable range is 2
			if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer2_idx] - layer2_golden[layer2_idx] > 2 & TOP_inst.psum_rearrange.Rearrange_Buffer[layer2_idx] - layer2_golden[layer2_idx] < -2) begin
				layer2_error = layer2_error + 1;
			end
		end
	end
	if(layer2_error == 0) begin
		$display("=======================================================");
		$display("============= Simulation pass in layer 2 ==============");
		$display("=======================================================");
	end
	else begin
		$display("-------------------------------------------------------");
		$display("---------- The total error in layer 2 : %3d -----------", layer2_error);
		$display("-------------------------------------------------------");
	end
	*/
	$display("\n");
	
	
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Start layer 3 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("=======================================================");
	$display("-------------------- Start layer 3 --------------------");
	$display("=======================================================");	wait(TOP_inst.TOP_controller.state == LAYER3_LOAD_GLB); 	
	$display("------------- Start to load iact & weight -------------");	wait(TOP_inst.TOP_controller.state == LAYER3_LOAD_PE); 		
	$display("------------- Start to load PE            -------------");	wait(TOP_inst.TOP_controller.state == LAYER3_CAL); 			
	$display("------------- PE calculation start        -------------");	wait(TOP_inst.TOP_controller.state == LAYER3_READ_OUT_PSUM);
	$display("------------- PE all calculation finish   -------------");	
	$display("------------- Layer 3 ReLU                -------------");	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= check layer 3 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	wait(TOP_inst.TOP_controller.state == LAYER3_DONE);			
	repeat(4)@(posedge clock);
	/*
	$display("------------- Layer 3 finish              -------------");
	$display("-------------------------------------------------------");
	for (layer3_idx = 0; layer3_idx <= LAYER_3_OUT_DEPTH-1; layer3_idx = layer3_idx + 1) begin
		if(TOP_inst.psum_rearrange.Rearrange_Buffer[layer3_idx] != layer3_golden[layer3_idx]) begin
			$display("Rearrange_Buffer[%3d]: %3d, The golden value[%3d]: %3d", layer3_idx, TOP_inst.psum_rearrange.Rearrange_Buffer[layer3_idx], layer3_idx, layer3_golden[layer3_idx]);
			layer3_error = layer3_error + 1;
		end
	end
	if(layer3_error == 0) begin
		$display("=======================================================");
		$display("============= Simulation pass in layer 3 ==============");
		$display("=======================================================");
	end
	else begin
		$display("-------------------------------------------------------");
		$display("---------- The total error in layer 3 : %3d -----------", layer3_error);
		$display("-------------------------------------------------------");
	end
	*/
	$display("\n");
	
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= Start layer 4 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("=======================================================");
	$display("-------------------- Start layer 4 --------------------");
	$display("=======================================================");	wait(TOP_inst.TOP_controller.state == LAYER4_LOAD_GLB); 	
	$display("------------- Start to load iact & weight -------------");	wait(TOP_inst.TOP_controller.state == LAYER4_LOAD_PE); 		
	$display("------------- Start to load PE            -------------");	wait(TOP_inst.TOP_controller.state == LAYER4_CAL); 			
	$display("------------- PE calculation start        -------------");	wait(TOP_inst.TOP_controller.state == LAYER4_READ_OUT_PSUM);
	$display("------------- PE all calculation finish   -------------");	
	$display("------------- Layer 4 softmax             -------------");	
	/*
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ======================================================= check layer 4 ======================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	*/
	wait(TOP_inst.softmax.data_in_valid);	
	/*
	for (layer4_idx = 0; layer4_idx <= LAYER_4_OUT_DEPTH-1; layer4_idx = layer4_idx + 1) begin
		#1
		$display("Softmax_Buffer[%3d]: %3d", layer4_idx, TOP_inst.softmax.data_in);
		repeat(1)@(posedge clock);
	end
	*/
	/*	
	for (layer4_idx = 0; layer4_idx <= LAYER_4_OUT_DEPTH-1; layer4_idx = layer4_idx + 1) begin
		#1
		if(TOP_inst.softmax.data_in != layer4_golden[layer4_idx]) begin
			$display("Softmax_Buffer[%3d]: %3d, The golden value[%3d]: %3d", layer4_idx, TOP_inst.softmax.data_in, layer4_idx, layer4_golden[layer4_idx]);
			layer4_error = layer4_error + 1;
		end
		repeat(1)@(posedge clock);
	end
	$display("------------- Layer 4 finish              -------------");
	$display("-------------------------------------------------------");
	if(layer4_error == 0) begin
		$display("=======================================================");
		$display("============= Simulation pass in layer 4 ==============");
		$display("=======================================================");
	end
	else begin
		$display("-------------------------------------------------------");
		$display("---------- The total error in layer 4 : %3d -----------", layer4_error);
		$display("-------------------------------------------------------");
	end
	*/
	
	repeat(3)@(posedge clock);
	$display("\n");
	
	// ------------------------------------------------------------------------------------------------------------------------------ //
	// ========================================================== SUMMARY =========================================================== //
	// ------------------------------------------------------------------------------------------------------------------------------ //
	$display("======================= summary =======================");
	$display("----- The load GLB    cycles for layer 0 : %5d ------", L0_LOAD_CYCLES);
	$display("----- The load GLB    cycles for layer 1 : %5d ------", L1_LOAD_CYCLES);
	$display("----- The load GLB    cycles for layer 2 : %5d ------", L2_LOAD_CYCLES);
	$display("----- The load GLB    cycles for layer 3 : %5d ------", L3_LOAD_CYCLES);
	$display("----- The load GLB    cycles for layer 4 : %5d ------", L4_LOAD_CYCLES);
	$display("-------------------------------------------------------");
	$display("----- The calculation cycles for layer 0 : %5d ------", L0_CAL_CYCLES);
	$display("----- The calculation cycles for layer 1 : %5d ------", L1_CAL_CYCLES);
	$display("----- The calculation cycles for layer 2 : %5d ------", L2_CAL_CYCLES);
	$display("----- The calculation cycles for layer 3 : %5d ------", L3_CAL_CYCLES);
	$display("----- The calculation cycles for layer 4 : %5d ------", L4_CAL_CYCLES);
	$display("-------------------------------------------------------");
	$display("----- The total load GLB cycles          : %5d ------", TOTAL_LOAD_CYCLES);
	$display("----- The total calculation cycles       : %5d ------", TOTAL_CAL_CYCLES);
	$display("----- The total cycles                   : %5d -----",  TOTAL_CYCLES);
	$display("-------------------------------------------------------");
	$display("----- The load GLB    cycles ratio       : 0.%2d -------", TOTAL_LOAD_CYCLES*100 / TOTAL_CYCLES);
	$display("----- The calculation cycles ratio       : 0.%2d -------", TOTAL_CAL_CYCLES *100 / TOTAL_CYCLES);
	$display("-------------------------------------------------------");
	$display("----- The throughput for calculation     : %3d GOPS ---", 8*28164*2*2/TOTAL_CAL_CYCLES);	// 8*281640*2*200/1000/TOTAL_CAL_CYCLES
	
	$display("=======================================================");
	$display("\n");
	
	$display("---------- The inference result is : %1d -----------", result);
	$display("\n");
	
	wait(TOP_inst.TOP_controller.state == DONE);
	
	repeat(10)@(posedge clock);	
	$stop;
end


always@(posedge clock) begin
	if(reset) begin
		iact_in 		<= 'd0;
		iact_in_valid	<= 'd0;
	end
	else if(MEM_read_en & MEM_read_addr < 'd784)begin
		iact_in <= MEM[MEM_read_addr];
		iact_in_valid	<= 'd1;
	end
	else begin
		iact_in 		<= 'd0;
		iact_in_valid	<= 'd0;
	end
end



wire MEM_weight_addr_1 			= MEM_read_addr >= IACT_DATA_END 			& MEM_read_addr < WEIGHT_ADDR_1_END;
wire MEM_weight_data_1 			= MEM_read_addr >= WEIGHT_ADDR_1_END 		& MEM_read_addr < WEIGHT_DATA_1_END; 		
wire MEM_weight_addr_2_former 	= MEM_read_addr >= WEIGHT_DATA_1_END 		& MEM_read_addr < WEIGHT_ADDR_2_FORMER_END; 	
wire MEM_weight_data_2_former 	= MEM_read_addr >= WEIGHT_ADDR_2_FORMER_END	& MEM_read_addr < WEIGHT_DATA_2_FORMER_END; 	
wire MEM_weight_addr_2_later 	= MEM_read_addr >= WEIGHT_DATA_2_FORMER_END	& MEM_read_addr < WEIGHT_ADDR_2_LATER_END; 	
wire MEM_weight_data_2_later 	= MEM_read_addr >= WEIGHT_ADDR_2_LATER_END 	& MEM_read_addr < WEIGHT_DATA_2_LATER_END; 	
wire MEM_weight_addr_3 			= MEM_read_addr >= WEIGHT_DATA_2_LATER_END 	& MEM_read_addr < WEIGHT_ADDR_3_END; 		
wire MEM_weight_data_3 			= MEM_read_addr >= WEIGHT_ADDR_3_END 		& MEM_read_addr < WEIGHT_DATA_3_END; 		
wire MEM_weight_addr_4 			= MEM_read_addr >= WEIGHT_DATA_3_END 		& MEM_read_addr < WEIGHT_ADDR_4_END; 		
wire MEM_weight_data_4 			= MEM_read_addr >= WEIGHT_ADDR_4_END 		& MEM_read_addr < WEIGHT_DATA_4_END; 		
wire MEM_weight_addr_5 			= MEM_read_addr >= WEIGHT_DATA_4_END 		& MEM_read_addr < WEIGHT_ADDR_5_END; 		
wire MEM_weight_data_5 			= MEM_read_addr >= WEIGHT_ADDR_5_END 		& MEM_read_addr < WEIGHT_DATA_5_END; 		

always@(posedge clock) begin
	if(reset) begin
		weight_addr_in 			<= 'd0;
		weight_addr_in_valid	<= 'd0;
	end
	else if(MEM_read_en & (MEM_weight_addr_1 | MEM_weight_addr_2_former | MEM_weight_addr_2_later | MEM_weight_addr_3 | MEM_weight_addr_4 | MEM_weight_addr_5))begin
		weight_addr_in 			<= MEM[MEM_read_addr];
		weight_addr_in_valid	<= 'd1;
	end
	else begin
		weight_addr_in 			<= 'd0;
		weight_addr_in_valid	<= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		weight_data_in 			<= 'd0;
		weight_data_in_valid	<= 'd0;
	end
	else if(MEM_read_en & (MEM_weight_data_1 | MEM_weight_data_2_former | MEM_weight_data_2_later | MEM_weight_data_3 | MEM_weight_data_4 | MEM_weight_data_5))begin
		weight_data_in 			<= MEM[MEM_read_addr];
		weight_data_in_valid	<= 'd1;
	end
	else begin
		weight_data_in 			<= 'd0;
		weight_data_in_valid	<= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		result <= 'd0;
	end
	else if(final_out_valid)begin
		result <= final_out;
	end
end


always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER0_CAL) begin
		L0_CAL_CYCLES = L0_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER1_CAL) begin
		L1_CAL_CYCLES = L1_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER2_CAL) begin
		L2_CAL_CYCLES = L2_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER3_CAL) begin
		L3_CAL_CYCLES = L3_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER4_CAL) begin
		L4_CAL_CYCLES = L4_CAL_CYCLES + 1;
	end
end


always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER0_LOAD_GLB) begin
		L0_LOAD_CYCLES = L0_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER1_LOAD_GLB) begin
		L1_LOAD_CYCLES = L1_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER2_LOAD_GLB) begin
		L2_LOAD_CYCLES = L2_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER3_LOAD_GLB) begin
		L3_LOAD_CYCLES = L3_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_inst.TOP_controller.state == LAYER4_LOAD_GLB) begin
		L4_LOAD_CYCLES = L4_LOAD_CYCLES + 1;
	end
end


always@(posedge clock) begin
	TOTAL_CYCLES = TOTAL_CYCLES + 1;
end



endmodule
