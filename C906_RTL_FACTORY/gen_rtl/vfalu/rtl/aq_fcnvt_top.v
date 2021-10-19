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

// &ModuleBeg; @22
module aq_fcnvt_top(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_yy_clk_en,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vfcvt_vpu_ex2_gpr_result,
  vfcvt_vpu_ex3_fflags,
  vfcvt_vpu_ex3_fpr_result,
  vpu_group_1_xx_ex1_eu_sel,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_sel,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1,
  vpu_group_1_xx_ex2_eu_sel,
  vpu_group_1_xx_ex2_rm,
  vpu_group_1_xx_ex2_sel,
  vpu_group_1_xx_ex2_stall,
  vpu_group_1_xx_ex3_stall
);

// &Ports; @23
input           cp0_vpu_icg_en;                      
input           cp0_vpu_xx_bf16;                     
input           cp0_vpu_xx_dqnan;                    
input           cp0_yy_clk_en;                       
input           forever_cpuclk;                      
input           ifu_vpu_warm_up;                     
input           pad_yy_icg_scan_en;                  
input   [9 :0]  vpu_group_1_xx_ex1_eu_sel;           
input   [19:0]  vpu_group_1_xx_ex1_func;             
input           vpu_group_1_xx_ex1_sel;              
input   [63:0]  vpu_group_1_xx_ex1_srcv0;            
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type;       
input   [63:0]  vpu_group_1_xx_ex1_srcv1;            
input   [9 :0]  vpu_group_1_xx_ex2_eu_sel;           
input   [2 :0]  vpu_group_1_xx_ex2_rm;               
input           vpu_group_1_xx_ex2_sel;              
input           vpu_group_1_xx_ex2_stall;            
input           vpu_group_1_xx_ex3_stall;            
output  [63:0]  vfcvt_vpu_ex2_gpr_result;            
output  [4 :0]  vfcvt_vpu_ex3_fflags;                
output  [63:0]  vfcvt_vpu_ex3_fpr_result;            

// &Regs; @24

// &Wires; @25
wire    [15:0]  bhalf0_final_frac;                   
wire            cp0_vpu_icg_en;                      
wire            cp0_vpu_xx_bf16;                     
wire            cp0_vpu_xx_dqnan;                    
wire            cp0_yy_clk_en;                       
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
wire    [5 :0]  double_pipe_ex2_widden_dn_itof_expnt; 
wire    [63:0]  double_pipe_ftoi_int;                
wire    [4 :0]  double_pipe_htox_expnt;              
wire    [8 :0]  double_pipe_htox_value;              
wire    [63:0]  double_pipe_special_value;           
wire            double_pipe_src_dn;                  
wire    [4 :0]  double_pipe_stod_expnt;              
wire    [21:0]  double_pipe_stod_value;              
wire            ex1_dest_bhalf;                      
wire            ex1_dest_float;                      
wire            ex1_dest_half;                       
wire            ex1_dest_si;                         
wire            ex1_dest_single;                     
wire    [63:0]  ex1_double_src;                      
wire    [15:0]  ex1_half0_src;                       
wire    [7 :0]  ex1_l8_0_src;                        
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
wire            ex1_src_bhalf;                       
wire            ex1_src_double;                      
wire            ex1_src_float;                       
wire            ex1_src_half;                        
wire            ex1_src_i;                           
wire            ex1_src_l16;                         
wire            ex1_src_l32;                         
wire            ex1_src_l64;                         
wire            ex1_src_l8;                          
wire            ex1_src_si;                          
wire            ex1_src_single;                      
wire            ex2_bh_quod_up;                      
wire    [6 :0]  ex2_bhalf0_orig_frac;                
wire            ex2_dest_bhalf;                      
wire            ex2_dest_double;                     
wire            ex2_dest_float;                      
wire            ex2_dest_half;                       
wire            ex2_dest_l16;                        
wire            ex2_dest_l32;                        
wire            ex2_dest_l64;                        
wire            ex2_dest_l8;                         
wire            ex2_dest_si;                         
wire            ex2_dest_single;                     
wire    [51:0]  ex2_double_orig_frac;                
wire            ex2_h_quod_up;                       
wire    [9 :0]  ex2_half0_orig_frac;                 
wire    [63:0]  ex2_int16_0_result;                  
wire    [63:0]  ex2_int32_0_result;                  
wire    [63:0]  ex2_int64_result;                    
wire    [63:0]  ex2_l16_0_result;                    
wire    [63:0]  ex2_l32_0_result;                    
wire    [7 :0]  ex2_l8_0_result;                     
wire            ex2_narrow;                          
wire            ex2_op_itof;                         
wire            ex2_quod_dn;                         
wire    [22:0]  ex2_single0_orig_frac;               
wire            ex2_src_l16;                         
wire            ex2_src_l32;                         
wire            ex2_src_l64;                         
wire            ex2_widden;                          
wire    [63:0]  ex3_double_result;                   
wire            fcnvt_ex1_pipe_clk;                  
wire            fcnvt_ex1_pipedown;                  
wire            fcnvt_ex2_pipe_clk;                  
wire            fcnvt_ex2_pipe_double_clk;           
wire            fcnvt_ex2_pipedown;                  
wire            forever_cpuclk;                      
wire    [15:0]  half0_final_frac;                    
wire            ifu_vpu_warm_up;                     
wire    [15:0]  l16_0_itof_value;                    
wire    [31:0]  l32_0_itof_value;                    
wire    [63:0]  l64_itof_value;                      
wire            pad_yy_icg_scan_en;                  
wire    [31:0]  single0_final_frac;                  
wire    [63:0]  vfcvt_vpu_ex2_gpr_result;            
wire    [4 :0]  vfcvt_vpu_ex3_fflags;                
wire    [63:0]  vfcvt_vpu_ex3_fpr_result;            
wire    [9 :0]  vpu_group_1_xx_ex1_eu_sel;           
wire    [19:0]  vpu_group_1_xx_ex1_func;             
wire            vpu_group_1_xx_ex1_sel;              
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;            
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;       
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;            
wire    [9 :0]  vpu_group_1_xx_ex2_eu_sel;           
wire    [2 :0]  vpu_group_1_xx_ex2_rm;               
wire            vpu_group_1_xx_ex2_sel;              
wire            vpu_group_1_xx_ex2_stall;            
wire            vpu_group_1_xx_ex3_stall;            



//&Instance("aq_fcnvt_double");
// &Instance("aq_fcnvt_double"); @29
aq_fcnvt_double  x_aq_fcnvt_double (
  .bhalf0_final_frac                    (bhalf0_final_frac                   ),
  .cp0_vpu_xx_dqnan                     (cp0_vpu_xx_dqnan                    ),
  .double_final_frac                    (double_final_frac                   ),
  .double_pipe_bhtod_value              (double_pipe_bhtod_value             ),
  .double_pipe_bhtox_expnt              (double_pipe_bhtox_expnt             ),
  .double_pipe_ex1_special_vld          (double_pipe_ex1_special_vld         ),
  .double_pipe_ex1_src_cnan             (double_pipe_ex1_src_cnan            ),
  .double_pipe_ex1_src_inf              (double_pipe_ex1_src_inf             ),
  .double_pipe_ex1_src_qnan             (double_pipe_ex1_src_qnan            ),
  .double_pipe_ex1_src_snan             (double_pipe_ex1_src_snan            ),
  .double_pipe_ex1_src_zero             (double_pipe_ex1_src_zero            ),
  .double_pipe_ex2_expt                 (double_pipe_ex2_expt                ),
  .double_pipe_ex2_frac                 (double_pipe_ex2_frac                ),
  .double_pipe_ex2_int                  (double_pipe_ex2_int                 ),
  .double_pipe_ex2_widden_dn_itof_expnt (double_pipe_ex2_widden_dn_itof_expnt),
  .double_pipe_ftoi_int                 (double_pipe_ftoi_int                ),
  .double_pipe_htox_expnt               (double_pipe_htox_expnt              ),
  .double_pipe_htox_value               (double_pipe_htox_value              ),
  .double_pipe_special_value            (double_pipe_special_value           ),
  .double_pipe_src_dn                   (double_pipe_src_dn                  ),
  .double_pipe_stod_expnt               (double_pipe_stod_expnt              ),
  .double_pipe_stod_value               (double_pipe_stod_value              ),
  .ex1_dest_bhalf                       (ex1_dest_bhalf                      ),
  .ex1_dest_float                       (ex1_dest_float                      ),
  .ex1_dest_half                        (ex1_dest_half                       ),
  .ex1_dest_si                          (ex1_dest_si                         ),
  .ex1_dest_single                      (ex1_dest_single                     ),
  .ex1_double_src                       (ex1_double_src                      ),
  .ex1_half0_src                        (ex1_half0_src                       ),
  .ex1_l8_0_src                         (ex1_l8_0_src                        ),
  .ex1_op_bhtod                         (ex1_op_bhtod                        ),
  .ex1_op_bhtos                         (ex1_op_bhtos                        ),
  .ex1_op_dtobh                         (ex1_op_dtobh                        ),
  .ex1_op_dtoh                          (ex1_op_dtoh                         ),
  .ex1_op_dtos                          (ex1_op_dtos                         ),
  .ex1_op_ftoi                          (ex1_op_ftoi                         ),
  .ex1_op_htod                          (ex1_op_htod                         ),
  .ex1_op_htos                          (ex1_op_htos                         ),
  .ex1_op_stobh                         (ex1_op_stobh                        ),
  .ex1_op_stod                          (ex1_op_stod                         ),
  .ex1_op_stoh                          (ex1_op_stoh                         ),
  .ex1_single0_src                      (ex1_single0_src                     ),
  .ex1_src_bhalf                        (ex1_src_bhalf                       ),
  .ex1_src_double                       (ex1_src_double                      ),
  .ex1_src_float                        (ex1_src_float                       ),
  .ex1_src_half                         (ex1_src_half                        ),
  .ex1_src_i                            (ex1_src_i                           ),
  .ex1_src_l16                          (ex1_src_l16                         ),
  .ex1_src_l32                          (ex1_src_l32                         ),
  .ex1_src_l64                          (ex1_src_l64                         ),
  .ex1_src_l8                           (ex1_src_l8                          ),
  .ex1_src_si                           (ex1_src_si                          ),
  .ex1_src_single                       (ex1_src_single                      ),
  .ex2_bh_quod_up                       (ex2_bh_quod_up                      ),
  .ex2_bhalf0_orig_frac                 (ex2_bhalf0_orig_frac                ),
  .ex2_dest_bhalf                       (ex2_dest_bhalf                      ),
  .ex2_dest_double                      (ex2_dest_double                     ),
  .ex2_dest_float                       (ex2_dest_float                      ),
  .ex2_dest_half                        (ex2_dest_half                       ),
  .ex2_dest_l16                         (ex2_dest_l16                        ),
  .ex2_dest_l32                         (ex2_dest_l32                        ),
  .ex2_dest_l64                         (ex2_dest_l64                        ),
  .ex2_dest_l8                          (ex2_dest_l8                         ),
  .ex2_dest_si                          (ex2_dest_si                         ),
  .ex2_dest_single                      (ex2_dest_single                     ),
  .ex2_double_orig_frac                 (ex2_double_orig_frac                ),
  .ex2_h_quod_up                        (ex2_h_quod_up                       ),
  .ex2_half0_orig_frac                  (ex2_half0_orig_frac                 ),
  .ex2_int16_0_result                   (ex2_int16_0_result                  ),
  .ex2_int32_0_result                   (ex2_int32_0_result                  ),
  .ex2_int64_result                     (ex2_int64_result                    ),
  .ex2_l16_0_result                     (ex2_l16_0_result                    ),
  .ex2_l32_0_result                     (ex2_l32_0_result                    ),
  .ex2_l8_0_result                      (ex2_l8_0_result                     ),
  .ex2_narrow                           (ex2_narrow                          ),
  .ex2_op_itof                          (ex2_op_itof                         ),
  .ex2_quod_dn                          (ex2_quod_dn                         ),
  .ex2_single0_orig_frac                (ex2_single0_orig_frac               ),
  .ex2_src_l16                          (ex2_src_l16                         ),
  .ex2_src_l32                          (ex2_src_l32                         ),
  .ex2_src_l64                          (ex2_src_l64                         ),
  .ex2_widden                           (ex2_widden                          ),
  .ex3_double_result                    (ex3_double_result                   ),
  .fcnvt_ex1_pipe_clk                   (fcnvt_ex1_pipe_clk                  ),
  .fcnvt_ex1_pipedown                   (fcnvt_ex1_pipedown                  ),
  .fcnvt_ex2_pipe_double_clk            (fcnvt_ex2_pipe_double_clk           ),
  .fcnvt_ex2_pipedown                   (fcnvt_ex2_pipedown                  ),
  .half0_final_frac                     (half0_final_frac                    ),
  .l16_0_itof_value                     (l16_0_itof_value                    ),
  .l32_0_itof_value                     (l32_0_itof_value                    ),
  .l64_itof_value                       (l64_itof_value                      ),
  .single0_final_frac                   (single0_final_frac                  ),
  .vpu_group_1_xx_ex2_rm                (vpu_group_1_xx_ex2_rm               )
);


// &ConnRule(s/half2/half1/); @33
// &ConnRule(s/l8_2/l8_1/); @34
// &ConnRule(s/l16_2/l16_1/); @35
// &ConnRule(s/half_pipe/half_pipe1/); @36
// &Instance("aq_fcnvt_half","x_aq_fcnvt_half_1"); @37
// &Instance("aq_fcnvt_single","x_aq_fcnvt_single1"); @39
// &ConnRule(s/half2/half3/); @40
// &ConnRule(s/l8_2/l8_3/); @41
// &ConnRule(s/l16_2/l16_3/); @42
// &ConnRule(s/half_pipe/half_pipe3/); @43
// &Instance("aq_fcnvt_half","x_aq_fcnvt_half_3"); @44
// &ConnRule(s/half2/half4/); @47
// &ConnRule(s/l8_2/l8_4/); @48
// &ConnRule(s/l16_2/l16_4/); @49
// &ConnRule(s/l32_1/l32_2/); @50
// &ConnRule(s/single_pipe/single_pipe2/); @51
// &ConnRule(s/single1/single2/); @52
// &Instance("aq_fcnvt_single","x_aq_fcnvt_single2"); @53
// &ConnRule(s/half2/half5/); @55
// &ConnRule(s/l8_2/l8_5/); @56
// &ConnRule(s/l16_2/l16_5/); @57
// &ConnRule(s/half_pipe/half_pipe5/); @58
// &Instance("aq_fcnvt_half","x_aq_fcnvt_half_5"); @59
// &ConnRule(s/half2/half6/); @61
// &ConnRule(s/l8_2/l8_6/); @62
// &ConnRule(s/l16_2/l16_6/); @63
// &ConnRule(s/l32_1/l32_3/); @64
// &ConnRule(s/single_pipe/single_pipe3/); @65
// &ConnRule(s/single1/single3/); @66
// &Instance("aq_fcnvt_single","x_aq_fcnvt_single3"); @67
// &ConnRule(s/half2/half7/); @68
// &ConnRule(s/l8_2/l8_7/); @69
// &ConnRule(s/l16_2/l16_7/); @70
// &ConnRule(s/half_pipe/half_pipe7/); @71
// &Instance("aq_fcnvt_half","x_aq_fcnvt_half_7"); @72
// &Instance("aq_fcnvt_dp"); @76
// &Instance("aq_fcnvt_scalar_dp"); @79
aq_fcnvt_scalar_dp  x_aq_fcnvt_scalar_dp (
  .bhalf0_final_frac                    (bhalf0_final_frac                   ),
  .cp0_vpu_xx_bf16                      (cp0_vpu_xx_bf16                     ),
  .double_final_frac                    (double_final_frac                   ),
  .double_pipe_bhtod_value              (double_pipe_bhtod_value             ),
  .double_pipe_bhtox_expnt              (double_pipe_bhtox_expnt             ),
  .double_pipe_ex1_special_vld          (double_pipe_ex1_special_vld         ),
  .double_pipe_ex1_src_cnan             (double_pipe_ex1_src_cnan            ),
  .double_pipe_ex1_src_inf              (double_pipe_ex1_src_inf             ),
  .double_pipe_ex1_src_qnan             (double_pipe_ex1_src_qnan            ),
  .double_pipe_ex1_src_snan             (double_pipe_ex1_src_snan            ),
  .double_pipe_ex1_src_zero             (double_pipe_ex1_src_zero            ),
  .double_pipe_ex2_expt                 (double_pipe_ex2_expt                ),
  .double_pipe_ex2_frac                 (double_pipe_ex2_frac                ),
  .double_pipe_ex2_int                  (double_pipe_ex2_int                 ),
  .double_pipe_ex2_widden_dn_itof_expnt (double_pipe_ex2_widden_dn_itof_expnt),
  .double_pipe_ftoi_int                 (double_pipe_ftoi_int                ),
  .double_pipe_htox_expnt               (double_pipe_htox_expnt              ),
  .double_pipe_htox_value               (double_pipe_htox_value              ),
  .double_pipe_special_value            (double_pipe_special_value           ),
  .double_pipe_src_dn                   (double_pipe_src_dn                  ),
  .double_pipe_stod_expnt               (double_pipe_stod_expnt              ),
  .double_pipe_stod_value               (double_pipe_stod_value              ),
  .ex1_dest_bhalf                       (ex1_dest_bhalf                      ),
  .ex1_dest_float                       (ex1_dest_float                      ),
  .ex1_dest_half                        (ex1_dest_half                       ),
  .ex1_dest_si                          (ex1_dest_si                         ),
  .ex1_dest_single                      (ex1_dest_single                     ),
  .ex1_double_src                       (ex1_double_src                      ),
  .ex1_half0_src                        (ex1_half0_src                       ),
  .ex1_l8_0_src                         (ex1_l8_0_src                        ),
  .ex1_op_bhtod                         (ex1_op_bhtod                        ),
  .ex1_op_bhtos                         (ex1_op_bhtos                        ),
  .ex1_op_dtobh                         (ex1_op_dtobh                        ),
  .ex1_op_dtoh                          (ex1_op_dtoh                         ),
  .ex1_op_dtos                          (ex1_op_dtos                         ),
  .ex1_op_ftoi                          (ex1_op_ftoi                         ),
  .ex1_op_htod                          (ex1_op_htod                         ),
  .ex1_op_htos                          (ex1_op_htos                         ),
  .ex1_op_stobh                         (ex1_op_stobh                        ),
  .ex1_op_stod                          (ex1_op_stod                         ),
  .ex1_op_stoh                          (ex1_op_stoh                         ),
  .ex1_single0_src                      (ex1_single0_src                     ),
  .ex1_src_bhalf                        (ex1_src_bhalf                       ),
  .ex1_src_double                       (ex1_src_double                      ),
  .ex1_src_float                        (ex1_src_float                       ),
  .ex1_src_half                         (ex1_src_half                        ),
  .ex1_src_i                            (ex1_src_i                           ),
  .ex1_src_l16                          (ex1_src_l16                         ),
  .ex1_src_l32                          (ex1_src_l32                         ),
  .ex1_src_l64                          (ex1_src_l64                         ),
  .ex1_src_l8                           (ex1_src_l8                          ),
  .ex1_src_si                           (ex1_src_si                          ),
  .ex1_src_single                       (ex1_src_single                      ),
  .ex2_bh_quod_up                       (ex2_bh_quod_up                      ),
  .ex2_bhalf0_orig_frac                 (ex2_bhalf0_orig_frac                ),
  .ex2_dest_bhalf                       (ex2_dest_bhalf                      ),
  .ex2_dest_double                      (ex2_dest_double                     ),
  .ex2_dest_float                       (ex2_dest_float                      ),
  .ex2_dest_half                        (ex2_dest_half                       ),
  .ex2_dest_l16                         (ex2_dest_l16                        ),
  .ex2_dest_l32                         (ex2_dest_l32                        ),
  .ex2_dest_l64                         (ex2_dest_l64                        ),
  .ex2_dest_l8                          (ex2_dest_l8                         ),
  .ex2_dest_si                          (ex2_dest_si                         ),
  .ex2_dest_single                      (ex2_dest_single                     ),
  .ex2_double_orig_frac                 (ex2_double_orig_frac                ),
  .ex2_h_quod_up                        (ex2_h_quod_up                       ),
  .ex2_half0_orig_frac                  (ex2_half0_orig_frac                 ),
  .ex2_int16_0_result                   (ex2_int16_0_result                  ),
  .ex2_int32_0_result                   (ex2_int32_0_result                  ),
  .ex2_int64_result                     (ex2_int64_result                    ),
  .ex2_l16_0_result                     (ex2_l16_0_result                    ),
  .ex2_l32_0_result                     (ex2_l32_0_result                    ),
  .ex2_l8_0_result                      (ex2_l8_0_result                     ),
  .ex2_narrow                           (ex2_narrow                          ),
  .ex2_op_itof                          (ex2_op_itof                         ),
  .ex2_quod_dn                          (ex2_quod_dn                         ),
  .ex2_single0_orig_frac                (ex2_single0_orig_frac               ),
  .ex2_src_l16                          (ex2_src_l16                         ),
  .ex2_src_l32                          (ex2_src_l32                         ),
  .ex2_src_l64                          (ex2_src_l64                         ),
  .ex2_widden                           (ex2_widden                          ),
  .ex3_double_result                    (ex3_double_result                   ),
  .fcnvt_ex1_pipe_clk                   (fcnvt_ex1_pipe_clk                  ),
  .fcnvt_ex1_pipedown                   (fcnvt_ex1_pipedown                  ),
  .fcnvt_ex2_pipe_clk                   (fcnvt_ex2_pipe_clk                  ),
  .fcnvt_ex2_pipedown                   (fcnvt_ex2_pipedown                  ),
  .half0_final_frac                     (half0_final_frac                    ),
  .ifu_vpu_warm_up                      (ifu_vpu_warm_up                     ),
  .l16_0_itof_value                     (l16_0_itof_value                    ),
  .l32_0_itof_value                     (l32_0_itof_value                    ),
  .l64_itof_value                       (l64_itof_value                      ),
  .single0_final_frac                   (single0_final_frac                  ),
  .vfcvt_vpu_ex2_gpr_result             (vfcvt_vpu_ex2_gpr_result            ),
  .vfcvt_vpu_ex3_fflags                 (vfcvt_vpu_ex3_fflags                ),
  .vfcvt_vpu_ex3_fpr_result             (vfcvt_vpu_ex3_fpr_result            ),
  .vpu_group_1_xx_ex1_func              (vpu_group_1_xx_ex1_func             ),
  .vpu_group_1_xx_ex1_srcv0             (vpu_group_1_xx_ex1_srcv0            ),
  .vpu_group_1_xx_ex1_srcv0_type        (vpu_group_1_xx_ex1_srcv0_type       ),
  .vpu_group_1_xx_ex1_srcv1             (vpu_group_1_xx_ex1_srcv1            )
);

// &Instance("aq_fcnvt_ctrl"); @81
aq_fcnvt_ctrl  x_aq_fcnvt_ctrl (
  .cp0_vpu_icg_en            (cp0_vpu_icg_en           ),
  .cp0_yy_clk_en             (cp0_yy_clk_en            ),
  .ex2_dest_l64              (ex2_dest_l64             ),
  .fcnvt_ex1_pipe_clk        (fcnvt_ex1_pipe_clk       ),
  .fcnvt_ex1_pipedown        (fcnvt_ex1_pipedown       ),
  .fcnvt_ex2_pipe_clk        (fcnvt_ex2_pipe_clk       ),
  .fcnvt_ex2_pipe_double_clk (fcnvt_ex2_pipe_double_clk),
  .fcnvt_ex2_pipedown        (fcnvt_ex2_pipedown       ),
  .forever_cpuclk            (forever_cpuclk           ),
  .ifu_vpu_warm_up           (ifu_vpu_warm_up          ),
  .pad_yy_icg_scan_en        (pad_yy_icg_scan_en       ),
  .vpu_group_1_xx_ex1_eu_sel (vpu_group_1_xx_ex1_eu_sel),
  .vpu_group_1_xx_ex1_sel    (vpu_group_1_xx_ex1_sel   ),
  .vpu_group_1_xx_ex2_eu_sel (vpu_group_1_xx_ex2_eu_sel),
  .vpu_group_1_xx_ex2_sel    (vpu_group_1_xx_ex2_sel   ),
  .vpu_group_1_xx_ex2_stall  (vpu_group_1_xx_ex2_stall ),
  .vpu_group_1_xx_ex3_stall  (vpu_group_1_xx_ex3_stall )
);


// &ModuleEnd; @83
endmodule



