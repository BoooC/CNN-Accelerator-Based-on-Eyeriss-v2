// ====================================================================================================== //
// This module is the controller for PE module in Top-level.
// PE controller contains 3 state, IDLE, LOAD, CAL
// This module is the continuation point of form top signals and output control signals.
// ====================================================================================================== //


module Processing_Element_Controller (
	input   clock,
	input   reset,
	
	output  mac_en,
	output  from_top_psum_enq_en,
	output  from_top_do_load_en,
	input   from_top_cal_fin,
	
	input   top_psum_enq_en,
	input   top_do_load_en,
	output  top_cal_fin,
	input   top_write_fin
);

// ================================================	//
// 					 Parameters  					//
// ================================================	//
localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam CAL  = 2'b10;


// ================================================	//
// 				 Registers & Wires  				//
// ================================================	//
reg [1:0] PE_state, next_PE_state;


// ================================================	//
// 					 Combination  					//
// ================================================	//
assign mac_en 				= (PE_state == CAL) ? 1'b1 : 1'b0;
assign from_top_psum_enq_en = top_psum_enq_en;
assign from_top_do_load_en  = top_do_load_en;
assign top_cal_fin 			= from_top_cal_fin & (PE_state == CAL);

// next state logic
always@(*) begin
	case(PE_state)
		IDLE    : next_PE_state = top_do_load_en 	? LOAD : IDLE;
		LOAD    : next_PE_state = top_write_fin 	? CAL  : LOAD;
		CAL     : next_PE_state = from_top_cal_fin 	? IDLE : CAL;
		default : next_PE_state = IDLE;
	endcase
end


// ================================================	//
// 					 Sequential  					//
// ================================================	//
// FSM
always@(posedge clock) begin
    if(reset) begin
		PE_state <= IDLE;
	end
	else begin
		PE_state <= next_PE_state;
	end
end


endmodule