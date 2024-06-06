onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+IP_Iact_Data_SRAM_BRAM -L xilinx_vip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_3 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.IP_Iact_Data_SRAM_BRAM xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {IP_Iact_Data_SRAM_BRAM.udo}

run -all

endsim

quit -force
