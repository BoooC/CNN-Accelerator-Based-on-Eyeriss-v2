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


module Weight_Router (
	// source ports
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
	
	// destination ports
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
	
	// control signals
	input         data_in_sel,
	input         data_out_sel
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
// data out direction
localparam UNICAST 	= 1'b0;
localparam HOR_CAST = 1'b1;

// data in direction
localparam GLB   	= 1'b0;
localparam HORIZ	= 1'b1;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
// internal signals
wire internal_address_ready 	= (data_out_sel == HOR_CAST) 	? horiz_address_out_ready 	: 1'b1; // PE interface is always ready
wire internal_data_ready 		= (data_out_sel == HOR_CAST) 	? horiz_data_out_ready  	: 1'b1;
	
wire internal_address_valid 	= (data_in_sel == HORIZ) 		? horiz_address_in_valid 	: GLB_address_in_valid;
wire internal_data_valid 		= (data_in_sel == HORIZ) 		? horiz_data_in_valid 		: GLB_data_in_valid;

wire [7:0]	internal_address 	= (data_in_sel == HORIZ) 		? horiz_address_in 			: GLB_address_in;
wire [12:0]	internal_data 		= (data_in_sel == HORIZ) 		? horiz_data_in 			: GLB_data_in;

// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// in ready switching
assign GLB_address_in_ready 	= (data_in_sel == GLB)	 & internal_address_ready;
assign GLB_data_in_ready 		= (data_in_sel == GLB)	 & internal_data_ready;
														 
assign horiz_address_in_ready 	= (data_in_sel == HORIZ) & internal_address_ready;
assign horiz_data_in_ready 		= (data_in_sel == HORIZ) & internal_data_ready;

// data out switching
assign PE_address_out_valid 	= internal_address_valid;
assign PE_address_out 			= internal_address;
					
assign PE_data_out_valid 		= internal_data_valid;
assign PE_data_out 				= internal_data;

assign horiz_address_out_valid 	= (data_out_sel == HOR_CAST) & internal_address_valid;
assign horiz_address_out 		= internal_address;
	
assign horiz_data_out_valid 	= (data_out_sel == HOR_CAST) & internal_data_valid;
assign horiz_data_out 			= internal_data;


endmodule
