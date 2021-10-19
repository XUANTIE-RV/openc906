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
module aq_fdsu_top(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  rbus_vfdsu_fpr_wb_grnt,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_flush,
  vfdsu_rbus_fflags,
  vfdsu_rbus_fflags_vld,
  vfdsu_rbus_fpr_wb_data,
  vfdsu_rbus_fpr_wb_index,
  vfdsu_rbus_fpr_wb_req,
  vfdsu_vpu_busy,
  vfdsu_vpu_ex1_denormal_stall,
  vfdsu_vpu_state_idle,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_rm,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1,
  vpu_group_1_xx_ex1_srcv1_type,
  vpu_group_1_xx_ex1_vreg,
  vpu_vfdsu_ex1_sel
);

// &Ports; @24
input           cp0_vpu_icg_en;                              
input           cp0_vpu_xx_bf16;                             
input           cp0_vpu_xx_dqnan;                            
input           cp0_yy_clk_en;                               
input           cpurst_b;                                    
input           forever_cpuclk;                              
input           ifu_vpu_warm_up;                             
input           pad_yy_icg_scan_en;                          
input           rbus_vfdsu_fpr_wb_grnt;                      
input           rtu_yy_xx_async_flush;                       
input           rtu_yy_xx_flush;                             
input   [19:0]  vpu_group_1_xx_ex1_func;                     
input   [2 :0]  vpu_group_1_xx_ex1_rm;                       
input   [63:0]  vpu_group_1_xx_ex1_srcv0;                    
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type;               
input   [63:0]  vpu_group_1_xx_ex1_srcv1;                    
input   [47:0]  vpu_group_1_xx_ex1_srcv1_type;               
input   [6 :0]  vpu_group_1_xx_ex1_vreg;                     
input           vpu_vfdsu_ex1_sel;                           
output  [4 :0]  vfdsu_rbus_fflags;                           
output          vfdsu_rbus_fflags_vld;                       
output  [63:0]  vfdsu_rbus_fpr_wb_data;                      
output  [4 :0]  vfdsu_rbus_fpr_wb_index;                     
output          vfdsu_rbus_fpr_wb_req;                       
output          vfdsu_vpu_busy;                              
output          vfdsu_vpu_ex1_denormal_stall;                
output          vfdsu_vpu_state_idle;                        

// &Regs; @25

// &Wires; @26
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
wire            cp0_vpu_xx_bf16;                             
wire            cp0_vpu_xx_dqnan;                            
wire            cp0_yy_clk_en;                               
wire            cpurst_b;                                    
wire            ctrl_dp_ex1_save_op0;                        
wire            ctrl_dp_ex1_save_op0_gate;                   
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
wire    [59:0]  double_pipe0_cur_rem_1;                      
wire    [59:0]  double_pipe0_cur_rem_2;                      
wire    [12:0]  double_pipe0_ex1_expnt_adder_op1;            
wire            double_pipe0_ex1_ff1_sel_op1;                
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
wire            double_pipe0_ex1_save_op0;                   
wire            double_pipe0_ex1_srt_skip;                   
wire    [12:0]  double_pipe0_ex2_expnt_adder_op1;            
wire            double_pipe0_ex2_of;                         
wire            double_pipe0_ex2_uf_srt_skip;                
wire    [52:0]  double_pipe0_ex3_result_denorm_round_add_num; 
wire    [4 :0]  double_pipe0_ex4_expt;                       
wire    [63:0]  double_pipe0_ex4_result;                     
wire    [54:0]  double_pipe0_fdsu_ex4_frac;                  
wire    [54:0]  double_pipe0_frac_add1_rst;                  
wire    [54:0]  double_pipe0_frac_sub1_rst;                  
wire    [12:0]  double_pipe0_op0_ff1_cnt;                    
wire    [12:0]  double_pipe0_op0_id_expnt;                   
wire    [63:0]  double_pipe0_oper0;                          
wire    [63:0]  double_pipe0_oper1;                          
wire    [57:0]  double_pipe0_qt_rt_const_shift_std;          
wire            double_pipe0_save_op0_neg_expnt;             
wire    [52:0]  double_pipe0_srt_divisor;                    
wire    [59:0]  double_pipe0_srt_remainder;                  
wire            double_pipe0_srt_remainder_zero;             
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
wire            ex1_double;                                  
wire            ex1_double0_op0_id;                          
wire            ex1_double0_op1_id;                          
wire            ex1_f16;                                     
wire            ex1_half;                                    
wire            ex1_half0_op0_id;                            
wire            ex1_half0_op1_id;                            
wire            ex1_pipe_clk;                                
wire            ex1_pipedown;                                
wire            ex1_pipedown_gate;                           
wire            ex1_save_ff1_op1_id;                         
wire            ex1_single;                                  
wire            ex1_single0_op0_id;                          
wire            ex1_single0_op1_id;                          
wire            ex1_sqrt;                                    
wire            ex2_pipe_clk;                                
wire            ex2_pipedown;                                
wire            ex2_srt_first_round;                         
wire            ex3_pipedown;                                
wire            ex4_pipe_clk;                                
wire            ex4_pipedown;                                
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
wire            ifu_vpu_warm_up;                             
wire            pad_yy_icg_scan_en;                          
wire            rbus_vfdsu_fpr_wb_grnt;                      
wire            rtu_yy_xx_async_flush;                       
wire            rtu_yy_xx_flush;                             
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
wire            srt_sm_on;                                   
wire    [4 :0]  vfdsu_rbus_fflags;                           
wire            vfdsu_rbus_fflags_vld;                       
wire    [63:0]  vfdsu_rbus_fpr_wb_data;                      
wire    [4 :0]  vfdsu_rbus_fpr_wb_index;                     
wire            vfdsu_rbus_fpr_wb_req;                       
wire            vfdsu_vpu_busy;                              
wire            vfdsu_vpu_ex1_denormal_stall;                
wire            vfdsu_vpu_state_idle;                        
wire    [19:0]  vpu_group_1_xx_ex1_func;                     
wire    [2 :0]  vpu_group_1_xx_ex1_rm;                       
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;                    
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;               
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;                    
wire    [47:0]  vpu_group_1_xx_ex1_srcv1_type;               
wire    [6 :0]  vpu_group_1_xx_ex1_vreg;                     
wire            vpu_vfdsu_ex1_sel;                           


// &ConnRule(s/double0_pipe/double_pipe0/); @28
// &Instance("aq_fdsu_double"); @29
aq_fdsu_double  x_aq_fdsu_double (
  .bhalf0_denorm_shift_num                      (bhalf0_denorm_shift_num                     ),
  .bhalf0_denorm_shift_num_in                   (bhalf0_denorm_shift_num_in                  ),
  .bhalf0_denorm_shift_val                      (bhalf0_denorm_shift_val                     ),
  .bhalf0_denorm_to_tiny_frac                   (bhalf0_denorm_to_tiny_frac                  ),
  .bhalf0_ex1_divisor                           (bhalf0_ex1_divisor                          ),
  .bhalf0_ex1_ff1_frac                          (bhalf0_ex1_ff1_frac                         ),
  .bhalf0_ex1_id_frac                           (bhalf0_ex1_id_frac                          ),
  .bhalf0_ex1_id_frac_f                         (bhalf0_ex1_id_frac_f                        ),
  .bhalf0_ex1_op0_id_vld                        (bhalf0_ex1_op0_id_vld                       ),
  .bhalf0_ex1_op1_id_vld                        (bhalf0_ex1_op1_id_vld                       ),
  .bhalf0_ex1_op1_sel                           (bhalf0_ex1_op1_sel                          ),
  .bhalf0_ex1_qnan_f                            (bhalf0_ex1_qnan_f                           ),
  .bhalf0_ex1_remainder                         (bhalf0_ex1_remainder                        ),
  .bhalf0_ex2_result_denorm_round_add_num       (bhalf0_ex2_result_denorm_round_add_num      ),
  .bhalf0_ex3_frac_add1_op1                     (bhalf0_ex3_frac_add1_op1                    ),
  .bhalf0_ex3_frac_final_rst                    (bhalf0_ex3_frac_final_rst                   ),
  .bhalf0_ex3_frac_sub1_op1                     (bhalf0_ex3_frac_sub1_op1                    ),
  .bhalf0_ex3_frac_sub1_op2                     (bhalf0_ex3_frac_sub1_op2                    ),
  .bhalf0_ex4_qnan_f                            (bhalf0_ex4_qnan_f                           ),
  .bhalf0_remainder_nxt                         (bhalf0_remainder_nxt                        ),
  .cp0_vpu_icg_en                               (cp0_vpu_icg_en                              ),
  .cp0_vpu_xx_dqnan                             (cp0_vpu_xx_dqnan                            ),
  .cp0_yy_clk_en                                (cp0_yy_clk_en                               ),
  .double0_denorm_shift_num                     (double0_denorm_shift_num                    ),
  .double0_denorm_shift_num_in                  (double0_denorm_shift_num_in                 ),
  .double0_denorm_shift_val                     (double0_denorm_shift_val                    ),
  .double0_denorm_to_tiny_frac                  (double0_denorm_to_tiny_frac                 ),
  .double0_ex1_divisor                          (double0_ex1_divisor                         ),
  .double0_ex1_ff1_frac                         (double0_ex1_ff1_frac                        ),
  .double0_ex1_id_frac                          (double0_ex1_id_frac                         ),
  .double0_ex1_id_frac_f                        (double0_ex1_id_frac_f                       ),
  .double0_ex1_op0_id_vld                       (double0_ex1_op0_id_vld                      ),
  .double0_ex1_op1_id_vld                       (double0_ex1_op1_id_vld                      ),
  .double0_ex1_op1_sel                          (double0_ex1_op1_sel                         ),
  .double0_ex1_qnan_f                           (double0_ex1_qnan_f                          ),
  .double0_ex1_remainder                        (double0_ex1_remainder                       ),
  .double0_ex2_result_denorm_round_add_num      (double0_ex2_result_denorm_round_add_num     ),
  .double0_ex3_frac_add1_op1                    (double0_ex3_frac_add1_op1                   ),
  .double0_ex3_frac_final_rst                   (double0_ex3_frac_final_rst                  ),
  .double0_ex3_frac_sub1_op1                    (double0_ex3_frac_sub1_op1                   ),
  .double0_ex3_frac_sub1_op2                    (double0_ex3_frac_sub1_op2                   ),
  .double0_ex4_qnan_f                           (double0_ex4_qnan_f                          ),
  .double0_pipe_cur_rem_1                       (double_pipe0_cur_rem_1                      ),
  .double0_pipe_cur_rem_2                       (double_pipe0_cur_rem_2                      ),
  .double0_pipe_ex1_expnt_adder_op1             (double_pipe0_ex1_expnt_adder_op1            ),
  .double0_pipe_ex1_ff1_sel_op1                 (double_pipe0_ex1_ff1_sel_op1                ),
  .double0_pipe_ex1_op0_cnan                    (double_pipe0_ex1_op0_cnan                   ),
  .double0_pipe_ex1_op0_id_expnt_neg            (double_pipe0_ex1_op0_id_expnt_neg           ),
  .double0_pipe_ex1_op0_inf                     (double_pipe0_ex1_op0_inf                    ),
  .double0_pipe_ex1_op0_qnan                    (double_pipe0_ex1_op0_qnan                   ),
  .double0_pipe_ex1_op0_snan                    (double_pipe0_ex1_op0_snan                   ),
  .double0_pipe_ex1_op0_zero                    (double_pipe0_ex1_op0_zero                   ),
  .double0_pipe_ex1_op1_cnan                    (double_pipe0_ex1_op1_cnan                   ),
  .double0_pipe_ex1_op1_id_expnt_neg            (double_pipe0_ex1_op1_id_expnt_neg           ),
  .double0_pipe_ex1_op1_inf                     (double_pipe0_ex1_op1_inf                    ),
  .double0_pipe_ex1_op1_qnan                    (double_pipe0_ex1_op1_qnan                   ),
  .double0_pipe_ex1_op1_snan                    (double_pipe0_ex1_op1_snan                   ),
  .double0_pipe_ex1_op1_zero                    (double_pipe0_ex1_op1_zero                   ),
  .double0_pipe_ex1_result_qnan                 (double_pipe0_ex1_result_qnan                ),
  .double0_pipe_ex1_save_op0                    (double_pipe0_ex1_save_op0                   ),
  .double0_pipe_ex1_srt_skip                    (double_pipe0_ex1_srt_skip                   ),
  .double0_pipe_ex2_expnt_adder_op1             (double_pipe0_ex2_expnt_adder_op1            ),
  .double0_pipe_ex2_of                          (double_pipe0_ex2_of                         ),
  .double0_pipe_ex2_uf_srt_skip                 (double_pipe0_ex2_uf_srt_skip                ),
  .double0_pipe_ex3_result_denorm_round_add_num (double_pipe0_ex3_result_denorm_round_add_num),
  .double0_pipe_ex4_expt                        (double_pipe0_ex4_expt                       ),
  .double0_pipe_ex4_result                      (double_pipe0_ex4_result                     ),
  .double0_pipe_fdsu_ex4_frac                   (double_pipe0_fdsu_ex4_frac                  ),
  .double0_pipe_frac_add1_rst                   (double_pipe0_frac_add1_rst                  ),
  .double0_pipe_frac_sub1_rst                   (double_pipe0_frac_sub1_rst                  ),
  .double0_pipe_op0_ff1_cnt                     (double_pipe0_op0_ff1_cnt                    ),
  .double0_pipe_op0_id_expnt                    (double_pipe0_op0_id_expnt                   ),
  .double0_pipe_oper0                           (double_pipe0_oper0                          ),
  .double0_pipe_oper1                           (double_pipe0_oper1                          ),
  .double0_pipe_qt_rt_const_shift_std           (double_pipe0_qt_rt_const_shift_std          ),
  .double0_pipe_save_op0_neg_expnt              (double_pipe0_save_op0_neg_expnt             ),
  .double0_pipe_srt_divisor                     (double_pipe0_srt_divisor                    ),
  .double0_pipe_srt_remainder                   (double_pipe0_srt_remainder                  ),
  .double0_pipe_srt_remainder_zero              (double_pipe0_srt_remainder_zero             ),
  .double0_pipe_total_qt_rt                     (double_pipe0_total_qt_rt                    ),
  .double0_pipe_total_qt_rt_minus               (double_pipe0_total_qt_rt_minus              ),
  .double0_remainder_nxt                        (double0_remainder_nxt                       ),
  .double0_srt_remainder                        (double0_srt_remainder                       ),
  .double0_srt_remainder_add1_op1               (double0_srt_remainder_add1_op1              ),
  .double0_srt_remainder_add1_op2               (double0_srt_remainder_add1_op2              ),
  .double0_srt_remainder_add2_op1               (double0_srt_remainder_add2_op1              ),
  .double0_srt_remainder_add2_op2               (double0_srt_remainder_add2_op2              ),
  .double0_srt_remainder_shift                  (double0_srt_remainder_shift                 ),
  .double0_total_qt_rt                          (double0_total_qt_rt                         ),
  .double0_total_qt_rt_minus_next               (double0_total_qt_rt_minus_next              ),
  .double0_total_qt_rt_next                     (double0_total_qt_rt_next                    ),
  .dp_xx_ex1_rm                                 (dp_xx_ex1_rm                                ),
  .ex1_bhalf                                    (ex1_bhalf                                   ),
  .ex1_bhalf0_op0_id                            (ex1_bhalf0_op0_id                           ),
  .ex1_bhalf0_op1_id                            (ex1_bhalf0_op1_id                           ),
  .ex1_div                                      (ex1_div                                     ),
  .ex1_double                                   (ex1_double                                  ),
  .ex1_double0_op0_id                           (ex1_double0_op0_id                          ),
  .ex1_double0_op1_id                           (ex1_double0_op1_id                          ),
  .ex1_f16                                      (ex1_f16                                     ),
  .ex1_half                                     (ex1_half                                    ),
  .ex1_half0_op0_id                             (ex1_half0_op0_id                            ),
  .ex1_half0_op1_id                             (ex1_half0_op1_id                            ),
  .ex1_pipe_clk                                 (ex1_pipe_clk                                ),
  .ex1_pipedown                                 (ex1_pipedown                                ),
  .ex1_single                                   (ex1_single                                  ),
  .ex1_single0_op0_id                           (ex1_single0_op0_id                          ),
  .ex1_single0_op1_id                           (ex1_single0_op1_id                          ),
  .ex1_sqrt                                     (ex1_sqrt                                    ),
  .ex2_pipe_clk                                 (ex2_pipe_clk                                ),
  .ex2_pipedown                                 (ex2_pipedown                                ),
  .ex2_srt_first_round                          (ex2_srt_first_round                         ),
  .ex3_pipedown                                 (ex3_pipedown                                ),
  .expnt_rst_clk                                (expnt_rst_clk                               ),
  .fdsu_ex1_sel                                 (fdsu_ex1_sel                                ),
  .fdsu_ex2_bhalf                               (fdsu_ex2_bhalf                              ),
  .fdsu_ex2_div                                 (fdsu_ex2_div                                ),
  .fdsu_ex2_double                              (fdsu_ex2_double                             ),
  .fdsu_ex2_half                                (fdsu_ex2_half                               ),
  .fdsu_ex2_single                              (fdsu_ex2_single                             ),
  .fdsu_ex2_sqrt                                (fdsu_ex2_sqrt                               ),
  .fdsu_ex3_bhalf                               (fdsu_ex3_bhalf                              ),
  .fdsu_ex3_double                              (fdsu_ex3_double                             ),
  .fdsu_ex3_half                                (fdsu_ex3_half                               ),
  .fdsu_ex3_single                              (fdsu_ex3_single                             ),
  .fdsu_ex4_bhalf                               (fdsu_ex4_bhalf                              ),
  .fdsu_ex4_double                              (fdsu_ex4_double                             ),
  .fdsu_ex4_half                                (fdsu_ex4_half                               ),
  .fdsu_ex4_single                              (fdsu_ex4_single                             ),
  .fdsu_yy_rm                                   (fdsu_yy_rm                                  ),
  .forever_cpuclk                               (forever_cpuclk                              ),
  .half0_denorm_shift_num                       (half0_denorm_shift_num                      ),
  .half0_denorm_shift_num_in                    (half0_denorm_shift_num_in                   ),
  .half0_denorm_shift_val                       (half0_denorm_shift_val                      ),
  .half0_denorm_to_tiny_frac                    (half0_denorm_to_tiny_frac                   ),
  .half0_ex1_divisor                            (half0_ex1_divisor                           ),
  .half0_ex1_ff1_frac                           (half0_ex1_ff1_frac                          ),
  .half0_ex1_id_frac                            (half0_ex1_id_frac                           ),
  .half0_ex1_id_frac_f                          (half0_ex1_id_frac_f                         ),
  .half0_ex1_op0_id_vld                         (half0_ex1_op0_id_vld                        ),
  .half0_ex1_op1_id_vld                         (half0_ex1_op1_id_vld                        ),
  .half0_ex1_op1_sel                            (half0_ex1_op1_sel                           ),
  .half0_ex1_qnan_f                             (half0_ex1_qnan_f                            ),
  .half0_ex1_remainder                          (half0_ex1_remainder                         ),
  .half0_ex2_result_denorm_round_add_num        (half0_ex2_result_denorm_round_add_num       ),
  .half0_ex3_frac_add1_op1                      (half0_ex3_frac_add1_op1                     ),
  .half0_ex3_frac_final_rst                     (half0_ex3_frac_final_rst                    ),
  .half0_ex3_frac_sub1_op1                      (half0_ex3_frac_sub1_op1                     ),
  .half0_ex3_frac_sub1_op2                      (half0_ex3_frac_sub1_op2                     ),
  .half0_ex4_qnan_f                             (half0_ex4_qnan_f                            ),
  .half0_remainder_nxt                          (half0_remainder_nxt                         ),
  .half0_total_qt_rt                            (half0_total_qt_rt                           ),
  .half0_total_qt_rt_minus_next                 (half0_total_qt_rt_minus_next                ),
  .half0_total_qt_rt_next                       (half0_total_qt_rt_next                      ),
  .pad_yy_icg_scan_en                           (pad_yy_icg_scan_en                          ),
  .single0_denorm_shift_num                     (single0_denorm_shift_num                    ),
  .single0_denorm_shift_num_in                  (single0_denorm_shift_num_in                 ),
  .single0_denorm_shift_val                     (single0_denorm_shift_val                    ),
  .single0_denorm_to_tiny_frac                  (single0_denorm_to_tiny_frac                 ),
  .single0_ex1_divisor                          (single0_ex1_divisor                         ),
  .single0_ex1_ff1_frac                         (single0_ex1_ff1_frac                        ),
  .single0_ex1_id_frac                          (single0_ex1_id_frac                         ),
  .single0_ex1_id_frac_f                        (single0_ex1_id_frac_f                       ),
  .single0_ex1_op0_id_vld                       (single0_ex1_op0_id_vld                      ),
  .single0_ex1_op1_id_vld                       (single0_ex1_op1_id_vld                      ),
  .single0_ex1_op1_sel                          (single0_ex1_op1_sel                         ),
  .single0_ex1_qnan_f                           (single0_ex1_qnan_f                          ),
  .single0_ex1_remainder                        (single0_ex1_remainder                       ),
  .single0_ex2_result_denorm_round_add_num      (single0_ex2_result_denorm_round_add_num     ),
  .single0_ex3_frac_add1_op1                    (single0_ex3_frac_add1_op1                   ),
  .single0_ex3_frac_final_rst                   (single0_ex3_frac_final_rst                  ),
  .single0_ex3_frac_sub1_op1                    (single0_ex3_frac_sub1_op1                   ),
  .single0_ex3_frac_sub1_op2                    (single0_ex3_frac_sub1_op2                   ),
  .single0_ex4_qnan_f                           (single0_ex4_qnan_f                          ),
  .single0_remainder_nxt                        (single0_remainder_nxt                       ),
  .single0_total_qt_rt                          (single0_total_qt_rt                         ),
  .single0_total_qt_rt_minus_next               (single0_total_qt_rt_minus_next              ),
  .single0_total_qt_rt_next                     (single0_total_qt_rt_next                    )
);

// &Instance("aq_fdsu_decd_dp"); @31
// &ConnRule(s/single_pipe/single_pipe1/) @32
// &Instance("aq_fdsu_single"); @33
// &ConnRule(s/fdsu_/single_pipe1_/); @34
// &Instance("aq_fdsu_single_dp"); @35
// &ConnRule(s/half_pipe/half_pipe1/); @37
// &ConnRule(s/half0/half1/); @38
// &Instance("aq_fdsu_half","x_aq_fdsu_half_0"); @39
// &ConnRule(s/fdsu_/half_pipe1_/); @40
// &Instance("aq_fdsu_half_dp","x_aq_fdsu_half_dp_0"); @41
// &ConnRule(s/half_pipe/half_pipe3/); @43
// &ConnRule(s/half0/half3/); @44
// &Instance("aq_fdsu_half","x_aq_fdsu_half_1"); @45
// &ConnRule(s/fdsu_/half_pipe3_/); @46
// &Instance("aq_fdsu_half_dp","x_aq_fdsu_half_dp_1"); @47
// &Instance("aq_fdsu_dp"); @50
// &Instance("aq_fdsu_ctrl"); @51
// &ConnRule(s/double_pipe0/double_pipe1/); @54
// &ConnRule(s/single_pipe1/single_pipe3/); @55
// &ConnRule(s/half_pipe1/half_pipe5/); @56
// &ConnRule(s/half_pipe3/half_pipe7/); @57
// &ConnRule(s/double0/double1/); @58
// &ConnRule(s/single0/single2/); @59
// &ConnRule(s/single1/single3/); @60
// &ConnRule(s/half0/half4/); @61
// &ConnRule(s/half1/half5/); @62
// &ConnRule(s/half2/half6/); @63
// &ConnRule(s/half3/half7/); @64
// &Instance("aq_fdsu_64_slice","aq_fdsu_64_slice_h"); @65
// &Connect(.ex1_norm_src0(ex1_norm_src0[127:64]), @66
//          .ex1_norm_src1(ex1_norm_src1[127:64]), @67
//          .vpu_group_1_xx_ex1_vm_byte_mask(vpu_group_1_xx_ex1_vm_byte_mask[15:8]), @68
//          .vpu_group_1_xx_ex1_vl_byte_mask(vpu_group_1_xx_ex1_vl_byte_mask[15:8]), @69
//          .fdsu_scalar(1'b0), @70
//          .vfdsu_ex5_result(vfdsu_ex5_result_h), @71
//          .vfdsu_ex5_expt  (vfdsu_ex5_expt_h) @72
//         ); @73
// &Instance("aq_fdsu_scalar_dp"); @91
aq_fdsu_scalar_dp  x_aq_fdsu_scalar_dp (
  .bhalf0_denorm_shift_num                      (bhalf0_denorm_shift_num                     ),
  .bhalf0_denorm_shift_num_in                   (bhalf0_denorm_shift_num_in                  ),
  .bhalf0_denorm_shift_val                      (bhalf0_denorm_shift_val                     ),
  .bhalf0_denorm_to_tiny_frac                   (bhalf0_denorm_to_tiny_frac                  ),
  .bhalf0_ex1_divisor                           (bhalf0_ex1_divisor                          ),
  .bhalf0_ex1_ff1_frac                          (bhalf0_ex1_ff1_frac                         ),
  .bhalf0_ex1_id_frac                           (bhalf0_ex1_id_frac                          ),
  .bhalf0_ex1_id_frac_f                         (bhalf0_ex1_id_frac_f                        ),
  .bhalf0_ex1_qnan_f                            (bhalf0_ex1_qnan_f                           ),
  .bhalf0_ex1_remainder                         (bhalf0_ex1_remainder                        ),
  .bhalf0_ex2_result_denorm_round_add_num       (bhalf0_ex2_result_denorm_round_add_num      ),
  .bhalf0_ex3_frac_add1_op1                     (bhalf0_ex3_frac_add1_op1                    ),
  .bhalf0_ex3_frac_final_rst                    (bhalf0_ex3_frac_final_rst                   ),
  .bhalf0_ex3_frac_sub1_op1                     (bhalf0_ex3_frac_sub1_op1                    ),
  .bhalf0_ex3_frac_sub1_op2                     (bhalf0_ex3_frac_sub1_op2                    ),
  .bhalf0_ex4_qnan_f                            (bhalf0_ex4_qnan_f                           ),
  .bhalf0_remainder_nxt                         (bhalf0_remainder_nxt                        ),
  .cp0_vpu_icg_en                               (cp0_vpu_icg_en                              ),
  .cp0_vpu_xx_bf16                              (cp0_vpu_xx_bf16                             ),
  .cp0_yy_clk_en                                (cp0_yy_clk_en                               ),
  .ctrl_dp_ex1_save_op0                         (ctrl_dp_ex1_save_op0                        ),
  .ctrl_dp_ex1_save_op0_gate                    (ctrl_dp_ex1_save_op0_gate                   ),
  .double0_denorm_shift_num                     (double0_denorm_shift_num                    ),
  .double0_denorm_shift_num_in                  (double0_denorm_shift_num_in                 ),
  .double0_denorm_shift_val                     (double0_denorm_shift_val                    ),
  .double0_denorm_to_tiny_frac                  (double0_denorm_to_tiny_frac                 ),
  .double0_ex1_divisor                          (double0_ex1_divisor                         ),
  .double0_ex1_ff1_frac                         (double0_ex1_ff1_frac                        ),
  .double0_ex1_id_frac                          (double0_ex1_id_frac                         ),
  .double0_ex1_id_frac_f                        (double0_ex1_id_frac_f                       ),
  .double0_ex1_qnan_f                           (double0_ex1_qnan_f                          ),
  .double0_ex1_remainder                        (double0_ex1_remainder                       ),
  .double0_ex2_result_denorm_round_add_num      (double0_ex2_result_denorm_round_add_num     ),
  .double0_ex3_frac_add1_op1                    (double0_ex3_frac_add1_op1                   ),
  .double0_ex3_frac_final_rst                   (double0_ex3_frac_final_rst                  ),
  .double0_ex3_frac_sub1_op1                    (double0_ex3_frac_sub1_op1                   ),
  .double0_ex3_frac_sub1_op2                    (double0_ex3_frac_sub1_op2                   ),
  .double0_ex4_qnan_f                           (double0_ex4_qnan_f                          ),
  .double0_remainder_nxt                        (double0_remainder_nxt                       ),
  .double0_srt_remainder                        (double0_srt_remainder                       ),
  .double0_srt_remainder_add1_op1               (double0_srt_remainder_add1_op1              ),
  .double0_srt_remainder_add1_op2               (double0_srt_remainder_add1_op2              ),
  .double0_srt_remainder_add2_op1               (double0_srt_remainder_add2_op1              ),
  .double0_srt_remainder_add2_op2               (double0_srt_remainder_add2_op2              ),
  .double0_srt_remainder_shift                  (double0_srt_remainder_shift                 ),
  .double0_total_qt_rt                          (double0_total_qt_rt                         ),
  .double0_total_qt_rt_minus_next               (double0_total_qt_rt_minus_next              ),
  .double0_total_qt_rt_next                     (double0_total_qt_rt_next                    ),
  .double_pipe0_cur_rem_1                       (double_pipe0_cur_rem_1                      ),
  .double_pipe0_cur_rem_2                       (double_pipe0_cur_rem_2                      ),
  .double_pipe0_ex1_expnt_adder_op1             (double_pipe0_ex1_expnt_adder_op1            ),
  .double_pipe0_ex1_op0_cnan                    (double_pipe0_ex1_op0_cnan                   ),
  .double_pipe0_ex1_op0_id_expnt_neg            (double_pipe0_ex1_op0_id_expnt_neg           ),
  .double_pipe0_ex1_op0_inf                     (double_pipe0_ex1_op0_inf                    ),
  .double_pipe0_ex1_op0_qnan                    (double_pipe0_ex1_op0_qnan                   ),
  .double_pipe0_ex1_op0_snan                    (double_pipe0_ex1_op0_snan                   ),
  .double_pipe0_ex1_op0_zero                    (double_pipe0_ex1_op0_zero                   ),
  .double_pipe0_ex1_op1_cnan                    (double_pipe0_ex1_op1_cnan                   ),
  .double_pipe0_ex1_op1_id_expnt_neg            (double_pipe0_ex1_op1_id_expnt_neg           ),
  .double_pipe0_ex1_op1_inf                     (double_pipe0_ex1_op1_inf                    ),
  .double_pipe0_ex1_op1_qnan                    (double_pipe0_ex1_op1_qnan                   ),
  .double_pipe0_ex1_op1_sel                     (double_pipe0_ex1_op1_sel                    ),
  .double_pipe0_ex1_op1_snan                    (double_pipe0_ex1_op1_snan                   ),
  .double_pipe0_ex1_op1_zero                    (double_pipe0_ex1_op1_zero                   ),
  .double_pipe0_ex1_result_qnan                 (double_pipe0_ex1_result_qnan                ),
  .double_pipe0_ex2_expnt_adder_op1             (double_pipe0_ex2_expnt_adder_op1            ),
  .double_pipe0_ex3_result_denorm_round_add_num (double_pipe0_ex3_result_denorm_round_add_num),
  .double_pipe0_ex4_expt                        (double_pipe0_ex4_expt                       ),
  .double_pipe0_ex4_result                      (double_pipe0_ex4_result                     ),
  .double_pipe0_fdsu_ex4_frac                   (double_pipe0_fdsu_ex4_frac                  ),
  .double_pipe0_frac_add1_rst                   (double_pipe0_frac_add1_rst                  ),
  .double_pipe0_frac_sub1_rst                   (double_pipe0_frac_sub1_rst                  ),
  .double_pipe0_op0_ff1_cnt                     (double_pipe0_op0_ff1_cnt                    ),
  .double_pipe0_op0_id_expnt                    (double_pipe0_op0_id_expnt                   ),
  .double_pipe0_oper0                           (double_pipe0_oper0                          ),
  .double_pipe0_oper1                           (double_pipe0_oper1                          ),
  .double_pipe0_qt_rt_const_shift_std           (double_pipe0_qt_rt_const_shift_std          ),
  .double_pipe0_srt_divisor                     (double_pipe0_srt_divisor                    ),
  .double_pipe0_srt_remainder                   (double_pipe0_srt_remainder                  ),
  .double_pipe0_total_qt_rt                     (double_pipe0_total_qt_rt                    ),
  .double_pipe0_total_qt_rt_minus               (double_pipe0_total_qt_rt_minus              ),
  .dp_ctrl_ex1_bhalf                            (dp_ctrl_ex1_bhalf                           ),
  .dp_ctrl_ex1_div                              (dp_ctrl_ex1_div                             ),
  .dp_ctrl_ex1_double                           (dp_ctrl_ex1_double                          ),
  .dp_ctrl_ex1_half                             (dp_ctrl_ex1_half                            ),
  .dp_ctrl_ex1_single                           (dp_ctrl_ex1_single                          ),
  .dp_xx_ex1_rm                                 (dp_xx_ex1_rm                                ),
  .ex1_bhalf                                    (ex1_bhalf                                   ),
  .ex1_bhalf0_op0_id                            (ex1_bhalf0_op0_id                           ),
  .ex1_bhalf0_op1_id                            (ex1_bhalf0_op1_id                           ),
  .ex1_div                                      (ex1_div                                     ),
  .ex1_double                                   (ex1_double                                  ),
  .ex1_double0_op0_id                           (ex1_double0_op0_id                          ),
  .ex1_double0_op1_id                           (ex1_double0_op1_id                          ),
  .ex1_f16                                      (ex1_f16                                     ),
  .ex1_half                                     (ex1_half                                    ),
  .ex1_half0_op0_id                             (ex1_half0_op0_id                            ),
  .ex1_half0_op1_id                             (ex1_half0_op1_id                            ),
  .ex1_pipe_clk                                 (ex1_pipe_clk                                ),
  .ex1_pipedown                                 (ex1_pipedown                                ),
  .ex1_pipedown_gate                            (ex1_pipedown_gate                           ),
  .ex1_save_ff1_op1_id                          (ex1_save_ff1_op1_id                         ),
  .ex1_single                                   (ex1_single                                  ),
  .ex1_single0_op0_id                           (ex1_single0_op0_id                          ),
  .ex1_single0_op1_id                           (ex1_single0_op1_id                          ),
  .ex1_sqrt                                     (ex1_sqrt                                    ),
  .ex2_pipedown                                 (ex2_pipedown                                ),
  .ex3_pipedown                                 (ex3_pipedown                                ),
  .ex4_pipe_clk                                 (ex4_pipe_clk                                ),
  .ex4_pipedown                                 (ex4_pipedown                                ),
  .fdsu_ex2_bhalf                               (fdsu_ex2_bhalf                              ),
  .fdsu_ex2_div                                 (fdsu_ex2_div                                ),
  .fdsu_ex2_double                              (fdsu_ex2_double                             ),
  .fdsu_ex2_half                                (fdsu_ex2_half                               ),
  .fdsu_ex2_single                              (fdsu_ex2_single                             ),
  .fdsu_ex2_sqrt                                (fdsu_ex2_sqrt                               ),
  .fdsu_ex3_bhalf                               (fdsu_ex3_bhalf                              ),
  .fdsu_ex3_double                              (fdsu_ex3_double                             ),
  .fdsu_ex3_half                                (fdsu_ex3_half                               ),
  .fdsu_ex3_single                              (fdsu_ex3_single                             ),
  .fdsu_ex4_bhalf                               (fdsu_ex4_bhalf                              ),
  .fdsu_ex4_double                              (fdsu_ex4_double                             ),
  .fdsu_ex4_half                                (fdsu_ex4_half                               ),
  .fdsu_ex4_single                              (fdsu_ex4_single                             ),
  .fdsu_yy_rm                                   (fdsu_yy_rm                                  ),
  .forever_cpuclk                               (forever_cpuclk                              ),
  .half0_denorm_shift_num                       (half0_denorm_shift_num                      ),
  .half0_denorm_shift_num_in                    (half0_denorm_shift_num_in                   ),
  .half0_denorm_shift_val                       (half0_denorm_shift_val                      ),
  .half0_denorm_to_tiny_frac                    (half0_denorm_to_tiny_frac                   ),
  .half0_ex1_divisor                            (half0_ex1_divisor                           ),
  .half0_ex1_ff1_frac                           (half0_ex1_ff1_frac                          ),
  .half0_ex1_id_frac                            (half0_ex1_id_frac                           ),
  .half0_ex1_id_frac_f                          (half0_ex1_id_frac_f                         ),
  .half0_ex1_qnan_f                             (half0_ex1_qnan_f                            ),
  .half0_ex1_remainder                          (half0_ex1_remainder                         ),
  .half0_ex2_result_denorm_round_add_num        (half0_ex2_result_denorm_round_add_num       ),
  .half0_ex3_frac_add1_op1                      (half0_ex3_frac_add1_op1                     ),
  .half0_ex3_frac_final_rst                     (half0_ex3_frac_final_rst                    ),
  .half0_ex3_frac_sub1_op1                      (half0_ex3_frac_sub1_op1                     ),
  .half0_ex3_frac_sub1_op2                      (half0_ex3_frac_sub1_op2                     ),
  .half0_ex4_qnan_f                             (half0_ex4_qnan_f                            ),
  .half0_remainder_nxt                          (half0_remainder_nxt                         ),
  .half0_total_qt_rt                            (half0_total_qt_rt                           ),
  .half0_total_qt_rt_minus_next                 (half0_total_qt_rt_minus_next                ),
  .half0_total_qt_rt_next                       (half0_total_qt_rt_next                      ),
  .pad_yy_icg_scan_en                           (pad_yy_icg_scan_en                          ),
  .single0_denorm_shift_num                     (single0_denorm_shift_num                    ),
  .single0_denorm_shift_num_in                  (single0_denorm_shift_num_in                 ),
  .single0_denorm_shift_val                     (single0_denorm_shift_val                    ),
  .single0_denorm_to_tiny_frac                  (single0_denorm_to_tiny_frac                 ),
  .single0_ex1_divisor                          (single0_ex1_divisor                         ),
  .single0_ex1_ff1_frac                         (single0_ex1_ff1_frac                        ),
  .single0_ex1_id_frac                          (single0_ex1_id_frac                         ),
  .single0_ex1_id_frac_f                        (single0_ex1_id_frac_f                       ),
  .single0_ex1_qnan_f                           (single0_ex1_qnan_f                          ),
  .single0_ex1_remainder                        (single0_ex1_remainder                       ),
  .single0_ex2_result_denorm_round_add_num      (single0_ex2_result_denorm_round_add_num     ),
  .single0_ex3_frac_add1_op1                    (single0_ex3_frac_add1_op1                   ),
  .single0_ex3_frac_final_rst                   (single0_ex3_frac_final_rst                  ),
  .single0_ex3_frac_sub1_op1                    (single0_ex3_frac_sub1_op1                   ),
  .single0_ex3_frac_sub1_op2                    (single0_ex3_frac_sub1_op2                   ),
  .single0_ex4_qnan_f                           (single0_ex4_qnan_f                          ),
  .single0_remainder_nxt                        (single0_remainder_nxt                       ),
  .single0_total_qt_rt                          (single0_total_qt_rt                         ),
  .single0_total_qt_rt_minus_next               (single0_total_qt_rt_minus_next              ),
  .single0_total_qt_rt_next                     (single0_total_qt_rt_next                    ),
  .srt_sm_on                                    (srt_sm_on                                   ),
  .vfdsu_rbus_fflags                            (vfdsu_rbus_fflags                           ),
  .vfdsu_rbus_fpr_wb_data                       (vfdsu_rbus_fpr_wb_data                      ),
  .vfdsu_rbus_fpr_wb_index                      (vfdsu_rbus_fpr_wb_index                     ),
  .vpu_group_1_xx_ex1_func                      (vpu_group_1_xx_ex1_func                     ),
  .vpu_group_1_xx_ex1_rm                        (vpu_group_1_xx_ex1_rm                       ),
  .vpu_group_1_xx_ex1_srcv0                     (vpu_group_1_xx_ex1_srcv0                    ),
  .vpu_group_1_xx_ex1_srcv0_type                (vpu_group_1_xx_ex1_srcv0_type               ),
  .vpu_group_1_xx_ex1_srcv1                     (vpu_group_1_xx_ex1_srcv1                    ),
  .vpu_group_1_xx_ex1_srcv1_type                (vpu_group_1_xx_ex1_srcv1_type               ),
  .vpu_group_1_xx_ex1_vreg                      (vpu_group_1_xx_ex1_vreg                     )
);

// &Instance("aq_fdsu_scalar_ctrl"); @92
aq_fdsu_scalar_ctrl  x_aq_fdsu_scalar_ctrl (
  .bhalf0_ex1_op0_id_vld           (bhalf0_ex1_op0_id_vld          ),
  .bhalf0_ex1_op1_id_vld           (bhalf0_ex1_op1_id_vld          ),
  .bhalf0_ex1_op1_sel              (bhalf0_ex1_op1_sel             ),
  .cp0_vpu_icg_en                  (cp0_vpu_icg_en                 ),
  .cp0_yy_clk_en                   (cp0_yy_clk_en                  ),
  .cpurst_b                        (cpurst_b                       ),
  .ctrl_dp_ex1_save_op0            (ctrl_dp_ex1_save_op0           ),
  .ctrl_dp_ex1_save_op0_gate       (ctrl_dp_ex1_save_op0_gate      ),
  .double0_ex1_op0_id_vld          (double0_ex1_op0_id_vld         ),
  .double0_ex1_op1_id_vld          (double0_ex1_op1_id_vld         ),
  .double0_ex1_op1_sel             (double0_ex1_op1_sel            ),
  .double_pipe0_ex1_ff1_sel_op1    (double_pipe0_ex1_ff1_sel_op1   ),
  .double_pipe0_ex1_op1_sel        (double_pipe0_ex1_op1_sel       ),
  .double_pipe0_ex1_save_op0       (double_pipe0_ex1_save_op0      ),
  .double_pipe0_ex1_srt_skip       (double_pipe0_ex1_srt_skip      ),
  .double_pipe0_ex2_of             (double_pipe0_ex2_of            ),
  .double_pipe0_ex2_uf_srt_skip    (double_pipe0_ex2_uf_srt_skip   ),
  .double_pipe0_save_op0_neg_expnt (double_pipe0_save_op0_neg_expnt),
  .double_pipe0_srt_remainder_zero (double_pipe0_srt_remainder_zero),
  .dp_ctrl_ex1_bhalf               (dp_ctrl_ex1_bhalf              ),
  .dp_ctrl_ex1_div                 (dp_ctrl_ex1_div                ),
  .dp_ctrl_ex1_double              (dp_ctrl_ex1_double             ),
  .dp_ctrl_ex1_half                (dp_ctrl_ex1_half               ),
  .dp_ctrl_ex1_single              (dp_ctrl_ex1_single             ),
  .ex1_bhalf                       (ex1_bhalf                      ),
  .ex1_double                      (ex1_double                     ),
  .ex1_half                        (ex1_half                       ),
  .ex1_pipe_clk                    (ex1_pipe_clk                   ),
  .ex1_pipedown                    (ex1_pipedown                   ),
  .ex1_pipedown_gate               (ex1_pipedown_gate              ),
  .ex1_save_ff1_op1_id             (ex1_save_ff1_op1_id            ),
  .ex1_single                      (ex1_single                     ),
  .ex2_pipe_clk                    (ex2_pipe_clk                   ),
  .ex2_pipedown                    (ex2_pipedown                   ),
  .ex2_srt_first_round             (ex2_srt_first_round            ),
  .ex3_pipedown                    (ex3_pipedown                   ),
  .ex4_pipe_clk                    (ex4_pipe_clk                   ),
  .ex4_pipedown                    (ex4_pipedown                   ),
  .expnt_rst_clk                   (expnt_rst_clk                  ),
  .fdsu_ex1_sel                    (fdsu_ex1_sel                   ),
  .forever_cpuclk                  (forever_cpuclk                 ),
  .half0_ex1_op0_id_vld            (half0_ex1_op0_id_vld           ),
  .half0_ex1_op1_id_vld            (half0_ex1_op1_id_vld           ),
  .half0_ex1_op1_sel               (half0_ex1_op1_sel              ),
  .ifu_vpu_warm_up                 (ifu_vpu_warm_up                ),
  .pad_yy_icg_scan_en              (pad_yy_icg_scan_en             ),
  .rbus_vfdsu_fpr_wb_grnt          (rbus_vfdsu_fpr_wb_grnt         ),
  .rtu_yy_xx_async_flush           (rtu_yy_xx_async_flush          ),
  .rtu_yy_xx_flush                 (rtu_yy_xx_flush                ),
  .single0_ex1_op0_id_vld          (single0_ex1_op0_id_vld         ),
  .single0_ex1_op1_id_vld          (single0_ex1_op1_id_vld         ),
  .single0_ex1_op1_sel             (single0_ex1_op1_sel            ),
  .srt_sm_on                       (srt_sm_on                      ),
  .vfdsu_rbus_fflags_vld           (vfdsu_rbus_fflags_vld          ),
  .vfdsu_rbus_fpr_wb_req           (vfdsu_rbus_fpr_wb_req          ),
  .vfdsu_vpu_busy                  (vfdsu_vpu_busy                 ),
  .vfdsu_vpu_ex1_denormal_stall    (vfdsu_vpu_ex1_denormal_stall   ),
  .vfdsu_vpu_state_idle            (vfdsu_vpu_state_idle           ),
  .vpu_vfdsu_ex1_sel               (vpu_vfdsu_ex1_sel              )
);



// &Force("output","vfdsu_rbus_fflags"); @96



// &ModuleEnd; @133
endmodule


