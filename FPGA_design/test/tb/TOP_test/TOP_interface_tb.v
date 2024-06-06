`timescale 1ns / 1ps
`define CYCLE      10.0 
`define END_CYCLE  200000

`define DRAM_PAT	"test/tb/TOP_test/MEM/DRAM.txt"
`define ROM_PAT		"test/tb/TOP_test/MEM/ROM.txt"
`define GOLDEN_PAT	"test/tb/TOP_test/MEM/GOLDEN.txt"

module TOP_interface_tb();

reg				clock;
reg				reset;

reg		[7:0]	DRAM_data_in;	// ifmap

reg				system_enable;

wire	[3:0]	final_out;		// 0 ~ 9
wire			final_out_valid;

wire			DRAM_read_en;
wire	[9:0]	DRAM_read_addr;	// 0 ~ 783


TOP_interface TOP_interface_inst (
	.clock			(clock			),
	.reset          (reset          ),
	.DRAM_data_in   (DRAM_data_in   ),
	.system_enable  (system_enable  ),
	.final_out      (final_out      ),
	.final_out_valid(final_out_valid),
	.DRAM_read_en   (DRAM_read_en   ),
	.DRAM_read_addr (DRAM_read_addr )
);


parameter LAYER_0_OUT_DEPTH = 'd864;	// 12*12*6=864
parameter LAYER_1_OUT_DEPTH = 'd256;	// 4*4*16=256
parameter LAYER_2_OUT_DEPTH = 'd120;	
parameter LAYER_3_OUT_DEPTH = 'd84;	
parameter LAYER_4_OUT_DEPTH = 'd10;	

parameter 	test_iters	= 1000;
integer 	test_error 	= 0;
integer 	test_iter;

reg	signed	[7:0] 	DRAM	[0:784*test_iters-1];// for ifmap
// reg	signed	[15:0] 	ROM		[0:50000];			// for weight
reg			[3:0] 	GOLDEN	[0:test_iters-1];	// for weight

reg 		[3:0] 	result;

initial begin 	  
	$readmemh(`DRAM_PAT		, DRAM);
	//$readmemh(`ROM_PAT		, ROM);
	$readmemh(`GOLDEN_PAT	, GOLDEN);
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

integer accuracy;
integer fraction;
initial begin
	for(test_iter=0; test_iter<test_iters; test_iter=test_iter+1) begin
		repeat(1)@(posedge clock); reset = 1'b1;
		repeat(1)@(posedge clock); reset = 1'b0;
		repeat(1)@(posedge clock); system_enable = 1'b1;
		repeat(1)@(posedge clock); system_enable = 1'b0;
		/*
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= Start layer 0 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		$display("=======================================================");
		$display("==================== Start layer 0 ====================");
		$display("=======================================================");
		repeat(3)@(posedge clock);
		wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_LOAD_IFMAP);
		$display("------------- Start to load ifmap         -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_LOAD_GLB);
		$display("------------- Load ifmap finish           -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_LOAD_PE);
		$display("------------- Start to load PE            -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_CAL);
		$display("------------- PE calculation start        -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_READ_OUT_PSUM);
		$display("------------- Layer 0 ReLU                -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_POOLING);		
		$display("------------- Layer 0 ReLU & pooling      -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_DONE);			
		$display("------------- Layer 0 finish              -------------");
		$display("-------------------------------------------------------");
		$display("\n");
		
		
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= Start layer 1 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		$display("=======================================================");
		$display("-------------------- Start layer 1 --------------------");
		$display("=======================================================");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_LOAD_GLB); 	
		$display("------------- Start to load iact & weight -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_LOAD_PE); 		
		$display("------------- Start to load PE            -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_CAL); 			
		$display("------------- PE calculation start        -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_READ_OUT_PSUM);
		$display("------------- Layer 1 ReLU                -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_POOLING);		
		$display("------------- Layer 1 ReLU & pooling      -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_DONE);			
		$display("------------- Layer 1 finish              -------------");
		$display("-------------------------------------------------------");
		$display("\n");
		
		
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= Start layer 2 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		$display("=======================================================");
		$display("-------------------- Start layer 2 --------------------");
		$display("=======================================================");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_LOAD_GLB); 	
		$display("------------- Start to load iact & weight -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_LOAD_PE); 		
		$display("------------- Start to load PE            -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_CAL); 			
		$display("------------- PE calculation start        -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_READ_OUT_PSUM);
		$display("------------- Layer 2 ReLU                -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_DONE);			
		$display("------------- Layer 2 finish              -------------");
		$display("-------------------------------------------------------");
		$display("\n");
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= Start layer 3 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		$display("=======================================================");
		$display("-------------------- Start layer 3 --------------------");
		$display("=======================================================");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_LOAD_GLB); 	
		$display("------------- Start to load iact & weight -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_LOAD_PE); 		
		$display("------------- Start to load PE            -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_CAL); 			
		$display("------------- PE calculation start        -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_READ_OUT_PSUM);
		$display("------------- Layer 3 ReLU                -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_DONE);			
		$display("------------- Layer 3 finish              -------------");
		$display("-------------------------------------------------------");
		$display("\n");
		
		
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= Start layer 4 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		$display("=======================================================");
		$display("-------------------- Start layer 4 --------------------");
		$display("=======================================================");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_LOAD_GLB); 	
		$display("------------- Start to load iact & weight -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_LOAD_PE); 		
		$display("------------- Start to load PE            -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_CAL); 			
		$display("------------- PE calculation start        -------------");	wait(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_READ_OUT_PSUM);
		$display("------------- PE all calculation finish   -------------");	
		$display("------------- Layer 4 softmax             -------------");	
		$display("-------------------------------------------------------");
		$display("\n");
		// ------------------------------------------------------------------------------------------------------------------------------ //
		// ======================================================= check layer 4 ======================================================== //
		// ------------------------------------------------------------------------------------------------------------------------------ //
		wait(TOP_interface_inst.TOP_inst.softmax.data_in_valid);	
		
		for (layer4_idx = 0; layer4_idx <= LAYER_4_OUT_DEPTH-1; layer4_idx = layer4_idx + 1) begin
			#1
			$display("Softmax_Buffer[%3d]: %3d", layer4_idx, TOP_interface_inst.TOP_inst.softmax.data_in);
			repeat(1)@(posedge clock);
		end
		
		
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
		*/
		wait(final_out_valid);
		$display("Iter :%3d. The inference result is : %1d,    The golden result is: %1d", test_iter, final_out, GOLDEN[test_iter]);
		if(final_out != GOLDEN[test_iter]) begin
			$display("Error! At instance : %3d", test_iter);
			test_error = test_error + 1;
		end
		// $display("---------- The inference result is : %1d -----------", final_out);
		// $display("\n");
		
	end
	accuracy = (test_iters-test_error)*100/test_iters;
	fraction = (test_iters-test_error)*100%test_iters;
	$display("\n");
	$display("There are %3d errors in %3d test patterns", test_error, test_iters);
	$display("The accuracy is %2d.%1d percent", accuracy, fraction);
	$display("\n");
	repeat(10)@(posedge clock);	
	$stop;
end


wire [20:0]	DRAM_read_iters_addr = DRAM_read_addr + test_iter*784;
always@(posedge clock) begin
	if(reset) begin
		DRAM_data_in <= 'd0;
	end
	else if(DRAM_read_en)begin
		DRAM_data_in <= DRAM[DRAM_read_iters_addr];
	end
	else begin
		DRAM_data_in <= 'd0;
	end
end



reg [20:0] CYCLES;
always@(posedge clock) begin
	if(reset) begin
		CYCLES <= 'd0;
	end
	else begin
		CYCLES <= CYCLES + 'd1;
	end
end

always@(posedge clock) begin
	if(CYCLES > `END_CYCLE) begin
		$display("-----------------------------------------------------");
		$display("Error!!! The simulation can't be terminated under normal operation!");
		$display("-------------------------FAIL------------------------");
		$display("-----------------------------------------------------");
		$stop;
	end
end


/*
always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_CAL) begin
		L0_CAL_CYCLES = L0_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_CAL) begin
		L1_CAL_CYCLES = L1_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_CAL) begin
		L2_CAL_CYCLES = L2_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_CAL) begin
		L3_CAL_CYCLES = L3_CAL_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_CAL) begin
		L4_CAL_CYCLES = L4_CAL_CYCLES + 1;
	end
end


always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER0_LOAD_GLB) begin
		L0_LOAD_CYCLES = L0_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER1_LOAD_GLB) begin
		L1_LOAD_CYCLES = L1_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER2_LOAD_GLB) begin
		L2_LOAD_CYCLES = L2_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER3_LOAD_GLB) begin
		L3_LOAD_CYCLES = L3_LOAD_CYCLES + 1;
	end
end

always@(posedge clock) begin
	if(TOP_interface_inst.TOP_inst.TOP_controller.state == LAYER4_LOAD_GLB) begin
		L4_LOAD_CYCLES = L4_LOAD_CYCLES + 1;
	end
end


always@(posedge clock) begin
	TOTAL_CYCLES = TOTAL_CYCLES + 1;
end
*/


endmodule
