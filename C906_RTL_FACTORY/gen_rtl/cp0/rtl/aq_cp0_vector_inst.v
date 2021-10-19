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

// &ModuleBeg; @23
module aq_cp0_vector_inst(
  iui_special_rs1_x0,
  iui_special_vsetvl,
  iui_special_vsetvl_dp,
  iui_special_vsetvl_rs1,
  iui_special_vsetvl_rs2,
  special_iui_vsetvl_wdata,
  special_regs_vsetvl_dp
);


// &Ports; @25
input           iui_special_rs1_x0;      
input           iui_special_vsetvl;      
input           iui_special_vsetvl_dp;   
input   [63:0]  iui_special_vsetvl_rs1;  
input   [11:0]  iui_special_vsetvl_rs2;  
output  [63:0]  special_iui_vsetvl_wdata; 
output          special_regs_vsetvl_dp;  

// &Regs; @26

// &Wires; @27
wire    [63:0]  special_iui_vsetvl_wdata; 
wire            special_regs_vsetvl_dp;  


// &Force("bus", "iui_special_vsetvl_rs2", 11, 0); @36
// &CombBeg; @85
// &CombEnd; @113
// &Force("output","special_vsetvl_illegal"); @141
// &CombBeg; @142
// &CombEnd; @155
assign special_iui_vsetvl_wdata[63:0] = 64'b0;
// &Force("input", "iui_special_vsetvl_rs1"); &Force("bus", "iui_special_vsetvl_rs1", 63, 0); @178
// &Force("input", "iui_special_vsetvl_rs2"); &Force("bus", "iui_special_vsetvl_rs2", 11, 0); @179
// &Force("input", "iui_special_rs1_x0"); @180
// &Force("input", "iui_special_vsetvl"); @181
// &Force("input", "iui_special_vsetvl_dp"); @182
assign special_regs_vsetvl_dp = 1'b0;

// &ModuleEnd; @186
endmodule



