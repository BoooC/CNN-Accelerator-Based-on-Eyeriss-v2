
## Clock signal 125 MHz

set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { clock }]; 
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clock }];

##LEDs

set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { result[0] }];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { result[1] }];
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { result[2] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { result[3] }];

##Buttons

#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { reset }]; 

