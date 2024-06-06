// ====================================================================================================== //
// This module is psum router.
// psum router module is pure circuit switching (MUX).
// 3 psum ports in GLB connect to 3 PE in PE clusteer (one-to-one solumn) through psum routers.
// There are 3 ports(north, south, PE & GLB) in this module.
// This module contains 3 types of internal signals, internal_data, internal_data_valid, internal_data_ready.
// There 2 control signals from upper module, data_in_sel, data_out_sel, which can control the switching mode.
// data_in_sel and data_out_sel with valid and ready protocol, would estabalish 3-way handshake.
// 
// For data signals,  one MUX deals 2 ports input data  signals and use data_in_sel  to determine internal_data.
// For valid signals, one MUX deals 2 ports input valid signals and use data_in_sel  to determine internal_valid.
// For ready signals, one MUX deals 2 ports input ready signals and use data_out_sel to determine internal_ready.
//  
// data  out signals are connected directly to internal_data.
// valid out signals are determine by a MUX with data_out_sel control.
// ready out signals are determine by a MUX with data_in_sel control.
// 
// In psum router, the input signals of GLB are always sent to PE.
// ====================================================================================================== //


module Psum_Router (
	// source ports
	output        			PE_in_ready,
	input         			PE_in_valid,
	input	signed 	[20:0] 	PE_in,
	
	output        			GLB_in_ready,
	input         			GLB_in_valid,
	input 	signed	[20:0] 	GLB_in,
	
	output        			north_in_ready,
	input         			north_in_valid,
	input 	signed 	[20:0] 	north_in,
	
	// destination ports
	input         			PE_out_ready,
	output        			PE_out_valid,
	output 	signed 	[20:0]	PE_out,
	
	input         			GLB_out_ready,
	output        			GLB_out_valid,
	output 	signed 	[20:0]	GLB_out,
	
	input         			south_out_ready,
	output        			south_out_valid,
	output 	signed	[20:0]	south_out,
	
	// control
	input         			data_in_sel,
	input         			data_out_sel
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
// data in direction
localparam FROM_NOR = 1'b0;
localparam FROM_GLB = 1'b1;

// data out direction
localparam TO_SOU 	= 1'b0;
localparam TO_PE  	= 1'b1;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
// internal wire
wire internal_ready = (data_out_sel == TO_PE) 	? PE_out_ready 	: south_out_ready;
wire internal_valid = (data_in_sel == FROM_GLB) ? GLB_in_valid 	: north_in_valid;
wire internal_data 	= (data_in_sel == FROM_GLB) ? GLB_in 		: north_in;


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// PE always sent to GLB
assign PE_in_ready 		= GLB_out_ready;
assign GLB_out_valid 	= PE_in_valid;
assign GLB_out 			= PE_in;

assign GLB_in_ready 	= (data_in_sel == FROM_GLB) & internal_ready;
assign north_in_ready 	= (data_in_sel == FROM_NOR) & internal_ready;

assign PE_out_valid 	= (data_out_sel == TO_PE) 	& internal_valid;
assign PE_out 			= internal_data;

assign south_out_valid 	= (data_out_sel == TO_SOU) 	& internal_valid;
assign south_out 		= internal_data;

endmodule
