// ====================================================================================================== //
// This module is the FIFO for the IO of data of PE.
// This FIFO is used to buffer the IO of data between the inside of PE and outside of PE for asynchromous case.  
// 
// TODO : For FPGA implementation, use FIFO IP to replace this module
// ====================================================================================================== //


module PE_data_FIFO #(
	parameter DATA_IN_WIDTH = 4
	)
(
	input        				clock,
	input        				reset,
	// data signals
	output       				data_in_ready, 
	input        				data_in_valid,
	input  [DATA_IN_WIDTH-1:0] 	data_in,
	output       				data_out_valid, 
	output [DATA_IN_WIDTH-1:0] 	data_out
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam BUFFER_DEPTH = 4;


// ================================================	//
// 					 Registers  					//
// ================================================	//
reg [DATA_IN_WIDTH-1:0] buffer [0:BUFFER_DEPTH-1];
reg maybe_full;

reg [1:0] buffer_read_addr;
reg [1:0] buffer_write_addr;


// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire [DATA_IN_WIDTH-1:0] buffer_data_out;

wire ptr_match 	= (buffer_write_addr == buffer_read_addr) ? 1'b1 : 1'b0;
wire empty 		= ptr_match & ~maybe_full;

wire write_en 	= empty ? 1'b0 : data_in_valid;
wire read_en  	= empty ? 1'b0 : data_out_valid;


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign buffer_data_out 	= buffer[buffer_read_addr];
assign data_in_ready 	= 1'b1;
assign data_out_valid 	= data_in_valid | (~empty);
assign data_out 		= empty ? data_in : buffer_data_out;


// ================================================	//
// 					 Sequential  					//
// ================================================	//
integer i;
always@(posedge clock) begin
	if(reset) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			buffer[i] <= 'd0;
		end
	end
	else if(~empty & data_in_valid) begin
		buffer[buffer_write_addr] <= data_in;
	end
end

always@(posedge clock) begin
	if(reset) begin
		buffer_write_addr <= 'd0;
	end 
	else if(write_en) begin
		buffer_write_addr <= buffer_write_addr + 'd1;
	end
end
	
always@(posedge clock) begin	
	if(reset) begin
		buffer_read_addr <= 'd0;
	end 
	else if(read_en) begin
		buffer_read_addr <= buffer_read_addr + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		maybe_full <= 1'b0;
	end 
	else if(write_en != read_en) begin
		if(empty) begin
			maybe_full <= 1'b0;
		end 
		else begin
			maybe_full <= data_in_valid;
		end
	end
end

endmodule