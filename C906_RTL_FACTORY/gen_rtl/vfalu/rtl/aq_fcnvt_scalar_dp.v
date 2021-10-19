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
module aq_fcnvt_scalar_dp(
  bhalf0_final_frac,
  cp0_vpu_xx_bf16,
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
  fcnvt_ex2_pipe_clk,
  fcnvt_ex2_pipedown,
  half0_final_frac,
  ifu_vpu_warm_up,
  l16_0_itof_value,
  l32_0_itof_value,
  l64_itof_value,
  single0_final_frac,
  vfcvt_vpu_ex2_gpr_result,
  vfcvt_vpu_ex3_fflags,
  vfcvt_vpu_ex3_fpr_result,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1
);

// &Ports; @27
input   [15:0]  bhalf0_final_frac;                   
input           cp0_vpu_xx_bf16;                     
input   [63:0]  double_final_frac;                   
input           double_pipe_ex1_special_vld;         
input   [3 :0]  double_pipe_ex2_expt;                
input   [63:0]  double_pipe_ftoi_int;                
input   [63:0]  ex2_int16_0_result;                  
input   [63:0]  ex2_int32_0_result;                  
input   [63:0]  ex2_int64_result;                    
input   [63:0]  ex2_l16_0_result;                    
input   [63:0]  ex2_l32_0_result;                    
input   [7 :0]  ex2_l8_0_result;                     
input   [63:0]  ex3_double_result;                   
input           fcnvt_ex1_pipe_clk;                  
input           fcnvt_ex1_pipedown;                  
input           fcnvt_ex2_pipe_clk;                  
input           fcnvt_ex2_pipedown;                  
input   [15:0]  half0_final_frac;                    
input           ifu_vpu_warm_up;                     
input   [31:0]  single0_final_frac;                  
input   [19:0]  vpu_group_1_xx_ex1_func;             
input   [63:0]  vpu_group_1_xx_ex1_srcv0;            
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type;       
input   [63:0]  vpu_group_1_xx_ex1_srcv1;            
output  [5 :0]  double_pipe_bhtod_value;             
output  [4 :0]  double_pipe_bhtox_expnt;             
output          double_pipe_ex1_src_cnan;            
output          double_pipe_ex1_src_inf;             
output          double_pipe_ex1_src_qnan;            
output          double_pipe_ex1_src_snan;            
output          double_pipe_ex1_src_zero;            
output  [63:0]  double_pipe_ex2_frac;                
output  [63:0]  double_pipe_ex2_int;                 
output  [5 :0]  double_pipe_ex2_widden_dn_itof_expnt; 
output  [4 :0]  double_pipe_htox_expnt;              
output  [8 :0]  double_pipe_htox_value;              
output  [63:0]  double_pipe_special_value;           
output          double_pipe_src_dn;                  
output  [4 :0]  double_pipe_stod_expnt;              
output  [21:0]  double_pipe_stod_value;              
output          ex1_dest_bhalf;                      
output          ex1_dest_float;                      
output          ex1_dest_half;                       
output          ex1_dest_si;                         
output          ex1_dest_single;                     
output  [63:0]  ex1_double_src;                      
output  [15:0]  ex1_half0_src;                       
output  [7 :0]  ex1_l8_0_src;                        
output          ex1_op_bhtod;                        
output          ex1_op_bhtos;                        
output          ex1_op_dtobh;                        
output          ex1_op_dtoh;                         
output          ex1_op_dtos;                         
output          ex1_op_ftoi;                         
output          ex1_op_htod;                         
output          ex1_op_htos;                         
output          ex1_op_stobh;                        
output          ex1_op_stod;                         
output          ex1_op_stoh;                         
output  [31:0]  ex1_single0_src;                     
output          ex1_src_bhalf;                       
output          ex1_src_double;                      
output          ex1_src_float;                       
output          ex1_src_half;                        
output          ex1_src_i;                           
output          ex1_src_l16;                         
output          ex1_src_l32;                         
output          ex1_src_l64;                         
output          ex1_src_l8;                          
output          ex1_src_si;                          
output          ex1_src_single;                      
output          ex2_bh_quod_up;                      
output  [6 :0]  ex2_bhalf0_orig_frac;                
output          ex2_dest_bhalf;                      
output          ex2_dest_double;                     
output          ex2_dest_float;                      
output          ex2_dest_half;                       
output          ex2_dest_l16;                        
output          ex2_dest_l32;                        
output          ex2_dest_l64;                        
output          ex2_dest_l8;                         
output          ex2_dest_si;                         
output          ex2_dest_single;                     
output  [51:0]  ex2_double_orig_frac;                
output          ex2_h_quod_up;                       
output  [9 :0]  ex2_half0_orig_frac;                 
output          ex2_narrow;                          
output          ex2_op_itof;                         
output          ex2_quod_dn;                         
output  [22:0]  ex2_single0_orig_frac;               
output          ex2_src_l16;                         
output          ex2_src_l32;                         
output          ex2_src_l64;                         
output          ex2_widden;                          
output  [15:0]  l16_0_itof_value;                    
output  [31:0]  l32_0_itof_value;                    
output  [63:0]  l64_itof_value;                      
output  [63:0]  vfcvt_vpu_ex2_gpr_result;            
output  [4 :0]  vfcvt_vpu_ex3_fflags;                
output  [63:0]  vfcvt_vpu_ex3_fpr_result;            

// &Regs; @28
reg             ex2_bh_quod_up;                      
reg     [63:0]  ex2_comb_frac;                       
reg     [63:0]  ex2_combin_src;                      
reg             ex2_dest_bhalf_flop;                 
reg             ex2_dest_float;                      
reg             ex2_dest_l16;                        
reg             ex2_dest_l32;                        
reg             ex2_dest_l64;                        
reg             ex2_dest_l8;                         
reg             ex2_dest_si;                         
reg             ex2_h_quod_up;                       
reg     [5 :0]  ex2_left_shift_bit;                  
reg             ex2_narrow;                          
reg             ex2_op_itof;                         
reg             ex2_quod_dn;                         
reg             ex2_src_l16;                         
reg             ex2_src_l32;                         
reg             ex2_src_l64;                         
reg             ex2_src_l8;                          
reg             ex2_widden;                          
reg             ex3_dest_l64;                        
reg     [3 :0]  ex3_expt;                            
reg     [63:0]  ex3_result;                          

// &Wires; @29
wire    [15:0]  bhalf0_final_frac;                   
wire    [63:0]  bhalf0_for_ff1;                      
wire    [15:0]  bhalf0_frac_for_shift;               
wire    [5 :0]  bhtod_shift_bit;                     
wire            cnvt_src0_half0_id;                  
wire            cnvt_src0_half0_inf;                 
wire            cnvt_src0_half0_qnan;                
wire            cnvt_src0_half0_snan;                
wire            cnvt_src0_half0_zero;                
wire            cp0_vpu_xx_bf16;                     
wire            cur_l16;                             
wire            cur_l32;                             
wire            cur_l64;                             
wire            cur_l8;                              
wire    [63:0]  double_final_frac;                   
wire    [5 :0]  double_pipe_bhtod_value;             
wire    [4 :0]  double_pipe_bhtox_expnt;             
wire            double_pipe_ex1_special_vld;         
wire            double_pipe_ex1_src_cnan;            
wire            double_pipe_ex1_src_inf;             
wire            double_pipe_ex1_src_qnan;            
wire            double_pipe_ex1_src_snan;            
wire            double_pipe_ex1_src_zero;            
wire    [3 :0]  double_pipe_ex2_expt;                
wire    [63:0]  double_pipe_ex2_frac;                
wire    [63:0]  double_pipe_ex2_int;                 
wire    [5 :0]  double_pipe_ex2_itof_expnt;          
wire    [5 :0]  double_pipe_ex2_widden_dn_itof_expnt; 
wire    [5 :0]  double_pipe_ex2_xtod_expnt;          
wire    [63:0]  double_pipe_ftoi_int;                
wire    [4 :0]  double_pipe_htox_expnt;              
wire    [8 :0]  double_pipe_htox_value;              
wire    [63:0]  double_pipe_special_value;           
wire            double_pipe_src_dn;                  
wire    [4 :0]  double_pipe_stod_expnt;              
wire    [21:0]  double_pipe_stod_value;              
wire            ex1_bh_quod_up;                      
wire    [63:0]  ex1_combined_src;                    
wire            ex1_dest_bhalf;                      
wire            ex1_dest_double;                     
wire            ex1_dest_float;                      
wire            ex1_dest_half;                       
wire            ex1_dest_l16;                        
wire            ex1_dest_l32;                        
wire            ex1_dest_l64;                        
wire            ex1_dest_l8;                         
wire            ex1_dest_si;                         
wire            ex1_dest_single;                     
wire            ex1_dest_widden;                     
wire    [63:0]  ex1_double_src;                      
wire    [63:0]  ex1_final_norm_frac;                 
wire    [5 :0]  ex1_float_shift_bit;                 
wire    [63:0]  ex1_float_src_tail;                  
wire    [63:0]  ex1_ftoi_int;                        
wire            ex1_h_quod_up;                       
wire    [15:0]  ex1_half0_src;                       
wire    [5 :0]  ex1_itof_shift_bit;                  
wire            ex1_l16_0_src_neg;                   
wire            ex1_l32_0_src_neg;                   
wire            ex1_l64_0_src_neg;                   
wire    [7 :0]  ex1_l8_0_src;                        
wire    [5 :0]  ex1_left_shift_bit;                  
wire            ex1_narrow;                          
wire    [63:0]  ex1_norm_neg_src;                    
wire    [63:0]  ex1_norm_src;                        
wire            ex1_op_bhtod;                        
wire            ex1_op_bhtos;                        
wire            ex1_op_dtobh;                        
wire            ex1_op_dtoh;                         
wire            ex1_op_dtos;                         
wire            ex1_op_ftoi;                         
wire            ex1_op_htod;                         
wire            ex1_op_htos;                         
wire            ex1_op_itof;                         
wire            ex1_op_stobh;                        
wire            ex1_op_stod;                         
wire            ex1_op_stoh;                         
wire            ex1_quod_dn;                         
wire            ex1_quod_up;                         
wire            ex1_same;                            
wire            ex1_sign;                            
wire    [31:0]  ex1_single0_src;                     
wire    [3 :0]  ex1_size;                            
wire            ex1_special_vld;                     
wire            ex1_src_bhalf;                       
wire            ex1_src_double;                      
wire            ex1_src_float;                       
wire            ex1_src_half;                        
wire            ex1_src_i;                           
wire            ex1_src_l16;                         
wire            ex1_src_l32;                         
wire            ex1_src_l64;                         
wire            ex1_src_l8;                          
wire            ex1_src_neg;                         
wire            ex1_src_si;                          
wire            ex1_src_single;                      
wire            ex1_widden;                          
wire    [6 :0]  ex2_bhalf0_orig_frac;                
wire            ex2_dest_bhalf;                      
wire            ex2_dest_double;                     
wire            ex2_dest_half;                       
wire            ex2_dest_single;                     
wire    [51:0]  ex2_double_orig_frac;                
wire    [3 :0]  ex2_expt;                            
wire    [63:0]  ex2_frac;                            
wire    [9 :0]  ex2_half0_orig_frac;                 
wire    [63:0]  ex2_int16_0_result;                  
wire    [63:0]  ex2_int32_0_result;                  
wire    [63:0]  ex2_int64_result;                    
wire    [63:0]  ex2_int_r;                           
wire    [63:0]  ex2_l16_0_result;                    
wire    [63:0]  ex2_l32_0_result;                    
wire    [63:0]  ex2_scalar_int_result;               
wire    [63:0]  ex2_scalar_total_result;             
wire    [63:0]  ex2_shift_src;                       
wire    [22:0]  ex2_single0_orig_frac;               
wire    [63:0]  ex2_total_result;                    
wire    [63:0]  ex3_double_result;                   
wire            fcnvt_ex1_pipe_clk;                  
wire            fcnvt_ex1_pipedown;                  
wire            fcnvt_ex2_pipe_clk;                  
wire            fcnvt_ex2_pipedown;                  
wire    [23:0]  ff1_16_bit;                          
wire    [13:0]  ff1_32_bit;                          
wire    [7 :0]  ff1_64_bit;                          
wire    [39:0]  ff1_8_bit;                           
wire    [63:0]  ff1_src_in;                          
wire    [15:0]  half0_final_frac;                    
wire    [63:0]  half0_for_ff1;                       
wire    [15:0]  half0_frac_for_shift;                
wire    [5 :0]  htox_shift_bit;                      
wire    [5 :0]  i16tof_shift_bit;                    
wire    [5 :0]  i32tof_shift_bit;                    
wire    [5 :0]  i64tof_shift_bit;                    
wire            ifu_vpu_warm_up;                     
wire    [63:0]  int_src_for_shift;                   
wire    [15:0]  l16_0_itof_value;                    
wire    [15:0]  l16_0_shift_out_val;                 
wire    [15:0]  l16_1_shift_out_val;                 
wire    [15:0]  l16_2_shift_out_val;                 
wire    [15:0]  l16_3_shift_out_val;                 
wire    [31:0]  l32_0_itof_value;                    
wire    [31:0]  l32_0_shift_out_val;                 
wire    [31:0]  l32_1_shift_out_val;                 
wire    [63:0]  l64_int_abs_val;                     
wire    [63:0]  l64_itof_value;                      
wire    [63:0]  l64_shift_out_val;                   
wire    [63:0]  neg_adder_op0;                       
wire    [63:0]  neg_adder_op1;                       
wire    [63:0]  neg_result;                          
wire            shift_16;                            
wire    [2 :0]  shift_src_size;                      
wire    [31:0]  single0_final_frac;                  
wire            src0_double_id;                      
wire            src0_double_inf;                     
wire            src0_double_qnan;                    
wire            src0_double_snan;                    
wire            src0_double_zero;                    
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
wire    [47:0]  srcv0_type;                          
wire    [5 :0]  stod_shift_bit;                      
wire    [63:0]  vfcvt_vpu_ex2_gpr_result;            
wire    [4 :0]  vfcvt_vpu_ex3_fflags;                
wire    [63:0]  vfcvt_vpu_ex3_fpr_result;            
wire    [19:0]  vpu_group_1_xx_ex1_func;             
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;            
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;       
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;            

//cnvt

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+


//--------------------------------------------
//                    Interface with idu :
//--------------------------------------------
// &Force("output","ex1_dest_si"); @41
// &Force("output","ex1_src_l64"); @42
// &Force("output","ex1_src_l32"); @43
// &Force("output","ex1_src_l16"); @44
// &Force("output","ex1_src_l8"); @45
// //&Force("output","ex1_dest_double"); @46
// &Force("output","ex1_dest_single"); @47
// &Force("output","ex1_dest_float"); @48
// &Force("output","ex1_op_ftoi"); @49
// &Force("bus","vpu_group_1_xx_ex1_func",19,0); @50
assign ex1_op_ftoi    = !vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3];
assign ex1_op_stod    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[6] && ex1_src_l32;
assign ex1_op_dtos    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[5] && ex1_src_l64;
assign ex1_op_htos    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[6] && ex1_src_l16&& !cp0_vpu_xx_bf16; 
assign ex1_op_bhtos    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[6] && ex1_src_l16&& cp0_vpu_xx_bf16;                        
assign ex1_op_stoh    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[5] && ex1_src_l32 && !cp0_vpu_xx_bf16;
assign ex1_op_stobh    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[5] && ex1_src_l32 && cp0_vpu_xx_bf16;
                        
assign ex1_op_itof    = vpu_group_1_xx_ex1_func[1] && !vpu_group_1_xx_ex1_func[3];
assign ex1_op_bhtod   = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[8] && ex1_src_bhalf;
assign ex1_op_htod   = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[8] && ex1_src_half;
assign ex1_op_dtoh    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[7] && ex1_src_l64 && !cp0_vpu_xx_bf16;
assign ex1_op_dtobh    = vpu_group_1_xx_ex1_func[1] && vpu_group_1_xx_ex1_func[3] &&
                        vpu_group_1_xx_ex1_func[7] && ex1_src_l64 && cp0_vpu_xx_bf16;

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+
assign cur_l64        = vpu_group_1_xx_ex1_func[13:12] == 2'b11;
assign cur_l32        = vpu_group_1_xx_ex1_func[13:12] == 2'b10;
assign cur_l16        = vpu_group_1_xx_ex1_func[13:12] == 2'b01;
assign cur_l8         = vpu_group_1_xx_ex1_func[13:12] == 2'b00;
assign ex1_narrow     = vpu_group_1_xx_ex1_func[5];
assign ex1_same       = vpu_group_1_xx_ex1_func[4];
assign ex1_quod_up    = vpu_group_1_xx_ex1_func[8];
assign ex1_quod_dn    = vpu_group_1_xx_ex1_func[7];

assign ex1_dest_si    = vpu_group_1_xx_ex1_func[1:0] == 2'b00;
assign ex1_dest_widden= vpu_group_1_xx_ex1_func[6];
//assign ex1_dest_quod  = vpu_group_1_xx_ex1_func[8];
assign ex1_src_l64    = cur_l64 && ex1_same   ||
                        cur_l32 && ex1_narrow ||
                        cur_l16 && ex1_quod_dn;
assign ex1_src_l32    = cur_l32 && (ex1_same || ex1_widden)  ||
                        cur_l16 && ex1_narrow;
assign ex1_src_l16    = cur_l16 && (ex1_same || ex1_widden || ex1_quod_up)|| cur_l8  &&ex1_narrow;
assign ex1_src_l8     = cur_l8  && ex1_widden;

assign ex1_src_double = ex1_src_l64 && vpu_group_1_xx_ex1_func[3];
assign ex1_src_single = ex1_src_l32 && vpu_group_1_xx_ex1_func[3];
assign ex1_src_half   = ex1_src_l16 && vpu_group_1_xx_ex1_func[3] && !cp0_vpu_xx_bf16;
assign ex1_src_bhalf  = ex1_src_l16 && vpu_group_1_xx_ex1_func[3] && cp0_vpu_xx_bf16;

assign ex1_h_quod_up  = ex1_quod_up && !cp0_vpu_xx_bf16;
assign ex1_bh_quod_up = ex1_quod_up && cp0_vpu_xx_bf16;
// &Force("output","ex1_src_double"); @106
// &Force("output","ex1_src_single"); @107
// &Force("output","ex1_src_half"); @108
// &Force("output","ex1_src_bhalf"); @109
// &Force("output","ex1_src_si"); @110
assign ex1_src_float  = vpu_group_1_xx_ex1_func[3];
assign ex1_dest_float = vpu_group_1_xx_ex1_func[1];

assign ex1_src_si     = !vpu_group_1_xx_ex1_func[3] && !vpu_group_1_xx_ex1_func[2];
assign ex1_src_i      = !vpu_group_1_xx_ex1_func[3];
// &Force("output","ex1_src_i"); @116

assign ex1_dest_l64    = cur_l64 && ex1_same   ||
                         cur_l32 && ex1_widden ||
                         cur_l16 && ex1_quod_up;
assign ex1_dest_l32    = cur_l32 && (ex1_same || ex1_narrow)  ||
                         cur_l16 && ex1_widden;
assign ex1_dest_l16    = cur_l16 && (ex1_same || ex1_narrow || ex1_quod_dn)  ||
                         cur_l8 && ex1_widden;
assign ex1_dest_l8     = cur_l8  && ex1_narrow;

assign ex1_dest_double  = ex1_dest_l64;
assign ex1_dest_single  = ex1_dest_l32;
assign ex1_dest_half    = ex1_dest_l16 && !cp0_vpu_xx_bf16;
assign ex1_dest_bhalf   = ex1_dest_l16 && cp0_vpu_xx_bf16;
// &Force("output","ex1_dest_bhalf"); @131
// &Force("output","ex1_dest_half"); @132

// &Force("output","ex1_op_bhtod"); @134
// &Force("output","ex1_op_htod"); @135
// &Force("output","ex1_op_htos"); @136
// //&Force("output","ex1_op_itof"); @137
// &Force("output","ex1_op_stod"); @138

assign srcv0_type[47:0]          = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign src0_double_snan    = srcv0_type[47];
assign src0_double_qnan    = srcv0_type[46];
assign src0_double_inf    = srcv0_type[45];
assign src0_double_zero    = srcv0_type[44];
assign src0_double_id    = srcv0_type[43];
//assign src0_double_norm    = srcv0_type[42];
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
assign src0_half0_inf     = srcv0_type[24];
assign src0_half0_zero    = srcv0_type[23];
assign src0_half0_id    = srcv0_type[22];
//assign src0_half0_norm    = srcv0_type[21];

assign cnvt_src0_half0_inf   = src0_half0_inf;
assign cnvt_src0_half0_snan  = src0_half0_snan;
assign cnvt_src0_half0_qnan  = src0_half0_qnan;
assign cnvt_src0_half0_zero  = src0_half0_zero;
assign cnvt_src0_half0_id    = src0_half0_id;


assign double_pipe_ex1_src_inf      = ex1_src_double && src0_double_inf 
                                      || ex1_src_single && src0_single0_inf 
                                      || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_inf;
assign double_pipe_ex1_src_qnan     = ex1_src_double && src0_double_qnan 
                                      || ex1_src_single && src0_single0_qnan 
                                      || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_qnan;


assign double_pipe_ex1_src_cnan     = ex1_src_single && src0_single0_cnan || (ex1_src_half || ex1_src_bhalf) && src0_half0_cnan;
assign double_pipe_ex1_src_snan     = ex1_src_double && src0_double_snan || ex1_src_single && src0_single0_snan || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_snan;
assign double_pipe_ex1_src_zero     = ex1_src_double && src0_double_zero || ex1_src_single && src0_single0_zero || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_zero;


assign double_pipe_src_dn            = ex1_src_double && src0_double_id  || 
                                       ex1_src_single && src0_single0_id ||
                                       (ex1_src_half||ex1_src_bhalf)   && cnvt_src0_half0_id; 

//assign half_pipe0_src_dn             = dp_xx_ex1_id;
//assign half_pipe1_src_dn             = dp_xx_ex1_id;

assign ex1_norm_src[63:0]            = ex1_src_i ? vpu_group_1_xx_ex1_srcv1[63:0] : vpu_group_1_xx_ex1_srcv0[63:0];
//assign ex1_split_odd                 = vpu_group_1_xx_ex1_split_count[0] && !ex1_scalar;

// &Force("bus","vpu_group_1_xx_ex1_split_count",7,0); @192

assign ex1_double_src[63:0]     = ex1_norm_src[63:0];
assign ex1_single0_src[31:0]    = ex1_norm_src[31:0];
assign ex1_half0_src[15:0]      = ex1_norm_src[15:0];
                                                                 

//assign l8_src[31:0]             = ex1_dest_widden && ex1_split_odd ? ex1_norm_src[63:32] 
//                                                                   : ex1_norm_src[31:0];
assign ex1_l8_0_src[7:0]        = 8'b0;
//assign ex1_l8_0_src[7:0]        = l8_src[7:0];   
//assign ex1_l8_1_src[7:0]        = l8_src[15:8];   
//assign ex1_l8_2_src[7:0]        = l8_src[23:16];   
//assign ex1_l8_3_src[7:0]        = l8_src[31:24];   
// &Force("output","ex1_double_src"); @206
// &Force("output","ex1_single0_src"); @207
// //&Force("output","ex1_single1_src"); @208
// &Force("output","ex1_half0_src"); @209
//================================================
//  mask prepare
//================================================
assign ex1_widden                  = ex1_dest_widden;
//assign ex1_org_mask[7:0]           = vpu_group_1_xx_ex1_vm_byte_mask[7:0] &
//                                     vpu_group_1_xx_ex1_vl_byte_mask[7:0];
//assign ex1_vl_mask[7:0]            = vpu_group_1_xx_ex1_vl_byte_mask[7:0];
//&Instance("aq_falu_mask_prepare");
// //&Connect(.ex1_split_odd  (ex1_split_odd), @218
// //         .ex1_widden     (ex1_widden   ), @219
// //         .vmask          (ex1_org_mask ), @220
// //         .vl_dest_mask   (ex1_vl_mask  ), @221
// //         .ex1_final_mask (ex1_pre_mask ), @222
// //         .ex1_dest_mask  (ex1_dst_mask ), @223
// //         .ex1_l8        (ex1_src_l8  ), @224
// //         .ex1_narrow    (ex1_narrow) @225
// //        ); @226
//
//
//assign ex1_exe_mask[3:0]        = ex1_pre_mask[3:0];
//================================================
// ftoi logic
//================================================
//assign ex1_double_ftoi_trans[52:0] = {1'b1,ex1_norm_src[51:0]};
//assign ex1_single0_ftoi_trans[23:0] = {1'b1,ex1_norm_src[22:0]};
//assign ex1_single1_ftoi_trans[23:0] = {1'b1,ex1_norm_src[54:32]};
//assign ex1_half0_ftoi_trans[10:0] = {1'b1,ex1_norm_src[9:0]};
//assign ex1_half1_ftoi_trans[10:0] = {1'b1,ex1_norm_src[25:16]};
//assign ex1_half2_ftoi_trans[10:0] = {1'b1,ex1_norm_src[41:32]};
//assign ex1_half3_ftoi_trans[10:0] = {1'b1,ex1_norm_src[57:48]};
//assign ex1_bhalf0_ftoi_trans[7:0] = {1'b1,ex1_norm_src[6:0]};
//assign ex1_bhalf1_ftoi_trans[7:0] = {1'b1,ex1_norm_src[22:16]};
//assign ex1_bhalf2_ftoi_trans[7:0] = {1'b1,ex1_norm_src[38:32]};
//assign ex1_bhalf3_ftoi_trans[7:0] = {1'b1,ex1_norm_src[54:48]};
//&Instance("aq_fcnvt_ftoi_shift");
// //&Connect(.ex1_f16(ex1_src_l16), @245
// //         .ex1_double(ex1_src_l64), @246
// //         .ex1_single(ex1_src_l32), @247
// //         .ex1_half(ex1_src_half), @248
// //         .ex1_bhalf(ex1_src_bhalf), @249
// //        ); @250
//assign double_ftoi_int_in[127:0] = shift_64_result[127:0];
//assign single0_ftoi_int_in[63:0] = shift_32_result_1[63:0];
//assign single1_ftoi_int_in[63:0] = shift_32_result_0[63:0];
//assign half0_ftoi_int_in[31:0]   = shift_16_result_3[31:0];
//assign half1_ftoi_int_in[31:0]   = shift_16_result_2[31:0];
//assign half2_ftoi_int_in[31:0]   = shift_16_result_1[31:0];
//assign half3_ftoi_int_in[31:0]   = shift_16_result_0[31:0];
//================================================
// ff1 logic
//================================================

assign ex1_sign                 =   ex1_op_itof && ex1_src_si;
assign ex1_size                 =  {ex1_src_l64,ex1_src_l32,ex1_src_l16,ex1_src_l8};
assign ff1_src_in[63:0]         =   ex1_op_itof ? ex1_norm_src[63:0]
                                                : ex1_float_src_tail[63:0];
assign half0_frac_for_shift[15:0]   = {ex1_norm_src[9:0],6'b0};                                             
//assign half1_frac_for_shift[15:0]   = {ex1_norm_src[25:16],6'b0};                                             
//assign half2_frac_for_shift[15:0]   = {ex1_norm_src[41:32],6'b0};                                             
//assign half3_frac_for_shift[15:0]   = {ex1_norm_src[57:48],6'b0};  
assign bhalf0_frac_for_shift[15:0]  = {ex1_norm_src[6:0],9'b0};                                             
//assign bhalf1_frac_for_shift[15:0]  = {ex1_norm_src[22:16],6'b0};                                             
//assign bhalf2_frac_for_shift[15:0]  = {ex1_norm_src[38:32],6'b0};                                             
//assign bhalf3_frac_for_shift[15:0]  = {ex1_norm_src[54:48],6'b0};
assign half0_for_ff1[63:0]          = {48'b0,half0_frac_for_shift[15:0]};
assign bhalf0_for_ff1[63:0]         = {48'b0,bhalf0_frac_for_shift[15:0]};
assign ex1_float_src_tail[63:0]     = {64{ex1_src_l32}}   & {32'b0,ex1_norm_src[22:0],9'b0} |
                                      {64{ex1_src_half}}  & {half0_for_ff1[63:0]}           |
                                      {64{ex1_src_bhalf}} & {bhalf0_for_ff1[63:0]};
// here we will repack the shift value for widden: htox 
//assign half_widden_for_ff1_shift[63:0]  = ex1_split_odd ? {32'b0,half3_frac_for_shift[15:0],half2_frac_for_shift[15:0]}
//                                                        : {32'b0,half1_frac_for_shift[15:0],half0_frac_for_shift[15:0]};
//assign ex1_float_for_shift[63:0]        = {64{ex1_op_stod}}  & {32'b0,ex1_norm_src[22:0],9'b0}   | 
//                                          {64{ex1_op_htos||
//                                              ex1_op_htod}}  & half_widden_for_ff1_shift[63:0]   |
//                                          {64{ex1_op_bhtod}} & bhalf0_for_ff1[63:0];

// &Instance("aq_vdsp_64_bit_ff1"); @287
aq_vdsp_64_bit_ff1  x_aq_vdsp_64_bit_ff1 (
  .ex1_sign   (ex1_sign  ),
  .ex1_size   (ex1_size  ),
  .ex1_src    (ff1_src_in),
  .ff1_16_bit (ff1_16_bit),
  .ff1_32_bit (ff1_32_bit),
  .ff1_64_bit (ff1_64_bit),
  .ff1_8_bit  (ff1_8_bit )
);

// &Connect(.ex1_sign   (ex1_sign     ), @288
//          .ex1_size   (ex1_size     ), @289
//          .ex1_src    (ff1_src_in   ), @290
//         ); @291
//assign  i16tof_widden_shift_bit[5:0] = {2'b0,ff1_16_bit[3:0]};
assign  i16tof_shift_bit[5:0]        = {2'b0,ff1_16_bit[3:0]};
assign  i32tof_shift_bit[5:0]        = {1'b0,ff1_32_bit[4:0]};
// &Force("nonport","ff1_8_bit"); @295
//assign  i8tof_shift_bit[15:0]         = ex1_split_odd ? {ff1_8_bit[38:35],ff1_8_bit[33:30],ff1_8_bit[28:25],ff1_8_bit[23:20]}
//                                                      : {ff1_8_bit[18:15],ff1_8_bit[13:10],ff1_8_bit[8:5],ff1_8_bit[3:0]};

assign  i64tof_shift_bit[5:0]        = {ff1_64_bit[5:0]};
assign  ex1_itof_shift_bit[5:0]      = {6{ex1_src_l64}} & i64tof_shift_bit[5:0] |
                                       {6{ex1_src_l32}} & i32tof_shift_bit[5:0] |
                                       {6{ex1_src_l16}} & i16tof_shift_bit[5:0];// |
//                                        {16{ex1_src_l8}}  & i8tof_shift_bit[15:0];
assign  stod_shift_bit[5:0]          = {1'b0,ff1_32_bit[4:0]};
assign double_pipe_stod_expnt[4:0]    = stod_shift_bit[4:0];
// for htox , it is widden or quod up 
assign  htox_shift_bit[5:0]          = {2'b0,ff1_16_bit[3:0]};

assign bhtod_shift_bit[5:0]          = {2'b0,ff1_16_bit[3:0]};
assign ex1_float_shift_bit[5:0]      = {6{ex1_op_stod}} & stod_shift_bit[5:0] |
                                       {6{ex1_op_htos||
                                          ex1_op_htod}}  & htox_shift_bit[5:0]   |
                                       {6{ex1_op_bhtod}} & bhtod_shift_bit[5:0];
assign double_pipe_bhtox_expnt[4:0]   = {1'b0,bhtod_shift_bit[3:0]};
assign double_pipe_htox_expnt[4:0]    = {1'b0,htox_shift_bit[3:0]};
//assign single_pipe_htos_expnt[4:0]    = {1'b0,htox_shift_bit[11:8]};
 // combin the shift and pipe to ex2 stage                                           
assign ex1_left_shift_bit[5:0]       = ex1_op_itof ? ex1_itof_shift_bit[5:0]
                                                   : ex1_float_shift_bit[5:0];
// for the itof negative num, the neg and add1
assign ex1_norm_neg_src[63:0]  = ~ex1_norm_src[63:0];
assign neg_adder_op0[63:0]     = {64{ex1_src_l64}} & {ex1_norm_neg_src[63:0]} | 
                                 {64{ex1_src_l32}} & {{32{ex1_norm_neg_src[31]}},ex1_norm_neg_src[31:0]} |
                                 {64{ex1_src_l16}} & {{48{ex1_norm_neg_src[15]}},ex1_norm_neg_src[15:0]};
assign neg_adder_op1[63:0]     = 64'b1;
// the negative adder 
assign neg_result[63:0]        = neg_adder_op0[63:0] + neg_adder_op1[63:0];
//assign i8_neg_result[63:0]     = ex1_split_odd ? {neg_result[70:63],8'b0,neg_result[61:54],8'b0,neg_result[52:45],8'b0,neg_result[43:36],8'b0}
//                                               : {neg_result[34:27],8'b0,neg_result[25:18],8'b0,neg_result[16:9],8'b0,neg_result[7:0],8'b0};
//assign i8_norm_src[63:0]       = ex1_split_odd ? {ex1_norm_src[63:56],8'b0,ex1_norm_src[55:48],8'b0,ex1_norm_src[47:40],8'b0,ex1_norm_src[39:32],8'b0}
//                                               : {ex1_norm_src[31:24],8'b0,ex1_norm_src[23:16],8'b0,ex1_norm_src[15:8],8'b0,ex1_norm_src[7:0],8'b0};
assign ex1_l64_0_src_neg       = ex1_norm_src[63] && ex1_src_si;
assign ex1_l32_0_src_neg       = ex1_norm_src[31] && ex1_src_si;
assign ex1_l16_0_src_neg       = ex1_norm_src[15] && ex1_src_si;
assign ex1_src_neg             = ex1_src_l64 && ex1_l64_0_src_neg ||
                                 ex1_src_l32 && ex1_l32_0_src_neg ||
                                 ex1_src_l16 && ex1_l16_0_src_neg;
//assign ex1_l16_1_src_neg       = ex1_norm_src[31] && ex1_src_si;
//assign ex1_l16_2_src_neg       = ex1_norm_src[47] && ex1_src_si;
//assign ex1_l16_3_src_neg       = ex1_norm_src[63] && ex1_src_si;
//assign ex1_l8_0_src_neg        = ex1_split_odd ? ex1_norm_src[39] && ex1_src_si : ex1_norm_src[7] && ex1_src_si;
//assign ex1_l8_1_src_neg        = ex1_split_odd ? ex1_norm_src[47] && ex1_src_si : ex1_norm_src[15] && ex1_src_si;
//assign ex1_l8_2_src_neg        = ex1_split_odd ? ex1_norm_src[55] && ex1_src_si : ex1_norm_src[23] && ex1_src_si;
//assign ex1_l8_3_src_neg        = ex1_split_odd ? ex1_norm_src[63] && ex1_src_si : ex1_norm_src[31] && ex1_src_si;

assign l64_int_abs_val[63:0]   = ex1_src_neg ? neg_result[63:0]  : ex1_norm_src[63:0];
//assign l32_0_int_abs_val[31:0] = ex1_l32_0_src_neg ? neg_result[31:0]  : ex1_norm_src[31:0];
//assign l32_1_int_abs_val[31:0] = ex1_l32_1_src_neg ? neg_result[67:36] : ex1_norm_src[63:32];

//assign l32_int_abs_val[63:0]   = {,l32_0_int_abs_val[31:0]};
//assign l16_0_int_abs_val[15:0] = ex1_l16_0_src_neg ? neg_result[15:0]  : ex1_norm_src[15:0];
//assign l16_1_int_abs_val[15:0] = ex1_l16_1_src_neg ? neg_result[33:18] : ex1_norm_src[31:16];
//assign l16_2_int_abs_val[15:0] = ex1_l16_2_src_neg ? neg_result[51:36] : ex1_norm_src[47:32];
//assign l16_3_int_abs_val[15:0] = ex1_l16_3_src_neg ? neg_result[69:54] : ex1_norm_src[63:48];
//assign l16_int_widden_abs_val[63:0] = ex1_split_odd ? {16'b0,l16_3_int_abs_val[15:0],16'b0,l16_2_int_abs_val[15:0]}
//                                                    : {16'b0,l16_1_int_abs_val[15:0],16'b0,l16_0_int_abs_val[15:0]};
//assign l16_int_abs_val[63:0]   = ex1_widden ? l16_int_widden_abs_val[63:0] 
//                                            : {l16_3_int_abs_val[15:0],l16_2_int_abs_val[15:0],
//                                               l16_1_int_abs_val[15:0],l16_0_int_abs_val[15:0]};
//
//assign l8_0_int_abs_val[15:0]  = ex1_l8_0_src_neg ? i8_neg_result[15:0]  : i8_norm_src[15:0];
//assign l8_1_int_abs_val[15:0]  = ex1_l8_1_src_neg ? i8_neg_result[31:16] : i8_norm_src[31:16];
//assign l8_2_int_abs_val[15:0]  = ex1_l8_2_src_neg ? i8_neg_result[47:32] : i8_norm_src[47:32];
//assign l8_3_int_abs_val[15:0]  = ex1_l8_3_src_neg ? i8_neg_result[63:48] : i8_norm_src[63:48];
//
//assign l8_int_abs_val[63:0]    = {l8_3_int_abs_val[15:0],l8_2_int_abs_val[15:0],l8_1_int_abs_val[15:0],l8_0_int_abs_val[15:0]};
// the itof abs value
assign int_src_for_shift[63:0] = l64_int_abs_val[63:0];

//assign ex1_shift_float_src[63:0] = ex1_op_itof ? int_src_for_shift[63:0] 
//                                               : ex1_float_for_shift[63:0];


assign ex1_ftoi_int[63:0]       = double_pipe_ftoi_int[63:0];
// the fraction, the normal f resutl and the value that need shift fraction
// will combined into this flop
assign ex1_final_norm_frac[63:0] = {64{ex1_dest_double}} & double_final_frac[63:0]   |
                                   {64{ex1_dest_single}} & {32'b0,single0_final_frac[31:0]} |
                                   {64{ex1_dest_half}}   & {48'b0,half0_final_frac[15:0]}   |
                                   {64{ex1_dest_bhalf}}  & {48'b0,bhalf0_final_frac[15:0]};

//assign ex1_combined_src[67:0]   = ex1_op_ftoi ? ex1_ftoi_int[67:0] :
//                                  ex1_op_itof ? {4'b0,int_src_for_shift[63:0]} 
//                                              : {4'b0,ex1_final_norm_frac[63:0]};
assign ex1_combined_src[63:0]   = ex1_op_itof ? {int_src_for_shift[63:0]} 
                                              : {ex1_final_norm_frac[63:0]};                                            
assign ex1_special_vld        = double_pipe_ex1_special_vld;
always @(posedge fcnvt_ex1_pipe_clk)
begin
  if(fcnvt_ex1_pipedown && ex1_op_ftoi || ifu_vpu_warm_up) begin
    //ex2_combin_src[67:0] <= ex1_combined_src[67:0];
    ex2_combin_src[63:0] <= ex1_ftoi_int[63:0];
  end
end
assign ex2_int_r[63:0]  = ex2_combin_src[63:0];
assign ex2_frac[63:0]   =  ex2_comb_frac[63:0];
assign ex2_shift_src[63:0] = ex2_comb_frac[63:0];


always @(posedge fcnvt_ex1_pipe_clk)
begin
  if(fcnvt_ex1_pipedown && (ex1_dest_float|| ex1_special_vld) || ifu_vpu_warm_up) begin
    //ex2_frac[63:0]           <= ex1_final_norm_frac[63:0];
   //ex2_shift_src[63:0]      <= int_src_for_shift[63:0];
    ex2_comb_frac[63:0]      <= ex1_combined_src[63:0];
    ex2_left_shift_bit[5:0] <= ex1_left_shift_bit[5:0];
  end
end
always @(posedge fcnvt_ex1_pipe_clk)
begin 
  if(fcnvt_ex1_pipedown || ifu_vpu_warm_up) begin
    ex2_narrow      <= ex1_narrow;
    ex2_widden      <= ex1_widden;
    ex2_quod_dn     <= ex1_quod_dn;
    ex2_h_quod_up   <= ex1_h_quod_up;
    ex2_bh_quod_up  <= ex1_bh_quod_up;
    ex2_op_itof     <= ex1_op_itof;
    ex2_src_l64     <= ex1_src_l64;
    ex2_src_l32     <= ex1_src_l32;
    ex2_src_l16     <= ex1_src_l16;
    ex2_src_l8      <= ex1_src_l8;
    ex2_dest_l64    <= ex1_dest_l64;
    ex2_dest_l32    <= ex1_dest_l32;
    ex2_dest_l16    <= ex1_dest_l16;
    ex2_dest_bhalf_flop  <= ex1_dest_bhalf;
    ex2_dest_l8     <= ex1_dest_l8;
    ex2_dest_float  <= ex1_dest_float;
    ex2_dest_si     <= ex1_dest_si;
  end
end

//=============================================
//
// ex2 stage
//=============================================
// &Force("output","ex2_narrow"); @436
// &Force("output","ex2_dest_bhalf"); @437
// &Force("output","ex2_dest_double"); @438
// &Force("output","ex2_dest_float"); @439
// &Force("output","ex2_dest_half"); @440
// &Force("output","ex2_dest_single"); @441
// &Force("nonport","ex2_dst_mask"); @442
// &Force("output","ex2_dest_l64"); @443
// &Force("output","ex2_dest_l32"); @444
// &Force("output","ex2_dest_l16"); @445
// &Force("output","ex2_dest_l8"); @446
// &Force("output","ex2_op_itof"); @447
//ff1 itof expnt                                        
assign double_pipe_ex2_itof_expnt[5:0]= ex2_left_shift_bit[5:0];
assign double_pipe_ex2_xtod_expnt[5:0]= {1'b0,ex2_left_shift_bit[4:0]};
assign double_pipe_ex2_widden_dn_itof_expnt[5:0] = ex2_op_itof ? double_pipe_ex2_itof_expnt[5:0]
                                                               : double_pipe_ex2_xtod_expnt[5:0];
                                        

assign ex2_dest_double              =  ex2_dest_l64 && ex2_dest_float;
assign ex2_dest_single              =  ex2_dest_l32 && ex2_dest_float;
assign ex2_dest_half                =  ex2_dest_l16 && ex2_dest_float && !ex2_dest_bhalf;
assign ex2_dest_bhalf               =   ex2_dest_float && ex2_dest_bhalf_flop;


//assign ex2_half                     = ex2_dest_l16 && ex2_dest_float;
assign double_pipe_ex2_int[63:0]    = ex2_int_r[63:0];

assign double_pipe_ex2_frac[63:0]    = ex2_frac[63:0];
//assign half_pipe0_ex2_frac[15:0]     = ex2_frac[31:16];
//assign half_pipe1_ex2_frac[15:0]     = ex2_frac[63:48];

assign ex2_double_orig_frac[51:0]    = ex2_frac[51:0];
assign ex2_single0_orig_frac[22:0]   = ex2_frac[22:0];

assign ex2_half0_orig_frac[9:0]     = ex2_frac[9:0];
assign ex2_bhalf0_orig_frac[6:0]    = ex2_frac[6:0];

//=====================================================
// ex2 shift :
// itof shift
// stod shift
// htox shift
//=====================================================
assign shift_16             = ex2_src_l16||ex2_src_l8;
assign shift_src_size[2:0]  = {ex2_src_l64,ex2_src_l32,shift_16};
// &Force("output","ex2_src_l64"); @482
// &Force("output","ex2_src_l32"); @483
// &Force("output","ex2_src_l16"); @484

// &Instance("aq_left_shift_64"); @486
aq_left_shift_64  x_aq_left_shift_64 (
  .input_l16_0_shift_cnt   (ex2_left_shift_bit[3:0]),
  .input_l16_1_shift_cnt   (4'b0                   ),
  .input_l16_2_shift_cnt   (4'b0                   ),
  .input_l16_3_shift_cnt   (4'b0                   ),
  .input_l32_0_shift_cnt   (ex2_left_shift_bit[4:0]),
  .input_l32_1_shift_cnt   (5'b0                   ),
  .input_l64_shift_cnt     (ex2_left_shift_bit[5:0]),
  .input_org_src           (ex2_shift_src          ),
  .input_size              (shift_src_size[2:0]    ),
  .l16_0_shift_out_val     (l16_0_shift_out_val    ),
  .l16_1_shift_out_val     (l16_1_shift_out_val    ),
  .l16_2_shift_out_val     (l16_2_shift_out_val    ),
  .l16_3_shift_out_val     (l16_3_shift_out_val    ),
  .l32_0_shift_out_val     (l32_0_shift_out_val    ),
  .l32_1_shift_out_val     (l32_1_shift_out_val    ),
  .l64_shift_out_val       (l64_shift_out_val      )
);

// &Connect ( @487
//           .input_l16_0_shift_cnt(ex2_left_shift_bit[3:0]  ), @488
//           .input_l16_1_shift_cnt(4'b0 ), @489
//           .input_l16_2_shift_cnt(4'b0 ), @490
//           .input_l16_3_shift_cnt(4'b0), @491
//           .input_l32_0_shift_cnt(ex2_left_shift_bit[4:0]  ), @492
//           .input_l32_1_shift_cnt(5'b0 ), @493
//           .input_l64_shift_cnt  (ex2_left_shift_bit[5:0]  ), @494
//           .input_org_src        (ex2_shift_src            ), @495
//           .input_size           (shift_src_size[2:0]      ) @496
//          ); @497
assign l64_itof_value[63:0]   = l64_shift_out_val[63:0];
assign l32_0_itof_value[31:0] = l32_0_shift_out_val[31:0];
assign l16_0_itof_value[15:0] = l16_0_shift_out_val[15:0];
 
assign double_pipe_stod_value[21:0] = l32_0_shift_out_val[30:9];
assign double_pipe_htox_value[8:0]  = l16_0_shift_out_val[14:6];
assign double_pipe_bhtod_value[5:0] = l16_0_shift_out_val[14:9];

// &Force("nonport","l16_1_shift_out_val"); @506
// &Force("nonport","l16_2_shift_out_val"); @507
// &Force("nonport","l16_3_shift_out_val"); @508
// &Force("nonport","l32_1_shift_out_val"); @509

// //&Force("nonport","l16_1_itof_value"); @511
// //&Force("nonport","l16_2_itof_value"); @512
// //&Force("nonport","l16_3_itof_value"); @513
// //&Force("nonport","l32_1_itof_value"); @514
// //&Force("nonport","double_pipe_stod_value"); @515
// //&Force("nonport","double_pipe_htox_value"); @516
// //&Force("nonport","double_pipe_bhtox_value"); @517
// //&Force("nonport","single_pipe_htox_value"); @518

//ex2_round_adder
//assign ex2_double_for_rnd[52:0]    = ex2_op_itof ? l64_itof_value[63:11] : ex2_frac[52:0];
//assign ex2_single0_for_rnd[23:0]   = ex2_op_itof ? l32_0_itof_value[31:8] : ex2_frac[23:0];
//assign ex2_single1_for_rnd[23:0]   = ex2_op_itof ? l32_1_itof_value[31:8] : ex2_frac[55:32];
//assign ex2_half0_for_rnd[10:0]     = ex2_op_itof ? l16_0_itof_value[15:5] : ex2_frac[10:0];
//assign ex2_half1_for_rnd[10:0]     = ex2_op_itof ? l16_1_itof_value[15:5] : ex2_frac[26:16];
//assign ex2_half2_for_rnd[10:0]     = ex2_op_itof ? l16_2_itof_value[15:5] : ex2_frac[42:32];
//assign ex2_half3_for_rnd[10:0]     = ex2_op_itof ? l16_3_itof_value[15:5] : ex2_frac[58:48];
//assign ex2_bhalf0_for_rnd[7:0]     = ex2_op_itof ? l16_0_itof_value[15:8] : ex2_frac[7:0];
//assign ex2_bhalf1_for_rnd[7:0]     = ex2_op_itof ? l16_1_itof_value[15:8] : ex2_frac[23:16];
//assign ex2_bhalf2_for_rnd[7:0]     = ex2_op_itof ? l16_2_itof_value[15:8] : ex2_frac[39:32];
//assign ex2_bhalf3_for_rnd[7:0]     = ex2_op_itof ? l16_3_itof_value[15:8] : ex2_frac[55:48];
//

//assign ex2_l64_rnd_add_op0[63:0]   = ex2_dest_float ? ex2_op_itof ? {l64_itof_value[63:]
//assign ex2_l32_rnd_add_op0[]




assign double_pipe_special_value[63:0]    =  ex2_frac[63:0];




// &Force("input","ex2_l8_0_result"); @545
// &Force("bus","ex2_l8_0_result",7,0); @546
assign ex2_scalar_total_result[63:0]    = //{64{ex2_dest_l64}} & ex2_l64_result[63:0]                |
                                          {64{ex2_dest_l32}} & {ex2_l32_0_result[63:0]} |
                                          {64{ex2_dest_l16}} & {ex2_l16_0_result[63:0]}; 
assign ex2_scalar_int_result[63:0]      = {64{ex2_dest_l64}} & ex2_int64_result[63:0]     |
                                          {64{ex2_dest_l32}} & {ex2_int32_0_result[63:0]} |
                                          {64{ex2_dest_l16}} & {ex2_int16_0_result[63:0]};       
assign vfcvt_vpu_ex2_gpr_result[63:0]   = ex2_scalar_int_result[63:0];
assign ex2_total_result[63:0]           = ex2_scalar_total_result[63:0];    

assign ex2_expt[3:0]                    = double_pipe_ex2_expt[3:0];
always @(posedge fcnvt_ex2_pipe_clk)
begin
  if(fcnvt_ex2_pipedown) begin
    ex3_result[63:0]     <= ex2_total_result[63:0];
  end
end
always @(posedge fcnvt_ex2_pipe_clk)
begin
  if(fcnvt_ex2_pipedown) begin
    ex3_expt[3:0]      <= ex2_expt[3:0];
    ex3_dest_l64       <= ex2_dest_l64;
  end
end

//------------------------------------------------------------------------------
//                                EX2 pipedown to EX3:
//------------------------------------------------------------------------------



assign vfcvt_vpu_ex3_fpr_result[63:0]             = ex3_dest_l64 ? ex3_double_result[63:0] : ex3_result[63:0];
assign vfcvt_vpu_ex3_fflags[4:0]                  = {ex3_expt[3],1'b0,ex3_expt[2:0]};






// &ModuleEnd; @585
endmodule


