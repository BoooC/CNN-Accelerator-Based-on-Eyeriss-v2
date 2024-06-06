// ====================================================================================================== //
// This module is the later address spad.
// later address spad is used to store the address vector by CSC decoder, whose range is 0~127.
// For convolution layer, later address spad stores the iact address.
// For depthwise-convolution and fully conncected layer, later address spad stores the weight address.
// For one later matrix, the number of address is the width of the matrix plus one (for zero end sign).
// ====================================================================================================== //


module Later_Address_Spad(
	input        		clock,
	input        		reset,
	// data signals
	output       		data_in_ready,
	input        		data_in_valid,
	input  		[6:0] 	data_in,
	output 		[6:0]	data_out,			// 7b : Can store 2^7=128 data at most 
	// control signals
	input        		write_en,
	output       		write_fin,
	input  		[4:0] 	read_idx,
	input        		read_idx_en,
	input        		addr_read_inc
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam SPAD_DEPTH = 32;
localparam SPAD_WIDTH = 7;


// ================================================	//
// 					 Registers  					//
// ================================================	//
reg [SPAD_WIDTH-1:0] 	Weight_Address_Spad [0:SPAD_DEPTH-1]; // TODO : use register file IP
reg [4:0] 				spad_write_addr;
reg [4:0] 				spad_read_addr;


// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire  data_in_shake = data_in_ready & data_in_valid & write_en;
wire  read_fin   	= (data_out == 'd0) & addr_read_inc;


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign write_fin 		= (data_in == 'd0) & data_in_shake;
assign data_in_ready	= 1'd1;
assign data_out  		= Weight_Address_Spad[spad_read_addr];


// ================================================	//
// 					 Sequential  					//
// ================================================	//
// write spad
integer i;
always @(posedge clock) begin
	if (reset) begin
		for(i=0; i<SPAD_DEPTH; i=i+1) begin
			Weight_Address_Spad[i] <= 7'd127;
		end
	end
	else if(data_in_shake) begin
		Weight_Address_Spad[spad_write_addr] <= data_in;
	end
end

// write addr
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

// read addr
always @(posedge clock) begin	
    if (reset) begin
		spad_read_addr <= 'd0;
    end 
	else if (read_idx_en) begin
		spad_read_addr <= read_idx;
    end 
	else if (addr_read_inc) begin
		if (read_fin) begin
			spad_read_addr <= 'd0;
		end 
		else begin
			spad_read_addr <= spad_read_addr + 'd1;
		end
    end
end

  
endmodule
