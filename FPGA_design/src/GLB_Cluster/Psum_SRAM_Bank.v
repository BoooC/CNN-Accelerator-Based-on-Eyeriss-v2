// ====================================================================================================== //
// This module is psum SRAM.
// psum SRAM module is used to store psum data.
// Use write_count signal to count psum SRAM write in to control psum write.
// write_count's upbound will be determined by input signal PSUM_DEPTH.
// ====================================================================================================== //


module Psum_SRAM_Bank(
	input         				clock,
	input         				reset,
	// data signals
	output        				psum_data_in_ready,
	input         				psum_data_in_valid,
	input 		signed 	[20:0] 	psum_data_in,
	
	input         				psum_data_out_ready,
	output reg       			psum_data_out_valid,
	output 		signed 	[20:0] 	psum_data_out,
	
	// control signals
	input         				psum_write_en,
	input  				[9:0]  	psum_write_addr,
	output        				psum_write_done,
	
	input         				psum_read_out_en,	// read out to rearrange and do im2col
	input         				psum_read_en,
	input  				[9:0]  	psum_read_addr,
	
	input				[4:0]	PSUM_DEPTH
);

// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam PSUM_SRAM_DEPTH = 512;


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg [4:0] write_count; 


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire  write_shake 		= psum_data_in_ready  & psum_data_in_valid; // & psum_write_en
wire  read_shake  		= psum_data_out_ready & (psum_read_en | psum_read_out_en); 


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign psum_data_in_ready  = psum_write_en; 
assign psum_write_done = (write_count == PSUM_DEPTH + 'd1); 


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
always @(posedge clock) begin
	if (reset) begin 
		psum_data_out_valid <= 1'd0; 
	end 
	else begin
		psum_data_out_valid <= read_shake; 
	end
end

always @(posedge clock) begin
	if (reset) begin 
		write_count <= 5'd0; 
	end 
	else if (psum_write_done) begin 
		write_count <= 5'd0;
	end 
	else if (write_shake) begin 
		write_count <= write_count + 5'd1;
	end
end


// ====================================================	//
// 						 BRAM IP	  					//
// ====================================================	//
wire 					IP_BRAM_write_en	= write_shake;
wire					IP_BRAM_read_en		= read_shake;
wire 			[8:0]	IP_BRAM_write_addr	= psum_write_addr;
wire 			[8:0]	IP_BRAM_read_addr	= psum_read_addr;
wire	signed	[20:0]	IP_BRAM_data_in		= psum_data_in;
wire	signed	[20:0]	IP_BRAM_data_out;

assign psum_data_out	= IP_BRAM_data_out;
	
Psum_Data_SRAM_BRAM Psum_Data_SRAM_BRAM_inst (
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


module Psum_Data_SRAM_BRAM (
    input 					clk,
	input					reset,
	input 					write_en,
	input					read_en,
	
	input 			[8:0]	write_addr,
	input 			[8:0]	read_addr,
	
	input	signed	[20:0]	data_in,
	
	output	signed	[20:0]	data_out
);

wire					wr;
wire 			[8:0] 	addra;
wire	signed	[20:0] 	dina;
wire 			[8:0] 	addrb;
wire 	signed	[20:0] 	doutb;

IP_Psum_Data_SRAM_BRAM u0 (   	
  .clka		(clk	),  
  .wea		(wr		),     	
  .addra	(addra	),  	
  .dina		(dina	),  

  .clkb		(clk	),  
  .rstb		(reset	),     
  .addrb	(addrb	),  	  
  .doutb	(doutb	)  	
);


assign addra 	= write_addr;
assign addrb 	= read_addr;
assign dina 	= data_in;
assign wr		= write_en;

assign data_out = ~write_en	? doutb	: 'd0;

endmodule
