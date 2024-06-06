module psum_SRAM_out_acc #(
	parameter BATCHES 	= 4,
	parameter CHANNELS 	= 3
	)
(
	input 						clock,
	input 						reset,
	input 						en,
	
	input		signed	[20:0]	data_in,
	input						data_in_valid,
					 
	output	reg signed	[20:0]	data_out,
	output	reg 				data_out_valid
);

/*
	C0~5
	C6~11
	C12~15
*/
localparam BUFFER_DEPTH = BATCHES*CHANNELS;

reg	signed	[20:0] Buffer [0:BUFFER_DEPTH-1];
reg	[3:0] idx;
reg en_reg;
reg en_pulse_reg;
wire en_pulse = en & (~en_reg);

wire data_in_en = en_reg & data_in_valid;

wire signed	[20:0]	data_out_batch_0 = Buffer[0] + Buffer[4] + Buffer[8];
wire signed	[20:0]	data_out_batch_1 = Buffer[1] + Buffer[5] + Buffer[9];
wire signed	[20:0]	data_out_batch_2 = Buffer[2] + Buffer[6] + Buffer[10];
wire signed	[20:0]	data_out_batch_3 = Buffer[3] + Buffer[7] + Buffer[11];
		  
integer i;
always@(posedge clock) begin
	if(reset) begin
		for(i=0; i<BUFFER_DEPTH; i=i+1) begin
			Buffer[i] <= 'd0;
		end
	end
	else if(data_in_en) begin
		Buffer[idx] <= data_in;
	end
end


always@(posedge clock) begin
	if(reset) begin
		idx <= 'd0;
	end
	else if(data_in_en) begin
		idx <= (idx == 'd11) ? 'd0 : (idx + 'd1);
	end
end


always@(posedge clock) begin
	if(reset) begin
		data_out <= 'd0;
	end
	else begin
		case(idx)
			'd9		: data_out <= data_out_batch_0;
			'd10	: data_out <= data_out_batch_1;
			'd11	: data_out <= data_out_batch_2;
			'd0		: data_out <= data_out_batch_3;
			default : data_out <= 'd0;
		endcase
	end
end

always@(posedge clock) begin
	if(reset) begin
		data_out_valid <= 'd0;
	end
	else if((idx == 'd9) | (idx == 'd10) | (idx == 'd11) | (idx == 'd0) & ~en_pulse_reg & en_reg) begin
		data_out_valid <= 'd1;
	end
	else begin
		data_out_valid <= 'd0;
	end
end

always@(posedge clock) begin
	if(reset) begin
		en_reg 			<= 'd0;
		en_pulse_reg 	<= 'd0;
	end
	else begin
		en_reg 			<= en;
		en_pulse_reg 	<= en_pulse;
	end
end



endmodule
