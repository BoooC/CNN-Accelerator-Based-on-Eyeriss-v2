// ====================================================================================================== //
// This module is Cluster_Group_Controller.
// Cluster_Group_Controller(CG_controller) contains state FSM to control operation stage.
// 
// There are 5 states 		: CG_IDLE, CG_LOAD_GLB, CG_LOAD_PE, CG_PE_CAL,CG_READ_PSUM.
// For CG_IDLE 		state 	: wait cg_en signal to active CG.
// For CG_LOAD_GLB 	state 	: iact data and address are stored into GLB.
// For CG_LOAD_PE 	state 	: then system load iact from GLB into PE and load weight from off-chip into PE .
// For CG_PE_CAL 	state 	: when both iact and weight are written finish, then all PEs will begin to perform GEMM.
// For CG_READ_PSUM state 	: the system will accumulate psum as all PEs calculate finish(synchronize), 
// 							  psum will be read from GLB and accumulated with the psum in PE and then write back to GLB.
// 
// ====================================================================================================== //

module Cluster_Group_Controller (
	input       clock,
	input       reset,
	
	output      GLB_psum_0_write_en,
	output      GLB_psum_1_write_en,
	output      GLB_psum_2_write_en,
	
	input       GLB_psum_0_write_done,
	input       GLB_psum_1_write_done,
	input       GLB_psum_2_write_done,
	
	output      GLB_psum_0_read_en,
	output      GLB_psum_1_read_en,
	output      GLB_psum_2_read_en,
	
	output      GLB_iact_0_0_write_en,
	output      GLB_iact_0_1_write_en,
	output      GLB_iact_0_2_write_en,
	output      GLB_iact_1_0_write_en,
	output      GLB_iact_1_1_write_en,
	output      GLB_iact_1_2_write_en,
	output      GLB_iact_2_0_write_en,
	output      GLB_iact_2_1_write_en,
	output      GLB_iact_2_2_write_en,
	
	input       GLB_iact_0_0_write_done,
	input       GLB_iact_0_1_write_done,
	input       GLB_iact_0_2_write_done,
	input       GLB_iact_1_0_write_done,
	input       GLB_iact_1_1_write_done,
	input       GLB_iact_1_2_write_done,
	input       GLB_iact_2_0_write_done,
	input       GLB_iact_2_1_write_done,
	input       GLB_iact_2_2_write_done,
	
	output      GLB_iact_0_0_read_en,
	output      GLB_iact_0_1_read_en,
	output      GLB_iact_0_2_read_en,
	output      GLB_iact_1_0_read_en,
	output      GLB_iact_1_1_read_en,
	output      GLB_iact_1_2_read_en,
	output      GLB_iact_2_0_read_en,
	output      GLB_iact_2_1_read_en,
	output      GLB_iact_2_2_read_en,
	
	input       GLB_iact_0_0_read_done,
	input       GLB_iact_0_1_read_done,
	input       GLB_iact_0_2_read_done,
	input       GLB_iact_1_0_read_done,
	input       GLB_iact_1_1_read_done,
	input       GLB_iact_1_2_read_done,
	input       GLB_iact_2_0_read_done,
	input       GLB_iact_2_1_read_done,
	input       GLB_iact_2_2_read_done,
	
	output      GLB_load_en,
	output      PE_load_en,
	output      psum_load_en,
	
	input		src_GLB_load_fin,		// for other cluster cast
	
	input       psum_acc_en,
	
	output      psum_add,
	input       read_psum_en,
	input       cg_en,
	input		PE_all_write_fin,
	output      cal_fin,
	
	output		idle_wire,
	
	input		psum_acc_fin
);

// ====================================================================	//
// 						 		Parameters  							//
// ====================================================================	//
localparam CG_IDLE		= 3'd0;	// wait cg_en signal
localparam CG_LOAD_GLB 	= 3'd1; // load iact into GLB Cluster(iact SRAM)
localparam CG_LOAD_PE	= 3'd2; // load iact from GLB Cluster(iact SRAM),load weight from DRAM
localparam CG_PE_CAL	= 3'd3; // PE perform GEMM and 5-stage pipeline CSC decoding
localparam CG_READ_PSUM	= 3'd4; // PE read psum into the tails of PE Array to accumulate them and transmitted to GLB psum SRAM


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg  GLB_iact_0_0_write_fin_reg;
reg  GLB_iact_0_1_write_fin_reg;
reg  GLB_iact_0_2_write_fin_reg;
reg  GLB_iact_1_0_write_fin_reg;
reg  GLB_iact_1_1_write_fin_reg;
reg  GLB_iact_1_2_write_fin_reg;
reg  GLB_iact_2_0_write_fin_reg;
reg  GLB_iact_2_1_write_fin_reg;
reg  GLB_iact_2_2_write_fin_reg;

reg  GLB_iact_0_0_read_fin_reg; 
reg  GLB_iact_0_1_read_fin_reg; 
reg  GLB_iact_0_2_read_fin_reg; 
reg  GLB_iact_1_0_read_fin_reg; 
reg  GLB_iact_1_1_read_fin_reg; 
reg  GLB_iact_1_2_read_fin_reg; 
reg  GLB_iact_2_0_read_fin_reg; 
reg  GLB_iact_2_1_read_fin_reg; 
reg  GLB_iact_2_2_read_fin_reg; 

reg  GLB_psum_0_write_fin_reg; 
reg  GLB_psum_1_write_fin_reg; 
reg  GLB_psum_2_write_fin_reg; 

// FSM signals
reg [2:0] CG_state, next_CG_state; 

// output
reg  GLB_iact_write_en_reg;
reg  psum_load_en_reg;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire CG_IDLE_wire 	 		= CG_state == CG_IDLE;
wire CG_LOAD_GLB_wire 		= CG_state == CG_LOAD_GLB;
wire CG_LOAD_PE_wire 	 	= CG_state == CG_LOAD_PE;
wire CG_PE_CAL_wire 	 	= CG_state == CG_PE_CAL;
wire CG_READ_PSUM_wire 		= CG_state == CG_READ_PSUM;

wire load_GLB_fin			= GLB_iact_all_write_fin | src_GLB_load_fin;
wire GLB_iact_all_write_fin	= GLB_iact_0_0_write_fin_reg & GLB_iact_0_1_write_fin_reg & GLB_iact_0_2_write_fin_reg & 
							  GLB_iact_1_0_write_fin_reg & GLB_iact_1_1_write_fin_reg & GLB_iact_1_2_write_fin_reg & 
							  GLB_iact_2_0_write_fin_reg & GLB_iact_2_1_write_fin_reg & GLB_iact_2_2_write_fin_reg; 
								  
wire GLB_psum_all_load_fin 	= GLB_psum_0_write_fin_reg & GLB_psum_1_write_fin_reg & GLB_psum_2_write_fin_reg; 


// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign GLB_psum_0_write_en 		= CG_READ_PSUM_wire & ~GLB_psum_0_write_fin_reg;
assign GLB_psum_1_write_en 		= CG_READ_PSUM_wire & ~GLB_psum_1_write_fin_reg;
assign GLB_psum_2_write_en 		= CG_READ_PSUM_wire & ~GLB_psum_2_write_fin_reg;

assign GLB_psum_0_read_en 		= (CG_READ_PSUM_wire & ~GLB_psum_0_write_fin_reg) | read_psum_en;
assign GLB_psum_1_read_en 		= (CG_READ_PSUM_wire & ~GLB_psum_1_write_fin_reg) | read_psum_en;
assign GLB_psum_2_read_en 		= (CG_READ_PSUM_wire & ~GLB_psum_2_write_fin_reg) | read_psum_en;

assign GLB_iact_0_0_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_0_1_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_0_2_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_1_0_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_1_1_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_1_2_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_2_0_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_2_1_write_en	= GLB_iact_write_en_reg;
assign GLB_iact_2_2_write_en	= GLB_iact_write_en_reg;

assign GLB_iact_0_0_read_en		= CG_LOAD_PE_wire & ~GLB_iact_0_0_read_fin_reg;
assign GLB_iact_0_1_read_en		= CG_LOAD_PE_wire & ~GLB_iact_0_1_read_fin_reg;
assign GLB_iact_0_2_read_en		= CG_LOAD_PE_wire & ~GLB_iact_0_2_read_fin_reg;
assign GLB_iact_1_0_read_en		= CG_LOAD_PE_wire & ~GLB_iact_1_0_read_fin_reg;
assign GLB_iact_1_1_read_en		= CG_LOAD_PE_wire & ~GLB_iact_1_1_read_fin_reg;
assign GLB_iact_1_2_read_en		= CG_LOAD_PE_wire & ~GLB_iact_1_2_read_fin_reg;
assign GLB_iact_2_0_read_en		= CG_LOAD_PE_wire & ~GLB_iact_2_0_read_fin_reg;
assign GLB_iact_2_1_read_en		= CG_LOAD_PE_wire & ~GLB_iact_2_1_read_fin_reg;
assign GLB_iact_2_2_read_en		= CG_LOAD_PE_wire & ~GLB_iact_2_2_read_fin_reg;

assign idle_wire 	= CG_IDLE_wire;
assign GLB_load_en 	= CG_LOAD_GLB_wire;
assign PE_load_en 	= CG_LOAD_PE_wire;
assign cal_fin 		= CG_READ_PSUM_wire; 
assign psum_add 	= CG_READ_PSUM_wire;

assign psum_load_en = psum_load_en_reg;


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
// FSM
always@(posedge clock) begin
	if(reset) begin
		CG_state <= CG_IDLE;
	end
	else begin
		CG_state <= next_CG_state;
	end
end

// next state logic
always@(*) begin
	case(CG_state)
		CG_IDLE      : next_CG_state = cg_en 			? CG_LOAD_GLB 	: CG_IDLE; 
		CG_LOAD_GLB  : next_CG_state = load_GLB_fin 	? CG_LOAD_PE 	: CG_LOAD_GLB; 
		CG_LOAD_PE   : next_CG_state = PE_all_write_fin ? CG_PE_CAL 	: CG_LOAD_PE;
		CG_PE_CAL    : next_CG_state = psum_acc_en 		? CG_READ_PSUM 	: CG_PE_CAL; 
		CG_READ_PSUM : next_CG_state = psum_acc_fin 	? CG_IDLE 		: CG_READ_PSUM;
		default      : next_CG_state = CG_IDLE;
	endcase      
end


// iact write finish registers
always@(posedge clock) begin
	if(reset) begin
		GLB_iact_0_0_write_fin_reg <= 1'b0;
		GLB_iact_0_1_write_fin_reg <= 1'b0;
		GLB_iact_0_2_write_fin_reg <= 1'd0;
		GLB_iact_1_0_write_fin_reg <= 1'b0;
		GLB_iact_1_1_write_fin_reg <= 1'b0;
		GLB_iact_1_2_write_fin_reg <= 1'd0;
		GLB_iact_2_0_write_fin_reg <= 1'b0;
		GLB_iact_2_1_write_fin_reg <= 1'b0;
		GLB_iact_2_2_write_fin_reg <= 1'd0;
	end 
	else if(GLB_iact_all_write_fin) begin
		GLB_iact_0_0_write_fin_reg <= 1'b0;
		GLB_iact_0_1_write_fin_reg <= 1'b0;
		GLB_iact_0_2_write_fin_reg <= 1'd0;
		GLB_iact_1_0_write_fin_reg <= 1'b0;
		GLB_iact_1_1_write_fin_reg <= 1'b0;
		GLB_iact_1_2_write_fin_reg <= 1'd0;
		GLB_iact_2_0_write_fin_reg <= 1'b0;
		GLB_iact_2_1_write_fin_reg <= 1'b0;
		GLB_iact_2_2_write_fin_reg <= 1'd0;
	end 
	else begin
		GLB_iact_0_0_write_fin_reg <= GLB_iact_0_0_write_done | GLB_iact_0_0_write_fin_reg;
		GLB_iact_0_1_write_fin_reg <= GLB_iact_0_1_write_done | GLB_iact_0_1_write_fin_reg;
		GLB_iact_0_2_write_fin_reg <= GLB_iact_0_2_write_done | GLB_iact_0_2_write_fin_reg;
		GLB_iact_1_0_write_fin_reg <= GLB_iact_1_0_write_done | GLB_iact_1_0_write_fin_reg;
		GLB_iact_1_1_write_fin_reg <= GLB_iact_1_1_write_done | GLB_iact_1_1_write_fin_reg;
		GLB_iact_1_2_write_fin_reg <= GLB_iact_1_2_write_done | GLB_iact_1_2_write_fin_reg;
		GLB_iact_2_0_write_fin_reg <= GLB_iact_2_0_write_done | GLB_iact_2_0_write_fin_reg;
		GLB_iact_2_1_write_fin_reg <= GLB_iact_2_1_write_done | GLB_iact_2_1_write_fin_reg;
		GLB_iact_2_2_write_fin_reg <= GLB_iact_2_2_write_done | GLB_iact_2_2_write_fin_reg;
	end
end


// iact read finish registers
always @(posedge clock) begin
	if (reset) begin
		GLB_iact_0_0_read_fin_reg <= 1'b0;
		GLB_iact_0_1_read_fin_reg <= 1'b0;
		GLB_iact_0_2_read_fin_reg <= 1'b0;
		GLB_iact_1_0_read_fin_reg <= 1'b0;
		GLB_iact_1_1_read_fin_reg <= 1'b0;
		GLB_iact_1_2_read_fin_reg <= 1'b0;
		GLB_iact_2_0_read_fin_reg <= 1'b0;
		GLB_iact_2_1_read_fin_reg <= 1'b0;
		GLB_iact_2_2_read_fin_reg <= 1'b0;
	end 
	else if (PE_all_write_fin) begin
		GLB_iact_0_0_read_fin_reg <= 1'b0;
		GLB_iact_0_1_read_fin_reg <= 1'b0;
		GLB_iact_0_2_read_fin_reg <= 1'b0;
		GLB_iact_1_0_read_fin_reg <= 1'b0;
		GLB_iact_1_1_read_fin_reg <= 1'b0;
		GLB_iact_1_2_read_fin_reg <= 1'b0;
		GLB_iact_2_0_read_fin_reg <= 1'b0;
		GLB_iact_2_1_read_fin_reg <= 1'b0;
		GLB_iact_2_2_read_fin_reg <= 1'b0;
	end 
	else begin
		GLB_iact_0_0_read_fin_reg <= GLB_iact_0_0_read_done | GLB_iact_0_0_read_fin_reg;
		GLB_iact_0_1_read_fin_reg <= GLB_iact_0_1_read_done | GLB_iact_0_1_read_fin_reg;
		GLB_iact_0_2_read_fin_reg <= GLB_iact_0_2_read_done | GLB_iact_0_2_read_fin_reg;
		GLB_iact_1_0_read_fin_reg <= GLB_iact_1_0_read_done | GLB_iact_1_0_read_fin_reg;
		GLB_iact_1_1_read_fin_reg <= GLB_iact_1_1_read_done | GLB_iact_1_1_read_fin_reg;
		GLB_iact_1_2_read_fin_reg <= GLB_iact_1_2_read_done | GLB_iact_1_2_read_fin_reg;
		GLB_iact_2_0_read_fin_reg <= GLB_iact_2_0_read_done | GLB_iact_2_0_read_fin_reg;
		GLB_iact_2_1_read_fin_reg <= GLB_iact_2_1_read_done | GLB_iact_2_1_read_fin_reg;
		GLB_iact_2_2_read_fin_reg <= GLB_iact_2_2_read_done | GLB_iact_2_2_read_fin_reg;
	end
end


// psum psum write fin registers
always @(posedge clock) begin
	if (reset) begin
		GLB_psum_0_write_fin_reg <= 1'b0;
		GLB_psum_1_write_fin_reg <= 1'b0;
		GLB_psum_2_write_fin_reg <= 1'b0;
	end 
	else if (GLB_psum_all_load_fin) begin
		GLB_psum_0_write_fin_reg <= 1'b0;
		GLB_psum_1_write_fin_reg <= 1'b0;
		GLB_psum_2_write_fin_reg <= 1'b0;
	end 
	else begin
		GLB_psum_0_write_fin_reg <= GLB_psum_0_write_done | GLB_psum_0_write_fin_reg;
		GLB_psum_1_write_fin_reg <= GLB_psum_1_write_done | GLB_psum_1_write_fin_reg;
		GLB_psum_2_write_fin_reg <= GLB_psum_2_write_done | GLB_psum_2_write_fin_reg;
	end
end


// output
always@(posedge clock) begin
	if(reset) begin 
		GLB_iact_write_en_reg <= 1'b0; 
	end 
	else begin
		GLB_iact_write_en_reg <= cg_en & CG_IDLE_wire;
	end
end


always@(posedge clock) begin
	if(reset) begin
		psum_load_en_reg <= 'd0;
	end
	else begin
		psum_load_en_reg <= psum_acc_en & CG_PE_CAL_wire; 
	end
end

endmodule
