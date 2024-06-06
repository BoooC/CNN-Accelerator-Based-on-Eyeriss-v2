onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IP_Psum_Data_SRAM_BRAM_opt

do {wave.do}

view wave
view structure
view signals

do {IP_Psum_Data_SRAM_BRAM.udo}

run -all

quit -force
