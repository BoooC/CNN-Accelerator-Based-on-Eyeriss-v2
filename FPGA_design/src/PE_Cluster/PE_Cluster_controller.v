// ====================================================================================================== //
// This module is PE cluster switcher.
// PE cluster controller module is used to switch the data from router by iact_data_in_sel and iact_data_out_sel.
// The two control data flow signals can control the direction of input data pass.
// Input data can transmit broad-cast or horizontal-multicast to the PE in PE cluster.
// ====================================================================================================== //


module PE_Cluster_controller (
	// true then broad-cast, and read the index of router that should be broad-casted,
	// false then only get the corresponding index of input activations router
	input         iact_data_in_sel,
	
	// iact_data_out_sel should be assigned to the index of router port when broad-cast;
	input  [1:0]  iact_data_out_sel,
	
	output        iact_from_router_0_address_in_ready,
	output        iact_from_router_1_address_in_ready,
	output        iact_from_router_2_address_in_ready,
	input         iact_from_router_0_address_in_valid,
	input         iact_from_router_1_address_in_valid,
	input         iact_from_router_2_address_in_valid,
	input  [7:0]  iact_from_router_0_address_in,
	input  [7:0]  iact_from_router_1_address_in,
	input  [7:0]  iact_from_router_2_address_in,
	
	output        iact_from_router_0_data_in_ready,
	output        iact_from_router_1_data_in_ready,
	output        iact_from_router_2_data_in_ready,
	input         iact_from_router_0_data_in_valid,
	input         iact_from_router_1_data_in_valid,
	input         iact_from_router_2_data_in_vaild,
	input  [12:0] iact_from_router_0_data_in,
	input  [12:0] iact_from_router_1_data_in,
	input  [12:0] iact_from_router_2_data_in,
	
	output        iact_to_PE_0_0_address_out_valid,
	output        iact_to_PE_0_1_address_out_valid,
	output        iact_to_PE_0_2_address_out_valid,
	output        iact_to_PE_1_0_address_out_valid,
	output        iact_to_PE_1_1_address_out_valid,
	output        iact_to_PE_1_2_address_out_valid,
	output        iact_to_PE_2_0_address_out_valid,
	output        iact_to_PE_2_1_address_out_valid,
	output        iact_to_PE_2_2_address_out_valid,
	
	output        iact_to_PE_0_0_data_out_valid,
	output        iact_to_PE_0_1_data_out_valid,
	output        iact_to_PE_0_2_data_out_valid,
	output        iact_to_PE_1_0_data_out_valid,
	output        iact_to_PE_1_1_data_out_valid,
	output        iact_to_PE_1_2_data_out_valid,
	output        iact_to_PE_2_0_data_out_valid,
	output        iact_to_PE_2_1_data_out_valid,
	output        iact_to_PE_2_2_data_out_valid,
	
	output [7:0]  iact_to_PE_0_0_address_out_bits,
	output [7:0]  iact_to_PE_0_1_address_out_bits,
	output [7:0]  iact_to_PE_0_2_address_out_bits,
	output [7:0]  iact_to_PE_1_0_address_out_bits,
	output [7:0]  iact_to_PE_1_1_address_out_bits,
	output [7:0]  iact_to_PE_1_2_address_out_bits,
	output [7:0]  iact_to_PE_2_0_address_out_bits,
	output [7:0]  iact_to_PE_2_1_address_out_bits,
	output [7:0]  iact_to_PE_2_2_address_out_bits,
	
	output [12:0] iact_to_PE_0_0_data_out_bits,
	output [12:0] iact_to_PE_0_1_data_out_bits,
	output [12:0] iact_to_PE_0_2_data_out_bits,
	output [12:0] iact_to_PE_1_0_data_out_bits,
	output [12:0] iact_to_PE_1_1_data_out_bits,	
	output [12:0] iact_to_PE_1_2_data_out_bits,	
	output [12:0] iact_to_PE_2_0_data_out_bits,
	output [12:0] iact_to_PE_2_1_data_out_bits,
	output [12:0] iact_to_PE_2_2_data_out_bits
);

localparam BROADCAST = 1'b1;

localparam ROUTER_0 = 2'd0;
localparam ROUTER_1 = 2'd1;
localparam ROUTER_2 = 2'd2;

wire  connections_iact_form_router_0_address_in_valid;
wire  connections_iact_form_router_1_address_in_valid; 
wire  connections_iact_form_router_2_address_in_valid; 

wire [7:0] connections_iact_form_router_0_address_in_bits;
wire [7:0] connections_iact_form_router_1_address_in_bits; 
wire [7:0] connections_iact_form_router_2_address_in_bits; 

wire  connections_iact_form_router_0_data_in_valid;
wire  connections_iact_form_router_1_data_in_valid; 
wire  connections_iact_form_router_2_data_in_valid; 

wire [12:0] connections_iact_form_router_0_data_in_bits;
wire [12:0] connections_iact_form_router_1_data_in_bits;
wire [12:0] connections_iact_form_router_2_data_in_bits;

wire connections_iact_to_PE_0_0_address_out_valid;	
wire connections_iact_to_PE_0_1_address_out_valid;	
wire connections_iact_to_PE_0_2_address_out_valid;	
wire connections_iact_to_PE_1_0_address_out_valid;	
wire connections_iact_to_PE_1_1_address_out_valid;	
wire connections_iact_to_PE_1_2_address_out_valid;	
wire connections_iact_to_PE_2_0_address_out_valid;	
wire connections_iact_to_PE_2_1_address_out_valid;	
wire connections_iact_to_PE_2_2_address_out_valid;	

wire connections_iact_to_PE_0_0_data_out_valid;		
wire connections_iact_to_PE_0_1_data_out_valid;		
wire connections_iact_to_PE_0_2_data_out_valid;			
wire connections_iact_to_PE_1_0_data_out_valid;		
wire connections_iact_to_PE_1_1_data_out_valid;		
wire connections_iact_to_PE_1_2_data_out_valid;			
wire connections_iact_to_PE_2_0_data_out_valid;		
wire connections_iact_to_PE_2_1_data_out_valid;		
wire connections_iact_to_PE_2_2_data_out_valid;		

PE_Cluster_Connection PE_Cluster_Connection_inst ( 
	.iact_to_PE_0_0_address_out_valid	(connections_iact_to_PE_0_0_address_out_valid	),
	.iact_to_PE_0_1_address_out_valid	(connections_iact_to_PE_0_1_address_out_valid	),
	.iact_to_PE_0_2_address_out_valid	(connections_iact_to_PE_0_2_address_out_valid	),
	.iact_to_PE_1_0_address_out_valid	(connections_iact_to_PE_1_0_address_out_valid	),
	.iact_to_PE_1_1_address_out_valid	(connections_iact_to_PE_1_1_address_out_valid	),
	.iact_to_PE_1_2_address_out_valid	(connections_iact_to_PE_1_2_address_out_valid	),
	.iact_to_PE_2_0_address_out_valid	(connections_iact_to_PE_2_0_address_out_valid	),
	.iact_to_PE_2_1_address_out_valid	(connections_iact_to_PE_2_1_address_out_valid	),
	.iact_to_PE_2_2_address_out_valid	(connections_iact_to_PE_2_2_address_out_valid	),
										
	.iact_to_PE_0_0_data_out_valid		(connections_iact_to_PE_0_0_data_out_valid		),
	.iact_to_PE_0_1_data_out_valid		(connections_iact_to_PE_0_1_data_out_valid		),
	.iact_to_PE_0_2_data_out_valid		(connections_iact_to_PE_0_2_data_out_valid		),
	.iact_to_PE_1_0_data_out_valid		(connections_iact_to_PE_1_0_data_out_valid		),
	.iact_to_PE_1_1_data_out_valid		(connections_iact_to_PE_1_1_data_out_valid		),
	.iact_to_PE_1_2_data_out_valid		(connections_iact_to_PE_1_2_data_out_valid		),
	.iact_to_PE_2_0_data_out_valid		(connections_iact_to_PE_2_0_data_out_valid		),
	.iact_to_PE_2_1_data_out_valid		(connections_iact_to_PE_2_1_data_out_valid		),
	.iact_to_PE_2_2_data_out_valid		(connections_iact_to_PE_2_2_data_out_valid		),
	
	.iact_to_PE_0_0_address_out_bits	(iact_to_PE_0_0_address_out_bits	),
	.iact_to_PE_0_1_address_out_bits	(iact_to_PE_0_1_address_out_bits	),
	.iact_to_PE_0_2_address_out_bits	(iact_to_PE_0_2_address_out_bits	),
	.iact_to_PE_1_0_address_out_bits	(iact_to_PE_1_0_address_out_bits	),
	.iact_to_PE_1_1_address_out_bits	(iact_to_PE_1_1_address_out_bits	),
	.iact_to_PE_1_2_address_out_bits	(iact_to_PE_1_2_address_out_bits	),
	.iact_to_PE_2_0_address_out_bits	(iact_to_PE_2_0_address_out_bits	),
	.iact_to_PE_2_1_address_out_bits	(iact_to_PE_2_1_address_out_bits	),
	.iact_to_PE_2_2_address_out_bits	(iact_to_PE_2_2_address_out_bits	),
	
	.iact_to_PE_0_0_data_out_bits		(iact_to_PE_0_0_data_out_bits		),
	.iact_to_PE_0_1_data_out_bits		(iact_to_PE_0_1_data_out_bits		),
	.iact_to_PE_0_2_data_out_bits		(iact_to_PE_0_2_data_out_bits		),
	.iact_to_PE_1_0_data_out_bits		(iact_to_PE_1_0_data_out_bits		),
	.iact_to_PE_1_1_data_out_bits		(iact_to_PE_1_1_data_out_bits		),
	.iact_to_PE_1_2_data_out_bits		(iact_to_PE_1_2_data_out_bits		),
	.iact_to_PE_2_0_data_out_bits		(iact_to_PE_2_0_data_out_bits		),
	.iact_to_PE_2_1_data_out_bits		(iact_to_PE_2_1_data_out_bits		),
	.iact_to_PE_2_2_data_out_bits		(iact_to_PE_2_2_data_out_bits		),
	
	.iact_form_router_0_address_in_valid(connections_iact_form_router_0_address_in_valid),
	.iact_form_router_1_address_in_valid(connections_iact_form_router_1_address_in_valid),
	.iact_form_router_2_address_in_valid(connections_iact_form_router_2_address_in_valid),
	.iact_form_router_0_data_in_valid	(connections_iact_form_router_0_data_in_valid	),
	.iact_form_router_1_data_in_valid	(connections_iact_form_router_1_data_in_valid	),
	.iact_form_router_2_data_in_valid	(connections_iact_form_router_2_data_in_valid	),
	
	.iact_form_router_0_address_in_bits	(connections_iact_form_router_0_address_in_bits	),
	.iact_form_router_1_address_in_bits	(connections_iact_form_router_1_address_in_bits	),
	.iact_form_router_2_address_in_bits	(connections_iact_form_router_2_address_in_bits	),
	.iact_form_router_0_data_in_bits	(connections_iact_form_router_0_data_in_bits	),
	.iact_form_router_1_data_in_bits	(connections_iact_form_router_1_data_in_bits	),
	.iact_form_router_2_data_in_bits	(connections_iact_form_router_2_data_in_bits	)
);


assign iact_to_PE_0_0_address_out_valid = connections_iact_to_PE_0_0_address_out_valid;	                            
assign iact_to_PE_0_1_address_out_valid = connections_iact_to_PE_0_1_address_out_valid;	                            
assign iact_to_PE_0_2_address_out_valid = connections_iact_to_PE_0_2_address_out_valid;	                             
assign iact_to_PE_1_0_address_out_valid = connections_iact_to_PE_1_0_address_out_valid;	                            
assign iact_to_PE_1_1_address_out_valid = connections_iact_to_PE_1_1_address_out_valid;	                            
assign iact_to_PE_1_2_address_out_valid = connections_iact_to_PE_1_2_address_out_valid;	                             
assign iact_to_PE_2_0_address_out_valid = connections_iact_to_PE_2_0_address_out_valid;	                            
assign iact_to_PE_2_1_address_out_valid = connections_iact_to_PE_2_1_address_out_valid;	                            
assign iact_to_PE_2_2_address_out_valid = connections_iact_to_PE_2_2_address_out_valid;	                             
                                                                         
assign iact_to_PE_0_0_data_out_valid = connections_iact_to_PE_0_0_data_out_valid;		                         
assign iact_to_PE_0_1_data_out_valid = connections_iact_to_PE_0_1_data_out_valid;		                         
assign iact_to_PE_0_2_data_out_valid = connections_iact_to_PE_0_2_data_out_valid;		                         
assign iact_to_PE_1_0_data_out_valid = connections_iact_to_PE_1_0_data_out_valid;		                         
assign iact_to_PE_1_1_data_out_valid = connections_iact_to_PE_1_1_data_out_valid;		                         
assign iact_to_PE_1_2_data_out_valid = connections_iact_to_PE_1_2_data_out_valid;			                         
assign iact_to_PE_2_0_data_out_valid = connections_iact_to_PE_2_0_data_out_valid;		                         
assign iact_to_PE_2_1_data_out_valid = connections_iact_to_PE_2_1_data_out_valid;		                         
assign iact_to_PE_2_2_data_out_valid = connections_iact_to_PE_2_2_data_out_valid;		                         
	
wire  iact_from_router_address_in_valid = 	(iact_data_out_sel == ROUTER_2) ? iact_from_router_2_address_in_valid : 
											(iact_data_out_sel == ROUTER_1) ? iact_from_router_1_address_in_valid : 
											(iact_data_out_sel == ROUTER_0) ? iact_from_router_0_address_in_valid : 1'b0; 
					
wire  iact_from_router_data_in_valid 	= 	(iact_data_out_sel == ROUTER_2) ? iact_from_router_2_data_in_vaild : 
											(iact_data_out_sel == ROUTER_1) ? iact_from_router_1_data_in_valid : 
											(iact_data_out_sel == ROUTER_0) ? iact_from_router_0_data_in_valid : 1'b0;
					
wire [7:0] iact_from_router_address_in 	= 	(iact_data_out_sel == ROUTER_2) ? iact_from_router_2_address_in : 
											(iact_data_out_sel == ROUTER_1) ? iact_from_router_1_address_in : 
											(iact_data_out_sel == ROUTER_0) ? iact_from_router_0_address_in : 'd0; 
					
wire [12:0] iact_from_router_data_in 	= 	(iact_data_out_sel == ROUTER_2) ? iact_from_router_2_data_in : 
											(iact_data_out_sel == ROUTER_1) ? iact_from_router_1_data_in : 
											(iact_data_out_sel == ROUTER_0) ? iact_from_router_0_data_in : 'd0; 

assign iact_from_router_0_address_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_0) ? 1'b1 : 1'b0) : 1'b1;
assign iact_from_router_0_data_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_0) ? 1'b1 : 1'b0) : 1'b1;
assign iact_from_router_1_address_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_1) ? 1'b1 : 1'b0) : 1'b1;
assign iact_from_router_1_data_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_1) ? 1'b1 : 1'b0) : 1'b1;
assign iact_from_router_2_address_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_2) ? 1'b1 : 1'b0) : 1'b1;
assign iact_from_router_2_data_in_ready 	= (iact_data_in_sel == BROADCAST) ? ((iact_data_out_sel == ROUTER_2) ? 1'b1 : 1'b0) : 1'b1;

// Broadcast: read the index of router that should be broadcasted,
// Otherwise: only get the corresponding index of input activations router
assign connections_iact_form_router_0_address_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in_valid 	: iact_from_router_0_address_in_valid;
assign connections_iact_form_router_1_address_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in_valid 	: iact_from_router_1_address_in_valid;
assign connections_iact_form_router_2_address_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in_valid 	: iact_from_router_2_address_in_valid;
assign connections_iact_form_router_0_data_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in_valid 		: iact_from_router_0_data_in_valid;
assign connections_iact_form_router_1_data_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in_valid 		: iact_from_router_1_data_in_valid;
assign connections_iact_form_router_2_data_in_valid 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in_valid 		: iact_from_router_2_data_in_vaild; 
assign connections_iact_form_router_0_address_in_bits 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in  		: iact_from_router_0_address_in;
assign connections_iact_form_router_1_address_in_bits 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in  		: iact_from_router_1_address_in;
assign connections_iact_form_router_2_address_in_bits 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_address_in  		: iact_from_router_2_address_in; 
assign connections_iact_form_router_0_data_in_bits 		= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in 			: iact_from_router_0_data_in;
assign connections_iact_form_router_1_data_in_bits 		= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in 			: iact_from_router_1_data_in;
assign connections_iact_form_router_2_data_in_bits	 	= (iact_data_in_sel == BROADCAST) ? iact_from_router_data_in 			: iact_from_router_2_data_in; 

endmodule
