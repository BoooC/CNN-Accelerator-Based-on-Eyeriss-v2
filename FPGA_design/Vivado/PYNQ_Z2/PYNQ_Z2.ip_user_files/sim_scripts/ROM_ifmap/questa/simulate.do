onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ROM_ifmap_opt

do {wave.do}

view wave
view structure
view signals

do {ROM_ifmap.udo}

run -all

quit -force
