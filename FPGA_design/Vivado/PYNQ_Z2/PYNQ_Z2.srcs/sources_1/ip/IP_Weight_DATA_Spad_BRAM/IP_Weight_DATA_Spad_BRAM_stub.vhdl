-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Jan  4 19:14:34 2024
-- Host        : booo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top IP_Weight_DATA_Spad_BRAM -prefix
--               IP_Weight_DATA_Spad_BRAM_ IP_Weight_DATA_Spad_BRAM_stub.vhdl
-- Design      : IP_Weight_DATA_Spad_BRAM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IP_Weight_DATA_Spad_BRAM is
  Port ( 
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 11 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rsta_busy : out STD_LOGIC
  );

end IP_Weight_DATA_Spad_BRAM;

architecture stub of IP_Weight_DATA_Spad_BRAM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,rsta,wea[0:0],addra[6:0],dina[11:0],douta[11:0],rsta_busy";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_3,Vivado 2019.1";
begin
end;
