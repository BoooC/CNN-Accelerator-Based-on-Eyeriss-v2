// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Jan  4 19:19:36 2024
// Host        : booo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top IP_Psum_Rearrange_BRAM -prefix
//               IP_Psum_Rearrange_BRAM_ IP_Psum_Rearrange_BRAM_stub.v
// Design      : IP_Psum_Rearrange_BRAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module IP_Psum_Rearrange_BRAM(clka, wea, addra, dina, clkb, rstb, addrb, doutb, 
  rsta_busy, rstb_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[11:0],dina[7:0],clkb,rstb,addrb[11:0],doutb[7:0],rsta_busy,rstb_busy" */;
  input clka;
  input [0:0]wea;
  input [11:0]addra;
  input [7:0]dina;
  input clkb;
  input rstb;
  input [11:0]addrb;
  output [7:0]doutb;
  output rsta_busy;
  output rstb_busy;
endmodule