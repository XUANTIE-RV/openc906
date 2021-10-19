/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
#############################################################################################
# For Upper Level Flatten STA: set parent_path, e.g. "soc_top/aaa_top/bbb_top/"
#                              set cpu clock name of current chip, e.g. PLL_DIV_CLK_4
# Keep Default Settings for Block-Level Implementation
#############################################################################################

if {![info exist parent_path]}  { set parent_path  "" } ;# Default ""
if {![info exist CPU_CLK_NAME]} { set CPU_CLK_NAME CPU_CLK } ;# Default CPU_CLK
if {![info exist APB_CLK_NAME]} { set APB_CLK_NAME SYS_APB_CLK } ;# Default SYS_APB_CLK

################################################################################
# Initial variables for synthesis; modify this part based on design
################################################################################

set IF_READ_BUIDIN_VARIABLES 0 ;# For standalone usage, set to "1" ; For synthesis, set to "0"
set SYS_APB_SYNC      0 ; # For sync apb set to "1", for async apb set to "0"
set SYS2CPU_CLK_RATIO 2 ;# Set ratio(multicycle) for sys axi clk compared to cpuclk, default "2"

set CPU_PERIOD   [expr (1000.00/1000)] ;# CPU is constrained at 1.0GHz

if {$IF_READ_BUIDIN_VARIABLES} {
   set SETUP_UNCERTAINTY 0.2
   set HOLD_UNCERTAINTY  0.08
   set MAX_FANOUT        32
   set MAX_TRANSITION    0.5

   set LOAD_PIN      "AN2D2BWP12T30P140/A1"
   set DRIVING_CELL  "BUFFD2BWP12T30P140"

}

#################################################################################
# Proc Used in this File
#################################################################################
proc list_add_prefix {input_list prefix} {
   set output_list ""
   foreach element $input_list {
      lappend output_list ${prefix}${element}
   }
   return "$output_list"
}

proc get_args_port_pin {input_list} {
   if {[string match */* $input_list]} {
      return "-through \[get_pins \{$input_list\}\]"
   } elseif {[string match *in* [get_attribute [get_ports [lindex $input_list 0]] direction]]} {
      return "-from \[get_ports \{$input_list\}\]"
   } elseif {[string match *out* [get_attribute [get_ports [lindex $input_list 0]] direction]]} {
      return "-to \[get_ports \{$input_list\}\]"
   } else {
      echo "! port_pin_list check failed for $input_list, mixing inputs, outputs, or pins is not allowed"
   }
}

if {$synopsys_program_name=="pt_shell"} {
   proc get_flat_pins {arg} {
      get_pins -hier -filter "is_hierarchical==false && full_name=~$arg"
   }
   proc get_flat_cells {arg} {
      get_cells -hier -filter "is_hierarchical==false && full_name=~$arg"
   }
}

#################################################################################
# Basic Constraints
#################################################################################
if {$parent_path==""} {
   set SYS_AXI_PERIOD           [expr $CPU_PERIOD * $SYS2CPU_CLK_RATIO * 1.0]
   set PLIC_PERIOD              [expr $CPU_PERIOD * 2.0]
   set SYS_APB_PERIOD           [expr $CPU_PERIOD * 2.0]

   set CLK_INPUTS               [get_ports {*clk *clock *tck}]
   set DATA_INPUTS              [remove_from_collection [all_inputs] $CLK_INPUTS]

   set_max_fanout $MAX_FANOUT [current_design]
   set_max_transition $MAX_TRANSITION [current_design]
   set_input_transition 0.1 $CLK_INPUTS
   set_load [expr [load_of [get_lib_pins */$LOAD_PIN]]*5.0] [all_outputs]
   set_driving_cell -lib_cell $DRIVING_CELL $DATA_INPUTS

   create_clock [get_ports pll_core_cpuclk]  -name $CPU_CLK_NAME -period $CPU_PERIOD
   create_clock [get_ports sys_apb_clk]      -name $APB_CLK_NAME -period $SYS_APB_PERIOD

   create_clock -name V_CPU_CLK     -period $CPU_PERIOD
   create_clock -name V_SYS_AXI_CLK -period $SYS_AXI_PERIOD
   create_clock -name V_SYS_APB_CLK -period $SYS_APB_PERIOD

}

################################################################################
# Generated Clock: PLIC
################################################################################
create_generated_clock -name PLIC_CLK -source [get_attribute [get_clocks $CPU_CLK_NAME] sources] -edges {1 2 5} \
   [filter [get_flat_pins ${parent_path}x_aq_mp_clk_top?x_apb_gated_clk*x_gated_clk_cell*] direction==out]
set_multicycle_path -from $CPU_CLK_NAME -to PLIC_CLK -setup 2 -start
set_multicycle_path -from $CPU_CLK_NAME -to PLIC_CLK -hold  1 -start
set_multicycle_path -to $CPU_CLK_NAME -from PLIC_CLK -setup 2 -end
set_multicycle_path -to $CPU_CLK_NAME -from PLIC_CLK -hold  1 -end

################################################################################
# Generated Clock: SYSTEM AXI
################################################################################
if {$SYS2CPU_CLK_RATIO>1} {
   set_multicycle_path -from $CPU_CLK_NAME -to V_SYS_AXI_CLK -setup $SYS2CPU_CLK_RATIO -start
   set_multicycle_path -from $CPU_CLK_NAME -to V_SYS_AXI_CLK -hold  [expr $SYS2CPU_CLK_RATIO - 1] -start
   set_multicycle_path -to $CPU_CLK_NAME -from V_SYS_AXI_CLK -setup $SYS2CPU_CLK_RATIO -end
   set_multicycle_path -to $CPU_CLK_NAME -from V_SYS_AXI_CLK -hold  [expr $SYS2CPU_CLK_RATIO - 1] -end
}

################################################################################
# SYS APB CLK constraint,which is asyn with each other
################################################################################
if {$SYS_APB_SYNC} {
### clock from port defined as variable, $CPU_CLK_NAME, $APB_CLK_NAME
  set_multicycle_path -from $CPU_CLK_NAME -to [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] -setup 2 -start
  set_multicycle_path -from $CPU_CLK_NAME -to [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] -hold  1 -start
  set_multicycle_path -to $CPU_CLK_NAME -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] -setup 2 -end
  set_multicycle_path -to $CPU_CLK_NAME -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] -hold  1 -end


} else {

  set_max_delay [expr $CPU_PERIOD*2] -ignore_clock_latency -from [get_clocks [list $CPU_CLK_NAME V_CPU_CLK]] -to [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]]
  set_max_delay [expr $CPU_PERIOD*2] -ignore_clock_latency -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] -to [get_clocks [list $CPU_CLK_NAME V_CPU_CLK]]

  set_false_path -hold -from $CPU_CLK_NAME -to [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]]
  set_false_path -hold -to $CPU_CLK_NAME -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]]
}
# User-Edit Ends Here


################################################################################
# Ports Constrains
################################################################################
### PLIC Ports
set PLIC_INPUTS {pad_plic_int_vld*}

# If PLIC inputs can not meet the following constraint, max_delay can be relaxed
eval set_max_delay [expr $CPU_PERIOD *5] [get_args_port_pin [list_add_prefix $PLIC_INPUTS $parent_path]] -ignore_clock_latency
eval set_false_path -hold [get_args_port_pin [list_add_prefix $PLIC_INPUTS $parent_path]]

### APB_CLK ports
set SYS_APB_INPUTS  {tdt_dmi_paddr* tdt_dmi_penable* tdt_dmi_psel* tdt_dmi_pw*}
set SYS_APB_OUTPUTS {tdt_dmi_prdata* tdt_dmi_pready* tdt_dmi_pslverr*}
if {$parent_path==""} {
  set_input_delay   -max [expr $SYS_APB_PERIOD*0.6] -clock V_SYS_APB_CLK [get_ports $SYS_APB_INPUTS]
  set_input_delay   -min 0                          -clock V_SYS_APB_CLK [get_ports $SYS_APB_INPUTS]
  set_output_delay  -max [expr $SYS_APB_PERIOD*0.6] -clock V_SYS_APB_CLK [get_ports $SYS_APB_OUTPUTS]
  set_output_delay  -min 0                          -clock V_SYS_APB_CLK [get_ports $SYS_APB_OUTPUTS]
}

### CPU_INPUT
if {$SYS_APB_SYNC==0} {
   #CPU Ports
  set CPU_INPUTS  {axim_clk_en*}
} else {
   #CPU sync sys apb
  set CPU_INPUTS  {axim_clk_en* sys_apb_clk_en*}
}

if {$parent_path==""} {
   set_input_delay  -max [expr $CPU_PERIOD*0.6] -clock V_CPU_CLK [get_ports $CPU_INPUTS]
   set_input_delay  -min 0                      -clock V_CPU_CLK [get_ports $CPU_INPUTS]
}

## SYS_Ports

if {$parent_path==""} {

   set SYS_CLK_INS  [remove_from_collection $DATA_INPUTS  [get_ports "$PLIC_INPUTS $CPU_INPUTS $SYS_APB_INPUTS"]]
   set SYS_CLK_OUTS [remove_from_collection [all_outputs] [get_ports $SYS_APB_OUTPUTS]]

   set_input_delay  -max [expr $SYS_AXI_PERIOD*0.6] -clock V_SYS_AXI_CLK $SYS_CLK_INS
   set_input_delay  -min 0                      -clock V_SYS_AXI_CLK $SYS_CLK_INS

   set_output_delay -max [expr $SYS_AXI_PERIOD*0.6] -clock V_SYS_AXI_CLK $SYS_CLK_OUTS
   set_output_delay -min 0                          -clock V_SYS_AXI_CLK $SYS_CLK_OUTS

}

##### Async Reset & Constants
set RESET {
pad_cpu_rst_b*
pad_yy_dft_clk_rst_b*
pad_yy_scan_rst_b*
sys_apb_rst_b*
}
eval set_false_path [get_args_port_pin [list_add_prefix $RESET $parent_path]]

set CONSTANTS {
pad_cpu_apb_base*
pad_cpu_rvba*
pad_plic_int_cfg*
}
eval set_false_path [get_args_port_pin [list_add_prefix $CONSTANTS $parent_path]]

set  DEBUG {core*_pad_retire*}
eval set_multicycle_path -setup 3 -start [get_args_port_pin [list_add_prefix $DEBUG $parent_path]]
eval set_multicycle_path -hold  2 -start [get_args_port_pin [list_add_prefix $DEBUG $parent_path]]

################################################################################
# Group Path
################################################################################
if {$parent_path!=""} { return }
unset parent_path

group_path -name INPUT  -from [all_inputs]
group_path -name OUTPUT -to [all_outputs]
group_path -name COMBO  -from [all_inputs] -to [all_outputs]

set_clock_uncertainty -setup $SETUP_UNCERTAINTY [all_clocks]
set_clock_uncertainty -hold $HOLD_UNCERTAINTY [all_clocks]

################################################################################
# Set DFT Signals
################################################################################

if {[sizeof_collection [get_ports -quiet pad_yy_mbist_mode]]} {
   set_false_path -from [get_ports pad_yy_mbist_mode]
}

set_case_analysis 0 [get_ports pad_yy_scan_mode]
set_case_analysis 0 [get_ports pad_yy_icg_scan_en]
if {[sizeof_collection [get_ports -quiet pad_yy_scan_enable]]} {
   set_case_analysis 0 [get_ports pad_yy_scan_enable]
}

