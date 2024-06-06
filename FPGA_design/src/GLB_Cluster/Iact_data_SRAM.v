// ====================================================================================================== //
// This module is iact data SRAM.
// iact data SRAM module is used to store iact data_count vector from CSC decoder.
// Because the data stored in SRAM is CSC format, the length is not fixed.
// Hence, this module contains a FSM to control data stream end sign
// When FSM detects one zero, then LUT will be written current index to record this data stream end index.
// When FSM detects two contineous zero, then FSM will control write index to zero(reset read index),
// which stands for all data stream for this SRAM is finish. 
// ====================================================================================================== //


module iact_data_SRAM(
	input        		clock,
	input        		reset,
	// data signals
	output       		data_in_ready,
	input        		data_in_valid,
	input  		[11:0] 	data_in,
	input        		data_out_ready,
	output reg       	data_out_valid,
	output  	[11:0] 	data_out,
	
	// control signals
	input        		write_en,
	output       		write_done,
	input        		read_en,
	input  		[9:0] 	read_addr,
	output       		read_done
);

// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//	
localparam IACT_DATA_SRAM_DEPTH = 2048;
localparam IACT_DATA_LUT_DEPTH  = 32;

localparam NOZERO  = 2'b00;
localparam ONEZERO = 2'b01; // record statr address
localparam TWOZERO = 2'b10; // data stream finish


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg 	[10:0] 	addr_LUT_mem [0:IACT_DATA_LUT_DEPTH-1]; // store start address

reg 	[1:0] 	read_zero_state, 	next_read_zero_state;
reg 	[1:0] 	write_zero_state, 	next_write_zero_state; 

reg 	[10:0] 	SRAM_write_idx;
reg 	[10:0] 	stream_read_idx; 
reg 	[10:0] 	LUT_write_idx; 


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//

wire 	[10:0] 	SRAM_read_addr;
wire 	[9:0] 	LUT_read_addr; 
wire 	[10:0] 	LUT_data_out; 

wire 	data_in_shake 		= data_in_ready & data_in_valid;

wire  	meet_zero_wire_read	= (data_out == 'd0) & data_out_valid; 
wire  	meet_zero_wire_write= data_in  == 'd0; 

wire  	read_shake 			= read_en & data_out_ready & ~meet_zero_wire_read; 
wire  	write_done_wire 	= write_zero_state == TWOZERO;
wire  	read_done_wire 		= meet_zero_wire_read & read_en; 


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign LUT_read_addr 	= read_addr;
assign LUT_data_out 	= addr_LUT_mem[LUT_read_addr]; 
assign SRAM_read_addr	= stream_read_idx + LUT_data_out;

assign data_in_ready	= write_en; 
assign write_done 		= write_done_wire & (SRAM_write_idx != 'd0); 
assign read_done 		= read_done_wire  & (read_zero_state != ONEZERO); 


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
// read FSM
always @(posedge clock) begin
	if (reset) begin 
		read_zero_state <= NOZERO; 
	end 
	else begin
		read_zero_state <= next_read_zero_state;
	end
end

// write FSM
always @(posedge clock) begin
	if (reset) begin 
		write_zero_state <= NOZERO; 
	end 
	else begin
		write_zero_state <= next_write_zero_state;
	end
end

// read next state logic
always@(*) begin
	case(read_zero_state)
		NOZERO  : next_read_zero_state = (meet_zero_wire_read & data_out_ready & data_out_valid) ? ONEZERO : NOZERO;
		ONEZERO : next_read_zero_state = (meet_zero_wire_read) ? TWOZERO : NOZERO;
		TWOZERO : next_read_zero_state = NOZERO;
		default : next_read_zero_state = NOZERO;
	endcase
end

// write next state logic
always@(*) begin
	case(write_zero_state)
		NOZERO  : next_write_zero_state = (meet_zero_wire_write & write_en & data_in_valid) ? ONEZERO : NOZERO;
		ONEZERO : next_write_zero_state = (meet_zero_wire_write & write_en & data_in_valid) ? TWOZERO : NOZERO;
		TWOZERO : next_write_zero_state = NOZERO;
		default : next_write_zero_state = NOZERO;
	endcase
end

// write LUT
integer i;
always @(posedge clock) begin
	if(reset) begin
		addr_LUT_mem[0] <= 'd0; 
		for(i=1; i<IACT_DATA_LUT_DEPTH; i=i+1) begin
			addr_LUT_mem[i] <= IACT_DATA_SRAM_DEPTH-1; 
		end
	end
	else if (write_zero_state == ONEZERO) begin
		addr_LUT_mem[LUT_write_idx + 'd1] <= SRAM_write_idx; 
	end
end


// LTU index 
always @(posedge clock) begin
	if (reset) begin 
		LUT_write_idx <= 'd0;
	end 
	else if (write_done_wire) begin 
		LUT_write_idx <= 'd0;
	end 
	else if (write_zero_state == ONEZERO & write_en) begin 
		LUT_write_idx <= LUT_write_idx + 'd1; 
	end
end

// SRAM date out
always @(posedge clock) begin
	if (reset) begin 
		data_out_valid <= 1'd0; 
	end 
	else begin
		data_out_valid <= read_shake; 
	end
end

// SRAM write index
always @(posedge clock) begin
	if (reset) begin
		SRAM_write_idx <= 'd0; 
	end 
	else if (write_done) begin 
		SRAM_write_idx <= 'd0;
	end 
	else if (write_en & data_in_valid) begin 
		SRAM_write_idx <= SRAM_write_idx + 'd1;
	end
end

// SRAM read index
always @(posedge clock) begin
	if (reset) begin 
		stream_read_idx <= 'd0; 
	end 
	else if (read_done_wire | ~read_en) begin 
		stream_read_idx <= 'd0;
	end 
	
	else if (read_en) begin 
		stream_read_idx <= stream_read_idx + 'd1;
	end
end


// ====================================================	//
// 						 BRAM IP	  					//
// ====================================================	//
wire 			IP_BRAM_write_en	= data_in_shake;
wire			IP_BRAM_read_en		= read_shake;
wire 	[10:0]	IP_BRAM_write_addr	= SRAM_write_idx;
wire 	[10:0]	IP_BRAM_read_addr	= SRAM_read_addr;
wire	[11:0]	IP_BRAM_data_in		= data_in;
wire	[11:0]	IP_BRAM_data_out;

assign data_out	= IP_BRAM_data_out;
	
Iact_Data_SRAM_BRAM Iact_Data_SRAM_BRAM_inst (
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


module Iact_Data_SRAM_BRAM (
    input 			clk,
	input			reset,
	input 			write_en,
	input			read_en,
	
	input 	[10:0]	write_addr,
	input 	[10:0]	read_addr,
	
	input	[11:0]	data_in,
	
	output	[11:0]	data_out
);

wire		wr;
wire [10:0] addra;
wire [11:0] dina;
wire [10:0] addrb;
wire [11:0] doutb;

IP_Iact_Data_SRAM_BRAM u0 (   	
  .clka		(clk	),  
  .wea		(wr		),     	
  .addra	(addra	),  	
  .dina		(dina	),  
  
  .clkb		(clk	),  
  .rstb		(reset	),     
  .addrb	(addrb	),  	  
  .doutb	(doutb	)  	
);

// need 4 cycles to clear spad data
reg	[1:0] 	clear_count;
reg 		clear_flag;

always @(posedge clk) begin
	if (reset) begin
		clear_flag <= 'd1; 
	end
	else if(clear_count == 'd3) begin
		clear_flag <= 'd0; 
	end
end

always @(posedge clk) begin
	if (reset) begin
		clear_count <= 'd0; 
	end
	else if(clear_flag) begin
		clear_count <= clear_count + 'd1; 
	end
end


assign addra 	= (clear_flag & ~write_en) ? clear_count : write_addr;
assign addrb 	= read_addr;
assign dina 	= clear_flag ? 'd0 : data_in;
assign wr		= write_en | clear_flag;

assign data_out = doutb;


endmodule
