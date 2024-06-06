// ====================================================================================================== //
// This module is psum_rearrange buffer.
// psum_rearrange is only used to store data from psum SRAM bank to rearrange.
// The data in this buffer is ifmap of the next layer.
// ====================================================================================================== //

module psum_rearrange(
	input        			clock,
	input        			reset,	
	
	input  	 				write_en,
	input			[11:0]	write_addr,
	input	signed	[7:0] 	data_in,
	input        			data_in_valid,
	
	input			[11:0] 	read_addr,
	output	signed 	[7:0] 	data_out
);

localparam BUFFER_DEPTH = 3500;	// 576*6=3456

reg signed	[7:0] Rearrange_Buffer [0:BUFFER_DEPTH-1];


assign data_out = Rearrange_Buffer[read_addr];

integer i;
always @(posedge clock) begin
	if (reset) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			Rearrange_Buffer[i] <= 7'sd0;
		end
	end
	else if(write_en & data_in_valid) begin
		Rearrange_Buffer[write_addr] <= data_in;
	end
end


endmodule
