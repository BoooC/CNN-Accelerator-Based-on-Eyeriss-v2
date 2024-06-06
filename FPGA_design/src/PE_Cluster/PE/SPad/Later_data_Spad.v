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


module Later_Data_Spad(
	input         		clock,
	input         		reset,
	// data signals
	output        		data_in_ready,
	input         		data_in_valid,
	input  		[11:0] 	data_in,
	output 		[11:0] 	data_out,		// 8b for data, 4b for count, there are 2^4 rows in a Spad at most.
	output reg 	[6:0]  	column_num,		// use the count to determine whether the later data read done.
	// control signals
	input         		write_en,
	output        		write_fin,
	input         		read_en,
	input  		[6:0]  	read_idx,
	input         		index_inc,
	input         		read_idx_en
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam SPAD_DEPTH = 100;
localparam SPAD_WIDTH = 12;


// ================================================	//
// 					 Registers  					//
// ================================================	//
reg [6:0] spad_write_addr;
reg [6:0] spad_read_addr;


// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire  data_in_shake = data_in_ready & data_in_valid & write_en;
wire  read_fin   	= (data_out == 'd0) & index_inc;

// RAM read delay 1 cycle for BRAM
wire [6:0] next_data_read_addr = read_en ? column_num : spad_read_addr;


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign write_fin 		= (data_in == 'd0) & data_in_shake;
assign data_in_ready 	= 1'd1;


// ================================================	//
// 					 Sequential  					//
// ================================================	//
always @(posedge clock) begin
	if(reset) begin
		spad_read_addr <= 'd0;
	end
	else begin 
		spad_read_addr <= next_data_read_addr;
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


// ====================================================	//
// 						 BRAM IP	  					//
// ====================================================	//
wire 			IP_BRAM_write_en	= data_in_shake;
wire			IP_BRAM_read_en		= 'd1;
wire 	[6:0]	IP_BRAM_write_addr	= spad_write_addr;
wire 	[6:0]	IP_BRAM_read_addr	= next_data_read_addr;
wire	[11:0]	IP_BRAM_data_in		= data_in;
wire	[11:0]	IP_BRAM_data_out;

assign data_out	= IP_BRAM_data_out;
	
Weight_DATA_Spad_BRAM Weight_DATA_Spad_BRAM_inst (
    .clk			(clock					),
	.reset			(reset					),
	.write_en       (IP_BRAM_write_en       ),
	.read_en        (IP_BRAM_read_en        ),
	.write_addr     (IP_BRAM_write_addr     ),
	.read_addr      (IP_BRAM_read_addr      ),
	.data_in        (IP_BRAM_data_in        ),
	.data_out       (IP_BRAM_data_out       )
);

endmodule


module Weight_DATA_Spad_BRAM (
    input 			clk,
	input			reset,
	input 			write_en,
	input			read_en,
	
	input 	[6:0]	write_addr,
	input 	[6:0]	read_addr,
	
	input	[11:0]	data_in,
	
	output	[11:0]	data_out
);

wire		wr;
wire [6:0] 	addra;
wire [11:0] dina;
wire [11:0] douta;

IP_Weight_DATA_Spad_BRAM u0 (   	
  .clka		(clk	),    	
  .rsta		(reset	),
  .wea		(wr		),      	
  .addra	(addra	),  	
  .dina		(dina	),    	
  .douta	(douta	)  	
);

// need 100 cycles to clear spad data
reg	[6:0]	clear_count;
reg 		clear_flag;
always @(posedge clk) begin
	if (reset) begin
		clear_flag <= 'd1; 
	end
	else if(clear_count == 'd99) begin
		clear_flag <= 'd0; 
	end
end

always @(posedge clk) begin
	if (reset) begin
		clear_count <= 'd0; 
	end
	else if(clear_flag) begin
		clear_count <= (clear_count == 'd99) ? 'd0 : (clear_count + 'd1); 
	end
end

assign wr		= write_en | clear_flag;
assign addra 	= wr ? (clear_flag ? clear_count : write_addr) : read_addr;
assign dina 	= clear_flag ? 'd0 : data_in;

assign data_out = douta;


endmodule
