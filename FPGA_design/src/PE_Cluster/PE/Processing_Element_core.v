// ====================================================================================================== //
// This module is the integration for all SPad in PE.
// PE_Pad is the core of PE, which is contains all control and datapath.
// This design is based on 5-stage pipeline architecture.
// 
// TODO : read later data should be only one cycle
// TODO : optimaize the state machine converted condition
// ====================================================================================================== //


module Processing_Element_core (
	input         			clock,
	input         			reset,
	// data signals
	output        			psum_in_ready,	
	input         			psum_in_valid,
	input 	signed 	[20:0] 	psum_in,
	input  			       	psum_out_ready,
	output 			       	psum_out_valid,
	output 	signed	[20:0] 	psum_out,
				
	input  			       	former_address_in_valid,
	input  			[7:0]  	former_address_in,
	input  			       	former_data_in_valid,
	input  			[12:0] 	former_data_in,
				
	input  			       	later_address_in_valid,
	input  			[6:0]  	later_address_in,
	input  			       	later_data_in_valid,
	input  			[11:0] 	later_data_in,
	
	// control signals
	input         			mac_en,
	input         			psum_enq_en,
	input         			load_en,
	output        			cal_fin,
	
	output 			       	former_address_write_fin,
	output 			       	former_data_write_fin,
				
	output 			       	later_address_write_fin,
	output 			       	later_data_write_fin,
				
	output 			       	psum_acc_fin,
	
	input			[4:0]	PSUM_DEPTH,
	input					psum_spad_clear
);

// ====================================================================	//
// 						 		Instantiation  							//
// ====================================================================	//
// PSumSPad module
wire					Psum_Spad_psum_in_ready; 
wire					Psum_Spad_psum_in_valid; 
wire	signed [20:0] 	Psum_Spad_psum_in; 
wire  					Psum_Spad_psum_out_ready; 
wire  					Psum_Spad_psum_out_valid; 
wire 	signed	[20:0] 	Psum_Spad_psum_out; 
wire 			[4:0] 	Psum_Spad_read_idx; 
wire 			[4:0] 	Psum_Spad_write_idx; 

// former address spad module
wire 			[7:0] 	former_address_spad_data_out;
wire 			 		former_address_spad_data_in_ready; 
wire 			 		former_address_spad_data_in_valid; 
wire 			[7:0] 	former_address_spad_data_in; 
wire 			 		former_address_spad_write_en; 
wire 			 		former_address_spad_write_fin;
wire 			 		former_address_spad_idx_inc;

// former data spad module
wire 			[7:0] 	former_data_spad_col_num; 
wire 			[12:0] 	former_data_spad_data_out;
wire 			 		former_data_spad_data_in_ready; 
wire 			 		former_data_spad_data_in_valid; 
wire 			[12:0] 	former_data_spad_data_in; 
wire 			 		former_data_spad_write_en; 
wire 			 		former_data_spad_write_fin;
wire 			 		former_data_spad_idx_inc;

// later address spad module
wire 			[6:0] 	later_address_spad_data_out; 
wire 			 		later_address_spad_data_in_ready;
wire 			 		later_address_spad_data_in_valid;
wire 			[6:0] 	later_address_spad_data_in; 
wire 			 		later_address_spad_write_en; 
wire 			 		later_address_spad_write_fin;
wire 			[4:0] 	later_address_spad_read_idx;
wire 			 		later_address_spad_idx_inc; 
wire 			 		later_address_spad_read_idx_en; 

// later data spad module
wire 			[6:0] 	later_data_spad_col_num;
wire 			[11:0] 	later_data_spad_data_out;
wire 			 		later_data_spad_data_in_ready; 
wire 			 		later_data_spad_data_in_valid; 
wire 			[11:0] 	later_data_spad_data_in; 
wire 			 		later_data_spad_write_en; 
wire 			 		later_data_spad_write_fin;
wire 			 		later_data_spad_read_en; 
wire 			[6:0] 	later_data_spad_read_idx; 
wire 			 		later_data_spad_read_idx_inc;
wire 			 		later_data_spad_read_idx_en;

Psum_Spad Psum_Spad_inst ( 
	.clock			(clock						),
	.reset			(reset						),
	.psum_in_ready	(Psum_Spad_psum_in_ready	),
	.psum_in_valid	(Psum_Spad_psum_in_valid	),
	.psum_in		(Psum_Spad_psum_in			),
	.psum_out_ready	(Psum_Spad_psum_out_ready	),
	.psum_out_vaild	(Psum_Spad_psum_out_valid	),
	.psum_out		(Psum_Spad_psum_out			),
	.read_idx		(Psum_Spad_read_idx			),
	.write_idx		(Psum_Spad_write_idx		),
	.psum_spad_clear(psum_spad_clear			)
);

Former_Address_Spad Former_Address_Spad_inst ( 
	.clock			(clock								),
	.reset			(reset								),
	.data_out		(former_address_spad_data_out		),
	.data_in_ready	(former_address_spad_data_in_ready	),
	.data_in_valid	(former_address_spad_data_in_valid	),
	.data_in		(former_address_spad_data_in		),
	.write_en		(former_address_spad_write_en		),
	.write_fin		(former_address_spad_write_fin		),
	.index_inc		(former_address_spad_idx_inc		)
);

Former_Data_Spad Former_Data_Spad_inst ( 
	.clock			(clock								),
	.reset			(reset								),
	.column_num		(former_data_spad_col_num			),
	.data_out		(former_data_spad_data_out			),
	.data_in_ready	(former_data_spad_data_in_ready		),
	.data_in_valid	(former_data_spad_data_in_valid		),
	.data_in		(former_data_spad_data_in			),
	.write_en		(former_data_spad_write_en			),
	.write_fin		(former_data_spad_write_fin			),
	.index_inc		(former_data_spad_idx_inc			)
);

Later_Address_Spad Later_Address_Spad_inst ( 
	.clock			(clock								),
	.reset			(reset								),
	.data_out		(later_address_spad_data_out		),
	.data_in_ready	(later_address_spad_data_in_ready	),
	.data_in_valid	(later_address_spad_data_in_valid	),
	.data_in		(later_address_spad_data_in			),
	.write_en		(later_address_spad_write_en		),
	.write_fin		(later_address_spad_write_fin		),
	.read_idx		(later_address_spad_read_idx		),
	.addr_read_inc	(later_address_spad_idx_inc			),
	.read_idx_en	(later_address_spad_read_idx_en		)
);

Later_Data_Spad Later_Data_Spad_inst (
	.clock			(clock							),
	.reset			(reset							),
	.column_num		(later_data_spad_col_num		),
	.data_out		(later_data_spad_data_out		),
	.data_in_ready	(later_data_spad_data_in_ready	),
	.data_in_valid	(later_data_spad_data_in_valid	),
	.data_in		(later_data_spad_data_in		),
	.write_en		(later_data_spad_write_en		),
	.write_fin		(later_data_spad_write_fin		),
	.read_en		(later_data_spad_read_en		),
	.read_idx		(later_data_spad_read_idx		),
	.index_inc		(later_data_spad_read_idx_inc	),
	.read_idx_en	(later_data_spad_read_idx_en	)
);

// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
parameter WEIGHT_MATRIX_ROW = 4;

// state parameters
localparam IDLE 				= 3'd0;			// the pad is idle, and if received mac_en signal from controller, then start 5 stage pipeline
localparam READ_FORMER_ADDRESS 	= 3'd1;			// read the former address
localparam READ_FORMER_DATA 	= 3'd2;			// read the former data
localparam READ_LATER_ADDRESS 	= 3'd3;			// read the later address
localparam READ_LATER_DATA_1 	= 3'd4;			// read the later data
localparam READ_LATER_DATA_2 	= 3'd5;			// wait one cycle as SRAM
localparam DO_MAC 				= 3'd6;			// wait for mac computation
localparam WRITE_BACK 			= 3'd7;			// write the partial sum back					


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg 		[2:0]	PE_state, next_PE_state;	// state FSM signals

reg 		[3:0] 	former_matrix_col_reg; 
reg 				former_matrix_inc_reg;
reg  				former_data_first_read_reg; 
reg 				later_data_first_read_reg; 

reg signed 	[20:0]	product_reg;    						// iact * weight                     							
reg signed 	[20:0] 	psum_load_reg;							// psum load from psum spad       
reg  				psum_load_state;						// determine psum accumulation is for psum spad or psum_in form PE ouside 
reg 		[4:0] 	psum_read_idx_reg, next_psum_read_idx;	// PSUM SPad read idx FSM signals


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
// state FSM signals
wire IDLE_wire 					= PE_state == IDLE;
wire READ_FORMER_ADDRESS_wire 	= PE_state == READ_FORMER_ADDRESS;
wire READ_FORMER_DATA_wire 		= PE_state == READ_FORMER_DATA;
wire READ_LATER_ADDRESS_wire 	= PE_state == READ_LATER_ADDRESS;
wire READ_LATER_DATA_1_wire 	= PE_state == READ_LATER_DATA_1;
wire READ_LATER_DATA_2_wire 	= PE_state == READ_LATER_DATA_2;
wire DO_MAC_wire 				= PE_state == DO_MAC;			
wire WRITE_BACK_wire 			= PE_state == WRITE_BACK;		


// data coun vector decoding				       			
wire 		[4:0] 	former_matrix_row_wire	= former_data_spad_data_out	[4:0];
wire signed [7:0] 	former_matrix_data_wire	= former_data_spad_data_out	[12:5];
wire 		[3:0] 	later_matrix_row_wire	= later_data_spad_data_out	[3:0];  
wire signed [7:0] 	later_matrix_data_wire	= later_data_spad_data_out	[11:4];


// use the maximum value of the address to stand for current column is all zero to skip this column
wire former_zero_col_wire  					= former_address_spad_data_out 	== 8'd255;
wire later_zero_col_wire					= later_address_spad_data_out	== 7'd127;

wire read_later_zero_col_wire 				= former_matrix_row_wire == later_address_spad_data_out;
wire later_matrix_read_first_col_wire 		= former_matrix_row_wire == 5'd0; 


// SPad control
wire signed [20:0]	product_wire 			= (later_matrix_row_wire == 'd15) ? 'sd0 : (later_matrix_data_wire * former_matrix_data_wire);  // TODO 
wire signed [20:0] 	psum_load_wire 		 	= Psum_Spad_psum_out;
wire signed [20:0] 	psum_acc_result_wire 	= psum_load_state ? (psum_load_wire + psum_in) : (psum_load_reg + product_reg);
wire 		[4:0]  	psum_write_idx_wire  	= later_matrix_row_wire + (former_matrix_col_reg-1) * WEIGHT_MATRIX_ROW; 
wire				psum_read_fin_wire		= psum_read_idx_reg == PSUM_DEPTH;


wire former_data_spad_idx_inc_wire 			= former_address_spad_data_out == (former_data_spad_col_num + 'd1);
wire Iact_Data_Spad_read_fin_wire			= (former_matrix_data_wire == 'd0) & (~former_data_first_read_reg);
	
wire later_data_spad_read_fin_wire   		= (later_matrix_data_wire == 'd0); 
wire later_data_spad_idx_inc_wire   		= (later_address_spad_data_out == (later_data_spad_col_num + 'd1)) | later_data_spad_read_fin_wire;
wire later_address_spad_read_fin_wire 		= (later_address_spad_data_out == 'd0) ? 1'b1 : 1'b0;
	
wire Psum_Spad_read_valid_wire 				= psum_in_valid & psum_load_state;
wire Psum_Spad_read_idx_inc_wire 			= psum_out_ready & psum_out_valid;
wire Psum_Spad_read_fin_wire 				= (READ_FORMER_DATA_wire 	& Iact_Data_Spad_read_fin_wire)	|
											  (WRITE_BACK_wire 			& Iact_Data_Spad_read_fin_wire) | 
											  (psum_read_fin_wire 		& Psum_Spad_read_idx_inc_wire);


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
// output signals
assign cal_fin 						= Iact_Data_Spad_read_fin_wire & ~IDLE_wire;
			
assign psum_in_ready 				= psum_out_ready & psum_load_state;
assign psum_out_valid 				= Psum_Spad_psum_out_ready & Psum_Spad_psum_out_valid & Psum_Spad_read_valid_wire;
assign psum_out 					= psum_acc_result_wire;
assign psum_acc_fin 				= Psum_Spad_read_fin_wire & psum_load_state;

assign former_address_write_fin		= former_address_spad_write_fin;
assign former_data_write_fin 		= former_data_spad_write_fin;
	
assign later_address_write_fin 		= later_address_spad_write_fin;
assign later_data_write_fin 		= later_data_spad_write_fin;


// instantiated module connection
assign Psum_Spad_psum_in_valid 				= WRITE_BACK_wire;
assign Psum_Spad_psum_in 					= WRITE_BACK_wire ? psum_acc_result_wire : 21'sd0;
assign Psum_Spad_psum_out_ready 			= DO_MAC_wire | Psum_Spad_read_valid_wire;
assign Psum_Spad_read_idx 					= next_psum_read_idx;
assign Psum_Spad_write_idx 					= psum_write_idx_wire;

assign former_address_spad_data_in_valid	= former_address_in_valid;
assign former_address_spad_data_in 			= former_address_in;
assign former_address_spad_write_en 		= load_en;
assign former_address_spad_idx_inc 			= (READ_FORMER_ADDRESS_wire && former_zero_col_wire) 												|| 
											  (READ_LATER_ADDRESS_wire 	&& former_data_spad_idx_inc_wire	&& later_zero_col_wire) 			|| 
											  (WRITE_BACK_wire 			&& former_data_spad_idx_inc_wire	&& later_data_spad_idx_inc_wire) 	|| 
											  (~IDLE_wire 				&& cal_fin);

assign former_data_spad_data_in_valid 		= former_data_in_valid;
assign former_data_spad_data_in 			= former_data_in;
assign former_data_spad_write_en 			= load_en;	
assign former_data_spad_idx_inc 			= (READ_FORMER_ADDRESS_wire && (~former_zero_col_wire | ~former_data_spad_idx_inc_wire) && (~former_data_first_read_reg)) 	|| 
											  (READ_LATER_ADDRESS_wire 	&& later_zero_col_wire && (~former_data_spad_idx_inc_wire)) 									|| 
											  (WRITE_BACK_wire 			&& later_data_spad_idx_inc_wire && (~former_data_spad_idx_inc_wire)) 							|| 
											  (~IDLE_wire 				&& Iact_Data_Spad_read_fin_wire);

assign later_address_spad_data_in_valid		= later_address_in_valid;
assign later_address_spad_data_in 			= later_address_in;
assign later_address_spad_write_en 			= load_en;
assign later_address_spad_read_idx 			= (READ_FORMER_DATA_wire & later_data_first_read_reg 	& (~later_matrix_read_first_col_wire)) ? (former_matrix_row_wire - 4'd1) : former_matrix_row_wire;
assign later_address_spad_read_idx_en 		= (READ_FORMER_DATA_wire 	| READ_LATER_ADDRESS_wire) 	& later_data_first_read_reg;
assign later_address_spad_idx_inc 			= (READ_LATER_DATA_1_wire 	| DO_MAC_wire) 				& later_zero_col_wire;

assign later_data_spad_data_in_valid 		= later_data_in_valid;
assign later_data_spad_data_in 				= later_data_in;
assign later_data_spad_write_en 			= load_en;
assign later_data_spad_read_en 				= READ_LATER_DATA_1_wire;
assign later_data_spad_read_idx 			= later_matrix_read_first_col_wire ? 'd0 : later_address_spad_data_out;
assign later_data_spad_read_idx_en 			= (READ_LATER_ADDRESS_wire) & later_data_first_read_reg 	& (~later_zero_col_wire);
assign later_data_spad_read_idx_inc 		= (READ_LATER_ADDRESS_wire 	& (~later_zero_col_wire) 		& (~later_data_first_read_reg)) | 
											  (WRITE_BACK_wire 			& (~later_data_spad_idx_inc_wire));

// state converted signals
wire former_address_read_done_wire	= ~(former_data_spad_idx_inc_wire & former_zero_col_wire);
wire former_data_read_done_wire 	= Iact_Data_Spad_read_fin_wire;
wire later_data_read_done 			= later_data_spad_idx_inc_wire 	| later_address_spad_read_fin_wire;
wire former_one_col_read_done		= former_data_spad_idx_inc_wire | later_address_spad_read_fin_wire;

// next state logic
always@(*) begin
	case(PE_state)
		IDLE 				: next_PE_state = mac_en 						? READ_FORMER_ADDRESS 	: IDLE;
		READ_FORMER_ADDRESS : next_PE_state = former_address_read_done_wire ? READ_FORMER_DATA 		: READ_FORMER_ADDRESS;
		READ_FORMER_DATA 	: next_PE_state = former_data_read_done_wire 	? IDLE 					: READ_LATER_ADDRESS;
		READ_LATER_ADDRESS 	: next_PE_state = ~later_zero_col_wire 			? READ_LATER_DATA_1 	: 
											  former_data_spad_idx_inc_wire ? READ_FORMER_ADDRESS 	: READ_FORMER_DATA;
		READ_LATER_DATA_1 	: next_PE_state = READ_LATER_DATA_2;
		READ_LATER_DATA_2 	: next_PE_state = DO_MAC;
		DO_MAC 				: next_PE_state = WRITE_BACK;
		WRITE_BACK 	        : next_PE_state = former_data_read_done_wire 	? IDLE 					: 
											  ~later_data_read_done 		? READ_LATER_DATA_1 	: 
											  former_one_col_read_done 		? READ_FORMER_ADDRESS 	: READ_FORMER_DATA;
		default				: next_PE_state = IDLE;
	endcase
end


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
// FSM
always@(posedge clock) begin
	if(reset) begin
		PE_state <= IDLE;
	end
	else begin
		PE_state <= next_PE_state;
	end
end	

always@(posedge clock) begin
	if(reset) begin
		former_matrix_inc_reg <= 1'b0;
	end
	else if(READ_FORMER_ADDRESS_wire)begin
		former_matrix_inc_reg <= former_zero_col_wire;
	end
end


always@(posedge clock) begin
	if(reset) begin
		former_matrix_col_reg <= 'd0;
	end
	else if(psum_enq_en)begin
		former_matrix_col_reg <= 'd0;
	end
	else if(READ_FORMER_ADDRESS_wire)begin
		former_matrix_col_reg <= former_matrix_col_reg + former_matrix_inc_reg + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		former_data_first_read_reg <= 1'b1;
	end 
	else begin
		if(READ_FORMER_DATA_wire | WRITE_BACK_wire) begin
			former_data_first_read_reg <= Iact_Data_Spad_read_fin_wire | former_data_first_read_reg;
		end
		else if(READ_LATER_ADDRESS_wire) begin
			former_data_first_read_reg <= 1'b0;
		end
	end
end	
	
always@(posedge clock) begin
	if(reset) begin
		later_data_first_read_reg <= 1'b1;
	end 
	else begin
	    if(IDLE_wire) begin
			later_data_first_read_reg <= mac_en | later_data_first_read_reg;
		end
		else if(READ_LATER_ADDRESS_wire) begin
			later_data_first_read_reg <= later_zero_col_wire | later_data_first_read_reg;
		end
		else if(WRITE_BACK_wire && !Iact_Data_Spad_read_fin_wire) begin
			later_data_first_read_reg <= later_data_spad_idx_inc_wire | later_address_spad_read_fin_wire;
		end
	end
end

always@(posedge clock) begin	
	if(reset) begin
		product_reg <= 21'sd0;
	end 
	else begin
		if(DO_MAC_wire) begin
			product_reg <= product_wire;	// TODO
		end
	end
end

always@(posedge clock) begin
	if(reset) begin
		psum_load_reg <= 21'sd0;
	end 
	else begin
		psum_load_reg <= psum_load_wire;
	end
end

always@(posedge clock) begin
	if(reset) begin
		psum_load_state <= 1'b0; 
	end 
	else if(psum_acc_fin) begin
		psum_load_state <= 1'b0;
	end 
	else begin
		psum_load_state <= psum_enq_en | psum_load_state;
	end
end
	
	
// psum read index FSM
always@(posedge clock) begin	
	if(reset) begin 
		psum_read_idx_reg <= 5'd0; 
	end 
	else begin 
		psum_read_idx_reg <= next_psum_read_idx;
	end 
end

// next psum read index logic
always@(*) begin	
	if(READ_LATER_DATA_2_wire) begin 
		next_psum_read_idx <= Psum_Spad_write_idx;
	end 
	else if (Psum_Spad_read_fin_wire) begin 
		next_psum_read_idx <= 5'd0;
	end 
	else if (Psum_Spad_read_idx_inc_wire) begin 
		next_psum_read_idx <= psum_read_idx_reg + 5'd1;
	end
	else begin
		next_psum_read_idx <= psum_read_idx_reg;
	end
end


endmodule
