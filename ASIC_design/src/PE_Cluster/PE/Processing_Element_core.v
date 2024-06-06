// ====================================================================================================== //
// This module is the integration for all SPad in PE.
// PE_Pad is the core of PE, which is contains all control and datapath.
// This design is based on 5-stage pipeline architecture.
// 
// TODO : read later data should be only one cycle
// TODO : optimaize the state machine converted condition
// ====================================================================================================== //

module Processing_Element_core(
  input         			clock,
  input         			reset,
  input         			mac_en,
  input         			psum_enq_en,
  input         			load_en,
  output        			cal_fin,
  
  output        			psum_in_ready,	
  input         			psum_in_valid,
  input 	signed 	[20:0] 	psum_in,
  input  			       	psum_out_ready,
  output 			       	psum_out_valid,
  output 	signed	[20:0] 	psum_out,
				
  input  			       	iact_address_in_valid,
  input  			[7:0]  	iact_address_in,
  input  			       	iact_data_in_valid,
  input  			[12:0] 	iact_data_in,
				
  input  			       	weight_address_in_valid,
  input  			[6:0]  	weight_address_in,
  input  			       	weight_data_in_valid,
  input  			[11:0] 	weight_data_in,
				
  output 			       	iact_address_write_fin,
  output 			       	iact_data_write_fin,
				
  output 			       	weight_address_write_fin,
  output 			       	weight_data_write_fin,
				
  output 			       	psum_acc_fin,
  
  input				[4:0]	PSUM_DEPTH,
  input						psum_spad_clear
);

// parameter PSUM_DEPTH = 31;

localparam IDLE 				= 3'd0; // the pad is idle, and if received valid signal from control, then read and send data to mac
localparam READ_IACT_ADDRESS 	= 3'd1; // read the input activation address
localparam READ_IACT_DATA 		= 3'd2; // read the input activation data
localparam READ_WEIGHT_ADDRESS 	= 3'd3; // read the weight address
localparam READ_WEIGHT_DATA_1 	= 3'd4; // read the weight data
localparam READ_WEIGHT_DATA_2 	= 3'd5; // wait one cycle as SRAM
localparam DO_MAC 				= 3'd6; // wait for mac computation
localparam WRITE_BACK 			= 3'd7; // write the partial sum back

// PSumSPad module
wire				Psum_Spad_psum_in_ready; 
wire				Psum_Spad_psum_in_valid; 
wire signed [20:0] 	Psum_Spad_psum_in; 
wire  				Psum_Spad_psum_out_ready; 
wire  				Psum_Spad_psum_out_valid; 
wire signed [20:0] 	Psum_Spad_psum_out; 
wire 		[4:0] 	Psum_Spad_read_idx; 
wire 		[4:0] 	Psum_Spad_write_idx; 

// iact address spad module
wire [7:0] 	iact_address_spad_data_out;
wire  		iact_address_spad_data_in_ready; 
wire  		iact_address_spad_data_in_valid; 
wire [7:0] 	iact_address_spad_data_in; 
wire  		iact_address_spad_write_en; 
wire  		iact_address_spad_write_fin;
wire  		iact_address_spad_idx_inc;

// iact data spad module
wire [7:0] 	iact_data_spad_col_num; 
wire [12:0] iact_data_spad_data_out;
wire  		iact_data_spad_data_in_ready; 
wire  		iact_data_spad_data_in_valid; 
wire [12:0] iact_data_spad_data_in; 
wire  		iact_data_spad_write_en; 
wire  		iact_data_spad_write_fin;
wire  		Iact_Data_Spad_idx_inc;

// weight address spad module
wire [6:0] 	weight_address_spad_data_out; 
wire  		weight_address_spad_data_in_ready;
wire  		weight_address_spad_data_in_valid;
wire [6:0] 	weight_address_spad_data_in; 
wire  		weight_address_spad_write_en; 
wire  		weight_address_spad_write_fin;
wire [4:0] 	weight_address_spad_read_idx;
wire  		weight_address_spad_idx_inc; 
wire  		weight_address_spad_read_idx_en; 

// weight data spad module
wire [6:0] 	weight_data_spad_col_num;
wire [11:0] weight_data_spad_data_out;
wire  		weight_data_spad_data_in_ready; 
wire  		weight_data_spad_data_in_valid; 
wire [11:0] weight_data_spad_data_in; 
wire  		weight_data_spad_write_en; 
wire  		weight_data_spad_write_fin;
wire  		weight_data_spad_read_en; 
wire [6:0] 	weight_data_spad_read_idx; 
wire  		weight_data_spad_read_idx_inc;
wire  		weight_data_spad_read_idx_en;

Psum_Spad pSumSPadModule ( 
	.clock			(clock),
	.reset			(reset),
	.psum_in_ready	(Psum_Spad_psum_in_ready),
	.psum_in_valid	(Psum_Spad_psum_in_valid),
	.psum_in		(Psum_Spad_psum_in),
	.psum_out_ready	(Psum_Spad_psum_out_ready),
	.psum_out_vaild	(Psum_Spad_psum_out_valid),
	.psum_out		(Psum_Spad_psum_out),
	.read_idx		(Psum_Spad_read_idx),
	.write_idx		(Psum_Spad_write_idx),
	.psum_spad_clear(psum_spad_clear)
);

Iact_Address_Spad inActAdrSPadModule ( 
	.clock			(clock),
	.reset			(reset),
	.data_out		(iact_address_spad_data_out),
	.data_in_ready	(iact_address_spad_data_in_ready),
	.data_in_valid	(iact_address_spad_data_in_valid),
	.data_in		(iact_address_spad_data_in),
	.write_en		(iact_address_spad_write_en),
	.write_fin		(iact_address_spad_write_fin),
	.index_inc		(iact_address_spad_idx_inc)
);

Iact_Data_Spad inActDataSPadModule ( 
	.clock			(clock),
	.reset			(reset),
	.column_num		(iact_data_spad_col_num),
	.data_out		(iact_data_spad_data_out),
	.data_in_ready	(iact_data_spad_data_in_ready),
	.data_in_valid	(iact_data_spad_data_in_valid),
	.data_in		(iact_data_spad_data_in),
	.write_en		(iact_data_spad_write_en),
	.write_fin		(iact_data_spad_write_fin),
	.index_inc		(Iact_Data_Spad_idx_inc)
);

Weight_Address_Spad weightAdrSPadModule ( 
	.clock			(clock),
	.reset			(reset),
	.data_out		(weight_address_spad_data_out),
	.data_in_ready	(weight_address_spad_data_in_ready),
	.data_in_valid	(weight_address_spad_data_in_valid),
	.data_in		(weight_address_spad_data_in),
	.write_en		(weight_address_spad_write_en),
	.write_fin		(weight_address_spad_write_fin),
	.read_idx		(weight_address_spad_read_idx),
	.addr_read_inc	(weight_address_spad_idx_inc),
	.read_idx_en	(weight_address_spad_read_idx_en)
);

Weight_Data_Spad weightDataSPadModule (
	.clock			(clock),
	.reset			(reset),
	.column_num		(weight_data_spad_col_num),
	.data_out		(weight_data_spad_data_out),
	.data_in_ready	(weight_data_spad_data_in_ready),
	.data_in_valid	(weight_data_spad_data_in_valid),
	.data_in		(weight_data_spad_data_in),
	.write_en		(weight_data_spad_write_en),
	.write_fin		(weight_data_spad_write_fin),
	.read_en		(weight_data_spad_read_en),
	.read_idx		(weight_data_spad_read_idx),
	.index_inc		(weight_data_spad_read_idx_inc),
	.read_idx_en	(weight_data_spad_read_idx_en)
);
        							
reg [2:0]	PE_state, next_PE_state;   

reg  		iact_zero_col_reg; 
reg  		iact_data_read_en_reg; 
reg [3:0] 	iact_matrix_col_reg; 
reg [3:0] 	iact_zero_col_num_reg;

reg  		iact_data_first_read_reg; 
reg 		weight_data_first_read; 

reg signed 	[20:0]	product_reg;                         							
reg signed 	[20:0] 	psum_load_reg;             
reg  				psum_load_state;  
reg 		[4:0] 	psum_read_idx_reg;
		      						       			
wire 		[4:0] 	iact_matrix_row_wire    = iact_data_spad_data_out	[4:0];
wire signed [7:0] 	iact_matrix_data_wire   = iact_data_spad_data_out	[12:5];
wire 		[3:0] 	weight_matrix_row_wire  = weight_data_spad_data_out	[3:0];  
wire signed [7:0] 	weight_matrix_data_wire = weight_data_spad_data_out	[11:4];

wire weight_matrix_read_first_col = (iact_matrix_row_wire == 5'd0) ? 1'b1 : 1'b0; 

wire signed [20:0] 	psum_load_wire 		 = Psum_Spad_psum_out;
wire signed [20:0] 	psum_acc_result_wire = psum_load_state ? (psum_load_wire + psum_in) : (psum_load_reg + product_reg);
wire 		[6:0]  	psum_write_idx_wire  = weight_matrix_row_wire + (iact_matrix_col_reg-1) * 'd4; 

wire  iact_zero_col_wire  	= (iact_address_spad_data_out 	== 8'd255 ) ? 1'b1 : 1'b0;
wire  weight_zero_col_wire	= (weight_address_spad_data_out == 7'd127) ? 1'b1 : 1'b0;

wire  Iact_Data_Spad_idx_inc_wire 	= (iact_address_spad_data_out == (iact_data_spad_col_num + 'd1)) ? 1'b1 : 1'b0;
wire  Iact_Data_Spad_read_fin_wire	= (iact_matrix_data_wire == 'd0) & (~iact_data_first_read_reg);

wire  Weight_Data_Spad_read_fin_wire   	= (weight_matrix_data_wire == 'd0); 
wire  Weight_Data_Spad_idx_inc_wire   	= (weight_address_spad_data_out == (weight_data_spad_col_num + 'd1)) | Weight_Data_Spad_read_fin_wire;
wire  Weight_Address_Spad_read_fin_wire = (weight_address_spad_data_out == 'd0) ? 1'b1 : 1'b0;

wire  Psum_Spad_read_valid_wire 	= psum_in_valid & psum_load_state;
wire  Psum_Spad_read_idx_inc_wire 	= psum_out_ready & psum_out_valid;
wire  Psum_Spad_read_fin_wire 		= ((PE_state == READ_IACT_DATA) & Iact_Data_Spad_read_fin_wire)	|
								      ((PE_state == WRITE_BACK) & Iact_Data_Spad_read_fin_wire) 	| 
									  (Psum_Spad_read_idx_inc_wire & psum_read_idx_reg == PSUM_DEPTH);

wire read_weight_zero_col_wire = iact_matrix_row_wire == weight_address_spad_data_out;

// instantiated module connection
assign cal_fin = Iact_Data_Spad_read_fin_wire & (PE_state != IDLE);

assign psum_in_ready 	= psum_out_ready & psum_load_state;
assign psum_out_valid 	= Psum_Spad_psum_out_ready & Psum_Spad_psum_out_valid & Psum_Spad_read_valid_wire;
assign psum_out 		= psum_acc_result_wire;

assign iact_address_write_fin	= iact_address_spad_write_fin;
assign iact_data_write_fin 		= iact_data_spad_write_fin;

assign weight_address_write_fin = weight_address_spad_write_fin;
assign weight_data_write_fin 	= weight_data_spad_write_fin;

assign psum_acc_fin = Psum_Spad_read_fin_wire & psum_load_state;

assign Psum_Spad_psum_in_valid 			= (PE_state == WRITE_BACK) ? 1'b1 : 1'b0;
assign Psum_Spad_psum_in 				= (PE_state == WRITE_BACK) ? psum_acc_result_wire : 21'd0;
assign Psum_Spad_psum_out_ready 		= (PE_state == DO_MAC) | Psum_Spad_read_valid_wire;
assign Psum_Spad_read_idx 				= psum_read_idx_reg;
assign Psum_Spad_write_idx 				= psum_write_idx_wire[4:0];

assign iact_address_spad_data_in_valid 	= iact_address_in_valid;
assign iact_address_spad_data_in 		= iact_address_in;
assign iact_address_spad_write_en 		= load_en;
assign iact_address_spad_idx_inc 		= ((PE_state == READ_IACT_ADDRESS) && iact_zero_col_wire) || 
										  ((PE_state == READ_WEIGHT_ADDRESS) && weight_zero_col_wire && Iact_Data_Spad_idx_inc_wire) || 
										  ((PE_state == WRITE_BACK) && Weight_Data_Spad_idx_inc_wire && Iact_Data_Spad_idx_inc_wire) || 
										  ((PE_state != IDLE) && cal_fin);

assign iact_data_spad_data_in_valid 	= iact_data_in_valid;
assign iact_data_spad_data_in 			= iact_data_in;
assign iact_data_spad_write_en 			= load_en;	
assign Iact_Data_Spad_idx_inc 			= ((PE_state == READ_IACT_ADDRESS) && (~iact_zero_col_wire | ~Iact_Data_Spad_idx_inc_wire) && (~iact_data_first_read_reg)) || 
										  ((PE_state == READ_WEIGHT_ADDRESS) && weight_zero_col_wire && (~Iact_Data_Spad_idx_inc_wire)) || 
										  ((PE_state == WRITE_BACK) && Weight_Data_Spad_idx_inc_wire && (~Iact_Data_Spad_idx_inc_wire)) || 
										  ((PE_state != IDLE) && Iact_Data_Spad_read_fin_wire);

assign weight_address_spad_data_in_valid= weight_address_in_valid;
assign weight_address_spad_data_in 		= weight_address_in;
assign weight_address_spad_write_en 	= load_en;
assign weight_address_spad_read_idx 	= ((PE_state == READ_IACT_DATA) & weight_data_first_read & (~weight_matrix_read_first_col)) ? (iact_matrix_row_wire - 4'd1) : iact_matrix_row_wire;
assign weight_address_spad_idx_inc 		= ((PE_state == DO_MAC) | PE_state == READ_WEIGHT_DATA_1) & weight_zero_col_wire;
assign weight_address_spad_read_idx_en 	= ((PE_state == READ_IACT_DATA) | (PE_state == READ_WEIGHT_ADDRESS)) & weight_data_first_read;

assign weight_data_spad_data_in_valid 	= weight_data_in_valid;
assign weight_data_spad_data_in 		= weight_data_in;
assign weight_data_spad_write_en 		= load_en;
assign weight_data_spad_read_en 		= PE_state == READ_WEIGHT_DATA_1;
assign weight_data_spad_read_idx 		= weight_matrix_read_first_col ? 'd0 : weight_address_spad_data_out;
assign weight_data_spad_read_idx_inc 	= ((PE_state == READ_WEIGHT_ADDRESS) & (~weight_zero_col_wire) & (~weight_data_first_read)) | 
										  ((PE_state == WRITE_BACK) & (~Weight_Data_Spad_idx_inc_wire));
assign weight_data_spad_read_idx_en 	= (PE_state == READ_WEIGHT_ADDRESS) & weight_data_first_read & (~weight_zero_col_wire);


always @(posedge clock) begin
	if (reset) begin
		PE_state <= IDLE;
	end
	else begin
		PE_state <= next_PE_state;
	end
end	

always@(*) begin
	case(PE_state)
		IDLE 				: next_PE_state = mac_en ? READ_IACT_ADDRESS : IDLE;
		READ_IACT_ADDRESS 	: next_PE_state = Iact_Data_Spad_idx_inc_wire & iact_zero_col_wire ? READ_IACT_ADDRESS : READ_IACT_DATA;
		READ_IACT_DATA 		: next_PE_state = Iact_Data_Spad_read_fin_wire ? IDLE : READ_WEIGHT_ADDRESS;
		READ_WEIGHT_ADDRESS : next_PE_state = weight_zero_col_wire ? (Iact_Data_Spad_idx_inc_wire ? READ_IACT_ADDRESS : READ_IACT_DATA) : READ_WEIGHT_DATA_1;
		READ_WEIGHT_DATA_1 	: next_PE_state = READ_WEIGHT_DATA_2;
		READ_WEIGHT_DATA_2 	: next_PE_state = DO_MAC;
		DO_MAC 				: next_PE_state = WRITE_BACK;
		WRITE_BACK 	        : next_PE_state = Iact_Data_Spad_read_fin_wire ? IDLE : ((Weight_Data_Spad_idx_inc_wire | Weight_Address_Spad_read_fin_wire) ? ((Iact_Data_Spad_idx_inc_wire | Weight_Address_Spad_read_fin_wire) ? READ_IACT_ADDRESS : READ_IACT_DATA) : READ_WEIGHT_DATA_1);
		default				: next_PE_state = IDLE;
	endcase
end


always @(posedge clock) begin
    if (reset) begin
        iact_zero_col_reg <= 1'b0;
    end 
    else begin
        if (PE_state == READ_IACT_ADDRESS) begin
            iact_zero_col_reg <= iact_zero_col_wire | iact_zero_col_reg;
        end
        else if (PE_state == READ_WEIGHT_ADDRESS) begin
            if(weight_zero_col_wire && Iact_Data_Spad_idx_inc_wire && iact_zero_col_reg) begin
				iact_zero_col_reg <= 1'b0;
			end
        end
        else if (PE_state == WRITE_BACK) begin
            if ((!Iact_Data_Spad_read_fin_wire) && (Weight_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire) && (Iact_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire) && iact_zero_col_reg) begin
                iact_zero_col_reg <= 1'b0;
            end
        end
		else begin
			iact_zero_col_reg <= iact_zero_col_reg;
		end
    end
end


always @(posedge clock) begin
	if (reset) begin
		iact_data_read_en_reg <= 1'h0;
	end 
	else begin
		case(PE_state)
			IDLE                : iact_data_read_en_reg <= mac_en ? 1'b0 : iact_data_read_en_reg;
			READ_IACT_ADDRESS   : iact_data_read_en_reg <= iact_zero_col_wire ? 1'b0 : 1'b1;
			READ_IACT_DATA      : iact_data_read_en_reg <= Iact_Data_Spad_read_fin_wire & iact_data_read_en_reg;
			READ_WEIGHT_ADDRESS : iact_data_read_en_reg <= weight_zero_col_wire ? (Iact_Data_Spad_idx_inc_wire ? 1'b0 : 1'b1) : iact_data_read_en_reg;
			READ_WEIGHT_DATA_2  : iact_data_read_en_reg <= 1'b0;
			WRITE_BACK          : iact_data_read_en_reg <= (Weight_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire) ? (Iact_Data_Spad_idx_inc_wire ? 1'b0 : 1'b1) : iact_data_read_en_reg;
		endcase
	end
end	

always @(posedge clock) begin
	if (reset) begin
		iact_zero_col_num_reg <= 'd0;
	end 
	else begin
		if (PE_state == READ_IACT_ADDRESS) begin
			if (iact_zero_col_wire) begin
				iact_zero_col_num_reg <= iact_zero_col_num_reg + 'd1;
			end
		end 
		else if (PE_state == READ_WEIGHT_ADDRESS && weight_zero_col_wire && Iact_Data_Spad_idx_inc_wire && iact_zero_col_reg) begin
			iact_zero_col_num_reg <= 'd0;
		end
		else if (PE_state == WRITE_BACK) begin
			if (!Iact_Data_Spad_read_fin_wire && (Weight_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire) && (Iact_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire) && iact_zero_col_reg) begin
				iact_zero_col_num_reg <= 'd0;
			end
		end
	end
end

reg iact_matrix_inc_reg;
always@(posedge clock) begin
	if(reset) begin
		iact_matrix_inc_reg <= 1'b0;
	end
	else if(PE_state == READ_IACT_ADDRESS)begin
		iact_matrix_inc_reg <= iact_zero_col_wire;
	end
end


always @(posedge clock) begin
	if (reset) begin
		iact_matrix_col_reg <= 'd0;
	end
	else if(psum_enq_en)begin
		iact_matrix_col_reg <= 'd0;
	end
	else if(PE_state == READ_IACT_ADDRESS)begin
		iact_matrix_col_reg <= iact_matrix_col_reg + 'd1 + iact_matrix_inc_reg;
	end
end

always @(posedge clock) begin
	if (reset) begin
		iact_data_first_read_reg <= 1'b1;
	end 
	else begin
		if (PE_state == READ_IACT_DATA || PE_state == WRITE_BACK) begin
			iact_data_first_read_reg <= Iact_Data_Spad_read_fin_wire || iact_data_first_read_reg;
		end
		else if (PE_state == READ_WEIGHT_ADDRESS) begin
			iact_data_first_read_reg <= 1'b0;
		end
	end
end	
	
always @(posedge clock) begin
	if (reset) begin
		weight_data_first_read <= 1'b1;
	end 
	else begin
	    if (PE_state == IDLE) begin
			weight_data_first_read <= mac_en || weight_data_first_read;
		end
		else if (PE_state == READ_WEIGHT_ADDRESS) begin
			weight_data_first_read <= weight_zero_col_wire || weight_data_first_read;
		end
		else if (PE_state == WRITE_BACK && !Iact_Data_Spad_read_fin_wire) begin
			weight_data_first_read <= Weight_Data_Spad_idx_inc_wire || Weight_Address_Spad_read_fin_wire;
		end
	end
end
	
always @(posedge clock) begin	
	if (reset) begin
		product_reg <= 21'sd0;
	end 
	else begin
		if (PE_state == DO_MAC) begin
			product_reg <= weight_matrix_data_wire * iact_matrix_data_wire;
		end
	end
end

always @(posedge clock) begin
	if (reset) begin
		psum_load_reg <= 21'd0;
	end 
	else begin
		psum_load_reg <= psum_load_wire;
	end
end

always @(posedge clock) begin
	if (reset) begin
		psum_load_state <= 1'b0; 
	end 
	else if (psum_acc_fin) begin
		psum_load_state <= 1'b0;
	end 
	else begin
		psum_load_state <= psum_enq_en | psum_load_state;
	end
end
	
always @(posedge clock) begin	
	if (reset) begin 
		psum_read_idx_reg <= 5'd0; 
	end 
	else if (PE_state == READ_WEIGHT_DATA_2) begin 
		psum_read_idx_reg <= Psum_Spad_write_idx;
	end 
	else if (Psum_Spad_read_fin_wire) begin 
		psum_read_idx_reg <= 5'd0;
	end 
	else if (Psum_Spad_read_idx_inc_wire) begin 
		psum_read_idx_reg <= psum_read_idx_reg + 5'd1;
	end
end

endmodule
