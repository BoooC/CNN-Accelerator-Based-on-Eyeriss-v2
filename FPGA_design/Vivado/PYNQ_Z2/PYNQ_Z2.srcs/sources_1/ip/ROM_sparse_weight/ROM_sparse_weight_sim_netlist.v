// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Jan  4 19:27:29 2024
// Host        : booo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/ROM_sparse_weight/ROM_sparse_weight_sim_netlist.v
// Design      : ROM_sparse_weight
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ROM_sparse_weight,blk_mem_gen_v8_4_3,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module ROM_sparse_weight
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [15:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [15:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [15:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "16" *) 
  (* C_ADDRB_WIDTH = "16" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "2" *) 
  (* C_COUNT_36K_BRAM = "18" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     15.89039 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "ROM_sparse_weight.mem" *) 
  (* C_INIT_FILE_NAME = "ROM_sparse_weight.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "40000" *) 
  (* C_READ_DEPTH_B = "40000" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "40000" *) 
  (* C_WRITE_DEPTH_B = "40000" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  ROM_sparse_weight_blk_mem_gen_v8_4_3 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[15:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[15:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "bindec" *) 
module ROM_sparse_weight_bindec
   (ena_array,
    addra,
    ena);
  output [8:0]ena_array;
  input [3:0]addra;
  input ena;

  wire [3:0]addra;
  wire ena;
  wire [8:0]ena_array;

  LUT5 #(
    .INIT(32'h00000010)) 
    ENOUT
       (.I0(addra[3]),
        .I1(addra[2]),
        .I2(ena),
        .I3(addra[0]),
        .I4(addra[1]),
        .O(ena_array[0]));
  LUT5 #(
    .INIT(32'h01000000)) 
    ENOUT__0
       (.I0(addra[3]),
        .I1(addra[2]),
        .I2(addra[1]),
        .I3(addra[0]),
        .I4(ena),
        .O(ena_array[1]));
  LUT5 #(
    .INIT(32'h01000000)) 
    ENOUT__1
       (.I0(addra[3]),
        .I1(addra[2]),
        .I2(addra[0]),
        .I3(addra[1]),
        .I4(ena),
        .O(ena_array[2]));
  LUT5 #(
    .INIT(32'h01000000)) 
    ENOUT__2
       (.I0(addra[3]),
        .I1(addra[1]),
        .I2(addra[0]),
        .I3(addra[2]),
        .I4(ena),
        .O(ena_array[3]));
  LUT5 #(
    .INIT(32'h10000000)) 
    ENOUT__3
       (.I0(addra[3]),
        .I1(addra[1]),
        .I2(ena),
        .I3(addra[0]),
        .I4(addra[2]),
        .O(ena_array[4]));
  LUT5 #(
    .INIT(32'h10000000)) 
    ENOUT__4
       (.I0(addra[3]),
        .I1(addra[0]),
        .I2(ena),
        .I3(addra[1]),
        .I4(addra[2]),
        .O(ena_array[5]));
  LUT5 #(
    .INIT(32'h40000000)) 
    ENOUT__5
       (.I0(addra[3]),
        .I1(ena),
        .I2(addra[2]),
        .I3(addra[0]),
        .I4(addra[1]),
        .O(ena_array[6]));
  LUT5 #(
    .INIT(32'h01000000)) 
    ENOUT__6
       (.I0(addra[2]),
        .I1(addra[1]),
        .I2(addra[0]),
        .I3(ena),
        .I4(addra[3]),
        .O(ena_array[7]));
  LUT5 #(
    .INIT(32'h10000000)) 
    ENOUT__7
       (.I0(addra[2]),
        .I1(addra[1]),
        .I2(addra[3]),
        .I3(addra[0]),
        .I4(ena),
        .O(ena_array[8]));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module ROM_sparse_weight_blk_mem_gen_generic_cstr
   (douta,
    clka,
    addra,
    ena);
  output [15:0]douta;
  input clka;
  input [15:0]addra;
  input ena;

  wire [15:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;
  wire [9:0]ena_array;
  wire [8:0]p_11_out;
  wire [8:0]p_15_out;
  wire [8:0]p_19_out;
  wire [8:0]p_23_out;
  wire [8:0]p_27_out;
  wire [8:0]p_31_out;
  wire [8:0]p_35_out;
  wire [8:0]p_39_out;
  wire [8:0]p_3_out;
  wire [8:0]p_7_out;
  wire ram_douta;
  wire ram_ena__0_n_0;
  wire ram_ena_n_0;
  wire \ramloop[1].ram.r_n_0 ;
  wire \ramloop[2].ram.r_n_0 ;
  wire \ramloop[3].ram.r_n_0 ;
  wire \ramloop[3].ram.r_n_1 ;
  wire \ramloop[3].ram.r_n_2 ;
  wire \ramloop[4].ram.r_n_0 ;
  wire \ramloop[5].ram.r_n_0 ;
  wire \ramloop[6].ram.r_n_0 ;
  wire \ramloop[6].ram.r_n_1 ;
  wire \ramloop[6].ram.r_n_2 ;
  wire \ramloop[6].ram.r_n_3 ;
  wire \ramloop[7].ram.r_n_0 ;
  wire \ramloop[8].ram.r_n_0 ;
  wire \ramloop[9].ram.r_n_0 ;

  ROM_sparse_weight_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[15:12]),
        .ena(ena),
        .ena_array({ena_array[9:4],ena_array[2:0]}));
  ROM_sparse_weight_blk_mem_gen_mux \has_mux_a.A 
       (.DOADO(\ramloop[1].ram.r_n_0 ),
        .addra(addra[15:12]),
        .clka(clka),
        .douta(douta),
        .\douta[0] (ram_douta),
        .\douta[1] (\ramloop[2].ram.r_n_0 ),
        .\douta[2] ({\ramloop[3].ram.r_n_0 ,\ramloop[3].ram.r_n_1 }),
        .\douta[2]_0 (\ramloop[4].ram.r_n_0 ),
        .\douta[3] (\ramloop[5].ram.r_n_0 ),
        .\douta[4] (\ramloop[7].ram.r_n_0 ),
        .\douta[5] (\ramloop[8].ram.r_n_0 ),
        .\douta[6] ({\ramloop[6].ram.r_n_0 ,\ramloop[6].ram.r_n_1 ,\ramloop[6].ram.r_n_2 ,\ramloop[6].ram.r_n_3 }),
        .\douta[6]_0 (\ramloop[9].ram.r_n_0 ),
        .ena(ena),
        .p_11_out(p_11_out),
        .p_15_out(p_15_out),
        .p_19_out(p_19_out),
        .p_23_out(p_23_out),
        .p_27_out(p_27_out),
        .p_31_out(p_31_out),
        .p_35_out(p_35_out),
        .p_39_out(p_39_out),
        .p_3_out(p_3_out),
        .p_7_out(p_7_out));
  LUT2 #(
    .INIT(4'h2)) 
    ram_ena
       (.I0(ena),
        .I1(addra[15]),
        .O(ram_ena_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    ram_ena__0
       (.I0(addra[14]),
        .I1(addra[15]),
        .I2(ena),
        .O(ram_ena__0_n_0));
  ROM_sparse_weight_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (ram_douta),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized9 \ramloop[10].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[0]),
        .p_39_out(p_39_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized10 \ramloop[11].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[1]),
        .p_35_out(p_35_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized11 \ramloop[12].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[2]),
        .p_31_out(p_31_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized12 \ramloop[13].ram.r 
       (.addra(addra),
        .clka(clka),
        .ena(ena),
        .p_27_out(p_27_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized13 \ramloop[14].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[4]),
        .p_23_out(p_23_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized14 \ramloop[15].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[5]),
        .p_19_out(p_19_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized15 \ramloop[16].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[6]),
        .p_15_out(p_15_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized16 \ramloop[17].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[7]),
        .p_11_out(p_11_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized17 \ramloop[18].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[8]),
        .p_7_out(p_7_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized18 \ramloop[19].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .ena_array(ena_array[9]),
        .p_3_out(p_3_out));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram (ram_ena__0_n_0),
        .DOADO(\ramloop[1].ram.r_n_0 ),
        .addra(addra[13:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[2].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ({\ramloop[3].ram.r_n_0 ,\ramloop[3].ram.r_n_1 }),
        .addra(addra),
        .clka(clka),
        .ena(ena),
        .ena_0(\ramloop[3].ram.r_n_2 ));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[4].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[5].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[6].ram.r_n_0 ,\ramloop[6].ram.r_n_1 ,\ramloop[6].ram.r_n_2 ,\ramloop[6].ram.r_n_3 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[3].ram.r_n_2 ),
        .addra(addra[12:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[7].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized7 \ramloop[8].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[8].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
  ROM_sparse_weight_blk_mem_gen_prim_width__parameterized8 \ramloop[9].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[9].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (ram_ena_n_0),
        .addra(addra[14:0]),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module ROM_sparse_weight_blk_mem_gen_mux
   (douta,
    p_3_out,
    p_7_out,
    ena,
    addra,
    clka,
    DOADO,
    \douta[0] ,
    \douta[2] ,
    \douta[1] ,
    \douta[2]_0 ,
    \douta[6] ,
    \douta[3] ,
    \douta[4] ,
    \douta[5] ,
    \douta[6]_0 ,
    p_27_out,
    p_31_out,
    p_35_out,
    p_39_out,
    p_11_out,
    p_15_out,
    p_19_out,
    p_23_out);
  output [15:0]douta;
  input [8:0]p_3_out;
  input [8:0]p_7_out;
  input ena;
  input [3:0]addra;
  input clka;
  input [0:0]DOADO;
  input [0:0]\douta[0] ;
  input [1:0]\douta[2] ;
  input [0:0]\douta[1] ;
  input [0:0]\douta[2]_0 ;
  input [3:0]\douta[6] ;
  input [0:0]\douta[3] ;
  input [0:0]\douta[4] ;
  input [0:0]\douta[5] ;
  input [0:0]\douta[6]_0 ;
  input [8:0]p_27_out;
  input [8:0]p_31_out;
  input [8:0]p_35_out;
  input [8:0]p_39_out;
  input [8:0]p_11_out;
  input [8:0]p_15_out;
  input [8:0]p_19_out;
  input [8:0]p_23_out;

  wire [0:0]DOADO;
  wire [3:0]addra;
  wire clka;
  wire [15:0]douta;
  wire [0:0]\douta[0] ;
  wire \douta[10]_INST_0_i_1_n_0 ;
  wire \douta[10]_INST_0_i_2_n_0 ;
  wire \douta[10]_INST_0_i_3_n_0 ;
  wire \douta[11]_INST_0_i_1_n_0 ;
  wire \douta[11]_INST_0_i_2_n_0 ;
  wire \douta[11]_INST_0_i_3_n_0 ;
  wire \douta[12]_INST_0_i_1_n_0 ;
  wire \douta[12]_INST_0_i_2_n_0 ;
  wire \douta[12]_INST_0_i_3_n_0 ;
  wire \douta[13]_INST_0_i_1_n_0 ;
  wire \douta[13]_INST_0_i_2_n_0 ;
  wire \douta[13]_INST_0_i_3_n_0 ;
  wire \douta[14]_INST_0_i_1_n_0 ;
  wire \douta[14]_INST_0_i_2_n_0 ;
  wire \douta[14]_INST_0_i_3_n_0 ;
  wire \douta[15]_INST_0_i_1_n_0 ;
  wire \douta[15]_INST_0_i_2_n_0 ;
  wire \douta[15]_INST_0_i_3_n_0 ;
  wire [0:0]\douta[1] ;
  wire [1:0]\douta[2] ;
  wire [0:0]\douta[2]_0 ;
  wire [0:0]\douta[3] ;
  wire [0:0]\douta[4] ;
  wire [0:0]\douta[5] ;
  wire [3:0]\douta[6] ;
  wire [0:0]\douta[6]_0 ;
  wire \douta[7]_INST_0_i_1_n_0 ;
  wire \douta[7]_INST_0_i_2_n_0 ;
  wire \douta[7]_INST_0_i_3_n_0 ;
  wire \douta[8]_INST_0_i_1_n_0 ;
  wire \douta[8]_INST_0_i_2_n_0 ;
  wire \douta[8]_INST_0_i_3_n_0 ;
  wire \douta[9]_INST_0_i_1_n_0 ;
  wire \douta[9]_INST_0_i_2_n_0 ;
  wire \douta[9]_INST_0_i_3_n_0 ;
  wire ena;
  wire [8:0]p_11_out;
  wire [8:0]p_15_out;
  wire [8:0]p_19_out;
  wire [8:0]p_23_out;
  wire [8:0]p_27_out;
  wire [8:0]p_31_out;
  wire [8:0]p_35_out;
  wire [8:0]p_39_out;
  wire [8:0]p_3_out;
  wire [8:0]p_7_out;
  wire [3:0]sel_pipe;

  LUT4 #(
    .INIT(16'h2F20)) 
    \douta[0]_INST_0 
       (.I0(DOADO),
        .I1(sel_pipe[2]),
        .I2(sel_pipe[3]),
        .I3(\douta[0] ),
        .O(douta[0]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[10]_INST_0 
       (.I0(\douta[10]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[10]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[10]_INST_0_i_3_n_0 ),
        .O(douta[10]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[10]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[3]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[3]),
        .I4(sel_pipe[2]),
        .O(\douta[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[10]_INST_0_i_2 
       (.I0(p_11_out[3]),
        .I1(p_15_out[3]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[3]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[3]),
        .O(\douta[10]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[10]_INST_0_i_3 
       (.I0(p_27_out[3]),
        .I1(p_31_out[3]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[3]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[3]),
        .O(\douta[10]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[11]_INST_0 
       (.I0(\douta[11]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[11]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[11]_INST_0_i_3_n_0 ),
        .O(douta[11]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[11]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[4]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[4]),
        .I4(sel_pipe[2]),
        .O(\douta[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[11]_INST_0_i_2 
       (.I0(p_11_out[4]),
        .I1(p_15_out[4]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[4]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[4]),
        .O(\douta[11]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[11]_INST_0_i_3 
       (.I0(p_27_out[4]),
        .I1(p_31_out[4]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[4]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[4]),
        .O(\douta[11]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[12]_INST_0 
       (.I0(\douta[12]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[12]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[12]_INST_0_i_3_n_0 ),
        .O(douta[12]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[12]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[5]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[5]),
        .I4(sel_pipe[2]),
        .O(\douta[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[12]_INST_0_i_2 
       (.I0(p_11_out[5]),
        .I1(p_15_out[5]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[5]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[5]),
        .O(\douta[12]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[12]_INST_0_i_3 
       (.I0(p_27_out[5]),
        .I1(p_31_out[5]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[5]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[5]),
        .O(\douta[12]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[13]_INST_0 
       (.I0(\douta[13]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[13]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[13]_INST_0_i_3_n_0 ),
        .O(douta[13]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[13]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[6]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[6]),
        .I4(sel_pipe[2]),
        .O(\douta[13]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[13]_INST_0_i_2 
       (.I0(p_11_out[6]),
        .I1(p_15_out[6]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[6]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[6]),
        .O(\douta[13]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[13]_INST_0_i_3 
       (.I0(p_27_out[6]),
        .I1(p_31_out[6]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[6]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[6]),
        .O(\douta[13]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[14]_INST_0 
       (.I0(\douta[14]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[14]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[14]_INST_0_i_3_n_0 ),
        .O(douta[14]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[14]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[7]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[7]),
        .I4(sel_pipe[2]),
        .O(\douta[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[14]_INST_0_i_2 
       (.I0(p_11_out[7]),
        .I1(p_15_out[7]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[7]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[7]),
        .O(\douta[14]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[14]_INST_0_i_3 
       (.I0(p_27_out[7]),
        .I1(p_31_out[7]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[7]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[7]),
        .O(\douta[14]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[15]_INST_0 
       (.I0(\douta[15]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[15]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[15]_INST_0_i_3_n_0 ),
        .O(douta[15]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[15]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[8]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[8]),
        .I4(sel_pipe[2]),
        .O(\douta[15]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[15]_INST_0_i_2 
       (.I0(p_11_out[8]),
        .I1(p_15_out[8]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[8]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[8]),
        .O(\douta[15]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[15]_INST_0_i_3 
       (.I0(p_27_out[8]),
        .I1(p_31_out[8]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[8]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[8]),
        .O(\douta[15]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[1]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[2] [0]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[1] ),
        .O(douta[1]));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[2]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[2] [1]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[2]_0 ),
        .O(douta[2]));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[3]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[6] [0]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[3] ),
        .O(douta[3]));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[4]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[6] [1]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[4] ),
        .O(douta[4]));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[5]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[6] [2]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[5] ),
        .O(douta[5]));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[6]_INST_0 
       (.I0(sel_pipe[1]),
        .I1(\douta[6] [3]),
        .I2(sel_pipe[2]),
        .I3(sel_pipe[3]),
        .I4(\douta[6]_0 ),
        .O(douta[6]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[7]_INST_0 
       (.I0(\douta[7]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[7]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[7]_INST_0_i_3_n_0 ),
        .O(douta[7]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[7]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[0]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[0]),
        .I4(sel_pipe[2]),
        .O(\douta[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[7]_INST_0_i_2 
       (.I0(p_11_out[0]),
        .I1(p_15_out[0]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[0]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[0]),
        .O(\douta[7]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[7]_INST_0_i_3 
       (.I0(p_27_out[0]),
        .I1(p_31_out[0]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[0]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[0]),
        .O(\douta[7]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[8]_INST_0 
       (.I0(\douta[8]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[8]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[8]_INST_0_i_3_n_0 ),
        .O(douta[8]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[8]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[1]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[1]),
        .I4(sel_pipe[2]),
        .O(\douta[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[8]_INST_0_i_2 
       (.I0(p_11_out[1]),
        .I1(p_15_out[1]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[1]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[1]),
        .O(\douta[8]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[8]_INST_0_i_3 
       (.I0(p_27_out[1]),
        .I1(p_31_out[1]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[1]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[1]),
        .O(\douta[8]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \douta[9]_INST_0 
       (.I0(\douta[9]_INST_0_i_1_n_0 ),
        .I1(sel_pipe[3]),
        .I2(\douta[9]_INST_0_i_2_n_0 ),
        .I3(sel_pipe[2]),
        .I4(\douta[9]_INST_0_i_3_n_0 ),
        .O(douta[9]));
  LUT5 #(
    .INIT(32'h00004540)) 
    \douta[9]_INST_0_i_1 
       (.I0(sel_pipe[1]),
        .I1(p_3_out[2]),
        .I2(sel_pipe[0]),
        .I3(p_7_out[2]),
        .I4(sel_pipe[2]),
        .O(\douta[9]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[9]_INST_0_i_2 
       (.I0(p_11_out[2]),
        .I1(p_15_out[2]),
        .I2(sel_pipe[1]),
        .I3(p_19_out[2]),
        .I4(sel_pipe[0]),
        .I5(p_23_out[2]),
        .O(\douta[9]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[9]_INST_0_i_3 
       (.I0(p_27_out[2]),
        .I1(p_31_out[2]),
        .I2(sel_pipe[1]),
        .I3(p_35_out[2]),
        .I4(sel_pipe[0]),
        .I5(p_39_out[2]),
        .O(\douta[9]_INST_0_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clka),
        .CE(ena),
        .D(addra[0]),
        .Q(sel_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[1] 
       (.C(clka),
        .CE(ena),
        .D(addra[1]),
        .Q(sel_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[2] 
       (.C(clka),
        .CE(ena),
        .D(addra[2]),
        .Q(sel_pipe[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[3] 
       (.C(clka),
        .CE(ena),
        .D(addra[3]),
        .Q(sel_pipe[3]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized0
   (DOADO,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    addra);
  output [0:0]DOADO;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  input [13:0]addra;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire [0:0]DOADO;
  wire [13:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .DOADO(DOADO),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized1
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized10
   (p_35_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_35_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_35_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized10 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_35_out(p_35_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized11
   (p_31_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_31_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_31_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized11 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_31_out(p_31_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized12
   (p_27_out,
    clka,
    addra,
    ena);
  output [8:0]p_27_out;
  input clka;
  input [15:0]addra;
  input ena;

  wire [15:0]addra;
  wire clka;
  wire ena;
  wire [8:0]p_27_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized12 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena(ena),
        .p_27_out(p_27_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized13
   (p_23_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_23_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_23_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized13 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_23_out(p_23_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized14
   (p_19_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_19_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_19_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized14 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_19_out(p_19_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized15
   (p_15_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_15_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_15_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized15 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_15_out(p_15_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized16
   (p_11_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_11_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_11_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized16 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_11_out(p_11_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized17
   (p_7_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_7_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_7_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized17 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_7_out(p_7_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized18
   (p_3_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_3_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_3_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized18 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_3_out(p_3_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized2
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    ena_0,
    clka,
    addra,
    ena);
  output [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  output ena_0;
  input clka;
  input [15:0]addra;
  input ena;

  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire [15:0]addra;
  wire clka;
  wire ena;
  wire ena_0;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized2 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .addra(addra),
        .clka(clka),
        .ena(ena),
        .ena_0(ena_0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized3
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized4
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized4 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized5
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [12:0]addra;

  wire [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [12:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized5 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized6
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized6 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized7
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized7 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized8
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized8 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ROM_sparse_weight_blk_mem_gen_prim_width__parameterized9
   (p_39_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_39_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_39_out;

  ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized9 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .ena_array(ena_array),
        .p_39_out(p_39_out));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hAACA59474A52AAED95ABA51555229803F6CAA1BEB2B4B4D5B4A555259DCAB52A),
    .INIT_01(256'hA6512AAE71556A85555C1F55B26C59949A50B6AAA48AC8AA6A27156BD12CB61A),
    .INIT_02(256'hF33722AA9EA8B848A9227B55515A4AAA5E5954AA9955EBD4E56AA65EA4B09ACD),
    .INIT_03(256'h9569541290A9A6B7A952D694D4D94D52ABA51AA98E9B4A2ED44AD188D1A2F9D2),
    .INIT_04(256'h2861FB2AA1D4A690A9695ED5B62D16AAA8B5D89C58AAAAAAA4AA4EAAB4374A9A),
    .INIT_05(256'hB9B00377132A2E535DDFA96AA5AD5AEF6CA11063EA58959552DC896ACA4A55A9),
    .INIT_06(256'h70D8058B874D98380AC0B199ABA830A8B4E6296469B37406A94B03651781CB38),
    .INIT_07(256'h292AB64D53F76B56775D68BAD9DD662A6B555417AACADB2860269DB95730A6F4),
    .INIT_08(256'h13D459F2EAAA57E640B5B9359204D5632E0E6F5BABA55952A880AC61452E2655),
    .INIT_09(256'hC357A45684B6192AECA0127B1036C72E7718A6E8D1B6CD382CA4605C51A900CB),
    .INIT_0A(256'h8AA5035B10FB90288AFA7E2E93A2E993B32538567531E5B0C7B40ADD6D8FBBAD),
    .INIT_0B(256'hA7FD28B795116453B202A8365F47DE46AAE2B481F185158214F158EEBEADD2A6),
    .INIT_0C(256'h52DE959BCC43EA335E11060AD522C99454B80E8D6B02AFE944BB8E8441954581),
    .INIT_0D(256'hE575EA929A5B4EB65E0529057A8441AAA6A445FE81BE1733215697C4E91AF5C2),
    .INIT_0E(256'hE2B658708E29D5CEC5817E56AEAAFA4D752457F6099D212483B2EAC677510B6C),
    .INIT_0F(256'h566A51117580978647B2EBD989545F885B4B57261A9919D6E05793D978539126),
    .INIT_10(256'h44B29B010B8591A0A8918D68265CF53E78E90BCC4BC542AB95CA297988AC94F5),
    .INIT_11(256'h1499AF2ED59498491790A536C7AA5D562048D466019D91B5117954B8CE78B56A),
    .INIT_12(256'hA56245363EC0B495535A2BDF00C4391242B54B4A84E18B46B4954470A928AF85),
    .INIT_13(256'h2932A8AB44411BDCDDD5353614B38B8AC142D4BB29D5E54034DD267BBA074948),
    .INIT_14(256'h9592B2757274951D2D75117B9AA587CD27D7680AAD91364B4F4AC524659152AA),
    .INIT_15(256'hC8B575E635DB5F2AA9550FA5207971C5B14D08993451345F57025B992520E454),
    .INIT_16(256'hC0E49FB57568A283954C826680B3A8AC345B589777292E35568769CC341561B2),
    .INIT_17(256'h6DAD5548B43F99AA8D61E4D341A8DC2DDCAEAD5D929761CC7DAF4B108379C724),
    .INIT_18(256'h335532EA51278EA721DEB0EB18AEC0B5AB3D21159595652497F7414247F012A6),
    .INIT_19(256'hAA5089D804CE65529932CCC2AAA2F477A088DAD756ABBCB6AE436A88ABEC4A1D),
    .INIT_1A(256'hD2E8A5A2433D639954197EE3D55A21139496668A6E56F8D9A36CA598CA326BDD),
    .INIT_1B(256'hA86F56A92A866CAD4A5B14094EAAB752DA2455A34729DA69542AAA8131121B40),
    .INIT_1C(256'hB224DA30A911AEAA9C5F653A6A9CC96B28A0DF58B9AD448A983A1DCE9B295DFD),
    .INIT_1D(256'h085FC9B5ACA965659696949C97E218A0E14ABC103CB49C9D2D572EE9496E66AB),
    .INIT_1E(256'hD15E0632C56FAEB2B40A3A4522D240C954B43174565D1EBCA03615DAEAA0D2D4),
    .INIT_1F(256'h5465A877AB95494D4841A536CC98489D65E4EAC6547110499AE28B0E177C33B4),
    .INIT_20(256'h534E0895D58612A56DA3C0C8AA3C2B422E7514A89347D436850E74CA50131429),
    .INIT_21(256'h8D2A605AB4A23A412A091D185968D3071C892B944D5268AA93CFD00B24B102AA),
    .INIT_22(256'hC2C68D6E4A60A911845426B8999D6E311FCADEABC6A440A2E2B9AD39E6FB596A),
    .INIT_23(256'hE541C55132A32745F562BAAF02978B5AD60D489675AD39156C60D8020A78880B),
    .INIT_24(256'h9606B3914FB4154AD6C176FC155CC7424FB851D549B8F9C2A6A2434B25289A5D),
    .INIT_25(256'h1AF2A12C6A64D2606B54CA162A2FE636FBA99AA994EA61534132D71B608AE50E),
    .INIT_26(256'h552D712D3AD5551ACA0975A87D25AD4E4A45D6ECD0AAD1680952CB0F4E5752DA),
    .INIT_27(256'h6EAAA275AAA14D8C1E5F52ABB55D494A8BBE4D54F5DEE5DA97AAACD29551DAA1),
    .INIT_28(256'h2B135AB514B82CEB2BAAAF2DA7D6A3B40EB14C5A30EB454AB124C952B5514BA9),
    .INIT_29(256'h94AA3D83B7B7A2492B63ADD6D05A66616B4897BD7FD2DCBB5AC5311A55249F66),
    .INIT_2A(256'h6215BECF1DC9EB0C8E5282952292954AD53352B6AAA1B25C9356DC54BAD76A48),
    .INIT_2B(256'h9A820AD40B17A39394752A64B4D4B10AE832D128DFED5131BBA55552096F6AFA),
    .INIT_2C(256'hB52056C6D6E2580AF6492D435A5CC74C5A2BB5AA2ECD717A5F54B26A7B284E67),
    .INIT_2D(256'hD5070AFABEB5DACAAA693558A152D65AE4EC2859A0A8B97B4CB15308A49235BD),
    .INIT_2E(256'h564AFCADAA5D9A756934B5B592A2BD6AB2934AA969A56D54D0D88885755556D7),
    .INIT_2F(256'hA956FC104B6CD36D274BE4A6B525355B66A68AA8A5395EA5D89957A4A4B5B859),
    .INIT_30(256'hEBC9324D39759A99AA6A65D78473F3439097461AA55556D267DF1424B492A52C),
    .INIT_31(256'h0AA2A34D352A8BD5FEAA7DC9DC309297455BBC5D6A4B2EAEC560EA196D12A85A),
    .INIT_32(256'h53A95625CAB407556A156B79A17D4136BA8F3B15941BBC955B6EA4AA62EB5C22),
    .INIT_33(256'hB093652A14BAA374CAD6B9B0B1A8CD3A245271A8422A2894580961C9728AD38B),
    .INIT_34(256'h5AD3BEA8D7B544EAD57149A9A8B45588ACD474D4D5516A513AA6555AA4A565CF),
    .INIT_35(256'h4AD391CB57A5A182A38DA4ABCE5DAE4AD916A224B4DC959AB6B1B1A6D5EB774D),
    .INIT_36(256'hC49174D495A749556F2A9CE2BA74E5AACB3D622DCA98B22A0BAF259A85AD6AA8),
    .INIT_37(256'hB5757A6B1D554A6945BCCEA028962AACCA34B7CE429295338CA91374AC24A23D),
    .INIT_38(256'h650A98D5B537AFDED57E6AAD2A8D72B5D52B4712626A69088AA13C523546A424),
    .INIT_39(256'hAD239790A1286E64A6B2A7E954D9795495955111A094BC1558554B58AA868EAF),
    .INIT_3A(256'h292B4852B508EB675952992ADD2758F69832A93A52DF8916DAD265244B77D89E),
    .INIT_3B(256'hAD55286D3AA94A86B14B512B348A5A4AB80B5257A54AA31F35025A68A3E49628),
    .INIT_3C(256'h2B56A6C748C31A368EBABD3CD0BAA693F22A28EABD0C2B88AAAD5964B236AAD6),
    .INIT_3D(256'hA491AD1F534EAAABA8294A905653C36D5765A6A512E9A0F961683D4A5BAA5655),
    .INIT_3E(256'hA1AA312554D05B555685358319F5CB9BDAC8C09A56AB6AAD7E6B9AC90ED4954A),
    .INIT_3F(256'h4F02C71660E9AD2ADD1EDDB4D79975C5DF2E5AF944BB537666CABE3F0294B6D4),
    .INIT_40(256'h1154A934F555CA95B78B6F4A558D542CD50A4DA8682F6795D4B6E62A69AA1D5B),
    .INIT_41(256'h2994B6976A8CFAA9577255D5AA549AD4FA51D39B44D3A573A9255D36EA9F5891),
    .INIT_42(256'h544AB66555D996A7723A43B55648B49428A894AF45AA2AD7BF2BE27CF5ADAACB),
    .INIT_43(256'h6853DBF958A0531234DD1410B6A8EBABC841A4A12F6564EA55A07D66F52969A2),
    .INIT_44(256'hEEAA4B76F6522553828765F6CE881BB876A56548F552B0AF253252B6EAA9FB2D),
    .INIT_45(256'h146BBD2AB3B7B56B5B65317862DB8772D556E955533AB5BD696646D4B2973362),
    .INIT_46(256'hBED95255D5B0B5156F5558B44D500D2AD266765C851B59762D722E955D8E675D),
    .INIT_47(256'h911F5D6E85592AB5526A84B37A0059AA955AD52F55AAEAEF94E96C6B5417323C),
    .INIT_48(256'hADB43482A9BA322D7B4552871688499DD507495B48C74296240E300DF952963D),
    .INIT_49(256'h29A6B16AAC5ABC926BB6D0B45F65F0962B7AA97AAB5AA9AEA95D554A4DDED6C8),
    .INIT_4A(256'h6DFADA597492AD659F55B5856995E24B9955B555B68B1D28725AC9AD9A9E8FD5),
    .INIT_4B(256'h53215CE716B52F5B954AEABDAAC4B29EB228295AAD9D86D71F10EA4D54B5A9D3),
    .INIT_4C(256'h25C2A61E3286A427AA6F554B6D955B68924CAD25116564A488C605B536B1669D),
    .INIT_4D(256'h36A570DAB80694BED24AEE56A5A5574AAD7DBF39B9142D5AC454392A95A92755),
    .INIT_4E(256'h4C451290969B688B57B522A16A4A8556AB9B6F09AA348AC925D4A558AE535D05),
    .INIT_4F(256'hE65FA93A22596ABD926777B5CEE295792AB76EC2A24DB26C6AD5F596B4D756AF),
    .INIT_50(256'hED5A695D4AD2A443F30A4D967D4C5328BDD22533CD81B654BFFAEC94B629A88E),
    .INIT_51(256'h5DB7429503A8890D21D4B5460154D4A66B481BF6C8B6BC6A3A7526E496A86E48),
    .INIT_52(256'hC8D2E6AB2548A2BD90BB636D96B136D8A7AA6A308434AFE9D92909374C24DB4D),
    .INIT_53(256'hA4566D8537AED395552A2CA4FAC12A96A9A5A51A58A2E5754B25D892D2A99B42),
    .INIT_54(256'hA3555BAAAB5CFD548F6C3966D26AAAA24AEBF215D2F8F54698888F6523B2AE2C),
    .INIT_55(256'hD15A9D554ADA85F24C95B5A30AAACED2BAB3849C4553AA96BF6D9CC55CA829D3),
    .INIT_56(256'h59597C24C9259A6D61C45455A2568B944AF35A9A95AAA8BD6D5AD8BABAAAE9CA),
    .INIT_57(256'hA154128AD1DB1D22B77F50428B2C1C495D290F3EAD31B9E3DE966E6A540BB2C9),
    .INIT_58(256'h778D6EB2050A5C9DD3ABBD6D5262BE8C1125AA151B0AE6D6AB6B6C935127AAFC),
    .INIT_59(256'h293171BD9B8106AE8242F866FAC98A35241264A970B86B775BB517A555D32715),
    .INIT_5A(256'h84AAAB5965469BA63CF3D8956B6BAB08455295555B44B444EA526BA44EE5C46D),
    .INIT_5B(256'hB65ADB1EAD5E2AB355544799522A55D5157374D6266D6AF35ED62902ACD450D9),
    .INIT_5C(256'h5B4972B2BD90AC9DAB6C5B7E90E955ACBD90654B18E25AED27B5A968B56AAA92),
    .INIT_5D(256'h2BB4CD56152B6F76B739A1694230ADB4BA890D57FA274EEB64603AD2A9A55751),
    .INIT_5E(256'h453B953C5497259D8ABAEA4ADFB2ACD68EE74BC6D6B29D6A8885C2055553D513),
    .INIT_5F(256'hA5D6496A9AD693C7594BF5961D85599B2D10F7CAA3A9D55DD16576326D494C53),
    .INIT_60(256'h356432236B3A852A999DD515CD725AAD595C6B729196C4EBAFD853914AAF5883),
    .INIT_61(256'hA512B53DAED1DAA2EAA506ECE0B16AD91A96559AA091AAD38BB3E7D22AC524A5),
    .INIT_62(256'h0D15288E6AA235EAB621ADC7646355554D0DB0DE8AD5EECAD4BCA2A435A8AB4D),
    .INIT_63(256'hC99C84AE69A745AA91A4C5DE6F4AA4927694918C1DB03AAB871ADA3BA8A0972A),
    .INIT_64(256'h30CA1498AB2DA4C36E2EA91DCEB5AE5BE20AA17141171DD1BAE65DB01A112EDC),
    .INIT_65(256'hC44C738B0DA87E2D6EC92E9505E534532A20B79C3917E42CD5252A5C7AD5628A),
    .INIT_66(256'hA8AB9B508ED49A055E269E46DDFC756A910D22A5CA14E9CB5548528E622D5C92),
    .INIT_67(256'h28E6A14F512522E45550C9BD39DBA1AA623DE2CEEAAD6AA8BBA32BC7F75A433A),
    .INIT_68(256'hAAB3555A54B45405B2DC0A9DC8544A8D29DE6649F8A10861D46F74ABB290AB95),
    .INIT_69(256'h3F9D3504D4EF2F3B36495B6854575206ACB695C6C650B3CC015290491D5B68A4),
    .INIT_6A(256'hC5A829A019CA68756C9755549DB2D04958E4ED6D1A2661B5C802455E91B17312),
    .INIT_6B(256'h52D58D2AA8A4D6E8A11F6556A8D5548D2E6E2B6051455F0D5AAD0D4500247D02),
    .INIT_6C(256'h4DB79E75D70536CD6A2959D12991AD3D5AED18944555D12B690EC6B590556D82),
    .INIT_6D(256'h45A465DC6A594CD2B3AA851AEDD6A72936D4AB397B525AAAE82C655ACAAFBDD6),
    .INIT_6E(256'h43AD6D64A6295C72BA5B37C9552222971596EAD6BB36CAA45FE696A55A749E67),
    .INIT_6F(256'h36D732120B9F252A899754C5D51B58B45A56CB20D19AD9BAF7556A571B8B6950),
    .INIT_70(256'h375515D2D2925574D5554B62D7082DA59683A98AB56AB67E9D68A15AF554CA85),
    .INIT_71(256'hF539088BD3F1454554A55557A1952A26F55A956977F47758C9AC1BA6E2A52157),
    .INIT_72(256'hAE552DD4BA54EADA9A97A2E9945952D56AE1A68AABD3BA7A62D5692F798224AE),
    .INIT_73(256'h4B2344CCAB55A565E758B5DC34FA2E6BE952092D585552BAACC8EBAAE4A8DAD6),
    .INIT_74(256'h596E1AD6952AE5294EA959EE9A6D76BBD34AAB54A4DBB5AA94C8AA4BC9616B2D),
    .INIT_75(256'h566AAA1855244959453489D564B0AA55E656B59F5947656A962B52F6BF56E4E4),
    .INIT_76(256'hDA26A9AA9A62B33AAB571A32985A939749D3CC7D552D2AAB9F2D5572A2AC7EFF),
    .INIT_77(256'hEBAA5EDB5456D44BAB9A9694F691ED77993D2CF95282669D5D5571546AA69DDB),
    .INIT_78(256'hAAF4FD06B5AF4D966A94B2ABDDAD6B6E97A7D6B4DCA4EB5554A6B0958DAACE49),
    .INIT_79(256'h32B54DAA72902E0AC54C98ADAB3AB5C5BCD55A95AE26AD5554EDAA2D57B67155),
    .INIT_7A(256'h9AAA8CBA49E3A4B21DB4D34CDDB4CF2E28159137A24AA524677895C2F7546FEE),
    .INIT_7B(256'h45D2DA652968F1295D55B126A09AEC4A256E04CC499C55AB7855FAC565556ABB),
    .INIT_7C(256'h54A329AAF6F556FDDD4B7555257495268E9552F5B94F5BB646A4950A3EA6DEAB),
    .INIT_7D(256'hFD35DE9451AE7B8E55503592A4C63CF75175DB916F02D75ADE6FBFA1AAAEDEDD),
    .INIT_7E(256'hD2CAA4A3FC2F74EAD56E6A5555E56AAD4ADBABE2CF155B5975174AFAD6EEA549),
    .INIT_7F(256'hC990B16B253B1B0B32AAAB1D7CADAFAC9573872966BDBBAA6AAA6B3788E994D4),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized0
   (DOADO,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    addra);
  output [0:0]DOADO;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input [13:0]addra;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [0:0]DOADO;
  wire [13:0]addra;
  wire clka;
  wire [15:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hAD74D2B240130A915A3AB679FAA895B0EEA2C56D41EADD558A0EDF853AAD9892),
    .INIT_01(256'hC9C2AB2B5B5494895BA7D93227B225D55CD45F0846CCAAB4B2B4D4D5489524B0),
    .INIT_02(256'h6AA8AB09EA515D47B695A8948D2A595149AD49232BE5DD65478EBBD5A977A8AA),
    .INIT_03(256'h000000000000000000AE1AA6C8D5689555DCA92A444A8D79C755AAE2AA3A97D5),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:1],DOADO}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ),
        .ENBWREN(1'b0),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized1
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hF3EF9195AC84B24616B2C666662AC5A3325A49ACDCA4C526DEC96636296CDE1D),
    .INIT_01(256'hCB624CC459994F566669506024B0AD194C93A733C92C8243546A56B2858924AC),
    .INIT_02(256'hE105FCCD2C4D2D5532549301BA8B8B3317F28530C9A94D66984CC468C9395369),
    .INIT_03(256'hA649E5A1594D0ADAF16564DA188E89E4CD39ACD12B127334996C934504207C8E),
    .INIT_04(256'h11490BB330E5CCE531CC6A985B3874CACEA15D119CCCCA0CC8C16B33493A5714),
    .INIT_05(256'hD12A55AD064C8B661696C5FA514A6255A84AB4B54A6DDB199A8EEA416C6D67CD),
    .INIT_06(256'h256D5ED12B96455240A254D2C8AC95FD2AB3525DB5279ADB2B4119D1A92AAC50),
    .INIT_07(256'h724B1A97095A4264A22A32A94C954ABCCD426D05155393AD2B54C9EBB5AD2CA2),
    .INIT_08(256'h86A692AA8CBB72AB6A931559242A86424AAAA59D52C76260ED299B2976440CB1),
    .INIT_09(256'h559AE975822B51EEB512A4B2B55DAABB2352B5A565552992AAF4FD36151A2A51),
    .INIT_0A(256'h6329529232929D4D0052893B2508934B2586AD31212B56159290C63356A93149),
    .INIT_0B(256'h354A7922DCA5CE05DB284ABB55854A6FBB56A2E8DAB45ED459BA1249AB0B498A),
    .INIT_0C(256'h698D1836969ACB65A8A8AD4751A2A37555116329D5ACFD4A2DD299A1CAA966D5),
    .INIT_0D(256'hC9E150D5CD15ECA32B5254AB5321EAC03485692AAAEB22A2185ECB9AA354A755),
    .INIT_0E(256'h5A25132A2A85295A2AA4AA524B4A6775F9B07AAB24B78A4AD6E5A6D2F565AACA),
    .INIT_0F(256'h1773689559C9252E97214AF1527896C411965ABDACCCDD72A5556154C90A2468),
    .INIT_10(256'h5585CE55522F5B322A48D554FC9A5E9552B192A681768FC926BCE8D494D936D5),
    .INIT_11(256'h444A3A489D752D6B5AD5C8AAA94B6A650A8D96ABCACD511A580DC9903216B131),
    .INIT_12(256'h51AB16648B6946247516B9522AB695A48B296A5BD68D726AE8D996CA6B4E8934),
    .INIT_13(256'h2DA34D5A6AB4B284999E15549D05DD24651AA6D1B0965196A69673557495E355),
    .INIT_14(256'hA81B3B58A6AED0AE361A9B554AF6CD61912A415328B4AC64922FB59D1C845BC3),
    .INIT_15(256'h6C74274E596F758C0B825ACE6AA24368A8D5BD2D1A7A7F6A4294AA4D978AAEE5),
    .INIT_16(256'hE5B6CAD8512D8F328199213254D521890CADD22DDA424A9044D2556A2311AA88),
    .INIT_17(256'hA7491791A6974D73A60AB2BA533294B690CB396EA79A6756A90AF8B2CAD16D90),
    .INIT_18(256'h263C9B4CCBCAAB0C517B20A6B5756AA1C869B4A93A894945255592617D155B32),
    .INIT_19(256'hB2C4CAD3A168D7343067A597868B5122D62D925A15A9296346A9CC25056470AD),
    .INIT_1A(256'h565542D365D42A72B8BBD4A92E4B4AB1474455A4AA03AB52CA55CE32D1894694),
    .INIT_1B(256'hC2B544D5B0D348C892EDA913ECB35A0B934C993695B28F4CAAACD8AB6B870FEA),
    .INIT_1C(256'hD1A96B5ACCBAF2A43515092E9355AC4CB5B295912CC9A9DCAD53568B08BB4956),
    .INIT_1D(256'h61749CD8E6D9B34D231CBD89BAA52A32B518E945560846594A2D8B5D853B4C0C),
    .INIT_1E(256'h4D8B0C64D13B3B1934DE52A32832F5637EE165AA84066C29172B5B6DA99B86A5),
    .INIT_1F(256'h7234ED5B32186316ED6AC9A456D11D2DB696B46B2EABBADCD34B2964A5EE92FA),
    .INIT_20(256'h5A14A23966D4D481B535695A5954B5D4C7D0295225AA815B29D5655319477D4D),
    .INIT_21(256'h2980B55324CB5D15B3ABB5AC9552DAAA2AD598C1566B4AC8269598218CD8B0B3),
    .INIT_22(256'h688B55CAD3B64BAB2AA54AD6CAAF44A58B5E543563D15549480D08A34C1F0B4F),
    .INIT_23(256'h49248AE4671A4B5159B6530A55DA947243564CA2D4F9A949594A8A175F561ABD),
    .INIT_24(256'hD35566C99A2506146B5453AE98AA559365EAF57B5292556B4A14D65250A44953),
    .INIT_25(256'hBE2B3AB44C499B74FCE9DC248CBBB4A46AC2D23186BE3260B5A79A1A25D6A0E4),
    .INIT_26(256'h9BF65A7632999652EB45D9CA57313F8B1C5A6489520205CD519B6B776EBFFAEA),
    .INIT_27(256'h48C2C776F33A6D16B3CB633DC995AC0CDDA16E98A0ACBD6CDACD4942D964E0C9),
    .INIT_28(256'hF06354E4594D2F42F33F33B6D67B27D6AADA697AB76E7668D1AAA598DE6992EE),
    .INIT_29(256'hD68AAAA3DFBAE8ED8D4BAE04996D6575B22D192FAFA36ED99376215366451F87),
    .INIT_2A(256'h55D9D4EC55EDF3ECDB641BE5B4DAD96F562797C4EB36D7E927981EE32B9F4490),
    .INIT_2B(256'h22C15AEAAC22CBA7253A20A92CFE9A534D6569AD96E585A5D12B99BBADCA52D3),
    .INIT_2C(256'hDE4A1B64FB546257B411CE6A5B5572695372D9CCAB69D99D79A6DABFAC4E9245),
    .INIT_2D(256'h59DA78B31BA6936CCC4E7EDEB1E4849C08B6B2A23CF26C52113A5A5297235ED6),
    .INIT_2E(256'h530A5136CC96AC667DA55AF9C404B5BEDBDB8CB24D364866996452B6559E7477),
    .INIT_2F(256'hC174AEAA6C26E5B6059556C72461F9918BFF5CCAC9BD5AE75ACD9A350639329E),
    .INIT_30(256'hCDED6B69B266BCED2C8D0964C11BB46AEADD8BDC386F9B65579DA146A6DB4FB6),
    .INIT_31(256'h3CBAB7944654AD9939205E8D7F3A5B26218D0957937DD4CE898A4CD5C9D4C66C),
    .INIT_32(256'hA53264AE6C395459CCA403ACCA558B9B23AE5A46C66BE8E5924AC8B345521873),
    .INIT_33(256'h1A25D9ED2632CA59ECDBD2A421B2764CC69E623164B34EE96E92429DBDCC652D),
    .INIT_34(256'h935DA4B05ADB88BEF645512A3DD549123098989966E7B3122CCB6678C73178AA),
    .INIT_35(256'hADC4448E6BF5C90CC91AB52C93612B6E9D97372E969AF12D393ADA23698FBD8F),
    .INIT_36(256'h651A5966C8C58D988BB716A82B6EB92D625624BE6CE15AB0DD3A36DCD5094CCC),
    .INIT_37(256'hDAD9A37DA667ECB181281B2542E6B52990D918746BDB2626D6FDBDDECEC13451),
    .INIT_38(256'h376F2366D62575AC85954BC84CDA24969933EBA4B4B08DB354CDAA8B5A6B28B8),
    .INIT_39(256'hC985DADD3532B37677233F7C6693ADA4391D853AF4D92E99975A6182CCE5299A),
    .INIT_3A(256'hB232136525DDCA546076D47295BA5242CD43059C64EFD2842364B6488DA552D4),
    .INIT_3B(256'hC679B2B65CCDACECD2727A3226506360B2AB639B09D5262A1BAB6F412D39DB74),
    .INIT_3C(256'hB9952C2751CDAC6A2F0FD5AA5A5CCB15B4B32D331646FBD133396DB6DB473364),
    .INIT_3D(256'hB6D9298F9267CBB2CDBDECDA1BE79508672934C99AB5ABB1B5FEB6733BD3DB65),
    .INIT_3E(256'hCBD35DB67D055264542946D4AFFE93D310938AC363CA4CC97853D44D2776DE6B),
    .INIT_3F(256'h6FABBDBCB2BCC9B28F2B19E6991DC996EA3C83EA152D8424B49C94C63CC2DAA6),
    .INIT_40(256'h5A6131B9587990D9C2DFC66E9916668B5A508ACDB2C5B2BF9EB4876CAD43D194),
    .INIT_41(256'hCD4D2725F3A9530D9E4366973366D298D4655BBD895DE7BED3B606B8932A6ED2),
    .INIT_42(256'h688B274A990EDB2E642F6D5B7851381EB13EE6C56932B3669B8AA83645392B69),
    .INIT_43(256'h4B939EED9CC9FDFB67695F66CB34934D716AFD4A0A66B6B299C22E73C04D6D25),
    .INIT_44(256'hA94C802D236431F2C2D5A9E36A12A3D0DB0A9791D95AA4CA48249BDBBCD85176),
    .INIT_45(256'h845D2982E1D9B54A1277A3FD4B6CD6B29666CD9E623CC129B2449766DB261AA4),
    .INIT_46(256'hEBB16AA666A55A164E6792D865FA5C336B5B5B6A16720224A9A76B2669134A69),
    .INIT_47(256'hC19D8FAED9868CD864BCDAC457556DCD266A99DD9CF4BED2276D8873E75A9F36),
    .INIT_48(256'h36DE3F1437ECA442AC56652594C8929699ABF66DEDB5AB188D2EA28DD0630547),
    .INIT_49(256'hB243324CB51F6ADA76A426D89E24A59AB7D5515C32FF312F3255996A171C7A8D),
    .INIT_4A(256'hB16C8C7E492749800C02D92A33C74B57CA18FA663B2F66335B6D6ED60D0ACB1F),
    .INIT_4B(256'h7A39F957AB285C68F9ACAD18B498D8DA83409C6B37D12CB3B5A4F76DF92531E3),
    .INIT_4C(256'h57D4D47CA4C8CE75F34D9912013E6C40DB693E28594A46312C97A8DA64D9B7CD),
    .INIT_4D(256'hA4C95A9B32171E349B909444C9C59D92C9B5FDE6DE24B79F1A669DB2D93DA59A),
    .INIT_4E(256'hA966A4D51A134C8D652637344D94E59B3531B755335B2FA2B76AC99334A01549),
    .INIT_4F(256'h36AB2D1083024C235B4A64A9AD75DBA1913A8C633496E8B64F5ED93C5896674A),
    .INIT_50(256'hCB9FCC6992E4B66564554DEB75EE95F12ED08A4B75C92748D5D84ED974CDCCC1),
    .INIT_51(256'h16A7152661315DA647E95A948A51661CADB15FAA6AFD691D52BA3B169BFB4B0E),
    .INIT_52(256'h92E4C5F7B66A4FFAD93A4BB4D5DDA4E7CB334CBA2FD904A1C9AA20619646918A),
    .INIT_53(256'h365B4FA9B7071B25A639494AA28B8C9CBDA77B536D31CAB9534A75E764F12D90),
    .INIT_54(256'hCC486ACCF369A9694D4951B49B4CACD3133DE55962AD4656DD13D2480124CB79),
    .INIT_55(256'h5A4CD9966D93293BE926D9D5B33484A32032C6C6E9EB22DE0DCEDE666ECB3164),
    .INIT_56(256'h9E11F72BE9B52CB7EA5699598B7B15D9635A6C8F5F3332D4483C950CB3B2B290),
    .INIT_57(256'hC8E0A7D359921130F7BEE494D6FF56915DB22B98C822FCCB7927457F5ECC2B92),
    .INIT_58(256'h992977A56A8C110913B2F7BE74B408D65D4733599228ACE4D24F76FA7D09F3F2),
    .INIT_59(256'hF2A6A53E86325B343494CEB3F3162CB6B65B76D25EECAFA66A963ACE6A9BAB9B),
    .INIT_5A(256'hD690C2924997CDE464655EC02D932C56F79FD999D3A5368F6C9BB2C86B0EA47F),
    .INIT_5B(256'h246F722F2E6913324578B99D8CA258EA6877F91336B74B9E58833D5331291CA2),
    .INIT_5C(256'h8D964010B92ACAD64DB8AFBB6A4DE7382EE571526B446CB6C6A7B1CEDE8CCB1B),
    .INIT_5D(256'hA2D96E7B59B275EBC45BD5B3A2A530B9932D86A2B04B5756388A51D4CDF5ADAD),
    .INIT_5E(256'h19B3EA2E62C7B7196AB34C6CEBC4F764D7346D6744DB6980CE2194A6677B51BB),
    .INIT_5F(256'h39986DACD394DAE59255BEDA562E5DD3B9A4A59305AD666A955576A44E4A3744),
    .INIT_60(256'h5889FB76B5AC318310916246AA6452CE6C94D25025549681C6109A1A62F569DB),
    .INIT_61(256'hC9B8D9D6CC9B73374CC9CF496A25B37E56DB4523C6E2CC97D3354C7AB317B6D6),
    .INIT_62(256'h57DE424454B46EAB2CB40D75B6A534AA1CDB685C2F5CB590720E437166824469),
    .INIT_63(256'h540155ECCCC552D44AF29956D66E5436A5561A8CAB3956ED234C651785283991),
    .INIT_64(256'h7A882212A59912B53A9533A83334C811A65CD52AD55A4AE5388AC175B35AA999),
    .INIT_65(256'h17616953893D55762B9B8A2144BFAA65D146AAAB0B548CC6D782F119128A339C),
    .INIT_66(256'hCA71CE56DA1ED356174C2B13594AD82C44574B01616930926F921565933A6A39),
    .INIT_67(256'h115C34845A0977351CFA9A4B2F5D6B2ACAAAB766142BA008366BA212A958A5D2),
    .INIT_68(256'hE3A5ECDB7A4614A92092EA969B546DC64D580B6B7AA81D4B48A4D83AE8D2F698),
    .INIT_69(256'hAD069650928ACA4DA06DCD12851ECB54E4633F525D759636BC245A25B99622C9),
    .INIT_6A(256'h6940B10D5D74B62687C261F98964951552CAA7A42D4B4A40925715B025453655),
    .INIT_6B(256'h5B96167D4DF6954D354729FF291A9A59AB78D24AB196358992C95595AD49C86A),
    .INIT_6C(256'h8EDAABA6A38BA496CCB16D634CA6A9398DA9BD3861211AB9CE5594C106994153),
    .INIT_6D(256'h96360A98EB62797B3BCCE65BA99EC84DA4E933B16D9B6CED4D4949908CCB35EF),
    .INIT_6E(256'hB536F63104B216BC1C9D256D99B74BDA9924B0FB72547CCB96B318C90C591487),
    .INIT_6F(256'hA6E67B5B44DA4BCCF5059A96D942911A6C8B6E4B05336ECCE866736442D23062),
    .INIT_70(256'hB999A5637ADB667E998195A5444D36C9272535D319B32755D64CCB625A59ACD7),
    .INIT_71(256'hDA5D52935BCA686666CE579935063377591329B1D8F95E6A9136AECBF5864D82),
    .INIT_72(256'hCF2949993C96B2132ACB3372D86D84D9CCD5CCDCCF9ADCCF4499EDB5DD24B6C8),
    .INIT_73(256'hA5B268D6C39E267689933A993ACCCF4A31976D8A5299E32D496CB23348B193E4),
    .INIT_74(256'h9D4A939F2653B6324ECE53F52D45A715E4130F9E37629933012D8B756D8B4A29),
    .INIT_75(256'h64718CD569876E6A7DB91567CADDB71934A6E62591F64E4CA4B56777299A8D76),
    .INIT_76(256'hEC4F3D0CD3533A2F321AA0A32C9CDB2596E688D9DA4DBC432E719FDA331E55AC),
    .INIT_77(256'hCD346D1168E4E56D335CC518D4DAB9DB11A5B52E8B9374D66999BB865374C89D),
    .INIT_78(256'hF37969AB26358F24B0D6E73B96D1B13719C95B269686F27E78F720E7353C9373),
    .INIT_79(256'hA7466ACC9B198FB49619CCCE722CD992D6679CD9F03CF66666BE4E4E653D65DA),
    .INIT_7A(256'hECCC093392BAC924BAD95C6956DADBB74D26CBA73493464EF7AD19E4E667556F),
    .INIT_7B(256'h81D49249B26A63BA6996D9B7FADF496C4935A999521696F25266AB61A9664CDA),
    .INIT_7C(256'h652A7C0CFB5996EB666FA79987A7D9BB28A674A71EAA13DB4B2A2603970C1B33),
    .INIT_7D(256'h5DB99326953F5CDF99A9A6A4E94B269982994D2A4B8B6A6A64B65B48CCCCE886),
    .INIT_7E(256'hFB6BE4CDFC4F46B36AA40367D5764B39ACAF35B36E191D93B655ECDBE757F66D),
    .INIT_7F(256'hE71B166669A24E5654C33229A6CECED8395B1FAD8438CADC4B0C49662ACD18FD),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized10
   (p_35_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_35_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_35_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_35_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_35_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized11
   (p_31_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_31_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_31_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h1A0F1214061618070610081A0D180712141A1818130A170F1800000000000000),
    .INIT_2A(256'h08121015121905060519070D1A0C1909051916090E08071A051718140C000707),
    .INIT_2B(256'h091A151A14191019001517121A070C08130F1419170715070909110709190000),
    .INIT_2C(256'h07160B140A0D0909060614060F0F00101A070809170910160600170F061A0A17),
    .INIT_2D(256'h0D001507161807181200070513101A190000051605150A061000090517060612),
    .INIT_2E(256'h071916090B05050F11071A1307190F0F0705160D06070A160A05181919170A00),
    .INIT_2F(256'h100918000A0A07071519091619081811080A1819111A1419050019141018051A),
    .INIT_30(256'h14070B0000141505171719191800001909150910061905061A180A0600001417),
    .INIT_31(256'h0A0F0C07100F00090D1A1106071300150A0C051608070019151916191800000A),
    .INIT_32(256'h090711091700181619171715151A191809161919060B0B140B100508190B090C),
    .INIT_33(256'h1A06151709191617000012160B0C180B0719141013000F080013191407071817),
    .INIT_34(256'h0C080905180F190A050014100C060B1906191A120018101314071819081A0709),
    .INIT_35(256'h10100A10091010131018170019140519050E140015100500070F0B1409171805),
    .INIT_36(256'h0A00001707101010100810101913100F071810101010160810060F1019101010),
    .INIT_37(256'h0516090017151500101408150915140A09170706120907060611121219061619),
    .INIT_38(256'h150D18190517150506140C06070A1A1500140918181912171516161A1919001A),
    .INIT_39(256'h18190C0F16170D160F08141700191A171605161505141A16180F000618101814),
    .INIT_3A(256'h071906180F14071416051A1100071A140805170D06090009060A12070B1A1619),
    .INIT_3B(256'h1A0506061607121307090B0A13190616160518100B0808180617000F14190A06),
    .INIT_3C(256'h141A18091313131018181010150A051A161512181A10070605180700170B060A),
    .INIT_3D(256'h110F17060511060812170B1906180000160A0619050007121617050608071500),
    .INIT_3E(256'h0514161017190810090E19101319120618081508001A0E120B08001007151205),
    .INIT_3F(256'h181011060F190513090D0907071A061606070A1000151010061000170F171006),
    .INIT_40(256'h18091A080906181010080610061900060F18141A05140717101708170C101918),
    .INIT_41(256'h001618191611160607120615070B1200110A18190B1515160605151806080F16),
    .INIT_42(256'h070D0D19191218181A051808161817050017131116191105070F15070D180810),
    .INIT_43(256'h14071A0E0707050F08100C171017070915071000180A10081A06090018101918),
    .INIT_44(256'h1508170F0F001712121609060A18060B1A101618001816101010181507161907),
    .INIT_45(256'h120A12171615000F12071516111006160500141212151906060E0708111A1807),
    .INIT_46(256'h161019131816061018150518080B0A151600161A181017121310160813081015),
    .INIT_47(256'h121208100A1819180719180C16000006090C19060F16071A071210101617060A),
    .INIT_48(256'h06081514181A17110816161819141912170C0016000000140613151807061809),
    .INIT_49(256'h0B13131316160909051A18181908141A1000141A1619190814070708150A090C),
    .INIT_4A(256'h0B101518191500001A081A1A060009191214181900150A0F19190C15000D0700),
    .INIT_4B(256'h171700140A0900161A170707000619101A12000D1206050A0910131511161A16),
    .INIT_4C(256'h0C0714191917160B1A0A091813050A110A001906000E0D1A1313191511071407),
    .INIT_4D(256'h141919190B1A0B0015170A12110500000900150A191915181615171110061819),
    .INIT_4E(256'h131913140500111513070016071513191A1900000818171310151A0B051A1100),
    .INIT_4F(256'h0A09140709071A1A171919151014160F1A06101518191A170016071706001000),
    .INIT_50(256'h1100171800121A06081308070C0615050A001307101014151415161018190B00),
    .INIT_51(256'h0F0812191A1400141617001907080709090B070000181A0918000A191A190609),
    .INIT_52(256'h1307191A0F0014101518061719111206161416060913101816061606120B0919),
    .INIT_53(256'h05100F100F10141715000B19180500160806070A14070013001A0A0706110505),
    .INIT_54(256'h1010101610170B1017090F0F16100F101010101007060F160F19081010170F06),
    .INIT_55(256'h15180806170C1A1919190608190618131A080806150706050710151A000F0610),
    .INIT_56(256'h160616001807000007191815130E170000001516180717181909080510001000),
    .INIT_57(256'h05181919171019101405000618150700001516171A06080A00190F191A001417),
    .INIT_58(256'h1909121017161611051A13000C1708190719150F1917101013140719080A101A),
    .INIT_59(256'h0717151A06081600140919000E160707071A0A06050506051A0F150D16081618),
    .INIT_5A(256'h001A190C1414160817101408070000191316141916191506060A0C1109140700),
    .INIT_5B(256'h1710171818061A0F100914151A19180F05130F080F0900061710061900100707),
    .INIT_5C(256'h181006081517141A0017141817170800150F181010191914180F0815101A1310),
    .INIT_5D(256'h19071A1814001A18061419160A07061219001919130615111513130711181517),
    .INIT_5E(256'h06080A1805190F07131917171216161207101715120008000A17191710170007),
    .INIT_5F(256'h161506181705090805150D191A1914140C0509050000071A001519060F100814),
    .INIT_60(256'h140F0E18070B0807061A1718061A100D10151A1112151617001505101919060A),
    .INIT_61(256'h06060A0015161316181308140B14090606171716100616001008181610101010),
    .INIT_62(256'h1614151A1A15180B18101310101A111418081619161600180819081916090706),
    .INIT_63(256'h1816191410180017111A170F1700141A1015061014130A001018191810140914),
    .INIT_64(256'h0D0C1717050C1815141417100A1000150B121110110C18061210101910191A0B),
    .INIT_65(256'h19190006050D150F0C080A191906000909150F10001412100A07141916110012),
    .INIT_66(256'h0012051A090C1A1A08180B050A0F050D000A0706150A0906120E171A1805150F),
    .INIT_67(256'h13080C170B0F141A1410101A05100A1600081A001A081A1A14180B1707001718),
    .INIT_68(256'h19100610061610170910120F000B1A14060C0D0B060016061A09070A100F1008),
    .INIT_69(256'h1819181116100B0710000607170906101A060D0B060A180709180618100E0607),
    .INIT_6A(256'h17150D14150A0015090605060B050F050605080A080A1906070706091A0F0F14),
    .INIT_6B(256'h090E0517081513000013180A1516100608081519190D170C1616060B08050519),
    .INIT_6C(256'h06140F0C1A17001907180916161810191910050719131319051A080017181613),
    .INIT_6D(256'h100F090F1A0F0C07001A18150D16141A151300071808150F170817090A061614),
    .INIT_6E(256'h190010061718180D1819101005180F1400071910140D1605150A0F080F0E0609),
    .INIT_6F(256'h171610051706001818151808060B001115150608061110130E070D0E1516090B),
    .INIT_70(256'h100B1A0B190B0013111906121A06160705151914091205051906191812000014),
    .INIT_71(256'h0F0910060610001010051519190A071713180510061808160509141807081910),
    .INIT_72(256'h10151910100610190D100F1710101410100F061010080F08060F0517100F1A10),
    .INIT_73(256'h1409190F19080F0E101510121A100A0F0E080B001018130F101010140A10180D),
    .INIT_74(256'h1510071A1417181015101019001815080B0500190F060C1A19080F0705171906),
    .INIT_75(256'h16070D160F100F05190014070715060D180D161A16070D081110121406061000),
    .INIT_76(256'h160B17000F06101006151A160A1010180F190806001A06181A0009151A050706),
    .INIT_77(256'h0B0F0010190F1905061808191105110E1305140B1306090914130B0D120C0F10),
    .INIT_78(256'h12161216001613131819000C161918171A0A080B19190818170E070B070A0F13),
    .INIT_79(256'h1A0F00091815100714170F170008071810190F1711050017180D0817050C0614),
    .INIT_7A(256'h13150F0D17170B160F0000000609170614190900000A170C06060D150708090F),
    .INIT_7B(256'h160F0800101A120F19101405091719150D0F17081610090A07100F051617060B),
    .INIT_7C(256'h18130D10000A061A171310171308130707170007190F120C160D150B1913060F),
    .INIT_7D(256'h0A000A0D0A09090C100D1008070706000D150F0D0618081909060807180A080F),
    .INIT_7E(256'h001A07060B061919120B061908001516090A120A18080705090B0D060E0F080F),
    .INIT_7F(256'h1A19061609130000090008000C0509160E070007000D140D0608060E16101510),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_31_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_31_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized12
   (p_27_out,
    clka,
    addra,
    ena);
  output [8:0]p_27_out;
  input clka;
  input [15:0]addra;
  input ena;

  wire [15:0]addra;
  wire clka;
  wire ena;
  wire [3:3]ena_array;
  wire [8:0]p_27_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h08060F090919180C060505091A0A17160B0606060E1713150A07100607191816),
    .INIT_01(256'h18171A0F0D00150017171300181916151A120919191517061608131400081006),
    .INIT_02(256'h130A120B191707180F061706141808120A050C151108100819131A0700190617),
    .INIT_03(256'h050F170C19161005151913071908050A101A130814150515101600000F121109),
    .INIT_04(256'h0707080015191209101A1915181813001919001918111714080513190B001012),
    .INIT_05(256'h070B180519151409191816061612150F191914191A11160E12150D1805070514),
    .INIT_06(256'h131A0010121210140500121708191111150508001416111413170A0616060019),
    .INIT_07(256'h000C0F160F10150A000B0713061608000809071910061A1607140C00170C1912),
    .INIT_08(256'h181605071705070711170C18080606180619100D180A051300061A170C18070F),
    .INIT_09(256'h001A0F1609060818170907060706070708001A00180F061013180A08191A1918),
    .INIT_0A(256'h1808150711061207050F17181618150F0B190618061809000A071910000A1809),
    .INIT_0B(256'h1A10130818161810191119141618181A1613181918180012180F141A1514170F),
    .INIT_0C(256'h1A0C1400100F0A131412000609171A121A13060916110019160016080A171819),
    .INIT_0D(256'h1019161307101A0606181005190F0A080610160D0018191810180700100C190C),
    .INIT_0E(256'h140F0F0F060708061506180705150B080F1A081012160F1A1917191707120006),
    .INIT_0F(256'h0900061600060F1715101414131908100819051414170016190A000E15131115),
    .INIT_10(256'h100F0A07001710161006100B11160812171008000C18131005150709181A0014),
    .INIT_11(256'h080F100F12170F1017100C1009050F0F101810191209100F100F101317100F19),
    .INIT_12(256'h1714050707151810091614070819081912141807060A08000F0819190F100F10),
    .INIT_13(256'h0A0618181617070A060C171914001318051507001A001A1A19150807071A160D),
    .INIT_14(256'h0717130A140A13150718151A111710180A14181706001318130F17190A101419),
    .INIT_15(256'h060C1A13060A1A0B05080D19081805150916130711000F070717150710190515),
    .INIT_16(256'h1906091918091306130E0000101014181917131800100F0F1807110B06130510),
    .INIT_17(256'h15051317150807141A0605161107101A17161218001909101510061409171119),
    .INIT_18(256'h0818001A0606181A191A19000F1018061815161905131416191811071A110618),
    .INIT_19(256'h1613101917071013101500100A140B0619050D10190F060C0A0A1712070F1806),
    .INIT_1A(256'h12171900101008090F071705190610101410050F0510101A17101A07100B1810),
    .INIT_1B(256'h06170D05001915190C07161713190D0716001206110709090505121607181216),
    .INIT_1C(256'h1712001A0700190005190B1909120615100C1209060F14101608191700100919),
    .INIT_1D(256'h0000150010150706000A160D191516170B0C0F070B090C1A0F1506081406081A),
    .INIT_1E(256'h09000D100B1613090506001316141815060606081A1910101800081913181908),
    .INIT_1F(256'h1000110A061A1707060C091A1811061616100C11170718190F06000605120718),
    .INIT_20(256'h18171A001A0613190714170F0F160612140006090913080900190A0D06151511),
    .INIT_21(256'h160A1A070F17171110081517150916160C100B18060F06090D13081017081308),
    .INIT_22(256'h190F1608060609090F00100D160F130D10091910061207170818171517001608),
    .INIT_23(256'h081712191A170D161706060806140F1007170F05071606001414061705100816),
    .INIT_24(256'h14131813000510090719060C070A1705060714190615000618151A0D18141716),
    .INIT_25(256'h180613121712070507060B0F071818130519080F1707000B190D070F10070718),
    .INIT_26(256'h050A06070A10000719090606171010061017081708071400180D001617161106),
    .INIT_27(256'h101A0F08140500160F180819070715141813001308170B10000000181607080B),
    .INIT_28(256'h080F140F0508080008060D0614070008091700191419100F091016000007170F),
    .INIT_29(256'h12070500091019151A080017120611100F071909121A0616101A170600190805),
    .INIT_2A(256'h171A181518121A13191610151A1A1A1617170810151A181A1000160908140605),
    .INIT_2B(256'h081A0B000718181910091816080013151A120D181918141007001707081A0E10),
    .INIT_2C(256'h1708181619071609081A0F0806090610100D0B150A19130A0B19090000140507),
    .INIT_2D(256'h141710100F1607131019161008060D1A051518101A001706181500000017160F),
    .INIT_2E(256'h171708101A08001A070614190B0707001217091719060D18191A0700081A1319),
    .INIT_2F(256'h151118190E15121A0000080A0706100807131819181715140517070014100519),
    .INIT_30(256'h10111009100F101018100B170F0B0F1110101A100F1A090F191A070F0F151000),
    .INIT_31(256'h18171A1919071614061A17060707070F0F0015170F101218101A0A0D0F141810),
    .INIT_32(256'h19190E190710050F10191419190900151A101A0C06071907160900131A190A19),
    .INIT_33(256'h1217180D071518170C1A1507100019190B18061300170B0B150F151900000716),
    .INIT_34(256'h1006050F1305150A0F00071907120A0006151508071514160619091516081315),
    .INIT_35(256'h061A1017070F08001918080A17070F130F1000101A0F08130F1A0A0907051A0A),
    .INIT_36(256'h10100F1913140F060A15190F1514141A16160010191712050B181708151A121A),
    .INIT_37(256'h060711080608151306130009150610191017181A15150B19061514151019130F),
    .INIT_38(256'h170709151A09111A191617170006090518060F0F100D09190606170A19070700),
    .INIT_39(256'h180F1813090910001010090F17100F05130509160F1007070F10180710071519),
    .INIT_3A(256'h0007081617160516101A160A1918071908090F0718130D0F16190808170C1514),
    .INIT_3B(256'h19160E07060C0F1406181806130613160811080C161A0C0F0F0E1A05180E1706),
    .INIT_3C(256'h16060812161507120515051618100614170600170E18170808120A08070B0018),
    .INIT_3D(256'h150F0F18170C090A0C15060F0F08090C10060608160C181315160E170006160C),
    .INIT_3E(256'h120917061813110E19181A0A0B130712060811161A100808100800180A0F0000),
    .INIT_3F(256'h161A19071A070D190F1A07150C151A151217141410100806000009100F130F0B),
    .INIT_40(256'h0F161810161417120615140A0A171018090F1809190814001A06141618061005),
    .INIT_41(256'h0F10160F0F16180705130D17100F0016080B0F1A0F0C090C17180A170B0D141A),
    .INIT_42(256'h150718131514050C0916101219001617131813110D05160C100717170F07101A),
    .INIT_43(256'h061319090A1913170F001006191800070800160813060807081016150807130C),
    .INIT_44(256'h080D1609141417091A1800100A1705170A0600110A17161819161317180F1416),
    .INIT_45(256'h07080C191A000008160A0A000514081518081910181000171206161811181011),
    .INIT_46(256'h051708170718131A1900170F12101510100815060B060817000619090010100E),
    .INIT_47(256'h1009001500120F001707190506100717191106170E10141918070910150A080F),
    .INIT_48(256'h18190D0900071009091916000917171210121318190F1A080B180A080018120A),
    .INIT_49(256'h0615061818141819071A0014170F14060506171607171900100914141607170C),
    .INIT_4A(256'h101A1909170715001A190F0708060B0608081405000009050806061617191719),
    .INIT_4B(256'h08190B1A09060C0C130900100F1215130B181A1812080718171A0A170A090719),
    .INIT_4C(256'h0C0B19100B0509050A0D050D0A000A08141607140F1A071A101716141A131817),
    .INIT_4D(256'h081614140E0013130512001416000F0D0A0F0010160E00190800000B0A0E0F0A),
    .INIT_4E(256'h080F101A1007150D1300161709071A0B10101512171A0A11171618170E171710),
    .INIT_4F(256'h100A161010090F0518101010000F0500051819100506140600190600060A060E),
    .INIT_50(256'h161814000F08060F15081011100F140C19100F171510090F0F13100F0A0C1A10),
    .INIT_51(256'h0715051113170C17170813180A14070A1A180019081815070715181912151811),
    .INIT_52(256'h00180E06141407170011100500190000190D0719190506190F12070519151500),
    .INIT_53(256'h06130E070F091A0C171A13181511090807101507091319100E0E120008151819),
    .INIT_54(256'h1717000B0F1018141609191A17170917101A07081306091919160B0A080D0700),
    .INIT_55(256'h120A1A121509000F091819120D1A11071719180609060B151317180F0A0F001A),
    .INIT_56(256'h0C070A0D000F0509061015180517191A000A13180B101615101A0812070F1A12),
    .INIT_57(256'h13061A1510051814090F170A100A131A1A0719191A180508170F0C1810050717),
    .INIT_58(256'h08081918100F0A19080C140D1018161016100B160915160F160F151005100B00),
    .INIT_59(256'h191A0615150516071008100810070715190A14181A150E1613071816051A0010),
    .INIT_5A(256'h0F0F060D0F060616071A06051018180D10161818070D00101700120815050718),
    .INIT_5B(256'h1013181A1A1713151A131810001800131407150F1815180C050B00100705001A),
    .INIT_5C(256'h0F0F1715101A1815170608131A101A06190B0F081917000609140C0017181015),
    .INIT_5D(256'h0A10170A0909191A1819111607080F101A140D191011100910000F0805100008),
    .INIT_5E(256'h1A191414140A07051A07160D190B0E16121615091807120012181519110A1010),
    .INIT_5F(256'h1217161A1617101A0610151808160019080E16171806101A101708181215140A),
    .INIT_60(256'h1908151006151717181913061810101A19131012151210191410160911110A19),
    .INIT_61(256'h1612181010070915070806120010121A18151806131607100E050C0914000F00),
    .INIT_62(256'h0F0708050B000510080506191718131317071614181700080719000617090619),
    .INIT_63(256'h06100018070A14070A0B0710140D08120706160D07100A17161A1A0507001A0A),
    .INIT_64(256'h1708091A090A071112191300150F0B0C17090D0719081110061A001A15061600),
    .INIT_65(256'h090818190000170C091613120506150F0A0B0607050700131918101113151305),
    .INIT_66(256'h18151A151A12130900001805180A091805060619180B101A0008071716190C16),
    .INIT_67(256'h090A1A0719151A0A0D16190A180F0C191A1800171A0F0C160518150A00100017),
    .INIT_68(256'h140616000D181A0019160B090C100915071A16121A1A001A1706130900190F19),
    .INIT_69(256'h120710181A191911161514060706050D1A070011071710080711121808000A12),
    .INIT_6A(256'h1010000F08130F1106190C061819190017151016061907060A17000817080010),
    .INIT_6B(256'h1918190918000007051000180D180D08190A000A0A141514191617111019110B),
    .INIT_6C(256'h0009191A15061A10190B1A050A18170007130F1A0F1209080610191A001A0008),
    .INIT_6D(256'h0013050813171612150C13181918051813131014121919170710161510191007),
    .INIT_6E(256'h060D100818180617190A08091800080515160F0F10061405140014101805121A),
    .INIT_6F(256'h0F190F160A10091010141010120F0F100710101010070F10110F001A00000006),
    .INIT_70(256'h150916090F00001807061806071818000F061010131014170F0F111017070614),
    .INIT_71(256'h1000000015181A07081A060F16180000180B1614190808060816001000060800),
    .INIT_72(256'h1A1718150C1418081906171710071819100718180F0913160509170600170007),
    .INIT_73(256'h13160618171A13111A151A080A18061A080F16141019101A06100009171A0C1A),
    .INIT_74(256'h17000F15180809000000000611060B0B001907140C1900191719000F1A060906),
    .INIT_75(256'h13140510051706001A15191A15121308171218051A1A181409090908071A1717),
    .INIT_76(256'h16130F1418000014141018171A13160808161800181A0806100807191318180B),
    .INIT_77(256'h11171A000F0F0C09050F1214080F1410070F1506101009131718180909100F17),
    .INIT_78(256'h0500131610151217101306131910161A0F140806170800120F0C170817111909),
    .INIT_79(256'h15121A1000070905171808170B0517140007160B10061618080B18101612100B),
    .INIT_7A(256'h0D170A0B000615170A101A080B07101809131913190A130D1607001807001508),
    .INIT_7B(256'h071718131A101711060017090000150A181816121A0C0817090000190F091912),
    .INIT_7C(256'h050A101917071414140600101210051210111906080907080B0C171908091017),
    .INIT_7D(256'h15171013000710091500060A161300061706060018071918180F181408000606),
    .INIT_7E(256'h0609000A15000907111610131014091A0615131917151A151A13101515151613),
    .INIT_7F(256'h1500090610000609140012171819131706070F060F1917100D150F0C0F071515),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_27_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_27_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT5 #(
    .INIT(32'h10000000)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1 
       (.I0(addra[15]),
        .I1(addra[14]),
        .I2(ena),
        .I3(addra[12]),
        .I4(addra[13]),
        .O(ena_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized13
   (p_23_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_23_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_23_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h05160B0707180F05180918151600071407191008171617181318151419171017),
    .INIT_01(256'h1810141414180607000B00120008180F08191A0A07160619151000150A191414),
    .INIT_02(256'h070F070609171818101906071A06100B12180709000F190D14141A1219140800),
    .INIT_03(256'h191009051A10080806091610060E060C0A1715001A171914000E0D170F1A0614),
    .INIT_04(256'h06050B1A0C1707170709091106161A050C000A120013090509071205091A080C),
    .INIT_05(256'h19180F080A170718070509130F050016091709001A00060809090A0715080005),
    .INIT_06(256'h101018121617181019001A19060B101A001900050B070E050716151618050800),
    .INIT_07(256'h12131A181816181718061818190A06181911181815180014160B001405191516),
    .INIT_08(256'h0907060517050F0F050F0606181517190014051A170908151A1810191712161A),
    .INIT_09(256'h19050706061811080A1517081618061800150715081018121918161306071909),
    .INIT_0A(256'h12061018130D071605190A00191516121A130000190A07050C1400070B08180C),
    .INIT_0B(256'h17191206171A170C1900081A0B09171913001A0F1A1000001A00100000080718),
    .INIT_0C(256'h0D150F0808130F080F100505100F05100F130F10101010101A0A0F15180A0F00),
    .INIT_0D(256'h13061618171A111710170D0605000D15100F1918161017121009100F080F1810),
    .INIT_0E(256'h1A12171012151716110607000814141711000C0B150C001108190B1A16111312),
    .INIT_0F(256'h17101412191807181805000816150506170906080F00050F17150F1014000615),
    .INIT_10(256'h150C181600091707170813071017101813061A06130912101311171611061715),
    .INIT_11(256'h180D05050F100606071A0800180913180A130818050510170713000609060F0F),
    .INIT_12(256'h050512181907191907001410061910110713070A0A16161913170B0909000912),
    .INIT_13(256'h190519140618000A130C0F10061005061A151913071618091215130F1200060F),
    .INIT_14(256'h0F19161A1019151A00100718180B080505100000190D191A0E060D00150F0F0C),
    .INIT_15(256'h1A00141A180616001019090A1410130F130709190F100518110F1917100B0F10),
    .INIT_16(256'h1907190F101911090F0E000B071A170516121417140511110713161417160B0E),
    .INIT_17(256'h140F0B0C0D061906171A00171A061A181918191806000A1714081610100F100F),
    .INIT_18(256'h001517071A0506170016111817071408181806120818150A11100E1A17051706),
    .INIT_19(256'h191A07181109070017070F101A0B120C0017000B0010191115000C0510160709),
    .INIT_1A(256'h0F051108160913071112000700171014051607120507100B0B170010190A100F),
    .INIT_1B(256'h18001A1815070B11090F100510001805161917190C1A0715060E170E0C080F09),
    .INIT_1C(256'h0510090718140914091508100A07170010150517071A10191510161815091717),
    .INIT_1D(256'h09131A071A1A1A0718061914191A00170B0F0C0617070F0F0610190811191916),
    .INIT_1E(256'h0817190008180610160A1916140D001007151907150718061816190C16060707),
    .INIT_1F(256'h08191710061605101007161510000A00060616090B190F1000080A13170C1810),
    .INIT_20(256'h100F10080D0908180F1809101006000D0C120814060707171708130817171417),
    .INIT_21(256'h1A1715060510071110001815150717100A1712160A1A1906120D07100F05001A),
    .INIT_22(256'h0716081717070E0000161818081010161A17000511081A110E17160A06110718),
    .INIT_23(256'h1107050905090F1108001814161A1A101A17161919090D0F0E1817090B060708),
    .INIT_24(256'h16190710001A180A0B0C00150C1A180706160A19080E0000170917051A0C070A),
    .INIT_25(256'h101008151917001008161408001207181706191919181A140006191319110707),
    .INIT_26(256'h0710131007060616110C1616101A100B001810091819140618161A1705161915),
    .INIT_27(256'h121A1A181818140B0F090F0A180A0E0A19070500081612160D10001008101306),
    .INIT_28(256'h081106061009160F0614120F0A001419160006050719060A18070015060A1617),
    .INIT_29(256'h090B170C13140516170B190006170708130A1818120617150718141A08191719),
    .INIT_2A(256'h100F0809101008100F001600001A080A05150A18080B0B15071507080A1A0E06),
    .INIT_2B(256'h0F0A180F1010050E0F1914090F1A0F1010050A1010170F1012141710060F170B),
    .INIT_2C(256'h17061917141008141900120606160A060A170C18060919061907101913000F0F),
    .INIT_2D(256'h00171712181015171200060908160C1207060605060617130615191517150016),
    .INIT_2E(256'h09170F191800140C091517191615150607191000060911171610150618070C19),
    .INIT_2F(256'h19101614141111001615140719070D140A06101A191A181A18081908160A0008),
    .INIT_30(256'h13160B061A161806140B00070B0907090609050D19070A0606161715150F1100),
    .INIT_31(256'h060007070F060508111317081A160015071714191413101015091A170706141A),
    .INIT_32(256'h0F0A0010051A100C06101A0618070707150610151A091A05151716050806060F),
    .INIT_33(256'h18190C180A1910161714090F0F14171910100A131405191009161A1205171008),
    .INIT_34(256'h14061516190B160007061716101A121810191412181316081500140F19131510),
    .INIT_35(256'h16091905000000070509100606190C190A0C0500151714171A140B181A151400),
    .INIT_36(256'h09000A06190A0706191612100718170518181711161213191900140819051806),
    .INIT_37(256'h1A1A0D16051A0F090C151A12091814000B1709070B001914160D180616060807),
    .INIT_38(256'h08071616061714140816070C14190D07090508160B1000100600000A18060708),
    .INIT_39(256'h15050A15061A0618111A160A050A190709081A0915160D0500131019171A1017),
    .INIT_3A(256'h16050510101015060F111306101416191907180B141000000619060710181507),
    .INIT_3B(256'h0717060807061805171018100F120915050C0917101000101012181313190710),
    .INIT_3C(256'h0700091608190A13091900101718071713151019170F171316121A151016100F),
    .INIT_3D(256'h0819120507101A121514061515141700151A061A1A1914070C160A091A0A1807),
    .INIT_3E(256'h19070916101A070913150016150709121908140A1805160D0711191718170619),
    .INIT_3F(256'h051A050B0E0A0F0B140F0019001A171A12180606150607080813080F00160715),
    .INIT_40(256'h0A190F1409191908101605071010081007130007051009051919161718000805),
    .INIT_41(256'h07181717050A19171A12151A0700160A090F17090800171508111805000D1300),
    .INIT_42(256'h0606131305191213181A061919001911161808120710090A1310001719191A1A),
    .INIT_43(256'h17050E160B0707160719100D180D00161A1119100F10100B00071A1A07101916),
    .INIT_44(256'h06140710081319131808110900110512091A1A07171905190D07001905000919),
    .INIT_45(256'h06181A181906121011080606091819080A1115151417101010151017000F1608),
    .INIT_46(256'h0D091A11051017050606091606071409090A0A19060610070017151911060513),
    .INIT_47(256'h100B14141A061615141017061518171615180019101413161A17001706190705),
    .INIT_48(256'h0006160606071A000C06180000101906191009100C1410161212100019110809),
    .INIT_49(256'h09100F05171018190F180F0F090F100F1608100816080F150F0F150F0F070F09),
    .INIT_4A(256'h19080519060B061A100A180C0F180F13140B051510090010050F101010101019),
    .INIT_4B(256'h18171A1917060007190A12191A060607090A0A050A0B00061A05150000101608),
    .INIT_4C(256'h17070B000800171005160A1110060910091A06060C08090D07001517060A1607),
    .INIT_4D(256'h0000101A1A06000F1106000514190A1808061616161710151510090C100F1200),
    .INIT_4E(256'h00001A0810170F1806060E00001607170719101713160F0F15070510140C1006),
    .INIT_4F(256'h0F00141408081413191718181405191615080600060A1815110613181806080B),
    .INIT_50(256'h0F0600121A0B10061910181518101918161911061A0610190518191407100E15),
    .INIT_51(256'h0718191410091006171A1810141017101912100619100F0506100F120D10100F),
    .INIT_52(256'h18120507191A0715190606190C14000A061010090F18180818001510090F1017),
    .INIT_53(256'h1906071307060C10171813150C131419050500100C190C100010100B16161817),
    .INIT_54(256'h13191A0A15140519180F16181207100A0B07091611060710000D150907050006),
    .INIT_55(256'h180617110013191909130E1308190612140610161810000B100C06130C190819),
    .INIT_56(256'h190F0809140A0A101014111919100C0B101010161010171013101018001A101A),
    .INIT_57(256'h1615140D1A0A1917111619130718151A18160A08161718001A05130006181014),
    .INIT_58(256'h070A0B15161815191916100808101213131310121A10001A1419070914071519),
    .INIT_59(256'h0F1917191A150B08101414051A0612001013170B180A10151A101A1411141816),
    .INIT_5A(256'h15100B1606181419100914130D0B09051700160A0F100616130D1A171A130008),
    .INIT_5B(256'h0E061816060605160F180707181A180017081313171610181716131A10160806),
    .INIT_5C(256'h110D0613150F070C130A0717171708000F15140818101A16120A18001815140F),
    .INIT_5D(256'h0619130607160909081805130D100900001912061616100712140F1915121310),
    .INIT_5E(256'h07071A06130814150808150A0D0A060B00181714060A09090819150616080505),
    .INIT_5F(256'h1217101210060E0F1412051810080013150618080D1A0B16100A170F0F000009),
    .INIT_60(256'h1719111007101515101910081A1800160A051807071817120B0F150F1A0F1005),
    .INIT_61(256'h0D15151A171506000A0F07190A001A05180A1307150D0F050B180F1A15091105),
    .INIT_62(256'h09190019101508140B08070708100C0E080D0D0A091208080E09091A09051211),
    .INIT_63(256'h190708190C14080F13141019151A1909180A0F081800050D06050E1905090F0D),
    .INIT_64(256'h16060F1A091809000F1A060C06090A071807170615070F051717071309100007),
    .INIT_65(256'h13191911130808160F08100F160D080805160B071910100919101A0D18000915),
    .INIT_66(256'h150A14140507101908100F0C12141618170F1915160618180012091907060700),
    .INIT_67(256'h1807080F0A09050015081A0812101906181610180D1516170010071700180615),
    .INIT_68(256'h09070F0F0B1A0F1015100F160F160F161A1710100019081A06071A090508090E),
    .INIT_69(256'h1A14181A12051A060015061A1010151013071010101417060B0F100A100F1010),
    .INIT_6A(256'h19191A13161316070800151913000D0F0E1716191A000710130D191314101919),
    .INIT_6B(256'h150D160709060D060F180806081500001A19001513060906091913060D141306),
    .INIT_6C(256'h06170F11080A130B0B100715001606001A07070A171417100A170A16070E1011),
    .INIT_6D(256'h0A09130A0B18140F1A0A000917091808090F1319150605161819100F170A0A17),
    .INIT_6E(256'h140607160719141000060E0F0E000B1A180B0F15051718180910001315131A05),
    .INIT_6F(256'h1A000E1A070D10100B0D13100F1713111219120D171705080F07080A09100F10),
    .INIT_70(256'h0C000706140C15091613171A15081510170817001A1A0916080E14191908100A),
    .INIT_71(256'h10061710071314191510151611061306100F1617181216000F061A050F09100F),
    .INIT_72(256'h0D18121617191910190807170F0C0F0F15140516160F090F0515111617001208),
    .INIT_73(256'h141407100A190F001018101A0C0F19190818060812000000001A141819171916),
    .INIT_74(256'h1405060B15141905101012090B080F180719191300171715051005120A10150A),
    .INIT_75(256'h140A0E1909061917110A000B071914191A000008150D1A091714001909150813),
    .INIT_76(256'h05130B0D121007181817101619140000001A1818081A1010071007090F0C0705),
    .INIT_77(256'h16081A1019171012101612080014101713190706160B06140713050C08131A19),
    .INIT_78(256'h191819180D071800101A051707001219151608090619050513071A0A19151607),
    .INIT_79(256'h00101808100910151609061A0B0F07160011150F111310191A190B0C1713090A),
    .INIT_7A(256'h0706140518101A130F1A151513180710080F0D060605121015090F190B071606),
    .INIT_7B(256'h19080614080807171509000612141618091A08170016180A1200190900090017),
    .INIT_7C(256'h1808140000090717190006160718170717060907141809100718170816090018),
    .INIT_7D(256'h170909000708061800130A1806081806060012160A1715131207051605120716),
    .INIT_7E(256'h090D0710150C00050C19061916000A07100519130B0514101510000808061919),
    .INIT_7F(256'h181809051600071A0C090908050B061A0B0C00001207171711130C1409100610),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_23_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_23_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized14
   (p_19_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_19_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_19_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h070A1A06130619190A080A05001619000816120B051508170608190010141107),
    .INIT_01(256'h151A060009100717121519070606191518161913001416061917001918061012),
    .INIT_02(256'h0F001A121A000009050607120513110719191018061114171500191A14180600),
    .INIT_03(256'h06051A13001905061A00060000191918190B19180717191813060D160E081716),
    .INIT_04(256'h1015161718160516150813190018121215071016000A050016100008090C0707),
    .INIT_05(256'h0517001A19050D060A060615050518061619050A00000000141010171418121A),
    .INIT_06(256'h1A081006090F1010101007060F19060F0F1A0819171016101913170F00080615),
    .INIT_07(256'h19000C071A0C1108170F05060908061416061A000F091006100F131910130F07),
    .INIT_08(256'h071019081518070A090A140E13080B0808051A07000817180007101805191406),
    .INIT_09(256'h0018190F19170915051600001813080706061705180A19071010120500050810),
    .INIT_0A(256'h1A001815181819000D1608001A18140918190D131619140D19060B1800100617),
    .INIT_0B(256'h1616140710131718110810101906000619071A00191A0000070A18190A060B07),
    .INIT_0C(256'h071618130716090A180007100907001017081A14160F17101708161411061412),
    .INIT_0D(256'h0A100606070F10001714180F100A0010091019171010171207061A071A170914),
    .INIT_0E(256'h171716071416081A0710100A0519000F18061A15161017061006100B16180F07),
    .INIT_0F(256'h0514161A191606181510100600160007120A1A161316121014141712190A1416),
    .INIT_10(256'h19161A191107151900120F110719080A10170E0C171912191615150907180506),
    .INIT_11(256'h00000913190B001815060B171517140B1711070618180607180B191019181505),
    .INIT_12(256'h19071A05151705101015121910190008101914151A0B13100517071319091900),
    .INIT_13(256'h19091A180B1518001708161A180010100710161A141A1718071617090806150F),
    .INIT_14(256'h10100619181917150F08151811120008050615071917121600180D18160F1407),
    .INIT_15(256'h121A0713171712070B0A0700000010151010111915190013141A1A091A10141A),
    .INIT_16(256'h0A101A090F00190E1713181714090819190610001A1708190512001A10170B09),
    .INIT_17(256'h12070F1618081909001910070914161A000C1907001A13180C18101719180015),
    .INIT_18(256'h07191008130F0805001612101508001613131813180510110E190F130F0F0606),
    .INIT_19(256'h080D060C091A000E08160600171019161611061A06091A0717060F090A060811),
    .INIT_1A(256'h191619100807110518121A0914000C18080D1007050F1A14161200180F1A080A),
    .INIT_1B(256'h0711161015100800000B180D0017191707090F071917160B09190B160F190607),
    .INIT_1C(256'h0F0C101006130A160F0718000F0B061719140A1309060A0808181505190B0706),
    .INIT_1D(256'h140A100B061619090800061508070515140C141A070606090A130B190B161712),
    .INIT_1E(256'h0706000000160007080F0F0906000805080F130D1A060013060E180D0F101812),
    .INIT_1F(256'h12100710100F1311000D0600081A0D07110F181319190709080D16160B181706),
    .INIT_20(256'h0C080D0900190D050B150707190C150A0B0B110A060B181506150F1710191316),
    .INIT_21(256'h051806000811001906080A10190B19180E16051219060C19080F050F08101212),
    .INIT_22(256'h10100616100006191817101017151810171914161A1718191607170519000615),
    .INIT_23(256'h1A1900090F1A0C090805071908090A090006140D0D050508160F131717080C10),
    .INIT_24(256'h10100F130B1010141010140C10121006100F0F0F1916170F1013171A0F100F15),
    .INIT_25(256'h0617150C000916000C1311100F07060508191913171300100815100A0F15100E),
    .INIT_26(256'h14191817060500081A06181A00091009180C1908090600001616121A05150612),
    .INIT_27(256'h060615100A0605190F190B1809070613001A06171619140D05100F0B180F151A),
    .INIT_28(256'h100B180F000C101009131A1005181010190018171508050A060F0B1810151914),
    .INIT_29(256'h0717090A071419100A1A05121810180C1512000F0019180A0F0F0A10100F0509),
    .INIT_2A(256'h1606101516151316100F16071410070813070800130C160A1214051A10000710),
    .INIT_2B(256'h1712151A0E1416140B1614180F12180610060A090012111A0905070818131108),
    .INIT_2C(256'h0F140F0F0B0914150908131907100D0C180A0600120819131613071017160708),
    .INIT_2D(256'h1519111715130016080F0F1708061813140714140F0E0F19111009100B10070A),
    .INIT_2E(256'h101A1100131606140615150718121A15081614171308070F0505141406170F18),
    .INIT_2F(256'h101705140A08081314000C19190F1007081805001618161A0D100A1209171A17),
    .INIT_30(256'h0D1500151312150F0B15190712141517000A0010170710140709071012001014),
    .INIT_31(256'h1009191605160707171318060711180A17180F1A190F0614161610101A0B1300),
    .INIT_32(256'h08130807100C100013100714191A0710101A1817181810190714101813110016),
    .INIT_33(256'h191909171315130819171915060F18171115100505131A0F070F000600070919),
    .INIT_34(256'h141713101A1110140606151413070812171500081A0B1800061414060E071906),
    .INIT_35(256'h0B090A140C1A0D171A0600100F150B070608061007111719100F170F08151600),
    .INIT_36(256'h000A06081A18000C121619161610151018081015160F171907180708100A0F16),
    .INIT_37(256'h071907001516191918191719150E001312000000170606161819190914061219),
    .INIT_38(256'h151710120C18191A151113001709141316160D1A1708090618080708190C1014),
    .INIT_39(256'h0619060B090F071A060011100615161A061A08090F140E071900150715181716),
    .INIT_3A(256'h0708191708151908191318191100130806190000190C1519001015160E1A0015),
    .INIT_3B(256'h110F1A0000061800070D17051707141807001916190519191917190015051819),
    .INIT_3C(256'h0611160A080605181606151700071319000D0B1919151819181617191717170F),
    .INIT_3D(256'h16050014080C0014060717111A001218101618070008171A1816111317110618),
    .INIT_3E(256'h12000009070719181014071017191519150610171919061A0918000817001908),
    .INIT_3F(256'h1A070C070500171305000B1705180808191A1516071819181315131010100613),
    .INIT_40(256'h0A0013181015061409000A0B0F0505000B1A0717060719170009001415150806),
    .INIT_41(256'h100F120818190A17000718160706170517061714180518090613101418121708),
    .INIT_42(256'h120F0F100710101810000911071A051900070C0718100B080006180909100C09),
    .INIT_43(256'h00050F0F16151810100709101019140F19080F1606100F060F131010071A0F07),
    .INIT_44(256'h0517070000180808060B1A13181908181906080505101919051207070A001416),
    .INIT_45(256'h1509090506000000181A15061316110518051519161518161919170618150B05),
    .INIT_46(256'h071916171314101619181800001A0606081A07121216050F1410151819111400),
    .INIT_47(256'h1708071817171800061818101819151200001908181616091012170918130918),
    .INIT_48(256'h06081A19191A10091A1508070A19001910080000051700070609060A17061A06),
    .INIT_49(256'h0A1A1A0915191017100A0900001012071A1610081218090F07100607180A1717),
    .INIT_4A(256'h141506070F090F131910100919100A0007190514061708161717000718001218),
    .INIT_4B(256'h10171510121A1810000F081710060505081A151A05130F181410131019151A12),
    .INIT_4C(256'h00000019120010181912061617151519151217180F17071419150007170C1119),
    .INIT_4D(256'h181514111A1A1A1317100A14000C101607070B180609190A0810180806061808),
    .INIT_4E(256'h0E080F1A140600181706070819000F101409140505071A09171A190A09050717),
    .INIT_4F(256'h18100516060715101018071A0618111210101A16081A001812130000000A1A10),
    .INIT_50(256'h001906060813000E131A0919090517130019171A0C080C07000005181A181A1A),
    .INIT_51(256'h1610101A1314081311151409051616140516101A15121218100A06190A171915),
    .INIT_52(256'h1215191218090011151008181519120A1415000B130B0F1A1A19180006000B18),
    .INIT_53(256'h0A190B16121710181A05061A161A00150616000B170C0B191907051117061212),
    .INIT_54(256'h071200080E181A091718180617170019110A160016150F0708150A1A07160707),
    .INIT_55(256'h0016170C0600170616001907060615061817090007191000110F101519051216),
    .INIT_56(256'h10071310161010060707170619080818131706140509190A120A1608090F070F),
    .INIT_57(256'h1906140A06170E18121006190A1008111A16150809060019171400080A100606),
    .INIT_58(256'h100914161019051915171A1712061816101811091916051806090E0C06000619),
    .INIT_59(256'h001010140005091006181316180D051818181A131A1507000807131414001016),
    .INIT_5A(256'h170019090C000D08060713100A1A1A1817190808001315191118141119191517),
    .INIT_5B(256'h0515191815190019050014180A0A00080900101A0819060A1819181A15180A13),
    .INIT_5C(256'h0B0F0F1410191900161800150C1706191A051509060912110718080F08090617),
    .INIT_5D(256'h1A1909181811121714151000170516000E070F10100807000D0C05000C08090F),
    .INIT_5E(256'h190500140019161605190F0D1806050A100008130B061415150A000812161817),
    .INIT_5F(256'h170F10120F14050F080F060E07191019091013101A0F10180F000B0D18190007),
    .INIT_60(256'h09110A0F10091514051715001016081007130D100F101009180F100F170F0916),
    .INIT_61(256'h070D191A061519051200190C05050500180718180716191A0714060718111218),
    .INIT_62(256'h0E181415170707050617050010051910151A1306180719151517001608100815),
    .INIT_63(256'h0619060D141917191913150600100B16090B090B1005190B190F1905180E1A15),
    .INIT_64(256'h060B171307070607051718000F16150D1A0017181A0806090F09081A191A1210),
    .INIT_65(256'h07120807181A061712161813161A05000F120A1916061609080700000008050C),
    .INIT_66(256'h081600141508001015101505121510100F18150A1A1610140C11100A19091A17),
    .INIT_67(256'h06061908120F0610180700100F10101006141008191A07191105060817150706),
    .INIT_68(256'h17090614120B0012131005051919170910100610151216191006101810100511),
    .INIT_69(256'h1317000C08161900071619111A191A131219190A170618130009060719070918),
    .INIT_6A(256'h060700061918141700160F18170A19100C0817191300180610061A16170B1615),
    .INIT_6B(256'h09091517160018141514191816190714170813180716160A0A05090B10131717),
    .INIT_6C(256'h0A16101A1800161207101917110A060815061919101105140007080906051817),
    .INIT_6D(256'h160A11120613050500181818131614141808060F051017080618190F19120509),
    .INIT_6E(256'h1707071414101A151700091A090718170618000A161910181900091205191506),
    .INIT_6F(256'h090018101217161310160C101015140612171916101817140512151818101019),
    .INIT_70(256'h090F10070608190B11170F19101A001714100615080709060D1908180F150017),
    .INIT_71(256'h001810191A151306071010150F09080016161A150C19190D10150710000C130A),
    .INIT_72(256'h181309180507050C060818181719160F1919100618170A100808171007001017),
    .INIT_73(256'h08150810190007090709081516190606140607190016180912190C1A0000100F),
    .INIT_74(256'h10100F11171600100509060F0F100A0610100E07080C131007151A080015060C),
    .INIT_75(256'h111816070A0B080A1819000B1819180816151707060618170013101A07101909),
    .INIT_76(256'h090F0809180918180A0F0D090F0000070C0F16160F181507190600050A18090D),
    .INIT_77(256'h11101914150C05180B08001414060007171105191105180D0C0006050018191A),
    .INIT_78(256'h000D130B06050716110708191514171819061919180912150C1A000807191A16),
    .INIT_79(256'h07091000000C1510090A131414170600191A08071900170F0D0E0A070E0A1919),
    .INIT_7A(256'h0A0F0A0B000D1A000606190B06180806141019060610101A050C19121009050A),
    .INIT_7B(256'h14000A131A091A1309171614191815130518080A170910000F08070D0F070B08),
    .INIT_7C(256'h00131714141412100717120C060B15190C170617060810001A100B0A07100011),
    .INIT_7D(256'h051A1406151718141807081715150900150F18000518080E060C12160F110606),
    .INIT_7E(256'h10150F10120F18180F061010061014101015101005100F140010081000060809),
    .INIT_7F(256'h1609190718191400180B0A1207060E08000F090F0F050F050610171010110610),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_19_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_19_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized15
   (p_15_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_15_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_15_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h170B190609071419070F190608170B0000191417170D09130716071817100F0C),
    .INIT_01(256'h00191215170C19191A080A061518000619060F191508171914050B000819051A),
    .INIT_02(256'h0E0F120906141519171A070F090912100812000E090D06191015191112101400),
    .INIT_03(256'h081116101909080815171218141014000A101A060B12071A09190C120611050A),
    .INIT_04(256'h101614160A101806141306141810181300090B0018150B18091A1A1700000811),
    .INIT_05(256'h080D1A00120F0C1A0617000B11061A151718181507161416061408110B130615),
    .INIT_06(256'h0E0F13100B100D19190B0F070710180013091905180F190809130A051A0E1306),
    .INIT_07(256'h1A0F0908140F09121414151A150900101512120C0F190718120F100F190F140E),
    .INIT_08(256'h1718130D0A161A0E171800111516161809081918140A1416170C060B1606190D),
    .INIT_09(256'h0A1008100A06171418191A18000A150006070517180605090F1A081309171705),
    .INIT_0A(256'h1616151809061A14000F070616000E06100B1713190617090C19060813190000),
    .INIT_0B(256'h18191807101614101016171008120515000B190D0506061906110609080A0B14),
    .INIT_0C(256'h160618090B080706090D1718001719060F070C10050709170809060015101014),
    .INIT_0D(256'h07101617100D1419171618181216001009061319051814100919190806150815),
    .INIT_0E(256'h05141400180F16180F0A09170D060A1014180D1114080F0A060A07160809191A),
    .INIT_0F(256'h1A170C110519150610140C170F1817160C100F0A0F07061717181A0F070F1009),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h050E1A0C19121400000000000000000000000000000000000000000000000000),
    .INIT_63(256'h180E00101013090810170F10180707171607101A1A06091009070715060C0A09),
    .INIT_64(256'h160516100A1018081015151010060C0817160B0608050B0D091A000500141209),
    .INIT_65(256'h060805130B07080508110806171213061A1A071A060914000F0E141316001A00),
    .INIT_66(256'h1A10060D1A170015161007000B08050A0B190B0F0F060C0F081A14101A191807),
    .INIT_67(256'h14071800191A051914100F1410100F1412060F0800061019181018060619100B),
    .INIT_68(256'h13120F1108070C0F13060908101500190F0E081A0C09070F000F0F1819001609),
    .INIT_69(256'h17071617100C15050A09181518061119150C1819090F0016070617190706080D),
    .INIT_6A(256'h000A17060A1A131006091410141618191616050F0C190D06140610160F10100B),
    .INIT_6B(256'h1510071218171507000F131618120F10130C00100810000C091900190A060900),
    .INIT_6C(256'h00180710001813000010050A1A00190707110F00180A0507090F130B100C1A0F),
    .INIT_6D(256'h190F17131608000B0919190B080607000C1706150609160F17070C1705060B19),
    .INIT_6E(256'h060011001507190C061910080F0D150C15140D16000806190D1919141416120B),
    .INIT_6F(256'h141A180F0710050719180507170C060F1A12151015061915150909000C101806),
    .INIT_70(256'h191816160819130E1919080E0B18190A15070E00140518090619100900000006),
    .INIT_71(256'h190B070008190A0A001606090605081A09170007141105091306101307090E0A),
    .INIT_72(256'h1306000A05051517071A161410100F00140708160F1118101711070A0C0A0F06),
    .INIT_73(256'h101A001008131409151A060719130F1700151A0E071418050009131805160806),
    .INIT_74(256'h10171606180710190F1013061A1213141910120A1619191A1A16151413051416),
    .INIT_75(256'h050716000919160609160D000C0A0A180F001314051005191006090706120F18),
    .INIT_76(256'h09051019000C060B06050817060C08071A080F181A190713081900061309080E),
    .INIT_77(256'h0A080712170F1705071A051719100F1A190017191A070607080919110E0A0806),
    .INIT_78(256'h1005121A0E16190708080E08090E18171A060C07120C1919190F0F100F001906),
    .INIT_79(256'h10000A0D09181806100C07150006061616000B0A0C061013100E061009050F07),
    .INIT_7A(256'h1A090F120013101616070C0B151006190F1018160E051507170A0707190D090A),
    .INIT_7B(256'h060819061008171607070A1919080D190E0B09190C051015091A191A140A1A05),
    .INIT_7C(256'h00120A0E10090913101A1718090F00060A1213090818001A1A0C0909060B180E),
    .INIT_7D(256'h000F080518090B060F090006100811121907150F10050D171709180A18060606),
    .INIT_7E(256'h06151400071A05100F130D0A16051308070710190619070F10091815080C0E0C),
    .INIT_7F(256'h08100E1310001408000005101606050E08160017190817150A060917190E1315),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_15_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_15_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized16
   (p_11_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_11_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_11_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h19070B170610151707000A130D0F190A080F1510191605000A17080D1013190F),
    .INIT_01(256'h100F16090919090515070F071A18060006161A0C0C060C140F16121910180019),
    .INIT_02(256'h1809190616060D0A181613160F0B1005070F05191A00070B13100F1705081706),
    .INIT_03(256'h1808071219001519180612180C1607001019101019191A1813160F0610001307),
    .INIT_04(256'h1A0A141510080505060909181009060E10000A100C000D171710061905051608),
    .INIT_05(256'h100F101A1906071017070010100F0E0615160807080F0E180B0716051A060A0A),
    .INIT_06(256'h1910120F151515161A1708180F1A101017181706140919081800101016080B09),
    .INIT_07(256'h080F00140816090C141508090619190F151A14080713000F060F171A1A150C18),
    .INIT_08(256'h06000510101817150F1A0A0900180A18070D180F190B07180C180F1706071A18),
    .INIT_09(256'h110F06050A00051308091A180C051507080F0F0E07080519001406070A05060F),
    .INIT_0A(256'h12100609090E060609001A0010120F17191A17181A06181814070E0F14090F19),
    .INIT_0B(256'h160C110B1A0809180C060508060A050F101705100F180D0A0B1513070714000B),
    .INIT_0C(256'h120E1A0A130A1900101800140F161715100A1A061018190A0A16071A06001619),
    .INIT_0D(256'h13140E0A1A060B0A1909141010050515060B08000500080A0610070706101205),
    .INIT_0E(256'h1A101809051808000000181807070F1019000608100808080D071910000C0D10),
    .INIT_0F(256'h0010050D1A17071718141A0007141A0C0E06050610060717170B000F1012140F),
    .INIT_10(256'h0C1A17001810150A1010141000181407140608100F1917110F12101017130806),
    .INIT_11(256'h00050F0D0D15060B1906071514140F170A19090618080B08150907100B140F19),
    .INIT_12(256'h0F06071A081900000B0F0F0A10100B171A131800090F1919180A171405091216),
    .INIT_13(256'h16170C051912170900060F0F141108001113110010190819110F171011180813),
    .INIT_14(256'h0016160B051619000D0C08180919160E081505120718081900001A091A090817),
    .INIT_15(256'h190819081419071518191507070600161107161115060A09180000130F15190D),
    .INIT_16(256'h0C18000000141019070F17080A09050A00081905071418171409101A15001812),
    .INIT_17(256'h001907071A0007101A061614110A0C19000F130D1A0F05170A051807100F1705),
    .INIT_18(256'h050F0A1A0D051700080E090718160716120A0B060D19050606180B120B060F0D),
    .INIT_19(256'h0E0B0F1A1410180807191A061609100618180508090A1A1A10060E100F0A0007),
    .INIT_1A(256'h0A08111A070716160B0717150E08160706060D0F0B000F190E0F100907170A0D),
    .INIT_1B(256'h0A061313060B000F0610181114161009100F120F19180A0619060E180D101906),
    .INIT_1C(256'h070014000615061900180519090B1212101A0F0F0000051706130F0A070E0A0C),
    .INIT_1D(256'h1A1619190707161705060916180A0E0D0C19001918070E0519190A000A0E0F14),
    .INIT_1E(256'h1010141A0F1819001816120007091810131718080005150D1000080906060619),
    .INIT_1F(256'h071A16150A08180D090F0E0705000D0518000606060713070009070C060D1606),
    .INIT_20(256'h0706061813070010051A06190F0C050014170A1A07060F170C0F10181A061A17),
    .INIT_21(256'h0C160009061908050C08060B0F0B1A0E1116080C180A1905190C1118170B0506),
    .INIT_22(256'h19160607120F080C1710140C0716141A190909100F0505000512170805130511),
    .INIT_23(256'h0D1919131A050B06111007151A061617131411000F17140A0D0A1010060E120C),
    .INIT_24(256'h0709060B1007070F000B100C090807071011181405000C151809071007081307),
    .INIT_25(256'h0A071000000017090508170600061A0605080613090F0C0E0000001A08191508),
    .INIT_26(256'h080807190E1A0B1A130D07060A061919081A190B110806180E13060A0F100816),
    .INIT_27(256'h08060900080517000600180C00081012050900060F120009161805060C001009),
    .INIT_28(256'h0F151A060518181907150D060B140609051010000C000F060F00000707101817),
    .INIT_29(256'h0F0D1A0B141508180900051613071517050610120B1905050B1A0618130C0F0A),
    .INIT_2A(256'h101608070F1900001907080808000507091612170C19170B0E07050F001A0706),
    .INIT_2B(256'h1919190919180F17191706170600160806150C07070D190906191A16130B0500),
    .INIT_2C(256'h061806190718160F15160F170F051018001018120F101913140F08171508001A),
    .INIT_2D(256'h190507061717150C070500100B05170509140011100506160E1010151714090C),
    .INIT_2E(256'h1608120F1208110B11060A000A1A060505050C061A180E07060D140F10120510),
    .INIT_2F(256'h080908100F05070017000916080F1706071205080F10140A101518070D19070C),
    .INIT_30(256'h160A05070C000F0A0B1019070907091905050C00101817161708001800191A05),
    .INIT_31(256'h1A091805000010190515071317100D07050B1919160017120A18100F0708120F),
    .INIT_32(256'h19110C1A06101A061018091A0000171A140F0608070D1910170805000C100010),
    .INIT_33(256'h151806101805071A0C0917150D06060E15170A00060719060C17080006081918),
    .INIT_34(256'h0A0B060E1A0708000709141917081706130B1016171A0019071A0F0D16070618),
    .INIT_35(256'h080D1A10060C00070805080B0D0D05091208100606191905180C080D130A1010),
    .INIT_36(256'h070E120818090B18080A13050D06140E0C130610160A1A15080016051905100E),
    .INIT_37(256'h050610160A06191600060F0D050008130D080F0A07081518090D09090C181010),
    .INIT_38(256'h1A06060E08070F0F0F07051010181912160B0F08080F14160706170019141600),
    .INIT_39(256'h0F0A0D120C09160F18181717090F0F11080800060A051A160708070800180705),
    .INIT_3A(256'h14051A1909060506090A061A1600140D05000011130008071A05150F06161008),
    .INIT_3B(256'h090F14121116000A181017070513081017130A1606100D091719180F0F191910),
    .INIT_3C(256'h170A181A0F130C0C0A190910100C0606080D0F0C0C1811180F180613170C0010),
    .INIT_3D(256'h1613141407070010190907000E1406161718060F1010080E081300051919071A),
    .INIT_3E(256'h0718091718161A00111819170B16061814180F1719071006180F100A1019160A),
    .INIT_3F(256'h00061A120E16080719080A191610160E061210120010080617101700130F090F),
    .INIT_40(256'h0C0C081A0F180F14060B0E120706070F09101A0A0E05170A05080A1010000C00),
    .INIT_41(256'h1100100B060C0C0E1017051910001A0A08141018190800160006191819101310),
    .INIT_42(256'h0E110500051A07080608130F00061910000A17060B1513060E1407141A130F0F),
    .INIT_43(256'h0807000E19120500070B15131718080C11191318070B13130F1009190510051A),
    .INIT_44(256'h101507000619070F1816060F1410140B0F16060719191A000606171817091714),
    .INIT_45(256'h1A080518181506071618100C19050906000A000908070A0F1800050F191A0000),
    .INIT_46(256'h1816061814060C1119051A19190011180E100700000006170C0B17070809070B),
    .INIT_47(256'h1310070518000F111400000D120A0C0A18070A1006100B1719111009130F1419),
    .INIT_48(256'h0607190A19140605070B1A170A1816150D0018150F18121A15170916151A1209),
    .INIT_49(256'h070916171006100F0F090D0700190E071A0E06180C0B0B0A00110F0E00151819),
    .INIT_4A(256'h060D00160F08080E00141A06171410101708140F0A0F0B090F10070F161A1409),
    .INIT_4B(256'h00111909080F0A16070D0F1A1207100F17150616160618051910071618060C00),
    .INIT_4C(256'h0608000F06160919100F06090E06150F07171906061912050709070E00051819),
    .INIT_4D(256'h0709140E1316190B1619191A10070F061317091A061417001015080B0000160F),
    .INIT_4E(256'h1508060C0F11000906180716170C000A1A191A06001111190606081006070A08),
    .INIT_4F(256'h0E000F0B190700151706080A160A0A081015080C081613190911140B18130F0E),
    .INIT_50(256'h0000070E0F001510101719120710100510170A06090D0D001900161400000B05),
    .INIT_51(256'h101813100F00000709070F0707191A0D1611181011140F0019080F100010100D),
    .INIT_52(256'h08081814100618100A1610191015071A0A170D0A000610101506090719000B14),
    .INIT_53(256'h09191810100B06100015091914180B0600061A1A180805100705160710000006),
    .INIT_54(256'h120000140A0619071309080009061019070C1810101000000906101517141709),
    .INIT_55(256'h0F120E00071707081A1707140F0F080E0A19190006190B060B0D0A0607080F10),
    .INIT_56(256'h1A0C190B0F070B1505061A170F14060B06071816180D1408101008100019171A),
    .INIT_57(256'h17050F0A18070E09150F10191012170B061100150C050F19131000000B050018),
    .INIT_58(256'h0B0A1808060606100717070F16081213171506091409050F080D0600181A1518),
    .INIT_59(256'h17151916080E101619100706170F100E08070F19101218060918121000050814),
    .INIT_5A(256'h0C160C0F160619191409000F070F0C14191A12070B0F0D1A101716090D13121A),
    .INIT_5B(256'h00151407101019070B08051613051805060C061807190C071A1805061714090B),
    .INIT_5C(256'h0B09071906180A06000D0F0000170C0E0819080D180F0C170F12190809070814),
    .INIT_5D(256'h100018190606131A070607120712140B090F091106100018050C070707001016),
    .INIT_5E(256'h0C1915170C120A140E19000012171A0D060B100707160C18190F17140817100B),
    .INIT_5F(256'h07110B0011061800001806000C18170A06181809150C0F181900190C0C081810),
    .INIT_60(256'h0F1A1313070C0F06100F100D0800141014061A080B191908161810111014100C),
    .INIT_61(256'h050C0B09070513061018000519060712151017171707071214061A001417061A),
    .INIT_62(256'h0F150F0000061A1910161009101906180F120010061808000608071A06060607),
    .INIT_63(256'h050C120F18110F15170010140F130A16120F1600071A061608101119170B1617),
    .INIT_64(256'h061711050F1A061610171A06161416150C0A18071A17160B170606150F061312),
    .INIT_65(256'h070E151A17161016100016070E090019160A160F06181510080610061117000A),
    .INIT_66(256'h0000001210140D10100F181810110F0C1A1A131300190B0F0000140A06170D0B),
    .INIT_67(256'h0D0B0B091518161913000C1A050F0B0917060708141009050F090D071915140A),
    .INIT_68(256'h0B08190613110C0607060D070716190500191608061A0F150019061907080906),
    .INIT_69(256'h0919081A18050C1A0E1019090F070F0F191A1700050600180810160B0906000B),
    .INIT_6A(256'h0C060E0A0B06000610191806160608080618091A050710100F1506060800181A),
    .INIT_6B(256'h09081918050906060B0A060D080F0609190F0019080B0C05081A0F180506181A),
    .INIT_6C(256'h171900100F121214070E09000D08100B100B191907150D160E17111817180708),
    .INIT_6D(256'h1A1016060606001A07090E0914180709090F0F07050A09180618081114180918),
    .INIT_6E(256'h0D1917050010130517190006000007061A00061A141407100607150F15170A14),
    .INIT_6F(256'h1A0A0B00050019091518001709050A0006070B090819070D0A09090805000706),
    .INIT_70(256'h000A080A19051A18130017090700080900081015080F160C0D16060016101309),
    .INIT_71(256'h0A170019071817100706110907051410140A19000A10090F000C1900071A0606),
    .INIT_72(256'h08081819000018160F0B0005081018191A10090008190612141A1400050D0608),
    .INIT_73(256'h0F100E00130F0D131615190B171900060606071A1A071200120A1A1916171709),
    .INIT_74(256'h0A1418130719070518000A0508191A07110F1A091808100C1A16150C10091916),
    .INIT_75(256'h0805051807141A070712181417121719130716141205070600191007100F0A18),
    .INIT_76(256'h00001A0A00180A06171915061A07000007190B1000100A07061718161A1A0019),
    .INIT_77(256'h08001A10091A0E1019191806110E1A0E130810070F17080006060E0A19180E00),
    .INIT_78(256'h140819091612070C0605050A190F0F0A100900130E0C1018001808151A090610),
    .INIT_79(256'h0907130619080F061709150015080A190A1209181A06051A1A09000705000709),
    .INIT_7A(256'h16180508000F18140A0B000006140709090616141815190A00111919090C161A),
    .INIT_7B(256'h0D100906170C1A000700050B181018160A081A0A080000060D0906060605170F),
    .INIT_7C(256'h0A18000718150C180010060600061A15100F1A19000019180914120608100600),
    .INIT_7D(256'h121810060713160D18180C16060617050D07160F170A12051900100F160F1A17),
    .INIT_7E(256'h0D1A060F0F0605000A100F0F08001308171506060A0606100A0719180C15140B),
    .INIT_7F(256'h0507070A06181000090800111216080A0F0C0606051906090F0011161A070D0E),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_11_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_11_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized17
   (p_7_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_7_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_7_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h080606171319111917001212060A161A0006071A160C0D050D1718000610070F),
    .INIT_01(256'h0505170C101017090017090A1000060618061A0809070505061906080C001610),
    .INIT_02(256'h190B0F150600060A1806001A1A0C08141A19060019150C071410100610100F13),
    .INIT_03(256'h110009060019001A0518080F190917080010180F051819190512150700171A14),
    .INIT_04(256'h1A001A000F1A0A1906071906050C0B10000510070B070608061A180D150C0008),
    .INIT_05(256'h0F1106000B0609080F10000F0A0E190B07150C070C07151000090A001518171A),
    .INIT_06(256'h00000000000000000000000000000000000000100F0E000E1A1A1900051A060C),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h1010101015100718121000000000000000000000000000000000000000000000),
    .INIT_0F(256'h181010120F080C101018090D1008111412170B120C1410111611131211070811),
    .INIT_10(256'h100709100A1317101310101018181700080A090A101016000010120B1617120C),
    .INIT_11(256'h1007180B09140000140A0800000007110A07160F10080812000A1010180A0910),
    .INIT_12(256'h0710101216150000001814101000000000171016001010101600141011071010),
    .INIT_13(256'h17100910131000000010111314100F1813000707101807101618170908101310),
    .INIT_14(256'h18140C131000101410111012100D0B10100810101315090B1016130008101612),
    .INIT_15(256'h001000000D140014161415130E181300101509070000181717111408130B1013),
    .INIT_16(256'h000009100D150815101216151109181815080814151510101808081200000000),
    .INIT_17(256'h1400001817140717101710151110111110001714101008161018081410131010),
    .INIT_18(256'h180714141014081009100A171811180717070912070000101315180A10101010),
    .INIT_19(256'h1211081400070D07110A100814091100000B1014170C0018130000070C101000),
    .INIT_1A(256'h090D101015100C17100E1314091210080C130912170B08171010101711101807),
    .INIT_1B(256'h1710100B17121300100914101517001016131610110A0D170910130917101116),
    .INIT_1C(256'h0010001008100A131210101410091017070A1710130A10140A10101007091014),
    .INIT_1D(256'h000000000000001408070813000012130C181300071507161310140717001508),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_7_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_7_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized18
   (p_3_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_3_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_3_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_3_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_3_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized2
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    ena_0,
    clka,
    addra,
    ena);
  output [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  output ena_0;
  input clka;
  input [15:0]addra;
  input ena;

  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [15:0]addra;
  wire clka;
  wire ena;
  wire ena_0;
  wire [15:2]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h34DD5050C41410D541050C1013414001040005351101047401504010D4515310),
    .INIT_01(256'hFA41493E38E0F4138E4E7923910C531143004D051410135133501044D1145141),
    .INIT_02(256'h409379423DE4135394DF9340FA50F943A40E342893D4D3E4E9E4E3E8253E53E4),
    .INIT_03(256'h145444405001450415044143A43E53A417A25F893E528974E38D0910E53E43E9),
    .INIT_04(256'h4103D05434514045450FC533C0C03000000F00F50450D544510411475040D045),
    .INIT_05(256'h3D05045445040444F40514051444113FCF0C000300C104145134050501004341),
    .INIT_06(256'h1003114150515505144441005114115114000003C00C3C0050551105043C5414),
    .INIT_07(256'h00000000000000000000000000000000000000F003000030C151141411500414),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(2),
    .READ_WIDTH_B(2),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(2),
    .WRITE_WIDTH_B(2)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR({addra[12:0],1'b0}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:2],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(ena_0),
        .ENBWREN(1'b0),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1 
       (.I0(ena),
        .I1(addra[15]),
        .I2(addra[13]),
        .I3(addra[14]),
        .O(ena_0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized3
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hC3731DE6CF18C37718C307B8783DD5EFF3F96D96E738E678E70E7847318C980F),
    .INIT_01(256'hF3838F08E1E18C1878719A790738CE2190E24430F1CF0C9C6773973AE631C730),
    .INIT_02(256'h6826470E376E3689C26F2D6624ECEC339B9CE6022DCE71872D8F048F0E20638E),
    .INIT_03(256'hC47186C26271331C3A7E78E360EC0E78F1CE3303CC139C381DB109E8D3EBC89E),
    .INIT_04(256'h218D0C03C57908D9C04E731F642E670CF339961910F0F0CF0CF2743C6E246310),
    .INIT_05(256'h1DCC66365B8F0C7B871B09B3618C7366317326C6730EE21E1F64CC48707187F2),
    .INIT_06(256'hB98E68E2321896636CCB611CF2CED931CC3B9C16C605DC8C326252663233319D),
    .INIT_07(256'h438C231992638C78C44C40CD91198C308E1B8999D9831DC1B2671131D9C9C8C4),
    .INIT_08(256'h24C71CCCC0CC64CC7325D99E38B318747333360E63067384CE32D24C6788B726),
    .INIT_09(256'h861CCE66D4CC61B339DB38232619330C459CC6C986664E233338B658662C3362),
    .INIT_0A(256'h43CE631C58DCD98E2C9CD233C60CDD9239C731A5B9B198D91B266B5A67322271),
    .INIT_0B(256'hC193B23B193988991C33731C66166C84CC633B329CD867189EDC1C8D33CD8D33),
    .INIT_0C(256'h711620DB18EC8C463332C98B99C4CDA66621B43199C8C98C36E32D3693318719),
    .INIT_0D(256'h71B99CE6EE66773BB38466CD9C368CF338C98E4CCCCC3B3BAD9B12ECCD98C666),
    .INIT_0E(256'h6CC662333309B1934CC933648C734B99A1C69CCC49260C7304C6CB64A1863373),
    .INIT_0F(256'h64438D26611239C4E5C273619C611B169DE41CC930EE8E64C6664266919339B3),
    .INIT_10(256'h991913999CC99DC4CC91199948EC67261CC223370D98EB0DC0D0B166D911D866),
    .INIT_11(256'h6693338319A1CE7263190ECCCD8C0C79B3110733631665DC62519122A45B263D),
    .INIT_12(256'h99C398472C72673866643264332719C70C318C6CE0C9A073311E186CB2733226),
    .INIT_13(256'hB1C471938CD923161118266719D911C8866CC71DC118981B38184419A7198D99),
    .INIT_14(256'h3123DC60C4C8E6C847A31D999338E676224C719C3126C876E433261656C66303),
    .INIT_15(256'h715846749E7219CF321B93084CCC62713299D1CE5C63A6739B18CC91D9CCC881),
    .INIT_16(256'h8938131E19B13424C611C5BB66E63131A9319CC99C0C7326671B998345A1CCD3),
    .INIT_17(256'hC98E661D072591BCC84CC32399C31938E6F3CE773B23B58731C36D23136189D8),
    .INIT_18(256'h44591C708D8CCC36626C3934D9B98CC6F24E3931DCCE7189C6661B89965863C4),
    .INIT_19(256'h3C991362C67361A72244C91B34CC663B1B311C9C66CDCE438B3270C9C9B66336),
    .INIT_1A(256'h849984E47199B0A3212D9832486C7325998766C733633260F39908DC62D20B19),
    .INIT_1B(256'h0CC66719C0E470F11C71CE22773C638CE386E1C319C0EC71333013324DDBAD8C),
    .INIT_1C(256'hE2CE739CF0DCC4372619B1B32399318EC6C319E1CEF03110319C18EC12CD8E67),
    .INIT_1D(256'hB199111EC8123A09C42726CEDCC64CC339933198672E976E73B60C6E09B388CE),
    .INIT_1E(256'h6813A847664DCC22268C9CCA4CA366726739B9CCE76848CE25B39D8EC2D2E339),
    .INIT_1F(256'h6446CE1DC3218D87718CF1C098E191C838D8388C37321C911C73C248C648DB23),
    .INIT_20(256'h9C673321871898C639C18D936D9939988B664E6306330663CE66419C619A598E),
    .INIT_21(256'hCE33399C390C6E61C3322631199C9CCC4CE62D199873830CC4E6E14DC91D24C3),
    .INIT_22(256'h7313998C9CC3723233398CE4133608C6126C873984E66672732E30CD88AD9273),
    .INIT_23(256'h8E46EC81BBD38D9861C463CC66E3199C9B98613B66CE3191918CECA46C64D32E),
    .INIT_24(256'hE461BB121339A7988C661B371ECC861B8933666260DC98738C27646399096D85),
    .INIT_25(256'h10000000000000004040C0000002000000800001000000000000002C4904C948),
    .INIT_26(256'h1100000020000000000011000000080000400480000000000002020608060008),
    .INIT_27(256'h0000002000000800000300010000000000000000000800000008000000008000),
    .INIT_28(256'h0002000000000000020000000400000000000010000000008000000000000000),
    .INIT_29(256'h0000008104202001010300000000400022080000030008090000000000000E00),
    .INIT_2A(256'h000180841101C004000000000000000000020280000000000200184008004000),
    .INIT_2B(256'h0000088000000102040000000080000000000008800400010100000000000000),
    .INIT_2C(256'h0000100480000000200008020000000002000100000000001000000000000000),
    .INIT_2D(256'h0002000000008000000020000000001000800000000000000000000000000400),
    .INIT_2E(256'h0000000000000840000000010000200000000000000000000000000000000006),
    .INIT_2F(256'h0150280000040000000100000000200000000000003018000008020000200000),
    .INIT_30(256'h8081000020401000000000000001200000000010000000000510000000000000),
    .INIT_31(256'h0800020000000000000008001020020000000000000000088000400000000000),
    .INIT_32(256'h0000000000300000000000000000000000041000000000000000000000001002),
    .INIT_33(256'h0000002000200040C08000002100000800004000000000000000000020000000),
    .INIT_34(256'h020020A002000020000000000800000000000000004000000000000000004080),
    .INIT_35(256'h00C0000002010000000004280000000810040000000000001020000001022008),
    .INIT_36(256'h000000000000000001000000004000000004000C000000200000000000000000),
    .INIT_37(256'h0000004000000021000000000000200000000000000000000000000000000001),
    .INIT_38(256'h2100000000000088041002000000200000024000000000000000000000000000),
    .INIT_39(256'h000100900000000004202260000000000000000000000C000000010008000008),
    .INIT_3A(256'h0000000000008000000000020000000000000010008B00000000200000000000),
    .INIT_3B(256'h00000000000000000000000200000200000A0002000002000000000000000000),
    .INIT_3C(256'h0000200200C000000C0000000010000120000000040002000008000400000000),
    .INIT_3D(256'h0000000E00040000800000000001000806202000000100200000200011000200),
    .INIT_3E(256'h00000000040010000000000001E0820000000000000000087003000906000000),
    .INIT_3F(256'h44000000200000000802100400000000000C0060000000240000800000000200),
    .INIT_40(256'h00000020004080010002040200004000000000800000000100A0002000000000),
    .INIT_41(256'h0000040400004200000000000000000000404318001020200000000000000000),
    .INIT_42(256'h0000040000000000400000000000301000000004000000040000002000000000),
    .INIT_43(256'h0001008010000000000000000000000040000000002000200100284080000000),
    .INIT_44(256'h0000002000000000020000800800030000000000010020000000000200000000),
    .INIT_45(256'h0000000200001000004000000040000000000000001800000000000000040020),
    .INIT_46(256'h00010000400000000E0010000100000000000000000000000002000000000001),
    .INIT_47(256'h0008000800000000000000004000000000000000000002000000000000000220),
    .INIT_48(256'h0000200000000000000000000008000400020000000400000004000900000004),
    .INIT_49(256'h0000100080180000422000001400000002000018000000000000000001180000),
    .INIT_4A(256'h0000001000000000080000000000000200002000000200000000000000000000),
    .INIT_4B(256'h0000000600000000000080000000001000000000000000020000000000000000),
    .INIT_4C(256'h0100000800000001000000000100000000000400000000000004000000000000),
    .INIT_4D(256'h0000000000040020000000000001000000012000000404000000000000000000),
    .INIT_4E(256'h0000000000030000002020200000000001000700000000000000010000001000),
    .INIT_4F(256'h0400200002000020100040000840000000200842000000000000800000040000),
    .INIT_50(256'h400000000000000020000D000008012008500000440000401000080000090000),
    .INIT_51(256'h0002000000000000010000000040000000001300401000080030000000000800),
    .INIT_52(256'h008080020400002000180200000000800100000000000001C000000000000000),
    .INIT_53(256'h0010000032040200000000000000000001800000000000200200000000800000),
    .INIT_54(256'h0000000002080100090000000000000000008000000000041000000000000000),
    .INIT_55(256'h0040100000000000000000000000000000000000000000040000080008000000),
    .INIT_56(256'h100070008000000000000001000001000000000801000000000000002000A000),
    .INIT_57(256'h0040000040000020220400000008000019000010000030820000004000000000),
    .INIT_58(256'h01004000000800010300000010000004000000000000808000000000400100A0),
    .INIT_59(256'h000000380200000000000000E000002000000000000000240010000000022200),
    .INIT_5A(256'h0000020000000000044010002002000000020000020020040000000002008040),
    .INIT_5B(256'h0000000228000020001001100020000000424000040008000800010000000000),
    .INIT_5C(256'h0000000020000000000000380000400000000000000000200001000000000000),
    .INIT_5D(256'h0000000000002040000000000000008000000000200004002000008000000000),
    .INIT_5E(256'h0022000800060000002000000200000004000804000000008001000000020002),
    .INIT_5F(256'h0100000000000080000110000000010200000100010000001001040000000000),
    .INIT_60(256'h0000000000000000100000000000100C00000000000000018000001000010000),
    .INIT_61(256'h0000000000000000000000000000001000000000008000030001000000000000),
    .INIT_62(256'h86678C6898C748CC08C6C86638C9A6CC696DB2973399391C64D7744647337671),
    .INIT_63(256'h98D666C88EF61B18933B11849B8C9924C6672316CDDD9B31CA6F76253632DDDD),
    .INIT_64(256'hA31344DC362E24D9B319C2315BD90362CB6F19B366638C862C3369A6DC630D11),
    .INIT_65(256'h9989B26221CE6647B312333996C9CC866274CCCD9266C88899CB426E2313B8D0),
    .INIT_66(256'h0CBD0C64EC671C606477339B906C9E4F66660C3671B1BD1C761C6649244C731D),
    .INIT_67(256'h9D9738E99C4E4446196310924D8E4DCC8CCCC474A70DCCCCDB4DCC9B32133663),
    .INIT_68(256'h30C676939C989931C4E4B318ED99711781934C725332518D91369ECCCCE33B21),
    .INIT_69(256'h36172798E4CC8C6E3B7191A0E6648C6736442663699924A728476349D1E44CF1),
    .INIT_6A(256'h8E713DC99198C44736E386612E4719999C833636318C70991C8466243999A399),
    .INIT_6B(256'h9CE7184E70C71981C66A4E6432631C91CC4C9C7325E7A62E1CF06619C6716E4C),
    .INIT_6C(256'h000008000200000000000101000000280000000001466332739918E6241E7663),
    .INIT_6D(256'h0000001040000800020000008984000000802221000000000000000000020084),
    .INIT_6E(256'h0000400000000020101000000000000000008080200000001080000000001006),
    .INIT_6F(256'h04C0200000000000800000008002000000000000000000004000400000000000),
    .INIT_70(256'h2000000000000040000000000000040004010000000004000000000200400000),
    .INIT_71(256'h8010000001C04000000014000100000400000000005000000000008040000000),
    .INIT_72(256'h840000003800800000020060800000C000810000030010000000000010000000),
    .INIT_73(256'h00004080011000400000201010800C0000000000000000000000000200000000),
    .INIT_74(256'h11480204000000000C0800E00000040000000000000001000000000000010000),
    .INIT_75(256'h0040000000000000002000000000800000040001010400080000000000000460),
    .INIT_76(256'h0004000000000000020000000000020000000010000C00020C00040000001028),
    .INIT_77(256'h8000081000000000021000000000000200000000000064000000200000000011),
    .INIT_78(256'h0060000000040C000000A0031000010001000000100080004004008000000001),
    .INIT_79(256'h02000000020008000000000C2000000080000001200000000008000800004000),
    .INIT_7A(256'h00000032000000001000100040100300000080060000000406000100C400014C),
    .INIT_7B(256'h0190004000200000400000040098000000000000000000000000000000000010),
    .INIT_7C(256'h00000000E00000C0004200000000000000001000180001000020000000040000),
    .INIT_7D(256'h14210004002C4000000000002000000000000000020000000000120000008080),
    .INIT_7E(256'h40000001C80300020000000000400000000201000C0010102000009080448000),
    .INIT_7F(256'h01000040010000000000000020880C0001400600003000800000002400000080),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized4
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFC03E207001F007820FC083F80259340F03AA58007C10780F8107F883E10E03F),
    .INIT_01(256'hFC0BF0008201F01F8081E07E47C10FC21F00803C01F010E0783C07C4F801F800),
    .INIT_02(256'hE74787F0078038E1FC080E07C0F00FC01C1CF802300F8007C1F008F00FC27C00),
    .INIT_03(256'h007C07047C7E43E03C878103810F107F01F043E1F023E040E03E1CC6469BDC46),
    .INIT_04(256'h620E2E43FA420F01FE007C1E784F87F103C21821E100FC0FF103802070478427),
    .INIT_05(256'hE1F0783863F0307C181C01C3860F8387C07C38F87C70FC201C0810718081F8FC),
    .INIT_06(256'hC1F070FC3C1F078380F3861F00F0E1C1F0C3E018F8061F0FC38C6387C3C3C1E1),
    .INIT_07(256'h03F03C1E1C7C007F078F80F1E1E1F0C0F01C0E1E1E1C1E01C387E1C1E1F1F0F8),
    .INIT_08(256'h38F81F0F0F0F870F8039E01FC0C3E0787C3C38107C087C070FC31C7187F03838),
    .INIT_09(256'h181F0078E70F81C3C1E3C03C381E3C0F861F070E07878FC3C3C1386078303C7C),
    .INIT_0A(256'h8C0F83E060E0E1F0301F1C43F80F1E1C3E07C1C1C1C1E0E01C38739C783C3C7E),
    .INIT_0B(256'h01E3C3C3E1C1F0E1E03C7C2078078F070F83C3C0E0E187E0E0E01F0E3C0E11C3),
    .INIT_0C(256'h81E7C0E3E0F0F0783C030E0C1E08F1C787C1C7C1E1F0F1F038FC31C71C3E081E),
    .INIT_0D(256'h81C1E0F8F078783C3C07870E1FC70F03C0F1F070F0F03C3C0E1C030F0E1F0787),
    .INIT_0E(256'h70F87C3C3C0E3E038F01C3870F8073E1C1F8E0F00E38307C07070C78C607C383),
    .INIT_0F(256'h787C0E387E1C3E07060383821F801C18E1F81F0E3F0F0F8707878478E1E3C03C),
    .INIT_10(256'h1E1E1C1E1F0E1E00F0E1E1E070F0783860FC3C380E1F0C0E00E0C278E1E1E078),
    .INIT_11(256'h871C3C03E1C60F8383E1F0F0F1F0707E3C1E07C383E7861F8061E1C3389C383E),
    .INIT_12(256'h1E0C1F87CF8387C078783C783C3821F8103E0F8F00F1C383C01FE08F3C7C3C07),
    .INIT_13(256'h3E0781E3F0E03C18E1E038781E1E1E0F078F001E01E0E1E3C0E0781E381E0E1E),
    .INIT_14(256'hC1C01F80F8F0F8F0783C1E1E1C3F0787C38F821FC038F078F83C381867187C0C),
    .INIT_15(256'h7E607878E07C61F03C1C1C0F8F0F8381C0E1E1F0607C387C1C1F0F1E1E0F0F01),
    .INIT_16(256'hF1C0E3E01E3E07C7181E09C38707C23E31C1E0F1E0707C38781C1E0C79C1F0E0),
    .INIT_17(256'hF1F0781E07C61E3F0F8F03C3E203E1C0F803F0783C03C6183E0C71C3E381F1E0),
    .INIT_18(256'h079E207F0E0F0FC7838FC238E1C1F0F8FC703E3E1F107E0E0787E3F2186183F8),
    .INIT_19(256'h3F1E0383078381C7C078F01C38F0783C1C3E1F1F870E0F83F3C380F00E387C38),
    .INIT_1A(256'h071E070781E1C0C3C031E03C70707C061E078707C383C38303E1F0E0831C0C1E),
    .INIT_1B(256'h0F07801E03078101E081F03C78007C10FC08FE041E030F81C3C01C3C0E1C0E0F),
    .INIT_1C(256'h030F801F00E0F838381E3E3C3C1E3E0F07041E020F01C1E0C1E060F0230E1078),
    .INIT_1D(256'hC1E1E1E0F01C3C71F807C70F1F078F03C1E3C1E0783018707C3830700E3C0F0F),
    .INIT_1E(256'h701C30787871F003C70F1F0C70C3878387C1C1F0F87070F0063C1E0F0CE303C1),
    .INIT_1F(256'h7878F061FC3E0E187E00FE071F01E1F1C0E0C0F0383C1F1E007C038F0070E03C),
    .INIT_20(256'hE0783C01F81F1F083E01F1E071E1C1E00C78707C383C187C0F87861F821C61F0),
    .INIT_21(256'hF03C3E003E0F8F8603C3C7C1E1E0E0F070F80E1E007C0C0F07070271F01E3803),
    .INIT_22(256'h7C1C1E0F1F0383C3C3C1F0F81C3870F8238F183E0707878383CFC0F1F0CE1C03),
    .INIT_23(256'h0F870F01C3E3F1E181F883F078FC1E1F1C1F81C3870FC1E1E1F0F03870071C30),
    .INIT_24(256'h0781C3E3E3C1C7E0F0781C381F0F181C01C3878380E0E183F038787C1E318E06),
    .INIT_25(256'h10000000000000004040C0000002000000800001000000000000000F8E18F18F),
    .INIT_26(256'h1100000020000000000011000000080000400480000000000002020608060008),
    .INIT_27(256'h0000002000000800000300010000000000000000000800000008000000008000),
    .INIT_28(256'h0002000000000000020000000400000000000010000000008000000000000000),
    .INIT_29(256'h0000008104202001010300000000400022080000030008090000000000000E00),
    .INIT_2A(256'h000180841101C004000000000000000000020280000000000200184008004000),
    .INIT_2B(256'h0000088000000102040000000080000000000008800400010100000000000000),
    .INIT_2C(256'h0000100480000000200008020000000002000100000000001000000000000000),
    .INIT_2D(256'h0002000000008000000020000000001000800000000000000000000000000400),
    .INIT_2E(256'h0000000000000840000000010000200000000000000000000000000000000006),
    .INIT_2F(256'h0150280000040000000100000000200000000000003018000008020000200000),
    .INIT_30(256'h8081000020401000000000000001200000000010000000000510000000000000),
    .INIT_31(256'h0800020000000000000008001020020000000000000000088000400000000000),
    .INIT_32(256'h0000000000300000000000000000000000041000000000000000000000001002),
    .INIT_33(256'h0000002000200040C08000002100000800004000000000000000000020000000),
    .INIT_34(256'h020020A002000020000000000800000000000000004000000000000000004080),
    .INIT_35(256'h00C0000002010000000004280000000810040000000000001020000001022008),
    .INIT_36(256'h000000000000000001000000004000000004000C000000200000000000000000),
    .INIT_37(256'h0000004000000021000000000000200000000000000000000000000000000001),
    .INIT_38(256'h2100000000000088041002000000200000024000000000000000000000000000),
    .INIT_39(256'h000100900000000004202260000000000000000000000C000000010008000008),
    .INIT_3A(256'h0000000000008000000000020000000000000010008B00000000200000000000),
    .INIT_3B(256'h00000000000000000000000200000200000A0002000002000000000000000000),
    .INIT_3C(256'h0000200200C000000C0000000010000120000000040002000008000400000000),
    .INIT_3D(256'h0000000E00040000800000000001000806202000000100200000200011000200),
    .INIT_3E(256'h00000000040010000000000001E0820000000000000000087003000906000000),
    .INIT_3F(256'h44000000200000000802100400000000000C0060000000240000800000000200),
    .INIT_40(256'h00000020004080010002040200004000000000800000000100A0002000000000),
    .INIT_41(256'h0000040400004200000000000000000000404318001020200000000000000000),
    .INIT_42(256'h0000040000000000400000000000301000000004000000040000002000000000),
    .INIT_43(256'h0001008010000000000000000000000040000000002000200100284080000000),
    .INIT_44(256'h0000002000000000020000800800030000000000010020000000000200000000),
    .INIT_45(256'h0000000200001000004000000040000000000000001800000000000000040020),
    .INIT_46(256'h00010000400000000E0010000100000000000000000000000002000000000001),
    .INIT_47(256'h0008000800000000000000004000000000000000000002000000000000000220),
    .INIT_48(256'h0000200000000000000000000008000400020000000400000004000900000004),
    .INIT_49(256'h0000100080180000422000001400000002000018000000000000000001180000),
    .INIT_4A(256'h0000001000000000080000000000000200002000000200000000000000000000),
    .INIT_4B(256'h0000000600000000000080000000001000000000000000020000000000000000),
    .INIT_4C(256'h0100000800000001000000000100000000000400000000000004000000000000),
    .INIT_4D(256'h0000000000040020000000000001000000012000000404000000000000000000),
    .INIT_4E(256'h0000000000030000002020200000000001000700000000000000010000001000),
    .INIT_4F(256'h0400200002000020100040000840000000200842000000000000800000040000),
    .INIT_50(256'h400000000000000020000D000008012008500000440000401000080000090000),
    .INIT_51(256'h0002000000000000010000000040000000001300401000080030000000000800),
    .INIT_52(256'h008080020400002000180200000000800100000000000001C000000000000000),
    .INIT_53(256'h0010000032040200000000000000000001800000000000200200000000800000),
    .INIT_54(256'h0000000002080100090000000000000000008000000000041000000000000000),
    .INIT_55(256'h0040100000000000000000000000000000000000000000040000080008000000),
    .INIT_56(256'h100070008000000000000001000001000000000801000000000000002000A000),
    .INIT_57(256'h0040000040000020220400000008000019000010000030820000004000000000),
    .INIT_58(256'h01004000000800010300000010000004000000000000808000000000400100A0),
    .INIT_59(256'h000000380200000000000000E000002000000000000000240010000000022200),
    .INIT_5A(256'h0000020000000000044010002002000000020000020020040000000002008040),
    .INIT_5B(256'h0000000228000020001001100020000000424000040008000800010000000000),
    .INIT_5C(256'h0000000020000000000000380000400000000000000000200001000000000000),
    .INIT_5D(256'h0000000000002040000000000000008000000000200004002000008000000000),
    .INIT_5E(256'h0022000800060000002000000200000004000804000000008001000000020002),
    .INIT_5F(256'h0100000000000080000110000000010200000100010000001001040000000000),
    .INIT_60(256'h0000000000000000100000000000100C00000000000000018000001000010000),
    .INIT_61(256'h0000000000000000000000000000001000000000008000030001000000000000),
    .INIT_62(256'h0787F08F1F0070F030F8F0783F0E38F00E71C3183C01C1E078E7807878038781),
    .INIT_63(256'hE0E78700F0F863E0E03C1E18E3F0E1C700783C18F1E01C3E0C707839C7C31E1E),
    .INIT_64(256'h3C1C78E0C7CFC71E3C1E03C19C1E03830C0FE1C0787C10F8303C71C0E07C31E1),
    .INIT_65(256'hE1F1C383C1F07807C3E03C3E18F1F00783870F0E1C78F10F1E0C7C7043E3C31F),
    .INIT_66(256'h0F3E1078F0781F80787803E3E18F1F8078780FC7823E3E1F87E07871C0707C21),
    .INIT_67(256'h21E7C10E1F8078786183E0E38E1071F00F0F07873831F0F0E38E0F1C3C63C780),
    .INIT_68(256'hC3078703E0E01E3E07073C20F1E07E180E1C707C63C39E0E1E38E00F0F043C3E),
    .INIT_69(256'h3827C7E1070F00703C01E1C3078710783887C7838E1E073831878381E1F80F01),
    .INIT_6A(256'h0F823E0E01E0F887C703F87E0F87E01E1F0C38383E0F831E1F187838C1E1C41E),
    .INIT_6B(256'hE0F81F8F80F81E0E078C0F87C07C1F01F0701F83C1F838301F00781E087E700F),
    .INIT_6C(256'h0000080002000000000001010000002800000000010783C07C1E00F8381F8783),
    .INIT_6D(256'h0000001040000800020000008984000000802221000000000000000000020084),
    .INIT_6E(256'h0000400000000020101000000000000000008080200000001080000000001006),
    .INIT_6F(256'h04C0200000000000800000008002000000000000000000004000400000000000),
    .INIT_70(256'h2000000000000040000000000000040004010000000004000000000200400000),
    .INIT_71(256'h8010000001C04000000014000100000400000000005000000000008040000000),
    .INIT_72(256'h840000003800800000020060800000C000810000030010000000000010000000),
    .INIT_73(256'h00004080011000400000201010800C0000000000000000000000000200000000),
    .INIT_74(256'h11480204000000000C0800E00000040000000000000001000000000000010000),
    .INIT_75(256'h0040000000000000002000000000800000040001010400080000000000000460),
    .INIT_76(256'h0004000000000000020000000000020000000010000C00020C00040000001028),
    .INIT_77(256'h8000081000000000021000000000000200000000000064000000200000000011),
    .INIT_78(256'h0060000000040C000000A0031000010001000000100080004004008000000001),
    .INIT_79(256'h02000000020008000000000C2000000080000001200000000008000800004000),
    .INIT_7A(256'h00000032000000001000100040100300000080060000000406000100C400014C),
    .INIT_7B(256'h0190004000200000400000040098000000000000000000000000000000000010),
    .INIT_7C(256'h00000000E00000C0004200000000000000001000180001000020000000040000),
    .INIT_7D(256'h14210004002C4000000000002000000000000000020000000000120000008080),
    .INIT_7E(256'h40000001C80300020000000000400000000201000C0010102000009080448000),
    .INIT_7F(256'h01000040010000000000000020880C0001400600003000800000002400000080),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized5
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [12:0]addra;

  wire [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [12:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hCEE800A20824C38C8E48C6CA2408E300AAC20EEAA048CCC03A88A0EAA4A300EE),
    .INIT_01(256'hC3E43E368A2E6A60306E8688800A3224EAE4C08C443606AE8AC30868800400E0),
    .INIT_02(256'hE6A320A0E03EE4CA4ACE4220028328A48323E4446AA484603C02844CA6C4A602),
    .INIT_03(256'h000000055544433332221111000006655544443332222110000CEE3A6643E40E),
    .INIT_04(256'h0000065554444333222111110004444433332222111000000333322222211111),
    .INIT_05(256'h0006555443333332211100000554444333332211111000032222222211111110),
    .INIT_06(256'h0554444333222211100000066655544433322211110003332222211111100000),
    .INIT_07(256'hC0028A600AEA0E48CA08CC0E0A0C424E0008E020AC0333322222211111100000),
    .INIT_08(256'h0E08E633E4A0338A28020E6C3C00A420066084E80020E4036C2A0020308C8C46),
    .INIT_09(256'h20E0000330AA02E8038C00404CC46060A00802333A2003033A0C3000A30EAC00),
    .INIT_0A(256'h3033E63EE02E82E30AAE30AE2486860640480368040806400C008E6608032060),
    .INIT_0B(256'hA33A4226060002CA00E600400CA00E0033A0EC0A0E0AE2E6286268C4C22E0333),
    .INIT_0C(256'h040E04A22A08AC433E028E3E833A800062CC0820C0A6A44462AC8330808A00E0),
    .INIT_0D(256'hC006C8E30A00EA006640EA00CEE040A6C800800A002A88084EA24C8C002C00E4),
    .INIT_0E(256'h0000000A22083300A8C324828064636A3000C0400C02060AA0EA040460606E0E),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(4),
    .READ_WIDTH_B(4),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(4),
    .WRITE_WIDTH_B(4)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:4],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized6
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h007C03F80FE003803F000FC00009058AA553492AF801F83F001F800FC01F002A),
    .INIT_01(256'h000C000F03FE006000FE03807801F003E00307C0FE001F0F80401807003E003F),
    .INIT_02(256'h4A780800380FC70E007030780700F003E0E0003CC1F001F80E000F03F003800F),
    .INIT_03(256'h0781F80783807C00C0F801FC01F01F801E007C02003C007F01C00E8764D29094),
    .INIT_04(256'h43F0507C0383F01E038F802000703801FC03E03E01FF00F001FC07C000780038),
    .INIT_05(256'hFE007FC07C003F801FE001FC07F003F8007FC0FF807F003FE0771F8200FE0100),
    .INIT_06(256'hFE007F003FE007FC00FC07E000FF01FE00FC001F0007E00FFC007C07FC03FE01),
    .INIT_07(256'h7C003FE01F800F8007F000FE01FE00FF001FF01FE01FE001FC07FE01FE01FF00),
    .INIT_08(256'h3F001FF00FF007F0003E01E000FC007F803FC01F800F8007F0001F81F8003FC0),
    .INIT_09(256'h1FE0007F07F001FC01FC003FC01FC00FF81FF80FF807F003FC003F807FC03F80),
    .INIT_0A(256'h0FF003FF80FF01FFC01FE07C000FE01FC007FE01FE01FF001FC083E07FC03F80),
    .INIT_0B(256'h01FC03FC01FE00FE003F803F8007F007F003FC00FF01F800FF001FF03FF001FC),
    .INIT_0C(256'h01F800FC00FF007FC003F00FE000FE07F801F801FE00FE003F0001F81FC00FE0),
    .INIT_0D(256'h01FE00FF007F803FC007F80FE007F003FF01FF80FF003FC00FE003F00FE007F8),
    .INIT_0E(256'h80FF803FC00FC003F001FC07F0007C01FE00FF000FC03F8007F8007F07F803FC),
    .INIT_0F(256'h807FF03F801FC007F803FC03E0001FE0FE001FF03FF00FF807F8007F01FC003F),
    .INIT_10(256'hE01FE01FE00FE000FF01FE007F007FC07F003FC00FE00FF000FF007F01FE007F),
    .INIT_11(256'hF81FC003FE07F003FC01FF00FE007F803FE007FC03F807E0007E0003C01FC03F),
    .INIT_12(256'hE00FE007F003F8007F803F803FC03E001FC00FF000FE03FC01E0000FC07FC007),
    .INIT_13(256'hC007FE03FF003FE0FE003F801FE01FF007F007E001FF01FC00FF801FC01FF01F),
    .INIT_14(256'hFE03E000FF00FF007FC01FE01FC007F803F003E0003F007F003FC020781F800F),
    .INIT_15(256'h7F807F80FF807E003FE01FF00FF003FE00FE01FF807FC07FE01FF01FE00FF001),
    .INIT_16(256'hFE00FC001FC007F81FE001FC07F8003FC1FE00FE007F803F801FE0007E01FF00),
    .INIT_17(256'hFE007FE007F81FC00FF003FC03FC01FF00FC007FC003F81FC0007E03FC01FE00),
    .INIT_18(256'h07E03F800FF00FF803F0003F01FE00FF007FC03FE01F800FF807FC001F81FC00),
    .INIT_19(256'h3FE003FC07FC01F8007F001FC0FF803FE03FE01FF80FF003FC03FF000FC07FC0),
    .INIT_1A(256'h07E007F801FE00FC003E003F807F8007E007F807FC03FC03FC01FF0003E00FE0),
    .INIT_1B(256'h0FF807E003F801FE00FE003F803F801F000F0007E003F001FC001FC00FE00FF0),
    .INIT_1C(256'h03F003E000FF003FC01FC03FC01FC00FF807E003F001FE00FE007F0003F01F80),
    .INIT_1D(256'h01FE01FF001FC07E0007F80FE007F003FE03FE007FC01F807FC03F800FC00FF0),
    .INIT_1E(256'h801FC07F807E0003F80FE0007F03F803F801FE00FF807F0007C01FF000FC03FE),
    .INIT_1F(256'h807F007E003FF01F800F0007E001FE01FF00FF003FC01FE01F8003F0007F003F),
    .INIT_20(256'h007FC03E001FE00FC001FE007E01FE000F807F803FC01F800FF807E0001F81FF),
    .INIT_21(256'h003FC01FC00FF007FC03F801FE00FF007F000FE01F800FF007F8007E001FC0FC),
    .INIT_22(256'h801FE00FE003FC03FC01FF001FC07F0003F01FC007F807FC03F000FE000FE07C),
    .INIT_23(256'hF007F001FC03FE01FE00FC007F001FE01FE001FC07F001FE01FF003F8007E03F),
    .INIT_24(256'hF801FC03FC01F800FF801FC01FF01FE001FC07FC00FF01FC003F807FE001F007),
    .INIT_25(256'hFB845F14F5FFA98CDEDAEA2ADC7F63991C942309DCF2AA29A3A6178FF000FE0F),
    .INIT_26(256'hF5AA5FEDB80D0260210933F3BF873EDFEC7FCE824038A20C542E67B6E8D6CAEB),
    .INIT_27(256'h2902D43C66433847606F6BDDE2C1FB811205EA193D1E24DBBD8865816FE88654),
    .INIT_28(256'h9143288CA049A2AC5704B9685DD6A426878602D2B15C1140D1F20B76124DAB08),
    .INIT_29(256'h4CAF0881E7702333EDDBBE341759C1247F0BC5082B90EFC981D01BD8AC769F87),
    .INIT_2A(256'h6919BEED7559C334A317716606B246A32B07BBC18B79B23EABD8F8563FC0E1A0),
    .INIT_2B(256'h4C5089C94E8BBBA3A533199A5DF4E5F4B7536CB982649E57772DB1E760A67CA5),
    .INIT_2C(256'hFF8951ACEAC573DE250DA8CE76E92085C7B369D5D0A0E49859048260190C010C),
    .INIT_2D(256'h19A295EE8CC7E7687C0DE1CBCC8D9DB26ABCD076DC228E461816EEE62CB177B4),
    .INIT_2E(256'h4EE034264E40FAC8FF8A7E830815FBDAFE098303212246D4D06640044898012F),
    .INIT_2F(256'hC1F178E21E7C99D7AF49FA4BA14EEDDB47945B3BE2B97AFB413D231244A7A9FF),
    .INIT_30(256'hBBA167C62DC8B9D9F11B5E5AAD116FB8C0C20D5A98DB9942FD543C35E31625E7),
    .INIT_31(256'h1FAAEE167CDBE6BD0247B92536B466B29434E4115359364AF72846101007160E),
    .INIT_32(256'h2A8CE22C36F353CC5FAEDAA5013CDBF3E116BB994820F4CADF2B4D5B54473B17),
    .INIT_33(256'h20DCB2FB2126287DE1C0DCECA91D505BB182D465039010B2804EA5BC63EA6ED9),
    .INIT_34(256'h3FF570A35BA97AFC6999303298629DDE7A4626FA03C40BB8BB6B9E45451A70C9),
    .INIT_35(256'h40F4E7E847B3D1034B41E62B36F2B02973741080988F23097A32E05453E7E90B),
    .INIT_36(256'h42C95CE52A728727452B8E007CF4E577470434CD2B88402906978A2C541F09B8),
    .INIT_37(256'h939CB86E45960035F7EA2F044FF8AA7CC2B0CD487E4AEF24C43BF9A45222B693),
    .INIT_38(256'h67AB3905D49871F934BD234C364939F7C78361310068B5293BC46A7AC7954090),
    .INIT_39(256'h42852CBFC00829464723E3EA8EE39D5DC68C6A0A0C6A5CBFC14445CFFC002CCB),
    .INIT_3A(256'hD173C742E787900F052700F7192F1F00EC2E1E321F8F94F274336CA66D5639D0),
    .INIT_3B(256'h3CBC887DE056EE88169EF133E364A36C670F1783FDD632AD3343F21096F41BC2),
    .INIT_3C(256'h231664B332FB9C728C19EC67C93E4A8FE8654210B4FC631EC07A50EEA6818830),
    .INIT_3D(256'hE00E86DE1C173284A85A7E215A552E1867386E571203F66087C7E1C9136ABE07),
    .INIT_3E(256'h0E5CC0B3251FBD3024A5BB1FA1F28F592294E51006210D587A5F7A5DAE9C81EA),
    .INIT_3F(256'h5610693CA0C0441B0D3B964405813568588F58EB74F539EC65AFE58CB81BB2A9),
    .INIT_40(256'h0589F1A83674CBBFE5FE6F82129254E682A8CABD4441E46104A7AC332A00DFFB),
    .INIT_41(256'h005A3D27C262F3E46B7B411C7A84A0A6A0C173BDC61DA4E78EEC0DB0B7694A72),
    .INIT_42(256'hD312BEE5D4852B2DDE13BBF6974B3CD68C20569C9BA5CC3D8807B9EBE740A213),
    .INIT_43(256'h0131DB8D1468899079A84325A6660028CA58724FA6F0BCED37A47973F058F729),
    .INIT_44(256'h04BB6820ABB144DB33661EA44E894BF666226DF16B48B908592EEDAB53A4FBA8),
    .INIT_45(256'hB883DDAB797A19B23179AF8558DE6283D09A2607729A1B216942BCC541B50AF9),
    .INIT_46(256'h0ED9F0336E2004B96FC676820F927692901D1E9C41ED15291AD6A8DB13C803CD),
    .INIT_47(256'hF7580EDCD044BD5E39CE8D96E44FCC919409C0784AE22A6AF289B7493DF51AA9),
    .INIT_48(256'hB538B799C32F907F62F0F00580BDB396968B897E309C1116F94DE8892D70CACD),
    .INIT_49(256'h847F55BAA73F4FC45A2DD0265E50B73663D4C55C70D7AC41A8B50BFA2DFB8C01),
    .INIT_4A(256'h266E36DC662800152BF7996E88E4B26B90ABF40D849A8B24B12A4A2190B0DCF1),
    .INIT_4B(256'hC144733E49EF3DC2DE56FCEC7DA8E87739AAE52602302BF7BC040D44F4C24148),
    .INIT_4C(256'h1BC9595984BDD623ACAC5110E1B6B3800B4DBC81052B3C4EAA075FA48855D654),
    .INIT_4D(256'hA20C43E36A152520D3DA77557EA34E49796D6BAFC185FE105E720254FABA473F),
    .INIT_4E(256'h6460834FB3C702AEE137A8E82F07A62085442F14805B255A2C0571F5191A5764),
    .INIT_4F(256'hDE52A10202217EBFBC22CD130E69B654C8A58DE3C1CC48BA010FF8DC44642059),
    .INIT_50(256'hE4F50C53543992D4232E6D35C17825BE6FD2F1F7DCE24BEEB8499D1507CB44C3),
    .INIT_51(256'hD9B38A52988D315A9D94006537D4B41330E07784489513797A72E9C6909ECD73),
    .INIT_52(256'hF890A4969DE448E3919A030854DCF5F60500BE396E64F0DFFC0A9500832915A7),
    .INIT_53(256'h253FEEA172E7D718C538B3E8CB8D45547BE4E65F6020953F12C1662A178571FC),
    .INIT_54(256'h25FF003C46ADB1869BAF1C1D20377D0B5929A6EA02D820D5BC633970267CA4A1),
    .INIT_55(256'h0D5C17188A8C1F6BE96DEE49F869240E7A5B609ACE6103A64C6A1BC3384015EF),
    .INIT_56(256'hBC59FC4D9498CEA3651DA0732C4D835DB44ED95E1D1C47CD4940A544E562A040),
    .INIT_57(256'hE3724000466070783B4E3676AF6F1015FDE3817C4FC133B6A20B7746C4206CB5),
    .INIT_58(256'hB7FF5951F00E51A52BC77094F172B9E770236382E025F298640F841FD1BB00A1),
    .INIT_59(256'h804228FC0FBA79B3C0100DA1F933BB384D56022B0B18F52EE510E43C9B1F2EC7),
    .INIT_5A(256'h16A8FB980A2031C92CE8B8CF2427E22A2BCB57864F067FEE933A10650725E875),
    .INIT_5B(256'h4F7CAC93EB6F187DCB1C677B7239BE35CDE6C1002E6F8B120EEA6DF052C63D00),
    .INIT_5C(256'h1C88410B68B8E496D8B2F07A11CBEF8C5BC3254ADA04BCAB9107990916624854),
    .INIT_5D(256'h284892E1209DA0DE46567BB44938B7EAEA039775E06AEC57E2558B9BD13D0543),
    .INIT_5E(256'h066AF82CF94E2845F1B40339BA3B22D66DA59D55A9ED1160DD2D26E5C462AC6B),
    .INIT_5F(256'hA96E7E262C80428672D5FB2D69F20D321AD4DD8DE78908179679047B63EDE592),
    .INIT_60(256'h46889C57693256385F99E67358493B5D4922AEFCC81D0327B59C7A984EA73EE3),
    .INIT_61(256'h3848AC7D8E84DE63C27196080F52E2D1102B1E41F1D860770A433BC97B03A7F0),
    .INIT_62(256'h07F8000FE0007F0000FF007FC0003F00707E001FC001FE0080F8007F8003F801),
    .INIT_63(256'h0107F800FF0003FF003FE000FC0001F8007FC020FE001FC0007F8041F8001FE0),
    .INIT_64(256'hC0007F0007F0001FC01FFC001FE00C03F00FFE007F8000FFC0C07E00FF8001FE),
    .INIT_65(256'hFE0003FC01FF8007FC003FC000FE0007FC000FF0207F000FE0007F8003FC001F),
    .INIT_66(256'h0FC0007F007FE0007F8003FC000FE0007F800FF8003FC01FF800807E007F8001),
    .INIT_67(256'h01F8000FE0007F8001FC0303F0007E000FF00007C001FF0103F0001FC003F800),
    .INIT_68(256'h0007F803FF001FC00007C000FE007FE0001F80007C001FF0003F000FF0003FC0),
    .INIT_69(256'hC007F80007F0007FC001FE0007F8007FC007F8040FE0383FC007FC01FE000FFE),
    .INIT_6A(256'hF0003FF001FF0007F803FF800FF8001FE0003FC03FF0001FE0007FC001FE001F),
    .INIT_6B(256'hFF001FF000FFE00007F00FF8007FE001FF801FFC01FFC03FE0007FE0007F800F),
    .INIT_6C(256'h6406EC2502A8F963AD001BA9AA438BF9402B87DCDD07FC007FE000FFC01FF803),
    .INIT_6D(256'h3BB7CBD3408EFCE0534C0E01EDB769D7A1922BF3482D160870EE6DDD7B32DBCC),
    .INIT_6E(256'h5577D04F8673A320387FBF41E48698980C96FA902E02D842B8885459C418F447),
    .INIT_6F(256'h16CAFDC72AEB0135CFD5B74FE3029C2685A82CF4B1D1A0325926416EBB267FEB),
    .INIT_70(256'h653BC5C11668F2437E44353856630638BEFF4293FCAE4D9A427A51C208C7AC7D),
    .INIT_71(256'hB054769D01E8714423C1FD98D75F0457531B68D81D751032D84071D2C08431BF),
    .INIT_72(256'hCE6F6DE4BECC948BB88720ECB8AE58D04BBB2462D3E85FF5226F1D43727640CE),
    .INIT_73(256'hCD69CFF50950F45E2331FD9F37E0BDF208E076A287109ACC7BC0C90F6E013EBB),
    .INIT_74(256'hB7ED1B75E8B1EED88EBF0FE1595B1EA9D6008F023E3CEF37885C3D7638CB4ECE),
    .INIT_75(256'h6ECFBA6AF1018656D926D09DCF29BAD04ACDF5C93917697989BD16F3F4C28EF1),
    .INIT_76(256'h0E64F8A4F23A26AB866C15208C0196390CE8049A6A0ECC0E2C400E9FAA3B93A8),
    .INIT_77(256'hB4E0CA3F3A3DBAD78237B15D9B8269E6613801DC6D6A6E55F3FFE04387836051),
    .INIT_78(256'h027580DF6FAEAD1DA20CFD235F31BDB8D9F137BAF916AF73DF2525DA4ED946C3),
    .INIT_79(256'hA7F577FB1A742B04C677906F705F9B078EF5CFC5BF08FC7205BEA26CC3CD79D8),
    .INIT_7A(256'h7AC15ABBB88BA807184CF44CC09C839E857A84C6761374A66E2343A1DE7263CD),
    .INIT_7B(256'hCFB76F5E6E29E4B5703040E567D95C4F5347C0AADB56C667F87C65A622981D1B),
    .INIT_7C(256'h6A06994AE752C3E715677AD45F59E96D530D743DFB159D34F53F8225BFCE49CD),
    .INIT_7D(256'hFF2BFCEEC0FEE47F24C67905AA65175AB32345B50F3368C9043FFEB05D29FEB4),
    .INIT_7E(256'hC64D0E51E823D112BCD40A0F59F4FC47AD8A3B60DD9A12D8E260A99BBF7797EA),
    .INIT_7F(256'hD549CBE58B7A7C8D4D44D39D358E7E9207CACEFD647089A2CB282027213701FA),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized7
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h7014366AF8083AC43B2B18800C0E060CC66071CC71A49D84EFE077A1CB046E0C),
    .INIT_01(256'hF4DEE325139227BBA38888B22033CE81817286807ACD8DD4D386CF84DE30875A),
    .INIT_02(256'h8C48EBA49C673EE2465F35040BE9E0798E0079AC613BC7DA3B39BF58F682C240),
    .INIT_03(256'hA55A5A8F2C082EBCE1D16E54905929B1BFDAB3B937B9E478FD410F0780E0E118),
    .INIT_04(256'h1A282F6087F3D32AFC8C84F76ECFE122F15A001481ECB13F105BA231608F5C41),
    .INIT_05(256'h000080000000000000000E0000000000018000000000000C0F4776349ED8FF16),
    .INIT_06(256'h00000000000018000F000000030000000000006000380010000F800000000000),
    .INIT_07(256'h00000000000000000000030000000000006000200000000E0000000200000000),
    .INIT_08(256'h000000000000000003C000000000000000000000000000000003E0000000C000),
    .INIT_09(256'h00000F8000000200000000C00060003000000000000000000001C00080004000),
    .INIT_0A(256'h000004000300000000E00000003000000008000600020001E000FC0000000000),
    .INIT_0B(256'h0600000000000000004000000018000800040003000000000000600000001E00),
    .INIT_0C(256'h0200010000000000003C0010000F0000000200000000000040003E0000000000),
    .INIT_0D(256'h00000000000000000018000000000000000000000000400030001C0000000000),
    .INIT_0E(256'h000000400030001C000E000000038000000000007000000018000F8000000000),
    .INIT_0F(256'h0000000000000008000400000001E000000060000000100008000780020001C0),
    .INIT_10(256'h0020000000000007000200018000800000000000100000000700038000000080),
    .INIT_11(256'h0000000C000000000000000000000000000018000C000000038001FC00E00040),
    .INIT_12(256'h00000000000000018000C000400000000000000007000000000000F000000038),
    .INIT_13(256'h000000000001C000000040002000000008000000020000000000006000200000),
    .INIT_14(256'h000000010000000000002000000008000400000001C000800040003F80000000),
    .INIT_15(256'h8001800000000000000000000000040003000000008000000020000000000006),
    .INIT_16(256'h000000006000380000000E00000003C000000000000000000000000F80060003),
    .INIT_17(256'h0000000038000000000004000000000000000000003C0000000F800400020001),
    .INIT_18(256'h7800000010000000040003C000000000000000000000000000000003E0000000),
    .INIT_19(256'h00001C0008000600038001E000000040000000000000000400000001F0008000),
    .INIT_1A(256'h180008000600030001C000C000000038001800080004000000000000FC007000),
    .INIT_1B(256'h0000000000000000000000400000000000000000000000000000E00070003000),
    .INIT_1C(256'h04000000010000C000600000000000000000000000000000000000003C000000),
    .INIT_1D(256'h0200000000E000000038001000080004000000018000E0000000000010000000),
    .INIT_1E(256'h01E000800000003C0010000F800400000000000000000000380000000F000400),
    .INIT_1F(256'h00800000000000000000000000020000000000004000200000000C00078003C0),
    .INIT_20(256'h00000000000000000006000380000000F0000000000000000000000003E00000),
    .INIT_21(256'h0000000000000000000000000000000000003000000000000000038001E00000),
    .INIT_22(256'h000000000004000000000000E00000003C000000080000000000010000F00000),
    .INIT_23(256'h0008000600000000000000000000200000000E0000000200000000C000780000),
    .INIT_24(256'h000600000000000000006000200000000E0000000300000000C00000003E0018),
    .INIT_25(256'h4529C63C7DDB3F9A0CB00018AD8576323B310B340DA25813970937B0001F0000),
    .INIT_26(256'hC850B54A8001C360216962D67F2E411B013D6B6AC8EA53A865158118E541DF52),
    .INIT_27(256'hADD1D0098863034A408CB960A242E3A653376555D9401CE23EE4519812A55C69),
    .INIT_28(256'h8A20A98D34F4A1864D0BABB95B28201AD1B20FEA0537384B5B8C27BF9304E029),
    .INIT_29(256'hA6A9051AB90F0D4AD2D026F60C1EB4D85081D53FBC0BC5E453A532BCD3478190),
    .INIT_2A(256'h39005E20E01A38A8250D0656023242A7AA21A07D7A3E03D7CD5AC73332F3A204),
    .INIT_2B(256'h3F7E0128125F12F151AF25B0815C53C0B3692D9031D81B6E4AA2FEFA28A350F8),
    .INIT_2C(256'h25026062441E5F908DD8E03814600081719A42B7C223B8D2C7C8DE50312C4017),
    .INIT_2D(256'h1D80B43A8A070D315F6F9962E964B40A54607326ACAB3486E20CFF9135943217),
    .INIT_2E(256'hCED08F4E8AD8D63DDA39B7B40AC7CCC3931B670061B06664911920001989CEE9),
    .INIT_2F(256'h9C2743A00489147F1B5CE7A767CC970BE79AD1382E8F01755973393A70C77A0F),
    .INIT_30(256'h7B082101050B084CF385C42C262A05607C81330FC1C2ACF7F8CF5C067B0371CB),
    .INIT_31(256'h32A00483F7CF9E1C4ADEB662469B588F8C75CD998B65E88311D5045E80B50915),
    .INIT_32(256'h795010A5CF40339800E2AA44A379996B66C82949484A94DA520F1D42540584FC),
    .INIT_33(256'h398906DF0493DCB7032950EC903108128565093D60F030A68D4ECE1D42280BF7),
    .INIT_34(256'h38F9540980EA5287BC7D1837245A854D2782AC59D28C04D35C48A6A6447EAF4C),
    .INIT_35(256'hD1108E6AC4BEF4E947216345C1909081AE3B3AB4A4466D2F204E811654C40D85),
    .INIT_36(256'h06844C3532B64151D4CB8FBD7DA2A3E4478052C3DB11EA55729DB83E54BF2BF8),
    .INIT_37(256'hB094802F0DF2F7C473C93C56F72BCC41DBB9B75C6E4EB375F43BF891E890B01C),
    .INIT_38(256'h46D0922D80121D30C165C914F55D0B66A891A028A111D74D39B5AF7BB009E445),
    .INIT_39(256'h07866E6A579D109EA0CBC50A8E3B0B25378EF58A3AF283B95E56967754207447),
    .INIT_3A(256'hA1509354E4806252D1570C9599D0268EA84192E61440CC9601D24780C917A1D0),
    .INIT_3B(256'h7605E9175205F6EC3B16A530F02BE4A450B17740DF0548B5D755852CF7923768),
    .INIT_3C(256'h5C245F406F01202563E1FC813246689C492A919190E8A8838480967AAA6D5829),
    .INIT_3D(256'hEA06825155C875892AF807162C8CCC01A09EC97611D214DDEFDD1C42C48F51A7),
    .INIT_3E(256'hCEFC6056F0412218E2CCDB8AAC0F455BB95AE1945EA7582104DC7B0418D4C1C0),
    .INIT_3F(256'h1199E9BE1345F01816BCC360550B54019330141D67A19F52C25F3600A71AE584),
    .INIT_40(256'hB67A9414083D40482A2C68910D8E204A28618C686A31E5489701D180BF119A46),
    .INIT_41(256'hAB980960A3839D8A792048147396E0765133B082C7CF818CC3F41C31F3CF1AB0),
    .INIT_42(256'h62DB4BA4D78DE7793803D852C77981AFD8A25D5B9AA1BD6029CAF413E6F0E04D),
    .INIT_43(256'h1D62831384C82581BC50DF0E1C80014625531D5A839150811AE713141B36E882),
    .INIT_44(256'h1EA2C48980F506D539A0AC06811320A55B3C3BE9DE40C3C8E31643A951011067),
    .INIT_45(256'h366843C13A5142126806F7E889B13753D0AA22455280FD823E8AF13B73118C84),
    .INIT_46(256'h6A5AC3673F65021D811187E00A36109214BB1E4C84971CEB8F71982C451DF77E),
    .INIT_47(256'h4F50C753305423CA930AA32131075561CE097038C9AA2CE3C821EB48109BA014),
    .INIT_48(256'h4A22C0C429BB1038E635E40726E49140735548358A792187D021EA742B62828B),
    .INIT_49(256'h971BE98203C31FAC10C999048AD60F0478A27D83B0DBC8C13BB51EDA52800504),
    .INIT_4A(256'h50DEA4C2DC2802157627594F4FFDB63D627C8C109A901DA5F502C329D0A2FC69),
    .INIT_4B(256'h07814478D6AC0922AE72143234FAE86D2984E570957B8B848D6669B9990AC0B3),
    .INIT_4C(256'hB6E38570103EE524A78639B1E28BFF291509F2F64E9A7D0CE6487B32AA518F5C),
    .INIT_4D(256'hAAAA69826C5BFF85BB555FD969146411FC0C50442F393ACCB352C5D47E3F04A4),
    .INIT_4E(256'hA4203F3BF1DC3A9C9852050F420E82280256E82754FFD5730EAF72C5BFFC6768),
    .INIT_4F(256'hF23801CAC9891E00EA3985F1A11D292DE9D1C334ABE26A24300F39E4D4494FD6),
    .INIT_50(256'h277088625C2FA8D69935C0A68D75C48B25855295383B8CAC8181D60D85863F02),
    .INIT_51(256'h2B05F6821911281BAC50816A8E34E41515E588A90E09BC7213C31D563E68C378),
    .INIT_52(256'hBC0A521D3843021428413129788C060600D1BB03D271247034DD1380FA654E37),
    .INIT_53(256'h0607ED4B04E1757F178935FBC488902612113F4A4153DC93914126BDD70859FE),
    .INIT_54(256'h05CC12AEC0855061462A54CD3023737A589A347C32D0C9C3208A5CD9E28679E6),
    .INIT_55(256'h1D8C00B6210CA76ED86DDA23BFB866AC301A45B6B35B45D26AC3D2E674CCB44E),
    .INIT_56(256'h4F190767118A0622811B2F7E44FC4AECC53645D108987810701B7C80D7FA4509),
    .INIT_57(256'h71843C628F6C7C8B089212C347125E5D429A1987CAE38525A9256811BF6CCA61),
    .INIT_58(256'h38A538649D028FAC385582E3C276BA903E456ACAE83128295C60CE9D342CA54C),
    .INIT_59(256'h9A2A0844D82829913805F63A1984188767556A020F80A081C4023C20FA244D72),
    .INIT_5A(256'hAF9BF5C92BCC027D602368C98D090455BC2902581D0943EB0E6BDF1D55844610),
    .INIT_5B(256'hCDC5ADA9812D8D01BA0EE20FE0C081F47530808B225D10C800CE5229414F0740),
    .INIT_5C(256'h3448C6B5CCA4D8DA1B92AC03DE2FB482022312D3BF840BDABB064FD5578669D5),
    .INIT_5D(256'hA56B04A1C58A4D9D335B587FCA924430CA591EFE1274327B183F2B61F40B2B42),
    .INIT_5E(256'h8B549102EB78399C5E097573A80820E3E38F01905F0BC9A0129AFC87C0E01DFD),
    .INIT_5F(256'h141D7A042CCA4306A296C6697B86F4300B2940DE7214BAD2C46A71D54579E316),
    .INIT_60(256'h64A05854E3F8659E25CB856D62AB2A2389809C7EE0B3DC3E7B4905CEC052789A),
    .INIT_61(256'h743C1B1D25969E334028F6242F50AD01D4206D97DE63523482F0E0DB6CD38819),
    .INIT_62(256'h180000F0000780003F000180000FC0007F8003E0001E0000FF000780003C0000),
    .INIT_63(256'h01F8000F00007C0003C0001F0000FE000780003F0001E0000F80007E0003E000),
    .INIT_64(256'h001F8000F80007E000200001E0000FFC0070000380001F0000FF800700003E00),
    .INIT_65(256'h0001FC000E0000780003C0001F0000F80007F0003F8001F0000F80007C0003E0),
    .INIT_66(256'hF0001F800080000780003C0001F0000F8000700003C000000000FF800780003E),
    .INIT_67(256'h3E0001F0000F80007E0003FC001F8000F00007F8003E0001FC000FE0007C0003),
    .INIT_68(256'h03F8001C0000E00007F8003F000180000FE0007F8003E0001FC000F00007C000),
    .INIT_69(256'h00380001F8000F80007E0003F8001F8000F80007F0003FC001F8000E00007000),
    .INIT_6A(256'h0003C0001E0000F800040000300001E0000FC000400003E0001F8000FE0007E0),
    .INIT_6B(256'h000020000100000FF80070000380001E0000E00006000000000180000F800070),
    .INIT_6C(256'h6D91A589A0A3792069E58018E344DF91C2680A5DF678000380001F0000E00004),
    .INIT_6D(256'h98B177620B0A271FCC7E1549441021C38236485A08CEB698A51FF44729E4A962),
    .INIT_6E(256'h872B2E0F82D9E3912589BB1E60A3B69F0C4E470147B20A12C339CC06CD9C2DC1),
    .INIT_6F(256'h8322CC8F4FC9CD1D529310AF4129142F901604DA659AD7C10A34A54A6FD22E6B),
    .INIT_70(256'h5DD53D55153CA0024204B542D04002053BFC0B12EC2BD1886C6AEBB5FA2DE64B),
    .INIT_71(256'h3160A75020308404A56EA998A64A02F2C23F4F08EC0462D7E2586111A3B45D2B),
    .INIT_72(256'h121B7ED7057469CAA77D499800A1E7179A7422EEE8E06FE37E0F100B43A5C18F),
    .INIT_73(256'hBDF807350A24B408D872CF8B8E34F16064215A396F90D3D4EA95006DF0C141D6),
    .INIT_74(256'h02A18873C5B63DE34325BD112943334E38F7ACE56D1D8E57CCDF93269878BAC2),
    .INIT_75(256'h0A1728373545E3B2830599824DBD197922F83C28080226F18495D857AFEE008B),
    .INIT_76(256'hD86A2CB018EB0082A5230F8408029DACC707E245C921768091F221159B21E954),
    .INIT_77(256'h214912A74ECD2755E44941568C2239DCDC00283A436B9013A1AE96C4AB87B1A4),
    .INIT_78(256'h4A95A257E948217CBC125DB427DE6C141A3B8DB747F039B39DE15832AF8B9280),
    .INIT_79(256'h20F366A32D61276B7E8696139649B75527392EE6DA64BD3CA5A6A23431CBA8B2),
    .INIT_7A(256'h68D587894C3AFD00C2ADEFF6876460C037324A101256E0C3E823AEE1383962A2),
    .INIT_7B(256'h2C6CF712FBC9BBB5204D60500A24766D15968E97349CCD21F19CF33420F22903),
    .INIT_7C(256'h928C830E1073613C550D14DC6D4B1AACD7084A3124428ADCB85759C082F0E508),
    .INIT_7D(256'h00D04C48118090DF0135E8895C4544CDFBAC527A28602C816A0FE181B1F15E57),
    .INIT_7E(256'h20518C103774E135A80AB247B721DC30AF193815D2D02CCE00AA8B4A15895421),
    .INIT_7F(256'hE855312B5E7A4EA31525F1949D0213188891008FB487A778728DD41020AE8040),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized8
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [14:0]addra;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hD8813758810C00E02AD37F000430180F078381F06CE14FC0FF8001ABFA9C31B0),
    .INIT_01(256'h3C7807AAD6B423EFE6C9235F138ABC4B8958C64544C2F4DE9A804E196CA48202),
    .INIT_02(256'hF050291C9420363D7584236E3AE0755B3DD0AE779438EEC40B233331B7D0CF63),
    .INIT_03(256'h011A7320E601C52EB17865E2BC034B331656C3E21C18F58F5EE85008070301E0),
    .INIT_04(256'h5805BB985E270027F62C89ACD2DE3E29C54D3C26D00CA5C1305E8FFFD15A9219),
    .INIT_05(256'h0000000000000000000000000000000000000000000000317DE3EA96DC3069A1),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'hC060C99307C7FEFCAC383A3478ADA6130C194E7C8BACDFB8581BB50000000000),
    .INIT_26(256'hAC53BFFD08418320206F8AC73E86C68B3E350B6153C8F12CC5CDB4F9A750D230),
    .INIT_27(256'h3F40E4998A437601CCD459A21A02C1A8E3ADC8DD88D44D6B9DF5EFD05D9A3BA0),
    .INIT_28(256'hCDA1384702EE329665A1820BD86B302B0F044F23CF51096F20C89C73D020DC60),
    .INIT_29(256'h98858C129958858ED244BA073CB7206219030A1CBC092330458E0FA4936B11E0),
    .INIT_2A(256'h90D846638C8A1EDACDD9C92616B20386AB3CD01348539010B15D241C91A320CA),
    .INIT_2B(256'h5DD072789A210A70DA03BB53944AC1F29555B8B013F8B10CE2620D57CCA6A00C),
    .INIT_2C(256'hDE984AA3749F60668B30607C9901A88724D86E1383A33CF26CF680305DC82469),
    .INIT_2D(256'h51C8C5A60F8B43BF5510097994982DEC2E651AB7DD67FF77C11066A404309337),
    .INIT_2E(256'hCDC6E382883190264B3D84960A935E0DB243231B24A042E49168EF864461AFA1),
    .INIT_2F(256'h20AFC3082CF98197844E7259A40784EFC19F6BBA2F8F0157D5766C8AD2C00A87),
    .INIT_30(256'h2B02B54C09B96C6DF997F28B036E9DE1E527764AE3C9CD54186223B66EF92894),
    .INIT_31(256'hA2066D8C702C9A885155B005C7CD3D9A1CF4A1686ECF58C12B8F0C80E47C922A),
    .INIT_32(256'hEA344627F48243B2A0EF53E3E9E94AE819B8A0B3E68400FA57AF515B440784C0),
    .INIT_33(256'h35A136DD268230BF22050BBACA9E123277C131E4E0D9B806D5074C5CC6084A15),
    .INIT_34(256'h6407D211C99058C58B9EB1B2E40158C0E692FC8B909742300B429460CBBC8D15),
    .INIT_35(256'h522DB9E32820A425C562C0837E083FE320418812EC90E83DAB94C927FACD91A1),
    .INIT_36(256'hBA506AB5321BCF7A9E62872535B2CE754633C760C3C917C4CC77A908543B0F1C),
    .INIT_37(256'h3EDDA92A5C554A9C632A6AE454F84B19462A9B50621A7171D033FAB5F2F37790),
    .INIT_38(256'h02933309AEB83131E96CA0B5D1124DBD8090A5A08B3A861C19E5EF12A19DCC65),
    .INIT_39(256'h0306AF24C72AABFAB99A4417A5280A10E74DD0885430F1585597D0DF050F0C93),
    .INIT_3A(256'h96E23774370E1038DD1966D41A436628C921B6427614EF92FB64152CAFC42990),
    .INIT_3B(256'hA1A0A0195BF186941CD86428C565E52D277092CCFC3050961C4313F874A22DE8),
    .INIT_3C(256'h484406D1411EF97AE3CB19532AA47082D068C85ADAC35DCD8770665A00501137),
    .INIT_3D(256'hA80682C1D183F5062A322B2740FC6B24618B4FB315D68359237200392CE03043),
    .INIT_3E(256'h6EF6F09639126863AC15D7EA2A146855E62B5000421A48A10D983450D96083C6),
    .INIT_3F(256'hA0A729E8C1420CC484098842DFCB3C6D9201C11B06050E81876D63A99F4C90C4),
    .INIT_40(256'h096E3859180C1B26E54DA19DE795337890A182396D21259A1E158F09C35187B1),
    .INIT_41(256'h904FABA1630E156EEC7A5B1626B6A032E6231002D8AB099A682613811FEA6B19),
    .INIT_42(256'hFB811065958B3D0B0003AAC2E0578C8E742A6CD2C304B7CA39276D07D030543A),
    .INIT_43(256'h72702F42849CD478D17547828E0470CB135B792AFF55890934254112541EEE0C),
    .INIT_44(256'hBDB4EA8B2250440A11D1E056C08C28597B3031F54630197F480E98AC446032D8),
    .INIT_45(256'h92B30211B8F544AE32813DEDE9170F4392FE442740A1B6F4B74B75A061B2B145),
    .INIT_46(256'h1BE479FF9DAB3AAEB19DE2622863A338E75A0C58890BC3B5AE69148EFB02E03E),
    .INIT_47(256'hA3529306D6C4E6BA905E1450894CD4C5AB0BC0B0E9E57477554E414D4C5EF882),
    .INIT_48(256'h509984135B5954171415A4156247CB9BD89C08051E098990BAB85390326019B1),
    .INIT_49(256'h8D8E0FE2066217A9019880A620C60A38C4B395676B9738C0B0BDCAFB70628C88),
    .INIT_4A(256'hA99F7843FE3A1090748F980016C40C3C48B0D21F6AD58FA4D58ACB319C1921CA),
    .INIT_4B(256'h11600259A3B37C27AD2E1C266DEAE02B1AE2E9629A010800D73C080484D8D8EC),
    .INIT_4C(256'h724B12266C307C1C6AACC983608DEB90CDD8E2EF8B31078D4E19AB29E8485CD5),
    .INIT_4D(256'h10CE3EF2E438FD979552FB98F782081593101886029172D34D0205547ABF4449),
    .INIT_4E(256'h8925062092102839125E00127117A5B0EE0E2824843BFFF3030158D118AC02D1),
    .INIT_4F(256'hF1980D62012A740CC033A26E429FC56D8D9AA7343880C43C052511109A29275D),
    .INIT_50(256'h03660857142FA274875FF0009F01B60946029D66019951B4698650018ED0CEA6),
    .INIT_51(256'hE6859C23948D4B433CB4828184A084F3842C48698400DED279CF3814361B506C),
    .INIT_52(256'hB404135D9B5F00C7F34021D255A0823E2CE82171DE34D8CA31BD0CA5CE364F6E),
    .INIT_53(256'h8641DB230071C4C85682C492C88C1213EA0523D8ED581E513D81C13FD508ED6C),
    .INIT_54(256'h6E9F6AA63431688F24A9080D2114732A1D7517DA02DA903BE48F39F2D747C9A3),
    .INIT_55(256'h35A568048B448BFF71F23EC2F870622C4EB956D1B86AAB62063B11E2540CBBCE),
    .INIT_56(256'hA8BC02F804E04417B0D84E7424BC14E26E145FC540302C9959F8AD4047700049),
    .INIT_57(256'h5B8C00611903920BC1E007E28F613053401F1EECD870C40940A292B856275345),
    .INIT_58(256'hE86F3D6329219F2E30A37B1381877AA07A2562CA692240786623B58B270ED31E),
    .INIT_59(256'h303A1040E190FC95B1207C8811C56CCE08731A85CB08B7C00002098ED2CD485C),
    .INIT_5A(256'hC49250192938F95B72A78CCDCC0D09265A40893B180CCE430A8A8D1655EE5F2C),
    .INIT_5B(256'h4FFD249DC5BBB4935B8E20EFF05079DC98B49E681A3953B3160A543176EF4608),
    .INIT_5C(256'h76C809D2983C959CEE6AEBC2F0ED26F850D0A6700F24F6C9A72ECCAED3E2C9D4),
    .INIT_5D(256'hAE0114D188005B0BF374D81E48BFE37C2BDC6AD00F64F91D1EE5436799362643),
    .INIT_5E(256'hBA41FCB55D58191C55DD056A28F92083A2F31301DB3B000101189F834121BDB9),
    .INIT_5F(256'h94007FA02DC84A27BEEACC0A46B8C8A0859CE09E642298934470B1970D89AF59),
    .INIT_60(256'h751C1DFC68227F720C0C2D7D4A506B810E72127BD4F057742544D8E7DB221193),
    .INIT_61(256'hCA7B1B1C8482975E1750EC1C55709CE2C60A398F3C5360E4AE50A2BF455A512B),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'hA3B364980486D924A7AE6CE2EA048D91C26813AADC0000000000000000000000),
    .INIT_6D(256'hF2FF1889225EB21E589277BF022A03E1822281566EEFB0587184559BDB852B6B),
    .INIT_6E(256'h35AA2254C3D66604AEADAE20A1A88C1F4133157C5F22AA7E6F0E5E0A732B6C41),
    .INIT_6F(256'h932E0247ABAF0F365CC49592243C3DED948AA42974FBC6C929130E26E31E8B69),
    .INIT_70(256'h581BA54CB1E86D0664073515331501AC980C4D411FDDF02E7D34C0F16237066D),
    .INIT_71(256'h25C626D92C1835E403AFE9831A5B260976A32DC17283377F1BCEE30E2781F6E8),
    .INIT_72(256'h508466E784E3319A5DE1668978CEB30BF976C56EC4E3264D7DA3D4A3A062A1D7),
    .INIT_73(256'hB549136A0E24F60148E1D983292C33E4747878311B0DD34A21682269CC88ABEF),
    .INIT_74(256'h0625CCBA22FB3C4BC091F40B6F5359A3F4B3ED22B618CE9B07D9BFCBE09EEB55),
    .INIT_75(256'h8E972B2AFBE3CF36C2C75E9811FC2B6C66FA5E967C937FB4CA30D3BFCC248B9B),
    .INIT_76(256'hD4386074031F489608CE570004D0D0E506EAC42C3872D160508B82D16223CA07),
    .INIT_77(256'h4721814FC8DC69546023B25E4A46BD90CD28AB9CC720815CE10F8CB313A32866),
    .INIT_78(256'h1B8EE04F40C8A22E7E5C05A00D928087C64EB38A6972247F92703C72AF91CE80),
    .INIT_79(256'hB0684C9E9DD105EFE3C66E51964537767F2D65449A58DDD305A739754D00AE79),
    .INIT_7A(256'h6652960C09D9CE00A00CE1B28EE53080E5780E5144C220B309B8A621182358B1),
    .INIT_7B(256'hEE07C600A5C5A58D303EF1C1BA4526AA20BF847EF91FA4727055E1446C503385),
    .INIT_7C(256'h673D7B1A0167352D2810125D3803448D9E9C69BF2414CAC49417DF84924A8290),
    .INIT_7D(256'h281632285303087B14C4FC065AA51628F9EBDDB839342CB03E8F0C9D8EC91274),
    .INIT_7E(256'h8A8F9C1E04DCD391F4EA9E1609BB551285A840C191DFAE28106C610C258A0F8A),
    .INIT_7F(256'h945709A4AE70ECE45583DB15943410FA38A2C845A3C5F73CDA8AF389807F1436),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module ROM_sparse_weight_blk_mem_gen_prim_wrapper_init__parameterized9
   (p_39_out,
    clka,
    ena_array,
    addra);
  output [8:0]p_39_out;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire [8:0]p_39_out;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h1F1F2E2A1F20262A1C202A2C2226202020271F1B1E16171C1D00000000000000),
    .INIT_01(256'h152C21161F1F1C181F1D121B2027201E2E24111A272E28171C151F17111E1A17),
    .INIT_02(256'h2C2C2E151F2A191413121F202017202C251713151F131A2216232127142A2020),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h2020202030242025200000000000000000000000000000000000000000000000),
    .INIT_05(256'h202F0D16251A1F1D2E14110E0F202A332E202526110E1C1D0F17202020202020),
    .INIT_06(256'h232D2629332920242D202520261420202020222F2633312F2E32272A10222020),
    .INIT_07(256'h130F1A1F2E2320203213132726281019141A1F1F3114122E2021250F22200E2B),
    .INIT_08(256'h1131310F2E1D0E2C2D0030322F2B20202D20202320340D291D32292E1B1F1A16),
    .INIT_09(256'h2A2B120F12130F0C0F132018202C1520330C202E2A3111162D2B100F1122220C),
    .INIT_0A(256'h0D130E1B151B18202D1A2027281011141B282E28130E3019302F312C21281133),
    .INIT_0B(256'h321030112B11291B2C1F2E0F1300303030120C2030182F2B2833333317132023),
    .INIT_0C(256'h2A0E0C33141930231A132D181D121F302627160D3122140E332D33202A202D31),
    .INIT_0D(256'h1F1326201513160D0E322028172B20172818282B1133180D100D2D31132A2933),
    .INIT_0E(256'h260E330C161433332E28270B1415112F2E303220202D32252C30331B26222A1F),
    .INIT_0F(256'h0F3227332C1F20200D13101F0E242B2032331C311114250F310C0F00312F2A32),
    .INIT_10(256'h0F1132271B0D231310282032242F2F300C33182B2E0F1327200C0C200D332B33),
    .INIT_11(256'h2E202C181F0F0C2E20202E2F2C20241A2A20282E2A331B1F18142D0B16333424),
    .INIT_12(256'h0D0F34132D1200341A191F1F161A0D231827323223100E331414171E16140E28),
    .INIT_13(256'h0F20141B301F0C0E1133112E0C0C31340E2212332910200C0C33332F2D30320C),
    .INIT_14(256'h2011292D2E302A270F1F14132E2D2028191A1C13292E2F272030342B2A202F28),
    .INIT_15(256'h270E152E332A110D0D3030171212130D34132C0F1530103100100F1C161F0E13),
    .INIT_16(256'h0C0E191031232020102A2526322D182F20160D2612172E1132301F300D291913),
    .INIT_17(256'h0000000000000000000C1C1611201820302E2A0D311F1E110E0E1A23292C3234),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h121B181F1F1F1310122830342733202D20120000000000000000000000000000),
    .INIT_1A(256'h24201B10143011181A3030330B1D1F0D1B1F1F27202D22280E300F180B21120C),
    .INIT_1B(256'h110E2E15191F0B2E161511330D1B2C202C0E2C2F20281F1F1C1A0E3124202D0F),
    .INIT_1C(256'h1F30171F173100120C2C132F18200F290E0C11120D13110F110D1F1F19221815),
    .INIT_1D(256'h2D33133320340E11131912111D202B2F2B3029290C0C0F2D2C2C333320260E31),
    .INIT_1E(256'h2D172320320B302F2A20202024200D150D282C2C340F34161C0D1E33171F1120),
    .INIT_1F(256'h1C201D0E002D2A27202920243220300E1312111414170D152320332332341226),
    .INIT_20(256'h2A2F2728202033172B322D25223211252A16201F0E2C0C1A0D11333033342013),
    .INIT_21(256'h20203331202034282031320B3329152B160C0F20303225312F322E110F24290C),
    .INIT_22(256'h2E262332202000100D302F201F1F2731320F1126311E11160D14303413322F30),
    .INIT_23(256'h25272F2C20312E1F1D1F1A331831242213202F272F162B2020200D0C0D1F0E30),
    .INIT_24(256'h0D2D300E0E332E2F121611262A1315111232150F320E2E2A20302D2A30342F31),
    .INIT_25(256'h222F2C242E300F100E140C000C0D0C2F0B0D2D20192F192B2A12322E25312F0C),
    .INIT_26(256'h2331312F16153310330D0E302B2E202B25292333200D2E171C120E121726332B),
    .INIT_27(256'h1C0F15191F00312F330D3420102925330D12282C322E2E0C1710140F242D202F),
    .INIT_28(256'h2A310F23191F0E30283132322E20262013100D2D12170D322E202532202F0C0C),
    .INIT_29(256'h0F282F3118282A10181F0F0F322F302514130B0F0F2E25202C2014100C2E3315),
    .INIT_2A(256'h000000000000000000000000000000000000000000000000000017292E212912),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],p_39_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],p_39_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module ROM_sparse_weight_blk_mem_gen_top
   (douta,
    clka,
    addra,
    ena);
  output [15:0]douta;
  input clka;
  input [15:0]addra;
  input ena;

  wire [15:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;

  ROM_sparse_weight_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .douta(douta),
        .ena(ena));
endmodule

(* C_ADDRA_WIDTH = "16" *) (* C_ADDRB_WIDTH = "16" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "2" *) 
(* C_COUNT_36K_BRAM = "18" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     15.89039 mW" *) 
(* C_FAMILY = "zynq" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "ROM_sparse_weight.mem" *) 
(* C_INIT_FILE_NAME = "ROM_sparse_weight.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "3" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "40000" *) (* C_READ_DEPTH_B = "40000" *) (* C_READ_LATENCY_A = "1" *) 
(* C_READ_LATENCY_B = "1" *) (* C_READ_WIDTH_A = "16" *) (* C_READ_WIDTH_B = "16" *) 
(* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) (* C_RST_PRIORITY_A = "CE" *) 
(* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) (* C_USE_BRAM_BLOCK = "0" *) 
(* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) (* C_USE_DEFAULT_DATA = "1" *) 
(* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) (* C_USE_URAM = "0" *) 
(* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) (* C_WRITE_DEPTH_A = "40000" *) 
(* C_WRITE_DEPTH_B = "40000" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
(* C_WRITE_WIDTH_A = "16" *) (* C_WRITE_WIDTH_B = "16" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* ORIG_REF_NAME = "blk_mem_gen_v8_4_3" *) (* downgradeipidentifiedwarnings = "yes" *) 
module ROM_sparse_weight_blk_mem_gen_v8_4_3
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [15:0]addra;
  input [15:0]dina;
  output [15:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [15:0]addrb;
  input [15:0]dinb;
  output [15:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [15:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [15:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [15:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [15:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [15:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;

  assign dbiterr = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign rdaddrecc[15] = \<const0> ;
  assign rdaddrecc[14] = \<const0> ;
  assign rdaddrecc[13] = \<const0> ;
  assign rdaddrecc[12] = \<const0> ;
  assign rdaddrecc[11] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[15] = \<const0> ;
  assign s_axi_rdaddrecc[14] = \<const0> ;
  assign s_axi_rdaddrecc[13] = \<const0> ;
  assign s_axi_rdaddrecc[12] = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  ROM_sparse_weight_blk_mem_gen_v8_4_3_synth inst_blk_mem_gen
       (.addra(addra),
        .clka(clka),
        .douta(douta),
        .ena(ena));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_3_synth" *) 
module ROM_sparse_weight_blk_mem_gen_v8_4_3_synth
   (douta,
    clka,
    addra,
    ena);
  output [15:0]douta;
  input clka;
  input [15:0]addra;
  input ena;

  wire [15:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;

  ROM_sparse_weight_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .clka(clka),
        .douta(douta),
        .ena(ena));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
