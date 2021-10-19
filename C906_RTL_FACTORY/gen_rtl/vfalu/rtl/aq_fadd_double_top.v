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
module aq_fadd_double_top(
  cp0_vpu_xx_dqnan,
  double_pipe_ex1_src0_cnan,
  double_pipe_ex1_src0_id,
  double_pipe_ex1_src0_inf,
  double_pipe_ex1_src0_qnan,
  double_pipe_ex1_src0_snan,
  double_pipe_ex1_src0_zero,
  double_pipe_ex1_src1_cnan,
  double_pipe_ex1_src1_id,
  double_pipe_ex1_src1_inf,
  double_pipe_ex1_src1_qnan,
  double_pipe_ex1_src1_snan,
  double_pipe_ex1_src1_zero,
  double_pipe_ex2_cmp_r,
  double_pipe_ex2_special_result,
  double_pipe_ex3_expt,
  ex1_bhalf,
  ex1_bhalf0_adder_a_final,
  ex1_bhalf0_special_data,
  ex1_double,
  ex1_double_adder_a_final,
  ex1_double_special_data,
  ex1_f16,
  ex1_half,
  ex1_half0_adder_a_final,
  ex1_half0_special_data,
  ex1_op_add,
  ex1_op_add_sub,
  ex1_op_cmp,
  ex1_op_sel,
  ex1_op_sub,
  ex1_rdn,
  ex1_single,
  ex1_single0_adder_a_final,
  ex1_single0_special_data,
  ex2_bhalf,
  ex2_bhalf0_rslt,
  ex2_double,
  ex2_double_adder_a,
  ex2_double_rslt,
  ex2_half,
  ex2_half0_rslt,
  ex2_op_add_sub,
  ex2_op_cmp,
  ex2_op_feq,
  ex2_op_fle,
  ex2_op_flt,
  ex2_op_fne,
  ex2_op_ford,
  ex2_op_max,
  ex2_op_min,
  ex2_op_sel,
  ex2_op_sub,
  ex2_rdn,
  ex2_rmm,
  ex2_rne,
  ex2_rtz,
  ex2_rup,
  ex2_single,
  ex2_single0_rslt,
  ex3_bhalf,
  ex3_bhalf0_result,
  ex3_double,
  ex3_double_result,
  ex3_half,
  ex3_half0_result,
  ex3_op_cmp,
  ex3_op_sel,
  ex3_rdn,
  ex3_rtz,
  ex3_rup,
  ex3_single,
  ex3_single0_result,
  fadd_double_src0,
  fadd_double_src1,
  fadd_ex1_pipe_clk,
  fadd_ex1_pipedown,
  fadd_ex2_nocmp_pipe_clk,
  fadd_ex2_nocmp_pipedown,
  fadd_ex2_pipe_clk,
  fadd_ex2_pipedown,
  fadd_ex3_bhalf0_rslt,
  fadd_ex3_double_rslt,
  fadd_ex3_half0_rslt,
  fadd_ex3_single0_rslt,
  fadd_half0_src0,
  fadd_half0_src1,
  fadd_single0_src0,
  fadd_single0_src1,
  ifu_vpu_warm_up
);

// &Ports @27
input           cp0_vpu_xx_dqnan;              
input           double_pipe_ex1_src0_cnan;     
input           double_pipe_ex1_src0_id;       
input           double_pipe_ex1_src0_inf;      
input           double_pipe_ex1_src0_qnan;     
input           double_pipe_ex1_src0_snan;     
input           double_pipe_ex1_src0_zero;     
input           double_pipe_ex1_src1_cnan;     
input           double_pipe_ex1_src1_id;       
input           double_pipe_ex1_src1_inf;      
input           double_pipe_ex1_src1_qnan;     
input           double_pipe_ex1_src1_snan;     
input           double_pipe_ex1_src1_zero;     
input   [63:0]  double_pipe_ex2_special_result; 
input           ex1_bhalf;                     
input           ex1_double;                    
input           ex1_f16;                       
input           ex1_half;                      
input           ex1_op_add;                    
input           ex1_op_add_sub;                
input           ex1_op_cmp;                    
input           ex1_op_sel;                    
input           ex1_op_sub;                    
input           ex1_rdn;                       
input           ex1_single;                    
input           ex2_bhalf;                     
input           ex2_double;                    
input   [53:0]  ex2_double_adder_a;            
input           ex2_half;                      
input           ex2_op_add_sub;                
input           ex2_op_cmp;                    
input           ex2_op_feq;                    
input           ex2_op_fle;                    
input           ex2_op_flt;                    
input           ex2_op_fne;                    
input           ex2_op_ford;                   
input           ex2_op_max;                    
input           ex2_op_min;                    
input           ex2_op_sel;                    
input           ex2_op_sub;                    
input           ex2_rdn;                       
input           ex2_rmm;                       
input           ex2_rne;                       
input           ex2_rtz;                       
input           ex2_rup;                       
input           ex2_single;                    
input           ex3_bhalf;                     
input   [8 :0]  ex3_bhalf0_result;             
input           ex3_double;                    
input   [53:0]  ex3_double_result;             
input           ex3_half;                      
input   [11:0]  ex3_half0_result;              
input           ex3_op_cmp;                    
input           ex3_op_sel;                    
input           ex3_rdn;                       
input           ex3_rtz;                       
input           ex3_rup;                       
input           ex3_single;                    
input   [24:0]  ex3_single0_result;            
input   [63:0]  fadd_double_src0;              
input   [63:0]  fadd_double_src1;              
input           fadd_ex1_pipe_clk;             
input           fadd_ex1_pipedown;             
input           fadd_ex2_nocmp_pipe_clk;       
input           fadd_ex2_nocmp_pipedown;       
input           fadd_ex2_pipe_clk;             
input           fadd_ex2_pipedown;             
input   [15:0]  fadd_half0_src0;               
input   [15:0]  fadd_half0_src1;               
input   [31:0]  fadd_single0_src0;             
input   [31:0]  fadd_single0_src1;             
input           ifu_vpu_warm_up;               
output          double_pipe_ex2_cmp_r;         
output  [4 :0]  double_pipe_ex3_expt;          
output  [8 :0]  ex1_bhalf0_adder_a_final;      
output  [15:0]  ex1_bhalf0_special_data;       
output  [53:0]  ex1_double_adder_a_final;      
output  [63:0]  ex1_double_special_data;       
output  [11:0]  ex1_half0_adder_a_final;       
output  [15:0]  ex1_half0_special_data;        
output  [24:0]  ex1_single0_adder_a_final;     
output  [31:0]  ex1_single0_special_data;      
output  [8 :0]  ex2_bhalf0_rslt;               
output  [53:0]  ex2_double_rslt;               
output  [11:0]  ex2_half0_rslt;                
output  [24:0]  ex2_single0_rslt;              
output  [63:0]  fadd_ex3_bhalf0_rslt;          
output  [63:0]  fadd_ex3_double_rslt;          
output  [63:0]  fadd_ex3_half0_rslt;           
output  [63:0]  fadd_ex3_single0_rslt;         

// &Regs; @28

// &Wires; @29
wire            add_cmp_act_s;                 
wire            add_cmp_both_zero;             
wire            add_cmp_ex2_src0_eq_src1;      
wire            cp0_vpu_xx_dqnan;              
wire            double_pipe_ex1_src0_cnan;     
wire            double_pipe_ex1_src0_id;       
wire            double_pipe_ex1_src0_inf;      
wire            double_pipe_ex1_src0_qnan;     
wire            double_pipe_ex1_src0_snan;     
wire            double_pipe_ex1_src0_zero;     
wire            double_pipe_ex1_src1_cnan;     
wire            double_pipe_ex1_src1_id;       
wire            double_pipe_ex1_src1_inf;      
wire            double_pipe_ex1_src1_qnan;     
wire            double_pipe_ex1_src1_snan;     
wire            double_pipe_ex1_src1_zero;     
wire            double_pipe_ex2_cmp_r;         
wire    [63:0]  double_pipe_ex2_special_result; 
wire    [4 :0]  double_pipe_ex3_expt;          
wire    [10:0]  dp_maxmin_src_a_e;             
wire    [51:0]  dp_maxmin_src_a_f;             
wire            dp_maxmin_src_a_s;             
wire    [10:0]  dp_maxmin_src_b_e;             
wire    [52:0]  dp_maxmin_src_b_f;             
wire            dp_maxmin_src_b_s;             
wire            dp_maxmin_src_chg;             
wire            ex1_bhalf;                     
wire    [8 :0]  ex1_bhalf0_adder_a_final;      
wire    [15:0]  ex1_bhalf0_special_data;       
wire            ex1_double;                    
wire    [53:0]  ex1_double_adder_a_final;      
wire    [63:0]  ex1_double_special_data;       
wire            ex1_f16;                       
wire            ex1_half;                      
wire    [11:0]  ex1_half0_adder_a_final;       
wire    [15:0]  ex1_half0_special_data;        
wire            ex1_op_add;                    
wire            ex1_op_add_sub;                
wire            ex1_op_cmp;                    
wire            ex1_op_sel;                    
wire            ex1_op_sub;                    
wire            ex1_rdn;                       
wire            ex1_single;                    
wire    [24:0]  ex1_single0_adder_a_final;     
wire    [31:0]  ex1_single0_special_data;      
wire            ex1_src0_0;                    
wire            ex1_src1_0;                    
wire            ex2_act_s;                     
wire            ex2_act_sub;                   
wire            ex2_bhalf;                     
wire    [8 :0]  ex2_bhalf0_addsub_rslt;        
wire    [8 :0]  ex2_bhalf0_rslt;               
wire    [6 :0]  ex2_bhalf0_sel_final_f;        
wire    [15:0]  ex2_bhalf0_special_data;       
wire            ex2_both_zero;                 
wire            ex2_cmp_special_r;             
wire            ex2_double;                    
wire    [53:0]  ex2_double_adder_a;            
wire    [53:0]  ex2_double_addsub_rslt;        
wire    [53:0]  ex2_double_rslt;               
wire    [51:0]  ex2_double_sel_final_f;        
wire    [63:0]  ex2_double_special_data;       
wire    [10:0]  ex2_e_add_rslt;                
wire            ex2_half;                      
wire    [11:0]  ex2_half0_addsub_rslt;         
wire    [11:0]  ex2_half0_rslt;                
wire    [9 :0]  ex2_half0_sel_final_f;         
wire    [15:0]  ex2_half0_special_data;        
wire            ex2_nocmp_nosel;               
wire            ex2_nv;                        
wire            ex2_op_add_sub;                
wire            ex2_op_cmp;                    
wire            ex2_op_feq;                    
wire            ex2_op_fle;                    
wire            ex2_op_flt;                    
wire            ex2_op_fne;                    
wire            ex2_op_ford;                   
wire            ex2_op_max;                    
wire            ex2_op_min;                    
wire            ex2_op_sel;                    
wire            ex2_op_sub;                    
wire            ex2_rdn;                       
wire            ex2_rmm;                       
wire            ex2_rne;                       
wire            ex2_rtz;                       
wire            ex2_rup;                       
wire    [10:0]  ex2_sel_final_e;               
wire            ex2_sel_final_sign;            
wire            ex2_single;                    
wire    [24:0]  ex2_single0_addsub_rslt;       
wire    [24:0]  ex2_single0_rslt;              
wire    [22:0]  ex2_single0_sel_final_f;       
wire    [31:0]  ex2_single0_special_data;      
wire            ex2_special_value_vld;         
wire            ex2_src0_0;                    
wire            ex2_src0_cnan;                 
wire            ex2_src0_inf;                  
wire            ex2_src0_qnan;                 
wire            ex2_src0_snan;                 
wire            ex2_src1_0;                    
wire            ex2_src1_cnan;                 
wire            ex2_src1_inf;                  
wire            ex2_src1_qnan;                 
wire            ex2_src1_snan;                 
wire            ex3_act_s;                     
wire            ex3_bhalf;                     
wire    [8 :0]  ex3_bhalf0_result;             
wire            ex3_double;                    
wire    [53:0]  ex3_double_result;             
wire            ex3_expt_mask;                 
wire            ex3_half;                      
wire    [11:0]  ex3_half0_result;              
wire            ex3_nv;                        
wire            ex3_op_cmp;                    
wire            ex3_op_sel;                    
wire    [10:0]  ex3_org_e;                     
wire            ex3_rdn;                       
wire            ex3_rtz;                       
wire            ex3_rup;                       
wire            ex3_single;                    
wire    [24:0]  ex3_single0_result;            
wire            ex3_special_n_op_sel;          
wire    [63:0]  fadd_double_src0;              
wire    [63:0]  fadd_double_src1;              
wire            fadd_ex1_pipe_clk;             
wire            fadd_ex1_pipedown;             
wire            fadd_ex2_nocmp_pipe_clk;       
wire            fadd_ex2_nocmp_pipedown;       
wire            fadd_ex2_pipe_clk;             
wire            fadd_ex2_pipedown;             
wire    [63:0]  fadd_ex3_bhalf0_rslt;          
wire    [63:0]  fadd_ex3_double_rslt;          
wire    [63:0]  fadd_ex3_half0_rslt;           
wire    [63:0]  fadd_ex3_single0_rslt;         
wire    [15:0]  fadd_half0_src0;               
wire    [15:0]  fadd_half0_src1;               
wire    [31:0]  fadd_single0_src0;             
wire    [31:0]  fadd_single0_src1;             
wire            ifu_vpu_warm_up;               


// &Instance("aq_fadd_double_dp"); @31
aq_fadd_double_dp  x_aq_fadd_double_dp (
  .double_pipe_ex1_src0_cnan (double_pipe_ex1_src0_cnan),
  .double_pipe_ex1_src0_inf  (double_pipe_ex1_src0_inf ),
  .double_pipe_ex1_src0_qnan (double_pipe_ex1_src0_qnan),
  .double_pipe_ex1_src0_snan (double_pipe_ex1_src0_snan),
  .double_pipe_ex1_src0_zero (double_pipe_ex1_src0_zero),
  .double_pipe_ex1_src1_cnan (double_pipe_ex1_src1_cnan),
  .double_pipe_ex1_src1_inf  (double_pipe_ex1_src1_inf ),
  .double_pipe_ex1_src1_qnan (double_pipe_ex1_src1_qnan),
  .double_pipe_ex1_src1_snan (double_pipe_ex1_src1_snan),
  .double_pipe_ex1_src1_zero (double_pipe_ex1_src1_zero),
  .ex1_src0_0                (ex1_src0_0               ),
  .ex1_src1_0                (ex1_src1_0               ),
  .ex2_act_s                 (ex2_act_s                ),
  .ex2_bhalf                 (ex2_bhalf                ),
  .ex2_bhalf0_addsub_rslt    (ex2_bhalf0_addsub_rslt   ),
  .ex2_bhalf0_rslt           (ex2_bhalf0_rslt          ),
  .ex2_bhalf0_sel_final_f    (ex2_bhalf0_sel_final_f   ),
  .ex2_bhalf0_special_data   (ex2_bhalf0_special_data  ),
  .ex2_double                (ex2_double               ),
  .ex2_double_addsub_rslt    (ex2_double_addsub_rslt   ),
  .ex2_double_rslt           (ex2_double_rslt          ),
  .ex2_double_sel_final_f    (ex2_double_sel_final_f   ),
  .ex2_double_special_data   (ex2_double_special_data  ),
  .ex2_e_add_rslt            (ex2_e_add_rslt           ),
  .ex2_half                  (ex2_half                 ),
  .ex2_half0_addsub_rslt     (ex2_half0_addsub_rslt    ),
  .ex2_half0_rslt            (ex2_half0_rslt           ),
  .ex2_half0_sel_final_f     (ex2_half0_sel_final_f    ),
  .ex2_half0_special_data    (ex2_half0_special_data   ),
  .ex2_nocmp_nosel           (ex2_nocmp_nosel          ),
  .ex2_nv                    (ex2_nv                   ),
  .ex2_op_cmp                (ex2_op_cmp               ),
  .ex2_op_sel                (ex2_op_sel               ),
  .ex2_sel_final_e           (ex2_sel_final_e          ),
  .ex2_sel_final_sign        (ex2_sel_final_sign       ),
  .ex2_single                (ex2_single               ),
  .ex2_single0_addsub_rslt   (ex2_single0_addsub_rslt  ),
  .ex2_single0_rslt          (ex2_single0_rslt         ),
  .ex2_single0_sel_final_f   (ex2_single0_sel_final_f  ),
  .ex2_single0_special_data  (ex2_single0_special_data ),
  .ex2_special_value_vld     (ex2_special_value_vld    ),
  .ex2_src0_0                (ex2_src0_0               ),
  .ex2_src0_cnan             (ex2_src0_cnan            ),
  .ex2_src0_inf              (ex2_src0_inf             ),
  .ex2_src0_qnan             (ex2_src0_qnan            ),
  .ex2_src0_snan             (ex2_src0_snan            ),
  .ex2_src1_0                (ex2_src1_0               ),
  .ex2_src1_cnan             (ex2_src1_cnan            ),
  .ex2_src1_inf              (ex2_src1_inf             ),
  .ex2_src1_qnan             (ex2_src1_qnan            ),
  .ex2_src1_snan             (ex2_src1_snan            ),
  .ex3_act_s                 (ex3_act_s                ),
  .ex3_expt_mask             (ex3_expt_mask            ),
  .ex3_nv                    (ex3_nv                   ),
  .ex3_org_e                 (ex3_org_e                ),
  .ex3_special_n_op_sel      (ex3_special_n_op_sel     ),
  .fadd_ex1_pipe_clk         (fadd_ex1_pipe_clk        ),
  .fadd_ex1_pipedown         (fadd_ex1_pipedown        ),
  .fadd_ex2_nocmp_pipe_clk   (fadd_ex2_nocmp_pipe_clk  ),
  .fadd_ex2_nocmp_pipedown   (fadd_ex2_nocmp_pipedown  ),
  .fadd_ex2_pipe_clk         (fadd_ex2_pipe_clk        ),
  .fadd_ex2_pipedown         (fadd_ex2_pipedown        )
);

// &Instance("aq_fadd_double_red_sel"); @33
// &Instance("aq_fadd_double_special"); @35
aq_fadd_double_special  x_aq_fadd_double_special (
  .cp0_vpu_xx_dqnan         (cp0_vpu_xx_dqnan        ),
  .dp_maxmin_src_a_e        (dp_maxmin_src_a_e       ),
  .dp_maxmin_src_a_f        (dp_maxmin_src_a_f       ),
  .dp_maxmin_src_a_s        (dp_maxmin_src_a_s       ),
  .dp_maxmin_src_b_e        (dp_maxmin_src_b_e       ),
  .dp_maxmin_src_b_f        (dp_maxmin_src_b_f       ),
  .dp_maxmin_src_b_s        (dp_maxmin_src_b_s       ),
  .dp_maxmin_src_chg        (dp_maxmin_src_chg       ),
  .ex2_act_sub              (ex2_act_sub             ),
  .ex2_bhalf0_special_data  (ex2_bhalf0_special_data ),
  .ex2_both_zero            (ex2_both_zero           ),
  .ex2_cmp_special_r        (ex2_cmp_special_r       ),
  .ex2_double_special_data  (ex2_double_special_data ),
  .ex2_half0_special_data   (ex2_half0_special_data  ),
  .ex2_nv                   (ex2_nv                  ),
  .ex2_op_add_sub           (ex2_op_add_sub          ),
  .ex2_op_cmp               (ex2_op_cmp              ),
  .ex2_op_feq               (ex2_op_feq              ),
  .ex2_op_fle               (ex2_op_fle              ),
  .ex2_op_flt               (ex2_op_flt              ),
  .ex2_op_fne               (ex2_op_fne              ),
  .ex2_op_ford              (ex2_op_ford             ),
  .ex2_op_max               (ex2_op_max              ),
  .ex2_op_min               (ex2_op_min              ),
  .ex2_op_sel               (ex2_op_sel              ),
  .ex2_op_sub               (ex2_op_sub              ),
  .ex2_single0_special_data (ex2_single0_special_data),
  .ex2_special_value_vld    (ex2_special_value_vld   ),
  .ex2_src0_0               (ex2_src0_0              ),
  .ex2_src0_cnan            (ex2_src0_cnan           ),
  .ex2_src0_inf             (ex2_src0_inf            ),
  .ex2_src0_qnan            (ex2_src0_qnan           ),
  .ex2_src0_snan            (ex2_src0_snan           ),
  .ex2_src1_0               (ex2_src1_0              ),
  .ex2_src1_cnan            (ex2_src1_cnan           ),
  .ex2_src1_inf             (ex2_src1_inf            ),
  .ex2_src1_qnan            (ex2_src1_qnan           ),
  .ex2_src1_snan            (ex2_src1_snan           )
);

// &Instance("aq_fadd_double_add"); @36
aq_fadd_double_add  x_aq_fadd_double_add (
  .add_cmp_act_s                  (add_cmp_act_s                 ),
  .add_cmp_both_zero              (add_cmp_both_zero             ),
  .add_cmp_ex2_src0_eq_src1       (add_cmp_ex2_src0_eq_src1      ),
  .double_pipe_ex1_src0_id        (double_pipe_ex1_src0_id       ),
  .double_pipe_ex1_src1_id        (double_pipe_ex1_src1_id       ),
  .double_pipe_ex2_special_result (double_pipe_ex2_special_result),
  .double_pipe_ex3_expt           (double_pipe_ex3_expt          ),
  .dp_maxmin_src_a_e              (dp_maxmin_src_a_e             ),
  .dp_maxmin_src_a_f              (dp_maxmin_src_a_f             ),
  .dp_maxmin_src_a_s              (dp_maxmin_src_a_s             ),
  .dp_maxmin_src_b_e              (dp_maxmin_src_b_e             ),
  .dp_maxmin_src_b_f              (dp_maxmin_src_b_f             ),
  .dp_maxmin_src_b_s              (dp_maxmin_src_b_s             ),
  .dp_maxmin_src_chg              (dp_maxmin_src_chg             ),
  .ex1_bhalf                      (ex1_bhalf                     ),
  .ex1_bhalf0_adder_a_final       (ex1_bhalf0_adder_a_final      ),
  .ex1_bhalf0_special_data        (ex1_bhalf0_special_data       ),
  .ex1_double                     (ex1_double                    ),
  .ex1_double_adder_a_final       (ex1_double_adder_a_final      ),
  .ex1_double_special_data        (ex1_double_special_data       ),
  .ex1_f16                        (ex1_f16                       ),
  .ex1_half                       (ex1_half                      ),
  .ex1_half0_adder_a_final        (ex1_half0_adder_a_final       ),
  .ex1_half0_special_data         (ex1_half0_special_data        ),
  .ex1_op_add                     (ex1_op_add                    ),
  .ex1_op_add_sub                 (ex1_op_add_sub                ),
  .ex1_op_cmp                     (ex1_op_cmp                    ),
  .ex1_op_sel                     (ex1_op_sel                    ),
  .ex1_op_sub                     (ex1_op_sub                    ),
  .ex1_rdn                        (ex1_rdn                       ),
  .ex1_single                     (ex1_single                    ),
  .ex1_single0_adder_a_final      (ex1_single0_adder_a_final     ),
  .ex1_single0_special_data       (ex1_single0_special_data      ),
  .ex1_src0_0                     (ex1_src0_0                    ),
  .ex1_src1_0                     (ex1_src1_0                    ),
  .ex2_act_s                      (ex2_act_s                     ),
  .ex2_act_sub                    (ex2_act_sub                   ),
  .ex2_bhalf                      (ex2_bhalf                     ),
  .ex2_bhalf0_addsub_rslt         (ex2_bhalf0_addsub_rslt        ),
  .ex2_both_zero                  (ex2_both_zero                 ),
  .ex2_double                     (ex2_double                    ),
  .ex2_double_adder_a             (ex2_double_adder_a            ),
  .ex2_double_addsub_rslt         (ex2_double_addsub_rslt        ),
  .ex2_e_add_rslt                 (ex2_e_add_rslt                ),
  .ex2_half                       (ex2_half                      ),
  .ex2_half0_addsub_rslt          (ex2_half0_addsub_rslt         ),
  .ex2_nocmp_nosel                (ex2_nocmp_nosel               ),
  .ex2_op_sel                     (ex2_op_sel                    ),
  .ex2_rdn                        (ex2_rdn                       ),
  .ex2_rmm                        (ex2_rmm                       ),
  .ex2_rne                        (ex2_rne                       ),
  .ex2_rtz                        (ex2_rtz                       ),
  .ex2_rup                        (ex2_rup                       ),
  .ex2_single                     (ex2_single                    ),
  .ex2_single0_addsub_rslt        (ex2_single0_addsub_rslt       ),
  .ex2_special_value_vld          (ex2_special_value_vld         ),
  .ex3_act_s                      (ex3_act_s                     ),
  .ex3_bhalf                      (ex3_bhalf                     ),
  .ex3_bhalf0_result              (ex3_bhalf0_result             ),
  .ex3_double                     (ex3_double                    ),
  .ex3_double_result              (ex3_double_result             ),
  .ex3_expt_mask                  (ex3_expt_mask                 ),
  .ex3_half                       (ex3_half                      ),
  .ex3_half0_result               (ex3_half0_result              ),
  .ex3_nv                         (ex3_nv                        ),
  .ex3_op_cmp                     (ex3_op_cmp                    ),
  .ex3_op_sel                     (ex3_op_sel                    ),
  .ex3_org_e                      (ex3_org_e                     ),
  .ex3_rdn                        (ex3_rdn                       ),
  .ex3_rtz                        (ex3_rtz                       ),
  .ex3_rup                        (ex3_rup                       ),
  .ex3_single                     (ex3_single                    ),
  .ex3_single0_result             (ex3_single0_result            ),
  .ex3_special_n_op_sel           (ex3_special_n_op_sel          ),
  .fadd_double_src0               (fadd_double_src0              ),
  .fadd_double_src1               (fadd_double_src1              ),
  .fadd_ex1_pipe_clk              (fadd_ex1_pipe_clk             ),
  .fadd_ex1_pipedown              (fadd_ex1_pipedown             ),
  .fadd_ex2_nocmp_pipe_clk        (fadd_ex2_nocmp_pipe_clk       ),
  .fadd_ex2_nocmp_pipedown        (fadd_ex2_nocmp_pipedown       ),
  .fadd_ex3_bhalf0_rslt           (fadd_ex3_bhalf0_rslt          ),
  .fadd_ex3_double_rslt           (fadd_ex3_double_rslt          ),
  .fadd_ex3_half0_rslt            (fadd_ex3_half0_rslt           ),
  .fadd_ex3_single0_rslt          (fadd_ex3_single0_rslt         ),
  .fadd_half0_src0                (fadd_half0_src0               ),
  .fadd_half0_src1                (fadd_half0_src1               ),
  .fadd_single0_src0              (fadd_single0_src0             ),
  .fadd_single0_src1              (fadd_single0_src1             ),
  .ifu_vpu_warm_up                (ifu_vpu_warm_up               )
);

//&Instance("aq_fadd_double_round");
// &Instance("aq_fadd_double_cmp_max"); @38
aq_fadd_double_cmp_max  x_aq_fadd_double_cmp_max (
  .add_cmp_act_s            (add_cmp_act_s           ),
  .add_cmp_both_zero        (add_cmp_both_zero       ),
  .add_cmp_ex2_src0_eq_src1 (add_cmp_ex2_src0_eq_src1),
  .double_pipe_ex2_cmp_r    (double_pipe_ex2_cmp_r   ),
  .dp_maxmin_src_a_e        (dp_maxmin_src_a_e       ),
  .dp_maxmin_src_a_f        (dp_maxmin_src_a_f       ),
  .dp_maxmin_src_a_s        (dp_maxmin_src_a_s       ),
  .dp_maxmin_src_b_e        (dp_maxmin_src_b_e       ),
  .dp_maxmin_src_b_f        (dp_maxmin_src_b_f       ),
  .dp_maxmin_src_b_s        (dp_maxmin_src_b_s       ),
  .dp_maxmin_src_chg        (dp_maxmin_src_chg       ),
  .ex2_bhalf0_sel_final_f   (ex2_bhalf0_sel_final_f  ),
  .ex2_cmp_special_r        (ex2_cmp_special_r       ),
  .ex2_double_sel_final_f   (ex2_double_sel_final_f  ),
  .ex2_half0_sel_final_f    (ex2_half0_sel_final_f   ),
  .ex2_op_feq               (ex2_op_feq              ),
  .ex2_op_fle               (ex2_op_fle              ),
  .ex2_op_flt               (ex2_op_flt              ),
  .ex2_op_fne               (ex2_op_fne              ),
  .ex2_op_ford              (ex2_op_ford             ),
  .ex2_op_max               (ex2_op_max              ),
  .ex2_sel_final_e          (ex2_sel_final_e         ),
  .ex2_sel_final_sign       (ex2_sel_final_sign      ),
  .ex2_single0_sel_final_f  (ex2_single0_sel_final_f ),
  .ex2_special_value_vld    (ex2_special_value_vld   )
);


// &ModuleEnd; @40
endmodule


