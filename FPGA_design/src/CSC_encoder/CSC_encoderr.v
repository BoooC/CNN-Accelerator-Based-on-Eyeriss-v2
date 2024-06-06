// ====================================================================================================== //
// This module is CSC_Encoder.
// CSC_Encoder read data in column direction.
//
// The input matrix_height and matrix_width is output matrix shape.
// An additive signal clear_iact_SRAM is used to clear GBL SRAM Bank.
// The clear represents write contineous zero to clear SRAM Bank module.
// data in SRAM will not be clear, but SRAM Bank module will clear writing address.
//
// PEs don't support over 2 contineous zero column, therefore, this module can detect 2 contineous column,
// and set the second column contains one value 1 and coressponding count will be set the maximum value to
// let PES detect this column has been modify, and PE will dischard this valud.
// 
// ====================================================================================================== //


module CSC_Encoder #(
	parameter ADDR_WIDTH 	= 7,
	parameter COUNT_WIDTH 	= 4,
	parameter DATA_WIDTH 	= 8
	)
(
	input         							clock,
	input         							reset,
	output        							data_in_ready,
	input         							data_in_valid,
	input 	signed 	[7:0]  					data_in,
					
	input         							address_out_ready,
	output        							address_out_valid,
	output [ADDR_WIDTH-1:0] 				address_out,
	input         							data_out_ready,
	output        							data_out_valid,
	output [DATA_WIDTH+COUNT_WIDTH-1:0] 	data_out,
					
	input  [4:0]  							matrix_height,
	input  [4:0]  							matrix_width,
	
	input									clear_iact_SRAM,
	
	output									one_vector_done
);


// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam DATA_IN_BITWIDTH  = 8;


// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//
wire  								data_in_FIFO_clock; 
wire  								data_in_FIFO_reset; 
wire  								data_in_FIFO_data_in_ready; 
wire  								data_in_FIFO_data_in_valid; 
wire signed	[7:0] 					data_in_FIFO_data_in; 
wire  								data_in_FIFO_data_out_ready; 
wire  								data_in_FIFO_data_out_valid; 
wire signed	[7:0] 					data_in_FIFO_data_out; 
						
wire  								address_out_FIFO_clock; 
wire  								address_out_FIFO_reset; 
wire  								address_out_FIFO_data_in_ready; 
wire  								address_out_FIFO_data_in_valid; 
wire [ADDR_WIDTH-1:0] 				address_out_FIFO_data_in; 
wire  								address_out_FIFO_data_out_ready;
wire  								address_out_FIFO_data_out_valid; 
wire [ADDR_WIDTH-1:0] 				address_out_FIFO_data_out; 

wire  								data_out_FIFO_clock; 
wire  								data_out_FIFO_reset;
wire  								data_out_FIFO_data_in_ready; 
wire  								data_out_FIFO_data_in_valid; 
wire [DATA_WIDTH+COUNT_WIDTH-1:0] 	data_out_FIFO_data_in; 
wire  								data_out_FIFO_data_out_ready; 
wire  								data_out_FIFO_data_out_valid; 
wire [DATA_WIDTH+COUNT_WIDTH-1:0] 	data_out_FIFO_data_out; 


CSC_switch_FIFO  #(
	.DATA_WIDTH(DATA_IN_BITWIDTH)
	)
Data_in_FIFO( 
	.clock			(data_in_FIFO_clock			),
	.reset			(data_in_FIFO_reset			),
	.data_in_ready	(data_in_FIFO_data_in_ready	),
	.data_in_valid	(data_in_FIFO_data_in_valid	),
	.data_in 		(data_in_FIFO_data_in		),
	.data_out_ready	(data_in_FIFO_data_out_ready),
	.data_out_valid	(data_in_FIFO_data_out_valid),
	.data_out 		(data_in_FIFO_data_out		)
);

CSC_switch_FIFO  #(
	.DATA_WIDTH(ADDR_WIDTH)
	)
Address_out_FIFO( 
	.clock			(address_out_FIFO_clock			),
	.reset			(address_out_FIFO_reset			),
	.data_in_ready	(address_out_FIFO_data_in_ready	),
	.data_in_valid	(address_out_FIFO_data_in_valid	),
	.data_in 		(address_out_FIFO_data_in		),
	.data_out_ready	(address_out_FIFO_data_out_ready),
	.data_out_valid	(address_out_FIFO_data_out_valid),
	.data_out 		(address_out_FIFO_data_out		)
);

CSC_switch_FIFO  #(
	.DATA_WIDTH(DATA_WIDTH+COUNT_WIDTH)
	)
Data_out_FIFO( 
	.clock			(data_out_FIFO_clock			),
	.reset			(data_out_FIFO_reset			),
	.data_in_ready	(data_out_FIFO_data_in_ready	),
	.data_in_valid	(data_out_FIFO_data_in_valid	),
	.data_in 		(data_out_FIFO_data_in			),
	.data_out_ready	(data_out_FIFO_data_out_ready	),
	.data_out_valid	(data_out_FIFO_data_out_valid	),
	.data_out 		(data_out_FIFO_data_out			)
);


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg  [COUNT_WIDTH-1:0] 	csc_count; 
reg  [ADDR_WIDTH-1:0] 	csc_address; 
reg  [4:0] 				column_counter; 
reg  					zero_col;

reg   					one_vector_fin_reg; 
reg						end_flag_reg;
reg						first_col_flag;
reg	[4:0]				zero_count;
reg	[4:0]				count;

// reg						pre_zero_col;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire  one_col_fin 		= matrix_height == (csc_count + 'd1); 
wire  one_matrix_fin 	= matrix_width 	== (column_counter + 'd1); 

wire  meet_non_zero 		= data_in_FIFO_data_out != 'sd0; 
wire  current_zero_column 	= one_col_fin & (~meet_non_zero) & zero_col; 
wire  first_none_zero_value = meet_non_zero & zero_col; 
wire  first_col_all_zero 	= first_col_flag & (zero_count == count) & (data_in == 'd0);
wire  current_col_all_zero 	= (zero_count == count) & (data_in == 'd0);

// CSC encoding valid
wire  out_data_valid = meet_non_zero & data_in_FIFO_data_out_valid;
wire  out_addr_valid = (current_zero_column | first_none_zero_value) & data_in_FIFO_data_out_valid & (csc_address != 'd0); 

wire  end_flag = one_vector_fin_reg; 

// wire adjust_flag = (first_col_all_zero & count == matrix_height-'d1) | (current_col_all_zero & pre_zero_col & one_col_fin);
wire adjust_flag = (first_col_all_zero & count == matrix_height-'d1) | (current_col_all_zero & one_col_fin);


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// output
assign one_vector_done		= (address_out_valid == 'd1) & (address_out == 'd0);

assign data_in_ready 		= data_in_FIFO_data_in_valid; 

assign address_out_valid 	= clear_iact_SRAM ? 'd1 : address_out_FIFO_data_out_valid; 
assign address_out 			= clear_iact_SRAM ? 'd0 : address_out_FIFO_data_out; 

assign data_out_valid 		= clear_iact_SRAM ? 'd1 : data_out_FIFO_data_out_valid;
assign data_out 			= clear_iact_SRAM ? 'd0 : data_out_FIFO_data_out; 


// inter-connection
assign data_in_FIFO_clock 				= clock;                                                                 
assign data_in_FIFO_reset 				= reset;                                                                 
assign data_in_FIFO_data_in_valid 		= end_flag | end_flag_reg ? 'd0 : data_in_valid;                                                     
assign data_in_FIFO_data_in 			= end_flag | end_flag_reg ? 'd0 : (adjust_flag ? 'd1 : data_in);                                                            
assign data_in_FIFO_data_out_ready 		= 1'b1; // ~end_flag ? (~meet_non_zero ? (data_out_FIFO_data_in_ready & address_out_FIFO_data_in_ready) : 1'b1) : 1'b0;                                                          
                                   
assign address_out_FIFO_clock 			= clock;                                                       
assign address_out_FIFO_reset 			= reset; 
assign address_out_FIFO_data_in_valid 	= end_flag | end_flag_reg | out_addr_valid;                            
assign address_out_FIFO_data_in 		= end_flag_reg ? 'd0 : (current_zero_column ? (1<<ADDR_WIDTH)-1 : csc_address); 
assign address_out_FIFO_data_out_ready 	= address_out_ready;                                       
                                                                                              
assign data_out_FIFO_clock 				= clock;                                                    
assign data_out_FIFO_reset 				= reset;                                                    
assign data_out_FIFO_data_in_valid 		= end_flag | out_data_valid;                         
assign data_out_FIFO_data_in 			= end_flag ? 'd0 : adjust_flag ? ({data_in_FIFO_data_out, ((1<<COUNT_WIDTH)-1)}) : ({data_in_FIFO_data_out, csc_count});  
assign data_out_FIFO_data_out_ready 	= data_out_ready;                                       


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
/*
always@(posedge clock) begin
	if(reset) begin 								
		pre_zero_col <= 'd0;						
	end 
	else if(one_col_fin) begin 						
		pre_zero_col <= current_zero_column;
	end 
end	
*/
	 
always@(posedge clock) begin
	if(reset) begin 								
		zero_count <= 'd0;						
	end 
	else if(end_flag) begin 						
		zero_count <= 'd0;
	end 
	else if(data_in_valid & (data_in == 'd0)) begin 						
		zero_count <= (zero_count == matrix_height-'d1) ? matrix_height-'d1 : zero_count + 'd1;
	end 
end

always@(posedge clock) begin
	if(reset) begin 								
		count <= 'd0;						
	end 
	else if(end_flag) begin 						
		count <= 'd0;
	end 
	else if(data_in_valid) begin 						
		count <= (count == matrix_height-'d1) ? matrix_height-'d1 : count + 'd1;
	end 
end	  

	   
always@(posedge clock) begin
	if(reset) begin 								
		first_col_flag <= 'd1; 							
	end 
	else if(end_flag) begin 						
		first_col_flag <= 'd1;
	end 
	else if(count == matrix_height-'d1) begin 				
		first_col_flag <= first_col_flag & 'd0;
	end
end	
				
				  
always@(posedge clock) begin                                                           
	if(reset) begin                                                                    
		csc_count <= 'd0; 
	end 
	else if(data_in_FIFO_data_out_ready & data_in_FIFO_data_out_valid) begin 
		if(one_col_fin) begin 
			csc_count <= 'd0;
		end 
		else begin
			csc_count <= csc_count + 'd1;
		end
	end
end

always@(posedge clock) begin
	if(reset) begin 								
		csc_address <= 'd0; 							
	end 
	else if(end_flag) begin 						
		csc_address <= 'd0;
	end 
	else if(out_data_valid) begin 				
		csc_address <= csc_address + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin 								
		column_counter <= 'd0; 						
	end 
	else if(end_flag) begin 						
		column_counter <= 'd0;
	end 
	else if(one_col_fin) begin 					
		column_counter <= column_counter + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		zero_col <= 1'b1;
	end
	else if(one_col_fin) begin
		zero_col <= 1'b1;
	end
	else if(meet_non_zero)begin
		zero_col <= 1'b0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		one_vector_fin_reg <= 'd0;
	end
	else begin
		one_vector_fin_reg <= one_col_fin & one_matrix_fin; 		
	end
end
  
always@(posedge clock) begin
	if(reset) begin
		end_flag_reg <= 'd0;
	end
	else begin
		end_flag_reg <= end_flag; 		
	end						
end


endmodule
