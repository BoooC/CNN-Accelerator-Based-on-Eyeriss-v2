// ====================================================================================================== //
// This module is the FIFO for the input and output of psum data.
// This FIFO is used to buffer the IO of data between the inside of PE and outside of PE for asynchromous case.  
// 
// TODO : For FPGA implementation, use FIFO IP to replace this module.
// 
// note : the module should be disbalem because psum is always synchromous to inside and outside of PE.
// ====================================================================================================== //


module PE_psum_FIFO(
	input         			clock,
	input         			reset,
	// data signals
	output        			data_in_ready,
	input         			data_in_valid,
	input 	signed [20:0] 	data_in,
	input         			data_out_ready,
	output        			data_out_valid,
	output 	signed [20:0] 	data_out
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam BUFFER_DEPTH = 4;


// ================================================	//
// 					 Registers  					//
// ================================================	//
reg signed [20:0] buffer [0:BUFFER_DEPTH-1];

reg [1:0] buffer_read_addr;
reg [1:0] buffer_write_addr;

reg maybe_full;


// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire ptr_match 		= (buffer_write_addr == buffer_read_addr) ? 1'b1 : 1'b0;
wire empty 			= 'd1; // ptr_match & ~maybe_full;
wire full  			= ptr_match &  maybe_full;

wire data_in_shake  = data_in_ready  & data_in_valid;
wire data_out_shake = data_out_ready & data_out_valid;

wire write_en 		= empty ? (~data_out_ready & data_in_shake) : data_in_shake;
wire read_en  		= empty ? 1'b0 : data_out_shake;

wire signed [20:0] buffer_data_out_wire = buffer[buffer_read_addr];


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign data_in_ready 	= data_out_ready | ~full;
assign data_out_valid 	= data_in_valid  | ~empty;
assign data_out 		= empty ? data_in : buffer_data_out_wire;


// ================================================	//
// 					 Sequential  					//
// ================================================	//
integer i;
always@(posedge clock) begin
	if(reset) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			buffer[i] <= 21'sd0;
		end
	end
    else if (write_en) begin
		buffer[buffer_write_addr] <= data_in;
    end
end

always@(posedge clock) begin
    if (reset) begin
		buffer_write_addr <= 2'd0;
    end 
	else if (write_en) begin
		buffer_write_addr <= buffer_write_addr + 2'd1;
    end
end	

always@(posedge clock) begin
    if (reset) begin
		buffer_read_addr <= 2'd0;
    end 
	else if (read_en) begin
		buffer_read_addr <= buffer_read_addr + 2'd1;
    end
end

always@(posedge clock) begin
    if (reset) begin
		maybe_full <= 1'b0;
    end 
	else if (write_en != read_en) begin
		if (empty) begin
			if (data_out_ready) begin
				maybe_full <= 1'b0;
			end 
			else begin
				maybe_full <= data_in_shake;
			end
		end 
		else begin
			maybe_full <= data_in_shake;
		end
    end
end


endmodule

