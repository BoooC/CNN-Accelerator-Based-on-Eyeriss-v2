module H2L_detect(
    input 	clock,
	input	reset,
    input 	pin_in,
    output 	sig_H2L
);

reg pin_pre;

assign sig_H2L = !pin_in & pin_pre;

always@(posedge clock) begin	
	if(reset) begin
		pin_pre <= 'd1;
	end
	else begin
		pin_pre <= pin_in;
	end
end
	
endmodule


/*
module L2H_detect(
    input 	clock,
    input 	reset,
    input 	pin_in,
    output sig_L2H
);

reg pin_pre;

assign sig_L2H = pin_in & !pin_pre;

always@(posedge clock) begin
    if(reset) begin
        pin_pre <= 1'b0;
	end
    else begin
        pin_pre <= pin_in;
	end
end

endmodule
*/
