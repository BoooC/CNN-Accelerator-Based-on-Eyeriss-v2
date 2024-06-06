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

module Cluster_Group_Controller
(
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


reg  GLB_iact_0_0_write_fin;
reg  GLB_iact_0_1_write_fin;
reg  GLB_iact_0_2_write_fin;
reg  GLB_iact_1_0_write_fin;
reg  GLB_iact_1_1_write_fin;
reg  GLB_iact_1_2_write_fin;
reg  GLB_iact_2_0_write_fin;
reg  GLB_iact_2_1_write_fin;
reg  GLB_iact_2_2_write_fin;

reg  GLB_iact_0_0_read_fin; 
reg  GLB_iact_0_1_read_fin; 
reg  GLB_iact_0_2_read_fin; 
reg  GLB_iact_1_0_read_fin; 
reg  GLB_iact_1_1_read_fin; 
reg  GLB_iact_1_2_read_fin; 
reg  GLB_iact_2_0_read_fin; 
reg  GLB_iact_2_1_read_fin; 
reg  GLB_iact_2_2_read_fin; 

reg  GLB_psum_0_write_fin; 
reg  GLB_psum_1_write_fin; 
reg  GLB_psum_2_write_fin; 

// true when inAct data have loaded into GLB from off chip
wire GLB_iact_all_write_fin = 	GLB_iact_0_0_write_fin & GLB_iact_0_1_write_fin & GLB_iact_0_2_write_fin & 
								GLB_iact_1_0_write_fin & GLB_iact_1_1_write_fin & GLB_iact_1_2_write_fin & 
								GLB_iact_2_0_write_fin & GLB_iact_2_1_write_fin & GLB_iact_2_2_write_fin; 
								  
wire GLB_iact_all_read_fin 	= 	GLB_iact_0_0_read_fin & GLB_iact_0_1_read_fin & GLB_iact_0_2_read_fin & 
								GLB_iact_1_0_read_fin & GLB_iact_1_1_read_fin & GLB_iact_1_2_read_fin & 
								GLB_iact_2_0_read_fin & GLB_iact_2_1_read_fin & GLB_iact_2_2_read_fin; 
								  
// true when pSum data have loaded into GLB from PECluster
wire  GLB_psum_all_load_fin 	= GLB_psum_0_write_fin & GLB_psum_1_write_fin & GLB_psum_2_write_fin; 
// PE ready to calculate 
wire  iact_load_PE_fin 			= GLB_iact_all_read_fin; 

localparam CG_IDLE		= 3'd0;
localparam CG_LOAD_GLB 	= 3'd1; // load inAct and PSum from outside CG into GLBCluster
localparam CG_LOAD_PE	= 3'd2; // load inAct, weight from outside PECluster (from GLB and outside CG)
localparam CG_PE_CAL	= 3'd3; // PE doing computations
localparam CG_READ_PSUM	= 3'd4; // PE read PSum into the tails of PEArray to accumulate them and get out put PSum

reg [2:0] CG_state, next_CG_state; 

// output
reg  GLB_iact_0_0_write_en_reg; 
reg  GLB_iact_0_1_write_en_reg; 
reg  GLB_iact_0_2_write_en_reg; 
reg  GLB_iact_1_0_write_en_reg; 
reg  GLB_iact_1_1_write_en_reg; 
reg  GLB_iact_1_2_write_en_reg; 
reg  GLB_iact_2_0_write_en_reg; 
reg  GLB_iact_2_1_write_en_reg; 
reg  GLB_iact_2_2_write_en_reg; 
reg  psum_load_en_reg;


wire  load_PE_wire 	 = (CG_state == CG_LOAD_PE  ) ? 1'b1 : 1'b0;
wire  read_psum_wire = (CG_state == CG_READ_PSUM) ? 1'b1 : 1'b0;

assign idle_wire = CG_state == CG_IDLE;

assign GLB_psum_0_write_en = read_psum_wire & ~GLB_psum_0_write_fin;
assign GLB_psum_1_write_en = read_psum_wire & ~GLB_psum_1_write_fin;
assign GLB_psum_2_write_en = read_psum_wire & ~GLB_psum_2_write_fin;

// PSum will be read out from GLB to PE for accumulation or from GLB to outside as a result
assign GLB_psum_0_read_en = (read_psum_wire & ~GLB_psum_0_write_fin) | read_psum_en;
assign GLB_psum_1_read_en = (read_psum_wire & ~GLB_psum_1_write_fin) | read_psum_en;
assign GLB_psum_2_read_en = (read_psum_wire & ~GLB_psum_2_write_fin) | read_psum_en;

assign GLB_iact_0_0_write_en = GLB_iact_0_0_write_en_reg;
assign GLB_iact_0_1_write_en = GLB_iact_0_1_write_en_reg;
assign GLB_iact_0_2_write_en = GLB_iact_0_2_write_en_reg;
assign GLB_iact_1_0_write_en = GLB_iact_1_0_write_en_reg;
assign GLB_iact_1_1_write_en = GLB_iact_1_1_write_en_reg;
assign GLB_iact_1_2_write_en = GLB_iact_1_2_write_en_reg;
assign GLB_iact_2_0_write_en = GLB_iact_2_0_write_en_reg;
assign GLB_iact_2_1_write_en = GLB_iact_2_1_write_en_reg;
assign GLB_iact_2_2_write_en = GLB_iact_2_2_write_en_reg;

// each GLB inAct's read enable will be true until the corresponding PEs finish reading
assign GLB_iact_0_0_read_en = load_PE_wire & ~GLB_iact_0_0_read_fin;
assign GLB_iact_0_1_read_en = load_PE_wire & ~GLB_iact_0_1_read_fin;
assign GLB_iact_0_2_read_en = load_PE_wire & ~GLB_iact_0_2_read_fin;
assign GLB_iact_1_0_read_en = load_PE_wire & ~GLB_iact_1_0_read_fin;
assign GLB_iact_1_1_read_en = load_PE_wire & ~GLB_iact_1_1_read_fin;
assign GLB_iact_1_2_read_en = load_PE_wire & ~GLB_iact_1_2_read_fin;
assign GLB_iact_2_0_read_en = load_PE_wire & ~GLB_iact_2_0_read_fin;
assign GLB_iact_2_1_read_en = load_PE_wire & ~GLB_iact_2_1_read_fin;
assign GLB_iact_2_2_read_en = load_PE_wire & ~GLB_iact_2_2_read_fin;

assign PE_load_en 	= CG_state == CG_LOAD_PE;
assign psum_add 	= CG_state == CG_READ_PSUM;
assign GLB_load_en 	= CG_state == CG_LOAD_GLB;

assign psum_load_en = psum_load_en_reg;
assign cal_fin 		= read_psum_wire; // current layer has finished all the computations

// state control
always@(posedge clock) begin
	if(reset) begin
		CG_state <= CG_IDLE;
	end
	else begin
		CG_state <= next_CG_state;
	end
end

always@(*) begin
	case(CG_state)
		// when doEn Cluster_Group
		CG_IDLE      : next_CG_state = cg_en ? CG_LOAD_GLB : CG_IDLE; 
		
		// when inAct data and address have stored into GLB, then begin load data into PE
		CG_LOAD_GLB  : next_CG_state = GLB_iact_all_write_fin | src_GLB_load_fin ? CG_LOAD_PE : CG_LOAD_GLB; 
		
		// when inAct write finish, then all PEs have finish read inAct
		CG_LOAD_PE   : next_CG_state = PE_all_write_fin ? CG_PE_CAL : CG_LOAD_PE;
		
		// all_cal_fin : every time s2Inc, that means cal finish
		// otherwise : or we need to load new InAct and Weight BUT PSum
		CG_PE_CAL    : next_CG_state = psum_acc_en ? CG_READ_PSUM : CG_PE_CAL; 
		
		// GLB_psum_all_load_fin : after GLB, read out all PSum from the head of each column
		CG_READ_PSUM : next_CG_state = psum_acc_fin ? CG_IDLE : CG_READ_PSUM;
		default      : next_CG_state = CG_IDLE;
	endcase      
end


// write finish control
always @(posedge clock) begin
	if (reset) begin
		GLB_iact_0_0_write_fin <= 1'b0;
		GLB_iact_0_1_write_fin <= 1'b0;
		GLB_iact_0_2_write_fin <= 1'd0;
		GLB_iact_1_0_write_fin <= 1'b0;
		GLB_iact_1_1_write_fin <= 1'b0;
		GLB_iact_1_2_write_fin <= 1'd0;
		GLB_iact_2_0_write_fin <= 1'b0;
		GLB_iact_2_1_write_fin <= 1'b0;
		GLB_iact_2_2_write_fin <= 1'd0;
	end 
	else if (GLB_iact_all_write_fin) begin
		GLB_iact_0_0_write_fin <= 1'b0;
		GLB_iact_0_1_write_fin <= 1'b0;
		GLB_iact_0_2_write_fin <= 1'd0;
		GLB_iact_1_0_write_fin <= 1'b0;
		GLB_iact_1_1_write_fin <= 1'b0;
		GLB_iact_1_2_write_fin <= 1'd0;
		GLB_iact_2_0_write_fin <= 1'b0;
		GLB_iact_2_1_write_fin <= 1'b0;
		GLB_iact_2_2_write_fin <= 1'd0;
	end 
	else begin
		GLB_iact_0_0_write_fin <= GLB_iact_0_0_write_done | GLB_iact_0_0_write_fin;
		GLB_iact_0_1_write_fin <= GLB_iact_0_1_write_done | GLB_iact_0_1_write_fin;
		GLB_iact_0_2_write_fin <= GLB_iact_0_2_write_done | GLB_iact_0_2_write_fin;
		GLB_iact_1_0_write_fin <= GLB_iact_1_0_write_done | GLB_iact_1_0_write_fin;
		GLB_iact_1_1_write_fin <= GLB_iact_1_1_write_done | GLB_iact_1_1_write_fin;
		GLB_iact_1_2_write_fin <= GLB_iact_1_2_write_done | GLB_iact_1_2_write_fin;
		GLB_iact_2_0_write_fin <= GLB_iact_2_0_write_done | GLB_iact_2_0_write_fin;
		GLB_iact_2_1_write_fin <= GLB_iact_2_1_write_done | GLB_iact_2_1_write_fin;
		GLB_iact_2_2_write_fin <= GLB_iact_2_2_write_done | GLB_iact_2_2_write_fin;
	end
end




always @(posedge clock) begin
	if (reset) begin
		GLB_iact_0_0_read_fin <= 1'b0;
		GLB_iact_0_1_read_fin <= 1'b0;
		GLB_iact_0_2_read_fin <= 1'b0;
		GLB_iact_1_0_read_fin <= 1'b0;
		GLB_iact_1_1_read_fin <= 1'b0;
		GLB_iact_1_2_read_fin <= 1'b0;
		GLB_iact_2_0_read_fin <= 1'b0;
		GLB_iact_2_1_read_fin <= 1'b0;
		GLB_iact_2_2_read_fin <= 1'b0;
	end 
	else if (PE_all_write_fin) begin
		GLB_iact_0_0_read_fin <= 1'b0;
		GLB_iact_0_1_read_fin <= 1'b0;
		GLB_iact_0_2_read_fin <= 1'b0;
		GLB_iact_1_0_read_fin <= 1'b0;
		GLB_iact_1_1_read_fin <= 1'b0;
		GLB_iact_1_2_read_fin <= 1'b0;
		GLB_iact_2_0_read_fin <= 1'b0;
		GLB_iact_2_1_read_fin <= 1'b0;
		GLB_iact_2_2_read_fin <= 1'b0;
	end 
	else begin
		GLB_iact_0_0_read_fin <= GLB_iact_0_0_read_done | GLB_iact_0_0_read_fin;
		GLB_iact_0_1_read_fin <= GLB_iact_0_1_read_done | GLB_iact_0_1_read_fin;
		GLB_iact_0_2_read_fin <= GLB_iact_0_2_read_done | GLB_iact_0_2_read_fin;
		GLB_iact_1_0_read_fin <= GLB_iact_1_0_read_done | GLB_iact_1_0_read_fin;
		GLB_iact_1_1_read_fin <= GLB_iact_1_1_read_done | GLB_iact_1_1_read_fin;
		GLB_iact_1_2_read_fin <= GLB_iact_1_2_read_done | GLB_iact_1_2_read_fin;
		GLB_iact_2_0_read_fin <= GLB_iact_2_0_read_done | GLB_iact_2_0_read_fin;
		GLB_iact_2_1_read_fin <= GLB_iact_2_1_read_done | GLB_iact_2_1_read_fin;
		GLB_iact_2_2_read_fin <= GLB_iact_2_2_read_done | GLB_iact_2_2_read_fin;
	end
end


always @(posedge clock) begin
	if (reset) begin
		GLB_psum_0_write_fin <= 1'b0;
	end 
	else if (GLB_psum_all_load_fin) begin
		GLB_psum_0_write_fin <= 1'b0;
	end 
	else begin
		GLB_psum_0_write_fin <= GLB_psum_0_write_done | GLB_psum_0_write_fin;
	end
end

always @(posedge clock) begin
	if (reset) begin
		GLB_psum_1_write_fin <= 1'b0;
	end 
	else if (GLB_psum_all_load_fin) begin
		GLB_psum_1_write_fin <= 1'b0;
	end 
	else begin
		GLB_psum_1_write_fin <= GLB_psum_1_write_done | GLB_psum_1_write_fin;
	end
end

always @(posedge clock) begin
	if (reset) begin
		GLB_psum_2_write_fin <= 1'b0;
	end 
	else if (GLB_psum_all_load_fin) begin
		GLB_psum_2_write_fin <= 1'b0;
	end 
	else begin
		GLB_psum_2_write_fin <= GLB_psum_2_write_done | GLB_psum_2_write_fin;
	end
end


// output
always @(posedge clock) begin
	if (reset) begin 
		GLB_iact_0_0_write_en_reg <= 1'b0; 
		GLB_iact_0_1_write_en_reg <= 1'b0;
		GLB_iact_0_2_write_en_reg <= 1'b0;
		GLB_iact_1_0_write_en_reg <= 1'b0; 
		GLB_iact_1_1_write_en_reg <= 1'b0;
		GLB_iact_1_2_write_en_reg <= 1'b0;
		GLB_iact_2_0_write_en_reg <= 1'b0; 
		GLB_iact_2_1_write_en_reg <= 1'b0;
		GLB_iact_2_2_write_en_reg <= 1'b0;
	end 
	else begin
		GLB_iact_0_0_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_0_1_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_0_2_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_1_0_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_1_1_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_1_2_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_2_0_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_2_1_write_en_reg <= cg_en & (CG_state == CG_IDLE);
		GLB_iact_2_2_write_en_reg <= cg_en & (CG_state == CG_IDLE);
	end
end


always @(posedge clock) begin
	if(reset) begin
		psum_load_en_reg <= 'd0;
	end
	else begin
		psum_load_en_reg <= psum_acc_en & (CG_state == CG_PE_CAL); 
	end
end

endmodule
