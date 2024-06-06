// ====================================================================================================== //
// This module is Psum_Requantizer.
// The quantization scheme is a simple shifter.
//
// Since psum will be accumulated with several times, in this design the maximum accumulated time is 6,
// which means the bitwidth of data will be extended to 21-bit. (8+8+(6-1))
// it must be requantized back to 8-bit precision.
//
// For normal case, the shifter should shift 13-bit, but this chip is for SCNN, in ordeer to avoid the data 
// vanishing by requantization, this module only shift 2-bit to reserve the information of data.
// ====================================================================================================== //

module Psum_Requantizer (
	input	signed	[20:0]	data_in,
	input					data_in_valid,
	output	signed	[7:0]	data_out,
	output					data_out_valid
);

assign data_out = data_in [17:10];
assign data_out_valid = data_in_valid;


endmodule
