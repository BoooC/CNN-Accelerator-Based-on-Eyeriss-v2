// ====================================================================================================== //
// This module is Max_pooling.
// This module only contains a buffer for 2x2 data and find_max logic.
// In this design, the pooling function only supports 2x2 max pooling.
// 
// TODO : extend this pooling module supported different poolong types, 
// such as average pooling, mini pooling, 4x4, 8x8, etc...
// 
// for different types of pooling it only need to revise 
// the counter and buffer depth and the number of stage of find max logic.
// ====================================================================================================== //

module Max_pooling #(
	parameter stride = 2
	)
(	
	input						clock,
	input						reset,
	input						enable,
	
	input		signed	[7:0]	data_in,
	input						data_in_valid,
	
	output	 	signed	[7:0]	data_out,
	output						data_out_valid
);

localparam	BUFFER_DEPTH = stride*stride;

reg	signed	[7:0] find_max_buffer [0:BUFFER_DEPTH-1];
reg	[1:0] addr;

wire buffer_full 	= addr == 'd3;
reg	 buffer_full_reg;

wire signed	[7:0] max_valule_0_1= (find_max_buffer[0] > find_max_buffer[1]) ? find_max_buffer[0] : find_max_buffer[1];
wire signed	[7:0] max_valule_2_3= (find_max_buffer[2] > find_max_buffer[3]) ? find_max_buffer[2] : find_max_buffer[3];
wire signed	[7:0] max_value		= (max_valule_0_1 > max_valule_2_3) ? max_valule_0_1 : max_valule_2_3;

integer i;
always@(posedge clock) begin
	if(reset) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			find_max_buffer[i] <= 'sd0;
		end
	end
	else if(enable & data_in_valid) begin
		find_max_buffer[addr] <= data_in;
	end
end


always@(posedge clock) begin
	if(reset) begin
		addr <= 'd0;
	end
	else if(enable) begin
		addr <= addr + 'd1;
	end
end

always@(posedge clock) begin
	if(reset) begin
		buffer_full_reg <= 'd0;
	end
	else begin
		buffer_full_reg <= buffer_full;
	end
end


assign	data_out		= buffer_full_reg ? max_value : 'd0;
assign	data_out_valid 	= buffer_full_reg ? 'd1 : 'd0;
/*
always@(posedge clock) begin
	if(reset) begin
		data_out 		<= 'd0;
		data_out_valid 	<= 'd0;
	end
	else if(buffer_full) begin
		data_out 		<= max_value;
		data_out_valid 	<= 'd1;
	end
	else begin
		data_out 		<= 'd0;
		data_out_valid 	<= 'd0;
	end
end
*/

endmodule
