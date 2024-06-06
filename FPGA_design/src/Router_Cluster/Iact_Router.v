// ====================================================================================================== //
// This module is iact router.
// iact router module is pure circuit switching (MUX).
// 9 iact SRAM connect to 9 PE in PE clusteer (one-to-one) through iact routers.
// There are 4 ports(north, south, horiz, PE & GLB) in this module.
// This module contains 3 types of internal signals, internal_data, internal_data_valid, internal_data_ready.
// There 2 control signals from upper module, data_in_sel, data_out_sel, which can control the switching mode.
// data_in_sel and data_out_sel with valid and ready protocol, would estabalish 3-way handshake.
// 
// For data signals,  one large MUX deals 4 ports input data  signals and use data_in_sel  to determine internal_data.
// For valid signals, one large MUX deals 4 ports input valid signals and use data_in_sel  to determine internal_valid.
// For ready signals, one large MUX deals 4 ports input ready signals and use data_out_sel to determine internal_ready.
//  
// data  out signals are connected directly to internal_data.
// valid out signals are determine by a MUX with data_out_sel control.
// ready out signals are determine by a MUX with data_in_sel control.
// 
// In iact router, input signals are always sent to PE.
// ====================================================================================================== //


module Iact_Router (
	// source ports
	output 		       GLB_address_in_ready,
	input  		       GLB_address_in_valid,
	input  		[6:0]  GLB_address_in,
	output 		       GLB_data_in_ready,
	input  		       GLB_data_in_valid,
	input  		[11:0] GLB_data_in,
			
	output 		       north_address_in_ready,
	input  		       north_address_in_valid,
	input  		[6:0]  north_address_in,
	output 		       north_data_in_ready,
	input  		       north_data_in_valid,
	input  		[11:0] north_data_in,
			
	output 		       south_address_in_ready,
	input  		       south_address_in_valid,
	input  		[6:0]  south_address_in,
	output 		       south_data_in_ready,
	input  		       south_data_in_valid,
	input  		[11:0] south_data_in,
			
	output 		       horiz_address_in_ready,
	input  		       horiz_address_in_valid,
	input  		[6:0]  horiz_address_in,
	output 		       horiz_data_in_ready,
	input  		       horiz_data_in_valid,
	input  		[11:0] horiz_data_in,
	
	// destination ports
	input         		PE_address_out_ready,
	output 		       	PE_address_out_valid,
	output		[6:0]  	PE_address_out,
	input         		PE_data_out_ready,
	output        		PE_data_out_valid,
	output 	 	[11:0] 	PE_data_out,
	
	input				north_address_out_ready,
	output 	reg        	north_address_out_valid,
	output 	 	[6:0]  	north_address_out,
	input				north_data_out_ready,
	output 	reg        	north_data_out_valid,
	output 	 	[11:0] 	north_data_out,
	
	input         		south_address_out_ready,
	output 	reg        	south_address_out_valid,
	output 	 	[6:0]  	south_address_out,
	input         		south_data_out_ready,
	output 	reg        	south_data_out_valid,
	output 	 	[11:0] 	south_data_out,
	
	input         		horiz_address_out_ready,
	output 	reg        	horiz_address_out_valid,
	output 	 	[6:0]  	horiz_address_out,
	input         		horiz_data_out_ready,
	output	reg	       	horiz_data_out_valid,
	output 	 	[11:0]	horiz_data_out,
	
	// control
	input  		[1:0]  	data_in_sel,
	input  		[1:0]  	data_out_sel
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
// data out direction
localparam UNICAST 		= 2'b00;
localparam HOR_CAST		= 2'b01;
localparam VER_CAST		= 2'b10;
localparam BROADCAST 	= 2'b11;

// data in direction
localparam GLB   = 2'b00;
localparam NORTH = 2'b01;
localparam SOUTH = 2'b10;
localparam HORIZ = 2'b11;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
reg  		internal_address_ready;
reg  		internal_data_ready;
reg  		internal_address_valid;
reg  		internal_data_valid;
reg [6:0] 	internal_address;
reg [11:0]	internal_data;


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// output in_ready signals
assign GLB_address_in_ready 	= (data_in_sel == GLB) 	 & internal_address_ready;
assign GLB_data_in_ready 		= (data_in_sel == GLB) 	 & internal_data_ready; 
														 
assign north_address_in_ready 	= (data_in_sel == NORTH) & internal_address_ready;
assign north_data_in_ready 		= (data_in_sel == NORTH) & internal_data_ready;
														 
assign south_address_in_ready 	= (data_in_sel == SOUTH) & internal_address_ready;
assign south_data_in_ready 		= (data_in_sel == SOUTH) & internal_data_ready;
														 
assign horiz_address_in_ready	= (data_in_sel == HORIZ) & internal_address_ready;
assign horiz_data_in_ready 		= (data_in_sel == HORIZ) & internal_data_ready;

// data and address are always sent to PE
assign PE_address_out_valid = internal_address_valid;
assign PE_data_out_valid	= internal_data_valid;

// internal data and address are connected to all ports
assign PE_address_out		= internal_address;
assign north_address_out 	= internal_address;
assign south_address_out 	= internal_address;
assign horiz_address_out 	= internal_address;
assign PE_data_out			= internal_data;
assign north_data_out 		= internal_data;
assign south_data_out 		= internal_data;
assign horiz_data_out 		= internal_data;

// use vvalid signal to determine routing mode
always@(*) begin
	case(data_out_sel)
		UNICAST : begin
			north_address_out_valid = 1'b0;
			south_address_out_valid	= 1'b0;
			horiz_address_out_valid = 1'b0;
			north_data_out_valid 	= 1'b0;
			south_data_out_valid 	= 1'b0;
			horiz_data_out_valid 	= 1'b0;
		end	
		HOR_CAST : begin
			north_address_out_valid = 1'b0;
			south_address_out_valid = 1'b0;
			horiz_address_out_valid = internal_address_valid;
			north_data_out_valid 	= 1'b0;
			south_data_out_valid 	= 1'b0;
			horiz_data_out_valid 	= internal_data_valid;
		end	
		VER_CAST : begin
			north_address_out_valid = internal_address_valid; 
			south_address_out_valid = internal_address_valid; 
			horiz_address_out_valid = 1'b0;
			north_data_out_valid 	= internal_data_valid; 
			south_data_out_valid 	= internal_data_valid; 
			horiz_data_out_valid 	= 1'b0;
		end	
		BROADCAST : begin
			north_address_out_valid = internal_address_valid; 
			south_address_out_valid = internal_address_valid; 
			horiz_address_out_valid = internal_address_valid;
			north_data_out_valid 	= internal_data_valid; 
			south_data_out_valid 	= internal_data_valid; 
			horiz_data_out_valid 	= internal_data_valid;
		end	
		default : begin
			north_address_out_valid = 'd0;
			south_address_out_valid = 'd0;
			horiz_address_out_valid = 'd0;
			north_data_out_valid 	= 'd0;
			south_data_out_valid 	= 'd0;
			horiz_data_out_valid 	= 'd0;
		end	                        
	endcase                         
end


// internal signals
always@(*) begin
	case(data_out_sel)
		UNICAST 		: internal_address_ready = PE_address_out_ready;
		HOR_CAST   : internal_address_ready = PE_address_out_ready & horiz_address_out_ready;
		VER_CAST	: internal_address_ready = PE_address_out_ready & south_address_out_ready;
		BROADCAST 	   	: internal_address_ready = PE_address_out_ready & north_address_out_ready & south_address_out_ready & horiz_address_out_ready;
		default 		: internal_address_ready = 1'b1;
	endcase
end

always@(*) begin
	case(data_out_sel)
		UNICAST 		: internal_data_ready = PE_data_out_ready;
		HOR_CAST   : internal_data_ready = PE_data_out_ready & horiz_data_out_ready;
		VER_CAST	: internal_data_ready = PE_data_out_ready & south_data_out_ready; 
		BROADCAST 	   	: internal_data_ready = PE_data_out_ready & north_data_out_ready & south_data_out_ready & horiz_data_out_ready; 
		default 		: internal_data_ready = 1'b1;
	endcase
end

always@(*) begin
	case(data_in_sel)
		GLB     : internal_address_valid = GLB_address_in_valid;
		NORTH   : internal_address_valid = north_address_in_valid;
		SOUTH   : internal_address_valid = south_address_in_valid;
		HORIZ   : internal_address_valid = horiz_address_in_valid;
		default : internal_address_valid = 1'b0;
	endcase
end

always@(*) begin
	case(data_in_sel)
		GLB     : internal_data_valid = GLB_data_in_valid;
		NORTH   : internal_data_valid = north_data_in_valid;
		SOUTH   : internal_data_valid = south_data_in_valid;
		HORIZ   : internal_data_valid = horiz_data_in_valid;
		default : internal_data_valid = 1'b0;
	endcase
end

always@(*) begin
	case(data_in_sel)
		GLB     : internal_address = GLB_address_in;
		NORTH   : internal_address = north_address_in;
		SOUTH   : internal_address = south_address_in;
		HORIZ   : internal_address = horiz_address_in;
		default : internal_address = 'd0;
	endcase
end

always@(*) begin
	case(data_in_sel)
		GLB     : internal_data = GLB_data_in;
		NORTH   : internal_data = north_data_in;
		SOUTH   : internal_data = south_data_in;
		HORIZ   : internal_data = horiz_data_in;
		default : internal_data = 'd0;
	endcase
end


endmodule