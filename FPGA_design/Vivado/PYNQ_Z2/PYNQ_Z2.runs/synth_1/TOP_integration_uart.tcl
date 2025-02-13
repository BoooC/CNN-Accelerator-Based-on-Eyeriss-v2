# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 5
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.cache/wt [current_project]
set_property parent.project_path C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
set_property ip_output_repo c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/high_sparsity/ROM_sparse_COE.coe
add_files C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/ifmap_5.coe
add_files C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/ifmap_4.coe
add_files C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/test/tb/TOP_test/MEM/ifmap_0.coe
read_verilog -library xil_defaultlib {
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/CSCSwitcher.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/CSC_switch_FIFO.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ClusterGroup.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ClusterGroupController.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ClusterGroup_array.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/GLBCluster.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/InActRouter.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/InActSRAMBank.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/InAct_addr_SRAM.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/InAct_data_SRAM.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/Max_pooling.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PECluster.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PEClusterInActDataConnections.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PEClusterInActv.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PE_data_FIFO.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PE_psum_FIFO.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PSumRouter.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PSumSPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/PSumSRAMBank.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ProcessingElement.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ProcessingElementControl.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ProcessingElementPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/Psum_Requantizer.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/ReLU.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/RouterCluster.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/TOP.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/TOP_controller.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/TOP_interface.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/WeightAdrSPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/WeightRouter.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/clock_gen.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/im2col_converter.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/inActAdrSPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/inActDataSPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/interrupt_gen.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/psum_SRAM_out_acc.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/psum_rearrange.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/display/seg7_encoder.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/softmax.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/UART/start_en_detect.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/UART/uart_module.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/UART/uart_rx_band_gen.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/UART/uart_rx_ctl.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/UART/uart_rx_module.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/weightDataSPad.v
  C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/TOP_integration_uart.v
}
read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_ifmap_BRAM/IP_ifmap_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_ifmap_BRAM/IP_ifmap_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_Rearrange_BRAM/IP_Psum_Rearrange_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_Rearrange_BRAM/IP_Psum_Rearrange_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_Data_SRAM_BRAM/IP_Psum_Data_SRAM_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_Data_SRAM_BRAM/IP_Psum_Data_SRAM_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_Data_SRAM_BRAM/IP_Iact_Data_SRAM_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_Data_SRAM_BRAM/IP_Iact_Data_SRAM_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_Addr_SRAM_BRAM/IP_Iact_Addr_SRAM_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_Addr_SRAM_BRAM/IP_Iact_Addr_SRAM_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Weight_DATA_Spad_BRAM/IP_Weight_DATA_Spad_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Weight_DATA_Spad_BRAM/IP_Weight_DATA_Spad_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_DATA_Spad_BRAM/IP_Iact_DATA_Spad_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Iact_DATA_Spad_BRAM/IP_Iact_DATA_Spad_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_DATA_Spad_BRAM/IP_Psum_DATA_Spad_BRAM.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/IP_Psum_DATA_Spad_BRAM/IP_Psum_DATA_Spad_BRAM_ooc.xdc]

read_ip -quiet C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/ROM_sparse_weight/ROM_sparse_weight.xci
set_property used_in_implementation false [get_files -all c:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/sim/PYNQ_Z2/PYNQ_Z2.srcs/sources_1/ip/ROM_sparse_weight/ROM_sparse_weight_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/constraints/constraints.xdc
set_property used_in_implementation false [get_files C:/Users/p8101/Desktop/school/Univ/Special_project/LeNet_5_Eyeriss_v2/src/constraints/constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top TOP_integration_uart -part xc7z020clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef TOP_integration_uart.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file TOP_integration_uart_utilization_synth.rpt -pb TOP_integration_uart_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
