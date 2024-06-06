onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xilinx_vip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_3 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.ROM_ifmap xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ROM_ifmap.udo}

run -all

quit -force
