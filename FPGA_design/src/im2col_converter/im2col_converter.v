
// ============================================================================================================ //
// This module is im2col_converter.
// im2col_converter is simple address controller for im2col converter based on original ifmap address.
// im2col_converter need several addrss jump value for im2col addressing .
// The jump formula is listed below.

// TODO : use line buffer to reuse im2col addressing data.
// 0	1	2	3	4
// 5	6	7	8	9
// 10	11	12	13	14
// for 3x3 filter
// use line buffer to store 0 5 10 1 6 11 address data
// next cycle store 1 6 11 2 7 12 address data
// for 5x5 filter, it need 5x4=20 length line buffer.
//
// another method
// only need lenght of 4 line buffer
// when im2col combines CSC CSC encoder, the output of im2col is as following
// 0	1	2	3	4	28	29 
// 1	2	3	4	5	29	30
// 2	3	4	5	6	30	31
// 3	4	5	6	7	31	32
// line buffer only need to store 0 1 2 3, next cycle sotre 1 2 3 4, the data of 1 2 3 are reused.
// 
// ============================================================================================================ //
// 
// im2col example
// 28x28 image arrangement:
// 
// 0	1	2	3	4	5	6	...	25	26	27
// 28	29	30	31	32	33	34	...	53	54	55
// 56	57	58	59	60	61	62	...	81	82	83
// 84	85	86	87	88	89	90	...	109	110	111
// 112	113	114	115	116	117	118	...	137	138	139
// 140	141	142	143	144	145	146	...	165	166	167
//  .							...			 .
//  .							...			 .
//  .							...			 .
// 728							...	753	754	755
// 756	757	758	759	760	761	762	...	781	782	783
// 
// 
// jump encodinng
// one filter 	  done 	-> +21 	(28-7)		general formual : ifmap_size - filter_size-1+vector_rows = 28 - (5-1+3) = 28-7
// one vector col done 	-> -2				general formual : vector_rows - 1 = 4-1
// one vector     done 	-> -115	(4-119)		general formual : vector_rows - ((filter_size-1) + (filter_size-1)*ifmap_size + vector_rows-1) = 4 - ((5-1)+(5-1)*28+(4-1)) = 4-119
// one ifmap  row done	-> -111	(28-139)	general formual : ifmap_size - (ifmap_size*filter_size-1) = 28 - (28*5-1) = 28-139
// ofmap_size 			-> 6				general formual : (ifmap_size-vector_rows)/vector_rows = (28-4)/4
// 
// 
// im2col image arrangement(filter size):
// 	ifmap row 1   	  |		ifmap row 2	  |		ifmap row 3	  |		ifmap row 4	  |		ifmap row 5
// ============================================= vector 1 ============================================= 
//	0	1	2	3	4	28	29	30	31	32	56	57	58	59	60	84	85	86	87	88	112	113	114	115	116
//	1	2	3	4	5	29	30	31	32	33	57	58	59	60	61	85	86	87	88	89	113	114	115	116	117
//	2	3	4	5	6	30	31	32	33	34	58	59	60	61	62	86	87	88	89	90	114	115	116	117	118
//	3	4	5	6	7	31	32	33	34	35	59	60	61	62	63	87	88	89	90	91	115	116	117	118	119
// ============================================= vector 2 ============================================= 
//	4	5	6	7	8	32	33	34	35	36	60	61	62	63	64	88	89	90	91	92	116	117	118	119	120
//	5	6	...																		117	118	119	120	121
//	6	7	...																		118	119	120	121	122
//	7	8	...																		119	120	121	122	123
//	.
//	.
//	.
// ============================================= vector 6 ============================================= 
//	20	21	22	23	24	48	49	50	51	52	76	77	78	79	80	104	105	106	107	108	132	133	134	135	136
//	21	22	23	24	25	49	50	51	52	53	77	78	79	80	81	105	106	107	108	109	133	134	135	136	137
//	22	23	24	25	26	50	51	52	53	54	78	79	80	81	82	106	107	108	109	110	134	135	136	137	138
//	23	24	25	26	27	51	52	53	54	55	79	80	81	82	83	107	108	109	110	111	135	136	137	138	139
//
// ifmap one row done -> jump
// 
// ============================================= vector 7 ============================================= 
//	28	29	30	31	32	56	57	58	59	60	84	85	86	87	88	112	113	114	115	116	140	141	142	143	144
//	29	30	31	32	33	57	58	59	60	61	85	86	87	88	89	113	114	115	116	117	141	142	143	144	145
//	30	31	32	33	34	58	59	60	61	62	86	87	88	89	90	114	115	116	117	118	142	143	144	145	146
//	31	32	33	34	35	59	60	61	62	63	87	88	89	90	91	115	116	117	118	119	143	144	145	146	147
// ============================================= vector 8 ============================================= 
//	32	33	34	35	36	60	61	62	63	64	88	89	90	91	92	116	117	118	119	120	144	145	146	147	148
//	33	34	...																		145	146	147	148	149
//	34	35	...																		146	147	148	149	150
//	35	36	...																		147	148	149	150	151
//	.
//	.
//	.
// ============================================= vector 8 ============================================= 
//	48	49	50	51	52	76	77	78	79	80	104	105	106	107	108	132	133	134	135	136	160	161	162	163	164
//	49	50	51	52	53	77	78	79	80	81	105	106	107	108	109	133	134	135	136	137	161	162	163	164	165
//	50	51	52	53	54	78	79	80	81	82	106	107	108	109	110	134	135	136	137	138	162	163	164	165	166
//	51	52	53	54	55	79	80	81	82	83	107	108	109	110	111	135	136	137	138	139	163	164	165	166	167
//	
// ifmap one row done -> jump
//	.
//	.
//	.
// ifmap one row done -> jump
//
// ============================================= vector 144 ============================================= 
//	664	665	666	667	668	692	693	694	695	696	720	721	722	723	724	748	749	750	751	752	776	777	778	779	780		
//	665	666	667	668	669	693	694	695	696	697	721	722	723	724	725	749	750	751	752	753	777	778	779	780	781		
//	666	667	668	669	670	694	695	696	697	698	722	723	724	725	726	750	751	752	753	754	778	779	780	781	782	
//	667	668	669	670	671	695	696	697	698	699	723	724	725	726	727	751	752	753	754	755	779	780	781	782	783
//	



module im2col_converter #(
	parameter	weight_width 	= 5, 
	parameter	im2col_out_rows = 4
)
(
	input				clock,
	input				reset,
	input				enable,
		
	input		[9:0]	ifmap_len,				// 783		
	input		[4:0]	ofmap_size,				
	
	// These jump signals are used for weight or ifmap sides(discontineous numbers) 
	input		[9:0]	next_weight_row_jump,	// +21	
	input		[9:0]	next_ifmap_row_jump,	// 111
	input		[9:0]	next_vector_jump,		// 115
	
	output	reg	[9:0]	read_psum_addr,
	output				convert_one_stream_done
);



// ====================================================================	//
// 						 		Registers  								//
// ====================================================================	//
reg	[2:0]	weight_row_counter;
reg	[2:0]	ofmap_col_counter;
reg	[2:0]	ofmap_row_counter;
reg	[2:0]	ifmap_col_counter;

reg convert_one_vector_done_dly0;
reg convert_one_vector_done_dly1;
reg convert_one_vector_done_dly2;



// ====================================================================	//
// 						 		Wires  									//
// ====================================================================	//
wire one_vector_done_dly =	convert_one_vector_done_dly0 | convert_one_vector_done_dly1 | convert_one_vector_done_dly2;

wire ofmap_col_done	=	(ofmap_col_counter 	== im2col_out_rows-1);
wire weight_row_done= 	(weight_row_counter == weight_width-1);
wire ofmap_row_done	= 	(ofmap_row_counter 	== weight_width-1);
wire ifmap_col_done	= 	(ifmap_col_counter	== ofmap_size-1);

wire ofmap_col_read = 	~ofmap_col_done & ~one_vector_done_dly;



// ====================================================================	//
// 						 		Combination  							//
// ====================================================================	//
assign convert_one_stream_done = read_psum_addr == ifmap_len;



// ====================================================================	//
// 						 		Sequential  							//
// ====================================================================	//
// Need to delay 3 cycles because CSC encoder write 2 extra data(final address and end sign, 0)
always@(posedge clock) begin
	if(reset) begin
		convert_one_vector_done_dly0 <= 'd0;
		convert_one_vector_done_dly1 <= 'd0;
		convert_one_vector_done_dly2 <= 'd0;
	end
	else begin
		convert_one_vector_done_dly0 <= ofmap_row_done & weight_row_done & ofmap_col_done;
		convert_one_vector_done_dly1 <= convert_one_vector_done_dly0;
		convert_one_vector_done_dly2 <= convert_one_vector_done_dly2;
	end
end


// im2col counter for addressing
always@(posedge clock) begin
	if(reset) begin
		ifmap_col_counter <= 'd0;
	end
	else if(ofmap_row_done & weight_row_done & ofmap_col_done) begin
		ifmap_col_counter <= ifmap_col_done ? 'd0 : (ifmap_col_counter + 'd1);
	end
end


always@(posedge clock) begin
	if(reset) begin
		ofmap_row_counter <= 'd0;
	end
	else if(weight_row_done & ofmap_col_done) begin
		ofmap_row_counter <= ofmap_row_done ? 'd0 : (ofmap_row_counter + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		weight_row_counter <= 'd0;
	end
	else if(ofmap_col_done) begin
		weight_row_counter <= weight_row_done ? 'd0 : (weight_row_counter + 'd1);
	end
end

always@(posedge clock) begin
	if(reset) begin
		ofmap_col_counter <= 'd0;
	end
	else if(enable & ~convert_one_vector_done_dly0 & ~convert_one_vector_done_dly1) begin
		ofmap_col_counter <= ofmap_col_done ? 'd0 : (ofmap_col_counter + 'd1);
	end
end


// output psum read address
always@(posedge clock) begin
	if(reset) begin
		read_psum_addr <= 'd0;
	end
	else if(enable) begin
		if(ifmap_col_done & ofmap_row_done & weight_row_done & ofmap_col_done) begin
			read_psum_addr <= read_psum_addr - next_ifmap_row_jump;
		end
		else if(ofmap_row_done & weight_row_done & ofmap_col_done) begin
			read_psum_addr <= read_psum_addr - next_vector_jump; 	
		end
		else if(weight_row_done & ofmap_col_done) begin								
			read_psum_addr <= read_psum_addr + next_weight_row_jump;
		end
		else if(ofmap_col_done) begin
			read_psum_addr <= read_psum_addr - 'd2; 	
		end
		else if(ofmap_col_read) begin
			read_psum_addr <= read_psum_addr + 'd1;
		end
	end
	else begin
		read_psum_addr <= 'd0;
	end
end














endmodule
