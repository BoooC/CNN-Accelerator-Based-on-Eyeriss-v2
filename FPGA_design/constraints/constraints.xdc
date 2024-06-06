

set_property -dict { PACKAGE_PIN H16   		IOSTANDARD LVCMOS33 } [get_ports { clock }]; 
create_clock -name clock -period 8.00 -waveform {0 4} [get_ports { clock }];

set_property -dict { PACKAGE_PIN D19   		IOSTANDARD LVCMOS33 } [get_ports { reset }];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_IBUF]


set_property -dict { PACKAGE_PIN W6    		IOSTANDARD LVCMOS33 } [get_ports { rx_pin_in }];


set_property -dict { PACKAGE_PIN R14    	IOSTANDARD LVCMOS33 } [get_ports { result[0] }];
set_property -dict { PACKAGE_PIN P14    	IOSTANDARD LVCMOS33 } [get_ports { result[1] }];
set_property -dict { PACKAGE_PIN N16    	IOSTANDARD LVCMOS33 } [get_ports { result[2] }];
set_property -dict { PACKAGE_PIN M14    	IOSTANDARD LVCMOS33 } [get_ports { result[3] }];


set_property -dict { PACKAGE_PIN T14    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[0] }];
set_property -dict { PACKAGE_PIN U12    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[1] }];
set_property -dict { PACKAGE_PIN U13    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[2] }];
set_property -dict { PACKAGE_PIN V13    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[3] }];
set_property -dict { PACKAGE_PIN V15    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[4] }];
set_property -dict { PACKAGE_PIN T15    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[5] }];
set_property -dict { PACKAGE_PIN R16    	IOSTANDARD LVCMOS33 } [get_ports { seg_7[6] }];



