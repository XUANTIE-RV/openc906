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

// &ModuleBeg; @27
module aq_fcnvt_double(
  bhalf0_final_frac,
  cp0_vpu_xx_dqnan,
  double_final_frac,
  double_pipe_bhtod_value,
  double_pipe_bhtox_expnt,
  double_pipe_ex1_special_vld,
  double_pipe_ex1_src_cnan,
  double_pipe_ex1_src_inf,
  double_pipe_ex1_src_qnan,
  double_pipe_ex1_src_snan,
  double_pipe_ex1_src_zero,
  double_pipe_ex2_expt,
  double_pipe_ex2_frac,
  double_pipe_ex2_int,
  double_pipe_ex2_widden_dn_itof_expnt,
  double_pipe_ftoi_int,
  double_pipe_htox_expnt,
  double_pipe_htox_value,
  double_pipe_special_value,
  double_pipe_src_dn,
  double_pipe_stod_expnt,
  double_pipe_stod_value,
  ex1_dest_bhalf,
  ex1_dest_float,
  ex1_dest_half,
  ex1_dest_si,
  ex1_dest_single,
  ex1_double_src,
  ex1_half0_src,
  ex1_l8_0_src,
  ex1_op_bhtod,
  ex1_op_bhtos,
  ex1_op_dtobh,
  ex1_op_dtoh,
  ex1_op_dtos,
  ex1_op_ftoi,
  ex1_op_htod,
  ex1_op_htos,
  ex1_op_stobh,
  ex1_op_stod,
  ex1_op_stoh,
  ex1_single0_src,
  ex1_src_bhalf,
  ex1_src_double,
  ex1_src_float,
  ex1_src_half,
  ex1_src_i,
  ex1_src_l16,
  ex1_src_l32,
  ex1_src_l64,
  ex1_src_l8,
  ex1_src_si,
  ex1_src_single,
  ex2_bh_quod_up,
  ex2_bhalf0_orig_frac,
  ex2_dest_bhalf,
  ex2_dest_double,
  ex2_dest_float,
  ex2_dest_half,
  ex2_dest_l16,
  ex2_dest_l32,
  ex2_dest_l64,
  ex2_dest_l8,
  ex2_dest_si,
  ex2_dest_single,
  ex2_double_orig_frac,
  ex2_h_quod_up,
  ex2_half0_orig_frac,
  ex2_int16_0_result,
  ex2_int32_0_result,
  ex2_int64_result,
  ex2_l16_0_result,
  ex2_l32_0_result,
  ex2_l8_0_result,
  ex2_narrow,
  ex2_op_itof,
  ex2_quod_dn,
  ex2_single0_orig_frac,
  ex2_src_l16,
  ex2_src_l32,
  ex2_src_l64,
  ex2_widden,
  ex3_double_result,
  fcnvt_ex1_pipe_clk,
  fcnvt_ex1_pipedown,
  fcnvt_ex2_pipe_double_clk,
  fcnvt_ex2_pipedown,
  half0_final_frac,
  l16_0_itof_value,
  l32_0_itof_value,
  l64_itof_value,
  single0_final_frac,
  vpu_group_1_xx_ex2_rm
);

// &Ports; @28
input           cp0_vpu_xx_dqnan;                    
input   [5 :0]  double_pipe_bhtod_value;             
input   [4 :0]  double_pipe_bhtox_expnt;             
input           double_pipe_ex1_src_cnan;            
input           double_pipe_ex1_src_inf;             
input           double_pipe_ex1_src_qnan;            
input           double_pipe_ex1_src_snan;            
input           double_pipe_ex1_src_zero;            
input   [63:0]  double_pipe_ex2_frac;                
input   [63:0]  double_pipe_ex2_int;                 
input   [5 :0]  double_pipe_ex2_widden_dn_itof_expnt; 
input   [4 :0]  double_pipe_htox_expnt;              
input   [8 :0]  double_pipe_htox_value;              
input   [63:0]  double_pipe_special_value;           
input           double_pipe_src_dn;                  
input   [4 :0]  double_pipe_stod_expnt;              
input   [21:0]  double_pipe_stod_value;              
input           ex1_dest_bhalf;                      
input           ex1_dest_float;                      
input           ex1_dest_half;                       
input           ex1_dest_si;                         
input           ex1_dest_single;                     
input   [63:0]  ex1_double_src;                      
input   [15:0]  ex1_half0_src;                       
input   [7 :0]  ex1_l8_0_src;                        
input           ex1_op_bhtod;                        
input           ex1_op_bhtos;                        
input           ex1_op_dtobh;                        
input           ex1_op_dtoh;                         
input           ex1_op_dtos;                         
input           ex1_op_ftoi;                         
input           ex1_op_htod;                         
input           ex1_op_htos;                         
input           ex1_op_stobh;                        
input           ex1_op_stod;                         
input           ex1_op_stoh;                         
input   [31:0]  ex1_single0_src;                     
input           ex1_src_bhalf;                       
input           ex1_src_double;                      
input           ex1_src_float;                       
input           ex1_src_half;                        
input           ex1_src_i;                           
input           ex1_src_l16;                         
input           ex1_src_l32;                         
input           ex1_src_l64;                         
input           ex1_src_l8;                          
input           ex1_src_si;                          
input           ex1_src_single;                      
input           ex2_bh_quod_up;                      
input   [6 :0]  ex2_bhalf0_orig_frac;                
input           ex2_dest_bhalf;                      
input           ex2_dest_double;                     
input           ex2_dest_float;                      
input           ex2_dest_half;                       
input           ex2_dest_l16;                        
input           ex2_dest_l32;                        
input           ex2_dest_l64;                        
input           ex2_dest_l8;                         
input           ex2_dest_si;                         
input           ex2_dest_single;                     
input   [51:0]  ex2_double_orig_frac;                
input           ex2_h_quod_up;                       
input   [9 :0]  ex2_half0_orig_frac;                 
input           ex2_narrow;                          
input           ex2_op_itof;                         
input           ex2_quod_dn;                         
input   [22:0]  ex2_single0_orig_frac;               
input           ex2_src_l16;                         
input           ex2_src_l32;                         
input           ex2_src_l64;                         
input           ex2_widden;                          
input           fcnvt_ex1_pipe_clk;                  
input           fcnvt_ex1_pipedown;                  
input           fcnvt_ex2_pipe_double_clk;           
input           fcnvt_ex2_pipedown;                  
input   [15:0]  l16_0_itof_value;                    
input   [31:0]  l32_0_itof_value;                    
input   [63:0]  l64_itof_value;                      
input   [2 :0]  vpu_group_1_xx_ex2_rm;               
output  [15:0]  bhalf0_final_frac;                   
output  [63:0]  double_final_frac;                   
output          double_pipe_ex1_special_vld;         
output  [3 :0]  double_pipe_ex2_expt;                
output  [63:0]  double_pipe_ftoi_int;                
output  [63:0]  ex2_int16_0_result;                  
output  [63:0]  ex2_int32_0_result;                  
output  [63:0]  ex2_int64_result;                    
output  [63:0]  ex2_l16_0_result;                    
output  [63:0]  ex2_l32_0_result;                    
output  [7 :0]  ex2_l8_0_result;                     
output  [63:0]  ex3_double_result;                   
output  [15:0]  half0_final_frac;                    
output  [31:0]  single0_final_frac;                  

// &Regs; @29
reg     [10:0]  ex1_special_sel_1;                   
reg     [2 :0]  ex1_special_sel_2;                   
reg     [63:0]  ex2_bhalf_result;                    
reg     [11:0]  ex2_eadder_bias;                     
reg     [11:0]  ex2_eadder_bias1;                    
reg     [11:0]  ex2_exp;                             
reg     [63:0]  ex2_half_result;                     
reg             ex2_narrow_dn;                       
reg             ex2_nv;                              
reg             ex2_sign;                            
reg     [63:0]  ex2_single_result;                   
reg     [1 :0]  ex2_special_int;                     
reg             ex2_special_vld_flop;                
reg             ex2_src_is_0;                        
reg     [56:0]  ex2_tail;                            
reg             ex2_widden_quod_up_dn;               
reg     [63:0]  ex3_double_result;                   

// &Wires; @30
wire    [15:0]  bhalf0_final_frac;                   
wire    [15:0]  bhalf0_special_result;               
wire            bhalf_expnt_add;                     
wire            bhalf_norm_f_all_1;                  
wire            cp0_vpu_xx_dqnan;                    
wire            double_expnt_add;                    
wire    [63:0]  double_final_frac;                   
wire            double_norm_f_all_1;                 
wire    [5 :0]  double_pipe_bhtod_value;             
wire    [4 :0]  double_pipe_bhtox_expnt;             
wire            double_pipe_ex1_special_vld;         
wire            double_pipe_ex1_src_cnan;            
wire            double_pipe_ex1_src_inf;             
wire            double_pipe_ex1_src_qnan;            
wire            double_pipe_ex1_src_snan;            
wire            double_pipe_ex1_src_zero;            
wire    [52:0]  double_pipe_ex2_cmb_frac;            
wire    [3 :0]  double_pipe_ex2_expt;                
wire    [63:0]  double_pipe_ex2_frac;                
wire    [63:0]  double_pipe_ex2_int;                 
wire    [5 :0]  double_pipe_ex2_widden_dn_itof_expnt; 
wire    [63:0]  double_pipe_ftoi_int;                
wire    [4 :0]  double_pipe_htox_expnt;              
wire    [8 :0]  double_pipe_htox_value;              
wire    [63:0]  double_pipe_special_value;           
wire            double_pipe_src_dn;                  
wire    [4 :0]  double_pipe_stod_expnt;              
wire    [21:0]  double_pipe_stod_value;              
wire    [63:0]  double_special_result;               
wire    [6 :0]  ex1_bhalf_f;                         
wire    [7 :0]  ex1_bhalf_final_frac;                
wire            ex1_bhalf_quod_dn;                   
wire    [11:0]  ex1_bhalf_quod_e;                    
wire    [52:0]  ex1_bhalf_quod_f;                    
wire    [63:0]  ex1_bhalf_special;                   
wire    [63:0]  ex1_bhalf_special_0;                 
wire    [63:0]  ex1_bhalf_special_cnan;              
wire    [63:0]  ex1_bhalf_special_inf;               
wire    [63:0]  ex1_bhalf_special_qnan;              
wire    [23:0]  ex1_bhalf_widden_f;                  
wire            ex1_dest_bhalf;                      
wire            ex1_dest_float;                      
wire            ex1_dest_half;                       
wire            ex1_dest_si;                         
wire            ex1_dest_single;                     
wire    [10:0]  ex1_double_e;                        
wire    [51:0]  ex1_double_f;                        
wire    [52:0]  ex1_double_final_frac;               
wire            ex1_double_narrow_dn;                
wire    [56:0]  ex1_double_narrow_dn_t;              
wire    [23:0]  ex1_double_narrow_frac;              
wire    [23:0]  ex1_double_narrow_frac_t;            
wire    [56:0]  ex1_double_narrow_tail;              
wire    [7 :0]  ex1_double_quod_bhalf_frac;          
wire    [56:0]  ex1_double_quod_bhalf_tail;          
wire            ex1_double_quod_dn;                  
wire    [56:0]  ex1_double_quod_dn_t;                
wire    [10:0]  ex1_double_quod_frac_t;              
wire    [10:0]  ex1_double_quod_half_frac;           
wire    [56:0]  ex1_double_quod_half_tail;           
wire    [63:0]  ex1_double_special;                  
wire    [63:0]  ex1_double_special_0;                
wire    [63:0]  ex1_double_special_cnan;             
wire    [63:0]  ex1_double_special_inf;              
wire    [63:0]  ex1_double_special_qnan;             
wire    [63:0]  ex1_double_src;                      
wire    [23:0]  ex1_dtos_sh_f_v;                     
wire    [53:0]  ex1_dtos_sh_f_x;                     
wire    [11:0]  ex1_e_without_bias;                  
wire    [11:0]  ex1_exp_bias;                        
wire            ex1_final_double_narrow_dn;          
wire    [11:0]  ex1_final_exp;                       
wire            ex1_final_sign;                      
wire    [56:0]  ex1_final_tail;                      
wire    [56:0]  ex1_final_tail_t;                    
wire            ex1_float_s;                         
wire    [63:0]  ex1_fsh_i_v_nm;                      
wire    [53:0]  ex1_fsh_i_x_nm;                      
wire    [63:0]  ex1_ftoi_0;                          
wire    [63:0]  ex1_ftoi_int;                        
wire    [53:0]  ex1_ftoi_int_tail;                   
wire    [63:0]  ex1_ftoi_max;                        
wire    [63:0]  ex1_ftoi_min;                        
wire    [63:0]  ex1_ftoi_specail;                    
wire    [52:0]  ex1_ftoi_trans;                      
wire    [63:0]  ex1_ftosi_max;                       
wire    [63:0]  ex1_ftosi_min;                       
wire    [63:0]  ex1_ftoui_max;                       
wire    [63:0]  ex1_ftoui_min;                       
wire    [15:0]  ex1_half0_src;                       
wire    [9 :0]  ex1_half_f;                          
wire    [10:0]  ex1_half_final_frac;                 
wire            ex1_half_quod_dn;                    
wire    [11:0]  ex1_half_quod_e;                     
wire    [52:0]  ex1_half_quod_f;                     
wire    [63:0]  ex1_half_special;                    
wire    [63:0]  ex1_half_special_0;                  
wire    [63:0]  ex1_half_special_cnan;               
wire    [63:0]  ex1_half_special_inf;                
wire    [63:0]  ex1_half_special_qnan;               
wire            ex1_half_widden_dn;                  
wire    [11:0]  ex1_half_widden_e;                   
wire    [23:0]  ex1_half_widden_f;                   
wire            ex1_ia_0;                            
wire            ex1_int_s;                           
wire    [7 :0]  ex1_l8_0_src;                        
wire            ex1_nv;                              
wire            ex1_op_bhtod;                        
wire            ex1_op_bhtos;                        
wire            ex1_op_dtobh;                        
wire            ex1_op_dtoh;                         
wire            ex1_op_dtos;                         
wire            ex1_op_ftoi;                         
wire            ex1_op_htod;                         
wire            ex1_op_htos;                         
wire            ex1_op_stobh;                        
wire            ex1_op_stod;                         
wire            ex1_op_stoh;                         
wire    [31:0]  ex1_single0_src;                     
wire            ex1_single_bf_dn;                    
wire    [7 :0]  ex1_single_e;                        
wire    [22:0]  ex1_single_f;                        
wire    [23:0]  ex1_single_final_frac;               
wire    [7 :0]  ex1_single_narrow_bhalf_frac;        
wire    [56:0]  ex1_single_narrow_bhalf_tail;        
wire            ex1_single_narrow_dn;                
wire    [56:0]  ex1_single_narrow_dn_t;              
wire    [10:0]  ex1_single_narrow_frac_t;            
wire    [10:0]  ex1_single_narrow_half_frac;         
wire    [56:0]  ex1_single_narrow_half_tail;         
wire    [63:0]  ex1_single_special;                  
wire    [63:0]  ex1_single_special_0;                
wire    [63:0]  ex1_single_special_cnan;             
wire    [63:0]  ex1_single_special_inf;              
wire    [63:0]  ex1_single_special_qnan;             
wire            ex1_single_widden_dn;                
wire    [11:0]  ex1_single_widden_e;                 
wire    [52:0]  ex1_single_widden_f;                 
wire            ex1_special_f_nv;                    
wire            ex1_special_i_nv;                    
wire            ex1_special_vld;                     
wire            ex1_src_bhalf;                       
wire            ex1_src_dn;                          
wire            ex1_src_double;                      
wire    [10:0]  ex1_src_e;                           
wire    [51:0]  ex1_src_f;                           
wire            ex1_src_f_0;                         
wire            ex1_src_f_cnan;                      
wire            ex1_src_f_inf;                       
wire            ex1_src_f_qnan;                      
wire            ex1_src_f_snan;                      
wire            ex1_src_float;                       
wire            ex1_src_half;                        
wire            ex1_src_i;                           
wire            ex1_src_is_0;                        
wire            ex1_src_l16;                         
wire            ex1_src_l32;                         
wire            ex1_src_l64;                         
wire            ex1_src_l8;                          
wire            ex1_src_s;                           
wire            ex1_src_si;                          
wire            ex1_src_single;                      
wire            ex1_widden_quod_up_dn;               
wire            ex1_widdn_quod;                      
wire    [11:0]  ex1_widdne_quod_e;                   
wire    [51:0]  ex1_xtoh_f;                          
wire    [10:0]  ex1_xtoh_sh_f_v;                     
wire    [53:0]  ex1_xtoh_sh_f_x;                     
wire            ex2_bh_quod_up;                      
wire    [6 :0]  ex2_bhalf0_f;                        
wire    [6 :0]  ex2_bhalf0_orig_f;                   
wire    [6 :0]  ex2_bhalf0_orig_frac;                
wire            ex2_bhalf_expnt_of;                  
wire    [63:0]  ex2_bhalf_norm_result;               
wire            ex2_bhalf_of;                        
wire            ex2_bhalf_uf;                        
wire            ex2_denorm;                          
wire            ex2_dest_bhalf;                      
wire    [55:0]  ex2_dest_bhalf_itof_tail;            
wire            ex2_dest_double;                     
wire    [10:0]  ex2_dest_double_itof_tail;           
wire            ex2_dest_float;                      
wire            ex2_dest_half;                       
wire    [52:0]  ex2_dest_half_itof_tail;             
wire            ex2_dest_l16;                        
wire            ex2_dest_l32;                        
wire            ex2_dest_l64;                        
wire            ex2_dest_l8;                         
wire            ex2_dest_sel_float;                  
wire            ex2_dest_si;                         
wire            ex2_dest_single;                     
wire    [39:0]  ex2_dest_single_itof_tail;           
wire    [11:0]  ex2_double_dn_ebias;                 
wire    [51:0]  ex2_double_f;                        
wire    [63:0]  ex2_double_norm_result;              
wire    [51:0]  ex2_double_orig_f;                   
wire    [51:0]  ex2_double_orig_frac;                
wire    [63:0]  ex2_double_result;                   
wire    [63:0]  ex2_double_special_result;           
wire    [11:0]  ex2_expnt;                           
wire            ex2_expnt_add1;                      
wire    [11:0]  ex2_expnt_src0;                      
wire    [11:0]  ex2_expnt_src1;                      
wire    [3 :0]  ex2_expt;                            
wire            ex2_expt_nv;                         
wire            ex2_expt_nv_f;                       
wire            ex2_expt_nv_i;                       
wire            ex2_expt_nx;                         
wire            ex2_expt_nx_t;                       
wire            ex2_expt_of;                         
wire            ex2_expt_uf;                         
wire    [63:0]  ex2_f16_result;                      
wire    [63:0]  ex2_frac;                            
wire            ex2_frac_lst;                        
wire            ex2_h_quod_up;                       
wire    [9 :0]  ex2_half0_f;                         
wire    [9 :0]  ex2_half0_orig_f;                    
wire    [9 :0]  ex2_half0_orig_frac;                 
wire            ex2_half_expnt_of;                   
wire            ex2_half_norm_expnt_of;              
wire            ex2_half_norm_potnt_of;              
wire    [63:0]  ex2_half_norm_result;                
wire            ex2_half_of;                         
wire            ex2_half_uf;                         
wire    [63:0]  ex2_i16_result;                      
wire    [63:0]  ex2_int;                             
wire    [63:0]  ex2_int16_0_result;                  
wire    [63:0]  ex2_int16_result;                    
wire    [63:0]  ex2_int32_0_result;                  
wire    [63:0]  ex2_int32_result;                    
wire    [63:0]  ex2_int64_result;                    
wire    [7 :0]  ex2_int8_result;                     
wire    [63:0]  ex2_int_for_rnd;                     
wire            ex2_int_lst;                         
wire            ex2_int_max;                         
wire            ex2_int_min;                         
wire    [63:0]  ex2_int_nm_result;                   
wire    [11:0]  ex2_itof_bhalf_bias;                 
wire    [11:0]  ex2_itof_bhalf_bias1;                
wire    [11:0]  ex2_itof_double_bias;                
wire    [11:0]  ex2_itof_double_bias1;               
wire            ex2_itof_h_expnt_of;                 
wire            ex2_itof_h_h_potnt_of;               
wire            ex2_itof_h_potnt_of;                 
wire    [11:0]  ex2_itof_half_bias;                  
wire    [11:0]  ex2_itof_half_bias1;                 
wire            ex2_itof_l_h_expnt_of;               
wire            ex2_itof_l_h_potnt_of;               
wire    [52:0]  ex2_itof_rnd_src0;                   
wire    [55:0]  ex2_itof_tail;                       
wire            ex2_itof_w_h_expnt_of;               
wire            ex2_itof_w_h_potnt_of;               
wire    [63:0]  ex2_l16_0_result;                    
wire    [63:0]  ex2_l32_0_result;                    
wire    [63:0]  ex2_l64_result;                      
wire    [7 :0]  ex2_l8_0_result;                     
wire            ex2_lfn_sel_t;                       
wire            ex2_narrow;                          
wire    [11:0]  ex2_norm_expnt;                      
wire            ex2_op_itof;                         
wire            ex2_quod_dn;                         
wire            ex2_r_inf;                           
wire            ex2_r_lfn;                           
wire            ex2_r_zero;                          
wire            ex2_rm_rdn;                          
wire            ex2_rm_rmm;                          
wire            ex2_rm_rne;                          
wire            ex2_rm_rtz;                          
wire            ex2_rm_rup;                          
wire    [63:0]  ex2_rnd_adder_f_p1;                  
wire    [53:0]  ex2_rnd_adder_f_p1_f;                
wire    [63:0]  ex2_rnd_adder_f_src1;                
wire    [63:0]  ex2_rnd_adder_i_p1;                  
wire    [63:0]  ex2_rnd_adder_i_src0;                
wire            ex2_rnd_lst;                         
wire            ex2_round_add;                       
wire    [15:0]  ex2_si16_result;                     
wire    [31:0]  ex2_si32_result;                     
wire    [63:0]  ex2_si64_result;                     
wire    [7 :0]  ex2_si8_result;                      
wire    [22:0]  ex2_single0_f;                       
wire    [22:0]  ex2_single0_orig_f;                  
wire    [22:0]  ex2_single0_orig_frac;               
wire            ex2_single_expnt_of;                 
wire    [63:0]  ex2_single_norm_result;              
wire            ex2_single_of;                       
wire            ex2_single_uf;                       
wire    [63:0]  ex2_special_n_int_result;            
wire            ex2_special_vld;                     
wire            ex2_src_l16;                         
wire            ex2_src_l32;                         
wire            ex2_src_l64;                         
wire    [56:0]  ex2_tail_lst;                        
wire            ex2_tosi16_neg_exp_crit_of;          
wire            ex2_tosi16_neg_exp_of;               
wire            ex2_tosi16_of;                       
wire            ex2_tosi16_pos_exp_of;               
wire            ex2_tosi16_uf;                       
wire            ex2_tosi64_neg_exp_crit_of;          
wire            ex2_tosi64_neg_exp_of;               
wire            ex2_tosi64_of;                       
wire            ex2_tosi64_pos_exp_of;               
wire            ex2_tosi64_potnt_exp_uf;             
wire            ex2_tosi64_uf;                       
wire            ex2_tosi8_neg_exp_crit_of;           
wire            ex2_tosi8_neg_exp_of;                
wire            ex2_tosi8_of;                        
wire            ex2_tosi8_pos_exp_of;                
wire            ex2_tosi8_uf;                        
wire            ex2_tosi_neg_exp_crit_of;            
wire            ex2_tosi_neg_exp_of;                 
wire            ex2_tosi_of;                         
wire            ex2_tosi_pos_exp_of;                 
wire            ex2_tosi_uf;                         
wire            ex2_toui16_exp_of;                   
wire            ex2_toui16_of;                       
wire            ex2_toui16_uf;                       
wire            ex2_toui64_exp_of;                   
wire            ex2_toui64_of;                       
wire            ex2_toui64_uf;                       
wire            ex2_toui8_exp_of;                    
wire            ex2_toui8_of;                        
wire            ex2_toui8_uf;                        
wire            ex2_toui_exp_of;                     
wire            ex2_toui_of;                         
wire            ex2_toui_uf;                         
wire    [15:0]  ex2_ui16_result;                     
wire    [31:0]  ex2_ui32_result;                     
wire    [63:0]  ex2_ui64_result;                     
wire    [7 :0]  ex2_ui8_result;                      
wire    [63:0]  ex2_uint_nm_result;                  
wire            ex2_widden;                          
wire            ex2_x_eq_0p5;                        
wire            ex2_x_gt_0p5;                        
wire            ex2_x_zero;                          
wire            fcnvt_ex1_pipe_clk;                  
wire            fcnvt_ex1_pipedown;                  
wire            fcnvt_ex2_pipe_double_clk;           
wire            fcnvt_ex2_pipedown;                  
wire    [15:0]  half0_final_frac;                    
wire    [15:0]  half0_special_result;                
wire            half_expnt_add;                      
wire            half_norm_f_all_1;                   
wire            int_dest_max_si;                     
wire            int_dest_max_si16;                   
wire            int_dest_max_si64;                   
wire            int_dest_max_si8;                    
wire            int_dest_max_ui;                     
wire            int_dest_max_ui16;                   
wire            int_dest_max_ui64;                   
wire            int_dest_max_ui8;                    
wire            int_dest_min_si;                     
wire            int_dest_min_si16;                   
wire            int_dest_min_si64;                   
wire            int_dest_min_si8;                    
wire            int_dest_min_ui;                     
wire            int_dest_min_ui16;                   
wire            int_dest_min_ui64;                   
wire            int_dest_min_ui8;                    
wire    [7 :0]  itof_bhalf_value;                    
wire    [52:0]  itof_double_value;                   
wire    [10:0]  itof_half_value;                     
wire    [23:0]  itof_single_value;                   
wire    [15:0]  l16_0_itof_value;                    
wire    [31:0]  l32_0_itof_value;                    
wire    [63:0]  l64_itof_value;                      
wire    [50:0]  qnan_f;                              
wire    [31:0]  single0_final_frac;                  
wire    [31:0]  single0_special_result;              
wire            single_expnt_add;                    
wire            single_norm_f_all_1;                 
wire    [2 :0]  vpu_group_1_xx_ex2_rm;               
wire    [51:0]  widden_quod_up_double_f;             
wire            widden_quod_up_sel;                  
wire    [22:0]  widden_single_f;                     


// &Force("bus", "dp_xx_ex1_cnan", 2, 0); @32
// &Force("bus", "dp_xx_ex1_snan", 2, 0); @33
// &Force("bus", "dp_xx_ex1_qnan", 2, 0); @34
// &Force("bus", "dp_xx_ex1_norm", 2, 0); @35
// &Force("bus", "dp_xx_ex1_zero", 2, 0); @36
// &Force("bus", "dp_xx_ex1_inf", 2, 0); @37
// &Force("bus", "dp_xx_ex1_id", 2, 0); @38
// &Force("bus", "idu_fpu_ex1_func", 9, 0); @39


//==============================================================================
//                     EX1 Operation
//==============================================================================

assign ex1_ia_0       = ex1_src_l64 && ~|ex1_double_src[63:0] || 
                        ex1_src_l32 && ~|ex1_single0_src[31:0]||
                        ex1_src_l16 && ~|ex1_half0_src[15:0]  ||
                        ex1_src_l8 && ~|ex1_l8_0_src[7:0];
assign ex1_int_s      = ex1_src_l64 && ex1_double_src[63] || 
                        ex1_src_l32 && ex1_single0_src[31]||
                        ex1_src_l16 && ex1_half0_src[15]  ||
                        ex1_src_l8 && ex1_l8_0_src[7];
assign ex1_float_s    = ex1_src_double && ex1_double_src[63] || 
                        ex1_src_single && ex1_single0_src[31]||
                        (ex1_src_half||ex1_src_bhalf) && ex1_half0_src[15];
assign ex1_src_s      = ex1_src_si ? ex1_int_s
                                   : ex1_float_s;
// inf/nan only for float
assign ex1_src_f_inf      = double_pipe_ex1_src_inf;
assign ex1_src_f_qnan     = double_pipe_ex1_src_qnan;
assign ex1_src_f_cnan     = double_pipe_ex1_src_cnan;
assign ex1_src_f_snan     = double_pipe_ex1_src_snan;
assign ex1_src_f_0        = double_pipe_ex1_src_zero;
assign ex1_src_dn         = double_pipe_src_dn;


assign ex1_src_e[10:0]    = {11{ex1_src_double}} & {ex1_double_src[62:52]} |
                            {11{ex1_src_single}} & {3'b0, ex1_single0_src[30:23]}       |
                            {11{ex1_src_half}}   & {6'b0,ex1_half0_src[14:10]}    |
                            {11{ex1_src_bhalf}}  & {3'b0,ex1_half0_src[14:7]};
assign ex1_exp_bias[11:0] = {12{ex1_src_double}} & 12'hC01 | 
                            {12{ex1_src_single}} & 12'hF81 |
                            {12{ex1_src_half}}   & 12'hFF1 |
                            {12{ex1_src_bhalf}}  & 12'hF81;

//float or int equal 0
assign ex1_src_is_0       = ex1_src_f_0 && ex1_src_float || ex1_ia_0 && ex1_src_i;

assign ex1_double_f[51:0] = ex1_double_src[51:0];
assign ex1_double_e[10:0] = ex1_double_src[62:52];
assign ex1_single_f[22:0] = ex1_single0_src[22:0];
assign ex1_single_e[7:0] = ex1_single0_src[30:23];
assign ex1_half_f[9:0]    = ex1_half0_src[9:0];
assign ex1_bhalf_f[6:0]   = ex1_half0_src[6:0];
//assign ex1_src_f0[63:0]   = [63:0] & {64{fcnvt_ex1_sel}};
//TBD
//assign ex1_src_int[63:0] =  {64{ex1_src_l64}} & ex1_double_src[63:0]         |
//                            {64{ex1_src_l32}} & {{32{ex1_single0_src[31] && ex1_src_si}},ex1_single0_src[31:0]}|
//                            {64{ex1_src_l16}} & {{48{ex1_half0_src[15] && ex1_src_si}},ex1_half0_src[15:0]  }|
//                            {64{ex1_src_l8}}  & {{56{ex1_l8_0_src[7] && ex1_src_si}},ex1_l8_0_src[7:0]};


//------------------------------------------------------------------------------
//                    expnt adjust:
//------------------------------------------------------------------------------
assign ex1_e_without_bias[11:0] = {1'b0, ex1_src_e[10:0]} + ex1_exp_bias[11:0];


//------------------------------------------------------------------------------
//                    EX1 FTOI Path:
//------------------------------------------------------------------------------
//In FTOI, generate int and tail, shift by ex1_e_without_bias
//Corner: when  ex1_e_without_bias == -1, round bits is different with other
//case
assign ex1_src_f[51:0] = {52{ex1_src_single}} & {ex1_single_f[22:0] ,29'b0} |
                         {52{ex1_src_double}} &  ex1_double_f[51:0]         |
                         {52{ex1_src_half}}   & {ex1_half_f[9:0],42'b0}     |
                         {52{ex1_src_bhalf}}  & {ex1_bhalf_f[6:0],45'b0};
assign ex1_ftoi_trans[52:0] = {~ex1_src_is_0, ex1_src_f[51:0]};
//assign double_pipe_ex1_expnt[5:0] = ex1_e_without_bias[5:0];
// &Instance("aq_fcnvt_ftoi_d","x_aq_fcnvt_ftoi_d"); @112
aq_fcnvt_ftoi_d  x_aq_fcnvt_ftoi_d (
  .fsh_cnt                 (ex1_e_without_bias[6:0]),
  .fsh_i_v_nm              (ex1_fsh_i_v_nm         ),
  .fsh_i_x_nm              (ex1_fsh_i_x_nm         ),
  .fsh_src                 (ex1_ftoi_trans         )
);

// &Connect( @113
//           .fsh_cnt    (ex1_e_without_bias[6:0]), @114
//           .fsh_src    (ex1_ftoi_trans), @115
//           .fsh_i_v_nm (ex1_fsh_i_v_nm), @116
//           .fsh_i_x_nm (ex1_fsh_i_x_nm) @117
//         ); @118
// //&Force("bus","double_pipe_ftoi_int_in",127,0); @119
assign ex1_ftoi_int[63:0]      = ex1_e_without_bias[11] ? 64'b0 : ex1_fsh_i_v_nm[63:0];
assign ex1_ftoi_int_tail[53:0] = ex1_e_without_bias[11] && ex1_e_without_bias[10:0] != 11'h7ff ? {1'b0,ex1_ftoi_trans[52:0]} : ex1_fsh_i_x_nm[53:0];
//assign ex1_src_i_sign          = ex1_src_s;

//------------------------------------------------------------------------------
//                    EX1 ITOF Path:
//------------------------------------------------------------------------------
//In ITOF, if dest is single, need rounding
//assign ex1_src_neg_shf      = ex1_src_i_sign && ex1_src_si;
//assign ex1_itof_neg_i[32:0] = {1'b0,~ex1_src_int[31:0]} + 33'b1;
//assign ex1_itof_src[31:0]   = ex1_src_neg_shf ? ex1_itof_neg_i[31:0] : ex1_src_int[31:0];
//assign ex1_itof_src_sh_h[63:0] = {ex1_itof_src_neg_h[31:0],ex1_itof_src[31:0]};
//assign ex1_itof_cin            = ~|ex1_src_int[31:0];
//assign ex1_itof_src_neg_h[31:0]= ex1_src_neg_shf ? (~ex1_src_int[63:32] + {{31{1'b0}},ex1_itof_cin}) :  ex1_src_int[63:32];
//&Instance("aq_fcnvt_itof_d","x_aq_fcnvt_itof_d");
// //&Connect( @135
// //          .ff1_sh_src       (ex1_itof_src     ),     // input data @136
// //          .ff1_sh_cnt       (ex1_ff1_d_cnt    ),     // find fist 1 @137
// //          .ff1_sh_f_v       (ex1_ff1_sh_f_v   )      // output frac @138
// //        ); @139

//&Instance("aq_fcnvt_itof_d_h","x_aq_fcnvt_itof_d_h");
// //&Connect( @142
// //          .ff1_sh_src       (ex1_itof_src_sh_h[63:0]       ),     // input data @143
// //          .ff1_sh_cnt       (ex1_ff1_d_cnt_h           ),     // find fist 1 @144
// //          .ff1_sh_f_v       (ex1_ff1_sh_f_v_h          ),      // output frac @145
// //          .ff1_high_all1    (ex1_ff1_high_all1         ), @146
// //          .sel_low          (ex1_ff1_sel_low           ) @147
// //        ); @148
// i to f: f is frac of float, and t is for rounding
//assign itof_dest_double_f[52:0] = ex1_ff1_sel_low ? ex1_ff1_sh_f_v[52:0]
//                                                  : ex1_ff1_sh_f_v_h[63:11];
//assign itof_dest_double_t[56:0] =  ex1_ff1_sel_low ? 57'b0
//                                                   : {ex1_ff1_sh_f_v_h[10:0],46'b0};
//
//
//assign itof_dest_single_f[23:0] = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[52:29]}
//                                                  : ex1_ff1_sh_f_v_h[63:40];
//assign itof_dest_single_t[56:0] = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[28:0], 28'b0}
//                                                  : {ex1_ff1_sh_f_v_h[39:0],17'b0};
//
//assign itof_dest_half_f[10:0]   = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[52:42]}
//                                                  : ex1_ff1_sh_f_v_h[63:53];
//assign itof_dest_half_t[56:0]   = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[41:0],15'b0}
//                                                  : {ex1_ff1_sh_f_v_h[52:0],4'b0};
//assign itof_dest_bhalf_f[7:0]   = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[52:45]}
//                                                  : ex1_ff1_sh_f_v_h[63:56];
//assign itof_dest_bhalf_t[56:0]   = ex1_ff1_sel_low ? {ex1_ff1_sh_f_v[44:0],12'b0}
//                                                  : {ex1_ff1_sh_f_v_h[55:0],1'b0};
// //&Force("nonport","ex1_ff1_high_all1"); @169
// merge the dest is single and doubleex1_single_widden_e
//assign ex1_itof_expnt[11:0]     = {6'b0,double_pipe_ex1_itof_expnt[5:0]};
//assign ex1_itof_dest_tail[56:0] = {57{ex1_dest_double}} & itof_dest_double_t[56:0] |
//                                  {57{ex1_dest_single}} & itof_dest_single_t[56:0] |
//                                  {57{ex1_dest_half}}   & itof_dest_half_t[56:0]     |
//                                  {57{ex1_dest_bhalf}}  & itof_dest_bhalf_t[56:0];


//------------------------------------------------------------------------------
//                    EX1 FTOF Path:
//------------------------------------------------------------------------------
//In FTOF, including  STOD and DTOS
//STOD : when e_single == -127, need to find FF1 in single frac
//DTOS : double has 53 frac bits, so maybe need rounding
//assign ex1_dn_frac[22:0] = ex1_src_bhalf ? {ex1_bhalf_f[6:0],16'b0} : ex1_single_f[22:0];
//&Instance("aq_fcnvt_stod_d","x_aq_fcnvt_stod_d");
// //&Connect( @186
// //          .stod_sh_src      (ex1_dn_frac      ), @187
// //          .stod_sh_f_v      (ex1_stod_sh_f_v  ), @188
// //          .stod_sh_cnt      (ex1_stod_sh_cnt  ) @189
// //        ); @190
//
//// This message is useful, only when src single is dn
assign ex1_single_widden_dn         = ex1_src_dn && ex1_op_stod;
//assign ex1_single_widden_dn_e[11:0] = ex1_stod_sh_cnt[11:0];
//assign ex1_single_widden_dn_f[23:0] = ex1_stod_sh_f_v[23:0];
assign ex1_single_widden_f[52:0]    = ex1_single_widden_dn ? {21'b0,ex1_single_f[22:0],9'b0}
                                                           : {!ex1_src_dn, ex1_single_f[22:0], 29'b0};
assign ex1_single_widden_e[11:0]    = ex1_single_widden_dn ? {7'b0,double_pipe_stod_expnt[4:0]} : ex1_e_without_bias[11:0];

assign ex1_bhalf_widden_f[23:0]     = {!ex1_src_dn, ex1_bhalf_f[6:0], 16'b0};
//assign ex1_bhalf_wddden_e[11:0]     = ex1_e_without_bias[11:0];
//bhalf quod up
assign ex1_bhalf_quod_dn            = ex1_src_dn && ex1_op_bhtod;
assign ex1_bhalf_quod_f[52:0]     = ex1_bhalf_quod_dn ? {37'b0,ex1_bhalf_f[6:0],9'b0} : {1'b1,ex1_bhalf_f[6:0],45'b0};
assign ex1_bhalf_quod_e[11:0]     = ex1_bhalf_quod_dn ?  {7'b0,double_pipe_bhtox_expnt[4:0]} : ex1_e_without_bias[11:0];

//assign ex1_half_dn[9:0]             = ex1_half_f[9:0];  
//&Instance("aq_fcnvt_htos_sh","x_aq_fcnvt_htos_d");
// //&Connect( @209
// //          .htos_sh_src      (ex1_half_dn    ), @210
// //          .htos_sh_f_v      (ex1_htos_sh_f_v  ), @211
// //          .htos_sh_cnt      (ex1_htos_sh_cnt  ) @212
// //        ); @213
//
assign ex1_half_widden_dn         = ex1_src_dn && ex1_op_htos;
//assign ex1_half_widden_dn_e[11:0] = {{6{1'b1}},ex1_htos_sh_cnt[5:0]};
//assign ex1_half_widden_dn_f[10:0] = ex1_htos_sh_f_v[10:0];
assign ex1_half_widden_f[23:0]    = ex1_half_widden_dn ? {8'b0,ex1_half_f[9:0],6'b0} : {!ex1_src_dn, ex1_half_f[9:0], 13'b0};
assign ex1_half_widden_e[11:0]    = ex1_half_widden_dn ? {7'b0,double_pipe_htox_expnt[4:0]} : ex1_e_without_bias[11:0];

assign ex1_widden_quod_up_dn      = ex1_half_widden_dn || ex1_bhalf_quod_dn 
                                    || ex1_single_widden_dn ||ex1_half_quod_dn;
//half quod up
assign ex1_half_quod_dn          = ex1_src_dn && ex1_op_htod;
assign ex1_half_quod_f[52:0]     = ex1_half_quod_dn ? {37'b0,ex1_half_f[9:0],6'b0} : {1'b1,ex1_half_f[9:0],42'b0};
assign ex1_half_quod_e[11:0]     = ex1_half_quod_dn ? {7'b0,double_pipe_htox_expnt[4:0]} : ex1_e_without_bias[11:0];


// &Instance("aq_fcnvt_dtos_d","x_aq_fcnvt_dtos_d"); @229
aq_fcnvt_dtos_d  x_aq_fcnvt_dtos_d (
  .dtos_sh_cnt     (ex1_double_e   ),
  .dtos_sh_f_v     (ex1_dtos_sh_f_v),
  .dtos_sh_f_x     (ex1_dtos_sh_f_x),
  .dtos_sh_src     (ex1_double_f   )
);

// &Connect( @230
//           .dtos_sh_src      (ex1_double_f      ), // double fraction @231
//           .dtos_sh_cnt      (ex1_double_e      ), // double exponent @232
//           .dtos_sh_f_v      (ex1_dtos_sh_f_v   ), @233
//           .dtos_sh_f_x      (ex1_dtos_sh_f_x   ) @234
//         ); @235
// This message is useful, only when dest single is dn
assign ex1_double_narrow_dn           = ex1_double_e[10:0] < 11'h381;
assign ex1_double_narrow_dn_t[56:0]   = {ex1_dtos_sh_f_x[53:0],3'b0};  // 54 bits for g r s

assign ex1_double_narrow_frac_t[23:0] = ex1_double_narrow_dn ? ex1_dtos_sh_f_v[23:0]
                                                             : {1'b1, ex1_double_f[51:29]};
assign ex1_double_narrow_frac[23:0]   = {ex1_double_narrow_frac_t[23:0]};
assign ex1_double_narrow_tail[56:0]   = ex1_double_narrow_dn ? ex1_double_narrow_dn_t[56:0]
                                                             : {ex1_double_f[28:0], 28'b0};

// quod to bhalf
assign ex1_double_quod_bhalf_frac[7:0]  = ex1_double_narrow_frac_t[23:16];
assign ex1_double_quod_bhalf_tail[56:0] = {ex1_double_narrow_frac_t[15:0],ex1_double_narrow_tail[56:16]};



assign ex1_xtoh_f[51:0]               = ex1_src_double ? ex1_double_f[51:0]
                                                       : {ex1_single_f[22:0],29'b0};
// &Instance("aq_fcnvt_xtoh_sh","x_aq_fcnvt_xtoh_d"); @254
aq_fcnvt_xtoh_sh  x_aq_fcnvt_xtoh_d (
  .xtoh_sh_cnt        (ex1_e_without_bias),
  .xtoh_sh_f_v        (ex1_xtoh_sh_f_v   ),
  .xtoh_sh_f_x        (ex1_xtoh_sh_f_x   ),
  .xtoh_sh_src        (ex1_xtoh_f        )
);

// &Connect( @255
//           .xtoh_sh_src      (ex1_xtoh_f              ), // double fraction @256
//           .xtoh_sh_cnt      (ex1_e_without_bias      ), // double exponent @257
//           .xtoh_sh_f_v      (ex1_xtoh_sh_f_v         ), @258
//           .xtoh_sh_f_x      (ex1_xtoh_sh_f_x         ) @259
//         ); @260
assign ex1_single_narrow_dn            = ex1_single_e[7:0] < 8'h71;
assign ex1_single_narrow_dn_t[56:0]    = {ex1_xtoh_sh_f_x[53:0],3'b0};  // 54 bits for g r s

assign ex1_single_narrow_frac_t[10:0] = ex1_single_narrow_dn ? ex1_xtoh_sh_f_v[10:0]
                                                             : {1'b1, ex1_single_f[22:13]};
assign ex1_single_narrow_half_frac[10:0]   = { ex1_single_narrow_frac_t[10:0]};
assign ex1_single_narrow_half_tail[56:0]   = ex1_single_narrow_dn ? ex1_single_narrow_dn_t[56:0]
                                                             : {ex1_single_f[12:0], 44'b0};

assign ex1_double_quod_dn            = ex1_double_e[10:0] < 11'h3f1;
assign ex1_double_quod_dn_t[56:0]    = {ex1_xtoh_sh_f_x[53:0],3'b0};  // 54 bits for g r s

assign ex1_double_quod_frac_t[10:0]  = ex1_double_quod_dn ? ex1_xtoh_sh_f_v[10:0]
                                                             : {1'b1, ex1_double_f[51:42]};
assign ex1_double_quod_half_frac[10:0]   = { ex1_double_quod_frac_t[10:0]};
assign ex1_double_quod_half_tail[56:0]   = ex1_double_quod_dn ? ex1_double_quod_dn_t[56:0]
                                                             : {ex1_double_f[41:0], 15'b0};

assign ex1_single_narrow_bhalf_frac[7:0] = {ex1_src_dn,ex1_single_f[22:16]};
assign ex1_single_narrow_bhalf_tail[56:0]= {ex1_single_f[15:0],41'b0};


//------------------------------------------------------------------------------
//                    EX1 final result:
//------------------------------------------------------------------------------

assign ex1_double_final_frac[52:0]   = 
                                       {53{ex1_op_stod}} & ex1_single_widden_f[52:0]|
                                       {53{ex1_op_htod}} & ex1_half_quod_f[52:0]    |
                                       {53{ex1_op_bhtod}} & ex1_bhalf_quod_f[52:0];
assign ex1_single_final_frac[23:0]   = 
                                       {24{ex1_op_dtos}} & ex1_double_narrow_frac[23:0]|
                                       {24{ex1_op_htos}} & ex1_half_widden_f[23:0]  |
                                       {24{ex1_op_bhtos}} & ex1_bhalf_widden_f[23:0];
assign ex1_half_final_frac[10:0]     = 
                                       {11{ex1_op_stoh}} & ex1_single_narrow_half_frac[10:0]|
                                       {11{ex1_op_dtoh}} & ex1_double_quod_half_frac[10:0];
assign ex1_bhalf_final_frac[7:0]     = 
                                       {8{ex1_op_stobh}} & ex1_single_narrow_bhalf_frac[7:0]|
                                       {8{ex1_op_dtobh}} & ex1_double_quod_bhalf_frac[7:0];

assign ex1_final_tail_t[56:0] = 
                                {57{ex1_op_dtos}} & ex1_double_narrow_tail[56:0]       |
                                {57{ex1_op_stoh}} & ex1_single_narrow_half_tail[56:0]  |
                                {57{ex1_op_dtoh}} & ex1_double_quod_half_tail[56:0]    |
                                {57{ex1_op_stobh}} & ex1_single_narrow_bhalf_tail[56:0]|
                                {57{ex1_op_dtobh}} & ex1_double_quod_bhalf_tail[56:0];


// merge dest int and float result
assign ex1_final_tail[56:0] = ex1_op_ftoi ? {ex1_ftoi_int_tail[53:0],3'b0} : ex1_final_tail_t[56:0];
assign ex1_widdn_quod       = ex1_op_stod ||ex1_op_htod || ex1_op_bhtod ||  ex1_op_htos;
assign ex1_widdne_quod_e[11:0] = {12{ex1_op_stod}} & ex1_single_widden_e[11:0] |
                                 {12{ex1_op_htod}} & ex1_half_quod_e[11:0]     |
                                 {12{ex1_op_bhtod}}& ex1_bhalf_quod_e[11:0]    |
                                 {12{ex1_op_htos}} & ex1_half_widden_e[11:0];


assign ex1_final_exp[11:0]  = ex1_widdn_quod ? ex1_widdne_quod_e[11:0] 
                                             : ex1_e_without_bias[11:0];
// merge dest float expnt and dest int
assign ex1_single_bf_dn     = ex1_single_e[7:0] == 8'h0;
assign ex1_final_sign       = ex1_src_s && !(ex1_src_float && !ex1_dest_float && ex1_src_is_0
                                                           || !ex1_src_float  && !ex1_src_si);
assign ex1_final_double_narrow_dn  = ex1_src_float && ((ex1_src_double && (ex1_double_narrow_dn && (ex1_dest_single||ex1_dest_bhalf) 
                                                                         || ex1_double_quod_dn && ex1_dest_half))
                                                      || (ex1_single_narrow_dn && ex1_dest_half || ex1_single_bf_dn && ex1_dest_bhalf) && ex1_src_single
                                                      || ex1_src_dn      && ex1_op_stobh);


//------------------------------------------------------------------------------
//                    EX1 special result:
//------------------------------------------------------------------------------
//In fcnvt double, single to double and double to single, FPU only record the input
//src type, so the special result should generate in fcnvt

//d to s
//cnan, qnan, inf, 0, qnan_src2, qnan_src1, qnan_src0, cnan, inf, zero, src2, 11 bits

assign ex1_single_special_qnan[63:0] = {32'hffffffff, ex1_src_s, {8{1'b1}}, 1'b1, qnan_f[50:29]};
assign ex1_single_special_inf[63:0]  = {32'hffffffff, ex1_src_s, {8{1'b1}}, 23'b0};
assign ex1_single_special_0[63:0]    = {32'hffffffff, ex1_src_s, 31'b0};
assign ex1_single_special_cnan[63:0] = {32'hffffffff, 1'b0, {8{1'b1}}, 1'b1, 22'b0};

assign ex1_single_special[63:0] = {64{ex1_special_sel_1[9]}}  & ex1_single_special_qnan[63:0] |
                                  {64{ex1_special_sel_1[8]}}  & ex1_single_special_inf[63:0]  |
                                  {64{ex1_special_sel_1[7]}}  & ex1_single_special_0[63:0]    |
                                  {64{ex1_special_sel_1[10]}} & ex1_single_special_cnan[63:0];

assign ex1_half_special_qnan[63:0] = {{48{1'b1}}, ex1_src_s, {5{1'b1}}, 1'b1, qnan_f[50:42]};
assign ex1_half_special_inf[63:0]  = {{48{1'b1}}, ex1_src_s, {5{1'b1}}, 10'b0};
assign ex1_half_special_0[63:0]    = {{48{1'b1}}, ex1_src_s, 15'b0};
assign ex1_half_special_cnan[63:0] = {{48{1'b1}}, 1'b0, {5{1'b1}}, 1'b1, 9'b0};

assign ex1_half_special[63:0] = {64{ex1_special_sel_1[9]}}  & ex1_half_special_qnan[63:0] |
                                {64{ex1_special_sel_1[8]}}  & ex1_half_special_inf[63:0]  |
                                {64{ex1_special_sel_1[7]}}  & ex1_half_special_0[63:0]    |
                                {64{ex1_special_sel_1[10]}} & ex1_half_special_cnan[63:0];

assign ex1_bhalf_special_qnan[63:0] = {{48{1'b1}}, ex1_src_s, {8{1'b1}}, 1'b1, qnan_f[50:45]};
assign ex1_bhalf_special_inf[63:0]  = {{48{1'b1}}, ex1_src_s, {8{1'b1}}, 7'b0};
assign ex1_bhalf_special_0[63:0]    = {{48{1'b1}}, ex1_src_s, 15'b0};
assign ex1_bhalf_special_cnan[63:0] = {{48{1'b1}}, 1'b0, {8{1'b1}}, 1'b1, 6'b0};

assign ex1_bhalf_special[63:0] = {64{ex1_special_sel_1[9]}}  & ex1_bhalf_special_qnan[63:0] |
                                 {64{ex1_special_sel_1[8]}}  & ex1_bhalf_special_inf[63:0]  |
                                 {64{ex1_special_sel_1[7]}}  & ex1_bhalf_special_0[63:0]    |
                                 {64{ex1_special_sel_1[10]}} & ex1_bhalf_special_cnan[63:0];     
assign qnan_f[50:0]            = {51{ex1_src_double}} & ex1_double_f[50:0] |
                                 {51{ex1_src_single}} & {ex1_single_f[21:0],29'b0} |
                                 {51{ex1_src_half}}    & {ex1_half_f[8:0],42'b0}     |
                                 {51{ex1_src_bhalf}}   & {ex1_bhalf_f[5:0],45'b0};

//s to d
//cnan, qnan, inf, 0, qnan_src2,qnan_src1,qnan_src0,cnan,inf,zero,src2
// &CombBeg; @376
always @( ex1_src_f_0
       or ex1_src_f_cnan
       or cp0_vpu_xx_dqnan
       or ex1_src_f_qnan
       or ex1_src_f_inf
       or ex1_src_f_snan)
begin
if(ex1_src_f_snan && cp0_vpu_xx_dqnan)
  ex1_special_sel_1[10:0] = {1'b0, 1'b1, 9'b0}; // qnan
else if(ex1_src_f_cnan)
  ex1_special_sel_1[10:0] = {1'b1, 1'b0, 9'b0}; // cnan
else if(ex1_src_f_qnan && cp0_vpu_xx_dqnan)
  ex1_special_sel_1[10:0] = {1'b0, 1'b1, 9'b0}; // qnan
else if(ex1_src_f_inf)
  ex1_special_sel_1[10:0] = {2'b0, 1'b1, 8'b0}; // inf
else if(ex1_src_f_0)
  ex1_special_sel_1[10:0] = {3'b0, 1'b1, 7'b0}; // 0
else// if(ex1_src_f_cnan)
  ex1_special_sel_1[10:0] = {1'b1, 1'b0, 9'b0}; // cnan
// &CombEnd; @389
end



assign ex1_double_special_qnan[63:0] = {ex1_src_s,{11{1'b1}} , 1'b1, qnan_f[50:0]};
assign ex1_double_special_cnan[63:0] = {1'b0, {11{1'b1}}, 1'b1, 51'b0};
assign ex1_double_special_inf[63:0]  = {ex1_src_s,{11{1'b1}}, 52'b0};
assign ex1_double_special_0[63:0]    = {ex1_src_s, 63'b0};

assign ex1_double_special[63:0] = {64{ex1_special_sel_1[9]}}  & ex1_double_special_qnan[63:0] |
                                  {64{ex1_special_sel_1[8]}}  & ex1_double_special_inf[63:0]  |
                                  {64{ex1_special_sel_1[7]}}  & ex1_double_special_0[63:0]    |
                                  {64{ex1_special_sel_1[10]}} & ex1_double_special_cnan[63:0];



assign ex1_special_f_nv = ex1_src_f_snan;

//f to i
//max, min, 0
// &CombBeg; @409
always @( ex1_src_f_qnan
       or ex1_src_f_inf
       or ex1_src_f_snan
       or ex1_src_s)
begin
if(ex1_src_f_snan)
  ex1_special_sel_2[2:0] = {1'b1, 2'b0};
else if(ex1_src_f_qnan)
  ex1_special_sel_2[2:0] = {1'b1, 2'b0};
else if(ex1_src_f_inf && ex1_src_s)
  ex1_special_sel_2[2:0] = {1'b0, 1'b1, 1'b0};
else if(ex1_src_f_inf && !ex1_src_s)
  ex1_special_sel_2[2:0] = {1'b1, 2'b0};
else //if(ex1_src_f_0)
  ex1_special_sel_2[2:0] = {2'b0, 1'b1};
// &CombEnd; @420
end

assign ex1_ftosi_max[63:0] = {1'b0, {63{1'b1}}};
assign ex1_ftosi_min[63:0] = {1'b1, 63'b0};
assign ex1_ftoi_0[63:0]    = 64'b0;
assign ex1_ftoui_max[63:0] = {64{1'b1}};
assign ex1_ftoui_min[63:0] = 64'b0;
assign ex1_ftoi_min[63:0]  = ex1_dest_si ? ex1_ftosi_min[63:0] : ex1_ftoui_min[63:0];
assign ex1_ftoi_max[63:0]  = ex1_dest_si ? ex1_ftosi_max[63:0] : ex1_ftoui_max[63:0];

assign ex1_ftoi_specail[63:0] = {64{ex1_special_sel_2[2]}}  & ex1_ftoi_max[63:0] |
                                {64{ex1_special_sel_2[1]}}  & ex1_ftoi_min[63:0] |
                                {64{ex1_special_sel_2[0]}}  & ex1_ftoi_0[63:0];


assign ex1_special_i_nv       = ex1_src_float && !ex1_dest_float && (ex1_src_f_snan || ex1_src_f_qnan || ex1_src_f_inf);


//------------------------------------------------------------------------------
//                    EX1 float result rename for output:
//------------------------------------------------------------------------------
//assign double_pipe_rtu_rst[63:0]   = {ex1_ftoi_specail[31:0],32'b0};

//assign fcnvt_ex1_rtu_wb_vld      = ex1_op_ftoi && (ex1_src_f_snan || ex1_src_f_cnan || ex1_src_f_qnan || ex1_src_f_inf || ex1_src_f_0)
//                                   && fcnvt_ex1_sel && falu_ctrl_xx_ex1_vld;


//------------------------------------------------------------------------------
//                    EX1 int result rename for output:
//------------------------------------------------------------------------------
//
// TBD 
assign double_special_result[63:0]  = ex1_dest_float ? ex1_double_special[63:0] : ex1_ftoi_specail[63:0];
assign single0_special_result[31:0] = ex1_dest_float ? ex1_single_special[31:0] : ex1_ftoi_specail[63:32];
assign half0_special_result[15:0]   = ex1_dest_float ? ex1_half_special[15:0]   : ex1_ftoi_specail[63:48];
assign bhalf0_special_result[15:0]  = ex1_dest_float ? ex1_bhalf_special[15:0]  : ex1_ftoi_specail[63:48];

assign ex1_special_vld               = (ex1_src_float) && (ex1_src_f_snan || ex1_src_f_cnan || ex1_src_f_qnan || ex1_src_f_inf || ex1_src_f_0);
                                        //    && fcnvt_ex1_sel && falu_ctrl_xx_ex1_vld;
//assign fcnvt_ex1_dp_special_sel[7:0]  = {1'b1, 7'b0};
assign ex1_nv                       = ex1_src_float && ex1_special_f_nv  || ex1_special_i_nv;
//assign fcnvt_ex1_dp_special_sign[2:0] = 3'b0;
//assign fcnvt_ex1_dp_single            = ex1_dest_single;

//Output for icg
//assign fcnvt_ex1_op_ftoi = ex1_op_ftoi;
//assign fcnvt_dest_f      = ex1_dest_float;
assign double_final_frac[63:0]   = ex1_special_vld ? double_special_result[63:0] : {11'b0,ex1_double_final_frac[52:0]};
assign single0_final_frac[31:0]  = ex1_special_vld ? single0_special_result[31:0] : {8'b0,ex1_single_final_frac[23:0]};
assign half0_final_frac[15:0]    = ex1_special_vld ? half0_special_result[15:0] : {5'b0,ex1_half_final_frac[10:0]};
assign bhalf0_final_frac[15:0]   = ex1_special_vld ? bhalf0_special_result[15:0] : {8'b0,ex1_bhalf_final_frac[7:0]};
assign double_pipe_ex1_special_vld   = ex1_special_vld;

//assign double_pipe_not_sel_shift  = ex1_special_vld || !ex1_widden_quod_up_dn;

//------------------------------------------------------------------------------
//                    EX1 pipedown to EX2:
//------------------------------------------------------------------------------
always @(posedge fcnvt_ex1_pipe_clk)
begin
  if(fcnvt_ex1_pipedown) begin
    ex2_tail[56:0]       <= ex1_final_tail[56:0];
    ex2_sign             <= ex1_final_sign;
    ex2_narrow_dn        <= ex1_final_double_narrow_dn;
    ex2_widden_quod_up_dn<= ex1_widden_quod_up_dn;
    ex2_src_is_0         <= ex1_src_is_0;
    ex2_exp[11:0]        <= ex1_final_exp[11:0];
    ex2_special_vld_flop <= ex1_special_vld;
    ex2_nv               <= ex1_nv;
    ex2_special_int[1:0] <= ex1_special_sel_2[2:1];
  end
end
assign ex2_special_vld = ex2_special_vld_flop;
//TBD, these will be reused in vector scenario
assign double_pipe_ftoi_int[63:0]      = {ex1_ftoi_int[63:0]};

//always @(posedge fcnvt_ex1_pipe_clk)
//begin
//  if(fcnvt_ex1_pipedown && fcnvt_ex1_op_ftoi || ifu_vpu_warm_up) begin
//    ex2_int_r[31:0] <= ex1_ftoi_int[31:0];
//  end
//end

//always @(posedge fcnvt_ex1_pipe_clk)
//begin
//  if(fcnvt_ex1_pipedown && fcnvt_dest_f || ifu_vpu_warm_up) begin
//    ex2_frac[52:0]  <= ex1_final_frac[52:0];
//  end
//end


//==============================================================================
//                                EX2  Operation:
//==============================================================================
// &Force("bus","double_pipe_ex2_int",67,0); @519
assign ex2_int[63:0]   = double_pipe_ex2_int[63:0];
assign ex2_frac[63:0]  = double_pipe_ex2_frac[63:0];

assign ex2_expnt[11:0] = ex2_exp[11:0];
//assign ex2_int[31:0]   = ex2_int_r[31:0];
//assign ex2_dest_double = !ex2_dest_single && ex2_dest_float;
assign ex2_rm_rne      = vpu_group_1_xx_ex2_rm[2:0] == 3'b000;
assign ex2_rm_rtz      = vpu_group_1_xx_ex2_rm[2:0] == 3'b001;
assign ex2_rm_rup      = vpu_group_1_xx_ex2_rm[2:0] == 3'b011;
assign ex2_rm_rdn      = vpu_group_1_xx_ex2_rm[2:0] == 3'b010;
assign ex2_rm_rmm      = vpu_group_1_xx_ex2_rm[2:0] == 3'b100;


assign ex2_dest_double_itof_tail[10:0] = ex2_widden ? 11'b0 : l64_itof_value[10:0];
assign ex2_dest_single_itof_tail[39:0] = ex2_narrow ? l64_itof_value[39:0] : 
                                         ex2_widden ? 40'b0  
                                                    : {l32_0_itof_value[7:0],32'b0};
assign ex2_dest_half_itof_tail[52:0]   = ex2_quod_dn ? l64_itof_value[52:0] : 
                                         ex2_narrow  ? {l32_0_itof_value[20:0],32'b0} : 
                                         ex2_widden  ? 53'b0 
                                                     : {l16_0_itof_value[4:0],48'b0};
assign ex2_dest_bhalf_itof_tail[55:0]   = ex2_quod_dn ? l64_itof_value[55:0] : 
                                          ex2_narrow  ? {l32_0_itof_value[23:0],32'b0} : 
                                          ex2_widden  ? 56'b0 
                                                      : {l16_0_itof_value[7:0],48'b0};
assign ex2_itof_tail[55:0]              = {56{ex2_dest_double}} & {ex2_dest_double_itof_tail[10:0],45'b0} | 
                                          {56{ex2_dest_single}} & {ex2_dest_single_itof_tail[39:0],16'b0} |
                                          {56{ex2_dest_half}}   & {ex2_dest_half_itof_tail[52:0],3'b0}    |
                                          {56{ex2_dest_bhalf}}  & ex2_dest_bhalf_itof_tail[55:0];
assign ex2_tail_lst[56:0] = ex2_op_itof ? {ex2_itof_tail[55:0],1'b0} :
                            ex2_widden_quod_up_dn  ? 57'b0 
                                                   : ex2_tail[56:0];
//frac rounding
assign ex2_x_zero      = ~|ex2_tail_lst[56:0];
assign ex2_x_eq_0p5    = ex2_tail_lst[56] && (~|ex2_tail_lst[55:0]);
assign ex2_x_gt_0p5    = ex2_tail_lst[56] && (|ex2_tail_lst[55:0]);


//------------------------------------------------------------------------------
//                                EX2 rounding:
//------------------------------------------------------------------------------
assign ex2_int_lst   = ex2_int[0];
assign ex2_frac_lst  = double_pipe_ex2_cmb_frac[0];
assign ex2_rnd_lst   = ex2_dest_float  ? ex2_frac_lst : ex2_int_lst;  // lst

assign ex2_round_add = (ex2_rm_rup  && !ex2_sign && (!ex2_x_zero))      ||
                       (ex2_rm_rdn  && ex2_sign  && (!ex2_x_zero))      ||
                       (ex2_rm_rmm) && (ex2_x_gt_0p5 || ex2_x_eq_0p5)   ||
                       (ex2_rm_rne  && (ex2_x_gt_0p5 || (ex2_x_eq_0p5 && ex2_rnd_lst)));  // round add 1

assign itof_double_value[52:0]    =  ex2_h_quod_up ? {l16_0_itof_value[15:0],37'b0} :
                                     ex2_widden    ? {l32_0_itof_value[31:0],21'b0} 
                                                   : l64_itof_value[63:11];
assign itof_single_value[23:0]    = ex2_narrow ? l64_itof_value[63:40] :
                                    ex2_widden ? {l16_0_itof_value[15:0],8'b0} 
                                               : l32_0_itof_value[31:8];
assign itof_half_value[10:0]      = ex2_quod_dn ? l64_itof_value[63:53] :
                                    ex2_narrow  ? l32_0_itof_value[31:21] 
                                                : l16_0_itof_value[15:5];
assign itof_bhalf_value[7:0]      = ex2_quod_dn ? l64_itof_value[63:56] :
                                    ex2_narrow  ? l32_0_itof_value[31:24] 
                                                : l16_0_itof_value[15:8];
// //&Force("bus","l16_0_itof_value",15,0); @583
// //&Force("bus","l32_0_itof_value",31,0); @584
//                       assign itof_double_value[52:0]    = l64_itof_value[63:11];
//assign itof_single_value[23:0]    = l64_itof_value[63:40];
//assign itof_half_value[10:0]      = l64_itof_value[63:53];
//assign itof_bhalf_value[7:0]      = l64_itof_value[63:56];

assign ex2_itof_rnd_src0[52:0]    =  {53{ex2_dest_double}} & itof_double_value[52:0]          |
                                     {53{ex2_dest_single}} & {29'b0,itof_single_value[23:0]} |
                                     {53{ex2_dest_half}}   & {42'b0,itof_half_value[10:0] } |
                                     {53{ex2_dest_bhalf}}  & {45'b0,itof_bhalf_value[7:0]};
assign double_pipe_ex2_cmb_frac[52:0] = ex2_op_itof ? ex2_itof_rnd_src0[52:0] : ex2_frac[52:0];
//assign ex2_rnd_adder_f_src0[63:0]     = ex2_dest_float ? {11'b0, double_pipe_ex2_cmb_frac[52:0]} 
//                                                       : {ex2_rnd_adder_i_src0[63:0]};
//assign ex2_rnd_adder_f_src0[63:0] = ex2_rnd_adder_i_src0[63:0] + ex2_rnd_adder_f_src1[63:0];                                                       
assign ex2_rnd_adder_f_p1_f[53:0]   = {1'b0, double_pipe_ex2_cmb_frac[52:0]} + 54'b1;
assign ex2_rnd_adder_f_src1[63:0] = 64'b1;
assign ex2_rnd_adder_f_p1[63:0]   = ex2_rnd_adder_i_src0[63:0] + ex2_rnd_adder_f_src1[63:0];
assign ex2_rnd_adder_i_p1[63:0]   = ex2_rnd_adder_f_p1[63:0];

assign ex2_int_for_rnd[63:0]      = {64{ex2_dest_l64}} & ex2_int[63:0]         |
                                    {64{ex2_dest_l32}} & {32'b0,ex2_int[31:0]} |
                                    {64{ex2_dest_l16}} & {48'b0,ex2_int[15:0]} |
                                    {64{ex2_dest_l8}}  & {56'b0,ex2_int[7:0]};

assign ex2_rnd_adder_i_src0[63:0] = ex2_dest_si && ex2_sign ? { ~ex2_int_for_rnd[63:0]}
                                                            : { ex2_int_for_rnd[63:0]};

assign ex2_double_orig_f[51:0]    = ex2_op_itof ? itof_double_value[51:0] : ex2_double_orig_frac[51:0];
assign ex2_single0_orig_f[22:0]   = ex2_op_itof ? itof_single_value[22:0] : ex2_single0_orig_frac[22:0];
assign ex2_half0_orig_f[9:0]      = ex2_op_itof ? itof_half_value[9:0] : ex2_half0_orig_frac[9:0];
assign ex2_bhalf0_orig_f[6:0]     = ex2_op_itof ? itof_bhalf_value[6:0] : ex2_bhalf0_orig_frac[6:0];
//TBD half0_orig_f
// here the widden or quod up logic will merged in
// and it does not need to round
assign widden_quod_up_sel            = ex2_widden_quod_up_dn;
assign widden_quod_up_double_f[51:0] = {52{ex2_widden}}     & {double_pipe_stod_value[21:0],30'b0} |
                                       {52{ex2_h_quod_up}}  & {double_pipe_htox_value[8:0],43'b0}  |
                                       {52{ex2_bh_quod_up}} & {double_pipe_bhtod_value[5:0],46'b0};

assign widden_single_f[22:0]         = {double_pipe_htox_value[8:0],14'b0};

assign ex2_double_f[51:0]  = widden_quod_up_sel ? widden_quod_up_double_f[51:0] : 
                             ex2_round_add      ? ex2_rnd_adder_f_p1_f[51:0]      : ex2_double_orig_f[51:0];
assign ex2_single0_f[22:0] = widden_quod_up_sel ? widden_single_f[22:0]    : 
                             ex2_round_add      ? ex2_rnd_adder_f_p1_f[22:0] : ex2_single0_orig_f[22:0];
assign ex2_half0_f[9:0]    = ex2_round_add ? ex2_rnd_adder_f_p1_f[9:0] :  ex2_half0_orig_f[9:0];
assign ex2_bhalf0_f[6:0]   = ex2_round_add ? ex2_rnd_adder_f_p1_f[6:0] :  ex2_bhalf0_orig_f[6:0];

//------------------------------------------------------------------------------
//                               EX2 normal result:
//------------------------------------------------------------------------------
// int normal result
assign ex2_int_nm_result[63:0]  = ex2_sign ^ ex2_round_add ? ex2_rnd_adder_i_p1[63:0]
                                                           : ex2_rnd_adder_i_src0[63:0];
assign ex2_uint_nm_result[63:0] = (ex2_round_add ? ex2_rnd_adder_i_p1[63:0]
                                                 : ex2_rnd_adder_i_src0[63:0]) & {64{!ex2_sign}};

assign ex2_double_dn_ebias[11:0] = ex2_widden || ex2_bh_quod_up ? 12'h380 : 12'h3f0;
assign ex2_itof_half_bias[11:0]   = ex2_src_l64 ? 12'd78 : ex2_src_l32 ? 12'd46 : ex2_src_l16 ? 12'd30 : 12'd22;
assign ex2_itof_half_bias1[11:0]  = ex2_src_l64 ? 12'd79 : ex2_src_l32 ? 12'd47 : ex2_src_l16 ? 12'd31 : 12'd23;
assign ex2_itof_bhalf_bias[11:0]  = ex2_src_l64 ? 12'd190 : ex2_src_l32 ? 12'd158 : ex2_src_l16 ? 12'd142 : 12'd134;
assign ex2_itof_bhalf_bias1[11:0] = ex2_src_l64 ? 12'd191 : ex2_src_l32 ? 12'd159 : ex2_src_l16 ? 12'd143 : 12'd135;
assign ex2_itof_double_bias[11:0] = ex2_src_l64 ? 12'd1086 : ex2_src_l32 ? 12'd1054 : 12'd1038;
assign ex2_itof_double_bias1[11:0] = ex2_src_l64 ? 12'd1087 : ex2_src_l32 ? 12'd1055 : 12'd1039;
// generate normal exponent
// &CombBeg; @649
always @( ex2_dest_double
       or ex2_itof_half_bias[11:0]
       or ex2_widden_quod_up_dn
       or ex2_itof_bhalf_bias[11:0]
       or ex2_op_itof
       or ex2_itof_double_bias[11:0]
       or ex2_double_dn_ebias[11:0]
       or ex2_dest_bhalf
       or ex2_itof_bhalf_bias1[11:0]
       or ex2_itof_double_bias1[11:0]
       or ex2_itof_half_bias1[11:0]
       or ex2_dest_single)
begin
  if (ex2_dest_double) begin
    ex2_eadder_bias[11:0]  = ex2_op_itof ? ex2_itof_double_bias[11:0] : 
                             ex2_widden_quod_up_dn ? ex2_double_dn_ebias[11:0] : 12'd1023;
    ex2_eadder_bias1[11:0] = ex2_op_itof ? ex2_itof_double_bias1[11:0] : 12'd1024;
  end
  else if(ex2_dest_single || ex2_dest_bhalf) begin
    ex2_eadder_bias[11:0]  = ex2_op_itof ? ex2_itof_bhalf_bias[11:0] :ex2_widden_quod_up_dn ? 12'h70 : 12'd127;
    ex2_eadder_bias1[11:0] = ex2_op_itof ? ex2_itof_bhalf_bias1[11:0] :12'd128;
  end
  else begin
    ex2_eadder_bias[11:0]  = ex2_op_itof ? ex2_itof_half_bias[11:0] :12'd15;
    ex2_eadder_bias1[11:0] = ex2_op_itof ? ex2_itof_half_bias1[11:0] :12'd16;
  end
// &CombEnd; @663
end

// the dn widden the bias will be adjust 
// we need to mins the value in ex2_expnt


assign ex2_expnt_add1       = ex2_dest_double && double_expnt_add || 
                              ex2_dest_single && single_expnt_add ||
                              ex2_dest_half   && half_expnt_add   ||
                              ex2_dest_bhalf  && bhalf_expnt_add;
assign ex2_expnt_src0[11:0] = ex2_widden_quod_up_dn||ex2_op_itof ? ~{6'b0,double_pipe_ex2_widden_dn_itof_expnt[5:0]} : ex2_expnt[11:0]; 
assign ex2_expnt_src1[11:0] = ex2_expnt_add1  ? ex2_eadder_bias1[11:0] : ex2_eadder_bias[11:0];
assign ex2_norm_expnt[11:0] = ex2_expnt_src0[11:0] + ex2_expnt_src1[11:0] + {11'b0,ex2_widden_quod_up_dn||ex2_op_itof};
assign ex2_denorm    = ex2_norm_expnt[11];

// normal result
assign ex2_double_norm_result[63:0]    = {ex2_sign, ex2_norm_expnt[10:0], ex2_double_f[51:0]};
assign ex2_single_norm_result[63:0]    = ex2_denorm ? {32'hffffffff, ex2_sign, 8'b0, ex2_single0_f[22:0]}
                                                    : {32'hffffffff, ex2_sign, ex2_norm_expnt[7:0], ex2_single0_f[22:0]};
assign ex2_half_norm_result[63:0]      = ex2_denorm ? {{48{1'b1}}, ex2_sign, 5'b0, ex2_half0_f[9:0]}
                                                    : {{48{1'b1}}, ex2_sign, ex2_norm_expnt[4:0], ex2_half0_f[9:0]};
assign ex2_bhalf_norm_result[63:0]     = ex2_denorm ? {{48{1'b1}}, ex2_sign, 8'b0, ex2_bhalf0_f[6:0]}
                                                    : {{48{1'b1}}, ex2_sign, ex2_norm_expnt[7:0], ex2_bhalf0_f[6:0]};
//------------------------------------------------------------------------------
//                                EX2 exception:
//------------------------------------------------------------------------------
//1. Dest is Int:
//NV : 1. the float number is out of range of int
//NX : 1. tail is not zero
//2. Int to Float
//NX : 1. tail is not zero
//3. Double to Single
//NX : 1. tail is not zero
//     2. of
//     3. uf
//OF : 1. input is not nan or inf, and e > 8'b11111110
//UF : 1. input is not zero, and e < 381

// Dest is float
assign double_norm_f_all_1 = &ex2_double_orig_f[51:0];
assign single_norm_f_all_1 = &ex2_single0_orig_f[22:0];
assign half_norm_f_all_1   = &ex2_half0_orig_f[9:0];
assign bhalf_norm_f_all_1  = &ex2_bhalf0_orig_f[6:0];
assign double_expnt_add    = double_norm_f_all_1 && ex2_round_add && !ex2_widden_quod_up_dn;
assign single_expnt_add    = single_norm_f_all_1 && ex2_round_add&& !ex2_widden_quod_up_dn;
assign half_expnt_add      = half_norm_f_all_1 && ex2_round_add;
assign bhalf_expnt_add     = bhalf_norm_f_all_1 && ex2_round_add;

assign ex2_itof_l_h_expnt_of = (double_pipe_ex2_widden_dn_itof_expnt[5:0] <=6'd47)&&!ex2_src_is_0;
assign ex2_itof_l_h_potnt_of = double_pipe_ex2_widden_dn_itof_expnt[5:0] ==6'd48;
assign ex2_itof_w_h_expnt_of = (double_pipe_ex2_widden_dn_itof_expnt[5:0] <=6'd15)&&!ex2_src_is_0;
assign ex2_itof_w_h_potnt_of = double_pipe_ex2_widden_dn_itof_expnt[5:0] ==6'd16;
assign ex2_itof_h_h_potnt_of = (double_pipe_ex2_widden_dn_itof_expnt[5:0] ==6'd0)&&!ex2_src_is_0;
assign ex2_itof_h_expnt_of     = ex2_src_l64 && ex2_itof_l_h_expnt_of || ex2_src_l32 && ex2_itof_w_h_expnt_of;
assign ex2_itof_h_potnt_of     = ex2_src_l64 && ex2_itof_l_h_potnt_of || ex2_src_l32 && ex2_itof_w_h_potnt_of 
                                 || ex2_src_l16 && ex2_itof_h_h_potnt_of ;
assign ex2_half_norm_expnt_of  = ex2_op_itof ? ex2_itof_h_expnt_of 
                                             : !ex2_expnt[11] && (ex2_expnt[11:0] >= 12'h010);
assign ex2_half_norm_potnt_of  = ex2_op_itof ? ex2_itof_h_potnt_of
                                             : !ex2_expnt[11] && (ex2_expnt[11:0] == 12'h0f );




assign ex2_single_expnt_of = !ex2_expnt[11]  && (ex2_expnt[11:0] >= 12'h080) ||
                             (ex2_expnt[11:0] == 12'h07f) && single_expnt_add;
assign ex2_half_expnt_of  =  ex2_half_norm_expnt_of||
                             ex2_half_norm_potnt_of && half_expnt_add;
assign ex2_bhalf_expnt_of = !ex2_expnt[11]  && (ex2_expnt[11:0] >= 12'h080) ||
                             (ex2_expnt[11:0] == 12'h07f) && bhalf_expnt_add;

assign ex2_single_of       = ex2_dest_single && ex2_single_expnt_of   && ex2_dest_float && !ex2_special_vld;
assign ex2_half_of         = ex2_dest_half && ex2_half_expnt_of   && ex2_dest_float && !ex2_special_vld;
assign ex2_bhalf_of        = ex2_dest_bhalf && ex2_bhalf_expnt_of   && ex2_dest_float && !ex2_special_vld;
assign ex2_single_uf       = ex2_dest_single && ex2_narrow_dn   && !(single_norm_f_all_1 && single_expnt_add) && ex2_expt_nx_t && !ex2_special_vld;
assign ex2_half_uf         = ex2_dest_half && ex2_narrow_dn   && !(half_norm_f_all_1 && half_expnt_add) && ex2_expt_nx_t && !ex2_special_vld;
assign ex2_bhalf_uf        = ex2_dest_bhalf && ex2_narrow_dn   && !(bhalf_norm_f_all_1 && bhalf_expnt_add) && ex2_expt_nx_t && !ex2_special_vld;


assign ex2_expt_of   = ex2_single_of || ex2_half_of || ex2_bhalf_of;
assign ex2_expt_uf   = ex2_single_uf || ex2_half_uf || ex2_bhalf_uf;
assign ex2_expt_nx_t = !ex2_x_zero&& !ex2_special_vld && !ex2_src_is_0; // including int nx

assign ex2_expt_nv_f = 1'b0;

// Dest is int
assign ex2_tosi64_pos_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd62);
assign ex2_tosi64_neg_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd63);
assign ex2_tosi64_neg_exp_crit_of =  ex2_expnt[11:0] == 12'd63;
assign ex2_tosi64_potnt_exp_uf    = ex2_int_for_rnd[63] && |ex2_int_for_rnd[62:0];

assign ex2_tosi64_of              = ex2_dest_l64 && ex2_dest_si && !ex2_sign && (ex2_tosi64_pos_exp_of || ex2_int_for_rnd[63]);
assign ex2_tosi64_uf              = ex2_dest_l64 && ex2_dest_si &&  ex2_sign && (ex2_tosi64_neg_exp_of || ex2_tosi64_neg_exp_crit_of && ex2_tosi64_potnt_exp_uf);

assign ex2_toui64_exp_of          = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd63);
assign ex2_toui64_of              = ex2_dest_l64 && !ex2_dest_si && !ex2_sign && (ex2_toui64_exp_of);
assign ex2_toui64_uf              = ex2_dest_l64 && !ex2_dest_si &&  ex2_sign && (!ex2_expnt[11]  || ex2_round_add);


assign ex2_tosi_pos_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd30);
assign ex2_tosi_neg_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd31);
assign ex2_tosi_neg_exp_crit_of =  ex2_expnt[11:0] == 12'd31;

assign ex2_tosi_of              = ex2_dest_l32 && ex2_dest_si && !ex2_sign && (ex2_tosi_pos_exp_of || ex2_int_nm_result[31]);
assign ex2_tosi_uf              = ex2_dest_l32 && ex2_dest_si &&  ex2_sign && (ex2_tosi_neg_exp_of || ex2_tosi_neg_exp_crit_of && !ex2_int_nm_result[31]);

assign ex2_toui_exp_of          = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd31);
assign ex2_toui_of              = ex2_dest_l32 && !ex2_dest_si && !ex2_sign && (ex2_toui_exp_of || ex2_uint_nm_result[32]);
assign ex2_toui_uf              = ex2_dest_l32 && !ex2_dest_si &&  ex2_sign && (!ex2_expnt[11]  || ex2_round_add);

assign ex2_tosi16_pos_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd14);
assign ex2_tosi16_neg_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd15);
assign ex2_tosi16_neg_exp_crit_of =  ex2_expnt[11:0] == 12'd15;

assign ex2_tosi16_of              = ex2_dest_l16 && ex2_dest_si && !ex2_sign && (ex2_tosi16_pos_exp_of || ex2_int_nm_result[15]);
assign ex2_tosi16_uf              = ex2_dest_l16 && ex2_dest_si &&  ex2_sign && (ex2_tosi16_neg_exp_of || ex2_tosi16_neg_exp_crit_of && !ex2_int_nm_result[15]);

assign ex2_toui16_exp_of          = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd15);
assign ex2_toui16_of              = ex2_dest_l16 && !ex2_dest_si && !ex2_sign && (ex2_toui16_exp_of || ex2_uint_nm_result[16]);
assign ex2_toui16_uf              = ex2_dest_l16 && !ex2_dest_si &&  ex2_sign && (!ex2_expnt[11]  || ex2_round_add);

assign ex2_tosi8_pos_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd6);
assign ex2_tosi8_neg_exp_of      = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd7);
assign ex2_tosi8_neg_exp_crit_of =  ex2_expnt[11:0] == 12'd7;

assign ex2_tosi8_of              = ex2_dest_l8 && ex2_dest_si && !ex2_sign && (ex2_tosi8_pos_exp_of || ex2_int_nm_result[7]);
assign ex2_tosi8_uf              = ex2_dest_l8 && ex2_dest_si &&  ex2_sign && (ex2_tosi8_neg_exp_of || ex2_tosi8_neg_exp_crit_of && !ex2_int_nm_result[7]);

assign ex2_toui8_exp_of          = !ex2_expnt[11] && (ex2_expnt[10:0] > 11'd7);
assign ex2_toui8_of              = ex2_dest_l8 && !ex2_dest_si && !ex2_sign && (ex2_toui8_exp_of || ex2_uint_nm_result[8]);
assign ex2_toui8_uf              = ex2_dest_l8 && !ex2_dest_si &&  ex2_sign && (!ex2_expnt[11]  || ex2_round_add);


assign ex2_expt_nv_i            =  ex2_tosi64_of || ex2_tosi64_uf || ex2_toui64_of || ex2_toui64_uf ||
                                   ex2_tosi_of || ex2_tosi_uf || ex2_toui_of || ex2_toui_uf         ||
                                   ex2_tosi16_of || ex2_tosi16_uf || ex2_toui16_of || ex2_toui16_uf ||
                                   ex2_tosi8_of || ex2_tosi8_uf || ex2_toui8_of || ex2_toui8_uf;
assign ex2_expt_nv              = !ex2_dest_float && ex2_expt_nv_i || ex2_expt_nv_f || ex2_nv;

// Finally, NX expt, here nx_t include uf
assign ex2_expt_nx              = !ex2_expt_nv && (ex2_expt_of || ex2_expt_nx_t);
assign ex2_expt[3:0]            = {ex2_expt_nv, ex2_expt_of, ex2_expt_uf, ex2_expt_nx};


//------------------------------------------------------------------------------
//                                EX2 special result:
//------------------------------------------------------------------------------
assign ex2_lfn_sel_t    = ex2_rm_rtz || ex2_rm_rup && ex2_sign || ex2_rm_rdn && !ex2_sign;
// single lfn and inf
assign ex2_r_lfn        = ex2_dest_float&&ex2_expt_of && ex2_lfn_sel_t && !ex2_special_vld;
assign ex2_r_inf        = ex2_dest_float&&ex2_expt_of && !ex2_lfn_sel_t && !ex2_special_vld;
assign ex2_r_zero       = ex2_dest_float&&ex2_src_is_0 && !ex2_special_vld;

assign ex2_double_special_result[63:0] = ex2_special_vld ? double_pipe_special_value[63:0] : {ex2_sign,63'b0};
assign ex2_double_result[63:0]    = ex2_special_vld || ex2_r_zero || !ex2_dest_float ? ex2_special_n_int_result[63:0]    
                                                                  :  ex2_double_norm_result[63:0];
assign ex2_special_n_int_result[63:0] = ex2_dest_float||ex2_special_vld ? ex2_double_special_result[63:0] 
                                                       : ex2_int64_result[63:0];
//assign ex2_single_result[63:0]    = ex2_special_vld ? {32'hffffffff,double_pipe_special_value[31:0]}:  ex2_single_norm_result[63:0];
//assign ex2_half_result[63:0]      = ex2_special_vld ? {{48{1'b1}},double_pipe_special_value[15:0]}  :  ex2_half_norm_result[63:0];
//assign ex2_bhalf_result[63:0]     = ex2_special_vld ? {{48{1'b1}},double_pipe_special_value[15:0]}  :  ex2_bhalf_norm_result[63:0];

// &CombBeg; @825
always @( ex2_r_lfn
       or ex2_bhalf_norm_result[63:0]
       or double_pipe_special_value[31:0]
       or ex2_sign
       or ex2_special_vld
       or ex2_single_norm_result[63:0]
       or ex2_half_norm_result[63:0]
       or ex2_r_zero
       or ex2_r_inf)
begin
case({ex2_special_vld,ex2_r_inf, ex2_r_lfn, ex2_r_zero})
  4'b1000:begin
         // ex2_double_result[63:0]    = {double_pipe_special_value[63:0]};
          ex2_single_result[63:0]    = {32'hffffffff,double_pipe_special_value[31:0]};
          ex2_half_result[63:0]      = {{48{1'b1}},double_pipe_special_value[15:0]};
          ex2_bhalf_result[63:0]     = {{48{1'b1}},double_pipe_special_value[15:0]};
          end      
  4'b0100:begin 
       //   ex2_double_result[63:0]    = {ex2_sign,11'h7ff,52'b0};
          ex2_single_result[63:0]    = {32'hffffffff,ex2_sign,8'hff,23'b0};
          ex2_half_result[63:0]      = {{48{1'b1}},ex2_sign,5'h1f,10'b0};
          ex2_bhalf_result[63:0]     = {{48{1'b1}},ex2_sign,8'hff,7'b0};
          end
  4'b0010:begin
       //   ex2_double_result[63:0]    = {ex2_sign,11'h7fe,{52{1'b1}}};
          ex2_single_result[63:0]    = {32'hffffffff,ex2_sign,8'hfe,{23{1'b1}}};
          ex2_half_result[63:0]      = {{48{1'b1}},ex2_sign,5'h1e,{10{1'b1}}};
          ex2_bhalf_result[63:0]     = {{48{1'b1}},ex2_sign,8'hfe,{7{1'b1}}};
          end
  4'b0001:begin
       //   ex2_double_result[63:0]    = {ex2_sign,63'b0};
          ex2_single_result[63:0]    = {32'hffffffff,ex2_sign,31'b0};
          ex2_half_result[63:0]      = {{48{1'b1}},ex2_sign,15'b0};
          ex2_bhalf_result[63:0]     = {{48{1'b1}},ex2_sign,15'b0};
          end
  default:begin
        //  ex2_double_result[63:0]   =  ex2_double_norm_result[63:0];
          ex2_single_result[63:0]   =  ex2_single_norm_result[63:0];
          ex2_half_result[63:0]     =  ex2_half_norm_result[63:0];
          ex2_bhalf_result[63:0]    =  ex2_bhalf_norm_result[63:0];
          end
endcase
// &CombEnd; @858
end
//assign ex2_int32_special_result[63:0] = {{32{double_pipe_special_value[31]}},double_pipe_special_value[31:0]};
//assign ex2_int16_special_result[63:0] = {{48{double_pipe_special_value[15]}},double_pipe_special_value[15:0]};

//------------------------------------------------------------------------------
//                                EX2 Merge final results:
//------------------------------------------------------------------------------
//assign ex2_float_result[63:0]  = ex2_dest_double ? ex2_double_result[63:0]
//                                                 : ex2_single_result[63:0];
//int result
assign ex2_int_max               = ex2_special_int[1];
assign ex2_int_min               = ex2_special_int[0];

assign int_dest_max_si64         = ex2_dest_si && (ex2_tosi64_of) || ex2_int_max;
assign int_dest_min_si64         = ex2_dest_si && ex2_tosi64_uf || ex2_int_min;
assign int_dest_max_ui64         = !ex2_dest_si && (ex2_toui64_of) || ex2_int_max;
assign int_dest_min_ui64         = !ex2_dest_si && (ex2_toui64_uf);

assign int_dest_max_si         = ex2_dest_si && (ex2_tosi_of) || ex2_int_max;
assign int_dest_min_si         = ex2_dest_si && ex2_tosi_uf || ex2_int_min;
assign int_dest_max_ui         = !ex2_dest_si && (ex2_toui_of) || ex2_int_max;
assign int_dest_min_ui         = !ex2_dest_si && (ex2_toui_of) || ex2_int_min;

assign int_dest_max_si16         = ex2_dest_si && (ex2_tosi16_of) || ex2_int_max;
assign int_dest_min_si16         = ex2_dest_si && ex2_tosi16_uf || ex2_int_min;
assign int_dest_max_ui16         = !ex2_dest_si && (ex2_toui16_of) || ex2_int_max;
assign int_dest_min_ui16         = !ex2_dest_si && (ex2_toui16_uf) || ex2_int_min;

assign int_dest_max_si8         = ex2_dest_si && (ex2_tosi8_of) || ex2_int_max;
assign int_dest_min_si8         = ex2_dest_si && ex2_tosi8_uf || ex2_int_min;
assign int_dest_max_ui8         = !ex2_dest_si && (ex2_toui8_of) || ex2_int_max;
assign int_dest_min_ui8         = !ex2_dest_si && (ex2_toui8_uf) || ex2_int_min;

assign ex2_si64_result[63:0]     = int_dest_max_si64 ? {1'b0,{63{1'b1}}} :
                                   int_dest_min_si64 ? {1'b1,63'b0}
                                                     : ex2_int_nm_result[63:0];

assign ex2_ui64_result[63:0]     = int_dest_max_ui64 ? {64{1'b1}} :
                                   int_dest_min_ui64 ? {64{1'b0}}
                                                 : ex2_uint_nm_result[63:0];
assign ex2_int64_result[63:0]    = ex2_dest_si ? ex2_si64_result[63:0]
                                               : ex2_ui64_result[63:0];
//i32
assign ex2_si32_result[31:0]     = int_dest_max_si ? {1'b0,{31{1'b1}}} :
                                   int_dest_min_si ? {1'b1,31'b0}
                                                   : ex2_int_nm_result[31:0];

assign ex2_ui32_result[31:0]     = int_dest_max_ui ? {32{1'b1}} :
                                   int_dest_min_ui   ? {32{1'b0}}
                                                 : ex2_uint_nm_result[31:0];
assign ex2_int32_result[63:0]    = ex2_dest_si ? {{32{ex2_si32_result[31]}},ex2_si32_result[31:0]}
                                               : {{32{ex2_ui32_result[31]}},ex2_ui32_result[31:0]};
//i16

assign ex2_si16_result[15:0]     = int_dest_max_si16 ? {1'b0,{15{1'b1}}} :
                                   int_dest_min_si16 ? {1'b1,15'b0}
                                                   : ex2_int_nm_result[15:0];

assign ex2_ui16_result[15:0]     = int_dest_max_ui16 ? {16{1'b1}} :
                                   int_dest_min_ui16  ? {16{1'b0}}
                                                 : ex2_uint_nm_result[15:0];
assign ex2_int16_result[63:0]    = ex2_dest_si ? {{48{ex2_si16_result[15]}},ex2_si16_result[15:0]}
                                               : {{48{ex2_ui16_result[15]}},ex2_ui16_result[15:0]};
//i8

assign ex2_si8_result[7:0]     = int_dest_max_si8 ? {1'b0,{7{1'b1}}} :
                                   int_dest_min_si8 ? {1'b1,7'b0}
                                                   : ex2_int_nm_result[7:0];

assign ex2_ui8_result[7:0]     = int_dest_max_ui8 ? {8{1'b1}} :
                                 int_dest_min_ui8  ? {8{1'b0}}
                                                 : ex2_uint_nm_result[7:0];
assign ex2_int8_result[7:0]    = ex2_dest_si ? ex2_si8_result[7:0]
                                              : ex2_ui8_result[7:0];


assign ex2_dest_sel_float      = ex2_dest_float  ;
assign ex2_l64_result[63:0]    = ex2_double_result[63:0];
assign ex2_l32_0_result[63:0]  = ex2_dest_sel_float ? ex2_single_result[63:0] :
                                 ex2_special_vld    ? {{32{double_pipe_special_value[31]}},double_pipe_special_value[31:0]}
                                                    : ex2_int32_result[63:0] ;
assign ex2_f16_result[63:0]    = ex2_dest_half ? ex2_half_result[63:0] 
                                               : ex2_bhalf_result[63:0];      
assign ex2_i16_result[63:0]    =  ex2_int16_result[63:0];
assign ex2_l8_0_result[7:0]    =  ex2_special_vld   ? double_pipe_special_value[15:8]
                                                    : ex2_int8_result[7:0];
                                              
assign ex2_l16_0_result[63:0]  = ex2_dest_sel_float ? ex2_f16_result[63:0] :
                                 ex2_special_vld    ? {{48{double_pipe_special_value[15]}},double_pipe_special_value[15:0]}
                                                    : ex2_i16_result[63:0];
// &Force("output","ex2_int64_result"); @948

assign ex2_int32_0_result[63:0]  = ex2_int32_result[63:0];
assign ex2_int16_0_result[63:0]  = ex2_int16_result[63:0];

assign double_pipe_ex2_expt[3:0] = ex2_expt[3:0];
//Output for icg
//assign fcnvt_h_rst_vld = ex2_dest_float && ex2_dest_double;


//------------------------------------------------------------------------------
//                                EX2 pipedown to EX3:
//------------------------------------------------------------------------------
always @(posedge fcnvt_ex2_pipe_double_clk)
begin
  if(fcnvt_ex2_pipedown) begin
    //ex3_expt[3:0]      <= ex2_expt[3:0];
    //ex3_dest_float     <= ex2_dest_float;
    //ex3_single         <= ex2_dest_single;
    //ex3_r_inf          <= ex2_r_inf;
    //ex3_r_lfn          <= ex2_r_lfn;
    //ex3_r_zero         <= ex2_r_zero;
    //ex3_sign           <= ex2_sign;
    ex3_double_result[63:0] <= ex2_l64_result[63:0];
  end
end
//assign double_pipe_ex3_r_inf    = ex3_r_inf;
//assign double_pipe_ex3_r_lfn    = ex3_r_lfn;
//assign double_pipe_ex3_r_zero   = ex3_r_zero;
//
//&CombBeg;
//casez({double_pipe_ex3_r_inf,double_pipe_ex3_r_lfn,double_pipe_ex3_r_zero})
//  3'b100:begin 
//          ex3_double_result[63:0]    = {ex3_sign,11'h7ff,52'b0};
//          ex3_single0_result[63:0]    = {32'hffffffff,ex2_sign,8'hff,23'b0};
//          ex3_half0_result[63:0]      = {{48{1'b1}},ex2_sign,5'h1f,10'b0};
////          ex3_bhalf0_result[63:0]     = {{48{1'b1}},ex2_sign,8'hff,7'b0};
//          end
//  3'b010:begin
//          ex3_double_result[63:0]    = {ex3_sign,11'h7fe,{52{1'b1}}};
//          ex3_single0_result[63:0]    = {32'hffffffff,ex2_sign,8'hfe,{23{1'b1}}};
//          ex3_half0_result[63:0]      = {{48{1'b1}},ex2_sign,5'h1e,{10{1'b1}}};
////          ex3_bhalf0_result[63:0]     = {{48{1'b1}},ex2_sign,8'hfe,{7{1'b1}}};
//          end
//  3'b001:begin
//          ex3_double_result[63:0]    = {ex3_sign,63'b0};
//          ex3_single0_result[63:0]    = {32'hffffffff,ex2_sign,31'b0};
//          ex3_half0_result[63:0]      = {{48{1'b1}},ex2_sign,15'b0};
////          ex3_bhalf0_result[63:0]     = {{48{1'b1}},ex2_sign,15'b0};
//          end
//  default:begin
//          ex3_double_result[63:0]   =  {double_pipe_ex3_in_result[63:0]};
//          ex3_single0_result[63:0]   =  {{32{1'b1}},double_pipe_ex3_in_result[31:0]};
//          ex3_half0_result[63:0]     =  {{48{1'b1}},double_pipe_ex3_in_result[15:0]};
////          ex3_bhalf0_result[63:0]    =  {{48{1'b1}},double_pipe_ex3_in_result[15:0]}};
//          end
//endcase
//&CombEnd;

//always @(posedge fcnvt_ex2_pipe_clk)
//begin
//  if(fcnvt_ex2_pipedown && fcnvt_h_rst_vld || ifu_vpu_warm_up) begin
//    ex3_result_h[31:0] <= ex2_total_result[63:32];
//  end
//end
//
//assign ex3_result[63:0]          = {ex3_result_h[31:0], ex3_result_l[31:0]};
//assign fcnvt_ex3_result[63:0]    = ex3_single ? {32'hffffffff,ex3_result[31:0]} : ex3_result[63:0];
//assign fcnvt_ex3_expt[4:0]       = {ex3_expt[3], 1'b0, ex3_expt[2:0]};
//
//
////------------------------------------------------------------------------------
////                            EX3 float result rename for output:
////------------------------------------------------------------------------------
//assign fcnvt_ex3_dp_fflags[4:0]  = fcnvt_ex3_expt[4:0];
//assign fcnvt_ex3_dp_rst[63:0]    = fcnvt_ex3_result[63:0];
//assign fcnvt_ex3_dp_wb_vld       = ex3_dest_float && fcnvt_ex3_sel && falu_ctrl_xx_ex3_vld;
//
//
////------------------------------------------------------------------------------
////                            EX3 int result rename for output:
////------------------------------------------------------------------------------
//assign fcnvt_ex3_rtu_fflags[4:0] = fcnvt_ex3_expt[4:0];
//assign fcnvt_ex3_rtu_rst[31:0]   = fcnvt_ex3_result[31:0];
//assign fcnvt_ex3_rtu_wb_vld      = !ex3_dest_float && fcnvt_ex3_sel && falu_ctrl_xx_ex3_vld;
//assign fcnvt_ex3_dp_single       = ex3_single;



// &ModuleEnd; @1037
endmodule


