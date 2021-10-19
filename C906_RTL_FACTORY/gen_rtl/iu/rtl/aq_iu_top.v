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
module aq_iu_top(
  cp0_iu_icg_en,
  cp0_xx_mrvbr,
  cp0_yy_clk_en,
  cpurst_b,
  da_xx_fwd_data,
  da_xx_fwd_dst_reg,
  da_xx_fwd_vld,
  forever_cpuclk,
  hpcp_iu_cnt_en,
  idu_alu_ex1_gateclk_sel,
  idu_bju_ex1_gateclk_sel,
  idu_div_ex1_gateclk_sel,
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
  idu_mult_ex1_gateclk_sel,
  ifu_iu_chgflw_pc,
  ifu_iu_chgflw_vld,
  ifu_iu_ex1_pc_pred,
  ifu_iu_reset_vld,
  ifu_iu_warm_up,
  iu_cp0_ex1_cur_pc,
  iu_dtu_debug_info,
  iu_hpcp_inst_bht_mispred,
  iu_hpcp_inst_condbr,
  iu_hpcp_jump_8m,
  iu_idu_bju_full,
  iu_idu_bju_global_full,
  iu_idu_div_full,
  iu_idu_mult_full,
  iu_idu_mult_issue_stall,
  iu_ifu_bht_cur_pc,
  iu_ifu_bht_mispred,
  iu_ifu_bht_mispred_gate,
  iu_ifu_bht_pred,
  iu_ifu_bht_taken,
  iu_ifu_br_vld,
  iu_ifu_br_vld_gate,
  iu_ifu_link_vld,
  iu_ifu_link_vld_gate,
  iu_ifu_pc_mispred,
  iu_ifu_pc_mispred_gate,
  iu_ifu_ret_vld,
  iu_ifu_ret_vld_gate,
  iu_ifu_tar_pc,
  iu_ifu_tar_pc_vld,
  iu_ifu_tar_pc_vld_gate,
  iu_lsu_ex1_cur_pc,
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
  iu_yy_xx_cancel,
  lsu_iu_ex2_data,
  lsu_iu_ex2_data_vld,
  lsu_iu_ex2_dest_reg,
  mmu_xx_mmu_en,
  pad_yy_icg_scan_en,
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
  rtu_yy_xx_flush_fe
);

// &Ports; @24
input           cp0_iu_icg_en;               
input   [39:0]  cp0_xx_mrvbr;                
input           cp0_yy_clk_en;               
input           cpurst_b;                    
input   [63:0]  da_xx_fwd_data;              
input   [5 :0]  da_xx_fwd_dst_reg;           
input           da_xx_fwd_vld;               
input           forever_cpuclk;              
input           hpcp_iu_cnt_en;              
input           idu_alu_ex1_gateclk_sel;     
input           idu_bju_ex1_gateclk_sel;     
input           idu_div_ex1_gateclk_sel;     
input           idu_iu_ex1_alu_dp_sel;       
input           idu_iu_ex1_alu_sel;          
input   [1 :0]  idu_iu_ex1_bht_pred;         
input           idu_iu_ex1_bju_br_sel;       
input           idu_iu_ex1_bju_dp_sel;       
input           idu_iu_ex1_bju_sel;          
input           idu_iu_ex1_div_dp_sel;       
input           idu_iu_ex1_div_sel;          
input   [5 :0]  idu_iu_ex1_dst0_reg;         
input   [19:0]  idu_iu_ex1_func;             
input           idu_iu_ex1_inst_vld;         
input           idu_iu_ex1_length;           
input           idu_iu_ex1_mult_dp_sel;      
input           idu_iu_ex1_mult_sel;         
input           idu_iu_ex1_pipedown_vld;     
input           idu_iu_ex1_split;            
input   [63:0]  idu_iu_ex1_src0_data;        
input           idu_iu_ex1_src0_ready;       
input   [5 :0]  idu_iu_ex1_src0_reg;         
input   [63:0]  idu_iu_ex1_src1_data;        
input           idu_iu_ex1_src1_ready;       
input   [5 :0]  idu_iu_ex1_src1_reg;         
input   [63:0]  idu_iu_ex1_src2_data;        
input           idu_mult_ex1_gateclk_sel;    
input   [39:0]  ifu_iu_chgflw_pc;            
input           ifu_iu_chgflw_vld;           
input   [39:0]  ifu_iu_ex1_pc_pred;          
input           ifu_iu_reset_vld;            
input           ifu_iu_warm_up;              
input   [63:0]  lsu_iu_ex2_data;             
input           lsu_iu_ex2_data_vld;         
input   [4 :0]  lsu_iu_ex2_dest_reg;         
input           mmu_xx_mmu_en;               
input           pad_yy_icg_scan_en;          
input           rtu_iu_div_wb_grant;         
input           rtu_iu_div_wb_grant_for_full; 
input           rtu_iu_ex1_cmplt;            
input           rtu_iu_ex1_cmplt_dp;         
input           rtu_iu_ex1_inst_len;         
input           rtu_iu_ex1_inst_split;       
input   [39:0]  rtu_iu_ex2_cur_pc;           
input   [39:0]  rtu_iu_ex2_next_pc;          
input           rtu_iu_mul_wb_grant;         
input           rtu_iu_mul_wb_grant_for_full; 
input           rtu_yy_xx_flush_fe;          
output  [39:0]  iu_cp0_ex1_cur_pc;           
output  [8 :0]  iu_dtu_debug_info;           
output          iu_hpcp_inst_bht_mispred;    
output          iu_hpcp_inst_condbr;         
output          iu_hpcp_jump_8m;             
output          iu_idu_bju_full;             
output          iu_idu_bju_global_full;      
output          iu_idu_div_full;             
output          iu_idu_mult_full;            
output          iu_idu_mult_issue_stall;     
output  [39:0]  iu_ifu_bht_cur_pc;           
output          iu_ifu_bht_mispred;          
output          iu_ifu_bht_mispred_gate;     
output  [1 :0]  iu_ifu_bht_pred;             
output          iu_ifu_bht_taken;            
output          iu_ifu_br_vld;               
output          iu_ifu_br_vld_gate;          
output          iu_ifu_link_vld;             
output          iu_ifu_link_vld_gate;        
output          iu_ifu_pc_mispred;           
output          iu_ifu_pc_mispred_gate;      
output          iu_ifu_ret_vld;              
output          iu_ifu_ret_vld_gate;         
output  [63:0]  iu_ifu_tar_pc;               
output          iu_ifu_tar_pc_vld;           
output          iu_ifu_tar_pc_vld_gate;      
output  [15:0]  iu_lsu_ex1_cur_pc;           
output          iu_rtu_depd_lsu_chgflow_vld; 
output  [39:0]  iu_rtu_depd_lsu_next_pc;     
output  [63:0]  iu_rtu_div_data;             
output  [5 :0]  iu_rtu_div_preg;             
output          iu_rtu_div_wb_dp;            
output          iu_rtu_div_wb_vld;           
output          iu_rtu_ex1_alu_cmplt;        
output          iu_rtu_ex1_alu_cmplt_dp;     
output  [63:0]  iu_rtu_ex1_alu_data;         
output          iu_rtu_ex1_alu_inst_len;     
output          iu_rtu_ex1_alu_inst_split;   
output  [5 :0]  iu_rtu_ex1_alu_preg;         
output          iu_rtu_ex1_alu_wb_dp;        
output          iu_rtu_ex1_alu_wb_vld;       
output          iu_rtu_ex1_bju_cmplt;        
output          iu_rtu_ex1_bju_cmplt_dp;     
output  [63:0]  iu_rtu_ex1_bju_data;         
output          iu_rtu_ex1_bju_inst_len;     
output  [5 :0]  iu_rtu_ex1_bju_preg;         
output          iu_rtu_ex1_bju_wb_dp;        
output          iu_rtu_ex1_bju_wb_vld;       
output          iu_rtu_ex1_branch_inst;      
output  [39:0]  iu_rtu_ex1_cur_pc;           
output          iu_rtu_ex1_div_cmplt;        
output          iu_rtu_ex1_div_cmplt_dp;     
output          iu_rtu_ex1_mul_cmplt;        
output          iu_rtu_ex1_mul_cmplt_dp;     
output  [39:0]  iu_rtu_ex1_next_pc;          
output          iu_rtu_ex2_bju_ras_mispred;  
output  [63:0]  iu_rtu_ex3_mul_data;         
output  [5 :0]  iu_rtu_ex3_mul_preg;         
output          iu_rtu_ex3_mul_wb_vld;       
output          iu_xx_no_op;                 
output          iu_yy_xx_cancel;             

// &Regs; @25

// &Wires; @26
wire    [63:0]  ag_bju_pc;                   
wire    [39:0]  bju_ag_cur_pc;               
wire    [63:0]  bju_ag_offset;               
wire            bju_ag_offset_sel;           
wire            bju_ag_use_pc;               
wire    [3 :0]  bju_deginfo;                 
wire            bju_entry_no_vld;            
wire            bju_ras_not_vld;             
wire            cp0_iu_icg_en;               
wire    [39:0]  cp0_xx_mrvbr;                
wire            cp0_yy_clk_en;               
wire            cpurst_b;                    
wire    [63:0]  da_xx_fwd_data;              
wire    [5 :0]  da_xx_fwd_dst_reg;           
wire            da_xx_fwd_vld;               
wire            div_ctrl_no_op;              
wire    [2 :0]  div_dbginfo;                 
wire            forever_cpuclk;              
wire            hpcp_iu_cnt_en;              
wire            idu_alu_ex1_gateclk_sel;     
wire            idu_bju_ex1_gateclk_sel;     
wire            idu_div_ex1_gateclk_sel;     
wire            idu_iu_ex1_alu_dp_sel;       
wire            idu_iu_ex1_alu_sel;          
wire    [1 :0]  idu_iu_ex1_bht_pred;         
wire            idu_iu_ex1_bju_br_sel;       
wire            idu_iu_ex1_bju_dp_sel;       
wire            idu_iu_ex1_bju_sel;          
wire            idu_iu_ex1_div_dp_sel;       
wire            idu_iu_ex1_div_sel;          
wire    [5 :0]  idu_iu_ex1_dst0_reg;         
wire    [5 :0]  idu_iu_ex1_dst_preg;         
wire    [19:0]  idu_iu_ex1_func;             
wire            idu_iu_ex1_inst_len;         
wire            idu_iu_ex1_inst_vld;         
wire            idu_iu_ex1_length;           
wire            idu_iu_ex1_mult_dp_sel;      
wire            idu_iu_ex1_mult_sel;         
wire            idu_iu_ex1_pipedown_vld;     
wire            idu_iu_ex1_split;            
wire    [63:0]  idu_iu_ex1_src0;             
wire    [63:0]  idu_iu_ex1_src0_data;        
wire            idu_iu_ex1_src0_ready;       
wire    [5 :0]  idu_iu_ex1_src0_reg;         
wire    [63:0]  idu_iu_ex1_src1;             
wire    [63:0]  idu_iu_ex1_src1_data;        
wire            idu_iu_ex1_src1_ready;       
wire    [5 :0]  idu_iu_ex1_src1_reg;         
wire    [63:0]  idu_iu_ex1_src2;             
wire    [63:0]  idu_iu_ex1_src2_data;        
wire            idu_mult_ex1_gateclk_sel;    
wire    [39:0]  ifu_iu_chgflw_pc;            
wire            ifu_iu_chgflw_vld;           
wire    [39:0]  ifu_iu_ex1_pc_pred;          
wire            ifu_iu_reset_vld;            
wire            ifu_iu_warm_up;              
wire    [39:0]  iu_cp0_ex1_cur_pc;           
wire    [8 :0]  iu_dtu_debug_info;           
wire            iu_hpcp_inst_bht_mispred;    
wire            iu_hpcp_inst_condbr;         
wire            iu_hpcp_jump_8m;             
wire            iu_idu_bju_full;             
wire            iu_idu_bju_global_full;      
wire            iu_idu_div_full;             
wire            iu_idu_mult_full;            
wire            iu_idu_mult_issue_stall;     
wire    [39:0]  iu_ifu_bht_cur_pc;           
wire            iu_ifu_bht_mispred;          
wire            iu_ifu_bht_mispred_gate;     
wire    [1 :0]  iu_ifu_bht_pred;             
wire            iu_ifu_bht_taken;            
wire            iu_ifu_br_vld;               
wire            iu_ifu_br_vld_gate;          
wire            iu_ifu_link_vld;             
wire            iu_ifu_link_vld_gate;        
wire            iu_ifu_pc_mispred;           
wire            iu_ifu_pc_mispred_gate;      
wire            iu_ifu_ret_vld;              
wire            iu_ifu_ret_vld_gate;         
wire    [63:0]  iu_ifu_tar_pc;               
wire            iu_ifu_tar_pc_vld;           
wire            iu_ifu_tar_pc_vld_gate;      
wire    [15:0]  iu_lsu_ex1_cur_pc;           
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
wire            iu_yy_xx_cancel;             
wire    [63:0]  lsu_iu_ex2_data;             
wire            lsu_iu_ex2_data_vld;         
wire    [4 :0]  lsu_iu_ex2_dest_reg;         
wire            mmu_xx_mmu_en;               
wire            mul_ctrl_no_op;              
wire    [1 :0]  mul_dbginfo;                 
wire            pad_yy_icg_scan_en;          
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
wire            rtu_yy_xx_flush_fe;          


// &Instance("aq_iu_alu"); @28
aq_iu_alu  x_aq_iu_alu (
  .idu_alu_ex1_gateclk_sel   (idu_alu_ex1_gateclk_sel  ),
  .idu_iu_ex1_alu_dp_sel     (idu_iu_ex1_alu_dp_sel    ),
  .idu_iu_ex1_alu_sel        (idu_iu_ex1_alu_sel       ),
  .idu_iu_ex1_dst0_reg       (idu_iu_ex1_dst0_reg      ),
  .idu_iu_ex1_func           (idu_iu_ex1_func          ),
  .idu_iu_ex1_inst_len       (idu_iu_ex1_inst_len      ),
  .idu_iu_ex1_split          (idu_iu_ex1_split         ),
  .idu_iu_ex1_src0           (idu_iu_ex1_src0          ),
  .idu_iu_ex1_src1           (idu_iu_ex1_src1          ),
  .idu_iu_ex1_src2           (idu_iu_ex1_src2          ),
  .iu_rtu_ex1_alu_cmplt      (iu_rtu_ex1_alu_cmplt     ),
  .iu_rtu_ex1_alu_cmplt_dp   (iu_rtu_ex1_alu_cmplt_dp  ),
  .iu_rtu_ex1_alu_data       (iu_rtu_ex1_alu_data      ),
  .iu_rtu_ex1_alu_inst_len   (iu_rtu_ex1_alu_inst_len  ),
  .iu_rtu_ex1_alu_inst_split (iu_rtu_ex1_alu_inst_split),
  .iu_rtu_ex1_alu_preg       (iu_rtu_ex1_alu_preg      ),
  .iu_rtu_ex1_alu_wb_dp      (iu_rtu_ex1_alu_wb_dp     ),
  .iu_rtu_ex1_alu_wb_vld     (iu_rtu_ex1_alu_wb_vld    )
);


// &Instance("aq_iu_mul"); @30
aq_iu_mul  x_aq_iu_mul (
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .idu_iu_ex1_dst_preg          (idu_iu_ex1_dst_preg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_mult_dp_sel       (idu_iu_ex1_mult_dp_sel      ),
  .idu_iu_ex1_mult_sel          (idu_iu_ex1_mult_sel         ),
  .idu_iu_ex1_src0              (idu_iu_ex1_src0             ),
  .idu_iu_ex1_src1              (idu_iu_ex1_src1             ),
  .idu_iu_ex1_src2              (idu_iu_ex1_src2             ),
  .idu_mult_ex1_gateclk_sel     (idu_mult_ex1_gateclk_sel    ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .iu_idu_mult_full             (iu_idu_mult_full            ),
  .iu_idu_mult_issue_stall      (iu_idu_mult_issue_stall     ),
  .iu_rtu_ex1_mul_cmplt         (iu_rtu_ex1_mul_cmplt        ),
  .iu_rtu_ex1_mul_cmplt_dp      (iu_rtu_ex1_mul_cmplt_dp     ),
  .iu_rtu_ex3_mul_data          (iu_rtu_ex3_mul_data         ),
  .iu_rtu_ex3_mul_preg          (iu_rtu_ex3_mul_preg         ),
  .iu_rtu_ex3_mul_wb_vld        (iu_rtu_ex3_mul_wb_vld       ),
  .mul_ctrl_no_op               (mul_ctrl_no_op              ),
  .mul_dbginfo                  (mul_dbginfo                 ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_iu_mul_wb_grant          (rtu_iu_mul_wb_grant         ),
  .rtu_iu_mul_wb_grant_for_full (rtu_iu_mul_wb_grant_for_full),
  .rtu_yy_xx_flush_fe           (rtu_yy_xx_flush_fe          )
);


// &Instance("aq_iu_div"); @32
aq_iu_div  x_aq_iu_div (
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .div_ctrl_no_op               (div_ctrl_no_op              ),
  .div_dbginfo                  (div_dbginfo                 ),
  .forever_cpuclk               (forever_cpuclk              ),
  .idu_div_ex1_gateclk_sel      (idu_div_ex1_gateclk_sel     ),
  .idu_iu_ex1_div_dp_sel        (idu_iu_ex1_div_dp_sel       ),
  .idu_iu_ex1_div_sel           (idu_iu_ex1_div_sel          ),
  .idu_iu_ex1_dst_preg          (idu_iu_ex1_dst_preg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_src0              (idu_iu_ex1_src0             ),
  .idu_iu_ex1_src1              (idu_iu_ex1_src1             ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .iu_idu_div_full              (iu_idu_div_full             ),
  .iu_rtu_div_data              (iu_rtu_div_data             ),
  .iu_rtu_div_preg              (iu_rtu_div_preg             ),
  .iu_rtu_div_wb_dp             (iu_rtu_div_wb_dp            ),
  .iu_rtu_div_wb_vld            (iu_rtu_div_wb_vld           ),
  .iu_rtu_ex1_div_cmplt         (iu_rtu_ex1_div_cmplt        ),
  .iu_rtu_ex1_div_cmplt_dp      (iu_rtu_ex1_div_cmplt_dp     ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_iu_div_wb_grant          (rtu_iu_div_wb_grant         ),
  .rtu_iu_div_wb_grant_for_full (rtu_iu_div_wb_grant_for_full)
);


// &Instance("aq_iu_bju"); @34
aq_iu_bju  x_aq_iu_bju (
  .ag_bju_pc                   (ag_bju_pc                  ),
  .bju_ag_cur_pc               (bju_ag_cur_pc              ),
  .bju_ag_offset               (bju_ag_offset              ),
  .bju_ag_offset_sel           (bju_ag_offset_sel          ),
  .bju_ag_use_pc               (bju_ag_use_pc              ),
  .bju_deginfo                 (bju_deginfo                ),
  .bju_entry_no_vld            (bju_entry_no_vld           ),
  .bju_ras_not_vld             (bju_ras_not_vld            ),
  .cp0_iu_icg_en               (cp0_iu_icg_en              ),
  .cp0_xx_mrvbr                (cp0_xx_mrvbr               ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .cpurst_b                    (cpurst_b                   ),
  .da_xx_fwd_data              (da_xx_fwd_data             ),
  .da_xx_fwd_dst_reg           (da_xx_fwd_dst_reg          ),
  .da_xx_fwd_vld               (da_xx_fwd_vld              ),
  .forever_cpuclk              (forever_cpuclk             ),
  .hpcp_iu_cnt_en              (hpcp_iu_cnt_en             ),
  .idu_bju_ex1_gateclk_sel     (idu_bju_ex1_gateclk_sel    ),
  .idu_iu_ex1_bht_pred         (idu_iu_ex1_bht_pred        ),
  .idu_iu_ex1_bju_br_sel       (idu_iu_ex1_bju_br_sel      ),
  .idu_iu_ex1_bju_dp_sel       (idu_iu_ex1_bju_dp_sel      ),
  .idu_iu_ex1_bju_sel          (idu_iu_ex1_bju_sel         ),
  .idu_iu_ex1_dst_preg         (idu_iu_ex1_dst_preg        ),
  .idu_iu_ex1_func             (idu_iu_ex1_func            ),
  .idu_iu_ex1_inst_len         (idu_iu_ex1_inst_len        ),
  .idu_iu_ex1_inst_vld         (idu_iu_ex1_inst_vld        ),
  .idu_iu_ex1_pipedown_vld     (idu_iu_ex1_pipedown_vld    ),
  .idu_iu_ex1_split            (idu_iu_ex1_split           ),
  .idu_iu_ex1_src0             (idu_iu_ex1_src0            ),
  .idu_iu_ex1_src0_ready       (idu_iu_ex1_src0_ready      ),
  .idu_iu_ex1_src0_reg         (idu_iu_ex1_src0_reg        ),
  .idu_iu_ex1_src1             (idu_iu_ex1_src1            ),
  .idu_iu_ex1_src1_ready       (idu_iu_ex1_src1_ready      ),
  .idu_iu_ex1_src1_reg         (idu_iu_ex1_src1_reg        ),
  .idu_iu_ex1_src2             (idu_iu_ex1_src2            ),
  .ifu_iu_chgflw_pc            (ifu_iu_chgflw_pc           ),
  .ifu_iu_chgflw_vld           (ifu_iu_chgflw_vld          ),
  .ifu_iu_ex1_pc_pred          (ifu_iu_ex1_pc_pred         ),
  .ifu_iu_reset_vld            (ifu_iu_reset_vld           ),
  .ifu_iu_warm_up              (ifu_iu_warm_up             ),
  .iu_cp0_ex1_cur_pc           (iu_cp0_ex1_cur_pc          ),
  .iu_hpcp_inst_bht_mispred    (iu_hpcp_inst_bht_mispred   ),
  .iu_hpcp_inst_condbr         (iu_hpcp_inst_condbr        ),
  .iu_hpcp_jump_8m             (iu_hpcp_jump_8m            ),
  .iu_idu_bju_full             (iu_idu_bju_full            ),
  .iu_idu_bju_global_full      (iu_idu_bju_global_full     ),
  .iu_ifu_bht_cur_pc           (iu_ifu_bht_cur_pc          ),
  .iu_ifu_bht_mispred          (iu_ifu_bht_mispred         ),
  .iu_ifu_bht_mispred_gate     (iu_ifu_bht_mispred_gate    ),
  .iu_ifu_bht_pred             (iu_ifu_bht_pred            ),
  .iu_ifu_bht_taken            (iu_ifu_bht_taken           ),
  .iu_ifu_br_vld               (iu_ifu_br_vld              ),
  .iu_ifu_br_vld_gate          (iu_ifu_br_vld_gate         ),
  .iu_ifu_link_vld             (iu_ifu_link_vld            ),
  .iu_ifu_link_vld_gate        (iu_ifu_link_vld_gate       ),
  .iu_ifu_pc_mispred           (iu_ifu_pc_mispred          ),
  .iu_ifu_pc_mispred_gate      (iu_ifu_pc_mispred_gate     ),
  .iu_ifu_ret_vld              (iu_ifu_ret_vld             ),
  .iu_ifu_ret_vld_gate         (iu_ifu_ret_vld_gate        ),
  .iu_ifu_tar_pc               (iu_ifu_tar_pc              ),
  .iu_ifu_tar_pc_vld           (iu_ifu_tar_pc_vld          ),
  .iu_ifu_tar_pc_vld_gate      (iu_ifu_tar_pc_vld_gate     ),
  .iu_lsu_ex1_cur_pc           (iu_lsu_ex1_cur_pc          ),
  .iu_rtu_depd_lsu_chgflow_vld (iu_rtu_depd_lsu_chgflow_vld),
  .iu_rtu_depd_lsu_next_pc     (iu_rtu_depd_lsu_next_pc    ),
  .iu_rtu_ex1_bju_cmplt        (iu_rtu_ex1_bju_cmplt       ),
  .iu_rtu_ex1_bju_cmplt_dp     (iu_rtu_ex1_bju_cmplt_dp    ),
  .iu_rtu_ex1_bju_data         (iu_rtu_ex1_bju_data        ),
  .iu_rtu_ex1_bju_inst_len     (iu_rtu_ex1_bju_inst_len    ),
  .iu_rtu_ex1_bju_preg         (iu_rtu_ex1_bju_preg        ),
  .iu_rtu_ex1_bju_wb_dp        (iu_rtu_ex1_bju_wb_dp       ),
  .iu_rtu_ex1_bju_wb_vld       (iu_rtu_ex1_bju_wb_vld      ),
  .iu_rtu_ex1_branch_inst      (iu_rtu_ex1_branch_inst     ),
  .iu_rtu_ex1_cur_pc           (iu_rtu_ex1_cur_pc          ),
  .iu_rtu_ex1_next_pc          (iu_rtu_ex1_next_pc         ),
  .iu_rtu_ex2_bju_ras_mispred  (iu_rtu_ex2_bju_ras_mispred ),
  .iu_yy_xx_cancel             (iu_yy_xx_cancel            ),
  .lsu_iu_ex2_data             (lsu_iu_ex2_data            ),
  .lsu_iu_ex2_data_vld         (lsu_iu_ex2_data_vld        ),
  .lsu_iu_ex2_dest_reg         (lsu_iu_ex2_dest_reg        ),
  .mmu_xx_mmu_en               (mmu_xx_mmu_en              ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_iu_ex1_cmplt            (rtu_iu_ex1_cmplt           ),
  .rtu_iu_ex1_cmplt_dp         (rtu_iu_ex1_cmplt_dp        ),
  .rtu_iu_ex1_inst_len         (rtu_iu_ex1_inst_len        ),
  .rtu_iu_ex1_inst_split       (rtu_iu_ex1_inst_split      ),
  .rtu_iu_ex2_cur_pc           (rtu_iu_ex2_cur_pc          ),
  .rtu_iu_ex2_next_pc          (rtu_iu_ex2_next_pc         )
);


// &Instance("aq_iu_addr_gen"); @36
aq_iu_addr_gen  x_aq_iu_addr_gen (
  .ag_bju_pc               (ag_bju_pc              ),
  .bju_ag_cur_pc           (bju_ag_cur_pc          ),
  .bju_ag_offset           (bju_ag_offset          ),
  .bju_ag_offset_sel       (bju_ag_offset_sel      ),
  .bju_ag_use_pc           (bju_ag_use_pc          ),
  .idu_bju_ex1_gateclk_sel (idu_bju_ex1_gateclk_sel),
  .idu_iu_ex1_src0         (idu_iu_ex1_src0        ),
  .idu_iu_ex1_src2         (idu_iu_ex1_src2        ),
  .mmu_xx_mmu_en           (mmu_xx_mmu_en          )
);



assign iu_xx_no_op = !idu_iu_ex1_inst_vld && div_ctrl_no_op && mul_ctrl_no_op && bju_entry_no_vld && bju_ras_not_vld;

// input signal Rename
assign idu_iu_ex1_dst_preg[5:0] = idu_iu_ex1_dst0_reg[5:0];
assign idu_iu_ex1_src0[63:0] = idu_iu_ex1_src0_data[63:0];
assign idu_iu_ex1_src1[63:0] = idu_iu_ex1_src1_data[63:0];
assign idu_iu_ex1_src2[63:0] = idu_iu_ex1_src2_data[63:0];
assign idu_iu_ex1_inst_len = idu_iu_ex1_length;
assign iu_dtu_debug_info[8:0] = {bju_deginfo[3:0], mul_dbginfo[1:0], div_dbginfo[2:0]};


// &ModuleEnd; @50
endmodule


