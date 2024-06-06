// ====================================================================================================== //
// This module is ReLU function.
// In CNN model, it is commonly set a activation funciotn succeed Convolution operation.
// The most popular activation funciotn is ReLU, which can force the negative value to 0.
// In this chip, ReLU can increase the sparsity of iact, therefore, ReLU funcion is properly in Peripheral. 
//
// ====================================================================================================== //

module ReLU (
	input	signed	[7:0]	data_in,
	input					data_in_valid,
	output	signed	[7:0]	data_out,
	output					data_out_valid
);

assign data_out = data_in[7] ? 8'sd0 : data_in;
assign data_out_valid = data_in_valid;


endmodule
