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

// &Depend("cpu_cfig.h"); @17

// &ModuleBeg; @19
module aq_cpuio_top(
  biu_cp0_coreid,
  biu_cp0_me_int,
  biu_cp0_ms_int,
  biu_cp0_mt_int,
  biu_cp0_rvba,
  biu_cp0_se_int,
  biu_cp0_ss_int,
  biu_cp0_st_int,
  biu_hpcp_time,
  clint_cpuio_time,
  cp0_biu_lpmd_b,
  cpuio_sysio_lpmd_b,
  pad_biu_coreid,
  sysio_cpuio_me_int,
  sysio_cpuio_ms_int,
  sysio_cpuio_mt_int,
  sysio_cpuio_se_int,
  sysio_cpuio_ss_int,
  sysio_cpuio_st_int,
  sysio_xx_rvba
);

// &Ports; @20
input   [63:0]  clint_cpuio_time;  
input   [1 :0]  cp0_biu_lpmd_b;    
input   [2 :0]  pad_biu_coreid;    
input           sysio_cpuio_me_int; 
input           sysio_cpuio_ms_int; 
input           sysio_cpuio_mt_int; 
input           sysio_cpuio_se_int; 
input           sysio_cpuio_ss_int; 
input           sysio_cpuio_st_int; 
input   [39:0]  sysio_xx_rvba;     
output  [2 :0]  biu_cp0_coreid;    
output          biu_cp0_me_int;    
output          biu_cp0_ms_int;    
output          biu_cp0_mt_int;    
output  [39:0]  biu_cp0_rvba;      
output          biu_cp0_se_int;    
output          biu_cp0_ss_int;    
output          biu_cp0_st_int;    
output  [63:0]  biu_hpcp_time;     
output  [1 :0]  cpuio_sysio_lpmd_b; 

// &Regs; @21

// &Wires; @22
wire    [2 :0]  biu_cp0_coreid;    
wire            biu_cp0_me_int;    
wire            biu_cp0_ms_int;    
wire            biu_cp0_mt_int;    
wire    [39:0]  biu_cp0_rvba;      
wire            biu_cp0_se_int;    
wire            biu_cp0_ss_int;    
wire            biu_cp0_st_int;    
wire    [63:0]  biu_hpcp_time;     
wire    [63:0]  clint_cpuio_time;  
wire    [1 :0]  cp0_biu_lpmd_b;    
wire    [1 :0]  cpuio_sysio_lpmd_b; 
wire    [2 :0]  pad_biu_coreid;    
wire            sysio_cpuio_me_int; 
wire            sysio_cpuio_ms_int; 
wire            sysio_cpuio_mt_int; 
wire            sysio_cpuio_se_int; 
wire            sysio_cpuio_ss_int; 
wire            sysio_cpuio_st_int; 
wire    [39:0]  sysio_xx_rvba;     


assign biu_cp0_coreid[2:0] = pad_biu_coreid[2:0];
assign biu_cp0_me_int      = sysio_cpuio_me_int;
assign biu_cp0_ms_int      = sysio_cpuio_ms_int;  
assign biu_cp0_mt_int      = sysio_cpuio_mt_int;
assign biu_cp0_se_int      = sysio_cpuio_se_int;
assign biu_cp0_ss_int      = sysio_cpuio_ss_int;
assign biu_cp0_st_int      = sysio_cpuio_st_int;
assign biu_hpcp_time[63:0] = clint_cpuio_time[63:0];
assign biu_cp0_rvba[39:0]  = sysio_xx_rvba[39:0];
assign cpuio_sysio_lpmd_b[1:0] = cp0_biu_lpmd_b[1:0];
// &ModuleEnd; @37
endmodule


