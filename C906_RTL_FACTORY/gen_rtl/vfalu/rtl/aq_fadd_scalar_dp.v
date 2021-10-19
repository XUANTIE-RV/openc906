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
module aq_fadd_scalar_dp(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_yy_clk_en,
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
  fadd_ex2_nocmp,
  fadd_ex2_pipe_clk,
  fadd_ex2_pipedown,
  fadd_ex3_bhalf0_rslt,
  fadd_ex3_double_rslt,
  fadd_ex3_half0_rslt,
  fadd_ex3_pipedown,
  fadd_ex3_single0_rslt,
  fadd_half0_src0,
  fadd_half0_src1,
  fadd_single0_src0,
  fadd_single0_src1,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vfalu_vpu_ex2_gpr_result,
  vfalu_vpu_ex2_result_ready_in_ex3,
  vfalu_vpu_ex3_fflags,
  vfalu_vpu_ex3_fpr_result,
  vfalu_vpu_ex3_result_ready_in_ex4,
  vfalu_vpu_ex4_fflags,
  vfalu_vpu_ex4_fpr_result,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_rm,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1,
  vpu_group_1_xx_ex1_srcv1_type,
  vpu_group_1_xx_ex2_rm
);

// &Ports; @27
input           cp0_vpu_icg_en;                   
input           cp0_vpu_xx_bf16;                  
input           cp0_yy_clk_en;                    
input           double_pipe_ex2_cmp_r;            
input   [4 :0]  double_pipe_ex3_expt;             
input   [8 :0]  ex1_bhalf0_adder_a_final;         
input   [15:0]  ex1_bhalf0_special_data;          
input   [53:0]  ex1_double_adder_a_final;         
input   [63:0]  ex1_double_special_data;          
input   [11:0]  ex1_half0_adder_a_final;          
input   [15:0]  ex1_half0_special_data;           
input   [24:0]  ex1_single0_adder_a_final;        
input   [31:0]  ex1_single0_special_data;         
input   [8 :0]  ex2_bhalf0_rslt;                  
input   [53:0]  ex2_double_rslt;                  
input   [11:0]  ex2_half0_rslt;                   
input   [24:0]  ex2_single0_rslt;                 
input           fadd_ex1_pipe_clk;                
input           fadd_ex1_pipedown;                
input           fadd_ex2_pipe_clk;                
input           fadd_ex2_pipedown;                
input   [63:0]  fadd_ex3_bhalf0_rslt;             
input   [63:0]  fadd_ex3_double_rslt;             
input   [63:0]  fadd_ex3_half0_rslt;              
input           fadd_ex3_pipedown;                
input   [63:0]  fadd_ex3_single0_rslt;            
input           forever_cpuclk;                   
input           ifu_vpu_warm_up;                  
input           pad_yy_icg_scan_en;               
input   [19:0]  vpu_group_1_xx_ex1_func;          
input   [2 :0]  vpu_group_1_xx_ex1_rm;            
input   [63:0]  vpu_group_1_xx_ex1_srcv0;         
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type;    
input   [63:0]  vpu_group_1_xx_ex1_srcv1;         
input   [47:0]  vpu_group_1_xx_ex1_srcv1_type;    
input   [2 :0]  vpu_group_1_xx_ex2_rm;            
output          double_pipe_ex1_src0_cnan;        
output          double_pipe_ex1_src0_id;          
output          double_pipe_ex1_src0_inf;         
output          double_pipe_ex1_src0_qnan;        
output          double_pipe_ex1_src0_snan;        
output          double_pipe_ex1_src0_zero;        
output          double_pipe_ex1_src1_cnan;        
output          double_pipe_ex1_src1_id;          
output          double_pipe_ex1_src1_inf;         
output          double_pipe_ex1_src1_qnan;        
output          double_pipe_ex1_src1_snan;        
output          double_pipe_ex1_src1_zero;        
output  [63:0]  double_pipe_ex2_special_result;   
output          ex1_bhalf;                        
output          ex1_double;                       
output          ex1_f16;                          
output          ex1_half;                         
output          ex1_op_add;                       
output          ex1_op_add_sub;                   
output          ex1_op_cmp;                       
output          ex1_op_sel;                       
output          ex1_op_sub;                       
output          ex1_rdn;                          
output          ex1_single;                       
output          ex2_bhalf;                        
output          ex2_double;                       
output  [53:0]  ex2_double_adder_a;               
output          ex2_half;                         
output          ex2_op_add_sub;                   
output          ex2_op_cmp;                       
output          ex2_op_feq;                       
output          ex2_op_fle;                       
output          ex2_op_flt;                       
output          ex2_op_fne;                       
output          ex2_op_ford;                      
output          ex2_op_max;                       
output          ex2_op_min;                       
output          ex2_op_sel;                       
output          ex2_op_sub;                       
output          ex2_rdn;                          
output          ex2_rmm;                          
output          ex2_rne;                          
output          ex2_rtz;                          
output          ex2_rup;                          
output          ex2_single;                       
output          ex3_bhalf;                        
output  [8 :0]  ex3_bhalf0_result;                
output          ex3_double;                       
output  [53:0]  ex3_double_result;                
output          ex3_half;                         
output  [11:0]  ex3_half0_result;                 
output          ex3_op_cmp;                       
output          ex3_op_sel;                       
output          ex3_rdn;                          
output          ex3_rtz;                          
output          ex3_rup;                          
output          ex3_single;                       
output  [24:0]  ex3_single0_result;               
output  [63:0]  fadd_double_src0;                 
output  [63:0]  fadd_double_src1;                 
output          fadd_ex2_nocmp;                   
output  [15:0]  fadd_half0_src0;                  
output  [15:0]  fadd_half0_src1;                  
output  [31:0]  fadd_single0_src0;                
output  [31:0]  fadd_single0_src1;                
output  [63:0]  vfalu_vpu_ex2_gpr_result;         
output          vfalu_vpu_ex2_result_ready_in_ex3; 
output  [4 :0]  vfalu_vpu_ex3_fflags;             
output  [63:0]  vfalu_vpu_ex3_fpr_result;         
output          vfalu_vpu_ex3_result_ready_in_ex4; 
output  [4 :0]  vfalu_vpu_ex4_fflags;             
output  [63:0]  vfalu_vpu_ex4_fpr_result;         

// &Regs; @28
reg     [53:0]  ex2_adder_a;                      
reg             ex2_bhalf;                        
reg             ex2_double;                       
reg             ex2_half;                         
reg             ex2_op_add_sub;                   
reg             ex2_op_cmp;                       
reg             ex2_op_feq;                       
reg             ex2_op_fle;                       
reg             ex2_op_flt;                       
reg             ex2_op_fne;                       
reg             ex2_op_ford;                      
reg             ex2_op_max;                       
reg             ex2_op_min;                       
reg             ex2_op_sel;                       
reg             ex2_op_sub;                       
reg             ex2_single;                       
reg     [63:0]  ex2_special_result;               
reg             ex3_bhalf;                        
reg             ex3_double;                       
reg     [53:0]  ex3_final_rslt;                   
reg             ex3_half;                         
reg             ex3_op_cmp;                       
reg             ex3_op_sel;                       
reg             ex3_rdn;                          
reg             ex3_rtz;                          
reg             ex3_rup;                          
reg             ex3_single;                       
reg     [4 :0]  ex4_expt;                         
reg     [63:0]  ex4_result;                       

// &Wires; @29
wire            cp0_vpu_icg_en;                   
wire            cp0_vpu_xx_bf16;                  
wire            cp0_yy_clk_en;                    
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
wire    [2 :0]  dp_xx_ex1_rm;                     
wire            ex1_bhalf;                        
wire    [8 :0]  ex1_bhalf0_adder_a_final;         
wire    [15:0]  ex1_bhalf0_special_data;          
wire            ex1_bhalf0_src0_id;               
wire            ex1_bhalf0_src1_id;               
wire            ex1_double;                       
wire    [53:0]  ex1_double_adder_a_final;         
wire    [63:0]  ex1_double_special_data;          
wire            ex1_double_src0_id;               
wire            ex1_double_src1_id;               
wire            ex1_f16;                          
wire            ex1_half;                         
wire    [11:0]  ex1_half0_adder_a_final;          
wire    [15:0]  ex1_half0_special_data;           
wire            ex1_half0_src0_id;                
wire            ex1_half0_src1_id;                
wire    [63:0]  ex1_norm_src0;                    
wire    [63:0]  ex1_norm_src1;                    
wire            ex1_op_add;                       
wire            ex1_op_add_sub;                   
wire            ex1_op_cmp;                       
wire            ex1_op_feq;                       
wire            ex1_op_fle;                       
wire            ex1_op_flt;                       
wire            ex1_op_fne;                       
wire            ex1_op_ford;                      
wire            ex1_op_max;                       
wire            ex1_op_min;                       
wire            ex1_op_sel;                       
wire            ex1_op_sub;                       
wire            ex1_org_f16;                      
wire            ex1_rdn;                          
wire            ex1_single;                       
wire    [24:0]  ex1_single0_adder_a_final;        
wire    [31:0]  ex1_single0_special_data;         
wire            ex1_single0_src0_id;              
wire            ex1_single0_src1_id;              
wire            ex1_special_maxmin_pipe_down;     
wire    [63:0]  ex1_special_result_pack;          
wire    [53:0]  ex2_adder_a_pre;                  
wire    [8 :0]  ex2_bhalf0_rslt;                  
wire    [53:0]  ex2_double_adder_a;               
wire    [53:0]  ex2_double_rslt;                  
wire    [53:0]  ex2_final_rslt_pack;              
wire    [11:0]  ex2_half0_rslt;                   
wire    [53:0]  ex2_no_cmp_result_pack;           
wire    [53:0]  ex2_nor_final_rslt_pack;          
wire            ex2_rdn;                          
wire            ex2_rmm;                          
wire            ex2_rne;                          
wire            ex2_rtz;                          
wire            ex2_rup;                          
wire    [24:0]  ex2_single0_rslt;                 
wire    [8 :0]  ex3_bhalf0_result;                
wire    [53:0]  ex3_double_result;                
wire            ex3_ex4_clk;                      
wire            ex3_ex4_clk_en;                   
wire            ex3_ex4_pipe_vld;                 
wire    [11:0]  ex3_half0_result;                 
wire    [24:0]  ex3_single0_result;               
wire    [4 :0]  ex4_expt_pre;                     
wire    [63:0]  ex4_result_pre;                   
wire    [63:0]  fadd_double_src0;                 
wire    [63:0]  fadd_double_src1;                 
wire            fadd_ex1_pipe_clk;                
wire            fadd_ex1_pipedown;                
wire            fadd_ex2_nocmp;                   
wire            fadd_ex2_pipe_clk;                
wire            fadd_ex2_pipedown;                
wire    [63:0]  fadd_ex3_bhalf0_rslt;             
wire    [63:0]  fadd_ex3_double_rslt;             
wire    [63:0]  fadd_ex3_half0_rslt;              
wire            fadd_ex3_pipedown;                
wire    [63:0]  fadd_ex3_single0_rslt;            
wire    [15:0]  fadd_half0_src0;                  
wire            fadd_half0_src0_cnan;             
wire            fadd_half0_src0_id;               
wire            fadd_half0_src0_inf;              
wire            fadd_half0_src0_qnan;             
wire            fadd_half0_src0_snan;             
wire            fadd_half0_src0_zero;             
wire    [15:0]  fadd_half0_src1;                  
wire            fadd_half0_src1_cnan;             
wire            fadd_half0_src1_id;               
wire            fadd_half0_src1_inf;              
wire            fadd_half0_src1_qnan;             
wire            fadd_half0_src1_snan;             
wire            fadd_half0_src1_zero;             
wire    [31:0]  fadd_single0_src0;                
wire            fadd_single0_src0_cnan;           
wire            fadd_single0_src0_id;             
wire            fadd_single0_src0_inf;            
wire            fadd_single0_src0_qnan;           
wire            fadd_single0_src0_snan;           
wire            fadd_single0_src0_zero;           
wire    [31:0]  fadd_single0_src1;                
wire            fadd_single0_src1_cnan;           
wire            fadd_single0_src1_id;             
wire            fadd_single0_src1_inf;            
wire            fadd_single0_src1_qnan;           
wire            fadd_single0_src1_snan;           
wire            fadd_single0_src1_zero;           
wire            forever_cpuclk;                   
wire            ifu_vpu_warm_up;                  
wire            pad_yy_icg_scan_en;               
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
wire            src1_double_id;                   
wire            src1_double_inf;                  
wire            src1_double_qnan;                 
wire            src1_double_snan;                 
wire            src1_double_zero;                 
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
wire    [63:0]  vfalu_vpu_ex2_gpr_result;         
wire            vfalu_vpu_ex2_result_ready_in_ex3; 
wire    [4 :0]  vfalu_vpu_ex3_fflags;             
wire    [63:0]  vfalu_vpu_ex3_fpr_result;         
wire            vfalu_vpu_ex3_result_ready_in_ex4; 
wire    [4 :0]  vfalu_vpu_ex4_fflags;             
wire    [63:0]  vfalu_vpu_ex4_fpr_result;         
wire    [2 :0]  vpu_group_0_xx_ex2_rm;            
wire    [19:0]  vpu_group_1_xx_ex1_func;          
wire    [2 :0]  vpu_group_1_xx_ex1_rm;            
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;         
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;    
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;         
wire    [47:0]  vpu_group_1_xx_ex1_srcv1_type;    
wire    [2 :0]  vpu_group_1_xx_ex2_rm;            


// &Force("bus", "dp_xx_ex1_cnan", 2, 0); @31
// &Force("bus", "dp_xx_ex1_snan", 2, 0); @32
// &Force("bus", "dp_xx_ex1_qnan", 2, 0); @33
// &Force("bus", "dp_xx_ex1_norm", 2, 0); @34
// &Force("bus", "dp_xx_ex1_zero", 2, 0); @35
// &Force("bus", "dp_xx_ex1_inf", 2, 0); @36
// &Force("bus", "dp_xx_ex1_id", 2, 0); @37
// &Force("bus", "vpu_group_1_xx_ex1_func", 19, 0); @38
//==============================================================================
//                     EX1 Operation
//==============================================================================
//------------------------------------------------------------------------------
//                    Interface with idu :
//------------------------------------------------------------------------------



//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+





//convert
//  10                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| max |      |      max   max  | min | 
//+------+------+-----+--+--------+------+------+-------+-------+


//compare
//                 6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |  cmp         fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+


//cnvt

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|        clas    |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+


//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+

//compare
//                 6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |  cmp        fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+

// TBD 

assign ex1_op_add_sub  = vpu_group_1_xx_ex1_func[7];
assign ex1_op_add      = vpu_group_1_xx_ex1_func[7] &&  vpu_group_1_xx_ex1_func[4];
assign ex1_op_sub      = vpu_group_1_xx_ex1_func[7] &&  vpu_group_1_xx_ex1_func[3];
// &Force("output","ex1_op_sub"); @129
assign ex1_op_fle      = vpu_group_1_xx_ex1_func[6] &&  vpu_group_1_xx_ex1_func[2];
assign ex1_op_feq      = vpu_group_1_xx_ex1_func[6] &&  vpu_group_1_xx_ex1_func[0];
assign ex1_op_flt      = vpu_group_1_xx_ex1_func[6] &&  vpu_group_1_xx_ex1_func[1];
assign ex1_op_ford     = ex1_op_cmp && vpu_group_1_xx_ex1_func[3];
assign ex1_op_fne      = ex1_op_cmp && vpu_group_1_xx_ex1_func[4];
// //&Force("output","ex1_op_ford"); @135
assign ex1_op_max      = vpu_group_1_xx_ex1_func[5] &&  vpu_group_1_xx_ex1_func[4];
assign ex1_op_min      = vpu_group_1_xx_ex1_func[5] &&  vpu_group_1_xx_ex1_func[3];
assign ex1_op_sel      = vpu_group_1_xx_ex1_func[5];

assign ex1_op_cmp      = vpu_group_1_xx_ex1_func[6];




// &Force("output","ex1_op_cmp"); @145
// &Force("output","ex1_op_add_sub"); @146


assign ex1_single      = vpu_group_1_xx_ex1_func[13:12] == 2'b10;
assign ex1_double      = vpu_group_1_xx_ex1_func[13:12] == 2'b11;
assign ex1_half        = ex1_f16 && !cp0_vpu_xx_bf16 ;
assign ex1_bhalf       = ex1_f16 && cp0_vpu_xx_bf16;
assign ex1_org_f16     = (vpu_group_1_xx_ex1_func[13:12] == 2'b01);
assign ex1_f16         = ex1_org_f16;
// &Force("output","ex1_f16"); @155

// &Force("output","ex1_double"); @157
// &Force("output","ex1_single"); @158
// &Force("output","ex1_half"); @159
// &Force("output","ex1_bhalf"); @160

// //&Force("output","ex1_op_feq"); @162
// //&Force("output","ex1_op_fle"); @163
// //&Force("output","ex1_op_flt"); @164
// //&Force("output","ex1_op_fne"); @165
// &Force("output","ex1_op_sel"); @166

assign ex1_rdn         = dp_xx_ex1_rm[2:0] == 3'b010;

//------------------------------------------------------------------------------
//                    common special information
//------------------------------------------------------------------------------
//TBD, there will be the inner forward path 
assign  ex1_double_src0_id  = src0_double_id;
assign  ex1_double_src1_id  = src1_double_id;
assign  ex1_single0_src0_id = fadd_single0_src0_id;
assign  ex1_single0_src1_id = fadd_single0_src1_id;
assign  ex1_half0_src0_id = fadd_half0_src0_id;
assign  ex1_half0_src1_id = fadd_half0_src1_id;
assign  ex1_bhalf0_src0_id = fadd_half0_src0_id;
assign  ex1_bhalf0_src1_id = fadd_half0_src1_id;


assign double_pipe_ex1_src0_id = ex1_double  && ex1_double_src0_id  || 
                                 ex1_single  && ex1_single0_src0_id ||
                                (ex1_half)   && ex1_half0_src0_id   ||
                                (ex1_bhalf)  && ex1_bhalf0_src0_id;
assign double_pipe_ex1_src1_id = ex1_double   && ex1_double_src1_id  || 
                                 ex1_single   && ex1_single0_src1_id ||
                                 (ex1_half)   && ex1_half0_src1_id   ||
                                 (ex1_bhalf)  && ex1_bhalf0_src1_id;

// //&Force("output","ex1_half0_src1_id"); @193


 
assign srcv0_type[47:0]          = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign srcv1_type[47:0]          = vpu_group_1_xx_ex1_srcv1_type[47:0];
assign src0_double_snan          = srcv0_type[47];
assign src0_double_qnan          = srcv0_type[46];
assign src0_double_inf           = srcv0_type[45];
assign src0_double_zero          = srcv0_type[44];
assign src0_double_id            = srcv0_type[43];
//assign src0_double_norm        = srcv0_type[42];
assign src0_single0_cnan         = srcv0_type[41];
assign src0_single0_snan         = srcv0_type[40];
assign src0_single0_qnan         = srcv0_type[39];
assign src0_single0_inf          = srcv0_type[38];
assign src0_single0_zero         = srcv0_type[37];
assign src0_single0_id           = srcv0_type[36];
//assign src0_single0_norm         : srcv0_type[35];

assign src0_half0_cnan           = srcv0_type[27];
assign src0_half0_snan           = srcv0_type[26];
assign src0_half0_qnan           = srcv0_type[25];
assign src0_half0_inf            = srcv0_type[24];
assign src0_half0_zero           = srcv0_type[23];
assign src0_half0_id             = srcv0_type[22];
//assign src0_half0_norm           : srcv0_type[21];


assign src1_double_snan          = srcv1_type[47];
assign src1_double_qnan          = srcv1_type[46];
assign src1_double_inf           = srcv1_type[45];
assign src1_double_zero          = srcv1_type[44];
assign src1_double_id            = srcv1_type[43];
//assign src1_double_norm          : srcv1_type[42];
assign src1_single0_cnan         = srcv1_type[41];
assign src1_single0_snan         = srcv1_type[40];
assign src1_single0_qnan         = srcv1_type[39];
assign src1_single0_inf          = srcv1_type[38];
assign src1_single0_zero         = srcv1_type[37];
assign src1_single0_id           = srcv1_type[36];
//assign src1_single0_norm         : srcv1_type[35];
assign src1_half0_cnan           = srcv1_type[27];
assign src1_half0_snan           = srcv1_type[26];
assign src1_half0_qnan           = srcv1_type[25];
assign src1_half0_inf            = srcv1_type[24];
assign src1_half0_zero           = srcv1_type[23];
assign src1_half0_id             = srcv1_type[22];
//assign src1_half0_norm           : srcv1_type[21];




assign fadd_single0_src0_cnan     = src0_single0_cnan;
assign fadd_single0_src1_cnan     = src1_single0_cnan;
assign fadd_half0_src0_cnan       = src0_half0_cnan;
assign fadd_half0_src1_cnan       = src1_half0_cnan;


assign fadd_single0_src0_snan     = src0_single0_snan;
assign fadd_single0_src1_snan     = src1_single0_snan;
assign fadd_half0_src0_snan       = src0_half0_snan;
assign fadd_half0_src1_snan       = src1_half0_snan;

assign fadd_single0_src0_qnan     = src0_single0_qnan;
assign fadd_single0_src1_qnan     = src1_single0_qnan;
assign fadd_half0_src0_qnan       = src0_half0_qnan;
assign fadd_half0_src1_qnan       = src1_half0_qnan;


assign fadd_single0_src0_inf     = src0_single0_inf;
assign fadd_single0_src1_inf     = src1_single0_inf;
assign fadd_half0_src0_inf       = src0_half0_inf;
assign fadd_half0_src1_inf       = src1_half0_inf;

assign fadd_single0_src0_zero     = src0_single0_zero;
assign fadd_single0_src1_zero     = src1_single0_zero;
assign fadd_half0_src0_zero       = src0_half0_zero;
assign fadd_half0_src1_zero       = src1_half0_zero;

assign fadd_single0_src0_id     = src0_single0_id;
assign fadd_single0_src1_id     = src1_single0_id;
assign fadd_half0_src0_id       = src0_half0_id;
assign fadd_half0_src1_id       = src1_half0_id;


assign double_pipe_ex1_src0_cnan = ex1_single  && fadd_single0_src0_cnan || (ex1_half || ex1_bhalf ) && fadd_half0_src0_cnan;
assign double_pipe_ex1_src1_cnan = ex1_single  && fadd_single0_src1_cnan || (ex1_half || ex1_bhalf ) && fadd_half0_src1_cnan;
assign double_pipe_ex1_src0_snan = ex1_double && src0_double_snan || ex1_single && fadd_single0_src0_snan || (ex1_half || ex1_bhalf) && fadd_half0_src0_snan ;
assign double_pipe_ex1_src1_snan = ex1_double && src1_double_snan || ex1_single && fadd_single0_src1_snan || (ex1_half || ex1_bhalf) && fadd_half0_src1_snan ;
assign double_pipe_ex1_src0_qnan = ex1_double && src0_double_qnan || ex1_single &&  fadd_single0_src0_qnan || (ex1_half || ex1_bhalf) && fadd_half0_src0_qnan ;
assign double_pipe_ex1_src1_qnan = ex1_double && src1_double_qnan || ex1_single && fadd_single0_src1_qnan || (ex1_half || ex1_bhalf) && fadd_half0_src1_qnan ;
assign double_pipe_ex1_src0_inf  = ex1_double && src0_double_inf || ex1_single && fadd_single0_src0_inf || (ex1_half || ex1_bhalf) && fadd_half0_src0_inf  ;
assign double_pipe_ex1_src1_inf  = ex1_double && src1_double_inf || ex1_single && fadd_single0_src1_inf || (ex1_half || ex1_bhalf) && fadd_half0_src1_inf  ;
assign double_pipe_ex1_src0_zero = ex1_double && src0_double_zero || ex1_single && fadd_single0_src0_zero || (ex1_half || ex1_bhalf) && fadd_half0_src0_zero ;
assign double_pipe_ex1_src1_zero = ex1_double && src1_double_zero || ex1_single && fadd_single0_src1_zero || (ex1_half || ex1_bhalf) && fadd_half0_src1_zero ;


//================================
//
//  ex1 operand prepare
//
//================================
// the operand will encounter the inner forward data

assign ex1_norm_src0[63:0]         = vpu_group_1_xx_ex1_srcv0[63:0];
assign ex1_norm_src1[63:0]         = vpu_group_1_xx_ex1_srcv1[63:0];

assign fadd_double_src0[63:0]      = vpu_group_1_xx_ex1_srcv0[63:0];
assign fadd_double_src1[63:0]      = vpu_group_1_xx_ex1_srcv1[63:0];

assign fadd_single0_src0[31:0]     = ex1_norm_src0[31:0];
                                                   
assign fadd_single0_src1[31:0]     = ex1_norm_src1[31:0];

                                                     
assign fadd_half0_src0[15:0]       = ex1_norm_src0[15:0];
assign fadd_half0_src1[15:0]       = ex1_norm_src1[15:0];

//assign fadd_bhalf0_src0[15:0]      = fadd_half0_src0[15:0];
//assign fadd_bhalf0_src1[15:0]      = fadd_half0_src1[15:0];
//assign fadd_bhalf1_src0[15:0]      = fadd_half1_src0[15:0];
//assign fadd_bhalf1_src1[15:0]      = fadd_half1_src1[15:0];
//assign fadd_bhalf2_src0[15:0]      = fadd_half2_src0[15:0];
//assign fadd_bhalf2_src1[15:0]      = fadd_half2_src1[15:0];
//assign fadd_bhalf3_src0[15:0]      = fadd_half3_src0[15:0];
//assign fadd_bhalf3_src1[15:0]      = fadd_half3_src1[15:0];
// &Force("output","fadd_half0_src0"); @320
// &Force("output","fadd_half0_src1"); @321






//======================================
//
// the shift operator
//
//======================================    
// the reused non shift
// //&ConnRule(s/data_out/shift/); @334
// //&ConnRule(s/_data_g_out/_g_bit/); @335
// //&ConnRule(s/_data_r_out/_r_bit/); @336
// //&ConnRule(s/_data_s_out/_s_bit/); @337
// //&ConnRule(s/shift_num_in/shift_pre/); @338
// //&ConnRule(s/shift_cnt/ed/); @339
// //&ConnRule(s/input_ex1/ex1/); @340
//&Instance("aq_fadd_align_shift2");
// //&Connect(.ex1_half1_shift_num_in(11'b0), @342
// //         .ex1_bhalf1_shift_num_in(8'b0), @343
// //         .ex1_half2_shift_num_in(11'b0), @344
// //         .ex1_bhalf2_shift_num_in(8'b0), @345
// //         .ex1_half3_shift_num_in(11'b0), @346
// //         .ex1_bhalf3_shift_num_in(8'b0), @347
// //         .ex1_single1_shift_num_in(24'b0), @348
// //         .half_pipe0_shift_cnt(4'b0), @349
// //         .half_pipe1_shift_cnt(4'b0), @350
// //         .single_pipe_shift_cnt(5'b0), @351
// //         ); @352
//
//assign ex2_adder_b_pre[127:0] = {128{ex1_double}} & {s24_shift_0_result[63:0],s24_shift_1_result[63:0]}  |
//                                {128{ex1_single}} & {s24_shift_0_result[63:0],s24_shift_1_result[63:0]} |
//                                {128{ex1_half||ex1_bhalf}} & {s16_shift_0_result[31:0],s16_shift_1_result[31:0],
//                                                             s16_shift_2_result[31:0],s16_shift_3_result[31:0]};


assign ex2_adder_a_pre[53:0] = {54{ex1_double}} &  ex1_double_adder_a_final[53:0]         |
                               {54{ex1_single}} & {5'b0,24'b0,ex1_single0_adder_a_final[24:0]} |
                               {54{ex1_half}}   & {7'b0,11'b0,
                                                        11'b0,2'b0,
                                                        11'b0,
                                                        ex1_half0_adder_a_final[11:0]} |
                               {54{ex1_bhalf}}  & {10'b0,8'b0,3'b0,
                                                         8'b0,3'b0,2'b0,
                                                         8'b0,3'b0,
                                                         ex1_bhalf0_adder_a_final[8:0]};
//assign ex2_adder_b_pre[52:0] = {53{ex1_double}} &  ex1_double_adder_b_final[52:0]         |
//                               {53{ex1_single}} & {5'b0,ex1_single1_adder_b_final[23:0],ex1_single0_adder_b_final[23:0]} |
//                               {53{ex1_half}}   & {7'b0,ex1_half3_adder_b_final[10:0],
//                                                        ex1_half2_adder_b_final[10:0],2'b0,
//                                                        ex1_half1_adder_b_final[10:0],
//                                                        ex1_half0_adder_b_final[10:0]} |
//                               {53{ex1_bhalf}}  & {10'b0,ex1_bhalf3_adder_b_final[7:0],3'b0,
//                                                        ex1_bhalf2_adder_b_final[7:0],3'b0,2'b0,
//                                                        ex1_bhalf1_adder_b_final[7:0],3'b0,
//                                                        ex1_bhalf0_adder_b_final[7:0]};
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown) begin
    ex2_adder_a[53:0]   <= ex2_adder_a_pre[53:0];
//    ex2_adder_b[127:0]  <= ex2_adder_b_pre[127:0];
//    ex2_ed              <= double_pipe_ed[5];
  end
end

assign ex1_special_result_pack[63:0]  = {64{ex1_double}} & ex1_double_special_data[63:0]    |
                                        {64{ex1_single}} & {32'b0,ex1_single0_special_data[31:0]} |
                                        {64{ex1_half}} & {48'b0,
                                                          ex1_half0_special_data[15:0]}     |
                                        {64{ex1_bhalf}} & {48'b0,
                                                           ex1_bhalf0_special_data[15:0]};                 
assign ex1_special_maxmin_pipe_down = fadd_ex1_pipedown; 
always @(posedge fadd_ex1_pipe_clk)
begin
  if(ex1_special_maxmin_pipe_down) begin
    ex2_special_result[63:0]   <= ex1_special_result_pack[63:0];
  end
end
//assign ex1_half_dest_widden = ex1_dest_widden && ex1_org_f16 && !cp0_vpu_xx_bf16;
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown) begin
    ex2_op_add_sub    <= ex1_op_add_sub;
    ex2_op_sub        <= ex1_op_sub;
    ex2_op_cmp        <= ex1_op_cmp;
    ex2_op_sel        <= ex1_op_sel;
    ex2_op_max        <= ex1_op_max;
    ex2_op_min        <= ex1_op_min;
    ex2_single        <= ex1_single;
    ex2_double        <= ex1_double;
    ex2_half          <= ex1_half;
    ex2_bhalf         <= ex1_bhalf;
  end
end

// &Force("output","ex2_op_cmp"); @419
// &Force("output","ex2_op_sel"); @420
// &Force("output","ex2_op_cmp"); @421
// &Force("output","ex2_single"); @422
// &Force("output","ex2_double"); @423
// &Force("output","ex2_half"); @424
// &Force("output","ex2_bhalf"); @425
assign fadd_ex2_nocmp  = !ex2_op_cmp;

always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown && ex1_op_cmp || ifu_vpu_warm_up) begin
    ex2_op_fle    <= ex1_op_fle;
    ex2_op_feq    <= ex1_op_feq;
    ex2_op_flt    <= ex1_op_flt;
    ex2_op_fne    <= ex1_op_fne;
    ex2_op_ford   <= ex1_op_ford;
  end
end

assign ex2_rne      = vpu_group_0_xx_ex2_rm[2:0] == 3'b000;
assign ex2_rtz      = vpu_group_0_xx_ex2_rm[2:0] == 3'b001;
assign ex2_rup      = vpu_group_0_xx_ex2_rm[2:0] == 3'b011;
assign ex2_rdn      = vpu_group_0_xx_ex2_rm[2:0] == 3'b010;
assign ex2_rmm      = vpu_group_0_xx_ex2_rm[2:0] == 3'b100;

// &Force("output","ex2_rtz"); @445
// &Force("output","ex2_rdn"); @446
// &Force("output","ex2_rup"); @447



//=============================================
//
//  
//  EX2 Stage operation
//
//
//=============================================
assign double_pipe_ex2_special_result[63:0] = ex2_special_result[63:0];


assign ex2_double_adder_a[53:0]  = ex2_adder_a[53:0];
//assign ex2_single0_adder_a[23:0] = ex2_adder_a[23:0];
//assign ex2_half0_adder_a[10:0]   = ex2_adder_a[10:0];
//assign ex2_bhalf0_adder_a[7:0]   = ex2_adder_a[7:0];

// adder b
//TBD
//assign ex2_double_adder_b_total[127:0] = ex2_ed ? {32'b0,ex2_adder_b[127:96],
//                                                         ex2_adder_b[95:64]|ex2_adder_b[63:32],
//                                                         ex2_adder_b[31:0]}
//                                                : {ex2_adder_b[127:96],
//                                                   ex2_adder_b[95:64] | ex2_adder_b[63:32],
//                                                   ex2_adder_b[31:0],32'b0};
//assign ex2_double_adder_b[52:0]  = ex2_double_adder_b_total[127:75];
//assign ex2_double_adder_b_tail[54:0] = ex2_double_adder_b_total[74:20];    
//
//assign ex2_single0_adder_b[23:0]      = ex2_adder_b[127:104];
//assign ex2_single0_adder_b_tail[25:0] = ex2_adder_b[103:78];
//assign ex2_half0_adder_b[10:0]        = ex2_adder_b[127:117];
//assign ex2_half0_adder_b_tail[12:0]   = ex2_adder_b[116:104];
//assign ex2_bhalf0_adder_b[7:0]        = ex2_adder_b[127:120];
//assign ex2_bhalf0_adder_b_tail[9:0]   = ex2_adder_b[119:110];


//ex2 reuse adder
// there will be two 57bit adder, and two 31bit adder

// the 57bit adder will calculate: double half0,half1, single0
// the 31bit adder will calculate: single1 half2, half3

//TBD
//assign double_adder_op0[53:0]          = {54{ex2_double}} & ex2_double_adder_src0[53:0]   |
//                                         {54{ex2_single}} & {29'b0,ex2_single0_adder_src0[24:0]}|
//                                         {54{ex2_half}}    & {29'b0,12'b0,1'b0,
//                                                                    ex2_half0_adder_src0[11:0]} |
//                                         {54{ex2_bhalf}}   & {32'b0,9'b0,4'b0,
//                                                             ex2_bhalf0_adder_src0[8:0]};
//                                         
//assign double_adder_op1[53:0]          = {54{ex2_double}} & ex2_double_adder_src1[53:0]   |
//                                         {54{ex2_single}} & {29'b0,ex2_single0_adder_src1[24:0]}|
//                                         {54{ex2_half}}    & {29'b0,12'b0,1'b0,
//                                                             ex2_half0_adder_src1[11:0]} |
//                                         {54{ex2_bhalf}}   & {32'b0,9'b0,4'b0,
//                                                             ex2_bhalf0_adder_src1[8:0]};
//assign double_pipe_adder1_op2[53:0]     = double_pipe_ex2_act_add ? 54'd0 : 54'd1;
////a+b a+b+1
//assign double_adder1_op2[53:0]          = double_pipe_adder1_op2[53:0];
//assign double_pipe_adder2_op2[53:0]     = double_pipe_ex2_act_add ? 54'd2 : 54'd0;
//
//assign double_adder2_op2[53:0]          = double_pipe_adder2_op2[53:0];
////a+b a+b+1
//assign ex2_double_adder1_rslt[53:0] = double_adder_op0[53:0] 
//                                         + double_adder_op1[53:0] 
//                                         + double_adder1_op2[53:0];
//// a+b+16 a+b                                         
//assign ex2_double_adder2_rslt[53:0] = double_adder_op0[53:0] 
//                                         + double_adder_op1[53:0] 
//                                         + double_adder2_op2[53:0];
//
//assign ex2_double_pipe_add1_rslt[53:0] = ex2_double_adder1_rslt[53:0];
//assign ex2_double_pipe_add2_rslt[53:0] = ex2_double_adder2_rslt[53:0];



//============================================
//
// the srcv2 merging in, and reduction merging
//
//=============================================
// for the order reduction, the src1 will always been selected
// for unorder, src0/1 will be in exe mask
// for normal exe, the exe mask is maskoff the org resut, using the src2




assign dp_xx_ex1_rm[2:0]   = vpu_group_1_xx_ex1_rm[2:0];
assign vpu_group_0_xx_ex2_rm[2:0]   = vpu_group_1_xx_ex2_rm[2:0];
//assign dp_xx_ex3_rm[2:0]   = vpu_group_1_xx_ex3_rm[2:0];
//============================================
//
// the compare result operation
//
//=============================================
// the compare result will be reserved by 
// the dp,

//compare result    

//assign ex2_cmp_mask[7:0]  = vpu_group_1_xx_ex2_vl_byte_mask[7:0] & vpu_group_1_xx_ex2_vm_byte_mask[7:0];
assign ex2_nor_final_rslt_pack[53:0]       = {54{ex2_double}} & ex2_double_rslt[53:0] | 
                                             {54{ex2_single}} & {4'b0,25'b0,ex2_single0_rslt[24:0]} |
                                             {54{ex2_half}}   & {5'b0,24'b0,
                                                                 1'b0,12'b0,ex2_half0_rslt[11:0]}   |
                                             {54{ex2_bhalf}}  & {8'b0,9'b0,
                                                                 3'b0,9'b0,
                                                            1'b0,3'b0,9'b0,
                                                                 3'b0,ex2_bhalf0_rslt[8:0]};
assign ex2_no_cmp_result_pack[53:0]    = {ex2_nor_final_rslt_pack[53:0]};
assign ex2_final_rslt_pack[53:0]       = ex2_no_cmp_result_pack[53:0];
assign vfalu_vpu_ex2_gpr_result[63:0]  = {63'b0,double_pipe_ex2_cmp_r};

assign vfalu_vpu_ex2_result_ready_in_ex3 = !(ex2_double && !ex2_op_cmp);
always @(posedge fadd_ex2_pipe_clk)
begin
    if(fadd_ex2_pipedown) begin
     ex3_final_rslt[53:0]  <= ex2_final_rslt_pack[53:0];
  end
end

always @(posedge fadd_ex2_pipe_clk)
begin
  if(fadd_ex2_pipedown) begin
    ex3_single  <= ex2_single;
    ex3_double  <= ex2_double;
    ex3_half    <= ex2_half;
    ex3_bhalf   <= ex2_bhalf;
    ex3_op_cmp  <= ex2_op_cmp;
    ex3_op_sel  <= ex2_op_sel;
    ex3_rtz     <= ex2_rtz;
    ex3_rup     <= ex2_rup;
    ex3_rdn     <= ex2_rdn;
  end
end
// &Force("output","ex3_double"); @585
// &Force("output","ex3_single"); @586
// &Force("output","ex3_half"); @587
// &Force("output","ex3_bhalf"); @588
// &Force("output","ex3_op_cmp"); @589
//assign ex3_split_cnt[11:0] = {vpu_group_1_xx_ex3_split_count[3:0],vpu_group_1_xx_ex3_split_count[7:0]};
//============================================
//  ex3 compare result pack
//============================================




//============================================
//
//  ex 3 result
//============================================
//
//assign ex3_rne           = dp_xx_ex3_rm[2:0] == 3'b000;
//assign ex3_rtz           = dp_xx_ex3_rm[2:0] == 3'b001;
//assign ex3_rup           = dp_xx_ex3_rm[2:0] == 3'b011;
//assign ex3_rdn           = dp_xx_ex3_rm[2:0] == 3'b010;
//assign ex3_rmm           = dp_xx_ex3_rm[2:0] == 3'b100;


assign ex3_double_result[53:0]  = ex3_final_rslt[53:0];
assign ex3_single0_result[24:0] = ex3_final_rslt[24:0];
assign ex3_half0_result[11:0]   = ex3_final_rslt[11:0];
assign ex3_bhalf0_result[8:0]   = ex3_final_rslt[8:0];



assign vfalu_vpu_ex3_fpr_result[63:0]             = {64{ex3_single}} & fadd_ex3_single0_rslt[63:0] |
                                                    {64{ex3_half}}   & fadd_ex3_half0_rslt[63:0]   |
                                                    {64{ex3_bhalf}}  & fadd_ex3_bhalf0_rslt[63:0];
// for the vector compare, the exception will update when the last split
// instruction 
assign vfalu_vpu_ex3_fflags[4:0]                  = double_pipe_ex3_expt[4:0];
assign vfalu_vpu_ex3_result_ready_in_ex4          = (ex3_double );



assign ex4_expt_pre[4:0]                  = double_pipe_ex3_expt[4:0];
assign ex4_result_pre[63:0]               = fadd_ex3_double_rslt[63:0]; 
// &Instance("gated_clk_cell", "x_widden_denorm_clk"); @629
gated_clk_cell  x_widden_denorm_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_ex4_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_ex4_clk_en    ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk         ), @630
//          .external_en (1'b0                   ), @631
//          .global_en   (cp0_yy_clk_en          ), @632
//          .module_en   (cp0_vpu_icg_en         ), @633
//          .local_en    (ex3_ex4_clk_en   ), @634
//          .clk_out     (ex3_ex4_clk      )); @635

assign ex3_ex4_pipe_vld = (ex3_double) && fadd_ex3_pipedown  || ifu_vpu_warm_up;
assign ex3_ex4_clk_en   = ex3_ex4_pipe_vld;


//the next expt generate for unorder reduction
//TBD
always @(posedge ex3_ex4_clk)
begin
    if(ex3_ex4_pipe_vld) begin
        ex4_result[63:0]        <= ex4_result_pre[63:0];
        ex4_expt[4:0]           <= ex4_expt_pre[4:0];
    end
end
assign vfalu_vpu_ex4_fflags[4:0]      = ex4_expt[4:0];
assign vfalu_vpu_ex4_fpr_result[63:0] = ex4_result[63:0];

// &ModuleEnd; @653
endmodule


