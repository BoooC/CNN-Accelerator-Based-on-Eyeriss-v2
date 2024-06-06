onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib processing_system7_0_opt

do {wave.do}

view wave
view structure
view signals

do {processing_system7_0.udo}

run -all

quit -force
