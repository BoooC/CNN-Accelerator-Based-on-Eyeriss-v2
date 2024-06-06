// ====================================================================================================== //
// This module is the psum spad.
// psum spad is used to store the psum data from iact * weight and accumulate with previous psum data.
// 
// psum spad depth is from the depth of th multiplication of former matrix and later matrix.
// In this design the former matrix shape is (8, 25), later matrix shape is (25, 4). Hence, the psum shape is (8, 4) = 32
// The shape of former matrix and later matrix can be scale for custom design.
// 
// The bitwidth of iact data is 8, The bitwidth of weight data is 8, The bitwidth of product from iact and weight is 16, 
// I set the maximum times of accumulation is 6, which is 2 PE cluster requirment
// (one PE cluster contains 3 rows of PE, hence it will be accumulated 6 timees) 
// 
// For FPGA implementation, psum spad uses BRAM to store data.
// ====================================================================================================== //


module Psum_Spad (
	input         			clock,
	input         			reset,
	// data signals
	output        			psum_in_ready,
	input         			psum_in_valid,
	input 	signed 	[20:0] 	psum_in,
	input         			psum_out_ready,
	output        			psum_out_vaild,
	output 	signed 	[20:0] 	psum_out,
	// control signals
	input  			[4:0]  	read_idx,
	input  			[4:0]  	write_idx,
	input					psum_spad_clear	
	/*  This signal is used to clear psum spad data, because when PE accumulates data, 
		it will read psum data first,
		then accemulate the psum spad data with the product from iact and weight 
	*/
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam SPAD_DEPTH = 32; // (8, 25) * (25, 4) = (8, 4), Matrix shape
localparam SPAD_WIDTH = 21;


// ================================================	//
// 					 	Wires  						//
// ================================================	//
wire  data_in_shake = psum_in_ready & psum_in_valid;


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign psum_in_ready 	= ~psum_out_ready; 
assign psum_out_vaild 	= ~psum_in_valid; 



// ====================================================	//
// 						 BRAM IP	  					//
// ====================================================	//
wire					IP_BRAM_reset		= reset | psum_spad_clear;
wire 					IP_BRAM_write_en	= data_in_shake;
wire 			[4:0]	IP_BRAM_write_addr	= write_idx;
wire 			[4:0]	IP_BRAM_read_addr	= read_idx;
wire	signed	[20:0]	IP_BRAM_data_in		= psum_in;
wire	signed	[20:0]	IP_BRAM_data_out;

assign psum_out	= IP_BRAM_data_out;
	
Psum_DATA_Spad_BRAM Psum_DATA_Spad_BRAM_inst (
    .clk			(clock					),
	.reset			(IP_BRAM_reset			),
	.write_en       (IP_BRAM_write_en       ),
	.write_addr     (IP_BRAM_write_addr     ),
	.read_addr      (IP_BRAM_read_addr      ),
	.data_in        (IP_BRAM_data_in        ),
	.data_out       (IP_BRAM_data_out       )
);

endmodule


module Psum_DATA_Spad_BRAM (
    input 					clk,
	input					reset,
	input 					write_en,
			
	input 			[4:0]	write_addr,
	input 			[4:0]	read_addr,
	
	input	signed	[20:0]	data_in,
	
	output	signed	[20:0]	data_out
);

wire					wr;
wire 			[4:0] 	addra;
wire	signed	[20:0] 	dina;
wire 			[4:0] 	addrb;
wire	signed	[20:0] 	doutb;

IP_Psum_DATA_Spad_BRAM u0 (   	
  .clka		(clk	),  
  .wea		(wr		),     	
  .addra	(addra	),  	
  .dina		(dina	),  
  
  .clkb		(clk	),  
  .rstb		(reset	),     
  .addrb	(addrb	),  	  
  .doutb	(doutb	)  	
);

// need 32 cycles to clear spad data
reg			[4:0] 	clear_count;
reg 				clear_flag;
reg					wr_reg;
reg	signed	[20:0] 	data_out_reg;

always @(posedge clk) begin
	if (reset) begin
		clear_flag <= 'd1; 
	end
	else if(clear_count == 'd31) begin
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

always @(posedge clk) begin
	if (reset) begin
		wr_reg <= 'd0; 
	end
	else begin
		wr_reg <= wr; 
	end
end

always @(posedge clk) begin
	if (reset) begin
		data_out_reg <= 'd0; 
	end
	else begin
		data_out_reg <= doutb; 
	end
end

assign addra 	= clear_flag ? clear_count : write_addr;
assign addrb 	= read_addr;
assign dina 	= clear_flag ? 'd0 : data_in;
assign wr		= write_en | clear_flag;

assign data_out = wr_reg ? data_out_reg : doutb;


endmodule

