onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IP_Iact_Addr_SRAM_BRAM_opt

do {wave.do}

view wave
view structure
view signals

do {IP_Iact_Addr_SRAM_BRAM.udo}

run -all

quit -force
