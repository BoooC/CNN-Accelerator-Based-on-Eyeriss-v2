// ====================================================================================================== //
// This module is iact data SRAM.
// iact data SRAM module is used to store iact data_count vector from CSC decoder.
// Because the data stored in SRAM is CSC format, the length is not fixed.
// Hence, this module contains a FSM to control data stream end sign
// When FSM detects one zero, then LUT will be written current index to record this data stream end index.
// When FSM detects two contineous zero, then FSM will control write index to zero(reset read index),
// which stands for all data stream for this SRAM is finish. 
// ====================================================================================================== //

module Iact_data_SRAM(
	input        		clock,
	input        		reset,
	output       		data_in_ready,
	input        		data_in_valid,
	input  		[11:0] 	data_in,
	input        		data_out_ready,
	output reg       	data_out_valid,
	output reg 	[11:0] 	data_out,
	input        		write_en,
	output       		write_done,
	input        		read_en,
	input  		[9:0] 	read_addr,
	output       		read_done
);

localparam IACT_DATA_SRAM_DEPTH = 1024;
localparam IACT_DATA_LUT_DEPTH  = 32;

localparam NOZERO  = 2'b00;
localparam ONEZERO = 2'b01; // record statr address
localparam TWOZERO = 2'b10; // data stream finish

reg [11:0] InActSRAM [0:IACT_DATA_SRAM_DEPTH-1]; 
reg [10:0] addr_LUT_mem [0:IACT_DATA_LUT_DEPTH-1]; // store start address

reg  waitForRead;
reg [1:0] readZero;

reg [1:0] readZeroState, next_readZeroState;
reg [1:0] writeZeroState, next_writeZeroState; 

reg [10:0] writeIdx;
reg [10:0] readIdxAcc; 
reg [10:0] lookupTableWriteIdx; 
reg  writeDoneOnce; 

wire [10:0] InActSRAM_readOutData_addr;
wire [9:0] addr_LUT_mem_readStartIdx_addr; 
wire [10:0] addr_LUT_mem_readStartIdx_data; 

wire  meetZeroWire_read  = (data_out == 'd0) & data_out_valid; 
wire  meetZeroWire_write = (data_in  == 'd0) ? 1'b1 : 1'b0; 

wire  doReadWire 	= read_en & data_out_ready & ~meetZeroWire_read; 
wire  writeDoneWire = (writeZeroState == TWOZERO);
wire  readDoneWire 	= meetZeroWire_read & read_en; 

assign addr_LUT_mem_readStartIdx_addr = read_addr;
assign addr_LUT_mem_readStartIdx_data = addr_LUT_mem[addr_LUT_mem_readStartIdx_addr]; 
assign InActSRAM_readOutData_addr 	  = readIdxAcc + addr_LUT_mem_readStartIdx_data;

assign data_in_ready = write_en; 
assign write_done 	 = writeDoneWire & (writeIdx != 'd0); 
assign read_done 	 = readDoneWire  & (readZeroState != ONEZERO); 

// FSM
always @(posedge clock) begin
	if (reset) begin 
		readZeroState <= NOZERO; 
	end 
	else begin
		readZeroState <= next_readZeroState;
	end
end

always @(posedge clock) begin
	if (reset) begin 
		writeZeroState <= NOZERO; 
	end 
	else begin
		writeZeroState <= next_writeZeroState;
	end
end

// next state logic
always@(*) begin
	case(readZeroState)
		NOZERO  : next_readZeroState = (meetZeroWire_read & data_out_ready & data_out_valid) ? ONEZERO : NOZERO;
		ONEZERO : next_readZeroState = (meetZeroWire_read) ? TWOZERO : NOZERO;
		TWOZERO : next_readZeroState = NOZERO;
		default : next_readZeroState = NOZERO;
	endcase
end

always@(*) begin
	case(writeZeroState)
		NOZERO  : next_writeZeroState = (meetZeroWire_write & write_en & data_in_valid) ? ONEZERO : NOZERO;
		ONEZERO : next_writeZeroState = (meetZeroWire_write & write_en & data_in_valid) ? TWOZERO : NOZERO;
		TWOZERO : next_writeZeroState = NOZERO;
		default : next_writeZeroState = NOZERO;
	endcase
end


// read SRAM
always @(posedge clock) begin
	if(reset) begin
		data_out = 'd0;
	end
	else if (doReadWire) begin
		data_out <= InActSRAM[InActSRAM_readOutData_addr];
	end
end


integer i;
// write SRAM
always @(posedge clock) begin
	if(reset) begin
		for(i=0; i<IACT_DATA_SRAM_DEPTH; i=i+1) begin
			InActSRAM[i] <= 'd0; 
		end
	end
	else if (write_en & data_in_valid) begin
		InActSRAM[writeIdx] <= data_in; 
	end
end


always @(posedge clock) begin
	if(reset) begin
		addr_LUT_mem[0] <= 'd0; 
		for(i=1; i<IACT_DATA_LUT_DEPTH; i=i+1) begin
			addr_LUT_mem[i] <= IACT_DATA_SRAM_DEPTH-1; 
		end
	end
	else if (writeZeroState == ONEZERO) begin
		addr_LUT_mem[lookupTableWriteIdx + 'd1] <= writeIdx; 
	end
end


// LTU index 
always @(posedge clock) begin
	if (reset) begin 
		lookupTableWriteIdx <= 'd0;
	end 
	else if (writeDoneWire) begin 
		lookupTableWriteIdx <= 'd0;
	end 
	else if (writeZeroState == ONEZERO & write_en) begin 
		lookupTableWriteIdx <= lookupTableWriteIdx + 'd1; 
	end
end

// control signal
always @(posedge clock) begin
	if (reset) begin 
		waitForRead <= 1'd0; 
	end 
	else if(!readDoneWire & data_out_ready) begin
		waitForRead <= (doReadWire ? !waitForRead : waitForRead);
	end
	else begin
		waitForRead <= 1'd0; 
	end
end

always @(posedge clock) begin
	if (reset) begin 
		data_out_valid <= 1'd0; 
	end 
	else begin
		data_out_valid <= doReadWire; 
	end
end

always @(posedge clock) begin
	if (reset) begin
		writeIdx <= 'd0; 
	end 
	else if (write_done) begin 
		writeIdx <= 'd0;
	end 
	else if (write_en & data_in_valid) begin 
		writeIdx <= writeIdx + 'd1;
	end
end

always @(posedge clock) begin
	if (reset) begin 
		readIdxAcc <= 'd0; 
	end 
	else if (readDoneWire | ~read_en) begin 
		readIdxAcc <= 'd0;
	end 
	
	else if (read_en) begin 
		readIdxAcc <= readIdxAcc + 'd1;
	end
end


endmodule
