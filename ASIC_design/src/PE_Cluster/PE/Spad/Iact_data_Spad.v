// ====================================================================================================== //
// This module is the former data spad.
// Former data spad is used to store the data vector and count vector by CSC decoder, whose range is -128~127(INT-8).
// 
// For convolution layer, Former data spad stores the weight data.
// For depthwise-convolution and fully conncected layer, Former data spad stores the iact data.
// 
// The count bitwidth is 5, the data bitwidth is 8.
// The count bitwidth = 5 represents the row of former matrix can be 32 at most.
// 
// For FPGA implementation, former data spad uses BRAM to store data.
// ====================================================================================================== //

module Iact_Data_Spad(
	input         clock,
	input         reset,
	output [7:0]  column_num,
	output [12:0] data_out,		// 8b for data, 5b for count, there are 2^5 rows in a Spad at most
	output        data_in_ready,
	input         data_in_valid,
	input  [12:0] data_in,
	input         write_en,
	output        write_fin,
	input         index_inc 	// combine read_en and index increase
);

localparam SPAD_DEPTH = 210;
localparam SPAD_WIDTH = 13;

reg [SPAD_WIDTH-1:0] Iact_Data_Spad [0:SPAD_DEPTH-1];
reg [7:0] spad_write_addr;
reg [7:0] spad_read_addr; 

wire  data_in_shake = data_in_ready & data_in_valid & write_en; 

wire  read_fin 	 = (data_out == 'd0) & index_inc; 
assign write_fin = (data_in  == 'd0) & data_in_shake; 

assign data_in_ready = 1'b1; 
assign data_out 	 = Iact_Data_Spad[spad_read_addr]; 

assign column_num = spad_read_addr; 

// write spad
integer i;
always @(posedge clock) begin
	if (reset) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Iact_Data_Spad[i] <= 'd0;
		end
	end
	else if(data_in_shake) begin
		Iact_Data_Spad[spad_write_addr] <= data_in;
	end
end

// wr addr
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
		spad_read_addr <= 'd0; 
	end 
	else if (index_inc) begin 
		if (read_fin) begin 
			spad_read_addr <= 'd0; 
		end 
		else begin
			spad_read_addr <= spad_read_addr + 'd1; 
		end
	end
end
	
endmodule
