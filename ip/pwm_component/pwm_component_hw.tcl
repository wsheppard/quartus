# TCL File Generated by Component Editor 12.1
# Wed Dec 05 11:45:32 GMT 2012
# DO NOT MODIFY


# 
# pwm_component "pwm_component" v1.1
# null 2012.12.05.11:45:32
# SOPC
# 

# 
# request TCL package from ACDS 12.1
# 
package require -exact qsys 12.1


# 
# module pwm_component
# 
set_module_property DESCRIPTION SOPC
set_module_property NAME pwm_component
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property DISPLAY_NAME pwm_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL pwm_component
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file pwm.vhd VHDL PATH pwm.vhd
add_fileset_file pwm_component.vhd VHDL PATH pwm_component.vhd

add_fileset sim_vhdl SIM_VHDL "" "VHDL Simulation"
set_fileset_property sim_vhdl TOP_LEVEL pwm_component
set_fileset_property sim_vhdl ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file pwm.vhd VHDL PATH pwm.vhd
add_fileset_file pwm_component.vhd VHDL PATH pwm_component.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point s1
# 
add_interface s1 avalon end
set_interface_property s1 addressUnits WORDS
set_interface_property s1 associatedClock s1_clk
set_interface_property s1 associatedReset reset_sink
set_interface_property s1 bitsPerSymbol 8
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 burstcountUnits WORDS
set_interface_property s1 explicitAddressSpan 0
set_interface_property s1 holdTime 0
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitTime 1
set_interface_property s1 setupTime 0
set_interface_property s1 timingUnits Cycles
set_interface_property s1 writeWaitTime 0
set_interface_property s1 ENABLED true

add_interface_port s1 s1_write write Input 1
add_interface_port s1 s1_address address Input 2
add_interface_port s1 s1_writedata writedata Input 32
set_interface_assignment s1 embeddedsw.configuration.isFlash 0
set_interface_assignment s1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true

add_interface_port conduit_end pwm_out_1 export Output 1
add_interface_port conduit_end pwm_out_2 export Output 1
add_interface_port conduit_end pwm_out_3 export Output 1
add_interface_port conduit_end pwm_out_4 export Output 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock s1_clk
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true

add_interface_port reset_sink s1_reset reset_n Input 1


# 
# connection point s1_clk
# 
add_interface s1_clk clock end
set_interface_property s1_clk clockRate 0
set_interface_property s1_clk ENABLED true

add_interface_port s1_clk s1_clk clk Input 1
