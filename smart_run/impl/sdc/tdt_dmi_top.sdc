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
if {![info exist APB_CLK_NAME]} { set APB_CLK_NAME SYS_APB_CLK } ;# Default SYS_APB_CLK
if {![info exist JTG_CLK_NAME]} { set JTG_CLK_NAME JTG_CLK } ;# Default JTG_CLK

################################################################################
# Initial variables for synthesis; modify this part based on design
################################################################################

set IF_READ_BUIDIN_VARIABLES 0 ;# For standalone usage, set to "1" ; For synthesis, set to "0"
set SYS_APB_SYNC      0 ; # For sync apb set to "1", for async apb set to "0"

set CPU_PERIOD   [expr (1000.00/1000)] ;# CPU is constrained at 1.0GHz
set JTG_PERIOD   [expr (1000.00/50)]   ;# JTG is constrained at 50MHz

if {$IF_READ_BUIDIN_VARIABLES} {
   set SETUP_UNCERTAINTY 0.2
   set HOLD_UNCERTAINTY  0.08
   set MAX_FANOUT        32
   set MAX_TRANSITION    0.5

   set LOAD_PIN         "AN2D2BWP12T30P140/A1"
   set DRIVING_CELL	"BUFFD2BWP12T30P140"
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
   set SYS_APB_PERIOD           [expr $CPU_PERIOD * 2.0]
  
   set CLK_INPUTS               [get_ports {*clk *clock *tck}]
   set DATA_INPUTS              [remove_from_collection [all_inputs] $CLK_INPUTS]
  
   set_max_fanout $MAX_FANOUT [current_design]
   set_max_transition $MAX_TRANSITION [current_design]
   set_input_transition 0.1 $CLK_INPUTS
   set_load [expr [load_of [get_lib_pins */$LOAD_PIN]]*5.0] [all_outputs]
   set_driving_cell -lib_cell $DRIVING_CELL $DATA_INPUTS
  
   create_clock [get_ports sys_apb_clk]      -name $APB_CLK_NAME -period $SYS_APB_PERIOD
   create_clock [get_ports pad_tdt_dtm_tclk] -name $JTG_CLK_NAME -period $JTG_PERIOD
  
   create_clock -name V_SYS_APB_CLK -period $SYS_APB_PERIOD
   create_clock -name V_JTG_CLK     -period $JTG_PERIOD
  
   set_max_delay [expr $SYS_APB_PERIOD] ignore_clock_latency \
      -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] \
      -to   [get_clocks [list $JTG_CLK_NAME V_JTG_CLK]]
   set_max_delay [expr $SYS_APB_PERIOD] ignore_clock_latency \
      -from [get_clocks [list $JTG_CLK_NAME V_JTG_CLK]] \
      -to   [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]]
  
   set_false_path -hold -from [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]] \
                        -to   [get_clocks [list $JTG_CLK_NAME V_JTG_CLK]]
   set_false_path -hold -from [get_clocks [list $JTG_CLK_NAME V_JTG_CLK]] \
                        -to   [get_clocks [list $APB_CLK_NAME V_SYS_APB_CLK]]
}

################################################################################
# Ports Constrains
################################################################################
### JTG Ports
set JTG_INPUTS  {pad_tdt_dtm_*}
set JTG_OUTPUTS {tdt_dtm_pad_t*}

if {$parent_path==""} {
   set_input_delay  -max [expr $JTG_PERIOD*0.9] -clock V_JTG_CLK [get_ports $JTG_INPUTS]
   set_input_delay  -min 0                      -clock V_JTG_CLK [get_ports $JTG_INPUTS]

   set_output_delay -max [expr $JTG_PERIOD*0.9] -clock V_JTG_CLK [get_ports $JTG_OUTPUTS] -clock_fall
   set_output_delay -min 0                      -clock V_JTG_CLK [get_ports $JTG_OUTPUTS] -clock_fall
}

### SYS APB Ports
set APB_INPUTS  [remove_from_collection $DATA_INPUTS  [get_ports $JTG_INPUTS]]
set APB_OUTPUTS [remove_from_collection [all_outputs] [get_ports $JTG_OUTPUTS]]

if {$parent_path==""} {
   set_input_delay   -max [expr $SYS_APB_PERIOD*0.6] -clock V_SYS_APB_CLK [get_ports $APB_INPUTS]
   set_input_delay   -min 0                          -clock V_SYS_APB_CLK [get_ports $APB_INPUTS]
   set_output_delay  -max [expr $SYS_APB_PERIOD*0.6] -clock V_SYS_APB_CLK [get_ports $APB_OUTPUTS]
   set_output_delay  -min 0                          -clock V_SYS_APB_CLK [get_ports $APB_OUTPUTS]
}

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
set_case_analysis 0 [get_ports pad_tdt_icg_scan_en]
set_case_analysis 0 [get_ports pad_yy_scan_mode

