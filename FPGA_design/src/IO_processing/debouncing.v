module debouncing(
	input 			clock, 
	input 			sig_in, 
	output 	reg 	sig_out
); 



reg	[4:0] bounce;

always@(posedge clock) begin
	bounce[0] <= sig_in;
	bounce[1] <= bounce[0];
	bounce[2] <= bounce[1];
	bounce[3] <= bounce[2];
	bounce[4] <= bounce[3];
end
	

always@(*) begin
	case(bounce)
		5'b00000 : sig_out = 1'b0;
		5'b11111 : sig_out = 1'b1;
		default	 : sig_out = 1'b0;
	endcase
end


endmodule 