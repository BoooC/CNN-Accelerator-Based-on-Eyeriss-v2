onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IP_Psum_Rearrange_BRAM_opt

do {wave.do}

view wave
view structure
view signals

do {IP_Psum_Rearrange_BRAM.udo}

run -all

quit -force
