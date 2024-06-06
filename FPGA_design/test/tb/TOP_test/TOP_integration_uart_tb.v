`timescale 1ns / 1ps
`define CYCLE      10.0 
`define END_CYCLE  500_0000

`define DRAM_PAT	"test/tb/TOP_test/MEM/DRAM.txt"
`define GOLDEN_PAT	"test/tb/TOP_test/MEM/GOLDEN.txt"

module TOP_integration_uart_tb();

reg 			clock;
reg 			reset;
reg				rx_pin_in;
wire	[3:0]	result;

TOP_integration_uart TOP_integration_uart_inst (
	.clock		(clock		),
	.reset      (reset      ),
	.rx_pin_in  (rx_pin_in  ),
	.result     (result     )
);

reg [5:0] clk_count=0;
wire clk_de = clk_count[4];
always@(posedge clock) begin
	clk_count <= clk_count + 'd1;
end

parameter SYS_RATE 		= 125_00_0000; // 125 MHz
parameter BAND_RATE		= 115200;
parameter CNT_BAND 		= SYS_RATE / BAND_RATE;
parameter HALF_CNT_BAND = CNT_BAND / 2;


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
	clock 		= 'd0;
	reset 		= 'd0;
	rx_pin_in 	= 'd1;
end

always #5 clock = ~clock; 


integer i, j;
reg [7:0] dram_data_in;
initial begin
	for(test_iter=0; test_iter<test_iters; test_iter=test_iter+1) begin
		repeat(300)@(posedge clk_de); reset = 1'b1;
		repeat(300)@(posedge clk_de); reset = 1'b0;
		
		for(i=0; i<784; i=i+1) begin
			dram_data_in = DRAM[i + test_iter*784];
			repeat(CNT_BAND)@(posedge clk_de);
			// start
			#2 rx_pin_in = 'd0;	
			repeat(CNT_BAND)@(posedge clk_de);
			// 8-bit data
			for(j=0; j<8; j=j+1) begin
				#2 
				rx_pin_in = DRAM[i + test_iter*784][j];
				repeat(CNT_BAND)@(posedge clk_de);
			end
			// end
			#2 
			rx_pin_in = 'd1;	
		end
		
		wait(TOP_integration_uart_inst.final_out_valid);
		repeat(2)@(posedge clk_de);	
		$display("Iter :%3d. The inference result is : %1d,    The golden result is: %1d", test_iter, result, GOLDEN[test_iter]);
		if(result != GOLDEN[test_iter]) begin
			$display("Error! At instance : %3d", test_iter);
			test_error = test_error + 1;
		end
		
		repeat(1000)@(posedge clk_de);	
	end
	$display("\n");
	$display("There are %3d errors in %3d test patterns", test_error, test_iters);
	$display("\n");
	repeat(10)@(posedge clk_de);	
	$stop;
end


reg [31:0] CYCLES;
always@(posedge clk_de) begin
	if(reset) begin
		CYCLES <= 'd0;
	end
	else begin
		CYCLES <= CYCLES + 'd1;
	end
end


always@(posedge clk_de) begin
	if(CYCLES > `END_CYCLE) begin
		$display("-----------------------------------------------------");
		$display("Error!!! The simulation can't be terminated under normal operation!");
		$display("-------------------------FAIL------------------------");
		$display("-----------------------------------------------------");
		$stop;
	end
end


endmodule
