// ====================================================================================================== //
// This module is Softmax funcion.
// This module would read 10 contineous value and find the maximum value index.
// In FPGA design, the function is handwritten digit recognition, therefore the output of softmax is 0~9
// 
// ====================================================================================================== //



module softmax (
	input					clock,
	input					reset,
	
	input					en,
	
	input	signed	[20:0]	data_in,
	input					data_in_valid,
	
	output	reg		[3:0]	data_out,		// 0~9
	output	reg				data_out_valid
);


// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg			[3:0]	data_idx;
reg	signed	[20:0]	max_data_temp;
reg			[3:0]	max_data_idx_temp;


// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire data_in_en = en & data_in_valid;
wire end_flag 	= data_idx == 'd9;


// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
always@(posedge clock) begin
	if(reset) begin
		data_out 		<= 'd0;
		data_out_valid	<= 'd0;
	end
	else if(end_flag) begin
		data_out 		<= (data_in > max_data_temp) ? 'd9 : max_data_idx_temp;
		data_out_valid	<= 'd1;
	end
	else begin
		data_out 		<= 'd0;
		data_out_valid	<= 'd0;
	end
end


always@(posedge clock) begin
	if(reset) begin
		data_idx <= 'd0;
	end
	else if(data_in_en) begin
		data_idx <= end_flag ? 'd0 : (data_idx + 'd1);
	end
end

// set initial max reg to the minimum value
always@(posedge clock) begin
	if(reset) begin
		max_data_temp <= 21'b1_1111_1111_1111_1111_1111;
	end
	else if(end_flag) begin
		max_data_temp <= 21'b1_1111_1111_1111_1111_1111;
	end
	else if(data_in_en) begin
		max_data_temp <= (data_in > max_data_temp) ? data_in : max_data_temp;
	end
end

// store index coressponding to current largest value index
always@(posedge clock) begin
	if(reset) begin
		max_data_idx_temp <= 'd0;
	end
	else if(end_flag) begin
		max_data_idx_temp <= 'd0;
	end
	else if(data_in_en) begin
		max_data_idx_temp <= (data_in > max_data_temp) ? data_idx : max_data_idx_temp;
	end
end


endmodule
