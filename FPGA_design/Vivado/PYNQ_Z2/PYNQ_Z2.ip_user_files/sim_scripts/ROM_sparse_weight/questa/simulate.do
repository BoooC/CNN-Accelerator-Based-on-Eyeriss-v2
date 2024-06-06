onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ROM_sparse_weight_opt

do {wave.do}

view wave
view structure
view signals

do {ROM_sparse_weight.udo}

run -all

quit -force
