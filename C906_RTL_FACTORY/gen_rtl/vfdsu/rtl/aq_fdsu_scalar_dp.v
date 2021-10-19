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
module aq_fdsu_scalar_dp(
  bhalf0_denorm_shift_num,
  bhalf0_denorm_shift_num_in,
  bhalf0_denorm_shift_val,
  bhalf0_denorm_to_tiny_frac,
  bhalf0_ex1_divisor,
  bhalf0_ex1_ff1_frac,
  bhalf0_ex1_id_frac,
  bhalf0_ex1_id_frac_f,
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
  cp0_vpu_xx_bf16,
  cp0_yy_clk_en,
  ctrl_dp_ex1_save_op0,
  ctrl_dp_ex1_save_op0_gate,
  double0_denorm_shift_num,
  double0_denorm_shift_num_in,
  double0_denorm_shift_val,
  double0_denorm_to_tiny_frac,
  double0_ex1_divisor,
  double0_ex1_ff1_frac,
  double0_ex1_id_frac,
  double0_ex1_id_frac_f,
  double0_ex1_qnan_f,
  double0_ex1_remainder,
  double0_ex2_result_denorm_round_add_num,
  double0_ex3_frac_add1_op1,
  double0_ex3_frac_final_rst,
  double0_ex3_frac_sub1_op1,
  double0_ex3_frac_sub1_op2,
  double0_ex4_qnan_f,
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
  double_pipe0_cur_rem_1,
  double_pipe0_cur_rem_2,
  double_pipe0_ex1_expnt_adder_op1,
  double_pipe0_ex1_op0_cnan,
  double_pipe0_ex1_op0_id_expnt_neg,
  double_pipe0_ex1_op0_inf,
  double_pipe0_ex1_op0_qnan,
  double_pipe0_ex1_op0_snan,
  double_pipe0_ex1_op0_zero,
  double_pipe0_ex1_op1_cnan,
  double_pipe0_ex1_op1_id_expnt_neg,
  double_pipe0_ex1_op1_inf,
  double_pipe0_ex1_op1_qnan,
  double_pipe0_ex1_op1_sel,
  double_pipe0_ex1_op1_snan,
  double_pipe0_ex1_op1_zero,
  double_pipe0_ex1_result_qnan,
  double_pipe0_ex2_expnt_adder_op1,
  double_pipe0_ex3_result_denorm_round_add_num,
  double_pipe0_ex4_expt,
  double_pipe0_ex4_result,
  double_pipe0_fdsu_ex4_frac,
  double_pipe0_frac_add1_rst,
  double_pipe0_frac_sub1_rst,
  double_pipe0_op0_ff1_cnt,
  double_pipe0_op0_id_expnt,
  double_pipe0_oper0,
  double_pipe0_oper1,
  double_pipe0_qt_rt_const_shift_std,
  double_pipe0_srt_divisor,
  double_pipe0_srt_remainder,
  double_pipe0_total_qt_rt,
  double_pipe0_total_qt_rt_minus,
  dp_ctrl_ex1_bhalf,
  dp_ctrl_ex1_div,
  dp_ctrl_ex1_double,
  dp_ctrl_ex1_half,
  dp_ctrl_ex1_single,
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
  ex1_pipedown_gate,
  ex1_save_ff1_op1_id,
  ex1_single,
  ex1_single0_op0_id,
  ex1_single0_op1_id,
  ex1_sqrt,
  ex2_pipedown,
  ex3_pipedown,
  ex4_pipe_clk,
  ex4_pipedown,
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
  single0_total_qt_rt_next,
  srt_sm_on,
  vfdsu_rbus_fflags,
  vfdsu_rbus_fpr_wb_data,
  vfdsu_rbus_fpr_wb_index,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_rm,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1,
  vpu_group_1_xx_ex1_srcv1_type,
  vpu_group_1_xx_ex1_vreg
);

// &Ports; @22
input   [6 :0]  bhalf0_denorm_shift_num_in;                  
input   [8 :0]  bhalf0_denorm_shift_val;                     
input           bhalf0_denorm_to_tiny_frac;                  
input   [7 :0]  bhalf0_ex1_divisor;                          
input   [6 :0]  bhalf0_ex1_ff1_frac;                         
input   [7 :0]  bhalf0_ex1_qnan_f;                           
input   [14:0]  bhalf0_ex1_remainder;                        
input   [7 :0]  bhalf0_ex2_result_denorm_round_add_num;      
input   [9 :0]  bhalf0_ex3_frac_add1_op1;                    
input   [9 :0]  bhalf0_ex3_frac_final_rst;                   
input   [9 :0]  bhalf0_ex3_frac_sub1_op1;                    
input   [9 :0]  bhalf0_ex3_frac_sub1_op2;                    
input   [14:0]  bhalf0_remainder_nxt;                        
input           cp0_vpu_icg_en;                              
input           cp0_vpu_xx_bf16;                             
input           cp0_yy_clk_en;                               
input           ctrl_dp_ex1_save_op0;                        
input           ctrl_dp_ex1_save_op0_gate;                   
input   [51:0]  double0_denorm_shift_num_in;                 
input   [11:0]  double0_denorm_shift_val;                    
input           double0_denorm_to_tiny_frac;                 
input   [52:0]  double0_ex1_divisor;                         
input   [51:0]  double0_ex1_ff1_frac;                        
input   [52:0]  double0_ex1_qnan_f;                          
input   [59:0]  double0_ex1_remainder;                       
input   [52:0]  double0_ex2_result_denorm_round_add_num;     
input   [54:0]  double0_ex3_frac_add1_op1;                   
input   [54:0]  double0_ex3_frac_final_rst;                  
input   [54:0]  double0_ex3_frac_sub1_op1;                   
input   [54:0]  double0_ex3_frac_sub1_op2;                   
input   [59:0]  double0_remainder_nxt;                       
input   [59:0]  double0_srt_remainder_add1_op1;              
input   [59:0]  double0_srt_remainder_add1_op2;              
input   [59:0]  double0_srt_remainder_add2_op1;              
input   [59:0]  double0_srt_remainder_add2_op2;              
input   [59:0]  double0_srt_remainder_shift;                 
input   [57:0]  double0_total_qt_rt_minus_next;              
input   [57:0]  double0_total_qt_rt_next;                    
input   [12:0]  double_pipe0_ex1_expnt_adder_op1;            
input           double_pipe0_ex1_op1_sel;                    
input           double_pipe0_ex1_result_qnan;                
input   [4 :0]  double_pipe0_ex4_expt;                       
input   [63:0]  double_pipe0_ex4_result;                     
input   [12:0]  double_pipe0_op0_id_expnt;                   
input           ex1_pipe_clk;                                
input           ex1_pipedown;                                
input           ex1_pipedown_gate;                           
input           ex1_save_ff1_op1_id;                         
input           ex2_pipedown;                                
input           ex3_pipedown;                                
input           ex4_pipe_clk;                                
input           ex4_pipedown;                                
input           forever_cpuclk;                              
input   [9 :0]  half0_denorm_shift_num_in;                   
input   [5 :0]  half0_denorm_shift_val;                      
input           half0_denorm_to_tiny_frac;                   
input   [10:0]  half0_ex1_divisor;                           
input   [9 :0]  half0_ex1_ff1_frac;                          
input   [10:0]  half0_ex1_qnan_f;                            
input   [18:0]  half0_ex1_remainder;                         
input   [10:0]  half0_ex2_result_denorm_round_add_num;       
input   [12:0]  half0_ex3_frac_add1_op1;                     
input   [12:0]  half0_ex3_frac_final_rst;                    
input   [12:0]  half0_ex3_frac_sub1_op1;                     
input   [12:0]  half0_ex3_frac_sub1_op2;                     
input   [18:0]  half0_remainder_nxt;                         
input   [15:0]  half0_total_qt_rt_minus_next;                
input   [15:0]  half0_total_qt_rt_next;                      
input           pad_yy_icg_scan_en;                          
input   [22:0]  single0_denorm_shift_num_in;                 
input   [8 :0]  single0_denorm_shift_val;                    
input           single0_denorm_to_tiny_frac;                 
input   [23:0]  single0_ex1_divisor;                         
input   [22:0]  single0_ex1_ff1_frac;                        
input   [23:0]  single0_ex1_qnan_f;                          
input   [30:0]  single0_ex1_remainder;                       
input   [23:0]  single0_ex2_result_denorm_round_add_num;     
input   [25:0]  single0_ex3_frac_add1_op1;                   
input   [25:0]  single0_ex3_frac_final_rst;                  
input   [25:0]  single0_ex3_frac_sub1_op1;                   
input   [25:0]  single0_ex3_frac_sub1_op2;                   
input   [30:0]  single0_remainder_nxt;                       
input   [27:0]  single0_total_qt_rt_minus_next;              
input   [27:0]  single0_total_qt_rt_next;                    
input           srt_sm_on;                                   
input   [19:0]  vpu_group_1_xx_ex1_func;                     
input   [2 :0]  vpu_group_1_xx_ex1_rm;                       
input   [63:0]  vpu_group_1_xx_ex1_srcv0;                    
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type;               
input   [63:0]  vpu_group_1_xx_ex1_srcv1;                    
input   [47:0]  vpu_group_1_xx_ex1_srcv1_type;               
input   [6 :0]  vpu_group_1_xx_ex1_vreg;                     
output  [6 :0]  bhalf0_denorm_shift_num;                     
output  [6 :0]  bhalf0_ex1_id_frac;                          
output  [6 :0]  bhalf0_ex1_id_frac_f;                        
output  [7 :0]  bhalf0_ex4_qnan_f;                           
output  [51:0]  double0_denorm_shift_num;                    
output  [51:0]  double0_ex1_id_frac;                         
output  [51:0]  double0_ex1_id_frac_f;                       
output  [52:0]  double0_ex4_qnan_f;                          
output  [59:0]  double0_srt_remainder;                       
output  [57:0]  double0_total_qt_rt;                         
output  [59:0]  double_pipe0_cur_rem_1;                      
output  [59:0]  double_pipe0_cur_rem_2;                      
output          double_pipe0_ex1_op0_cnan;                   
output  [12:0]  double_pipe0_ex1_op0_id_expnt_neg;           
output          double_pipe0_ex1_op0_inf;                    
output          double_pipe0_ex1_op0_qnan;                   
output          double_pipe0_ex1_op0_snan;                   
output          double_pipe0_ex1_op0_zero;                   
output          double_pipe0_ex1_op1_cnan;                   
output  [12:0]  double_pipe0_ex1_op1_id_expnt_neg;           
output          double_pipe0_ex1_op1_inf;                    
output          double_pipe0_ex1_op1_qnan;                   
output          double_pipe0_ex1_op1_snan;                   
output          double_pipe0_ex1_op1_zero;                   
output  [12:0]  double_pipe0_ex2_expnt_adder_op1;            
output  [52:0]  double_pipe0_ex3_result_denorm_round_add_num; 
output  [54:0]  double_pipe0_fdsu_ex4_frac;                  
output  [54:0]  double_pipe0_frac_add1_rst;                  
output  [54:0]  double_pipe0_frac_sub1_rst;                  
output  [12:0]  double_pipe0_op0_ff1_cnt;                    
output  [63:0]  double_pipe0_oper0;                          
output  [63:0]  double_pipe0_oper1;                          
output  [57:0]  double_pipe0_qt_rt_const_shift_std;          
output  [52:0]  double_pipe0_srt_divisor;                    
output  [59:0]  double_pipe0_srt_remainder;                  
output  [57:0]  double_pipe0_total_qt_rt;                    
output  [57:0]  double_pipe0_total_qt_rt_minus;              
output          dp_ctrl_ex1_bhalf;                           
output          dp_ctrl_ex1_div;                             
output          dp_ctrl_ex1_double;                          
output          dp_ctrl_ex1_half;                            
output          dp_ctrl_ex1_single;                          
output  [2 :0]  dp_xx_ex1_rm;                                
output          ex1_bhalf;                                   
output          ex1_bhalf0_op0_id;                           
output          ex1_bhalf0_op1_id;                           
output          ex1_div;                                     
output          ex1_double;                                  
output          ex1_double0_op0_id;                          
output          ex1_double0_op1_id;                          
output          ex1_f16;                                     
output          ex1_half;                                    
output          ex1_half0_op0_id;                            
output          ex1_half0_op1_id;                            
output          ex1_single;                                  
output          ex1_single0_op0_id;                          
output          ex1_single0_op1_id;                          
output          ex1_sqrt;                                    
output          fdsu_ex2_bhalf;                              
output          fdsu_ex2_div;                                
output          fdsu_ex2_double;                             
output          fdsu_ex2_half;                               
output          fdsu_ex2_single;                             
output          fdsu_ex2_sqrt;                               
output          fdsu_ex3_bhalf;                              
output          fdsu_ex3_double;                             
output          fdsu_ex3_half;                               
output          fdsu_ex3_single;                             
output          fdsu_ex4_bhalf;                              
output          fdsu_ex4_double;                             
output          fdsu_ex4_half;                               
output          fdsu_ex4_single;                             
output  [2 :0]  fdsu_yy_rm;                                  
output  [9 :0]  half0_denorm_shift_num;                      
output  [9 :0]  half0_ex1_id_frac;                           
output  [9 :0]  half0_ex1_id_frac_f;                         
output  [10:0]  half0_ex4_qnan_f;                            
output  [15:0]  half0_total_qt_rt;                           
output  [22:0]  single0_denorm_shift_num;                    
output  [22:0]  single0_ex1_id_frac;                         
output  [22:0]  single0_ex1_id_frac_f;                       
output  [23:0]  single0_ex4_qnan_f;                          
output  [27:0]  single0_total_qt_rt;                         
output  [4 :0]  vfdsu_rbus_fflags;                           
output  [63:0]  vfdsu_rbus_fpr_wb_data;                      
output  [4 :0]  vfdsu_rbus_fpr_wb_index;                     

// &Regs; @23
reg             fdsu_bhalf;                                  
reg             fdsu_div;                                    
reg             fdsu_double;                                 
reg     [52:0]  fdsu_ex3_result_denorm_round_add_num;        
reg             fdsu_half;                                   
reg     [52:0]  fdsu_qnan_f;                                 
reg     [2 :0]  fdsu_rm;                                     
reg             fdsu_single;                                 
reg             fdsu_sqrt;                                   
reg     [6 :0]  fdsu_wb_freg;                                
reg     [57:0]  qt_rt_const_shift_std;                       
reg     [54:0]  srt_divisor;                                 
reg     [59:0]  srt_remainder;                               
reg     [57:0]  total_qt_rt;                                 
reg     [57:0]  total_qt_rt_minus;                           
reg     [4 :0]  vfdsu_ex5_expt;                              
reg     [63:0]  vfdsu_ex5_result;                            

// &Wires; @24
wire    [6 :0]  bhalf0_denorm_shift_num;                     
wire    [6 :0]  bhalf0_denorm_shift_num_in;                  
wire    [8 :0]  bhalf0_denorm_shift_val;                     
wire            bhalf0_denorm_to_tiny_frac;                  
wire    [7 :0]  bhalf0_ex1_divisor;                          
wire    [6 :0]  bhalf0_ex1_ff1_frac;                         
wire    [12:0]  bhalf0_ex1_id_expnt;                         
wire    [6 :0]  bhalf0_ex1_id_frac;                          
wire    [6 :0]  bhalf0_ex1_id_frac_f;                        
wire    [7 :0]  bhalf0_ex1_qnan_f;                           
wire    [14:0]  bhalf0_ex1_remainder;                        
wire    [7 :0]  bhalf0_ex2_result_denorm_round_add_num;      
wire    [9 :0]  bhalf0_ex3_frac_add1_op1;                    
wire    [9 :0]  bhalf0_ex3_frac_final_rst;                   
wire    [9 :0]  bhalf0_ex3_frac_sub1_op1;                    
wire    [9 :0]  bhalf0_ex3_frac_sub1_op2;                    
wire    [7 :0]  bhalf0_ex4_qnan_f;                           
wire    [15:0]  bhalf0_ff1_shift_num_in;                     
wire    [14:0]  bhalf0_remainder_nxt;                        
wire    [6 :0]  bhalf1_denorm_shift_num;                     
wire    [6 :0]  bhalf1_denorm_shift_num_in;                  
wire    [8 :0]  bhalf1_denorm_shift_val;                     
wire            bhalf1_denorm_to_tiny_frac;                  
wire    [6 :0]  bhalf2_denorm_shift_num;                     
wire    [6 :0]  bhalf2_denorm_shift_num_in;                  
wire    [8 :0]  bhalf2_denorm_shift_val;                     
wire            bhalf2_denorm_to_tiny_frac;                  
wire    [6 :0]  bhalf3_denorm_shift_num;                     
wire    [6 :0]  bhalf3_denorm_shift_num_in;                  
wire    [8 :0]  bhalf3_denorm_shift_val;                     
wire            bhalf3_denorm_to_tiny_frac;                  
wire    [54:0]  bhalf_frac_add1_op1;                         
wire    [54:0]  bhalf_frac_sub1_op1;                         
wire    [54:0]  bhalf_frac_sub1_op2;                         
wire            cp0_vpu_icg_en;                              
wire            cp0_vpu_xx_bf16;                             
wire            cp0_yy_clk_en;                               
wire            ctrl_dp_ex1_save_op0;                        
wire            ctrl_dp_ex1_save_op0_gate;                   
wire    [51:0]  double0_denorm_shift_num;                    
wire    [51:0]  double0_denorm_shift_num_in;                 
wire    [11:0]  double0_denorm_shift_val;                    
wire            double0_denorm_to_tiny_frac;                 
wire    [52:0]  double0_ex1_divisor;                         
wire    [51:0]  double0_ex1_ff1_frac;                        
wire    [12:0]  double0_ex1_id_expnt;                        
wire    [51:0]  double0_ex1_id_frac;                         
wire    [51:0]  double0_ex1_id_frac_f;                       
wire    [52:0]  double0_ex1_qnan_f;                          
wire    [59:0]  double0_ex1_remainder;                       
wire    [52:0]  double0_ex2_result_denorm_round_add_num;     
wire    [54:0]  double0_ex3_frac_add1_op1;                   
wire    [54:0]  double0_ex3_frac_final_rst;                  
wire    [54:0]  double0_ex3_frac_sub1_op1;                   
wire    [54:0]  double0_ex3_frac_sub1_op2;                   
wire    [52:0]  double0_ex4_qnan_f;                          
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
wire    [63:0]  double_ff1_shift_num_in;                     
wire    [54:0]  double_frac;                                 
wire    [54:0]  double_frac_add1_op1;                        
wire    [54:0]  double_frac_sub1_op1;                        
wire    [54:0]  double_frac_sub1_op2;                        
wire    [59:0]  double_pipe0_cur_rem_1;                      
wire    [59:0]  double_pipe0_cur_rem_2;                      
wire    [12:0]  double_pipe0_ex1_expnt_adder_op1;            
wire            double_pipe0_ex1_op0_cnan;                   
wire    [12:0]  double_pipe0_ex1_op0_id_expnt_neg;           
wire            double_pipe0_ex1_op0_inf;                    
wire            double_pipe0_ex1_op0_qnan;                   
wire            double_pipe0_ex1_op0_snan;                   
wire            double_pipe0_ex1_op0_zero;                   
wire            double_pipe0_ex1_op1_cnan;                   
wire    [12:0]  double_pipe0_ex1_op1_id_expnt_neg;           
wire            double_pipe0_ex1_op1_inf;                    
wire            double_pipe0_ex1_op1_qnan;                   
wire            double_pipe0_ex1_op1_sel;                    
wire            double_pipe0_ex1_op1_snan;                   
wire            double_pipe0_ex1_op1_zero;                   
wire            double_pipe0_ex1_result_qnan;                
wire    [12:0]  double_pipe0_ex2_expnt_adder_op1;            
wire    [52:0]  double_pipe0_ex3_result_denorm_round_add_num; 
wire    [4 :0]  double_pipe0_ex4_expt;                       
wire    [63:0]  double_pipe0_ex4_result;                     
wire    [54:0]  double_pipe0_fdsu_ex4_frac;                  
wire    [12:0]  double_pipe0_ff1_cnt;                        
wire    [54:0]  double_pipe0_frac_add1_rst;                  
wire    [54:0]  double_pipe0_frac_sub1_rst;                  
wire    [12:0]  double_pipe0_id_expnt_neg;                   
wire    [12:0]  double_pipe0_id_expnt_neg_op0;               
wire    [12:0]  double_pipe0_op0_ff1_cnt;                    
wire    [12:0]  double_pipe0_op0_id_expnt;                   
wire    [12:0]  double_pipe0_op1_id_expnt;                   
wire    [63:0]  double_pipe0_oper0;                          
wire    [63:0]  double_pipe0_oper1;                          
wire    [57:0]  double_pipe0_qt_rt_const_shift_std;          
wire    [52:0]  double_pipe0_srt_divisor;                    
wire    [59:0]  double_pipe0_srt_remainder;                  
wire    [57:0]  double_pipe0_total_qt_rt;                    
wire    [57:0]  double_pipe0_total_qt_rt_minus;              
wire            dp_ctrl_ex1_bhalf;                           
wire            dp_ctrl_ex1_div;                             
wire            dp_ctrl_ex1_double;                          
wire            dp_ctrl_ex1_half;                            
wire            dp_ctrl_ex1_single;                          
wire    [2 :0]  dp_xx_ex1_rm;                                
wire            ex1_bhalf;                                   
wire            ex1_bhalf0_op0_id;                           
wire            ex1_bhalf0_op1_id;                           
wire            ex1_div;                                     
wire    [54:0]  ex1_divisor;                                 
wire            ex1_double;                                  
wire            ex1_double0_op0_id;                          
wire            ex1_double0_op1_id;                          
wire            ex1_ex2_pipe_clk;                            
wire            ex1_ex2_pipe_clk_en;                         
wire    [52:0]  ex1_expnt_pack;                              
wire            ex1_f16;                                     
wire            ex1_half;                                    
wire            ex1_half0_op0_id;                            
wire            ex1_half0_op1_id;                            
wire    [59:0]  ex1_initial_remainder;                       
wire    [52:0]  ex1_op1_id_expnt_pack;                       
wire    [54:0]  ex1_oper_id_frac_pack;                       
wire            ex1_pipe_clk;                                
wire            ex1_pipedown;                                
wire            ex1_pipedown_gate;                           
wire            ex1_qnan_f_pipe_vld;                         
wire    [2 :0]  ex1_rm;                                      
wire            ex1_save_ff1_op1_id;                         
wire            ex1_save_op0;                                
wire            ex1_save_op0_gate;                           
wire            ex1_sign;                                    
wire            ex1_single;                                  
wire            ex1_single0_op0_id;                          
wire            ex1_single0_op1_id;                          
wire    [3 :0]  ex1_size;                                    
wire            ex1_sqrt;                                    
wire    [6 :0]  ex1_wb_freg;                                 
wire    [52:0]  ex2_pack_denorm_round_add_num;               
wire            ex2_pipedown;                                
wire    [54:0]  ex3_frac_final_rst;                          
wire            ex3_pipedown;                                
wire            ex4_pipe_clk;                                
wire            ex4_pipedown;                                
wire            fdsu_ex2_bhalf;                              
wire            fdsu_ex2_div;                                
wire            fdsu_ex2_double;                             
wire            fdsu_ex2_half;                               
wire            fdsu_ex2_single;                             
wire            fdsu_ex2_sqrt;                               
wire            fdsu_ex3_bhalf;                              
wire            fdsu_ex3_double;                             
wire            fdsu_ex3_half;                               
wire            fdsu_ex3_single;                             
wire            fdsu_ex4_bhalf;                              
wire            fdsu_ex4_double;                             
wire            fdsu_ex4_half;                               
wire            fdsu_ex4_single;                             
wire    [2 :0]  fdsu_yy_rm;                                  
wire    [23:0]  ff1_16_bit;                                  
wire    [13:0]  ff1_32_bit;                                  
wire    [7 :0]  ff1_64_bit;                                  
wire    [39:0]  ff1_8_bit;                                   
wire    [63:0]  ff1_src_in;                                  
wire            forever_cpuclk;                              
wire    [54:0]  frac_add1_op0;                               
wire    [54:0]  frac_add1_op1;                               
wire    [54:0]  frac_add1_rst;                               
wire    [54:0]  frac_sub1_op1;                               
wire    [54:0]  frac_sub1_op2;                               
wire    [54:0]  frac_sub1_rst;                               
wire    [9 :0]  half0_denorm_shift_num;                      
wire    [9 :0]  half0_denorm_shift_num_in;                   
wire    [5 :0]  half0_denorm_shift_val;                      
wire            half0_denorm_to_tiny_frac;                   
wire    [10:0]  half0_ex1_divisor;                           
wire    [9 :0]  half0_ex1_ff1_frac;                          
wire    [12:0]  half0_ex1_id_expnt;                          
wire    [9 :0]  half0_ex1_id_frac;                           
wire    [9 :0]  half0_ex1_id_frac_f;                         
wire    [10:0]  half0_ex1_qnan_f;                            
wire    [18:0]  half0_ex1_remainder;                         
wire    [10:0]  half0_ex2_result_denorm_round_add_num;       
wire    [12:0]  half0_ex3_frac_add1_op1;                     
wire    [12:0]  half0_ex3_frac_final_rst;                    
wire    [12:0]  half0_ex3_frac_sub1_op1;                     
wire    [12:0]  half0_ex3_frac_sub1_op2;                     
wire    [10:0]  half0_ex4_qnan_f;                            
wire    [15:0]  half0_ff1_shift_num_in;                      
wire    [18:0]  half0_remainder_nxt;                         
wire    [15:0]  half0_total_qt_rt;                           
wire    [15:0]  half0_total_qt_rt_minus_next;                
wire    [15:0]  half0_total_qt_rt_next;                      
wire    [9 :0]  half1_denorm_shift_num;                      
wire    [9 :0]  half1_denorm_shift_num_in;                   
wire    [5 :0]  half1_denorm_shift_val;                      
wire            half1_denorm_to_tiny_frac;                   
wire    [9 :0]  half2_denorm_shift_num;                      
wire    [9 :0]  half2_denorm_shift_num_in;                   
wire    [5 :0]  half2_denorm_shift_val;                      
wire            half2_denorm_to_tiny_frac;                   
wire    [9 :0]  half3_denorm_shift_num;                      
wire    [9 :0]  half3_denorm_shift_num_in;                   
wire    [5 :0]  half3_denorm_shift_val;                      
wire            half3_denorm_to_tiny_frac;                   
wire    [54:0]  half_frac_add1_op1;                          
wire    [54:0]  half_frac_sub1_op1;                          
wire    [54:0]  half_frac_sub1_op2;                          
wire    [3 :0]  input_l16_0_shift_cnt;                       
wire    [3 :0]  input_l16_1_shift_cnt;                       
wire    [3 :0]  input_l16_2_shift_cnt;                       
wire    [3 :0]  input_l16_3_shift_cnt;                       
wire    [4 :0]  input_l32_0_shift_cnt;                       
wire    [4 :0]  input_l32_1_shift_cnt;                       
wire    [5 :0]  input_l64_shift_cnt;                         
wire    [15:0]  l16_0_shift_out_val;                         
wire    [15:0]  l16_1_shift_out_val;                         
wire    [15:0]  l16_2_shift_out_val;                         
wire    [15:0]  l16_3_shift_out_val;                         
wire    [31:0]  l32_0_shift_out_val;                         
wire    [31:0]  l32_1_shift_out_val;                         
wire    [63:0]  l64_shift_out_val;                           
wire            pad_yy_icg_scan_en;                          
wire    [52:0]  qnan_f_pack;                                 
wire            qt_clk;                                      
wire            qt_clk_en;                                   
wire    [57:0]  qt_rt_const_shift_std_init_val;              
wire    [57:0]  qt_rt_const_shift_std_next;                  
wire    [59:0]  remainder_adder_1;                           
wire    [59:0]  remainder_adder_2;                           
wire    [22:0]  single0_denorm_shift_num;                    
wire    [22:0]  single0_denorm_shift_num_in;                 
wire    [8 :0]  single0_denorm_shift_val;                    
wire            single0_denorm_to_tiny_frac;                 
wire    [23:0]  single0_ex1_divisor;                         
wire    [22:0]  single0_ex1_ff1_frac;                        
wire    [12:0]  single0_ex1_id_expnt;                        
wire    [22:0]  single0_ex1_id_frac;                         
wire    [22:0]  single0_ex1_id_frac_f;                       
wire    [23:0]  single0_ex1_qnan_f;                          
wire    [30:0]  single0_ex1_remainder;                       
wire    [23:0]  single0_ex2_result_denorm_round_add_num;     
wire    [25:0]  single0_ex3_frac_add1_op1;                   
wire    [25:0]  single0_ex3_frac_final_rst;                  
wire    [25:0]  single0_ex3_frac_sub1_op1;                   
wire    [25:0]  single0_ex3_frac_sub1_op2;                   
wire    [23:0]  single0_ex4_qnan_f;                          
wire    [31:0]  single0_ff1_shift_num_in;                    
wire    [30:0]  single0_remainder_nxt;                       
wire    [27:0]  single0_total_qt_rt;                         
wire    [27:0]  single0_total_qt_rt_minus_next;              
wire    [27:0]  single0_total_qt_rt_next;                    
wire    [22:0]  single1_denorm_shift_num;                    
wire    [22:0]  single1_denorm_shift_num_in;                 
wire    [8 :0]  single1_denorm_shift_val;                    
wire            single1_denorm_to_tiny_frac;                 
wire    [54:0]  single_frac_add1_op1;                        
wire    [54:0]  single_frac_sub1_op1;                        
wire    [54:0]  single_frac_sub1_op2;                        
wire            src0_double0_id;                             
wire            src0_double0_inf;                            
wire            src0_double0_qnan;                           
wire            src0_double0_snan;                           
wire            src0_double0_zero;                           
wire            src0_half0_cnan;                             
wire            src0_half0_id;                               
wire            src0_half0_inf;                              
wire            src0_half0_qnan;                             
wire            src0_half0_snan;                             
wire            src0_half0_zero;                             
wire            src0_single0_cnan;                           
wire            src0_single0_id;                             
wire            src0_single0_inf;                            
wire            src0_single0_qnan;                           
wire            src0_single0_snan;                           
wire            src0_single0_zero;                           
wire            src1_double0_id;                             
wire            src1_double0_inf;                            
wire            src1_double0_qnan;                           
wire            src1_double0_snan;                           
wire            src1_double0_zero;                           
wire            src1_half0_cnan;                             
wire            src1_half0_id;                               
wire            src1_half0_inf;                              
wire            src1_half0_qnan;                             
wire            src1_half0_snan;                             
wire            src1_half0_zero;                             
wire            src1_single0_cnan;                           
wire            src1_single0_id;                             
wire            src1_single0_inf;                            
wire            src1_single0_qnan;                           
wire            src1_single0_snan;                           
wire            src1_single0_zero;                           
wire    [47:0]  srcv0_type;                                  
wire    [47:0]  srcv1_type;                                  
wire            srt_div_clk;                                 
wire            srt_div_clk_en;                              
wire    [59:0]  srt_remainder_add1_op1;                      
wire    [59:0]  srt_remainder_add1_op2;                      
wire    [59:0]  srt_remainder_add2_op1;                      
wire    [59:0]  srt_remainder_add2_op2;                      
wire    [59:0]  srt_remainder_nxt;                           
wire    [59:0]  srt_remainder_shift;                         
wire            srt_sm_on;                                   
wire    [57:0]  total_qt_rt_minus_next;                      
wire    [57:0]  total_qt_rt_next;                            
wire    [4 :0]  vfdsu_ex4_final_expt;                        
wire    [63:0]  vfdsu_ex4_final_result;                      
wire    [4 :0]  vfdsu_rbus_fflags;                           
wire    [63:0]  vfdsu_rbus_fpr_wb_data;                      
wire    [4 :0]  vfdsu_rbus_fpr_wb_index;                     
wire    [19:0]  vpu_group_1_xx_ex1_func;                     
wire    [2 :0]  vpu_group_1_xx_ex1_rm;                       
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;                    
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;               
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;                    
wire    [47:0]  vpu_group_1_xx_ex1_srcv1_type;               
wire    [6 :0]  vpu_group_1_xx_ex1_vreg;                     


//=========================================================
//
//  common special value for
//==========================================================

assign srcv0_type[47:0]          = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign srcv1_type[47:0]          = vpu_group_1_xx_ex1_srcv1_type[47:0];
assign src0_double0_snan    = srcv0_type[47];
assign src0_double0_qnan    = srcv0_type[46];
assign src0_double0_inf    = srcv0_type[45];
assign src0_double0_zero    = srcv0_type[44];
assign src0_double0_id    = srcv0_type[43];
//assign src0_double0_norm    = srcv0_type[42];
assign src0_single0_cnan    = srcv0_type[41];
assign src0_single0_snan    = srcv0_type[40];
assign src0_single0_qnan    = srcv0_type[39];
assign src0_single0_inf    = srcv0_type[38];
assign src0_single0_zero    = srcv0_type[37];
assign src0_single0_id    = srcv0_type[36];
//assign src0_single0_norm    = srcv0_type[35];

assign src0_half0_cnan    = srcv0_type[27];
assign src0_half0_snan    = srcv0_type[26];
assign src0_half0_qnan    = srcv0_type[25];
assign src0_half0_inf    = srcv0_type[24];
assign src0_half0_zero    = srcv0_type[23];
assign src0_half0_id    = srcv0_type[22];
//assign src0_half0_norm    = srcv0_type[21];



assign src1_double0_snan    = srcv1_type[47];
assign src1_double0_qnan    = srcv1_type[46];
assign src1_double0_inf    = srcv1_type[45];
assign src1_double0_zero    = srcv1_type[44];
assign src1_double0_id    = srcv1_type[43];
//assign src1_double0_norm    = srcv1_type[42];
assign src1_single0_cnan    = srcv1_type[41];
assign src1_single0_snan    = srcv1_type[40];
assign src1_single0_qnan    = srcv1_type[39];
assign src1_single0_inf    = srcv1_type[38];
assign src1_single0_zero    = srcv1_type[37];
assign src1_single0_id    = srcv1_type[36];
//assign src1_single0_norm    = srcv1_type[35];

assign src1_half0_cnan    = srcv1_type[27];
assign src1_half0_snan    = srcv1_type[26];
assign src1_half0_qnan    = srcv1_type[25];
assign src1_half0_inf    = srcv1_type[24];
assign src1_half0_zero    = srcv1_type[23];
assign src1_half0_id    = srcv1_type[22];
//assign src1_half0_norm    = srcv1_type[21];


// &Force("bus", "dp_xx_ex1_inf", 2, 0); @80
assign  double_pipe0_ex1_op0_inf               = ex1_double && src0_double0_inf || ex1_single && src0_single0_inf || (ex1_half || ex1_bhalf) && src0_half0_inf;
assign  double_pipe0_ex1_op1_inf               = ex1_double && src1_double0_inf || ex1_single && src1_single0_inf || (ex1_half || ex1_bhalf) && src1_half0_inf;
//zero
// &Force("bus", "dp_xx_ex1_zero", 2, 0); @84
assign double_pipe0_ex1_op0_zero               = ex1_double && src0_double0_zero || ex1_single && src0_single0_zero || (ex1_half || ex1_bhalf) && src0_half0_zero;
assign double_pipe0_ex1_op1_zero               = ex1_double && src1_double0_zero || ex1_single && src1_single0_zero || (ex1_half || ex1_bhalf) && src1_half0_zero;

//denormalize number
// &Force("bus", "dp_xx_ex1_id", 2, 0); @89
assign ex1_half0_op0_id  = src0_half0_id ;
assign ex1_half0_op1_id  = src1_half0_id ;
assign ex1_bhalf0_op0_id  = src0_half0_id ;
assign ex1_bhalf0_op1_id  = src1_half0_id ;
assign ex1_single0_op0_id  = src0_single0_id ;
assign ex1_single0_op1_id  = src1_single0_id ;
assign ex1_double0_op0_id  = src0_double0_id ;
assign ex1_double0_op1_id  = src1_double0_id ;

//cNaN
// &Force("bus", "dp_xx_ex1_cnan", 2, 0); @100
assign double_pipe0_ex1_op0_cnan               = ex1_single && src0_single0_cnan || (ex1_half || ex1_bhalf) && src0_half0_cnan;
assign double_pipe0_ex1_op1_cnan               = ex1_single && src1_single0_cnan || (ex1_half || ex1_bhalf) && src1_half0_cnan;


//sNaN
// &Force("bus", "dp_xx_ex1_snan", 2, 0); @106
assign double_pipe0_ex1_op0_snan               = ex1_double && src0_double0_snan || ex1_single && src0_single0_snan || (ex1_half || ex1_bhalf) && src0_half0_snan ;
assign double_pipe0_ex1_op1_snan               = ex1_double && src1_double0_snan || ex1_single && src1_single0_snan || (ex1_half || ex1_bhalf) && src1_half0_snan;


//qNaN
// &Force("bus", "dp_xx_ex1_qnan", 2, 0); @112
assign double_pipe0_ex1_op0_qnan               = ex1_double && src0_double0_qnan || ex1_single && src0_single0_qnan || (ex1_half || ex1_bhalf) && src0_half0_qnan ;
assign double_pipe0_ex1_op1_qnan               = ex1_double && src1_double0_qnan || ex1_single && src1_single0_qnan || (ex1_half || ex1_bhalf) && src1_half0_qnan;


// &Force("bus", "vpu_group_1_xx_ex1_func", 19, 0); @117
assign ex1_double              = vpu_group_1_xx_ex1_func[13:12] == 2'b11;
assign ex1_single              = vpu_group_1_xx_ex1_func[13:12] == 2'b10;
assign ex1_half                = ex1_f16 && !cp0_vpu_xx_bf16;
assign ex1_bhalf               = ex1_f16 && cp0_vpu_xx_bf16;
assign ex1_f16                 = vpu_group_1_xx_ex1_func[13:12] == 2'b01;
assign ex1_div                 = vpu_group_1_xx_ex1_func[0];
assign ex1_sqrt                = vpu_group_1_xx_ex1_func[1];
assign ex1_rm[2:0]             = vpu_group_1_xx_ex1_rm[2:0];

// &Force("output","ex1_div"); @127
// &Force("output","ex1_sqrt"); @128
assign double_pipe0_oper0[63:0] = vpu_group_1_xx_ex1_srcv0[63:0];
assign double_pipe0_oper1[63:0] = vpu_group_1_xx_ex1_srcv1[63:0];



assign ex1_wb_freg[6:0]       = vpu_group_1_xx_ex1_vreg[6:0];          
//==========================================================
//                         common Flops
//==========================================================
always @(posedge ex1_pipe_clk)
begin
  if(ex1_pipedown)
  begin
    fdsu_wb_freg[6:0]    <= ex1_wb_freg[6:0];
    fdsu_div             <= ex1_div;
    fdsu_sqrt            <= ex1_sqrt;
    fdsu_double          <= ex1_double;
    fdsu_single          <= ex1_single;
    fdsu_half            <= ex1_half;
    fdsu_bhalf           <= ex1_bhalf;
    fdsu_rm[2:0]         <= ex1_rm[2:0];
  end
  else
  begin
    fdsu_wb_freg[6:0]    <= fdsu_wb_freg[6:0];
    fdsu_div             <= fdsu_div;
    fdsu_sqrt            <= fdsu_sqrt;
    fdsu_double          <= fdsu_double;
    fdsu_single          <= fdsu_single;
    fdsu_half            <= fdsu_half;
    fdsu_bhalf           <= fdsu_bhalf;
    fdsu_rm[2:0]         <= fdsu_rm[2:0];
  end
end


assign fdsu_ex2_div            = fdsu_div;
assign fdsu_ex2_sqrt           = fdsu_sqrt;

// &Force("output","ex1_double"); @168
// &Force("output","ex1_single"); @169
// &Force("output","ex1_f16"); @170
// &Force("output","ex1_half"); @171
// &Force("output","ex1_bhalf"); @172

//assign fdsu_yy_div             = fdsu_div;
//assign fdsu_yy_sqrt            = fdsu_sqrt;
assign dp_ctrl_ex1_div         = ex1_div;
assign dp_ctrl_ex1_double      = ex1_double;
assign dp_ctrl_ex1_single      = ex1_single;
assign dp_ctrl_ex1_half        = ex1_half;
assign dp_ctrl_ex1_bhalf       = ex1_bhalf;
//assign dp_ctrl_double          = fdsu_double;
//assign dp_ctrl_single          = fdsu_single;
//assign dp_ctrl_half            = fdsu_half;
//assign dp_ctrl_bhalf           = fdsu_bhalf;

assign fdsu_ex2_double         = fdsu_double;
assign fdsu_ex2_single         = fdsu_single;
assign fdsu_ex2_half           = fdsu_half;
assign fdsu_ex2_bhalf          = fdsu_bhalf;
//assign fdsu_ex2_f16            = fdsu_half && fdsu_bhalf;
assign fdsu_ex3_double         = fdsu_double;
assign fdsu_ex3_single         = fdsu_single;
assign fdsu_ex3_half           = fdsu_half;
assign fdsu_ex3_bhalf          = fdsu_bhalf;
assign fdsu_ex4_double         = fdsu_double;
assign fdsu_ex4_single         = fdsu_single;
assign fdsu_ex4_half           = fdsu_half;
assign fdsu_ex4_bhalf          = fdsu_bhalf;
assign fdsu_yy_rm[2:0]         = fdsu_rm[2:0];

//*********************************************
// first stage, the operand preparation
//*********************************************
// cost down approch
// the first stage , the FF1 logic will be reused for vector instruction
// //&ConnRule(s/shift/ff1_shift/); @206
//&Instance("aq_fdsu_ff1","x_aq_fdsu_ff1");
// //&Connect(.input_double(ex1_double)); @208
// //&Connect(.input_single(ex1_single)); @209
// //&Connect(.input_half(ex1_half)); @210
// //&Connect(.input_bhalf(ex1_bhalf)); @211

assign ex1_size[3:0]   = {ex1_double,ex1_single,ex1_half||ex1_bhalf,1'b0};
assign ex1_sign        = 1'b0;

// &Instance("aq_vdsp_64_bit_ff1"); @216
aq_vdsp_64_bit_ff1  x_aq_vdsp_64_bit_ff1 (
  .ex1_sign   (ex1_sign  ),
  .ex1_size   (ex1_size  ),
  .ex1_src    (ff1_src_in),
  .ff1_16_bit (ff1_16_bit),
  .ff1_32_bit (ff1_32_bit),
  .ff1_64_bit (ff1_64_bit),
  .ff1_8_bit  (ff1_8_bit )
);

// &Connect(.ex1_sign   (ex1_sign     ), @217
//          .ex1_size   (ex1_size     ), @218
//          .ex1_src    (ff1_src_in   ), @219
//         ); @220

// input signal from the execution pipeline
assign bhalf0_ff1_shift_num_in[15:0]   = {bhalf0_ex1_ff1_frac[6:0],9'b0};
// half preceision fraction
assign half0_ff1_shift_num_in[15:0]    = {half0_ex1_ff1_frac[9:0],6'b0};

assign single0_ff1_shift_num_in[31:0] = {single0_ex1_ff1_frac[22:0],9'b0};

assign double_ff1_shift_num_in[63:0]  = {double0_ex1_ff1_frac[51:0],12'b0};

assign ff1_src_in[63:0]               = {64{ex1_bhalf}} & {48'b0,bhalf0_ff1_shift_num_in[15:0]}  |
                                        {64{ex1_half}}  & {48'b0,half0_ff1_shift_num_in[15:0]}    |
                                        {64{ex1_single}}& {32'b0,single0_ff1_shift_num_in[31:0]}|
                                        {64{ex1_double}}& double_ff1_shift_num_in[63:0];

//output singal of the shift 
assign bhalf0_ex1_id_expnt[12:0]      = {9'b0,ff1_16_bit[3:0]};
assign half0_ex1_id_expnt[12:0]       = {9'b0,ff1_16_bit[3:0]};   
assign single0_ex1_id_expnt[12:0]     = {8'b0,ff1_32_bit[4:0]};
assign double0_ex1_id_expnt[12:0]      = {7'b0,ff1_64_bit[5:0]};



// &Force("nonport","ff1_8_bit"); @244
// &Instance("aq_left_shift_64"); @245
aq_left_shift_64  x_aq_left_shift_64 (
  .input_l16_0_shift_cnt (input_l16_0_shift_cnt),
  .input_l16_1_shift_cnt (input_l16_1_shift_cnt),
  .input_l16_2_shift_cnt (input_l16_2_shift_cnt),
  .input_l16_3_shift_cnt (input_l16_3_shift_cnt),
  .input_l32_0_shift_cnt (input_l32_0_shift_cnt),
  .input_l32_1_shift_cnt (input_l32_1_shift_cnt),
  .input_l64_shift_cnt   (input_l64_shift_cnt  ),
  .input_org_src         (ff1_src_in           ),
  .input_size            (ex1_size[3:1]        ),
  .l16_0_shift_out_val   (l16_0_shift_out_val  ),
  .l16_1_shift_out_val   (l16_1_shift_out_val  ),
  .l16_2_shift_out_val   (l16_2_shift_out_val  ),
  .l16_3_shift_out_val   (l16_3_shift_out_val  ),
  .l32_0_shift_out_val   (l32_0_shift_out_val  ),
  .l32_1_shift_out_val   (l32_1_shift_out_val  ),
  .l64_shift_out_val     (l64_shift_out_val    )
);

// &Connect ( @246
//           .input_org_src        (ff1_src_in            ), @247
//           .input_size           (ex1_size[3:1]      ) @248
//          ); @249

assign input_l64_shift_cnt[5:0]         = double_pipe0_id_expnt_neg_op0[5:0];
                                           
assign input_l32_0_shift_cnt[4:0]       = input_l64_shift_cnt[4:0];           
assign input_l16_0_shift_cnt[3:0]       = input_l64_shift_cnt[3:0];  

assign input_l32_1_shift_cnt[4:0]       = 5'b0;
                                           
assign input_l16_2_shift_cnt[3:0]       = 4'b0;
assign input_l16_1_shift_cnt[3:0]       = 4'b0;
assign input_l16_3_shift_cnt[3:0]       = 4'b0;

// &Force("nonport","l16_1_shift_out_val"); @262
// &Force("nonport","l16_2_shift_out_val"); @263
// &Force("nonport","l16_3_shift_out_val"); @264
// &Force("nonport","l32_1_shift_out_val"); @265

assign double_pipe0_id_expnt_neg_op0[12:0]    = double_pipe0_ex1_op1_sel ? double_pipe0_op1_id_expnt[12:0]
                                                                       : double_pipe0_op0_id_expnt[12:0];
assign double_pipe0_id_expnt_neg[12:0]      = ~double_pipe0_id_expnt_neg_op0[12:0] + 13'b1;

assign double_pipe0_ex1_op0_id_expnt_neg[12:0] = double_pipe0_id_expnt_neg[12:0];
assign double_pipe0_ex1_op1_id_expnt_neg[12:0] = double_pipe0_id_expnt_neg[12:0];
//fraction
assign bhalf0_ex1_id_frac[6:0]        = l16_0_shift_out_val[15:9];
assign half0_ex1_id_frac[9:0]         = l16_0_shift_out_val[15:6];
assign single0_ex1_id_frac[22:0]      = l32_0_shift_out_val[31:9];
assign double0_ex1_id_frac[51:0]       = l64_shift_out_val[63:12];

// &Force("output","double0_ex1_id_frac"); @279
// &Force("output","single0_ex1_id_frac"); @280
// &Force("output","half0_ex1_id_frac"); @281
// &Force("output","bhalf0_ex1_id_frac"); @282

assign ex1_qnan_f_pipe_vld = ex1_pipedown && (double_pipe0_ex1_result_qnan);
assign qnan_f_pack[52:0]   = {53{ex1_double}} & double0_ex1_qnan_f[52:0]         |
                             {53{ex1_single}} & {single0_ex1_qnan_f[23:0],
                                                 24'b0,5'b0} |
                             {53{ex1_half}}   & {half0_ex1_qnan_f[10:0],
                                                 11'b0,
                                                 11'b0,
                                                 11'b0,
                                                 9'b0}                         |
                             {53{ex1_bhalf}}  & {bhalf0_ex1_qnan_f[7:0],
                                                 8'b0,
                                                 8'b0,
                                                 8'b0,
                                                 21'b0};
always @(posedge ex1_pipe_clk)
begin
  if(ex1_qnan_f_pipe_vld)
  begin
    fdsu_qnan_f[52:0]    <= qnan_f_pack[52:0];
  end
end

assign double0_ex4_qnan_f[52:0]  = fdsu_qnan_f[52:0];
assign single0_ex4_qnan_f[23:0] = fdsu_qnan_f[52:29];
assign half0_ex4_qnan_f[10:0]    = fdsu_qnan_f[52:42];
assign bhalf0_ex4_qnan_f[7:0]   = fdsu_qnan_f[52:45];


//******************************************************
// the iteration and other reuse resourses
//******************************************************

//this flop will be used for:
//   1. ex2 exponent 1 operand
//   3. for the denormal result, the round add number
//===================
// ex2 stage single
//===================
assign ex1_expnt_pack[52:0]             = {10'b0,10'b0,
                                                 10'b0,
                                                 10'b0,
                                           double_pipe0_ex1_expnt_adder_op1[12:0]};
assign double_pipe0_ex2_expnt_adder_op1[12:0]  = fdsu_ex3_result_denorm_round_add_num[12:0];

assign double_pipe0_op1_id_expnt[12:0]     = fdsu_ex3_result_denorm_round_add_num[12:0];

//assign ex1_op1_id_expnt_neg_pack[52:0]        = {10'b0,half_pipe1_ex1_op1_id_expnt_neg[9:0],
//                                                       single_pipe_ex1_op1_id_expnt_neg[9:0],
//                                                       half_pipe0_ex1_op1_id_expnt_neg[9:0],
//                                                       double_pipe0_ex1_op1_id_expnt_neg[12:0]};
assign double_pipe0_ff1_cnt[12:0]          = {13{ex1_double}} &  double0_ex1_id_expnt[12:0] |
                                            {13{ex1_single}} &  single0_ex1_id_expnt[12:0] |
                                                {13{ex1_half}} &  half0_ex1_id_expnt[12:0] |
                                                {13{ex1_bhalf}} &  bhalf0_ex1_id_expnt[12:0];
                                              
assign ex1_op1_id_expnt_pack[52:0]            = {10'b0,30'b0,
                                                       double_pipe0_ff1_cnt[12:0]}; 
assign double_pipe0_op0_ff1_cnt[12:0]        = double_pipe0_ff1_cnt[12:0];

//===================
// ex3 stage single 
//===================
assign ex2_pack_denorm_round_add_num[52:0] = 
                           {53{fdsu_double}} & double0_ex2_result_denorm_round_add_num[52:0]  | 
                           {53{fdsu_single}} & {
                                               single0_ex2_result_denorm_round_add_num[23:0],
                                               1'b0,24'b0,4'b0} |
                           {53{fdsu_half}}   & {half0_ex2_result_denorm_round_add_num[10:0],1'b0,
                                               1'b0,11'b0,
                                               1'b0,11'b0,1'b0,
                                               1'b0,11'b0,4'b0}   |
                           {53{fdsu_bhalf}}  & {bhalf0_ex2_result_denorm_round_add_num[7:0],4'b0,
                                                1'b0,8'b0,3'b0,
                                                1'b0,8'b0,4'b0,
                                                1'b0,8'b0,7'b0};

assign double_pipe0_ex3_result_denorm_round_add_num[52:0] = fdsu_ex3_result_denorm_round_add_num[52:0];
//assign ex1_expnt_pack[52:0] = {40'b0,double_pipe0_ex1_expnt_adder_op1[12:0]};
assign ex1_ex2_pipe_clk_en = ex1_pipedown_gate || ex2_pipedown || ex1_save_ff1_op1_id;
// &Instance("gated_clk_cell", "x_ex1_ex2_pipe_clk"); @363
gated_clk_cell  x_ex1_ex2_pipe_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_ex2_pipe_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_ex2_pipe_clk_en),
  .module_en           (cp0_vpu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @364
//          .external_en (1'b0), @365
//          .global_en   (cp0_yy_clk_en), @366
//          .module_en   (cp0_vpu_icg_en), @367
//          .local_en    (ex1_ex2_pipe_clk_en), @368
//          .clk_out     (ex1_ex2_pipe_clk)); @369

always @(posedge ex1_ex2_pipe_clk)
begin
  if(ex1_save_ff1_op1_id)
  begin
    fdsu_ex3_result_denorm_round_add_num[52:0]
                              <= ex1_op1_id_expnt_pack[52:0];
  end
  else if(ex1_pipedown)
    fdsu_ex3_result_denorm_round_add_num[52:0]
                              <= ex1_expnt_pack[52:0];
  else if(ex2_pipedown)
  begin
    fdsu_ex3_result_denorm_round_add_num[52:0]
                              <= ex2_pack_denorm_round_add_num[52:0];
  end
  else
  begin
    fdsu_ex3_result_denorm_round_add_num[52:0]
                              <= fdsu_ex3_result_denorm_round_add_num[52:0];
  end
end


// the iteration flop: remainder and divisor and quotient flop reuse
//*****************************
// remainder flop
//*****************************
// the flop will be reused for all of the remainder 

assign ex1_initial_remainder[59:0] = {60{ex1_double}} & {double0_ex1_remainder[59:0]}  |
                                     {60{ex1_single}} & {single0_ex1_remainder[30:0],9'b0,
                                                         20'b0} |
                                     {60{ex1_half}}   &  {half0_ex1_remainder[18:0],1'b0,
                                                          19'b0,1'b0,
                                                          19'b0,1'b0
                                                          }         |
                                     {60{ex1_bhalf}}  & {bhalf0_ex1_remainder[14:0],1'b0,4'b0,
                                                          15'b0,1'b0,4'b0,
                                                          15'b0,1'b0,4'b0
                                                          };
assign srt_remainder_nxt[59:0]      = {60{fdsu_double}} & {double0_remainder_nxt[59:0]}  |
                                      {60{fdsu_single}} & {single0_remainder_nxt[30:0],9'b0,
                                                           20'b0} |
                                      {60{fdsu_half}}   & {half0_remainder_nxt[18:0],1'b0,
                                                           19'b0,1'b0,
                                                           19'b0,1'b0
                                                           }         |
                                      {60{fdsu_bhalf}}  & {bhalf0_remainder_nxt[14:0],1'b0,4'b0,
                                                           15'b0,1'b0,4'b0,
                                                           15'b0,1'b0,4'b0};
//&Instance("gated_clk_cell","x_srt_rem_clk");
// // &Connect( .clk_in         (forever_cpuclk), @422
// //           .clk_out        (srt_rem_clk),//Out Clock @423
// //           .external_en    (1'b0), @424
// //           .global_en      (cp0_yy_clk_en), @425
// //           .local_en       (srt_rem_clk_en),//Local Condition @426
// //           .module_en      (1'b0) @427
// //         ); @428
// assign srt_rem_clk_en = ex1_pipedown ||
//                         srt_sm_on;                                                         
                                                         
always @(posedge qt_clk)
begin
  if (ex1_pipedown)
    srt_remainder[59:0] <= ex1_initial_remainder[59:0];
  else if (srt_sm_on)
    srt_remainder[59:0] <= srt_remainder_nxt[59:0];
  else
    srt_remainder[59:0] <= srt_remainder[59:0];
end

assign double_pipe0_srt_remainder[59:0] = srt_remainder[59:0];

// output to each srt data path
assign double0_srt_remainder[59:0]  = srt_remainder[59:0];


//******************************
// divisor reuse
//******************************
assign ex1_oper_id_frac_pack[54:0]  = {55{ex1_double}} & {3'b0,double0_ex1_id_frac[51:0]} |
                                      {55{ex1_single}} & {9'b0,23'b0,
                                                               single0_ex1_id_frac[22:0]}|
                                      {55{ex1_half}}   & {15'b0,30'b0,
                                                               half0_ex1_id_frac[9:0]}   |
                                      {55{ex1_bhalf}}   & {27'b0,7'b0,
                                                                 7'b0,
                                                                 7'b0,
                                                                 bhalf0_ex1_id_frac[6:0]};
assign ex1_divisor[54:0]            = {55{ex1_double}} & {2'b0,double0_ex1_divisor[52:0]} |
                                      {55{ex1_single}} & {2'b0,single0_ex1_divisor[23:0],1'b0,
                                                               24'b0,
                                                          4'b0}|
                                      {55{ex1_half}}   & {2'b0,half0_ex1_divisor[10:0],1'b0,
                                                               11'b0,
                                                          2'b0,11'b0,1'b0,
                                                               11'b0,
                                                          5'b0}   |
                                      {55{ex1_bhalf}}   & {2'b0,bhalf0_ex1_divisor[7:0],3'b0,1'b0,
                                                                8'b0,3'b0,
                                                           2'b0,8'b0,3'b0,1'b0,
                                                                8'b0,3'b0,
                                                           5'b0};
                                                             
// &Instance("gated_clk_cell","x_srt_div_clk"); @475
gated_clk_cell  x_srt_div_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (srt_div_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (srt_div_clk_en    ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @476
//           .clk_out        (srt_div_clk),//Out Clock @477
//           .external_en    (1'b0), @478
//           .global_en      (cp0_yy_clk_en), @479
//           .local_en       (srt_div_clk_en),//Local Condition @480
//           .module_en      (cp0_vpu_icg_en) @481
//         ); @482
assign srt_div_clk_en = ex1_pipedown_gate
                     || ex1_save_op0_gate
                     || ex3_pipedown;
assign ex1_save_op0      = ctrl_dp_ex1_save_op0;
assign ex1_save_op0_gate = ctrl_dp_ex1_save_op0_gate;
always @(posedge srt_div_clk)
begin
  if (ex1_save_op0)
    srt_divisor[54:0] <= {{ex1_oper_id_frac_pack[54:0]}};
  else if (ex1_pipedown)
    srt_divisor[54:0] <= {ex1_divisor[54:0]};
  else if (ex3_pipedown)
    srt_divisor[54:0] <= ex3_frac_final_rst[54:0];
  else
    srt_divisor[54:0] <= srt_divisor[54:0];
end

assign ex3_frac_final_rst[54:0]         = {55{fdsu_double}} & double0_ex3_frac_final_rst[54:0]    |
                                          {55{fdsu_single}} & {single0_ex3_frac_final_rst[25:0],
                                                               26'b0,
                                                               3'b0                            } |
                                          {55{fdsu_half}}   & {half0_ex3_frac_final_rst[12:0],
                                                               13'b0,
                                                               13'b0,
                                                               13'b0,
                                                               3'b0                            } |
                                          {55{fdsu_bhalf}}  & {bhalf0_ex3_frac_final_rst[9:0],3'b0,
                                                               10'b0,3'b0,
                                                               10'b0,3'b0,
                                                               10'b0,3'b0,
                                                               3'b0                            };
assign double_pipe0_srt_divisor[52:0]    = srt_divisor[52:0];

assign double0_ex1_id_frac_f[51:0]  = srt_divisor[51:0];
assign single0_ex1_id_frac_f[22:0] = srt_divisor[22:0];
assign half0_ex1_id_frac_f[9:0]    = srt_divisor[9:0];
assign bhalf0_ex1_id_frac_f[6:0]   = srt_divisor[6:0];


assign double_pipe0_fdsu_ex4_frac[54:0]  = srt_divisor[54:0];
//*****************************
// quotient and qt constant flop
//*****************************
// the flop will be reused for all of the datapath

assign dp_xx_ex1_rm[2:0]                    = vpu_group_1_xx_ex1_rm[2:0];
assign qt_rt_const_shift_std_init_val[57:0] = {1'b0,1'b1,56'b0};
                                             
assign qt_rt_const_shift_std_next[57:0] = {2'b0,qt_rt_const_shift_std[57:2]};
assign total_qt_rt_next[57:0]     = {58{fdsu_double}} & {double0_total_qt_rt_next[57:0]} | 
                                    {58{fdsu_single}} & {single0_total_qt_rt_next[27:0],4'b0,
                                                         26'b0}|
                                    {58{fdsu_half || fdsu_bhalf}}
                                                      & {half0_total_qt_rt_next[15:0],
                                                         16'b0,
                                                         16'b0,
                                                         10'b0};
assign total_qt_rt_minus_next[57:0]= {58{fdsu_double}} & {double0_total_qt_rt_minus_next[57:0]} | 
                                     {58{fdsu_single}} & {single0_total_qt_rt_minus_next[27:0],4'b0,
                                                        26'b0}|
                                     {58{fdsu_half || fdsu_bhalf}}
                                                       & {half0_total_qt_rt_minus_next[15:0],
                                                          16'b0,
                                                          16'b0,
                                                          10'b0}; 
                                                        
//gate clk
// &Instance("gated_clk_cell","x_qt_clk"); @550
gated_clk_cell  x_qt_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (qt_clk            ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (qt_clk_en         ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @551
//           .clk_out        (qt_clk),//Out Clock @552
//           .external_en    (1'b0), @553
//           .global_en      (cp0_yy_clk_en), @554
//           .local_en       (qt_clk_en),//Local Condition @555
//           .module_en      (cp0_vpu_icg_en) @556
//         ); @557
assign qt_clk_en = srt_sm_on ||
                   ex1_pipedown_gate;

always @(posedge qt_clk)
begin
  if(ex1_pipedown)
  begin
    qt_rt_const_shift_std[57:0] <= qt_rt_const_shift_std_init_val[57:0];
    total_qt_rt[57:0]           <= 58'b0;
    total_qt_rt_minus[57:0]     <= 58'b0;
  end
  else if(srt_sm_on)
  begin
    qt_rt_const_shift_std[57:0] <= qt_rt_const_shift_std_next[57:0];
    total_qt_rt[57:0]           <= total_qt_rt_next[57:0];
    total_qt_rt_minus[57:0]     <= total_qt_rt_minus_next[57:0];
  end
  else
  begin
    qt_rt_const_shift_std[57:0] <= qt_rt_const_shift_std[57:0];
    total_qt_rt[57:0]           <= total_qt_rt[57:0];
    total_qt_rt_minus[57:0]     <= total_qt_rt_minus[57:0];
  end
end
assign double_pipe0_qt_rt_const_shift_std[57:0] = qt_rt_const_shift_std[57:0];




assign double_pipe0_total_qt_rt[57:0]    = total_qt_rt[57:0];
assign double_pipe0_total_qt_rt_minus[57:0]    = total_qt_rt_minus[57:0];

assign double0_total_qt_rt[57:0]         = total_qt_rt[57:0];
//assign double0_total_qt_rt_minus[57:0]   = total_qt_rt_minus[63:6];

assign single0_total_qt_rt[27:0]        = total_qt_rt[57:30];
//assign single0_total_qt_rt_minus[27:0]  = total_qt_rt_minus[63:36];
assign half0_total_qt_rt[15:0]          = total_qt_rt[57:42];
//assign half0_total_qt_rt_minus[15:0]    = total_qt_rt_minus[63:48];

// &Force("output","double0_total_qt_rt"); @598
// //&Force("output","double0_total_qt_rt_minus"); @599
// &Force("output","single0_total_qt_rt"); @600
// //&Force("output","single0_total_qt_rt_minus"); @601

// &Force("output","half0_total_qt_rt"); @603
// //&Force("output","half0_total_qt_rt_minus"); @604

//=======================================
// remainder reuse for all of the vector
//=======================================
// there will be two adder

assign srt_remainder_shift[59:0]    = double0_srt_remainder_shift[59:0];
assign srt_remainder_add1_op1[59:0] = double0_srt_remainder_add1_op1[59:0];
assign srt_remainder_add1_op2[59:0] = double0_srt_remainder_add1_op2[59:0];
assign srt_remainder_add2_op1[59:0] = double0_srt_remainder_add2_op1[59:0];
assign srt_remainder_add2_op2[59:0] = double0_srt_remainder_add2_op2[59:0];                                                         
// this will be used for cal the +-1 result
assign remainder_adder_1[59:0] = srt_remainder_shift[59:0] 
                                 + srt_remainder_add1_op1[59:0]
                                 + srt_remainder_add1_op2[59:0];

assign remainder_adder_2[59:0] = srt_remainder_shift[59:0] 
                                 + srt_remainder_add2_op1[59:0]
                                 + srt_remainder_add2_op2[59:0];

assign double_pipe0_cur_rem_1[59:0]  = remainder_adder_1[59:0];

assign double_pipe0_cur_rem_2[59:0]  = remainder_adder_2[59:0];


//assign single0_cur_rem_1[30:0]  = remainder_adder_1[44:14];
//assign half3_cur_rem_1[18:0]    = remainder_adder_1[75:57];
//assign half2_cur_rem_1[18:0]    = remainder_adder_1[56:38];
//assign half1_cur_rem_1[18:0]    = remainder_adder_1[37:19];
//assign half0_cur_rem_1[18:0]    = remainder_adder_1[18:0];
//
//assign double_cur_rem_2[59:0]   = remainder_adder_2[75:16];
//assign single1_cur_rem_2[30:0]  = remainder_adder_2[75:45];
//assign single0_cur_rem_2[30:0]  = remainder_adder_2[44:14];
//assign half3_cur_rem_2[18:0]    = remainder_adder_2[75:57];
//assign half2_cur_rem_2[18:0]    = remainder_adder_2[56:38];
//assign half1_cur_rem_2[18:0]    = remainder_adder_2[37:19];
//assign half0_cur_rem_2[18:0]    = remainder_adder_2[18:0];


//=======================================
// round adder reuse
//========================================
assign double_frac[54:0]            = {1'b0,double0_total_qt_rt[56:3]};
assign frac_add1_op0[54:0]          = double_frac[54:0];
assign double_frac_add1_op1[54:0]   = double0_ex3_frac_add1_op1[54:0];
assign single_frac_add1_op1[54:0]   = {single0_ex3_frac_add1_op1[25:0],2'b0,
                                       26'b0,1'b0};
assign half_frac_add1_op1[54:0]     = {half0_ex3_frac_add1_op1[12:0],1'b0,
                                       13'b0,1'b0,
                                       13'b0,1'b0,
                                       13'b0};
assign bhalf_frac_add1_op1[54:0]    = {bhalf0_ex3_frac_add1_op1[9:0],4'b0,
                                       10'b0,4'b0,
                                       10'b0,4'b0,
                                       10'b0,3'b0};

assign frac_add1_op1[54:0]          = {55{fdsu_double}} & double_frac_add1_op1[54:0] |
                                      {55{fdsu_single}} & single_frac_add1_op1[54:0] | 
                                      {55{fdsu_half}}   & half_frac_add1_op1[54:0]   |
                                      {55{fdsu_bhalf}}  & bhalf_frac_add1_op1[54:0];

assign double_frac_sub1_op1[54:0]   = double0_ex3_frac_sub1_op1[54:0];
assign single_frac_sub1_op1[54:0]   = {single0_ex3_frac_sub1_op1[25:0],2'b0,
                                       26'b0,1'b0};
assign half_frac_sub1_op1[54:0]     = {half0_ex3_frac_sub1_op1[12:0],1'b0,
                                       13'b0,1'b0,
                                       13'b0,1'b0,
                                       13'b0};
assign bhalf_frac_sub1_op1[54:0]    = {bhalf0_ex3_frac_sub1_op1[9:0],4'b0,
                                       13'b0,1'b0,
                                       13'b0,1'b0,
                                       13'b0};                                     
assign frac_sub1_op1[54:0]          = {55{fdsu_double}} & double_frac_sub1_op1[54:0] |
                                      {55{fdsu_single}} & single_frac_sub1_op1[54:0] | 
                                      {55{fdsu_half  }} & half_frac_sub1_op1[54:0]   |
                                      {55{fdsu_bhalf }} & bhalf_frac_sub1_op1[54:0];

assign double_frac_sub1_op2[54:0]   = double0_ex3_frac_sub1_op2[54:0];
assign single_frac_sub1_op2[54:0]   = {single0_ex3_frac_sub1_op2[25:0],2'b0,
                                       26'b0,1'b0};

assign half_frac_sub1_op2[54:0]     = {half0_ex3_frac_sub1_op2[12:0],1'b0,
                                       13'b0,1'b0,
                                       13'b0,1'b0,
                                       13'b0};
assign bhalf_frac_sub1_op2[54:0]    = {bhalf0_ex3_frac_sub1_op2[9:0],4'b0,
                                       10'b0,4'b0,
                                       10'b0,4'b0,
                                       10'b0,3'b0};
                                     
assign frac_sub1_op2[54:0]          = {55{fdsu_double}} & double_frac_sub1_op2[54:0] |
                                      {55{fdsu_single}} & single_frac_sub1_op2[54:0] | 
                                      {55{fdsu_half  }} & half_frac_sub1_op2[54:0]   |
                                      {55{fdsu_bhalf  }}& bhalf_frac_sub1_op2[54:0];

assign frac_add1_rst[54:0]          = frac_add1_op0[54:0] + frac_add1_op1[54:0];
assign frac_sub1_rst[54:0]           = frac_add1_op0[54:0] + frac_sub1_op1[54:0]
                                                          + frac_sub1_op2[54:0];

assign double_pipe0_frac_add1_rst[54:0]   = frac_add1_rst[54:0];
assign double_pipe0_frac_sub1_rst[54:0]   = frac_sub1_rst[54:0];



//============================================
//  denormal shift instance
//============================================
// &ConnRule(s/shift/denorm_shift/); @713
// &ConnRule(s/double_/double0_/); @714
// &Instance("aq_fdsu_denorm_shift","x_aq_fdsu_denorm_shift"); @715
aq_fdsu_denorm_shift  x_aq_fdsu_denorm_shift (
  .bhalf0_denorm_to_tiny_frac  (bhalf0_denorm_to_tiny_frac ),
  .bhalf0_shift_num            (bhalf0_denorm_shift_num    ),
  .bhalf0_shift_num_in         (bhalf0_denorm_shift_num_in ),
  .bhalf0_shift_val            (bhalf0_denorm_shift_val    ),
  .bhalf1_denorm_to_tiny_frac  (bhalf1_denorm_to_tiny_frac ),
  .bhalf1_shift_num            (bhalf1_denorm_shift_num    ),
  .bhalf1_shift_num_in         (bhalf1_denorm_shift_num_in ),
  .bhalf1_shift_val            (bhalf1_denorm_shift_val    ),
  .bhalf2_denorm_to_tiny_frac  (bhalf2_denorm_to_tiny_frac ),
  .bhalf2_shift_num            (bhalf2_denorm_shift_num    ),
  .bhalf2_shift_num_in         (bhalf2_denorm_shift_num_in ),
  .bhalf2_shift_val            (bhalf2_denorm_shift_val    ),
  .bhalf3_denorm_to_tiny_frac  (bhalf3_denorm_to_tiny_frac ),
  .bhalf3_shift_num            (bhalf3_denorm_shift_num    ),
  .bhalf3_shift_num_in         (bhalf3_denorm_shift_num_in ),
  .bhalf3_shift_val            (bhalf3_denorm_shift_val    ),
  .double_denorm_to_tiny_frac  (double0_denorm_to_tiny_frac),
  .double_shift_num            (double0_denorm_shift_num   ),
  .double_shift_num_in         (double0_denorm_shift_num_in),
  .double_shift_val            (double0_denorm_shift_val   ),
  .half0_denorm_to_tiny_frac   (half0_denorm_to_tiny_frac  ),
  .half0_shift_num             (half0_denorm_shift_num     ),
  .half0_shift_num_in          (half0_denorm_shift_num_in  ),
  .half0_shift_val             (half0_denorm_shift_val     ),
  .half1_denorm_to_tiny_frac   (half1_denorm_to_tiny_frac  ),
  .half1_shift_num             (half1_denorm_shift_num     ),
  .half1_shift_num_in          (half1_denorm_shift_num_in  ),
  .half1_shift_val             (half1_denorm_shift_val     ),
  .half2_denorm_to_tiny_frac   (half2_denorm_to_tiny_frac  ),
  .half2_shift_num             (half2_denorm_shift_num     ),
  .half2_shift_num_in          (half2_denorm_shift_num_in  ),
  .half2_shift_val             (half2_denorm_shift_val     ),
  .half3_denorm_to_tiny_frac   (half3_denorm_to_tiny_frac  ),
  .half3_shift_num             (half3_denorm_shift_num     ),
  .half3_shift_num_in          (half3_denorm_shift_num_in  ),
  .half3_shift_val             (half3_denorm_shift_val     ),
  .input_bhalf                 (fdsu_bhalf                 ),
  .input_double                (fdsu_double                ),
  .input_half                  (fdsu_half                  ),
  .input_single                (fdsu_single                ),
  .single0_denorm_to_tiny_frac (single0_denorm_to_tiny_frac),
  .single0_shift_num           (single0_denorm_shift_num   ),
  .single0_shift_num_in        (single0_denorm_shift_num_in),
  .single0_shift_val           (single0_denorm_shift_val   ),
  .single1_denorm_to_tiny_frac (single1_denorm_to_tiny_frac),
  .single1_shift_num           (single1_denorm_shift_num   ),
  .single1_shift_num_in        (single1_denorm_shift_num_in),
  .single1_shift_val           (single1_denorm_shift_val   )
);

// &Connect(.input_double(fdsu_double)); @716
// &Connect(.input_single(fdsu_single)); @717
// &Connect(.input_half(fdsu_half)); @718
// &Connect(.input_bhalf(fdsu_bhalf)); @719


assign bhalf1_denorm_shift_num_in[6:0] = 7'b0;
assign bhalf2_denorm_shift_num_in[6:0] = 7'b0;
assign bhalf3_denorm_shift_num_in[6:0] = 7'b0;
assign half1_denorm_shift_num_in[9:0] = 10'b0;
assign half2_denorm_shift_num_in[9:0] = 10'b0;
assign half3_denorm_shift_num_in[9:0] = 10'b0;
// &Force("nonport","bhalf1_denorm_shift_num"); @728
// &Force("nonport","bhalf2_denorm_shift_num"); @729
// &Force("nonport","bhalf3_denorm_shift_num"); @730
// &Force("nonport","half1_denorm_shift_num");  @731
// &Force("nonport","half2_denorm_shift_num");  @732
// &Force("nonport","half3_denorm_shift_num");  @733
// &Force("nonport","single1_denorm_shift_num"); @734

assign bhalf1_denorm_shift_val[8:0] = 9'b0;
assign bhalf2_denorm_shift_val[8:0] = 9'b0;
assign bhalf3_denorm_shift_val[8:0] = 9'b0;
assign half1_denorm_shift_val[5:0] = 6'b0;
assign half2_denorm_shift_val[5:0] = 6'b0;
assign half3_denorm_shift_val[5:0] = 6'b0;
assign single1_denorm_shift_num_in[22:0] = 23'b0;
assign single1_denorm_shift_val[8:0] = 9'b0;
assign bhalf1_denorm_to_tiny_frac    = 1'b0;
assign bhalf2_denorm_to_tiny_frac    = 1'b0;
assign bhalf3_denorm_to_tiny_frac    = 1'b0;
assign single1_denorm_to_tiny_frac    = 1'b0;
assign half1_denorm_to_tiny_frac    = 1'b0;
assign half2_denorm_to_tiny_frac    = 1'b0;
assign half3_denorm_to_tiny_frac    = 1'b0;

//assign vfdsu_rbus_fpr_wb_data[63:0]   = double_pipe0_ex4_result[63:0];
assign vfdsu_rbus_fpr_wb_index[4:0]   = fdsu_wb_freg[6:2];


//assign vfdsu_rbus_fflags[4:0]          = fdsu_scalar ? double_pipe0_ex4_expt[4:0]  
//                                                     : vfdsu_vec_expt[4:0];                                                           

assign vfdsu_ex4_final_result[63:0]   = double_pipe0_ex4_result[63:0];
assign vfdsu_ex4_final_expt[4:0]      = double_pipe0_ex4_expt[4:0];

always @(posedge ex4_pipe_clk)
begin
   if(ex4_pipedown)
    begin
      vfdsu_ex5_result[63:0] <= vfdsu_ex4_final_result[63:0];
      vfdsu_ex5_expt[4:0]    <= vfdsu_ex4_final_expt[4:0];
    end
end
assign vfdsu_rbus_fpr_wb_data[63:0]   = vfdsu_ex5_result[63:0];
assign vfdsu_rbus_fflags[4:0]         = vfdsu_ex5_expt[4:0];


// &ModuleEnd; @774
endmodule


