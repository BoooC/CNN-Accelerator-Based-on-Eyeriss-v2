module TOP # (
	parameter WEIGHT_DATA_3_END = 'd30619,
	parameter WEIGHT_DATA_4_END = 'd39877,
	parameter WEIGHT_DATA_5_END = 'd40762
)
(
	input						clock,
	input						reset,
		
	input	signed		[7:0]	iact_in,
	input						iact_in_valid,
		
	input	signed		[7:0]	weight_addr_in,
	input						weight_addr_in_valid,
	input	signed		[12:0]	weight_data_in,
	input						weight_data_in_valid,
	
	input						system_enable,
	//output				[5:0]	state,
			
	output				[3:0]	final_out,			// 0 ~ 9
	output						final_out_valid,
	
	output						MEM_read_en,
	output				[15:0]	MEM_read_addr		// weight_in : 44190, iact_in : 784
	
);



localparam	IM2COL_WEIGHT_WIDTH 	= 5;
localparam	IM2COL_OUT_ROWS			= 4;

localparam	CSC_IACT_ADDR_WIDTH		= 7;
localparam	CSC_IACT_COUNT_WIDTH	= 4;
localparam	CSC_IACT_DATA_WIDTH		= 8;
localparam	CSC_WEIGHT_ADDR_WIDTH	= 8;
localparam	CSC_WEIGHT_COUNT_WIDTH	= 5;
localparam	CSC_WEIGHT_DATA_WIDTH	= 8;

localparam	POOL_STRIDE 			= 2;

wire					psum_acc_fin;

wire 			     	CG_0_0_PE_cluster_iact_data_in_sel;
wire 			[1:0]	CG_0_0_PE_cluster_iact_data_out_sel;
wire 			     	CG_0_0_PE_cluster_psum_data_in_sel;
wire 			[1:0]	CG_0_0_router_cluster_iact_data_in_sel;
wire 			[1:0]	CG_0_0_router_cluster_iact_data_out_sel;
wire 			     	CG_0_0_router_cluster_weight_data_in_sel;
wire 			     	CG_0_0_router_cluster_weight_data_out_sel;
wire 			     	CG_0_0_router_cluster_psum_data_in_sel;
wire 			     	CG_0_0_router_cluster_psum_data_out_sel;
wire 			     	CG_0_0_read_psum_en;
wire			     	CG_0_0_cal_fin;
wire 			     	CG_0_0_cg_en;
wire			     	CG_0_0_PE_weight_load_en;
wire			     	CG_0_0_GLB_iact_load_en;
wire					CG_0_0_src_GLB_load_fin;
wire					CG_0_0_psum_SRAM_Bank_0_read_out_en;
wire					CG_0_0_psum_SRAM_Bank_1_read_out_en;
wire					CG_0_0_psum_SRAM_Bank_2_read_out_en;
wire					CG_0_0_PE_0_0_disable;
wire					CG_0_0_PE_0_1_disable;
wire					CG_0_0_PE_0_2_disable;
wire					CG_0_0_PE_1_0_disable;
wire					CG_0_0_PE_1_1_disable;
wire					CG_0_0_PE_1_2_disable;
wire					CG_0_0_PE_2_0_disable;
wire					CG_0_0_PE_2_1_disable;
wire					CG_0_0_PE_2_2_disable;
wire			[9:0]	CG_0_0_GLB_iact_0_0_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_0_1_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_0_2_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_1_0_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_1_1_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_1_2_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_2_0_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_2_1_read_addr;
wire			[9:0]	CG_0_0_GLB_iact_2_2_read_addr;
wire					CG_0_0_GLB_psum_write_en;
wire			[9:0]	CG_0_0_GLB_psum_0_write_addr;
wire			[9:0]	CG_0_0_GLB_psum_1_write_addr;
wire			[9:0]	CG_0_0_GLB_psum_2_write_addr;
wire			[9:0]	CG_0_0_GLB_psum_0_read_addr;
wire			[9:0]	CG_0_0_GLB_psum_1_read_addr;
wire			[9:0]	CG_0_0_GLB_psum_2_read_addr;
wire			      	CG_0_0_GLB_iact_0_0_address_in_ready;
wire 			      	CG_0_0_GLB_iact_0_0_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_0_0_address_in;
wire			      	CG_0_0_GLB_iact_0_0_data_in_ready;
wire 			      	CG_0_0_GLB_iact_0_0_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_0_0_data_in;
wire			      	CG_0_0_GLB_iact_0_1_address_in_ready;
wire 			      	CG_0_0_GLB_iact_0_1_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_0_1_address_in;
wire			      	CG_0_0_GLB_iact_0_1_data_in_ready;
wire 			      	CG_0_0_GLB_iact_0_1_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_0_1_data_in;
wire			       	CG_0_0_GLB_iact_0_2_address_in_ready;
wire 			       	CG_0_0_GLB_iact_0_2_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_0_2_address_in;
wire			       	CG_0_0_GLB_iact_0_2_data_in_ready;
wire 			       	CG_0_0_GLB_iact_0_2_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_0_2_data_in;
wire			       	CG_0_0_GLB_iact_1_0_address_in_ready;
wire 			       	CG_0_0_GLB_iact_1_0_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_1_0_address_in;
wire			       	CG_0_0_GLB_iact_1_0_data_in_ready;
wire 			       	CG_0_0_GLB_iact_1_0_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_1_0_data_in;
wire			       	CG_0_0_GLB_iact_1_1_address_in_ready;
wire 			       	CG_0_0_GLB_iact_1_1_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_1_1_address_in;
wire			       	CG_0_0_GLB_iact_1_1_data_in_ready;
wire 			       	CG_0_0_GLB_iact_1_1_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_1_1_data_in;
wire			       	CG_0_0_GLB_iact_1_2_address_in_ready;
wire 			       	CG_0_0_GLB_iact_1_2_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_1_2_address_in;
wire			       	CG_0_0_GLB_iact_1_2_data_in_ready;
wire 			       	CG_0_0_GLB_iact_1_2_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_1_2_data_in;
wire			       	CG_0_0_GLB_iact_2_0_address_in_ready;
wire 			       	CG_0_0_GLB_iact_2_0_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_2_0_address_in;
wire			       	CG_0_0_GLB_iact_2_0_data_in_ready;
wire 			       	CG_0_0_GLB_iact_2_0_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_2_0_data_in;
wire			       	CG_0_0_GLB_iact_2_1_address_in_ready;
wire 			       	CG_0_0_GLB_iact_2_1_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_2_1_address_in;
wire			       	CG_0_0_GLB_iact_2_1_data_in_ready;
wire 			       	CG_0_0_GLB_iact_2_1_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_2_1_data_in;
wire			       	CG_0_0_GLB_iact_2_2_address_in_ready;
wire 			       	CG_0_0_GLB_iact_2_2_address_in_valid;
wire 			[6:0]  	CG_0_0_GLB_iact_2_2_address_in;
wire			       	CG_0_0_GLB_iact_2_2_data_in_ready;
wire 			       	CG_0_0_GLB_iact_2_2_data_in_valid;
wire 			[11:0] 	CG_0_0_GLB_iact_2_2_data_in;
wire			       	CG_0_0_GLB_weight_0_address_in_ready;
wire 			       	CG_0_0_GLB_weight_0_address_in_valid;
wire 			[7:0]  	CG_0_0_GLB_weight_0_address_in;
wire			       	CG_0_0_GLB_weight_0_data_in_ready;
wire 			       	CG_0_0_GLB_weight_0_data_in_valid;
wire 			[12:0] 	CG_0_0_GLB_weight_0_data_in;
wire			       	CG_0_0_GLB_weight_1_address_in_ready;
wire 			       	CG_0_0_GLB_weight_1_address_in_valid;
wire 			[7:0]  	CG_0_0_GLB_weight_1_address_in;
wire			       	CG_0_0_GLB_weight_1_data_in_ready;
wire 			       	CG_0_0_GLB_weight_1_data_in_valid;
wire 			[12:0] 	CG_0_0_GLB_weight_1_data_in;
wire			       	CG_0_0_GLB_weight_2_address_in_ready;
wire 			       	CG_0_0_GLB_weight_2_address_in_valid;
wire 			[7:0]  	CG_0_0_GLB_weight_2_address_in;
wire			       	CG_0_0_GLB_weight_2_data_in_ready;
wire 			       	CG_0_0_GLB_weight_2_data_in_valid;
wire 			[12:0] 	CG_0_0_GLB_weight_2_data_in;
wire        			CG_0_0_GLB_psum_0_data_in_ready;
wire         			CG_0_0_GLB_psum_0_data_in_valid;
wire	signed 	[20:0] 	CG_0_0_GLB_psum_0_data_in;
wire         			CG_0_0_GLB_psum_0_data_out_ready;
wire        			CG_0_0_GLB_psum_0_data_out_valid;
wire 	signed 	[20:0] 	CG_0_0_GLB_psum_0_data_out;
wire        			CG_0_0_GLB_psum_1_data_in_ready;
wire         			CG_0_0_GLB_psum_1_data_in_valid;
wire 	signed 	[20:0] 	CG_0_0_GLB_psum_1_data_in;
wire         			CG_0_0_GLB_psum_1_data_out_ready;
wire        			CG_0_0_GLB_psum_1_data_out_valid;
wire 	signed 	[20:0] 	CG_0_0_GLB_psum_1_data_out;
wire        			CG_0_0_GLB_psum_2_data_in_ready;
wire         			CG_0_0_GLB_psum_2_data_in_valid;
wire 	signed 	[20:0] 	CG_0_0_GLB_psum_2_data_in;
wire         			CG_0_0_GLB_psum_2_data_out_ready;
wire        			CG_0_0_GLB_psum_2_data_out_valid;
wire 	signed 	[20:0] 	CG_0_0_GLB_psum_2_data_out;
wire			[4:0]	CG_0_0_PSUM_DEPTH;
wire					CG_0_0_psum_spad_clear;
wire					CG_0_0_iact_write_fin_clear;
wire					CG_0_0_weight_write_fin_clear;
wire 			     	CG_0_1_PE_cluster_iact_data_in_sel;
wire 			[1:0]	CG_0_1_PE_cluster_iact_data_out_sel;
wire 			     	CG_0_1_PE_cluster_psum_data_in_sel;
wire 			[1:0]	CG_0_1_router_cluster_iact_data_in_sel;
wire 			[1:0]	CG_0_1_router_cluster_iact_data_out_sel;
wire 			     	CG_0_1_router_cluster_weight_data_in_sel;
wire 			     	CG_0_1_router_cluster_weight_data_out_sel;
wire 			     	CG_0_1_router_cluster_psum_data_in_sel;
wire 			     	CG_0_1_router_cluster_psum_data_out_sel;
wire 			     	CG_0_1_read_psum_en;
wire			     	CG_0_1_cal_fin;
wire 			     	CG_0_1_cg_en;
wire			     	CG_0_1_PE_weight_load_en;
wire			     	CG_0_1_GLB_iact_load_en;
wire					CG_0_1_src_GLB_load_fin;
wire					CG_0_1_psum_SRAM_Bank_0_read_out_en;
wire					CG_0_1_psum_SRAM_Bank_1_read_out_en;
wire					CG_0_1_psum_SRAM_Bank_2_read_out_en;
wire					CG_0_1_PE_0_0_disable;
wire					CG_0_1_PE_0_1_disable;
wire					CG_0_1_PE_0_2_disable;
wire					CG_0_1_PE_1_0_disable;
wire					CG_0_1_PE_1_1_disable;
wire					CG_0_1_PE_1_2_disable;
wire					CG_0_1_PE_2_0_disable;
wire					CG_0_1_PE_2_1_disable;
wire					CG_0_1_PE_2_2_disable;
wire			[9:0]	CG_0_1_GLB_iact_0_0_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_0_1_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_0_2_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_1_0_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_1_1_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_1_2_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_2_0_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_2_1_read_addr;
wire			[9:0]	CG_0_1_GLB_iact_2_2_read_addr;
wire					CG_0_1_GLB_psum_write_en;
wire			[9:0]	CG_0_1_GLB_psum_0_write_addr;
wire			[9:0]	CG_0_1_GLB_psum_1_write_addr;
wire			[9:0]	CG_0_1_GLB_psum_2_write_addr;
wire			[9:0]	CG_0_1_GLB_psum_0_read_addr;
wire			[9:0]	CG_0_1_GLB_psum_1_read_addr;
wire			[9:0]	CG_0_1_GLB_psum_2_read_addr;
wire			      	CG_0_1_GLB_iact_0_0_address_in_ready;
wire 			      	CG_0_1_GLB_iact_0_0_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_0_0_address_in;
wire			      	CG_0_1_GLB_iact_0_0_data_in_ready;
wire 			      	CG_0_1_GLB_iact_0_0_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_0_0_data_in;
wire			      	CG_0_1_GLB_iact_0_1_address_in_ready;
wire 			      	CG_0_1_GLB_iact_0_1_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_0_1_address_in;
wire			      	CG_0_1_GLB_iact_0_1_data_in_ready;
wire 			      	CG_0_1_GLB_iact_0_1_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_0_1_data_in;
wire			       	CG_0_1_GLB_iact_0_2_address_in_ready;
wire 			       	CG_0_1_GLB_iact_0_2_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_0_2_address_in;
wire			       	CG_0_1_GLB_iact_0_2_data_in_ready;
wire 			       	CG_0_1_GLB_iact_0_2_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_0_2_data_in;
wire			       	CG_0_1_GLB_iact_1_0_address_in_ready;
wire 			       	CG_0_1_GLB_iact_1_0_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_1_0_address_in;
wire			       	CG_0_1_GLB_iact_1_0_data_in_ready;
wire 			       	CG_0_1_GLB_iact_1_0_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_1_0_data_in;
wire			       	CG_0_1_GLB_iact_1_1_address_in_ready;
wire 			       	CG_0_1_GLB_iact_1_1_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_1_1_address_in;
wire			       	CG_0_1_GLB_iact_1_1_data_in_ready;
wire 			       	CG_0_1_GLB_iact_1_1_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_1_1_data_in;
wire			       	CG_0_1_GLB_iact_1_2_address_in_ready;
wire 			       	CG_0_1_GLB_iact_1_2_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_1_2_address_in;
wire			       	CG_0_1_GLB_iact_1_2_data_in_ready;
wire 			       	CG_0_1_GLB_iact_1_2_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_1_2_data_in;
wire			       	CG_0_1_GLB_iact_2_0_address_in_ready;
wire 			       	CG_0_1_GLB_iact_2_0_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_2_0_address_in;
wire			       	CG_0_1_GLB_iact_2_0_data_in_ready;
wire 			       	CG_0_1_GLB_iact_2_0_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_2_0_data_in;
wire			       	CG_0_1_GLB_iact_2_1_address_in_ready;
wire 			       	CG_0_1_GLB_iact_2_1_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_2_1_address_in;
wire			       	CG_0_1_GLB_iact_2_1_data_in_ready;
wire 			       	CG_0_1_GLB_iact_2_1_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_2_1_data_in;
wire			       	CG_0_1_GLB_iact_2_2_address_in_ready;
wire 			       	CG_0_1_GLB_iact_2_2_address_in_valid;
wire 			[6:0]  	CG_0_1_GLB_iact_2_2_address_in;
wire			       	CG_0_1_GLB_iact_2_2_data_in_ready;
wire 			       	CG_0_1_GLB_iact_2_2_data_in_valid;
wire 			[11:0] 	CG_0_1_GLB_iact_2_2_data_in;
wire			       	CG_0_1_GLB_weight_0_address_in_ready;
wire 			       	CG_0_1_GLB_weight_0_address_in_valid;
wire 			[7:0]  	CG_0_1_GLB_weight_0_address_in;
wire			       	CG_0_1_GLB_weight_0_data_in_ready;
wire 			       	CG_0_1_GLB_weight_0_data_in_valid;
wire 			[12:0] 	CG_0_1_GLB_weight_0_data_in;
wire			       	CG_0_1_GLB_weight_1_address_in_ready;
wire 			       	CG_0_1_GLB_weight_1_address_in_valid;
wire 			[7:0]  	CG_0_1_GLB_weight_1_address_in;
wire			       	CG_0_1_GLB_weight_1_data_in_ready;
wire 			       	CG_0_1_GLB_weight_1_data_in_valid;
wire 			[12:0] 	CG_0_1_GLB_weight_1_data_in;
wire			       	CG_0_1_GLB_weight_2_address_in_ready;
wire 			       	CG_0_1_GLB_weight_2_address_in_valid;
wire 			[7:0]  	CG_0_1_GLB_weight_2_address_in;
wire			       	CG_0_1_GLB_weight_2_data_in_ready;
wire 			       	CG_0_1_GLB_weight_2_data_in_valid;
wire 			[12:0] 	CG_0_1_GLB_weight_2_data_in;
wire        			CG_0_1_GLB_psum_0_data_in_ready;
wire         			CG_0_1_GLB_psum_0_data_in_valid;
wire	signed 	[20:0] 	CG_0_1_GLB_psum_0_data_in;
wire         			CG_0_1_GLB_psum_0_data_out_ready;
wire        			CG_0_1_GLB_psum_0_data_out_valid;
wire 	signed 	[20:0] 	CG_0_1_GLB_psum_0_data_out;
wire        			CG_0_1_GLB_psum_1_data_in_ready;
wire         			CG_0_1_GLB_psum_1_data_in_valid;
wire 	signed 	[20:0] 	CG_0_1_GLB_psum_1_data_in;
wire         			CG_0_1_GLB_psum_1_data_out_ready;
wire        			CG_0_1_GLB_psum_1_data_out_valid;
wire 	signed 	[20:0] 	CG_0_1_GLB_psum_1_data_out;
wire        			CG_0_1_GLB_psum_2_data_in_ready;
wire         			CG_0_1_GLB_psum_2_data_in_valid;
wire 	signed 	[20:0] 	CG_0_1_GLB_psum_2_data_in;
wire         			CG_0_1_GLB_psum_2_data_out_ready;
wire        			CG_0_1_GLB_psum_2_data_out_valid;
wire 	signed 	[20:0] 	CG_0_1_GLB_psum_2_data_out;
wire			[4:0]	CG_0_1_PSUM_DEPTH;
wire					CG_0_1_psum_spad_clear;
wire					CG_0_1_iact_write_fin_clear;
wire					CG_0_1_weight_write_fin_clear;
wire 			     	CG_1_0_PE_cluster_iact_data_in_sel;
wire 			[1:0]	CG_1_0_PE_cluster_iact_data_out_sel;
wire 			     	CG_1_0_PE_cluster_psum_data_in_sel;
wire 			[1:0]	CG_1_0_router_cluster_iact_data_in_sel;
wire 			[1:0]	CG_1_0_router_cluster_iact_data_out_sel;
wire 			     	CG_1_0_router_cluster_weight_data_in_sel;
wire 			     	CG_1_0_router_cluster_weight_data_out_sel;
wire 			     	CG_1_0_router_cluster_psum_data_in_sel;
wire 			     	CG_1_0_router_cluster_psum_data_out_sel;
wire 			     	CG_1_0_read_psum_en;
wire			     	CG_1_0_cal_fin;
wire 			     	CG_1_0_cg_en;
wire			     	CG_1_0_PE_weight_load_en;
wire			     	CG_1_0_GLB_iact_load_en;
wire					CG_1_0_src_GLB_load_fin;
wire					CG_1_0_psum_SRAM_Bank_0_read_out_en;
wire					CG_1_0_psum_SRAM_Bank_1_read_out_en;
wire					CG_1_0_psum_SRAM_Bank_2_read_out_en;
wire					CG_1_0_PE_0_0_disable;
wire					CG_1_0_PE_0_1_disable;
wire					CG_1_0_PE_0_2_disable;
wire					CG_1_0_PE_1_0_disable;
wire					CG_1_0_PE_1_1_disable;
wire					CG_1_0_PE_1_2_disable;
wire					CG_1_0_PE_2_0_disable;
wire					CG_1_0_PE_2_1_disable;
wire					CG_1_0_PE_2_2_disable;
wire			[9:0]	CG_1_0_GLB_iact_0_0_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_0_1_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_0_2_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_1_0_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_1_1_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_1_2_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_2_0_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_2_1_read_addr;
wire			[9:0]	CG_1_0_GLB_iact_2_2_read_addr;
wire					CG_1_0_GLB_psum_write_en;
wire			[9:0]	CG_1_0_GLB_psum_0_write_addr;
wire			[9:0]	CG_1_0_GLB_psum_1_write_addr;
wire			[9:0]	CG_1_0_GLB_psum_2_write_addr;
wire			[9:0]	CG_1_0_GLB_psum_0_read_addr;
wire			[9:0]	CG_1_0_GLB_psum_1_read_addr;
wire			[9:0]	CG_1_0_GLB_psum_2_read_addr;
wire			      	CG_1_0_GLB_iact_0_0_address_in_ready;
wire 			      	CG_1_0_GLB_iact_0_0_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_0_0_address_in;
wire			      	CG_1_0_GLB_iact_0_0_data_in_ready;
wire 			      	CG_1_0_GLB_iact_0_0_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_0_0_data_in;
wire			      	CG_1_0_GLB_iact_0_1_address_in_ready;
wire 			      	CG_1_0_GLB_iact_0_1_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_0_1_address_in;
wire			      	CG_1_0_GLB_iact_0_1_data_in_ready;
wire 			      	CG_1_0_GLB_iact_0_1_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_0_1_data_in;
wire			       	CG_1_0_GLB_iact_0_2_address_in_ready;
wire 			       	CG_1_0_GLB_iact_0_2_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_0_2_address_in;
wire			       	CG_1_0_GLB_iact_0_2_data_in_ready;
wire 			       	CG_1_0_GLB_iact_0_2_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_0_2_data_in;
wire			       	CG_1_0_GLB_iact_1_0_address_in_ready;
wire 			       	CG_1_0_GLB_iact_1_0_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_1_0_address_in;
wire			       	CG_1_0_GLB_iact_1_0_data_in_ready;
wire 			       	CG_1_0_GLB_iact_1_0_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_1_0_data_in;
wire			       	CG_1_0_GLB_iact_1_1_address_in_ready;
wire 			       	CG_1_0_GLB_iact_1_1_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_1_1_address_in;
wire			       	CG_1_0_GLB_iact_1_1_data_in_ready;
wire 			       	CG_1_0_GLB_iact_1_1_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_1_1_data_in;
wire			       	CG_1_0_GLB_iact_1_2_address_in_ready;
wire 			       	CG_1_0_GLB_iact_1_2_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_1_2_address_in;
wire			       	CG_1_0_GLB_iact_1_2_data_in_ready;
wire 			       	CG_1_0_GLB_iact_1_2_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_1_2_data_in;
wire			       	CG_1_0_GLB_iact_2_0_address_in_ready;
wire 			       	CG_1_0_GLB_iact_2_0_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_2_0_address_in;
wire			       	CG_1_0_GLB_iact_2_0_data_in_ready;
wire 			       	CG_1_0_GLB_iact_2_0_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_2_0_data_in;
wire			       	CG_1_0_GLB_iact_2_1_address_in_ready;
wire 			       	CG_1_0_GLB_iact_2_1_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_2_1_address_in;
wire			       	CG_1_0_GLB_iact_2_1_data_in_ready;
wire 			       	CG_1_0_GLB_iact_2_1_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_2_1_data_in;
wire			       	CG_1_0_GLB_iact_2_2_address_in_ready;
wire 			       	CG_1_0_GLB_iact_2_2_address_in_valid;
wire 			[6:0]  	CG_1_0_GLB_iact_2_2_address_in;
wire			       	CG_1_0_GLB_iact_2_2_data_in_ready;
wire 			       	CG_1_0_GLB_iact_2_2_data_in_valid;
wire 			[11:0] 	CG_1_0_GLB_iact_2_2_data_in;
wire			       	CG_1_0_GLB_weight_0_address_in_ready;
wire 			       	CG_1_0_GLB_weight_0_address_in_valid;
wire 			[7:0]  	CG_1_0_GLB_weight_0_address_in;
wire			       	CG_1_0_GLB_weight_0_data_in_ready;
wire 			       	CG_1_0_GLB_weight_0_data_in_valid;
wire 			[12:0] 	CG_1_0_GLB_weight_0_data_in;
wire			       	CG_1_0_GLB_weight_1_address_in_ready;
wire 			       	CG_1_0_GLB_weight_1_address_in_valid;
wire 			[7:0]  	CG_1_0_GLB_weight_1_address_in;
wire			       	CG_1_0_GLB_weight_1_data_in_ready;
wire 			       	CG_1_0_GLB_weight_1_data_in_valid;
wire 			[12:0] 	CG_1_0_GLB_weight_1_data_in;
wire			       	CG_1_0_GLB_weight_2_address_in_ready;
wire 			       	CG_1_0_GLB_weight_2_address_in_valid;
wire 			[7:0]  	CG_1_0_GLB_weight_2_address_in;
wire			       	CG_1_0_GLB_weight_2_data_in_ready;
wire 			       	CG_1_0_GLB_weight_2_data_in_valid;
wire 			[12:0] 	CG_1_0_GLB_weight_2_data_in;
wire        			CG_1_0_GLB_psum_0_data_in_ready;
wire         			CG_1_0_GLB_psum_0_data_in_valid;
wire	signed 	[20:0] 	CG_1_0_GLB_psum_0_data_in;
wire         			CG_1_0_GLB_psum_0_data_out_ready;
wire        			CG_1_0_GLB_psum_0_data_out_valid;
wire 	signed 	[20:0] 	CG_1_0_GLB_psum_0_data_out;
wire        			CG_1_0_GLB_psum_1_data_in_ready;
wire         			CG_1_0_GLB_psum_1_data_in_valid;
wire 	signed 	[20:0] 	CG_1_0_GLB_psum_1_data_in;
wire         			CG_1_0_GLB_psum_1_data_out_ready;
wire        			CG_1_0_GLB_psum_1_data_out_valid;
wire 	signed 	[20:0] 	CG_1_0_GLB_psum_1_data_out;
wire        			CG_1_0_GLB_psum_2_data_in_ready;
wire         			CG_1_0_GLB_psum_2_data_in_valid;
wire 	signed 	[20:0] 	CG_1_0_GLB_psum_2_data_in;
wire         			CG_1_0_GLB_psum_2_data_out_ready;
wire        			CG_1_0_GLB_psum_2_data_out_valid;
wire 	signed 	[20:0] 	CG_1_0_GLB_psum_2_data_out;
wire			[4:0]	CG_1_0_PSUM_DEPTH;
wire					CG_1_0_psum_spad_clear;
wire					CG_1_0_iact_write_fin_clear;
wire					CG_1_0_weight_write_fin_clear;
wire 			     	CG_1_1_PE_cluster_iact_data_in_sel;
wire 			[1:0]	CG_1_1_PE_cluster_iact_data_out_sel;
wire 			     	CG_1_1_PE_cluster_psum_data_in_sel;
wire 			[1:0]	CG_1_1_router_cluster_iact_data_in_sel;
wire 			[1:0]	CG_1_1_router_cluster_iact_data_out_sel;
wire 			     	CG_1_1_router_cluster_weight_data_in_sel;
wire 			     	CG_1_1_router_cluster_weight_data_out_sel;
wire 			     	CG_1_1_router_cluster_psum_data_in_sel;
wire 			     	CG_1_1_router_cluster_psum_data_out_sel;
wire 			     	CG_1_1_read_psum_en;
wire			     	CG_1_1_cal_fin;
wire 			     	CG_1_1_cg_en;
wire			     	CG_1_1_PE_weight_load_en;
wire			     	CG_1_1_GLB_iact_load_en;
wire					CG_1_1_src_GLB_load_fin;
wire					CG_1_1_psum_SRAM_Bank_0_read_out_en;
wire					CG_1_1_psum_SRAM_Bank_1_read_out_en;
wire					CG_1_1_psum_SRAM_Bank_2_read_out_en;
wire					CG_1_1_PE_0_0_disable;
wire					CG_1_1_PE_0_1_disable;
wire					CG_1_1_PE_0_2_disable;
wire					CG_1_1_PE_1_0_disable;
wire					CG_1_1_PE_1_1_disable;
wire					CG_1_1_PE_1_2_disable;
wire					CG_1_1_PE_2_0_disable;
wire					CG_1_1_PE_2_1_disable;
wire					CG_1_1_PE_2_2_disable;
wire			[9:0]	CG_1_1_GLB_iact_0_0_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_0_1_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_0_2_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_1_0_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_1_1_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_1_2_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_2_0_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_2_1_read_addr;
wire			[9:0]	CG_1_1_GLB_iact_2_2_read_addr;
wire					CG_1_1_GLB_psum_write_en;
wire			[9:0]	CG_1_1_GLB_psum_0_write_addr;
wire			[9:0]	CG_1_1_GLB_psum_1_write_addr;
wire			[9:0]	CG_1_1_GLB_psum_2_write_addr;
wire			[9:0]	CG_1_1_GLB_psum_0_read_addr;
wire			[9:0]	CG_1_1_GLB_psum_1_read_addr;
wire			[9:0]	CG_1_1_GLB_psum_2_read_addr;
wire			      	CG_1_1_GLB_iact_0_0_address_in_ready;
wire 			      	CG_1_1_GLB_iact_0_0_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_0_0_address_in;
wire			      	CG_1_1_GLB_iact_0_0_data_in_ready;
wire 			      	CG_1_1_GLB_iact_0_0_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_0_0_data_in;
wire			      	CG_1_1_GLB_iact_0_1_address_in_ready;
wire 			      	CG_1_1_GLB_iact_0_1_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_0_1_address_in;
wire			      	CG_1_1_GLB_iact_0_1_data_in_ready;
wire 			      	CG_1_1_GLB_iact_0_1_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_0_1_data_in;
wire			       	CG_1_1_GLB_iact_0_2_address_in_ready;
wire 			       	CG_1_1_GLB_iact_0_2_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_0_2_address_in;
wire			       	CG_1_1_GLB_iact_0_2_data_in_ready;
wire 			       	CG_1_1_GLB_iact_0_2_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_0_2_data_in;
wire			       	CG_1_1_GLB_iact_1_0_address_in_ready;
wire 			       	CG_1_1_GLB_iact_1_0_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_1_0_address_in;
wire			       	CG_1_1_GLB_iact_1_0_data_in_ready;
wire 			       	CG_1_1_GLB_iact_1_0_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_1_0_data_in;
wire			       	CG_1_1_GLB_iact_1_1_address_in_ready;
wire 			       	CG_1_1_GLB_iact_1_1_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_1_1_address_in;
wire			       	CG_1_1_GLB_iact_1_1_data_in_ready;
wire 			       	CG_1_1_GLB_iact_1_1_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_1_1_data_in;
wire			       	CG_1_1_GLB_iact_1_2_address_in_ready;
wire 			       	CG_1_1_GLB_iact_1_2_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_1_2_address_in;
wire			       	CG_1_1_GLB_iact_1_2_data_in_ready;
wire 			       	CG_1_1_GLB_iact_1_2_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_1_2_data_in;
wire			       	CG_1_1_GLB_iact_2_0_address_in_ready;
wire 			       	CG_1_1_GLB_iact_2_0_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_2_0_address_in;
wire			       	CG_1_1_GLB_iact_2_0_data_in_ready;
wire 			       	CG_1_1_GLB_iact_2_0_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_2_0_data_in;
wire			       	CG_1_1_GLB_iact_2_1_address_in_ready;
wire 			       	CG_1_1_GLB_iact_2_1_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_2_1_address_in;
wire			       	CG_1_1_GLB_iact_2_1_data_in_ready;
wire 			       	CG_1_1_GLB_iact_2_1_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_2_1_data_in;
wire			       	CG_1_1_GLB_iact_2_2_address_in_ready;
wire 			       	CG_1_1_GLB_iact_2_2_address_in_valid;
wire 			[6:0]  	CG_1_1_GLB_iact_2_2_address_in;
wire			       	CG_1_1_GLB_iact_2_2_data_in_ready;
wire 			       	CG_1_1_GLB_iact_2_2_data_in_valid;
wire 			[11:0] 	CG_1_1_GLB_iact_2_2_data_in;
wire			       	CG_1_1_GLB_weight_0_address_in_ready;
wire 			       	CG_1_1_GLB_weight_0_address_in_valid;
wire 			[7:0]  	CG_1_1_GLB_weight_0_address_in;
wire			       	CG_1_1_GLB_weight_0_data_in_ready;
wire 			       	CG_1_1_GLB_weight_0_data_in_valid;
wire 			[12:0] 	CG_1_1_GLB_weight_0_data_in;
wire			       	CG_1_1_GLB_weight_1_address_in_ready;
wire 			       	CG_1_1_GLB_weight_1_address_in_valid;
wire 			[7:0]  	CG_1_1_GLB_weight_1_address_in;
wire			       	CG_1_1_GLB_weight_1_data_in_ready;
wire 			       	CG_1_1_GLB_weight_1_data_in_valid;
wire 			[12:0] 	CG_1_1_GLB_weight_1_data_in;
wire			       	CG_1_1_GLB_weight_2_address_in_ready;
wire 			       	CG_1_1_GLB_weight_2_address_in_valid;
wire 			[7:0]  	CG_1_1_GLB_weight_2_address_in;
wire			       	CG_1_1_GLB_weight_2_data_in_ready;
wire 			       	CG_1_1_GLB_weight_2_data_in_valid;
wire 			[12:0] 	CG_1_1_GLB_weight_2_data_in;
wire        			CG_1_1_GLB_psum_0_data_in_ready;
wire         			CG_1_1_GLB_psum_0_data_in_valid;
wire	signed 	[20:0] 	CG_1_1_GLB_psum_0_data_in;
wire         			CG_1_1_GLB_psum_0_data_out_ready;
wire        			CG_1_1_GLB_psum_0_data_out_valid;
wire 	signed 	[20:0] 	CG_1_1_GLB_psum_0_data_out;
wire        			CG_1_1_GLB_psum_1_data_in_ready;
wire         			CG_1_1_GLB_psum_1_data_in_valid;
wire 	signed 	[20:0] 	CG_1_1_GLB_psum_1_data_in;
wire         			CG_1_1_GLB_psum_1_data_out_ready;
wire        			CG_1_1_GLB_psum_1_data_out_valid;
wire 	signed 	[20:0] 	CG_1_1_GLB_psum_1_data_out;
wire        			CG_1_1_GLB_psum_2_data_in_ready;
wire         			CG_1_1_GLB_psum_2_data_in_valid;
wire 	signed 	[20:0] 	CG_1_1_GLB_psum_2_data_in;
wire         			CG_1_1_GLB_psum_2_data_out_ready;
wire        			CG_1_1_GLB_psum_2_data_out_valid;
wire 	signed 	[20:0] 	CG_1_1_GLB_psum_2_data_out;
wire			[4:0]	CG_1_1_PSUM_DEPTH;
wire					CG_1_1_psum_spad_clear;
wire					CG_1_1_iact_write_fin_clear;
wire					CG_1_1_weight_write_fin_clear;


// ---------------- im2col converter ---------------- //
wire					im2col_enable;                    
wire			[9:0]	im2col_ifmap_len;                 	// 576
wire			[4:0]	im2col_ofmap_size;	       			// 24*24
wire			[9:0]	im2col_next_weight_row_jump;		// 21
wire			[9:0]	im2col_next_ifmap_row_jump;			// 111
wire			[9:0]	im2col_next_vector_jump;			// 115
wire			[9:0]	im2col_read_psum_addr;          	
wire					im2col_convert_one_stream_done;


// ---------------- csc encoder ---------------- //
wire        											csc_iact_data_in_ready;
wire         											csc_iact_data_in_valid;
wire 	signed 	[7:0]  									csc_iact_data_in;
wire         											csc_iact_address_out_ready;
wire        											csc_iact_address_out_valid;
wire [CSC_IACT_ADDR_WIDTH-1:0] 							csc_iact_address_out;
wire         											csc_iact_data_out_ready;
wire        											csc_iact_data_out_valid;
wire [CSC_IACT_DATA_WIDTH+CSC_IACT_COUNT_WIDTH-1:0] 	csc_iact_data_out;		
wire [4:0]  											csc_iact_matrix_height;
wire [4:0]  											csc_iact_matrix_weight;
wire													csc_iact_clear_iact_SRAM;
wire													csc_iact_one_vector_done;

wire        											csc_weight_data_in_ready;
wire         											csc_weight_data_in_valid;
wire 	signed 	[7:0]  									csc_weight_data_in;
wire         											csc_weight_address_out_ready;
wire        											csc_weight_address_out_valid;
wire [CSC_WEIGHT_ADDR_WIDTH-1:0] 						csc_weight_address_out;
wire         											csc_weight_data_out_ready;
wire        											csc_weight_data_out_valid;
wire [CSC_WEIGHT_DATA_WIDTH+CSC_WEIGHT_COUNT_WIDTH-1:0] csc_weight_data_out;		
wire [4:0]  											csc_weight_matrix_height;
wire [4:0]  											csc_weight_matrix_weight;
wire													csc_weight_clear_iact_SRAM;
wire													csc_weight_one_vector_done;


// ---------------- psum rearrange ---------------- //
wire	 				rearrange_write_en;
wire			[11:0]	rearrange_write_addr;
wire	signed	[7:0] 	rearrange_data_in;
wire	     			rearrange_data_in_valid;
wire			[11:0] 	rearrange_read_addr;
wire	signed 	[7:0] 	rearrange_data_out;


// ---------------- psum requantizer ---------------- //
wire	signed	[20:0]	quant_data_in;
wire					quant_data_in_valid;
wire	signed	[7:0]	quant_data_out;
wire					quant_data_out_valid;


// ---------------- ReLU ---------------- //
wire	signed	[7:0]	ReLU_data_in;
wire					ReLU_data_in_valid;
wire	signed	[7:0]	ReLU_data_out;
wire					ReLU_data_out_valid;


// ---------------- Max Pooling ---------------- //
wire					pool_enable;
wire	signed	[7:0]	pool_data_in;
wire					pool_data_in_valid;
wire	signed	[7:0]	pool_data_out;
wire					pool_data_out_valid;


// ---------------- psum SRAM out acc ---------------- //
wire					psum_SRAM_out_acc_en;
wire	signed	[20:0]	psum_SRAM_out_acc_data_in;
wire					psum_SRAM_out_acc_data_in_valid;
wire	signed	[20:0]	psum_SRAM_out_acc_data_out;
wire					psum_SRAM_out_acc_data_out_valid;


// ---------------- Softmax ---------------- //
wire					softmax_en;
wire	signed	[20:0]	softmax_data_in;
wire					softmax_data_in_valid;
wire			[3:0]	softmax_data_out;
wire					softmax_data_out_valid;


// ---------------- TOP controller ---------------- //
wire			ctrl_softmax_en;
wire 			ctrl_csc_en;
wire			ctrl_conv_flag;
wire			ctrl_fc_flag;
wire	[2:0]	ctrl_layer_count;
wire			ctrl_ifmap_in_en;
wire			ctrl_ReLU_en;
wire			ctrl_psum_acc_fin;
wire			ctrl_psum_SRAM_out_acc_en;
wire			ctrl_CG_0_0_GLB_psum_0_out_en;
wire			ctrl_CG_0_0_GLB_psum_1_out_en;
wire			ctrl_CG_0_0_GLB_psum_2_out_en;
wire			ctrl_CG_0_1_GLB_psum_0_out_en;
wire			ctrl_CG_0_1_GLB_psum_1_out_en;
wire			ctrl_CG_0_1_GLB_psum_2_out_en;
wire			ctrl_CG_1_0_GLB_psum_0_out_en;
wire			ctrl_CG_1_0_GLB_psum_1_out_en;
wire			ctrl_CG_1_0_GLB_psum_2_out_en;
wire			ctrl_CG_1_1_GLB_psum_0_out_en;
wire			ctrl_CG_1_1_GLB_psum_1_out_en;
wire			ctrl_CG_1_1_GLB_psum_2_out_en;
wire			ctrl_CG_0_0_GLB_iact_0_0_in_en;
wire			ctrl_CG_0_0_GLB_iact_0_1_in_en;
wire			ctrl_CG_0_0_GLB_iact_0_2_in_en;
wire			ctrl_CG_0_0_GLB_iact_1_0_in_en;
wire			ctrl_CG_0_0_GLB_iact_1_1_in_en;
wire			ctrl_CG_0_0_GLB_iact_1_2_in_en;
wire			ctrl_CG_0_0_GLB_iact_2_0_in_en;
wire			ctrl_CG_0_0_GLB_iact_2_1_in_en;
wire			ctrl_CG_0_0_GLB_iact_2_2_in_en;
wire			ctrl_CG_0_1_GLB_iact_0_0_in_en;
wire			ctrl_CG_0_1_GLB_iact_0_1_in_en;
wire			ctrl_CG_0_1_GLB_iact_0_2_in_en;
wire			ctrl_CG_0_1_GLB_iact_1_0_in_en;
wire			ctrl_CG_0_1_GLB_iact_1_1_in_en;
wire			ctrl_CG_0_1_GLB_iact_1_2_in_en;
wire			ctrl_CG_0_1_GLB_iact_2_0_in_en;
wire			ctrl_CG_0_1_GLB_iact_2_1_in_en;
wire			ctrl_CG_0_1_GLB_iact_2_2_in_en;
wire			ctrl_CG_1_0_GLB_iact_0_0_in_en;
wire			ctrl_CG_1_0_GLB_iact_0_1_in_en;
wire			ctrl_CG_1_0_GLB_iact_0_2_in_en;
wire			ctrl_CG_1_0_GLB_iact_1_0_in_en;
wire			ctrl_CG_1_0_GLB_iact_1_1_in_en;
wire			ctrl_CG_1_0_GLB_iact_1_2_in_en;
wire			ctrl_CG_1_0_GLB_iact_2_0_in_en;
wire			ctrl_CG_1_0_GLB_iact_2_1_in_en;
wire			ctrl_CG_1_0_GLB_iact_2_2_in_en;
wire			ctrl_CG_1_1_GLB_iact_0_0_in_en;
wire			ctrl_CG_1_1_GLB_iact_0_1_in_en;
wire			ctrl_CG_1_1_GLB_iact_0_2_in_en;
wire			ctrl_CG_1_1_GLB_iact_1_0_in_en;
wire			ctrl_CG_1_1_GLB_iact_1_1_in_en;
wire			ctrl_CG_1_1_GLB_iact_1_2_in_en;
wire			ctrl_CG_1_1_GLB_iact_2_0_in_en;
wire			ctrl_CG_1_1_GLB_iact_2_1_in_en;
wire			ctrl_CG_1_1_GLB_iact_2_2_in_en;
wire			ctrl_CG_0_0_GLB_weight_0_in_en;
wire			ctrl_CG_0_0_GLB_weight_1_in_en;
wire			ctrl_CG_0_0_GLB_weight_2_in_en;
wire			ctrl_CG_0_1_GLB_weight_0_in_en;
wire			ctrl_CG_0_1_GLB_weight_1_in_en;
wire			ctrl_CG_0_1_GLB_weight_2_in_en;
wire			ctrl_CG_1_0_GLB_weight_0_in_en;
wire			ctrl_CG_1_0_GLB_weight_1_in_en;
wire			ctrl_CG_1_0_GLB_weight_2_in_en;
wire			ctrl_CG_1_1_GLB_weight_0_in_en;
wire			ctrl_CG_1_1_GLB_weight_1_in_en;
wire			ctrl_CG_1_1_GLB_weight_2_in_en;
wire	     	ctrl_CG_0_0_PE_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_0_0_PE_cluster_iact_data_out_sel;
wire	     	ctrl_CG_0_0_PE_cluster_psum_data_in_sel;
wire	[1:0]	ctrl_CG_0_0_router_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_0_0_router_cluster_iact_data_out_sel;
wire	     	ctrl_CG_0_0_router_cluster_weight_data_in_sel;
wire	     	ctrl_CG_0_0_router_cluster_weight_data_out_sel;
wire	     	ctrl_CG_0_0_router_cluster_psum_data_in_sel;
wire	     	ctrl_CG_0_0_router_cluster_psum_data_out_sel;
wire			ctrl_CG_0_0_src_GLB_load_fin;
wire			ctrl_CG_0_0_GLB_iact_load_en;
wire			ctrl_CG_0_0_PE_weight_load_en;
wire			ctrl_CG_0_0_cal_fin;
wire			ctrl_CG_0_0_cg_en;
wire			ctrl_CG_0_0_read_psum_en;
wire			ctrl_CG_0_0_psum_SRAM_Bank_0_read_out_en;
wire			ctrl_CG_0_0_psum_SRAM_Bank_1_read_out_en;
wire			ctrl_CG_0_0_psum_SRAM_Bank_2_read_out_en;
wire			ctrl_CG_0_0_PE_0_0_disable;
wire			ctrl_CG_0_0_PE_0_1_disable;
wire			ctrl_CG_0_0_PE_0_2_disable;
wire			ctrl_CG_0_0_PE_1_0_disable;
wire			ctrl_CG_0_0_PE_1_1_disable;
wire			ctrl_CG_0_0_PE_1_2_disable;
wire			ctrl_CG_0_0_PE_2_0_disable;
wire			ctrl_CG_0_0_PE_2_1_disable;
wire			ctrl_CG_0_0_PE_2_2_disable;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_0_0_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_0_1_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_0_2_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_1_0_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_1_1_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_1_2_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_2_0_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_2_1_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_iact_2_2_read_addr;
wire			ctrl_CG_0_0_GLB_psum_write_en;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_0_write_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_1_write_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_2_write_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_0_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_1_read_addr;
wire	[9:0]	ctrl_CG_0_0_GLB_psum_2_read_addr;
wire	[4:0]	ctrl_CG_0_0_PSUM_DEPTH;
wire			ctrl_CG_0_0_psum_spad_clear;
wire			ctrl_CG_0_0_iact_write_fin_clear;
wire			ctrl_CG_0_0_weight_write_fin_clear;
wire	     	ctrl_CG_0_1_PE_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_0_1_PE_cluster_iact_data_out_sel;
wire	     	ctrl_CG_0_1_PE_cluster_psum_data_in_sel;
wire	[1:0]	ctrl_CG_0_1_router_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_0_1_router_cluster_iact_data_out_sel;
wire	     	ctrl_CG_0_1_router_cluster_weight_data_in_sel;
wire	     	ctrl_CG_0_1_router_cluster_weight_data_out_sel;
wire	     	ctrl_CG_0_1_router_cluster_psum_data_in_sel;
wire	     	ctrl_CG_0_1_router_cluster_psum_data_out_sel;
wire			ctrl_CG_0_1_src_GLB_load_fin;
wire			ctrl_CG_0_1_GLB_iact_load_en;
wire			ctrl_CG_0_1_PE_weight_load_en;
wire			ctrl_CG_0_1_cal_fin;
wire			ctrl_CG_0_1_cg_en;
wire			ctrl_CG_0_1_read_psum_en;
wire			ctrl_CG_0_1_psum_SRAM_Bank_0_read_out_en;
wire			ctrl_CG_0_1_psum_SRAM_Bank_1_read_out_en;
wire			ctrl_CG_0_1_psum_SRAM_Bank_2_read_out_en;
wire			ctrl_CG_0_1_PE_0_0_disable;
wire			ctrl_CG_0_1_PE_0_1_disable;
wire			ctrl_CG_0_1_PE_0_2_disable;
wire			ctrl_CG_0_1_PE_1_0_disable;
wire			ctrl_CG_0_1_PE_1_1_disable;
wire			ctrl_CG_0_1_PE_1_2_disable;
wire			ctrl_CG_0_1_PE_2_0_disable;
wire			ctrl_CG_0_1_PE_2_1_disable;
wire			ctrl_CG_0_1_PE_2_2_disable;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_0_0_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_0_1_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_0_2_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_1_0_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_1_1_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_1_2_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_2_0_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_2_1_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_iact_2_2_read_addr;
wire			ctrl_CG_0_1_GLB_psum_write_en;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_0_write_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_1_write_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_2_write_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_0_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_1_read_addr;
wire	[9:0]	ctrl_CG_0_1_GLB_psum_2_read_addr;
wire	[4:0]	ctrl_CG_0_1_PSUM_DEPTH;
wire			ctrl_CG_0_1_psum_spad_clear;
wire			ctrl_CG_0_1_iact_write_fin_clear;
wire			ctrl_CG_0_1_weight_write_fin_clear;
wire	     	ctrl_CG_1_0_PE_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_1_0_PE_cluster_iact_data_out_sel;
wire	     	ctrl_CG_1_0_PE_cluster_psum_data_in_sel;
wire	[1:0]	ctrl_CG_1_0_router_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_1_0_router_cluster_iact_data_out_sel;
wire	     	ctrl_CG_1_0_router_cluster_weight_data_in_sel;
wire	     	ctrl_CG_1_0_router_cluster_weight_data_out_sel;
wire	     	ctrl_CG_1_0_router_cluster_psum_data_in_sel;
wire	     	ctrl_CG_1_0_router_cluster_psum_data_out_sel;
wire			ctrl_CG_1_0_src_GLB_load_fin;
wire			ctrl_CG_1_0_GLB_iact_load_en;
wire			ctrl_CG_1_0_PE_weight_load_en;
wire			ctrl_CG_1_0_cal_fin;
wire			ctrl_CG_1_0_cg_en;
wire			ctrl_CG_1_0_read_psum_en;
wire			ctrl_CG_1_0_psum_SRAM_Bank_0_read_out_en;
wire			ctrl_CG_1_0_psum_SRAM_Bank_1_read_out_en;
wire			ctrl_CG_1_0_psum_SRAM_Bank_2_read_out_en;
wire			ctrl_CG_1_0_PE_0_0_disable;
wire			ctrl_CG_1_0_PE_0_1_disable;
wire			ctrl_CG_1_0_PE_0_2_disable;
wire			ctrl_CG_1_0_PE_1_0_disable;
wire			ctrl_CG_1_0_PE_1_1_disable;
wire			ctrl_CG_1_0_PE_1_2_disable;
wire			ctrl_CG_1_0_PE_2_0_disable;
wire			ctrl_CG_1_0_PE_2_1_disable;
wire			ctrl_CG_1_0_PE_2_2_disable;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_0_0_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_0_1_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_0_2_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_1_0_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_1_1_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_1_2_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_2_0_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_2_1_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_iact_2_2_read_addr;
wire			ctrl_CG_1_0_GLB_psum_write_en;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_0_write_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_1_write_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_2_write_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_0_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_1_read_addr;
wire	[9:0]	ctrl_CG_1_0_GLB_psum_2_read_addr;
wire	[4:0]	ctrl_CG_1_0_PSUM_DEPTH;
wire			ctrl_CG_1_0_psum_spad_clear;
wire			ctrl_CG_1_0_iact_write_fin_clear;
wire			ctrl_CG_1_0_weight_write_fin_clear;
wire	     	ctrl_CG_1_1_PE_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_1_1_PE_cluster_iact_data_out_sel;
wire	     	ctrl_CG_1_1_PE_cluster_psum_data_in_sel;
wire	[1:0]	ctrl_CG_1_1_router_cluster_iact_data_in_sel;
wire	[1:0]	ctrl_CG_1_1_router_cluster_iact_data_out_sel;
wire	     	ctrl_CG_1_1_router_cluster_weight_data_in_sel;
wire	     	ctrl_CG_1_1_router_cluster_weight_data_out_sel;
wire	     	ctrl_CG_1_1_router_cluster_psum_data_in_sel;
wire	     	ctrl_CG_1_1_router_cluster_psum_data_out_sel;
wire			ctrl_CG_1_1_src_GLB_load_fin;
wire			ctrl_CG_1_1_GLB_iact_load_en;
wire			ctrl_CG_1_1_PE_weight_load_en;
wire			ctrl_CG_1_1_cal_fin;
wire			ctrl_CG_1_1_cg_en;
wire			ctrl_CG_1_1_read_psum_en;
wire			ctrl_CG_1_1_psum_SRAM_Bank_0_read_out_en;
wire			ctrl_CG_1_1_psum_SRAM_Bank_1_read_out_en;
wire			ctrl_CG_1_1_psum_SRAM_Bank_2_read_out_en;
wire			ctrl_CG_1_1_PE_0_0_disable;
wire			ctrl_CG_1_1_PE_0_1_disable;
wire			ctrl_CG_1_1_PE_0_2_disable;
wire			ctrl_CG_1_1_PE_1_0_disable;
wire			ctrl_CG_1_1_PE_1_1_disable;
wire			ctrl_CG_1_1_PE_1_2_disable;
wire			ctrl_CG_1_1_PE_2_0_disable;
wire			ctrl_CG_1_1_PE_2_1_disable;
wire			ctrl_CG_1_1_PE_2_2_disable;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_0_0_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_0_1_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_0_2_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_1_0_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_1_1_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_1_2_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_2_0_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_2_1_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_iact_2_2_read_addr;
wire			ctrl_CG_1_1_GLB_psum_write_en;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_0_write_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_1_write_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_2_write_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_0_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_1_read_addr;
wire	[9:0]	ctrl_CG_1_1_GLB_psum_2_read_addr;
wire	[4:0]	ctrl_CG_1_1_PSUM_DEPTH;
wire			ctrl_CG_1_1_psum_spad_clear;
wire			ctrl_CG_1_1_iact_write_fin_clear;
wire			ctrl_CG_1_1_weight_write_fin_clear;
wire  	[4:0]  	ctrl_CSC_encoder_iact_matrix_height;
wire  	[4:0]  	ctrl_CSC_encoder_iact_matrix_width;
wire			ctrl_CSC_encoder_iact_clear_iact_SRAM;
wire			ctrl_CSC_encoder_iact_one_vector_done;
wire  	[4:0]  	ctrl_CSC_encoder_weight_matrix_height;
wire  	[4:0]  	ctrl_CSC_encoder_weight_matrix_width;
wire			ctrl_CSC_encoder_weight_clear_iact_SRAM;
wire			ctrl_CSC_encoder_weight_one_vector_done;
wire			ctrl_im2col_enable;				
wire	[9:0]	ctrl_im2col_ifmap_len;					
wire	[4:0]	ctrl_im2col_ofmap_size;
wire	[9:0]	ctrl_im2col_next_weight_row_jump;
wire	[9:0]	ctrl_im2col_next_ifmap_row_jump;
wire	[9:0]	ctrl_im2col_next_vector_jump;	
wire	[9:0]	ctrl_im2col_read_psum_addr;	
wire			ctrl_im2col_convert_one_stream_done;  	
wire			ctrl_psum_rearrange_write_en;
wire	[11:0]	ctrl_psum_rearrange_write_addr;
wire	[11:0]	ctrl_psum_rearrange_read_addr;
wire			ctrl_pool_enable;




ClusterGroup_array ClusterGroup_array(

	.clock										(clock										),
	.reset                                      (reset                                      ),	
	.psum_acc_fin								(psum_acc_fin								),
	.CG_0_0_PE_cluster_iact_data_in_sel         (CG_0_0_PE_cluster_iact_data_in_sel         ),
	.CG_0_0_PE_cluster_iact_data_out_sel        (CG_0_0_PE_cluster_iact_data_out_sel        ),
	.CG_0_0_PE_cluster_psum_data_in_sel         (CG_0_0_PE_cluster_psum_data_in_sel         ),								
	.CG_0_0_router_cluster_iact_data_in_sel     (CG_0_0_router_cluster_iact_data_in_sel     ),
	.CG_0_0_router_cluster_iact_data_out_sel    (CG_0_0_router_cluster_iact_data_out_sel    ),
	.CG_0_0_router_cluster_weight_data_in_sel   (CG_0_0_router_cluster_weight_data_in_sel   ),
	.CG_0_0_router_cluster_weight_data_out_sel  (CG_0_0_router_cluster_weight_data_out_sel  ),
	.CG_0_0_router_cluster_psum_data_in_sel     (CG_0_0_router_cluster_psum_data_in_sel     ),
	.CG_0_0_router_cluster_psum_data_out_sel    (CG_0_0_router_cluster_psum_data_out_sel    ),							
	.CG_0_0_read_psum_en                        (CG_0_0_read_psum_en                        ),
	.CG_0_0_cal_fin                             (CG_0_0_cal_fin                             ),
	.CG_0_0_cg_en                               (CG_0_0_cg_en                               ),
	.CG_0_0_PE_weight_load_en                   (CG_0_0_PE_weight_load_en                   ),
	.CG_0_0_GLB_iact_load_en                    (CG_0_0_GLB_iact_load_en                    ),
	.CG_0_0_src_GLB_load_fin                    (CG_0_0_src_GLB_load_fin                    ),
	.CG_0_0_psum_SRAM_Bank_0_read_out_en        (CG_0_0_psum_SRAM_Bank_0_read_out_en        ),
	.CG_0_0_psum_SRAM_Bank_1_read_out_en        (CG_0_0_psum_SRAM_Bank_1_read_out_en        ),
	.CG_0_0_psum_SRAM_Bank_2_read_out_en        (CG_0_0_psum_SRAM_Bank_2_read_out_en        ),	
	.CG_0_0_PE_0_0_disable						(CG_0_0_PE_0_0_disable						),
	.CG_0_0_PE_0_1_disable                      (CG_0_0_PE_0_1_disable						),
	.CG_0_0_PE_0_2_disable                      (CG_0_0_PE_0_2_disable						),
	.CG_0_0_PE_1_0_disable                      (CG_0_0_PE_1_0_disable						),
	.CG_0_0_PE_1_1_disable                      (CG_0_0_PE_1_1_disable						),
	.CG_0_0_PE_1_2_disable                      (CG_0_0_PE_1_2_disable						),
	.CG_0_0_PE_2_0_disable                      (CG_0_0_PE_2_0_disable						),
	.CG_0_0_PE_2_1_disable                      (CG_0_0_PE_2_1_disable						),
	.CG_0_0_PE_2_2_disable                      (CG_0_0_PE_2_2_disable						),
	.CG_0_0_GLB_iact_0_0_read_addr              (CG_0_0_GLB_iact_0_0_read_addr              ),
	.CG_0_0_GLB_iact_0_1_read_addr              (CG_0_0_GLB_iact_0_1_read_addr              ),
	.CG_0_0_GLB_iact_0_2_read_addr              (CG_0_0_GLB_iact_0_2_read_addr              ),
	.CG_0_0_GLB_iact_1_0_read_addr              (CG_0_0_GLB_iact_1_0_read_addr              ),
	.CG_0_0_GLB_iact_1_1_read_addr              (CG_0_0_GLB_iact_1_1_read_addr              ),
	.CG_0_0_GLB_iact_1_2_read_addr              (CG_0_0_GLB_iact_1_2_read_addr              ),
	.CG_0_0_GLB_iact_2_0_read_addr              (CG_0_0_GLB_iact_2_0_read_addr              ),
	.CG_0_0_GLB_iact_2_1_read_addr              (CG_0_0_GLB_iact_2_1_read_addr              ),
	.CG_0_0_GLB_iact_2_2_read_addr              (CG_0_0_GLB_iact_2_2_read_addr              ),
	.CG_0_0_GLB_psum_write_en                   (CG_0_0_GLB_psum_write_en                   ),
	.CG_0_0_GLB_psum_0_write_addr               (CG_0_0_GLB_psum_0_write_addr               ),
	.CG_0_0_GLB_psum_1_write_addr               (CG_0_0_GLB_psum_1_write_addr               ),
	.CG_0_0_GLB_psum_2_write_addr               (CG_0_0_GLB_psum_2_write_addr               ),
	.CG_0_0_GLB_psum_0_read_addr                (CG_0_0_GLB_psum_0_read_addr                ),
	.CG_0_0_GLB_psum_1_read_addr                (CG_0_0_GLB_psum_1_read_addr                ),
	.CG_0_0_GLB_psum_2_read_addr                (CG_0_0_GLB_psum_2_read_addr                ),
	.CG_0_0_GLB_iact_0_0_address_in_ready       (CG_0_0_GLB_iact_0_0_address_in_ready       ),
	.CG_0_0_GLB_iact_0_0_address_in_valid       (CG_0_0_GLB_iact_0_0_address_in_valid       ),
	.CG_0_0_GLB_iact_0_0_address_in             (CG_0_0_GLB_iact_0_0_address_in             ),
	.CG_0_0_GLB_iact_0_0_data_in_ready          (CG_0_0_GLB_iact_0_0_data_in_ready          ),
	.CG_0_0_GLB_iact_0_0_data_in_valid          (CG_0_0_GLB_iact_0_0_data_in_valid          ),
	.CG_0_0_GLB_iact_0_0_data_in                (CG_0_0_GLB_iact_0_0_data_in                ),
	.CG_0_0_GLB_iact_0_1_address_in_ready       (CG_0_0_GLB_iact_0_1_address_in_ready       ),
	.CG_0_0_GLB_iact_0_1_address_in_valid       (CG_0_0_GLB_iact_0_1_address_in_valid       ),
	.CG_0_0_GLB_iact_0_1_address_in             (CG_0_0_GLB_iact_0_1_address_in             ),
	.CG_0_0_GLB_iact_0_1_data_in_ready          (CG_0_0_GLB_iact_0_1_data_in_ready          ),
	.CG_0_0_GLB_iact_0_1_data_in_valid          (CG_0_0_GLB_iact_0_1_data_in_valid          ),
	.CG_0_0_GLB_iact_0_1_data_in                (CG_0_0_GLB_iact_0_1_data_in                ),
	.CG_0_0_GLB_iact_0_2_address_in_ready       (CG_0_0_GLB_iact_0_2_address_in_ready       ),
	.CG_0_0_GLB_iact_0_2_address_in_valid       (CG_0_0_GLB_iact_0_2_address_in_valid       ),
	.CG_0_0_GLB_iact_0_2_address_in             (CG_0_0_GLB_iact_0_2_address_in             ),
	.CG_0_0_GLB_iact_0_2_data_in_ready          (CG_0_0_GLB_iact_0_2_data_in_ready          ),
	.CG_0_0_GLB_iact_0_2_data_in_valid          (CG_0_0_GLB_iact_0_2_data_in_valid          ),
	.CG_0_0_GLB_iact_0_2_data_in                (CG_0_0_GLB_iact_0_2_data_in                ),
	.CG_0_0_GLB_iact_1_0_address_in_ready       (CG_0_0_GLB_iact_1_0_address_in_ready       ),
	.CG_0_0_GLB_iact_1_0_address_in_valid       (CG_0_0_GLB_iact_1_0_address_in_valid       ),
	.CG_0_0_GLB_iact_1_0_address_in             (CG_0_0_GLB_iact_1_0_address_in             ),
	.CG_0_0_GLB_iact_1_0_data_in_ready          (CG_0_0_GLB_iact_1_0_data_in_ready          ),
	.CG_0_0_GLB_iact_1_0_data_in_valid          (CG_0_0_GLB_iact_1_0_data_in_valid          ),
	.CG_0_0_GLB_iact_1_0_data_in                (CG_0_0_GLB_iact_1_0_data_in                ),
	.CG_0_0_GLB_iact_1_1_address_in_ready       (CG_0_0_GLB_iact_1_1_address_in_ready       ),
	.CG_0_0_GLB_iact_1_1_address_in_valid       (CG_0_0_GLB_iact_1_1_address_in_valid       ),
	.CG_0_0_GLB_iact_1_1_address_in             (CG_0_0_GLB_iact_1_1_address_in             ),
	.CG_0_0_GLB_iact_1_1_data_in_ready          (CG_0_0_GLB_iact_1_1_data_in_ready          ),
	.CG_0_0_GLB_iact_1_1_data_in_valid          (CG_0_0_GLB_iact_1_1_data_in_valid          ),
	.CG_0_0_GLB_iact_1_1_data_in                (CG_0_0_GLB_iact_1_1_data_in                ),
	.CG_0_0_GLB_iact_1_2_address_in_ready       (CG_0_0_GLB_iact_1_2_address_in_ready       ),
	.CG_0_0_GLB_iact_1_2_address_in_valid       (CG_0_0_GLB_iact_1_2_address_in_valid       ),
	.CG_0_0_GLB_iact_1_2_address_in             (CG_0_0_GLB_iact_1_2_address_in             ),
	.CG_0_0_GLB_iact_1_2_data_in_ready          (CG_0_0_GLB_iact_1_2_data_in_ready          ),
	.CG_0_0_GLB_iact_1_2_data_in_valid          (CG_0_0_GLB_iact_1_2_data_in_valid          ),
	.CG_0_0_GLB_iact_1_2_data_in                (CG_0_0_GLB_iact_1_2_data_in                ),
	.CG_0_0_GLB_iact_2_0_address_in_ready       (CG_0_0_GLB_iact_2_0_address_in_ready       ),
	.CG_0_0_GLB_iact_2_0_address_in_valid       (CG_0_0_GLB_iact_2_0_address_in_valid       ),
	.CG_0_0_GLB_iact_2_0_address_in             (CG_0_0_GLB_iact_2_0_address_in             ),
	.CG_0_0_GLB_iact_2_0_data_in_ready          (CG_0_0_GLB_iact_2_0_data_in_ready          ),
	.CG_0_0_GLB_iact_2_0_data_in_valid          (CG_0_0_GLB_iact_2_0_data_in_valid          ),
	.CG_0_0_GLB_iact_2_0_data_in                (CG_0_0_GLB_iact_2_0_data_in                ),
	.CG_0_0_GLB_iact_2_1_address_in_ready       (CG_0_0_GLB_iact_2_1_address_in_ready       ),
	.CG_0_0_GLB_iact_2_1_address_in_valid       (CG_0_0_GLB_iact_2_1_address_in_valid       ),
	.CG_0_0_GLB_iact_2_1_address_in             (CG_0_0_GLB_iact_2_1_address_in             ),
	.CG_0_0_GLB_iact_2_1_data_in_ready          (CG_0_0_GLB_iact_2_1_data_in_ready          ),
	.CG_0_0_GLB_iact_2_1_data_in_valid          (CG_0_0_GLB_iact_2_1_data_in_valid          ),
	.CG_0_0_GLB_iact_2_1_data_in                (CG_0_0_GLB_iact_2_1_data_in                ),
	.CG_0_0_GLB_iact_2_2_address_in_ready       (CG_0_0_GLB_iact_2_2_address_in_ready       ),
	.CG_0_0_GLB_iact_2_2_address_in_valid       (CG_0_0_GLB_iact_2_2_address_in_valid       ),
	.CG_0_0_GLB_iact_2_2_address_in             (CG_0_0_GLB_iact_2_2_address_in             ),
	.CG_0_0_GLB_iact_2_2_data_in_ready          (CG_0_0_GLB_iact_2_2_data_in_ready          ),
	.CG_0_0_GLB_iact_2_2_data_in_valid          (CG_0_0_GLB_iact_2_2_data_in_valid          ),
	.CG_0_0_GLB_iact_2_2_data_in                (CG_0_0_GLB_iact_2_2_data_in                ),
	.CG_0_0_GLB_weight_0_address_in_ready       (CG_0_0_GLB_weight_0_address_in_ready       ),
	.CG_0_0_GLB_weight_0_address_in_valid       (CG_0_0_GLB_weight_0_address_in_valid       ),
	.CG_0_0_GLB_weight_0_address_in             (CG_0_0_GLB_weight_0_address_in             ),
	.CG_0_0_GLB_weight_0_data_in_ready          (CG_0_0_GLB_weight_0_data_in_ready          ),
	.CG_0_0_GLB_weight_0_data_in_valid          (CG_0_0_GLB_weight_0_data_in_valid          ),
	.CG_0_0_GLB_weight_0_data_in                (CG_0_0_GLB_weight_0_data_in                ),
	.CG_0_0_GLB_weight_1_address_in_ready       (CG_0_0_GLB_weight_1_address_in_ready       ),
	.CG_0_0_GLB_weight_1_address_in_valid       (CG_0_0_GLB_weight_1_address_in_valid       ),
	.CG_0_0_GLB_weight_1_address_in             (CG_0_0_GLB_weight_1_address_in             ),
	.CG_0_0_GLB_weight_1_data_in_ready          (CG_0_0_GLB_weight_1_data_in_ready          ),
	.CG_0_0_GLB_weight_1_data_in_valid          (CG_0_0_GLB_weight_1_data_in_valid          ),
	.CG_0_0_GLB_weight_1_data_in                (CG_0_0_GLB_weight_1_data_in                ),
	.CG_0_0_GLB_weight_2_address_in_ready       (CG_0_0_GLB_weight_2_address_in_ready       ),
	.CG_0_0_GLB_weight_2_address_in_valid       (CG_0_0_GLB_weight_2_address_in_valid       ),
	.CG_0_0_GLB_weight_2_address_in             (CG_0_0_GLB_weight_2_address_in             ),
	.CG_0_0_GLB_weight_2_data_in_ready          (CG_0_0_GLB_weight_2_data_in_ready          ),
	.CG_0_0_GLB_weight_2_data_in_valid          (CG_0_0_GLB_weight_2_data_in_valid          ),
	.CG_0_0_GLB_weight_2_data_in                (CG_0_0_GLB_weight_2_data_in                ),
	.CG_0_0_GLB_psum_0_data_in_ready            (CG_0_0_GLB_psum_0_data_in_ready            ),
	.CG_0_0_GLB_psum_0_data_in_valid            (CG_0_0_GLB_psum_0_data_in_valid            ),
	.CG_0_0_GLB_psum_0_data_in                  (CG_0_0_GLB_psum_0_data_in                  ),
	.CG_0_0_GLB_psum_0_data_out_ready           (CG_0_0_GLB_psum_0_data_out_ready           ),
	.CG_0_0_GLB_psum_0_data_out_valid           (CG_0_0_GLB_psum_0_data_out_valid           ),
	.CG_0_0_GLB_psum_0_data_out                 (CG_0_0_GLB_psum_0_data_out                 ),
	.CG_0_0_GLB_psum_1_data_in_ready            (CG_0_0_GLB_psum_1_data_in_ready            ),
	.CG_0_0_GLB_psum_1_data_in_valid            (CG_0_0_GLB_psum_1_data_in_valid            ),
	.CG_0_0_GLB_psum_1_data_in                  (CG_0_0_GLB_psum_1_data_in                  ),
	.CG_0_0_GLB_psum_1_data_out_ready           (CG_0_0_GLB_psum_1_data_out_ready           ),
	.CG_0_0_GLB_psum_1_data_out_valid           (CG_0_0_GLB_psum_1_data_out_valid           ),
	.CG_0_0_GLB_psum_1_data_out                 (CG_0_0_GLB_psum_1_data_out                 ),
	.CG_0_0_GLB_psum_2_data_in_ready            (CG_0_0_GLB_psum_2_data_in_ready            ),
	.CG_0_0_GLB_psum_2_data_in_valid            (CG_0_0_GLB_psum_2_data_in_valid            ),
	.CG_0_0_GLB_psum_2_data_in                  (CG_0_0_GLB_psum_2_data_in                  ),
	.CG_0_0_GLB_psum_2_data_out_ready           (CG_0_0_GLB_psum_2_data_out_ready           ),
	.CG_0_0_GLB_psum_2_data_out_valid           (CG_0_0_GLB_psum_2_data_out_valid           ),
	.CG_0_0_GLB_psum_2_data_out                 (CG_0_0_GLB_psum_2_data_out                 ),
	.CG_0_0_PSUM_DEPTH                          (CG_0_0_PSUM_DEPTH                          ),
	.CG_0_0_psum_spad_clear                     (CG_0_0_psum_spad_clear                     ),
	.CG_0_0_iact_write_fin_clear                (CG_0_0_iact_write_fin_clear                ),
	.CG_0_0_weight_write_fin_clear              (CG_0_0_weight_write_fin_clear              ),
	
	.CG_0_1_PE_cluster_iact_data_in_sel         (CG_0_1_PE_cluster_iact_data_in_sel         ),
	.CG_0_1_PE_cluster_iact_data_out_sel        (CG_0_1_PE_cluster_iact_data_out_sel        ),
	.CG_0_1_PE_cluster_psum_data_in_sel         (CG_0_1_PE_cluster_psum_data_in_sel         ),
	.CG_0_1_router_cluster_iact_data_in_sel     (CG_0_1_router_cluster_iact_data_in_sel     ),
	.CG_0_1_router_cluster_iact_data_out_sel    (CG_0_1_router_cluster_iact_data_out_sel    ),
	.CG_0_1_router_cluster_weight_data_in_sel   (CG_0_1_router_cluster_weight_data_in_sel   ),
	.CG_0_1_router_cluster_weight_data_out_sel  (CG_0_1_router_cluster_weight_data_out_sel  ),
	.CG_0_1_router_cluster_psum_data_in_sel     (CG_0_1_router_cluster_psum_data_in_sel     ),
	.CG_0_1_router_cluster_psum_data_out_sel    (CG_0_1_router_cluster_psum_data_out_sel    ),
	.CG_0_1_read_psum_en                        (CG_0_1_read_psum_en                        ),
	.CG_0_1_cal_fin                             (CG_0_1_cal_fin                             ),
	.CG_0_1_cg_en                               (CG_0_1_cg_en                               ),
	.CG_0_1_PE_weight_load_en                   (CG_0_1_PE_weight_load_en                   ),
	.CG_0_1_GLB_iact_load_en                    (CG_0_1_GLB_iact_load_en                    ),
	.CG_0_1_src_GLB_load_fin                    (CG_0_1_src_GLB_load_fin                    ),
	.CG_0_1_psum_SRAM_Bank_0_read_out_en        (CG_0_1_psum_SRAM_Bank_0_read_out_en        ),
	.CG_0_1_psum_SRAM_Bank_1_read_out_en        (CG_0_1_psum_SRAM_Bank_1_read_out_en        ),
	.CG_0_1_psum_SRAM_Bank_2_read_out_en        (CG_0_1_psum_SRAM_Bank_2_read_out_en        ),
	.CG_0_1_PE_0_0_disable						(CG_0_1_PE_0_0_disable						),
	.CG_0_1_PE_0_1_disable                      (CG_0_1_PE_0_1_disable						),
	.CG_0_1_PE_0_2_disable                      (CG_0_1_PE_0_2_disable						),
	.CG_0_1_PE_1_0_disable                      (CG_0_1_PE_1_0_disable						),
	.CG_0_1_PE_1_1_disable                      (CG_0_1_PE_1_1_disable						),
	.CG_0_1_PE_1_2_disable                      (CG_0_1_PE_1_2_disable						),
	.CG_0_1_PE_2_0_disable                      (CG_0_1_PE_2_0_disable						),
	.CG_0_1_PE_2_1_disable                      (CG_0_1_PE_2_1_disable						),
	.CG_0_1_PE_2_2_disable                      (CG_0_1_PE_2_2_disable						),
	.CG_0_1_GLB_iact_0_0_read_addr              (CG_0_1_GLB_iact_0_0_read_addr              ),
	.CG_0_1_GLB_iact_0_1_read_addr              (CG_0_1_GLB_iact_0_1_read_addr              ),
	.CG_0_1_GLB_iact_0_2_read_addr              (CG_0_1_GLB_iact_0_2_read_addr              ),
	.CG_0_1_GLB_iact_1_0_read_addr              (CG_0_1_GLB_iact_1_0_read_addr              ),
	.CG_0_1_GLB_iact_1_1_read_addr              (CG_0_1_GLB_iact_1_1_read_addr              ),
	.CG_0_1_GLB_iact_1_2_read_addr              (CG_0_1_GLB_iact_1_2_read_addr              ),
	.CG_0_1_GLB_iact_2_0_read_addr              (CG_0_1_GLB_iact_2_0_read_addr              ),
	.CG_0_1_GLB_iact_2_1_read_addr              (CG_0_1_GLB_iact_2_1_read_addr              ),
	.CG_0_1_GLB_iact_2_2_read_addr              (CG_0_1_GLB_iact_2_2_read_addr              ),
	.CG_0_1_GLB_psum_write_en                   (CG_0_1_GLB_psum_write_en                   ),
	.CG_0_1_GLB_psum_0_write_addr               (CG_0_1_GLB_psum_0_write_addr               ),
	.CG_0_1_GLB_psum_1_write_addr               (CG_0_1_GLB_psum_1_write_addr               ),
	.CG_0_1_GLB_psum_2_write_addr               (CG_0_1_GLB_psum_2_write_addr               ),
	.CG_0_1_GLB_psum_0_read_addr                (CG_0_1_GLB_psum_0_read_addr                ),
	.CG_0_1_GLB_psum_1_read_addr                (CG_0_1_GLB_psum_1_read_addr                ),
	.CG_0_1_GLB_psum_2_read_addr                (CG_0_1_GLB_psum_2_read_addr                ),
	.CG_0_1_GLB_iact_0_0_address_in_ready       (CG_0_1_GLB_iact_0_0_address_in_ready       ),
	.CG_0_1_GLB_iact_0_0_address_in_valid       (CG_0_1_GLB_iact_0_0_address_in_valid       ),
	.CG_0_1_GLB_iact_0_0_address_in             (CG_0_1_GLB_iact_0_0_address_in             ),
	.CG_0_1_GLB_iact_0_0_data_in_ready          (CG_0_1_GLB_iact_0_0_data_in_ready          ),
	.CG_0_1_GLB_iact_0_0_data_in_valid          (CG_0_1_GLB_iact_0_0_data_in_valid          ),
	.CG_0_1_GLB_iact_0_0_data_in                (CG_0_1_GLB_iact_0_0_data_in                ),
	.CG_0_1_GLB_iact_0_1_address_in_ready       (CG_0_1_GLB_iact_0_1_address_in_ready       ),
	.CG_0_1_GLB_iact_0_1_address_in_valid       (CG_0_1_GLB_iact_0_1_address_in_valid       ),
	.CG_0_1_GLB_iact_0_1_address_in             (CG_0_1_GLB_iact_0_1_address_in             ),
	.CG_0_1_GLB_iact_0_1_data_in_ready          (CG_0_1_GLB_iact_0_1_data_in_ready          ),
	.CG_0_1_GLB_iact_0_1_data_in_valid          (CG_0_1_GLB_iact_0_1_data_in_valid          ),
	.CG_0_1_GLB_iact_0_1_data_in                (CG_0_1_GLB_iact_0_1_data_in                ),
	.CG_0_1_GLB_iact_0_2_address_in_ready       (CG_0_1_GLB_iact_0_2_address_in_ready       ),
	.CG_0_1_GLB_iact_0_2_address_in_valid       (CG_0_1_GLB_iact_0_2_address_in_valid       ),
	.CG_0_1_GLB_iact_0_2_address_in             (CG_0_1_GLB_iact_0_2_address_in             ),
	.CG_0_1_GLB_iact_0_2_data_in_ready          (CG_0_1_GLB_iact_0_2_data_in_ready          ),
	.CG_0_1_GLB_iact_0_2_data_in_valid          (CG_0_1_GLB_iact_0_2_data_in_valid          ),
	.CG_0_1_GLB_iact_0_2_data_in                (CG_0_1_GLB_iact_0_2_data_in                ),
	.CG_0_1_GLB_iact_1_0_address_in_ready       (CG_0_1_GLB_iact_1_0_address_in_ready       ),
	.CG_0_1_GLB_iact_1_0_address_in_valid       (CG_0_1_GLB_iact_1_0_address_in_valid       ),
	.CG_0_1_GLB_iact_1_0_address_in             (CG_0_1_GLB_iact_1_0_address_in             ),
	.CG_0_1_GLB_iact_1_0_data_in_ready          (CG_0_1_GLB_iact_1_0_data_in_ready          ),
	.CG_0_1_GLB_iact_1_0_data_in_valid          (CG_0_1_GLB_iact_1_0_data_in_valid          ),
	.CG_0_1_GLB_iact_1_0_data_in                (CG_0_1_GLB_iact_1_0_data_in                ),
	.CG_0_1_GLB_iact_1_1_address_in_ready       (CG_0_1_GLB_iact_1_1_address_in_ready       ),
	.CG_0_1_GLB_iact_1_1_address_in_valid       (CG_0_1_GLB_iact_1_1_address_in_valid       ),
	.CG_0_1_GLB_iact_1_1_address_in             (CG_0_1_GLB_iact_1_1_address_in             ),
	.CG_0_1_GLB_iact_1_1_data_in_ready          (CG_0_1_GLB_iact_1_1_data_in_ready          ),
	.CG_0_1_GLB_iact_1_1_data_in_valid          (CG_0_1_GLB_iact_1_1_data_in_valid          ),
	.CG_0_1_GLB_iact_1_1_data_in                (CG_0_1_GLB_iact_1_1_data_in                ),
	.CG_0_1_GLB_iact_1_2_address_in_ready       (CG_0_1_GLB_iact_1_2_address_in_ready       ),
	.CG_0_1_GLB_iact_1_2_address_in_valid       (CG_0_1_GLB_iact_1_2_address_in_valid       ),
	.CG_0_1_GLB_iact_1_2_address_in             (CG_0_1_GLB_iact_1_2_address_in             ),
	.CG_0_1_GLB_iact_1_2_data_in_ready          (CG_0_1_GLB_iact_1_2_data_in_ready          ),
	.CG_0_1_GLB_iact_1_2_data_in_valid          (CG_0_1_GLB_iact_1_2_data_in_valid          ),
	.CG_0_1_GLB_iact_1_2_data_in                (CG_0_1_GLB_iact_1_2_data_in                ),
	.CG_0_1_GLB_iact_2_0_address_in_ready       (CG_0_1_GLB_iact_2_0_address_in_ready       ),
	.CG_0_1_GLB_iact_2_0_address_in_valid       (CG_0_1_GLB_iact_2_0_address_in_valid       ),
	.CG_0_1_GLB_iact_2_0_address_in             (CG_0_1_GLB_iact_2_0_address_in             ),
	.CG_0_1_GLB_iact_2_0_data_in_ready          (CG_0_1_GLB_iact_2_0_data_in_ready          ),
	.CG_0_1_GLB_iact_2_0_data_in_valid          (CG_0_1_GLB_iact_2_0_data_in_valid          ),
	.CG_0_1_GLB_iact_2_0_data_in                (CG_0_1_GLB_iact_2_0_data_in                ),
	.CG_0_1_GLB_iact_2_1_address_in_ready       (CG_0_1_GLB_iact_2_1_address_in_ready       ),
	.CG_0_1_GLB_iact_2_1_address_in_valid       (CG_0_1_GLB_iact_2_1_address_in_valid       ),
	.CG_0_1_GLB_iact_2_1_address_in             (CG_0_1_GLB_iact_2_1_address_in             ),
	.CG_0_1_GLB_iact_2_1_data_in_ready          (CG_0_1_GLB_iact_2_1_data_in_ready          ),
	.CG_0_1_GLB_iact_2_1_data_in_valid          (CG_0_1_GLB_iact_2_1_data_in_valid          ),
	.CG_0_1_GLB_iact_2_1_data_in                (CG_0_1_GLB_iact_2_1_data_in                ),
	.CG_0_1_GLB_iact_2_2_address_in_ready       (CG_0_1_GLB_iact_2_2_address_in_ready       ),
	.CG_0_1_GLB_iact_2_2_address_in_valid       (CG_0_1_GLB_iact_2_2_address_in_valid       ),
	.CG_0_1_GLB_iact_2_2_address_in             (CG_0_1_GLB_iact_2_2_address_in             ),
	.CG_0_1_GLB_iact_2_2_data_in_ready          (CG_0_1_GLB_iact_2_2_data_in_ready          ),
	.CG_0_1_GLB_iact_2_2_data_in_valid          (CG_0_1_GLB_iact_2_2_data_in_valid          ),
	.CG_0_1_GLB_iact_2_2_data_in                (CG_0_1_GLB_iact_2_2_data_in                ),
	.CG_0_1_GLB_weight_0_address_in_ready       (CG_0_1_GLB_weight_0_address_in_ready       ),
	.CG_0_1_GLB_weight_0_address_in_valid       (CG_0_1_GLB_weight_0_address_in_valid       ),
	.CG_0_1_GLB_weight_0_address_in             (CG_0_1_GLB_weight_0_address_in             ),
	.CG_0_1_GLB_weight_0_data_in_ready          (CG_0_1_GLB_weight_0_data_in_ready          ),
	.CG_0_1_GLB_weight_0_data_in_valid          (CG_0_1_GLB_weight_0_data_in_valid          ),
	.CG_0_1_GLB_weight_0_data_in                (CG_0_1_GLB_weight_0_data_in                ),
	.CG_0_1_GLB_weight_1_address_in_ready       (CG_0_1_GLB_weight_1_address_in_ready       ),
	.CG_0_1_GLB_weight_1_address_in_valid       (CG_0_1_GLB_weight_1_address_in_valid       ),
	.CG_0_1_GLB_weight_1_address_in             (CG_0_1_GLB_weight_1_address_in             ),
	.CG_0_1_GLB_weight_1_data_in_ready          (CG_0_1_GLB_weight_1_data_in_ready          ),
	.CG_0_1_GLB_weight_1_data_in_valid          (CG_0_1_GLB_weight_1_data_in_valid          ),
	.CG_0_1_GLB_weight_1_data_in                (CG_0_1_GLB_weight_1_data_in                ),
	.CG_0_1_GLB_weight_2_address_in_ready       (CG_0_1_GLB_weight_2_address_in_ready       ),
	.CG_0_1_GLB_weight_2_address_in_valid       (CG_0_1_GLB_weight_2_address_in_valid       ),
	.CG_0_1_GLB_weight_2_address_in             (CG_0_1_GLB_weight_2_address_in             ),
	.CG_0_1_GLB_weight_2_data_in_ready          (CG_0_1_GLB_weight_2_data_in_ready          ),
	.CG_0_1_GLB_weight_2_data_in_valid          (CG_0_1_GLB_weight_2_data_in_valid          ),
	.CG_0_1_GLB_weight_2_data_in                (CG_0_1_GLB_weight_2_data_in                ),
	.CG_0_1_GLB_psum_0_data_in_ready            (CG_0_1_GLB_psum_0_data_in_ready            ),
	.CG_0_1_GLB_psum_0_data_in_valid            (CG_0_1_GLB_psum_0_data_in_valid            ),
	.CG_0_1_GLB_psum_0_data_in                  (CG_0_1_GLB_psum_0_data_in                  ),
	.CG_0_1_GLB_psum_0_data_out_ready           (CG_0_1_GLB_psum_0_data_out_ready           ),
	.CG_0_1_GLB_psum_0_data_out_valid           (CG_0_1_GLB_psum_0_data_out_valid           ),
	.CG_0_1_GLB_psum_0_data_out                 (CG_0_1_GLB_psum_0_data_out                 ),
	.CG_0_1_GLB_psum_1_data_in_ready            (CG_0_1_GLB_psum_1_data_in_ready            ),
	.CG_0_1_GLB_psum_1_data_in_valid            (CG_0_1_GLB_psum_1_data_in_valid            ),
	.CG_0_1_GLB_psum_1_data_in                  (CG_0_1_GLB_psum_1_data_in                  ),
	.CG_0_1_GLB_psum_1_data_out_ready           (CG_0_1_GLB_psum_1_data_out_ready           ),
	.CG_0_1_GLB_psum_1_data_out_valid           (CG_0_1_GLB_psum_1_data_out_valid           ),
	.CG_0_1_GLB_psum_1_data_out                 (CG_0_1_GLB_psum_1_data_out                 ),
	.CG_0_1_GLB_psum_2_data_in_ready            (CG_0_1_GLB_psum_2_data_in_ready            ),
	.CG_0_1_GLB_psum_2_data_in_valid            (CG_0_1_GLB_psum_2_data_in_valid            ),
	.CG_0_1_GLB_psum_2_data_in                  (CG_0_1_GLB_psum_2_data_in                  ),
	.CG_0_1_GLB_psum_2_data_out_ready           (CG_0_1_GLB_psum_2_data_out_ready           ),
	.CG_0_1_GLB_psum_2_data_out_valid           (CG_0_1_GLB_psum_2_data_out_valid           ),
	.CG_0_1_GLB_psum_2_data_out                 (CG_0_1_GLB_psum_2_data_out                 ),
	.CG_0_1_PSUM_DEPTH                          (CG_0_1_PSUM_DEPTH                          ),
	.CG_0_1_psum_spad_clear                     (CG_0_1_psum_spad_clear                     ),
	.CG_0_1_iact_write_fin_clear                (CG_0_1_iact_write_fin_clear                ),
	.CG_0_1_weight_write_fin_clear              (CG_0_1_weight_write_fin_clear              ),
	
	.CG_1_0_PE_cluster_iact_data_in_sel         (CG_1_0_PE_cluster_iact_data_in_sel         ),
	.CG_1_0_PE_cluster_iact_data_out_sel        (CG_1_0_PE_cluster_iact_data_out_sel        ),
	.CG_1_0_PE_cluster_psum_data_in_sel         (CG_1_0_PE_cluster_psum_data_in_sel         ),
	.CG_1_0_router_cluster_iact_data_in_sel     (CG_1_0_router_cluster_iact_data_in_sel     ),
	.CG_1_0_router_cluster_iact_data_out_sel    (CG_1_0_router_cluster_iact_data_out_sel    ),
	.CG_1_0_router_cluster_weight_data_in_sel   (CG_1_0_router_cluster_weight_data_in_sel   ),
	.CG_1_0_router_cluster_weight_data_out_sel  (CG_1_0_router_cluster_weight_data_out_sel  ),
	.CG_1_0_router_cluster_psum_data_in_sel     (CG_1_0_router_cluster_psum_data_in_sel     ),
	.CG_1_0_router_cluster_psum_data_out_sel    (CG_1_0_router_cluster_psum_data_out_sel    ),
	.CG_1_0_read_psum_en                        (CG_1_0_read_psum_en                        ),
	.CG_1_0_cal_fin                             (CG_1_0_cal_fin                             ),
	.CG_1_0_cg_en                               (CG_1_0_cg_en                               ),
	.CG_1_0_PE_weight_load_en                   (CG_1_0_PE_weight_load_en                   ),
	.CG_1_0_GLB_iact_load_en                    (CG_1_0_GLB_iact_load_en                    ),
	.CG_1_0_src_GLB_load_fin                    (CG_1_0_src_GLB_load_fin                    ),
	.CG_1_0_psum_SRAM_Bank_0_read_out_en        (CG_1_0_psum_SRAM_Bank_0_read_out_en        ),
	.CG_1_0_psum_SRAM_Bank_1_read_out_en        (CG_1_0_psum_SRAM_Bank_1_read_out_en        ),
	.CG_1_0_psum_SRAM_Bank_2_read_out_en        (CG_1_0_psum_SRAM_Bank_2_read_out_en        ),
	.CG_1_0_PE_0_0_disable						(CG_1_0_PE_0_0_disable						),
	.CG_1_0_PE_0_1_disable                      (CG_1_0_PE_0_1_disable						),
	.CG_1_0_PE_0_2_disable                      (CG_1_0_PE_0_2_disable						),
	.CG_1_0_PE_1_0_disable                      (CG_1_0_PE_1_0_disable						),
	.CG_1_0_PE_1_1_disable                      (CG_1_0_PE_1_1_disable						),
	.CG_1_0_PE_1_2_disable                      (CG_1_0_PE_1_2_disable						),
	.CG_1_0_PE_2_0_disable                      (CG_1_0_PE_2_0_disable						),
	.CG_1_0_PE_2_1_disable                      (CG_1_0_PE_2_1_disable						),
	.CG_1_0_PE_2_2_disable                      (CG_1_0_PE_2_2_disable						),
	.CG_1_0_GLB_iact_0_0_read_addr              (CG_1_0_GLB_iact_0_0_read_addr              ),
	.CG_1_0_GLB_iact_0_1_read_addr              (CG_1_0_GLB_iact_0_1_read_addr              ),
	.CG_1_0_GLB_iact_0_2_read_addr              (CG_1_0_GLB_iact_0_2_read_addr              ),
	.CG_1_0_GLB_iact_1_0_read_addr              (CG_1_0_GLB_iact_1_0_read_addr              ),
	.CG_1_0_GLB_iact_1_1_read_addr              (CG_1_0_GLB_iact_1_1_read_addr              ),
	.CG_1_0_GLB_iact_1_2_read_addr              (CG_1_0_GLB_iact_1_2_read_addr              ),
	.CG_1_0_GLB_iact_2_0_read_addr              (CG_1_0_GLB_iact_2_0_read_addr              ),
	.CG_1_0_GLB_iact_2_1_read_addr              (CG_1_0_GLB_iact_2_1_read_addr              ),
	.CG_1_0_GLB_iact_2_2_read_addr              (CG_1_0_GLB_iact_2_2_read_addr              ),
	.CG_1_0_GLB_psum_write_en                   (CG_1_0_GLB_psum_write_en                   ),
	.CG_1_0_GLB_psum_0_write_addr               (CG_1_0_GLB_psum_0_write_addr               ),
	.CG_1_0_GLB_psum_1_write_addr               (CG_1_0_GLB_psum_1_write_addr               ),
	.CG_1_0_GLB_psum_2_write_addr               (CG_1_0_GLB_psum_2_write_addr               ),
	.CG_1_0_GLB_psum_0_read_addr                (CG_1_0_GLB_psum_0_read_addr                ),
	.CG_1_0_GLB_psum_1_read_addr                (CG_1_0_GLB_psum_1_read_addr                ),
	.CG_1_0_GLB_psum_2_read_addr                (CG_1_0_GLB_psum_2_read_addr                ),
	.CG_1_0_GLB_iact_0_0_address_in_ready       (CG_1_0_GLB_iact_0_0_address_in_ready       ),
	.CG_1_0_GLB_iact_0_0_address_in_valid       (CG_1_0_GLB_iact_0_0_address_in_valid       ),
	.CG_1_0_GLB_iact_0_0_address_in             (CG_1_0_GLB_iact_0_0_address_in             ),
	.CG_1_0_GLB_iact_0_0_data_in_ready          (CG_1_0_GLB_iact_0_0_data_in_ready          ),
	.CG_1_0_GLB_iact_0_0_data_in_valid          (CG_1_0_GLB_iact_0_0_data_in_valid          ),
	.CG_1_0_GLB_iact_0_0_data_in                (CG_1_0_GLB_iact_0_0_data_in                ),
	.CG_1_0_GLB_iact_0_1_address_in_ready       (CG_1_0_GLB_iact_0_1_address_in_ready       ),
	.CG_1_0_GLB_iact_0_1_address_in_valid       (CG_1_0_GLB_iact_0_1_address_in_valid       ),
	.CG_1_0_GLB_iact_0_1_address_in             (CG_1_0_GLB_iact_0_1_address_in             ),
	.CG_1_0_GLB_iact_0_1_data_in_ready          (CG_1_0_GLB_iact_0_1_data_in_ready          ),
	.CG_1_0_GLB_iact_0_1_data_in_valid          (CG_1_0_GLB_iact_0_1_data_in_valid          ),
	.CG_1_0_GLB_iact_0_1_data_in                (CG_1_0_GLB_iact_0_1_data_in                ),
	.CG_1_0_GLB_iact_0_2_address_in_ready       (CG_1_0_GLB_iact_0_2_address_in_ready       ),
	.CG_1_0_GLB_iact_0_2_address_in_valid       (CG_1_0_GLB_iact_0_2_address_in_valid       ),
	.CG_1_0_GLB_iact_0_2_address_in             (CG_1_0_GLB_iact_0_2_address_in             ),
	.CG_1_0_GLB_iact_0_2_data_in_ready          (CG_1_0_GLB_iact_0_2_data_in_ready          ),
	.CG_1_0_GLB_iact_0_2_data_in_valid          (CG_1_0_GLB_iact_0_2_data_in_valid          ),
	.CG_1_0_GLB_iact_0_2_data_in                (CG_1_0_GLB_iact_0_2_data_in                ),
	.CG_1_0_GLB_iact_1_0_address_in_ready       (CG_1_0_GLB_iact_1_0_address_in_ready       ),
	.CG_1_0_GLB_iact_1_0_address_in_valid       (CG_1_0_GLB_iact_1_0_address_in_valid       ),
	.CG_1_0_GLB_iact_1_0_address_in             (CG_1_0_GLB_iact_1_0_address_in             ),
	.CG_1_0_GLB_iact_1_0_data_in_ready          (CG_1_0_GLB_iact_1_0_data_in_ready          ),
	.CG_1_0_GLB_iact_1_0_data_in_valid          (CG_1_0_GLB_iact_1_0_data_in_valid          ),
	.CG_1_0_GLB_iact_1_0_data_in                (CG_1_0_GLB_iact_1_0_data_in                ),
	.CG_1_0_GLB_iact_1_1_address_in_ready       (CG_1_0_GLB_iact_1_1_address_in_ready       ),
	.CG_1_0_GLB_iact_1_1_address_in_valid       (CG_1_0_GLB_iact_1_1_address_in_valid       ),
	.CG_1_0_GLB_iact_1_1_address_in             (CG_1_0_GLB_iact_1_1_address_in             ),
	.CG_1_0_GLB_iact_1_1_data_in_ready          (CG_1_0_GLB_iact_1_1_data_in_ready          ),
	.CG_1_0_GLB_iact_1_1_data_in_valid          (CG_1_0_GLB_iact_1_1_data_in_valid          ),
	.CG_1_0_GLB_iact_1_1_data_in                (CG_1_0_GLB_iact_1_1_data_in                ),
	.CG_1_0_GLB_iact_1_2_address_in_ready       (CG_1_0_GLB_iact_1_2_address_in_ready       ),
	.CG_1_0_GLB_iact_1_2_address_in_valid       (CG_1_0_GLB_iact_1_2_address_in_valid       ),
	.CG_1_0_GLB_iact_1_2_address_in             (CG_1_0_GLB_iact_1_2_address_in             ),
	.CG_1_0_GLB_iact_1_2_data_in_ready          (CG_1_0_GLB_iact_1_2_data_in_ready          ),
	.CG_1_0_GLB_iact_1_2_data_in_valid          (CG_1_0_GLB_iact_1_2_data_in_valid          ),
	.CG_1_0_GLB_iact_1_2_data_in                (CG_1_0_GLB_iact_1_2_data_in                ),
	.CG_1_0_GLB_iact_2_0_address_in_ready       (CG_1_0_GLB_iact_2_0_address_in_ready       ),
	.CG_1_0_GLB_iact_2_0_address_in_valid       (CG_1_0_GLB_iact_2_0_address_in_valid       ),
	.CG_1_0_GLB_iact_2_0_address_in             (CG_1_0_GLB_iact_2_0_address_in             ),
	.CG_1_0_GLB_iact_2_0_data_in_ready          (CG_1_0_GLB_iact_2_0_data_in_ready          ),
	.CG_1_0_GLB_iact_2_0_data_in_valid          (CG_1_0_GLB_iact_2_0_data_in_valid          ),
	.CG_1_0_GLB_iact_2_0_data_in                (CG_1_0_GLB_iact_2_0_data_in                ),
	.CG_1_0_GLB_iact_2_1_address_in_ready       (CG_1_0_GLB_iact_2_1_address_in_ready       ),
	.CG_1_0_GLB_iact_2_1_address_in_valid       (CG_1_0_GLB_iact_2_1_address_in_valid       ),
	.CG_1_0_GLB_iact_2_1_address_in             (CG_1_0_GLB_iact_2_1_address_in             ),
	.CG_1_0_GLB_iact_2_1_data_in_ready          (CG_1_0_GLB_iact_2_1_data_in_ready          ),
	.CG_1_0_GLB_iact_2_1_data_in_valid          (CG_1_0_GLB_iact_2_1_data_in_valid          ),
	.CG_1_0_GLB_iact_2_1_data_in                (CG_1_0_GLB_iact_2_1_data_in                ),
	.CG_1_0_GLB_iact_2_2_address_in_ready       (CG_1_0_GLB_iact_2_2_address_in_ready       ),
	.CG_1_0_GLB_iact_2_2_address_in_valid       (CG_1_0_GLB_iact_2_2_address_in_valid       ),
	.CG_1_0_GLB_iact_2_2_address_in             (CG_1_0_GLB_iact_2_2_address_in             ),
	.CG_1_0_GLB_iact_2_2_data_in_ready          (CG_1_0_GLB_iact_2_2_data_in_ready          ),
	.CG_1_0_GLB_iact_2_2_data_in_valid          (CG_1_0_GLB_iact_2_2_data_in_valid          ),
	.CG_1_0_GLB_iact_2_2_data_in                (CG_1_0_GLB_iact_2_2_data_in                ),
	.CG_1_0_GLB_weight_0_address_in_ready       (CG_1_0_GLB_weight_0_address_in_ready       ),
	.CG_1_0_GLB_weight_0_address_in_valid       (CG_1_0_GLB_weight_0_address_in_valid       ),
	.CG_1_0_GLB_weight_0_address_in             (CG_1_0_GLB_weight_0_address_in             ),
	.CG_1_0_GLB_weight_0_data_in_ready          (CG_1_0_GLB_weight_0_data_in_ready          ),
	.CG_1_0_GLB_weight_0_data_in_valid          (CG_1_0_GLB_weight_0_data_in_valid          ),
	.CG_1_0_GLB_weight_0_data_in                (CG_1_0_GLB_weight_0_data_in                ),
	.CG_1_0_GLB_weight_1_address_in_ready       (CG_1_0_GLB_weight_1_address_in_ready       ),
	.CG_1_0_GLB_weight_1_address_in_valid       (CG_1_0_GLB_weight_1_address_in_valid       ),
	.CG_1_0_GLB_weight_1_address_in             (CG_1_0_GLB_weight_1_address_in             ),
	.CG_1_0_GLB_weight_1_data_in_ready          (CG_1_0_GLB_weight_1_data_in_ready          ),
	.CG_1_0_GLB_weight_1_data_in_valid          (CG_1_0_GLB_weight_1_data_in_valid          ),
	.CG_1_0_GLB_weight_1_data_in                (CG_1_0_GLB_weight_1_data_in                ),
	.CG_1_0_GLB_weight_2_address_in_ready       (CG_1_0_GLB_weight_2_address_in_ready       ),
	.CG_1_0_GLB_weight_2_address_in_valid       (CG_1_0_GLB_weight_2_address_in_valid       ),
	.CG_1_0_GLB_weight_2_address_in             (CG_1_0_GLB_weight_2_address_in             ),
	.CG_1_0_GLB_weight_2_data_in_ready          (CG_1_0_GLB_weight_2_data_in_ready          ),
	.CG_1_0_GLB_weight_2_data_in_valid          (CG_1_0_GLB_weight_2_data_in_valid          ),
	.CG_1_0_GLB_weight_2_data_in                (CG_1_0_GLB_weight_2_data_in                ),
	.CG_1_0_GLB_psum_0_data_in_ready            (CG_1_0_GLB_psum_0_data_in_ready            ),
	.CG_1_0_GLB_psum_0_data_in_valid            (CG_1_0_GLB_psum_0_data_in_valid            ),
	.CG_1_0_GLB_psum_0_data_in                  (CG_1_0_GLB_psum_0_data_in                  ),
	.CG_1_0_GLB_psum_0_data_out_ready           (CG_1_0_GLB_psum_0_data_out_ready           ),
	.CG_1_0_GLB_psum_0_data_out_valid           (CG_1_0_GLB_psum_0_data_out_valid           ),
	.CG_1_0_GLB_psum_0_data_out                 (CG_1_0_GLB_psum_0_data_out                 ),
	.CG_1_0_GLB_psum_1_data_in_ready            (CG_1_0_GLB_psum_1_data_in_ready            ),
	.CG_1_0_GLB_psum_1_data_in_valid            (CG_1_0_GLB_psum_1_data_in_valid            ),
	.CG_1_0_GLB_psum_1_data_in                  (CG_1_0_GLB_psum_1_data_in                  ),
	.CG_1_0_GLB_psum_1_data_out_ready           (CG_1_0_GLB_psum_1_data_out_ready           ),
	.CG_1_0_GLB_psum_1_data_out_valid           (CG_1_0_GLB_psum_1_data_out_valid           ),
	.CG_1_0_GLB_psum_1_data_out                 (CG_1_0_GLB_psum_1_data_out                 ),
	.CG_1_0_GLB_psum_2_data_in_ready            (CG_1_0_GLB_psum_2_data_in_ready            ),
	.CG_1_0_GLB_psum_2_data_in_valid            (CG_1_0_GLB_psum_2_data_in_valid            ),
	.CG_1_0_GLB_psum_2_data_in                  (CG_1_0_GLB_psum_2_data_in                  ),
	.CG_1_0_GLB_psum_2_data_out_ready           (CG_1_0_GLB_psum_2_data_out_ready           ),
	.CG_1_0_GLB_psum_2_data_out_valid           (CG_1_0_GLB_psum_2_data_out_valid           ),
	.CG_1_0_GLB_psum_2_data_out                 (CG_1_0_GLB_psum_2_data_out                 ),
	.CG_1_0_PSUM_DEPTH                          (CG_1_0_PSUM_DEPTH                          ),
	.CG_1_0_psum_spad_clear                     (CG_1_0_psum_spad_clear                     ),
	.CG_1_0_iact_write_fin_clear                (CG_1_0_iact_write_fin_clear                ),
	.CG_1_0_weight_write_fin_clear              (CG_1_0_weight_write_fin_clear              ),
	
	.CG_1_1_PE_cluster_iact_data_in_sel         (CG_1_1_PE_cluster_iact_data_in_sel         ),
	.CG_1_1_PE_cluster_iact_data_out_sel        (CG_1_1_PE_cluster_iact_data_out_sel        ),
	.CG_1_1_PE_cluster_psum_data_in_sel         (CG_1_1_PE_cluster_psum_data_in_sel         ),
	.CG_1_1_router_cluster_iact_data_in_sel     (CG_1_1_router_cluster_iact_data_in_sel     ),
	.CG_1_1_router_cluster_iact_data_out_sel    (CG_1_1_router_cluster_iact_data_out_sel    ),
	.CG_1_1_router_cluster_weight_data_in_sel   (CG_1_1_router_cluster_weight_data_in_sel   ),
	.CG_1_1_router_cluster_weight_data_out_sel  (CG_1_1_router_cluster_weight_data_out_sel  ),
	.CG_1_1_router_cluster_psum_data_in_sel     (CG_1_1_router_cluster_psum_data_in_sel     ),
	.CG_1_1_router_cluster_psum_data_out_sel    (CG_1_1_router_cluster_psum_data_out_sel    ),
	.CG_1_1_read_psum_en                        (CG_1_1_read_psum_en                        ),
	.CG_1_1_cal_fin                             (CG_1_1_cal_fin                             ),
	.CG_1_1_cg_en                               (CG_1_1_cg_en                               ),
	.CG_1_1_PE_weight_load_en                   (CG_1_1_PE_weight_load_en                   ),
	.CG_1_1_GLB_iact_load_en                    (CG_1_1_GLB_iact_load_en                    ),
	.CG_1_1_src_GLB_load_fin                    (CG_1_1_src_GLB_load_fin                    ),
	.CG_1_1_psum_SRAM_Bank_0_read_out_en        (CG_1_1_psum_SRAM_Bank_0_read_out_en        ),
	.CG_1_1_psum_SRAM_Bank_1_read_out_en        (CG_1_1_psum_SRAM_Bank_1_read_out_en        ),
	.CG_1_1_psum_SRAM_Bank_2_read_out_en        (CG_1_1_psum_SRAM_Bank_2_read_out_en        ),
	.CG_1_1_PE_0_0_disable						(CG_1_1_PE_0_0_disable						),
	.CG_1_1_PE_0_1_disable                      (CG_1_1_PE_0_1_disable						),
	.CG_1_1_PE_0_2_disable                      (CG_1_1_PE_0_2_disable						),
	.CG_1_1_PE_1_0_disable                      (CG_1_1_PE_1_0_disable						),
	.CG_1_1_PE_1_1_disable                      (CG_1_1_PE_1_1_disable						),
	.CG_1_1_PE_1_2_disable                      (CG_1_1_PE_1_2_disable						),
	.CG_1_1_PE_2_0_disable                      (CG_1_1_PE_2_0_disable						),
	.CG_1_1_PE_2_1_disable                      (CG_1_1_PE_2_1_disable						),
	.CG_1_1_PE_2_2_disable                      (CG_1_1_PE_2_2_disable						),
	.CG_1_1_GLB_iact_0_0_read_addr              (CG_1_1_GLB_iact_0_0_read_addr              ),
	.CG_1_1_GLB_iact_0_1_read_addr              (CG_1_1_GLB_iact_0_1_read_addr              ),
	.CG_1_1_GLB_iact_0_2_read_addr              (CG_1_1_GLB_iact_0_2_read_addr              ),
	.CG_1_1_GLB_iact_1_0_read_addr              (CG_1_1_GLB_iact_1_0_read_addr              ),
	.CG_1_1_GLB_iact_1_1_read_addr              (CG_1_1_GLB_iact_1_1_read_addr              ),
	.CG_1_1_GLB_iact_1_2_read_addr              (CG_1_1_GLB_iact_1_2_read_addr              ),
	.CG_1_1_GLB_iact_2_0_read_addr              (CG_1_1_GLB_iact_2_0_read_addr              ),
	.CG_1_1_GLB_iact_2_1_read_addr              (CG_1_1_GLB_iact_2_1_read_addr              ),
	.CG_1_1_GLB_iact_2_2_read_addr              (CG_1_1_GLB_iact_2_2_read_addr              ),
	.CG_1_1_GLB_psum_write_en                   (CG_1_1_GLB_psum_write_en                   ),
	.CG_1_1_GLB_psum_0_write_addr               (CG_1_1_GLB_psum_0_write_addr               ),
	.CG_1_1_GLB_psum_1_write_addr               (CG_1_1_GLB_psum_1_write_addr               ),
	.CG_1_1_GLB_psum_2_write_addr               (CG_1_1_GLB_psum_2_write_addr               ),
	.CG_1_1_GLB_psum_0_read_addr                (CG_1_1_GLB_psum_0_read_addr                ),
	.CG_1_1_GLB_psum_1_read_addr                (CG_1_1_GLB_psum_1_read_addr                ),
	.CG_1_1_GLB_psum_2_read_addr                (CG_1_1_GLB_psum_2_read_addr                ),
	.CG_1_1_GLB_iact_0_0_address_in_ready       (CG_1_1_GLB_iact_0_0_address_in_ready       ),
	.CG_1_1_GLB_iact_0_0_address_in_valid       (CG_1_1_GLB_iact_0_0_address_in_valid       ),
	.CG_1_1_GLB_iact_0_0_address_in             (CG_1_1_GLB_iact_0_0_address_in             ),
	.CG_1_1_GLB_iact_0_0_data_in_ready          (CG_1_1_GLB_iact_0_0_data_in_ready          ),
	.CG_1_1_GLB_iact_0_0_data_in_valid          (CG_1_1_GLB_iact_0_0_data_in_valid          ),
	.CG_1_1_GLB_iact_0_0_data_in                (CG_1_1_GLB_iact_0_0_data_in                ),
	.CG_1_1_GLB_iact_0_1_address_in_ready       (CG_1_1_GLB_iact_0_1_address_in_ready       ),
	.CG_1_1_GLB_iact_0_1_address_in_valid       (CG_1_1_GLB_iact_0_1_address_in_valid       ),
	.CG_1_1_GLB_iact_0_1_address_in             (CG_1_1_GLB_iact_0_1_address_in             ),
	.CG_1_1_GLB_iact_0_1_data_in_ready          (CG_1_1_GLB_iact_0_1_data_in_ready          ),
	.CG_1_1_GLB_iact_0_1_data_in_valid          (CG_1_1_GLB_iact_0_1_data_in_valid          ),
	.CG_1_1_GLB_iact_0_1_data_in                (CG_1_1_GLB_iact_0_1_data_in                ),
	.CG_1_1_GLB_iact_0_2_address_in_ready       (CG_1_1_GLB_iact_0_2_address_in_ready       ),
	.CG_1_1_GLB_iact_0_2_address_in_valid       (CG_1_1_GLB_iact_0_2_address_in_valid       ),
	.CG_1_1_GLB_iact_0_2_address_in             (CG_1_1_GLB_iact_0_2_address_in             ),
	.CG_1_1_GLB_iact_0_2_data_in_ready          (CG_1_1_GLB_iact_0_2_data_in_ready          ),
	.CG_1_1_GLB_iact_0_2_data_in_valid          (CG_1_1_GLB_iact_0_2_data_in_valid          ),
	.CG_1_1_GLB_iact_0_2_data_in                (CG_1_1_GLB_iact_0_2_data_in                ),
	.CG_1_1_GLB_iact_1_0_address_in_ready       (CG_1_1_GLB_iact_1_0_address_in_ready       ),
	.CG_1_1_GLB_iact_1_0_address_in_valid       (CG_1_1_GLB_iact_1_0_address_in_valid       ),
	.CG_1_1_GLB_iact_1_0_address_in             (CG_1_1_GLB_iact_1_0_address_in             ),
	.CG_1_1_GLB_iact_1_0_data_in_ready          (CG_1_1_GLB_iact_1_0_data_in_ready          ),
	.CG_1_1_GLB_iact_1_0_data_in_valid          (CG_1_1_GLB_iact_1_0_data_in_valid          ),
	.CG_1_1_GLB_iact_1_0_data_in                (CG_1_1_GLB_iact_1_0_data_in                ),
	.CG_1_1_GLB_iact_1_1_address_in_ready       (CG_1_1_GLB_iact_1_1_address_in_ready       ),
	.CG_1_1_GLB_iact_1_1_address_in_valid       (CG_1_1_GLB_iact_1_1_address_in_valid       ),
	.CG_1_1_GLB_iact_1_1_address_in             (CG_1_1_GLB_iact_1_1_address_in             ),
	.CG_1_1_GLB_iact_1_1_data_in_ready          (CG_1_1_GLB_iact_1_1_data_in_ready          ),
	.CG_1_1_GLB_iact_1_1_data_in_valid          (CG_1_1_GLB_iact_1_1_data_in_valid          ),
	.CG_1_1_GLB_iact_1_1_data_in                (CG_1_1_GLB_iact_1_1_data_in                ),
	.CG_1_1_GLB_iact_1_2_address_in_ready       (CG_1_1_GLB_iact_1_2_address_in_ready       ),
	.CG_1_1_GLB_iact_1_2_address_in_valid       (CG_1_1_GLB_iact_1_2_address_in_valid       ),
	.CG_1_1_GLB_iact_1_2_address_in             (CG_1_1_GLB_iact_1_2_address_in             ),
	.CG_1_1_GLB_iact_1_2_data_in_ready          (CG_1_1_GLB_iact_1_2_data_in_ready          ),
	.CG_1_1_GLB_iact_1_2_data_in_valid          (CG_1_1_GLB_iact_1_2_data_in_valid          ),
	.CG_1_1_GLB_iact_1_2_data_in                (CG_1_1_GLB_iact_1_2_data_in                ),
	.CG_1_1_GLB_iact_2_0_address_in_ready       (CG_1_1_GLB_iact_2_0_address_in_ready       ),
	.CG_1_1_GLB_iact_2_0_address_in_valid       (CG_1_1_GLB_iact_2_0_address_in_valid       ),
	.CG_1_1_GLB_iact_2_0_address_in             (CG_1_1_GLB_iact_2_0_address_in             ),
	.CG_1_1_GLB_iact_2_0_data_in_ready          (CG_1_1_GLB_iact_2_0_data_in_ready          ),
	.CG_1_1_GLB_iact_2_0_data_in_valid          (CG_1_1_GLB_iact_2_0_data_in_valid          ),
	.CG_1_1_GLB_iact_2_0_data_in                (CG_1_1_GLB_iact_2_0_data_in                ),
	.CG_1_1_GLB_iact_2_1_address_in_ready       (CG_1_1_GLB_iact_2_1_address_in_ready       ),
	.CG_1_1_GLB_iact_2_1_address_in_valid       (CG_1_1_GLB_iact_2_1_address_in_valid       ),
	.CG_1_1_GLB_iact_2_1_address_in             (CG_1_1_GLB_iact_2_1_address_in             ),
	.CG_1_1_GLB_iact_2_1_data_in_ready          (CG_1_1_GLB_iact_2_1_data_in_ready          ),
	.CG_1_1_GLB_iact_2_1_data_in_valid          (CG_1_1_GLB_iact_2_1_data_in_valid          ),
	.CG_1_1_GLB_iact_2_1_data_in                (CG_1_1_GLB_iact_2_1_data_in                ),
	.CG_1_1_GLB_iact_2_2_address_in_ready       (CG_1_1_GLB_iact_2_2_address_in_ready       ),
	.CG_1_1_GLB_iact_2_2_address_in_valid       (CG_1_1_GLB_iact_2_2_address_in_valid       ),
	.CG_1_1_GLB_iact_2_2_address_in             (CG_1_1_GLB_iact_2_2_address_in             ),
	.CG_1_1_GLB_iact_2_2_data_in_ready          (CG_1_1_GLB_iact_2_2_data_in_ready          ),
	.CG_1_1_GLB_iact_2_2_data_in_valid          (CG_1_1_GLB_iact_2_2_data_in_valid          ),
	.CG_1_1_GLB_iact_2_2_data_in                (CG_1_1_GLB_iact_2_2_data_in                ),
	.CG_1_1_GLB_weight_0_address_in_ready       (CG_1_1_GLB_weight_0_address_in_ready       ),
	.CG_1_1_GLB_weight_0_address_in_valid       (CG_1_1_GLB_weight_0_address_in_valid       ),
	.CG_1_1_GLB_weight_0_address_in             (CG_1_1_GLB_weight_0_address_in             ),
	.CG_1_1_GLB_weight_0_data_in_ready          (CG_1_1_GLB_weight_0_data_in_ready          ),
	.CG_1_1_GLB_weight_0_data_in_valid          (CG_1_1_GLB_weight_0_data_in_valid          ),
	.CG_1_1_GLB_weight_0_data_in                (CG_1_1_GLB_weight_0_data_in                ),
	.CG_1_1_GLB_weight_1_address_in_ready       (CG_1_1_GLB_weight_1_address_in_ready       ),
	.CG_1_1_GLB_weight_1_address_in_valid       (CG_1_1_GLB_weight_1_address_in_valid       ),
	.CG_1_1_GLB_weight_1_address_in             (CG_1_1_GLB_weight_1_address_in             ),
	.CG_1_1_GLB_weight_1_data_in_ready          (CG_1_1_GLB_weight_1_data_in_ready          ),
	.CG_1_1_GLB_weight_1_data_in_valid          (CG_1_1_GLB_weight_1_data_in_valid          ),
	.CG_1_1_GLB_weight_1_data_in                (CG_1_1_GLB_weight_1_data_in                ),
	.CG_1_1_GLB_weight_2_address_in_ready       (CG_1_1_GLB_weight_2_address_in_ready       ),
	.CG_1_1_GLB_weight_2_address_in_valid       (CG_1_1_GLB_weight_2_address_in_valid       ),
	.CG_1_1_GLB_weight_2_address_in             (CG_1_1_GLB_weight_2_address_in             ),
	.CG_1_1_GLB_weight_2_data_in_ready          (CG_1_1_GLB_weight_2_data_in_ready          ),
	.CG_1_1_GLB_weight_2_data_in_valid          (CG_1_1_GLB_weight_2_data_in_valid          ),
	.CG_1_1_GLB_weight_2_data_in                (CG_1_1_GLB_weight_2_data_in                ),
	.CG_1_1_GLB_psum_0_data_in_ready            (CG_1_1_GLB_psum_0_data_in_ready            ),
	.CG_1_1_GLB_psum_0_data_in_valid            (CG_1_1_GLB_psum_0_data_in_valid            ),
	.CG_1_1_GLB_psum_0_data_in                  (CG_1_1_GLB_psum_0_data_in                  ),
	.CG_1_1_GLB_psum_0_data_out_ready           (CG_1_1_GLB_psum_0_data_out_ready           ),
	.CG_1_1_GLB_psum_0_data_out_valid           (CG_1_1_GLB_psum_0_data_out_valid           ),
	.CG_1_1_GLB_psum_0_data_out                 (CG_1_1_GLB_psum_0_data_out                 ),
	.CG_1_1_GLB_psum_1_data_in_ready            (CG_1_1_GLB_psum_1_data_in_ready            ),
	.CG_1_1_GLB_psum_1_data_in_valid            (CG_1_1_GLB_psum_1_data_in_valid            ),
	.CG_1_1_GLB_psum_1_data_in                  (CG_1_1_GLB_psum_1_data_in                  ),
	.CG_1_1_GLB_psum_1_data_out_ready           (CG_1_1_GLB_psum_1_data_out_ready           ),
	.CG_1_1_GLB_psum_1_data_out_valid           (CG_1_1_GLB_psum_1_data_out_valid           ),
	.CG_1_1_GLB_psum_1_data_out                 (CG_1_1_GLB_psum_1_data_out                 ),
	.CG_1_1_GLB_psum_2_data_in_ready            (CG_1_1_GLB_psum_2_data_in_ready            ),
	.CG_1_1_GLB_psum_2_data_in_valid            (CG_1_1_GLB_psum_2_data_in_valid            ),
	.CG_1_1_GLB_psum_2_data_in                  (CG_1_1_GLB_psum_2_data_in                  ),
	.CG_1_1_GLB_psum_2_data_out_ready           (CG_1_1_GLB_psum_2_data_out_ready           ),
	.CG_1_1_GLB_psum_2_data_out_valid           (CG_1_1_GLB_psum_2_data_out_valid           ),
	.CG_1_1_GLB_psum_2_data_out                 (CG_1_1_GLB_psum_2_data_out                 ),
	.CG_1_1_PSUM_DEPTH                          (CG_1_1_PSUM_DEPTH                          ),
	.CG_1_1_psum_spad_clear                     (CG_1_1_psum_spad_clear                     ),
	.CG_1_1_iact_write_fin_clear                (CG_1_1_iact_write_fin_clear                ),
	.CG_1_1_weight_write_fin_clear              (CG_1_1_weight_write_fin_clear              )
	
);



im2col_converter #(
	.weight_width	(IM2COL_WEIGHT_WIDTH),
	.im2col_out_rows(IM2COL_OUT_ROWS	)
	)
im2col_converter
(
	.clock						(clock							),
	.reset                      (reset                   		),
	.enable                     (im2col_enable                  ),
	.ifmap_len                  (im2col_ifmap_len               ),
	.ofmap_size	                (im2col_ofmap_size	       		),
	.next_weight_row_jump		(im2col_next_weight_row_jump	),
	.next_ifmap_row_jump		(im2col_next_ifmap_row_jump		),
	.next_vector_jump	    	(im2col_next_vector_jump		),
	.read_psum_addr             (im2col_read_psum_addr          ),
	.convert_one_stream_done	(im2col_convert_one_stream_done	)
	
);




CSC_Encoder #(
	.ADDR_WIDTH	(CSC_IACT_ADDR_WIDTH	),
	.COUNT_WIDTH(CSC_IACT_COUNT_WIDTH	),
	.DATA_WIDTH	(CSC_IACT_DATA_WIDTH	)
	)
CSC_Encoder_iact
(
	.clock				(clock						),
	.reset              (reset              		),
	.data_in_ready      (csc_iact_data_in_ready     ),
	.data_in_valid      (csc_iact_data_in_valid     ),
	.data_in            (csc_iact_data_in           ),
	.address_out_ready  (csc_iact_address_out_ready ),
	.address_out_valid  (csc_iact_address_out_valid ),
	.address_out        (csc_iact_address_out       ),
	.data_out_ready     (csc_iact_data_out_ready    ),
	.data_out_valid     (csc_iact_data_out_valid    ),
	.data_out           (csc_iact_data_out          ),
	.matrix_height      (csc_iact_matrix_height     ),
	.matrix_width      	(csc_iact_matrix_weight     ),
	.clear_iact_SRAM	(csc_iact_clear_iact_SRAM	),
	.one_vector_done	(csc_iact_one_vector_done	)
);


CSC_Encoder #(
	.ADDR_WIDTH	(CSC_WEIGHT_ADDR_WIDTH	),
	.COUNT_WIDTH(CSC_WEIGHT_COUNT_WIDTH	),
	.DATA_WIDTH	(CSC_WEIGHT_DATA_WIDTH	)
	)
CSC_Encoder_weight
(
	.clock				(clock							),
	.reset              (reset              			),
	.data_in_ready      (csc_weight_data_in_ready    	),
	.data_in_valid      (csc_weight_data_in_valid    	),
	.data_in            (csc_weight_data_in          	),
	.address_out_ready  (csc_weight_address_out_ready	),
	.address_out_valid  (csc_weight_address_out_valid	),
	.address_out        (csc_weight_address_out      	),
	.data_out_ready     (csc_weight_data_out_ready   	),
	.data_out_valid     (csc_weight_data_out_valid   	),
	.data_out           (csc_weight_data_out         	),
	.matrix_height      (csc_weight_matrix_height    	),
	.matrix_width      	(csc_weight_matrix_weight    	),
	.clear_iact_SRAM	(csc_weight_clear_iact_SRAM		),
	.one_vector_done	(csc_weight_one_vector_done		)
);



psum_rearrange	psum_rearrange (
	.clock			(clock					),
	.reset          (reset          		),
	.write_en       (rearrange_write_en     ),
	.write_addr		(rearrange_write_addr	),
	.data_in        (rearrange_data_in      ),
	.data_in_valid  (rearrange_data_in_valid),
	.read_addr      (rearrange_read_addr    ),
	.data_out       (rearrange_data_out   	)
);



Psum_Requantizer	Psum_Requantizer(
	.data_in		(quant_data_in			),
	.data_in_valid  (quant_data_in_valid  	),
	.data_out       (quant_data_out       	),
	.data_out_valid (quant_data_out_valid 	)
);



ReLU	ReLU(
	.data_in		(ReLU_data_in		),
	.data_in_valid  (ReLU_data_in_valid ),
	.data_out       (ReLU_data_out      ),
	.data_out_valid (ReLU_data_out_valid)
);


Max_pooling	#(
	.stride(POOL_STRIDE)
	)
Max_pooling
(	
	.clock			(clock				),
	.reset          (reset          	),
	.enable         (pool_enable        ),
	.data_in        (pool_data_in       ),
	.data_in_valid  (pool_data_in_valid ),
	.data_out       (pool_data_out      ),
	.data_out_valid (pool_data_out_valid)
);


psum_SRAM_out_acc #(
	.BATCHES	('d4),
	.CHANNELS	('d3)
	)
psum_SRAM_out_acc
(
	.clock			(clock								),
	.reset          (reset          					),
	.en             (psum_SRAM_out_acc_en             	),
	.data_in        (psum_SRAM_out_acc_data_in        	),
	.data_in_valid  (psum_SRAM_out_acc_data_in_valid  	),
	.data_out       (psum_SRAM_out_acc_data_out       	),
	.data_out_valid (psum_SRAM_out_acc_data_out_valid 	)
);


softmax	softmax(
	.clock			(clock					),
	.reset          (reset          		),
	.en             (softmax_en             ),
	.data_in        (softmax_data_in        ),
	.data_in_valid  (softmax_data_in_valid  ),
	.data_out       (softmax_data_out       ),
	.data_out_valid (softmax_data_out_valid )
);


wire weight_addr_end	= weight_addr_in_valid 	& weight_addr_in 	== 'd0;
wire weight_data_end	= weight_data_in_valid 	& weight_data_in 	== 'd0;
wire csc_addr_end 		= csc_weight_address_out_valid 	& csc_weight_address_out 	== 'd0;
// wire csc_data_end 		= csc_weight_data_out_valid 	& csc_weight_data_out 		== 'd0;

TOP_controller # (
	.WEIGHT_DATA_3_END(WEIGHT_DATA_3_END),
	.WEIGHT_DATA_4_END(WEIGHT_DATA_4_END),
	.WEIGHT_DATA_5_END(WEIGHT_DATA_5_END)
)
TOP_controller (
	.clock										(clock											),
	.reset                                      (reset                                     		),
	.system_enable								(system_enable									),
	//.state										(state),
	.MEM_read_en								(MEM_read_en									),
	.MEM_read_addr								(MEM_read_addr									),
	.weight_addr_end							(weight_addr_end								),
	.weight_data_end							(weight_data_end								),
	.csc_addr_end								(csc_addr_end									),
	// .csc_data_end								(csc_data_end									),
	.softmax_en									(ctrl_softmax_en								),
	.csc_en										(ctrl_csc_en									),
	.conv_flag									(ctrl_conv_flag									),
	.fc_flag									(ctrl_fc_flag									),
	.layer_count								(ctrl_layer_count								),
	.ifmap_in_en								(ctrl_ifmap_in_en								),
	.ReLU_en									(ctrl_ReLU_en									),
	.psum_acc_fin								(ctrl_psum_acc_fin								),
	.psum_SRAM_out_acc_en						(ctrl_psum_SRAM_out_acc_en						),
	.CG_0_0_GLB_psum_0_out_en					(ctrl_CG_0_0_GLB_psum_0_out_en					),
	.CG_0_0_GLB_psum_1_out_en                   (ctrl_CG_0_0_GLB_psum_1_out_en 					),
	.CG_0_0_GLB_psum_2_out_en                   (ctrl_CG_0_0_GLB_psum_2_out_en 					),
	.CG_0_1_GLB_psum_0_out_en                   (ctrl_CG_0_1_GLB_psum_0_out_en 					),
	.CG_0_1_GLB_psum_1_out_en                   (ctrl_CG_0_1_GLB_psum_1_out_en 					),
	.CG_0_1_GLB_psum_2_out_en                   (ctrl_CG_0_1_GLB_psum_2_out_en 					),
	.CG_1_0_GLB_psum_0_out_en                   (ctrl_CG_1_0_GLB_psum_0_out_en 					),
	.CG_1_0_GLB_psum_1_out_en                   (ctrl_CG_1_0_GLB_psum_1_out_en 					),
	.CG_1_0_GLB_psum_2_out_en                   (ctrl_CG_1_0_GLB_psum_2_out_en 					),
	.CG_1_1_GLB_psum_0_out_en                   (ctrl_CG_1_1_GLB_psum_0_out_en 					),
	.CG_1_1_GLB_psum_1_out_en                   (ctrl_CG_1_1_GLB_psum_1_out_en 					),
	.CG_1_1_GLB_psum_2_out_en                   (ctrl_CG_1_1_GLB_psum_2_out_en 					),
	.CG_0_0_GLB_iact_0_0_in_en                  (ctrl_CG_0_0_GLB_iact_0_0_in_en					),
	.CG_0_0_GLB_iact_0_1_in_en                  (ctrl_CG_0_0_GLB_iact_0_1_in_en					),
	.CG_0_0_GLB_iact_0_2_in_en                  (ctrl_CG_0_0_GLB_iact_0_2_in_en					),
	.CG_0_0_GLB_iact_1_0_in_en                  (ctrl_CG_0_0_GLB_iact_1_0_in_en					),
	.CG_0_0_GLB_iact_1_1_in_en                  (ctrl_CG_0_0_GLB_iact_1_1_in_en					),
	.CG_0_0_GLB_iact_1_2_in_en                  (ctrl_CG_0_0_GLB_iact_1_2_in_en					),
	.CG_0_0_GLB_iact_2_0_in_en                  (ctrl_CG_0_0_GLB_iact_2_0_in_en					),
	.CG_0_0_GLB_iact_2_1_in_en                  (ctrl_CG_0_0_GLB_iact_2_1_in_en					),
	.CG_0_0_GLB_iact_2_2_in_en                  (ctrl_CG_0_0_GLB_iact_2_2_in_en					),
	.CG_0_1_GLB_iact_0_0_in_en                  (ctrl_CG_0_1_GLB_iact_0_0_in_en					),
	.CG_0_1_GLB_iact_0_1_in_en                  (ctrl_CG_0_1_GLB_iact_0_1_in_en					),
	.CG_0_1_GLB_iact_0_2_in_en                  (ctrl_CG_0_1_GLB_iact_0_2_in_en					),
	.CG_0_1_GLB_iact_1_0_in_en                  (ctrl_CG_0_1_GLB_iact_1_0_in_en					),
	.CG_0_1_GLB_iact_1_1_in_en                  (ctrl_CG_0_1_GLB_iact_1_1_in_en					),
	.CG_0_1_GLB_iact_1_2_in_en                  (ctrl_CG_0_1_GLB_iact_1_2_in_en					),
	.CG_0_1_GLB_iact_2_0_in_en                  (ctrl_CG_0_1_GLB_iact_2_0_in_en					),
	.CG_0_1_GLB_iact_2_1_in_en                  (ctrl_CG_0_1_GLB_iact_2_1_in_en					),
	.CG_0_1_GLB_iact_2_2_in_en                  (ctrl_CG_0_1_GLB_iact_2_2_in_en					),
	.CG_1_0_GLB_iact_0_0_in_en                  (ctrl_CG_1_0_GLB_iact_0_0_in_en					),
	.CG_1_0_GLB_iact_0_1_in_en                  (ctrl_CG_1_0_GLB_iact_0_1_in_en					),
	.CG_1_0_GLB_iact_0_2_in_en                  (ctrl_CG_1_0_GLB_iact_0_2_in_en					),
	.CG_1_0_GLB_iact_1_0_in_en                  (ctrl_CG_1_0_GLB_iact_1_0_in_en					),
	.CG_1_0_GLB_iact_1_1_in_en                  (ctrl_CG_1_0_GLB_iact_1_1_in_en					),
	.CG_1_0_GLB_iact_1_2_in_en                  (ctrl_CG_1_0_GLB_iact_1_2_in_en					),
	.CG_1_0_GLB_iact_2_0_in_en                  (ctrl_CG_1_0_GLB_iact_2_0_in_en					),
	.CG_1_0_GLB_iact_2_1_in_en                  (ctrl_CG_1_0_GLB_iact_2_1_in_en					),
	.CG_1_0_GLB_iact_2_2_in_en                  (ctrl_CG_1_0_GLB_iact_2_2_in_en					),
	.CG_1_1_GLB_iact_0_0_in_en                  (ctrl_CG_1_1_GLB_iact_0_0_in_en					),
	.CG_1_1_GLB_iact_0_1_in_en                  (ctrl_CG_1_1_GLB_iact_0_1_in_en					),
	.CG_1_1_GLB_iact_0_2_in_en                  (ctrl_CG_1_1_GLB_iact_0_2_in_en					),
	.CG_1_1_GLB_iact_1_0_in_en                  (ctrl_CG_1_1_GLB_iact_1_0_in_en					),
	.CG_1_1_GLB_iact_1_1_in_en                  (ctrl_CG_1_1_GLB_iact_1_1_in_en					),
	.CG_1_1_GLB_iact_1_2_in_en                  (ctrl_CG_1_1_GLB_iact_1_2_in_en					),
	.CG_1_1_GLB_iact_2_0_in_en                  (ctrl_CG_1_1_GLB_iact_2_0_in_en					),
	.CG_1_1_GLB_iact_2_1_in_en                  (ctrl_CG_1_1_GLB_iact_2_1_in_en					),
	.CG_1_1_GLB_iact_2_2_in_en                  (ctrl_CG_1_1_GLB_iact_2_2_in_en					),
	.CG_0_0_GLB_weight_0_in_en                  (ctrl_CG_0_0_GLB_weight_0_in_en					),
	.CG_0_0_GLB_weight_1_in_en                  (ctrl_CG_0_0_GLB_weight_1_in_en					),
	.CG_0_0_GLB_weight_2_in_en                  (ctrl_CG_0_0_GLB_weight_2_in_en					),
	.CG_0_1_GLB_weight_0_in_en                  (ctrl_CG_0_1_GLB_weight_0_in_en					),
	.CG_0_1_GLB_weight_1_in_en                  (ctrl_CG_0_1_GLB_weight_1_in_en					),
	.CG_0_1_GLB_weight_2_in_en                  (ctrl_CG_0_1_GLB_weight_2_in_en					),
	.CG_1_0_GLB_weight_0_in_en                  (ctrl_CG_1_0_GLB_weight_0_in_en					),
	.CG_1_0_GLB_weight_1_in_en                  (ctrl_CG_1_0_GLB_weight_1_in_en					),
	.CG_1_0_GLB_weight_2_in_en                  (ctrl_CG_1_0_GLB_weight_2_in_en					),
	.CG_1_1_GLB_weight_0_in_en                  (ctrl_CG_1_1_GLB_weight_0_in_en					),
	.CG_1_1_GLB_weight_1_in_en                  (ctrl_CG_1_1_GLB_weight_1_in_en					),
	.CG_1_1_GLB_weight_2_in_en                  (ctrl_CG_1_1_GLB_weight_2_in_en					),
	
	.CG_0_0_PE_cluster_iact_data_in_sel         (ctrl_CG_0_0_PE_cluster_iact_data_in_sel        ),
	.CG_0_0_PE_cluster_iact_data_out_sel        (ctrl_CG_0_0_PE_cluster_iact_data_out_sel       ),
	.CG_0_0_PE_cluster_psum_data_in_sel         (ctrl_CG_0_0_PE_cluster_psum_data_in_sel        ),
	.CG_0_0_router_cluster_iact_data_in_sel     (ctrl_CG_0_0_router_cluster_iact_data_in_sel    ),
	.CG_0_0_router_cluster_iact_data_out_sel    (ctrl_CG_0_0_router_cluster_iact_data_out_sel   ),
	.CG_0_0_router_cluster_weight_data_in_sel   (ctrl_CG_0_0_router_cluster_weight_data_in_sel  ),
	.CG_0_0_router_cluster_weight_data_out_sel  (ctrl_CG_0_0_router_cluster_weight_data_out_sel ),
	.CG_0_0_router_cluster_psum_data_in_sel     (ctrl_CG_0_0_router_cluster_psum_data_in_sel    ),
	.CG_0_0_router_cluster_psum_data_out_sel    (ctrl_CG_0_0_router_cluster_psum_data_out_sel   ),
	.CG_0_0_src_GLB_load_fin                    (ctrl_CG_0_0_src_GLB_load_fin                   ),
	.CG_0_0_GLB_iact_load_en                    (ctrl_CG_0_0_GLB_iact_load_en                   ),
	.CG_0_0_PE_weight_load_en                   (ctrl_CG_0_0_PE_weight_load_en                  ),
	.CG_0_0_cal_fin                             (ctrl_CG_0_0_cal_fin                            ),
	.CG_0_0_cg_en                               (ctrl_CG_0_0_cg_en                              ),
	.CG_0_0_read_psum_en                        (ctrl_CG_0_0_read_psum_en                       ),
	.CG_0_0_psum_SRAM_Bank_0_read_out_en        (ctrl_CG_0_0_psum_SRAM_Bank_0_read_out_en       ),
	.CG_0_0_psum_SRAM_Bank_1_read_out_en        (ctrl_CG_0_0_psum_SRAM_Bank_1_read_out_en       ),
	.CG_0_0_psum_SRAM_Bank_2_read_out_en        (ctrl_CG_0_0_psum_SRAM_Bank_2_read_out_en       ),
	.CG_0_0_PE_0_0_disable						(ctrl_CG_0_0_PE_0_0_disable						),
	.CG_0_0_PE_0_1_disable                      (ctrl_CG_0_0_PE_0_1_disable						),
	.CG_0_0_PE_0_2_disable                      (ctrl_CG_0_0_PE_0_2_disable						),
	.CG_0_0_PE_1_0_disable                      (ctrl_CG_0_0_PE_1_0_disable						),
	.CG_0_0_PE_1_1_disable                      (ctrl_CG_0_0_PE_1_1_disable						),
	.CG_0_0_PE_1_2_disable                      (ctrl_CG_0_0_PE_1_2_disable						),
	.CG_0_0_PE_2_0_disable                      (ctrl_CG_0_0_PE_2_0_disable						),
	.CG_0_0_PE_2_1_disable                      (ctrl_CG_0_0_PE_2_1_disable						),
	.CG_0_0_PE_2_2_disable                      (ctrl_CG_0_0_PE_2_2_disable						),
	.CG_0_0_GLB_iact_0_0_read_addr              (ctrl_CG_0_0_GLB_iact_0_0_read_addr             ),
	.CG_0_0_GLB_iact_0_1_read_addr              (ctrl_CG_0_0_GLB_iact_0_1_read_addr             ),
	.CG_0_0_GLB_iact_0_2_read_addr              (ctrl_CG_0_0_GLB_iact_0_2_read_addr             ),
	.CG_0_0_GLB_iact_1_0_read_addr              (ctrl_CG_0_0_GLB_iact_1_0_read_addr             ),
	.CG_0_0_GLB_iact_1_1_read_addr              (ctrl_CG_0_0_GLB_iact_1_1_read_addr             ),
	.CG_0_0_GLB_iact_1_2_read_addr              (ctrl_CG_0_0_GLB_iact_1_2_read_addr             ),
	.CG_0_0_GLB_iact_2_0_read_addr              (ctrl_CG_0_0_GLB_iact_2_0_read_addr             ),
	.CG_0_0_GLB_iact_2_1_read_addr              (ctrl_CG_0_0_GLB_iact_2_1_read_addr             ),
	.CG_0_0_GLB_iact_2_2_read_addr              (ctrl_CG_0_0_GLB_iact_2_2_read_addr             ),
	.CG_0_0_GLB_psum_write_en                   (ctrl_CG_0_0_GLB_psum_write_en                  ),
	.CG_0_0_GLB_psum_0_write_addr               (ctrl_CG_0_0_GLB_psum_0_write_addr              ),
	.CG_0_0_GLB_psum_1_write_addr               (ctrl_CG_0_0_GLB_psum_1_write_addr              ),
	.CG_0_0_GLB_psum_2_write_addr               (ctrl_CG_0_0_GLB_psum_2_write_addr              ),
	.CG_0_0_GLB_psum_0_read_addr                (ctrl_CG_0_0_GLB_psum_0_read_addr               ),
	.CG_0_0_GLB_psum_1_read_addr                (ctrl_CG_0_0_GLB_psum_1_read_addr               ),
	.CG_0_0_GLB_psum_2_read_addr                (ctrl_CG_0_0_GLB_psum_2_read_addr               ),
	.CG_0_0_PSUM_DEPTH                          (ctrl_CG_0_0_PSUM_DEPTH                         ),
	.CG_0_0_psum_spad_clear                     (ctrl_CG_0_0_psum_spad_clear                    ),
	.CG_0_0_iact_write_fin_clear                (ctrl_CG_0_0_iact_write_fin_clear               ),
	.CG_0_0_weight_write_fin_clear              (ctrl_CG_0_0_weight_write_fin_clear             ),
	.CG_0_1_PE_cluster_iact_data_in_sel         (ctrl_CG_0_1_PE_cluster_iact_data_in_sel        ),
	.CG_0_1_PE_cluster_iact_data_out_sel        (ctrl_CG_0_1_PE_cluster_iact_data_out_sel       ),
	.CG_0_1_PE_cluster_psum_data_in_sel         (ctrl_CG_0_1_PE_cluster_psum_data_in_sel        ),
	.CG_0_1_router_cluster_iact_data_in_sel     (ctrl_CG_0_1_router_cluster_iact_data_in_sel    ),
	.CG_0_1_router_cluster_iact_data_out_sel    (ctrl_CG_0_1_router_cluster_iact_data_out_sel   ),
	.CG_0_1_router_cluster_weight_data_in_sel   (ctrl_CG_0_1_router_cluster_weight_data_in_sel  ),
	.CG_0_1_router_cluster_weight_data_out_sel  (ctrl_CG_0_1_router_cluster_weight_data_out_sel ),
	.CG_0_1_router_cluster_psum_data_in_sel     (ctrl_CG_0_1_router_cluster_psum_data_in_sel    ),
	.CG_0_1_router_cluster_psum_data_out_sel    (ctrl_CG_0_1_router_cluster_psum_data_out_sel   ),
	.CG_0_1_src_GLB_load_fin                    (ctrl_CG_0_1_src_GLB_load_fin                   ),
	.CG_0_1_GLB_iact_load_en                    (ctrl_CG_0_1_GLB_iact_load_en                   ),
	.CG_0_1_PE_weight_load_en                   (ctrl_CG_0_1_PE_weight_load_en                  ),
	.CG_0_1_cal_fin                             (ctrl_CG_0_1_cal_fin                            ),
	.CG_0_1_cg_en                               (ctrl_CG_0_1_cg_en                              ),
	.CG_0_1_read_psum_en                        (ctrl_CG_0_1_read_psum_en                       ),
	.CG_0_1_psum_SRAM_Bank_0_read_out_en        (ctrl_CG_0_1_psum_SRAM_Bank_0_read_out_en       ),
	.CG_0_1_psum_SRAM_Bank_1_read_out_en        (ctrl_CG_0_1_psum_SRAM_Bank_1_read_out_en       ),
	.CG_0_1_psum_SRAM_Bank_2_read_out_en        (ctrl_CG_0_1_psum_SRAM_Bank_2_read_out_en       ),
	.CG_0_1_PE_0_0_disable						(ctrl_CG_0_1_PE_0_0_disable						),
	.CG_0_1_PE_0_1_disable                      (ctrl_CG_0_1_PE_0_1_disable						),
	.CG_0_1_PE_0_2_disable                      (ctrl_CG_0_1_PE_0_2_disable						),
	.CG_0_1_PE_1_0_disable                      (ctrl_CG_0_1_PE_1_0_disable						),
	.CG_0_1_PE_1_1_disable                      (ctrl_CG_0_1_PE_1_1_disable						),
	.CG_0_1_PE_1_2_disable                      (ctrl_CG_0_1_PE_1_2_disable						),
	.CG_0_1_PE_2_0_disable                      (ctrl_CG_0_1_PE_2_0_disable						),
	.CG_0_1_PE_2_1_disable                      (ctrl_CG_0_1_PE_2_1_disable						),
	.CG_0_1_PE_2_2_disable                      (ctrl_CG_0_1_PE_2_2_disable						),
	.CG_0_1_GLB_iact_0_0_read_addr              (ctrl_CG_0_1_GLB_iact_0_0_read_addr             ),
	.CG_0_1_GLB_iact_0_1_read_addr              (ctrl_CG_0_1_GLB_iact_0_1_read_addr             ),
	.CG_0_1_GLB_iact_0_2_read_addr              (ctrl_CG_0_1_GLB_iact_0_2_read_addr             ),
	.CG_0_1_GLB_iact_1_0_read_addr              (ctrl_CG_0_1_GLB_iact_1_0_read_addr             ),
	.CG_0_1_GLB_iact_1_1_read_addr              (ctrl_CG_0_1_GLB_iact_1_1_read_addr             ),
	.CG_0_1_GLB_iact_1_2_read_addr              (ctrl_CG_0_1_GLB_iact_1_2_read_addr             ),
	.CG_0_1_GLB_iact_2_0_read_addr              (ctrl_CG_0_1_GLB_iact_2_0_read_addr             ),
	.CG_0_1_GLB_iact_2_1_read_addr              (ctrl_CG_0_1_GLB_iact_2_1_read_addr             ),
	.CG_0_1_GLB_iact_2_2_read_addr              (ctrl_CG_0_1_GLB_iact_2_2_read_addr             ),
	.CG_0_1_GLB_psum_write_en                   (ctrl_CG_0_1_GLB_psum_write_en                  ),
	.CG_0_1_GLB_psum_0_write_addr               (ctrl_CG_0_1_GLB_psum_0_write_addr              ),
	.CG_0_1_GLB_psum_1_write_addr               (ctrl_CG_0_1_GLB_psum_1_write_addr              ),
	.CG_0_1_GLB_psum_2_write_addr               (ctrl_CG_0_1_GLB_psum_2_write_addr              ),
	.CG_0_1_GLB_psum_0_read_addr                (ctrl_CG_0_1_GLB_psum_0_read_addr               ),
	.CG_0_1_GLB_psum_1_read_addr                (ctrl_CG_0_1_GLB_psum_1_read_addr               ),
	.CG_0_1_GLB_psum_2_read_addr                (ctrl_CG_0_1_GLB_psum_2_read_addr               ),
	.CG_0_1_PSUM_DEPTH                          (ctrl_CG_0_1_PSUM_DEPTH                         ),
	.CG_0_1_psum_spad_clear                     (ctrl_CG_0_1_psum_spad_clear                    ),
	.CG_0_1_iact_write_fin_clear                (ctrl_CG_0_1_iact_write_fin_clear               ),
	.CG_0_1_weight_write_fin_clear              (ctrl_CG_0_1_weight_write_fin_clear             ),
	.CG_1_0_PE_cluster_iact_data_in_sel         (ctrl_CG_1_0_PE_cluster_iact_data_in_sel        ),
	.CG_1_0_PE_cluster_iact_data_out_sel        (ctrl_CG_1_0_PE_cluster_iact_data_out_sel       ),
	.CG_1_0_PE_cluster_psum_data_in_sel         (ctrl_CG_1_0_PE_cluster_psum_data_in_sel        ),
	.CG_1_0_router_cluster_iact_data_in_sel     (ctrl_CG_1_0_router_cluster_iact_data_in_sel    ),
	.CG_1_0_router_cluster_iact_data_out_sel    (ctrl_CG_1_0_router_cluster_iact_data_out_sel   ),
	.CG_1_0_router_cluster_weight_data_in_sel   (ctrl_CG_1_0_router_cluster_weight_data_in_sel  ),
	.CG_1_0_router_cluster_weight_data_out_sel  (ctrl_CG_1_0_router_cluster_weight_data_out_sel ),
	.CG_1_0_router_cluster_psum_data_in_sel     (ctrl_CG_1_0_router_cluster_psum_data_in_sel    ),
	.CG_1_0_router_cluster_psum_data_out_sel    (ctrl_CG_1_0_router_cluster_psum_data_out_sel   ),
	.CG_1_0_src_GLB_load_fin                    (ctrl_CG_1_0_src_GLB_load_fin                   ),
	.CG_1_0_GLB_iact_load_en                    (ctrl_CG_1_0_GLB_iact_load_en                   ),
	.CG_1_0_PE_weight_load_en                   (ctrl_CG_1_0_PE_weight_load_en                  ),
	.CG_1_0_cal_fin                             (ctrl_CG_1_0_cal_fin                            ),
	.CG_1_0_cg_en                               (ctrl_CG_1_0_cg_en                              ),
	.CG_1_0_read_psum_en                        (ctrl_CG_1_0_read_psum_en                       ),
	.CG_1_0_psum_SRAM_Bank_0_read_out_en        (ctrl_CG_1_0_psum_SRAM_Bank_0_read_out_en       ),
	.CG_1_0_psum_SRAM_Bank_1_read_out_en        (ctrl_CG_1_0_psum_SRAM_Bank_1_read_out_en       ),
	.CG_1_0_psum_SRAM_Bank_2_read_out_en        (ctrl_CG_1_0_psum_SRAM_Bank_2_read_out_en       ),
	.CG_1_0_PE_0_0_disable						(ctrl_CG_1_0_PE_0_0_disable						),
	.CG_1_0_PE_0_1_disable                      (ctrl_CG_1_0_PE_0_1_disable						),
	.CG_1_0_PE_0_2_disable                      (ctrl_CG_1_0_PE_0_2_disable						),
	.CG_1_0_PE_1_0_disable                      (ctrl_CG_1_0_PE_1_0_disable						),
	.CG_1_0_PE_1_1_disable                      (ctrl_CG_1_0_PE_1_1_disable						),
	.CG_1_0_PE_1_2_disable                      (ctrl_CG_1_0_PE_1_2_disable						),
	.CG_1_0_PE_2_0_disable                      (ctrl_CG_1_0_PE_2_0_disable						),
	.CG_1_0_PE_2_1_disable                      (ctrl_CG_1_0_PE_2_1_disable						),
	.CG_1_0_PE_2_2_disable                      (ctrl_CG_1_0_PE_2_2_disable						),
	.CG_1_0_GLB_iact_0_0_read_addr              (ctrl_CG_1_0_GLB_iact_0_0_read_addr             ),
	.CG_1_0_GLB_iact_0_1_read_addr              (ctrl_CG_1_0_GLB_iact_0_1_read_addr             ),
	.CG_1_0_GLB_iact_0_2_read_addr              (ctrl_CG_1_0_GLB_iact_0_2_read_addr             ),
	.CG_1_0_GLB_iact_1_0_read_addr              (ctrl_CG_1_0_GLB_iact_1_0_read_addr             ),
	.CG_1_0_GLB_iact_1_1_read_addr              (ctrl_CG_1_0_GLB_iact_1_1_read_addr             ),
	.CG_1_0_GLB_iact_1_2_read_addr              (ctrl_CG_1_0_GLB_iact_1_2_read_addr             ),
	.CG_1_0_GLB_iact_2_0_read_addr              (ctrl_CG_1_0_GLB_iact_2_0_read_addr             ),
	.CG_1_0_GLB_iact_2_1_read_addr              (ctrl_CG_1_0_GLB_iact_2_1_read_addr             ),
	.CG_1_0_GLB_iact_2_2_read_addr              (ctrl_CG_1_0_GLB_iact_2_2_read_addr             ),
	.CG_1_0_GLB_psum_write_en                   (ctrl_CG_1_0_GLB_psum_write_en                  ),
	.CG_1_0_GLB_psum_0_write_addr               (ctrl_CG_1_0_GLB_psum_0_write_addr              ),
	.CG_1_0_GLB_psum_1_write_addr               (ctrl_CG_1_0_GLB_psum_1_write_addr              ),
	.CG_1_0_GLB_psum_2_write_addr               (ctrl_CG_1_0_GLB_psum_2_write_addr              ),
	.CG_1_0_GLB_psum_0_read_addr                (ctrl_CG_1_0_GLB_psum_0_read_addr               ),
	.CG_1_0_GLB_psum_1_read_addr                (ctrl_CG_1_0_GLB_psum_1_read_addr               ),
	.CG_1_0_GLB_psum_2_read_addr                (ctrl_CG_1_0_GLB_psum_2_read_addr               ),
	.CG_1_0_PSUM_DEPTH                          (ctrl_CG_1_0_PSUM_DEPTH                         ),
	.CG_1_0_psum_spad_clear                     (ctrl_CG_1_0_psum_spad_clear                    ),
	.CG_1_0_iact_write_fin_clear                (ctrl_CG_1_0_iact_write_fin_clear               ),
	.CG_1_0_weight_write_fin_clear              (ctrl_CG_1_0_weight_write_fin_clear             ),
	.CG_1_1_PE_cluster_iact_data_in_sel         (ctrl_CG_1_1_PE_cluster_iact_data_in_sel        ),
	.CG_1_1_PE_cluster_iact_data_out_sel        (ctrl_CG_1_1_PE_cluster_iact_data_out_sel       ),
	.CG_1_1_PE_cluster_psum_data_in_sel         (ctrl_CG_1_1_PE_cluster_psum_data_in_sel        ),
	.CG_1_1_router_cluster_iact_data_in_sel     (ctrl_CG_1_1_router_cluster_iact_data_in_sel    ),
	.CG_1_1_router_cluster_iact_data_out_sel    (ctrl_CG_1_1_router_cluster_iact_data_out_sel   ),
	.CG_1_1_router_cluster_weight_data_in_sel   (ctrl_CG_1_1_router_cluster_weight_data_in_sel  ),
	.CG_1_1_router_cluster_weight_data_out_sel  (ctrl_CG_1_1_router_cluster_weight_data_out_sel ),
	.CG_1_1_router_cluster_psum_data_in_sel     (ctrl_CG_1_1_router_cluster_psum_data_in_sel    ),
	.CG_1_1_router_cluster_psum_data_out_sel    (ctrl_CG_1_1_router_cluster_psum_data_out_sel   ),
	.CG_1_1_src_GLB_load_fin                    (ctrl_CG_1_1_src_GLB_load_fin                   ),
	.CG_1_1_GLB_iact_load_en                    (ctrl_CG_1_1_GLB_iact_load_en                   ),
	.CG_1_1_PE_weight_load_en                   (ctrl_CG_1_1_PE_weight_load_en                  ),
	.CG_1_1_cal_fin                             (ctrl_CG_1_1_cal_fin                            ),
	.CG_1_1_cg_en                               (ctrl_CG_1_1_cg_en                              ),
	.CG_1_1_read_psum_en                        (ctrl_CG_1_1_read_psum_en                       ),
	.CG_1_1_psum_SRAM_Bank_0_read_out_en        (ctrl_CG_1_1_psum_SRAM_Bank_0_read_out_en       ),
	.CG_1_1_psum_SRAM_Bank_1_read_out_en        (ctrl_CG_1_1_psum_SRAM_Bank_1_read_out_en       ),
	.CG_1_1_psum_SRAM_Bank_2_read_out_en        (ctrl_CG_1_1_psum_SRAM_Bank_2_read_out_en       ),
	.CG_1_1_PE_0_0_disable						(ctrl_CG_1_1_PE_0_0_disable						),
	.CG_1_1_PE_0_1_disable                      (ctrl_CG_1_1_PE_0_1_disable						),
	.CG_1_1_PE_0_2_disable                      (ctrl_CG_1_1_PE_0_2_disable						),
	.CG_1_1_PE_1_0_disable                      (ctrl_CG_1_1_PE_1_0_disable						),
	.CG_1_1_PE_1_1_disable                      (ctrl_CG_1_1_PE_1_1_disable						),
	.CG_1_1_PE_1_2_disable                      (ctrl_CG_1_1_PE_1_2_disable						),
	.CG_1_1_PE_2_0_disable                      (ctrl_CG_1_1_PE_2_0_disable						),
	.CG_1_1_PE_2_1_disable                      (ctrl_CG_1_1_PE_2_1_disable						),
	.CG_1_1_PE_2_2_disable                      (ctrl_CG_1_1_PE_2_2_disable						),
	.CG_1_1_GLB_iact_0_0_read_addr              (ctrl_CG_1_1_GLB_iact_0_0_read_addr             ),
	.CG_1_1_GLB_iact_0_1_read_addr              (ctrl_CG_1_1_GLB_iact_0_1_read_addr             ),
	.CG_1_1_GLB_iact_0_2_read_addr              (ctrl_CG_1_1_GLB_iact_0_2_read_addr             ),
	.CG_1_1_GLB_iact_1_0_read_addr              (ctrl_CG_1_1_GLB_iact_1_0_read_addr             ),
	.CG_1_1_GLB_iact_1_1_read_addr              (ctrl_CG_1_1_GLB_iact_1_1_read_addr             ),
	.CG_1_1_GLB_iact_1_2_read_addr              (ctrl_CG_1_1_GLB_iact_1_2_read_addr             ),
	.CG_1_1_GLB_iact_2_0_read_addr              (ctrl_CG_1_1_GLB_iact_2_0_read_addr             ),
	.CG_1_1_GLB_iact_2_1_read_addr              (ctrl_CG_1_1_GLB_iact_2_1_read_addr             ),
	.CG_1_1_GLB_iact_2_2_read_addr              (ctrl_CG_1_1_GLB_iact_2_2_read_addr             ),
	.CG_1_1_GLB_psum_write_en                   (ctrl_CG_1_1_GLB_psum_write_en                  ),
	.CG_1_1_GLB_psum_0_write_addr               (ctrl_CG_1_1_GLB_psum_0_write_addr              ),
	.CG_1_1_GLB_psum_1_write_addr               (ctrl_CG_1_1_GLB_psum_1_write_addr              ),
	.CG_1_1_GLB_psum_2_write_addr               (ctrl_CG_1_1_GLB_psum_2_write_addr              ),
	.CG_1_1_GLB_psum_0_read_addr                (ctrl_CG_1_1_GLB_psum_0_read_addr               ),
	.CG_1_1_GLB_psum_1_read_addr                (ctrl_CG_1_1_GLB_psum_1_read_addr               ),
	.CG_1_1_GLB_psum_2_read_addr                (ctrl_CG_1_1_GLB_psum_2_read_addr               ),
	.CG_1_1_PSUM_DEPTH                          (ctrl_CG_1_1_PSUM_DEPTH                         ),
	.CG_1_1_psum_spad_clear                     (ctrl_CG_1_1_psum_spad_clear                    ),
	.CG_1_1_iact_write_fin_clear                (ctrl_CG_1_1_iact_write_fin_clear               ),
	.CG_1_1_weight_write_fin_clear              (ctrl_CG_1_1_weight_write_fin_clear             ),
	.CSC_encoder_iact_matrix_height				(ctrl_CSC_encoder_iact_matrix_height            ),
	.CSC_encoder_iact_matrix_width				(ctrl_CSC_encoder_iact_matrix_width     		),
	.CSC_encoder_iact_clear_iact_SRAM			(ctrl_CSC_encoder_iact_clear_iact_SRAM			),
	.CSC_encoder_iact_one_vector_done			(ctrl_CSC_encoder_iact_one_vector_done			),
	.CSC_encoder_weight_matrix_height			(ctrl_CSC_encoder_weight_matrix_height          ),
	.CSC_encoder_weight_matrix_width			(ctrl_CSC_encoder_weight_matrix_width     		),
	.CSC_encoder_weight_clear_iact_SRAM			(ctrl_CSC_encoder_weight_clear_iact_SRAM		),
	.CSC_encoder_weight_one_vector_done			(ctrl_CSC_encoder_weight_one_vector_done		),
	.im2col_enable                              (ctrl_im2col_enable                             ),
	.im2col_ifmap_len					        (ctrl_im2col_ifmap_len					        ),
	.im2col_ofmap_size					        (ctrl_im2col_ofmap_size					        ),
	.im2col_next_weight_row_jump				(ctrl_im2col_next_weight_row_jump				),
	.im2col_next_ifmap_row_jump					(ctrl_im2col_next_ifmap_row_jump				),
	.im2col_next_vector_jump		        	(ctrl_im2col_next_vector_jump		       	 	),
	.im2col_read_psum_addr						(ctrl_im2col_read_psum_addr						),
	.im2col_convert_one_stream_done             (ctrl_im2col_convert_one_stream_done			),
	.psum_rearrange_write_en                    (ctrl_psum_rearrange_write_en                   ),
	.psum_rearrange_write_addr					(ctrl_psum_rearrange_write_addr					),
	.psum_rearrange_read_addr                   (ctrl_psum_rearrange_read_addr                  ),
	.pool_enable                                (ctrl_pool_enable                               )
);
	
	
assign	psum_acc_fin 									= ctrl_psum_acc_fin;
assign	CG_0_0_PE_cluster_iact_data_in_sel     		   	= ctrl_CG_0_0_PE_cluster_iact_data_in_sel; 
assign	CG_0_0_PE_cluster_iact_data_out_sel            	= ctrl_CG_0_0_PE_cluster_iact_data_out_sel;
assign	CG_0_0_PE_cluster_psum_data_in_sel             	= ctrl_CG_0_0_PE_cluster_psum_data_in_sel;
assign	CG_0_0_router_cluster_iact_data_in_sel         	= ctrl_CG_0_0_router_cluster_iact_data_in_sel;
assign	CG_0_0_router_cluster_iact_data_out_sel        	= ctrl_CG_0_0_router_cluster_iact_data_out_sel;
assign	CG_0_0_router_cluster_weight_data_in_sel       	= ctrl_CG_0_0_router_cluster_weight_data_in_sel;
assign	CG_0_0_router_cluster_weight_data_out_sel      	= ctrl_CG_0_0_router_cluster_weight_data_out_sel;
assign	CG_0_0_router_cluster_psum_data_in_sel         	= ctrl_CG_0_0_router_cluster_psum_data_in_sel;
assign	CG_0_0_router_cluster_psum_data_out_sel        	= ctrl_CG_0_0_router_cluster_psum_data_out_sel;
assign	CG_0_0_read_psum_en								= ctrl_CG_0_0_read_psum_en;
assign	CG_0_0_cg_en                                  	= ctrl_CG_0_0_cg_en;
assign	CG_0_0_src_GLB_load_fin                         = ctrl_CG_0_0_src_GLB_load_fin;
assign	CG_0_0_psum_SRAM_Bank_0_read_out_en        		= ctrl_CG_0_0_psum_SRAM_Bank_0_read_out_en;
assign	CG_0_0_psum_SRAM_Bank_1_read_out_en        		= ctrl_CG_0_0_psum_SRAM_Bank_1_read_out_en;	
assign	CG_0_0_psum_SRAM_Bank_2_read_out_en        		= ctrl_CG_0_0_psum_SRAM_Bank_2_read_out_en;
assign  CG_0_0_PE_0_0_disable							= ctrl_CG_0_0_PE_0_0_disable;						
assign  CG_0_0_PE_0_1_disable                      		= ctrl_CG_0_0_PE_0_1_disable;						
assign  CG_0_0_PE_0_2_disable                      		= ctrl_CG_0_0_PE_0_2_disable;						
assign  CG_0_0_PE_1_0_disable                      		= ctrl_CG_0_0_PE_1_0_disable;						
assign  CG_0_0_PE_1_1_disable                      		= ctrl_CG_0_0_PE_1_1_disable;						
assign  CG_0_0_PE_1_2_disable                      		= ctrl_CG_0_0_PE_1_2_disable;						
assign  CG_0_0_PE_2_0_disable                      		= ctrl_CG_0_0_PE_2_0_disable;						
assign  CG_0_0_PE_2_1_disable                      		= ctrl_CG_0_0_PE_2_1_disable;						
assign  CG_0_0_PE_2_2_disable                      		= ctrl_CG_0_0_PE_2_2_disable;						

assign	CG_0_0_GLB_iact_0_0_read_addr              		= ctrl_CG_0_0_GLB_iact_0_0_read_addr;            
assign	CG_0_0_GLB_iact_0_1_read_addr                   = ctrl_CG_0_0_GLB_iact_0_1_read_addr;            
assign	CG_0_0_GLB_iact_0_2_read_addr                   = ctrl_CG_0_0_GLB_iact_0_2_read_addr;            
assign	CG_0_0_GLB_iact_1_0_read_addr                   = ctrl_CG_0_0_GLB_iact_1_0_read_addr;            
assign	CG_0_0_GLB_iact_1_1_read_addr                   = ctrl_CG_0_0_GLB_iact_1_1_read_addr;            
assign	CG_0_0_GLB_iact_1_2_read_addr                   = ctrl_CG_0_0_GLB_iact_1_2_read_addr;            
assign	CG_0_0_GLB_iact_2_0_read_addr                   = ctrl_CG_0_0_GLB_iact_2_0_read_addr;            
assign	CG_0_0_GLB_iact_2_1_read_addr                   = ctrl_CG_0_0_GLB_iact_2_1_read_addr;            
assign	CG_0_0_GLB_iact_2_2_read_addr                   = ctrl_CG_0_0_GLB_iact_2_2_read_addr;            
assign	CG_0_0_GLB_psum_write_en                        = ctrl_CG_0_0_GLB_psum_write_en;                  
assign	CG_0_0_GLB_psum_0_write_addr                    = ctrl_CG_0_0_GLB_psum_0_write_addr;              
assign	CG_0_0_GLB_psum_1_write_addr                    = ctrl_CG_0_0_GLB_psum_1_write_addr;              
assign	CG_0_0_GLB_psum_2_write_addr                    = ctrl_CG_0_0_GLB_psum_2_write_addr;              
assign	CG_0_0_GLB_psum_0_read_addr                     = ctrl_CG_0_0_GLB_psum_0_read_addr;               
assign	CG_0_0_GLB_psum_1_read_addr                     = ctrl_CG_0_0_GLB_psum_1_read_addr;               
assign	CG_0_0_GLB_psum_2_read_addr                     = ctrl_CG_0_0_GLB_psum_2_read_addr;               
assign	CG_0_0_GLB_iact_0_0_address_in_valid            = ctrl_CG_0_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_0_address_in                  = ctrl_CG_0_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_0_0_data_in_valid               = ctrl_CG_0_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_0_data_in                     = ctrl_CG_0_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_0_1_address_in_valid            = ctrl_CG_0_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_1_address_in                  = ctrl_CG_0_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_0_1_data_in_valid               = ctrl_CG_0_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_1_data_in                     = ctrl_CG_0_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_0_2_address_in_valid            = ctrl_CG_0_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_2_address_in                  = ctrl_CG_0_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_0_2_data_in_valid               = ctrl_CG_0_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_0_2_data_in                     = ctrl_CG_0_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_1_0_address_in_valid            = ctrl_CG_0_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_0_address_in                  = ctrl_CG_0_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_1_0_data_in_valid               = ctrl_CG_0_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_0_data_in                     = ctrl_CG_0_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_1_1_address_in_valid            = ctrl_CG_0_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_1_address_in                  = ctrl_CG_0_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;  
assign	CG_0_0_GLB_iact_1_1_data_in_valid               = ctrl_CG_0_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_1_data_in                     = ctrl_CG_0_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_1_2_address_in_valid            = ctrl_CG_0_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_2_address_in                  = ctrl_CG_0_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_1_2_data_in_valid               = ctrl_CG_0_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_1_2_data_in                     = ctrl_CG_0_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_0_address_in_valid            = ctrl_CG_0_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_0_address_in                  = ctrl_CG_0_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_0_data_in_valid               = ctrl_CG_0_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_0_data_in                     = ctrl_CG_0_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_1_address_in_valid            = ctrl_CG_0_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_1_address_in                  = ctrl_CG_0_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_1_data_in_valid               = ctrl_CG_0_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_1_data_in                     = ctrl_CG_0_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_2_address_in_valid            = ctrl_CG_0_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_2_address_in                  = ctrl_CG_0_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_0_GLB_iact_2_2_data_in_valid               = ctrl_CG_0_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_0_GLB_iact_2_2_data_in                     = ctrl_CG_0_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_0_GLB_weight_0_address_in_valid            = ctrl_CG_0_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_0_address_in                  = ctrl_CG_0_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_0_GLB_weight_0_data_in_valid               = ctrl_CG_0_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_0_data_in                     = ctrl_CG_0_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_0_GLB_weight_1_address_in_valid            = ctrl_CG_0_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_1_address_in                  = ctrl_CG_0_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_0_GLB_weight_1_data_in_valid               = ctrl_CG_0_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_1_data_in                     = ctrl_CG_0_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_0_GLB_weight_2_address_in_valid            = ctrl_CG_0_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_2_address_in                  = ctrl_CG_0_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_0_GLB_weight_2_data_in_valid               = ctrl_CG_0_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_0_GLB_weight_2_data_in                     = ctrl_CG_0_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_0_GLB_psum_0_data_in_valid                 = 'd1;
assign	CG_0_0_GLB_psum_0_data_in                       = 'd0;
assign	CG_0_0_GLB_psum_0_data_out_ready                = 'd1;
assign	CG_0_0_GLB_psum_1_data_in_valid                 = 'd1;
assign	CG_0_0_GLB_psum_1_data_in                       = 'd0;
assign	CG_0_0_GLB_psum_1_data_out_ready                = 'd1;
assign	CG_0_0_GLB_psum_2_data_in_valid                 = 'd1;
assign	CG_0_0_GLB_psum_2_data_in                       = 'd0;
assign	CG_0_0_GLB_psum_2_data_out_ready                = 'd1;
assign	CG_0_0_PSUM_DEPTH                               = ctrl_CG_0_0_PSUM_DEPTH;
assign	CG_0_0_psum_spad_clear                          = ctrl_CG_0_0_psum_spad_clear;
assign	CG_0_0_iact_write_fin_clear                     = ctrl_CG_0_0_iact_write_fin_clear;
assign	CG_0_0_weight_write_fin_clear                   = ctrl_CG_0_0_weight_write_fin_clear; 


assign	CG_0_1_PE_cluster_iact_data_in_sel     		   	= ctrl_CG_0_1_PE_cluster_iact_data_in_sel; 
assign	CG_0_1_PE_cluster_iact_data_out_sel            	= ctrl_CG_0_1_PE_cluster_iact_data_out_sel;
assign	CG_0_1_PE_cluster_psum_data_in_sel             	= ctrl_CG_0_1_PE_cluster_psum_data_in_sel;
assign	CG_0_1_router_cluster_iact_data_in_sel         	= ctrl_CG_0_1_router_cluster_iact_data_in_sel;
assign	CG_0_1_router_cluster_iact_data_out_sel        	= ctrl_CG_0_1_router_cluster_iact_data_out_sel;
assign	CG_0_1_router_cluster_weight_data_in_sel       	= ctrl_CG_0_1_router_cluster_weight_data_in_sel;
assign	CG_0_1_router_cluster_weight_data_out_sel      	= ctrl_CG_0_1_router_cluster_weight_data_out_sel;
assign	CG_0_1_router_cluster_psum_data_in_sel         	= ctrl_CG_0_1_router_cluster_psum_data_in_sel;
assign	CG_0_1_router_cluster_psum_data_out_sel        	= ctrl_CG_0_1_router_cluster_psum_data_out_sel;
assign	CG_0_1_read_psum_en								= ctrl_CG_0_1_read_psum_en;
assign	CG_0_1_cg_en                                  	= ctrl_CG_0_1_cg_en;
assign	CG_0_1_src_GLB_load_fin                         = ctrl_CG_0_1_src_GLB_load_fin;
assign	CG_0_1_psum_SRAM_Bank_0_read_out_en        		= ctrl_CG_0_1_psum_SRAM_Bank_0_read_out_en;
assign	CG_0_1_psum_SRAM_Bank_1_read_out_en        		= ctrl_CG_0_1_psum_SRAM_Bank_1_read_out_en;	
assign	CG_0_1_psum_SRAM_Bank_2_read_out_en        		= ctrl_CG_0_1_psum_SRAM_Bank_2_read_out_en;
assign  CG_0_1_PE_0_0_disable							= ctrl_CG_0_1_PE_0_0_disable;						
assign  CG_0_1_PE_0_1_disable                      		= ctrl_CG_0_1_PE_0_1_disable;						
assign  CG_0_1_PE_0_2_disable                      		= ctrl_CG_0_1_PE_0_2_disable;						
assign  CG_0_1_PE_1_0_disable                      		= ctrl_CG_0_1_PE_1_0_disable;						
assign  CG_0_1_PE_1_1_disable                      		= ctrl_CG_0_1_PE_1_1_disable;						
assign  CG_0_1_PE_1_2_disable                      		= ctrl_CG_0_1_PE_1_2_disable;						
assign  CG_0_1_PE_2_0_disable                      		= ctrl_CG_0_1_PE_2_0_disable;						
assign  CG_0_1_PE_2_1_disable                      		= ctrl_CG_0_1_PE_2_1_disable;						
assign  CG_0_1_PE_2_2_disable                      		= ctrl_CG_0_1_PE_2_2_disable;	
assign	CG_0_1_GLB_iact_0_0_read_addr              		= ctrl_CG_0_1_GLB_iact_0_0_read_addr;            
assign	CG_0_1_GLB_iact_0_1_read_addr                   = ctrl_CG_0_1_GLB_iact_0_1_read_addr;            
assign	CG_0_1_GLB_iact_0_2_read_addr                   = ctrl_CG_0_1_GLB_iact_0_2_read_addr;            
assign	CG_0_1_GLB_iact_1_0_read_addr                   = ctrl_CG_0_1_GLB_iact_1_0_read_addr;            
assign	CG_0_1_GLB_iact_1_1_read_addr                   = ctrl_CG_0_1_GLB_iact_1_1_read_addr;            
assign	CG_0_1_GLB_iact_1_2_read_addr                   = ctrl_CG_0_1_GLB_iact_1_2_read_addr;            
assign	CG_0_1_GLB_iact_2_0_read_addr                   = ctrl_CG_0_1_GLB_iact_2_0_read_addr;            
assign	CG_0_1_GLB_iact_2_1_read_addr                   = ctrl_CG_0_1_GLB_iact_2_1_read_addr;            
assign	CG_0_1_GLB_iact_2_2_read_addr                   = ctrl_CG_0_1_GLB_iact_2_2_read_addr;            
assign	CG_0_1_GLB_psum_write_en                        = ctrl_CG_0_1_GLB_psum_write_en;                  
assign	CG_0_1_GLB_psum_0_write_addr                    = ctrl_CG_0_1_GLB_psum_0_write_addr;              
assign	CG_0_1_GLB_psum_1_write_addr                    = ctrl_CG_0_1_GLB_psum_1_write_addr;              
assign	CG_0_1_GLB_psum_2_write_addr                    = ctrl_CG_0_1_GLB_psum_2_write_addr;              
assign	CG_0_1_GLB_psum_0_read_addr                     = ctrl_CG_0_1_GLB_psum_0_read_addr;               
assign	CG_0_1_GLB_psum_1_read_addr                     = ctrl_CG_0_1_GLB_psum_1_read_addr;               
assign	CG_0_1_GLB_psum_2_read_addr                     = ctrl_CG_0_1_GLB_psum_2_read_addr;               
assign	CG_0_1_GLB_iact_0_0_address_in_valid            = ctrl_CG_0_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_0_address_in                  = ctrl_CG_0_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_0_0_data_in_valid               = ctrl_CG_0_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_0_data_in                     = ctrl_CG_0_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_0_1_address_in_valid            = ctrl_CG_0_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_1_address_in                  = ctrl_CG_0_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_0_1_data_in_valid               = ctrl_CG_0_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_1_data_in                     = ctrl_CG_0_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_0_2_address_in_valid            = ctrl_CG_0_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_2_address_in                  = ctrl_CG_0_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_0_2_data_in_valid               = ctrl_CG_0_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_0_2_data_in                     = ctrl_CG_0_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_1_0_address_in_valid            = ctrl_CG_0_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_0_address_in                  = ctrl_CG_0_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_1_0_data_in_valid               = ctrl_CG_0_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_0_data_in                     = ctrl_CG_0_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_1_1_address_in_valid            = ctrl_CG_0_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_1_address_in                  = ctrl_CG_0_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0; 
assign	CG_0_1_GLB_iact_1_1_data_in_valid               = ctrl_CG_0_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_1_data_in                     = ctrl_CG_0_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_1_2_address_in_valid            = ctrl_CG_0_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_2_address_in                  = ctrl_CG_0_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_1_2_data_in_valid               = ctrl_CG_0_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_1_2_data_in                     = ctrl_CG_0_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_0_address_in_valid            = ctrl_CG_0_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_0_address_in                  = ctrl_CG_0_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_0_data_in_valid               = ctrl_CG_0_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_0_data_in                     = ctrl_CG_0_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_1_address_in_valid            = ctrl_CG_0_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_1_address_in                  = ctrl_CG_0_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_1_data_in_valid               = ctrl_CG_0_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_1_data_in                     = ctrl_CG_0_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_2_address_in_valid            = ctrl_CG_0_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_2_address_in                  = ctrl_CG_0_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_0_1_GLB_iact_2_2_data_in_valid               = ctrl_CG_0_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_0_1_GLB_iact_2_2_data_in                     = ctrl_CG_0_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_0_1_GLB_weight_0_address_in_valid            = ctrl_CG_0_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_0_address_in                  = ctrl_CG_0_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_1_GLB_weight_0_data_in_valid               = ctrl_CG_0_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_0_data_in                     = ctrl_CG_0_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_1_GLB_weight_1_address_in_valid            = ctrl_CG_0_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_1_address_in                  = ctrl_CG_0_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_1_GLB_weight_1_data_in_valid               = ctrl_CG_0_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_1_data_in                     = ctrl_CG_0_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_1_GLB_weight_2_address_in_valid            = ctrl_CG_0_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_2_address_in                  = ctrl_CG_0_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_0_1_GLB_weight_2_data_in_valid               = ctrl_CG_0_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_0_1_GLB_weight_2_data_in                     = ctrl_CG_0_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_0_1_GLB_psum_0_data_in_valid                 = 'd1;
assign	CG_0_1_GLB_psum_0_data_in                       = 'd0;
assign	CG_0_1_GLB_psum_0_data_out_ready                = 'd1;
assign	CG_0_1_GLB_psum_1_data_in_valid                 = 'd1;
assign	CG_0_1_GLB_psum_1_data_in                       = 'd0;
assign	CG_0_1_GLB_psum_1_data_out_ready                = 'd1;
assign	CG_0_1_GLB_psum_2_data_in_valid                 = 'd1;
assign	CG_0_1_GLB_psum_2_data_in                       = 'd0;
assign	CG_0_1_GLB_psum_2_data_out_ready                = 'd1;
assign	CG_0_1_PSUM_DEPTH                               = ctrl_CG_0_1_PSUM_DEPTH;
assign	CG_0_1_psum_spad_clear                          = ctrl_CG_0_1_psum_spad_clear;
assign	CG_0_1_iact_write_fin_clear                     = ctrl_CG_0_1_iact_write_fin_clear;
assign	CG_0_1_weight_write_fin_clear                   = ctrl_CG_0_1_weight_write_fin_clear; 


assign	CG_1_0_PE_cluster_iact_data_in_sel     		   	= ctrl_CG_1_0_PE_cluster_iact_data_in_sel; 
assign	CG_1_0_PE_cluster_iact_data_out_sel            	= ctrl_CG_1_0_PE_cluster_iact_data_out_sel;
assign	CG_1_0_PE_cluster_psum_data_in_sel             	= ctrl_CG_1_0_PE_cluster_psum_data_in_sel;
assign	CG_1_0_router_cluster_iact_data_in_sel         	= ctrl_CG_1_0_router_cluster_iact_data_in_sel;
assign	CG_1_0_router_cluster_iact_data_out_sel        	= ctrl_CG_1_0_router_cluster_iact_data_out_sel;
assign	CG_1_0_router_cluster_weight_data_in_sel       	= ctrl_CG_1_0_router_cluster_weight_data_in_sel;
assign	CG_1_0_router_cluster_weight_data_out_sel      	= ctrl_CG_1_0_router_cluster_weight_data_out_sel;
assign	CG_1_0_router_cluster_psum_data_in_sel         	= ctrl_CG_1_0_router_cluster_psum_data_in_sel;
assign	CG_1_0_router_cluster_psum_data_out_sel        	= ctrl_CG_1_0_router_cluster_psum_data_out_sel;
assign	CG_1_0_read_psum_en								= ctrl_CG_1_0_read_psum_en;
assign	CG_1_0_cg_en                                  	= ctrl_CG_1_0_cg_en;
assign	CG_1_0_src_GLB_load_fin                         = ctrl_CG_1_0_src_GLB_load_fin;
assign	CG_1_0_psum_SRAM_Bank_0_read_out_en        		= ctrl_CG_1_0_psum_SRAM_Bank_0_read_out_en;
assign	CG_1_0_psum_SRAM_Bank_1_read_out_en        		= ctrl_CG_1_0_psum_SRAM_Bank_1_read_out_en;	
assign	CG_1_0_psum_SRAM_Bank_2_read_out_en        		= ctrl_CG_1_0_psum_SRAM_Bank_2_read_out_en;
assign  CG_1_0_PE_0_0_disable							= ctrl_CG_1_0_PE_0_0_disable;						
assign  CG_1_0_PE_0_1_disable                      		= ctrl_CG_1_0_PE_0_1_disable;						
assign  CG_1_0_PE_0_2_disable                      		= ctrl_CG_1_0_PE_0_2_disable;						
assign  CG_1_0_PE_1_0_disable                      		= ctrl_CG_1_0_PE_1_0_disable;						
assign  CG_1_0_PE_1_1_disable                      		= ctrl_CG_1_0_PE_1_1_disable;						
assign  CG_1_0_PE_1_2_disable                      		= ctrl_CG_1_0_PE_1_2_disable;						
assign  CG_1_0_PE_2_0_disable                      		= ctrl_CG_1_0_PE_2_0_disable;						
assign  CG_1_0_PE_2_1_disable                      		= ctrl_CG_1_0_PE_2_1_disable;						
assign  CG_1_0_PE_2_2_disable                      		= ctrl_CG_1_0_PE_2_2_disable;	
assign	CG_1_0_GLB_iact_0_0_read_addr              		= ctrl_CG_1_0_GLB_iact_0_0_read_addr;            
assign	CG_1_0_GLB_iact_0_1_read_addr                   = ctrl_CG_1_0_GLB_iact_0_1_read_addr;            
assign	CG_1_0_GLB_iact_0_2_read_addr                   = ctrl_CG_1_0_GLB_iact_0_2_read_addr;            
assign	CG_1_0_GLB_iact_1_0_read_addr                   = ctrl_CG_1_0_GLB_iact_1_0_read_addr;            
assign	CG_1_0_GLB_iact_1_1_read_addr                   = ctrl_CG_1_0_GLB_iact_1_1_read_addr;            
assign	CG_1_0_GLB_iact_1_2_read_addr                   = ctrl_CG_1_0_GLB_iact_1_2_read_addr;            
assign	CG_1_0_GLB_iact_2_0_read_addr                   = ctrl_CG_1_0_GLB_iact_2_0_read_addr;            
assign	CG_1_0_GLB_iact_2_1_read_addr                   = ctrl_CG_1_0_GLB_iact_2_1_read_addr;            
assign	CG_1_0_GLB_iact_2_2_read_addr                   = ctrl_CG_1_0_GLB_iact_2_2_read_addr;            
assign	CG_1_0_GLB_psum_write_en                        = ctrl_CG_1_0_GLB_psum_write_en;                  
assign	CG_1_0_GLB_psum_0_write_addr                    = ctrl_CG_1_0_GLB_psum_0_write_addr;              
assign	CG_1_0_GLB_psum_1_write_addr                    = ctrl_CG_1_0_GLB_psum_1_write_addr;              
assign	CG_1_0_GLB_psum_2_write_addr                    = ctrl_CG_1_0_GLB_psum_2_write_addr;              
assign	CG_1_0_GLB_psum_0_read_addr                     = ctrl_CG_1_0_GLB_psum_0_read_addr;               
assign	CG_1_0_GLB_psum_1_read_addr                     = ctrl_CG_1_0_GLB_psum_1_read_addr;               
assign	CG_1_0_GLB_psum_2_read_addr                     = ctrl_CG_1_0_GLB_psum_2_read_addr;               
assign	CG_1_0_GLB_iact_0_0_address_in_valid            = ctrl_CG_1_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_0_address_in                  = ctrl_CG_1_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_0_0_data_in_valid               = ctrl_CG_1_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_0_data_in                     = ctrl_CG_1_0_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_0_1_address_in_valid            = ctrl_CG_1_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_1_address_in                  = ctrl_CG_1_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_0_1_data_in_valid               = ctrl_CG_1_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_1_data_in                     = ctrl_CG_1_0_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_0_2_address_in_valid            = ctrl_CG_1_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_2_address_in                  = ctrl_CG_1_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_0_2_data_in_valid               = ctrl_CG_1_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_0_2_data_in                     = ctrl_CG_1_0_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_1_0_address_in_valid            = ctrl_CG_1_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_0_address_in                  = ctrl_CG_1_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_1_0_data_in_valid               = ctrl_CG_1_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_0_data_in                     = ctrl_CG_1_0_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_1_1_address_in_valid            = ctrl_CG_1_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_1_address_in                  = ctrl_CG_1_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0; 
assign	CG_1_0_GLB_iact_1_1_data_in_valid               = ctrl_CG_1_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_1_data_in                     = ctrl_CG_1_0_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_1_2_address_in_valid            = ctrl_CG_1_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_2_address_in                  = ctrl_CG_1_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_1_2_data_in_valid               = ctrl_CG_1_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_1_2_data_in                     = ctrl_CG_1_0_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_0_address_in_valid            = ctrl_CG_1_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_0_address_in                  = ctrl_CG_1_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_0_data_in_valid               = ctrl_CG_1_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_0_data_in                     = ctrl_CG_1_0_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_1_address_in_valid            = ctrl_CG_1_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_1_address_in                  = ctrl_CG_1_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_1_data_in_valid               = ctrl_CG_1_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_1_data_in                     = ctrl_CG_1_0_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_2_address_in_valid            = ctrl_CG_1_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_2_address_in                  = ctrl_CG_1_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out		: weight_addr_in) 				: 'd0;
assign	CG_1_0_GLB_iact_2_2_data_in_valid               = ctrl_CG_1_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid	: weight_data_in_valid) 		: 'd0;
assign	CG_1_0_GLB_iact_2_2_data_in                     = ctrl_CG_1_0_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_0_GLB_weight_0_address_in_valid            = ctrl_CG_1_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_0_address_in                  = ctrl_CG_1_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_0_GLB_weight_0_data_in_valid               = ctrl_CG_1_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_0_data_in                     = ctrl_CG_1_0_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_0_GLB_weight_1_address_in_valid            = ctrl_CG_1_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_1_address_in                  = ctrl_CG_1_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_0_GLB_weight_1_data_in_valid               = ctrl_CG_1_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_1_data_in                     = ctrl_CG_1_0_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_0_GLB_weight_2_address_in_valid            = ctrl_CG_1_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid		: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_2_address_in                  = ctrl_CG_1_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_0_GLB_weight_2_data_in_valid               = ctrl_CG_1_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid		: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_0_GLB_weight_2_data_in                     = ctrl_CG_1_0_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_0_GLB_psum_0_data_in_valid                 = 'd1;
assign	CG_1_0_GLB_psum_0_data_in                       = 'd0;
assign	CG_1_0_GLB_psum_0_data_out_ready                = 'd1;
assign	CG_1_0_GLB_psum_1_data_in_valid                 = 'd1;
assign	CG_1_0_GLB_psum_1_data_in                       = 'd0;
assign	CG_1_0_GLB_psum_1_data_out_ready                = 'd1;
assign	CG_1_0_GLB_psum_2_data_in_valid                 = 'd1;
assign	CG_1_0_GLB_psum_2_data_in                       = 'd0;
assign	CG_1_0_GLB_psum_2_data_out_ready                = 'd1;
assign	CG_1_0_PSUM_DEPTH                               = ctrl_CG_1_0_PSUM_DEPTH;
assign	CG_1_0_psum_spad_clear                          = ctrl_CG_1_0_psum_spad_clear;
assign	CG_1_0_iact_write_fin_clear                     = ctrl_CG_1_0_iact_write_fin_clear;
assign	CG_1_0_weight_write_fin_clear                   = ctrl_CG_1_0_weight_write_fin_clear; 


assign	CG_1_1_PE_cluster_iact_data_in_sel     		   	= ctrl_CG_1_1_PE_cluster_iact_data_in_sel; 
assign	CG_1_1_PE_cluster_iact_data_out_sel            	= ctrl_CG_1_1_PE_cluster_iact_data_out_sel;
assign	CG_1_1_PE_cluster_psum_data_in_sel             	= ctrl_CG_1_1_PE_cluster_psum_data_in_sel;
assign	CG_1_1_router_cluster_iact_data_in_sel         	= ctrl_CG_1_1_router_cluster_iact_data_in_sel;
assign	CG_1_1_router_cluster_iact_data_out_sel        	= ctrl_CG_1_1_router_cluster_iact_data_out_sel;
assign	CG_1_1_router_cluster_weight_data_in_sel       	= ctrl_CG_1_1_router_cluster_weight_data_in_sel;
assign	CG_1_1_router_cluster_weight_data_out_sel      	= ctrl_CG_1_1_router_cluster_weight_data_out_sel;
assign	CG_1_1_router_cluster_psum_data_in_sel         	= ctrl_CG_1_1_router_cluster_psum_data_in_sel;
assign	CG_1_1_router_cluster_psum_data_out_sel        	= ctrl_CG_1_1_router_cluster_psum_data_out_sel;
assign	CG_1_1_read_psum_en								= ctrl_CG_1_1_read_psum_en;
assign	CG_1_1_cg_en                                  	= ctrl_CG_1_1_cg_en;
assign	CG_1_1_src_GLB_load_fin                         = ctrl_CG_1_1_src_GLB_load_fin;
assign	CG_1_1_psum_SRAM_Bank_0_read_out_en        		= ctrl_CG_1_1_psum_SRAM_Bank_0_read_out_en;
assign	CG_1_1_psum_SRAM_Bank_1_read_out_en        		= ctrl_CG_1_1_psum_SRAM_Bank_1_read_out_en;	
assign	CG_1_1_psum_SRAM_Bank_2_read_out_en        		= ctrl_CG_1_1_psum_SRAM_Bank_2_read_out_en;
assign  CG_1_1_PE_0_0_disable							= ctrl_CG_1_1_PE_0_0_disable;						
assign  CG_1_1_PE_0_1_disable                      		= ctrl_CG_1_1_PE_0_1_disable;						
assign  CG_1_1_PE_0_2_disable                      		= ctrl_CG_1_1_PE_0_2_disable;						
assign  CG_1_1_PE_1_0_disable                      		= ctrl_CG_1_1_PE_1_0_disable;						
assign  CG_1_1_PE_1_1_disable                      		= ctrl_CG_1_1_PE_1_1_disable;						
assign  CG_1_1_PE_1_2_disable                      		= ctrl_CG_1_1_PE_1_2_disable;						
assign  CG_1_1_PE_2_0_disable                      		= ctrl_CG_1_1_PE_2_0_disable;						
assign  CG_1_1_PE_2_1_disable                      		= ctrl_CG_1_1_PE_2_1_disable;						
assign  CG_1_1_PE_2_2_disable                      		= ctrl_CG_1_1_PE_2_2_disable;	
assign	CG_1_1_GLB_iact_0_0_read_addr              		= ctrl_CG_1_1_GLB_iact_0_0_read_addr;            
assign	CG_1_1_GLB_iact_0_1_read_addr                   = ctrl_CG_1_1_GLB_iact_0_1_read_addr;            
assign	CG_1_1_GLB_iact_0_2_read_addr                   = ctrl_CG_1_1_GLB_iact_0_2_read_addr;            
assign	CG_1_1_GLB_iact_1_0_read_addr                   = ctrl_CG_1_1_GLB_iact_1_0_read_addr;            
assign	CG_1_1_GLB_iact_1_1_read_addr                   = ctrl_CG_1_1_GLB_iact_1_1_read_addr;            
assign	CG_1_1_GLB_iact_1_2_read_addr                   = ctrl_CG_1_1_GLB_iact_1_2_read_addr;            
assign	CG_1_1_GLB_iact_2_0_read_addr                   = ctrl_CG_1_1_GLB_iact_2_0_read_addr;            
assign	CG_1_1_GLB_iact_2_1_read_addr                   = ctrl_CG_1_1_GLB_iact_2_1_read_addr;            
assign	CG_1_1_GLB_iact_2_2_read_addr                   = ctrl_CG_1_1_GLB_iact_2_2_read_addr;            
assign	CG_1_1_GLB_psum_write_en                        = ctrl_CG_1_1_GLB_psum_write_en;                  
assign	CG_1_1_GLB_psum_0_write_addr                    = ctrl_CG_1_1_GLB_psum_0_write_addr;              
assign	CG_1_1_GLB_psum_1_write_addr                    = ctrl_CG_1_1_GLB_psum_1_write_addr;              
assign	CG_1_1_GLB_psum_2_write_addr                    = ctrl_CG_1_1_GLB_psum_2_write_addr;              
assign	CG_1_1_GLB_psum_0_read_addr                     = ctrl_CG_1_1_GLB_psum_0_read_addr;               
assign	CG_1_1_GLB_psum_1_read_addr                     = ctrl_CG_1_1_GLB_psum_1_read_addr;               
assign	CG_1_1_GLB_psum_2_read_addr                     = ctrl_CG_1_1_GLB_psum_2_read_addr;               
assign	CG_1_1_GLB_iact_0_0_address_in_valid            = ctrl_CG_1_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_0_address_in                  = ctrl_CG_1_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_0_0_data_in_valid               = ctrl_CG_1_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_0_data_in                     = ctrl_CG_1_1_GLB_iact_0_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_0_1_address_in_valid            = ctrl_CG_1_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_1_address_in                  = ctrl_CG_1_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_0_1_data_in_valid               = ctrl_CG_1_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_1_data_in                     = ctrl_CG_1_1_GLB_iact_0_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_0_2_address_in_valid            = ctrl_CG_1_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_2_address_in                  = ctrl_CG_1_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_0_2_data_in_valid               = ctrl_CG_1_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_0_2_data_in                     = ctrl_CG_1_1_GLB_iact_0_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_1_0_address_in_valid            = ctrl_CG_1_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_0_address_in                  = ctrl_CG_1_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_1_0_data_in_valid               = ctrl_CG_1_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_0_data_in                     = ctrl_CG_1_1_GLB_iact_1_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_1_1_address_in_valid            = ctrl_CG_1_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_1_address_in                  = ctrl_CG_1_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0; 
assign	CG_1_1_GLB_iact_1_1_data_in_valid               = ctrl_CG_1_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_1_data_in                     = ctrl_CG_1_1_GLB_iact_1_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_1_2_address_in_valid            = ctrl_CG_1_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_2_address_in                  = ctrl_CG_1_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_1_2_data_in_valid               = ctrl_CG_1_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_1_2_data_in                     = ctrl_CG_1_1_GLB_iact_1_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_0_address_in_valid            = ctrl_CG_1_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_0_address_in                  = ctrl_CG_1_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_0_data_in_valid               = ctrl_CG_1_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_0_data_in                     = ctrl_CG_1_1_GLB_iact_2_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_1_address_in_valid            = ctrl_CG_1_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_1_address_in                  = ctrl_CG_1_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_1_data_in_valid               = ctrl_CG_1_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_1_data_in                     = ctrl_CG_1_1_GLB_iact_2_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_2_address_in_valid            = ctrl_CG_1_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out_valid	: weight_addr_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_2_address_in                  = ctrl_CG_1_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_address_out			: weight_addr_in) 				: 'd0;
assign	CG_1_1_GLB_iact_2_2_data_in_valid               = ctrl_CG_1_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out_valid		: weight_data_in_valid) 		: 'd0;
assign	CG_1_1_GLB_iact_2_2_data_in                     = ctrl_CG_1_1_GLB_iact_2_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? csc_iact_data_out			: weight_data_in) 				: 'd0;
assign	CG_1_1_GLB_weight_0_address_in_valid            = ctrl_CG_1_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid			: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_0_address_in                  = ctrl_CG_1_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_1_GLB_weight_0_data_in_valid               = ctrl_CG_1_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid			: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_0_data_in                     = ctrl_CG_1_1_GLB_weight_0_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_1_GLB_weight_1_address_in_valid            = ctrl_CG_1_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid			: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_1_address_in                  = ctrl_CG_1_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_1_GLB_weight_1_data_in_valid               = ctrl_CG_1_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid			: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_1_data_in                     = ctrl_CG_1_1_GLB_weight_1_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_1_GLB_weight_2_address_in_valid            = ctrl_CG_1_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in_valid			: csc_weight_address_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_2_address_in                  = ctrl_CG_1_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_addr_in				: csc_weight_address_out)		: 'd0;
assign	CG_1_1_GLB_weight_2_data_in_valid               = ctrl_CG_1_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in_valid			: csc_weight_data_out_valid)	: 'd0;
assign	CG_1_1_GLB_weight_2_data_in                     = ctrl_CG_1_1_GLB_weight_2_in_en ? ((ctrl_conv_flag | ctrl_CSC_encoder_iact_clear_iact_SRAM) ? weight_data_in				: csc_weight_data_out)			: 'd0;
assign	CG_1_1_GLB_psum_0_data_in_valid                 = 'd1;
assign	CG_1_1_GLB_psum_0_data_in                       = 'd0;
assign	CG_1_1_GLB_psum_0_data_out_ready                = 'd1;
assign	CG_1_1_GLB_psum_1_data_in_valid                 = 'd1;
assign	CG_1_1_GLB_psum_1_data_in                       = 'd0;
assign	CG_1_1_GLB_psum_1_data_out_ready                = 'd1;
assign	CG_1_1_GLB_psum_2_data_in_valid                 = 'd1;
assign	CG_1_1_GLB_psum_2_data_in                       = 'd0;
assign	CG_1_1_GLB_psum_2_data_out_ready                = 'd1;
assign	CG_1_1_PSUM_DEPTH                               = ctrl_CG_1_1_PSUM_DEPTH;
assign	CG_1_1_psum_spad_clear                          = ctrl_CG_1_1_psum_spad_clear;
assign	CG_1_1_iact_write_fin_clear                     = ctrl_CG_1_1_iact_write_fin_clear;
assign	CG_1_1_weight_write_fin_clear                   = ctrl_CG_1_1_weight_write_fin_clear; 



assign	im2col_enable						= ctrl_im2col_enable;
assign	im2col_ifmap_len       				= ctrl_im2col_ifmap_len;       			
assign	im2col_ofmap_size   		    	= ctrl_im2col_ofmap_size;   
assign  im2col_next_weight_row_jump			= ctrl_im2col_next_weight_row_jump;
assign	im2col_next_ifmap_row_jump			= ctrl_im2col_next_ifmap_row_jump;  
assign	im2col_next_vector_jump   			= ctrl_im2col_next_vector_jump;
assign	ctrl_im2col_read_psum_addr   		= im2col_read_psum_addr;	 
assign	ctrl_im2col_convert_one_stream_done = im2col_convert_one_stream_done;

assign	csc_iact_data_in_valid              = ctrl_csc_en & ctrl_conv_flag ? 'd1 : 'd0;
assign	csc_iact_data_in                    = ctrl_csc_en & ctrl_conv_flag ? rearrange_data_out : 'sd0;
assign	csc_iact_address_out_ready          = 1'b1;
assign	csc_iact_data_out_ready             = 1'b1;
assign	csc_iact_matrix_height              = ctrl_CSC_encoder_iact_matrix_height;
assign	csc_iact_matrix_weight              = ctrl_CSC_encoder_iact_matrix_width;
assign 	csc_iact_clear_iact_SRAM			= ctrl_CSC_encoder_iact_clear_iact_SRAM;

assign	csc_weight_data_in_valid            = ctrl_csc_en & ctrl_fc_flag ? 'd1 : 'd0;
assign	csc_weight_data_in                  = ctrl_csc_en & ctrl_fc_flag ? rearrange_data_out : 'sd0;
assign	csc_weight_address_out_ready        = 1'b1;
assign	csc_weight_data_out_ready           = 1'b1;
assign	csc_weight_matrix_height            = ctrl_CSC_encoder_weight_matrix_height;
assign	csc_weight_matrix_weight            = ctrl_CSC_encoder_weight_matrix_width;
assign 	csc_weight_clear_iact_SRAM			= ctrl_CSC_encoder_weight_clear_iact_SRAM;

assign	rearrange_write_en				= ctrl_psum_rearrange_write_en;
assign	rearrange_write_addr			= ctrl_psum_rearrange_write_addr;
assign	rearrange_data_in               = ctrl_ifmap_in_en ? iact_in		: (pool_enable ? pool_data_out 		 : (ctrl_ReLU_en ? ReLU_data_out 	  	: 'd0));
assign	rearrange_data_in_valid         = ctrl_ifmap_in_en ? iact_in_valid	: (pool_enable ? pool_data_out_valid : (ctrl_ReLU_en ? ReLU_data_out_valid 	: 'd0));
assign	rearrange_read_addr             = ctrl_psum_rearrange_read_addr;


wire signed	[20:0]	GLB_psum_out		= ctrl_CG_0_0_GLB_psum_0_out_en ? CG_0_0_GLB_psum_0_data_out : 
										  ctrl_CG_0_0_GLB_psum_1_out_en ? CG_0_0_GLB_psum_1_data_out : 
										  ctrl_CG_0_0_GLB_psum_2_out_en ? CG_0_0_GLB_psum_2_data_out : 
										  ctrl_CG_0_1_GLB_psum_0_out_en ? CG_0_1_GLB_psum_0_data_out : 
										  ctrl_CG_0_1_GLB_psum_1_out_en ? CG_0_1_GLB_psum_1_data_out : 
										  ctrl_CG_0_1_GLB_psum_2_out_en ? CG_0_1_GLB_psum_2_data_out : 
										  ctrl_CG_1_0_GLB_psum_0_out_en ? CG_1_0_GLB_psum_0_data_out : 
										  ctrl_CG_1_0_GLB_psum_1_out_en ? CG_1_0_GLB_psum_1_data_out : 
										  ctrl_CG_1_0_GLB_psum_2_out_en ? CG_1_0_GLB_psum_2_data_out : 
										  ctrl_CG_1_1_GLB_psum_0_out_en ? CG_1_1_GLB_psum_0_data_out : 
										  ctrl_CG_1_1_GLB_psum_1_out_en ? CG_1_1_GLB_psum_1_data_out : 
										  ctrl_CG_1_1_GLB_psum_2_out_en ? CG_1_1_GLB_psum_2_data_out : 'sd0;
										  
wire 				GLB_psum_out_valid	= ctrl_CG_0_0_GLB_psum_0_out_en ? CG_0_0_GLB_psum_0_data_out_valid : 
										  ctrl_CG_0_0_GLB_psum_1_out_en ? CG_0_0_GLB_psum_1_data_out_valid : 
										  ctrl_CG_0_0_GLB_psum_2_out_en ? CG_0_0_GLB_psum_2_data_out_valid : 
										  ctrl_CG_0_1_GLB_psum_0_out_en ? CG_0_1_GLB_psum_0_data_out_valid : 
										  ctrl_CG_0_1_GLB_psum_1_out_en ? CG_0_1_GLB_psum_1_data_out_valid : 
										  ctrl_CG_0_1_GLB_psum_2_out_en ? CG_0_1_GLB_psum_2_data_out_valid : 
										  ctrl_CG_1_0_GLB_psum_0_out_en ? CG_1_0_GLB_psum_0_data_out_valid : 
										  ctrl_CG_1_0_GLB_psum_1_out_en ? CG_1_0_GLB_psum_1_data_out_valid : 
										  ctrl_CG_1_0_GLB_psum_2_out_en ? CG_1_0_GLB_psum_2_data_out_valid : 
										  ctrl_CG_1_1_GLB_psum_0_out_en ? CG_1_1_GLB_psum_0_data_out_valid : 
										  ctrl_CG_1_1_GLB_psum_1_out_en ? CG_1_1_GLB_psum_1_data_out_valid : 
										  ctrl_CG_1_1_GLB_psum_2_out_en ? CG_1_1_GLB_psum_2_data_out_valid : 'd0;


// output
assign	final_out		=  softmax_data_out;
assign	final_out_valid	=  softmax_data_out_valid;

assign	softmax_en 						= ctrl_softmax_en;
assign	softmax_data_in 				= ctrl_softmax_en ? GLB_psum_out 		: 'sd0;
assign	softmax_data_in_valid			= ctrl_softmax_en ? GLB_psum_out_valid 	: 'd0;

assign  psum_SRAM_out_acc_en			= ctrl_psum_SRAM_out_acc_en;
assign	psum_SRAM_out_acc_data_in		= ctrl_psum_SRAM_out_acc_en ? GLB_psum_out 			: 'sd0;
assign	psum_SRAM_out_acc_data_in_valid	= ctrl_psum_SRAM_out_acc_en ? GLB_psum_out_valid 	: 'd0;


// fc1 multiple channels to acc
assign	quant_data_in					= ctrl_layer_count == 'd2 ? psum_SRAM_out_acc_data_out 			: GLB_psum_out;			
assign	quant_data_in_valid             = ctrl_layer_count == 'd2 ? psum_SRAM_out_acc_data_out_valid 	: GLB_psum_out_valid;

assign	ReLU_data_in					= quant_data_out;
assign	ReLU_data_in_valid				= quant_data_out_valid;
	
assign	pool_enable						= ctrl_pool_enable;
assign	pool_data_in                    = ctrl_pool_enable ? rearrange_data_out : 'sd0;
assign	pool_data_in_valid              = ctrl_pool_enable ? 'd1 : 'sd0;

assign	ctrl_CG_0_0_GLB_iact_load_en    = CG_0_0_GLB_iact_load_en;    
assign	ctrl_CG_0_0_PE_weight_load_en   = CG_0_0_PE_weight_load_en;   
assign	ctrl_CG_0_0_cal_fin             = CG_0_0_cal_fin;           
assign	ctrl_CG_0_1_GLB_iact_load_en    = CG_0_1_GLB_iact_load_en;    
assign	ctrl_CG_0_1_PE_weight_load_en   = CG_0_1_PE_weight_load_en;   
assign	ctrl_CG_0_1_cal_fin             = CG_0_1_cal_fin;            
assign	ctrl_CG_1_0_GLB_iact_load_en    = CG_1_0_GLB_iact_load_en;    
assign	ctrl_CG_1_0_PE_weight_load_en   = CG_1_0_PE_weight_load_en;   
assign	ctrl_CG_1_0_cal_fin             = CG_1_0_cal_fin;              
assign	ctrl_CG_1_1_GLB_iact_load_en    = CG_1_1_GLB_iact_load_en;    
assign	ctrl_CG_1_1_PE_weight_load_en   = CG_1_1_PE_weight_load_en;   
assign	ctrl_CG_1_1_cal_fin             = CG_1_1_cal_fin;             
assign	ctrl_CSC_encoder_iact_one_vector_done 	= csc_iact_one_vector_done;
assign	ctrl_CSC_encoder_weight_one_vector_done = csc_weight_one_vector_done;

endmodule
