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
module aq_fdsu_srt(
  bhalf0_ex2_result_denorm_round_add_num,
  bhalf0_remainder_nxt,
  double_ex2_result_denorm_round_add_num,
  double_pipe_cur_rem_1,
  double_pipe_cur_rem_2,
  double_pipe_ex2_expnt_adder_op0,
  double_pipe_ex2_expnt_adder_op1,
  double_pipe_ex2_of,
  double_pipe_ex2_of_rm_lfn,
  double_pipe_ex2_op0_norm,
  double_pipe_ex2_op1_norm,
  double_pipe_ex2_potnt_of,
  double_pipe_ex2_potnt_uf,
  double_pipe_ex2_result_inf,
  double_pipe_ex2_result_lfn,
  double_pipe_ex2_rslt_denorm,
  double_pipe_ex2_srt_expnt_rst,
  double_pipe_ex2_uf,
  double_pipe_ex2_uf_srt_skip,
  double_pipe_qt_rt_const_shift_std,
  double_pipe_srt_divisor,
  double_pipe_srt_remainder,
  double_pipe_srt_remainder_zero,
  double_pipe_total_qt_rt,
  double_pipe_total_qt_rt_minus,
  double_remainder_nxt,
  double_srt_remainder,
  double_srt_remainder_add1_op1,
  double_srt_remainder_add1_op2,
  double_srt_remainder_add2_op1,
  double_srt_remainder_add2_op2,
  double_srt_remainder_shift,
  double_total_qt_rt_minus_next,
  double_total_qt_rt_next,
  ex2_pipe_clk,
  ex2_pipedown,
  ex2_srt_first_round,
  fdsu_ex2_bhalf,
  fdsu_ex2_div,
  fdsu_ex2_double,
  fdsu_ex2_half,
  fdsu_ex2_single,
  fdsu_ex2_sqrt,
  fdsu_ex3_id_srt_skip,
  fdsu_ex3_rem_sign,
  fdsu_ex3_rem_zero,
  half0_ex2_result_denorm_round_add_num,
  half0_remainder_nxt,
  half0_total_qt_rt_minus_next,
  half0_total_qt_rt_next,
  single0_ex2_result_denorm_round_add_num,
  single0_remainder_nxt,
  single0_total_qt_rt_minus_next,
  single0_total_qt_rt_next
);

// &Ports; @24
input   [59:0]  double_pipe_cur_rem_1;                  
input   [59:0]  double_pipe_cur_rem_2;                  
input   [12:0]  double_pipe_ex2_expnt_adder_op0;        
input   [12:0]  double_pipe_ex2_expnt_adder_op1;        
input           double_pipe_ex2_of_rm_lfn;              
input           double_pipe_ex2_op0_norm;               
input           double_pipe_ex2_op1_norm;               
input   [57:0]  double_pipe_qt_rt_const_shift_std;      
input   [52:0]  double_pipe_srt_divisor;                
input   [59:0]  double_pipe_srt_remainder;              
input   [57:0]  double_pipe_total_qt_rt;                
input   [57:0]  double_pipe_total_qt_rt_minus;          
input   [59:0]  double_srt_remainder;                   
input           ex2_pipe_clk;                           
input           ex2_pipedown;                           
input           ex2_srt_first_round;                    
input           fdsu_ex2_bhalf;                         
input           fdsu_ex2_div;                           
input           fdsu_ex2_double;                        
input           fdsu_ex2_half;                          
input           fdsu_ex2_single;                        
input           fdsu_ex2_sqrt;                          
output  [7 :0]  bhalf0_ex2_result_denorm_round_add_num; 
output  [14:0]  bhalf0_remainder_nxt;                   
output  [52:0]  double_ex2_result_denorm_round_add_num; 
output          double_pipe_ex2_of;                     
output          double_pipe_ex2_potnt_of;               
output          double_pipe_ex2_potnt_uf;               
output          double_pipe_ex2_result_inf;             
output          double_pipe_ex2_result_lfn;             
output          double_pipe_ex2_rslt_denorm;            
output  [12:0]  double_pipe_ex2_srt_expnt_rst;          
output          double_pipe_ex2_uf;                     
output          double_pipe_ex2_uf_srt_skip;            
output          double_pipe_srt_remainder_zero;         
output  [59:0]  double_remainder_nxt;                   
output  [59:0]  double_srt_remainder_add1_op1;          
output  [59:0]  double_srt_remainder_add1_op2;          
output  [59:0]  double_srt_remainder_add2_op1;          
output  [59:0]  double_srt_remainder_add2_op2;          
output  [59:0]  double_srt_remainder_shift;             
output  [57:0]  double_total_qt_rt_minus_next;          
output  [57:0]  double_total_qt_rt_next;                
output          fdsu_ex3_id_srt_skip;                   
output          fdsu_ex3_rem_sign;                      
output          fdsu_ex3_rem_zero;                      
output  [10:0]  half0_ex2_result_denorm_round_add_num;  
output  [18:0]  half0_remainder_nxt;                    
output  [15:0]  half0_total_qt_rt_minus_next;           
output  [15:0]  half0_total_qt_rt_next;                 
output  [23:0]  single0_ex2_result_denorm_round_add_num; 
output  [30:0]  single0_remainder_nxt;                  
output  [27:0]  single0_total_qt_rt_minus_next;         
output  [27:0]  single0_total_qt_rt_next;               

// &Regs; @25
reg     [59:0]  cur_rem;                                
reg     [7 :0]  digit_bound_1;                          
reg     [7 :0]  digit_bound_2;                          
reg     [52:0]  double_ex2_result_denorm_round_add_num; 
reg             fdsu_ex3_id_srt_skip;                   
reg             fdsu_ex3_rem_sign;                      
reg             fdsu_ex3_rem_zero;                      
reg     [10:0]  half0_ex2_result_denorm_round_add_num;  
reg     [7 :0]  qtrt_sel_rem;                           
reg     [59:0]  rem_add1_op1;                           
reg     [18:0]  rem_add1_op1_h;                         
reg     [30:0]  rem_add1_op1_s;                         
reg     [59:0]  rem_add2_op1;                           
reg     [18:0]  rem_add2_op1_h;                         
reg     [30:0]  rem_add2_op1_s;                         
reg     [23:0]  single0_ex2_result_denorm_round_add_num; 
reg     [57:0]  total_qt_rt_minus_next;                 
reg     [57:0]  total_qt_rt_next;                       

// &Wires; @26
wire    [7 :0]  bhalf0_ex2_result_denorm_round_add_num; 
wire    [14:0]  bhalf0_remainder_nxt;                   
wire    [7 :0]  bound1_cmp_result;                      
wire            bound1_cmp_sign;                        
wire    [7 :0]  bound2_cmp_result;                      
wire            bound2_cmp_sign;                        
wire    [3 :0]  bound_sel;                              
wire    [59:0]  div_qt_1_rem_add_op1;                   
wire    [18:0]  div_qt_1_rem_add_op1_h;                 
wire    [30:0]  div_qt_1_rem_add_op1_s;                 
wire    [59:0]  div_qt_2_rem_add_op1;                   
wire    [18:0]  div_qt_2_rem_add_op1_h;                 
wire    [30:0]  div_qt_2_rem_add_op1_s;                 
wire    [59:0]  div_qt_r1_rem_add_op1;                  
wire    [18:0]  div_qt_r1_rem_add_op1_h;                
wire    [30:0]  div_qt_r1_rem_add_op1_s;                
wire    [59:0]  div_qt_r2_rem_add_op1;                  
wire    [18:0]  div_qt_r2_rem_add_op1_h;                
wire    [30:0]  div_qt_r2_rem_add_op1_s;                
wire    [59:0]  double_pipe_cur_rem_1;                  
wire    [59:0]  double_pipe_cur_rem_2;                  
wire    [12:0]  double_pipe_ex2_expnt_adder_op0;        
wire    [12:0]  double_pipe_ex2_expnt_adder_op1;        
wire            double_pipe_ex2_of;                     
wire            double_pipe_ex2_of_rm_lfn;              
wire            double_pipe_ex2_op0_norm;               
wire            double_pipe_ex2_op1_norm;               
wire            double_pipe_ex2_potnt_of;               
wire            double_pipe_ex2_potnt_uf;               
wire            double_pipe_ex2_result_inf;             
wire            double_pipe_ex2_result_lfn;             
wire            double_pipe_ex2_rslt_denorm;            
wire    [12:0]  double_pipe_ex2_srt_expnt_rst;          
wire            double_pipe_ex2_uf;                     
wire            double_pipe_ex2_uf_srt_skip;            
wire    [57:0]  double_pipe_qt_rt_const_shift_std;      
wire    [52:0]  double_pipe_srt_divisor;                
wire    [59:0]  double_pipe_srt_remainder;              
wire            double_pipe_srt_remainder_zero;         
wire    [57:0]  double_pipe_total_qt_rt;                
wire    [57:0]  double_pipe_total_qt_rt_minus;          
wire    [59:0]  double_remainder_nxt;                   
wire    [59:0]  double_srt_remainder;                   
wire    [59:0]  double_srt_remainder_add1_op1;          
wire    [59:0]  double_srt_remainder_add1_op2;          
wire    [59:0]  double_srt_remainder_add2_op1;          
wire    [59:0]  double_srt_remainder_add2_op2;          
wire    [59:0]  double_srt_remainder_shift;             
wire            double_srt_remainder_zero;              
wire    [57:0]  double_total_qt_rt_minus_next;          
wire    [57:0]  double_total_qt_rt_next;                
wire            ex2_bhalf_div_of;                       
wire            ex2_bhalf_div_uf;                       
wire            ex2_bhalf_exp_potnt_of;                 
wire            ex2_bhalf_exp_potnt_uf;                 
wire            ex2_bhalf_expnt_of;                     
wire            ex2_bhalf_expnt_uf;                     
wire            ex2_bhalf_id_nor_srt_skip;              
wire            ex2_bhalf_potnt_of;                     
wire            ex2_bhalf_potnt_uf;                     
wire            ex2_div_of;                             
wire            ex2_doub_exp_potnt_of;                  
wire            ex2_doub_exp_potnt_uf;                  
wire            ex2_doub_expnt_of;                      
wire            ex2_doub_expnt_uf;                      
wire            ex2_doub_potnt_uf;                      
wire            ex2_double_div_of;                      
wire            ex2_double_div_uf;                      
wire            ex2_double_id_nor_srt_skip;             
wire            ex2_double_potnt_of;                    
wire    [12:0]  ex2_expnt_result;                       
wire            ex2_half_div_of;                        
wire            ex2_half_div_uf;                        
wire            ex2_half_exp_potnt_of;                  
wire            ex2_half_exp_potnt_uf;                  
wire            ex2_half_expnt_of;                      
wire            ex2_half_expnt_uf;                      
wire            ex2_half_id_nor_srt_skip;               
wire            ex2_half_potnt_of;                      
wire            ex2_half_potnt_uf;                      
wire            ex2_id_nor_srt_skip;                    
wire            ex2_of_plus;                            
wire            ex2_pipe_clk;                           
wire            ex2_pipedown;                           
wire            ex2_sing_exp_potnt_of;                  
wire            ex2_sing_exp_potnt_uf;                  
wire            ex2_sing_expnt_of;                      
wire            ex2_sing_expnt_uf;                      
wire            ex2_sing_potnt_uf;                      
wire            ex2_single_div_of;                      
wire            ex2_single_div_uf;                      
wire            ex2_single_id_nor_srt_skip;             
wire            ex2_single_potnt_of;                    
wire    [12:0]  ex2_sqrt_expnt_result;                  
wire    [12:0]  ex2_srt_expnt_rst;                      
wire            ex2_srt_first_round;                    
wire            ex2_uf;                                 
wire            ex2_uf_plus;                            
wire            fdsu_ex2_bhalf;                         
wire            fdsu_ex2_div;                           
wire            fdsu_ex2_double;                        
wire    [12:0]  fdsu_ex2_expnt_rst;                     
wire            fdsu_ex2_half;                          
wire            fdsu_ex2_of_rm_lfn;                     
wire            fdsu_ex2_op0_norm;                      
wire            fdsu_ex2_op1_norm;                      
wire            fdsu_ex2_result_lfn;                    
wire            fdsu_ex2_single;                        
wire            fdsu_ex2_sqrt;                          
wire    [18:0]  half0_remainder_nxt;                    
wire    [15:0]  half0_total_qt_rt_minus_next;           
wire    [15:0]  half0_total_qt_rt_next;                 
wire    [57:0]  qt_rt_const_pre_sel_q1;                 
wire    [57:0]  qt_rt_const_pre_sel_q2;                 
wire    [57:0]  qt_rt_const_q1;                         
wire    [57:0]  qt_rt_const_q2;                         
wire    [57:0]  qt_rt_const_q3;                         
wire    [57:0]  qt_rt_mins_const_pre_sel_q1;            
wire    [57:0]  qt_rt_mins_const_pre_sel_q2;            
wire            rem_sign;                               
wire    [30:0]  single0_remainder_nxt;                  
wire    [27:0]  single0_total_qt_rt_minus_next;         
wire    [27:0]  single0_total_qt_rt_next;               
wire    [59:0]  sqrt_qt_1_rem_add_op1;                  
wire    [18:0]  sqrt_qt_1_rem_add_op1_h;                
wire    [30:0]  sqrt_qt_1_rem_add_op1_s;                
wire    [59:0]  sqrt_qt_2_rem_add_op1;                  
wire    [18:0]  sqrt_qt_2_rem_add_op1_h;                
wire    [30:0]  sqrt_qt_2_rem_add_op1_s;                
wire    [59:0]  sqrt_qt_r1_rem_add_op1;                 
wire    [18:0]  sqrt_qt_r1_rem_add_op1_h;               
wire    [30:0]  sqrt_qt_r1_rem_add_op1_s;               
wire    [59:0]  sqrt_qt_r2_rem_add_op1;                 
wire    [18:0]  sqrt_qt_r2_rem_add_op1_h;               
wire    [30:0]  sqrt_qt_r2_rem_add_op1_s;               
wire    [59:0]  srt_remainder_shift;                    
wire    [59:0]  srt_remainder_shift_cur;                
wire    [18:0]  srt_remainder_shift_h;                  
wire    [30:0]  srt_remainder_shift_s;                  
wire            srt_remainder_sign;                     
wire            srt_remainder_zero;                     
wire    [57:0]  total_qt_rt_pre_sel;                    


//assign fdsu_ex2_div             = fdsu_yy_div;
//assign fdsu_ex2_sqrt            = fdsu_yy_sqrt;
assign fdsu_ex2_op0_norm        = double_pipe_ex2_op0_norm;
assign fdsu_ex2_op1_norm        = double_pipe_ex2_op1_norm;
assign fdsu_ex2_of_rm_lfn       = double_pipe_ex2_of_rm_lfn;
assign fdsu_ex2_result_lfn      = 1'b0;

//==========================================================
//                    EX2 Expnt Generate
//==========================================================
//expnt0 sub expnt1
assign ex2_expnt_result[12:0] =  double_pipe_ex2_expnt_adder_op0[12:0] -
                                 double_pipe_ex2_expnt_adder_op1[12:0];

//===================sqrt exponent prepare==================
//sqrt exponent prepare
//afert E sub, div E by 2
assign ex2_sqrt_expnt_result[12:0] = {ex2_expnt_result[12],
                                      ex2_expnt_result[12:1]};

assign ex2_srt_expnt_rst[12:0] = (fdsu_ex2_sqrt)
                               ? ex2_sqrt_expnt_result[12:0]
                               : ex2_expnt_result[12:0];
assign double_pipe_ex2_srt_expnt_rst[12:0] = ex2_srt_expnt_rst[12:0];
assign fdsu_ex2_expnt_rst[12:0]            = ex2_srt_expnt_rst[12:0];


//====================EX2 Expt info=========================
//EX1 only detect of/uf under id condition
//EX2 will deal with other condition

//========================EX2 Overflow======================
//When input is normal, overflow when E1-E2 > 16/128/1024
assign ex2_doub_expnt_of = ~fdsu_ex2_expnt_rst[12] && (fdsu_ex2_expnt_rst[11:0] > 12'd1024);
assign ex2_sing_expnt_of = ~fdsu_ex2_expnt_rst[9] && (fdsu_ex2_expnt_rst[8:0] > 9'd128);
assign ex2_half_expnt_of = ~fdsu_ex2_expnt_rst[6] && (fdsu_ex2_expnt_rst[5:0] > 6'd16);
assign ex2_bhalf_expnt_of = ex2_sing_expnt_of;
//ex2 overflow when
//  1.op0 & op1 both norm && expnt overflow
//  2.ex1_id_of
// //&Force("output","ex2_of"); @68
assign double_pipe_ex2_of      = ex2_of_plus;
assign ex2_of_plus = ex2_div_of  && fdsu_ex2_div;
assign ex2_double_div_of  = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_doub_expnt_of;
assign ex2_single_div_of  = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_sing_expnt_of;
assign ex2_half_div_of    = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_half_expnt_of;
assign ex2_bhalf_div_of   = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_bhalf_expnt_of;
assign ex2_div_of         = fdsu_ex2_double && ex2_double_div_of || 
                            fdsu_ex2_single && ex2_single_div_of ||
                            fdsu_ex2_half   && ex2_half_div_of   ||
                            fdsu_ex2_bhalf  && ex2_bhalf_div_of;

//potential overflow when E1-E2 = 128/1024
assign ex2_doub_exp_potnt_of  = fdsu_ex2_expnt_rst[12:0] == 13'd1024;
assign ex2_sing_exp_potnt_of  = fdsu_ex2_expnt_rst[9:0]  == 10'd128;
assign ex2_half_exp_potnt_of  = fdsu_ex2_expnt_rst[6:0]  == 7'd16;
assign ex2_bhalf_exp_potnt_of = ex2_sing_exp_potnt_of;
assign ex2_double_potnt_of      = ex2_doub_exp_potnt_of &&
                                  fdsu_ex2_op0_norm &&
                                  fdsu_ex2_op1_norm;
assign ex2_single_potnt_of      = ex2_sing_exp_potnt_of &&
                                  fdsu_ex2_op0_norm &&
                                  fdsu_ex2_op1_norm;
assign ex2_half_potnt_of        = ex2_half_exp_potnt_of &&
                                  fdsu_ex2_op0_norm &&
                                  fdsu_ex2_op1_norm;
assign ex2_bhalf_potnt_of       = ex2_bhalf_exp_potnt_of &&
                                  fdsu_ex2_op0_norm &&
                                  fdsu_ex2_op1_norm;
assign double_pipe_ex2_potnt_of = fdsu_ex2_div  && (
                                  fdsu_ex2_double && ex2_double_potnt_of ||
                                  fdsu_ex2_single && ex2_single_potnt_of ||
                                  fdsu_ex2_half   && ex2_half_potnt_of   ||
                                  fdsu_ex2_bhalf  && ex2_bhalf_potnt_of);

//=======================EX2 Underflow======================
//When input is normal, underflow when E1-E2 <= -127/-1023
assign  ex2_doub_expnt_uf = fdsu_ex2_expnt_rst[12] && (fdsu_ex2_expnt_rst[11:0] <= 12'hc01);
assign ex2_sing_expnt_uf  = fdsu_ex2_expnt_rst[12] &&(fdsu_ex2_expnt_rst[11:0] <= 12'hf81);
assign ex2_half_expnt_uf  = fdsu_ex2_expnt_rst[12] &&(fdsu_ex2_expnt_rst[11:0] <= 12'hff1);
assign ex2_bhalf_expnt_uf = ex2_sing_expnt_uf;
//ex2 underflow when
//  1.op0 & op1 both norm && expnt underflow
//  2.ex1_id_uf
//  and detect when to skip the srt, here, we have further optmization
assign ex2_uf      = ex2_uf_plus;
assign ex2_uf_plus = fdsu_ex2_div && (
                     fdsu_ex2_double && ex2_double_div_uf || 
                     fdsu_ex2_single && ex2_single_div_uf ||
                     fdsu_ex2_half   && ex2_half_div_uf   ||
                     fdsu_ex2_bhalf  && ex2_bhalf_div_uf);
assign ex2_double_div_uf  = fdsu_ex2_op0_norm &&
                           fdsu_ex2_op1_norm &&
                           ex2_doub_expnt_uf;
assign ex2_single_div_uf  = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_sing_expnt_uf; 
assign ex2_half_div_uf    = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_half_expnt_uf;
assign ex2_bhalf_div_uf   = fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            ex2_bhalf_expnt_uf;


// srt underflow skip
assign ex2_double_id_nor_srt_skip =  fdsu_ex2_expnt_rst[12]
                                     && (fdsu_ex2_expnt_rst[11:0]<12'hbcd);
assign ex2_single_id_nor_srt_skip =  fdsu_ex2_expnt_rst[12]
                                     && (fdsu_ex2_expnt_rst[11:0]<12'hf6a);
assign ex2_half_id_nor_srt_skip   =  fdsu_ex2_expnt_rst[12]
                                     && (fdsu_ex2_expnt_rst[11:0]<12'hfe7);
assign ex2_bhalf_id_nor_srt_skip   =  fdsu_ex2_expnt_rst[12]
                                     && (fdsu_ex2_expnt_rst[11:0]<12'hf7a); 

assign ex2_id_nor_srt_skip        = fdsu_ex2_double && ex2_double_id_nor_srt_skip || 
                                    fdsu_ex2_single && ex2_single_id_nor_srt_skip || 
                                    fdsu_ex2_half   && ex2_half_id_nor_srt_skip   || 
                                    fdsu_ex2_bhalf  && ex2_bhalf_id_nor_srt_skip;
assign double_pipe_ex2_uf_srt_skip            = ex2_id_nor_srt_skip;


//potential underflow when E1-E2 = -126/-1022
assign ex2_doub_exp_potnt_uf = fdsu_ex2_expnt_rst[12] && (fdsu_ex2_expnt_rst[11:0] == 12'hc02);
assign ex2_sing_exp_potnt_uf = fdsu_ex2_expnt_rst[12] && (fdsu_ex2_expnt_rst[11:0] == 12'hf82);
assign ex2_half_exp_potnt_uf = fdsu_ex2_expnt_rst[12] && (fdsu_ex2_expnt_rst[11:0] == 12'hff2);
assign ex2_bhalf_exp_potnt_uf= ex2_sing_potnt_uf;
assign double_pipe_ex2_potnt_uf          = fdsu_ex2_double && ex2_doub_potnt_uf || 
                               fdsu_ex2_single && ex2_sing_potnt_uf ||
                               fdsu_ex2_half   && ex2_half_potnt_uf ||
                               fdsu_ex2_bhalf  && ex2_bhalf_potnt_uf;
assign ex2_doub_potnt_uf      = (ex2_doub_exp_potnt_uf &&
                            fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            fdsu_ex2_div)     ||
                           (ex2_doub_exp_potnt_uf &&
                            fdsu_ex2_op0_norm);
assign ex2_sing_potnt_uf      = (ex2_sing_exp_potnt_uf &&
                            fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            fdsu_ex2_div)     ||
                           (ex2_sing_exp_potnt_uf &&
                            fdsu_ex2_op0_norm);
assign ex2_half_potnt_uf      = (ex2_half_exp_potnt_uf &&
                            fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            fdsu_ex2_div)     ||
                           (ex2_half_exp_potnt_uf &&
                            fdsu_ex2_op0_norm);
assign ex2_bhalf_potnt_uf      = (ex2_bhalf_exp_potnt_uf &&
                            fdsu_ex2_op0_norm &&
                            fdsu_ex2_op1_norm &&
                            fdsu_ex2_div)     ||
                           (ex2_bhalf_exp_potnt_uf &&
                            fdsu_ex2_op0_norm);



//===================special result========================
assign double_pipe_ex2_result_inf  = ex2_of_plus && !fdsu_ex2_of_rm_lfn;
assign double_pipe_ex2_result_lfn  = fdsu_ex2_result_lfn ||
                                     ex2_of_plus &&  fdsu_ex2_of_rm_lfn;
assign double_pipe_ex2_rslt_denorm     = ex2_uf;

                       
//===============ex2 round prepare for denormal round======
// &CombBeg; @202
always @( fdsu_ex2_expnt_rst[12:0])
begin
case(fdsu_ex2_expnt_rst[12:0])
  13'h1c02:double_ex2_result_denorm_round_add_num[52:0] = 53'h1; //-1022 1
  13'h1c01:double_ex2_result_denorm_round_add_num[52:0] = 53'h2; //-1023 0
  13'h1c00:double_ex2_result_denorm_round_add_num[52:0] = 53'h4; //-1024 -1
  13'h1bff:double_ex2_result_denorm_round_add_num[52:0] = 53'h8; //-1025 -2
  13'h1bfe:double_ex2_result_denorm_round_add_num[52:0] = 53'h10; //-1026 -3
  13'h1bfd:double_ex2_result_denorm_round_add_num[52:0] = 53'h20; //-1027 -4
  13'h1bfc:double_ex2_result_denorm_round_add_num[52:0] = 53'h40; //-1028 -5
  13'h1bfb:double_ex2_result_denorm_round_add_num[52:0] = 53'h80; //-1029 -6
  13'h1bfa:double_ex2_result_denorm_round_add_num[52:0] = 53'h100; //-1030 -7
  13'h1bf9:double_ex2_result_denorm_round_add_num[52:0] = 53'h200; //-1031 -8
  13'h1bf8:double_ex2_result_denorm_round_add_num[52:0] = 53'h400; //-1032 -9
  13'h1bf7:double_ex2_result_denorm_round_add_num[52:0] = 53'h800; //-1033 -10
  13'h1bf6:double_ex2_result_denorm_round_add_num[52:0] = 53'h1000; //-1034 -11
  13'h1bf5:double_ex2_result_denorm_round_add_num[52:0] = 53'h2000; //-1035 -12
  13'h1bf4:double_ex2_result_denorm_round_add_num[52:0] = 53'h4000; //-1036 -13
  13'h1bf3:double_ex2_result_denorm_round_add_num[52:0] = 53'h8000; // -1037
  13'h1bf2:double_ex2_result_denorm_round_add_num[52:0] = 53'h10000;//-1038
  13'h1bf1:double_ex2_result_denorm_round_add_num[52:0] = 53'h20000;//-1039
  13'h1bf0:double_ex2_result_denorm_round_add_num[52:0] = 53'h40000; //-1040
  13'h1bef:double_ex2_result_denorm_round_add_num[52:0] = 53'h80000; //-1041
  13'h1bee:double_ex2_result_denorm_round_add_num[52:0] = 53'h100000; //-1042
  13'h1bed:double_ex2_result_denorm_round_add_num[52:0] = 53'h200000; //-1043
  13'h1bec:double_ex2_result_denorm_round_add_num[52:0] = 53'h400000; //-1044
  13'h1beb:double_ex2_result_denorm_round_add_num[52:0] = 53'h800000; //-1045
  13'h1bea:double_ex2_result_denorm_round_add_num[52:0] = 53'h1000000;//-1046
  13'h1be9:double_ex2_result_denorm_round_add_num[52:0] = 53'h2000000;//-1047
  13'h1be8:double_ex2_result_denorm_round_add_num[52:0] = 53'h4000000; //-1048
  13'h1be7:double_ex2_result_denorm_round_add_num[52:0] = 53'h8000000; //-1049
  13'h1be6:double_ex2_result_denorm_round_add_num[52:0] = 53'h10000000;//-1050
  13'h1be5:double_ex2_result_denorm_round_add_num[52:0] = 53'h20000000; //-1051
  13'h1be4:double_ex2_result_denorm_round_add_num[52:0] = 53'h40000000; //-1052
  13'h1be3:double_ex2_result_denorm_round_add_num[52:0] = 53'h80000000; //-1053
  13'h1be2:double_ex2_result_denorm_round_add_num[52:0] = 53'h100000000; //-1054
  13'h1be1:double_ex2_result_denorm_round_add_num[52:0] = 53'h200000000; //-1055
  13'h1be0:double_ex2_result_denorm_round_add_num[52:0] = 53'h400000000; //-1056
  13'h1bdf:double_ex2_result_denorm_round_add_num[52:0] = 53'h800000000; //-1057
  13'h1bde:double_ex2_result_denorm_round_add_num[52:0] = 53'h1000000000; //-1058
  13'h1bdd:double_ex2_result_denorm_round_add_num[52:0] = 53'h2000000000; //-1059
  13'h1bdc:double_ex2_result_denorm_round_add_num[52:0] = 53'h4000000000; //-1060
  13'h1bdb:double_ex2_result_denorm_round_add_num[52:0] = 53'h8000000000; //-1061
  13'h1bda:double_ex2_result_denorm_round_add_num[52:0] = 53'h10000000000; //-1062
  13'h1bd9:double_ex2_result_denorm_round_add_num[52:0] = 53'h20000000000; //-1063
  13'h1bd8:double_ex2_result_denorm_round_add_num[52:0] = 53'h40000000000; //-1064
  13'h1bd7:double_ex2_result_denorm_round_add_num[52:0] = 53'h80000000000; //-1065
  13'h1bd6:double_ex2_result_denorm_round_add_num[52:0] = 53'h100000000000; //-1066
  13'h1bd5:double_ex2_result_denorm_round_add_num[52:0] = 53'h200000000000; //-1067
  13'h1bd4:double_ex2_result_denorm_round_add_num[52:0] = 53'h400000000000; //-1068
  13'h1bd3:double_ex2_result_denorm_round_add_num[52:0] = 53'h800000000000; //-1069
  13'h1bd2:double_ex2_result_denorm_round_add_num[52:0] = 53'h1000000000000;//-1070
  13'h1bd1:double_ex2_result_denorm_round_add_num[52:0] = 53'h2000000000000; //-1071
  13'h1bd0:double_ex2_result_denorm_round_add_num[52:0] = 53'h4000000000000; //-1072
  13'h1bcf:double_ex2_result_denorm_round_add_num[52:0] = 53'h8000000000000; //-1073
  13'h1bce:double_ex2_result_denorm_round_add_num[52:0] = 53'h10000000000000; //-1073
  default: double_ex2_result_denorm_round_add_num[52:0] = 53'h0;
endcase
// &CombEnd; @259
end
// &CombBeg; @260
always @( fdsu_ex2_expnt_rst[12:0])
begin
case(fdsu_ex2_expnt_rst[12:0])
  13'h1f82:single0_ex2_result_denorm_round_add_num[23:0] = 24'h1; //-126 1
  13'h1f81:single0_ex2_result_denorm_round_add_num[23:0] = 24'h2; //-127 0
  13'h1f80:single0_ex2_result_denorm_round_add_num[23:0] = 24'h4; //-128 -1
  13'h1f7f:single0_ex2_result_denorm_round_add_num[23:0] = 24'h8; //-129 -2
  13'h1f7e:single0_ex2_result_denorm_round_add_num[23:0] = 24'h10; //-130 -3
  13'h1f7d:single0_ex2_result_denorm_round_add_num[23:0] = 24'h20; //-131 -4
  13'h1f7c:single0_ex2_result_denorm_round_add_num[23:0] = 24'h40; //-132 -5
  13'h1f7b:single0_ex2_result_denorm_round_add_num[23:0] = 24'h80; //-133 -6
  13'h1f7a:single0_ex2_result_denorm_round_add_num[23:0] = 24'h100; //-134 -7
  13'h1f79:single0_ex2_result_denorm_round_add_num[23:0] = 24'h200; //-135 -8
  13'h1f78:single0_ex2_result_denorm_round_add_num[23:0] = 24'h400; //-136 -9
  13'h1f77:single0_ex2_result_denorm_round_add_num[23:0] = 24'h800; //-137 -10
  13'h1f76:single0_ex2_result_denorm_round_add_num[23:0] = 24'h1000; //-138 -11
  13'h1f75:single0_ex2_result_denorm_round_add_num[23:0] = 24'h2000; //-139 -12
  13'h1f74:single0_ex2_result_denorm_round_add_num[23:0] = 24'h4000; //-140 -13
  13'h1f73:single0_ex2_result_denorm_round_add_num[23:0] = 24'h8000; // -141 -14
  13'h1f72:single0_ex2_result_denorm_round_add_num[23:0] = 24'h10000;//-142  -15
  13'h1f71:single0_ex2_result_denorm_round_add_num[23:0] = 24'h20000;//-143 -16
  13'h1f70:single0_ex2_result_denorm_round_add_num[23:0] = 24'h40000; //-144 -17
  13'h1f6f:single0_ex2_result_denorm_round_add_num[23:0] = 24'h80000; //-145 -18
  13'h1f6e:single0_ex2_result_denorm_round_add_num[23:0] = 24'h100000; //-146 -19
  13'h1f6d:single0_ex2_result_denorm_round_add_num[23:0] = 24'h200000; //-147 -20
  13'h1f6c:single0_ex2_result_denorm_round_add_num[23:0] = 24'h400000; //-148 -21
  13'h1f6b:single0_ex2_result_denorm_round_add_num[23:0] = 24'h800000; //-148 -22
  default: single0_ex2_result_denorm_round_add_num[23:0] = 24'h0;  // -23
endcase
// &CombEnd; @288
end
// &Force("output","single0_ex2_result_denorm_round_add_num"); @289
// &CombBeg; @290
always @( fdsu_ex2_expnt_rst[12:0])
begin
case(fdsu_ex2_expnt_rst[12:0])
  13'h1ff2:half0_ex2_result_denorm_round_add_num[10:0] = 11'h1; //-14 1
  13'h1ff1:half0_ex2_result_denorm_round_add_num[10:0] = 11'h2; //-15 0
  13'h1ff0:half0_ex2_result_denorm_round_add_num[10:0] = 11'h4; //-16 -1
  13'h1fef:half0_ex2_result_denorm_round_add_num[10:0] = 11'h8; //-17 -2
  13'h1fee:half0_ex2_result_denorm_round_add_num[10:0] = 11'h10; //-18 -3
  13'h1fed:half0_ex2_result_denorm_round_add_num[10:0] = 11'h20; //-19 -4
  13'h1fec:half0_ex2_result_denorm_round_add_num[10:0] = 11'h40; //-20 -5
  13'h1feb:half0_ex2_result_denorm_round_add_num[10:0] = 11'h80; //-21 -6
  13'h1fea:half0_ex2_result_denorm_round_add_num[10:0] = 11'h100; //-22 -7
  13'h1fe9:half0_ex2_result_denorm_round_add_num[10:0] = 11'h200; //-23 -8
  13'h1fe8:half0_ex2_result_denorm_round_add_num[10:0] = 11'h400; //-24 -9
  default: half0_ex2_result_denorm_round_add_num[10:0] = 11'h0;  // -25
endcase
// &CombEnd; @305
end
assign bhalf0_ex2_result_denorm_round_add_num[7:0] = single0_ex2_result_denorm_round_add_num[7:0];

//assign ex2_result_denorm_round_add_num[52:0] = fdsu_ex2_double ?
//                                               ex2_result_double_denorm_round_add_num[52:0] :
//                                               ex2_result_single_denorm_round_add_num[52:0];





//====================Pipe to EX3===========================
//always @(posedge ex1_ex2_pipe_clk)
//begin
//  if(ex1_pipedown)
//  begin
//    fdsu_ex3_result_denorm_round_add_num[52:0]
//                              <= {40'b0, ex1_expnt_adder_op1[12:0]};
//  end
//  else if(ex2_pipedown)
//  begin
//    fdsu_ex3_result_denorm_round_add_num[52:0]
//                              <= ex2_result_denorm_round_add_num[52:0];
//  end
//  else
//  begin
//    fdsu_ex3_result_denorm_round_add_num[52:0]
//                              <= fdsu_ex3_result_denorm_round_add_num[52:0];
//  end
//end
//assign ex2_expnt_adder_op1 = fdsu_ex3_result_denorm_round_add_num[12:0];

//assign ex1_ex2_pipe_clk_en = ex1_pipedown_gate || ex2_pipedown;
//&Instance("gated_clk_cell", "x_ex1_ex2_pipe_clk");
// //&Connect(.clk_in      (forever_cpuclk), @339
// //         .external_en (1'b0), @340
// //         .global_en   (cp0_yy_clk_en), @341
// //         .module_en   (1'b0), @342
// //         .local_en    (ex1_ex2_pipe_clk_en), @343
// //         .clk_out     (ex1_ex2_pipe_clk)); @344

always @(posedge ex2_pipe_clk)
begin
  if(ex2_pipedown)
  begin
    fdsu_ex3_rem_sign        <= srt_remainder_sign;
    fdsu_ex3_rem_zero        <= srt_remainder_zero;
    fdsu_ex3_id_srt_skip     <= ex2_id_nor_srt_skip;
  end
  else
  begin
    fdsu_ex3_rem_sign        <= fdsu_ex3_rem_sign;
    fdsu_ex3_rem_zero        <= fdsu_ex3_rem_zero;
    fdsu_ex3_id_srt_skip    <=  fdsu_ex3_id_srt_skip;
  end
end

// &Force("output","fdsu_ex3_rem_sign"); @362
// &Force("output","fdsu_ex3_rem_zero"); @363
// //&Force("output","fdsu_ex3_result_denorm_round_add_num"); @364
// &Force("output","fdsu_ex3_id_srt_skip"); @365

//==========================================================
//    SRT Remainder & Divisor for Quotient/Root Generate
//==========================================================

//===================Remainder Generate=====================
//gate clk
// &Instance("gated_clk_cell","x_srt_rem_clk");
// // &Connect( .clk_in         (forever_cpuclk), @374
// //           .clk_out        (srt_rem_clk),//Out Clock @375
// //           .external_en    (1'b0), @376
// //           .global_en      (cp0_yy_clk_en), @377
// //           .local_en       (srt_rem_clk_en),//Local Condition @378
// //           .module_en      (1'b0) @379
// //         ); @380
// assign srt_rem_clk_en = ex1_pipedown ||
//                         srt_sm_on;

//always @(posedge qt_clk)
//begin
//  if (ex1_pipedown)
//    srt_remainder[59:0] <= ex1_remainder[59:0];
//  else if (srt_sm_on)
//    srt_remainder[59:0] <= srt_remainder_nxt[59:0];
//  else
//    srt_remainder[59:0] <= srt_remainder[59:0];
//end
//
////=====================Divisor Generate=====================
////gate clk
//&Instance("gated_clk_cell","x_srt_div_clk");
// //&Connect( .clk_in         (forever_cpuclk), @397
// //          .clk_out        (srt_div_clk),//Out Clock @398
// //          .external_en    (1'b0), @399
// //          .global_en      (cp0_yy_clk_en), @400
// //          .local_en       (srt_div_clk_en),//Local Condition @401
// //          .module_en      (1'b0) @402
// //        ); @403
//assign srt_div_clk_en = ex1_pipedown_gate
//                     || ex1_save_op0_gate
//                     || ex3_pipedown;
//// final_rst saved in srt_divisor.
//// srt_divisor is 53 bits, final_rst is 55 bits.
//always @(posedge srt_div_clk)
//begin
//  if (ex1_save_op0)
//    srt_divisor[54:0] <= {3'b0, {ex1_oper_id_frac[51:0]}};
//  else if (ex1_pipedown)
//    srt_divisor[54:0] <= {2'b0, ex1_divisor[52:0]};
//  else if (ex3_pipedown)
//    srt_divisor[54:0] <= ex3_frac_final_rst[54:0];
//  else
//    srt_divisor[54:0] <= srt_divisor[54:0];
//end
//assign ex1_oper_id_frac_f[51:0] = srt_divisor[51:0];
//assign fdsu_ex4_frac[54:0] = srt_divisor[54:0];

//=======================Bound Select=======================
//---------------------------------------+
// K   | 8 | 9 | 10| 11| 12| 13| 14|15,16|
//---------------------------------------+
//32S1 | 7 | 7 | 8 | 9 | 9 | 10| 11|  12 |
//---------------------------------------+
//32S2 | 25| 28| 31| 33| 36| 39| 41|  47 |
//---------------------------------------+

//bound_sel[3:0]
//For div,  use divisor high four bit as K
//For sqrt, use 2qi high four bit as K next round and
//          use 1010 as K first round
  
assign bound_sel[3:0] = (fdsu_ex2_div)
                      ? double_pipe_srt_divisor[52:49]
                      : (ex2_srt_first_round)
                        ? 4'b1010
                        : double_pipe_total_qt_rt[56:53];
//Select bound as look up table
//   K = bound_sel[3:0]
//32S1 = digit_bound_1[7:0]
//32s2 = digit_bound_2[7:0]
// &CombBeg; @446
always @( bound_sel[3:0])
begin
case(bound_sel[3:0])
4'b0000:       //when first interation get "10", choose k=16
   begin
     digit_bound_1[7:0] = 8'b11110100;//-12
     digit_bound_2[7:0] = 8'b11010001;//-47
   end
4'b1000:
   begin
     digit_bound_1[7:0] = 8'b11111001;//-7
     digit_bound_2[7:0] = 8'b11100111;//-25
   end
4'b1001:
   begin
     digit_bound_1[7:0] = 8'b11111001;//-7
     digit_bound_2[7:0] = 8'b11100100;//-28
   end
4'b1010:
   begin
     digit_bound_1[7:0] = 8'b11111000;//-8
     digit_bound_2[7:0] = 8'b11100001;//-31
   end
4'b1011:
   begin
     digit_bound_1[7:0] = 8'b11110111;//-9
     digit_bound_2[7:0] = 8'b11011111;//-33
   end
4'b1100:
   begin
     digit_bound_1[7:0] = 8'b11110111;//-9
     digit_bound_2[7:0] = 8'b11011100;//-36
   end
4'b1101:
   begin
     digit_bound_1[7:0] = 8'b11110110;//-10
     digit_bound_2[7:0] = 8'b11011001;//-39
   end
4'b1110:
   begin
     digit_bound_1[7:0] = 8'b11110101;//-11
     digit_bound_2[7:0] = 8'b11010111;//-41
   end
4'b1111:
   begin
     digit_bound_1[7:0] = 8'b11110100;//-12
     digit_bound_2[7:0] = 8'b11010001;//-47
   end
default:
   begin
     digit_bound_1[7:0] = 8'b11111001;//-7
     digit_bound_2[7:0] = 8'b11100111;//-25
   end
endcase
// &CombEnd; @499
end

//==============Prepare for quotient generate===============
assign bound1_cmp_result[7:0] = qtrt_sel_rem[7:0] + digit_bound_1[7:0];
assign bound2_cmp_result[7:0] = qtrt_sel_rem[7:0] + digit_bound_2[7:0];
assign bound1_cmp_sign        = bound1_cmp_result[7];
assign bound2_cmp_sign        = bound2_cmp_result[7];
assign rem_sign               = double_pipe_srt_remainder[57];

//qtrt_sel_rem is use to select quotient
//Only when sqrt first round use 8R0 select quotient(special rule)
//4R0 is used to select quotient on other condition
//For negative remaider, we use ~rem not (~rem + 1)
//Because  bound1 <=  rem   <   bound2, when positive rem
//        -bound2 <=  rem   <  -bound1, when negative rem
//Thus     bound1 <  -rem   <=  bound2, when negative rem
//Thus     bound1 <= -rem-1 <   bound2, when negative rem
//Thus     bound1 <= ~rem   <   bound2, when negative rem
//srt_remainder[57] used as sign bit
// &CombBeg; @518
always @( ex2_srt_first_round
       or fdsu_ex2_sqrt
       or double_pipe_srt_remainder[57:49])
begin
if(ex2_srt_first_round && fdsu_ex2_sqrt)
  qtrt_sel_rem[7:0] = {double_pipe_srt_remainder[57],   double_pipe_srt_remainder[55:49]};
else
  qtrt_sel_rem[7:0] =  double_pipe_srt_remainder[57] ? ~double_pipe_srt_remainder[57:50]
                                         :  double_pipe_srt_remainder[57:50];
// &CombEnd; @524
end

////==========================================================
////     on fly round method to generate total quotient
////==========================================================
////gate clk
//&Instance("gated_clk_cell","x_qt_clk");
// //&Connect( .clk_in         (forever_cpuclk), @531
// //          .clk_out        (qt_clk),//Out Clock @532
// //          .external_en    (1'b0), @533
// //          .global_en      (cp0_yy_clk_en), @534
// //          .local_en       (qt_clk_en),//Local Condition @535
// //          .module_en      (1'b0) @536
// //        ); @537
//assign qt_clk_en = srt_sm_on ||
//                   ex1_pipedown_gate;
//
////qt_rt_const_shift_std[57:0] is const data for on fly round
////                which is used to record the times of round
////
////total_qt_rt[57:0]       is total quotient
////total_qt_rt_minus[57:0] is total quotient minus
////                which is used to generate quotient rapidly
//always @(posedge qt_clk)
//begin
//  if(ex1_pipedown)
//  begin
//    qt_rt_const_shift_std[57:0] <= {1'b0,1'b1,56'b0};
//    total_qt_rt_58[57:0]        <= 58'b0;
//    total_qt_rt_minus_58[57:0]  <= 58'b0;
//  end
//  else if(srt_sm_on)
//  begin
//    qt_rt_const_shift_std[57:0] <= qt_rt_const_shift_std_next[57:0];
//    total_qt_rt_58[57:0]        <= total_qt_rt_58_next[57:0];
//    total_qt_rt_minus_58[57:0]  <= total_qt_rt_minus_58_next[57:0];
//  end
//  else
//  begin
//    qt_rt_const_shift_std[57:0] <= qt_rt_const_shift_std[57:0];
//    total_qt_rt_58[57:0]        <= total_qt_rt_58[57:0];
//    total_qt_rt_minus_58[57:0]  <= total_qt_rt_minus_58[57:0];
//  end
//end
// //&Force("output","total_qt_rt_58"); @568

//qt_rt_const_q1/q2/q3 for shift 1/2/3 in
assign qt_rt_const_q1[57:0] =  double_pipe_qt_rt_const_shift_std[57:0];
assign qt_rt_const_q2[57:0] = {double_pipe_qt_rt_const_shift_std[56:0],1'b0};
assign qt_rt_const_q3[57:0] =  qt_rt_const_q1[57:0] |
                               qt_rt_const_q2[57:0];
//qt_rt_const update value
//assign qt_rt_const_shift_std_next[57:0] = {2'b0, double_pipe_qt_rt_const_shift_std[57:2]};

//========total_qt_rt & total_qt_rt_minus update value======
//q(i+1) is the total quotient/root after the (i+1) digit
//is calculated
//                 q(i+1)             qm(i+1)
//d(i+1)=-2     qm(i)+2*shift      qm(i)+1*shift
//d(i+1)=-1     qm(i)+3*shift      qm(i)+2*shift
//d(i+1)=0      q(i)               qm(i)+3*shift
//d(i+1)=1      q(i)+1*shift       q(i)
//d(i+1)=2      q(i)+2*shift       q(i)+1*shift
//Note:
//shift = 4^(-i-1), qm(i+1)=q(i+1)-shift

//pre select for quotient
assign total_qt_rt_pre_sel[57:0]         = (rem_sign) ?
                                           double_pipe_total_qt_rt_minus[57:0] :
                                           double_pipe_total_qt_rt[57:0];
//when the quotient is 2 or -2
assign qt_rt_const_pre_sel_q2[57:0]      = qt_rt_const_q2[57:0];
assign qt_rt_mins_const_pre_sel_q2[57:0] = qt_rt_const_q1[57:0];
//when the quotient is 1 or -1
assign qt_rt_const_pre_sel_q1[57:0]      = (rem_sign) ?
                                           qt_rt_const_q3[57:0] ://-1
                                           qt_rt_const_q1[57:0]; //1
assign qt_rt_mins_const_pre_sel_q1[57:0] = (rem_sign) ?
                                           qt_rt_const_q2[57:0] : //-1
                                           58'b0;

//After bound compare, the final selection
// &CombBeg; @606
always @( qt_rt_mins_const_pre_sel_q2[57:0]
       or qt_rt_mins_const_pre_sel_q1[57:0]
       or double_pipe_total_qt_rt_minus[57:0]
       or bound1_cmp_sign
       or total_qt_rt_pre_sel[57:0]
       or qt_rt_const_pre_sel_q1[57:0]
       or qt_rt_const_q3[57:0]
       or bound2_cmp_sign
       or qt_rt_const_pre_sel_q2[57:0]
       or double_pipe_total_qt_rt[57:0])
begin
casez({bound1_cmp_sign,bound2_cmp_sign})
  2'b00:// the quotient is -2 or 2
  begin
    total_qt_rt_next[57:0]       = total_qt_rt_pre_sel[57:0] |
                                      qt_rt_const_pre_sel_q2[57:0];
    total_qt_rt_minus_next[57:0] = total_qt_rt_pre_sel[57:0] |
                                      qt_rt_mins_const_pre_sel_q2[57:0];
  end
  2'b01:// quotient is -1 or 1
  begin
    total_qt_rt_next[57:0]       = total_qt_rt_pre_sel[57:0] |
                                      qt_rt_const_pre_sel_q1[57:0];
    total_qt_rt_minus_next[57:0] = total_qt_rt_pre_sel[57:0] |
                                      qt_rt_mins_const_pre_sel_q1[57:0];
  end
  2'b1?: // quotient is 0
  begin
    total_qt_rt_next[57:0]       = double_pipe_total_qt_rt[57:0];
    total_qt_rt_minus_next[57:0] = double_pipe_total_qt_rt_minus[57:0] |
                                      qt_rt_const_q3[57:0];
  end
  default:
  begin
    total_qt_rt_next[57:0]       = 58'b0;
    total_qt_rt_minus_next[57:0] = 58'b0;
  end
endcase
// &CombEnd; @634
end
assign double_total_qt_rt_next[57:0]       = total_qt_rt_next[57:0];
assign double_total_qt_rt_minus_next[57:0] = total_qt_rt_minus_next[57:0];
assign single0_total_qt_rt_next[27:0]       = total_qt_rt_next[57:30];
assign single0_total_qt_rt_minus_next[27:0] = total_qt_rt_minus_next[57:30];
assign half0_total_qt_rt_next[15:0]         = total_qt_rt_next[57:42];
assign half0_total_qt_rt_minus_next[15:0]   = total_qt_rt_minus_next[57:42];

//==========================================================
//      on fly round method to generate cur remainder
//==========================================================
//Division emainder add value
//Quoit 1
assign div_qt_1_rem_add_op1[59:0]     = ~{3'b0,double_pipe_srt_divisor[52:0],4'b0};
assign div_qt_1_rem_add_op1_s[30:0]   = ~{3'b0,double_pipe_srt_divisor[52:29],4'b0};
assign div_qt_1_rem_add_op1_h[18:0]   = ~{3'b0,double_pipe_srt_divisor[52:42],5'b0};
//Quoit 2
assign div_qt_2_rem_add_op1[59:0]     = ~{2'b0,double_pipe_srt_divisor[52:0],5'b0};
assign div_qt_2_rem_add_op1_s[30:0]   = ~{2'b0,double_pipe_srt_divisor[52:29],5'b0};
assign div_qt_2_rem_add_op1_h[18:0]   = ~{2'b0,double_pipe_srt_divisor[52:42],6'b0};
//Quoit -1
assign div_qt_r1_rem_add_op1[59:0]    =  {3'b0,double_pipe_srt_divisor[52:0],4'b0};
assign div_qt_r1_rem_add_op1_s[30:0]  =  {3'b0,double_pipe_srt_divisor[52:29],4'b0};
assign div_qt_r1_rem_add_op1_h[18:0]  =  {3'b0,double_pipe_srt_divisor[52:42],5'b0};
//Quoit -2
assign div_qt_r2_rem_add_op1[59:0]    =  {2'b0,double_pipe_srt_divisor[52:0],5'b0};
assign div_qt_r2_rem_add_op1_s[30:0]  =  {2'b0,double_pipe_srt_divisor[52:29],5'b0};
assign div_qt_r2_rem_add_op1_h[18:0]  =  {2'b0,double_pipe_srt_divisor[52:42],6'b0};

//Sqrt remainder add value op1
//Quoit 1
assign sqrt_qt_1_rem_add_op1[59:0]    = ~({2'b0,double_pipe_total_qt_rt[57:0]} |
                                        {3'b0,qt_rt_const_q1[57:1]});
assign sqrt_qt_1_rem_add_op1_s[30:0]  = ~({2'b0,double_pipe_total_qt_rt[57:30],1'b0} |
                                         {3'b0,qt_rt_const_q1[57:30]});
assign sqrt_qt_1_rem_add_op1_h[18:0]  = ~({2'b0,double_pipe_total_qt_rt[57:42],1'b0} |
                                         {3'b0,qt_rt_const_q1[57:42]});
//Quoit 2
assign sqrt_qt_2_rem_add_op1[59:0]  = ~({1'b0,double_pipe_total_qt_rt[57:0],1'b0} |
                                        {1'b0,qt_rt_const_q1[57:0],1'b0});

assign sqrt_qt_2_rem_add_op1_s[30:0]  = ~({1'b0,double_pipe_total_qt_rt[57:30],2'b0} |
                                        {1'b0,qt_rt_const_q1[57:30],2'b0});
assign sqrt_qt_2_rem_add_op1_h[18:0]  = ~({1'b0,double_pipe_total_qt_rt[57:42],2'b0} |
                                        {1'b0,qt_rt_const_q1[57:42],2'b0});
//Quoit -1
assign sqrt_qt_r1_rem_add_op1[59:0] =   {2'b0,double_pipe_total_qt_rt_minus[57:0]} |
                                        {1'b0,qt_rt_const_q1[57:0],1'b0}  |
                                        {2'b0,qt_rt_const_q1[57:0]}       |
                                        {3'b0,qt_rt_const_q1[57:1]};
assign sqrt_qt_r1_rem_add_op1_s[30:0] =   {2'b0,double_pipe_total_qt_rt_minus[57:30],1'b0} |
                                        {1'b0,qt_rt_const_q1[57:30],2'b0}  |
                                        {2'b0,qt_rt_const_q1[57:30],1'b0}       |
                                        {3'b0,qt_rt_const_q1[57:30]};
assign sqrt_qt_r1_rem_add_op1_h[18:0] =   {2'b0,double_pipe_total_qt_rt_minus[57:42],1'b0} |
                                        {1'b0,qt_rt_const_q1[57:42],2'b0}  |
                                        {2'b0,qt_rt_const_q1[57:42],1'b0}       |
                                        {3'b0,qt_rt_const_q1[57:42]};
//Quoit -2
assign sqrt_qt_r2_rem_add_op1[59:0] =   {1'b0,
                                         double_pipe_total_qt_rt_minus[57:0],1'b0} |
                                        {qt_rt_const_q1[57:0],2'b0}       |
                                        {1'b0,qt_rt_const_q1[57:0],1'b0};
assign sqrt_qt_r2_rem_add_op1_s[30:0] =   {1'b0,
                                         double_pipe_total_qt_rt_minus[57:30],2'b0} |
                                        {qt_rt_const_q1[57:30],3'b0}       |
                                        {1'b0,qt_rt_const_q1[57:30],2'b0};
assign sqrt_qt_r2_rem_add_op1_h[18:0] =   {1'b0,
                                         double_pipe_total_qt_rt_minus[57:42],2'b0} |
                                        {qt_rt_const_q1[57:42],3'b0}       |
                                        {1'b0,qt_rt_const_q1[57:42],2'b0};
//Remainder Adder select logic
// &CombBeg; @706
always @( div_qt_1_rem_add_op1_s[30:0]
       or sqrt_qt_2_rem_add_op1_h[18:0]
       or rem_sign
       or div_qt_1_rem_add_op1[59:0]
       or sqrt_qt_r2_rem_add_op1[59:0]
       or div_qt_2_rem_add_op1_h[18:0]
       or sqrt_qt_r1_rem_add_op1[59:0]
       or sqrt_qt_1_rem_add_op1[59:0]
       or div_qt_r1_rem_add_op1[59:0]
       or div_qt_r2_rem_add_op1_h[18:0]
       or div_qt_2_rem_add_op1[59:0]
       or fdsu_ex2_sqrt
       or sqrt_qt_2_rem_add_op1[59:0]
       or sqrt_qt_r2_rem_add_op1_h[18:0]
       or div_qt_r1_rem_add_op1_s[30:0]
       or sqrt_qt_r1_rem_add_op1_h[18:0]
       or sqrt_qt_2_rem_add_op1_s[30:0]
       or sqrt_qt_r2_rem_add_op1_s[30:0]
       or sqrt_qt_1_rem_add_op1_h[18:0]
       or div_qt_r1_rem_add_op1_h[18:0]
       or sqrt_qt_r1_rem_add_op1_s[30:0]
       or div_qt_1_rem_add_op1_h[18:0]
       or div_qt_r2_rem_add_op1_s[30:0]
       or div_qt_r2_rem_add_op1[59:0]
       or sqrt_qt_1_rem_add_op1_s[30:0]
       or div_qt_2_rem_add_op1_s[30:0])
begin
case({rem_sign,fdsu_ex2_sqrt})
  2'b01:
  begin
        rem_add1_op1[59:0]   = sqrt_qt_1_rem_add_op1[59:0];
        rem_add2_op1[59:0]   = sqrt_qt_2_rem_add_op1[59:0];
        rem_add1_op1_s[30:0] = sqrt_qt_1_rem_add_op1_s[30:0];
        rem_add2_op1_s[30:0] = sqrt_qt_2_rem_add_op1_s[30:0];
        rem_add1_op1_h[18:0] = sqrt_qt_1_rem_add_op1_h[18:0];
        rem_add2_op1_h[18:0] = sqrt_qt_2_rem_add_op1_h[18:0];
  end
  2'b00:
  begin
        rem_add1_op1[59:0]   = div_qt_1_rem_add_op1[59:0];
        rem_add2_op1[59:0]   = div_qt_2_rem_add_op1[59:0];
        rem_add1_op1_s[30:0] = div_qt_1_rem_add_op1_s[30:0];
        rem_add2_op1_s[30:0] = div_qt_2_rem_add_op1_s[30:0];
        rem_add1_op1_h[18:0] = div_qt_1_rem_add_op1_h[18:0];
        rem_add2_op1_h[18:0] = div_qt_2_rem_add_op1_h[18:0];
  end
  2'b11:
  begin
        rem_add1_op1[59:0]   = sqrt_qt_r1_rem_add_op1[59:0];
        rem_add2_op1[59:0]   = sqrt_qt_r2_rem_add_op1[59:0];
        rem_add1_op1_s[30:0] = sqrt_qt_r1_rem_add_op1_s[30:0];
        rem_add2_op1_s[30:0] = sqrt_qt_r2_rem_add_op1_s[30:0];
        rem_add1_op1_h[18:0] = sqrt_qt_r1_rem_add_op1_h[18:0];
        rem_add2_op1_h[18:0] = sqrt_qt_r2_rem_add_op1_h[18:0];
  end
  2'b10:
  begin
        rem_add1_op1[59:0]   = div_qt_r1_rem_add_op1[59:0];
        rem_add2_op1[59:0]   = div_qt_r2_rem_add_op1[59:0];
        rem_add1_op1_s[30:0] = div_qt_r1_rem_add_op1_s[30:0];
        rem_add2_op1_s[30:0] = div_qt_r2_rem_add_op1_s[30:0];
        rem_add1_op1_h[18:0] = div_qt_r1_rem_add_op1_h[18:0];
        rem_add2_op1_h[18:0] = div_qt_r2_rem_add_op1_h[18:0];
  end
  default :
  begin
        rem_add1_op1[59:0] = 60'b0;
        rem_add2_op1[59:0] = 60'b0;
        rem_add1_op1_s[30:0] = 31'b0;
        rem_add2_op1_s[30:0] = 31'b0;
        rem_add1_op1_h[18:0] = 19'b0;
        rem_add2_op1_h[18:0] = 19'b0;
  end
  endcase
// &CombEnd; @754
end
assign srt_remainder_shift[59:0] = {double_pipe_srt_remainder[59],
                                    double_pipe_srt_remainder[56:0],2'b0};
assign srt_remainder_shift_s[30:0] = {double_pipe_srt_remainder[59],
                                    double_pipe_srt_remainder[56:29],2'b0};
assign srt_remainder_shift_h[18:0] = {double_pipe_srt_remainder[59],
                                    double_pipe_srt_remainder[56:41],2'b0};
assign srt_remainder_shift_cur[59:0] = {60{fdsu_ex2_double}} & srt_remainder_shift[59:0]  |
                                       {60{fdsu_ex2_single}} & {srt_remainder_shift_s[30:0],29'b0} |
                                       {60{(fdsu_ex2_half 
                                        || fdsu_ex2_bhalf)}} & {srt_remainder_shift_h[18:0],41'b0};
assign double_srt_remainder_shift[59:0]     = srt_remainder_shift[59:0];
// adder 1
assign double_srt_remainder_add1_op1[59:0]  = rem_add1_op1[59:0];
assign double_srt_remainder_add1_op2[59:0]  = {59'b0, ~rem_sign};

//adder 2
assign double_srt_remainder_add2_op1[59:0]  = rem_add2_op1[59:0];
assign double_srt_remainder_add2_op2[59:0]  = {59'b0, ~rem_sign};

// &Force("nonport","rem_add1_op1_h"); @786
// &Force("nonport","rem_add1_op1_s"); @787
// &Force("nonport","rem_add2_op1_h"); @788
// &Force("nonport","rem_add2_op1_s"); @789
//Remainder add
//assign cur_doub_rem_1[59:0]      = srt_remainder_shift[59:0] +
//                                   rem_add1_op1[59:0]    +
//                                   {59'b0, ~rem_sign};
//assign cur_doub_rem_2[59:0]      = srt_remainder_shift[59:0] +
//                                   rem_add2_op1[59:0]    +
//                                   {59'b0, ~rem_sign};
//assign cur_rem_1[59:0]           = cur_doub_rem_1[59:0];
//assign cur_rem_2[59:0]           = cur_doub_rem_2[59:0];
//Generate srt remainder update value
// &CombBeg; @801
always @( srt_remainder_shift_cur[59:0]
       or bound1_cmp_sign
       or double_pipe_cur_rem_1[59:0]
       or double_pipe_cur_rem_2[59:0]
       or bound2_cmp_sign)
begin
case({bound1_cmp_sign,bound2_cmp_sign})
  2'b00:   cur_rem[59:0]         = double_pipe_cur_rem_2[59:0];  //+-2
  2'b01:   cur_rem[59:0]         = double_pipe_cur_rem_1[59:0];  //+-1
  default: cur_rem[59:0]         = srt_remainder_shift_cur[59:0]; //0
endcase
// &CombEnd; @807
end
assign double_remainder_nxt[59:0]   = cur_rem[59:0];
assign single0_remainder_nxt[30:0]  = cur_rem[59:29];
assign half0_remainder_nxt[18:0]    = cur_rem[59:41];
assign bhalf0_remainder_nxt[14:0]   = cur_rem[59:45];

// &Force("output","double_remainder_nxt"); @813
//Remainder is zero signal in EX3

assign double_pipe_srt_remainder_zero         = srt_remainder_zero;
assign double_srt_remainder_zero  = ~|double_srt_remainder[59:0];
assign srt_remainder_zero = double_srt_remainder_zero;
// //&Force("output","srt_remainder_zero"); @829
assign srt_remainder_sign        =   double_remainder_nxt[59];
// to dp single 
assign double_pipe_ex2_uf = ex2_uf;
// &ModuleEnd; @833
endmodule



