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

// &ModuleBeg; @22
module aq_mp_rst_top(
  ciu_rst_b,
  clkgen_rst_b,
  core0_rst_b,
  forever_cpuclk,
  pad_cpu_rst_b,
  pad_yy_dft_clk_rst_b,
  pad_yy_mbist_mode,
  pad_yy_scan_mode,
  pad_yy_scan_rst_b,
  sync_sys_apb_rst_b,
  sys_apb_clk,
  sys_apb_rst_b
);

// &Ports; @23
input        forever_cpuclk;      
input        pad_cpu_rst_b;       
input        pad_yy_dft_clk_rst_b; 
input        pad_yy_mbist_mode;   
input        pad_yy_scan_mode;    
input        pad_yy_scan_rst_b;   
input        sys_apb_clk;         
input        sys_apb_rst_b;       
output       ciu_rst_b;           
output       clkgen_rst_b;        
output       core0_rst_b;         
output       sync_sys_apb_rst_b;  

// &Regs; @24
reg          ciu_rst_ff_1st;      
reg          ciu_rst_ff_2nd;      
reg          ciu_rst_ff_3rd;      
reg          sys_apb_rst_ff_1st;  

// &Wires; @25
wire         async_apb_rst_b;     
wire         async_ciu_rst_b;     
wire         ciu_rst_b;           
wire         clkgen_rst_b;        
wire         core0_rst_b;         
wire         forever_cpuclk;      
wire         pad_cpu_rst_b;       
wire         pad_yy_dft_clk_rst_b; 
wire         pad_yy_mbist_mode;   
wire         pad_yy_scan_mode;    
wire         pad_yy_scan_rst_b;   
wire         sync_sys_apb_rst_b;  
wire         sys_apb_clk;         
wire         sys_apb_rst_b;       


//assign ciu_rre[3:0] = 4'b1;
////cpu reset 
//assign cpu0_rst_b = pad_core0_rst_b & ciu_rre[0] | pad_yy_mbist_mode;
//
//always @(posedge forever_cpuclk or negedge cpu0_rst_b)
//begin
//  if(!cpu0_rst_b)
//  begin
//    cpu0_rst_ff_1st <= 1'b0;
//    cpu0_rst_ff_2nd <= 1'b0;
//    cpu0_rst_ff_3rd <= 1'b0;
//  end
//  else
//  begin
//    cpu0_rst_ff_1st <= 1'b1;
//    cpu0_rst_ff_2nd <= cpu0_rst_ff_1st;
//    cpu0_rst_ff_3rd <= cpu0_rst_ff_2nd;
//  end
//end
//
//assign core0_rst_b =  pad_yy_scan_mode ? pad_yy_scan_rst_b : cpu0_rst_ff_3rd;
//
//
//
//

assign async_ciu_rst_b = pad_cpu_rst_b & !pad_yy_mbist_mode;

always @(posedge forever_cpuclk or negedge async_ciu_rst_b)
begin
  if (!async_ciu_rst_b)
  begin
    ciu_rst_ff_1st <= 1'b0;
    ciu_rst_ff_2nd <= 1'b0;
    ciu_rst_ff_3rd <= 1'b0;
  end
  else
  begin
    ciu_rst_ff_1st <= 1'b1;
    ciu_rst_ff_2nd <= ciu_rst_ff_1st;
    ciu_rst_ff_3rd <= ciu_rst_ff_2nd;
  end
end

assign async_apb_rst_b = sys_apb_rst_b & !pad_yy_mbist_mode;

always @(posedge sys_apb_clk or negedge async_apb_rst_b)
begin
  if (!async_apb_rst_b)
    sys_apb_rst_ff_1st <= 1'b0;
  else
    sys_apb_rst_ff_1st <= 1'b1;
end

// &Force("output","ciu_rst_b"); @149
assign ciu_rst_b   = pad_yy_scan_mode ? pad_yy_scan_rst_b : ciu_rst_ff_3rd;
assign core0_rst_b = ciu_rst_b;

assign sync_sys_apb_rst_b = pad_yy_scan_mode ? pad_yy_scan_rst_b : sys_apb_rst_ff_1st;

assign clkgen_rst_b = pad_yy_scan_mode ? pad_yy_dft_clk_rst_b : ciu_rst_ff_3rd;

//assign jtg_trst_b_bf_flop = async_ciu_rst_b & pad_had_jtg_trst_b ;
//assign trst_b = pad_yy_scan_mode ? pad_yy_scan_rst_b : jtg_trst_b_bf_flop;

// &ModuleEnd; @160
endmodule


