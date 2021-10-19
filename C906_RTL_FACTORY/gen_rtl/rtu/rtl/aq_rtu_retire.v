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

// &Depend("aq_dtu_cfig.h"); @23
// &Depend("cpu_cfig.h"); @24
// &ModuleBeg; @25
module aq_rtu_retire(
  async_select_next_pc,
  cp0_rtu_fence_idle,
  cp0_rtu_icg_en,
  cp0_rtu_in_lpmd,
  cp0_rtu_trap_pc,
  cp0_rtu_vstart_eq_0,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_retire_ex2_retire_vld,
  dp_retire_ex2_cur_pc,
  dp_retire_ex2_fs_dirty,
  dp_retire_ex2_halt_info,
  dp_retire_ex2_inst_branch,
  dp_retire_ex2_inst_chgflw,
  dp_retire_ex2_inst_dret,
  dp_retire_ex2_inst_ebreak,
  dp_retire_ex2_inst_expt,
  dp_retire_ex2_inst_flush,
  dp_retire_ex2_inst_mret,
  dp_retire_ex2_inst_split,
  dp_retire_ex2_inst_sret,
  dp_retire_ex2_inst_vstart,
  dp_retire_ex2_next_pc,
  dp_retire_ex2_tval,
  dp_retire_ex2_vec,
  dp_retire_ex2_vs_dirty,
  dp_retire_ex2_vstart,
  dtu_rtu_async_halt_req,
  dtu_rtu_dpc,
  dtu_rtu_ebreak_action,
  dtu_rtu_pending_tval,
  dtu_rtu_resume_req,
  dtu_rtu_step_en,
  dtu_rtu_sync_flush,
  dtu_rtu_sync_halt_req,
  forever_cpuclk,
  hpcp_rtu_cnt_en,
  ifu_rtu_reset_halt_req,
  ifu_rtu_warm_up,
  int_retire_int_vec,
  int_retire_int_vld,
  iu_rtu_depd_lsu_chgflow_vld,
  iu_rtu_ex2_bju_ras_mispred,
  iu_xx_no_op,
  lsu_rtu_async_expt_vld,
  lsu_rtu_async_ld_inst,
  lsu_rtu_async_tval,
  lsu_rtu_ex1_buffer_vld,
  lsu_rtu_no_op,
  mmu_xx_mmu_en,
  pad_yy_icg_scan_en,
  retire_ctrl_commit_clear,
  retire_ctrl_commit_clear_for_bju,
  retire_rbus_fs_dirty,
  retire_rbus_vs_dirty,
  retire_top_dbg_info,
  rtu_cp0_epc,
  rtu_cp0_exit_debug,
  rtu_cp0_tval,
  rtu_cp0_vstart,
  rtu_cp0_vstart_vld,
  rtu_cpu_no_retire,
  rtu_dtu_dpc,
  rtu_dtu_halt_ack,
  rtu_dtu_pending_ack,
  rtu_dtu_retire_chgflw,
  rtu_dtu_retire_debug_expt_vld,
  rtu_dtu_retire_halt_info,
  rtu_dtu_retire_mret,
  rtu_dtu_retire_next_pc,
  rtu_dtu_retire_sret,
  rtu_dtu_retire_vld,
  rtu_dtu_tval,
  rtu_hpcp_int_vld,
  rtu_hpcp_retire_inst_vld,
  rtu_hpcp_retire_pc,
  rtu_idu_flush_fe,
  rtu_idu_flush_stall,
  rtu_idu_flush_wbt,
  rtu_idu_pipeline_empty,
  rtu_ifu_chgflw_pc,
  rtu_ifu_chgflw_vld,
  rtu_ifu_dbg_mask,
  rtu_ifu_flush_fe,
  rtu_lsu_async_expt_ack,
  rtu_lsu_expt_ack,
  rtu_lsu_expt_exit,
  rtu_mmu_bad_vpn,
  rtu_mmu_expt_vld,
  rtu_pad_halted,
  rtu_pad_retire,
  rtu_pad_retire_pc,
  rtu_vidu_flush_wbt,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  rtu_yy_xx_flush,
  rtu_yy_xx_flush_fe,
  vidu_rtu_no_op,
  vpu_rtu_no_op,
  wb_retire_wb_no_op
);


// &Ports; @27
input           async_select_next_pc;                 
input           cp0_rtu_fence_idle;                   
input           cp0_rtu_icg_en;                       
input           cp0_rtu_in_lpmd;                      
input   [39:0]  cp0_rtu_trap_pc;                      
input           cp0_rtu_vstart_eq_0;                  
input           cp0_yy_clk_en;                        
input           cpurst_b;                             
input           ctrl_retire_ex2_retire_vld;           
input   [39:0]  dp_retire_ex2_cur_pc;                 
input           dp_retire_ex2_fs_dirty;               
input   [21:0]  dp_retire_ex2_halt_info;              
input           dp_retire_ex2_inst_branch;            
input           dp_retire_ex2_inst_chgflw;            
input           dp_retire_ex2_inst_dret;              
input           dp_retire_ex2_inst_ebreak;            
input           dp_retire_ex2_inst_expt;              
input           dp_retire_ex2_inst_flush;             
input           dp_retire_ex2_inst_mret;              
input           dp_retire_ex2_inst_split;             
input           dp_retire_ex2_inst_sret;              
input           dp_retire_ex2_inst_vstart;            
input   [39:0]  dp_retire_ex2_next_pc;                
input   [39:0]  dp_retire_ex2_tval;                   
input   [4 :0]  dp_retire_ex2_vec;                    
input           dp_retire_ex2_vs_dirty;               
input   [6 :0]  dp_retire_ex2_vstart;                 
input           dtu_rtu_async_halt_req;               
input   [63:0]  dtu_rtu_dpc;                          
input           dtu_rtu_ebreak_action;                
input   [63:0]  dtu_rtu_pending_tval;                 
input           dtu_rtu_resume_req;                   
input           dtu_rtu_step_en;                      
input           dtu_rtu_sync_flush;                   
input           dtu_rtu_sync_halt_req;                
input           forever_cpuclk;                       
input           hpcp_rtu_cnt_en;                      
input           ifu_rtu_reset_halt_req;               
input           ifu_rtu_warm_up;                      
input   [4 :0]  int_retire_int_vec;                   
input           int_retire_int_vld;                   
input           iu_rtu_depd_lsu_chgflow_vld;          
input           iu_rtu_ex2_bju_ras_mispred;           
input           iu_xx_no_op;                          
input           lsu_rtu_async_expt_vld;               
input           lsu_rtu_async_ld_inst;                
input   [39:0]  lsu_rtu_async_tval;                   
input           lsu_rtu_ex1_buffer_vld;               
input           lsu_rtu_no_op;                        
input           mmu_xx_mmu_en;                        
input           pad_yy_icg_scan_en;                   
input           vidu_rtu_no_op;                       
input           vpu_rtu_no_op;                        
input           wb_retire_wb_no_op;                   
output          retire_ctrl_commit_clear;             
output          retire_ctrl_commit_clear_for_bju;     
output          retire_rbus_fs_dirty;                 
output          retire_rbus_vs_dirty;                 
output  [10:0]  retire_top_dbg_info;                  
output  [63:0]  rtu_cp0_epc;                          
output          rtu_cp0_exit_debug;                   
output  [63:0]  rtu_cp0_tval;                         
output  [6 :0]  rtu_cp0_vstart;                       
output          rtu_cp0_vstart_vld;                   
output          rtu_cpu_no_retire;                    
output  [63:0]  rtu_dtu_dpc;                          
output          rtu_dtu_halt_ack;                     
output          rtu_dtu_pending_ack;                  
output          rtu_dtu_retire_chgflw;                
output          rtu_dtu_retire_debug_expt_vld;        
output  [21:0]  rtu_dtu_retire_halt_info;             
output          rtu_dtu_retire_mret;                  
output  [39:0]  rtu_dtu_retire_next_pc;               
output          rtu_dtu_retire_sret;                  
output          rtu_dtu_retire_vld;                   
output  [63:0]  rtu_dtu_tval;                         
output          rtu_hpcp_int_vld;                     
output          rtu_hpcp_retire_inst_vld;             
output  [39:0]  rtu_hpcp_retire_pc;                   
output          rtu_idu_flush_fe;                     
output          rtu_idu_flush_stall;                  
output          rtu_idu_flush_wbt;                    
output          rtu_idu_pipeline_empty;               
output  [39:0]  rtu_ifu_chgflw_pc;                    
output          rtu_ifu_chgflw_vld;                   
output          rtu_ifu_dbg_mask;                     
output          rtu_ifu_flush_fe;                     
output          rtu_lsu_async_expt_ack;               
output          rtu_lsu_expt_ack;                     
output          rtu_lsu_expt_exit;                    
output  [26:0]  rtu_mmu_bad_vpn;                      
output          rtu_mmu_expt_vld;                     
output          rtu_pad_halted;                       
output          rtu_pad_retire;                       
output  [39:0]  rtu_pad_retire_pc;                    
output          rtu_vidu_flush_wbt;                   
output          rtu_yy_xx_async_flush;                
output          rtu_yy_xx_dbgon;                      
output          rtu_yy_xx_expt_int;                   
output  [4 :0]  rtu_yy_xx_expt_vec;                   
output          rtu_yy_xx_expt_vld;                   
output          rtu_yy_xx_flush;                      
output          rtu_yy_xx_flush_fe;                   

// &Regs; @28
reg             bkpt_req_split_lsu_trigger_buf;       
reg             bkpt_req_split_trigger_t1_buf;        
reg             dbg_mode_on;                          
reg             dbg_mode_on_after_req;                
reg     [2 :0]  flush_cur_state;                      
reg     [2 :0]  flush_next_state;                     
reg     [3 :0]  halt_cause;                           
reg             halt_req_split_trigger_t1_buf;        
reg             no_retire;                            
reg             retire_async_flush;                   
reg     [21:0]  retire_buf_split_trigger_t1_halt_info; 
reg     [39:0]  retire_chgflw_pc;                     
reg     [31:0]  retire_cnt;                           
reg             retire_int_vld_flop;                  
reg             retire_trap_chgflw_vld;               
reg     [39:0]  retire_trap_epc;                      
reg     [63:0]  retire_trap_tval;                     
reg     [4 :0]  retire_trap_vec;                      
reg             retire_xret_vld;                      
reg     [21:0]  rtu_dtu_retire_halt_info;             
reg     [63:0]  rtu_dtu_tval;                         

// &Wires; @29
wire            async_select_next_pc;                 
wire            bkpt_req_buf_split_trigger_t1;        
wire            bkpt_req_ebreak;                      
wire            bkpt_req_pending;                     
wire            bkpt_req_split_trigger_t1;            
wire            bkpt_req_t1_retire_vld;               
wire            bkpt_req_t1_retire_vld_raw;           
wire            bkpt_req_trigger_t0;                  
wire            bkpt_req_trigger_t1;                  
wire            bkpt_req_trigger_t1_raw;              
wire            cp0_rtu_fence_idle;                   
wire            cp0_rtu_icg_en;                       
wire            cp0_rtu_in_lpmd;                      
wire    [39:0]  cp0_rtu_trap_pc;                      
wire            cp0_rtu_vstart_eq_0;                  
wire            cp0_yy_clk_en;                        
wire            cpurst_b;                             
wire            ctrl_retire_ex2_retire_vld;           
wire    [39:0]  dp_retire_ex2_cur_pc;                 
wire            dp_retire_ex2_fs_dirty;               
wire    [21:0]  dp_retire_ex2_halt_info;              
wire            dp_retire_ex2_inst_branch;            
wire            dp_retire_ex2_inst_chgflw;            
wire            dp_retire_ex2_inst_dret;              
wire            dp_retire_ex2_inst_ebreak;            
wire            dp_retire_ex2_inst_expt;              
wire            dp_retire_ex2_inst_flush;             
wire            dp_retire_ex2_inst_mret;              
wire            dp_retire_ex2_inst_split;             
wire            dp_retire_ex2_inst_sret;              
wire            dp_retire_ex2_inst_vstart;            
wire    [39:0]  dp_retire_ex2_next_pc;                
wire    [39:0]  dp_retire_ex2_tval;                   
wire    [4 :0]  dp_retire_ex2_vec;                    
wire            dp_retire_ex2_vs_dirty;               
wire    [6 :0]  dp_retire_ex2_vstart;                 
wire            dtu_rtu_async_halt_req;               
wire    [63:0]  dtu_rtu_dpc;                          
wire            dtu_rtu_ebreak_action;                
wire    [63:0]  dtu_rtu_pending_tval;                 
wire            dtu_rtu_resume_req;                   
wire            dtu_rtu_step_en;                      
wire            dtu_rtu_sync_flush;                   
wire            dtu_rtu_sync_halt_req;                
wire            forever_cpuclk;                       
wire            halt_req;                             
wire            halt_req_buf_split_trigger_t1;        
wire            halt_req_dm_async;                    
wire            halt_req_dm_sync;                     
wire            halt_req_ebreak;                      
wire            halt_req_pending;                     
wire            halt_req_reset;                       
wire            halt_req_split_trigger_t1;            
wire            halt_req_step;                        
wire            halt_req_t1;                          
wire            halt_req_t1_raw;                      
wire            halt_req_t1_retire_vld;               
wire            halt_req_t1_retire_vld_raw;           
wire            halt_req_trigger_t0;                  
wire            halt_req_trigger_t1;                  
wire            halt_req_trigger_t1_raw;              
wire            ifu_rtu_reset_halt_req;               
wire            ifu_rtu_warm_up;                      
wire    [4 :0]  int_retire_int_vec;                   
wire            int_retire_int_vld;                   
wire            iu_rtu_depd_lsu_chgflow_vld;          
wire            iu_rtu_ex2_bju_ras_mispred;           
wire            iu_xx_no_op;                          
wire            lsu_rtu_async_expt_vld;               
wire            lsu_rtu_async_ld_inst;                
wire    [39:0]  lsu_rtu_async_tval;                   
wire            lsu_rtu_ex1_buffer_vld;               
wire            lsu_rtu_no_op;                        
wire            mmu_xx_mmu_en;                        
wire            pad_yy_icg_scan_en;                   
wire            retire_async_expt;                    
wire    [63:0]  retire_async_expt_tval;               
wire    [4 :0]  retire_async_expt_vec;                
wire            retire_async_trap_vld;                
wire            retire_bju_flush_req;                 
wire            retire_bkpt_expt;                     
wire            retire_bkpt_expt_lsu_trigger_t1;      
wire            retire_bkpt_expt_split_lsu_trigger_t1; 
wire            retire_bkpt_expt_t1;                  
wire            retire_chgflw_vld;                    
wire            retire_clk;                           
wire            retire_clk_en;                        
wire            retire_commit_clear;                  
wire            retire_commit_clear_for_bju;          
wire            retire_cpu_no_op;                     
wire            retire_ctrl_commit_clear;             
wire            retire_ctrl_commit_clear_for_bju;     
wire            retire_dbg_mode_async_trap_vld;       
wire            retire_debug_flush;                   
wire            retire_ex2_retire_normal;             
wire            retire_ex2_retire_vld;                
wire            retire_exit_debug;                    
wire            retire_expt_debug;                    
wire            retire_expt_inst;                     
wire            retire_flush_be;                      
wire            retire_flush_fe;                      
wire            retire_flush_fe_set;                  
wire            retire_flush_wait;                    
wire            retire_fs_dirty;                      
wire    [21:0]  retire_halt_info;                     
wire            retire_inst_expt;                     
wire    [4 :0]  retire_inst_expt_vec;                 
wire            retire_inst_flush;                    
wire            retire_inst_flush_fe_set;             
wire            retire_int_inst;                      
wire    [4 :0]  retire_int_vec;                       
wire            retire_mmu_trap;                      
wire            retire_pending_bkpt_expt;             
wire            retire_pipeline_empty;                
wire            retire_rbus_fs_dirty;                 
wire            retire_rbus_vs_dirty;                 
wire            retire_sync_expt;                     
wire    [39:0]  retire_sync_tval;                     
wire    [63:0]  retire_sync_tval_64;                  
wire    [10:0]  retire_top_dbg_info;                  
wire    [63:0]  retire_trap_epc_64;                   
wire            retire_trap_int;                      
wire            retire_trap_vld;                      
wire            retire_tval_use_pipeline;             
wire            retire_vs_dirty;                      
wire    [6 :0]  retire_vstart;                        
wire            retire_vstart_updt;                   
wire    [63:0]  rtu_cp0_epc;                          
wire            rtu_cp0_exit_debug;                   
wire    [63:0]  rtu_cp0_tval;                         
wire    [6 :0]  rtu_cp0_vstart;                       
wire            rtu_cp0_vstart_vld;                   
wire            rtu_cpu_no_retire;                    
wire    [63:0]  rtu_dtu_dpc;                          
wire            rtu_dtu_halt_ack;                     
wire            rtu_dtu_pending_ack;                  
wire            rtu_dtu_retire_chgflw;                
wire            rtu_dtu_retire_debug_expt_vld;        
wire            rtu_dtu_retire_mret;                  
wire    [39:0]  rtu_dtu_retire_next_pc;               
wire            rtu_dtu_retire_sret;                  
wire            rtu_dtu_retire_vld;                   
wire            rtu_hpcp_int_vld;                     
wire            rtu_hpcp_retire_inst_vld;             
wire    [39:0]  rtu_hpcp_retire_pc;                   
wire            rtu_idu_flush_fe;                     
wire            rtu_idu_flush_stall;                  
wire            rtu_idu_flush_wbt;                    
wire            rtu_idu_pipeline_empty;               
wire    [39:0]  rtu_ifu_chgflw_pc;                    
wire            rtu_ifu_chgflw_vld;                   
wire            rtu_ifu_dbg_mask;                     
wire            rtu_ifu_flush_fe;                     
wire            rtu_lsu_async_expt_ack;               
wire            rtu_lsu_expt_ack;                     
wire            rtu_lsu_expt_exit;                    
wire    [26:0]  rtu_mmu_bad_vpn;                      
wire            rtu_mmu_expt_vld;                     
wire            rtu_pad_halted;                       
wire            rtu_pad_retire;                       
wire    [39:0]  rtu_pad_retire_pc;                    
wire            rtu_vidu_flush_wbt;                   
wire            rtu_yy_xx_async_flush;                
wire            rtu_yy_xx_dbgon;                      
wire            rtu_yy_xx_expt_int;                   
wire    [4 :0]  rtu_yy_xx_expt_vec;                   
wire            rtu_yy_xx_expt_vld;                   
wire            rtu_yy_xx_flush;                      
wire            rtu_yy_xx_flush_fe;                   
wire            vidu_rtu_no_op;                       
wire            vpu_rtu_no_op;                        
wire            wb_retire_wb_no_op;                   


//==========================================================
//                          Retire
//==========================================================
assign retire_ex2_retire_vld    = ctrl_retire_ex2_retire_vld;
//inst with async expt should commit its result
assign retire_ex2_retire_normal = retire_ex2_retire_vld
                                  && !retire_sync_expt;

//==========================================================
//                       Trap Process
//==========================================================
//----------------------------------------------------------
//                           Expt
//----------------------------------------------------------
// Expt source includes:
//   1. EX1 Expt
//   2. bus error
//   3. breakpoint
assign retire_inst_expt             = dp_retire_ex2_inst_expt || retire_bkpt_expt;
assign retire_inst_expt_vec[4:0]    = dp_retire_ex2_vec[4:0];

assign retire_async_expt            = lsu_rtu_async_expt_vld;
assign retire_async_expt_vec[4:0]   = lsu_rtu_async_ld_inst ? 5'd5
                                                            : 5'd7;
assign retire_async_expt_tval[63:0] = {24'b0, lsu_rtu_async_tval[39:0]};

assign retire_sync_expt             = retire_inst_expt
                                   || retire_pending_bkpt_expt;

assign retire_expt_inst             = retire_sync_expt
                                   || retire_async_expt;
//expt in debug mode: expt except bkpt will set cmderr3
assign retire_expt_debug            = retire_pending_bkpt_expt
                                   || retire_async_expt
                                   || dp_retire_ex2_inst_expt
                                      && !retire_bkpt_expt;

//----------------------------------------------------------
//                           Int
//----------------------------------------------------------
// Int source from rtu_int.
assign retire_int_inst        = int_retire_int_vld;
assign retire_int_vec[4:0]    = int_retire_int_vec[4:0];

//----------------------------------------------------------
//                       Trap Vector
//----------------------------------------------------------
// Trap level:
//   1. pending bkpt expt
//   2. Int
//   3. async expt
//   4. sync expt
// &CombBeg; @83
always @( retire_inst_expt_vec[4:0]
       or retire_async_expt
       or retire_bkpt_expt
       or retire_int_vec[4:0]
       or retire_async_expt_vec[4:0]
       or retire_int_inst
       or retire_pending_bkpt_expt)
begin
  if (retire_pending_bkpt_expt)
    retire_trap_vec[4:0] = 5'd3;
  else if (retire_int_inst)
    retire_trap_vec[4:0] = retire_int_vec[4:0];
  else if (retire_async_expt)
    retire_trap_vec[4:0] = retire_async_expt_vec[4:0];
  else if (retire_bkpt_expt)
    retire_trap_vec[4:0] = 5'd3;
  else
    retire_trap_vec[4:0] = retire_inst_expt_vec[4:0];
// &CombEnd; @94
end

assign retire_mmu_trap = retire_trap_vec[4:0] == 5'd1
                      || retire_trap_vec[4:0] == 5'd13
                      || retire_trap_vec[4:0] == 5'd15;

//----------------------------------------------------------
//                        Trap TVAL
//----------------------------------------------------------
// 0, 1, 12 inst fetch expt use pc+if_high.
// 2 ill inst use opcode
// 4, 5, 6, 7, 13, 15 ld/st use addr.
//   bus err addr from async tval. others is in pipeline tval.
assign retire_tval_use_pipeline  = retire_inst_expt_vec[4:0] == 5'b1
                                || retire_inst_expt_vec[4:0] == 5'd2
                                || retire_inst_expt_vec[4:0] == 5'd4
                                || retire_inst_expt_vec[4:0] == 5'd5
                                || retire_inst_expt_vec[4:0] == 5'd6
                                || retire_inst_expt_vec[4:0] == 5'd7
                                || retire_inst_expt_vec[4:0] == 5'd12
                                || retire_inst_expt_vec[4:0] == 5'd13
                                || retire_inst_expt_vec[4:0] == 5'd15
                                || bkpt_req_trigger_t0;

assign retire_sync_tval[39:0]    = dp_retire_ex2_tval[39:0];
assign retire_sync_tval_64[63:0] = mmu_xx_mmu_en
                                   ? {{24{retire_sync_tval[39]}}, retire_sync_tval[39:0]}
                                   : {24'b0, retire_sync_tval[39:0]};

// &CombBeg; @123
always @( retire_async_expt
       or retire_sync_tval_64[63:0]
       or retire_async_expt_tval[63:0]
       or retire_int_inst
       or retire_tval_use_pipeline
       or dtu_rtu_pending_tval[63:0]
       or retire_pending_bkpt_expt)
begin
  if (retire_pending_bkpt_expt)
    retire_trap_tval[63:0] = dtu_rtu_pending_tval[63:0];
  else if (retire_int_inst)
    retire_trap_tval[63:0] = 64'b0;
  else if (retire_async_expt)
    retire_trap_tval[63:0] = retire_async_expt_tval[63:0];
  else if (retire_tval_use_pipeline)
    retire_trap_tval[63:0] = retire_sync_tval_64[63:0];
  else
    retire_trap_tval[63:0] = 64'b0;
// &CombEnd; @134
end

//----------------------------------------------------------
//                         Trap EPC
//----------------------------------------------------------
// epc save next pc:
//   1. only int
//   2. only async expt without split
//   3. int with async expt.
// epc save cur pc:
//   1. sync expt
//   2. async expt with split
//   3. async expt with sync expt
//   4. int with sync expt
// &CombBeg; @148
always @( retire_async_expt
       or dp_retire_ex2_inst_split
       or dp_retire_ex2_cur_pc[39:0]
       or dp_retire_ex2_next_pc[39:0]
       or retire_sync_expt)
begin
  if (retire_sync_expt
   || retire_async_expt && dp_retire_ex2_inst_split)
    retire_trap_epc[39:0] = dp_retire_ex2_cur_pc[39:0];
  else
    retire_trap_epc[39:0] = dp_retire_ex2_next_pc[39:0];
// &CombEnd; @154
end

assign retire_trap_epc_64[39:0]  = retire_trap_epc[39:0];
assign retire_trap_epc_64[63:40] = {24{mmu_xx_mmu_en && retire_trap_epc[39]}};

//----------------------------------------------------------
//                         Trap Ack
//----------------------------------------------------------
assign retire_trap_vld = retire_ex2_retire_vld
                         && !halt_req && !dbg_mode_on
                         && (retire_expt_inst || retire_int_inst);

assign retire_trap_int = retire_int_inst && !retire_pending_bkpt_expt;

//----------------------------------------------------------
//                        Async Ack
//----------------------------------------------------------
assign retire_async_trap_vld = retire_async_expt
                               && retire_trap_vld
                               && (!retire_int_inst
                                  || !retire_pending_bkpt_expt);
//debug mode async trap
assign retire_dbg_mode_async_trap_vld = retire_async_expt
                                        && retire_ex2_retire_vld
                                        &&  !retire_pending_bkpt_expt;

//==========================================================
//                      Debug Process
//==========================================================
//----------------------------------------------------------
//                Halt Request : Timing 0
//----------------------------------------------------------
//t0 halt request will enter debug mode when not in debug mode
assign halt_req_reset            = ifu_rtu_reset_halt_req;
//async halt req ignore db      g_mode_on
assign halt_req_dm_async         = dtu_rtu_async_halt_req;
assign halt_req_ebreak           = retire_ex2_retire_vld
                                   && dtu_rtu_ebreak_action
                                   && dp_retire_ex2_inst_ebreak
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dbg_mode_on_after_req;
assign halt_req_trigger_t0       = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dbg_mode_on_after_req;
assign halt_req_pending          = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION]
                                   && !dbg_mode_on_after_req;
//t0 halt request
assign halt_req                  = halt_req_reset
                                || halt_req_ebreak
                                || halt_req_trigger_t0
                                || halt_req_pending
                                || halt_req_dm_async;

//----------------------------------------------------------
//                Halt Request : Timing 1
//----------------------------------------------------------
//cannot ack t1 halt request when:
//1.inst with pending halt or expt
//2.in debug mode
assign halt_req_t1_retire_vld_raw = retire_ex2_retire_vld
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                    && !dbg_mode_on_after_req;
//3.ack t0 halt request
//4.t1 bkpt expt request (see below)
assign halt_req_t1_retire_vld     = halt_req_t1_retire_vld_raw
                                    && !halt_req;
//Halt Request with Timing 1
assign halt_req_dm_sync           = halt_req_t1_retire_vld
                                    && !dp_retire_ex2_inst_split
                                    && dtu_rtu_sync_halt_req;
assign halt_req_step              = halt_req_t1_retire_vld
                                    && !dp_retire_ex2_inst_split
                                    && dtu_rtu_step_en;
assign halt_req_trigger_t1_raw    = halt_req_t1_retire_vld
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
// &Force("nonport","veri_halt_req_t1"); @239

//split inst t1 trigger will be buffered and ack in last split inst
assign halt_req_trigger_t1        = halt_req_trigger_t1_raw
                                    && !dp_retire_ex2_inst_split;
assign halt_req_split_trigger_t1  = halt_req_trigger_t1_raw
                                    && dp_retire_ex2_inst_split;
//buffered split trigger will ack at non-split inst
assign halt_req_buf_split_trigger_t1 = halt_req_t1_retire_vld
                                   && !dp_retire_ex2_inst_split
                                   && halt_req_split_trigger_t1_buf;

//t1 halt request will generate inst flush and signal dtu pending halt
assign halt_req_t1_raw            = halt_req_dm_sync
                                 || halt_req_trigger_t1
                                 || halt_req_buf_split_trigger_t1
                                 || halt_req_step;

//cannot ack t1 halt request when:
//4.t1 bkpt expt request
assign halt_req_t1                = halt_req_t1_raw
                                    && !retire_bkpt_expt_t1;

//----------------------------------------------------------
//              Bkpt Expt Request : Timing 0
//----------------------------------------------------------
assign bkpt_req_ebreak           = retire_ex2_retire_vld
                                   && !dtu_rtu_ebreak_action
                                   && dp_retire_ex2_inst_ebreak
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT];
assign bkpt_req_pending          = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];

assign bkpt_req_trigger_t0       = retire_ex2_retire_vld
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
//normal bkpt expt includes       ebreak and t0 trigger
assign retire_bkpt_expt          = bkpt_req_ebreak
                                   || bkpt_req_trigger_t0;
//pending bkpt expt has highest priority
assign retire_pending_bkpt_expt  = bkpt_req_pending;

//----------------------------------------------------------
//              Bkpt Expt Request : Timing 1
//----------------------------------------------------------
//cannot ack t1 halt request when:
//1.inst with pending halt or expt
assign bkpt_req_t1_retire_vld_raw = retire_ex2_retire_vld
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT];
//2.ack t0 halt request
assign bkpt_req_t1_retire_vld     = bkpt_req_t1_retire_vld_raw
                                    && !halt_req;
//Halt Request with Timing 1
assign bkpt_req_trigger_t1_raw    = bkpt_req_t1_retire_vld
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
// &Force("nonport","veri_retire_bkpt_expt_t1"); @318
//split inst t1 trigger will be buffered and ack in last split inst
assign bkpt_req_trigger_t1        = bkpt_req_trigger_t1_raw
                                    && !dp_retire_ex2_inst_split;
assign bkpt_req_split_trigger_t1  = bkpt_req_trigger_t1_raw
                                    && dp_retire_ex2_inst_split;
//buffered split trigger will ack  at non-split inst
assign bkpt_req_buf_split_trigger_t1 = bkpt_req_t1_retire_vld
                                   && bkpt_req_split_trigger_t1_buf
                                   && !dp_retire_ex2_inst_split;

assign retire_bkpt_expt_t1        = bkpt_req_trigger_t1
                                 || bkpt_req_buf_split_trigger_t1;

assign retire_bkpt_expt_lsu_trigger_t1       = bkpt_req_trigger_t1
                                               && dp_retire_ex2_halt_info[`TDT_HINFO_LDST];
assign retire_bkpt_expt_split_lsu_trigger_t1 = bkpt_req_buf_split_trigger_t1
                                               && bkpt_req_split_lsu_trigger_buf;

//----------------------------------------------------------
//                   Debug Sync Flush
//----------------------------------------------------------
//when dtu signal sync flush, rtu should flush when any inst
//retire: include step and icount
assign retire_debug_flush  = retire_ex2_retire_vld
                             && dtu_rtu_sync_flush
                             && !dp_retire_ex2_inst_split
                             && !dbg_mode_on_after_req;

//----------------------------------------------------------
//                     Exit Debug Mode
//----------------------------------------------------------
//exit debug ignore exception:
//execute dret in debug mode should not generate exception
assign retire_exit_debug   = dbg_mode_on_after_req
                             && (dtu_rtu_resume_req
                              || retire_ex2_retire_vld
                                 && dp_retire_ex2_inst_dret);

//----------------------------------------------------------
//                     Cause Select
//----------------------------------------------------------
//select cause according to priority
//not includes itrigger and etrigger, which fire in 
// &CombBeg; @370
always @( halt_req_trigger_t0
       or halt_req_buf_split_trigger_t1
       or halt_req_pending
       or halt_req_dm_sync
       or dp_retire_ex2_halt_info[11:8]
       or halt_req_ebreak
       or halt_req_reset
       or halt_req_trigger_t1
       or halt_req_dm_async)
begin
  if(halt_req_dm_async)
    halt_cause[3:0] = 4'd8;
  else if(halt_req_pending)
    halt_cause[3:0] = dp_retire_ex2_halt_info[`TDT_HINFO_CAUSE:`TDT_HINFO_CAUSE-3];
  else if(halt_req_trigger_t0
       || halt_req_trigger_t1
       || halt_req_buf_split_trigger_t1)
    halt_cause[3:0] = 4'd2;
  else if(halt_req_ebreak)
    halt_cause[3:0] = 4'd1;
  else if(halt_req_reset)
    halt_cause[3:0] = 4'd5;
  else if(halt_req_dm_sync)
    halt_cause[3:0] = 4'd3;
  else //halt_req_step
    halt_cause[3:0] = 4'd4;
// &CombEnd; @387
end

//----------------------------------------------------------
//                       Debug Mode
//----------------------------------------------------------
//debug mode on after request:
//used to mask ifu inst fetch and new halt request
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dbg_mode_on_after_req <= 1'b0;
  else if (halt_req)
    dbg_mode_on_after_req <= 1'b1;
  else if (retire_exit_debug)
    dbg_mode_on_after_req <= 1'b0;
end

//debug mode on after flush be:
//indicate hart is in halt
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dbg_mode_on <= 1'b0;
  else if (retire_flush_be && dbg_mode_on_after_req)
    dbg_mode_on <= 1'b1;
  else if (retire_exit_debug)
    dbg_mode_on <= 1'b0;
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_async_flush <= 1'b0;
  else
    retire_async_flush <= halt_req_dm_async;
end

//----------------------------------------------------------
//                Split inst t1 halt info
//----------------------------------------------------------
//if split inst hit t0 trigger, it will ack as normal inst
//if split inst hit t1 trigger, rtu will buffer and merge
//halt info, then ack at last split inst (!split)
//if split inst flush, t1 halt info will be flushed
//chain 1 match will clear/not merge into halt info 
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    halt_req_split_trigger_t1_buf <= 1'b0;
  else if (retire_flush_be || halt_req_trigger_t1)
    halt_req_split_trigger_t1_buf <= 1'b0;
  else if (halt_req_split_trigger_t1)
    halt_req_split_trigger_t1_buf <= 1'b1;
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b0;
    bkpt_req_split_lsu_trigger_buf <= 1'b0;
  end
  else if (retire_flush_be || bkpt_req_trigger_t1) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b0;
    bkpt_req_split_lsu_trigger_buf <= 1'b0;
  end
  else if (bkpt_req_split_trigger_t1) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b1;
    bkpt_req_split_lsu_trigger_buf <= dp_retire_ex2_halt_info[`TDT_HINFO_LDST];
  end
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if (retire_flush_be || halt_req_trigger_t1 || bkpt_req_trigger_t1)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if (halt_req_split_trigger_t1 || bkpt_req_split_trigger_t1)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <=
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0]
                | dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//----------------------------------------------------------
//                Retire Halt Info
//----------------------------------------------------------
//if there is buffered split trigger t1 halt/bkpt req
//merge buffered halt info into retired halt info
assign retire_halt_info[`TDT_HINFO_WIDTH-1:0] =
    dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
  | {`TDT_HINFO_WIDTH{(halt_req_buf_split_trigger_t1
                    || bkpt_req_buf_split_trigger_t1)}}
    & retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0];

//==========================================================
//                      Flush Control
//==========================================================
assign retire_inst_flush    = dp_retire_ex2_inst_flush;
assign retire_bju_flush_req = iu_rtu_ex2_bju_ras_mispred
                              || iu_rtu_depd_lsu_chgflow_vld;

//----------------------------------------------------------
//                        Flush Set
//----------------------------------------------------------
// Flush fe will be set when:
//   1. int/ expt
//   2. flush inst
//   3. t1 bkpt expt
//   4. t0 and t1 halt req:
//      halt req will sync with inst retire by itself
assign retire_inst_flush_fe_set    = retire_ex2_retire_vld
                                     && (retire_expt_inst
                                      || retire_int_inst
                                      || retire_inst_flush
                                      || retire_vstart_updt
                                      || retire_bkpt_expt_t1
                                      || retire_debug_flush)
                                     || halt_req
                                     || halt_req_t1;
//   5. bju flush(without retire)
assign retire_flush_fe_set         = retire_inst_flush_fe_set
                                     || retire_bju_flush_req;

assign retire_commit_clear         = retire_inst_flush_fe_set
                                     || retire_bju_flush_req
                                     || retire_flush_fe;

assign retire_commit_clear_for_bju = retire_inst_flush_fe_set
                                     || iu_rtu_ex2_bju_ras_mispred
                                     || retire_flush_fe;

//----------------------------------------------------------
//                        Flush FSM
//----------------------------------------------------------
parameter FLUSH_IDLE  = 3'b000;
parameter FLUSH_FE    = 3'b001;
parameter FLUSH_WAIT  = 3'b100;
parameter FLUSH_BE    = 3'b010;
parameter FLUSH_FE_BE = 3'b011;

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    flush_cur_state[2:0] <= 3'b0;
  else if (halt_req_dm_async)
    flush_cur_state[2:0] <= FLUSH_FE_BE;
  else
    flush_cur_state[2:0] <= flush_next_state[2:0];
end

// &CombBeg; @537
always @( retire_cpu_no_op
       or retire_flush_fe_set
       or flush_cur_state)
begin
  case(flush_cur_state)
  FLUSH_IDLE:
    if (retire_flush_fe_set)
      flush_next_state = FLUSH_FE;
    else
      flush_next_state = FLUSH_IDLE;
  FLUSH_FE:
    if (retire_cpu_no_op)
      flush_next_state = FLUSH_BE;
    else
      flush_next_state = FLUSH_WAIT;
  FLUSH_WAIT:
    if (retire_cpu_no_op)
      flush_next_state = FLUSH_BE;
    else
      flush_next_state = FLUSH_WAIT;
  FLUSH_BE:
    flush_next_state = FLUSH_IDLE;
  FLUSH_FE_BE:
    flush_next_state = FLUSH_IDLE;
  default:
    flush_next_state = FLUSH_IDLE;
  endcase
// &CombEnd; @561
end

assign retire_flush_wait = flush_cur_state == FLUSH_WAIT;
assign retire_flush_fe   = flush_cur_state[0];
assign retire_flush_be   = flush_cur_state[1];

assign retire_cpu_no_op      = !retire_ex2_retire_vld
                               && wb_retire_wb_no_op
                               && lsu_rtu_no_op
                               && iu_xx_no_op
                               && vpu_rtu_no_op
                               && vidu_rtu_no_op;
assign retire_pipeline_empty = retire_cpu_no_op
                               && !lsu_rtu_ex1_buffer_vld;

//==========================================================
//                        Changeflow
//==========================================================
// To opt timing, trap_vld chgflw will be flop.
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_trap_chgflw_vld <= 1'b0;
  else if (retire_trap_vld)
    retire_trap_chgflw_vld <= 1'b1;
  else if (retire_flush_be)
    retire_trap_chgflw_vld <= 1'b0;
end

assign retire_chgflw_vld = 
            retire_ex2_retire_vld && !retire_trap_vld
            && (dp_retire_ex2_inst_chgflw || dp_retire_ex2_inst_flush)
         || retire_vstart_updt && !retire_trap_vld
         || retire_trap_chgflw_vld && retire_flush_fe
         || retire_exit_debug;

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_xret_vld <= 1'b0;
  else if (retire_ex2_retire_normal && (dp_retire_ex2_inst_mret
                                     || dp_retire_ex2_inst_sret))
    retire_xret_vld <= 1'b1;
  else if (retire_flush_be)
    retire_xret_vld <= 1'b0;
end

//----------------------------------------------------------
//                      Changeflow PC
//----------------------------------------------------------
// &Force("bus","dtu_rtu_dpc",63,0); @611
// &CombBeg; @612
always @( retire_exit_debug
       or cp0_rtu_trap_pc[39:0]
       or dp_retire_ex2_next_pc[39:0]
       or dtu_rtu_dpc[39:0]
       or retire_trap_chgflw_vld)
begin
  if(retire_exit_debug)
    retire_chgflw_pc[39:0] = dtu_rtu_dpc[39:0];
  else if(retire_trap_chgflw_vld)
    retire_chgflw_pc[39:0] = cp0_rtu_trap_pc[39:0];
  else
    retire_chgflw_pc[39:0] = dp_retire_ex2_next_pc[39:0];
// &CombEnd; @619
end

//==========================================================
//                      VSTART Update
//==========================================================
//vstart should update when lsu expt (including data trigger hit)
//(use inst expt here because vstart inst can only from lsu)
assign retire_vstart_updt = retire_ex2_retire_vld
                            && !retire_pending_bkpt_expt
                            && dp_retire_ex2_inst_vstart
                            && (retire_inst_expt
                            || !retire_inst_expt && !cp0_rtu_vstart_eq_0);
assign retire_vstart[6:0] = {7{retire_inst_expt}} & dp_retire_ex2_vstart[6:0];

//==========================================================
//                       FS VS Dirty
//==========================================================
assign retire_fs_dirty = retire_ex2_retire_normal && dp_retire_ex2_fs_dirty;
assign retire_vs_dirty = retire_ex2_retire_normal && dp_retire_ex2_vs_dirty;

//==========================================================
//                   No Retire For Debug
//==========================================================
always @ (posedge forever_cpuclk)
begin
  if (retire_ex2_retire_vld || ifu_rtu_warm_up)
    retire_cnt[31:0] <= 32'b0;
  else
    retire_cnt[31:0] <= retire_cnt[31:0] + 32'b1;
end

always @ (posedge forever_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    no_retire <= 1'b0;
  else if (retire_ex2_retire_vld)
    no_retire <= 1'b0;
  else if (retire_cnt[31:0] == 32'd8192)
    no_retire <= 1'b1;
end

assign rtu_cpu_no_retire = !no_retire && retire_cnt[31:0] == 32'd8192 && cp0_rtu_fence_idle
                                                                      && !dbg_mode_on
                                                                      && !cp0_rtu_in_lpmd;
// &Force("input", "cp0_rtu_fence_idle"); @665
// &Force("input", "cp0_rtu_in_lpmd"); @666

//==========================================================
//                     HPCP Information
//==========================================================
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_int_vld_flop <= 1'b0;
  else
    retire_int_vld_flop <= retire_trap_vld && retire_trap_int;
end

//==========================================================
//                           ICG
//==========================================================
assign retire_clk_en = halt_req
                    || retire_exit_debug
                    || retire_flush_fe_set
                    || retire_trap_chgflw_vld
                    || flush_cur_state != FLUSH_IDLE
                    || retire_async_flush
                    || halt_req_trigger_t1
                    || halt_req_split_trigger_t1
                    || bkpt_req_trigger_t1
                    || bkpt_req_split_trigger_t1;
// &Instance("gated_clk_cell", "x_retire_clk"); @692
gated_clk_cell  x_retire_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (retire_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (retire_clk_en     ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @693
//          .external_en (1'b0), @694
//          .global_en   (cp0_yy_clk_en), @695
//          .module_en   (cp0_rtu_icg_en), @696
//          .local_en    (retire_clk_en), @697
//          .clk_out     (retire_clk)); @698

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign retire_ctrl_commit_clear         = retire_commit_clear;
assign retire_ctrl_commit_clear_for_bju = retire_commit_clear_for_bju;

assign retire_rbus_fs_dirty             = retire_fs_dirty;
assign retire_rbus_vs_dirty             = retire_vs_dirty;

assign retire_top_dbg_info[10:0] = {retire_ex2_retire_vld,
                                    dbg_mode_on_after_req,
                                    flush_cur_state[2:0],
                                    retire_cpu_no_op,
                                    lsu_rtu_ex1_buffer_vld,
                                    lsu_rtu_no_op,
                                    iu_xx_no_op,
                                    vpu_rtu_no_op,
                                    vidu_rtu_no_op};

//----------------------------------------------------------
//                          For xx
//----------------------------------------------------------
assign rtu_yy_xx_expt_vld      = retire_trap_vld;
assign rtu_yy_xx_expt_int      = retire_trap_int;
assign rtu_yy_xx_expt_vec[4:0] = retire_trap_vec[4:0];

assign rtu_yy_xx_dbgon         = dbg_mode_on;

assign rtu_yy_xx_flush_fe      = retire_flush_fe;
assign rtu_yy_xx_flush         = retire_flush_be;

assign rtu_yy_xx_async_flush   = retire_async_flush;

//----------------------------------------------------------
//                         For Pad
//----------------------------------------------------------
assign rtu_pad_retire          = retire_ex2_retire_vld;
assign rtu_pad_retire_pc[39:0] = dp_retire_ex2_cur_pc[39:0];
assign rtu_pad_halted          = dbg_mode_on;

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
//trigger signals
// &CombBeg; @750
always @( halt_req_t1_raw
       or halt_req
       or retire_bkpt_expt_t1
       or halt_req_buf_split_trigger_t1
       or retire_halt_info[21:0]
       or bkpt_req_buf_split_trigger_t1
       or halt_req_t1
       or halt_cause[3:0])
begin
  rtu_dtu_retire_halt_info[`TDT_HINFO_WIDTH-1:0] = retire_halt_info[`TDT_HINFO_WIDTH-1:0];
  if(1'b1) begin
  rtu_dtu_retire_halt_info[`TDT_HINFO_ACTION]       = halt_req    || halt_req_t1;
  rtu_dtu_retire_halt_info[`TDT_HINFO_PENDING_HALT] = halt_req_t1 || retire_bkpt_expt_t1;
  rtu_dtu_retire_halt_info[`TDT_HINFO_ACTION01]     = retire_halt_info[`TDT_HINFO_ACTION01]
                                                      || halt_req_buf_split_trigger_t1
                                                      && bkpt_req_buf_split_trigger_t1
                                                      || retire_bkpt_expt_t1
                                                      && halt_req_t1_raw;
  rtu_dtu_retire_halt_info[`TDT_HINFO_CAUSE:`TDT_HINFO_CAUSE-3] = halt_cause[3:0];
  end
// &CombEnd; @762
end

//halt signals
assign rtu_dtu_dpc[63:0]             = dtu_rtu_async_halt_req && async_select_next_pc ?
                                       {{24{dp_retire_ex2_next_pc[39]}},dp_retire_ex2_next_pc[39:0]} :
                                       {{24{dp_retire_ex2_cur_pc[39]}},dp_retire_ex2_cur_pc[39:0]};

// &CombBeg; @769
always @( retire_bkpt_expt_split_lsu_trigger_t1
       or retire_sync_tval_64[63:0]
       or dp_retire_ex2_cur_pc[39:0]
       or retire_bkpt_expt_lsu_trigger_t1)
begin
  //if load/store mcontrol, update load/store address
  if(retire_bkpt_expt_lsu_trigger_t1)
    rtu_dtu_tval[63:0]               = retire_sync_tval_64[63:0];
  //if split load/store mcontrol, update 0
  else if(retire_bkpt_expt_split_lsu_trigger_t1)
    rtu_dtu_tval[63:0]               = 64'b0;
  //otherwise update cur pc
  else
    rtu_dtu_tval[63:0]               = {{24{dp_retire_ex2_cur_pc[39]}},
                                            dp_retire_ex2_cur_pc[39:0]};
// &CombEnd; @780
end

assign rtu_dtu_halt_ack              = halt_req;
assign rtu_dtu_pending_ack           = halt_req_pending || bkpt_req_pending;

//inst retire and pcfifo
assign rtu_dtu_retire_vld            = retire_ex2_retire_vld
                                       && (retire_flush_fe_set || !dp_retire_ex2_inst_split);
assign rtu_dtu_retire_debug_expt_vld = retire_ex2_retire_vld
                                       && dbg_mode_on
                                       && retire_expt_debug;
assign rtu_dtu_retire_mret           = dp_retire_ex2_inst_mret;
assign rtu_dtu_retire_sret           = dp_retire_ex2_inst_sret;
assign rtu_dtu_retire_chgflw         = dp_retire_ex2_inst_branch;
assign rtu_dtu_retire_next_pc[39:0]  = dp_retire_ex2_next_pc[39:0];

//----------------------------------------------------------
//                         For IFU
//----------------------------------------------------------
assign rtu_ifu_chgflw_vld       = retire_chgflw_vld;
assign rtu_ifu_flush_fe         = retire_flush_fe;
assign rtu_ifu_chgflw_pc[39:0]  = retire_chgflw_pc[39:0];

assign rtu_ifu_dbg_mask         = dbg_mode_on_after_req;

//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign rtu_cp0_epc[63:0]        = retire_trap_epc_64[63:0];
assign rtu_cp0_tval[63:0]       = retire_trap_tval[63:0];

assign rtu_cp0_vstart_vld       = retire_vstart_updt;
assign rtu_cp0_vstart[6:0]      = retire_vstart[6:0];

assign rtu_cp0_exit_debug       = retire_exit_debug;

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign rtu_idu_flush_stall      = retire_flush_wait || retire_flush_be;
assign rtu_idu_pipeline_empty   = retire_pipeline_empty;
assign rtu_idu_flush_fe         = retire_flush_fe;
assign rtu_idu_flush_wbt        = retire_flush_be;
assign rtu_vidu_flush_wbt       = retire_flush_be;

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign rtu_lsu_expt_ack         = retire_trap_chgflw_vld && retire_flush_be;
assign rtu_lsu_expt_exit        = retire_xret_vld && retire_flush_be;
assign rtu_lsu_async_expt_ack   = dbg_mode_on
                                  ? retire_dbg_mode_async_trap_vld
                                  : retire_async_trap_vld;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
// &Force("input", "hpcp_rtu_cnt_en"); @837
assign rtu_hpcp_retire_inst_vld = retire_ex2_retire_vld && !dp_retire_ex2_inst_split;
assign rtu_hpcp_retire_pc[39:0] = dp_retire_ex2_cur_pc[39:0]; 
assign rtu_hpcp_int_vld         = retire_int_vld_flop;

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign rtu_mmu_expt_vld         = retire_trap_vld
                                  && !retire_trap_int && retire_mmu_trap;
assign rtu_mmu_bad_vpn[26:0]    = retire_trap_tval[38:12];

// &Force("output","flush_next_state"); @850

// &ModuleEnd; @853
endmodule



