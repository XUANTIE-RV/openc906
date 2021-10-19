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


// &ModuleBeg; @24
module aq_iu_bju(
  ag_bju_pc,
  bju_ag_cur_pc,
  bju_ag_offset,
  bju_ag_offset_sel,
  bju_ag_use_pc,
  bju_deginfo,
  bju_entry_no_vld,
  bju_ras_not_vld,
  cp0_iu_icg_en,
  cp0_xx_mrvbr,
  cp0_yy_clk_en,
  cpurst_b,
  da_xx_fwd_data,
  da_xx_fwd_dst_reg,
  da_xx_fwd_vld,
  forever_cpuclk,
  hpcp_iu_cnt_en,
  idu_bju_ex1_gateclk_sel,
  idu_iu_ex1_bht_pred,
  idu_iu_ex1_bju_br_sel,
  idu_iu_ex1_bju_dp_sel,
  idu_iu_ex1_bju_sel,
  idu_iu_ex1_dst_preg,
  idu_iu_ex1_func,
  idu_iu_ex1_inst_len,
  idu_iu_ex1_inst_vld,
  idu_iu_ex1_pipedown_vld,
  idu_iu_ex1_split,
  idu_iu_ex1_src0,
  idu_iu_ex1_src0_ready,
  idu_iu_ex1_src0_reg,
  idu_iu_ex1_src1,
  idu_iu_ex1_src1_ready,
  idu_iu_ex1_src1_reg,
  idu_iu_ex1_src2,
  ifu_iu_chgflw_pc,
  ifu_iu_chgflw_vld,
  ifu_iu_ex1_pc_pred,
  ifu_iu_reset_vld,
  ifu_iu_warm_up,
  iu_cp0_ex1_cur_pc,
  iu_hpcp_inst_bht_mispred,
  iu_hpcp_inst_condbr,
  iu_hpcp_jump_8m,
  iu_idu_bju_full,
  iu_idu_bju_global_full,
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
  iu_rtu_ex1_bju_cmplt,
  iu_rtu_ex1_bju_cmplt_dp,
  iu_rtu_ex1_bju_data,
  iu_rtu_ex1_bju_inst_len,
  iu_rtu_ex1_bju_preg,
  iu_rtu_ex1_bju_wb_dp,
  iu_rtu_ex1_bju_wb_vld,
  iu_rtu_ex1_branch_inst,
  iu_rtu_ex1_cur_pc,
  iu_rtu_ex1_next_pc,
  iu_rtu_ex2_bju_ras_mispred,
  iu_yy_xx_cancel,
  lsu_iu_ex2_data,
  lsu_iu_ex2_data_vld,
  lsu_iu_ex2_dest_reg,
  mmu_xx_mmu_en,
  pad_yy_icg_scan_en,
  rtu_iu_ex1_cmplt,
  rtu_iu_ex1_cmplt_dp,
  rtu_iu_ex1_inst_len,
  rtu_iu_ex1_inst_split,
  rtu_iu_ex2_cur_pc,
  rtu_iu_ex2_next_pc
);

// &Ports; @25
input   [63:0]  ag_bju_pc;                   
input           cp0_iu_icg_en;               
input   [39:0]  cp0_xx_mrvbr;                
input           cp0_yy_clk_en;               
input           cpurst_b;                    
input   [63:0]  da_xx_fwd_data;              
input   [5 :0]  da_xx_fwd_dst_reg;           
input           da_xx_fwd_vld;               
input           forever_cpuclk;              
input           hpcp_iu_cnt_en;              
input           idu_bju_ex1_gateclk_sel;     
input   [1 :0]  idu_iu_ex1_bht_pred;         
input           idu_iu_ex1_bju_br_sel;       
input           idu_iu_ex1_bju_dp_sel;       
input           idu_iu_ex1_bju_sel;          
input   [5 :0]  idu_iu_ex1_dst_preg;         
input   [19:0]  idu_iu_ex1_func;             
input           idu_iu_ex1_inst_len;         
input           idu_iu_ex1_inst_vld;         
input           idu_iu_ex1_pipedown_vld;     
input           idu_iu_ex1_split;            
input   [63:0]  idu_iu_ex1_src0;             
input           idu_iu_ex1_src0_ready;       
input   [5 :0]  idu_iu_ex1_src0_reg;         
input   [63:0]  idu_iu_ex1_src1;             
input           idu_iu_ex1_src1_ready;       
input   [5 :0]  idu_iu_ex1_src1_reg;         
input   [63:0]  idu_iu_ex1_src2;             
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
input           rtu_iu_ex1_cmplt;            
input           rtu_iu_ex1_cmplt_dp;         
input           rtu_iu_ex1_inst_len;         
input           rtu_iu_ex1_inst_split;       
input   [39:0]  rtu_iu_ex2_cur_pc;           
input   [39:0]  rtu_iu_ex2_next_pc;          
output  [39:0]  bju_ag_cur_pc;               
output  [63:0]  bju_ag_offset;               
output          bju_ag_offset_sel;           
output          bju_ag_use_pc;               
output  [3 :0]  bju_deginfo;                 
output          bju_entry_no_vld;            
output          bju_ras_not_vld;             
output  [39:0]  iu_cp0_ex1_cur_pc;           
output          iu_hpcp_inst_bht_mispred;    
output          iu_hpcp_inst_condbr;         
output          iu_hpcp_jump_8m;             
output          iu_idu_bju_full;             
output          iu_idu_bju_global_full;      
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
output          iu_rtu_ex1_bju_cmplt;        
output          iu_rtu_ex1_bju_cmplt_dp;     
output  [63:0]  iu_rtu_ex1_bju_data;         
output          iu_rtu_ex1_bju_inst_len;     
output  [5 :0]  iu_rtu_ex1_bju_preg;         
output          iu_rtu_ex1_bju_wb_dp;        
output          iu_rtu_ex1_bju_wb_vld;       
output          iu_rtu_ex1_branch_inst;      
output  [39:0]  iu_rtu_ex1_cur_pc;           
output  [39:0]  iu_rtu_ex1_next_pc;          
output          iu_rtu_ex2_bju_ras_mispred;  
output          iu_yy_xx_cancel;             

// &Regs; @26
reg             bht_mispred;                 
reg     [1 :0]  bju_bht_pred_flop;           
reg     [11:0]  bju_branch_imm_flop;         
reg             bju_entry_src0_vld;          
reg             bju_entry_src1_vld;          
reg             bju_entry_vld;               
reg     [3 :0]  bju_func_flop;               
reg             bju_inst_j;                  
reg             bju_inst_len_flop;           
reg             bju_j_8m;                    
reg     [63:0]  bju_not_pred_pc_flop;        
reg     [38:0]  bju_pcgen_pc_39_1;           
reg             bju_ras_mispred_vld;         
reg     [63:0]  bju_src0_flop;               
reg     [4 :0]  bju_src0_reg_flop;           
reg     [63:0]  bju_src1_flop;               
reg     [4 :0]  bju_src1_reg_flop;           
reg             inst_condbr;                 

// &Wires; @27
wire    [63:0]  ag_bju_pc;                   
wire    [39:0]  bju_ag_cur_pc;               
wire    [63:0]  bju_ag_offset;               
wire            bju_ag_offset_sel;           
wire    [63:0]  bju_ag_tar_pc;               
wire            bju_ag_tar_pc_sel;           
wire            bju_ag_use_pc;               
wire            bju_auipc_sel;               
wire            bju_beq_taken;               
wire    [39:0]  bju_bht_cur_pc;              
wire            bju_bht_mispred;             
wire            bju_bht_mispred_entry;       
wire            bju_bht_mispred_no_entry;    
wire    [1 :0]  bju_bht_pred;                
wire            bju_bht_taken;               
wire            bju_blt_taken;               
wire            bju_br_vld;                  
wire            bju_br_vld_gate;             
wire            bju_clk;                     
wire            bju_clk_en;                  
wire            bju_cond_br_taken;           
wire            bju_cond_br_taken_raw;       
wire            bju_cond_sel;                
wire            bju_cond_sel_ex1;            
wire    [41:0]  bju_cur_pc_ext;              
wire    [3 :0]  bju_deginfo;                 
wire            bju_depend_lsu;              
wire            bju_depend_lsu_cmplt;        
wire            bju_depend_lsu_src0;         
wire            bju_depend_lsu_src0_raw;     
wire            bju_depend_lsu_src1;         
wire            bju_depend_lsu_src1_raw;     
wire            bju_entry_clk;               
wire            bju_entry_clk_en;            
wire            bju_entry_no_vld;            
wire            bju_entry_pop;               
wire            bju_entry_src0_vld_initial;  
wire            bju_entry_src1_vld_initial;  
wire            bju_entry_vld_set;           
wire            bju_ex1_inst_cmplt_no_depend; 
wire            bju_ex1_inst_no_depd;        
wire            bju_ex1_use_pc;              
wire    [19:0]  bju_func;                    
wire    [4 :0]  bju_fwd_src0_reg;            
wire    [4 :0]  bju_fwd_src1_reg;            
wire    [40:0]  bju_hpcp_adder_src0;         
wire    [40:0]  bju_hpcp_adder_src1;         
wire    [39:0]  bju_hpcp_cur_pc;             
wire    [40:0]  bju_hpcp_jump_pc;            
wire    [39:0]  bju_hpcp_next_pc;            
wire    [62:0]  bju_inc_pc_63_1_wb;          
wire    [40:0]  bju_inc_pc_adder0;           
wire    [40:0]  bju_inc_pc_adder1;           
wire    [63:0]  bju_inc_pc_ext;              
wire    [62:0]  bju_inc_pc_ext_63_1;         
wire    [62:0]  bju_inc_pc_ext_63_1_16bit;   
wire    [62:0]  bju_inc_pc_ext_63_1_32bit;   
wire    [63:0]  bju_inc_pc_wb_data;          
wire            bju_inst_cmplt;              
wire            bju_inst_cmplt_dp;           
wire            bju_inst_j_set;              
wire            bju_inst_jalr;               
wire    [40:0]  bju_j_8m_cmp_neg;            
wire    [40:0]  bju_j_8m_cmp_pos;            
wire            bju_j_8m_judge_rst;          
wire            bju_j_8m_neg_judge;          
wire            bju_j_8m_pos_judge;          
wire            bju_j_8m_update;             
wire            bju_link_vld;                
wire            bju_link_vld_raw;            
wire            bju_lsu_wb_fwd_src0_vld;     
wire            bju_lsu_wb_fwd_src1_vld;     
wire    [63:0]  bju_next_pc;                 
wire    [38:0]  bju_next_pc_update;          
wire            bju_not_ex1_chgflw;          
wire    [39:0]  bju_not_ex1_tar_pc;          
wire    [63:0]  bju_not_ex1_tar_pc_raw;      
wire    [63:0]  bju_not_pred_pc;             
wire    [4 :0]  bju_op_func;                 
wire            bju_pc_cmp_fail;             
wire            bju_pc_cmp_gate;             
wire            bju_pc_cmp_set;              
wire            bju_pc_reg_mispred;          
wire    [39:0]  bju_pcgen_pc;                
wire            bju_ras_not_vld;             
wire            bju_ras_pc_mispred_set;      
wire            bju_ret_vld;                 
wire            bju_ret_vld_raw;             
wire    [63:0]  bju_src0;                    
wire            bju_src0_fwd_vld;            
wire            bju_src0_lt_src1;            
wire            bju_src0_lt_src1_signed;     
wire    [63:0]  bju_src0_raw;                
wire    [4 :0]  bju_src0_reg;                
wire    [63:0]  bju_src0_tmp;                
wire    [63:0]  bju_src1;                    
wire            bju_src1_fwd_vld;            
wire    [63:0]  bju_src1_raw;                
wire    [4 :0]  bju_src1_reg;                
wire    [63:0]  bju_src1_tmp;                
wire    [63:0]  bju_src2_raw;                
wire            bju_src_dst_reg_equal;       
wire            bju_tar_pc_vld;              
wire            bju_tar_pc_vld_gate;         
wire            bju_tar_pc_vld_raw;          
wire            bju_uncond_sel;              
wire            cp0_iu_icg_en;               
wire    [39:0]  cp0_xx_mrvbr;                
wire            cp0_yy_clk_en;               
wire            cpurst_b;                    
wire    [63:0]  da_xx_fwd_data;              
wire    [5 :0]  da_xx_fwd_dst_reg;           
wire            da_xx_fwd_vld;               
wire            forever_cpuclk;              
wire            hpcp_iu_cnt_en;              
wire            idu_bju_ex1_gateclk_sel;     
wire    [1 :0]  idu_iu_ex1_bht_pred;         
wire            idu_iu_ex1_bju_br_sel;       
wire            idu_iu_ex1_bju_depd_lsu_src0; 
wire            idu_iu_ex1_bju_depd_lsu_src1; 
wire            idu_iu_ex1_bju_dp_sel;       
wire            idu_iu_ex1_bju_sel;          
wire    [5 :0]  idu_iu_ex1_dst_preg;         
wire    [19:0]  idu_iu_ex1_func;             
wire            idu_iu_ex1_inst_len;         
wire    [63:0]  idu_iu_ex1_src0;             
wire            idu_iu_ex1_src0_ready;       
wire    [5 :0]  idu_iu_ex1_src0_reg;         
wire    [63:0]  idu_iu_ex1_src1;             
wire            idu_iu_ex1_src1_ready;       
wire    [5 :0]  idu_iu_ex1_src1_reg;         
wire    [63:0]  idu_iu_ex1_src2;             
wire    [39:0]  ifu_iu_chgflw_pc;            
wire            ifu_iu_chgflw_vld;           
wire    [39:0]  ifu_iu_ex1_pc_pred;          
wire            ifu_iu_reset_vld;            
wire            ifu_iu_warm_up;              
wire    [39:0]  iu_cp0_ex1_cur_pc;           
wire            iu_hpcp_inst_bht_mispred;    
wire            iu_hpcp_inst_bht_mispred_set; 
wire            iu_hpcp_inst_condbr;         
wire            iu_hpcp_inst_condbr_set;     
wire            iu_hpcp_j_inst_en;           
wire            iu_hpcp_jump_8m;             
wire            iu_idu_bju_full;             
wire            iu_idu_bju_global_full;      
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
wire            iu_rtu_ex1_bju_cmplt;        
wire            iu_rtu_ex1_bju_cmplt_dp;     
wire    [63:0]  iu_rtu_ex1_bju_data;         
wire            iu_rtu_ex1_bju_inst_len;     
wire    [5 :0]  iu_rtu_ex1_bju_preg;         
wire            iu_rtu_ex1_bju_wb_dp;        
wire            iu_rtu_ex1_bju_wb_vld;       
wire            iu_rtu_ex1_branch_inst;      
wire    [39:0]  iu_rtu_ex1_cur_pc;           
wire    [39:0]  iu_rtu_ex1_next_pc;          
wire            iu_rtu_ex2_bju_ras_mispred;  
wire            iu_yy_xx_cancel;             
wire    [63:0]  lsu_iu_ex2_data;             
wire            lsu_iu_ex2_data_vld;         
wire    [4 :0]  lsu_iu_ex2_dest_reg;         
wire            mmu_xx_mmu_en;               
wire            pad_yy_icg_scan_en;          
wire            rtu_iu_ex1_cmplt;            
wire            rtu_iu_ex1_cmplt_dp;         
wire            rtu_iu_ex1_inst_len;         
wire            rtu_iu_ex1_inst_split;       
wire    [39:0]  rtu_iu_ex2_cur_pc;           
wire    [39:0]  rtu_iu_ex2_next_pc;          


// &Force("input", "idu_iu_ex1_split"); @29
// &Force("input", "idu_iu_ex1_pipedown_vld"); @30
// &Force("input", "idu_iu_ex1_inst_vld"); @31
// &Force("bus", "cp0_xx_mrvbr", 39, 0); @32
// &Force("bus", "ifu_iu_chgflw_pc", 39, 0); @33
// &Force("bus", "idu_iu_ex1_src0_reg", 5, 0); @34
// &Force("bus", "idu_iu_ex1_src1_reg", 5, 0); @35
// &Force("bus", "idu_iu_ex1_dst_preg", 5, 0); @36
// &Force("bus", "da_xx_fwd_dst_reg", 5, 0); @37

//==========================================================
//                   Operand  Prepare
//==========================================================
assign bju_func[19:0] = idu_iu_ex1_func[19:0] & {20{idu_iu_ex1_bju_dp_sel}};
assign bju_depend_lsu_src0_raw = idu_iu_ex1_bju_depd_lsu_src0 && bju_func[6]; // func[6] : cond branch inst
assign bju_depend_lsu_src1_raw = idu_iu_ex1_bju_depd_lsu_src1 && bju_func[6];
assign idu_iu_ex1_bju_depd_lsu_src0 = !idu_iu_ex1_src0_ready;
assign idu_iu_ex1_bju_depd_lsu_src1 = !idu_iu_ex1_src1_ready;

// lsu da fwd
assign bju_lsu_wb_fwd_src0_vld = da_xx_fwd_vld && da_xx_fwd_dst_reg[4:0] == bju_fwd_src0_reg[4:0] && bju_depend_lsu_src0_raw;
assign bju_lsu_wb_fwd_src1_vld = da_xx_fwd_vld && da_xx_fwd_dst_reg[4:0] == bju_fwd_src1_reg[4:0] && bju_depend_lsu_src1_raw;

assign bju_depend_lsu_src0 = idu_iu_ex1_bju_depd_lsu_src0 && bju_func[6] && !bju_lsu_wb_fwd_src0_vld;
assign bju_depend_lsu_src1 = idu_iu_ex1_bju_depd_lsu_src1 && bju_func[6] && !bju_lsu_wb_fwd_src1_vld;
// bju_depend lsu : 1. src not ready
//                  2. cond branch inst
//                  3. no lsu da fwd or after fwd still depend
assign bju_depend_lsu      = bju_depend_lsu_src0 || bju_depend_lsu_src1;

// operand mux
assign bju_src0_tmp[63:0] = idu_iu_ex1_src0[63:0] & {64{idu_bju_ex1_gateclk_sel}};
assign bju_src1_tmp[63:0] = idu_iu_ex1_src1[63:0] & {64{idu_bju_ex1_gateclk_sel}};
assign bju_src2_raw[63:0] = idu_iu_ex1_src2[63:0] & {64{idu_bju_ex1_gateclk_sel}};

// if da fwd vld, this cond branch inst not depend lsu
assign bju_src0_raw[63:0] = bju_lsu_wb_fwd_src0_vld ? da_xx_fwd_data[63:0] : bju_src0_tmp[63:0];
assign bju_src1_raw[63:0] = bju_lsu_wb_fwd_src1_vld ? da_xx_fwd_data[63:0] : bju_src1_tmp[63:0];

assign bju_src0_reg[4:0] = idu_iu_ex1_src0_reg[4:0];
assign bju_src1_reg[4:0] = idu_iu_ex1_src1_reg[4:0];

// lsu dc fwd
assign bju_src0_fwd_vld = lsu_iu_ex2_data_vld && lsu_iu_ex2_dest_reg[4:0] == bju_fwd_src0_reg[4:0] &&
                         (bju_depend_lsu_src0 && !bju_entry_vld || !bju_entry_src0_vld && bju_entry_vld);
assign bju_src1_fwd_vld = lsu_iu_ex2_data_vld && lsu_iu_ex2_dest_reg[4:0] == bju_fwd_src1_reg[4:0] &&
                         (bju_depend_lsu_src1 && !bju_entry_vld || !bju_entry_src1_vld && bju_entry_vld);

assign bju_fwd_src0_reg[4:0] = bju_entry_vld ? bju_src0_reg_flop[4:0] : bju_src0_reg[4:0];
assign bju_fwd_src1_reg[4:0] = bju_entry_vld ? bju_src1_reg_flop[4:0] : bju_src1_reg[4:0];

assign bju_ex1_inst_no_depd = !bju_depend_lsu && idu_iu_ex1_bju_dp_sel;
assign bju_entry_vld_set    = bju_depend_lsu;
assign bju_entry_pop        = bju_entry_src0_vld && bju_entry_src1_vld && bju_entry_vld;

// this signal for bju no op
assign bju_entry_no_vld     = !bju_entry_vld;

assign bju_cond_sel_ex1         = bju_func[6];
assign bju_uncond_sel           = bju_func[5];
assign bju_auipc_sel            = bju_func[7];
assign bju_ag_cur_pc[39:0]      = bju_pcgen_pc[39:0];

// entry inst calculate jump tar pc
assign bju_ag_offset[63:0]      = {{51{bju_branch_imm_flop[11]}}, bju_branch_imm_flop[11:0], 1'b0};
assign bju_ag_offset_sel        = bju_entry_vld;

assign iu_idu_bju_full        = bju_entry_vld && bju_entry_src0_vld && bju_entry_src1_vld;
assign iu_idu_bju_global_full = bju_entry_vld && !(bju_entry_src0_vld && bju_entry_src1_vld);

assign bju_depend_lsu_cmplt = !bju_entry_vld && (!bju_depend_lsu_src0 || bju_src0_fwd_vld) &&
                             (!bju_depend_lsu_src1 || bju_src1_fwd_vld) && bju_depend_lsu  && idu_iu_ex1_bju_sel || // ex1 lsu fwd vld, cmplt in ex1
                               bju_entry_vld && !(bju_entry_src0_vld  && bju_entry_src1_vld)   &&
                             (!bju_entry_src0_vld  && bju_src0_fwd_vld  || bju_entry_src0_vld) &&
                             (!bju_entry_src1_vld  && bju_src1_fwd_vld  || bju_entry_src1_vld);  //cmplt in entry


//==========================================================
//                    BJU Inst Entry
//==========================================================
always @ (posedge bju_entry_clk)
begin
  if (bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel || ifu_iu_warm_up) begin
    bju_func_flop[3:0]          <= bju_func[4:1];                // inst func
    bju_bht_pred_flop[1:0]      <= idu_iu_ex1_bht_pred[1:0];     // bht pred
    bju_not_pred_pc_flop[63:0]  <= bju_not_pred_pc[63:0];        // not pred pc: chgflow tar pc
    bju_src0_reg_flop[4:0]      <= bju_src0_reg[4:0];
    bju_src1_reg_flop[4:0]      <= bju_src1_reg[4:0];
    bju_inst_len_flop           <= idu_iu_ex1_inst_len;
    bju_branch_imm_flop[11:0]   <= bju_src2_raw[12:1];           // jump pc offset
  end
end

// if ex1 fwd vld, src_vld set 1
assign bju_entry_src0_vld_initial = !bju_depend_lsu_src0 || bju_src0_fwd_vld;
always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_src0_vld <= 1'b0;
  else if(bju_entry_pop)
    bju_entry_src0_vld <= 1'b0;
  else if(bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel)
    bju_entry_src0_vld <= bju_entry_src0_vld_initial;
  else if(bju_src0_fwd_vld)
    bju_entry_src0_vld <= 1'b1;
end

assign bju_entry_src1_vld_initial = !bju_depend_lsu_src1 || bju_src1_fwd_vld;
always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_src1_vld <= 1'b0;
  else if(bju_entry_pop)
    bju_entry_src1_vld <= 1'b0;
  else if(bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel)
    bju_entry_src1_vld <= bju_entry_src1_vld_initial;
  else if(bju_src1_fwd_vld)
    bju_entry_src1_vld <= 1'b1;
end

always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_vld <= 1'b0;
  else if(bju_entry_vld_set && idu_iu_ex1_bju_sel)
    bju_entry_vld <= 1'b1;
  else if(bju_entry_pop)
    bju_entry_vld <= 1'b0;
end

always @ (posedge bju_entry_clk)
begin
  if (ifu_iu_warm_up || !bju_entry_vld && !bju_depend_lsu_src0 && bju_func[6])
    bju_src0_flop[63:0] <= bju_src0_raw[63:0];
  else if (bju_src0_fwd_vld)
    bju_src0_flop[63:0] <= lsu_iu_ex2_data[63:0];
  else if (bju_pc_cmp_set)   // ras mispred
    bju_src0_flop[63:0] <= bju_ag_tar_pc[63:0];
end

always @ (posedge bju_entry_clk)
begin
  if (ifu_iu_warm_up || !bju_entry_vld && !bju_depend_lsu_src1)
    bju_src1_flop[63:0] <= bju_src1_raw[63:0];
  else if (bju_src1_fwd_vld)
    bju_src1_flop[63:0] <= lsu_iu_ex2_data[63:0];
end


//==========================================================
//               Entry or Non-Entry Select
//==========================================================
assign bju_op_func[4:0]  = bju_entry_vld ? {bju_func_flop[3:0], 1'b0} : bju_func[4:0];
assign bju_bht_pred[1:0] = bju_entry_vld ? bju_bht_pred_flop[1:0]     : idu_iu_ex1_bht_pred[1:0];
assign bju_src0[63:0]    = bju_entry_vld ? bju_src0_flop[63:0]        : bju_src0_raw[63:0];
assign bju_src1[63:0]    = bju_entry_vld ? bju_src1_flop[63:0]        : bju_src1_raw[63:0];


//==========================================================
//                        Inc PC
//==========================================================
// before adder only extend 2 bit
assign bju_cur_pc_ext[41:0] = {{2{mmu_xx_mmu_en & bju_pcgen_pc[39]}}, bju_pcgen_pc[39:0]};
assign bju_inc_pc_ext[63:0] = {bju_inc_pc_ext_63_1[62:0], 1'b0};

// for timing, two adder: 32 bits and 16 bits
assign bju_inc_pc_adder0[40:0] = bju_cur_pc_ext[41:1] + {40'b0, 1'b1};
assign bju_inc_pc_adder1[40:0] = bju_cur_pc_ext[41:1] + {39'b0, 1'b1, 1'b0};

assign bju_inc_pc_ext_63_1_16bit[62:0] = {{22{bju_inc_pc_adder0[40]}}, bju_inc_pc_adder0[40:0]};
assign bju_inc_pc_ext_63_1_32bit[62:0] = {{22{bju_inc_pc_adder1[40]}}, bju_inc_pc_adder1[40:0]};
assign bju_inc_pc_ext_63_1[62:0]       = rtu_iu_ex1_inst_len ? bju_inc_pc_ext_63_1_32bit[62:0] : bju_inc_pc_ext_63_1_16bit[62:0];
assign bju_inc_pc_63_1_wb[62:0]        = idu_iu_ex1_inst_len ? bju_inc_pc_ext_63_1_32bit[62:0] : bju_inc_pc_ext_63_1_16bit[62:0];
assign bju_inc_pc_wb_data[63:0]        = {bju_inc_pc_63_1_wb[62:0], 1'b0};


//==========================================================
//                        AUIPC
//==========================================================
assign bju_ex1_use_pc      = bju_func[8];
assign bju_ag_use_pc       = bju_ex1_use_pc || bju_entry_vld;


//==========================================================
//              Un-condition Branch & Jump
//==========================================================
assign bju_inst_jalr       = bju_uncond_sel & bju_func[1];
assign bju_ag_tar_pc[63:0] = ag_bju_pc[63:0];


//==========================================================
//                  Condition Branch
//==========================================================
assign bju_cond_sel     = bju_cond_sel_ex1 || bju_entry_vld;
assign bju_beq_taken    = bju_src0[63:0] == bju_src1[63:0];
assign bju_src0_lt_src1 = bju_src0[63:0] < bju_src1[63:0];
assign bju_src0_lt_src1_signed =  bju_src0[63] &&  bju_src1[63] && bju_src0_lt_src1
                               || bju_src0[63] && !bju_src1[63]
                               ||!bju_src0[63] && !bju_src1[63] && bju_src0_lt_src1;
assign bju_blt_taken           = bju_op_func[4] ? bju_src0_lt_src1_signed
                                                : bju_src0_lt_src1;
assign bju_cond_br_taken_raw = (bju_beq_taken  ^ bju_op_func[3]) & bju_op_func[2]     // beq and bne taken
                             | (bju_blt_taken  ^ bju_op_func[3]) & bju_op_func[1];    // blt/bltu and bge/bgeu taken

// When judge the real jump result, choose bju_cond_br_taken_raw
assign bju_cond_br_taken     = bju_ex1_inst_no_depd || bju_entry_pop ? bju_cond_br_taken_raw
                                                                     : bju_bht_pred[1];


//==========================================================
//                     Next PC
//==========================================================
assign bju_ag_tar_pc_sel = bju_cond_br_taken && (bju_cond_sel_ex1  || bju_entry_vld) && !bju_entry_pop
                        || bju_uncond_sel;
assign bju_next_pc[63:0] = bju_ag_tar_pc_sel ? bju_ag_tar_pc[63:0]
                                             : bju_inc_pc_ext[63:0];


//==========================================================
//               Branch & Jump Inst target PC
//==========================================================
// BHT predict result is in pred[1].
//   0-untaken, 1-taken.
assign bju_not_pred_pc[63:0] = bju_bht_pred[1] ? bju_inc_pc_ext[63:0]
                                               : bju_ag_tar_pc[63:0];

// BHT Predict Judge
assign bju_bht_mispred_no_entry  = bju_cond_sel && (bju_cond_br_taken ^ bju_bht_pred[1]) && bju_ex1_inst_no_depd; // ex1 inst
assign bju_bht_mispred_entry     = bju_cond_sel && (bju_cond_br_taken ^ bju_bht_pred[1]) && bju_entry_pop;        // entry inst
assign bju_br_vld      = bju_entry_vld ? bju_entry_pop : bju_cond_sel_ex1 && bju_ex1_inst_no_depd && idu_iu_ex1_bju_br_sel;
assign bju_br_vld_gate = bju_cond_sel_ex1 && bju_ex1_inst_no_depd && !bju_entry_vld || bju_entry_pop;
assign bju_bht_taken   = bju_cond_br_taken;

// PC Mispred
// bju_pc_cmp_fail will set ex2 chgflw because of timing.
// for inst like jalr x1, x1 , should force chgflow
assign bju_pc_cmp_gate     = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1;
assign bju_pc_cmp_set      = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1 && idu_iu_ex1_bju_sel;
assign bju_pc_cmp_fail     = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1 && (bju_src_dst_reg_equal || bju_ag_tar_pc[39:0] != ifu_iu_ex1_pc_pred[39:0]); // ras pc wrong
assign bju_pc_reg_mispred  = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] != 5'b1; // ras reg wrong

assign bju_bht_mispred     = bju_bht_mispred_no_entry && idu_iu_ex1_bju_sel || bju_bht_mispred_entry;
assign bju_tar_pc_vld_raw  = bju_entry_vld ? bju_bht_mispred_entry : (bju_bht_mispred_no_entry || bju_pc_reg_mispred) && idu_iu_ex1_bju_br_sel;
assign bju_tar_pc_vld      = bju_tar_pc_vld_raw || bju_ras_mispred_vld;
assign bju_tar_pc_vld_gate = bju_bht_mispred_no_entry || bju_pc_reg_mispred || bju_bht_mispred_entry || bju_ras_mispred_vld;

assign bju_src_dst_reg_equal = (idu_iu_ex1_src0_reg[4:0] == idu_iu_ex1_dst_preg[4:0]) && bju_func[11];
assign bju_ret_vld_raw       = idu_iu_ex1_src0_reg[4:0] == 5'b1 && bju_inst_jalr && bju_ex1_inst_no_depd && !bju_src_dst_reg_equal;
assign bju_ret_vld           = bju_ret_vld_raw && idu_iu_ex1_bju_sel;
assign bju_link_vld_raw      = idu_iu_ex1_dst_preg[4:0] == 5'b1 && bju_uncond_sel && bju_ex1_inst_no_depd && bju_func[11];
assign bju_link_vld          = bju_link_vld_raw && idu_iu_ex1_bju_sel;

assign bju_inst_cmplt         = idu_iu_ex1_bju_sel && !bju_depend_lsu || bju_depend_lsu_cmplt;
assign bju_inst_cmplt_dp      = idu_iu_ex1_bju_dp_sel || bju_entry_vld && !(bju_entry_src0_vld && bju_entry_src1_vld);

assign bju_ras_pc_mispred_set = bju_pc_cmp_fail && idu_iu_ex1_bju_sel;
assign bju_ras_not_vld        = !bju_ras_mispred_vld;
assign bju_ex1_inst_cmplt_no_depend = idu_iu_ex1_bju_sel && !bju_depend_lsu;

always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bju_ras_mispred_vld <= 1'b0;
  else if (bju_ras_pc_mispred_set)
    bju_ras_mispred_vld <= 1'b1;
  else
    bju_ras_mispred_vld <= 1'b0;
end


//==========================================================
//                     PC Generator
//==========================================================
// PC update:
// 1. reset
// 2. ifu chgflow
// 3. bju entry chgflow(depend lsu branch and ras pc mispred)
// 4. inst cmplt pc(inc pc and ex1 chgflow pc)
always @ (posedge bju_clk)
begin
  if (ifu_iu_reset_vld)
    bju_pcgen_pc_39_1[38:0] <= cp0_xx_mrvbr[39:1];
  else if (ifu_iu_chgflw_vld)
    bju_pcgen_pc_39_1[38:0] <= ifu_iu_chgflw_pc[39:1];
  else if (bju_not_ex1_chgflw)
    bju_pcgen_pc_39_1[38:0] <= bju_not_ex1_tar_pc[39:1];
  else if (rtu_iu_ex1_cmplt && !rtu_iu_ex1_inst_split)
    bju_pcgen_pc_39_1[38:0] <= bju_next_pc_update[38:0];
end

assign bju_next_pc_update[38:0] = bju_next_pc[39:1];
assign bju_pcgen_pc[39:0]       = {bju_pcgen_pc_39_1[38:0], 1'b0};
assign bju_bht_cur_pc[39:0]     = bju_entry_vld ? rtu_iu_ex2_cur_pc[39:0]
                                                : bju_pcgen_pc[39:0];

assign bju_not_ex1_chgflw           = bju_ras_mispred_vld || bju_bht_mispred_entry;
assign bju_not_ex1_tar_pc_raw[63:0] = bju_ras_mispred_vld ? bju_src0_flop[63:0] : bju_not_pred_pc_flop[63:0];
assign bju_not_ex1_tar_pc[39:0]     = bju_not_ex1_tar_pc_raw[39:0];


//==========================================================
//                  BJU gateclk
//==========================================================
// bju_clk include:
//   1. bju_pcgen;
//   2. bju PMU counter;
//   3. tar_pc_vld_mask.

assign bju_clk_en = ifu_iu_chgflw_vld
                 || rtu_iu_ex1_cmplt_dp
                 || ifu_iu_warm_up
                 || ifu_iu_reset_vld
                 || inst_condbr
                 || bju_ras_mispred_vld
                 || bju_entry_pop
                 || bht_mispred
                 || bju_j_8m_update;

// &Instance("gated_clk_cell", "x_bju_clk"); @347
gated_clk_cell  x_bju_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bju_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bju_clk_en        ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @348
//          .external_en (1'b0), @349
//          .global_en   (cp0_yy_clk_en), @350
//          .module_en   (cp0_iu_icg_en), @351
//          .local_en    (bju_clk_en), @352
//          .clk_out     (bju_clk)); @353

assign bju_entry_clk_en = bju_depend_lsu && idu_bju_ex1_gateclk_sel
                     || ifu_iu_warm_up
                     || bju_entry_vld
                     || bju_pc_cmp_gate
                     || bju_ras_mispred_vld;

// &Instance("gated_clk_cell", "x_bju_entry_clk"); @361
gated_clk_cell  x_bju_entry_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bju_entry_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bju_entry_clk_en  ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @362
//          .external_en (1'b0), @363
//          .global_en   (cp0_yy_clk_en), @364
//          .module_en   (cp0_iu_icg_en), @365
//          .local_en    (bju_entry_clk_en), @366
//          .clk_out     (bju_entry_clk)); @367


//==========================================================
//                      OUTPUT SIGNAL
//==========================================================
//----------------------------------------------------------
//                        IFU SIGNAL
//----------------------------------------------------------
assign iu_ifu_tar_pc_vld      = bju_tar_pc_vld;
assign iu_ifu_tar_pc_vld_gate = bju_tar_pc_vld_gate;
assign iu_ifu_tar_pc[63:0] = bju_entry_vld ? bju_not_pred_pc_flop[63:0]
                                           : bju_ras_mispred_vld ? bju_src0_flop[63:0]
                                                                 : bju_next_pc[63:0];
// &Force("output", "iu_ifu_tar_pc_vld"); @381
assign iu_yy_xx_cancel     = iu_ifu_tar_pc_vld;
// BHT Singal
assign iu_ifu_br_vld           = bju_br_vld;
assign iu_ifu_br_vld_gate      = bju_br_vld_gate;
assign iu_ifu_bht_cur_pc[39:0] = bju_bht_cur_pc[39:0];
assign iu_ifu_bht_taken        = bju_bht_taken;
assign iu_ifu_bht_pred[1:0]    = bju_bht_pred[1:0];
assign iu_ifu_bht_mispred      = bju_bht_mispred;
assign iu_ifu_bht_mispred_gate = bju_bht_mispred_no_entry || bju_bht_mispred_entry;

// RAS Singal
assign iu_ifu_ret_vld       = bju_ret_vld;
assign iu_ifu_link_vld      = bju_link_vld;
assign iu_ifu_ret_vld_gate  = bju_ret_vld_raw;
assign iu_ifu_link_vld_gate = bju_link_vld_raw;
assign iu_ifu_pc_mispred    = bju_pc_reg_mispred && idu_iu_ex1_bju_sel;
assign iu_ifu_pc_mispred_gate = bju_pc_reg_mispred;

//----------------------------------------------------------
//                        RTU SIGNAL
//----------------------------------------------------------
assign iu_rtu_ex1_bju_cmplt       = bju_inst_cmplt;
assign iu_rtu_ex1_bju_cmplt_dp    = bju_inst_cmplt_dp;
assign iu_rtu_ex1_bju_inst_len    = bju_entry_vld ? bju_inst_len_flop : idu_iu_ex1_inst_len;
assign iu_rtu_ex1_bju_wb_vld      = (bju_uncond_sel || bju_auipc_sel) && idu_iu_ex1_bju_sel && bju_func[11];
assign iu_rtu_ex1_bju_wb_dp       = (bju_uncond_sel || bju_auipc_sel) && idu_iu_ex1_bju_dp_sel && bju_func[11];
assign iu_rtu_ex1_bju_data[63:0]     = bju_uncond_sel ? bju_inc_pc_wb_data[63:0] : ag_bju_pc[63:0];
assign iu_rtu_ex1_next_pc[39:0]      = {bju_next_pc_update[38:0], 1'b0};
assign iu_rtu_ex1_cur_pc[39:0]       = bju_pcgen_pc[39:0];
assign iu_rtu_ex1_branch_inst        = |bju_func[6:5] && idu_iu_ex1_bju_dp_sel || bju_entry_vld;
assign iu_rtu_ex1_bju_preg[5:0]      = {1'b0, idu_iu_ex1_dst_preg[4:0]};
assign iu_rtu_depd_lsu_chgflow_vld   = bju_bht_mispred_entry;
assign iu_rtu_depd_lsu_next_pc[39:0] = bju_not_pred_pc_flop[39:0];
assign iu_rtu_ex2_bju_ras_mispred    = bju_ras_mispred_vld;

// pctrace signals
//assign iu_rtu_ex1_condbr  = bju_cond_sel_ex1 && idu_iu_ex1_bju_sel || bju_entry_vld;
//assign iu_rtu_ex1_jmp     = bju_inst_jalr && idu_iu_ex1_bju_sel;
//assign iu_rtu_ex1_pcall   = bju_link_vld;
//assign iu_rtu_ex1_preturn = bju_ret_vld;
//assign iu_rtu_ex1_taken   = bju_cond_br_taken;

//----------------------------------------------------------
//                        CP0 SIGNAL
//----------------------------------------------------------
assign iu_cp0_ex1_cur_pc[39:0] = bju_pcgen_pc[39:0];

//----------------------------------------------------------
//                        LSU SIGNAL
//----------------------------------------------------------
assign iu_lsu_ex1_cur_pc[15:0] = bju_pcgen_pc[15:0];


//==========================================================
//                       HPCP Signal
//==========================================================
assign iu_hpcp_inst_condbr_set      = (bju_cond_sel_ex1 && bju_ex1_inst_cmplt_no_depend || bju_depend_lsu_cmplt) && hpcp_iu_cnt_en;
assign iu_hpcp_inst_bht_mispred_set = bju_bht_mispred  && hpcp_iu_cnt_en;
always @ (posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_condbr <= 1'b0;
  else if(iu_hpcp_inst_condbr_set)
    inst_condbr <= 1'b1;
  else
    inst_condbr <= 1'b0;
end

always @ (posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_mispred <= 1'b0;
  else if(iu_hpcp_inst_bht_mispred_set)
    bht_mispred <= 1'b1;
  else
    bht_mispred <= 1'b0;
end

assign iu_hpcp_inst_condbr      = inst_condbr;
assign iu_hpcp_inst_bht_mispred = bht_mispred;
assign bju_deginfo[3:0] = {bju_entry_vld, bju_entry_src0_vld, bju_entry_src1_vld, bju_ras_mispred_vld};

assign bju_hpcp_cur_pc[39:0]  = rtu_iu_ex2_cur_pc[39:0];
assign bju_hpcp_next_pc[39:0] = rtu_iu_ex2_next_pc[39:0];
assign bju_hpcp_adder_src0[40:0] = {mmu_xx_mmu_en && bju_hpcp_next_pc[39], bju_hpcp_next_pc[39:0]} & {41{bju_inst_j}};
assign bju_hpcp_adder_src1[40:0] = {mmu_xx_mmu_en && bju_hpcp_cur_pc[39],  bju_hpcp_cur_pc[39:0]}  & {41{bju_inst_j}};
assign bju_hpcp_jump_pc[40:0]    = bju_hpcp_adder_src0[40:0] - bju_hpcp_adder_src1[40:0];

assign iu_hpcp_j_inst_en = hpcp_iu_cnt_en && (bju_uncond_sel || bju_inst_j);
assign bju_inst_j_set    = bju_uncond_sel && idu_iu_ex1_bju_sel && !bju_ret_vld_raw;

assign bju_j_8m_cmp_pos[40:0] = 41'h7fffff;
assign bju_j_8m_cmp_neg[40:0] = 41'h1ffff800001;
assign bju_j_8m_pos_judge = bju_hpcp_jump_pc[40:0] > bju_j_8m_cmp_pos[40:0];
assign bju_j_8m_neg_judge = bju_hpcp_jump_pc[40:0] < bju_j_8m_cmp_neg[40:0];
assign bju_j_8m_judge_rst = bju_hpcp_jump_pc[40] ? bju_j_8m_neg_judge : bju_j_8m_pos_judge;

always @(posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_inst_j <= 1'b0;
  else if(iu_hpcp_j_inst_en)
    bju_inst_j <= bju_inst_j_set;
end

assign bju_j_8m_update = hpcp_iu_cnt_en && (bju_j_8m_judge_rst || bju_j_8m);
always @(posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_j_8m <= 1'b0;
  else if(bju_j_8m_update)
    bju_j_8m <= bju_j_8m_judge_rst;
end
assign iu_hpcp_jump_8m = bju_j_8m;







// &ModuleEnd; @521
endmodule


