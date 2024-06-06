

set_property -dict { PACKAGE_PIN H16   		IOSTANDARD LVCMOS33 } [get_ports { clock }]; 
create_clock -name clock -period 8.00 -waveform {0 4} [get_ports { clock }];

set_property -dict { PACKAGE_PIN D19   		IOSTANDARD LVCMOS33 } [get_ports { reset }];

set_property -dict { PACKAGE_PIN D20   		IOSTANDARD LVCMOS33 } [get_ports { btn1 }];
set_property -dict { PACKAGE_PIN L20   		IOSTANDARD LVCMOS33 } [get_ports { btn2 }];
set_property -dict { PACKAGE_PIN L19   		IOSTANDARD LVCMOS33 } [get_ports { btn3 }];

set_property -dict { PACKAGE_PIN R14    	IOSTANDARD LVCMOS33 } [get_ports { result[0] }];
set_property -dict { PACKAGE_PIN P14    	IOSTANDARD LVCMOS33 } [get_ports { result[1] }];
set_property -dict { PACKAGE_PIN N16    	IOSTANDARD LVCMOS33 } [get_ports { result[2] }];
set_property -dict { PACKAGE_PIN M14    	IOSTANDARD LVCMOS33 } [get_ports { result[3] }];


set_property -dict { PACKAGE_PIN W6    	IOSTANDARD LVCMOS33 } [get_ports { rx_pin_in }];

