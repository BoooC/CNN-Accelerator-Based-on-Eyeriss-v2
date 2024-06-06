// ====================================================================================================== //
// This module is GLB cluster.
// GLB cluster module contains 9 iact SRAM and 3 psum SRAM.
// 9 iact SRAM connect to 9 PE in PE clusteer (one-to-one).
// 9 iact SRAM is used to support uni-cast in all layers.
// 9 iact SRAM is mainly to supply sufficient bandwidth.
// If SRAM BW is not a bottlenect for specific application, 9 iact SRAM can be scale down to 3. 
// 
// GLB cluster contains weight ports, but there is no SRAM to store weight data.
// weight data in GLB cluster will be directly pass to PE cluster and store in PE SPad (SRAM)
// ====================================================================================================== //


module GLB_Cluster (
	input        			clock,
	input        			reset,
	
	// iact SRAM Bank 0_0
	output 			       	iact_SRAM_Bank_0_0_address_in_ready,
	input  			       	iact_SRAM_Bank_0_0_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_0_0_address_in,
	output 			       	iact_SRAM_Bank_0_0_data_in_ready,
	input  			       	iact_SRAM_Bank_0_0_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_0_0_data_in,
												
	input  			       	iact_SRAM_Bank_0_0_address_out_ready,
	output 			       	iact_SRAM_Bank_0_0_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_0_0_address_out,
	input  			       	iact_SRAM_Bank_0_0_data_out_ready,
	output 			       	iact_SRAM_Bank_0_0_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_0_0_data_out,
												
	input  			       	iact_SRAM_Bank_0_0_write_en,
	output 			       	iact_SRAM_Bank_0_0_write_done,
	input  			       	iact_SRAM_Bank_0_0_read_en,
	input  			[9:0]  	iact_SRAM_Bank_0_0_read_addr,
	output 			       	iact_SRAM_Bank_0_0_read_done,		
	
	// iact SRAM Bank 0_1
	output 			      	iact_SRAM_Bank_0_1_address_in_ready,
	input  			      	iact_SRAM_Bank_0_1_address_in_valid,
	input  			[6:0] 	iact_SRAM_Bank_0_1_address_in,
	output 			      	iact_SRAM_Bank_0_1_data_in_ready,
	input  			      	iact_SRAM_Bank_0_1_data_in_valid,
	input  			[11:0]	iact_SRAM_Bank_0_1_data_in,
												
	input  			      	iact_SRAM_Bank_0_1_address_out_ready,
	output 			      	iact_SRAM_Bank_0_1_address_out_valid,
	output 			[6:0] 	iact_SRAM_Bank_0_1_address_out,
	input  			      	iact_SRAM_Bank_0_1_data_out_ready,
	output 			      	iact_SRAM_Bank_0_1_data_out_valid,
	output 			[11:0]	iact_SRAM_Bank_0_1_data_out,
												
	input  			      	iact_SRAM_Bank_0_1_write_en,
	output 			      	iact_SRAM_Bank_0_1_write_done,
	input  			      	iact_SRAM_Bank_0_1_read_en,
	input  			[9:0] 	iact_SRAM_Bank_0_1_read_addr,
	output 			      	iact_SRAM_Bank_0_1_read_done,		
		
	// iact SRAM Bank 0_2
	output 			       	iact_SRAM_Bank_0_2_address_in_ready,
	input  			       	iact_SRAM_Bank_0_2_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_0_2_address_in,
	output 			       	iact_SRAM_Bank_0_2_data_in_ready,
	input  			       	iact_SRAM_Bank_0_2_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_0_2_data_in,
												
	input  			       	iact_SRAM_Bank_0_2_address_out_ready,
	output 			       	iact_SRAM_Bank_0_2_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_0_2_address_out,
	input  			       	iact_SRAM_Bank_0_2_data_out_ready,
	output 			       	iact_SRAM_Bank_0_2_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_0_2_data_out,
												
	input  			       	iact_SRAM_Bank_0_2_write_en,
	output 			       	iact_SRAM_Bank_0_2_write_done,
	input  			       	iact_SRAM_Bank_0_2_read_en,
	input  			[9:0]  	iact_SRAM_Bank_0_2_read_addr,
	output 			       	iact_SRAM_Bank_0_2_read_done,	
	
	// iact SRAM Bank 1_0
	output			      	iact_SRAM_Bank_1_0_address_in_ready,
	input 			      	iact_SRAM_Bank_1_0_address_in_valid,
	input 			[6:0] 	iact_SRAM_Bank_1_0_address_in,
	output			      	iact_SRAM_Bank_1_0_data_in_ready,
	input 			      	iact_SRAM_Bank_1_0_data_in_valid,
	input 			[11:0]	iact_SRAM_Bank_1_0_data_in,
												
	input 			      	iact_SRAM_Bank_1_0_address_out_ready,
	output			      	iact_SRAM_Bank_1_0_address_out_valid,
	output			[6:0] 	iact_SRAM_Bank_1_0_address_out,
	input 			      	iact_SRAM_Bank_1_0_data_out_ready,
	output			      	iact_SRAM_Bank_1_0_data_out_valid,
	output			[11:0]	iact_SRAM_Bank_1_0_data_out,
												
	input 			      	iact_SRAM_Bank_1_0_write_en,
	output			      	iact_SRAM_Bank_1_0_write_done,
	input 			      	iact_SRAM_Bank_1_0_read_en,
	input 			[9:0] 	iact_SRAM_Bank_1_0_read_addr,
	output			      	iact_SRAM_Bank_1_0_read_done,		
								
	// iact SRAM Bank 1_1       
	output			       	iact_SRAM_Bank_1_1_address_in_ready,
	input 			       	iact_SRAM_Bank_1_1_address_in_valid,
	input 			[6:0]  	iact_SRAM_Bank_1_1_address_in,
	output			       	iact_SRAM_Bank_1_1_data_in_ready,
	input 			       	iact_SRAM_Bank_1_1_data_in_valid,
	input 			[11:0] 	iact_SRAM_Bank_1_1_data_in,
												
	input 			       	iact_SRAM_Bank_1_1_address_out_ready,
	output			       	iact_SRAM_Bank_1_1_address_out_valid,
	output			[6:0]  	iact_SRAM_Bank_1_1_address_out,
	input 			       	iact_SRAM_Bank_1_1_data_out_ready,
	output			       	iact_SRAM_Bank_1_1_data_out_valid,
	output			[11:0] 	iact_SRAM_Bank_1_1_data_out,
												
	input 			       	iact_SRAM_Bank_1_1_write_en,
	output			       	iact_SRAM_Bank_1_1_write_done,
	input 			       	iact_SRAM_Bank_1_1_read_en,
	input 			[9:0]  	iact_SRAM_Bank_1_1_read_addr,
	output			       	iact_SRAM_Bank_1_1_read_done,		
								 
	// iact SRAM Bank 1_2        
	output 			       	iact_SRAM_Bank_1_2_address_in_ready,
	input  			       	iact_SRAM_Bank_1_2_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_1_2_address_in,
	output 			       	iact_SRAM_Bank_1_2_data_in_ready,
	input  			       	iact_SRAM_Bank_1_2_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_1_2_data_in,
												
	input  			       	iact_SRAM_Bank_1_2_address_out_ready,
	output 			       	iact_SRAM_Bank_1_2_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_1_2_address_out,
	input  			       	iact_SRAM_Bank_1_2_data_out_ready,
	output 			       	iact_SRAM_Bank_1_2_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_1_2_data_out,
												
	input  			       	iact_SRAM_Bank_1_2_write_en,
	output 			       	iact_SRAM_Bank_1_2_write_done,
	input  			       	iact_SRAM_Bank_1_2_read_en,
	input  			[9:0]  	iact_SRAM_Bank_1_2_read_addr,
	output 			       	iact_SRAM_Bank_1_2_read_done,	


	// iact SRAM Bank 2_0
	output 			       	iact_SRAM_Bank_2_0_address_in_ready,
	input  			       	iact_SRAM_Bank_2_0_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_2_0_address_in,
	output 			       	iact_SRAM_Bank_2_0_data_in_ready,
	input  			       	iact_SRAM_Bank_2_0_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_2_0_data_in,
												
	input  			       	iact_SRAM_Bank_2_0_address_out_ready,
	output 			       	iact_SRAM_Bank_2_0_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_2_0_address_out,
	input  			       	iact_SRAM_Bank_2_0_data_out_ready,
	output 			       	iact_SRAM_Bank_2_0_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_2_0_data_out,
												
	input  			       	iact_SRAM_Bank_2_0_write_en,
	output 			       	iact_SRAM_Bank_2_0_write_done,
	input  			       	iact_SRAM_Bank_2_0_read_en,
	input  			[9:0]  	iact_SRAM_Bank_2_0_read_addr,
	output 			       	iact_SRAM_Bank_2_0_read_done,		
								 
	// iact SRAM Bank 2_1        
	output 			       	iact_SRAM_Bank_2_1_address_in_ready,
	input  			       	iact_SRAM_Bank_2_1_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_2_1_address_in,
	output 			       	iact_SRAM_Bank_2_1_data_in_ready,
	input  			       	iact_SRAM_Bank_2_1_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_2_1_data_in,
												
	input  			       	iact_SRAM_Bank_2_1_address_out_ready,
	output 			       	iact_SRAM_Bank_2_1_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_2_1_address_out,
	input  			       	iact_SRAM_Bank_2_1_data_out_ready,
	output 			       	iact_SRAM_Bank_2_1_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_2_1_data_out,
												
	input  			       	iact_SRAM_Bank_2_1_write_en,
	output 			       	iact_SRAM_Bank_2_1_write_done,
	input  			       	iact_SRAM_Bank_2_1_read_en,
	input  			[9:0]  	iact_SRAM_Bank_2_1_read_addr,
	output 			       	iact_SRAM_Bank_2_1_read_done,		
								
	// iact SRAM Bank 2_2        
	output 			       	iact_SRAM_Bank_2_2_address_in_ready,
	input  			       	iact_SRAM_Bank_2_2_address_in_valid,
	input  			[6:0]  	iact_SRAM_Bank_2_2_address_in,
	output 			       	iact_SRAM_Bank_2_2_data_in_ready,
	input  			       	iact_SRAM_Bank_2_2_data_in_valid,
	input  			[11:0] 	iact_SRAM_Bank_2_2_data_in,
												
	input  			       	iact_SRAM_Bank_2_2_address_out_ready,
	output 			       	iact_SRAM_Bank_2_2_address_out_valid,
	output 			[6:0]  	iact_SRAM_Bank_2_2_address_out,
	input  			       	iact_SRAM_Bank_2_2_data_out_ready,
	output 			       	iact_SRAM_Bank_2_2_data_out_valid,
	output 			[11:0] 	iact_SRAM_Bank_2_2_data_out,
												
	input  			       	iact_SRAM_Bank_2_2_write_en,
	output 			       	iact_SRAM_Bank_2_2_write_done,
	input  			       	iact_SRAM_Bank_2_2_read_en,
	input  			[9:0]  	iact_SRAM_Bank_2_2_read_addr,
	output 			       	iact_SRAM_Bank_2_2_read_done,	
	
	
	// There is no SRAM to store weights from TOP DRAM
	// weights ares directly stored in PE spad
	output 			       	weight_0_address_in_ready,
	input  			       	weight_0_address_in_valid,
	input  			[7:0]  	weight_0_address_in,
	output 			       	weight_0_data_in_ready,
	input  			       	weight_0_data_in_valid,
	input  			[12:0] 	weight_0_data_in,
					
	input  			       	weight_0_address_out_ready,
	output 			       	weight_0_address_out_valid,
	output 			[7:0]  	weight_0_address_out,
	input  			       	weight_0_data_out_ready,
	output 			       	weight_0_data_out_valid,
	output 			[12:0] 	weight_0_data_out,
					
	output 			       	weight_1_address_in_ready,
	input  			       	weight_1_address_in_valid,
	input  			[7:0]  	weight_1_address_in,
	output 			       	weight_1_data_in_ready,
	input  			       	weight_1_data_in_valid,
	input  			[12:0] 	weight_1_data_in,
										
	input  			       	weight_1_address_out_ready,
	output 			       	weight_1_address_out_valid,
	output 			[7:0]  	weight_1_address_out,
	input  			       	weight_1_data_out_ready,
	output 			       	weight_1_data_out_valid,
	output 			[12:0] 	weight_1_data_out,
					
	output 			       	weight_2_address_in_ready,
	input  			       	weight_2_address_in_valid,
	input  			[7:0]  	weight_2_address_in,
	output 			       	weight_2_data_in_ready,
	input  			       	weight_2_data_in_valid,
	input  			[12:0] 	weight_2_data_in,
										
	input  			       	weight_2_address_out_ready,
	output 			       	weight_2_address_out_valid,
	output 			[7:0]  	weight_2_address_out,
	input  			       	weight_2_data_out_ready,
	output 			       	weight_2_data_out_valid,
	output 			[12:0] 	weight_2_data_out,
	
	// psum SRAM Bank 0
	output        			psum_SRAM_Bank_0_data_in_ready,        
	input         			psum_SRAM_Bank_0_data_in_valid,        
	input 	signed  [20:0] 	psum_SRAM_Bank_0_data_in,  
	input         			psum_SRAM_Bank_0_data_out_ready,      
	output        			psum_SRAM_Bank_0_data_out_valid,      
	output 	signed	[20:0] 	psum_SRAM_Bank_0_data_out,    
	
	input 			       	psum_SRAM_Bank_0_write_en,     
	input 			[9:0]  	psum_SRAM_Bank_0_write_addr,        
	output			       	psum_SRAM_Bank_0_write_done,  
	input 			       	psum_SRAM_Bank_0_read_out_en,   
	input 			       	psum_SRAM_Bank_0_read_en,      
	input 			[9:0]  	psum_SRAM_Bank_0_read_addr,     
	
	// psum SRAM Bank 1
	output        			psum_SRAM_Bank_1_data_in_ready,      
	input         			psum_SRAM_Bank_1_data_in_valid,      
	input 	signed	[20:0] 	psum_SRAM_Bank_1_data_in,     
	input         			psum_SRAM_Bank_1_data_out_ready,     
	output        			psum_SRAM_Bank_1_data_out_valid,     
	output 	signed	[20:0] 	psum_SRAM_Bank_1_data_out,    
								 
	input  			      	psum_SRAM_Bank_1_write_en,      
	input  			[9:0] 	psum_SRAM_Bank_1_write_addr,
	output 			      	psum_SRAM_Bank_1_write_done,
	input  			       	psum_SRAM_Bank_1_read_out_en,  
	input  			      	psum_SRAM_Bank_1_read_en,   
	input  			[9:0] 	psum_SRAM_Bank_1_read_addr, 
	
	// psum SRAM Bank 2
	output        			psum_SRAM_Bank_2_data_in_ready,      
	input         			psum_SRAM_Bank_2_data_in_valid,      
	input 	signed	[20:0]	psum_SRAM_Bank_2_data_in,     
	input         			psum_SRAM_Bank_2_data_out_ready,     
	output        			psum_SRAM_Bank_2_data_out_valid,     
	output 	signed	[20:0]	psum_SRAM_Bank_2_data_out,    
								 
	input         			psum_SRAM_Bank_2_write_en,      
	input  			[9:0]  	psum_SRAM_Bank_2_write_addr,
	output 			       	psum_SRAM_Bank_2_write_done,
	input         			psum_SRAM_Bank_2_read_out_en,  
	input  			       	psum_SRAM_Bank_2_read_en,   
	input  			[9:0]  	psum_SRAM_Bank_2_read_addr, 
	
	input			[4:0]	PSUM_DEPTH			
);


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// weights directly pass throught GLB cluster
assign weight_0_address_in_ready  = weight_0_address_out_ready;
assign weight_0_data_in_ready     = weight_0_data_out_ready;
assign weight_0_address_out       = weight_0_address_in;
assign weight_0_address_out_valid = weight_0_address_in_valid;
assign weight_0_data_out_valid    = weight_0_data_in_valid;
assign weight_0_data_out          = weight_0_data_in;

assign weight_1_address_in_ready  = weight_1_address_out_ready;
assign weight_1_data_in_ready     = weight_1_data_out_ready;
assign weight_1_address_out       = weight_1_address_in;
assign weight_1_address_out_valid = weight_1_address_in_valid;
assign weight_1_data_out_valid    = weight_1_data_in_valid;
assign weight_1_data_out          = weight_1_data_in;

assign weight_2_address_in_ready  = weight_2_address_out_ready;
assign weight_2_data_in_ready     = weight_2_data_out_ready;
assign weight_2_address_out       = weight_2_address_in;
assign weight_2_address_out_valid = weight_2_address_in_valid;
assign weight_2_data_out_valid    = weight_2_data_in_valid;
assign weight_2_data_out          = weight_2_data_in;


// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//
Iact_SRAM_Bank inActSRAM_0_0 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_0_0_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_0_0_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_0_0_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_0_0_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_0_0_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_0_0_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_0_0_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_0_0_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_0_0_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_0_0_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_0_0_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_0_0_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_0_0_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_0_0_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_0_0_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_0_0_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_0_0_read_done			) 
);


Iact_SRAM_Bank inActSRAM_0_1 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_0_1_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_0_1_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_0_1_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_0_1_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_0_1_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_0_1_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_0_1_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_0_1_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_0_1_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_0_1_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_0_1_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_0_1_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_0_1_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_0_1_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_0_1_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_0_1_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_0_1_read_done			) 
);


Iact_SRAM_Bank inActSRAM_0_2 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_0_2_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_0_2_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_0_2_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_0_2_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_0_2_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_0_2_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_0_2_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_0_2_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_0_2_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_0_2_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_0_2_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_0_2_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_0_2_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_0_2_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_0_2_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_0_2_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_0_2_read_done			) 
);

Iact_SRAM_Bank inActSRAM_1_0 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_1_0_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_1_0_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_1_0_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_1_0_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_1_0_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_1_0_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_1_0_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_1_0_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_1_0_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_1_0_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_1_0_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_1_0_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_1_0_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_1_0_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_1_0_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_1_0_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_1_0_read_done			) 
);

Iact_SRAM_Bank inActSRAM_1_1 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_1_1_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_1_1_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_1_1_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_1_1_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_1_1_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_1_1_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_1_1_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_1_1_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_1_1_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_1_1_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_1_1_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_1_1_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_1_1_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_1_1_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_1_1_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_1_1_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_1_1_read_done			) 
);

Iact_SRAM_Bank inActSRAM_1_2 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_1_2_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_1_2_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_1_2_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_1_2_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_1_2_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_1_2_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_1_2_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_1_2_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_1_2_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_1_2_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_1_2_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_1_2_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_1_2_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_1_2_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_1_2_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_1_2_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_1_2_read_done			) 
);

Iact_SRAM_Bank inActSRAM_2_0 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_2_0_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_2_0_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_2_0_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_2_0_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_2_0_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_2_0_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_2_0_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_2_0_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_2_0_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_2_0_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_2_0_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_2_0_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_2_0_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_2_0_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_2_0_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_2_0_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_2_0_read_done			) 
);


Iact_SRAM_Bank inActSRAM_2_1 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_2_1_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_2_1_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_2_1_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_2_1_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_2_1_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_2_1_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_2_1_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_2_1_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_2_1_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_2_1_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_2_1_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_2_1_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_2_1_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_2_1_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_2_1_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_2_1_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_2_1_read_done			) 
);


Iact_SRAM_Bank inActSRAM_2_2 ( 
	.clock                  (clock                  				),
	.reset                  (reset                  				),
	.iact_address_in_ready	(iact_SRAM_Bank_2_2_address_in_ready	),
	.iact_address_in_valid	(iact_SRAM_Bank_2_2_address_in_valid	),
	.iact_address_in		(iact_SRAM_Bank_2_2_address_in			),
	.iact_data_in_ready		(iact_SRAM_Bank_2_2_data_in_ready		),
	.iact_data_in_valid		(iact_SRAM_Bank_2_2_data_in_valid		),
	.iact_data_in		    (iact_SRAM_Bank_2_2_data_in				),
	.iact_address_out_ready	(iact_SRAM_Bank_2_2_address_out_ready	),
	.iact_address_out_valid	(iact_SRAM_Bank_2_2_address_out_valid	),
	.iact_address_out		(iact_SRAM_Bank_2_2_address_out   		),
	.iact_data_out_ready	(iact_SRAM_Bank_2_2_data_out_ready		),
	.iact_data_out_valid	(iact_SRAM_Bank_2_2_data_out_valid		),
	.iact_data_out		    (iact_SRAM_Bank_2_2_data_out			),
	.iact_write_en   	    (iact_SRAM_Bank_2_2_write_en			),
	.iact_write_done      	(iact_SRAM_Bank_2_2_write_done			),
	.iact_read_en   	    (iact_SRAM_Bank_2_2_read_en				),
	.iact_read_addr      	(iact_SRAM_Bank_2_2_read_addr			),
	.iact_read_done      	(iact_SRAM_Bank_2_2_read_done			) 
);


Psum_SRAM_Bank pSumSRAM0 ( 
	.clock          	(clock         					),
	.reset          	(reset         					),
	.psum_data_in_ready (psum_SRAM_Bank_0_data_in_ready ),
	.psum_data_in_valid (psum_SRAM_Bank_0_data_in_valid ),
	.psum_data_in       (psum_SRAM_Bank_0_data_in       ),
	.psum_data_out_ready(psum_SRAM_Bank_0_data_out_ready),
	.psum_data_out_valid(psum_SRAM_Bank_0_data_out_valid),
	.psum_data_out      (psum_SRAM_Bank_0_data_out      ),
	.psum_write_en      (psum_SRAM_Bank_0_write_en      ),
	.psum_write_addr    (psum_SRAM_Bank_0_write_addr    ),
	.psum_write_done    (psum_SRAM_Bank_0_write_done    ),
	.psum_read_out_en	(psum_SRAM_Bank_0_read_out_en	),
	.psum_read_en       (psum_SRAM_Bank_0_read_en       ),
	.psum_read_addr     (psum_SRAM_Bank_0_read_addr     ),
	.PSUM_DEPTH			(PSUM_DEPTH						)
);

Psum_SRAM_Bank pSumSRAM1 ( 
	.clock          	(clock         					),
	.reset          	(reset         					),
	.psum_data_in_ready (psum_SRAM_Bank_1_data_in_ready ),
	.psum_data_in_valid (psum_SRAM_Bank_1_data_in_valid ),
	.psum_data_in       (psum_SRAM_Bank_1_data_in       ),
	.psum_data_out_ready(psum_SRAM_Bank_1_data_out_ready),
	.psum_data_out_valid(psum_SRAM_Bank_1_data_out_valid),
	.psum_data_out      (psum_SRAM_Bank_1_data_out      ),
	.psum_write_en      (psum_SRAM_Bank_1_write_en      ),
	.psum_write_addr    (psum_SRAM_Bank_1_write_addr    ),
	.psum_write_done    (psum_SRAM_Bank_1_write_done    ),
	.psum_read_out_en	(psum_SRAM_Bank_1_read_out_en	),
	.psum_read_en       (psum_SRAM_Bank_1_read_en       ),
	.psum_read_addr     (psum_SRAM_Bank_1_read_addr     ),
	.PSUM_DEPTH			(PSUM_DEPTH						)
);

Psum_SRAM_Bank pSumSRAM2 ( 
	.clock          	(clock         					),
	.reset          	(reset         					),
	.psum_data_in_ready (psum_SRAM_Bank_2_data_in_ready ),
	.psum_data_in_valid (psum_SRAM_Bank_2_data_in_valid ),
	.psum_data_in       (psum_SRAM_Bank_2_data_in       ),
	.psum_data_out_ready(psum_SRAM_Bank_2_data_out_ready),
	.psum_data_out_valid(psum_SRAM_Bank_2_data_out_valid),
	.psum_data_out      (psum_SRAM_Bank_2_data_out      ),
	.psum_write_en      (psum_SRAM_Bank_2_write_en      ),
	.psum_write_addr    (psum_SRAM_Bank_2_write_addr    ),
	.psum_write_done    (psum_SRAM_Bank_2_write_done    ),
	.psum_read_out_en	(psum_SRAM_Bank_2_read_out_en	),
	.psum_read_en       (psum_SRAM_Bank_2_read_en       ),
	.psum_read_addr     (psum_SRAM_Bank_2_read_addr     ),
	.PSUM_DEPTH			(PSUM_DEPTH						)
);

  
endmodule
