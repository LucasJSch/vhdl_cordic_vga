onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sram_internal_opt

do {wave.do}

view wave
view structure
view signals

do {sram_internal.udo}

run -all

quit -force
