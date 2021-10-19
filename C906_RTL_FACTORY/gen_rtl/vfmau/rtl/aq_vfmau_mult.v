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

// &ModuleBeg; @24
module aq_vfmau_mult(
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

// &Ports; @25
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

// &Regs; @26

// &Wires; @27
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
wire             ex1_f16;                      
wire             ex1_half;                     
wire    [1  :0]  ex1_id_reg;                   
wire             ex1_mac;                      
wire             ex1_neg;                      
wire    [2  :0]  ex1_rm;                       
wire             ex1_single;                   
wire    [63 :0]  ex1_srcv0;                    
wire    [63 :0]  ex1_srcv1;                    
wire    [63 :0]  ex1_srcv2;                    
wire             ex1_sub;                      
wire             ex1_widen;                    
wire             ex2_bf16;                     
wire             ex2_double;                   
wire             ex2_dst_bf16;                 
wire             ex2_dst_double;               
wire             ex2_dst_f16;                  
wire             ex2_dst_half;                 
wire             ex2_dst_single;               
wire             ex2_mac;                      
wire    [105:0]  ex2_mult_data;                
wire             ex2_single;                   
wire    [5  :0]  ex2_special_sel;              
wire             ex3_bf16;                     
wire             ex3_dst_bf16;                 
wire             ex3_dst_double;               
wire             ex3_dst_f16;                  
wire             ex3_dst_single;               
wire             ex3_f16;                      
wire    [2  :0]  ex3_rm;                       
wire             ex3_simd;                     
wire             ex3_single;                   
wire             ex3_special_cmplt;            
wire             ex4_bf16;                     
wire             ex4_dst_bf16;                 
wire             ex4_dst_double;               
wire             ex4_dst_f16;                  
wire             ex4_dst_half;                 
wire             ex4_dst_single;               
wire             ex4_f16;                      
wire    [2  :0]  ex4_rm;                       
wire             ex4_single;                   
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



// &Instance("aq_vfmau_frac_mult","x_aq_vfmau_frac_mult"); @30
aq_vfmau_frac_mult  x_aq_vfmau_frac_mult (
  .ctrl_dp_ex1_inst_pipe_down (ctrl_dp_ex1_inst_pipe_down),
  .ex1_bf16                   (ex1_bf16                  ),
  .ex1_double                 (ex1_double                ),
  .ex1_f16                    (ex1_f16                   ),
  .ex1_id_reg                 (ex1_id_reg                ),
  .ex1_single                 (ex1_single                ),
  .ex1_srcv0                  (ex1_srcv0                 ),
  .ex1_srcv1                  (ex1_srcv1                 ),
  .ex2_mult_data              (ex2_mult_data             ),
  .fmau_ex2_data_clk          (fmau_ex2_data_clk         ),
  .ifu_vpu_warm_up            (ifu_vpu_warm_up           )
);

// &Instance("aq_vfmau_mult_double","x_aq_vfmau_mult_double"); @31
aq_vfmau_mult_double  x_aq_vfmau_mult_double (
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ctrl_dp_ex4_inst_pipe_down    (ctrl_dp_ex4_inst_pipe_down   ),
  .ex1_bf16                      (ex1_bf16                     ),
  .ex1_double                    (ex1_double                   ),
  .ex1_double_expnt_near_of      (ex1_double_expnt_near_of     ),
  .ex1_double_expnt_near_uf      (ex1_double_expnt_near_uf     ),
  .ex1_dst_bf16                  (ex1_dst_bf16                 ),
  .ex1_dst_double                (ex1_dst_double               ),
  .ex1_dst_f16                   (ex1_dst_f16                  ),
  .ex1_dst_half                  (ex1_dst_half                 ),
  .ex1_dst_single                (ex1_dst_single               ),
  .ex1_f16                       (ex1_f16                      ),
  .ex1_half                      (ex1_half                     ),
  .ex1_id_reg                    (ex1_id_reg                   ),
  .ex1_mac                       (ex1_mac                      ),
  .ex1_neg                       (ex1_neg                      ),
  .ex1_rm                        (ex1_rm                       ),
  .ex1_single                    (ex1_single                   ),
  .ex1_srcv0                     (ex1_srcv0                    ),
  .ex1_srcv1                     (ex1_srcv1                    ),
  .ex1_srcv2                     (ex1_srcv2                    ),
  .ex1_sub                       (ex1_sub                      ),
  .ex1_widen                     (ex1_widen                    ),
  .ex2_bf16                      (ex2_bf16                     ),
  .ex2_double                    (ex2_double                   ),
  .ex2_dst_bf16                  (ex2_dst_bf16                 ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_dst_f16                   (ex2_dst_f16                  ),
  .ex2_dst_half                  (ex2_dst_half                 ),
  .ex2_dst_single                (ex2_dst_single               ),
  .ex2_mac                       (ex2_mac                      ),
  .ex2_mult_data                 (ex2_mult_data                ),
  .ex2_single                    (ex2_single                   ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_bf16                      (ex3_bf16                     ),
  .ex3_dst_bf16                  (ex3_dst_bf16                 ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_dst_f16                   (ex3_dst_f16                  ),
  .ex3_dst_single                (ex3_dst_single               ),
  .ex3_f16                       (ex3_f16                      ),
  .ex3_rm                        (ex3_rm                       ),
  .ex3_simd                      (ex3_simd                     ),
  .ex3_single                    (ex3_single                   ),
  .ex3_special_cmplt             (ex3_special_cmplt            ),
  .ex4_bf16                      (ex4_bf16                     ),
  .ex4_dst_bf16                  (ex4_dst_bf16                 ),
  .ex4_dst_double                (ex4_dst_double               ),
  .ex4_dst_f16                   (ex4_dst_f16                  ),
  .ex4_dst_half                  (ex4_dst_half                 ),
  .ex4_dst_single                (ex4_dst_single               ),
  .ex4_f16                       (ex4_f16                      ),
  .ex4_rm                        (ex4_rm                       ),
  .ex4_single                    (ex4_single                   ),
  .fmau_ex2_data_clk             (fmau_ex2_data_clk            ),
  .fmau_ex3_data_clk             (fmau_ex3_data_clk            ),
  .fmau_ex4_data_clk             (fmau_ex4_data_clk            ),
  .fmau_ex5_data_clk             (fmau_ex5_data_clk            ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .vfmau_vpu_ex3_fflags          (vfmau_vpu_ex3_fflags         ),
  .vfmau_vpu_ex3_fpr_result      (vfmau_vpu_ex3_fpr_result     ),
  .vfmau_vpu_ex4_fflags          (vfmau_vpu_ex4_fflags         ),
  .vfmau_vpu_ex4_fpr_result      (vfmau_vpu_ex4_fpr_result     ),
  .vfmau_vpu_ex5_fflags          (vfmau_vpu_ex5_fflags         ),
  .vfmau_vpu_ex5_fpr_result      (vfmau_vpu_ex5_fpr_result     ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);

// &ConnRule(s/halfx/half1/); @33
// &Instance("aq_vfmau_mult_simd_single","x_aq_vfmau_mult_simd_single"); @34
// &ConnRule(s/halfx/half2/); @36
// &ConnRule(s/singlex/single0/); @37
// &Instance("aq_vfmau_mult_simd_half","x_aq_vfmau_simd_half2"); @38
// &Force("nonport","ex1_simd_half2_left_max"); @39
// &Force("nonport","ex1_simd_half2_right_sel"); @40
// &ConnRule(s/halfx/half3/); @42
// &ConnRule(s/singlex/single1/); @43
// &Instance("aq_vfmau_mult_simd_half","x_aq_vfmau_simd_half3"); @44
// &Force("nonport","ex2_simd_half3_left_max"); @45
// &Force("nonport","ex2_simd_half3_right_sel"); @46

// &ModuleEnd; @49
endmodule


