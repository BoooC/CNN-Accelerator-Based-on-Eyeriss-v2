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

module Iact_Router(
	// src ports
	output        GLB_address_in_ready,
	input         GLB_address_in_valid,
	input  [6:0]  GLB_address_in,
	output        GLB_data_in_ready,
	input         GLB_data_in_valid,
	input  [11:0] GLB_data_in,
	
	output        north_address_in_ready,
	input         north_address_in_valid,
	input  [6:0]  north_address_in,
	output        north_data_in_ready,
	input         north_data_in_valid,
	input  [11:0] north_data_in,
	
	output        south_address_in_ready,
	input         south_address_in_valid,
	input  [6:0]  south_address_in,
	output        south_data_in_ready,
	input         south_data_in_valid,
	input  [11:0] south_data_in,
	
	output        horiz_address_in_ready,
	input         horiz_address_in_valid,
	input  [6:0]  horiz_address_in,
	output        horiz_data_in_ready,
	input         horiz_data_in_valid,
	input  [11:0] horiz_data_in,
	
	// dst ports
	input         		PE_address_out_ready,
	output reg       	PE_address_out_valid,
	output reg [6:0]  	PE_address_out,
	input         		PE_data_out_ready,
	output reg       	PE_data_out_valid,
	output reg [11:0] 	PE_data_out,
	
	input				north_address_out_ready,
	output reg        	north_address_out_valid,
	output reg [6:0]  	north_address_out,
	input				north_data_out_ready,
	output reg        	north_data_out_valid,
	output reg [11:0] 	north_data_out,
	
	input         		south_address_out_ready,
	output reg        	south_address_out_valid,
	output reg [6:0]  	south_address_out,
	input         		south_data_out_ready,
	output reg        	south_data_out_valid,
	output reg [11:0] 	south_data_out,
	
	input         		horiz_address_out_ready,
	output reg        	horiz_address_out_valid,
	output reg [6:0]  	horiz_address_out,
	input         		horiz_data_out_ready,
	output reg        	horiz_data_out_valid,
	output reg [11:0]	horiz_data_out,
	
	// control
	input  [1:0]  		data_in_sel,
	input  [1:0]  		data_out_sel
);


// data out direction
localparam UNICAST 		 = 2'b00;
localparam HOR_MULTICAST = 2'b01;
localparam VER_MULTICAST = 2'b10;
localparam BROADCAST 	 = 2'b11;

// data in direction
localparam GLB   = 2'b00;
localparam NORTH = 2'b01;
localparam SOUTH = 2'b10;
localparam HORIZ = 2'b11;

wire  sel_GLB_in 	= data_in_sel == GLB; 
wire  sel_north_in 	= data_in_sel == NORTH; 
wire  sel_south_in 	= data_in_sel == SOUTH; 

wire  unicast 		= data_out_sel == UNICAST; 
wire  hor_multicast = data_out_sel == HOR_MULTICAST; 
wire  ver_multicast = data_out_sel == VER_MULTICAST; 

reg  internal_address_ready;
reg  internal_data_ready;
reg  internal_address_valid;
reg  internal_data_valid;

always@(*) begin
	case(data_out_sel)
		UNICAST 		: internal_address_ready = PE_address_out_ready;
		HOR_MULTICAST   : internal_address_ready = PE_address_out_ready & horiz_address_out_ready;
		VER_MULTICAST	: internal_address_ready = PE_address_out_ready & south_address_out_ready; // south_address_out_ready;
		BROADCAST 	   	: internal_address_ready = PE_address_out_ready & north_address_out_ready & south_address_out_ready & horiz_address_out_ready; // horiz_address_out_ready;
		default 		: internal_address_ready = 1'b1;
	endcase
end

always@(*) begin
	case(data_out_sel)
		UNICAST 		: internal_data_ready = PE_data_out_ready;
		HOR_MULTICAST   : internal_data_ready = PE_data_out_ready & horiz_data_out_ready;
		VER_MULTICAST	: internal_data_ready = PE_data_out_ready & south_data_out_ready; // south_data_out_ready;
		BROADCAST 	   	: internal_data_ready = PE_data_out_ready & north_data_out_ready & south_data_out_ready & horiz_data_out_ready; // horiz_data_out_ready;
		default 		: internal_data_ready = 1'b1;
	endcase
end


always@(*) begin
	case(data_in_sel)
		GLB     : internal_address_valid = GLB_address_in_valid;
		NORTH   : internal_address_valid = north_address_in_valid;
		SOUTH   : internal_address_valid = south_address_in_valid;
		HORIZ   : internal_address_valid = horiz_address_in_valid;
		default : internal_address_valid = 1'b1;
	endcase
end

always@(*) begin
	case(data_in_sel)
		GLB     : internal_data_valid = GLB_data_in_valid;
		NORTH   : internal_data_valid = north_data_in_valid;
		SOUTH   : internal_data_valid = south_data_in_valid;
		HORIZ   : internal_data_valid = horiz_data_in_valid;
		default : internal_data_valid = 1'b1;
	endcase
end

assign GLB_address_in_ready 	= (data_in_sel == GLB) ? internal_address_ready 	: 1'b0;
assign GLB_data_in_ready 		= (data_in_sel == GLB) ? internal_data_ready 		: 1'b0; 

assign north_address_in_ready 	= (data_in_sel == NORTH) ? internal_address_ready 	: 1'b0;
assign north_data_in_ready 		= (data_in_sel == NORTH) ? internal_data_ready 		: 1'b0;

assign south_address_in_ready 	= (data_in_sel == SOUTH) ? internal_address_ready 	: 1'b0;
assign south_data_in_ready 		= (data_in_sel == SOUTH) ? internal_data_ready 		: 1'b0;

assign horiz_address_in_ready	= (data_in_sel == HORIZ) ? internal_address_ready 	: 1'b0;
assign horiz_data_in_ready 		= (data_in_sel == HORIZ) ? internal_data_ready 		: 1'b0;


// data and address are always sent to PE
always@(*) begin
	case(data_in_sel)
		GLB : begin
			PE_address_out_valid 	= GLB_address_in_valid;
			PE_address_out 			= GLB_address_in;
			PE_data_out_valid 		= GLB_data_in_valid;
			PE_data_out 			= GLB_data_in;
		end
		NORTH : begin
			PE_address_out_valid 	= north_address_in_valid;
			PE_address_out 			= north_address_in;
			PE_data_out_valid 		= north_data_in_valid;
			PE_data_out 			= north_data_in;
		end
		SOUTH : begin
			PE_address_out_valid 	= south_address_in_valid;
			PE_address_out 			= south_address_in;
			PE_data_out_valid 		= south_data_in_valid;
			PE_data_out 			= sel_south_in;
		end
		HORIZ : begin
			PE_address_out_valid 	= horiz_address_in_valid;
			PE_address_out 			= horiz_address_in;
			PE_data_out_valid 		= horiz_data_in_valid;
			PE_data_out 			= horiz_data_in;
		end
		default : begin
			PE_address_out_valid 	= 'd0;
			PE_address_out 			= 'd0;
			PE_data_out_valid 		= 'd0;
			PE_data_out 			= 'd0;
		end
	endcase
end


always@(*) begin
	case(data_in_sel)
		GLB : begin
			north_address_out 	= GLB_address_in;
			south_address_out 	= GLB_address_in;
			horiz_address_out 	= GLB_address_in;
			north_data_out 		= GLB_data_in;
			south_data_out 		= GLB_data_in;
			horiz_data_out 		= GLB_data_in;
		end	
		NORTH : begin
			north_address_out 	= north_address_in;
			south_address_out 	= north_address_in;
			horiz_address_out 	= north_address_in;
			north_data_out 		= north_data_in;
			south_data_out 		= north_data_in;
			horiz_data_out 		= north_data_in;
		end	
		SOUTH : begin
			north_address_out 	= south_address_in;
			south_address_out 	= south_address_in;
			horiz_address_out 	= south_address_in;
			north_data_out 		= south_data_in;
			south_data_out 		= south_data_in;
			horiz_data_out 		= south_data_in;
		end	
		HORIZ : begin
			north_address_out 	= horiz_address_in;
			south_address_out 	= horiz_address_in;
			horiz_address_out 	= horiz_address_in;
			north_data_out 		= horiz_data_in;
			south_data_out 		= horiz_data_in;
			horiz_data_out 		= horiz_data_in;
		end	
		default : begin
			north_address_out 	= 'd0;
			south_address_out 	= 'd0;
			horiz_address_out 	= 'd0;
			north_data_out 		= 'd0;
			south_data_out	 	= 'd0;
			horiz_data_out 		= 'd0;
		end	                     
	endcase                      
end


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
		HOR_MULTICAST : begin
			north_address_out_valid = 1'b0;
			south_address_out_valid = 1'b0;
			horiz_address_out_valid = internal_address_valid;
			north_data_out_valid 	= 1'b0;
			south_data_out_valid 	= 1'b0;
			horiz_data_out_valid 	= internal_data_valid;
		end	
		VER_MULTICAST : begin
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

endmodule