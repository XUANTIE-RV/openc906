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
module aq_dtu_mcontrol_output_select(
  action0_mcontrol,
  action1_mcontrol,
  cp0_dtu_icg_en,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_write_tdata1,
  cp0_write_tdata2,
  cp0_write_tdata3,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_ifu_halt_info_vld,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  exe0_16bit,
  exe0_32bit,
  exe1_16bit,
  exe1_32bit,
  forever_cpuclk,
  ifu_dtu_addr_vld0,
  ifu_dtu_addr_vld1,
  ifu_dtu_data_vld0,
  ifu_dtu_data_vld1,
  ifu_dtu_exe_addr0,
  ifu_dtu_exe_addr1,
  ifu_dtu_exe_data0,
  ifu_dtu_exe_data1,
  ldst_128bit,
  ldst_16bit,
  ldst_32bit,
  ldst_64bit,
  ldst_8bit,
  ldst_addr_mcontrol,
  ldst_data_mcontrol,
  load_addr_vld,
  load_data_vld,
  lsu_dtu_halt_info,
  lsu_dtu_last_check,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  m0_tdata1,
  m0_tdata2,
  m0_tdata3,
  m0_tinfo,
  m1_tdata1,
  m1_tdata2,
  m1_tdata3,
  m1_tinfo,
  m2_tdata1,
  m2_tdata2,
  m2_tdata3,
  m2_tinfo,
  m3_tdata1,
  m3_tdata2,
  m3_tdata3,
  m3_tinfo,
  m4_tdata1,
  m4_tdata2,
  m4_tdata3,
  m4_tinfo,
  m5_tdata1,
  m5_tdata2,
  m5_tdata3,
  m5_tinfo,
  m6_tdata1,
  m6_tdata2,
  m6_tdata3,
  m6_tinfo,
  m7_tdata1,
  m7_tdata2,
  m7_tdata3,
  m7_tinfo,
  m_mode,
  mcontext,
  mcontrol_halt_info0,
  mcontrol_halt_info1,
  mcontrol_hit,
  pad_yy_icg_scan_en,
  rtu_yy_xx_dbgon,
  s_mode,
  scontext,
  store_addr_vld,
  store_data_vld,
  tcontrol,
  tselect_wr_en,
  u_mode
);

// &Ports; @21
input           cp0_dtu_icg_en;                    
input   [63:0]  cp0_dtu_satp;                      
input   [63:0]  cp0_dtu_wdata;                     
input           cp0_write_tdata1;                  
input           cp0_write_tdata2;                  
input           cp0_write_tdata3;                  
input           cp0_yy_clk_en;                     
input           cpurst_b;                          
input           exe0_16bit;                        
input           exe0_32bit;                        
input           exe1_16bit;                        
input           exe1_32bit;                        
input           forever_cpuclk;                    
input           ifu_dtu_addr_vld0;                 
input           ifu_dtu_addr_vld1;                 
input           ifu_dtu_data_vld0;                 
input           ifu_dtu_data_vld1;                 
input   [39:0]  ifu_dtu_exe_addr0;                 
input   [39:0]  ifu_dtu_exe_addr1;                 
input   [31:0]  ifu_dtu_exe_data0;                 
input   [31:0]  ifu_dtu_exe_data1;                 
input           ldst_128bit;                       
input           ldst_16bit;                        
input           ldst_32bit;                        
input           ldst_64bit;                        
input           ldst_8bit;                         
input           load_addr_vld;                     
input           load_data_vld;                     
input   [21:0]  lsu_dtu_halt_info;                 
input           lsu_dtu_last_check;                
input   [39:0]  lsu_dtu_ldst_addr;                 
input           lsu_dtu_ldst_addr_vld;             
input   [15:0]  lsu_dtu_ldst_bytes_vld;            
input   [63:0]  lsu_dtu_ldst_data;                 
input           lsu_dtu_ldst_data_vld;             
input           m_mode;                            
input   [63:0]  mcontext;                          
input   [7 :0]  mcontrol_hit;                      
input           pad_yy_icg_scan_en;                
input           rtu_yy_xx_dbgon;                   
input           s_mode;                            
input   [63:0]  scontext;                          
input           store_addr_vld;                    
input           store_data_vld;                    
input   [63:0]  tcontrol;                          
input   [9 :0]  tselect_wr_en;                     
input           u_mode;                            
output  [7 :0]  action0_mcontrol;                  
output  [7 :0]  action1_mcontrol;                  
output          dtu_ifu_halt_info_vld;             
output  [21:0]  dtu_lsu_halt_info;                 
output          dtu_lsu_halt_info_vld;             
output          ldst_addr_mcontrol;                
output          ldst_data_mcontrol;                
output  [63:0]  m0_tdata1;                         
output  [63:0]  m0_tdata2;                         
output  [63:0]  m0_tdata3;                         
output  [63:0]  m0_tinfo;                          
output  [63:0]  m1_tdata1;                         
output  [63:0]  m1_tdata2;                         
output  [63:0]  m1_tdata3;                         
output  [63:0]  m1_tinfo;                          
output  [63:0]  m2_tdata1;                         
output  [63:0]  m2_tdata2;                         
output  [63:0]  m2_tdata3;                         
output  [63:0]  m2_tinfo;                          
output  [63:0]  m3_tdata1;                         
output  [63:0]  m3_tdata2;                         
output  [63:0]  m3_tdata3;                         
output  [63:0]  m3_tinfo;                          
output  [63:0]  m4_tdata1;                         
output  [63:0]  m4_tdata2;                         
output  [63:0]  m4_tdata3;                         
output  [63:0]  m4_tinfo;                          
output  [63:0]  m5_tdata1;                         
output  [63:0]  m5_tdata2;                         
output  [63:0]  m5_tdata3;                         
output  [63:0]  m5_tinfo;                          
output  [63:0]  m6_tdata1;                         
output  [63:0]  m6_tdata2;                         
output  [63:0]  m6_tdata3;                         
output  [63:0]  m6_tinfo;                          
output  [63:0]  m7_tdata1;                         
output  [63:0]  m7_tdata2;                         
output  [63:0]  m7_tdata3;                         
output  [63:0]  m7_tinfo;                          
output  [21:0]  mcontrol_halt_info0;               
output  [21:0]  mcontrol_halt_info1;               

// &Regs; @22
reg             cp0_write_tdata1_f;                
reg             exe_cycle2_cannot_hit;             
reg             ldst_cancel;                       
reg             ldst_cycle2_cannot_hit;            
reg     [7 :0]  ldst_match;                        
reg             lsu_dtu_last_check_f;              
reg     [1 :0]  m1_mtiming;                        
reg     [1 :0]  m1_mtiming_mask;                   
reg     [1 :0]  m1_priority;                       
reg     [1 :0]  m1_priority_mask;                  
reg     [1 :0]  m2_mtiming;                        
reg     [1 :0]  m2_mtiming_mask;                   
reg     [1 :0]  m2_priority;                       
reg     [1 :0]  m2_priority_mask;                  
reg     [1 :0]  m3_mtiming;                        
reg     [1 :0]  m3_mtiming_mask;                   
reg     [1 :0]  m3_priority;                       
reg     [1 :0]  m3_priority_mask;                  
reg     [1 :0]  m4_mtiming;                        
reg     [1 :0]  m4_mtiming_mask;                   
reg     [1 :0]  m4_priority;                       
reg     [1 :0]  m4_priority_mask;                  
reg     [1 :0]  m5_mtiming;                        
reg     [1 :0]  m5_mtiming_mask;                   
reg     [1 :0]  m5_priority;                       
reg     [1 :0]  m5_priority_mask;                  
reg     [1 :0]  m6_mtiming;                        
reg     [1 :0]  m6_mtiming_mask;                   
reg     [1 :0]  m6_priority;                       
reg     [1 :0]  m6_priority_mask;                  
reg             need_match_store_data_t0_trigger_f; 
reg     [6 :0]  x_phigher_than_m0_reg;             
reg     [6 :0]  x_phigher_than_m1_reg;             
reg     [6 :0]  x_phigher_than_m2_reg;             
reg     [6 :0]  x_phigher_than_m3_reg;             
reg     [6 :0]  x_phigher_than_m4_reg;             
reg     [6 :0]  x_phigher_than_m5_reg;             
reg     [6 :0]  x_phigher_than_m6_reg;             
reg     [6 :0]  x_phigher_than_m7_reg;             
reg     [6 :0]  x_thigher_than_m0_reg;             
reg     [6 :0]  x_thigher_than_m1_reg;             
reg     [6 :0]  x_thigher_than_m2_reg;             
reg     [6 :0]  x_thigher_than_m3_reg;             
reg     [6 :0]  x_thigher_than_m4_reg;             
reg     [6 :0]  x_thigher_than_m5_reg;             
reg     [6 :0]  x_thigher_than_m6_reg;             
reg     [6 :0]  x_thigher_than_m7_reg;             

// &Wires; @23
wire    [7 :0]  action0_mcontrol;                  
wire    [7 :0]  action1_mcontrol;                  
wire    [7 :0]  already_match;                     
wire            chain0_exe_ldst;                   
wire            chain0_on;                         
wire            chain0_same_timing;                
wire            chain0_timing0_match;              
wire            chain1_exe_ldst;                   
wire            chain1_on;                         
wire            chain1_same_timing;                
wire            chain1_timing0_match;              
wire            chain2_exe_ldst;                   
wire            chain2_on;                         
wire            chain2_same_timing;                
wire            chain2_timing0_match;              
wire            chain3_exe_ldst;                   
wire            chain3_on;                         
wire            chain3_same_timing;                
wire            chain3_timing0_match;              
wire            chain4_exe_ldst;                   
wire            chain4_on;                         
wire            chain4_same_timing;                
wire            chain4_timing0_match;              
wire            chain5_exe_ldst;                   
wire            chain5_on;                         
wire            chain5_same_timing;                
wire            chain5_timing0_match;              
wire            chain6_exe_ldst;                   
wire            chain6_on;                         
wire            chain6_same_timing;                
wire            chain6_timing0_match;              
wire            cp0_dtu_icg_en;                    
wire    [63:0]  cp0_dtu_satp;                      
wire    [63:0]  cp0_dtu_wdata;                     
wire            cp0_write_tdata1;                  
wire            cp0_write_tdata2;                  
wire            cp0_write_tdata3;                  
wire            cp0_yy_clk_en;                     
wire            cpurst_b;                          
wire            dtu_ifu_halt_info_vld;             
wire    [21:0]  dtu_lsu_halt_info;                 
wire            dtu_lsu_halt_info_vld;             
wire            exe0_16bit;                        
wire            exe0_32bit;                        
wire            exe0_action;                       
wire            exe0_action0;                      
wire            exe0_action01;                     
wire            exe0_action1;                      
wire    [7 :0]  exe0_after_chain_match;            
wire            exe0_after_chain_match0;           
wire            exe0_after_chain_match1;           
wire            exe0_after_chain_match2;           
wire            exe0_after_chain_match3;           
wire            exe0_after_chain_match4;           
wire            exe0_after_chain_match5;           
wire            exe0_after_chain_match6;           
wire            exe0_after_chain_match7;           
wire            exe0_cancel;                       
wire            exe0_chain;                        
wire            exe0_chain0_match;                 
wire            exe0_chain1_match;                 
wire            exe0_chain2_match;                 
wire            exe0_chain3_match;                 
wire            exe0_chain4_match;                 
wire            exe0_chain5_match;                 
wire            exe0_chain6_match;                 
wire            exe0_chain_cancel;                 
wire            exe0_have_match;                   
wire    [7 :0]  exe0_match;                        
wire            exe0_may_hit;                      
wire            exe0_mcontrol0_single_match;       
wire            exe0_mcontrol1_single_match;       
wire            exe0_mcontrol2_single_match;       
wire            exe0_mcontrol3_single_match;       
wire            exe0_mcontrol4_single_match;       
wire            exe0_mcontrol5_single_match;       
wire            exe0_mcontrol6_single_match;       
wire            exe0_mcontrol7_single_match;       
wire            exe0_single_mcontrol_cancel;       
wire            exe0_timing;                       
wire            exe1_16bit;                        
wire            exe1_32bit;                        
wire            exe1_action;                       
wire            exe1_action0;                      
wire            exe1_action01;                     
wire            exe1_action1;                      
wire    [7 :0]  exe1_after_chain_match;            
wire            exe1_after_chain_match0;           
wire            exe1_after_chain_match1;           
wire            exe1_after_chain_match2;           
wire            exe1_after_chain_match3;           
wire            exe1_after_chain_match4;           
wire            exe1_after_chain_match5;           
wire            exe1_after_chain_match6;           
wire            exe1_after_chain_match7;           
wire            exe1_cancel;                       
wire            exe1_chain;                        
wire            exe1_chain0_match;                 
wire            exe1_chain1_match;                 
wire            exe1_chain2_match;                 
wire            exe1_chain3_match;                 
wire            exe1_chain4_match;                 
wire            exe1_chain5_match;                 
wire            exe1_chain6_match;                 
wire            exe1_chain_cancel;                 
wire            exe1_have_match;                   
wire    [7 :0]  exe1_match;                        
wire            exe1_may_hit;                      
wire            exe1_mcontrol0_single_match;       
wire            exe1_mcontrol1_single_match;       
wire            exe1_mcontrol2_single_match;       
wire            exe1_mcontrol3_single_match;       
wire            exe1_mcontrol4_single_match;       
wire            exe1_mcontrol5_single_match;       
wire            exe1_mcontrol6_single_match;       
wire            exe1_mcontrol7_single_match;       
wire            exe1_single_mcontrol_cancel;       
wire            exe1_timing;                       
wire            exe_may_hit;                       
wire            forever_cpuclk;                    
wire            have_store_data_timing0;           
wire            have_timing0_match;                
wire            ifu_dtu_addr_vld0;                 
wire            ifu_dtu_addr_vld1;                 
wire            ifu_dtu_data_vld0;                 
wire            ifu_dtu_data_vld1;                 
wire    [39:0]  ifu_dtu_exe_addr0;                 
wire    [39:0]  ifu_dtu_exe_addr1;                 
wire    [31:0]  ifu_dtu_exe_data0;                 
wire    [31:0]  ifu_dtu_exe_data1;                 
wire            ldst_128bit;                       
wire            ldst_16bit;                        
wire            ldst_32bit;                        
wire            ldst_64bit;                        
wire            ldst_8bit;                         
wire            ldst_action;                       
wire            ldst_action0;                      
wire            ldst_action01;                     
wire            ldst_action1;                      
wire            ldst_addr_mcontrol;                
wire    [7 :0]  ldst_after_chain_match;            
wire            ldst_after_chain_match0;           
wire            ldst_after_chain_match1;           
wire            ldst_after_chain_match2;           
wire            ldst_after_chain_match3;           
wire            ldst_after_chain_match4;           
wire            ldst_after_chain_match5;           
wire            ldst_after_chain_match6;           
wire            ldst_after_chain_match7;           
wire            ldst_chain0_match;                 
wire            ldst_chain1_match;                 
wire            ldst_chain2_match;                 
wire            ldst_chain3_match;                 
wire            ldst_chain4_match;                 
wire            ldst_chain5_match;                 
wire            ldst_chain6_match;                 
wire            ldst_data_mcontrol;                
wire            ldst_have_match;                   
wire            ldst_may_hit;                      
wire            ldst_mcontrol0_single_match;       
wire            ldst_mcontrol0_timing0_match;      
wire            ldst_mcontrol1_single_match;       
wire            ldst_mcontrol1_timing0_match;      
wire            ldst_mcontrol2_single_match;       
wire            ldst_mcontrol2_timing0_match;      
wire            ldst_mcontrol3_single_match;       
wire            ldst_mcontrol3_timing0_match;      
wire            ldst_mcontrol4_single_match;       
wire            ldst_mcontrol4_timing0_match;      
wire            ldst_mcontrol5_single_match;       
wire            ldst_mcontrol5_timing0_match;      
wire            ldst_mcontrol6_single_match;       
wire            ldst_mcontrol6_timing0_match;      
wire            ldst_mcontrol7_single_match;       
wire            ldst_mcontrol7_timing0_match;      
wire            ldst_timing;                       
wire            load_addr_vld;                     
wire            load_data_vld;                     
wire    [21:0]  lsu_dtu_halt_info;                 
wire            lsu_dtu_last_check;                
wire    [39:0]  lsu_dtu_ldst_addr;                 
wire            lsu_dtu_ldst_addr_vld;             
wire    [15:0]  lsu_dtu_ldst_bytes_vld;            
wire    [63:0]  lsu_dtu_ldst_data;                 
wire            lsu_dtu_ldst_data_vld;             
wire            m01_is_exe_chain;                  
wire            m0_exe0_action0;                   
wire            m0_exe0_action1;                   
wire            m0_exe0_can_match;                 
wire            m0_exe0_chain;                     
wire            m0_exe0_match;                     
wire            m0_exe1_action0;                   
wire            m0_exe1_action1;                   
wire            m0_exe1_can_match;                 
wire            m0_exe1_chain;                     
wire            m0_exe1_match;                     
wire            m0_exe_chain_modify;               
wire            m0_ldst_action0;                   
wire            m0_ldst_action1;                   
wire            m0_ldst_can_match;                 
wire            m0_ldst_match;                     
wire            m0_ldst_timing;                    
wire    [1 :0]  m0_mtiming;                        
wire    [1 :0]  m0_mtiming_mask;                   
wire            m0_phigher_than_m1;                
wire            m0_phigher_than_m2;                
wire            m0_phigher_than_m3;                
wire            m0_phigher_than_m4;                
wire            m0_phigher_than_m5;                
wire            m0_phigher_than_m6;                
wire            m0_phigher_than_m7;                
wire    [1 :0]  m0_priority;                       
wire    [1 :0]  m0_priority_mask;                  
wire    [63:0]  m0_tdata1;                         
wire    [63:0]  m0_tdata2;                         
wire    [63:0]  m0_tdata3;                         
wire            m0_thigher_than_m1;                
wire            m0_thigher_than_m2;                
wire            m0_thigher_than_m3;                
wire            m0_thigher_than_m4;                
wire            m0_thigher_than_m5;                
wire            m0_thigher_than_m6;                
wire            m0_thigher_than_m7;                
wire    [63:0]  m0_tinfo;                          
wire            m12_is_exe_chain;                  
wire            m1_exe0_action0;                   
wire            m1_exe0_action1;                   
wire            m1_exe0_can_match;                 
wire            m1_exe0_chain;                     
wire            m1_exe0_match;                     
wire            m1_exe1_action0;                   
wire            m1_exe1_action1;                   
wire            m1_exe1_can_match;                 
wire            m1_exe1_chain;                     
wire            m1_exe1_match;                     
wire            m1_exe_chain_modify;               
wire            m1_ldst_action0;                   
wire            m1_ldst_action1;                   
wire            m1_ldst_can_match;                 
wire            m1_ldst_match;                     
wire            m1_ldst_timing;                    
wire            m1_phigher_than_m0;                
wire            m1_phigher_than_m0_no_chain;       
wire            m1_phigher_than_m2;                
wire            m1_phigher_than_m3;                
wire            m1_phigher_than_m4;                
wire            m1_phigher_than_m5;                
wire            m1_phigher_than_m6;                
wire            m1_phigher_than_m7;                
wire    [63:0]  m1_tdata1;                         
wire    [63:0]  m1_tdata2;                         
wire    [63:0]  m1_tdata3;                         
wire            m1_thigher_than_m0;                
wire            m1_thigher_than_m0_no_chain;       
wire            m1_thigher_than_m2;                
wire            m1_thigher_than_m3;                
wire            m1_thigher_than_m4;                
wire            m1_thigher_than_m5;                
wire            m1_thigher_than_m6;                
wire            m1_thigher_than_m7;                
wire    [63:0]  m1_tinfo;                          
wire            m23_is_exe_chain;                  
wire            m2_exe0_action0;                   
wire            m2_exe0_action1;                   
wire            m2_exe0_can_match;                 
wire            m2_exe0_chain;                     
wire            m2_exe0_match;                     
wire            m2_exe1_action0;                   
wire            m2_exe1_action1;                   
wire            m2_exe1_can_match;                 
wire            m2_exe1_chain;                     
wire            m2_exe1_match;                     
wire            m2_exe_chain_modify;               
wire            m2_ldst_action0;                   
wire            m2_ldst_action1;                   
wire            m2_ldst_can_match;                 
wire            m2_ldst_match;                     
wire            m2_ldst_timing;                    
wire            m2_phigher_than_m0;                
wire            m2_phigher_than_m1;                
wire            m2_phigher_than_m1_no_chain;       
wire            m2_phigher_than_m3;                
wire            m2_phigher_than_m4;                
wire            m2_phigher_than_m5;                
wire            m2_phigher_than_m6;                
wire            m2_phigher_than_m7;                
wire    [63:0]  m2_tdata1;                         
wire    [63:0]  m2_tdata2;                         
wire    [63:0]  m2_tdata3;                         
wire            m2_thigher_than_m0;                
wire            m2_thigher_than_m1;                
wire            m2_thigher_than_m1_no_chain;       
wire            m2_thigher_than_m3;                
wire            m2_thigher_than_m4;                
wire            m2_thigher_than_m5;                
wire            m2_thigher_than_m6;                
wire            m2_thigher_than_m7;                
wire    [63:0]  m2_tinfo;                          
wire            m34_is_exe_chain;                  
wire            m3_exe0_action0;                   
wire            m3_exe0_action1;                   
wire            m3_exe0_can_match;                 
wire            m3_exe0_chain;                     
wire            m3_exe0_match;                     
wire            m3_exe1_action0;                   
wire            m3_exe1_action1;                   
wire            m3_exe1_can_match;                 
wire            m3_exe1_chain;                     
wire            m3_exe1_match;                     
wire            m3_exe_chain_modify;               
wire            m3_ldst_action0;                   
wire            m3_ldst_action1;                   
wire            m3_ldst_can_match;                 
wire            m3_ldst_match;                     
wire            m3_ldst_timing;                    
wire            m3_phigher_than_m0;                
wire            m3_phigher_than_m1;                
wire            m3_phigher_than_m2;                
wire            m3_phigher_than_m2_no_chain;       
wire            m3_phigher_than_m4;                
wire            m3_phigher_than_m5;                
wire            m3_phigher_than_m6;                
wire            m3_phigher_than_m7;                
wire    [63:0]  m3_tdata1;                         
wire    [63:0]  m3_tdata2;                         
wire    [63:0]  m3_tdata3;                         
wire            m3_thigher_than_m0;                
wire            m3_thigher_than_m1;                
wire            m3_thigher_than_m2;                
wire            m3_thigher_than_m2_no_chain;       
wire            m3_thigher_than_m4;                
wire            m3_thigher_than_m5;                
wire            m3_thigher_than_m6;                
wire            m3_thigher_than_m7;                
wire    [63:0]  m3_tinfo;                          
wire            m45_is_exe_chain;                  
wire            m4_exe0_action0;                   
wire            m4_exe0_action1;                   
wire            m4_exe0_can_match;                 
wire            m4_exe0_chain;                     
wire            m4_exe0_match;                     
wire            m4_exe1_action0;                   
wire            m4_exe1_action1;                   
wire            m4_exe1_can_match;                 
wire            m4_exe1_chain;                     
wire            m4_exe1_match;                     
wire            m4_exe_chain_modify;               
wire            m4_ldst_action0;                   
wire            m4_ldst_action1;                   
wire            m4_ldst_can_match;                 
wire            m4_ldst_match;                     
wire            m4_ldst_timing;                    
wire            m4_phigher_than_m0;                
wire            m4_phigher_than_m1;                
wire            m4_phigher_than_m2;                
wire            m4_phigher_than_m3;                
wire            m4_phigher_than_m3_no_chain;       
wire            m4_phigher_than_m5;                
wire            m4_phigher_than_m6;                
wire            m4_phigher_than_m7;                
wire    [63:0]  m4_tdata1;                         
wire    [63:0]  m4_tdata2;                         
wire    [63:0]  m4_tdata3;                         
wire            m4_thigher_than_m0;                
wire            m4_thigher_than_m1;                
wire            m4_thigher_than_m2;                
wire            m4_thigher_than_m3;                
wire            m4_thigher_than_m3_no_chain;       
wire            m4_thigher_than_m5;                
wire            m4_thigher_than_m6;                
wire            m4_thigher_than_m7;                
wire    [63:0]  m4_tinfo;                          
wire            m56_is_exe_chain;                  
wire            m5_exe0_action0;                   
wire            m5_exe0_action1;                   
wire            m5_exe0_can_match;                 
wire            m5_exe0_chain;                     
wire            m5_exe0_match;                     
wire            m5_exe1_action0;                   
wire            m5_exe1_action1;                   
wire            m5_exe1_can_match;                 
wire            m5_exe1_chain;                     
wire            m5_exe1_match;                     
wire            m5_exe_chain_modify;               
wire            m5_ldst_action0;                   
wire            m5_ldst_action1;                   
wire            m5_ldst_can_match;                 
wire            m5_ldst_match;                     
wire            m5_ldst_timing;                    
wire            m5_phigher_than_m0;                
wire            m5_phigher_than_m1;                
wire            m5_phigher_than_m2;                
wire            m5_phigher_than_m3;                
wire            m5_phigher_than_m4;                
wire            m5_phigher_than_m4_no_chain;       
wire            m5_phigher_than_m6;                
wire            m5_phigher_than_m7;                
wire    [63:0]  m5_tdata1;                         
wire    [63:0]  m5_tdata2;                         
wire    [63:0]  m5_tdata3;                         
wire            m5_thigher_than_m0;                
wire            m5_thigher_than_m1;                
wire            m5_thigher_than_m2;                
wire            m5_thigher_than_m3;                
wire            m5_thigher_than_m4;                
wire            m5_thigher_than_m4_no_chain;       
wire            m5_thigher_than_m6;                
wire            m5_thigher_than_m7;                
wire    [63:0]  m5_tinfo;                          
wire            m67_is_exe_chain;                  
wire            m6_exe0_action0;                   
wire            m6_exe0_action1;                   
wire            m6_exe0_can_match;                 
wire            m6_exe0_chain;                     
wire            m6_exe0_match;                     
wire            m6_exe1_action0;                   
wire            m6_exe1_action1;                   
wire            m6_exe1_can_match;                 
wire            m6_exe1_chain;                     
wire            m6_exe1_match;                     
wire            m6_exe_chain_modify;               
wire            m6_ldst_action0;                   
wire            m6_ldst_action1;                   
wire            m6_ldst_can_match;                 
wire            m6_ldst_match;                     
wire            m6_ldst_timing;                    
wire            m6_phigher_than_m0;                
wire            m6_phigher_than_m1;                
wire            m6_phigher_than_m2;                
wire            m6_phigher_than_m3;                
wire            m6_phigher_than_m4;                
wire            m6_phigher_than_m5;                
wire            m6_phigher_than_m5_no_chain;       
wire            m6_phigher_than_m7;                
wire    [63:0]  m6_tdata1;                         
wire    [63:0]  m6_tdata2;                         
wire    [63:0]  m6_tdata3;                         
wire            m6_thigher_than_m0;                
wire            m6_thigher_than_m1;                
wire            m6_thigher_than_m2;                
wire            m6_thigher_than_m3;                
wire            m6_thigher_than_m4;                
wire            m6_thigher_than_m5;                
wire            m6_thigher_than_m5_no_chain;       
wire            m6_thigher_than_m7;                
wire    [63:0]  m6_tinfo;                          
wire            m7_exe0_action0;                   
wire            m7_exe0_action1;                   
wire            m7_exe0_can_match;                 
wire            m7_exe0_chain;                     
wire            m7_exe0_match;                     
wire            m7_exe1_action0;                   
wire            m7_exe1_action1;                   
wire            m7_exe1_can_match;                 
wire            m7_exe1_chain;                     
wire            m7_exe1_match;                     
wire            m7_exe_chain_modify;               
wire            m7_ldst_action0;                   
wire            m7_ldst_action1;                   
wire            m7_ldst_can_match;                 
wire            m7_ldst_match;                     
wire            m7_ldst_timing;                    
wire    [1 :0]  m7_mtiming;                        
wire    [1 :0]  m7_mtiming_mask;                   
wire            m7_phigher_than_m0;                
wire            m7_phigher_than_m1;                
wire            m7_phigher_than_m2;                
wire            m7_phigher_than_m3;                
wire            m7_phigher_than_m4;                
wire            m7_phigher_than_m5;                
wire            m7_phigher_than_m6;                
wire            m7_phigher_than_m6_no_chain;       
wire    [1 :0]  m7_priority;                       
wire    [1 :0]  m7_priority_mask;                  
wire    [63:0]  m7_tdata1;                         
wire    [63:0]  m7_tdata2;                         
wire    [63:0]  m7_tdata3;                         
wire            m7_thigher_than_m0;                
wire            m7_thigher_than_m1;                
wire            m7_thigher_than_m2;                
wire            m7_thigher_than_m3;                
wire            m7_thigher_than_m4;                
wire            m7_thigher_than_m5;                
wire            m7_thigher_than_m6;                
wire            m7_thigher_than_m6_no_chain;       
wire    [63:0]  m7_tinfo;                          
wire            m_mode;                            
wire    [63:0]  mcontext;                          
wire            mcontrol0_action0;                 
wire            mcontrol0_action1;                 
wire            mcontrol0_chain;                   
wire            mcontrol0_dmode;                   
wire            mcontrol0_exe0_cancel;             
wire            mcontrol0_exe0_match;              
wire            mcontrol0_exe0_may_hit;            
wire            mcontrol0_exe1_cancel;             
wire            mcontrol0_exe1_match;              
wire            mcontrol0_exe1_may_hit;            
wire            mcontrol0_is_exe;                  
wire            mcontrol0_is_ldst;                 
wire            mcontrol0_is_ldst_addr;            
wire            mcontrol0_is_ldst_data;            
wire            mcontrol0_ldst_match;              
wire            mcontrol0_ldst_may_hit;            
wire    [1 :0]  mcontrol0_mtiming;                 
wire    [1 :0]  mcontrol0_mtiming_mask;            
wire    [1 :0]  mcontrol0_priority;                
wire    [1 :0]  mcontrol0_priority_mask;           
wire            mcontrol0_store_data_timing0;      
wire            mcontrol0_timing;                  
wire            mcontrol1_action0;                 
wire            mcontrol1_action1;                 
wire            mcontrol1_chain;                   
wire            mcontrol1_dmode;                   
wire            mcontrol1_exe0_cancel;             
wire            mcontrol1_exe0_match;              
wire            mcontrol1_exe0_may_hit;            
wire            mcontrol1_exe1_cancel;             
wire            mcontrol1_exe1_match;              
wire            mcontrol1_exe1_may_hit;            
wire            mcontrol1_is_exe;                  
wire            mcontrol1_is_ldst;                 
wire            mcontrol1_is_ldst_addr;            
wire            mcontrol1_is_ldst_data;            
wire            mcontrol1_ldst_match;              
wire            mcontrol1_ldst_may_hit;            
wire    [1 :0]  mcontrol1_mtiming;                 
wire    [1 :0]  mcontrol1_mtiming_mask;            
wire    [1 :0]  mcontrol1_priority;                
wire    [1 :0]  mcontrol1_priority_mask;           
wire            mcontrol1_store_data_timing0;      
wire            mcontrol1_timing;                  
wire            mcontrol2_action0;                 
wire            mcontrol2_action1;                 
wire            mcontrol2_chain;                   
wire            mcontrol2_dmode;                   
wire            mcontrol2_exe0_cancel;             
wire            mcontrol2_exe0_match;              
wire            mcontrol2_exe0_may_hit;            
wire            mcontrol2_exe1_cancel;             
wire            mcontrol2_exe1_match;              
wire            mcontrol2_exe1_may_hit;            
wire            mcontrol2_is_exe;                  
wire            mcontrol2_is_ldst;                 
wire            mcontrol2_is_ldst_addr;            
wire            mcontrol2_is_ldst_data;            
wire            mcontrol2_ldst_match;              
wire            mcontrol2_ldst_may_hit;            
wire    [1 :0]  mcontrol2_mtiming;                 
wire    [1 :0]  mcontrol2_mtiming_mask;            
wire    [1 :0]  mcontrol2_priority;                
wire    [1 :0]  mcontrol2_priority_mask;           
wire            mcontrol2_store_data_timing0;      
wire            mcontrol2_timing;                  
wire            mcontrol3_action0;                 
wire            mcontrol3_action1;                 
wire            mcontrol3_chain;                   
wire            mcontrol3_dmode;                   
wire            mcontrol3_exe0_cancel;             
wire            mcontrol3_exe0_match;              
wire            mcontrol3_exe0_may_hit;            
wire            mcontrol3_exe1_cancel;             
wire            mcontrol3_exe1_match;              
wire            mcontrol3_exe1_may_hit;            
wire            mcontrol3_is_exe;                  
wire            mcontrol3_is_ldst;                 
wire            mcontrol3_is_ldst_addr;            
wire            mcontrol3_is_ldst_data;            
wire            mcontrol3_ldst_match;              
wire            mcontrol3_ldst_may_hit;            
wire    [1 :0]  mcontrol3_mtiming;                 
wire    [1 :0]  mcontrol3_mtiming_mask;            
wire    [1 :0]  mcontrol3_priority;                
wire    [1 :0]  mcontrol3_priority_mask;           
wire            mcontrol3_store_data_timing0;      
wire            mcontrol3_timing;                  
wire            mcontrol4_action0;                 
wire            mcontrol4_action1;                 
wire            mcontrol4_chain;                   
wire            mcontrol4_dmode;                   
wire            mcontrol4_exe0_cancel;             
wire            mcontrol4_exe0_match;              
wire            mcontrol4_exe0_may_hit;            
wire            mcontrol4_exe1_cancel;             
wire            mcontrol4_exe1_match;              
wire            mcontrol4_exe1_may_hit;            
wire            mcontrol4_is_exe;                  
wire            mcontrol4_is_ldst;                 
wire            mcontrol4_is_ldst_addr;            
wire            mcontrol4_is_ldst_data;            
wire            mcontrol4_ldst_match;              
wire            mcontrol4_ldst_may_hit;            
wire    [1 :0]  mcontrol4_mtiming;                 
wire    [1 :0]  mcontrol4_mtiming_mask;            
wire    [1 :0]  mcontrol4_priority;                
wire    [1 :0]  mcontrol4_priority_mask;           
wire            mcontrol4_store_data_timing0;      
wire            mcontrol4_timing;                  
wire            mcontrol5_action0;                 
wire            mcontrol5_action1;                 
wire            mcontrol5_chain;                   
wire            mcontrol5_dmode;                   
wire            mcontrol5_exe0_cancel;             
wire            mcontrol5_exe0_match;              
wire            mcontrol5_exe0_may_hit;            
wire            mcontrol5_exe1_cancel;             
wire            mcontrol5_exe1_match;              
wire            mcontrol5_exe1_may_hit;            
wire            mcontrol5_is_exe;                  
wire            mcontrol5_is_ldst;                 
wire            mcontrol5_is_ldst_addr;            
wire            mcontrol5_is_ldst_data;            
wire            mcontrol5_ldst_match;              
wire            mcontrol5_ldst_may_hit;            
wire    [1 :0]  mcontrol5_mtiming;                 
wire    [1 :0]  mcontrol5_mtiming_mask;            
wire    [1 :0]  mcontrol5_priority;                
wire    [1 :0]  mcontrol5_priority_mask;           
wire            mcontrol5_store_data_timing0;      
wire            mcontrol5_timing;                  
wire            mcontrol6_action0;                 
wire            mcontrol6_action1;                 
wire            mcontrol6_chain;                   
wire            mcontrol6_dmode;                   
wire            mcontrol6_exe0_cancel;             
wire            mcontrol6_exe0_match;              
wire            mcontrol6_exe0_may_hit;            
wire            mcontrol6_exe1_cancel;             
wire            mcontrol6_exe1_match;              
wire            mcontrol6_exe1_may_hit;            
wire            mcontrol6_is_exe;                  
wire            mcontrol6_is_ldst;                 
wire            mcontrol6_is_ldst_addr;            
wire            mcontrol6_is_ldst_data;            
wire            mcontrol6_ldst_match;              
wire            mcontrol6_ldst_may_hit;            
wire    [1 :0]  mcontrol6_mtiming;                 
wire    [1 :0]  mcontrol6_mtiming_mask;            
wire    [1 :0]  mcontrol6_priority;                
wire    [1 :0]  mcontrol6_priority_mask;           
wire            mcontrol6_store_data_timing0;      
wire            mcontrol6_timing;                  
wire            mcontrol7_action0;                 
wire            mcontrol7_action1;                 
wire            mcontrol7_chain;                   
wire            mcontrol7_dmode;                   
wire            mcontrol7_exe0_cancel;             
wire            mcontrol7_exe0_match;              
wire            mcontrol7_exe0_may_hit;            
wire            mcontrol7_exe1_cancel;             
wire            mcontrol7_exe1_match;              
wire            mcontrol7_exe1_may_hit;            
wire            mcontrol7_is_exe;                  
wire            mcontrol7_is_ldst;                 
wire            mcontrol7_is_ldst_addr;            
wire            mcontrol7_is_ldst_data;            
wire            mcontrol7_ldst_match;              
wire            mcontrol7_ldst_may_hit;            
wire    [1 :0]  mcontrol7_mtiming;                 
wire    [1 :0]  mcontrol7_mtiming_mask;            
wire    [1 :0]  mcontrol7_priority;                
wire    [1 :0]  mcontrol7_priority_mask;           
wire            mcontrol7_store_data_timing0;      
wire            mcontrol7_timing;                  
wire    [21:0]  mcontrol_halt_info0;               
wire    [21:0]  mcontrol_halt_info1;               
wire    [7 :0]  mcontrol_hit;                      
wire            mcontrol_output_clk;               
wire            mcontrol_output_clk_en;            
wire            need_match_store_data_t0_trigger;  
wire            pad_yy_icg_scan_en;                
wire            rtu_yy_xx_dbgon;                   
wire            s_mode;                            
wire    [63:0]  scontext;                          
wire            store_addr_vld;                    
wire            store_data_vld;                    
wire    [63:0]  tcontrol;                          
wire    [7 :0]  timing0_match;                     
wire    [9 :0]  tselect_wr_en;                     
wire            u_mode;                            
wire    [6 :0]  x_phigher_than_m0;                 
wire    [6 :0]  x_phigher_than_m1;                 
wire    [6 :0]  x_phigher_than_m2;                 
wire    [6 :0]  x_phigher_than_m3;                 
wire    [6 :0]  x_phigher_than_m4;                 
wire    [6 :0]  x_phigher_than_m5;                 
wire    [6 :0]  x_phigher_than_m6;                 
wire    [6 :0]  x_phigher_than_m7;                 
wire    [6 :0]  x_thigher_than_m0;                 
wire    [6 :0]  x_thigher_than_m1;                 
wire    [6 :0]  x_thigher_than_m2;                 
wire    [6 :0]  x_thigher_than_m3;                 
wire    [6 :0]  x_thigher_than_m4;                 
wire    [6 :0]  x_thigher_than_m5;                 
wire    [6 :0]  x_thigher_than_m6;                 
wire    [6 :0]  x_thigher_than_m7;                 


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;

// &Force("input","ifu_dtu_exe_addr0");&Force("bus","ifu_dtu_exe_addr0",39,0); @29
// &Force("input","ifu_dtu_exe_data0");&Force("bus","ifu_dtu_exe_data0",31,0); @30
// &Force("input","ifu_dtu_exe_addr1");&Force("bus","ifu_dtu_exe_addr1",39,0); @31
// &Force("input","ifu_dtu_exe_data1");&Force("bus","ifu_dtu_exe_data1",31,0); @32
// &Force("input","lsu_dtu_halt_info");&Force("bus","lsu_dtu_halt_info",`TDT_HINFO_WIDTH-1,0); @34
// &Force("input","lsu_dtu_ldst_addr");&Force("bus","lsu_dtu_ldst_addr",39,0); @35
// &Force("input","lsu_dtu_ldst_addr_vld"); @36
// &Force("input","lsu_dtu_ldst_bytes_vld");&Force("bus","lsu_dtu_ldst_bytes_vld",15,0); @37
// &Force("input","lsu_dtu_ldst_data");&Force("bus","lsu_dtu_ldst_data",63,0); @38
// &Force("input","lsu_dtu_ldst_data_vld"); @39
// &Force("input","lsu_dtu_ldst_type");&Force("bus","lsu_dtu_ldst_type",1,0); @40
// &Force("input","lsu_dtu_mem_access_size");&Force("bus","lsu_dtu_mem_access_size",2,0); @41
// &Force("input","lsu_dtu_last_check"); @42
// &Force("output","mcontrol_halt_info0");&Force("bus","mcontrol_halt_info0",`TDT_HINFO_WIDTH-1,0); @44
// &Force("output","mcontrol_halt_info1");&Force("bus","mcontrol_halt_info1",`TDT_HINFO_WIDTH-1,0); @45
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_0"); @126
// &Connect( @127
//          .trigger_selected        (tselect_wr_en[0]), @128
//          .set_trigger_hit         (mcontrol_hit[0]), @129
//          .already_match           (already_match[0]), @130
//          .previous_trigger_chian  (1'b0), @131
//          .previous_trigger_dmode  (1'b0), @132
//          .next_trigger_chain      (mcontrol1_chain), @133
//          .next_trigger_dmode      (mcontrol1_dmode), @134
//          .tdata1_chain            (mcontrol0_chain), @135
//          .tdata1_dmode            (mcontrol0_dmode), @136
//          .tdata1_action0          (mcontrol0_action0), @137
//          .tdata1_action1          (mcontrol0_action1),   @138
//          .tdata1_timing           (mcontrol0_timing), @139
//          .exe_mcontrol            (mcontrol0_is_exe),, @140
//          .ldst_mcontrol           (mcontrol0_is_ldst), @141
//          .ldst_addr_mcontrol      (mcontrol0_is_ldst_addr), @142
//          .ldst_data_mcontrol      (mcontrol0_is_ldst_data), @143
//          .mpriority               (mcontrol0_priority), @144
//          .mpriority_mask          (mcontrol0_priority_mask), @145
//          .mtiming                 (mcontrol0_mtiming), @146
//          .mtiming_mask            (mcontrol0_mtiming_mask), @147
//          .exe0_match              (mcontrol0_exe0_match), @148
//          .exe1_match              (mcontrol0_exe1_match), @149
//          .ldst_match              (mcontrol0_ldst_match), @150
//          .tdata1         (m0_tdata1), @151
//          .tdata2         (m0_tdata2), @152
//          .tdata3         (m0_tdata3), @153
//          .tinfo          (m0_tinfo), @154
//          //.tcontrol       (m0_tcontrol), @155
//          //.mcontext       (m0_mcontext), @156
//          //.scontext       (m0_scontext), @157
//          .ldst_may_hit   (mcontrol0_ldst_may_hit), @158
//          .exe0_may_hit    (mcontrol0_exe0_may_hit), @159
//          .exe1_may_hit    (mcontrol0_exe1_may_hit)); @160
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_1"); @162
// &Connect( @163
//          .trigger_selected        (tselect_wr_en[1]), @164
//          .set_trigger_hit         (mcontrol_hit[1]), @165
//          .already_match           (already_match[1]),     @166
//          .previous_trigger_chian  (mcontrol0_chain), @167
//          .previous_trigger_dmode  (mcontrol0_dmode), @168
//          .next_trigger_chain      (1'b1), @169
//          .next_trigger_dmode      (1'b0), @170
//          .tdata1_chain            (mcontrol1_chain), @171
//          .tdata1_dmode            (mcontrol1_dmode), @172
//          .tdata1_action0          (mcontrol1_action0), @173
//          .tdata1_action1          (mcontrol1_action1), @174
//          .tdata1_timing           (mcontrol1_timing), @175
//          .exe_mcontrol            (mcontrol1_is_exe),, @176
//          .ldst_mcontrol           (mcontrol1_is_ldst), @177
//          .ldst_addr_mcontrol      (mcontrol1_is_ldst_addr), @178
//          .ldst_data_mcontrol      (mcontrol1_is_ldst_data), @179
//          .mpriority               (mcontrol1_priority), @180
//          .mpriority_mask          (mcontrol1_priority_mask), @181
//          .mtiming                 (mcontrol1_mtiming), @182
//          .mtiming_mask            (mcontrol1_mtiming_mask), @183
//          .exe0_match              (mcontrol1_exe0_match), @184
//          .exe1_match              (mcontrol1_exe1_match), @185
//          .ldst_match              (mcontrol1_ldst_match), @186
//          .tdata1         (m1_tdata1), @187
//          .tdata2         (m1_tdata2), @188
//          .tdata3         (m1_tdata3), @189
//          .tinfo          (m1_tinfo), @190
//          //.tcontrol       (m1_tcontrol), @191
//          //.mcontext       (m1_mcontext), @192
//          //.scontext       (m1_scontext), @193
//          .ldst_may_hit   (mcontrol1_ldst_may_hit), @194
//          .exe0_may_hit    (mcontrol1_exe0_may_hit), @195
//          .exe1_may_hit    (mcontrol1_exe1_may_hit)); @196
// &Force("bus","tselect_wr_en",9,0); @198
// &Force("bus","lsu_dtu_halt_info",`TDT_HINFO_WIDTH-1,0); @250
// &CombBeg; @541
// &CombEnd; @548
// //&Force("nonport","ldst_chain"); @551
// &CombBeg; @568
// &CombEnd; @576

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_0"); @596
// &Connect( @597
//          .trigger_selected        (tselect_wr_en[0]), @598
//          .set_trigger_hit         (mcontrol_hit[0]), @599
//          .already_match           (already_match[0]), @600
//          .previous_trigger_chian  (1'b0), @601
//          .previous_trigger_dmode  (1'b0), @602
//          .next_trigger_chain      (mcontrol1_chain), @603
//          .next_trigger_dmode      (mcontrol1_dmode), @604
//          .tdata1_chain            (mcontrol0_chain), @605
//          .tdata1_dmode            (mcontrol0_dmode), @606
//          .tdata1_action0          (mcontrol0_action0), @607
//          .tdata1_action1          (mcontrol0_action1),   @608
//          .tdata1_timing           (mcontrol0_timing), @609
//          .exe_mcontrol            (mcontrol0_is_exe), @610
//          .ldst_mcontrol           (mcontrol0_is_ldst), @611
//          .ldst_addr_mcontrol      (mcontrol0_is_ldst_addr), @612
//          .ldst_data_mcontrol      (mcontrol0_is_ldst_data), @613
//          .mpriority               (mcontrol0_priority), @614
//          .mpriority_mask          (mcontrol0_priority_mask), @615
//          .mtiming                 (mcontrol0_mtiming), @616
//          .mtiming_mask            (mcontrol0_mtiming_mask), @617
//          .exe0_match              (mcontrol0_exe0_match), @618
//          .exe1_match              (mcontrol0_exe1_match), @619
//          .ldst_match              (mcontrol0_ldst_match), @620
//          .tdata1         (m0_tdata1), @621
//          .tdata2         (m0_tdata2), @622
//          .tdata3         (m0_tdata3), @623
//          .tinfo          (m0_tinfo), @624
//          //.tcontrol       (m0_tcontrol), @625
//          //.mcontext       (m0_mcontext), @626
//          //.scontext       (m0_scontext), @627
//          .ldst_may_hit   (mcontrol0_ldst_may_hit), @628
//          .exe0_may_hit    (mcontrol0_exe0_may_hit), @629
//          .exe1_may_hit    (mcontrol0_exe1_may_hit)); @630
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_1"); @632
// &Connect( @633
//          .trigger_selected        (tselect_wr_en[1]), @634
//          .set_trigger_hit         (mcontrol_hit[1]), @635
//          .already_match           (already_match[1]),     @636
//          .previous_trigger_chian  (mcontrol0_chain), @637
//          .previous_trigger_dmode  (mcontrol0_dmode), @638
//          .next_trigger_chain      (mcontrol2_chain), @639
//          .next_trigger_dmode      (mcontrol2_dmode), @640
//          .tdata1_chain            (mcontrol1_chain), @641
//          .tdata1_dmode            (mcontrol1_dmode), @642
//          .tdata1_action0          (mcontrol1_action0), @643
//          .tdata1_action1          (mcontrol1_action1), @644
//          .tdata1_timing           (mcontrol1_timing), @645
//          .exe_mcontrol            (mcontrol1_is_exe), @646
//          .ldst_mcontrol           (mcontrol1_is_ldst), @647
//          .ldst_addr_mcontrol      (mcontrol1_is_ldst_addr), @648
//          .ldst_data_mcontrol      (mcontrol1_is_ldst_data), @649
//          .mpriority               (mcontrol1_priority), @650
//          .mpriority_mask          (mcontrol1_priority_mask), @651
//          .mtiming                 (mcontrol1_mtiming), @652
//          .mtiming_mask            (mcontrol1_mtiming_mask), @653
//          .exe0_match              (mcontrol1_exe0_match), @654
//          .exe1_match              (mcontrol1_exe1_match), @655
//          .ldst_match              (mcontrol1_ldst_match), @656
//          .tdata1         (m1_tdata1), @657
//          .tdata2         (m1_tdata2), @658
//          .tdata3         (m1_tdata3), @659
//          .tinfo          (m1_tinfo), @660
//          //.tcontrol       (m1_tcontrol), @661
//          //.mcontext       (m1_mcontext), @662
//          //.scontext       (m1_scontext), @663
//          .ldst_may_hit   (mcontrol1_ldst_may_hit), @664
//          .exe0_may_hit    (mcontrol1_exe0_may_hit), @665
//          .exe1_may_hit    (mcontrol1_exe1_may_hit)); @666
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_2"); @668
// &Connect( @669
//          .trigger_selected        (tselect_wr_en[2]), @670
//          .set_trigger_hit         (mcontrol_hit[2]), @671
//          .already_match           (already_match[2]),     @672
//          .previous_trigger_chian  (mcontrol1_chain), @673
//          .previous_trigger_dmode  (mcontrol1_dmode), @674
//          .next_trigger_chain      (mcontrol3_chain), @675
//          .next_trigger_dmode      (mcontrol3_dmode), @676
//          .tdata1_chain            (mcontrol2_chain), @677
//          .tdata1_dmode            (mcontrol2_dmode), @678
//          .tdata1_action0          (mcontrol2_action0), @679
//          .tdata1_action1          (mcontrol2_action1), @680
//          .tdata1_timing           (mcontrol2_timing), @681
//          .exe_mcontrol            (mcontrol2_is_exe), @682
//          .ldst_mcontrol           (mcontrol2_is_ldst), @683
//          .ldst_addr_mcontrol      (mcontrol2_is_ldst_addr), @684
//          .ldst_data_mcontrol      (mcontrol2_is_ldst_data), @685
//          .mpriority               (mcontrol2_priority), @686
//          .mpriority_mask          (mcontrol2_priority_mask), @687
//          .mtiming                 (mcontrol2_mtiming), @688
//          .mtiming_mask            (mcontrol2_mtiming_mask), @689
//          .exe0_match              (mcontrol2_exe0_match), @690
//          .exe1_match              (mcontrol2_exe1_match), @691
//          .ldst_match              (mcontrol2_ldst_match), @692
//          .tdata1         (m2_tdata1), @693
//          .tdata2         (m2_tdata2), @694
//          .tdata3         (m2_tdata3), @695
//          .tinfo          (m2_tinfo), @696
//          //.tcontrol       (m2_tcontrol), @697
//          //.mcontext       (m2_mcontext), @698
//          //.scontext       (m2_scontext), @699
//          .ldst_may_hit   (mcontrol2_ldst_may_hit), @700
//          .exe0_may_hit    (mcontrol2_exe0_may_hit), @701
//          .exe1_may_hit    (mcontrol2_exe1_may_hit)); @702
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_3"); @704
// &Connect( @705
//          .trigger_selected        (tselect_wr_en[3]), @706
//          .set_trigger_hit         (mcontrol_hit[3]), @707
//          .already_match           (already_match[3]),     @708
//          .previous_trigger_chian  (mcontrol2_chain), @709
//          .previous_trigger_dmode  (mcontrol2_dmode), @710
//          .next_trigger_chain      (1'b1), @711
//          .next_trigger_dmode      (1'b0), @712
//          .tdata1_chain            (mcontrol3_chain), @713
//          .tdata1_dmode            (mcontrol3_dmode), @714
//          .tdata1_action0          (mcontrol3_action0), @715
//          .tdata1_action1          (mcontrol3_action1), @716
//          .tdata1_timing           (mcontrol3_timing), @717
//          .exe_mcontrol            (mcontrol3_is_exe), @718
//          .ldst_mcontrol           (mcontrol3_is_ldst), @719
//          .ldst_addr_mcontrol      (mcontrol3_is_ldst_addr), @720
//          .ldst_data_mcontrol      (mcontrol3_is_ldst_data), @721
//          .mpriority               (mcontrol3_priority), @722
//          .mpriority_mask          (mcontrol3_priority_mask), @723
//          .mtiming                 (mcontrol3_mtiming), @724
//          .mtiming_mask            (mcontrol3_mtiming_mask), @725
//          .exe0_match              (mcontrol3_exe0_match), @726
//          .exe1_match              (mcontrol3_exe1_match), @727
//          .ldst_match              (mcontrol3_ldst_match), @728
//          .tdata1         (m3_tdata1), @729
//          .tdata2         (m3_tdata2), @730
//          .tdata3         (m3_tdata3), @731
//          .tinfo          (m3_tinfo), @732
//          //.tcontrol       (m3_tcontrol), @733
//          //.mcontext       (m3_mcontext), @734
//          //.scontext       (m3_scontext), @735
//          .ldst_may_hit   (mcontrol3_ldst_may_hit), @736
//          .exe0_may_hit    (mcontrol3_exe0_may_hit), @737
//          .exe1_may_hit    (mcontrol3_exe1_may_hit)); @738
// &Force("bus","tselect_wr_en",9,0); @740
// &Force("bus","lsu_dtu_halt_info",`TDT_HINFO_WIDTH-1,0); @776
// &CombBeg; @845
// &CombEnd; @862
// &CombBeg; @863
// &CombEnd; @880
// &CombBeg; @893
// &CombEnd; @910
// &CombBeg; @912
// &CombEnd; @929
// &CombBeg; @1294
// &CombEnd; @1301
// //&Force("nonport","ldst_chain"); @1305
// &CombBeg; @1328
// &CombEnd; @1336

//=========================================================
//
//             mcontrol match judgment(8 mcontrol)     
//
//=========================================================
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_0"); @1356
aq_dtu_mcontrol  x_aq_dtu_mcontrol_0 (
  .already_match           (already_match[0]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol0_exe0_match   ),
  .exe0_may_hit            (mcontrol0_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol0_exe1_match   ),
  .exe1_may_hit            (mcontrol0_exe1_may_hit ),
  .exe_mcontrol            (mcontrol0_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol0_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol0_is_ldst_data ),
  .ldst_match              (mcontrol0_ldst_match   ),
  .ldst_may_hit            (mcontrol0_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol0_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol0_priority     ),
  .mpriority_mask          (mcontrol0_priority_mask),
  .mtiming                 (mcontrol0_mtiming      ),
  .mtiming_mask            (mcontrol0_mtiming_mask ),
  .next_trigger_chain      (mcontrol1_chain        ),
  .next_trigger_dmode      (mcontrol1_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (1'b0                   ),
  .previous_trigger_dmode  (1'b0                   ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[0]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m0_tdata1              ),
  .tdata1_action0          (mcontrol0_action0      ),
  .tdata1_action1          (mcontrol0_action1      ),
  .tdata1_chain            (mcontrol0_chain        ),
  .tdata1_dmode            (mcontrol0_dmode        ),
  .tdata1_timing           (mcontrol0_timing       ),
  .tdata2                  (m0_tdata2              ),
  .tdata3                  (m0_tdata3              ),
  .tinfo                   (m0_tinfo               ),
  .trigger_selected        (tselect_wr_en[0]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1357
//          .trigger_selected        (tselect_wr_en[0]), @1358
//          .set_trigger_hit         (mcontrol_hit[0]), @1359
//          .already_match           (already_match[0]), @1360
//          .previous_trigger_chian  (1'b0), @1361
//          .previous_trigger_dmode  (1'b0), @1362
//          .next_trigger_chain      (mcontrol1_chain), @1363
//          .next_trigger_dmode      (mcontrol1_dmode), @1364
//          .tdata1_chain            (mcontrol0_chain), @1365
//          .tdata1_dmode            (mcontrol0_dmode), @1366
//          .tdata1_action0          (mcontrol0_action0), @1367
//          .tdata1_action1          (mcontrol0_action1),   @1368
//          .tdata1_timing           (mcontrol0_timing), @1369
//          .exe_mcontrol            (mcontrol0_is_exe), @1370
//          .ldst_mcontrol           (mcontrol0_is_ldst), @1371
//          .ldst_addr_mcontrol      (mcontrol0_is_ldst_addr), @1372
//          .ldst_data_mcontrol      (mcontrol0_is_ldst_data), @1373
//          .mpriority               (mcontrol0_priority), @1374
//          .mpriority_mask          (mcontrol0_priority_mask), @1375
//          .mtiming                 (mcontrol0_mtiming), @1376
//          .mtiming_mask            (mcontrol0_mtiming_mask), @1377
//          .exe0_match              (mcontrol0_exe0_match), @1378
//          .exe1_match              (mcontrol0_exe1_match), @1379
//          .ldst_match              (mcontrol0_ldst_match), @1380
//          .tdata1         (m0_tdata1), @1381
//          .tdata2         (m0_tdata2), @1382
//          .tdata3         (m0_tdata3), @1383
//          .tinfo          (m0_tinfo), @1384
//          //.tcontrol       (m0_tcontrol), @1385
//          //.mcontext       (m0_mcontext), @1386
//          //.scontext       (m0_scontext), @1387
//          .ldst_may_hit    (mcontrol0_ldst_may_hit), @1388
//          .exe0_may_hit    (mcontrol0_exe0_may_hit), @1389
//          .exe1_may_hit    (mcontrol0_exe1_may_hit)); @1390

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_1"); @1392
aq_dtu_mcontrol  x_aq_dtu_mcontrol_1 (
  .already_match           (already_match[1]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol1_exe0_match   ),
  .exe0_may_hit            (mcontrol1_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol1_exe1_match   ),
  .exe1_may_hit            (mcontrol1_exe1_may_hit ),
  .exe_mcontrol            (mcontrol1_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol1_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol1_is_ldst_data ),
  .ldst_match              (mcontrol1_ldst_match   ),
  .ldst_may_hit            (mcontrol1_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol1_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol1_priority     ),
  .mpriority_mask          (mcontrol1_priority_mask),
  .mtiming                 (mcontrol1_mtiming      ),
  .mtiming_mask            (mcontrol1_mtiming_mask ),
  .next_trigger_chain      (mcontrol2_chain        ),
  .next_trigger_dmode      (mcontrol2_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol0_chain        ),
  .previous_trigger_dmode  (mcontrol0_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[1]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m1_tdata1              ),
  .tdata1_action0          (mcontrol1_action0      ),
  .tdata1_action1          (mcontrol1_action1      ),
  .tdata1_chain            (mcontrol1_chain        ),
  .tdata1_dmode            (mcontrol1_dmode        ),
  .tdata1_timing           (mcontrol1_timing       ),
  .tdata2                  (m1_tdata2              ),
  .tdata3                  (m1_tdata3              ),
  .tinfo                   (m1_tinfo               ),
  .trigger_selected        (tselect_wr_en[1]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1393
//          .trigger_selected        (tselect_wr_en[1]), @1394
//          .set_trigger_hit         (mcontrol_hit[1]), @1395
//          .already_match           (already_match[1]),     @1396
//          .previous_trigger_chian  (mcontrol0_chain), @1397
//          .previous_trigger_dmode  (mcontrol0_dmode), @1398
//          .next_trigger_chain      (mcontrol2_chain), @1399
//          .next_trigger_dmode      (mcontrol2_dmode), @1400
//          .tdata1_chain            (mcontrol1_chain), @1401
//          .tdata1_dmode            (mcontrol1_dmode), @1402
//          .tdata1_action0          (mcontrol1_action0), @1403
//          .tdata1_action1          (mcontrol1_action1), @1404
//          .tdata1_timing           (mcontrol1_timing), @1405
//          .exe_mcontrol            (mcontrol1_is_exe), @1406
//          .ldst_mcontrol           (mcontrol1_is_ldst), @1407
//          .ldst_addr_mcontrol      (mcontrol1_is_ldst_addr), @1408
//          .ldst_data_mcontrol      (mcontrol1_is_ldst_data), @1409
//          .mpriority               (mcontrol1_priority), @1410
//          .mpriority_mask          (mcontrol1_priority_mask), @1411
//          .mtiming                 (mcontrol1_mtiming), @1412
//          .mtiming_mask            (mcontrol1_mtiming_mask), @1413
//          .exe0_match              (mcontrol1_exe0_match), @1414
//          .exe1_match              (mcontrol1_exe1_match), @1415
//          .ldst_match              (mcontrol1_ldst_match), @1416
//          .tdata1         (m1_tdata1), @1417
//          .tdata2         (m1_tdata2), @1418
//          .tdata3         (m1_tdata3), @1419
//          .tinfo          (m1_tinfo), @1420
//          //.tcontrol       (m1_tcontrol), @1421
//          //.mcontext       (m1_mcontext), @1422
//          //.scontext       (m1_scontext), @1423
//          .ldst_may_hit   (mcontrol1_ldst_may_hit), @1424
//          .exe0_may_hit    (mcontrol1_exe0_may_hit), @1425
//          .exe1_may_hit    (mcontrol1_exe1_may_hit)); @1426

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_2"); @1428
aq_dtu_mcontrol  x_aq_dtu_mcontrol_2 (
  .already_match           (already_match[2]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol2_exe0_match   ),
  .exe0_may_hit            (mcontrol2_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol2_exe1_match   ),
  .exe1_may_hit            (mcontrol2_exe1_may_hit ),
  .exe_mcontrol            (mcontrol2_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol2_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol2_is_ldst_data ),
  .ldst_match              (mcontrol2_ldst_match   ),
  .ldst_may_hit            (mcontrol2_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol2_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol2_priority     ),
  .mpriority_mask          (mcontrol2_priority_mask),
  .mtiming                 (mcontrol2_mtiming      ),
  .mtiming_mask            (mcontrol2_mtiming_mask ),
  .next_trigger_chain      (mcontrol3_chain        ),
  .next_trigger_dmode      (mcontrol3_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol1_chain        ),
  .previous_trigger_dmode  (mcontrol1_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[2]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m2_tdata1              ),
  .tdata1_action0          (mcontrol2_action0      ),
  .tdata1_action1          (mcontrol2_action1      ),
  .tdata1_chain            (mcontrol2_chain        ),
  .tdata1_dmode            (mcontrol2_dmode        ),
  .tdata1_timing           (mcontrol2_timing       ),
  .tdata2                  (m2_tdata2              ),
  .tdata3                  (m2_tdata3              ),
  .tinfo                   (m2_tinfo               ),
  .trigger_selected        (tselect_wr_en[2]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1429
//          .trigger_selected        (tselect_wr_en[2]), @1430
//          .set_trigger_hit         (mcontrol_hit[2]), @1431
//          .already_match           (already_match[2]),     @1432
//          .previous_trigger_chian  (mcontrol1_chain), @1433
//          .previous_trigger_dmode  (mcontrol1_dmode), @1434
//          .next_trigger_chain      (mcontrol3_chain), @1435
//          .next_trigger_dmode      (mcontrol3_dmode), @1436
//          .tdata1_chain            (mcontrol2_chain), @1437
//          .tdata1_dmode            (mcontrol2_dmode), @1438
//          .tdata1_action0          (mcontrol2_action0), @1439
//          .tdata1_action1          (mcontrol2_action1), @1440
//          .tdata1_timing           (mcontrol2_timing), @1441
//          .exe_mcontrol            (mcontrol2_is_exe), @1442
//          .ldst_mcontrol           (mcontrol2_is_ldst), @1443
//          .ldst_addr_mcontrol      (mcontrol2_is_ldst_addr), @1444
//          .ldst_data_mcontrol      (mcontrol2_is_ldst_data), @1445
//          .mpriority               (mcontrol2_priority), @1446
//          .mpriority_mask          (mcontrol2_priority_mask), @1447
//          .mtiming                 (mcontrol2_mtiming), @1448
//          .mtiming_mask            (mcontrol2_mtiming_mask), @1449
//          .exe0_match              (mcontrol2_exe0_match), @1450
//          .exe1_match              (mcontrol2_exe1_match), @1451
//          .ldst_match              (mcontrol2_ldst_match), @1452
//          .tdata1         (m2_tdata1), @1453
//          .tdata2         (m2_tdata2), @1454
//          .tdata3         (m2_tdata3), @1455
//          .tinfo          (m2_tinfo), @1456
//          //.tcontrol       (m2_tcontrol), @1457
//          //.mcontext       (m2_mcontext), @1458
//          //.scontext       (m2_scontext), @1459
//          .ldst_may_hit   (mcontrol2_ldst_may_hit), @1460
//          .exe0_may_hit    (mcontrol2_exe0_may_hit), @1461
//          .exe1_may_hit    (mcontrol2_exe1_may_hit)); @1462

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_3"); @1464
aq_dtu_mcontrol  x_aq_dtu_mcontrol_3 (
  .already_match           (already_match[3]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol3_exe0_match   ),
  .exe0_may_hit            (mcontrol3_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol3_exe1_match   ),
  .exe1_may_hit            (mcontrol3_exe1_may_hit ),
  .exe_mcontrol            (mcontrol3_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol3_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol3_is_ldst_data ),
  .ldst_match              (mcontrol3_ldst_match   ),
  .ldst_may_hit            (mcontrol3_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol3_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol3_priority     ),
  .mpriority_mask          (mcontrol3_priority_mask),
  .mtiming                 (mcontrol3_mtiming      ),
  .mtiming_mask            (mcontrol3_mtiming_mask ),
  .next_trigger_chain      (mcontrol4_chain        ),
  .next_trigger_dmode      (mcontrol4_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol2_chain        ),
  .previous_trigger_dmode  (mcontrol2_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[3]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m3_tdata1              ),
  .tdata1_action0          (mcontrol3_action0      ),
  .tdata1_action1          (mcontrol3_action1      ),
  .tdata1_chain            (mcontrol3_chain        ),
  .tdata1_dmode            (mcontrol3_dmode        ),
  .tdata1_timing           (mcontrol3_timing       ),
  .tdata2                  (m3_tdata2              ),
  .tdata3                  (m3_tdata3              ),
  .tinfo                   (m3_tinfo               ),
  .trigger_selected        (tselect_wr_en[3]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1465
//          .trigger_selected        (tselect_wr_en[3]), @1466
//          .set_trigger_hit         (mcontrol_hit[3]), @1467
//          .already_match           (already_match[3]),     @1468
//          .previous_trigger_chian  (mcontrol2_chain), @1469
//          .previous_trigger_dmode  (mcontrol2_dmode), @1470
//          .next_trigger_chain      (mcontrol4_chain), @1471
//          .next_trigger_dmode      (mcontrol4_dmode), @1472
//          .tdata1_chain            (mcontrol3_chain), @1473
//          .tdata1_dmode            (mcontrol3_dmode), @1474
//          .tdata1_action0          (mcontrol3_action0), @1475
//          .tdata1_action1          (mcontrol3_action1), @1476
//          .tdata1_timing           (mcontrol3_timing), @1477
//          .exe_mcontrol            (mcontrol3_is_exe), @1478
//          .ldst_mcontrol           (mcontrol3_is_ldst), @1479
//          .ldst_addr_mcontrol      (mcontrol3_is_ldst_addr), @1480
//          .ldst_data_mcontrol      (mcontrol3_is_ldst_data), @1481
//          .mpriority               (mcontrol3_priority), @1482
//          .mpriority_mask          (mcontrol3_priority_mask), @1483
//          .mtiming                 (mcontrol3_mtiming), @1484
//          .mtiming_mask            (mcontrol3_mtiming_mask), @1485
//          .exe0_match              (mcontrol3_exe0_match), @1486
//          .exe1_match              (mcontrol3_exe1_match), @1487
//          .ldst_match              (mcontrol3_ldst_match), @1488
//          .tdata1         (m3_tdata1), @1489
//          .tdata2         (m3_tdata2), @1490
//          .tdata3         (m3_tdata3), @1491
//          .tinfo          (m3_tinfo), @1492
//          //.tcontrol       (m3_tcontrol), @1493
//          //.mcontext       (m3_mcontext), @1494
//          //.scontext       (m3_scontext), @1495
//          .ldst_may_hit   (mcontrol3_ldst_may_hit), @1496
//          .exe0_may_hit    (mcontrol3_exe0_may_hit), @1497
//          .exe1_may_hit    (mcontrol3_exe1_may_hit)); @1498

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_4"); @1500
aq_dtu_mcontrol  x_aq_dtu_mcontrol_4 (
  .already_match           (already_match[4]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol4_exe0_match   ),
  .exe0_may_hit            (mcontrol4_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol4_exe1_match   ),
  .exe1_may_hit            (mcontrol4_exe1_may_hit ),
  .exe_mcontrol            (mcontrol4_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol4_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol4_is_ldst_data ),
  .ldst_match              (mcontrol4_ldst_match   ),
  .ldst_may_hit            (mcontrol4_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol4_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol4_priority     ),
  .mpriority_mask          (mcontrol4_priority_mask),
  .mtiming                 (mcontrol4_mtiming      ),
  .mtiming_mask            (mcontrol4_mtiming_mask ),
  .next_trigger_chain      (mcontrol5_chain        ),
  .next_trigger_dmode      (mcontrol5_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol3_chain        ),
  .previous_trigger_dmode  (mcontrol3_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[4]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m4_tdata1              ),
  .tdata1_action0          (mcontrol4_action0      ),
  .tdata1_action1          (mcontrol4_action1      ),
  .tdata1_chain            (mcontrol4_chain        ),
  .tdata1_dmode            (mcontrol4_dmode        ),
  .tdata1_timing           (mcontrol4_timing       ),
  .tdata2                  (m4_tdata2              ),
  .tdata3                  (m4_tdata3              ),
  .tinfo                   (m4_tinfo               ),
  .trigger_selected        (tselect_wr_en[4]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1501
//          .trigger_selected        (tselect_wr_en[4]), @1502
//          .set_trigger_hit         (mcontrol_hit[4]), @1503
//          .already_match           (already_match[4]),     @1504
//          .previous_trigger_chian  (mcontrol3_chain), @1505
//          .previous_trigger_dmode  (mcontrol3_dmode), @1506
//          .next_trigger_chain      (mcontrol5_chain), @1507
//          .next_trigger_dmode      (mcontrol5_dmode), @1508
//          .tdata1_chain            (mcontrol4_chain), @1509
//          .tdata1_dmode            (mcontrol4_dmode), @1510
//          .tdata1_action0          (mcontrol4_action0), @1511
//          .tdata1_action1          (mcontrol4_action1), @1512
//          .tdata1_timing           (mcontrol4_timing), @1513
//          .exe_mcontrol            (mcontrol4_is_exe), @1514
//          .ldst_mcontrol           (mcontrol4_is_ldst), @1515
//          .ldst_addr_mcontrol      (mcontrol4_is_ldst_addr), @1516
//          .ldst_data_mcontrol      (mcontrol4_is_ldst_data), @1517
//          .mpriority               (mcontrol4_priority), @1518
//          .mpriority_mask          (mcontrol4_priority_mask), @1519
//          .mtiming                 (mcontrol4_mtiming), @1520
//          .mtiming_mask            (mcontrol4_mtiming_mask), @1521
//          .exe0_match              (mcontrol4_exe0_match), @1522
//          .exe1_match              (mcontrol4_exe1_match), @1523
//          .ldst_match              (mcontrol4_ldst_match), @1524
//          .tdata1         (m4_tdata1), @1525
//          .tdata2         (m4_tdata2), @1526
//          .tdata3         (m4_tdata3), @1527
//          .tinfo          (m4_tinfo), @1528
//          //.tcontrol       (m4_tcontrol), @1529
//          //.mcontext       (m4_mcontext), @1530
//          //.scontext       (m4_scontext), @1531
//          .ldst_may_hit   (mcontrol4_ldst_may_hit), @1532
//          .exe0_may_hit    (mcontrol4_exe0_may_hit), @1533
//          .exe1_may_hit    (mcontrol4_exe1_may_hit)); @1534

// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_5"); @1536
aq_dtu_mcontrol  x_aq_dtu_mcontrol_5 (
  .already_match           (already_match[5]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol5_exe0_match   ),
  .exe0_may_hit            (mcontrol5_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol5_exe1_match   ),
  .exe1_may_hit            (mcontrol5_exe1_may_hit ),
  .exe_mcontrol            (mcontrol5_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol5_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol5_is_ldst_data ),
  .ldst_match              (mcontrol5_ldst_match   ),
  .ldst_may_hit            (mcontrol5_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol5_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol5_priority     ),
  .mpriority_mask          (mcontrol5_priority_mask),
  .mtiming                 (mcontrol5_mtiming      ),
  .mtiming_mask            (mcontrol5_mtiming_mask ),
  .next_trigger_chain      (mcontrol6_chain        ),
  .next_trigger_dmode      (mcontrol6_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol4_chain        ),
  .previous_trigger_dmode  (mcontrol4_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[5]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m5_tdata1              ),
  .tdata1_action0          (mcontrol5_action0      ),
  .tdata1_action1          (mcontrol5_action1      ),
  .tdata1_chain            (mcontrol5_chain        ),
  .tdata1_dmode            (mcontrol5_dmode        ),
  .tdata1_timing           (mcontrol5_timing       ),
  .tdata2                  (m5_tdata2              ),
  .tdata3                  (m5_tdata3              ),
  .tinfo                   (m5_tinfo               ),
  .trigger_selected        (tselect_wr_en[5]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1537
//          .trigger_selected        (tselect_wr_en[5]), @1538
//          .set_trigger_hit         (mcontrol_hit[5]), @1539
//          .already_match           (already_match[5]),     @1540
//          .previous_trigger_chian  (mcontrol4_chain), @1541
//          .previous_trigger_dmode  (mcontrol4_dmode), @1542
//          .next_trigger_chain      (mcontrol6_chain), @1543
//          .next_trigger_dmode      (mcontrol6_dmode), @1544
//          .tdata1_chain            (mcontrol5_chain), @1545
//          .tdata1_dmode            (mcontrol5_dmode), @1546
//          .tdata1_action0          (mcontrol5_action0), @1547
//          .tdata1_action1          (mcontrol5_action1), @1548
//          .tdata1_timing           (mcontrol5_timing), @1549
//          .exe_mcontrol            (mcontrol5_is_exe), @1550
//          .ldst_mcontrol           (mcontrol5_is_ldst), @1551
//          .ldst_addr_mcontrol      (mcontrol5_is_ldst_addr), @1552
//          .ldst_data_mcontrol      (mcontrol5_is_ldst_data), @1553
//          .mpriority               (mcontrol5_priority), @1554
//          .mpriority_mask          (mcontrol5_priority_mask), @1555
//          .mtiming                 (mcontrol5_mtiming), @1556
//          .mtiming_mask            (mcontrol5_mtiming_mask), @1557
//          .exe0_match              (mcontrol5_exe0_match), @1558
//          .exe1_match              (mcontrol5_exe1_match), @1559
//          .ldst_match              (mcontrol5_ldst_match), @1560
//          .tdata1         (m5_tdata1), @1561
//          .tdata2         (m5_tdata2), @1562
//          .tdata3         (m5_tdata3), @1563
//          .tinfo          (m5_tinfo), @1564
//          //.tcontrol       (m5_tcontrol), @1565
//          //.mcontext       (m5_mcontext), @1566
//          //.scontext       (m5_scontext), @1567
//          .ldst_may_hit   (mcontrol5_ldst_may_hit), @1568
//          .exe0_may_hit    (mcontrol5_exe0_may_hit), @1569
//          .exe1_may_hit    (mcontrol5_exe1_may_hit)); @1570
    
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_6"); @1572
aq_dtu_mcontrol  x_aq_dtu_mcontrol_6 (
  .already_match           (already_match[6]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol6_exe0_match   ),
  .exe0_may_hit            (mcontrol6_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol6_exe1_match   ),
  .exe1_may_hit            (mcontrol6_exe1_may_hit ),
  .exe_mcontrol            (mcontrol6_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol6_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol6_is_ldst_data ),
  .ldst_match              (mcontrol6_ldst_match   ),
  .ldst_may_hit            (mcontrol6_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol6_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol6_priority     ),
  .mpriority_mask          (mcontrol6_priority_mask),
  .mtiming                 (mcontrol6_mtiming      ),
  .mtiming_mask            (mcontrol6_mtiming_mask ),
  .next_trigger_chain      (mcontrol7_chain        ),
  .next_trigger_dmode      (mcontrol7_dmode        ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol5_chain        ),
  .previous_trigger_dmode  (mcontrol5_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[6]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m6_tdata1              ),
  .tdata1_action0          (mcontrol6_action0      ),
  .tdata1_action1          (mcontrol6_action1      ),
  .tdata1_chain            (mcontrol6_chain        ),
  .tdata1_dmode            (mcontrol6_dmode        ),
  .tdata1_timing           (mcontrol6_timing       ),
  .tdata2                  (m6_tdata2              ),
  .tdata3                  (m6_tdata3              ),
  .tinfo                   (m6_tinfo               ),
  .trigger_selected        (tselect_wr_en[6]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1573
//          .trigger_selected        (tselect_wr_en[6]), @1574
//          .set_trigger_hit         (mcontrol_hit[6]), @1575
//          .already_match           (already_match[6]),     @1576
//          .previous_trigger_chian  (mcontrol5_chain), @1577
//          .previous_trigger_dmode  (mcontrol5_dmode), @1578
//          .next_trigger_chain      (mcontrol7_chain), @1579
//          .next_trigger_dmode      (mcontrol7_dmode), @1580
//          .tdata1_chain            (mcontrol6_chain), @1581
//          .tdata1_dmode            (mcontrol6_dmode), @1582
//          .tdata1_action0          (mcontrol6_action0), @1583
//          .tdata1_action1          (mcontrol6_action1), @1584
//          .tdata1_timing           (mcontrol6_timing), @1585
//          .exe_mcontrol            (mcontrol6_is_exe), @1586
//          .ldst_mcontrol           (mcontrol6_is_ldst), @1587
//          .ldst_addr_mcontrol      (mcontrol6_is_ldst_addr), @1588
//          .ldst_data_mcontrol      (mcontrol6_is_ldst_data), @1589
//          .mpriority               (mcontrol6_priority), @1590
//          .mpriority_mask          (mcontrol6_priority_mask), @1591
//          .mtiming                 (mcontrol6_mtiming), @1592
//          .mtiming_mask            (mcontrol6_mtiming_mask), @1593
//          .exe0_match              (mcontrol6_exe0_match), @1594
//          .exe1_match              (mcontrol6_exe1_match), @1595
//          .ldst_match              (mcontrol6_ldst_match), @1596
//          .tdata1         (m6_tdata1), @1597
//          .tdata2         (m6_tdata2), @1598
//          .tdata3         (m6_tdata3), @1599
//          .tinfo          (m6_tinfo), @1600
//          //.tcontrol       (m6_tcontrol), @1601
//          //.mcontext       (m6_mcontext), @1602
//          //.scontext       (m6_scontext), @1603
//          .ldst_may_hit   (mcontrol6_ldst_may_hit), @1604
//          .exe0_may_hit    (mcontrol6_exe0_may_hit), @1605
//          .exe1_may_hit    (mcontrol6_exe1_may_hit)); @1606
    
// &Instance("aq_dtu_mcontrol","x_aq_dtu_mcontrol_7"); @1608
aq_dtu_mcontrol  x_aq_dtu_mcontrol_7 (
  .already_match           (already_match[7]       ),
  .cp0_dtu_icg_en          (cp0_dtu_icg_en         ),
  .cp0_dtu_satp            (cp0_dtu_satp           ),
  .cp0_dtu_wdata           (cp0_dtu_wdata          ),
  .cp0_write_tdata1        (cp0_write_tdata1       ),
  .cp0_write_tdata2        (cp0_write_tdata2       ),
  .cp0_write_tdata3        (cp0_write_tdata3       ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .exe0_16bit              (exe0_16bit             ),
  .exe0_32bit              (exe0_32bit             ),
  .exe0_match              (mcontrol7_exe0_match   ),
  .exe0_may_hit            (mcontrol7_exe0_may_hit ),
  .exe1_16bit              (exe1_16bit             ),
  .exe1_32bit              (exe1_32bit             ),
  .exe1_match              (mcontrol7_exe1_match   ),
  .exe1_may_hit            (mcontrol7_exe1_may_hit ),
  .exe_mcontrol            (mcontrol7_is_exe       ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_dtu_addr_vld0       (ifu_dtu_addr_vld0      ),
  .ifu_dtu_addr_vld1       (ifu_dtu_addr_vld1      ),
  .ifu_dtu_data_vld0       (ifu_dtu_data_vld0      ),
  .ifu_dtu_data_vld1       (ifu_dtu_data_vld1      ),
  .ifu_dtu_exe_addr0       (ifu_dtu_exe_addr0      ),
  .ifu_dtu_exe_addr1       (ifu_dtu_exe_addr1      ),
  .ifu_dtu_exe_data0       (ifu_dtu_exe_data0      ),
  .ifu_dtu_exe_data1       (ifu_dtu_exe_data1      ),
  .ldst_128bit             (ldst_128bit            ),
  .ldst_16bit              (ldst_16bit             ),
  .ldst_32bit              (ldst_32bit             ),
  .ldst_64bit              (ldst_64bit             ),
  .ldst_8bit               (ldst_8bit              ),
  .ldst_addr_mcontrol      (mcontrol7_is_ldst_addr ),
  .ldst_data_mcontrol      (mcontrol7_is_ldst_data ),
  .ldst_match              (mcontrol7_ldst_match   ),
  .ldst_may_hit            (mcontrol7_ldst_may_hit ),
  .ldst_mcontrol           (mcontrol7_is_ldst      ),
  .load_addr_vld           (load_addr_vld          ),
  .load_data_vld           (load_data_vld          ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .m_mode                  (m_mode                 ),
  .mcontext                (mcontext               ),
  .mpriority               (mcontrol7_priority     ),
  .mpriority_mask          (mcontrol7_priority_mask),
  .mtiming                 (mcontrol7_mtiming      ),
  .mtiming_mask            (mcontrol7_mtiming_mask ),
  .next_trigger_chain      (1'b1                   ),
  .next_trigger_dmode      (1'b0                   ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .previous_trigger_chian  (mcontrol6_chain        ),
  .previous_trigger_dmode  (mcontrol6_dmode        ),
  .rtu_yy_xx_dbgon         (rtu_yy_xx_dbgon        ),
  .s_mode                  (s_mode                 ),
  .scontext                (scontext               ),
  .set_trigger_hit         (mcontrol_hit[7]        ),
  .store_addr_vld          (store_addr_vld         ),
  .store_data_vld          (store_data_vld         ),
  .tcontrol                (tcontrol               ),
  .tdata1                  (m7_tdata1              ),
  .tdata1_action0          (mcontrol7_action0      ),
  .tdata1_action1          (mcontrol7_action1      ),
  .tdata1_chain            (mcontrol7_chain        ),
  .tdata1_dmode            (mcontrol7_dmode        ),
  .tdata1_timing           (mcontrol7_timing       ),
  .tdata2                  (m7_tdata2              ),
  .tdata3                  (m7_tdata3              ),
  .tinfo                   (m7_tinfo               ),
  .trigger_selected        (tselect_wr_en[7]       ),
  .u_mode                  (u_mode                 )
);

// &Connect( @1609
//          .trigger_selected        (tselect_wr_en[7]), @1610
//          .set_trigger_hit         (mcontrol_hit[7]), @1611
//          .already_match           (already_match[7]),     @1612
//          .previous_trigger_chian  (mcontrol6_chain), @1613
//          .previous_trigger_dmode  (mcontrol6_dmode), @1614
//          .next_trigger_chain      (1'b1), @1615
//          .next_trigger_dmode      (1'b0), @1616
//          .tdata1_chain            (mcontrol7_chain), @1617
//          .tdata1_dmode            (mcontrol7_dmode), @1618
//          .tdata1_action0          (mcontrol7_action0), @1619
//          .tdata1_action1          (mcontrol7_action1), @1620
//          .tdata1_timing           (mcontrol7_timing), @1621
//          .exe_mcontrol            (mcontrol7_is_exe), @1622
//          .ldst_mcontrol           (mcontrol7_is_ldst), @1623
//          .ldst_addr_mcontrol      (mcontrol7_is_ldst_addr), @1624
//          .ldst_data_mcontrol      (mcontrol7_is_ldst_data), @1625
//          .mpriority               (mcontrol7_priority), @1626
//          .mpriority_mask          (mcontrol7_priority_mask), @1627
//          .mtiming                 (mcontrol7_mtiming), @1628
//          .mtiming_mask            (mcontrol7_mtiming_mask), @1629
//          .exe0_match              (mcontrol7_exe0_match), @1630
//          .exe1_match              (mcontrol7_exe1_match), @1631
//          .ldst_match              (mcontrol7_ldst_match), @1632
//          .tdata1         (m7_tdata1), @1633
//          .tdata2         (m7_tdata2), @1634
//          .tdata3         (m7_tdata3), @1635
//          .tinfo          (m7_tinfo), @1636
//          //.tcontrol       (m7_tcontrol), @1637
//          //.mcontext       (m7_mcontext), @1638
//          //.scontext       (m7_scontext), @1639
//          .ldst_may_hit   (mcontrol7_ldst_may_hit), @1640
//          .exe0_may_hit    (mcontrol7_exe0_may_hit), @1641
//          .exe1_may_hit    (mcontrol7_exe1_may_hit)); @1642
    
// &Force("bus","tselect_wr_en",9,0); @1644
//---------------------------------------------------------
//                    generate information
//---------------------------------------------------------
// &Force("bus","lsu_dtu_halt_info",`TDT_HINFO_WIDTH-1,0); @1648
assign already_match[7:0] = lsu_dtu_halt_info[`TDT_HINFO_TRIGGER:`TDT_HINFO_TRIGGER-7];
assign action0_mcontrol[`TDT_TM_MCONTROL_TRI_NUM-1:0] = {mcontrol7_action0,mcontrol6_action0,
                                                         mcontrol5_action0,mcontrol4_action0,
                                                         mcontrol3_action0,mcontrol2_action0,
                                                         mcontrol1_action0,mcontrol0_action0};//output
assign action1_mcontrol[`TDT_TM_MCONTROL_TRI_NUM-1:0] = {mcontrol7_action1,mcontrol6_action1,
                                                         mcontrol5_action1,mcontrol4_action1,
                                                         mcontrol3_action1,mcontrol2_action1,
                                                         mcontrol1_action1,mcontrol0_action1};
assign ldst_addr_mcontrol = mcontrol0_is_ldst_addr || mcontrol1_is_ldst_addr || mcontrol2_is_ldst_addr || mcontrol3_is_ldst_addr ||
                            mcontrol4_is_ldst_addr || mcontrol5_is_ldst_addr || mcontrol6_is_ldst_addr || mcontrol7_is_ldst_addr;
assign ldst_data_mcontrol = mcontrol0_is_ldst_data || mcontrol1_is_ldst_data || mcontrol2_is_ldst_data || mcontrol3_is_ldst_data ||
                            mcontrol4_is_ldst_data || mcontrol5_is_ldst_data || mcontrol6_is_ldst_data || mcontrol7_is_ldst_data;
assign exe0_may_hit       = mcontrol0_exe0_may_hit || mcontrol1_exe0_may_hit || mcontrol2_exe0_may_hit || mcontrol3_exe0_may_hit ||
                            mcontrol4_exe0_may_hit || mcontrol5_exe0_may_hit || mcontrol6_exe0_may_hit || mcontrol7_exe0_may_hit;
assign exe1_may_hit       = mcontrol0_exe1_may_hit || mcontrol1_exe1_may_hit || mcontrol2_exe1_may_hit || mcontrol3_exe1_may_hit ||
                            mcontrol4_exe1_may_hit || mcontrol5_exe1_may_hit || mcontrol6_exe1_may_hit || mcontrol7_exe1_may_hit;
assign exe_may_hit        = exe0_may_hit && ifu_dtu_addr_vld0 || exe1_may_hit && ifu_dtu_addr_vld1;  
assign ldst_may_hit       = mcontrol0_ldst_may_hit || mcontrol1_ldst_may_hit || mcontrol2_ldst_may_hit || mcontrol3_ldst_may_hit ||
                            mcontrol4_ldst_may_hit || mcontrol5_ldst_may_hit || mcontrol6_ldst_may_hit || mcontrol7_ldst_may_hit;

//assign exe_clcye1_hit_vld_need_reg =  exe0_may_hit && (ifu_dtu_addr_vld0 || ifu_dtu_data_vld0) ||
//                                      exe1_may_hit && (ifu_dtu_addr_vld1 || ifu_dtu_data_vld1);
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
    if(!cpurst_b)
      exe_cycle2_cannot_hit <= 1'b0;
    else if(exe_cycle2_cannot_hit)
      exe_cycle2_cannot_hit <= 1'b0;
    else if(exe_may_hit)
      exe_cycle2_cannot_hit <= 1'b1;
end
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
    if(!cpurst_b)
      ldst_cycle2_cannot_hit <= 1'b0;
    else if(ldst_cycle2_cannot_hit)
      ldst_cycle2_cannot_hit <= 1'b0;
    else if(ldst_may_hit)
      ldst_cycle2_cannot_hit <= 1'b1;
end

assign dtu_ifu_halt_info_vld     = exe_cycle2_cannot_hit || !exe_may_hit;
assign dtu_lsu_halt_info_vld     = ldst_cycle2_cannot_hit || !ldst_may_hit;
//----------------------chain info-------------------------
assign chain0_on        = mcontrol0_chain;
assign chain1_on        = mcontrol1_chain;
assign chain2_on        = mcontrol2_chain;
assign chain3_on        = mcontrol3_chain;
assign chain4_on        = mcontrol4_chain;
assign chain5_on        = mcontrol5_chain;
assign chain6_on        = mcontrol6_chain;

assign m01_is_exe_chain = chain0_on && mcontrol0_is_exe && mcontrol1_is_exe;
assign m12_is_exe_chain = chain1_on && mcontrol1_is_exe && mcontrol2_is_exe;
assign m23_is_exe_chain = chain2_on && mcontrol2_is_exe && mcontrol3_is_exe;
assign m34_is_exe_chain = chain3_on && mcontrol3_is_exe && mcontrol4_is_exe;
assign m45_is_exe_chain = chain4_on && mcontrol4_is_exe && mcontrol5_is_exe;
assign m56_is_exe_chain = chain5_on && mcontrol5_is_exe && mcontrol6_is_exe;
assign m67_is_exe_chain = chain6_on && mcontrol6_is_exe && mcontrol7_is_exe;

assign chain0_exe_ldst = chain0_on && (mcontrol0_is_exe && mcontrol1_is_ldst || mcontrol1_is_exe && mcontrol0_is_ldst);
assign chain1_exe_ldst = chain1_on && (mcontrol1_is_exe && mcontrol2_is_ldst || mcontrol2_is_exe && mcontrol1_is_ldst);
assign chain2_exe_ldst = chain2_on && (mcontrol2_is_exe && mcontrol3_is_ldst || mcontrol3_is_exe && mcontrol2_is_ldst);
assign chain3_exe_ldst = chain3_on && (mcontrol3_is_exe && mcontrol4_is_ldst || mcontrol4_is_exe && mcontrol3_is_ldst);
assign chain4_exe_ldst = chain4_on && (mcontrol4_is_exe && mcontrol5_is_ldst || mcontrol5_is_exe && mcontrol4_is_ldst);
assign chain5_exe_ldst = chain5_on && (mcontrol5_is_exe && mcontrol6_is_ldst || mcontrol6_is_exe && mcontrol5_is_ldst);
assign chain6_exe_ldst = chain6_on && (mcontrol6_is_exe && mcontrol7_is_ldst || mcontrol7_is_exe && mcontrol6_is_ldst);

assign chain0_same_timing = mcontrol0_timing == mcontrol1_timing || chain0_exe_ldst;
assign chain1_same_timing = mcontrol1_timing == mcontrol2_timing || chain1_exe_ldst;
assign chain2_same_timing = mcontrol2_timing == mcontrol3_timing || chain2_exe_ldst;
assign chain3_same_timing = mcontrol3_timing == mcontrol4_timing || chain3_exe_ldst;
assign chain4_same_timing = mcontrol4_timing == mcontrol5_timing || chain4_exe_ldst;
assign chain5_same_timing = mcontrol5_timing == mcontrol6_timing || chain5_exe_ldst;
assign chain6_same_timing = mcontrol6_timing == mcontrol7_timing || chain6_exe_ldst;
//modify the chain value of exe+ld/st trigger
assign m0_exe_chain_modify   = chain0_exe_ldst;
assign m1_exe_chain_modify   = chain0_exe_ldst || chain1_exe_ldst;
assign m2_exe_chain_modify   = chain1_exe_ldst || chain2_exe_ldst;
assign m3_exe_chain_modify   = chain2_exe_ldst || chain3_exe_ldst;
assign m4_exe_chain_modify   = chain3_exe_ldst || chain4_exe_ldst;
assign m5_exe_chain_modify   = chain4_exe_ldst || chain5_exe_ldst;
assign m6_exe_chain_modify   = chain5_exe_ldst || chain6_exe_ldst;
assign m7_exe_chain_modify   = chain6_exe_ldst;
//--------------------priority info-----------------------
//chain detect
//chain priority
assign m1_phigher_than_m0_no_chain = |(mcontrol0_priority_mask[1:0] & mcontrol1_priority[1:0]);
assign m2_phigher_than_m1_no_chain = |(mcontrol1_priority_mask[1:0] & mcontrol2_priority[1:0]);
assign m3_phigher_than_m2_no_chain = |(mcontrol2_priority_mask[1:0] & mcontrol3_priority[1:0]);
assign m4_phigher_than_m3_no_chain = |(mcontrol3_priority_mask[1:0] & mcontrol4_priority[1:0]);
assign m5_phigher_than_m4_no_chain = |(mcontrol4_priority_mask[1:0] & mcontrol5_priority[1:0]);
assign m6_phigher_than_m5_no_chain = |(mcontrol5_priority_mask[1:0] & mcontrol6_priority[1:0]);
assign m7_phigher_than_m6_no_chain = |(mcontrol6_priority_mask[1:0] & mcontrol7_priority[1:0]);

assign m0_priority[1:0]      = chain0_on && !m1_phigher_than_m0_no_chain ? //m0_priority
                               mcontrol1_priority[1:0] : mcontrol0_priority[1:0];
assign m0_priority_mask[1:0] = chain0_on && !m1_phigher_than_m0_no_chain ?
                               mcontrol1_priority_mask[1:0]: mcontrol0_priority_mask[1:0];
// &CombBeg; @1749
always @( mcontrol2_priority[1:0]
       or mcontrol0_priority_mask[1:0]
       or m2_phigher_than_m1_no_chain
       or mcontrol1_priority_mask[1:0]
       or mcontrol1_priority[1:0]
       or mcontrol0_priority[1:0]
       or chain0_on
       or m1_phigher_than_m0_no_chain
       or mcontrol2_priority_mask[1:0]
       or chain1_on)
begin
  //m1_priority
  if(chain0_on && m1_phigher_than_m0_no_chain)
    begin
      m1_priority[1:0]     = mcontrol0_priority[1:0];
      m1_priority_mask[1:0]= mcontrol0_priority_mask[1:0];
    end
  else if(chain1_on && !m2_phigher_than_m1_no_chain)
    begin
      m1_priority[1:0]     = mcontrol2_priority[1:0];
      m1_priority_mask[1:0]= mcontrol2_priority_mask[1:0];
    end
  else
    begin
      m1_priority[1:0]     = mcontrol1_priority[1:0];
      m1_priority_mask[1:0]= mcontrol1_priority_mask[1:0];
    end
// &CombEnd; @1766
end
// &CombBeg; @1767
always @( mcontrol2_priority[1:0]
       or m2_phigher_than_m1_no_chain
       or mcontrol1_priority_mask[1:0]
       or mcontrol1_priority[1:0]
       or mcontrol3_priority_mask[1:0]
       or m3_phigher_than_m2_no_chain
       or mcontrol2_priority_mask[1:0]
       or chain2_on
       or chain1_on
       or mcontrol3_priority[1:0])
begin
  //m2_priority
  if(chain1_on && m2_phigher_than_m1_no_chain)
    begin
      m2_priority[1:0]     = mcontrol1_priority[1:0];
      m2_priority_mask[1:0]= mcontrol1_priority_mask[1:0];
    end
  else if(chain2_on && !m3_phigher_than_m2_no_chain)
    begin
      m2_priority[1:0]     = mcontrol3_priority[1:0];
      m2_priority_mask[1:0]= mcontrol3_priority_mask[1:0];
    end
  else
    begin
      m2_priority[1:0]     = mcontrol2_priority[1:0];
      m2_priority_mask[1:0]= mcontrol2_priority_mask[1:0];
    end
// &CombEnd; @1784
end
// &CombBeg; @1785
always @( mcontrol2_priority[1:0]
       or m4_phigher_than_m3_no_chain
       or mcontrol3_priority_mask[1:0]
       or mcontrol4_priority[1:0]
       or m3_phigher_than_m2_no_chain
       or mcontrol2_priority_mask[1:0]
       or chain3_on
       or chain2_on
       or mcontrol3_priority[1:0]
       or mcontrol4_priority_mask[1:0])
begin
  //m3_priority
  if(chain2_on && m3_phigher_than_m2_no_chain)
    begin
      m3_priority[1:0]     = mcontrol2_priority[1:0];
      m3_priority_mask[1:0]= mcontrol2_priority_mask[1:0];
    end
  else if(chain3_on && !m4_phigher_than_m3_no_chain)
    begin
      m3_priority[1:0]     = mcontrol4_priority[1:0];
      m3_priority_mask[1:0]= mcontrol4_priority_mask[1:0];
    end
  else
    begin
      m3_priority[1:0]     = mcontrol3_priority[1:0];
      m3_priority_mask[1:0]= mcontrol3_priority_mask[1:0];
    end
// &CombEnd; @1802
end
// &CombBeg; @1803
always @( mcontrol5_priority[1:0]
       or m4_phigher_than_m3_no_chain
       or mcontrol4_priority[1:0]
       or mcontrol3_priority_mask[1:0]
       or m5_phigher_than_m4_no_chain
       or chain4_on
       or chain3_on
       or mcontrol3_priority[1:0]
       or mcontrol4_priority_mask[1:0]
       or mcontrol5_priority_mask[1:0])
begin
  //m4_priority
  if(chain3_on && m4_phigher_than_m3_no_chain)
    begin
      m4_priority[1:0]     = mcontrol3_priority[1:0];
      m4_priority_mask[1:0]= mcontrol3_priority_mask[1:0];
    end
  else if(chain4_on && !m5_phigher_than_m4_no_chain)
    begin
      m4_priority[1:0]     = mcontrol5_priority[1:0];
      m4_priority_mask[1:0]= mcontrol5_priority_mask[1:0];
    end
  else
    begin
      m4_priority[1:0]     = mcontrol4_priority[1:0];
      m4_priority_mask[1:0]= mcontrol4_priority_mask[1:0];
    end
// &CombEnd; @1820
end
// &CombBeg; @1821
always @( mcontrol5_priority[1:0]
       or mcontrol6_priority[1:0]
       or mcontrol4_priority[1:0]
       or m5_phigher_than_m4_no_chain
       or m6_phigher_than_m5_no_chain
       or chain5_on
       or chain4_on
       or mcontrol5_priority_mask[1:0]
       or mcontrol4_priority_mask[1:0]
       or mcontrol6_priority_mask[1:0])
begin
  //m5_priority
  if(chain4_on && m5_phigher_than_m4_no_chain)
    begin
      m5_priority[1:0]     = mcontrol4_priority[1:0];
      m5_priority_mask[1:0]= mcontrol4_priority_mask[1:0];
    end
  else if(chain5_on && !m6_phigher_than_m5_no_chain)
    begin
      m5_priority[1:0]     = mcontrol6_priority[1:0];
      m5_priority_mask[1:0]= mcontrol6_priority_mask[1:0];
    end
  else
    begin
      m5_priority[1:0]     = mcontrol5_priority[1:0];
      m5_priority_mask[1:0]= mcontrol5_priority_mask[1:0];
    end
// &CombEnd; @1838
end
// &CombBeg; @1839
always @( mcontrol5_priority[1:0]
       or mcontrol7_priority_mask[1:0]
       or mcontrol6_priority[1:0]
       or m7_phigher_than_m6_no_chain
       or m6_phigher_than_m5_no_chain
       or chain5_on
       or mcontrol7_priority[1:0]
       or chain6_on
       or mcontrol6_priority_mask[1:0]
       or mcontrol5_priority_mask[1:0])
begin
  //m6_priority
  if(chain5_on  && m6_phigher_than_m5_no_chain)
    begin
      m6_priority[1:0]     = mcontrol5_priority[1:0];
      m6_priority_mask[1:0]= mcontrol5_priority_mask[1:0];
    end
  else if(chain6_on && !m7_phigher_than_m6_no_chain)
    begin
      m6_priority[1:0]     = mcontrol7_priority[1:0];
      m6_priority_mask[1:0]= mcontrol7_priority_mask[1:0];
    end
  else
    begin
      m6_priority[1:0]     = mcontrol6_priority[1:0];
      m6_priority_mask[1:0]= mcontrol6_priority_mask[1:0];
    end
// &CombEnd; @1856
end
assign m7_priority[1:0]      = chain6_on && m7_phigher_than_m6_no_chain ? //m7_priority
                               mcontrol6_priority[1:0] : mcontrol7_priority[1:0];
assign m7_priority_mask[1:0] = chain6_on && m7_phigher_than_m6_no_chain ?
                               mcontrol6_priority_mask[1:0] : mcontrol7_priority_mask[1:0];
//chain timing
assign m1_thigher_than_m0_no_chain = |(mcontrol0_mtiming_mask[1:0] & mcontrol1_mtiming[1:0]);
assign m2_thigher_than_m1_no_chain = |(mcontrol1_mtiming_mask[1:0] & mcontrol2_mtiming[1:0]);
assign m3_thigher_than_m2_no_chain = |(mcontrol2_mtiming_mask[1:0] & mcontrol3_mtiming[1:0]);
assign m4_thigher_than_m3_no_chain = |(mcontrol3_mtiming_mask[1:0] & mcontrol4_mtiming[1:0]);
assign m5_thigher_than_m4_no_chain = |(mcontrol4_mtiming_mask[1:0] & mcontrol5_mtiming[1:0]);
assign m6_thigher_than_m5_no_chain = |(mcontrol5_mtiming_mask[1:0] & mcontrol6_mtiming[1:0]);
assign m7_thigher_than_m6_no_chain = |(mcontrol6_mtiming_mask[1:0] & mcontrol7_mtiming[1:0]);

assign m0_mtiming[1:0]       = chain0_on && !m1_thigher_than_m0_no_chain? //m0_timing
                               mcontrol1_mtiming[1:0] : mcontrol0_mtiming[1:0];
assign m0_mtiming_mask[1:0]  = chain0_on && !m1_thigher_than_m0_no_chain ?
                               mcontrol1_mtiming_mask[1:0]:mcontrol0_mtiming_mask[1:0];
// &CombBeg; @1874
always @( mcontrol2_mtiming[1:0]
       or mcontrol1_mtiming_mask[1:0]
       or m1_thigher_than_m0_no_chain
       or mcontrol1_mtiming[1:0]
       or chain0_on
       or mcontrol0_mtiming_mask[1:0]
       or m2_thigher_than_m1_no_chain
       or chain1_on
       or mcontrol2_mtiming_mask[1:0]
       or mcontrol0_mtiming[1:0])
begin
  //m1_timing
  if(chain0_on && m1_thigher_than_m0_no_chain)
    begin
      m1_mtiming[1:0]     = mcontrol0_mtiming[1:0];
      m1_mtiming_mask[1:0]= mcontrol0_mtiming_mask[1:0];
    end
  else if(chain1_on && !m2_thigher_than_m1_no_chain)
    begin
      m1_mtiming[1:0]     = mcontrol2_mtiming[1:0];
      m1_mtiming_mask[1:0]= mcontrol2_mtiming_mask[1:0];
    end
  else
    begin
      m1_mtiming[1:0]     = mcontrol1_mtiming[1:0];
      m1_mtiming_mask[1:0]= mcontrol1_mtiming_mask[1:0];
    end
// &CombEnd; @1891
end
// &CombBeg; @1892
always @( mcontrol2_mtiming[1:0]
       or mcontrol1_mtiming_mask[1:0]
       or mcontrol3_mtiming[1:0]
       or m3_thigher_than_m2_no_chain
       or mcontrol1_mtiming[1:0]
       or m2_thigher_than_m1_no_chain
       or mcontrol3_mtiming_mask[1:0]
       or chain2_on
       or chain1_on
       or mcontrol2_mtiming_mask[1:0])
begin
  //m2_timing
  if(chain1_on && m2_thigher_than_m1_no_chain)
    begin
      m2_mtiming[1:0]     = mcontrol1_mtiming[1:0];
      m2_mtiming_mask[1:0]= mcontrol1_mtiming_mask[1:0];
    end
  else if(chain2_on && !m3_thigher_than_m2_no_chain)
    begin
      m2_mtiming[1:0]     = mcontrol3_mtiming[1:0];
      m2_mtiming_mask[1:0]= mcontrol3_mtiming_mask[1:0];
    end
  else
    begin
      m2_mtiming[1:0]     = mcontrol2_mtiming[1:0];
      m2_mtiming_mask[1:0]= mcontrol2_mtiming_mask[1:0];
    end
// &CombEnd; @1909
end
// &CombBeg; @1910
always @( mcontrol2_mtiming[1:0]
       or mcontrol3_mtiming[1:0]
       or mcontrol4_mtiming_mask[1:0]
       or m3_thigher_than_m2_no_chain
       or chain3_on
       or mcontrol3_mtiming_mask[1:0]
       or mcontrol4_mtiming[1:0]
       or m4_thigher_than_m3_no_chain
       or chain2_on
       or mcontrol2_mtiming_mask[1:0])
begin
  //m3_timing
  if(chain2_on && m3_thigher_than_m2_no_chain)
    begin
      m3_mtiming[1:0]     = mcontrol2_mtiming[1:0];
      m3_mtiming_mask[1:0]= mcontrol2_mtiming_mask[1:0];
    end
  else if(chain3_on && !m4_thigher_than_m3_no_chain)
    begin
      m3_mtiming[1:0]     = mcontrol4_mtiming[1:0];
      m3_mtiming_mask[1:0]= mcontrol4_mtiming_mask[1:0];
    end
  else
    begin
      m3_mtiming[1:0]     = mcontrol3_mtiming[1:0];
      m3_mtiming_mask[1:0]= mcontrol3_mtiming_mask[1:0];
    end
// &CombEnd; @1927
end
// &CombBeg; @1928
always @( mcontrol3_mtiming[1:0]
       or mcontrol4_mtiming_mask[1:0]
       or mcontrol5_mtiming[1:0]
       or m5_thigher_than_m4_no_chain
       or mcontrol5_mtiming_mask[1:0]
       or chain4_on
       or chain3_on
       or mcontrol4_mtiming[1:0]
       or mcontrol3_mtiming_mask[1:0]
       or m4_thigher_than_m3_no_chain)
begin
  //m4_timing
  if(chain3_on && m4_thigher_than_m3_no_chain)
    begin
      m4_mtiming[1:0]     = mcontrol3_mtiming[1:0];
      m4_mtiming_mask[1:0]= mcontrol3_mtiming_mask[1:0];
    end
  else if(chain4_on && !m5_thigher_than_m4_no_chain)
    begin
      m4_mtiming[1:0]     = mcontrol5_mtiming[1:0];
      m4_mtiming_mask[1:0]= mcontrol5_mtiming_mask[1:0];
    end
  else
    begin
      m4_mtiming[1:0]     = mcontrol4_mtiming[1:0];
      m4_mtiming_mask[1:0]= mcontrol4_mtiming_mask[1:0];
    end
// &CombEnd; @1945
end
// &CombBeg; @1946
always @( m6_thigher_than_m5_no_chain
       or mcontrol4_mtiming_mask[1:0]
       or mcontrol5_mtiming[1:0]
       or mcontrol6_mtiming_mask[1:0]
       or m5_thigher_than_m4_no_chain
       or mcontrol6_mtiming[1:0]
       or chain5_on
       or mcontrol5_mtiming_mask[1:0]
       or chain4_on
       or mcontrol4_mtiming[1:0])
begin
  //m5_timing
  if(chain4_on && m5_thigher_than_m4_no_chain)
    begin
      m5_mtiming[1:0]     = mcontrol4_mtiming[1:0];
      m5_mtiming_mask[1:0]= mcontrol4_mtiming_mask[1:0];
    end
  else if(chain5_on && !m6_thigher_than_m5_no_chain)
    begin
      m5_mtiming[1:0]     = mcontrol6_mtiming[1:0];
      m5_mtiming_mask[1:0]= mcontrol6_mtiming_mask[1:0];
    end
  else
    begin
      m5_mtiming[1:0]     = mcontrol5_mtiming[1:0];
      m5_mtiming_mask[1:0]= mcontrol5_mtiming_mask[1:0];
    end
// &CombEnd; @1963
end
// &CombBeg; @1964
always @( m6_thigher_than_m5_no_chain
       or mcontrol6_mtiming_mask[1:0]
       or mcontrol5_mtiming[1:0]
       or mcontrol7_mtiming[1:0]
       or mcontrol6_mtiming[1:0]
       or mcontrol7_mtiming_mask[1:0]
       or chain5_on
       or mcontrol5_mtiming_mask[1:0]
       or m7_thigher_than_m6_no_chain
       or chain6_on)
begin
  //m6_timing
  if(chain5_on && m6_thigher_than_m5_no_chain)
    begin
      m6_mtiming[1:0]     = mcontrol5_mtiming[1:0];
      m6_mtiming_mask[1:0]= mcontrol5_mtiming_mask[1:0];
    end
  else if(chain6_on && !m7_thigher_than_m6_no_chain)
    begin
      m6_mtiming[1:0]     = mcontrol7_mtiming[1:0];
      m6_mtiming_mask[1:0]= mcontrol7_mtiming_mask[1:0];
    end
  else
    begin
      m6_mtiming[1:0]     = mcontrol6_mtiming[1:0];
      m6_mtiming_mask[1:0]= mcontrol6_mtiming_mask[1:0];
    end
// &CombEnd; @1981
end
assign m7_mtiming[1:0]      = chain6_on && m7_thigher_than_m6_no_chain ? 
                              mcontrol6_mtiming[1:0] : mcontrol7_mtiming[1:0];
assign m7_mtiming_mask[1:0] = chain6_on && m7_thigher_than_m6_no_chain ?
                              mcontrol6_mtiming_mask[1:0] : mcontrol7_mtiming_mask[1:0];
//higher priority
assign m1_phigher_than_m0 = |(m0_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m0 = |(m0_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m0 = |(m0_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m0 = |(m0_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m0 = |(m0_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m0 = |(m0_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m0 = |(m0_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m0[6:0] = {m7_phigher_than_m0,m6_phigher_than_m0,m5_phigher_than_m0,
                                 m4_phigher_than_m0,m3_phigher_than_m0,m2_phigher_than_m0,
                                 m1_phigher_than_m0};

assign m0_phigher_than_m1 = |(m1_priority_mask[1:0] & m0_priority[1:0]);
assign m2_phigher_than_m1 = |(m1_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m1 = |(m1_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m1 = |(m1_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m1 = |(m1_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m1 = |(m1_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m1 = |(m1_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m1[6:0] = {m7_phigher_than_m1,m6_phigher_than_m1,m5_phigher_than_m1,
                                 m4_phigher_than_m1,m3_phigher_than_m1,m2_phigher_than_m1,
                                 m0_phigher_than_m1};

assign m0_phigher_than_m2 = |(m2_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m2 = |(m2_priority_mask[1:0] & m1_priority[1:0]);
assign m3_phigher_than_m2 = |(m2_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m2 = |(m2_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m2 = |(m2_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m2 = |(m2_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m2 = |(m2_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m2[6:0] = {m7_phigher_than_m2,m6_phigher_than_m2,m5_phigher_than_m2,
                                 m4_phigher_than_m2,m3_phigher_than_m2,m1_phigher_than_m2,
                                 m0_phigher_than_m2};

assign m0_phigher_than_m3 = |(m3_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m3 = |(m3_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m3 = |(m3_priority_mask[1:0] & m2_priority[1:0]);
assign m4_phigher_than_m3 = |(m3_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m3 = |(m3_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m3 = |(m3_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m3 = |(m3_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m3[6:0] = {m7_phigher_than_m3,m6_phigher_than_m3,m5_phigher_than_m3,
                                 m4_phigher_than_m3,m2_phigher_than_m3,m1_phigher_than_m3,
                                 m0_phigher_than_m3};

assign m0_phigher_than_m4 = |(m4_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m4 = |(m4_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m4 = |(m4_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m4 = |(m4_priority_mask[1:0] & m3_priority[1:0]);
assign m5_phigher_than_m4 = |(m4_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m4 = |(m4_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m4 = |(m4_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m4[6:0] = {m7_phigher_than_m4,m6_phigher_than_m4,m5_phigher_than_m4,
                                 m3_phigher_than_m4,m2_phigher_than_m4,m1_phigher_than_m4,
                                 m0_phigher_than_m4};

assign m0_phigher_than_m5 = |(m5_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m5 = |(m5_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m5 = |(m5_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m5 = |(m5_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m5 = |(m5_priority_mask[1:0] & m4_priority[1:0]);
assign m6_phigher_than_m5 = |(m5_priority_mask[1:0] & m6_priority[1:0]);
assign m7_phigher_than_m5 = |(m5_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m5[6:0] = {m7_phigher_than_m5,m6_phigher_than_m5,m4_phigher_than_m5,
                                 m3_phigher_than_m5,m2_phigher_than_m5,m1_phigher_than_m5,
                                 m0_phigher_than_m5};

assign m0_phigher_than_m6 = |(m6_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m6 = |(m6_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m6 = |(m6_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m6 = |(m6_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m6 = |(m6_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m6 = |(m6_priority_mask[1:0] & m5_priority[1:0]);
assign m7_phigher_than_m6 = |(m6_priority_mask[1:0] & m7_priority[1:0]);
assign x_phigher_than_m6[6:0] = {m7_phigher_than_m6,m5_phigher_than_m6,m4_phigher_than_m6,
                                 m3_phigher_than_m6,m2_phigher_than_m6,m1_phigher_than_m6,
                                 m0_phigher_than_m6};

assign m0_phigher_than_m7 = |(m7_priority_mask[1:0] & m0_priority[1:0]);
assign m1_phigher_than_m7 = |(m7_priority_mask[1:0] & m1_priority[1:0]);
assign m2_phigher_than_m7 = |(m7_priority_mask[1:0] & m2_priority[1:0]);
assign m3_phigher_than_m7 = |(m7_priority_mask[1:0] & m3_priority[1:0]);
assign m4_phigher_than_m7 = |(m7_priority_mask[1:0] & m4_priority[1:0]);
assign m5_phigher_than_m7 = |(m7_priority_mask[1:0] & m5_priority[1:0]);
assign m6_phigher_than_m7 = |(m7_priority_mask[1:0] & m6_priority[1:0]);
assign x_phigher_than_m7[6:0] = {m6_phigher_than_m7,m5_phigher_than_m7,m4_phigher_than_m7,
                                 m3_phigher_than_m7,m2_phigher_than_m7,m1_phigher_than_m7,
                                 m0_phigher_than_m7};

//higher timing
assign m1_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m0 = |(m0_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m0[6:0] = {m7_thigher_than_m0,m6_thigher_than_m0,m5_thigher_than_m0,
                                 m4_thigher_than_m0,m3_thigher_than_m0,m2_thigher_than_m0,
                                 m1_thigher_than_m0};

assign m0_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m2_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m1 = |(m1_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m1[6:0] = {m7_thigher_than_m1,m6_thigher_than_m1,m5_thigher_than_m1,
                                 m4_thigher_than_m1,m3_thigher_than_m1,m2_thigher_than_m1,
                                 m0_thigher_than_m1};

assign m0_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m3_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m2 = |(m2_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m2[6:0] = {m7_thigher_than_m2,m6_thigher_than_m2,m5_thigher_than_m2,
                                 m4_thigher_than_m2,m3_thigher_than_m2,m1_thigher_than_m2,
                                 m0_thigher_than_m2};

assign m0_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m4_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m3 = |(m3_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m3[6:0] = {m7_thigher_than_m3,m6_thigher_than_m3,m5_thigher_than_m3,
                                 m4_thigher_than_m3,m2_thigher_than_m3,m1_thigher_than_m3,
                                 m0_thigher_than_m3};

assign m0_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m5_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m4 = |(m4_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m4[6:0] = {m7_thigher_than_m4,m6_thigher_than_m4,m5_thigher_than_m4,
                                 m3_thigher_than_m4,m2_thigher_than_m4,m1_thigher_than_m4,
                                 m0_thigher_than_m4};

assign m0_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m6_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign m7_thigher_than_m5 = |(m5_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m5[6:0] = {m7_thigher_than_m5,m6_thigher_than_m5,m4_thigher_than_m5,
                                 m3_thigher_than_m5,m2_thigher_than_m5,m1_thigher_than_m5,
                                 m0_thigher_than_m5};

assign m0_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m7_thigher_than_m6 = |(m6_mtiming_mask[1:0] & m7_mtiming[1:0]);
assign x_thigher_than_m6[6:0] = {m7_thigher_than_m6,m5_thigher_than_m6,m4_thigher_than_m6,
                                 m3_thigher_than_m6,m2_thigher_than_m6,m1_thigher_than_m6,
                                 m0_thigher_than_m6};

assign m0_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m0_mtiming[1:0]);
assign m1_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m1_mtiming[1:0]);
assign m2_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m2_mtiming[1:0]);
assign m3_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m3_mtiming[1:0]);
assign m4_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m4_mtiming[1:0]);
assign m5_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m5_mtiming[1:0]);
assign m6_thigher_than_m7 = |(m7_mtiming_mask[1:0] & m6_mtiming[1:0]);
assign x_thigher_than_m7[6:0] = {m6_thigher_than_m7,m5_thigher_than_m7,m4_thigher_than_m7,
                                 m3_thigher_than_m7,m2_thigher_than_m7,m1_thigher_than_m7,
                                 m0_thigher_than_m7};

 
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
    if(!cpurst_b)
      begin
        x_phigher_than_m0_reg[6:0] <= 7'b0;
        x_phigher_than_m1_reg[6:0] <= 7'b0;
        x_phigher_than_m2_reg[6:0] <= 7'b0;
        x_phigher_than_m3_reg[6:0] <= 7'b0;
        x_phigher_than_m4_reg[6:0] <= 7'b0;
        x_phigher_than_m5_reg[6:0] <= 7'b0;
        x_phigher_than_m6_reg[6:0] <= 7'b0;
        x_phigher_than_m7_reg[6:0] <= 7'b0;

        x_thigher_than_m0_reg[6:0] <= 7'b0;
        x_thigher_than_m1_reg[6:0] <= 7'b0;
        x_thigher_than_m2_reg[6:0] <= 7'b0;
        x_thigher_than_m3_reg[6:0] <= 7'b0;
        x_thigher_than_m4_reg[6:0] <= 7'b0;
        x_thigher_than_m5_reg[6:0] <= 7'b0;
        x_thigher_than_m6_reg[6:0] <= 7'b0;
        x_thigher_than_m7_reg[6:0] <= 7'b0;
      end
    else if(cp0_write_tdata1_f)
      begin
        x_phigher_than_m0_reg[6:0] <= x_phigher_than_m0[6:0];
        x_phigher_than_m1_reg[6:0] <= x_phigher_than_m1[6:0];
        x_phigher_than_m2_reg[6:0] <= x_phigher_than_m2[6:0];
        x_phigher_than_m3_reg[6:0] <= x_phigher_than_m3[6:0];
        x_phigher_than_m4_reg[6:0] <= x_phigher_than_m4[6:0];
        x_phigher_than_m5_reg[6:0] <= x_phigher_than_m5[6:0];
        x_phigher_than_m6_reg[6:0] <= x_phigher_than_m6[6:0];
        x_phigher_than_m7_reg[6:0] <= x_phigher_than_m7[6:0];

        x_thigher_than_m0_reg[6:0] <= x_thigher_than_m0[6:0];
        x_thigher_than_m1_reg[6:0] <= x_thigher_than_m1[6:0];
        x_thigher_than_m2_reg[6:0] <= x_thigher_than_m2[6:0];
        x_thigher_than_m3_reg[6:0] <= x_thigher_than_m3[6:0];
        x_thigher_than_m4_reg[6:0] <= x_thigher_than_m4[6:0];
        x_thigher_than_m5_reg[6:0] <= x_thigher_than_m5[6:0];
        x_thigher_than_m6_reg[6:0] <= x_thigher_than_m6[6:0];
        x_thigher_than_m7_reg[6:0] <= x_thigher_than_m7[6:0];
      end
end

//---------------------------------------------------------
//                    exe0 output select logic
//---------------------------------------------------------
//chain match logic

//generate cancel signal
//if single trigger match, need to cancel
assign mcontrol0_exe0_cancel = mcontrol0_exe0_match && !chain0_on;
assign mcontrol1_exe0_cancel = mcontrol1_exe0_match && !(chain0_on || chain1_on);
assign mcontrol2_exe0_cancel = mcontrol2_exe0_match && !(chain1_on || chain2_on);
assign mcontrol3_exe0_cancel = mcontrol3_exe0_match && !(chain2_on || chain3_on);
assign mcontrol4_exe0_cancel = mcontrol4_exe0_match && !(chain3_on || chain4_on);
assign mcontrol5_exe0_cancel = mcontrol5_exe0_match && !(chain4_on || chain5_on);
assign mcontrol6_exe0_cancel = mcontrol6_exe0_match && !(chain5_on || chain6_on);
assign mcontrol7_exe0_cancel = mcontrol7_exe0_match && !chain6_on;
assign exe0_single_mcontrol_cancel = mcontrol0_exe0_cancel || mcontrol1_exe0_cancel || mcontrol2_exe0_cancel || mcontrol3_exe0_cancel ||
                                     mcontrol4_exe0_cancel || mcontrol5_exe0_cancel || mcontrol6_exe0_cancel || mcontrol7_exe0_cancel;
//if exe + exe chain match, need to cancel
assign exe0_chain0_match   = mcontrol0_exe0_match && mcontrol1_exe0_match && chain0_same_timing && m01_is_exe_chain;
assign exe0_chain1_match   = mcontrol1_exe0_match && mcontrol2_exe0_match && chain1_same_timing && m12_is_exe_chain;
assign exe0_chain2_match   = mcontrol2_exe0_match && mcontrol3_exe0_match && chain2_same_timing && m23_is_exe_chain;
assign exe0_chain3_match   = mcontrol3_exe0_match && mcontrol4_exe0_match && chain3_same_timing && m34_is_exe_chain;
assign exe0_chain4_match   = mcontrol4_exe0_match && mcontrol5_exe0_match && chain4_same_timing && m45_is_exe_chain;
assign exe0_chain5_match   = mcontrol5_exe0_match && mcontrol6_exe0_match && chain5_same_timing && m56_is_exe_chain;
assign exe0_chain6_match   = mcontrol6_exe0_match && mcontrol7_exe0_match && chain6_same_timing && m67_is_exe_chain;
assign exe0_chain_cancel   = exe0_chain0_match || exe0_chain1_match || exe0_chain2_match || exe0_chain3_match ||
                             exe0_chain4_match || exe0_chain5_match || exe0_chain6_match;
//after chain match
assign exe0_mcontrol0_single_match = mcontrol0_exe0_match && !m01_is_exe_chain;
assign exe0_after_chain_match0     = exe0_mcontrol0_single_match || exe0_chain0_match;

assign exe0_mcontrol1_single_match = mcontrol1_exe0_match && !(m01_is_exe_chain || m12_is_exe_chain);
assign exe0_after_chain_match1     = exe0_mcontrol1_single_match || exe0_chain0_match || exe0_chain1_match;

assign exe0_mcontrol2_single_match = mcontrol2_exe0_match && !(m12_is_exe_chain || m23_is_exe_chain);
assign exe0_after_chain_match2     = exe0_mcontrol2_single_match || exe0_chain1_match || exe0_chain2_match;

assign exe0_mcontrol3_single_match = mcontrol3_exe0_match && !(m23_is_exe_chain || m34_is_exe_chain);
assign exe0_after_chain_match3     = exe0_mcontrol3_single_match || exe0_chain2_match || exe0_chain3_match;

assign exe0_mcontrol4_single_match = mcontrol4_exe0_match && !(m34_is_exe_chain || m45_is_exe_chain);
assign exe0_after_chain_match4     = exe0_mcontrol4_single_match || exe0_chain3_match || exe0_chain4_match;

assign exe0_mcontrol5_single_match = mcontrol5_exe0_match && !(m45_is_exe_chain || m56_is_exe_chain);
assign exe0_after_chain_match5     = exe0_mcontrol5_single_match || exe0_chain4_match || exe0_chain5_match;

assign exe0_mcontrol6_single_match = mcontrol6_exe0_match && !(m56_is_exe_chain || m67_is_exe_chain);
assign exe0_after_chain_match6     = exe0_mcontrol6_single_match || exe0_chain5_match || exe0_chain6_match;

assign exe0_mcontrol7_single_match = mcontrol7_exe0_match && !m67_is_exe_chain;
assign exe0_after_chain_match7     = exe0_mcontrol7_single_match || exe0_chain6_match;

//assign exe0_after_chain_match0 = m01_is_exe_chain ? exe0_chain0_match : 
//                                                    mcontrol0_exe0_match;
//&CombBeg;
//  if(m01_is_exe_chain)
//    exe0_after_chain_match1 = exe0_chain0_match;
//  else if(m12_is_exe_chain)
//    exe0_after_chain_match1 = exe0_chain1_match;
//  else
//    exe0_after_chain_match1 = mcontrol1_exe0_match;
//&CombEnd;
//&CombBeg;
//  if(m12_is_exe_chain)
//    exe0_after_chain_match2 = exe0_chain1_match;
//  else if(m23_is_exe_chain)
//    exe0_after_chain_match2 = exe0_chain2_match;
//  else
//    exe0_after_chain_match2 = mcontrol2_exe0_match;
//&CombEnd;
//&CombBeg;
//  if(m23_is_exe_chain)
//    exe0_after_chain_match3 = exe0_chain2_match;
//  else if(m34_is_exe_chain)
//    exe0_after_chain_match3 = exe0_chain3_match;
//  else
//    exe0_after_chain_match3 = mcontrol3_exe0_match;
//&CombEnd;
//&CombBeg;
//  if(m34_is_exe_chain)
//    exe0_after_chain_match4 = exe0_chain3_match;
//  else if(m45_is_exe_chain)
//    exe0_after_chain_match4 = exe0_chain4_match;
//  else
//    exe0_after_chain_match4 = mcontrol4_exe0_match;
//&CombEnd;
//&CombBeg;
//  if(m45_is_exe_chain)
//    exe0_after_chain_match5 = exe0_chain4_match;
//  else if(m56_is_exe_chain)
//    exe0_after_chain_match5 = exe0_chain5_match;
//  else
//    exe0_after_chain_match5 = mcontrol5_exe0_match;
//&CombEnd;
//&CombBeg;
//  if(m56_is_exe_chain)
//    exe0_after_chain_match6 = exe0_chain5_match;
//  else if(m67_is_exe_chain)
//    exe0_after_chain_match6 = exe0_chain6_match;
//  else
//    exe0_after_chain_match6 = mcontrol6_exe0_match;
//&CombEnd;
//assign exe0_after_chain_match7 = m67_is_exe_chain ? exe0_chain6_match : 
//                                                    mcontrol7_exe0_match;
assign exe0_after_chain_match[7:0] ={exe0_after_chain_match7,exe0_after_chain_match6,
                                     exe0_after_chain_match5,exe0_after_chain_match4,
                                     exe0_after_chain_match3,exe0_after_chain_match2,
                                     exe0_after_chain_match1,exe0_after_chain_match0};
//priority select logic
assign m0_exe0_can_match = !(|(x_phigher_than_m0_reg[6:0] & exe0_after_chain_match[7:1]));
assign m1_exe0_can_match = !(|(x_phigher_than_m1_reg[6:0] & {exe0_after_chain_match[7:2],exe0_after_chain_match[0]}));
assign m2_exe0_can_match = !(|(x_phigher_than_m2_reg[6:0] & {exe0_after_chain_match[7:3],exe0_after_chain_match[1:0]}));
assign m3_exe0_can_match = !(|(x_phigher_than_m3_reg[6:0] & {exe0_after_chain_match[7:4],exe0_after_chain_match[2:0]}));
assign m4_exe0_can_match = !(|(x_phigher_than_m4_reg[6:0] & {exe0_after_chain_match[7:5],exe0_after_chain_match[3:0]}));
assign m5_exe0_can_match = !(|(x_phigher_than_m5_reg[6:0] & {exe0_after_chain_match[7:6],exe0_after_chain_match[4:0]}));
assign m6_exe0_can_match = !(|(x_phigher_than_m6_reg[6:0] & {exe0_after_chain_match[7],exe0_after_chain_match[5:0]}));
assign m7_exe0_can_match = !(|(x_phigher_than_m7_reg[6:0] & exe0_after_chain_match[6:0]));

assign m0_exe0_match     = m0_exe0_can_match && exe0_after_chain_match0;
assign m1_exe0_match     = m1_exe0_can_match && exe0_after_chain_match1;
assign m2_exe0_match     = m2_exe0_can_match && exe0_after_chain_match2;
assign m3_exe0_match     = m3_exe0_can_match && exe0_after_chain_match3;
assign m4_exe0_match     = m4_exe0_can_match && exe0_after_chain_match4;
assign m5_exe0_match     = m5_exe0_can_match && exe0_after_chain_match5;
assign m6_exe0_match     = m6_exe0_can_match && exe0_after_chain_match6;
assign m7_exe0_match     = m7_exe0_can_match && exe0_after_chain_match7;

//output select
//match
assign exe0_match[7:0]    = {m7_exe0_match,m6_exe0_match,m5_exe0_match,m4_exe0_match,
                             m3_exe0_match,m2_exe0_match,m1_exe0_match,m0_exe0_match};
assign exe0_have_match    = exe0_cancel;
//chain
assign m0_exe0_chain      = m0_exe0_match && m0_exe_chain_modify;
assign m1_exe0_chain      = m1_exe0_match && m1_exe_chain_modify;
assign m2_exe0_chain      = m2_exe0_match && m2_exe_chain_modify;
assign m3_exe0_chain      = m3_exe0_match && m3_exe_chain_modify;
assign m4_exe0_chain      = m4_exe0_match && m4_exe_chain_modify;
assign m5_exe0_chain      = m5_exe0_match && m5_exe_chain_modify;
assign m6_exe0_chain      = m6_exe0_match && m6_exe_chain_modify;
assign m7_exe0_chain      = m7_exe0_match && m7_exe_chain_modify;
assign exe0_chain         = m7_exe0_chain || m6_exe0_chain || m5_exe0_chain || m4_exe0_chain ||
                            m3_exe0_chain || m2_exe0_chain || m1_exe0_chain || m0_exe0_chain;
//action0
assign m0_exe0_action0      = m0_exe0_match && mcontrol0_action0;
assign m1_exe0_action0      = m1_exe0_match && mcontrol1_action0;
assign m2_exe0_action0      = m2_exe0_match && mcontrol2_action0;
assign m3_exe0_action0      = m3_exe0_match && mcontrol3_action0;
assign m4_exe0_action0      = m4_exe0_match && mcontrol4_action0;
assign m5_exe0_action0      = m5_exe0_match && mcontrol5_action0;
assign m6_exe0_action0      = m6_exe0_match && mcontrol6_action0;
assign m7_exe0_action0      = m7_exe0_match && mcontrol7_action0;
assign exe0_action0         = m7_exe0_action0 || m6_exe0_action0 || m5_exe0_action0 || m4_exe0_action0 ||
                            m3_exe0_action0 || m2_exe0_action0 || m1_exe0_action0 || m0_exe0_action0;

//action1
assign m0_exe0_action1      = m0_exe0_match && mcontrol0_action1;
assign m1_exe0_action1      = m1_exe0_match && mcontrol1_action1;
assign m2_exe0_action1      = m2_exe0_match && mcontrol2_action1;
assign m3_exe0_action1      = m3_exe0_match && mcontrol3_action1;
assign m4_exe0_action1      = m4_exe0_match && mcontrol4_action1;
assign m5_exe0_action1      = m5_exe0_match && mcontrol5_action1;
assign m6_exe0_action1      = m6_exe0_match && mcontrol6_action1;
assign m7_exe0_action1      = m7_exe0_match && mcontrol7_action1;
assign exe0_action1         = m7_exe0_action1 || m6_exe0_action1 || m5_exe0_action1 || m4_exe0_action1 ||
                            m3_exe0_action1 || m2_exe0_action1 || m1_exe0_action1 || m0_exe0_action1;

assign exe0_action        = !exe0_action0 && exe0_action1;
assign exe0_action01      = exe0_action0 && exe0_action1;

//timing
assign exe0_timing         = 1'b0;

//cancel
assign exe0_cancel        = exe0_single_mcontrol_cancel || exe0_chain_cancel;

assign mcontrol_halt_info0[`TDT_HINFO_WIDTH-1:0] = {exe0_match[7:0],{`TDT_TM_OTHER_TRI_NUM{1'b0}},4'd2,1'b0,
                                                   exe0_timing,exe0_action01,exe0_action,
                                                   exe0_chain,1'b0,exe0_have_match,exe0_cancel};

//---------------------------------------------------------
//                    exe1 output select logic
//---------------------------------------------------------
//chain match logic

//generate cancel signal
//if single trigger match, need to cancel
assign mcontrol0_exe1_cancel = mcontrol0_exe1_match && !chain0_on;
assign mcontrol1_exe1_cancel = mcontrol1_exe1_match && !(chain0_on || chain1_on);
assign mcontrol2_exe1_cancel = mcontrol2_exe1_match && !(chain1_on || chain2_on);
assign mcontrol3_exe1_cancel = mcontrol3_exe1_match && !(chain2_on || chain3_on);
assign mcontrol4_exe1_cancel = mcontrol4_exe1_match && !(chain3_on || chain4_on);
assign mcontrol5_exe1_cancel = mcontrol5_exe1_match && !(chain4_on || chain5_on);
assign mcontrol6_exe1_cancel = mcontrol6_exe1_match && !(chain5_on || chain6_on);
assign mcontrol7_exe1_cancel = mcontrol7_exe1_match && !chain6_on;
assign exe1_single_mcontrol_cancel = mcontrol0_exe1_cancel || mcontrol1_exe1_cancel || mcontrol2_exe1_cancel || mcontrol3_exe1_cancel ||
                                     mcontrol4_exe1_cancel || mcontrol5_exe1_cancel || mcontrol6_exe1_cancel || mcontrol7_exe1_cancel;
//if exe + exe chain match, need to cancel
assign exe1_chain0_match   = mcontrol0_exe1_match && mcontrol1_exe1_match && chain0_same_timing && m01_is_exe_chain;
assign exe1_chain1_match   = mcontrol1_exe1_match && mcontrol2_exe1_match && chain1_same_timing && m12_is_exe_chain;
assign exe1_chain2_match   = mcontrol2_exe1_match && mcontrol3_exe1_match && chain2_same_timing && m23_is_exe_chain;
assign exe1_chain3_match   = mcontrol3_exe1_match && mcontrol4_exe1_match && chain3_same_timing && m34_is_exe_chain;
assign exe1_chain4_match   = mcontrol4_exe1_match && mcontrol5_exe1_match && chain4_same_timing && m45_is_exe_chain;
assign exe1_chain5_match   = mcontrol5_exe1_match && mcontrol6_exe1_match && chain5_same_timing && m56_is_exe_chain;
assign exe1_chain6_match   = mcontrol6_exe1_match && mcontrol7_exe1_match && chain6_same_timing && m67_is_exe_chain;
assign exe1_chain_cancel   = exe1_chain0_match || exe1_chain1_match ||
                             exe1_chain2_match || exe1_chain3_match ||
                             exe1_chain4_match || exe1_chain5_match || 
                             exe1_chain6_match;
//after chain match
assign exe1_mcontrol0_single_match = mcontrol0_exe1_match && !m01_is_exe_chain;
assign exe1_after_chain_match0     = exe1_mcontrol0_single_match || exe1_chain0_match;

assign exe1_mcontrol1_single_match = mcontrol1_exe1_match && !(m01_is_exe_chain || m12_is_exe_chain);
assign exe1_after_chain_match1     = exe1_mcontrol1_single_match || exe1_chain0_match || exe1_chain1_match;

assign exe1_mcontrol2_single_match = mcontrol2_exe1_match && !(m12_is_exe_chain || m23_is_exe_chain);
assign exe1_after_chain_match2     = exe1_mcontrol2_single_match || exe1_chain1_match || exe1_chain2_match;

assign exe1_mcontrol3_single_match = mcontrol3_exe1_match && !(m23_is_exe_chain || m34_is_exe_chain);
assign exe1_after_chain_match3     = exe1_mcontrol3_single_match || exe1_chain2_match || exe1_chain3_match;

assign exe1_mcontrol4_single_match = mcontrol4_exe1_match && !(m34_is_exe_chain || m45_is_exe_chain);
assign exe1_after_chain_match4     = exe1_mcontrol4_single_match || exe1_chain3_match || exe1_chain4_match;

assign exe1_mcontrol5_single_match = mcontrol5_exe1_match && !(m45_is_exe_chain || m56_is_exe_chain);
assign exe1_after_chain_match5     = exe1_mcontrol5_single_match || exe1_chain4_match || exe1_chain5_match;

assign exe1_mcontrol6_single_match = mcontrol6_exe1_match && !(m56_is_exe_chain || m67_is_exe_chain);
assign exe1_after_chain_match6     = exe1_mcontrol6_single_match || exe1_chain5_match || exe1_chain6_match;

assign exe1_mcontrol7_single_match = mcontrol7_exe1_match && !m67_is_exe_chain;
assign exe1_after_chain_match7     = exe1_mcontrol7_single_match || exe1_chain6_match;

//assign exe1_after_chain_match0 = m01_is_exe_chain ? exe1_chain0_match : 
//                                                    mcontrol0_exe1_match;
//&CombBeg;
//  if(m01_is_exe_chain)
//    exe1_after_chain_match1 = exe1_chain0_match;
//  else if(m12_is_exe_chain)
//    exe1_after_chain_match1 = exe1_chain1_match;
//  else
//    exe1_after_chain_match1 = mcontrol1_exe1_match;
//&CombEnd;
//&CombBeg;
//  if(m12_is_exe_chain)
//    exe1_after_chain_match2 = exe1_chain1_match;
//  else if(m23_is_exe_chain)
//    exe1_after_chain_match2 = exe1_chain2_match;
//  else
//    exe1_after_chain_match2 = mcontrol2_exe1_match;
//&CombEnd;
//&CombBeg;
//  if(m23_is_exe_chain)
//    exe1_after_chain_match3 = exe1_chain2_match;
//  else if(m34_is_exe_chain)
//    exe1_after_chain_match3 = exe1_chain3_match;
//  else
//    exe1_after_chain_match3 = mcontrol3_exe1_match;
//&CombEnd;
//&CombBeg;
//  if(m34_is_exe_chain)
//    exe1_after_chain_match4 = exe1_chain3_match;
//  else if(m45_is_exe_chain)
//    exe1_after_chain_match4 = exe1_chain4_match;
//  else
//    exe1_after_chain_match4 = mcontrol4_exe1_match;
//&CombEnd;
//&CombBeg;
//  if(m45_is_exe_chain)
//    exe1_after_chain_match5 = exe1_chain4_match;
//  else if(m56_is_exe_chain)
//    exe1_after_chain_match5 = exe1_chain5_match;
//  else
//    exe1_after_chain_match5 = mcontrol5_exe1_match;
//&CombEnd;
//&CombBeg;
//  if(m56_is_exe_chain)
//    exe1_after_chain_match6 = exe1_chain5_match;
//  else if(m67_is_exe_chain)
//    exe1_after_chain_match6 = exe1_chain6_match;
//  else
//    exe1_after_chain_match6 = mcontrol6_exe1_match;
//&CombEnd;
//assign exe1_after_chain_match7 = m67_is_exe_chain ? exe1_chain6_match : 
//                                                    mcontrol7_exe1_match;
assign exe1_after_chain_match[7:0] ={exe1_after_chain_match7,exe1_after_chain_match6,
                                     exe1_after_chain_match5,exe1_after_chain_match4,
                                     exe1_after_chain_match3,exe1_after_chain_match2,
                                     exe1_after_chain_match1,exe1_after_chain_match0};
//priority select logic
assign m0_exe1_can_match = !(|(x_phigher_than_m0_reg[6:0] & exe1_after_chain_match[7:1]));
assign m1_exe1_can_match = !(|(x_phigher_than_m1_reg[6:0] & {exe1_after_chain_match[7:2],exe1_after_chain_match[0]}));
assign m2_exe1_can_match = !(|(x_phigher_than_m2_reg[6:0] & {exe1_after_chain_match[7:3],exe1_after_chain_match[1:0]}));
assign m3_exe1_can_match = !(|(x_phigher_than_m3_reg[6:0] & {exe1_after_chain_match[7:4],exe1_after_chain_match[2:0]}));
assign m4_exe1_can_match = !(|(x_phigher_than_m4_reg[6:0] & {exe1_after_chain_match[7:5],exe1_after_chain_match[3:0]}));
assign m5_exe1_can_match = !(|(x_phigher_than_m5_reg[6:0] & {exe1_after_chain_match[7:6],exe1_after_chain_match[4:0]}));
assign m6_exe1_can_match = !(|(x_phigher_than_m6_reg[6:0] & {exe1_after_chain_match[7],exe1_after_chain_match[5:0]}));
assign m7_exe1_can_match = !(|(x_phigher_than_m7_reg[6:0] & exe1_after_chain_match[6:0]));

assign m0_exe1_match     = m0_exe1_can_match && exe1_after_chain_match0;
assign m1_exe1_match     = m1_exe1_can_match && exe1_after_chain_match1;
assign m2_exe1_match     = m2_exe1_can_match && exe1_after_chain_match2;
assign m3_exe1_match     = m3_exe1_can_match && exe1_after_chain_match3;
assign m4_exe1_match     = m4_exe1_can_match && exe1_after_chain_match4;
assign m5_exe1_match     = m5_exe1_can_match && exe1_after_chain_match5;
assign m6_exe1_match     = m6_exe1_can_match && exe1_after_chain_match6;
assign m7_exe1_match     = m7_exe1_can_match && exe1_after_chain_match7;

//output select
//match
assign exe1_match[7:0]    = {m7_exe1_match,m6_exe1_match,m5_exe1_match,m4_exe1_match,
                             m3_exe1_match,m2_exe1_match,m1_exe1_match,m0_exe1_match};
assign exe1_have_match    = exe1_cancel;  
//chain
assign m0_exe1_chain      = m0_exe1_match && m0_exe_chain_modify;
assign m1_exe1_chain      = m1_exe1_match && m1_exe_chain_modify;
assign m2_exe1_chain      = m2_exe1_match && m2_exe_chain_modify;
assign m3_exe1_chain      = m3_exe1_match && m3_exe_chain_modify;
assign m4_exe1_chain      = m4_exe1_match && m4_exe_chain_modify;
assign m5_exe1_chain      = m5_exe1_match && m5_exe_chain_modify;
assign m6_exe1_chain      = m6_exe1_match && m6_exe_chain_modify;
assign m7_exe1_chain      = m7_exe1_match && m7_exe_chain_modify;
assign exe1_chain         = m7_exe1_chain || m6_exe1_chain || m5_exe1_chain || m4_exe1_chain ||
                            m3_exe1_chain || m2_exe1_chain || m1_exe1_chain || m0_exe1_chain;
//action0
assign m0_exe1_action0      = m0_exe1_match && mcontrol0_action0;
assign m1_exe1_action0      = m1_exe1_match && mcontrol1_action0;
assign m2_exe1_action0      = m2_exe1_match && mcontrol2_action0;
assign m3_exe1_action0      = m3_exe1_match && mcontrol3_action0;
assign m4_exe1_action0      = m4_exe1_match && mcontrol4_action0;
assign m5_exe1_action0      = m5_exe1_match && mcontrol5_action0;
assign m6_exe1_action0      = m6_exe1_match && mcontrol6_action0;
assign m7_exe1_action0      = m7_exe1_match && mcontrol7_action0;
assign exe1_action0         = m7_exe1_action0 || m6_exe1_action0 || m5_exe1_action0 || m4_exe1_action0 ||
                            m3_exe1_action0 || m2_exe1_action0 || m1_exe1_action0 || m0_exe1_action0;

//action1
assign m0_exe1_action1      = m0_exe1_match && mcontrol0_action1;
assign m1_exe1_action1      = m1_exe1_match && mcontrol1_action1;
assign m2_exe1_action1      = m2_exe1_match && mcontrol2_action1;
assign m3_exe1_action1      = m3_exe1_match && mcontrol3_action1;
assign m4_exe1_action1      = m4_exe1_match && mcontrol4_action1;
assign m5_exe1_action1      = m5_exe1_match && mcontrol5_action1;
assign m6_exe1_action1      = m6_exe1_match && mcontrol6_action1;
assign m7_exe1_action1      = m7_exe1_match && mcontrol7_action1;
assign exe1_action1         = m7_exe1_action1 || m6_exe1_action1 || m5_exe1_action1 || m4_exe1_action1 ||
                            m3_exe1_action1 || m2_exe1_action1 || m1_exe1_action1 || m0_exe1_action1;

assign exe1_action        = !exe1_action0 && exe1_action1;
assign exe1_action01      = exe1_action0 && exe1_action1;

//timing
assign exe1_timing         = 1'b0;

//cancel
assign exe1_cancel        = exe1_single_mcontrol_cancel || exe1_chain_cancel;

assign mcontrol_halt_info1[`TDT_HINFO_WIDTH-1:0] = {exe1_match[7:0],{`TDT_TM_OTHER_TRI_NUM{1'b0}},4'd2,1'b0,
                                                   exe1_timing,exe1_action01,exe1_action,
                                                   exe1_chain,1'b0,exe1_have_match,exe1_cancel};

//---------------------------------------------------------
//                    ldst output select logic
//---------------------------------------------------------
//assign ldst_chain0_data = (mcontrol1_is_ldst_data || mcontrol0_is_ldst_data) && chain0_on; 
//assign ldst_chain1_data = (mcontrol2_is_ldst_data || mcontrol1_is_ldst_data) && chain1_on;
//assign ldst_chain2_data = (mcontrol3_is_ldst_data || mcontrol2_is_ldst_data) && chain2_on;
//assign ldst_chain3_data = (mcontrol4_is_ldst_data || mcontrol3_is_ldst_data) && chain3_on;
//assign ldst_chain4_data = (mcontrol5_is_ldst_data || mcontrol4_is_ldst_data) && chain4_on;
//assign ldst_chain5_data = (mcontrol6_is_ldst_data || mcontrol5_is_ldst_data) && chain5_on;
//assign ldst_chain6_data = (mcontrol7_is_ldst_data || mcontrol6_is_ldst_data) && chain6_on;
//assign have_ldst_data_chain = ldst_chain0_data || ldst_chain1_data || ldst_chain2_data || ldst_chain3_data ||
//                                  ldst_chain4_data || ldst_chain5_data || ldst_chain6_data;
//
assign mcontrol0_store_data_timing0 = mcontrol0_is_ldst_data && !mcontrol0_timing;
assign mcontrol1_store_data_timing0 = mcontrol1_is_ldst_data && !mcontrol1_timing;
assign mcontrol2_store_data_timing0 = mcontrol2_is_ldst_data && !mcontrol2_timing;
assign mcontrol3_store_data_timing0 = mcontrol3_is_ldst_data && !mcontrol3_timing;
assign mcontrol4_store_data_timing0 = mcontrol4_is_ldst_data && !mcontrol4_timing;
assign mcontrol5_store_data_timing0 = mcontrol5_is_ldst_data && !mcontrol5_timing;
assign mcontrol6_store_data_timing0 = mcontrol6_is_ldst_data && !mcontrol6_timing;
assign mcontrol7_store_data_timing0 = mcontrol7_is_ldst_data && !mcontrol7_timing;
assign have_store_data_timing0      = mcontrol0_store_data_timing0 || mcontrol1_store_data_timing0 || mcontrol2_store_data_timing0 || mcontrol3_store_data_timing0 ||
                                      mcontrol4_store_data_timing0 || mcontrol5_store_data_timing0 || mcontrol6_store_data_timing0 || mcontrol7_store_data_timing0;

//chain match logic
assign ldst_chain0_match   = mcontrol0_ldst_match && mcontrol1_ldst_match && chain0_same_timing && chain0_on;
assign ldst_chain1_match   = mcontrol1_ldst_match && mcontrol2_ldst_match && chain1_same_timing && chain1_on;
assign ldst_chain2_match   = mcontrol2_ldst_match && mcontrol3_ldst_match && chain2_same_timing && chain2_on;
assign ldst_chain3_match   = mcontrol3_ldst_match && mcontrol4_ldst_match && chain3_same_timing && chain3_on;
assign ldst_chain4_match   = mcontrol4_ldst_match && mcontrol5_ldst_match && chain4_same_timing && chain4_on;
assign ldst_chain5_match   = mcontrol5_ldst_match && mcontrol6_ldst_match && chain5_same_timing && chain5_on;
assign ldst_chain6_match   = mcontrol6_ldst_match && mcontrol7_ldst_match && chain6_same_timing && chain6_on;
//after chain match
assign ldst_mcontrol0_single_match = mcontrol0_ldst_match && !chain0_on;
assign ldst_after_chain_match0     = ldst_mcontrol0_single_match || ldst_chain0_match;

assign ldst_mcontrol1_single_match = mcontrol1_ldst_match && !(chain0_on || chain1_on);
assign ldst_after_chain_match1     = ldst_mcontrol1_single_match || ldst_chain0_match || ldst_chain1_match;

assign ldst_mcontrol2_single_match = mcontrol2_ldst_match && !(chain1_on || chain2_on);
assign ldst_after_chain_match2     = ldst_mcontrol2_single_match || ldst_chain1_match || ldst_chain2_match;

assign ldst_mcontrol3_single_match = mcontrol3_ldst_match && !(chain2_on || chain3_on);
assign ldst_after_chain_match3     = ldst_mcontrol3_single_match || ldst_chain2_match || ldst_chain3_match;

assign ldst_mcontrol4_single_match = mcontrol4_ldst_match && !(chain3_on || chain4_on);
assign ldst_after_chain_match4     = ldst_mcontrol4_single_match || ldst_chain3_match || ldst_chain4_match;

assign ldst_mcontrol5_single_match = mcontrol5_ldst_match && !(chain4_on || chain5_on);
assign ldst_after_chain_match5     = ldst_mcontrol5_single_match || ldst_chain4_match || ldst_chain5_match;

assign ldst_mcontrol6_single_match = mcontrol6_ldst_match && !(chain5_on || chain6_on);
assign ldst_after_chain_match6     = ldst_mcontrol6_single_match || ldst_chain5_match || ldst_chain6_match;

assign ldst_mcontrol7_single_match = mcontrol7_ldst_match && !chain6_on;
assign ldst_after_chain_match7     = ldst_mcontrol7_single_match || ldst_chain6_match;

//timing0 match
assign ldst_mcontrol0_timing0_match = mcontrol0_is_ldst && !mcontrol0_timing && ldst_mcontrol0_single_match;
assign ldst_mcontrol1_timing0_match = mcontrol1_is_ldst && !mcontrol1_timing && ldst_mcontrol1_single_match;
assign ldst_mcontrol2_timing0_match = mcontrol2_is_ldst && !mcontrol2_timing && ldst_mcontrol2_single_match;
assign ldst_mcontrol3_timing0_match = mcontrol3_is_ldst && !mcontrol3_timing && ldst_mcontrol3_single_match;
assign ldst_mcontrol4_timing0_match = mcontrol4_is_ldst && !mcontrol4_timing && ldst_mcontrol4_single_match;
assign ldst_mcontrol5_timing0_match = mcontrol5_is_ldst && !mcontrol5_timing && ldst_mcontrol5_single_match;
assign ldst_mcontrol6_timing0_match = mcontrol6_is_ldst && !mcontrol6_timing && ldst_mcontrol6_single_match;
assign ldst_mcontrol7_timing0_match = mcontrol7_is_ldst && !mcontrol7_timing && ldst_mcontrol7_single_match;

assign chain0_timing0_match = (mcontrol0_is_ldst ? !mcontrol0_timing : !mcontrol1_timing) && ldst_chain0_match;
assign chain1_timing0_match = (mcontrol1_is_ldst ? !mcontrol1_timing : !mcontrol2_timing) && ldst_chain1_match;
assign chain2_timing0_match = (mcontrol2_is_ldst ? !mcontrol2_timing : !mcontrol3_timing) && ldst_chain2_match;
assign chain3_timing0_match = (mcontrol3_is_ldst ? !mcontrol3_timing : !mcontrol4_timing) && ldst_chain3_match;
assign chain4_timing0_match = (mcontrol4_is_ldst ? !mcontrol4_timing : !mcontrol5_timing) && ldst_chain4_match;
assign chain5_timing0_match = (mcontrol5_is_ldst ? !mcontrol5_timing : !mcontrol6_timing) && ldst_chain5_match;
assign chain6_timing0_match = (mcontrol6_is_ldst ? !mcontrol6_timing : !mcontrol7_timing) && ldst_chain6_match;


assign timing0_match[7:0] = {ldst_mcontrol7_timing0_match || chain6_timing0_match,
                             ldst_mcontrol6_timing0_match || chain6_timing0_match || chain5_timing0_match,
                             ldst_mcontrol5_timing0_match || chain5_timing0_match || chain4_timing0_match,
                             ldst_mcontrol4_timing0_match || chain4_timing0_match || chain3_timing0_match,
                             ldst_mcontrol3_timing0_match || chain3_timing0_match || chain2_timing0_match,
                             ldst_mcontrol2_timing0_match || chain2_timing0_match || chain1_timing0_match,
                             ldst_mcontrol1_timing0_match || chain1_timing0_match || chain0_timing0_match,
                             ldst_mcontrol0_timing0_match || chain0_timing0_match};

assign have_timing0_match = |timing0_match[7:0];


assign ldst_after_chain_match[7:0] ={ldst_after_chain_match7,ldst_after_chain_match6,
                                     ldst_after_chain_match5,ldst_after_chain_match4,
                                     ldst_after_chain_match3,ldst_after_chain_match2,
                                     ldst_after_chain_match1,ldst_after_chain_match0};

//priority select logic
assign m0_ldst_can_match = !(|(x_thigher_than_m0_reg[6:0] & ldst_after_chain_match[7:1]));
assign m1_ldst_can_match = !(|(x_thigher_than_m1_reg[6:0] & {ldst_after_chain_match[7:2],ldst_after_chain_match[0]}));
assign m2_ldst_can_match = !(|(x_thigher_than_m2_reg[6:0] & {ldst_after_chain_match[7:3],ldst_after_chain_match[1:0]}));
assign m3_ldst_can_match = !(|(x_thigher_than_m3_reg[6:0] & {ldst_after_chain_match[7:4],ldst_after_chain_match[2:0]}));
assign m4_ldst_can_match = !(|(x_thigher_than_m4_reg[6:0] & {ldst_after_chain_match[7:5],ldst_after_chain_match[3:0]}));
assign m5_ldst_can_match = !(|(x_thigher_than_m5_reg[6:0] & {ldst_after_chain_match[7:6],ldst_after_chain_match[4:0]}));
assign m6_ldst_can_match = !(|(x_thigher_than_m6_reg[6:0] & {ldst_after_chain_match[7],ldst_after_chain_match[5:0]}));
assign m7_ldst_can_match = !(|(x_thigher_than_m7_reg[6:0] & ldst_after_chain_match[6:0]));

assign m0_ldst_match     = m0_ldst_can_match && ldst_after_chain_match[0];
assign m1_ldst_match     = m1_ldst_can_match && ldst_after_chain_match[1];
assign m2_ldst_match     = m2_ldst_can_match && ldst_after_chain_match[2];
assign m3_ldst_match     = m3_ldst_can_match && ldst_after_chain_match[3];
assign m4_ldst_match     = m4_ldst_can_match && ldst_after_chain_match[4];
assign m5_ldst_match     = m5_ldst_can_match && ldst_after_chain_match[5];
assign m6_ldst_match     = m6_ldst_can_match && ldst_after_chain_match[6];
assign m7_ldst_match     = m7_ldst_can_match && ldst_after_chain_match[7];

//output select
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      lsu_dtu_last_check_f <= 1'b0;
  else if(lsu_dtu_last_check)
      lsu_dtu_last_check_f <= 1'b1;
  else if(lsu_dtu_last_check_f)
      lsu_dtu_last_check_f <= 1'b0;
end

assign need_match_store_data_t0_trigger = have_store_data_timing0 && store_addr_vld; 
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      need_match_store_data_t0_trigger_f <= 1'b0;
  else if(need_match_store_data_t0_trigger)
      need_match_store_data_t0_trigger_f <= 1'b1;
  else if(need_match_store_data_t0_trigger_f)
      need_match_store_data_t0_trigger_f <= 1'b0;
end

//match
// &CombBeg; @2718
always @( mcontrol5_ldst_match
       or mcontrol4_ldst_match
       or m1_ldst_match
       or lsu_dtu_last_check_f
       or m0_ldst_match
       or need_match_store_data_t0_trigger_f
       or m6_ldst_match
       or mcontrol6_ldst_match
       or mcontrol3_ldst_match
       or mcontrol1_ldst_match
       or m5_ldst_match
       or m3_ldst_match
       or timing0_match[7:0]
       or m4_ldst_match
       or have_timing0_match
       or m7_ldst_match
       or mcontrol0_ldst_match
       or m2_ldst_match
       or mcontrol7_ldst_match
       or mcontrol2_ldst_match)
begin
if(lsu_dtu_last_check_f)
    ldst_match[7:0] = {m7_ldst_match,m6_ldst_match,m5_ldst_match,m4_ldst_match,
                       m3_ldst_match,m2_ldst_match,m1_ldst_match,m0_ldst_match};
else if(have_timing0_match && !need_match_store_data_t0_trigger_f)
    ldst_match[7:0] = timing0_match[7:0];
else
    ldst_match[7:0] = {mcontrol7_ldst_match,mcontrol6_ldst_match,mcontrol5_ldst_match,mcontrol4_ldst_match,
                       mcontrol3_ldst_match,mcontrol2_ldst_match,mcontrol1_ldst_match,mcontrol0_ldst_match};
// &CombEnd; @2727
end

assign ldst_have_match = |ldst_after_chain_match[7:0];

//action0
assign m0_ldst_action0      = m0_ldst_match && mcontrol0_action0;
assign m1_ldst_action0      = m1_ldst_match && mcontrol1_action0;
assign m2_ldst_action0      = m2_ldst_match && mcontrol2_action0;
assign m3_ldst_action0      = m3_ldst_match && mcontrol3_action0;
assign m4_ldst_action0      = m4_ldst_match && mcontrol4_action0;
assign m5_ldst_action0      = m5_ldst_match && mcontrol5_action0;
assign m6_ldst_action0      = m6_ldst_match && mcontrol6_action0;
assign m7_ldst_action0      = m7_ldst_match && mcontrol7_action0;
assign ldst_action0         = m7_ldst_action0 || m6_ldst_action0 || m5_ldst_action0 || m4_ldst_action0 ||
                              m3_ldst_action0 || m2_ldst_action0 || m1_ldst_action0 || m0_ldst_action0;

//action1
assign m0_ldst_action1      = m0_ldst_match && mcontrol0_action1;
assign m1_ldst_action1      = m1_ldst_match && mcontrol1_action1;
assign m2_ldst_action1      = m2_ldst_match && mcontrol2_action1;
assign m3_ldst_action1      = m3_ldst_match && mcontrol3_action1;
assign m4_ldst_action1      = m4_ldst_match && mcontrol4_action1;
assign m5_ldst_action1      = m5_ldst_match && mcontrol5_action1;
assign m6_ldst_action1      = m6_ldst_match && mcontrol6_action1;
assign m7_ldst_action1      = m7_ldst_match && mcontrol7_action1;
assign ldst_action1         = m7_ldst_action1 || m6_ldst_action1 || m5_ldst_action1 || m4_ldst_action1 ||
                              m3_ldst_action1 || m2_ldst_action1 || m1_ldst_action1 || m0_ldst_action1;

assign ldst_action        = !ldst_action0 && ldst_action1;
assign ldst_action01      = ldst_action0 && ldst_action1;

//timing
assign m0_ldst_timing      = m0_ldst_match && mcontrol0_timing;
assign m1_ldst_timing      = m1_ldst_match && mcontrol1_timing;
assign m2_ldst_timing      = m2_ldst_match && mcontrol2_timing;
assign m3_ldst_timing      = m3_ldst_match && mcontrol3_timing;
assign m4_ldst_timing      = m4_ldst_match && mcontrol4_timing;
assign m5_ldst_timing      = m5_ldst_match && mcontrol5_timing;
assign m6_ldst_timing      = m6_ldst_match && mcontrol6_timing;
assign m7_ldst_timing      = m7_ldst_match && mcontrol7_timing;
assign ldst_timing         = m7_ldst_timing || m6_ldst_timing || m5_ldst_timing || m4_ldst_timing ||
                             m3_ldst_timing || m2_ldst_timing || m1_ldst_timing || m0_ldst_timing;

//cancel
// &CombBeg; @2771
always @( lsu_dtu_last_check_f
       or need_match_store_data_t0_trigger_f
       or ldst_have_match
       or have_timing0_match
       or ldst_timing)
begin
//assign ldst_cancel        = !ldst_timing && ldst_have_match;
if(lsu_dtu_last_check_f)
    ldst_cancel =  !ldst_timing && ldst_have_match;
else if(have_timing0_match && !need_match_store_data_t0_trigger_f)
    ldst_cancel = 1'b1;   
else
    ldst_cancel = 1'b0;
// &CombEnd; @2779
end

assign dtu_lsu_halt_info[`TDT_HINFO_WIDTH-1:0] = {ldst_match[7:0],{`TDT_TM_OTHER_TRI_NUM{1'b0}},4'd2,1'b0,
                                                   ldst_timing,ldst_action01,ldst_action,
                                                   1'b0,1'b1,ldst_have_match,ldst_cancel};


//==========================================================
//                     gate clk
//==========================================================
always @(posedge mcontrol_output_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     cp0_write_tdata1_f <= 1'b0;
  else
     cp0_write_tdata1_f <= cp0_write_tdata1;
end
// &Force("nonport","cp0_write_tdata1_f"); @2805


assign mcontrol_output_clk_en = cp0_write_tdata1 || cp0_write_tdata1_f ||
                                exe_may_hit || ldst_may_hit || 
                                exe_cycle2_cannot_hit || ldst_cycle2_cannot_hit ||
                                lsu_dtu_last_check || lsu_dtu_last_check_f ||
                                need_match_store_data_t0_trigger || need_match_store_data_t0_trigger_f;
// &Force("nonport","mcontrol_output_clk_en"); @2813

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @2815
gated_clk_cell  x_reg_gated_clk (
  .clk_in                 (forever_cpuclk        ),
  .clk_out                (mcontrol_output_clk   ),
  .external_en            (1'b0                  ),
  .global_en              (cp0_yy_clk_en         ),
  .local_en               (mcontrol_output_clk_en),
  .module_en              (cp0_dtu_icg_en        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    )
);

// &Connect(.clk_in      (forever_cpuclk), @2816
//          .external_en (1'b0), @2817
//          .global_en   (cp0_yy_clk_en), @2818
//          .module_en   (cp0_dtu_icg_en), @2819
//          .local_en    (mcontrol_output_clk_en), @2820
//          //.local_en    (1'b1), @2821
//          .clk_out     (mcontrol_output_clk)); @2822

// &ModuleEnd; @2825
endmodule


