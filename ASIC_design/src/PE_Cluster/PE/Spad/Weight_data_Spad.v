// ====================================================================================================== //
// This module is the later data spad.
// later data spad is used to store the data vector and count vector by CSC decoder, whose range is -128~127(INT-8).
// 
// For convolution layer, later data spad stores the iact data.
// For depthwise-convolution and fully conncected layer, later data spad stores the weight data.
// 
// The count bitwidth is 4, the data bitwidth is 8.
// The count bitwidth = 4 represents the row of later matrix can be 16 at most.
// 
// For FPGA implementation, later data spad uses BRAM to store data.
// ====================================================================================================== //

module Weight_Data_Spad(
	input         		clock,
	input         		reset,
	output reg 	[6:0]  	column_num,
	output 		[11:0] 	data_out,		// 8b for data, 4b for count, there are 2^4 rows in a Spad at most
	output        		data_in_ready,
	input         		data_in_valid,
	input  		[11:0] 	data_in,
	input         		write_en,
	output        		write_fin,
	input         		read_en,
	input  		[6:0]  	read_idx,
	input         		index_inc,
	input         		read_idx_en
);

localparam SPAD_DEPTH = 108;
localparam SPAD_WIDTH = 12;

reg [SPAD_WIDTH-1:0] Weight_Data_Spad [0:SPAD_DEPTH-1];
reg [6:0] spad_write_addr;
reg [6:0] spad_read_addr;

wire  data_in_shake = data_in_ready & data_in_valid & write_en;

wire  read_fin   = (data_out == 'd0) & index_inc;
assign write_fin = (data_in == 'd0) & data_in_shake;

assign data_in_ready = 1'd1;
assign data_out 	 = Weight_Data_Spad[spad_read_addr];

integer i;
always @(posedge clock) begin
	if(reset) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Weight_Data_Spad[i] <= 'd0;
		end
	end
	else if (data_in_shake) begin
		Weight_Data_Spad[spad_write_addr] <= data_in;
	end
end  

always @(posedge clock) begin
	if(reset) begin
		spad_read_addr <= 'd0;
	end
	else if (read_en) begin
		spad_read_addr <= column_num;
	end
end

always @(posedge clock) begin
	if (reset) begin
		spad_write_addr <= 'd0;
	end 
	else if (data_in_shake) begin
		if (write_fin) begin
			spad_write_addr <= 'd0;
		end 
		else begin
			spad_write_addr <= spad_write_addr + 'd1;
		end
	end
end

always @(posedge clock) begin	
	if (reset) begin
		column_num <= 'd0;
	end 
	else if (read_idx_en) begin
		column_num <= read_idx;
	end 
	else if (index_inc) begin
		if (read_fin) begin
			column_num <= 'd0;
		end 
		else begin
			column_num <= column_num + 'd1;
		end
	end
end

endmodule
