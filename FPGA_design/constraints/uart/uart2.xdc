

set_property -dict { PACKAGE_PIN H16   		IOSTANDARD LVCMOS33 } [get_ports { clock }]; 
create_clock -name clock -period 20.00 -waveform {0 10} [get_ports { clock }];



set_property -dict { PACKAGE_PIN R14    	IOSTANDARD LVCMOS33 } [get_ports { led_tri_io[0] }];
set_property -dict { PACKAGE_PIN P14    	IOSTANDARD LVCMOS33 } [get_ports { led_tri_io[1] }];
set_property -dict { PACKAGE_PIN N16    	IOSTANDARD LVCMOS33 } [get_ports { led_tri_io[2] }];
set_property -dict { PACKAGE_PIN M14    	IOSTANDARD LVCMOS33 } [get_ports { led_tri_io[3] }];


set_property -dict { PACKAGE_PIN W6    	IOSTANDARD LVCMOS33 } [get_ports { uart_rtl_rxd }];

