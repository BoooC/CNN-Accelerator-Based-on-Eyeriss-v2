// ====================================================================================================== //
// This module is iact SRAM.
// iact SRAM module contains address iact SRAM and sata SRAM.
// iact SRAM module contains FSM to control data stream end sign
// When FSM detects one zero, the coresspoding SRAM will be set done and wait another SRAM detects one zero.
// ====================================================================================================== //


module Iact_SRAM_Bank(
	input         clock,
	input         reset,
	// data signals
	output        iact_address_in_ready,
	input         iact_address_in_valid,
	input  [6:0]  iact_address_in,
	
	output        iact_data_in_ready,
	input         iact_data_in_valid,
	input  [11:0] iact_data_in,
	
	input         iact_address_out_ready,
	output        iact_address_out_valid,
	output [6:0]  iact_address_out,
	
	input         iact_data_out_ready,
	output        iact_data_out_valid,
	output [11:0] iact_data_out,
	
	// control signals
	input         iact_write_en,
	output        iact_write_done,
	
	input         iact_read_en,
	input  [9:0]  iact_read_addr,
	output        iact_read_done
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam IDLE  	 = 2'd0;
localparam WORK  	 = 2'd1;
localparam WAIT_ADDR = 2'd2;
localparam WAIT_DATA = 2'd3;


// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//
iact_addr_SRAM iact_addr_SRAM_inst ( 
	.clock			(clock					),                                             
	.reset			(reset					),                                             
	.data_in_ready	(iact_address_in_ready	),  
	.data_in_valid	(iact_address_in_valid	),  
	.data_in		(iact_address_in		),              
	.data_out_ready	(iact_address_out_ready	),
	.data_out_valid	(iact_address_out_valid	),
	.data_out		(iact_address_out		),            
	.write_en		(addr_SRAM_write_en		),            
	.write_done		(addr_SRAM_write_done	),        
	.read_en		(addr_SRAM_read_en		),              
	.read_addr		(addr_SRAM_read_addr	),         
	.read_done		(addr_SRAM_read_done	)           
);

iact_data_SRAM iact_data_SRAM_inst ( 
	.clock			(clock					),                      
	.reset			(reset					),                      
	.data_in_ready	(iact_data_in_ready		), 
	.data_in_valid	(iact_data_in_valid		), 
	.data_in		(iact_data_in			),             
	.data_out_ready	(iact_data_out_ready	),
	.data_out_valid	(iact_data_out_valid	),
	.data_out		(iact_data_out			),           
	.write_en		(data_SRAM_write_en		),       
	.write_done		(data_SRAM_write_done	),   
	.read_en		(data_SRAM_read_en		),         
	.read_addr		(data_SRAM_read_addr	),     
	.read_done		(data_SRAM_read_done	)      
);


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg [1:0] iact_read_state, 	next_iact_read_state; 
reg [1:0] iact_write_state, next_iact_write_state;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire  addr_SRAM_write_en; 
wire  addr_SRAM_write_done; 
wire  addr_SRAM_read_en; 
wire  addr_SRAM_read_done; 

wire  data_SRAM_write_en;
wire  data_SRAM_write_done; 
wire  data_SRAM_read_en;  
wire  data_SRAM_read_done; 

wire  write_done_both = addr_SRAM_write_done & data_SRAM_write_done; 
wire  read_done_both  = addr_SRAM_read_done  & data_SRAM_read_done; 

wire [9:0] addr_SRAM_read_addr;
wire [9:0] data_SRAM_read_addr; 


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign addr_SRAM_write_en   = iact_write_state == WORK || iact_write_state == WAIT_ADDR; 
assign addr_SRAM_read_en	= iact_read_state  == WORK || iact_read_state  == WAIT_ADDR; 

assign data_SRAM_write_en  	= iact_write_state == WORK || iact_write_state == WAIT_DATA; 
assign data_SRAM_read_en   	= iact_read_state  == WORK || iact_read_state  == WAIT_DATA;

assign addr_SRAM_read_addr 	= iact_read_addr;
assign data_SRAM_read_addr 	= iact_read_addr;  

assign iact_write_done		= 	((iact_write_state == WAIT_ADDR) & addr_SRAM_write_done)|| 
								((iact_write_state == WAIT_DATA) & data_SRAM_write_done)||
								((iact_write_state == WORK) 	 & write_done_both);
									
assign iact_read_done 		= 	((iact_read_state == WAIT_ADDR) & addr_SRAM_read_done) 	|| 
								((iact_read_state == WAIT_DATA) & data_SRAM_read_done)  ||
								((iact_read_state == WORK) 		& read_done_both); 


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//		
// FSM
always @(posedge clock) begin
	if (reset) begin 
		iact_read_state <= IDLE;
	end 
	else begin
		iact_read_state <= next_iact_read_state;
	end
end

always @(posedge clock) begin
	if (reset) begin 
		iact_write_state <= IDLE;
	end 
	else begin
		iact_write_state <= next_iact_write_state;
	end
end

// next state logic
always@(*) begin
	case(iact_read_state)
		IDLE  	  : next_iact_read_state = iact_read_en 		? WORK : IDLE;
		WORK  	  : next_iact_read_state = read_done_both 		? IDLE : (addr_SRAM_read_done ? WAIT_DATA : (data_SRAM_read_done ? WAIT_ADDR : WORK));
		WAIT_ADDR : next_iact_read_state = addr_SRAM_read_done  ? IDLE : WAIT_ADDR;
		WAIT_DATA : next_iact_read_state = data_SRAM_read_done 	? IDLE : WAIT_DATA;
		default   : next_iact_read_state = IDLE;
	endcase
end

always@(*) begin
	case(iact_write_state)
		IDLE  	  : next_iact_write_state = iact_write_en 		? WORK : IDLE;
		WORK  	  : next_iact_write_state = write_done_both 	? IDLE : (addr_SRAM_write_done ? WAIT_DATA : (data_SRAM_write_done ? WAIT_ADDR : WORK));
		WAIT_ADDR : next_iact_write_state = addr_SRAM_write_done? IDLE : WAIT_ADDR;
		WAIT_DATA : next_iact_write_state = data_SRAM_write_done? IDLE : WAIT_DATA;
		default   : next_iact_write_state = IDLE;
	endcase
end


endmodule
