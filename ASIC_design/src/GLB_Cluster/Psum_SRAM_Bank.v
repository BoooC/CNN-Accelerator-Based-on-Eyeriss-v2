// ====================================================================================================== //
// This module is psum SRAM.
// psum SRAM module is used to store psum data.
// Use write_count signal to count psum SRAM write in to control psum write.
// write_count's upbound will be determined by input signal PSUM_DEPTH.
// ====================================================================================================== //

module Psum_SRAM_Bank(
	input         				clock,
	input         				reset,
	output        				psum_data_in_ready,
	input         				psum_data_in_valid,
	input 		signed 	[20:0] 	psum_data_in,
	
	input         				psum_data_out_ready,
	output reg       			psum_data_out_valid,
	output reg	signed 	[20:0] 	psum_data_out,
	
	input         				psum_write_en,
	input  				[9:0]  	psum_write_addr,
	output        				psum_write_done,
	
	input         				psum_read_out_en,	// read out to rearrange and do im2col
	input         				psum_read_en,
	input  				[9:0]  	psum_read_addr,
	
	input				[4:0]	PSUM_DEPTH
);

localparam PSUM_SRAM_DEPTH = 512;

reg signed [20:0] Psum_SRAM_Bank [0:PSUM_SRAM_DEPTH-1];
reg [4:0] writeCounter; 

wire  doWriteWire 		= psum_data_in_ready  & psum_data_in_valid; // & psum_write_en
wire  doReadWire  		= psum_data_out_ready & psum_read_en; 
wire  doReadOutWire  	= psum_data_out_ready & psum_read_out_en; 

assign psum_data_in_ready  = psum_write_en; 
assign psum_write_done = (writeCounter == PSUM_DEPTH + 'd1); 


integer i;
// write SRAM
always @(posedge clock) begin
	if(reset) begin
		for(i=0; i<PSUM_SRAM_DEPTH; i=i+1) begin
			Psum_SRAM_Bank[i] <= 21'sd0; 
		end
	end
	if (doWriteWire) begin
		Psum_SRAM_Bank[psum_write_addr] <= psum_data_in; 
	end
end

// read SRAM
always @(posedge clock) begin
	if (doReadWire | doReadOutWire) begin
		psum_data_out <= Psum_SRAM_Bank[psum_read_addr];
	end
end


always @(posedge clock) begin
	if (reset) begin 
		psum_data_out_valid <= 1'd0; 
	end 
	else begin
		psum_data_out_valid <= doReadWire | doReadOutWire; 
	end
end

always @(posedge clock) begin
	if (reset) begin 
		writeCounter <= 5'd0; 
	end 
	else if (psum_write_done) begin 
		writeCounter <= 5'd0;
	end 
	else if (doWriteWire) begin 
		writeCounter <= writeCounter + 5'd1;
	end
end

endmodule
