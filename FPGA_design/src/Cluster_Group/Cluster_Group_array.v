module ClusterGroup_array(

	input         			clock,
	input         			reset,
	
	input					psum_acc_fin,
	// -------------------- CG_0_0 -------------------- //
	input 			     	CG_0_0_PE_cluster_iact_data_in_sel,
	input 			[1:0]	CG_0_0_PE_cluster_iact_data_out_sel,
	input 			     	CG_0_0_PE_cluster_psum_data_in_sel,
						
	input 			[1:0]	CG_0_0_router_cluster_iact_data_in_sel,
	input 			[1:0]	CG_0_0_router_cluster_iact_data_out_sel,
	input 			     	CG_0_0_router_cluster_weight_data_in_sel,
	input 			     	CG_0_0_router_cluster_weight_data_out_sel,
	input 			     	CG_0_0_router_cluster_psum_data_in_sel,
	input 			     	CG_0_0_router_cluster_psum_data_out_sel,
						
	input 			     	CG_0_0_read_psum_en,
	output			     	CG_0_0_cal_fin,
	input 			     	CG_0_0_cg_en,
	output			     	CG_0_0_PE_weight_load_en,
	output			     	CG_0_0_GLB_iact_load_en,
	input					CG_0_0_src_GLB_load_fin,
	input					CG_0_0_psum_SRAM_Bank_0_read_out_en,
	input					CG_0_0_psum_SRAM_Bank_1_read_out_en,
	input					CG_0_0_psum_SRAM_Bank_2_read_out_en,
	
	input					CG_0_0_PE_0_0_disable,
	input					CG_0_0_PE_0_1_disable,
	input					CG_0_0_PE_0_2_disable,
	input					CG_0_0_PE_1_0_disable,
	input					CG_0_0_PE_1_1_disable,
	input					CG_0_0_PE_1_2_disable,
	input					CG_0_0_PE_2_0_disable,
	input					CG_0_0_PE_2_1_disable,
	input					CG_0_0_PE_2_2_disable,	
	
	input			[9:0]	CG_0_0_GLB_iact_0_0_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_0_1_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_0_2_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_1_0_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_1_1_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_1_2_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_2_0_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_2_1_read_addr,
	input			[9:0]	CG_0_0_GLB_iact_2_2_read_addr,
				
	input					CG_0_0_GLB_psum_write_en,
	input			[9:0]	CG_0_0_GLB_psum_0_write_addr,
	input			[9:0]	CG_0_0_GLB_psum_1_write_addr,
	input			[9:0]	CG_0_0_GLB_psum_2_write_addr,
	input			[9:0]	CG_0_0_GLB_psum_0_read_addr,
	input			[9:0]	CG_0_0_GLB_psum_1_read_addr,
	input			[9:0]	CG_0_0_GLB_psum_2_read_addr,
				
	output			      	CG_0_0_GLB_iact_0_0_address_in_ready,
	input 			      	CG_0_0_GLB_iact_0_0_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_0_0_address_in,
	output			      	CG_0_0_GLB_iact_0_0_data_in_ready,
	input 			      	CG_0_0_GLB_iact_0_0_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_0_0_data_in,
	output			      	CG_0_0_GLB_iact_0_1_address_in_ready,
	input 			      	CG_0_0_GLB_iact_0_1_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_0_1_address_in,
	output			      	CG_0_0_GLB_iact_0_1_data_in_ready,
	input 			      	CG_0_0_GLB_iact_0_1_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_0_1_data_in,
	output			       	CG_0_0_GLB_iact_0_2_address_in_ready,
	input 			       	CG_0_0_GLB_iact_0_2_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_0_2_address_in,
	output			       	CG_0_0_GLB_iact_0_2_data_in_ready,
	input 			       	CG_0_0_GLB_iact_0_2_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_0_2_data_in,
	output			       	CG_0_0_GLB_iact_1_0_address_in_ready,
	input 			       	CG_0_0_GLB_iact_1_0_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_1_0_address_in,
	output			       	CG_0_0_GLB_iact_1_0_data_in_ready,
	input 			       	CG_0_0_GLB_iact_1_0_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_1_0_data_in,
	output			       	CG_0_0_GLB_iact_1_1_address_in_ready,
	input 			       	CG_0_0_GLB_iact_1_1_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_1_1_address_in,
	output			       	CG_0_0_GLB_iact_1_1_data_in_ready,
	input 			       	CG_0_0_GLB_iact_1_1_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_1_1_data_in,
	output			       	CG_0_0_GLB_iact_1_2_address_in_ready,
	input 			       	CG_0_0_GLB_iact_1_2_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_1_2_address_in,
	output			       	CG_0_0_GLB_iact_1_2_data_in_ready,
	input 			       	CG_0_0_GLB_iact_1_2_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_1_2_data_in,
	output			       	CG_0_0_GLB_iact_2_0_address_in_ready,
	input 			       	CG_0_0_GLB_iact_2_0_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_2_0_address_in,
	output			       	CG_0_0_GLB_iact_2_0_data_in_ready,
	input 			       	CG_0_0_GLB_iact_2_0_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_2_0_data_in,
	output			       	CG_0_0_GLB_iact_2_1_address_in_ready,
	input 			       	CG_0_0_GLB_iact_2_1_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_2_1_address_in,
	output			       	CG_0_0_GLB_iact_2_1_data_in_ready,
	input 			       	CG_0_0_GLB_iact_2_1_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_2_1_data_in,
	output			       	CG_0_0_GLB_iact_2_2_address_in_ready,
	input 			       	CG_0_0_GLB_iact_2_2_address_in_valid,
	input 			[6:0]  	CG_0_0_GLB_iact_2_2_address_in,
	output			       	CG_0_0_GLB_iact_2_2_data_in_ready,
	input 			       	CG_0_0_GLB_iact_2_2_data_in_valid,
	input 			[11:0] 	CG_0_0_GLB_iact_2_2_data_in,
				
	output			       	CG_0_0_GLB_weight_0_address_in_ready,
	input 			       	CG_0_0_GLB_weight_0_address_in_valid,
	input 			[7:0]  	CG_0_0_GLB_weight_0_address_in,
	output			       	CG_0_0_GLB_weight_0_data_in_ready,
	input 			       	CG_0_0_GLB_weight_0_data_in_valid,
	input 			[12:0] 	CG_0_0_GLB_weight_0_data_in,
	output			       	CG_0_0_GLB_weight_1_address_in_ready,
	input 			       	CG_0_0_GLB_weight_1_address_in_valid,
	input 			[7:0]  	CG_0_0_GLB_weight_1_address_in,
	output			       	CG_0_0_GLB_weight_1_data_in_ready,
	input 			       	CG_0_0_GLB_weight_1_data_in_valid,
	input 			[12:0] 	CG_0_0_GLB_weight_1_data_in,
	output			       	CG_0_0_GLB_weight_2_address_in_ready,
	input 			       	CG_0_0_GLB_weight_2_address_in_valid,
	input 			[7:0]  	CG_0_0_GLB_weight_2_address_in,
	output			       	CG_0_0_GLB_weight_2_data_in_ready,
	input 			       	CG_0_0_GLB_weight_2_data_in_valid,
	input 			[12:0] 	CG_0_0_GLB_weight_2_data_in,
	
	output        			CG_0_0_GLB_psum_0_data_in_ready,
	input         			CG_0_0_GLB_psum_0_data_in_valid,
	input	signed 	[20:0] 	CG_0_0_GLB_psum_0_data_in,
	input         			CG_0_0_GLB_psum_0_data_out_ready,
	output        			CG_0_0_GLB_psum_0_data_out_valid,
	output 	signed 	[20:0] 	CG_0_0_GLB_psum_0_data_out,
	output        			CG_0_0_GLB_psum_1_data_in_ready,
	input         			CG_0_0_GLB_psum_1_data_in_valid,
	input 	signed 	[20:0] 	CG_0_0_GLB_psum_1_data_in,
	input         			CG_0_0_GLB_psum_1_data_out_ready,
	output        			CG_0_0_GLB_psum_1_data_out_valid,
	output 	signed 	[20:0] 	CG_0_0_GLB_psum_1_data_out,
	output        			CG_0_0_GLB_psum_2_data_in_ready,
	input         			CG_0_0_GLB_psum_2_data_in_valid,
	input 	signed 	[20:0] 	CG_0_0_GLB_psum_2_data_in,
	input         			CG_0_0_GLB_psum_2_data_out_ready,
	output        			CG_0_0_GLB_psum_2_data_out_valid,
	output 	signed 	[20:0] 	CG_0_0_GLB_psum_2_data_out,
	
	input			[4:0]	CG_0_0_PSUM_DEPTH,
	input					CG_0_0_psum_spad_clear,
							
	input					CG_0_0_iact_write_fin_clear,
	input					CG_0_0_weight_write_fin_clear,
	
	
	// -------------------- CG_0_1 -------------------- //
	input 			     	CG_0_1_PE_cluster_iact_data_in_sel,
	input 			[1:0]	CG_0_1_PE_cluster_iact_data_out_sel,
	input 			     	CG_0_1_PE_cluster_psum_data_in_sel,
								 
	input 			[1:0]	CG_0_1_router_cluster_iact_data_in_sel,
	input 			[1:0]	CG_0_1_router_cluster_iact_data_out_sel,
	input 			     	CG_0_1_router_cluster_weight_data_in_sel,
	input 			     	CG_0_1_router_cluster_weight_data_out_sel,
	input 			     	CG_0_1_router_cluster_psum_data_in_sel,
	input 			     	CG_0_1_router_cluster_psum_data_out_sel,
								 
	input 			     	CG_0_1_read_psum_en,
	output			     	CG_0_1_cal_fin,
	input 			     	CG_0_1_cg_en,
	output			     	CG_0_1_PE_weight_load_en,
	output			     	CG_0_1_GLB_iact_load_en,
	input					CG_0_1_src_GLB_load_fin,
	input					CG_0_1_psum_SRAM_Bank_0_read_out_en,
	input					CG_0_1_psum_SRAM_Bank_1_read_out_en,
	input					CG_0_1_psum_SRAM_Bank_2_read_out_en,
	
	input					CG_0_1_PE_0_0_disable,
	input					CG_0_1_PE_0_1_disable,
	input					CG_0_1_PE_0_2_disable,
	input					CG_0_1_PE_1_0_disable,
	input					CG_0_1_PE_1_1_disable,
	input					CG_0_1_PE_1_2_disable,
	input					CG_0_1_PE_2_0_disable,
	input					CG_0_1_PE_2_1_disable,
	input					CG_0_1_PE_2_2_disable,
	
	input			[9:0]	CG_0_1_GLB_iact_0_0_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_0_1_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_0_2_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_1_0_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_1_1_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_1_2_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_2_0_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_2_1_read_addr,
	input			[9:0]	CG_0_1_GLB_iact_2_2_read_addr,
	
	input					CG_0_1_GLB_psum_write_en,
	input			[9:0]	CG_0_1_GLB_psum_0_write_addr,
	input			[9:0]	CG_0_1_GLB_psum_1_write_addr,
	input			[9:0]	CG_0_1_GLB_psum_2_write_addr,
	input			[9:0]	CG_0_1_GLB_psum_0_read_addr,
	input			[9:0]	CG_0_1_GLB_psum_1_read_addr,
	input			[9:0]	CG_0_1_GLB_psum_2_read_addr,
								 
	output			      	CG_0_1_GLB_iact_0_0_address_in_ready,
	input 			      	CG_0_1_GLB_iact_0_0_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_0_0_address_in,
	output			      	CG_0_1_GLB_iact_0_0_data_in_ready,
	input 			      	CG_0_1_GLB_iact_0_0_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_0_0_data_in,
	output			      	CG_0_1_GLB_iact_0_1_address_in_ready,
	input 			      	CG_0_1_GLB_iact_0_1_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_0_1_address_in,
	output			      	CG_0_1_GLB_iact_0_1_data_in_ready,
	input 			      	CG_0_1_GLB_iact_0_1_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_0_1_data_in,
	output			       	CG_0_1_GLB_iact_0_2_address_in_ready,
	input 			       	CG_0_1_GLB_iact_0_2_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_0_2_address_in,
	output			       	CG_0_1_GLB_iact_0_2_data_in_ready,
	input 			       	CG_0_1_GLB_iact_0_2_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_0_2_data_in,
	output			       	CG_0_1_GLB_iact_1_0_address_in_ready,
	input 			       	CG_0_1_GLB_iact_1_0_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_1_0_address_in,
	output			       	CG_0_1_GLB_iact_1_0_data_in_ready,
	input 			       	CG_0_1_GLB_iact_1_0_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_1_0_data_in,
	output			       	CG_0_1_GLB_iact_1_1_address_in_ready,
	input 			       	CG_0_1_GLB_iact_1_1_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_1_1_address_in,
	output			       	CG_0_1_GLB_iact_1_1_data_in_ready,
	input 			       	CG_0_1_GLB_iact_1_1_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_1_1_data_in,
	output			       	CG_0_1_GLB_iact_1_2_address_in_ready,
	input 			       	CG_0_1_GLB_iact_1_2_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_1_2_address_in,
	output			       	CG_0_1_GLB_iact_1_2_data_in_ready,
	input 			       	CG_0_1_GLB_iact_1_2_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_1_2_data_in,
	output			       	CG_0_1_GLB_iact_2_0_address_in_ready,
	input 			       	CG_0_1_GLB_iact_2_0_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_2_0_address_in,
	output			       	CG_0_1_GLB_iact_2_0_data_in_ready,
	input 			       	CG_0_1_GLB_iact_2_0_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_2_0_data_in,
	output			       	CG_0_1_GLB_iact_2_1_address_in_ready,
	input 			       	CG_0_1_GLB_iact_2_1_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_2_1_address_in,
	output			       	CG_0_1_GLB_iact_2_1_data_in_ready,
	input 			       	CG_0_1_GLB_iact_2_1_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_2_1_data_in,
	output			       	CG_0_1_GLB_iact_2_2_address_in_ready,
	input 			       	CG_0_1_GLB_iact_2_2_address_in_valid,
	input 			[6:0]  	CG_0_1_GLB_iact_2_2_address_in,
	output			       	CG_0_1_GLB_iact_2_2_data_in_ready,
	input 			       	CG_0_1_GLB_iact_2_2_data_in_valid,
	input 			[11:0] 	CG_0_1_GLB_iact_2_2_data_in,
								 
	output			       	CG_0_1_GLB_weight_0_address_in_ready,
	input 			       	CG_0_1_GLB_weight_0_address_in_valid,
	input 			[7:0]  	CG_0_1_GLB_weight_0_address_in,
	output			       	CG_0_1_GLB_weight_0_data_in_ready,
	input 			       	CG_0_1_GLB_weight_0_data_in_valid,
	input 			[12:0] 	CG_0_1_GLB_weight_0_data_in,
	output			       	CG_0_1_GLB_weight_1_address_in_ready,
	input 			       	CG_0_1_GLB_weight_1_address_in_valid,
	input 			[7:0]  	CG_0_1_GLB_weight_1_address_in,
	output			       	CG_0_1_GLB_weight_1_data_in_ready,
	input 			       	CG_0_1_GLB_weight_1_data_in_valid,
	input 			[12:0] 	CG_0_1_GLB_weight_1_data_in,
	output			       	CG_0_1_GLB_weight_2_address_in_ready,
	input 			       	CG_0_1_GLB_weight_2_address_in_valid,
	input 			[7:0]  	CG_0_1_GLB_weight_2_address_in,
	output			       	CG_0_1_GLB_weight_2_data_in_ready,
	input 			       	CG_0_1_GLB_weight_2_data_in_valid,
	input 			[12:0] 	CG_0_1_GLB_weight_2_data_in,
								 
	output        			CG_0_1_GLB_psum_0_data_in_ready,
	input         			CG_0_1_GLB_psum_0_data_in_valid,
	input	signed 	[20:0] 	CG_0_1_GLB_psum_0_data_in,
	input         			CG_0_1_GLB_psum_0_data_out_ready,
	output        			CG_0_1_GLB_psum_0_data_out_valid,
	output 	signed 	[20:0] 	CG_0_1_GLB_psum_0_data_out,
	output        			CG_0_1_GLB_psum_1_data_in_ready,
	input         			CG_0_1_GLB_psum_1_data_in_valid,
	input 	signed 	[20:0] 	CG_0_1_GLB_psum_1_data_in,
	input         			CG_0_1_GLB_psum_1_data_out_ready,
	output        			CG_0_1_GLB_psum_1_data_out_valid,
	output 	signed 	[20:0] 	CG_0_1_GLB_psum_1_data_out,
	output        			CG_0_1_GLB_psum_2_data_in_ready,
	input         			CG_0_1_GLB_psum_2_data_in_valid,
	input 	signed 	[20:0] 	CG_0_1_GLB_psum_2_data_in,
	input         			CG_0_1_GLB_psum_2_data_out_ready,
	output        			CG_0_1_GLB_psum_2_data_out_valid,
	output 	signed 	[20:0] 	CG_0_1_GLB_psum_2_data_out,
								 
	input			[4:0]	CG_0_1_PSUM_DEPTH,
	input					CG_0_1_psum_spad_clear,
								 
	input					CG_0_1_iact_write_fin_clear,
	input					CG_0_1_weight_write_fin_clear,
	
	// -------------------- CG_1_0 -------------------- //
	input 			     	CG_1_0_PE_cluster_iact_data_in_sel,
	input 			[1:0]	CG_1_0_PE_cluster_iact_data_out_sel,
	input 			     	CG_1_0_PE_cluster_psum_data_in_sel,
							   
	input 			[1:0]	CG_1_0_router_cluster_iact_data_in_sel,
	input 			[1:0]	CG_1_0_router_cluster_iact_data_out_sel,
	input 			     	CG_1_0_router_cluster_weight_data_in_sel,
	input 			     	CG_1_0_router_cluster_weight_data_out_sel,
	input 			     	CG_1_0_router_cluster_psum_data_in_sel,
	input 			     	CG_1_0_router_cluster_psum_data_out_sel,
							   
	input 			     	CG_1_0_read_psum_en,
	output			     	CG_1_0_cal_fin,
	input 			     	CG_1_0_cg_en,
	output			     	CG_1_0_PE_weight_load_en,
	output			     	CG_1_0_GLB_iact_load_en,
	input					CG_1_0_src_GLB_load_fin,
	input					CG_1_0_psum_SRAM_Bank_0_read_out_en,
	input					CG_1_0_psum_SRAM_Bank_1_read_out_en,
	input					CG_1_0_psum_SRAM_Bank_2_read_out_en,
	
	input					CG_1_0_PE_0_0_disable,
	input					CG_1_0_PE_0_1_disable,
	input					CG_1_0_PE_0_2_disable,
	input					CG_1_0_PE_1_0_disable,
	input					CG_1_0_PE_1_1_disable,
	input					CG_1_0_PE_1_2_disable,
	input					CG_1_0_PE_2_0_disable,
	input					CG_1_0_PE_2_1_disable,
	input					CG_1_0_PE_2_2_disable,
							   
	input			[9:0]	CG_1_0_GLB_iact_0_0_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_0_1_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_0_2_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_1_0_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_1_1_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_1_2_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_2_0_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_2_1_read_addr,
	input			[9:0]	CG_1_0_GLB_iact_2_2_read_addr,
	
	input					CG_1_0_GLB_psum_write_en,
	input			[9:0]	CG_1_0_GLB_psum_0_write_addr,
	input			[9:0]	CG_1_0_GLB_psum_1_write_addr,
	input			[9:0]	CG_1_0_GLB_psum_2_write_addr,
	input			[9:0]	CG_1_0_GLB_psum_0_read_addr,
	input			[9:0]	CG_1_0_GLB_psum_1_read_addr,
	input			[9:0]	CG_1_0_GLB_psum_2_read_addr,
							   
	output			      	CG_1_0_GLB_iact_0_0_address_in_ready,
	input 			      	CG_1_0_GLB_iact_0_0_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_0_0_address_in,
	output			      	CG_1_0_GLB_iact_0_0_data_in_ready,
	input 			      	CG_1_0_GLB_iact_0_0_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_0_0_data_in,
	output			      	CG_1_0_GLB_iact_0_1_address_in_ready,
	input 			      	CG_1_0_GLB_iact_0_1_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_0_1_address_in,
	output			      	CG_1_0_GLB_iact_0_1_data_in_ready,
	input 			      	CG_1_0_GLB_iact_0_1_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_0_1_data_in,
	output			       	CG_1_0_GLB_iact_0_2_address_in_ready,
	input 			       	CG_1_0_GLB_iact_0_2_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_0_2_address_in,
	output			       	CG_1_0_GLB_iact_0_2_data_in_ready,
	input 			       	CG_1_0_GLB_iact_0_2_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_0_2_data_in,
	output			       	CG_1_0_GLB_iact_1_0_address_in_ready,
	input 			       	CG_1_0_GLB_iact_1_0_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_1_0_address_in,
	output			       	CG_1_0_GLB_iact_1_0_data_in_ready,
	input 			       	CG_1_0_GLB_iact_1_0_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_1_0_data_in,
	output			       	CG_1_0_GLB_iact_1_1_address_in_ready,
	input 			       	CG_1_0_GLB_iact_1_1_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_1_1_address_in,
	output			       	CG_1_0_GLB_iact_1_1_data_in_ready,
	input 			       	CG_1_0_GLB_iact_1_1_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_1_1_data_in,
	output			       	CG_1_0_GLB_iact_1_2_address_in_ready,
	input 			       	CG_1_0_GLB_iact_1_2_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_1_2_address_in,
	output			       	CG_1_0_GLB_iact_1_2_data_in_ready,
	input 			       	CG_1_0_GLB_iact_1_2_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_1_2_data_in,
	output			       	CG_1_0_GLB_iact_2_0_address_in_ready,
	input 			       	CG_1_0_GLB_iact_2_0_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_2_0_address_in,
	output			       	CG_1_0_GLB_iact_2_0_data_in_ready,
	input 			       	CG_1_0_GLB_iact_2_0_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_2_0_data_in,
	output			       	CG_1_0_GLB_iact_2_1_address_in_ready,
	input 			       	CG_1_0_GLB_iact_2_1_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_2_1_address_in,
	output			       	CG_1_0_GLB_iact_2_1_data_in_ready,
	input 			       	CG_1_0_GLB_iact_2_1_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_2_1_data_in,
	output			       	CG_1_0_GLB_iact_2_2_address_in_ready,
	input 			       	CG_1_0_GLB_iact_2_2_address_in_valid,
	input 			[6:0]  	CG_1_0_GLB_iact_2_2_address_in,
	output			       	CG_1_0_GLB_iact_2_2_data_in_ready,
	input 			       	CG_1_0_GLB_iact_2_2_data_in_valid,
	input 			[11:0] 	CG_1_0_GLB_iact_2_2_data_in,
							   
	output			       	CG_1_0_GLB_weight_0_address_in_ready,
	input 			       	CG_1_0_GLB_weight_0_address_in_valid,
	input 			[7:0]  	CG_1_0_GLB_weight_0_address_in,
	output			       	CG_1_0_GLB_weight_0_data_in_ready,
	input 			       	CG_1_0_GLB_weight_0_data_in_valid,
	input 			[12:0] 	CG_1_0_GLB_weight_0_data_in,
	output			       	CG_1_0_GLB_weight_1_address_in_ready,
	input 			       	CG_1_0_GLB_weight_1_address_in_valid,
	input 			[7:0]  	CG_1_0_GLB_weight_1_address_in,
	output			       	CG_1_0_GLB_weight_1_data_in_ready,
	input 			       	CG_1_0_GLB_weight_1_data_in_valid,
	input 			[12:0] 	CG_1_0_GLB_weight_1_data_in,
	output			       	CG_1_0_GLB_weight_2_address_in_ready,
	input 			       	CG_1_0_GLB_weight_2_address_in_valid,
	input 			[7:0]  	CG_1_0_GLB_weight_2_address_in,
	output			       	CG_1_0_GLB_weight_2_data_in_ready,
	input 			       	CG_1_0_GLB_weight_2_data_in_valid,
	input 			[12:0] 	CG_1_0_GLB_weight_2_data_in,
							   
	output        			CG_1_0_GLB_psum_0_data_in_ready,
	input         			CG_1_0_GLB_psum_0_data_in_valid,
	input	signed 	[20:0] 	CG_1_0_GLB_psum_0_data_in,
	input         			CG_1_0_GLB_psum_0_data_out_ready,
	output        			CG_1_0_GLB_psum_0_data_out_valid,
	output 	signed 	[20:0] 	CG_1_0_GLB_psum_0_data_out,
	output        			CG_1_0_GLB_psum_1_data_in_ready,
	input         			CG_1_0_GLB_psum_1_data_in_valid,
	input 	signed 	[20:0] 	CG_1_0_GLB_psum_1_data_in,
	input         			CG_1_0_GLB_psum_1_data_out_ready,
	output        			CG_1_0_GLB_psum_1_data_out_valid,
	output 	signed 	[20:0] 	CG_1_0_GLB_psum_1_data_out,
	output        			CG_1_0_GLB_psum_2_data_in_ready,
	input         			CG_1_0_GLB_psum_2_data_in_valid,
	input 	signed 	[20:0] 	CG_1_0_GLB_psum_2_data_in,
	input         			CG_1_0_GLB_psum_2_data_out_ready,
	output        			CG_1_0_GLB_psum_2_data_out_valid,
	output 	signed 	[20:0] 	CG_1_0_GLB_psum_2_data_out,
							   
	input			[4:0]	CG_1_0_PSUM_DEPTH,
	input					CG_1_0_psum_spad_clear,
							   
	input					CG_1_0_iact_write_fin_clear,
	input					CG_1_0_weight_write_fin_clear,
							   
							   
	// -------------------- CG_1_1 -------------------- //
	input 			     	CG_1_1_PE_cluster_iact_data_in_sel,
	input 			[1:0]	CG_1_1_PE_cluster_iact_data_out_sel,
	input 			     	CG_1_1_PE_cluster_psum_data_in_sel,
								
	input 			[1:0]	CG_1_1_router_cluster_iact_data_in_sel,
	input 			[1:0]	CG_1_1_router_cluster_iact_data_out_sel,
	input 			     	CG_1_1_router_cluster_weight_data_in_sel,
	input 			     	CG_1_1_router_cluster_weight_data_out_sel,
	input 			     	CG_1_1_router_cluster_psum_data_in_sel,
	input 			     	CG_1_1_router_cluster_psum_data_out_sel,

	input 			     	CG_1_1_read_psum_en,
	output			     	CG_1_1_cal_fin,
	input 			     	CG_1_1_cg_en,
	output			     	CG_1_1_PE_weight_load_en,
	output			     	CG_1_1_GLB_iact_load_en,
	input					CG_1_1_src_GLB_load_fin,
	input					CG_1_1_psum_SRAM_Bank_0_read_out_en,
	input					CG_1_1_psum_SRAM_Bank_1_read_out_en,
	input					CG_1_1_psum_SRAM_Bank_2_read_out_en,
	
	input					CG_1_1_PE_0_0_disable,
	input					CG_1_1_PE_0_1_disable,
	input					CG_1_1_PE_0_2_disable,
	input					CG_1_1_PE_1_0_disable,
	input					CG_1_1_PE_1_1_disable,
	input					CG_1_1_PE_1_2_disable,
	input					CG_1_1_PE_2_0_disable,
	input					CG_1_1_PE_2_1_disable,
	input					CG_1_1_PE_2_2_disable,
	
	input			[9:0]	CG_1_1_GLB_iact_0_0_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_0_1_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_0_2_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_1_0_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_1_1_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_1_2_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_2_0_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_2_1_read_addr,
	input			[9:0]	CG_1_1_GLB_iact_2_2_read_addr,
	
	input					CG_1_1_GLB_psum_write_en,
	input			[9:0]	CG_1_1_GLB_psum_0_write_addr,
	input			[9:0]	CG_1_1_GLB_psum_1_write_addr,
	input			[9:0]	CG_1_1_GLB_psum_2_write_addr,
	input			[9:0]	CG_1_1_GLB_psum_0_read_addr,
	input			[9:0]	CG_1_1_GLB_psum_1_read_addr,
	input			[9:0]	CG_1_1_GLB_psum_2_read_addr,
								
	output			      	CG_1_1_GLB_iact_0_0_address_in_ready,
	input 			      	CG_1_1_GLB_iact_0_0_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_0_0_address_in,
	output			      	CG_1_1_GLB_iact_0_0_data_in_ready,
	input 			      	CG_1_1_GLB_iact_0_0_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_0_0_data_in,
	output			      	CG_1_1_GLB_iact_0_1_address_in_ready,
	input 			      	CG_1_1_GLB_iact_0_1_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_0_1_address_in,
	output			      	CG_1_1_GLB_iact_0_1_data_in_ready,
	input 			      	CG_1_1_GLB_iact_0_1_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_0_1_data_in,
	output			       	CG_1_1_GLB_iact_0_2_address_in_ready,
	input 			       	CG_1_1_GLB_iact_0_2_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_0_2_address_in,
	output			       	CG_1_1_GLB_iact_0_2_data_in_ready,
	input 			       	CG_1_1_GLB_iact_0_2_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_0_2_data_in,
	output			       	CG_1_1_GLB_iact_1_0_address_in_ready,
	input 			       	CG_1_1_GLB_iact_1_0_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_1_0_address_in,
	output			       	CG_1_1_GLB_iact_1_0_data_in_ready,
	input 			       	CG_1_1_GLB_iact_1_0_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_1_0_data_in,
	output			       	CG_1_1_GLB_iact_1_1_address_in_ready,
	input 			       	CG_1_1_GLB_iact_1_1_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_1_1_address_in,
	output			       	CG_1_1_GLB_iact_1_1_data_in_ready,
	input 			       	CG_1_1_GLB_iact_1_1_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_1_1_data_in,
	output			       	CG_1_1_GLB_iact_1_2_address_in_ready,
	input 			       	CG_1_1_GLB_iact_1_2_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_1_2_address_in,
	output			       	CG_1_1_GLB_iact_1_2_data_in_ready,
	input 			       	CG_1_1_GLB_iact_1_2_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_1_2_data_in,
	output			       	CG_1_1_GLB_iact_2_0_address_in_ready,
	input 			       	CG_1_1_GLB_iact_2_0_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_2_0_address_in,
	output			       	CG_1_1_GLB_iact_2_0_data_in_ready,
	input 			       	CG_1_1_GLB_iact_2_0_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_2_0_data_in,
	output			       	CG_1_1_GLB_iact_2_1_address_in_ready,
	input 			       	CG_1_1_GLB_iact_2_1_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_2_1_address_in,
	output			       	CG_1_1_GLB_iact_2_1_data_in_ready,
	input 			       	CG_1_1_GLB_iact_2_1_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_2_1_data_in,
	output			       	CG_1_1_GLB_iact_2_2_address_in_ready,
	input 			       	CG_1_1_GLB_iact_2_2_address_in_valid,
	input 			[6:0]  	CG_1_1_GLB_iact_2_2_address_in,
	output			       	CG_1_1_GLB_iact_2_2_data_in_ready,
	input 			       	CG_1_1_GLB_iact_2_2_data_in_valid,
	input 			[11:0] 	CG_1_1_GLB_iact_2_2_data_in,
								
	output			       	CG_1_1_GLB_weight_0_address_in_ready,
	input 			       	CG_1_1_GLB_weight_0_address_in_valid,
	input 			[7:0]  	CG_1_1_GLB_weight_0_address_in,
	output			       	CG_1_1_GLB_weight_0_data_in_ready,
	input 			       	CG_1_1_GLB_weight_0_data_in_valid,
	input 			[12:0] 	CG_1_1_GLB_weight_0_data_in,
	output			       	CG_1_1_GLB_weight_1_address_in_ready,
	input 			       	CG_1_1_GLB_weight_1_address_in_valid,
	input 			[7:0]  	CG_1_1_GLB_weight_1_address_in,
	output			       	CG_1_1_GLB_weight_1_data_in_ready,
	input 			       	CG_1_1_GLB_weight_1_data_in_valid,
	input 			[12:0] 	CG_1_1_GLB_weight_1_data_in,
	output			       	CG_1_1_GLB_weight_2_address_in_ready,
	input 			       	CG_1_1_GLB_weight_2_address_in_valid,
	input 			[7:0]  	CG_1_1_GLB_weight_2_address_in,
	output			       	CG_1_1_GLB_weight_2_data_in_ready,
	input 			       	CG_1_1_GLB_weight_2_data_in_valid,
	input 			[12:0] 	CG_1_1_GLB_weight_2_data_in,
								
	output        			CG_1_1_GLB_psum_0_data_in_ready,
	input         			CG_1_1_GLB_psum_0_data_in_valid,
	input	signed 	[20:0] 	CG_1_1_GLB_psum_0_data_in,
	input         			CG_1_1_GLB_psum_0_data_out_ready,
	output        			CG_1_1_GLB_psum_0_data_out_valid,
	output 	signed 	[20:0] 	CG_1_1_GLB_psum_0_data_out,
	output        			CG_1_1_GLB_psum_1_data_in_ready,
	input         			CG_1_1_GLB_psum_1_data_in_valid,
	input 	signed 	[20:0] 	CG_1_1_GLB_psum_1_data_in,
	input         			CG_1_1_GLB_psum_1_data_out_ready,
	output        			CG_1_1_GLB_psum_1_data_out_valid,
	output 	signed 	[20:0] 	CG_1_1_GLB_psum_1_data_out,
	output        			CG_1_1_GLB_psum_2_data_in_ready,
	input         			CG_1_1_GLB_psum_2_data_in_valid,
	input 	signed 	[20:0] 	CG_1_1_GLB_psum_2_data_in,
	input         			CG_1_1_GLB_psum_2_data_out_ready,
	output        			CG_1_1_GLB_psum_2_data_out_valid,
	output 	signed 	[20:0] 	CG_1_1_GLB_psum_2_data_out,
								
	input			[4:0]	CG_1_1_PSUM_DEPTH,
	input					CG_1_1_psum_spad_clear,
								
	input					CG_1_1_iact_write_fin_clear,
	input					CG_1_1_weight_write_fin_clear
	
);



// --------------------- CG_0_0 --------------------- //
wire  		      		CG_0_0_clock = clock;
wire  		      		CG_0_0_reset = reset;

wire 			       	CG_0_0_router_iact_0_0_north_address_in_ready;
wire 			       	CG_0_0_router_iact_0_0_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_north_address_in;
wire 			       	CG_0_0_router_iact_0_0_north_data_in_ready;
wire 			       	CG_0_0_router_iact_0_0_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_north_data_in;
wire 			       	CG_0_0_router_iact_0_0_south_address_in_ready;
wire 			       	CG_0_0_router_iact_0_0_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_south_address_in;
wire 			       	CG_0_0_router_iact_0_0_south_data_in_ready;
wire 			       	CG_0_0_router_iact_0_0_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_south_data_in;
wire 			       	CG_0_0_router_iact_0_0_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_0_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_horiz_address_in;
wire 			       	CG_0_0_router_iact_0_0_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_0_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_horiz_data_in;
wire 			       	CG_0_0_router_iact_0_0_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_0_0_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_north_address_out;
wire 			       	CG_0_0_router_iact_0_0_north_data_out_ready;
wire 			       	CG_0_0_router_iact_0_0_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_north_data_out;
wire 			       	CG_0_0_router_iact_0_0_south_address_out_ready;
wire 			       	CG_0_0_router_iact_0_0_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_south_address_out;
wire 			       	CG_0_0_router_iact_0_0_south_data_out_ready;
wire 			       	CG_0_0_router_iact_0_0_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_south_data_out;
wire 			       	CG_0_0_router_iact_0_0_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_0_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_0_horiz_address_out;
wire 			       	CG_0_0_router_iact_0_0_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_0_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_0_horiz_data_out;
wire 			       	CG_0_0_router_iact_0_1_north_address_in_ready;
wire 			       	CG_0_0_router_iact_0_1_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_north_address_in;
wire 			       	CG_0_0_router_iact_0_1_north_data_in_ready;
wire 			       	CG_0_0_router_iact_0_1_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_north_data_in;
wire 			       	CG_0_0_router_iact_0_1_south_address_in_ready;
wire 			       	CG_0_0_router_iact_0_1_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_south_address_in;
wire 			       	CG_0_0_router_iact_0_1_south_data_in_ready;
wire 			       	CG_0_0_router_iact_0_1_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_south_data_in;
wire 			       	CG_0_0_router_iact_0_1_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_0_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_horiz_address_in;
wire 			       	CG_0_0_router_iact_0_1_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_0_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_horiz_data_in;
wire 			       	CG_0_0_router_iact_0_1_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_0_1_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_north_address_out;
wire 			       	CG_0_0_router_iact_0_1_north_data_out_ready;
wire 			       	CG_0_0_router_iact_0_1_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_north_data_out;
wire 			       	CG_0_0_router_iact_0_1_south_address_out_ready;
wire 			       	CG_0_0_router_iact_0_1_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_south_address_out;
wire 			       	CG_0_0_router_iact_0_1_south_data_out_ready;
wire 			       	CG_0_0_router_iact_0_1_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_south_data_out;
wire 			       	CG_0_0_router_iact_0_1_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_0_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_1_horiz_address_out;
wire 			       	CG_0_0_router_iact_0_1_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_0_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_1_horiz_data_out;
wire 			       	CG_0_0_router_iact_0_2_north_address_in_ready;
wire 			       	CG_0_0_router_iact_0_2_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_north_address_in;
wire 			       	CG_0_0_router_iact_0_2_north_data_in_ready;
wire 			       	CG_0_0_router_iact_0_2_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_north_data_in;
wire 			       	CG_0_0_router_iact_0_2_south_address_in_ready;
wire 			       	CG_0_0_router_iact_0_2_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_south_address_in;
wire 			       	CG_0_0_router_iact_0_2_south_data_in_ready;
wire 			       	CG_0_0_router_iact_0_2_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_south_data_in;
wire 			       	CG_0_0_router_iact_0_2_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_0_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_horiz_address_in;
wire 			       	CG_0_0_router_iact_0_2_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_0_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_horiz_data_in;
wire 			       	CG_0_0_router_iact_0_2_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_0_2_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_north_address_out;
wire 			       	CG_0_0_router_iact_0_2_north_data_out_ready;
wire 			       	CG_0_0_router_iact_0_2_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_north_data_out;
wire 			       	CG_0_0_router_iact_0_2_south_address_out_ready;
wire 			       	CG_0_0_router_iact_0_2_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_south_address_out;
wire 			       	CG_0_0_router_iact_0_2_south_data_out_ready;
wire 			       	CG_0_0_router_iact_0_2_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_south_data_out;
wire 			       	CG_0_0_router_iact_0_2_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_0_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_0_2_horiz_address_out;
wire 			       	CG_0_0_router_iact_0_2_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_0_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_0_2_horiz_data_out;
wire 			       	CG_0_0_router_iact_1_0_north_address_in_ready;
wire 			       	CG_0_0_router_iact_1_0_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_north_address_in;
wire 			       	CG_0_0_router_iact_1_0_north_data_in_ready;
wire 			       	CG_0_0_router_iact_1_0_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_north_data_in;
wire 			       	CG_0_0_router_iact_1_0_south_address_in_ready;
wire 			       	CG_0_0_router_iact_1_0_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_south_address_in;
wire 			       	CG_0_0_router_iact_1_0_south_data_in_ready;
wire 			       	CG_0_0_router_iact_1_0_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_south_data_in;
wire 			       	CG_0_0_router_iact_1_0_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_1_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_horiz_address_in;
wire 			       	CG_0_0_router_iact_1_0_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_1_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_horiz_data_in;
wire 			       	CG_0_0_router_iact_1_0_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_1_0_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_north_address_out;
wire 			       	CG_0_0_router_iact_1_0_north_data_out_ready;
wire 			       	CG_0_0_router_iact_1_0_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_north_data_out;
wire 			       	CG_0_0_router_iact_1_0_south_address_out_ready;
wire 			       	CG_0_0_router_iact_1_0_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_south_address_out;
wire 			       	CG_0_0_router_iact_1_0_south_data_out_ready;
wire 			       	CG_0_0_router_iact_1_0_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_south_data_out;
wire 			       	CG_0_0_router_iact_1_0_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_1_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_0_horiz_address_out;
wire 			       	CG_0_0_router_iact_1_0_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_1_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_0_horiz_data_out;
wire 			       	CG_0_0_router_iact_1_1_north_address_in_ready;
wire 			       	CG_0_0_router_iact_1_1_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_north_address_in;
wire 			       	CG_0_0_router_iact_1_1_north_data_in_ready;
wire 			       	CG_0_0_router_iact_1_1_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_north_data_in;
wire 			       	CG_0_0_router_iact_1_1_south_address_in_ready;
wire 			       	CG_0_0_router_iact_1_1_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_south_address_in;
wire 			       	CG_0_0_router_iact_1_1_south_data_in_ready;
wire 			       	CG_0_0_router_iact_1_1_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_south_data_in;
wire 			       	CG_0_0_router_iact_1_1_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_1_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_horiz_address_in;
wire 			       	CG_0_0_router_iact_1_1_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_1_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_horiz_data_in;
wire 			       	CG_0_0_router_iact_1_1_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_1_1_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_north_address_out;
wire 			       	CG_0_0_router_iact_1_1_north_data_out_ready;
wire 			       	CG_0_0_router_iact_1_1_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_north_data_out;
wire 			       	CG_0_0_router_iact_1_1_south_address_out_ready;
wire 			       	CG_0_0_router_iact_1_1_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_south_address_out;
wire 			       	CG_0_0_router_iact_1_1_south_data_out_ready;
wire 			       	CG_0_0_router_iact_1_1_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_south_data_out;
wire 			       	CG_0_0_router_iact_1_1_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_1_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_1_horiz_address_out;
wire 			       	CG_0_0_router_iact_1_1_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_1_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_1_horiz_data_out;  
wire 			       	CG_0_0_router_iact_1_2_north_address_in_ready;
wire 			       	CG_0_0_router_iact_1_2_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_north_address_in;
wire 			       	CG_0_0_router_iact_1_2_north_data_in_ready;
wire 			       	CG_0_0_router_iact_1_2_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_north_data_in;
wire 			       	CG_0_0_router_iact_1_2_south_address_in_ready;
wire 			       	CG_0_0_router_iact_1_2_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_south_address_in;
wire 			       	CG_0_0_router_iact_1_2_south_data_in_ready;
wire 			       	CG_0_0_router_iact_1_2_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_south_data_in;
wire 			       	CG_0_0_router_iact_1_2_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_1_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_horiz_address_in;
wire 			       	CG_0_0_router_iact_1_2_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_1_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_horiz_data_in;
wire 			       	CG_0_0_router_iact_1_2_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_1_2_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_north_address_out;
wire 			       	CG_0_0_router_iact_1_2_north_data_out_ready;
wire 			       	CG_0_0_router_iact_1_2_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_north_data_out;
wire 			       	CG_0_0_router_iact_1_2_south_address_out_ready;
wire 			       	CG_0_0_router_iact_1_2_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_south_address_out;
wire 			       	CG_0_0_router_iact_1_2_south_data_out_ready;
wire 			       	CG_0_0_router_iact_1_2_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_south_data_out;
wire 			       	CG_0_0_router_iact_1_2_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_1_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_1_2_horiz_address_out;
wire 			       	CG_0_0_router_iact_1_2_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_1_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_1_2_horiz_data_out;
wire 			       	CG_0_0_router_iact_2_0_north_address_in_ready;
wire 			       	CG_0_0_router_iact_2_0_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_north_address_in;
wire 			       	CG_0_0_router_iact_2_0_north_data_in_ready;
wire 			       	CG_0_0_router_iact_2_0_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_north_data_in;
wire 			       	CG_0_0_router_iact_2_0_south_address_in_ready;
wire 			       	CG_0_0_router_iact_2_0_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_south_address_in;
wire 			       	CG_0_0_router_iact_2_0_south_data_in_ready;
wire 			       	CG_0_0_router_iact_2_0_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_south_data_in;
wire 			       	CG_0_0_router_iact_2_0_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_2_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_horiz_address_in;
wire 			       	CG_0_0_router_iact_2_0_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_2_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_horiz_data_in;
wire 			       	CG_0_0_router_iact_2_0_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_2_0_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_north_address_out;
wire 			       	CG_0_0_router_iact_2_0_north_data_out_ready;
wire 			       	CG_0_0_router_iact_2_0_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_north_data_out;
wire 			       	CG_0_0_router_iact_2_0_south_address_out_ready;
wire 			       	CG_0_0_router_iact_2_0_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_south_address_out;
wire 			       	CG_0_0_router_iact_2_0_south_data_out_ready;
wire 			       	CG_0_0_router_iact_2_0_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_south_data_out;
wire 			       	CG_0_0_router_iact_2_0_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_2_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_0_horiz_address_out;
wire 			       	CG_0_0_router_iact_2_0_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_2_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_0_horiz_data_out;
wire 			       	CG_0_0_router_iact_2_1_north_address_in_ready;
wire 			       	CG_0_0_router_iact_2_1_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_north_address_in;
wire 			       	CG_0_0_router_iact_2_1_north_data_in_ready;
wire 			       	CG_0_0_router_iact_2_1_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_north_data_in;
wire 			       	CG_0_0_router_iact_2_1_south_address_in_ready;
wire 			       	CG_0_0_router_iact_2_1_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_south_address_in;
wire 			       	CG_0_0_router_iact_2_1_south_data_in_ready;
wire 			       	CG_0_0_router_iact_2_1_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_south_data_in;
wire 			       	CG_0_0_router_iact_2_1_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_2_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_horiz_address_in;
wire 			       	CG_0_0_router_iact_2_1_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_2_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_horiz_data_in;
wire 			       	CG_0_0_router_iact_2_1_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_2_1_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_north_address_out;
wire 			       	CG_0_0_router_iact_2_1_north_data_out_ready;
wire 			       	CG_0_0_router_iact_2_1_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_north_data_out;
wire 			       	CG_0_0_router_iact_2_1_south_address_out_ready;
wire 			       	CG_0_0_router_iact_2_1_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_south_address_out;
wire 			       	CG_0_0_router_iact_2_1_south_data_out_ready;
wire 			       	CG_0_0_router_iact_2_1_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_south_data_out;
wire 			       	CG_0_0_router_iact_2_1_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_2_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_1_horiz_address_out;
wire 			       	CG_0_0_router_iact_2_1_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_2_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_1_horiz_data_out;   
wire 			       	CG_0_0_router_iact_2_2_north_address_in_ready;
wire 			       	CG_0_0_router_iact_2_2_north_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_north_address_in;
wire 			       	CG_0_0_router_iact_2_2_north_data_in_ready;
wire 			       	CG_0_0_router_iact_2_2_north_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_north_data_in;
wire 			       	CG_0_0_router_iact_2_2_south_address_in_ready;
wire 			       	CG_0_0_router_iact_2_2_south_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_south_address_in;
wire 			       	CG_0_0_router_iact_2_2_south_data_in_ready;
wire 			       	CG_0_0_router_iact_2_2_south_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_south_data_in;
wire 			       	CG_0_0_router_iact_2_2_horiz_address_in_ready;
wire 			       	CG_0_0_router_iact_2_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_horiz_address_in;
wire 			       	CG_0_0_router_iact_2_2_horiz_data_in_ready;
wire 			       	CG_0_0_router_iact_2_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_horiz_data_in;
wire 			       	CG_0_0_router_iact_2_2_north_address_out_ready;	
wire 			       	CG_0_0_router_iact_2_2_north_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_north_address_out;
wire 			       	CG_0_0_router_iact_2_2_north_data_out_ready;
wire 			       	CG_0_0_router_iact_2_2_north_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_north_data_out;
wire 			       	CG_0_0_router_iact_2_2_south_address_out_ready;
wire 			       	CG_0_0_router_iact_2_2_south_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_south_address_out;
wire 			       	CG_0_0_router_iact_2_2_south_data_out_ready;
wire 			       	CG_0_0_router_iact_2_2_south_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_south_data_out;
wire 			       	CG_0_0_router_iact_2_2_horiz_address_out_ready;
wire 			       	CG_0_0_router_iact_2_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_0_router_iact_2_2_horiz_address_out;
wire 			       	CG_0_0_router_iact_2_2_horiz_data_out_ready;
wire 			       	CG_0_0_router_iact_2_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_0_router_iact_2_2_horiz_data_out;
			
wire 			       	CG_0_0_router_weight_0_horiz_address_in_ready;
wire 			       	CG_0_0_router_weight_0_horiz_address_in_valid;
wire 			[7:0]  	CG_0_0_router_weight_0_horiz_address_in;
wire 			       	CG_0_0_router_weight_0_horiz_data_in_ready;
wire 			       	CG_0_0_router_weight_0_horiz_data_in_valid;
wire 			[12:0] 	CG_0_0_router_weight_0_horiz_data_in;
wire 			       	CG_0_0_router_weight_0_horiz_address_out_ready;
wire 			       	CG_0_0_router_weight_0_horiz_address_out_valid;
wire 			[7:0]  	CG_0_0_router_weight_0_horiz_address_out;
wire 			       	CG_0_0_router_weight_0_horiz_data_out_ready;
wire 			       	CG_0_0_router_weight_0_horiz_data_out_valid;
wire 			[12:0] 	CG_0_0_router_weight_0_horiz_data_out;
wire 			       	CG_0_0_router_weight_1_horiz_address_in_ready;
wire 			       	CG_0_0_router_weight_1_horiz_address_in_valid;
wire 			[7:0]  	CG_0_0_router_weight_1_horiz_address_in;
wire 			       	CG_0_0_router_weight_1_horiz_data_in_ready;
wire 			       	CG_0_0_router_weight_1_horiz_data_in_valid;
wire 			[12:0] 	CG_0_0_router_weight_1_horiz_data_in;
wire 			       	CG_0_0_router_weight_1_horiz_address_out_ready;
wire 			       	CG_0_0_router_weight_1_horiz_address_out_valid;
wire 			[7:0]  	CG_0_0_router_weight_1_horiz_address_out;
wire 			       	CG_0_0_router_weight_1_horiz_data_out_ready;
wire 			       	CG_0_0_router_weight_1_horiz_data_out_valid;
wire 			[12:0] 	CG_0_0_router_weight_1_horiz_data_out;
wire 			       	CG_0_0_router_weight_2_horiz_address_in_ready;
wire 			       	CG_0_0_router_weight_2_horiz_address_in_valid;
wire 			[7:0]  	CG_0_0_router_weight_2_horiz_address_in;
wire 			       	CG_0_0_router_weight_2_horiz_data_in_ready;
wire 			       	CG_0_0_router_weight_2_horiz_data_in_valid;
wire 			[12:0] 	CG_0_0_router_weight_2_horiz_data_in;
wire 			       	CG_0_0_router_weight_2_horiz_address_out_ready;
wire 			       	CG_0_0_router_weight_2_horiz_address_out_valid;
wire 			[7:0]  	CG_0_0_router_weight_2_horiz_address_out;
wire        			CG_0_0_router_weight_2_horiz_data_out_ready;
wire        			CG_0_0_router_weight_2_horiz_data_out_valid;
wire 			[12:0] 	CG_0_0_router_weight_2_horiz_data_out;
		
wire        			CG_0_0_router_psum_0_north_in_ready;
wire        			CG_0_0_router_psum_0_north_in_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_0_north_in;
wire        			CG_0_0_router_psum_0_south_out_ready;
wire        			CG_0_0_router_psum_0_south_out_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_0_south_out;
wire        			CG_0_0_router_psum_1_north_in_ready;
wire        			CG_0_0_router_psum_1_north_in_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_1_north_in;
wire        			CG_0_0_router_psum_1_south_out_ready;
wire        			CG_0_0_router_psum_1_south_out_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_1_south_out;
wire        			CG_0_0_router_psum_2_north_in_ready;
wire        			CG_0_0_router_psum_2_north_in_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_2_north_in;
wire        			CG_0_0_router_psum_2_south_out_ready;
wire        			CG_0_0_router_psum_2_south_out_valid;
wire	signed	[20:0] 	CG_0_0_router_psum_2_south_out;
			
wire        			CG_0_0_cg_south_psum_0_in_ready;
wire        			CG_0_0_cg_south_psum_0_in_valid;
wire	signed	[20:0] 	CG_0_0_cg_south_psum_0_in;
wire        			CG_0_0_cg_south_psum_1_in_ready;
wire        			CG_0_0_cg_south_psum_1_in_valid;
wire	signed	[20:0] 	CG_0_0_cg_south_psum_1_in;
wire        			CG_0_0_cg_south_psum_2_in_ready;
wire        			CG_0_0_cg_south_psum_2_in_valid;
wire	signed	[20:0] 	CG_0_0_cg_south_psum_2_in;
wire        			CG_0_0_cg_north_psum_0_out_ready;
wire        			CG_0_0_cg_north_psum_0_out_valid;
wire	signed	[20:0] 	CG_0_0_cg_north_psum_0_out;
wire        			CG_0_0_cg_north_psum_1_out_ready;
wire        			CG_0_0_cg_north_psum_1_out_valid;
wire	signed	[20:0] 	CG_0_0_cg_north_psum_1_out;
wire        			CG_0_0_cg_north_psum_2_out_ready;
wire        			CG_0_0_cg_north_psum_2_out_valid;
wire	signed	[20:0] 	CG_0_0_cg_north_psum_2_out;
			


// --------------------- CG_0_1 --------------------- //
wire  		      		CG_0_1_clock = clock;
wire  		      		CG_0_1_reset = reset;

wire 			       	CG_0_1_router_iact_0_0_north_address_in_ready;
wire 			       	CG_0_1_router_iact_0_0_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_north_address_in;
wire 			       	CG_0_1_router_iact_0_0_north_data_in_ready;
wire 			       	CG_0_1_router_iact_0_0_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_north_data_in;
wire 			       	CG_0_1_router_iact_0_0_south_address_in_ready;
wire 			       	CG_0_1_router_iact_0_0_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_south_address_in;
wire 			       	CG_0_1_router_iact_0_0_south_data_in_ready;
wire 			       	CG_0_1_router_iact_0_0_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_south_data_in;
wire 			       	CG_0_1_router_iact_0_0_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_0_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_horiz_address_in;
wire 			       	CG_0_1_router_iact_0_0_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_0_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_horiz_data_in;
wire 			       	CG_0_1_router_iact_0_0_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_0_0_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_north_address_out;
wire 			       	CG_0_1_router_iact_0_0_north_data_out_ready;
wire 			       	CG_0_1_router_iact_0_0_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_north_data_out;
wire 			       	CG_0_1_router_iact_0_0_south_address_out_ready;
wire 			       	CG_0_1_router_iact_0_0_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_south_address_out;
wire 			       	CG_0_1_router_iact_0_0_south_data_out_ready;
wire 			       	CG_0_1_router_iact_0_0_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_south_data_out;
wire 			       	CG_0_1_router_iact_0_0_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_0_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_0_horiz_address_out;
wire 			       	CG_0_1_router_iact_0_0_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_0_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_0_horiz_data_out;
wire 			       	CG_0_1_router_iact_0_1_north_address_in_ready;
wire 			       	CG_0_1_router_iact_0_1_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_north_address_in;
wire 			       	CG_0_1_router_iact_0_1_north_data_in_ready;
wire 			       	CG_0_1_router_iact_0_1_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_north_data_in;
wire 			       	CG_0_1_router_iact_0_1_south_address_in_ready;
wire 			       	CG_0_1_router_iact_0_1_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_south_address_in;
wire 			       	CG_0_1_router_iact_0_1_south_data_in_ready;
wire 			       	CG_0_1_router_iact_0_1_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_south_data_in;
wire 			       	CG_0_1_router_iact_0_1_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_0_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_horiz_address_in;
wire 			       	CG_0_1_router_iact_0_1_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_0_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_horiz_data_in;
wire 			       	CG_0_1_router_iact_0_1_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_0_1_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_north_address_out;
wire 			       	CG_0_1_router_iact_0_1_north_data_out_ready;
wire 			       	CG_0_1_router_iact_0_1_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_north_data_out;
wire 			       	CG_0_1_router_iact_0_1_south_address_out_ready;
wire 			       	CG_0_1_router_iact_0_1_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_south_address_out;
wire 			       	CG_0_1_router_iact_0_1_south_data_out_ready;
wire 			       	CG_0_1_router_iact_0_1_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_south_data_out;
wire 			       	CG_0_1_router_iact_0_1_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_0_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_1_horiz_address_out;
wire 			       	CG_0_1_router_iact_0_1_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_0_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_1_horiz_data_out;
wire 			       	CG_0_1_router_iact_0_2_north_address_in_ready;
wire 			       	CG_0_1_router_iact_0_2_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_north_address_in;
wire 			       	CG_0_1_router_iact_0_2_north_data_in_ready;
wire 			       	CG_0_1_router_iact_0_2_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_north_data_in;
wire 			       	CG_0_1_router_iact_0_2_south_address_in_ready;
wire 			       	CG_0_1_router_iact_0_2_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_south_address_in;
wire 			       	CG_0_1_router_iact_0_2_south_data_in_ready;
wire 			       	CG_0_1_router_iact_0_2_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_south_data_in;
wire 			       	CG_0_1_router_iact_0_2_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_0_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_horiz_address_in;
wire 			       	CG_0_1_router_iact_0_2_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_0_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_horiz_data_in;
wire 			       	CG_0_1_router_iact_0_2_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_0_2_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_north_address_out;
wire 			       	CG_0_1_router_iact_0_2_north_data_out_ready;
wire 			       	CG_0_1_router_iact_0_2_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_north_data_out;
wire 			       	CG_0_1_router_iact_0_2_south_address_out_ready;
wire 			       	CG_0_1_router_iact_0_2_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_south_address_out;
wire 			       	CG_0_1_router_iact_0_2_south_data_out_ready;
wire 			       	CG_0_1_router_iact_0_2_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_south_data_out;
wire 			       	CG_0_1_router_iact_0_2_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_0_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_0_2_horiz_address_out;
wire 			       	CG_0_1_router_iact_0_2_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_0_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_0_2_horiz_data_out;
wire 			       	CG_0_1_router_iact_1_0_north_address_in_ready;
wire 			       	CG_0_1_router_iact_1_0_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_north_address_in;
wire 			       	CG_0_1_router_iact_1_0_north_data_in_ready;
wire 			       	CG_0_1_router_iact_1_0_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_north_data_in;
wire 			       	CG_0_1_router_iact_1_0_south_address_in_ready;
wire 			       	CG_0_1_router_iact_1_0_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_south_address_in;
wire 			       	CG_0_1_router_iact_1_0_south_data_in_ready;
wire 			       	CG_0_1_router_iact_1_0_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_south_data_in;
wire 			       	CG_0_1_router_iact_1_0_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_1_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_horiz_address_in;
wire 			       	CG_0_1_router_iact_1_0_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_1_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_horiz_data_in;
wire 			       	CG_0_1_router_iact_1_0_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_1_0_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_north_address_out;
wire 			       	CG_0_1_router_iact_1_0_north_data_out_ready;
wire 			       	CG_0_1_router_iact_1_0_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_north_data_out;
wire 			       	CG_0_1_router_iact_1_0_south_address_out_ready;
wire 			       	CG_0_1_router_iact_1_0_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_south_address_out;
wire 			       	CG_0_1_router_iact_1_0_south_data_out_ready;
wire 			       	CG_0_1_router_iact_1_0_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_south_data_out;
wire 			       	CG_0_1_router_iact_1_0_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_1_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_0_horiz_address_out;
wire 			       	CG_0_1_router_iact_1_0_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_1_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_0_horiz_data_out;
wire 			       	CG_0_1_router_iact_1_1_north_address_in_ready;
wire 			       	CG_0_1_router_iact_1_1_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_north_address_in;
wire 			       	CG_0_1_router_iact_1_1_north_data_in_ready;
wire 			       	CG_0_1_router_iact_1_1_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_north_data_in;
wire 			       	CG_0_1_router_iact_1_1_south_address_in_ready;
wire 			       	CG_0_1_router_iact_1_1_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_south_address_in;
wire 			       	CG_0_1_router_iact_1_1_south_data_in_ready;
wire 			       	CG_0_1_router_iact_1_1_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_south_data_in;
wire 			       	CG_0_1_router_iact_1_1_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_1_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_horiz_address_in;
wire 			       	CG_0_1_router_iact_1_1_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_1_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_horiz_data_in;
wire 			       	CG_0_1_router_iact_1_1_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_1_1_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_north_address_out;
wire 			       	CG_0_1_router_iact_1_1_north_data_out_ready;
wire 			       	CG_0_1_router_iact_1_1_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_north_data_out;
wire 			       	CG_0_1_router_iact_1_1_south_address_out_ready;
wire 			       	CG_0_1_router_iact_1_1_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_south_address_out;
wire 			       	CG_0_1_router_iact_1_1_south_data_out_ready;
wire 			       	CG_0_1_router_iact_1_1_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_south_data_out;
wire 			       	CG_0_1_router_iact_1_1_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_1_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_1_horiz_address_out;
wire 			       	CG_0_1_router_iact_1_1_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_1_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_1_horiz_data_out;  
wire 			       	CG_0_1_router_iact_1_2_north_address_in_ready;
wire 			       	CG_0_1_router_iact_1_2_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_north_address_in;
wire 			       	CG_0_1_router_iact_1_2_north_data_in_ready;
wire 			       	CG_0_1_router_iact_1_2_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_north_data_in;
wire 			       	CG_0_1_router_iact_1_2_south_address_in_ready;
wire 			       	CG_0_1_router_iact_1_2_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_south_address_in;
wire 			       	CG_0_1_router_iact_1_2_south_data_in_ready;
wire 			       	CG_0_1_router_iact_1_2_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_south_data_in;
wire 			       	CG_0_1_router_iact_1_2_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_1_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_horiz_address_in;
wire 			       	CG_0_1_router_iact_1_2_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_1_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_horiz_data_in;
wire 			       	CG_0_1_router_iact_1_2_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_1_2_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_north_address_out;
wire 			       	CG_0_1_router_iact_1_2_north_data_out_ready;
wire 			       	CG_0_1_router_iact_1_2_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_north_data_out;
wire 			       	CG_0_1_router_iact_1_2_south_address_out_ready;
wire 			       	CG_0_1_router_iact_1_2_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_south_address_out;
wire 			       	CG_0_1_router_iact_1_2_south_data_out_ready;
wire 			       	CG_0_1_router_iact_1_2_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_south_data_out;
wire 			       	CG_0_1_router_iact_1_2_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_1_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_1_2_horiz_address_out;
wire 			       	CG_0_1_router_iact_1_2_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_1_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_1_2_horiz_data_out;
wire 			       	CG_0_1_router_iact_2_0_north_address_in_ready;
wire 			       	CG_0_1_router_iact_2_0_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_north_address_in;
wire 			       	CG_0_1_router_iact_2_0_north_data_in_ready;
wire 			       	CG_0_1_router_iact_2_0_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_north_data_in;
wire 			       	CG_0_1_router_iact_2_0_south_address_in_ready;
wire 			       	CG_0_1_router_iact_2_0_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_south_address_in;
wire 			       	CG_0_1_router_iact_2_0_south_data_in_ready;
wire 			       	CG_0_1_router_iact_2_0_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_south_data_in;
wire 			       	CG_0_1_router_iact_2_0_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_2_0_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_horiz_address_in;
wire 			       	CG_0_1_router_iact_2_0_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_2_0_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_horiz_data_in;
wire 			       	CG_0_1_router_iact_2_0_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_2_0_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_north_address_out;
wire 			       	CG_0_1_router_iact_2_0_north_data_out_ready;
wire 			       	CG_0_1_router_iact_2_0_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_north_data_out;
wire 			       	CG_0_1_router_iact_2_0_south_address_out_ready;
wire 			       	CG_0_1_router_iact_2_0_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_south_address_out;
wire 			       	CG_0_1_router_iact_2_0_south_data_out_ready;
wire 			       	CG_0_1_router_iact_2_0_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_south_data_out;
wire 			       	CG_0_1_router_iact_2_0_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_2_0_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_0_horiz_address_out;
wire 			       	CG_0_1_router_iact_2_0_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_2_0_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_0_horiz_data_out;
wire 			       	CG_0_1_router_iact_2_1_north_address_in_ready;
wire 			       	CG_0_1_router_iact_2_1_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_north_address_in;
wire 			       	CG_0_1_router_iact_2_1_north_data_in_ready;
wire 			       	CG_0_1_router_iact_2_1_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_north_data_in;
wire 			       	CG_0_1_router_iact_2_1_south_address_in_ready;
wire 			       	CG_0_1_router_iact_2_1_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_south_address_in;
wire 			       	CG_0_1_router_iact_2_1_south_data_in_ready;
wire 			       	CG_0_1_router_iact_2_1_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_south_data_in;
wire 			       	CG_0_1_router_iact_2_1_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_2_1_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_horiz_address_in;
wire 			       	CG_0_1_router_iact_2_1_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_2_1_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_horiz_data_in;
wire 			       	CG_0_1_router_iact_2_1_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_2_1_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_north_address_out;
wire 			       	CG_0_1_router_iact_2_1_north_data_out_ready;
wire 			       	CG_0_1_router_iact_2_1_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_north_data_out;
wire 			       	CG_0_1_router_iact_2_1_south_address_out_ready;
wire 			       	CG_0_1_router_iact_2_1_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_south_address_out;
wire 			       	CG_0_1_router_iact_2_1_south_data_out_ready;
wire 			       	CG_0_1_router_iact_2_1_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_south_data_out;
wire 			       	CG_0_1_router_iact_2_1_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_2_1_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_1_horiz_address_out;
wire 			       	CG_0_1_router_iact_2_1_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_2_1_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_1_horiz_data_out;   
wire 			       	CG_0_1_router_iact_2_2_north_address_in_ready;
wire 			       	CG_0_1_router_iact_2_2_north_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_north_address_in;
wire 			       	CG_0_1_router_iact_2_2_north_data_in_ready;
wire 			       	CG_0_1_router_iact_2_2_north_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_north_data_in;
wire 			       	CG_0_1_router_iact_2_2_south_address_in_ready;
wire 			       	CG_0_1_router_iact_2_2_south_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_south_address_in;
wire 			       	CG_0_1_router_iact_2_2_south_data_in_ready;
wire 			       	CG_0_1_router_iact_2_2_south_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_south_data_in;
wire 			       	CG_0_1_router_iact_2_2_horiz_address_in_ready;
wire 			       	CG_0_1_router_iact_2_2_horiz_address_in_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_horiz_address_in;
wire 			       	CG_0_1_router_iact_2_2_horiz_data_in_ready;
wire 			       	CG_0_1_router_iact_2_2_horiz_data_in_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_horiz_data_in;
wire 			       	CG_0_1_router_iact_2_2_north_address_out_ready;	
wire 			       	CG_0_1_router_iact_2_2_north_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_north_address_out;
wire 			       	CG_0_1_router_iact_2_2_north_data_out_ready;
wire 			       	CG_0_1_router_iact_2_2_north_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_north_data_out;
wire 			       	CG_0_1_router_iact_2_2_south_address_out_ready;
wire 			       	CG_0_1_router_iact_2_2_south_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_south_address_out;
wire 			       	CG_0_1_router_iact_2_2_south_data_out_ready;
wire 			       	CG_0_1_router_iact_2_2_south_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_south_data_out;
wire 			       	CG_0_1_router_iact_2_2_horiz_address_out_ready;
wire 			       	CG_0_1_router_iact_2_2_horiz_address_out_valid;
wire 			[6:0]  	CG_0_1_router_iact_2_2_horiz_address_out;
wire 			       	CG_0_1_router_iact_2_2_horiz_data_out_ready;
wire 			       	CG_0_1_router_iact_2_2_horiz_data_out_valid;
wire 			[11:0] 	CG_0_1_router_iact_2_2_horiz_data_out;
			
wire 			       	CG_0_1_router_weight_0_horiz_address_in_ready;
wire 			       	CG_0_1_router_weight_0_horiz_address_in_valid;
wire 			[7:0]  	CG_0_1_router_weight_0_horiz_address_in;
wire 			       	CG_0_1_router_weight_0_horiz_data_in_ready;
wire 			       	CG_0_1_router_weight_0_horiz_data_in_valid;
wire 			[12:0] 	CG_0_1_router_weight_0_horiz_data_in;
wire 			       	CG_0_1_router_weight_0_horiz_address_out_ready;
wire 			       	CG_0_1_router_weight_0_horiz_address_out_valid;
wire 			[7:0]  	CG_0_1_router_weight_0_horiz_address_out;
wire 			       	CG_0_1_router_weight_0_horiz_data_out_ready;
wire 			       	CG_0_1_router_weight_0_horiz_data_out_valid;
wire 			[12:0] 	CG_0_1_router_weight_0_horiz_data_out;
wire 			       	CG_0_1_router_weight_1_horiz_address_in_ready;
wire 			       	CG_0_1_router_weight_1_horiz_address_in_valid;
wire 			[7:0]  	CG_0_1_router_weight_1_horiz_address_in;
wire 			       	CG_0_1_router_weight_1_horiz_data_in_ready;
wire 			       	CG_0_1_router_weight_1_horiz_data_in_valid;
wire 			[12:0] 	CG_0_1_router_weight_1_horiz_data_in;
wire 			       	CG_0_1_router_weight_1_horiz_address_out_ready;
wire 			       	CG_0_1_router_weight_1_horiz_address_out_valid;
wire 			[7:0]  	CG_0_1_router_weight_1_horiz_address_out;
wire 			       	CG_0_1_router_weight_1_horiz_data_out_ready;
wire 			       	CG_0_1_router_weight_1_horiz_data_out_valid;
wire 			[12:0] 	CG_0_1_router_weight_1_horiz_data_out;
wire 			       	CG_0_1_router_weight_2_horiz_address_in_ready;
wire 			       	CG_0_1_router_weight_2_horiz_address_in_valid;
wire 			[7:0]  	CG_0_1_router_weight_2_horiz_address_in;
wire 			       	CG_0_1_router_weight_2_horiz_data_in_ready;
wire 			       	CG_0_1_router_weight_2_horiz_data_in_valid;
wire 			[12:0] 	CG_0_1_router_weight_2_horiz_data_in;
wire 			       	CG_0_1_router_weight_2_horiz_address_out_ready;
wire 			       	CG_0_1_router_weight_2_horiz_address_out_valid;
wire 			[7:0]  	CG_0_1_router_weight_2_horiz_address_out;
wire        			CG_0_1_router_weight_2_horiz_data_out_ready;
wire        			CG_0_1_router_weight_2_horiz_data_out_valid;
wire 			[12:0] 	CG_0_1_router_weight_2_horiz_data_out;
		
wire        			CG_0_1_router_psum_0_north_in_ready;
wire        			CG_0_1_router_psum_0_north_in_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_0_north_in;
wire        			CG_0_1_router_psum_0_south_out_ready;
wire        			CG_0_1_router_psum_0_south_out_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_0_south_out;
wire        			CG_0_1_router_psum_1_north_in_ready;
wire        			CG_0_1_router_psum_1_north_in_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_1_north_in;
wire        			CG_0_1_router_psum_1_south_out_ready;
wire        			CG_0_1_router_psum_1_south_out_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_1_south_out;
wire        			CG_0_1_router_psum_2_north_in_ready;
wire        			CG_0_1_router_psum_2_north_in_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_2_north_in;
wire        			CG_0_1_router_psum_2_south_out_ready;
wire        			CG_0_1_router_psum_2_south_out_valid;
wire	signed	[20:0] 	CG_0_1_router_psum_2_south_out;
			
wire        			CG_0_1_cg_south_psum_0_in_ready;
wire        			CG_0_1_cg_south_psum_0_in_valid;
wire	signed	[20:0] 	CG_0_1_cg_south_psum_0_in;
wire        			CG_0_1_cg_south_psum_1_in_ready;
wire        			CG_0_1_cg_south_psum_1_in_valid;
wire	signed	[20:0] 	CG_0_1_cg_south_psum_1_in;
wire        			CG_0_1_cg_south_psum_2_in_ready;
wire        			CG_0_1_cg_south_psum_2_in_valid;
wire	signed	[20:0] 	CG_0_1_cg_south_psum_2_in;
wire        			CG_0_1_cg_north_psum_0_out_ready;
wire        			CG_0_1_cg_north_psum_0_out_valid;
wire	signed	[20:0] 	CG_0_1_cg_north_psum_0_out;
wire        			CG_0_1_cg_north_psum_1_out_ready;
wire        			CG_0_1_cg_north_psum_1_out_valid;
wire	signed	[20:0] 	CG_0_1_cg_north_psum_1_out;
wire        			CG_0_1_cg_north_psum_2_out_ready;
wire        			CG_0_1_cg_north_psum_2_out_valid;
wire	signed	[20:0] 	CG_0_1_cg_north_psum_2_out;
			

// --------------------- CG_1_0 --------------------- //
wire  		      		CG_1_0_clock = clock;
wire  		      		CG_1_0_reset = reset;

wire 			       	CG_1_0_router_iact_0_0_north_address_in_ready;
wire 			       	CG_1_0_router_iact_0_0_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_north_address_in;
wire 			       	CG_1_0_router_iact_0_0_north_data_in_ready;
wire 			       	CG_1_0_router_iact_0_0_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_north_data_in;
wire 			       	CG_1_0_router_iact_0_0_south_address_in_ready;
wire 			       	CG_1_0_router_iact_0_0_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_south_address_in;
wire 			       	CG_1_0_router_iact_0_0_south_data_in_ready;
wire 			       	CG_1_0_router_iact_0_0_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_south_data_in;
wire 			       	CG_1_0_router_iact_0_0_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_0_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_horiz_address_in;
wire 			       	CG_1_0_router_iact_0_0_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_0_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_horiz_data_in;
wire 			       	CG_1_0_router_iact_0_0_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_0_0_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_north_address_out;
wire 			       	CG_1_0_router_iact_0_0_north_data_out_ready;
wire 			       	CG_1_0_router_iact_0_0_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_north_data_out;
wire 			       	CG_1_0_router_iact_0_0_south_address_out_ready;
wire 			       	CG_1_0_router_iact_0_0_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_south_address_out;
wire 			       	CG_1_0_router_iact_0_0_south_data_out_ready;
wire 			       	CG_1_0_router_iact_0_0_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_south_data_out;
wire 			       	CG_1_0_router_iact_0_0_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_0_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_0_horiz_address_out;
wire 			       	CG_1_0_router_iact_0_0_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_0_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_0_horiz_data_out;
wire 			       	CG_1_0_router_iact_0_1_north_address_in_ready;
wire 			       	CG_1_0_router_iact_0_1_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_north_address_in;
wire 			       	CG_1_0_router_iact_0_1_north_data_in_ready;
wire 			       	CG_1_0_router_iact_0_1_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_north_data_in;
wire 			       	CG_1_0_router_iact_0_1_south_address_in_ready;
wire 			       	CG_1_0_router_iact_0_1_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_south_address_in;
wire 			       	CG_1_0_router_iact_0_1_south_data_in_ready;
wire 			       	CG_1_0_router_iact_0_1_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_south_data_in;
wire 			       	CG_1_0_router_iact_0_1_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_0_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_horiz_address_in;
wire 			       	CG_1_0_router_iact_0_1_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_0_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_horiz_data_in;
wire 			       	CG_1_0_router_iact_0_1_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_0_1_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_north_address_out;
wire 			       	CG_1_0_router_iact_0_1_north_data_out_ready;
wire 			       	CG_1_0_router_iact_0_1_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_north_data_out;
wire 			       	CG_1_0_router_iact_0_1_south_address_out_ready;
wire 			       	CG_1_0_router_iact_0_1_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_south_address_out;
wire 			       	CG_1_0_router_iact_0_1_south_data_out_ready;
wire 			       	CG_1_0_router_iact_0_1_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_south_data_out;
wire 			       	CG_1_0_router_iact_0_1_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_0_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_1_horiz_address_out;
wire 			       	CG_1_0_router_iact_0_1_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_0_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_1_horiz_data_out;
wire 			       	CG_1_0_router_iact_0_2_north_address_in_ready;
wire 			       	CG_1_0_router_iact_0_2_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_north_address_in;
wire 			       	CG_1_0_router_iact_0_2_north_data_in_ready;
wire 			       	CG_1_0_router_iact_0_2_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_north_data_in;
wire 			       	CG_1_0_router_iact_0_2_south_address_in_ready;
wire 			       	CG_1_0_router_iact_0_2_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_south_address_in;
wire 			       	CG_1_0_router_iact_0_2_south_data_in_ready;
wire 			       	CG_1_0_router_iact_0_2_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_south_data_in;
wire 			       	CG_1_0_router_iact_0_2_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_0_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_horiz_address_in;
wire 			       	CG_1_0_router_iact_0_2_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_0_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_horiz_data_in;
wire 			       	CG_1_0_router_iact_0_2_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_0_2_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_north_address_out;
wire 			       	CG_1_0_router_iact_0_2_north_data_out_ready;
wire 			       	CG_1_0_router_iact_0_2_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_north_data_out;
wire 			       	CG_1_0_router_iact_0_2_south_address_out_ready;
wire 			       	CG_1_0_router_iact_0_2_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_south_address_out;
wire 			       	CG_1_0_router_iact_0_2_south_data_out_ready;
wire 			       	CG_1_0_router_iact_0_2_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_south_data_out;
wire 			       	CG_1_0_router_iact_0_2_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_0_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_0_2_horiz_address_out;
wire 			       	CG_1_0_router_iact_0_2_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_0_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_0_2_horiz_data_out;
wire 			       	CG_1_0_router_iact_1_0_north_address_in_ready;
wire 			       	CG_1_0_router_iact_1_0_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_north_address_in;
wire 			       	CG_1_0_router_iact_1_0_north_data_in_ready;
wire 			       	CG_1_0_router_iact_1_0_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_north_data_in;
wire 			       	CG_1_0_router_iact_1_0_south_address_in_ready;
wire 			       	CG_1_0_router_iact_1_0_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_south_address_in;
wire 			       	CG_1_0_router_iact_1_0_south_data_in_ready;
wire 			       	CG_1_0_router_iact_1_0_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_south_data_in;
wire 			       	CG_1_0_router_iact_1_0_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_1_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_horiz_address_in;
wire 			       	CG_1_0_router_iact_1_0_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_1_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_horiz_data_in;
wire 			       	CG_1_0_router_iact_1_0_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_1_0_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_north_address_out;
wire 			       	CG_1_0_router_iact_1_0_north_data_out_ready;
wire 			       	CG_1_0_router_iact_1_0_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_north_data_out;
wire 			       	CG_1_0_router_iact_1_0_south_address_out_ready;
wire 			       	CG_1_0_router_iact_1_0_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_south_address_out;
wire 			       	CG_1_0_router_iact_1_0_south_data_out_ready;
wire 			       	CG_1_0_router_iact_1_0_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_south_data_out;
wire 			       	CG_1_0_router_iact_1_0_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_1_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_0_horiz_address_out;
wire 			       	CG_1_0_router_iact_1_0_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_1_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_0_horiz_data_out;
wire 			       	CG_1_0_router_iact_1_1_north_address_in_ready;
wire 			       	CG_1_0_router_iact_1_1_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_north_address_in;
wire 			       	CG_1_0_router_iact_1_1_north_data_in_ready;
wire 			       	CG_1_0_router_iact_1_1_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_north_data_in;
wire 			       	CG_1_0_router_iact_1_1_south_address_in_ready;
wire 			       	CG_1_0_router_iact_1_1_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_south_address_in;
wire 			       	CG_1_0_router_iact_1_1_south_data_in_ready;
wire 			       	CG_1_0_router_iact_1_1_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_south_data_in;
wire 			       	CG_1_0_router_iact_1_1_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_1_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_horiz_address_in;
wire 			       	CG_1_0_router_iact_1_1_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_1_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_horiz_data_in;
wire 			       	CG_1_0_router_iact_1_1_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_1_1_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_north_address_out;
wire 			       	CG_1_0_router_iact_1_1_north_data_out_ready;
wire 			       	CG_1_0_router_iact_1_1_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_north_data_out;
wire 			       	CG_1_0_router_iact_1_1_south_address_out_ready;
wire 			       	CG_1_0_router_iact_1_1_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_south_address_out;
wire 			       	CG_1_0_router_iact_1_1_south_data_out_ready;
wire 			       	CG_1_0_router_iact_1_1_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_south_data_out;
wire 			       	CG_1_0_router_iact_1_1_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_1_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_1_horiz_address_out;
wire 			       	CG_1_0_router_iact_1_1_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_1_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_1_horiz_data_out;  
wire 			       	CG_1_0_router_iact_1_2_north_address_in_ready;
wire 			       	CG_1_0_router_iact_1_2_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_north_address_in;
wire 			       	CG_1_0_router_iact_1_2_north_data_in_ready;
wire 			       	CG_1_0_router_iact_1_2_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_north_data_in;
wire 			       	CG_1_0_router_iact_1_2_south_address_in_ready;
wire 			       	CG_1_0_router_iact_1_2_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_south_address_in;
wire 			       	CG_1_0_router_iact_1_2_south_data_in_ready;
wire 			       	CG_1_0_router_iact_1_2_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_south_data_in;
wire 			       	CG_1_0_router_iact_1_2_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_1_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_horiz_address_in;
wire 			       	CG_1_0_router_iact_1_2_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_1_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_horiz_data_in;
wire 			       	CG_1_0_router_iact_1_2_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_1_2_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_north_address_out;
wire 			       	CG_1_0_router_iact_1_2_north_data_out_ready;
wire 			       	CG_1_0_router_iact_1_2_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_north_data_out;
wire 			       	CG_1_0_router_iact_1_2_south_address_out_ready;
wire 			       	CG_1_0_router_iact_1_2_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_south_address_out;
wire 			       	CG_1_0_router_iact_1_2_south_data_out_ready;
wire 			       	CG_1_0_router_iact_1_2_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_south_data_out;
wire 			       	CG_1_0_router_iact_1_2_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_1_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_1_2_horiz_address_out;
wire 			       	CG_1_0_router_iact_1_2_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_1_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_1_2_horiz_data_out;
wire 			       	CG_1_0_router_iact_2_0_north_address_in_ready;
wire 			       	CG_1_0_router_iact_2_0_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_north_address_in;
wire 			       	CG_1_0_router_iact_2_0_north_data_in_ready;
wire 			       	CG_1_0_router_iact_2_0_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_north_data_in;
wire 			       	CG_1_0_router_iact_2_0_south_address_in_ready;
wire 			       	CG_1_0_router_iact_2_0_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_south_address_in;
wire 			       	CG_1_0_router_iact_2_0_south_data_in_ready;
wire 			       	CG_1_0_router_iact_2_0_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_south_data_in;
wire 			       	CG_1_0_router_iact_2_0_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_2_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_horiz_address_in;
wire 			       	CG_1_0_router_iact_2_0_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_2_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_horiz_data_in;
wire 			       	CG_1_0_router_iact_2_0_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_2_0_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_north_address_out;
wire 			       	CG_1_0_router_iact_2_0_north_data_out_ready;
wire 			       	CG_1_0_router_iact_2_0_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_north_data_out;
wire 			       	CG_1_0_router_iact_2_0_south_address_out_ready;
wire 			       	CG_1_0_router_iact_2_0_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_south_address_out;
wire 			       	CG_1_0_router_iact_2_0_south_data_out_ready;
wire 			       	CG_1_0_router_iact_2_0_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_south_data_out;
wire 			       	CG_1_0_router_iact_2_0_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_2_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_0_horiz_address_out;
wire 			       	CG_1_0_router_iact_2_0_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_2_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_0_horiz_data_out;
wire 			       	CG_1_0_router_iact_2_1_north_address_in_ready;
wire 			       	CG_1_0_router_iact_2_1_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_north_address_in;
wire 			       	CG_1_0_router_iact_2_1_north_data_in_ready;
wire 			       	CG_1_0_router_iact_2_1_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_north_data_in;
wire 			       	CG_1_0_router_iact_2_1_south_address_in_ready;
wire 			       	CG_1_0_router_iact_2_1_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_south_address_in;
wire 			       	CG_1_0_router_iact_2_1_south_data_in_ready;
wire 			       	CG_1_0_router_iact_2_1_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_south_data_in;
wire 			       	CG_1_0_router_iact_2_1_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_2_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_horiz_address_in;
wire 			       	CG_1_0_router_iact_2_1_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_2_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_horiz_data_in;
wire 			       	CG_1_0_router_iact_2_1_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_2_1_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_north_address_out;
wire 			       	CG_1_0_router_iact_2_1_north_data_out_ready;
wire 			       	CG_1_0_router_iact_2_1_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_north_data_out;
wire 			       	CG_1_0_router_iact_2_1_south_address_out_ready;
wire 			       	CG_1_0_router_iact_2_1_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_south_address_out;
wire 			       	CG_1_0_router_iact_2_1_south_data_out_ready;
wire 			       	CG_1_0_router_iact_2_1_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_south_data_out;
wire 			       	CG_1_0_router_iact_2_1_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_2_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_1_horiz_address_out;
wire 			       	CG_1_0_router_iact_2_1_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_2_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_1_horiz_data_out;   
wire 			       	CG_1_0_router_iact_2_2_north_address_in_ready;
wire 			       	CG_1_0_router_iact_2_2_north_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_north_address_in;
wire 			       	CG_1_0_router_iact_2_2_north_data_in_ready;
wire 			       	CG_1_0_router_iact_2_2_north_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_north_data_in;
wire 			       	CG_1_0_router_iact_2_2_south_address_in_ready;
wire 			       	CG_1_0_router_iact_2_2_south_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_south_address_in;
wire 			       	CG_1_0_router_iact_2_2_south_data_in_ready;
wire 			       	CG_1_0_router_iact_2_2_south_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_south_data_in;
wire 			       	CG_1_0_router_iact_2_2_horiz_address_in_ready;
wire 			       	CG_1_0_router_iact_2_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_horiz_address_in;
wire 			       	CG_1_0_router_iact_2_2_horiz_data_in_ready;
wire 			       	CG_1_0_router_iact_2_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_horiz_data_in;
wire 			       	CG_1_0_router_iact_2_2_north_address_out_ready;	
wire 			       	CG_1_0_router_iact_2_2_north_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_north_address_out;
wire 			       	CG_1_0_router_iact_2_2_north_data_out_ready;
wire 			       	CG_1_0_router_iact_2_2_north_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_north_data_out;
wire 			       	CG_1_0_router_iact_2_2_south_address_out_ready;
wire 			       	CG_1_0_router_iact_2_2_south_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_south_address_out;
wire 			       	CG_1_0_router_iact_2_2_south_data_out_ready;
wire 			       	CG_1_0_router_iact_2_2_south_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_south_data_out;
wire 			       	CG_1_0_router_iact_2_2_horiz_address_out_ready;
wire 			       	CG_1_0_router_iact_2_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_0_router_iact_2_2_horiz_address_out;
wire 			       	CG_1_0_router_iact_2_2_horiz_data_out_ready;
wire 			       	CG_1_0_router_iact_2_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_0_router_iact_2_2_horiz_data_out;
			
wire 			       	CG_1_0_router_weight_0_horiz_address_in_ready;
wire 			       	CG_1_0_router_weight_0_horiz_address_in_valid;
wire 			[7:0]  	CG_1_0_router_weight_0_horiz_address_in;
wire 			       	CG_1_0_router_weight_0_horiz_data_in_ready;
wire 			       	CG_1_0_router_weight_0_horiz_data_in_valid;
wire 			[12:0] 	CG_1_0_router_weight_0_horiz_data_in;
wire 			       	CG_1_0_router_weight_0_horiz_address_out_ready;
wire 			       	CG_1_0_router_weight_0_horiz_address_out_valid;
wire 			[7:0]  	CG_1_0_router_weight_0_horiz_address_out;
wire 			       	CG_1_0_router_weight_0_horiz_data_out_ready;
wire 			       	CG_1_0_router_weight_0_horiz_data_out_valid;
wire 			[12:0] 	CG_1_0_router_weight_0_horiz_data_out;
wire 			       	CG_1_0_router_weight_1_horiz_address_in_ready;
wire 			       	CG_1_0_router_weight_1_horiz_address_in_valid;
wire 			[7:0]  	CG_1_0_router_weight_1_horiz_address_in;
wire 			       	CG_1_0_router_weight_1_horiz_data_in_ready;
wire 			       	CG_1_0_router_weight_1_horiz_data_in_valid;
wire 			[12:0] 	CG_1_0_router_weight_1_horiz_data_in;
wire 			       	CG_1_0_router_weight_1_horiz_address_out_ready;
wire 			       	CG_1_0_router_weight_1_horiz_address_out_valid;
wire 			[7:0]  	CG_1_0_router_weight_1_horiz_address_out;
wire 			       	CG_1_0_router_weight_1_horiz_data_out_ready;
wire 			       	CG_1_0_router_weight_1_horiz_data_out_valid;
wire 			[12:0] 	CG_1_0_router_weight_1_horiz_data_out;
wire 			       	CG_1_0_router_weight_2_horiz_address_in_ready;
wire 			       	CG_1_0_router_weight_2_horiz_address_in_valid;
wire 			[7:0]  	CG_1_0_router_weight_2_horiz_address_in;
wire 			       	CG_1_0_router_weight_2_horiz_data_in_ready;
wire 			       	CG_1_0_router_weight_2_horiz_data_in_valid;
wire 			[12:0] 	CG_1_0_router_weight_2_horiz_data_in;
wire 			       	CG_1_0_router_weight_2_horiz_address_out_ready;
wire 			       	CG_1_0_router_weight_2_horiz_address_out_valid;
wire 			[7:0]  	CG_1_0_router_weight_2_horiz_address_out;
wire        			CG_1_0_router_weight_2_horiz_data_out_ready;
wire        			CG_1_0_router_weight_2_horiz_data_out_valid;
wire 			[12:0] 	CG_1_0_router_weight_2_horiz_data_out;
		
wire        			CG_1_0_router_psum_0_north_in_ready;
wire        			CG_1_0_router_psum_0_north_in_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_0_north_in;
wire        			CG_1_0_router_psum_0_south_out_ready;
wire        			CG_1_0_router_psum_0_south_out_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_0_south_out;
wire        			CG_1_0_router_psum_1_north_in_ready;
wire        			CG_1_0_router_psum_1_north_in_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_1_north_in;
wire        			CG_1_0_router_psum_1_south_out_ready;
wire        			CG_1_0_router_psum_1_south_out_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_1_south_out;
wire        			CG_1_0_router_psum_2_north_in_ready;
wire        			CG_1_0_router_psum_2_north_in_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_2_north_in;
wire        			CG_1_0_router_psum_2_south_out_ready;
wire        			CG_1_0_router_psum_2_south_out_valid;
wire	signed	[20:0] 	CG_1_0_router_psum_2_south_out;
			
wire        			CG_1_0_cg_south_psum_0_in_ready;
wire        			CG_1_0_cg_south_psum_0_in_valid;
wire	signed	[20:0] 	CG_1_0_cg_south_psum_0_in;
wire        			CG_1_0_cg_south_psum_1_in_ready;
wire        			CG_1_0_cg_south_psum_1_in_valid;
wire	signed	[20:0] 	CG_1_0_cg_south_psum_1_in;
wire        			CG_1_0_cg_south_psum_2_in_ready;
wire        			CG_1_0_cg_south_psum_2_in_valid;
wire	signed	[20:0] 	CG_1_0_cg_south_psum_2_in;
wire        			CG_1_0_cg_north_psum_0_out_ready;
wire        			CG_1_0_cg_north_psum_0_out_valid;
wire	signed	[20:0] 	CG_1_0_cg_north_psum_0_out;
wire        			CG_1_0_cg_north_psum_1_out_ready;
wire        			CG_1_0_cg_north_psum_1_out_valid;
wire	signed	[20:0] 	CG_1_0_cg_north_psum_1_out;
wire        			CG_1_0_cg_north_psum_2_out_ready;
wire        			CG_1_0_cg_north_psum_2_out_valid;
wire	signed	[20:0] 	CG_1_0_cg_north_psum_2_out;
			
			
// --------------------- CG_1_1 --------------------- //
wire  		      		CG_1_1_clock = clock;
wire  		      		CG_1_1_reset = reset;

wire 			       	CG_1_1_router_iact_0_0_north_address_in_ready;
wire 			       	CG_1_1_router_iact_0_0_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_north_address_in;
wire 			       	CG_1_1_router_iact_0_0_north_data_in_ready;
wire 			       	CG_1_1_router_iact_0_0_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_north_data_in;
wire 			       	CG_1_1_router_iact_0_0_south_address_in_ready;
wire 			       	CG_1_1_router_iact_0_0_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_south_address_in;
wire 			       	CG_1_1_router_iact_0_0_south_data_in_ready;
wire 			       	CG_1_1_router_iact_0_0_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_south_data_in;
wire 			       	CG_1_1_router_iact_0_0_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_0_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_horiz_address_in;
wire 			       	CG_1_1_router_iact_0_0_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_0_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_horiz_data_in;
wire 			       	CG_1_1_router_iact_0_0_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_0_0_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_north_address_out;
wire 			       	CG_1_1_router_iact_0_0_north_data_out_ready;
wire 			       	CG_1_1_router_iact_0_0_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_north_data_out;
wire 			       	CG_1_1_router_iact_0_0_south_address_out_ready;
wire 			       	CG_1_1_router_iact_0_0_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_south_address_out;
wire 			       	CG_1_1_router_iact_0_0_south_data_out_ready;
wire 			       	CG_1_1_router_iact_0_0_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_south_data_out;
wire 			       	CG_1_1_router_iact_0_0_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_0_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_0_horiz_address_out;
wire 			       	CG_1_1_router_iact_0_0_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_0_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_0_horiz_data_out;
wire 			       	CG_1_1_router_iact_0_1_north_address_in_ready;
wire 			       	CG_1_1_router_iact_0_1_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_north_address_in;
wire 			       	CG_1_1_router_iact_0_1_north_data_in_ready;
wire 			       	CG_1_1_router_iact_0_1_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_north_data_in;
wire 			       	CG_1_1_router_iact_0_1_south_address_in_ready;
wire 			       	CG_1_1_router_iact_0_1_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_south_address_in;
wire 			       	CG_1_1_router_iact_0_1_south_data_in_ready;
wire 			       	CG_1_1_router_iact_0_1_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_south_data_in;
wire 			       	CG_1_1_router_iact_0_1_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_0_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_horiz_address_in;
wire 			       	CG_1_1_router_iact_0_1_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_0_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_horiz_data_in;
wire 			       	CG_1_1_router_iact_0_1_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_0_1_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_north_address_out;
wire 			       	CG_1_1_router_iact_0_1_north_data_out_ready;
wire 			       	CG_1_1_router_iact_0_1_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_north_data_out;
wire 			       	CG_1_1_router_iact_0_1_south_address_out_ready;
wire 			       	CG_1_1_router_iact_0_1_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_south_address_out;
wire 			       	CG_1_1_router_iact_0_1_south_data_out_ready;
wire 			       	CG_1_1_router_iact_0_1_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_south_data_out;
wire 			       	CG_1_1_router_iact_0_1_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_0_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_1_horiz_address_out;
wire 			       	CG_1_1_router_iact_0_1_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_0_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_1_horiz_data_out;
wire 			       	CG_1_1_router_iact_0_2_north_address_in_ready;
wire 			       	CG_1_1_router_iact_0_2_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_north_address_in;
wire 			       	CG_1_1_router_iact_0_2_north_data_in_ready;
wire 			       	CG_1_1_router_iact_0_2_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_north_data_in;
wire 			       	CG_1_1_router_iact_0_2_south_address_in_ready;
wire 			       	CG_1_1_router_iact_0_2_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_south_address_in;
wire 			       	CG_1_1_router_iact_0_2_south_data_in_ready;
wire 			       	CG_1_1_router_iact_0_2_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_south_data_in;
wire 			       	CG_1_1_router_iact_0_2_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_0_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_horiz_address_in;
wire 			       	CG_1_1_router_iact_0_2_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_0_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_horiz_data_in;
wire 			       	CG_1_1_router_iact_0_2_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_0_2_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_north_address_out;
wire 			       	CG_1_1_router_iact_0_2_north_data_out_ready;
wire 			       	CG_1_1_router_iact_0_2_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_north_data_out;
wire 			       	CG_1_1_router_iact_0_2_south_address_out_ready;
wire 			       	CG_1_1_router_iact_0_2_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_south_address_out;
wire 			       	CG_1_1_router_iact_0_2_south_data_out_ready;
wire 			       	CG_1_1_router_iact_0_2_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_south_data_out;
wire 			       	CG_1_1_router_iact_0_2_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_0_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_0_2_horiz_address_out;
wire 			       	CG_1_1_router_iact_0_2_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_0_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_0_2_horiz_data_out;
wire 			       	CG_1_1_router_iact_1_0_north_address_in_ready;
wire 			       	CG_1_1_router_iact_1_0_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_north_address_in;
wire 			       	CG_1_1_router_iact_1_0_north_data_in_ready;
wire 			       	CG_1_1_router_iact_1_0_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_north_data_in;
wire 			       	CG_1_1_router_iact_1_0_south_address_in_ready;
wire 			       	CG_1_1_router_iact_1_0_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_south_address_in;
wire 			       	CG_1_1_router_iact_1_0_south_data_in_ready;
wire 			       	CG_1_1_router_iact_1_0_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_south_data_in;
wire 			       	CG_1_1_router_iact_1_0_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_1_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_horiz_address_in;
wire 			       	CG_1_1_router_iact_1_0_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_1_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_horiz_data_in;
wire 			       	CG_1_1_router_iact_1_0_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_1_0_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_north_address_out;
wire 			       	CG_1_1_router_iact_1_0_north_data_out_ready;
wire 			       	CG_1_1_router_iact_1_0_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_north_data_out;
wire 			       	CG_1_1_router_iact_1_0_south_address_out_ready;
wire 			       	CG_1_1_router_iact_1_0_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_south_address_out;
wire 			       	CG_1_1_router_iact_1_0_south_data_out_ready;
wire 			       	CG_1_1_router_iact_1_0_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_south_data_out;
wire 			       	CG_1_1_router_iact_1_0_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_1_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_0_horiz_address_out;
wire 			       	CG_1_1_router_iact_1_0_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_1_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_0_horiz_data_out;
wire 			       	CG_1_1_router_iact_1_1_north_address_in_ready;
wire 			       	CG_1_1_router_iact_1_1_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_north_address_in;
wire 			       	CG_1_1_router_iact_1_1_north_data_in_ready;
wire 			       	CG_1_1_router_iact_1_1_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_north_data_in;
wire 			       	CG_1_1_router_iact_1_1_south_address_in_ready;
wire 			       	CG_1_1_router_iact_1_1_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_south_address_in;
wire 			       	CG_1_1_router_iact_1_1_south_data_in_ready;
wire 			       	CG_1_1_router_iact_1_1_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_south_data_in;
wire 			       	CG_1_1_router_iact_1_1_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_1_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_horiz_address_in;
wire 			       	CG_1_1_router_iact_1_1_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_1_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_horiz_data_in;
wire 			       	CG_1_1_router_iact_1_1_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_1_1_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_north_address_out;
wire 			       	CG_1_1_router_iact_1_1_north_data_out_ready;
wire 			       	CG_1_1_router_iact_1_1_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_north_data_out;
wire 			       	CG_1_1_router_iact_1_1_south_address_out_ready;
wire 			       	CG_1_1_router_iact_1_1_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_south_address_out;
wire 			       	CG_1_1_router_iact_1_1_south_data_out_ready;
wire 			       	CG_1_1_router_iact_1_1_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_south_data_out;
wire 			       	CG_1_1_router_iact_1_1_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_1_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_1_horiz_address_out;
wire 			       	CG_1_1_router_iact_1_1_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_1_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_1_horiz_data_out;  
wire 			       	CG_1_1_router_iact_1_2_north_address_in_ready;
wire 			       	CG_1_1_router_iact_1_2_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_north_address_in;
wire 			       	CG_1_1_router_iact_1_2_north_data_in_ready;
wire 			       	CG_1_1_router_iact_1_2_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_north_data_in;
wire 			       	CG_1_1_router_iact_1_2_south_address_in_ready;
wire 			       	CG_1_1_router_iact_1_2_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_south_address_in;
wire 			       	CG_1_1_router_iact_1_2_south_data_in_ready;
wire 			       	CG_1_1_router_iact_1_2_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_south_data_in;
wire 			       	CG_1_1_router_iact_1_2_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_1_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_horiz_address_in;
wire 			       	CG_1_1_router_iact_1_2_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_1_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_horiz_data_in;
wire 			       	CG_1_1_router_iact_1_2_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_1_2_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_north_address_out;
wire 			       	CG_1_1_router_iact_1_2_north_data_out_ready;
wire 			       	CG_1_1_router_iact_1_2_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_north_data_out;
wire 			       	CG_1_1_router_iact_1_2_south_address_out_ready;
wire 			       	CG_1_1_router_iact_1_2_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_south_address_out;
wire 			       	CG_1_1_router_iact_1_2_south_data_out_ready;
wire 			       	CG_1_1_router_iact_1_2_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_south_data_out;
wire 			       	CG_1_1_router_iact_1_2_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_1_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_1_2_horiz_address_out;
wire 			       	CG_1_1_router_iact_1_2_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_1_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_1_2_horiz_data_out;
wire 			       	CG_1_1_router_iact_2_0_north_address_in_ready;
wire 			       	CG_1_1_router_iact_2_0_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_north_address_in;
wire 			       	CG_1_1_router_iact_2_0_north_data_in_ready;
wire 			       	CG_1_1_router_iact_2_0_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_north_data_in;
wire 			       	CG_1_1_router_iact_2_0_south_address_in_ready;
wire 			       	CG_1_1_router_iact_2_0_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_south_address_in;
wire 			       	CG_1_1_router_iact_2_0_south_data_in_ready;
wire 			       	CG_1_1_router_iact_2_0_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_south_data_in;
wire 			       	CG_1_1_router_iact_2_0_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_2_0_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_horiz_address_in;
wire 			       	CG_1_1_router_iact_2_0_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_2_0_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_horiz_data_in;
wire 			       	CG_1_1_router_iact_2_0_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_2_0_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_north_address_out;
wire 			       	CG_1_1_router_iact_2_0_north_data_out_ready;
wire 			       	CG_1_1_router_iact_2_0_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_north_data_out;
wire 			       	CG_1_1_router_iact_2_0_south_address_out_ready;
wire 			       	CG_1_1_router_iact_2_0_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_south_address_out;
wire 			       	CG_1_1_router_iact_2_0_south_data_out_ready;
wire 			       	CG_1_1_router_iact_2_0_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_south_data_out;
wire 			       	CG_1_1_router_iact_2_0_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_2_0_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_0_horiz_address_out;
wire 			       	CG_1_1_router_iact_2_0_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_2_0_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_0_horiz_data_out;
wire 			       	CG_1_1_router_iact_2_1_north_address_in_ready;
wire 			       	CG_1_1_router_iact_2_1_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_north_address_in;
wire 			       	CG_1_1_router_iact_2_1_north_data_in_ready;
wire 			       	CG_1_1_router_iact_2_1_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_north_data_in;
wire 			       	CG_1_1_router_iact_2_1_south_address_in_ready;
wire 			       	CG_1_1_router_iact_2_1_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_south_address_in;
wire 			       	CG_1_1_router_iact_2_1_south_data_in_ready;
wire 			       	CG_1_1_router_iact_2_1_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_south_data_in;
wire 			       	CG_1_1_router_iact_2_1_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_2_1_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_horiz_address_in;
wire 			       	CG_1_1_router_iact_2_1_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_2_1_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_horiz_data_in;
wire 			       	CG_1_1_router_iact_2_1_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_2_1_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_north_address_out;
wire 			       	CG_1_1_router_iact_2_1_north_data_out_ready;
wire 			       	CG_1_1_router_iact_2_1_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_north_data_out;
wire 			       	CG_1_1_router_iact_2_1_south_address_out_ready;
wire 			       	CG_1_1_router_iact_2_1_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_south_address_out;
wire 			       	CG_1_1_router_iact_2_1_south_data_out_ready;
wire 			       	CG_1_1_router_iact_2_1_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_south_data_out;
wire 			       	CG_1_1_router_iact_2_1_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_2_1_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_1_horiz_address_out;
wire 			       	CG_1_1_router_iact_2_1_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_2_1_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_1_horiz_data_out;   
wire 			       	CG_1_1_router_iact_2_2_north_address_in_ready;
wire 			       	CG_1_1_router_iact_2_2_north_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_north_address_in;
wire 			       	CG_1_1_router_iact_2_2_north_data_in_ready;
wire 			       	CG_1_1_router_iact_2_2_north_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_north_data_in;
wire 			       	CG_1_1_router_iact_2_2_south_address_in_ready;
wire 			       	CG_1_1_router_iact_2_2_south_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_south_address_in;
wire 			       	CG_1_1_router_iact_2_2_south_data_in_ready;
wire 			       	CG_1_1_router_iact_2_2_south_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_south_data_in;
wire 			       	CG_1_1_router_iact_2_2_horiz_address_in_ready;
wire 			       	CG_1_1_router_iact_2_2_horiz_address_in_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_horiz_address_in;
wire 			       	CG_1_1_router_iact_2_2_horiz_data_in_ready;
wire 			       	CG_1_1_router_iact_2_2_horiz_data_in_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_horiz_data_in;
wire 			       	CG_1_1_router_iact_2_2_north_address_out_ready;	
wire 			       	CG_1_1_router_iact_2_2_north_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_north_address_out;
wire 			       	CG_1_1_router_iact_2_2_north_data_out_ready;
wire 			       	CG_1_1_router_iact_2_2_north_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_north_data_out;
wire 			       	CG_1_1_router_iact_2_2_south_address_out_ready;
wire 			       	CG_1_1_router_iact_2_2_south_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_south_address_out;
wire 			       	CG_1_1_router_iact_2_2_south_data_out_ready;
wire 			       	CG_1_1_router_iact_2_2_south_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_south_data_out;
wire 			       	CG_1_1_router_iact_2_2_horiz_address_out_ready;
wire 			       	CG_1_1_router_iact_2_2_horiz_address_out_valid;
wire 			[6:0]  	CG_1_1_router_iact_2_2_horiz_address_out;
wire 			       	CG_1_1_router_iact_2_2_horiz_data_out_ready;
wire 			       	CG_1_1_router_iact_2_2_horiz_data_out_valid;
wire 			[11:0] 	CG_1_1_router_iact_2_2_horiz_data_out;
			
wire 			       	CG_1_1_router_weight_0_horiz_address_in_ready;
wire 			       	CG_1_1_router_weight_0_horiz_address_in_valid;
wire 			[7:0]  	CG_1_1_router_weight_0_horiz_address_in;
wire 			       	CG_1_1_router_weight_0_horiz_data_in_ready;
wire 			       	CG_1_1_router_weight_0_horiz_data_in_valid;
wire 			[12:0] 	CG_1_1_router_weight_0_horiz_data_in;
wire 			       	CG_1_1_router_weight_0_horiz_address_out_ready;
wire 			       	CG_1_1_router_weight_0_horiz_address_out_valid;
wire 			[7:0]  	CG_1_1_router_weight_0_horiz_address_out;
wire 			       	CG_1_1_router_weight_0_horiz_data_out_ready;
wire 			       	CG_1_1_router_weight_0_horiz_data_out_valid;
wire 			[12:0] 	CG_1_1_router_weight_0_horiz_data_out;
wire 			       	CG_1_1_router_weight_1_horiz_address_in_ready;
wire 			       	CG_1_1_router_weight_1_horiz_address_in_valid;
wire 			[7:0]  	CG_1_1_router_weight_1_horiz_address_in;
wire 			       	CG_1_1_router_weight_1_horiz_data_in_ready;
wire 			       	CG_1_1_router_weight_1_horiz_data_in_valid;
wire 			[12:0] 	CG_1_1_router_weight_1_horiz_data_in;
wire 			       	CG_1_1_router_weight_1_horiz_address_out_ready;
wire 			       	CG_1_1_router_weight_1_horiz_address_out_valid;
wire 			[7:0]  	CG_1_1_router_weight_1_horiz_address_out;
wire 			       	CG_1_1_router_weight_1_horiz_data_out_ready;
wire 			       	CG_1_1_router_weight_1_horiz_data_out_valid;
wire 			[12:0] 	CG_1_1_router_weight_1_horiz_data_out;
wire 			       	CG_1_1_router_weight_2_horiz_address_in_ready;
wire 			       	CG_1_1_router_weight_2_horiz_address_in_valid;
wire 			[7:0]  	CG_1_1_router_weight_2_horiz_address_in;
wire 			       	CG_1_1_router_weight_2_horiz_data_in_ready;
wire 			       	CG_1_1_router_weight_2_horiz_data_in_valid;
wire 			[12:0] 	CG_1_1_router_weight_2_horiz_data_in;
wire 			       	CG_1_1_router_weight_2_horiz_address_out_ready;
wire 			       	CG_1_1_router_weight_2_horiz_address_out_valid;
wire 			[7:0]  	CG_1_1_router_weight_2_horiz_address_out;
wire        			CG_1_1_router_weight_2_horiz_data_out_ready;
wire        			CG_1_1_router_weight_2_horiz_data_out_valid;
wire 			[12:0] 	CG_1_1_router_weight_2_horiz_data_out;
		
wire        			CG_1_1_router_psum_0_north_in_ready;
wire        			CG_1_1_router_psum_0_north_in_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_0_north_in;
wire        			CG_1_1_router_psum_0_south_out_ready;
wire        			CG_1_1_router_psum_0_south_out_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_0_south_out;
wire        			CG_1_1_router_psum_1_north_in_ready;
wire        			CG_1_1_router_psum_1_north_in_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_1_north_in;
wire        			CG_1_1_router_psum_1_south_out_ready;
wire        			CG_1_1_router_psum_1_south_out_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_1_south_out;
wire        			CG_1_1_router_psum_2_north_in_ready;
wire        			CG_1_1_router_psum_2_north_in_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_2_north_in;
wire        			CG_1_1_router_psum_2_south_out_ready;
wire        			CG_1_1_router_psum_2_south_out_valid;
wire	signed	[20:0] 	CG_1_1_router_psum_2_south_out;
			
wire        			CG_1_1_cg_south_psum_0_in_ready;
wire        			CG_1_1_cg_south_psum_0_in_valid;
wire	signed	[20:0] 	CG_1_1_cg_south_psum_0_in;
wire        			CG_1_1_cg_south_psum_1_in_ready;
wire        			CG_1_1_cg_south_psum_1_in_valid;
wire	signed	[20:0] 	CG_1_1_cg_south_psum_1_in;
wire        			CG_1_1_cg_south_psum_2_in_ready;
wire        			CG_1_1_cg_south_psum_2_in_valid;
wire	signed	[20:0] 	CG_1_1_cg_south_psum_2_in;
wire        			CG_1_1_cg_north_psum_0_out_ready;
wire        			CG_1_1_cg_north_psum_0_out_valid;
wire	signed	[20:0] 	CG_1_1_cg_north_psum_0_out;
wire        			CG_1_1_cg_north_psum_1_out_ready;
wire        			CG_1_1_cg_north_psum_1_out_valid;
wire	signed	[20:0] 	CG_1_1_cg_north_psum_1_out;
wire        			CG_1_1_cg_north_psum_2_out_ready;
wire        			CG_1_1_cg_north_psum_2_out_valid;
wire	signed	[20:0] 	CG_1_1_cg_north_psum_2_out;
			

wire	CG_0_0_all_cal_fin;
wire	CG_0_1_all_cal_fin;
wire	CG_1_0_all_cal_fin;
wire	CG_1_1_all_cal_fin;
wire	gloabl_cal_fin = CG_0_0_all_cal_fin & CG_0_1_all_cal_fin & CG_1_0_all_cal_fin & CG_1_1_all_cal_fin;

assign 	CG_0_0_psum_acc_en 	= gloabl_cal_fin;
assign 	CG_0_1_psum_acc_en 	= gloabl_cal_fin;
assign 	CG_1_0_psum_acc_en 	= gloabl_cal_fin;
assign 	CG_1_1_psum_acc_en 	= gloabl_cal_fin;
assign	CG_0_0_psum_acc_fin	= psum_acc_fin;
assign	CG_0_1_psum_acc_fin	= psum_acc_fin;
assign	CG_1_0_psum_acc_fin	= psum_acc_fin;
assign	CG_1_1_psum_acc_fin	= psum_acc_fin;

ClusterGroup ClusterGroup_0_0 (
	.clock										(CG_0_0_clock									),
	.reset										(CG_0_0_reset									),
											   					
	.PE_cluster_iact_data_in_sel                (CG_0_0_PE_cluster_iact_data_in_sel             ),
	.PE_cluster_iact_data_out_sel               (CG_0_0_PE_cluster_iact_data_out_sel            ),
	.PE_cluster_psum_data_in_sel                (CG_0_0_PE_cluster_psum_data_in_sel             ),
									            			
	.router_cluster_iact_data_in_sel            (CG_0_0_router_cluster_iact_data_in_sel         ),
	.router_cluster_iact_data_out_sel           (CG_0_0_router_cluster_iact_data_out_sel        ),
	.router_cluster_weight_data_in_sel          (CG_0_0_router_cluster_weight_data_in_sel       ),
	.router_cluster_weight_data_out_sel         (CG_0_0_router_cluster_weight_data_out_sel      ),
	.router_cluster_psum_data_in_sel            (CG_0_0_router_cluster_psum_data_in_sel         ),
	.router_cluster_psum_data_out_sel           (CG_0_0_router_cluster_psum_data_out_sel        ),
							                    
	.read_psum_en                               (CG_0_0_read_psum_en                            ),
	.cal_fin                                    (CG_0_0_cal_fin                                 ),
	.cg_en                                      (CG_0_0_cg_en                                   ),
	.PE_weight_load_en                          (CG_0_0_PE_weight_load_en                       ),
	.GLB_iact_load_en                           (CG_0_0_GLB_iact_load_en                        ),
	.src_GLB_load_fin							(CG_0_0_src_GLB_load_fin						),
	.all_cal_fin								(CG_0_0_all_cal_fin								),
	.psum_acc_en								(CG_0_0_psum_acc_en								),
	.psum_acc_fin								(CG_0_0_psum_acc_fin							),
	.GLB_psum_write_en							(CG_0_0_GLB_psum_write_en						),
	.psum_SRAM_Bank_0_read_out_en				(CG_0_0_psum_SRAM_Bank_0_read_out_en			),
	.psum_SRAM_Bank_1_read_out_en				(CG_0_0_psum_SRAM_Bank_1_read_out_en			),
	.psum_SRAM_Bank_2_read_out_en				(CG_0_0_psum_SRAM_Bank_2_read_out_en			),
	
	.PE_0_0_disable								(CG_0_0_PE_0_0_disable							),
	.PE_0_1_disable								(CG_0_0_PE_0_1_disable							),
	.PE_0_2_disable								(CG_0_0_PE_0_2_disable							),
	.PE_1_0_disable								(CG_0_0_PE_1_0_disable							),
	.PE_1_1_disable								(CG_0_0_PE_1_1_disable							),
	.PE_1_2_disable								(CG_0_0_PE_1_2_disable							),
	.PE_2_0_disable								(CG_0_0_PE_2_0_disable							),
	.PE_2_1_disable								(CG_0_0_PE_2_1_disable							),
	.PE_2_2_disable								(CG_0_0_PE_2_2_disable							),
			                   
	.GLB_iact_0_0_read_addr                     (CG_0_0_GLB_iact_0_0_read_addr                  ),
	.GLB_iact_0_1_read_addr                     (CG_0_0_GLB_iact_0_1_read_addr                  ),
	.GLB_iact_0_2_read_addr                     (CG_0_0_GLB_iact_0_2_read_addr                  ),
	.GLB_iact_1_0_read_addr                     (CG_0_0_GLB_iact_1_0_read_addr                  ),
	.GLB_iact_1_1_read_addr                     (CG_0_0_GLB_iact_1_1_read_addr                  ),
	.GLB_iact_1_2_read_addr                     (CG_0_0_GLB_iact_1_2_read_addr                  ),
	.GLB_iact_2_0_read_addr                     (CG_0_0_GLB_iact_2_0_read_addr                  ),
	.GLB_iact_2_1_read_addr                     (CG_0_0_GLB_iact_2_1_read_addr                  ),
	.GLB_iact_2_2_read_addr                     (CG_0_0_GLB_iact_2_2_read_addr                  ),
							                    
	.GLB_psum_0_write_addr                      (CG_0_0_GLB_psum_0_write_addr                   ),
	.GLB_psum_1_write_addr                      (CG_0_0_GLB_psum_1_write_addr                   ),
	.GLB_psum_2_write_addr                      (CG_0_0_GLB_psum_2_write_addr                   ),
	.GLB_psum_0_read_addr                       (CG_0_0_GLB_psum_0_read_addr                    ),
	.GLB_psum_1_read_addr                       (CG_0_0_GLB_psum_1_read_addr                    ),
	.GLB_psum_2_read_addr                       (CG_0_0_GLB_psum_2_read_addr                    ),
								               
	.GLB_iact_0_0_address_in_ready              (CG_0_0_GLB_iact_0_0_address_in_ready           ),
	.GLB_iact_0_0_address_in_valid              (CG_0_0_GLB_iact_0_0_address_in_valid           ),
	.GLB_iact_0_0_address_in                    (CG_0_0_GLB_iact_0_0_address_in                 ),
	.GLB_iact_0_0_data_in_ready                 (CG_0_0_GLB_iact_0_0_data_in_ready              ),
	.GLB_iact_0_0_data_in_valid                 (CG_0_0_GLB_iact_0_0_data_in_valid              ),
	.GLB_iact_0_0_data_in                       (CG_0_0_GLB_iact_0_0_data_in                    ),
	.GLB_iact_0_1_address_in_ready              (CG_0_0_GLB_iact_0_1_address_in_ready           ),
	.GLB_iact_0_1_address_in_valid              (CG_0_0_GLB_iact_0_1_address_in_valid           ),
	.GLB_iact_0_1_address_in                    (CG_0_0_GLB_iact_0_1_address_in                 ),
	.GLB_iact_0_1_data_in_ready                 (CG_0_0_GLB_iact_0_1_data_in_ready              ),
	.GLB_iact_0_1_data_in_valid                 (CG_0_0_GLB_iact_0_1_data_in_valid              ),
	.GLB_iact_0_1_data_in                       (CG_0_0_GLB_iact_0_1_data_in                    ),
	.GLB_iact_0_2_address_in_ready              (CG_0_0_GLB_iact_0_2_address_in_ready           ),
	.GLB_iact_0_2_address_in_valid              (CG_0_0_GLB_iact_0_2_address_in_valid           ),
	.GLB_iact_0_2_address_in                    (CG_0_0_GLB_iact_0_2_address_in                 ),
	.GLB_iact_0_2_data_in_ready                 (CG_0_0_GLB_iact_0_2_data_in_ready              ),
	.GLB_iact_0_2_data_in_valid                 (CG_0_0_GLB_iact_0_2_data_in_valid              ),
	.GLB_iact_0_2_data_in                       (CG_0_0_GLB_iact_0_2_data_in                    ),
	.GLB_iact_1_0_address_in_ready              (CG_0_0_GLB_iact_1_0_address_in_ready           ),
	.GLB_iact_1_0_address_in_valid              (CG_0_0_GLB_iact_1_0_address_in_valid           ),
	.GLB_iact_1_0_address_in                    (CG_0_0_GLB_iact_1_0_address_in                 ),
	.GLB_iact_1_0_data_in_ready                 (CG_0_0_GLB_iact_1_0_data_in_ready              ),
	.GLB_iact_1_0_data_in_valid                 (CG_0_0_GLB_iact_1_0_data_in_valid              ),
	.GLB_iact_1_0_data_in                       (CG_0_0_GLB_iact_1_0_data_in                    ),
	.GLB_iact_1_1_address_in_ready              (CG_0_0_GLB_iact_1_1_address_in_ready           ),
	.GLB_iact_1_1_address_in_valid              (CG_0_0_GLB_iact_1_1_address_in_valid           ),
	.GLB_iact_1_1_address_in                    (CG_0_0_GLB_iact_1_1_address_in                 ),
	.GLB_iact_1_1_data_in_ready                 (CG_0_0_GLB_iact_1_1_data_in_ready              ),
	.GLB_iact_1_1_data_in_valid                 (CG_0_0_GLB_iact_1_1_data_in_valid              ),
	.GLB_iact_1_1_data_in                       (CG_0_0_GLB_iact_1_1_data_in                    ),
	.GLB_iact_1_2_address_in_ready              (CG_0_0_GLB_iact_1_2_address_in_ready           ),
	.GLB_iact_1_2_address_in_valid              (CG_0_0_GLB_iact_1_2_address_in_valid           ),
	.GLB_iact_1_2_address_in                    (CG_0_0_GLB_iact_1_2_address_in                 ),
	.GLB_iact_1_2_data_in_ready                 (CG_0_0_GLB_iact_1_2_data_in_ready              ),
	.GLB_iact_1_2_data_in_valid                 (CG_0_0_GLB_iact_1_2_data_in_valid              ),
	.GLB_iact_1_2_data_in                       (CG_0_0_GLB_iact_1_2_data_in                    ),
	.GLB_iact_2_0_address_in_ready              (CG_0_0_GLB_iact_2_0_address_in_ready           ),
	.GLB_iact_2_0_address_in_valid              (CG_0_0_GLB_iact_2_0_address_in_valid           ),
	.GLB_iact_2_0_address_in                    (CG_0_0_GLB_iact_2_0_address_in                 ),
	.GLB_iact_2_0_data_in_ready                 (CG_0_0_GLB_iact_2_0_data_in_ready              ),
	.GLB_iact_2_0_data_in_valid                 (CG_0_0_GLB_iact_2_0_data_in_valid              ),
	.GLB_iact_2_0_data_in                       (CG_0_0_GLB_iact_2_0_data_in                    ),
	.GLB_iact_2_1_address_in_ready              (CG_0_0_GLB_iact_2_1_address_in_ready           ),
	.GLB_iact_2_1_address_in_valid              (CG_0_0_GLB_iact_2_1_address_in_valid           ),
	.GLB_iact_2_1_address_in                    (CG_0_0_GLB_iact_2_1_address_in                 ),
	.GLB_iact_2_1_data_in_ready                 (CG_0_0_GLB_iact_2_1_data_in_ready              ),
	.GLB_iact_2_1_data_in_valid                 (CG_0_0_GLB_iact_2_1_data_in_valid              ),
	.GLB_iact_2_1_data_in                       (CG_0_0_GLB_iact_2_1_data_in                    ),
	.GLB_iact_2_2_address_in_ready              (CG_0_0_GLB_iact_2_2_address_in_ready           ),
	.GLB_iact_2_2_address_in_valid              (CG_0_0_GLB_iact_2_2_address_in_valid           ),
	.GLB_iact_2_2_address_in                    (CG_0_0_GLB_iact_2_2_address_in                 ),
	.GLB_iact_2_2_data_in_ready                 (CG_0_0_GLB_iact_2_2_data_in_ready              ),
	.GLB_iact_2_2_data_in_valid                 (CG_0_0_GLB_iact_2_2_data_in_valid              ),
	.GLB_iact_2_2_data_in                       (CG_0_0_GLB_iact_2_2_data_in                    ),
										    						
	.GLB_weight_0_address_in_ready              (CG_0_0_GLB_weight_0_address_in_ready           ),
	.GLB_weight_0_address_in_valid              (CG_0_0_GLB_weight_0_address_in_valid           ),
	.GLB_weight_0_address_in                    (CG_0_0_GLB_weight_0_address_in                 ),
	.GLB_weight_0_data_in_ready                 (CG_0_0_GLB_weight_0_data_in_ready              ),
	.GLB_weight_0_data_in_valid                 (CG_0_0_GLB_weight_0_data_in_valid              ),
	.GLB_weight_0_data_in                       (CG_0_0_GLB_weight_0_data_in                    ),
	.GLB_weight_1_address_in_ready              (CG_0_0_GLB_weight_1_address_in_ready           ),
	.GLB_weight_1_address_in_valid	            (CG_0_0_GLB_weight_1_address_in_valid	     	),
	.GLB_weight_1_address_in                    (CG_0_0_GLB_weight_1_address_in                 ),
	.GLB_weight_1_data_in_ready                 (CG_0_0_GLB_weight_1_data_in_ready              ),
	.GLB_weight_1_data_in_valid                 (CG_0_0_GLB_weight_1_data_in_valid              ),
	.GLB_weight_1_data_in                       (CG_0_0_GLB_weight_1_data_in                    ),
	.GLB_weight_2_address_in_ready              (CG_0_0_GLB_weight_2_address_in_ready           ),
	.GLB_weight_2_address_in_valid              (CG_0_0_GLB_weight_2_address_in_valid           ),
	.GLB_weight_2_address_in                    (CG_0_0_GLB_weight_2_address_in                 ),
	.GLB_weight_2_data_in_ready                 (CG_0_0_GLB_weight_2_data_in_ready              ),
	.GLB_weight_2_data_in_valid                 (CG_0_0_GLB_weight_2_data_in_valid              ),
	.GLB_weight_2_data_in                       (CG_0_0_GLB_weight_2_data_in                    ),
										     
	.GLB_psum_0_data_in_ready                   (CG_0_0_GLB_psum_0_data_in_ready                ),
	.GLB_psum_0_data_in_valid                   (CG_0_0_GLB_psum_0_data_in_valid                ),
	.GLB_psum_0_data_in                         (CG_0_0_GLB_psum_0_data_in                      ),
	.GLB_psum_0_data_out_ready                  (CG_0_0_GLB_psum_0_data_out_ready               ),
	.GLB_psum_0_data_out_valid                  (CG_0_0_GLB_psum_0_data_out_valid               ),
	.GLB_psum_0_data_out                        (CG_0_0_GLB_psum_0_data_out                     ),
	.GLB_psum_1_data_in_ready                   (CG_0_0_GLB_psum_1_data_in_ready                ),
	.GLB_psum_1_data_in_valid                   (CG_0_0_GLB_psum_1_data_in_valid                ),
	.GLB_psum_1_data_in                         (CG_0_0_GLB_psum_1_data_in                      ),
	.GLB_psum_1_data_out_ready                  (CG_0_0_GLB_psum_1_data_out_ready               ),
	.GLB_psum_1_data_out_valid                  (CG_0_0_GLB_psum_1_data_out_valid               ),
	.GLB_psum_1_data_out                        (CG_0_0_GLB_psum_1_data_out                     ),
	.GLB_psum_2_data_in_ready                   (CG_0_0_GLB_psum_2_data_in_ready                ),
	.GLB_psum_2_data_in_valid                   (CG_0_0_GLB_psum_2_data_in_valid                ),
	.GLB_psum_2_data_in                         (CG_0_0_GLB_psum_2_data_in                      ),
	.GLB_psum_2_data_out_ready                  (CG_0_0_GLB_psum_2_data_out_ready               ),
	.GLB_psum_2_data_out_valid                  (CG_0_0_GLB_psum_2_data_out_valid               ),
	.GLB_psum_2_data_out                        (CG_0_0_GLB_psum_2_data_out                     ),
											
	.router_iact_0_0_north_address_in_ready		(CG_0_0_router_iact_0_0_north_address_in_ready	),
	.router_iact_0_0_north_address_in_valid     (CG_0_0_router_iact_0_0_north_address_in_valid  ),
	.router_iact_0_0_north_address_in           (CG_0_0_router_iact_0_0_north_address_in        ),
	.router_iact_0_0_north_data_in_ready        (CG_0_0_router_iact_0_0_north_data_in_ready     ),
	.router_iact_0_0_north_data_in_valid        (CG_0_0_router_iact_0_0_north_data_in_valid     ),
	.router_iact_0_0_north_data_in              (CG_0_0_router_iact_0_0_north_data_in           ),
	.router_iact_0_0_south_address_in_ready     (CG_0_0_router_iact_0_0_south_address_in_ready  ),
	.router_iact_0_0_south_address_in_valid     (CG_0_0_router_iact_0_0_south_address_in_valid  ),
	.router_iact_0_0_south_address_in           (CG_0_0_router_iact_0_0_south_address_in        ),
	.router_iact_0_0_south_data_in_ready        (CG_0_0_router_iact_0_0_south_data_in_ready     ),
	.router_iact_0_0_south_data_in_valid        (CG_0_0_router_iact_0_0_south_data_in_valid     ),
	.router_iact_0_0_south_data_in              (CG_0_0_router_iact_0_0_south_data_in           ),
	.router_iact_0_0_horiz_address_in_ready     (CG_0_0_router_iact_0_0_horiz_address_in_ready  ),
	.router_iact_0_0_horiz_address_in_valid     (CG_0_0_router_iact_0_0_horiz_address_in_valid  ),
	.router_iact_0_0_horiz_address_in           (CG_0_0_router_iact_0_0_horiz_address_in        ),
	.router_iact_0_0_horiz_data_in_ready        (CG_0_0_router_iact_0_0_horiz_data_in_ready     ),
	.router_iact_0_0_horiz_data_in_valid        (CG_0_0_router_iact_0_0_horiz_data_in_valid     ),
	.router_iact_0_0_horiz_data_in              (CG_0_0_router_iact_0_0_horiz_data_in           ),
	.router_iact_0_0_north_address_out_ready	(CG_0_0_router_iact_0_0_north_address_out_ready	),
	.router_iact_0_0_north_address_out_valid    (CG_0_0_router_iact_0_0_north_address_out_valid ),
	.router_iact_0_0_north_address_out          (CG_0_0_router_iact_0_0_north_address_out       ),
	.router_iact_0_0_north_data_out_ready       (CG_0_0_router_iact_0_0_north_data_out_ready    ),
	.router_iact_0_0_north_data_out_valid       (CG_0_0_router_iact_0_0_north_data_out_valid    ),
	.router_iact_0_0_north_data_out             (CG_0_0_router_iact_0_0_north_data_out          ),
	.router_iact_0_0_south_address_out_ready    (CG_0_0_router_iact_0_0_south_address_out_ready ),
	.router_iact_0_0_south_address_out_valid    (CG_0_0_router_iact_0_0_south_address_out_valid ),
	.router_iact_0_0_south_address_out          (CG_0_0_router_iact_0_0_south_address_out       ),
	.router_iact_0_0_south_data_out_ready       (CG_0_0_router_iact_0_0_south_data_out_ready    ),
	.router_iact_0_0_south_data_out_valid       (CG_0_0_router_iact_0_0_south_data_out_valid    ),
	.router_iact_0_0_south_data_out             (CG_0_0_router_iact_0_0_south_data_out          ),
	.router_iact_0_0_horiz_address_out_ready    (CG_0_0_router_iact_0_0_horiz_address_out_ready ),
	.router_iact_0_0_horiz_address_out_valid    (CG_0_0_router_iact_0_0_horiz_address_out_valid ),
	.router_iact_0_0_horiz_address_out          (CG_0_0_router_iact_0_0_horiz_address_out       ),
	.router_iact_0_0_horiz_data_out_ready       (CG_0_0_router_iact_0_0_horiz_data_out_ready    ),
	.router_iact_0_0_horiz_data_out_valid       (CG_0_0_router_iact_0_0_horiz_data_out_valid    ),
	.router_iact_0_0_horiz_data_out             (CG_0_0_router_iact_0_0_horiz_data_out          ),
	.router_iact_0_1_north_address_in_ready     (CG_0_0_router_iact_0_1_north_address_in_ready  ),
	.router_iact_0_1_north_address_in_valid     (CG_0_0_router_iact_0_1_north_address_in_valid  ),
	.router_iact_0_1_north_address_in           (CG_0_0_router_iact_0_1_north_address_in        ),
	.router_iact_0_1_north_data_in_ready        (CG_0_0_router_iact_0_1_north_data_in_ready     ),
	.router_iact_0_1_north_data_in_valid        (CG_0_0_router_iact_0_1_north_data_in_valid     ),
	.router_iact_0_1_north_data_in              (CG_0_0_router_iact_0_1_north_data_in           ),
	.router_iact_0_1_south_address_in_ready     (CG_0_0_router_iact_0_1_south_address_in_ready  ),
	.router_iact_0_1_south_address_in_valid     (CG_0_0_router_iact_0_1_south_address_in_valid  ),
	.router_iact_0_1_south_address_in           (CG_0_0_router_iact_0_1_south_address_in        ),
	.router_iact_0_1_south_data_in_ready        (CG_0_0_router_iact_0_1_south_data_in_ready     ),
	.router_iact_0_1_south_data_in_valid        (CG_0_0_router_iact_0_1_south_data_in_valid     ),
	.router_iact_0_1_south_data_in              (CG_0_0_router_iact_0_1_south_data_in           ),
	.router_iact_0_1_horiz_address_in_ready     (CG_0_0_router_iact_0_1_horiz_address_in_ready  ),
	.router_iact_0_1_horiz_address_in_valid     (CG_0_0_router_iact_0_1_horiz_address_in_valid  ),
	.router_iact_0_1_horiz_address_in           (CG_0_0_router_iact_0_1_horiz_address_in        ),
	.router_iact_0_1_horiz_data_in_ready        (CG_0_0_router_iact_0_1_horiz_data_in_ready     ),
	.router_iact_0_1_horiz_data_in_valid        (CG_0_0_router_iact_0_1_horiz_data_in_valid     ),
	.router_iact_0_1_horiz_data_in              (CG_0_0_router_iact_0_1_horiz_data_in           ),
	.router_iact_0_1_north_address_out_ready	(CG_0_0_router_iact_0_1_north_address_out_ready	),
	.router_iact_0_1_north_address_out_valid    (CG_0_0_router_iact_0_1_north_address_out_valid ),
	.router_iact_0_1_north_address_out          (CG_0_0_router_iact_0_1_north_address_out       ),
	.router_iact_0_1_north_data_out_ready       (CG_0_0_router_iact_0_1_north_data_out_ready    ),
	.router_iact_0_1_north_data_out_valid       (CG_0_0_router_iact_0_1_north_data_out_valid    ),
	.router_iact_0_1_north_data_out             (CG_0_0_router_iact_0_1_north_data_out          ),
	.router_iact_0_1_south_address_out_ready    (CG_0_0_router_iact_0_1_south_address_out_ready ),
	.router_iact_0_1_south_address_out_valid    (CG_0_0_router_iact_0_1_south_address_out_valid ),
	.router_iact_0_1_south_address_out          (CG_0_0_router_iact_0_1_south_address_out       ),
	.router_iact_0_1_south_data_out_ready       (CG_0_0_router_iact_0_1_south_data_out_ready    ),
	.router_iact_0_1_south_data_out_valid       (CG_0_0_router_iact_0_1_south_data_out_valid    ),
	.router_iact_0_1_south_data_out             (CG_0_0_router_iact_0_1_south_data_out          ),
	.router_iact_0_1_horiz_address_out_ready    (CG_0_0_router_iact_0_1_horiz_address_out_ready ),
	.router_iact_0_1_horiz_address_out_valid    (CG_0_0_router_iact_0_1_horiz_address_out_valid ),
	.router_iact_0_1_horiz_address_out          (CG_0_0_router_iact_0_1_horiz_address_out       ),
	.router_iact_0_1_horiz_data_out_ready       (CG_0_0_router_iact_0_1_horiz_data_out_ready    ),
	.router_iact_0_1_horiz_data_out_valid       (CG_0_0_router_iact_0_1_horiz_data_out_valid    ),
	.router_iact_0_1_horiz_data_out             (CG_0_0_router_iact_0_1_horiz_data_out          ),
	.router_iact_0_2_north_address_in_ready     (CG_0_0_router_iact_0_2_north_address_in_ready  ),
	.router_iact_0_2_north_address_in_valid     (CG_0_0_router_iact_0_2_north_address_in_valid  ),
	.router_iact_0_2_north_address_in           (CG_0_0_router_iact_0_2_north_address_in        ),
	.router_iact_0_2_north_data_in_ready        (CG_0_0_router_iact_0_2_north_data_in_ready     ),
	.router_iact_0_2_north_data_in_valid        (CG_0_0_router_iact_0_2_north_data_in_valid     ),
	.router_iact_0_2_north_data_in              (CG_0_0_router_iact_0_2_north_data_in           ),
	.router_iact_0_2_south_address_in_ready     (CG_0_0_router_iact_0_2_south_address_in_ready  ),
	.router_iact_0_2_south_address_in_valid     (CG_0_0_router_iact_0_2_south_address_in_valid  ),
	.router_iact_0_2_south_address_in           (CG_0_0_router_iact_0_2_south_address_in        ),
	.router_iact_0_2_south_data_in_ready        (CG_0_0_router_iact_0_2_south_data_in_ready     ),
	.router_iact_0_2_south_data_in_valid        (CG_0_0_router_iact_0_2_south_data_in_valid     ),
	.router_iact_0_2_south_data_in              (CG_0_0_router_iact_0_2_south_data_in           ),
	.router_iact_0_2_horiz_address_in_ready     (CG_0_0_router_iact_0_2_horiz_address_in_ready  ),
	.router_iact_0_2_horiz_address_in_valid     (CG_0_0_router_iact_0_2_horiz_address_in_valid  ),
	.router_iact_0_2_horiz_address_in           (CG_0_0_router_iact_0_2_horiz_address_in        ),
	.router_iact_0_2_horiz_data_in_ready        (CG_0_0_router_iact_0_2_horiz_data_in_ready     ),
	.router_iact_0_2_horiz_data_in_valid        (CG_0_0_router_iact_0_2_horiz_data_in_valid     ),
	.router_iact_0_2_horiz_data_in              (CG_0_0_router_iact_0_2_horiz_data_in           ),
	.router_iact_0_2_north_address_out_ready	(CG_0_0_router_iact_0_2_north_address_out_ready	),
	.router_iact_0_2_north_address_out_valid    (CG_0_0_router_iact_0_2_north_address_out_valid ),
	.router_iact_0_2_north_address_out          (CG_0_0_router_iact_0_2_north_address_out       ),
	.router_iact_0_2_north_data_out_ready       (CG_0_0_router_iact_0_2_north_data_out_ready    ),
	.router_iact_0_2_north_data_out_valid       (CG_0_0_router_iact_0_2_north_data_out_valid    ),
	.router_iact_0_2_north_data_out             (CG_0_0_router_iact_0_2_north_data_out          ),
	.router_iact_0_2_south_address_out_ready    (CG_0_0_router_iact_0_2_south_address_out_ready ),
	.router_iact_0_2_south_address_out_valid    (CG_0_0_router_iact_0_2_south_address_out_valid ),
	.router_iact_0_2_south_address_out          (CG_0_0_router_iact_0_2_south_address_out       ),
	.router_iact_0_2_south_data_out_ready       (CG_0_0_router_iact_0_2_south_data_out_ready    ),
	.router_iact_0_2_south_data_out_valid       (CG_0_0_router_iact_0_2_south_data_out_valid    ),
	.router_iact_0_2_south_data_out             (CG_0_0_router_iact_0_2_south_data_out          ),
	.router_iact_0_2_horiz_address_out_ready    (CG_0_0_router_iact_0_2_horiz_address_out_ready ),
	.router_iact_0_2_horiz_address_out_valid    (CG_0_0_router_iact_0_2_horiz_address_out_valid ),
	.router_iact_0_2_horiz_address_out          (CG_0_0_router_iact_0_2_horiz_address_out       ),
	.router_iact_0_2_horiz_data_out_ready       (CG_0_0_router_iact_0_2_horiz_data_out_ready    ),
	.router_iact_0_2_horiz_data_out_valid       (CG_0_0_router_iact_0_2_horiz_data_out_valid    ),
	.router_iact_0_2_horiz_data_out             (CG_0_0_router_iact_0_2_horiz_data_out          ),
	.router_iact_1_0_north_address_in_ready     (CG_0_0_router_iact_1_0_north_address_in_ready  ),
	.router_iact_1_0_north_address_in_valid     (CG_0_0_router_iact_1_0_north_address_in_valid  ),
	.router_iact_1_0_north_address_in           (CG_0_0_router_iact_1_0_north_address_in        ),
	.router_iact_1_0_north_data_in_ready        (CG_0_0_router_iact_1_0_north_data_in_ready     ),
	.router_iact_1_0_north_data_in_valid        (CG_0_0_router_iact_1_0_north_data_in_valid     ),
	.router_iact_1_0_north_data_in              (CG_0_0_router_iact_1_0_north_data_in           ),
	.router_iact_1_0_south_address_in_ready     (CG_0_0_router_iact_1_0_south_address_in_ready  ),
	.router_iact_1_0_south_address_in_valid     (CG_0_0_router_iact_1_0_south_address_in_valid  ),
	.router_iact_1_0_south_address_in           (CG_0_0_router_iact_1_0_south_address_in        ),
	.router_iact_1_0_south_data_in_ready        (CG_0_0_router_iact_1_0_south_data_in_ready     ),
	.router_iact_1_0_south_data_in_valid        (CG_0_0_router_iact_1_0_south_data_in_valid     ),
	.router_iact_1_0_south_data_in              (CG_0_0_router_iact_1_0_south_data_in           ),
	.router_iact_1_0_horiz_address_in_ready     (CG_0_0_router_iact_1_0_horiz_address_in_ready  ),
	.router_iact_1_0_horiz_address_in_valid     (CG_0_0_router_iact_1_0_horiz_address_in_valid  ),
	.router_iact_1_0_horiz_address_in           (CG_0_0_router_iact_1_0_horiz_address_in        ),
	.router_iact_1_0_horiz_data_in_ready        (CG_0_0_router_iact_1_0_horiz_data_in_ready     ),
	.router_iact_1_0_horiz_data_in_valid        (CG_0_0_router_iact_1_0_horiz_data_in_valid     ),
	.router_iact_1_0_horiz_data_in              (CG_0_0_router_iact_1_0_horiz_data_in           ),
	.router_iact_1_0_north_address_out_ready	(CG_0_0_router_iact_1_0_north_address_out_ready	),
	.router_iact_1_0_north_address_out_valid    (CG_0_0_router_iact_1_0_north_address_out_valid ),
	.router_iact_1_0_north_address_out          (CG_0_0_router_iact_1_0_north_address_out       ),
	.router_iact_1_0_north_data_out_ready       (CG_0_0_router_iact_1_0_north_data_out_ready    ),
	.router_iact_1_0_north_data_out_valid       (CG_0_0_router_iact_1_0_north_data_out_valid    ),
	.router_iact_1_0_north_data_out             (CG_0_0_router_iact_1_0_north_data_out          ),
	.router_iact_1_0_south_address_out_ready    (CG_0_0_router_iact_1_0_south_address_out_ready ),
	.router_iact_1_0_south_address_out_valid    (CG_0_0_router_iact_1_0_south_address_out_valid ),
	.router_iact_1_0_south_address_out          (CG_0_0_router_iact_1_0_south_address_out       ),
	.router_iact_1_0_south_data_out_ready       (CG_0_0_router_iact_1_0_south_data_out_ready    ),
	.router_iact_1_0_south_data_out_valid       (CG_0_0_router_iact_1_0_south_data_out_valid    ),
	.router_iact_1_0_south_data_out             (CG_0_0_router_iact_1_0_south_data_out          ),
	.router_iact_1_0_horiz_address_out_ready    (CG_0_0_router_iact_1_0_horiz_address_out_ready ),
	.router_iact_1_0_horiz_address_out_valid    (CG_0_0_router_iact_1_0_horiz_address_out_valid ),
	.router_iact_1_0_horiz_address_out          (CG_0_0_router_iact_1_0_horiz_address_out       ),
	.router_iact_1_0_horiz_data_out_ready       (CG_0_0_router_iact_1_0_horiz_data_out_ready    ),
	.router_iact_1_0_horiz_data_out_valid       (CG_0_0_router_iact_1_0_horiz_data_out_valid    ),
	.router_iact_1_0_horiz_data_out             (CG_0_0_router_iact_1_0_horiz_data_out          ),
	.router_iact_1_1_north_address_in_ready     (CG_0_0_router_iact_1_1_north_address_in_ready  ),
	.router_iact_1_1_north_address_in_valid     (CG_0_0_router_iact_1_1_north_address_in_valid  ),
	.router_iact_1_1_north_address_in           (CG_0_0_router_iact_1_1_north_address_in        ),
	.router_iact_1_1_north_data_in_ready        (CG_0_0_router_iact_1_1_north_data_in_ready     ),
	.router_iact_1_1_north_data_in_valid        (CG_0_0_router_iact_1_1_north_data_in_valid     ),
	.router_iact_1_1_north_data_in              (CG_0_0_router_iact_1_1_north_data_in           ),
	.router_iact_1_1_south_address_in_ready     (CG_0_0_router_iact_1_1_south_address_in_ready  ),
	.router_iact_1_1_south_address_in_valid     (CG_0_0_router_iact_1_1_south_address_in_valid  ),
	.router_iact_1_1_south_address_in           (CG_0_0_router_iact_1_1_south_address_in        ),
	.router_iact_1_1_south_data_in_ready        (CG_0_0_router_iact_1_1_south_data_in_ready     ),
	.router_iact_1_1_south_data_in_valid        (CG_0_0_router_iact_1_1_south_data_in_valid     ),
	.router_iact_1_1_south_data_in              (CG_0_0_router_iact_1_1_south_data_in           ),
	.router_iact_1_1_horiz_address_in_ready     (CG_0_0_router_iact_1_1_horiz_address_in_ready  ),
	.router_iact_1_1_horiz_address_in_valid     (CG_0_0_router_iact_1_1_horiz_address_in_valid  ),
	.router_iact_1_1_horiz_address_in           (CG_0_0_router_iact_1_1_horiz_address_in        ),
	.router_iact_1_1_horiz_data_in_ready        (CG_0_0_router_iact_1_1_horiz_data_in_ready     ),
	.router_iact_1_1_horiz_data_in_valid        (CG_0_0_router_iact_1_1_horiz_data_in_valid     ),
	.router_iact_1_1_horiz_data_in              (CG_0_0_router_iact_1_1_horiz_data_in           ),
	.router_iact_1_1_north_address_out_ready	(CG_0_0_router_iact_1_1_north_address_out_ready	),
	.router_iact_1_1_north_address_out_valid    (CG_0_0_router_iact_1_1_north_address_out_valid ),
	.router_iact_1_1_north_address_out          (CG_0_0_router_iact_1_1_north_address_out       ),
	.router_iact_1_1_north_data_out_ready       (CG_0_0_router_iact_1_1_north_data_out_ready    ),
	.router_iact_1_1_north_data_out_valid       (CG_0_0_router_iact_1_1_north_data_out_valid    ),
	.router_iact_1_1_north_data_out             (CG_0_0_router_iact_1_1_north_data_out          ),
	.router_iact_1_1_south_address_out_ready    (CG_0_0_router_iact_1_1_south_address_out_ready ),
	.router_iact_1_1_south_address_out_valid    (CG_0_0_router_iact_1_1_south_address_out_valid ),
	.router_iact_1_1_south_address_out          (CG_0_0_router_iact_1_1_south_address_out       ),
	.router_iact_1_1_south_data_out_ready       (CG_0_0_router_iact_1_1_south_data_out_ready    ),
	.router_iact_1_1_south_data_out_valid       (CG_0_0_router_iact_1_1_south_data_out_valid    ),
	.router_iact_1_1_south_data_out             (CG_0_0_router_iact_1_1_south_data_out          ),
	.router_iact_1_1_horiz_address_out_ready    (CG_0_0_router_iact_1_1_horiz_address_out_ready ),
	.router_iact_1_1_horiz_address_out_valid    (CG_0_0_router_iact_1_1_horiz_address_out_valid ),
	.router_iact_1_1_horiz_address_out          (CG_0_0_router_iact_1_1_horiz_address_out       ),
	.router_iact_1_1_horiz_data_out_ready       (CG_0_0_router_iact_1_1_horiz_data_out_ready    ),
	.router_iact_1_1_horiz_data_out_valid       (CG_0_0_router_iact_1_1_horiz_data_out_valid    ),
	.router_iact_1_1_horiz_data_out             (CG_0_0_router_iact_1_1_horiz_data_out          ),
	.router_iact_1_2_north_address_in_ready     (CG_0_0_router_iact_1_2_north_address_in_ready  ),
	.router_iact_1_2_north_address_in_valid     (CG_0_0_router_iact_1_2_north_address_in_valid  ),
	.router_iact_1_2_north_address_in           (CG_0_0_router_iact_1_2_north_address_in        ),
	.router_iact_1_2_north_data_in_ready        (CG_0_0_router_iact_1_2_north_data_in_ready     ),
	.router_iact_1_2_north_data_in_valid        (CG_0_0_router_iact_1_2_north_data_in_valid     ),
	.router_iact_1_2_north_data_in              (CG_0_0_router_iact_1_2_north_data_in           ),
	.router_iact_1_2_south_address_in_ready     (CG_0_0_router_iact_1_2_south_address_in_ready  ),
	.router_iact_1_2_south_address_in_valid     (CG_0_0_router_iact_1_2_south_address_in_valid  ),
	.router_iact_1_2_south_address_in           (CG_0_0_router_iact_1_2_south_address_in        ),
	.router_iact_1_2_south_data_in_ready        (CG_0_0_router_iact_1_2_south_data_in_ready     ),
	.router_iact_1_2_south_data_in_valid        (CG_0_0_router_iact_1_2_south_data_in_valid     ),
	.router_iact_1_2_south_data_in              (CG_0_0_router_iact_1_2_south_data_in           ),
	.router_iact_1_2_horiz_address_in_ready     (CG_0_0_router_iact_1_2_horiz_address_in_ready  ),
	.router_iact_1_2_horiz_address_in_valid     (CG_0_0_router_iact_1_2_horiz_address_in_valid  ),
	.router_iact_1_2_horiz_address_in           (CG_0_0_router_iact_1_2_horiz_address_in        ),
	.router_iact_1_2_horiz_data_in_ready        (CG_0_0_router_iact_1_2_horiz_data_in_ready     ),
	.router_iact_1_2_horiz_data_in_valid        (CG_0_0_router_iact_1_2_horiz_data_in_valid     ),
	.router_iact_1_2_horiz_data_in              (CG_0_0_router_iact_1_2_horiz_data_in           ),
	.router_iact_1_2_north_address_out_ready	(CG_0_0_router_iact_1_2_north_address_out_ready	),
	.router_iact_1_2_north_address_out_valid    (CG_0_0_router_iact_1_2_north_address_out_valid ),
	.router_iact_1_2_north_address_out          (CG_0_0_router_iact_1_2_north_address_out       ),
	.router_iact_1_2_north_data_out_ready       (CG_0_0_router_iact_1_2_north_data_out_ready    ),
	.router_iact_1_2_north_data_out_valid       (CG_0_0_router_iact_1_2_north_data_out_valid    ),
	.router_iact_1_2_north_data_out             (CG_0_0_router_iact_1_2_north_data_out          ),
	.router_iact_1_2_south_address_out_ready    (CG_0_0_router_iact_1_2_south_address_out_ready ),
	.router_iact_1_2_south_address_out_valid    (CG_0_0_router_iact_1_2_south_address_out_valid ),
	.router_iact_1_2_south_address_out          (CG_0_0_router_iact_1_2_south_address_out       ),
	.router_iact_1_2_south_data_out_ready       (CG_0_0_router_iact_1_2_south_data_out_ready    ),
	.router_iact_1_2_south_data_out_valid       (CG_0_0_router_iact_1_2_south_data_out_valid    ),
	.router_iact_1_2_south_data_out             (CG_0_0_router_iact_1_2_south_data_out          ),
	.router_iact_1_2_horiz_address_out_ready    (CG_0_0_router_iact_1_2_horiz_address_out_ready ),
	.router_iact_1_2_horiz_address_out_valid    (CG_0_0_router_iact_1_2_horiz_address_out_valid ),
	.router_iact_1_2_horiz_address_out          (CG_0_0_router_iact_1_2_horiz_address_out       ),
	.router_iact_1_2_horiz_data_out_ready       (CG_0_0_router_iact_1_2_horiz_data_out_ready    ),
	.router_iact_1_2_horiz_data_out_valid       (CG_0_0_router_iact_1_2_horiz_data_out_valid    ),
	.router_iact_1_2_horiz_data_out             (CG_0_0_router_iact_1_2_horiz_data_out          ),
	.router_iact_2_0_north_address_in_ready     (CG_0_0_router_iact_2_0_north_address_in_ready  ),
	.router_iact_2_0_north_address_in_valid     (CG_0_0_router_iact_2_0_north_address_in_valid  ),
	.router_iact_2_0_north_address_in           (CG_0_0_router_iact_2_0_north_address_in        ),
	.router_iact_2_0_north_data_in_ready        (CG_0_0_router_iact_2_0_north_data_in_ready     ),
	.router_iact_2_0_north_data_in_valid        (CG_0_0_router_iact_2_0_north_data_in_valid     ),
	.router_iact_2_0_north_data_in              (CG_0_0_router_iact_2_0_north_data_in           ),
	.router_iact_2_0_south_address_in_ready     (CG_0_0_router_iact_2_0_south_address_in_ready  ),
	.router_iact_2_0_south_address_in_valid     (CG_0_0_router_iact_2_0_south_address_in_valid  ),
	.router_iact_2_0_south_address_in           (CG_0_0_router_iact_2_0_south_address_in        ),
	.router_iact_2_0_south_data_in_ready        (CG_0_0_router_iact_2_0_south_data_in_ready     ),
	.router_iact_2_0_south_data_in_valid        (CG_0_0_router_iact_2_0_south_data_in_valid     ),
	.router_iact_2_0_south_data_in              (CG_0_0_router_iact_2_0_south_data_in           ),
	.router_iact_2_0_horiz_address_in_ready     (CG_0_0_router_iact_2_0_horiz_address_in_ready  ),
	.router_iact_2_0_horiz_address_in_valid     (CG_0_0_router_iact_2_0_horiz_address_in_valid  ),
	.router_iact_2_0_horiz_address_in           (CG_0_0_router_iact_2_0_horiz_address_in        ),
	.router_iact_2_0_horiz_data_in_ready        (CG_0_0_router_iact_2_0_horiz_data_in_ready     ),
	.router_iact_2_0_horiz_data_in_valid        (CG_0_0_router_iact_2_0_horiz_data_in_valid     ),
	.router_iact_2_0_horiz_data_in              (CG_0_0_router_iact_2_0_horiz_data_in           ),
	.router_iact_2_0_north_address_out_ready	(CG_0_0_router_iact_2_0_north_address_out_ready	),
	.router_iact_2_0_north_address_out_valid    (CG_0_0_router_iact_2_0_north_address_out_valid ),
	.router_iact_2_0_north_address_out          (CG_0_0_router_iact_2_0_north_address_out       ),
	.router_iact_2_0_north_data_out_ready       (CG_0_0_router_iact_2_0_north_data_out_ready    ),
	.router_iact_2_0_north_data_out_valid       (CG_0_0_router_iact_2_0_north_data_out_valid    ),
	.router_iact_2_0_north_data_out             (CG_0_0_router_iact_2_0_north_data_out          ),
	.router_iact_2_0_south_address_out_ready    (CG_0_0_router_iact_2_0_south_address_out_ready ),
	.router_iact_2_0_south_address_out_valid    (CG_0_0_router_iact_2_0_south_address_out_valid ),
	.router_iact_2_0_south_address_out          (CG_0_0_router_iact_2_0_south_address_out       ),
	.router_iact_2_0_south_data_out_ready       (CG_0_0_router_iact_2_0_south_data_out_ready    ),
	.router_iact_2_0_south_data_out_valid       (CG_0_0_router_iact_2_0_south_data_out_valid    ),
	.router_iact_2_0_south_data_out             (CG_0_0_router_iact_2_0_south_data_out          ),
	.router_iact_2_0_horiz_address_out_ready    (CG_0_0_router_iact_2_0_horiz_address_out_ready ),
	.router_iact_2_0_horiz_address_out_valid    (CG_0_0_router_iact_2_0_horiz_address_out_valid ),
	.router_iact_2_0_horiz_address_out          (CG_0_0_router_iact_2_0_horiz_address_out       ),
	.router_iact_2_0_horiz_data_out_ready       (CG_0_0_router_iact_2_0_horiz_data_out_ready    ),
	.router_iact_2_0_horiz_data_out_valid       (CG_0_0_router_iact_2_0_horiz_data_out_valid    ),
	.router_iact_2_0_horiz_data_out             (CG_0_0_router_iact_2_0_horiz_data_out          ),
	.router_iact_2_1_north_address_in_ready     (CG_0_0_router_iact_2_1_north_address_in_ready  ),
	.router_iact_2_1_north_address_in_valid     (CG_0_0_router_iact_2_1_north_address_in_valid  ),
	.router_iact_2_1_north_address_in           (CG_0_0_router_iact_2_1_north_address_in        ),
	.router_iact_2_1_north_data_in_ready        (CG_0_0_router_iact_2_1_north_data_in_ready     ),
	.router_iact_2_1_north_data_in_valid        (CG_0_0_router_iact_2_1_north_data_in_valid     ),
	.router_iact_2_1_north_data_in              (CG_0_0_router_iact_2_1_north_data_in           ),
	.router_iact_2_1_south_address_in_ready     (CG_0_0_router_iact_2_1_south_address_in_ready  ),
	.router_iact_2_1_south_address_in_valid     (CG_0_0_router_iact_2_1_south_address_in_valid  ),
	.router_iact_2_1_south_address_in           (CG_0_0_router_iact_2_1_south_address_in        ),
	.router_iact_2_1_south_data_in_ready        (CG_0_0_router_iact_2_1_south_data_in_ready     ),
	.router_iact_2_1_south_data_in_valid        (CG_0_0_router_iact_2_1_south_data_in_valid     ),
	.router_iact_2_1_south_data_in              (CG_0_0_router_iact_2_1_south_data_in           ),
	.router_iact_2_1_horiz_address_in_ready     (CG_0_0_router_iact_2_1_horiz_address_in_ready  ),
	.router_iact_2_1_horiz_address_in_valid     (CG_0_0_router_iact_2_1_horiz_address_in_valid  ),
	.router_iact_2_1_horiz_address_in           (CG_0_0_router_iact_2_1_horiz_address_in        ),
	.router_iact_2_1_horiz_data_in_ready        (CG_0_0_router_iact_2_1_horiz_data_in_ready     ),
	.router_iact_2_1_horiz_data_in_valid        (CG_0_0_router_iact_2_1_horiz_data_in_valid     ),
	.router_iact_2_1_horiz_data_in              (CG_0_0_router_iact_2_1_horiz_data_in           ),
	.router_iact_2_1_north_address_out_ready	(CG_0_0_router_iact_2_1_north_address_out_ready	),
	.router_iact_2_1_north_address_out_valid    (CG_0_0_router_iact_2_1_north_address_out_valid ),
	.router_iact_2_1_north_address_out          (CG_0_0_router_iact_2_1_north_address_out       ),
	.router_iact_2_1_north_data_out_ready       (CG_0_0_router_iact_2_1_north_data_out_ready    ),
	.router_iact_2_1_north_data_out_valid       (CG_0_0_router_iact_2_1_north_data_out_valid    ),
	.router_iact_2_1_north_data_out             (CG_0_0_router_iact_2_1_north_data_out          ),
	.router_iact_2_1_south_address_out_ready    (CG_0_0_router_iact_2_1_south_address_out_ready ),
	.router_iact_2_1_south_address_out_valid    (CG_0_0_router_iact_2_1_south_address_out_valid ),
	.router_iact_2_1_south_address_out          (CG_0_0_router_iact_2_1_south_address_out       ),
	.router_iact_2_1_south_data_out_ready       (CG_0_0_router_iact_2_1_south_data_out_ready    ),
	.router_iact_2_1_south_data_out_valid       (CG_0_0_router_iact_2_1_south_data_out_valid    ),
	.router_iact_2_1_south_data_out             (CG_0_0_router_iact_2_1_south_data_out          ),
	.router_iact_2_1_horiz_address_out_ready    (CG_0_0_router_iact_2_1_horiz_address_out_ready ),
	.router_iact_2_1_horiz_address_out_valid    (CG_0_0_router_iact_2_1_horiz_address_out_valid ),
	.router_iact_2_1_horiz_address_out          (CG_0_0_router_iact_2_1_horiz_address_out       ),
	.router_iact_2_1_horiz_data_out_ready       (CG_0_0_router_iact_2_1_horiz_data_out_ready    ),
	.router_iact_2_1_horiz_data_out_valid       (CG_0_0_router_iact_2_1_horiz_data_out_valid    ),
	.router_iact_2_1_horiz_data_out             (CG_0_0_router_iact_2_1_horiz_data_out          ),
	.router_iact_2_2_north_address_in_ready     (CG_0_0_router_iact_2_2_north_address_in_ready  ),
	.router_iact_2_2_north_address_in_valid     (CG_0_0_router_iact_2_2_north_address_in_valid  ),
	.router_iact_2_2_north_address_in           (CG_0_0_router_iact_2_2_north_address_in        ),
	.router_iact_2_2_north_data_in_ready        (CG_0_0_router_iact_2_2_north_data_in_ready     ),
	.router_iact_2_2_north_data_in_valid        (CG_0_0_router_iact_2_2_north_data_in_valid     ),
	.router_iact_2_2_north_data_in              (CG_0_0_router_iact_2_2_north_data_in           ),
	.router_iact_2_2_south_address_in_ready     (CG_0_0_router_iact_2_2_south_address_in_ready  ),
	.router_iact_2_2_south_address_in_valid     (CG_0_0_router_iact_2_2_south_address_in_valid  ),
	.router_iact_2_2_south_address_in           (CG_0_0_router_iact_2_2_south_address_in        ),
	.router_iact_2_2_south_data_in_ready        (CG_0_0_router_iact_2_2_south_data_in_ready     ),
	.router_iact_2_2_south_data_in_valid        (CG_0_0_router_iact_2_2_south_data_in_valid     ),
	.router_iact_2_2_south_data_in              (CG_0_0_router_iact_2_2_south_data_in           ),
	.router_iact_2_2_horiz_address_in_ready     (CG_0_0_router_iact_2_2_horiz_address_in_ready  ),
	.router_iact_2_2_horiz_address_in_valid     (CG_0_0_router_iact_2_2_horiz_address_in_valid  ),
	.router_iact_2_2_horiz_address_in           (CG_0_0_router_iact_2_2_horiz_address_in        ),
	.router_iact_2_2_horiz_data_in_ready        (CG_0_0_router_iact_2_2_horiz_data_in_ready     ),
	.router_iact_2_2_horiz_data_in_valid        (CG_0_0_router_iact_2_2_horiz_data_in_valid     ),
	.router_iact_2_2_horiz_data_in              (CG_0_0_router_iact_2_2_horiz_data_in           ),
	.router_iact_2_2_north_address_out_ready	(CG_0_0_router_iact_2_2_north_address_out_ready	),
	.router_iact_2_2_north_address_out_valid    (CG_0_0_router_iact_2_2_north_address_out_valid ),
	.router_iact_2_2_north_address_out          (CG_0_0_router_iact_2_2_north_address_out       ),
	.router_iact_2_2_north_data_out_ready       (CG_0_0_router_iact_2_2_north_data_out_ready    ),
	.router_iact_2_2_north_data_out_valid       (CG_0_0_router_iact_2_2_north_data_out_valid    ),
	.router_iact_2_2_north_data_out             (CG_0_0_router_iact_2_2_north_data_out          ),
	.router_iact_2_2_south_address_out_ready    (CG_0_0_router_iact_2_2_south_address_out_ready ),
	.router_iact_2_2_south_address_out_valid    (CG_0_0_router_iact_2_2_south_address_out_valid ),
	.router_iact_2_2_south_address_out          (CG_0_0_router_iact_2_2_south_address_out       ),
	.router_iact_2_2_south_data_out_ready       (CG_0_0_router_iact_2_2_south_data_out_ready    ),
	.router_iact_2_2_south_data_out_valid       (CG_0_0_router_iact_2_2_south_data_out_valid    ),
	.router_iact_2_2_south_data_out             (CG_0_0_router_iact_2_2_south_data_out          ),
	.router_iact_2_2_horiz_address_out_ready    (CG_0_0_router_iact_2_2_horiz_address_out_ready ),
	.router_iact_2_2_horiz_address_out_valid    (CG_0_0_router_iact_2_2_horiz_address_out_valid ),
	.router_iact_2_2_horiz_address_out          (CG_0_0_router_iact_2_2_horiz_address_out       ),
	.router_iact_2_2_horiz_data_out_ready       (CG_0_0_router_iact_2_2_horiz_data_out_ready    ),
	.router_iact_2_2_horiz_data_out_valid       (CG_0_0_router_iact_2_2_horiz_data_out_valid    ),
	.router_iact_2_2_horiz_data_out             (CG_0_0_router_iact_2_2_horiz_data_out          ),
												
	.router_weight_0_horiz_address_in_ready     (CG_0_0_router_weight_0_horiz_address_in_ready  ),
	.router_weight_0_horiz_address_in_valid     (CG_0_0_router_weight_0_horiz_address_in_valid  ),
	.router_weight_0_horiz_address_in           (CG_0_0_router_weight_0_horiz_address_in        ),
	.router_weight_0_horiz_data_in_ready        (CG_0_0_router_weight_0_horiz_data_in_ready     ),
	.router_weight_0_horiz_data_in_valid        (CG_0_0_router_weight_0_horiz_data_in_valid     ),
	.router_weight_0_horiz_data_in              (CG_0_0_router_weight_0_horiz_data_in           ),
	.router_weight_0_horiz_address_out_ready    (CG_0_0_router_weight_0_horiz_address_out_ready ),
	.router_weight_0_horiz_address_out_valid    (CG_0_0_router_weight_0_horiz_address_out_valid ),
	.router_weight_0_horiz_address_out          (CG_0_0_router_weight_0_horiz_address_out       ),
	.router_weight_0_horiz_data_out_ready       (CG_0_0_router_weight_0_horiz_data_out_ready    ),
	.router_weight_0_horiz_data_out_valid       (CG_0_0_router_weight_0_horiz_data_out_valid    ),
	.router_weight_0_horiz_data_out             (CG_0_0_router_weight_0_horiz_data_out          ),
	.router_weight_1_horiz_address_in_ready     (CG_0_0_router_weight_1_horiz_address_in_ready  ),
	.router_weight_1_horiz_address_in_valid     (CG_0_0_router_weight_1_horiz_address_in_valid  ),
	.router_weight_1_horiz_address_in           (CG_0_0_router_weight_1_horiz_address_in        ),
	.router_weight_1_horiz_data_in_ready        (CG_0_0_router_weight_1_horiz_data_in_ready     ),
	.router_weight_1_horiz_data_in_valid        (CG_0_0_router_weight_1_horiz_data_in_valid     ),
	.router_weight_1_horiz_data_in              (CG_0_0_router_weight_1_horiz_data_in           ),
	.router_weight_1_horiz_address_out_ready    (CG_0_0_router_weight_1_horiz_address_out_ready ),
	.router_weight_1_horiz_address_out_valid    (CG_0_0_router_weight_1_horiz_address_out_valid ),
	.router_weight_1_horiz_address_out          (CG_0_0_router_weight_1_horiz_address_out       ),
	.router_weight_1_horiz_data_out_ready       (CG_0_0_router_weight_1_horiz_data_out_ready    ),
	.router_weight_1_horiz_data_out_valid       (CG_0_0_router_weight_1_horiz_data_out_valid    ),
	.router_weight_1_horiz_data_out             (CG_0_0_router_weight_1_horiz_data_out          ),
	.router_weight_2_horiz_address_in_ready     (CG_0_0_router_weight_2_horiz_address_in_ready  ),
	.router_weight_2_horiz_address_in_valid     (CG_0_0_router_weight_2_horiz_address_in_valid  ),
	.router_weight_2_horiz_address_in           (CG_0_0_router_weight_2_horiz_address_in        ),
	.router_weight_2_horiz_data_in_ready        (CG_0_0_router_weight_2_horiz_data_in_ready     ),
	.router_weight_2_horiz_data_in_valid        (CG_0_0_router_weight_2_horiz_data_in_valid     ),
	.router_weight_2_horiz_data_in              (CG_0_0_router_weight_2_horiz_data_in           ),
	.router_weight_2_horiz_address_out_ready    (CG_0_0_router_weight_2_horiz_address_out_ready ),
	.router_weight_2_horiz_address_out_valid    (CG_0_0_router_weight_2_horiz_address_out_valid ),
	.router_weight_2_horiz_address_out          (CG_0_0_router_weight_2_horiz_address_out       ),
	.router_weight_2_horiz_data_out_ready       (CG_0_0_router_weight_2_horiz_data_out_ready    ),
	.router_weight_2_horiz_data_out_valid       (CG_0_0_router_weight_2_horiz_data_out_valid    ),
	.router_weight_2_horiz_data_out             (CG_0_0_router_weight_2_horiz_data_out          ),
												
	.router_psum_0_north_in_ready               (CG_0_0_router_psum_0_north_in_ready            ),
	.router_psum_0_north_in_valid               (CG_0_0_router_psum_0_north_in_valid            ),
	.router_psum_0_north_in                     (CG_0_0_router_psum_0_north_in                  ),
	.router_psum_0_south_out_ready              (CG_0_0_router_psum_0_south_out_ready           ),
	.router_psum_0_south_out_valid              (CG_0_0_router_psum_0_south_out_valid           ),
	.router_psum_0_south_out                    (CG_0_0_router_psum_0_south_out                 ),
	.router_psum_1_north_in_ready               (CG_0_0_router_psum_1_north_in_ready            ),
	.router_psum_1_north_in_valid               (CG_0_0_router_psum_1_north_in_valid            ),
	.router_psum_1_north_in                     (CG_0_0_router_psum_1_north_in                  ),
	.router_psum_1_south_out_ready              (CG_0_0_router_psum_1_south_out_ready           ),
	.router_psum_1_south_out_valid              (CG_0_0_router_psum_1_south_out_valid           ),
	.router_psum_1_south_out                    (CG_0_0_router_psum_1_south_out                 ),
	.router_psum_2_north_in_ready               (CG_0_0_router_psum_2_north_in_ready            ),
	.router_psum_2_north_in_valid               (CG_0_0_router_psum_2_north_in_valid            ),
	.router_psum_2_north_in                     (CG_0_0_router_psum_2_north_in                  ),
	.router_psum_2_south_out_ready              (CG_0_0_router_psum_2_south_out_ready           ),
	.router_psum_2_south_out_valid              (CG_0_0_router_psum_2_south_out_valid           ),
	.router_psum_2_south_out                    (CG_0_0_router_psum_2_south_out                 ),
												 					
	.cg_south_psum_0_in_ready                   (CG_0_0_cg_south_psum_0_in_ready                ),
	.cg_south_psum_0_in_valid                   (CG_0_0_cg_south_psum_0_in_valid                ),
	.cg_south_psum_0_in                         (CG_0_0_cg_south_psum_0_in                      ),
	.cg_south_psum_1_in_ready                   (CG_0_0_cg_south_psum_1_in_ready                ),
	.cg_south_psum_1_in_valid                   (CG_0_0_cg_south_psum_1_in_valid                ),
	.cg_south_psum_1_in                         (CG_0_0_cg_south_psum_1_in                      ),
	.cg_south_psum_2_in_ready                   (CG_0_0_cg_south_psum_2_in_ready                ),
	.cg_south_psum_2_in_valid                   (CG_0_0_cg_south_psum_2_in_valid                ),
	.cg_south_psum_2_in                         (CG_0_0_cg_south_psum_2_in                      ),
	.cg_north_psum_0_out_ready                  (CG_0_0_cg_north_psum_0_out_ready               ),
	.cg_north_psum_0_out_valid                  (CG_0_0_cg_north_psum_0_out_valid               ),
	.cg_north_psum_0_out                        (CG_0_0_cg_north_psum_0_out                     ),
	.cg_north_psum_1_out_ready                  (CG_0_0_cg_north_psum_1_out_ready               ),
	.cg_north_psum_1_out_valid                  (CG_0_0_cg_north_psum_1_out_valid               ),
	.cg_north_psum_1_out                        (CG_0_0_cg_north_psum_1_out                     ),
	.cg_north_psum_2_out_ready                  (CG_0_0_cg_north_psum_2_out_ready               ),
	.cg_north_psum_2_out_valid                  (CG_0_0_cg_north_psum_2_out_valid               ),
	.cg_north_psum_2_out                        (CG_0_0_cg_north_psum_2_out                     ),
									         
	.PSUM_DEPTH                                 (CG_0_0_PSUM_DEPTH                              ),
	.psum_spad_clear                            (CG_0_0_psum_spad_clear                         ),
											
	.iact_write_fin_clear                       (CG_0_0_iact_write_fin_clear                	),
	.weight_write_fin_clear						(CG_0_0_weight_write_fin_clear					)
);



ClusterGroup ClusterGroup_0_1 (
	.clock										(CG_0_1_clock									),
	.reset										(CG_0_1_reset									),
											   					
	.PE_cluster_iact_data_in_sel                (CG_0_1_PE_cluster_iact_data_in_sel             ),
	.PE_cluster_iact_data_out_sel               (CG_0_1_PE_cluster_iact_data_out_sel            ),
	.PE_cluster_psum_data_in_sel                (CG_0_1_PE_cluster_psum_data_in_sel             ),
									            			
	.router_cluster_iact_data_in_sel            (CG_0_1_router_cluster_iact_data_in_sel         ),
	.router_cluster_iact_data_out_sel           (CG_0_1_router_cluster_iact_data_out_sel        ),
	.router_cluster_weight_data_in_sel          (CG_0_1_router_cluster_weight_data_in_sel       ),
	.router_cluster_weight_data_out_sel         (CG_0_1_router_cluster_weight_data_out_sel      ),
	.router_cluster_psum_data_in_sel            (CG_0_1_router_cluster_psum_data_in_sel         ),
	.router_cluster_psum_data_out_sel           (CG_0_1_router_cluster_psum_data_out_sel        ),
							                    
	.read_psum_en                               (CG_0_1_read_psum_en                            ),
	.cal_fin                                    (CG_0_1_cal_fin                                 ),
	.cg_en                                      (CG_0_1_cg_en                                   ),
	.PE_weight_load_en                          (CG_0_1_PE_weight_load_en                       ),
	.GLB_iact_load_en                           (CG_0_1_GLB_iact_load_en                        ),
	.src_GLB_load_fin							(CG_0_1_src_GLB_load_fin						),
	.all_cal_fin								(CG_0_1_all_cal_fin								),
	.psum_acc_en								(CG_0_1_psum_acc_en								),
	.psum_acc_fin								(CG_0_1_psum_acc_fin							),
	.GLB_psum_write_en							(CG_0_1_GLB_psum_write_en						),
	.psum_SRAM_Bank_0_read_out_en				(CG_0_1_psum_SRAM_Bank_0_read_out_en			),
	.psum_SRAM_Bank_1_read_out_en				(CG_0_1_psum_SRAM_Bank_1_read_out_en			),
	.psum_SRAM_Bank_2_read_out_en				(CG_0_1_psum_SRAM_Bank_2_read_out_en			),
	
	.PE_0_0_disable								(CG_0_1_PE_0_0_disable							),
	.PE_0_1_disable								(CG_0_1_PE_0_1_disable							),
	.PE_0_2_disable								(CG_0_1_PE_0_2_disable							),
	.PE_1_0_disable								(CG_0_1_PE_1_0_disable							),
	.PE_1_1_disable								(CG_0_1_PE_1_1_disable							),
	.PE_1_2_disable								(CG_0_1_PE_1_2_disable							),
	.PE_2_0_disable								(CG_0_1_PE_2_0_disable							),
	.PE_2_1_disable								(CG_0_1_PE_2_1_disable							),
	.PE_2_2_disable								(CG_0_1_PE_2_2_disable							),
							                   
	.GLB_iact_0_0_read_addr                     (CG_0_1_GLB_iact_0_0_read_addr                  ),
	.GLB_iact_0_1_read_addr                     (CG_0_1_GLB_iact_0_1_read_addr                  ),
	.GLB_iact_0_2_read_addr                     (CG_0_1_GLB_iact_0_2_read_addr                  ),
	.GLB_iact_1_0_read_addr                     (CG_0_1_GLB_iact_1_0_read_addr                  ),
	.GLB_iact_1_1_read_addr                     (CG_0_1_GLB_iact_1_1_read_addr                  ),
	.GLB_iact_1_2_read_addr                     (CG_0_1_GLB_iact_1_2_read_addr                  ),
	.GLB_iact_2_0_read_addr                     (CG_0_1_GLB_iact_2_0_read_addr                  ),
	.GLB_iact_2_1_read_addr                     (CG_0_1_GLB_iact_2_1_read_addr                  ),
	.GLB_iact_2_2_read_addr                     (CG_0_1_GLB_iact_2_2_read_addr                  ),
							                    
	.GLB_psum_0_write_addr                      (CG_0_1_GLB_psum_0_write_addr                   ),
	.GLB_psum_1_write_addr                      (CG_0_1_GLB_psum_1_write_addr                   ),
	.GLB_psum_2_write_addr                      (CG_0_1_GLB_psum_2_write_addr                   ),
	.GLB_psum_0_read_addr                       (CG_0_1_GLB_psum_0_read_addr                    ),
	.GLB_psum_1_read_addr                       (CG_0_1_GLB_psum_1_read_addr                    ),
	.GLB_psum_2_read_addr                       (CG_0_1_GLB_psum_2_read_addr                    ),
								               
	.GLB_iact_0_0_address_in_ready              (CG_0_1_GLB_iact_0_0_address_in_ready           ),
	.GLB_iact_0_0_address_in_valid              (CG_0_1_GLB_iact_0_0_address_in_valid           ),
	.GLB_iact_0_0_address_in                    (CG_0_1_GLB_iact_0_0_address_in                 ),
	.GLB_iact_0_0_data_in_ready                 (CG_0_1_GLB_iact_0_0_data_in_ready              ),
	.GLB_iact_0_0_data_in_valid                 (CG_0_1_GLB_iact_0_0_data_in_valid              ),
	.GLB_iact_0_0_data_in                       (CG_0_1_GLB_iact_0_0_data_in                    ),
	.GLB_iact_0_1_address_in_ready              (CG_0_1_GLB_iact_0_1_address_in_ready           ),
	.GLB_iact_0_1_address_in_valid              (CG_0_1_GLB_iact_0_1_address_in_valid           ),
	.GLB_iact_0_1_address_in                    (CG_0_1_GLB_iact_0_1_address_in                 ),
	.GLB_iact_0_1_data_in_ready                 (CG_0_1_GLB_iact_0_1_data_in_ready              ),
	.GLB_iact_0_1_data_in_valid                 (CG_0_1_GLB_iact_0_1_data_in_valid              ),
	.GLB_iact_0_1_data_in                       (CG_0_1_GLB_iact_0_1_data_in                    ),
	.GLB_iact_0_2_address_in_ready              (CG_0_1_GLB_iact_0_2_address_in_ready           ),
	.GLB_iact_0_2_address_in_valid              (CG_0_1_GLB_iact_0_2_address_in_valid           ),
	.GLB_iact_0_2_address_in                    (CG_0_1_GLB_iact_0_2_address_in                 ),
	.GLB_iact_0_2_data_in_ready                 (CG_0_1_GLB_iact_0_2_data_in_ready              ),
	.GLB_iact_0_2_data_in_valid                 (CG_0_1_GLB_iact_0_2_data_in_valid              ),
	.GLB_iact_0_2_data_in                       (CG_0_1_GLB_iact_0_2_data_in                    ),
	.GLB_iact_1_0_address_in_ready              (CG_0_1_GLB_iact_1_0_address_in_ready           ),
	.GLB_iact_1_0_address_in_valid              (CG_0_1_GLB_iact_1_0_address_in_valid           ),
	.GLB_iact_1_0_address_in                    (CG_0_1_GLB_iact_1_0_address_in                 ),
	.GLB_iact_1_0_data_in_ready                 (CG_0_1_GLB_iact_1_0_data_in_ready              ),
	.GLB_iact_1_0_data_in_valid                 (CG_0_1_GLB_iact_1_0_data_in_valid              ),
	.GLB_iact_1_0_data_in                       (CG_0_1_GLB_iact_1_0_data_in                    ),
	.GLB_iact_1_1_address_in_ready              (CG_0_1_GLB_iact_1_1_address_in_ready           ),
	.GLB_iact_1_1_address_in_valid              (CG_0_1_GLB_iact_1_1_address_in_valid           ),
	.GLB_iact_1_1_address_in                    (CG_0_1_GLB_iact_1_1_address_in                 ),
	.GLB_iact_1_1_data_in_ready                 (CG_0_1_GLB_iact_1_1_data_in_ready              ),
	.GLB_iact_1_1_data_in_valid                 (CG_0_1_GLB_iact_1_1_data_in_valid              ),
	.GLB_iact_1_1_data_in                       (CG_0_1_GLB_iact_1_1_data_in                    ),
	.GLB_iact_1_2_address_in_ready              (CG_0_1_GLB_iact_1_2_address_in_ready           ),
	.GLB_iact_1_2_address_in_valid              (CG_0_1_GLB_iact_1_2_address_in_valid           ),
	.GLB_iact_1_2_address_in                    (CG_0_1_GLB_iact_1_2_address_in                 ),
	.GLB_iact_1_2_data_in_ready                 (CG_0_1_GLB_iact_1_2_data_in_ready              ),
	.GLB_iact_1_2_data_in_valid                 (CG_0_1_GLB_iact_1_2_data_in_valid              ),
	.GLB_iact_1_2_data_in                       (CG_0_1_GLB_iact_1_2_data_in                    ),
	.GLB_iact_2_0_address_in_ready              (CG_0_1_GLB_iact_2_0_address_in_ready           ),
	.GLB_iact_2_0_address_in_valid              (CG_0_1_GLB_iact_2_0_address_in_valid           ),
	.GLB_iact_2_0_address_in                    (CG_0_1_GLB_iact_2_0_address_in                 ),
	.GLB_iact_2_0_data_in_ready                 (CG_0_1_GLB_iact_2_0_data_in_ready              ),
	.GLB_iact_2_0_data_in_valid                 (CG_0_1_GLB_iact_2_0_data_in_valid              ),
	.GLB_iact_2_0_data_in                       (CG_0_1_GLB_iact_2_0_data_in                    ),
	.GLB_iact_2_1_address_in_ready              (CG_0_1_GLB_iact_2_1_address_in_ready           ),
	.GLB_iact_2_1_address_in_valid              (CG_0_1_GLB_iact_2_1_address_in_valid           ),
	.GLB_iact_2_1_address_in                    (CG_0_1_GLB_iact_2_1_address_in                 ),
	.GLB_iact_2_1_data_in_ready                 (CG_0_1_GLB_iact_2_1_data_in_ready              ),
	.GLB_iact_2_1_data_in_valid                 (CG_0_1_GLB_iact_2_1_data_in_valid              ),
	.GLB_iact_2_1_data_in                       (CG_0_1_GLB_iact_2_1_data_in                    ),
	.GLB_iact_2_2_address_in_ready              (CG_0_1_GLB_iact_2_2_address_in_ready           ),
	.GLB_iact_2_2_address_in_valid              (CG_0_1_GLB_iact_2_2_address_in_valid           ),
	.GLB_iact_2_2_address_in                    (CG_0_1_GLB_iact_2_2_address_in                 ),
	.GLB_iact_2_2_data_in_ready                 (CG_0_1_GLB_iact_2_2_data_in_ready              ),
	.GLB_iact_2_2_data_in_valid                 (CG_0_1_GLB_iact_2_2_data_in_valid              ),
	.GLB_iact_2_2_data_in                       (CG_0_1_GLB_iact_2_2_data_in                    ),
										    						
	.GLB_weight_0_address_in_ready              (CG_0_1_GLB_weight_0_address_in_ready           ),
	.GLB_weight_0_address_in_valid              (CG_0_1_GLB_weight_0_address_in_valid           ),
	.GLB_weight_0_address_in                    (CG_0_1_GLB_weight_0_address_in                 ),
	.GLB_weight_0_data_in_ready                 (CG_0_1_GLB_weight_0_data_in_ready              ),
	.GLB_weight_0_data_in_valid                 (CG_0_1_GLB_weight_0_data_in_valid              ),
	.GLB_weight_0_data_in                       (CG_0_1_GLB_weight_0_data_in                    ),
	.GLB_weight_1_address_in_ready              (CG_0_1_GLB_weight_1_address_in_ready           ),
	.GLB_weight_1_address_in_valid	            (CG_0_1_GLB_weight_1_address_in_valid	     	),
	.GLB_weight_1_address_in                    (CG_0_1_GLB_weight_1_address_in                 ),
	.GLB_weight_1_data_in_ready                 (CG_0_1_GLB_weight_1_data_in_ready              ),
	.GLB_weight_1_data_in_valid                 (CG_0_1_GLB_weight_1_data_in_valid              ),
	.GLB_weight_1_data_in                       (CG_0_1_GLB_weight_1_data_in                    ),
	.GLB_weight_2_address_in_ready              (CG_0_1_GLB_weight_2_address_in_ready           ),
	.GLB_weight_2_address_in_valid              (CG_0_1_GLB_weight_2_address_in_valid           ),
	.GLB_weight_2_address_in                    (CG_0_1_GLB_weight_2_address_in                 ),
	.GLB_weight_2_data_in_ready                 (CG_0_1_GLB_weight_2_data_in_ready              ),
	.GLB_weight_2_data_in_valid                 (CG_0_1_GLB_weight_2_data_in_valid              ),
	.GLB_weight_2_data_in                       (CG_0_1_GLB_weight_2_data_in                    ),
										     
	.GLB_psum_0_data_in_ready                   (CG_0_1_GLB_psum_0_data_in_ready                ),
	.GLB_psum_0_data_in_valid                   (CG_0_1_GLB_psum_0_data_in_valid                ),
	.GLB_psum_0_data_in                         (CG_0_1_GLB_psum_0_data_in                      ),
	.GLB_psum_0_data_out_ready                  (CG_0_1_GLB_psum_0_data_out_ready               ),
	.GLB_psum_0_data_out_valid                  (CG_0_1_GLB_psum_0_data_out_valid               ),
	.GLB_psum_0_data_out                        (CG_0_1_GLB_psum_0_data_out                     ),
	.GLB_psum_1_data_in_ready                   (CG_0_1_GLB_psum_1_data_in_ready                ),
	.GLB_psum_1_data_in_valid                   (CG_0_1_GLB_psum_1_data_in_valid                ),
	.GLB_psum_1_data_in                         (CG_0_1_GLB_psum_1_data_in                      ),
	.GLB_psum_1_data_out_ready                  (CG_0_1_GLB_psum_1_data_out_ready               ),
	.GLB_psum_1_data_out_valid                  (CG_0_1_GLB_psum_1_data_out_valid               ),
	.GLB_psum_1_data_out                        (CG_0_1_GLB_psum_1_data_out                     ),
	.GLB_psum_2_data_in_ready                   (CG_0_1_GLB_psum_2_data_in_ready                ),
	.GLB_psum_2_data_in_valid                   (CG_0_1_GLB_psum_2_data_in_valid                ),
	.GLB_psum_2_data_in                         (CG_0_1_GLB_psum_2_data_in                      ),
	.GLB_psum_2_data_out_ready                  (CG_0_1_GLB_psum_2_data_out_ready               ),
	.GLB_psum_2_data_out_valid                  (CG_0_1_GLB_psum_2_data_out_valid               ),
	.GLB_psum_2_data_out                        (CG_0_1_GLB_psum_2_data_out                     ),
											
	.router_iact_0_0_north_address_in_ready		(CG_0_1_router_iact_0_0_north_address_in_ready	),
	.router_iact_0_0_north_address_in_valid     (CG_0_1_router_iact_0_0_north_address_in_valid  ),
	.router_iact_0_0_north_address_in           (CG_0_1_router_iact_0_0_north_address_in        ),
	.router_iact_0_0_north_data_in_ready        (CG_0_1_router_iact_0_0_north_data_in_ready     ),
	.router_iact_0_0_north_data_in_valid        (CG_0_1_router_iact_0_0_north_data_in_valid     ),
	.router_iact_0_0_north_data_in              (CG_0_1_router_iact_0_0_north_data_in           ),
	.router_iact_0_0_south_address_in_ready     (CG_0_1_router_iact_0_0_south_address_in_ready  ),
	.router_iact_0_0_south_address_in_valid     (CG_0_1_router_iact_0_0_south_address_in_valid  ),
	.router_iact_0_0_south_address_in           (CG_0_1_router_iact_0_0_south_address_in        ),
	.router_iact_0_0_south_data_in_ready        (CG_0_1_router_iact_0_0_south_data_in_ready     ),
	.router_iact_0_0_south_data_in_valid        (CG_0_1_router_iact_0_0_south_data_in_valid     ),
	.router_iact_0_0_south_data_in              (CG_0_1_router_iact_0_0_south_data_in           ),
	.router_iact_0_0_horiz_address_in_ready     (CG_0_1_router_iact_0_0_horiz_address_in_ready  ),
	.router_iact_0_0_horiz_address_in_valid     (CG_0_1_router_iact_0_0_horiz_address_in_valid  ),
	.router_iact_0_0_horiz_address_in           (CG_0_1_router_iact_0_0_horiz_address_in        ),
	.router_iact_0_0_horiz_data_in_ready        (CG_0_1_router_iact_0_0_horiz_data_in_ready     ),
	.router_iact_0_0_horiz_data_in_valid        (CG_0_1_router_iact_0_0_horiz_data_in_valid     ),
	.router_iact_0_0_horiz_data_in              (CG_0_1_router_iact_0_0_horiz_data_in           ),
	.router_iact_0_0_north_address_out_ready	(CG_0_1_router_iact_0_0_north_address_out_ready	),
	.router_iact_0_0_north_address_out_valid    (CG_0_1_router_iact_0_0_north_address_out_valid ),
	.router_iact_0_0_north_address_out          (CG_0_1_router_iact_0_0_north_address_out       ),
	.router_iact_0_0_north_data_out_ready       (CG_0_1_router_iact_0_0_north_data_out_ready    ),
	.router_iact_0_0_north_data_out_valid       (CG_0_1_router_iact_0_0_north_data_out_valid    ),
	.router_iact_0_0_north_data_out             (CG_0_1_router_iact_0_0_north_data_out          ),
	.router_iact_0_0_south_address_out_ready    (CG_0_1_router_iact_0_0_south_address_out_ready ),
	.router_iact_0_0_south_address_out_valid    (CG_0_1_router_iact_0_0_south_address_out_valid ),
	.router_iact_0_0_south_address_out          (CG_0_1_router_iact_0_0_south_address_out       ),
	.router_iact_0_0_south_data_out_ready       (CG_0_1_router_iact_0_0_south_data_out_ready    ),
	.router_iact_0_0_south_data_out_valid       (CG_0_1_router_iact_0_0_south_data_out_valid    ),
	.router_iact_0_0_south_data_out             (CG_0_1_router_iact_0_0_south_data_out          ),
	.router_iact_0_0_horiz_address_out_ready    (CG_0_1_router_iact_0_0_horiz_address_out_ready ),
	.router_iact_0_0_horiz_address_out_valid    (CG_0_1_router_iact_0_0_horiz_address_out_valid ),
	.router_iact_0_0_horiz_address_out          (CG_0_1_router_iact_0_0_horiz_address_out       ),
	.router_iact_0_0_horiz_data_out_ready       (CG_0_1_router_iact_0_0_horiz_data_out_ready    ),
	.router_iact_0_0_horiz_data_out_valid       (CG_0_1_router_iact_0_0_horiz_data_out_valid    ),
	.router_iact_0_0_horiz_data_out             (CG_0_1_router_iact_0_0_horiz_data_out          ),
	.router_iact_0_1_north_address_in_ready     (CG_0_1_router_iact_0_1_north_address_in_ready  ),
	.router_iact_0_1_north_address_in_valid     (CG_0_1_router_iact_0_1_north_address_in_valid  ),
	.router_iact_0_1_north_address_in           (CG_0_1_router_iact_0_1_north_address_in        ),
	.router_iact_0_1_north_data_in_ready        (CG_0_1_router_iact_0_1_north_data_in_ready     ),
	.router_iact_0_1_north_data_in_valid        (CG_0_1_router_iact_0_1_north_data_in_valid     ),
	.router_iact_0_1_north_data_in              (CG_0_1_router_iact_0_1_north_data_in           ),
	.router_iact_0_1_south_address_in_ready     (CG_0_1_router_iact_0_1_south_address_in_ready  ),
	.router_iact_0_1_south_address_in_valid     (CG_0_1_router_iact_0_1_south_address_in_valid  ),
	.router_iact_0_1_south_address_in           (CG_0_1_router_iact_0_1_south_address_in        ),
	.router_iact_0_1_south_data_in_ready        (CG_0_1_router_iact_0_1_south_data_in_ready     ),
	.router_iact_0_1_south_data_in_valid        (CG_0_1_router_iact_0_1_south_data_in_valid     ),
	.router_iact_0_1_south_data_in              (CG_0_1_router_iact_0_1_south_data_in           ),
	.router_iact_0_1_horiz_address_in_ready     (CG_0_1_router_iact_0_1_horiz_address_in_ready  ),
	.router_iact_0_1_horiz_address_in_valid     (CG_0_1_router_iact_0_1_horiz_address_in_valid  ),
	.router_iact_0_1_horiz_address_in           (CG_0_1_router_iact_0_1_horiz_address_in        ),
	.router_iact_0_1_horiz_data_in_ready        (CG_0_1_router_iact_0_1_horiz_data_in_ready     ),
	.router_iact_0_1_horiz_data_in_valid        (CG_0_1_router_iact_0_1_horiz_data_in_valid     ),
	.router_iact_0_1_horiz_data_in              (CG_0_1_router_iact_0_1_horiz_data_in           ),
	.router_iact_0_1_north_address_out_ready	(CG_0_1_router_iact_0_1_north_address_out_ready	),
	.router_iact_0_1_north_address_out_valid    (CG_0_1_router_iact_0_1_north_address_out_valid ),
	.router_iact_0_1_north_address_out          (CG_0_1_router_iact_0_1_north_address_out       ),
	.router_iact_0_1_north_data_out_ready       (CG_0_1_router_iact_0_1_north_data_out_ready    ),
	.router_iact_0_1_north_data_out_valid       (CG_0_1_router_iact_0_1_north_data_out_valid    ),
	.router_iact_0_1_north_data_out             (CG_0_1_router_iact_0_1_north_data_out          ),
	.router_iact_0_1_south_address_out_ready    (CG_0_1_router_iact_0_1_south_address_out_ready ),
	.router_iact_0_1_south_address_out_valid    (CG_0_1_router_iact_0_1_south_address_out_valid ),
	.router_iact_0_1_south_address_out          (CG_0_1_router_iact_0_1_south_address_out       ),
	.router_iact_0_1_south_data_out_ready       (CG_0_1_router_iact_0_1_south_data_out_ready    ),
	.router_iact_0_1_south_data_out_valid       (CG_0_1_router_iact_0_1_south_data_out_valid    ),
	.router_iact_0_1_south_data_out             (CG_0_1_router_iact_0_1_south_data_out          ),
	.router_iact_0_1_horiz_address_out_ready    (CG_0_1_router_iact_0_1_horiz_address_out_ready ),
	.router_iact_0_1_horiz_address_out_valid    (CG_0_1_router_iact_0_1_horiz_address_out_valid ),
	.router_iact_0_1_horiz_address_out          (CG_0_1_router_iact_0_1_horiz_address_out       ),
	.router_iact_0_1_horiz_data_out_ready       (CG_0_1_router_iact_0_1_horiz_data_out_ready    ),
	.router_iact_0_1_horiz_data_out_valid       (CG_0_1_router_iact_0_1_horiz_data_out_valid    ),
	.router_iact_0_1_horiz_data_out             (CG_0_1_router_iact_0_1_horiz_data_out          ),
	.router_iact_0_2_north_address_in_ready     (CG_0_1_router_iact_0_2_north_address_in_ready  ),
	.router_iact_0_2_north_address_in_valid     (CG_0_1_router_iact_0_2_north_address_in_valid  ),
	.router_iact_0_2_north_address_in           (CG_0_1_router_iact_0_2_north_address_in        ),
	.router_iact_0_2_north_data_in_ready        (CG_0_1_router_iact_0_2_north_data_in_ready     ),
	.router_iact_0_2_north_data_in_valid        (CG_0_1_router_iact_0_2_north_data_in_valid     ),
	.router_iact_0_2_north_data_in              (CG_0_1_router_iact_0_2_north_data_in           ),
	.router_iact_0_2_south_address_in_ready     (CG_0_1_router_iact_0_2_south_address_in_ready  ),
	.router_iact_0_2_south_address_in_valid     (CG_0_1_router_iact_0_2_south_address_in_valid  ),
	.router_iact_0_2_south_address_in           (CG_0_1_router_iact_0_2_south_address_in        ),
	.router_iact_0_2_south_data_in_ready        (CG_0_1_router_iact_0_2_south_data_in_ready     ),
	.router_iact_0_2_south_data_in_valid        (CG_0_1_router_iact_0_2_south_data_in_valid     ),
	.router_iact_0_2_south_data_in              (CG_0_1_router_iact_0_2_south_data_in           ),
	.router_iact_0_2_horiz_address_in_ready     (CG_0_1_router_iact_0_2_horiz_address_in_ready  ),
	.router_iact_0_2_horiz_address_in_valid     (CG_0_1_router_iact_0_2_horiz_address_in_valid  ),
	.router_iact_0_2_horiz_address_in           (CG_0_1_router_iact_0_2_horiz_address_in        ),
	.router_iact_0_2_horiz_data_in_ready        (CG_0_1_router_iact_0_2_horiz_data_in_ready     ),
	.router_iact_0_2_horiz_data_in_valid        (CG_0_1_router_iact_0_2_horiz_data_in_valid     ),
	.router_iact_0_2_horiz_data_in              (CG_0_1_router_iact_0_2_horiz_data_in           ),
	.router_iact_0_2_north_address_out_ready	(CG_0_1_router_iact_0_2_north_address_out_ready	),
	.router_iact_0_2_north_address_out_valid    (CG_0_1_router_iact_0_2_north_address_out_valid ),
	.router_iact_0_2_north_address_out          (CG_0_1_router_iact_0_2_north_address_out       ),
	.router_iact_0_2_north_data_out_ready       (CG_0_1_router_iact_0_2_north_data_out_ready    ),
	.router_iact_0_2_north_data_out_valid       (CG_0_1_router_iact_0_2_north_data_out_valid    ),
	.router_iact_0_2_north_data_out             (CG_0_1_router_iact_0_2_north_data_out          ),
	.router_iact_0_2_south_address_out_ready    (CG_0_1_router_iact_0_2_south_address_out_ready ),
	.router_iact_0_2_south_address_out_valid    (CG_0_1_router_iact_0_2_south_address_out_valid ),
	.router_iact_0_2_south_address_out          (CG_0_1_router_iact_0_2_south_address_out       ),
	.router_iact_0_2_south_data_out_ready       (CG_0_1_router_iact_0_2_south_data_out_ready    ),
	.router_iact_0_2_south_data_out_valid       (CG_0_1_router_iact_0_2_south_data_out_valid    ),
	.router_iact_0_2_south_data_out             (CG_0_1_router_iact_0_2_south_data_out          ),
	.router_iact_0_2_horiz_address_out_ready    (CG_0_1_router_iact_0_2_horiz_address_out_ready ),
	.router_iact_0_2_horiz_address_out_valid    (CG_0_1_router_iact_0_2_horiz_address_out_valid ),
	.router_iact_0_2_horiz_address_out          (CG_0_1_router_iact_0_2_horiz_address_out       ),
	.router_iact_0_2_horiz_data_out_ready       (CG_0_1_router_iact_0_2_horiz_data_out_ready    ),
	.router_iact_0_2_horiz_data_out_valid       (CG_0_1_router_iact_0_2_horiz_data_out_valid    ),
	.router_iact_0_2_horiz_data_out             (CG_0_1_router_iact_0_2_horiz_data_out          ),
	.router_iact_1_0_north_address_in_ready     (CG_0_1_router_iact_1_0_north_address_in_ready  ),
	.router_iact_1_0_north_address_in_valid     (CG_0_1_router_iact_1_0_north_address_in_valid  ),
	.router_iact_1_0_north_address_in           (CG_0_1_router_iact_1_0_north_address_in        ),
	.router_iact_1_0_north_data_in_ready        (CG_0_1_router_iact_1_0_north_data_in_ready     ),
	.router_iact_1_0_north_data_in_valid        (CG_0_1_router_iact_1_0_north_data_in_valid     ),
	.router_iact_1_0_north_data_in              (CG_0_1_router_iact_1_0_north_data_in           ),
	.router_iact_1_0_south_address_in_ready     (CG_0_1_router_iact_1_0_south_address_in_ready  ),
	.router_iact_1_0_south_address_in_valid     (CG_0_1_router_iact_1_0_south_address_in_valid  ),
	.router_iact_1_0_south_address_in           (CG_0_1_router_iact_1_0_south_address_in        ),
	.router_iact_1_0_south_data_in_ready        (CG_0_1_router_iact_1_0_south_data_in_ready     ),
	.router_iact_1_0_south_data_in_valid        (CG_0_1_router_iact_1_0_south_data_in_valid     ),
	.router_iact_1_0_south_data_in              (CG_0_1_router_iact_1_0_south_data_in           ),
	.router_iact_1_0_horiz_address_in_ready     (CG_0_1_router_iact_1_0_horiz_address_in_ready  ),
	.router_iact_1_0_horiz_address_in_valid     (CG_0_1_router_iact_1_0_horiz_address_in_valid  ),
	.router_iact_1_0_horiz_address_in           (CG_0_1_router_iact_1_0_horiz_address_in        ),
	.router_iact_1_0_horiz_data_in_ready        (CG_0_1_router_iact_1_0_horiz_data_in_ready     ),
	.router_iact_1_0_horiz_data_in_valid        (CG_0_1_router_iact_1_0_horiz_data_in_valid     ),
	.router_iact_1_0_horiz_data_in              (CG_0_1_router_iact_1_0_horiz_data_in           ),
	.router_iact_1_0_north_address_out_ready	(CG_0_1_router_iact_1_0_north_address_out_ready	),
	.router_iact_1_0_north_address_out_valid    (CG_0_1_router_iact_1_0_north_address_out_valid ),
	.router_iact_1_0_north_address_out          (CG_0_1_router_iact_1_0_north_address_out       ),
	.router_iact_1_0_north_data_out_ready       (CG_0_1_router_iact_1_0_north_data_out_ready    ),
	.router_iact_1_0_north_data_out_valid       (CG_0_1_router_iact_1_0_north_data_out_valid    ),
	.router_iact_1_0_north_data_out             (CG_0_1_router_iact_1_0_north_data_out          ),
	.router_iact_1_0_south_address_out_ready    (CG_0_1_router_iact_1_0_south_address_out_ready ),
	.router_iact_1_0_south_address_out_valid    (CG_0_1_router_iact_1_0_south_address_out_valid ),
	.router_iact_1_0_south_address_out          (CG_0_1_router_iact_1_0_south_address_out       ),
	.router_iact_1_0_south_data_out_ready       (CG_0_1_router_iact_1_0_south_data_out_ready    ),
	.router_iact_1_0_south_data_out_valid       (CG_0_1_router_iact_1_0_south_data_out_valid    ),
	.router_iact_1_0_south_data_out             (CG_0_1_router_iact_1_0_south_data_out          ),
	.router_iact_1_0_horiz_address_out_ready    (CG_0_1_router_iact_1_0_horiz_address_out_ready ),
	.router_iact_1_0_horiz_address_out_valid    (CG_0_1_router_iact_1_0_horiz_address_out_valid ),
	.router_iact_1_0_horiz_address_out          (CG_0_1_router_iact_1_0_horiz_address_out       ),
	.router_iact_1_0_horiz_data_out_ready       (CG_0_1_router_iact_1_0_horiz_data_out_ready    ),
	.router_iact_1_0_horiz_data_out_valid       (CG_0_1_router_iact_1_0_horiz_data_out_valid    ),
	.router_iact_1_0_horiz_data_out             (CG_0_1_router_iact_1_0_horiz_data_out          ),
	.router_iact_1_1_north_address_in_ready     (CG_0_1_router_iact_1_1_north_address_in_ready  ),
	.router_iact_1_1_north_address_in_valid     (CG_0_1_router_iact_1_1_north_address_in_valid  ),
	.router_iact_1_1_north_address_in           (CG_0_1_router_iact_1_1_north_address_in        ),
	.router_iact_1_1_north_data_in_ready        (CG_0_1_router_iact_1_1_north_data_in_ready     ),
	.router_iact_1_1_north_data_in_valid        (CG_0_1_router_iact_1_1_north_data_in_valid     ),
	.router_iact_1_1_north_data_in              (CG_0_1_router_iact_1_1_north_data_in           ),
	.router_iact_1_1_south_address_in_ready     (CG_0_1_router_iact_1_1_south_address_in_ready  ),
	.router_iact_1_1_south_address_in_valid     (CG_0_1_router_iact_1_1_south_address_in_valid  ),
	.router_iact_1_1_south_address_in           (CG_0_1_router_iact_1_1_south_address_in        ),
	.router_iact_1_1_south_data_in_ready        (CG_0_1_router_iact_1_1_south_data_in_ready     ),
	.router_iact_1_1_south_data_in_valid        (CG_0_1_router_iact_1_1_south_data_in_valid     ),
	.router_iact_1_1_south_data_in              (CG_0_1_router_iact_1_1_south_data_in           ),
	.router_iact_1_1_horiz_address_in_ready     (CG_0_1_router_iact_1_1_horiz_address_in_ready  ),
	.router_iact_1_1_horiz_address_in_valid     (CG_0_1_router_iact_1_1_horiz_address_in_valid  ),
	.router_iact_1_1_horiz_address_in           (CG_0_1_router_iact_1_1_horiz_address_in        ),
	.router_iact_1_1_horiz_data_in_ready        (CG_0_1_router_iact_1_1_horiz_data_in_ready     ),
	.router_iact_1_1_horiz_data_in_valid        (CG_0_1_router_iact_1_1_horiz_data_in_valid     ),
	.router_iact_1_1_horiz_data_in              (CG_0_1_router_iact_1_1_horiz_data_in           ),
	.router_iact_1_1_north_address_out_ready	(CG_0_1_router_iact_1_1_north_address_out_ready	),
	.router_iact_1_1_north_address_out_valid    (CG_0_1_router_iact_1_1_north_address_out_valid ),
	.router_iact_1_1_north_address_out          (CG_0_1_router_iact_1_1_north_address_out       ),
	.router_iact_1_1_north_data_out_ready       (CG_0_1_router_iact_1_1_north_data_out_ready    ),
	.router_iact_1_1_north_data_out_valid       (CG_0_1_router_iact_1_1_north_data_out_valid    ),
	.router_iact_1_1_north_data_out             (CG_0_1_router_iact_1_1_north_data_out          ),
	.router_iact_1_1_south_address_out_ready    (CG_0_1_router_iact_1_1_south_address_out_ready ),
	.router_iact_1_1_south_address_out_valid    (CG_0_1_router_iact_1_1_south_address_out_valid ),
	.router_iact_1_1_south_address_out          (CG_0_1_router_iact_1_1_south_address_out       ),
	.router_iact_1_1_south_data_out_ready       (CG_0_1_router_iact_1_1_south_data_out_ready    ),
	.router_iact_1_1_south_data_out_valid       (CG_0_1_router_iact_1_1_south_data_out_valid    ),
	.router_iact_1_1_south_data_out             (CG_0_1_router_iact_1_1_south_data_out          ),
	.router_iact_1_1_horiz_address_out_ready    (CG_0_1_router_iact_1_1_horiz_address_out_ready ),
	.router_iact_1_1_horiz_address_out_valid    (CG_0_1_router_iact_1_1_horiz_address_out_valid ),
	.router_iact_1_1_horiz_address_out          (CG_0_1_router_iact_1_1_horiz_address_out       ),
	.router_iact_1_1_horiz_data_out_ready       (CG_0_1_router_iact_1_1_horiz_data_out_ready    ),
	.router_iact_1_1_horiz_data_out_valid       (CG_0_1_router_iact_1_1_horiz_data_out_valid    ),
	.router_iact_1_1_horiz_data_out             (CG_0_1_router_iact_1_1_horiz_data_out          ),
	.router_iact_1_2_north_address_in_ready     (CG_0_1_router_iact_1_2_north_address_in_ready  ),
	.router_iact_1_2_north_address_in_valid     (CG_0_1_router_iact_1_2_north_address_in_valid  ),
	.router_iact_1_2_north_address_in           (CG_0_1_router_iact_1_2_north_address_in        ),
	.router_iact_1_2_north_data_in_ready        (CG_0_1_router_iact_1_2_north_data_in_ready     ),
	.router_iact_1_2_north_data_in_valid        (CG_0_1_router_iact_1_2_north_data_in_valid     ),
	.router_iact_1_2_north_data_in              (CG_0_1_router_iact_1_2_north_data_in           ),
	.router_iact_1_2_south_address_in_ready     (CG_0_1_router_iact_1_2_south_address_in_ready  ),
	.router_iact_1_2_south_address_in_valid     (CG_0_1_router_iact_1_2_south_address_in_valid  ),
	.router_iact_1_2_south_address_in           (CG_0_1_router_iact_1_2_south_address_in        ),
	.router_iact_1_2_south_data_in_ready        (CG_0_1_router_iact_1_2_south_data_in_ready     ),
	.router_iact_1_2_south_data_in_valid        (CG_0_1_router_iact_1_2_south_data_in_valid     ),
	.router_iact_1_2_south_data_in              (CG_0_1_router_iact_1_2_south_data_in           ),
	.router_iact_1_2_horiz_address_in_ready     (CG_0_1_router_iact_1_2_horiz_address_in_ready  ),
	.router_iact_1_2_horiz_address_in_valid     (CG_0_1_router_iact_1_2_horiz_address_in_valid  ),
	.router_iact_1_2_horiz_address_in           (CG_0_1_router_iact_1_2_horiz_address_in        ),
	.router_iact_1_2_horiz_data_in_ready        (CG_0_1_router_iact_1_2_horiz_data_in_ready     ),
	.router_iact_1_2_horiz_data_in_valid        (CG_0_1_router_iact_1_2_horiz_data_in_valid     ),
	.router_iact_1_2_horiz_data_in              (CG_0_1_router_iact_1_2_horiz_data_in           ),
	.router_iact_1_2_north_address_out_ready	(CG_0_1_router_iact_1_2_north_address_out_ready	),
	.router_iact_1_2_north_address_out_valid    (CG_0_1_router_iact_1_2_north_address_out_valid ),
	.router_iact_1_2_north_address_out          (CG_0_1_router_iact_1_2_north_address_out       ),
	.router_iact_1_2_north_data_out_ready       (CG_0_1_router_iact_1_2_north_data_out_ready    ),
	.router_iact_1_2_north_data_out_valid       (CG_0_1_router_iact_1_2_north_data_out_valid    ),
	.router_iact_1_2_north_data_out             (CG_0_1_router_iact_1_2_north_data_out          ),
	.router_iact_1_2_south_address_out_ready    (CG_0_1_router_iact_1_2_south_address_out_ready ),
	.router_iact_1_2_south_address_out_valid    (CG_0_1_router_iact_1_2_south_address_out_valid ),
	.router_iact_1_2_south_address_out          (CG_0_1_router_iact_1_2_south_address_out       ),
	.router_iact_1_2_south_data_out_ready       (CG_0_1_router_iact_1_2_south_data_out_ready    ),
	.router_iact_1_2_south_data_out_valid       (CG_0_1_router_iact_1_2_south_data_out_valid    ),
	.router_iact_1_2_south_data_out             (CG_0_1_router_iact_1_2_south_data_out          ),
	.router_iact_1_2_horiz_address_out_ready    (CG_0_1_router_iact_1_2_horiz_address_out_ready ),
	.router_iact_1_2_horiz_address_out_valid    (CG_0_1_router_iact_1_2_horiz_address_out_valid ),
	.router_iact_1_2_horiz_address_out          (CG_0_1_router_iact_1_2_horiz_address_out       ),
	.router_iact_1_2_horiz_data_out_ready       (CG_0_1_router_iact_1_2_horiz_data_out_ready    ),
	.router_iact_1_2_horiz_data_out_valid       (CG_0_1_router_iact_1_2_horiz_data_out_valid    ),
	.router_iact_1_2_horiz_data_out             (CG_0_1_router_iact_1_2_horiz_data_out          ),
	.router_iact_2_0_north_address_in_ready     (CG_0_1_router_iact_2_0_north_address_in_ready  ),
	.router_iact_2_0_north_address_in_valid     (CG_0_1_router_iact_2_0_north_address_in_valid  ),
	.router_iact_2_0_north_address_in           (CG_0_1_router_iact_2_0_north_address_in        ),
	.router_iact_2_0_north_data_in_ready        (CG_0_1_router_iact_2_0_north_data_in_ready     ),
	.router_iact_2_0_north_data_in_valid        (CG_0_1_router_iact_2_0_north_data_in_valid     ),
	.router_iact_2_0_north_data_in              (CG_0_1_router_iact_2_0_north_data_in           ),
	.router_iact_2_0_south_address_in_ready     (CG_0_1_router_iact_2_0_south_address_in_ready  ),
	.router_iact_2_0_south_address_in_valid     (CG_0_1_router_iact_2_0_south_address_in_valid  ),
	.router_iact_2_0_south_address_in           (CG_0_1_router_iact_2_0_south_address_in        ),
	.router_iact_2_0_south_data_in_ready        (CG_0_1_router_iact_2_0_south_data_in_ready     ),
	.router_iact_2_0_south_data_in_valid        (CG_0_1_router_iact_2_0_south_data_in_valid     ),
	.router_iact_2_0_south_data_in              (CG_0_1_router_iact_2_0_south_data_in           ),
	.router_iact_2_0_horiz_address_in_ready     (CG_0_1_router_iact_2_0_horiz_address_in_ready  ),
	.router_iact_2_0_horiz_address_in_valid     (CG_0_1_router_iact_2_0_horiz_address_in_valid  ),
	.router_iact_2_0_horiz_address_in           (CG_0_1_router_iact_2_0_horiz_address_in        ),
	.router_iact_2_0_horiz_data_in_ready        (CG_0_1_router_iact_2_0_horiz_data_in_ready     ),
	.router_iact_2_0_horiz_data_in_valid        (CG_0_1_router_iact_2_0_horiz_data_in_valid     ),
	.router_iact_2_0_horiz_data_in              (CG_0_1_router_iact_2_0_horiz_data_in           ),
	.router_iact_2_0_north_address_out_ready	(CG_0_1_router_iact_2_0_north_address_out_ready	),
	.router_iact_2_0_north_address_out_valid    (CG_0_1_router_iact_2_0_north_address_out_valid ),
	.router_iact_2_0_north_address_out          (CG_0_1_router_iact_2_0_north_address_out       ),
	.router_iact_2_0_north_data_out_ready       (CG_0_1_router_iact_2_0_north_data_out_ready    ),
	.router_iact_2_0_north_data_out_valid       (CG_0_1_router_iact_2_0_north_data_out_valid    ),
	.router_iact_2_0_north_data_out             (CG_0_1_router_iact_2_0_north_data_out          ),
	.router_iact_2_0_south_address_out_ready    (CG_0_1_router_iact_2_0_south_address_out_ready ),
	.router_iact_2_0_south_address_out_valid    (CG_0_1_router_iact_2_0_south_address_out_valid ),
	.router_iact_2_0_south_address_out          (CG_0_1_router_iact_2_0_south_address_out       ),
	.router_iact_2_0_south_data_out_ready       (CG_0_1_router_iact_2_0_south_data_out_ready    ),
	.router_iact_2_0_south_data_out_valid       (CG_0_1_router_iact_2_0_south_data_out_valid    ),
	.router_iact_2_0_south_data_out             (CG_0_1_router_iact_2_0_south_data_out          ),
	.router_iact_2_0_horiz_address_out_ready    (CG_0_1_router_iact_2_0_horiz_address_out_ready ),
	.router_iact_2_0_horiz_address_out_valid    (CG_0_1_router_iact_2_0_horiz_address_out_valid ),
	.router_iact_2_0_horiz_address_out          (CG_0_1_router_iact_2_0_horiz_address_out       ),
	.router_iact_2_0_horiz_data_out_ready       (CG_0_1_router_iact_2_0_horiz_data_out_ready    ),
	.router_iact_2_0_horiz_data_out_valid       (CG_0_1_router_iact_2_0_horiz_data_out_valid    ),
	.router_iact_2_0_horiz_data_out             (CG_0_1_router_iact_2_0_horiz_data_out          ),
	.router_iact_2_1_north_address_in_ready     (CG_0_1_router_iact_2_1_north_address_in_ready  ),
	.router_iact_2_1_north_address_in_valid     (CG_0_1_router_iact_2_1_north_address_in_valid  ),
	.router_iact_2_1_north_address_in           (CG_0_1_router_iact_2_1_north_address_in        ),
	.router_iact_2_1_north_data_in_ready        (CG_0_1_router_iact_2_1_north_data_in_ready     ),
	.router_iact_2_1_north_data_in_valid        (CG_0_1_router_iact_2_1_north_data_in_valid     ),
	.router_iact_2_1_north_data_in              (CG_0_1_router_iact_2_1_north_data_in           ),
	.router_iact_2_1_south_address_in_ready     (CG_0_1_router_iact_2_1_south_address_in_ready  ),
	.router_iact_2_1_south_address_in_valid     (CG_0_1_router_iact_2_1_south_address_in_valid  ),
	.router_iact_2_1_south_address_in           (CG_0_1_router_iact_2_1_south_address_in        ),
	.router_iact_2_1_south_data_in_ready        (CG_0_1_router_iact_2_1_south_data_in_ready     ),
	.router_iact_2_1_south_data_in_valid        (CG_0_1_router_iact_2_1_south_data_in_valid     ),
	.router_iact_2_1_south_data_in              (CG_0_1_router_iact_2_1_south_data_in           ),
	.router_iact_2_1_horiz_address_in_ready     (CG_0_1_router_iact_2_1_horiz_address_in_ready  ),
	.router_iact_2_1_horiz_address_in_valid     (CG_0_1_router_iact_2_1_horiz_address_in_valid  ),
	.router_iact_2_1_horiz_address_in           (CG_0_1_router_iact_2_1_horiz_address_in        ),
	.router_iact_2_1_horiz_data_in_ready        (CG_0_1_router_iact_2_1_horiz_data_in_ready     ),
	.router_iact_2_1_horiz_data_in_valid        (CG_0_1_router_iact_2_1_horiz_data_in_valid     ),
	.router_iact_2_1_horiz_data_in              (CG_0_1_router_iact_2_1_horiz_data_in           ),
	.router_iact_2_1_north_address_out_ready	(CG_0_1_router_iact_2_1_north_address_out_ready	),
	.router_iact_2_1_north_address_out_valid    (CG_0_1_router_iact_2_1_north_address_out_valid ),
	.router_iact_2_1_north_address_out          (CG_0_1_router_iact_2_1_north_address_out       ),
	.router_iact_2_1_north_data_out_ready       (CG_0_1_router_iact_2_1_north_data_out_ready    ),
	.router_iact_2_1_north_data_out_valid       (CG_0_1_router_iact_2_1_north_data_out_valid    ),
	.router_iact_2_1_north_data_out             (CG_0_1_router_iact_2_1_north_data_out          ),
	.router_iact_2_1_south_address_out_ready    (CG_0_1_router_iact_2_1_south_address_out_ready ),
	.router_iact_2_1_south_address_out_valid    (CG_0_1_router_iact_2_1_south_address_out_valid ),
	.router_iact_2_1_south_address_out          (CG_0_1_router_iact_2_1_south_address_out       ),
	.router_iact_2_1_south_data_out_ready       (CG_0_1_router_iact_2_1_south_data_out_ready    ),
	.router_iact_2_1_south_data_out_valid       (CG_0_1_router_iact_2_1_south_data_out_valid    ),
	.router_iact_2_1_south_data_out             (CG_0_1_router_iact_2_1_south_data_out          ),
	.router_iact_2_1_horiz_address_out_ready    (CG_0_1_router_iact_2_1_horiz_address_out_ready ),
	.router_iact_2_1_horiz_address_out_valid    (CG_0_1_router_iact_2_1_horiz_address_out_valid ),
	.router_iact_2_1_horiz_address_out          (CG_0_1_router_iact_2_1_horiz_address_out       ),
	.router_iact_2_1_horiz_data_out_ready       (CG_0_1_router_iact_2_1_horiz_data_out_ready    ),
	.router_iact_2_1_horiz_data_out_valid       (CG_0_1_router_iact_2_1_horiz_data_out_valid    ),
	.router_iact_2_1_horiz_data_out             (CG_0_1_router_iact_2_1_horiz_data_out          ),
	.router_iact_2_2_north_address_in_ready     (CG_0_1_router_iact_2_2_north_address_in_ready  ),
	.router_iact_2_2_north_address_in_valid     (CG_0_1_router_iact_2_2_north_address_in_valid  ),
	.router_iact_2_2_north_address_in           (CG_0_1_router_iact_2_2_north_address_in        ),
	.router_iact_2_2_north_data_in_ready        (CG_0_1_router_iact_2_2_north_data_in_ready     ),
	.router_iact_2_2_north_data_in_valid        (CG_0_1_router_iact_2_2_north_data_in_valid     ),
	.router_iact_2_2_north_data_in              (CG_0_1_router_iact_2_2_north_data_in           ),
	.router_iact_2_2_south_address_in_ready     (CG_0_1_router_iact_2_2_south_address_in_ready  ),
	.router_iact_2_2_south_address_in_valid     (CG_0_1_router_iact_2_2_south_address_in_valid  ),
	.router_iact_2_2_south_address_in           (CG_0_1_router_iact_2_2_south_address_in        ),
	.router_iact_2_2_south_data_in_ready        (CG_0_1_router_iact_2_2_south_data_in_ready     ),
	.router_iact_2_2_south_data_in_valid        (CG_0_1_router_iact_2_2_south_data_in_valid     ),
	.router_iact_2_2_south_data_in              (CG_0_1_router_iact_2_2_south_data_in           ),
	.router_iact_2_2_horiz_address_in_ready     (CG_0_1_router_iact_2_2_horiz_address_in_ready  ),
	.router_iact_2_2_horiz_address_in_valid     (CG_0_1_router_iact_2_2_horiz_address_in_valid  ),
	.router_iact_2_2_horiz_address_in           (CG_0_1_router_iact_2_2_horiz_address_in        ),
	.router_iact_2_2_horiz_data_in_ready        (CG_0_1_router_iact_2_2_horiz_data_in_ready     ),
	.router_iact_2_2_horiz_data_in_valid        (CG_0_1_router_iact_2_2_horiz_data_in_valid     ),
	.router_iact_2_2_horiz_data_in              (CG_0_1_router_iact_2_2_horiz_data_in           ),
	.router_iact_2_2_north_address_out_ready	(CG_0_1_router_iact_2_2_north_address_out_ready	),
	.router_iact_2_2_north_address_out_valid    (CG_0_1_router_iact_2_2_north_address_out_valid ),
	.router_iact_2_2_north_address_out          (CG_0_1_router_iact_2_2_north_address_out       ),
	.router_iact_2_2_north_data_out_ready       (CG_0_1_router_iact_2_2_north_data_out_ready    ),
	.router_iact_2_2_north_data_out_valid       (CG_0_1_router_iact_2_2_north_data_out_valid    ),
	.router_iact_2_2_north_data_out             (CG_0_1_router_iact_2_2_north_data_out          ),
	.router_iact_2_2_south_address_out_ready    (CG_0_1_router_iact_2_2_south_address_out_ready ),
	.router_iact_2_2_south_address_out_valid    (CG_0_1_router_iact_2_2_south_address_out_valid ),
	.router_iact_2_2_south_address_out          (CG_0_1_router_iact_2_2_south_address_out       ),
	.router_iact_2_2_south_data_out_ready       (CG_0_1_router_iact_2_2_south_data_out_ready    ),
	.router_iact_2_2_south_data_out_valid       (CG_0_1_router_iact_2_2_south_data_out_valid    ),
	.router_iact_2_2_south_data_out             (CG_0_1_router_iact_2_2_south_data_out          ),
	.router_iact_2_2_horiz_address_out_ready    (CG_0_1_router_iact_2_2_horiz_address_out_ready ),
	.router_iact_2_2_horiz_address_out_valid    (CG_0_1_router_iact_2_2_horiz_address_out_valid ),
	.router_iact_2_2_horiz_address_out          (CG_0_1_router_iact_2_2_horiz_address_out       ),
	.router_iact_2_2_horiz_data_out_ready       (CG_0_1_router_iact_2_2_horiz_data_out_ready    ),
	.router_iact_2_2_horiz_data_out_valid       (CG_0_1_router_iact_2_2_horiz_data_out_valid    ),
	.router_iact_2_2_horiz_data_out             (CG_0_1_router_iact_2_2_horiz_data_out          ),
												
	.router_weight_0_horiz_address_in_ready     (CG_0_1_router_weight_0_horiz_address_in_ready  ),
	.router_weight_0_horiz_address_in_valid     (CG_0_1_router_weight_0_horiz_address_in_valid  ),
	.router_weight_0_horiz_address_in           (CG_0_1_router_weight_0_horiz_address_in        ),
	.router_weight_0_horiz_data_in_ready        (CG_0_1_router_weight_0_horiz_data_in_ready     ),
	.router_weight_0_horiz_data_in_valid        (CG_0_1_router_weight_0_horiz_data_in_valid     ),
	.router_weight_0_horiz_data_in              (CG_0_1_router_weight_0_horiz_data_in           ),
	.router_weight_0_horiz_address_out_ready    (CG_0_1_router_weight_0_horiz_address_out_ready ),
	.router_weight_0_horiz_address_out_valid    (CG_0_1_router_weight_0_horiz_address_out_valid ),
	.router_weight_0_horiz_address_out          (CG_0_1_router_weight_0_horiz_address_out       ),
	.router_weight_0_horiz_data_out_ready       (CG_0_1_router_weight_0_horiz_data_out_ready    ),
	.router_weight_0_horiz_data_out_valid       (CG_0_1_router_weight_0_horiz_data_out_valid    ),
	.router_weight_0_horiz_data_out             (CG_0_1_router_weight_0_horiz_data_out          ),
	.router_weight_1_horiz_address_in_ready     (CG_0_1_router_weight_1_horiz_address_in_ready  ),
	.router_weight_1_horiz_address_in_valid     (CG_0_1_router_weight_1_horiz_address_in_valid  ),
	.router_weight_1_horiz_address_in           (CG_0_1_router_weight_1_horiz_address_in        ),
	.router_weight_1_horiz_data_in_ready        (CG_0_1_router_weight_1_horiz_data_in_ready     ),
	.router_weight_1_horiz_data_in_valid        (CG_0_1_router_weight_1_horiz_data_in_valid     ),
	.router_weight_1_horiz_data_in              (CG_0_1_router_weight_1_horiz_data_in           ),
	.router_weight_1_horiz_address_out_ready    (CG_0_1_router_weight_1_horiz_address_out_ready ),
	.router_weight_1_horiz_address_out_valid    (CG_0_1_router_weight_1_horiz_address_out_valid ),
	.router_weight_1_horiz_address_out          (CG_0_1_router_weight_1_horiz_address_out       ),
	.router_weight_1_horiz_data_out_ready       (CG_0_1_router_weight_1_horiz_data_out_ready    ),
	.router_weight_1_horiz_data_out_valid       (CG_0_1_router_weight_1_horiz_data_out_valid    ),
	.router_weight_1_horiz_data_out             (CG_0_1_router_weight_1_horiz_data_out          ),
	.router_weight_2_horiz_address_in_ready     (CG_0_1_router_weight_2_horiz_address_in_ready  ),
	.router_weight_2_horiz_address_in_valid     (CG_0_1_router_weight_2_horiz_address_in_valid  ),
	.router_weight_2_horiz_address_in           (CG_0_1_router_weight_2_horiz_address_in        ),
	.router_weight_2_horiz_data_in_ready        (CG_0_1_router_weight_2_horiz_data_in_ready     ),
	.router_weight_2_horiz_data_in_valid        (CG_0_1_router_weight_2_horiz_data_in_valid     ),
	.router_weight_2_horiz_data_in              (CG_0_1_router_weight_2_horiz_data_in           ),
	.router_weight_2_horiz_address_out_ready    (CG_0_1_router_weight_2_horiz_address_out_ready ),
	.router_weight_2_horiz_address_out_valid    (CG_0_1_router_weight_2_horiz_address_out_valid ),
	.router_weight_2_horiz_address_out          (CG_0_1_router_weight_2_horiz_address_out       ),
	.router_weight_2_horiz_data_out_ready       (CG_0_1_router_weight_2_horiz_data_out_ready    ),
	.router_weight_2_horiz_data_out_valid       (CG_0_1_router_weight_2_horiz_data_out_valid    ),
	.router_weight_2_horiz_data_out             (CG_0_1_router_weight_2_horiz_data_out          ),
												
	.router_psum_0_north_in_ready               (CG_0_1_router_psum_0_north_in_ready            ),
	.router_psum_0_north_in_valid               (CG_0_1_router_psum_0_north_in_valid            ),
	.router_psum_0_north_in                     (CG_0_1_router_psum_0_north_in                  ),
	.router_psum_0_south_out_ready              (CG_0_1_router_psum_0_south_out_ready           ),
	.router_psum_0_south_out_valid              (CG_0_1_router_psum_0_south_out_valid           ),
	.router_psum_0_south_out                    (CG_0_1_router_psum_0_south_out                 ),
	.router_psum_1_north_in_ready               (CG_0_1_router_psum_1_north_in_ready            ),
	.router_psum_1_north_in_valid               (CG_0_1_router_psum_1_north_in_valid            ),
	.router_psum_1_north_in                     (CG_0_1_router_psum_1_north_in                  ),
	.router_psum_1_south_out_ready              (CG_0_1_router_psum_1_south_out_ready           ),
	.router_psum_1_south_out_valid              (CG_0_1_router_psum_1_south_out_valid           ),
	.router_psum_1_south_out                    (CG_0_1_router_psum_1_south_out                 ),
	.router_psum_2_north_in_ready               (CG_0_1_router_psum_2_north_in_ready            ),
	.router_psum_2_north_in_valid               (CG_0_1_router_psum_2_north_in_valid            ),
	.router_psum_2_north_in                     (CG_0_1_router_psum_2_north_in                  ),
	.router_psum_2_south_out_ready              (CG_0_1_router_psum_2_south_out_ready           ),
	.router_psum_2_south_out_valid              (CG_0_1_router_psum_2_south_out_valid           ),
	.router_psum_2_south_out                    (CG_0_1_router_psum_2_south_out                 ),
												 					
	.cg_south_psum_0_in_ready                   (CG_0_1_cg_south_psum_0_in_ready                ),
	.cg_south_psum_0_in_valid                   (CG_0_1_cg_south_psum_0_in_valid                ),
	.cg_south_psum_0_in                         (CG_0_1_cg_south_psum_0_in                      ),
	.cg_south_psum_1_in_ready                   (CG_0_1_cg_south_psum_1_in_ready                ),
	.cg_south_psum_1_in_valid                   (CG_0_1_cg_south_psum_1_in_valid                ),
	.cg_south_psum_1_in                         (CG_0_1_cg_south_psum_1_in                      ),
	.cg_south_psum_2_in_ready                   (CG_0_1_cg_south_psum_2_in_ready                ),
	.cg_south_psum_2_in_valid                   (CG_0_1_cg_south_psum_2_in_valid                ),
	.cg_south_psum_2_in                         (CG_0_1_cg_south_psum_2_in                      ),
	.cg_north_psum_0_out_ready                  (CG_0_1_cg_north_psum_0_out_ready               ),
	.cg_north_psum_0_out_valid                  (CG_0_1_cg_north_psum_0_out_valid               ),
	.cg_north_psum_0_out                        (CG_0_1_cg_north_psum_0_out                     ),
	.cg_north_psum_1_out_ready                  (CG_0_1_cg_north_psum_1_out_ready               ),
	.cg_north_psum_1_out_valid                  (CG_0_1_cg_north_psum_1_out_valid               ),
	.cg_north_psum_1_out                        (CG_0_1_cg_north_psum_1_out                     ),
	.cg_north_psum_2_out_ready                  (CG_0_1_cg_north_psum_2_out_ready               ),
	.cg_north_psum_2_out_valid                  (CG_0_1_cg_north_psum_2_out_valid               ),
	.cg_north_psum_2_out                        (CG_0_1_cg_north_psum_2_out                     ),
									         
	.PSUM_DEPTH                                 (CG_0_1_PSUM_DEPTH                              ),
	.psum_spad_clear                            (CG_0_1_psum_spad_clear                         ),
											
	.iact_write_fin_clear                       (CG_0_1_iact_write_fin_clear                	),
	.weight_write_fin_clear						(CG_0_1_weight_write_fin_clear					)
);



ClusterGroup ClusterGroup_1_0 (
	.clock										(CG_1_0_clock									),
	.reset										(CG_1_0_reset									),
											   					
	.PE_cluster_iact_data_in_sel                (CG_1_0_PE_cluster_iact_data_in_sel             ),
	.PE_cluster_iact_data_out_sel               (CG_1_0_PE_cluster_iact_data_out_sel            ),
	.PE_cluster_psum_data_in_sel                (CG_1_0_PE_cluster_psum_data_in_sel             ),
									            			
	.router_cluster_iact_data_in_sel            (CG_1_0_router_cluster_iact_data_in_sel         ),
	.router_cluster_iact_data_out_sel           (CG_1_0_router_cluster_iact_data_out_sel        ),
	.router_cluster_weight_data_in_sel          (CG_1_0_router_cluster_weight_data_in_sel       ),
	.router_cluster_weight_data_out_sel         (CG_1_0_router_cluster_weight_data_out_sel      ),
	.router_cluster_psum_data_in_sel            (CG_1_0_router_cluster_psum_data_in_sel         ),
	.router_cluster_psum_data_out_sel           (CG_1_0_router_cluster_psum_data_out_sel        ),
							                    
	.read_psum_en                               (CG_1_0_read_psum_en                            ),
	.cal_fin                                    (CG_1_0_cal_fin                                 ),
	.cg_en                                      (CG_1_0_cg_en                                   ),
	.PE_weight_load_en                          (CG_1_0_PE_weight_load_en                       ),
	.GLB_iact_load_en                           (CG_1_0_GLB_iact_load_en                        ),
	.src_GLB_load_fin							(CG_1_0_src_GLB_load_fin						),
	.all_cal_fin								(CG_1_0_all_cal_fin								),
	.psum_acc_en								(CG_1_0_psum_acc_en								),
	.psum_acc_fin								(CG_1_0_psum_acc_fin							),
	.GLB_psum_write_en							(CG_1_0_GLB_psum_write_en						),
	.psum_SRAM_Bank_0_read_out_en				(CG_1_0_psum_SRAM_Bank_0_read_out_en			),
	.psum_SRAM_Bank_1_read_out_en				(CG_1_0_psum_SRAM_Bank_1_read_out_en			),
	.psum_SRAM_Bank_2_read_out_en				(CG_1_0_psum_SRAM_Bank_2_read_out_en			),
	
	.PE_0_0_disable								(CG_1_0_PE_0_0_disable							),
	.PE_0_1_disable								(CG_1_0_PE_0_1_disable							),
	.PE_0_2_disable								(CG_1_0_PE_0_2_disable							),
	.PE_1_0_disable								(CG_1_0_PE_1_0_disable							),
	.PE_1_1_disable								(CG_1_0_PE_1_1_disable							),
	.PE_1_2_disable								(CG_1_0_PE_1_2_disable							),
	.PE_2_0_disable								(CG_1_0_PE_2_0_disable							),
	.PE_2_1_disable								(CG_1_0_PE_2_1_disable							),
	.PE_2_2_disable								(CG_1_0_PE_2_2_disable							),
							                   
	.GLB_iact_0_0_read_addr                     (CG_1_0_GLB_iact_0_0_read_addr                  ),
	.GLB_iact_0_1_read_addr                     (CG_1_0_GLB_iact_0_1_read_addr                  ),
	.GLB_iact_0_2_read_addr                     (CG_1_0_GLB_iact_0_2_read_addr                  ),
	.GLB_iact_1_0_read_addr                     (CG_1_0_GLB_iact_1_0_read_addr                  ),
	.GLB_iact_1_1_read_addr                     (CG_1_0_GLB_iact_1_1_read_addr                  ),
	.GLB_iact_1_2_read_addr                     (CG_1_0_GLB_iact_1_2_read_addr                  ),
	.GLB_iact_2_0_read_addr                     (CG_1_0_GLB_iact_2_0_read_addr                  ),
	.GLB_iact_2_1_read_addr                     (CG_1_0_GLB_iact_2_1_read_addr                  ),
	.GLB_iact_2_2_read_addr                     (CG_1_0_GLB_iact_2_2_read_addr                  ),
							                    
	.GLB_psum_0_write_addr                      (CG_1_0_GLB_psum_0_write_addr                   ),
	.GLB_psum_1_write_addr                      (CG_1_0_GLB_psum_1_write_addr                   ),
	.GLB_psum_2_write_addr                      (CG_1_0_GLB_psum_2_write_addr                   ),
	.GLB_psum_0_read_addr                       (CG_1_0_GLB_psum_0_read_addr                    ),
	.GLB_psum_1_read_addr                       (CG_1_0_GLB_psum_1_read_addr                    ),
	.GLB_psum_2_read_addr                       (CG_1_0_GLB_psum_2_read_addr                    ),
								               
	.GLB_iact_0_0_address_in_ready              (CG_1_0_GLB_iact_0_0_address_in_ready           ),
	.GLB_iact_0_0_address_in_valid              (CG_1_0_GLB_iact_0_0_address_in_valid           ),
	.GLB_iact_0_0_address_in                    (CG_1_0_GLB_iact_0_0_address_in                 ),
	.GLB_iact_0_0_data_in_ready                 (CG_1_0_GLB_iact_0_0_data_in_ready              ),
	.GLB_iact_0_0_data_in_valid                 (CG_1_0_GLB_iact_0_0_data_in_valid              ),
	.GLB_iact_0_0_data_in                       (CG_1_0_GLB_iact_0_0_data_in                    ),
	.GLB_iact_0_1_address_in_ready              (CG_1_0_GLB_iact_0_1_address_in_ready           ),
	.GLB_iact_0_1_address_in_valid              (CG_1_0_GLB_iact_0_1_address_in_valid           ),
	.GLB_iact_0_1_address_in                    (CG_1_0_GLB_iact_0_1_address_in                 ),
	.GLB_iact_0_1_data_in_ready                 (CG_1_0_GLB_iact_0_1_data_in_ready              ),
	.GLB_iact_0_1_data_in_valid                 (CG_1_0_GLB_iact_0_1_data_in_valid              ),
	.GLB_iact_0_1_data_in                       (CG_1_0_GLB_iact_0_1_data_in                    ),
	.GLB_iact_0_2_address_in_ready              (CG_1_0_GLB_iact_0_2_address_in_ready           ),
	.GLB_iact_0_2_address_in_valid              (CG_1_0_GLB_iact_0_2_address_in_valid           ),
	.GLB_iact_0_2_address_in                    (CG_1_0_GLB_iact_0_2_address_in                 ),
	.GLB_iact_0_2_data_in_ready                 (CG_1_0_GLB_iact_0_2_data_in_ready              ),
	.GLB_iact_0_2_data_in_valid                 (CG_1_0_GLB_iact_0_2_data_in_valid              ),
	.GLB_iact_0_2_data_in                       (CG_1_0_GLB_iact_0_2_data_in                    ),
	.GLB_iact_1_0_address_in_ready              (CG_1_0_GLB_iact_1_0_address_in_ready           ),
	.GLB_iact_1_0_address_in_valid              (CG_1_0_GLB_iact_1_0_address_in_valid           ),
	.GLB_iact_1_0_address_in                    (CG_1_0_GLB_iact_1_0_address_in                 ),
	.GLB_iact_1_0_data_in_ready                 (CG_1_0_GLB_iact_1_0_data_in_ready              ),
	.GLB_iact_1_0_data_in_valid                 (CG_1_0_GLB_iact_1_0_data_in_valid              ),
	.GLB_iact_1_0_data_in                       (CG_1_0_GLB_iact_1_0_data_in                    ),
	.GLB_iact_1_1_address_in_ready              (CG_1_0_GLB_iact_1_1_address_in_ready           ),
	.GLB_iact_1_1_address_in_valid              (CG_1_0_GLB_iact_1_1_address_in_valid           ),
	.GLB_iact_1_1_address_in                    (CG_1_0_GLB_iact_1_1_address_in                 ),
	.GLB_iact_1_1_data_in_ready                 (CG_1_0_GLB_iact_1_1_data_in_ready              ),
	.GLB_iact_1_1_data_in_valid                 (CG_1_0_GLB_iact_1_1_data_in_valid              ),
	.GLB_iact_1_1_data_in                       (CG_1_0_GLB_iact_1_1_data_in                    ),
	.GLB_iact_1_2_address_in_ready              (CG_1_0_GLB_iact_1_2_address_in_ready           ),
	.GLB_iact_1_2_address_in_valid              (CG_1_0_GLB_iact_1_2_address_in_valid           ),
	.GLB_iact_1_2_address_in                    (CG_1_0_GLB_iact_1_2_address_in                 ),
	.GLB_iact_1_2_data_in_ready                 (CG_1_0_GLB_iact_1_2_data_in_ready              ),
	.GLB_iact_1_2_data_in_valid                 (CG_1_0_GLB_iact_1_2_data_in_valid              ),
	.GLB_iact_1_2_data_in                       (CG_1_0_GLB_iact_1_2_data_in                    ),
	.GLB_iact_2_0_address_in_ready              (CG_1_0_GLB_iact_2_0_address_in_ready           ),
	.GLB_iact_2_0_address_in_valid              (CG_1_0_GLB_iact_2_0_address_in_valid           ),
	.GLB_iact_2_0_address_in                    (CG_1_0_GLB_iact_2_0_address_in                 ),
	.GLB_iact_2_0_data_in_ready                 (CG_1_0_GLB_iact_2_0_data_in_ready              ),
	.GLB_iact_2_0_data_in_valid                 (CG_1_0_GLB_iact_2_0_data_in_valid              ),
	.GLB_iact_2_0_data_in                       (CG_1_0_GLB_iact_2_0_data_in                    ),
	.GLB_iact_2_1_address_in_ready              (CG_1_0_GLB_iact_2_1_address_in_ready           ),
	.GLB_iact_2_1_address_in_valid              (CG_1_0_GLB_iact_2_1_address_in_valid           ),
	.GLB_iact_2_1_address_in                    (CG_1_0_GLB_iact_2_1_address_in                 ),
	.GLB_iact_2_1_data_in_ready                 (CG_1_0_GLB_iact_2_1_data_in_ready              ),
	.GLB_iact_2_1_data_in_valid                 (CG_1_0_GLB_iact_2_1_data_in_valid              ),
	.GLB_iact_2_1_data_in                       (CG_1_0_GLB_iact_2_1_data_in                    ),
	.GLB_iact_2_2_address_in_ready              (CG_1_0_GLB_iact_2_2_address_in_ready           ),
	.GLB_iact_2_2_address_in_valid              (CG_1_0_GLB_iact_2_2_address_in_valid           ),
	.GLB_iact_2_2_address_in                    (CG_1_0_GLB_iact_2_2_address_in                 ),
	.GLB_iact_2_2_data_in_ready                 (CG_1_0_GLB_iact_2_2_data_in_ready              ),
	.GLB_iact_2_2_data_in_valid                 (CG_1_0_GLB_iact_2_2_data_in_valid              ),
	.GLB_iact_2_2_data_in                       (CG_1_0_GLB_iact_2_2_data_in                    ),
										    						
	.GLB_weight_0_address_in_ready              (CG_1_0_GLB_weight_0_address_in_ready           ),
	.GLB_weight_0_address_in_valid              (CG_1_0_GLB_weight_0_address_in_valid           ),
	.GLB_weight_0_address_in                    (CG_1_0_GLB_weight_0_address_in                 ),
	.GLB_weight_0_data_in_ready                 (CG_1_0_GLB_weight_0_data_in_ready              ),
	.GLB_weight_0_data_in_valid                 (CG_1_0_GLB_weight_0_data_in_valid              ),
	.GLB_weight_0_data_in                       (CG_1_0_GLB_weight_0_data_in                    ),
	.GLB_weight_1_address_in_ready              (CG_1_0_GLB_weight_1_address_in_ready           ),
	.GLB_weight_1_address_in_valid	            (CG_1_0_GLB_weight_1_address_in_valid	     	),
	.GLB_weight_1_address_in                    (CG_1_0_GLB_weight_1_address_in                 ),
	.GLB_weight_1_data_in_ready                 (CG_1_0_GLB_weight_1_data_in_ready              ),
	.GLB_weight_1_data_in_valid                 (CG_1_0_GLB_weight_1_data_in_valid              ),
	.GLB_weight_1_data_in                       (CG_1_0_GLB_weight_1_data_in                    ),
	.GLB_weight_2_address_in_ready              (CG_1_0_GLB_weight_2_address_in_ready           ),
	.GLB_weight_2_address_in_valid              (CG_1_0_GLB_weight_2_address_in_valid           ),
	.GLB_weight_2_address_in                    (CG_1_0_GLB_weight_2_address_in                 ),
	.GLB_weight_2_data_in_ready                 (CG_1_0_GLB_weight_2_data_in_ready              ),
	.GLB_weight_2_data_in_valid                 (CG_1_0_GLB_weight_2_data_in_valid              ),
	.GLB_weight_2_data_in                       (CG_1_0_GLB_weight_2_data_in                    ),
										     
	.GLB_psum_0_data_in_ready                   (CG_1_0_GLB_psum_0_data_in_ready                ),
	.GLB_psum_0_data_in_valid                   (CG_1_0_GLB_psum_0_data_in_valid                ),
	.GLB_psum_0_data_in                         (CG_1_0_GLB_psum_0_data_in                      ),
	.GLB_psum_0_data_out_ready                  (CG_1_0_GLB_psum_0_data_out_ready               ),
	.GLB_psum_0_data_out_valid                  (CG_1_0_GLB_psum_0_data_out_valid               ),
	.GLB_psum_0_data_out                        (CG_1_0_GLB_psum_0_data_out                     ),
	.GLB_psum_1_data_in_ready                   (CG_1_0_GLB_psum_1_data_in_ready                ),
	.GLB_psum_1_data_in_valid                   (CG_1_0_GLB_psum_1_data_in_valid                ),
	.GLB_psum_1_data_in                         (CG_1_0_GLB_psum_1_data_in                      ),
	.GLB_psum_1_data_out_ready                  (CG_1_0_GLB_psum_1_data_out_ready               ),
	.GLB_psum_1_data_out_valid                  (CG_1_0_GLB_psum_1_data_out_valid               ),
	.GLB_psum_1_data_out                        (CG_1_0_GLB_psum_1_data_out                     ),
	.GLB_psum_2_data_in_ready                   (CG_1_0_GLB_psum_2_data_in_ready                ),
	.GLB_psum_2_data_in_valid                   (CG_1_0_GLB_psum_2_data_in_valid                ),
	.GLB_psum_2_data_in                         (CG_1_0_GLB_psum_2_data_in                      ),
	.GLB_psum_2_data_out_ready                  (CG_1_0_GLB_psum_2_data_out_ready               ),
	.GLB_psum_2_data_out_valid                  (CG_1_0_GLB_psum_2_data_out_valid               ),
	.GLB_psum_2_data_out                        (CG_1_0_GLB_psum_2_data_out                     ),
											
	.router_iact_0_0_north_address_in_ready		(CG_1_0_router_iact_0_0_north_address_in_ready	),
	.router_iact_0_0_north_address_in_valid     (CG_1_0_router_iact_0_0_north_address_in_valid  ),
	.router_iact_0_0_north_address_in           (CG_1_0_router_iact_0_0_north_address_in        ),
	.router_iact_0_0_north_data_in_ready        (CG_1_0_router_iact_0_0_north_data_in_ready     ),
	.router_iact_0_0_north_data_in_valid        (CG_1_0_router_iact_0_0_north_data_in_valid     ),
	.router_iact_0_0_north_data_in              (CG_1_0_router_iact_0_0_north_data_in           ),
	.router_iact_0_0_south_address_in_ready     (CG_1_0_router_iact_0_0_south_address_in_ready  ),
	.router_iact_0_0_south_address_in_valid     (CG_1_0_router_iact_0_0_south_address_in_valid  ),
	.router_iact_0_0_south_address_in           (CG_1_0_router_iact_0_0_south_address_in        ),
	.router_iact_0_0_south_data_in_ready        (CG_1_0_router_iact_0_0_south_data_in_ready     ),
	.router_iact_0_0_south_data_in_valid        (CG_1_0_router_iact_0_0_south_data_in_valid     ),
	.router_iact_0_0_south_data_in              (CG_1_0_router_iact_0_0_south_data_in           ),
	.router_iact_0_0_horiz_address_in_ready     (CG_1_0_router_iact_0_0_horiz_address_in_ready  ),
	.router_iact_0_0_horiz_address_in_valid     (CG_1_0_router_iact_0_0_horiz_address_in_valid  ),
	.router_iact_0_0_horiz_address_in           (CG_1_0_router_iact_0_0_horiz_address_in        ),
	.router_iact_0_0_horiz_data_in_ready        (CG_1_0_router_iact_0_0_horiz_data_in_ready     ),
	.router_iact_0_0_horiz_data_in_valid        (CG_1_0_router_iact_0_0_horiz_data_in_valid     ),
	.router_iact_0_0_horiz_data_in              (CG_1_0_router_iact_0_0_horiz_data_in           ),
	.router_iact_0_0_north_address_out_ready	(CG_1_0_router_iact_0_0_north_address_out_ready	),
	.router_iact_0_0_north_address_out_valid    (CG_1_0_router_iact_0_0_north_address_out_valid ),
	.router_iact_0_0_north_address_out          (CG_1_0_router_iact_0_0_north_address_out       ),
	.router_iact_0_0_north_data_out_ready       (CG_1_0_router_iact_0_0_north_data_out_ready    ),
	.router_iact_0_0_north_data_out_valid       (CG_1_0_router_iact_0_0_north_data_out_valid    ),
	.router_iact_0_0_north_data_out             (CG_1_0_router_iact_0_0_north_data_out          ),
	.router_iact_0_0_south_address_out_ready    (CG_1_0_router_iact_0_0_south_address_out_ready ),
	.router_iact_0_0_south_address_out_valid    (CG_1_0_router_iact_0_0_south_address_out_valid ),
	.router_iact_0_0_south_address_out          (CG_1_0_router_iact_0_0_south_address_out       ),
	.router_iact_0_0_south_data_out_ready       (CG_1_0_router_iact_0_0_south_data_out_ready    ),
	.router_iact_0_0_south_data_out_valid       (CG_1_0_router_iact_0_0_south_data_out_valid    ),
	.router_iact_0_0_south_data_out             (CG_1_0_router_iact_0_0_south_data_out          ),
	.router_iact_0_0_horiz_address_out_ready    (CG_1_0_router_iact_0_0_horiz_address_out_ready ),
	.router_iact_0_0_horiz_address_out_valid    (CG_1_0_router_iact_0_0_horiz_address_out_valid ),
	.router_iact_0_0_horiz_address_out          (CG_1_0_router_iact_0_0_horiz_address_out       ),
	.router_iact_0_0_horiz_data_out_ready       (CG_1_0_router_iact_0_0_horiz_data_out_ready    ),
	.router_iact_0_0_horiz_data_out_valid       (CG_1_0_router_iact_0_0_horiz_data_out_valid    ),
	.router_iact_0_0_horiz_data_out             (CG_1_0_router_iact_0_0_horiz_data_out          ),
	.router_iact_0_1_north_address_in_ready     (CG_1_0_router_iact_0_1_north_address_in_ready  ),
	.router_iact_0_1_north_address_in_valid     (CG_1_0_router_iact_0_1_north_address_in_valid  ),
	.router_iact_0_1_north_address_in           (CG_1_0_router_iact_0_1_north_address_in        ),
	.router_iact_0_1_north_data_in_ready        (CG_1_0_router_iact_0_1_north_data_in_ready     ),
	.router_iact_0_1_north_data_in_valid        (CG_1_0_router_iact_0_1_north_data_in_valid     ),
	.router_iact_0_1_north_data_in              (CG_1_0_router_iact_0_1_north_data_in           ),
	.router_iact_0_1_south_address_in_ready     (CG_1_0_router_iact_0_1_south_address_in_ready  ),
	.router_iact_0_1_south_address_in_valid     (CG_1_0_router_iact_0_1_south_address_in_valid  ),
	.router_iact_0_1_south_address_in           (CG_1_0_router_iact_0_1_south_address_in        ),
	.router_iact_0_1_south_data_in_ready        (CG_1_0_router_iact_0_1_south_data_in_ready     ),
	.router_iact_0_1_south_data_in_valid        (CG_1_0_router_iact_0_1_south_data_in_valid     ),
	.router_iact_0_1_south_data_in              (CG_1_0_router_iact_0_1_south_data_in           ),
	.router_iact_0_1_horiz_address_in_ready     (CG_1_0_router_iact_0_1_horiz_address_in_ready  ),
	.router_iact_0_1_horiz_address_in_valid     (CG_1_0_router_iact_0_1_horiz_address_in_valid  ),
	.router_iact_0_1_horiz_address_in           (CG_1_0_router_iact_0_1_horiz_address_in        ),
	.router_iact_0_1_horiz_data_in_ready        (CG_1_0_router_iact_0_1_horiz_data_in_ready     ),
	.router_iact_0_1_horiz_data_in_valid        (CG_1_0_router_iact_0_1_horiz_data_in_valid     ),
	.router_iact_0_1_horiz_data_in              (CG_1_0_router_iact_0_1_horiz_data_in           ),
	.router_iact_0_1_north_address_out_ready	(CG_1_0_router_iact_0_1_north_address_out_ready	),
	.router_iact_0_1_north_address_out_valid    (CG_1_0_router_iact_0_1_north_address_out_valid ),
	.router_iact_0_1_north_address_out          (CG_1_0_router_iact_0_1_north_address_out       ),
	.router_iact_0_1_north_data_out_ready       (CG_1_0_router_iact_0_1_north_data_out_ready    ),
	.router_iact_0_1_north_data_out_valid       (CG_1_0_router_iact_0_1_north_data_out_valid    ),
	.router_iact_0_1_north_data_out             (CG_1_0_router_iact_0_1_north_data_out          ),
	.router_iact_0_1_south_address_out_ready    (CG_1_0_router_iact_0_1_south_address_out_ready ),
	.router_iact_0_1_south_address_out_valid    (CG_1_0_router_iact_0_1_south_address_out_valid ),
	.router_iact_0_1_south_address_out          (CG_1_0_router_iact_0_1_south_address_out       ),
	.router_iact_0_1_south_data_out_ready       (CG_1_0_router_iact_0_1_south_data_out_ready    ),
	.router_iact_0_1_south_data_out_valid       (CG_1_0_router_iact_0_1_south_data_out_valid    ),
	.router_iact_0_1_south_data_out             (CG_1_0_router_iact_0_1_south_data_out          ),
	.router_iact_0_1_horiz_address_out_ready    (CG_1_0_router_iact_0_1_horiz_address_out_ready ),
	.router_iact_0_1_horiz_address_out_valid    (CG_1_0_router_iact_0_1_horiz_address_out_valid ),
	.router_iact_0_1_horiz_address_out          (CG_1_0_router_iact_0_1_horiz_address_out       ),
	.router_iact_0_1_horiz_data_out_ready       (CG_1_0_router_iact_0_1_horiz_data_out_ready    ),
	.router_iact_0_1_horiz_data_out_valid       (CG_1_0_router_iact_0_1_horiz_data_out_valid    ),
	.router_iact_0_1_horiz_data_out             (CG_1_0_router_iact_0_1_horiz_data_out          ),
	.router_iact_0_2_north_address_in_ready     (CG_1_0_router_iact_0_2_north_address_in_ready  ),
	.router_iact_0_2_north_address_in_valid     (CG_1_0_router_iact_0_2_north_address_in_valid  ),
	.router_iact_0_2_north_address_in           (CG_1_0_router_iact_0_2_north_address_in        ),
	.router_iact_0_2_north_data_in_ready        (CG_1_0_router_iact_0_2_north_data_in_ready     ),
	.router_iact_0_2_north_data_in_valid        (CG_1_0_router_iact_0_2_north_data_in_valid     ),
	.router_iact_0_2_north_data_in              (CG_1_0_router_iact_0_2_north_data_in           ),
	.router_iact_0_2_south_address_in_ready     (CG_1_0_router_iact_0_2_south_address_in_ready  ),
	.router_iact_0_2_south_address_in_valid     (CG_1_0_router_iact_0_2_south_address_in_valid  ),
	.router_iact_0_2_south_address_in           (CG_1_0_router_iact_0_2_south_address_in        ),
	.router_iact_0_2_south_data_in_ready        (CG_1_0_router_iact_0_2_south_data_in_ready     ),
	.router_iact_0_2_south_data_in_valid        (CG_1_0_router_iact_0_2_south_data_in_valid     ),
	.router_iact_0_2_south_data_in              (CG_1_0_router_iact_0_2_south_data_in           ),
	.router_iact_0_2_horiz_address_in_ready     (CG_1_0_router_iact_0_2_horiz_address_in_ready  ),
	.router_iact_0_2_horiz_address_in_valid     (CG_1_0_router_iact_0_2_horiz_address_in_valid  ),
	.router_iact_0_2_horiz_address_in           (CG_1_0_router_iact_0_2_horiz_address_in        ),
	.router_iact_0_2_horiz_data_in_ready        (CG_1_0_router_iact_0_2_horiz_data_in_ready     ),
	.router_iact_0_2_horiz_data_in_valid        (CG_1_0_router_iact_0_2_horiz_data_in_valid     ),
	.router_iact_0_2_horiz_data_in              (CG_1_0_router_iact_0_2_horiz_data_in           ),
	.router_iact_0_2_north_address_out_ready	(CG_1_0_router_iact_0_2_north_address_out_ready	),
	.router_iact_0_2_north_address_out_valid    (CG_1_0_router_iact_0_2_north_address_out_valid ),
	.router_iact_0_2_north_address_out          (CG_1_0_router_iact_0_2_north_address_out       ),
	.router_iact_0_2_north_data_out_ready       (CG_1_0_router_iact_0_2_north_data_out_ready    ),
	.router_iact_0_2_north_data_out_valid       (CG_1_0_router_iact_0_2_north_data_out_valid    ),
	.router_iact_0_2_north_data_out             (CG_1_0_router_iact_0_2_north_data_out          ),
	.router_iact_0_2_south_address_out_ready    (CG_1_0_router_iact_0_2_south_address_out_ready ),
	.router_iact_0_2_south_address_out_valid    (CG_1_0_router_iact_0_2_south_address_out_valid ),
	.router_iact_0_2_south_address_out          (CG_1_0_router_iact_0_2_south_address_out       ),
	.router_iact_0_2_south_data_out_ready       (CG_1_0_router_iact_0_2_south_data_out_ready    ),
	.router_iact_0_2_south_data_out_valid       (CG_1_0_router_iact_0_2_south_data_out_valid    ),
	.router_iact_0_2_south_data_out             (CG_1_0_router_iact_0_2_south_data_out          ),
	.router_iact_0_2_horiz_address_out_ready    (CG_1_0_router_iact_0_2_horiz_address_out_ready ),
	.router_iact_0_2_horiz_address_out_valid    (CG_1_0_router_iact_0_2_horiz_address_out_valid ),
	.router_iact_0_2_horiz_address_out          (CG_1_0_router_iact_0_2_horiz_address_out       ),
	.router_iact_0_2_horiz_data_out_ready       (CG_1_0_router_iact_0_2_horiz_data_out_ready    ),
	.router_iact_0_2_horiz_data_out_valid       (CG_1_0_router_iact_0_2_horiz_data_out_valid    ),
	.router_iact_0_2_horiz_data_out             (CG_1_0_router_iact_0_2_horiz_data_out          ),
	.router_iact_1_0_north_address_in_ready     (CG_1_0_router_iact_1_0_north_address_in_ready  ),
	.router_iact_1_0_north_address_in_valid     (CG_1_0_router_iact_1_0_north_address_in_valid  ),
	.router_iact_1_0_north_address_in           (CG_1_0_router_iact_1_0_north_address_in        ),
	.router_iact_1_0_north_data_in_ready        (CG_1_0_router_iact_1_0_north_data_in_ready     ),
	.router_iact_1_0_north_data_in_valid        (CG_1_0_router_iact_1_0_north_data_in_valid     ),
	.router_iact_1_0_north_data_in              (CG_1_0_router_iact_1_0_north_data_in           ),
	.router_iact_1_0_south_address_in_ready     (CG_1_0_router_iact_1_0_south_address_in_ready  ),
	.router_iact_1_0_south_address_in_valid     (CG_1_0_router_iact_1_0_south_address_in_valid  ),
	.router_iact_1_0_south_address_in           (CG_1_0_router_iact_1_0_south_address_in        ),
	.router_iact_1_0_south_data_in_ready        (CG_1_0_router_iact_1_0_south_data_in_ready     ),
	.router_iact_1_0_south_data_in_valid        (CG_1_0_router_iact_1_0_south_data_in_valid     ),
	.router_iact_1_0_south_data_in              (CG_1_0_router_iact_1_0_south_data_in           ),
	.router_iact_1_0_horiz_address_in_ready     (CG_1_0_router_iact_1_0_horiz_address_in_ready  ),
	.router_iact_1_0_horiz_address_in_valid     (CG_1_0_router_iact_1_0_horiz_address_in_valid  ),
	.router_iact_1_0_horiz_address_in           (CG_1_0_router_iact_1_0_horiz_address_in        ),
	.router_iact_1_0_horiz_data_in_ready        (CG_1_0_router_iact_1_0_horiz_data_in_ready     ),
	.router_iact_1_0_horiz_data_in_valid        (CG_1_0_router_iact_1_0_horiz_data_in_valid     ),
	.router_iact_1_0_horiz_data_in              (CG_1_0_router_iact_1_0_horiz_data_in           ),
	.router_iact_1_0_north_address_out_ready	(CG_1_0_router_iact_1_0_north_address_out_ready	),
	.router_iact_1_0_north_address_out_valid    (CG_1_0_router_iact_1_0_north_address_out_valid ),
	.router_iact_1_0_north_address_out          (CG_1_0_router_iact_1_0_north_address_out       ),
	.router_iact_1_0_north_data_out_ready       (CG_1_0_router_iact_1_0_north_data_out_ready    ),
	.router_iact_1_0_north_data_out_valid       (CG_1_0_router_iact_1_0_north_data_out_valid    ),
	.router_iact_1_0_north_data_out             (CG_1_0_router_iact_1_0_north_data_out          ),
	.router_iact_1_0_south_address_out_ready    (CG_1_0_router_iact_1_0_south_address_out_ready ),
	.router_iact_1_0_south_address_out_valid    (CG_1_0_router_iact_1_0_south_address_out_valid ),
	.router_iact_1_0_south_address_out          (CG_1_0_router_iact_1_0_south_address_out       ),
	.router_iact_1_0_south_data_out_ready       (CG_1_0_router_iact_1_0_south_data_out_ready    ),
	.router_iact_1_0_south_data_out_valid       (CG_1_0_router_iact_1_0_south_data_out_valid    ),
	.router_iact_1_0_south_data_out             (CG_1_0_router_iact_1_0_south_data_out          ),
	.router_iact_1_0_horiz_address_out_ready    (CG_1_0_router_iact_1_0_horiz_address_out_ready ),
	.router_iact_1_0_horiz_address_out_valid    (CG_1_0_router_iact_1_0_horiz_address_out_valid ),
	.router_iact_1_0_horiz_address_out          (CG_1_0_router_iact_1_0_horiz_address_out       ),
	.router_iact_1_0_horiz_data_out_ready       (CG_1_0_router_iact_1_0_horiz_data_out_ready    ),
	.router_iact_1_0_horiz_data_out_valid       (CG_1_0_router_iact_1_0_horiz_data_out_valid    ),
	.router_iact_1_0_horiz_data_out             (CG_1_0_router_iact_1_0_horiz_data_out          ),
	.router_iact_1_1_north_address_in_ready     (CG_1_0_router_iact_1_1_north_address_in_ready  ),
	.router_iact_1_1_north_address_in_valid     (CG_1_0_router_iact_1_1_north_address_in_valid  ),
	.router_iact_1_1_north_address_in           (CG_1_0_router_iact_1_1_north_address_in        ),
	.router_iact_1_1_north_data_in_ready        (CG_1_0_router_iact_1_1_north_data_in_ready     ),
	.router_iact_1_1_north_data_in_valid        (CG_1_0_router_iact_1_1_north_data_in_valid     ),
	.router_iact_1_1_north_data_in              (CG_1_0_router_iact_1_1_north_data_in           ),
	.router_iact_1_1_south_address_in_ready     (CG_1_0_router_iact_1_1_south_address_in_ready  ),
	.router_iact_1_1_south_address_in_valid     (CG_1_0_router_iact_1_1_south_address_in_valid  ),
	.router_iact_1_1_south_address_in           (CG_1_0_router_iact_1_1_south_address_in        ),
	.router_iact_1_1_south_data_in_ready        (CG_1_0_router_iact_1_1_south_data_in_ready     ),
	.router_iact_1_1_south_data_in_valid        (CG_1_0_router_iact_1_1_south_data_in_valid     ),
	.router_iact_1_1_south_data_in              (CG_1_0_router_iact_1_1_south_data_in           ),
	.router_iact_1_1_horiz_address_in_ready     (CG_1_0_router_iact_1_1_horiz_address_in_ready  ),
	.router_iact_1_1_horiz_address_in_valid     (CG_1_0_router_iact_1_1_horiz_address_in_valid  ),
	.router_iact_1_1_horiz_address_in           (CG_1_0_router_iact_1_1_horiz_address_in        ),
	.router_iact_1_1_horiz_data_in_ready        (CG_1_0_router_iact_1_1_horiz_data_in_ready     ),
	.router_iact_1_1_horiz_data_in_valid        (CG_1_0_router_iact_1_1_horiz_data_in_valid     ),
	.router_iact_1_1_horiz_data_in              (CG_1_0_router_iact_1_1_horiz_data_in           ),
	.router_iact_1_1_north_address_out_ready	(CG_1_0_router_iact_1_1_north_address_out_ready	),
	.router_iact_1_1_north_address_out_valid    (CG_1_0_router_iact_1_1_north_address_out_valid ),
	.router_iact_1_1_north_address_out          (CG_1_0_router_iact_1_1_north_address_out       ),
	.router_iact_1_1_north_data_out_ready       (CG_1_0_router_iact_1_1_north_data_out_ready    ),
	.router_iact_1_1_north_data_out_valid       (CG_1_0_router_iact_1_1_north_data_out_valid    ),
	.router_iact_1_1_north_data_out             (CG_1_0_router_iact_1_1_north_data_out          ),
	.router_iact_1_1_south_address_out_ready    (CG_1_0_router_iact_1_1_south_address_out_ready ),
	.router_iact_1_1_south_address_out_valid    (CG_1_0_router_iact_1_1_south_address_out_valid ),
	.router_iact_1_1_south_address_out          (CG_1_0_router_iact_1_1_south_address_out       ),
	.router_iact_1_1_south_data_out_ready       (CG_1_0_router_iact_1_1_south_data_out_ready    ),
	.router_iact_1_1_south_data_out_valid       (CG_1_0_router_iact_1_1_south_data_out_valid    ),
	.router_iact_1_1_south_data_out             (CG_1_0_router_iact_1_1_south_data_out          ),
	.router_iact_1_1_horiz_address_out_ready    (CG_1_0_router_iact_1_1_horiz_address_out_ready ),
	.router_iact_1_1_horiz_address_out_valid    (CG_1_0_router_iact_1_1_horiz_address_out_valid ),
	.router_iact_1_1_horiz_address_out          (CG_1_0_router_iact_1_1_horiz_address_out       ),
	.router_iact_1_1_horiz_data_out_ready       (CG_1_0_router_iact_1_1_horiz_data_out_ready    ),
	.router_iact_1_1_horiz_data_out_valid       (CG_1_0_router_iact_1_1_horiz_data_out_valid    ),
	.router_iact_1_1_horiz_data_out             (CG_1_0_router_iact_1_1_horiz_data_out          ),
	.router_iact_1_2_north_address_in_ready     (CG_1_0_router_iact_1_2_north_address_in_ready  ),
	.router_iact_1_2_north_address_in_valid     (CG_1_0_router_iact_1_2_north_address_in_valid  ),
	.router_iact_1_2_north_address_in           (CG_1_0_router_iact_1_2_north_address_in        ),
	.router_iact_1_2_north_data_in_ready        (CG_1_0_router_iact_1_2_north_data_in_ready     ),
	.router_iact_1_2_north_data_in_valid        (CG_1_0_router_iact_1_2_north_data_in_valid     ),
	.router_iact_1_2_north_data_in              (CG_1_0_router_iact_1_2_north_data_in           ),
	.router_iact_1_2_south_address_in_ready     (CG_1_0_router_iact_1_2_south_address_in_ready  ),
	.router_iact_1_2_south_address_in_valid     (CG_1_0_router_iact_1_2_south_address_in_valid  ),
	.router_iact_1_2_south_address_in           (CG_1_0_router_iact_1_2_south_address_in        ),
	.router_iact_1_2_south_data_in_ready        (CG_1_0_router_iact_1_2_south_data_in_ready     ),
	.router_iact_1_2_south_data_in_valid        (CG_1_0_router_iact_1_2_south_data_in_valid     ),
	.router_iact_1_2_south_data_in              (CG_1_0_router_iact_1_2_south_data_in           ),
	.router_iact_1_2_horiz_address_in_ready     (CG_1_0_router_iact_1_2_horiz_address_in_ready  ),
	.router_iact_1_2_horiz_address_in_valid     (CG_1_0_router_iact_1_2_horiz_address_in_valid  ),
	.router_iact_1_2_horiz_address_in           (CG_1_0_router_iact_1_2_horiz_address_in        ),
	.router_iact_1_2_horiz_data_in_ready        (CG_1_0_router_iact_1_2_horiz_data_in_ready     ),
	.router_iact_1_2_horiz_data_in_valid        (CG_1_0_router_iact_1_2_horiz_data_in_valid     ),
	.router_iact_1_2_horiz_data_in              (CG_1_0_router_iact_1_2_horiz_data_in           ),
	.router_iact_1_2_north_address_out_ready	(CG_1_0_router_iact_1_2_north_address_out_ready	),
	.router_iact_1_2_north_address_out_valid    (CG_1_0_router_iact_1_2_north_address_out_valid ),
	.router_iact_1_2_north_address_out          (CG_1_0_router_iact_1_2_north_address_out       ),
	.router_iact_1_2_north_data_out_ready       (CG_1_0_router_iact_1_2_north_data_out_ready    ),
	.router_iact_1_2_north_data_out_valid       (CG_1_0_router_iact_1_2_north_data_out_valid    ),
	.router_iact_1_2_north_data_out             (CG_1_0_router_iact_1_2_north_data_out          ),
	.router_iact_1_2_south_address_out_ready    (CG_1_0_router_iact_1_2_south_address_out_ready ),
	.router_iact_1_2_south_address_out_valid    (CG_1_0_router_iact_1_2_south_address_out_valid ),
	.router_iact_1_2_south_address_out          (CG_1_0_router_iact_1_2_south_address_out       ),
	.router_iact_1_2_south_data_out_ready       (CG_1_0_router_iact_1_2_south_data_out_ready    ),
	.router_iact_1_2_south_data_out_valid       (CG_1_0_router_iact_1_2_south_data_out_valid    ),
	.router_iact_1_2_south_data_out             (CG_1_0_router_iact_1_2_south_data_out          ),
	.router_iact_1_2_horiz_address_out_ready    (CG_1_0_router_iact_1_2_horiz_address_out_ready ),
	.router_iact_1_2_horiz_address_out_valid    (CG_1_0_router_iact_1_2_horiz_address_out_valid ),
	.router_iact_1_2_horiz_address_out          (CG_1_0_router_iact_1_2_horiz_address_out       ),
	.router_iact_1_2_horiz_data_out_ready       (CG_1_0_router_iact_1_2_horiz_data_out_ready    ),
	.router_iact_1_2_horiz_data_out_valid       (CG_1_0_router_iact_1_2_horiz_data_out_valid    ),
	.router_iact_1_2_horiz_data_out             (CG_1_0_router_iact_1_2_horiz_data_out          ),
	.router_iact_2_0_north_address_in_ready     (CG_1_0_router_iact_2_0_north_address_in_ready  ),
	.router_iact_2_0_north_address_in_valid     (CG_1_0_router_iact_2_0_north_address_in_valid  ),
	.router_iact_2_0_north_address_in           (CG_1_0_router_iact_2_0_north_address_in        ),
	.router_iact_2_0_north_data_in_ready        (CG_1_0_router_iact_2_0_north_data_in_ready     ),
	.router_iact_2_0_north_data_in_valid        (CG_1_0_router_iact_2_0_north_data_in_valid     ),
	.router_iact_2_0_north_data_in              (CG_1_0_router_iact_2_0_north_data_in           ),
	.router_iact_2_0_south_address_in_ready     (CG_1_0_router_iact_2_0_south_address_in_ready  ),
	.router_iact_2_0_south_address_in_valid     (CG_1_0_router_iact_2_0_south_address_in_valid  ),
	.router_iact_2_0_south_address_in           (CG_1_0_router_iact_2_0_south_address_in        ),
	.router_iact_2_0_south_data_in_ready        (CG_1_0_router_iact_2_0_south_data_in_ready     ),
	.router_iact_2_0_south_data_in_valid        (CG_1_0_router_iact_2_0_south_data_in_valid     ),
	.router_iact_2_0_south_data_in              (CG_1_0_router_iact_2_0_south_data_in           ),
	.router_iact_2_0_horiz_address_in_ready     (CG_1_0_router_iact_2_0_horiz_address_in_ready  ),
	.router_iact_2_0_horiz_address_in_valid     (CG_1_0_router_iact_2_0_horiz_address_in_valid  ),
	.router_iact_2_0_horiz_address_in           (CG_1_0_router_iact_2_0_horiz_address_in        ),
	.router_iact_2_0_horiz_data_in_ready        (CG_1_0_router_iact_2_0_horiz_data_in_ready     ),
	.router_iact_2_0_horiz_data_in_valid        (CG_1_0_router_iact_2_0_horiz_data_in_valid     ),
	.router_iact_2_0_horiz_data_in              (CG_1_0_router_iact_2_0_horiz_data_in           ),
	.router_iact_2_0_north_address_out_ready	(CG_1_0_router_iact_2_0_north_address_out_ready	),
	.router_iact_2_0_north_address_out_valid    (CG_1_0_router_iact_2_0_north_address_out_valid ),
	.router_iact_2_0_north_address_out          (CG_1_0_router_iact_2_0_north_address_out       ),
	.router_iact_2_0_north_data_out_ready       (CG_1_0_router_iact_2_0_north_data_out_ready    ),
	.router_iact_2_0_north_data_out_valid       (CG_1_0_router_iact_2_0_north_data_out_valid    ),
	.router_iact_2_0_north_data_out             (CG_1_0_router_iact_2_0_north_data_out          ),
	.router_iact_2_0_south_address_out_ready    (CG_1_0_router_iact_2_0_south_address_out_ready ),
	.router_iact_2_0_south_address_out_valid    (CG_1_0_router_iact_2_0_south_address_out_valid ),
	.router_iact_2_0_south_address_out          (CG_1_0_router_iact_2_0_south_address_out       ),
	.router_iact_2_0_south_data_out_ready       (CG_1_0_router_iact_2_0_south_data_out_ready    ),
	.router_iact_2_0_south_data_out_valid       (CG_1_0_router_iact_2_0_south_data_out_valid    ),
	.router_iact_2_0_south_data_out             (CG_1_0_router_iact_2_0_south_data_out          ),
	.router_iact_2_0_horiz_address_out_ready    (CG_1_0_router_iact_2_0_horiz_address_out_ready ),
	.router_iact_2_0_horiz_address_out_valid    (CG_1_0_router_iact_2_0_horiz_address_out_valid ),
	.router_iact_2_0_horiz_address_out          (CG_1_0_router_iact_2_0_horiz_address_out       ),
	.router_iact_2_0_horiz_data_out_ready       (CG_1_0_router_iact_2_0_horiz_data_out_ready    ),
	.router_iact_2_0_horiz_data_out_valid       (CG_1_0_router_iact_2_0_horiz_data_out_valid    ),
	.router_iact_2_0_horiz_data_out             (CG_1_0_router_iact_2_0_horiz_data_out          ),
	.router_iact_2_1_north_address_in_ready     (CG_1_0_router_iact_2_1_north_address_in_ready  ),
	.router_iact_2_1_north_address_in_valid     (CG_1_0_router_iact_2_1_north_address_in_valid  ),
	.router_iact_2_1_north_address_in           (CG_1_0_router_iact_2_1_north_address_in        ),
	.router_iact_2_1_north_data_in_ready        (CG_1_0_router_iact_2_1_north_data_in_ready     ),
	.router_iact_2_1_north_data_in_valid        (CG_1_0_router_iact_2_1_north_data_in_valid     ),
	.router_iact_2_1_north_data_in              (CG_1_0_router_iact_2_1_north_data_in           ),
	.router_iact_2_1_south_address_in_ready     (CG_1_0_router_iact_2_1_south_address_in_ready  ),
	.router_iact_2_1_south_address_in_valid     (CG_1_0_router_iact_2_1_south_address_in_valid  ),
	.router_iact_2_1_south_address_in           (CG_1_0_router_iact_2_1_south_address_in        ),
	.router_iact_2_1_south_data_in_ready        (CG_1_0_router_iact_2_1_south_data_in_ready     ),
	.router_iact_2_1_south_data_in_valid        (CG_1_0_router_iact_2_1_south_data_in_valid     ),
	.router_iact_2_1_south_data_in              (CG_1_0_router_iact_2_1_south_data_in           ),
	.router_iact_2_1_horiz_address_in_ready     (CG_1_0_router_iact_2_1_horiz_address_in_ready  ),
	.router_iact_2_1_horiz_address_in_valid     (CG_1_0_router_iact_2_1_horiz_address_in_valid  ),
	.router_iact_2_1_horiz_address_in           (CG_1_0_router_iact_2_1_horiz_address_in        ),
	.router_iact_2_1_horiz_data_in_ready        (CG_1_0_router_iact_2_1_horiz_data_in_ready     ),
	.router_iact_2_1_horiz_data_in_valid        (CG_1_0_router_iact_2_1_horiz_data_in_valid     ),
	.router_iact_2_1_horiz_data_in              (CG_1_0_router_iact_2_1_horiz_data_in           ),
	.router_iact_2_1_north_address_out_ready	(CG_1_0_router_iact_2_1_north_address_out_ready	),
	.router_iact_2_1_north_address_out_valid    (CG_1_0_router_iact_2_1_north_address_out_valid ),
	.router_iact_2_1_north_address_out          (CG_1_0_router_iact_2_1_north_address_out       ),
	.router_iact_2_1_north_data_out_ready       (CG_1_0_router_iact_2_1_north_data_out_ready    ),
	.router_iact_2_1_north_data_out_valid       (CG_1_0_router_iact_2_1_north_data_out_valid    ),
	.router_iact_2_1_north_data_out             (CG_1_0_router_iact_2_1_north_data_out          ),
	.router_iact_2_1_south_address_out_ready    (CG_1_0_router_iact_2_1_south_address_out_ready ),
	.router_iact_2_1_south_address_out_valid    (CG_1_0_router_iact_2_1_south_address_out_valid ),
	.router_iact_2_1_south_address_out          (CG_1_0_router_iact_2_1_south_address_out       ),
	.router_iact_2_1_south_data_out_ready       (CG_1_0_router_iact_2_1_south_data_out_ready    ),
	.router_iact_2_1_south_data_out_valid       (CG_1_0_router_iact_2_1_south_data_out_valid    ),
	.router_iact_2_1_south_data_out             (CG_1_0_router_iact_2_1_south_data_out          ),
	.router_iact_2_1_horiz_address_out_ready    (CG_1_0_router_iact_2_1_horiz_address_out_ready ),
	.router_iact_2_1_horiz_address_out_valid    (CG_1_0_router_iact_2_1_horiz_address_out_valid ),
	.router_iact_2_1_horiz_address_out          (CG_1_0_router_iact_2_1_horiz_address_out       ),
	.router_iact_2_1_horiz_data_out_ready       (CG_1_0_router_iact_2_1_horiz_data_out_ready    ),
	.router_iact_2_1_horiz_data_out_valid       (CG_1_0_router_iact_2_1_horiz_data_out_valid    ),
	.router_iact_2_1_horiz_data_out             (CG_1_0_router_iact_2_1_horiz_data_out          ),
	.router_iact_2_2_north_address_in_ready     (CG_1_0_router_iact_2_2_north_address_in_ready  ),
	.router_iact_2_2_north_address_in_valid     (CG_1_0_router_iact_2_2_north_address_in_valid  ),
	.router_iact_2_2_north_address_in           (CG_1_0_router_iact_2_2_north_address_in        ),
	.router_iact_2_2_north_data_in_ready        (CG_1_0_router_iact_2_2_north_data_in_ready     ),
	.router_iact_2_2_north_data_in_valid        (CG_1_0_router_iact_2_2_north_data_in_valid     ),
	.router_iact_2_2_north_data_in              (CG_1_0_router_iact_2_2_north_data_in           ),
	.router_iact_2_2_south_address_in_ready     (CG_1_0_router_iact_2_2_south_address_in_ready  ),
	.router_iact_2_2_south_address_in_valid     (CG_1_0_router_iact_2_2_south_address_in_valid  ),
	.router_iact_2_2_south_address_in           (CG_1_0_router_iact_2_2_south_address_in        ),
	.router_iact_2_2_south_data_in_ready        (CG_1_0_router_iact_2_2_south_data_in_ready     ),
	.router_iact_2_2_south_data_in_valid        (CG_1_0_router_iact_2_2_south_data_in_valid     ),
	.router_iact_2_2_south_data_in              (CG_1_0_router_iact_2_2_south_data_in           ),
	.router_iact_2_2_horiz_address_in_ready     (CG_1_0_router_iact_2_2_horiz_address_in_ready  ),
	.router_iact_2_2_horiz_address_in_valid     (CG_1_0_router_iact_2_2_horiz_address_in_valid  ),
	.router_iact_2_2_horiz_address_in           (CG_1_0_router_iact_2_2_horiz_address_in        ),
	.router_iact_2_2_horiz_data_in_ready        (CG_1_0_router_iact_2_2_horiz_data_in_ready     ),
	.router_iact_2_2_horiz_data_in_valid        (CG_1_0_router_iact_2_2_horiz_data_in_valid     ),
	.router_iact_2_2_horiz_data_in              (CG_1_0_router_iact_2_2_horiz_data_in           ),
	.router_iact_2_2_north_address_out_ready	(CG_1_0_router_iact_2_2_north_address_out_ready	),
	.router_iact_2_2_north_address_out_valid    (CG_1_0_router_iact_2_2_north_address_out_valid ),
	.router_iact_2_2_north_address_out          (CG_1_0_router_iact_2_2_north_address_out       ),
	.router_iact_2_2_north_data_out_ready       (CG_1_0_router_iact_2_2_north_data_out_ready    ),
	.router_iact_2_2_north_data_out_valid       (CG_1_0_router_iact_2_2_north_data_out_valid    ),
	.router_iact_2_2_north_data_out             (CG_1_0_router_iact_2_2_north_data_out          ),
	.router_iact_2_2_south_address_out_ready    (CG_1_0_router_iact_2_2_south_address_out_ready ),
	.router_iact_2_2_south_address_out_valid    (CG_1_0_router_iact_2_2_south_address_out_valid ),
	.router_iact_2_2_south_address_out          (CG_1_0_router_iact_2_2_south_address_out       ),
	.router_iact_2_2_south_data_out_ready       (CG_1_0_router_iact_2_2_south_data_out_ready    ),
	.router_iact_2_2_south_data_out_valid       (CG_1_0_router_iact_2_2_south_data_out_valid    ),
	.router_iact_2_2_south_data_out             (CG_1_0_router_iact_2_2_south_data_out          ),
	.router_iact_2_2_horiz_address_out_ready    (CG_1_0_router_iact_2_2_horiz_address_out_ready ),
	.router_iact_2_2_horiz_address_out_valid    (CG_1_0_router_iact_2_2_horiz_address_out_valid ),
	.router_iact_2_2_horiz_address_out          (CG_1_0_router_iact_2_2_horiz_address_out       ),
	.router_iact_2_2_horiz_data_out_ready       (CG_1_0_router_iact_2_2_horiz_data_out_ready    ),
	.router_iact_2_2_horiz_data_out_valid       (CG_1_0_router_iact_2_2_horiz_data_out_valid    ),
	.router_iact_2_2_horiz_data_out             (CG_1_0_router_iact_2_2_horiz_data_out          ),
												
	.router_weight_0_horiz_address_in_ready     (CG_1_0_router_weight_0_horiz_address_in_ready  ),
	.router_weight_0_horiz_address_in_valid     (CG_1_0_router_weight_0_horiz_address_in_valid  ),
	.router_weight_0_horiz_address_in           (CG_1_0_router_weight_0_horiz_address_in        ),
	.router_weight_0_horiz_data_in_ready        (CG_1_0_router_weight_0_horiz_data_in_ready     ),
	.router_weight_0_horiz_data_in_valid        (CG_1_0_router_weight_0_horiz_data_in_valid     ),
	.router_weight_0_horiz_data_in              (CG_1_0_router_weight_0_horiz_data_in           ),
	.router_weight_0_horiz_address_out_ready    (CG_1_0_router_weight_0_horiz_address_out_ready ),
	.router_weight_0_horiz_address_out_valid    (CG_1_0_router_weight_0_horiz_address_out_valid ),
	.router_weight_0_horiz_address_out          (CG_1_0_router_weight_0_horiz_address_out       ),
	.router_weight_0_horiz_data_out_ready       (CG_1_0_router_weight_0_horiz_data_out_ready    ),
	.router_weight_0_horiz_data_out_valid       (CG_1_0_router_weight_0_horiz_data_out_valid    ),
	.router_weight_0_horiz_data_out             (CG_1_0_router_weight_0_horiz_data_out          ),
	.router_weight_1_horiz_address_in_ready     (CG_1_0_router_weight_1_horiz_address_in_ready  ),
	.router_weight_1_horiz_address_in_valid     (CG_1_0_router_weight_1_horiz_address_in_valid  ),
	.router_weight_1_horiz_address_in           (CG_1_0_router_weight_1_horiz_address_in        ),
	.router_weight_1_horiz_data_in_ready        (CG_1_0_router_weight_1_horiz_data_in_ready     ),
	.router_weight_1_horiz_data_in_valid        (CG_1_0_router_weight_1_horiz_data_in_valid     ),
	.router_weight_1_horiz_data_in              (CG_1_0_router_weight_1_horiz_data_in           ),
	.router_weight_1_horiz_address_out_ready    (CG_1_0_router_weight_1_horiz_address_out_ready ),
	.router_weight_1_horiz_address_out_valid    (CG_1_0_router_weight_1_horiz_address_out_valid ),
	.router_weight_1_horiz_address_out          (CG_1_0_router_weight_1_horiz_address_out       ),
	.router_weight_1_horiz_data_out_ready       (CG_1_0_router_weight_1_horiz_data_out_ready    ),
	.router_weight_1_horiz_data_out_valid       (CG_1_0_router_weight_1_horiz_data_out_valid    ),
	.router_weight_1_horiz_data_out             (CG_1_0_router_weight_1_horiz_data_out          ),
	.router_weight_2_horiz_address_in_ready     (CG_1_0_router_weight_2_horiz_address_in_ready  ),
	.router_weight_2_horiz_address_in_valid     (CG_1_0_router_weight_2_horiz_address_in_valid  ),
	.router_weight_2_horiz_address_in           (CG_1_0_router_weight_2_horiz_address_in        ),
	.router_weight_2_horiz_data_in_ready        (CG_1_0_router_weight_2_horiz_data_in_ready     ),
	.router_weight_2_horiz_data_in_valid        (CG_1_0_router_weight_2_horiz_data_in_valid     ),
	.router_weight_2_horiz_data_in              (CG_1_0_router_weight_2_horiz_data_in           ),
	.router_weight_2_horiz_address_out_ready    (CG_1_0_router_weight_2_horiz_address_out_ready ),
	.router_weight_2_horiz_address_out_valid    (CG_1_0_router_weight_2_horiz_address_out_valid ),
	.router_weight_2_horiz_address_out          (CG_1_0_router_weight_2_horiz_address_out       ),
	.router_weight_2_horiz_data_out_ready       (CG_1_0_router_weight_2_horiz_data_out_ready    ),
	.router_weight_2_horiz_data_out_valid       (CG_1_0_router_weight_2_horiz_data_out_valid    ),
	.router_weight_2_horiz_data_out             (CG_1_0_router_weight_2_horiz_data_out          ),
												
	.router_psum_0_north_in_ready               (CG_1_0_router_psum_0_north_in_ready            ),
	.router_psum_0_north_in_valid               (CG_1_0_router_psum_0_north_in_valid            ),
	.router_psum_0_north_in                     (CG_1_0_router_psum_0_north_in                  ),
	.router_psum_0_south_out_ready              (CG_1_0_router_psum_0_south_out_ready           ),
	.router_psum_0_south_out_valid              (CG_1_0_router_psum_0_south_out_valid           ),
	.router_psum_0_south_out                    (CG_1_0_router_psum_0_south_out                 ),
	.router_psum_1_north_in_ready               (CG_1_0_router_psum_1_north_in_ready            ),
	.router_psum_1_north_in_valid               (CG_1_0_router_psum_1_north_in_valid            ),
	.router_psum_1_north_in                     (CG_1_0_router_psum_1_north_in                  ),
	.router_psum_1_south_out_ready              (CG_1_0_router_psum_1_south_out_ready           ),
	.router_psum_1_south_out_valid              (CG_1_0_router_psum_1_south_out_valid           ),
	.router_psum_1_south_out                    (CG_1_0_router_psum_1_south_out                 ),
	.router_psum_2_north_in_ready               (CG_1_0_router_psum_2_north_in_ready            ),
	.router_psum_2_north_in_valid               (CG_1_0_router_psum_2_north_in_valid            ),
	.router_psum_2_north_in                     (CG_1_0_router_psum_2_north_in                  ),
	.router_psum_2_south_out_ready              (CG_1_0_router_psum_2_south_out_ready           ),
	.router_psum_2_south_out_valid              (CG_1_0_router_psum_2_south_out_valid           ),
	.router_psum_2_south_out                    (CG_1_0_router_psum_2_south_out                 ),
												 					
	.cg_south_psum_0_in_ready                   (CG_1_0_cg_south_psum_0_in_ready                ),
	.cg_south_psum_0_in_valid                   (CG_1_0_cg_south_psum_0_in_valid                ),
	.cg_south_psum_0_in                         (CG_1_0_cg_south_psum_0_in                      ),
	.cg_south_psum_1_in_ready                   (CG_1_0_cg_south_psum_1_in_ready                ),
	.cg_south_psum_1_in_valid                   (CG_1_0_cg_south_psum_1_in_valid                ),
	.cg_south_psum_1_in                         (CG_1_0_cg_south_psum_1_in                      ),
	.cg_south_psum_2_in_ready                   (CG_1_0_cg_south_psum_2_in_ready                ),
	.cg_south_psum_2_in_valid                   (CG_1_0_cg_south_psum_2_in_valid                ),
	.cg_south_psum_2_in                         (CG_1_0_cg_south_psum_2_in                      ),
	.cg_north_psum_0_out_ready                  (CG_1_0_cg_north_psum_0_out_ready               ),
	.cg_north_psum_0_out_valid                  (CG_1_0_cg_north_psum_0_out_valid               ),
	.cg_north_psum_0_out                        (CG_1_0_cg_north_psum_0_out                     ),
	.cg_north_psum_1_out_ready                  (CG_1_0_cg_north_psum_1_out_ready               ),
	.cg_north_psum_1_out_valid                  (CG_1_0_cg_north_psum_1_out_valid               ),
	.cg_north_psum_1_out                        (CG_1_0_cg_north_psum_1_out                     ),
	.cg_north_psum_2_out_ready                  (CG_1_0_cg_north_psum_2_out_ready               ),
	.cg_north_psum_2_out_valid                  (CG_1_0_cg_north_psum_2_out_valid               ),
	.cg_north_psum_2_out                        (CG_1_0_cg_north_psum_2_out                     ),
									         
	.PSUM_DEPTH                                 (CG_1_0_PSUM_DEPTH                              ),
	.psum_spad_clear                            (CG_1_0_psum_spad_clear                         ),
											
	.iact_write_fin_clear                       (CG_1_0_iact_write_fin_clear                	),
	.weight_write_fin_clear						(CG_1_0_weight_write_fin_clear					)
);



ClusterGroup ClusterGroup_1_1 (
	.clock										(CG_1_1_clock									),
	.reset										(CG_1_1_reset									),
											   					
	.PE_cluster_iact_data_in_sel                (CG_1_1_PE_cluster_iact_data_in_sel             ),
	.PE_cluster_iact_data_out_sel               (CG_1_1_PE_cluster_iact_data_out_sel            ),
	.PE_cluster_psum_data_in_sel                (CG_1_1_PE_cluster_psum_data_in_sel             ),
									            			
	.router_cluster_iact_data_in_sel            (CG_1_1_router_cluster_iact_data_in_sel         ),
	.router_cluster_iact_data_out_sel           (CG_1_1_router_cluster_iact_data_out_sel        ),
	.router_cluster_weight_data_in_sel          (CG_1_1_router_cluster_weight_data_in_sel       ),
	.router_cluster_weight_data_out_sel         (CG_1_1_router_cluster_weight_data_out_sel      ),
	.router_cluster_psum_data_in_sel            (CG_1_1_router_cluster_psum_data_in_sel         ),
	.router_cluster_psum_data_out_sel           (CG_1_1_router_cluster_psum_data_out_sel        ),
							                    
	.read_psum_en                               (CG_1_1_read_psum_en                            ),
	.cal_fin                                    (CG_1_1_cal_fin                                 ),
	.cg_en                                      (CG_1_1_cg_en                                   ),
	.PE_weight_load_en                          (CG_1_1_PE_weight_load_en                       ),
	.GLB_iact_load_en                           (CG_1_1_GLB_iact_load_en                        ),
	.src_GLB_load_fin							(CG_1_1_src_GLB_load_fin						),
	.all_cal_fin								(CG_1_1_all_cal_fin								),
	.psum_acc_en								(CG_1_1_psum_acc_en								),
	.psum_acc_fin								(CG_1_1_psum_acc_fin							),
	.GLB_psum_write_en							(CG_1_1_GLB_psum_write_en						),
	.psum_SRAM_Bank_0_read_out_en				(CG_1_1_psum_SRAM_Bank_0_read_out_en			),
	.psum_SRAM_Bank_1_read_out_en				(CG_1_1_psum_SRAM_Bank_1_read_out_en			),
	.psum_SRAM_Bank_2_read_out_en				(CG_1_1_psum_SRAM_Bank_2_read_out_en			),
	
	.PE_0_0_disable								(CG_1_1_PE_0_0_disable							),
	.PE_0_1_disable								(CG_1_1_PE_0_1_disable							),
	.PE_0_2_disable								(CG_1_1_PE_0_2_disable							),
	.PE_1_0_disable								(CG_1_1_PE_1_0_disable							),
	.PE_1_1_disable								(CG_1_1_PE_1_1_disable							),
	.PE_1_2_disable								(CG_1_1_PE_1_2_disable							),
	.PE_2_0_disable								(CG_1_1_PE_2_0_disable							),
	.PE_2_1_disable								(CG_1_1_PE_2_1_disable							),
	.PE_2_2_disable								(CG_1_1_PE_2_2_disable							),
							                   
	.GLB_iact_0_0_read_addr                     (CG_1_1_GLB_iact_0_0_read_addr                  ),
	.GLB_iact_0_1_read_addr                     (CG_1_1_GLB_iact_0_1_read_addr                  ),
	.GLB_iact_0_2_read_addr                     (CG_1_1_GLB_iact_0_2_read_addr                  ),
	.GLB_iact_1_0_read_addr                     (CG_1_1_GLB_iact_1_0_read_addr                  ),
	.GLB_iact_1_1_read_addr                     (CG_1_1_GLB_iact_1_1_read_addr                  ),
	.GLB_iact_1_2_read_addr                     (CG_1_1_GLB_iact_1_2_read_addr                  ),
	.GLB_iact_2_0_read_addr                     (CG_1_1_GLB_iact_2_0_read_addr                  ),
	.GLB_iact_2_1_read_addr                     (CG_1_1_GLB_iact_2_1_read_addr                  ),
	.GLB_iact_2_2_read_addr                     (CG_1_1_GLB_iact_2_2_read_addr                  ),
							                    
	.GLB_psum_0_write_addr                      (CG_1_1_GLB_psum_0_write_addr                   ),
	.GLB_psum_1_write_addr                      (CG_1_1_GLB_psum_1_write_addr                   ),
	.GLB_psum_2_write_addr                      (CG_1_1_GLB_psum_2_write_addr                   ),
	.GLB_psum_0_read_addr                       (CG_1_1_GLB_psum_0_read_addr                    ),
	.GLB_psum_1_read_addr                       (CG_1_1_GLB_psum_1_read_addr                    ),
	.GLB_psum_2_read_addr                       (CG_1_1_GLB_psum_2_read_addr                    ),
								               
	.GLB_iact_0_0_address_in_ready              (CG_1_1_GLB_iact_0_0_address_in_ready           ),
	.GLB_iact_0_0_address_in_valid              (CG_1_1_GLB_iact_0_0_address_in_valid           ),
	.GLB_iact_0_0_address_in                    (CG_1_1_GLB_iact_0_0_address_in                 ),
	.GLB_iact_0_0_data_in_ready                 (CG_1_1_GLB_iact_0_0_data_in_ready              ),
	.GLB_iact_0_0_data_in_valid                 (CG_1_1_GLB_iact_0_0_data_in_valid              ),
	.GLB_iact_0_0_data_in                       (CG_1_1_GLB_iact_0_0_data_in                    ),
	.GLB_iact_0_1_address_in_ready              (CG_1_1_GLB_iact_0_1_address_in_ready           ),
	.GLB_iact_0_1_address_in_valid              (CG_1_1_GLB_iact_0_1_address_in_valid           ),
	.GLB_iact_0_1_address_in                    (CG_1_1_GLB_iact_0_1_address_in                 ),
	.GLB_iact_0_1_data_in_ready                 (CG_1_1_GLB_iact_0_1_data_in_ready              ),
	.GLB_iact_0_1_data_in_valid                 (CG_1_1_GLB_iact_0_1_data_in_valid              ),
	.GLB_iact_0_1_data_in                       (CG_1_1_GLB_iact_0_1_data_in                    ),
	.GLB_iact_0_2_address_in_ready              (CG_1_1_GLB_iact_0_2_address_in_ready           ),
	.GLB_iact_0_2_address_in_valid              (CG_1_1_GLB_iact_0_2_address_in_valid           ),
	.GLB_iact_0_2_address_in                    (CG_1_1_GLB_iact_0_2_address_in                 ),
	.GLB_iact_0_2_data_in_ready                 (CG_1_1_GLB_iact_0_2_data_in_ready              ),
	.GLB_iact_0_2_data_in_valid                 (CG_1_1_GLB_iact_0_2_data_in_valid              ),
	.GLB_iact_0_2_data_in                       (CG_1_1_GLB_iact_0_2_data_in                    ),
	.GLB_iact_1_0_address_in_ready              (CG_1_1_GLB_iact_1_0_address_in_ready           ),
	.GLB_iact_1_0_address_in_valid              (CG_1_1_GLB_iact_1_0_address_in_valid           ),
	.GLB_iact_1_0_address_in                    (CG_1_1_GLB_iact_1_0_address_in                 ),
	.GLB_iact_1_0_data_in_ready                 (CG_1_1_GLB_iact_1_0_data_in_ready              ),
	.GLB_iact_1_0_data_in_valid                 (CG_1_1_GLB_iact_1_0_data_in_valid              ),
	.GLB_iact_1_0_data_in                       (CG_1_1_GLB_iact_1_0_data_in                    ),
	.GLB_iact_1_1_address_in_ready              (CG_1_1_GLB_iact_1_1_address_in_ready           ),
	.GLB_iact_1_1_address_in_valid              (CG_1_1_GLB_iact_1_1_address_in_valid           ),
	.GLB_iact_1_1_address_in                    (CG_1_1_GLB_iact_1_1_address_in                 ),
	.GLB_iact_1_1_data_in_ready                 (CG_1_1_GLB_iact_1_1_data_in_ready              ),
	.GLB_iact_1_1_data_in_valid                 (CG_1_1_GLB_iact_1_1_data_in_valid              ),
	.GLB_iact_1_1_data_in                       (CG_1_1_GLB_iact_1_1_data_in                    ),
	.GLB_iact_1_2_address_in_ready              (CG_1_1_GLB_iact_1_2_address_in_ready           ),
	.GLB_iact_1_2_address_in_valid              (CG_1_1_GLB_iact_1_2_address_in_valid           ),
	.GLB_iact_1_2_address_in                    (CG_1_1_GLB_iact_1_2_address_in                 ),
	.GLB_iact_1_2_data_in_ready                 (CG_1_1_GLB_iact_1_2_data_in_ready              ),
	.GLB_iact_1_2_data_in_valid                 (CG_1_1_GLB_iact_1_2_data_in_valid              ),
	.GLB_iact_1_2_data_in                       (CG_1_1_GLB_iact_1_2_data_in                    ),
	.GLB_iact_2_0_address_in_ready              (CG_1_1_GLB_iact_2_0_address_in_ready           ),
	.GLB_iact_2_0_address_in_valid              (CG_1_1_GLB_iact_2_0_address_in_valid           ),
	.GLB_iact_2_0_address_in                    (CG_1_1_GLB_iact_2_0_address_in                 ),
	.GLB_iact_2_0_data_in_ready                 (CG_1_1_GLB_iact_2_0_data_in_ready              ),
	.GLB_iact_2_0_data_in_valid                 (CG_1_1_GLB_iact_2_0_data_in_valid              ),
	.GLB_iact_2_0_data_in                       (CG_1_1_GLB_iact_2_0_data_in                    ),
	.GLB_iact_2_1_address_in_ready              (CG_1_1_GLB_iact_2_1_address_in_ready           ),
	.GLB_iact_2_1_address_in_valid              (CG_1_1_GLB_iact_2_1_address_in_valid           ),
	.GLB_iact_2_1_address_in                    (CG_1_1_GLB_iact_2_1_address_in                 ),
	.GLB_iact_2_1_data_in_ready                 (CG_1_1_GLB_iact_2_1_data_in_ready              ),
	.GLB_iact_2_1_data_in_valid                 (CG_1_1_GLB_iact_2_1_data_in_valid              ),
	.GLB_iact_2_1_data_in                       (CG_1_1_GLB_iact_2_1_data_in                    ),
	.GLB_iact_2_2_address_in_ready              (CG_1_1_GLB_iact_2_2_address_in_ready           ),
	.GLB_iact_2_2_address_in_valid              (CG_1_1_GLB_iact_2_2_address_in_valid           ),
	.GLB_iact_2_2_address_in                    (CG_1_1_GLB_iact_2_2_address_in                 ),
	.GLB_iact_2_2_data_in_ready                 (CG_1_1_GLB_iact_2_2_data_in_ready              ),
	.GLB_iact_2_2_data_in_valid                 (CG_1_1_GLB_iact_2_2_data_in_valid              ),
	.GLB_iact_2_2_data_in                       (CG_1_1_GLB_iact_2_2_data_in                    ),
										    						
	.GLB_weight_0_address_in_ready              (CG_1_1_GLB_weight_0_address_in_ready           ),
	.GLB_weight_0_address_in_valid              (CG_1_1_GLB_weight_0_address_in_valid           ),
	.GLB_weight_0_address_in                    (CG_1_1_GLB_weight_0_address_in                 ),
	.GLB_weight_0_data_in_ready                 (CG_1_1_GLB_weight_0_data_in_ready              ),
	.GLB_weight_0_data_in_valid                 (CG_1_1_GLB_weight_0_data_in_valid              ),
	.GLB_weight_0_data_in                       (CG_1_1_GLB_weight_0_data_in                    ),
	.GLB_weight_1_address_in_ready              (CG_1_1_GLB_weight_1_address_in_ready           ),
	.GLB_weight_1_address_in_valid	            (CG_1_1_GLB_weight_1_address_in_valid	     	),
	.GLB_weight_1_address_in                    (CG_1_1_GLB_weight_1_address_in                 ),
	.GLB_weight_1_data_in_ready                 (CG_1_1_GLB_weight_1_data_in_ready              ),
	.GLB_weight_1_data_in_valid                 (CG_1_1_GLB_weight_1_data_in_valid              ),
	.GLB_weight_1_data_in                       (CG_1_1_GLB_weight_1_data_in                    ),
	.GLB_weight_2_address_in_ready              (CG_1_1_GLB_weight_2_address_in_ready           ),
	.GLB_weight_2_address_in_valid              (CG_1_1_GLB_weight_2_address_in_valid           ),
	.GLB_weight_2_address_in                    (CG_1_1_GLB_weight_2_address_in                 ),
	.GLB_weight_2_data_in_ready                 (CG_1_1_GLB_weight_2_data_in_ready              ),
	.GLB_weight_2_data_in_valid                 (CG_1_1_GLB_weight_2_data_in_valid              ),
	.GLB_weight_2_data_in                       (CG_1_1_GLB_weight_2_data_in                    ),
										     
	.GLB_psum_0_data_in_ready                   (CG_1_1_GLB_psum_0_data_in_ready                ),
	.GLB_psum_0_data_in_valid                   (CG_1_1_GLB_psum_0_data_in_valid                ),
	.GLB_psum_0_data_in                         (CG_1_1_GLB_psum_0_data_in                      ),
	.GLB_psum_0_data_out_ready                  (CG_1_1_GLB_psum_0_data_out_ready               ),
	.GLB_psum_0_data_out_valid                  (CG_1_1_GLB_psum_0_data_out_valid               ),
	.GLB_psum_0_data_out                        (CG_1_1_GLB_psum_0_data_out                     ),
	.GLB_psum_1_data_in_ready                   (CG_1_1_GLB_psum_1_data_in_ready                ),
	.GLB_psum_1_data_in_valid                   (CG_1_1_GLB_psum_1_data_in_valid                ),
	.GLB_psum_1_data_in                         (CG_1_1_GLB_psum_1_data_in                      ),
	.GLB_psum_1_data_out_ready                  (CG_1_1_GLB_psum_1_data_out_ready               ),
	.GLB_psum_1_data_out_valid                  (CG_1_1_GLB_psum_1_data_out_valid               ),
	.GLB_psum_1_data_out                        (CG_1_1_GLB_psum_1_data_out                     ),
	.GLB_psum_2_data_in_ready                   (CG_1_1_GLB_psum_2_data_in_ready                ),
	.GLB_psum_2_data_in_valid                   (CG_1_1_GLB_psum_2_data_in_valid                ),
	.GLB_psum_2_data_in                         (CG_1_1_GLB_psum_2_data_in                      ),
	.GLB_psum_2_data_out_ready                  (CG_1_1_GLB_psum_2_data_out_ready               ),
	.GLB_psum_2_data_out_valid                  (CG_1_1_GLB_psum_2_data_out_valid               ),
	.GLB_psum_2_data_out                        (CG_1_1_GLB_psum_2_data_out                     ),
											
	.router_iact_0_0_north_address_in_ready		(CG_1_1_router_iact_0_0_north_address_in_ready	),
	.router_iact_0_0_north_address_in_valid     (CG_1_1_router_iact_0_0_north_address_in_valid  ),
	.router_iact_0_0_north_address_in           (CG_1_1_router_iact_0_0_north_address_in        ),
	.router_iact_0_0_north_data_in_ready        (CG_1_1_router_iact_0_0_north_data_in_ready     ),
	.router_iact_0_0_north_data_in_valid        (CG_1_1_router_iact_0_0_north_data_in_valid     ),
	.router_iact_0_0_north_data_in              (CG_1_1_router_iact_0_0_north_data_in           ),
	.router_iact_0_0_south_address_in_ready     (CG_1_1_router_iact_0_0_south_address_in_ready  ),
	.router_iact_0_0_south_address_in_valid     (CG_1_1_router_iact_0_0_south_address_in_valid  ),
	.router_iact_0_0_south_address_in           (CG_1_1_router_iact_0_0_south_address_in        ),
	.router_iact_0_0_south_data_in_ready        (CG_1_1_router_iact_0_0_south_data_in_ready     ),
	.router_iact_0_0_south_data_in_valid        (CG_1_1_router_iact_0_0_south_data_in_valid     ),
	.router_iact_0_0_south_data_in              (CG_1_1_router_iact_0_0_south_data_in           ),
	.router_iact_0_0_horiz_address_in_ready     (CG_1_1_router_iact_0_0_horiz_address_in_ready  ),
	.router_iact_0_0_horiz_address_in_valid     (CG_1_1_router_iact_0_0_horiz_address_in_valid  ),
	.router_iact_0_0_horiz_address_in           (CG_1_1_router_iact_0_0_horiz_address_in        ),
	.router_iact_0_0_horiz_data_in_ready        (CG_1_1_router_iact_0_0_horiz_data_in_ready     ),
	.router_iact_0_0_horiz_data_in_valid        (CG_1_1_router_iact_0_0_horiz_data_in_valid     ),
	.router_iact_0_0_horiz_data_in              (CG_1_1_router_iact_0_0_horiz_data_in           ),
	.router_iact_0_0_north_address_out_ready	(CG_1_1_router_iact_0_0_north_address_out_ready	),
	.router_iact_0_0_north_address_out_valid    (CG_1_1_router_iact_0_0_north_address_out_valid ),
	.router_iact_0_0_north_address_out          (CG_1_1_router_iact_0_0_north_address_out       ),
	.router_iact_0_0_north_data_out_ready       (CG_1_1_router_iact_0_0_north_data_out_ready    ),
	.router_iact_0_0_north_data_out_valid       (CG_1_1_router_iact_0_0_north_data_out_valid    ),
	.router_iact_0_0_north_data_out             (CG_1_1_router_iact_0_0_north_data_out          ),
	.router_iact_0_0_south_address_out_ready    (CG_1_1_router_iact_0_0_south_address_out_ready ),
	.router_iact_0_0_south_address_out_valid    (CG_1_1_router_iact_0_0_south_address_out_valid ),
	.router_iact_0_0_south_address_out          (CG_1_1_router_iact_0_0_south_address_out       ),
	.router_iact_0_0_south_data_out_ready       (CG_1_1_router_iact_0_0_south_data_out_ready    ),
	.router_iact_0_0_south_data_out_valid       (CG_1_1_router_iact_0_0_south_data_out_valid    ),
	.router_iact_0_0_south_data_out             (CG_1_1_router_iact_0_0_south_data_out          ),
	.router_iact_0_0_horiz_address_out_ready    (CG_1_1_router_iact_0_0_horiz_address_out_ready ),
	.router_iact_0_0_horiz_address_out_valid    (CG_1_1_router_iact_0_0_horiz_address_out_valid ),
	.router_iact_0_0_horiz_address_out          (CG_1_1_router_iact_0_0_horiz_address_out       ),
	.router_iact_0_0_horiz_data_out_ready       (CG_1_1_router_iact_0_0_horiz_data_out_ready    ),
	.router_iact_0_0_horiz_data_out_valid       (CG_1_1_router_iact_0_0_horiz_data_out_valid    ),
	.router_iact_0_0_horiz_data_out             (CG_1_1_router_iact_0_0_horiz_data_out          ),
	.router_iact_0_1_north_address_in_ready     (CG_1_1_router_iact_0_1_north_address_in_ready  ),
	.router_iact_0_1_north_address_in_valid     (CG_1_1_router_iact_0_1_north_address_in_valid  ),
	.router_iact_0_1_north_address_in           (CG_1_1_router_iact_0_1_north_address_in        ),
	.router_iact_0_1_north_data_in_ready        (CG_1_1_router_iact_0_1_north_data_in_ready     ),
	.router_iact_0_1_north_data_in_valid        (CG_1_1_router_iact_0_1_north_data_in_valid     ),
	.router_iact_0_1_north_data_in              (CG_1_1_router_iact_0_1_north_data_in           ),
	.router_iact_0_1_south_address_in_ready     (CG_1_1_router_iact_0_1_south_address_in_ready  ),
	.router_iact_0_1_south_address_in_valid     (CG_1_1_router_iact_0_1_south_address_in_valid  ),
	.router_iact_0_1_south_address_in           (CG_1_1_router_iact_0_1_south_address_in        ),
	.router_iact_0_1_south_data_in_ready        (CG_1_1_router_iact_0_1_south_data_in_ready     ),
	.router_iact_0_1_south_data_in_valid        (CG_1_1_router_iact_0_1_south_data_in_valid     ),
	.router_iact_0_1_south_data_in              (CG_1_1_router_iact_0_1_south_data_in           ),
	.router_iact_0_1_horiz_address_in_ready     (CG_1_1_router_iact_0_1_horiz_address_in_ready  ),
	.router_iact_0_1_horiz_address_in_valid     (CG_1_1_router_iact_0_1_horiz_address_in_valid  ),
	.router_iact_0_1_horiz_address_in           (CG_1_1_router_iact_0_1_horiz_address_in        ),
	.router_iact_0_1_horiz_data_in_ready        (CG_1_1_router_iact_0_1_horiz_data_in_ready     ),
	.router_iact_0_1_horiz_data_in_valid        (CG_1_1_router_iact_0_1_horiz_data_in_valid     ),
	.router_iact_0_1_horiz_data_in              (CG_1_1_router_iact_0_1_horiz_data_in           ),
	.router_iact_0_1_north_address_out_ready	(CG_1_1_router_iact_0_1_north_address_out_ready	),
	.router_iact_0_1_north_address_out_valid    (CG_1_1_router_iact_0_1_north_address_out_valid ),
	.router_iact_0_1_north_address_out          (CG_1_1_router_iact_0_1_north_address_out       ),
	.router_iact_0_1_north_data_out_ready       (CG_1_1_router_iact_0_1_north_data_out_ready    ),
	.router_iact_0_1_north_data_out_valid       (CG_1_1_router_iact_0_1_north_data_out_valid    ),
	.router_iact_0_1_north_data_out             (CG_1_1_router_iact_0_1_north_data_out          ),
	.router_iact_0_1_south_address_out_ready    (CG_1_1_router_iact_0_1_south_address_out_ready ),
	.router_iact_0_1_south_address_out_valid    (CG_1_1_router_iact_0_1_south_address_out_valid ),
	.router_iact_0_1_south_address_out          (CG_1_1_router_iact_0_1_south_address_out       ),
	.router_iact_0_1_south_data_out_ready       (CG_1_1_router_iact_0_1_south_data_out_ready    ),
	.router_iact_0_1_south_data_out_valid       (CG_1_1_router_iact_0_1_south_data_out_valid    ),
	.router_iact_0_1_south_data_out             (CG_1_1_router_iact_0_1_south_data_out          ),
	.router_iact_0_1_horiz_address_out_ready    (CG_1_1_router_iact_0_1_horiz_address_out_ready ),
	.router_iact_0_1_horiz_address_out_valid    (CG_1_1_router_iact_0_1_horiz_address_out_valid ),
	.router_iact_0_1_horiz_address_out          (CG_1_1_router_iact_0_1_horiz_address_out       ),
	.router_iact_0_1_horiz_data_out_ready       (CG_1_1_router_iact_0_1_horiz_data_out_ready    ),
	.router_iact_0_1_horiz_data_out_valid       (CG_1_1_router_iact_0_1_horiz_data_out_valid    ),
	.router_iact_0_1_horiz_data_out             (CG_1_1_router_iact_0_1_horiz_data_out          ),
	.router_iact_0_2_north_address_in_ready     (CG_1_1_router_iact_0_2_north_address_in_ready  ),
	.router_iact_0_2_north_address_in_valid     (CG_1_1_router_iact_0_2_north_address_in_valid  ),
	.router_iact_0_2_north_address_in           (CG_1_1_router_iact_0_2_north_address_in        ),
	.router_iact_0_2_north_data_in_ready        (CG_1_1_router_iact_0_2_north_data_in_ready     ),
	.router_iact_0_2_north_data_in_valid        (CG_1_1_router_iact_0_2_north_data_in_valid     ),
	.router_iact_0_2_north_data_in              (CG_1_1_router_iact_0_2_north_data_in           ),
	.router_iact_0_2_south_address_in_ready     (CG_1_1_router_iact_0_2_south_address_in_ready  ),
	.router_iact_0_2_south_address_in_valid     (CG_1_1_router_iact_0_2_south_address_in_valid  ),
	.router_iact_0_2_south_address_in           (CG_1_1_router_iact_0_2_south_address_in        ),
	.router_iact_0_2_south_data_in_ready        (CG_1_1_router_iact_0_2_south_data_in_ready     ),
	.router_iact_0_2_south_data_in_valid        (CG_1_1_router_iact_0_2_south_data_in_valid     ),
	.router_iact_0_2_south_data_in              (CG_1_1_router_iact_0_2_south_data_in           ),
	.router_iact_0_2_horiz_address_in_ready     (CG_1_1_router_iact_0_2_horiz_address_in_ready  ),
	.router_iact_0_2_horiz_address_in_valid     (CG_1_1_router_iact_0_2_horiz_address_in_valid  ),
	.router_iact_0_2_horiz_address_in           (CG_1_1_router_iact_0_2_horiz_address_in        ),
	.router_iact_0_2_horiz_data_in_ready        (CG_1_1_router_iact_0_2_horiz_data_in_ready     ),
	.router_iact_0_2_horiz_data_in_valid        (CG_1_1_router_iact_0_2_horiz_data_in_valid     ),
	.router_iact_0_2_horiz_data_in              (CG_1_1_router_iact_0_2_horiz_data_in           ),
	.router_iact_0_2_north_address_out_ready	(CG_1_1_router_iact_0_2_north_address_out_ready	),
	.router_iact_0_2_north_address_out_valid    (CG_1_1_router_iact_0_2_north_address_out_valid ),
	.router_iact_0_2_north_address_out          (CG_1_1_router_iact_0_2_north_address_out       ),
	.router_iact_0_2_north_data_out_ready       (CG_1_1_router_iact_0_2_north_data_out_ready    ),
	.router_iact_0_2_north_data_out_valid       (CG_1_1_router_iact_0_2_north_data_out_valid    ),
	.router_iact_0_2_north_data_out             (CG_1_1_router_iact_0_2_north_data_out          ),
	.router_iact_0_2_south_address_out_ready    (CG_1_1_router_iact_0_2_south_address_out_ready ),
	.router_iact_0_2_south_address_out_valid    (CG_1_1_router_iact_0_2_south_address_out_valid ),
	.router_iact_0_2_south_address_out          (CG_1_1_router_iact_0_2_south_address_out       ),
	.router_iact_0_2_south_data_out_ready       (CG_1_1_router_iact_0_2_south_data_out_ready    ),
	.router_iact_0_2_south_data_out_valid       (CG_1_1_router_iact_0_2_south_data_out_valid    ),
	.router_iact_0_2_south_data_out             (CG_1_1_router_iact_0_2_south_data_out          ),
	.router_iact_0_2_horiz_address_out_ready    (CG_1_1_router_iact_0_2_horiz_address_out_ready ),
	.router_iact_0_2_horiz_address_out_valid    (CG_1_1_router_iact_0_2_horiz_address_out_valid ),
	.router_iact_0_2_horiz_address_out          (CG_1_1_router_iact_0_2_horiz_address_out       ),
	.router_iact_0_2_horiz_data_out_ready       (CG_1_1_router_iact_0_2_horiz_data_out_ready    ),
	.router_iact_0_2_horiz_data_out_valid       (CG_1_1_router_iact_0_2_horiz_data_out_valid    ),
	.router_iact_0_2_horiz_data_out             (CG_1_1_router_iact_0_2_horiz_data_out          ),
	.router_iact_1_0_north_address_in_ready     (CG_1_1_router_iact_1_0_north_address_in_ready  ),
	.router_iact_1_0_north_address_in_valid     (CG_1_1_router_iact_1_0_north_address_in_valid  ),
	.router_iact_1_0_north_address_in           (CG_1_1_router_iact_1_0_north_address_in        ),
	.router_iact_1_0_north_data_in_ready        (CG_1_1_router_iact_1_0_north_data_in_ready     ),
	.router_iact_1_0_north_data_in_valid        (CG_1_1_router_iact_1_0_north_data_in_valid     ),
	.router_iact_1_0_north_data_in              (CG_1_1_router_iact_1_0_north_data_in           ),
	.router_iact_1_0_south_address_in_ready     (CG_1_1_router_iact_1_0_south_address_in_ready  ),
	.router_iact_1_0_south_address_in_valid     (CG_1_1_router_iact_1_0_south_address_in_valid  ),
	.router_iact_1_0_south_address_in           (CG_1_1_router_iact_1_0_south_address_in        ),
	.router_iact_1_0_south_data_in_ready        (CG_1_1_router_iact_1_0_south_data_in_ready     ),
	.router_iact_1_0_south_data_in_valid        (CG_1_1_router_iact_1_0_south_data_in_valid     ),
	.router_iact_1_0_south_data_in              (CG_1_1_router_iact_1_0_south_data_in           ),
	.router_iact_1_0_horiz_address_in_ready     (CG_1_1_router_iact_1_0_horiz_address_in_ready  ),
	.router_iact_1_0_horiz_address_in_valid     (CG_1_1_router_iact_1_0_horiz_address_in_valid  ),
	.router_iact_1_0_horiz_address_in           (CG_1_1_router_iact_1_0_horiz_address_in        ),
	.router_iact_1_0_horiz_data_in_ready        (CG_1_1_router_iact_1_0_horiz_data_in_ready     ),
	.router_iact_1_0_horiz_data_in_valid        (CG_1_1_router_iact_1_0_horiz_data_in_valid     ),
	.router_iact_1_0_horiz_data_in              (CG_1_1_router_iact_1_0_horiz_data_in           ),
	.router_iact_1_0_north_address_out_ready	(CG_1_1_router_iact_1_0_north_address_out_ready	),
	.router_iact_1_0_north_address_out_valid    (CG_1_1_router_iact_1_0_north_address_out_valid ),
	.router_iact_1_0_north_address_out          (CG_1_1_router_iact_1_0_north_address_out       ),
	.router_iact_1_0_north_data_out_ready       (CG_1_1_router_iact_1_0_north_data_out_ready    ),
	.router_iact_1_0_north_data_out_valid       (CG_1_1_router_iact_1_0_north_data_out_valid    ),
	.router_iact_1_0_north_data_out             (CG_1_1_router_iact_1_0_north_data_out          ),
	.router_iact_1_0_south_address_out_ready    (CG_1_1_router_iact_1_0_south_address_out_ready ),
	.router_iact_1_0_south_address_out_valid    (CG_1_1_router_iact_1_0_south_address_out_valid ),
	.router_iact_1_0_south_address_out          (CG_1_1_router_iact_1_0_south_address_out       ),
	.router_iact_1_0_south_data_out_ready       (CG_1_1_router_iact_1_0_south_data_out_ready    ),
	.router_iact_1_0_south_data_out_valid       (CG_1_1_router_iact_1_0_south_data_out_valid    ),
	.router_iact_1_0_south_data_out             (CG_1_1_router_iact_1_0_south_data_out          ),
	.router_iact_1_0_horiz_address_out_ready    (CG_1_1_router_iact_1_0_horiz_address_out_ready ),
	.router_iact_1_0_horiz_address_out_valid    (CG_1_1_router_iact_1_0_horiz_address_out_valid ),
	.router_iact_1_0_horiz_address_out          (CG_1_1_router_iact_1_0_horiz_address_out       ),
	.router_iact_1_0_horiz_data_out_ready       (CG_1_1_router_iact_1_0_horiz_data_out_ready    ),
	.router_iact_1_0_horiz_data_out_valid       (CG_1_1_router_iact_1_0_horiz_data_out_valid    ),
	.router_iact_1_0_horiz_data_out             (CG_1_1_router_iact_1_0_horiz_data_out          ),
	.router_iact_1_1_north_address_in_ready     (CG_1_1_router_iact_1_1_north_address_in_ready  ),
	.router_iact_1_1_north_address_in_valid     (CG_1_1_router_iact_1_1_north_address_in_valid  ),
	.router_iact_1_1_north_address_in           (CG_1_1_router_iact_1_1_north_address_in        ),
	.router_iact_1_1_north_data_in_ready        (CG_1_1_router_iact_1_1_north_data_in_ready     ),
	.router_iact_1_1_north_data_in_valid        (CG_1_1_router_iact_1_1_north_data_in_valid     ),
	.router_iact_1_1_north_data_in              (CG_1_1_router_iact_1_1_north_data_in           ),
	.router_iact_1_1_south_address_in_ready     (CG_1_1_router_iact_1_1_south_address_in_ready  ),
	.router_iact_1_1_south_address_in_valid     (CG_1_1_router_iact_1_1_south_address_in_valid  ),
	.router_iact_1_1_south_address_in           (CG_1_1_router_iact_1_1_south_address_in        ),
	.router_iact_1_1_south_data_in_ready        (CG_1_1_router_iact_1_1_south_data_in_ready     ),
	.router_iact_1_1_south_data_in_valid        (CG_1_1_router_iact_1_1_south_data_in_valid     ),
	.router_iact_1_1_south_data_in              (CG_1_1_router_iact_1_1_south_data_in           ),
	.router_iact_1_1_horiz_address_in_ready     (CG_1_1_router_iact_1_1_horiz_address_in_ready  ),
	.router_iact_1_1_horiz_address_in_valid     (CG_1_1_router_iact_1_1_horiz_address_in_valid  ),
	.router_iact_1_1_horiz_address_in           (CG_1_1_router_iact_1_1_horiz_address_in        ),
	.router_iact_1_1_horiz_data_in_ready        (CG_1_1_router_iact_1_1_horiz_data_in_ready     ),
	.router_iact_1_1_horiz_data_in_valid        (CG_1_1_router_iact_1_1_horiz_data_in_valid     ),
	.router_iact_1_1_horiz_data_in              (CG_1_1_router_iact_1_1_horiz_data_in           ),
	.router_iact_1_1_north_address_out_ready	(CG_1_1_router_iact_1_1_north_address_out_ready	),
	.router_iact_1_1_north_address_out_valid    (CG_1_1_router_iact_1_1_north_address_out_valid ),
	.router_iact_1_1_north_address_out          (CG_1_1_router_iact_1_1_north_address_out       ),
	.router_iact_1_1_north_data_out_ready       (CG_1_1_router_iact_1_1_north_data_out_ready    ),
	.router_iact_1_1_north_data_out_valid       (CG_1_1_router_iact_1_1_north_data_out_valid    ),
	.router_iact_1_1_north_data_out             (CG_1_1_router_iact_1_1_north_data_out          ),
	.router_iact_1_1_south_address_out_ready    (CG_1_1_router_iact_1_1_south_address_out_ready ),
	.router_iact_1_1_south_address_out_valid    (CG_1_1_router_iact_1_1_south_address_out_valid ),
	.router_iact_1_1_south_address_out          (CG_1_1_router_iact_1_1_south_address_out       ),
	.router_iact_1_1_south_data_out_ready       (CG_1_1_router_iact_1_1_south_data_out_ready    ),
	.router_iact_1_1_south_data_out_valid       (CG_1_1_router_iact_1_1_south_data_out_valid    ),
	.router_iact_1_1_south_data_out             (CG_1_1_router_iact_1_1_south_data_out          ),
	.router_iact_1_1_horiz_address_out_ready    (CG_1_1_router_iact_1_1_horiz_address_out_ready ),
	.router_iact_1_1_horiz_address_out_valid    (CG_1_1_router_iact_1_1_horiz_address_out_valid ),
	.router_iact_1_1_horiz_address_out          (CG_1_1_router_iact_1_1_horiz_address_out       ),
	.router_iact_1_1_horiz_data_out_ready       (CG_1_1_router_iact_1_1_horiz_data_out_ready    ),
	.router_iact_1_1_horiz_data_out_valid       (CG_1_1_router_iact_1_1_horiz_data_out_valid    ),
	.router_iact_1_1_horiz_data_out             (CG_1_1_router_iact_1_1_horiz_data_out          ),
	.router_iact_1_2_north_address_in_ready     (CG_1_1_router_iact_1_2_north_address_in_ready  ),
	.router_iact_1_2_north_address_in_valid     (CG_1_1_router_iact_1_2_north_address_in_valid  ),
	.router_iact_1_2_north_address_in           (CG_1_1_router_iact_1_2_north_address_in        ),
	.router_iact_1_2_north_data_in_ready        (CG_1_1_router_iact_1_2_north_data_in_ready     ),
	.router_iact_1_2_north_data_in_valid        (CG_1_1_router_iact_1_2_north_data_in_valid     ),
	.router_iact_1_2_north_data_in              (CG_1_1_router_iact_1_2_north_data_in           ),
	.router_iact_1_2_south_address_in_ready     (CG_1_1_router_iact_1_2_south_address_in_ready  ),
	.router_iact_1_2_south_address_in_valid     (CG_1_1_router_iact_1_2_south_address_in_valid  ),
	.router_iact_1_2_south_address_in           (CG_1_1_router_iact_1_2_south_address_in        ),
	.router_iact_1_2_south_data_in_ready        (CG_1_1_router_iact_1_2_south_data_in_ready     ),
	.router_iact_1_2_south_data_in_valid        (CG_1_1_router_iact_1_2_south_data_in_valid     ),
	.router_iact_1_2_south_data_in              (CG_1_1_router_iact_1_2_south_data_in           ),
	.router_iact_1_2_horiz_address_in_ready     (CG_1_1_router_iact_1_2_horiz_address_in_ready  ),
	.router_iact_1_2_horiz_address_in_valid     (CG_1_1_router_iact_1_2_horiz_address_in_valid  ),
	.router_iact_1_2_horiz_address_in           (CG_1_1_router_iact_1_2_horiz_address_in        ),
	.router_iact_1_2_horiz_data_in_ready        (CG_1_1_router_iact_1_2_horiz_data_in_ready     ),
	.router_iact_1_2_horiz_data_in_valid        (CG_1_1_router_iact_1_2_horiz_data_in_valid     ),
	.router_iact_1_2_horiz_data_in              (CG_1_1_router_iact_1_2_horiz_data_in           ),
	.router_iact_1_2_north_address_out_ready	(CG_1_1_router_iact_1_2_north_address_out_ready	),
	.router_iact_1_2_north_address_out_valid    (CG_1_1_router_iact_1_2_north_address_out_valid ),
	.router_iact_1_2_north_address_out          (CG_1_1_router_iact_1_2_north_address_out       ),
	.router_iact_1_2_north_data_out_ready       (CG_1_1_router_iact_1_2_north_data_out_ready    ),
	.router_iact_1_2_north_data_out_valid       (CG_1_1_router_iact_1_2_north_data_out_valid    ),
	.router_iact_1_2_north_data_out             (CG_1_1_router_iact_1_2_north_data_out          ),
	.router_iact_1_2_south_address_out_ready    (CG_1_1_router_iact_1_2_south_address_out_ready ),
	.router_iact_1_2_south_address_out_valid    (CG_1_1_router_iact_1_2_south_address_out_valid ),
	.router_iact_1_2_south_address_out          (CG_1_1_router_iact_1_2_south_address_out       ),
	.router_iact_1_2_south_data_out_ready       (CG_1_1_router_iact_1_2_south_data_out_ready    ),
	.router_iact_1_2_south_data_out_valid       (CG_1_1_router_iact_1_2_south_data_out_valid    ),
	.router_iact_1_2_south_data_out             (CG_1_1_router_iact_1_2_south_data_out          ),
	.router_iact_1_2_horiz_address_out_ready    (CG_1_1_router_iact_1_2_horiz_address_out_ready ),
	.router_iact_1_2_horiz_address_out_valid    (CG_1_1_router_iact_1_2_horiz_address_out_valid ),
	.router_iact_1_2_horiz_address_out          (CG_1_1_router_iact_1_2_horiz_address_out       ),
	.router_iact_1_2_horiz_data_out_ready       (CG_1_1_router_iact_1_2_horiz_data_out_ready    ),
	.router_iact_1_2_horiz_data_out_valid       (CG_1_1_router_iact_1_2_horiz_data_out_valid    ),
	.router_iact_1_2_horiz_data_out             (CG_1_1_router_iact_1_2_horiz_data_out          ),
	.router_iact_2_0_north_address_in_ready     (CG_1_1_router_iact_2_0_north_address_in_ready  ),
	.router_iact_2_0_north_address_in_valid     (CG_1_1_router_iact_2_0_north_address_in_valid  ),
	.router_iact_2_0_north_address_in           (CG_1_1_router_iact_2_0_north_address_in        ),
	.router_iact_2_0_north_data_in_ready        (CG_1_1_router_iact_2_0_north_data_in_ready     ),
	.router_iact_2_0_north_data_in_valid        (CG_1_1_router_iact_2_0_north_data_in_valid     ),
	.router_iact_2_0_north_data_in              (CG_1_1_router_iact_2_0_north_data_in           ),
	.router_iact_2_0_south_address_in_ready     (CG_1_1_router_iact_2_0_south_address_in_ready  ),
	.router_iact_2_0_south_address_in_valid     (CG_1_1_router_iact_2_0_south_address_in_valid  ),
	.router_iact_2_0_south_address_in           (CG_1_1_router_iact_2_0_south_address_in        ),
	.router_iact_2_0_south_data_in_ready        (CG_1_1_router_iact_2_0_south_data_in_ready     ),
	.router_iact_2_0_south_data_in_valid        (CG_1_1_router_iact_2_0_south_data_in_valid     ),
	.router_iact_2_0_south_data_in              (CG_1_1_router_iact_2_0_south_data_in           ),
	.router_iact_2_0_horiz_address_in_ready     (CG_1_1_router_iact_2_0_horiz_address_in_ready  ),
	.router_iact_2_0_horiz_address_in_valid     (CG_1_1_router_iact_2_0_horiz_address_in_valid  ),
	.router_iact_2_0_horiz_address_in           (CG_1_1_router_iact_2_0_horiz_address_in        ),
	.router_iact_2_0_horiz_data_in_ready        (CG_1_1_router_iact_2_0_horiz_data_in_ready     ),
	.router_iact_2_0_horiz_data_in_valid        (CG_1_1_router_iact_2_0_horiz_data_in_valid     ),
	.router_iact_2_0_horiz_data_in              (CG_1_1_router_iact_2_0_horiz_data_in           ),
	.router_iact_2_0_north_address_out_ready	(CG_1_1_router_iact_2_0_north_address_out_ready	),
	.router_iact_2_0_north_address_out_valid    (CG_1_1_router_iact_2_0_north_address_out_valid ),
	.router_iact_2_0_north_address_out          (CG_1_1_router_iact_2_0_north_address_out       ),
	.router_iact_2_0_north_data_out_ready       (CG_1_1_router_iact_2_0_north_data_out_ready    ),
	.router_iact_2_0_north_data_out_valid       (CG_1_1_router_iact_2_0_north_data_out_valid    ),
	.router_iact_2_0_north_data_out             (CG_1_1_router_iact_2_0_north_data_out          ),
	.router_iact_2_0_south_address_out_ready    (CG_1_1_router_iact_2_0_south_address_out_ready ),
	.router_iact_2_0_south_address_out_valid    (CG_1_1_router_iact_2_0_south_address_out_valid ),
	.router_iact_2_0_south_address_out          (CG_1_1_router_iact_2_0_south_address_out       ),
	.router_iact_2_0_south_data_out_ready       (CG_1_1_router_iact_2_0_south_data_out_ready    ),
	.router_iact_2_0_south_data_out_valid       (CG_1_1_router_iact_2_0_south_data_out_valid    ),
	.router_iact_2_0_south_data_out             (CG_1_1_router_iact_2_0_south_data_out          ),
	.router_iact_2_0_horiz_address_out_ready    (CG_1_1_router_iact_2_0_horiz_address_out_ready ),
	.router_iact_2_0_horiz_address_out_valid    (CG_1_1_router_iact_2_0_horiz_address_out_valid ),
	.router_iact_2_0_horiz_address_out          (CG_1_1_router_iact_2_0_horiz_address_out       ),
	.router_iact_2_0_horiz_data_out_ready       (CG_1_1_router_iact_2_0_horiz_data_out_ready    ),
	.router_iact_2_0_horiz_data_out_valid       (CG_1_1_router_iact_2_0_horiz_data_out_valid    ),
	.router_iact_2_0_horiz_data_out             (CG_1_1_router_iact_2_0_horiz_data_out          ),
	.router_iact_2_1_north_address_in_ready     (CG_1_1_router_iact_2_1_north_address_in_ready  ),
	.router_iact_2_1_north_address_in_valid     (CG_1_1_router_iact_2_1_north_address_in_valid  ),
	.router_iact_2_1_north_address_in           (CG_1_1_router_iact_2_1_north_address_in        ),
	.router_iact_2_1_north_data_in_ready        (CG_1_1_router_iact_2_1_north_data_in_ready     ),
	.router_iact_2_1_north_data_in_valid        (CG_1_1_router_iact_2_1_north_data_in_valid     ),
	.router_iact_2_1_north_data_in              (CG_1_1_router_iact_2_1_north_data_in           ),
	.router_iact_2_1_south_address_in_ready     (CG_1_1_router_iact_2_1_south_address_in_ready  ),
	.router_iact_2_1_south_address_in_valid     (CG_1_1_router_iact_2_1_south_address_in_valid  ),
	.router_iact_2_1_south_address_in           (CG_1_1_router_iact_2_1_south_address_in        ),
	.router_iact_2_1_south_data_in_ready        (CG_1_1_router_iact_2_1_south_data_in_ready     ),
	.router_iact_2_1_south_data_in_valid        (CG_1_1_router_iact_2_1_south_data_in_valid     ),
	.router_iact_2_1_south_data_in              (CG_1_1_router_iact_2_1_south_data_in           ),
	.router_iact_2_1_horiz_address_in_ready     (CG_1_1_router_iact_2_1_horiz_address_in_ready  ),
	.router_iact_2_1_horiz_address_in_valid     (CG_1_1_router_iact_2_1_horiz_address_in_valid  ),
	.router_iact_2_1_horiz_address_in           (CG_1_1_router_iact_2_1_horiz_address_in        ),
	.router_iact_2_1_horiz_data_in_ready        (CG_1_1_router_iact_2_1_horiz_data_in_ready     ),
	.router_iact_2_1_horiz_data_in_valid        (CG_1_1_router_iact_2_1_horiz_data_in_valid     ),
	.router_iact_2_1_horiz_data_in              (CG_1_1_router_iact_2_1_horiz_data_in           ),
	.router_iact_2_1_north_address_out_ready	(CG_1_1_router_iact_2_1_north_address_out_ready	),
	.router_iact_2_1_north_address_out_valid    (CG_1_1_router_iact_2_1_north_address_out_valid ),
	.router_iact_2_1_north_address_out          (CG_1_1_router_iact_2_1_north_address_out       ),
	.router_iact_2_1_north_data_out_ready       (CG_1_1_router_iact_2_1_north_data_out_ready    ),
	.router_iact_2_1_north_data_out_valid       (CG_1_1_router_iact_2_1_north_data_out_valid    ),
	.router_iact_2_1_north_data_out             (CG_1_1_router_iact_2_1_north_data_out          ),
	.router_iact_2_1_south_address_out_ready    (CG_1_1_router_iact_2_1_south_address_out_ready ),
	.router_iact_2_1_south_address_out_valid    (CG_1_1_router_iact_2_1_south_address_out_valid ),
	.router_iact_2_1_south_address_out          (CG_1_1_router_iact_2_1_south_address_out       ),
	.router_iact_2_1_south_data_out_ready       (CG_1_1_router_iact_2_1_south_data_out_ready    ),
	.router_iact_2_1_south_data_out_valid       (CG_1_1_router_iact_2_1_south_data_out_valid    ),
	.router_iact_2_1_south_data_out             (CG_1_1_router_iact_2_1_south_data_out          ),
	.router_iact_2_1_horiz_address_out_ready    (CG_1_1_router_iact_2_1_horiz_address_out_ready ),
	.router_iact_2_1_horiz_address_out_valid    (CG_1_1_router_iact_2_1_horiz_address_out_valid ),
	.router_iact_2_1_horiz_address_out          (CG_1_1_router_iact_2_1_horiz_address_out       ),
	.router_iact_2_1_horiz_data_out_ready       (CG_1_1_router_iact_2_1_horiz_data_out_ready    ),
	.router_iact_2_1_horiz_data_out_valid       (CG_1_1_router_iact_2_1_horiz_data_out_valid    ),
	.router_iact_2_1_horiz_data_out             (CG_1_1_router_iact_2_1_horiz_data_out          ),
	.router_iact_2_2_north_address_in_ready     (CG_1_1_router_iact_2_2_north_address_in_ready  ),
	.router_iact_2_2_north_address_in_valid     (CG_1_1_router_iact_2_2_north_address_in_valid  ),
	.router_iact_2_2_north_address_in           (CG_1_1_router_iact_2_2_north_address_in        ),
	.router_iact_2_2_north_data_in_ready        (CG_1_1_router_iact_2_2_north_data_in_ready     ),
	.router_iact_2_2_north_data_in_valid        (CG_1_1_router_iact_2_2_north_data_in_valid     ),
	.router_iact_2_2_north_data_in              (CG_1_1_router_iact_2_2_north_data_in           ),
	.router_iact_2_2_south_address_in_ready     (CG_1_1_router_iact_2_2_south_address_in_ready  ),
	.router_iact_2_2_south_address_in_valid     (CG_1_1_router_iact_2_2_south_address_in_valid  ),
	.router_iact_2_2_south_address_in           (CG_1_1_router_iact_2_2_south_address_in        ),
	.router_iact_2_2_south_data_in_ready        (CG_1_1_router_iact_2_2_south_data_in_ready     ),
	.router_iact_2_2_south_data_in_valid        (CG_1_1_router_iact_2_2_south_data_in_valid     ),
	.router_iact_2_2_south_data_in              (CG_1_1_router_iact_2_2_south_data_in           ),
	.router_iact_2_2_horiz_address_in_ready     (CG_1_1_router_iact_2_2_horiz_address_in_ready  ),
	.router_iact_2_2_horiz_address_in_valid     (CG_1_1_router_iact_2_2_horiz_address_in_valid  ),
	.router_iact_2_2_horiz_address_in           (CG_1_1_router_iact_2_2_horiz_address_in        ),
	.router_iact_2_2_horiz_data_in_ready        (CG_1_1_router_iact_2_2_horiz_data_in_ready     ),
	.router_iact_2_2_horiz_data_in_valid        (CG_1_1_router_iact_2_2_horiz_data_in_valid     ),
	.router_iact_2_2_horiz_data_in              (CG_1_1_router_iact_2_2_horiz_data_in           ),
	.router_iact_2_2_north_address_out_ready	(CG_1_1_router_iact_2_2_north_address_out_ready	),
	.router_iact_2_2_north_address_out_valid    (CG_1_1_router_iact_2_2_north_address_out_valid ),
	.router_iact_2_2_north_address_out          (CG_1_1_router_iact_2_2_north_address_out       ),
	.router_iact_2_2_north_data_out_ready       (CG_1_1_router_iact_2_2_north_data_out_ready    ),
	.router_iact_2_2_north_data_out_valid       (CG_1_1_router_iact_2_2_north_data_out_valid    ),
	.router_iact_2_2_north_data_out             (CG_1_1_router_iact_2_2_north_data_out          ),
	.router_iact_2_2_south_address_out_ready    (CG_1_1_router_iact_2_2_south_address_out_ready ),
	.router_iact_2_2_south_address_out_valid    (CG_1_1_router_iact_2_2_south_address_out_valid ),
	.router_iact_2_2_south_address_out          (CG_1_1_router_iact_2_2_south_address_out       ),
	.router_iact_2_2_south_data_out_ready       (CG_1_1_router_iact_2_2_south_data_out_ready    ),
	.router_iact_2_2_south_data_out_valid       (CG_1_1_router_iact_2_2_south_data_out_valid    ),
	.router_iact_2_2_south_data_out             (CG_1_1_router_iact_2_2_south_data_out          ),
	.router_iact_2_2_horiz_address_out_ready    (CG_1_1_router_iact_2_2_horiz_address_out_ready ),
	.router_iact_2_2_horiz_address_out_valid    (CG_1_1_router_iact_2_2_horiz_address_out_valid ),
	.router_iact_2_2_horiz_address_out          (CG_1_1_router_iact_2_2_horiz_address_out       ),
	.router_iact_2_2_horiz_data_out_ready       (CG_1_1_router_iact_2_2_horiz_data_out_ready    ),
	.router_iact_2_2_horiz_data_out_valid       (CG_1_1_router_iact_2_2_horiz_data_out_valid    ),
	.router_iact_2_2_horiz_data_out             (CG_1_1_router_iact_2_2_horiz_data_out          ),
												
	.router_weight_0_horiz_address_in_ready     (CG_1_1_router_weight_0_horiz_address_in_ready  ),
	.router_weight_0_horiz_address_in_valid     (CG_1_1_router_weight_0_horiz_address_in_valid  ),
	.router_weight_0_horiz_address_in           (CG_1_1_router_weight_0_horiz_address_in        ),
	.router_weight_0_horiz_data_in_ready        (CG_1_1_router_weight_0_horiz_data_in_ready     ),
	.router_weight_0_horiz_data_in_valid        (CG_1_1_router_weight_0_horiz_data_in_valid     ),
	.router_weight_0_horiz_data_in              (CG_1_1_router_weight_0_horiz_data_in           ),
	.router_weight_0_horiz_address_out_ready    (CG_1_1_router_weight_0_horiz_address_out_ready ),
	.router_weight_0_horiz_address_out_valid    (CG_1_1_router_weight_0_horiz_address_out_valid ),
	.router_weight_0_horiz_address_out          (CG_1_1_router_weight_0_horiz_address_out       ),
	.router_weight_0_horiz_data_out_ready       (CG_1_1_router_weight_0_horiz_data_out_ready    ),
	.router_weight_0_horiz_data_out_valid       (CG_1_1_router_weight_0_horiz_data_out_valid    ),
	.router_weight_0_horiz_data_out             (CG_1_1_router_weight_0_horiz_data_out          ),
	.router_weight_1_horiz_address_in_ready     (CG_1_1_router_weight_1_horiz_address_in_ready  ),
	.router_weight_1_horiz_address_in_valid     (CG_1_1_router_weight_1_horiz_address_in_valid  ),
	.router_weight_1_horiz_address_in           (CG_1_1_router_weight_1_horiz_address_in        ),
	.router_weight_1_horiz_data_in_ready        (CG_1_1_router_weight_1_horiz_data_in_ready     ),
	.router_weight_1_horiz_data_in_valid        (CG_1_1_router_weight_1_horiz_data_in_valid     ),
	.router_weight_1_horiz_data_in              (CG_1_1_router_weight_1_horiz_data_in           ),
	.router_weight_1_horiz_address_out_ready    (CG_1_1_router_weight_1_horiz_address_out_ready ),
	.router_weight_1_horiz_address_out_valid    (CG_1_1_router_weight_1_horiz_address_out_valid ),
	.router_weight_1_horiz_address_out          (CG_1_1_router_weight_1_horiz_address_out       ),
	.router_weight_1_horiz_data_out_ready       (CG_1_1_router_weight_1_horiz_data_out_ready    ),
	.router_weight_1_horiz_data_out_valid       (CG_1_1_router_weight_1_horiz_data_out_valid    ),
	.router_weight_1_horiz_data_out             (CG_1_1_router_weight_1_horiz_data_out          ),
	.router_weight_2_horiz_address_in_ready     (CG_1_1_router_weight_2_horiz_address_in_ready  ),
	.router_weight_2_horiz_address_in_valid     (CG_1_1_router_weight_2_horiz_address_in_valid  ),
	.router_weight_2_horiz_address_in           (CG_1_1_router_weight_2_horiz_address_in        ),
	.router_weight_2_horiz_data_in_ready        (CG_1_1_router_weight_2_horiz_data_in_ready     ),
	.router_weight_2_horiz_data_in_valid        (CG_1_1_router_weight_2_horiz_data_in_valid     ),
	.router_weight_2_horiz_data_in              (CG_1_1_router_weight_2_horiz_data_in           ),
	.router_weight_2_horiz_address_out_ready    (CG_1_1_router_weight_2_horiz_address_out_ready ),
	.router_weight_2_horiz_address_out_valid    (CG_1_1_router_weight_2_horiz_address_out_valid ),
	.router_weight_2_horiz_address_out          (CG_1_1_router_weight_2_horiz_address_out       ),
	.router_weight_2_horiz_data_out_ready       (CG_1_1_router_weight_2_horiz_data_out_ready    ),
	.router_weight_2_horiz_data_out_valid       (CG_1_1_router_weight_2_horiz_data_out_valid    ),
	.router_weight_2_horiz_data_out             (CG_1_1_router_weight_2_horiz_data_out          ),
												
	.router_psum_0_north_in_ready               (CG_1_1_router_psum_0_north_in_ready            ),
	.router_psum_0_north_in_valid               (CG_1_1_router_psum_0_north_in_valid            ),
	.router_psum_0_north_in                     (CG_1_1_router_psum_0_north_in                  ),
	.router_psum_0_south_out_ready              (CG_1_1_router_psum_0_south_out_ready           ),
	.router_psum_0_south_out_valid              (CG_1_1_router_psum_0_south_out_valid           ),
	.router_psum_0_south_out                    (CG_1_1_router_psum_0_south_out                 ),
	.router_psum_1_north_in_ready               (CG_1_1_router_psum_1_north_in_ready            ),
	.router_psum_1_north_in_valid               (CG_1_1_router_psum_1_north_in_valid            ),
	.router_psum_1_north_in                     (CG_1_1_router_psum_1_north_in                  ),
	.router_psum_1_south_out_ready              (CG_1_1_router_psum_1_south_out_ready           ),
	.router_psum_1_south_out_valid              (CG_1_1_router_psum_1_south_out_valid           ),
	.router_psum_1_south_out                    (CG_1_1_router_psum_1_south_out                 ),
	.router_psum_2_north_in_ready               (CG_1_1_router_psum_2_north_in_ready            ),
	.router_psum_2_north_in_valid               (CG_1_1_router_psum_2_north_in_valid            ),
	.router_psum_2_north_in                     (CG_1_1_router_psum_2_north_in                  ),
	.router_psum_2_south_out_ready              (CG_1_1_router_psum_2_south_out_ready           ),
	.router_psum_2_south_out_valid              (CG_1_1_router_psum_2_south_out_valid           ),
	.router_psum_2_south_out                    (CG_1_1_router_psum_2_south_out                 ),
												 					
	.cg_south_psum_0_in_ready                   (CG_1_1_cg_south_psum_0_in_ready                ),
	.cg_south_psum_0_in_valid                   (CG_1_1_cg_south_psum_0_in_valid                ),
	.cg_south_psum_0_in                         (CG_1_1_cg_south_psum_0_in                      ),
	.cg_south_psum_1_in_ready                   (CG_1_1_cg_south_psum_1_in_ready                ),
	.cg_south_psum_1_in_valid                   (CG_1_1_cg_south_psum_1_in_valid                ),
	.cg_south_psum_1_in                         (CG_1_1_cg_south_psum_1_in                      ),
	.cg_south_psum_2_in_ready                   (CG_1_1_cg_south_psum_2_in_ready                ),
	.cg_south_psum_2_in_valid                   (CG_1_1_cg_south_psum_2_in_valid                ),
	.cg_south_psum_2_in                         (CG_1_1_cg_south_psum_2_in                      ),
	.cg_north_psum_0_out_ready                  (CG_1_1_cg_north_psum_0_out_ready               ),
	.cg_north_psum_0_out_valid                  (CG_1_1_cg_north_psum_0_out_valid               ),
	.cg_north_psum_0_out                        (CG_1_1_cg_north_psum_0_out                     ),
	.cg_north_psum_1_out_ready                  (CG_1_1_cg_north_psum_1_out_ready               ),
	.cg_north_psum_1_out_valid                  (CG_1_1_cg_north_psum_1_out_valid               ),
	.cg_north_psum_1_out                        (CG_1_1_cg_north_psum_1_out                     ),
	.cg_north_psum_2_out_ready                  (CG_1_1_cg_north_psum_2_out_ready               ),
	.cg_north_psum_2_out_valid                  (CG_1_1_cg_north_psum_2_out_valid               ),
	.cg_north_psum_2_out                        (CG_1_1_cg_north_psum_2_out                     ),
									         
	.PSUM_DEPTH                                 (CG_1_1_PSUM_DEPTH                              ),
	.psum_spad_clear                            (CG_1_1_psum_spad_clear                         ),
											
	.iact_write_fin_clear                       (CG_1_1_iact_write_fin_clear                	),
	.weight_write_fin_clear						(CG_1_1_weight_write_fin_clear					)
);





// ------------------- CG_0_0 ------------------- //
assign	CG_0_0_router_iact_0_0_north_address_out_ready	= 'd1;
assign	CG_0_0_router_iact_0_0_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_0_0_north_address_in         = 'd0;
assign	CG_0_0_router_iact_0_0_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_0_0_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_0_0_north_data_in            = 'd0;
assign	CG_0_0_router_iact_0_0_south_address_out_ready  = CG_1_0_router_iact_0_0_north_address_in_ready;   
assign	CG_0_0_router_iact_0_0_south_address_in_valid   = CG_1_0_router_iact_0_0_north_address_out_valid;   
assign	CG_0_0_router_iact_0_0_south_address_in         = CG_1_0_router_iact_0_0_north_address_out;         
assign	CG_0_0_router_iact_0_0_south_data_out_ready     = CG_1_0_router_iact_0_0_north_data_in_ready;      
assign	CG_0_0_router_iact_0_0_south_data_in_valid      = CG_1_0_router_iact_0_0_north_data_out_valid;      
assign	CG_0_0_router_iact_0_0_south_data_in            = CG_1_0_router_iact_0_0_north_data_out;            
assign	CG_0_0_router_iact_0_0_horiz_address_out_ready  = CG_0_1_router_iact_0_0_horiz_address_in_ready;   
assign	CG_0_0_router_iact_0_0_horiz_address_in_valid   = CG_0_1_router_iact_0_0_horiz_address_out_valid;   
assign	CG_0_0_router_iact_0_0_horiz_address_in         = CG_0_1_router_iact_0_0_horiz_address_out;         
assign	CG_0_0_router_iact_0_0_horiz_data_out_ready     = CG_0_1_router_iact_0_0_horiz_data_in_ready;      
assign	CG_0_0_router_iact_0_0_horiz_data_in_valid      = CG_0_1_router_iact_0_0_horiz_data_out_valid;      
assign	CG_0_0_router_iact_0_0_horiz_data_in            = CG_0_1_router_iact_0_0_horiz_data_out;          
assign	CG_0_0_router_iact_0_1_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_0_1_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_0_1_north_address_in         = 'd0;
assign	CG_0_0_router_iact_0_1_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_0_1_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_0_1_north_data_in            = 'd0;
assign	CG_0_0_router_iact_0_1_south_address_out_ready  = CG_1_0_router_iact_0_1_north_address_in_ready; 
assign	CG_0_0_router_iact_0_1_south_address_in_valid   = CG_1_0_router_iact_0_1_north_address_out_valid; 
assign	CG_0_0_router_iact_0_1_south_address_in         = CG_1_0_router_iact_0_1_north_address_out;       
assign	CG_0_0_router_iact_0_1_south_data_out_ready     = CG_1_0_router_iact_0_1_north_data_in_ready;    
assign	CG_0_0_router_iact_0_1_south_data_in_valid      = CG_1_0_router_iact_0_1_north_data_out_valid;    
assign	CG_0_0_router_iact_0_1_south_data_in            = CG_1_0_router_iact_0_1_north_data_out;          
assign	CG_0_0_router_iact_0_1_horiz_address_out_ready  = CG_0_1_router_iact_0_1_horiz_address_in_ready; 
assign	CG_0_0_router_iact_0_1_horiz_address_in_valid   = CG_0_1_router_iact_0_1_horiz_address_out_valid; 
assign	CG_0_0_router_iact_0_1_horiz_address_in         = CG_0_1_router_iact_0_1_horiz_address_out;       
assign	CG_0_0_router_iact_0_1_horiz_data_out_ready     = CG_0_1_router_iact_0_1_horiz_data_in_ready;    
assign	CG_0_0_router_iact_0_1_horiz_data_in_valid      = CG_0_1_router_iact_0_1_horiz_data_out_valid;    
assign	CG_0_0_router_iact_0_1_horiz_data_in            = CG_0_1_router_iact_0_1_horiz_data_out;          
assign	CG_0_0_router_iact_0_2_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_0_2_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_0_2_north_address_in         = 'd0;
assign	CG_0_0_router_iact_0_2_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_0_2_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_0_2_north_data_in            = 'd0;
assign	CG_0_0_router_iact_0_2_south_address_out_ready  = CG_1_0_router_iact_0_2_north_address_in_ready; 
assign	CG_0_0_router_iact_0_2_south_address_in_valid   = CG_1_0_router_iact_0_2_north_address_out_valid; 
assign	CG_0_0_router_iact_0_2_south_address_in         = CG_1_0_router_iact_0_2_north_address_out;       
assign	CG_0_0_router_iact_0_2_south_data_out_ready     = CG_1_0_router_iact_0_2_north_data_in_ready;    
assign	CG_0_0_router_iact_0_2_south_data_in_valid      = CG_1_0_router_iact_0_2_north_data_out_valid;    
assign	CG_0_0_router_iact_0_2_south_data_in            = CG_1_0_router_iact_0_2_north_data_out;          
assign	CG_0_0_router_iact_0_2_horiz_address_out_ready  = CG_0_1_router_iact_0_2_horiz_address_in_ready; 
assign	CG_0_0_router_iact_0_2_horiz_address_in_valid   = CG_0_1_router_iact_0_2_horiz_address_out_valid; 
assign	CG_0_0_router_iact_0_2_horiz_address_in         = CG_0_1_router_iact_0_2_horiz_address_out;       
assign	CG_0_0_router_iact_0_2_horiz_data_out_ready     = CG_0_1_router_iact_0_2_horiz_data_in_ready;    
assign	CG_0_0_router_iact_0_2_horiz_data_in_valid      = CG_0_1_router_iact_0_2_horiz_data_out_valid;    
assign	CG_0_0_router_iact_0_2_horiz_data_in            = CG_0_1_router_iact_0_2_horiz_data_out;          
assign	CG_0_0_router_iact_1_0_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_1_0_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_1_0_north_address_in         = 'd0;
assign	CG_0_0_router_iact_1_0_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_1_0_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_1_0_north_data_in            = 'd0;
assign	CG_0_0_router_iact_1_0_south_address_out_ready  = CG_1_0_router_iact_1_0_north_address_in_ready; 
assign	CG_0_0_router_iact_1_0_south_address_in_valid   = CG_1_0_router_iact_1_0_north_address_out_valid; 
assign	CG_0_0_router_iact_1_0_south_address_in         = CG_1_0_router_iact_1_0_north_address_out;       
assign	CG_0_0_router_iact_1_0_south_data_out_ready     = CG_1_0_router_iact_1_0_north_data_in_ready;    
assign	CG_0_0_router_iact_1_0_south_data_in_valid      = CG_1_0_router_iact_1_0_north_data_out_valid;    
assign	CG_0_0_router_iact_1_0_south_data_in            = CG_1_0_router_iact_1_0_north_data_out;          
assign	CG_0_0_router_iact_1_0_horiz_address_out_ready  = CG_0_1_router_iact_1_0_horiz_address_in_ready; 
assign	CG_0_0_router_iact_1_0_horiz_address_in_valid   = CG_0_1_router_iact_1_0_horiz_address_out_valid; 
assign	CG_0_0_router_iact_1_0_horiz_address_in         = CG_0_1_router_iact_1_0_horiz_address_out;       
assign	CG_0_0_router_iact_1_0_horiz_data_out_ready     = CG_0_1_router_iact_1_0_horiz_data_in_ready;    
assign	CG_0_0_router_iact_1_0_horiz_data_in_valid      = CG_0_1_router_iact_1_0_horiz_data_out_valid;    
assign	CG_0_0_router_iact_1_0_horiz_data_in            = CG_0_1_router_iact_1_0_horiz_data_out;  
          
assign	CG_0_0_router_iact_1_1_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_1_1_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_1_1_north_address_in         = 'd0;
assign	CG_0_0_router_iact_1_1_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_1_1_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_1_1_north_data_in            = 'd0;
assign	CG_0_0_router_iact_1_1_south_address_out_ready  = CG_1_0_router_iact_1_1_north_address_in_ready; 
assign	CG_0_0_router_iact_1_1_south_address_in_valid   = CG_1_0_router_iact_1_1_north_address_out_valid; 
assign	CG_0_0_router_iact_1_1_south_address_in         = CG_1_0_router_iact_1_1_north_address_out;       
assign	CG_0_0_router_iact_1_1_south_data_out_ready     = CG_1_0_router_iact_1_1_north_data_in_ready;    
assign	CG_0_0_router_iact_1_1_south_data_in_valid      = CG_1_0_router_iact_1_1_north_data_out_valid;    
assign	CG_0_0_router_iact_1_1_south_data_in            = CG_1_0_router_iact_1_1_north_data_out;          
assign	CG_0_0_router_iact_1_1_horiz_address_out_ready  = CG_0_1_router_iact_1_1_horiz_address_in_ready; 
assign	CG_0_0_router_iact_1_1_horiz_address_in_valid   = CG_0_1_router_iact_1_1_horiz_address_out_valid; 
assign	CG_0_0_router_iact_1_1_horiz_address_in         = CG_0_1_router_iact_1_1_horiz_address_out;       
assign	CG_0_0_router_iact_1_1_horiz_data_out_ready     = CG_0_1_router_iact_1_1_horiz_data_in_ready;    
assign	CG_0_0_router_iact_1_1_horiz_data_in_valid      = CG_0_1_router_iact_1_1_horiz_data_out_valid;    
assign	CG_0_0_router_iact_1_1_horiz_data_in            = CG_0_1_router_iact_1_1_horiz_data_out;          		
assign	CG_0_0_router_iact_1_2_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_1_2_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_1_2_north_address_in         = 'd0;
assign	CG_0_0_router_iact_1_2_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_1_2_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_1_2_north_data_in            = 'd0;
assign	CG_0_0_router_iact_1_2_south_address_out_ready  = CG_1_0_router_iact_1_2_north_address_in_ready; 
assign	CG_0_0_router_iact_1_2_south_address_in_valid   = CG_1_0_router_iact_1_2_north_address_out_valid; 
assign	CG_0_0_router_iact_1_2_south_address_in         = CG_1_0_router_iact_1_2_north_address_out;       
assign	CG_0_0_router_iact_1_2_south_data_out_ready     = CG_1_0_router_iact_1_2_north_data_in_ready;    
assign	CG_0_0_router_iact_1_2_south_data_in_valid      = CG_1_0_router_iact_1_2_north_data_out_valid;    
assign	CG_0_0_router_iact_1_2_south_data_in            = CG_1_0_router_iact_1_2_north_data_out;          
assign	CG_0_0_router_iact_1_2_horiz_address_out_ready  = CG_0_1_router_iact_1_2_horiz_address_in_ready; 
assign	CG_0_0_router_iact_1_2_horiz_address_in_valid   = CG_0_1_router_iact_1_2_horiz_address_out_valid; 
assign	CG_0_0_router_iact_1_2_horiz_address_in         = CG_0_1_router_iact_1_2_horiz_address_out;       
assign	CG_0_0_router_iact_1_2_horiz_data_out_ready     = CG_0_1_router_iact_1_2_horiz_data_in_ready;    
assign	CG_0_0_router_iact_1_2_horiz_data_in_valid      = CG_0_1_router_iact_1_2_horiz_data_out_valid;    
assign	CG_0_0_router_iact_1_2_horiz_data_in            = CG_0_1_router_iact_1_2_horiz_data_out;           
assign	CG_0_0_router_iact_2_0_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_2_0_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_2_0_north_address_in         = 'd0;
assign	CG_0_0_router_iact_2_0_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_2_0_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_2_0_north_data_in            = 'd0;
assign	CG_0_0_router_iact_2_0_south_address_out_ready  = CG_1_0_router_iact_2_0_north_address_in_ready; 
assign	CG_0_0_router_iact_2_0_south_address_in_valid   = CG_1_0_router_iact_2_0_north_address_out_valid; 
assign	CG_0_0_router_iact_2_0_south_address_in         = CG_1_0_router_iact_2_0_north_address_out;       
assign	CG_0_0_router_iact_2_0_south_data_out_ready     = CG_1_0_router_iact_2_0_north_data_in_ready;    
assign	CG_0_0_router_iact_2_0_south_data_in_valid      = CG_1_0_router_iact_2_0_north_data_out_valid;    
assign	CG_0_0_router_iact_2_0_south_data_in            = CG_1_0_router_iact_2_0_north_data_out;          
assign	CG_0_0_router_iact_2_0_horiz_address_out_ready  = CG_0_1_router_iact_2_0_horiz_address_in_ready; 
assign	CG_0_0_router_iact_2_0_horiz_address_in_valid   = CG_0_1_router_iact_2_0_horiz_address_out_valid; 
assign	CG_0_0_router_iact_2_0_horiz_address_in         = CG_0_1_router_iact_2_0_horiz_address_out;       
assign	CG_0_0_router_iact_2_0_horiz_data_out_ready     = CG_0_1_router_iact_2_0_horiz_data_in_ready;    
assign	CG_0_0_router_iact_2_0_horiz_data_in_valid      = CG_0_1_router_iact_2_0_horiz_data_out_valid;    
assign	CG_0_0_router_iact_2_0_horiz_data_in            = CG_0_1_router_iact_2_0_horiz_data_out;           					
assign	CG_0_0_router_iact_2_1_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_2_1_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_2_1_north_address_in         = 'd0;
assign	CG_0_0_router_iact_2_1_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_2_1_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_2_1_north_data_in            = 'd0;
assign	CG_0_0_router_iact_2_1_south_address_out_ready  = CG_1_0_router_iact_2_1_north_address_in_ready; 
assign	CG_0_0_router_iact_2_1_south_address_in_valid   = CG_1_0_router_iact_2_1_north_address_out_valid; 
assign	CG_0_0_router_iact_2_1_south_address_in         = CG_1_0_router_iact_2_1_north_address_out;       
assign	CG_0_0_router_iact_2_1_south_data_out_ready     = CG_1_0_router_iact_2_1_north_data_in_ready;    
assign	CG_0_0_router_iact_2_1_south_data_in_valid      = CG_1_0_router_iact_2_1_north_data_out_valid;    
assign	CG_0_0_router_iact_2_1_south_data_in            = CG_1_0_router_iact_2_1_north_data_out;          
assign	CG_0_0_router_iact_2_1_horiz_address_out_ready  = CG_0_1_router_iact_2_1_horiz_address_in_ready; 
assign	CG_0_0_router_iact_2_1_horiz_address_in_valid   = CG_0_1_router_iact_2_1_horiz_address_out_valid; 
assign	CG_0_0_router_iact_2_1_horiz_address_in         = CG_0_1_router_iact_2_1_horiz_address_out;       
assign	CG_0_0_router_iact_2_1_horiz_data_out_ready     = CG_0_1_router_iact_2_1_horiz_data_in_ready;    
assign	CG_0_0_router_iact_2_1_horiz_data_in_valid      = CG_0_1_router_iact_2_1_horiz_data_out_valid;    
assign	CG_0_0_router_iact_2_1_horiz_data_in            = CG_0_1_router_iact_2_1_horiz_data_out;                						
assign	CG_0_0_router_iact_2_2_north_address_out_ready  = 'd1;
assign	CG_0_0_router_iact_2_2_north_address_in_valid   = 'd0;
assign	CG_0_0_router_iact_2_2_north_address_in         = 'd0;
assign	CG_0_0_router_iact_2_2_north_data_out_ready     = 'd1;
assign	CG_0_0_router_iact_2_2_north_data_in_valid      = 'd0;
assign	CG_0_0_router_iact_2_2_north_data_in            = 'd0;
assign	CG_0_0_router_iact_2_2_south_address_out_ready  = CG_1_0_router_iact_2_2_north_address_in_ready; 
assign	CG_0_0_router_iact_2_2_south_address_in_valid   = CG_1_0_router_iact_2_2_north_address_out_valid; 
assign	CG_0_0_router_iact_2_2_south_address_in         = CG_1_0_router_iact_2_2_north_address_out;       
assign	CG_0_0_router_iact_2_2_south_data_out_ready     = CG_1_0_router_iact_2_2_north_data_in_ready;    
assign	CG_0_0_router_iact_2_2_south_data_in_valid      = CG_1_0_router_iact_2_2_north_data_out_valid;    
assign	CG_0_0_router_iact_2_2_south_data_in            = CG_1_0_router_iact_2_2_north_data_out;          
assign	CG_0_0_router_iact_2_2_horiz_address_out_ready  = CG_0_1_router_iact_2_2_horiz_address_in_ready; 
assign	CG_0_0_router_iact_2_2_horiz_address_in_valid   = CG_0_1_router_iact_2_2_horiz_address_out_valid; 
assign	CG_0_0_router_iact_2_2_horiz_address_in         = CG_0_1_router_iact_2_2_horiz_address_out;       
assign	CG_0_0_router_iact_2_2_horiz_data_out_ready     = CG_0_1_router_iact_2_2_horiz_data_in_ready;    
assign	CG_0_0_router_iact_2_2_horiz_data_in_valid      = CG_0_1_router_iact_2_2_horiz_data_out_valid;    
assign	CG_0_0_router_iact_2_2_horiz_data_in            = CG_0_1_router_iact_2_2_horiz_data_out;           

assign	CG_0_0_router_weight_0_horiz_address_out_ready  = CG_0_1_router_weight_0_horiz_address_in_ready;   
assign	CG_0_0_router_weight_0_horiz_address_in_valid   = CG_0_1_router_weight_0_horiz_address_out_valid;   
assign	CG_0_0_router_weight_0_horiz_address_in         = CG_0_1_router_weight_0_horiz_address_out;         
assign	CG_0_0_router_weight_0_horiz_data_out_ready     = CG_0_1_router_weight_0_horiz_data_in_ready;      
assign	CG_0_0_router_weight_0_horiz_data_in_valid      = CG_0_1_router_weight_0_horiz_data_out_valid;      
assign	CG_0_0_router_weight_0_horiz_data_in            = CG_0_1_router_weight_0_horiz_data_out;            
assign	CG_0_0_router_weight_1_horiz_address_out_ready  = CG_0_1_router_weight_1_horiz_address_in_ready;   
assign	CG_0_0_router_weight_1_horiz_address_in_valid   = CG_0_1_router_weight_1_horiz_address_out_valid;   
assign	CG_0_0_router_weight_1_horiz_address_in         = CG_0_1_router_weight_1_horiz_address_out;         
assign	CG_0_0_router_weight_1_horiz_data_out_ready     = CG_0_1_router_weight_1_horiz_data_in_ready;      
assign	CG_0_0_router_weight_1_horiz_data_in_valid      = CG_0_1_router_weight_1_horiz_data_out_valid;      
assign	CG_0_0_router_weight_1_horiz_data_in            = CG_0_1_router_weight_1_horiz_data_out;          
assign	CG_0_0_router_weight_2_horiz_address_out_ready  = CG_0_1_router_weight_2_horiz_address_in_ready;  
assign	CG_0_0_router_weight_2_horiz_address_in_valid   = CG_0_1_router_weight_2_horiz_address_out_valid;   
assign	CG_0_0_router_weight_2_horiz_address_in         = CG_0_1_router_weight_2_horiz_address_out;          
assign	CG_0_0_router_weight_2_horiz_data_out_ready     = CG_0_1_router_weight_2_horiz_data_in_ready;      
assign	CG_0_0_router_weight_2_horiz_data_in_valid      = CG_0_1_router_weight_2_horiz_data_out_valid;      
assign	CG_0_0_router_weight_2_horiz_data_in            = CG_0_1_router_weight_2_horiz_data_out;  
		
assign 	CG_0_0_router_psum_0_north_in_valid             = 'd0;
assign 	CG_0_0_router_psum_0_north_in                   = 'd0;
assign 	CG_0_0_router_psum_0_south_out_ready            = CG_1_0_router_psum_0_north_in_ready;
assign 	CG_0_0_router_psum_1_north_in_valid             = 'd0;
assign 	CG_0_0_router_psum_1_north_in                   = 'd0;
assign 	CG_0_0_router_psum_1_south_out_ready            = CG_1_0_router_psum_1_north_in_ready;
assign 	CG_0_0_router_psum_2_north_in_valid             = 'd0;
assign 	CG_0_0_router_psum_2_north_in                   = 'd0;
assign 	CG_0_0_router_psum_2_south_out_ready            = CG_1_0_router_psum_2_north_in_ready;

assign	CG_0_0_cg_north_psum_0_out_ready                = 'd1;
assign	CG_0_0_cg_south_psum_0_in_valid                 = CG_1_0_cg_north_psum_0_out_valid;
assign	CG_0_0_cg_south_psum_0_in                       = CG_1_0_cg_north_psum_0_out;
assign	CG_0_0_cg_north_psum_1_out_ready                = 'd1;
assign	CG_0_0_cg_south_psum_1_in_valid                 = CG_1_0_cg_north_psum_1_out_valid;
assign	CG_0_0_cg_south_psum_1_in                       = CG_1_0_cg_north_psum_1_out;
assign	CG_0_0_cg_north_psum_2_out_ready                = 'd1;
assign	CG_0_0_cg_south_psum_2_in_valid                 = CG_1_0_cg_north_psum_2_out_valid;
assign	CG_0_0_cg_south_psum_2_in                       = CG_1_0_cg_north_psum_2_out;
                   


// ------------------- CG_0_1 ------------------- //
assign	CG_0_1_router_iact_0_0_north_address_out_ready	= 'd0;
assign	CG_0_1_router_iact_0_0_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_0_0_north_address_in         = 'd0;
assign	CG_0_1_router_iact_0_0_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_0_0_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_0_0_north_data_in            = 'd0;
assign	CG_0_1_router_iact_0_0_south_address_out_ready  = CG_1_1_router_iact_0_0_north_address_in_ready;   
assign	CG_0_1_router_iact_0_0_south_address_in_valid   = CG_1_1_router_iact_0_0_north_address_out_valid;   
assign	CG_0_1_router_iact_0_0_south_address_in         = CG_1_1_router_iact_0_0_north_address_out;         
assign	CG_0_1_router_iact_0_0_south_data_out_ready     = CG_1_1_router_iact_0_0_north_data_in_ready;      
assign	CG_0_1_router_iact_0_0_south_data_in_valid      = CG_1_1_router_iact_0_0_north_data_out_valid;      
assign	CG_0_1_router_iact_0_0_south_data_in            = CG_1_1_router_iact_0_0_north_data_out;            
assign	CG_0_1_router_iact_0_0_horiz_address_out_ready  = CG_0_0_router_iact_0_0_horiz_address_in_ready;   
assign	CG_0_1_router_iact_0_0_horiz_address_in_valid   = CG_0_0_router_iact_0_0_horiz_address_out_valid;   
assign	CG_0_1_router_iact_0_0_horiz_address_in         = CG_0_0_router_iact_0_0_horiz_address_out;         
assign	CG_0_1_router_iact_0_0_horiz_data_out_ready     = CG_0_0_router_iact_0_0_horiz_data_in_ready;      
assign	CG_0_1_router_iact_0_0_horiz_data_in_valid      = CG_0_0_router_iact_0_0_horiz_data_out_valid;      
assign	CG_0_1_router_iact_0_0_horiz_data_in            = CG_0_0_router_iact_0_0_horiz_data_out;          
assign	CG_0_1_router_iact_0_1_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_0_1_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_0_1_north_address_in         = 'd0;
assign	CG_0_1_router_iact_0_1_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_0_1_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_0_1_north_data_in            = 'd0;
assign	CG_0_1_router_iact_0_1_south_address_out_ready  = CG_1_1_router_iact_0_1_north_address_in_ready; 
assign	CG_0_1_router_iact_0_1_south_address_in_valid   = CG_1_1_router_iact_0_1_north_address_out_valid; 
assign	CG_0_1_router_iact_0_1_south_address_in         = CG_1_1_router_iact_0_1_north_address_out;       
assign	CG_0_1_router_iact_0_1_south_data_out_ready     = CG_1_1_router_iact_0_1_north_data_in_ready;    
assign	CG_0_1_router_iact_0_1_south_data_in_valid      = CG_1_1_router_iact_0_1_north_data_out_valid;    
assign	CG_0_1_router_iact_0_1_south_data_in            = CG_1_1_router_iact_0_1_north_data_out;          
assign	CG_0_1_router_iact_0_1_horiz_address_out_ready  = CG_0_0_router_iact_0_1_horiz_address_in_ready; 
assign	CG_0_1_router_iact_0_1_horiz_address_in_valid   = CG_0_0_router_iact_0_1_horiz_address_out_valid; 
assign	CG_0_1_router_iact_0_1_horiz_address_in         = CG_0_0_router_iact_0_1_horiz_address_out;       
assign	CG_0_1_router_iact_0_1_horiz_data_out_ready     = CG_0_0_router_iact_0_1_horiz_data_in_ready;    
assign	CG_0_1_router_iact_0_1_horiz_data_in_valid      = CG_0_0_router_iact_0_1_horiz_data_out_valid;    
assign	CG_0_1_router_iact_0_1_horiz_data_in            = CG_0_0_router_iact_0_1_horiz_data_out;          
assign	CG_0_1_router_iact_0_2_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_0_2_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_0_2_north_address_in         = 'd0;
assign	CG_0_1_router_iact_0_2_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_0_2_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_0_2_north_data_in            = 'd0;
assign	CG_0_1_router_iact_0_2_south_address_out_ready  = CG_1_1_router_iact_0_2_north_address_in_ready; 
assign	CG_0_1_router_iact_0_2_south_address_in_valid   = CG_1_1_router_iact_0_2_north_address_out_valid; 
assign	CG_0_1_router_iact_0_2_south_address_in         = CG_1_1_router_iact_0_2_north_address_out;       
assign	CG_0_1_router_iact_0_2_south_data_out_ready     = CG_1_1_router_iact_0_2_north_data_in_ready;    
assign	CG_0_1_router_iact_0_2_south_data_in_valid      = CG_1_1_router_iact_0_2_north_data_out_valid;    
assign	CG_0_1_router_iact_0_2_south_data_in            = CG_1_1_router_iact_0_2_north_data_out;          
assign	CG_0_1_router_iact_0_2_horiz_address_out_ready  = CG_0_0_router_iact_0_2_horiz_address_in_ready; 
assign	CG_0_1_router_iact_0_2_horiz_address_in_valid   = CG_0_0_router_iact_0_2_horiz_address_out_valid; 
assign	CG_0_1_router_iact_0_2_horiz_address_in         = CG_0_0_router_iact_0_2_horiz_address_out;       
assign	CG_0_1_router_iact_0_2_horiz_data_out_ready     = CG_0_0_router_iact_0_2_horiz_data_in_ready;    
assign	CG_0_1_router_iact_0_2_horiz_data_in_valid      = CG_0_0_router_iact_0_2_horiz_data_out_valid;    
assign	CG_0_1_router_iact_0_2_horiz_data_in            = CG_0_0_router_iact_0_2_horiz_data_out;          
assign	CG_0_1_router_iact_1_0_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_1_0_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_1_0_north_address_in         = 'd0;
assign	CG_0_1_router_iact_1_0_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_1_0_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_1_0_north_data_in            = 'd0;
assign	CG_0_1_router_iact_1_0_south_address_out_ready  = CG_1_1_router_iact_1_0_north_address_in_ready; 
assign	CG_0_1_router_iact_1_0_south_address_in_valid   = CG_1_1_router_iact_1_0_north_address_out_valid; 
assign	CG_0_1_router_iact_1_0_south_address_in         = CG_1_1_router_iact_1_0_north_address_out;       
assign	CG_0_1_router_iact_1_0_south_data_out_ready     = CG_1_1_router_iact_1_0_north_data_in_ready;    
assign	CG_0_1_router_iact_1_0_south_data_in_valid      = CG_1_1_router_iact_1_0_north_data_out_valid;    
assign	CG_0_1_router_iact_1_0_south_data_in            = CG_1_1_router_iact_1_0_north_data_out;          
assign	CG_0_1_router_iact_1_0_horiz_address_out_ready  = CG_0_0_router_iact_1_0_horiz_address_in_ready; 
assign	CG_0_1_router_iact_1_0_horiz_address_in_valid   = CG_0_0_router_iact_1_0_horiz_address_out_valid; 
assign	CG_0_1_router_iact_1_0_horiz_address_in         = CG_0_0_router_iact_1_0_horiz_address_out;       
assign	CG_0_1_router_iact_1_0_horiz_data_out_ready     = CG_0_0_router_iact_1_0_horiz_data_in_ready;    
assign	CG_0_1_router_iact_1_0_horiz_data_in_valid      = CG_0_0_router_iact_1_0_horiz_data_out_valid;    
assign	CG_0_1_router_iact_1_0_horiz_data_in            = CG_0_0_router_iact_1_0_horiz_data_out;            
assign	CG_0_1_router_iact_1_1_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_1_1_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_1_1_north_address_in         = 'd0;
assign	CG_0_1_router_iact_1_1_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_1_1_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_1_1_north_data_in            = 'd0;
assign	CG_0_1_router_iact_1_1_south_address_out_ready  = CG_1_1_router_iact_1_1_north_address_in_ready; 
assign	CG_0_1_router_iact_1_1_south_address_in_valid   = CG_1_1_router_iact_1_1_north_address_out_valid; 
assign	CG_0_1_router_iact_1_1_south_address_in         = CG_1_1_router_iact_1_1_north_address_out;       
assign	CG_0_1_router_iact_1_1_south_data_out_ready     = CG_1_1_router_iact_1_1_north_data_in_ready;    
assign	CG_0_1_router_iact_1_1_south_data_in_valid      = CG_1_1_router_iact_1_1_north_data_out_valid;    
assign	CG_0_1_router_iact_1_1_south_data_in            = CG_1_1_router_iact_1_1_north_data_out;          
assign	CG_0_1_router_iact_1_1_horiz_address_out_ready  = CG_0_0_router_iact_1_1_horiz_address_in_ready; 
assign	CG_0_1_router_iact_1_1_horiz_address_in_valid   = CG_0_0_router_iact_1_1_horiz_address_out_valid; 
assign	CG_0_1_router_iact_1_1_horiz_address_in         = CG_0_0_router_iact_1_1_horiz_address_out;       
assign	CG_0_1_router_iact_1_1_horiz_data_out_ready     = CG_0_0_router_iact_1_1_horiz_data_in_ready;    
assign	CG_0_1_router_iact_1_1_horiz_data_in_valid      = CG_0_0_router_iact_1_1_horiz_data_out_valid;    
assign	CG_0_1_router_iact_1_1_horiz_data_in            = CG_0_0_router_iact_1_1_horiz_data_out;          		
assign	CG_0_1_router_iact_1_2_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_1_2_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_1_2_north_address_in         = 'd0;
assign	CG_0_1_router_iact_1_2_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_1_2_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_1_2_north_data_in            = 'd0;
assign	CG_0_1_router_iact_1_2_south_address_out_ready  = CG_1_1_router_iact_1_2_north_address_in_ready; 
assign	CG_0_1_router_iact_1_2_south_address_in_valid   = CG_1_1_router_iact_1_2_north_address_out_valid; 
assign	CG_0_1_router_iact_1_2_south_address_in         = CG_1_1_router_iact_1_2_north_address_out;       
assign	CG_0_1_router_iact_1_2_south_data_out_ready     = CG_1_1_router_iact_1_2_north_data_in_ready;    
assign	CG_0_1_router_iact_1_2_south_data_in_valid      = CG_1_1_router_iact_1_2_north_data_out_valid;    
assign	CG_0_1_router_iact_1_2_south_data_in            = CG_1_1_router_iact_1_2_north_data_out;          
assign	CG_0_1_router_iact_1_2_horiz_address_out_ready  = CG_0_0_router_iact_1_2_horiz_address_in_ready; 
assign	CG_0_1_router_iact_1_2_horiz_address_in_valid   = CG_0_0_router_iact_1_2_horiz_address_out_valid; 
assign	CG_0_1_router_iact_1_2_horiz_address_in         = CG_0_0_router_iact_1_2_horiz_address_out;       
assign	CG_0_1_router_iact_1_2_horiz_data_out_ready     = CG_0_0_router_iact_1_2_horiz_data_in_ready;    
assign	CG_0_1_router_iact_1_2_horiz_data_in_valid      = CG_0_0_router_iact_1_2_horiz_data_out_valid;    
assign	CG_0_1_router_iact_1_2_horiz_data_in            = CG_0_0_router_iact_1_2_horiz_data_out;           
assign	CG_0_1_router_iact_2_0_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_2_0_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_2_0_north_address_in         = 'd0;
assign	CG_0_1_router_iact_2_0_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_2_0_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_2_0_north_data_in            = 'd0;
assign	CG_0_1_router_iact_2_0_south_address_out_ready  = CG_1_1_router_iact_2_0_north_address_in_ready; 
assign	CG_0_1_router_iact_2_0_south_address_in_valid   = CG_1_1_router_iact_2_0_north_address_out_valid; 
assign	CG_0_1_router_iact_2_0_south_address_in         = CG_1_1_router_iact_2_0_north_address_out;       
assign	CG_0_1_router_iact_2_0_south_data_out_ready     = CG_1_1_router_iact_2_0_north_data_in_ready;    
assign	CG_0_1_router_iact_2_0_south_data_in_valid      = CG_1_1_router_iact_2_0_north_data_out_valid;    
assign	CG_0_1_router_iact_2_0_south_data_in            = CG_1_1_router_iact_2_0_north_data_out;          
assign	CG_0_1_router_iact_2_0_horiz_address_out_ready  = CG_0_0_router_iact_2_0_horiz_address_in_ready; 
assign	CG_0_1_router_iact_2_0_horiz_address_in_valid   = CG_0_0_router_iact_2_0_horiz_address_out_valid; 
assign	CG_0_1_router_iact_2_0_horiz_address_in         = CG_0_0_router_iact_2_0_horiz_address_out;       
assign	CG_0_1_router_iact_2_0_horiz_data_out_ready     = CG_0_0_router_iact_2_0_horiz_data_in_ready;    
assign	CG_0_1_router_iact_2_0_horiz_data_in_valid      = CG_0_0_router_iact_2_0_horiz_data_out_valid;    
assign	CG_0_1_router_iact_2_0_horiz_data_in            = CG_0_0_router_iact_2_0_horiz_data_out;           					
assign	CG_0_1_router_iact_2_1_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_2_1_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_2_1_north_address_in         = 'd0;
assign	CG_0_1_router_iact_2_1_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_2_1_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_2_1_north_data_in            = 'd0;
assign	CG_0_1_router_iact_2_1_south_address_out_ready  = CG_1_1_router_iact_2_1_north_address_in_ready; 
assign	CG_0_1_router_iact_2_1_south_address_in_valid   = CG_1_1_router_iact_2_1_north_address_out_valid; 
assign	CG_0_1_router_iact_2_1_south_address_in         = CG_1_1_router_iact_2_1_north_address_out;       
assign	CG_0_1_router_iact_2_1_south_data_out_ready     = CG_1_1_router_iact_2_1_north_data_in_ready;    
assign	CG_0_1_router_iact_2_1_south_data_in_valid      = CG_1_1_router_iact_2_1_north_data_out_valid;    
assign	CG_0_1_router_iact_2_1_south_data_in            = CG_1_1_router_iact_2_1_north_data_out;          
assign	CG_0_1_router_iact_2_1_horiz_address_out_ready  = CG_0_0_router_iact_2_1_horiz_address_in_ready; 
assign	CG_0_1_router_iact_2_1_horiz_address_in_valid   = CG_0_0_router_iact_2_1_horiz_address_out_valid; 
assign	CG_0_1_router_iact_2_1_horiz_address_in         = CG_0_0_router_iact_2_1_horiz_address_out;       
assign	CG_0_1_router_iact_2_1_horiz_data_out_ready     = CG_0_0_router_iact_2_1_horiz_data_in_ready;    
assign	CG_0_1_router_iact_2_1_horiz_data_in_valid      = CG_0_0_router_iact_2_1_horiz_data_out_valid;    
assign	CG_0_1_router_iact_2_1_horiz_data_in            = CG_0_0_router_iact_2_1_horiz_data_out;                						
assign	CG_0_1_router_iact_2_2_north_address_out_ready  = 'd1;
assign	CG_0_1_router_iact_2_2_north_address_in_valid   = 'd0;
assign	CG_0_1_router_iact_2_2_north_address_in         = 'd0;
assign	CG_0_1_router_iact_2_2_north_data_out_ready     = 'd1;
assign	CG_0_1_router_iact_2_2_north_data_in_valid      = 'd0;
assign	CG_0_1_router_iact_2_2_north_data_in            = 'd0;
assign	CG_0_1_router_iact_2_2_south_address_out_ready  = CG_1_1_router_iact_2_2_north_address_in_ready; 
assign	CG_0_1_router_iact_2_2_south_address_in_valid   = CG_1_1_router_iact_2_2_north_address_out_valid; 
assign	CG_0_1_router_iact_2_2_south_address_in         = CG_1_1_router_iact_2_2_north_address_out;       
assign	CG_0_1_router_iact_2_2_south_data_out_ready     = CG_1_1_router_iact_2_2_north_data_in_ready;    
assign	CG_0_1_router_iact_2_2_south_data_in_valid      = CG_1_1_router_iact_2_2_north_data_out_valid;    
assign	CG_0_1_router_iact_2_2_south_data_in            = CG_1_1_router_iact_2_2_north_data_out;          
assign	CG_0_1_router_iact_2_2_horiz_address_out_ready  = CG_0_0_router_iact_2_2_horiz_address_in_ready; 
assign	CG_0_1_router_iact_2_2_horiz_address_in_valid   = CG_0_0_router_iact_2_2_horiz_address_out_valid; 
assign	CG_0_1_router_iact_2_2_horiz_address_in         = CG_0_0_router_iact_2_2_horiz_address_out;       
assign	CG_0_1_router_iact_2_2_horiz_data_out_ready     = CG_0_0_router_iact_2_2_horiz_data_in_ready;    
assign	CG_0_1_router_iact_2_2_horiz_data_in_valid      = CG_0_0_router_iact_2_2_horiz_data_out_valid;    
assign	CG_0_1_router_iact_2_2_horiz_data_in            = CG_0_0_router_iact_2_2_horiz_data_out;           
			
assign	CG_0_1_router_weight_0_horiz_address_out_ready 	= CG_0_1_router_weight_0_horiz_address_in_ready;   
assign	CG_0_1_router_weight_0_horiz_address_in_valid   = CG_0_0_router_weight_0_horiz_address_out_valid;   
assign	CG_0_1_router_weight_0_horiz_address_in         = CG_0_0_router_weight_0_horiz_address_out;         
assign	CG_0_1_router_weight_0_horiz_data_out_ready     = CG_0_0_router_weight_0_horiz_data_in_ready;      
assign	CG_0_1_router_weight_0_horiz_data_in_valid      = CG_0_0_router_weight_0_horiz_data_out_valid;      
assign	CG_0_1_router_weight_0_horiz_data_in            = CG_0_0_router_weight_0_horiz_data_out;            
assign	CG_0_1_router_weight_1_horiz_address_out_ready  = CG_0_0_router_weight_1_horiz_address_in_ready;   
assign	CG_0_1_router_weight_1_horiz_address_in_valid   = CG_0_0_router_weight_1_horiz_address_out_valid;   
assign	CG_0_1_router_weight_1_horiz_address_in         = CG_0_0_router_weight_1_horiz_address_out;         
assign	CG_0_1_router_weight_1_horiz_data_out_ready     = CG_0_0_router_weight_1_horiz_data_in_ready;      
assign	CG_0_1_router_weight_1_horiz_data_in_valid      = CG_0_0_router_weight_1_horiz_data_out_valid;      
assign	CG_0_1_router_weight_1_horiz_data_in            = CG_0_0_router_weight_1_horiz_data_out;          
assign	CG_0_1_router_weight_2_horiz_address_out_ready  = CG_0_0_router_weight_2_horiz_address_in_ready;  
assign	CG_0_1_router_weight_2_horiz_address_in_valid   = CG_0_0_router_weight_2_horiz_address_out_valid;   
assign	CG_0_1_router_weight_2_horiz_address_in         = CG_0_0_router_weight_2_horiz_address_out;          
assign	CG_0_1_router_weight_2_horiz_data_out_ready     = CG_0_0_router_weight_2_horiz_data_in_ready;      
assign	CG_0_1_router_weight_2_horiz_data_in_valid      = CG_0_0_router_weight_2_horiz_data_out_valid;      
assign	CG_0_1_router_weight_2_horiz_data_in            = CG_0_0_router_weight_2_horiz_data_out;  
				
assign 	CG_0_1_router_psum_0_north_in_valid             = CG_1_1_router_psum_0_south_out_valid;
assign 	CG_0_1_router_psum_0_north_in                   = CG_1_1_router_psum_0_south_out;
assign 	CG_0_1_router_psum_0_south_out_ready            = 'd1;
assign 	CG_0_1_router_psum_1_north_in_valid             = CG_1_1_router_psum_1_south_out_valid;
assign 	CG_0_1_router_psum_1_north_in                   = CG_1_1_router_psum_1_south_out;
assign 	CG_0_1_router_psum_1_south_out_ready            = 'd1;
assign 	CG_0_1_router_psum_2_north_in_valid             = CG_1_1_router_psum_2_south_out_valid;
assign 	CG_0_1_router_psum_2_north_in                   = CG_1_1_router_psum_2_south_out;
assign 	CG_0_1_router_psum_2_south_out_ready            = 'd1;
				
assign	CG_0_1_cg_north_psum_0_out_ready                = 'd1;
assign	CG_0_1_cg_south_psum_0_in_valid                 = CG_1_1_cg_north_psum_0_out_valid;
assign	CG_0_1_cg_south_psum_0_in                       = CG_1_1_cg_north_psum_0_out;
assign	CG_0_1_cg_north_psum_1_out_ready                = 'd1;
assign	CG_0_1_cg_south_psum_1_in_valid                 = CG_1_1_cg_north_psum_1_out_valid;
assign	CG_0_1_cg_south_psum_1_in                       = CG_1_1_cg_north_psum_1_out;
assign	CG_0_1_cg_north_psum_2_out_ready                = 'd1;
assign	CG_0_1_cg_south_psum_2_in_valid                 = CG_1_1_cg_north_psum_2_out_valid;
assign	CG_0_1_cg_south_psum_2_in                       = CG_1_1_cg_north_psum_2_out;



// ------------------- CG_1_0 ------------------- //
assign	CG_1_0_router_iact_0_0_north_address_out_ready	= CG_0_0_router_iact_0_0_south_address_in_ready;	
assign	CG_1_0_router_iact_0_0_north_address_in_valid   = CG_0_0_router_iact_0_0_south_address_out_valid;   
assign	CG_1_0_router_iact_0_0_north_address_in         = CG_0_0_router_iact_0_0_south_address_out;         
assign	CG_1_0_router_iact_0_0_north_data_out_ready      = CG_0_0_router_iact_0_0_south_data_in_ready;      
assign	CG_1_0_router_iact_0_0_north_data_in_valid      = CG_0_0_router_iact_0_0_south_data_out_valid;      
assign	CG_1_0_router_iact_0_0_north_data_in            = CG_0_0_router_iact_0_0_south_data_out;            
assign	CG_1_0_router_iact_0_0_south_address_out_ready   = 'd1;   
assign	CG_1_0_router_iact_0_0_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_0_0_south_address_in         = 'd0;
assign	CG_1_0_router_iact_0_0_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_0_0_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_0_0_south_data_in            = 'd0;
assign	CG_1_0_router_iact_0_0_horiz_address_out_ready   = CG_1_1_router_iact_0_0_horiz_address_in_ready;   
assign	CG_1_0_router_iact_0_0_horiz_address_in_valid   = CG_1_1_router_iact_0_0_horiz_address_out_valid;   
assign	CG_1_0_router_iact_0_0_horiz_address_in         = CG_1_1_router_iact_0_0_horiz_address_out;         
assign	CG_1_0_router_iact_0_0_horiz_data_out_ready      = CG_1_1_router_iact_0_0_horiz_data_in_ready;      
assign	CG_1_0_router_iact_0_0_horiz_data_in_valid      = CG_1_1_router_iact_0_0_horiz_data_out_valid;      
assign	CG_1_0_router_iact_0_0_horiz_data_in            = CG_1_1_router_iact_0_0_horiz_data_out;          
assign	CG_1_0_router_iact_0_1_north_address_out_ready   = CG_0_0_router_iact_0_1_south_address_in_ready;	
assign	CG_1_0_router_iact_0_1_north_address_in_valid   = CG_0_0_router_iact_0_1_south_address_out_valid;   
assign	CG_1_0_router_iact_0_1_north_address_in         = CG_0_0_router_iact_0_1_south_address_out;         
assign	CG_1_0_router_iact_0_1_north_data_out_ready      = CG_0_0_router_iact_0_1_south_data_in_ready;      
assign	CG_1_0_router_iact_0_1_north_data_in_valid      = CG_0_0_router_iact_0_1_south_data_out_valid;      
assign	CG_1_0_router_iact_0_1_north_data_in            = CG_0_0_router_iact_0_1_south_data_out;            
assign	CG_1_0_router_iact_0_1_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_0_1_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_0_1_south_address_in         = 'd0;
assign	CG_1_0_router_iact_0_1_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_0_1_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_0_1_south_data_in            = 'd0;
assign	CG_1_0_router_iact_0_1_horiz_address_out_ready   = CG_1_1_router_iact_0_1_horiz_address_in_ready; 
assign	CG_1_0_router_iact_0_1_horiz_address_in_valid   = CG_1_1_router_iact_0_1_horiz_address_out_valid; 
assign	CG_1_0_router_iact_0_1_horiz_address_in         = CG_1_1_router_iact_0_1_horiz_address_out;       
assign	CG_1_0_router_iact_0_1_horiz_data_out_ready      = CG_1_1_router_iact_0_1_horiz_data_in_ready;    
assign	CG_1_0_router_iact_0_1_horiz_data_in_valid      = CG_1_1_router_iact_0_1_horiz_data_out_valid;    
assign	CG_1_0_router_iact_0_1_horiz_data_in            = CG_1_1_router_iact_0_1_horiz_data_out;          
assign	CG_1_0_router_iact_0_2_north_address_out_ready   = CG_0_0_router_iact_0_2_south_address_in_ready;   
assign	CG_1_0_router_iact_0_2_north_address_in_valid   = CG_0_0_router_iact_0_2_south_address_out_valid;   
assign	CG_1_0_router_iact_0_2_north_address_in         = CG_0_0_router_iact_0_2_south_address_out;         
assign	CG_1_0_router_iact_0_2_north_data_out_ready      = CG_0_0_router_iact_0_2_south_data_in_ready;      
assign	CG_1_0_router_iact_0_2_north_data_in_valid      = CG_0_0_router_iact_0_2_south_data_out_valid;      
assign	CG_1_0_router_iact_0_2_north_data_in            = CG_0_0_router_iact_0_2_south_data_out;            
assign	CG_1_0_router_iact_0_2_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_0_2_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_0_2_south_address_in         = 'd0;
assign	CG_1_0_router_iact_0_2_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_0_2_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_0_2_south_data_in            = 'd0;
assign	CG_1_0_router_iact_0_2_horiz_address_out_ready   = CG_1_1_router_iact_0_2_horiz_address_in_ready; 
assign	CG_1_0_router_iact_0_2_horiz_address_in_valid   = CG_1_1_router_iact_0_2_horiz_address_out_valid; 
assign	CG_1_0_router_iact_0_2_horiz_address_in         = CG_1_1_router_iact_0_2_horiz_address_out;       
assign	CG_1_0_router_iact_0_2_horiz_data_out_ready      = CG_1_1_router_iact_0_2_horiz_data_in_ready;    
assign	CG_1_0_router_iact_0_2_horiz_data_in_valid      = CG_1_1_router_iact_0_2_horiz_data_out_valid;    
assign	CG_1_0_router_iact_0_2_horiz_data_in            = CG_1_1_router_iact_0_2_horiz_data_out;          
assign	CG_1_0_router_iact_1_0_north_address_out_ready   = CG_0_0_router_iact_1_0_south_address_in_ready;   
assign	CG_1_0_router_iact_1_0_north_address_in_valid   = CG_0_0_router_iact_1_0_south_address_out_valid;   
assign	CG_1_0_router_iact_1_0_north_address_in         = CG_0_0_router_iact_1_0_south_address_out;         
assign	CG_1_0_router_iact_1_0_north_data_out_ready      = CG_0_0_router_iact_1_0_south_data_in_ready;      
assign	CG_1_0_router_iact_1_0_north_data_in_valid      = CG_0_0_router_iact_1_0_south_data_out_valid;     
assign	CG_1_0_router_iact_1_0_north_data_in            = CG_0_0_router_iact_1_0_south_data_out;      
assign	CG_1_0_router_iact_1_0_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_1_0_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_1_0_south_address_in         = 'd0;
assign	CG_1_0_router_iact_1_0_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_1_0_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_1_0_south_data_in            = 'd0;
assign	CG_1_0_router_iact_1_0_horiz_address_out_ready   = CG_1_1_router_iact_1_0_horiz_address_in_ready; 
assign	CG_1_0_router_iact_1_0_horiz_address_in_valid   = CG_1_1_router_iact_1_0_horiz_address_out_valid; 
assign	CG_1_0_router_iact_1_0_horiz_address_in         = CG_1_1_router_iact_1_0_horiz_address_out;       
assign	CG_1_0_router_iact_1_0_horiz_data_out_ready      = CG_1_1_router_iact_1_0_horiz_data_in_ready;    
assign	CG_1_0_router_iact_1_0_horiz_data_in_valid      = CG_1_1_router_iact_1_0_horiz_data_out_valid;    
assign	CG_1_0_router_iact_1_0_horiz_data_in            = CG_1_1_router_iact_1_0_horiz_data_out;            
assign	CG_1_0_router_iact_1_1_north_address_out_ready   = CG_0_0_router_iact_1_1_south_address_in_ready;   
assign	CG_1_0_router_iact_1_1_north_address_in_valid   = CG_0_0_router_iact_1_1_south_address_out_valid;   
assign	CG_1_0_router_iact_1_1_north_address_in         = CG_0_0_router_iact_1_1_south_address_out;         
assign	CG_1_0_router_iact_1_1_north_data_out_ready      = CG_0_0_router_iact_1_1_south_data_in_ready;      
assign	CG_1_0_router_iact_1_1_north_data_in_valid      = CG_0_0_router_iact_1_1_south_data_out_valid;      
assign	CG_1_0_router_iact_1_1_north_data_in            = CG_0_0_router_iact_1_1_south_data_out;            
assign	CG_1_0_router_iact_1_1_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_1_1_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_1_1_south_address_in         = 'd0;
assign	CG_1_0_router_iact_1_1_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_1_1_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_1_1_south_data_in            = 'd0;
assign	CG_1_0_router_iact_1_1_horiz_address_out_ready   = CG_1_1_router_iact_1_1_horiz_address_in_ready; 
assign	CG_1_0_router_iact_1_1_horiz_address_in_valid   = CG_1_1_router_iact_1_1_horiz_address_out_valid; 
assign	CG_1_0_router_iact_1_1_horiz_address_in         = CG_1_1_router_iact_1_1_horiz_address_out;       
assign	CG_1_0_router_iact_1_1_horiz_data_out_ready      = CG_1_1_router_iact_1_1_horiz_data_in_ready;    
assign	CG_1_0_router_iact_1_1_horiz_data_in_valid      = CG_1_1_router_iact_1_1_horiz_data_out_valid;    
assign	CG_1_0_router_iact_1_1_horiz_data_in            = CG_1_1_router_iact_1_1_horiz_data_out;          		
assign	CG_1_0_router_iact_1_2_north_address_out_ready   = CG_0_0_router_iact_1_2_south_address_in_ready;   
assign	CG_1_0_router_iact_1_2_north_address_in_valid   = CG_0_0_router_iact_1_2_south_address_out_valid;   
assign	CG_1_0_router_iact_1_2_north_address_in         = CG_0_0_router_iact_1_2_south_address_out;         
assign	CG_1_0_router_iact_1_2_north_data_out_ready      = CG_0_0_router_iact_1_2_south_data_in_ready;      
assign	CG_1_0_router_iact_1_2_north_data_in_valid      = CG_0_0_router_iact_1_2_south_data_out_valid;      
assign	CG_1_0_router_iact_1_2_north_data_in            = CG_0_0_router_iact_1_2_south_data_out;            
assign	CG_1_0_router_iact_1_2_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_1_2_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_1_2_south_address_in         = 'd0;
assign	CG_1_0_router_iact_1_2_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_1_2_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_1_2_south_data_in            = 'd0;
assign	CG_1_0_router_iact_1_2_horiz_address_out_ready   = CG_1_1_router_iact_1_2_horiz_address_in_ready; 
assign	CG_1_0_router_iact_1_2_horiz_address_in_valid   = CG_1_1_router_iact_1_2_horiz_address_out_valid; 
assign	CG_1_0_router_iact_1_2_horiz_address_in         = CG_1_1_router_iact_1_2_horiz_address_out;       
assign	CG_1_0_router_iact_1_2_horiz_data_out_ready      = CG_1_1_router_iact_1_2_horiz_data_in_ready;    
assign	CG_1_0_router_iact_1_2_horiz_data_in_valid      = CG_1_1_router_iact_1_2_horiz_data_out_valid;    
assign	CG_1_0_router_iact_1_2_horiz_data_in            = CG_1_1_router_iact_1_2_horiz_data_out;           
assign	CG_1_0_router_iact_2_0_north_address_out_ready   = CG_0_0_router_iact_2_0_south_address_in_ready;   
assign	CG_1_0_router_iact_2_0_north_address_in_valid   = CG_0_0_router_iact_2_0_south_address_out_valid;   
assign	CG_1_0_router_iact_2_0_north_address_in         = CG_0_0_router_iact_2_0_south_address_out;         
assign	CG_1_0_router_iact_2_0_north_data_out_ready      = CG_0_0_router_iact_2_0_south_data_in_ready;      
assign	CG_1_0_router_iact_2_0_north_data_in_valid      = CG_0_0_router_iact_2_0_south_data_out_valid;      
assign	CG_1_0_router_iact_2_0_north_data_in            = CG_0_0_router_iact_2_0_south_data_out;            
assign	CG_1_0_router_iact_2_0_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_2_0_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_2_0_south_address_in         = 'd0;
assign	CG_1_0_router_iact_2_0_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_2_0_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_2_0_south_data_in            = 'd0;
assign	CG_1_0_router_iact_2_0_horiz_address_out_ready   = CG_1_1_router_iact_2_0_horiz_address_in_ready; 
assign	CG_1_0_router_iact_2_0_horiz_address_in_valid   = CG_1_1_router_iact_2_0_horiz_address_out_valid; 
assign	CG_1_0_router_iact_2_0_horiz_address_in         = CG_1_1_router_iact_2_0_horiz_address_out;       
assign	CG_1_0_router_iact_2_0_horiz_data_out_ready      = CG_1_1_router_iact_2_0_horiz_data_in_ready;    
assign	CG_1_0_router_iact_2_0_horiz_data_in_valid      = CG_1_1_router_iact_2_0_horiz_data_out_valid;    
assign	CG_1_0_router_iact_2_0_horiz_data_in            = CG_1_1_router_iact_2_0_horiz_data_out;           					
assign	CG_1_0_router_iact_2_1_north_address_out_ready   = CG_0_0_router_iact_2_1_south_address_in_ready;   
assign	CG_1_0_router_iact_2_1_north_address_in_valid   = CG_0_0_router_iact_2_1_south_address_out_valid;   
assign	CG_1_0_router_iact_2_1_north_address_in         = CG_0_0_router_iact_2_1_south_address_out;         
assign	CG_1_0_router_iact_2_1_north_data_out_ready      = CG_0_0_router_iact_2_1_south_data_in_ready;      
assign	CG_1_0_router_iact_2_1_north_data_in_valid      = CG_0_0_router_iact_2_1_south_data_out_valid;      
assign	CG_1_0_router_iact_2_1_north_data_in            = CG_0_0_router_iact_2_1_south_data_out;            
assign	CG_1_0_router_iact_2_1_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_2_1_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_2_1_south_address_in         = 'd0;
assign	CG_1_0_router_iact_2_1_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_2_1_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_2_1_south_data_in            = 'd0;
assign	CG_1_0_router_iact_2_1_horiz_address_out_ready   = CG_1_1_router_iact_2_1_horiz_address_in_ready; 
assign	CG_1_0_router_iact_2_1_horiz_address_in_valid   = CG_1_1_router_iact_2_1_horiz_address_out_valid; 
assign	CG_1_0_router_iact_2_1_horiz_address_in         = CG_1_1_router_iact_2_1_horiz_address_out;       
assign	CG_1_0_router_iact_2_1_horiz_data_out_ready      = CG_1_1_router_iact_2_1_horiz_data_in_ready;    
assign	CG_1_0_router_iact_2_1_horiz_data_in_valid      = CG_1_1_router_iact_2_1_horiz_data_out_valid;    
assign	CG_1_0_router_iact_2_1_horiz_data_in            = CG_1_1_router_iact_2_1_horiz_data_out;                						
assign	CG_1_0_router_iact_2_2_north_address_out_ready   = CG_0_0_router_iact_2_2_south_address_in_ready;   
assign	CG_1_0_router_iact_2_2_north_address_in_valid   = CG_0_0_router_iact_2_2_south_address_out_valid;   
assign	CG_1_0_router_iact_2_2_north_address_in         = CG_0_0_router_iact_2_2_south_address_out;         
assign	CG_1_0_router_iact_2_2_north_data_out_ready      = CG_0_0_router_iact_2_2_south_data_in_ready;      
assign	CG_1_0_router_iact_2_2_north_data_in_valid      = CG_0_0_router_iact_2_2_south_data_out_valid;      
assign	CG_1_0_router_iact_2_2_north_data_in            = CG_0_0_router_iact_2_2_south_data_out;            
assign	CG_1_0_router_iact_2_2_south_address_out_ready   = 'd1;
assign	CG_1_0_router_iact_2_2_south_address_in_valid   = 'd0;
assign	CG_1_0_router_iact_2_2_south_address_in         = 'd0;
assign	CG_1_0_router_iact_2_2_south_data_out_ready      = 'd1;
assign	CG_1_0_router_iact_2_2_south_data_in_valid      = 'd0;
assign	CG_1_0_router_iact_2_2_south_data_in            = 'd0;
assign	CG_1_0_router_iact_2_2_horiz_address_out_ready   = CG_1_1_router_iact_2_2_horiz_address_in_ready; 
assign	CG_1_0_router_iact_2_2_horiz_address_in_valid   = CG_1_1_router_iact_2_2_horiz_address_out_valid; 
assign	CG_1_0_router_iact_2_2_horiz_address_in         = CG_1_1_router_iact_2_2_horiz_address_out;       
assign	CG_1_0_router_iact_2_2_horiz_data_out_ready      = CG_1_1_router_iact_2_2_horiz_data_in_ready;    
assign	CG_1_0_router_iact_2_2_horiz_data_in_valid      = CG_1_1_router_iact_2_2_horiz_data_out_valid;    
assign	CG_1_0_router_iact_2_2_horiz_data_in            = CG_1_1_router_iact_2_2_horiz_data_out;           
		  
assign	CG_1_0_router_weight_0_horiz_address_out_ready   = CG_1_1_router_weight_0_horiz_address_in_ready;   
assign	CG_1_0_router_weight_0_horiz_address_in_valid   = CG_1_1_router_weight_0_horiz_address_out_valid;   
assign	CG_1_0_router_weight_0_horiz_address_in         = CG_1_1_router_weight_0_horiz_address_out;         
assign	CG_1_0_router_weight_0_horiz_data_out_ready      = CG_1_1_router_weight_0_horiz_data_in_ready;      
assign	CG_1_0_router_weight_0_horiz_data_in_valid      = CG_1_1_router_weight_0_horiz_data_out_valid;      
assign	CG_1_0_router_weight_0_horiz_data_in            = CG_1_1_router_weight_0_horiz_data_out;            
assign	CG_1_0_router_weight_1_horiz_address_out_ready   = CG_1_1_router_weight_1_horiz_address_in_ready;   
assign	CG_1_0_router_weight_1_horiz_address_in_valid   = CG_1_1_router_weight_1_horiz_address_out_valid;   
assign	CG_1_0_router_weight_1_horiz_address_in         = CG_1_1_router_weight_1_horiz_address_out;         
assign	CG_1_0_router_weight_1_horiz_data_out_ready      = CG_1_1_router_weight_1_horiz_data_in_ready;      
assign	CG_1_0_router_weight_1_horiz_data_in_valid      = CG_1_1_router_weight_1_horiz_data_out_valid;      
assign	CG_1_0_router_weight_1_horiz_data_in            = CG_1_1_router_weight_1_horiz_data_out;          
assign	CG_1_0_router_weight_2_horiz_address_out_ready   = CG_1_1_router_weight_2_horiz_address_in_ready;  
assign	CG_1_0_router_weight_2_horiz_address_in_valid   = CG_1_1_router_weight_2_horiz_address_out_valid;   
assign	CG_1_0_router_weight_2_horiz_address_in         = CG_1_1_router_weight_2_horiz_address_out;          
assign	CG_1_0_router_weight_2_horiz_data_out_ready      = CG_1_1_router_weight_2_horiz_data_in_ready;      
assign	CG_1_0_router_weight_2_horiz_data_in_valid      = CG_1_1_router_weight_2_horiz_data_out_valid;      
assign	CG_1_0_router_weight_2_horiz_data_in            = CG_1_1_router_weight_2_horiz_data_out;  
				
assign 	CG_1_0_router_psum_0_north_in_valid             = CG_0_0_router_psum_0_south_out_valid;
assign 	CG_1_0_router_psum_0_north_in                   = CG_0_0_router_psum_0_south_out;
assign 	CG_1_0_router_psum_0_south_out_ready            = 'd1;
assign 	CG_1_0_router_psum_1_north_in_valid             = CG_0_0_router_psum_1_south_out_valid;
assign 	CG_1_0_router_psum_1_north_in                   = CG_0_0_router_psum_1_south_out;
assign 	CG_1_0_router_psum_1_south_out_ready            = 'd1;
assign 	CG_1_0_router_psum_2_north_in_valid             = CG_0_0_router_psum_2_south_out_valid;
assign 	CG_1_0_router_psum_2_north_in                   = CG_0_0_router_psum_2_south_out;
assign 	CG_1_0_router_psum_2_south_out_ready            = 'd1;
				
assign	CG_1_0_cg_north_psum_0_out_ready                = CG_0_0_cg_south_psum_0_in_ready;
assign	CG_1_0_cg_south_psum_0_in_valid                 = 'd1;
assign	CG_1_0_cg_south_psum_0_in                       = 'd0;
assign	CG_1_0_cg_north_psum_1_out_ready                = CG_0_0_cg_south_psum_1_in_ready;
assign	CG_1_0_cg_south_psum_1_in_valid                 = 'd1;
assign	CG_1_0_cg_south_psum_1_in                       = 'd0;
assign	CG_1_0_cg_north_psum_2_out_ready                = CG_0_0_cg_south_psum_2_in_ready;
assign	CG_1_0_cg_south_psum_2_in_valid                 = 'd1;
assign	CG_1_0_cg_south_psum_2_in                       = 'd0;
                   


// ------------------- CG_1_1 ------------------- //
assign	CG_1_1_router_iact_0_0_north_address_out_ready	= CG_0_1_router_iact_0_0_south_address_in_ready;	
assign	CG_1_1_router_iact_0_0_north_address_in_valid   = CG_0_1_router_iact_0_0_south_address_out_valid;   
assign	CG_1_1_router_iact_0_0_north_address_in         = CG_0_1_router_iact_0_0_south_address_out;         
assign	CG_1_1_router_iact_0_0_north_data_out_ready      = CG_0_1_router_iact_0_0_south_data_in_ready;      
assign	CG_1_1_router_iact_0_0_north_data_in_valid      = CG_0_1_router_iact_0_0_south_data_out_valid;      
assign	CG_1_1_router_iact_0_0_north_data_in            = CG_0_1_router_iact_0_0_south_data_out;            
assign	CG_1_1_router_iact_0_0_south_address_out_ready   = 'd1;   
assign	CG_1_1_router_iact_0_0_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_0_0_south_address_in         = 'd0;
assign	CG_1_1_router_iact_0_0_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_0_0_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_0_0_south_data_in            = 'd0;
assign	CG_1_1_router_iact_0_0_horiz_address_out_ready   = CG_1_0_router_iact_0_0_horiz_address_in_ready;   
assign	CG_1_1_router_iact_0_0_horiz_address_in_valid   = CG_1_0_router_iact_0_0_horiz_address_out_valid;   
assign	CG_1_1_router_iact_0_0_horiz_address_in         = CG_1_0_router_iact_0_0_horiz_address_out;         
assign	CG_1_1_router_iact_0_0_horiz_data_out_ready      = CG_1_0_router_iact_0_0_horiz_data_in_ready;      
assign	CG_1_1_router_iact_0_0_horiz_data_in_valid      = CG_1_0_router_iact_0_0_horiz_data_out_valid;      
assign	CG_1_1_router_iact_0_0_horiz_data_in            = CG_1_0_router_iact_0_0_horiz_data_out;          
assign	CG_1_1_router_iact_0_1_north_address_out_ready   = CG_0_1_router_iact_0_1_south_address_in_ready;	
assign	CG_1_1_router_iact_0_1_north_address_in_valid   = CG_0_1_router_iact_0_1_south_address_out_valid;   
assign	CG_1_1_router_iact_0_1_north_address_in         = CG_0_1_router_iact_0_1_south_address_out;         
assign	CG_1_1_router_iact_0_1_north_data_out_ready      = CG_0_1_router_iact_0_1_south_data_in_ready;      
assign	CG_1_1_router_iact_0_1_north_data_in_valid      = CG_0_1_router_iact_0_1_south_data_out_valid;      
assign	CG_1_1_router_iact_0_1_north_data_in            = CG_0_1_router_iact_0_1_south_data_out;            
assign	CG_1_1_router_iact_0_1_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_0_1_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_0_1_south_address_in         = 'd0;
assign	CG_1_1_router_iact_0_1_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_0_1_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_0_1_south_data_in            = 'd0;
assign	CG_1_1_router_iact_0_1_horiz_address_out_ready   = CG_1_0_router_iact_0_1_horiz_address_in_ready; 
assign	CG_1_1_router_iact_0_1_horiz_address_in_valid   = CG_1_0_router_iact_0_1_horiz_address_out_valid; 
assign	CG_1_1_router_iact_0_1_horiz_address_in         = CG_1_0_router_iact_0_1_horiz_address_out;       
assign	CG_1_1_router_iact_0_1_horiz_data_out_ready      = CG_1_0_router_iact_0_1_horiz_data_in_ready;    
assign	CG_1_1_router_iact_0_1_horiz_data_in_valid      = CG_1_0_router_iact_0_1_horiz_data_out_valid;    
assign	CG_1_1_router_iact_0_1_horiz_data_in            = CG_1_0_router_iact_0_1_horiz_data_out;          
assign	CG_1_1_router_iact_0_2_north_address_out_ready   = CG_0_1_router_iact_0_2_south_address_in_ready;   
assign	CG_1_1_router_iact_0_2_north_address_in_valid   = CG_0_1_router_iact_0_2_south_address_out_valid;   
assign	CG_1_1_router_iact_0_2_north_address_in         = CG_0_1_router_iact_0_2_south_address_out;         
assign	CG_1_1_router_iact_0_2_north_data_out_ready      = CG_0_1_router_iact_0_2_south_data_in_ready;      
assign	CG_1_1_router_iact_0_2_north_data_in_valid      = CG_0_1_router_iact_0_2_south_data_out_valid;      
assign	CG_1_1_router_iact_0_2_north_data_in            = CG_0_1_router_iact_0_2_south_data_out;            
assign	CG_1_1_router_iact_0_2_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_0_2_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_0_2_south_address_in         = 'd0;
assign	CG_1_1_router_iact_0_2_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_0_2_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_0_2_south_data_in            = 'd0;
assign	CG_1_1_router_iact_0_2_horiz_address_out_ready   = CG_1_0_router_iact_0_2_horiz_address_in_ready; 
assign	CG_1_1_router_iact_0_2_horiz_address_in_valid   = CG_1_0_router_iact_0_2_horiz_address_out_valid; 
assign	CG_1_1_router_iact_0_2_horiz_address_in         = CG_1_0_router_iact_0_2_horiz_address_out;       
assign	CG_1_1_router_iact_0_2_horiz_data_out_ready      = CG_1_0_router_iact_0_2_horiz_data_in_ready;    
assign	CG_1_1_router_iact_0_2_horiz_data_in_valid      = CG_1_0_router_iact_0_2_horiz_data_out_valid;    
assign	CG_1_1_router_iact_0_2_horiz_data_in            = CG_1_0_router_iact_0_2_horiz_data_out;          
assign	CG_1_1_router_iact_1_0_north_address_out_ready   = CG_0_1_router_iact_1_0_south_address_in_ready;   
assign	CG_1_1_router_iact_1_0_north_address_in_valid   = CG_0_1_router_iact_1_0_south_address_out_valid;   
assign	CG_1_1_router_iact_1_0_north_address_in         = CG_0_1_router_iact_1_0_south_address_out;         
assign	CG_1_1_router_iact_1_0_north_data_out_ready      = CG_0_1_router_iact_1_0_south_data_in_ready;      
assign	CG_1_1_router_iact_1_0_north_data_in_valid      = CG_0_1_router_iact_1_0_south_data_out_valid;     
assign	CG_1_1_router_iact_1_0_north_data_in            = CG_0_1_router_iact_1_0_south_data_out;      
assign	CG_1_1_router_iact_1_0_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_1_0_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_1_0_south_address_in         = 'd0;
assign	CG_1_1_router_iact_1_0_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_1_0_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_1_0_south_data_in            = 'd0;
assign	CG_1_1_router_iact_1_0_horiz_address_out_ready   = CG_1_0_router_iact_1_0_horiz_address_in_ready; 
assign	CG_1_1_router_iact_1_0_horiz_address_in_valid   = CG_1_0_router_iact_1_0_horiz_address_out_valid; 
assign	CG_1_1_router_iact_1_0_horiz_address_in         = CG_1_0_router_iact_1_0_horiz_address_out;       
assign	CG_1_1_router_iact_1_0_horiz_data_out_ready      = CG_1_0_router_iact_1_0_horiz_data_in_ready;    
assign	CG_1_1_router_iact_1_0_horiz_data_in_valid      = CG_1_0_router_iact_1_0_horiz_data_out_valid;    
assign	CG_1_1_router_iact_1_0_horiz_data_in            = CG_1_0_router_iact_1_0_horiz_data_out;            
assign	CG_1_1_router_iact_1_1_north_address_out_ready   = CG_0_1_router_iact_1_1_south_address_in_ready;   
assign	CG_1_1_router_iact_1_1_north_address_in_valid   = CG_0_1_router_iact_1_1_south_address_out_valid;   
assign	CG_1_1_router_iact_1_1_north_address_in         = CG_0_1_router_iact_1_1_south_address_out;         
assign	CG_1_1_router_iact_1_1_north_data_out_ready      = CG_0_1_router_iact_1_1_south_data_in_ready;      
assign	CG_1_1_router_iact_1_1_north_data_in_valid      = CG_0_1_router_iact_1_1_south_data_out_valid;      
assign	CG_1_1_router_iact_1_1_north_data_in            = CG_0_1_router_iact_1_1_south_data_out;            
assign	CG_1_1_router_iact_1_1_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_1_1_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_1_1_south_address_in         = 'd0;
assign	CG_1_1_router_iact_1_1_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_1_1_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_1_1_south_data_in            = 'd0;
assign	CG_1_1_router_iact_1_1_horiz_address_out_ready   = CG_1_0_router_iact_1_1_horiz_address_in_ready; 
assign	CG_1_1_router_iact_1_1_horiz_address_in_valid   = CG_1_0_router_iact_1_1_horiz_address_out_valid; 
assign	CG_1_1_router_iact_1_1_horiz_address_in         = CG_1_0_router_iact_1_1_horiz_address_out;       
assign	CG_1_1_router_iact_1_1_horiz_data_out_ready      = CG_1_0_router_iact_1_1_horiz_data_in_ready;    
assign	CG_1_1_router_iact_1_1_horiz_data_in_valid      = CG_1_0_router_iact_1_1_horiz_data_out_valid;    
assign	CG_1_1_router_iact_1_1_horiz_data_in            = CG_1_0_router_iact_1_1_horiz_data_out;          		
assign	CG_1_1_router_iact_1_2_north_address_out_ready   = CG_0_1_router_iact_1_2_south_address_in_ready;   
assign	CG_1_1_router_iact_1_2_north_address_in_valid   = CG_0_1_router_iact_1_2_south_address_out_valid;   
assign	CG_1_1_router_iact_1_2_north_address_in         = CG_0_1_router_iact_1_2_south_address_out;         
assign	CG_1_1_router_iact_1_2_north_data_out_ready      = CG_0_1_router_iact_1_2_south_data_in_ready;      
assign	CG_1_1_router_iact_1_2_north_data_in_valid      = CG_0_1_router_iact_1_2_south_data_out_valid;      
assign	CG_1_1_router_iact_1_2_north_data_in            = CG_0_1_router_iact_1_2_south_data_out;            
assign	CG_1_1_router_iact_1_2_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_1_2_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_1_2_south_address_in         = 'd0;
assign	CG_1_1_router_iact_1_2_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_1_2_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_1_2_south_data_in            = 'd0;
assign	CG_1_1_router_iact_1_2_horiz_address_out_ready   = CG_1_0_router_iact_1_2_horiz_address_in_ready; 
assign	CG_1_1_router_iact_1_2_horiz_address_in_valid   = CG_1_0_router_iact_1_2_horiz_address_out_valid; 
assign	CG_1_1_router_iact_1_2_horiz_address_in         = CG_1_0_router_iact_1_2_horiz_address_out;       
assign	CG_1_1_router_iact_1_2_horiz_data_out_ready      = CG_1_0_router_iact_1_2_horiz_data_in_ready;    
assign	CG_1_1_router_iact_1_2_horiz_data_in_valid      = CG_1_0_router_iact_1_2_horiz_data_out_valid;    
assign	CG_1_1_router_iact_1_2_horiz_data_in            = CG_1_0_router_iact_1_2_horiz_data_out;           
assign	CG_1_1_router_iact_2_0_north_address_out_ready   = CG_0_1_router_iact_2_0_south_address_in_ready;   
assign	CG_1_1_router_iact_2_0_north_address_in_valid   = CG_0_1_router_iact_2_0_south_address_out_valid;   
assign	CG_1_1_router_iact_2_0_north_address_in         = CG_0_1_router_iact_2_0_south_address_out;         
assign	CG_1_1_router_iact_2_0_north_data_out_ready      = CG_0_1_router_iact_2_0_south_data_in_ready;      
assign	CG_1_1_router_iact_2_0_north_data_in_valid      = CG_0_1_router_iact_2_0_south_data_out_valid;      
assign	CG_1_1_router_iact_2_0_north_data_in            = CG_0_1_router_iact_2_0_south_data_out;            
assign	CG_1_1_router_iact_2_0_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_2_0_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_2_0_south_address_in         = 'd0;
assign	CG_1_1_router_iact_2_0_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_2_0_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_2_0_south_data_in            = 'd0;
assign	CG_1_1_router_iact_2_0_horiz_address_out_ready   = CG_1_0_router_iact_2_0_horiz_address_in_ready; 
assign	CG_1_1_router_iact_2_0_horiz_address_in_valid   = CG_1_0_router_iact_2_0_horiz_address_out_valid; 
assign	CG_1_1_router_iact_2_0_horiz_address_in         = CG_1_0_router_iact_2_0_horiz_address_out;       
assign	CG_1_1_router_iact_2_0_horiz_data_out_ready      = CG_1_0_router_iact_2_0_horiz_data_in_ready;    
assign	CG_1_1_router_iact_2_0_horiz_data_in_valid      = CG_1_0_router_iact_2_0_horiz_data_out_valid;    
assign	CG_1_1_router_iact_2_0_horiz_data_in            = CG_1_0_router_iact_2_0_horiz_data_out;           					
assign	CG_1_1_router_iact_2_1_north_address_out_ready   = CG_0_1_router_iact_2_1_south_address_in_ready;   
assign	CG_1_1_router_iact_2_1_north_address_in_valid   = CG_0_1_router_iact_2_1_south_address_out_valid;   
assign	CG_1_1_router_iact_2_1_north_address_in         = CG_0_1_router_iact_2_1_south_address_out;         
assign	CG_1_1_router_iact_2_1_north_data_out_ready      = CG_0_1_router_iact_2_1_south_data_in_ready;      
assign	CG_1_1_router_iact_2_1_north_data_in_valid      = CG_0_1_router_iact_2_1_south_data_out_valid;      
assign	CG_1_1_router_iact_2_1_north_data_in            = CG_0_1_router_iact_2_1_south_data_out;            
assign	CG_1_1_router_iact_2_1_south_address_out_ready   = 'd1;
assign	CG_1_1_router_iact_2_1_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_2_1_south_address_in         = 'd0;
assign	CG_1_1_router_iact_2_1_south_data_out_ready      = 'd1;
assign	CG_1_1_router_iact_2_1_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_2_1_south_data_in            = 'd0;
assign	CG_1_1_router_iact_2_1_horiz_address_out_ready  = CG_1_0_router_iact_2_1_horiz_address_in_ready; 
assign	CG_1_1_router_iact_2_1_horiz_address_in_valid   = CG_1_0_router_iact_2_1_horiz_address_out_valid; 
assign	CG_1_1_router_iact_2_1_horiz_address_in         = CG_1_0_router_iact_2_1_horiz_address_out;       
assign	CG_1_1_router_iact_2_1_horiz_data_out_ready     = CG_1_0_router_iact_2_1_horiz_data_in_ready;    
assign	CG_1_1_router_iact_2_1_horiz_data_in_valid      = CG_1_0_router_iact_2_1_horiz_data_out_valid;    
assign	CG_1_1_router_iact_2_1_horiz_data_in            = CG_1_0_router_iact_2_1_horiz_data_out;                						
assign	CG_1_1_router_iact_2_2_north_address_out_ready  = CG_0_1_router_iact_2_2_south_address_in_ready;   
assign	CG_1_1_router_iact_2_2_north_address_in_valid   = CG_0_1_router_iact_2_2_south_address_out_valid;   
assign	CG_1_1_router_iact_2_2_north_address_in         = CG_0_1_router_iact_2_2_south_address_out;         
assign	CG_1_1_router_iact_2_2_north_data_out_ready     = CG_0_1_router_iact_2_2_south_data_in_ready;      
assign	CG_1_1_router_iact_2_2_north_data_in_valid      = CG_0_1_router_iact_2_2_south_data_out_valid;      
assign	CG_1_1_router_iact_2_2_north_data_in            = CG_0_1_router_iact_2_2_south_data_out;            
assign	CG_1_1_router_iact_2_2_south_address_out_ready  = 'd1;
assign	CG_1_1_router_iact_2_2_south_address_in_valid   = 'd0;
assign	CG_1_1_router_iact_2_2_south_address_in         = 'd0;
assign	CG_1_1_router_iact_2_2_south_data_out_ready     = 'd1;
assign	CG_1_1_router_iact_2_2_south_data_in_valid      = 'd0;
assign	CG_1_1_router_iact_2_2_south_data_in            = 'd0;
assign	CG_1_1_router_iact_2_2_horiz_address_out_ready  = CG_1_0_router_iact_2_2_horiz_address_in_ready; 
assign	CG_1_1_router_iact_2_2_horiz_address_in_valid   = CG_1_0_router_iact_2_2_horiz_address_out_valid; 
assign	CG_1_1_router_iact_2_2_horiz_address_in         = CG_1_0_router_iact_2_2_horiz_address_out;       
assign	CG_1_1_router_iact_2_2_horiz_data_out_ready     = CG_1_0_router_iact_2_2_horiz_data_in_ready;    
assign	CG_1_1_router_iact_2_2_horiz_data_in_valid      = CG_1_0_router_iact_2_2_horiz_data_out_valid;    
assign	CG_1_1_router_iact_2_2_horiz_data_in            = CG_1_0_router_iact_2_2_horiz_data_out;           
			 
assign	CG_1_1_router_weight_0_horiz_address_out_ready  = CG_1_0_router_weight_0_horiz_address_in_ready;   
assign	CG_1_1_router_weight_0_horiz_address_in_valid   = CG_1_0_router_weight_0_horiz_address_out_valid;   
assign	CG_1_1_router_weight_0_horiz_address_in         = CG_1_0_router_weight_0_horiz_address_out;         
assign	CG_1_1_router_weight_0_horiz_data_out_ready     = CG_1_0_router_weight_0_horiz_data_in_ready;      
assign	CG_1_1_router_weight_0_horiz_data_in_valid      = CG_1_0_router_weight_0_horiz_data_out_valid;      
assign	CG_1_1_router_weight_0_horiz_data_in            = CG_1_0_router_weight_0_horiz_data_out;            
assign	CG_1_1_router_weight_1_horiz_address_out_ready  = CG_1_0_router_weight_1_horiz_address_in_ready;   
assign	CG_1_1_router_weight_1_horiz_address_in_valid   = CG_1_0_router_weight_1_horiz_address_out_valid;   
assign	CG_1_1_router_weight_1_horiz_address_in         = CG_1_0_router_weight_1_horiz_address_out;         
assign	CG_1_1_router_weight_1_horiz_data_out_ready     = CG_1_0_router_weight_1_horiz_data_in_ready;      
assign	CG_1_1_router_weight_1_horiz_data_in_valid      = CG_1_0_router_weight_1_horiz_data_out_valid;      
assign	CG_1_1_router_weight_1_horiz_data_in            = CG_1_0_router_weight_1_horiz_data_out;          
assign	CG_1_1_router_weight_2_horiz_address_out_ready  = CG_1_0_router_weight_2_horiz_address_in_ready;  
assign	CG_1_1_router_weight_2_horiz_address_in_valid   = CG_1_0_router_weight_2_horiz_address_out_valid;   
assign	CG_1_1_router_weight_2_horiz_address_in         = CG_1_0_router_weight_2_horiz_address_out;          
assign	CG_1_1_router_weight_2_horiz_data_out_ready     = CG_1_0_router_weight_2_horiz_data_in_ready;      
assign	CG_1_1_router_weight_2_horiz_data_in_valid      = CG_1_0_router_weight_2_horiz_data_out_valid;      
assign	CG_1_1_router_weight_2_horiz_data_in            = CG_1_0_router_weight_2_horiz_data_out;  
					
assign 	CG_1_1_router_psum_0_north_in_valid             = CG_0_1_router_psum_0_south_out_valid;
assign 	CG_1_1_router_psum_0_north_in                   = CG_0_1_router_psum_0_south_out;
assign 	CG_1_1_router_psum_0_south_out_ready            = 'd1;
assign 	CG_1_1_router_psum_1_north_in_valid             = CG_0_1_router_psum_1_south_out_valid;
assign 	CG_1_1_router_psum_1_north_in                   = CG_0_1_router_psum_1_south_out;
assign 	CG_1_1_router_psum_1_south_out_ready            = 'd1;
assign 	CG_1_1_router_psum_2_north_in_valid             = CG_0_1_router_psum_2_south_out_valid;
assign 	CG_1_1_router_psum_2_north_in                   = CG_0_1_router_psum_2_south_out;
assign 	CG_1_1_router_psum_2_south_out_ready            = 'd1;
					
assign	CG_1_1_cg_north_psum_0_out_ready                = CG_0_1_cg_south_psum_0_in_ready;
assign	CG_1_1_cg_south_psum_0_in_valid                 = 'd1;
assign	CG_1_1_cg_south_psum_0_in                       = 'd0;
assign	CG_1_1_cg_north_psum_1_out_ready                = CG_0_1_cg_south_psum_1_in_ready;
assign	CG_1_1_cg_south_psum_1_in_valid                 = 'd1;
assign	CG_1_1_cg_south_psum_1_in                       = 'd0;
assign	CG_1_1_cg_north_psum_2_out_ready                = CG_0_1_cg_south_psum_2_in_ready;
assign	CG_1_1_cg_south_psum_2_in_valid                 = 'd1;
assign	CG_1_1_cg_south_psum_2_in                       = 'd0;



endmodule
