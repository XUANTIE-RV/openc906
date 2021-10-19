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
module aq_fdsu_double(
  bhalf0_denorm_shift_num,
  bhalf0_denorm_shift_num_in,
  bhalf0_denorm_shift_val,
  bhalf0_denorm_to_tiny_frac,
  bhalf0_ex1_divisor,
  bhalf0_ex1_ff1_frac,
  bhalf0_ex1_id_frac,
  bhalf0_ex1_id_frac_f,
  bhalf0_ex1_op0_id_vld,
  bhalf0_ex1_op1_id_vld,
  bhalf0_ex1_op1_sel,
  bhalf0_ex1_qnan_f,
  bhalf0_ex1_remainder,
  bhalf0_ex2_result_denorm_round_add_num,
  bhalf0_ex3_frac_add1_op1,
  bhalf0_ex3_frac_final_rst,
  bhalf0_ex3_frac_sub1_op1,
  bhalf0_ex3_frac_sub1_op2,
  bhalf0_ex4_qnan_f,
  bhalf0_remainder_nxt,
  cp0_vpu_icg_en,
  cp0_vpu_xx_dqnan,
  cp0_yy_clk_en,
  double0_denorm_shift_num,
  double0_denorm_shift_num_in,
  double0_denorm_shift_val,
  double0_denorm_to_tiny_frac,
  double0_ex1_divisor,
  double0_ex1_ff1_frac,
  double0_ex1_id_frac,
  double0_ex1_id_frac_f,
  double0_ex1_op0_id_vld,
  double0_ex1_op1_id_vld,
  double0_ex1_op1_sel,
  double0_ex1_qnan_f,
  double0_ex1_remainder,
  double0_ex2_result_denorm_round_add_num,
  double0_ex3_frac_add1_op1,
  double0_ex3_frac_final_rst,
  double0_ex3_frac_sub1_op1,
  double0_ex3_frac_sub1_op2,
  double0_ex4_qnan_f,
  double0_pipe_cur_rem_1,
  double0_pipe_cur_rem_2,
  double0_pipe_ex1_expnt_adder_op1,
  double0_pipe_ex1_ff1_sel_op1,
  double0_pipe_ex1_op0_cnan,
  double0_pipe_ex1_op0_id_expnt_neg,
  double0_pipe_ex1_op0_inf,
  double0_pipe_ex1_op0_qnan,
  double0_pipe_ex1_op0_snan,
  double0_pipe_ex1_op0_zero,
  double0_pipe_ex1_op1_cnan,
  double0_pipe_ex1_op1_id_expnt_neg,
  double0_pipe_ex1_op1_inf,
  double0_pipe_ex1_op1_qnan,
  double0_pipe_ex1_op1_snan,
  double0_pipe_ex1_op1_zero,
  double0_pipe_ex1_result_qnan,
  double0_pipe_ex1_save_op0,
  double0_pipe_ex1_srt_skip,
  double0_pipe_ex2_expnt_adder_op1,
  double0_pipe_ex2_of,
  double0_pipe_ex2_uf_srt_skip,
  double0_pipe_ex3_result_denorm_round_add_num,
  double0_pipe_ex4_expt,
  double0_pipe_ex4_result,
  double0_pipe_fdsu_ex4_frac,
  double0_pipe_frac_add1_rst,
  double0_pipe_frac_sub1_rst,
  double0_pipe_op0_ff1_cnt,
  double0_pipe_op0_id_expnt,
  double0_pipe_oper0,
  double0_pipe_oper1,
  double0_pipe_qt_rt_const_shift_std,
  double0_pipe_save_op0_neg_expnt,
  double0_pipe_srt_divisor,
  double0_pipe_srt_remainder,
  double0_pipe_srt_remainder_zero,
  double0_pipe_total_qt_rt,
  double0_pipe_total_qt_rt_minus,
  double0_remainder_nxt,
  double0_srt_remainder,
  double0_srt_remainder_add1_op1,
  double0_srt_remainder_add1_op2,
  double0_srt_remainder_add2_op1,
  double0_srt_remainder_add2_op2,
  double0_srt_remainder_shift,
  double0_total_qt_rt,
  double0_total_qt_rt_minus_next,
  double0_total_qt_rt_next,
  dp_xx_ex1_rm,
  ex1_bhalf,
  ex1_bhalf0_op0_id,
  ex1_bhalf0_op1_id,
  ex1_div,
  ex1_double,
  ex1_double0_op0_id,
  ex1_double0_op1_id,
  ex1_f16,
  ex1_half,
  ex1_half0_op0_id,
  ex1_half0_op1_id,
  ex1_pipe_clk,
  ex1_pipedown,
  ex1_single,
  ex1_single0_op0_id,
  ex1_single0_op1_id,
  ex1_sqrt,
  ex2_pipe_clk,
  ex2_pipedown,
  ex2_srt_first_round,
  ex3_pipedown,
  expnt_rst_clk,
  fdsu_ex1_sel,
  fdsu_ex2_bhalf,
  fdsu_ex2_div,
  fdsu_ex2_double,
  fdsu_ex2_half,
  fdsu_ex2_single,
  fdsu_ex2_sqrt,
  fdsu_ex3_bhalf,
  fdsu_ex3_double,
  fdsu_ex3_half,
  fdsu_ex3_single,
  fdsu_ex4_bhalf,
  fdsu_ex4_double,
  fdsu_ex4_half,
  fdsu_ex4_single,
  fdsu_yy_rm,
  forever_cpuclk,
  half0_denorm_shift_num,
  half0_denorm_shift_num_in,
  half0_denorm_shift_val,
  half0_denorm_to_tiny_frac,
  half0_ex1_divisor,
  half0_ex1_ff1_frac,
  half0_ex1_id_frac,
  half0_ex1_id_frac_f,
  half0_ex1_op0_id_vld,
  half0_ex1_op1_id_vld,
  half0_ex1_op1_sel,
  half0_ex1_qnan_f,
  half0_ex1_remainder,
  half0_ex2_result_denorm_round_add_num,
  half0_ex3_frac_add1_op1,
  half0_ex3_frac_final_rst,
  half0_ex3_frac_sub1_op1,
  half0_ex3_frac_sub1_op2,
  half0_ex4_qnan_f,
  half0_remainder_nxt,
  half0_total_qt_rt,
  half0_total_qt_rt_minus_next,
  half0_total_qt_rt_next,
  pad_yy_icg_scan_en,
  single0_denorm_shift_num,
  single0_denorm_shift_num_in,
  single0_denorm_shift_val,
  single0_denorm_to_tiny_frac,
  single0_ex1_divisor,
  single0_ex1_ff1_frac,
  single0_ex1_id_frac,
  single0_ex1_id_frac_f,
  single0_ex1_op0_id_vld,
  single0_ex1_op1_id_vld,
  single0_ex1_op1_sel,
  single0_ex1_qnan_f,
  single0_ex1_remainder,
  single0_ex2_result_denorm_round_add_num,
  single0_ex3_frac_add1_op1,
  single0_ex3_frac_final_rst,
  single0_ex3_frac_sub1_op1,
  single0_ex3_frac_sub1_op2,
  single0_ex4_qnan_f,
  single0_remainder_nxt,
  single0_total_qt_rt,
  single0_total_qt_rt_minus_next,
  single0_total_qt_rt_next
);

// &Ports; @23
input   [6 :0]  bhalf0_denorm_shift_num;                     
input   [6 :0]  bhalf0_ex1_id_frac;                          
input   [6 :0]  bhalf0_ex1_id_frac_f;                        
input           bhalf0_ex1_op1_sel;                          
input   [7 :0]  bhalf0_ex4_qnan_f;                           
input           cp0_vpu_icg_en;                              
input           cp0_vpu_xx_dqnan;                            
input           cp0_yy_clk_en;                               
input   [51:0]  double0_denorm_shift_num;                    
input   [51:0]  double0_ex1_id_frac;                         
input   [51:0]  double0_ex1_id_frac_f;                       
input           double0_ex1_op1_sel;                         
input   [52:0]  double0_ex4_qnan_f;                          
input   [59:0]  double0_pipe_cur_rem_1;                      
input   [59:0]  double0_pipe_cur_rem_2;                      
input           double0_pipe_ex1_ff1_sel_op1;                
input           double0_pipe_ex1_op0_cnan;                   
input   [12:0]  double0_pipe_ex1_op0_id_expnt_neg;           
input           double0_pipe_ex1_op0_inf;                    
input           double0_pipe_ex1_op0_qnan;                   
input           double0_pipe_ex1_op0_snan;                   
input           double0_pipe_ex1_op0_zero;                   
input           double0_pipe_ex1_op1_cnan;                   
input   [12:0]  double0_pipe_ex1_op1_id_expnt_neg;           
input           double0_pipe_ex1_op1_inf;                    
input           double0_pipe_ex1_op1_qnan;                   
input           double0_pipe_ex1_op1_snan;                   
input           double0_pipe_ex1_op1_zero;                   
input           double0_pipe_ex1_save_op0;                   
input   [12:0]  double0_pipe_ex2_expnt_adder_op1;            
input   [52:0]  double0_pipe_ex3_result_denorm_round_add_num; 
input   [54:0]  double0_pipe_fdsu_ex4_frac;                  
input   [54:0]  double0_pipe_frac_add1_rst;                  
input   [54:0]  double0_pipe_frac_sub1_rst;                  
input   [12:0]  double0_pipe_op0_ff1_cnt;                    
input   [63:0]  double0_pipe_oper0;                          
input   [63:0]  double0_pipe_oper1;                          
input   [57:0]  double0_pipe_qt_rt_const_shift_std;          
input           double0_pipe_save_op0_neg_expnt;             
input   [52:0]  double0_pipe_srt_divisor;                    
input   [59:0]  double0_pipe_srt_remainder;                  
input   [57:0]  double0_pipe_total_qt_rt;                    
input   [57:0]  double0_pipe_total_qt_rt_minus;              
input   [59:0]  double0_srt_remainder;                       
input   [57:0]  double0_total_qt_rt;                         
input   [2 :0]  dp_xx_ex1_rm;                                
input           ex1_bhalf;                                   
input           ex1_bhalf0_op0_id;                           
input           ex1_bhalf0_op1_id;                           
input           ex1_div;                                     
input           ex1_double;                                  
input           ex1_double0_op0_id;                          
input           ex1_double0_op1_id;                          
input           ex1_f16;                                     
input           ex1_half;                                    
input           ex1_half0_op0_id;                            
input           ex1_half0_op1_id;                            
input           ex1_pipe_clk;                                
input           ex1_pipedown;                                
input           ex1_single;                                  
input           ex1_single0_op0_id;                          
input           ex1_single0_op1_id;                          
input           ex1_sqrt;                                    
input           ex2_pipe_clk;                                
input           ex2_pipedown;                                
input           ex2_srt_first_round;                         
input           ex3_pipedown;                                
input           expnt_rst_clk;                               
input           fdsu_ex1_sel;                                
input           fdsu_ex2_bhalf;                              
input           fdsu_ex2_div;                                
input           fdsu_ex2_double;                             
input           fdsu_ex2_half;                               
input           fdsu_ex2_single;                             
input           fdsu_ex2_sqrt;                               
input           fdsu_ex3_bhalf;                              
input           fdsu_ex3_double;                             
input           fdsu_ex3_half;                               
input           fdsu_ex3_single;                             
input           fdsu_ex4_bhalf;                              
input           fdsu_ex4_double;                             
input           fdsu_ex4_half;                               
input           fdsu_ex4_single;                             
input   [2 :0]  fdsu_yy_rm;                                  
input           forever_cpuclk;                              
input   [9 :0]  half0_denorm_shift_num;                      
input   [9 :0]  half0_ex1_id_frac;                           
input   [9 :0]  half0_ex1_id_frac_f;                         
input           half0_ex1_op1_sel;                           
input   [10:0]  half0_ex4_qnan_f;                            
input   [15:0]  half0_total_qt_rt;                           
input           pad_yy_icg_scan_en;                          
input   [22:0]  single0_denorm_shift_num;                    
input   [22:0]  single0_ex1_id_frac;                         
input   [22:0]  single0_ex1_id_frac_f;                       
input           single0_ex1_op1_sel;                         
input   [23:0]  single0_ex4_qnan_f;                          
input   [27:0]  single0_total_qt_rt;                         
output  [6 :0]  bhalf0_denorm_shift_num_in;                  
output  [8 :0]  bhalf0_denorm_shift_val;                     
output          bhalf0_denorm_to_tiny_frac;                  
output  [7 :0]  bhalf0_ex1_divisor;                          
output  [6 :0]  bhalf0_ex1_ff1_frac;                         
output          bhalf0_ex1_op0_id_vld;                       
output          bhalf0_ex1_op1_id_vld;                       
output  [7 :0]  bhalf0_ex1_qnan_f;                           
output  [14:0]  bhalf0_ex1_remainder;                        
output  [7 :0]  bhalf0_ex2_result_denorm_round_add_num;      
output  [9 :0]  bhalf0_ex3_frac_add1_op1;                    
output  [9 :0]  bhalf0_ex3_frac_final_rst;                   
output  [9 :0]  bhalf0_ex3_frac_sub1_op1;                    
output  [9 :0]  bhalf0_ex3_frac_sub1_op2;                    
output  [14:0]  bhalf0_remainder_nxt;                        
output  [51:0]  double0_denorm_shift_num_in;                 
output  [11:0]  double0_denorm_shift_val;                    
output          double0_denorm_to_tiny_frac;                 
output  [52:0]  double0_ex1_divisor;                         
output  [51:0]  double0_ex1_ff1_frac;                        
output          double0_ex1_op0_id_vld;                      
output          double0_ex1_op1_id_vld;                      
output  [52:0]  double0_ex1_qnan_f;                          
output  [59:0]  double0_ex1_remainder;                       
output  [52:0]  double0_ex2_result_denorm_round_add_num;     
output  [54:0]  double0_ex3_frac_add1_op1;                   
output  [54:0]  double0_ex3_frac_final_rst;                  
output  [54:0]  double0_ex3_frac_sub1_op1;                   
output  [54:0]  double0_ex3_frac_sub1_op2;                   
output  [12:0]  double0_pipe_ex1_expnt_adder_op1;            
output          double0_pipe_ex1_result_qnan;                
output          double0_pipe_ex1_srt_skip;                   
output          double0_pipe_ex2_of;                         
output          double0_pipe_ex2_uf_srt_skip;                
output  [4 :0]  double0_pipe_ex4_expt;                       
output  [63:0]  double0_pipe_ex4_result;                     
output  [12:0]  double0_pipe_op0_id_expnt;                   
output          double0_pipe_srt_remainder_zero;             
output  [59:0]  double0_remainder_nxt;                       
output  [59:0]  double0_srt_remainder_add1_op1;              
output  [59:0]  double0_srt_remainder_add1_op2;              
output  [59:0]  double0_srt_remainder_add2_op1;              
output  [59:0]  double0_srt_remainder_add2_op2;              
output  [59:0]  double0_srt_remainder_shift;                 
output  [57:0]  double0_total_qt_rt_minus_next;              
output  [57:0]  double0_total_qt_rt_next;                    
output  [9 :0]  half0_denorm_shift_num_in;                   
output  [5 :0]  half0_denorm_shift_val;                      
output          half0_denorm_to_tiny_frac;                   
output  [10:0]  half0_ex1_divisor;                           
output  [9 :0]  half0_ex1_ff1_frac;                          
output          half0_ex1_op0_id_vld;                        
output          half0_ex1_op1_id_vld;                        
output  [10:0]  half0_ex1_qnan_f;                            
output  [18:0]  half0_ex1_remainder;                         
output  [10:0]  half0_ex2_result_denorm_round_add_num;       
output  [12:0]  half0_ex3_frac_add1_op1;                     
output  [12:0]  half0_ex3_frac_final_rst;                    
output  [12:0]  half0_ex3_frac_sub1_op1;                     
output  [12:0]  half0_ex3_frac_sub1_op2;                     
output  [18:0]  half0_remainder_nxt;                         
output  [15:0]  half0_total_qt_rt_minus_next;                
output  [15:0]  half0_total_qt_rt_next;                      
output  [22:0]  single0_denorm_shift_num_in;                 
output  [8 :0]  single0_denorm_shift_val;                    
output          single0_denorm_to_tiny_frac;                 
output  [23:0]  single0_ex1_divisor;                         
output  [22:0]  single0_ex1_ff1_frac;                        
output          single0_ex1_op0_id_vld;                      
output          single0_ex1_op1_id_vld;                      
output  [23:0]  single0_ex1_qnan_f;                          
output  [30:0]  single0_ex1_remainder;                       
output  [23:0]  single0_ex2_result_denorm_round_add_num;     
output  [25:0]  single0_ex3_frac_add1_op1;                   
output  [25:0]  single0_ex3_frac_final_rst;                  
output  [25:0]  single0_ex3_frac_sub1_op1;                   
output  [25:0]  single0_ex3_frac_sub1_op2;                   
output  [30:0]  single0_remainder_nxt;                       
output  [27:0]  single0_total_qt_rt_minus_next;              
output  [27:0]  single0_total_qt_rt_next;                    

// &Regs; @24

// &Wires; @25
wire    [6 :0]  bhalf0_denorm_shift_num;                     
wire    [6 :0]  bhalf0_denorm_shift_num_in;                  
wire    [8 :0]  bhalf0_denorm_shift_val;                     
wire            bhalf0_denorm_to_tiny_frac;                  
wire    [7 :0]  bhalf0_ex1_divisor;                          
wire    [6 :0]  bhalf0_ex1_ff1_frac;                         
wire    [6 :0]  bhalf0_ex1_id_frac;                          
wire    [6 :0]  bhalf0_ex1_id_frac_f;                        
wire            bhalf0_ex1_op0_id_vld;                       
wire            bhalf0_ex1_op1_id_vld;                       
wire            bhalf0_ex1_op1_sel;                          
wire    [7 :0]  bhalf0_ex1_qnan_f;                           
wire    [14:0]  bhalf0_ex1_remainder;                        
wire    [7 :0]  bhalf0_ex2_result_denorm_round_add_num;      
wire    [9 :0]  bhalf0_ex3_frac_add1_op1;                    
wire    [9 :0]  bhalf0_ex3_frac_final_rst;                   
wire    [9 :0]  bhalf0_ex3_frac_sub1_op1;                    
wire    [9 :0]  bhalf0_ex3_frac_sub1_op2;                    
wire    [7 :0]  bhalf0_ex4_qnan_f;                           
wire    [14:0]  bhalf0_remainder_nxt;                        
wire            cp0_vpu_icg_en;                              
wire            cp0_vpu_xx_dqnan;                            
wire            cp0_yy_clk_en;                               
wire    [51:0]  double0_denorm_shift_num;                    
wire    [51:0]  double0_denorm_shift_num_in;                 
wire    [11:0]  double0_denorm_shift_val;                    
wire            double0_denorm_to_tiny_frac;                 
wire    [52:0]  double0_ex1_divisor;                         
wire    [51:0]  double0_ex1_ff1_frac;                        
wire    [51:0]  double0_ex1_id_frac;                         
wire    [51:0]  double0_ex1_id_frac_f;                       
wire            double0_ex1_op0_id_vld;                      
wire            double0_ex1_op1_id_vld;                      
wire            double0_ex1_op1_sel;                         
wire    [52:0]  double0_ex1_qnan_f;                          
wire    [59:0]  double0_ex1_remainder;                       
wire    [52:0]  double0_ex2_result_denorm_round_add_num;     
wire    [54:0]  double0_ex3_frac_add1_op1;                   
wire    [54:0]  double0_ex3_frac_final_rst;                  
wire    [54:0]  double0_ex3_frac_sub1_op1;                   
wire    [54:0]  double0_ex3_frac_sub1_op2;                   
wire    [52:0]  double0_ex4_qnan_f;                          
wire    [59:0]  double0_pipe_cur_rem_1;                      
wire    [59:0]  double0_pipe_cur_rem_2;                      
wire            double0_pipe_ex1_dz;                         
wire    [12:0]  double0_pipe_ex1_expnt_adder_op0;            
wire    [12:0]  double0_pipe_ex1_expnt_adder_op1;            
wire            double0_pipe_ex1_ff1_sel_op1;                
wire    [12:0]  double0_pipe_ex1_id_expnt_f;                 
wire            double0_pipe_ex1_nv;                         
wire            double0_pipe_ex1_of_result_lfn;              
wire            double0_pipe_ex1_op0_cnan;                   
wire    [12:0]  double0_pipe_ex1_op0_id_expnt_neg;           
wire            double0_pipe_ex1_op0_inf;                    
wire            double0_pipe_ex1_op0_norm;                   
wire            double0_pipe_ex1_op0_qnan;                   
wire            double0_pipe_ex1_op0_snan;                   
wire            double0_pipe_ex1_op0_zero;                   
wire            double0_pipe_ex1_op1_cnan;                   
wire    [12:0]  double0_pipe_ex1_op1_id_expnt_neg;           
wire            double0_pipe_ex1_op1_inf;                    
wire            double0_pipe_ex1_op1_norm;                   
wire            double0_pipe_ex1_op1_qnan;                   
wire            double0_pipe_ex1_op1_snan;                   
wire            double0_pipe_ex1_op1_zero;                   
wire            double0_pipe_ex1_result_inf;                 
wire            double0_pipe_ex1_result_lfn;                 
wire            double0_pipe_ex1_result_qnan;                
wire            double0_pipe_ex1_result_sign;                
wire            double0_pipe_ex1_result_zero;                
wire            double0_pipe_ex1_save_op0;                   
wire            double0_pipe_ex1_srt_skip;                   
wire    [12:0]  double0_pipe_ex2_expnt_adder_op0;            
wire    [12:0]  double0_pipe_ex2_expnt_adder_op1;            
wire            double0_pipe_ex2_of;                         
wire            double0_pipe_ex2_of_rm_lfn;                  
wire            double0_pipe_ex2_op0_norm;                   
wire            double0_pipe_ex2_op1_norm;                   
wire            double0_pipe_ex2_potnt_of;                   
wire            double0_pipe_ex2_potnt_uf;                   
wire            double0_pipe_ex2_result_inf;                 
wire            double0_pipe_ex2_result_lfn;                 
wire            double0_pipe_ex2_rslt_denorm;                
wire    [12:0]  double0_pipe_ex2_srt_expnt_rst;              
wire            double0_pipe_ex2_uf;                         
wire            double0_pipe_ex2_uf_srt_skip;                
wire    [12:0]  double0_pipe_ex3_expnt_adjust_result;        
wire    [12:0]  double0_pipe_ex3_expnt_rst;                  
wire            double0_pipe_ex3_potnt_uf;                   
wire    [52:0]  double0_pipe_ex3_result_denorm_round_add_num; 
wire            double0_pipe_ex3_result_inf;                 
wire            double0_pipe_ex3_result_lfn;                 
wire            double0_pipe_ex3_result_qnan;                
wire            double0_pipe_ex3_result_sign;                
wire            double0_pipe_ex3_result_zero;                
wire            double0_pipe_ex3_rslt_denorm;                
wire            double0_pipe_ex3_rslt_denorm_in;             
wire            double0_pipe_ex4_denorm_to_tiny_frac;        
wire            double0_pipe_ex4_dz;                         
wire    [12:0]  double0_pipe_ex4_expnt_rst;                  
wire    [4 :0]  double0_pipe_ex4_expt;                       
wire            double0_pipe_ex4_nv;                         
wire            double0_pipe_ex4_nx;                         
wire            double0_pipe_ex4_of;                         
wire            double0_pipe_ex4_of_rm_lfn;                  
wire    [1 :0]  double0_pipe_ex4_potnt_norm;                 
wire            double0_pipe_ex4_potnt_of;                   
wire            double0_pipe_ex4_potnt_uf;                   
wire    [63:0]  double0_pipe_ex4_result;                     
wire            double0_pipe_ex4_result_inf;                 
wire            double0_pipe_ex4_result_lfn;                 
wire            double0_pipe_ex4_result_nor;                 
wire            double0_pipe_ex4_result_qnan;                
wire            double0_pipe_ex4_result_sign;                
wire            double0_pipe_ex4_result_zero;                
wire            double0_pipe_ex4_rslt_denorm;                
wire            double0_pipe_ex4_uf;                         
wire    [54:0]  double0_pipe_fdsu_ex4_frac;                  
wire    [54:0]  double0_pipe_frac_add1_rst;                  
wire    [54:0]  double0_pipe_frac_sub1_rst;                  
wire    [12:0]  double0_pipe_op0_ff1_cnt;                    
wire    [12:0]  double0_pipe_op0_id_expnt;                   
wire    [63:0]  double0_pipe_oper0;                          
wire    [63:0]  double0_pipe_oper1;                          
wire    [57:0]  double0_pipe_qt_rt_const_shift_std;          
wire            double0_pipe_save_op0_neg_expnt;             
wire    [52:0]  double0_pipe_srt_divisor;                    
wire    [59:0]  double0_pipe_srt_remainder;                  
wire            double0_pipe_srt_remainder_zero;             
wire    [57:0]  double0_pipe_total_qt_rt;                    
wire    [57:0]  double0_pipe_total_qt_rt_minus;              
wire    [59:0]  double0_remainder_nxt;                       
wire    [59:0]  double0_srt_remainder;                       
wire    [59:0]  double0_srt_remainder_add1_op1;              
wire    [59:0]  double0_srt_remainder_add1_op2;              
wire    [59:0]  double0_srt_remainder_add2_op1;              
wire    [59:0]  double0_srt_remainder_add2_op2;              
wire    [59:0]  double0_srt_remainder_shift;                 
wire    [57:0]  double0_total_qt_rt;                         
wire    [57:0]  double0_total_qt_rt_minus_next;              
wire    [57:0]  double0_total_qt_rt_next;                    
wire    [2 :0]  dp_xx_ex1_rm;                                
wire            ex1_bhalf;                                   
wire            ex1_bhalf0_op0_id;                           
wire            ex1_bhalf0_op1_id;                           
wire            ex1_div;                                     
wire            ex1_double;                                  
wire            ex1_double0_op0_id;                          
wire            ex1_double0_op1_id;                          
wire            ex1_f16;                                     
wire            ex1_half;                                    
wire            ex1_half0_op0_id;                            
wire            ex1_half0_op1_id;                            
wire            ex1_op0_sign;                                
wire    [63:0]  ex1_oper0;                                   
wire    [63:0]  ex1_oper1;                                   
wire            ex1_pipe_clk;                                
wire            ex1_pipedown;                                
wire            ex1_single;                                  
wire            ex1_single0_op0_id;                          
wire            ex1_single0_op1_id;                          
wire            ex1_sqrt;                                    
wire            ex2_pipe_clk;                                
wire            ex2_pipedown;                                
wire            ex2_srt_first_round;                         
wire            ex3_pipedown;                                
wire            expnt_rst_clk;                               
wire            fdsu_ex1_sel;                                
wire            fdsu_ex2_bhalf;                              
wire            fdsu_ex2_div;                                
wire            fdsu_ex2_double;                             
wire            fdsu_ex2_half;                               
wire            fdsu_ex2_single;                             
wire            fdsu_ex2_sqrt;                               
wire            fdsu_ex3_bhalf;                              
wire            fdsu_ex3_double;                             
wire            fdsu_ex3_half;                               
wire            fdsu_ex3_id_srt_skip;                        
wire            fdsu_ex3_rem_sign;                           
wire            fdsu_ex3_rem_zero;                           
wire            fdsu_ex3_single;                             
wire            fdsu_ex4_bhalf;                              
wire            fdsu_ex4_double;                             
wire            fdsu_ex4_half;                               
wire            fdsu_ex4_single;                             
wire    [2 :0]  fdsu_yy_rm;                                  
wire            forever_cpuclk;                              
wire    [9 :0]  half0_denorm_shift_num;                      
wire    [9 :0]  half0_denorm_shift_num_in;                   
wire    [5 :0]  half0_denorm_shift_val;                      
wire            half0_denorm_to_tiny_frac;                   
wire    [10:0]  half0_ex1_divisor;                           
wire    [9 :0]  half0_ex1_ff1_frac;                          
wire    [9 :0]  half0_ex1_id_frac;                           
wire    [9 :0]  half0_ex1_id_frac_f;                         
wire            half0_ex1_op0_id_vld;                        
wire            half0_ex1_op1_id_vld;                        
wire            half0_ex1_op1_sel;                           
wire    [10:0]  half0_ex1_qnan_f;                            
wire    [18:0]  half0_ex1_remainder;                         
wire    [10:0]  half0_ex2_result_denorm_round_add_num;       
wire    [12:0]  half0_ex3_frac_add1_op1;                     
wire    [12:0]  half0_ex3_frac_final_rst;                    
wire    [12:0]  half0_ex3_frac_sub1_op1;                     
wire    [12:0]  half0_ex3_frac_sub1_op2;                     
wire    [10:0]  half0_ex4_qnan_f;                            
wire    [18:0]  half0_remainder_nxt;                         
wire    [15:0]  half0_total_qt_rt;                           
wire    [15:0]  half0_total_qt_rt_minus_next;                
wire    [15:0]  half0_total_qt_rt_next;                      
wire            pad_yy_icg_scan_en;                          
wire    [22:0]  single0_denorm_shift_num;                    
wire    [22:0]  single0_denorm_shift_num_in;                 
wire    [8 :0]  single0_denorm_shift_val;                    
wire            single0_denorm_to_tiny_frac;                 
wire    [23:0]  single0_ex1_divisor;                         
wire    [22:0]  single0_ex1_ff1_frac;                        
wire    [22:0]  single0_ex1_id_frac;                         
wire    [22:0]  single0_ex1_id_frac_f;                       
wire            single0_ex1_op0_id_vld;                      
wire            single0_ex1_op1_id_vld;                      
wire            single0_ex1_op1_sel;                         
wire    [23:0]  single0_ex1_qnan_f;                          
wire    [30:0]  single0_ex1_remainder;                       
wire    [23:0]  single0_ex2_result_denorm_round_add_num;     
wire    [25:0]  single0_ex3_frac_add1_op1;                   
wire    [25:0]  single0_ex3_frac_final_rst;                  
wire    [25:0]  single0_ex3_frac_sub1_op1;                   
wire    [25:0]  single0_ex3_frac_sub1_op2;                   
wire    [23:0]  single0_ex4_qnan_f;                          
wire    [30:0]  single0_remainder_nxt;                       
wire    [27:0]  single0_total_qt_rt;                         
wire    [27:0]  single0_total_qt_rt_minus_next;              
wire    [27:0]  single0_total_qt_rt_next;                    

// &ConnRule(s/double_/double0_/); @26
// &Instance("aq_fdsu_special"); @27
aq_fdsu_special  x_aq_fdsu_special (
  .bhalf0_ex1_qnan_f            (bhalf0_ex1_qnan_f           ),
  .cp0_vpu_xx_dqnan             (cp0_vpu_xx_dqnan            ),
  .double_ex1_qnan_f            (double0_ex1_qnan_f          ),
  .double_pipe_ex1_dz           (double0_pipe_ex1_dz         ),
  .double_pipe_ex1_nv           (double0_pipe_ex1_nv         ),
  .double_pipe_ex1_op0_cnan     (double0_pipe_ex1_op0_cnan   ),
  .double_pipe_ex1_op0_inf      (double0_pipe_ex1_op0_inf    ),
  .double_pipe_ex1_op0_norm     (double0_pipe_ex1_op0_norm   ),
  .double_pipe_ex1_op0_qnan     (double0_pipe_ex1_op0_qnan   ),
  .double_pipe_ex1_op0_snan     (double0_pipe_ex1_op0_snan   ),
  .double_pipe_ex1_op0_zero     (double0_pipe_ex1_op0_zero   ),
  .double_pipe_ex1_op1_cnan     (double0_pipe_ex1_op1_cnan   ),
  .double_pipe_ex1_op1_inf      (double0_pipe_ex1_op1_inf    ),
  .double_pipe_ex1_op1_norm     (double0_pipe_ex1_op1_norm   ),
  .double_pipe_ex1_op1_qnan     (double0_pipe_ex1_op1_qnan   ),
  .double_pipe_ex1_op1_snan     (double0_pipe_ex1_op1_snan   ),
  .double_pipe_ex1_op1_zero     (double0_pipe_ex1_op1_zero   ),
  .double_pipe_ex1_result_inf   (double0_pipe_ex1_result_inf ),
  .double_pipe_ex1_result_lfn   (double0_pipe_ex1_result_lfn ),
  .double_pipe_ex1_result_qnan  (double0_pipe_ex1_result_qnan),
  .double_pipe_ex1_result_zero  (double0_pipe_ex1_result_zero),
  .double_pipe_ex1_srt_skip     (double0_pipe_ex1_srt_skip   ),
  .ex1_div                      (ex1_div                     ),
  .ex1_op0_sign                 (ex1_op0_sign                ),
  .ex1_oper0                    (ex1_oper0                   ),
  .ex1_oper1                    (ex1_oper1                   ),
  .ex1_sqrt                     (ex1_sqrt                    ),
  .half0_ex1_qnan_f             (half0_ex1_qnan_f            ),
  .single0_ex1_qnan_f           (single0_ex1_qnan_f          )
);

// &ConnRule(s/double_/double0_/); @28
// &Instance("aq_fdsu_prepare"); @29
aq_fdsu_prepare  x_aq_fdsu_prepare (
  .bhalf0_ex1_divisor                (bhalf0_ex1_divisor               ),
  .bhalf0_ex1_ff1_frac               (bhalf0_ex1_ff1_frac              ),
  .bhalf0_ex1_id_frac                (bhalf0_ex1_id_frac               ),
  .bhalf0_ex1_id_frac_f              (bhalf0_ex1_id_frac_f             ),
  .bhalf0_ex1_op0_id_vld             (bhalf0_ex1_op0_id_vld            ),
  .bhalf0_ex1_op1_id_vld             (bhalf0_ex1_op1_id_vld            ),
  .bhalf0_ex1_op1_sel                (bhalf0_ex1_op1_sel               ),
  .bhalf0_ex1_remainder              (bhalf0_ex1_remainder             ),
  .double_ex1_divisor                (double0_ex1_divisor              ),
  .double_ex1_ff1_frac               (double0_ex1_ff1_frac             ),
  .double_ex1_id_frac                (double0_ex1_id_frac              ),
  .double_ex1_id_frac_f              (double0_ex1_id_frac_f            ),
  .double_ex1_op0_id_vld             (double0_ex1_op0_id_vld           ),
  .double_ex1_op1_id_vld             (double0_ex1_op1_id_vld           ),
  .double_ex1_op1_sel                (double0_ex1_op1_sel              ),
  .double_ex1_remainder              (double0_ex1_remainder            ),
  .double_pipe_ex1_expnt_adder_op0   (double0_pipe_ex1_expnt_adder_op0 ),
  .double_pipe_ex1_expnt_adder_op1   (double0_pipe_ex1_expnt_adder_op1 ),
  .double_pipe_ex1_ff1_sel_op1       (double0_pipe_ex1_ff1_sel_op1     ),
  .double_pipe_ex1_id_expnt_f        (double0_pipe_ex1_id_expnt_f      ),
  .double_pipe_ex1_of_result_lfn     (double0_pipe_ex1_of_result_lfn   ),
  .double_pipe_ex1_op0_id_expnt_neg  (double0_pipe_ex1_op0_id_expnt_neg),
  .double_pipe_ex1_op1_id_expnt_neg  (double0_pipe_ex1_op1_id_expnt_neg),
  .double_pipe_ex1_result_sign       (double0_pipe_ex1_result_sign     ),
  .double_pipe_oper0                 (double0_pipe_oper0               ),
  .double_pipe_oper1                 (double0_pipe_oper1               ),
  .dp_xx_ex1_rm                      (dp_xx_ex1_rm                     ),
  .ex1_bhalf                         (ex1_bhalf                        ),
  .ex1_bhalf0_op0_id                 (ex1_bhalf0_op0_id                ),
  .ex1_bhalf0_op1_id                 (ex1_bhalf0_op1_id                ),
  .ex1_div                           (ex1_div                          ),
  .ex1_double                        (ex1_double                       ),
  .ex1_double_op0_id                 (ex1_double0_op0_id               ),
  .ex1_double_op1_id                 (ex1_double0_op1_id               ),
  .ex1_f16                           (ex1_f16                          ),
  .ex1_half                          (ex1_half                         ),
  .ex1_half0_op0_id                  (ex1_half0_op0_id                 ),
  .ex1_half0_op1_id                  (ex1_half0_op1_id                 ),
  .ex1_op0_sign                      (ex1_op0_sign                     ),
  .ex1_oper0                         (ex1_oper0                        ),
  .ex1_oper1                         (ex1_oper1                        ),
  .ex1_single                        (ex1_single                       ),
  .ex1_single0_op0_id                (ex1_single0_op0_id               ),
  .ex1_single0_op1_id                (ex1_single0_op1_id               ),
  .ex1_sqrt                          (ex1_sqrt                         ),
  .fdsu_ex1_sel                      (fdsu_ex1_sel                     ),
  .half0_ex1_divisor                 (half0_ex1_divisor                ),
  .half0_ex1_ff1_frac                (half0_ex1_ff1_frac               ),
  .half0_ex1_id_frac                 (half0_ex1_id_frac                ),
  .half0_ex1_id_frac_f               (half0_ex1_id_frac_f              ),
  .half0_ex1_op0_id_vld              (half0_ex1_op0_id_vld             ),
  .half0_ex1_op1_id_vld              (half0_ex1_op1_id_vld             ),
  .half0_ex1_op1_sel                 (half0_ex1_op1_sel                ),
  .half0_ex1_remainder               (half0_ex1_remainder              ),
  .single0_ex1_divisor               (single0_ex1_divisor              ),
  .single0_ex1_ff1_frac              (single0_ex1_ff1_frac             ),
  .single0_ex1_id_frac               (single0_ex1_id_frac              ),
  .single0_ex1_id_frac_f             (single0_ex1_id_frac_f            ),
  .single0_ex1_op0_id_vld            (single0_ex1_op0_id_vld           ),
  .single0_ex1_op1_id_vld            (single0_ex1_op1_id_vld           ),
  .single0_ex1_op1_sel               (single0_ex1_op1_sel              ),
  .single0_ex1_remainder             (single0_ex1_remainder            )
);

// &ConnRule(s/double_/double0_/); @30
// &Instance("aq_fdsu_srt"); @31
aq_fdsu_srt  x_aq_fdsu_srt (
  .bhalf0_ex2_result_denorm_round_add_num  (bhalf0_ex2_result_denorm_round_add_num ),
  .bhalf0_remainder_nxt                    (bhalf0_remainder_nxt                   ),
  .double_ex2_result_denorm_round_add_num  (double0_ex2_result_denorm_round_add_num),
  .double_pipe_cur_rem_1                   (double0_pipe_cur_rem_1                 ),
  .double_pipe_cur_rem_2                   (double0_pipe_cur_rem_2                 ),
  .double_pipe_ex2_expnt_adder_op0         (double0_pipe_ex2_expnt_adder_op0       ),
  .double_pipe_ex2_expnt_adder_op1         (double0_pipe_ex2_expnt_adder_op1       ),
  .double_pipe_ex2_of                      (double0_pipe_ex2_of                    ),
  .double_pipe_ex2_of_rm_lfn               (double0_pipe_ex2_of_rm_lfn             ),
  .double_pipe_ex2_op0_norm                (double0_pipe_ex2_op0_norm              ),
  .double_pipe_ex2_op1_norm                (double0_pipe_ex2_op1_norm              ),
  .double_pipe_ex2_potnt_of                (double0_pipe_ex2_potnt_of              ),
  .double_pipe_ex2_potnt_uf                (double0_pipe_ex2_potnt_uf              ),
  .double_pipe_ex2_result_inf              (double0_pipe_ex2_result_inf            ),
  .double_pipe_ex2_result_lfn              (double0_pipe_ex2_result_lfn            ),
  .double_pipe_ex2_rslt_denorm             (double0_pipe_ex2_rslt_denorm           ),
  .double_pipe_ex2_srt_expnt_rst           (double0_pipe_ex2_srt_expnt_rst         ),
  .double_pipe_ex2_uf                      (double0_pipe_ex2_uf                    ),
  .double_pipe_ex2_uf_srt_skip             (double0_pipe_ex2_uf_srt_skip           ),
  .double_pipe_qt_rt_const_shift_std       (double0_pipe_qt_rt_const_shift_std     ),
  .double_pipe_srt_divisor                 (double0_pipe_srt_divisor               ),
  .double_pipe_srt_remainder               (double0_pipe_srt_remainder             ),
  .double_pipe_srt_remainder_zero          (double0_pipe_srt_remainder_zero        ),
  .double_pipe_total_qt_rt                 (double0_pipe_total_qt_rt               ),
  .double_pipe_total_qt_rt_minus           (double0_pipe_total_qt_rt_minus         ),
  .double_remainder_nxt                    (double0_remainder_nxt                  ),
  .double_srt_remainder                    (double0_srt_remainder                  ),
  .double_srt_remainder_add1_op1           (double0_srt_remainder_add1_op1         ),
  .double_srt_remainder_add1_op2           (double0_srt_remainder_add1_op2         ),
  .double_srt_remainder_add2_op1           (double0_srt_remainder_add2_op1         ),
  .double_srt_remainder_add2_op2           (double0_srt_remainder_add2_op2         ),
  .double_srt_remainder_shift              (double0_srt_remainder_shift            ),
  .double_total_qt_rt_minus_next           (double0_total_qt_rt_minus_next         ),
  .double_total_qt_rt_next                 (double0_total_qt_rt_next               ),
  .ex2_pipe_clk                            (ex2_pipe_clk                           ),
  .ex2_pipedown                            (ex2_pipedown                           ),
  .ex2_srt_first_round                     (ex2_srt_first_round                    ),
  .fdsu_ex2_bhalf                          (fdsu_ex2_bhalf                         ),
  .fdsu_ex2_div                            (fdsu_ex2_div                           ),
  .fdsu_ex2_double                         (fdsu_ex2_double                        ),
  .fdsu_ex2_half                           (fdsu_ex2_half                          ),
  .fdsu_ex2_single                         (fdsu_ex2_single                        ),
  .fdsu_ex2_sqrt                           (fdsu_ex2_sqrt                          ),
  .fdsu_ex3_id_srt_skip                    (fdsu_ex3_id_srt_skip                   ),
  .fdsu_ex3_rem_sign                       (fdsu_ex3_rem_sign                      ),
  .fdsu_ex3_rem_zero                       (fdsu_ex3_rem_zero                      ),
  .half0_ex2_result_denorm_round_add_num   (half0_ex2_result_denorm_round_add_num  ),
  .half0_remainder_nxt                     (half0_remainder_nxt                    ),
  .half0_total_qt_rt_minus_next            (half0_total_qt_rt_minus_next           ),
  .half0_total_qt_rt_next                  (half0_total_qt_rt_next                 ),
  .single0_ex2_result_denorm_round_add_num (single0_ex2_result_denorm_round_add_num),
  .single0_remainder_nxt                   (single0_remainder_nxt                  ),
  .single0_total_qt_rt_minus_next          (single0_total_qt_rt_minus_next         ),
  .single0_total_qt_rt_next                (single0_total_qt_rt_next               )
);

// &ConnRule(s/double_/double0_/); @32
// &Instance("aq_fdsu_round"); @33
aq_fdsu_round  x_aq_fdsu_round (
  .bhalf0_ex3_frac_add1_op1                     (bhalf0_ex3_frac_add1_op1                    ),
  .bhalf0_ex3_frac_final_rst                    (bhalf0_ex3_frac_final_rst                   ),
  .bhalf0_ex3_frac_sub1_op1                     (bhalf0_ex3_frac_sub1_op1                    ),
  .bhalf0_ex3_frac_sub1_op2                     (bhalf0_ex3_frac_sub1_op2                    ),
  .cp0_vpu_icg_en                               (cp0_vpu_icg_en                              ),
  .cp0_yy_clk_en                                (cp0_yy_clk_en                               ),
  .double_ex3_frac_add1_op1                     (double0_ex3_frac_add1_op1                   ),
  .double_ex3_frac_final_rst                    (double0_ex3_frac_final_rst                  ),
  .double_ex3_frac_sub1_op1                     (double0_ex3_frac_sub1_op1                   ),
  .double_ex3_frac_sub1_op2                     (double0_ex3_frac_sub1_op2                   ),
  .double_pipe_ex3_expnt_adjust_result          (double0_pipe_ex3_expnt_adjust_result        ),
  .double_pipe_ex3_expnt_rst                    (double0_pipe_ex3_expnt_rst                  ),
  .double_pipe_ex3_potnt_uf                     (double0_pipe_ex3_potnt_uf                   ),
  .double_pipe_ex3_result_denorm_round_add_num  (double0_pipe_ex3_result_denorm_round_add_num),
  .double_pipe_ex3_result_inf                   (double0_pipe_ex3_result_inf                 ),
  .double_pipe_ex3_result_lfn                   (double0_pipe_ex3_result_lfn                 ),
  .double_pipe_ex3_result_qnan                  (double0_pipe_ex3_result_qnan                ),
  .double_pipe_ex3_result_sign                  (double0_pipe_ex3_result_sign                ),
  .double_pipe_ex3_result_zero                  (double0_pipe_ex3_result_zero                ),
  .double_pipe_ex3_rslt_denorm                  (double0_pipe_ex3_rslt_denorm                ),
  .double_pipe_ex3_rslt_denorm_in               (double0_pipe_ex3_rslt_denorm_in             ),
  .double_pipe_ex4_denorm_to_tiny_frac          (double0_pipe_ex4_denorm_to_tiny_frac        ),
  .double_pipe_ex4_nx                           (double0_pipe_ex4_nx                         ),
  .double_pipe_ex4_potnt_norm                   (double0_pipe_ex4_potnt_norm                 ),
  .double_pipe_ex4_result_nor                   (double0_pipe_ex4_result_nor                 ),
  .double_pipe_frac_add1_rst                    (double0_pipe_frac_add1_rst                  ),
  .double_pipe_frac_sub1_rst                    (double0_pipe_frac_sub1_rst                  ),
  .double_pipe_total_qt_rt                      (double0_pipe_total_qt_rt                    ),
  .double_total_qt_rt                           (double0_total_qt_rt                         ),
  .ex3_pipedown                                 (ex3_pipedown                                ),
  .fdsu_ex3_bhalf                               (fdsu_ex3_bhalf                              ),
  .fdsu_ex3_double                              (fdsu_ex3_double                             ),
  .fdsu_ex3_half                                (fdsu_ex3_half                               ),
  .fdsu_ex3_id_srt_skip                         (fdsu_ex3_id_srt_skip                        ),
  .fdsu_ex3_rem_sign                            (fdsu_ex3_rem_sign                           ),
  .fdsu_ex3_rem_zero                            (fdsu_ex3_rem_zero                           ),
  .fdsu_ex3_single                              (fdsu_ex3_single                             ),
  .fdsu_yy_rm                                   (fdsu_yy_rm                                  ),
  .forever_cpuclk                               (forever_cpuclk                              ),
  .half0_ex3_frac_add1_op1                      (half0_ex3_frac_add1_op1                     ),
  .half0_ex3_frac_final_rst                     (half0_ex3_frac_final_rst                    ),
  .half0_ex3_frac_sub1_op1                      (half0_ex3_frac_sub1_op1                     ),
  .half0_ex3_frac_sub1_op2                      (half0_ex3_frac_sub1_op2                     ),
  .half0_total_qt_rt                            (half0_total_qt_rt                           ),
  .pad_yy_icg_scan_en                           (pad_yy_icg_scan_en                          ),
  .single0_ex3_frac_add1_op1                    (single0_ex3_frac_add1_op1                   ),
  .single0_ex3_frac_final_rst                   (single0_ex3_frac_final_rst                  ),
  .single0_ex3_frac_sub1_op1                    (single0_ex3_frac_sub1_op1                   ),
  .single0_ex3_frac_sub1_op2                    (single0_ex3_frac_sub1_op2                   ),
  .single0_total_qt_rt                          (single0_total_qt_rt                         )
);

// &ConnRule(s/double_/double0_/); @34
// &Instance("aq_fdsu_pack"); @35
aq_fdsu_pack  x_aq_fdsu_pack (
  .bhalf0_denorm_shift_num              (bhalf0_denorm_shift_num             ),
  .bhalf0_denorm_shift_num_in           (bhalf0_denorm_shift_num_in          ),
  .bhalf0_denorm_shift_val              (bhalf0_denorm_shift_val             ),
  .bhalf0_denorm_to_tiny_frac           (bhalf0_denorm_to_tiny_frac          ),
  .bhalf0_ex4_qnan_f                    (bhalf0_ex4_qnan_f                   ),
  .double_denorm_shift_num              (double0_denorm_shift_num            ),
  .double_denorm_shift_num_in           (double0_denorm_shift_num_in         ),
  .double_denorm_shift_val              (double0_denorm_shift_val            ),
  .double_denorm_to_tiny_frac           (double0_denorm_to_tiny_frac         ),
  .double_ex4_qnan_f                    (double0_ex4_qnan_f                  ),
  .double_pipe_ex4_denorm_to_tiny_frac  (double0_pipe_ex4_denorm_to_tiny_frac),
  .double_pipe_ex4_dz                   (double0_pipe_ex4_dz                 ),
  .double_pipe_ex4_expnt_rst            (double0_pipe_ex4_expnt_rst          ),
  .double_pipe_ex4_expt                 (double0_pipe_ex4_expt               ),
  .double_pipe_ex4_nv                   (double0_pipe_ex4_nv                 ),
  .double_pipe_ex4_nx                   (double0_pipe_ex4_nx                 ),
  .double_pipe_ex4_of                   (double0_pipe_ex4_of                 ),
  .double_pipe_ex4_of_rm_lfn            (double0_pipe_ex4_of_rm_lfn          ),
  .double_pipe_ex4_potnt_norm           (double0_pipe_ex4_potnt_norm         ),
  .double_pipe_ex4_potnt_of             (double0_pipe_ex4_potnt_of           ),
  .double_pipe_ex4_potnt_uf             (double0_pipe_ex4_potnt_uf           ),
  .double_pipe_ex4_result               (double0_pipe_ex4_result             ),
  .double_pipe_ex4_result_inf           (double0_pipe_ex4_result_inf         ),
  .double_pipe_ex4_result_lfn           (double0_pipe_ex4_result_lfn         ),
  .double_pipe_ex4_result_nor           (double0_pipe_ex4_result_nor         ),
  .double_pipe_ex4_result_qnan          (double0_pipe_ex4_result_qnan        ),
  .double_pipe_ex4_result_sign          (double0_pipe_ex4_result_sign        ),
  .double_pipe_ex4_result_zero          (double0_pipe_ex4_result_zero        ),
  .double_pipe_ex4_rslt_denorm          (double0_pipe_ex4_rslt_denorm        ),
  .double_pipe_ex4_uf                   (double0_pipe_ex4_uf                 ),
  .double_pipe_fdsu_ex4_frac            (double0_pipe_fdsu_ex4_frac          ),
  .fdsu_ex4_bhalf                       (fdsu_ex4_bhalf                      ),
  .fdsu_ex4_double                      (fdsu_ex4_double                     ),
  .fdsu_ex4_half                        (fdsu_ex4_half                       ),
  .fdsu_ex4_single                      (fdsu_ex4_single                     ),
  .half0_denorm_shift_num               (half0_denorm_shift_num              ),
  .half0_denorm_shift_num_in            (half0_denorm_shift_num_in           ),
  .half0_denorm_shift_val               (half0_denorm_shift_val              ),
  .half0_denorm_to_tiny_frac            (half0_denorm_to_tiny_frac           ),
  .half0_ex4_qnan_f                     (half0_ex4_qnan_f                    ),
  .single0_denorm_shift_num             (single0_denorm_shift_num            ),
  .single0_denorm_shift_num_in          (single0_denorm_shift_num_in         ),
  .single0_denorm_shift_val             (single0_denorm_shift_val            ),
  .single0_denorm_to_tiny_frac          (single0_denorm_to_tiny_frac         ),
  .single0_ex4_qnan_f                   (single0_ex4_qnan_f                  )
);

// &ConnRule(s/double_/double0_/); @36
// &ConnRule(s/fdsu/double0_pipe/); @37
// &Instance("aq_fdsu_double_dp"); @38
aq_fdsu_double_dp  x_aq_fdsu_double_dp (
  .ex1_pipe_clk                         (ex1_pipe_clk                        ),
  .ex1_pipedown                         (ex1_pipedown                        ),
  .ex2_pipe_clk                         (ex2_pipe_clk                        ),
  .ex2_pipedown                         (ex2_pipedown                        ),
  .ex3_pipedown                         (ex3_pipedown                        ),
  .expnt_rst_clk                        (expnt_rst_clk                       ),
  .fdsu_ex1_dz                          (double0_pipe_ex1_dz                 ),
  .fdsu_ex1_expnt_adder_op0             (double0_pipe_ex1_expnt_adder_op0    ),
  .fdsu_ex1_id_expnt_f                  (double0_pipe_ex1_id_expnt_f         ),
  .fdsu_ex1_nv                          (double0_pipe_ex1_nv                 ),
  .fdsu_ex1_of_result_lfn               (double0_pipe_ex1_of_result_lfn      ),
  .fdsu_ex1_op0_id_expnt_neg            (double0_pipe_ex1_op0_id_expnt_neg   ),
  .fdsu_ex1_op0_norm                    (double0_pipe_ex1_op0_norm           ),
  .fdsu_ex1_op1_norm                    (double0_pipe_ex1_op1_norm           ),
  .fdsu_ex1_result_inf                  (double0_pipe_ex1_result_inf         ),
  .fdsu_ex1_result_lfn                  (double0_pipe_ex1_result_lfn         ),
  .fdsu_ex1_result_qnan                 (double0_pipe_ex1_result_qnan        ),
  .fdsu_ex1_result_sign                 (double0_pipe_ex1_result_sign        ),
  .fdsu_ex1_result_zero                 (double0_pipe_ex1_result_zero        ),
  .fdsu_ex1_save_op0                    (double0_pipe_ex1_save_op0           ),
  .fdsu_ex2_expnt_adder_op0             (double0_pipe_ex2_expnt_adder_op0    ),
  .fdsu_ex2_of                          (double0_pipe_ex2_of                 ),
  .fdsu_ex2_of_rm_lfn                   (double0_pipe_ex2_of_rm_lfn          ),
  .fdsu_ex2_op0_norm                    (double0_pipe_ex2_op0_norm           ),
  .fdsu_ex2_op1_norm                    (double0_pipe_ex2_op1_norm           ),
  .fdsu_ex2_potnt_of                    (double0_pipe_ex2_potnt_of           ),
  .fdsu_ex2_potnt_uf                    (double0_pipe_ex2_potnt_uf           ),
  .fdsu_ex2_result_inf                  (double0_pipe_ex2_result_inf         ),
  .fdsu_ex2_result_lfn                  (double0_pipe_ex2_result_lfn         ),
  .fdsu_ex2_rslt_denorm                 (double0_pipe_ex2_rslt_denorm        ),
  .fdsu_ex2_srt_expnt_rst               (double0_pipe_ex2_srt_expnt_rst      ),
  .fdsu_ex2_uf                          (double0_pipe_ex2_uf                 ),
  .fdsu_ex3_expnt_adjust_result         (double0_pipe_ex3_expnt_adjust_result),
  .fdsu_ex3_expnt_rst                   (double0_pipe_ex3_expnt_rst          ),
  .fdsu_ex3_potnt_uf                    (double0_pipe_ex3_potnt_uf           ),
  .fdsu_ex3_result_inf                  (double0_pipe_ex3_result_inf         ),
  .fdsu_ex3_result_lfn                  (double0_pipe_ex3_result_lfn         ),
  .fdsu_ex3_result_qnan                 (double0_pipe_ex3_result_qnan        ),
  .fdsu_ex3_result_sign                 (double0_pipe_ex3_result_sign        ),
  .fdsu_ex3_result_zero                 (double0_pipe_ex3_result_zero        ),
  .fdsu_ex3_rslt_denorm                 (double0_pipe_ex3_rslt_denorm        ),
  .fdsu_ex3_rslt_denorm_in              (double0_pipe_ex3_rslt_denorm_in     ),
  .fdsu_ex4_dz                          (double0_pipe_ex4_dz                 ),
  .fdsu_ex4_expnt_rst                   (double0_pipe_ex4_expnt_rst          ),
  .fdsu_ex4_nv                          (double0_pipe_ex4_nv                 ),
  .fdsu_ex4_of                          (double0_pipe_ex4_of                 ),
  .fdsu_ex4_of_rm_lfn                   (double0_pipe_ex4_of_rm_lfn          ),
  .fdsu_ex4_potnt_of                    (double0_pipe_ex4_potnt_of           ),
  .fdsu_ex4_potnt_uf                    (double0_pipe_ex4_potnt_uf           ),
  .fdsu_ex4_result_inf                  (double0_pipe_ex4_result_inf         ),
  .fdsu_ex4_result_lfn                  (double0_pipe_ex4_result_lfn         ),
  .fdsu_ex4_result_qnan                 (double0_pipe_ex4_result_qnan        ),
  .fdsu_ex4_result_sign                 (double0_pipe_ex4_result_sign        ),
  .fdsu_ex4_result_zero                 (double0_pipe_ex4_result_zero        ),
  .fdsu_ex4_rslt_denorm                 (double0_pipe_ex4_rslt_denorm        ),
  .fdsu_ex4_uf                          (double0_pipe_ex4_uf                 ),
  .fdsu_op0_ff1_cnt                     (double0_pipe_op0_ff1_cnt            ),
  .fdsu_op0_id_expnt                    (double0_pipe_op0_id_expnt           ),
  .fdsu_save_op0_neg_expnt              (double0_pipe_save_op0_neg_expnt     )
);

//&Instance("aq_fdsu_dp");
// &Force("output","double0_pipe_ex1_result_qnan"); @40
// &Force("output","double0_pipe_ex2_of"); @41
// &ModuleEnd; @42
endmodule


