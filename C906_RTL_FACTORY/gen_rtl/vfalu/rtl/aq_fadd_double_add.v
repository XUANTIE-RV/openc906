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

// &ModuleBeg; @26
module aq_fadd_double_add(
  add_cmp_act_s,
  add_cmp_both_zero,
  add_cmp_ex2_src0_eq_src1,
  double_pipe_ex1_src0_id,
  double_pipe_ex1_src1_id,
  double_pipe_ex2_special_result,
  double_pipe_ex3_expt,
  dp_maxmin_src_a_e,
  dp_maxmin_src_a_f,
  dp_maxmin_src_a_s,
  dp_maxmin_src_b_e,
  dp_maxmin_src_b_f,
  dp_maxmin_src_b_s,
  dp_maxmin_src_chg,
  ex1_bhalf,
  ex1_bhalf0_adder_a_final,
  ex1_bhalf0_special_data,
  ex1_double,
  ex1_double_adder_a_final,
  ex1_double_special_data,
  ex1_f16,
  ex1_half,
  ex1_half0_adder_a_final,
  ex1_half0_special_data,
  ex1_op_add,
  ex1_op_add_sub,
  ex1_op_cmp,
  ex1_op_sel,
  ex1_op_sub,
  ex1_rdn,
  ex1_single,
  ex1_single0_adder_a_final,
  ex1_single0_special_data,
  ex1_src0_0,
  ex1_src1_0,
  ex2_act_s,
  ex2_act_sub,
  ex2_bhalf,
  ex2_bhalf0_addsub_rslt,
  ex2_both_zero,
  ex2_double,
  ex2_double_adder_a,
  ex2_double_addsub_rslt,
  ex2_e_add_rslt,
  ex2_half,
  ex2_half0_addsub_rslt,
  ex2_nocmp_nosel,
  ex2_op_sel,
  ex2_rdn,
  ex2_rmm,
  ex2_rne,
  ex2_rtz,
  ex2_rup,
  ex2_single,
  ex2_single0_addsub_rslt,
  ex2_special_value_vld,
  ex3_act_s,
  ex3_bhalf,
  ex3_bhalf0_result,
  ex3_double,
  ex3_double_result,
  ex3_expt_mask,
  ex3_half,
  ex3_half0_result,
  ex3_nv,
  ex3_op_cmp,
  ex3_op_sel,
  ex3_org_e,
  ex3_rdn,
  ex3_rtz,
  ex3_rup,
  ex3_single,
  ex3_single0_result,
  ex3_special_n_op_sel,
  fadd_double_src0,
  fadd_double_src1,
  fadd_ex1_pipe_clk,
  fadd_ex1_pipedown,
  fadd_ex2_nocmp_pipe_clk,
  fadd_ex2_nocmp_pipedown,
  fadd_ex3_bhalf0_rslt,
  fadd_ex3_double_rslt,
  fadd_ex3_half0_rslt,
  fadd_ex3_single0_rslt,
  fadd_half0_src0,
  fadd_half0_src1,
  fadd_single0_src0,
  fadd_single0_src1,
  ifu_vpu_warm_up
);

// &Ports; @27
input            double_pipe_ex1_src0_id;       
input            double_pipe_ex1_src1_id;       
input   [63 :0]  double_pipe_ex2_special_result; 
input            ex1_bhalf;                     
input            ex1_double;                    
input            ex1_f16;                       
input            ex1_half;                      
input            ex1_op_add;                    
input            ex1_op_add_sub;                
input            ex1_op_cmp;                    
input            ex1_op_sel;                    
input            ex1_op_sub;                    
input            ex1_rdn;                       
input            ex1_single;                    
input            ex1_src0_0;                    
input            ex1_src1_0;                    
input            ex2_bhalf;                     
input            ex2_both_zero;                 
input            ex2_double;                    
input   [53 :0]  ex2_double_adder_a;            
input            ex2_half;                      
input            ex2_nocmp_nosel;               
input            ex2_op_sel;                    
input            ex2_rdn;                       
input            ex2_rmm;                       
input            ex2_rne;                       
input            ex2_rtz;                       
input            ex2_rup;                       
input            ex2_single;                    
input            ex2_special_value_vld;         
input            ex3_act_s;                     
input            ex3_bhalf;                     
input   [8  :0]  ex3_bhalf0_result;             
input            ex3_double;                    
input   [53 :0]  ex3_double_result;             
input            ex3_expt_mask;                 
input            ex3_half;                      
input   [11 :0]  ex3_half0_result;              
input            ex3_nv;                        
input            ex3_op_cmp;                    
input            ex3_op_sel;                    
input   [10 :0]  ex3_org_e;                     
input            ex3_rdn;                       
input            ex3_rtz;                       
input            ex3_rup;                       
input            ex3_single;                    
input   [24 :0]  ex3_single0_result;            
input            ex3_special_n_op_sel;          
input   [63 :0]  fadd_double_src0;              
input   [63 :0]  fadd_double_src1;              
input            fadd_ex1_pipe_clk;             
input            fadd_ex1_pipedown;             
input            fadd_ex2_nocmp_pipe_clk;       
input            fadd_ex2_nocmp_pipedown;       
input   [15 :0]  fadd_half0_src0;               
input   [15 :0]  fadd_half0_src1;               
input   [31 :0]  fadd_single0_src0;             
input   [31 :0]  fadd_single0_src1;             
input            ifu_vpu_warm_up;               
output           add_cmp_act_s;                 
output           add_cmp_both_zero;             
output           add_cmp_ex2_src0_eq_src1;      
output  [4  :0]  double_pipe_ex3_expt;          
output  [10 :0]  dp_maxmin_src_a_e;             
output  [51 :0]  dp_maxmin_src_a_f;             
output           dp_maxmin_src_a_s;             
output  [10 :0]  dp_maxmin_src_b_e;             
output  [52 :0]  dp_maxmin_src_b_f;             
output           dp_maxmin_src_b_s;             
output           dp_maxmin_src_chg;             
output  [8  :0]  ex1_bhalf0_adder_a_final;      
output  [15 :0]  ex1_bhalf0_special_data;       
output  [53 :0]  ex1_double_adder_a_final;      
output  [63 :0]  ex1_double_special_data;       
output  [11 :0]  ex1_half0_adder_a_final;       
output  [15 :0]  ex1_half0_special_data;        
output  [24 :0]  ex1_single0_adder_a_final;     
output  [31 :0]  ex1_single0_special_data;      
output           ex2_act_s;                     
output           ex2_act_sub;                   
output  [8  :0]  ex2_bhalf0_addsub_rslt;        
output  [53 :0]  ex2_double_addsub_rslt;        
output  [10 :0]  ex2_e_add_rslt;                
output  [11 :0]  ex2_half0_addsub_rslt;         
output  [24 :0]  ex2_single0_addsub_rslt;       
output  [63 :0]  fadd_ex3_bhalf0_rslt;          
output  [63 :0]  fadd_ex3_double_rslt;          
output  [63 :0]  fadd_ex3_half0_rslt;           
output  [63 :0]  fadd_ex3_single0_rslt;         

// &Regs; @28
reg     [7  :0]  ex1_e_onehot;                  
reg              ex2_act_s_raw;                 
reg              ex2_act_sub;                   
reg              ex2_add_bypass;                
reg              ex2_add_bypass_s;              
reg     [84 :0]  ex2_adder_b;                   
reg              ex2_both_dn;                   
reg              ex2_double_ed;                 
reg              ex2_e_diff_0;                  
reg              ex2_e_diff_1;                  
reg     [2  :0]  ex2_e_mask_h;                  
reg     [7  :0]  ex2_e_onehot_pre;              
reg     [63 :0]  ex2_e_onehot_raw;              
reg              ex2_r_0_sign;                  
reg              ex2_shift_no_limit;            
reg              ex2_src0_0;                    
reg     [10 :0]  ex2_src0_e;                    
reg              ex2_src0_f_position;           
reg              ex2_src0_s;                    
reg              ex2_src1_0;                    
reg              ex2_src1_s;                    
reg              ex2_src_chg;                   
reg              ex2_src_equal;                 
reg              ex3_act_sub;                   
reg              ex3_both_dn;                   
reg              ex3_both_zero;                 
reg     [5  :0]  ex3_e_adjust;                  
reg              ex3_nx;                        
reg              ex3_r_0_sign;                  
reg              ex3_rst_shift;                 
reg              ex3_src_equal;                 
reg     [63 :0]  fadd_ex3_bhalf0_rslt;          
reg     [63 :0]  fadd_ex3_double_rslt;          
reg     [63 :0]  fadd_ex3_half0_rslt;           
reg     [63 :0]  fadd_ex3_single0_rslt;         

// &Wires; @29
wire             add_cin;                       
wire             add_cmp_act_s;                 
wire             add_cmp_both_zero;             
wire             add_cmp_ex2_src0_eq_src1;      
wire    [53 :0]  double_pipe_adder1_op2;        
wire    [53 :0]  double_pipe_adder2_op2;        
wire             double_pipe_ex1_src0_id;       
wire             double_pipe_ex1_src1_id;       
wire             double_pipe_ex2_act_add;       
wire    [63 :0]  double_pipe_ex2_special_result; 
wire    [4  :0]  double_pipe_ex3_expt;          
wire    [51 :0]  double_src0_raw;               
wire    [51 :0]  double_src1_raw;               
wire    [10 :0]  dp_maxmin_src_a_e;             
wire    [51 :0]  dp_maxmin_src_a_f;             
wire             dp_maxmin_src_a_s;             
wire    [10 :0]  dp_maxmin_src_b_e;             
wire    [52 :0]  dp_maxmin_src_b_f;             
wire             dp_maxmin_src_b_s;             
wire             dp_maxmin_src_chg;             
wire    [52 :0]  dp_src_a_f_orig;               
wire    [11 :0]  e_diff;                        
wire    [11 :0]  e_diff_contrary;               
wire    [10 :0]  ea;                            
wire    [10 :0]  eb;                            
wire             ex1_act_s;                     
wire             ex1_act_sub;                   
wire             ex1_add_bypass;                
wire             ex1_add_bypass_s;              
wire    [84 :0]  ex1_align_shift_result;        
wire             ex1_bhalf;                     
wire    [8  :0]  ex1_bhalf0_adder_a_final;      
wire    [7  :0]  ex1_bhalf0_fa_for_shift;       
wire    [7  :0]  ex1_bhalf0_fb_for_shift;       
wire    [7  :0]  ex1_bhalf0_shift_pre;          
wire    [15 :0]  ex1_bhalf0_special_data;       
wire             ex1_bhalf0_src0_norm;          
wire             ex1_bhalf0_src1_norm;          
wire    [15 :0]  ex1_bhalf0_src1_sel_raw;       
wire             ex1_both_dn;                   
wire             ex1_cmp_sel;                   
wire             ex1_cmp_sub;                   
wire             ex1_double;                    
wire    [53 :0]  ex1_double_adder_a_final;      
wire    [10 :0]  ex1_double_ea;                 
wire    [10 :0]  ex1_double_eb;                 
wire    [52 :0]  ex1_double_fa;                 
wire    [52 :0]  ex1_double_fa_for_shift;       
wire    [52 :0]  ex1_double_fb;                 
wire    [52 :0]  ex1_double_fb_for_shift;       
wire    [52 :0]  ex1_double_shift_pre;          
wire    [63 :0]  ex1_double_special_data;       
wire             ex1_double_src0_norm;          
wire             ex1_double_src1_norm;          
wire    [63 :0]  ex1_double_src1_sel_raw;       
wire    [10 :0]  ex1_e_big;                     
wire    [11 :0]  ex1_e_big_diff;                
wire             ex1_e_big_s;                   
wire    [10 :0]  ex1_e_big_t;                   
wire             ex1_e_diff_0;                  
wire             ex1_e_diff_1;                  
wire    [10 :0]  ex1_e_ed;                      
wire             ex1_es;                        
wire             ex1_f16;                       
wire             ex1_f_e_equal;                 
wire    [52 :0]  ex1_for_adder_a;               
wire    [52 :0]  ex1_for_adder_a_final;         
wire    [52 :0]  ex1_for_adder_a_nor;           
wire    [52 :0]  ex1_for_align_shift;           
wire             ex1_half;                      
wire    [11 :0]  ex1_half0_adder_a_final;       
wire    [10 :0]  ex1_half0_fa_for_shift;        
wire    [10 :0]  ex1_half0_fb_for_shift;        
wire    [10 :0]  ex1_half0_shift_pre;           
wire    [15 :0]  ex1_half0_special_data;        
wire             ex1_half0_src0_norm;           
wire             ex1_half0_src1_norm;           
wire    [15 :0]  ex1_half0_src1_sel_raw;        
wire             ex1_op_add;                    
wire             ex1_op_add_sub;                
wire             ex1_op_cmp;                    
wire             ex1_op_sel;                    
wire             ex1_op_sub;                    
wire             ex1_r_0_sign;                  
wire             ex1_rdn;                       
wire             ex1_shift_no_limit;            
wire             ex1_single;                    
wire    [24 :0]  ex1_single0_adder_a_final;     
wire    [23 :0]  ex1_single0_fa;                
wire    [23 :0]  ex1_single0_fa_for_shift;      
wire    [23 :0]  ex1_single0_fb;                
wire    [23 :0]  ex1_single0_fb_for_shift;      
wire    [23 :0]  ex1_single0_shift_pre;         
wire    [31 :0]  ex1_single0_special_data;      
wire             ex1_single0_src0_norm;         
wire             ex1_single0_src1_norm;         
wire    [31 :0]  ex1_single0_src1_sel_raw;      
wire    [10 :0]  ex1_single_ea;                 
wire    [10 :0]  ex1_single_eb;                 
wire             ex1_src0_0;                    
wire             ex1_src0_dn_0;                 
wire    [10 :0]  ex1_src0_e;                    
wire    [10 :0]  ex1_src0_e_raw;                
wire             ex1_src0_equal_src1;           
wire             ex1_src0_f_raw;                
wire    [52 :0]  ex1_src0_for_eq;               
wire    [52 :0]  ex1_src0_for_shift;            
wire             ex1_src0_id;                   
wire    [51 :0]  ex1_src0_raw;                  
wire             ex1_src0_s;                    
wire             ex1_src0_s_raw;                
wire             ex1_src1_0;                    
wire             ex1_src1_dn_0;                 
wire    [10 :0]  ex1_src1_e;                    
wire    [10 :0]  ex1_src1_e_raw;                
wire    [51 :0]  ex1_src1_f_raw;                
wire    [52 :0]  ex1_src1_for_eq;               
wire    [52 :0]  ex1_src1_for_shift;            
wire             ex1_src1_id;                   
wire    [51 :0]  ex1_src1_raw;                  
wire             ex1_src1_s;                    
wire             ex1_src1_s_raw;                
wire             ex2_act_add;                   
wire             ex2_act_s;                     
wire             ex2_act_s_tmp;                 
wire    [116:0]  ex2_adder_b_double;            
wire    [54 :0]  ex2_adder_b_tail;              
wire    [53 :0]  ex2_adder_src1;                
wire    [53 :0]  ex2_adder_sub_r;               
wire             ex2_bhalf;                     
wire    [11 :0]  ex2_bhalf0_add_r;              
wire    [8  :0]  ex2_bhalf0_addsub_rslt;        
wire    [8  :0]  ex2_bhalf0_lop_src0;           
wire    [8  :0]  ex2_bhalf0_lop_src1;           
wire    [10 :0]  ex2_bhalf0_src1_e;             
wire    [8  :0]  ex2_bhalf0_sub000xx_rslt;      
wire    [11 :0]  ex2_bhalf0_sub_r;              
wire             ex2_both_dn_n_widden;          
wire             ex2_both_dn_no_widden;         
wire             ex2_both_dn_widden_add;        
wire             ex2_both_zero;                 
wire             ex2_dest_widden;               
wire             ex2_double;                    
wire    [56 :0]  ex2_double_add_inc1_r;         
wire    [56 :0]  ex2_double_add_inc2_r;         
wire    [10 :0]  ex2_double_add_op1;            
wire    [10 :0]  ex2_double_add_op2;            
wire    [56 :0]  ex2_double_add_r;              
wire    [53 :0]  ex2_double_adder_a;            
wire    [53 :0]  ex2_double_addsub_rslt;        
wire    [53 :0]  ex2_double_b_sub_a_r;          
wire    [10 :0]  ex2_double_e_add_rslt;         
wire    [5  :0]  ex2_double_e_adjust;           
wire    [53 :0]  ex2_double_lop_src0;           
wire    [53 :0]  ex2_double_lop_src1;           
wire    [53 :0]  ex2_double_pipe_add1_rslt;     
wire    [53 :0]  ex2_double_pipe_add2_rslt;     
wire    [10 :0]  ex2_double_src1_e;             
wire    [53 :0]  ex2_double_sub000xx_rslt;      
wire    [56 :0]  ex2_double_sub_inc1_r;         
wire    [56 :0]  ex2_double_sub_inc2_r;         
wire    [56 :0]  ex2_double_sub_r;              
wire    [10 :0]  ex2_e_add_op1;                 
wire    [10 :0]  ex2_e_add_op2;                 
wire    [10 :0]  ex2_e_add_rslt;                
wire    [5  :0]  ex2_e_adjust_pre;              
wire    [63 :0]  ex2_e_onehot;                  
wire    [53 :0]  ex2_e_onehot_mask;             
wire    [2  :0]  ex2_grs;                       
wire             ex2_half;                      
wire    [14 :0]  ex2_half0_add_r;               
wire    [11 :0]  ex2_half0_addsub_rslt;         
wire    [11 :0]  ex2_half0_lop_src0;            
wire    [11 :0]  ex2_half0_lop_src1;            
wire    [10 :0]  ex2_half0_src1_e;              
wire    [11 :0]  ex2_half0_sub000xx_rslt;       
wire    [14 :0]  ex2_half0_sub_r;               
wire    [53 :0]  ex2_lop_src0;                  
wire    [53 :0]  ex2_lop_src1;                  
wire             ex2_no_dn_no_widden;           
wire             ex2_nocmp_nosel;               
wire             ex2_nx;                        
wire             ex2_op_no_sel;                 
wire             ex2_op_sel;                    
wire             ex2_r_add01xxx;                
wire             ex2_r_add1xxxx;                
wire             ex2_r_sel000xx;                
wire             ex2_r_sub000xx;                
wire             ex2_r_sub001xx;                
wire             ex2_r_sub01xxx;                
wire             ex2_rdn;                       
wire             ex2_rmm;                       
wire             ex2_rne;                       
wire             ex2_rst_shift;                 
wire             ex2_rtz;                       
wire             ex2_rup;                       
wire             ex2_single;                    
wire    [27 :0]  ex2_single0_add_r;             
wire    [24 :0]  ex2_single0_addsub_rslt;       
wire    [24 :0]  ex2_single0_lop_src0;          
wire    [24 :0]  ex2_single0_lop_src1;          
wire    [10 :0]  ex2_single0_src1_e;            
wire    [24 :0]  ex2_single0_sub000xx_rslt;     
wire    [27 :0]  ex2_single0_sub_r;             
wire    [10 :0]  ex2_single_half_e_add_rslt;    
wire    [10 :0]  ex2_single_half_e_rslt;        
wire             ex2_special_value_vld;         
wire             ex2_src0_e_eq_0;               
wire             ex2_src0_eq_src1;              
wire    [10 :0]  ex2_src1_e;                    
wire             ex2_sub_1;                     
wire    [2  :0]  ex2_sub_grs;                   
wire             ex2_sub_neg;                   
wire    [27 :0]  ex2_sub_r_shift;               
wire    [27 :0]  ex2_sub_r_shift_t;             
wire             ex2_sub_sel_m1;                
wire             ex2_widden_potnt_sub000;       
wire             ex3_act_add;                   
wire             ex3_act_s;                     
wire             ex3_bhalf;                     
wire    [6  :0]  ex3_bhalf0_f;                  
wire    [8  :0]  ex3_bhalf0_result;             
wire    [10 :0]  ex3_d_norm_e;                  
wire             ex3_d_sel_adder;               
wire             ex3_double;                    
wire             ex3_double_dn;                 
wire    [51 :0]  ex3_double_f;                  
wire    [53 :0]  ex3_double_result;             
wire    [53 :0]  ex3_double_result_f;           
wire    [51 :0]  ex3_double_sub000xx_f;         
wire    [53 :0]  ex3_double_sub_rst;            
wire    [11 :0]  ex3_e_addr_src1;               
wire             ex3_e_max;                     
wire             ex3_e_sel_adder;               
wire    [11 :0]  ex3_e_tmp_0;                   
wire             ex3_expt_mask;                 
wire             ex3_expt_nx;                   
wire             ex3_expt_of;                   
wire             ex3_half;                      
wire    [9  :0]  ex3_half0_f;                   
wire    [11 :0]  ex3_half0_result;              
wire    [10 :0]  ex3_no_d_norm_e;               
wire    [51 :0]  ex3_norm_double_f;             
wire             ex3_nv;                        
wire             ex3_op_cmp;                    
wire             ex3_op_sel;                    
wire    [10 :0]  ex3_org_e;                     
wire             ex3_r_0;                       
wire             ex3_r_inf;                     
wire             ex3_r_lfn;                     
wire             ex3_r_lfn_sel;                 
wire             ex3_r_sub000xx;                
wire             ex3_rdn;                       
wire             ex3_rtz;                       
wire             ex3_rup;                       
wire             ex3_single;                    
wire    [22 :0]  ex3_single0_f;                 
wire    [24 :0]  ex3_single0_result;            
wire             ex3_special_n_op_sel;          
wire    [53 :0]  ex3_sub_rst_shift;             
wire             ex3_to_dn;                     
wire    [63 :0]  fadd_double_src0;              
wire    [63 :0]  fadd_double_src1;              
wire             fadd_ex1_act_sub;              
wire             fadd_ex1_op_add_sub;           
wire             fadd_ex1_pipe_clk;             
wire             fadd_ex1_pipedown;             
wire             fadd_ex2_nocmp_pipe_clk;       
wire             fadd_ex2_nocmp_pipedown;       
wire    [15 :0]  fadd_half0_src0;               
wire    [15 :0]  fadd_half0_src1;               
wire    [31 :0]  fadd_single0_src0;             
wire    [31 :0]  fadd_single0_src1;             
wire    [4  :0]  ff1_pred_bh_b;                 
wire    [5  :0]  ff1_pred_d_b;                  
wire    [4  :0]  ff1_pred_h_b;                  
wire    [4  :0]  ff1_pred_s_b;                  
wire             ifu_vpu_warm_up;               
wire    [5  :0]  left_shift_cnt;                
wire             sa;                            
wire             sb;                            
wire    [22 :0]  single0_src0_raw;              
wire    [22 :0]  single0_src1_raw;              
wire    [27 :0]  sub000_shift_value;            


//------------------------------------------------------------------------------
//                    Valid Add/Sub :
//------------------------------------------------------------------------------
//According to origin operate and sign of two oprand
//Get to valid operate
//  Add/sub  |   S0  |   S1  |  Result  |
//    Add        +       +        Add
//    Add        +       -        Sub
//    Add        -       +        Sub
//    Add        -       -        Add
//    Sub        +       +        Sub
//    Sub        +       -        Add
//    Sub        -       +        Add
//    Sub        -       -        Sub
//Ex1 Actural Operation

assign ex1_act_sub = (ex1_op_add) &&
                     (sa ^ sb) ||
                     (ex1_op_sub  || ex1_op_cmp  || ex1_cmp_sel) &&
                     (sa ^~ sb);
assign ex1_act_s   = (ex1_es && ex1_cmp_sub)
                   ? ~ex1_e_big_s
                   : ex1_e_big_s;
assign ex1_cmp_sub = ex1_op_sub || ex1_op_cmp || ex1_cmp_sel;
assign ex1_cmp_sel = ex1_op_sel;


//------------------------------------------------------------------------------
//                    EX1 Double/Single Merge:
//------------------------------------------------------------------------------
//sa : input src_0 sign, fa : input src_0 frac
//sb : input src_1 sign  fb : input src_1 frac
//ex1_s_big_s : the expnt bigger number's sign
assign sa       = ex1_double & fadd_double_src0[63]   || 
                  ex1_single & (fadd_single0_src0[31]) || 
                  ex1_f16   & fadd_half0_src0[15];

assign sb       = ex1_double & fadd_double_src1[63]   || 
                  ex1_single & (fadd_single0_src1[31]) || 
                  ex1_f16   & fadd_half0_src1[15];

// expnt src0
assign ea[10:0] = {11{ex1_double}} & ex1_double_ea[10:0]          |
                  {11{ex1_single}} & {ex1_single_ea[10:0]}            |
                  {11{ex1_half}}   & {6'b0, fadd_half0_src0[14:10]}   |
                  {11{ex1_bhalf}}  & {3'b0, fadd_half0_src0[14:7]};

assign ex1_single_ea[10:0]      = {3'b0,fadd_single0_src0[30:23]};
assign ex1_double_ea[10:0]      = fadd_double_src0[62:52];
assign ex1_half0_src0_norm      = fadd_half0_src0[14:10] != 5'b0;
assign ex1_bhalf0_src0_norm     = ex1_half0_src0_norm || (fadd_half0_src0[9:7]!=3'b0);
assign ex1_single0_src0_norm    = fadd_single0_src0[30:23] != 8'b0;
assign ex1_double_src0_norm     = fadd_double_src0[62:52] != 11'b0;

assign ex1_half0_src1_norm      = fadd_half0_src1[14:10] != 5'b0;
assign ex1_bhalf0_src1_norm     = ex1_half0_src1_norm || (fadd_half0_src1[9:7]!=3'b0);
assign ex1_single0_src1_norm    = fadd_single0_src1[30:23] != 8'b0;
assign ex1_double_src1_norm     = fadd_double_src1[62:52] != 11'b0;

assign ex1_single_eb[10:0]             = {3'b0,fadd_single0_src1[30:23]};
assign ex1_double_eb[10:0]             = {fadd_double_src1[62:52]};
assign eb[10:0]                        = {11{ex1_double}} &  ex1_double_eb[10:0]          |
                                         {11{ex1_single}} & {ex1_single_eb[10:0]}            |
                                         {11{ex1_half}}   & {6'b0, fadd_half0_src1[14:10]}   |
                                         {11{ex1_bhalf}}  & {3'b0, fadd_half0_src1[14:7]};
// tail number src0

assign ex1_bhalf0_fa_for_shift[7:0]  = ex1_bhalf0_src0_norm ? {1'b1,fadd_half0_src0[6:0]}
                                                            : {fadd_half0_src0[6:0],1'b0};
assign ex1_half0_fa_for_shift[10:0]  = ex1_half0_src0_norm ? {1'b1,fadd_half0_src0[9:0]}
                                                            : {fadd_half0_src0[9:0],1'b0};
assign ex1_single0_fa[23:0]          = ex1_single0_src0_norm ? {1'b1,fadd_single0_src0[22:0]}  
                                                             : {fadd_single0_src0[22:0],1'b0};
assign ex1_single0_fa_for_shift[23:0]= ex1_single0_fa[23:0];
assign ex1_double_fa_for_shift[52:0] = ex1_double_fa[52:0];

assign ex1_double_fa[52:0] = ex1_double_src0_norm ? {1'b1,fadd_double_src0[51:0]}
                                                            : {fadd_double_src0[51:0],1'b0};

// tail numbner src1

assign ex1_bhalf0_fb_for_shift[7:0]  = ex1_bhalf0_src1_norm ? {1'b1,fadd_half0_src1[6:0]}
                                                            : {fadd_half0_src1[6:0],1'b0};
assign ex1_half0_fb_for_shift[10:0]  = ex1_half0_src1_norm ? {1'b1,fadd_half0_src1[9:0]}
                                                            : {fadd_half0_src1[9:0],1'b0};
assign ex1_single0_fb_for_shift[23:0]  = ex1_single0_fb[23:0];
assign ex1_double_fb_for_shift[52:0]   = ex1_double_fb[52:0];
assign ex1_single0_fb[23:0]          = ex1_single0_src1_norm ? {1'b1,fadd_single0_src1[22:0]}  
                                                             : {fadd_single0_src1[22:0],1'b0};


assign ex1_double_fb[52:0] = ex1_double_src1_norm ? {1'b1,fadd_double_src1[51:0]}
                                                            : {fadd_double_src1[51:0],1'b0};
// //&Connect(.htos_sh_src(fadd_half0_widden_src1[9:0])); @195
// //&Connect(.htos_sh_f_v(widden_half_dn_fb_pre[10:0])); @196
// //&Connect(.htos_sh_cnt(widden_half_dn_eb_pre[7:0])); @197
// &Instance("aq_stod_sh"); @200
// &Connect(.stod_sh_src(stod_sh_src[22:0])); @201
// &Connect(.stod_sh_f_v(widden_dn_fb_pre[23:0])); @202
// &Connect(.htos_sh_cnt(widden_half_dn_eb_pre[7:0])); @203
// &Connect(.stod_sh_cnt(widden_single_dn_eb_pre[10:0])); @204
//
//assign fa[51:0] = ex1_double & fadd_double_src0[51:0]  : {29'b0, fadd_single0_src0[22:0]};
//
//assign sb       = ex1_double & fadd_double_src1[63]    : fadd_single0_src1[31];
//assign eb[10:0] = ex1_double & fadd_double_src1[62:52] : {3'b0, fadd_single0_src1[30:23]};
//assign fb[51:0] = ex1_double & fadd_double_src1[51:0]  : {29'b0, fadd_single0_src1[22:0]};

assign ex1_e_big_s      = ex1_es ? sb : sa;
assign ex1_src0_e[10:0] = ea[10:0];
assign ex1_src1_e[10:0] = eb[10:0];
//assign ex1_src0_f[51:0] = fa[51:0];
//assign ex1_src1_f[51:0] = fb[51:0];

// norm : src is not nan/inf/dn/0
// id   : input denormal
//assign ex1_src0_norm    = ;
//assign ex1_src1_norm    = ;
assign ex1_src0_id      = double_pipe_ex1_src0_id;
assign ex1_src1_id      = double_pipe_ex1_src1_id;

// for power : add ex1 src mux
//assign fadd_double_src0[63:0] = idu_fpu_ex1_srcf0[63:0] & {64{fadd_ex1_sel}};
//assign fadd_src1[63:0] = idu_fpu_ex1_srcf1[63:0] & {64{fadd_ex1_sel}};
assign single0_src0_raw[22:0] = fadd_single0_src0[22:0];
assign single0_src1_raw[22:0] = fadd_single0_src1[22:0];
assign double_src0_raw[51:0]  = fadd_double_src0[51:0];
assign double_src1_raw[51:0]  = fadd_double_src1[51:0];
assign ex1_src0_s      = sa;
assign ex1_src1_s      = sb;
assign ex1_src0_for_eq[52:0] = {53{ex1_double}} & ex1_double_fa_for_shift[52:0]         |
                               {53{ex1_single}} & {ex1_single0_fa_for_shift[23:0],29'b0}|
                               {53{ex1_half}}   & {ex1_half0_fa_for_shift[10:0],42'b0}   |
                               {53{ex1_bhalf}}  & {ex1_bhalf0_fa_for_shift[7:0],45'b0};
assign ex1_src1_for_eq[52:0] = {53{ex1_double}} & ex1_double_fb_for_shift[52:0]         |
                               {53{ex1_single}} & {ex1_single0_fb_for_shift[23:0],29'b0}|
                               {53{ex1_half}}   & {ex1_half0_fb_for_shift[10:0],42'b0}   |
                               {53{ex1_bhalf}}  & {ex1_bhalf0_fb_for_shift[7:0],45'b0};
assign ex1_src0_raw[51:0] = {52{ex1_double}} & double_src0_raw[51:0]         |
                               {52{ex1_single}} & {single0_src0_raw[22:0],29'b0}|
                               {52{ex1_half}}   & {fadd_half0_src0[9:0],42'b0}   |
                               {52{ex1_bhalf}}  & {fadd_half0_src0[6:0],45'b0};
assign ex1_src1_raw[51:0] = {52{ex1_double}} & double_src1_raw[51:0]         |
                               {52{ex1_single}} & {single0_src1_raw[22:0],29'b0}|
                               {52{ex1_half}}   & {fadd_half0_src1[9:0],42'b0}   |
                               {52{ex1_bhalf}}  & {fadd_half0_src1[6:0],45'b0};
assign ex1_f_e_equal       = (ex1_src0_e[10:0] == ex1_src1_e[10:0]) && (ex1_src0_for_eq[52:0] == ex1_src1_for_eq[52:0]);
assign ex1_src0_equal_src1 = ex1_f_e_equal;


//------------------------------------------------------------------------------
//                    EX1 Exponent Sub:
//------------------------------------------------------------------------------
// four adders in parallel
// the sign of the result of adder 0 is used to select the positive result
// 
//
// 


assign e_diff[11:0]          = {1'b0,ea[10:0]}- {1'b0, eb[10:0]};
assign e_diff_contrary[11:0] = {1'b0,eb[10:0]}- {1'b0, ea[10:0]};
assign ex1_es                = e_diff[11];

// when ex1_es is 1, src_0 expnt is less than src_1 expnt

assign ex1_e_ed[10:0]   = e_diff[11] ? e_diff_contrary[10:0] : e_diff[10:0];


// shift number prepare, the number who has smaller expnt need shift

//assign ex1_double_shift_pre[52:0] = ex1_es ? ex1_double_fa_for_shift[52:0] : ex1_double_fb_for_shift[52:0];
//assign ex1_double_adder_a[52:0]   = ex1_es ? ex1_double_fb_for_shift[52:0] : ex1_double_fa_for_shift[52:0];
//
//assign ex1_single0_shift_pre[23:0] = ex1_es ? ex1_single0_fa_for_shift[23:0] : ex1_single0_fb_for_shift[23:0];
//assign ex1_single0_adder_a[23:0]   = ex1_es ? ex1_single0_fb_for_shift[23:0] : ex1_single0_fa_for_shift[23:0];
//
//assign ex1_half0_shift_pre[10:0]   = ex1_es ? ex1_half0_fa_for_shift[10:0] : ex1_half0_fb_for_shift[10:0];
//assign ex1_half0_adder_a[10:0]     = ex1_es ? ex1_half0_fb_for_shift[10:0] : ex1_half0_fa_for_shift[10:0];
//
//assign ex1_bhalf0_shift_pre[7:0]   = ex1_es ? ex1_bhalf0_fa_for_shift[7:0] : ex1_bhalf0_fb_for_shift[7:0];
//assign ex1_bhalf0_adder_a[7:0]     = ex1_es ? ex1_bhalf0_fb_for_shift[7:0] : ex1_bhalf0_fa_for_shift[7:0];

//assign double_pipe_ed[5:0]        = ex1_e_ed[5:0];
assign ex1_double_shift_pre[52:0]  = ex1_for_align_shift[52:0];
assign ex1_single0_shift_pre[23:0] = ex1_for_align_shift[23:0];
assign ex1_half0_shift_pre[10:0]   = ex1_for_align_shift[10:0];
assign ex1_bhalf0_shift_pre[7:0]   = ex1_for_align_shift[7:0];

// //&Force("output","ex1_align_shift_result"); @343

// for timing consideration we align at the least significant bits for the single and half

assign ex1_src0_for_shift[52:0] = {53{ex1_double}} & ex1_double_fa_for_shift[52:0]         |
                                  {53{ex1_single}} & {29'b0,ex1_single0_fa_for_shift[23:0]}|
                                  {53{ex1_half}}   & {42'b0,ex1_half0_fa_for_shift[10:0]}  |
                                  {53{ex1_bhalf}}  & {45'b0,ex1_bhalf0_fa_for_shift[7:0]};
assign ex1_src1_for_shift[52:0] = {53{ex1_double}} & ex1_double_fb_for_shift[52:0]         |
                                  {53{ex1_single}} & {29'b0,ex1_single0_fb_for_shift[23:0]}|
                                  {53{ex1_half}}   & {42'b0,ex1_half0_fb_for_shift[10:0]}  |
                                  {53{ex1_bhalf}}  & {45'b0,ex1_bhalf0_fb_for_shift[7:0]};

assign ex1_for_align_shift[52:0] = ex1_es ? ex1_src0_for_shift[52:0] : ex1_src1_for_shift[52:0];
assign ex1_for_adder_a[52:0]     = ex1_es ? ex1_src1_for_shift[52:0] : ex1_src0_for_shift[52:0];

assign ex1_align_shift_result[84:0]  = {ex1_for_align_shift[52:0],32'b0} >> ex1_e_ed[4:0];

// ///&Force("output","ex1_double_shift_pre"); @361
// ///&Force("output","ex1_single0_shift_pre"); @362
// ///&Force("output","ex1_half0_shift_pre"); @363
// ///&Force("output","ex1_bhalf0_shift_pre"); @364
assign ex1_add_bypass   = ex1_double && ex1_e_ed[10:0] >  11'h36 ||
                          ex1_single && ex1_e_ed[10:0] >  11'h19 ||
                          ex1_half   && ex1_e_ed[10:0] >  11'hc  ||
                          ex1_bhalf  && ex1_e_ed[10:0] >  11'h9;
assign ex1_add_bypass_s = ex1_double && |ex1_double_shift_pre[52:0] || 
                          ex1_single && |ex1_single0_shift_pre[23:0] ||
                          ex1_half   && |ex1_half0_shift_pre[10:0]    ||
                          ex1_bhalf  && |ex1_bhalf0_shift_pre[7:0];


//assign ex1_double_adder_a_nor[52:0]     = ~ex1_double_adder_a[52:0];
//assign ex1_double_adder_a_final[52:0]   = ex1_act_sub ? ex1_double_adder_a_nor[52:0] : ex1_double_adder_a[52:0];
////assign ex1_double_adder_b_final[52:0]   = ex1_double_shift[52:0];
//
//assign ex1_single0_adder_a_nor[23:0]     = ~ex1_single0_adder_a[23:0];
//assign ex1_single0_adder_a_final[23:0]   = ex1_act_sub ? ex1_single0_adder_a_nor[23:0] : ex1_single0_adder_a[23:0];
////assign ex1_single0_adder_b_final[23:0]   = ex1_single0_shift[23:0];
//
//assign ex1_half0_adder_a_nor[10:0]     = ~ex1_half0_adder_a[10:0];
//assign ex1_half0_adder_a_final[10:0]   = ex1_act_sub ? ex1_half0_adder_a_nor[10:0] : ex1_half0_adder_a[10:0];
////assign ex1_half0_adder_b_final[10:0]   = ex1_half0_shift[10:0];
//
//assign ex1_bhalf0_adder_a_nor[7:0]     = ~ex1_bhalf0_adder_a[7:0];
//assign ex1_bhalf0_adder_a_final[7:0]   = ex1_act_sub ? ex1_bhalf0_adder_a_nor[7:0] : ex1_bhalf0_adder_a[7:0];
////assign ex1_bhalf0_adder_b_final[7:0]   = ex1_bhalf0_shift[7:0];

assign ex1_for_adder_a_nor[52:0]        = ~ex1_for_adder_a[52:0];
assign ex1_for_adder_a_final[52:0]      = ex1_act_sub ? ex1_for_adder_a_nor[52:0] : ex1_for_adder_a[52:0];
assign ex1_double_adder_a_final[53:0]   = {ex1_act_sub,ex1_for_adder_a_final[52:0]};
assign ex1_single0_adder_a_final[24:0]  = {ex1_act_sub,ex1_for_adder_a_final[23:0]};
assign ex1_half0_adder_a_final[11:0]    = {ex1_act_sub,ex1_for_adder_a_final[10:0]};
assign ex1_bhalf0_adder_a_final[8:0]    = {ex1_act_sub,ex1_for_adder_a_final[7:0]};

// These signals are for max/min result
assign ex1_src0_e_raw[10:0] = ex1_es ? eb[10:0] : ea[10:0];
assign ex1_src1_e_raw[10:0] = ex1_es ? ea[10:0] : eb[10:0];

assign ex1_src1_f_raw[51:0] = ex1_es ? ex1_src0_raw[51:0] : ex1_src1_raw[51:0];
// this signal is used for the shift, which is denorm, the ed of the float is 
// used to indicate absolutely difference
assign ex1_src0_f_raw       = ex1_es ? ex1_src1_dn_0 : ex1_src0_dn_0;

assign ex1_src0_s_raw       = ex1_es ? sb : sa;
assign ex1_src1_s_raw       = ex1_es ? sa : sb;



// these signal is used for the sub result selection in the second stage

assign ex1_src0_dn_0  = ex1_src0_0 || ex1_src0_id;
assign ex1_src1_dn_0  = ex1_src1_0 || ex1_src1_id;
assign ex1_e_diff_1     = (ex1_e_ed[10:0] == 11'b1);
assign ex1_e_diff_0     = (ex1_e_ed[10:0] == 11'b0);
assign ex1_both_dn               = ex1_src0_dn_0 && ex1_src1_dn_0;



// this data is used for restore the other operand
assign ex1_double_src1_sel_raw[63:0]  = {ex1_src1_s_raw, ex1_src1_e_raw[10:0], ex1_src1_f_raw[51:0]};
assign ex1_single0_src1_sel_raw[31:0] = {ex1_src1_s_raw, ex1_src1_e_raw[7:0], ex1_src1_f_raw[51:29]};
assign ex1_half0_src1_sel_raw[15:0]   = {ex1_src1_s_raw, ex1_src1_e_raw[4:0], ex1_src1_f_raw[51:42]};
assign ex1_bhalf0_src1_sel_raw[15:0]  = {ex1_src1_s_raw, ex1_src1_e_raw[7:0], ex1_src1_f_raw[51:45]};


//assign falu_fpu_ex1_src_reuse_data[63:0] = ex1_src1_sel_raw[63:0];
//assign falu_fpu_ex1_src_reuse            = ex1_sel_nm_vld ;

//------------------------------------------------------------------------------
//                    EX1 Most Shift NM:
//------------------------------------------------------------------------------
//For result is denormal, shift_cnt has a limit
//the shift base is 1, and when e euqal 0 shoule be seemed as 1
assign ex1_e_big_t[10:0]    = ex1_es ? ex1_src1_e[10:0] : ex1_src0_e[10:0];
assign ex1_e_big_diff[11:0] = {1'b0,ex1_e_big_t[10:0]} - 12'b1;
assign ex1_e_big[10:0]      = ex1_e_big_diff[10:0] & {11{!ex1_e_big_diff[11]}};
assign ex1_shift_no_limit   = |ex1_e_big[10:6];

// &CombBeg; @447
always @( ex1_e_big[2:0])
begin
case(ex1_e_big[2:0])
  3'd0 : ex1_e_onehot[7:0] = 8'b1000_0000;
  3'd1 : ex1_e_onehot[7:0] = 8'b0100_0000;
  3'd2 : ex1_e_onehot[7:0] = 8'b0010_0000;
  3'd3 : ex1_e_onehot[7:0] = 8'b0001_0000;
  3'd4 : ex1_e_onehot[7:0] = 8'b0000_1000;
  3'd5 : ex1_e_onehot[7:0] = 8'b0000_0100;
  3'd6 : ex1_e_onehot[7:0] = 8'b0000_0010;
  3'd7 : ex1_e_onehot[7:0] = 8'b0000_0001;
  default: ex1_e_onehot[7:0] = {8{1'bx}};
endcase
// &CombEnd; @459
end

assign ex1_double_special_data[63:0]     = ex1_double_src1_sel_raw[63:0];
assign ex1_single0_special_data[31:0]    = ex1_single0_src1_sel_raw[31:0];
assign ex1_half0_special_data[15:0]      = ex1_half0_src1_sel_raw[15:0];
assign ex1_bhalf0_special_data[15:0]     = ex1_bhalf0_src1_sel_raw[15:0];
assign ex1_r_0_sign = ex1_op_add &&
                      ((ex1_src0_s && ex1_src1_s) ||
                      (ex1_src0_s || ex1_src1_s) && ex1_rdn) ||
                      ex1_op_sub &&
                      ((ex1_src0_s && !ex1_src1_s) ||
                      (ex1_src0_s || !ex1_src1_s) && ex1_rdn);

// output for icg
assign fadd_ex1_act_sub    = ex1_act_sub;
assign fadd_ex1_op_add_sub = ex1_op_add_sub;


//==============================================================================
//                     EX1 pipedown to EX2
//==============================================================================
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown || ifu_vpu_warm_up) begin
    ex2_act_s_raw         <= ex1_act_s;
    ex2_act_sub           <= ex1_act_sub;
    ex2_both_dn           <= ex1_both_dn;
    ex2_src_equal         <= ex1_src0_equal_src1;
    ex2_r_0_sign          <= ex1_r_0_sign;
    ex2_src_chg           <= ex1_es;
    ex2_src0_s            <= ex1_src0_s_raw;
    ex2_src1_s            <= ex1_src1_s_raw;
    ex2_src0_e[10:0]      <= ex1_src0_e_raw[10:0];
    ex2_e_diff_0          <= ex1_e_diff_0;
    ex2_add_bypass        <= ex1_add_bypass;
    ex2_add_bypass_s      <= ex1_add_bypass_s;
    ex2_src0_0            <= ex1_src0_0;   
    ex2_src1_0            <= ex1_src1_0;   
  end
end
// &Force("output","ex2_act_sub"); @499

always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown && fadd_ex1_act_sub && fadd_ex1_op_add_sub || ifu_vpu_warm_up) begin
    ex2_e_mask_h[2:0]     <= ex1_e_big[5:3];
    ex2_e_onehot_pre[7:0] <= ex1_e_onehot[7:0];
    ex2_shift_no_limit    <= ex1_shift_no_limit;
    ex2_e_diff_1          <= ex1_e_diff_1;
  end
end


always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown || ifu_vpu_warm_up) begin
    ex2_src0_f_position    <= ex1_src0_f_raw;
  end
end
// for timing consideration
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown || ifu_vpu_warm_up) begin
    ex2_adder_b[84:0] <= ex1_align_shift_result[84:0];
    ex2_double_ed     <= ex1_e_ed[5];
  end
end

assign add_cmp_ex2_src0_eq_src1 = ex2_src_equal;
//==============================================================================
//                     EX2 Operation
//==============================================================================
//the information to the max/min and compare
assign add_cmp_both_zero   = ex2_src0_0 && ex2_src1_0;
//------------------------------------------------------------------------------
//                     EX2 Most Shift Mask:
//------------------------------------------------------------------------------
//This for dn rst to limit the shift_cnt
// &CombBeg; @537
always @( ex2_e_onehot_pre[7:0]
       or ex2_e_mask_h[2:0])
begin
case(ex2_e_mask_h[2:0])
  3'd0 : ex2_e_onehot_raw[63:0]   = {ex2_e_onehot_pre[7:0], 56'b0};
  3'd1 : ex2_e_onehot_raw[63:0]   = {8'b0,  ex2_e_onehot_pre[7:0], 48'b0};
  3'd2 : ex2_e_onehot_raw[63:0]   = {16'b0, ex2_e_onehot_pre[7:0], 40'b0};
  3'd3 : ex2_e_onehot_raw[63:0]   = {24'b0, ex2_e_onehot_pre[7:0], 32'b0};
  3'd4 : ex2_e_onehot_raw[63:0]   = {32'b0, ex2_e_onehot_pre[7:0], 24'b0};
  3'd5 : ex2_e_onehot_raw[63:0]   = {40'b0, ex2_e_onehot_pre[7:0], 16'b0};
  3'd6 : ex2_e_onehot_raw[63:0]   = {48'b0, ex2_e_onehot_pre[7:0], 8'b0};
  3'd7 : ex2_e_onehot_raw[63:0]   = {56'b0, ex2_e_onehot_pre[7:0]};
  default: ex2_e_onehot_raw[63:0] = {64{1'bx}};
endcase
// &CombEnd; @549
end
assign ex2_e_onehot[63:0]      = ex2_e_onehot_raw[63:0] & {64{!ex2_shift_no_limit}};
assign ex2_e_onehot_mask[53:0] = {54{ex2_single && !ex2_dest_widden}} & {30'b0, ex2_e_onehot[63:40]} |
                                 {54{ex2_double && !ex2_dest_widden}} & {1'b0, ex2_e_onehot[63:11]}  |
                                 {54{ex2_half}}   & {43'b0, ex2_e_onehot[63:53]} |
                                 {54{ex2_bhalf}}  & {46'b0, ex2_e_onehot[63:56]};

//------------------------
// 
//------------------------
// &Force("bus","double_pipe_ex2_special_result",63,0); @559
assign dp_src_a_f_orig[52:0]          = ex2_act_sub         ? ~ex2_double_adder_a[52:0]    : ex2_double_adder_a[52:0];
assign dp_maxmin_src_a_f[51:0]        = ex2_src0_f_position ? dp_src_a_f_orig[52:1] : dp_src_a_f_orig[51:0];
assign dp_maxmin_src_a_e[10:0]        = ex2_src0_e[10:0];
assign dp_maxmin_src_a_s              = ex2_src0_s;
assign dp_maxmin_src_b_f[52:0]        = double_pipe_ex2_special_result[52:0];
assign dp_maxmin_src_b_e[10:0]        = ex2_src1_e[10:0];
assign dp_maxmin_src_b_s              = ex2_src1_s;
assign ex2_double_src1_e[10:0]        = double_pipe_ex2_special_result[62:52];
assign ex2_single0_src1_e[10:0]       = {3'b0,double_pipe_ex2_special_result[30:23]};
assign ex2_half0_src1_e[10:0]         = {6'b0,double_pipe_ex2_special_result[14:10]};
assign ex2_bhalf0_src1_e[10:0]        = {3'b0,double_pipe_ex2_special_result[14:7]};

assign ex2_src1_e[10:0]               = {11{ex2_double}} & ex2_double_src1_e[10:0]  |
                                        {11{ex2_single}} & ex2_single0_src1_e[10:0] |
                                        {11{ex2_half}}   & ex2_half0_src1_e[10:0]   |
                                        {11{ex2_bhalf}}  & ex2_bhalf0_src1_e[10:0];

assign dp_maxmin_src_chg              = ex2_src_chg;
//------------------------------------------------------------------------------
//                     EX2 LOP and Adder:
//------------------------------------------------------------------------------

assign ex2_adder_b_double[116:0]           = ex2_double_ed ? {32'b0,ex2_adder_b[84:0]}
                                                           : {ex2_adder_b[84:0],32'b0};

//assign ex2_adder_b_tail[54:0]         = {55{ex2_double}} & ex2_double_adder_b_tail[54:0]          | 
//                                        {55{ex2_single}} & {ex2_single0_adder_b_tail[25:0],29'b0} |
//                                        {55{ex2_half}}   & {ex2_half0_adder_b_tail[12:0],42'b0}   |
//                                        {55{ex2_bhalf}}  & {ex2_bhalf0_adder_b_tail[9:0],45'b0};

assign ex2_adder_src1[53:0]           = ex2_add_bypass ? 54'b0 : {1'b0, ex2_adder_b_double[116:64]};
assign ex2_adder_b_tail[54:0]         = ex2_adder_b_double[63:9];
//assign ex2_double_adder_b[52:0]       = ex2_adder_b[52:0];
//assign ex2_single0_adder_b[23:0]      = ex2_adder_b[23:0];
//assign ex2_half0_adder_b[10:0]        = ex2_adder_b[10:0];
//assign ex2_bhalf0_adder_b[7:0]        = ex2_adder_b[7:0];

assign ex2_grs[2:0]                   = ex2_add_bypass ? {2'b0,ex2_add_bypass_s}
                                                       : {ex2_adder_b_tail[54],ex2_adder_b_tail[53],|ex2_adder_b_tail[52:0]};


assign ex2_double_lop_src0[53:0]   = {ex2_double_adder_a[53:0]};
assign ex2_double_lop_src1[53:0]   = ex2_adder_src1[53:0];
//assign ex2_double_adder_src0[53:0] = ex2_double_lop_src0[53:0];
//assign ex2_double_adder_src1[53:0] = ex2_double_lop_src1[53:0];

assign ex2_single0_lop_src0[24:0]  = ex2_double_adder_a[24:0];
assign ex2_single0_lop_src1[24:0]  = ex2_adder_src1[24:0];
//assign ex2_single0_adder_src0[24:0]= ex2_single0_lop_src0[24:0];
//assign ex2_single0_adder_src1[24:0]= ex2_single0_lop_src1[24:0];
//
assign ex2_half0_lop_src0[11:0]   = ex2_double_adder_a[11:0];
assign ex2_half0_lop_src1[11:0]   = ex2_adder_src1[11:0];
//assign ex2_half0_adder_src0[11:0] = ex2_half0_lop_src0[11:0];
//assign ex2_half0_adder_src1[11:0] = ex2_half0_lop_src1[11:0];
//
assign ex2_bhalf0_lop_src0[8:0]   = ex2_double_adder_a[8:0];
assign ex2_bhalf0_lop_src1[8:0]   = ex2_adder_src1[8:0];
//assign ex2_bhalf0_adder_src0[8:0] = ex2_bhalf0_lop_src0[8:0];
//assign ex2_bhalf0_adder_src1[8:0] = ex2_bhalf0_lop_src1[8:0];

// //&Force("output","ex2_double_adder_src0"); @621
// //&Force("output","ex2_double_adder_src1"); @622
// //&Force("output","ex2_single0_adder_src0"); @623
// //&Force("output","ex2_single0_adder_src1"); @624
// //&Force("output","ex2_half0_adder_src0"); @625
// //&Force("output","ex2_half0_adder_src1"); @626
// //&Force("output","ex2_bhalf0_adder_src0"); @627
// //&Force("output","ex2_bhalf0_adder_src1"); @628
//preprare for the leading zero prediction
//
//assign ex2_lop_src0[53:0]   = ex2_double_adder_a[53:0];
//assign ex2_lop_src1[53:0]   = ex2_adder_src1[53:0];
assign ex2_lop_src0[53:0]   = {54{ex2_double}} & ex2_double_lop_src0[53:0]          |
                              {54{ex2_single}} & {{29{ex2_single0_lop_src0[24]}},ex2_single0_lop_src0[24:0]} |
                              {54{ex2_half}}   & {{42{ex2_half0_lop_src0[11]}},ex2_half0_lop_src0[11:0]}   |
                              {54{ex2_bhalf}}  & {{45{ex2_bhalf0_lop_src0[8]}},ex2_bhalf0_lop_src0[8:0]};
assign ex2_lop_src1[53:0]   = {54{ex2_double}} & ex2_double_lop_src1[53:0]          |
                              {54{ex2_single}} & {29'b0,ex2_single0_lop_src1[24:0]} |
                              {54{ex2_half}}   & {42'b0,ex2_half0_lop_src1[11:0]}   |
                              {54{ex2_bhalf}}  & {45'b0,ex2_bhalf0_lop_src1[8:0]};

assign ex2_src0_eq_src1 = ex2_src_equal;
assign ex2_act_s_tmp    = ex2_act_s_raw;
assign ex2_act_add      = !ex2_act_sub;
assign ex2_src0_e_eq_0  = ex2_src0_e[10:0] == 11'b0;


assign ex2_op_no_sel      = ex2_act_sub && !ex2_op_sel;

/// we wound like to caclulate the a+b+16, using its value to calculate the
// rounding result
// for minus, ~(~a+b-8) = a-b+8 
// so the third operand for add: 16, for sub: -8

// there will be two adder
//             adder0             adder1 
//add       :  a+b                a+b+2
//sub dif 1 :  ~a+b+1(~(a-b-1))   ~a+b ~(a-b)
//sub dif 0 :  ~a+b+1(b-a)        ~a+b ~(a-b)


// for timing consideration the adder will not reuse with other module
assign double_pipe_adder1_op2[53:0]     = double_pipe_ex2_act_add ? 54'd0 : 54'd1;
assign double_pipe_adder2_op2[53:0]     = double_pipe_ex2_act_add ? 54'd2 : 54'd0;

assign ex2_double_pipe_add1_rslt[53:0] =  ex2_double_adder_a[53:0] + ex2_adder_src1[53:0] + double_pipe_adder1_op2[53:0];
assign ex2_double_pipe_add2_rslt[53:0] =  ex2_double_adder_a[53:0] + ex2_adder_src1[53:0] + double_pipe_adder2_op2[53:0];

// the double result
assign double_pipe_ex2_act_add     = !ex2_act_sub;
// TBD
assign ex2_double_add_r[56:0]      = {ex2_double_pipe_add1_rslt[53:0],ex2_grs[2:0]};
assign ex2_double_add_inc2_r[56:0] = {ex2_double_pipe_add2_rslt[53:0],ex2_grs[2:0]};
assign ex2_double_add_inc1_r[56:0] = ex2_double_pipe_add1_rslt[0] ? {ex2_double_pipe_add2_rslt[53:1],1'b0, ex2_grs[2:0]}
                                                                  : {ex2_double_pipe_add1_rslt[53:0] | 54'd1,ex2_grs[2:0]};

// the sub 
assign ex2_sub_grs[2:0]            = ~ex2_grs[2:0] + 3'b1;
assign ex2_sub_sel_m1              = |ex2_grs[2:0];
assign ex2_double_sub_r[56:0]      = ex2_sub_sel_m1 ? {~ex2_double_pipe_add1_rslt[53:0],ex2_sub_grs[2:0]}
                                                    : {~ex2_double_pipe_add2_rslt[53:0],3'b0};
assign ex2_double_sub_inc2_r[56:0] = {~ex2_double_pipe_add2_rslt[53:0],ex2_sub_grs[2:0]};
assign ex2_double_sub_inc1_r[56:0] = ex2_sub_grs[2] ? {ex2_double_sub_inc2_r[56:3],1'b0,ex2_double_sub_inc2_r[1:0]}
                                                    : ex2_double_sub_r[56:0] | 57'd4;

assign ex2_double_b_sub_a_r[53:0]  = ex2_double_pipe_add1_rslt[53:0];

// the single result
// 
assign ex2_single0_add_r[27:0]      = ex2_double_add_r[27:0];
//
assign ex2_single0_sub_r[27:0]      = ex2_double_sub_r[27:0];
//
assign ex2_half0_add_r[14:0]        = ex2_double_add_r[14:0];
//
assign ex2_half0_sub_r[14:0]        = ex2_double_sub_r[14:0];

//
assign ex2_bhalf0_add_r[11:0]       = ex2_double_add_r[11:0];
//
assign ex2_bhalf0_sub_r[11:0]       = ex2_double_sub_r[11:0];

// sub inc1: sub001: a-b+4
//           sub01: a-b+8 


//assign ex2_adder2_r[56:0] = ~ex2_adder0_r[56:0];
assign ex2_sub_neg          = ex2_double && ~ex2_double_pipe_add2_rslt[53]  ||
                              ex2_single && ~ex2_double_pipe_add2_rslt[24] ||
                              ex2_half   && ~ex2_double_pipe_add2_rslt[11]   ||
                              ex2_bhalf  && ~ex2_double_pipe_add2_rslt[8];

// the  e difference minus  result
// using the double result into the shift will not make any error
assign ex2_adder_sub_r[53:0] = ex2_sub_neg ? ex2_double_b_sub_a_r[53:0] : ~ex2_double_pipe_add2_rslt[53:0];


// &Instance("aq_fadd_lop_s1_sb","x_aq_fadd_lop_s1_s_b"); @718
aq_fadd_lop_s1_sb  x_aq_fadd_lop_s1_s_b (
  .act_sub           (ex2_act_sub      ),
  .ff1_mask          (ex2_e_onehot_mask),
  .ff1_pred_bh       (ff1_pred_bh_b    ),
  .ff1_pred_d        (ff1_pred_d_b     ),
  .ff1_pred_h        (ff1_pred_h_b     ),
  .ff1_pred_s        (ff1_pred_s_b     ),
  .src0_adder        (ex2_lop_src0     ),
  .src1_adder        (ex2_lop_src1     )
);

// &Connect( @719
//           .src0_adder        (ex2_lop_src0       ), @720
//           .src1_adder        (ex2_lop_src1       ), @721
//           .ff1_mask          (ex2_e_onehot_mask  ), @722
//           .ff1_pred_d        (ff1_pred_d_b       ), @723
//           .ff1_pred_s        (ff1_pred_s_b       ), @724
//           .ff1_pred_h        (ff1_pred_h_b       ), @725
//           .ff1_pred_bh       (ff1_pred_bh_b      ), @726
//           .act_sub           (ex2_act_sub        ) @727
//         );     @728



assign left_shift_cnt[5:0]       = {6{ex2_single || ex2_double}} & {1'b0,ff1_pred_s_b[4:0]} |
                                   {6{ex2_half}}   & {1'b0,ff1_pred_h_b[4:0]} |
                                   {6{ex2_bhalf}}  & {1'b0,ff1_pred_bh_b[4:0]};

assign ex2_double_e_adjust[5:0]  = ff1_pred_d_b[5:0];
assign ex2_e_adjust_pre[5:0]     = left_shift_cnt[5:0];
assign ex2_both_dn_widden_add    = ex2_both_dn_n_widden && ex2_act_add;
assign sub000_shift_value[27:0]  = ex2_both_dn_widden_add ? ex2_single0_add_r[27:0] : 
                                   ex2_e_diff_0 ? {ex2_adder_sub_r[24:0],3'b0} :  ex2_single0_sub_r[27:0];

// the shift logic will deal with the following situation:                                 
// 1. when both denormal dest widden add,
// 2. the expnt diff 1 result
// 3. the expnt diff 0 result                                    
// &Instance("aq_fadd_shift_sub_single","x_aq_fadd_shift_sub"); @746
aq_fadd_shift_sub_single  x_aq_fadd_shift_sub (
  .data_in                  (sub000_shift_value[27:0]),
  .data_out                 (ex2_sub_r_shift_t       ),
  .shift_cnt                (left_shift_cnt[4:0]     )
);

// &Connect( @747
//           .data_in           (sub000_shift_value[27:0]    ), @748
//           .shift_cnt         (left_shift_cnt[4:0]         ), @749
//           .data_out          (ex2_sub_r_shift_t           ) @750
//         ); @751
assign ex2_sub_r_shift[27:0]  = {ex2_sub_r_shift_t[27:0]};

assign ex2_dest_widden = 1'b0;

assign ex2_both_dn_n_widden    = ex2_both_dn && ex2_dest_widden;
assign ex2_both_dn_no_widden   = ex2_both_dn && !ex2_dest_widden;

assign ex2_no_dn_no_widden     = !ex2_both_dn;
// in the second stage, the round are handled in paraell
// the rounding preparation logic
//
//
// Merge all round mode to one, because g/r/s is accurate
assign ex2_r_add1xxxx = ex2_act_add && (
                        ex2_double && ex2_double_add_r[56]  ||
                        ex2_single && ex2_single0_add_r[27] ||
                        ex2_half   && ex2_half0_add_r[14]   ||
                        ex2_bhalf  && ex2_bhalf0_add_r[11] || ex2_both_dn_no_widden);
assign ex2_r_add01xxx = ex2_act_add && (
                        ex2_double && !ex2_double_add_r[56]  ||
                        ex2_single && !ex2_single0_add_r[27] ||
                        ex2_half   && !ex2_half0_add_r[14]   ||
                        ex2_bhalf  && !ex2_bhalf0_add_r[11]) && ex2_no_dn_no_widden;
assign ex2_sub_1      = ex2_single && ex2_single0_sub_r[26] ||
                        ex2_double && ex2_double_sub_r[55]  ||
                        ex2_half   && ex2_half0_sub_r[13]   ||
                        ex2_bhalf  && ex2_bhalf0_sub_r[10];

assign ex2_r_sub01xxx = ex2_act_sub &&((ex2_sub_1 && !ex2_src0_e_eq_0&& !ex2_e_diff_0)  || ex2_both_dn_no_widden);
assign ex2_r_sub000xx = ex2_op_no_sel && (ex2_e_diff_1 && !ex2_sub_1 || ex2_e_diff_0) && !ex2_both_dn_no_widden;
assign ex2_r_sel000xx                  = ex2_r_sub000xx || ex2_act_add && ex2_both_dn_n_widden && !ex2_single0_add_r[27];
assign ex2_double_sub000xx_rslt[53:0]  = ex2_e_diff_1 ? ex2_double_sub_r[55:2] : {ex2_adder_sub_r[52:0],1'b0};
assign ex2_rst_shift                   = ex2_r_sub000xx
                                         || ex2_both_dn_n_widden && ex2_act_add && !ex2_single0_add_r[27];
assign ex2_r_sub001xx = ex2_act_sub && !ex2_r_sub000xx && !ex2_r_sub01xxx;

assign ex2_single0_sub000xx_rslt[24:0] = ex2_sub_r_shift[26:2];
assign ex2_half0_sub000xx_rslt[11:0]   = ex2_sub_r_shift[13:2];
assign ex2_bhalf0_sub000xx_rslt[8:0]   = ex2_sub_r_shift[10:2];


// the round logical
// &Instance("aq_fadd_double_round"); @808
aq_fadd_double_round  x_aq_fadd_double_round (
  .ex2_act_s                 (ex2_act_s                ),
  .ex2_adder_sub_r           (ex2_adder_sub_r          ),
  .ex2_bhalf0_addsub_rslt    (ex2_bhalf0_addsub_rslt   ),
  .ex2_bhalf0_sub000xx_rslt  (ex2_bhalf0_sub000xx_rslt ),
  .ex2_both_dn_no_widden     (ex2_both_dn_no_widden    ),
  .ex2_double_add_inc1_r     (ex2_double_add_inc1_r    ),
  .ex2_double_add_inc2_r     (ex2_double_add_inc2_r    ),
  .ex2_double_add_r          (ex2_double_add_r         ),
  .ex2_double_addsub_rslt    (ex2_double_addsub_rslt   ),
  .ex2_double_sub000xx_rslt  (ex2_double_sub000xx_rslt ),
  .ex2_double_sub_inc1_r     (ex2_double_sub_inc1_r    ),
  .ex2_double_sub_inc2_r     (ex2_double_sub_inc2_r    ),
  .ex2_double_sub_r          (ex2_double_sub_r         ),
  .ex2_half0_addsub_rslt     (ex2_half0_addsub_rslt    ),
  .ex2_half0_sub000xx_rslt   (ex2_half0_sub000xx_rslt  ),
  .ex2_nx                    (ex2_nx                   ),
  .ex2_r_add01xxx            (ex2_r_add01xxx           ),
  .ex2_r_add1xxxx            (ex2_r_add1xxxx           ),
  .ex2_r_sel000xx            (ex2_r_sel000xx           ),
  .ex2_r_sub000xx            (ex2_r_sub000xx           ),
  .ex2_r_sub001xx            (ex2_r_sub001xx           ),
  .ex2_r_sub01xxx            (ex2_r_sub01xxx           ),
  .ex2_rdn                   (ex2_rdn                  ),
  .ex2_rmm                   (ex2_rmm                  ),
  .ex2_rne                   (ex2_rne                  ),
  .ex2_rtz                   (ex2_rtz                  ),
  .ex2_rup                   (ex2_rup                  ),
  .ex2_single0_addsub_rslt   (ex2_single0_addsub_rslt  ),
  .ex2_single0_sub000xx_rslt (ex2_single0_sub000xx_rslt),
  .ex2_special_value_vld     (ex2_special_value_vld    )
);

//=================================================
//  the exponent calculation is this stage
//=================================================
// for the single and half the expnt will be calculated in this stage
//
assign ex2_widden_potnt_sub000 = ex2_dest_widden && (ex2_e_diff_1 && !ex2_single0_sub_r[26] || ex2_e_diff_0);
assign ex2_e_add_op1[10:0]    = ex2_dest_widden ? 11'd112 : 11'h0;
assign ex2_e_add_op2[10:0]    = ex2_widden_potnt_sub000 
                                || !ex2_dest_widden ? {5'b0,ex2_e_adjust_pre[5:0]}
                                                    : 11'h0;

assign ex2_single_half_e_add_rslt[10:0]   = ex2_src0_e[10:0] + ex2_e_add_op1[10:0] - ex2_e_add_op2[10:0];

assign ex2_single_half_e_rslt[10:0]       = ex2_r_sub000xx  ? ex2_single_half_e_add_rslt[10:0] :
                                            ex2_dest_widden ? ex2_single_half_e_add_rslt[10:0] 
                                                            : ex2_src0_e[10:0];

assign ex2_double_add_op1[10:0]           = ex2_r_sel000xx ? {5'b0,ex2_double_e_adjust[5:0]}
                                                           : 11'b0;
assign ex2_double_add_op2[10:0]           = 11'b0;
assign ex2_double_e_add_rslt[10:0]        = ex2_src0_e[10:0] - ex2_double_add_op1[10:0] + ex2_double_add_op2[10:0];
assign ex2_e_add_rslt[10:0]               = ex2_double ? ex2_double_e_add_rslt[10:0]
                                                       : ex2_single_half_e_rslt[10:0];



//------------------------------------------------------------------------------
//                         
//------------------------------------------------------------------------------
//EX2: generate cmp sel instruction result and special add/sub result

assign ex2_act_s = ex2_act_sub && !ex2_src_chg && ex2_sub_neg && ex2_e_diff_0 ? !ex2_act_s_tmp : ex2_act_s_tmp;

assign add_cmp_act_s = ex2_act_s;

// &Force("output","ex2_act_s"); @848





always @(posedge fadd_ex2_nocmp_pipe_clk)
begin
  if(fadd_ex2_nocmp_pipedown  && ex2_nocmp_nosel || ifu_vpu_warm_up) begin
    ex3_e_adjust[5:0]          <= ex2_double_e_adjust[5:0];
  end
end

always @(posedge fadd_ex2_nocmp_pipe_clk)
begin
  if(fadd_ex2_nocmp_pipedown) begin
//    ex3_data[56:0]   <= ex2_final_rst[56:0];
//    ex3_org_e[10:0]  <= ex2_org_e[10:0];
    ex3_both_dn      <= ex2_both_dn_no_widden;
    ex3_both_zero    <= ex2_both_zero;
    ex3_src_equal    <= ex2_src0_eq_src1;
    ex3_r_0_sign     <= ex2_r_0_sign;
    ex3_rst_shift    <= ex2_rst_shift;
    ex3_nx           <= ex2_nx;
    ex3_act_sub      <= ex2_act_sub;
  end
end


//------------------------------------------------------------------------------
//                     EX3 pipe    
//------------------------------------------------------------------------------
assign ex3_double_result_f[53:0]  = ex3_double_result[53:0];
//assign ex3_single0_result_f[24:0] = 

// &Instance("aq_fadd_shift_sub_h_double","x_aq_fadd_shift_sub_h"); @886
aq_fadd_shift_sub_h_double  x_aq_fadd_shift_sub_h (
  .data_in             (ex3_double_result_f),
  .data_out            (ex3_sub_rst_shift  ),
  .shift_cnt           (ex3_e_adjust       )
);

// &Connect( @887
//           .data_in           (ex3_double_result_f  ), @888
//           .shift_cnt         (ex3_e_adjust         ), @889
//           .data_out          (ex3_sub_rst_shift    ) @890
//         ); @891
assign ex3_double_sub_rst[53:0] = {ex3_sub_rst_shift[53:0]};


assign ex3_double_dn                = ex3_org_e[10:0] == 11'b1;
assign ex3_double_sub000xx_f[51:0]  = (ex3_double_sub_rst[53] || ex3_double_dn)  ? ex3_double_sub_rst[52:1]
                                                                                 : ex3_double_sub_rst[51:0];
                                                             
assign ex3_norm_double_f[51:0]      = ex3_both_dn || ex3_double_result_f[53] ? ex3_double_result_f[52:1]
                                                                             : ex3_double_result_f[51:0];
assign ex3_r_sub000xx               = ex3_rst_shift;
assign ex3_double_f[51:0]           = ex3_r_sub000xx ? ex3_double_sub000xx_f[51:0]
                                                     : ex3_norm_double_f[51:0];
assign ex3_single0_f[22:0]          = ex3_both_dn || ex3_single0_result[24]||ex3_to_dn ? ex3_single0_result[23:1]
                                                             : ex3_single0_result[22:0];
assign ex3_half0_f[9:0]             = ex3_both_dn || ex3_half0_result[11]||ex3_to_dn ? ex3_single0_result[10:1]
                                                             : ex3_single0_result[9:0];
assign ex3_bhalf0_f[6:0]            = ex3_both_dn || ex3_half0_result[8]||ex3_to_dn ? ex3_single0_result[7:1]
                                                             : ex3_single0_result[6:0];

assign ex3_to_dn                    = (ex3_org_e[10:0] == 11'b1) && ex3_e_sel_adder && ex3_act_sub;

//assign ex3_shift_one     = !ex3_shift_max && !ex3_sub_rst[55];
assign ex3_act_add                  = !ex3_act_sub;




assign ex3_e_max                    = !ex3_org_e[0] && (ex3_double && &ex3_org_e[10:1] ||
                                                        ex3_single && &ex3_org_e[7:1]  ||
                                                        ex3_half   && &ex3_org_e[4:1]  ||
                                                        ex3_bhalf  && &ex3_org_e[7:1]);
//expnt adjustment
assign ex3_e_addr_src1[11:0] = ex3_act_sub || ex3_rst_shift ? 12'b1 : 12'hfff;

assign ex3_e_tmp_0[11:0]     = {1'b0, ex3_org_e[10:0]} - ex3_e_addr_src1[11:0];

assign ex3_e_sel_adder       = ex3_single && ((ex3_act_sub || ex3_rst_shift) && !ex3_single0_result[24] || !ex3_act_sub && !ex3_rst_shift && ex3_single0_result[24]) ||
                               ex3_half  && (ex3_act_sub && !ex3_half0_result[11] || !ex3_act_sub && ex3_half0_result[11])     ||
                               ex3_bhalf && (ex3_act_sub && !ex3_bhalf0_result[8] ||!ex3_act_sub &&  ex3_bhalf0_result[8]);

assign ex3_no_d_norm_e[10:0]     = ex3_both_dn&& ex3_act_sub ? 11'b0 : ex3_e_sel_adder ? ex3_e_tmp_0[10:0] : ex3_org_e[10:0];

assign ex3_d_sel_adder           = ex3_double && ( ex3_rst_shift && !ex3_double_sub_rst[53] ||
                                                   ex3_act_sub && !ex3_rst_shift && !ex3_double_result[53]  || 
                                                  !ex3_act_sub && !ex3_rst_shift && ex3_double_result[53]);
assign ex3_d_norm_e[10:0]        = ex3_both_dn&& ex3_act_sub ? 11'b0 : ex3_d_sel_adder ? ex3_e_tmp_0[10:0] : ex3_org_e[10:0];

//------------------------------------------------------------------------------
//                              Expt Result:
//------------------------------------------------------------------------------

assign add_cin     = ex3_double && ex3_double_result[53]  || 
                     ex3_single && ex3_single0_result[24] ||
                     ex3_half   && ex3_half0_result[11]   ||
                     ex3_bhalf  && ex3_bhalf0_result[8];
assign ex3_expt_of = ex3_act_add && ex3_e_max && add_cin && !ex3_expt_mask;
//assign ex3_nx      = (ex3_r_add1xxxx || ex3_r_add01xxx || ex3_r_sub01xxx || ex3_r_sub001xx) &&
//                     (ex3_round_g || ex3_round_r || ex3_round_s);
assign ex3_expt_nx = ex3_expt_of  || ex3_nx && !ex3_nv && !ex3_expt_mask;

//------------------------------------------------------------------------------
//                             Special Result :
//------------------------------------------------------------------------------
assign ex3_r_lfn_sel = ex3_rtz || ex3_rup && ex3_act_s || ex3_rdn && !ex3_act_s;
assign ex3_r_lfn     = ex3_r_lfn_sel && ex3_expt_of;
assign ex3_r_inf     = ex3_expt_of && !ex3_r_lfn_sel;
assign ex3_r_0       = (ex3_both_zero || ex3_src_equal && ex3_act_sub ) && !ex3_special_n_op_sel;
//------------------------------------------------------------------------------
//                             Final Result Merge:
//------------------------------------------------------------------------------
// &CombBeg; @962
always @( ex3_r_inf
       or ex3_act_s
       or ex3_r_0_sign
       or ex3_d_norm_e[10:0]
       or ex3_special_n_op_sel
       or ex3_org_e[10:0]
       or ex3_r_lfn
       or ex3_r_0
       or ex3_double_f[51:0]
       or ex3_double_result[51:0])
begin
  case({ex3_special_n_op_sel,ex3_r_inf,ex3_r_lfn,ex3_r_0})
  4'b1000: fadd_ex3_double_rslt[63:0] = {ex3_act_s, ex3_org_e[10:0], ex3_double_result[51:0]};
  4'b0100: fadd_ex3_double_rslt[63:0] = {              ex3_act_s, {11{1'b1}}, 52'b0};
  4'b0010: fadd_ex3_double_rslt[63:0] = {              ex3_act_s, {{10{1'b1}},1'b0}, {52{1'b1}}};
  4'b0001: fadd_ex3_double_rslt[63:0] = {              ex3_r_0_sign, 11'b0, 52'b0};
  default: fadd_ex3_double_rslt[63:0] = {ex3_act_s, ex3_d_norm_e[10:0], ex3_double_f[51:0]};
endcase
// &CombEnd; @970
end

// &CombBeg; @972
always @( ex3_r_inf
       or ex3_act_s
       or ex3_org_e[7:0]
       or ex3_r_0_sign
       or ex3_special_n_op_sel
       or ex3_single0_f[22:0]
       or ex3_r_lfn
       or ex3_r_0
       or ex3_no_d_norm_e[7:0]
       or ex3_single0_result[22:0])
begin
  case({ex3_special_n_op_sel,ex3_r_inf,ex3_r_lfn,ex3_r_0})
  4'b1000: fadd_ex3_single0_rslt[63:0] = {{32{1'b1}},ex3_act_s, ex3_org_e[7:0], ex3_single0_result[22:0]};
  4'b0100: fadd_ex3_single0_rslt[63:0] = {{32{1'b1}},           ex3_act_s, {8{1'b1}}, 23'b0};
  4'b0010: fadd_ex3_single0_rslt[63:0] = {{32{1'b1}},           ex3_act_s, {{7{1'b1}},1'b0}, {23{1'b1}}};
  4'b0001: fadd_ex3_single0_rslt[63:0] = {{32{1'b1}},           ex3_r_0_sign, 8'b0, 23'b0};
  default: fadd_ex3_single0_rslt[63:0] = {{32{1'b1}},ex3_act_s, ex3_no_d_norm_e[7:0], ex3_single0_f[22:0]};
endcase
// &CombEnd; @980
end

// &CombBeg; @982
always @( ex3_r_inf
       or ex3_half0_f[9:0]
       or ex3_act_s
       or ex3_r_0_sign
       or ex3_no_d_norm_e[4:0]
       or ex3_special_n_op_sel
       or ex3_r_lfn
       or ex3_r_0
       or ex3_org_e[4:0]
       or ex3_half0_result[9:0])
begin
  case({ex3_special_n_op_sel,ex3_r_inf,ex3_r_lfn,ex3_r_0})
  4'b1000: fadd_ex3_half0_rslt[63:0] = {{48{1'b1}},ex3_act_s, ex3_org_e[4:0], ex3_half0_result[9:0]};
  4'b0100: fadd_ex3_half0_rslt[63:0] = {{48{1'b1}},           ex3_act_s, {5{1'b1}}, 10'b0};
  4'b0010: fadd_ex3_half0_rslt[63:0] = {{48{1'b1}},           ex3_act_s, {{4{1'b1}},1'b0}, {10{1'b1}}};
  4'b0001: fadd_ex3_half0_rslt[63:0] = {{48{1'b1}},           ex3_r_0_sign, 5'b0, 10'b0};
  default: fadd_ex3_half0_rslt[63:0] = {{48{1'b1}},ex3_act_s, ex3_no_d_norm_e[4:0], ex3_half0_f[9:0]};
endcase
// &CombEnd; @990
end

// &CombBeg; @992
always @( ex3_r_inf
       or ex3_act_s
       or ex3_org_e[7:0]
       or ex3_r_0_sign
       or ex3_special_n_op_sel
       or ex3_bhalf0_f[6:0]
       or ex3_bhalf0_result[6:0]
       or ex3_r_lfn
       or ex3_r_0
       or ex3_no_d_norm_e[7:0])
begin
  case({ex3_special_n_op_sel,ex3_r_inf,ex3_r_lfn,ex3_r_0})
  4'b1000: fadd_ex3_bhalf0_rslt[63:0] = {{48{1'b1}},ex3_act_s, ex3_org_e[7:0], ex3_bhalf0_result[6:0]};
  4'b0100: fadd_ex3_bhalf0_rslt[63:0] = {{48{1'b1}},              ex3_act_s, {8{1'b1}}, 7'b0};
  4'b0010: fadd_ex3_bhalf0_rslt[63:0] = {{48{1'b1}},              ex3_act_s, {{7{1'b1}},1'b0}, {7{1'b1}}};
  4'b0001: fadd_ex3_bhalf0_rslt[63:0] = {{48{1'b1}},              ex3_r_0_sign, 8'b0, 7'b0};
  default: fadd_ex3_bhalf0_rslt[63:0] = {{48{1'b1}},ex3_act_s, ex3_no_d_norm_e[7:0], ex3_bhalf0_f[6:0]};
endcase
// &CombEnd; @1000
end


assign double_pipe_ex3_expt[4:0]     = {ex3_nv, 1'b0, ex3_expt_of, 1'b0, ex3_expt_nx} &
                                       {2'b11,{3{~ex3_op_sel}}}                       &
                                       {2'b11,{3{~ex3_op_cmp}}};

// &ModuleEnd; @1007
endmodule


