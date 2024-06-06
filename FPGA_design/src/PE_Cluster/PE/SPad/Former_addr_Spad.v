// ====================================================================================================== //
// This module is the former address spad.
// Former address spad is used to store the address vector by CSC decoder, whose range is 0~255.
// For convolution layer, Former address spad stores the weight address.
// For depthwise-convolution and fully conncected layer, Former address spad stores the iact address.
// For one former matrix, the number of address is the width of the matrix plus one (for zero end sign).
// ====================================================================================================== //

module Former_Address_Spad(
	input        		clock,
	input        		reset,
	// data signals
	output       		data_in_ready,
	input        		data_in_valid,
	input  		[7:0] 	data_in,
	output 	 	[7:0] 	data_out,		// 8b : Can store 2^8=256 data at most
	// control signals
	input        		write_en,
	output       		write_fin,
	input       		index_inc 		// combine read_en and index increase
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam SPAD_DEPTH = 12;
localparam SPAD_WIDTH = 8;

// ================================================	//
// 					 Registers  					//
// ================================================	//
reg [SPAD_WIDTH-1:0] 	Iact_Address_Spad [0:SPAD_DEPTH-1]; // TODO : use register file IP
reg [3:0] 				data_write_addr;
reg [3:0] 				data_read_addr; 

// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire  data_in_shake		= data_in_ready & data_in_valid & write_en; 
wire  read_fin 			= (data_out == 'd0) & index_inc; 

// ================================================	//
// 					 Combination  					//
// ================================================	//
assign write_fin 		= (data_in == 'd0) & data_in_shake; 
assign data_in_ready 	= 1'b1; 
assign data_out 	 	= Iact_Address_Spad[data_read_addr]; 

// ================================================	//
// 					 Sequential  					//
// ================================================	//
// write spad
integer i;
always@(posedge clock) begin
	if(reset) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Iact_Address_Spad[i] <= 'd0;
		end
	end
	else if(data_in_shake) begin
		Iact_Address_Spad[data_write_addr] <= data_in;
	end
end

// write addr
always@(posedge clock) begin
	if(reset) begin 
		data_write_addr <= 'd0; 
	end 
	else if(data_in_shake) begin 
		if(write_fin) begin 
			data_write_addr <= 'd0;
		end 
		else begin
			data_write_addr <= data_write_addr + 'd1;
		end
	end
end

// read addr
always@(posedge clock) begin  
	if(reset) begin
		data_read_addr <= 'd0; 
	end 
	else if(index_inc) begin 
		if(read_fin) begin 
			data_read_addr <= 'd0; 
		end 
		else begin
			data_read_addr <= data_read_addr + 'd1; 
		end
	end
end


endmodule
