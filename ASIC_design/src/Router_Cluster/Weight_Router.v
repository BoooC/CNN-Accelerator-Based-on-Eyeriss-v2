// ====================================================================================================== //
// This module is weight router.
// weight router module is pure circuit switching (MUX).
// 3 weight ports in GLB connect to 3 PE in PE clusteer (one-to-one row) through weight routers.
// There are 2 ports(horiz, PE & GLB) in this module.
// This module contains 3 types of internal signals, internal_data, internal_data_valid, internal_data_ready.
// There 2 control signals from upper module, data_in_sel, data_out_sel, which can control the switching mode.
// data_in_sel and data_out_sel with valid and ready protocol, would estabalish 3-way handshake.
// 
// For data signals,  one large MUX deals 2 ports input data  signals and use data_in_sel  to determine internal_data.
// For valid signals, one large MUX deals 2 ports input valid signals and use data_in_sel  to determine internal_valid.
// For ready signals, one large MUX deals 2 ports input ready signals and use data_out_sel to determine internal_ready.
//  
// data  out signals are connected directly to internal_data.
// valid out signals are determine by a MUX with data_out_sel control.
// ready out signals are determine by a MUX with data_in_sel control.
// 
// In weight router, input signals are always sent to PE.
// ====================================================================================================== //

module Weight_Router(
	// src ports
	output        GLB_address_in_ready,
	input         GLB_address_in_valid,
	input  [7:0]  GLB_address_in,
	output        GLB_data_in_ready,
	input         GLB_data_in_valid,
	input  [12:0] GLB_data_in,
	
	output        horiz_address_in_ready,
	input         horiz_address_in_valid,
	input  [7:0]  horiz_address_in,
	output        horiz_data_in_ready,
	input         horiz_data_in_valid,
	input  [12:0] horiz_data_in,
	
	// dst ports
	output        PE_address_out_valid,
	output [7:0]  PE_address_out,
	output        PE_data_out_valid,
	output [12:0] PE_data_out,
	
	input         horiz_address_out_ready,
	output        horiz_address_out_valid,
	output [7:0]  horiz_address_out,
	input         horiz_data_out_ready,
	output        horiz_data_out_valid,
	output [12:0] horiz_data_out,
	
	// control
	input         data_in_sel,
	input         data_out_sel
);

// data out direction
localparam UNICAST 		 = 1'b0;
localparam HOR_MULTICAST = 1'b1;

// data in direction
localparam GLB   = 1'b0;
localparam HORIZ = 1'b1;

// internal wire
wire internal_address_ready 	= (data_out_sel == HOR_MULTICAST) ? horiz_address_out_ready : 1'b1; // PE interface is always ready
wire internal_data_ready 		= (data_out_sel == HOR_MULTICAST) ? horiz_data_out_ready  	: 1'b1;
	
wire internal_address_valid 	= (data_in_sel == HORIZ) ? horiz_address_in_valid 	: GLB_address_in_valid;
wire internal_data_valid 		= (data_in_sel == HORIZ) ? horiz_data_in_valid 		: GLB_data_in_valid;

// ready out switching
assign GLB_address_in_ready 	= (data_in_sel == GLB) ? internal_address_ready : 1'b0;
assign GLB_data_in_ready 		= (data_in_sel == GLB) ? internal_data_ready 	: 1'b0;

assign horiz_address_in_ready 	= (data_in_sel == HORIZ) & internal_address_ready;
assign horiz_data_in_ready 		= (data_in_sel == HORIZ) & internal_data_ready;

// data out switching
assign PE_address_out_valid 	= (data_in_sel == HORIZ) ? horiz_address_in_valid 	: GLB_address_in_valid;
assign PE_address_out 			= (data_in_sel == HORIZ) ? horiz_address_in 		: GLB_address_in;
	
assign PE_data_out_valid 		= (data_in_sel == HORIZ) ? horiz_data_in_valid 	: GLB_data_in_valid;
assign PE_data_out 				= (data_in_sel == HORIZ) ? horiz_data_in 		: GLB_data_in;

assign horiz_address_out_valid 	= (data_out_sel == HOR_MULTICAST) ? internal_address_valid 	: 1'b0;
assign horiz_address_out 		= (data_in_sel  == HORIZ) 		  ? horiz_address_in 		: GLB_address_in;

assign horiz_data_out_valid 	= (data_out_sel == HOR_MULTICAST) ? internal_data_valid : 1'b0;
assign horiz_data_out 			= (data_in_sel  == HORIZ) 		  ? horiz_data_in 		: GLB_data_in;


endmodule
