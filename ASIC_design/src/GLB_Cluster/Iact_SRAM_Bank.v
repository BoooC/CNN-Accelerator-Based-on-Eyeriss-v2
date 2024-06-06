// ====================================================================================================== //
// This module is iact SRAM.
// iact SRAM module contains address iact SRAM and sata SRAM.
// iact SRAM module contains FSM to control data stream end sign
// When FSM detects one zero, the coresspoding SRAM will be set done and wait another SRAM detects one zero.
// ====================================================================================================== //

module Iact_SRAM_Bank(
	input         clock,
	input         reset,
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
	
	input         iact_write_en,
	output        iact_write_done,
	
	input         iact_read_en,
	input  [9:0]  iact_read_addr,
	output        iact_read_done
);


localparam IDLE  	 = 2'd0;
localparam WORK  	 = 2'd1;
localparam WAIT_ADDR = 2'd2;
localparam WAIT_DATA = 2'd3;

reg [1:0] inActReadState, next_inActReadState; 
reg [1:0] inActWriteState, next_inActWriteState;

wire  adrSRAM_write_en; 
wire  adrSRAM_write_done; 
wire  adrSRAM_read_en; 
wire  adrSRAM_read_done; 

wire  dataSRAM_write_en;
wire  dataSRAM_write_done; 
wire  dataSRAM_read_en;  
wire  dataSRAM_read_done; 

wire  WriteDoneAtSameTimeWire = adrSRAM_write_done & dataSRAM_write_done; 
wire  ReadDoneAtSameTimeWire  = adrSRAM_read_done  & dataSRAM_read_done; 

wire [9:0] addrSRAM_read_addr;
wire [9:0] dataSRAM_read_addr; 

assign adrSRAM_write_en   = inActWriteState == WORK || inActWriteState == WAIT_ADDR; 
assign adrSRAM_read_en 	  = inActReadState  == WORK || inActReadState  == WAIT_ADDR; 

assign dataSRAM_write_en  = inActWriteState == WORK || inActWriteState == WAIT_DATA; 
assign dataSRAM_read_en   = inActReadState  == WORK || inActReadState  == WAIT_DATA;

assign addrSRAM_read_addr = iact_read_addr;
assign dataSRAM_read_addr = iact_read_addr;  

Iact_addr_SRAM addrSRAM ( 
	.clock			(clock),                                             
	.reset			(reset),                                             
	.data_in_ready	(iact_address_in_ready),  
	.data_in_valid	(iact_address_in_valid),  
	.data_in		(iact_address_in),              
	.data_out_ready	(iact_address_out_ready),
	.data_out_valid	(iact_address_out_valid),
	.data_out		(iact_address_out),            
	.write_en		(adrSRAM_write_en),            
	.write_done		(adrSRAM_write_done),        
	.read_en		(adrSRAM_read_en),              
	.read_addr		(addrSRAM_read_addr),         
	.read_done		(adrSRAM_read_done)           
);

Iact_data_SRAM dataSRAM ( 
	.clock			(clock),                      
	.reset			(reset),                      
	.data_in_ready	(iact_data_in_ready), 
	.data_in_valid	(iact_data_in_valid), 
	.data_in		(iact_data_in),             
	.data_out_ready	(iact_data_out_ready),
	.data_out_valid	(iact_data_out_valid),
	.data_out		(iact_data_out),           
	.write_en		(dataSRAM_write_en),       
	.write_done		(dataSRAM_write_done),   
	.read_en		(dataSRAM_read_en),         
	.read_addr		(dataSRAM_read_addr),     
	.read_done		(dataSRAM_read_done)      
);


assign iact_write_done= ((inActWriteState == WAIT_ADDR) & adrSRAM_write_done) 	|| 
						((inActWriteState == WAIT_DATA) & dataSRAM_write_done)	||
						((inActWriteState == WORK) 	 	& WriteDoneAtSameTimeWire);
									
assign iact_read_done = ((inActReadState == WAIT_ADDR) 	& adrSRAM_read_done) 	|| 
						((inActReadState == WAIT_DATA) 	& dataSRAM_read_done)  	||
						((inActReadState == WORK) 		& ReadDoneAtSameTimeWire); 
						
// FSM
always @(posedge clock) begin
	if (reset) begin 
		inActReadState <= IDLE;
	end 
	else begin
		inActReadState <= next_inActReadState;
	end
end

always @(posedge clock) begin
	if (reset) begin 
		inActWriteState <= IDLE;
	end 
	else begin
		inActWriteState <= next_inActWriteState;
	end
end

always@(*) begin
	case(inActReadState)
		IDLE  	  : next_inActReadState = iact_read_en ? WORK : IDLE;
		WORK  	  : next_inActReadState = ReadDoneAtSameTimeWire ? IDLE : (adrSRAM_read_done ? WAIT_DATA : (dataSRAM_read_done ? WAIT_ADDR : WORK));
		WAIT_ADDR : next_inActReadState = adrSRAM_read_done  ? IDLE : WAIT_ADDR;
		WAIT_DATA : next_inActReadState = dataSRAM_read_done ? IDLE : WAIT_DATA;
		default   : next_inActReadState = IDLE;
	endcase
end

always@(*) begin
	case(inActWriteState)
		IDLE  	  : next_inActWriteState = iact_write_en ? WORK : IDLE;
		WORK  	  : next_inActWriteState = WriteDoneAtSameTimeWire ? IDLE : (adrSRAM_write_done ? WAIT_DATA : (dataSRAM_write_done ? WAIT_ADDR : WORK));
		WAIT_ADDR : next_inActWriteState = adrSRAM_write_done  ? IDLE : WAIT_ADDR;
		WAIT_DATA : next_inActWriteState = dataSRAM_write_done ? IDLE : WAIT_DATA;
		default   : next_inActWriteState = IDLE;
	endcase
end


endmodule
