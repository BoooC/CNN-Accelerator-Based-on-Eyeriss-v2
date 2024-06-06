module seg7_scan(
    input 				clock,
    input 				reset,
    input		[7:0]	hb_dn_code, // high byte
    input 		[7:0]	hb_up_code,
    input 		[7:0]	lb_dn_code, // low byte
    input 		[7:0]	lb_up_code,
    output	reg	[3:0]	an,
    output	reg	[7:0]	seg_code
);

parameter AN0 = 4'b0001, AN1 = 4'b0010, AN2 = 4'b0100, AN3 = 4'b1000;
parameter FRE_CNT = 20'd625000;

reg [19:0]	cnt_freq;
reg [1:0]	pos;

always@(posedge clock) begin
    if(reset) begin
        cnt_freq <= 20'd0;
    end
    else if(cnt_freq == FRE_CNT) begin
        cnt_freq <= 20'd0;
    end
    else begin
		cnt_freq <= cnt_freq + 1'b1;
	end
end

always@(posedge clock) begin
    if(reset) begin
        pos <= 2'd0;
    end
    else if(cnt_freq == FRE_CNT) begin
        pos <= pos + 1'b1;
    end
end
            
always@(posedge clock) begin
    if(reset) begin
        an <= 4'hf;
        seg_code <= 8'hff;
    end
    else begin
        case(pos)
            2'd0: begin
                an <= AN0;
                seg_code <= lb_dn_code;
            end
            2'd1: begin
                an <= AN1;
                seg_code <= lb_up_code;
            end
            2'd2: begin
                an <= AN2;
                seg_code <= hb_dn_code;
            end
            2'd3: begin
                an <= AN3;
                seg_code <= hb_up_code;
            end
        endcase
	end
end
		
endmodule
