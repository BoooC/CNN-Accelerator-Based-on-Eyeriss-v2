module CSC_switch_FIFO #(
	parameter DATA_WIDTH = 8
	)
(
	input        				clock,
	input        				reset,
	output       				data_in_ready,
	input        				data_in_valid,
	input  [DATA_WIDTH-1:0] 	data_in,
	input        				data_out_ready,
	output      				data_out_valid,
	output [DATA_WIDTH-1:0] 	data_out
);

localparam BUFFER_DEPTH = 4;
	
reg [DATA_WIDTH-1:0] Buffer [0:BUFFER_DEPTH-1]; 

reg  maybe_full;
reg [1:0] Buffer_write_addr;
reg [1:0] Buffer_read_addr; 

wire [DATA_WIDTH-1:0] Buffer_read_out_data;

wire  Buffer_write_en;
wire  ptr_match = (Buffer_write_addr == Buffer_read_addr) ? 1'b1 : 1'b0;

wire  empty = ptr_match & ~maybe_full;
wire  full  = ptr_match &  maybe_full; 

wire  data_in_shake  = data_in_ready & data_in_valid; 
wire  data_out_shake = data_out_ready & data_out_valid; 

wire  data_in_en  = (empty && data_out_ready) ? 1'b0 : data_in_shake;
wire  data_out_en =  empty 				   	  ? 1'b0 : data_out_shake;

assign Buffer_read_out_data = Buffer[Buffer_read_addr]; 
assign data_in_ready  = data_out_ready | ~full; 
assign data_out_valid = data_in_valid  | ~empty;

assign data_out = empty ? data_in : Buffer_read_out_data; 
assign Buffer_write_en = empty ? (~data_out_ready & data_in_shake) : data_in_shake;

// write
integer i;
always @(posedge clock) begin
	if (Buffer_write_en) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			Buffer[Buffer_write_addr] <= 'd0; 
		end
	end
	else if (Buffer_write_en) begin
		Buffer[Buffer_write_addr] <= data_in; 
	end
end

// write addr
always @(posedge clock) begin
	if (reset) begin
		Buffer_write_addr <= 2'd0;
	end 
	else if (data_in_en) begin 
		Buffer_write_addr <= Buffer_write_addr + 2'd1;
	end
end

// read addr
always @(posedge clock) begin
	if (reset) begin
		Buffer_read_addr <= 2'd0;
	end 
	else if (data_out_en) begin 
		Buffer_read_addr <= Buffer_read_addr + 2'd1; 
	end
end

// flow control
always @(posedge clock) begin
	if (reset) begin
		maybe_full <= 1'd0;
	end 
	else if (data_in_en != data_out_en) begin 
		if (empty) begin
			if (data_out_ready) begin 
				maybe_full <= 1'd0; 
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
