module seg7_module(
    input 			clock,
    input 			reset,
    input 	[7:0] 	b3_data,
    input 	[7:0] 	b2_data,
    input 	[7:0] 	b1_data,
    input 	[7:0] 	b0_data,
	
    output 	[3:0] 	seg_h_an, // B3, B2
    output 	[7:0] 	seg_h_code,
    output 	[3:0] 	seg_l_an, // B1, B0
    output 	[7:0] 	seg_l_code
);

//  01 23  45 67  89 ab  cd ef
// __b3__ __b2__ __b1__ __b0__   

wire [7:0] b3_dn_code;
wire [7:0] b3_up_code;
wire [7:0] b2_dn_code;
wire [7:0] b2_up_code;
wire [7:0] b1_dn_code;
wire [7:0] b1_up_code;
wire [7:0] b0_dn_code;
wire [7:0] b0_up_code;

seg7_encoder b3_dn_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b3_data[3:0]),
    .out_code	(b3_dn_code)
);

seg7_encoder b3_up_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b3_data[7:4]),
    .out_code	(b3_up_code)
);

seg7_encoder b2_dn_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b2_data[3:0]),
    .out_code	(b2_dn_code)
);

seg7_encoder b2_up_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b2_data[7:4]),
    .out_code	(b2_up_code)
);

seg7_encoder b1_dn_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b1_data[3:0]),
    .out_code	(b1_dn_code)
);

seg7_encoder b1_up_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b1_data[7:4]),
    .out_code	(b1_up_code)
);

seg7_encoder b0_dn_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b0_data[3:0]),
    .out_code	(b0_dn_code)
);

seg7_encoder b0_up_encode(
    .clock		(clock),
    .reset		(reset),
    .in_num		(b0_data[7:4]),
    .out_code	(b0_up_code)
);

seg7_scan seg7_h_scan(
    .clock		(clock),
    .reset		(reset),
    .hb_dn_code	(b3_dn_code),
    .hb_up_code	(b3_up_code),
    .lb_dn_code	(b2_dn_code),
    .lb_up_code	(b2_up_code),  
    .an			(seg_h_an),
    .seg_code	(seg_h_code)
);

seg7_scan seg7_l_scan(
    .clock		(clock),
    .reset		(reset),
    .hb_dn_code	(b1_dn_code),
    .hb_up_code	(b1_up_code),
    .lb_dn_code	(b0_dn_code),
    .lb_up_code	(b0_up_code),  
    .an			(seg_l_an),
    .seg_code	(seg_l_code)
);
   
endmodule