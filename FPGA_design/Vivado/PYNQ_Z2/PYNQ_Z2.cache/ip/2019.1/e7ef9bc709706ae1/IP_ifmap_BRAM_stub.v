// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Jan  4 19:28:09 2024
// Host        : booo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ IP_ifmap_BRAM_stub.v
// Design      : IP_ifmap_BRAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clka, rsta, wea, addra, dina, douta, rsta_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,wea[0:0],addra[9:0],dina[7:0],douta[7:0],rsta_busy" */;
  input clka;
  input rsta;
  input [0:0]wea;
  input [9:0]addra;
  input [7:0]dina;
  output [7:0]douta;
  output rsta_busy;
endmodule
