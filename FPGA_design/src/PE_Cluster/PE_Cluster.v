// ====================================================================================================== //
// This module is the Top-level of PE cluster.
// PE cluster module contains the 3x3 array PEs and PE cluster controller.
// The control signals write_fin are used to control the data in from uppper level module.
// The control signals cal_fin are used to control uppper level module.
// disable signals is used to disable selected PE for physical mapping.
// If disable signals are high, the utilization of PE will be decrease.
// ====================================================================================================== //


module PE_Cluster(
	input  			       	clock,
	input  			       	reset,
	// data signals
	output 			       	iact_0_address_in_ready,
	input  			       	iact_0_address_in_valid,
	input  			[7:0]  	iact_0_address_in,
	output 			       	iact_0_data_in_ready,
	input  			       	iact_0_data_in_valid,
	input  			[12:0] 	iact_0_data_in,
	output 			       	iact_1_address_in_ready,
	input  			       	iact_1_address_in_valid,
	input  			[7:0]  	iact_1_address_in,
	output 			       	iact_1_data_in_ready,
	input  			       	iact_1_data_in_valid,
	input  			[12:0] 	iact_1_data_in,
	output 			       	iact_2_address_in_ready,
	input  			       	iact_2_address_in_valid,
	input  			[7:0]  	iact_2_address_in,
	output 			       	iact_2_data_in_ready,
	input  			       	iact_2_data_in_valid,
	input  			[12:0] 	iact_2_data_in,
					
	input  			       	weight_0_0_address_in_valid,
	input  			[6:0]  	weight_0_0_address_in,
	input  			       	weight_0_0_data_in_valid,
	input  			[11:0] 	weight_0_0_data_in,
	input  			       	weight_0_1_address_in_valid,
	input  			[6:0]  	weight_0_1_address_in,
	input  			       	weight_0_1_data_in_valid,
	input  			[11:0] 	weight_0_1_data_in,
	input  			       	weight_0_2_address_in_valid,
	input  			[6:0]  	weight_0_2_address_in,
	input  			       	weight_0_2_data_in_valid,
	input  			[11:0] 	weight_0_2_data_in,
	
	input  			       	weight_1_0_address_in_valid,
	input  			[6:0]  	weight_1_0_address_in,
	input  			       	weight_1_0_data_in_valid,
	input  			[11:0] 	weight_1_0_data_in,
	input  			       	weight_1_1_address_in_valid,
	input  			[6:0]  	weight_1_1_address_in,
	input  			       	weight_1_1_data_in_valid,
	input  			[11:0] 	weight_1_1_data_in,
	input  			       	weight_1_2_address_in_valid,
	input  			[6:0]  	weight_1_2_address_in,
	input  			       	weight_1_2_data_in_valid,
	input  			[11:0] 	weight_1_2_data_in,
	
	input  			       	weight_2_0_address_in_valid,
	input  			[6:0]  	weight_2_0_address_in,
	input  			       	weight_2_0_data_in_valid,
	input  			[11:0] 	weight_2_0_data_in,
	input  			       	weight_2_1_address_in_valid,
	input  			[6:0]  	weight_2_1_address_in,
	input  			       	weight_2_1_data_in_valid,
	input  			[11:0] 	weight_2_1_data_in,
	input  			       	weight_2_2_address_in_valid,
	input  			[6:0]  	weight_2_2_address_in,
	input  			       	weight_2_2_data_in_valid,
	input  			[11:0] 	weight_2_2_data_in,
	
	output        			psum_0_in_ready,
	input         			psum_0_in_valid,
	input 	signed 	[20:0] 	psum_0_in,			
	output        			psum_1_in_ready,
	input         			psum_1_in_valid,
	input 	signed 	[20:0] 	psum_1_in,
	output       		 	psum_2_in_ready,
	input         			psum_2_in_valid,
	input 	signed 	[20:0] 	psum_2_in,
	
	input         			psum_0_out_ready,
	output        			psum_0_out_valid,
	output 	signed 	[20:0] 	psum_0_out,
	input         			psum_1_out_ready,
	output        			psum_1_out_valid,
	output 	signed 	[20:0] 	psum_1_out,
	input        			psum_2_out_ready,
	output        			psum_2_out_valid,
	output 	signed 	[20:0] 	psum_2_out,
	
	output        			psum_0_in_from_south_ready,
	input         			psum_0_in_from_south_valid,
	input 	signed 	[20:0] 	psum_0_in_from_south,
	output       	 		psum_1_in_from_south_ready,
	input        	 		psum_1_in_from_south_valid,
	input 	signed 	[20:0] 	psum_1_in_from_south,
	output       	 		psum_2_in_from_south_ready,
	input        			psum_2_in_from_south_valid,
	input 	signed 	[20:0] 	psum_2_in_from_south,
	
	// control signals
	input					PE_0_0_disable,
	input					PE_0_1_disable,
	input					PE_0_2_disable,
	input					PE_1_0_disable,
	input					PE_1_1_disable,
	input					PE_1_2_disable,
	input					PE_2_0_disable,
	input					PE_2_1_disable,
	input					PE_2_2_disable,
	
	input         			psum_load_en,
	
	input         			iact_data_in_sel,
	input  			[1:0]  	iact_data_out_sel,
	
	input         			psum_data_in_sel, // true for GLB psum, false for south psum
	
	input         			do_en,
	
	input					iact_write_fin_clear,
	input					weight_write_fin_clear,
	output					all_write_fin,
	
	output        			all_cal_fin,
	
	input 			[4:0]	PSUM_DEPTH,
	input					psum_spad_clear
);

// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//													
// PE_0_0                                                       
wire  				PE_0_0_psum_in_ready;          
wire  				PE_0_0_psum_in_valid;          
wire signed [20:0] 	PE_0_0_psum_in;                
wire  				PE_0_0_psum_out_ready;         
wire  				PE_0_0_psum_out_valid;         
wire signed [20:0] 	PE_0_0_psum_out;               
wire		 		PE_0_0_iact_address_in_valid;  
wire		[7:0] 	PE_0_0_iact_address_in;       	
wire		 		PE_0_0_iact_data_in_valid;     
wire		[12:0] 	PE_0_0_iact_data_in;      		
wire		 		PE_0_0_weight_address_in_valid;
wire		[6:0] 	PE_0_0_weight_address_in;      
wire		 		PE_0_0_weight_data_in_valid;   
wire		[11:0] 	PE_0_0_weight_data_in;     		
wire		 		PE_0_0_iact_address_write_fin; 
wire		 		PE_0_0_iact_data_write_fin;    
wire		 		PE_0_0_psum_add_fin;           
wire		 		PE_0_0_psum_enq_en;            
wire		 		PE_0_0_do_load_en;             
wire		 		PE_0_0_cal_fin;                

// PE_0_1
wire  				PE_0_1_psum_in_ready;          
wire  				PE_0_1_psum_in_valid;          
wire signed [20:0] 	PE_0_1_psum_in;                
wire  				PE_0_1_psum_out_ready;         
wire  				PE_0_1_psum_out_valid;         
wire signed [20:0] 	PE_0_1_psum_out;               
wire		 		PE_0_1_iact_address_in_valid;  
wire		[7:0] 	PE_0_1_iact_address_in;       	
wire		 		PE_0_1_iact_data_in_valid;     
wire		[12:0] 	PE_0_1_iact_data_in;      		
wire		 		PE_0_1_weight_address_in_valid;
wire		[6:0] 	PE_0_1_weight_address_in;      
wire		 		PE_0_1_weight_data_in_valid;    
wire		[11:0] 	PE_0_1_weight_data_in;     		
wire		 		PE_0_1_iact_address_write_fin; 
wire		 		PE_0_1_iact_data_write_fin;    
wire		 		PE_0_1_psum_add_fin;           
wire		 		PE_0_1_psum_enq_en;            
wire		 		PE_0_1_do_load_en;             
wire		 		PE_0_1_cal_fin;                

// PE_0_2
wire  				PE_0_2_psum_in_ready;          
wire  				PE_0_2_psum_in_valid;          
wire signed [20:0] 	PE_0_2_psum_in;                
wire  				PE_0_2_psum_out_ready;         
wire  				PE_0_2_psum_out_valid;         
wire signed [20:0] 	PE_0_2_psum_out;               
wire		 		PE_0_2_iact_address_in_valid;  
wire		[7:0] 	PE_0_2_iact_address_in;       	
wire		 		PE_0_2_iact_data_in_valid;     
wire		[12:0] 	PE_0_2_iact_data_in;      		
wire		 		PE_0_2_weight_address_in_valid;
wire		[6:0] 	PE_0_2_weight_address_in;      
wire		 		PE_0_2_weight_data_in_valid;   
wire		[11:0] 	PE_0_2_weight_data_in;     		
wire		 		PE_0_2_iact_address_write_fin; 
wire		 		PE_0_2_iact_data_write_fin;    
wire		 		PE_0_2_psum_add_fin;           
wire		 		PE_0_2_psum_enq_en;            
wire		 		PE_0_2_do_load_en;             
wire		 		PE_0_2_cal_fin;                
    
// PE_1_0
wire  				PE_1_0_psum_in_ready;          
wire  				PE_1_0_psum_in_valid;          
wire signed [20:0] 	PE_1_0_psum_in;                
wire  				PE_1_0_psum_out_ready;         
wire  				PE_1_0_psum_out_valid;         
wire signed [20:0] 	PE_1_0_psum_out;               
wire		 		PE_1_0_iact_address_in_valid;  
wire		[7:0] 	PE_1_0_iact_address_in;       	
wire		 		PE_1_0_iact_data_in_valid;     
wire		[12:0] 	PE_1_0_iact_data_in;      		
wire		 		PE_1_0_weight_address_in_valid;
wire		[6:0] 	PE_1_0_weight_address_in;      
wire		 		PE_1_0_weight_data_in_valid;   
wire		[11:0] 	PE_1_0_weight_data_in;     		
wire		 		PE_1_0_iact_address_write_fin; 
wire		 		PE_1_0_iact_data_write_fin;    
wire		 		PE_1_0_psum_add_fin;           
wire		 		PE_1_0_psum_enq_en;            
wire		 		PE_1_0_do_load_en;             
wire		 		PE_1_0_cal_fin;                

// PE_1_1
wire  				PE_1_1_psum_in_ready;          
wire  				PE_1_1_psum_in_valid;          
wire signed [20:0] 	PE_1_1_psum_in;                
wire  				PE_1_1_psum_out_ready;         
wire  				PE_1_1_psum_out_valid;         
wire signed [20:0] 	PE_1_1_psum_out;               
wire		 		PE_1_1_iact_address_in_valid;  
wire		[7:0] 	PE_1_1_iact_address_in;       	
wire		 		PE_1_1_iact_data_in_valid;     
wire		[12:0] 	PE_1_1_iact_data_in;      		
wire		 		PE_1_1_weight_address_in_valid;
wire		[6:0] 	PE_1_1_weight_address_in;      
wire		 		PE_1_1_weight_data_in_valid;    
wire		[11:0] 	PE_1_1_weight_data_in;     		
wire		 		PE_1_1_iact_address_write_fin; 
wire		 		PE_1_1_iact_data_write_fin;    
wire		 		PE_1_1_psum_add_fin;           
wire		 		PE_1_1_psum_enq_en;            
wire		 		PE_1_1_do_load_en;             
wire		 		PE_1_1_cal_fin;                

// PE_1_2
wire  				PE_1_2_psum_in_ready;          
wire  				PE_1_2_psum_in_valid;          
wire signed [20:0] 	PE_1_2_psum_in;                
wire  				PE_1_2_psum_out_ready;         
wire  				PE_1_2_psum_out_valid;         
wire signed [20:0] 	PE_1_2_psum_out;               
wire		 		PE_1_2_iact_address_in_valid;  
wire		[7:0] 	PE_1_2_iact_address_in;       	
wire		 		PE_1_2_iact_data_in_valid;     
wire		[12:0] 	PE_1_2_iact_data_in;      		
wire		 		PE_1_2_weight_address_in_valid;
wire		[6:0] 	PE_1_2_weight_address_in;      
wire		 		PE_1_2_weight_data_in_valid;     
wire		[11:0] 	PE_1_2_weight_data_in;     		
wire		 		PE_1_2_iact_address_write_fin; 
wire		 		PE_1_2_iact_data_write_fin;    
wire		 		PE_1_2_psum_add_fin;           
wire		 		PE_1_2_psum_enq_en;            
wire		 		PE_1_2_do_load_en;             
wire		 		PE_1_2_cal_fin;                   

// PE_2_0
wire  				PE_2_0_psum_in_ready;          
wire  				PE_2_0_psum_in_valid;          
wire signed [20:0] 	PE_2_0_psum_in;                
wire  				PE_2_0_psum_out_ready;         
wire  				PE_2_0_psum_out_valid;         
wire signed [20:0] 	PE_2_0_psum_out;               
wire		 		PE_2_0_iact_address_in_valid;  
wire		[7:0] 	PE_2_0_iact_address_in;       	
wire		 		PE_2_0_iact_data_in_valid;     
wire		[12:0] 	PE_2_0_iact_data_in;      		
wire		 		PE_2_0_weight_address_in_valid;
wire		[6:0] 	PE_2_0_weight_address_in;      
wire		 		PE_2_0_weight_data_in_valid;    
wire		[11:0] 	PE_2_0_weight_data_in;     		
wire		 		PE_2_0_iact_address_write_fin; 
wire		 		PE_2_0_iact_data_write_fin;    
wire		 		PE_2_0_psum_add_fin;           
wire		 		PE_2_0_psum_enq_en;            
wire		 		PE_2_0_do_load_en;             
wire		 		PE_2_0_cal_fin;                

// PE_2_1
wire  				PE_2_1_psum_in_ready;          
wire  				PE_2_1_psum_in_valid;          
wire signed [20:0] 	PE_2_1_psum_in;                
wire  				PE_2_1_psum_out_ready;         
wire  				PE_2_1_psum_out_valid;         
wire signed [20:0] 	PE_2_1_psum_out;               
wire		 		PE_2_1_iact_address_in_valid;  
wire		[7:0] 	PE_2_1_iact_address_in;       	
wire		 		PE_2_1_iact_data_in_valid;     
wire		[12:0] 	PE_2_1_iact_data_in;      		
wire		 		PE_2_1_weight_address_in_valid;
wire		[6:0] 	PE_2_1_weight_address_in;      
wire		 		PE_2_1_weight_data_in_valid;    
wire		[11:0] 	PE_2_1_weight_data_in;     		
wire		 		PE_2_1_iact_address_write_fin; 
wire		 		PE_2_1_iact_data_write_fin;    
wire		 		PE_2_1_psum_add_fin;           
wire		 		PE_2_1_psum_enq_en;            
wire		 		PE_2_1_do_load_en;             
wire		 		PE_2_1_cal_fin;                

// PE_2_2
wire  				PE_2_2_psum_in_ready;          
wire  				PE_2_2_psum_in_valid;          
wire signed [20:0] 	PE_2_2_psum_in;                
wire  				PE_2_2_psum_out_ready;         
wire  				PE_2_2_psum_out_valid;         
wire signed [20:0] 	PE_2_2_psum_out;               
wire		 		PE_2_2_iact_address_in_valid;  
wire		[7:0] 	PE_2_2_iact_address_in;       	
wire		 		PE_2_2_iact_data_in_valid;     
wire		[12:0] 	PE_2_2_iact_data_in;      		
wire		 		PE_2_2_weight_address_in_valid;
wire		[6:0] 	PE_2_2_weight_address_in;      
wire		 		PE_2_2_weight_data_in_valid;    
wire		[11:0] 	PE_2_2_weight_data_in;     		
wire		 		PE_2_2_iact_address_write_fin; 
wire		 		PE_2_2_iact_data_write_fin;    
wire		 		PE_2_2_psum_add_fin;           
wire		 		PE_2_2_psum_enq_en;            
wire		 		PE_2_2_do_load_en;             
wire		 		PE_2_2_cal_fin;                

// PE 
ProcessingElement pe00 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_0_0_psum_in_ready       	),
	.psum_in_valid       	(PE_0_0_psum_in_valid       	),
	.psum_in             	(PE_0_0_psum_in             	),
	.psum_out_ready       	(PE_0_0_psum_out_ready       	),
	.psum_out_valid      	(PE_0_0_psum_out_valid      	),
	.psum_out         	    (PE_0_0_psum_out         	    ),
	.iact_address_in_valid	(PE_0_0_iact_address_in_valid	),
	.iact_address_in      	(PE_0_0_iact_address_in      	),
	.iact_data_in_valid    	(PE_0_0_iact_data_in_valid    	),
	.iact_data_in      		(PE_0_0_iact_data_in      		),		
	.weight_address_in_valid(PE_0_0_weight_address_in_valid	),		
	.weight_address_in     	(PE_0_0_weight_address_in     	),
	.weight_data_in_valid  	(PE_0_0_weight_data_in_valid  	),
	.weight_data_in    		(PE_0_0_weight_data_in    		),	
	.iact_address_write_fin	(PE_0_0_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_0_0_iact_data_write_fin   	),
	.psum_add_fin          	(PE_0_0_psum_add_fin          	),
	.psum_enq_en         	(PE_0_0_psum_enq_en         	),
	.do_load_en         	(PE_0_0_do_load_en         		),
	.cal_fin             	(PE_0_0_cal_fin             	),
	.iact_write_fin_clear	(PE_0_0_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_0_0_weight_write_fin_clear	),
	.all_write_fin			(PE_0_0_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe01 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_0_1_psum_in_ready       	),
	.psum_in_valid       	(PE_0_1_psum_in_valid       	),
	.psum_in             	(PE_0_1_psum_in             	),
	.psum_out_ready       	(PE_0_1_psum_out_ready       	),
	.psum_out_valid      	(PE_0_1_psum_out_valid      	),
	.psum_out         	    (PE_0_1_psum_out         	    ),
	.iact_address_in_valid	(PE_0_1_iact_address_in_valid	),
	.iact_address_in      	(PE_0_1_iact_address_in      	),
	.iact_data_in_valid    	(PE_0_1_iact_data_in_valid    	),
	.iact_data_in      		(PE_0_1_iact_data_in      		),	
	.weight_address_in_valid(PE_0_1_weight_address_in_valid	),	
	.weight_address_in     	(PE_0_1_weight_address_in     	),
	.weight_data_in_valid  	(PE_0_1_weight_data_in_valid  	),
	.weight_data_in    		(PE_0_1_weight_data_in    		),	
	.iact_address_write_fin	(PE_0_1_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_0_1_iact_data_write_fin   	),
	.psum_add_fin          	(PE_0_1_psum_add_fin          	),
	.psum_enq_en         	(PE_0_1_psum_enq_en         	),
	.do_load_en         	(PE_0_1_do_load_en         		),
	.cal_fin             	(PE_0_1_cal_fin             	),
	.iact_write_fin_clear	(PE_0_1_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_0_1_weight_write_fin_clear	),
	.all_write_fin			(PE_0_1_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe02 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_0_2_psum_in_ready       	),
	.psum_in_valid       	(PE_0_2_psum_in_valid       	),
	.psum_in             	(PE_0_2_psum_in             	),
	.psum_out_ready       	(PE_0_2_psum_out_ready       	),
	.psum_out_valid      	(PE_0_2_psum_out_valid      	),
	.psum_out         	    (PE_0_2_psum_out         	    ),
	.iact_address_in_valid	(PE_0_2_iact_address_in_valid	),
	.iact_address_in      	(PE_0_2_iact_address_in      	),
	.iact_data_in_valid    	(PE_0_2_iact_data_in_valid    	),
	.iact_data_in      		(PE_0_2_iact_data_in      		),	
	.weight_address_in_valid(PE_0_2_weight_address_in_valid	),	
	.weight_address_in     	(PE_0_2_weight_address_in     	),
	.weight_data_in_valid  	(PE_0_2_weight_data_in_valid  	),
	.weight_data_in    		(PE_0_2_weight_data_in    		),	
	.iact_address_write_fin	(PE_0_2_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_0_2_iact_data_write_fin   	),
	.psum_add_fin          	(PE_0_2_psum_add_fin          	),
	.psum_enq_en         	(PE_0_2_psum_enq_en         	),
	.do_load_en         	(PE_0_2_do_load_en         		),
	.cal_fin             	(PE_0_2_cal_fin             	),
	.iact_write_fin_clear	(PE_0_2_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_0_2_weight_write_fin_clear	),
	.all_write_fin			(PE_0_2_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe10 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_1_0_psum_in_ready       	),
	.psum_in_valid       	(PE_1_0_psum_in_valid       	),
	.psum_in             	(PE_1_0_psum_in             	),
	.psum_out_ready       	(PE_1_0_psum_out_ready       	),
	.psum_out_valid      	(PE_1_0_psum_out_valid      	),
	.psum_out         	    (PE_1_0_psum_out         	    ),
	.iact_address_in_valid	(PE_1_0_iact_address_in_valid	),
	.iact_address_in      	(PE_1_0_iact_address_in      	),
	.iact_data_in_valid    	(PE_1_0_iact_data_in_valid    	),
	.iact_data_in      		(PE_1_0_iact_data_in      		),	
	.weight_address_in_valid(PE_1_0_weight_address_in_valid	),	
	.weight_address_in     	(PE_1_0_weight_address_in     	),
	.weight_data_in_valid  	(PE_1_0_weight_data_in_valid  	),
	.weight_data_in    		(PE_1_0_weight_data_in    		),	
	.iact_address_write_fin	(PE_1_0_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_1_0_iact_data_write_fin   	),
	.psum_add_fin          	(PE_1_0_psum_add_fin          	),
	.psum_enq_en         	(PE_1_0_psum_enq_en         	),
	.do_load_en         	(PE_1_0_do_load_en         		),
	.cal_fin             	(PE_1_0_cal_fin             	),
	.iact_write_fin_clear	(PE_1_0_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_1_0_weight_write_fin_clear	),
	.all_write_fin			(PE_1_0_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe11 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_1_1_psum_in_ready       	),
	.psum_in_valid       	(PE_1_1_psum_in_valid       	),
	.psum_in             	(PE_1_1_psum_in             	),
	.psum_out_ready       	(PE_1_1_psum_out_ready       	),
	.psum_out_valid      	(PE_1_1_psum_out_valid      	),
	.psum_out         	    (PE_1_1_psum_out         	    ),
	.iact_address_in_valid	(PE_1_1_iact_address_in_valid	),
	.iact_address_in      	(PE_1_1_iact_address_in      	),
	.iact_data_in_valid    	(PE_1_1_iact_data_in_valid    	),
	.iact_data_in      		(PE_1_1_iact_data_in      		),
	.weight_address_in_valid(PE_1_1_weight_address_in_valid	),
	.weight_address_in     	(PE_1_1_weight_address_in     	),
	.weight_data_in_valid  	(PE_1_1_weight_data_in_valid  	),
	.weight_data_in    		(PE_1_1_weight_data_in    		),
	.iact_address_write_fin	(PE_1_1_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_1_1_iact_data_write_fin   	),
	.psum_add_fin          	(PE_1_1_psum_add_fin          	),
	.psum_enq_en         	(PE_1_1_psum_enq_en         	),
	.do_load_en         	(PE_1_1_do_load_en         		),
	.cal_fin             	(PE_1_1_cal_fin             	),
	.iact_write_fin_clear	(PE_1_1_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_1_1_weight_write_fin_clear	),
	.all_write_fin			(PE_1_1_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe12 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_1_2_psum_in_ready       	),
	.psum_in_valid       	(PE_1_2_psum_in_valid       	),
	.psum_in             	(PE_1_2_psum_in             	),
	.psum_out_ready       	(PE_1_2_psum_out_ready       	),
	.psum_out_valid      	(PE_1_2_psum_out_valid      	),
	.psum_out         	    (PE_1_2_psum_out         	    ),
	.iact_address_in_valid	(PE_1_2_iact_address_in_valid	),
	.iact_address_in      	(PE_1_2_iact_address_in      	),
	.iact_data_in_valid    	(PE_1_2_iact_data_in_valid    	),
	.iact_data_in      		(PE_1_2_iact_data_in      		),
	.weight_address_in_valid(PE_1_2_weight_address_in_valid	),
	.weight_address_in     	(PE_1_2_weight_address_in     	),
	.weight_data_in_valid  	(PE_1_2_weight_data_in_valid  	),
	.weight_data_in    		(PE_1_2_weight_data_in    		),
	.iact_address_write_fin	(PE_1_2_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_1_2_iact_data_write_fin   	),
	.psum_add_fin          	(PE_1_2_psum_add_fin          	),
	.psum_enq_en         	(PE_1_2_psum_enq_en         	),
	.do_load_en         	(PE_1_2_do_load_en         		),
	.cal_fin             	(PE_1_2_cal_fin             	),
	.iact_write_fin_clear	(PE_1_2_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_1_2_weight_write_fin_clear	),
	.all_write_fin			(PE_1_2_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe20 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_2_0_psum_in_ready       	),
	.psum_in_valid       	(PE_2_0_psum_in_valid       	),
	.psum_in             	(PE_2_0_psum_in             	),
	.psum_out_ready       	(PE_2_0_psum_out_ready       	),
	.psum_out_valid      	(PE_2_0_psum_out_valid      	),
	.psum_out         	    (PE_2_0_psum_out         	    ),
	.iact_address_in_valid	(PE_2_0_iact_address_in_valid	),
	.iact_address_in      	(PE_2_0_iact_address_in      	),
	.iact_data_in_valid    	(PE_2_0_iact_data_in_valid    	),
	.iact_data_in      		(PE_2_0_iact_data_in      		),
	.weight_address_in_valid(PE_2_0_weight_address_in_valid	),
	.weight_address_in     	(PE_2_0_weight_address_in     	),
	.weight_data_in_valid  	(PE_2_0_weight_data_in_valid  	),
	.weight_data_in    		(PE_2_0_weight_data_in    		),
	.iact_address_write_fin	(PE_2_0_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_2_0_iact_data_write_fin   	),
	.psum_add_fin          	(PE_2_0_psum_add_fin          	),
	.psum_enq_en         	(PE_2_0_psum_enq_en         	),
	.do_load_en         	(PE_2_0_do_load_en         		),
	.cal_fin             	(PE_2_0_cal_fin             	),
	.iact_write_fin_clear	(PE_2_0_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_2_0_weight_write_fin_clear	),
	.all_write_fin			(PE_2_0_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe21 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_2_1_psum_in_ready       	),
	.psum_in_valid       	(PE_2_1_psum_in_valid       	),
	.psum_in             	(PE_2_1_psum_in             	),
	.psum_out_ready       	(PE_2_1_psum_out_ready       	),
	.psum_out_valid      	(PE_2_1_psum_out_valid      	),
	.psum_out         	    (PE_2_1_psum_out         	    ),
	.iact_address_in_valid	(PE_2_1_iact_address_in_valid	),
	.iact_address_in      	(PE_2_1_iact_address_in      	),
	.iact_data_in_valid    	(PE_2_1_iact_data_in_valid    	),
	.iact_data_in      		(PE_2_1_iact_data_in      		),
	.weight_address_in_valid(PE_2_1_weight_address_in_valid	),
	.weight_address_in     	(PE_2_1_weight_address_in     	),
	.weight_data_in_valid  	(PE_2_1_weight_data_in_valid  	),
	.weight_data_in    		(PE_2_1_weight_data_in    		),
	.iact_address_write_fin	(PE_2_1_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_2_1_iact_data_write_fin   	),
	.psum_add_fin          	(PE_2_1_psum_add_fin          	),
	.psum_enq_en         	(PE_2_1_psum_enq_en         	),
	.do_load_en         	(PE_2_1_do_load_en         		),
	.cal_fin             	(PE_2_1_cal_fin             	),
	.iact_write_fin_clear	(PE_2_1_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_2_1_weight_write_fin_clear	),
	.all_write_fin			(PE_2_1_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

ProcessingElement pe22 ( 
	.clock					(clock),
	.reset					(reset),
	.psum_in_ready       	(PE_2_2_psum_in_ready       	),
	.psum_in_valid       	(PE_2_2_psum_in_valid       	),
	.psum_in             	(PE_2_2_psum_in             	),
	.psum_out_ready       	(PE_2_2_psum_out_ready       	),
	.psum_out_valid      	(PE_2_2_psum_out_valid      	),
	.psum_out         	    (PE_2_2_psum_out         	    ),
	.iact_address_in_valid	(PE_2_2_iact_address_in_valid	),
	.iact_address_in      	(PE_2_2_iact_address_in      	),
	.iact_data_in_valid    	(PE_2_2_iact_data_in_valid    	),
	.iact_data_in      		(PE_2_2_iact_data_in      		),
	.weight_address_in_valid(PE_2_2_weight_address_in_valid	),
	.weight_address_in     	(PE_2_2_weight_address_in     	),
	.weight_data_in_valid  	(PE_2_2_weight_data_in_valid  	),
	.weight_data_in    		(PE_2_2_weight_data_in    		),
	.iact_address_write_fin	(PE_2_2_iact_address_write_fin	),
	.iact_data_write_fin   	(PE_2_2_iact_data_write_fin   	),
	.psum_add_fin          	(PE_2_2_psum_add_fin          	),
	.psum_enq_en         	(PE_2_2_psum_enq_en         	),
	.do_load_en         	(PE_2_2_do_load_en         		),
	.cal_fin             	(PE_2_2_cal_fin             	),
	.iact_write_fin_clear	(PE_2_2_iact_write_fin_clear	),
	.weight_write_fin_clear	(PE_2_2_weight_write_fin_clear	),
	.all_write_fin			(PE_2_2_write_fin				),
	.PSUM_DEPTH				(PSUM_DEPTH						),
	.psum_spad_clear		(psum_spad_clear				)
);

// PE cluster controller
PE_Cluster_controller PE_Cluster_controller_inst ( 				
	.iact_data_in_sel                   (iact_data_in_sel				),
	.iact_data_out_sel                  (iact_data_out_sel 				),
									
	.iact_to_PE_0_0_address_out_valid	(PE_0_0_iact_address_in_valid	),	   
	.iact_to_PE_0_1_address_out_valid   (PE_0_1_iact_address_in_valid   ),  
	.iact_to_PE_0_2_address_out_valid   (PE_0_2_iact_address_in_valid   ),  
	.iact_to_PE_1_0_address_out_valid   (PE_1_0_iact_address_in_valid   ),  
	.iact_to_PE_1_1_address_out_valid   (PE_1_1_iact_address_in_valid   ),  
	.iact_to_PE_1_2_address_out_valid   (PE_1_2_iact_address_in_valid   ),  
	.iact_to_PE_2_0_address_out_valid   (PE_2_0_iact_address_in_valid   ),  
	.iact_to_PE_2_1_address_out_valid   (PE_2_1_iact_address_in_valid   ),  
	.iact_to_PE_2_2_address_out_valid   (PE_2_2_iact_address_in_valid   ),  
										
	.iact_to_PE_0_0_data_out_valid      (PE_0_0_iact_data_in_valid      ),      
	.iact_to_PE_0_1_data_out_valid      (PE_0_1_iact_data_in_valid      ),      
	.iact_to_PE_0_2_data_out_valid      (PE_0_2_iact_data_in_valid      ),        
	.iact_to_PE_1_0_data_out_valid      (PE_1_0_iact_data_in_valid      ),      
	.iact_to_PE_1_1_data_out_valid      (PE_1_1_iact_data_in_valid      ),      
	.iact_to_PE_1_2_data_out_valid      (PE_1_2_iact_data_in_valid      ),         
	.iact_to_PE_2_0_data_out_valid      (PE_2_0_iact_data_in_valid      ),      
	.iact_to_PE_2_1_data_out_valid      (PE_2_1_iact_data_in_valid      ),      
	.iact_to_PE_2_2_data_out_valid      (PE_2_2_iact_data_in_valid      ),   
										
	.iact_to_PE_0_0_address_out_bits    (PE_0_0_iact_address_in    ),        
	.iact_to_PE_0_1_address_out_bits    (PE_0_1_iact_address_in    ),        
	.iact_to_PE_0_2_address_out_bits    (PE_0_2_iact_address_in    ),          
	.iact_to_PE_1_0_address_out_bits    (PE_1_0_iact_address_in    ),        
	.iact_to_PE_1_1_address_out_bits    (PE_1_1_iact_address_in    ),        
	.iact_to_PE_1_2_address_out_bits    (PE_1_2_iact_address_in    ),         
	.iact_to_PE_2_0_address_out_bits    (PE_2_0_iact_address_in    ),        
	.iact_to_PE_2_1_address_out_bits    (PE_2_1_iact_address_in    ),        
	.iact_to_PE_2_2_address_out_bits    (PE_2_2_iact_address_in    ),      
										
	.iact_to_PE_0_0_data_out_bits       (PE_0_0_iact_data_in       ),     
	.iact_to_PE_0_1_data_out_bits       (PE_0_1_iact_data_in       ),     
	.iact_to_PE_0_2_data_out_bits       (PE_0_2_iact_data_in       ),        
	.iact_to_PE_1_0_data_out_bits       (PE_1_0_iact_data_in       ),     
	.iact_to_PE_1_1_data_out_bits	    (PE_1_1_iact_data_in	   ),        
	.iact_to_PE_1_2_data_out_bits	    (PE_1_2_iact_data_in	   ),       
	.iact_to_PE_2_0_data_out_bits       (PE_2_0_iact_data_in       ),     
	.iact_to_PE_2_1_data_out_bits       (PE_2_1_iact_data_in       ),     
	.iact_to_PE_2_2_data_out_bits       (PE_2_2_iact_data_in       ),     
										
	.iact_from_router_0_address_in_ready(iact_0_address_in_ready	),          
	.iact_from_router_0_address_in_valid(iact_0_address_in_valid	),          
	.iact_from_router_0_address_in      (iact_0_address_in      	),  	
	.iact_from_router_0_data_in_ready   (iact_0_data_in_ready  	 	),        		
	.iact_from_router_0_data_in_valid   (iact_0_data_in_valid   	),  	
	.iact_from_router_0_data_in         (iact_0_data_in        		),  
									
	.iact_from_router_1_address_in_ready(iact_1_address_in_ready	),          
	.iact_from_router_1_address_in_valid(iact_1_address_in_valid	),            
	.iact_from_router_1_address_in      (iact_1_address_in      	),      
	.iact_from_router_1_data_in_ready   (iact_1_data_in_ready   	),        
	.iact_from_router_1_data_in_valid   (iact_1_data_in_valid   	),         
	.iact_from_router_1_data_in         (iact_1_data_in         	),
										
	.iact_from_router_2_address_in_ready(iact_2_address_in_ready),          
	.iact_from_router_2_address_in_valid(iact_2_address_in_valid	),            
	.iact_from_router_2_address_in      (iact_2_address_in      	),      
	.iact_from_router_2_data_in_ready   (iact_2_data_in_ready  	 	),        
	.iact_from_router_2_data_in_vaild   (iact_2_data_in_valid    	),         
	.iact_from_router_2_data_in         (iact_2_data_in          	)   
);                                      

// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam PSUM_FROM_SOU 	= 1'b0;
localparam PSUM_FROM_ROUTER = 1'b1;


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg  PE_0_0_cal_fin_reg; 
reg  PE_0_1_cal_fin_reg; 
reg  PE_0_2_cal_fin_reg; 
reg  PE_1_0_cal_fin_reg; 
reg  PE_1_1_cal_fin_reg; 
reg  PE_1_2_cal_fin_reg; 
reg  PE_2_0_cal_fin_reg; 
reg  PE_2_1_cal_fin_reg; 
reg  PE_2_2_cal_fin_reg; 

reg  PE_0_0_write_fin_reg;
reg  PE_0_1_write_fin_reg;
reg  PE_0_2_write_fin_reg;        
reg  PE_1_0_write_fin_reg;
reg  PE_1_1_write_fin_reg;
reg  PE_1_2_write_fin_reg;        
reg  PE_2_0_write_fin_reg;
reg  PE_2_1_write_fin_reg;
reg  PE_2_2_write_fin_reg;


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// output signals
assign all_write_fin= 	PE_0_0_write_fin_reg & PE_0_1_write_fin_reg & PE_0_2_write_fin_reg & 
						PE_1_0_write_fin_reg & PE_1_1_write_fin_reg & PE_1_2_write_fin_reg & 
						PE_2_0_write_fin_reg & PE_2_1_write_fin_reg & PE_2_2_write_fin_reg; 

assign all_cal_fin	= 	PE_0_0_cal_fin_reg & PE_0_1_cal_fin_reg & PE_0_2_cal_fin_reg & 
						PE_1_0_cal_fin_reg & PE_1_1_cal_fin_reg & PE_1_2_cal_fin_reg & 
						PE_2_0_cal_fin_reg & PE_2_1_cal_fin_reg & PE_2_2_cal_fin_reg; 


assign psum_0_in_ready 	= (psum_data_in_sel == PSUM_FROM_ROUTER) & PE_2_0_psum_in_ready; 
assign psum_1_in_ready 	= (psum_data_in_sel == PSUM_FROM_ROUTER) & PE_2_1_psum_in_ready; 
assign psum_2_in_ready 	= (psum_data_in_sel == PSUM_FROM_ROUTER) & PE_2_2_psum_in_ready; 

assign psum_0_out_valid	= PE_0_0_psum_out_valid;  
assign psum_1_out_valid	= PE_0_1_psum_out_valid;  
assign psum_2_out_valid	= PE_0_2_psum_out_valid;  

assign psum_0_out 		= PE_0_0_psum_out; 
assign psum_1_out 		= PE_0_1_psum_out; 
assign psum_2_out 		= PE_0_2_psum_out; 

assign psum_0_in_from_south_ready = (psum_data_in_sel == PSUM_FROM_ROUTER) ? 1'b0 : PE_2_0_psum_in_ready; 
assign psum_1_in_from_south_ready = (psum_data_in_sel == PSUM_FROM_ROUTER) ? 1'b0 : PE_2_1_psum_in_ready; 
assign psum_2_in_from_south_ready = (psum_data_in_sel == PSUM_FROM_ROUTER) ? 1'b0 : PE_2_2_psum_in_ready; 


// inter-connection
assign PE_0_0_psum_in_valid 			= PE_1_0_psum_out_valid; 
assign PE_0_0_psum_in 					= PE_1_0_psum_out; 
assign PE_0_0_psum_out_ready 			= psum_0_out_ready;
assign PE_0_0_weight_address_in_valid 	= weight_0_0_address_in_valid; 
assign PE_0_0_weight_address_in 		= weight_0_0_address_in; 
assign PE_0_0_weight_data_in_valid 		= weight_0_0_data_in_valid; 
assign PE_0_0_weight_data_in 			= weight_0_0_data_in; 
assign PE_0_0_psum_enq_en 				= psum_load_en; 
assign PE_0_0_do_load_en 				= do_en & ~PE_0_0_cal_fin_reg; 
assign PE_0_0_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_0_0_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_0_1_psum_in_valid 			= PE_1_1_psum_out_valid;
assign PE_0_1_psum_in 					= PE_1_1_psum_out; 
assign PE_0_1_psum_out_ready 			= psum_1_out_ready;
assign PE_0_1_weight_address_in_valid 	= weight_0_1_address_in_valid; 
assign PE_0_1_weight_address_in 		= weight_0_1_address_in; 
assign PE_0_1_weight_data_in_valid 		= weight_0_1_data_in_valid; 
assign PE_0_1_weight_data_in 			= weight_0_1_data_in; 
assign PE_0_1_psum_enq_en 				= psum_load_en; 
assign PE_0_1_do_load_en 				= do_en & ~PE_0_1_cal_fin_reg; 
assign PE_0_1_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_0_1_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_0_2_psum_in_valid 			= PE_1_2_psum_out_valid;
assign PE_0_2_psum_in 					= PE_1_2_psum_out; 
assign PE_0_2_psum_out_ready 			= psum_2_out_ready;
assign PE_0_2_weight_address_in_valid 	= weight_0_2_address_in_valid; 
assign PE_0_2_weight_address_in 		= weight_0_2_address_in; 
assign PE_0_2_weight_data_in_valid 		= weight_0_2_data_in_valid; 
assign PE_0_2_weight_data_in 			= weight_0_2_data_in; 
assign PE_0_2_psum_enq_en 				= psum_load_en; 
assign PE_0_2_do_load_en 				= do_en & ~PE_0_2_cal_fin_reg; 
assign PE_0_2_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_0_2_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_1_0_psum_in_valid 			= PE_2_0_psum_out_valid;
assign PE_1_0_psum_in 					= PE_2_0_psum_out; 
assign PE_1_0_psum_out_ready 			= PE_0_0_psum_in_ready;
assign PE_1_0_weight_address_in_valid 	= weight_1_0_address_in_valid; 
assign PE_1_0_weight_address_in 		= weight_1_0_address_in; 
assign PE_1_0_weight_data_in_valid 		= weight_1_0_data_in_valid; 
assign PE_1_0_weight_data_in 			= weight_1_0_data_in; 
assign PE_1_0_psum_enq_en 				= psum_load_en; 
assign PE_1_0_do_load_en 				= do_en & ~PE_1_0_cal_fin_reg; 
assign PE_1_0_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_1_0_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_1_1_psum_in_valid 			= PE_2_1_psum_out_valid;
assign PE_1_1_psum_in 					= PE_2_1_psum_out; 
assign PE_1_1_psum_out_ready 			= PE_0_1_psum_in_ready;
assign PE_1_1_weight_address_in_valid 	= weight_1_1_address_in_valid;                        
assign PE_1_1_weight_address_in 		= weight_1_1_address_in; 
assign PE_1_1_weight_data_in_valid 		= weight_1_1_data_in_valid; 
assign PE_1_1_weight_data_in 			= weight_1_1_data_in; 
assign PE_1_1_psum_enq_en 				= psum_load_en; 
assign PE_1_1_do_load_en 				= do_en & ~PE_1_1_cal_fin_reg; 
assign PE_1_1_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_1_1_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_1_2_psum_in_valid 			= PE_2_2_psum_out_valid;
assign PE_1_2_psum_in 					= PE_2_2_psum_out; 
assign PE_1_2_psum_out_ready 			= PE_0_2_psum_in_ready;
assign PE_1_2_weight_address_in_valid 	= weight_1_2_address_in_valid; 
assign PE_1_2_weight_address_in 		= weight_1_2_address_in; 
assign PE_1_2_weight_data_in_valid 		= weight_1_2_data_in_valid; 
assign PE_1_2_weight_data_in 			= weight_1_2_data_in; 
assign PE_1_2_psum_enq_en 				= psum_load_en; 
assign PE_1_2_do_load_en 				= do_en & ~PE_1_2_cal_fin_reg; 
assign PE_1_2_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_1_2_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_2_0_psum_in_valid 			= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_0_in_valid : psum_0_in_from_south_valid; 
assign PE_2_0_psum_in 					= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_0_in : psum_0_in_from_south; 
assign PE_2_0_psum_out_ready 			= PE_1_0_psum_in_ready;
assign PE_2_0_weight_address_in_valid 	= weight_2_0_address_in_valid; 
assign PE_2_0_weight_address_in 		= weight_2_0_address_in; 
assign PE_2_0_weight_data_in_valid 		= weight_2_0_data_in_valid; 
assign PE_2_0_weight_data_in 			= weight_2_0_data_in; 
assign PE_2_0_psum_enq_en 				= psum_load_en; 
assign PE_2_0_do_load_en 				= do_en & ~PE_2_0_cal_fin_reg;  
assign PE_2_0_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_2_0_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_2_1_psum_in_valid 			= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_1_in_valid : psum_1_in_from_south_valid; 
assign PE_2_1_psum_in 					= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_1_in : psum_1_in_from_south; 
assign PE_2_1_psum_out_ready 			= PE_1_1_psum_in_ready;
assign PE_2_1_weight_address_in_valid 	= weight_2_1_address_in_valid; 
assign PE_2_1_weight_address_in 		= weight_2_1_address_in; 
assign PE_2_1_weight_data_in_valid 		= weight_2_1_data_in_valid; 
assign PE_2_1_weight_data_in 			= weight_2_1_data_in; 
assign PE_2_1_psum_enq_en 				= psum_load_en; 
assign PE_2_1_do_load_en 				= do_en & ~PE_2_1_cal_fin_reg;  
assign PE_2_1_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_2_1_weight_write_fin_clear	= weight_write_fin_clear;

assign PE_2_2_psum_in_valid 			= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_2_in_valid 	: psum_2_in_from_south_valid; 
assign PE_2_2_psum_in 					= (psum_data_in_sel == PSUM_FROM_ROUTER) ? psum_2_in 		: psum_2_in_from_south; 
assign PE_2_2_psum_out_ready 			= PE_1_2_psum_in_ready;
assign PE_2_2_weight_address_in_valid 	= weight_2_2_address_in_valid; 
assign PE_2_2_weight_address_in 		= weight_2_2_address_in; 
assign PE_2_2_weight_data_in_valid 		= weight_2_2_data_in_valid; 
assign PE_2_2_weight_data_in 			= weight_2_2_data_in; 
assign PE_2_2_psum_enq_en 				= psum_load_en; 
assign PE_2_2_do_load_en 				= do_en & ~PE_2_2_cal_fin_reg;  
assign PE_2_2_iact_write_fin_clear		= iact_write_fin_clear;
assign PE_2_2_weight_write_fin_clear	= weight_write_fin_clear;


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
always@(posedge clock) begin
	if(reset) begin 
		PE_0_0_write_fin_reg <= 1'b0; 
		PE_0_1_write_fin_reg <= 1'b0;
		PE_0_2_write_fin_reg <= 1'b0;
						
		PE_1_0_write_fin_reg <= 1'b0;
		PE_1_1_write_fin_reg <= 1'b0;
		PE_1_2_write_fin_reg <= 1'b0;
						
		PE_2_0_write_fin_reg <= 1'b0;
		PE_2_1_write_fin_reg <= 1'b0;
		PE_2_2_write_fin_reg <= 1'b0;
	end 
	else if(all_cal_fin) begin 
		PE_0_0_write_fin_reg <= 1'b0; 
		PE_0_1_write_fin_reg <= 1'b0;
		PE_0_2_write_fin_reg <= 1'b0;
						
		PE_1_0_write_fin_reg <= 1'b0;
		PE_1_1_write_fin_reg <= 1'b0;
		PE_1_2_write_fin_reg <= 1'b0;
						
		PE_2_0_write_fin_reg <= 1'b0;
		PE_2_1_write_fin_reg <= 1'b0;
		PE_2_2_write_fin_reg <= 1'b0;
	end 
	else begin
		PE_0_0_write_fin_reg <= PE_0_0_write_fin | PE_0_0_write_fin_reg | PE_0_0_disable;        
		PE_0_1_write_fin_reg <= PE_0_1_write_fin | PE_0_1_write_fin_reg | PE_0_1_disable;        
		PE_0_2_write_fin_reg <= PE_0_2_write_fin | PE_0_2_write_fin_reg | PE_0_2_disable;          
		                                                                        
		PE_1_0_write_fin_reg <= PE_1_0_write_fin | PE_1_0_write_fin_reg | PE_1_0_disable;        
		PE_1_1_write_fin_reg <= PE_1_1_write_fin | PE_1_1_write_fin_reg | PE_1_1_disable;        
		PE_1_2_write_fin_reg <= PE_1_2_write_fin | PE_1_2_write_fin_reg | PE_1_2_disable;         
		                                                                        
		PE_2_0_write_fin_reg <= PE_2_0_write_fin | PE_2_0_write_fin_reg | PE_2_0_disable;        
		PE_2_1_write_fin_reg <= PE_2_1_write_fin | PE_2_1_write_fin_reg | PE_2_1_disable;        
		PE_2_2_write_fin_reg <= PE_2_2_write_fin | PE_2_2_write_fin_reg | PE_2_2_disable;
	end
end


always@(posedge clock) begin
	if(reset) begin 
		PE_0_0_cal_fin_reg <= 1'b0; 
		PE_0_1_cal_fin_reg <= 1'b0;
		PE_0_2_cal_fin_reg <= 1'b0;
						
		PE_1_0_cal_fin_reg <= 1'b0;
		PE_1_1_cal_fin_reg <= 1'b0;
		PE_1_2_cal_fin_reg <= 1'b0;
						
		PE_2_0_cal_fin_reg <= 1'b0;
		PE_2_1_cal_fin_reg <= 1'b0;
		PE_2_2_cal_fin_reg <= 1'b0;
	end 
	else if(all_cal_fin) begin 
		PE_0_0_cal_fin_reg <= 1'b0; 
		PE_0_1_cal_fin_reg <= 1'b0;
		PE_0_2_cal_fin_reg <= 1'b0;
						
		PE_1_0_cal_fin_reg <= 1'b0;
		PE_1_1_cal_fin_reg <= 1'b0;
		PE_1_2_cal_fin_reg <= 1'b0;
						
		PE_2_0_cal_fin_reg <= 1'b0;
		PE_2_1_cal_fin_reg <= 1'b0;
		PE_2_2_cal_fin_reg <= 1'b0;
	end 
	else begin
		PE_0_0_cal_fin_reg <= PE_0_0_cal_fin | PE_0_0_cal_fin_reg | PE_0_0_disable;        
		PE_0_1_cal_fin_reg <= PE_0_1_cal_fin | PE_0_1_cal_fin_reg | PE_0_1_disable;        
		PE_0_2_cal_fin_reg <= PE_0_2_cal_fin | PE_0_2_cal_fin_reg | PE_0_2_disable;          
		                                                                  
		PE_1_0_cal_fin_reg <= PE_1_0_cal_fin | PE_1_0_cal_fin_reg | PE_1_0_disable;        
		PE_1_1_cal_fin_reg <= PE_1_1_cal_fin | PE_1_1_cal_fin_reg | PE_1_1_disable;        
		PE_1_2_cal_fin_reg <= PE_1_2_cal_fin | PE_1_2_cal_fin_reg | PE_1_2_disable;         
		                                                                  
		PE_2_0_cal_fin_reg <= PE_2_0_cal_fin | PE_2_0_cal_fin_reg | PE_2_0_disable;        
		PE_2_1_cal_fin_reg <= PE_2_1_cal_fin | PE_2_1_cal_fin_reg | PE_2_1_disable;        
		PE_2_2_cal_fin_reg <= PE_2_2_cal_fin | PE_2_2_cal_fin_reg | PE_2_2_disable;
	end
end


endmodule
