// ====================================================================================================== //
// This module is the psum spad.
// psum spad is used to store the psum data from iact * weight and accumulate with previous psum data.
// 
// psum spad depth is from the depth of th multiplication of former matrix and later matrix.
// In this design the former matrix shape is (8, 25), later matrix shape is (25, 4). Hence, the psum shape is (8, 4) = 32
// The shape of former matrix and later matrix can be scale for custom design.
// 
// The bitwidth of iact data is 8, The bitwidth of weight data is 8, The bitwidth of product from iact and weight is 16, 
// I set the maximum times of accumulation is 6, which is 2 PE cluster requirment
// (one PE cluster contains 3 rows of PE, hence it will be accumulated 6 timees) 
// 
// For FPGA implementation, psum spad uses BRAM to store data.
// ====================================================================================================== //

module Psum_Spad(
	input         			clock,
	input         			reset,
	output        			psum_in_ready,
	input         			psum_in_valid,
	input 	signed 	[20:0] 	psum_in,
	input         			psum_out_ready,
	output        			psum_out_vaild,
	output 	signed 	[20:0] 	psum_out,
	input  			[4:0]  	read_idx,
	input  			[4:0]  	write_idx,
	input					psum_spad_clear
);

localparam SPAD_DEPTH = 32; // (8, 25) * (25, 4) = (8, 4), Matrix shape
localparam SPAD_WIDTH = 21;

reg signed [SPAD_WIDTH:0] Psum_Data_Spad [0:SPAD_DEPTH-1]; 	

wire  data_in_shake = psum_in_ready & psum_in_valid;

assign psum_in_ready 	= ~psum_out_ready; 
assign psum_out_vaild 	= ~psum_in_valid; 
assign psum_out      	= Psum_Data_Spad[read_idx]; 

integer i;
always @(posedge clock) begin
	if (reset) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Psum_Data_Spad[i] <= 21'sd0;
		end
	end
	else if (psum_spad_clear) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Psum_Data_Spad[i] <= 21'sd0;
		end
	end
	else if(data_in_shake) begin
		Psum_Data_Spad[write_idx] <= psum_in;
	end
end
	
endmodule
