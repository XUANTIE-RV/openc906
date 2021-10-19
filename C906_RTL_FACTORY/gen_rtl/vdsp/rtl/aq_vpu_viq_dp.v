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
module aq_vpu_viq_dp(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_rm,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  handle_double_vpu,
  handle_scalar_fpu,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  rbus_viqx_ex3_fpr_wb_grnt,
  rbus_viqx_ex3_gpr_wb_grnt,
  rbus_viqx_ex4_fpr_wb_grnt,
  rbus_viqx_ex5_fpr_wb_grnt,
  rtu_yy_xx_async_flush,
  vfalu_vpu_ex1_denormal_stall,
  vfalu_vpu_ex2_gpr_result,
  vfalu_vpu_ex2_result_ready_in_ex3,
  vfalu_vpu_ex3_fflags,
  vfalu_vpu_ex3_result_ready_in_ex4,
  vfalu_vpu_ex4_fflags,
  vfalu_vpu_ex4_fpr_result,
  vfcvt_vpu_ex2_gpr_result,
  vfcvt_vpu_ex3_fflags,
  vfdsu_vpu_busy,
  vfdsu_vpu_ex1_denormal_stall,
  vfdsu_vpu_state_idle,
  vfmau_vpu_ex2_result_ready_in_ex3,
  vfmau_vpu_ex3_fflags,
  vfmau_vpu_ex3_result_ready_in_ex4,
  vfmau_vpu_ex4_fflags,
  vfmau_vpu_ex4_fpr_result,
  vfmau_vpu_ex5_fflags,
  vfmau_vpu_ex5_fpr_result,
  vfspu_vpu_ex2_result,
  vidu_vpu_vid_fp_inst_dp_vld,
  vidu_vpu_vid_fp_inst_dst_reg,
  vidu_vpu_vid_fp_inst_dst_vld,
  vidu_vpu_vid_fp_inst_dste_vld,
  vidu_vpu_vid_fp_inst_dstf_reg,
  vidu_vpu_vid_fp_inst_dstf_vld,
  vidu_vpu_vid_fp_inst_eu,
  vidu_vpu_vid_fp_inst_func,
  vidu_vpu_vid_fp_inst_gateclk_vld,
  vidu_vpu_vid_fp_inst_src1_data,
  vidu_vpu_vid_fp_inst_srcf0_data,
  vidu_vpu_vid_fp_inst_srcf1_data,
  vidu_vpu_vid_fp_inst_srcf2_data,
  vidu_vpu_vid_fp_inst_srcf2_rdy,
  vidu_vpu_vid_fp_inst_srcf2_vld,
  vidu_vpu_vid_fp_inst_vld,
  viqs_xx_ex1_vint_sel,
  viqs_xx_ex2_vint_result_ready,
  viqs_xx_ex2_vint_sel,
  viqs_xx_ex3_vint_pipedown,
  viqs_xx_ex5_stall,
  viqx_rbus_ex3_fflags,
  viqx_rbus_ex3_fflags_vld,
  viqx_rbus_ex3_fpr_wb_data,
  viqx_rbus_ex3_fpr_wb_index,
  viqx_rbus_ex3_fpr_wb_req,
  viqx_rbus_ex3_fpu_wb_sel,
  viqx_rbus_ex3_gpr_wb_data,
  viqx_rbus_ex3_gpr_wb_index,
  viqx_rbus_ex3_gpr_wb_req,
  viqx_rbus_ex4_fflags,
  viqx_rbus_ex4_fflags_vld,
  viqx_rbus_ex4_fpr_wb_data,
  viqx_rbus_ex4_fpr_wb_index,
  viqx_rbus_ex4_fpr_wb_req,
  viqx_rbus_ex5_fflags,
  viqx_rbus_ex5_fflags_vld,
  viqx_rbus_ex5_fpr_wb_data,
  viqx_rbus_ex5_fpr_wb_index,
  viqx_rbus_ex5_fpr_wb_req,
  viqx_xx_ex1_eu_sel,
  viqx_xx_ex1_func,
  viqx_xx_ex1_gp_sel,
  viqx_xx_ex1_id_reg,
  viqx_xx_ex1_lsu_inst_vld,
  viqx_xx_ex1_rm,
  viqx_xx_ex1_srcv0,
  viqx_xx_ex1_srcv0_type,
  viqx_xx_ex1_srcv1,
  viqx_xx_ex1_srcv1_type,
  viqx_xx_ex1_srcv2,
  viqx_xx_ex1_srcv2_ready,
  viqx_xx_ex1_srcv2_type,
  viqx_xx_ex1_stall,
  viqx_xx_ex1_vreg,
  viqx_xx_ex2_eu_sel,
  viqx_xx_ex2_func,
  viqx_xx_ex2_gp_sel,
  viqx_xx_ex2_rm,
  viqx_xx_ex2_stall,
  viqx_xx_ex3_eu_sel,
  viqx_xx_ex3_func,
  viqx_xx_ex3_gp_sel,
  viqx_xx_ex3_rm,
  viqx_xx_ex3_stall,
  viqx_xx_ex4_eu_sel,
  viqx_xx_ex4_func,
  viqx_xx_ex4_gp_sel,
  viqx_xx_ex4_rm,
  viqx_xx_ex4_stall,
  viqx_xx_ex5_stall,
  viqx_xx_ex5_vld,
  viqx_xx_no_op,
  vlsu_vex1_split_stall
);

// &Ports; @24
input           cp0_vpu_icg_en;                   
input           cp0_vpu_xx_bf16;                  
input   [2 :0]  cp0_vpu_xx_rm;                    
input           cp0_yy_clk_en;                    
input           cpurst_b;                         
input           forever_cpuclk;                   
input           handle_double_vpu;                
input           handle_scalar_fpu;                
input           ifu_vpu_warm_up;                  
input           pad_yy_icg_scan_en;               
input           rbus_viqx_ex3_fpr_wb_grnt;        
input           rbus_viqx_ex3_gpr_wb_grnt;        
input           rbus_viqx_ex4_fpr_wb_grnt;        
input           rbus_viqx_ex5_fpr_wb_grnt;        
input           rtu_yy_xx_async_flush;            
input           vfalu_vpu_ex1_denormal_stall;     
input   [63:0]  vfalu_vpu_ex2_gpr_result;         
input           vfalu_vpu_ex2_result_ready_in_ex3; 
input   [4 :0]  vfalu_vpu_ex3_fflags;             
input           vfalu_vpu_ex3_result_ready_in_ex4; 
input   [4 :0]  vfalu_vpu_ex4_fflags;             
input   [63:0]  vfalu_vpu_ex4_fpr_result;         
input   [63:0]  vfcvt_vpu_ex2_gpr_result;         
input   [4 :0]  vfcvt_vpu_ex3_fflags;             
input           vfdsu_vpu_busy;                   
input           vfdsu_vpu_ex1_denormal_stall;     
input           vfdsu_vpu_state_idle;             
input           vfmau_vpu_ex2_result_ready_in_ex3; 
input   [4 :0]  vfmau_vpu_ex3_fflags;             
input           vfmau_vpu_ex3_result_ready_in_ex4; 
input   [4 :0]  vfmau_vpu_ex4_fflags;             
input   [63:0]  vfmau_vpu_ex4_fpr_result;         
input   [4 :0]  vfmau_vpu_ex5_fflags;             
input   [63:0]  vfmau_vpu_ex5_fpr_result;         
input   [63:0]  vfspu_vpu_ex2_result;             
input           vidu_vpu_vid_fp_inst_dp_vld;      
input   [5 :0]  vidu_vpu_vid_fp_inst_dst_reg;     
input           vidu_vpu_vid_fp_inst_dst_vld;     
input           vidu_vpu_vid_fp_inst_dste_vld;    
input   [4 :0]  vidu_vpu_vid_fp_inst_dstf_reg;    
input           vidu_vpu_vid_fp_inst_dstf_vld;    
input   [9 :0]  vidu_vpu_vid_fp_inst_eu;          
input   [19:0]  vidu_vpu_vid_fp_inst_func;        
input           vidu_vpu_vid_fp_inst_gateclk_vld; 
input   [63:0]  vidu_vpu_vid_fp_inst_src1_data;   
input   [63:0]  vidu_vpu_vid_fp_inst_srcf0_data;  
input   [63:0]  vidu_vpu_vid_fp_inst_srcf1_data;  
input   [63:0]  vidu_vpu_vid_fp_inst_srcf2_data;  
input           vidu_vpu_vid_fp_inst_srcf2_rdy;   
input           vidu_vpu_vid_fp_inst_srcf2_vld;   
input           vidu_vpu_vid_fp_inst_vld;         
input           viqs_xx_ex1_vint_sel;             
input           viqs_xx_ex2_vint_result_ready;    
input           viqs_xx_ex2_vint_sel;             
input           viqs_xx_ex3_vint_pipedown;        
input           viqs_xx_ex5_stall;                
input           vlsu_vex1_split_stall;            
output  [5 :0]  viqx_rbus_ex3_fflags;             
output          viqx_rbus_ex3_fflags_vld;         
output  [63:0]  viqx_rbus_ex3_fpr_wb_data;        
output  [4 :0]  viqx_rbus_ex3_fpr_wb_index;       
output          viqx_rbus_ex3_fpr_wb_req;         
output  [2 :0]  viqx_rbus_ex3_fpu_wb_sel;         
output  [63:0]  viqx_rbus_ex3_gpr_wb_data;        
output  [5 :0]  viqx_rbus_ex3_gpr_wb_index;       
output          viqx_rbus_ex3_gpr_wb_req;         
output  [5 :0]  viqx_rbus_ex4_fflags;             
output          viqx_rbus_ex4_fflags_vld;         
output  [63:0]  viqx_rbus_ex4_fpr_wb_data;        
output  [4 :0]  viqx_rbus_ex4_fpr_wb_index;       
output          viqx_rbus_ex4_fpr_wb_req;         
output  [5 :0]  viqx_rbus_ex5_fflags;             
output          viqx_rbus_ex5_fflags_vld;         
output  [63:0]  viqx_rbus_ex5_fpr_wb_data;        
output  [4 :0]  viqx_rbus_ex5_fpr_wb_index;       
output          viqx_rbus_ex5_fpr_wb_req;         
output  [9 :0]  viqx_xx_ex1_eu_sel;               
output  [19:0]  viqx_xx_ex1_func;                 
output  [3 :0]  viqx_xx_ex1_gp_sel;               
output  [1 :0]  viqx_xx_ex1_id_reg;               
output          viqx_xx_ex1_lsu_inst_vld;         
output  [2 :0]  viqx_xx_ex1_rm;                   
output  [63:0]  viqx_xx_ex1_srcv0;                
output  [47:0]  viqx_xx_ex1_srcv0_type;           
output  [63:0]  viqx_xx_ex1_srcv1;                
output  [47:0]  viqx_xx_ex1_srcv1_type;           
output  [63:0]  viqx_xx_ex1_srcv2;                
output          viqx_xx_ex1_srcv2_ready;          
output  [47:0]  viqx_xx_ex1_srcv2_type;           
output          viqx_xx_ex1_stall;                
output  [6 :0]  viqx_xx_ex1_vreg;                 
output  [9 :0]  viqx_xx_ex2_eu_sel;               
output  [19:0]  viqx_xx_ex2_func;                 
output  [3 :0]  viqx_xx_ex2_gp_sel;               
output  [2 :0]  viqx_xx_ex2_rm;                   
output          viqx_xx_ex2_stall;                
output  [9 :0]  viqx_xx_ex3_eu_sel;               
output  [19:0]  viqx_xx_ex3_func;                 
output  [3 :0]  viqx_xx_ex3_gp_sel;               
output  [2 :0]  viqx_xx_ex3_rm;                   
output          viqx_xx_ex3_stall;                
output  [9 :0]  viqx_xx_ex4_eu_sel;               
output  [19:0]  viqx_xx_ex4_func;                 
output  [3 :0]  viqx_xx_ex4_gp_sel;               
output  [2 :0]  viqx_xx_ex4_rm;                   
output          viqx_xx_ex4_stall;                
output          viqx_xx_ex5_stall;                
output          viqx_xx_ex5_vld;                  
output          viqx_xx_no_op;                    

// &Regs; @25
reg             ex1_dste_vld;                     
reg             ex1_dstf_vld;                     
reg             ex1_dstg_vld;                     
reg     [9 :0]  ex1_eu_sel;                       
reg     [19:0]  ex1_func;                         
reg     [3 :0]  ex1_gp_sel;                       
reg     [3 :0]  ex1_group_sel;                    
reg     [1 :0]  ex1_id_reg;                       
reg             ex1_inst_lsu;                     
reg             ex1_inst_vld;                     
reg     [5 :0]  ex1_reg;                          
reg     [2 :0]  ex1_rm;                           
reg     [63:0]  ex1_srcv0;                        
reg     [63:0]  ex1_srcv1;                        
reg     [63:0]  ex1_srcv2;                        
reg             ex1_srcv2_ready;                  
reg     [6 :0]  ex1_vreg;                         
reg             ex2_dste_vld;                     
reg             ex2_dstf_vld;                     
reg             ex2_dstg_vld;                     
reg     [9 :0]  ex2_eu_sel;                       
reg     [19:0]  ex2_func;                         
reg     [3 :0]  ex2_gp_sel;                       
reg             ex2_inst_vld;                     
reg     [5 :0]  ex2_reg;                          
reg     [2 :0]  ex2_rm;                           
reg     [6 :0]  ex2_vreg;                         
reg             ex3_dste_vld;                     
reg             ex3_dstf_vld;                     
reg             ex3_dstg_vld;                     
reg     [9 :0]  ex3_eu_sel;                       
reg     [4 :0]  ex3_fflags_out;                   
reg     [2 :0]  ex3_fpu_wb_sel;                   
reg     [19:0]  ex3_func;                         
reg     [3 :0]  ex3_gp_sel;                       
reg             ex3_gpr_wb_vld;                   
reg             ex3_inst_vld;                     
reg     [5 :0]  ex3_reg;                          
reg     [63:0]  ex3_result;                       
reg             ex3_result_ready;                 
reg     [2 :0]  ex3_rm;                           
reg     [6 :0]  ex3_vreg;                         
reg             ex4_dste_vld;                     
reg             ex4_dstf_vld;                     
reg     [9 :0]  ex4_eu_sel;                       
reg     [5 :0]  ex4_fflags_out;                   
reg     [63:0]  ex4_fpr_result_out;               
reg     [19:0]  ex4_func;                         
reg     [3 :0]  ex4_gp_sel;                       
reg             ex4_inst_vld;                     
reg             ex4_result_ready;                 
reg     [2 :0]  ex4_rm;                           
reg     [6 :0]  ex4_vreg;                         
reg             ex5_inst_vld;                     
reg     [6 :0]  ex5_vreg;                         

// &Wires; @26
wire            cp0_vpu_icg_en;                   
wire            cp0_vpu_xx_bf16;                  
wire    [2 :0]  cp0_vpu_xx_rm;                    
wire            cp0_yy_clk_en;                    
wire            cpurst_b;                         
wire            ex1_ctrl_clk;                     
wire            ex1_ctrl_clk_en;                  
wire            ex1_denorm_stall;                 
wire            ex1_denormal_clk;                 
wire            ex1_denormal_clk_en;              
wire            ex1_denormal_double;              
wire            ex1_denormal_half;                
wire            ex1_denormal_single;              
wire            ex1_div_stall;                    
wire    [1 :0]  ex1_double_id;                    
wire            ex1_dstv_vld;                     
wire            ex1_fp_denormal_stall;            
wire            ex1_fp_reduct_fwd_ex4;            
wire    [1 :0]  ex1_half0_id;                     
wire    [1 :0]  ex1_id_reg_updt;                  
wire            ex1_inst_clk;                     
wire            ex1_inst_clk_en;                  
wire            ex1_inst_sqrt;                    
wire            ex1_no_pipe_down;                 
wire    [47:0]  ex1_opvf_h;                       
wire    [1 :0]  ex1_single0_id;                   
wire    [47:0]  ex1_srcv0_high;                   
wire    [63:0]  ex1_srcv0_ori;                    
wire            ex1_srcv0_vec;                    
wire    [47:0]  ex1_srcv1_high;                   
wire    [63:0]  ex1_srcv1_ori;                    
wire            ex1_srcv1_vec;                    
wire            ex1_srcv2_clk;                    
wire            ex1_srcv2_clk_en;                 
wire    [47:0]  ex1_srcv2_high;                   
wire            ex1_srcv2_vec;                    
wire            ex1_stall;                        
wire            ex1_vfdsu_sel;                    
wire            ex1_vfmau_sel;                    
wire            ex1_vint_sync_stall;              
wire            ex1_vlsu_stall;                   
wire            ex2_ctrl_clk;                     
wire            ex2_ctrl_clk_en;                  
wire    [2 :0]  ex2_fpu_wb_sel;                   
wire            ex2_inst_clk;                     
wire            ex2_inst_clk_en;                  
wire            ex2_no_pipe_down;                 
wire    [63:0]  ex2_result_new;                   
wire            ex2_result_ready;                 
wire            ex2_result_ready_in_ex3;          
wire            ex2_stall;                        
wire            ex2_vfalu_inst_vld;               
wire            ex2_vfcvt_inst_vld;               
wire            ex2_vfspu_inst_vld;               
wire            ex2_vint_sync_stall;              
wire            ex3_ctrl_clk;                     
wire            ex3_ctrl_clk_en;                  
wire            ex3_dstv_vld;                     
wire    [63:0]  ex3_fpr_result_out;               
wire    [63:0]  ex3_gpr_result_out;               
wire            ex3_inst_clk;                     
wire            ex3_inst_clk_en;                  
wire            ex3_no_pipe_down;                 
wire            ex3_result_clk;                   
wire            ex3_result_clk_en;                
wire            ex3_result_ready_in_ex4;          
wire            ex3_sat_bit;                      
wire            ex3_stall;                        
wire            ex3_vint_sync_stall;              
wire            ex4_ctrl_clk;                     
wire            ex4_ctrl_clk_en;                  
wire            ex4_dstv_vld;                     
wire    [5 :0]  ex4_fflags;                       
wire            ex4_fp_reduct_to_be_fwd;          
wire            ex4_inst_clk;                     
wire            ex4_inst_clk_en;                  
wire            ex4_no_pipe_down;                 
wire            ex4_sel_vmul_result;              
wire            ex4_stall;                        
wire            ex4_vint_sync_stall;              
wire            ex5_ctrl_clk;                     
wire            ex5_ctrl_clk_en;                  
wire            ex5_dstf_vld;                     
wire            ex5_dstv_vld;                     
wire            ex5_inst_clk;                     
wire            ex5_inst_clk_en;                  
wire            ex5_stall;                        
wire            forever_cpuclk;                   
wire            handle_double_vpu;                
wire            handle_scalar_fpu;                
wire            ifu_vpu_warm_up;                  
wire            pad_yy_icg_scan_en;               
wire            rbus_viqx_ex3_fpr_wb_grnt;        
wire            rbus_viqx_ex3_gpr_wb_grnt;        
wire            rbus_viqx_ex3_vpr_wb_grnt;        
wire            rbus_viqx_ex4_fpr_wb_grnt;        
wire            rbus_viqx_ex4_vpr_wb_grnt;        
wire            rbus_viqx_ex5_fpr_wb_grnt;        
wire            rbus_viqx_ex5_vpr_wb_grnt;        
wire            rtu_yy_xx_async_flush;            
wire    [47:0]  srcv0_type;                       
wire    [47:0]  srcv1_type;                       
wire    [47:0]  srcv2_type;                       
wire            vdivu_vpu_busy;                   
wire            vfalu_vpu_ex1_denormal_stall;     
wire    [63:0]  vfalu_vpu_ex2_gpr_result;         
wire            vfalu_vpu_ex2_result_ready_in_ex3; 
wire    [4 :0]  vfalu_vpu_ex3_fflags;             
wire            vfalu_vpu_ex3_result_ready_in_ex4; 
wire    [4 :0]  vfalu_vpu_ex4_fflags;             
wire    [63:0]  vfalu_vpu_ex4_fpr_result;         
wire    [63:0]  vfcvt_vpu_ex2_gpr_result;         
wire    [4 :0]  vfcvt_vpu_ex3_fflags;             
wire            vfdsu_vpu_busy;                   
wire            vfdsu_vpu_ex1_denormal_stall;     
wire            vfdsu_vpu_state_idle;             
wire            vfmau_vpu_ex2_result_ready_in_ex3; 
wire    [4 :0]  vfmau_vpu_ex3_fflags;             
wire            vfmau_vpu_ex3_result_ready_in_ex4; 
wire    [4 :0]  vfmau_vpu_ex4_fflags;             
wire    [63:0]  vfmau_vpu_ex4_fpr_result;         
wire    [4 :0]  vfmau_vpu_ex5_fflags;             
wire    [63:0]  vfmau_vpu_ex5_fpr_result;         
wire    [63:0]  vfspu_vpu_ex2_result;             
wire            vid_f_dp_sel;                     
wire            vid_f_dste_vld;                   
wire            vid_f_dstf_vld;                   
wire            vid_f_dstg_vld;                   
wire    [9 :0]  vid_f_eu_sel;                     
wire    [4 :0]  vid_f_freg;                       
wire    [19:0]  vid_f_func;                       
wire    [3 :0]  vid_f_gp_sel;                     
wire    [5 :0]  vid_f_reg;                        
wire    [2 :0]  vid_f_rm;                         
wire            vid_f_sel;                        
wire            vid_f_sel_clk_en;                 
wire    [63:0]  vid_f_src1;                       
wire    [63:0]  vid_f_srcf0;                      
wire    [63:0]  vid_f_srcf1;                      
wire            vid_f_srcf1_scalar;               
wire    [63:0]  vid_f_srcf2;                      
wire            vid_f_srcf2_rdy;                  
wire            vid_f_srcf2_vld;                  
wire    [3 :0]  vid_v_gp_sel;                     
wire            vid_v_sel;                        
wire            vid_v_sel_clk_en;                 
wire            vidu_vpu_vid_fp_inst_dp_vld;      
wire    [5 :0]  vidu_vpu_vid_fp_inst_dst_reg;     
wire            vidu_vpu_vid_fp_inst_dst_vld;     
wire            vidu_vpu_vid_fp_inst_dste_vld;    
wire    [4 :0]  vidu_vpu_vid_fp_inst_dstf_reg;    
wire            vidu_vpu_vid_fp_inst_dstf_vld;    
wire    [9 :0]  vidu_vpu_vid_fp_inst_eu;          
wire    [19:0]  vidu_vpu_vid_fp_inst_func;        
wire            vidu_vpu_vid_fp_inst_gateclk_vld; 
wire    [63:0]  vidu_vpu_vid_fp_inst_src1_data;   
wire    [63:0]  vidu_vpu_vid_fp_inst_srcf0_data;  
wire    [63:0]  vidu_vpu_vid_fp_inst_srcf1_data;  
wire    [63:0]  vidu_vpu_vid_fp_inst_srcf2_data;  
wire            vidu_vpu_vid_fp_inst_srcf2_rdy;   
wire            vidu_vpu_vid_fp_inst_srcf2_vld;   
wire            vidu_vpu_vid_fp_inst_vld;         
wire            viqs_xx_ex1_vint_sel;             
wire            viqs_xx_ex2_vint_result_ready;    
wire            viqs_xx_ex2_vint_sel;             
wire            viqs_xx_ex3_vint_pipedown;        
wire            viqs_xx_ex5_stall;                
wire    [5 :0]  viqx_rbus_ex3_fflags;             
wire            viqx_rbus_ex3_fflags_vld;         
wire    [63:0]  viqx_rbus_ex3_fpr_wb_data;        
wire    [4 :0]  viqx_rbus_ex3_fpr_wb_index;       
wire            viqx_rbus_ex3_fpr_wb_req;         
wire    [2 :0]  viqx_rbus_ex3_fpu_wb_sel;         
wire    [63:0]  viqx_rbus_ex3_gpr_wb_data;        
wire    [5 :0]  viqx_rbus_ex3_gpr_wb_index;       
wire            viqx_rbus_ex3_gpr_wb_req;         
wire    [5 :0]  viqx_rbus_ex4_fflags;             
wire            viqx_rbus_ex4_fflags_vld;         
wire    [63:0]  viqx_rbus_ex4_fpr_wb_data;        
wire    [4 :0]  viqx_rbus_ex4_fpr_wb_index;       
wire            viqx_rbus_ex4_fpr_wb_req;         
wire    [5 :0]  viqx_rbus_ex5_fflags;             
wire            viqx_rbus_ex5_fflags_vld;         
wire    [63:0]  viqx_rbus_ex5_fpr_wb_data;        
wire    [4 :0]  viqx_rbus_ex5_fpr_wb_index;       
wire            viqx_rbus_ex5_fpr_wb_req;         
wire    [9 :0]  viqx_xx_ex1_eu_sel;               
wire    [19:0]  viqx_xx_ex1_func;                 
wire    [3 :0]  viqx_xx_ex1_gp_sel;               
wire    [1 :0]  viqx_xx_ex1_id_reg;               
wire            viqx_xx_ex1_lsu_inst_vld;         
wire    [2 :0]  viqx_xx_ex1_rm;                   
wire    [63:0]  viqx_xx_ex1_srcv0;                
wire    [47:0]  viqx_xx_ex1_srcv0_type;           
wire    [63:0]  viqx_xx_ex1_srcv1;                
wire    [47:0]  viqx_xx_ex1_srcv1_type;           
wire    [63:0]  viqx_xx_ex1_srcv2;                
wire            viqx_xx_ex1_srcv2_ready;          
wire    [47:0]  viqx_xx_ex1_srcv2_type;           
wire            viqx_xx_ex1_stall;                
wire    [6 :0]  viqx_xx_ex1_vreg;                 
wire    [9 :0]  viqx_xx_ex2_eu_sel;               
wire    [19:0]  viqx_xx_ex2_func;                 
wire    [3 :0]  viqx_xx_ex2_gp_sel;               
wire    [2 :0]  viqx_xx_ex2_rm;                   
wire            viqx_xx_ex2_stall;                
wire    [9 :0]  viqx_xx_ex3_eu_sel;               
wire    [19:0]  viqx_xx_ex3_func;                 
wire    [3 :0]  viqx_xx_ex3_gp_sel;               
wire    [2 :0]  viqx_xx_ex3_rm;                   
wire            viqx_xx_ex3_stall;                
wire    [9 :0]  viqx_xx_ex4_eu_sel;               
wire    [19:0]  viqx_xx_ex4_func;                 
wire    [3 :0]  viqx_xx_ex4_gp_sel;               
wire    [2 :0]  viqx_xx_ex4_rm;                   
wire            viqx_xx_ex4_stall;                
wire            viqx_xx_ex5_stall;                
wire            viqx_xx_ex5_vld;                  
wire            viqx_xx_no_op;                    
wire            vlsu_vex1_split_stall;            
wire            vmulu_vpu_ex4_sat;                


//=======================================================================
//                           VID_EU_SEL
//=======================================================================
parameter GP_BASE    = 8;
parameter GP_WIDTH   = 4;
parameter XLEN       = 64;
parameter FLEN       = 64;
parameter SILEN      = 32;
parameter VREG       = 7;

//==========================================================
//         VID VECTOR inst information
//==========================================================
// &Force("bus","vidu_vpu_vid_vecx_inst_dstv_bank",7,0); @42
// &Force("input","vidu_vpu_vid_inst_srcv0_bank2_data"); @156
// &Force("input","vidu_vpu_vid_inst_srcv0_bank3_data"); @157
// &Force("input","vidu_vpu_vid_inst_srcv0_bank4_data"); @158
// &Force("input","vidu_vpu_vid_inst_srcv0_bank5_data"); @159
// &Force("input","vidu_vpu_vid_inst_srcv0_bank6_data"); @160
// &Force("input","vidu_vpu_vid_inst_srcv0_bank7_data"); @161
// &Force("input","vidu_vpu_vid_inst_srcv1_bank2_data"); @162
// &Force("input","vidu_vpu_vid_inst_srcv1_bank3_data"); @163
// &Force("input","vidu_vpu_vid_inst_srcv1_bank4_data"); @164
// &Force("input","vidu_vpu_vid_inst_srcv1_bank5_data"); @165
// &Force("input","vidu_vpu_vid_inst_srcv1_bank6_data"); @166
// &Force("input","vidu_vpu_vid_inst_srcv1_bank7_data"); @167
// &Force("input","vidu_vpu_vid_inst_srcv2_bank2_data"); @168
// &Force("input","vidu_vpu_vid_inst_srcv2_bank3_data"); @169
// &Force("input","vidu_vpu_vid_inst_srcv2_bank4_data"); @170
// &Force("input","vidu_vpu_vid_inst_srcv2_bank5_data"); @171
// &Force("input","vidu_vpu_vid_inst_srcv2_bank6_data"); @172
// &Force("input","vidu_vpu_vid_inst_srcv2_bank7_data"); @173
// &Force("input","vidu_vpu_vid_inst_srcvm_bank2_data"); @174
// &Force("input","vidu_vpu_vid_inst_srcvm_bank3_data"); @175
// &Force("input","vidu_vpu_vid_inst_srcvm_bank4_data"); @176
// &Force("input","vidu_vpu_vid_inst_srcvm_bank5_data"); @177
// &Force("input","vidu_vpu_vid_inst_srcvm_bank6_data"); @178
// &Force("input","vidu_vpu_vid_inst_srcvm_bank7_data"); @179
// &Force("input","vidu_vpu_vid_inst_srcv0_bank2_data"); @180
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank2_data",`BANK_WIDTH-1,0); @181
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank3_data",`BANK_WIDTH-1,0); @182
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank4_data",`BANK_WIDTH-1,0); @183
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank5_data",`BANK_WIDTH-1,0); @184
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank6_data",`BANK_WIDTH-1,0); @185
// &Force("bus","vidu_vpu_vid_inst_srcv0_bank7_data",`BANK_WIDTH-1,0); @186
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank2_data",`BANK_WIDTH-1,0); @187
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank3_data",`BANK_WIDTH-1,0); @188
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank4_data",`BANK_WIDTH-1,0); @189
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank5_data",`BANK_WIDTH-1,0); @190
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank6_data",`BANK_WIDTH-1,0); @191
// &Force("bus","vidu_vpu_vid_inst_srcv1_bank7_data",`BANK_WIDTH-1,0); @192
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank2_data",`BANK_WIDTH-1,0); @193
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank3_data",`BANK_WIDTH-1,0); @194
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank4_data",`BANK_WIDTH-1,0); @195
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank5_data",`BANK_WIDTH-1,0); @196
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank6_data",`BANK_WIDTH-1,0); @197
// &Force("bus","vidu_vpu_vid_inst_srcv2_bank7_data",`BANK_WIDTH-1,0); @198
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank2_data",`BANK_WIDTH-1,0); @199
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank3_data",`BANK_WIDTH-1,0); @200
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank4_data",`BANK_WIDTH-1,0); @201
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank5_data",`BANK_WIDTH-1,0); @202
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank6_data",`BANK_WIDTH-1,0); @203
// &Force("bus","vidu_vpu_vid_inst_srcvm_bank7_data",`BANK_WIDTH-1,0); @204
// &Force("bus","vidu_vpu_vid_vecx_inst_srcv0_bank",7,0); @205
// &Force("bus","vidu_vpu_vid_vecx_inst_srcv1_bank",7,0); @206
// &Force("bus","vidu_vpu_vid_vecx_inst_srcv2_bank",7,0); @207
// &Force("bus","vidu_vpu_vid_vecx_inst_srcvm_bank",7,0); @208
// &CombBeg; @236
// &CombEnd; @242
// &CombBeg; @252
// &CombEnd; @260
// &CombBeg; @280
// &CombEnd; @287
// &CombBeg; @297
// &CombEnd; @306
// &CombBeg; @318
// &CombEnd; @331
// &CombBeg; @363
// &CombEnd; @373
assign vid_v_sel                  = 1'b0;
assign vid_v_sel_clk_en           = 1'b0;
assign vid_v_gp_sel[GP_WIDTH-1:0] = {GP_WIDTH{1'b0}};
assign vdivu_vpu_busy             = 1'b0;

//==========================================================
//         VID scalar FPU inst information
//==========================================================
assign vid_f_sel                  = vidu_vpu_vid_fp_inst_vld && handle_scalar_fpu;
assign vid_f_dp_sel               = vidu_vpu_vid_fp_inst_dp_vld && handle_scalar_fpu;
assign vid_f_sel_clk_en           = vidu_vpu_vid_fp_inst_gateclk_vld && handle_scalar_fpu;
assign vid_f_eu_sel[`EU_WIDTH-1:0]= vidu_vpu_vid_fp_inst_eu[`EU_WIDTH-1:0];

assign vid_f_gp_sel[0]            = vid_f_eu_sel[GP_BASE-1:GP_BASE-2]==2'b00;
assign vid_f_gp_sel[1]            = vid_f_eu_sel[GP_BASE-1:GP_BASE-2]==2'b01;
assign vid_f_gp_sel[2]            = vid_f_eu_sel[GP_BASE-1:GP_BASE-2]==2'b10;
assign vid_f_gp_sel[3]            = vid_f_eu_sel[GP_BASE-1:GP_BASE-2]==2'b11;

assign vid_f_func[`FUNC_WIDTH-1:0]= vidu_vpu_vid_fp_inst_func[`FUNC_WIDTH-1:0];
assign vid_f_rm[2:0]              = (vid_f_func[18:16]==3'b111) ? cp0_vpu_xx_rm[2:0]:vid_f_func[18:16];
assign vid_f_freg[4:0]            = vidu_vpu_vid_fp_inst_dstf_reg[4:0];
assign vid_f_reg[5:0]             = vidu_vpu_vid_fp_inst_dst_reg[5:0];
assign vid_f_dstf_vld             = vidu_vpu_vid_fp_inst_dstf_vld;
assign vid_f_dste_vld             = vidu_vpu_vid_fp_inst_dste_vld;
assign vid_f_dstg_vld             = vidu_vpu_vid_fp_inst_dst_vld;
assign vid_f_srcf0[FLEN-1:0]      = vidu_vpu_vid_fp_inst_srcf0_data[FLEN-1:0];
assign vid_f_srcf1[FLEN-1:0]      = vidu_vpu_vid_fp_inst_srcf1_data[FLEN-1:0];
assign vid_f_srcf2[FLEN-1:0]      = vidu_vpu_vid_fp_inst_srcf2_data[FLEN-1:0];
assign vid_f_srcf2_rdy            = vidu_vpu_vid_fp_inst_srcf2_rdy;
assign vid_f_srcf2_vld            = vidu_vpu_vid_fp_inst_srcf2_vld;
assign vid_f_src1[XLEN-1:0]       = vidu_vpu_vid_fp_inst_src1_data[XLEN-1:0];

assign vid_f_srcf1_scalar         = vid_f_gp_sel[2] && vid_f_eu_sel[1] && (vid_f_func[5] && vid_f_func[0])|| //fmv.f.x
                                    vid_f_gp_sel[2] && vid_f_eu_sel[0] && (!vid_f_func[3]); //fcnvt.f.x  
//==========================================================
//         VID pipe to VEX1
//==========================================================
assign ex1_ctrl_clk_en  =   vid_v_sel_clk_en || vid_f_sel_clk_en || ex1_inst_vld;

// &Instance("gated_clk_cell", "x_vpu_ex1_ctrl_gated_clk"); @436
gated_clk_cell  x_vpu_ex1_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_ctrl_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_ctrl_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @437
//          .external_en (1'b0), @438
//          .global_en   (cp0_yy_clk_en), @439
//          .module_en   (cp0_vpu_icg_en), @440
//          .local_en    (ex1_ctrl_clk_en), @441
//          .clk_out     (ex1_ctrl_clk)); @442

assign ex1_denorm_stall = ex1_fp_denormal_stall
                       || ex1_gp_sel[1] && ex1_eu_sel[0] && vfalu_vpu_ex1_denormal_stall
                       || ex1_gp_sel[3] && ex1_eu_sel[0] && vfdsu_vpu_ex1_denormal_stall;

assign ex1_div_stall = ex1_gp_sel[3] && |ex1_eu_sel[1:0] && (vdivu_vpu_busy || vfdsu_vpu_busy);

assign ex1_vlsu_stall = ex1_inst_lsu && vlsu_vex1_split_stall;
assign ex1_no_pipe_down  = 1'b0;

assign ex1_vint_sync_stall = 1'b0;
assign ex1_stall = ex1_inst_vld && (!ex1_gp_sel[3] && (ex2_stall || ex2_vint_sync_stall || ex1_no_pipe_down) 
                                  || ex1_denorm_stall || ex1_div_stall || ex1_vlsu_stall);

always @(posedge ex1_ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex1_inst_vld                 <= 1'b0;
    ex1_group_sel[GP_WIDTH-1:0]  <= {GP_WIDTH{1'b0}};
  end
  else if(rtu_yy_xx_async_flush) begin
    ex1_inst_vld                 <= 1'b0;
    ex1_group_sel[GP_WIDTH-1:0]  <= {GP_WIDTH{1'b0}};
  end
  else if(!ex1_stall) begin
    ex1_inst_vld                 <= (vid_v_sel || vid_f_sel) && !ex1_vint_sync_stall;
    ex1_group_sel[GP_WIDTH-1:0]  <= {GP_WIDTH{vid_v_sel && !ex1_vint_sync_stall}} & vid_v_gp_sel[GP_WIDTH-1:0] | {GP_WIDTH{vid_f_sel && !ex1_vint_sync_stall}} & vid_f_gp_sel[GP_WIDTH-1:0];
  end
end


assign ex1_inst_clk_en  =   vid_v_sel_clk_en || vid_f_sel_clk_en || ifu_vpu_warm_up ;

// &Instance("gated_clk_cell", "x_vpu_ex1_inst_gated_clk"); @485
gated_clk_cell  x_vpu_ex1_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_inst_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @486
//          .external_en (1'b0), @487
//          .global_en   (cp0_yy_clk_en), @488
//          .module_en   (cp0_vpu_icg_en), @489
//          .local_en    (ex1_inst_clk_en), @490
//          .clk_out     (ex1_inst_clk)); @491
// &Instance("gated_clk_cell", "x_vpu_ex1_srcv2_gated_clk"); @572
// &Connect(.clk_in      (forever_cpuclk), @573
//          .external_en (1'b0), @574
//          .global_en   (cp0_yy_clk_en), @575
//          .module_en   (cp0_vpu_icg_en), @576
//          .local_en    (ex1_srcv2_clk_en), @577
//          .clk_out     (ex1_srcv2_clk)); @578
// &Instance("gated_clk_cell", "x_vpu_ex1_srcvm_gated_clk"); @593
// &Connect(.clk_in      (forever_cpuclk), @594
//          .external_en (1'b0), @595
//          .global_en   (cp0_yy_clk_en), @596
//          .module_en   (cp0_vpu_icg_en), @597
//          .local_en    (ex1_srcvm_clk_en), @598
//          .clk_out     (ex1_srcvm_clk)); @599
always @(posedge ex1_inst_clk)
begin
  if(vid_f_dp_sel && !ex1_stall || ifu_vpu_warm_up) begin
    ex1_eu_sel[`EU_WIDTH-1:0] <= vid_f_eu_sel[`EU_WIDTH-1:0];
    ex1_gp_sel[GP_WIDTH-1:0]  <= vid_f_gp_sel[GP_WIDTH-1:0];
    ex1_func[`FUNC_WIDTH-1:0] <= vid_f_func[`FUNC_WIDTH-1:0] ;
    ex1_vreg[VREG-1:0]        <={vid_f_freg[4:0],2'b0};
    ex1_reg[5:0]              <= vid_f_reg[5:0];
    ex1_rm[2:0]               <= vid_f_rm[2:0];
    ex1_dstf_vld              <= vid_f_dstf_vld;
    ex1_dste_vld              <= vid_f_dste_vld;
    ex1_dstg_vld              <= vid_f_dstg_vld;
    ex1_srcv0[FLEN-1:0]       <= vid_f_srcf0[FLEN-1:0];
    ex1_srcv1[FLEN-1:0]       <= vid_f_srcf1_scalar ? vid_f_src1[FLEN-1:0] : vid_f_srcf1[FLEN-1:0];
    ex1_srcv2_ready           <= vid_f_srcf2_rdy;
    ex1_inst_lsu              <= vid_f_gp_sel[3] && vid_f_eu_sel[5];
  end
end

assign ex1_srcv2_clk_en  =   vid_f_sel_clk_en && vid_f_srcf2_vld || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_vpu_ex1_srcv2_gated_clk"); @638
gated_clk_cell  x_vpu_ex1_srcv2_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_srcv2_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_srcv2_clk_en  ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @639
//          .external_en (1'b0), @640
//          .global_en   (cp0_yy_clk_en), @641
//          .module_en   (cp0_vpu_icg_en), @642
//          .local_en    (ex1_srcv2_clk_en), @643
//          .clk_out     (ex1_srcv2_clk)); @644

always @(posedge ex1_srcv2_clk)
begin
  if(vid_f_dp_sel && vid_f_srcf2_vld && !ex1_stall) begin
    ex1_srcv2[FLEN-1:0]      <= vid_f_srcf2[FLEN-1:0];
  end
end
assign ex1_dstv_vld  = 1'b0;
assign ex1_opvf_h[47:0] = {48{1'b0}};

//==========================================================
//         EX1 pipe to EX2
//==========================================================
assign ex2_ctrl_clk_en  =   ex1_inst_vld && !ex1_gp_sel[3] || ex2_inst_vld;

// &Instance("gated_clk_cell", "x_vpu_ex2_ctrl_gated_clk"); @661
gated_clk_cell  x_vpu_ex2_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_ctrl_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_ctrl_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @662
//          .external_en (1'b0), @663
//          .global_en   (cp0_yy_clk_en), @664
//          .module_en   (cp0_vpu_icg_en), @665
//          .local_en    (ex2_ctrl_clk_en), @666
//          .clk_out     (ex2_ctrl_clk)); @667
assign ex2_no_pipe_down  = 1'b0;

assign ex2_vint_sync_stall = 1'b0;
assign ex2_stall = ex2_inst_vld && (ex3_stall || ex3_vint_sync_stall || ex2_no_pipe_down);

always @(posedge ex2_ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex2_inst_vld <= 1'b0;
  end
  else if(rtu_yy_xx_async_flush) begin
    ex2_inst_vld <= 1'b0;
  end
  else if(!ex2_stall) begin
    ex2_inst_vld <= ex1_inst_vld && !ex1_gp_sel[3] && !ex1_denorm_stall && !ex1_no_pipe_down && !ex2_vint_sync_stall;
  end
end

assign ex2_inst_clk_en  = ex1_inst_vld && !ex1_gp_sel[3] 
                       || viqs_xx_ex1_vint_sel
                       || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_vpu_ex2_inst_gated_clk"); @699
gated_clk_cell  x_vpu_ex2_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_inst_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @700
//          .external_en (1'b0), @701
//          .global_en   (cp0_yy_clk_en), @702
//          .module_en   (cp0_vpu_icg_en), @703
//          .local_en    (ex2_inst_clk_en), @704
//          .clk_out     (ex2_inst_clk)); @705


always @(posedge ex2_inst_clk)
begin
  if(ex1_inst_vld && !ex1_gp_sel[3] && !ex2_stall && !ex2_vint_sync_stall || ifu_vpu_warm_up) begin
    ex2_eu_sel[`EU_WIDTH-1:0]        <= ex1_eu_sel[`EU_WIDTH-1:0];
    ex2_gp_sel[GP_WIDTH-1:0]         <= ex1_gp_sel[GP_WIDTH-1:0];
    ex2_func[`FUNC_WIDTH-1:0]        <= ex1_func[`FUNC_WIDTH-1:0];
    ex2_vreg[VREG-1:0]               <= ex1_vreg[VREG-1:0];
    ex2_reg[5:0]                     <= ex1_reg[5:0];
    ex2_dstf_vld                     <= ex1_dstf_vld;
    ex2_dste_vld                     <= ex1_dste_vld && (ex1_dstf_vld || ex1_dstg_vld || ex1_dstv_vld);
    ex2_dstg_vld                     <= ex1_dstg_vld;
    ex2_rm[2:0]                      <= ex1_rm[2:0];
  end
end
 
// &Force("bus","viqs_xx_ex2_srcv2",`VEC_WIDTH-1,0); @754

//==========================================================
//         EX2 pipe to EX3
//==========================================================
assign ex3_ctrl_clk_en  =   ex2_inst_vld || ex3_inst_vld;

// &Instance("gated_clk_cell", "x_vpu_ex3_ctrl_gated_clk"); @768
gated_clk_cell  x_vpu_ex3_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_ctrl_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_ctrl_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @769
//          .external_en (1'b0), @770
//          .global_en   (cp0_yy_clk_en), @771
//          .module_en   (cp0_vpu_icg_en), @772
//          .local_en    (ex3_ctrl_clk_en), @773
//          .clk_out     (ex3_ctrl_clk)); @774
assign ex3_no_pipe_down          = 1'b0;
assign ex3_dstv_vld              = 1'b0;
assign rbus_viqx_ex3_vpr_wb_grnt = 1'b0;

assign ex3_vint_sync_stall  =  1'b0;
assign ex3_stall = ex3_inst_vld && ((ex3_result_ready && ex3_dstv_vld && !rbus_viqx_ex3_vpr_wb_grnt
                                || !ex3_result_ready)&& (ex4_stall || ex4_vint_sync_stall || ex3_no_pipe_down)
                                ||  ex3_result_ready && ex3_dstg_vld && !rbus_viqx_ex3_gpr_wb_grnt
                                ||  ex3_result_ready && ex3_dstf_vld && !rbus_viqx_ex3_fpr_wb_grnt);


always @(posedge ex3_ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex3_inst_vld   <= 1'b0;
    ex3_gpr_wb_vld <= 1'b0; 
  end
  else if(rtu_yy_xx_async_flush) begin
    ex3_inst_vld   <= 1'b0;
    ex3_gpr_wb_vld <= 1'b0; 
  end
  else if(!ex3_stall) begin
    ex3_inst_vld   <= ex2_inst_vld && !ex2_no_pipe_down && !ex3_vint_sync_stall;
    ex3_gpr_wb_vld <= ex2_inst_vld && ex2_dstg_vld && !ex2_no_pipe_down && !ex3_vint_sync_stall;
  end
end 

assign ex3_inst_clk_en  = ex2_inst_vld 
                       || viqs_xx_ex2_vint_sel
                       || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_vpu_ex3_inst_gated_clk"); @815
gated_clk_cell  x_vpu_ex3_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_inst_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @816
//          .external_en (1'b0), @817
//          .global_en   (cp0_yy_clk_en), @818
//          .module_en   (cp0_vpu_icg_en), @819
//          .local_en    (ex3_inst_clk_en), @820
//          .clk_out     (ex3_inst_clk)); @821

always @(posedge ex3_inst_clk)
begin 
  if(ex2_inst_vld && !ex3_stall && !ex3_vint_sync_stall || ifu_vpu_warm_up) begin
    ex3_eu_sel[`EU_WIDTH-1:0] <= ex2_eu_sel[`EU_WIDTH-1:0];
    ex3_gp_sel[GP_WIDTH-1:0]  <= ex2_gp_sel[GP_WIDTH-1:0];
    ex3_func[`FUNC_WIDTH-1:0] <= ex2_func[`FUNC_WIDTH-1:0] ;
    ex3_vreg[VREG-1:0]        <= ex2_vreg[VREG-1:0];
    ex3_reg[5:0]              <= ex2_reg[5:0];
    ex3_rm[2:0]               <= ex2_rm[2:0];
    ex3_dstf_vld              <= ex2_dstf_vld;
    ex3_dste_vld              <= ex2_dste_vld;
    ex3_dstg_vld              <= ex2_dstg_vld;
    ex3_fpu_wb_sel[2:0]       <= ex2_fpu_wb_sel[2:0];
    ex3_result_ready          <= ex2_result_ready_in_ex3;
  end
end

assign ex3_result_clk_en  = ex2_inst_vld && ex2_result_ready 
                       || viqs_xx_ex2_vint_result_ready
                       || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_vpu_ex3_result_gated_clk"); @844
gated_clk_cell  x_vpu_ex3_result_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_result_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_result_clk_en ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @845
//          .external_en (1'b0), @846
//          .global_en   (cp0_yy_clk_en), @847
//          .module_en   (cp0_vpu_icg_en), @848
//          .local_en    (ex3_result_clk_en), @849
//          .clk_out     (ex3_result_clk)); @850


always @(posedge ex3_result_clk)
begin
  if(ex2_inst_vld  && ex2_result_ready && !ex3_stall && !ex3_vint_sync_stall || ifu_vpu_warm_up) begin
    ex3_result[FLEN-1:0] <= ex2_result_new[FLEN-1:0];
  end
end



//==========================================================
//         EX3 pipe to EX4
//==========================================================
assign ex4_ctrl_clk_en  =   ex3_inst_vld && (!ex3_result_ready || ex3_dstv_vld) || ex4_inst_vld;

// &Instance("gated_clk_cell", "x_vpu_ex4_ctrl_gated_clk"); @924
gated_clk_cell  x_vpu_ex4_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex4_ctrl_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex4_ctrl_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @925
//          .external_en (1'b0), @926
//          .global_en   (cp0_yy_clk_en), @927
//          .module_en   (cp0_vpu_icg_en), @928
//          .local_en    (ex4_ctrl_clk_en), @929
//          .clk_out     (ex4_ctrl_clk)); @930
assign ex4_dstv_vld              = 1'b0;
assign rbus_viqx_ex4_vpr_wb_grnt = 1'b0;
assign ex4_fp_reduct_to_be_fwd   = 1'b0;
assign ex1_fp_reduct_fwd_ex4     = 1'b0;

assign ex4_no_pipe_down = viqs_xx_ex5_stall && ex4_gp_sel[0] && ex4_eu_sel[0]; 

assign ex4_vint_sync_stall = 1'b0;
assign ex4_stall = ex4_inst_vld && (ex4_result_ready && ex4_dstv_vld && !rbus_viqx_ex4_vpr_wb_grnt
                                ||  ex4_result_ready && ex4_dstf_vld && !rbus_viqx_ex4_fpr_wb_grnt
                                || !ex4_result_ready && (ex5_stall || ex4_no_pipe_down)
                                ||  ex4_fp_reduct_to_be_fwd && !ex1_fp_reduct_fwd_ex4);

always @(posedge ex4_ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex4_inst_vld <= 1'b0;
  end
  else if(rtu_yy_xx_async_flush) begin
    ex4_inst_vld <= 1'b0;
  end
  else if(!ex4_stall) begin
    ex4_inst_vld <= ex3_inst_vld && (!ex3_result_ready || ex3_dstv_vld && !rbus_viqx_ex3_vpr_wb_grnt) && !ex3_no_pipe_down && !ex4_vint_sync_stall;
  end
end


assign ex4_inst_clk_en  = ex3_inst_vld && (!ex3_result_ready || ex3_dstv_vld)
                       || viqs_xx_ex3_vint_pipedown 
                       || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_vpu_ex4_inst_gated_clk"); @971
gated_clk_cell  x_vpu_ex4_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex4_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex4_inst_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @972
//          .external_en (1'b0), @973
//          .global_en   (cp0_yy_clk_en), @974
//          .module_en   (cp0_vpu_icg_en), @975
//          .local_en    (ex4_inst_clk_en), @976
//          .clk_out     (ex4_inst_clk)); @977

always @(posedge ex4_inst_clk)
begin
  if(ex3_inst_vld && (!ex3_result_ready || ex3_dstv_vld && !rbus_viqx_ex3_vpr_wb_grnt) && !ex4_stall && !ex4_vint_sync_stall || ifu_vpu_warm_up) begin
    ex4_eu_sel[`EU_WIDTH-1:0] <= ex3_result_ready ? {`EU_WIDTH{1'b0}} : ex3_eu_sel[`EU_WIDTH-1:0];
    ex4_gp_sel[GP_WIDTH-1:0]  <= ex3_result_ready ? {GP_WIDTH{1'b0}} : ex3_gp_sel[GP_WIDTH-1:0];
    ex4_func[`FUNC_WIDTH-1:0] <= ex3_func[`FUNC_WIDTH-1:0] ;
    ex4_vreg[VREG-1:0]        <= ex3_vreg[VREG-1:0];
    ex4_rm[2:0]               <= ex3_rm[2:0];
    ex4_dstf_vld              <= ex3_dstf_vld;
    ex4_dste_vld              <= ex3_dste_vld;
    ex4_result_ready          <= ex3_result_ready_in_ex4 || ex3_result_ready;
  end
end

// &CombBeg; @1012
// &CombEnd; @1018
// &Force("bus","viqs_xx_ex4_srcv2",`VEC_WIDTH-1,0); @1038

//==========================================================
//         EX4 pipe to EX5
//==========================================================
assign ex5_ctrl_clk_en  =  (handle_scalar_fpu || handle_double_vpu) &&
                           (ex4_inst_vld && !ex4_result_ready || ex5_inst_vld);

// &Instance("gated_clk_cell", "x_vpu_ex5_ctrl_gated_clk"); @1053
gated_clk_cell  x_vpu_ex5_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex5_ctrl_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex5_ctrl_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1054
//          .external_en (1'b0), @1055
//          .global_en   (cp0_yy_clk_en), @1056
//          .module_en   (cp0_vpu_icg_en), @1057
//          .local_en    (ex5_ctrl_clk_en), @1058
//          .clk_out     (ex5_ctrl_clk)); @1059

assign ex5_stall = ex5_inst_vld && (ex5_dstf_vld && !rbus_viqx_ex5_fpr_wb_grnt
                                    || ex5_dstv_vld && !rbus_viqx_ex5_vpr_wb_grnt);

always @(posedge ex5_ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex5_inst_vld <= 1'b0;
  end
  else if(rtu_yy_xx_async_flush) begin
    ex5_inst_vld <= 1'b0;
  end
  else if(!ex5_stall) begin
    ex5_inst_vld <= ex4_inst_vld && (handle_scalar_fpu || handle_double_vpu) && !ex4_result_ready && !ex4_no_pipe_down;
  end
end

assign ex5_inst_clk_en  =  (handle_scalar_fpu || handle_double_vpu) &&
                           (ex4_inst_vld && !ex4_result_ready) || ifu_vpu_warm_up;
// &Instance("gated_clk_cell", "x_vpu_ex5_inst_gated_clk"); @1086
gated_clk_cell  x_vpu_ex5_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex5_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex5_inst_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1087
//          .external_en (1'b0), @1088
//          .global_en   (cp0_yy_clk_en), @1089
//          .module_en   (cp0_vpu_icg_en), @1090
//          .local_en    (ex5_inst_clk_en), @1091
//          .clk_out     (ex5_inst_clk)); @1092

always @(posedge ex5_inst_clk)
begin
  if(ex4_inst_vld && (handle_scalar_fpu || handle_double_vpu) && !ex4_result_ready && !ex5_stall || ifu_vpu_warm_up) begin
    ex5_vreg[VREG-1:0] <= ex4_vreg[VREG-1:0];
  end
end

assign rbus_viqx_ex5_vpr_wb_grnt = 1'b0;
assign ex5_dstv_vld              = 1'b0;
assign ex5_dstf_vld              = 1'b1;

//------------------------------------------------------------------------------
//		EX1: prepare srcvx src type judge
//------------------------------------------------------------------------------
assign ex1_srcv0_high[47:0] = ex1_opvf_h[47:0];
assign ex1_srcv0_vec        = !ex1_func[`FUNC_WIDTH-5];
assign ex1_srcv0_ori[63:0]  = ex1_srcv0[63:0];
// &Instance("aq_vpu_srcv_type","x_aq_vpu_srcv0_type"); @1137
aq_vpu_srcv_type  x_aq_vpu_srcv0_type (
  .cp0_vpu_xx_bf16     (cp0_vpu_xx_bf16    ),
  .ex1_srcvx           (ex1_srcv0_ori[63:0]),
  .ex1_srcvx_high      (ex1_srcv0_high     ),
  .ex1_srcvx_vec       (ex1_srcv0_vec      ),
  .inst_simd           (ex1_func[11]       ),
  .srcvx_type          (srcv0_type         )
);

// &Connect(.inst_simd        (ex1_func[11]       ), @1138
//          .ex1_srcvx_vec    (ex1_srcv0_vec      ), @1139
//          .ex1_srcvx        (ex1_srcv0_ori[63:0]), @1140
//          .ex1_srcvx_high   (ex1_srcv0_high     ), @1141
//          .srcvx_type       (srcv0_type         )); @1142


assign ex1_srcv1_high[47:0] = ex1_opvf_h[47:0];
assign ex1_srcv1_vec        = ex1_func[`FUNC_WIDTH-5];
assign ex1_srcv1_ori[63:0]  = ex1_srcv1[63:0];  
// &Instance("aq_vpu_srcv_type","x_aq_vpu_srcv1_type"); @1152
aq_vpu_srcv_type  x_aq_vpu_srcv1_type (
  .cp0_vpu_xx_bf16     (cp0_vpu_xx_bf16    ),
  .ex1_srcvx           (ex1_srcv1_ori[63:0]),
  .ex1_srcvx_high      (ex1_srcv1_high     ),
  .ex1_srcvx_vec       (ex1_srcv1_vec      ),
  .inst_simd           (ex1_func[11]       ),
  .srcvx_type          (srcv1_type         )
);

// &Connect(.inst_simd        (ex1_func[11]       ), @1153
//          .ex1_srcvx_vec    (ex1_srcv1_vec      ), @1154
//          .ex1_srcvx        (ex1_srcv1_ori[63:0]), @1155
//          .ex1_srcvx_high   (ex1_srcv1_high     ), @1156
//          .srcvx_type       (srcv1_type         )); @1157

assign ex1_srcv2_high[47:0] = 48'hffffffffffff;
assign ex1_srcv2_vec        = 1'b1;
// &Instance("aq_vpu_srcv_type","x_aq_vpu_srcv2_type"); @1161
aq_vpu_srcv_type  x_aq_vpu_srcv2_type (
  .cp0_vpu_xx_bf16 (cp0_vpu_xx_bf16),
  .ex1_srcvx       (ex1_srcv2[63:0]),
  .ex1_srcvx_high  (ex1_srcv2_high ),
  .ex1_srcvx_vec   (ex1_srcv2_vec  ),
  .inst_simd       (ex1_func[11]   ),
  .srcvx_type      (srcv2_type     )
);

// &Connect(.inst_simd        (ex1_func[11]   ), @1162
//          .ex1_srcvx_vec    (ex1_srcv2_vec  ), @1163
//          .ex1_srcvx        (ex1_srcv2[63:0]), @1164
//          .ex1_srcvx_high   (ex1_srcv2_high ), @1165
//          .srcvx_type       (srcv2_type     )); @1166


//------------------------------------------------------------------------------
//		EX1: float point denormal stall
//------------------------------------------------------------------------------
// &Instance("gated_clk_cell", "x_ex1_denormal_clk"); @1208
// &Connect(.clk_in      (forever_cpuclk      ), @1209
//          .external_en (1'b0                ), @1210
//          .global_en   (cp0_yy_clk_en       ), @1211
//          .module_en   (cp0_vpu_icg_en      ), @1212
//          .local_en    (ex1_denormal_clk_en ), @1213
//          .clk_out     (ex1_denormal_clk    ));     @1214
assign ex1_vfmau_sel = ex1_inst_vld  && ex1_gp_sel[0] && ex1_eu_sel[0];
assign ex1_vfdsu_sel = ex1_inst_vld  && ex1_gp_sel[3] && ex1_eu_sel[0] && vfdsu_vpu_state_idle;
assign ex1_inst_sqrt = ex1_vfdsu_sel && ex1_func[1];

assign ex1_denormal_double = ex1_vfmau_sel &&  ex1_func[6]
                          || ex1_vfdsu_sel && (ex1_func[13:12] == 2'b11);
assign ex1_denormal_single = ex1_vfmau_sel &&  ex1_func[5]
                          || ex1_vfdsu_sel && (ex1_func[13:12] == 2'b10);
assign ex1_denormal_half   = ex1_vfmau_sel &&  ex1_func[4]
                          || ex1_vfdsu_sel && (ex1_func[13:12] == 2'b01);
assign ex1_double_id[1:0]  = {srcv1_type[43] && !ex1_inst_sqrt,srcv0_type[43]};
assign ex1_single0_id[1:0] = {srcv1_type[36] && !ex1_inst_sqrt,srcv0_type[36]};
assign ex1_half0_id[1:0]   = {srcv1_type[22] && !ex1_inst_sqrt,srcv0_type[22]};

assign ex1_fp_denormal_stall = (|ex1_double_id[1:0] ) && (ex1_id_reg[1:0] == 2'b00) && ex1_denormal_double
                            || (|ex1_single0_id[1:0]) && (ex1_id_reg[1:0] == 2'b00) && ex1_denormal_single
                            || (|ex1_half0_id[1:0]  ) && (ex1_id_reg[1:0] == 2'b00) && ex1_denormal_half;

assign ex1_id_reg_updt[1:0] = {2{ex1_denormal_double}} & ex1_double_id[1:0]
                            | {2{ex1_denormal_single}} & ex1_single0_id[1:0]
                            | {2{ex1_denormal_half}}   & ex1_half0_id[1:0];

// &Instance("gated_clk_cell", "x_ex1_denormal_clk"); @1253
gated_clk_cell  x_ex1_denormal_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_denormal_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_denormal_clk_en),
  .module_en           (cp0_vpu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk      ), @1254
//          .external_en (1'b0                ), @1255
//          .global_en   (cp0_yy_clk_en       ), @1256
//          .module_en   (cp0_vpu_icg_en      ), @1257
//          .local_en    (ex1_denormal_clk_en ), @1258
//          .clk_out     (ex1_denormal_clk    ));     @1259

assign ex1_denormal_clk_en = ex1_fp_denormal_stall  || (|ex1_id_reg[1:0]);

always@(posedge ex1_denormal_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ex1_id_reg[1:0] <= {2{1'b0}};
  else if (rtu_yy_xx_async_flush)
    ex1_id_reg[1:0] <= {2{1'b0}};
  else if(ex1_fp_denormal_stall)
    ex1_id_reg[1:0] <= ex1_id_reg_updt[1:0];
  else
    ex1_id_reg[1:0] <= {2{1'b0}};
end


// &Instance("aq_vpu_vm_mask_extract", "x_aq_vpu_vm_mask_extract"); @1281
// &Instance("aq_vpu_vl_mask_extract", "x_aq_vpu_vl_mask_extract"); @1283
// &CombBeg; @1330
// &CombEnd; @1337
// &Force("bus","ex1_vm_bit_mask_neg",`VEC_WIDTH-1,0); @1342
// &CombBeg; @1344
// &CombEnd; @1349
// &Force("bus","ex3_vl_byte_mask_double",`BYTE_NUM*2-1,0); @1431
// &Force("bus","ex3_vm_byte_mask_double",`BYTE_NUM*2-1,0); @1432
// &CombBeg; @1435
// &CombEnd; @1441
// &CombBeg; @1443
// &CombEnd; @1449
// &CombBeg; @1451
// &CombEnd; @1457
// &Force("bus","ex3_vl_mask_normal",`VEC_WIDTH-1,0); @1459
// &Force("bus","ex3_vm_mask_normal",`VEC_WIDTH-1,0); @1460
// &CombBeg; @1462
// &CombEnd; @1468
// &CombBeg; @1480
// &CombEnd; @1488
// &CombBeg; @1496
// &CombEnd; @1503
// &CombBeg; @1505
// &CombEnd; @1512

assign ex2_result_ready     = ex2_vfspu_inst_vld || ex2_dstg_vld;

assign ex2_vfalu_inst_vld   = ex2_gp_sel[1] && ex2_eu_sel[0];
assign ex2_vfcvt_inst_vld   = ex2_gp_sel[2] && ex2_eu_sel[0];
assign ex2_vfspu_inst_vld   = ex2_gp_sel[2] && ex2_eu_sel[1];

assign ex2_result_new[FLEN-1:0] = {FLEN{ex2_vfspu_inst_vld  }} &  vfspu_vpu_ex2_result[FLEN-1:0]
                                 |{FLEN{ex2_vfalu_inst_vld  }} &  vfalu_vpu_ex2_gpr_result[FLEN-1:0]
                                 |{FLEN{ex2_vfcvt_inst_vld  }} &  vfcvt_vpu_ex2_gpr_result[FLEN-1:0];

assign ex2_result_ready_in_ex3 =  ex2_gp_sel[1] && ex2_eu_sel[0] && vfalu_vpu_ex2_result_ready_in_ex3|| // vfalu
                                  ex2_gp_sel[2] && ex2_eu_sel[0] || // vfcvt
                                  ex2_gp_sel[2] && ex2_eu_sel[1] || // vfspu
                                  ex2_gp_sel[0] && ex2_eu_sel[0] && vfmau_vpu_ex2_result_ready_in_ex3; //vfmau

assign ex3_sat_bit          = 1'b0;

assign ex2_fpu_wb_sel[2] = ex2_eu_sel[9:0]== 10'b0110_000001;//fcvt
assign ex2_fpu_wb_sel[1] = ex2_eu_sel[9:0]== 10'b0101_000001;//falu
assign ex2_fpu_wb_sel[0] = ex2_eu_sel[9:0]== 10'b0100_000001;//fmau

assign viqx_rbus_ex3_fpu_wb_sel[2:0] = ex3_fpu_wb_sel[2:0];
//===========================================================
//               GPR WRITE BACK
//===========================================================

assign ex3_gpr_result_out[XLEN-1:0] =  ex3_result[XLEN-1:0];

assign viqx_rbus_ex3_gpr_wb_req            = ex3_gpr_wb_vld;
assign viqx_rbus_ex3_gpr_wb_data[XLEN-1:0] = ex3_gpr_result_out[XLEN-1:0];
assign viqx_rbus_ex3_gpr_wb_index[5:0]     = ex3_reg[5:0];

//===========================================================
//               FFLAG WRITE BACK
//===========================================================
// &CombBeg; @1562
always @( vfcvt_vpu_ex3_fflags[4:0]
       or vfalu_vpu_ex3_fflags[4:0]
       or vfmau_vpu_ex3_fflags[4:0]
       or ex3_eu_sel[7:0])
begin
case(ex3_eu_sel[7:0])
   8'b00_000001:ex3_fflags_out[4:0] =  vfmau_vpu_ex3_fflags[4:0]; 
   8'b01_000001:ex3_fflags_out[4:0] =  vfalu_vpu_ex3_fflags[4:0]; 
   8'b10_000001:ex3_fflags_out[4:0] =  vfcvt_vpu_ex3_fflags[4:0]; 
        default:ex3_fflags_out[4:0] =  {5{1'b0}};
endcase
// &CombEnd; @1569
end

assign viqx_rbus_ex3_fflags_vld = ex3_inst_vld && ex3_dste_vld && ex3_result_ready;
assign viqx_rbus_ex3_fflags[5:0]= {ex3_sat_bit, ex3_fflags_out[4:0]};

//===========================================================
//               FPR WRITE BACK
//===========================================================
assign ex3_fpr_result_out[FLEN-1:0] =  ex3_result[FLEN-1:0];

assign viqx_rbus_ex3_fpr_wb_req            = ex3_inst_vld && ex3_dstf_vld && ex3_result_ready;
assign viqx_rbus_ex3_fpr_wb_data[FLEN-1:0] = ex3_fpr_result_out[FLEN-1:0];
assign viqx_rbus_ex3_fpr_wb_index[4:0]     = ex3_vreg[6:2];
//===========================================================
//               RESULT THAT WILL WRITE BACK IN EX4
//===========================================================
assign ex3_result_ready_in_ex4 = ex3_gp_sel[0] && ex3_eu_sel[0] && vfmau_vpu_ex3_result_ready_in_ex4
                              || ex3_gp_sel[1] && ex3_eu_sel[0] && vfalu_vpu_ex3_result_ready_in_ex4;
//==========================================================
//                 EX4 result package
//==========================================================
// &CombBeg; @1607
// &CombEnd; @1613
// &CombBeg; @1615
// &CombEnd; @1621
//===========================================================
//               FPR EX4 WRITE BACK
//===========================================================
assign ex4_fflags[5:0] = {6{1'b0}};
assign ex4_sel_vmul_result =  1'b0;
assign vmulu_vpu_ex4_sat   =  1'b0;

// &CombBeg; @1639
always @( ex4_eu_sel[9:0]
       or vfalu_vpu_ex4_fpr_result[63:0]
       or vfmau_vpu_ex4_fpr_result[63:0])
begin
case(ex4_eu_sel[9:0])
   10'b0100_000001:ex4_fpr_result_out[FLEN-1:0] =  vfmau_vpu_ex4_fpr_result[FLEN-1:0]; 
   10'b0101_000001:ex4_fpr_result_out[FLEN-1:0] =  vfalu_vpu_ex4_fpr_result[FLEN-1:0]; 
           default:ex4_fpr_result_out[FLEN-1:0] =  {FLEN{1'bx}};
endcase
// &CombEnd; @1645
end

// &CombBeg; @1647
always @( ex4_fflags[5:0]
       or vfalu_vpu_ex4_fflags[4:0]
       or vfmau_vpu_ex4_fflags[4:0]
       or ex4_sel_vmul_result
       or ex4_eu_sel[7:0]
       or vmulu_vpu_ex4_sat)
begin
case(ex4_eu_sel[7:0])
   8'b00_000001:ex4_fflags_out[5:0] =  {1'b0,vfmau_vpu_ex4_fflags[4:0]}; 
   8'b01_000001:ex4_fflags_out[5:0] =  {1'b0,vfalu_vpu_ex4_fflags[4:0]}; 
        default:ex4_fflags_out[5:0] =  ex4_sel_vmul_result ? {vmulu_vpu_ex4_sat, 5'b00000}: ex4_fflags[5:0];
endcase
// &CombEnd; @1653
end

assign viqx_rbus_ex4_fflags_vld  = ex4_inst_vld && ex4_dste_vld && ex4_result_ready;
assign viqx_rbus_ex4_fflags[5:0] = {ex4_fflags_out[5:0]};

assign viqx_rbus_ex4_fpr_wb_req = ex4_inst_vld && ex4_dstf_vld && ex4_result_ready;
assign viqx_rbus_ex4_fpr_wb_data[FLEN-1:0] = ex4_fpr_result_out[FLEN-1:0];
assign viqx_rbus_ex4_fpr_wb_index[4:0] = ex4_vreg[6:2];

//===========================================================
//               FPR EX5 WRITE BACK
//===========================================================
assign viqx_rbus_ex5_fflags_vld  = ex5_inst_vld;
assign viqx_rbus_ex5_fflags[5:0] = {1'b0,vfmau_vpu_ex5_fflags[4:0]};


assign viqx_rbus_ex5_fpr_wb_req = ex5_inst_vld && ex5_dstf_vld;
assign viqx_rbus_ex5_fpr_wb_data[FLEN-1:0] = vfmau_vpu_ex5_fpr_result[FLEN-1:0];
assign viqx_rbus_ex5_fpr_wb_index[4:0] = ex5_vreg[6:2];


//==========================================================
//                 EX1 information broadcast
//==========================================================
assign viqx_xx_ex1_gp_sel[GP_WIDTH-1:0]        = ex1_group_sel[GP_WIDTH-1:0];
assign viqx_xx_ex1_eu_sel[`EU_WIDTH-1:0]       = ex1_eu_sel[`EU_WIDTH-1:0];
assign viqx_xx_ex1_func[`FUNC_WIDTH-1:0]       = ex1_func[`FUNC_WIDTH-1:0];
assign viqx_xx_ex1_rm[2:0]                     = ex1_rm[2:0];
assign viqx_xx_ex1_srcv0[FLEN-1:0]             = ex1_srcv0[FLEN-1:0];
assign viqx_xx_ex1_srcv1[FLEN-1:0]             = ex1_srcv1[FLEN-1:0];
assign viqx_xx_ex1_srcv2[FLEN-1:0]             = ex1_srcv2[FLEN-1:0];
assign viqx_xx_ex1_srcv2_ready                 = ex1_srcv2_ready;
assign viqx_xx_ex1_vreg[VREG-1:0]              = ex1_vreg[VREG-1:0];

assign viqx_xx_ex1_srcv0_type[47:0]            = srcv0_type[47:0];
assign viqx_xx_ex1_srcv1_type[47:0]            = srcv1_type[47:0];
assign viqx_xx_ex1_srcv2_type[47:0]            = srcv2_type[47:0];

assign viqx_xx_ex1_lsu_inst_vld                = ex1_inst_vld && ex1_inst_lsu;

assign viqx_xx_ex1_id_reg[1:0]                 = ex1_id_reg[1:0];
assign viqx_xx_ex1_stall                       = ex1_stall;


//==========================================================
//                 EX2 information broadcast
//==========================================================
assign viqx_xx_ex2_gp_sel[GP_WIDTH-1:0]        = {GP_WIDTH{ex2_inst_vld}} & ex2_gp_sel[GP_WIDTH-1:0];
assign viqx_xx_ex2_eu_sel[`EU_WIDTH-1:0]       = ex2_eu_sel[`EU_WIDTH-1:0];
assign viqx_xx_ex2_func[`FUNC_WIDTH-1:0]       = ex2_func[`FUNC_WIDTH-1:0];
assign viqx_xx_ex2_rm[2:0]                     = ex2_rm[2:0];
assign viqx_xx_ex2_stall                       = ex2_stall;


//==========================================================
//                 EX3 information broadcast
//==========================================================
assign viqx_xx_ex3_gp_sel[GP_WIDTH-1:0]        = {GP_WIDTH{ex3_inst_vld}} & ex3_gp_sel[GP_WIDTH-1:0];
assign viqx_xx_ex3_eu_sel[`EU_WIDTH-1:0]       = ex3_eu_sel[`EU_WIDTH-1:0];
assign viqx_xx_ex3_func[`FUNC_WIDTH-1:0]       = ex3_func[`FUNC_WIDTH-1:0];
assign viqx_xx_ex3_rm[2:0]                     = ex3_rm[2:0];
assign viqx_xx_ex3_stall                       = ex3_stall;


//==========================================================
//                 EX4 information broadcast
//==========================================================
assign viqx_xx_ex4_gp_sel[GP_WIDTH-1:0]        = {GP_WIDTH{ex4_inst_vld}} & ex4_gp_sel[GP_WIDTH-1:0];
assign viqx_xx_ex4_eu_sel[`EU_WIDTH-1:0]       = ex4_eu_sel[`EU_WIDTH-1:0];
assign viqx_xx_ex4_func[`FUNC_WIDTH-1:0]       = ex4_func[`FUNC_WIDTH-1:0];
assign viqx_xx_ex4_rm[2:0]                     = ex4_rm[2:0];
assign viqx_xx_ex4_stall                       = ex4_stall;


assign viqx_xx_ex5_vld                         = ex5_inst_vld;
assign viqx_xx_ex5_stall                       = ex5_stall;

assign viqx_xx_no_op                           = !ex1_inst_vld && !ex2_inst_vld && !ex3_inst_vld 
                                              && !ex4_inst_vld && !ex5_inst_vld;

                                              
// &Force("input","forever_cpuclk"); @1866
// &Force("input","forever_cpuclk"); @1876
// &Force("input","rtu_yy_xx_async_flush"); @1877
// &Force("input","vidu_vpu_vid_vec0_inst_vld"); @1878
// &Force("input","vidu_vpu_vid_vec0_inst_vlmul"); @1879
// &Force("input","vidu_vpu_vid_vec0_inst_vsew"); @1880
// &Force("input","vidu_vpu_vid_vec0_inst_dp_vld"); @1881
// &Force("input","vidu_vpu_vid_vec0_inst_vl"); @1882
// &Force("input","vidu_vpu_vid_vec0_inst_func"); @1883
// &Force("input","vidu_vpu_vid_vec0_inst_eu"); @1884
// &Force("input","vidu_vpu_vid_vec1_inst_vld"); @1885
// &Force("input","vidu_vpu_vid_vec1_inst_vlmul"); @1886
// &Force("input","vidu_vpu_vid_vec1_inst_vsew"); @1887
// &Force("input","vidu_vpu_vid_vec1_inst_dp_vld"); @1888
// &Force("input","vidu_vpu_vid_vec1_inst_vl"); @1892
// &Force("input","vidu_vpu_vid_vec1_inst_func"); @1894
// &Force("input","vidu_vpu_vid_vec1_inst_eu"); @1896
// &Force("input","vidu_vpu_vid_fp_inst_vld"); @1897
// &Force("input","vidu_vpu_vid_fp_inst_dp_vld"); @1898
// &Force("output","viqx_rbus_ex3_fflags_vld"); @1919
// &Force("output","viqx_rbus_ex3_fflags"); @1920
// &Force("output","viqx_rbus_ex4_fflags_vld"); @1921
// &Force("output","viqx_rbus_ex4_fflags"); @1922
// &Force("output","viqx_rbus_ex5_fflags_vld"); @1923
// &Force("output","viqx_rbus_ex5_fflags"); @1924
// &Force("nonport","viqx_rbus_ex3_fflags_vld_reg"); @1925
// &Force("nonport","viqx_rbus_ex3_fflags_reg"); @1926
// &Force("nonport","viqx_rbus_ex4_fflags_vld_reg"); @1927
// &Force("nonport","viqx_rbus_ex4_fflags_reg"); @1928
// &Force("nonport","viqx_rbus_ex5_fflags_vld_reg"); @1929
// &Force("nonport","viqx_rbus_ex5_fflags_reg"); @1930
// &CombBeg; @2088
// &CombEnd; @2108
// &Force("nonport","vec0_vlmax"); @2109
// &CombBeg; @2127
// &CombEnd; @2147
// &Force("nonport","vec1_vlmax"); @2148
// &Force("nonport","ex5_eu_sel"); @2230
// &Force("nonport","ex5_vint_inst"); @2231
// &ModuleEnd; @2243
endmodule




