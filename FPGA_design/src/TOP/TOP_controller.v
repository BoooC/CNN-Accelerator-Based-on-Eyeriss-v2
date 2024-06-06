// ====================================================================================================== //
// This module is TOP_controller.
// This module control TOP module through several control signals in GLB and PE.
// The shape of SCNN will be compiled by SCNN_shape_info_compiler to get some value 
// for im2col, PE array mapping, unfolding, folding scheme.
// 
// TODO : The end of fully connected layer should use 2 contineous zero to represent current layer weight data
// have been loaded done.(remove the parameter from TOP)
// ====================================================================================================== //


module TOP_controller # (
	parameter WEIGHT_DATA_3_END = 'd30619,
	parameter WEIGHT_DATA_4_END = 'd39877,
	parameter WEIGHT_DATA_5_END = 'd40762
)
(
	input				clock,
	input				reset,
		
	input				system_enable,
	
	output				MEM_read_en,
	output	reg	[15:0]	MEM_read_addr,
	
	input				weight_addr_end,
	input				weight_data_end,
	input				csc_addr_end,
	
	output				ifmap_in_en,
	output				ReLU_en,
	output				psum_acc_fin,
	output				psum_SRAM_out_acc_en,
	output				softmax_en,
	
	output reg			csc_en,
	
	output 				conv_flag,
	output 				fc_flag,
	output	reg [2:0] 	layer_count,
	
	output 				CG_0_0_GLB_psum_0_out_en,
	output 				CG_0_0_GLB_psum_1_out_en,
	output 				CG_0_0_GLB_psum_2_out_en,
	output 				CG_0_1_GLB_psum_0_out_en,
	output 				CG_0_1_GLB_psum_1_out_en,
	output 				CG_0_1_GLB_psum_2_out_en,
	output 				CG_1_0_GLB_psum_0_out_en,
	output 				CG_1_0_GLB_psum_1_out_en,
	output 				CG_1_0_GLB_psum_2_out_en,
	output 				CG_1_1_GLB_psum_0_out_en,
	output 				CG_1_1_GLB_psum_1_out_en,
	output 				CG_1_1_GLB_psum_2_out_en,
	
	output 				CG_0_0_GLB_iact_0_0_in_en,
	output 				CG_0_0_GLB_iact_0_1_in_en,
	output 				CG_0_0_GLB_iact_0_2_in_en,
	output 				CG_0_0_GLB_iact_1_0_in_en,
	output 				CG_0_0_GLB_iact_1_1_in_en,
	output 				CG_0_0_GLB_iact_1_2_in_en,
	output 				CG_0_0_GLB_iact_2_0_in_en,
	output 				CG_0_0_GLB_iact_2_1_in_en,
	output 				CG_0_0_GLB_iact_2_2_in_en,
	output 				CG_0_1_GLB_iact_0_0_in_en,
	output 				CG_0_1_GLB_iact_0_1_in_en,
	output 				CG_0_1_GLB_iact_0_2_in_en,
	output 				CG_0_1_GLB_iact_1_0_in_en,
	output 				CG_0_1_GLB_iact_1_1_in_en,
	output 				CG_0_1_GLB_iact_1_2_in_en,
	output 				CG_0_1_GLB_iact_2_0_in_en,
	output 				CG_0_1_GLB_iact_2_1_in_en,
	output 				CG_0_1_GLB_iact_2_2_in_en,
	output 				CG_1_0_GLB_iact_0_0_in_en,
	output 				CG_1_0_GLB_iact_0_1_in_en,
	output 				CG_1_0_GLB_iact_0_2_in_en,
	output 				CG_1_0_GLB_iact_1_0_in_en,
	output 				CG_1_0_GLB_iact_1_1_in_en,
	output 				CG_1_0_GLB_iact_1_2_in_en,
	output 				CG_1_0_GLB_iact_2_0_in_en,
	output 				CG_1_0_GLB_iact_2_1_in_en,
	output 				CG_1_0_GLB_iact_2_2_in_en,
	output 				CG_1_1_GLB_iact_0_0_in_en,
	output 				CG_1_1_GLB_iact_0_1_in_en,
	output 				CG_1_1_GLB_iact_0_2_in_en,
	output 				CG_1_1_GLB_iact_1_0_in_en,
	output 				CG_1_1_GLB_iact_1_1_in_en,
	output 				CG_1_1_GLB_iact_1_2_in_en,
	output 				CG_1_1_GLB_iact_2_0_in_en,
	output 				CG_1_1_GLB_iact_2_1_in_en,
	output 				CG_1_1_GLB_iact_2_2_in_en,
	
	output 				CG_0_0_GLB_weight_0_in_en,
	output 				CG_0_0_GLB_weight_1_in_en,
	output 				CG_0_0_GLB_weight_2_in_en,
	output 				CG_0_1_GLB_weight_0_in_en,
	output 				CG_0_1_GLB_weight_1_in_en,
	output 				CG_0_1_GLB_weight_2_in_en,
	output 				CG_1_0_GLB_weight_0_in_en,
	output 				CG_1_0_GLB_weight_1_in_en,
	output 				CG_1_0_GLB_weight_2_in_en,
	output 				CG_1_1_GLB_weight_0_in_en,
	output 				CG_1_1_GLB_weight_1_in_en,
	output 				CG_1_1_GLB_weight_2_in_en,
	
	// ------------- CG_0_0 ------------- //
	output		     	CG_0_0_PE_cluster_iact_data_in_sel,
	output		[1:0]	CG_0_0_PE_cluster_iact_data_out_sel,
	output		     	CG_0_0_PE_cluster_psum_data_in_sel,
	
	output		[1:0]	CG_0_0_router_cluster_iact_data_in_sel,
	output		[1:0]	CG_0_0_router_cluster_iact_data_out_sel,
	output		     	CG_0_0_router_cluster_weight_data_in_sel,
	output		     	CG_0_0_router_cluster_weight_data_out_sel,
	output		     	CG_0_0_router_cluster_psum_data_in_sel,
	output		     	CG_0_0_router_cluster_psum_data_out_sel,
			
	input				CG_0_0_GLB_iact_load_en,
	input				CG_0_0_PE_weight_load_en,
	input				CG_0_0_cal_fin,
	output	reg			CG_0_0_src_GLB_load_fin,
	output				CG_0_0_cg_en,
	output				CG_0_0_read_psum_en,
	output				CG_0_0_psum_SRAM_Bank_0_read_out_en,
	output				CG_0_0_psum_SRAM_Bank_1_read_out_en,
	output				CG_0_0_psum_SRAM_Bank_2_read_out_en,
	
	output				CG_0_0_PE_0_0_disable,					
	output				CG_0_0_PE_0_1_disable,					
	output				CG_0_0_PE_0_2_disable,					
	output				CG_0_0_PE_1_0_disable,					
	output				CG_0_0_PE_1_1_disable,					
	output				CG_0_0_PE_1_2_disable,					
	output				CG_0_0_PE_2_0_disable,					
	output				CG_0_0_PE_2_1_disable,					
	output				CG_0_0_PE_2_2_disable,
		
	output		[9:0]	CG_0_0_GLB_iact_0_0_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_0_1_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_0_2_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_1_0_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_1_1_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_1_2_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_2_0_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_2_1_read_addr,
	output		[9:0]	CG_0_0_GLB_iact_2_2_read_addr,
		
	output				CG_0_0_GLB_psum_write_en,
	output	reg	[9:0]	CG_0_0_GLB_psum_0_write_addr,
	output	reg	[9:0]	CG_0_0_GLB_psum_1_write_addr,
	output	reg	[9:0]	CG_0_0_GLB_psum_2_write_addr,
	output		[9:0]	CG_0_0_GLB_psum_0_read_addr,
	output		[9:0]	CG_0_0_GLB_psum_1_read_addr,
	output		[9:0]	CG_0_0_GLB_psum_2_read_addr,
		   
	output		[4:0]	CG_0_0_PSUM_DEPTH,
	output				CG_0_0_psum_spad_clear,
				
	output				CG_0_0_iact_write_fin_clear,
	output				CG_0_0_weight_write_fin_clear,
	
	// ------------- CG_0_1 ------------- //
	output		     	CG_0_1_PE_cluster_iact_data_in_sel,
	output		[1:0]	CG_0_1_PE_cluster_iact_data_out_sel,
	output		     	CG_0_1_PE_cluster_psum_data_in_sel,
	
	output		[1:0]	CG_0_1_router_cluster_iact_data_in_sel,
	output		[1:0]	CG_0_1_router_cluster_iact_data_out_sel,
	output		     	CG_0_1_router_cluster_weight_data_in_sel,
	output		     	CG_0_1_router_cluster_weight_data_out_sel,
	output		     	CG_0_1_router_cluster_psum_data_in_sel,
	output		     	CG_0_1_router_cluster_psum_data_out_sel,
							
	input				CG_0_1_GLB_iact_load_en,
	input				CG_0_1_PE_weight_load_en,
	input				CG_0_1_cal_fin,
	output	reg			CG_0_1_src_GLB_load_fin,
	output				CG_0_1_cg_en,
	output				CG_0_1_read_psum_en,
	output				CG_0_1_psum_SRAM_Bank_0_read_out_en,
	output				CG_0_1_psum_SRAM_Bank_1_read_out_en,
	output				CG_0_1_psum_SRAM_Bank_2_read_out_en,
	
	output				CG_0_1_PE_0_0_disable,					
	output				CG_0_1_PE_0_1_disable,					
	output				CG_0_1_PE_0_2_disable,					
	output				CG_0_1_PE_1_0_disable,					
	output				CG_0_1_PE_1_1_disable,					
	output				CG_0_1_PE_1_2_disable,					
	output				CG_0_1_PE_2_0_disable,					
	output				CG_0_1_PE_2_1_disable,					
	output				CG_0_1_PE_2_2_disable,
							 
	output		[9:0]	CG_0_1_GLB_iact_0_0_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_0_1_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_0_2_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_1_0_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_1_1_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_1_2_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_2_0_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_2_1_read_addr,
	output		[9:0]	CG_0_1_GLB_iact_2_2_read_addr,
							
	output				CG_0_1_GLB_psum_write_en,
	output	reg	[9:0]	CG_0_1_GLB_psum_0_write_addr,
	output	reg	[9:0]	CG_0_1_GLB_psum_1_write_addr,
	output	reg	[9:0]	CG_0_1_GLB_psum_2_write_addr,
	output		[9:0]	CG_0_1_GLB_psum_0_read_addr,
	output		[9:0]	CG_0_1_GLB_psum_1_read_addr,
	output		[9:0]	CG_0_1_GLB_psum_2_read_addr,
							
	output		[4:0]	CG_0_1_PSUM_DEPTH,
	output				CG_0_1_psum_spad_clear,
							
	output				CG_0_1_iact_write_fin_clear,
	output				CG_0_1_weight_write_fin_clear,
	
	
	// ------------- CG_1_0 ------------- //
	output		     	CG_1_0_PE_cluster_iact_data_in_sel,
	output		[1:0]	CG_1_0_PE_cluster_iact_data_out_sel,
	output		     	CG_1_0_PE_cluster_psum_data_in_sel,
						
	output		[1:0]	CG_1_0_router_cluster_iact_data_in_sel,
	output		[1:0]	CG_1_0_router_cluster_iact_data_out_sel,
	output		     	CG_1_0_router_cluster_weight_data_in_sel,
	output		     	CG_1_0_router_cluster_weight_data_out_sel,
	output		     	CG_1_0_router_cluster_psum_data_in_sel,
	output		     	CG_1_0_router_cluster_psum_data_out_sel,
						
	input				CG_1_0_GLB_iact_load_en,
	input				CG_1_0_PE_weight_load_en,
	input				CG_1_0_cal_fin,
	output	reg			CG_1_0_src_GLB_load_fin,
	output				CG_1_0_cg_en,
	output				CG_1_0_read_psum_en,
	output				CG_1_0_psum_SRAM_Bank_0_read_out_en,
	output				CG_1_0_psum_SRAM_Bank_1_read_out_en,
	output				CG_1_0_psum_SRAM_Bank_2_read_out_en,
	
	output				CG_1_0_PE_0_0_disable,					
	output				CG_1_0_PE_0_1_disable,					
	output				CG_1_0_PE_0_2_disable,					
	output				CG_1_0_PE_1_0_disable,					
	output				CG_1_0_PE_1_1_disable,					
	output				CG_1_0_PE_1_2_disable,					
	output				CG_1_0_PE_2_0_disable,					
	output				CG_1_0_PE_2_1_disable,					
	output				CG_1_0_PE_2_2_disable,
						
	output		[9:0]	CG_1_0_GLB_iact_0_0_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_0_1_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_0_2_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_1_0_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_1_1_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_1_2_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_2_0_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_2_1_read_addr,
	output		[9:0]	CG_1_0_GLB_iact_2_2_read_addr,
						
	output				CG_1_0_GLB_psum_write_en,
	output	reg	[9:0]	CG_1_0_GLB_psum_0_write_addr,
	output	reg	[9:0]	CG_1_0_GLB_psum_1_write_addr,
	output	reg	[9:0]	CG_1_0_GLB_psum_2_write_addr,
	output		[9:0]	CG_1_0_GLB_psum_0_read_addr,
	output		[9:0]	CG_1_0_GLB_psum_1_read_addr,
	output		[9:0]	CG_1_0_GLB_psum_2_read_addr,
						
	output		[4:0]	CG_1_0_PSUM_DEPTH,
	output				CG_1_0_psum_spad_clear,
						
	output				CG_1_0_iact_write_fin_clear,
	output				CG_1_0_weight_write_fin_clear,
						
	// ------------- CG_1_1 ------------- //
	output		     	CG_1_1_PE_cluster_iact_data_in_sel,
	output		[1:0]	CG_1_1_PE_cluster_iact_data_out_sel,
	output		     	CG_1_1_PE_cluster_psum_data_in_sel,
	
	output		[1:0]	CG_1_1_router_cluster_iact_data_in_sel,
	output		[1:0]	CG_1_1_router_cluster_iact_data_out_sel,
	output		     	CG_1_1_router_cluster_weight_data_in_sel,
	output		     	CG_1_1_router_cluster_weight_data_out_sel,
	output		     	CG_1_1_router_cluster_psum_data_in_sel,
	output		     	CG_1_1_router_cluster_psum_data_out_sel,
	
	input				CG_1_1_GLB_iact_load_en,
	input				CG_1_1_PE_weight_load_en,
	input				CG_1_1_cal_fin,
	output	reg			CG_1_1_src_GLB_load_fin,
	output				CG_1_1_cg_en,
	output				CG_1_1_read_psum_en,
	output				CG_1_1_psum_SRAM_Bank_0_read_out_en,
	output				CG_1_1_psum_SRAM_Bank_1_read_out_en,
	output				CG_1_1_psum_SRAM_Bank_2_read_out_en,
	
	output				CG_1_1_PE_0_0_disable,					
	output				CG_1_1_PE_0_1_disable,					
	output				CG_1_1_PE_0_2_disable,					
	output				CG_1_1_PE_1_0_disable,					
	output				CG_1_1_PE_1_1_disable,					
	output				CG_1_1_PE_1_2_disable,					
	output				CG_1_1_PE_2_0_disable,					
	output				CG_1_1_PE_2_1_disable,					
	output				CG_1_1_PE_2_2_disable,
							
	output		[9:0]	CG_1_1_GLB_iact_0_0_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_0_1_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_0_2_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_1_0_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_1_1_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_1_2_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_2_0_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_2_1_read_addr,
	output		[9:0]	CG_1_1_GLB_iact_2_2_read_addr,
							
	output				CG_1_1_GLB_psum_write_en,
	output	reg	[9:0]	CG_1_1_GLB_psum_0_write_addr,
	output	reg	[9:0]	CG_1_1_GLB_psum_1_write_addr,
	output	reg	[9:0]	CG_1_1_GLB_psum_2_write_addr,
	output		[9:0]	CG_1_1_GLB_psum_0_read_addr,
	output		[9:0]	CG_1_1_GLB_psum_1_read_addr,
	output		[9:0]	CG_1_1_GLB_psum_2_read_addr,
							
	output		[4:0]	CG_1_1_PSUM_DEPTH,
	output				CG_1_1_psum_spad_clear,
							
	output				CG_1_1_iact_write_fin_clear,
	output				CG_1_1_weight_write_fin_clear,
		
	// ------------- CSC_encoder ------------- //
	output  	[4:0]  	CSC_encoder_iact_matrix_height,
	output  	[4:0]  	CSC_encoder_iact_matrix_width,
	output				CSC_encoder_iact_clear_iact_SRAM,
	input				CSC_encoder_iact_one_vector_done,
	
	output  	[4:0]  	CSC_encoder_weight_matrix_height,
	output  	[4:0]  	CSC_encoder_weight_matrix_width,
	output				CSC_encoder_weight_clear_iact_SRAM,
	input				CSC_encoder_weight_one_vector_done,
	
	// ------------- im2col converter ------------- //
	output				im2col_enable,
	output		[9:0]	im2col_ifmap_len,					// 576
	output		[4:0]	im2col_ofmap_size,					// 24*24
	output		[9:0]	im2col_next_weight_row_jump,
	output		[9:0]	im2col_next_ifmap_row_jump,			// 111
	output		[9:0]	im2col_next_vector_jump,			// 115
	input		[9:0]	im2col_read_psum_addr,
	input               im2col_convert_one_stream_done,
	
	
	// ------------- psum_rearrange_write_en ------------- //
	output				psum_rearrange_write_en,
	output	reg	[11:0]	psum_rearrange_write_addr,
	output	reg	[11:0]	psum_rearrange_read_addr,
	
	// ------------- pool_enable ------------- //
	output				pool_enable
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
// HM-NoC routing mode parameters
// iact control path
localparam IACT_GLB   			= 2'b00;
localparam IACT_NORTH 			= 2'b01;
localparam IACT_SOUTH 			= 2'b10;
localparam IACT_HORIZ 			= 2'b11;
localparam IACT_UNICAST 		= 2'b00;
localparam IACT_HOR_MULTICAST 	= 2'b01;
localparam IACT_VER_MULTICAST 	= 2'b10;
localparam IACT_BROADCAST 	 	= 2'b11;

// weight control path
localparam WEIGHT_GLB   		= 1'b0;
localparam WEIGHT_HORIZ 		= 1'b1;
localparam WEIGHT_UNICAST 		= 1'b0;
localparam WEIGHT_HOR_MULTICAST = 1'b1;
		
// psum control path
localparam PSUM_FROM_NOR 		= 1'b0;
localparam PSUM_FROM_GLB 		= 1'b1;
localparam PSUM_TO_SOU 			= 1'b0;
localparam PSUM_TO_PE  			= 1'b1;

// PE cluster control path
localparam PE_IACT_BROADCAST	= 1'b1;
localparam PE_IACT_ROUTER_0 	= 2'd0;
localparam PE_IACT_ROUTER_1 	= 2'd1;
localparam PE_IACT_ROUTER_2 	= 2'd2;

localparam PE_PSUM_FROM_SOU 	= 1'b0;
localparam PE_PSUM_FROM_ROUTER 	= 1'b1;


// TOP level control
localparam  IDLE 					= 'd0;
localparam  LAYER_LOAD_IFMAP 		= 'd1;	// data processing and load GLB
localparam  LAYER_LOAD_GLB			= 'd2;
localparam  LAYER_LOAD_PE			= 'd3;
localparam  LAYER_CAL 				= 'd4;
localparam  LAYER_PSUM_ACC 			= 'd5;
localparam  LAYER_READ_OUT_PSUM 	= 'd6;
localparam  LAYER_POOLING			= 'd7;
localparam  LAYER_DONE				= 'd8;
localparam  DONE					= 'd63;

reg	[5:0]	state, next_state;

// state wire
wire  IDLE_wire 				= state == IDLE;
wire  LAYER_LOAD_IFMAP_wire 	= state == LAYER_LOAD_IFMAP;
wire  LAYER_LOAD_GLB_wire		= state == LAYER_LOAD_GLB;
wire  LAYER_LOAD_PE_wire		= state == LAYER_LOAD_PE;
wire  LAYER_CAL_wire 			= state == LAYER_CAL;	
wire  LAYER_PSUM_ACC_wire 		= state == LAYER_PSUM_ACC;
wire  LAYER_READ_OUT_PSUM_wire 	= state == LAYER_READ_OUT_PSUM;	
wire  LAYER_POOLING_wire		= state == LAYER_POOLING;	
wire  LAYER_DONE_wire			= state == LAYER_DONE;	
wire  DONE_wire					= state == DONE;		



wire LAYER0_LOAD_GLB_wire 		= layer0_flag & LAYER_LOAD_GLB_wire;
wire LAYER1_LOAD_GLB_wire 		= layer1_flag & LAYER_LOAD_GLB_wire;
wire LAYER2_LOAD_GLB_wire 		= layer2_flag & LAYER_LOAD_GLB_wire;
wire LAYER3_LOAD_GLB_wire 		= layer3_flag & LAYER_LOAD_GLB_wire;
wire LAYER4_LOAD_GLB_wire 		= layer4_flag & LAYER_LOAD_GLB_wire;

wire LAYER0_LOAD_PE_wire		= layer0_flag & LAYER_LOAD_PE_wire;
wire LAYER1_LOAD_PE_wire		= layer1_flag & LAYER_LOAD_PE_wire;
wire LAYER2_LOAD_PE_wire		= layer2_flag & LAYER_LOAD_PE_wire;
wire LAYER3_LOAD_PE_wire		= layer3_flag & LAYER_LOAD_PE_wire;
wire LAYER4_LOAD_PE_wire		= layer4_flag & LAYER_LOAD_PE_wire;

wire LAYER0_CAL_wire 			= layer0_flag & LAYER_CAL_wire;
wire LAYER1_CAL_wire 			= layer1_flag & LAYER_CAL_wire;
wire LAYER2_CAL_wire 			= layer2_flag & LAYER_CAL_wire;
wire LAYER3_CAL_wire 			= layer3_flag & LAYER_CAL_wire;
wire LAYER4_CAL_wire 			= layer4_flag & LAYER_CAL_wire;

wire LAYER0_PSUM_ACC_wire 		= layer0_flag & LAYER_PSUM_ACC_wire;
wire LAYER1_PSUM_ACC_wire 		= layer1_flag & LAYER_PSUM_ACC_wire;
wire LAYER2_PSUM_ACC_wire 		= layer2_flag & LAYER_PSUM_ACC_wire;
wire LAYER3_PSUM_ACC_wire 		= layer3_flag & LAYER_PSUM_ACC_wire;
wire LAYER4_PSUM_ACC_wire 		= layer4_flag & LAYER_PSUM_ACC_wire;

wire LAYER0_READ_OUT_PSUM_wire 	= layer0_flag & LAYER_READ_OUT_PSUM_wire;
wire LAYER1_READ_OUT_PSUM_wire 	= layer1_flag & LAYER_READ_OUT_PSUM_wire;
wire LAYER2_READ_OUT_PSUM_wire 	= layer2_flag & LAYER_READ_OUT_PSUM_wire;
wire LAYER3_READ_OUT_PSUM_wire 	= layer3_flag & LAYER_READ_OUT_PSUM_wire;
wire LAYER4_READ_OUT_PSUM_wire 	= layer4_flag & LAYER_READ_OUT_PSUM_wire;

wire LAYER0_POOLING_wire	 	= layer0_flag & LAYER_POOLING_wire;
wire LAYER1_POOLING_wire	 	= layer1_flag & LAYER_POOLING_wire;

		


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg [11:0] psum_rearrange_read_addr_reg;

reg			csc_en_reg;
reg [2:0] 	fc_weight_read_batch;	// fc1 weight : 16*30(16x4), batches=30, 6 PE array psum out parallel, iteration = 30/6 = 5

reg	[5:0] 	GLB_iact_en_sel;
reg			ifmap_load_fin_reg;

reg	[7:0]	psum_acc_times;

reg			pool_row_count;
reg			pool_col_count;
reg [3:0]	pool_ofmap_row_count;

reg	[4:0]	read_out_psum_count; 	// 0~3
reg	[4:0]	read_out_psum_sel;		// 0~11
reg	[4:0]	read_out_psum_iter;		// 0~11
reg	[4:0]	read_out_psum_channel;	// 0~5

reg			first_iter_read_GLB_iact, second_iter_read_GLB_iact, third_iter_read_GLB_iact; 	
reg [1:0] 	layer_done_count;

// one shot pulse generator
reg			layer_iter_fin_reg;
reg			psum_acc_state_reg;
reg			pool_state_reg;
reg 		pool_pulse_reg;

reg	[9:0]	CG_0_0_GLB_psum_0_read_addr_reg, CG_0_0_GLB_psum_1_read_addr_reg, CG_0_0_GLB_psum_2_read_addr_reg;
reg	[9:0]	CG_0_1_GLB_psum_0_read_addr_reg, CG_0_1_GLB_psum_1_read_addr_reg, CG_0_1_GLB_psum_2_read_addr_reg;
reg	[9:0]	CG_1_0_GLB_psum_0_read_addr_reg, CG_1_0_GLB_psum_1_read_addr_reg, CG_1_0_GLB_psum_2_read_addr_reg;
reg	[9:0]	CG_1_1_GLB_psum_0_read_addr_reg, CG_1_1_GLB_psum_1_read_addr_reg, CG_1_1_GLB_psum_2_read_addr_reg;

reg			im2col_convert_one_stream_done_reg;

reg [2:0] 	psum_read_out_channel;

reg	[9:0] 	GLB_iact_read_addr;

reg	[2:0] 	GLB_iact_load_batch;	// one batch for 6 (4x25) sets
reg	[2:0] 	GLB_iact_load_channel;
reg	[2:0] 	GLB_iact_load_iter;

reg	[2:0] 	GLB_weight_load_channel;

reg 		GLB_weight_load_end_reg;

reg 		psum_read_out_oen_channel_read_done;
reg 		read_out_psum_later_flag; 

reg [4:0] 	fc_psum_rearrange_read_count;
reg [4:0] 	fc_psum_rearrange_read_channel;

reg [1:0] 	GLB_psum_read_channel; 	// 0~2
reg [2:0] 	GLB_psum_read_batch; 	// 0~4
reg	[2:0] 	GLB_psum_read_sel;		// 0~5
reg	[2:0] 	GLB_psum_read_sel_reg;	

reg			LAYER2_READ_OUT_PSUM_reg, LAYER3_READ_OUT_PSUM_reg, LAYER4_READ_OUT_PSUM_reg;
reg			psum_SRAM_out_acc_en_dly0, psum_SRAM_out_acc_en_dly1, psum_SRAM_out_acc_en_dly2;

// for fc layers, the psum out from SRAM would delay 3 clock cycles 
reg [3:0] 	fc_channel_acc_count;
reg 		csc_en_fin;



// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire layer0_flag = layer_count == 'd0;
wire layer1_flag = layer_count == 'd1;
wire layer2_flag = layer_count == 'd2;
wire layer3_flag = layer_count == 'd3;
wire layer4_flag = layer_count == 'd4;

wire GLB_psum_read_addr_reg_done 	= CG_0_0_GLB_psum_0_read_addr_reg 	== 'd3;
wire GLB_psum_read_channel_done 	= (layer2_flag & GLB_psum_read_channel 	== 'd2) | (layer3_flag & GLB_psum_read_channel == 'd0) | ((layer4_flag & GLB_psum_read_channel == 'd0));
wire GLB_psum_read_batch_done 		= (layer2_flag & GLB_psum_read_batch 	== 'd4) | (layer3_flag & GLB_psum_read_batch == 'd3 & GLB_psum_read_sel == 'd2) | (layer4_flag & GLB_psum_read_batch == 'd0);
wire GLB_psum_read_sel_done			= (layer2_flag & GLB_psum_read_sel 		== 'd5) | (layer3_flag & (GLB_psum_read_batch == 'd3 & GLB_psum_read_sel == 'd2) | GLB_psum_read_sel == 'd5) | ((layer4_flag & GLB_psum_read_sel == 'd2));

wire GLB_iact_load_channel_0 = GLB_iact_load_channel == 'd0;
wire GLB_iact_load_channel_1 = GLB_iact_load_channel == 'd1;
wire GLB_iact_load_channel_2 = GLB_iact_load_channel == 'd2;
wire GLB_iact_load_channel_3 = GLB_iact_load_channel == 'd3;
wire GLB_iact_load_channel_4 = GLB_iact_load_channel == 'd4;
wire GLB_iact_load_channel_5 = GLB_iact_load_channel == 'd5;


wire psum_rearrange_read_addr_dly_3_cycles = (layer2_flag & (fc_psum_rearrange_read_count == 'd15 | fc_psum_rearrange_read_count == 'd16)) | 
											 (layer3_flag & (fc_psum_rearrange_read_count == 'd19 | fc_psum_rearrange_read_count == 'd20)) | 
											 (layer4_flag & (fc_psum_rearrange_read_count == 'd20 | fc_psum_rearrange_read_count == 'd21));


// weight_broadcast is for the case of the numbers of weight matrix is less, it will broadcast weight to reuse weight
wire weight_broadcast 			= layer0_flag;
wire GLB_weight_load_channel_0	= GLB_weight_load_channel == 'd0;
wire GLB_weight_load_channel_1	= GLB_weight_load_channel == 'd1;
wire GLB_weight_load_channel_2	= GLB_weight_load_channel == 'd2;
wire GLB_weight_load_channel_3	= GLB_weight_load_channel == 'd3;
wire GLB_weight_load_channel_4	= GLB_weight_load_channel == 'd4;
wire GLB_weight_load_channel_5	= GLB_weight_load_channel == 'd5;

// one shot pulse signals
wire 		psum_acc_pulse, pool_pulse, layer_iter_fin_pulse;	

// state machine control signals
wire 		ifmap_load_fin, all_GLB_load_en, all_PE_weight_load_en, all_cal_fin;

// pool control signals
wire 		pool_row_done, pool_col_done, pool_ofmap_row_done;
wire 		pool_fin;

// read out psum control signals
wire 		read_out_psum_count_done, read_out_psum_sel_done, read_out_psum_iter_done, read_out_psum_channel_done;
wire 		all_GLB_psum_read_out_done;
wire [9:0]	first_GLB_psum_read_out_adjust;

// load data iteration signals
wire 		all_iter_fin;
wire 		layer_iter_fin, layer_done_fin;
wire 		layer_1_former_iter_fin;

wire [3:0] 	read_out_psum_sets 			= layer0_flag ? 'd11 : (layer1_flag ? 'd5 	: 'd0);
wire [3:0] 	read_out_psum_iters			= layer0_flag ? 'd11 : (layer1_flag ? 'd2 	: 'd0);
wire [3:0] 	read_out_psum_channels		= layer0_flag ? 'd5  : (layer1_flag ? 'd7 	: 'd0);
			
wire [3:0]	pool_ofmap_rows				= layer0_flag ? 'd11 : layer1_flag ? 'd3 : 'd0;

wire 		pool_pulse_wire 			= LAYER_POOLING_wire;

wire 		cg_en 						= LAYER_LOAD_GLB_wire | LAYER_LOAD_PE_wire | LAYER_CAL_wire | layer_done_fin;

wire 		GLB_weight_load_end 		= (layer0_flag & weight_data_end) | (layer1_flag & GLB_weight_load_channel_5 & weight_data_end);

// wait 12 psums accumulated to 3 psums, for more than 4 channels need to accumulated
wire 		fc_psum_read_en 			= (fc_channel_acc_count == 'd8 | fc_channel_acc_count == 'd9 | fc_channel_acc_count == 'd10 | fc_channel_acc_count == 'd11);
		
wire 		MEM_fc1_read_done 			= (MEM_read_addr == WEIGHT_DATA_3_END) & layer2_flag;
wire 		MEM_fc2_read_done 			= (MEM_read_addr == WEIGHT_DATA_4_END) & layer3_flag;
wire 		MEM_fc3_read_done 			= (MEM_read_addr == WEIGHT_DATA_5_END) & layer4_flag;

// pipeline : flow control
wire 		load_PE_start 				= (layer0_flag & GLB_iact_en_sel 	 == 'd8 	& third_iter_read_GLB_iact) | 
										  (layer1_flag & GLB_iact_load_batch == 'd1 	& GLB_iact_load_channel_5) 	| 
										  (MEM_fc1_read_done | MEM_fc2_read_done | MEM_fc3_read_done);


wire read_out_psum_former_fin = layer1_flag & (read_out_psum_count == 'd3) & (read_out_psum_sel == 'd3) & (read_out_psum_iter == 'd2);

wire read_out_psum_en_conv 	= LAYER_READ_OUT_PSUM_wire & conv_flag;
wire read_out_psum_en_fc 	= LAYER_READ_OUT_PSUM_wire & fc_flag;

// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign  CG_0_0_PE_0_0_disable = 'd0;
assign  CG_0_0_PE_0_1_disable = 'd0;
assign  CG_0_0_PE_0_2_disable = 'd0;
assign  CG_0_0_PE_1_0_disable = 'd0;
assign  CG_0_0_PE_1_1_disable = 'd0;
assign  CG_0_0_PE_1_2_disable = 'd0;
assign  CG_0_0_PE_2_0_disable = 'd0;
assign  CG_0_0_PE_2_1_disable = 'd0;
assign  CG_0_0_PE_2_2_disable = 'd0;
assign  CG_0_1_PE_0_0_disable = layer4_flag;
assign  CG_0_1_PE_0_1_disable = layer4_flag;
assign  CG_0_1_PE_0_2_disable = layer4_flag;
assign  CG_0_1_PE_1_0_disable = layer4_flag;
assign  CG_0_1_PE_1_1_disable = layer4_flag;
assign  CG_0_1_PE_1_2_disable = layer4_flag;
assign  CG_0_1_PE_2_0_disable = layer4_flag;
assign  CG_0_1_PE_2_1_disable = layer4_flag;
assign  CG_0_1_PE_2_2_disable = layer4_flag;
assign  CG_1_0_PE_0_0_disable = 'd0;
assign  CG_1_0_PE_0_1_disable = 'd0;
assign  CG_1_0_PE_0_2_disable = 'd0;
assign  CG_1_0_PE_1_0_disable = layer4_flag;
assign  CG_1_0_PE_1_1_disable = layer4_flag;
assign  CG_1_0_PE_1_2_disable = layer4_flag;
assign  CG_1_0_PE_2_0_disable = layer4_flag;
assign  CG_1_0_PE_2_1_disable = layer4_flag;
assign  CG_1_0_PE_2_2_disable = layer4_flag;
assign  CG_1_1_PE_0_0_disable = layer4_flag;
assign  CG_1_1_PE_0_1_disable = layer4_flag;
assign  CG_1_1_PE_0_2_disable = layer4_flag;
assign  CG_1_1_PE_1_0_disable = layer4_flag;
assign  CG_1_1_PE_1_1_disable = layer4_flag;
assign  CG_1_1_PE_1_2_disable = layer4_flag;
assign  CG_1_1_PE_2_0_disable = layer4_flag;
assign  CG_1_1_PE_2_1_disable = layer4_flag;
assign  CG_1_1_PE_2_2_disable = layer4_flag;


assign psum_SRAM_out_acc_en			= 	(LAYER2_READ_OUT_PSUM_wire | LAYER2_READ_OUT_PSUM_reg) | (LAYER3_READ_OUT_PSUM_wire | LAYER3_READ_OUT_PSUM_reg) | (LAYER4_READ_OUT_PSUM_wire | LAYER4_READ_OUT_PSUM_reg);

// layer control
assign conv_flag					= 	layer0_flag | layer1_flag;
assign fc_flag						= 	layer2_flag | layer3_flag | layer4_flag;

// pulse generation
assign 	layer_iter_fin_pulse 		= 	layer_iter_fin 	& (~layer_iter_fin_reg);

// state machine control
assign	ifmap_load_fin				= 	MEM_read_addr >= 'd783 & CG_0_0_GLB_psum_0_write_addr < 'd289;
assign	all_GLB_load_en 			= 	(CG_0_0_GLB_iact_load_en | CG_0_1_GLB_iact_load_en | CG_1_0_GLB_iact_load_en | CG_1_1_GLB_iact_load_en) & (~load_PE_start);
assign	all_PE_weight_load_en 		= 	CG_0_0_PE_weight_load_en| CG_0_1_PE_weight_load_en | CG_1_0_PE_weight_load_en| CG_1_1_PE_weight_load_en;
assign	all_cal_fin					= 	CG_0_0_cal_fin & CG_0_1_cal_fin & CG_1_0_cal_fin & CG_1_1_cal_fin;

// read ifmap control
assign	ifmap_in_en 				= 	LAYER_LOAD_IFMAP_wire;

// read out psum control
assign 	psum_acc_pulse 				= 	LAYER_PSUM_ACC_wire & (~psum_acc_state_reg);
assign	read_out_psum_count_done	= 	read_out_psum_count == 'd3;

assign	read_out_psum_sel_done		= 	(read_out_psum_sel 	== read_out_psum_sets	& read_out_psum_count_done & layer0_flag) | 
										(read_out_psum_sel 	== read_out_psum_sets 	& read_out_psum_count_done & layer1_flag) | 
										(read_out_psum_iter == read_out_psum_iters 	& read_out_psum_sel == 'd3 & read_out_psum_count_done & layer1_flag);

assign	read_out_psum_iter_done		= 	read_out_psum_iter 		== read_out_psum_iters 		& read_out_psum_sel_done;				  
assign	read_out_psum_channel_done	= 	read_out_psum_channel 	== read_out_psum_channels	& read_out_psum_iter_done;

assign	all_GLB_psum_read_out_done 	= 	(layer0_flag & read_out_psum_channel_done) | 
										(layer1_flag & read_out_psum_channel_done  & read_out_psum_later_flag) | 
										(fc_flag & GLB_psum_read_addr_reg_done & GLB_psum_read_channel_done & GLB_psum_read_batch_done & GLB_psum_read_sel_done);

assign 	first_GLB_psum_read_out_adjust = all_iter_fin ? (read_out_psum_channel == 'd7) ? 'd96 : ((read_out_psum_channel+'d1)<<'d2) : (read_out_psum_channel<<'d2);

assign 	psum_rearrange_write_en 	= 	(LAYER_LOAD_IFMAP_wire) 	| 
										(LAYER0_READ_OUT_PSUM_wire) | 
										(LAYER1_READ_OUT_PSUM_wire) | 
										(fc_psum_read_en) 			| 
										(LAYER3_READ_OUT_PSUM_reg)	| 
										(LAYER4_READ_OUT_PSUM_reg)	| 
										(LAYER_POOLING_wire & ~pool_pulse & ~pool_pulse_reg & ~pool_col_done & ~pool_row_done); 

assign	psum_acc_fin				= 	(CG_0_0_GLB_psum_0_write_addr % 'd24 == 'd23 & layer0_flag)	| 
										(CG_0_0_GLB_psum_0_write_addr % 'd32 == 'd31 & layer1_flag) | 
										(CG_0_0_GLB_psum_0_write_addr % 'd4  == 'd3  & layer2_flag) | 
										(CG_0_0_GLB_psum_0_write_addr % 'd4  == 'd3  & layer3_flag) | 
										(CG_0_0_GLB_psum_0_write_addr % 'd4  == 'd3  & layer4_flag) | CG_0_0_GLB_psum_0_write_addr == 'd289;	// need to be optimized


// pool control
assign 	pool_pulse 					= 	pool_pulse_wire & (~pool_state_reg);
assign	pool_row_done 				= 	pool_row_count == 'd1;
assign	pool_col_done 				= 	pool_col_count == 'd1;
assign	pool_ofmap_row_done 		= 	pool_ofmap_row_count == pool_ofmap_rows;
assign	pool_fin					= 	LAYER_POOLING_wire & ((layer0_flag & psum_rearrange_read_addr_reg == 'd3455) | (layer1_flag & psum_rearrange_read_addr_reg == 'd1024)); // 573+574*5=3443


wire psum_acc_done = (layer0_flag & psum_acc_times == 'd12) 	|
                     (layer1_flag & psum_acc_times == 'd6) 		|
                     (layer2_flag & psum_acc_times == 'd15) 	|
                     (layer3_flag & psum_acc_times == 'd4)		|
                     (layer4_flag & psum_acc_times == 'd1);


// layer transition control
assign 	all_iter_fin 				= 	read_out_psum_iter_done;	
assign 	layer_iter_fin				= 	psum_acc_done & psum_acc_fin;
assign	layer_1_former_iter_fin		= 	layer1_flag & psum_acc_times == 'd3  & psum_acc_fin;

assign 	layer_done_fin 				= 	layer_done_count == 'd2; // 2 cycles for layer0 done state, iact SRAM two zero to clear write idx

// PE signal clear 
assign psum_spad_clear 				= LAYER0_LOAD_GLB_wire | LAYER1_LOAD_GLB_wire | LAYER2_LOAD_GLB_wire | LAYER3_LOAD_GLB_wire | LAYER4_LOAD_GLB_wire;
assign iact_write_fin_clear			= LAYER_DONE_wire | layer_1_former_iter_fin | layer_iter_fin | (layer2_flag & psum_acc_pulse & fc_weight_read_batch == 'd4);

assign CG_0_0_psum_spad_clear 			= psum_spad_clear;
assign CG_0_1_psum_spad_clear 			= psum_spad_clear;
assign CG_1_0_psum_spad_clear 			= psum_spad_clear;
assign CG_1_1_psum_spad_clear 			= psum_spad_clear;

assign CG_0_0_iact_write_fin_clear		= iact_write_fin_clear;
assign CG_0_1_iact_write_fin_clear		= iact_write_fin_clear;
assign CG_1_0_iact_write_fin_clear		= iact_write_fin_clear;
assign CG_1_1_iact_write_fin_clear		= iact_write_fin_clear;

assign CG_0_0_weight_write_fin_clear	= LAYER0_CAL_wire | LAYER1_CAL_wire | LAYER2_CAL_wire | LAYER3_CAL_wire | LAYER4_CAL_wire;
assign CG_0_1_weight_write_fin_clear	= LAYER0_CAL_wire | LAYER1_CAL_wire | LAYER2_CAL_wire | LAYER3_CAL_wire | LAYER4_CAL_wire;
assign CG_1_0_weight_write_fin_clear	= LAYER0_CAL_wire | LAYER1_CAL_wire | LAYER2_CAL_wire | LAYER3_CAL_wire | LAYER4_CAL_wire;
assign CG_1_1_weight_write_fin_clear	= LAYER0_CAL_wire | LAYER1_CAL_wire | LAYER2_CAL_wire | LAYER3_CAL_wire | LAYER4_CAL_wire;



assign MEM_read_en	= 	(LAYER_LOAD_IFMAP_wire & ~ifmap_load_fin_reg) | 
						(layer0_flag & all_PE_weight_load_en 	& !GLB_weight_load_end_reg & !GLB_weight_load_end) 	| 
						(layer1_flag & all_PE_weight_load_en 	& !GLB_weight_load_end_reg & !GLB_weight_load_end) 	| 
						(layer2_flag & all_GLB_load_en 	 		& !MEM_fc1_read_done)							|
						(layer3_flag & all_GLB_load_en 	 		& !MEM_fc2_read_done)							|
						(layer4_flag & all_GLB_load_en 	 		& !MEM_fc3_read_done);


// other modules control
assign CG_0_0_cg_en						= cg_en;
assign CG_0_1_cg_en						= cg_en;
assign CG_1_0_cg_en						= cg_en;
assign CG_1_1_cg_en						= cg_en;

assign im2col_enable					= (MEM_read_addr > 'd783 & ~im2col_convert_one_stream_done_reg) & ~(layer1_flag & psum_read_out_oen_channel_read_done);
assign im2col_ifmap_len					= layer0_flag ? 'd783 	: layer1_flag ? 'd143 	: 'd0;
assign im2col_ofmap_size				= layer0_flag ? 'd6 	: layer1_flag ? 'd2 	: 'd0;
assign im2col_next_vector_jump			= layer0_flag ? 'd115 	: layer1_flag ? 'd51 	: 'd0;
assign im2col_next_ifmap_row_jump		= layer0_flag ? 'd111 	: layer1_flag ? 'd47 	: 'd0;
assign im2col_next_weight_row_jump		= layer0_flag ? 'd21 	: layer1_flag ? 'd5 	: 'd0;

assign CSC_encoder_iact_matrix_height	= conv_flag ? 'd4 	: fc_flag ? 'd16 : 'd0;
assign CSC_encoder_iact_matrix_width	= conv_flag ? 'd25 	: fc_flag ? 'd1  : 'd0;
assign CSC_encoder_iact_clear_iact_SRAM = LAYER_POOLING_wire | LAYER2_READ_OUT_PSUM_wire | LAYER3_READ_OUT_PSUM_wire | LAYER4_READ_OUT_PSUM_wire;

assign CSC_encoder_weight_matrix_height	= layer2_flag ? 'd16 : layer3_flag ? 'd20 : layer4_flag ? 'd21 : 'd0;
assign CSC_encoder_weight_matrix_width	= 'd1;	// for fc layer
assign CSC_encoder_weight_clear_iact_SRAM = (psum_rearrange_read_addr_reg == 'd3499) ? 'd1 : 'd0;

assign psum_acc_en						= LAYER_PSUM_ACC_wire;
assign CG_0_0_read_psum_en 				= psum_acc_en;
assign CG_0_1_read_psum_en 				= psum_acc_en;
assign CG_1_0_read_psum_en 				= psum_acc_en;
assign CG_1_1_read_psum_en 				= psum_acc_en;
      
assign CG_0_0_GLB_psum_write_en			= psum_acc_en;
assign CG_0_1_GLB_psum_write_en			= psum_acc_en;
assign CG_1_0_GLB_psum_write_en			= psum_acc_en;
assign CG_1_1_GLB_psum_write_en			= psum_acc_en;


wire GLB_iact_en_sel_0	= GLB_iact_en_sel == 'd0;
wire GLB_iact_en_sel_1	= GLB_iact_en_sel == 'd1;
wire GLB_iact_en_sel_2	= GLB_iact_en_sel == 'd2;
wire GLB_iact_en_sel_3	= GLB_iact_en_sel == 'd3;
wire GLB_iact_en_sel_4	= GLB_iact_en_sel == 'd4;
wire GLB_iact_en_sel_5	= GLB_iact_en_sel == 'd5;
wire GLB_iact_en_sel_6	= GLB_iact_en_sel == 'd6;	
wire GLB_iact_en_sel_7	= GLB_iact_en_sel == 'd7;	
wire GLB_iact_en_sel_8	= GLB_iact_en_sel == 'd8;	
wire GLB_iact_en_sel_9	= GLB_iact_en_sel == 'd9;	
wire GLB_iact_en_sel_10	= GLB_iact_en_sel == 'd10;
wire GLB_iact_en_sel_11	= GLB_iact_en_sel == 'd11;


assign CG_0_0_GLB_iact_0_0_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_0_1_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_0_2_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_1_0_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_1_1_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_1_2_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_2_0_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_2_1_read_addr = GLB_iact_read_addr;
assign CG_0_0_GLB_iact_2_2_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_0_0_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_0_1_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_0_2_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_1_0_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_1_1_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_1_2_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_2_0_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_2_1_read_addr = GLB_iact_read_addr;
assign CG_0_1_GLB_iact_2_2_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_0_0_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_0_1_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_0_2_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_1_0_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_1_1_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_1_2_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_2_0_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_2_1_read_addr = GLB_iact_read_addr;
assign CG_1_0_GLB_iact_2_2_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_0_0_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_0_1_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_0_2_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_1_0_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_1_1_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_1_2_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_2_0_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_2_1_read_addr = GLB_iact_read_addr;
assign CG_1_1_GLB_iact_2_2_read_addr = GLB_iact_read_addr;

assign CG_0_0_GLB_iact_0_0_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_0) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_0);
assign CG_0_0_GLB_iact_0_1_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_1) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_1);
assign CG_0_0_GLB_iact_0_2_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_2) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_2);
assign CG_0_1_GLB_iact_0_0_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_3);
assign CG_0_1_GLB_iact_0_1_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_4);
assign CG_0_1_GLB_iact_0_2_in_en		= (~layer0_flag & GLB_iact_load_channel_0 & GLB_iact_en_sel_5) 	| CSC_encoder_iact_clear_iact_SRAM | (layer0_flag & GLB_iact_en_sel_5);

assign CG_0_0_GLB_iact_1_0_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_0)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_0_GLB_iact_1_1_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_1)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_0_GLB_iact_1_2_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_2)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_1_0_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_1_1_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_1_2_in_en		= (~layer0_flag & GLB_iact_load_channel_1 & GLB_iact_en_sel_5) 	| CSC_encoder_iact_clear_iact_SRAM;
																
assign CG_0_0_GLB_iact_2_0_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_0)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_0_GLB_iact_2_1_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_1)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_0_GLB_iact_2_2_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_2)	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_2_0_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_2_1_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_0_1_GLB_iact_2_2_in_en		= (~layer0_flag & GLB_iact_load_channel_2 & GLB_iact_en_sel_5)	| CSC_encoder_iact_clear_iact_SRAM;
																										   
assign CG_1_0_GLB_iact_0_0_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_0) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_6;
assign CG_1_0_GLB_iact_0_1_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_1) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_7;
assign CG_1_0_GLB_iact_0_2_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_2) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_8;
assign CG_1_1_GLB_iact_0_0_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_9;
assign CG_1_1_GLB_iact_0_1_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_10;
assign CG_1_1_GLB_iact_0_2_in_en		= (~layer0_flag & GLB_iact_load_channel_3 & GLB_iact_en_sel_5) 	| CSC_encoder_iact_clear_iact_SRAM | layer0_flag & GLB_iact_en_sel_11;
																										   
assign CG_1_0_GLB_iact_1_0_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_0) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_0_GLB_iact_1_1_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_1) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_0_GLB_iact_1_2_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_2) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_1_0_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_1_1_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_1_2_in_en		=(~layer0_flag & GLB_iact_load_channel_4 & GLB_iact_en_sel_5) 	| CSC_encoder_iact_clear_iact_SRAM;
															
assign CG_1_0_GLB_iact_2_0_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_0) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_0_GLB_iact_2_1_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_1) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_0_GLB_iact_2_2_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_2) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_2_0_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_3) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_2_1_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_4) 	| CSC_encoder_iact_clear_iact_SRAM;
assign CG_1_1_GLB_iact_2_2_in_en		=(~layer0_flag & GLB_iact_load_channel_5 & GLB_iact_en_sel_5)	| CSC_encoder_iact_clear_iact_SRAM;

assign CG_0_0_GLB_weight_0_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_0);
assign CG_0_0_GLB_weight_1_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_1);
assign CG_0_0_GLB_weight_2_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_2);
assign CG_0_1_GLB_weight_0_in_en	= 'd0;
assign CG_0_1_GLB_weight_1_in_en	= 'd0;
assign CG_0_1_GLB_weight_2_in_en	= 'd0;
assign CG_1_0_GLB_weight_0_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_3);
assign CG_1_0_GLB_weight_1_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_4);
assign CG_1_0_GLB_weight_2_in_en	= weight_broadcast | ((~weight_broadcast) & GLB_weight_load_channel_5);
assign CG_1_1_GLB_weight_0_in_en	= 'd0;
assign CG_1_1_GLB_weight_1_in_en	= 'd0;
assign CG_1_1_GLB_weight_2_in_en	= 'd0;

reg [5:0] psum_depth;
always@(*) begin
	case('d1)
		layer0_flag	: psum_depth = 'd24;
		layer1_flag	: psum_depth = 'd32;
		layer2_flag	: psum_depth = 'd4;
		layer3_flag	: psum_depth = 'd4;
		layer4_flag	: psum_depth = 'd4;
		default		: psum_depth = 'd4;
	endcase
end

assign CG_0_0_PSUM_DEPTH = psum_depth - 'd1;
assign CG_0_1_PSUM_DEPTH = psum_depth - 'd1;
assign CG_1_0_PSUM_DEPTH = psum_depth - 'd1;
assign CG_1_1_PSUM_DEPTH = psum_depth - 'd1;

assign CG_0_0_GLB_psum_0_out_en = (conv_flag & read_out_psum_sel == 'd0) 	| (fc_flag & GLB_psum_read_sel_reg == 'd0);
assign CG_0_0_GLB_psum_1_out_en = (conv_flag & read_out_psum_sel == 'd1) 	| (fc_flag & GLB_psum_read_sel_reg == 'd1);
assign CG_0_0_GLB_psum_2_out_en = (conv_flag & read_out_psum_sel == 'd2) 	| (fc_flag & GLB_psum_read_sel_reg == 'd2);
assign CG_0_1_GLB_psum_0_out_en = (conv_flag & read_out_psum_sel == 'd3) 	| (fc_flag & GLB_psum_read_sel_reg == 'd3);
assign CG_0_1_GLB_psum_1_out_en = (conv_flag & read_out_psum_sel == 'd4) 	| (fc_flag & GLB_psum_read_sel_reg == 'd4);
assign CG_0_1_GLB_psum_2_out_en = (conv_flag & read_out_psum_sel == 'd5) 	| (fc_flag & GLB_psum_read_sel_reg == 'd5);
assign CG_1_0_GLB_psum_0_out_en = (conv_flag & read_out_psum_sel == 'd6) 	| (fc_flag & GLB_psum_read_sel_reg == 'd6);
assign CG_1_0_GLB_psum_1_out_en = (conv_flag & read_out_psum_sel == 'd7) 	| (fc_flag & GLB_psum_read_sel_reg == 'd7);
assign CG_1_0_GLB_psum_2_out_en = (conv_flag & read_out_psum_sel == 'd8) 	| (fc_flag & GLB_psum_read_sel_reg == 'd8);
assign CG_1_1_GLB_psum_0_out_en = (conv_flag & read_out_psum_sel == 'd9) 	| (fc_flag & GLB_psum_read_sel_reg == 'd9);
assign CG_1_1_GLB_psum_1_out_en = (conv_flag & read_out_psum_sel == 'd10) 	| (fc_flag & GLB_psum_read_sel_reg == 'd10);
assign CG_1_1_GLB_psum_2_out_en = (conv_flag & read_out_psum_sel == 'd11)	| (fc_flag & GLB_psum_read_sel_reg == 'd11);


// router control
assign CG_0_0_PE_cluster_iact_data_in_sel		= ~PE_IACT_BROADCAST;
assign CG_0_1_PE_cluster_iact_data_in_sel		= ~PE_IACT_BROADCAST;
assign CG_1_0_PE_cluster_iact_data_in_sel		= ~PE_IACT_BROADCAST;
assign CG_1_1_PE_cluster_iact_data_in_sel		= ~PE_IACT_BROADCAST;

assign CG_0_0_PE_cluster_iact_data_out_sel		= PE_IACT_ROUTER_0;
assign CG_0_1_PE_cluster_iact_data_out_sel		= PE_IACT_ROUTER_0;
assign CG_1_0_PE_cluster_iact_data_out_sel		= PE_IACT_ROUTER_0;
assign CG_1_1_PE_cluster_iact_data_out_sel		= PE_IACT_ROUTER_0;

assign CG_0_0_PE_cluster_psum_data_in_sel		= weight_broadcast ? PE_PSUM_FROM_ROUTER : (layer1_flag ? PE_PSUM_FROM_SOU : PE_PSUM_FROM_SOU);
assign CG_0_1_PE_cluster_psum_data_in_sel		= weight_broadcast ? PE_PSUM_FROM_ROUTER : (layer1_flag ? PE_PSUM_FROM_SOU : PE_PSUM_FROM_SOU);
assign CG_1_0_PE_cluster_psum_data_in_sel		= weight_broadcast ? PE_PSUM_FROM_ROUTER : (layer1_flag ? PE_PSUM_FROM_SOU : PE_PSUM_FROM_SOU);
assign CG_1_1_PE_cluster_psum_data_in_sel		= weight_broadcast ? PE_PSUM_FROM_ROUTER : (layer1_flag ? PE_PSUM_FROM_SOU : PE_PSUM_FROM_SOU);

assign CG_0_0_router_cluster_iact_data_in_sel	= IACT_GLB;
assign CG_0_1_router_cluster_iact_data_in_sel	= IACT_GLB;
assign CG_1_0_router_cluster_iact_data_in_sel	= IACT_GLB;
assign CG_1_1_router_cluster_iact_data_in_sel	= IACT_GLB;
          
assign CG_0_0_router_cluster_iact_data_out_sel	= IACT_UNICAST;
assign CG_0_1_router_cluster_iact_data_out_sel	= IACT_UNICAST;
assign CG_1_0_router_cluster_iact_data_out_sel	= IACT_UNICAST;
assign CG_1_1_router_cluster_iact_data_out_sel	= IACT_UNICAST;
          
assign CG_0_0_router_cluster_weight_data_in_sel	= WEIGHT_GLB;
assign CG_0_1_router_cluster_weight_data_in_sel	= WEIGHT_HORIZ;
assign CG_1_0_router_cluster_weight_data_in_sel	= WEIGHT_GLB;
assign CG_1_1_router_cluster_weight_data_in_sel	= WEIGHT_HORIZ;

assign CG_0_0_router_cluster_weight_data_out_sel= WEIGHT_HOR_MULTICAST;
assign CG_0_1_router_cluster_weight_data_out_sel= WEIGHT_UNICAST;
assign CG_1_0_router_cluster_weight_data_out_sel= WEIGHT_HOR_MULTICAST;
assign CG_1_1_router_cluster_weight_data_out_sel= WEIGHT_UNICAST;
          
assign CG_0_0_router_cluster_psum_data_in_sel	= PSUM_FROM_GLB;
assign CG_0_1_router_cluster_psum_data_in_sel	= PSUM_FROM_GLB;
assign CG_1_0_router_cluster_psum_data_in_sel	= PSUM_FROM_GLB;
assign CG_1_1_router_cluster_psum_data_in_sel	= PSUM_FROM_GLB;
          
assign CG_0_0_router_cluster_psum_data_out_sel	= PSUM_TO_PE;
assign CG_0_1_router_cluster_psum_data_out_sel	= PSUM_TO_PE;
assign CG_1_0_router_cluster_psum_data_out_sel	= PSUM_TO_PE;
assign CG_1_1_router_cluster_psum_data_out_sel	= PSUM_TO_PE;

assign CG_0_0_psum_SRAM_Bank_0_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd0);
assign CG_0_0_psum_SRAM_Bank_1_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd1);
assign CG_0_0_psum_SRAM_Bank_2_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd2);
assign CG_0_1_psum_SRAM_Bank_0_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd3);
assign CG_0_1_psum_SRAM_Bank_1_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd4);
assign CG_0_1_psum_SRAM_Bank_2_read_out_en	= read_out_psum_en_conv | (read_out_psum_en_fc & GLB_psum_read_sel == 'd5);
assign CG_1_0_psum_SRAM_Bank_0_read_out_en	= read_out_psum_en_conv;
assign CG_1_0_psum_SRAM_Bank_1_read_out_en	= read_out_psum_en_conv;
assign CG_1_0_psum_SRAM_Bank_2_read_out_en	= read_out_psum_en_conv;
assign CG_1_1_psum_SRAM_Bank_0_read_out_en	= read_out_psum_en_conv;
assign CG_1_1_psum_SRAM_Bank_1_read_out_en	= read_out_psum_en_conv;
assign CG_1_1_psum_SRAM_Bank_2_read_out_en	= read_out_psum_en_conv;

assign ReLU_en		=	(LAYER_READ_OUT_PSUM_wire & conv_flag) | fc_flag;
assign pool_enable	=	LAYER_POOLING_wire & ~pool_pulse;
assign softmax_en	= 	LAYER4_READ_OUT_PSUM_reg;

assign	CG_0_0_GLB_psum_0_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd0) ? (CG_0_0_GLB_psum_0_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_0_GLB_psum_0_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_0_GLB_psum_0_read_addr_reg + first_GLB_psum_read_out_adjust);
assign	CG_0_0_GLB_psum_1_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd1) ? (CG_0_0_GLB_psum_1_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_0_GLB_psum_1_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_0_GLB_psum_1_read_addr_reg + first_GLB_psum_read_out_adjust);
assign	CG_0_0_GLB_psum_2_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd2) ? (CG_0_0_GLB_psum_2_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_0_GLB_psum_2_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_0_GLB_psum_2_read_addr_reg + first_GLB_psum_read_out_adjust);
assign	CG_0_1_GLB_psum_0_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd3) ? (CG_0_1_GLB_psum_0_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_1_GLB_psum_0_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_1_GLB_psum_0_read_addr_reg + first_GLB_psum_read_out_adjust);
assign	CG_0_1_GLB_psum_1_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd4) ? (CG_0_1_GLB_psum_1_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_1_GLB_psum_1_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_1_GLB_psum_1_read_addr_reg + first_GLB_psum_read_out_adjust);
assign	CG_0_1_GLB_psum_2_read_addr = ((layer2_flag | layer3_flag) & GLB_psum_read_sel == 'd5) ? (CG_0_1_GLB_psum_2_read_addr_reg + 'd20*GLB_psum_read_channel + 'd4*GLB_psum_read_batch)  : (read_out_psum_later_flag ? CG_0_1_GLB_psum_2_read_addr_reg + first_GLB_psum_read_out_adjust + 'd96 	: CG_0_1_GLB_psum_2_read_addr_reg + first_GLB_psum_read_out_adjust);

assign	CG_1_0_GLB_psum_0_read_addr = CG_1_0_GLB_psum_0_read_addr_reg + (read_out_psum_channel<<'d2);
assign	CG_1_0_GLB_psum_1_read_addr = CG_1_0_GLB_psum_1_read_addr_reg + (read_out_psum_channel<<'d2);
assign	CG_1_0_GLB_psum_2_read_addr = CG_1_0_GLB_psum_2_read_addr_reg + (read_out_psum_channel<<'d2);
assign	CG_1_1_GLB_psum_0_read_addr = CG_1_1_GLB_psum_0_read_addr_reg + (read_out_psum_channel<<'d2);
assign	CG_1_1_GLB_psum_1_read_addr = CG_1_1_GLB_psum_1_read_addr_reg + (read_out_psum_channel<<'d2);
assign	CG_1_1_GLB_psum_2_read_addr = CG_1_1_GLB_psum_2_read_addr_reg + (read_out_psum_channel<<'d2);


// next state logic
always@(*) begin
	case(state)
		IDLE 				: next_state = system_enable 				? LAYER_LOAD_IFMAP 		: IDLE;
		LAYER_LOAD_IFMAP 	: next_state = ifmap_load_fin 				? LAYER_LOAD_GLB 		: LAYER_LOAD_IFMAP;
		LAYER_LOAD_GLB		: next_state = ~all_GLB_load_en 			? LAYER_LOAD_PE 		: LAYER_LOAD_GLB;
		LAYER_LOAD_PE		: next_state = ~all_PE_weight_load_en 		? LAYER_CAL 			: LAYER_LOAD_PE;
		LAYER_CAL 			: next_state = all_cal_fin 					? LAYER_PSUM_ACC 		: LAYER_CAL;
		LAYER_PSUM_ACC 		: next_state = layer_iter_fin				? LAYER_READ_OUT_PSUM	: (psum_acc_fin 	? LAYER_LOAD_GLB 	: LAYER_PSUM_ACC);
		LAYER_READ_OUT_PSUM	: next_state = all_GLB_psum_read_out_done 	? (conv_flag 			? LAYER_POOLING 	: LAYER_DONE)		: LAYER_READ_OUT_PSUM;
		LAYER_POOLING		: next_state = pool_fin 					? LAYER_DONE			: LAYER_POOLING;
		LAYER_DONE			: next_state = layer4_flag 					? DONE 					: (layer_done_fin 	? LAYER_LOAD_GLB	: LAYER_DONE); 
		DONE				: next_state = DONE;
		default				: next_state = IDLE;
	endcase
end



// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
// FSM
always@(posedge clock) begin
	if(reset) begin
		state <= IDLE;
	end
	else begin
		state <= next_state;
	end
end


always@(posedge clock) begin
	if(reset) begin
		fc_channel_acc_count <= 'd0;
	end
	else if(psum_SRAM_out_acc_en_dly2) begin
		fc_channel_acc_count <= (fc_channel_acc_count == 'd11) ? 'd0 : fc_channel_acc_count + 'd1;
	end
end


always@(posedge clock) begin
	if(reset) begin
		psum_SRAM_out_acc_en_dly0	<= 'd0;
		psum_SRAM_out_acc_en_dly1	<= 'd0;
		psum_SRAM_out_acc_en_dly2	<= 'd0;
	end
	else begin
		psum_SRAM_out_acc_en_dly0	<= psum_SRAM_out_acc_en;
		psum_SRAM_out_acc_en_dly1	<= psum_SRAM_out_acc_en_dly0;
		psum_SRAM_out_acc_en_dly2	<= psum_SRAM_out_acc_en_dly1;
	end
end


// read out psum addr process
always@(posedge clock) begin
	if(reset) begin
		read_out_psum_count <= 'd0;
	end
	else if(LAYER0_READ_OUT_PSUM_wire | LAYER1_READ_OUT_PSUM_wire) begin
		read_out_psum_count <= (read_out_psum_count != 'd3) ? (read_out_psum_count + 'd1) : 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		read_out_psum_sel <= 'd0;
	end
	else if(conv_flag) begin
		if(read_out_psum_count == 'd3) begin
			read_out_psum_sel <= ((read_out_psum_sel == read_out_psum_sets) | (read_out_psum_sel == 'd3 & read_out_psum_iter == 'd2 & layer1_flag)) ? 'd0 : (read_out_psum_sel + 'd1);
		end
	end
	else if(fc_flag) begin
		if(GLB_psum_read_channel_done & GLB_psum_read_addr_reg_done) begin
			read_out_psum_sel <= GLB_psum_read_sel_done ? 'd0 : (read_out_psum_sel + 'd1); 
		end
	end
end

always@(posedge clock) begin
	if(reset) begin
		read_out_psum_iter <= 'd0;
	end
	else if(read_out_psum_former_fin) begin
		read_out_psum_iter <= 'd0;
	end
	else if(read_out_psum_count == 'd3 & (read_out_psum_sel == read_out_psum_sets)) begin
		read_out_psum_iter <= (read_out_psum_iter == read_out_psum_iters) ? 'd0 : (read_out_psum_iter + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		read_out_psum_channel <= 'd0;
	end
	else if(read_out_psum_iter_done) begin
		read_out_psum_channel <= (~read_out_psum_channel_done) ? (read_out_psum_channel + 'd1) : 'd0;
	end
end



always @(posedge clock) begin
    if(reset) begin
		GLB_psum_read_channel <= 'd0;
    end
	else if(LAYER2_READ_OUT_PSUM_wire & GLB_psum_read_addr_reg_done) begin
		GLB_psum_read_channel <= GLB_psum_read_channel_done ? 'd0 : (GLB_psum_read_channel + 'd1); 
	end
end

always @(posedge clock) begin
    if(reset) begin
		GLB_psum_read_batch <= 'd0;
    end
	else if(GLB_psum_read_sel_done & GLB_psum_read_channel_done & GLB_psum_read_addr_reg_done) begin
		GLB_psum_read_batch <= GLB_psum_read_batch_done ? 'd0 : (GLB_psum_read_batch + 'd1); 
	end
end

always @(posedge clock) begin
    if(reset) begin
		GLB_psum_read_sel <= 'd0;
    end
	else if(GLB_psum_read_channel_done & GLB_psum_read_addr_reg_done) begin
		GLB_psum_read_sel <= GLB_psum_read_sel_done ? 'd0 : (GLB_psum_read_sel + 'd1); 
	end
end

always @(posedge clock) begin
    if(reset) begin
		GLB_psum_read_sel_reg <= 'd0;
    end
	else begin
		GLB_psum_read_sel_reg <= GLB_psum_read_sel;
	end
end


// read psum addr to acc
always @(posedge clock) begin
    if(reset) begin
        CG_0_0_GLB_psum_0_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= 'd1;
		end
		else if(read_out_psum_count == 'd3 & CG_1_1_GLB_psum_2_out_en & layer0_flag) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= CG_0_0_GLB_psum_0_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_0_out_en) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_0_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= 'd1;
		end
		else if(LAYER_DONE_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & (CG_0_1_GLB_psum_2_out_en | (read_out_psum_iter == 'd2 & CG_0_1_GLB_psum_0_out_en))) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= CG_0_0_GLB_psum_0_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_0_out_en) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd2) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_0_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_0_read_addr_reg <= (CG_0_0_GLB_psum_0_read_addr_reg == 'd3) ? 'd0 : (CG_0_0_GLB_psum_0_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_0_0_GLB_psum_1_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_0_out_en) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= CG_0_0_GLB_psum_1_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_1_out_en) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_1_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_0_out_en) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= CG_0_0_GLB_psum_1_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_1_out_en) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd2) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_1_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_1_read_addr_reg <= (CG_0_0_GLB_psum_1_read_addr_reg == 'd3) ? 'd0 : (CG_0_0_GLB_psum_1_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_0_0_GLB_psum_2_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_1_out_en) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= CG_0_0_GLB_psum_2_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_2_out_en) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_2_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_1_out_en) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= CG_0_0_GLB_psum_2_read_addr_reg + 'd1;
		end
		else if(CG_0_0_GLB_psum_2_out_en) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd2) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_0_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_0_0_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_0_0_GLB_psum_2_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_0_GLB_psum_2_read_addr_reg <= (CG_0_0_GLB_psum_2_read_addr_reg == 'd3) ? 'd0 : (CG_0_0_GLB_psum_2_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_0_1_GLB_psum_0_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_2_out_en) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= CG_0_1_GLB_psum_0_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_0_out_en) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_0_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_0_GLB_psum_2_out_en) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= CG_0_1_GLB_psum_0_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_0_out_en) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd2) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_0_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_0_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_0_read_addr_reg <= (CG_0_1_GLB_psum_0_read_addr_reg == 'd3) ? 'd0 : (CG_0_1_GLB_psum_0_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_0_1_GLB_psum_1_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_1_GLB_psum_0_out_en) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= CG_0_1_GLB_psum_1_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_1_out_en) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_1_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_1_GLB_psum_0_out_en & ~read_out_psum_iter_done) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= CG_0_1_GLB_psum_1_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_1_out_en) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd1) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_1_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_1_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_1_read_addr_reg <= (CG_0_1_GLB_psum_1_read_addr_reg == 'd3) ? 'd0 : (CG_0_1_GLB_psum_1_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_0_1_GLB_psum_2_read_addr_reg <= 'd0;
    end
	else if(layer0_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_1_GLB_psum_1_out_en) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= CG_0_1_GLB_psum_2_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_2_out_en) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER0_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER0_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_2_read_addr_reg;
		end
	end
	else if(layer1_flag) begin
		if(layer_iter_fin_pulse) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= 'd0;
		end
		else if(read_out_psum_count == 'd3 & CG_0_1_GLB_psum_1_out_en) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= CG_0_1_GLB_psum_2_read_addr_reg + 'd1;
		end
		else if(CG_0_1_GLB_psum_2_out_en) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? (read_out_psum_iter == 'd1) ? 'd0 : ((read_out_psum_iter+'d1) * psum_depth) : (CG_0_1_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER1_PSUM_ACC_wire) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_0_1_GLB_psum_2_read_addr_reg + 'd1);
		end
		else if(LAYER1_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_0_1_GLB_psum_2_read_addr_reg;
		end
	end
	else if(fc_flag) begin
		if(LAYER_READ_OUT_PSUM_wire) begin
			CG_0_1_GLB_psum_2_read_addr_reg <= (CG_0_1_GLB_psum_2_read_addr_reg == 'd3) ? 'd0 : (CG_0_1_GLB_psum_2_read_addr_reg + 'd1);
		end
	end
end

always @(posedge clock) begin
    if(reset) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_0_1_GLB_psum_2_out_en) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= CG_1_0_GLB_psum_0_read_addr_reg + 'd1;
    end
    else if(CG_1_0_GLB_psum_0_out_en) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= (CG_1_0_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_0_GLB_psum_0_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= (CG_1_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_1_0_GLB_psum_0_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_0_GLB_psum_0_read_addr_reg <= (CG_1_0_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_1_0_GLB_psum_0_read_addr_reg;
    end
end

always @(posedge clock) begin
    if(reset) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_1_0_GLB_psum_0_out_en) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= CG_1_0_GLB_psum_1_read_addr_reg + 'd1;
    end
    else if(CG_1_0_GLB_psum_1_out_en) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= (CG_1_0_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_0_GLB_psum_1_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= (CG_1_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_1_0_GLB_psum_1_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_0_GLB_psum_1_read_addr_reg <= (CG_1_0_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_1_0_GLB_psum_1_read_addr_reg;
    end
end


always @(posedge clock) begin
    if(reset) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_1_0_GLB_psum_1_out_en) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= CG_1_0_GLB_psum_2_read_addr_reg + 'd1;
    end
    else if(CG_1_0_GLB_psum_2_out_en) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= (CG_1_0_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_0_GLB_psum_2_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= (CG_1_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_1_0_GLB_psum_2_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_0_GLB_psum_2_read_addr_reg <= (CG_1_0_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_1_0_GLB_psum_2_read_addr_reg;
    end
end

always @(posedge clock) begin
    if(reset) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_1_0_GLB_psum_2_out_en) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= CG_1_1_GLB_psum_0_read_addr_reg + 'd1;
    end
    else if(CG_1_1_GLB_psum_0_out_en) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= (CG_1_1_GLB_psum_0_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_1_GLB_psum_0_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= (CG_1_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : (CG_1_1_GLB_psum_0_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_1_GLB_psum_0_read_addr_reg <= (CG_1_1_GLB_psum_0_read_addr_reg == 'd288) ? 'd0 : CG_1_1_GLB_psum_0_read_addr_reg;
    end
end

always @(posedge clock) begin
    if(reset) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_1_1_GLB_psum_0_out_en) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= CG_1_1_GLB_psum_1_read_addr_reg + 'd1;
    end
    else if(CG_1_1_GLB_psum_1_out_en) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= (CG_1_1_GLB_psum_1_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_1_GLB_psum_1_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= (CG_1_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : (CG_1_1_GLB_psum_1_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_1_GLB_psum_1_read_addr_reg <= (CG_1_1_GLB_psum_1_read_addr_reg == 'd288) ? 'd0 : CG_1_1_GLB_psum_1_read_addr_reg;
    end
end

always @(posedge clock) begin
    if(reset) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= 'd0;
    end
    else if(layer_iter_fin_pulse) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= 'd0;
    end
	else if(read_out_psum_count == 'd3 & CG_1_1_GLB_psum_1_out_en) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= CG_1_1_GLB_psum_2_read_addr_reg + 'd1;
    end
    else if(CG_1_1_GLB_psum_2_out_en) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= (CG_1_1_GLB_psum_2_read_addr_reg[1:0] == 2'b00) ? ((read_out_psum_iter+'d1) * psum_depth) : (CG_1_1_GLB_psum_2_read_addr_reg + 'd1);
    end
    else if(LAYER_PSUM_ACC_wire & conv_flag) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= (CG_1_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : (CG_1_1_GLB_psum_2_read_addr_reg + 'd1);
    end
	else if(LAYER0_READ_OUT_PSUM_wire) begin
        CG_1_1_GLB_psum_2_read_addr_reg <= (CG_1_1_GLB_psum_2_read_addr_reg == 'd288) ? 'd0 : CG_1_1_GLB_psum_2_read_addr_reg;
    end
end


always@(posedge clock) begin
	if(reset) begin
		GLB_iact_read_addr <= 'd0;
	end
	else if(psum_acc_pulse) begin
		GLB_iact_read_addr <= GLB_iact_read_addr + 'd1;
	end
	else if(LAYER_DONE_wire | layer_1_former_iter_fin) begin
		GLB_iact_read_addr <= 'd0;
	end
end


// read iact SRAM addr process
always@(posedge clock) begin
	if(reset) begin
		GLB_iact_en_sel <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		GLB_iact_en_sel <= 'd0;
	end
	else if(layer0_flag) begin
		if(im2col_convert_one_stream_done_reg & CSC_encoder_iact_one_vector_done) begin
			GLB_iact_en_sel <= 'd31;
		end
		else if(CSC_encoder_iact_one_vector_done) begin
			GLB_iact_en_sel <= (GLB_iact_en_sel != 'd11) ? (GLB_iact_en_sel + 'd1) : 'd0;
		end
	end
	else if(layer1_flag) begin
		if((im2col_read_psum_addr == 'd143) & psum_read_out_channel == 'd5 & CSC_encoder_iact_one_vector_done) begin
			GLB_iact_en_sel <= 'd31;
		end
		else if(CSC_encoder_iact_one_vector_done) begin
			GLB_iact_en_sel <= ((GLB_iact_en_sel == 'd5) | (GLB_iact_en_sel == 'd3 & GLB_iact_load_batch == 'd2)) ? 'd0 : (GLB_iact_en_sel + 'd1);
		end
	end
	else if(layer2_flag) begin
		if(weight_addr_end | weight_data_end) begin
			GLB_iact_en_sel <= (GLB_iact_en_sel == 'd5) ? 'd0 : (GLB_iact_en_sel + 'd1);
		end
	end
	else if(layer3_flag) begin
		if(GLB_iact_load_batch == 'd3 & GLB_iact_en_sel == 'd2 & (weight_addr_end | weight_data_end)) begin
			GLB_iact_en_sel <= 'd0;
		end
		else if(weight_addr_end | weight_data_end) begin
			GLB_iact_en_sel <= (GLB_iact_en_sel == 'd5) ? 'd0 : (GLB_iact_en_sel + 'd1);
		end
	end
	else if(layer4_flag) begin
		if(weight_addr_end | weight_data_end) begin
			GLB_iact_en_sel <= (GLB_iact_en_sel == 'd2) ? 'd0 : (GLB_iact_en_sel + 'd1);
		end
	end
end

always@(posedge clock) begin
	if(reset) begin
		GLB_iact_load_batch <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		GLB_iact_load_batch <= 'd0;
	end
	else if(layer1_flag) begin
		if(GLB_iact_en_sel == 'd5 & CSC_encoder_iact_one_vector_done) begin
			GLB_iact_load_batch <= GLB_iact_load_batch + 'd1;
		end
		else if(GLB_iact_load_batch == 'd2 & GLB_iact_en_sel == 'd3 & CSC_encoder_iact_one_vector_done) begin
			GLB_iact_load_batch <= 'd0;
		end
	end
	else if(layer2_flag) begin
		if(GLB_iact_en_sel == 'd5 & (weight_addr_end | weight_data_end)) begin
			GLB_iact_load_batch <= (GLB_iact_load_batch == 'd4) ? 'd0 : GLB_iact_load_batch + 'd1;
		end
	end
	else if(layer3_flag) begin
		if((GLB_iact_load_batch == 'd3 & GLB_iact_en_sel == 'd2) & (weight_addr_end | weight_data_end)) begin	// 21 sets, 6*3+3
			GLB_iact_load_batch <= 'd0;
		end
		else if(GLB_iact_en_sel == 'd5 & (weight_addr_end | weight_data_end)) begin
			GLB_iact_load_batch <= (GLB_iact_load_batch == 'd4) ? 'd0 : GLB_iact_load_batch + 'd1;
		end
	end
	else if(layer4_flag) begin
		GLB_iact_load_batch <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		GLB_iact_load_channel <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		GLB_iact_load_channel <= 'd0;
	end
	else if(layer1_flag & GLB_iact_load_batch == 'd2 & GLB_iact_en_sel == 'd3 & CSC_encoder_iact_one_vector_done) begin	// 16 = 6*2 + 4
		GLB_iact_load_channel <= GLB_iact_load_channel + 'd1;
	end
	else if(layer2_flag & GLB_iact_load_batch == 'd4 & GLB_iact_en_sel == 'd5 & (weight_addr_end | weight_data_end)) begin
		GLB_iact_load_channel <= (GLB_iact_load_channel == 'd5 | (GLB_iact_load_channel == 'd3 & GLB_iact_load_iter == 'd2)) ? 'd0 : (GLB_iact_load_channel + 'd1);
	end
	else if(layer3_flag & GLB_iact_load_batch == 'd3 & GLB_iact_en_sel == 'd2 & (weight_addr_end | weight_data_end)) begin
		GLB_iact_load_channel <= (GLB_iact_load_channel == 'd5) ? 'd0 : (GLB_iact_load_channel + 'd1);
	end
	else if(layer4_flag & GLB_iact_load_batch == 'd0 & GLB_iact_en_sel == 'd2 & (weight_addr_end | weight_data_end)) begin
		GLB_iact_load_channel <= (GLB_iact_load_channel == 'd3) ? 'd0 : (GLB_iact_load_channel + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		GLB_iact_load_iter <= 'd0;
	end
	else if(layer2_flag & GLB_iact_load_iter == 'd2 & GLB_iact_load_channel == 'd3 & GLB_iact_load_batch == 'd4 & GLB_iact_en_sel == 'd5 & (weight_addr_end | weight_data_end)) begin
		GLB_iact_load_iter <= 'd0;
	end
	else if(layer2_flag & GLB_iact_load_channel == 'd5 & GLB_iact_load_batch == 'd4 & GLB_iact_en_sel == 'd5 & (weight_addr_end | weight_data_end)) begin
		GLB_iact_load_iter <= GLB_iact_load_iter + 'd1;	// for layer2 ,ifmap channels=16 = 6*2+4, iter=3 
	end
end


// read weight addr process
always@(posedge clock) begin
	if(reset) begin
		GLB_weight_load_channel <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		GLB_weight_load_channel <= 'd0;
	end
	else if(((weight_addr_end | weight_data_end) & layer1_flag) | (csc_addr_end  & (layer2_flag | layer3_flag))) begin	// 16 = 6*2 + 4
		GLB_weight_load_channel <= (GLB_weight_load_channel == 'd5) ? 'd0 : (GLB_weight_load_channel + 'd1);
	end
	else if(((weight_addr_end | weight_data_end) & layer1_flag) | (csc_addr_end  & layer4_flag)) begin	// 16 = 6*2 + 4
		GLB_weight_load_channel <= (GLB_weight_load_channel == 'd3) ? 'd0 : (GLB_weight_load_channel + 'd1);
	end
end



always@(posedge clock) begin
	if(reset) begin
		psum_acc_times <= 'd0;
	end
	else if(psum_acc_pulse) begin
		psum_acc_times <= psum_acc_times + 'd1;
	end
	else if(LAYER_DONE_wire) begin
		psum_acc_times <= 'd0;
	end
end


always@(posedge clock) begin
	if(reset) begin
		im2col_convert_one_stream_done_reg <= 'd0;
	end
	else if(im2col_convert_one_stream_done & layer0_flag) begin
		im2col_convert_one_stream_done_reg <= 'd1;
	end
	else if(im2col_convert_one_stream_done & layer1_flag & psum_read_out_channel == 'd5) begin
		im2col_convert_one_stream_done_reg <= 'd1;
	end
	else if(layer_done_fin) begin
		im2col_convert_one_stream_done_reg <= 'd0;
	end
end


// For ensure the cal after SRAM ready
// bandwidth bottleneck
always@(posedge clock) begin
	if(reset) begin
		first_iter_read_GLB_iact <= 'd0;
	end
	else if(GLB_iact_en_sel == 'd11) begin
		first_iter_read_GLB_iact <= 'd1;
	end
	else if(LAYER_DONE_wire) begin
		first_iter_read_GLB_iact <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		second_iter_read_GLB_iact <= 'd0;
	end
	else if(GLB_iact_en_sel == 'd10 & first_iter_read_GLB_iact) begin
		second_iter_read_GLB_iact <= 'd1;
	end
	else if(LAYER_DONE_wire) begin
		second_iter_read_GLB_iact <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		third_iter_read_GLB_iact <= 'd0;
	end
	else if(GLB_iact_en_sel == 'd9 & second_iter_read_GLB_iact) begin
		third_iter_read_GLB_iact <= 'd1;
	end
	else if(LAYER_DONE_wire) begin
		third_iter_read_GLB_iact <= 'd0;
	end
end


always@(posedge clock) begin
	if(reset) begin
		CG_0_0_src_GLB_load_fin <= 'd0;
		CG_0_1_src_GLB_load_fin <= 'd0;
		CG_1_0_src_GLB_load_fin <= 'd0;
		CG_1_1_src_GLB_load_fin <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		CG_0_0_src_GLB_load_fin <= 'd0;
		CG_0_1_src_GLB_load_fin <= 'd0;
		CG_1_0_src_GLB_load_fin <= 'd0;
		CG_1_1_src_GLB_load_fin <= 'd0;
	end
	else if(load_PE_start) begin
		CG_0_0_src_GLB_load_fin <= 'd1;
		CG_0_1_src_GLB_load_fin <= 'd1;
		CG_1_0_src_GLB_load_fin <= 'd1;
		CG_1_1_src_GLB_load_fin <= 'd1;
	end
end


always@(posedge clock) begin
	if(reset) begin
		CG_0_0_GLB_psum_0_write_addr	<= 'd0;
		CG_0_0_GLB_psum_1_write_addr	<= 'd0;
		CG_0_0_GLB_psum_2_write_addr	<= 'd0;
		CG_0_1_GLB_psum_0_write_addr	<= 'd0;
		CG_0_1_GLB_psum_1_write_addr	<= 'd0;
		CG_0_1_GLB_psum_2_write_addr	<= 'd0;
		CG_1_0_GLB_psum_0_write_addr	<= 'd0;
		CG_1_0_GLB_psum_1_write_addr	<= 'd0;
		CG_1_0_GLB_psum_2_write_addr	<= 'd0;
		CG_1_1_GLB_psum_0_write_addr	<= 'd0;
		CG_1_1_GLB_psum_1_write_addr	<= 'd0;
		CG_1_1_GLB_psum_2_write_addr	<= 'd0;
	end
	else if(LAYER_PSUM_ACC_wire) begin
		CG_0_0_GLB_psum_0_write_addr	<= CG_0_0_GLB_psum_0_write_addr	+ 'd1;
		CG_0_0_GLB_psum_1_write_addr	<= CG_0_0_GLB_psum_1_write_addr + 'd1;
		CG_0_0_GLB_psum_2_write_addr	<= CG_0_0_GLB_psum_2_write_addr + 'd1;
		CG_0_1_GLB_psum_0_write_addr	<= CG_0_1_GLB_psum_0_write_addr + 'd1;
		CG_0_1_GLB_psum_1_write_addr	<= CG_0_1_GLB_psum_1_write_addr + 'd1;
		CG_0_1_GLB_psum_2_write_addr	<= CG_0_1_GLB_psum_2_write_addr + 'd1;
		CG_1_0_GLB_psum_0_write_addr	<= CG_1_0_GLB_psum_0_write_addr + 'd1;
		CG_1_0_GLB_psum_1_write_addr	<= CG_1_0_GLB_psum_1_write_addr + 'd1;
		CG_1_0_GLB_psum_2_write_addr	<= CG_1_0_GLB_psum_2_write_addr + 'd1;
		CG_1_1_GLB_psum_0_write_addr	<= CG_1_1_GLB_psum_0_write_addr + 'd1;
		CG_1_1_GLB_psum_1_write_addr	<= CG_1_1_GLB_psum_1_write_addr + 'd1;
		CG_1_1_GLB_psum_2_write_addr	<= CG_1_1_GLB_psum_2_write_addr + 'd1;
	end
	else if(LAYER_DONE_wire | (fc_weight_read_batch == 'd4 & psum_acc_pulse)) begin
		CG_0_0_GLB_psum_0_write_addr	<= 'd0;
		CG_0_0_GLB_psum_1_write_addr	<= 'd0;
		CG_0_0_GLB_psum_2_write_addr	<= 'd0;
		CG_0_1_GLB_psum_0_write_addr	<= 'd0;
		CG_0_1_GLB_psum_1_write_addr	<= 'd0;
		CG_0_1_GLB_psum_2_write_addr	<= 'd0;
		CG_1_0_GLB_psum_0_write_addr	<= 'd0;
		CG_1_0_GLB_psum_1_write_addr	<= 'd0;
		CG_1_0_GLB_psum_2_write_addr	<= 'd0;
		CG_1_1_GLB_psum_0_write_addr	<= 'd0;
		CG_1_1_GLB_psum_1_write_addr	<= 'd0;
		CG_1_1_GLB_psum_2_write_addr	<= 'd0;
	end
end


always@(posedge clock) begin
	if(reset) begin
		layer_done_count <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		layer_done_count <= (layer_done_count == 'd2) ? 'd0 : (layer_done_count + 'd1);
	end
end




// one shot pulse generator
always@(posedge clock) begin
	if(reset) begin
		layer_iter_fin_reg		<= 'd0;
		psum_acc_state_reg 		<= 'd0;
		pool_state_reg			<= 'd0;
		pool_pulse_reg			<= 'd0;
	end
	else begin
		layer_iter_fin_reg		<= layer_iter_fin;
		psum_acc_state_reg 		<= LAYER_PSUM_ACC_wire;
		pool_state_reg			<= pool_pulse_wire;
		pool_pulse_reg			<= pool_pulse;
	end
end



always@(posedge clock) begin
	if(reset) begin
		pool_row_count <= 'd0;
	end
	else if(pool_fin) begin
		pool_row_count <= 'd0;
	end
	else if(LAYER_POOLING_wire & ~pool_pulse) begin
		pool_row_count <= pool_row_count + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		pool_col_count <= 'd0;
	end
	else if(pool_fin) begin
		pool_col_count <= 'd0;
	end
	else if(pool_row_done) begin
		pool_col_count <= pool_col_count + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		pool_ofmap_row_count <= 'd0;
	end
	else if(pool_fin) begin
		pool_ofmap_row_count <= 'd0;
	end
	else if(pool_row_done & pool_col_done) begin
		pool_ofmap_row_count <= (pool_ofmap_row_count == pool_ofmap_rows) ? 'd0 : (pool_ofmap_row_count + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		psum_rearrange_write_addr <= 'd4095;
	end
	else if(psum_acc_pulse | pool_pulse) begin
		psum_rearrange_write_addr <= 'd0;
	end
	else if(psum_rearrange_write_en) begin
		psum_rearrange_write_addr <= psum_rearrange_write_addr + 'd1;
	end
end

// advance one cycle for BRAM read
always@(*) begin
	if(pool_pulse) begin
		psum_rearrange_read_addr = 'd0;
	end
	else if(LAYER0_POOLING_wire) begin
		if(pool_row_count & pool_col_count & pool_ofmap_row_done) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd1;
		end
		else if(pool_row_count & pool_col_count) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg - 'd23; // -24+1
		end
		else if(pool_row_count) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd23;
		end
		else begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd1;
		end
	end
	else if(LAYER1_POOLING_wire) begin
		if(pool_row_count & pool_col_count & pool_ofmap_row_done) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd1;
		end
		else if(pool_row_count & pool_col_count) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg - 'd7; // -24+1
		end
		else if(pool_row_count) begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd7;
		end
		else begin
			psum_rearrange_read_addr = psum_rearrange_read_addr_reg + 'd1;
		end
	end
	else if(LAYER_DONE_wire) begin
		psum_rearrange_read_addr = 'd0;
	end
	else if(layer0_flag) begin
		psum_rearrange_read_addr = im2col_read_psum_addr;
	end
	else if(layer1_flag) begin
		psum_rearrange_read_addr = im2col_read_psum_addr + psum_read_out_channel*'d144;
	end
	else if(layer2_flag & (csc_en | csc_en_reg) & ~psum_rearrange_read_addr_dly_3_cycles & fc_weight_read_batch == 'd0) begin // delay for the additive 0 of CSC encoder final output 
		psum_rearrange_read_addr = (psum_rearrange_read_addr_reg == 'd255) ? 'd3499 : (psum_rearrange_read_addr_reg == 'd3499) ? (fc_psum_rearrange_read_channel == 'd0) ? 'd0 : 'd3499 : psum_rearrange_read_addr_reg + 'd1;
	end
	else if(layer3_flag & (csc_en | csc_en_reg) & ~psum_rearrange_read_addr_dly_3_cycles) begin // delay for the additive 0 of CSC encoder final output 
		psum_rearrange_read_addr = (psum_rearrange_read_addr_reg == 'd119) ? 'd0 : psum_rearrange_read_addr_reg + 'd1;
	end
	else if(layer4_flag & (csc_en | csc_en_reg) & ~psum_rearrange_read_addr_dly_3_cycles) begin // delay for the additive 0 of CSC encoder final output 
		psum_rearrange_read_addr = (psum_rearrange_read_addr_reg == 'd83) ? 'd0 : psum_rearrange_read_addr_reg + 'd1;
	end
	else begin
		psum_rearrange_read_addr = psum_rearrange_read_addr_reg;
	end
end

always@(posedge clock) begin
	if(reset) begin
		psum_rearrange_read_addr_reg <= 'd0;
	end
	else begin
		psum_rearrange_read_addr_reg <= psum_rearrange_read_addr;
	end
end


always@(posedge clock) begin
	if(reset) begin
		fc_weight_read_batch <= 'd0;
	end
	else if(layer2_flag & psum_acc_pulse)begin
		fc_weight_read_batch <= (fc_weight_read_batch == 'd4) ? 'd0 : (fc_weight_read_batch + 'd1);
	end
	else if(layer3_flag & psum_acc_pulse)begin
		fc_weight_read_batch <= (fc_weight_read_batch == 'd3) ? 'd0 : (fc_weight_read_batch + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		fc_psum_rearrange_read_count <= 'd0;
	end
	else if(layer2_flag & (csc_en | csc_en_reg) & ~CSC_encoder_iact_one_vector_done & fc_weight_read_batch == 'd0)begin
		fc_psum_rearrange_read_count <= (fc_psum_rearrange_read_count == 'd17) ? 'd0 : (fc_psum_rearrange_read_count + 'd1);
	end
	else if(layer3_flag & (csc_en | csc_en_reg) & ~CSC_encoder_iact_one_vector_done)begin
		fc_psum_rearrange_read_count <= (fc_psum_rearrange_read_count == 'd21) ? 'd0 : (fc_psum_rearrange_read_count + 'd1);
	end
	else if(layer4_flag & (csc_en | csc_en_reg) & ~CSC_encoder_iact_one_vector_done)begin
		fc_psum_rearrange_read_count <= (fc_psum_rearrange_read_count == 'd22) ? 'd0 : (fc_psum_rearrange_read_count + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		fc_psum_rearrange_read_channel <= 'd0;
	end
	else if(layer2_flag & fc_psum_rearrange_read_count == 'd16)begin
		fc_psum_rearrange_read_channel <= (fc_psum_rearrange_read_channel == 'd5) ? 'd0 : (fc_psum_rearrange_read_channel + 'd1);
	end
	else if(layer3_flag & fc_psum_rearrange_read_count == 'd20)begin
		fc_psum_rearrange_read_channel <= (fc_psum_rearrange_read_channel == 'd5) ? 'd0 : (fc_psum_rearrange_read_channel + 'd1);
	end
	else if(layer4_flag & fc_psum_rearrange_read_count == 'd21)begin
		fc_psum_rearrange_read_channel <= (fc_psum_rearrange_read_channel == 'd3) ? 'd0 : (fc_psum_rearrange_read_channel + 'd1);
	end
end


always@(posedge clock) begin
	if(reset) begin
		psum_read_out_oen_channel_read_done <= 'd0;
	end
	else if(layer1_flag & im2col_read_psum_addr == 'd143)begin
		psum_read_out_oen_channel_read_done <= 'd1;
	end
	else begin
		psum_read_out_oen_channel_read_done <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		psum_read_out_channel <= 'd0;
	end
	else if(layer1_flag & im2col_read_psum_addr == 'd143) begin
		psum_read_out_channel <= psum_read_out_channel + 'd1;
	end
end


always@(posedge clock) begin
	if(reset) begin
		read_out_psum_later_flag <= 'd0;
	end
	else if(LAYER_DONE_wire) begin
		read_out_psum_later_flag <= 'd0;
	end
	else if(read_out_psum_channel_done & layer1_flag) begin
		read_out_psum_later_flag <= 'd1;
	end
end


always@(posedge clock) begin
	if(reset) begin
		LAYER2_READ_OUT_PSUM_reg	<= 'd0;
		LAYER3_READ_OUT_PSUM_reg	<= 'd0;
		LAYER4_READ_OUT_PSUM_reg	<= 'd0;
	end
	else begin
		LAYER2_READ_OUT_PSUM_reg 	<= LAYER2_READ_OUT_PSUM_wire;
		LAYER3_READ_OUT_PSUM_reg 	<= LAYER3_READ_OUT_PSUM_wire;
		LAYER4_READ_OUT_PSUM_reg 	<= LAYER4_READ_OUT_PSUM_wire;
	end
end


always@(posedge clock) begin
	if(reset) begin
		GLB_weight_load_end_reg <= 'd0;
	end
	else if(layer0_flag & weight_data_end) begin
		GLB_weight_load_end_reg <= 'd1;
	end
	else if(LAYER_DONE_wire | layer_1_former_iter_fin) begin
		GLB_weight_load_end_reg <= 'd0;
	end
	else if(layer1_flag & GLB_weight_load_channel_5 & weight_data_end) begin
		GLB_weight_load_end_reg <= 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		MEM_read_addr <= 'd0;
	end
	else if(MEM_read_en) begin
		MEM_read_addr <= MEM_read_addr + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		ifmap_load_fin_reg <= 'd0;
	end
	else if(ifmap_load_fin) begin
		ifmap_load_fin_reg <= 'd1;
	end
end


always@(posedge clock) begin
	if(reset) begin
		csc_en <= 'd0;
	end
	else if(im2col_convert_one_stream_done_reg | (((fc_psum_rearrange_read_count == 'd16 & layer2_flag) | (fc_psum_rearrange_read_count == 'd20 & layer3_flag)) & fc_psum_rearrange_read_channel == 'd5) | (fc_psum_rearrange_read_count == 'd21 & layer4_flag & fc_psum_rearrange_read_channel == 'd3)) begin
		csc_en <= 'd0;
	end
	else if(LAYER0_LOAD_GLB_wire | LAYER1_LOAD_GLB_wire | (LAYER2_LOAD_PE_wire & fc_weight_read_batch == 'd0 & ~csc_en_fin) | (LAYER3_LOAD_PE_wire & fc_weight_read_batch == 'd0 & ~csc_en_fin) | (LAYER4_LOAD_PE_wire & fc_weight_read_batch == 'd0 & ~csc_en_fin)) begin
		csc_en <= 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		csc_en_fin <= 'd0;
	end
	else if(LAYER2_CAL_wire | LAYER3_CAL_wire | LAYER4_CAL_wire)begin
		csc_en_fin <= 'd0;
	end
	else if(fc_psum_rearrange_read_count == 'd16 & fc_psum_rearrange_read_channel == 'd5 & (layer2_flag | layer3_flag))begin
		csc_en_fin <= 'd1;
	end
	else if(fc_psum_rearrange_read_count == 'd21 & fc_psum_rearrange_read_channel == 'd3 & layer4_flag)begin
		csc_en_fin <= 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		csc_en_reg <= 'd0;
	end
	else begin
		csc_en_reg <= csc_en;
	end
end

always@(posedge clock) begin
	if(reset) begin
		layer_count <= 'd0;
	end
	else if(LAYER_DONE_wire & layer_done_fin) begin
		layer_count <= layer_count + 'd1;
	end
end



endmodule
