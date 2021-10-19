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
module aq_rtu_top(
  cp0_rtu_ex1_chgflw,
  cp0_rtu_ex1_chgflw_pc,
  cp0_rtu_ex1_cmplt,
  cp0_rtu_ex1_cmplt_dp,
  cp0_rtu_ex1_expt_tval,
  cp0_rtu_ex1_expt_vec,
  cp0_rtu_ex1_expt_vld,
  cp0_rtu_ex1_flush,
  cp0_rtu_ex1_halt_info,
  cp0_rtu_ex1_inst_dret,
  cp0_rtu_ex1_inst_ebreak,
  cp0_rtu_ex1_inst_len,
  cp0_rtu_ex1_inst_mret,
  cp0_rtu_ex1_inst_split,
  cp0_rtu_ex1_inst_sret,
  cp0_rtu_ex1_vs_dirty,
  cp0_rtu_ex1_vs_dirty_dp,
  cp0_rtu_ex1_wb_data,
  cp0_rtu_ex1_wb_dp,
  cp0_rtu_ex1_wb_preg,
  cp0_rtu_ex1_wb_vld,
  cp0_rtu_fence_idle,
  cp0_rtu_icg_en,
  cp0_rtu_in_lpmd,
  cp0_rtu_int_vld,
  cp0_rtu_trap_pc,
  cp0_rtu_vstart_eq_0,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_rtu_async_halt_req,
  dtu_rtu_dpc,
  dtu_rtu_ebreak_action,
  dtu_rtu_int_mask,
  dtu_rtu_pending_tval,
  dtu_rtu_resume_req,
  dtu_rtu_step_en,
  dtu_rtu_sync_flush,
  dtu_rtu_sync_halt_req,
  forever_cpuclk,
  hpcp_rtu_cnt_en,
  ifu_rtu_reset_halt_req,
  ifu_rtu_warm_up,
  iu_rtu_depd_lsu_chgflow_vld,
  iu_rtu_depd_lsu_next_pc,
  iu_rtu_div_data,
  iu_rtu_div_preg,
  iu_rtu_div_wb_dp,
  iu_rtu_div_wb_vld,
  iu_rtu_ex1_alu_cmplt,
  iu_rtu_ex1_alu_cmplt_dp,
  iu_rtu_ex1_alu_data,
  iu_rtu_ex1_alu_inst_len,
  iu_rtu_ex1_alu_inst_split,
  iu_rtu_ex1_alu_preg,
  iu_rtu_ex1_alu_wb_dp,
  iu_rtu_ex1_alu_wb_vld,
  iu_rtu_ex1_bju_cmplt,
  iu_rtu_ex1_bju_cmplt_dp,
  iu_rtu_ex1_bju_data,
  iu_rtu_ex1_bju_inst_len,
  iu_rtu_ex1_bju_preg,
  iu_rtu_ex1_bju_wb_dp,
  iu_rtu_ex1_bju_wb_vld,
  iu_rtu_ex1_branch_inst,
  iu_rtu_ex1_cur_pc,
  iu_rtu_ex1_div_cmplt,
  iu_rtu_ex1_div_cmplt_dp,
  iu_rtu_ex1_mul_cmplt,
  iu_rtu_ex1_mul_cmplt_dp,
  iu_rtu_ex1_next_pc,
  iu_rtu_ex2_bju_ras_mispred,
  iu_rtu_ex3_mul_data,
  iu_rtu_ex3_mul_preg,
  iu_rtu_ex3_mul_wb_vld,
  iu_xx_no_op,
  lsu_rtu_async_expt_vld,
  lsu_rtu_async_ld_inst,
  lsu_rtu_async_tval,
  lsu_rtu_ex1_buffer_vld,
  lsu_rtu_ex1_cmplt,
  lsu_rtu_ex1_cmplt_dp,
  lsu_rtu_ex1_cmplt_for_pcgen,
  lsu_rtu_ex1_data,
  lsu_rtu_ex1_dest_reg,
  lsu_rtu_ex1_expt_tval,
  lsu_rtu_ex1_expt_vec,
  lsu_rtu_ex1_expt_vld,
  lsu_rtu_ex1_fs_dirty,
  lsu_rtu_ex1_halt_info,
  lsu_rtu_ex1_inst_len,
  lsu_rtu_ex1_inst_split,
  lsu_rtu_ex1_tval2_vld,
  lsu_rtu_ex1_vs_dirty,
  lsu_rtu_ex1_vstart,
  lsu_rtu_ex1_vstart_vld,
  lsu_rtu_ex1_wb_dp,
  lsu_rtu_ex1_wb_vld,
  lsu_rtu_ex2_data,
  lsu_rtu_ex2_data_vld,
  lsu_rtu_ex2_dest_reg,
  lsu_rtu_ex2_tval2,
  lsu_rtu_no_op,
  lsu_rtu_wb_data,
  lsu_rtu_wb_dest_reg,
  lsu_rtu_wb_vld,
  mmu_xx_mmu_en,
  pad_yy_icg_scan_en,
  rtu_cp0_epc,
  rtu_cp0_exit_debug,
  rtu_cp0_fflags,
  rtu_cp0_fflags_updt,
  rtu_cp0_fs_dirty_updt,
  rtu_cp0_fs_dirty_updt_dp,
  rtu_cp0_tval,
  rtu_cp0_vl,
  rtu_cp0_vl_vld,
  rtu_cp0_vs_dirty_updt,
  rtu_cp0_vs_dirty_updt_dp,
  rtu_cp0_vstart,
  rtu_cp0_vstart_vld,
  rtu_cp0_vxsat,
  rtu_cp0_vxsat_vld,
  rtu_cpu_no_retire,
  rtu_dtu_debug_info,
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
  rtu_idu_commit,
  rtu_idu_commit_for_bju,
  rtu_idu_flush_fe,
  rtu_idu_flush_stall,
  rtu_idu_flush_wbt,
  rtu_idu_fwd0_data,
  rtu_idu_fwd0_reg,
  rtu_idu_fwd0_vld,
  rtu_idu_fwd1_data,
  rtu_idu_fwd1_reg,
  rtu_idu_fwd1_vld,
  rtu_idu_fwd2_data,
  rtu_idu_fwd2_reg,
  rtu_idu_fwd2_vld,
  rtu_idu_pipeline_empty,
  rtu_idu_wb0_data,
  rtu_idu_wb0_reg,
  rtu_idu_wb0_vld,
  rtu_idu_wb1_data,
  rtu_idu_wb1_reg,
  rtu_idu_wb1_vld,
  rtu_ifu_chgflw_pc,
  rtu_ifu_chgflw_vld,
  rtu_ifu_dbg_mask,
  rtu_ifu_flush_fe,
  rtu_iu_div_wb_grant,
  rtu_iu_div_wb_grant_for_full,
  rtu_iu_ex1_cmplt,
  rtu_iu_ex1_cmplt_dp,
  rtu_iu_ex1_inst_len,
  rtu_iu_ex1_inst_split,
  rtu_iu_ex2_cur_pc,
  rtu_iu_ex2_next_pc,
  rtu_iu_mul_wb_grant,
  rtu_iu_mul_wb_grant_for_full,
  rtu_lsu_async_expt_ack,
  rtu_lsu_expt_ack,
  rtu_lsu_expt_exit,
  rtu_mmu_bad_vpn,
  rtu_mmu_expt_vld,
  rtu_pad_halted,
  rtu_pad_retire,
  rtu_pad_retire_pc,
  rtu_vidu_flush_wbt,
  rtu_vpu_gpr_wb_grnt,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  rtu_yy_xx_flush,
  rtu_yy_xx_flush_fe,
  vidu_rtu_no_op,
  vlsu_rtu_vl_updt_data,
  vlsu_rtu_vl_updt_vld,
  vpu_rtu_ex1_cmplt,
  vpu_rtu_ex1_cmplt_dp,
  vpu_rtu_ex1_fp_dirty,
  vpu_rtu_ex1_vec_dirty,
  vpu_rtu_fflag,
  vpu_rtu_fflag_vld,
  vpu_rtu_gpr_wb_data,
  vpu_rtu_gpr_wb_index,
  vpu_rtu_gpr_wb_req,
  vpu_rtu_no_op
);


// &Ports; @25
input           cp0_rtu_ex1_chgflw;              
input   [39:0]  cp0_rtu_ex1_chgflw_pc;           
input           cp0_rtu_ex1_cmplt;               
input           cp0_rtu_ex1_cmplt_dp;            
input   [39:0]  cp0_rtu_ex1_expt_tval;           
input   [4 :0]  cp0_rtu_ex1_expt_vec;            
input           cp0_rtu_ex1_expt_vld;            
input           cp0_rtu_ex1_flush;               
input   [21:0]  cp0_rtu_ex1_halt_info;           
input           cp0_rtu_ex1_inst_dret;           
input           cp0_rtu_ex1_inst_ebreak;         
input           cp0_rtu_ex1_inst_len;            
input           cp0_rtu_ex1_inst_mret;           
input           cp0_rtu_ex1_inst_split;          
input           cp0_rtu_ex1_inst_sret;           
input           cp0_rtu_ex1_vs_dirty;            
input           cp0_rtu_ex1_vs_dirty_dp;         
input   [63:0]  cp0_rtu_ex1_wb_data;             
input           cp0_rtu_ex1_wb_dp;               
input   [5 :0]  cp0_rtu_ex1_wb_preg;             
input           cp0_rtu_ex1_wb_vld;              
input           cp0_rtu_fence_idle;              
input           cp0_rtu_icg_en;                  
input           cp0_rtu_in_lpmd;                 
input   [14:0]  cp0_rtu_int_vld;                 
input   [39:0]  cp0_rtu_trap_pc;                 
input           cp0_rtu_vstart_eq_0;             
input           cp0_yy_clk_en;                   
input           cpurst_b;                        
input           dtu_rtu_async_halt_req;          
input   [63:0]  dtu_rtu_dpc;                     
input           dtu_rtu_ebreak_action;           
input           dtu_rtu_int_mask;                
input   [63:0]  dtu_rtu_pending_tval;            
input           dtu_rtu_resume_req;              
input           dtu_rtu_step_en;                 
input           dtu_rtu_sync_flush;              
input           dtu_rtu_sync_halt_req;           
input           forever_cpuclk;                  
input           hpcp_rtu_cnt_en;                 
input           ifu_rtu_reset_halt_req;          
input           ifu_rtu_warm_up;                 
input           iu_rtu_depd_lsu_chgflow_vld;     
input   [39:0]  iu_rtu_depd_lsu_next_pc;         
input   [63:0]  iu_rtu_div_data;                 
input   [5 :0]  iu_rtu_div_preg;                 
input           iu_rtu_div_wb_dp;                
input           iu_rtu_div_wb_vld;               
input           iu_rtu_ex1_alu_cmplt;            
input           iu_rtu_ex1_alu_cmplt_dp;         
input   [63:0]  iu_rtu_ex1_alu_data;             
input           iu_rtu_ex1_alu_inst_len;         
input           iu_rtu_ex1_alu_inst_split;       
input   [5 :0]  iu_rtu_ex1_alu_preg;             
input           iu_rtu_ex1_alu_wb_dp;            
input           iu_rtu_ex1_alu_wb_vld;           
input           iu_rtu_ex1_bju_cmplt;            
input           iu_rtu_ex1_bju_cmplt_dp;         
input   [63:0]  iu_rtu_ex1_bju_data;             
input           iu_rtu_ex1_bju_inst_len;         
input   [5 :0]  iu_rtu_ex1_bju_preg;             
input           iu_rtu_ex1_bju_wb_dp;            
input           iu_rtu_ex1_bju_wb_vld;           
input           iu_rtu_ex1_branch_inst;          
input   [39:0]  iu_rtu_ex1_cur_pc;               
input           iu_rtu_ex1_div_cmplt;            
input           iu_rtu_ex1_div_cmplt_dp;         
input           iu_rtu_ex1_mul_cmplt;            
input           iu_rtu_ex1_mul_cmplt_dp;         
input   [39:0]  iu_rtu_ex1_next_pc;              
input           iu_rtu_ex2_bju_ras_mispred;      
input   [63:0]  iu_rtu_ex3_mul_data;             
input   [5 :0]  iu_rtu_ex3_mul_preg;             
input           iu_rtu_ex3_mul_wb_vld;           
input           iu_xx_no_op;                     
input           lsu_rtu_async_expt_vld;          
input           lsu_rtu_async_ld_inst;           
input   [39:0]  lsu_rtu_async_tval;              
input           lsu_rtu_ex1_buffer_vld;          
input           lsu_rtu_ex1_cmplt;               
input           lsu_rtu_ex1_cmplt_dp;            
input           lsu_rtu_ex1_cmplt_for_pcgen;     
input   [63:0]  lsu_rtu_ex1_data;                
input   [5 :0]  lsu_rtu_ex1_dest_reg;            
input   [39:0]  lsu_rtu_ex1_expt_tval;           
input   [4 :0]  lsu_rtu_ex1_expt_vec;            
input           lsu_rtu_ex1_expt_vld;            
input           lsu_rtu_ex1_fs_dirty;            
input   [21:0]  lsu_rtu_ex1_halt_info;           
input           lsu_rtu_ex1_inst_len;            
input           lsu_rtu_ex1_inst_split;          
input           lsu_rtu_ex1_tval2_vld;           
input           lsu_rtu_ex1_vs_dirty;            
input   [6 :0]  lsu_rtu_ex1_vstart;              
input           lsu_rtu_ex1_vstart_vld;          
input           lsu_rtu_ex1_wb_dp;               
input           lsu_rtu_ex1_wb_vld;              
input   [63:0]  lsu_rtu_ex2_data;                
input           lsu_rtu_ex2_data_vld;            
input   [5 :0]  lsu_rtu_ex2_dest_reg;            
input   [39:0]  lsu_rtu_ex2_tval2;               
input           lsu_rtu_no_op;                   
input   [63:0]  lsu_rtu_wb_data;                 
input   [5 :0]  lsu_rtu_wb_dest_reg;             
input           lsu_rtu_wb_vld;                  
input           mmu_xx_mmu_en;                   
input           pad_yy_icg_scan_en;              
input           vidu_rtu_no_op;                  
input   [7 :0]  vlsu_rtu_vl_updt_data;           
input           vlsu_rtu_vl_updt_vld;            
input           vpu_rtu_ex1_cmplt;               
input           vpu_rtu_ex1_cmplt_dp;            
input           vpu_rtu_ex1_fp_dirty;            
input           vpu_rtu_ex1_vec_dirty;           
input   [5 :0]  vpu_rtu_fflag;                   
input           vpu_rtu_fflag_vld;               
input   [63:0]  vpu_rtu_gpr_wb_data;             
input   [5 :0]  vpu_rtu_gpr_wb_index;            
input           vpu_rtu_gpr_wb_req;              
input           vpu_rtu_no_op;                   
output  [63:0]  rtu_cp0_epc;                     
output          rtu_cp0_exit_debug;              
output  [4 :0]  rtu_cp0_fflags;                  
output          rtu_cp0_fflags_updt;             
output          rtu_cp0_fs_dirty_updt;           
output          rtu_cp0_fs_dirty_updt_dp;        
output  [63:0]  rtu_cp0_tval;                    
output  [7 :0]  rtu_cp0_vl;                      
output          rtu_cp0_vl_vld;                  
output          rtu_cp0_vs_dirty_updt;           
output          rtu_cp0_vs_dirty_updt_dp;        
output  [6 :0]  rtu_cp0_vstart;                  
output          rtu_cp0_vstart_vld;              
output          rtu_cp0_vxsat;                   
output          rtu_cp0_vxsat_vld;               
output          rtu_cpu_no_retire;               
output  [14:0]  rtu_dtu_debug_info;              
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
output          rtu_idu_commit;                  
output          rtu_idu_commit_for_bju;          
output          rtu_idu_flush_fe;                
output          rtu_idu_flush_stall;             
output          rtu_idu_flush_wbt;               
output  [63:0]  rtu_idu_fwd0_data;               
output  [5 :0]  rtu_idu_fwd0_reg;                
output          rtu_idu_fwd0_vld;                
output  [63:0]  rtu_idu_fwd1_data;               
output  [5 :0]  rtu_idu_fwd1_reg;                
output          rtu_idu_fwd1_vld;                
output  [63:0]  rtu_idu_fwd2_data;               
output  [5 :0]  rtu_idu_fwd2_reg;                
output          rtu_idu_fwd2_vld;                
output          rtu_idu_pipeline_empty;          
output  [63:0]  rtu_idu_wb0_data;                
output  [5 :0]  rtu_idu_wb0_reg;                 
output          rtu_idu_wb0_vld;                 
output  [63:0]  rtu_idu_wb1_data;                
output  [5 :0]  rtu_idu_wb1_reg;                 
output          rtu_idu_wb1_vld;                 
output  [39:0]  rtu_ifu_chgflw_pc;               
output          rtu_ifu_chgflw_vld;              
output          rtu_ifu_dbg_mask;                
output          rtu_ifu_flush_fe;                
output          rtu_iu_div_wb_grant;             
output          rtu_iu_div_wb_grant_for_full;    
output          rtu_iu_ex1_cmplt;                
output          rtu_iu_ex1_cmplt_dp;             
output          rtu_iu_ex1_inst_len;             
output          rtu_iu_ex1_inst_split;           
output  [39:0]  rtu_iu_ex2_cur_pc;               
output  [39:0]  rtu_iu_ex2_next_pc;              
output          rtu_iu_mul_wb_grant;             
output          rtu_iu_mul_wb_grant_for_full;    
output          rtu_lsu_async_expt_ack;          
output          rtu_lsu_expt_ack;                
output          rtu_lsu_expt_exit;               
output  [26:0]  rtu_mmu_bad_vpn;                 
output          rtu_mmu_expt_vld;                
output          rtu_pad_halted;                  
output          rtu_pad_retire;                  
output  [39:0]  rtu_pad_retire_pc;               
output          rtu_vidu_flush_wbt;              
output          rtu_vpu_gpr_wb_grnt;             
output          rtu_yy_xx_async_flush;           
output          rtu_yy_xx_dbgon;                 
output          rtu_yy_xx_expt_int;              
output  [4 :0]  rtu_yy_xx_expt_vec;              
output          rtu_yy_xx_expt_vld;              
output          rtu_yy_xx_flush;                 
output          rtu_yy_xx_flush_fe;              

// &Regs; @26

// &Wires; @27
wire            async_select_next_pc;            
wire            cp0_rtu_ex1_chgflw;              
wire    [39:0]  cp0_rtu_ex1_chgflw_pc;           
wire            cp0_rtu_ex1_cmplt;               
wire            cp0_rtu_ex1_cmplt_dp;            
wire    [39:0]  cp0_rtu_ex1_expt_tval;           
wire    [4 :0]  cp0_rtu_ex1_expt_vec;            
wire            cp0_rtu_ex1_expt_vld;            
wire            cp0_rtu_ex1_flush;               
wire    [21:0]  cp0_rtu_ex1_halt_info;           
wire            cp0_rtu_ex1_inst_dret;           
wire            cp0_rtu_ex1_inst_ebreak;         
wire            cp0_rtu_ex1_inst_len;            
wire            cp0_rtu_ex1_inst_mret;           
wire            cp0_rtu_ex1_inst_split;          
wire            cp0_rtu_ex1_inst_sret;           
wire            cp0_rtu_ex1_vs_dirty;            
wire            cp0_rtu_ex1_vs_dirty_dp;         
wire    [63:0]  cp0_rtu_ex1_wb_data;             
wire            cp0_rtu_ex1_wb_dp;               
wire    [5 :0]  cp0_rtu_ex1_wb_preg;             
wire            cp0_rtu_ex1_wb_vld;              
wire            cp0_rtu_fence_idle;              
wire            cp0_rtu_icg_en;                  
wire            cp0_rtu_in_lpmd;                 
wire    [14:0]  cp0_rtu_int_vld;                 
wire    [39:0]  cp0_rtu_trap_pc;                 
wire            cp0_rtu_vstart_eq_0;             
wire            cp0_yy_clk_en;                   
wire            cpurst_b;                        
wire            ctrl_dp_ex1_cmplt_dp;            
wire            ctrl_retire_ex2_retire_vld;      
wire            ctrl_top_dbg_info;               
wire            dp_ctrl_ex1_cmplt_dp;            
wire            dp_int_ex2_inst_split;           
wire            dp_misc_clk;                     
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
wire    [2 :0]  dp_top_dbg_info;                 
wire            dtu_rtu_async_halt_req;          
wire    [63:0]  dtu_rtu_dpc;                     
wire            dtu_rtu_ebreak_action;           
wire            dtu_rtu_int_mask;                
wire    [63:0]  dtu_rtu_pending_tval;            
wire            dtu_rtu_resume_req;              
wire            dtu_rtu_step_en;                 
wire            dtu_rtu_sync_flush;              
wire            dtu_rtu_sync_halt_req;           
wire            forever_cpuclk;                  
wire            hpcp_rtu_cnt_en;                 
wire            ifu_rtu_reset_halt_req;          
wire            ifu_rtu_warm_up;                 
wire    [4 :0]  int_retire_int_vec;              
wire            int_retire_int_vld;              
wire            iu_rtu_depd_lsu_chgflow_vld;     
wire    [39:0]  iu_rtu_depd_lsu_next_pc;         
wire    [63:0]  iu_rtu_div_data;                 
wire    [5 :0]  iu_rtu_div_preg;                 
wire            iu_rtu_div_wb_dp;                
wire            iu_rtu_div_wb_vld;               
wire            iu_rtu_ex1_alu_cmplt;            
wire            iu_rtu_ex1_alu_cmplt_dp;         
wire    [63:0]  iu_rtu_ex1_alu_data;             
wire            iu_rtu_ex1_alu_inst_len;         
wire            iu_rtu_ex1_alu_inst_split;       
wire    [5 :0]  iu_rtu_ex1_alu_preg;             
wire            iu_rtu_ex1_alu_wb_dp;            
wire            iu_rtu_ex1_alu_wb_vld;           
wire            iu_rtu_ex1_bju_cmplt;            
wire            iu_rtu_ex1_bju_cmplt_dp;         
wire    [63:0]  iu_rtu_ex1_bju_data;             
wire            iu_rtu_ex1_bju_inst_len;         
wire    [5 :0]  iu_rtu_ex1_bju_preg;             
wire            iu_rtu_ex1_bju_wb_dp;            
wire            iu_rtu_ex1_bju_wb_vld;           
wire            iu_rtu_ex1_branch_inst;          
wire    [39:0]  iu_rtu_ex1_cur_pc;               
wire            iu_rtu_ex1_div_cmplt;            
wire            iu_rtu_ex1_div_cmplt_dp;         
wire            iu_rtu_ex1_mul_cmplt;            
wire            iu_rtu_ex1_mul_cmplt_dp;         
wire    [39:0]  iu_rtu_ex1_next_pc;              
wire            iu_rtu_ex2_bju_ras_mispred;      
wire    [63:0]  iu_rtu_ex3_mul_data;             
wire    [5 :0]  iu_rtu_ex3_mul_preg;             
wire            iu_rtu_ex3_mul_wb_vld;           
wire            iu_xx_no_op;                     
wire            lsu_rtu_async_expt_vld;          
wire            lsu_rtu_async_ld_inst;           
wire    [39:0]  lsu_rtu_async_tval;              
wire            lsu_rtu_ex1_buffer_vld;          
wire            lsu_rtu_ex1_cmplt;               
wire            lsu_rtu_ex1_cmplt_dp;            
wire            lsu_rtu_ex1_cmplt_for_pcgen;     
wire    [63:0]  lsu_rtu_ex1_data;                
wire    [5 :0]  lsu_rtu_ex1_dest_reg;            
wire    [39:0]  lsu_rtu_ex1_expt_tval;           
wire    [4 :0]  lsu_rtu_ex1_expt_vec;            
wire            lsu_rtu_ex1_expt_vld;            
wire            lsu_rtu_ex1_fs_dirty;            
wire    [21:0]  lsu_rtu_ex1_halt_info;           
wire            lsu_rtu_ex1_inst_len;            
wire            lsu_rtu_ex1_inst_split;          
wire            lsu_rtu_ex1_tval2_vld;           
wire            lsu_rtu_ex1_vs_dirty;            
wire    [6 :0]  lsu_rtu_ex1_vstart;              
wire            lsu_rtu_ex1_vstart_vld;          
wire            lsu_rtu_ex1_wb_dp;               
wire            lsu_rtu_ex1_wb_vld;              
wire    [63:0]  lsu_rtu_ex2_data;                
wire            lsu_rtu_ex2_data_vld;            
wire    [5 :0]  lsu_rtu_ex2_dest_reg;            
wire    [39:0]  lsu_rtu_ex2_tval2;               
wire            lsu_rtu_no_op;                   
wire    [63:0]  lsu_rtu_wb_data;                 
wire    [5 :0]  lsu_rtu_wb_dest_reg;             
wire            lsu_rtu_wb_vld;                  
wire            mmu_xx_mmu_en;                   
wire            pad_yy_icg_scan_en;              
wire    [63:0]  rbus_wb_rbus_wb_data;            
wire            rbus_wb_rbus_wb_dp;              
wire    [5 :0]  rbus_wb_rbus_wb_preg;            
wire            rbus_wb_rbus_wb_vld;             
wire            retire_ctrl_commit_clear;        
wire            retire_ctrl_commit_clear_for_bju; 
wire            retire_rbus_fs_dirty;            
wire            retire_rbus_vs_dirty;            
wire    [10:0]  retire_top_dbg_info;             
wire    [63:0]  rtu_cp0_epc;                     
wire            rtu_cp0_exit_debug;              
wire    [4 :0]  rtu_cp0_fflags;                  
wire            rtu_cp0_fflags_updt;             
wire            rtu_cp0_fs_dirty_updt;           
wire            rtu_cp0_fs_dirty_updt_dp;        
wire    [63:0]  rtu_cp0_tval;                    
wire    [7 :0]  rtu_cp0_vl;                      
wire            rtu_cp0_vl_vld;                  
wire            rtu_cp0_vs_dirty_updt;           
wire            rtu_cp0_vs_dirty_updt_dp;        
wire    [6 :0]  rtu_cp0_vstart;                  
wire            rtu_cp0_vstart_vld;              
wire            rtu_cp0_vxsat;                   
wire            rtu_cp0_vxsat_vld;               
wire            rtu_cpu_no_retire;               
wire    [14:0]  rtu_dtu_debug_info;              
wire    [63:0]  rtu_dtu_dpc;                     
wire            rtu_dtu_halt_ack;                
wire            rtu_dtu_pending_ack;             
wire            rtu_dtu_retire_chgflw;           
wire            rtu_dtu_retire_debug_expt_vld;   
wire    [21:0]  rtu_dtu_retire_halt_info;        
wire            rtu_dtu_retire_mret;             
wire    [39:0]  rtu_dtu_retire_next_pc;          
wire            rtu_dtu_retire_sret;             
wire            rtu_dtu_retire_vld;              
wire    [63:0]  rtu_dtu_tval;                    
wire            rtu_hpcp_int_vld;                
wire            rtu_hpcp_retire_inst_vld;        
wire    [39:0]  rtu_hpcp_retire_pc;              
wire            rtu_idu_commit;                  
wire            rtu_idu_commit_for_bju;          
wire            rtu_idu_flush_fe;                
wire            rtu_idu_flush_stall;             
wire            rtu_idu_flush_wbt;               
wire    [63:0]  rtu_idu_fwd0_data;               
wire    [5 :0]  rtu_idu_fwd0_reg;                
wire            rtu_idu_fwd0_vld;                
wire    [63:0]  rtu_idu_fwd1_data;               
wire    [5 :0]  rtu_idu_fwd1_reg;                
wire            rtu_idu_fwd1_vld;                
wire    [63:0]  rtu_idu_fwd2_data;               
wire    [5 :0]  rtu_idu_fwd2_reg;                
wire            rtu_idu_fwd2_vld;                
wire            rtu_idu_pipeline_empty;          
wire    [63:0]  rtu_idu_wb0_data;                
wire    [5 :0]  rtu_idu_wb0_reg;                 
wire            rtu_idu_wb0_vld;                 
wire    [63:0]  rtu_idu_wb1_data;                
wire    [5 :0]  rtu_idu_wb1_reg;                 
wire            rtu_idu_wb1_vld;                 
wire    [39:0]  rtu_ifu_chgflw_pc;               
wire            rtu_ifu_chgflw_vld;              
wire            rtu_ifu_dbg_mask;                
wire            rtu_ifu_flush_fe;                
wire            rtu_iu_div_wb_grant;             
wire            rtu_iu_div_wb_grant_for_full;    
wire            rtu_iu_ex1_cmplt;                
wire            rtu_iu_ex1_cmplt_dp;             
wire            rtu_iu_ex1_inst_len;             
wire            rtu_iu_ex1_inst_split;           
wire    [39:0]  rtu_iu_ex2_cur_pc;               
wire    [39:0]  rtu_iu_ex2_next_pc;              
wire            rtu_iu_mul_wb_grant;             
wire            rtu_iu_mul_wb_grant_for_full;    
wire            rtu_lsu_async_expt_ack;          
wire            rtu_lsu_expt_ack;                
wire            rtu_lsu_expt_exit;               
wire    [26:0]  rtu_mmu_bad_vpn;                 
wire            rtu_mmu_expt_vld;                
wire            rtu_pad_halted;                  
wire            rtu_pad_retire;                  
wire    [39:0]  rtu_pad_retire_pc;               
wire            rtu_vidu_flush_wbt;              
wire            rtu_vpu_gpr_wb_grnt;             
wire            rtu_yy_xx_async_flush;           
wire            rtu_yy_xx_dbgon;                 
wire            rtu_yy_xx_expt_int;              
wire    [4 :0]  rtu_yy_xx_expt_vec;              
wire            rtu_yy_xx_expt_vld;              
wire            rtu_yy_xx_flush;                 
wire            rtu_yy_xx_flush_fe;              
wire            vidu_rtu_no_op;                  
wire    [7 :0]  vlsu_rtu_vl_updt_data;           
wire            vlsu_rtu_vl_updt_vld;            
wire            vpu_rtu_ex1_cmplt;               
wire            vpu_rtu_ex1_cmplt_dp;            
wire            vpu_rtu_ex1_fp_dirty;            
wire            vpu_rtu_ex1_vec_dirty;           
wire    [5 :0]  vpu_rtu_fflag;                   
wire            vpu_rtu_fflag_vld;               
wire    [63:0]  vpu_rtu_gpr_wb_data;             
wire    [5 :0]  vpu_rtu_gpr_wb_index;            
wire            vpu_rtu_gpr_wb_req;              
wire            vpu_rtu_no_op;                   
wire            wb_retire_wb_no_op;              


// &Instance("aq_rtu_ctrl"); @29
aq_rtu_ctrl  x_aq_rtu_ctrl (
  .async_select_next_pc             (async_select_next_pc            ),
  .cp0_rtu_ex1_cmplt                (cp0_rtu_ex1_cmplt               ),
  .cp0_rtu_icg_en                   (cp0_rtu_icg_en                  ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .ctrl_dp_ex1_cmplt_dp             (ctrl_dp_ex1_cmplt_dp            ),
  .ctrl_retire_ex2_retire_vld       (ctrl_retire_ex2_retire_vld      ),
  .ctrl_top_dbg_info                (ctrl_top_dbg_info               ),
  .dp_ctrl_ex1_cmplt_dp             (dp_ctrl_ex1_cmplt_dp            ),
  .dp_misc_clk                      (dp_misc_clk                     ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .ifu_rtu_warm_up                  (ifu_rtu_warm_up                 ),
  .iu_rtu_ex1_alu_cmplt             (iu_rtu_ex1_alu_cmplt            ),
  .iu_rtu_ex1_bju_cmplt             (iu_rtu_ex1_bju_cmplt            ),
  .iu_rtu_ex1_div_cmplt             (iu_rtu_ex1_div_cmplt            ),
  .iu_rtu_ex1_mul_cmplt             (iu_rtu_ex1_mul_cmplt            ),
  .lsu_rtu_ex1_cmplt                (lsu_rtu_ex1_cmplt               ),
  .lsu_rtu_ex1_cmplt_for_pcgen      (lsu_rtu_ex1_cmplt_for_pcgen     ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .retire_ctrl_commit_clear         (retire_ctrl_commit_clear        ),
  .retire_ctrl_commit_clear_for_bju (retire_ctrl_commit_clear_for_bju),
  .rtu_idu_commit                   (rtu_idu_commit                  ),
  .rtu_idu_commit_for_bju           (rtu_idu_commit_for_bju          ),
  .rtu_iu_ex1_cmplt                 (rtu_iu_ex1_cmplt                ),
  .rtu_iu_ex1_cmplt_dp              (rtu_iu_ex1_cmplt_dp             ),
  .vpu_rtu_ex1_cmplt                (vpu_rtu_ex1_cmplt               )
);


// &Instance("aq_rtu_dp"); @31
aq_rtu_dp  x_aq_rtu_dp (
  .cp0_rtu_ex1_chgflw          (cp0_rtu_ex1_chgflw         ),
  .cp0_rtu_ex1_chgflw_pc       (cp0_rtu_ex1_chgflw_pc      ),
  .cp0_rtu_ex1_cmplt_dp        (cp0_rtu_ex1_cmplt_dp       ),
  .cp0_rtu_ex1_expt_tval       (cp0_rtu_ex1_expt_tval      ),
  .cp0_rtu_ex1_expt_vec        (cp0_rtu_ex1_expt_vec       ),
  .cp0_rtu_ex1_expt_vld        (cp0_rtu_ex1_expt_vld       ),
  .cp0_rtu_ex1_flush           (cp0_rtu_ex1_flush          ),
  .cp0_rtu_ex1_halt_info       (cp0_rtu_ex1_halt_info      ),
  .cp0_rtu_ex1_inst_dret       (cp0_rtu_ex1_inst_dret      ),
  .cp0_rtu_ex1_inst_ebreak     (cp0_rtu_ex1_inst_ebreak    ),
  .cp0_rtu_ex1_inst_len        (cp0_rtu_ex1_inst_len       ),
  .cp0_rtu_ex1_inst_mret       (cp0_rtu_ex1_inst_mret      ),
  .cp0_rtu_ex1_inst_split      (cp0_rtu_ex1_inst_split     ),
  .cp0_rtu_ex1_inst_sret       (cp0_rtu_ex1_inst_sret      ),
  .cp0_rtu_icg_en              (cp0_rtu_icg_en             ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .ctrl_dp_ex1_cmplt_dp        (ctrl_dp_ex1_cmplt_dp       ),
  .dp_ctrl_ex1_cmplt_dp        (dp_ctrl_ex1_cmplt_dp       ),
  .dp_int_ex2_inst_split       (dp_int_ex2_inst_split      ),
  .dp_misc_clk                 (dp_misc_clk                ),
  .dp_retire_ex2_cur_pc        (dp_retire_ex2_cur_pc       ),
  .dp_retire_ex2_fs_dirty      (dp_retire_ex2_fs_dirty     ),
  .dp_retire_ex2_halt_info     (dp_retire_ex2_halt_info    ),
  .dp_retire_ex2_inst_branch   (dp_retire_ex2_inst_branch  ),
  .dp_retire_ex2_inst_chgflw   (dp_retire_ex2_inst_chgflw  ),
  .dp_retire_ex2_inst_dret     (dp_retire_ex2_inst_dret    ),
  .dp_retire_ex2_inst_ebreak   (dp_retire_ex2_inst_ebreak  ),
  .dp_retire_ex2_inst_expt     (dp_retire_ex2_inst_expt    ),
  .dp_retire_ex2_inst_flush    (dp_retire_ex2_inst_flush   ),
  .dp_retire_ex2_inst_mret     (dp_retire_ex2_inst_mret    ),
  .dp_retire_ex2_inst_split    (dp_retire_ex2_inst_split   ),
  .dp_retire_ex2_inst_sret     (dp_retire_ex2_inst_sret    ),
  .dp_retire_ex2_inst_vstart   (dp_retire_ex2_inst_vstart  ),
  .dp_retire_ex2_next_pc       (dp_retire_ex2_next_pc      ),
  .dp_retire_ex2_tval          (dp_retire_ex2_tval         ),
  .dp_retire_ex2_vec           (dp_retire_ex2_vec          ),
  .dp_retire_ex2_vs_dirty      (dp_retire_ex2_vs_dirty     ),
  .dp_retire_ex2_vstart        (dp_retire_ex2_vstart       ),
  .dp_top_dbg_info             (dp_top_dbg_info            ),
  .forever_cpuclk              (forever_cpuclk             ),
  .ifu_rtu_warm_up             (ifu_rtu_warm_up            ),
  .iu_rtu_depd_lsu_chgflow_vld (iu_rtu_depd_lsu_chgflow_vld),
  .iu_rtu_depd_lsu_next_pc     (iu_rtu_depd_lsu_next_pc    ),
  .iu_rtu_ex1_alu_cmplt_dp     (iu_rtu_ex1_alu_cmplt_dp    ),
  .iu_rtu_ex1_alu_inst_len     (iu_rtu_ex1_alu_inst_len    ),
  .iu_rtu_ex1_alu_inst_split   (iu_rtu_ex1_alu_inst_split  ),
  .iu_rtu_ex1_bju_cmplt_dp     (iu_rtu_ex1_bju_cmplt_dp    ),
  .iu_rtu_ex1_bju_inst_len     (iu_rtu_ex1_bju_inst_len    ),
  .iu_rtu_ex1_branch_inst      (iu_rtu_ex1_branch_inst     ),
  .iu_rtu_ex1_cur_pc           (iu_rtu_ex1_cur_pc          ),
  .iu_rtu_ex1_div_cmplt_dp     (iu_rtu_ex1_div_cmplt_dp    ),
  .iu_rtu_ex1_mul_cmplt_dp     (iu_rtu_ex1_mul_cmplt_dp    ),
  .iu_rtu_ex1_next_pc          (iu_rtu_ex1_next_pc         ),
  .lsu_rtu_ex1_cmplt_dp        (lsu_rtu_ex1_cmplt_dp       ),
  .lsu_rtu_ex1_expt_tval       (lsu_rtu_ex1_expt_tval      ),
  .lsu_rtu_ex1_expt_vec        (lsu_rtu_ex1_expt_vec       ),
  .lsu_rtu_ex1_expt_vld        (lsu_rtu_ex1_expt_vld       ),
  .lsu_rtu_ex1_fs_dirty        (lsu_rtu_ex1_fs_dirty       ),
  .lsu_rtu_ex1_halt_info       (lsu_rtu_ex1_halt_info      ),
  .lsu_rtu_ex1_inst_len        (lsu_rtu_ex1_inst_len       ),
  .lsu_rtu_ex1_inst_split      (lsu_rtu_ex1_inst_split     ),
  .lsu_rtu_ex1_tval2_vld       (lsu_rtu_ex1_tval2_vld      ),
  .lsu_rtu_ex1_vs_dirty        (lsu_rtu_ex1_vs_dirty       ),
  .lsu_rtu_ex1_vstart          (lsu_rtu_ex1_vstart         ),
  .lsu_rtu_ex1_vstart_vld      (lsu_rtu_ex1_vstart_vld     ),
  .lsu_rtu_ex2_tval2           (lsu_rtu_ex2_tval2          ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_iu_ex1_inst_len         (rtu_iu_ex1_inst_len        ),
  .rtu_iu_ex1_inst_split       (rtu_iu_ex1_inst_split      ),
  .rtu_iu_ex2_cur_pc           (rtu_iu_ex2_cur_pc          ),
  .rtu_iu_ex2_next_pc          (rtu_iu_ex2_next_pc         ),
  .vpu_rtu_ex1_cmplt_dp        (vpu_rtu_ex1_cmplt_dp       )
);


// &Instance("aq_rtu_rbus"); @33
aq_rtu_rbus  x_aq_rtu_rbus (
  .cp0_rtu_ex1_cmplt            (cp0_rtu_ex1_cmplt           ),
  .cp0_rtu_ex1_cmplt_dp         (cp0_rtu_ex1_cmplt_dp        ),
  .cp0_rtu_ex1_vs_dirty         (cp0_rtu_ex1_vs_dirty        ),
  .cp0_rtu_ex1_vs_dirty_dp      (cp0_rtu_ex1_vs_dirty_dp     ),
  .cp0_rtu_ex1_wb_data          (cp0_rtu_ex1_wb_data         ),
  .cp0_rtu_ex1_wb_dp            (cp0_rtu_ex1_wb_dp           ),
  .cp0_rtu_ex1_wb_preg          (cp0_rtu_ex1_wb_preg         ),
  .cp0_rtu_ex1_wb_vld           (cp0_rtu_ex1_wb_vld          ),
  .iu_rtu_div_data              (iu_rtu_div_data             ),
  .iu_rtu_div_preg              (iu_rtu_div_preg             ),
  .iu_rtu_div_wb_dp             (iu_rtu_div_wb_dp            ),
  .iu_rtu_div_wb_vld            (iu_rtu_div_wb_vld           ),
  .iu_rtu_ex1_alu_data          (iu_rtu_ex1_alu_data         ),
  .iu_rtu_ex1_alu_preg          (iu_rtu_ex1_alu_preg         ),
  .iu_rtu_ex1_alu_wb_dp         (iu_rtu_ex1_alu_wb_dp        ),
  .iu_rtu_ex1_alu_wb_vld        (iu_rtu_ex1_alu_wb_vld       ),
  .iu_rtu_ex1_bju_data          (iu_rtu_ex1_bju_data         ),
  .iu_rtu_ex1_bju_preg          (iu_rtu_ex1_bju_preg         ),
  .iu_rtu_ex1_bju_wb_dp         (iu_rtu_ex1_bju_wb_dp        ),
  .iu_rtu_ex1_bju_wb_vld        (iu_rtu_ex1_bju_wb_vld       ),
  .iu_rtu_ex3_mul_data          (iu_rtu_ex3_mul_data         ),
  .iu_rtu_ex3_mul_preg          (iu_rtu_ex3_mul_preg         ),
  .iu_rtu_ex3_mul_wb_vld        (iu_rtu_ex3_mul_wb_vld       ),
  .lsu_rtu_ex1_data             (lsu_rtu_ex1_data            ),
  .lsu_rtu_ex1_dest_reg         (lsu_rtu_ex1_dest_reg        ),
  .lsu_rtu_ex1_wb_dp            (lsu_rtu_ex1_wb_dp           ),
  .lsu_rtu_ex1_wb_vld           (lsu_rtu_ex1_wb_vld          ),
  .lsu_rtu_ex2_data             (lsu_rtu_ex2_data            ),
  .lsu_rtu_ex2_data_vld         (lsu_rtu_ex2_data_vld        ),
  .lsu_rtu_ex2_dest_reg         (lsu_rtu_ex2_dest_reg        ),
  .rbus_wb_rbus_wb_data         (rbus_wb_rbus_wb_data        ),
  .rbus_wb_rbus_wb_dp           (rbus_wb_rbus_wb_dp          ),
  .rbus_wb_rbus_wb_preg         (rbus_wb_rbus_wb_preg        ),
  .rbus_wb_rbus_wb_vld          (rbus_wb_rbus_wb_vld         ),
  .retire_rbus_fs_dirty         (retire_rbus_fs_dirty        ),
  .retire_rbus_vs_dirty         (retire_rbus_vs_dirty        ),
  .rtu_cp0_fs_dirty_updt        (rtu_cp0_fs_dirty_updt       ),
  .rtu_cp0_fs_dirty_updt_dp     (rtu_cp0_fs_dirty_updt_dp    ),
  .rtu_cp0_vl                   (rtu_cp0_vl                  ),
  .rtu_cp0_vl_vld               (rtu_cp0_vl_vld              ),
  .rtu_cp0_vs_dirty_updt        (rtu_cp0_vs_dirty_updt       ),
  .rtu_cp0_vs_dirty_updt_dp     (rtu_cp0_vs_dirty_updt_dp    ),
  .rtu_idu_fwd0_data            (rtu_idu_fwd0_data           ),
  .rtu_idu_fwd0_reg             (rtu_idu_fwd0_reg            ),
  .rtu_idu_fwd0_vld             (rtu_idu_fwd0_vld            ),
  .rtu_idu_fwd1_data            (rtu_idu_fwd1_data           ),
  .rtu_idu_fwd1_reg             (rtu_idu_fwd1_reg            ),
  .rtu_idu_fwd1_vld             (rtu_idu_fwd1_vld            ),
  .rtu_idu_fwd2_data            (rtu_idu_fwd2_data           ),
  .rtu_idu_fwd2_reg             (rtu_idu_fwd2_reg            ),
  .rtu_idu_fwd2_vld             (rtu_idu_fwd2_vld            ),
  .rtu_iu_div_wb_grant          (rtu_iu_div_wb_grant         ),
  .rtu_iu_div_wb_grant_for_full (rtu_iu_div_wb_grant_for_full),
  .rtu_iu_mul_wb_grant          (rtu_iu_mul_wb_grant         ),
  .rtu_iu_mul_wb_grant_for_full (rtu_iu_mul_wb_grant_for_full),
  .vlsu_rtu_vl_updt_data        (vlsu_rtu_vl_updt_data       ),
  .vlsu_rtu_vl_updt_vld         (vlsu_rtu_vl_updt_vld        ),
  .vpu_rtu_ex1_cmplt            (vpu_rtu_ex1_cmplt           ),
  .vpu_rtu_ex1_cmplt_dp         (vpu_rtu_ex1_cmplt_dp        ),
  .vpu_rtu_ex1_fp_dirty         (vpu_rtu_ex1_fp_dirty        ),
  .vpu_rtu_ex1_vec_dirty        (vpu_rtu_ex1_vec_dirty       )
);


// &Instance("aq_rtu_retire"); @35
aq_rtu_retire  x_aq_rtu_retire (
  .async_select_next_pc             (async_select_next_pc            ),
  .cp0_rtu_fence_idle               (cp0_rtu_fence_idle              ),
  .cp0_rtu_icg_en                   (cp0_rtu_icg_en                  ),
  .cp0_rtu_in_lpmd                  (cp0_rtu_in_lpmd                 ),
  .cp0_rtu_trap_pc                  (cp0_rtu_trap_pc                 ),
  .cp0_rtu_vstart_eq_0              (cp0_rtu_vstart_eq_0             ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .ctrl_retire_ex2_retire_vld       (ctrl_retire_ex2_retire_vld      ),
  .dp_retire_ex2_cur_pc             (dp_retire_ex2_cur_pc            ),
  .dp_retire_ex2_fs_dirty           (dp_retire_ex2_fs_dirty          ),
  .dp_retire_ex2_halt_info          (dp_retire_ex2_halt_info         ),
  .dp_retire_ex2_inst_branch        (dp_retire_ex2_inst_branch       ),
  .dp_retire_ex2_inst_chgflw        (dp_retire_ex2_inst_chgflw       ),
  .dp_retire_ex2_inst_dret          (dp_retire_ex2_inst_dret         ),
  .dp_retire_ex2_inst_ebreak        (dp_retire_ex2_inst_ebreak       ),
  .dp_retire_ex2_inst_expt          (dp_retire_ex2_inst_expt         ),
  .dp_retire_ex2_inst_flush         (dp_retire_ex2_inst_flush        ),
  .dp_retire_ex2_inst_mret          (dp_retire_ex2_inst_mret         ),
  .dp_retire_ex2_inst_split         (dp_retire_ex2_inst_split        ),
  .dp_retire_ex2_inst_sret          (dp_retire_ex2_inst_sret         ),
  .dp_retire_ex2_inst_vstart        (dp_retire_ex2_inst_vstart       ),
  .dp_retire_ex2_next_pc            (dp_retire_ex2_next_pc           ),
  .dp_retire_ex2_tval               (dp_retire_ex2_tval              ),
  .dp_retire_ex2_vec                (dp_retire_ex2_vec               ),
  .dp_retire_ex2_vs_dirty           (dp_retire_ex2_vs_dirty          ),
  .dp_retire_ex2_vstart             (dp_retire_ex2_vstart            ),
  .dtu_rtu_async_halt_req           (dtu_rtu_async_halt_req          ),
  .dtu_rtu_dpc                      (dtu_rtu_dpc                     ),
  .dtu_rtu_ebreak_action            (dtu_rtu_ebreak_action           ),
  .dtu_rtu_pending_tval             (dtu_rtu_pending_tval            ),
  .dtu_rtu_resume_req               (dtu_rtu_resume_req              ),
  .dtu_rtu_step_en                  (dtu_rtu_step_en                 ),
  .dtu_rtu_sync_flush               (dtu_rtu_sync_flush              ),
  .dtu_rtu_sync_halt_req            (dtu_rtu_sync_halt_req           ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .hpcp_rtu_cnt_en                  (hpcp_rtu_cnt_en                 ),
  .ifu_rtu_reset_halt_req           (ifu_rtu_reset_halt_req          ),
  .ifu_rtu_warm_up                  (ifu_rtu_warm_up                 ),
  .int_retire_int_vec               (int_retire_int_vec              ),
  .int_retire_int_vld               (int_retire_int_vld              ),
  .iu_rtu_depd_lsu_chgflow_vld      (iu_rtu_depd_lsu_chgflow_vld     ),
  .iu_rtu_ex2_bju_ras_mispred       (iu_rtu_ex2_bju_ras_mispred      ),
  .iu_xx_no_op                      (iu_xx_no_op                     ),
  .lsu_rtu_async_expt_vld           (lsu_rtu_async_expt_vld          ),
  .lsu_rtu_async_ld_inst            (lsu_rtu_async_ld_inst           ),
  .lsu_rtu_async_tval               (lsu_rtu_async_tval              ),
  .lsu_rtu_ex1_buffer_vld           (lsu_rtu_ex1_buffer_vld          ),
  .lsu_rtu_no_op                    (lsu_rtu_no_op                   ),
  .mmu_xx_mmu_en                    (mmu_xx_mmu_en                   ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .retire_ctrl_commit_clear         (retire_ctrl_commit_clear        ),
  .retire_ctrl_commit_clear_for_bju (retire_ctrl_commit_clear_for_bju),
  .retire_rbus_fs_dirty             (retire_rbus_fs_dirty            ),
  .retire_rbus_vs_dirty             (retire_rbus_vs_dirty            ),
  .retire_top_dbg_info              (retire_top_dbg_info             ),
  .rtu_cp0_epc                      (rtu_cp0_epc                     ),
  .rtu_cp0_exit_debug               (rtu_cp0_exit_debug              ),
  .rtu_cp0_tval                     (rtu_cp0_tval                    ),
  .rtu_cp0_vstart                   (rtu_cp0_vstart                  ),
  .rtu_cp0_vstart_vld               (rtu_cp0_vstart_vld              ),
  .rtu_cpu_no_retire                (rtu_cpu_no_retire               ),
  .rtu_dtu_dpc                      (rtu_dtu_dpc                     ),
  .rtu_dtu_halt_ack                 (rtu_dtu_halt_ack                ),
  .rtu_dtu_pending_ack              (rtu_dtu_pending_ack             ),
  .rtu_dtu_retire_chgflw            (rtu_dtu_retire_chgflw           ),
  .rtu_dtu_retire_debug_expt_vld    (rtu_dtu_retire_debug_expt_vld   ),
  .rtu_dtu_retire_halt_info         (rtu_dtu_retire_halt_info        ),
  .rtu_dtu_retire_mret              (rtu_dtu_retire_mret             ),
  .rtu_dtu_retire_next_pc           (rtu_dtu_retire_next_pc          ),
  .rtu_dtu_retire_sret              (rtu_dtu_retire_sret             ),
  .rtu_dtu_retire_vld               (rtu_dtu_retire_vld              ),
  .rtu_dtu_tval                     (rtu_dtu_tval                    ),
  .rtu_hpcp_int_vld                 (rtu_hpcp_int_vld                ),
  .rtu_hpcp_retire_inst_vld         (rtu_hpcp_retire_inst_vld        ),
  .rtu_hpcp_retire_pc               (rtu_hpcp_retire_pc              ),
  .rtu_idu_flush_fe                 (rtu_idu_flush_fe                ),
  .rtu_idu_flush_stall              (rtu_idu_flush_stall             ),
  .rtu_idu_flush_wbt                (rtu_idu_flush_wbt               ),
  .rtu_idu_pipeline_empty           (rtu_idu_pipeline_empty          ),
  .rtu_ifu_chgflw_pc                (rtu_ifu_chgflw_pc               ),
  .rtu_ifu_chgflw_vld               (rtu_ifu_chgflw_vld              ),
  .rtu_ifu_dbg_mask                 (rtu_ifu_dbg_mask                ),
  .rtu_ifu_flush_fe                 (rtu_ifu_flush_fe                ),
  .rtu_lsu_async_expt_ack           (rtu_lsu_async_expt_ack          ),
  .rtu_lsu_expt_ack                 (rtu_lsu_expt_ack                ),
  .rtu_lsu_expt_exit                (rtu_lsu_expt_exit               ),
  .rtu_mmu_bad_vpn                  (rtu_mmu_bad_vpn                 ),
  .rtu_mmu_expt_vld                 (rtu_mmu_expt_vld                ),
  .rtu_pad_halted                   (rtu_pad_halted                  ),
  .rtu_pad_retire                   (rtu_pad_retire                  ),
  .rtu_pad_retire_pc                (rtu_pad_retire_pc               ),
  .rtu_vidu_flush_wbt               (rtu_vidu_flush_wbt              ),
  .rtu_yy_xx_async_flush            (rtu_yy_xx_async_flush           ),
  .rtu_yy_xx_dbgon                  (rtu_yy_xx_dbgon                 ),
  .rtu_yy_xx_expt_int               (rtu_yy_xx_expt_int              ),
  .rtu_yy_xx_expt_vec               (rtu_yy_xx_expt_vec              ),
  .rtu_yy_xx_expt_vld               (rtu_yy_xx_expt_vld              ),
  .rtu_yy_xx_flush                  (rtu_yy_xx_flush                 ),
  .rtu_yy_xx_flush_fe               (rtu_yy_xx_flush_fe              ),
  .vidu_rtu_no_op                   (vidu_rtu_no_op                  ),
  .vpu_rtu_no_op                    (vpu_rtu_no_op                   ),
  .wb_retire_wb_no_op               (wb_retire_wb_no_op              )
);


// &Instance("aq_rtu_wb"); @37
aq_rtu_wb  x_aq_rtu_wb (
  .cp0_rtu_icg_en       (cp0_rtu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .ifu_rtu_warm_up      (ifu_rtu_warm_up     ),
  .lsu_rtu_wb_data      (lsu_rtu_wb_data     ),
  .lsu_rtu_wb_dest_reg  (lsu_rtu_wb_dest_reg ),
  .lsu_rtu_wb_vld       (lsu_rtu_wb_vld      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .rbus_wb_rbus_wb_data (rbus_wb_rbus_wb_data),
  .rbus_wb_rbus_wb_dp   (rbus_wb_rbus_wb_dp  ),
  .rbus_wb_rbus_wb_preg (rbus_wb_rbus_wb_preg),
  .rbus_wb_rbus_wb_vld  (rbus_wb_rbus_wb_vld ),
  .rtu_cp0_fflags       (rtu_cp0_fflags      ),
  .rtu_cp0_fflags_updt  (rtu_cp0_fflags_updt ),
  .rtu_cp0_vxsat        (rtu_cp0_vxsat       ),
  .rtu_cp0_vxsat_vld    (rtu_cp0_vxsat_vld   ),
  .rtu_idu_wb0_data     (rtu_idu_wb0_data    ),
  .rtu_idu_wb0_reg      (rtu_idu_wb0_reg     ),
  .rtu_idu_wb0_vld      (rtu_idu_wb0_vld     ),
  .rtu_idu_wb1_data     (rtu_idu_wb1_data    ),
  .rtu_idu_wb1_reg      (rtu_idu_wb1_reg     ),
  .rtu_idu_wb1_vld      (rtu_idu_wb1_vld     ),
  .rtu_vpu_gpr_wb_grnt  (rtu_vpu_gpr_wb_grnt ),
  .vpu_rtu_fflag        (vpu_rtu_fflag       ),
  .vpu_rtu_fflag_vld    (vpu_rtu_fflag_vld   ),
  .vpu_rtu_gpr_wb_data  (vpu_rtu_gpr_wb_data ),
  .vpu_rtu_gpr_wb_index (vpu_rtu_gpr_wb_index),
  .vpu_rtu_gpr_wb_req   (vpu_rtu_gpr_wb_req  ),
  .wb_retire_wb_no_op   (wb_retire_wb_no_op  )
);


// &Instance("aq_rtu_int"); @39
aq_rtu_int  x_aq_rtu_int (
  .cp0_rtu_int_vld       (cp0_rtu_int_vld      ),
  .dp_int_ex2_inst_split (dp_int_ex2_inst_split),
  .dtu_rtu_int_mask      (dtu_rtu_int_mask     ),
  .int_retire_int_vec    (int_retire_int_vec   ),
  .int_retire_int_vld    (int_retire_int_vld   )
);


// &Force("output", "rtu_yy_xx_dbgon"); @41

assign rtu_dtu_debug_info[14:0] = {retire_top_dbg_info[10:0],
                                   ctrl_top_dbg_info,
                                   dp_top_dbg_info[2:0]};


// &ModuleEnd; @124
endmodule



