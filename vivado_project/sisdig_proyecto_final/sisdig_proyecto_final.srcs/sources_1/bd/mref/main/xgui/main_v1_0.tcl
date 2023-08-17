# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ANGLE_STEP_INITIAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANGLE_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BYTES_TO_RECEIVE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COORDS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CORDIC_OFFSET" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CORDIC_STAGES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CORDIC_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CYCLES_TO_WAIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RAM_ADDRESS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RAM_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VRAM_ADDR_BITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VRAM_DATA_BITS_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.ANGLE_STEP_INITIAL { PARAM_VALUE.ANGLE_STEP_INITIAL } {
	# Procedure called to update ANGLE_STEP_INITIAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANGLE_STEP_INITIAL { PARAM_VALUE.ANGLE_STEP_INITIAL } {
	# Procedure called to validate ANGLE_STEP_INITIAL
	return true
}

proc update_PARAM_VALUE.ANGLE_WIDTH { PARAM_VALUE.ANGLE_WIDTH } {
	# Procedure called to update ANGLE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANGLE_WIDTH { PARAM_VALUE.ANGLE_WIDTH } {
	# Procedure called to validate ANGLE_WIDTH
	return true
}

proc update_PARAM_VALUE.BYTES_TO_RECEIVE { PARAM_VALUE.BYTES_TO_RECEIVE } {
	# Procedure called to update BYTES_TO_RECEIVE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BYTES_TO_RECEIVE { PARAM_VALUE.BYTES_TO_RECEIVE } {
	# Procedure called to validate BYTES_TO_RECEIVE
	return true
}

proc update_PARAM_VALUE.COORDS_WIDTH { PARAM_VALUE.COORDS_WIDTH } {
	# Procedure called to update COORDS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COORDS_WIDTH { PARAM_VALUE.COORDS_WIDTH } {
	# Procedure called to validate COORDS_WIDTH
	return true
}

proc update_PARAM_VALUE.CORDIC_OFFSET { PARAM_VALUE.CORDIC_OFFSET } {
	# Procedure called to update CORDIC_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CORDIC_OFFSET { PARAM_VALUE.CORDIC_OFFSET } {
	# Procedure called to validate CORDIC_OFFSET
	return true
}

proc update_PARAM_VALUE.CORDIC_STAGES { PARAM_VALUE.CORDIC_STAGES } {
	# Procedure called to update CORDIC_STAGES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CORDIC_STAGES { PARAM_VALUE.CORDIC_STAGES } {
	# Procedure called to validate CORDIC_STAGES
	return true
}

proc update_PARAM_VALUE.CORDIC_WIDTH { PARAM_VALUE.CORDIC_WIDTH } {
	# Procedure called to update CORDIC_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CORDIC_WIDTH { PARAM_VALUE.CORDIC_WIDTH } {
	# Procedure called to validate CORDIC_WIDTH
	return true
}

proc update_PARAM_VALUE.CYCLES_TO_WAIT { PARAM_VALUE.CYCLES_TO_WAIT } {
	# Procedure called to update CYCLES_TO_WAIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CYCLES_TO_WAIT { PARAM_VALUE.CYCLES_TO_WAIT } {
	# Procedure called to validate CYCLES_TO_WAIT
	return true
}

proc update_PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH { PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH } {
	# Procedure called to update CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH { PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH } {
	# Procedure called to validate CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH
	return true
}

proc update_PARAM_VALUE.RAM_ADDRESS_WIDTH { PARAM_VALUE.RAM_ADDRESS_WIDTH } {
	# Procedure called to update RAM_ADDRESS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_ADDRESS_WIDTH { PARAM_VALUE.RAM_ADDRESS_WIDTH } {
	# Procedure called to validate RAM_ADDRESS_WIDTH
	return true
}

proc update_PARAM_VALUE.RAM_DATA_WIDTH { PARAM_VALUE.RAM_DATA_WIDTH } {
	# Procedure called to update RAM_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_DATA_WIDTH { PARAM_VALUE.RAM_DATA_WIDTH } {
	# Procedure called to validate RAM_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.VRAM_ADDR_BITS { PARAM_VALUE.VRAM_ADDR_BITS } {
	# Procedure called to update VRAM_ADDR_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VRAM_ADDR_BITS { PARAM_VALUE.VRAM_ADDR_BITS } {
	# Procedure called to validate VRAM_ADDR_BITS
	return true
}

proc update_PARAM_VALUE.VRAM_DATA_BITS_WIDTH { PARAM_VALUE.VRAM_DATA_BITS_WIDTH } {
	# Procedure called to update VRAM_DATA_BITS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VRAM_DATA_BITS_WIDTH { PARAM_VALUE.VRAM_DATA_BITS_WIDTH } {
	# Procedure called to validate VRAM_DATA_BITS_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.RAM_DATA_WIDTH { MODELPARAM_VALUE.RAM_DATA_WIDTH PARAM_VALUE.RAM_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_DATA_WIDTH}] ${MODELPARAM_VALUE.RAM_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.RAM_ADDRESS_WIDTH { MODELPARAM_VALUE.RAM_ADDRESS_WIDTH PARAM_VALUE.RAM_ADDRESS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_ADDRESS_WIDTH}] ${MODELPARAM_VALUE.RAM_ADDRESS_WIDTH}
}

proc update_MODELPARAM_VALUE.BYTES_TO_RECEIVE { MODELPARAM_VALUE.BYTES_TO_RECEIVE PARAM_VALUE.BYTES_TO_RECEIVE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BYTES_TO_RECEIVE}] ${MODELPARAM_VALUE.BYTES_TO_RECEIVE}
}

proc update_MODELPARAM_VALUE.CYCLES_TO_WAIT { MODELPARAM_VALUE.CYCLES_TO_WAIT PARAM_VALUE.CYCLES_TO_WAIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CYCLES_TO_WAIT}] ${MODELPARAM_VALUE.CYCLES_TO_WAIT}
}

proc update_MODELPARAM_VALUE.COORDS_WIDTH { MODELPARAM_VALUE.COORDS_WIDTH PARAM_VALUE.COORDS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COORDS_WIDTH}] ${MODELPARAM_VALUE.COORDS_WIDTH}
}

proc update_MODELPARAM_VALUE.ANGLE_WIDTH { MODELPARAM_VALUE.ANGLE_WIDTH PARAM_VALUE.ANGLE_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANGLE_WIDTH}] ${MODELPARAM_VALUE.ANGLE_WIDTH}
}

proc update_MODELPARAM_VALUE.CORDIC_STAGES { MODELPARAM_VALUE.CORDIC_STAGES PARAM_VALUE.CORDIC_STAGES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CORDIC_STAGES}] ${MODELPARAM_VALUE.CORDIC_STAGES}
}

proc update_MODELPARAM_VALUE.CORDIC_WIDTH { MODELPARAM_VALUE.CORDIC_WIDTH PARAM_VALUE.CORDIC_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CORDIC_WIDTH}] ${MODELPARAM_VALUE.CORDIC_WIDTH}
}

proc update_MODELPARAM_VALUE.CORDIC_OFFSET { MODELPARAM_VALUE.CORDIC_OFFSET PARAM_VALUE.CORDIC_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CORDIC_OFFSET}] ${MODELPARAM_VALUE.CORDIC_OFFSET}
}

proc update_MODELPARAM_VALUE.ANGLE_STEP_INITIAL { MODELPARAM_VALUE.ANGLE_STEP_INITIAL PARAM_VALUE.ANGLE_STEP_INITIAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANGLE_STEP_INITIAL}] ${MODELPARAM_VALUE.ANGLE_STEP_INITIAL}
}

proc update_MODELPARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH { MODELPARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH}] ${MODELPARAM_VALUE.CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH}
}

proc update_MODELPARAM_VALUE.VRAM_ADDR_BITS { MODELPARAM_VALUE.VRAM_ADDR_BITS PARAM_VALUE.VRAM_ADDR_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VRAM_ADDR_BITS}] ${MODELPARAM_VALUE.VRAM_ADDR_BITS}
}

proc update_MODELPARAM_VALUE.VRAM_DATA_BITS_WIDTH { MODELPARAM_VALUE.VRAM_DATA_BITS_WIDTH PARAM_VALUE.VRAM_DATA_BITS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VRAM_DATA_BITS_WIDTH}] ${MODELPARAM_VALUE.VRAM_DATA_BITS_WIDTH}
}

