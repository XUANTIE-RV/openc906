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

// &Depend("aq_idu_cfig.h"); @23
// &ModuleBeg; @24
module aq_idu_top(
  cp0_idu_cskyee,
  cp0_idu_dis_fence_in_dbg,
  cp0_idu_frm,
  cp0_idu_fs,
  cp0_idu_icg_en,
  cp0_idu_issue_stall,
  cp0_idu_ucme,
  cp0_idu_vill,
  cp0_idu_vl_zero,
  cp0_idu_vlmul,
  cp0_idu_vs,
  cp0_idu_vsetvl_dis_stall,
  cp0_idu_vsew,
  cp0_idu_vstart,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  forever_cpuclk,
  hpcp_idu_cnt_en,
  idu_alu_ex1_gateclk_sel,
  idu_bju_ex1_gateclk_sel,
  idu_cp0_ex1_dp_sel,
  idu_cp0_ex1_dst0_reg,
  idu_cp0_ex1_expt_acc_error,
  idu_cp0_ex1_expt_high,
  idu_cp0_ex1_expt_illegal,
  idu_cp0_ex1_expt_page_fault,
  idu_cp0_ex1_func,
  idu_cp0_ex1_gateclk_sel,
  idu_cp0_ex1_halt_info,
  idu_cp0_ex1_length,
  idu_cp0_ex1_opcode,
  idu_cp0_ex1_sel,
  idu_cp0_ex1_split,
  idu_cp0_ex1_src0_data,
  idu_cp0_ex1_src1_data,
  idu_div_ex1_gateclk_sel,
  idu_dtu_debug_info,
  idu_hpcp_backend_stall,
  idu_hpcp_frontend_stall,
  idu_hpcp_inst_type,
  idu_ifu_id_stall,
  idu_iu_ex1_alu_dp_sel,
  idu_iu_ex1_alu_sel,
  idu_iu_ex1_bht_pred,
  idu_iu_ex1_bju_br_sel,
  idu_iu_ex1_bju_dp_sel,
  idu_iu_ex1_bju_sel,
  idu_iu_ex1_div_dp_sel,
  idu_iu_ex1_div_sel,
  idu_iu_ex1_dst0_reg,
  idu_iu_ex1_func,
  idu_iu_ex1_inst_vld,
  idu_iu_ex1_length,
  idu_iu_ex1_mult_dp_sel,
  idu_iu_ex1_mult_sel,
  idu_iu_ex1_pipedown_vld,
  idu_iu_ex1_split,
  idu_iu_ex1_src0_data,
  idu_iu_ex1_src0_ready,
  idu_iu_ex1_src0_reg,
  idu_iu_ex1_src1_data,
  idu_iu_ex1_src1_ready,
  idu_iu_ex1_src1_reg,
  idu_iu_ex1_src2_data,
  idu_lsu_ex1_dp_sel,
  idu_lsu_ex1_dst0_reg,
  idu_lsu_ex1_dst1_reg,
  idu_lsu_ex1_func,
  idu_lsu_ex1_gateclk_sel,
  idu_lsu_ex1_halt_info,
  idu_lsu_ex1_length,
  idu_lsu_ex1_sel,
  idu_lsu_ex1_split,
  idu_lsu_ex1_src0_data,
  idu_lsu_ex1_src1_data,
  idu_lsu_ex1_src2_data,
  idu_lsu_ex1_src2_ready,
  idu_lsu_ex1_src2_reg,
  idu_lsu_ex1_vlmul,
  idu_lsu_ex1_vsew,
  idu_mult_ex1_gateclk_sel,
  idu_vidu_ex1_fp_dp_sel,
  idu_vidu_ex1_fp_gateclk_sel,
  idu_vidu_ex1_fp_sel,
  idu_vidu_ex1_inst_data,
  idu_vidu_ex1_vec_dp_sel,
  idu_vidu_ex1_vec_gateclk_sel,
  idu_vidu_ex1_vec_sel,
  ifu_idu_id_bht_pred,
  ifu_idu_id_expt_acc_error,
  ifu_idu_id_expt_high,
  ifu_idu_id_expt_page_fault,
  ifu_idu_id_halt_info,
  ifu_idu_id_inst,
  ifu_idu_id_inst_vld,
  ifu_idu_warm_up,
  iu_idu_bju_full,
  iu_idu_bju_global_full,
  iu_idu_div_full,
  iu_idu_mult_full,
  iu_idu_mult_issue_stall,
  iu_yy_xx_cancel,
  lsu_idu_full,
  lsu_idu_global_full,
  pad_yy_icg_scan_en,
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
  rtu_yy_xx_dbgon,
  vidu_idu_fp_full,
  vidu_idu_vec_full
);

// &Ports; @25
input            cp0_idu_cskyee;                  
input            cp0_idu_dis_fence_in_dbg;        
input   [2  :0]  cp0_idu_frm;                     
input   [1  :0]  cp0_idu_fs;                      
input            cp0_idu_icg_en;                  
input            cp0_idu_issue_stall;             
input            cp0_idu_ucme;                    
input            cp0_idu_vill;                    
input            cp0_idu_vl_zero;                 
input   [1  :0]  cp0_idu_vlmul;                   
input   [1  :0]  cp0_idu_vs;                      
input            cp0_idu_vsetvl_dis_stall;        
input   [1  :0]  cp0_idu_vsew;                    
input   [6  :0]  cp0_idu_vstart;                  
input            cp0_yy_clk_en;                   
input   [1  :0]  cp0_yy_priv_mode;                
input            cpurst_b;                        
input            forever_cpuclk;                  
input            hpcp_idu_cnt_en;                 
input   [1  :0]  ifu_idu_id_bht_pred;             
input            ifu_idu_id_expt_acc_error;       
input            ifu_idu_id_expt_high;            
input            ifu_idu_id_expt_page_fault;      
input   [21 :0]  ifu_idu_id_halt_info;            
input   [31 :0]  ifu_idu_id_inst;                 
input            ifu_idu_id_inst_vld;             
input            ifu_idu_warm_up;                 
input            iu_idu_bju_full;                 
input            iu_idu_bju_global_full;          
input            iu_idu_div_full;                 
input            iu_idu_mult_full;                
input            iu_idu_mult_issue_stall;         
input            iu_yy_xx_cancel;                 
input            lsu_idu_full;                    
input            lsu_idu_global_full;             
input            pad_yy_icg_scan_en;              
input            rtu_idu_commit;                  
input            rtu_idu_commit_for_bju;          
input            rtu_idu_flush_fe;                
input            rtu_idu_flush_stall;             
input            rtu_idu_flush_wbt;               
input   [63 :0]  rtu_idu_fwd0_data;               
input   [5  :0]  rtu_idu_fwd0_reg;                
input            rtu_idu_fwd0_vld;                
input   [63 :0]  rtu_idu_fwd1_data;               
input   [5  :0]  rtu_idu_fwd1_reg;                
input            rtu_idu_fwd1_vld;                
input   [63 :0]  rtu_idu_fwd2_data;               
input   [5  :0]  rtu_idu_fwd2_reg;                
input            rtu_idu_fwd2_vld;                
input            rtu_idu_pipeline_empty;          
input   [63 :0]  rtu_idu_wb0_data;                
input   [5  :0]  rtu_idu_wb0_reg;                 
input            rtu_idu_wb0_vld;                 
input   [63 :0]  rtu_idu_wb1_data;                
input   [5  :0]  rtu_idu_wb1_reg;                 
input            rtu_idu_wb1_vld;                 
input            rtu_yy_xx_dbgon;                 
input            vidu_idu_fp_full;                
input            vidu_idu_vec_full;               
output           idu_alu_ex1_gateclk_sel;         
output           idu_bju_ex1_gateclk_sel;         
output           idu_cp0_ex1_dp_sel;              
output  [5  :0]  idu_cp0_ex1_dst0_reg;            
output           idu_cp0_ex1_expt_acc_error;      
output           idu_cp0_ex1_expt_high;           
output           idu_cp0_ex1_expt_illegal;        
output           idu_cp0_ex1_expt_page_fault;     
output  [19 :0]  idu_cp0_ex1_func;                
output           idu_cp0_ex1_gateclk_sel;         
output  [21 :0]  idu_cp0_ex1_halt_info;           
output           idu_cp0_ex1_length;              
output  [31 :0]  idu_cp0_ex1_opcode;              
output           idu_cp0_ex1_sel;                 
output           idu_cp0_ex1_split;               
output  [63 :0]  idu_cp0_ex1_src0_data;           
output  [63 :0]  idu_cp0_ex1_src1_data;           
output           idu_div_ex1_gateclk_sel;         
output  [14 :0]  idu_dtu_debug_info;              
output           idu_hpcp_backend_stall;          
output           idu_hpcp_frontend_stall;         
output  [6  :0]  idu_hpcp_inst_type;              
output           idu_ifu_id_stall;                
output           idu_iu_ex1_alu_dp_sel;           
output           idu_iu_ex1_alu_sel;              
output  [1  :0]  idu_iu_ex1_bht_pred;             
output           idu_iu_ex1_bju_br_sel;           
output           idu_iu_ex1_bju_dp_sel;           
output           idu_iu_ex1_bju_sel;              
output           idu_iu_ex1_div_dp_sel;           
output           idu_iu_ex1_div_sel;              
output  [5  :0]  idu_iu_ex1_dst0_reg;             
output  [19 :0]  idu_iu_ex1_func;                 
output           idu_iu_ex1_inst_vld;             
output           idu_iu_ex1_length;               
output           idu_iu_ex1_mult_dp_sel;          
output           idu_iu_ex1_mult_sel;             
output           idu_iu_ex1_pipedown_vld;         
output           idu_iu_ex1_split;                
output  [63 :0]  idu_iu_ex1_src0_data;            
output           idu_iu_ex1_src0_ready;           
output  [5  :0]  idu_iu_ex1_src0_reg;             
output  [63 :0]  idu_iu_ex1_src1_data;            
output           idu_iu_ex1_src1_ready;           
output  [5  :0]  idu_iu_ex1_src1_reg;             
output  [63 :0]  idu_iu_ex1_src2_data;            
output           idu_lsu_ex1_dp_sel;              
output  [5  :0]  idu_lsu_ex1_dst0_reg;            
output  [5  :0]  idu_lsu_ex1_dst1_reg;            
output  [19 :0]  idu_lsu_ex1_func;                
output           idu_lsu_ex1_gateclk_sel;         
output  [21 :0]  idu_lsu_ex1_halt_info;           
output           idu_lsu_ex1_length;              
output           idu_lsu_ex1_sel;                 
output           idu_lsu_ex1_split;               
output  [63 :0]  idu_lsu_ex1_src0_data;           
output  [63 :0]  idu_lsu_ex1_src1_data;           
output  [63 :0]  idu_lsu_ex1_src2_data;           
output           idu_lsu_ex1_src2_ready;          
output  [5  :0]  idu_lsu_ex1_src2_reg;            
output  [1  :0]  idu_lsu_ex1_vlmul;               
output  [1  :0]  idu_lsu_ex1_vsew;                
output           idu_mult_ex1_gateclk_sel;        
output           idu_vidu_ex1_fp_dp_sel;          
output           idu_vidu_ex1_fp_gateclk_sel;     
output           idu_vidu_ex1_fp_sel;             
output  [179:0]  idu_vidu_ex1_inst_data;          
output           idu_vidu_ex1_vec_dp_sel;         
output           idu_vidu_ex1_vec_gateclk_sel;    
output           idu_vidu_ex1_vec_sel;            

// &Regs; @26

// &Wires; @27
wire             cp0_idu_cskyee;                  
wire             cp0_idu_dis_fence_in_dbg;        
wire    [2  :0]  cp0_idu_frm;                     
wire    [1  :0]  cp0_idu_fs;                      
wire             cp0_idu_icg_en;                  
wire             cp0_idu_issue_stall;             
wire             cp0_idu_ucme;                    
wire             cp0_idu_vill;                    
wire             cp0_idu_vl_zero;                 
wire    [1  :0]  cp0_idu_vlmul;                   
wire    [1  :0]  cp0_idu_vs;                      
wire             cp0_idu_vsetvl_dis_stall;        
wire    [1  :0]  cp0_idu_vsew;                    
wire    [6  :0]  cp0_idu_vstart;                  
wire             cp0_yy_clk_en;                   
wire    [1  :0]  cp0_yy_priv_mode;                
wire             cpurst_b;                        
wire             ctrl_dp_dis_int_inst_gateclk_vld; 
wire             ctrl_dp_dis_vec_inst_gateclk_vld; 
wire             ctrl_dp_ex1_stall;               
wire    [9  :0]  ctrl_top_eu_sel;                 
wire             ctrl_wbt_dis_inst_vld;           
wire             ctrl_xx_dis_stall;               
wire    [264:0]  decd_dp_inst_data;               
wire             dp_ctrl_dis_inst_cancel;         
wire             dp_ctrl_dis_inst_cp0_fence;      
wire    [2  :0]  dp_ctrl_dis_inst_dst0_type;      
wire             dp_ctrl_dis_inst_dst0_vld;       
wire    [2  :0]  dp_ctrl_dis_inst_dst1_type;      
wire             dp_ctrl_dis_inst_dst1_vld;       
wire    [9  :0]  dp_ctrl_dis_inst_eu;             
wire             dp_ctrl_dis_inst_expt_vld;       
wire    [19 :0]  dp_ctrl_dis_inst_func;           
wire             dp_ctrl_dis_inst_src0_vld;       
wire             dp_ctrl_dis_inst_src1_vld;       
wire             dp_ctrl_dis_inst_src2_vld;       
wire    [2  :0]  dp_ctrl_dis_inst_src_type;       
wire             dp_ctrl_dis_inst_store;          
wire             dp_ctrl_dis_inst_vec;            
wire             dp_ctrl_inst_amo;                
wire             dp_ctrl_inst_csr;                
wire             dp_ctrl_inst_ecall;              
wire             dp_ctrl_inst_sync;               
wire             dp_ctrl_src0_fwd_vld;            
wire             dp_ctrl_src1_fwd_vld;            
wire             dp_ctrl_src2_fwd_vld;            
wire    [31 :0]  dp_decd_inst;                    
wire    [1  :0]  dp_decd_vlmul;                   
wire    [1  :0]  dp_decd_vsew;                    
wire    [5  :0]  dp_gpr_src0_reg;                 
wire    [5  :0]  dp_gpr_src1_reg;                 
wire    [5  :0]  dp_gpr_src2_reg;                 
wire    [31 :0]  dp_gpr_wb0_vld;                  
wire    [31 :0]  dp_gpr_wb1_vld;                  
wire    [31 :0]  dp_split_inst;                   
wire    [5  :0]  dp_wbt_dst0_reg;                 
wire    [2  :0]  dp_wbt_dst0_type;                
wire    [5  :0]  dp_wbt_dst1_reg;                 
wire    [2  :0]  dp_wbt_dst1_type;                
wire             dp_wbt_inst_dst0_vld;            
wire             dp_wbt_inst_dst1_vld;            
wire    [5  :0]  dp_wbt_src0_reg;                 
wire    [5  :0]  dp_wbt_src1_reg;                 
wire    [5  :0]  dp_wbt_src2_reg;                 
wire    [31 :0]  dp_wbt_wb_vld;                   
wire             forever_cpuclk;                  
wire    [63 :0]  gpr_dp_src0_data;                
wire    [63 :0]  gpr_dp_src1_data;                
wire    [63 :0]  gpr_dp_src2_data;                
wire             hpcp_idu_cnt_en;                 
wire             idu_alu_ex1_gateclk_sel;         
wire             idu_bju_ex1_gateclk_sel;         
wire             idu_cp0_ex1_dp_sel;              
wire    [5  :0]  idu_cp0_ex1_dst0_reg;            
wire             idu_cp0_ex1_expt_acc_error;      
wire             idu_cp0_ex1_expt_high;           
wire             idu_cp0_ex1_expt_illegal;        
wire             idu_cp0_ex1_expt_page_fault;     
wire    [19 :0]  idu_cp0_ex1_func;                
wire             idu_cp0_ex1_gateclk_sel;         
wire    [21 :0]  idu_cp0_ex1_halt_info;           
wire             idu_cp0_ex1_length;              
wire    [31 :0]  idu_cp0_ex1_opcode;              
wire             idu_cp0_ex1_sel;                 
wire             idu_cp0_ex1_split;               
wire    [63 :0]  idu_cp0_ex1_src0_data;           
wire    [63 :0]  idu_cp0_ex1_src1_data;           
wire             idu_div_ex1_gateclk_sel;         
wire    [14 :0]  idu_dtu_debug_info;              
wire             idu_hpcp_backend_stall;          
wire             idu_hpcp_frontend_stall;         
wire    [6  :0]  idu_hpcp_inst_type;              
wire             idu_ifu_id_stall;                
wire             idu_iu_ex1_alu_dp_sel;           
wire             idu_iu_ex1_alu_sel;              
wire    [1  :0]  idu_iu_ex1_bht_pred;             
wire             idu_iu_ex1_bju_br_sel;           
wire             idu_iu_ex1_bju_dp_sel;           
wire             idu_iu_ex1_bju_sel;              
wire             idu_iu_ex1_div_dp_sel;           
wire             idu_iu_ex1_div_sel;              
wire    [5  :0]  idu_iu_ex1_dst0_reg;             
wire    [19 :0]  idu_iu_ex1_func;                 
wire             idu_iu_ex1_inst_vld;             
wire             idu_iu_ex1_length;               
wire             idu_iu_ex1_mult_dp_sel;          
wire             idu_iu_ex1_mult_sel;             
wire             idu_iu_ex1_pipedown_vld;         
wire             idu_iu_ex1_split;                
wire    [63 :0]  idu_iu_ex1_src0_data;            
wire             idu_iu_ex1_src0_ready;           
wire    [5  :0]  idu_iu_ex1_src0_reg;             
wire    [63 :0]  idu_iu_ex1_src1_data;            
wire             idu_iu_ex1_src1_ready;           
wire    [5  :0]  idu_iu_ex1_src1_reg;             
wire    [63 :0]  idu_iu_ex1_src2_data;            
wire             idu_lsu_ex1_dp_sel;              
wire    [5  :0]  idu_lsu_ex1_dst0_reg;            
wire    [5  :0]  idu_lsu_ex1_dst1_reg;            
wire    [19 :0]  idu_lsu_ex1_func;                
wire             idu_lsu_ex1_gateclk_sel;         
wire    [21 :0]  idu_lsu_ex1_halt_info;           
wire             idu_lsu_ex1_length;              
wire             idu_lsu_ex1_sel;                 
wire             idu_lsu_ex1_split;               
wire    [63 :0]  idu_lsu_ex1_src0_data;           
wire    [63 :0]  idu_lsu_ex1_src1_data;           
wire    [63 :0]  idu_lsu_ex1_src2_data;           
wire             idu_lsu_ex1_src2_ready;          
wire    [5  :0]  idu_lsu_ex1_src2_reg;            
wire    [1  :0]  idu_lsu_ex1_vlmul;               
wire    [1  :0]  idu_lsu_ex1_vsew;                
wire             idu_mult_ex1_gateclk_sel;        
wire             idu_vidu_ex1_fp_dp_sel;          
wire             idu_vidu_ex1_fp_gateclk_sel;     
wire             idu_vidu_ex1_fp_sel;             
wire    [179:0]  idu_vidu_ex1_inst_data;          
wire             idu_vidu_ex1_vec_dp_sel;         
wire             idu_vidu_ex1_vec_gateclk_sel;    
wire             idu_vidu_ex1_vec_sel;            
wire    [1  :0]  ifu_idu_id_bht_pred;             
wire             ifu_idu_id_expt_acc_error;       
wire             ifu_idu_id_expt_high;            
wire             ifu_idu_id_expt_page_fault;      
wire    [21 :0]  ifu_idu_id_halt_info;            
wire    [31 :0]  ifu_idu_id_inst;                 
wire             ifu_idu_id_inst_vld;             
wire             ifu_idu_warm_up;                 
wire             iu_idu_bju_full;                 
wire             iu_idu_bju_global_full;          
wire             iu_idu_div_full;                 
wire             iu_idu_mult_full;                
wire             iu_idu_mult_issue_stall;         
wire             iu_yy_xx_cancel;                 
wire             lsu_idu_full;                    
wire             lsu_idu_global_full;             
wire             pad_yy_icg_scan_en;              
wire             rtu_idu_commit;                  
wire             rtu_idu_commit_for_bju;          
wire             rtu_idu_flush_fe;                
wire             rtu_idu_flush_stall;             
wire             rtu_idu_flush_wbt;               
wire    [63 :0]  rtu_idu_fwd0_data;               
wire    [5  :0]  rtu_idu_fwd0_reg;                
wire             rtu_idu_fwd0_vld;                
wire    [63 :0]  rtu_idu_fwd1_data;               
wire    [5  :0]  rtu_idu_fwd1_reg;                
wire             rtu_idu_fwd1_vld;                
wire    [63 :0]  rtu_idu_fwd2_data;               
wire    [5  :0]  rtu_idu_fwd2_reg;                
wire             rtu_idu_fwd2_vld;                
wire             rtu_idu_pipeline_empty;          
wire    [63 :0]  rtu_idu_wb0_data;                
wire    [5  :0]  rtu_idu_wb0_reg;                 
wire             rtu_idu_wb0_vld;                 
wire    [63 :0]  rtu_idu_wb1_data;                
wire    [5  :0]  rtu_idu_wb1_reg;                 
wire             rtu_idu_wb1_vld;                 
wire             rtu_yy_xx_dbgon;                 
wire             split_ctrl_id_stall;             
wire             split_ctrl_inst_vld;             
wire    [264:0]  split_dp_inst_data;              
wire             split_dp_inst_sel;               
wire    [3  :0]  split_top_cur_state_no_idle;     
wire             vidu_idu_fp_full;                
wire             vidu_idu_vec_full;               
wire    [6  :0]  wbt_ctrl_dst0_info;              
wire    [6  :0]  wbt_ctrl_dst1_info;              
wire    [6  :0]  wbt_ctrl_src0_info;              
wire    [6  :0]  wbt_ctrl_src1_info;              
wire    [6  :0]  wbt_ctrl_src2_info;              
wire             wbt_top_gpr_not_wb;              


//==========================================================
//                      IDU Modules
//==========================================================
// &Instance("aq_idu_id_decd",  "x_aq_idu_id_decd"); @32
aq_idu_id_decd  x_aq_idu_id_decd (
  .cp0_idu_cskyee    (cp0_idu_cskyee   ),
  .cp0_idu_frm       (cp0_idu_frm      ),
  .cp0_idu_fs        (cp0_idu_fs       ),
  .cp0_idu_ucme      (cp0_idu_ucme     ),
  .cp0_idu_vill      (cp0_idu_vill     ),
  .cp0_idu_vl_zero   (cp0_idu_vl_zero  ),
  .cp0_idu_vs        (cp0_idu_vs       ),
  .cp0_idu_vstart    (cp0_idu_vstart   ),
  .cp0_yy_priv_mode  (cp0_yy_priv_mode ),
  .decd_dp_inst_data (decd_dp_inst_data),
  .dp_decd_inst      (dp_decd_inst     ),
  .dp_decd_vlmul     (dp_decd_vlmul    ),
  .dp_decd_vsew      (dp_decd_vsew     ),
  .rtu_yy_xx_dbgon   (rtu_yy_xx_dbgon  )
);

// &Instance("aq_idu_id_split", "x_aq_idu_id_split"); @33
aq_idu_id_split  x_aq_idu_id_split (
  .cp0_idu_cskyee              (cp0_idu_cskyee             ),
  .cp0_idu_icg_en              (cp0_idu_icg_en             ),
  .cp0_idu_ucme                (cp0_idu_ucme               ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .cp0_yy_priv_mode            (cp0_yy_priv_mode           ),
  .cpurst_b                    (cpurst_b                   ),
  .ctrl_xx_dis_stall           (ctrl_xx_dis_stall          ),
  .dp_split_inst               (dp_split_inst              ),
  .forever_cpuclk              (forever_cpuclk             ),
  .ifu_idu_id_inst_vld         (ifu_idu_id_inst_vld        ),
  .iu_yy_xx_cancel             (iu_yy_xx_cancel            ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_idu_flush_fe            (rtu_idu_flush_fe           ),
  .rtu_yy_xx_dbgon             (rtu_yy_xx_dbgon            ),
  .split_ctrl_id_stall         (split_ctrl_id_stall        ),
  .split_ctrl_inst_vld         (split_ctrl_inst_vld        ),
  .split_dp_inst_data          (split_dp_inst_data         ),
  .split_dp_inst_sel           (split_dp_inst_sel          ),
  .split_top_cur_state_no_idle (split_top_cur_state_no_idle)
);

// &Instance("aq_idu_id_gpr",   "x_aq_idu_id_gpr"); @34
aq_idu_id_gpr  x_aq_idu_id_gpr (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .dp_gpr_src0_reg    (dp_gpr_src0_reg   ),
  .dp_gpr_src1_reg    (dp_gpr_src1_reg   ),
  .dp_gpr_src2_reg    (dp_gpr_src2_reg   ),
  .dp_gpr_wb0_vld     (dp_gpr_wb0_vld    ),
  .dp_gpr_wb1_vld     (dp_gpr_wb1_vld    ),
  .forever_cpuclk     (forever_cpuclk    ),
  .gpr_dp_src0_data   (gpr_dp_src0_data  ),
  .gpr_dp_src1_data   (gpr_dp_src1_data  ),
  .gpr_dp_src2_data   (gpr_dp_src2_data  ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  )
);

// &Instance("aq_idu_id_wbt",   "x_aq_idu_id_wbt"); @35
aq_idu_id_wbt  x_aq_idu_id_wbt (
  .cp0_idu_icg_en        (cp0_idu_icg_en       ),
  .cp0_yy_clk_en         (cp0_yy_clk_en        ),
  .cpurst_b              (cpurst_b             ),
  .ctrl_wbt_dis_inst_vld (ctrl_wbt_dis_inst_vld),
  .ctrl_xx_dis_stall     (ctrl_xx_dis_stall    ),
  .dp_wbt_dst0_reg       (dp_wbt_dst0_reg      ),
  .dp_wbt_dst0_type      (dp_wbt_dst0_type     ),
  .dp_wbt_dst1_reg       (dp_wbt_dst1_reg      ),
  .dp_wbt_dst1_type      (dp_wbt_dst1_type     ),
  .dp_wbt_inst_dst0_vld  (dp_wbt_inst_dst0_vld ),
  .dp_wbt_inst_dst1_vld  (dp_wbt_inst_dst1_vld ),
  .dp_wbt_src0_reg       (dp_wbt_src0_reg      ),
  .dp_wbt_src1_reg       (dp_wbt_src1_reg      ),
  .dp_wbt_src2_reg       (dp_wbt_src2_reg      ),
  .dp_wbt_wb_vld         (dp_wbt_wb_vld        ),
  .forever_cpuclk        (forever_cpuclk       ),
  .iu_yy_xx_cancel       (iu_yy_xx_cancel      ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .rtu_idu_flush_wbt     (rtu_idu_flush_wbt    ),
  .rtu_idu_wb0_vld       (rtu_idu_wb0_vld      ),
  .rtu_idu_wb1_vld       (rtu_idu_wb1_vld      ),
  .wbt_ctrl_dst0_info    (wbt_ctrl_dst0_info   ),
  .wbt_ctrl_dst1_info    (wbt_ctrl_dst1_info   ),
  .wbt_ctrl_src0_info    (wbt_ctrl_src0_info   ),
  .wbt_ctrl_src1_info    (wbt_ctrl_src1_info   ),
  .wbt_ctrl_src2_info    (wbt_ctrl_src2_info   ),
  .wbt_top_gpr_not_wb    (wbt_top_gpr_not_wb   )
);

// &Instance("aq_idu_id_dp",    "x_aq_idu_id_dp"); @36
aq_idu_id_dp  x_aq_idu_id_dp (
  .cp0_idu_icg_en                   (cp0_idu_icg_en                  ),
  .cp0_idu_vlmul                    (cp0_idu_vlmul                   ),
  .cp0_idu_vsew                     (cp0_idu_vsew                    ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .ctrl_dp_dis_int_inst_gateclk_vld (ctrl_dp_dis_int_inst_gateclk_vld),
  .ctrl_dp_dis_vec_inst_gateclk_vld (ctrl_dp_dis_vec_inst_gateclk_vld),
  .ctrl_dp_ex1_stall                (ctrl_dp_ex1_stall               ),
  .decd_dp_inst_data                (decd_dp_inst_data               ),
  .dp_ctrl_dis_inst_cancel          (dp_ctrl_dis_inst_cancel         ),
  .dp_ctrl_dis_inst_cp0_fence       (dp_ctrl_dis_inst_cp0_fence      ),
  .dp_ctrl_dis_inst_dst0_type       (dp_ctrl_dis_inst_dst0_type      ),
  .dp_ctrl_dis_inst_dst0_vld        (dp_ctrl_dis_inst_dst0_vld       ),
  .dp_ctrl_dis_inst_dst1_type       (dp_ctrl_dis_inst_dst1_type      ),
  .dp_ctrl_dis_inst_dst1_vld        (dp_ctrl_dis_inst_dst1_vld       ),
  .dp_ctrl_dis_inst_eu              (dp_ctrl_dis_inst_eu             ),
  .dp_ctrl_dis_inst_expt_vld        (dp_ctrl_dis_inst_expt_vld       ),
  .dp_ctrl_dis_inst_func            (dp_ctrl_dis_inst_func           ),
  .dp_ctrl_dis_inst_src0_vld        (dp_ctrl_dis_inst_src0_vld       ),
  .dp_ctrl_dis_inst_src1_vld        (dp_ctrl_dis_inst_src1_vld       ),
  .dp_ctrl_dis_inst_src2_vld        (dp_ctrl_dis_inst_src2_vld       ),
  .dp_ctrl_dis_inst_src_type        (dp_ctrl_dis_inst_src_type       ),
  .dp_ctrl_dis_inst_store           (dp_ctrl_dis_inst_store          ),
  .dp_ctrl_dis_inst_vec             (dp_ctrl_dis_inst_vec            ),
  .dp_ctrl_inst_amo                 (dp_ctrl_inst_amo                ),
  .dp_ctrl_inst_csr                 (dp_ctrl_inst_csr                ),
  .dp_ctrl_inst_ecall               (dp_ctrl_inst_ecall              ),
  .dp_ctrl_inst_sync                (dp_ctrl_inst_sync               ),
  .dp_ctrl_src0_fwd_vld             (dp_ctrl_src0_fwd_vld            ),
  .dp_ctrl_src1_fwd_vld             (dp_ctrl_src1_fwd_vld            ),
  .dp_ctrl_src2_fwd_vld             (dp_ctrl_src2_fwd_vld            ),
  .dp_decd_inst                     (dp_decd_inst                    ),
  .dp_decd_vlmul                    (dp_decd_vlmul                   ),
  .dp_decd_vsew                     (dp_decd_vsew                    ),
  .dp_gpr_src0_reg                  (dp_gpr_src0_reg                 ),
  .dp_gpr_src1_reg                  (dp_gpr_src1_reg                 ),
  .dp_gpr_src2_reg                  (dp_gpr_src2_reg                 ),
  .dp_gpr_wb0_vld                   (dp_gpr_wb0_vld                  ),
  .dp_gpr_wb1_vld                   (dp_gpr_wb1_vld                  ),
  .dp_split_inst                    (dp_split_inst                   ),
  .dp_wbt_dst0_reg                  (dp_wbt_dst0_reg                 ),
  .dp_wbt_dst0_type                 (dp_wbt_dst0_type                ),
  .dp_wbt_dst1_reg                  (dp_wbt_dst1_reg                 ),
  .dp_wbt_dst1_type                 (dp_wbt_dst1_type                ),
  .dp_wbt_inst_dst0_vld             (dp_wbt_inst_dst0_vld            ),
  .dp_wbt_inst_dst1_vld             (dp_wbt_inst_dst1_vld            ),
  .dp_wbt_src0_reg                  (dp_wbt_src0_reg                 ),
  .dp_wbt_src1_reg                  (dp_wbt_src1_reg                 ),
  .dp_wbt_src2_reg                  (dp_wbt_src2_reg                 ),
  .dp_wbt_wb_vld                    (dp_wbt_wb_vld                   ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .gpr_dp_src0_data                 (gpr_dp_src0_data                ),
  .gpr_dp_src1_data                 (gpr_dp_src1_data                ),
  .gpr_dp_src2_data                 (gpr_dp_src2_data                ),
  .idu_cp0_ex1_dst0_reg             (idu_cp0_ex1_dst0_reg            ),
  .idu_cp0_ex1_expt_acc_error       (idu_cp0_ex1_expt_acc_error      ),
  .idu_cp0_ex1_expt_high            (idu_cp0_ex1_expt_high           ),
  .idu_cp0_ex1_expt_illegal         (idu_cp0_ex1_expt_illegal        ),
  .idu_cp0_ex1_expt_page_fault      (idu_cp0_ex1_expt_page_fault     ),
  .idu_cp0_ex1_func                 (idu_cp0_ex1_func                ),
  .idu_cp0_ex1_halt_info            (idu_cp0_ex1_halt_info           ),
  .idu_cp0_ex1_length               (idu_cp0_ex1_length              ),
  .idu_cp0_ex1_opcode               (idu_cp0_ex1_opcode              ),
  .idu_cp0_ex1_split                (idu_cp0_ex1_split               ),
  .idu_cp0_ex1_src0_data            (idu_cp0_ex1_src0_data           ),
  .idu_cp0_ex1_src1_data            (idu_cp0_ex1_src1_data           ),
  .idu_iu_ex1_bht_pred              (idu_iu_ex1_bht_pred             ),
  .idu_iu_ex1_dst0_reg              (idu_iu_ex1_dst0_reg             ),
  .idu_iu_ex1_func                  (idu_iu_ex1_func                 ),
  .idu_iu_ex1_length                (idu_iu_ex1_length               ),
  .idu_iu_ex1_split                 (idu_iu_ex1_split                ),
  .idu_iu_ex1_src0_data             (idu_iu_ex1_src0_data            ),
  .idu_iu_ex1_src0_ready            (idu_iu_ex1_src0_ready           ),
  .idu_iu_ex1_src0_reg              (idu_iu_ex1_src0_reg             ),
  .idu_iu_ex1_src1_data             (idu_iu_ex1_src1_data            ),
  .idu_iu_ex1_src1_ready            (idu_iu_ex1_src1_ready           ),
  .idu_iu_ex1_src1_reg              (idu_iu_ex1_src1_reg             ),
  .idu_iu_ex1_src2_data             (idu_iu_ex1_src2_data            ),
  .idu_lsu_ex1_dst0_reg             (idu_lsu_ex1_dst0_reg            ),
  .idu_lsu_ex1_dst1_reg             (idu_lsu_ex1_dst1_reg            ),
  .idu_lsu_ex1_func                 (idu_lsu_ex1_func                ),
  .idu_lsu_ex1_halt_info            (idu_lsu_ex1_halt_info           ),
  .idu_lsu_ex1_length               (idu_lsu_ex1_length              ),
  .idu_lsu_ex1_split                (idu_lsu_ex1_split               ),
  .idu_lsu_ex1_src0_data            (idu_lsu_ex1_src0_data           ),
  .idu_lsu_ex1_src1_data            (idu_lsu_ex1_src1_data           ),
  .idu_lsu_ex1_src2_data            (idu_lsu_ex1_src2_data           ),
  .idu_lsu_ex1_src2_ready           (idu_lsu_ex1_src2_ready          ),
  .idu_lsu_ex1_src2_reg             (idu_lsu_ex1_src2_reg            ),
  .idu_lsu_ex1_vlmul                (idu_lsu_ex1_vlmul               ),
  .idu_lsu_ex1_vsew                 (idu_lsu_ex1_vsew                ),
  .idu_vidu_ex1_inst_data           (idu_vidu_ex1_inst_data          ),
  .ifu_idu_id_bht_pred              (ifu_idu_id_bht_pred             ),
  .ifu_idu_id_expt_acc_error        (ifu_idu_id_expt_acc_error       ),
  .ifu_idu_id_expt_high             (ifu_idu_id_expt_high            ),
  .ifu_idu_id_expt_page_fault       (ifu_idu_id_expt_page_fault      ),
  .ifu_idu_id_halt_info             (ifu_idu_id_halt_info            ),
  .ifu_idu_id_inst                  (ifu_idu_id_inst                 ),
  .ifu_idu_warm_up                  (ifu_idu_warm_up                 ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_idu_fwd0_data                (rtu_idu_fwd0_data               ),
  .rtu_idu_fwd0_reg                 (rtu_idu_fwd0_reg                ),
  .rtu_idu_fwd0_vld                 (rtu_idu_fwd0_vld                ),
  .rtu_idu_fwd1_data                (rtu_idu_fwd1_data               ),
  .rtu_idu_fwd1_reg                 (rtu_idu_fwd1_reg                ),
  .rtu_idu_fwd1_vld                 (rtu_idu_fwd1_vld                ),
  .rtu_idu_fwd2_data                (rtu_idu_fwd2_data               ),
  .rtu_idu_fwd2_reg                 (rtu_idu_fwd2_reg                ),
  .rtu_idu_fwd2_vld                 (rtu_idu_fwd2_vld                ),
  .rtu_idu_wb0_data                 (rtu_idu_wb0_data                ),
  .rtu_idu_wb0_reg                  (rtu_idu_wb0_reg                 ),
  .rtu_idu_wb0_vld                  (rtu_idu_wb0_vld                 ),
  .rtu_idu_wb1_data                 (rtu_idu_wb1_data                ),
  .rtu_idu_wb1_reg                  (rtu_idu_wb1_reg                 ),
  .rtu_idu_wb1_vld                  (rtu_idu_wb1_vld                 ),
  .split_dp_inst_data               (split_dp_inst_data              ),
  .split_dp_inst_sel                (split_dp_inst_sel               ),
  .wbt_ctrl_src0_info               (wbt_ctrl_src0_info              ),
  .wbt_ctrl_src1_info               (wbt_ctrl_src1_info              ),
  .wbt_ctrl_src2_info               (wbt_ctrl_src2_info              )
);

// &Instance("aq_idu_id_ctrl",  "x_aq_idu_id_ctrl"); @37
aq_idu_id_ctrl  x_aq_idu_id_ctrl (
  .cp0_idu_dis_fence_in_dbg         (cp0_idu_dis_fence_in_dbg        ),
  .cp0_idu_icg_en                   (cp0_idu_icg_en                  ),
  .cp0_idu_issue_stall              (cp0_idu_issue_stall             ),
  .cp0_idu_vsetvl_dis_stall         (cp0_idu_vsetvl_dis_stall        ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .ctrl_dp_dis_int_inst_gateclk_vld (ctrl_dp_dis_int_inst_gateclk_vld),
  .ctrl_dp_dis_vec_inst_gateclk_vld (ctrl_dp_dis_vec_inst_gateclk_vld),
  .ctrl_dp_ex1_stall                (ctrl_dp_ex1_stall               ),
  .ctrl_top_eu_sel                  (ctrl_top_eu_sel                 ),
  .ctrl_wbt_dis_inst_vld            (ctrl_wbt_dis_inst_vld           ),
  .ctrl_xx_dis_stall                (ctrl_xx_dis_stall               ),
  .dp_ctrl_dis_inst_cancel          (dp_ctrl_dis_inst_cancel         ),
  .dp_ctrl_dis_inst_cp0_fence       (dp_ctrl_dis_inst_cp0_fence      ),
  .dp_ctrl_dis_inst_dst0_type       (dp_ctrl_dis_inst_dst0_type      ),
  .dp_ctrl_dis_inst_dst0_vld        (dp_ctrl_dis_inst_dst0_vld       ),
  .dp_ctrl_dis_inst_dst1_type       (dp_ctrl_dis_inst_dst1_type      ),
  .dp_ctrl_dis_inst_dst1_vld        (dp_ctrl_dis_inst_dst1_vld       ),
  .dp_ctrl_dis_inst_eu              (dp_ctrl_dis_inst_eu             ),
  .dp_ctrl_dis_inst_expt_vld        (dp_ctrl_dis_inst_expt_vld       ),
  .dp_ctrl_dis_inst_func            (dp_ctrl_dis_inst_func           ),
  .dp_ctrl_dis_inst_src0_vld        (dp_ctrl_dis_inst_src0_vld       ),
  .dp_ctrl_dis_inst_src1_vld        (dp_ctrl_dis_inst_src1_vld       ),
  .dp_ctrl_dis_inst_src2_vld        (dp_ctrl_dis_inst_src2_vld       ),
  .dp_ctrl_dis_inst_src_type        (dp_ctrl_dis_inst_src_type       ),
  .dp_ctrl_dis_inst_store           (dp_ctrl_dis_inst_store          ),
  .dp_ctrl_dis_inst_vec             (dp_ctrl_dis_inst_vec            ),
  .dp_ctrl_inst_amo                 (dp_ctrl_inst_amo                ),
  .dp_ctrl_inst_csr                 (dp_ctrl_inst_csr                ),
  .dp_ctrl_inst_ecall               (dp_ctrl_inst_ecall              ),
  .dp_ctrl_inst_sync                (dp_ctrl_inst_sync               ),
  .dp_ctrl_src0_fwd_vld             (dp_ctrl_src0_fwd_vld            ),
  .dp_ctrl_src1_fwd_vld             (dp_ctrl_src1_fwd_vld            ),
  .dp_ctrl_src2_fwd_vld             (dp_ctrl_src2_fwd_vld            ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .hpcp_idu_cnt_en                  (hpcp_idu_cnt_en                 ),
  .idu_alu_ex1_gateclk_sel          (idu_alu_ex1_gateclk_sel         ),
  .idu_bju_ex1_gateclk_sel          (idu_bju_ex1_gateclk_sel         ),
  .idu_cp0_ex1_dp_sel               (idu_cp0_ex1_dp_sel              ),
  .idu_cp0_ex1_gateclk_sel          (idu_cp0_ex1_gateclk_sel         ),
  .idu_cp0_ex1_sel                  (idu_cp0_ex1_sel                 ),
  .idu_div_ex1_gateclk_sel          (idu_div_ex1_gateclk_sel         ),
  .idu_hpcp_backend_stall           (idu_hpcp_backend_stall          ),
  .idu_hpcp_frontend_stall          (idu_hpcp_frontend_stall         ),
  .idu_hpcp_inst_type               (idu_hpcp_inst_type              ),
  .idu_ifu_id_stall                 (idu_ifu_id_stall                ),
  .idu_iu_ex1_alu_dp_sel            (idu_iu_ex1_alu_dp_sel           ),
  .idu_iu_ex1_alu_sel               (idu_iu_ex1_alu_sel              ),
  .idu_iu_ex1_bju_br_sel            (idu_iu_ex1_bju_br_sel           ),
  .idu_iu_ex1_bju_dp_sel            (idu_iu_ex1_bju_dp_sel           ),
  .idu_iu_ex1_bju_sel               (idu_iu_ex1_bju_sel              ),
  .idu_iu_ex1_div_dp_sel            (idu_iu_ex1_div_dp_sel           ),
  .idu_iu_ex1_div_sel               (idu_iu_ex1_div_sel              ),
  .idu_iu_ex1_inst_vld              (idu_iu_ex1_inst_vld             ),
  .idu_iu_ex1_mult_dp_sel           (idu_iu_ex1_mult_dp_sel          ),
  .idu_iu_ex1_mult_sel              (idu_iu_ex1_mult_sel             ),
  .idu_iu_ex1_pipedown_vld          (idu_iu_ex1_pipedown_vld         ),
  .idu_lsu_ex1_dp_sel               (idu_lsu_ex1_dp_sel              ),
  .idu_lsu_ex1_gateclk_sel          (idu_lsu_ex1_gateclk_sel         ),
  .idu_lsu_ex1_sel                  (idu_lsu_ex1_sel                 ),
  .idu_mult_ex1_gateclk_sel         (idu_mult_ex1_gateclk_sel        ),
  .idu_vidu_ex1_fp_dp_sel           (idu_vidu_ex1_fp_dp_sel          ),
  .idu_vidu_ex1_fp_gateclk_sel      (idu_vidu_ex1_fp_gateclk_sel     ),
  .idu_vidu_ex1_fp_sel              (idu_vidu_ex1_fp_sel             ),
  .idu_vidu_ex1_vec_dp_sel          (idu_vidu_ex1_vec_dp_sel         ),
  .idu_vidu_ex1_vec_gateclk_sel     (idu_vidu_ex1_vec_gateclk_sel    ),
  .idu_vidu_ex1_vec_sel             (idu_vidu_ex1_vec_sel            ),
  .ifu_idu_id_inst_vld              (ifu_idu_id_inst_vld             ),
  .ifu_idu_warm_up                  (ifu_idu_warm_up                 ),
  .iu_idu_bju_full                  (iu_idu_bju_full                 ),
  .iu_idu_bju_global_full           (iu_idu_bju_global_full          ),
  .iu_idu_div_full                  (iu_idu_div_full                 ),
  .iu_idu_mult_full                 (iu_idu_mult_full                ),
  .iu_idu_mult_issue_stall          (iu_idu_mult_issue_stall         ),
  .iu_yy_xx_cancel                  (iu_yy_xx_cancel                 ),
  .lsu_idu_full                     (lsu_idu_full                    ),
  .lsu_idu_global_full              (lsu_idu_global_full             ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_idu_commit                   (rtu_idu_commit                  ),
  .rtu_idu_commit_for_bju           (rtu_idu_commit_for_bju          ),
  .rtu_idu_flush_fe                 (rtu_idu_flush_fe                ),
  .rtu_idu_flush_stall              (rtu_idu_flush_stall             ),
  .rtu_idu_pipeline_empty           (rtu_idu_pipeline_empty          ),
  .rtu_yy_xx_dbgon                  (rtu_yy_xx_dbgon                 ),
  .split_ctrl_id_stall              (split_ctrl_id_stall             ),
  .split_ctrl_inst_vld              (split_ctrl_inst_vld             ),
  .split_dp_inst_sel                (split_dp_inst_sel               ),
  .vidu_idu_fp_full                 (vidu_idu_fp_full                ),
  .vidu_idu_vec_full                (vidu_idu_vec_full               ),
  .wbt_ctrl_dst0_info               (wbt_ctrl_dst0_info              ),
  .wbt_ctrl_dst1_info               (wbt_ctrl_dst1_info              ),
  .wbt_ctrl_src0_info               (wbt_ctrl_src0_info              ),
  .wbt_ctrl_src1_info               (wbt_ctrl_src1_info              ),
  .wbt_ctrl_src2_info               (wbt_ctrl_src2_info              )
);


//==========================================================
//                      Debug info
//==========================================================
assign idu_dtu_debug_info[0]               = wbt_top_gpr_not_wb;
assign idu_dtu_debug_info[4:1]             = split_top_cur_state_no_idle[3:0];
assign idu_dtu_debug_info[`EU_WIDTH-1+5:5] = ctrl_top_eu_sel[`EU_WIDTH-1:0];

// &Force("input","forever_cpuclk"); @51
// &Force("input","cp0_rtu_ex1_expt_vld"); @52
// &Force("input","cp0_rtu_ex1_expt_vec"); @53
// &Force("bus","cp0_rtu_ex1_expt_vec",3,0); @54
// &ModuleEnd; @57
endmodule



