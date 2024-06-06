// ====================================================================================================== //
// 
//
//
//
// 
// ====================================================================================================== //


module SCNN_shape_info_compiler (
	input				clock,
	input				reset,
	
	// NN shape
	input		[9:0]	image_size,
	input		[9:0]	image_channels,
	input		[2:0]	filter_size,
	input		[4:0]	filter_numbers,
	
	input		[2:0]	total_layers,
	
	// TOP signal
	input		[2:0]	layer_count,

	
	output		[5:0]	psum_depth,
	output		[7:0]	psum_acc_times_bound,
	
	// im2col addressing jump values
	output		[9:0]	im2col_ifmap_len,
	output		[9:0]	im2col_read_psum_addr_bound,
	output		[4:0]	im2col_ofmap_size,
	output		[9:0]	im2col_next_vector_jump,
	output		[9:0]	im2col_next_ifmap_row_jump,
	output		[9:0]	im2col_next_weight_row_jump,
	
	// CSC Encoder
	output		[4:0]	CSC_encoder_iact_matrix_height,
	output		[4:0]	CSC_encoder_iact_matrix_width,
	
	output		[4:0]	CSC_encoder_weight_matrix_height,
	output		[4:0]	CSC_encoder_weight_matrix_width,
	
	// GLB psum read
	output 		[1:0] 	fc_GLB_psum_read_channel_bound,
	output 		[2:0] 	fc_GLB_psum_read_batche_bound,
	output		[2:0] 	fc_GLB_psum_read_sel_bound,
	output		[4:0]	fc_psum_rearrange_read_count_bound,
	output		[4:0]	fc_psum_rearrange_read_channel_bound,
	
	output		[5:0]	GLB_iact_en_sel_bound,
	output		[2:0]	GLB_iact_load_batch_bound,
	output		[2:0]	GLB_iact_load_channel_bound,
	output		[2:0]	GLB_iact_load_iter_bound,
	
	output		[2:0]	GLB_weight_load_channel_bound,
	
	output		[2:0]	psum_read_out_channel_bound,
	
	
	
	
);





// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
// LUT for model architecture
// layer_0 : conv
// layer_1 : conv
// layer_2 : fc
// layer_3 : fc
// layer_4 : fc
reg [4:0] layer_type_LUT = 5'b00011;	// 1 for conv, 0 for fc




// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire conv_flag 	= layer_type_LUT[layer_count];
wire fc_flag 	= ~layer_type_LUT[layer_count];

wire [3:0] former_matrix_col 	= filter_numbers > 'd8 ? 'd8 : filter_numbers;	// 0~8
wire [2:0] later_matrix_row 	= 'd4;											//0~4

wire weight_broadcast 			= image_channels < 'd7;							

// usage resource
wire [2:0] use_CG_col = 2;
wire [2:0] use_CG_row = weight_broadcast ? 'd2 : 'd1;
wire [2:0] use_PE_col = 3;
wire [2:0] use_PE_row = weight_broadcast ? 'd1 : 'd3;

wire [9:0] im2col_out_row = (image_size -filter_size + 'd1) * (image_size -filter_size + 'd1);
// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign psum_depth 			= conv_flag ? (former_matrix_col * later_matrix_row) : later_matrix_row;

assign psum_acc_times_bound	= (im2col_out_row/later_matrix_row) / (use_CG_col*use_CG_row*use_PE_col);


wire psum_acc_done = (layer0_flag & psum_acc_times == 'd12) 	|
                     (layer1_flag & psum_acc_times == 'd6) 		|
                     (layer2_flag & psum_acc_times == 'd15) 	|
                     (layer3_flag & psum_acc_times == 'd4)		|
                     (layer4_flag & psum_acc_times == 'd1);


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
always@(posedge clock) begin
	if(reset) begin
		
	end
	else if() begin
		
	end
end


endmodule
