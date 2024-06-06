// ====================================================================================================== //
// This module is the connection topology of PE in PE cluster.
// PE cluster connection module is a pure combination circuit.
// This topology is only used to connects the data form router and to which PE.
// It can be adjusted to adapt different topology for different data flow design.
// The current design is all horizontal connection for weight stationary plus (WS+) data flow
// ====================================================================================================== //


module PE_Cluster_Connection (
	input         	iact_form_router_0_address_in_valid,
	input         	iact_form_router_1_address_in_valid,
	input         	iact_form_router_2_address_in_valid,
	
	input  	[7:0]  	iact_form_router_0_address_in_bits,
	input  	[7:0]  	iact_form_router_1_address_in_bits,
	input  	[7:0]  	iact_form_router_2_address_in_bits,
	
	input         	iact_form_router_0_data_in_valid,
	input         	iact_form_router_1_data_in_valid,
	input         	iact_form_router_2_data_in_valid,
	
	input 	[12:0] 	iact_form_router_0_data_in_bits,
	input 	[12:0] 	iact_form_router_1_data_in_bits,
	input 	[12:0] 	iact_form_router_2_data_in_bits,
	
	output        	iact_to_PE_0_0_address_out_valid,
	output        	iact_to_PE_0_1_address_out_valid,
	output        	iact_to_PE_0_2_address_out_valid,
	output        	iact_to_PE_1_0_address_out_valid,
	output        	iact_to_PE_1_1_address_out_valid,
	output        	iact_to_PE_1_2_address_out_valid,
	output        	iact_to_PE_2_0_address_out_valid,
	output        	iact_to_PE_2_2_address_out_valid,
	output        	iact_to_PE_2_1_address_out_valid,
	
	output 	[7:0]  	iact_to_PE_0_0_address_out_bits,
	output 	[7:0]  	iact_to_PE_0_1_address_out_bits,
	output 	[7:0]  	iact_to_PE_0_2_address_out_bits,
	output 	[7:0]  	iact_to_PE_1_0_address_out_bits,
	output 	[7:0]  	iact_to_PE_1_1_address_out_bits,
	output 	[7:0]  	iact_to_PE_1_2_address_out_bits,
	output 	[7:0]  	iact_to_PE_2_0_address_out_bits,
	output 	[7:0]  	iact_to_PE_2_1_address_out_bits,
	output 	[7:0]  	iact_to_PE_2_2_address_out_bits,
	
	output        	iact_to_PE_0_0_data_out_valid,
	output        	iact_to_PE_0_1_data_out_valid,
	output        	iact_to_PE_0_2_data_out_valid,
	output        	iact_to_PE_1_0_data_out_valid,
	output        	iact_to_PE_1_1_data_out_valid,
	output        	iact_to_PE_1_2_data_out_valid,
	output        	iact_to_PE_2_0_data_out_valid,
	output        	iact_to_PE_2_1_data_out_valid,
	output        	iact_to_PE_2_2_data_out_valid,
	
	output 	[12:0] 	iact_to_PE_0_0_data_out_bits,
	output 	[12:0] 	iact_to_PE_0_1_data_out_bits,
	output 	[12:0] 	iact_to_PE_0_2_data_out_bits,
	output 	[12:0] 	iact_to_PE_1_0_data_out_bits,
	output 	[12:0] 	iact_to_PE_1_1_data_out_bits,
	output 	[12:0] 	iact_to_PE_1_2_data_out_bits,
	output 	[12:0] 	iact_to_PE_2_0_data_out_bits,
	output 	[12:0] 	iact_to_PE_2_1_data_out_bits,
	output 	[12:0] 	iact_to_PE_2_2_data_out_bits
);


assign iact_to_PE_0_0_address_out_valid	= iact_form_router_0_address_in_valid;	
assign iact_to_PE_0_1_address_out_valid	= iact_form_router_0_address_in_valid;	
assign iact_to_PE_0_2_address_out_valid	= iact_form_router_0_address_in_valid;	

assign iact_to_PE_1_0_address_out_valid	= iact_form_router_1_address_in_valid;	
assign iact_to_PE_1_1_address_out_valid	= iact_form_router_1_address_in_valid;	
assign iact_to_PE_1_2_address_out_valid	= iact_form_router_1_address_in_valid;	

assign iact_to_PE_2_0_address_out_valid	= iact_form_router_2_address_in_valid;	
assign iact_to_PE_2_1_address_out_valid	= iact_form_router_2_address_in_valid;	
assign iact_to_PE_2_2_address_out_valid	= iact_form_router_2_address_in_valid;	

					
assign iact_to_PE_0_0_address_out_bits	= iact_form_router_0_address_in_bits;	
assign iact_to_PE_0_1_address_out_bits	= iact_form_router_0_address_in_bits;	
assign iact_to_PE_0_2_address_out_bits	= iact_form_router_0_address_in_bits;	
                  
assign iact_to_PE_1_0_address_out_bits	= iact_form_router_1_address_in_bits;	
assign iact_to_PE_1_1_address_out_bits	= iact_form_router_1_address_in_bits;	
assign iact_to_PE_1_2_address_out_bits	= iact_form_router_1_address_in_bits;
                  
assign iact_to_PE_2_0_address_out_bits	= iact_form_router_2_address_in_bits;	
assign iact_to_PE_2_1_address_out_bits	= iact_form_router_2_address_in_bits;	
assign iact_to_PE_2_2_address_out_bits	= iact_form_router_2_address_in_bits;	

					
assign iact_to_PE_0_0_data_out_valid	= iact_form_router_0_data_in_valid;	
assign iact_to_PE_0_1_data_out_valid	= iact_form_router_0_data_in_valid;	
assign iact_to_PE_0_2_data_out_valid	= iact_form_router_0_data_in_valid;	
                                                     
assign iact_to_PE_1_0_data_out_valid	= iact_form_router_1_data_in_valid;	
assign iact_to_PE_1_1_data_out_valid	= iact_form_router_1_data_in_valid;	
assign iact_to_PE_1_2_data_out_valid	= iact_form_router_1_data_in_valid;	
                                                     
assign iact_to_PE_2_0_data_out_valid	= iact_form_router_2_data_in_valid;		
assign iact_to_PE_2_1_data_out_valid	= iact_form_router_2_data_in_valid;		
assign iact_to_PE_2_2_data_out_valid	= iact_form_router_2_data_in_valid;		


assign iact_to_PE_0_0_data_out_bits		= iact_form_router_0_data_in_bits;	
assign iact_to_PE_0_1_data_out_bits		= iact_form_router_0_data_in_bits;							
assign iact_to_PE_0_2_data_out_bits		= iact_form_router_0_data_in_bits;	
					                                     
assign iact_to_PE_1_0_data_out_bits		= iact_form_router_1_data_in_bits;			
assign iact_to_PE_1_1_data_out_bits		= iact_form_router_1_data_in_bits;		
assign iact_to_PE_1_2_data_out_bits		= iact_form_router_1_data_in_bits;	
                                                     
assign iact_to_PE_2_0_data_out_bits		= iact_form_router_2_data_in_bits;	
assign iact_to_PE_2_1_data_out_bits		= iact_form_router_2_data_in_bits;	
assign iact_to_PE_2_2_data_out_bits		= iact_form_router_2_data_in_bits;	


endmodule                               
