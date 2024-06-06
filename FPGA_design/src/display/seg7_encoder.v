module seg7_encoder(
    input 				clock,
    input 				reset,
    input		[3:0]	in_num,
    output reg 	[7:0]	out_code
);

// 	----a----	
// 	|		|	
//	f		b
//	|---g---|
//	e		c
//	|		|
//	----d---.


/*
// positive
// 						  .gfe_dcba
localparam display_0 = 8'b1011_1111;
localparam display_1 = 8'b1000_0110;
localparam display_2 = 8'b1101_1011;
localparam display_3 = 8'b1100_1111;
localparam display_4 = 8'b1110_0110;
localparam display_5 = 8'b1110_1101;
localparam display_6 = 8'b1111_1101;
localparam display_7 = 8'b1000_0111;
localparam display_8 = 8'b1111_1111;
localparam display_9 = 8'b1110_1111;
localparam display_a = 8'b1111_0111;
localparam display_b = 8'b1111_1100;
localparam display_c = 8'b1011_1001;
localparam display_d = 8'b1101_1110;
localparam display_e = 8'b1111_1001;
localparam display_f = 8'b1111_0001;
*/

// negative
// 						  .gfe_dcba
localparam display_0 = 8'b0100_0000;
localparam display_1 = 8'b0111_1001;
localparam display_2 = 8'b0010_0100;
localparam display_3 = 8'b0011_0000;
localparam display_4 = 8'b0001_1001;
localparam display_5 = 8'b0001_0010;
localparam display_6 = 8'b0000_0010;
localparam display_7 = 8'b0111_1000;
localparam display_8 = 8'b0000_0000;
localparam display_9 = 8'b0001_0000;
localparam display_a = 8'b0000_1000;
localparam display_b = 8'b0000_0011;
localparam display_c = 8'b0100_0110;
localparam display_d = 8'b0010_0001;
localparam display_e = 8'b0000_0110;
localparam display_f = 8'b0000_1110;

always@(posedge clock) begin
    if(reset) begin
        out_code <= display_0;
	end
    else begin
        case(in_num)
            4'd0	:  	out_code <= display_0;
            4'd1	:  	out_code <= display_1;
            4'd2	:  	out_code <= display_2;
            4'd3	:  	out_code <= display_3;
            4'd4	:  	out_code <= display_4;
            4'd5	:  	out_code <= display_5;
            4'd6	:  	out_code <= display_6;
            4'd7	:  	out_code <= display_7;
            4'd8	:  	out_code <= display_8;
            4'd9	:  	out_code <= display_9;
            4'd10	: 	out_code <= display_a;
            4'd11	: 	out_code <= display_b;
            4'd12	: 	out_code <= display_c;
            4'd13	: 	out_code <= display_d;
            4'd14	: 	out_code <= display_e;
            4'd15	: 	out_code <= display_f;
            default	:	out_code <= display_0;
        endcase
	end
end

endmodule
