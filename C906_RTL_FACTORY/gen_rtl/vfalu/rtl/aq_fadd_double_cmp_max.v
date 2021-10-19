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
module aq_fadd_double_cmp_max(
  add_cmp_act_s,
  add_cmp_both_zero,
  add_cmp_ex2_src0_eq_src1,
  double_pipe_ex2_cmp_r,
  dp_maxmin_src_a_e,
  dp_maxmin_src_a_f,
  dp_maxmin_src_a_s,
  dp_maxmin_src_b_e,
  dp_maxmin_src_b_f,
  dp_maxmin_src_b_s,
  dp_maxmin_src_chg,
  ex2_bhalf0_sel_final_f,
  ex2_cmp_special_r,
  ex2_double_sel_final_f,
  ex2_half0_sel_final_f,
  ex2_op_feq,
  ex2_op_fle,
  ex2_op_flt,
  ex2_op_fne,
  ex2_op_ford,
  ex2_op_max,
  ex2_sel_final_e,
  ex2_sel_final_sign,
  ex2_single0_sel_final_f,
  ex2_special_value_vld
);

// &Ports; @27
input           add_cmp_act_s;            
input           add_cmp_both_zero;        
input           add_cmp_ex2_src0_eq_src1; 
input   [10:0]  dp_maxmin_src_a_e;        
input   [51:0]  dp_maxmin_src_a_f;        
input           dp_maxmin_src_a_s;        
input   [10:0]  dp_maxmin_src_b_e;        
input   [52:0]  dp_maxmin_src_b_f;        
input           dp_maxmin_src_b_s;        
input           dp_maxmin_src_chg;        
input           ex2_cmp_special_r;        
input           ex2_op_feq;               
input           ex2_op_fle;               
input           ex2_op_flt;               
input           ex2_op_fne;               
input           ex2_op_ford;              
input           ex2_op_max;               
input           ex2_special_value_vld;    
output          double_pipe_ex2_cmp_r;    
output  [6 :0]  ex2_bhalf0_sel_final_f;   
output  [51:0]  ex2_double_sel_final_f;   
output  [9 :0]  ex2_half0_sel_final_f;    
output  [10:0]  ex2_sel_final_e;          
output          ex2_sel_final_sign;       
output  [22:0]  ex2_single0_sel_final_f;  

// &Regs; @28

// &Wires; @29
wire            add_cmp_act_s;            
wire            add_cmp_both_zero;        
wire            add_cmp_ex2_src0_eq_src1; 
wire            double_pipe_ex2_cmp_r;    
wire    [10:0]  dp_maxmin_src_a_e;        
wire    [51:0]  dp_maxmin_src_a_f;        
wire            dp_maxmin_src_a_s;        
wire    [10:0]  dp_maxmin_src_b_e;        
wire    [52:0]  dp_maxmin_src_b_f;        
wire            dp_maxmin_src_b_s;        
wire            dp_maxmin_src_chg;        
wire            ex2_act_s;                
wire    [6 :0]  ex2_bhalf0_sel_final_f;   
wire    [6 :0]  ex2_bhalf0_sel_rst_max_f; 
wire    [6 :0]  ex2_bhalf0_sel_rst_min_f; 
wire    [6 :0]  ex2_bhalf0_src0_f;        
wire    [6 :0]  ex2_bhalf0_src1_f;        
wire            ex2_both_zero;            
wire            ex2_cmp_feq;              
wire            ex2_cmp_fle;              
wire            ex2_cmp_flt;              
wire            ex2_cmp_fne;              
wire            ex2_cmp_r;                
wire            ex2_cmp_special_r;        
wire    [51:0]  ex2_double_sel_final_f;   
wire    [51:0]  ex2_double_sel_rst_max_f; 
wire    [51:0]  ex2_double_sel_rst_min_f; 
wire    [51:0]  ex2_double_src0_f;        
wire    [51:0]  ex2_double_src1_f;        
wire    [9 :0]  ex2_half0_sel_final_f;    
wire    [9 :0]  ex2_half0_sel_rst_max_f;  
wire    [9 :0]  ex2_half0_sel_rst_min_f;  
wire    [9 :0]  ex2_half0_src0_f;         
wire    [9 :0]  ex2_half0_src1_f;         
wire            ex2_op_feq;               
wire            ex2_op_fle;               
wire            ex2_op_flt;               
wire            ex2_op_fne;               
wire            ex2_op_ford;              
wire            ex2_op_max;               
wire            ex2_s_equal;              
wire    [10:0]  ex2_sel_final_e;          
wire            ex2_sel_final_sign;       
wire            ex2_sel_rst_both0_sign;   
wire    [10:0]  ex2_sel_rst_max_e;        
wire            ex2_sel_rst_max_s;        
wire    [10:0]  ex2_sel_rst_min_e;        
wire            ex2_sel_rst_min_s;        
wire    [22:0]  ex2_single0_sel_final_f;  
wire    [22:0]  ex2_single0_sel_rst_max_f; 
wire    [22:0]  ex2_single0_sel_rst_min_f; 
wire    [22:0]  ex2_single0_src0_f;       
wire    [22:0]  ex2_single0_src1_f;       
wire            ex2_special_value_vld;    
wire    [10:0]  ex2_src0_e;               
wire    [51:0]  ex2_src0_f;               
wire            ex2_src0_s;               
wire    [10:0]  ex2_src1_e;               
wire            ex2_src1_s;               
wire    [52:0]  ex2_src1_sel;             
wire            ex2_src_chg;              


// the sign is used to calculate the the compare result

assign  ex2_act_s         =  add_cmp_act_s;
assign  ex2_both_zero     =  add_cmp_both_zero;

//------------------------------------------------------------------------------
//                          CMP Normal Result:
//------------------------------------------------------------------------------

assign ex2_s_equal  = ex2_src0_s == ex2_src1_s;
assign ex2_cmp_feq  = ex2_s_equal && add_cmp_ex2_src0_eq_src1 || ex2_both_zero;
assign ex2_cmp_flt  = (ex2_act_s && !ex2_cmp_feq);
assign ex2_cmp_fle  = ex2_cmp_feq || ex2_cmp_flt;
assign ex2_cmp_fne  = !ex2_cmp_feq;

assign ex2_cmp_r    = ex2_op_fle  && ex2_cmp_fle ||
                      ex2_op_feq  && ex2_cmp_feq ||
                      ex2_op_flt  && ex2_cmp_flt ||
                      ex2_op_fne  && ex2_cmp_fne || ex2_op_ford;

//------------------------------------------------------------------------------
//                    EX2 int special result:
//------------------------------------------------------------------------------
//cmp instruction
//if src0 or src1 is nan, rst is 0, so just need focus on inf

//flt
//&CombBeg;
//if(ex2_src0_inf && ex2_src1_inf)
//  ex2_special_flt_rst = ex2_orig_src0_s && !ex2_orig_src1_s;
//else if(ex2_src0_inf)
//  ex2_special_flt_rst = ex2_orig_src0_s;
//else//if (ex2_src1_inf)
//  ex2_special_flt_rst = !ex2_orig_src1_s;
//&CombEnd;
//
////feq
//&CombBeg;
//if(ex2_src0_inf && ex2_src1_inf)
//  ex2_special_feq_rst = ex2_orig_src0_s ^ ~ex2_orig_src1_s;
//else //if only one inf
//  ex2_special_feq_rst = 1'b0;
//&CombEnd;
//
////fle
//assign ex2_special_fle_rst = ex2_special_feq_rst || ex2_special_flt_rst;
//assign ex2_special_inf_rst = ex2_op_fle & ex2_special_fle_rst | 
//                             ex2_op_feq & ex2_special_feq_rst | 
//                             ex2_op_flt & ex2_special_flt_rst | 
//                             ex2_op_fne & !ex2_special_feq_rst| ex2_op_ford;
//assign ex2_cmp_special_r   = ex2_nv_lt_le ? ex2_op_fne : ex2_special_inf_rst;

// the final compare result
// &Force("output","double_pipe_ex2_cmp_r"); @84
assign double_pipe_ex2_cmp_r = ex2_special_value_vld ? ex2_cmp_special_r
                                                     : ex2_cmp_r;

//------------------------------------------------------------------------------
//                          Max/Min Normal Result:
//------------------------------------------------------------------------------
//To gengrate max/min rst
//In double, for timing design, max/min rst pipedown to ex3. Here in order to
//simplify rtu design, we also pipedown to ex3 in single
assign ex2_src0_f[51:0]              = dp_maxmin_src_a_f[51:0];
assign ex2_src0_e[10:0]              = dp_maxmin_src_a_e[10:0];
assign ex2_src0_s                    = dp_maxmin_src_a_s;
assign ex2_src1_sel[52:0]             = dp_maxmin_src_b_f[52:0];
assign ex2_src_chg                    = dp_maxmin_src_chg;
assign ex2_src1_e[10:0]               = dp_maxmin_src_b_e[10:0];
//assign ex2_src1_f[52:0]               = dp_maxmin_src_b_f[52:0];
assign ex2_src1_s                     = dp_maxmin_src_b_s;

assign ex2_double_src1_f[51:0]        = ex2_src1_sel[51:0];
assign ex2_single0_src1_f[22:0]       = ex2_src1_sel[22:0];
assign ex2_half0_src1_f[9:0]          = ex2_src1_sel[9:0];
assign ex2_bhalf0_src1_f[6:0]         = ex2_src1_sel[6:0];

//assign ex2_double_src1_e[10:0]        = ex2_src1_e[10:0];
//assign ex2_single0_src1_e[10:0]       = {3'b0,ex2_src1_sel[30:23]};
//assign ex2_half0_src1_e[10:0]         = {6'b0,ex2_src1_sel[14:10]};
//assign ex2_bhalf0_src1_e[10:0]        = {3'b0,ex2_src1_sel[14:7]};
//
//assign ex2_src1_e[10:0]               = {11{ex2_double}} & ex2_double_src1_e[10:0]  |
//                                        {11{ex2_single}} & ex2_single0_src1_e[10:0] |
//                                        {11{ex2_half}}   & ex2_half0_src1_e[10:0]   |
//                                        {11{ex2_bhalf}}  & ex2_bhalf0_src1_e[10:0];

//assign ex2_double_src0_f_tmp[52:0]    = ex2_act_sub         ? ~ex2_double_adder_a[52:0]    : ex2_double_adder_a[52:0];
assign ex2_double_src0_f[51:0]        = ex2_src0_f[51:0];
//assign ex2_single0_src0_f_tmp[23:0]   = ex2_act_sub         ? ~ex2_single0_adder_a[23:0]    : ex2_single0_adder_a[23:0];
assign ex2_single0_src0_f[22:0]       = ex2_src0_f[22:0];
//assign ex2_half0_src0_f_tmp[10:0]     = ex2_act_sub         ? ~ex2_half0_adder_a[10:0]    : ex2_half0_adder_a[10:0];
assign ex2_half0_src0_f[9:0]          = ex2_src0_f[9:0];
//assign ex2_bhalf0_src0_f_tmp[7:0]     = ex2_act_sub         ? ~ex2_bhalf0_adder_a[7:0]    : ex2_bhalf0_adder_a[7:0];
assign ex2_bhalf0_src0_f[6:0]         = ex2_src0_f[6:0];

assign ex2_sel_rst_both0_sign         =  ex2_op_max ? ex2_src0_s && ex2_src1_s : ex2_src0_s || ex2_src1_s;
assign ex2_sel_rst_max_s              =  ex2_act_s ^ ex2_src_chg ? ex2_src1_s  : ex2_src0_s;
assign ex2_sel_rst_min_s              = !ex2_act_s ^ ex2_src_chg ? ex2_src1_s  : ex2_src0_s;
assign ex2_double_sel_rst_max_f[51:0] =  ex2_act_s ^ ex2_src_chg ? ex2_double_src1_f[51:0] : ex2_double_src0_f[51:0];
assign ex2_double_sel_rst_min_f[51:0] = !ex2_act_s ^ ex2_src_chg ? ex2_double_src1_f[51:0] : ex2_double_src0_f[51:0];

assign ex2_single0_sel_rst_max_f[22:0] =  ex2_act_s ^ ex2_src_chg ? ex2_single0_src1_f[22:0] : ex2_single0_src0_f[22:0];
assign ex2_single0_sel_rst_min_f[22:0] = !ex2_act_s ^ ex2_src_chg ? ex2_single0_src1_f[22:0] : ex2_single0_src0_f[22:0];

assign ex2_half0_sel_rst_max_f[9:0] =  ex2_act_s ^ ex2_src_chg ? ex2_half0_src1_f[9:0] : ex2_half0_src0_f[9:0];
assign ex2_half0_sel_rst_min_f[9:0] = !ex2_act_s ^ ex2_src_chg ? ex2_half0_src1_f[9:0] : ex2_half0_src0_f[9:0];

assign ex2_bhalf0_sel_rst_max_f[6:0] =  ex2_act_s ^ ex2_src_chg ? ex2_bhalf0_src1_f[6:0] : ex2_bhalf0_src0_f[6:0];
assign ex2_bhalf0_sel_rst_min_f[6:0] = !ex2_act_s ^ ex2_src_chg ? ex2_bhalf0_src1_f[6:0] : ex2_bhalf0_src0_f[6:0];

assign ex2_sel_final_sign            = ex2_both_zero ? ex2_sel_rst_both0_sign :
                                       ex2_op_max    ? ex2_sel_rst_max_s
                                                     : ex2_sel_rst_min_s;
assign ex2_sel_rst_max_e[10:0] =  ex2_act_s ^ ex2_src_chg ? ex2_src1_e[10:0] : ex2_src0_e[10:0];
assign ex2_sel_rst_min_e[10:0] = !ex2_act_s ^ ex2_src_chg ? ex2_src1_e[10:0] : ex2_src0_e[10:0];
assign ex2_sel_final_e[10:0]   = ex2_op_max ? ex2_sel_rst_max_e[10:0] : ex2_sel_rst_min_e[10:0];

assign ex2_double_sel_final_f[51:0]   = ex2_op_max ? ex2_double_sel_rst_max_f[51:0] : ex2_double_sel_rst_min_f[51:0];
assign ex2_single0_sel_final_f[22:0]  = ex2_op_max ? ex2_single0_sel_rst_max_f[22:0] : ex2_single0_sel_rst_min_f[22:0];
assign ex2_half0_sel_final_f[9:0]     = ex2_op_max ? ex2_half0_sel_rst_max_f[9:0] : ex2_half0_sel_rst_min_f[9:0];
assign ex2_bhalf0_sel_final_f[6:0]    = ex2_op_max ? ex2_bhalf0_sel_rst_max_f[6:0] : ex2_bhalf0_sel_rst_min_f[6:0];







// &ModuleEnd; @168
endmodule




