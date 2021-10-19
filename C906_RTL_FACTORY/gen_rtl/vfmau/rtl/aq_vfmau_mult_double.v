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
module aq_vfmau_mult_double(
  cp0_vpu_xx_dqnan,
  ctrl_dp_ex1_inst_pipe_down,
  ctrl_dp_ex2_inst_pipe_down,
  ctrl_dp_ex3_inst_pipe_down,
  ctrl_dp_ex4_inst_pipe_down,
  ex1_bf16,
  ex1_double,
  ex1_double_expnt_near_of,
  ex1_double_expnt_near_uf,
  ex1_dst_bf16,
  ex1_dst_double,
  ex1_dst_f16,
  ex1_dst_half,
  ex1_dst_single,
  ex1_f16,
  ex1_half,
  ex1_id_reg,
  ex1_mac,
  ex1_neg,
  ex1_rm,
  ex1_single,
  ex1_srcv0,
  ex1_srcv1,
  ex1_srcv2,
  ex1_sub,
  ex1_widen,
  ex2_bf16,
  ex2_double,
  ex2_dst_bf16,
  ex2_dst_double,
  ex2_dst_f16,
  ex2_dst_half,
  ex2_dst_single,
  ex2_mac,
  ex2_mult_data,
  ex2_single,
  ex2_special_sel,
  ex3_bf16,
  ex3_dst_bf16,
  ex3_dst_double,
  ex3_dst_f16,
  ex3_dst_single,
  ex3_f16,
  ex3_rm,
  ex3_simd,
  ex3_single,
  ex3_special_cmplt,
  ex4_bf16,
  ex4_dst_bf16,
  ex4_dst_double,
  ex4_dst_f16,
  ex4_dst_half,
  ex4_dst_single,
  ex4_f16,
  ex4_rm,
  ex4_single,
  fmau_ex2_data_clk,
  fmau_ex3_data_clk,
  fmau_ex4_data_clk,
  fmau_ex5_data_clk,
  ifu_vpu_warm_up,
  vfmau_vpu_ex3_fflags,
  vfmau_vpu_ex3_fpr_result,
  vfmau_vpu_ex4_fflags,
  vfmau_vpu_ex4_fpr_result,
  vfmau_vpu_ex5_fflags,
  vfmau_vpu_ex5_fpr_result,
  vpu_group_0_xx_ex1_srcv0_type,
  vpu_group_0_xx_ex1_srcv1_type,
  vpu_group_0_xx_ex1_srcv2_type
);

// &Ports; @28
input            cp0_vpu_xx_dqnan;                
input            ctrl_dp_ex1_inst_pipe_down;      
input            ctrl_dp_ex2_inst_pipe_down;      
input            ctrl_dp_ex3_inst_pipe_down;      
input            ctrl_dp_ex4_inst_pipe_down;      
input            ex1_bf16;                        
input            ex1_double;                      
input            ex1_dst_bf16;                    
input            ex1_dst_double;                  
input            ex1_dst_f16;                     
input            ex1_dst_half;                    
input            ex1_dst_single;                  
input            ex1_f16;                         
input            ex1_half;                        
input   [1  :0]  ex1_id_reg;                      
input            ex1_mac;                         
input            ex1_neg;                         
input   [2  :0]  ex1_rm;                          
input            ex1_single;                      
input   [63 :0]  ex1_srcv0;                       
input   [63 :0]  ex1_srcv1;                       
input   [63 :0]  ex1_srcv2;                       
input            ex1_sub;                         
input            ex1_widen;                       
input            ex2_bf16;                        
input            ex2_double;                      
input            ex2_dst_bf16;                    
input            ex2_dst_double;                  
input            ex2_dst_f16;                     
input            ex2_dst_half;                    
input            ex2_dst_single;                  
input            ex2_mac;                         
input   [105:0]  ex2_mult_data;                   
input            ex2_single;                      
input            ex3_bf16;                        
input            ex3_dst_bf16;                    
input            ex3_dst_double;                  
input            ex3_dst_f16;                     
input            ex3_dst_single;                  
input            ex3_f16;                         
input   [2  :0]  ex3_rm;                          
input            ex3_simd;                        
input            ex3_single;                      
input            ex4_bf16;                        
input            ex4_dst_bf16;                    
input            ex4_dst_double;                  
input            ex4_dst_f16;                     
input            ex4_dst_half;                    
input            ex4_dst_single;                  
input            ex4_f16;                         
input   [2  :0]  ex4_rm;                          
input            ex4_single;                      
input            fmau_ex2_data_clk;               
input            fmau_ex3_data_clk;               
input            fmau_ex4_data_clk;               
input            fmau_ex5_data_clk;               
input            ifu_vpu_warm_up;                 
input   [47 :0]  vpu_group_0_xx_ex1_srcv0_type;   
input   [47 :0]  vpu_group_0_xx_ex1_srcv1_type;   
input   [47 :0]  vpu_group_0_xx_ex1_srcv2_type;   
output           ex1_double_expnt_near_of;        
output           ex1_double_expnt_near_uf;        
output  [5  :0]  ex2_special_sel;                 
output           ex3_special_cmplt;               
output  [4  :0]  vfmau_vpu_ex3_fflags;            
output  [63 :0]  vfmau_vpu_ex3_fpr_result;        
output  [4  :0]  vfmau_vpu_ex4_fflags;            
output  [63 :0]  vfmau_vpu_ex4_fpr_result;        
output  [4  :0]  vfmau_vpu_ex5_fflags;            
output  [63 :0]  vfmau_vpu_ex5_fpr_result;        

// &Regs; @29
reg     [12 :0]  ex2_expnt_2;                     
reg     [51 :0]  ex2_frac_2;                      
reg     [12 :0]  ex2_left_max;                    
reg     [12 :0]  ex2_mac_expnt_diff;              
reg     [12 :0]  ex2_mult_expnt;                  
reg              ex2_mult_sign;                   
reg              ex2_right_sel;                   
reg     [6  :0]  ex2_shift_index;                 
reg              ex2_src2_expnt_not_zero;         
reg              ex2_src2_sign;                   
reg     [110:0]  ex3_adder_0;                     
reg     [110:0]  ex3_adder_1;                     
reg     [110:0]  ex3_adder_result;                
reg     [12 :0]  ex3_mac_expnt;                   
reg     [1  :0]  ex3_mult_double_gs_bit;          
reg     [12 :0]  ex3_mult_expnt;                  
reg     [51 :0]  ex3_mult_frac_result;            
reg     [1  :0]  ex3_mult_half_gs_bit;            
reg              ex3_mult_rnd_in;                 
reg              ex3_mult_sign;                   
reg     [1  :0]  ex3_mult_single_gs_bit;          
reg     [15 :0]  ex3_shift_limit_low;             
reg              ex3_sub_vld;                     
reg     [12 :0]  ex4_mac_expnt;                   
reg              ex4_mac_expnt_neg_max;           
reg     [10 :0]  ex4_mac_expnt_result;            
reg              ex4_mac_frac_not_zero;           
reg     [110:0]  ex4_mac_frac_pre;                
reg     [51 :0]  ex4_mac_frac_result;             
reg              ex4_mac_rnd_in;                  
reg     [1  :0]  ex4_mac_shift_high;              
reg              ex4_mac_sign;                    
reg              ex5_mac_double_nx;               
reg              ex5_mac_double_of;               
reg     [63 :0]  ex5_mac_double_result;           
reg              ex5_mac_double_uf;               

// &Wires; @30
wire             cp0_vpu_xx_dqnan;                
wire             ctrl_dp_ex1_inst_pipe_down;      
wire             ctrl_dp_ex2_inst_pipe_down;      
wire             ctrl_dp_ex3_inst_pipe_down;      
wire             ctrl_dp_ex4_inst_pipe_down;      
wire             ex1_bf16;                        
wire             ex1_double;                      
wire             ex1_double_expnt_near_of;        
wire             ex1_double_expnt_near_uf;        
wire             ex1_dst_bf16;                    
wire             ex1_dst_double;                  
wire             ex1_dst_f16;                     
wire             ex1_dst_half;                    
wire             ex1_dst_single;                  
wire    [12 :0]  ex1_expnt_0;                     
wire    [12 :0]  ex1_expnt_1;                     
wire    [12 :0]  ex1_expnt_2;                     
wire    [12 :0]  ex1_expnt_2_pre;                 
wire    [12 :0]  ex1_expnt_bias;                  
wire             ex1_f16;                         
wire    [51 :0]  ex1_frac_2;                      
wire             ex1_half;                        
wire    [1  :0]  ex1_id_reg;                      
wire    [12 :0]  ex1_left_bias;                   
wire    [12 :0]  ex1_left_max;                    
wire             ex1_mac;                         
wire    [12 :0]  ex1_mac_expnt_diff;              
wire    [12 :0]  ex1_mult_expnt;                  
wire             ex1_mult_sign;                   
wire             ex1_neg;                         
wire    [12 :0]  ex1_right_max;                   
wire             ex1_right_sel;                   
wire    [2  :0]  ex1_rm;                          
wire             ex1_single;                      
wire             ex1_src2_expnt_not_zero;         
wire             ex1_src2_sign;                   
wire    [63 :0]  ex1_srcv0;                       
wire    [63 :0]  ex1_srcv1;                       
wire    [63 :0]  ex1_srcv2;                       
wire             ex1_sub;                         
wire             ex1_widen;                       
wire    [110:0]  ex2_adder_0;                     
wire    [110:0]  ex2_adder_0_0;                   
wire    [110:0]  ex2_adder_0_1;                   
wire             ex2_adder_0_sel_h;               
wire    [110:0]  ex2_adder_1;                     
wire             ex2_adder_1_for_bf16_rnd_add_1;  
wire             ex2_adder_1_for_bf16_rnd_add_2;  
wire             ex2_adder_1_for_double_rnd_add_1; 
wire             ex2_adder_1_for_double_rnd_add_2; 
wire             ex2_adder_1_for_f16_rnd_add_1;   
wire             ex2_adder_1_for_f16_rnd_add_2;   
wire             ex2_adder_1_for_single_rnd_add_1; 
wire             ex2_adder_1_for_single_rnd_add_2; 
wire    [110:0]  ex2_adder_1_rnd_data;            
wire             ex2_bf16;                        
wire    [52 :0]  ex2_data_for_shift;              
wire             ex2_double;                      
wire             ex2_dst_bf16;                    
wire             ex2_dst_double;                  
wire             ex2_dst_f16;                     
wire             ex2_dst_half;                    
wire             ex2_dst_single;                  
wire             ex2_mac;                         
wire    [12 :0]  ex2_mac_expnt;                   
wire    [105:0]  ex2_mult_data;                   
wire    [1  :0]  ex2_mult_double_gs_bit;          
wire    [1  :0]  ex2_mult_half_gs_bit;            
wire    [1  :0]  ex2_mult_single_gs_bit;          
wire    [12 :0]  ex2_right_max;                   
wire    [110:0]  ex2_shift_data;                  
wire    [110:0]  ex2_shift_data_out;              
wire    [15 :0]  ex2_shift_limit_low;             
wire             ex2_shift_limit_vld;             
wire    [2  :0]  ex2_shift_sel;                   
wire             ex2_single;                      
wire    [5  :0]  ex2_special_sel;                 
wire             ex2_sub_vld;                     
wire    [110:0]  ex3_adder_0_result;              
wire    [110:0]  ex3_adder_1_result;              
wire    [2  :0]  ex3_adder_result_sel;            
wire             ex3_bf16;                        
wire             ex3_dst_bf16;                    
wire             ex3_dst_double;                  
wire             ex3_dst_f16;                     
wire             ex3_dst_single;                  
wire             ex3_f16;                         
wire    [15 :0]  ex3_fmau_result_15_0;            
wire    [15 :0]  ex3_fmau_result_31_16;           
wire    [15 :0]  ex3_fmau_result_47_32;           
wire    [15 :0]  ex3_fmau_result_63_48;           
wire    [6  :0]  ex3_lza_result;                  
wire    [12 :0]  ex3_mac_expnt_adjust;            
wire             ex3_mac_expnt_neg_max;           
wire             ex3_mac_frac_not_zero;           
wire    [110:0]  ex3_mac_result_shift;            
wire             ex3_mac_sign;                    
wire    [15 :0]  ex3_mult_bf16_result;            
wire    [2  :0]  ex3_mult_bf16_rnd_bit;           
wire    [63 :0]  ex3_mult_double_result;          
wire    [2  :0]  ex3_mult_double_rnd_bit;         
wire             ex3_mult_expnt_add_in;           
wire    [12 :0]  ex3_mult_expnt_p1;               
wire    [10 :0]  ex3_mult_expnt_result;           
wire    [1  :0]  ex3_mult_frac_sel;               
wire    [15 :0]  ex3_mult_half_result;            
wire    [2  :0]  ex3_mult_half_rnd_bit;           
wire    [51 :0]  ex3_mult_no_rnd_result;          
wire             ex3_mult_nx;                     
wire    [53 :0]  ex3_mult_result;                 
wire    [2  :0]  ex3_mult_rnd_bit;                
wire    [53 :0]  ex3_mult_rnd_result;             
wire    [31 :0]  ex3_mult_single_result;          
wire    [2  :0]  ex3_mult_single_rnd_bit;         
wire    [2  :0]  ex3_rm;                          
wire    [110:0]  ex3_shift_limit;                 
wire    [127:0]  ex3_shift_limit_one_hot;         
wire             ex3_simd;                        
wire             ex3_single;                      
wire             ex3_special_cmplt;               
wire             ex3_special_data_vld;            
wire    [1  :0]  ex3_special_fflags;              
wire    [63 :0]  ex3_special_result;              
wire             ex4_bf16;                        
wire    [2  :0]  ex4_bf16_rnd_bit;                
wire             ex4_double_early_of;             
wire    [2  :0]  ex4_double_rnd_bit;              
wire             ex4_dst_bf16;                    
wire             ex4_dst_double;                  
wire             ex4_dst_f16;                     
wire             ex4_dst_half;                    
wire             ex4_dst_single;                  
wire             ex4_early_of;                    
wire             ex4_expnt_11bit;                 
wire             ex4_expnt_11bit_p1_of;           
wire             ex4_expnt_5bit;                  
wire             ex4_expnt_5bit_p1_of;            
wire             ex4_expnt_8bit;                  
wire             ex4_expnt_8bit_p1_of;            
wire             ex4_expnt_rnd_in;                
wire             ex4_f16;                         
wire    [2  :0]  ex4_f16_rnd_bit;                 
wire    [63 :0]  ex4_fmau_double_result;          
wire    [15 :0]  ex4_fmau_half_result;            
wire    [15 :0]  ex4_fmau_result_15_0;            
wire    [15 :0]  ex4_fmau_result_31_16;           
wire    [15 :0]  ex4_fmau_result_47_32;           
wire    [15 :0]  ex4_fmau_result_63_48;           
wire    [31 :0]  ex4_fmau_single_result;          
wire             ex4_half_of;                     
wire             ex4_late_of;                     
wire    [53 :0]  ex4_mac_data_for_rnd;            
wire    [52 :0]  ex4_mac_data_no_rnd;             
wire    [110:0]  ex4_mac_data_shift_64;           
wire             ex4_mac_expnt_p1;                
wire    [2  :0]  ex4_mac_expnt_sel;               
wire    [110:0]  ex4_mac_frac;                    
wire    [1  :0]  ex4_mac_frac_sel;                
wire             ex4_mac_nx;                      
wire             ex4_mac_of;                      
wire    [53 :0]  ex4_mac_rnd_result;              
wire             ex4_mac_sign_result;             
wire             ex4_mac_uf;                      
wire             ex4_mult_double_nx;              
wire    [63 :0]  ex4_mult_double_result;          
wire             ex4_of_frac_bit;                 
wire             ex4_p1_of;                       
wire    [2  :0]  ex4_rm;                          
wire    [2  :0]  ex4_rnd_bit;                     
wire             ex4_single;                      
wire             ex4_single_of;                   
wire    [2  :0]  ex4_single_rnd_bit;              
wire             fmau_ex2_data_clk;               
wire             fmau_ex3_data_clk;               
wire             fmau_ex4_data_clk;               
wire             fmau_ex5_data_clk;               
wire             ifu_vpu_warm_up;                 
wire    [4  :0]  vfmau_vpu_ex3_fflags;            
wire    [63 :0]  vfmau_vpu_ex3_fpr_result;        
wire    [4  :0]  vfmau_vpu_ex4_fflags;            
wire    [63 :0]  vfmau_vpu_ex4_fpr_result;        
wire    [4  :0]  vfmau_vpu_ex5_fflags;            
wire    [63 :0]  vfmau_vpu_ex5_fpr_result;        
wire    [47 :0]  vpu_group_0_xx_ex1_srcv0_type;   
wire    [47 :0]  vpu_group_0_xx_ex1_srcv1_type;   
wire    [47 :0]  vpu_group_0_xx_ex1_srcv2_type;   


// &Depend("cpu_cfig.h"); @32

parameter DOUBLE_WIDTH= 64;
parameter DOUBLE_FRAC = 52;
parameter DOUBLE_EXPN = 11;
parameter ADD_D_WIDTH = 111;

parameter FUNC_WIDTH  = 10;

parameter SINGLE_WIDTH= 32;
parameter SINGLE_FRAC = 23;
parameter SINGLE_EXPN =  8;
parameter ADD_S_WIDTH = 53;

parameter F16_WIDTH   = 16;
parameter F16_FRAC    = 10;
parameter F16_EXPN    =  5;

parameter BF16_WIDTH  = 16;
parameter BF16_FRAC   =  7;
parameter BF16_EXPN   =  8;

// &Force("bus","ex1_id_reg",7,0); @55
// &Force("bus","vmulu_vfmau_simd_half0_mult_data",31,0); @56
// &Force("bus","vmulu_vfmau_simd_half2_mult_data",31,0); @57
// &Instance("aq_vfmau_special_judge_double","x_aq_vfmau_special_judge_double"); @161
// &CombBeg; @193
// &CombEnd; @200
// &Instance("aq_vfmau_frac_shift_double","x_aq_vfmau_frac_shift_double"); @208
// &CombBeg; @231
// &CombEnd; @237
// &Force("output","ex3_adder_1_double_sign");                                 @343
// &CombBeg; @349
// &CombEnd; @356
// &Instance("aq_vfmau_lza_double","x_aq_vfmau_lza_double"); @371
// &CombBeg; @403
// &CombEnd; @412
// &CombBeg; @415
// &CombEnd; @424
// &CombBeg; @442
// &CombEnd; @448
// &CombBeg; @450
// &CombEnd; @456
// &CombBeg; @502
// &CombEnd; @508
// &CombBeg; @512
// &CombEnd; @518
// &CombBeg; @522
// &CombEnd; @528
// &CombBeg; @532
// &CombEnd; @539
// &CombBeg; @544
// &CombEnd; @551
// &Force("output","ex3_single_lza_result"); @574
// &CombBeg; @636
// &CombEnd; @642
// &CombBeg; @672
// &CombEnd;  @681
// &CombBeg; @686
// &CombEnd; @692
// &CombBeg; @712
// &CombEnd; @719
// &CombBeg; @742
// &CombEnd; @748
// &CombBeg; @753
// &CombEnd; @759
// &CombBeg; @764
// &CombEnd; @770
// &CombBeg; @775
// &CombEnd; @781
// &CombBeg; @785
// &CombEnd; @791
// &CombBeg; @832
// &CombEnd;  @841
// &CombBeg; @845
// &CombEnd; @851
// &CombBeg; @869
// &CombEnd; @876
//==================================================================
//                     EX1 data prepare
//==================================================================
assign ex1_expnt_0[DOUBLE_EXPN+1:0]     = {(DOUBLE_EXPN+2){ex1_double}} & { 2'b00,       ex1_srcv0[DOUBLE_FRAC+DOUBLE_EXPN-1:DOUBLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_single}} & { 2'b00,3'b000,ex1_srcv0[SINGLE_FRAC+SINGLE_EXPN-1:SINGLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_f16   }} & { 2'b00,6'b000000,ex1_srcv0[F16_FRAC+F16_EXPN-1:F16_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_bf16  }} & { 2'b00,3'b000,ex1_srcv0[BF16_FRAC+BF16_EXPN-1:BF16_FRAC]};

assign ex1_expnt_1[DOUBLE_EXPN+1:0]     = {(DOUBLE_EXPN+2){ex1_double}} & { 2'b00,       ex1_srcv1[DOUBLE_FRAC+DOUBLE_EXPN-1:DOUBLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_single}} & { 2'b00,3'b000,ex1_srcv1[SINGLE_FRAC+SINGLE_EXPN-1:SINGLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_f16   }} & { 2'b00,6'b000000,ex1_srcv1[F16_FRAC+F16_EXPN-1:F16_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_bf16  }} & { 2'b00,3'b000,ex1_srcv1[BF16_FRAC+BF16_EXPN-1:BF16_FRAC]}; 

//srcv2                                         
assign ex1_expnt_2_pre[DOUBLE_EXPN+1:0] = {(DOUBLE_EXPN+2){ex1_double    }} & { 2'b00,       ex1_srcv2[DOUBLE_FRAC+DOUBLE_EXPN-1:DOUBLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_dst_single}} & { 2'b00,3'b000,ex1_srcv2[SINGLE_FRAC+SINGLE_EXPN-1:SINGLE_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_dst_f16   }} & { 2'b00,6'b000000,ex1_srcv2[F16_FRAC+F16_EXPN-1:F16_FRAC]}
                                        | {(DOUBLE_EXPN+2){ex1_dst_bf16  }} & { 2'b00,3'b000,ex1_srcv2[BF16_FRAC+BF16_EXPN-1:BF16_FRAC]};      
                                    
assign ex1_expnt_2[DOUBLE_EXPN+1:0]     = ex1_src2_expnt_not_zero ? ex1_expnt_2_pre[DOUBLE_EXPN+1:0] : 13'b0_0000_0000_0001;
assign ex1_src2_expnt_not_zero          = (|ex1_srcv2[14:7])  && ex1_dst_bf16
                                       || (|ex1_srcv2[14:10]) && ex1_dst_f16
                                       || (|ex1_srcv2[30:23]) && ex1_dst_single
                                       || (|ex1_srcv2[62:52]) && ex1_double;

assign ex1_frac_2[DOUBLE_FRAC-1:0]      = {DOUBLE_FRAC{ex1_double    }} & { ex1_srcv2[DOUBLE_FRAC-1:0]}
                                        | {DOUBLE_FRAC{ex1_dst_single}} & { ex1_srcv2[SINGLE_FRAC-1:0],29'b0}
                                        | {DOUBLE_FRAC{ex1_dst_f16   }} & { ex1_srcv2[F16_FRAC-1:0],42'b0}
                                        | {DOUBLE_FRAC{ex1_dst_bf16  }} & { ex1_srcv2[BF16_FRAC-1:0],45'b0}; 

assign ex1_src2_sign                    = (ex1_srcv2[DOUBLE_WIDTH-1]^ex1_neg^ex1_sub) && ex1_double
                                       || (ex1_srcv2[SINGLE_WIDTH-1]^ex1_neg^ex1_sub) && ex1_dst_single
                                       || (ex1_srcv2[F16_WIDTH-1]   ^ex1_neg^ex1_sub) && ex1_dst_f16
                                       || (ex1_srcv2[BF16_WIDTH-1]  ^ex1_neg^ex1_sub) && ex1_dst_bf16;


//mult exponent calculate                    
assign ex1_expnt_bias[DOUBLE_EXPN+1:0] = {13{ex1_double    }} & 13'b1_1100_0000_0001  //double= -1023
                                       | {13{ex1_single    }} & 13'b1_1111_1000_0001  //single= -127
                                       | {13{ex1_dst_f16   }} & 13'b1_1111_1111_0001  //half  = -15
                                       | {13{ex1_bf16      }} & 13'b1_1111_1000_0001; //bf16   = -127

assign ex1_mult_expnt[DOUBLE_EXPN+1:0] = {ex1_expnt_0[DOUBLE_EXPN+1:0]} + 
                                         {ex1_expnt_1[DOUBLE_EXPN+1:0]} +
                                         {1'b0,{DOUBLE_EXPN{1'b0}},ex1_id_reg[0]} +
                                         {1'b0,{DOUBLE_EXPN{1'b0}},ex1_id_reg[1]} +
                                         ex1_expnt_bias[DOUBLE_EXPN+1:0];

assign ex1_mult_sign                   = (ex1_srcv0[DOUBLE_WIDTH-1]^ex1_srcv1[DOUBLE_WIDTH-1]^ex1_neg) && ex1_double
                                      || (ex1_srcv0[SINGLE_WIDTH-1]^ex1_srcv1[SINGLE_WIDTH-1]^ex1_neg) && ex1_single
                                      || (ex1_srcv0[F16_WIDTH-1]   ^ex1_srcv1[F16_WIDTH-1]^ex1_neg)    && ex1_f16
                                      || (ex1_srcv0[BF16_WIDTH-1]  ^ex1_srcv1[BF16_WIDTH-1]^ex1_neg)   && ex1_bf16;


//mac shift alignment preparation                               
assign ex1_mac_expnt_diff[DOUBLE_EXPN+1:0] = ex1_mult_expnt[DOUBLE_EXPN+1:0] +
                                            {{DOUBLE_EXPN{1'b0}},2'b10} -  
                                            {ex1_expnt_2[DOUBLE_EXPN+1:0]};

assign ex1_right_max[DOUBLE_EXPN+1:0]      = 13'b0_0000_0110_1101;
assign ex1_right_sel                       = (ex1_mac_expnt_diff[DOUBLE_EXPN:0]< ex1_right_max[DOUBLE_EXPN:0]);


assign ex1_left_bias[DOUBLE_EXPN+1:0]      = 13'b0_0000_0011_0110; 
assign ex1_left_max[DOUBLE_EXPN+1:0]       = ex1_left_bias[DOUBLE_EXPN+1:0] + //FRAC+2 -(-D)
                                           + ex1_mac_expnt_diff[DOUBLE_EXPN+1:0];

// &Instance("aq_vfmau_special_judge_double","x_aq_vfmau_special_judge_double"); @982
aq_vfmau_special_judge_double  x_aq_vfmau_special_judge_double (
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ex1_bf16                      (ex1_bf16                     ),
  .ex1_double                    (ex1_double                   ),
  .ex1_double_expnt_near_of      (ex1_double_expnt_near_of     ),
  .ex1_double_expnt_near_uf      (ex1_double_expnt_near_uf     ),
  .ex1_dst_bf16                  (ex1_dst_bf16                 ),
  .ex1_dst_double                (ex1_dst_double               ),
  .ex1_dst_f16                   (ex1_dst_f16                  ),
  .ex1_dst_half                  (ex1_dst_half                 ),
  .ex1_dst_single                (ex1_dst_single               ),
  .ex1_half                      (ex1_half                     ),
  .ex1_mac                       (ex1_mac                      ),
  .ex1_mult_expnt                (ex1_mult_expnt               ),
  .ex1_mult_sign                 (ex1_mult_sign                ),
  .ex1_rm                        (ex1_rm                       ),
  .ex1_single                    (ex1_single                   ),
  .ex1_src2_sign                 (ex1_src2_sign                ),
  .ex1_srcv0                     (ex1_srcv0                    ),
  .ex1_srcv1                     (ex1_srcv1                    ),
  .ex1_srcv2                     (ex1_srcv2                    ),
  .ex1_widen                     (ex1_widen                    ),
  .ex2_dst_bf16                  (ex2_dst_bf16                 ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_dst_f16                   (ex2_dst_f16                  ),
  .ex2_dst_half                  (ex2_dst_half                 ),
  .ex2_dst_single                (ex2_dst_single               ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_mult_double_result        (ex3_mult_double_result       ),
  .ex3_mult_nx                   (ex3_mult_nx                  ),
  .ex3_special_data_vld          (ex3_special_data_vld         ),
  .ex3_special_fflags            (ex3_special_fflags           ),
  .ex3_special_result            (ex3_special_result           ),
  .ex4_mult_double_nx            (ex4_mult_double_nx           ),
  .ex4_mult_double_result        (ex4_mult_double_result       ),
  .fmau_ex2_data_clk             (fmau_ex2_data_clk            ),
  .fmau_ex3_data_clk             (fmau_ex3_data_clk            ),
  .fmau_ex4_data_clk             (fmau_ex4_data_clk            ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);


always @(posedge fmau_ex2_data_clk)
begin
 if(ctrl_dp_ex1_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex2_src2_sign                      <= ex1_src2_sign;
    ex2_src2_expnt_not_zero            <= ex1_src2_expnt_not_zero;   
    ex2_expnt_2[DOUBLE_EXPN+1:0]       <= ex1_expnt_2[DOUBLE_EXPN+1:0];    
    ex2_frac_2[DOUBLE_FRAC-1:0]        <= ex1_frac_2[DOUBLE_FRAC-1:0];
    ex2_mac_expnt_diff[DOUBLE_EXPN+1:0]<= ex1_mac_expnt_diff[DOUBLE_EXPN+1:0];
    ex2_mult_sign                      <= ex1_mult_sign;
    ex2_mult_expnt[DOUBLE_EXPN+1:0]    <= ex1_mult_expnt[DOUBLE_EXPN+1:0];
    ex2_left_max[DOUBLE_EXPN+1:0]      <= ex1_left_max[DOUBLE_EXPN+1:0];
    ex2_right_sel                      <= ex1_right_sel;
  end
end

//==========================================================
//                     EX2 src2 shift alignment
//==========================================================
assign ex2_shift_sel[0] = !ex2_mac_expnt_diff[DOUBLE_EXPN+1] &&  ex2_right_sel;//right shift diff
assign ex2_shift_sel[1] = !ex2_mac_expnt_diff[DOUBLE_EXPN+1] && !ex2_right_sel;//right shift 2*FRAC+5
assign ex2_shift_sel[2] =  ex2_mac_expnt_diff[DOUBLE_EXPN+1] && !ex2_left_max[DOUBLE_EXPN+1]; //left shift FRAC+2-|diff|

assign ex2_right_max[DOUBLE_EXPN+1:0] = 13'b0_0000_0110_1101;//2*FRAC+5

// &CombBeg; @1009
always @( ex2_mac_expnt_diff[6:0]
       or ex2_right_max[6:0]
       or ex2_shift_sel[2:0]
       or ex2_left_max[6:0])
begin
case(ex2_shift_sel[2:0])
  3'b001: ex2_shift_index[6:0] = ex2_mac_expnt_diff[6:0];
  3'b010: ex2_shift_index[6:0] = ex2_right_max[6:0];
  3'b100: ex2_shift_index[6:0] = ex2_left_max[6:0];
 default: ex2_shift_index[6:0] = {7{1'b0}};
endcase
// &CombEnd; @1016
end

assign ex2_mac_expnt[DOUBLE_EXPN+1:0] = ex2_mac_expnt_diff[DOUBLE_EXPN+1] 
                                      ? ex2_expnt_2[DOUBLE_EXPN+1:0] + { {6{1'b0}},ex2_shift_index[6:0]}
                                      : ex2_mult_expnt[DOUBLE_EXPN+1:0]+{ {DOUBLE_EXPN{1'b0}},2'b10};

assign ex2_data_for_shift[DOUBLE_FRAC:0] = {ex2_src2_expnt_not_zero,ex2_frac_2[DOUBLE_FRAC-1:0]};

// &Instance("aq_vfmau_frac_shift_double","x_aq_vfmau_frac_shift_double"); @1024
aq_vfmau_frac_shift_double  x_aq_vfmau_frac_shift_double (
  .ex2_data_for_shift (ex2_data_for_shift),
  .ex2_shift_data_out (ex2_shift_data_out),
  .ex2_shift_index    (ex2_shift_index   )
);


assign ex2_shift_data[110:0] = ex2_shift_data_out[110:0];

//==================================================================
//                     EX2 data prepare
//==================================================================
//case 1: E01+2>=E2 MAC
// MULT_RESULT:0|0|X|X|FRAC_H[51:0]|FRAC_L[51:0]|0|0|0
// SRC2        0|x|FRAC[51:0]|000.........000000000000>>shift index
//case 2: E01+2 < E2 MAC
// MULT_RESULT:0|0|00...00000|0|0|X|X|FRAC_H[51:0]|S
// SRC2        0|x|FRAC[51:0]|00....0.....000000000000>>shift index
//case 3:MULT ROUNDING
// MULT_RESULT:00..........000000|0|X|X|FRAC_H[51:0]|S
// SRC2        00..........000000000000|SINGLE...OUBLE|>>shift index
//ADDER_0
assign ex2_adder_0_0[ADD_D_WIDTH-1:0] = {2'b00,{DOUBLE_FRAC{1'b0}}, 2'b00, ex2_mult_data[105:52],|ex2_mult_double_gs_bit[1:0]};
assign ex2_adder_0_1[ADD_D_WIDTH-1:0] = {2'b00, ex2_mult_data[105:0],3'b0};

assign ex2_adder_0_sel_h            = ex2_mac_expnt_diff[DOUBLE_EXPN+1] || !ex2_mac;
assign ex2_adder_0[ADD_D_WIDTH-1:0] = (ex2_adder_0_sel_h)
                                    ? ex2_adder_0_0[ADD_D_WIDTH-1:0] 
                                    : ex2_adder_0_1[ADD_D_WIDTH-1:0];

//ADDER_1
assign ex2_adder_1_for_f16_rnd_add_1   = ex2_dst_f16 && !ex2_mac && !ex2_mult_data[105];
assign ex2_adder_1_for_f16_rnd_add_2   = ex2_dst_f16 && !ex2_mac &&  ex2_mult_data[105];

assign ex2_adder_1_for_bf16_rnd_add_1  = ex2_dst_bf16 && !ex2_mac && !ex2_mult_data[105];
assign ex2_adder_1_for_bf16_rnd_add_2  = ex2_dst_bf16 && !ex2_mac &&  ex2_mult_data[105];

//note the result of half widen mult is always exact,only if underflow,
//but it will calculate at EX4.
assign ex2_adder_1_for_single_rnd_add_1 = ex2_single && !ex2_mac && !ex2_mult_data[105];
assign ex2_adder_1_for_single_rnd_add_2 = ex2_single && !ex2_mac &&  ex2_mult_data[105];

assign ex2_adder_1_for_double_rnd_add_1 = ex2_double && !ex2_mac && !ex2_mult_data[105];
assign ex2_adder_1_for_double_rnd_add_2 = ex2_double && !ex2_mac &&  ex2_mult_data[105];

assign ex2_adder_1_rnd_data[ADD_D_WIDTH-1:0] =
   {{109{1'b0}},ex2_adder_1_for_double_rnd_add_1,{1{1'b0}} }
 | {{108{1'b0}},ex2_adder_1_for_double_rnd_add_2,{2{1'b0}} }
 | {{ 80{1'b0}},ex2_adder_1_for_single_rnd_add_1,{1{1'b0}}, {29{1'b0}} }
 | {{ 79{1'b0}},ex2_adder_1_for_single_rnd_add_2,{2{1'b0}}, {29{1'b0}} }
 | {{ 67{1'b0}},ex2_adder_1_for_f16_rnd_add_1,{1{1'b0}}, {42{1'b0}} }
 | {{ 66{1'b0}},ex2_adder_1_for_f16_rnd_add_2,{2{1'b0}}, {42{1'b0}} }
 | {{ 64{1'b0}},ex2_adder_1_for_bf16_rnd_add_1,{1{1'b0}}, {45{1'b0}} }
 | {{ 63{1'b0}},ex2_adder_1_for_bf16_rnd_add_2,{2{1'b0}}, {45{1'b0}} };

assign ex2_sub_vld                  = (ex2_mult_sign ^ ex2_src2_sign) && ex2_mac;
assign ex2_adder_1[ADD_D_WIDTH-1:0] = ex2_sub_vld 
                                   ? ~ex2_shift_data[ADD_D_WIDTH-1:0]
                                   : (ex2_shift_data[ADD_D_WIDTH-1:0] | ex2_adder_1_rnd_data[ADD_D_WIDTH-1:0]);

assign ex2_mult_half_gs_bit[1:0]   = (ex2_bf16)
                                   ? {ex2_mult_data[96] ,|ex2_mult_data[95:90]}
                                   : {ex2_mult_data[93],|ex2_mult_data[92:84]};
assign ex2_mult_single_gs_bit[1:0] = {ex2_mult_data[80], |ex2_mult_data[79:58]};
assign ex2_mult_double_gs_bit[1:0] = {ex2_mult_data[51], |ex2_mult_data[50: 0]};

assign ex2_shift_limit_low[15:0]   = 16'b1000_0000_0000_0000 >> ex2_mac_expnt[3:0];
assign ex2_shift_limit_vld         = (ex2_mac_expnt[12:7]==6'b00_0000);

//==========================================================
//                     EX3 data pipe
//==========================================================

always @(posedge fmau_ex3_data_clk)
begin
 if(ctrl_dp_ex2_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex3_sub_vld                     <= ex2_sub_vld;
    ex3_mult_sign                   <= ex2_mult_sign;
    ex3_mac_expnt[DOUBLE_EXPN+1:0]  <= ex2_mac_expnt[DOUBLE_EXPN+1:0];
    ex3_mult_expnt[DOUBLE_EXPN+1:0] <= ex2_mult_expnt[DOUBLE_EXPN+1:0];
    ex3_mult_half_gs_bit[1:0]       <= ex2_mult_half_gs_bit[1:0];
    ex3_mult_single_gs_bit[1:0]     <= ex2_mult_single_gs_bit[1:0];
    ex3_mult_double_gs_bit[1:0]     <= ex2_mult_double_gs_bit[1:0];
    ex3_adder_0[110:0]              <= ex2_adder_0[110:0];
    ex3_adder_1[110:0]              <= ex2_adder_1[110:0];
    ex3_shift_limit_low[15:0]       <= ex2_shift_limit_low[15:0] & {16{ex2_shift_limit_vld}};
  end
end

assign ex3_shift_limit_one_hot[127:0] = {ex3_shift_limit_low[15:0],{112{1'b0}} } >> {ex3_mac_expnt[6:4],4'b0};
assign ex3_shift_limit[110:0] = ex3_shift_limit_one_hot[127:17];

//==========================================================
//                     EX3 adders
//==========================================================
assign ex3_adder_0_result[ADD_D_WIDTH-1:0] = ex3_adder_0[ADD_D_WIDTH-1:0] + ex3_adder_1[ADD_D_WIDTH-1:0];
assign ex3_adder_1_result[ADD_D_WIDTH-1:0] = ex3_adder_0[ADD_D_WIDTH-1:0] + ex3_adder_1[ADD_D_WIDTH-1:0] + 1'b1;

assign ex3_adder_result_sel[0] = !ex3_sub_vld;
assign ex3_adder_result_sel[1] =  ex3_sub_vld && ex3_adder_1_result[ADD_D_WIDTH-1];
assign ex3_adder_result_sel[2] =  ex3_sub_vld &&!ex3_adder_1_result[ADD_D_WIDTH-1];

// &CombBeg; @1122
always @( ex3_adder_1_result[110:0]
       or ex3_adder_0_result[110:0]
       or ex3_adder_result_sel[2:0])
begin
case(ex3_adder_result_sel[2:0])
  3'b001: ex3_adder_result[ADD_D_WIDTH-1:0] = ex3_adder_0_result[ADD_D_WIDTH-1:0];
  3'b010: ex3_adder_result[ADD_D_WIDTH-1:0] =~ex3_adder_0_result[ADD_D_WIDTH-1:0];
  3'b100: ex3_adder_result[ADD_D_WIDTH-1:0] = ex3_adder_1_result[ADD_D_WIDTH-1:0];
 default: ex3_adder_result[ADD_D_WIDTH-1:0] = {ADD_D_WIDTH{1'bx}};
endcase
// &CombEnd; @1129
end

assign ex3_mac_sign = ex3_mult_sign ^(ex3_sub_vld && ex3_adder_1_result[ADD_D_WIDTH-1]);
assign ex3_mac_frac_not_zero = |ex3_adder_result[ADD_D_WIDTH-1:0];

//======================================================================
//   leading zero predict
//======================================================================
// &Instance("aq_vfmau_lza_double","x_aq_vfmau_lza_double"); @1137
aq_vfmau_lza_double  x_aq_vfmau_lza_double (
  .addend          (ex3_adder_1    ),
  .lza_result      (ex3_lza_result ),
  .sub_vld         (ex3_sub_vld    ),
  .summand         (ex3_adder_0    ),
  .upper_limit     (ex3_shift_limit)
);

// &Connect( .summand     (ex3_adder_0    ), @1138
//           .addend      (ex3_adder_1    ), @1139
//           .sub_vld     (ex3_sub_vld    ), @1140
//           .upper_limit (ex3_shift_limit), @1141
//           .lza_result  (ex3_lza_result )); @1142

//==================================================================================
// EX3 normal mult rounding:expnt= [-126/-1022,126/1022] && no denormal no overflow
//==================================================================================
assign ex3_mult_result[DOUBLE_FRAC+1:0] = ex3_adder_0[DOUBLE_FRAC+2:1];

assign ex3_mult_rnd_result[DOUBLE_FRAC+1:0] = ex3_adder_0_result[DOUBLE_FRAC+2:1];

assign ex3_mult_double_rnd_bit[2:0] = (ex3_mult_result[DOUBLE_FRAC+1])
                                    ? {ex3_mult_result[1:0],|ex3_mult_double_gs_bit[1:0]}
                                    : {ex3_mult_result[0],   ex3_mult_double_gs_bit[1:0]};

assign ex3_mult_single_rnd_bit[2:0] = (ex3_mult_result[DOUBLE_FRAC+1])
                                    ? {ex3_mult_result[30:29],|ex3_mult_single_gs_bit[1:0]}
                                    : {ex3_mult_result[29],   ex3_mult_single_gs_bit[1:0]}; 

assign ex3_mult_half_rnd_bit[2:0]   = (ex3_mult_result[DOUBLE_FRAC+1])
                                    ? {ex3_mult_result[43:42],|ex3_mult_half_gs_bit[1:0]}
                                    : {ex3_mult_result[42],   ex3_mult_half_gs_bit[1:0]}; 

assign ex3_mult_bf16_rnd_bit[2:0]   = (ex3_mult_result[DOUBLE_FRAC+1])
                                    ? {ex3_mult_result[46:45],|ex3_mult_half_gs_bit[1:0]}
                                    : {ex3_mult_result[45],   ex3_mult_half_gs_bit[1:0]};

assign ex3_mult_rnd_bit[2:0] = {3{ex3_dst_single}} & ex3_mult_single_rnd_bit[2:0]
                             | {3{ex3_dst_f16   }} & ex3_mult_half_rnd_bit[2:0]
                             | {3{ex3_dst_bf16  }} & ex3_mult_bf16_rnd_bit[2:0]
                             | {3{ex3_dst_double}} & ex3_mult_double_rnd_bit[2:0];


// &CombBeg; @1173
always @( ex3_mult_sign
       or ex3_rm[2:0]
       or ex3_mult_rnd_bit[2:0])
begin
case(ex3_rm[2:0])
  3'b000: ex3_mult_rnd_in = ex3_mult_rnd_bit[1] && (ex3_mult_rnd_bit[0] || ex3_mult_rnd_bit[2]); //round to nearest even
  3'b001: ex3_mult_rnd_in = 1'b0;
  3'b010: ex3_mult_rnd_in = ex3_mult_sign && |ex3_mult_rnd_bit[1:0]; //round to negative infinity
  3'b011: ex3_mult_rnd_in =!ex3_mult_sign && |ex3_mult_rnd_bit[1:0]; //round to positive infinity
  3'b100: ex3_mult_rnd_in = ex3_mult_rnd_bit[1];
default : ex3_mult_rnd_in = 1'b0;
endcase
// &CombEnd; @1182
end
                             

assign ex3_mult_frac_sel[0]        = ex3_mult_rnd_result[DOUBLE_FRAC+1] && ex3_mult_rnd_in;
assign ex3_mult_frac_sel[1]        =!ex3_mult_rnd_result[DOUBLE_FRAC+1] && ex3_mult_rnd_in;

assign ex3_mult_no_rnd_result[DOUBLE_FRAC-1:0] = (ex3_mult_result[DOUBLE_FRAC+1])
                                               ? ex3_mult_result[DOUBLE_FRAC:1]
                                               : ex3_mult_result[DOUBLE_FRAC-1:0];

// &CombBeg; @1192
always @( ex3_mult_no_rnd_result[51:0]
       or ex3_mult_frac_sel[1:0]
       or ex3_mult_rnd_result[52:0])
begin
case(ex3_mult_frac_sel[1:0])
  2'b01: ex3_mult_frac_result[DOUBLE_FRAC-1:0] = ex3_mult_rnd_result[DOUBLE_FRAC:1];
  2'b10: ex3_mult_frac_result[DOUBLE_FRAC-1:0] = ex3_mult_rnd_result[DOUBLE_FRAC-1:0];
default: ex3_mult_frac_result[DOUBLE_FRAC-1:0] = ex3_mult_no_rnd_result[DOUBLE_FRAC-1:0];
endcase
// &CombEnd; @1198
end


assign ex3_mult_expnt_p1[DOUBLE_EXPN+1:0] = ex3_mult_expnt[DOUBLE_EXPN+1:0] + 1'b1;

assign ex3_mult_expnt_add_in = ex3_mult_result[DOUBLE_FRAC+1] 
                            || &ex3_mult_result[DOUBLE_FRAC-1:DOUBLE_FRAC-23]  && ex3_mult_rnd_in && ex3_dst_single
                            || &ex3_mult_result[DOUBLE_FRAC-1:DOUBLE_FRAC-10]  && ex3_mult_rnd_in && ex3_dst_f16
                            || &ex3_mult_result[DOUBLE_FRAC-1:DOUBLE_FRAC-7]   && ex3_mult_rnd_in && ex3_dst_bf16
                            || &ex3_mult_result[DOUBLE_FRAC-1:0]               && ex3_mult_rnd_in && ex3_dst_double;


assign ex3_mult_expnt_result[DOUBLE_EXPN-1:0] =  (ex3_mult_expnt_add_in) 
                                               ? ex3_mult_expnt_p1[DOUBLE_EXPN-1:0]
                                               : ex3_mult_expnt[DOUBLE_EXPN-1:0];

assign ex3_mult_double_result[DOUBLE_WIDTH-1:0] = { ex3_mult_sign, 
                                                    ex3_mult_expnt_result[DOUBLE_EXPN-1:0],
                                                    ex3_mult_frac_result[DOUBLE_FRAC-1:0]};
assign ex3_mult_single_result[SINGLE_WIDTH-1:0] = { ex3_mult_sign, 
                                                    ex3_mult_expnt_result[SINGLE_EXPN-1:0],
                                                    ex3_mult_frac_result[DOUBLE_FRAC-1:DOUBLE_FRAC-SINGLE_FRAC]};
assign ex3_mult_half_result[F16_WIDTH-1:0]      = { ex3_mult_sign, 
                                                    ex3_mult_expnt_result[F16_EXPN-1:0],
                                                    ex3_mult_frac_result[DOUBLE_FRAC-1:DOUBLE_FRAC-F16_FRAC]};
assign ex3_mult_bf16_result[BF16_WIDTH-1:0]     = { ex3_mult_sign, 
                                                    ex3_mult_expnt_result[BF16_EXPN-1:0],
                                                    ex3_mult_frac_result[DOUBLE_FRAC-1:DOUBLE_FRAC-BF16_FRAC]};

assign ex3_mult_nx = (|ex3_mult_rnd_bit[1:0]) && !ex3_special_data_vld; 

assign ex3_fmau_result_63_48[15:0] = {16{!ex3_dst_double}} & 16'hffff;
assign ex3_fmau_result_47_32[15:0] = {16{!ex3_dst_double}} & 16'hffff;
assign ex3_fmau_result_31_16[15:0] = {16{ex3_single }} & ex3_mult_single_result[31:16]
                                   | {16{!ex3_single}} & 16'hffff;
assign ex3_fmau_result_15_0[15:0] = 
      {16{ex3_single}} & ex3_mult_single_result[15:0]
    | {16{ex3_f16}}    & ex3_mult_half_result[15:0]
    | {16{ex3_bf16}}   & ex3_mult_bf16_result[15:0];

assign vfmau_vpu_ex3_fpr_result[63:48] = (ex3_special_data_vld) ? ex3_special_result[63:48] : ex3_fmau_result_63_48[15:0];
assign vfmau_vpu_ex3_fpr_result[47:32] = (ex3_special_data_vld) ? ex3_special_result[47:32] : ex3_fmau_result_47_32[15:0];
assign vfmau_vpu_ex3_fpr_result[31:16] = (ex3_special_data_vld) ? ex3_special_result[31:16] : ex3_fmau_result_31_16[15:0];
assign vfmau_vpu_ex3_fpr_result[15:0]  = (ex3_special_data_vld) ? ex3_special_result[15:0]  : ex3_fmau_result_15_0[15:0];

assign vfmau_vpu_ex3_fflags[4:0] = {4'b0,ex3_mult_nx} 
                                 | {ex3_special_fflags[1],1'b0,ex3_special_fflags[0],1'b0,ex3_special_fflags[0]};

assign ex3_special_cmplt = ex3_special_data_vld && !(ex3_dst_double && ex3_simd);
//==========================================================
//                     EX3 result pipe down
//==========================================================
assign ex3_mac_result_shift[ADD_D_WIDTH-1:0] = ex3_adder_result[ADD_D_WIDTH-1:0]<<{ex3_lza_result[4:0]};
assign ex3_mac_expnt_adjust[DOUBLE_EXPN+1:0] = ex3_mac_expnt[DOUBLE_EXPN+1:0] -{ {6{1'b0}},ex3_lza_result[6:0]};//plus1
assign ex3_mac_expnt_neg_max                 =(ex3_mac_expnt[DOUBLE_EXPN+1:0] == { {6{1'b0}},ex3_lza_result[6:0]});

always @(posedge fmau_ex4_data_clk)
begin
 if(ctrl_dp_ex3_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex4_mac_expnt[DOUBLE_EXPN+1:0]    <= ex3_mac_expnt_adjust[DOUBLE_EXPN+1:0];
    ex4_mac_frac_pre[ADD_D_WIDTH-1:0] <= ex3_mac_result_shift[ADD_D_WIDTH-1:0];
    ex4_mac_shift_high[1:0]           <= ex3_lza_result[6:5];
    ex4_mac_expnt_neg_max             <= ex3_mac_expnt_neg_max;
    ex4_mac_frac_not_zero             <= ex3_mac_frac_not_zero;
    ex4_mac_sign                      <= ex3_mac_sign;
  end
end

assign ex4_mac_frac[ADD_D_WIDTH-1:0] = ex4_mac_shift_high[0] ? {ex4_mac_frac_pre[ADD_D_WIDTH-33:0], {32{1'b0}} }
                                                             :  ex4_mac_frac_pre[ADD_D_WIDTH- 1:0];

//======================================================================
//       EX4 MAC RESULT ROUNDING
//======================================================================                                                  
assign ex4_expnt_8bit  = ex4_dst_single || ex4_bf16;
assign ex4_expnt_5bit  = ex4_dst_f16;
assign ex4_expnt_11bit = ex4_dst_double;

//early overflow
assign ex4_single_of       = (ex4_mac_expnt[9 : 8]==2'b01)||(ex4_mac_expnt[9 : 0]==10'b00_1111_1111);
assign ex4_half_of         = (ex4_mac_expnt[6 : 5]==2'b01)||(ex4_mac_expnt[6 : 0]== 7'b00_1_1111);
assign ex4_double_early_of = (ex4_mac_expnt[12:11]==2'b01)||(ex4_mac_expnt[12: 0]==13'b00_111_1111_1111);

assign ex4_early_of  = ex4_expnt_8bit  && ex4_single_of
                    || ex4_expnt_5bit  && ex4_half_of
                    || ex4_expnt_11bit && ex4_double_early_of;

//plus 1 overflow
assign ex4_expnt_11bit_p1_of = (ex4_mac_expnt[12: 0] == 13'b00_111_1111_1110) && ex4_mac_expnt_p1;
assign ex4_expnt_8bit_p1_of  = (ex4_mac_expnt[9 : 0] == 10'b00_1111_1110) && ex4_mac_expnt_p1;
assign ex4_expnt_5bit_p1_of  = (ex4_mac_expnt[6 : 0] == 7'b00_1_1110) && ex4_mac_expnt_p1;

assign ex4_p1_of             = ex4_expnt_8bit  && ex4_expnt_8bit_p1_of
                            || ex4_expnt_5bit  && ex4_expnt_5bit_p1_of
                            || ex4_expnt_11bit && ex4_expnt_11bit_p1_of;

assign ex4_mac_expnt_p1      = ex4_mac_expnt_neg_max
                             || ex4_mac_shift_high[1] && ex4_mac_frac[ADD_D_WIDTH-65]
                             || !ex4_mac_shift_high[1] && ex4_mac_frac[ADD_D_WIDTH-1];

assign ex4_of_frac_bit  = (ex4_rm[2:0]==3'b001)//rnd to zero 
                        ||(ex4_rm[2:0]==3'b010) && !ex4_mac_sign //rnd to neg and !sign
                        ||(ex4_rm[2:0]==3'b011) &&  ex4_mac_sign;//rnd to pos and  sign

assign ex4_mac_data_shift_64[ADD_D_WIDTH-1:0] = ex4_mac_frac[ADD_D_WIDTH-1:0] <<{ex4_mac_shift_high[1],6'b000_000};

assign ex4_mac_data_no_rnd[DOUBLE_FRAC:0] = (ex4_mac_data_shift_64[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max)
                                          ? ex4_mac_data_shift_64[ADD_D_WIDTH-1:ADD_D_WIDTH-DOUBLE_FRAC-1]
                                          : ex4_mac_data_shift_64[ADD_D_WIDTH-2:ADD_D_WIDTH-DOUBLE_FRAC-2];

assign ex4_mac_data_for_rnd[DOUBLE_FRAC+1:0] = (ex4_mac_frac[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max)
                                             ? {1'b0, ex4_mac_frac[ADD_D_WIDTH-1:ADD_D_WIDTH-DOUBLE_FRAC-1]}
                                             : {1'b0, ex4_mac_frac[ADD_D_WIDTH-2:ADD_D_WIDTH-DOUBLE_FRAC-2]};

assign ex4_mac_rnd_result[DOUBLE_FRAC+1:0] = ex4_mac_data_for_rnd[DOUBLE_FRAC+1:0] +
                                           { {8{1'b0}},ex4_bf16,{2{1'b0}},ex4_f16,{12{1'b0}},ex4_single,{28{1'b0}},ex4_dst_double};                                      

assign ex4_double_rnd_bit[2:0] = (ex4_mac_frac[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max) 
                               ? {ex4_mac_frac[58:57],|ex4_mac_frac[56:0]}
                               : {ex4_mac_frac[57:56],|ex4_mac_frac[55:0]};
assign ex4_single_rnd_bit[2:0] = (ex4_mac_frac[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max) 
                               ? {ex4_mac_frac[87:86],|ex4_mac_frac[85:0]}
                               : {ex4_mac_frac[86:85],|ex4_mac_frac[84:0]};
assign ex4_f16_rnd_bit[2:0]    = (ex4_mac_frac[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max)
                               ? {ex4_mac_frac[100:99],|ex4_mac_frac[98:0]}
                               : {ex4_mac_frac[99:98],|ex4_mac_frac[97:0]};
assign ex4_bf16_rnd_bit[2:0]   = (ex4_mac_frac[ADD_D_WIDTH-1] || ex4_mac_expnt_neg_max)
                               ? {ex4_mac_frac[103:102],|ex4_mac_frac[101:0]}
                               : {ex4_mac_frac[102:101],|ex4_mac_frac[100:0]};


assign ex4_rnd_bit[2:0] = 
   {3{ex4_dst_single && !ex4_mac_shift_high[1]}} & ex4_single_rnd_bit[2:0]
 | {3{ex4_dst_f16    && !ex4_mac_shift_high[1]}} & ex4_f16_rnd_bit[2:0]
 | {3{ex4_dst_bf16   && !ex4_mac_shift_high[1]}} & ex4_bf16_rnd_bit[2:0]
 | {3{ex4_dst_double && !ex4_mac_shift_high[1]}} & ex4_double_rnd_bit[2:0];

// &CombBeg; @1336
always @( ex4_mac_sign
       or ex4_rm[2:0]
       or ex4_rnd_bit[2:0])
begin
case(ex4_rm[2:0])
  3'b000: ex4_mac_rnd_in = ex4_rnd_bit[1] && (ex4_rnd_bit[0] || ex4_rnd_bit[2]); //round to nearest even
  3'b001: ex4_mac_rnd_in = 1'b0;
  3'b010: ex4_mac_rnd_in = ex4_mac_sign && |ex4_rnd_bit[1:0]; //round to negative infinity
  3'b011: ex4_mac_rnd_in =!ex4_mac_sign && |ex4_rnd_bit[1:0]; //round to positive infinity
  3'b100: ex4_mac_rnd_in = ex4_rnd_bit[1];
default : ex4_mac_rnd_in = 1'b0;
endcase
// &CombEnd;  @1345
end

assign ex4_mac_frac_sel[0] = ex4_mac_rnd_result[DOUBLE_FRAC+1] && ex4_mac_rnd_in && !ex4_early_of && !ex4_p1_of; //1x.xxx after rnd,no of
assign ex4_mac_frac_sel[1] =!ex4_mac_rnd_result[DOUBLE_FRAC+1] && ex4_mac_rnd_in && !ex4_early_of && !ex4_p1_of; //0x.xxx after rnd,no of

// &CombBeg; @1350
always @( ex4_mac_data_no_rnd[51:0]
       or ex4_mac_rnd_result[52:0]
       or ex4_p1_of
       or ex4_early_of
       or ex4_mac_frac_sel[1:0]
       or ex4_of_frac_bit)
begin
case(ex4_mac_frac_sel[1:0])
  2'b01: ex4_mac_frac_result[DOUBLE_FRAC-1:0] = ex4_mac_rnd_result[DOUBLE_FRAC:1];
  2'b10: ex4_mac_frac_result[DOUBLE_FRAC-1:0] = ex4_mac_rnd_result[DOUBLE_FRAC-1:0];
default: ex4_mac_frac_result[DOUBLE_FRAC-1:0] =(ex4_early_of || ex4_p1_of) ? {DOUBLE_FRAC{ex4_of_frac_bit}} : ex4_mac_data_no_rnd[DOUBLE_FRAC-1:0];
endcase
// &CombEnd; @1356
end

assign ex4_expnt_rnd_in = ex4_mac_rnd_in  &&
                        (  ex4_single     && &(ex4_mac_data_for_rnd[DOUBLE_FRAC-1:DOUBLE_FRAC-23])
                        || ex4_dst_double && &(ex4_mac_data_for_rnd[DOUBLE_FRAC-1:DOUBLE_FRAC-52])
                        || ex4_dst_f16    && &(ex4_mac_data_for_rnd[DOUBLE_FRAC-1:DOUBLE_FRAC-10])
                        || ex4_dst_bf16   && &(ex4_mac_data_for_rnd[DOUBLE_FRAC-1:DOUBLE_FRAC-7]));


assign ex4_mac_expnt_sel[2] = ex4_mac_data_no_rnd[DOUBLE_FRAC] && ex4_mac_frac_not_zero && !ex4_early_of 
                           && ex4_expnt_rnd_in && ex4_mac_expnt_p1 && !ex4_p1_of;  //plus 2

assign ex4_mac_expnt_sel[1] = ex4_mac_data_no_rnd[DOUBLE_FRAC] && ex4_mac_frac_not_zero && !ex4_early_of 
                           &&(ex4_expnt_rnd_in ^ ex4_mac_expnt_p1) && !ex4_p1_of  //plus 1
                           ||!ex4_mac_data_no_rnd[DOUBLE_FRAC] && ex4_mac_frac_not_zero && !ex4_early_of 
                           && ex4_expnt_rnd_in;  //plus 1

assign ex4_mac_expnt_sel[0] = ex4_mac_data_no_rnd[DOUBLE_FRAC] && ex4_mac_frac_not_zero && !ex4_early_of 
                           &&!ex4_expnt_rnd_in && !ex4_mac_expnt_p1   //plus 0
                           ||!ex4_mac_data_no_rnd[DOUBLE_FRAC] && ex4_mac_frac_not_zero && !ex4_early_of
                           &&!ex4_expnt_rnd_in;

// &CombBeg; @1378
always @( ex4_mac_expnt[10:0]
       or ex4_p1_of
       or ex4_mac_expnt_sel[2:0]
       or ex4_early_of
       or ex4_of_frac_bit)
begin
case(ex4_mac_expnt_sel[2:0])
  3'b100: ex4_mac_expnt_result[DOUBLE_EXPN-1:0] = ex4_mac_expnt[DOUBLE_EXPN-1:0] + 11'b0000_0010;
  3'b010: ex4_mac_expnt_result[DOUBLE_EXPN-1:0] = ex4_mac_expnt[DOUBLE_EXPN-1:0] + 11'b0000_0001;
  3'b001: ex4_mac_expnt_result[DOUBLE_EXPN-1:0] = ex4_mac_expnt[DOUBLE_EXPN-1:0];
 default: ex4_mac_expnt_result[DOUBLE_EXPN-1:0] =(ex4_early_of || ex4_p1_of) ? {{10{1'b1}},!ex4_of_frac_bit}: 11'b0000_0000; 
endcase
// &CombEnd; @1385
end

assign ex4_mac_sign_result = ex4_mac_frac_not_zero ? ex4_mac_sign : (ex4_rm[2:0]==3'b010);

assign ex4_late_of = (ex4_mac_expnt[7:0] ==8'b1111_1101)      && ex4_mac_expnt_sel[2] && ex4_expnt_8bit
                   ||(ex4_mac_expnt[7:0] ==8'b1111_1110)      && ex4_mac_expnt_sel[1] && ex4_expnt_8bit
                   ||(ex4_mac_expnt[4:0] ==5'b1_1101)         && ex4_mac_expnt_sel[2] && ex4_expnt_5bit
                   ||(ex4_mac_expnt[4:0] ==5'b1_1110)         && ex4_mac_expnt_sel[1] && ex4_expnt_5bit
                   ||(ex4_mac_expnt[10:0]==11'b111_1111_1101) && ex4_mac_expnt_sel[2] && ex4_expnt_11bit
                   ||(ex4_mac_expnt[10:0]==11'b111_1111_1110) && ex4_mac_expnt_sel[1] && ex4_expnt_11bit;

assign ex4_mac_of = ex4_early_of || ex4_p1_of || ex4_late_of;
assign ex4_mac_uf = ex4_mac_expnt_neg_max && !ex4_mac_shift_high[1] && |ex4_rnd_bit[1:0]  //inexact frac
                && !ex4_expnt_rnd_in && !ex4_mac_data_no_rnd[DOUBLE_FRAC];

assign ex4_mac_nx = |ex4_rnd_bit[1:0] || ex4_mac_of;

//output data
assign ex4_fmau_double_result[63:0] = {ex4_mac_sign_result,ex4_mac_expnt_result[10:0],ex4_mac_frac_result[51:0]};
assign ex4_fmau_single_result[31:0] = {ex4_mac_sign_result,ex4_mac_expnt_result[7:0],ex4_mac_frac_result[51:29]};
assign ex4_fmau_half_result[15:0]   = (ex4_bf16) ? {ex4_mac_sign_result,ex4_mac_expnt_result[7:0],ex4_mac_frac_result[51:45]}
                                                 : {ex4_mac_sign_result,ex4_mac_expnt_result[4:0],ex4_mac_frac_result[51:42]};

assign ex4_fmau_result_63_48[15:0]  = {16{ex4_dst_double   }} & ex4_mult_double_result[63:48]
                                    | {16{!ex4_dst_double  }} & 16'hffff;
assign ex4_fmau_result_47_32[15:0]  = {16{ex4_dst_double   }} & ex4_mult_double_result[47:32]
                                    | {16{!ex4_dst_double  }} & 16'hffff;
assign ex4_fmau_result_31_16[15:0]  = {16{ex4_dst_double   }} & ex4_mult_double_result[31:16]
                                    | {16{ex4_single       }} & ex4_fmau_single_result[31:16] 
                                    | {16{ex4_dst_half     }} & 16'hffff;
assign ex4_fmau_result_15_0[15:0]   = {16{ex4_dst_double   }} & ex4_mult_double_result[15:0]
                                    | {16{ex4_single   }} & ex4_fmau_single_result[15:0]
                                    | {16{ex4_dst_half }} & ex4_fmau_half_result[15:0];

assign vfmau_vpu_ex4_fpr_result[63:0] = {ex4_fmau_result_63_48[15:0], 
                                         ex4_fmau_result_47_32[15:0],
                                         ex4_fmau_result_31_16[15:0],
                                         ex4_fmau_result_15_0[15:0]};
assign vfmau_vpu_ex4_fflags[4:0]      = {2'b0,ex4_mac_of,ex4_mac_uf,ex4_mac_nx || ex4_mac_of} & {5{!ex4_dst_double}}
                                      | {4'b0,ex4_mult_double_nx};

//==========================================================
//                     EX5 data pipe
//==========================================================                                      
always @(posedge fmau_ex5_data_clk)
begin
 if(ctrl_dp_ex4_inst_pipe_down || ifu_vpu_warm_up) 
 begin
   ex5_mac_double_result[63:0] <= ex4_fmau_double_result[63:0];
   ex5_mac_double_of           <= ex4_mac_of;
   ex5_mac_double_uf           <= ex4_mac_uf;
   ex5_mac_double_nx           <= ex4_mac_nx;
  end
end
assign vfmau_vpu_ex5_fpr_result[63:0] = ex5_mac_double_result[63:0];
assign vfmau_vpu_ex5_fflags[4:0]      = {2'b0,ex5_mac_double_of,ex5_mac_double_uf,ex5_mac_double_nx};


//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @1458
// &Force("nonport","clk"); @1459
// &Force("nonport","rst"); @1460
// &Force("nonport","inst_vld"); @1461
// &Force("nonport","mac"); @1462
// &Force("input","ex3_widen"); @1463

// &ModuleEnd; @1577
endmodule



