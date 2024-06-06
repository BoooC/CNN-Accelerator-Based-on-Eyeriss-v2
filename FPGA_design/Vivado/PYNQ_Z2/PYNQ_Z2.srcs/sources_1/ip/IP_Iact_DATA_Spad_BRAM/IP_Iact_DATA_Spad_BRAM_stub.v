// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Jan  4 19:13:53 2024
// Host        : booo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top IP_Iact_DATA_Spad_BRAM -prefix
//               IP_Iact_DATA_Spad_BRAM_ IP_Iact_DATA_Spad_BRAM_stub.v
// Design      : IP_Iact_DATA_Spad_BRAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module IP_Iact_DATA_Spad_BRAM(clka, rsta, wea, addra, dina, douta, rsta_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,wea[0:0],addra[7:0],dina[12:0],douta[12:0],rsta_busy" */;
  input clka;
  input rsta;
  input [0:0]wea;
  input [7:0]addra;
  input [12:0]dina;
  output [12:0]douta;
  output rsta_busy;
endmodule
