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
module aq_dtu_mcontrol(
  already_match,
  cp0_dtu_icg_en,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_write_tdata1,
  cp0_write_tdata2,
  cp0_write_tdata3,
  cp0_yy_clk_en,
  cpurst_b,
  exe0_16bit,
  exe0_32bit,
  exe0_match,
  exe0_may_hit,
  exe1_16bit,
  exe1_32bit,
  exe1_match,
  exe1_may_hit,
  exe_mcontrol,
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
  ldst_match,
  ldst_may_hit,
  ldst_mcontrol,
  load_addr_vld,
  load_data_vld,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  m_mode,
  mcontext,
  mpriority,
  mpriority_mask,
  mtiming,
  mtiming_mask,
  next_trigger_chain,
  next_trigger_dmode,
  pad_yy_icg_scan_en,
  previous_trigger_chian,
  previous_trigger_dmode,
  rtu_yy_xx_dbgon,
  s_mode,
  scontext,
  set_trigger_hit,
  store_addr_vld,
  store_data_vld,
  tcontrol,
  tdata1,
  tdata1_action0,
  tdata1_action1,
  tdata1_chain,
  tdata1_dmode,
  tdata1_timing,
  tdata2,
  tdata3,
  tinfo,
  trigger_selected,
  u_mode
);

// &Ports; @21
input           already_match;                              
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
input   [39:0]  lsu_dtu_ldst_addr;                          
input           lsu_dtu_ldst_addr_vld;                      
input   [15:0]  lsu_dtu_ldst_bytes_vld;                     
input   [63:0]  lsu_dtu_ldst_data;                          
input           lsu_dtu_ldst_data_vld;                      
input           m_mode;                                     
input   [63:0]  mcontext;                                   
input           next_trigger_chain;                         
input           next_trigger_dmode;                         
input           pad_yy_icg_scan_en;                         
input           previous_trigger_chian;                     
input           previous_trigger_dmode;                     
input           rtu_yy_xx_dbgon;                            
input           s_mode;                                     
input   [63:0]  scontext;                                   
input           set_trigger_hit;                            
input           store_addr_vld;                             
input           store_data_vld;                             
input   [63:0]  tcontrol;                                   
input           trigger_selected;                           
input           u_mode;                                     
output          exe0_match;                                 
output          exe0_may_hit;                               
output          exe1_match;                                 
output          exe1_may_hit;                               
output          exe_mcontrol;                               
output          ldst_addr_mcontrol;                         
output          ldst_data_mcontrol;                         
output          ldst_match;                                 
output          ldst_may_hit;                               
output          ldst_mcontrol;                              
output  [1 :0]  mpriority;                                  
output  [1 :0]  mpriority_mask;                             
output  [1 :0]  mtiming;                                    
output  [1 :0]  mtiming_mask;                               
output  [63:0]  tdata1;                                     
output          tdata1_action0;                             
output          tdata1_action1;                             
output          tdata1_chain;                               
output          tdata1_dmode;                               
output          tdata1_timing;                              
output  [63:0]  tdata2;                                     
output  [63:0]  tdata3;                                     
output  [63:0]  tinfo;                                      

// &Regs; @22
reg             dmode_legal;                                
reg             exe0_match;                                 
reg             exe1_match;                                 
reg             ldst_match;                                 
reg     [3 :0]  m_mask_four_bits;                           
reg     [7 :0]  m_mask_reg;                                 
reg             match_ldst_addr;                            
reg     [1 :0]  mpriority;                                  
reg     [1 :0]  mpriority_mask;                             
reg             scontext_enable;                            
reg             size1;                                      
reg             size2;                                      
reg             size3;                                      
reg     [63:0]  size_mask;                                  
reg     [0 :0]  tdata1_action;                              
reg             tdata1_chain;                               
reg             tdata1_dmode;                               
reg             tdata1_execute;                             
reg             tdata1_hit;                                 
reg             tdata1_load;                                
reg             tdata1_m;                                   
reg     [3 :0]  tdata1_match;                               
reg             tdata1_s;                                   
reg             tdata1_select;                              
reg     [1 :0]  tdata1_sizehi;                              
reg     [1 :0]  tdata1_sizelo;                              
reg             tdata1_store;                               
reg             tdata1_timing;                              
reg             tdata1_u;                                   
reg     [63:0]  tdata2;                                     
reg     [15:0]  tdata2_ldst_bytes_vld;                      
reg     [15:0]  tdata2_ldst_bytes_vld_0;                    
reg     [15:0]  tdata2_ldst_bytes_vld_for_match1;           
reg     [7 :0]  tdata2_ldst_bytes_vld_for_match1_eight_bits; 
reg     [15:0]  tdata2_ldst_bytes_vld_for_match4;           
reg     [3 :0]  tdata2_ldst_bytes_vld_four_bits;            
reg     [15:0]  tdata2_ldst_bytes_vld_greater;              
reg     [3 :0]  tdata2_ldst_bytes_vld_greater_four_bits;    
reg     [15:0]  tdata2_ldst_bytes_vld_less;                 
reg     [3 :0]  tdata2_ldst_bytes_vld_less_bits_four_bits;  
reg     [15:0]  tdata2_ldst_bytes_vld_reg_0;                
reg             tdata3_mselect;                             
reg     [12:0]  tdata3_mvalue;                              
reg     [1 :0]  tdata3_sselect;                             
reg     [33:0]  tdata3_svalue;                              
reg             write_tdata1_f;                             
reg             write_tdata2_f;                             

// &Wires; @23
wire            action_is_legal;                            
wire            action_legal;                               
wire            already_match;                              
wire            bytes_vld_match;                            
wire            chain_is_legal;                             
wire            chain_legal;                                
wire            cp0_dtu_icg_en;                             
wire    [63:0]  cp0_dtu_satp;                               
wire    [63:0]  cp0_dtu_wdata;                              
wire            cp0_write_tdata1;                           
wire            cp0_write_tdata2;                           
wire            cp0_write_tdata3;                           
wire            cp0_yy_clk_en;                              
wire            cpurst_b;                                   
wire            exe0_16bit;                                 
wire            exe0_32bit;                                 
wire            exe0_greater_than_tdata2;                   
wire            exe0_have_value_match0;                     
wire            exe0_have_value_match1;                     
wire            exe0_have_value_match2;                     
wire            exe0_have_value_match3;                     
wire            exe0_have_value_match4;                     
wire            exe0_have_value_match5;                     
wire            exe0_match_equal;                           
wire            exe0_match_greater;                         
wire            exe0_match_less;                            
wire            exe0_match_need_reg;                        
wire            exe0_match_top_mbits_equal;                 
wire            exe0_match_value_lower_half;                
wire            exe0_match_value_upper_half;                
wire            exe0_may_hit;                               
wire            exe0_size_match;                            
wire            exe0_type_match;                            
wire            exe0_type_size_match;                       
wire    [63:0]  exe0_value;                                 
wire    [63:0]  exe0_value_before_size_mask;                
wire    [31:0]  exe0_value_lower_half;                      
wire    [7 :0]  exe0_value_masked_low_8bis;                 
wire            exe0_value_match;                           
wire            exe0_value_match_for_may_hit;               
wire    [63:0]  exe0_value_top_mbits;                       
wire    [31:0]  exe0_value_upper_half;                      
wire            exe1_16bit;                                 
wire            exe1_32bit;                                 
wire            exe1_greater_than_tdata2;                   
wire            exe1_have_value_match0;                     
wire            exe1_have_value_match1;                     
wire            exe1_have_value_match2;                     
wire            exe1_have_value_match3;                     
wire            exe1_have_value_match4;                     
wire            exe1_have_value_match5;                     
wire            exe1_match_equal;                           
wire            exe1_match_greater;                         
wire            exe1_match_less;                            
wire            exe1_match_need_reg;                        
wire            exe1_match_top_mbits_equal;                 
wire            exe1_match_value_lower_half;                
wire            exe1_match_value_upper_half;                
wire            exe1_may_hit;                               
wire            exe1_size_match;                            
wire            exe1_type_match;                            
wire            exe1_type_size_match;                       
wire    [63:0]  exe1_value;                                 
wire    [63:0]  exe1_value_before_size_mask;                
wire    [31:0]  exe1_value_lower_half;                      
wire    [7 :0]  exe1_value_masked_low_8bis;                 
wire            exe1_value_match;                           
wire            exe1_value_match_for_may_hit;               
wire    [63:0]  exe1_value_top_mbits;                       
wire    [31:0]  exe1_value_upper_half;                      
wire            exe_addr_mcontrol;                          
wire            exe_data_mcontrol;                          
wire            exe_mcontrol;                               
wire            exe_size_is_legal;                          
wire    [63:0]  extend_exe_data0;                           
wire    [63:0]  extend_exe_data1;                           
wire            forever_cpuclk;                             
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
wire            ldst_addr_greater_than_tdata2;              
wire            ldst_addr_less_than_tdata2;                 
wire            ldst_addr_lower_half_match;                 
wire            ldst_addr_match_equal;                      
wire            ldst_addr_mcontrol;                         
wire            ldst_addr_top_mbits_equal;                  
wire            ldst_bytes_greater_than_tdata2;             
wire            ldst_bytes_less_than_tdata2;                
wire            ldst_bytes_vld_equal;                       
wire            ldst_bytes_vld_lower_half_and;              
wire            ldst_bytes_vld_mbits_equal;                 
wire            ldst_data_mcontrol;                         
wire            ldst_have_value_match0;                     
wire            ldst_have_value_match1;                     
wire            ldst_have_value_match2;                     
wire            ldst_have_value_match3;                     
wire            ldst_have_value_match4;                     
wire            ldst_have_value_match5;                     
wire    [7 :0]  ldst_m_mask;                                
wire            ldst_match_equal;                           
wire            ldst_match_greater;                         
wire            ldst_match_less;                            
wire            ldst_match_need_reg;                        
wire            ldst_match_need_reg_for_may_hit;            
wire            ldst_match_top_mbits_equal;                 
wire            ldst_match_value_lower_half;                
wire            ldst_match_value_upper_half;                
wire            ldst_may_hit;                               
wire            ldst_mcontrol;                              
wire            ldst_mcontrol_match;                        
wire            ldst_mcontrol_match_for_may_hit;            
wire            ldst_size_is_legal;                         
wire            ldst_size_match;                            
wire            ldst_top_equal_bytes_greater_tdata2;        
wire            ldst_top_equal_bytes_less_tdata2;           
wire            ldst_type_match;                            
wire            ldst_type_size_match;                       
wire    [63:0]  ldst_value;                                 
wire    [63:0]  ldst_value_before_size_mask;                
wire            ldst_value_equal;                           
wire            ldst_value_greater_equal_tdata2;            
wire            ldst_value_greater_than_tdata2;             
wire            ldst_value_less_than_tdata2;                
wire    [31:0]  ldst_value_lower_half;                      
wire            ldst_value_lower_half_and;                  
wire    [7 :0]  ldst_value_masked_low_8bis;                 
wire            ldst_value_match;                           
wire            ldst_value_match_for_may_hit;               
wire    [63:0]  ldst_value_top_mbits;                       
wire            ldst_value_top_mbits_equal;                 
wire    [31:0]  ldst_value_upper_half;                      
wire            load_addr_mcontrol;                         
wire            load_addr_vld;                              
wire            load_data_mcontrol;                         
wire            load_data_trigger;                          
wire            load_data_vld;                              
wire    [39:0]  lsu_dtu_ldst_addr;                          
wire            lsu_dtu_ldst_addr_vld;                      
wire    [15:0]  lsu_dtu_ldst_bytes_vld;                     
wire    [63:0]  lsu_dtu_ldst_data;                          
wire            lsu_dtu_ldst_data_vld;                      
wire            lsu_have_bytes_vld;                         
wire            m_enable;                                   
wire    [7 :0]  m_mask;                                     
wire            m_mode;                                     
wire    [5 :0]  maskmax;                                    
wire            match_is_legal;                             
wire    [3 :0]  match_legal;                                
wire    [63:0]  mcontext;                                   
wire            mcontext_enable;                            
wire            mcontext_must_match;                        
wire            mcontrol_clk;                               
wire            mcontrol_clk_en;                            
wire            ms_context_enable;                          
wire            msu_mode_enable;                            
wire    [1 :0]  mtiming;                                    
wire    [1 :0]  mtiming_mask;                               
wire            next_trigger_chain;                         
wire            next_trigger_dmode;                         
wire            not_dbg_mode_enable;                        
wire            pad_yy_icg_scan_en;                         
wire            previous_trigger_chian;                     
wire            previous_trigger_dmode;                     
wire            rtu_yy_xx_dbgon;                            
wire            s_enable;                                   
wire            s_mode;                                     
wire    [63:0]  scontext;                                   
wire            set_trigger_hit;                            
wire            size_is_legal;                              
wire    [3 :0]  size_legal;                                 
wire    [1 :0]  sselect_legal;                              
wire            store_addr_mcontrol;                        
wire            store_addr_vld;                             
wire            store_data_mcontrol;                        
wire            store_data_vld;                             
wire    [63:0]  tcontrol;                                   
wire            tcontrol_enable;                            
wire    [63:0]  tdata1;                                     
wire            tdata1_action0;                             
wire            tdata1_action1;                             
wire    [3 :0]  tdata1_size;                                
wire    [3 :0]  tdata2_4bits_value_for_m_mask;              
wire    [31:0]  tdata2_exe_value_lower_half;                
wire    [7 :0]  tdata2_exe_value_masked_low_8bits;          
wire    [63:0]  tdata2_exe_value_top_mbits;                 
wire    [31:0]  tdata2_exe_value_upper_half;                
wire    [7 :0]  tdata2_ldst_addr_masked_low_8bits;          
wire    [7 :0]  tdata2_ldst_data_masked_low_8bits;          
wire    [31:0]  tdata2_ldst_value_lower_half_match4;        
wire    [31:0]  tdata2_ldst_value_lower_half_match5;        
wire    [63:0]  tdata2_ldst_value_top_mbits;                
wire    [31:0]  tdata2_ldst_value_upper_half_match4;        
wire    [31:0]  tdata2_ldst_value_upper_half_match5;        
wire    [31:0]  tdata2_lower_half_value_size_masked;        
wire    [31:0]  tdata2_upper_half_value_size_masked;        
wire    [63:0]  tdata2_value;                               
wire    [63:0]  tdata2_value_before_size_mask;              
wire    [63:0]  tdata3;                                     
wire            tdata_writable;                             
wire            timing_exe_or_wdata;                        
wire            timing_legal;                               
wire    [63:0]  tinfo;                                      
wire            tri_already_match;                          
wire            trigger_enable;                             
wire            trigger_selected;                           
wire    [3 :0]  type_legal;                                 
wire            u_enable;                                   
wire            u_mode;                                     
wire    [3 :0]  wdata_tdata1_size;                          
wire            write_tdata1;                               
wire            write_tdata2;                               
wire            zero_lsb_higher_than_4;                     


//XLEN
parameter XLEN       = `TDT_DM_CORE_MAX_XLEN;
//parameter (`TDT_DM_CORE_HALF_XLEN)  = (`TDT_DM_CORE_HALF_XLEN);

//tdata1 parameter
parameter TYPE       = XLEN-1;
parameter DMODE      = XLEN-5;

//mcontrol parameter
parameter SIZEHI     = 22;
parameter HIT        = 20;
parameter SELECT     = 19;
parameter TIMING     = 18;
parameter SIZELO     = 17;
parameter ACTION     = 15;
parameter CHAIN      = 11;
parameter MATCH      = 10;
parameter M          = 6;
parameter S          = 4;
parameter U          = 3;
parameter EXECUTE    = 2;
parameter STORE      = 1;
parameter LOAD       = 0;

//tdata3 parameter
parameter MVALUE     = 63;
parameter MSELECT    = 50;
parameter SVALUE     = 35;
parameter SSELECT    = 1;

//tcontrol parameter
//parameter MPTE       = 7;
parameter MTE        = 3;

//=========================================================
//
//                       tdata1 wdata legalization
//
//=========================================================

//type
assign type_legal[3:0] = 4'd2;//mcontrol type = 2

//dmode
// &CombBeg; @69
always @( rtu_yy_xx_dbgon
       or tdata1[59]
       or previous_trigger_dmode
       or cp0_dtu_wdata[59]
       or previous_trigger_chian)
begin
if(!rtu_yy_xx_dbgon)//dmode only writable in debug mode
  dmode_legal = tdata1[DMODE]; 
else if(!previous_trigger_dmode && previous_trigger_chian)
  dmode_legal = 1'b0;
else
  dmode_legal = cp0_dtu_wdata[DMODE];
// &CombEnd; @76
end

//---------------------------------------------------------
//                 mcontrol tdata1 wdata legalization
//---------------------------------------------------------
//size
assign wdata_tdata1_size[3:0] = {cp0_dtu_wdata[SIZEHI:SIZEHI-1],cp0_dtu_wdata[SIZELO:SIZELO-1]};
assign exe_size_is_legal  = cp0_dtu_wdata[EXECUTE] && (wdata_tdata1_size[3:0] == 4'd0 ||
                            wdata_tdata1_size[3:0] == 4'd2 || wdata_tdata1_size[3:0] == 4'd3);//exe only suppurt size = 0,2,3
assign ldst_size_is_legal = (cp0_dtu_wdata[LOAD] || cp0_dtu_wdata[STORE]) && (wdata_tdata1_size[3:0] == 4'd0 || wdata_tdata1_size[3:0] == 4'd1 ||
                             wdata_tdata1_size[3:0] == 4'd2 || wdata_tdata1_size[3:0] == 4'd3 ||
                             wdata_tdata1_size[3:0] == 4'd5 || (wdata_tdata1_size[3:0] == 4'd9 && !cp0_dtu_wdata[SELECT]));
                             //ldst support all size, but size = 9 only allowed in addr trigger
assign size_is_legal      = exe_size_is_legal || ldst_size_is_legal;
assign size_legal[3:0]    = size_is_legal ? wdata_tdata1_size[3:0] : 4'b0;

//action
assign action_is_legal   = cp0_dtu_wdata[ACTION:ACTION-2] == 3'd0 && dmode_legal;
//(1)action <= 1;(2)dmode=1;action can be set to 0 or 1.
assign action_legal = action_is_legal ? cp0_dtu_wdata[ACTION-3] : 1'b0;

//match
assign match_is_legal   = cp0_dtu_wdata[MATCH:MATCH-3] == 4'd0 || cp0_dtu_wdata[MATCH:MATCH-3] == 4'd1 || cp0_dtu_wdata[MATCH:MATCH-3] == 4'd2 ||
                          cp0_dtu_wdata[MATCH:MATCH-3] == 4'd3 || cp0_dtu_wdata[MATCH:MATCH-3] == 4'd4 || cp0_dtu_wdata[MATCH:MATCH-3] == 4'd5;
assign match_legal[3:0] = match_is_legal ? cp0_dtu_wdata[MATCH:MATCH-3] : 4'b0;

//timing
assign load_data_trigger = cp0_dtu_wdata[LOAD] && cp0_dtu_wdata[SELECT];
assign timing_exe_or_wdata = cp0_dtu_wdata[EXECUTE] ? 1'b0 : cp0_dtu_wdata[TIMING];
assign timing_legal = load_data_trigger ? 1'b1 : timing_exe_or_wdata;

//chain
//1.if previous trigger chain=1, this trigger chain can't set to 1.
//2.if next trigger chain=1, this trigger chain can't set to 1.
//3.if next trigger dmode =1, this write operation will set this trigger dmode to 0,
//then the write operation can't set this trigger chain to 1.
assign chain_is_legal = !(previous_trigger_chian || next_trigger_chain ||
                          next_trigger_dmode && !dmode_legal);
assign chain_legal = chain_is_legal ? cp0_dtu_wdata[CHAIN] : 1'b0;  

//---------------------------------------------------------
//                legal tdata1 wdata
//---------------------------------------------------------
assign maskmax[5:0] = 6'd8;//TODO

//=========================================================
//
//                    write trigger CSR
//
//=========================================================

//---------------------------------------------------------
//                    write and update tdata1 
//---------------------------------------------------------

assign tdata_writable = !tdata1[DMODE] && (m_mode || rtu_yy_xx_dbgon) ||
                         tdata1[DMODE] && rtu_yy_xx_dbgon;
assign write_tdata1 = cp0_write_tdata1 && trigger_selected && tdata_writable;

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      begin
          tdata1_dmode       <= 1'b0;
          tdata1_sizehi[1:0] <= 2'b0;
          tdata1_select      <= 1'b0;
          tdata1_timing      <= 1'b0;
          tdata1_sizelo[1:0] <= 2'b0;
          tdata1_action      <= 1'b0;
          tdata1_chain       <= 1'b0;
          tdata1_match[3:0]  <= 4'b0;
          tdata1_m           <= 1'b0;
          tdata1_s           <= 1'b0;
          tdata1_u           <= 1'b0;
          tdata1_execute     <= 1'b0;
          tdata1_store       <= 1'b0;
          tdata1_load        <= 1'b0;
      end
  else if(write_tdata1)
      begin
          tdata1_dmode       <= dmode_legal;
          tdata1_sizehi[1:0] <= size_legal[3:2];
          tdata1_select      <= cp0_dtu_wdata[SELECT];
          tdata1_timing      <= timing_legal;
          tdata1_sizelo[1:0] <= size_legal[1:0];
          tdata1_action      <= action_legal;
          tdata1_chain       <= chain_legal;
          tdata1_match[3:0]  <= match_legal[3:0];
          tdata1_m           <= cp0_dtu_wdata[M];
          tdata1_s           <= cp0_dtu_wdata[S];
          tdata1_u           <= cp0_dtu_wdata[U];
          tdata1_execute     <= cp0_dtu_wdata[EXECUTE];
          tdata1_store       <= cp0_dtu_wdata[STORE];
          tdata1_load        <= cp0_dtu_wdata[LOAD];
       end
end
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      begin
          size1 <= 1'b0;
          size2 <= 1'b0;
          size3 <= 1'b0;
      end
  else if(write_tdata1)
      begin
          size1 <= size_legal[3:0] == 4'd1;
          size2 <= size_legal[3:0] == 4'd2;
          size3 <= size_legal[3:0] == 4'd3; 
      end
end

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      tdata1_hit <= 1'b0;
  else if(set_trigger_hit)
      tdata1_hit <= 1'b1;
  else if(write_tdata1)
      tdata1_hit <= cp0_dtu_wdata[HIT];
end

assign tdata1[XLEN-1:0] = {type_legal[3:0],tdata1_dmode,maskmax[5:0],{XLEN-34{1'b0}},tdata1_sizehi[1:0],
                 tdata1_hit,tdata1_select,tdata1_timing,tdata1_sizelo[1:0],3'b0,tdata1_action,
                 tdata1_chain,tdata1_match[3:0],tdata1_m,1'b0,tdata1_s,tdata1_u,tdata1_execute,
                 tdata1_store,tdata1_load};

// &Force("output","tdata1");&Force("bus","tdata1",XLEN-1,0); @203

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     write_tdata1_f <= 1'b0;
  else
     write_tdata1_f <= write_tdata1;
end
// &Force("nonport","write_tdata1_f"); @212
//tdata1 output
// &Force("output","tdata1_chain"); @214
// &Force("output","tdata1_dmode"); @215
// &Force("output","tdata1_timing"); @216
//assign tdata1_chain  = tdata1[CHAIN];
//assign tdata1_dmode  = tdata1[DMODE];
assign tdata1_action0 = !tdata1[ACTION-3];
assign tdata1_action1 = tdata1[ACTION-3];
//assign tdata1_timing = tdata1[TIMING];

//---------------------------------------------------------
//                    write tdata2
//---------------------------------------------------------
assign write_tdata2 = cp0_write_tdata2 && trigger_selected && tdata_writable;
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdata2[XLEN-1:0] <= {XLEN{1'b0}};
  else if(write_tdata2)
    tdata2[XLEN-1:0] <= cp0_dtu_wdata[XLEN-1:0];
end
// &Force("output","tdata2");&Force("bus","tdata2",XLEN-1,0); @234

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     write_tdata2_f <= 1'b0;
  else
     write_tdata2_f <= write_tdata2;
end
// &Force("nonport","write_tdata2_f"); @243
//---------------------------------------------------------
//                    write tdata3
//---------------------------------------------------------
//tdata3 wdata legalization
assign sselect_legal[1:0] = cp0_dtu_wdata[SSELECT:0] == 2'b11 ? 2'b00 : cp0_dtu_wdata[SSELECT:0];

//write tdata3
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
        tdata3_mvalue[12:0] <= 13'b0;
        tdata3_mselect      <= 1'b0;
        tdata3_svalue[33:0] <= 34'b0;
        tdata3_sselect[1:0] <= 2'b0;
    end
  else if(cp0_write_tdata3 && trigger_selected && tdata_writable)
    begin
        tdata3_mvalue[12:0] <= cp0_dtu_wdata[MVALUE:MVALUE-12];
        tdata3_mselect      <= cp0_dtu_wdata[MSELECT];
        tdata3_svalue[33:0] <= cp0_dtu_wdata[SVALUE:SVALUE-33];
        tdata3_sselect[1:0] <= sselect_legal[1:0];
    end
end
assign tdata3[XLEN-1:0] = {tdata3_mvalue[12:0],tdata3_mselect,{14{1'b0}},
                       tdata3_svalue[33:0],tdata3_sselect[1:0]};
// &Force("output","tdata3");&Force("bus","tdata3",XLEN-1,0); @270
//---------------------------------------------------------
//                    tinfo(read only)
//---------------------------------------------------------
assign tinfo = {{XLEN-3{1'b0}},3'b100};
// &Force("output","tinfo");&Force("bus","tinfo",XLEN-1,0); @275
//mcontrol type =2

//=========================================================
//
//                        decode
//
//=========================================================
//---------------------------------------------------------
//                  trigger enable signal
//---------------------------------------------------------
//tcontrol enable
//assign tdata1_action[3:0] = tdata1[ACTION:ACTION-3];

assign tcontrol_enable = !(!tcontrol[MTE] && !tdata1_action[0] && m_mode);//!(MTE=0 && action=0 && m_mode)
// &Force("bus","tcontrol",63,0); @290

//m s context enable
assign mcontext_must_match = tdata3[MSELECT] && m_mode;
assign mcontext_enable = mcontext_must_match ? tdata3[MVALUE:MVALUE-12] == mcontext[12:0] : 1'b1;
// &Force("bus","mcontext",63,0); @295

// &Force("input","cp0_dtu_satp");&Force("bus","cp0_dtu_satp",63,0); @297
// &CombBeg; @298
always @( tdata3[35:0]
       or scontext[33:0]
       or s_mode
       or cp0_dtu_satp[59:44])
begin
if(tdata3[SSELECT:0] == 2'd1 && s_mode)
  scontext_enable = tdata3[SVALUE:SVALUE-33] == scontext[33:0];
else if(tdata3[1:0] == 2'd2 && s_mode)
  scontext_enable = cp0_dtu_satp[59:44] == tdata3[SVALUE-18:SVALUE-33];
else
  scontext_enable = 1'b1;
// &CombEnd; @305
end
// &Force("bus","scontext",63,0); @306

assign ms_context_enable = mcontext_enable && scontext_enable;
//always @(posedge mcontrol_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//      ms_context_enable_reg <= 1'b0;
//  else
//      ms_context_enable_reg <= ms_context_enable;
//end
//m s u mode enable
assign m_enable = tdata1[M] && m_mode;
assign s_enable = tdata1[S] && s_mode;
assign u_enable = tdata1[U] && u_mode;

assign msu_mode_enable = m_enable || s_enable || u_enable;

//trigger can't match in debug mode
assign not_dbg_mode_enable = !rtu_yy_xx_dbgon;

//trigger enable
assign trigger_enable = tcontrol_enable && ms_context_enable &&
                        msu_mode_enable && not_dbg_mode_enable;

//---------------------------------------------------------
//               information for match 
//---------------------------------------------------------
//type of mcontrol
assign exe_mcontrol        = tdata1[EXECUTE];
assign ldst_mcontrol       = tdata1[LOAD] || tdata1[STORE];
// &Force("output","exe_mcontrol"); @336
// &Force("output","ldst_mcontrol"); @337
assign exe_addr_mcontrol   = tdata1[EXECUTE] && !tdata1[SELECT];
assign exe_data_mcontrol   = tdata1[EXECUTE] && tdata1[SELECT];

assign store_addr_mcontrol = tdata1[STORE] && !tdata1[SELECT];
assign store_data_mcontrol = tdata1[STORE] && tdata1[SELECT];
//assign load_mcontrol       = tdata1[LOAD];
//assign ldst_mcontrol       = store_mcontrol && load_mcontrol; 
assign load_addr_mcontrol  = tdata1[LOAD] && !tdata1[SELECT];
assign load_data_mcontrol  = tdata1[LOAD] && tdata1[SELECT];

assign ldst_addr_mcontrol = store_addr_mcontrol || load_addr_mcontrol;
assign ldst_data_mcontrol = store_data_mcontrol || load_data_mcontrol;
//priorty
// &CombBeg; @351
always @( tdata1[2]
       or tdata1[19])
begin
  if(tdata1[EXECUTE] && !tdata1[SELECT])
    begin
      mpriority[1:0] = 2'b10;
      mpriority_mask[1:0] = 2'b00;
    end
  else if(tdata1[EXECUTE] && tdata1[SELECT])
     begin
      mpriority[1:0] = 2'b01;
      mpriority_mask[1:0] = 2'b10;
    end
  else//ldst mcontrol or no mcontrol
     begin
      mpriority[1:0] = 2'b00;
      mpriority_mask[1:0] = 2'b11;
    end
// &CombEnd; @367
end
//mtiming
assign mtiming[1:0]      = !tdata1[TIMING] ? 2'b10 : 2'b01;
assign mtiming_mask[1:0] = !tdata1[TIMING] ? 2'b00 : 2'b10;
//size
assign tdata1_size[3:0]    = {tdata1[SIZEHI:SIZEHI-1],tdata1[SIZELO:SIZELO-1]};

//assign size_mask_63_32 = !(size1 || size2 || size3);
//assign size_mask_31_16 = !(size1 || size2);
//assign size_mask_15_8  = !size1;
//assign size_mask[XLEN-1:0] = {{32{size_mask_63_32}},{16{size_mask_31_16}},{8{size_mask_15_8}},{8{1'b1}}};
// &CombBeg; @378
always @( size1
       or size3
       or size2)
begin
  if(size1)
      size_mask[XLEN-1:0] = 64'h0000_0000_0000_00ff;
  else if(size2)
      size_mask[XLEN-1:0] = 64'h0000_0000_0000_ffff;
  else if(size3)
      size_mask[XLEN-1:0] = 64'h0000_0000_ffff_ffff;
  else 
      size_mask[XLEN-1:0] = 64'hffff_ffff_ffff_ffff;
// &CombEnd; @387
end

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      match_ldst_addr <= 1'b0;
  else if(!tdata1[SELECT] && (tdata1[LOAD] || tdata1[STORE]))
      match_ldst_addr <= 1'b1;
  else if(tdata1[LOAD] || tdata1[STORE] || tdata1[EXECUTE])
      match_ldst_addr <= 1'b0;
end

//tdata2 need to be masked off by size
assign tdata2_value_before_size_mask[XLEN-1:0] = {tdata2[XLEN-1:4], tdata2[3:0] & {4{!match_ldst_addr}}};
assign tdata2_value[XLEN-1:0] = tdata2_value_before_size_mask[XLEN-1:0] & size_mask[XLEN-1:0];

//half_value also need to be masked off by size
assign tdata2_upper_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2[XLEN-1:`TDT_DM_CORE_HALF_XLEN] & size_mask[`TDT_DM_CORE_HALF_XLEN-1:0];
assign tdata2_lower_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2[`TDT_DM_CORE_HALF_XLEN-1:0] & size_mask[`TDT_DM_CORE_HALF_XLEN-1:0];

assign tdata2_exe_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2_upper_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0];
assign tdata2_exe_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2_lower_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0];

assign tdata2_ldst_value_upper_half_match4[`TDT_DM_CORE_HALF_XLEN-1:0] = {tdata2_upper_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:4], 
                                                                          tdata2_upper_half_value_size_masked[3:0] & {4{tdata1[SELECT]}}};
assign tdata2_ldst_value_lower_half_match4[`TDT_DM_CORE_HALF_XLEN-1:0] = {tdata2_lower_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:4], 
                                                                          tdata2_lower_half_value_size_masked[3:0] & {4{tdata1[SELECT]}}};

assign tdata2_ldst_value_upper_half_match5[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2_upper_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0];
assign tdata2_ldst_value_lower_half_match5[`TDT_DM_CORE_HALF_XLEN-1:0] = tdata2_lower_half_value_size_masked[`TDT_DM_CORE_HALF_XLEN-1:0];
//translate tdata2[23:20] to bytes_vld. when select = 0, match = 4.
//tdata2_ldst_value_lower_half == ldst_value_lower_half & tdata2_exe_value_upper_half
//tdata2_ldst_bytes_vld == lsu_dtu_ldst_bytes_vld & tdata2_ldst_bytes_vld_for_match4

 //tdata2[3:0] generate low_bytes_vld
// &CombBeg; @422
always @( tdata2[1:0])
begin
 case(tdata2[1:0])
     2'b00:
         begin
          tdata2_ldst_bytes_vld_four_bits[3:0]             = 4'b0001;
          tdata2_ldst_bytes_vld_greater_four_bits[3:0]     = 4'b1111;
          tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]   = 4'b0000;
          tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0] = 8'b0000_0011;
         end
     2'b01:
         begin
          tdata2_ldst_bytes_vld_four_bits[3:0]             = 4'b0010;
          tdata2_ldst_bytes_vld_greater_four_bits[3:0]     = 4'b1110;
          tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]   = 4'b0001;
          tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0] = 8'b0000_1111;
         end
     2'b10:
         begin
          tdata2_ldst_bytes_vld_four_bits[3:0]             = 4'b0100;
          tdata2_ldst_bytes_vld_greater_four_bits[3:0]     = 4'b1100;
          tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]   = 4'b0011;
          tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0] = 8'b0000_1100;
         end
     2'b11:
         begin
          tdata2_ldst_bytes_vld_four_bits[3:0]             = 4'b1000;
          tdata2_ldst_bytes_vld_greater_four_bits[3:0]     = 4'b1000;
          tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]   = 4'b0111;
          tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0] = 8'b1111_1111;
         end
     default:
         begin
          tdata2_ldst_bytes_vld_four_bits[3:0]             = {4{1'bx}};
          tdata2_ldst_bytes_vld_greater_four_bits[3:0]     = {4{1'bx}};
          tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]   = {4{1'bx}};
          tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0] = {8{1'bx}};
         end
 endcase
// &CombEnd; @460
end
// &CombBeg; @461
always @( tdata2_ldst_bytes_vld_greater_four_bits[3:0]
       or tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0]
       or tdata2[3:0]
       or tdata2_ldst_bytes_vld_four_bits[3:0]
       or tdata2_ldst_bytes_vld_less_bits_four_bits[3:0])
begin
 case(tdata2[3:2])
     2'b00:
         begin
          tdata2_ldst_bytes_vld[15:0]            = {12'b0,tdata2_ldst_bytes_vld_four_bits[3:0]};
          tdata2_ldst_bytes_vld_greater[15:0]    = {12'hfff,tdata2_ldst_bytes_vld_greater_four_bits[3:0]};
          tdata2_ldst_bytes_vld_less[15:0]       = {12'b0,tdata2_ldst_bytes_vld_less_bits_four_bits[3:0]};
          tdata2_ldst_bytes_vld_for_match1[15:0] = {8'b0,tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0]};
         end
     2'b01:
         begin
          tdata2_ldst_bytes_vld[15:0]            = {8'b0,tdata2_ldst_bytes_vld_four_bits[3:0],4'b0};
          tdata2_ldst_bytes_vld_greater[15:0]    = {8'hff,tdata2_ldst_bytes_vld_greater_four_bits[3:0],4'b0};
          tdata2_ldst_bytes_vld_less[15:0]       = {8'b0,tdata2_ldst_bytes_vld_less_bits_four_bits[3:0],4'hf};
          if(tdata2[1:0] == 2'b11)
            tdata2_ldst_bytes_vld_for_match1[15:0] = {4'hf,tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0],4'hf};
          else
            tdata2_ldst_bytes_vld_for_match1[15:0] = {4'b0,tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0],4'b0};
         end
     2'b10:
         begin
          tdata2_ldst_bytes_vld[15:0]            = {4'b0,tdata2_ldst_bytes_vld_four_bits[3:0],8'b0};
          tdata2_ldst_bytes_vld_greater[15:0]    = {4'hf,tdata2_ldst_bytes_vld_greater_four_bits[3:0],8'b0};
          tdata2_ldst_bytes_vld_less[15:0]       = {4'b0,tdata2_ldst_bytes_vld_less_bits_four_bits[3:0],8'hff};
          tdata2_ldst_bytes_vld_for_match1[15:0] = {tdata2_ldst_bytes_vld_for_match1_eight_bits[7:0],8'b0};
         end
     2'b11:
         begin
          tdata2_ldst_bytes_vld[15:0]            = {tdata2_ldst_bytes_vld_four_bits[3:0],12'b0};
          tdata2_ldst_bytes_vld_greater[15:0]    = {tdata2_ldst_bytes_vld_greater_four_bits[3:0],12'b0};
          tdata2_ldst_bytes_vld_less[15:0]       = {tdata2_ldst_bytes_vld_less_bits_four_bits[3:0],12'hfff};
          if(tdata2[1:0] == 2'b11)
            tdata2_ldst_bytes_vld_for_match1[15:0] = {tdata2_ldst_bytes_vld_for_match1_eight_bits[3:0],12'hfff};
          else
            tdata2_ldst_bytes_vld_for_match1[15:0] = {tdata2_ldst_bytes_vld_for_match1_eight_bits[3:0],12'b0};
         end
     default:
         begin
          tdata2_ldst_bytes_vld[15:0]            = {16{1'bx}};
          tdata2_ldst_bytes_vld_greater[15:0]    = {16{1'bx}};
          tdata2_ldst_bytes_vld_less[15:0]       = {16{1'bx}};
          tdata2_ldst_bytes_vld_for_match1[15:0] = {16{1'bx}};
         end
 endcase
// &CombEnd; @505
end

// &CombBeg; @507
always @( tdata2[32+3:32]
       or tdata2_ldst_bytes_vld[15:0])
begin
 case(tdata2[(`TDT_DM_CORE_HALF_XLEN)+3:`TDT_DM_CORE_HALF_XLEN])
     4'b0000:tdata2_ldst_bytes_vld_for_match4[15:0] = {16{tdata2_ldst_bytes_vld[0]}};
     4'b0001:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b0010:tdata2_ldst_bytes_vld_for_match4[15:0] = { {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}} };
     4'b0011:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b0100:tdata2_ldst_bytes_vld_for_match4[15:0] = { {4{tdata2_ldst_bytes_vld[4]}},{4{tdata2_ldst_bytes_vld[0]}},
                                                        {4{tdata2_ldst_bytes_vld[4]}},{4{tdata2_ldst_bytes_vld[0]}} };
     4'b0101:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b0110:tdata2_ldst_bytes_vld_for_match4[15:0] = { {2{tdata2_ldst_bytes_vld[6]}},{2{tdata2_ldst_bytes_vld[4]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}},
                                                        {2{tdata2_ldst_bytes_vld[6]}},{2{tdata2_ldst_bytes_vld[4]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}} };
     4'b0111:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[7],tdata2_ldst_bytes_vld[6],tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[7],tdata2_ldst_bytes_vld[6],tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b1000:tdata2_ldst_bytes_vld_for_match4[15:0] = { {8{tdata2_ldst_bytes_vld[8]}},{8{tdata2_ldst_bytes_vld[0]}} };
     4'b1001:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],
                                                       tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b1010:tdata2_ldst_bytes_vld_for_match4[15:0] = { {2{tdata2_ldst_bytes_vld[10]}},{2{tdata2_ldst_bytes_vld[8]}},
                                                        {2{tdata2_ldst_bytes_vld[10]}},{2{tdata2_ldst_bytes_vld[8]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}} ,{2{tdata2_ldst_bytes_vld[0]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}} ,{2{tdata2_ldst_bytes_vld[0]}} };
     4'b1011:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[11],tdata2_ldst_bytes_vld[10],tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],
                                                       tdata2_ldst_bytes_vld[11],tdata2_ldst_bytes_vld[10],tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],
                                                       tdata2_ldst_bytes_vld[3],tdata2_ldst_bytes_vld[2],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b1100:tdata2_ldst_bytes_vld_for_match4[15:0] = { {4{tdata2_ldst_bytes_vld[12]}},{4{tdata2_ldst_bytes_vld[8]}},
                                                        {4{tdata2_ldst_bytes_vld[4]}} ,{4{tdata2_ldst_bytes_vld[0]}} };
     4'b1101:tdata2_ldst_bytes_vld_for_match4[15:0] = {tdata2_ldst_bytes_vld[13],tdata2_ldst_bytes_vld[12],tdata2_ldst_bytes_vld[13],tdata2_ldst_bytes_vld[12],
                                                       tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],tdata2_ldst_bytes_vld[9],tdata2_ldst_bytes_vld[8],
                                                       tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],tdata2_ldst_bytes_vld[5],tdata2_ldst_bytes_vld[4],
                                                       tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0],tdata2_ldst_bytes_vld[1],tdata2_ldst_bytes_vld[0]};
     4'b1110:tdata2_ldst_bytes_vld_for_match4[15:0] = { {2{tdata2_ldst_bytes_vld[14]}},{2{tdata2_ldst_bytes_vld[12]}},{2{tdata2_ldst_bytes_vld[10]}},
                                                        {2{tdata2_ldst_bytes_vld[8]}},{2{tdata2_ldst_bytes_vld[6]}} ,{2{tdata2_ldst_bytes_vld[4]}},
                                                        {2{tdata2_ldst_bytes_vld[2]}},{2{tdata2_ldst_bytes_vld[0]}} };
     4'b1111:tdata2_ldst_bytes_vld_for_match4[15:0] = tdata2_ldst_bytes_vld[15:0];
 default:tdata2_ldst_bytes_vld_for_match4[15:0] = {16{1'bx}};
endcase
// &CombEnd; @561
end

// &CombBeg; @563
always @( tdata2_ldst_bytes_vld_greater[15:0]
       or tdata2_ldst_bytes_vld_for_match1[15:0]
       or tdata2_ldst_bytes_vld[15:0]
       or tdata2_ldst_bytes_vld_for_match4[15:0]
       or tdata1[10:7]
       or tdata2_ldst_bytes_vld_less[15:0])
begin
 case(tdata1[MATCH:MATCH-3])
     4'd0:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld[15:0];
     4'd1:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld_for_match1[15:0];
     4'd2:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld_greater[15:0];
     4'd3:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld_less[15:0];
     4'd4:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld_for_match4[15:0];
     4'd5:tdata2_ldst_bytes_vld_0[15:0] = tdata2_ldst_bytes_vld[15:0];
     default:tdata2_ldst_bytes_vld_0[15:0] = {16{1'bx}};
 endcase
// &CombEnd; @573
end

//when match = 4, need reg_0 and reg_1 both.
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      tdata2_ldst_bytes_vld_reg_0[15:0] <= 16'b0;
  else if(tdata1[STORE] && !tdata1[SELECT] || tdata1[LOAD] && !tdata1[SELECT])
      tdata2_ldst_bytes_vld_reg_0[15:0] <= tdata2_ldst_bytes_vld_0[15:0];
end


//----------------------maksed value for match = 1------------------------------------
assign zero_lsb_higher_than_4 = tdata2[3:0] == 4'b1111;
assign tdata2_4bits_value_for_m_mask[3:0] = zero_lsb_higher_than_4 ? tdata2[7:4] : tdata2[3:0];
// &CombBeg; @588
always @( tdata2_4bits_value_for_m_mask[3:0])
begin
//m_mask and ldst_addr_mask(maskmax = 8). the low 4 bit of ldst addr are 0 
 casez(tdata2_4bits_value_for_m_mask[3:0]) 
   4'b???0:
           m_mask_four_bits[3:0] = 4'b1110;
   4'b??01:
           m_mask_four_bits[3:0] = 4'b1100;
   4'b?011:
           m_mask_four_bits[3:0] = 4'b1000;
   4'b0111:
           m_mask_four_bits[3:0] = 4'b0000;
   4'b1111:
           m_mask_four_bits[3:0] = 4'b0000;
   default:
           m_mask_four_bits[3:0] = {4{1'bx}};
endcase
// &CombEnd; @604
end

assign m_mask[7:0]            = zero_lsb_higher_than_4 ? {m_mask_four_bits[3:0],4'b0} : {4'b1111,m_mask_four_bits[3:0]};

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      m_mask_reg[7:0]             <= 8'b11111111;
  else if(tdata1[MATCH:MATCH-3] == 4'b1)
      m_mask_reg[7:0]             <= m_mask[7:0];
end 
//exe top M bits
assign tdata2_exe_value_masked_low_8bits[7:0]   = tdata2_value[7:0] & m_mask_reg[7:0];
assign tdata2_exe_value_top_mbits[XLEN-1:0]       = {tdata2_value[XLEN-1:8],tdata2_exe_value_masked_low_8bits[7:0]};
//ldst top M bits
assign ldst_m_mask[7:0] = tdata1[SELECT] ? m_mask_reg[7:0] : {m_mask_reg[7:4],4'b0};
assign tdata2_ldst_data_masked_low_8bits[7:0]   = tdata2_exe_value_masked_low_8bits[7:0];
assign tdata2_ldst_addr_masked_low_8bits[7:0]   = tdata2_value[7:0] & ldst_m_mask[7:0];
assign tdata2_ldst_value_top_mbits[XLEN-1:0]      = tdata1[SELECT] ? {tdata2_value[XLEN-1:8],tdata2_ldst_data_masked_low_8bits[7:0]} :
                                                                   {tdata2_value[XLEN-1:8],tdata2_ldst_addr_masked_low_8bits[7:0]};
//assign tdata2_ldst_bytes_vld_top_mbits[15:0]    = tdata2_ldst_bytes_vld_reg[15:0] & ldst_bytes_vld_m_mask_reg[15:0];

//=========================================================
//
//               exe0 match logic
//
//=========================================================
//---------------------------------------------------------
//              exe0 type match and size match
//---------------------------------------------------------
assign exe0_type_match      = ifu_dtu_addr_vld0 && exe_addr_mcontrol || ifu_dtu_data_vld0 && exe_data_mcontrol;
assign exe0_size_match      = tdata1_size[3:0] == 4'd0 || size2 && exe0_16bit || size3 && exe0_32bit || (ifu_dtu_addr_vld0 && !ifu_dtu_data_vld0);
assign exe0_type_size_match = exe0_type_match && exe0_size_match && trigger_enable;
//---------------------------------------------------------
//               exe0 value match
//---------------------------------------------------------
//value for exe0 trigger match
assign extend_exe_data0[XLEN-1:0] = {{XLEN-32{1'b0}},ifu_dtu_exe_data0[31:0]};
//assign exe0_value[XLEN-1:0]       = tdata1[SELECT] ? extend_exe_data0[XLEN-1:0] : {{XLEN-`PA_WIDTH{1'b0}},ifu_dtu_exe_addr0[`PA_WIDTH-1:0]};
assign exe0_value_before_size_mask[XLEN-1:0] = tdata1[SELECT] ? extend_exe_data0[XLEN-1:0] : {{XLEN-`PA_WIDTH{ifu_dtu_exe_addr0[`PA_WIDTH-1]}},ifu_dtu_exe_addr0[`PA_WIDTH-1:0]};
assign exe0_value[XLEN-1:0]       = exe0_value_before_size_mask[XLEN-1:0] & size_mask[XLEN-1:0];

assign exe0_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] = exe0_value[XLEN-1:`TDT_DM_CORE_HALF_XLEN];
assign exe0_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] = exe0_value[`TDT_DM_CORE_HALF_XLEN-1:0];

assign exe0_value_masked_low_8bis[7:0]   = exe0_value[7:0] & m_mask_reg[7:0];
assign exe0_value_top_mbits[XLEN-1:0]      = {exe0_value[XLEN-1:8],exe0_value_masked_low_8bis[7:0]};

//value match
assign exe0_match_equal              = exe0_value[XLEN-1:0] == tdata2_value[XLEN-1:0];//match = 0
assign exe0_match_top_mbits_equal    = exe0_value_top_mbits[XLEN-1:0] == tdata2_exe_value_top_mbits[XLEN-1:0];//match = 1
assign exe0_greater_than_tdata2      = exe0_value[XLEN-1:0] >= tdata2_value[XLEN-1:0];
assign exe0_match_greater            = exe0_greater_than_tdata2;//match = 2
assign exe0_match_less               = !exe0_greater_than_tdata2;//match = 3
assign exe0_match_value_lower_half   = tdata2_exe_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] == (exe0_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                            tdata2_exe_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0]);//match = 4
assign exe0_match_value_upper_half   = tdata2_exe_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] == (exe0_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                            tdata2_exe_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0]);//match = 5

assign exe0_have_value_match0 = tdata1[MATCH:MATCH-3] == 4'd0 && exe0_match_equal;
assign exe0_have_value_match1 = tdata1[MATCH:MATCH-3] == 4'd1 && exe0_match_top_mbits_equal;
assign exe0_have_value_match2 = tdata1[MATCH:MATCH-3] == 4'd2 && exe0_match_greater;
assign exe0_have_value_match3 = tdata1[MATCH:MATCH-3] == 4'd3 && exe0_match_less;
assign exe0_have_value_match4 = tdata1[MATCH:MATCH-3] == 4'd4 && exe0_match_value_lower_half;
assign exe0_have_value_match5 = tdata1[MATCH:MATCH-3] == 4'd5 && exe0_match_value_upper_half;

assign exe0_value_match = exe0_have_value_match0 || exe0_have_value_match1 || exe0_have_value_match2 ||
                          exe0_have_value_match3 || exe0_have_value_match4 || exe0_have_value_match5;

assign exe0_value_match_for_may_hit = exe0_have_value_match0 || exe0_have_value_match1 || exe0_have_value_match2 ||
                                      exe0_have_value_match3 || tdata1[MATCH:MATCH-3] == 4'd4 || tdata1[MATCH:MATCH-3] == 4'd5;
//---------------------------------------------------------
//             exe0 match result
//---------------------------------------------------------
assign exe0_match_need_reg   = exe0_value_match && exe0_type_size_match;
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     exe0_match      <= 1'b0;
  else
     exe0_match      <= exe0_match_need_reg;
end
// &Force("output","exe0_match"); @686

assign exe0_may_hit = exe0_value_match_for_may_hit;// && ifu_dtu_addr_vld0;

//=========================================================
//
//                     exe1 match logic
//               
//=========================================================
//---------------------------------------------------------
//              exe1 type match and size match
//---------------------------------------------------------
assign exe1_type_match      = ifu_dtu_addr_vld1 && exe_addr_mcontrol || ifu_dtu_data_vld1 && exe_data_mcontrol;
assign exe1_size_match      = tdata1_size[3:0] == 4'd0 || size2 && exe1_16bit || size3 && exe1_32bit || (ifu_dtu_addr_vld1 && !ifu_dtu_data_vld1);
assign exe1_type_size_match = exe1_type_match && exe1_size_match && trigger_enable;
//---------------------------------------------------------
//               exe1 value match
//---------------------------------------------------------
//value for exe1 trigger match
assign extend_exe_data1[XLEN-1:0] = {{XLEN-32{1'b0}},ifu_dtu_exe_data1[31:0]};
//assign exe1_value[XLEN-1:0]       = tdata1[SELECT] ? extend_exe_data1[XLEN-1:0]: {{XLEN-`PA_WIDTH{1'b0}},ifu_dtu_exe_addr1[`PA_WIDTH-1:0]};
assign exe1_value_before_size_mask[XLEN-1:0] = tdata1[SELECT] ? extend_exe_data1[XLEN-1:0] : {{XLEN-`PA_WIDTH{ifu_dtu_exe_addr1[`PA_WIDTH-1]}},ifu_dtu_exe_addr1[`PA_WIDTH-1:0]};
assign exe1_value[XLEN-1:0]       = exe1_value_before_size_mask[XLEN-1:0] & size_mask[XLEN-1:0];

assign exe1_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] = exe1_value[XLEN-1:`TDT_DM_CORE_HALF_XLEN];
assign exe1_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] = exe1_value[`TDT_DM_CORE_HALF_XLEN-1:0];

assign exe1_value_masked_low_8bis[7:0]   = exe1_value[7:0] & m_mask_reg[7:0];
assign exe1_value_top_mbits[XLEN-1:0]      = {exe1_value[XLEN-1:8],exe1_value_masked_low_8bis[7:0]};

//value match
assign exe1_match_equal              = exe1_value[XLEN-1:0] == tdata2_value[XLEN-1:0];//match = 0
assign exe1_match_top_mbits_equal    = exe1_value_top_mbits[XLEN-1:0] == tdata2_exe_value_top_mbits[XLEN-1:0];//match = 1
assign exe1_greater_than_tdata2      = exe1_value[XLEN-1:0] >= tdata2_value[XLEN-1:0];
assign exe1_match_greater            = exe1_greater_than_tdata2;//match = 2
assign exe1_match_less               = !exe1_greater_than_tdata2;//match = 3
assign exe1_match_value_lower_half   = tdata2_exe_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] == (exe1_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                            tdata2_exe_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0]);//match = 4
assign exe1_match_value_upper_half   = tdata2_exe_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] == (exe1_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                            tdata2_exe_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0]);//match = 5
assign exe1_have_value_match0 = tdata1[MATCH:MATCH-3] == 4'd0 && exe1_match_equal;
assign exe1_have_value_match1 = tdata1[MATCH:MATCH-3] == 4'd1 && exe1_match_top_mbits_equal;
assign exe1_have_value_match2 = tdata1[MATCH:MATCH-3] == 4'd2 && exe1_match_greater;
assign exe1_have_value_match3 = tdata1[MATCH:MATCH-3] == 4'd3 && exe1_match_less;
assign exe1_have_value_match4 = tdata1[MATCH:MATCH-3] == 4'd4 && exe1_match_value_lower_half;
assign exe1_have_value_match5 = tdata1[MATCH:MATCH-3] == 4'd5 && exe1_match_value_upper_half;

assign exe1_value_match = exe1_have_value_match0 || exe1_have_value_match1 || exe1_have_value_match2 ||
                               exe1_have_value_match3 || exe1_have_value_match4 || exe1_have_value_match5;

assign exe1_value_match_for_may_hit = exe1_have_value_match0 || exe1_have_value_match1 || exe1_have_value_match2 ||
                                      exe1_have_value_match3 || tdata1[MATCH:MATCH-3] == 4'd4 || tdata1[MATCH:MATCH-3] == 4'd5;
//---------------------------------------------------------
//             exe1 match result
//---------------------------------------------------------
assign exe1_match_need_reg   = exe1_value_match && exe1_type_size_match;
always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     exe1_match      <= 1'b0;
  else
     exe1_match      <= exe1_match_need_reg;
end
// &Force("output","exe1_match"); @749

assign exe1_may_hit = exe1_value_match_for_may_hit;// && ifu_dtu_addr_vld1;
//=========================================================
//             
//                    ldst match logic
//             
//=========================================================
//---------------------------------------------------------
//              ldst type match and size match
//---------------------------------------------------------
assign ldst_type_match = store_addr_vld  && store_addr_mcontrol ||
                         store_data_vld  && store_data_mcontrol ||
                         load_addr_vld && load_addr_mcontrol || 
                         load_data_vld && load_data_mcontrol;
assign ldst_size_match = tdata1_size[3:0] == 4'd0 || size1 && ldst_8bit || 
                         size2 && ldst_16bit || size3 && ldst_32bit || 
                         tdata1_size[3:0] == 4'd5 && ldst_64bit || tdata1_size[3:0] == 4'd9 && ldst_128bit;
assign ldst_type_size_match = ldst_type_match && ldst_size_match && trigger_enable;

//---------------------------------------------------------
//               ldst value match
//---------------------------------------------------------
//value for ldst trigger match
// &Force("bus","lsu_dtu_ldst_addr",`PA_WIDTH-1,0); @773
//assign ldst_value[XLEN-1:0] = tdata1[SELECT] ? lsu_dtu_ldst_data[XLEN-1:0]: {{XLEN-`PA_WIDTH{1'b0}},lsu_dtu_ldst_addr[`PA_WIDTH-1:4],4'b0};
assign ldst_value_before_size_mask[XLEN-1:0] = tdata1[SELECT] ? lsu_dtu_ldst_data[XLEN-1:0]: {{XLEN-`PA_WIDTH{lsu_dtu_ldst_addr[`PA_WIDTH-1]}},lsu_dtu_ldst_addr[`PA_WIDTH-1:4],4'b0};
assign ldst_value[XLEN-1:0]       = ldst_value_before_size_mask[XLEN-1:0] & size_mask[XLEN-1:0];

assign ldst_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] = ldst_value[XLEN-1:`TDT_DM_CORE_HALF_XLEN];
assign ldst_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] = ldst_value[`TDT_DM_CORE_HALF_XLEN-1:0];

//masked value
assign ldst_value_masked_low_8bis[7:0]   = ldst_value[7:0] & ldst_m_mask[7:0];
assign ldst_value_top_mbits[XLEN-1:0]      = {ldst_value[XLEN-1:8],ldst_value_masked_low_8bis[7:0]};
//assign ldst_bytes_vld_top_masked[15:0]   = lsu_dtu_ldst_bytes_vld[15:0] & ldst_bytes_vld_m_mask_reg[15:0];

//value match
assign lsu_have_bytes_vld = |lsu_dtu_ldst_bytes_vld[15:0];
assign bytes_vld_match = |(lsu_dtu_ldst_bytes_vld[15:0] & tdata2_ldst_bytes_vld_reg_0[15:0]);
//match = 0
//assign exe1_or_ldst_value[XLEN-1:0] = tdata1[EXECUTE] ? exe1_value[XLEN-1:0] : ldst_value[XLEN-1:0];
assign ldst_value_equal           = ldst_value[XLEN-1:0] == tdata2_value[XLEN-1:0];
//assign ldst_bytes_vld_equal       = |(lsu_dtu_ldst_bytes_vld[15:0] & tdata2_ldst_bytes_vld_reg[15:0]);
assign ldst_bytes_vld_equal       = bytes_vld_match;
assign ldst_addr_match_equal      = ldst_bytes_vld_equal && ldst_value_equal;
assign ldst_match_equal           = tdata1[SELECT] ? ldst_value_equal : ldst_addr_match_equal;
//assign exe1_match_equal         = exe1_or_ldst_value_equal;

//match = 1
//assign exe1_or_ldst_value_top_mbits[XLEN-1:0] = tdata1[EXECUTE] ? exe1_value_top_mbits[XLEN-1:0] : ldst_value_top_mbits[XLEN-1:0];
assign ldst_value_top_mbits_equal = ldst_value_top_mbits[XLEN-1:0] == tdata2_ldst_value_top_mbits[XLEN-1:0];
//assign ldst_bytes_vld_mbits_equal = ldst_bytes_vld_top_masked[15:0] == tdata2_ldst_bytes_vld_top_mbits[15:0];
//assign ldst_bytes_vld_mbits_equal = |(lsu_dtu_ldst_bytes_vld[15:0] & tdata2_ldst_bytes_vld_for_match1_reg[15:0]);
assign ldst_bytes_vld_mbits_equal = bytes_vld_match;
assign ldst_addr_top_mbits_equal  = ldst_value_top_mbits_equal && ldst_bytes_vld_mbits_equal;
assign ldst_match_top_mbits_equal = tdata1[SELECT] ? ldst_value_top_mbits_equal : ldst_addr_top_mbits_equal;
//assign exe1_match_top_mbits_equal = 
//match = 2
//same to match = 0
assign ldst_value_greater_equal_tdata2     = ldst_value[XLEN-1:0] >= tdata2_value[XLEN-1:0];//for ldst data >= tdata2
assign ldst_value_greater_than_tdata2      = ldst_value_greater_equal_tdata2 && !ldst_value_equal && lsu_have_bytes_vld;
//assign ldst_bytes_greater_than_tdata2      = |(lsu_dtu_ldst_bytes_vld[15:0] & tdata2_ldst_bytes_vld_greater_reg[15:0]);
assign ldst_bytes_greater_than_tdata2      = bytes_vld_match;
assign ldst_top_equal_bytes_greater_tdata2 = ldst_value_equal && ldst_bytes_greater_than_tdata2;//top addr equal, ldst bytes >= tdata2 bytes
assign ldst_addr_greater_than_tdata2       = ldst_value_greater_than_tdata2 || ldst_top_equal_bytes_greater_tdata2;
assign ldst_match_greater                  = tdata1[SELECT] ? ldst_value_greater_equal_tdata2 : ldst_addr_greater_than_tdata2;
//match = 3
assign ldst_value_less_than_tdata2         = !ldst_value_greater_equal_tdata2 && lsu_have_bytes_vld;
//assign ldst_bytes_less_than_tdata2         = |(lsu_dtu_ldst_bytes_vld[15:0] & tdata2_ldst_bytes_vld_less_reg[15:0]);
assign ldst_bytes_less_than_tdata2         = bytes_vld_match;
assign ldst_top_equal_bytes_less_tdata2    = ldst_value_equal && ldst_bytes_less_than_tdata2;//top addr equal, ldst bytes < tdata2 bytes
assign ldst_addr_less_than_tdata2          = ldst_value_less_than_tdata2 || ldst_top_equal_bytes_less_tdata2;
assign ldst_match_less                     = tdata1[SELECT] ? (!ldst_value_greater_equal_tdata2) : ldst_addr_less_than_tdata2;
//match = 4
assign ldst_value_lower_half_and     = tdata2_ldst_value_lower_half_match4[`TDT_DM_CORE_HALF_XLEN-1:0] == (ldst_value_lower_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                                      tdata2_ldst_value_upper_half_match4[`TDT_DM_CORE_HALF_XLEN-1:0]);//top addr match
assign ldst_bytes_vld_lower_half_and = bytes_vld_match;//bytes_vld_match
assign ldst_addr_lower_half_match    = ldst_value_lower_half_and && ldst_bytes_vld_lower_half_and;
assign ldst_match_value_lower_half   = tdata1[SELECT] ? ldst_value_lower_half_and : ldst_addr_lower_half_match;
//match = 5
assign ldst_match_value_upper_half   = tdata2_ldst_value_lower_half_match5[`TDT_DM_CORE_HALF_XLEN-1:0] == (ldst_value_upper_half[`TDT_DM_CORE_HALF_XLEN-1:0] & 
                                                                                      tdata2_ldst_value_upper_half_match5[`TDT_DM_CORE_HALF_XLEN-1:0]);
assign ldst_have_value_match0 = tdata1[MATCH:MATCH-3] == 4'd0 && ldst_match_equal;
assign ldst_have_value_match1 = tdata1[MATCH:MATCH-3] == 4'd1 && ldst_match_top_mbits_equal;
assign ldst_have_value_match2 = tdata1[MATCH:MATCH-3] == 4'd2 && ldst_match_greater;
assign ldst_have_value_match3 = tdata1[MATCH:MATCH-3] == 4'd3 && ldst_match_less;
assign ldst_have_value_match4 = tdata1[MATCH:MATCH-3] == 4'd4 && ldst_match_value_lower_half;
assign ldst_have_value_match5 = tdata1[MATCH:MATCH-3] == 4'd5 && ldst_match_value_upper_half;

assign ldst_value_match = ldst_have_value_match0 || ldst_have_value_match1 || ldst_have_value_match2 ||
                          ldst_have_value_match3 || ldst_have_value_match4 || ldst_have_value_match5;
assign ldst_value_match_for_may_hit = ldst_have_value_match0 || ldst_have_value_match1 || ldst_have_value_match2 ||
                                       ldst_have_value_match3 || tdata1[MATCH:MATCH-3] == 4'd4 || tdata1[MATCH:MATCH-3] == 4'd5;
//---------------------------------------------------------
//             ldst match result
//---------------------------------------------------------
assign tri_already_match        = already_match && (lsu_dtu_ldst_addr_vld || lsu_dtu_ldst_data_vld);
assign ldst_mcontrol_match     = ldst_value_match && ldst_type_size_match;
assign ldst_match_need_reg      = ldst_mcontrol_match || tri_already_match;

assign ldst_mcontrol_match_for_may_hit     = ldst_value_match_for_may_hit && ldst_type_size_match;
assign ldst_match_need_reg_for_may_hit     = ldst_mcontrol_match_for_may_hit || tri_already_match;

always @(posedge mcontrol_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
     ldst_match      <= 1'b0;
  else
     ldst_match      <= ldst_match_need_reg;
end
// &Force("output","ldst_match"); @860
//assign ldst_may_hit = ldst_cycle2_cannot_match ? 1'b0 : ldst_match_need_reg;
assign ldst_may_hit = ldst_match_need_reg_for_may_hit;//ldst_value_match || tri_already_match;

//==========================================================
//                     gate clk
//==========================================================
assign mcontrol_clk_en = trigger_selected && 
                    (cp0_write_tdata1   || cp0_write_tdata2   || cp0_write_tdata3 || 
                     write_tdata2_f || write_tdata1_f) ||
                     exe0_match_need_reg || exe0_match ||
                     exe1_match_need_reg || exe1_match ||
                     ldst_match_need_reg || ldst_match ||

                    set_trigger_hit;
// &Force("nonport","mcontrol_clk_en"); @875

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @877
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mcontrol_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (mcontrol_clk_en   ),
  .module_en          (cp0_dtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @878
//          .external_en (1'b0), @879
//          .global_en   (cp0_yy_clk_en), @880
//          .module_en   (cp0_dtu_icg_en), @881
//          .local_en    (mcontrol_clk_en), @882
//          //.local_en    (1'b1), @883
//          .clk_out     (mcontrol_clk)); @884
// &ModuleEnd; @885
endmodule


