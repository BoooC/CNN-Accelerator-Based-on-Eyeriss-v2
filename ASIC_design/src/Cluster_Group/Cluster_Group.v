// ====================================================================================================== //
// This module is Cluster_Group.
// Cluster_Group(CG) contains CG_ctrl, PE cluster, GLB cluster, router cluster.
// This module is the core of whole chip.
// In top-level, CG array can be scale as specific requirements.
// CG breakdown : PE x9, Iact SRAM x9, psum SRAM x3, iact router x9, weight router x3, psum router x3.
// For FPGA design, it contains 2x2 CG array, which contains 36 PEs.
// If the FPGA resourse is sufficient, the CG array can be scale up to 2n x 2 array, n>=1, 
// for Eyeriss v2 CG array is 8x2 
// ====================================================================================================== //

module Cluster_Group(
	input         	clock,
	input         	reset,
	// control
	input 	     	PE_cluster_iact_data_in_sel,
	input 	[1:0]	PE_cluster_iact_data_out_sel,
	input 	     	PE_cluster_psum_data_in_sel,
			
	input 	[1:0]	router_cluster_iact_data_in_sel,
	input 	[1:0]	router_cluster_iact_data_out_sel,
	input 	     	router_cluster_weight_data_in_sel,
	input 	     	router_cluster_weight_data_out_sel,
	input 	     	router_cluster_psum_data_in_sel,
	input 	     	router_cluster_psum_data_out_sel,
			
	input 	     	read_psum_en,
	output	     	cal_fin,
	input 	     	cg_en,
	output	     	PE_weight_load_en,
	output	     	GLB_iact_load_en,
	input			src_GLB_load_fin,
	output	reg		all_cal_fin,
	input			psum_acc_en,
	input			psum_acc_fin,
	input			GLB_psum_write_en,
	input			psum_SRAM_Bank_0_read_out_en,
	input			psum_SRAM_Bank_1_read_out_en,
	input			psum_SRAM_Bank_2_read_out_en,
	
	input			PE_0_0_disable,
	input			PE_0_1_disable,
	input			PE_0_2_disable,
	input			PE_1_0_disable,
	input			PE_1_1_disable,
	input			PE_1_2_disable,
	input			PE_2_0_disable,
	input			PE_2_1_disable,
	input			PE_2_2_disable,
	
	input	[10:0]	GLB_iact_0_0_read_addr,
	input	[10:0]	GLB_iact_0_1_read_addr,
	input	[10:0]	GLB_iact_0_2_read_addr,
	input	[10:0]	GLB_iact_1_0_read_addr,
	input	[10:0]	GLB_iact_1_1_read_addr,
	input	[10:0]	GLB_iact_1_2_read_addr,
	input	[10:0]	GLB_iact_2_0_read_addr,
	input	[10:0]	GLB_iact_2_1_read_addr,
	input	[10:0]	GLB_iact_2_2_read_addr,
	
	input	[9:0]	GLB_psum_0_write_addr,
	input	[9:0]	GLB_psum_1_write_addr,
	input	[9:0]	GLB_psum_2_write_addr,
	
	input	[9:0]	GLB_psum_0_read_addr,
	input	[9:0]	GLB_psum_1_read_addr,
	input	[9:0]	GLB_psum_2_read_addr,
	
	// ================== GLB IO ================== //
	// GLB iact SRAM Bank 0_0
	output        	GLB_iact_0_0_address_in_ready,
	input         	GLB_iact_0_0_address_in_valid,
	input  	[6:0]  	GLB_iact_0_0_address_in,
	output        	GLB_iact_0_0_data_in_ready,
	input         	GLB_iact_0_0_data_in_valid,
	input  	[11:0] 	GLB_iact_0_0_data_in,
	
	// GLB iact SRAM Bank 0_1
	output        	GLB_iact_0_1_address_in_ready,
	input         	GLB_iact_0_1_address_in_valid,
	input  	[6:0]  	GLB_iact_0_1_address_in,
	output        	GLB_iact_0_1_data_in_ready,
	input         	GLB_iact_0_1_data_in_valid,
	input  	[11:0] 	GLB_iact_0_1_data_in,
	
	// GLB iact SRAM Bank 0_2
	output 	       	GLB_iact_0_2_address_in_ready,
	input  	       	GLB_iact_0_2_address_in_valid,
	input  	[6:0]  	GLB_iact_0_2_address_in,
	output 	       	GLB_iact_0_2_data_in_ready,
	input  	       	GLB_iact_0_2_data_in_valid,
	input  	[11:0] 	GLB_iact_0_2_data_in,
	
	// GLB iact SRAM Bank 1_0
	output 	       	GLB_iact_1_0_address_in_ready,
	input  	       	GLB_iact_1_0_address_in_valid,
	input  	[6:0]  	GLB_iact_1_0_address_in,
	output 	       	GLB_iact_1_0_data_in_ready,
	input  	       	GLB_iact_1_0_data_in_valid,
	input  	[11:0] 	GLB_iact_1_0_data_in,
						   
	// GLB iact SRAM Bank 1_1
	output 	       	GLB_iact_1_1_address_in_ready,
	input  	       	GLB_iact_1_1_address_in_valid,
	input  	[6:0]  	GLB_iact_1_1_address_in,
	output 	       	GLB_iact_1_1_data_in_ready,
	input  	       	GLB_iact_1_1_data_in_valid,
	input  	[11:0] 	GLB_iact_1_1_data_in,
						   
	// GLB iact SRAM Bank 1_2
	output 	       	GLB_iact_1_2_address_in_ready,
	input  	       	GLB_iact_1_2_address_in_valid,
	input  	[6:0]  	GLB_iact_1_2_address_in,
	output 	       	GLB_iact_1_2_data_in_ready,
	input  	       	GLB_iact_1_2_data_in_valid,
	input  	[11:0] 	GLB_iact_1_2_data_in,
	
	// GLB iact SRAM Bank 2_0
	output 	       	GLB_iact_2_0_address_in_ready,
	input  	       	GLB_iact_2_0_address_in_valid,
	input  	[6:0]  	GLB_iact_2_0_address_in,
	output 	       	GLB_iact_2_0_data_in_ready,
	input  	       	GLB_iact_2_0_data_in_valid,
	input  	[11:0] 	GLB_iact_2_0_data_in,
	
	// GLB iact SRAM Bank 2_1
	output 	       	GLB_iact_2_1_address_in_ready,
	input  	       	GLB_iact_2_1_address_in_valid,
	input  	[6:0]  	GLB_iact_2_1_address_in,
	output 	       	GLB_iact_2_1_data_in_ready,
	input  	       	GLB_iact_2_1_data_in_valid,
	input  	[11:0] 	GLB_iact_2_1_data_in,
	
	// GLB iact SRAM Bank 2_2
	output 	       	GLB_iact_2_2_address_in_ready,
	input  	       	GLB_iact_2_2_address_in_valid,
	input  	[6:0]  	GLB_iact_2_2_address_in,
	output 	       	GLB_iact_2_2_data_in_ready,
	input  	       	GLB_iact_2_2_data_in_valid,
	input  	[11:0] 	GLB_iact_2_2_data_in,
	
	
	// GLB weight routing 0
	output 	       	GLB_weight_0_address_in_ready,
	input  	       	GLB_weight_0_address_in_valid,
	input  	[7:0]  	GLB_weight_0_address_in,
	output 	       	GLB_weight_0_data_in_ready,
	input  	       	GLB_weight_0_data_in_valid,
	input  	[12:0] 	GLB_weight_0_data_in,
	
	// GLB weight routing 1
	output 	       	GLB_weight_1_address_in_ready,
	input  	       	GLB_weight_1_address_in_valid,
	input  	[7:0]  	GLB_weight_1_address_in,
	output 	       	GLB_weight_1_data_in_ready,
	input  	       	GLB_weight_1_data_in_valid,
	input  	[12:0] 	GLB_weight_1_data_in,
	
	// GLB weight routing 2
	output 	       	GLB_weight_2_address_in_ready,
	input  	       	GLB_weight_2_address_in_valid,
	input  	[7:0]  	GLB_weight_2_address_in,
	output 	       	GLB_weight_2_data_in_ready,
	input  	       	GLB_weight_2_data_in_valid,
	input  	[12:0] 	GLB_weight_2_data_in,
	
	// GLB psum SRAM Bank 0
	output        			GLB_psum_0_data_in_ready,
	input         			GLB_psum_0_data_in_valid,
	input 	signed 	[20:0] 	GLB_psum_0_data_in,
	input         			GLB_psum_0_data_out_ready,
	output        			GLB_psum_0_data_out_valid,
	output 	signed 	[20:0] 	GLB_psum_0_data_out,
	// GLB psum SRAM Bank 1
	output        			GLB_psum_1_data_in_ready,
	input         			GLB_psum_1_data_in_valid,
	input 	signed 	[20:0] 	GLB_psum_1_data_in,
	input         			GLB_psum_1_data_out_ready,
	output        			GLB_psum_1_data_out_valid,
	output 	signed 	[20:0] 	GLB_psum_1_data_out,
	// GLB psum SRAM Bank 2
	output        			GLB_psum_2_data_in_ready,
	input         			GLB_psum_2_data_in_valid,
	input 	signed 	[20:0] 	GLB_psum_2_data_in,
	input         			GLB_psum_2_data_out_ready,
	output        			GLB_psum_2_data_out_valid,
	output 	signed 	[20:0] 	GLB_psum_2_data_out,
	
	
	// ================== router IO ================== //
	// iact router 0_0
	output        router_iact_0_0_north_address_in_ready,
	input         router_iact_0_0_north_address_in_valid,
	input  [6:0]  router_iact_0_0_north_address_in,
	output        router_iact_0_0_north_data_in_ready,
	input         router_iact_0_0_north_data_in_valid,
	input  [11:0] router_iact_0_0_north_data_in,
	output        router_iact_0_0_south_address_in_ready,
	input         router_iact_0_0_south_address_in_valid,
	input  [6:0]  router_iact_0_0_south_address_in,
	output        router_iact_0_0_south_data_in_ready,
	input         router_iact_0_0_south_data_in_valid,
	input  [11:0] router_iact_0_0_south_data_in,
	output        router_iact_0_0_horiz_address_in_ready,
	input         router_iact_0_0_horiz_address_in_valid,
	input  [6:0]  router_iact_0_0_horiz_address_in,
	output        router_iact_0_0_horiz_data_in_ready,
	input         router_iact_0_0_horiz_data_in_valid,
	input  [11:0] router_iact_0_0_horiz_data_in,
	input         router_iact_0_0_north_address_out_ready,	
	output        router_iact_0_0_north_address_out_valid,
	output [6:0]  router_iact_0_0_north_address_out,
	input         router_iact_0_0_north_data_out_ready,
	output        router_iact_0_0_north_data_out_valid,
	output [11:0] router_iact_0_0_north_data_out,
	input         router_iact_0_0_south_address_out_ready,
	output        router_iact_0_0_south_address_out_valid,
	output [6:0]  router_iact_0_0_south_address_out,
	input         router_iact_0_0_south_data_out_ready,
	output        router_iact_0_0_south_data_out_valid,
	output [11:0] router_iact_0_0_south_data_out,
	input         router_iact_0_0_horiz_address_out_ready,
	output        router_iact_0_0_horiz_address_out_valid,
	output [6:0]  router_iact_0_0_horiz_address_out,
	input         router_iact_0_0_horiz_data_out_ready,
	output        router_iact_0_0_horiz_data_out_valid,
	output [11:0] router_iact_0_0_horiz_data_out,
	
	// iact router 0_1
	output        router_iact_0_1_north_address_in_ready,
	input         router_iact_0_1_north_address_in_valid,
	input  [6:0]  router_iact_0_1_north_address_in,
	output        router_iact_0_1_north_data_in_ready,
	input         router_iact_0_1_north_data_in_valid,
	input  [11:0] router_iact_0_1_north_data_in,
	output        router_iact_0_1_south_address_in_ready,
	input         router_iact_0_1_south_address_in_valid,
	input  [6:0]  router_iact_0_1_south_address_in,
	output        router_iact_0_1_south_data_in_ready,
	input         router_iact_0_1_south_data_in_valid,
	input  [11:0] router_iact_0_1_south_data_in,
	output        router_iact_0_1_horiz_address_in_ready,
	input         router_iact_0_1_horiz_address_in_valid,
	input  [6:0]  router_iact_0_1_horiz_address_in,
	output        router_iact_0_1_horiz_data_in_ready,
	input         router_iact_0_1_horiz_data_in_valid,
	input  [11:0] router_iact_0_1_horiz_data_in,
	input         router_iact_0_1_north_address_out_ready,	
	output        router_iact_0_1_north_address_out_valid,
	output [6:0]  router_iact_0_1_north_address_out,
	input         router_iact_0_1_north_data_out_ready,
	output        router_iact_0_1_north_data_out_valid,
	output [11:0] router_iact_0_1_north_data_out,
	input         router_iact_0_1_south_address_out_ready,
	output        router_iact_0_1_south_address_out_valid,
	output [6:0]  router_iact_0_1_south_address_out,
	input         router_iact_0_1_south_data_out_ready,
	output        router_iact_0_1_south_data_out_valid,
	output [11:0] router_iact_0_1_south_data_out,
	input         router_iact_0_1_horiz_address_out_ready,
	output        router_iact_0_1_horiz_address_out_valid,
	output [6:0]  router_iact_0_1_horiz_address_out,
	input         router_iact_0_1_horiz_data_out_ready,
	output        router_iact_0_1_horiz_data_out_valid,
	output [11:0] router_iact_0_1_horiz_data_out,

	// iact router 0_2
	output        router_iact_0_2_north_address_in_ready,
	input         router_iact_0_2_north_address_in_valid,
	input  [6:0]  router_iact_0_2_north_address_in,
	output        router_iact_0_2_north_data_in_ready,
	input         router_iact_0_2_north_data_in_valid,
	input  [11:0] router_iact_0_2_north_data_in,
	output        router_iact_0_2_south_address_in_ready,
	input         router_iact_0_2_south_address_in_valid,
	input  [6:0]  router_iact_0_2_south_address_in,
	output        router_iact_0_2_south_data_in_ready,
	input         router_iact_0_2_south_data_in_valid,
	input  [11:0] router_iact_0_2_south_data_in,
	output        router_iact_0_2_horiz_address_in_ready,
	input         router_iact_0_2_horiz_address_in_valid,
	input  [6:0]  router_iact_0_2_horiz_address_in,
	output        router_iact_0_2_horiz_data_in_ready,
	input         router_iact_0_2_horiz_data_in_valid,
	input  [11:0] router_iact_0_2_horiz_data_in,
	input         router_iact_0_2_north_address_out_ready,	
	output        router_iact_0_2_north_address_out_valid,
	output [6:0]  router_iact_0_2_north_address_out,
	input         router_iact_0_2_north_data_out_ready,
	output        router_iact_0_2_north_data_out_valid,
	output [11:0] router_iact_0_2_north_data_out,
	input         router_iact_0_2_south_address_out_ready,
	output        router_iact_0_2_south_address_out_valid,
	output [6:0]  router_iact_0_2_south_address_out,
	input         router_iact_0_2_south_data_out_ready,
	output        router_iact_0_2_south_data_out_valid,
	output [11:0] router_iact_0_2_south_data_out,
	input         router_iact_0_2_horiz_address_out_ready,
	output        router_iact_0_2_horiz_address_out_valid,
	output [6:0]  router_iact_0_2_horiz_address_out,
	input         router_iact_0_2_horiz_data_out_ready,
	output        router_iact_0_2_horiz_data_out_valid,
	output [11:0] router_iact_0_2_horiz_data_out,
	
	
	// iact router 1_0
	output        router_iact_1_0_north_address_in_ready,
	input         router_iact_1_0_north_address_in_valid,
	input  [6:0]  router_iact_1_0_north_address_in,
	output        router_iact_1_0_north_data_in_ready,
	input         router_iact_1_0_north_data_in_valid,
	input  [11:0] router_iact_1_0_north_data_in,
	output        router_iact_1_0_south_address_in_ready,
	input         router_iact_1_0_south_address_in_valid,
	input  [6:0]  router_iact_1_0_south_address_in,
	output        router_iact_1_0_south_data_in_ready,
	input         router_iact_1_0_south_data_in_valid,
	input  [11:0] router_iact_1_0_south_data_in,
	output        router_iact_1_0_horiz_address_in_ready,
	input         router_iact_1_0_horiz_address_in_valid,
	input  [6:0]  router_iact_1_0_horiz_address_in,
	output        router_iact_1_0_horiz_data_in_ready,
	input         router_iact_1_0_horiz_data_in_valid,
	input  [11:0] router_iact_1_0_horiz_data_in,
	input         router_iact_1_0_north_address_out_ready,	
	output        router_iact_1_0_north_address_out_valid,
	output [6:0]  router_iact_1_0_north_address_out,
	input         router_iact_1_0_north_data_out_ready,
	output        router_iact_1_0_north_data_out_valid,
	output [11:0] router_iact_1_0_north_data_out,
	input         router_iact_1_0_south_address_out_ready,
	output        router_iact_1_0_south_address_out_valid,
	output [6:0]  router_iact_1_0_south_address_out,
	input         router_iact_1_0_south_data_out_ready,
	output        router_iact_1_0_south_data_out_valid,
	output [11:0] router_iact_1_0_south_data_out,
	input         router_iact_1_0_horiz_address_out_ready,
	output        router_iact_1_0_horiz_address_out_valid,
	output [6:0]  router_iact_1_0_horiz_address_out,
	input         router_iact_1_0_horiz_data_out_ready,
	output        router_iact_1_0_horiz_data_out_valid,
	output [11:0] router_iact_1_0_horiz_data_out,
							  
	// iact router 1_1        
	output        router_iact_1_1_north_address_in_ready,
	input         router_iact_1_1_north_address_in_valid,
	input  [6:0]  router_iact_1_1_north_address_in,
	output        router_iact_1_1_north_data_in_ready,
	input         router_iact_1_1_north_data_in_valid,
	input  [11:0] router_iact_1_1_north_data_in,
	output        router_iact_1_1_south_address_in_ready,
	input         router_iact_1_1_south_address_in_valid,
	input  [6:0]  router_iact_1_1_south_address_in,
	output        router_iact_1_1_south_data_in_ready,
	input         router_iact_1_1_south_data_in_valid,
	input  [11:0] router_iact_1_1_south_data_in,
	output        router_iact_1_1_horiz_address_in_ready,
	input         router_iact_1_1_horiz_address_in_valid,
	input  [6:0]  router_iact_1_1_horiz_address_in,
	output        router_iact_1_1_horiz_data_in_ready,
	input         router_iact_1_1_horiz_data_in_valid,
	input  [11:0] router_iact_1_1_horiz_data_in,
	input         router_iact_1_1_north_address_out_ready,	
	output        router_iact_1_1_north_address_out_valid,
	output [6:0]  router_iact_1_1_north_address_out,
	input         router_iact_1_1_north_data_out_ready,
	output        router_iact_1_1_north_data_out_valid,
	output [11:0] router_iact_1_1_north_data_out,
	input         router_iact_1_1_south_address_out_ready,
	output        router_iact_1_1_south_address_out_valid,
	output [6:0]  router_iact_1_1_south_address_out,
	input         router_iact_1_1_south_data_out_ready,
	output        router_iact_1_1_south_data_out_valid,
	output [11:0] router_iact_1_1_south_data_out,
	input         router_iact_1_1_horiz_address_out_ready,
	output        router_iact_1_1_horiz_address_out_valid,
	output [6:0]  router_iact_1_1_horiz_address_out,
	input         router_iact_1_1_horiz_data_out_ready,
	output        router_iact_1_1_horiz_data_out_valid,
	output [11:0] router_iact_1_1_horiz_data_out,
							  
	// iact router 1_2        
	output        router_iact_1_2_north_address_in_ready,
	input         router_iact_1_2_north_address_in_valid,
	input  [6:0]  router_iact_1_2_north_address_in,
	output        router_iact_1_2_north_data_in_ready,
	input         router_iact_1_2_north_data_in_valid,
	input  [11:0] router_iact_1_2_north_data_in,
	output        router_iact_1_2_south_address_in_ready,
	input         router_iact_1_2_south_address_in_valid,
	input  [6:0]  router_iact_1_2_south_address_in,
	output        router_iact_1_2_south_data_in_ready,
	input         router_iact_1_2_south_data_in_valid,
	input  [11:0] router_iact_1_2_south_data_in,
	output        router_iact_1_2_horiz_address_in_ready,
	input         router_iact_1_2_horiz_address_in_valid,
	input  [6:0]  router_iact_1_2_horiz_address_in,
	output        router_iact_1_2_horiz_data_in_ready,
	input         router_iact_1_2_horiz_data_in_valid,
	input  [11:0] router_iact_1_2_horiz_data_in,
	input         router_iact_1_2_north_address_out_ready,	
	output        router_iact_1_2_north_address_out_valid,
	output [6:0]  router_iact_1_2_north_address_out,
	input         router_iact_1_2_north_data_out_ready,
	output        router_iact_1_2_north_data_out_valid,
	output [11:0] router_iact_1_2_north_data_out,
	input         router_iact_1_2_south_address_out_ready,
	output        router_iact_1_2_south_address_out_valid,
	output [6:0]  router_iact_1_2_south_address_out,
	input         router_iact_1_2_south_data_out_ready,
	output        router_iact_1_2_south_data_out_valid,
	output [11:0] router_iact_1_2_south_data_out,
	input         router_iact_1_2_horiz_address_out_ready,
	output        router_iact_1_2_horiz_address_out_valid,
	output [6:0]  router_iact_1_2_horiz_address_out,
	input         router_iact_1_2_horiz_data_out_ready,
	output        router_iact_1_2_horiz_data_out_valid,
	output [11:0] router_iact_1_2_horiz_data_out,
	
	// iact router 2_0
	output        router_iact_2_0_north_address_in_ready,
	input         router_iact_2_0_north_address_in_valid,
	input  [6:0]  router_iact_2_0_north_address_in,
	output        router_iact_2_0_north_data_in_ready,
	input         router_iact_2_0_north_data_in_valid,
	input  [11:0] router_iact_2_0_north_data_in,
	output        router_iact_2_0_south_address_in_ready,
	input         router_iact_2_0_south_address_in_valid,
	input  [6:0]  router_iact_2_0_south_address_in,
	output        router_iact_2_0_south_data_in_ready,
	input         router_iact_2_0_south_data_in_valid,
	input  [11:0] router_iact_2_0_south_data_in,
	output        router_iact_2_0_horiz_address_in_ready,
	input         router_iact_2_0_horiz_address_in_valid,
	input  [6:0]  router_iact_2_0_horiz_address_in,
	output        router_iact_2_0_horiz_data_in_ready,
	input         router_iact_2_0_horiz_data_in_valid,
	input  [11:0] router_iact_2_0_horiz_data_in,
	input         router_iact_2_0_north_address_out_ready,	
	output        router_iact_2_0_north_address_out_valid,
	output [6:0]  router_iact_2_0_north_address_out,
	input         router_iact_2_0_north_data_out_ready,
	output        router_iact_2_0_north_data_out_valid,
	output [11:0] router_iact_2_0_north_data_out,
	input         router_iact_2_0_south_address_out_ready,
	output        router_iact_2_0_south_address_out_valid,
	output [6:0]  router_iact_2_0_south_address_out,
	input         router_iact_2_0_south_data_out_ready,
	output        router_iact_2_0_south_data_out_valid,
	output [11:0] router_iact_2_0_south_data_out,
	input         router_iact_2_0_horiz_address_out_ready,
	output        router_iact_2_0_horiz_address_out_valid,
	output [6:0]  router_iact_2_0_horiz_address_out,
	input         router_iact_2_0_horiz_data_out_ready,
	output        router_iact_2_0_horiz_data_out_valid,
	output [11:0] router_iact_2_0_horiz_data_out,
							  
	// iact router 2_1        
	output        router_iact_2_1_north_address_in_ready,
	input         router_iact_2_1_north_address_in_valid,
	input  [6:0]  router_iact_2_1_north_address_in,
	output        router_iact_2_1_north_data_in_ready,
	input         router_iact_2_1_north_data_in_valid,
	input  [11:0] router_iact_2_1_north_data_in,
	output        router_iact_2_1_south_address_in_ready,
	input         router_iact_2_1_south_address_in_valid,
	input  [6:0]  router_iact_2_1_south_address_in,
	output        router_iact_2_1_south_data_in_ready,
	input         router_iact_2_1_south_data_in_valid,
	input  [11:0] router_iact_2_1_south_data_in,
	output        router_iact_2_1_horiz_address_in_ready,
	input         router_iact_2_1_horiz_address_in_valid,
	input  [6:0]  router_iact_2_1_horiz_address_in,
	output        router_iact_2_1_horiz_data_in_ready,
	input         router_iact_2_1_horiz_data_in_valid,
	input  [11:0] router_iact_2_1_horiz_data_in,
	input         router_iact_2_1_north_address_out_ready,	
	output        router_iact_2_1_north_address_out_valid,
	output [6:0]  router_iact_2_1_north_address_out,
	input         router_iact_2_1_north_data_out_ready,
	output        router_iact_2_1_north_data_out_valid,
	output [11:0] router_iact_2_1_north_data_out,
	input         router_iact_2_1_south_address_out_ready,
	output        router_iact_2_1_south_address_out_valid,
	output [6:0]  router_iact_2_1_south_address_out,
	input         router_iact_2_1_south_data_out_ready,
	output        router_iact_2_1_south_data_out_valid,
	output [11:0] router_iact_2_1_south_data_out,
	input         router_iact_2_1_horiz_address_out_ready,
	output        router_iact_2_1_horiz_address_out_valid,
	output [6:0]  router_iact_2_1_horiz_address_out,
	input         router_iact_2_1_horiz_data_out_ready,
	output        router_iact_2_1_horiz_data_out_valid,
	output [11:0] router_iact_2_1_horiz_data_out,
							  
	// iact router 2_2        
	output        router_iact_2_2_north_address_in_ready,
	input         router_iact_2_2_north_address_in_valid,
	input  [6:0]  router_iact_2_2_north_address_in,
	output        router_iact_2_2_north_data_in_ready,
	input         router_iact_2_2_north_data_in_valid,
	input  [11:0] router_iact_2_2_north_data_in,
	output        router_iact_2_2_south_address_in_ready,
	input         router_iact_2_2_south_address_in_valid,
	input  [6:0]  router_iact_2_2_south_address_in,
	output        router_iact_2_2_south_data_in_ready,
	input         router_iact_2_2_south_data_in_valid,
	input  [11:0] router_iact_2_2_south_data_in,
	output        router_iact_2_2_horiz_address_in_ready,
	input         router_iact_2_2_horiz_address_in_valid,
	input  [6:0]  router_iact_2_2_horiz_address_in,
	output        router_iact_2_2_horiz_data_in_ready,
	input         router_iact_2_2_horiz_data_in_valid,
	input  [11:0] router_iact_2_2_horiz_data_in,
	input         router_iact_2_2_north_address_out_ready,	
	output        router_iact_2_2_north_address_out_valid,
	output [6:0]  router_iact_2_2_north_address_out,
	input         router_iact_2_2_north_data_out_ready,
	output        router_iact_2_2_north_data_out_valid,
	output [11:0] router_iact_2_2_north_data_out,
	input         router_iact_2_2_south_address_out_ready,
	output        router_iact_2_2_south_address_out_valid,
	output [6:0]  router_iact_2_2_south_address_out,
	input         router_iact_2_2_south_data_out_ready,
	output        router_iact_2_2_south_data_out_valid,
	output [11:0] router_iact_2_2_south_data_out,
	input         router_iact_2_2_horiz_address_out_ready,
	output        router_iact_2_2_horiz_address_out_valid,
	output [6:0]  router_iact_2_2_horiz_address_out,
	input         router_iact_2_2_horiz_data_out_ready,
	output        router_iact_2_2_horiz_data_out_valid,
	output [11:0] router_iact_2_2_horiz_data_out,
	
	// weight router 0
	output        router_weight_0_horiz_address_in_ready,
	input         router_weight_0_horiz_address_in_valid,
	input  [7:0]  router_weight_0_horiz_address_in,
	output        router_weight_0_horiz_data_in_ready,
	input         router_weight_0_horiz_data_in_valid,
	input  [12:0] router_weight_0_horiz_data_in,
	
	input         router_weight_0_horiz_address_out_ready,
	output        router_weight_0_horiz_address_out_valid,
	output [7:0]  router_weight_0_horiz_address_out,
	input         router_weight_0_horiz_data_out_ready,
	output        router_weight_0_horiz_data_out_valid,
	output [12:0] router_weight_0_horiz_data_out,
	
	// weight router 1
	output        router_weight_1_horiz_address_in_ready,
	input         router_weight_1_horiz_address_in_valid,
	input  [7:0]  router_weight_1_horiz_address_in,
	output        router_weight_1_horiz_data_in_ready,
	input         router_weight_1_horiz_data_in_valid,
	input  [12:0] router_weight_1_horiz_data_in,
	
	input         router_weight_1_horiz_address_out_ready,
	output        router_weight_1_horiz_address_out_valid,
	output [7:0]  router_weight_1_horiz_address_out,
	input         router_weight_1_horiz_data_out_ready,
	output        router_weight_1_horiz_data_out_valid,
	output [12:0] router_weight_1_horiz_data_out,
	
	// weight router 2
	output        router_weight_2_horiz_address_in_ready,
	input         router_weight_2_horiz_address_in_valid,
	input  [7:0]  router_weight_2_horiz_address_in,
	output        router_weight_2_horiz_data_in_ready,
	input         router_weight_2_horiz_data_in_valid,
	input  [12:0] router_weight_2_horiz_data_in,
	
	input         router_weight_2_horiz_address_out_ready,
	output        router_weight_2_horiz_address_out_valid,
	output [7:0]  router_weight_2_horiz_address_out,
	input         router_weight_2_horiz_data_out_ready,
	output        router_weight_2_horiz_data_out_valid,
	output [12:0] router_weight_2_horiz_data_out,
	
	// psum router 0
	output        			router_psum_0_north_in_ready,
	input         			router_psum_0_north_in_valid,
	input	signed	[20:0] 	router_psum_0_north_in,
	
	input         			router_psum_0_south_out_ready,
	output        			router_psum_0_south_out_valid,
	output	signed	[20:0] 	router_psum_0_south_out,
	
	// psum router 1
	output        			router_psum_1_north_in_ready,
	input         			router_psum_1_north_in_valid,
	input	signed	[20:0] 	router_psum_1_north_in,
	
	input         			router_psum_1_south_out_ready,
	output        			router_psum_1_south_out_valid,
	output	signed	[20:0] 	router_psum_1_south_out,
	
	// psum router 2
	output        			router_psum_2_north_in_ready,
	input         			router_psum_2_north_in_valid,
	input	signed	[20:0] 	router_psum_2_north_in,
	
	input         			router_psum_2_south_out_ready,
	output        			router_psum_2_south_out_valid,
	output	signed	[20:0] 	router_psum_2_south_out,
	
	
	// psum veritcal flow (interconnect with vertical cluster group)
	output        			cg_south_psum_0_in_ready,
	input         			cg_south_psum_0_in_valid,
	input	signed	[20:0] 	cg_south_psum_0_in,
	output        			cg_south_psum_1_in_ready,
	input         			cg_south_psum_1_in_valid,
	input	signed	[20:0] 	cg_south_psum_1_in,
	output        			cg_south_psum_2_in_ready,
	input         			cg_south_psum_2_in_valid,
	input	signed	[20:0] 	cg_south_psum_2_in,
	
	input         			cg_north_psum_0_out_ready,
	output        			cg_north_psum_0_out_valid,
	output	signed	[20:0] 	cg_north_psum_0_out,
	input         			cg_north_psum_1_out_ready,
	output        			cg_north_psum_1_out_valid,
	output	signed	[20:0] 	cg_north_psum_1_out,
	input         			cg_north_psum_2_out_ready,
	output        			cg_north_psum_2_out_valid,
	output	signed	[20:0] 	cg_north_psum_2_out,
	
	input			[4:0]	PSUM_DEPTH,
	input					psum_spad_clear,
	
	input					iact_write_fin_clear,
	input					weight_write_fin_clear
);

// PE Cluster connection
wire  		PE_Cluster_clock;                                     
wire  		PE_Cluster_reset;                                     
wire  		PE_Cluster_iact_0_address_in_ready;                   
wire  		PE_Cluster_iact_0_address_in_valid;                   
wire [7:0] 	PE_Cluster_iact_0_address_in;                    
wire  		PE_Cluster_iact_0_data_in_ready;                      
wire  		PE_Cluster_iact_0_data_in_valid;                      
wire [12:0] PE_Cluster_iact_0_data_in;                      
wire  		PE_Cluster_iact_1_address_in_ready;                   
wire  		PE_Cluster_iact_1_address_in_valid;                   
wire [7:0] 	PE_Cluster_iact_1_address_in;                    
wire  		PE_Cluster_iact_1_data_in_ready;                      
wire  		PE_Cluster_iact_1_data_in_valid;                      
wire [12:0] PE_Cluster_iact_1_data_in;                      
wire  		PE_Cluster_iact_2_address_in_ready;                   
wire  		PE_Cluster_iact_2_address_in_valid;                   
wire [7:0] 	PE_Cluster_iact_2_address_in;                    
wire  		PE_Cluster_iact_2_data_in_ready;                      
wire  		PE_Cluster_iact_2_data_in_valid;                      
wire [12:0] PE_Cluster_iact_2_data_in;        
              
wire  		PE_Cluster_weight_0_0_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_0_0_address_in;                  
wire  		PE_Cluster_weight_0_0_data_in_valid;                    
wire [11:0] PE_Cluster_weight_0_0_data_in;                    
wire  		PE_Cluster_weight_0_1_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_0_1_address_in;                  
wire  		PE_Cluster_weight_0_1_data_in_valid;                    
wire [11:0] PE_Cluster_weight_0_1_data_in;                    
wire  		PE_Cluster_weight_0_2_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_0_2_address_in;                  
wire  		PE_Cluster_weight_0_2_data_in_valid;                    
wire [11:0] PE_Cluster_weight_0_2_data_in;           
wire  		PE_Cluster_weight_1_0_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_1_0_address_in;                  
wire  		PE_Cluster_weight_1_0_data_in_valid;                    
wire [11:0] PE_Cluster_weight_1_0_data_in;                    
wire  		PE_Cluster_weight_1_1_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_1_1_address_in;                  
wire  		PE_Cluster_weight_1_1_data_in_valid;                    
wire [11:0] PE_Cluster_weight_1_1_data_in;                    
wire  		PE_Cluster_weight_1_2_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_1_2_address_in;                  
wire  		PE_Cluster_weight_1_2_data_in_valid;                    
wire [11:0] PE_Cluster_weight_1_2_data_in;    
wire  		PE_Cluster_weight_2_0_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_2_0_address_in;                  
wire  		PE_Cluster_weight_2_0_data_in_valid;                    
wire [11:0] PE_Cluster_weight_2_0_data_in;                    
wire  		PE_Cluster_weight_2_1_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_2_1_address_in;                  
wire  		PE_Cluster_weight_2_1_data_in_valid;                    
wire [11:0] PE_Cluster_weight_2_1_data_in;                    
wire  		PE_Cluster_weight_2_2_address_in_valid;                 
wire [6:0] 	PE_Cluster_weight_2_2_address_in;                  
wire  		PE_Cluster_weight_2_2_data_in_valid;                    
wire [11:0] PE_Cluster_weight_2_2_data_in;      

wire  					PE_Cluster_psum_0_in_ready;                           
wire  					PE_Cluster_psum_0_in_valid;                           
wire	signed	[20:0] 	PE_Cluster_psum_0_in;                           
wire  					PE_Cluster_psum_1_in_ready;                           
wire  					PE_Cluster_psum_1_in_valid;                           
wire	signed	[20:0] 	PE_Cluster_psum_1_in;                           
wire  					PE_Cluster_psum_2_in_ready;                           
wire  					PE_Cluster_psum_2_in_valid;                           
wire	signed	[20:0] 	PE_Cluster_psum_2_in;                                   
wire  					PE_Cluster_psum_0_out_ready;                          
wire  					PE_Cluster_psum_0_out_valid;                          
wire	signed	[20:0] 	PE_Cluster_psum_0_out;                          
wire  					PE_Cluster_psum_1_out_ready;                          
wire  					PE_Cluster_psum_1_out_valid;                          
wire	signed	[20:0] 	PE_Cluster_psum_1_out;                          
wire  					PE_Cluster_psum_2_out_ready;                          
wire  					PE_Cluster_psum_2_out_valid;                          
wire	signed	[20:0] 	PE_Cluster_psum_2_out;             
wire  					PE_Cluster_psum_0_in_from_south_ready;                
wire  					PE_Cluster_psum_0_in_from_south_valid;                
wire	signed	[20:0] 	PE_Cluster_psum_0_in_from_south;                
wire  					PE_Cluster_psum_1_in_from_south_ready;                
wire  					PE_Cluster_psum_1_in_from_south_valid;                
wire	signed	[20:0] 	PE_Cluster_psum_1_in_from_south;                
wire  					PE_Cluster_psum_2_in_from_south_ready;                
wire  					PE_Cluster_psum_2_in_from_south_valid;                
wire	signed	[20:0] 	PE_Cluster_psum_2_in_from_south;    
wire					PE_Cluster_PE_0_0_disable;
wire					PE_Cluster_PE_0_1_disable;
wire					PE_Cluster_PE_0_2_disable;
wire					PE_Cluster_PE_1_0_disable;
wire					PE_Cluster_PE_1_1_disable;
wire					PE_Cluster_PE_1_2_disable;
wire					PE_Cluster_PE_2_0_disable;
wire					PE_Cluster_PE_2_1_disable;
wire					PE_Cluster_PE_2_2_disable;
           
              
wire  		PE_Cluster_psum_load_en;                              
wire  		PE_Cluster_iact_data_in_sel;                          
wire [1:0] 	PE_Cluster_iact_data_out_sel;                    
wire  		PE_Cluster_psum_data_in_sel;                          
wire  		PE_Cluster_do_en;  
wire		PE_Cluster_iact_write_fin_clear;
wire		PE_Cluster_weight_write_fin_clear;
wire		PE_Cluster_all_write_fin;                                 
wire  		PE_Cluster_all_cal_fin;                               

// GLB Cluster connection
wire  		GLB_Cluster_clock;                                    
wire  		GLB_Cluster_reset;                                    
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_address_in_ready;        
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_address_in_valid;        
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_0_address_in;              
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_data_in_ready;           
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_data_in_valid;           
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_0_data_in;                
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_address_out_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_address_out_valid;       
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_0_address_out;             
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_data_out_ready;          
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_data_out_valid;          
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_0_data_out;     
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_write_en; 		               
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_write_done;                 
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_read_en;   		             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_0_0_read_addr;                   
wire  		GLB_Cluster_iact_SRAM_Bank_0_0_read_done;    
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_1_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_1_data_in;          	
wire 		GLB_Cluster_iact_SRAM_Bank_0_1_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_1_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_1_data_out;        	
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_0_1_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_0_1_read_done;           
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_2_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_2_data_in;          	
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_0_2_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_0_2_data_out;         	
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_0_2_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_0_2_read_done;                                   
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_address_in_ready;        
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_address_in_valid;        
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_0_address_in;              
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_data_in_ready;           
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_data_in_valid;           
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_0_data_in;                
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_address_out_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_address_out_valid;       
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_0_address_out;             
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_data_out_ready;          
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_data_out_valid;          
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_0_data_out;     
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_write_en; 		               
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_write_done;                 
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_read_en;   		             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_1_0_read_addr;                   
wire  		GLB_Cluster_iact_SRAM_Bank_1_0_read_done;    
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_1_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_1_data_in;          	
wire 		GLB_Cluster_iact_SRAM_Bank_1_1_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_1_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_1_data_out;        	
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_1_1_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_1_1_read_done;           
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_2_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_2_data_in;          	
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_1_2_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_1_2_data_out;         	
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_1_2_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_1_2_read_done;                               
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_address_in_ready;        
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_address_in_valid;        
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_0_address_in;              
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_data_in_ready;           
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_data_in_valid;           
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_0_data_in;                
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_address_out_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_address_out_valid;       
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_0_address_out;             
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_data_out_ready;          
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_data_out_valid;          
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_0_data_out;     
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_write_en; 		               
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_write_done;                 
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_read_en;   		             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_2_0_read_addr;                   
wire  		GLB_Cluster_iact_SRAM_Bank_2_0_read_done;    
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_1_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_1_data_in;          	
wire 		GLB_Cluster_iact_SRAM_Bank_2_1_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_1_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_1_data_out;        	
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_2_1_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_2_1_read_done;           
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_address_in_ready;    
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_address_in_valid;    
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_2_address_in;          
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_data_in_ready;       
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_data_in_valid;       
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_2_data_in;          	
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_address_out_ready;   
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_address_out_valid;   
wire [6:0] 	GLB_Cluster_iact_SRAM_Bank_2_2_address_out;         
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_data_out_ready;      
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_data_out_valid;      
wire [11:0] GLB_Cluster_iact_SRAM_Bank_2_2_data_out;         	
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_write_en;            
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_write_done;          
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_read_en;             
wire [9:0] 	GLB_Cluster_iact_SRAM_Bank_2_2_read_addr;           
wire  		GLB_Cluster_iact_SRAM_Bank_2_2_read_done; 
   
wire  		GLB_Cluster_weight_SRAM_Bank_0_address_in_ready;     
wire  		GLB_Cluster_weight_SRAM_Bank_0_address_in_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_0_address_in;          
wire  		GLB_Cluster_weight_SRAM_Bank_0_data_in_ready;       
wire  		GLB_Cluster_weight_SRAM_Bank_0_data_in_valid;       
wire [12:0] GLB_Cluster_weight_SRAM_Bank_0_data_in;         	
wire  		GLB_Cluster_weight_SRAM_Bank_0_address_out_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_0_address_out_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_0_address_out;         
wire  		GLB_Cluster_weight_SRAM_Bank_0_data_out_ready;      
wire 	 	GLB_Cluster_weight_SRAM_Bank_0_data_out_valid;      
wire [12:0] GLB_Cluster_weight_SRAM_Bank_0_data_out;        	
wire  		GLB_Cluster_weight_SRAM_Bank_1_address_in_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_1_address_in_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_1_address_in;          
wire  		GLB_Cluster_weight_SRAM_Bank_1_data_in_ready;       
wire  		GLB_Cluster_weight_SRAM_Bank_1_data_in_valid;       
wire [12:0] GLB_Cluster_weight_SRAM_Bank_1_data_in;        	
wire  		GLB_Cluster_weight_SRAM_Bank_1_address_out_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_1_address_out_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_1_address_out;         
wire  		GLB_Cluster_weight_SRAM_Bank_1_data_out_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_1_data_out_valid;      
wire [12:0] GLB_Cluster_weight_SRAM_Bank_1_data_out;       	
wire  		GLB_Cluster_weight_SRAM_Bank_2_address_in_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_2_address_in_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_2_address_in;          
wire  		GLB_Cluster_weight_SRAM_Bank_2_data_in_ready;       
wire  		GLB_Cluster_weight_SRAM_Bank_2_data_in_valid;       
wire [12:0] GLB_Cluster_weight_SRAM_Bank_2_data_in;        	
wire 		GLB_Cluster_weight_SRAM_Bank_2_address_out_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_2_address_out_valid;      
wire [7:0] 	GLB_Cluster_weight_SRAM_Bank_2_address_out;         
wire 	 	GLB_Cluster_weight_SRAM_Bank_2_data_out_ready;      
wire  		GLB_Cluster_weight_SRAM_Bank_2_data_out_valid;      
wire [12:0] GLB_Cluster_weight_SRAM_Bank_2_data_out;     
   	
wire  					GLB_Cluster_psum_SRAM_Bank_0_data_in_ready;          
wire 					GLB_Cluster_psum_SRAM_Bank_0_data_in_valid;          
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_0_data_in;               
wire  					GLB_Cluster_psum_SRAM_Bank_0_data_out_ready;         
wire  					GLB_Cluster_psum_SRAM_Bank_0_data_out_valid;         
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_0_data_out;              
wire  					GLB_Cluster_psum_SRAM_Bank_0_write_en;              
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_0_write_addr;            
wire  					GLB_Cluster_psum_SRAM_Bank_0_write_done;   
wire					GLB_Cluster_psum_SRAM_Bank_0_read_out_en;
wire  					GLB_Cluster_psum_SRAM_Bank_0_read_en;               
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_0_read_addr;             
wire  					GLB_Cluster_psum_SRAM_Bank_1_data_in_ready;          
wire  					GLB_Cluster_psum_SRAM_Bank_1_data_in_valid;          
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_1_data_in;               
wire  					GLB_Cluster_psum_SRAM_Bank_1_data_out_ready;         
wire  					GLB_Cluster_psum_SRAM_Bank_1_data_out_valid;         
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_1_data_out;              
wire  					GLB_Cluster_psum_SRAM_Bank_1_write_en;              
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_1_write_addr;            
wire  					GLB_Cluster_psum_SRAM_Bank_1_write_done;  
wire					GLB_Cluster_psum_SRAM_Bank_1_read_out_en;             
wire  					GLB_Cluster_psum_SRAM_Bank_1_read_en;               
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_1_read_addr;             
wire  					GLB_Cluster_psum_SRAM_Bank_2_data_in_ready;          
wire  					GLB_Cluster_psum_SRAM_Bank_2_data_in_valid;          
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_2_data_in;               
wire  					GLB_Cluster_psum_SRAM_Bank_2_data_out_ready;         
wire  					GLB_Cluster_psum_SRAM_Bank_2_data_out_valid;         
wire	signed	[20:0] 	GLB_Cluster_psum_SRAM_Bank_2_data_out;              
wire  					GLB_Cluster_psum_SRAM_Bank_2_write_en;              
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_2_write_addr;            
wire  					GLB_Cluster_psum_SRAM_Bank_2_write_done;    
wire					GLB_Cluster_psum_SRAM_Bank_2_read_out_en;        
wire  					GLB_Cluster_psum_SRAM_Bank_2_read_en;               
wire 			[9:0] 	GLB_Cluster_psum_SRAM_Bank_2_read_addr;           

// router Cluster connection
wire [1:0] 	iact_0_data_in_sel;             
wire [1:0] 	iact_0_data_out_sel;            
wire [1:0] 	iact_1_data_in_sel;             
wire [1:0] 	iact_1_data_out_sel;            
wire [1:0] 	iact_2_data_in_sel;             
wire [1:0] 	iact_2_data_out_sel;   
wire  		weight_0_data_in_sel;           
wire  		weight_0_data_out_sel;          
wire  		weight_1_data_in_sel;           
wire  		weight_1_data_out_sel;          
wire  		weight_2_data_in_sel;           
wire  		weight_2_data_out_sel; 
wire 	 	psum_0_data_in_sel;             
wire 	 	psum_0_data_out_sel;            
wire 	 	psum_1_data_in_sel;             
wire 	 	psum_1_data_out_sel;            
wire 	 	psum_2_data_in_sel;             
wire 	 	psum_2_data_out_sel;        
wire  		iact_0_0_GLB_address_in_ready;    
wire  		iact_0_0_GLB_address_in_valid;    
wire [6:0] 	iact_0_0_GLB_address_in_bits;     
wire   		iact_0_0_GLB_data_in_ready;       
wire   		iact_0_0_GLB_data_in_valid;       
wire [11:0] iact_0_0_GLB_data_in_bits;        
wire   		iact_0_0_north_address_in_ready;  
wire   		iact_0_0_north_address_in_valid;  
wire [6:0] 	iact_0_0_north_address_in_bits;   
wire   		iact_0_0_north_data_in_ready;     
wire   		iact_0_0_north_data_in_valid;     
wire [11:0] iact_0_0_north_data_in_bits;      
wire   		iact_0_0_south_address_in_ready;  
wire   		iact_0_0_south_address_in_valid;  
wire [6:0] 	iact_0_0_south_address_in_bits;   
wire   		iact_0_0_south_data_in_ready;     
wire   		iact_0_0_south_data_in_valid;     
wire [11:0] iact_0_0_south_data_in_bits;      
wire   		iact_0_0_horiz_address_in_ready;  
wire   		iact_0_0_horiz_address_in_valid;  
wire [6:0] 	iact_0_0_horiz_address_in_bits;   
wire   		iact_0_0_horiz_data_in_ready;   
wire   		iact_0_0_horiz_data_in_valid;     
wire [11:0] iact_0_0_horiz_data_in_bits;      
wire   		iact_0_0_PE_address_out_ready;    
wire   		iact_0_0_PE_address_out_valid;     
wire [6:0] 	iact_0_0_PE_address_out_bits;    
wire   		iact_0_0_PE_data_out_ready;       
wire   		iact_0_0_PE_data_out_valid;       
wire [11:0] iact_0_0_PE_data_out_bits;        
wire  		iact_0_0_north_address_out_valid; 
wire [6:0] 	iact_0_0_north_address_out_bits;  
wire  		iact_0_0_north_data_out_valid;    
wire [11:0] iact_0_0_north_data_out_bits;     
wire   		iact_0_0_south_address_out_ready; 
wire   		iact_0_0_south_address_out_valid;  
wire [6:0] 	iact_0_0_south_address_out_bits; 
wire   		iact_0_0_south_data_out_ready;    
wire   		iact_0_0_south_data_out_valid;    
wire [11:0] iact_0_0_south_data_out_bits;     
wire   		iact_0_0_horiz_address_out_ready; 
wire   		iact_0_0_horiz_address_out_valid;  
wire [6:0] 	iact_0_0_horiz_address_out_bits; 
wire   		iact_0_0_horiz_data_out_ready;    
wire   		iact_0_0_horiz_data_out_valid;    
wire [11:0] iact_0_0_horiz_data_out_bits;  
wire   		iact_0_1_GLB_address_in_ready;    
wire   		iact_0_1_GLB_address_in_valid;    
wire [6:0] 	iact_0_1_GLB_address_in_bits;     
wire   		iact_0_1_GLB_data_in_ready;       
wire   		iact_0_1_GLB_data_in_valid;       
wire [11:0] iact_0_1_GLB_data_in_bits;        
wire   		iact_0_1_north_address_in_ready;  
wire   		iact_0_1_north_address_in_valid;  
wire [6:0] 	iact_0_1_north_address_in_bits;   
wire   		iact_0_1_north_data_in_ready;     
wire   		iact_0_1_north_data_in_valid;     
wire [11:0] iact_0_1_north_data_in_bits;      
wire   		iact_0_1_south_address_in_ready;  
wire   		iact_0_1_south_address_in_valid;  
wire [6:0] 	iact_0_1_south_address_in_bits;   
wire   		iact_0_1_south_data_in_ready;     
wire   		iact_0_1_south_data_in_valid;     
wire [11:0] iact_0_1_south_data_in_bits;      
wire   		iact_0_1_horiz_address_in_ready;  
wire   		iact_0_1_horiz_address_in_valid;  
wire [6:0] 	iact_0_1_horiz_address_in_bits;   
wire   		iact_0_1_horiz_data_in_ready;     
wire   		iact_0_1_horiz_data_in_valid;     
wire [11:0] iact_0_1_horiz_data_in_bits;      
wire   		iact_0_1_PE_address_out_ready;    
wire   		iact_0_1_PE_address_out_valid;     
wire [6:0] 	iact_0_1_PE_address_out_bits;    
wire   		iact_0_1_PE_data_out_ready;       
wire   		iact_0_1_PE_data_out_valid;       
wire [11:0] iact_0_1_PE_data_out_bits;        
wire  		iact_0_1_north_address_out_valid; 
wire [6:0] 	iact_0_1_north_address_out_bits;  
wire  		iact_0_1_north_data_out_valid;    
wire [11:0] iact_0_1_north_data_out_bits;     
wire   		iact_0_1_south_address_out_ready; 
wire   		iact_0_1_south_address_out_valid;  
wire [6:0] 	iact_0_1_south_address_out_bits; 
wire   		iact_0_1_south_data_out_ready;    
wire   		iact_0_1_south_data_out_valid;    
wire [11:0] iact_0_1_south_data_out_bits;     
wire   		iact_0_1_horiz_address_out_ready; 
wire   		iact_0_1_horiz_address_out_valid;  
wire [6:0] 	iact_0_1_horiz_address_out_bits; 
wire   		iact_0_1_horiz_data_out_ready;    
wire   		iact_0_1_horiz_data_out_valid;    
wire [11:0] iact_0_1_horiz_data_out_bits;   
wire   		iact_0_2_GLB_address_in_ready;    
wire   		iact_0_2_GLB_address_in_valid;    
wire [6:0] 	iact_0_2_GLB_address_in_bits;     
wire   		iact_0_2_GLB_data_in_ready;       
wire   		iact_0_2_GLB_data_in_valid;       
wire [11:0] iact_0_2_GLB_data_in_bits;        
wire   		iact_0_2_north_address_in_ready;  
wire   		iact_0_2_north_address_in_valid;  
wire [6:0] 	iact_0_2_north_address_in_bits;   
wire   		iact_0_2_north_data_in_ready;     
wire   		iact_0_2_north_data_in_valid;     
wire [11:0] iact_0_2_north_data_in_bits;      
wire   		iact_0_2_south_address_in_ready;  
wire   		iact_0_2_south_address_in_valid;  
wire [6:0] 	iact_0_2_south_address_in_bits;   
wire   		iact_0_2_south_data_in_ready;     
wire   		iact_0_2_south_data_in_valid;     
wire [11:0] iact_0_2_south_data_in_bits;      
wire   		iact_0_2_horiz_address_in_ready;  
wire   		iact_0_2_horiz_address_in_valid;  
wire [6:0] 	iact_0_2_horiz_address_in_bits;   
wire   		iact_0_2_horiz_data_in_ready;     
wire   		iact_0_2_horiz_data_in_valid;     
wire [11:0] iact_0_2_horiz_data_in_bits;      
wire   		iact_0_2_PE_address_out_ready;    
wire   		iact_0_2_PE_address_out_valid;     
wire [6:0] 	iact_0_2_PE_address_out_bits;    
wire   		iact_0_2_PE_data_out_ready;       
wire   		iact_0_2_PE_data_out_valid;       
wire [11:0] iact_0_2_PE_data_out_bits;        
wire  		iact_0_2_north_address_out_valid; 
wire [6:0] 	iact_0_2_north_address_out_bits;  
wire  		iact_0_2_north_data_out_valid;    
wire [11:0] iact_0_2_north_data_out_bits;     
wire   		iact_0_2_south_address_out_ready; 
wire   		iact_0_2_south_address_out_valid;  
wire [6:0] 	iact_0_2_south_address_out_bits; 
wire   		iact_0_2_south_data_out_ready;    
wire   		iact_0_2_south_data_out_valid;    
wire [11:0] iact_0_2_south_data_out_bits;     
wire   		iact_0_2_horiz_address_out_ready; 
wire   		iact_0_2_horiz_address_out_valid;  
wire [6:0] 	iact_0_2_horiz_address_out_bits; 
wire   		iact_0_2_horiz_data_out_ready;    
wire   		iact_0_2_horiz_data_out_valid;    
wire [11:0] iact_0_2_horiz_data_out_bits;  
wire  		iact_1_0_GLB_address_in_ready;    
wire  		iact_1_0_GLB_address_in_valid;    
wire [6:0] 	iact_1_0_GLB_address_in_bits;     
wire   		iact_1_0_GLB_data_in_ready;       
wire   		iact_1_0_GLB_data_in_valid;       
wire [11:0] iact_1_0_GLB_data_in_bits;        
wire   		iact_1_0_north_address_in_ready;  
wire   		iact_1_0_north_address_in_valid;  
wire [6:0] 	iact_1_0_north_address_in_bits;   
wire   		iact_1_0_north_data_in_ready;     
wire   		iact_1_0_north_data_in_valid;     
wire [11:0] iact_1_0_north_data_in_bits;      
wire   		iact_1_0_south_address_in_ready;  
wire   		iact_1_0_south_address_in_valid;  
wire [6:0] 	iact_1_0_south_address_in_bits;   
wire   		iact_1_0_south_data_in_ready;     
wire   		iact_1_0_south_data_in_valid;     
wire [11:0] iact_1_0_south_data_in_bits;      
wire   		iact_1_0_horiz_address_in_ready;  
wire   		iact_1_0_horiz_address_in_valid;  
wire [6:0] 	iact_1_0_horiz_address_in_bits;   
wire   		iact_1_0_horiz_data_in_ready;   
wire   		iact_1_0_horiz_data_in_valid;     
wire [11:0] iact_1_0_horiz_data_in_bits;      
wire   		iact_1_0_PE_address_out_ready;    
wire   		iact_1_0_PE_address_out_valid;     
wire [6:0] 	iact_1_0_PE_address_out_bits;    
wire   		iact_1_0_PE_data_out_ready;       
wire   		iact_1_0_PE_data_out_valid;       
wire [11:0] iact_1_0_PE_data_out_bits;        
wire  		iact_1_0_north_address_out_valid; 
wire [6:0] 	iact_1_0_north_address_out_bits;  
wire  		iact_1_0_north_data_out_valid;    
wire [11:0] iact_1_0_north_data_out_bits;     
wire   		iact_1_0_south_address_out_ready; 
wire   		iact_1_0_south_address_out_valid;  
wire [6:0] 	iact_1_0_south_address_out_bits; 
wire   		iact_1_0_south_data_out_ready;    
wire   		iact_1_0_south_data_out_valid;    
wire [11:0] iact_1_0_south_data_out_bits;     
wire   		iact_1_0_horiz_address_out_ready; 
wire   		iact_1_0_horiz_address_out_valid;  
wire [6:0] 	iact_1_0_horiz_address_out_bits; 
wire   		iact_1_0_horiz_data_out_ready;    
wire   		iact_1_0_horiz_data_out_valid;    
wire [11:0] iact_1_0_horiz_data_out_bits;  
wire   		iact_1_1_GLB_address_in_ready;    
wire   		iact_1_1_GLB_address_in_valid;    
wire [6:0] 	iact_1_1_GLB_address_in_bits;     
wire   		iact_1_1_GLB_data_in_ready;       
wire   		iact_1_1_GLB_data_in_valid;       
wire [11:0] iact_1_1_GLB_data_in_bits;        
wire   		iact_1_1_north_address_in_ready;  
wire   		iact_1_1_north_address_in_valid;  
wire [6:0] 	iact_1_1_north_address_in_bits;   
wire   		iact_1_1_north_data_in_ready;     
wire   		iact_1_1_north_data_in_valid;     
wire [11:0] iact_1_1_north_data_in_bits;      
wire   		iact_1_1_south_address_in_ready;  
wire   		iact_1_1_south_address_in_valid;  
wire [6:0] 	iact_1_1_south_address_in_bits;   
wire   		iact_1_1_south_data_in_ready;     
wire   		iact_1_1_south_data_in_valid;     
wire [11:0] iact_1_1_south_data_in_bits;      
wire   		iact_1_1_horiz_address_in_ready;  
wire   		iact_1_1_horiz_address_in_valid;  
wire [6:0] 	iact_1_1_horiz_address_in_bits;   
wire   		iact_1_1_horiz_data_in_ready;     
wire   		iact_1_1_horiz_data_in_valid;     
wire [11:0] iact_1_1_horiz_data_in_bits;      
wire   		iact_1_1_PE_address_out_ready;    
wire   		iact_1_1_PE_address_out_valid;     
wire [6:0] 	iact_1_1_PE_address_out_bits;    
wire   		iact_1_1_PE_data_out_ready;       
wire   		iact_1_1_PE_data_out_valid;       
wire [11:0] iact_1_1_PE_data_out_bits;        
wire  		iact_1_1_north_address_out_valid; 
wire [6:0] 	iact_1_1_north_address_out_bits;  
wire  		iact_1_1_north_data_out_valid;    
wire [11:0] iact_1_1_north_data_out_bits;     
wire   		iact_1_1_south_address_out_ready; 
wire   		iact_1_1_south_address_out_valid;  
wire [6:0] 	iact_1_1_south_address_out_bits; 
wire   		iact_1_1_south_data_out_ready;    
wire   		iact_1_1_south_data_out_valid;    
wire [11:0] iact_1_1_south_data_out_bits;     
wire   		iact_1_1_horiz_address_out_ready; 
wire   		iact_1_1_horiz_address_out_valid;  
wire [6:0] 	iact_1_1_horiz_address_out_bits; 
wire   		iact_1_1_horiz_data_out_ready;    
wire   		iact_1_1_horiz_data_out_valid;    
wire [11:0] iact_1_1_horiz_data_out_bits;   
wire   		iact_1_2_GLB_address_in_ready;    
wire   		iact_1_2_GLB_address_in_valid;    
wire [6:0] 	iact_1_2_GLB_address_in_bits;     
wire   		iact_1_2_GLB_data_in_ready;       
wire   		iact_1_2_GLB_data_in_valid;       
wire [11:0] iact_1_2_GLB_data_in_bits;        
wire   		iact_1_2_north_address_in_ready;  
wire   		iact_1_2_north_address_in_valid;  
wire [6:0] 	iact_1_2_north_address_in_bits;   
wire   		iact_1_2_north_data_in_ready;     
wire   		iact_1_2_north_data_in_valid;     
wire [11:0] iact_1_2_north_data_in_bits;      
wire   		iact_1_2_south_address_in_ready;  
wire   		iact_1_2_south_address_in_valid;  
wire [6:0] 	iact_1_2_south_address_in_bits;   
wire   		iact_1_2_south_data_in_ready;     
wire   		iact_1_2_south_data_in_valid;     
wire [11:0] iact_1_2_south_data_in_bits;      
wire   		iact_1_2_horiz_address_in_ready;  
wire   		iact_1_2_horiz_address_in_valid;  
wire [6:0] 	iact_1_2_horiz_address_in_bits;   
wire   		iact_1_2_horiz_data_in_ready;     
wire   		iact_1_2_horiz_data_in_valid;     
wire [11:0] iact_1_2_horiz_data_in_bits;      
wire   		iact_1_2_PE_address_out_ready;    
wire   		iact_1_2_PE_address_out_valid;     
wire [6:0] 	iact_1_2_PE_address_out_bits;    
wire   		iact_1_2_PE_data_out_ready;       
wire   		iact_1_2_PE_data_out_valid;       
wire [11:0] iact_1_2_PE_data_out_bits;        
wire  		iact_1_2_north_address_out_valid; 
wire [6:0] 	iact_1_2_north_address_out_bits;  
wire  		iact_1_2_north_data_out_valid;    
wire [11:0] iact_1_2_north_data_out_bits;     
wire   		iact_1_2_south_address_out_ready; 
wire   		iact_1_2_south_address_out_valid;  
wire [6:0] 	iact_1_2_south_address_out_bits; 
wire   		iact_1_2_south_data_out_ready;    
wire   		iact_1_2_south_data_out_valid;    
wire [11:0] iact_1_2_south_data_out_bits;     
wire   		iact_1_2_horiz_address_out_ready; 
wire   		iact_1_2_horiz_address_out_valid;  
wire [6:0] 	iact_1_2_horiz_address_out_bits; 
wire   		iact_1_2_horiz_data_out_ready;    
wire   		iact_1_2_horiz_data_out_valid;    
wire [11:0] iact_1_2_horiz_data_out_bits;  
wire  		iact_2_0_GLB_address_in_ready;    
wire  		iact_2_0_GLB_address_in_valid;    
wire [6:0] 	iact_2_0_GLB_address_in_bits;     
wire   		iact_2_0_GLB_data_in_ready;       
wire   		iact_2_0_GLB_data_in_valid;       
wire [11:0] iact_2_0_GLB_data_in_bits;        
wire   		iact_2_0_north_address_in_ready;  
wire   		iact_2_0_north_address_in_valid;  
wire [6:0] 	iact_2_0_north_address_in_bits;   
wire   		iact_2_0_north_data_in_ready;     
wire   		iact_2_0_north_data_in_valid;     
wire [11:0] iact_2_0_north_data_in_bits;      
wire   		iact_2_0_south_address_in_ready;  
wire   		iact_2_0_south_address_in_valid;  
wire [6:0] 	iact_2_0_south_address_in_bits;   
wire   		iact_2_0_south_data_in_ready;     
wire   		iact_2_0_south_data_in_valid;     
wire [11:0] iact_2_0_south_data_in_bits;      
wire   		iact_2_0_horiz_address_in_ready;  
wire   		iact_2_0_horiz_address_in_valid;  
wire [6:0] 	iact_2_0_horiz_address_in_bits;   
wire   		iact_2_0_horiz_data_in_ready;   
wire   		iact_2_0_horiz_data_in_valid;     
wire [11:0] iact_2_0_horiz_data_in_bits;      
wire   		iact_2_0_PE_address_out_ready;    
wire   		iact_2_0_PE_address_out_valid;     
wire [6:0] 	iact_2_0_PE_address_out_bits;    
wire   		iact_2_0_PE_data_out_ready;       
wire   		iact_2_0_PE_data_out_valid;       
wire [11:0] iact_2_0_PE_data_out_bits;        
wire  		iact_2_0_north_address_out_valid; 
wire [6:0] 	iact_2_0_north_address_out_bits;  
wire  		iact_2_0_north_data_out_valid;    
wire [11:0] iact_2_0_north_data_out_bits;     
wire   		iact_2_0_south_address_out_ready; 
wire   		iact_2_0_south_address_out_valid;  
wire [6:0] 	iact_2_0_south_address_out_bits; 
wire   		iact_2_0_south_data_out_ready;    
wire   		iact_2_0_south_data_out_valid;    
wire [11:0] iact_2_0_south_data_out_bits;     
wire   		iact_2_0_horiz_address_out_ready; 
wire   		iact_2_0_horiz_address_out_valid;  
wire [6:0] 	iact_2_0_horiz_address_out_bits; 
wire   		iact_2_0_horiz_data_out_ready;    
wire   		iact_2_0_horiz_data_out_valid;    
wire [11:0] iact_2_0_horiz_data_out_bits;  
wire   		iact_2_1_GLB_address_in_ready;    
wire   		iact_2_1_GLB_address_in_valid;    
wire [6:0] 	iact_2_1_GLB_address_in_bits;     
wire   		iact_2_1_GLB_data_in_ready;       
wire   		iact_2_1_GLB_data_in_valid;       
wire [11:0] iact_2_1_GLB_data_in_bits;        
wire   		iact_2_1_north_address_in_ready;  
wire   		iact_2_1_north_address_in_valid;  
wire [6:0] 	iact_2_1_north_address_in_bits;   
wire   		iact_2_1_north_data_in_ready;     
wire   		iact_2_1_north_data_in_valid;     
wire [11:0] iact_2_1_north_data_in_bits;      
wire   		iact_2_1_south_address_in_ready;  
wire   		iact_2_1_south_address_in_valid;  
wire [6:0] 	iact_2_1_south_address_in_bits;   
wire   		iact_2_1_south_data_in_ready;     
wire   		iact_2_1_south_data_in_valid;     
wire [11:0] iact_2_1_south_data_in_bits;      
wire   		iact_2_1_horiz_address_in_ready;  
wire   		iact_2_1_horiz_address_in_valid;  
wire [6:0] 	iact_2_1_horiz_address_in_bits;   
wire   		iact_2_1_horiz_data_in_ready;     
wire   		iact_2_1_horiz_data_in_valid;     
wire [11:0] iact_2_1_horiz_data_in_bits;      
wire   		iact_2_1_PE_address_out_ready;    
wire   		iact_2_1_PE_address_out_valid;     
wire [6:0] 	iact_2_1_PE_address_out_bits;    
wire   		iact_2_1_PE_data_out_ready;       
wire   		iact_2_1_PE_data_out_valid;       
wire [11:0] iact_2_1_PE_data_out_bits;        
wire  		iact_2_1_north_address_out_valid; 
wire [6:0] 	iact_2_1_north_address_out_bits;  
wire  		iact_2_1_north_data_out_valid;    
wire [11:0] iact_2_1_north_data_out_bits;     
wire   		iact_2_1_south_address_out_ready; 
wire   		iact_2_1_south_address_out_valid;  
wire [6:0] 	iact_2_1_south_address_out_bits; 
wire   		iact_2_1_south_data_out_ready;    
wire   		iact_2_1_south_data_out_valid;    
wire [11:0] iact_2_1_south_data_out_bits;     
wire   		iact_2_1_horiz_address_out_ready; 
wire   		iact_2_1_horiz_address_out_valid;  
wire [6:0] 	iact_2_1_horiz_address_out_bits; 
wire   		iact_2_1_horiz_data_out_ready;    
wire   		iact_2_1_horiz_data_out_valid;    
wire [11:0] iact_2_1_horiz_data_out_bits;   
wire   		iact_2_2_GLB_address_in_ready;    
wire   		iact_2_2_GLB_address_in_valid;    
wire [6:0] 	iact_2_2_GLB_address_in_bits;     
wire   		iact_2_2_GLB_data_in_ready;       
wire   		iact_2_2_GLB_data_in_valid;       
wire [11:0] iact_2_2_GLB_data_in_bits;        
wire   		iact_2_2_north_address_in_ready;  
wire   		iact_2_2_north_address_in_valid;  
wire [6:0] 	iact_2_2_north_address_in_bits;   
wire   		iact_2_2_north_data_in_ready;     
wire   		iact_2_2_north_data_in_valid;     
wire [11:0] iact_2_2_north_data_in_bits;      
wire   		iact_2_2_south_address_in_ready;  
wire   		iact_2_2_south_address_in_valid;  
wire [6:0] 	iact_2_2_south_address_in_bits;   
wire   		iact_2_2_south_data_in_ready;     
wire   		iact_2_2_south_data_in_valid;     
wire [11:0] iact_2_2_south_data_in_bits;      
wire   		iact_2_2_horiz_address_in_ready;  
wire   		iact_2_2_horiz_address_in_valid;  
wire [6:0] 	iact_2_2_horiz_address_in_bits;   
wire   		iact_2_2_horiz_data_in_ready;     
wire   		iact_2_2_horiz_data_in_valid;     
wire [11:0] iact_2_2_horiz_data_in_bits;      
wire   		iact_2_2_PE_address_out_ready;    
wire   		iact_2_2_PE_address_out_valid;     
wire [6:0] 	iact_2_2_PE_address_out_bits;    
wire   		iact_2_2_PE_data_out_ready;       
wire   		iact_2_2_PE_data_out_valid;       
wire [11:0] iact_2_2_PE_data_out_bits;        
wire  		iact_2_2_north_address_out_valid; 
wire [6:0] 	iact_2_2_north_address_out_bits;  
wire  		iact_2_2_north_data_out_valid;    
wire [11:0] iact_2_2_north_data_out_bits;     
wire   		iact_2_2_south_address_out_ready; 
wire   		iact_2_2_south_address_out_valid;  
wire [6:0] 	iact_2_2_south_address_out_bits; 
wire   		iact_2_2_south_data_out_ready;    
wire   		iact_2_2_south_data_out_valid;    
wire [11:0] iact_2_2_south_data_out_bits;     
wire   		iact_2_2_horiz_address_out_ready; 
wire   		iact_2_2_horiz_address_out_valid;  
wire [6:0] 	iact_2_2_horiz_address_out_bits; 
wire   		iact_2_2_horiz_data_out_ready;    
wire   		iact_2_2_horiz_data_out_valid;    
wire [11:0] iact_2_2_horiz_data_out_bits;      
 
wire   		weight_0_GLB_address_in_ready;  
wire   		weight_0_GLB_address_in_valid;  
wire [7:0] 	weight_0_GLB_address_in_bits;   
wire   		weight_0_GLB_data_in_ready;     
wire   		weight_0_GLB_data_in_valid;     
wire [12:0] weight_0_GLB_data_in_bits;      
wire   		weight_0_horiz_address_in_ready;
wire   		weight_0_horiz_address_in_valid;
wire [7:0] 	weight_0_horiz_address_in_bits; 
wire   		weight_0_horiz_data_in_ready;   
wire   		weight_0_horiz_data_in_valid;   
wire [12:0] weight_0_horiz_data_in_bits;    
wire  		weight_0_PE_address_out_valid;  
wire [7:0] 	weight_0_PE_address_out_bits;   
wire  		weight_0_PE_data_out_valid;     
wire [12:0] weight_0_PE_data_out_bits;      
wire   		weight_0_horiz_address_out_ready;  
wire   		weight_0_horiz_address_out_valid;  
wire [7:0] 	weight_0_horiz_address_out_bits;  
wire   		weight_0_horiz_data_out_ready;    
wire   		weight_0_horiz_data_out_valid;    
wire [12:0] weight_0_horiz_data_out_bits;     
wire   		weight_1_GLB_address_in_ready;    
wire   		weight_1_GLB_address_in_valid;    
wire [7:0] 	weight_1_GLB_address_in_bits;     
wire   		weight_1_GLB_data_in_ready;       
wire   		weight_1_GLB_data_in_valid;       
wire [12:0] weight_1_GLB_data_in_bits;        
wire   		weight_1_horiz_address_in_ready;   
wire   		weight_1_horiz_address_in_valid;   
wire [7:0] 	weight_1_horiz_address_in_bits;   
wire   		weight_1_horiz_data_in_ready;     
wire   		weight_1_horiz_data_in_valid;     
wire [12:0] weight_1_horiz_data_in_bits;      
wire  		weight_1_PE_address_out_valid;    
wire [7:0] 	weight_1_PE_address_out_bits;     
wire  		weight_1_PE_data_out_valid;       
wire [12:0] weight_1_PE_data_out_bits;        
wire   		weight_1_horiz_address_out_ready;  
wire   		weight_1_horiz_address_out_valid;  
wire [7:0] 	weight_1_horiz_address_out_bits;  
wire   		weight_1_horiz_data_out_ready;    
wire   		weight_1_horiz_data_out_valid;    
wire [12:0] weight_1_horiz_data_out_bits;     
wire   		weight_2_GLB_address_in_ready;    
wire   		weight_2_GLB_address_in_valid;    
wire [7:0] 	weight_2_GLB_address_in_bits;     
wire   		weight_2_GLB_data_in_ready;       
wire   		weight_2_GLB_data_in_valid;       
wire [12:0] weight_2_GLB_data_in_bits;        
wire   		weight_2_horiz_address_in_ready;  
wire   		weight_2_horiz_address_in_valid;  
wire [7:0] 	weight_2_horiz_address_in_bits;   
wire   		weight_2_horiz_data_in_ready;     
wire   		weight_2_horiz_data_in_valid;     
wire [12:0] weight_2_horiz_data_in_bits;      
wire  		weight_2_PE_address_out_valid;    
wire [7:0] 	weight_2_PE_address_out_bits;     
wire  		weight_2_PE_data_out_valid;       
wire [12:0] weight_2_PE_data_out_bits;        
wire   		weight_2_horiz_address_out_ready; 
wire   		weight_2_horiz_address_out_valid; 
wire [7:0] 	weight_2_horiz_address_out_bits;  
wire   		weight_2_horiz_data_out_ready;    
wire   		weight_2_horiz_data_out_valid;    
wire [12:0] weight_2_horiz_data_out_bits;    

wire   					psum_0_PE_in_ready;               
wire   					psum_0_PE_in_valid;               
wire	signed	[20:0] 	psum_0_PE_in_bits;                
wire   					psum_0_GLB_in_ready;              
wire   					psum_0_GLB_in_valid;              
wire	signed	[20:0] 	psum_0_GLB_in_bits;               
wire   					psum_0_north_in_ready;            
wire   					psum_0_north_in_valid;            
wire	signed	[20:0] 	psum_0_north_in_bits;             
wire   					psum_0_PE_out_ready;              
wire   					psum_0_PE_out_valid;              
wire	signed	[20:0] 	psum_0_PE_out_bits;               
wire   					psum_0_GLB_out_ready;             
wire   					psum_0_GLB_out_valid;             
wire	signed	[20:0] 	psum_0_GLB_out_bits;              
wire   					psum_0_south_out_ready;           
wire   					psum_0_south_out_valid;           
wire	signed	[20:0] 	psum_0_south_out_bits;       
wire   					psum_1_PE_in_ready;               
wire   					psum_1_PE_in_valid;               
wire	signed	[20:0] 	psum_1_PE_in_bits;                
wire   					psum_1_GLB_in_ready;              
wire   					psum_1_GLB_in_valid;              
wire	signed	[20:0] 	psum_1_GLB_in_bits;               
wire   					psum_1_north_in_ready;            
wire   					psum_1_north_in_valid;            
wire	signed	[20:0] 	psum_1_north_in_bits;             
wire   					psum_1_PE_out_ready;              
wire   					psum_1_PE_out_valid;              
wire	signed	[20:0] 	psum_1_PE_out_bits;               
wire   					psum_1_GLB_out_ready;             
wire   					psum_1_GLB_out_valid;             
wire	signed	[20:0] 	psum_1_GLB_out_bits;              
wire   					psum_1_south_out_ready;           
wire   					psum_1_south_out_valid;           
wire	signed	[20:0] 	psum_1_south_out_bits;         
wire   					psum_2_PE_in_ready;               
wire   					psum_2_PE_in_valid;               
wire	signed	[20:0] 	psum_2_PE_in_bits;                
wire   					psum_2_GLB_in_ready;              
wire   					psum_2_GLB_in_valid;              
wire	signed	[20:0] 	psum_2_GLB_in_bits;               
wire   					psum_2_north_in_ready;            
wire   					psum_2_north_in_valid;            
wire	signed	[20:0] 	psum_2_north_in_bits;             
wire   					psum_2_PE_out_ready;              
wire   					psum_2_PE_out_valid;              
wire	signed	[20:0] 	psum_2_PE_out_bits;               
wire   					psum_2_GLB_out_ready;             
wire   					psum_2_GLB_out_valid;             
wire	signed	[20:0] 	psum_2_GLB_out_bits;              
wire   					psum_2_south_out_ready;           
wire   					psum_2_south_out_valid;           
wire	signed	[20:0] 	psum_2_south_out_bits;    


// cluster group controller connection
wire   		cg_ctrl_clock;                   
wire   		cg_ctrl_reset;                   
wire  		cg_ctrl_GLB_psum_0_write_en;     
wire   		cg_ctrl_GLB_psum_0_write_done;   
wire   		cg_ctrl_GLB_psum_0_read_en;       
wire  		cg_ctrl_GLB_psum_1_write_en;      
wire   		cg_ctrl_GLB_psum_1_write_done;   
wire   		cg_ctrl_GLB_psum_1_read_en;      
wire  		cg_ctrl_GLB_psum_2_write_en;      
wire   		cg_ctrl_GLB_psum_2_write_done;   
wire   		cg_ctrl_GLB_psum_2_read_en;         
wire  		cg_ctrl_GLB_iact_0_write_en;     
wire  		cg_ctrl_GLB_iact_0_write_done;   
wire  		cg_ctrl_GLB_iact_0_read_en;       
wire  		cg_ctrl_GLB_iact_0_read_done;    
wire  		cg_ctrl_GLB_iact_1_write_en;     
wire  		cg_ctrl_GLB_iact_1_write_done;   
wire  		cg_ctrl_GLB_iact_1_read_en;       
wire 		cg_ctrl_GLB_iact_1_read_done;    
wire 		cg_ctrl_GLB_iact_2_write_en;     
wire 		cg_ctrl_GLB_iact_2_write_done;   
wire 		cg_ctrl_GLB_iact_2_read_en;        
wire  		cg_ctrl_GLB_iact_2_read_done;    
wire  		cg_ctrl_PE_load_en;              
wire  		cg_ctrl_psum_load_en;     
wire		cg_ctrl_src_GLB_load_fin;    
wire		cg_ctrl_psum_acc_en;                
wire  		cg_ctrl_psum_add;                
wire  		cg_ctrl_read_psum_en;        
wire  		cg_ctrl_cg_en;   
wire		cg_ctrl_PE_all_write_fin;            
wire  		cg_ctrl_cal_fin;             
wire		cg_ctrl_idle_wire;
wire  		cg_ctrl_GLB_load_en;    
wire 		cg_ctrl_psum_acc_fin;   


PE_Cluster PE_Cluster ( 
	.clock                      	(PE_Cluster_clock                       ),
	.reset                      	(PE_Cluster_reset                       ),
	.iact_0_address_in_ready    	(PE_Cluster_iact_0_address_in_ready     ),
	.iact_0_address_in_valid    	(PE_Cluster_iact_0_address_in_valid     ),
	.iact_0_address_in          	(PE_Cluster_iact_0_address_in           ),
	.iact_0_data_in_ready       	(PE_Cluster_iact_0_data_in_ready        ),
	.iact_0_data_in_valid       	(PE_Cluster_iact_0_data_in_valid        ),
	.iact_0_data_in             	(PE_Cluster_iact_0_data_in              ),
	.iact_1_address_in_ready    	(PE_Cluster_iact_1_address_in_ready     ),
	.iact_1_address_in_valid    	(PE_Cluster_iact_1_address_in_valid     ),
	.iact_1_address_in          	(PE_Cluster_iact_1_address_in           ),
	.iact_1_data_in_ready       	(PE_Cluster_iact_1_data_in_ready        ),
	.iact_1_data_in_valid       	(PE_Cluster_iact_1_data_in_valid        ),
	.iact_1_data_in             	(PE_Cluster_iact_1_data_in              ),
	.iact_2_address_in_ready    	(PE_Cluster_iact_2_address_in_ready     ),
	.iact_2_address_in_valid    	(PE_Cluster_iact_2_address_in_valid     ),
	.iact_2_address_in          	(PE_Cluster_iact_2_address_in           ),
	.iact_2_data_in_ready       	(PE_Cluster_iact_2_data_in_ready        ),
	.iact_2_data_in_valid       	(PE_Cluster_iact_2_data_in_valid        ),
	.iact_2_data_in             	(PE_Cluster_iact_2_data_in              ),
	.weight_0_0_address_in_valid  	(PE_Cluster_weight_0_0_address_in_valid	),
	.weight_0_0_address_in        	(PE_Cluster_weight_0_0_address_in      	),
	.weight_0_0_data_in_valid     	(PE_Cluster_weight_0_0_data_in_valid   	),
	.weight_0_0_data_in           	(PE_Cluster_weight_0_0_data_in         	),
	.weight_0_1_address_in_valid  	(PE_Cluster_weight_0_1_address_in_valid	),
	.weight_0_1_address_in        	(PE_Cluster_weight_0_1_address_in      	),
	.weight_0_1_data_in_valid     	(PE_Cluster_weight_0_1_data_in_valid   	),
	.weight_0_1_data_in           	(PE_Cluster_weight_0_1_data_in         	),
	.weight_0_2_address_in_valid  	(PE_Cluster_weight_0_2_address_in_valid	),
	.weight_0_2_address_in        	(PE_Cluster_weight_0_2_address_in      	),
	.weight_0_2_data_in_valid     	(PE_Cluster_weight_0_2_data_in_valid   	),
	.weight_0_2_data_in           	(PE_Cluster_weight_0_2_data_in         	),
	.weight_1_0_address_in_valid  	(PE_Cluster_weight_1_0_address_in_valid	),
	.weight_1_0_address_in        	(PE_Cluster_weight_1_0_address_in      	),
	.weight_1_0_data_in_valid     	(PE_Cluster_weight_1_0_data_in_valid   	),
	.weight_1_0_data_in           	(PE_Cluster_weight_1_0_data_in         	),
	.weight_1_1_address_in_valid  	(PE_Cluster_weight_1_1_address_in_valid	),
	.weight_1_1_address_in        	(PE_Cluster_weight_1_1_address_in      	),
	.weight_1_1_data_in_valid     	(PE_Cluster_weight_1_1_data_in_valid   	),
	.weight_1_1_data_in           	(PE_Cluster_weight_1_1_data_in         	),
	.weight_1_2_address_in_valid  	(PE_Cluster_weight_1_2_address_in_valid	),
	.weight_1_2_address_in        	(PE_Cluster_weight_1_2_address_in      	),
	.weight_1_2_data_in_valid     	(PE_Cluster_weight_1_2_data_in_valid   	),
	.weight_1_2_data_in           	(PE_Cluster_weight_1_2_data_in         	),
	.weight_2_0_address_in_valid  	(PE_Cluster_weight_2_0_address_in_valid	),
	.weight_2_0_address_in        	(PE_Cluster_weight_2_0_address_in      	),
	.weight_2_0_data_in_valid     	(PE_Cluster_weight_2_0_data_in_valid   	),
	.weight_2_0_data_in           	(PE_Cluster_weight_2_0_data_in         	),
	.weight_2_1_address_in_valid  	(PE_Cluster_weight_2_1_address_in_valid	),
	.weight_2_1_address_in        	(PE_Cluster_weight_2_1_address_in      	),
	.weight_2_1_data_in_valid     	(PE_Cluster_weight_2_1_data_in_valid   	),
	.weight_2_1_data_in           	(PE_Cluster_weight_2_1_data_in         	),
	.weight_2_2_address_in_valid  	(PE_Cluster_weight_2_2_address_in_valid	),
	.weight_2_2_address_in        	(PE_Cluster_weight_2_2_address_in      	),
	.weight_2_2_data_in_valid     	(PE_Cluster_weight_2_2_data_in_valid   	),
	.weight_2_2_data_in           	(PE_Cluster_weight_2_2_data_in         	),
	.psum_0_in_ready            	(PE_Cluster_psum_0_in_ready             ),
	.psum_0_in_valid            	(PE_Cluster_psum_0_in_valid             ),
	.psum_0_in                  	(PE_Cluster_psum_0_in                   ),
	.psum_1_in_ready            	(PE_Cluster_psum_1_in_ready             ),
	.psum_1_in_valid            	(PE_Cluster_psum_1_in_valid             ),
	.psum_1_in                  	(PE_Cluster_psum_1_in                   ),
	.psum_2_in_ready            	(PE_Cluster_psum_2_in_ready             ),
	.psum_2_in_valid            	(PE_Cluster_psum_2_in_valid             ),
	.psum_2_in                  	(PE_Cluster_psum_2_in                   ),
	.psum_0_out_ready           	(PE_Cluster_psum_0_out_ready            ),
	.psum_0_out_valid           	(PE_Cluster_psum_0_out_valid            ),
	.psum_0_out                 	(PE_Cluster_psum_0_out                  ),
	.psum_1_out_ready           	(PE_Cluster_psum_1_out_ready            ),
	.psum_1_out_valid           	(PE_Cluster_psum_1_out_valid            ),
	.psum_1_out                 	(PE_Cluster_psum_1_out                  ),
	.psum_2_out_ready           	(PE_Cluster_psum_2_out_ready            ),
	.psum_2_out_valid           	(PE_Cluster_psum_2_out_valid            ),
	.psum_2_out                 	(PE_Cluster_psum_2_out                  ),
	.psum_0_in_from_south_ready 	(PE_Cluster_psum_0_in_from_south_ready  ),
	.psum_0_in_from_south_valid 	(PE_Cluster_psum_0_in_from_south_valid  ),
	.psum_0_in_from_south       	(PE_Cluster_psum_0_in_from_south        ),
	.psum_1_in_from_south_ready 	(PE_Cluster_psum_1_in_from_south_ready  ),
	.psum_1_in_from_south_valid 	(PE_Cluster_psum_1_in_from_south_valid  ),
	.psum_1_in_from_south       	(PE_Cluster_psum_1_in_from_south        ),
	.psum_2_in_from_south_ready 	(PE_Cluster_psum_2_in_from_south_ready  ),
	.psum_2_in_from_south_valid 	(PE_Cluster_psum_2_in_from_south_valid  ),
	.psum_2_in_from_south       	(PE_Cluster_psum_2_in_from_south        ),
	.PE_0_0_disable					(PE_Cluster_PE_0_0_disable				),
	.PE_0_1_disable					(PE_Cluster_PE_0_1_disable				),
	.PE_0_2_disable					(PE_Cluster_PE_0_2_disable				),
	.PE_1_0_disable					(PE_Cluster_PE_1_0_disable				),
	.PE_1_1_disable					(PE_Cluster_PE_1_1_disable				),
	.PE_1_2_disable					(PE_Cluster_PE_1_2_disable				),
	.PE_2_0_disable					(PE_Cluster_PE_2_0_disable				),
	.PE_2_1_disable					(PE_Cluster_PE_2_1_disable				),
	.PE_2_2_disable					(PE_Cluster_PE_2_2_disable				),
	.psum_load_en               	(PE_Cluster_psum_load_en                ),
	.iact_data_in_sel           	(PE_Cluster_iact_data_in_sel            ),
	.iact_data_out_sel          	(PE_Cluster_iact_data_out_sel           ),
	.psum_data_in_sel           	(PE_Cluster_psum_data_in_sel            ),
	.do_en                      	(PE_Cluster_do_en                       ),
	.iact_write_fin_clear			(PE_Cluster_iact_write_fin_clear		),
	.weight_write_fin_clear			(PE_Cluster_weight_write_fin_clear	   	),
	.all_write_fin					(PE_Cluster_all_write_fin			   	),
	.all_cal_fin                	(PE_Cluster_all_cal_fin                	),
	.PSUM_DEPTH						(PSUM_DEPTH							   	),
	.psum_spad_clear				(psum_spad_clear					   	)
);

GLB_Cluster GLB_Cluster ( 
	.clock                              	(GLB_Cluster_clock                               	),
	.reset                              	(GLB_Cluster_reset                               	),
	.iact_SRAM_Bank_0_0_address_in_ready  	(GLB_Cluster_iact_SRAM_Bank_0_0_address_in_ready   	),
	.iact_SRAM_Bank_0_0_address_in_valid  	(GLB_Cluster_iact_SRAM_Bank_0_0_address_in_valid   	),
	.iact_SRAM_Bank_0_0_address_in        	(GLB_Cluster_iact_SRAM_Bank_0_0_address_in         	),
	.iact_SRAM_Bank_0_0_data_in_ready     	(GLB_Cluster_iact_SRAM_Bank_0_0_data_in_ready      	),
	.iact_SRAM_Bank_0_0_data_in_valid     	(GLB_Cluster_iact_SRAM_Bank_0_0_data_in_valid      	),
	.iact_SRAM_Bank_0_0_data_in           	(GLB_Cluster_iact_SRAM_Bank_0_0_data_in            	),
	.iact_SRAM_Bank_0_0_address_out_ready 	(GLB_Cluster_iact_SRAM_Bank_0_0_address_out_ready  	),
	.iact_SRAM_Bank_0_0_address_out_valid 	(GLB_Cluster_iact_SRAM_Bank_0_0_address_out_valid  	),
	.iact_SRAM_Bank_0_0_address_out       	(GLB_Cluster_iact_SRAM_Bank_0_0_address_out        	),
	.iact_SRAM_Bank_0_0_data_out_ready    	(GLB_Cluster_iact_SRAM_Bank_0_0_data_out_ready     	),
	.iact_SRAM_Bank_0_0_data_out_valid    	(GLB_Cluster_iact_SRAM_Bank_0_0_data_out_valid     	),
	.iact_SRAM_Bank_0_0_data_out     		(GLB_Cluster_iact_SRAM_Bank_0_0_data_out     		),
	.iact_SRAM_Bank_0_0_write_en 		    (GLB_Cluster_iact_SRAM_Bank_0_0_write_en 		    ),
	.iact_SRAM_Bank_0_0_write_done        	(GLB_Cluster_iact_SRAM_Bank_0_0_write_done         	),
	.iact_SRAM_Bank_0_0_read_en   			(GLB_Cluster_iact_SRAM_Bank_0_0_read_en   		    ),
	.iact_SRAM_Bank_0_0_read_addr        	(GLB_Cluster_iact_SRAM_Bank_0_0_read_addr          	),
	.iact_SRAM_Bank_0_0_read_done    		(GLB_Cluster_iact_SRAM_Bank_0_0_read_done    		),
	.iact_SRAM_Bank_0_1_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_0_1_address_in_ready   	),
	.iact_SRAM_Bank_0_1_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_0_1_address_in_valid   	),
	.iact_SRAM_Bank_0_1_address_in       	(GLB_Cluster_iact_SRAM_Bank_0_1_address_in         	),
	.iact_SRAM_Bank_0_1_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_0_1_data_in_ready      	),
	.iact_SRAM_Bank_0_1_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_0_1_data_in_valid      	),
	.iact_SRAM_Bank_0_1_data_in          	(GLB_Cluster_iact_SRAM_Bank_0_1_data_in          	),
	.iact_SRAM_Bank_0_1_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_0_1_address_out_ready  	),
	.iact_SRAM_Bank_0_1_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_0_1_address_out_valid	),
	.iact_SRAM_Bank_0_1_address_out      	(GLB_Cluster_iact_SRAM_Bank_0_1_address_out        	),
	.iact_SRAM_Bank_0_1_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_0_1_data_out_ready     	),
	.iact_SRAM_Bank_0_1_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_0_1_data_out_valid     	),
	.iact_SRAM_Bank_0_1_data_out         	(GLB_Cluster_iact_SRAM_Bank_0_1_data_out        		),
	.iact_SRAM_Bank_0_1_write_en         	(GLB_Cluster_iact_SRAM_Bank_0_1_write_en           	),
	.iact_SRAM_Bank_0_1_write_done       	(GLB_Cluster_iact_SRAM_Bank_0_1_write_done         	),
	.iact_SRAM_Bank_0_1_read_en          	(GLB_Cluster_iact_SRAM_Bank_0_1_read_en            	),
	.iact_SRAM_Bank_0_1_read_addr        	(GLB_Cluster_iact_SRAM_Bank_0_1_read_addr          	),
	.iact_SRAM_Bank_0_1_read_done        	(GLB_Cluster_iact_SRAM_Bank_0_1_read_done          	),
	.iact_SRAM_Bank_0_2_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_0_2_address_in_ready   	),
	.iact_SRAM_Bank_0_2_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_0_2_address_in_valid   	),
	.iact_SRAM_Bank_0_2_address_in       	(GLB_Cluster_iact_SRAM_Bank_0_2_address_in         	),
	.iact_SRAM_Bank_0_2_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_0_2_data_in_ready      	),
	.iact_SRAM_Bank_0_2_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_0_2_data_in_valid      	),
	.iact_SRAM_Bank_0_2_data_in          	(GLB_Cluster_iact_SRAM_Bank_0_2_data_in          	),	
	.iact_SRAM_Bank_0_2_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_0_2_address_out_ready  	),
	.iact_SRAM_Bank_0_2_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_0_2_address_out_valid  	),
	.iact_SRAM_Bank_0_2_address_out      	(GLB_Cluster_iact_SRAM_Bank_0_2_address_out        	),
	.iact_SRAM_Bank_0_2_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_0_2_data_out_ready     	),
	.iact_SRAM_Bank_0_2_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_0_2_data_out_valid     	),
	.iact_SRAM_Bank_0_2_data_out         	(GLB_Cluster_iact_SRAM_Bank_0_2_data_out         	),	
	.iact_SRAM_Bank_0_2_write_en         	(GLB_Cluster_iact_SRAM_Bank_0_2_write_en           	),
	.iact_SRAM_Bank_0_2_write_done       	(GLB_Cluster_iact_SRAM_Bank_0_2_write_done         	),
	.iact_SRAM_Bank_0_2_read_en          	(GLB_Cluster_iact_SRAM_Bank_0_2_read_en            	),
	.iact_SRAM_Bank_0_2_read_addr        	(GLB_Cluster_iact_SRAM_Bank_0_2_read_addr          	),
	.iact_SRAM_Bank_0_2_read_done      		(GLB_Cluster_iact_SRAM_Bank_0_2_read_done      		),
	.iact_SRAM_Bank_1_0_address_in_ready  	(GLB_Cluster_iact_SRAM_Bank_1_0_address_in_ready   	),
	.iact_SRAM_Bank_1_0_address_in_valid  	(GLB_Cluster_iact_SRAM_Bank_1_0_address_in_valid   	),
	.iact_SRAM_Bank_1_0_address_in        	(GLB_Cluster_iact_SRAM_Bank_1_0_address_in         	),
	.iact_SRAM_Bank_1_0_data_in_ready     	(GLB_Cluster_iact_SRAM_Bank_1_0_data_in_ready      	),
	.iact_SRAM_Bank_1_0_data_in_valid     	(GLB_Cluster_iact_SRAM_Bank_1_0_data_in_valid      	),
	.iact_SRAM_Bank_1_0_data_in           	(GLB_Cluster_iact_SRAM_Bank_1_0_data_in            	),
	.iact_SRAM_Bank_1_0_address_out_ready 	(GLB_Cluster_iact_SRAM_Bank_1_0_address_out_ready  	),
	.iact_SRAM_Bank_1_0_address_out_valid 	(GLB_Cluster_iact_SRAM_Bank_1_0_address_out_valid  	),
	.iact_SRAM_Bank_1_0_address_out       	(GLB_Cluster_iact_SRAM_Bank_1_0_address_out        	),
	.iact_SRAM_Bank_1_0_data_out_ready    	(GLB_Cluster_iact_SRAM_Bank_1_0_data_out_ready     	),
	.iact_SRAM_Bank_1_0_data_out_valid    	(GLB_Cluster_iact_SRAM_Bank_1_0_data_out_valid     	),
	.iact_SRAM_Bank_1_0_data_out     		(GLB_Cluster_iact_SRAM_Bank_1_0_data_out     		),
	.iact_SRAM_Bank_1_0_write_en 		    (GLB_Cluster_iact_SRAM_Bank_1_0_write_en 		    ),
	.iact_SRAM_Bank_1_0_write_done        	(GLB_Cluster_iact_SRAM_Bank_1_0_write_done         	),
	.iact_SRAM_Bank_1_0_read_en   			(GLB_Cluster_iact_SRAM_Bank_1_0_read_en   		    ),
	.iact_SRAM_Bank_1_0_read_addr        	(GLB_Cluster_iact_SRAM_Bank_1_0_read_addr          	),
	.iact_SRAM_Bank_1_0_read_done    		(GLB_Cluster_iact_SRAM_Bank_1_0_read_done    		),
	.iact_SRAM_Bank_1_1_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_1_1_address_in_ready   	),
	.iact_SRAM_Bank_1_1_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_1_1_address_in_valid   	),
	.iact_SRAM_Bank_1_1_address_in       	(GLB_Cluster_iact_SRAM_Bank_1_1_address_in         	),
	.iact_SRAM_Bank_1_1_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_1_1_data_in_ready      	),
	.iact_SRAM_Bank_1_1_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_1_1_data_in_valid      	),
	.iact_SRAM_Bank_1_1_data_in          	(GLB_Cluster_iact_SRAM_Bank_1_1_data_in          	),
	.iact_SRAM_Bank_1_1_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_1_1_address_out_ready  	),
	.iact_SRAM_Bank_1_1_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_1_1_address_out_valid	),
	.iact_SRAM_Bank_1_1_address_out      	(GLB_Cluster_iact_SRAM_Bank_1_1_address_out        	),
	.iact_SRAM_Bank_1_1_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_1_1_data_out_ready     	),
	.iact_SRAM_Bank_1_1_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_1_1_data_out_valid     	),
	.iact_SRAM_Bank_1_1_data_out         	(GLB_Cluster_iact_SRAM_Bank_1_1_data_out        		),
	.iact_SRAM_Bank_1_1_write_en         	(GLB_Cluster_iact_SRAM_Bank_1_1_write_en           	),
	.iact_SRAM_Bank_1_1_write_done       	(GLB_Cluster_iact_SRAM_Bank_1_1_write_done         	),
	.iact_SRAM_Bank_1_1_read_en          	(GLB_Cluster_iact_SRAM_Bank_1_1_read_en            	),
	.iact_SRAM_Bank_1_1_read_addr        	(GLB_Cluster_iact_SRAM_Bank_1_1_read_addr          	),
	.iact_SRAM_Bank_1_1_read_done        	(GLB_Cluster_iact_SRAM_Bank_1_1_read_done          	),
	.iact_SRAM_Bank_1_2_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_1_2_address_in_ready   	),
	.iact_SRAM_Bank_1_2_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_1_2_address_in_valid   	),
	.iact_SRAM_Bank_1_2_address_in       	(GLB_Cluster_iact_SRAM_Bank_1_2_address_in         	),
	.iact_SRAM_Bank_1_2_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_1_2_data_in_ready      	),
	.iact_SRAM_Bank_1_2_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_1_2_data_in_valid      	),
	.iact_SRAM_Bank_1_2_data_in          	(GLB_Cluster_iact_SRAM_Bank_1_2_data_in          	),	
	.iact_SRAM_Bank_1_2_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_1_2_address_out_ready  	),
	.iact_SRAM_Bank_1_2_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_1_2_address_out_valid  	),
	.iact_SRAM_Bank_1_2_address_out      	(GLB_Cluster_iact_SRAM_Bank_1_2_address_out        	),
	.iact_SRAM_Bank_1_2_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_1_2_data_out_ready     	),
	.iact_SRAM_Bank_1_2_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_1_2_data_out_valid     	),
	.iact_SRAM_Bank_1_2_data_out         	(GLB_Cluster_iact_SRAM_Bank_1_2_data_out         	),	
	.iact_SRAM_Bank_1_2_write_en         	(GLB_Cluster_iact_SRAM_Bank_1_2_write_en           	),
	.iact_SRAM_Bank_1_2_write_done       	(GLB_Cluster_iact_SRAM_Bank_1_2_write_done         	),
	.iact_SRAM_Bank_1_2_read_en          	(GLB_Cluster_iact_SRAM_Bank_1_2_read_en            	),
	.iact_SRAM_Bank_1_2_read_addr        	(GLB_Cluster_iact_SRAM_Bank_1_2_read_addr          	),
	.iact_SRAM_Bank_1_2_read_done      		(GLB_Cluster_iact_SRAM_Bank_1_2_read_done      		),
	.iact_SRAM_Bank_2_0_address_in_ready  	(GLB_Cluster_iact_SRAM_Bank_2_0_address_in_ready   	),
	.iact_SRAM_Bank_2_0_address_in_valid  	(GLB_Cluster_iact_SRAM_Bank_2_0_address_in_valid   	),
	.iact_SRAM_Bank_2_0_address_in        	(GLB_Cluster_iact_SRAM_Bank_2_0_address_in         	),
	.iact_SRAM_Bank_2_0_data_in_ready     	(GLB_Cluster_iact_SRAM_Bank_2_0_data_in_ready      	),
	.iact_SRAM_Bank_2_0_data_in_valid     	(GLB_Cluster_iact_SRAM_Bank_2_0_data_in_valid      	),
	.iact_SRAM_Bank_2_0_data_in           	(GLB_Cluster_iact_SRAM_Bank_2_0_data_in            	),
	.iact_SRAM_Bank_2_0_address_out_ready 	(GLB_Cluster_iact_SRAM_Bank_2_0_address_out_ready  	),
	.iact_SRAM_Bank_2_0_address_out_valid 	(GLB_Cluster_iact_SRAM_Bank_2_0_address_out_valid  	),
	.iact_SRAM_Bank_2_0_address_out       	(GLB_Cluster_iact_SRAM_Bank_2_0_address_out        	),
	.iact_SRAM_Bank_2_0_data_out_ready    	(GLB_Cluster_iact_SRAM_Bank_2_0_data_out_ready     	),
	.iact_SRAM_Bank_2_0_data_out_valid    	(GLB_Cluster_iact_SRAM_Bank_2_0_data_out_valid     	),
	.iact_SRAM_Bank_2_0_data_out     		(GLB_Cluster_iact_SRAM_Bank_2_0_data_out     		),
	.iact_SRAM_Bank_2_0_write_en 		    (GLB_Cluster_iact_SRAM_Bank_2_0_write_en 		    ),
	.iact_SRAM_Bank_2_0_write_done        	(GLB_Cluster_iact_SRAM_Bank_2_0_write_done         	),
	.iact_SRAM_Bank_2_0_read_en   			(GLB_Cluster_iact_SRAM_Bank_2_0_read_en   		    ),
	.iact_SRAM_Bank_2_0_read_addr        	(GLB_Cluster_iact_SRAM_Bank_2_0_read_addr          	),
	.iact_SRAM_Bank_2_0_read_done    		(GLB_Cluster_iact_SRAM_Bank_2_0_read_done    		),
	.iact_SRAM_Bank_2_1_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_2_1_address_in_ready   	),
	.iact_SRAM_Bank_2_1_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_2_1_address_in_valid   	),
	.iact_SRAM_Bank_2_1_address_in       	(GLB_Cluster_iact_SRAM_Bank_2_1_address_in         	),
	.iact_SRAM_Bank_2_1_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_2_1_data_in_ready      	),
	.iact_SRAM_Bank_2_1_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_2_1_data_in_valid      	),
	.iact_SRAM_Bank_2_1_data_in          	(GLB_Cluster_iact_SRAM_Bank_2_1_data_in          	),
	.iact_SRAM_Bank_2_1_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_2_1_address_out_ready  	),
	.iact_SRAM_Bank_2_1_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_2_1_address_out_valid	),
	.iact_SRAM_Bank_2_1_address_out      	(GLB_Cluster_iact_SRAM_Bank_2_1_address_out        	),
	.iact_SRAM_Bank_2_1_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_2_1_data_out_ready     	),
	.iact_SRAM_Bank_2_1_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_2_1_data_out_valid     	),
	.iact_SRAM_Bank_2_1_data_out         	(GLB_Cluster_iact_SRAM_Bank_2_1_data_out        		),
	.iact_SRAM_Bank_2_1_write_en         	(GLB_Cluster_iact_SRAM_Bank_2_1_write_en           	),
	.iact_SRAM_Bank_2_1_write_done       	(GLB_Cluster_iact_SRAM_Bank_2_1_write_done         	),
	.iact_SRAM_Bank_2_1_read_en          	(GLB_Cluster_iact_SRAM_Bank_2_1_read_en            	),
	.iact_SRAM_Bank_2_1_read_addr        	(GLB_Cluster_iact_SRAM_Bank_2_1_read_addr          	),
	.iact_SRAM_Bank_2_1_read_done        	(GLB_Cluster_iact_SRAM_Bank_2_1_read_done          	),
	.iact_SRAM_Bank_2_2_address_in_ready 	(GLB_Cluster_iact_SRAM_Bank_2_2_address_in_ready   	),
	.iact_SRAM_Bank_2_2_address_in_valid 	(GLB_Cluster_iact_SRAM_Bank_2_2_address_in_valid   	),
	.iact_SRAM_Bank_2_2_address_in       	(GLB_Cluster_iact_SRAM_Bank_2_2_address_in         	),
	.iact_SRAM_Bank_2_2_data_in_ready    	(GLB_Cluster_iact_SRAM_Bank_2_2_data_in_ready      	),
	.iact_SRAM_Bank_2_2_data_in_valid    	(GLB_Cluster_iact_SRAM_Bank_2_2_data_in_valid      	),
	.iact_SRAM_Bank_2_2_data_in          	(GLB_Cluster_iact_SRAM_Bank_2_2_data_in          	),	
	.iact_SRAM_Bank_2_2_address_out_ready	(GLB_Cluster_iact_SRAM_Bank_2_2_address_out_ready  	),
	.iact_SRAM_Bank_2_2_address_out_valid	(GLB_Cluster_iact_SRAM_Bank_2_2_address_out_valid  	),
	.iact_SRAM_Bank_2_2_address_out      	(GLB_Cluster_iact_SRAM_Bank_2_2_address_out        	),
	.iact_SRAM_Bank_2_2_data_out_ready   	(GLB_Cluster_iact_SRAM_Bank_2_2_data_out_ready     	),
	.iact_SRAM_Bank_2_2_data_out_valid   	(GLB_Cluster_iact_SRAM_Bank_2_2_data_out_valid     	),
	.iact_SRAM_Bank_2_2_data_out         	(GLB_Cluster_iact_SRAM_Bank_2_2_data_out         	),	
	.iact_SRAM_Bank_2_2_write_en         	(GLB_Cluster_iact_SRAM_Bank_2_2_write_en           	),
	.iact_SRAM_Bank_2_2_write_done       	(GLB_Cluster_iact_SRAM_Bank_2_2_write_done         	),
	.iact_SRAM_Bank_2_2_read_en          	(GLB_Cluster_iact_SRAM_Bank_2_2_read_en            	),
	.iact_SRAM_Bank_2_2_read_addr        	(GLB_Cluster_iact_SRAM_Bank_2_2_read_addr          	),
	.iact_SRAM_Bank_2_2_read_done      		(GLB_Cluster_iact_SRAM_Bank_2_2_read_done      		),
	.weight_0_address_in_ready      	(GLB_Cluster_weight_SRAM_Bank_0_address_in_ready  	),
	.weight_0_address_in_valid      	(GLB_Cluster_weight_SRAM_Bank_0_address_in_valid  	),
	.weight_0_address_in          		(GLB_Cluster_weight_SRAM_Bank_0_address_in        	),
	.weight_0_data_in_ready       		(GLB_Cluster_weight_SRAM_Bank_0_data_in_ready     	),
	.weight_0_data_in_valid       		(GLB_Cluster_weight_SRAM_Bank_0_data_in_valid     	),
	.weight_0_data_in         			(GLB_Cluster_weight_SRAM_Bank_0_data_in         	 	),		
	.weight_0_address_out_ready      	(GLB_Cluster_weight_SRAM_Bank_0_address_out_ready 	),
	.weight_0_address_out_valid      	(GLB_Cluster_weight_SRAM_Bank_0_address_out_valid 	),
	.weight_0_address_out         		(GLB_Cluster_weight_SRAM_Bank_0_address_out       	),
	.weight_0_data_out_ready      		(GLB_Cluster_weight_SRAM_Bank_0_data_out_ready    	),
	.weight_0_data_out_valid      		(GLB_Cluster_weight_SRAM_Bank_0_data_out_valid    	),
	.weight_0_data_out        			(GLB_Cluster_weight_SRAM_Bank_0_data_out        	 	),		
	.weight_1_address_in_ready      	(GLB_Cluster_weight_SRAM_Bank_1_address_in_ready  	),
	.weight_1_address_in_valid      	(GLB_Cluster_weight_SRAM_Bank_1_address_in_valid  	),
	.weight_1_address_in          		(GLB_Cluster_weight_SRAM_Bank_1_address_in        	),
	.weight_1_data_in_ready       		(GLB_Cluster_weight_SRAM_Bank_1_data_in_ready     	),
	.weight_1_data_in_valid       		(GLB_Cluster_weight_SRAM_Bank_1_data_in_valid     	),
	.weight_1_data_in        			(GLB_Cluster_weight_SRAM_Bank_1_data_in        	 	),					
	.weight_1_address_out_ready   		(GLB_Cluster_weight_SRAM_Bank_1_address_out_ready 	),
	.weight_1_address_out_valid   		(GLB_Cluster_weight_SRAM_Bank_1_address_out_valid 	),
	.weight_1_address_out         		(GLB_Cluster_weight_SRAM_Bank_1_address_out       	),
	.weight_1_data_out_ready      		(GLB_Cluster_weight_SRAM_Bank_1_data_out_ready    	),
	.weight_1_data_out_valid      		(GLB_Cluster_weight_SRAM_Bank_1_data_out_valid    	),
	.weight_1_data_out       			(GLB_Cluster_weight_SRAM_Bank_1_data_out       	 	),					
	.weight_2_address_in_ready    		(GLB_Cluster_weight_SRAM_Bank_2_address_in_ready  	),
	.weight_2_address_in_valid    		(GLB_Cluster_weight_SRAM_Bank_2_address_in_valid  	),
	.weight_2_address_in          		(GLB_Cluster_weight_SRAM_Bank_2_address_in        	),
	.weight_2_data_in_ready       		(GLB_Cluster_weight_SRAM_Bank_2_data_in_ready     	),
	.weight_2_data_in_valid       		(GLB_Cluster_weight_SRAM_Bank_2_data_in_valid     	),
	.weight_2_data_in        			(GLB_Cluster_weight_SRAM_Bank_2_data_in        	 	),			
	.weight_2_address_out_ready   		(GLB_Cluster_weight_SRAM_Bank_2_address_out_ready 	),
	.weight_2_address_out_valid   		(GLB_Cluster_weight_SRAM_Bank_2_address_out_valid 	),
	.weight_2_address_out         		(GLB_Cluster_weight_SRAM_Bank_2_address_out       	),
	.weight_2_data_out_ready      		(GLB_Cluster_weight_SRAM_Bank_2_data_out_ready    	),
	.weight_2_data_out_valid      		(GLB_Cluster_weight_SRAM_Bank_2_data_out_valid    	),
	.weight_2_data_out        			(GLB_Cluster_weight_SRAM_Bank_2_data_out        		),		
	.psum_SRAM_Bank_0_data_in_ready     (GLB_Cluster_psum_SRAM_Bank_0_data_in_ready      	),
	.psum_SRAM_Bank_0_data_in_valid     (GLB_Cluster_psum_SRAM_Bank_0_data_in_valid      	),
	.psum_SRAM_Bank_0_data_in           (GLB_Cluster_psum_SRAM_Bank_0_data_in            	),
	.psum_SRAM_Bank_0_data_out_ready    (GLB_Cluster_psum_SRAM_Bank_0_data_out_ready     	),
	.psum_SRAM_Bank_0_data_out_valid    (GLB_Cluster_psum_SRAM_Bank_0_data_out_valid     	),
	.psum_SRAM_Bank_0_data_out          (GLB_Cluster_psum_SRAM_Bank_0_data_out           	),
	.psum_SRAM_Bank_0_write_en          (GLB_Cluster_psum_SRAM_Bank_0_write_en           	),
	.psum_SRAM_Bank_0_write_addr        (GLB_Cluster_psum_SRAM_Bank_0_write_addr         	),
	.psum_SRAM_Bank_0_write_done        (GLB_Cluster_psum_SRAM_Bank_0_write_done         	),
	.psum_SRAM_Bank_0_read_out_en		(GLB_Cluster_psum_SRAM_Bank_0_read_out_en			),
	.psum_SRAM_Bank_0_read_en           (GLB_Cluster_psum_SRAM_Bank_0_read_en            	),
	.psum_SRAM_Bank_0_read_addr         (GLB_Cluster_psum_SRAM_Bank_0_read_addr          	),
	.psum_SRAM_Bank_1_data_in_ready     (GLB_Cluster_psum_SRAM_Bank_1_data_in_ready      	),
	.psum_SRAM_Bank_1_data_in_valid     (GLB_Cluster_psum_SRAM_Bank_1_data_in_valid      	),
	.psum_SRAM_Bank_1_data_in           (GLB_Cluster_psum_SRAM_Bank_1_data_in            	),
	.psum_SRAM_Bank_1_data_out_ready    (GLB_Cluster_psum_SRAM_Bank_1_data_out_ready     	),
	.psum_SRAM_Bank_1_data_out_valid    (GLB_Cluster_psum_SRAM_Bank_1_data_out_valid     	),
	.psum_SRAM_Bank_1_data_out          (GLB_Cluster_psum_SRAM_Bank_1_data_out           	),
	.psum_SRAM_Bank_1_write_en          (GLB_Cluster_psum_SRAM_Bank_1_write_en           	),
	.psum_SRAM_Bank_1_write_addr        (GLB_Cluster_psum_SRAM_Bank_1_write_addr         	),
	.psum_SRAM_Bank_1_write_done        (GLB_Cluster_psum_SRAM_Bank_1_write_done            	),
	.psum_SRAM_Bank_1_read_out_en		(GLB_Cluster_psum_SRAM_Bank_1_read_out_en			),
	.psum_SRAM_Bank_1_read_en           (GLB_Cluster_psum_SRAM_Bank_1_read_en            	),
	.psum_SRAM_Bank_1_read_addr         (GLB_Cluster_psum_SRAM_Bank_1_read_addr          	),
	.psum_SRAM_Bank_2_data_in_ready     (GLB_Cluster_psum_SRAM_Bank_2_data_in_ready      	),
	.psum_SRAM_Bank_2_data_in_valid     (GLB_Cluster_psum_SRAM_Bank_2_data_in_valid      	),
	.psum_SRAM_Bank_2_data_in           (GLB_Cluster_psum_SRAM_Bank_2_data_in            	),
	.psum_SRAM_Bank_2_data_out_ready    (GLB_Cluster_psum_SRAM_Bank_2_data_out_ready     	),
	.psum_SRAM_Bank_2_data_out_valid    (GLB_Cluster_psum_SRAM_Bank_2_data_out_valid     	),
	.psum_SRAM_Bank_2_data_out          (GLB_Cluster_psum_SRAM_Bank_2_data_out           	),
	.psum_SRAM_Bank_2_write_en          (GLB_Cluster_psum_SRAM_Bank_2_write_en           	),
	.psum_SRAM_Bank_2_write_addr        (GLB_Cluster_psum_SRAM_Bank_2_write_addr         	),
	.psum_SRAM_Bank_2_write_done        (GLB_Cluster_psum_SRAM_Bank_2_write_done         	),
	.psum_SRAM_Bank_2_read_out_en		(GLB_Cluster_psum_SRAM_Bank_2_read_out_en			),
	.psum_SRAM_Bank_2_read_en           (GLB_Cluster_psum_SRAM_Bank_2_read_en            	),
	.psum_SRAM_Bank_2_read_addr         (GLB_Cluster_psum_SRAM_Bank_2_read_addr          	),
	.PSUM_DEPTH							(PSUM_DEPTH							   				)
);

Router_Cluster Router_Cluster ( 
	.iact_0_data_in_sel             	(iact_0_data_in_sel             	),
	.iact_0_data_out_sel            	(iact_0_data_out_sel            	),
	.iact_1_data_in_sel             	(iact_1_data_in_sel             	),
	.iact_1_data_out_sel            	(iact_1_data_out_sel            	),
	.iact_2_data_in_sel             	(iact_2_data_in_sel             	),
	.iact_2_data_out_sel   				(iact_2_data_out_sel   				),	
	.weight_0_data_in_sel           	(weight_0_data_in_sel           	),
	.weight_0_data_out_sel          	(weight_0_data_out_sel          	),
	.weight_1_data_in_sel           	(weight_1_data_in_sel           	),
	.weight_1_data_out_sel          	(weight_1_data_out_sel          	),
	.weight_2_data_in_sel           	(weight_2_data_in_sel           	),
	.weight_2_data_out_sel 				(weight_2_data_out_sel 				),
	.psum_0_data_in_sel             	(psum_0_data_in_sel             	),
	.psum_0_data_out_sel            	(psum_0_data_out_sel            	),
	.psum_1_data_in_sel             	(psum_1_data_in_sel             	),
	.psum_1_data_out_sel            	(psum_1_data_out_sel            	),
	.psum_2_data_in_sel             	(psum_2_data_in_sel             	),
	.psum_2_data_out_sel            	(psum_2_data_out_sel            	),
	.iact_0_0_GLB_address_in_ready    	(iact_0_0_GLB_address_in_ready    	),
	.iact_0_0_GLB_address_in_valid    	(iact_0_0_GLB_address_in_valid    	),
	.iact_0_0_GLB_address_in_bits     	(iact_0_0_GLB_address_in_bits     	),
	.iact_0_0_GLB_data_in_ready       	(iact_0_0_GLB_data_in_ready       	),
	.iact_0_0_GLB_data_in_valid       	(iact_0_0_GLB_data_in_valid       	),
	.iact_0_0_GLB_data_in_bits        	(iact_0_0_GLB_data_in_bits        	),
	.iact_0_0_north_address_in_ready  	(iact_0_0_north_address_in_ready  	),
	.iact_0_0_north_address_in_valid  	(iact_0_0_north_address_in_valid  	),
	.iact_0_0_north_address_in_bits   	(iact_0_0_north_address_in_bits   	),
	.iact_0_0_north_data_in_ready     	(iact_0_0_north_data_in_ready     	),
	.iact_0_0_north_data_in_valid     	(iact_0_0_north_data_in_valid     	),
	.iact_0_0_north_data_in_bits      	(iact_0_0_north_data_in_bits      	),
	.iact_0_0_south_address_in_ready  	(iact_0_0_south_address_in_ready  	),
	.iact_0_0_south_address_in_valid  	(iact_0_0_south_address_in_valid  	),
	.iact_0_0_south_address_in_bits   	(iact_0_0_south_address_in_bits   	),
	.iact_0_0_south_data_in_ready     	(iact_0_0_south_data_in_ready     	),
	.iact_0_0_south_data_in_valid     	(iact_0_0_south_data_in_valid     	),
	.iact_0_0_south_data_in_bits      	(iact_0_0_south_data_in_bits      	),
	.iact_0_0_horiz_address_in_ready  	(iact_0_0_horiz_address_in_ready  	),
	.iact_0_0_horiz_address_in_valid  	(iact_0_0_horiz_address_in_valid  	),
	.iact_0_0_horiz_address_in_bits   	(iact_0_0_horiz_address_in_bits   	),
	.iact_0_0_horiz_data_in_ready   	(iact_0_0_horiz_data_in_ready   	),
	.iact_0_0_horiz_data_in_valid     	(iact_0_0_horiz_data_in_valid     	),
	.iact_0_0_horiz_data_in_bits      	(iact_0_0_horiz_data_in_bits      	),
	.iact_0_0_PE_address_out_ready    	(iact_0_0_PE_address_out_ready    	),
	.iact_0_0_PE_address_out_bits     	(iact_0_0_PE_address_out_bits     	),
	.iact_0_0_PE_address_out_valid    	(iact_0_0_PE_address_out_valid    	),
	.iact_0_0_PE_data_out_ready       	(iact_0_0_PE_data_out_ready       	),
	.iact_0_0_PE_data_out_valid       	(iact_0_0_PE_data_out_valid       	),
	.iact_0_0_PE_data_out_bits        	(iact_0_0_PE_data_out_bits        	),
	.iact_0_0_north_address_out_ready	(iact_0_0_north_address_out_ready	),
	.iact_0_0_north_address_out_valid 	(iact_0_0_north_address_out_valid 	),
	.iact_0_0_north_address_out_bits  	(iact_0_0_north_address_out_bits  	),
	.iact_0_0_north_data_out_ready		(iact_0_0_north_data_out_ready		),
	.iact_0_0_north_data_out_valid    	(iact_0_0_north_data_out_valid    	),
	.iact_0_0_north_data_out_bits     	(iact_0_0_north_data_out_bits     	),
	.iact_0_0_south_address_out_ready 	(iact_0_0_south_address_out_ready 	),
	.iact_0_0_south_address_out_bits  	(iact_0_0_south_address_out_bits  	),
	.iact_0_0_south_address_out_valid 	(iact_0_0_south_address_out_valid 	),
	.iact_0_0_south_data_out_ready    	(iact_0_0_south_data_out_ready    	),
	.iact_0_0_south_data_out_valid    	(iact_0_0_south_data_out_valid    	),
	.iact_0_0_south_data_out_bits     	(iact_0_0_south_data_out_bits     	),
	.iact_0_0_horiz_address_out_ready 	(iact_0_0_horiz_address_out_ready 	),
	.iact_0_0_horiz_address_out_bits  	(iact_0_0_horiz_address_out_bits  	),
	.iact_0_0_horiz_address_out_valid 	(iact_0_0_horiz_address_out_valid 	),
	.iact_0_0_horiz_data_out_ready    	(iact_0_0_horiz_data_out_ready    	),
	.iact_0_0_horiz_data_out_valid    	(iact_0_0_horiz_data_out_valid    	),
	.iact_0_0_horiz_data_out_bits  		(iact_0_0_horiz_data_out_bits  		),
	.iact_0_1_GLB_address_in_ready    	(iact_0_1_GLB_address_in_ready    	),
	.iact_0_1_GLB_address_in_valid    	(iact_0_1_GLB_address_in_valid    	),
	.iact_0_1_GLB_address_in_bits     	(iact_0_1_GLB_address_in_bits     	),
	.iact_0_1_GLB_data_in_ready       	(iact_0_1_GLB_data_in_ready       	),
	.iact_0_1_GLB_data_in_valid       	(iact_0_1_GLB_data_in_valid       	),
	.iact_0_1_GLB_data_in_bits        	(iact_0_1_GLB_data_in_bits        	),
	.iact_0_1_north_address_in_ready  	(iact_0_1_north_address_in_ready  	),
	.iact_0_1_north_address_in_valid  	(iact_0_1_north_address_in_valid  	),
	.iact_0_1_north_address_in_bits   	(iact_0_1_north_address_in_bits   	),
	.iact_0_1_north_data_in_ready     	(iact_0_1_north_data_in_ready     	),
	.iact_0_1_north_data_in_valid     	(iact_0_1_north_data_in_valid     	),
	.iact_0_1_north_data_in_bits      	(iact_0_1_north_data_in_bits      	),
	.iact_0_1_south_address_in_ready  	(iact_0_1_south_address_in_ready  	),
	.iact_0_1_south_address_in_valid  	(iact_0_1_south_address_in_valid  	),
	.iact_0_1_south_address_in_bits   	(iact_0_1_south_address_in_bits   	),
	.iact_0_1_south_data_in_ready     	(iact_0_1_south_data_in_ready     	),
	.iact_0_1_south_data_in_valid     	(iact_0_1_south_data_in_valid     	),
	.iact_0_1_south_data_in_bits      	(iact_0_1_south_data_in_bits      	),
	.iact_0_1_horiz_address_in_ready  	(iact_0_1_horiz_address_in_ready  	),
	.iact_0_1_horiz_address_in_valid  	(iact_0_1_horiz_address_in_valid  	),
	.iact_0_1_horiz_address_in_bits   	(iact_0_1_horiz_address_in_bits   	),
	.iact_0_1_horiz_data_in_ready     	(iact_0_1_horiz_data_in_ready     	),
	.iact_0_1_horiz_data_in_valid     	(iact_0_1_horiz_data_in_valid     	),
	.iact_0_1_horiz_data_in_bits      	(iact_0_1_horiz_data_in_bits      	),
	.iact_0_1_PE_address_out_ready    	(iact_0_1_PE_address_out_ready    	),
	.iact_0_1_PE_address_out_bits     	(iact_0_1_PE_address_out_bits     	),
	.iact_0_1_PE_address_out_valid    	(iact_0_1_PE_address_out_valid    	),
	.iact_0_1_PE_data_out_ready       	(iact_0_1_PE_data_out_ready       	),
	.iact_0_1_PE_data_out_valid       	(iact_0_1_PE_data_out_valid       	),
	.iact_0_1_PE_data_out_bits        	(iact_0_1_PE_data_out_bits        	),
	.iact_0_1_north_address_out_ready	(iact_0_1_north_address_out_ready	),
	.iact_0_1_north_address_out_valid 	(iact_0_1_north_address_out_valid 	),
	.iact_0_1_north_address_out_bits  	(iact_0_1_north_address_out_bits  	),
	.iact_0_1_north_data_out_ready		(iact_0_1_north_data_out_ready		),
	.iact_0_1_north_data_out_valid    	(iact_0_1_north_data_out_valid    	),
	.iact_0_1_north_data_out_bits     	(iact_0_1_north_data_out_bits     	),
	.iact_0_1_south_address_out_ready 	(iact_0_1_south_address_out_ready 	),
	.iact_0_1_south_address_out_bits  	(iact_0_1_south_address_out_bits  	),
	.iact_0_1_south_address_out_valid 	(iact_0_1_south_address_out_valid 	),
	.iact_0_1_south_data_out_ready    	(iact_0_1_south_data_out_ready    	),
	.iact_0_1_south_data_out_valid    	(iact_0_1_south_data_out_valid    	),
	.iact_0_1_south_data_out_bits     	(iact_0_1_south_data_out_bits     	),
	.iact_0_1_horiz_address_out_ready 	(iact_0_1_horiz_address_out_ready 	),
	.iact_0_1_horiz_address_out_bits  	(iact_0_1_horiz_address_out_bits  	),
	.iact_0_1_horiz_address_out_valid 	(iact_0_1_horiz_address_out_valid 	),
	.iact_0_1_horiz_data_out_ready    	(iact_0_1_horiz_data_out_ready    	),
	.iact_0_1_horiz_data_out_valid    	(iact_0_1_horiz_data_out_valid    	),
	.iact_0_1_horiz_data_out_bits   	(iact_0_1_horiz_data_out_bits   	),
	.iact_0_2_GLB_address_in_ready    	(iact_0_2_GLB_address_in_ready    	),
	.iact_0_2_GLB_address_in_valid    	(iact_0_2_GLB_address_in_valid    	),
	.iact_0_2_GLB_address_in_bits     	(iact_0_2_GLB_address_in_bits     	),
	.iact_0_2_GLB_data_in_ready       	(iact_0_2_GLB_data_in_ready       	),
	.iact_0_2_GLB_data_in_valid       	(iact_0_2_GLB_data_in_valid       	),
	.iact_0_2_GLB_data_in_bits        	(iact_0_2_GLB_data_in_bits        	),
	.iact_0_2_north_address_in_ready  	(iact_0_2_north_address_in_ready  	),
	.iact_0_2_north_address_in_valid  	(iact_0_2_north_address_in_valid  	),
	.iact_0_2_north_address_in_bits   	(iact_0_2_north_address_in_bits   	),
	.iact_0_2_north_data_in_ready     	(iact_0_2_north_data_in_ready     	),
	.iact_0_2_north_data_in_valid     	(iact_0_2_north_data_in_valid     	),
	.iact_0_2_north_data_in_bits      	(iact_0_2_north_data_in_bits      	),
	.iact_0_2_south_address_in_ready  	(iact_0_2_south_address_in_ready  	),
	.iact_0_2_south_address_in_valid  	(iact_0_2_south_address_in_valid  	),
	.iact_0_2_south_address_in_bits   	(iact_0_2_south_address_in_bits   	),
	.iact_0_2_south_data_in_ready     	(iact_0_2_south_data_in_ready     	),
	.iact_0_2_south_data_in_valid     	(iact_0_2_south_data_in_valid     	),
	.iact_0_2_south_data_in_bits      	(iact_0_2_south_data_in_bits      	),
	.iact_0_2_horiz_address_in_ready  	(iact_0_2_horiz_address_in_ready  	),
	.iact_0_2_horiz_address_in_valid  	(iact_0_2_horiz_address_in_valid  	),
	.iact_0_2_horiz_address_in_bits   	(iact_0_2_horiz_address_in_bits   	),
	.iact_0_2_horiz_data_in_ready     	(iact_0_2_horiz_data_in_ready     	),
	.iact_0_2_horiz_data_in_valid     	(iact_0_2_horiz_data_in_valid     	),
	.iact_0_2_horiz_data_in_bits      	(iact_0_2_horiz_data_in_bits      	),
	.iact_0_2_PE_address_out_ready    	(iact_0_2_PE_address_out_ready    	),
	.iact_0_2_PE_address_out_bits     	(iact_0_2_PE_address_out_bits     	),
	.iact_0_2_PE_address_out_valid    	(iact_0_2_PE_address_out_valid    	),
	.iact_0_2_PE_data_out_ready       	(iact_0_2_PE_data_out_ready       	),
	.iact_0_2_PE_data_out_valid       	(iact_0_2_PE_data_out_valid       	),
	.iact_0_2_PE_data_out_bits        	(iact_0_2_PE_data_out_bits        	),
	.iact_0_2_north_address_out_ready	(iact_0_2_north_address_out_ready	),
	.iact_0_2_north_address_out_valid 	(iact_0_2_north_address_out_valid 	),
	.iact_0_2_north_address_out_bits  	(iact_0_2_north_address_out_bits  	),
	.iact_0_2_north_data_out_ready		(iact_0_2_north_data_out_ready		),
	.iact_0_2_north_data_out_valid    	(iact_0_2_north_data_out_valid    	),
	.iact_0_2_north_data_out_bits     	(iact_0_2_north_data_out_bits     	),
	.iact_0_2_south_address_out_ready 	(iact_0_2_south_address_out_ready 	),
	.iact_0_2_south_address_out_bits  	(iact_0_2_south_address_out_bits  	),
	.iact_0_2_south_address_out_valid 	(iact_0_2_south_address_out_valid 	),
	.iact_0_2_south_data_out_ready    	(iact_0_2_south_data_out_ready    	),
	.iact_0_2_south_data_out_valid    	(iact_0_2_south_data_out_valid    	),
	.iact_0_2_south_data_out_bits     	(iact_0_2_south_data_out_bits     	),
	.iact_0_2_horiz_address_out_ready 	(iact_0_2_horiz_address_out_ready 	),
	.iact_0_2_horiz_address_out_bits  	(iact_0_2_horiz_address_out_bits  	),
	.iact_0_2_horiz_address_out_valid 	(iact_0_2_horiz_address_out_valid 	),
	.iact_0_2_horiz_data_out_ready    	(iact_0_2_horiz_data_out_ready    	),
	.iact_0_2_horiz_data_out_valid    	(iact_0_2_horiz_data_out_valid    	),
	.iact_0_2_horiz_data_out_bits     	(iact_0_2_horiz_data_out_bits     	),
	.iact_1_0_GLB_address_in_ready    	(iact_1_0_GLB_address_in_ready    	),
	.iact_1_0_GLB_address_in_valid    	(iact_1_0_GLB_address_in_valid    	),
	.iact_1_0_GLB_address_in_bits     	(iact_1_0_GLB_address_in_bits     	),
	.iact_1_0_GLB_data_in_ready       	(iact_1_0_GLB_data_in_ready       	),
	.iact_1_0_GLB_data_in_valid       	(iact_1_0_GLB_data_in_valid       	),
	.iact_1_0_GLB_data_in_bits        	(iact_1_0_GLB_data_in_bits        	),
	.iact_1_0_north_address_in_ready  	(iact_1_0_north_address_in_ready  	),
	.iact_1_0_north_address_in_valid  	(iact_1_0_north_address_in_valid  	),
	.iact_1_0_north_address_in_bits   	(iact_1_0_north_address_in_bits   	),
	.iact_1_0_north_data_in_ready     	(iact_1_0_north_data_in_ready     	),
	.iact_1_0_north_data_in_valid     	(iact_1_0_north_data_in_valid     	),
	.iact_1_0_north_data_in_bits      	(iact_1_0_north_data_in_bits      	),
	.iact_1_0_south_address_in_ready  	(iact_1_0_south_address_in_ready  	),
	.iact_1_0_south_address_in_valid  	(iact_1_0_south_address_in_valid  	),
	.iact_1_0_south_address_in_bits   	(iact_1_0_south_address_in_bits   	),
	.iact_1_0_south_data_in_ready     	(iact_1_0_south_data_in_ready     	),
	.iact_1_0_south_data_in_valid     	(iact_1_0_south_data_in_valid     	),
	.iact_1_0_south_data_in_bits      	(iact_1_0_south_data_in_bits      	),
	.iact_1_0_horiz_address_in_ready  	(iact_1_0_horiz_address_in_ready  	),
	.iact_1_0_horiz_address_in_valid  	(iact_1_0_horiz_address_in_valid  	),
	.iact_1_0_horiz_address_in_bits   	(iact_1_0_horiz_address_in_bits   	),
	.iact_1_0_horiz_data_in_ready   	(iact_1_0_horiz_data_in_ready   	),
	.iact_1_0_horiz_data_in_valid     	(iact_1_0_horiz_data_in_valid     	),
	.iact_1_0_horiz_data_in_bits      	(iact_1_0_horiz_data_in_bits      	),
	.iact_1_0_PE_address_out_ready    	(iact_1_0_PE_address_out_ready    	),
	.iact_1_0_PE_address_out_bits     	(iact_1_0_PE_address_out_bits     	),
	.iact_1_0_PE_address_out_valid    	(iact_1_0_PE_address_out_valid    	),
	.iact_1_0_PE_data_out_ready       	(iact_1_0_PE_data_out_ready       	),
	.iact_1_0_PE_data_out_valid       	(iact_1_0_PE_data_out_valid       	),
	.iact_1_0_PE_data_out_bits        	(iact_1_0_PE_data_out_bits        	),
	.iact_1_0_north_address_out_ready	(iact_1_0_north_address_out_ready	),
	.iact_1_0_north_address_out_valid 	(iact_1_0_north_address_out_valid 	),
	.iact_1_0_north_address_out_bits  	(iact_1_0_north_address_out_bits  	),
	.iact_1_0_north_data_out_ready		(iact_1_0_north_data_out_ready		),
	.iact_1_0_north_data_out_valid    	(iact_1_0_north_data_out_valid    	),
	.iact_1_0_north_data_out_bits     	(iact_1_0_north_data_out_bits     	),
	.iact_1_0_south_address_out_ready 	(iact_1_0_south_address_out_ready 	),
	.iact_1_0_south_address_out_bits  	(iact_1_0_south_address_out_bits  	),
	.iact_1_0_south_address_out_valid 	(iact_1_0_south_address_out_valid 	),
	.iact_1_0_south_data_out_ready    	(iact_1_0_south_data_out_ready    	),
	.iact_1_0_south_data_out_valid    	(iact_1_0_south_data_out_valid    	),
	.iact_1_0_south_data_out_bits     	(iact_1_0_south_data_out_bits     	),
	.iact_1_0_horiz_address_out_ready 	(iact_1_0_horiz_address_out_ready 	),
	.iact_1_0_horiz_address_out_bits  	(iact_1_0_horiz_address_out_bits  	),
	.iact_1_0_horiz_address_out_valid 	(iact_1_0_horiz_address_out_valid 	),
	.iact_1_0_horiz_data_out_ready    	(iact_1_0_horiz_data_out_ready    	),
	.iact_1_0_horiz_data_out_valid    	(iact_1_0_horiz_data_out_valid    	),
	.iact_1_0_horiz_data_out_bits  		(iact_1_0_horiz_data_out_bits  		),
	.iact_1_1_GLB_address_in_ready    	(iact_1_1_GLB_address_in_ready    	),
	.iact_1_1_GLB_address_in_valid    	(iact_1_1_GLB_address_in_valid    	),
	.iact_1_1_GLB_address_in_bits     	(iact_1_1_GLB_address_in_bits     	),
	.iact_1_1_GLB_data_in_ready       	(iact_1_1_GLB_data_in_ready       	),
	.iact_1_1_GLB_data_in_valid       	(iact_1_1_GLB_data_in_valid       	),
	.iact_1_1_GLB_data_in_bits        	(iact_1_1_GLB_data_in_bits        	),
	.iact_1_1_north_address_in_ready  	(iact_1_1_north_address_in_ready  	),
	.iact_1_1_north_address_in_valid  	(iact_1_1_north_address_in_valid  	),
	.iact_1_1_north_address_in_bits   	(iact_1_1_north_address_in_bits   	),
	.iact_1_1_north_data_in_ready     	(iact_1_1_north_data_in_ready     	),
	.iact_1_1_north_data_in_valid     	(iact_1_1_north_data_in_valid     	),
	.iact_1_1_north_data_in_bits      	(iact_1_1_north_data_in_bits      	),
	.iact_1_1_south_address_in_ready  	(iact_1_1_south_address_in_ready  	),
	.iact_1_1_south_address_in_valid  	(iact_1_1_south_address_in_valid  	),
	.iact_1_1_south_address_in_bits   	(iact_1_1_south_address_in_bits   	),
	.iact_1_1_south_data_in_ready     	(iact_1_1_south_data_in_ready     	),
	.iact_1_1_south_data_in_valid     	(iact_1_1_south_data_in_valid     	),
	.iact_1_1_south_data_in_bits      	(iact_1_1_south_data_in_bits      	),
	.iact_1_1_horiz_address_in_ready  	(iact_1_1_horiz_address_in_ready  	),
	.iact_1_1_horiz_address_in_valid  	(iact_1_1_horiz_address_in_valid  	),
	.iact_1_1_horiz_address_in_bits   	(iact_1_1_horiz_address_in_bits   	),
	.iact_1_1_horiz_data_in_ready     	(iact_1_1_horiz_data_in_ready     	),
	.iact_1_1_horiz_data_in_valid     	(iact_1_1_horiz_data_in_valid     	),
	.iact_1_1_horiz_data_in_bits      	(iact_1_1_horiz_data_in_bits      	),
	.iact_1_1_PE_address_out_ready    	(iact_1_1_PE_address_out_ready    	),
	.iact_1_1_PE_address_out_bits     	(iact_1_1_PE_address_out_bits     	),
	.iact_1_1_PE_address_out_valid    	(iact_1_1_PE_address_out_valid    	),
	.iact_1_1_PE_data_out_ready       	(iact_1_1_PE_data_out_ready       	),
	.iact_1_1_PE_data_out_valid       	(iact_1_1_PE_data_out_valid       	),
	.iact_1_1_PE_data_out_bits        	(iact_1_1_PE_data_out_bits        	),
	.iact_1_1_north_address_out_ready	(iact_1_1_north_address_out_ready	),
	.iact_1_1_north_address_out_valid 	(iact_1_1_north_address_out_valid 	),
	.iact_1_1_north_address_out_bits  	(iact_1_1_north_address_out_bits  	),
	.iact_1_1_north_data_out_ready		(iact_1_1_north_data_out_ready		),
	.iact_1_1_north_data_out_valid    	(iact_1_1_north_data_out_valid    	),
	.iact_1_1_north_data_out_bits     	(iact_1_1_north_data_out_bits     	),
	.iact_1_1_south_address_out_ready 	(iact_1_1_south_address_out_ready 	),
	.iact_1_1_south_address_out_bits  	(iact_1_1_south_address_out_bits  	),
	.iact_1_1_south_address_out_valid 	(iact_1_1_south_address_out_valid 	),
	.iact_1_1_south_data_out_ready    	(iact_1_1_south_data_out_ready    	),
	.iact_1_1_south_data_out_valid    	(iact_1_1_south_data_out_valid    	),
	.iact_1_1_south_data_out_bits     	(iact_1_1_south_data_out_bits     	),
	.iact_1_1_horiz_address_out_ready 	(iact_1_1_horiz_address_out_ready 	),
	.iact_1_1_horiz_address_out_bits  	(iact_1_1_horiz_address_out_bits  	),
	.iact_1_1_horiz_address_out_valid 	(iact_1_1_horiz_address_out_valid 	),
	.iact_1_1_horiz_data_out_ready    	(iact_1_1_horiz_data_out_ready    	),
	.iact_1_1_horiz_data_out_valid    	(iact_1_1_horiz_data_out_valid    	),
	.iact_1_1_horiz_data_out_bits   	(iact_1_1_horiz_data_out_bits   	),
	.iact_1_2_GLB_address_in_ready    	(iact_1_2_GLB_address_in_ready    	),
	.iact_1_2_GLB_address_in_valid    	(iact_1_2_GLB_address_in_valid    	),
	.iact_1_2_GLB_address_in_bits     	(iact_1_2_GLB_address_in_bits     	),
	.iact_1_2_GLB_data_in_ready       	(iact_1_2_GLB_data_in_ready       	),
	.iact_1_2_GLB_data_in_valid       	(iact_1_2_GLB_data_in_valid       	),
	.iact_1_2_GLB_data_in_bits        	(iact_1_2_GLB_data_in_bits        	),
	.iact_1_2_north_address_in_ready  	(iact_1_2_north_address_in_ready  	),
	.iact_1_2_north_address_in_valid  	(iact_1_2_north_address_in_valid  	),
	.iact_1_2_north_address_in_bits   	(iact_1_2_north_address_in_bits   	),
	.iact_1_2_north_data_in_ready     	(iact_1_2_north_data_in_ready     	),
	.iact_1_2_north_data_in_valid     	(iact_1_2_north_data_in_valid     	),
	.iact_1_2_north_data_in_bits      	(iact_1_2_north_data_in_bits      	),
	.iact_1_2_south_address_in_ready  	(iact_1_2_south_address_in_ready  	),
	.iact_1_2_south_address_in_valid  	(iact_1_2_south_address_in_valid  	),
	.iact_1_2_south_address_in_bits   	(iact_1_2_south_address_in_bits   	),
	.iact_1_2_south_data_in_ready     	(iact_1_2_south_data_in_ready     	),
	.iact_1_2_south_data_in_valid     	(iact_1_2_south_data_in_valid     	),
	.iact_1_2_south_data_in_bits      	(iact_1_2_south_data_in_bits      	),
	.iact_1_2_horiz_address_in_ready  	(iact_1_2_horiz_address_in_ready  	),
	.iact_1_2_horiz_address_in_valid  	(iact_1_2_horiz_address_in_valid  	),
	.iact_1_2_horiz_address_in_bits   	(iact_1_2_horiz_address_in_bits   	),
	.iact_1_2_horiz_data_in_ready     	(iact_1_2_horiz_data_in_ready     	),
	.iact_1_2_horiz_data_in_valid     	(iact_1_2_horiz_data_in_valid     	),
	.iact_1_2_horiz_data_in_bits      	(iact_1_2_horiz_data_in_bits      	),
	.iact_1_2_PE_address_out_ready    	(iact_1_2_PE_address_out_ready    	),
	.iact_1_2_PE_address_out_bits     	(iact_1_2_PE_address_out_bits     	),
	.iact_1_2_PE_address_out_valid    	(iact_1_2_PE_address_out_valid    	),
	.iact_1_2_PE_data_out_ready       	(iact_1_2_PE_data_out_ready       	),
	.iact_1_2_PE_data_out_valid       	(iact_1_2_PE_data_out_valid       	),
	.iact_1_2_PE_data_out_bits        	(iact_1_2_PE_data_out_bits        	),
	.iact_1_2_north_address_out_ready	(iact_1_2_north_address_out_ready	),
	.iact_1_2_north_address_out_valid 	(iact_1_2_north_address_out_valid 	),
	.iact_1_2_north_address_out_bits  	(iact_1_2_north_address_out_bits  	),
	.iact_1_2_north_data_out_ready		(iact_1_2_north_data_out_ready		),
	.iact_1_2_north_data_out_valid    	(iact_1_2_north_data_out_valid    	),
	.iact_1_2_north_data_out_bits     	(iact_1_2_north_data_out_bits     	),
	.iact_1_2_south_address_out_ready 	(iact_1_2_south_address_out_ready 	),
	.iact_1_2_south_address_out_bits  	(iact_1_2_south_address_out_bits  	),
	.iact_1_2_south_address_out_valid 	(iact_1_2_south_address_out_valid 	),
	.iact_1_2_south_data_out_ready    	(iact_1_2_south_data_out_ready    	),
	.iact_1_2_south_data_out_valid    	(iact_1_2_south_data_out_valid    	),
	.iact_1_2_south_data_out_bits     	(iact_1_2_south_data_out_bits     	),
	.iact_1_2_horiz_address_out_ready 	(iact_1_2_horiz_address_out_ready 	),
	.iact_1_2_horiz_address_out_bits  	(iact_1_2_horiz_address_out_bits  	),
	.iact_1_2_horiz_address_out_valid 	(iact_1_2_horiz_address_out_valid 	),
	.iact_1_2_horiz_data_out_ready    	(iact_1_2_horiz_data_out_ready    	),
	.iact_1_2_horiz_data_out_valid    	(iact_1_2_horiz_data_out_valid    	),
	.iact_1_2_horiz_data_out_bits     	(iact_1_2_horiz_data_out_bits     	),
	.iact_2_0_GLB_address_in_ready    	(iact_2_0_GLB_address_in_ready    	),
	.iact_2_0_GLB_address_in_valid    	(iact_2_0_GLB_address_in_valid    	),
	.iact_2_0_GLB_address_in_bits     	(iact_2_0_GLB_address_in_bits     	),
	.iact_2_0_GLB_data_in_ready       	(iact_2_0_GLB_data_in_ready       	),
	.iact_2_0_GLB_data_in_valid       	(iact_2_0_GLB_data_in_valid       	),
	.iact_2_0_GLB_data_in_bits        	(iact_2_0_GLB_data_in_bits        	),
	.iact_2_0_north_address_in_ready  	(iact_2_0_north_address_in_ready  	),
	.iact_2_0_north_address_in_valid  	(iact_2_0_north_address_in_valid  	),
	.iact_2_0_north_address_in_bits   	(iact_2_0_north_address_in_bits   	),
	.iact_2_0_north_data_in_ready     	(iact_2_0_north_data_in_ready     	),
	.iact_2_0_north_data_in_valid     	(iact_2_0_north_data_in_valid     	),
	.iact_2_0_north_data_in_bits      	(iact_2_0_north_data_in_bits      	),
	.iact_2_0_south_address_in_ready  	(iact_2_0_south_address_in_ready  	),
	.iact_2_0_south_address_in_valid  	(iact_2_0_south_address_in_valid  	),
	.iact_2_0_south_address_in_bits   	(iact_2_0_south_address_in_bits   	),
	.iact_2_0_south_data_in_ready     	(iact_2_0_south_data_in_ready     	),
	.iact_2_0_south_data_in_valid     	(iact_2_0_south_data_in_valid     	),
	.iact_2_0_south_data_in_bits      	(iact_2_0_south_data_in_bits      	),
	.iact_2_0_horiz_address_in_ready  	(iact_2_0_horiz_address_in_ready  	),
	.iact_2_0_horiz_address_in_valid  	(iact_2_0_horiz_address_in_valid  	),
	.iact_2_0_horiz_address_in_bits   	(iact_2_0_horiz_address_in_bits   	),
	.iact_2_0_horiz_data_in_ready   	(iact_2_0_horiz_data_in_ready   	),
	.iact_2_0_horiz_data_in_valid     	(iact_2_0_horiz_data_in_valid     	),
	.iact_2_0_horiz_data_in_bits      	(iact_2_0_horiz_data_in_bits      	),
	.iact_2_0_PE_address_out_ready    	(iact_2_0_PE_address_out_ready    	),
	.iact_2_0_PE_address_out_bits     	(iact_2_0_PE_address_out_bits     	),
	.iact_2_0_PE_address_out_valid    	(iact_2_0_PE_address_out_valid    	),
	.iact_2_0_PE_data_out_ready       	(iact_2_0_PE_data_out_ready       	),
	.iact_2_0_PE_data_out_valid       	(iact_2_0_PE_data_out_valid       	),
	.iact_2_0_PE_data_out_bits        	(iact_2_0_PE_data_out_bits        	),
	.iact_2_0_north_address_out_ready	(iact_2_0_north_address_out_ready	),
	.iact_2_0_north_address_out_valid 	(iact_2_0_north_address_out_valid 	),
	.iact_2_0_north_address_out_bits  	(iact_2_0_north_address_out_bits  	),
	.iact_2_0_north_data_out_ready		(iact_2_0_north_data_out_ready		),
	.iact_2_0_north_data_out_valid    	(iact_2_0_north_data_out_valid    	),
	.iact_2_0_north_data_out_bits     	(iact_2_0_north_data_out_bits     	),
	.iact_2_0_south_address_out_ready 	(iact_2_0_south_address_out_ready 	),
	.iact_2_0_south_address_out_bits  	(iact_2_0_south_address_out_bits  	),
	.iact_2_0_south_address_out_valid 	(iact_2_0_south_address_out_valid 	),
	.iact_2_0_south_data_out_ready    	(iact_2_0_south_data_out_ready    	),
	.iact_2_0_south_data_out_valid    	(iact_2_0_south_data_out_valid    	),
	.iact_2_0_south_data_out_bits     	(iact_2_0_south_data_out_bits     	),
	.iact_2_0_horiz_address_out_ready 	(iact_2_0_horiz_address_out_ready 	),
	.iact_2_0_horiz_address_out_bits  	(iact_2_0_horiz_address_out_bits  	),
	.iact_2_0_horiz_address_out_valid 	(iact_2_0_horiz_address_out_valid 	),
	.iact_2_0_horiz_data_out_ready    	(iact_2_0_horiz_data_out_ready    	),
	.iact_2_0_horiz_data_out_valid    	(iact_2_0_horiz_data_out_valid    	),
	.iact_2_0_horiz_data_out_bits  		(iact_2_0_horiz_data_out_bits  		),
	.iact_2_1_GLB_address_in_ready    	(iact_2_1_GLB_address_in_ready    	),
	.iact_2_1_GLB_address_in_valid    	(iact_2_1_GLB_address_in_valid    	),
	.iact_2_1_GLB_address_in_bits     	(iact_2_1_GLB_address_in_bits     	),
	.iact_2_1_GLB_data_in_ready       	(iact_2_1_GLB_data_in_ready       	),
	.iact_2_1_GLB_data_in_valid       	(iact_2_1_GLB_data_in_valid       	),
	.iact_2_1_GLB_data_in_bits        	(iact_2_1_GLB_data_in_bits        	),
	.iact_2_1_north_address_in_ready  	(iact_2_1_north_address_in_ready  	),
	.iact_2_1_north_address_in_valid  	(iact_2_1_north_address_in_valid  	),
	.iact_2_1_north_address_in_bits   	(iact_2_1_north_address_in_bits   	),
	.iact_2_1_north_data_in_ready     	(iact_2_1_north_data_in_ready     	),
	.iact_2_1_north_data_in_valid     	(iact_2_1_north_data_in_valid     	),
	.iact_2_1_north_data_in_bits      	(iact_2_1_north_data_in_bits      	),
	.iact_2_1_south_address_in_ready  	(iact_2_1_south_address_in_ready  	),
	.iact_2_1_south_address_in_valid  	(iact_2_1_south_address_in_valid  	),
	.iact_2_1_south_address_in_bits   	(iact_2_1_south_address_in_bits   	),
	.iact_2_1_south_data_in_ready     	(iact_2_1_south_data_in_ready     	),
	.iact_2_1_south_data_in_valid     	(iact_2_1_south_data_in_valid     	),
	.iact_2_1_south_data_in_bits      	(iact_2_1_south_data_in_bits      	),
	.iact_2_1_horiz_address_in_ready  	(iact_2_1_horiz_address_in_ready  	),
	.iact_2_1_horiz_address_in_valid  	(iact_2_1_horiz_address_in_valid  	),
	.iact_2_1_horiz_address_in_bits   	(iact_2_1_horiz_address_in_bits   	),
	.iact_2_1_horiz_data_in_ready     	(iact_2_1_horiz_data_in_ready     	),
	.iact_2_1_horiz_data_in_valid     	(iact_2_1_horiz_data_in_valid     	),
	.iact_2_1_horiz_data_in_bits      	(iact_2_1_horiz_data_in_bits      	),
	.iact_2_1_PE_address_out_ready    	(iact_2_1_PE_address_out_ready    	),
	.iact_2_1_PE_address_out_bits     	(iact_2_1_PE_address_out_bits     	),
	.iact_2_1_PE_address_out_valid    	(iact_2_1_PE_address_out_valid    	),
	.iact_2_1_PE_data_out_ready       	(iact_2_1_PE_data_out_ready       	),
	.iact_2_1_PE_data_out_valid       	(iact_2_1_PE_data_out_valid       	),
	.iact_2_1_PE_data_out_bits        	(iact_2_1_PE_data_out_bits        	),
	.iact_2_1_north_address_out_ready	(iact_2_1_north_address_out_ready	),
	.iact_2_1_north_address_out_valid 	(iact_2_1_north_address_out_valid 	),
	.iact_2_1_north_address_out_bits  	(iact_2_1_north_address_out_bits  	),
	.iact_2_1_north_data_out_ready		(iact_2_1_north_data_out_ready		),
	.iact_2_1_north_data_out_valid    	(iact_2_1_north_data_out_valid    	),
	.iact_2_1_north_data_out_bits     	(iact_2_1_north_data_out_bits     	),
	.iact_2_1_south_address_out_ready 	(iact_2_1_south_address_out_ready 	),
	.iact_2_1_south_address_out_bits  	(iact_2_1_south_address_out_bits  	),
	.iact_2_1_south_address_out_valid 	(iact_2_1_south_address_out_valid 	),
	.iact_2_1_south_data_out_ready    	(iact_2_1_south_data_out_ready    	),
	.iact_2_1_south_data_out_valid    	(iact_2_1_south_data_out_valid    	),
	.iact_2_1_south_data_out_bits     	(iact_2_1_south_data_out_bits     	),
	.iact_2_1_horiz_address_out_ready 	(iact_2_1_horiz_address_out_ready 	),
	.iact_2_1_horiz_address_out_bits  	(iact_2_1_horiz_address_out_bits  	),
	.iact_2_1_horiz_address_out_valid 	(iact_2_1_horiz_address_out_valid 	),
	.iact_2_1_horiz_data_out_ready    	(iact_2_1_horiz_data_out_ready    	),
	.iact_2_1_horiz_data_out_valid    	(iact_2_1_horiz_data_out_valid    	),
	.iact_2_1_horiz_data_out_bits   	(iact_2_1_horiz_data_out_bits   	),
	.iact_2_2_GLB_address_in_ready    	(iact_2_2_GLB_address_in_ready    	),
	.iact_2_2_GLB_address_in_valid    	(iact_2_2_GLB_address_in_valid    	),
	.iact_2_2_GLB_address_in_bits     	(iact_2_2_GLB_address_in_bits     	),
	.iact_2_2_GLB_data_in_ready       	(iact_2_2_GLB_data_in_ready       	),
	.iact_2_2_GLB_data_in_valid       	(iact_2_2_GLB_data_in_valid       	),
	.iact_2_2_GLB_data_in_bits        	(iact_2_2_GLB_data_in_bits        	),
	.iact_2_2_north_address_in_ready  	(iact_2_2_north_address_in_ready  	),
	.iact_2_2_north_address_in_valid  	(iact_2_2_north_address_in_valid  	),
	.iact_2_2_north_address_in_bits   	(iact_2_2_north_address_in_bits   	),
	.iact_2_2_north_data_in_ready     	(iact_2_2_north_data_in_ready     	),
	.iact_2_2_north_data_in_valid     	(iact_2_2_north_data_in_valid     	),
	.iact_2_2_north_data_in_bits      	(iact_2_2_north_data_in_bits      	),
	.iact_2_2_south_address_in_ready  	(iact_2_2_south_address_in_ready  	),
	.iact_2_2_south_address_in_valid  	(iact_2_2_south_address_in_valid  	),
	.iact_2_2_south_address_in_bits   	(iact_2_2_south_address_in_bits   	),
	.iact_2_2_south_data_in_ready     	(iact_2_2_south_data_in_ready     	),
	.iact_2_2_south_data_in_valid     	(iact_2_2_south_data_in_valid     	),
	.iact_2_2_south_data_in_bits      	(iact_2_2_south_data_in_bits      	),
	.iact_2_2_horiz_address_in_ready  	(iact_2_2_horiz_address_in_ready  	),
	.iact_2_2_horiz_address_in_valid  	(iact_2_2_horiz_address_in_valid  	),
	.iact_2_2_horiz_address_in_bits   	(iact_2_2_horiz_address_in_bits   	),
	.iact_2_2_horiz_data_in_ready     	(iact_2_2_horiz_data_in_ready     	),
	.iact_2_2_horiz_data_in_valid     	(iact_2_2_horiz_data_in_valid     	),
	.iact_2_2_horiz_data_in_bits      	(iact_2_2_horiz_data_in_bits      	),
	.iact_2_2_PE_address_out_ready    	(iact_2_2_PE_address_out_ready    	),
	.iact_2_2_PE_address_out_bits     	(iact_2_2_PE_address_out_bits     	),
	.iact_2_2_PE_address_out_valid    	(iact_2_2_PE_address_out_valid    	),
	.iact_2_2_PE_data_out_ready       	(iact_2_2_PE_data_out_ready       	),
	.iact_2_2_PE_data_out_valid       	(iact_2_2_PE_data_out_valid       	),
	.iact_2_2_PE_data_out_bits        	(iact_2_2_PE_data_out_bits        	),
	.iact_2_2_north_address_out_ready	(iact_2_2_north_address_out_ready	),
	.iact_2_2_north_address_out_valid 	(iact_2_2_north_address_out_valid 	),
	.iact_2_2_north_address_out_bits  	(iact_2_2_north_address_out_bits  	),
	.iact_2_2_north_data_out_ready		(iact_2_2_north_data_out_ready		),
	.iact_2_2_north_data_out_valid    	(iact_2_2_north_data_out_valid    	),
	.iact_2_2_north_data_out_bits     	(iact_2_2_north_data_out_bits     	),
	.iact_2_2_south_address_out_ready 	(iact_2_2_south_address_out_ready 	),
	.iact_2_2_south_address_out_bits  	(iact_2_2_south_address_out_bits  	),
	.iact_2_2_south_address_out_valid 	(iact_2_2_south_address_out_valid 	),
	.iact_2_2_south_data_out_ready    	(iact_2_2_south_data_out_ready    	),
	.iact_2_2_south_data_out_valid    	(iact_2_2_south_data_out_valid    	),
	.iact_2_2_south_data_out_bits     	(iact_2_2_south_data_out_bits     	),
	.iact_2_2_horiz_address_out_ready 	(iact_2_2_horiz_address_out_ready 	),
	.iact_2_2_horiz_address_out_bits  	(iact_2_2_horiz_address_out_bits  	),
	.iact_2_2_horiz_address_out_valid 	(iact_2_2_horiz_address_out_valid 	),
	.iact_2_2_horiz_data_out_ready    	(iact_2_2_horiz_data_out_ready    	),
	.iact_2_2_horiz_data_out_valid    	(iact_2_2_horiz_data_out_valid    	),
	.iact_2_2_horiz_data_out_bits     	(iact_2_2_horiz_data_out_bits     	),
	.weight_0_GLB_address_in_ready  	(weight_0_GLB_address_in_ready  	),
	.weight_0_GLB_address_in_valid  	(weight_0_GLB_address_in_valid  	),
	.weight_0_GLB_address_in_bits   	(weight_0_GLB_address_in_bits   	),
	.weight_0_GLB_data_in_ready     	(weight_0_GLB_data_in_ready     	),
	.weight_0_GLB_data_in_valid     	(weight_0_GLB_data_in_valid     	),
	.weight_0_GLB_data_in_bits      	(weight_0_GLB_data_in_bits      	),
	.weight_0_horiz_address_in_ready	(weight_0_horiz_address_in_ready	),
	.weight_0_horiz_address_in_valid	(weight_0_horiz_address_in_valid	),
	.weight_0_horiz_address_in_bits 	(weight_0_horiz_address_in_bits 	),
	.weight_0_horiz_data_in_ready   	(weight_0_horiz_data_in_ready   	),
	.weight_0_horiz_data_in_valid   	(weight_0_horiz_data_in_valid   	),
	.weight_0_horiz_data_in_bits    	(weight_0_horiz_data_in_bits    	),
	.weight_0_PE_address_out_valid  	(weight_0_PE_address_out_valid  	),
	.weight_0_PE_address_out_bits   	(weight_0_PE_address_out_bits   	),
	.weight_0_PE_data_out_valid     	(weight_0_PE_data_out_valid     	),
	.weight_0_PE_data_out_bits      	(weight_0_PE_data_out_bits      	),
	.weight_0_horiz_address_out_ready 	(weight_0_horiz_address_out_ready 	),
	.weight_0_horiz_address_out_valid 	(weight_0_horiz_address_out_valid 	),
	.weight_0_horiz_address_out_bits  	(weight_0_horiz_address_out_bits  	),
	.weight_0_horiz_data_out_ready    	(weight_0_horiz_data_out_ready    	),
	.weight_0_horiz_data_out_valid    	(weight_0_horiz_data_out_valid    	),
	.weight_0_horiz_data_out_bits     	(weight_0_horiz_data_out_bits     	),
	.weight_1_GLB_address_in_ready    	(weight_1_GLB_address_in_ready    	),
	.weight_1_GLB_address_in_valid    	(weight_1_GLB_address_in_valid    	),
	.weight_1_GLB_address_in_bits     	(weight_1_GLB_address_in_bits     	),
	.weight_1_GLB_data_in_ready       	(weight_1_GLB_data_in_ready       	),
	.weight_1_GLB_data_in_valid       	(weight_1_GLB_data_in_valid       	),
	.weight_1_GLB_data_in_bits        	(weight_1_GLB_data_in_bits        	),
	.weight_1_horiz_address_in_ready  	(weight_1_horiz_address_in_ready  	),
	.weight_1_horiz_address_in_valid  	(weight_1_horiz_address_in_valid  	),
	.weight_1_horiz_address_in_bits   	(weight_1_horiz_address_in_bits   	),
	.weight_1_horiz_data_in_ready     	(weight_1_horiz_data_in_ready     	),
	.weight_1_horiz_data_in_valid     	(weight_1_horiz_data_in_valid     	),
	.weight_1_horiz_data_in_bits      	(weight_1_horiz_data_in_bits      	),
	.weight_1_PE_address_out_valid    	(weight_1_PE_address_out_valid    	),
	.weight_1_PE_address_out_bits     	(weight_1_PE_address_out_bits     	),
	.weight_1_PE_data_out_valid       	(weight_1_PE_data_out_valid       	),
	.weight_1_PE_data_out_bits        	(weight_1_PE_data_out_bits        	),
	.weight_1_horiz_address_out_ready 	(weight_1_horiz_address_out_ready 	),
	.weight_1_horiz_address_out_valid 	(weight_1_horiz_address_out_valid 	),
	.weight_1_horiz_address_out_bits  	(weight_1_horiz_address_out_bits  	),
	.weight_1_horiz_data_out_ready    	(weight_1_horiz_data_out_ready    	),
	.weight_1_horiz_data_out_valid    	(weight_1_horiz_data_out_valid    	),
	.weight_1_horiz_data_out_bits     	(weight_1_horiz_data_out_bits     	),
	.weight_2_GLB_address_in_ready    	(weight_2_GLB_address_in_ready    	),
	.weight_2_GLB_address_in_valid    	(weight_2_GLB_address_in_valid    	),
	.weight_2_GLB_address_in_bits     	(weight_2_GLB_address_in_bits     	),
	.weight_2_GLB_data_in_ready       	(weight_2_GLB_data_in_ready       	),
	.weight_2_GLB_data_in_valid       	(weight_2_GLB_data_in_valid       	),
	.weight_2_GLB_data_in_bits        	(weight_2_GLB_data_in_bits        	),
	.weight_2_horiz_address_in_ready  	(weight_2_horiz_address_in_ready  	),
	.weight_2_horiz_address_in_valid  	(weight_2_horiz_address_in_valid  	),
	.weight_2_horiz_address_in_bits   	(weight_2_horiz_address_in_bits   	),
	.weight_2_horiz_data_in_ready     	(weight_2_horiz_data_in_ready     	),
	.weight_2_horiz_data_in_valid     	(weight_2_horiz_data_in_valid     	),
	.weight_2_horiz_data_in_bits      	(weight_2_horiz_data_in_bits      	),
	.weight_2_PE_address_out_valid    	(weight_2_PE_address_out_valid    	),
	.weight_2_PE_address_out_bits     	(weight_2_PE_address_out_bits     	),
	.weight_2_PE_data_out_valid       	(weight_2_PE_data_out_valid       	),
	.weight_2_PE_data_out_bits        	(weight_2_PE_data_out_bits        	),
	.weight_2_horiz_address_out_ready 	(weight_2_horiz_address_out_ready 	),
	.weight_2_horiz_address_out_valid 	(weight_2_horiz_address_out_valid 	),
	.weight_2_horiz_address_out_bits  	(weight_2_horiz_address_out_bits  	),
	.weight_2_horiz_data_out_ready    	(weight_2_horiz_data_out_ready    	),
	.weight_2_horiz_data_out_valid    	(weight_2_horiz_data_out_valid    	),
	.weight_2_horiz_data_out_bits    	(weight_2_horiz_data_out_bits    	),
	.psum_0_PE_in_ready               	(psum_0_PE_in_ready               	),
	.psum_0_PE_in_valid               	(psum_0_PE_in_valid               	),
	.psum_0_PE_in_bits                	(psum_0_PE_in_bits                	),
	.psum_0_GLB_in_ready              	(psum_0_GLB_in_ready              	),
	.psum_0_GLB_in_valid              	(psum_0_GLB_in_valid              	),
	.psum_0_GLB_in_bits               	(psum_0_GLB_in_bits               	),
	.psum_0_north_in_ready            	(psum_0_north_in_ready            	),
	.psum_0_north_in_valid            	(psum_0_north_in_valid            	),
	.psum_0_north_in_bits             	(psum_0_north_in_bits             	),
	.psum_0_PE_out_ready              	(psum_0_PE_out_ready              	),
	.psum_0_PE_out_valid              	(psum_0_PE_out_valid              	),
	.psum_0_PE_out_bits               	(psum_0_PE_out_bits               	),
	.psum_0_GLB_out_ready             	(psum_0_GLB_out_ready             	),
	.psum_0_GLB_out_valid             	(psum_0_GLB_out_valid             	),
	.psum_0_GLB_out_bits              	(psum_0_GLB_out_bits              	),
	.psum_0_south_out_ready           	(psum_0_south_out_ready           	),
	.psum_0_south_out_valid           	(psum_0_south_out_valid           	),
	.psum_0_south_out_bits       		(psum_0_south_out_bits       		),
	.psum_1_PE_in_ready               	(psum_1_PE_in_ready               	),
	.psum_1_PE_in_valid               	(psum_1_PE_in_valid               	),
	.psum_1_PE_in_bits                	(psum_1_PE_in_bits                	),
	.psum_1_GLB_in_ready              	(psum_1_GLB_in_ready              	),
	.psum_1_GLB_in_valid              	(psum_1_GLB_in_valid              	),
	.psum_1_GLB_in_bits               	(psum_1_GLB_in_bits               	),
	.psum_1_north_in_ready            	(psum_1_north_in_ready            	),
	.psum_1_north_in_valid            	(psum_1_north_in_valid            	),
	.psum_1_north_in_bits             	(psum_1_north_in_bits             	),
	.psum_1_PE_out_ready              	(psum_1_PE_out_ready              	),
	.psum_1_PE_out_valid              	(psum_1_PE_out_valid              	),
	.psum_1_PE_out_bits               	(psum_1_PE_out_bits               	),
	.psum_1_GLB_out_ready             	(psum_1_GLB_out_ready             	),
	.psum_1_GLB_out_valid             	(psum_1_GLB_out_valid             	),
	.psum_1_GLB_out_bits              	(psum_1_GLB_out_bits              	),
	.psum_1_south_out_ready           	(psum_1_south_out_ready           	),
	.psum_1_south_out_valid           	(psum_1_south_out_valid           	),
	.psum_1_south_out_bits         		(psum_1_south_out_bits         		),
	.psum_2_PE_in_ready               	(psum_2_PE_in_ready               	),
	.psum_2_PE_in_valid               	(psum_2_PE_in_valid               	),
	.psum_2_PE_in_bits                	(psum_2_PE_in_bits                	),
	.psum_2_GLB_in_ready              	(psum_2_GLB_in_ready              	),
	.psum_2_GLB_in_valid              	(psum_2_GLB_in_valid              	),
	.psum_2_GLB_in_bits               	(psum_2_GLB_in_bits               	),
	.psum_2_north_in_ready            	(psum_2_north_in_ready            	),
	.psum_2_north_in_valid            	(psum_2_north_in_valid            	),
	.psum_2_north_in_bits             	(psum_2_north_in_bits             	),
	.psum_2_PE_out_ready              	(psum_2_PE_out_ready              	),
	.psum_2_PE_out_valid              	(psum_2_PE_out_valid              	),
	.psum_2_PE_out_bits               	(psum_2_PE_out_bits               	),
	.psum_2_GLB_out_ready             	(psum_2_GLB_out_ready             	),
	.psum_2_GLB_out_valid             	(psum_2_GLB_out_valid             	),
	.psum_2_GLB_out_bits              	(psum_2_GLB_out_bits              	),
	.psum_2_south_out_ready           	(psum_2_south_out_ready           	),
	.psum_2_south_out_valid           	(psum_2_south_out_valid           	),
	.psum_2_south_out_bits       		(psum_2_south_out_bits       		)
);

Cluster_Group_Controller Cluster_Group_Controller ( 
	.clock                 		(cg_ctrl_clock                 	),
	.reset                 		(cg_ctrl_reset                 	),
	.GLB_psum_0_write_en   		(cg_ctrl_GLB_psum_0_write_en   	),
	.GLB_psum_1_write_en   		(cg_ctrl_GLB_psum_1_write_en   	),
	.GLB_psum_2_write_en   		(cg_ctrl_GLB_psum_2_write_en   	),
	.GLB_psum_0_write_done 		(cg_ctrl_GLB_psum_0_write_done 	),
	.GLB_psum_1_write_done 		(cg_ctrl_GLB_psum_1_write_done 	),
	.GLB_psum_2_write_done 		(cg_ctrl_GLB_psum_2_write_done 	),
	.GLB_psum_0_read_en    		(cg_ctrl_GLB_psum_0_read_en    	),
	.GLB_psum_1_read_en    		(cg_ctrl_GLB_psum_1_read_en    	),
	.GLB_psum_2_read_en    		(cg_ctrl_GLB_psum_2_read_en    	),
	.GLB_iact_0_0_write_en   	(cg_ctrl_GLB_iact_0_0_write_en  ),
	.GLB_iact_0_1_write_en   	(cg_ctrl_GLB_iact_0_1_write_en  ),
	.GLB_iact_0_2_write_en   	(cg_ctrl_GLB_iact_0_2_write_en  ),
	.GLB_iact_0_0_write_done 	(cg_ctrl_GLB_iact_0_0_write_done),
	.GLB_iact_0_1_write_done 	(cg_ctrl_GLB_iact_0_1_write_done),
	.GLB_iact_0_2_write_done 	(cg_ctrl_GLB_iact_0_2_write_done),
	.GLB_iact_0_0_read_en    	(cg_ctrl_GLB_iact_0_0_read_en   ),
	.GLB_iact_0_1_read_en    	(cg_ctrl_GLB_iact_0_1_read_en   ),
	.GLB_iact_0_2_read_en    	(cg_ctrl_GLB_iact_0_2_read_en   ),
	.GLB_iact_0_0_read_done  	(cg_ctrl_GLB_iact_0_0_read_done ),
	.GLB_iact_0_1_read_done  	(cg_ctrl_GLB_iact_0_1_read_done ),
	.GLB_iact_0_2_read_done  	(cg_ctrl_GLB_iact_0_2_read_done ),
	.GLB_iact_1_0_write_en   	(cg_ctrl_GLB_iact_1_0_write_en  ),
	.GLB_iact_1_1_write_en   	(cg_ctrl_GLB_iact_1_1_write_en  ),
	.GLB_iact_1_2_write_en   	(cg_ctrl_GLB_iact_1_2_write_en  ),
	.GLB_iact_1_0_write_done 	(cg_ctrl_GLB_iact_1_0_write_done),
	.GLB_iact_1_1_write_done 	(cg_ctrl_GLB_iact_1_1_write_done),
	.GLB_iact_1_2_write_done 	(cg_ctrl_GLB_iact_1_2_write_done),
	.GLB_iact_1_0_read_en    	(cg_ctrl_GLB_iact_1_0_read_en   ),
	.GLB_iact_1_1_read_en    	(cg_ctrl_GLB_iact_1_1_read_en   ),
	.GLB_iact_1_2_read_en    	(cg_ctrl_GLB_iact_1_2_read_en   ),
	.GLB_iact_1_0_read_done  	(cg_ctrl_GLB_iact_1_0_read_done ),
	.GLB_iact_1_1_read_done  	(cg_ctrl_GLB_iact_1_1_read_done ),
	.GLB_iact_1_2_read_done  	(cg_ctrl_GLB_iact_1_2_read_done ),
	.GLB_iact_2_0_write_en   	(cg_ctrl_GLB_iact_2_0_write_en  ),
	.GLB_iact_2_1_write_en   	(cg_ctrl_GLB_iact_2_1_write_en  ),
	.GLB_iact_2_2_write_en   	(cg_ctrl_GLB_iact_2_2_write_en  ),
	.GLB_iact_2_0_write_done 	(cg_ctrl_GLB_iact_2_0_write_done),
	.GLB_iact_2_1_write_done 	(cg_ctrl_GLB_iact_2_1_write_done),
	.GLB_iact_2_2_write_done 	(cg_ctrl_GLB_iact_2_2_write_done),
	.GLB_iact_2_0_read_en    	(cg_ctrl_GLB_iact_2_0_read_en   ),
	.GLB_iact_2_1_read_en    	(cg_ctrl_GLB_iact_2_1_read_en   ),
	.GLB_iact_2_2_read_en    	(cg_ctrl_GLB_iact_2_2_read_en   ),
	.GLB_iact_2_0_read_done  	(cg_ctrl_GLB_iact_2_0_read_done ),
	.GLB_iact_2_1_read_done  	(cg_ctrl_GLB_iact_2_1_read_done ),
	.GLB_iact_2_2_read_done  	(cg_ctrl_GLB_iact_2_2_read_done ),
	.PE_load_en         		(cg_ctrl_PE_load_en          	),
	.psum_load_en       		(cg_ctrl_psum_load_en          	),
	.src_GLB_load_fin			(cg_ctrl_src_GLB_load_fin		),
	.psum_acc_en				(cg_ctrl_psum_acc_en			),
	.psum_add           		(cg_ctrl_psum_add              	),
	.read_psum_en      			(cg_ctrl_read_psum_en     	  	),
	.cg_en             			(cg_ctrl_cg_en            	  	),
	.PE_all_write_fin			(cg_ctrl_PE_all_write_fin	  	),
	.cal_fin           			(cg_ctrl_cal_fin          	  	),
	.idle_wire					(cg_ctrl_idle_wire				),
	.GLB_load_en       			(cg_ctrl_GLB_load_en      	  	),
	.psum_acc_fin				(cg_ctrl_psum_acc_fin			)
);

// psum flow direction
localparam TO_SOU = 1'b0;
localparam TO_PE  = 1'b1;

//=============== TOP output ===============//
assign cal_fin 					= cg_ctrl_cal_fin; 				
assign PE_weight_load_en		= cg_ctrl_PE_load_en; 	
assign GLB_iact_load_en 		= cg_ctrl_GLB_load_en; 	
assign idle_wire				= cg_ctrl_idle_wire;

// GLB iact SRAM Bank output connection
assign GLB_iact_0_0_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_0_0_address_in_ready; 
assign GLB_iact_0_1_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_0_1_address_in_ready; 
assign GLB_iact_0_2_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_0_2_address_in_ready;		
assign GLB_iact_0_0_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_0_0_data_in_ready; 	
assign GLB_iact_0_1_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_0_1_data_in_ready; 
assign GLB_iact_0_2_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_0_2_data_in_ready; 

assign GLB_iact_1_0_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_1_0_address_in_ready; 
assign GLB_iact_1_1_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_1_1_address_in_ready; 
assign GLB_iact_1_2_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_1_2_address_in_ready;		
assign GLB_iact_1_0_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_1_0_data_in_ready; 	
assign GLB_iact_1_1_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_1_1_data_in_ready; 
assign GLB_iact_1_2_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_1_2_data_in_ready; 

assign GLB_iact_2_0_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_2_0_address_in_ready; 
assign GLB_iact_2_1_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_2_1_address_in_ready; 
assign GLB_iact_2_2_address_in_ready 	= GLB_Cluster_iact_SRAM_Bank_2_2_address_in_ready;		
assign GLB_iact_2_0_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_2_0_data_in_ready; 	
assign GLB_iact_2_1_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_2_1_data_in_ready; 
assign GLB_iact_2_2_data_in_ready 		= GLB_Cluster_iact_SRAM_Bank_2_2_data_in_ready; 

// GLB weight SRAM Bank output connection
assign GLB_weight_0_address_in_ready 	= GLB_Cluster_weight_SRAM_Bank_0_address_in_ready; 
assign GLB_weight_1_address_in_ready 	= GLB_Cluster_weight_SRAM_Bank_1_address_in_ready; 	
assign GLB_weight_2_address_in_ready 	= GLB_Cluster_weight_SRAM_Bank_2_address_in_ready; 
assign GLB_weight_0_data_in_ready 		= GLB_Cluster_weight_SRAM_Bank_0_data_in_ready;	
assign GLB_weight_1_data_in_ready 		= GLB_Cluster_weight_SRAM_Bank_1_data_in_ready;	
assign GLB_weight_2_data_in_ready 		= GLB_Cluster_weight_SRAM_Bank_2_data_in_ready;
// GLB psum SRAM Bank output connection
assign GLB_psum_0_data_in_ready 	= (router_cluster_psum_data_out_sel == TO_SOU) ? GLB_Cluster_psum_SRAM_Bank_0_data_in_ready : 1'b0; 
assign GLB_psum_1_data_in_ready 	= (router_cluster_psum_data_out_sel == TO_SOU) ? GLB_Cluster_psum_SRAM_Bank_1_data_in_ready : 1'b0; 
assign GLB_psum_2_data_in_ready 	= (router_cluster_psum_data_out_sel == TO_SOU) ? GLB_Cluster_psum_SRAM_Bank_2_data_in_ready : 1'b0; 

assign GLB_psum_0_data_out_valid 	= GLB_Cluster_psum_SRAM_Bank_0_data_out_valid; // & (read_psum_en | psum_SRAM_Bank_0_read_out_en); 
assign GLB_psum_1_data_out_valid 	= GLB_Cluster_psum_SRAM_Bank_1_data_out_valid; // & (read_psum_en | psum_SRAM_Bank_1_read_out_en); 
assign GLB_psum_2_data_out_valid 	= GLB_Cluster_psum_SRAM_Bank_2_data_out_valid; // & (read_psum_en | psum_SRAM_Bank_2_read_out_en);

assign GLB_psum_0_data_out 			= GLB_Cluster_psum_SRAM_Bank_0_data_out;  
assign GLB_psum_1_data_out 			= GLB_Cluster_psum_SRAM_Bank_1_data_out; 
assign GLB_psum_2_data_out 			= GLB_Cluster_psum_SRAM_Bank_2_data_out; 

// iact router ready connection
assign router_iact_0_0_north_address_in_ready 	= iact_0_0_north_address_in_ready; 	
assign router_iact_0_0_south_address_in_ready 	= iact_0_0_south_address_in_ready; 	
assign router_iact_0_0_horiz_address_in_ready 	= iact_0_0_horiz_address_in_ready; 
assign router_iact_0_1_north_address_in_ready 	= iact_0_1_north_address_in_ready; 
assign router_iact_0_1_south_address_in_ready 	= iact_0_1_south_address_in_ready; 
assign router_iact_0_1_horiz_address_in_ready 	= iact_0_1_horiz_address_in_ready; 
assign router_iact_0_2_north_address_in_ready 	= iact_0_2_north_address_in_ready; 
assign router_iact_0_2_south_address_in_ready 	= iact_0_2_south_address_in_ready; 
assign router_iact_0_2_horiz_address_in_ready 	= iact_0_2_horiz_address_in_ready; 
													   
assign router_iact_0_0_north_data_in_ready 		= iact_0_0_north_data_in_ready; 			
assign router_iact_0_0_south_data_in_ready 		= iact_0_0_south_data_in_ready; 				
assign router_iact_0_0_horiz_data_in_ready 		= iact_0_0_horiz_data_in_ready; 
assign router_iact_0_1_north_data_in_ready 		= iact_0_1_north_data_in_ready;
assign router_iact_0_1_south_data_in_ready 		= iact_0_1_south_data_in_ready;
assign router_iact_0_1_horiz_data_in_ready 		= iact_0_1_horiz_data_in_ready;
assign router_iact_0_2_north_data_in_ready 		= iact_0_2_north_data_in_ready;
assign router_iact_0_2_south_data_in_ready 		= iact_0_2_south_data_in_ready;
assign router_iact_0_2_horiz_data_in_ready 		= iact_0_2_horiz_data_in_ready;

assign router_iact_1_0_north_address_in_ready 	= iact_1_0_north_address_in_ready; 	
assign router_iact_1_0_south_address_in_ready 	= iact_1_0_south_address_in_ready; 	
assign router_iact_1_0_horiz_address_in_ready 	= iact_1_0_horiz_address_in_ready; 
assign router_iact_1_1_north_address_in_ready 	= iact_1_1_north_address_in_ready; 
assign router_iact_1_1_south_address_in_ready 	= iact_1_1_south_address_in_ready; 
assign router_iact_1_1_horiz_address_in_ready 	= iact_1_1_horiz_address_in_ready; 
assign router_iact_1_2_north_address_in_ready 	= iact_1_2_north_address_in_ready; 
assign router_iact_1_2_south_address_in_ready 	= iact_1_2_south_address_in_ready; 
assign router_iact_1_2_horiz_address_in_ready 	= iact_1_2_horiz_address_in_ready; 
											  
assign router_iact_1_0_north_data_in_ready 		= iact_1_0_north_data_in_ready; 			
assign router_iact_1_0_south_data_in_ready 		= iact_1_0_south_data_in_ready; 				
assign router_iact_1_0_horiz_data_in_ready 		= iact_1_0_horiz_data_in_ready; 
assign router_iact_1_1_north_data_in_ready 		= iact_1_1_north_data_in_ready;
assign router_iact_1_1_south_data_in_ready 		= iact_1_1_south_data_in_ready;
assign router_iact_1_1_horiz_data_in_ready 		= iact_1_1_horiz_data_in_ready;
assign router_iact_1_2_north_data_in_ready 		= iact_1_2_north_data_in_ready;
assign router_iact_1_2_south_data_in_ready 		= iact_1_2_south_data_in_ready;
assign router_iact_1_2_horiz_data_in_ready 		= iact_1_2_horiz_data_in_ready;

assign router_iact_2_0_north_address_in_ready 	= iact_2_0_north_address_in_ready; 	
assign router_iact_2_0_south_address_in_ready 	= iact_2_0_south_address_in_ready; 	
assign router_iact_2_0_horiz_address_in_ready 	= iact_2_0_horiz_address_in_ready; 
assign router_iact_2_1_north_address_in_ready 	= iact_2_1_north_address_in_ready; 
assign router_iact_2_1_south_address_in_ready 	= iact_2_1_south_address_in_ready; 
assign router_iact_2_1_horiz_address_in_ready 	= iact_2_1_horiz_address_in_ready; 
assign router_iact_2_2_north_address_in_ready 	= iact_2_2_north_address_in_ready; 
assign router_iact_2_2_south_address_in_ready 	= iact_2_2_south_address_in_ready; 
assign router_iact_2_2_horiz_address_in_ready 	= iact_2_2_horiz_address_in_ready; 
											   
assign router_iact_2_0_north_data_in_ready 		= iact_2_0_north_data_in_ready; 			
assign router_iact_2_0_south_data_in_ready 		= iact_2_0_south_data_in_ready; 				
assign router_iact_2_0_horiz_data_in_ready 		= iact_2_0_horiz_data_in_ready; 
assign router_iact_2_1_north_data_in_ready 		= iact_2_1_north_data_in_ready;
assign router_iact_2_1_south_data_in_ready 		= iact_2_1_south_data_in_ready;
assign router_iact_2_1_horiz_data_in_ready 		= iact_2_1_horiz_data_in_ready;
assign router_iact_2_2_north_data_in_ready 		= iact_2_2_north_data_in_ready;
assign router_iact_2_2_south_data_in_ready 		= iact_2_2_south_data_in_ready;
assign router_iact_2_2_horiz_data_in_ready 		= iact_2_2_horiz_data_in_ready;

// iact router valid connection
assign router_iact_0_0_north_address_out_valid 	= iact_0_0_north_address_out_valid; 
assign router_iact_0_0_south_address_out_valid 	= iact_0_0_south_address_out_valid; 
assign router_iact_0_0_horiz_address_out_valid 	= iact_0_0_horiz_address_out_valid; 
assign router_iact_0_1_north_address_out_valid 	= iact_0_1_north_address_out_valid; 
assign router_iact_0_1_south_address_out_valid 	= iact_0_1_south_address_out_valid; 
assign router_iact_0_1_horiz_address_out_valid 	= iact_0_1_horiz_address_out_valid; 
assign router_iact_0_2_north_address_out_valid 	= iact_0_2_north_address_out_valid; 
assign router_iact_0_2_south_address_out_valid 	= iact_0_2_south_address_out_valid; 
assign router_iact_0_2_horiz_address_out_valid 	= iact_0_2_horiz_address_out_valid; 
													   
assign router_iact_0_0_north_data_out_valid 	= iact_0_0_north_data_out_valid;
assign router_iact_0_0_south_data_out_valid 	= iact_0_0_south_data_out_valid;
assign router_iact_0_0_horiz_data_out_valid 	= iact_0_0_horiz_data_out_valid;
assign router_iact_0_1_north_data_out_valid 	= iact_0_1_north_data_out_valid; 
assign router_iact_0_1_south_data_out_valid 	= iact_0_1_south_data_out_valid; 
assign router_iact_0_1_horiz_data_out_valid 	= iact_0_1_horiz_data_out_valid; 
assign router_iact_0_2_north_data_out_valid 	= iact_0_2_north_data_out_valid;
assign router_iact_0_2_south_data_out_valid 	= iact_0_2_south_data_out_valid;
assign router_iact_0_2_horiz_data_out_valid 	= iact_0_2_horiz_data_out_valid;

assign router_iact_1_0_north_address_out_valid 	= iact_1_0_north_address_out_valid; 
assign router_iact_1_0_south_address_out_valid 	= iact_1_0_south_address_out_valid; 
assign router_iact_1_0_horiz_address_out_valid 	= iact_1_0_horiz_address_out_valid; 
assign router_iact_1_1_north_address_out_valid 	= iact_1_1_north_address_out_valid; 
assign router_iact_1_1_south_address_out_valid 	= iact_1_1_south_address_out_valid; 
assign router_iact_1_1_horiz_address_out_valid 	= iact_1_1_horiz_address_out_valid; 
assign router_iact_1_2_north_address_out_valid 	= iact_1_2_north_address_out_valid; 
assign router_iact_1_2_south_address_out_valid 	= iact_1_2_south_address_out_valid; 
assign router_iact_1_2_horiz_address_out_valid 	= iact_1_2_horiz_address_out_valid; 
												  
assign router_iact_1_0_north_data_out_valid 	= iact_1_0_north_data_out_valid;
assign router_iact_1_0_south_data_out_valid 	= iact_1_0_south_data_out_valid;
assign router_iact_1_0_horiz_data_out_valid 	= iact_1_0_horiz_data_out_valid;
assign router_iact_1_1_north_data_out_valid 	= iact_1_1_north_data_out_valid; 
assign router_iact_1_1_south_data_out_valid 	= iact_1_1_south_data_out_valid; 
assign router_iact_1_1_horiz_data_out_valid 	= iact_1_1_horiz_data_out_valid; 
assign router_iact_1_2_north_data_out_valid 	= iact_1_2_north_data_out_valid;
assign router_iact_1_2_south_data_out_valid 	= iact_1_2_south_data_out_valid;
assign router_iact_1_2_horiz_data_out_valid 	= iact_1_2_horiz_data_out_valid;

assign router_iact_2_0_north_address_out_valid 	= iact_2_0_north_address_out_valid; 
assign router_iact_2_0_south_address_out_valid 	= iact_2_0_south_address_out_valid; 
assign router_iact_2_0_horiz_address_out_valid 	= iact_2_0_horiz_address_out_valid; 
assign router_iact_2_1_north_address_out_valid 	= iact_2_1_north_address_out_valid; 
assign router_iact_2_1_south_address_out_valid 	= iact_2_1_south_address_out_valid; 
assign router_iact_2_1_horiz_address_out_valid 	= iact_2_1_horiz_address_out_valid; 
assign router_iact_2_2_north_address_out_valid 	= iact_2_2_north_address_out_valid; 
assign router_iact_2_2_south_address_out_valid 	= iact_2_2_south_address_out_valid; 
assign router_iact_2_2_horiz_address_out_valid 	= iact_2_2_horiz_address_out_valid; 
											   
assign router_iact_2_0_north_data_out_valid 	= iact_2_0_north_data_out_valid;
assign router_iact_2_0_south_data_out_valid 	= iact_2_0_south_data_out_valid;
assign router_iact_2_0_horiz_data_out_valid 	= iact_2_0_horiz_data_out_valid;
assign router_iact_2_1_north_data_out_valid 	= iact_2_1_north_data_out_valid; 
assign router_iact_2_1_south_data_out_valid 	= iact_2_1_south_data_out_valid; 
assign router_iact_2_1_horiz_data_out_valid 	= iact_2_1_horiz_data_out_valid; 
assign router_iact_2_2_north_data_out_valid 	= iact_2_2_north_data_out_valid;
assign router_iact_2_2_south_data_out_valid 	= iact_2_2_south_data_out_valid;
assign router_iact_2_2_horiz_data_out_valid 	= iact_2_2_horiz_data_out_valid;


// iact router data connection
assign router_iact_0_0_north_address_out 	= iact_0_0_north_address_out_bits; 
assign router_iact_0_0_south_address_out 	= iact_0_0_south_address_out_bits;
assign router_iact_0_0_horiz_address_out 	= iact_0_0_horiz_address_out_bits; 
assign router_iact_0_1_north_address_out 	= iact_0_1_north_address_out_bits; 
assign router_iact_0_1_south_address_out 	= iact_0_1_south_address_out_bits; 
assign router_iact_0_1_horiz_address_out 	= iact_0_1_horiz_address_out_bits; 
assign router_iact_0_2_north_address_out 	= iact_0_2_north_address_out_bits; 
assign router_iact_0_2_south_address_out 	= iact_0_2_south_address_out_bits; 
assign router_iact_0_2_horiz_address_out 	= iact_0_2_horiz_address_out_bits; 
												   
assign router_iact_0_0_north_data_out 		= iact_0_0_north_data_out_bits;  
assign router_iact_0_0_south_data_out 		= iact_0_0_south_data_out_bits; 
assign router_iact_0_0_horiz_data_out 		= iact_0_0_horiz_data_out_bits; 
assign router_iact_0_1_north_data_out 		= iact_0_1_north_data_out_bits; 
assign router_iact_0_1_south_data_out 		= iact_0_1_south_data_out_bits; 
assign router_iact_0_1_horiz_data_out 		= iact_0_1_horiz_data_out_bits; 
assign router_iact_0_2_north_data_out 		= iact_0_2_north_data_out_bits; 
assign router_iact_0_2_south_data_out 		= iact_0_2_south_data_out_bits; 
assign router_iact_0_2_horiz_data_out 		= iact_0_2_horiz_data_out_bits; 

assign router_iact_1_0_north_address_out 	= iact_1_0_north_address_out_bits; 
assign router_iact_1_0_south_address_out 	= iact_1_0_south_address_out_bits;
assign router_iact_1_0_horiz_address_out 	= iact_1_0_horiz_address_out_bits; 
assign router_iact_1_1_north_address_out 	= iact_1_1_north_address_out_bits; 
assign router_iact_1_1_south_address_out 	= iact_1_1_south_address_out_bits; 
assign router_iact_1_1_horiz_address_out 	= iact_1_1_horiz_address_out_bits; 
assign router_iact_1_2_north_address_out 	= iact_1_2_north_address_out_bits; 
assign router_iact_1_2_south_address_out 	= iact_1_2_south_address_out_bits; 
assign router_iact_1_2_horiz_address_out 	= iact_1_2_horiz_address_out_bits; 
											  
assign router_iact_1_0_north_data_out 		= iact_1_0_north_data_out_bits;  
assign router_iact_1_0_south_data_out 		= iact_1_0_south_data_out_bits; 
assign router_iact_1_0_horiz_data_out 		= iact_1_0_horiz_data_out_bits; 
assign router_iact_1_1_north_data_out 		= iact_1_1_north_data_out_bits; 
assign router_iact_1_1_south_data_out 		= iact_1_1_south_data_out_bits; 
assign router_iact_1_1_horiz_data_out 		= iact_1_1_horiz_data_out_bits; 
assign router_iact_1_2_north_data_out 		= iact_1_2_north_data_out_bits; 
assign router_iact_1_2_south_data_out 		= iact_1_2_south_data_out_bits; 
assign router_iact_1_2_horiz_data_out 		= iact_1_2_horiz_data_out_bits; 

assign router_iact_2_0_north_address_out 	= iact_2_0_north_address_out_bits; 
assign router_iact_2_0_south_address_out 	= iact_2_0_south_address_out_bits;
assign router_iact_2_0_horiz_address_out 	= iact_2_0_horiz_address_out_bits; 
assign router_iact_2_1_north_address_out 	= iact_2_1_north_address_out_bits; 
assign router_iact_2_1_south_address_out 	= iact_2_1_south_address_out_bits; 
assign router_iact_2_1_horiz_address_out 	= iact_2_1_horiz_address_out_bits; 
assign router_iact_2_2_north_address_out 	= iact_2_2_north_address_out_bits; 
assign router_iact_2_2_south_address_out 	= iact_2_2_south_address_out_bits; 
assign router_iact_2_2_horiz_address_out 	= iact_2_2_horiz_address_out_bits; 
		
assign router_iact_2_0_north_data_out 		= iact_2_0_north_data_out_bits;  
assign router_iact_2_0_south_data_out 		= iact_2_0_south_data_out_bits; 
assign router_iact_2_0_horiz_data_out 		= iact_2_0_horiz_data_out_bits; 
assign router_iact_2_1_north_data_out 		= iact_2_1_north_data_out_bits; 
assign router_iact_2_1_south_data_out 		= iact_2_1_south_data_out_bits; 
assign router_iact_2_1_horiz_data_out 		= iact_2_1_horiz_data_out_bits; 
assign router_iact_2_2_north_data_out 		= iact_2_2_north_data_out_bits; 
assign router_iact_2_2_south_data_out 		= iact_2_2_south_data_out_bits; 
assign router_iact_2_2_horiz_data_out 		= iact_2_2_horiz_data_out_bits; 

// weight router ready connection
assign router_weight_0_horiz_address_in_ready = weight_0_horiz_address_in_ready; 
assign router_weight_1_horiz_address_in_ready = weight_1_horiz_address_in_ready; 
assign router_weight_2_horiz_address_in_ready = weight_2_horiz_address_in_ready; 

assign router_weight_0_horiz_data_in_ready = weight_0_horiz_data_in_ready;
assign router_weight_1_horiz_data_in_ready = weight_1_horiz_data_in_ready; 
assign router_weight_2_horiz_data_in_ready = weight_2_horiz_data_in_ready; 

// weight router valid connection
assign router_weight_0_horiz_address_out_valid 	= weight_0_horiz_address_out_valid; 
assign router_weight_1_horiz_address_out_valid 	= weight_1_horiz_address_out_valid; 
assign router_weight_2_horiz_address_out_valid 	= weight_2_horiz_address_out_valid; 
assign router_weight_0_horiz_data_out_valid		= weight_0_horiz_data_out_valid;
assign router_weight_1_horiz_data_out_valid		= weight_1_horiz_data_out_valid;
assign router_weight_2_horiz_data_out_valid		= weight_2_horiz_data_out_valid;

// weight router data connection
assign router_weight_0_horiz_address_out 	= weight_0_horiz_address_out_bits; 
assign router_weight_1_horiz_address_out 	= weight_1_horiz_address_out_bits; 
assign router_weight_2_horiz_address_out 	= weight_2_horiz_address_out_bits; 
assign router_weight_0_horiz_data_out 		= weight_0_horiz_data_out_bits; 
assign router_weight_1_horiz_data_out 		= weight_1_horiz_data_out_bits; 
assign router_weight_2_horiz_data_out 		= weight_2_horiz_data_out_bits; 

// psum router ready connection
assign router_psum_0_north_in_ready = psum_0_north_in_ready; 
assign router_psum_1_north_in_ready = psum_1_north_in_ready; 
assign router_psum_2_north_in_ready = psum_2_north_in_ready; 	

// psum router valid connection
assign router_psum_0_south_out_valid = psum_0_south_out_valid; 
assign router_psum_1_south_out_valid = psum_1_south_out_valid;
assign router_psum_2_south_out_valid = psum_2_south_out_valid; 

// psum router data connection
assign router_psum_0_south_out = psum_0_south_out_bits; 	
assign router_psum_1_south_out = psum_1_south_out_bits; 	
assign router_psum_2_south_out = psum_2_south_out_bits;	 

// interconnect with vertical cluster group
assign cg_south_psum_0_in_ready = PE_Cluster_psum_0_in_from_south_ready; 
assign cg_south_psum_1_in_ready = PE_Cluster_psum_1_in_from_south_ready; 
assign cg_south_psum_2_in_ready = PE_Cluster_psum_2_in_from_south_ready; 

assign cg_north_psum_0_out_valid = PE_Cluster_psum_0_out_valid; 
assign cg_north_psum_1_out_valid = PE_Cluster_psum_1_out_valid; 	
assign cg_north_psum_2_out_valid = PE_Cluster_psum_2_out_valid;

assign cg_north_psum_0_out = PE_Cluster_psum_0_out; 			
assign cg_north_psum_1_out = PE_Cluster_psum_1_out; 			
assign cg_north_psum_2_out = PE_Cluster_psum_2_out; 			

//=============== intra-connection ===============//
// router cluster to PE cluster
assign PE_Cluster_clock 							= clock;
assign PE_Cluster_reset 							= reset;
assign PE_Cluster_weight_0_0_address_in_valid 	= iact_0_0_PE_address_out_valid; 	
assign PE_Cluster_weight_0_1_address_in_valid 	= iact_0_1_PE_address_out_valid;
assign PE_Cluster_weight_0_2_address_in_valid 	= iact_0_2_PE_address_out_valid; 
assign PE_Cluster_weight_0_0_address_in 			= iact_0_0_PE_address_out_bits; 
assign PE_Cluster_weight_0_1_address_in 			= iact_0_1_PE_address_out_bits; 
assign PE_Cluster_weight_0_2_address_in 			= iact_0_2_PE_address_out_bits; 	
assign PE_Cluster_weight_0_0_data_in_valid 		= iact_0_0_PE_data_out_valid;	
assign PE_Cluster_weight_0_1_data_in_valid 		= iact_0_1_PE_data_out_valid;		
assign PE_Cluster_weight_0_2_data_in_valid 		= iact_0_2_PE_data_out_valid;
assign PE_Cluster_weight_0_0_data_in 			= iact_0_0_PE_data_out_bits; 	
assign PE_Cluster_weight_0_1_data_in 			= iact_0_1_PE_data_out_bits; 	
assign PE_Cluster_weight_0_2_data_in 			= iact_0_2_PE_data_out_bits;	
assign PE_Cluster_weight_1_0_address_in_valid 	= iact_1_0_PE_address_out_valid; 	
assign PE_Cluster_weight_1_1_address_in_valid 	= iact_1_1_PE_address_out_valid;
assign PE_Cluster_weight_1_2_address_in_valid 	= iact_1_2_PE_address_out_valid; 
assign PE_Cluster_weight_1_0_address_in 			= iact_1_0_PE_address_out_bits; 
assign PE_Cluster_weight_1_1_address_in 			= iact_1_1_PE_address_out_bits; 
assign PE_Cluster_weight_1_2_address_in 			= iact_1_2_PE_address_out_bits; 	
assign PE_Cluster_weight_1_0_data_in_valid 		= iact_1_0_PE_data_out_valid;	
assign PE_Cluster_weight_1_1_data_in_valid 		= iact_1_1_PE_data_out_valid;		
assign PE_Cluster_weight_1_2_data_in_valid 		= iact_1_2_PE_data_out_valid;
assign PE_Cluster_weight_1_0_data_in 			= iact_1_0_PE_data_out_bits; 	
assign PE_Cluster_weight_1_1_data_in 			= iact_1_1_PE_data_out_bits; 	
assign PE_Cluster_weight_1_2_data_in 			= iact_1_2_PE_data_out_bits;
assign PE_Cluster_weight_2_0_address_in_valid 	= iact_2_0_PE_address_out_valid; 	
assign PE_Cluster_weight_2_1_address_in_valid 	= iact_2_1_PE_address_out_valid;
assign PE_Cluster_weight_2_2_address_in_valid 	= iact_2_2_PE_address_out_valid; 
assign PE_Cluster_weight_2_0_address_in 			= iact_2_0_PE_address_out_bits; 
assign PE_Cluster_weight_2_1_address_in 			= iact_2_1_PE_address_out_bits; 
assign PE_Cluster_weight_2_2_address_in 			= iact_2_2_PE_address_out_bits; 	
assign PE_Cluster_weight_2_0_data_in_valid 		= iact_2_0_PE_data_out_valid;	
assign PE_Cluster_weight_2_1_data_in_valid 		= iact_2_1_PE_data_out_valid;		
assign PE_Cluster_weight_2_2_data_in_valid 		= iact_2_2_PE_data_out_valid;
assign PE_Cluster_weight_2_0_data_in 			= iact_2_0_PE_data_out_bits; 	
assign PE_Cluster_weight_2_1_data_in 			= iact_2_1_PE_data_out_bits; 	
assign PE_Cluster_weight_2_2_data_in 			= iact_2_2_PE_data_out_bits;		

assign PE_Cluster_iact_0_address_in_valid 		= weight_0_PE_address_out_valid; 
assign PE_Cluster_iact_1_address_in_valid 		= weight_1_PE_address_out_valid; 
assign PE_Cluster_iact_2_address_in_valid 		= weight_2_PE_address_out_valid;
assign PE_Cluster_iact_0_address_in 				= weight_0_PE_address_out_bits;		
assign PE_Cluster_iact_1_address_in 				= weight_1_PE_address_out_bits;	
assign PE_Cluster_iact_2_address_in 				= weight_2_PE_address_out_bits; 
assign PE_Cluster_iact_0_data_in_valid 			= weight_0_PE_data_out_valid; 	 		
assign PE_Cluster_iact_1_data_in_valid 			= weight_1_PE_data_out_valid; 		
assign PE_Cluster_iact_2_data_in_valid 			= weight_2_PE_data_out_valid; 
assign PE_Cluster_iact_0_data_in 				= weight_0_PE_data_out_bits;  
assign PE_Cluster_iact_1_data_in 				= weight_1_PE_data_out_bits; 	
assign PE_Cluster_iact_2_data_in 				= weight_2_PE_data_out_bits; 

assign PE_Cluster_psum_0_in_valid 				= psum_0_PE_out_valid; 
assign PE_Cluster_psum_1_in_valid 				= psum_1_PE_out_valid; 
assign PE_Cluster_psum_2_in_valid 				= psum_2_PE_out_valid; 
assign PE_Cluster_psum_0_in 						= psum_0_PE_out_bits; 
assign PE_Cluster_psum_1_in 						= psum_1_PE_out_bits; 
assign PE_Cluster_psum_2_in 						= psum_2_PE_out_bits; 
assign PE_Cluster_psum_0_out_ready 				= psum_0_PE_in_ready; 
assign PE_Cluster_psum_1_out_ready 				= psum_1_PE_in_ready; 
assign PE_Cluster_psum_2_out_ready 				= psum_2_PE_in_ready; 

// psum accumulate from south cluster group
assign PE_Cluster_psum_0_in_from_south_valid 	= cg_south_psum_0_in_valid; 
assign PE_Cluster_psum_1_in_from_south_valid 	= cg_south_psum_1_in_valid; 
assign PE_Cluster_psum_2_in_from_south_valid 	= cg_south_psum_2_in_valid; 
assign PE_Cluster_psum_0_in_from_south 			= cg_south_psum_0_in; 	
assign PE_Cluster_psum_1_in_from_south 			= cg_south_psum_1_in; 	
assign PE_Cluster_psum_2_in_from_south 			= cg_south_psum_2_in; 	

assign PE_Cluster_PE_0_0_disable					= PE_0_0_disable;
assign PE_Cluster_PE_0_1_disable					= PE_0_1_disable;
assign PE_Cluster_PE_0_2_disable					= PE_0_2_disable;
assign PE_Cluster_PE_1_0_disable					= PE_1_0_disable;
assign PE_Cluster_PE_1_1_disable					= PE_1_1_disable;
assign PE_Cluster_PE_1_2_disable					= PE_1_2_disable;
assign PE_Cluster_PE_2_0_disable					= PE_2_0_disable;
assign PE_Cluster_PE_2_1_disable					= PE_2_1_disable;
assign PE_Cluster_PE_2_2_disable					= PE_2_2_disable;

assign PE_Cluster_psum_load_en 					= cg_ctrl_psum_load_en; 
assign PE_Cluster_iact_data_in_sel 				= PE_cluster_iact_data_in_sel;
assign PE_Cluster_iact_data_out_sel 				= PE_cluster_iact_data_out_sel; 
assign PE_Cluster_psum_data_in_sel 				= PE_cluster_psum_data_in_sel; 
assign PE_Cluster_do_en 							= cg_ctrl_PE_load_en; 

assign PE_Cluster_iact_write_fin_clear 			= iact_write_fin_clear;
assign PE_Cluster_weight_write_fin_clear 		= weight_write_fin_clear;

// TOP iact and weight fetch and dataflow control
assign GLB_Cluster_clock = clock;
assign GLB_Cluster_reset = reset;
assign GLB_Cluster_iact_SRAM_Bank_0_0_address_in_valid  	= GLB_iact_0_0_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_address_in_valid  	= GLB_iact_0_1_address_in_valid;
assign GLB_Cluster_iact_SRAM_Bank_0_2_address_in_valid  	= GLB_iact_0_2_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_0_0_address_in 		= GLB_iact_0_0_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_address_in 		= GLB_iact_0_1_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_address_in 		= GLB_iact_0_2_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_0_0_data_in_valid 	 	= GLB_iact_0_0_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_data_in_valid 	 	= GLB_iact_0_1_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_data_in_valid 	 	= GLB_iact_0_2_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_0_0_data_in 			= GLB_iact_0_0_data_in;
assign GLB_Cluster_iact_SRAM_Bank_0_1_data_in 			= GLB_iact_0_1_data_in; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_data_in 			= GLB_iact_0_2_data_in; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_address_in_valid  	= GLB_iact_1_0_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_address_in_valid  	= GLB_iact_1_1_address_in_valid;
assign GLB_Cluster_iact_SRAM_Bank_1_2_address_in_valid  	= GLB_iact_1_2_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_address_in 		= GLB_iact_1_0_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_address_in 		= GLB_iact_1_1_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_address_in 		= GLB_iact_1_2_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_data_in_valid 	 	= GLB_iact_1_0_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_data_in_valid 	 	= GLB_iact_1_1_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_data_in_valid 	 	= GLB_iact_1_2_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_data_in 			= GLB_iact_1_0_data_in;
assign GLB_Cluster_iact_SRAM_Bank_1_1_data_in 			= GLB_iact_1_1_data_in; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_data_in 			= GLB_iact_1_2_data_in; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_address_in_valid  	= GLB_iact_2_0_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_address_in_valid  	= GLB_iact_2_1_address_in_valid;
assign GLB_Cluster_iact_SRAM_Bank_2_2_address_in_valid  	= GLB_iact_2_2_address_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_address_in 		= GLB_iact_2_0_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_address_in 		= GLB_iact_2_1_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_address_in 		= GLB_iact_2_2_address_in; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_data_in_valid 	 	= GLB_iact_2_0_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_data_in_valid 	 	= GLB_iact_2_1_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_data_in_valid 	 	= GLB_iact_2_2_data_in_valid; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_data_in 			= GLB_iact_2_0_data_in;
assign GLB_Cluster_iact_SRAM_Bank_2_1_data_in 			= GLB_iact_2_1_data_in; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_data_in 			= GLB_iact_2_2_data_in; 

assign GLB_Cluster_weight_SRAM_Bank_0_address_in_valid  	= GLB_weight_0_address_in_valid; 
assign GLB_Cluster_weight_SRAM_Bank_1_address_in_valid  	= GLB_weight_1_address_in_valid; 
assign GLB_Cluster_weight_SRAM_Bank_2_address_in_valid  	= GLB_weight_2_address_in_valid; 
assign GLB_Cluster_weight_SRAM_Bank_0_address_in 		= GLB_weight_0_address_in;
assign GLB_Cluster_weight_SRAM_Bank_1_address_in 		= GLB_weight_1_address_in; 
assign GLB_Cluster_weight_SRAM_Bank_2_address_in 		= GLB_weight_2_address_in; 
assign GLB_Cluster_weight_SRAM_Bank_0_data_in_valid 	 	= GLB_weight_0_data_in_valid;
assign GLB_Cluster_weight_SRAM_Bank_1_data_in_valid 	 	= GLB_weight_1_data_in_valid; 
assign GLB_Cluster_weight_SRAM_Bank_2_data_in_valid 	 	= GLB_weight_2_data_in_valid; 
assign GLB_Cluster_weight_SRAM_Bank_0_data_in			= GLB_weight_0_data_in; 
assign GLB_Cluster_weight_SRAM_Bank_1_data_in			= GLB_weight_1_data_in; 
assign GLB_Cluster_weight_SRAM_Bank_2_data_in			= GLB_weight_2_data_in; 

assign iact_0_data_in_sel  = router_cluster_iact_data_in_sel; 
assign iact_1_data_in_sel  = router_cluster_iact_data_in_sel; 
assign iact_2_data_in_sel  = router_cluster_iact_data_in_sel; 
assign iact_0_data_out_sel = router_cluster_iact_data_out_sel;
assign iact_1_data_out_sel = router_cluster_iact_data_out_sel;
assign iact_2_data_out_sel = router_cluster_iact_data_out_sel;

assign weight_0_data_in_sel  = router_cluster_weight_data_in_sel; 
assign weight_1_data_in_sel  = router_cluster_weight_data_in_sel; 
assign weight_2_data_in_sel  = router_cluster_weight_data_in_sel; 
assign weight_0_data_out_sel = router_cluster_weight_data_out_sel; 
assign weight_1_data_out_sel = router_cluster_weight_data_out_sel; 
assign weight_2_data_out_sel = router_cluster_weight_data_out_sel; 

assign psum_0_data_in_sel  = router_cluster_psum_data_in_sel; 	
assign psum_1_data_in_sel  = router_cluster_psum_data_in_sel; 	
assign psum_2_data_in_sel  = router_cluster_psum_data_in_sel; 	
assign psum_0_data_out_sel = router_cluster_psum_data_out_sel; 
assign psum_1_data_out_sel = router_cluster_psum_data_out_sel; 
assign psum_2_data_out_sel = router_cluster_psum_data_out_sel; 

// GLB cluster to router cluster
assign GLB_Cluster_iact_SRAM_Bank_0_0_address_out_ready 	= iact_0_0_GLB_address_in_ready;
assign GLB_Cluster_iact_SRAM_Bank_0_1_address_out_ready 	= iact_0_1_GLB_address_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_address_out_ready 	= iact_0_2_GLB_address_in_ready;  
assign GLB_Cluster_iact_SRAM_Bank_0_0_data_out_ready 	= iact_0_0_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_data_out_ready 	= iact_0_1_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_data_out_ready 	= iact_0_2_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_address_out_ready 	= iact_1_0_GLB_address_in_ready;
assign GLB_Cluster_iact_SRAM_Bank_1_1_address_out_ready 	= iact_1_1_GLB_address_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_address_out_ready 	= iact_1_2_GLB_address_in_ready;  
assign GLB_Cluster_iact_SRAM_Bank_1_0_data_out_ready 	= iact_1_0_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_data_out_ready 	= iact_1_1_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_data_out_ready 	= iact_1_2_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_address_out_ready 	= iact_2_0_GLB_address_in_ready;
assign GLB_Cluster_iact_SRAM_Bank_2_1_address_out_ready 	= iact_2_1_GLB_address_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_address_out_ready 	= iact_2_2_GLB_address_in_ready;  
assign GLB_Cluster_iact_SRAM_Bank_2_0_data_out_ready 	= iact_2_0_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_data_out_ready 	= iact_2_1_GLB_data_in_ready; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_data_out_ready 	= iact_2_2_GLB_data_in_ready; 

assign GLB_Cluster_weight_SRAM_Bank_0_address_out_ready 	= weight_0_GLB_address_in_ready; 
assign GLB_Cluster_weight_SRAM_Bank_1_address_out_ready 	= weight_1_GLB_address_in_ready; 
assign GLB_Cluster_weight_SRAM_Bank_2_address_out_ready 	= weight_2_GLB_address_in_ready; 
assign GLB_Cluster_weight_SRAM_Bank_0_data_out_ready 	= weight_0_GLB_data_in_ready;
assign GLB_Cluster_weight_SRAM_Bank_1_data_out_ready 	= weight_1_GLB_data_in_ready;
assign GLB_Cluster_weight_SRAM_Bank_2_data_out_ready 	= weight_2_GLB_data_in_ready;

// psum 
assign GLB_Cluster_psum_SRAM_Bank_0_data_in_valid  = psum_0_GLB_out_valid; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_0_GLB_out_valid : GLB_psum_0_data_in_valid;
assign GLB_Cluster_psum_SRAM_Bank_1_data_in_valid  = psum_1_GLB_out_valid; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_1_GLB_out_valid : GLB_psum_1_data_in_valid;
assign GLB_Cluster_psum_SRAM_Bank_2_data_in_valid  = psum_2_GLB_out_valid; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_2_GLB_out_valid : GLB_psum_2_data_in_valid;
assign GLB_Cluster_psum_SRAM_Bank_0_data_in 		  = psum_0_GLB_out_bits; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_0_GLB_out_bits  : GLB_psum_0_data_in; 
assign GLB_Cluster_psum_SRAM_Bank_1_data_in 		  = psum_1_GLB_out_bits; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_1_GLB_out_bits  : GLB_psum_1_data_in; 
assign GLB_Cluster_psum_SRAM_Bank_2_data_in 		  = psum_2_GLB_out_bits; // (router_cluster_psum_data_out_sel == TO_PE) ? psum_2_GLB_out_bits  : GLB_psum_2_data_in; 

assign GLB_Cluster_psum_SRAM_Bank_0_data_out_ready = (psum_0_GLB_in_ready & cg_ctrl_psum_add) | (GLB_psum_0_data_out_ready & (read_psum_en | psum_SRAM_Bank_0_read_out_en)); 
assign GLB_Cluster_psum_SRAM_Bank_1_data_out_ready = (psum_1_GLB_in_ready & cg_ctrl_psum_add) | (GLB_psum_1_data_out_ready & (read_psum_en | psum_SRAM_Bank_1_read_out_en)); 
assign GLB_Cluster_psum_SRAM_Bank_2_data_out_ready = (psum_2_GLB_in_ready & cg_ctrl_psum_add) | (GLB_psum_2_data_out_ready & (read_psum_en | psum_SRAM_Bank_2_read_out_en)); 

// cluster group control
assign GLB_Cluster_iact_SRAM_Bank_0_0_write_en	= cg_ctrl_GLB_iact_0_0_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_write_en	= cg_ctrl_GLB_iact_0_1_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_write_en	= cg_ctrl_GLB_iact_0_2_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_read_en 	= cg_ctrl_GLB_iact_0_1_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_0_0_read_en 	= cg_ctrl_GLB_iact_0_0_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_0_2_read_en 	= cg_ctrl_GLB_iact_0_2_read_en;  
assign GLB_Cluster_iact_SRAM_Bank_1_0_write_en	= cg_ctrl_GLB_iact_1_0_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_write_en	= cg_ctrl_GLB_iact_1_1_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_write_en	= cg_ctrl_GLB_iact_1_2_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_read_en 	= cg_ctrl_GLB_iact_1_1_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_1_0_read_en 	= cg_ctrl_GLB_iact_1_0_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_1_2_read_en 	= cg_ctrl_GLB_iact_1_2_read_en;   
assign GLB_Cluster_iact_SRAM_Bank_2_0_write_en	= cg_ctrl_GLB_iact_2_0_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_write_en	= cg_ctrl_GLB_iact_2_1_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_write_en	= cg_ctrl_GLB_iact_2_2_write_en; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_read_en 	= cg_ctrl_GLB_iact_2_1_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_2_0_read_en 	= cg_ctrl_GLB_iact_2_0_read_en; 
assign GLB_Cluster_iact_SRAM_Bank_2_2_read_en 	= cg_ctrl_GLB_iact_2_2_read_en;   

assign GLB_Cluster_psum_SRAM_Bank_0_write_en 	= cg_ctrl_GLB_psum_0_write_en & GLB_psum_write_en; 
assign GLB_Cluster_psum_SRAM_Bank_1_write_en 	= cg_ctrl_GLB_psum_1_write_en & GLB_psum_write_en; 
assign GLB_Cluster_psum_SRAM_Bank_2_write_en 	= cg_ctrl_GLB_psum_2_write_en & GLB_psum_write_en;  
assign GLB_Cluster_psum_SRAM_Bank_0_read_en		= cg_ctrl_GLB_psum_0_read_en; 
assign GLB_Cluster_psum_SRAM_Bank_1_read_en		= cg_ctrl_GLB_psum_1_read_en;   
assign GLB_Cluster_psum_SRAM_Bank_2_read_en		= cg_ctrl_GLB_psum_2_read_en; 
assign GLB_Cluster_psum_SRAM_Bank_0_read_out_en	= psum_SRAM_Bank_0_read_out_en;
assign GLB_Cluster_psum_SRAM_Bank_1_read_out_en	= psum_SRAM_Bank_1_read_out_en;
assign GLB_Cluster_psum_SRAM_Bank_2_read_out_en	= psum_SRAM_Bank_2_read_out_en;


assign GLB_Cluster_iact_SRAM_Bank_0_0_read_addr	= GLB_iact_0_0_read_addr; 
assign GLB_Cluster_iact_SRAM_Bank_0_1_read_addr	= GLB_iact_0_1_read_addr;
assign GLB_Cluster_iact_SRAM_Bank_0_2_read_addr	= GLB_iact_0_2_read_addr;
assign GLB_Cluster_iact_SRAM_Bank_1_0_read_addr	= GLB_iact_1_0_read_addr; 
assign GLB_Cluster_iact_SRAM_Bank_1_1_read_addr	= GLB_iact_1_1_read_addr;
assign GLB_Cluster_iact_SRAM_Bank_1_2_read_addr	= GLB_iact_1_2_read_addr;
assign GLB_Cluster_iact_SRAM_Bank_2_0_read_addr	= GLB_iact_2_0_read_addr; 
assign GLB_Cluster_iact_SRAM_Bank_2_1_read_addr	= GLB_iact_2_1_read_addr;
assign GLB_Cluster_iact_SRAM_Bank_2_2_read_addr	= GLB_iact_2_2_read_addr;

assign GLB_Cluster_psum_SRAM_Bank_0_read_addr	= GLB_psum_0_read_addr; 
assign GLB_Cluster_psum_SRAM_Bank_1_read_addr	= GLB_psum_1_read_addr; 
assign GLB_Cluster_psum_SRAM_Bank_2_read_addr	= GLB_psum_2_read_addr;  
assign GLB_Cluster_psum_SRAM_Bank_0_write_addr	= GLB_psum_0_write_addr; 
assign GLB_Cluster_psum_SRAM_Bank_1_write_addr	= GLB_psum_1_write_addr; 
assign GLB_Cluster_psum_SRAM_Bank_2_write_addr	= GLB_psum_2_write_addr; 

//============= other cluster group inter-connection =============//
// iact_ready
assign iact_0_0_PE_address_out_ready    	= PE_Cluster_iact_0_address_in_ready;     	// PE_Cluster_weight_0_0_address_in_ready;
assign iact_0_2_PE_address_out_ready 	  	= PE_Cluster_iact_0_address_in_ready;     	// PE_Cluster_weight_0_2_address_in_ready; 
assign iact_0_1_PE_address_out_ready 	 	= PE_Cluster_iact_0_address_in_ready; 	   	// PE_Cluster_weight_0_1_address_in_ready; 	
assign iact_1_0_PE_address_out_ready    	= PE_Cluster_iact_1_address_in_ready;
assign iact_1_2_PE_address_out_ready 	  	= PE_Cluster_iact_1_address_in_ready;
assign iact_1_1_PE_address_out_ready 	 	= PE_Cluster_iact_1_address_in_ready;
assign iact_2_0_PE_address_out_ready    	= PE_Cluster_iact_2_address_in_ready;
assign iact_2_2_PE_address_out_ready 	  	= PE_Cluster_iact_2_address_in_ready;
assign iact_2_1_PE_address_out_ready 	 	= PE_Cluster_iact_2_address_in_ready;

assign iact_0_0_north_address_out_ready 	= router_iact_0_0_north_address_out_ready; 	
assign iact_0_1_north_address_out_ready 	= router_iact_0_1_north_address_out_ready; 
assign iact_0_2_north_address_out_ready 	= router_iact_0_2_north_address_out_ready; 
assign iact_0_0_south_address_out_ready 	= router_iact_0_0_south_address_out_ready; 	
assign iact_0_1_south_address_out_ready 	= router_iact_0_1_south_address_out_ready; 
assign iact_0_2_south_address_out_ready 	= router_iact_0_2_south_address_out_ready; 
assign iact_0_0_horiz_address_out_ready 	= router_iact_0_0_horiz_address_out_ready; 	
assign iact_0_1_horiz_address_out_ready 	= router_iact_0_1_horiz_address_out_ready; 
assign iact_0_2_horiz_address_out_ready 	= router_iact_0_2_horiz_address_out_ready; 
assign iact_1_0_north_address_out_ready 	= router_iact_1_0_north_address_out_ready; 	
assign iact_1_1_north_address_out_ready 	= router_iact_1_1_north_address_out_ready; 
assign iact_1_2_north_address_out_ready 	= router_iact_1_2_north_address_out_ready; 
assign iact_1_0_south_address_out_ready 	= router_iact_1_0_south_address_out_ready; 	
assign iact_1_1_south_address_out_ready 	= router_iact_1_1_south_address_out_ready; 
assign iact_1_2_south_address_out_ready 	= router_iact_1_2_south_address_out_ready; 
assign iact_1_0_horiz_address_out_ready 	= router_iact_1_0_horiz_address_out_ready; 	
assign iact_1_1_horiz_address_out_ready 	= router_iact_1_1_horiz_address_out_ready; 
assign iact_1_2_horiz_address_out_ready 	= router_iact_1_2_horiz_address_out_ready; 
assign iact_2_0_north_address_out_ready 	= router_iact_2_0_north_address_out_ready; 	
assign iact_2_1_north_address_out_ready 	= router_iact_2_1_north_address_out_ready; 
assign iact_2_2_north_address_out_ready 	= router_iact_2_2_north_address_out_ready; 
assign iact_2_0_south_address_out_ready 	= router_iact_2_0_south_address_out_ready; 	
assign iact_2_1_south_address_out_ready 	= router_iact_2_1_south_address_out_ready; 
assign iact_2_2_south_address_out_ready 	= router_iact_2_2_south_address_out_ready; 
assign iact_2_0_horiz_address_out_ready 	= router_iact_2_0_horiz_address_out_ready; 	
assign iact_2_1_horiz_address_out_ready 	= router_iact_2_1_horiz_address_out_ready; 
assign iact_2_2_horiz_address_out_ready 	= router_iact_2_2_horiz_address_out_ready; 

assign iact_0_0_PE_data_out_ready    		= PE_Cluster_iact_0_data_in_ready; 	 	// PE_Cluster_weight_0_0_data_in_ready; 
assign iact_0_1_PE_data_out_ready 			= PE_Cluster_iact_0_data_in_ready;      	// PE_Cluster_weight_0_1_data_in_ready; 
assign iact_0_2_PE_data_out_ready 			= PE_Cluster_iact_0_data_in_ready;      	// PE_Cluster_weight_0_2_data_in_ready; 
assign iact_1_0_PE_data_out_ready    		= PE_Cluster_iact_1_data_in_ready;
assign iact_1_1_PE_data_out_ready 			= PE_Cluster_iact_1_data_in_ready;
assign iact_1_2_PE_data_out_ready 			= PE_Cluster_iact_1_data_in_ready;
assign iact_2_0_PE_data_out_ready    		= PE_Cluster_iact_2_data_in_ready;
assign iact_2_1_PE_data_out_ready 			= PE_Cluster_iact_2_data_in_ready;
assign iact_2_2_PE_data_out_ready 			= PE_Cluster_iact_2_data_in_ready;

assign iact_0_0_north_data_out_ready 		= router_iact_0_0_north_data_out_ready; 	
assign iact_0_1_north_data_out_ready 		= router_iact_0_1_north_data_out_ready; 
assign iact_0_2_north_data_out_ready 		= router_iact_0_2_north_data_out_ready; 
assign iact_0_0_south_data_out_ready 		= router_iact_0_0_south_data_out_ready; 
assign iact_0_1_south_data_out_ready 		= router_iact_0_1_south_data_out_ready; 
assign iact_0_2_south_data_out_ready 		= router_iact_0_2_south_data_out_ready; 
assign iact_0_0_horiz_data_out_ready 		= router_iact_0_0_horiz_data_out_ready; 
assign iact_0_1_horiz_data_out_ready 		= router_iact_0_1_horiz_data_out_ready; 
assign iact_0_2_horiz_data_out_ready 		= router_iact_0_2_horiz_data_out_ready; 
assign iact_1_0_north_data_out_ready 		= router_iact_1_0_north_data_out_ready; 	
assign iact_1_1_north_data_out_ready 		= router_iact_1_1_north_data_out_ready; 
assign iact_1_2_north_data_out_ready 		= router_iact_1_2_north_data_out_ready; 
assign iact_1_0_south_data_out_ready 		= router_iact_1_0_south_data_out_ready; 
assign iact_1_1_south_data_out_ready 		= router_iact_1_1_south_data_out_ready; 
assign iact_1_2_south_data_out_ready 		= router_iact_1_2_south_data_out_ready; 
assign iact_1_0_horiz_data_out_ready 		= router_iact_1_0_horiz_data_out_ready; 
assign iact_1_1_horiz_data_out_ready 		= router_iact_1_1_horiz_data_out_ready; 
assign iact_1_2_horiz_data_out_ready 		= router_iact_1_2_horiz_data_out_ready;
assign iact_2_0_north_data_out_ready 		= router_iact_2_0_north_data_out_ready; 	
assign iact_2_1_north_data_out_ready 		= router_iact_2_1_north_data_out_ready; 
assign iact_2_2_north_data_out_ready 		= router_iact_2_2_north_data_out_ready; 
assign iact_2_0_south_data_out_ready 		= router_iact_2_0_south_data_out_ready; 
assign iact_2_1_south_data_out_ready 		= router_iact_2_1_south_data_out_ready; 
assign iact_2_2_south_data_out_ready 		= router_iact_2_2_south_data_out_ready; 
assign iact_2_0_horiz_data_out_ready 		= router_iact_2_0_horiz_data_out_ready; 
assign iact_2_1_horiz_data_out_ready 		= router_iact_2_1_horiz_data_out_ready; 
assign iact_2_2_horiz_data_out_ready 		= router_iact_2_2_horiz_data_out_ready;

// iact_valid
assign iact_0_0_GLB_address_in_valid   	= GLB_Cluster_iact_SRAM_Bank_0_0_address_out_valid; 
assign iact_0_1_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_0_1_address_out_valid;
assign iact_0_2_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_0_2_address_out_valid; 
assign iact_0_0_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_0_0_data_out_valid; 	
assign iact_0_1_GLB_data_in_valid 		= GLB_Cluster_iact_SRAM_Bank_0_1_data_out_valid; 
assign iact_0_2_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_0_2_data_out_valid; 
assign iact_1_0_GLB_address_in_valid   	= GLB_Cluster_iact_SRAM_Bank_1_0_address_out_valid; 
assign iact_1_1_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_1_1_address_out_valid;
assign iact_1_2_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_1_2_address_out_valid; 
assign iact_1_0_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_1_0_data_out_valid; 	
assign iact_1_1_GLB_data_in_valid 		= GLB_Cluster_iact_SRAM_Bank_1_1_data_out_valid; 
assign iact_1_2_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_1_2_data_out_valid; 
assign iact_2_0_GLB_address_in_valid   	= GLB_Cluster_iact_SRAM_Bank_2_0_address_out_valid; 
assign iact_2_1_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_2_1_address_out_valid;
assign iact_2_2_GLB_address_in_valid 	= GLB_Cluster_iact_SRAM_Bank_2_2_address_out_valid; 
assign iact_2_0_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_2_0_data_out_valid; 	
assign iact_2_1_GLB_data_in_valid 		= GLB_Cluster_iact_SRAM_Bank_2_1_data_out_valid; 
assign iact_2_2_GLB_data_in_valid   	= GLB_Cluster_iact_SRAM_Bank_2_2_data_out_valid; 

assign iact_0_0_north_address_in_valid 	= router_iact_0_0_north_address_in_valid; 
assign iact_0_1_north_address_in_valid 	= router_iact_0_1_north_address_in_valid; 
assign iact_0_2_north_address_in_valid 	= router_iact_0_2_north_address_in_valid;	
assign iact_0_0_south_address_in_valid 	= router_iact_0_0_south_address_in_valid;
assign iact_0_1_south_address_in_valid 	= router_iact_0_1_south_address_in_valid; 	
assign iact_0_2_south_address_in_valid 	= router_iact_0_2_south_address_in_valid;
assign iact_0_0_horiz_address_in_valid 	= router_iact_0_0_horiz_address_in_valid;
assign iact_0_1_horiz_address_in_valid 	= router_iact_0_1_horiz_address_in_valid;
assign iact_0_2_horiz_address_in_valid 	= router_iact_0_2_horiz_address_in_valid;
assign iact_0_0_north_data_in_valid 	= router_iact_0_0_north_data_in_valid; 	
assign iact_0_1_north_data_in_valid 	= router_iact_0_1_north_data_in_valid;	
assign iact_0_2_north_data_in_valid 	= router_iact_0_2_north_data_in_valid; 
assign iact_0_0_south_data_in_valid 	= router_iact_0_0_south_data_in_valid; 
assign iact_0_1_south_data_in_valid 	= router_iact_0_1_south_data_in_valid; 	
assign iact_0_2_south_data_in_valid 	= router_iact_0_2_south_data_in_valid; 
assign iact_0_0_horiz_data_in_valid 	= router_iact_0_0_horiz_data_in_valid; 
assign iact_0_1_horiz_data_in_valid 	= router_iact_0_1_horiz_data_in_valid; 
assign iact_0_2_horiz_data_in_valid 	= router_iact_0_2_horiz_data_in_valid; 
assign iact_1_0_north_address_in_valid 	= router_iact_1_0_north_address_in_valid; 
assign iact_1_1_north_address_in_valid 	= router_iact_1_1_north_address_in_valid; 
assign iact_1_2_north_address_in_valid 	= router_iact_1_2_north_address_in_valid;	
assign iact_1_0_south_address_in_valid 	= router_iact_1_0_south_address_in_valid;
assign iact_1_1_south_address_in_valid 	= router_iact_1_1_south_address_in_valid; 	
assign iact_1_2_south_address_in_valid 	= router_iact_1_2_south_address_in_valid;
assign iact_1_0_horiz_address_in_valid 	= router_iact_1_0_horiz_address_in_valid;
assign iact_1_1_horiz_address_in_valid 	= router_iact_1_1_horiz_address_in_valid;
assign iact_1_2_horiz_address_in_valid 	= router_iact_1_2_horiz_address_in_valid;
assign iact_1_0_north_data_in_valid 	= router_iact_1_0_north_data_in_valid; 	
assign iact_1_1_north_data_in_valid 	= router_iact_1_1_north_data_in_valid;	
assign iact_1_2_north_data_in_valid 	= router_iact_1_2_north_data_in_valid; 
assign iact_1_0_south_data_in_valid 	= router_iact_1_0_south_data_in_valid; 
assign iact_1_1_south_data_in_valid 	= router_iact_1_1_south_data_in_valid; 	
assign iact_1_2_south_data_in_valid 	= router_iact_1_2_south_data_in_valid; 
assign iact_1_0_horiz_data_in_valid 	= router_iact_1_0_horiz_data_in_valid; 
assign iact_1_1_horiz_data_in_valid 	= router_iact_1_1_horiz_data_in_valid; 
assign iact_1_2_horiz_data_in_valid 	= router_iact_1_2_horiz_data_in_valid;
assign iact_2_0_north_address_in_valid 	= router_iact_2_0_north_address_in_valid; 
assign iact_2_1_north_address_in_valid 	= router_iact_2_1_north_address_in_valid; 
assign iact_2_2_north_address_in_valid 	= router_iact_2_2_north_address_in_valid;	
assign iact_2_0_south_address_in_valid 	= router_iact_2_0_south_address_in_valid;
assign iact_2_1_south_address_in_valid 	= router_iact_2_1_south_address_in_valid; 	
assign iact_2_2_south_address_in_valid 	= router_iact_2_2_south_address_in_valid;
assign iact_2_0_horiz_address_in_valid 	= router_iact_2_0_horiz_address_in_valid;
assign iact_2_1_horiz_address_in_valid 	= router_iact_2_1_horiz_address_in_valid;
assign iact_2_2_horiz_address_in_valid 	= router_iact_2_2_horiz_address_in_valid;
assign iact_2_0_north_data_in_valid 	= router_iact_2_0_north_data_in_valid; 	
assign iact_2_1_north_data_in_valid 	= router_iact_2_1_north_data_in_valid;	
assign iact_2_2_north_data_in_valid 	= router_iact_2_2_north_data_in_valid; 
assign iact_2_0_south_data_in_valid 	= router_iact_2_0_south_data_in_valid; 
assign iact_2_1_south_data_in_valid 	= router_iact_2_1_south_data_in_valid; 	
assign iact_2_2_south_data_in_valid 	= router_iact_2_2_south_data_in_valid; 
assign iact_2_0_horiz_data_in_valid 	= router_iact_2_0_horiz_data_in_valid; 
assign iact_2_1_horiz_data_in_valid 	= router_iact_2_1_horiz_data_in_valid; 
assign iact_2_2_horiz_data_in_valid 	= router_iact_2_2_horiz_data_in_valid;

// iact_data
assign iact_0_0_GLB_address_in_bits   	= GLB_Cluster_iact_SRAM_Bank_0_0_address_out; 
assign iact_0_1_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_0_1_address_out; 	
assign iact_0_2_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_0_2_address_out; 
assign iact_0_0_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_0_0_data_out; 
assign iact_0_1_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_0_1_data_out; 
assign iact_0_2_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_0_2_data_out; 
assign iact_1_0_GLB_address_in_bits   	= GLB_Cluster_iact_SRAM_Bank_1_0_address_out; 
assign iact_1_1_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_1_1_address_out; 	
assign iact_1_2_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_1_2_address_out; 
assign iact_1_0_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_1_0_data_out; 
assign iact_1_1_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_1_1_data_out; 
assign iact_1_2_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_1_2_data_out; 
assign iact_2_0_GLB_address_in_bits   	= GLB_Cluster_iact_SRAM_Bank_2_0_address_out; 
assign iact_2_1_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_2_1_address_out; 	
assign iact_2_2_GLB_address_in_bits 	= GLB_Cluster_iact_SRAM_Bank_2_2_address_out; 
assign iact_2_0_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_2_0_data_out; 
assign iact_2_1_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_2_1_data_out; 
assign iact_2_2_GLB_data_in_bits 	 	= GLB_Cluster_iact_SRAM_Bank_2_2_data_out; 

assign iact_0_0_north_address_in_bits 	= router_iact_0_0_north_address_in; 
assign iact_0_1_north_address_in_bits 	= router_iact_0_1_north_address_in; 
assign iact_0_2_north_address_in_bits 	= router_iact_0_2_north_address_in;
assign iact_0_0_south_address_in_bits 	= router_iact_0_0_south_address_in; 
assign iact_0_1_south_address_in_bits 	= router_iact_0_1_south_address_in;
assign iact_0_2_south_address_in_bits 	= router_iact_0_2_south_address_in; 
assign iact_0_0_horiz_address_in_bits 	= router_iact_0_0_horiz_address_in; 	
assign iact_0_1_horiz_address_in_bits 	= router_iact_0_1_horiz_address_in; 
assign iact_0_2_horiz_address_in_bits 	= router_iact_0_2_horiz_address_in;
assign iact_0_0_north_data_in_bits 		= router_iact_0_0_north_data_in; 	
assign iact_0_1_north_data_in_bits 		= router_iact_0_1_north_data_in; 	
assign iact_0_2_north_data_in_bits 		= router_iact_0_2_north_data_in; 	
assign iact_0_0_south_data_in_bits 		= router_iact_0_0_south_data_in; 	 
assign iact_0_1_south_data_in_bits 		= router_iact_0_1_south_data_in; 	
assign iact_0_2_south_data_in_bits 		= router_iact_0_2_south_data_in;		
assign iact_0_0_horiz_data_in_bits 		= router_iact_0_0_horiz_data_in; 
assign iact_0_1_horiz_data_in_bits 		= router_iact_0_1_horiz_data_in;
assign iact_0_2_horiz_data_in_bits 		= router_iact_0_2_horiz_data_in;
assign iact_1_0_north_address_in_bits 	= router_iact_1_0_north_address_in; 
assign iact_1_1_north_address_in_bits 	= router_iact_1_1_north_address_in; 
assign iact_1_2_north_address_in_bits 	= router_iact_1_2_north_address_in;
assign iact_1_0_south_address_in_bits 	= router_iact_1_0_south_address_in; 
assign iact_1_1_south_address_in_bits 	= router_iact_1_1_south_address_in;
assign iact_1_2_south_address_in_bits 	= router_iact_1_2_south_address_in; 
assign iact_1_0_horiz_address_in_bits 	= router_iact_1_0_horiz_address_in; 	
assign iact_1_1_horiz_address_in_bits 	= router_iact_1_1_horiz_address_in; 
assign iact_1_2_horiz_address_in_bits 	= router_iact_1_2_horiz_address_in;
assign iact_1_0_north_data_in_bits 		= router_iact_1_0_north_data_in; 	
assign iact_1_1_north_data_in_bits 		= router_iact_1_1_north_data_in; 	
assign iact_1_2_north_data_in_bits 		= router_iact_1_2_north_data_in; 	
assign iact_1_0_south_data_in_bits 		= router_iact_1_0_south_data_in; 	 
assign iact_1_1_south_data_in_bits 		= router_iact_1_1_south_data_in; 	
assign iact_1_2_south_data_in_bits 		= router_iact_1_2_south_data_in;		
assign iact_1_0_horiz_data_in_bits 		= router_iact_1_0_horiz_data_in; 
assign iact_1_1_horiz_data_in_bits 		= router_iact_1_1_horiz_data_in;
assign iact_1_2_horiz_data_in_bits 		= router_iact_1_2_horiz_data_in;
assign iact_2_0_north_address_in_bits 	= router_iact_2_0_north_address_in; 
assign iact_2_1_north_address_in_bits 	= router_iact_2_1_north_address_in; 
assign iact_2_2_north_address_in_bits 	= router_iact_2_2_north_address_in;
assign iact_2_0_south_address_in_bits 	= router_iact_2_0_south_address_in; 
assign iact_2_1_south_address_in_bits 	= router_iact_2_1_south_address_in;
assign iact_2_2_south_address_in_bits 	= router_iact_2_2_south_address_in; 
assign iact_2_0_horiz_address_in_bits 	= router_iact_2_0_horiz_address_in; 	
assign iact_2_1_horiz_address_in_bits 	= router_iact_2_1_horiz_address_in; 
assign iact_2_2_horiz_address_in_bits 	= router_iact_2_2_horiz_address_in;
assign iact_2_0_north_data_in_bits 		= router_iact_2_0_north_data_in; 	
assign iact_2_1_north_data_in_bits 		= router_iact_2_1_north_data_in; 	
assign iact_2_2_north_data_in_bits 		= router_iact_2_2_north_data_in; 	
assign iact_2_0_south_data_in_bits 		= router_iact_2_0_south_data_in; 	 
assign iact_2_1_south_data_in_bits 		= router_iact_2_1_south_data_in; 	
assign iact_2_2_south_data_in_bits 		= router_iact_2_2_south_data_in;		
assign iact_2_0_horiz_data_in_bits 		= router_iact_2_0_horiz_data_in; 
assign iact_2_1_horiz_data_in_bits 		= router_iact_2_1_horiz_data_in;
assign iact_2_2_horiz_data_in_bits 		= router_iact_2_2_horiz_data_in;


// weight_ready (weight GLBs are just like weight router)
assign weight_0_horiz_address_out_ready = router_weight_0_horiz_address_out_ready; 
assign weight_1_horiz_address_out_ready = router_weight_1_horiz_address_out_ready;
assign weight_2_horiz_address_out_ready = router_weight_2_horiz_address_out_ready; 
assign weight_0_horiz_data_out_ready 	= router_weight_0_horiz_data_out_ready; 
assign weight_1_horiz_data_out_ready 	= router_weight_1_horiz_data_out_ready; 
assign weight_2_horiz_data_out_ready 	= router_weight_2_horiz_data_out_ready; 

// weight_valid
assign weight_0_GLB_address_in_valid 	= GLB_Cluster_weight_SRAM_Bank_0_address_out_valid; 
assign weight_1_GLB_address_in_valid 	= GLB_Cluster_weight_SRAM_Bank_1_address_out_valid; 
assign weight_2_GLB_address_in_valid 	= GLB_Cluster_weight_SRAM_Bank_2_address_out_valid; 
assign weight_0_horiz_address_in_valid 	= router_weight_0_horiz_address_in_valid;
assign weight_1_horiz_address_in_valid 	= router_weight_1_horiz_address_in_valid;
assign weight_2_horiz_address_in_valid 	= router_weight_2_horiz_address_in_valid;

assign weight_0_GLB_data_in_valid 		= GLB_Cluster_weight_SRAM_Bank_0_data_out_valid;
assign weight_1_GLB_data_in_valid 		= GLB_Cluster_weight_SRAM_Bank_1_data_out_valid;
assign weight_2_GLB_data_in_valid 		= GLB_Cluster_weight_SRAM_Bank_2_data_out_valid;
assign weight_0_horiz_data_in_valid 	= router_weight_0_horiz_data_in_valid; 
assign weight_1_horiz_data_in_valid 	= router_weight_1_horiz_data_in_valid;
assign weight_2_horiz_data_in_valid 	= router_weight_2_horiz_data_in_valid; 

// weight_data
assign weight_0_GLB_address_in_bits 	= GLB_Cluster_weight_SRAM_Bank_0_address_out;
assign weight_1_GLB_address_in_bits 	= GLB_Cluster_weight_SRAM_Bank_1_address_out; 
assign weight_2_GLB_address_in_bits 	= GLB_Cluster_weight_SRAM_Bank_2_address_out;
assign weight_0_horiz_address_in_bits 	= router_weight_0_horiz_address_in; 
assign weight_1_horiz_address_in_bits 	= router_weight_1_horiz_address_in; 
assign weight_2_horiz_address_in_bits 	= router_weight_2_horiz_address_in; 

assign weight_0_GLB_data_in_bits 		= GLB_Cluster_weight_SRAM_Bank_0_data_out; 
assign weight_1_GLB_data_in_bits 		= GLB_Cluster_weight_SRAM_Bank_1_data_out; 
assign weight_2_GLB_data_in_bits 		= GLB_Cluster_weight_SRAM_Bank_2_data_out; 
assign weight_0_horiz_data_in_bits 		= router_weight_0_horiz_data_in;
assign weight_1_horiz_data_in_bits 		= router_weight_1_horiz_data_in;
assign weight_2_horiz_data_in_bits 		= router_weight_2_horiz_data_in;

// psum router inter-connection
assign psum_0_PE_out_ready 		= PE_Cluster_psum_0_in_ready; 
assign psum_1_PE_out_ready 		= PE_Cluster_psum_1_in_ready; 
assign psum_2_PE_out_ready 		= PE_Cluster_psum_2_in_ready;  	
assign psum_0_GLB_out_ready 	= router_cluster_psum_data_out_sel & GLB_Cluster_psum_SRAM_Bank_0_data_in_ready; 
assign psum_1_GLB_out_ready 	= router_cluster_psum_data_out_sel & GLB_Cluster_psum_SRAM_Bank_1_data_in_ready;
assign psum_2_GLB_out_ready 	= router_cluster_psum_data_out_sel & GLB_Cluster_psum_SRAM_Bank_2_data_in_ready;
assign psum_0_south_out_ready 	= router_psum_0_south_out_ready; 
assign psum_1_south_out_ready 	= router_psum_1_south_out_ready; 
assign psum_2_south_out_ready 	= router_psum_2_south_out_ready; 

assign psum_0_PE_in_valid 		= PE_Cluster_psum_0_out_valid; 
assign psum_1_PE_in_valid 		= PE_Cluster_psum_1_out_valid; 
assign psum_2_PE_in_valid 		= PE_Cluster_psum_2_out_valid; 
assign psum_0_GLB_in_valid 		= GLB_Cluster_psum_SRAM_Bank_0_data_out_valid & cg_ctrl_psum_add; 	
assign psum_1_GLB_in_valid 		= GLB_Cluster_psum_SRAM_Bank_1_data_out_valid & cg_ctrl_psum_add; 
assign psum_2_GLB_in_valid 		= GLB_Cluster_psum_SRAM_Bank_2_data_out_valid & cg_ctrl_psum_add; 
assign psum_0_north_in_valid 	= router_psum_0_north_in_valid; 
assign psum_1_north_in_valid 	= router_psum_1_north_in_valid; 
assign psum_2_north_in_valid 	= router_psum_2_north_in_valid;

assign psum_0_PE_in_bits 		= PE_Cluster_psum_0_out; 
assign psum_1_PE_in_bits 		= PE_Cluster_psum_1_out; 
assign psum_2_PE_in_bits 		= PE_Cluster_psum_2_out; 
assign psum_0_GLB_in_bits 		= GLB_Cluster_psum_SRAM_Bank_0_data_out; 
assign psum_1_GLB_in_bits 		= GLB_Cluster_psum_SRAM_Bank_1_data_out;
assign psum_2_GLB_in_bits 		= GLB_Cluster_psum_SRAM_Bank_2_data_out; 
assign psum_0_north_in_bits 	= router_psum_0_north_in;	
assign psum_1_north_in_bits 	= router_psum_1_north_in; 	
assign psum_2_north_in_bits 	= router_psum_2_north_in; 

// cluster group control
assign cg_ctrl_clock = clock;
assign cg_ctrl_reset = reset;
assign cg_ctrl_GLB_psum_0_write_done = GLB_Cluster_psum_SRAM_Bank_0_write_done; 
assign cg_ctrl_GLB_psum_1_write_done = GLB_Cluster_psum_SRAM_Bank_1_write_done; 
assign cg_ctrl_GLB_psum_2_write_done = GLB_Cluster_psum_SRAM_Bank_2_write_done; 

assign cg_ctrl_GLB_iact_0_0_write_done = GLB_Cluster_iact_SRAM_Bank_0_0_write_done;	
assign cg_ctrl_GLB_iact_0_1_write_done = GLB_Cluster_iact_SRAM_Bank_0_1_write_done; 		
assign cg_ctrl_GLB_iact_0_2_write_done = GLB_Cluster_iact_SRAM_Bank_0_2_write_done; 
assign cg_ctrl_GLB_iact_1_0_write_done = GLB_Cluster_iact_SRAM_Bank_1_0_write_done;	
assign cg_ctrl_GLB_iact_1_1_write_done = GLB_Cluster_iact_SRAM_Bank_1_1_write_done; 		
assign cg_ctrl_GLB_iact_1_2_write_done = GLB_Cluster_iact_SRAM_Bank_1_2_write_done; 
assign cg_ctrl_GLB_iact_2_0_write_done = GLB_Cluster_iact_SRAM_Bank_2_0_write_done;	
assign cg_ctrl_GLB_iact_2_1_write_done = GLB_Cluster_iact_SRAM_Bank_2_1_write_done; 		
assign cg_ctrl_GLB_iact_2_2_write_done = GLB_Cluster_iact_SRAM_Bank_2_2_write_done; 

assign cg_ctrl_GLB_iact_0_0_read_done  = GLB_Cluster_iact_SRAM_Bank_0_0_read_done; 		
assign cg_ctrl_GLB_iact_0_1_read_done  = GLB_Cluster_iact_SRAM_Bank_0_1_read_done; 		
assign cg_ctrl_GLB_iact_0_2_read_done  = GLB_Cluster_iact_SRAM_Bank_0_2_read_done; 	
assign cg_ctrl_GLB_iact_1_0_read_done  = GLB_Cluster_iact_SRAM_Bank_1_0_read_done; 		
assign cg_ctrl_GLB_iact_1_1_read_done  = GLB_Cluster_iact_SRAM_Bank_1_1_read_done; 		
assign cg_ctrl_GLB_iact_1_2_read_done  = GLB_Cluster_iact_SRAM_Bank_1_2_read_done; 
assign cg_ctrl_GLB_iact_2_0_read_done  = GLB_Cluster_iact_SRAM_Bank_2_0_read_done; 		
assign cg_ctrl_GLB_iact_2_1_read_done  = GLB_Cluster_iact_SRAM_Bank_2_1_read_done; 		
assign cg_ctrl_GLB_iact_2_2_read_done  = GLB_Cluster_iact_SRAM_Bank_2_2_read_done; 
	
assign cg_ctrl_read_psum_en 	= read_psum_en; 
assign cg_ctrl_cg_en 			= cg_en; 
assign cg_ctrl_PE_all_write_fin = PE_Cluster_all_write_fin;
assign cg_ctrl_src_GLB_load_fin = src_GLB_load_fin;
assign cg_ctrl_psum_acc_en		= psum_acc_en;
assign cg_ctrl_psum_acc_fin		= psum_acc_fin;

  
  
  
always@(posedge clock) begin
	if(reset) begin
		all_cal_fin <= 1'b0;
	end
	else if(idle_wire) begin
		all_cal_fin <= 1'b0;
	end
	else begin
		all_cal_fin <= all_cal_fin | PE_Cluster_all_cal_fin;
	end
end
  
  
  
endmodule
