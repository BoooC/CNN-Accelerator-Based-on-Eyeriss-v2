// ====================================================================================================== //
// This module is psum_rearrange buffer.
// psum_rearrange is only used to store data from psum SRAM bank to rearrange.
// The data in this buffer is ifmap of the next layer.
// ====================================================================================================== //


module psum_rearrange (
	input        				clock,
	input        				reset,	
	
	input  	 					write_en,
	input				[11:0]	write_addr,
	input		signed	[7:0] 	data_in,
	input        				data_in_valid,
	
	input				[11:0] 	read_addr,
	output		signed	[7:0]	data_out
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam BUFFER_DEPTH = 3500;	// 576*6=3456


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire data_in_shake = write_en & data_in_valid;


// ====================================================	//
// 						 BRAM IP	  					//
// ====================================================	//
wire 					IP_BRAM_write_en	= data_in_shake;
wire 			[11:0]	IP_BRAM_write_addr	= write_addr;
wire 			[11:0]	IP_BRAM_read_addr	= read_addr;
wire	signed	[7:0]	IP_BRAM_data_in		= data_in;
wire	signed	[7:0]	IP_BRAM_data_out;

assign data_out	= IP_BRAM_data_out;
	
Psum_Rearrange_BRAM Psum_Rearrange_BRAM_inst (
    .clk			(clock					),
	.reset			(reset					),
	.write_en       (IP_BRAM_write_en       ),
	.write_addr     (IP_BRAM_write_addr     ),
	.read_addr      (IP_BRAM_read_addr      ),
	.data_in        (IP_BRAM_data_in        ),
	.data_out       (IP_BRAM_data_out       )
);

endmodule


module Psum_Rearrange_BRAM (
    input 					clk,
	input					reset,
	input 					write_en,
			
	input 			[11:0]	write_addr,
	input 			[11:0]	read_addr,
	
	input	signed	[7:0]	data_in,
	
	output	signed	[7:0]	data_out
);

wire					wr;
wire 			[11:0] 	addra;
wire	signed	[7:0] 	dina;
wire 			[11:0] 	addrb;
wire	signed	[7:0] 	doutb;

IP_Psum_Rearrange_BRAM u0 (   	
  .clka		(clk	),  
  .wea		(wr		),     	
  .addra	(addra	),  	
  .dina		(dina	),  
  
  .clkb		(clk	),  
  .rstb		(reset	),     
  .addrb	(addrb	),  	  
  .doutb	(doutb	)  	
);


// need 4096 cycles to clear spad data
reg	[11:0] 	clear_count;
reg 		clear_flag;

always @(posedge clk) begin
	if (reset) begin
		clear_flag <= 'd1; 
	end
	else if(clear_count == 'd4095) begin
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
