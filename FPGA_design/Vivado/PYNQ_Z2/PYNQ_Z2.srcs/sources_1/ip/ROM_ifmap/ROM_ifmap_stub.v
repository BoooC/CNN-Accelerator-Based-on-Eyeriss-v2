// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Jan  5 03:09:28 2024
// Host        : booo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top ROM_ifmap -prefix
//               ROM_ifmap_ ROM_ifmap_stub.v
// Design      : ROM_ifmap
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module ROM_ifmap(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[9:0],douta[7:0]" */;
  input clka;
  input ena;
  input [9:0]addra;
  output [7:0]douta;
endmodule
