`timescale 1ns / 1ps
`define CYCLE      10.0 
`define END_CYCLE  200000

`define DRAM_PAT	"C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/DRAM.txt"
`define GOLDEN_PAT	"C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/GOLDEN.txt"

module TOP_integration_tb();

reg 			clock;
reg 			reset;

reg				ifmap_BRAM_wr_in;
reg		[7:0]	ifmap_BRAM_dina_in;

wire 	[3:0]	result;

wire			one_pattern_end_flag = TOP_integration_inst.TOP_interface_inst.TOP_inst.TOP_controller.state == 'd63;

TOP_integration TOP_integration_inst(
	.clock				(clock				),
	.reset              (reset              ),
	.ifmap_BRAM_wr_in   (ifmap_BRAM_wr_in   ),
	.ifmap_BRAM_dina_in (ifmap_BRAM_dina_in ),
	.result				(result				)
);


parameter 	test_iters	= 1000;
integer 	test_error 	= 0;
integer 	test_iter;

reg	signed	[7:0] 	DRAM	[0:784*test_iters-1];	// for ifmap
reg			[3:0] 	GOLDEN	[0:test_iters-1];		// labels

initial begin 	  
	$readmemh(`DRAM_PAT		, DRAM);
	$readmemh(`GOLDEN_PAT	, GOLDEN);
end

initial begin
	clock = 'd0;
	reset = 'd0;
end

always #5 clock = ~clock; 

integer i;
integer accuracy = 0;
integer fraction = 0;
initial begin
	for(test_iter=0; test_iter<test_iters; test_iter=test_iter+1) begin
		repeat(3)@(posedge clock); reset = 1'b1;
		repeat(3)@(posedge clock); reset = 1'b0;
		
		repeat(4096)@(posedge clock);
		for(i=0; i<784; i=i+1) begin
			ifmap_BRAM_wr_in = 'd1;
			ifmap_BRAM_dina_in = DRAM[i + test_iter*784];
			@(posedge clock);
			ifmap_BRAM_wr_in = 'd0;
			
			//repeat(8)@(posedge clock);
		end
		
		wait(TOP_integration_inst.final_out_valid);
		repeat(2)@(posedge clock);	
		$display("Iter :%3d. The inference result is : %1d,    The golden result is: %1d", test_iter, result, GOLDEN[test_iter]);
		if(result != GOLDEN[test_iter]) begin
			$display("Error! At instance : %3d", test_iter);
			test_error = test_error + 1;
		end
		
		repeat(100)@(posedge clock);	
	end
	$display("\n");
	$display("There are %3d errors in %3d test patterns", test_error, test_iters);
	$display("The accuracy is %2d.%1d percent", accuracy, fraction);
	$display("\n");
	repeat(10)@(posedge clock);	
	$stop;
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

real accuracy_temp;
always @(posedge clock) begin
    if (one_pattern_end_flag) begin
		accuracy_temp = ((test_iters - test_error) * 100.0) / test_iters;
        accuracy = accuracy_temp; 
        fraction = ((test_iters - test_error) * 100) % 100; 
        if (fraction < 0) begin
            fraction = -fraction;
        end
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


endmodule
