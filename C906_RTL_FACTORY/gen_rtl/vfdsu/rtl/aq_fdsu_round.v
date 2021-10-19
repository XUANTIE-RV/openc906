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
module aq_fdsu_round(
  bhalf0_ex3_frac_add1_op1,
  bhalf0_ex3_frac_final_rst,
  bhalf0_ex3_frac_sub1_op1,
  bhalf0_ex3_frac_sub1_op2,
  cp0_vpu_icg_en,
  cp0_yy_clk_en,
  double_ex3_frac_add1_op1,
  double_ex3_frac_final_rst,
  double_ex3_frac_sub1_op1,
  double_ex3_frac_sub1_op2,
  double_pipe_ex3_expnt_adjust_result,
  double_pipe_ex3_expnt_rst,
  double_pipe_ex3_potnt_uf,
  double_pipe_ex3_result_denorm_round_add_num,
  double_pipe_ex3_result_inf,
  double_pipe_ex3_result_lfn,
  double_pipe_ex3_result_qnan,
  double_pipe_ex3_result_sign,
  double_pipe_ex3_result_zero,
  double_pipe_ex3_rslt_denorm,
  double_pipe_ex3_rslt_denorm_in,
  double_pipe_ex4_denorm_to_tiny_frac,
  double_pipe_ex4_nx,
  double_pipe_ex4_potnt_norm,
  double_pipe_ex4_result_nor,
  double_pipe_frac_add1_rst,
  double_pipe_frac_sub1_rst,
  double_pipe_total_qt_rt,
  double_total_qt_rt,
  ex3_pipedown,
  fdsu_ex3_bhalf,
  fdsu_ex3_double,
  fdsu_ex3_half,
  fdsu_ex3_id_srt_skip,
  fdsu_ex3_rem_sign,
  fdsu_ex3_rem_zero,
  fdsu_ex3_single,
  fdsu_yy_rm,
  forever_cpuclk,
  half0_ex3_frac_add1_op1,
  half0_ex3_frac_final_rst,
  half0_ex3_frac_sub1_op1,
  half0_ex3_frac_sub1_op2,
  half0_total_qt_rt,
  pad_yy_icg_scan_en,
  single0_ex3_frac_add1_op1,
  single0_ex3_frac_final_rst,
  single0_ex3_frac_sub1_op1,
  single0_ex3_frac_sub1_op2,
  single0_total_qt_rt
);

// &Ports; @24
input           cp0_vpu_icg_en;                             
input           cp0_yy_clk_en;                              
input   [12:0]  double_pipe_ex3_expnt_rst;                  
input           double_pipe_ex3_potnt_uf;                   
input   [52:0]  double_pipe_ex3_result_denorm_round_add_num; 
input           double_pipe_ex3_result_inf;                 
input           double_pipe_ex3_result_lfn;                 
input           double_pipe_ex3_result_qnan;                
input           double_pipe_ex3_result_sign;                
input           double_pipe_ex3_result_zero;                
input           double_pipe_ex3_rslt_denorm_in;             
input   [54:0]  double_pipe_frac_add1_rst;                  
input   [54:0]  double_pipe_frac_sub1_rst;                  
input   [57:0]  double_pipe_total_qt_rt;                    
input   [57:0]  double_total_qt_rt;                         
input           ex3_pipedown;                               
input           fdsu_ex3_bhalf;                             
input           fdsu_ex3_double;                            
input           fdsu_ex3_half;                              
input           fdsu_ex3_id_srt_skip;                       
input           fdsu_ex3_rem_sign;                          
input           fdsu_ex3_rem_zero;                          
input           fdsu_ex3_single;                            
input   [2 :0]  fdsu_yy_rm;                                 
input           forever_cpuclk;                             
input   [15:0]  half0_total_qt_rt;                          
input           pad_yy_icg_scan_en;                         
input   [27:0]  single0_total_qt_rt;                        
output  [9 :0]  bhalf0_ex3_frac_add1_op1;                   
output  [9 :0]  bhalf0_ex3_frac_final_rst;                  
output  [9 :0]  bhalf0_ex3_frac_sub1_op1;                   
output  [9 :0]  bhalf0_ex3_frac_sub1_op2;                   
output  [54:0]  double_ex3_frac_add1_op1;                   
output  [54:0]  double_ex3_frac_final_rst;                  
output  [54:0]  double_ex3_frac_sub1_op1;                   
output  [54:0]  double_ex3_frac_sub1_op2;                   
output  [12:0]  double_pipe_ex3_expnt_adjust_result;        
output          double_pipe_ex3_rslt_denorm;                
output          double_pipe_ex4_denorm_to_tiny_frac;        
output          double_pipe_ex4_nx;                         
output  [1 :0]  double_pipe_ex4_potnt_norm;                 
output          double_pipe_ex4_result_nor;                 
output  [12:0]  half0_ex3_frac_add1_op1;                    
output  [12:0]  half0_ex3_frac_final_rst;                   
output  [12:0]  half0_ex3_frac_sub1_op1;                    
output  [12:0]  half0_ex3_frac_sub1_op2;                    
output  [25:0]  single0_ex3_frac_add1_op1;                  
output  [25:0]  single0_ex3_frac_final_rst;                 
output  [25:0]  single0_ex3_frac_sub1_op1;                  
output  [25:0]  single0_ex3_frac_sub1_op2;                  

// &Regs; @25
reg             bhalf_denorm_lst_frac;                      
reg             denorm_to_tiny_frac;                        
reg             double_denorm_lst_frac;                     
reg             double_pipe_ex4_denorm_to_tiny_frac;        
reg             double_pipe_ex4_nx;                         
reg     [1 :0]  double_pipe_ex4_potnt_norm;                 
reg             double_pipe_ex4_result_nor;                 
reg             frac_add_1;                                 
reg             frac_orig;                                  
reg             frac_sub_1;                                 
reg             half_denorm_lst_frac;                       
reg     [9 :0]  qt_result_bhalf_denorm_for_round;           
reg     [56:0]  qt_result_double_denorm_for_round;          
reg     [13:0]  qt_result_half_denorm_for_round;            
reg     [25:0]  qt_result_single_denorm_for_round;          
reg             single_denorm_lst_frac;                     

// &Wires; @26
wire    [9 :0]  bhalf0_ex3_frac_add1_op1;                   
wire    [9 :0]  bhalf0_ex3_frac_final_rst;                  
wire    [9 :0]  bhalf0_ex3_frac_sub1_op1;                   
wire    [9 :0]  bhalf0_ex3_frac_sub1_op2;                   
wire    [9 :0]  bhalf0_frac_add1_op1;                       
wire    [9 :0]  bhalf0_frac_sub1_op1;                       
wire            cp0_vpu_icg_en;                             
wire            cp0_yy_clk_en;                              
wire    [54:0]  double_ex3_frac_add1_op1;                   
wire    [54:0]  double_ex3_frac_final_rst;                  
wire    [54:0]  double_ex3_frac_sub1_op1;                   
wire    [54:0]  double_ex3_frac_sub1_op2;                   
wire    [54:0]  double_frac_add1_op1;                       
wire    [54:0]  double_frac_sub1_op1;                       
wire    [12:0]  double_pipe_ex3_expnt_adjust_result;        
wire    [12:0]  double_pipe_ex3_expnt_rst;                  
wire            double_pipe_ex3_potnt_uf;                   
wire    [52:0]  double_pipe_ex3_result_denorm_round_add_num; 
wire            double_pipe_ex3_result_inf;                 
wire            double_pipe_ex3_result_lfn;                 
wire            double_pipe_ex3_result_qnan;                
wire            double_pipe_ex3_result_sign;                
wire            double_pipe_ex3_result_zero;                
wire            double_pipe_ex3_rslt_denorm;                
wire            double_pipe_ex3_rslt_denorm_in;             
wire    [54:0]  double_pipe_frac_add1_rst;                  
wire    [54:0]  double_pipe_frac_sub1_rst;                  
wire    [57:0]  double_pipe_total_qt_rt;                    
wire    [57:0]  double_total_qt_rt;                         
wire            ex3_bhalf_denorm_eq;                        
wire            ex3_bhalf_denorm_gr;                        
wire            ex3_bhalf_denorm_plus;                      
wire            ex3_bhalf_denorm_potnt_norm;                
wire            ex3_bhalf_denorm_zero;                      
wire            ex3_bhalf_eq;                               
wire            ex3_bhalf_gr;                               
wire            ex3_bhalf_low_not_zero;                     
wire            ex3_bhalf_rslt_denorm;                      
wire            ex3_bhalf_rst_eq_1;                         
wire            ex3_bhalf_zero;                             
wire            ex3_denorm_eq;                              
wire            ex3_denorm_gr;                              
wire            ex3_denorm_lst_frac;                        
wire            ex3_denorm_nx;                              
wire            ex3_denorm_plus;                            
wire            ex3_denorm_potnt_norm;                      
wire            ex3_denorm_zero;                            
wire            ex3_doub_denorm_plus;                       
wire            ex3_doub_denorm_potnt_norm;                 
wire            ex3_doub_eq;                                
wire            ex3_doub_gr;                                
wire            ex3_doub_rslt_denorm;                       
wire            ex3_doub_rst_eq_1;                          
wire            ex3_doub_zero;                              
wire            ex3_double_denorm_eq;                       
wire            ex3_double_denorm_gr;                       
wire            ex3_double_denorm_zero;                     
wire            ex3_double_low_not_zero;                    
wire    [12:0]  ex3_expnt_adjst;                            
wire            ex3_half_denorm_eq;                         
wire            ex3_half_denorm_gr;                         
wire            ex3_half_denorm_plus;                       
wire            ex3_half_denorm_potnt_norm;                 
wire            ex3_half_denorm_zero;                       
wire            ex3_half_eq;                                
wire            ex3_half_gr;                                
wire            ex3_half_low_not_zero;                      
wire            ex3_half_rslt_denorm;                       
wire            ex3_half_rst_eq_1;                          
wire            ex3_half_zero;                              
wire            ex3_nx;                                     
wire            ex3_pipe_clk;                               
wire            ex3_pipe_clk_en;                            
wire            ex3_pipedown;                               
wire    [1 :0]  ex3_potnt_norm;                             
wire            ex3_qt_bhalf_lo1_not0;                      
wire            ex3_qt_bhalf_lo2_not0;                      
wire            ex3_qt_doub_lo2_not0;                       
wire            ex3_qt_doub_lo3_not0;                       
wire            ex3_qt_eq;                                  
wire            ex3_qt_gr;                                  
wire            ex3_qt_half_lo2_not0;                       
wire            ex3_qt_half_lo3_not0;                       
wire            ex3_qt_sing_lo3_not0;                       
wire            ex3_qt_sing_lo4_not0;                       
wire            ex3_qt_zero;                                
wire            ex3_rslt_denorm;                            
wire            ex3_rst_eq_1;                               
wire            ex3_rst_nor;                                
wire            ex3_sing_denorm_plus;                       
wire            ex3_sing_denorm_potnt_norm;                 
wire            ex3_sing_eq;                                
wire            ex3_sing_gr;                                
wire            ex3_sing_rslt_denorm;                       
wire            ex3_sing_rst_eq_1;                          
wire            ex3_sing_zero;                              
wire            ex3_single_denorm_eq;                       
wire            ex3_single_denorm_gr;                       
wire            ex3_single_denorm_zero;                     
wire            ex3_single_low_not_zero;                    
wire            expnt_m127;                                 
wire            fdsu_ex3_bhalf;                             
wire            fdsu_ex3_double;                            
wire    [12:0]  fdsu_ex3_expnt_rst;                         
wire            fdsu_ex3_half;                              
wire            fdsu_ex3_id_srt_skip;                       
wire            fdsu_ex3_potnt_uf;                          
wire            fdsu_ex3_rem_sign;                          
wire            fdsu_ex3_rem_zero;                          
wire            fdsu_ex3_result_inf;                        
wire            fdsu_ex3_result_lfn;                        
wire            fdsu_ex3_result_qnan;                       
wire            fdsu_ex3_result_sign;                       
wire            fdsu_ex3_result_zero;                       
wire    [2 :0]  fdsu_ex3_rm;                                
wire            fdsu_ex3_rslt_denorm;                       
wire            fdsu_ex3_single;                            
wire    [2 :0]  fdsu_yy_rm;                                 
wire            forever_cpuclk;                             
wire            frac_denorm_rdn_add_1;                      
wire            frac_denorm_rdn_sub_1;                      
wire            frac_denorm_rmm_add_1;                      
wire            frac_denorm_rne_add_1;                      
wire            frac_denorm_rtz_sub_1;                      
wire            frac_denorm_rup_add_1;                      
wire            frac_denorm_rup_sub_1;                      
wire    [54:0]  frac_final_rst;                             
wire            frac_rdn_add_1;                             
wire            frac_rdn_sub_1;                             
wire            frac_rmm_add_1;                             
wire            frac_rne_add_1;                             
wire            frac_rtz_sub_1;                             
wire            frac_rup_add_1;                             
wire            frac_rup_sub_1;                             
wire    [54:0]  frac_sub1_rst;                              
wire    [12:0]  half0_ex3_frac_add1_op1;                    
wire    [12:0]  half0_ex3_frac_final_rst;                   
wire    [12:0]  half0_ex3_frac_sub1_op1;                    
wire    [12:0]  half0_ex3_frac_sub1_op2;                    
wire    [12:0]  half0_frac_add1_op1;                        
wire    [12:0]  half0_frac_sub1_op1;                        
wire    [15:0]  half0_total_qt_rt;                          
wire            pad_yy_icg_scan_en;                         
wire    [25:0]  single0_ex3_frac_add1_op1;                  
wire    [25:0]  single0_ex3_frac_final_rst;                 
wire    [25:0]  single0_ex3_frac_sub1_op1;                  
wire    [25:0]  single0_ex3_frac_sub1_op2;                  
wire    [25:0]  single0_frac_add1_op1;                      
wire    [25:0]  single0_frac_sub1_op1;                      
wire    [27:0]  single0_total_qt_rt;                        


assign fdsu_ex3_result_sign     = double_pipe_ex3_result_sign;
//assign fdsu_ex3_double          = fdsu_yy_double;
assign fdsu_ex3_expnt_rst[12:0] = double_pipe_ex3_expnt_rst[12:0];
assign fdsu_ex3_result_inf      = double_pipe_ex3_result_inf;
assign fdsu_ex3_result_lfn      = double_pipe_ex3_result_lfn;
assign fdsu_ex3_result_qnan      = double_pipe_ex3_result_qnan;
assign fdsu_ex3_result_zero      = double_pipe_ex3_result_zero;
assign fdsu_ex3_rm[2:0]         = fdsu_yy_rm[2:0];
assign fdsu_ex3_rslt_denorm     = double_pipe_ex3_rslt_denorm_in;
assign fdsu_ex3_potnt_uf        = double_pipe_ex3_potnt_uf;
//=======================Round Rule=========================
//1/8 <= x < 1/4, 1/2 <= y < 1, => 1/8 < z < 1/2
//q[57:0] represent the fraction part result of quotient, q[57] for 1/2
//Thus the first "1" in 58 bit quotient will be in q[56] or q[55]
//For Double Float
//29 round to get 58 bit quotient, 52+1 bit as valid result, other for round
//if q[56] is 1, q[56:4] as 1.xxxx valid result, [3:0] for round
//if q[56] is 0, q[55:3] as 1.xxxx valid result, [2:0] for round
//For Single Float
//15 round to get 30 bit quotient, 23+1 bit as valid result, other for round
//if q[56] is 1, q[56:33] as 1.xxxx valid result, [32:28] for round
//if q[56] is 0, q[55:32] as 1.xxxx valid result, [31:28] for round
// &Force("bus","double_total_qt_rt",57,0); @50
// &Force("bus","single0_total_qt_rt",27,0); @51
// &Force("bus","half0_total_qt_rt",15,0); @52
assign ex3_qt_doub_lo3_not0 = |double_total_qt_rt[2:0];
assign ex3_qt_doub_lo2_not0 = |double_total_qt_rt[1:0];
assign ex3_qt_sing_lo4_not0 = |single0_total_qt_rt[1:0];
assign ex3_qt_sing_lo3_not0 = single0_total_qt_rt[0];
assign ex3_qt_half_lo3_not0 = |half0_total_qt_rt[2:0];
assign ex3_qt_half_lo2_not0 = |half0_total_qt_rt[1:0];
assign ex3_qt_bhalf_lo2_not0 = |half0_total_qt_rt[5:4];
assign ex3_qt_bhalf_lo1_not0 = half0_total_qt_rt[4];
//the quotient round bits great than "10000"(ronnd bits 10..0)
assign ex3_doub_gr          = (double_total_qt_rt[56])
                            ?  double_total_qt_rt[3] && ex3_qt_doub_lo3_not0
                            :  double_total_qt_rt[2] && ex3_qt_doub_lo2_not0;
assign ex3_sing_gr          = (single0_total_qt_rt[26])
                            ?  single0_total_qt_rt[2] && ex3_qt_sing_lo4_not0
                            :  single0_total_qt_rt[1] && ex3_qt_sing_lo3_not0;
assign ex3_half_gr          = (half0_total_qt_rt[14])
                            ?  half0_total_qt_rt[3] && ex3_qt_half_lo3_not0
                            :  half0_total_qt_rt[2] && ex3_qt_half_lo2_not0;      
assign ex3_bhalf_gr         = (half0_total_qt_rt[14])
                            ?  half0_total_qt_rt[6] && ex3_qt_bhalf_lo2_not0
                            :  half0_total_qt_rt[5] && ex3_qt_bhalf_lo1_not0;                             
assign ex3_qt_gr            = fdsu_ex3_double && ex3_doub_gr ||
                              fdsu_ex3_single && ex3_sing_gr ||
                              fdsu_ex3_half   && ex3_half_gr ||
                              fdsu_ex3_bhalf  && ex3_bhalf_gr;
//the quotient round bits is equal to "10000"(ronnd bits 10..0)
assign ex3_doub_eq          = (double_total_qt_rt[56])
                            ?  double_total_qt_rt[3] && !ex3_qt_doub_lo3_not0
                            :  double_total_qt_rt[2] && !ex3_qt_doub_lo2_not0;
assign ex3_sing_eq          = (single0_total_qt_rt[26])
                            ?  single0_total_qt_rt[2] && !ex3_qt_sing_lo4_not0
                            :  single0_total_qt_rt[1] && !ex3_qt_sing_lo3_not0;
assign ex3_half_eq          = (half0_total_qt_rt[14])
                            ?  half0_total_qt_rt[3] && !ex3_qt_half_lo3_not0
                            :  half0_total_qt_rt[2] && !ex3_qt_half_lo2_not0;      
assign ex3_bhalf_eq         = (half0_total_qt_rt[14])
                            ?  half0_total_qt_rt[6] && !ex3_qt_bhalf_lo2_not0
                            :  half0_total_qt_rt[5] && !ex3_qt_bhalf_lo1_not0;                             
assign ex3_qt_eq            = fdsu_ex3_double &&  ex3_doub_eq ||
                              fdsu_ex3_single &&  ex3_sing_eq ||
                              fdsu_ex3_half   &&  ex3_half_eq ||
                              fdsu_ex3_bhalf  &&  ex3_bhalf_eq;
//the quotient round bits is zero
assign ex3_doub_zero        = (double_total_qt_rt[56])
                            ?  !double_total_qt_rt[3] && !ex3_qt_doub_lo3_not0
                            :  !double_total_qt_rt[2] && !ex3_qt_doub_lo2_not0;
assign ex3_sing_zero        = (single0_total_qt_rt[26])
                            ?  !single0_total_qt_rt[2] && !ex3_qt_sing_lo4_not0
                            :  !single0_total_qt_rt[1] && !ex3_qt_sing_lo3_not0;
assign ex3_half_zero        = (half0_total_qt_rt[14])
                            ?  !half0_total_qt_rt[3] && !ex3_qt_half_lo3_not0
                            :  !half0_total_qt_rt[2] && !ex3_qt_half_lo2_not0;      
assign ex3_bhalf_zero       =  (half0_total_qt_rt[14])
                            ?  !half0_total_qt_rt[6] && !ex3_qt_bhalf_lo2_not0
                            :  !half0_total_qt_rt[5] && !ex3_qt_bhalf_lo1_not0;

assign ex3_qt_zero          = fdsu_ex3_double &&   ex3_doub_zero ||
                              fdsu_ex3_single &&   ex3_sing_zero ||
                              fdsu_ex3_half   &&   ex3_half_zero ||
                              fdsu_ex3_bhalf  &&   ex3_bhalf_zero;
//quotient is 1.00000..00 need special dealt with in the following
assign ex3_doub_rst_eq_1    = double_total_qt_rt[56] && ~|double_total_qt_rt[55:4];
assign ex3_sing_rst_eq_1    = single0_total_qt_rt[26] && ~|single0_total_qt_rt[25:3];
assign ex3_half_rst_eq_1    = half0_total_qt_rt[14] && ~|half0_total_qt_rt[13:4];
assign ex3_bhalf_rst_eq_1   = half0_total_qt_rt[14] && ~|half0_total_qt_rt[13:7];

assign ex3_rst_eq_1         = fdsu_ex3_double && ex3_doub_rst_eq_1 ||
                              fdsu_ex3_single && ex3_sing_rst_eq_1 ||
                              fdsu_ex3_half   && ex3_half_rst_eq_1 ||
                              fdsu_ex3_bhalf  && ex3_bhalf_rst_eq_1;


// for denormal result, first select the quotation num for rounding
//  specially for the result e=-126 and e=-1022,the denorm depends on the
//  MSB of the quotient
//assign expnt_m126                 = (fdsu_ex3_expnt_rst[12:0] == 13'h1f82);
assign ex3_doub_denorm_plus       = !double_total_qt_rt[56] && fdsu_ex3_potnt_uf;
assign ex3_sing_denorm_plus       = !single0_total_qt_rt[26] && fdsu_ex3_potnt_uf;
assign ex3_half_denorm_plus       = !half0_total_qt_rt[14] && fdsu_ex3_potnt_uf;
assign ex3_bhalf_denorm_plus      = !half0_total_qt_rt[14] && fdsu_ex3_potnt_uf;

assign ex3_denorm_plus            = fdsu_ex3_double &&  ex3_doub_denorm_plus ||
                                    fdsu_ex3_single &&  ex3_sing_denorm_plus ||
                                    fdsu_ex3_half   &&  ex3_half_denorm_plus ||
                                    fdsu_ex3_bhalf  &&  ex3_bhalf_denorm_plus;

assign ex3_doub_denorm_potnt_norm = double_total_qt_rt[56] && (fdsu_ex3_expnt_rst[12:0] == 13'h1c01);
assign expnt_m127                 = (fdsu_ex3_expnt_rst[12:0] == 13'h1f81);
assign ex3_sing_denorm_potnt_norm = single0_total_qt_rt[26] && expnt_m127;
assign ex3_half_denorm_potnt_norm = half0_total_qt_rt[14] && (fdsu_ex3_expnt_rst[12:0] == 13'h1ff1);
assign ex3_bhalf_denorm_potnt_norm = half0_total_qt_rt[14] && expnt_m127;

assign ex3_denorm_potnt_norm      = fdsu_ex3_double && ex3_doub_denorm_potnt_norm  ||
                                    fdsu_ex3_single && ex3_sing_denorm_potnt_norm  ||
                                    fdsu_ex3_half   && ex3_half_denorm_potnt_norm   ||
                                    fdsu_ex3_bhalf  && ex3_bhalf_denorm_potnt_norm ;

assign ex3_rslt_denorm            = ex3_denorm_plus || fdsu_ex3_rslt_denorm;
assign ex3_doub_rslt_denorm       = ex3_doub_denorm_plus || fdsu_ex3_rslt_denorm;
assign ex3_sing_rslt_denorm       = ex3_sing_denorm_plus || fdsu_ex3_rslt_denorm;
assign ex3_half_rslt_denorm       = ex3_half_denorm_plus || fdsu_ex3_rslt_denorm;
assign ex3_bhalf_rslt_denorm      = ex3_bhalf_denorm_plus || fdsu_ex3_rslt_denorm;

assign double_pipe_ex3_rslt_denorm = ex3_rslt_denorm;

// &CombBeg; @158
always @( double_total_qt_rt[56:0]
       or fdsu_ex3_expnt_rst[12:0])
begin
case(fdsu_ex3_expnt_rst[12:0])
  13'h1c02:begin qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[3:0], 53'b0};
                 double_denorm_lst_frac =  double_total_qt_rt[4];
						end//-1022 1
  13'h1c01:begin qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[4:0], 52'b0}; //-1023 0
                 double_denorm_lst_frac =  double_total_qt_rt[5];
						end//-1022 1
  13'h1c00:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[5:0], 51'b0}; //-1024 -1
                 double_denorm_lst_frac =  double_total_qt_rt[6];
						end//-1022 1
  13'h1bff:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[6:0], 50'b0}; //-1025 -2
                 double_denorm_lst_frac =  double_total_qt_rt[7];
						end//-1022 1
  13'h1bfe:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[7:0], 49'b0}; //-1026 -3
                 double_denorm_lst_frac =  double_total_qt_rt[8];
						end//-1022 1
  13'h1bfd:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[8:0], 48'b0}; //-1027 -4
                 double_denorm_lst_frac =  double_total_qt_rt[9];
						end//-1022 1
  13'h1bfc:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[9:0], 47'b0}; //-1028 -5
                 double_denorm_lst_frac =  double_total_qt_rt[10];
						end//-1022 1
  13'h1bfb:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[10:0],46'b0}; //-1029 -6
                 double_denorm_lst_frac =  double_total_qt_rt[11];
						end//-1022 1
  13'h1bfa:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[11:0],45'b0}; //-1030 -7
                 double_denorm_lst_frac =  double_total_qt_rt[12];
						end//-1022 1
  13'h1bf9:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[12:0],44'b0}; //-1031 -8
                 double_denorm_lst_frac =  double_total_qt_rt[13];
						end//-1022 1
  13'h1bf8:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[13:0],43'b0}; //-1032 -9
                 double_denorm_lst_frac =  double_total_qt_rt[14];
						end//-1022 1
  13'h1bf7:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[14:0],42'b0}; //-1033 -10
                 double_denorm_lst_frac =  double_total_qt_rt[15];
						end//-1022 1
  13'h1bf6:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[15:0],41'b0}; //-1034 -11
                 double_denorm_lst_frac =  double_total_qt_rt[16];
						end//-1022 1
  13'h1bf5:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[16:0],40'b0}; //-1035 -12
                 double_denorm_lst_frac =  double_total_qt_rt[17];
						end//-1022 1
  13'h1bf4:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[17:0],39'b0}; //-1036 -13
                 double_denorm_lst_frac =  double_total_qt_rt[18];
						end//-1022 1
  13'h1bf3:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[18:0],38'b0}; // -1037
                 double_denorm_lst_frac =  double_total_qt_rt[19];
						end//-1022 1
  13'h1bf2:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[19:0],37'b0}; //-1038
                 double_denorm_lst_frac =  double_total_qt_rt[20];
						end//-1022 1
  13'h1bf1:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[20:0],36'b0}; //-1039
                 double_denorm_lst_frac =  double_total_qt_rt[21];
						end//-1022 1
  13'h1bf0:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[21:0],35'b0}; //-1040
                 double_denorm_lst_frac =  double_total_qt_rt[22];
						end//-1022 1
  13'h1bef:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[22:0],34'b0}; //-1041
                 double_denorm_lst_frac =  double_total_qt_rt[23];
						end//-1022 1
  13'h1bee:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[23:0],33'b0}; //-1042
                 double_denorm_lst_frac =  double_total_qt_rt[24];
						end//-1022 1
  13'h1bed:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[24:0],32'b0}; //-1043
                 double_denorm_lst_frac =  double_total_qt_rt[25];
						end//-1022 1
  13'h1bec:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[25:0],31'b0}; //-1044
                 double_denorm_lst_frac =  double_total_qt_rt[26];
						end//-1022 1
  13'h1beb:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[26:0],30'b0}; //-1045
                 double_denorm_lst_frac =  double_total_qt_rt[27];
						end//-1022 1
  13'h1bea:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[27:0],29'b0}; //-1046
                 double_denorm_lst_frac =  double_total_qt_rt[28];
						end//-1022 1
  13'h1be9:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[28:0],28'b0}; //-1047
                 double_denorm_lst_frac =  double_total_qt_rt[29];
						end//-1022 1
  13'h1be8:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[29:0],27'b0}; //-1048
                 double_denorm_lst_frac =  double_total_qt_rt[30];
						end//-1022 1
  13'h1be7:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[30:0],26'b0}; //-1049
                 double_denorm_lst_frac =  double_total_qt_rt[31];
						end//-1022 1
  13'h1be6:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[31:0],25'b0}; //-1050
                 double_denorm_lst_frac =  double_total_qt_rt[32];
						end//-1022 1
  13'h1be5:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[32:0],24'b0}; //-1056
                 double_denorm_lst_frac =  double_total_qt_rt[33];
						end//-1022 1
  13'h1be4:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[33:0],23'b0}; //-1052
                 double_denorm_lst_frac =  double_total_qt_rt[34];
						end//-1022 1
  13'h1be3:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[34:0],22'b0}; //-1053
                 double_denorm_lst_frac =  double_total_qt_rt[35];
						end//-1022 1
  13'h1be2:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[35:0],21'b0}; //-1054
                 double_denorm_lst_frac =  double_total_qt_rt[36];
						end//-1022 1
  13'h1be1:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[36:0],20'b0}; //-1055
                 double_denorm_lst_frac =  double_total_qt_rt[37];
						end//-1022 1
  13'h1be0:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[37:0],19'b0}; //-1056
                 double_denorm_lst_frac =  double_total_qt_rt[38];
						end//-1022 1
  13'h1bdf:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[38:0],18'b0}; //-1057
                 double_denorm_lst_frac =  double_total_qt_rt[39];
						end//-1022 1
  13'h1bde:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[39:0],17'b0}; //-1058
                 double_denorm_lst_frac =  double_total_qt_rt[40];
						end//-1022 1
  13'h1bdd:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[40:0],16'b0}; //-1059
                 double_denorm_lst_frac =  double_total_qt_rt[41];
						end//-1022 1
  13'h1bdc:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[41:0],15'b0}; //-1060
                 double_denorm_lst_frac =  double_total_qt_rt[42];
						end//-1022 1
  13'h1bdb:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[42:0],14'b0}; //-1061
                 double_denorm_lst_frac =  double_total_qt_rt[43];
						end//-1022 1
  13'h1bda:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[43:0],13'b0}; //-1062
                 double_denorm_lst_frac =  double_total_qt_rt[44];
						end//-1022 1
  13'h1bd9:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[44:0],12'b0}; //-1063
                 double_denorm_lst_frac =  double_total_qt_rt[45];
						end//-1022 1
  13'h1bd8:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[45:0],11'b0}; //-1064
                 double_denorm_lst_frac =  double_total_qt_rt[46];
						end//-1022 1
  13'h1bd7:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[46:0],10'b0}; //-1065
                 double_denorm_lst_frac =  double_total_qt_rt[47];
						end//-1022 1
  13'h1bd6:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[47:0],9'b0};  //-1066
                 double_denorm_lst_frac =  double_total_qt_rt[48];
						end//-1022 1
  13'h1bd5:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[48:0],8'b0};  //-1067
                 double_denorm_lst_frac =  double_total_qt_rt[49];
						end//-1022 1
  13'h1bd4:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[49:0],7'b0};  //-1068
                 double_denorm_lst_frac =  double_total_qt_rt[50];
						end//-1022 1
  13'h1bd3:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[50:0],6'b0};  //-1069
                 double_denorm_lst_frac =  double_total_qt_rt[51];
						end//-1022 1
  13'h1bd2:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[51:0],5'b0};  //-1070
                 double_denorm_lst_frac =  double_total_qt_rt[52];
						end//-1022 1
  13'h1bd1:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[52:0],4'b0};  //-1071
                 double_denorm_lst_frac =  double_total_qt_rt[53];
						end//-1022 1
  13'h1bd0:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[53:0],3'b0};  //-1072
                 double_denorm_lst_frac =  double_total_qt_rt[54];
						end//-1022 1
  13'h1bcf:begin  qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[54:0],2'b0};  //-1073
                 double_denorm_lst_frac =  double_total_qt_rt[55];
						end//-1022 1
  13'h1bce:begin qt_result_double_denorm_for_round[56:0] = {double_total_qt_rt[55:0],1'b0};
                 double_denorm_lst_frac =  double_total_qt_rt[56];
						end//-1022 1
  default:begin qt_result_double_denorm_for_round[56:0] = double_total_qt_rt[56:0];
                 double_denorm_lst_frac =  1'b0;
						end//-1022 1

endcase
// &CombEnd; @324
end
//denomal result, check for rounding further optimization can be done in
//future
assign ex3_double_denorm_eq      = qt_result_double_denorm_for_round[56]
                                   &&  !ex3_double_low_not_zero;
assign ex3_double_low_not_zero   = |qt_result_double_denorm_for_round[55:0];
assign ex3_double_denorm_gr      = qt_result_double_denorm_for_round[56]
                                   &&  ex3_double_low_not_zero;
assign ex3_double_denorm_zero    = !qt_result_double_denorm_for_round[56]
                                   &&  !ex3_double_low_not_zero;

// &CombBeg; @335
always @( single0_total_qt_rt[26:0]
       or fdsu_ex3_expnt_rst[12:0])
begin
case(fdsu_ex3_expnt_rst[12:0])
  13'h1f82:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[2:0],23'b0}; //-126 1
                 single_denorm_lst_frac =  single0_total_qt_rt[3];
						end//-1022 1
  13'h1f81:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[3:0],22'b0}; //-125 0
                 single_denorm_lst_frac =  single0_total_qt_rt[4];
						end//-1022 1
  13'h1f80:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[4:0],21'b0}; //-128 -1
                 single_denorm_lst_frac =  single0_total_qt_rt[5];
						end//-1022 1
  13'h1f7f:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[5:0],20'b0}; //-129 -2
                 single_denorm_lst_frac =  single0_total_qt_rt[6];
						end//-1022 1
  13'h1f7e:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[6:0],19'b0}; //-130 -3
                 single_denorm_lst_frac =  single0_total_qt_rt[7];
						end//-1022 1
  13'h1f7d:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[7:0],18'b0}; //-131 -4
                 single_denorm_lst_frac =  single0_total_qt_rt[8];
						end//-1022 1
  13'h1f7c:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[8:0],17'b0}; //-132 -5
                 single_denorm_lst_frac =  single0_total_qt_rt[9];
						end//-1022 1
  13'h1f7b:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[9:0],16'b0}; //-133 -6
                 single_denorm_lst_frac =  single0_total_qt_rt[10];
						end//-1022 1
  13'h1f7a:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[10:0],15'b0}; //-134 -7
                 single_denorm_lst_frac =  single0_total_qt_rt[11];
						end//-1022 1
  13'h1f79:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[11:0],14'b0}; //-135 -8
                 single_denorm_lst_frac =  single0_total_qt_rt[12];
						end//-1022 1
  13'h1f78:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[12:0],13'b0}; //-136 -9
                 single_denorm_lst_frac =  single0_total_qt_rt[13];
						end//-1022 1
  13'h1f77:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[13:0],12'b0}; //-137 -10
                 single_denorm_lst_frac =  single0_total_qt_rt[14];
						end//-1022 1
  13'h1f76:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[14:0],11'b0}; //-138 -11
                 single_denorm_lst_frac =  single0_total_qt_rt[15];
						end//-1022 1
  13'h1f75:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[15:0],10'b0}; //-139 -12
                 single_denorm_lst_frac =  single0_total_qt_rt[16];
						end//-1022 1
  13'h1f74:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[16:0],9'b0}; //-140 -13
                 single_denorm_lst_frac =  single0_total_qt_rt[17];
						end//-1022 1
  13'h1f73:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[17:0],8'b0}; // -141
                 single_denorm_lst_frac =  single0_total_qt_rt[18];
						end//-1022 1
  13'h1f72:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[18:0],7'b0};//-142
                 single_denorm_lst_frac =  single0_total_qt_rt[19];
						end//-1022 1
  13'h1f71:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[19:0],6'b0};//-143
                 single_denorm_lst_frac =  single0_total_qt_rt[20];
						end//-1022 1
  13'h1f70:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[20:0],5'b0}; //-144
                 single_denorm_lst_frac =  single0_total_qt_rt[21];
						end//-1022 1
  13'h1f6f:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[21:0],4'b0}; //-145
                 single_denorm_lst_frac =  single0_total_qt_rt[22];
						end//-1022 1
  13'h1f6e:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[22:0],3'b0}; //-146
                 single_denorm_lst_frac =  single0_total_qt_rt[23];
						end//-1022 1
  13'h1f6d:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[23:0],2'b0}; //-147
                 single_denorm_lst_frac =  single0_total_qt_rt[24];
						end//-1022 1
  13'h1f6c:begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[24:0],1'b0}; //-148
                 single_denorm_lst_frac =  single0_total_qt_rt[25];
						end//-1022 1
  13'h1f6b: begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[25:0]};
                 single_denorm_lst_frac = single0_total_qt_rt[26] ;
						end//-1022 1
  default:  begin qt_result_single_denorm_for_round[25:0] = {single0_total_qt_rt[26:1]};
                 single_denorm_lst_frac = 1'b0;
						end//-1022 1
endcase
// &CombEnd; @413
end
//rounding evaluation for single denormalize number
assign ex3_single_denorm_eq      = qt_result_single_denorm_for_round[25]
                                   &&  !ex3_single_low_not_zero;
assign ex3_single_low_not_zero   = |qt_result_single_denorm_for_round[24:0];
assign ex3_single_denorm_gr      = qt_result_single_denorm_for_round[25]
                                   &&  ex3_single_low_not_zero;
assign ex3_single_denorm_zero    = !qt_result_single_denorm_for_round[25]
                                   && !ex3_single_low_not_zero;
// half                                    
// &CombBeg; @423
always @( half0_total_qt_rt[14:0]
       or fdsu_ex3_expnt_rst[12:0])
begin
case(fdsu_ex3_expnt_rst[12:0])
  13'h1ff2:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[3:0],10'b0}; //-126 1
                 half_denorm_lst_frac =  half0_total_qt_rt[4];
						end//-1022 1
  13'h1ff1:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[4:0],9'b0}; //-113 0
                 half_denorm_lst_frac =  half0_total_qt_rt[5];
						end//-1022 1
  13'h1ff0:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[5:0],8'b0}; //-128 -1
                 half_denorm_lst_frac =  half0_total_qt_rt[6];
						end//-1022 1
  13'h1fef:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[6:0],7'b0}; //-129 -2
                 half_denorm_lst_frac =  half0_total_qt_rt[7];
						end//-1022 1
  13'h1fee:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[7:0],6'b0}; //-130 -3
                 half_denorm_lst_frac =  half0_total_qt_rt[8];
						end//-1022 1
  13'h1fed:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[8:0],5'b0}; //-131 -4
                 half_denorm_lst_frac =  half0_total_qt_rt[9];
						end//-1022 1
  13'h1fec:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[9:0],4'b0}; //-132 -5
                 half_denorm_lst_frac =  half0_total_qt_rt[10];
						end//-1022 1
  13'h1feb:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[10:0],3'b0}; //-133 -6
                 half_denorm_lst_frac =  half0_total_qt_rt[11];
						end//-1022 1
  13'h1fea:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[11:0],2'b0}; //-134 -7
                 half_denorm_lst_frac =  half0_total_qt_rt[12];
						end//-1022 1
  13'h1fe9:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[12:0],1'b0}; //-135 -8
                 half_denorm_lst_frac =  half0_total_qt_rt[13];
						end//-1022 1
  13'h1fe8:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[13:0]}; //-136 -9
                 half_denorm_lst_frac =  half0_total_qt_rt[14];
						end//-1022 1
  default:begin qt_result_half_denorm_for_round[13:0] = {half0_total_qt_rt[14:1]}; //-137 -10
                 half_denorm_lst_frac =  1'b0;
						end//-1022 1
endcase
// &CombEnd; @462
end
//rounding evaluation for single denormalize number
assign ex3_half_denorm_eq      = qt_result_half_denorm_for_round[13]
                                   &&  !ex3_half_low_not_zero;
assign ex3_half_low_not_zero   = |qt_result_half_denorm_for_round[12:0];
assign ex3_half_denorm_gr      = qt_result_half_denorm_for_round[13]
                                   &&  ex3_half_low_not_zero;
assign ex3_half_denorm_zero    = !qt_result_half_denorm_for_round[13]
                                   && !ex3_half_low_not_zero;

// &CombBeg; @472
always @( fdsu_ex3_expnt_rst[12:0]
       or half0_total_qt_rt[14:4])
begin
case(fdsu_ex3_expnt_rst[12:0])
  13'h1f82:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[6:4],7'b0}; //-126 1
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[7];
						end//-1022 1
  13'h1f81:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[7:4],6'b0}; //-125 0
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[8];
						end//-1022 1
  13'h1f80:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[8:4],5'b0}; //-128 -1
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[9];
						end//-1022 1
  13'h1f7f:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[9:4],4'b0}; //-129 -2
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[10];
						end//-1022 1
  13'h1f7e:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[10:4],3'b0}; //-130 -3
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[11];
						end//-1022 1
  13'h1f7d:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[11:4],2'b0}; //-131 -4
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[12];
						end//-1022 1
  13'h1f7c:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[12:4],1'b0}; //-132 -5
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[13];
						end//-1022 1
  13'h1f7b:begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[13:4]}; //-133 -6
                 bhalf_denorm_lst_frac =  half0_total_qt_rt[14];
						end//-1022 1
  default: begin qt_result_bhalf_denorm_for_round[9:0] = {half0_total_qt_rt[14:5]}; //-134 -7
                 bhalf_denorm_lst_frac =  1'b0;
						end//-1022 1
  endcase
// &CombEnd; @502
end
//rounding evaluation for single denormalize number
assign ex3_bhalf_denorm_eq      = qt_result_bhalf_denorm_for_round[9]
                                   &&  !ex3_bhalf_low_not_zero;
assign ex3_bhalf_low_not_zero   = |qt_result_bhalf_denorm_for_round[8:0];
assign ex3_bhalf_denorm_gr      = qt_result_bhalf_denorm_for_round[9]
                                   &&  ex3_bhalf_low_not_zero;
assign ex3_bhalf_denorm_zero    = !qt_result_bhalf_denorm_for_round[9]
                                   && !ex3_bhalf_low_not_zero;

//rounding check fo denormalize result
assign ex3_denorm_eq             = fdsu_ex3_double && ex3_double_denorm_eq ||
                                   fdsu_ex3_single && ex3_single_denorm_eq ||
                                   fdsu_ex3_half   && ex3_half_denorm_eq   ||
                                   fdsu_ex3_bhalf  && ex3_bhalf_denorm_eq;
assign ex3_denorm_gr             = fdsu_ex3_double && ex3_double_denorm_gr ||
                                   fdsu_ex3_single && ex3_single_denorm_gr ||
                                   fdsu_ex3_half   && ex3_half_denorm_gr   ||
                                   fdsu_ex3_bhalf  && ex3_bhalf_denorm_gr;
assign ex3_denorm_zero           = fdsu_ex3_double && ex3_double_denorm_zero ||
                                   fdsu_ex3_single && ex3_single_denorm_zero ||
                                   fdsu_ex3_half   && ex3_half_denorm_zero   ||
                                   fdsu_ex3_bhalf  && ex3_bhalf_denorm_zero;
assign ex3_denorm_lst_frac       = fdsu_ex3_double && double_denorm_lst_frac ||
                                   fdsu_ex3_single && single_denorm_lst_frac ||
                                   fdsu_ex3_half   && half_denorm_lst_frac   ||
                                   fdsu_ex3_bhalf  && bhalf_denorm_lst_frac;
//Different Round Mode with different rounding rule
//Here we call rounding bit as "rb", remainder as "rem"
//RNE :
//  1.+1 : rb>10000 || rb==10000 && rem>0
//  2. 0 : Rest Condition
//  3.-1 : Never occur
//RTZ :
//  1.+1 : Never occur
//  2. 0 : Rest Condition
//  3.-1 : rb=10000 && rem<0
//RDN :
//  1.+1 : Q>0 Never occur   ; Q<0 Rest condition
//  2. 0 : Q>0 Rest condition; Q<0 Rem<0 && rb=0
//  3.-1 : Q>0 Rem<0 && rb=0 ; Q<0 Never occur
//RUP :
//  1.+1 : Q>0 Rest Condition; Q<0 Never occur
//  2. 0 : Q>0 Rem<0 && rb=0 ; Q<0 Rest condition
//  3.-1 : Q>0 Never occur   ; Q<0 Rem<0 && rb=0
//RMM :
//  1.+1 : rb>10000 || rb==10000 && rem>0
//  2. 0 : Rest Condition
//  3.-1 : Never occur
assign frac_rne_add_1 = ex3_qt_gr ||
                       (ex3_qt_eq && !fdsu_ex3_rem_sign);
assign frac_rtz_sub_1 = ex3_qt_zero && fdsu_ex3_rem_sign;
assign frac_rup_add_1 = !fdsu_ex3_result_sign &&
                       (!ex3_qt_zero ||
                       (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
assign frac_rup_sub_1 = fdsu_ex3_result_sign &&
                       (ex3_qt_zero && fdsu_ex3_rem_sign);
assign frac_rdn_add_1 = fdsu_ex3_result_sign &&
                       (!ex3_qt_zero ||
                       (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
assign frac_rdn_sub_1 = !fdsu_ex3_result_sign &&
                       (ex3_qt_zero && fdsu_ex3_rem_sign);
assign frac_rmm_add_1 = ex3_qt_gr ||
                       (ex3_qt_eq && !fdsu_ex3_rem_sign);
//denormal result
assign frac_denorm_rne_add_1 = ex3_denorm_gr ||
                               (ex3_denorm_eq &&
                               ((fdsu_ex3_rem_zero &&
                                ex3_denorm_lst_frac) ||
                               (!fdsu_ex3_rem_zero &&
                                !fdsu_ex3_rem_sign)));
assign frac_denorm_rtz_sub_1 = ex3_denorm_zero && fdsu_ex3_rem_sign;
assign frac_denorm_rup_add_1 = !fdsu_ex3_result_sign &&
                               (!ex3_denorm_zero ||
                               (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
assign frac_denorm_rup_sub_1 = fdsu_ex3_result_sign &&
                       (ex3_denorm_zero && fdsu_ex3_rem_sign);
assign frac_denorm_rdn_add_1 = fdsu_ex3_result_sign &&
                       (!ex3_denorm_zero ||
                       (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
assign frac_denorm_rdn_sub_1 = !fdsu_ex3_result_sign &&
                       (ex3_denorm_zero && fdsu_ex3_rem_sign);
assign frac_denorm_rmm_add_1 = ex3_denorm_gr ||
                       (ex3_denorm_eq && !fdsu_ex3_rem_sign);

//RM select
// &CombBeg; @588
always @( frac_rtz_sub_1
       or frac_rdn_add_1
       or fdsu_ex3_id_srt_skip
       or frac_denorm_rtz_sub_1
       or frac_rup_sub_1
       or frac_denorm_rmm_add_1
       or frac_denorm_rne_add_1
       or frac_rmm_add_1
       or fdsu_ex3_rm[2:0]
       or frac_denorm_rdn_add_1
       or frac_rne_add_1
       or frac_denorm_rdn_sub_1
       or fdsu_ex3_result_sign
       or frac_rup_add_1
       or frac_denorm_rup_sub_1
       or frac_rdn_sub_1
       or ex3_rslt_denorm
       or frac_denorm_rup_add_1)
begin
case(fdsu_ex3_rm[2:0])
  3'b000://round to nearst,ties to even
  begin
    frac_add_1          =  ex3_rslt_denorm ? frac_denorm_rne_add_1 : frac_rne_add_1;
    frac_sub_1          =  1'b0;
    frac_orig           =  ex3_rslt_denorm ? !frac_denorm_rne_add_1 : !frac_rne_add_1;
    denorm_to_tiny_frac =  fdsu_ex3_id_srt_skip ? 1'b0 : frac_denorm_rne_add_1;
  end
  3'b001:// round to 0
  begin
    frac_add_1           =  1'b0;
    frac_sub_1           =  ex3_rslt_denorm ? frac_denorm_rtz_sub_1 : frac_rtz_sub_1;
    frac_orig            =  ex3_rslt_denorm ? !frac_denorm_rtz_sub_1 : !frac_rtz_sub_1;
    denorm_to_tiny_frac  = 1'b0;
  end
  3'b010://round to -inf
  begin
    frac_add_1          =  ex3_rslt_denorm ? frac_denorm_rdn_add_1 : frac_rdn_add_1;
    frac_sub_1          =  ex3_rslt_denorm ? frac_denorm_rdn_sub_1 : frac_rdn_sub_1;
    frac_orig           =  ex3_rslt_denorm ? !frac_denorm_rdn_add_1 && !frac_denorm_rdn_sub_1
                                           : !frac_rdn_add_1 && !frac_rdn_sub_1;
    denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? fdsu_ex3_result_sign
                                                : frac_denorm_rdn_add_1;
  end
  3'b011://round to +inf
  begin
    frac_add_1          =  ex3_rslt_denorm ? frac_denorm_rup_add_1 : frac_rup_add_1;
    frac_sub_1          =  ex3_rslt_denorm ? frac_denorm_rup_sub_1 : frac_rup_sub_1;
    frac_orig           =  ex3_rslt_denorm ? !frac_denorm_rup_add_1 && !frac_denorm_rup_sub_1
                                           : !frac_rup_add_1 && !frac_rup_sub_1;
    denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? !fdsu_ex3_result_sign
                                                : frac_denorm_rup_add_1;
  end
  3'b100://round to nearest,ties to max magnitude
  begin
    frac_add_1          = ex3_rslt_denorm ? frac_denorm_rmm_add_1 : frac_rmm_add_1;
    frac_sub_1          = 1'b0;
    frac_orig           = ex3_rslt_denorm ? !frac_denorm_rmm_add_1 : !frac_rmm_add_1;
    denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? 1'b0 : frac_denorm_rmm_add_1;
  end
  default:
  begin
    frac_add_1          = 1'b0;
    frac_sub_1          = 1'b0;
    frac_orig           = 1'b0;
    denorm_to_tiny_frac = 1'b0;
  end
endcase
// &CombEnd; @637
end
// &Force("bus","double_pipe_total_qt_rt",57,0); @638
assign double_frac_add1_op1[54:0]  = double_pipe_total_qt_rt[56] ? 55'b10 : 55'b1;
assign double_frac_sub1_op1[54:0]  = double_pipe_total_qt_rt[56] ? {{54{1'b1}},1'b0} : {55{1'b1}};
assign single0_frac_add1_op1[25:0] = double_pipe_total_qt_rt[56] ? 26'b10 : 26'b1;
assign single0_frac_sub1_op1[25:0] = double_pipe_total_qt_rt[56] ? {{25{1'b1}},1'b0} : {26{1'b1}};
assign half0_frac_add1_op1[12:0]   = double_pipe_total_qt_rt[56] ? 13'b10 : 13'b1;
assign half0_frac_sub1_op1[12:0]   = double_pipe_total_qt_rt[56] ? {{12{1'b1}},1'b0} : {13{1'b1}};
assign bhalf0_frac_add1_op1[9:0]   = double_pipe_total_qt_rt[56] ? 10'b10 : 10'b1;
assign bhalf0_frac_sub1_op1[9:0]   = double_pipe_total_qt_rt[56] ? {{9{1'b1}},1'b0} : {10{1'b1}};

assign double_ex3_frac_add1_op1[54:0]  = ex3_doub_rslt_denorm ? 
                                         {1'b0,double_pipe_ex3_result_denorm_round_add_num[52:0],1'b0} :
                                         double_frac_add1_op1[54:0];
assign double_ex3_frac_sub1_op1[54:0]  = ex3_doub_rslt_denorm ? 
                                         ~{1'b0,double_pipe_ex3_result_denorm_round_add_num[52:0],1'b0} :
                                         double_frac_sub1_op1[54:0];
assign single0_ex3_frac_add1_op1[25:0] = ex3_sing_rslt_denorm ? 
                                         {1'b0,double_pipe_ex3_result_denorm_round_add_num[52:29],1'b0} :
                                         single0_frac_add1_op1[25:0];
assign single0_ex3_frac_sub1_op1[25:0] = ex3_sing_rslt_denorm ? 
                                         ~{1'b0,double_pipe_ex3_result_denorm_round_add_num[52:29],1'b0} :
                                         single0_frac_sub1_op1[25:0];
assign half0_ex3_frac_add1_op1[12:0]   = ex3_half_rslt_denorm ? 
                                         {1'b0,double_pipe_ex3_result_denorm_round_add_num[52:42],1'b0} :
                                         half0_frac_add1_op1[12:0];
assign half0_ex3_frac_sub1_op1[12:0]   = ex3_half_rslt_denorm ? 
                                         ~{1'b0,double_pipe_ex3_result_denorm_round_add_num[52:42],1'b0} :
                                         half0_frac_sub1_op1[12:0];
assign bhalf0_ex3_frac_add1_op1[9:0]   = ex3_bhalf_rslt_denorm ? 
                                         {1'b0,double_pipe_ex3_result_denorm_round_add_num[52:45],1'b0} :
                                         bhalf0_frac_add1_op1[9:0];

assign bhalf0_ex3_frac_sub1_op1[9:0]   = ex3_bhalf_rslt_denorm ? 
                                         ~{1'b0,double_pipe_ex3_result_denorm_round_add_num[52:45],1'b0} :
                                         bhalf0_frac_sub1_op1[9:0];

assign double_ex3_frac_sub1_op2[54:0]  = {54'b0, ex3_doub_rslt_denorm};
assign single0_ex3_frac_sub1_op2[25:0] = {25'b0, ex3_sing_rslt_denorm};
assign half0_ex3_frac_sub1_op2[12:0]   = {12'b0, ex3_half_rslt_denorm};
assign bhalf0_ex3_frac_sub1_op2[9:0]   = {9'b0,  ex3_bhalf_rslt_denorm};






////Add 1 or Sub 1 constant
//&CombBeg;
//case({total_qt_rt_58[56],fdsu_ex3_double})
//  2'b00:
//  begin
//    frac_add1_op1[54:0] = {2'b0,24'b1,29'b0};
//    frac_sub1_op1[54:0] = {2'b11,{24{1'b1}},29'b0};
//  end
//  2'b01:
//  begin
//    frac_add1_op1[54:0] = 55'b1;
//    frac_sub1_op1[54:0] = {55{1'b1}};
//  end
//  2'b10:
//  begin
//    frac_add1_op1[54:0] = {25'b1,30'b0};
//    frac_sub1_op1[54:0] = {{25{1'b1}},30'b0};
//  end
//  2'b11:
//  begin
//    frac_add1_op1[54:0] = 55'b10;
//    frac_sub1_op1[54:0] = {{54{1'b1}},1'b0};
//  end
//  default:
//  begin
//    frac_add1_op1[54:0] = 55'b0;
//    frac_sub1_op1[54:0] = 55'b0;
//  end
//endcase
//&CombEnd;

//Add 1 or Sub1 final result
//Conner case when quotient is 0.010000...00 and remainder is negative,
//The real quotient is actually 0.00fff..ff,
//The final result will need to sub 1 when
//RN : Never occur
//RP : sign of quotient is -
//RM : sign of quotient is +
//assign frac_add1_rst[54:0]             = {1'b0,total_qt_rt_58[56:3]} +
//                                         frac_add1_op1_with_denorm[54:0];
//assign frac_add1_op1_with_denorm[54:0] = ex3_rslt_denorm ?
//                                  {1'b0,fdsu_ex3_result_denorm_round_add_num[52:0],1'b0} :
//                                  frac_add1_op1[54:0];
//assign frac_sub1_rst[54:0]             = (ex3_rst_eq_1)
//                                       ? {2'b0,{53{1'b1}}}
//                                       : {1'b0,total_qt_rt_58[56:3]} +
//                                         frac_sub1_op1_with_denorm[54:0] + {54'b0, ex3_rslt_denorm};
//assign frac_sub1_op1_with_denorm[54:0] = ex3_rslt_denorm ?
//                                ~{1'b0,fdsu_ex3_result_denorm_round_add_num[52:0],1'b0} :
//                                frac_sub1_op1[54:0];
assign frac_sub1_rst[54:0]            = (ex3_rst_eq_1)
                                       ? {2'b0,{53{1'b1}}} : double_pipe_frac_sub1_rst[54:0];
assign frac_final_rst[54:0]           = (double_pipe_frac_add1_rst[54:0]         & {55{frac_add_1}}) |
                                        (frac_sub1_rst[54:0]         & {55{frac_sub_1}}) |
                                        ({1'b0,double_pipe_total_qt_rt[56:3]} & {55{frac_orig}});
assign double_ex3_frac_final_rst[54:0]    = frac_final_rst[54:0];
assign single0_ex3_frac_final_rst[25:0]   = frac_final_rst[54:29];
assign half0_ex3_frac_final_rst[12:0]     = frac_final_rst[54:42];
assign bhalf0_ex3_frac_final_rst[9:0]     = frac_final_rst[54:45];

//===============Pipe down signal prepare===================
assign ex3_rst_nor = !fdsu_ex3_result_zero &&
                      !fdsu_ex3_result_qnan &&
                      !fdsu_ex3_result_inf  &&
                      !fdsu_ex3_result_lfn;
//assign ex3_rst_nor = !fdsu_ex3_result_inf  &&
//                     !fdsu_ex3_result_lfn;
assign ex3_nx      = ex3_rst_nor &&
                    (!ex3_qt_zero || !fdsu_ex3_rem_zero || ex3_denorm_nx);
assign ex3_denorm_nx = ex3_rslt_denorm && (!ex3_denorm_zero ||  !fdsu_ex3_rem_zero);
//Adjust expnt
//Div:Actural expnt should plus 1 when op0 is id, sub 1 when op1 id
assign ex3_expnt_adjst[12:0] = {13{fdsu_ex3_double}} & 13'h3ff |
                               {13{fdsu_ex3_single}} & 13'h7f  |
                               {13{fdsu_ex3_half}}   & 13'hf  |
                               {13{fdsu_ex3_bhalf}}  & 13'h7f;

assign double_pipe_ex3_expnt_adjust_result[12:0] = fdsu_ex3_expnt_rst[12:0] +
                                       ex3_expnt_adjst[12:0];
//this information is for the packing, which determin the result is normal
//numer or not;
assign ex3_potnt_norm[1:0]    = {ex3_denorm_plus,ex3_denorm_potnt_norm};
//=======================Pipe to EX4========================
//gate clk
// &Instance("gated_clk_cell","x_ex3_pipe_clk"); @768
gated_clk_cell  x_ex3_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @769
//           .clk_out        (ex3_pipe_clk),//Out Clock @770
//           .external_en    (1'b0), @771
//           .global_en      (cp0_yy_clk_en), @772
//           .local_en       (ex3_pipe_clk_en),//Local Condition @773
//           .module_en      (cp0_vpu_icg_en) @774
//         ); @775
assign ex3_pipe_clk_en = ex3_pipedown;

always @(posedge ex3_pipe_clk)
begin
  if(ex3_pipedown)
  begin
    double_pipe_ex4_result_nor      <= ex3_rst_nor;
    double_pipe_ex4_nx              <= ex3_nx;
    double_pipe_ex4_denorm_to_tiny_frac
                                    <= denorm_to_tiny_frac;
    double_pipe_ex4_potnt_norm[1:0] <= ex3_potnt_norm[1:0];
  end
  else
  begin
    double_pipe_ex4_result_nor      <= double_pipe_ex4_result_nor;
    double_pipe_ex4_nx              <= double_pipe_ex4_nx;
    double_pipe_ex4_denorm_to_tiny_frac
                                    <= double_pipe_ex4_denorm_to_tiny_frac;
    double_pipe_ex4_potnt_norm[1:0] <= double_pipe_ex4_potnt_norm[1:0];
  end
end

// ex3_frac Pipedown to ex4 use srt_divisor.
//assign ex3_frac_final_rst[54:0] = frac_final_rst[54:0];
// &Force("output","double_pipe_ex4_result_nor"); @800
// &Force("output","double_pipe_ex4_nx"); @801
// &Force("output","double_pipe_ex4_denorm_to_tiny_frac"); @802
// &Force("output","double_pipe_ex4_potnt_norm"); @803


// &ModuleEnd; @806
endmodule



