onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xilinx_vip -L xil_defaultlib -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.processing_system7_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {processing_system7_0.udo}

run -all

quit -force
