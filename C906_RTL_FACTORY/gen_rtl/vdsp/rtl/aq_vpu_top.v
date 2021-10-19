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
module aq_vpu_top(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_vpu_xx_rm,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ifu_vpu_warm_up,
  lsu_vlsu_bytes_vld,
  lsu_vlsu_data,
  lsu_vlsu_data_grant,
  lsu_vlsu_data_vld,
  lsu_vlsu_dc_create_vld,
  lsu_vlsu_dc_fld_req,
  lsu_vlsu_dc_fof,
  lsu_vlsu_dc_nf,
  lsu_vlsu_dc_sew,
  lsu_vlsu_dc_split_cnt,
  lsu_vlsu_dc_sseg_first,
  lsu_vlsu_dc_stall,
  lsu_vlsu_dest_reg,
  lsu_vlsu_expt_vld,
  lsu_vlsu_func,
  lsu_vlsu_sew,
  lsu_vlsu_split_last,
  lsu_vlsu_st_expt,
  lsu_vlsu_st_offset,
  lsu_vlsu_st_sew,
  lsu_vlsu_st_size,
  lsu_vlsu_vl_update,
  lsu_vlsu_vl_upval,
  pad_yy_icg_scan_en,
  rtu_vpu_gpr_wb_grnt,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_flush,
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
  vlsu_buf_stall,
  vlsu_dtu_data,
  vlsu_dtu_data_vld,
  vlsu_dtu_data_vld_gate,
  vlsu_lsu_data_shift,
  vlsu_lsu_data_vld,
  vlsu_lsu_fwd_data,
  vlsu_lsu_fwd_dest_reg,
  vlsu_lsu_fwd_vld,
  vlsu_lsu_src2_depd,
  vlsu_lsu_src2_reg,
  vlsu_lsu_wdata,
  vlsu_rtu_vl_updt_data,
  vlsu_rtu_vl_updt_vld,
  vlsu_xx_no_op,
  vpu_dtu_dbg_info,
  vpu_rtu_fflag,
  vpu_rtu_fflag_vld,
  vpu_rtu_gpr_wb_data,
  vpu_rtu_gpr_wb_index,
  vpu_rtu_gpr_wb_req,
  vpu_rtu_no_op,
  vpu_vidu_fp_fwd_data,
  vpu_vidu_fp_fwd_reg,
  vpu_vidu_fp_fwd_vld,
  vpu_vidu_fp_wb_data,
  vpu_vidu_fp_wb_reg,
  vpu_vidu_fp_wb_vld,
  vpu_vidu_vex1_fp_stall,
  vpu_vidu_wbt_fp_wb0_reg,
  vpu_vidu_wbt_fp_wb0_vld,
  vpu_vidu_wbt_fp_wb1_reg,
  vpu_vidu_wbt_fp_wb1_vld
);

// &Ports; @25
input           cp0_vpu_icg_en;                   
input           cp0_vpu_xx_bf16;                  
input           cp0_vpu_xx_dqnan;                 
input   [2 :0]  cp0_vpu_xx_rm;                    
input           cp0_yy_clk_en;                    
input           cpurst_b;                         
input           forever_cpuclk;                   
input           ifu_vpu_warm_up;                  
input   [7 :0]  lsu_vlsu_bytes_vld;               
input   [63:0]  lsu_vlsu_data;                    
input           lsu_vlsu_data_grant;              
input           lsu_vlsu_data_vld;                
input           lsu_vlsu_dc_create_vld;           
input           lsu_vlsu_dc_fld_req;              
input           lsu_vlsu_dc_fof;                  
input   [2 :0]  lsu_vlsu_dc_nf;                   
input   [1 :0]  lsu_vlsu_dc_sew;                  
input   [9 :0]  lsu_vlsu_dc_split_cnt;            
input           lsu_vlsu_dc_sseg_first;           
input           lsu_vlsu_dc_stall;                
input   [4 :0]  lsu_vlsu_dest_reg;                
input           lsu_vlsu_expt_vld;                
input   [19:0]  lsu_vlsu_func;                    
input   [1 :0]  lsu_vlsu_sew;                     
input           lsu_vlsu_split_last;              
input           lsu_vlsu_st_expt;                 
input   [3 :0]  lsu_vlsu_st_offset;               
input   [1 :0]  lsu_vlsu_st_sew;                  
input   [1 :0]  lsu_vlsu_st_size;                 
input           lsu_vlsu_vl_update;               
input   [6 :0]  lsu_vlsu_vl_upval;                
input           pad_yy_icg_scan_en;               
input           rtu_vpu_gpr_wb_grnt;              
input           rtu_yy_xx_async_flush;            
input           rtu_yy_xx_flush;                  
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
output          vlsu_buf_stall;                   
output  [63:0]  vlsu_dtu_data;                    
output          vlsu_dtu_data_vld;                
output          vlsu_dtu_data_vld_gate;           
output  [3 :0]  vlsu_lsu_data_shift;              
output          vlsu_lsu_data_vld;                
output  [63:0]  vlsu_lsu_fwd_data;                
output  [4 :0]  vlsu_lsu_fwd_dest_reg;            
output          vlsu_lsu_fwd_vld;                 
output          vlsu_lsu_src2_depd;               
output  [4 :0]  vlsu_lsu_src2_reg;                
output  [63:0]  vlsu_lsu_wdata;                   
output  [7 :0]  vlsu_rtu_vl_updt_data;            
output          vlsu_rtu_vl_updt_vld;             
output          vlsu_xx_no_op;                    
output  [28:0]  vpu_dtu_dbg_info;                 
output  [5 :0]  vpu_rtu_fflag;                    
output          vpu_rtu_fflag_vld;                
output  [63:0]  vpu_rtu_gpr_wb_data;              
output  [5 :0]  vpu_rtu_gpr_wb_index;             
output          vpu_rtu_gpr_wb_req;               
output          vpu_rtu_no_op;                    
output  [63:0]  vpu_vidu_fp_fwd_data;             
output  [4 :0]  vpu_vidu_fp_fwd_reg;              
output          vpu_vidu_fp_fwd_vld;              
output  [63:0]  vpu_vidu_fp_wb_data;              
output  [4 :0]  vpu_vidu_fp_wb_reg;               
output          vpu_vidu_fp_wb_vld;               
output          vpu_vidu_vex1_fp_stall;           
output  [4 :0]  vpu_vidu_wbt_fp_wb0_reg;          
output          vpu_vidu_wbt_fp_wb0_vld;          
output  [4 :0]  vpu_vidu_wbt_fp_wb1_reg;          
output          vpu_vidu_wbt_fp_wb1_vld;          

// &Regs; @26

// &Wires; @27
wire            cp0_vpu_icg_en;                   
wire            cp0_vpu_xx_bf16;                  
wire            cp0_vpu_xx_dqnan;                 
wire    [2 :0]  cp0_vpu_xx_rm;                    
wire            cp0_yy_clk_en;                    
wire            cpurst_b;                         
wire            forever_cpuclk;                   
wire            ifu_vpu_warm_up;                  
wire    [7 :0]  lsu_vlsu_bytes_vld;               
wire    [63:0]  lsu_vlsu_data;                    
wire            lsu_vlsu_data_grant;              
wire            lsu_vlsu_data_vld;                
wire            lsu_vlsu_dc_create_vld;           
wire            lsu_vlsu_dc_fld_req;              
wire            lsu_vlsu_dc_fof;                  
wire    [2 :0]  lsu_vlsu_dc_nf;                   
wire    [1 :0]  lsu_vlsu_dc_sew;                  
wire    [9 :0]  lsu_vlsu_dc_split_cnt;            
wire            lsu_vlsu_dc_sseg_first;           
wire            lsu_vlsu_dc_stall;                
wire    [4 :0]  lsu_vlsu_dest_reg;                
wire            lsu_vlsu_expt_vld;                
wire    [19:0]  lsu_vlsu_func;                    
wire    [1 :0]  lsu_vlsu_sew;                     
wire            lsu_vlsu_split_last;              
wire            lsu_vlsu_st_expt;                 
wire    [3 :0]  lsu_vlsu_st_offset;               
wire    [1 :0]  lsu_vlsu_st_sew;                  
wire    [1 :0]  lsu_vlsu_st_size;                 
wire            lsu_vlsu_vl_update;               
wire    [6 :0]  lsu_vlsu_vl_upval;                
wire            pad_yy_icg_scan_en;               
wire            rbus_vfdsu_fpr_wb_grnt;           
wire            rbus_viq0_ex3_fpr_wb_grnt;        
wire            rbus_viq0_ex3_gpr_wb_grnt;        
wire            rbus_viq0_ex4_fpr_wb_grnt;        
wire            rbus_viq0_ex5_fpr_wb_grnt;        
wire            rtu_vpu_gpr_wb_grnt;              
wire            rtu_yy_xx_async_flush;            
wire            rtu_yy_xx_flush;                  
wire            vfalu_vpu_ex1_denormal_stall;     
wire    [63:0]  vfalu_vpu_ex2_gpr_result;         
wire            vfalu_vpu_ex2_result_ready_in_ex3; 
wire    [4 :0]  vfalu_vpu_ex3_fflags;             
wire    [63:0]  vfalu_vpu_ex3_fpr_result;         
wire            vfalu_vpu_ex3_result_ready_in_ex4; 
wire    [4 :0]  vfalu_vpu_ex4_fflags;             
wire    [63:0]  vfalu_vpu_ex4_fpr_result;         
wire    [63:0]  vfcvt_vpu_ex2_gpr_result;         
wire    [4 :0]  vfcvt_vpu_ex3_fflags;             
wire    [63:0]  vfcvt_vpu_ex3_fpr_result;         
wire    [4 :0]  vfdsu_rbus_fflags;                
wire            vfdsu_rbus_fflags_vld;            
wire    [63:0]  vfdsu_rbus_fpr_wb_data;           
wire    [4 :0]  vfdsu_rbus_fpr_wb_index;          
wire            vfdsu_rbus_fpr_wb_req;            
wire            vfdsu_vpu_busy;                   
wire            vfdsu_vpu_ex1_denormal_stall;     
wire            vfdsu_vpu_state_idle;             
wire            vfmau_vpu_ex2_result_ready_in_ex3; 
wire    [4 :0]  vfmau_vpu_ex3_fflags;             
wire    [63:0]  vfmau_vpu_ex3_fpr_result;         
wire            vfmau_vpu_ex3_result_ready_in_ex4; 
wire    [4 :0]  vfmau_vpu_ex4_fflags;             
wire    [63:0]  vfmau_vpu_ex4_fpr_result;         
wire    [4 :0]  vfmau_vpu_ex5_fflags;             
wire    [63:0]  vfmau_vpu_ex5_fpr_result;         
wire    [63:0]  vfspu_vpu_ex2_result;             
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
wire    [5 :0]  viq0_rbus_ex3_fflags;             
wire            viq0_rbus_ex3_fflags_vld;         
wire    [63:0]  viq0_rbus_ex3_fpr_wb_data;        
wire    [4 :0]  viq0_rbus_ex3_fpr_wb_index;       
wire            viq0_rbus_ex3_fpr_wb_req;         
wire    [2 :0]  viq0_rbus_ex3_fpu_wb_sel;         
wire    [63:0]  viq0_rbus_ex3_gpr_wb_data;        
wire    [5 :0]  viq0_rbus_ex3_gpr_wb_index;       
wire            viq0_rbus_ex3_gpr_wb_req;         
wire    [5 :0]  viq0_rbus_ex4_fflags;             
wire            viq0_rbus_ex4_fflags_vld;         
wire    [63:0]  viq0_rbus_ex4_fpr_wb_data;        
wire    [4 :0]  viq0_rbus_ex4_fpr_wb_index;       
wire            viq0_rbus_ex4_fpr_wb_req;         
wire    [5 :0]  viq0_rbus_ex5_fflags;             
wire            viq0_rbus_ex5_fflags_vld;         
wire    [63:0]  viq0_rbus_ex5_fpr_wb_data;        
wire    [4 :0]  viq0_rbus_ex5_fpr_wb_index;       
wire            viq0_rbus_ex5_fpr_wb_req;         
wire    [9 :0]  viq0_xx_ex1_eu_sel;               
wire    [19:0]  viq0_xx_ex1_func;                 
wire    [3 :0]  viq0_xx_ex1_gp_sel;               
wire    [1 :0]  viq0_xx_ex1_id_reg;               
wire            viq0_xx_ex1_lsu_inst_vld;         
wire    [2 :0]  viq0_xx_ex1_rm;                   
wire    [63:0]  viq0_xx_ex1_srcv0;                
wire    [47:0]  viq0_xx_ex1_srcv0_type;           
wire    [63:0]  viq0_xx_ex1_srcv1;                
wire    [47:0]  viq0_xx_ex1_srcv1_type;           
wire    [63:0]  viq0_xx_ex1_srcv2;                
wire            viq0_xx_ex1_srcv2_ready;          
wire    [47:0]  viq0_xx_ex1_srcv2_type;           
wire            viq0_xx_ex1_stall;                
wire    [6 :0]  viq0_xx_ex1_vreg;                 
wire    [9 :0]  viq0_xx_ex2_eu_sel;               
wire    [19:0]  viq0_xx_ex2_func;                 
wire    [3 :0]  viq0_xx_ex2_gp_sel;               
wire    [2 :0]  viq0_xx_ex2_rm;                   
wire            viq0_xx_ex2_stall;                
wire    [9 :0]  viq0_xx_ex3_eu_sel;               
wire    [19:0]  viq0_xx_ex3_func;                 
wire    [3 :0]  viq0_xx_ex3_gp_sel;               
wire    [2 :0]  viq0_xx_ex3_rm;                   
wire            viq0_xx_ex3_stall;                
wire    [9 :0]  viq0_xx_ex4_eu_sel;               
wire    [19:0]  viq0_xx_ex4_func;                 
wire    [3 :0]  viq0_xx_ex4_gp_sel;               
wire    [2 :0]  viq0_xx_ex4_rm;                   
wire            viq0_xx_ex4_stall;                
wire            viq0_xx_ex5_stall;                
wire            viq0_xx_ex5_vld;                  
wire            viq0_xx_no_op;                    
wire            viq1_xx_ex1_vint_sel;             
wire            viq1_xx_ex2_vint_result_ready;    
wire            viq1_xx_ex2_vint_sel;             
wire            viq1_xx_ex3_vint_pipedown;        
wire            viq1_xx_ex5_stall;                
wire            vlsu_buf_stall;                   
wire    [63:0]  vlsu_dtu_data;                    
wire            vlsu_dtu_data_vld;                
wire            vlsu_dtu_data_vld_gate;           
wire    [3 :0]  vlsu_lsu_data_shift;              
wire            vlsu_lsu_data_vld;                
wire    [63:0]  vlsu_lsu_fwd_data;                
wire    [4 :0]  vlsu_lsu_fwd_dest_reg;            
wire            vlsu_lsu_fwd_vld;                 
wire            vlsu_lsu_src2_depd;               
wire    [4 :0]  vlsu_lsu_src2_reg;                
wire    [63:0]  vlsu_lsu_wdata;                   
wire    [63:0]  vlsu_rbus_fpr_wb_data;            
wire    [4 :0]  vlsu_rbus_fpr_wb_index;           
wire            vlsu_rbus_fpr_wb_req;             
wire    [7 :0]  vlsu_rtu_vl_updt_data;            
wire            vlsu_rtu_vl_updt_vld;             
wire            vlsu_vex1_split_stall;            
wire            vlsu_xx_ex1_fp_stall;             
wire            vlsu_xx_no_op;                    
wire    [28:0]  vpu_dtu_dbg_info;                 
wire    [9 :0]  vpu_group_0_xx_ex1_eu_sel;        
wire    [19:0]  vpu_group_0_xx_ex1_func;          
wire    [1 :0]  vpu_group_0_xx_ex1_id_reg;        
wire    [2 :0]  vpu_group_0_xx_ex1_rm;            
wire            vpu_group_0_xx_ex1_sel;           
wire    [63:0]  vpu_group_0_xx_ex1_srcv0;         
wire    [47:0]  vpu_group_0_xx_ex1_srcv0_type;    
wire    [63:0]  vpu_group_0_xx_ex1_srcv1;         
wire    [47:0]  vpu_group_0_xx_ex1_srcv1_type;    
wire    [63:0]  vpu_group_0_xx_ex1_srcv2;         
wire    [47:0]  vpu_group_0_xx_ex1_srcv2_type;    
wire    [9 :0]  vpu_group_0_xx_ex2_eu_sel;        
wire    [19:0]  vpu_group_0_xx_ex2_func;          
wire    [2 :0]  vpu_group_0_xx_ex2_rm;            
wire            vpu_group_0_xx_ex2_sel;           
wire            vpu_group_0_xx_ex2_stall;         
wire    [9 :0]  vpu_group_0_xx_ex3_eu_sel;        
wire    [19:0]  vpu_group_0_xx_ex3_func;          
wire    [2 :0]  vpu_group_0_xx_ex3_rm;            
wire            vpu_group_0_xx_ex3_sel;           
wire            vpu_group_0_xx_ex3_stall;         
wire    [9 :0]  vpu_group_0_xx_ex4_eu_sel;        
wire    [19:0]  vpu_group_0_xx_ex4_func;          
wire    [2 :0]  vpu_group_0_xx_ex4_rm;            
wire            vpu_group_0_xx_ex4_sel;           
wire            vpu_group_0_xx_ex4_stall;         
wire            vpu_group_0_xx_ex5_sel;           
wire            vpu_group_0_xx_ex5_stall;         
wire    [9 :0]  vpu_group_1_xx_ex1_eu_sel;        
wire    [19:0]  vpu_group_1_xx_ex1_func;          
wire    [1 :0]  vpu_group_1_xx_ex1_id_reg;        
wire    [2 :0]  vpu_group_1_xx_ex1_rm;            
wire            vpu_group_1_xx_ex1_sel;           
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;         
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type;    
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;         
wire    [47:0]  vpu_group_1_xx_ex1_srcv1_type;    
wire    [63:0]  vpu_group_1_xx_ex1_srcv2;         
wire    [47:0]  vpu_group_1_xx_ex1_srcv2_type;    
wire    [9 :0]  vpu_group_1_xx_ex2_eu_sel;        
wire    [19:0]  vpu_group_1_xx_ex2_func;          
wire    [2 :0]  vpu_group_1_xx_ex2_rm;            
wire            vpu_group_1_xx_ex2_sel;           
wire            vpu_group_1_xx_ex2_stall;         
wire    [9 :0]  vpu_group_1_xx_ex3_eu_sel;        
wire    [19:0]  vpu_group_1_xx_ex3_func;          
wire    [2 :0]  vpu_group_1_xx_ex3_rm;            
wire            vpu_group_1_xx_ex3_sel;           
wire            vpu_group_1_xx_ex3_stall;         
wire    [9 :0]  vpu_group_1_xx_ex4_eu_sel;        
wire    [19:0]  vpu_group_1_xx_ex4_func;          
wire    [2 :0]  vpu_group_1_xx_ex4_rm;            
wire            vpu_group_1_xx_ex4_sel;           
wire            vpu_group_1_xx_ex4_stall;         
wire    [9 :0]  vpu_group_2_xx_ex1_eu_sel;        
wire    [19:0]  vpu_group_2_xx_ex1_func;          
wire    [1 :0]  vpu_group_2_xx_ex1_id_reg;        
wire    [2 :0]  vpu_group_2_xx_ex1_rm;            
wire            vpu_group_2_xx_ex1_sel;           
wire    [63:0]  vpu_group_2_xx_ex1_srcv0;         
wire    [47:0]  vpu_group_2_xx_ex1_srcv0_type;    
wire    [63:0]  vpu_group_2_xx_ex1_srcv1;         
wire    [47:0]  vpu_group_2_xx_ex1_srcv1_type;    
wire    [63:0]  vpu_group_2_xx_ex1_srcv2;         
wire    [47:0]  vpu_group_2_xx_ex1_srcv2_type;    
wire    [9 :0]  vpu_group_2_xx_ex2_eu_sel;        
wire    [19:0]  vpu_group_2_xx_ex2_func;          
wire    [2 :0]  vpu_group_2_xx_ex2_rm;            
wire            vpu_group_2_xx_ex2_sel;           
wire            vpu_group_2_xx_ex2_stall;         
wire    [9 :0]  vpu_group_2_xx_ex3_eu_sel;        
wire    [19:0]  vpu_group_2_xx_ex3_func;          
wire    [2 :0]  vpu_group_2_xx_ex3_rm;            
wire            vpu_group_2_xx_ex3_sel;           
wire            vpu_group_2_xx_ex3_stall;         
wire    [9 :0]  vpu_group_2_xx_ex4_eu_sel;        
wire    [19:0]  vpu_group_2_xx_ex4_func;          
wire    [2 :0]  vpu_group_2_xx_ex4_rm;            
wire            vpu_group_2_xx_ex4_sel;           
wire            vpu_group_2_xx_ex4_stall;         
wire    [9 :0]  vpu_group_3_xx_ex1_eu_sel;        
wire    [19:0]  vpu_group_3_xx_ex1_func;          
wire    [1 :0]  vpu_group_3_xx_ex1_id_reg;        
wire    [2 :0]  vpu_group_3_xx_ex1_rm;            
wire            vpu_group_3_xx_ex1_sel;           
wire    [63:0]  vpu_group_3_xx_ex1_srcv0;         
wire    [47:0]  vpu_group_3_xx_ex1_srcv0_type;    
wire    [63:0]  vpu_group_3_xx_ex1_srcv1;         
wire    [47:0]  vpu_group_3_xx_ex1_srcv1_type;    
wire    [63:0]  vpu_group_3_xx_ex1_srcv2;         
wire            vpu_group_3_xx_ex1_srcv2_ready;   
wire    [47:0]  vpu_group_3_xx_ex1_srcv2_type;    
wire    [6 :0]  vpu_group_3_xx_ex1_vreg;          
wire    [9 :0]  vpu_group_3_xx_ex2_eu_sel;        
wire    [19:0]  vpu_group_3_xx_ex2_func;          
wire    [2 :0]  vpu_group_3_xx_ex2_rm;            
wire            vpu_group_3_xx_ex2_sel;           
wire            vpu_group_3_xx_ex2_stall;         
wire    [9 :0]  vpu_group_3_xx_ex3_eu_sel;        
wire    [19:0]  vpu_group_3_xx_ex3_func;          
wire    [2 :0]  vpu_group_3_xx_ex3_rm;            
wire            vpu_group_3_xx_ex3_sel;           
wire            vpu_group_3_xx_ex3_stall;         
wire    [9 :0]  vpu_group_3_xx_ex4_eu_sel;        
wire    [19:0]  vpu_group_3_xx_ex4_func;          
wire    [2 :0]  vpu_group_3_xx_ex4_rm;            
wire            vpu_group_3_xx_ex4_sel;           
wire            vpu_group_3_xx_ex4_stall;         
wire    [5 :0]  vpu_rtu_fflag;                    
wire            vpu_rtu_fflag_vld;                
wire    [63:0]  vpu_rtu_gpr_wb_data;              
wire    [5 :0]  vpu_rtu_gpr_wb_index;             
wire            vpu_rtu_gpr_wb_req;               
wire            vpu_rtu_no_op;                    
wire            vpu_vfdsu_ex1_sel;                
wire    [63:0]  vpu_vidu_fp_fwd_data;             
wire    [4 :0]  vpu_vidu_fp_fwd_reg;              
wire            vpu_vidu_fp_fwd_vld;              
wire    [63:0]  vpu_vidu_fp_wb_data;              
wire    [4 :0]  vpu_vidu_fp_wb_reg;               
wire            vpu_vidu_fp_wb_vld;               
wire            vpu_vidu_vex1_fp_stall;           
wire    [4 :0]  vpu_vidu_wbt_fp_wb0_reg;          
wire            vpu_vidu_wbt_fp_wb0_vld;          
wire    [4 :0]  vpu_vidu_wbt_fp_wb1_reg;          
wire            vpu_vidu_wbt_fp_wb1_vld;          
wire            vpu_vlsu_ex1_lsu_inst_vld;        
wire    [63:0]  vpu_vlsu_fp_wb_data;              
wire    [4 :0]  vpu_vlsu_fp_wb_reg;               
wire            vpu_vlsu_fp_wb_vld;               

// &Instance("aq_vpu_viq0_vec_info_prepare", "x_aq_vpu_viq0_vec_info_prepare"); @30
// &Instance("aq_vpu_ex1_srcv_prepare", "x_aq_vpu_ex1_srcv_prepare"); @33
// &Instance("aq_vdsp_vmisc_top", "x_aq_vdsp_vmisc_top"); @36
// &Instance("aq_vdsp_vredu_top", "x_aq_vdsp_vredu_top"); @38
// &Instance("aq_vdsp_vshift_top", "x_aq_vdsp_vshift_top"); @40
// &Instance("aq_vdsp_vdivu_top", "x_aq_vdsp_vdivu_top"); @42
// &Instance("aq_vdsp_valu_top", "x_aq_vdsp_valu_top"); @44
// &Instance("aq_vdsp_vperm_top", "x_aq_vdsp_vperm_top"); @46
// &Instance("aq_vdsp_vmulu_top", "x_aq_vdsp_vmulu_top"); @48
// &ConnRule(s/group_0/group_1/); @50
// &Instance("aq_falu_top"); @51
// &Connect( .vpu_group_1_xx_ex1_srcv0 (vpu_group_1_xx_ex1_vfp_srcv0), @52
//           .vpu_group_1_xx_ex1_srcv1 (vpu_group_1_xx_ex1_vfp_srcv1)); @53
// &ConnRule(s/group_1/group_2/); @55
// &Instance("aq_fcnvt_top"); @56
// &Connect( .vpu_group_1_xx_ex1_srcv0 (vpu_group_2_xx_ex1_vfp_srcv0), @57
//           .vpu_group_1_xx_ex1_srcv1 (vpu_group_2_xx_ex1_vfp_srcv1)); @58
// &ConnRule(s/group_1/group_2/); @60
// &Instance("aq_fspu_top"); @61
// &Connect( .vpu_group_1_xx_ex1_srcv0 (vpu_group_2_xx_ex1_vfp_srcv0), @62
//           .vpu_group_1_xx_ex1_srcv1 (vpu_group_2_xx_ex1_vfp_srcv1)); @63
// &ConnRule(s/group_1/group_3/); @65
// &Instance("aq_fdsu_top"); @66
// &Connect( .vpu_group_1_xx_ex1_srcv0 (vpu_group_3_xx_ex1_vfp_srcv0), @67
//           .vpu_group_1_xx_ex1_srcv1 (vpu_group_3_xx_ex1_vfp_srcv1)); @68
// &Instance("aq_vfmau_top","x_aq_vfmau_top"); @70
// &Connect( .vpu_group_0_xx_ex1_srcv0 (vpu_group_0_xx_ex1_vfp_srcv0), @71
//           .vpu_group_0_xx_ex1_srcv1 (vpu_group_0_xx_ex1_vfp_srcv1)); @72
// &ConnRule(s/group_0/group_1/); @75
// &Instance("aq_falu_top"); @76
aq_falu_top  x_aq_falu_top (
  .cp0_vpu_icg_en                    (cp0_vpu_icg_en                   ),
  .cp0_vpu_xx_bf16                   (cp0_vpu_xx_bf16                  ),
  .cp0_vpu_xx_dqnan                  (cp0_vpu_xx_dqnan                 ),
  .cp0_yy_clk_en                     (cp0_yy_clk_en                    ),
  .forever_cpuclk                    (forever_cpuclk                   ),
  .ifu_vpu_warm_up                   (ifu_vpu_warm_up                  ),
  .pad_yy_icg_scan_en                (pad_yy_icg_scan_en               ),
  .vfalu_vpu_ex1_denormal_stall      (vfalu_vpu_ex1_denormal_stall     ),
  .vfalu_vpu_ex2_gpr_result          (vfalu_vpu_ex2_gpr_result         ),
  .vfalu_vpu_ex2_result_ready_in_ex3 (vfalu_vpu_ex2_result_ready_in_ex3),
  .vfalu_vpu_ex3_fflags              (vfalu_vpu_ex3_fflags             ),
  .vfalu_vpu_ex3_fpr_result          (vfalu_vpu_ex3_fpr_result         ),
  .vfalu_vpu_ex3_result_ready_in_ex4 (vfalu_vpu_ex3_result_ready_in_ex4),
  .vfalu_vpu_ex4_fflags              (vfalu_vpu_ex4_fflags             ),
  .vfalu_vpu_ex4_fpr_result          (vfalu_vpu_ex4_fpr_result         ),
  .vpu_group_1_xx_ex1_eu_sel         (vpu_group_1_xx_ex1_eu_sel        ),
  .vpu_group_1_xx_ex1_func           (vpu_group_1_xx_ex1_func          ),
  .vpu_group_1_xx_ex1_rm             (vpu_group_1_xx_ex1_rm            ),
  .vpu_group_1_xx_ex1_sel            (vpu_group_1_xx_ex1_sel           ),
  .vpu_group_1_xx_ex1_srcv0          (vpu_group_1_xx_ex1_srcv0         ),
  .vpu_group_1_xx_ex1_srcv0_type     (vpu_group_1_xx_ex1_srcv0_type    ),
  .vpu_group_1_xx_ex1_srcv1          (vpu_group_1_xx_ex1_srcv1         ),
  .vpu_group_1_xx_ex1_srcv1_type     (vpu_group_1_xx_ex1_srcv1_type    ),
  .vpu_group_1_xx_ex2_eu_sel         (vpu_group_1_xx_ex2_eu_sel        ),
  .vpu_group_1_xx_ex2_rm             (vpu_group_1_xx_ex2_rm            ),
  .vpu_group_1_xx_ex2_sel            (vpu_group_1_xx_ex2_sel           ),
  .vpu_group_1_xx_ex2_stall          (vpu_group_1_xx_ex2_stall         ),
  .vpu_group_1_xx_ex3_eu_sel         (vpu_group_1_xx_ex3_eu_sel        ),
  .vpu_group_1_xx_ex3_sel            (vpu_group_1_xx_ex3_sel           ),
  .vpu_group_1_xx_ex3_stall          (vpu_group_1_xx_ex3_stall         ),
  .vpu_group_1_xx_ex4_stall          (vpu_group_1_xx_ex4_stall         )
);


// &ConnRule(s/group_1/group_2/); @78
// &Instance("aq_fcnvt_top"); @79
aq_fcnvt_top  x_aq_fcnvt_top (
  .cp0_vpu_icg_en                (cp0_vpu_icg_en               ),
  .cp0_vpu_xx_bf16               (cp0_vpu_xx_bf16              ),
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .vfcvt_vpu_ex2_gpr_result      (vfcvt_vpu_ex2_gpr_result     ),
  .vfcvt_vpu_ex3_fflags          (vfcvt_vpu_ex3_fflags         ),
  .vfcvt_vpu_ex3_fpr_result      (vfcvt_vpu_ex3_fpr_result     ),
  .vpu_group_1_xx_ex1_eu_sel     (vpu_group_2_xx_ex1_eu_sel    ),
  .vpu_group_1_xx_ex1_func       (vpu_group_2_xx_ex1_func      ),
  .vpu_group_1_xx_ex1_sel        (vpu_group_2_xx_ex1_sel       ),
  .vpu_group_1_xx_ex1_srcv0      (vpu_group_2_xx_ex1_srcv0     ),
  .vpu_group_1_xx_ex1_srcv0_type (vpu_group_2_xx_ex1_srcv0_type),
  .vpu_group_1_xx_ex1_srcv1      (vpu_group_2_xx_ex1_srcv1     ),
  .vpu_group_1_xx_ex2_eu_sel     (vpu_group_2_xx_ex2_eu_sel    ),
  .vpu_group_1_xx_ex2_rm         (vpu_group_2_xx_ex2_rm        ),
  .vpu_group_1_xx_ex2_sel        (vpu_group_2_xx_ex2_sel       ),
  .vpu_group_1_xx_ex2_stall      (vpu_group_2_xx_ex2_stall     ),
  .vpu_group_1_xx_ex3_stall      (vpu_group_2_xx_ex3_stall     )
);


// &ConnRule(s/group_1/group_2/); @81
// &Instance("aq_fspu_top"); @82
aq_fspu_top  x_aq_fspu_top (
  .cp0_vpu_icg_en                (cp0_vpu_icg_en               ),
  .cp0_vpu_xx_bf16               (cp0_vpu_xx_bf16              ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .vfspu_vpu_ex2_result          (vfspu_vpu_ex2_result         ),
  .vpu_group_1_xx_ex1_eu_sel     (vpu_group_2_xx_ex1_eu_sel    ),
  .vpu_group_1_xx_ex1_func       (vpu_group_2_xx_ex1_func      ),
  .vpu_group_1_xx_ex1_sel        (vpu_group_2_xx_ex1_sel       ),
  .vpu_group_1_xx_ex1_srcv0      (vpu_group_2_xx_ex1_srcv0     ),
  .vpu_group_1_xx_ex1_srcv0_type (vpu_group_2_xx_ex1_srcv0_type),
  .vpu_group_1_xx_ex1_srcv1      (vpu_group_2_xx_ex1_srcv1     ),
  .vpu_group_1_xx_ex1_srcv1_type (vpu_group_2_xx_ex1_srcv1_type),
  .vpu_group_1_xx_ex2_stall      (vpu_group_2_xx_ex2_stall     )
);


// &ConnRule(s/group_1/group_3/); @84
// &Instance("aq_fdsu_top"); @85
aq_fdsu_top  x_aq_fdsu_top (
  .cp0_vpu_icg_en                (cp0_vpu_icg_en               ),
  .cp0_vpu_xx_bf16               (cp0_vpu_xx_bf16              ),
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .cpurst_b                      (cpurst_b                     ),
  .forever_cpuclk                (forever_cpuclk               ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .rbus_vfdsu_fpr_wb_grnt        (rbus_vfdsu_fpr_wb_grnt       ),
  .rtu_yy_xx_async_flush         (rtu_yy_xx_async_flush        ),
  .rtu_yy_xx_flush               (rtu_yy_xx_flush              ),
  .vfdsu_rbus_fflags             (vfdsu_rbus_fflags            ),
  .vfdsu_rbus_fflags_vld         (vfdsu_rbus_fflags_vld        ),
  .vfdsu_rbus_fpr_wb_data        (vfdsu_rbus_fpr_wb_data       ),
  .vfdsu_rbus_fpr_wb_index       (vfdsu_rbus_fpr_wb_index      ),
  .vfdsu_rbus_fpr_wb_req         (vfdsu_rbus_fpr_wb_req        ),
  .vfdsu_vpu_busy                (vfdsu_vpu_busy               ),
  .vfdsu_vpu_ex1_denormal_stall  (vfdsu_vpu_ex1_denormal_stall ),
  .vfdsu_vpu_state_idle          (vfdsu_vpu_state_idle         ),
  .vpu_group_1_xx_ex1_func       (vpu_group_3_xx_ex1_func      ),
  .vpu_group_1_xx_ex1_rm         (vpu_group_3_xx_ex1_rm        ),
  .vpu_group_1_xx_ex1_srcv0      (vpu_group_3_xx_ex1_srcv0     ),
  .vpu_group_1_xx_ex1_srcv0_type (vpu_group_3_xx_ex1_srcv0_type),
  .vpu_group_1_xx_ex1_srcv1      (vpu_group_3_xx_ex1_srcv1     ),
  .vpu_group_1_xx_ex1_srcv1_type (vpu_group_3_xx_ex1_srcv1_type),
  .vpu_group_1_xx_ex1_vreg       (vpu_group_3_xx_ex1_vreg      ),
  .vpu_vfdsu_ex1_sel             (vpu_vfdsu_ex1_sel            )
);


// &Instance("aq_vfmau_top","x_aq_vfmau_top"); @87
aq_vfmau_top  x_aq_vfmau_top (
  .cp0_vpu_icg_en                    (cp0_vpu_icg_en                   ),
  .cp0_vpu_xx_bf16                   (cp0_vpu_xx_bf16                  ),
  .cp0_vpu_xx_dqnan                  (cp0_vpu_xx_dqnan                 ),
  .cp0_yy_clk_en                     (cp0_yy_clk_en                    ),
  .forever_cpuclk                    (forever_cpuclk                   ),
  .ifu_vpu_warm_up                   (ifu_vpu_warm_up                  ),
  .pad_yy_icg_scan_en                (pad_yy_icg_scan_en               ),
  .vfmau_vpu_ex2_result_ready_in_ex3 (vfmau_vpu_ex2_result_ready_in_ex3),
  .vfmau_vpu_ex3_fflags              (vfmau_vpu_ex3_fflags             ),
  .vfmau_vpu_ex3_fpr_result          (vfmau_vpu_ex3_fpr_result         ),
  .vfmau_vpu_ex3_result_ready_in_ex4 (vfmau_vpu_ex3_result_ready_in_ex4),
  .vfmau_vpu_ex4_fflags              (vfmau_vpu_ex4_fflags             ),
  .vfmau_vpu_ex4_fpr_result          (vfmau_vpu_ex4_fpr_result         ),
  .vfmau_vpu_ex5_fflags              (vfmau_vpu_ex5_fflags             ),
  .vfmau_vpu_ex5_fpr_result          (vfmau_vpu_ex5_fpr_result         ),
  .vpu_group_0_xx_ex1_eu_sel         (vpu_group_0_xx_ex1_eu_sel        ),
  .vpu_group_0_xx_ex1_func           (vpu_group_0_xx_ex1_func          ),
  .vpu_group_0_xx_ex1_id_reg         (vpu_group_0_xx_ex1_id_reg        ),
  .vpu_group_0_xx_ex1_rm             (vpu_group_0_xx_ex1_rm            ),
  .vpu_group_0_xx_ex1_sel            (vpu_group_0_xx_ex1_sel           ),
  .vpu_group_0_xx_ex1_srcv0          (vpu_group_0_xx_ex1_srcv0         ),
  .vpu_group_0_xx_ex1_srcv0_type     (vpu_group_0_xx_ex1_srcv0_type    ),
  .vpu_group_0_xx_ex1_srcv1          (vpu_group_0_xx_ex1_srcv1         ),
  .vpu_group_0_xx_ex1_srcv1_type     (vpu_group_0_xx_ex1_srcv1_type    ),
  .vpu_group_0_xx_ex1_srcv2          (vpu_group_0_xx_ex1_srcv2         ),
  .vpu_group_0_xx_ex1_srcv2_type     (vpu_group_0_xx_ex1_srcv2_type    ),
  .vpu_group_0_xx_ex2_eu_sel         (vpu_group_0_xx_ex2_eu_sel        ),
  .vpu_group_0_xx_ex2_sel            (vpu_group_0_xx_ex2_sel           ),
  .vpu_group_0_xx_ex2_stall          (vpu_group_0_xx_ex2_stall         ),
  .vpu_group_0_xx_ex3_eu_sel         (vpu_group_0_xx_ex3_eu_sel        ),
  .vpu_group_0_xx_ex3_sel            (vpu_group_0_xx_ex3_sel           ),
  .vpu_group_0_xx_ex3_stall          (vpu_group_0_xx_ex3_stall         ),
  .vpu_group_0_xx_ex4_eu_sel         (vpu_group_0_xx_ex4_eu_sel        ),
  .vpu_group_0_xx_ex4_sel            (vpu_group_0_xx_ex4_sel           ),
  .vpu_group_0_xx_ex4_stall          (vpu_group_0_xx_ex4_stall         ),
  .vpu_group_0_xx_ex5_stall          (vpu_group_0_xx_ex5_stall         )
);


assign viq1_xx_ex1_vint_sel          = 1'b0;
assign viq1_xx_ex2_vint_result_ready = 1'b0;
assign viq1_xx_ex2_vint_sel          = 1'b0;
assign viq1_xx_ex3_vint_pipedown     = 1'b0;
assign viq1_xx_ex5_stall             = 1'b0;

// &Instance("aq_vlsu_top","x_aq_vlsu_top"); @96
aq_vlsu_top  x_aq_vlsu_top (
  .cp0_vpu_icg_en                 (cp0_vpu_icg_en                ),
  .cpurst_b                       (cpurst_b                      ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .ifu_vpu_warm_up                (ifu_vpu_warm_up               ),
  .lsu_vlsu_bytes_vld             (lsu_vlsu_bytes_vld            ),
  .lsu_vlsu_data                  (lsu_vlsu_data                 ),
  .lsu_vlsu_data_grant            (lsu_vlsu_data_grant           ),
  .lsu_vlsu_data_vld              (lsu_vlsu_data_vld             ),
  .lsu_vlsu_dc_create_vld         (lsu_vlsu_dc_create_vld        ),
  .lsu_vlsu_dc_fld_req            (lsu_vlsu_dc_fld_req           ),
  .lsu_vlsu_dc_fof                (lsu_vlsu_dc_fof               ),
  .lsu_vlsu_dc_nf                 (lsu_vlsu_dc_nf                ),
  .lsu_vlsu_dc_sew                (lsu_vlsu_dc_sew               ),
  .lsu_vlsu_dc_split_cnt          (lsu_vlsu_dc_split_cnt         ),
  .lsu_vlsu_dc_sseg_first         (lsu_vlsu_dc_sseg_first        ),
  .lsu_vlsu_dc_stall              (lsu_vlsu_dc_stall             ),
  .lsu_vlsu_dest_reg              (lsu_vlsu_dest_reg             ),
  .lsu_vlsu_expt_vld              (lsu_vlsu_expt_vld             ),
  .lsu_vlsu_func                  (lsu_vlsu_func                 ),
  .lsu_vlsu_sew                   (lsu_vlsu_sew                  ),
  .lsu_vlsu_split_last            (lsu_vlsu_split_last           ),
  .lsu_vlsu_st_expt               (lsu_vlsu_st_expt              ),
  .lsu_vlsu_st_offset             (lsu_vlsu_st_offset            ),
  .lsu_vlsu_st_sew                (lsu_vlsu_st_sew               ),
  .lsu_vlsu_st_size               (lsu_vlsu_st_size              ),
  .lsu_vlsu_vl_update             (lsu_vlsu_vl_update            ),
  .lsu_vlsu_vl_upval              (lsu_vlsu_vl_upval             ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            ),
  .rtu_yy_xx_async_flush          (rtu_yy_xx_async_flush         ),
  .rtu_yy_xx_flush                (rtu_yy_xx_flush               ),
  .vlsu_buf_stall                 (vlsu_buf_stall                ),
  .vlsu_dtu_data                  (vlsu_dtu_data                 ),
  .vlsu_dtu_data_vld              (vlsu_dtu_data_vld             ),
  .vlsu_dtu_data_vld_gate         (vlsu_dtu_data_vld_gate        ),
  .vlsu_lsu_data_shift            (vlsu_lsu_data_shift           ),
  .vlsu_lsu_data_vld              (vlsu_lsu_data_vld             ),
  .vlsu_lsu_fwd_data              (vlsu_lsu_fwd_data             ),
  .vlsu_lsu_fwd_dest_reg          (vlsu_lsu_fwd_dest_reg         ),
  .vlsu_lsu_fwd_vld               (vlsu_lsu_fwd_vld              ),
  .vlsu_lsu_src2_depd             (vlsu_lsu_src2_depd            ),
  .vlsu_lsu_src2_reg              (vlsu_lsu_src2_reg             ),
  .vlsu_lsu_wdata                 (vlsu_lsu_wdata                ),
  .vlsu_rbus_fpr_wb_data          (vlsu_rbus_fpr_wb_data         ),
  .vlsu_rbus_fpr_wb_index         (vlsu_rbus_fpr_wb_index        ),
  .vlsu_rbus_fpr_wb_req           (vlsu_rbus_fpr_wb_req          ),
  .vlsu_rtu_vl_updt_data          (vlsu_rtu_vl_updt_data         ),
  .vlsu_rtu_vl_updt_vld           (vlsu_rtu_vl_updt_vld          ),
  .vlsu_vex1_split_stall          (vlsu_vex1_split_stall         ),
  .vlsu_xx_ex1_fp_stall           (vlsu_xx_ex1_fp_stall          ),
  .vlsu_xx_no_op                  (vlsu_xx_no_op                 ),
  .vpu_group_3_xx_ex1_func        (vpu_group_3_xx_ex1_func       ),
  .vpu_group_3_xx_ex1_sel         (vpu_group_3_xx_ex1_sel        ),
  .vpu_group_3_xx_ex1_srcv1       (vpu_group_3_xx_ex1_srcv1      ),
  .vpu_group_3_xx_ex1_srcv2       (vpu_group_3_xx_ex1_srcv2      ),
  .vpu_group_3_xx_ex1_srcv2_ready (vpu_group_3_xx_ex1_srcv2_ready),
  .vpu_group_3_xx_ex1_vreg        (vpu_group_3_xx_ex1_vreg       ),
  .vpu_vlsu_ex1_lsu_inst_vld      (vpu_vlsu_ex1_lsu_inst_vld     ),
  .vpu_vlsu_fp_wb_data            (vpu_vlsu_fp_wb_data           ),
  .vpu_vlsu_fp_wb_reg             (vpu_vlsu_fp_wb_reg            ),
  .vpu_vlsu_fp_wb_vld             (vpu_vlsu_fp_wb_vld            )
);


// &Instance("aq_vpu_fwd_wb_rbus", "x_aq_vpu_fwd_wb_rbus"); @98
aq_vpu_fwd_wb_rbus  x_aq_vpu_fwd_wb_rbus (
  .cp0_vpu_icg_en                 (cp0_vpu_icg_en                ),
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpurst_b                       (cpurst_b                      ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .ifu_vpu_warm_up                (ifu_vpu_warm_up               ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            ),
  .rbus_vfdsu_fpr_wb_grnt         (rbus_vfdsu_fpr_wb_grnt        ),
  .rbus_viq0_ex3_fpr_wb_grnt      (rbus_viq0_ex3_fpr_wb_grnt     ),
  .rbus_viq0_ex3_gpr_wb_grnt      (rbus_viq0_ex3_gpr_wb_grnt     ),
  .rbus_viq0_ex4_fpr_wb_grnt      (rbus_viq0_ex4_fpr_wb_grnt     ),
  .rbus_viq0_ex5_fpr_wb_grnt      (rbus_viq0_ex5_fpr_wb_grnt     ),
  .rtu_vpu_gpr_wb_grnt            (rtu_vpu_gpr_wb_grnt           ),
  .rtu_yy_xx_async_flush          (rtu_yy_xx_async_flush         ),
  .vfalu_vpu_ex3_fpr_result       (vfalu_vpu_ex3_fpr_result      ),
  .vfcvt_vpu_ex3_fpr_result       (vfcvt_vpu_ex3_fpr_result      ),
  .vfdsu_rbus_fflags              (vfdsu_rbus_fflags             ),
  .vfdsu_rbus_fflags_vld          (vfdsu_rbus_fflags_vld         ),
  .vfdsu_rbus_fpr_wb_data         (vfdsu_rbus_fpr_wb_data        ),
  .vfdsu_rbus_fpr_wb_index        (vfdsu_rbus_fpr_wb_index       ),
  .vfdsu_rbus_fpr_wb_req          (vfdsu_rbus_fpr_wb_req         ),
  .vfdsu_vpu_busy                 (vfdsu_vpu_busy                ),
  .vfmau_vpu_ex3_fpr_result       (vfmau_vpu_ex3_fpr_result      ),
  .vidu_vpu_vid_fp_inst_vld       (vidu_vpu_vid_fp_inst_vld      ),
  .viq0_rbus_ex3_fflags           (viq0_rbus_ex3_fflags          ),
  .viq0_rbus_ex3_fflags_vld       (viq0_rbus_ex3_fflags_vld      ),
  .viq0_rbus_ex3_fpr_wb_data      (viq0_rbus_ex3_fpr_wb_data     ),
  .viq0_rbus_ex3_fpr_wb_index     (viq0_rbus_ex3_fpr_wb_index    ),
  .viq0_rbus_ex3_fpr_wb_req       (viq0_rbus_ex3_fpr_wb_req      ),
  .viq0_rbus_ex3_fpu_wb_sel       (viq0_rbus_ex3_fpu_wb_sel      ),
  .viq0_rbus_ex3_gpr_wb_data      (viq0_rbus_ex3_gpr_wb_data     ),
  .viq0_rbus_ex3_gpr_wb_index     (viq0_rbus_ex3_gpr_wb_index    ),
  .viq0_rbus_ex3_gpr_wb_req       (viq0_rbus_ex3_gpr_wb_req      ),
  .viq0_rbus_ex4_fflags           (viq0_rbus_ex4_fflags          ),
  .viq0_rbus_ex4_fflags_vld       (viq0_rbus_ex4_fflags_vld      ),
  .viq0_rbus_ex4_fpr_wb_data      (viq0_rbus_ex4_fpr_wb_data     ),
  .viq0_rbus_ex4_fpr_wb_index     (viq0_rbus_ex4_fpr_wb_index    ),
  .viq0_rbus_ex4_fpr_wb_req       (viq0_rbus_ex4_fpr_wb_req      ),
  .viq0_rbus_ex5_fflags           (viq0_rbus_ex5_fflags          ),
  .viq0_rbus_ex5_fflags_vld       (viq0_rbus_ex5_fflags_vld      ),
  .viq0_rbus_ex5_fpr_wb_data      (viq0_rbus_ex5_fpr_wb_data     ),
  .viq0_rbus_ex5_fpr_wb_index     (viq0_rbus_ex5_fpr_wb_index    ),
  .viq0_rbus_ex5_fpr_wb_req       (viq0_rbus_ex5_fpr_wb_req      ),
  .viq0_xx_ex1_gp_sel             (viq0_xx_ex1_gp_sel            ),
  .viq0_xx_ex1_lsu_inst_vld       (viq0_xx_ex1_lsu_inst_vld      ),
  .viq0_xx_ex1_srcv2_ready        (viq0_xx_ex1_srcv2_ready       ),
  .viq0_xx_ex1_stall              (viq0_xx_ex1_stall             ),
  .viq0_xx_ex1_vreg               (viq0_xx_ex1_vreg              ),
  .viq0_xx_ex5_stall              (viq0_xx_ex5_stall             ),
  .viq0_xx_ex5_vld                (viq0_xx_ex5_vld               ),
  .viq0_xx_no_op                  (viq0_xx_no_op                 ),
  .viq1_xx_ex5_stall              (viq1_xx_ex5_stall             ),
  .vlsu_rbus_fpr_wb_data          (vlsu_rbus_fpr_wb_data         ),
  .vlsu_rbus_fpr_wb_index         (vlsu_rbus_fpr_wb_index        ),
  .vlsu_rbus_fpr_wb_req           (vlsu_rbus_fpr_wb_req          ),
  .vlsu_xx_ex1_fp_stall           (vlsu_xx_ex1_fp_stall          ),
  .vpu_dtu_dbg_info               (vpu_dtu_dbg_info              ),
  .vpu_group_0_xx_ex5_sel         (vpu_group_0_xx_ex5_sel        ),
  .vpu_group_0_xx_ex5_stall       (vpu_group_0_xx_ex5_stall      ),
  .vpu_group_3_xx_ex1_eu_sel      (vpu_group_3_xx_ex1_eu_sel     ),
  .vpu_group_3_xx_ex1_sel         (vpu_group_3_xx_ex1_sel        ),
  .vpu_group_3_xx_ex1_srcv2_ready (vpu_group_3_xx_ex1_srcv2_ready),
  .vpu_group_3_xx_ex1_vreg        (vpu_group_3_xx_ex1_vreg       ),
  .vpu_rtu_fflag                  (vpu_rtu_fflag                 ),
  .vpu_rtu_fflag_vld              (vpu_rtu_fflag_vld             ),
  .vpu_rtu_gpr_wb_data            (vpu_rtu_gpr_wb_data           ),
  .vpu_rtu_gpr_wb_index           (vpu_rtu_gpr_wb_index          ),
  .vpu_rtu_gpr_wb_req             (vpu_rtu_gpr_wb_req            ),
  .vpu_rtu_no_op                  (vpu_rtu_no_op                 ),
  .vpu_vfdsu_ex1_sel              (vpu_vfdsu_ex1_sel             ),
  .vpu_vidu_fp_fwd_data           (vpu_vidu_fp_fwd_data          ),
  .vpu_vidu_fp_fwd_reg            (vpu_vidu_fp_fwd_reg           ),
  .vpu_vidu_fp_fwd_vld            (vpu_vidu_fp_fwd_vld           ),
  .vpu_vidu_fp_wb_data            (vpu_vidu_fp_wb_data           ),
  .vpu_vidu_fp_wb_reg             (vpu_vidu_fp_wb_reg            ),
  .vpu_vidu_fp_wb_vld             (vpu_vidu_fp_wb_vld            ),
  .vpu_vidu_vex1_fp_stall         (vpu_vidu_vex1_fp_stall        ),
  .vpu_vidu_wbt_fp_wb0_reg        (vpu_vidu_wbt_fp_wb0_reg       ),
  .vpu_vidu_wbt_fp_wb0_vld        (vpu_vidu_wbt_fp_wb0_vld       ),
  .vpu_vidu_wbt_fp_wb1_reg        (vpu_vidu_wbt_fp_wb1_reg       ),
  .vpu_vidu_wbt_fp_wb1_vld        (vpu_vidu_wbt_fp_wb1_vld       ),
  .vpu_vlsu_ex1_lsu_inst_vld      (vpu_vlsu_ex1_lsu_inst_vld     ),
  .vpu_vlsu_fp_wb_data            (vpu_vlsu_fp_wb_data           ),
  .vpu_vlsu_fp_wb_reg             (vpu_vlsu_fp_wb_reg            ),
  .vpu_vlsu_fp_wb_vld             (vpu_vlsu_fp_wb_vld            )
);


// &ConnRule(s/_vecx_/_vec00_/); @100
// &ConnRule(s/viqx_/viq0_/); @101
// &ConnRule(s/viqs_/viq1_/); @102
// &Instance("aq_vpu_viq_dp", "x_aq_vpu_viq0_dp"); @103
aq_vpu_viq_dp  x_aq_vpu_viq0_dp (
  .cp0_vpu_icg_en                    (cp0_vpu_icg_en                   ),
  .cp0_vpu_xx_bf16                   (cp0_vpu_xx_bf16                  ),
  .cp0_vpu_xx_rm                     (cp0_vpu_xx_rm                    ),
  .cp0_yy_clk_en                     (cp0_yy_clk_en                    ),
  .cpurst_b                          (cpurst_b                         ),
  .forever_cpuclk                    (forever_cpuclk                   ),
  .handle_double_vpu                 (1'b0                             ),
  .handle_scalar_fpu                 (1'b1                             ),
  .ifu_vpu_warm_up                   (ifu_vpu_warm_up                  ),
  .pad_yy_icg_scan_en                (pad_yy_icg_scan_en               ),
  .rbus_viqx_ex3_fpr_wb_grnt         (rbus_viq0_ex3_fpr_wb_grnt        ),
  .rbus_viqx_ex3_gpr_wb_grnt         (rbus_viq0_ex3_gpr_wb_grnt        ),
  .rbus_viqx_ex4_fpr_wb_grnt         (rbus_viq0_ex4_fpr_wb_grnt        ),
  .rbus_viqx_ex5_fpr_wb_grnt         (rbus_viq0_ex5_fpr_wb_grnt        ),
  .rtu_yy_xx_async_flush             (rtu_yy_xx_async_flush            ),
  .vfalu_vpu_ex1_denormal_stall      (vfalu_vpu_ex1_denormal_stall     ),
  .vfalu_vpu_ex2_gpr_result          (vfalu_vpu_ex2_gpr_result         ),
  .vfalu_vpu_ex2_result_ready_in_ex3 (vfalu_vpu_ex2_result_ready_in_ex3),
  .vfalu_vpu_ex3_fflags              (vfalu_vpu_ex3_fflags             ),
  .vfalu_vpu_ex3_result_ready_in_ex4 (vfalu_vpu_ex3_result_ready_in_ex4),
  .vfalu_vpu_ex4_fflags              (vfalu_vpu_ex4_fflags             ),
  .vfalu_vpu_ex4_fpr_result          (vfalu_vpu_ex4_fpr_result         ),
  .vfcvt_vpu_ex2_gpr_result          (vfcvt_vpu_ex2_gpr_result         ),
  .vfcvt_vpu_ex3_fflags              (vfcvt_vpu_ex3_fflags             ),
  .vfdsu_vpu_busy                    (vfdsu_vpu_busy                   ),
  .vfdsu_vpu_ex1_denormal_stall      (vfdsu_vpu_ex1_denormal_stall     ),
  .vfdsu_vpu_state_idle              (vfdsu_vpu_state_idle             ),
  .vfmau_vpu_ex2_result_ready_in_ex3 (vfmau_vpu_ex2_result_ready_in_ex3),
  .vfmau_vpu_ex3_fflags              (vfmau_vpu_ex3_fflags             ),
  .vfmau_vpu_ex3_result_ready_in_ex4 (vfmau_vpu_ex3_result_ready_in_ex4),
  .vfmau_vpu_ex4_fflags              (vfmau_vpu_ex4_fflags             ),
  .vfmau_vpu_ex4_fpr_result          (vfmau_vpu_ex4_fpr_result         ),
  .vfmau_vpu_ex5_fflags              (vfmau_vpu_ex5_fflags             ),
  .vfmau_vpu_ex5_fpr_result          (vfmau_vpu_ex5_fpr_result         ),
  .vfspu_vpu_ex2_result              (vfspu_vpu_ex2_result             ),
  .vidu_vpu_vid_fp_inst_dp_vld       (vidu_vpu_vid_fp_inst_dp_vld      ),
  .vidu_vpu_vid_fp_inst_dst_reg      (vidu_vpu_vid_fp_inst_dst_reg     ),
  .vidu_vpu_vid_fp_inst_dst_vld      (vidu_vpu_vid_fp_inst_dst_vld     ),
  .vidu_vpu_vid_fp_inst_dste_vld     (vidu_vpu_vid_fp_inst_dste_vld    ),
  .vidu_vpu_vid_fp_inst_dstf_reg     (vidu_vpu_vid_fp_inst_dstf_reg    ),
  .vidu_vpu_vid_fp_inst_dstf_vld     (vidu_vpu_vid_fp_inst_dstf_vld    ),
  .vidu_vpu_vid_fp_inst_eu           (vidu_vpu_vid_fp_inst_eu          ),
  .vidu_vpu_vid_fp_inst_func         (vidu_vpu_vid_fp_inst_func        ),
  .vidu_vpu_vid_fp_inst_gateclk_vld  (vidu_vpu_vid_fp_inst_gateclk_vld ),
  .vidu_vpu_vid_fp_inst_src1_data    (vidu_vpu_vid_fp_inst_src1_data   ),
  .vidu_vpu_vid_fp_inst_srcf0_data   (vidu_vpu_vid_fp_inst_srcf0_data  ),
  .vidu_vpu_vid_fp_inst_srcf1_data   (vidu_vpu_vid_fp_inst_srcf1_data  ),
  .vidu_vpu_vid_fp_inst_srcf2_data   (vidu_vpu_vid_fp_inst_srcf2_data  ),
  .vidu_vpu_vid_fp_inst_srcf2_rdy    (vidu_vpu_vid_fp_inst_srcf2_rdy   ),
  .vidu_vpu_vid_fp_inst_srcf2_vld    (vidu_vpu_vid_fp_inst_srcf2_vld   ),
  .vidu_vpu_vid_fp_inst_vld          (vidu_vpu_vid_fp_inst_vld         ),
  .viqs_xx_ex1_vint_sel              (viq1_xx_ex1_vint_sel             ),
  .viqs_xx_ex2_vint_result_ready     (viq1_xx_ex2_vint_result_ready    ),
  .viqs_xx_ex2_vint_sel              (viq1_xx_ex2_vint_sel             ),
  .viqs_xx_ex3_vint_pipedown         (viq1_xx_ex3_vint_pipedown        ),
  .viqs_xx_ex5_stall                 (viq1_xx_ex5_stall                ),
  .viqx_rbus_ex3_fflags              (viq0_rbus_ex3_fflags             ),
  .viqx_rbus_ex3_fflags_vld          (viq0_rbus_ex3_fflags_vld         ),
  .viqx_rbus_ex3_fpr_wb_data         (viq0_rbus_ex3_fpr_wb_data        ),
  .viqx_rbus_ex3_fpr_wb_index        (viq0_rbus_ex3_fpr_wb_index       ),
  .viqx_rbus_ex3_fpr_wb_req          (viq0_rbus_ex3_fpr_wb_req         ),
  .viqx_rbus_ex3_fpu_wb_sel          (viq0_rbus_ex3_fpu_wb_sel         ),
  .viqx_rbus_ex3_gpr_wb_data         (viq0_rbus_ex3_gpr_wb_data        ),
  .viqx_rbus_ex3_gpr_wb_index        (viq0_rbus_ex3_gpr_wb_index       ),
  .viqx_rbus_ex3_gpr_wb_req          (viq0_rbus_ex3_gpr_wb_req         ),
  .viqx_rbus_ex4_fflags              (viq0_rbus_ex4_fflags             ),
  .viqx_rbus_ex4_fflags_vld          (viq0_rbus_ex4_fflags_vld         ),
  .viqx_rbus_ex4_fpr_wb_data         (viq0_rbus_ex4_fpr_wb_data        ),
  .viqx_rbus_ex4_fpr_wb_index        (viq0_rbus_ex4_fpr_wb_index       ),
  .viqx_rbus_ex4_fpr_wb_req          (viq0_rbus_ex4_fpr_wb_req         ),
  .viqx_rbus_ex5_fflags              (viq0_rbus_ex5_fflags             ),
  .viqx_rbus_ex5_fflags_vld          (viq0_rbus_ex5_fflags_vld         ),
  .viqx_rbus_ex5_fpr_wb_data         (viq0_rbus_ex5_fpr_wb_data        ),
  .viqx_rbus_ex5_fpr_wb_index        (viq0_rbus_ex5_fpr_wb_index       ),
  .viqx_rbus_ex5_fpr_wb_req          (viq0_rbus_ex5_fpr_wb_req         ),
  .viqx_xx_ex1_eu_sel                (viq0_xx_ex1_eu_sel               ),
  .viqx_xx_ex1_func                  (viq0_xx_ex1_func                 ),
  .viqx_xx_ex1_gp_sel                (viq0_xx_ex1_gp_sel               ),
  .viqx_xx_ex1_id_reg                (viq0_xx_ex1_id_reg               ),
  .viqx_xx_ex1_lsu_inst_vld          (viq0_xx_ex1_lsu_inst_vld         ),
  .viqx_xx_ex1_rm                    (viq0_xx_ex1_rm                   ),
  .viqx_xx_ex1_srcv0                 (viq0_xx_ex1_srcv0                ),
  .viqx_xx_ex1_srcv0_type            (viq0_xx_ex1_srcv0_type           ),
  .viqx_xx_ex1_srcv1                 (viq0_xx_ex1_srcv1                ),
  .viqx_xx_ex1_srcv1_type            (viq0_xx_ex1_srcv1_type           ),
  .viqx_xx_ex1_srcv2                 (viq0_xx_ex1_srcv2                ),
  .viqx_xx_ex1_srcv2_ready           (viq0_xx_ex1_srcv2_ready          ),
  .viqx_xx_ex1_srcv2_type            (viq0_xx_ex1_srcv2_type           ),
  .viqx_xx_ex1_stall                 (viq0_xx_ex1_stall                ),
  .viqx_xx_ex1_vreg                  (viq0_xx_ex1_vreg                 ),
  .viqx_xx_ex2_eu_sel                (viq0_xx_ex2_eu_sel               ),
  .viqx_xx_ex2_func                  (viq0_xx_ex2_func                 ),
  .viqx_xx_ex2_gp_sel                (viq0_xx_ex2_gp_sel               ),
  .viqx_xx_ex2_rm                    (viq0_xx_ex2_rm                   ),
  .viqx_xx_ex2_stall                 (viq0_xx_ex2_stall                ),
  .viqx_xx_ex3_eu_sel                (viq0_xx_ex3_eu_sel               ),
  .viqx_xx_ex3_func                  (viq0_xx_ex3_func                 ),
  .viqx_xx_ex3_gp_sel                (viq0_xx_ex3_gp_sel               ),
  .viqx_xx_ex3_rm                    (viq0_xx_ex3_rm                   ),
  .viqx_xx_ex3_stall                 (viq0_xx_ex3_stall                ),
  .viqx_xx_ex4_eu_sel                (viq0_xx_ex4_eu_sel               ),
  .viqx_xx_ex4_func                  (viq0_xx_ex4_func                 ),
  .viqx_xx_ex4_gp_sel                (viq0_xx_ex4_gp_sel               ),
  .viqx_xx_ex4_rm                    (viq0_xx_ex4_rm                   ),
  .viqx_xx_ex4_stall                 (viq0_xx_ex4_stall                ),
  .viqx_xx_ex5_stall                 (viq0_xx_ex5_stall                ),
  .viqx_xx_ex5_vld                   (viq0_xx_ex5_vld                  ),
  .viqx_xx_no_op                     (viq0_xx_no_op                    ),
  .vlsu_vex1_split_stall             (vlsu_vex1_split_stall            )
);

// &Connect( .handle_scalar_fpu(1'b1)); @104
// &Connect( .handle_double_vpu(1'b1)); @106
// &Connect( .handle_double_vpu(1'b0)); @108

// &ConnRule(s/_vecx_/_vec1_/); @112
// &ConnRule(s/viqx_/viq1_/); @113
// &ConnRule(s/viqs_/viq0_/); @114
// &Instance("aq_vpu_viq_dp", "x_aq_vpu_viq1_dp"); @115
// &Connect( .handle_scalar_fpu(1'b0)); @116
// &Connect( .handle_double_vpu(1'b1)); @118
// &Connect( .handle_double_vpu(1'b0)); @120


// &ConnRule(s/group_x_/group_0_/); @125
// &Instance("aq_vpu_group_unit", "x_aq_vpu_group_0"); @126
aq_vpu_group_unit  x_aq_vpu_group_0 (
  .group_index                   (4'b0001                      ),
  .viq0_xx_ex1_eu_sel            (viq0_xx_ex1_eu_sel           ),
  .viq0_xx_ex1_func              (viq0_xx_ex1_func             ),
  .viq0_xx_ex1_gp_sel            (viq0_xx_ex1_gp_sel           ),
  .viq0_xx_ex1_id_reg            (viq0_xx_ex1_id_reg           ),
  .viq0_xx_ex1_rm                (viq0_xx_ex1_rm               ),
  .viq0_xx_ex1_srcv0             (viq0_xx_ex1_srcv0            ),
  .viq0_xx_ex1_srcv0_type        (viq0_xx_ex1_srcv0_type       ),
  .viq0_xx_ex1_srcv1             (viq0_xx_ex1_srcv1            ),
  .viq0_xx_ex1_srcv1_type        (viq0_xx_ex1_srcv1_type       ),
  .viq0_xx_ex1_srcv2             (viq0_xx_ex1_srcv2            ),
  .viq0_xx_ex1_srcv2_type        (viq0_xx_ex1_srcv2_type       ),
  .viq0_xx_ex2_eu_sel            (viq0_xx_ex2_eu_sel           ),
  .viq0_xx_ex2_func              (viq0_xx_ex2_func             ),
  .viq0_xx_ex2_gp_sel            (viq0_xx_ex2_gp_sel           ),
  .viq0_xx_ex2_rm                (viq0_xx_ex2_rm               ),
  .viq0_xx_ex2_stall             (viq0_xx_ex2_stall            ),
  .viq0_xx_ex3_eu_sel            (viq0_xx_ex3_eu_sel           ),
  .viq0_xx_ex3_func              (viq0_xx_ex3_func             ),
  .viq0_xx_ex3_gp_sel            (viq0_xx_ex3_gp_sel           ),
  .viq0_xx_ex3_rm                (viq0_xx_ex3_rm               ),
  .viq0_xx_ex3_stall             (viq0_xx_ex3_stall            ),
  .viq0_xx_ex4_eu_sel            (viq0_xx_ex4_eu_sel           ),
  .viq0_xx_ex4_func              (viq0_xx_ex4_func             ),
  .viq0_xx_ex4_gp_sel            (viq0_xx_ex4_gp_sel           ),
  .viq0_xx_ex4_rm                (viq0_xx_ex4_rm               ),
  .viq0_xx_ex4_stall             (viq0_xx_ex4_stall            ),
  .vpu_group_x_xx_ex1_eu_sel     (vpu_group_0_xx_ex1_eu_sel    ),
  .vpu_group_x_xx_ex1_func       (vpu_group_0_xx_ex1_func      ),
  .vpu_group_x_xx_ex1_id_reg     (vpu_group_0_xx_ex1_id_reg    ),
  .vpu_group_x_xx_ex1_rm         (vpu_group_0_xx_ex1_rm        ),
  .vpu_group_x_xx_ex1_sel        (vpu_group_0_xx_ex1_sel       ),
  .vpu_group_x_xx_ex1_srcv0      (vpu_group_0_xx_ex1_srcv0     ),
  .vpu_group_x_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_x_xx_ex1_srcv1      (vpu_group_0_xx_ex1_srcv1     ),
  .vpu_group_x_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_x_xx_ex1_srcv2      (vpu_group_0_xx_ex1_srcv2     ),
  .vpu_group_x_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type),
  .vpu_group_x_xx_ex2_eu_sel     (vpu_group_0_xx_ex2_eu_sel    ),
  .vpu_group_x_xx_ex2_func       (vpu_group_0_xx_ex2_func      ),
  .vpu_group_x_xx_ex2_rm         (vpu_group_0_xx_ex2_rm        ),
  .vpu_group_x_xx_ex2_sel        (vpu_group_0_xx_ex2_sel       ),
  .vpu_group_x_xx_ex2_stall      (vpu_group_0_xx_ex2_stall     ),
  .vpu_group_x_xx_ex3_eu_sel     (vpu_group_0_xx_ex3_eu_sel    ),
  .vpu_group_x_xx_ex3_func       (vpu_group_0_xx_ex3_func      ),
  .vpu_group_x_xx_ex3_rm         (vpu_group_0_xx_ex3_rm        ),
  .vpu_group_x_xx_ex3_sel        (vpu_group_0_xx_ex3_sel       ),
  .vpu_group_x_xx_ex3_stall      (vpu_group_0_xx_ex3_stall     ),
  .vpu_group_x_xx_ex4_eu_sel     (vpu_group_0_xx_ex4_eu_sel    ),
  .vpu_group_x_xx_ex4_func       (vpu_group_0_xx_ex4_func      ),
  .vpu_group_x_xx_ex4_rm         (vpu_group_0_xx_ex4_rm        ),
  .vpu_group_x_xx_ex4_sel        (vpu_group_0_xx_ex4_sel       ),
  .vpu_group_x_xx_ex4_stall      (vpu_group_0_xx_ex4_stall     )
);

// &Connect (.group_index (4'b0001)); @127

// &ConnRule(s/group_x_/group_1_/); @129
// &Instance("aq_vpu_group_unit", "x_aq_vpu_group_1"); @130
aq_vpu_group_unit  x_aq_vpu_group_1 (
  .group_index                   (4'b0010                      ),
  .viq0_xx_ex1_eu_sel            (viq0_xx_ex1_eu_sel           ),
  .viq0_xx_ex1_func              (viq0_xx_ex1_func             ),
  .viq0_xx_ex1_gp_sel            (viq0_xx_ex1_gp_sel           ),
  .viq0_xx_ex1_id_reg            (viq0_xx_ex1_id_reg           ),
  .viq0_xx_ex1_rm                (viq0_xx_ex1_rm               ),
  .viq0_xx_ex1_srcv0             (viq0_xx_ex1_srcv0            ),
  .viq0_xx_ex1_srcv0_type        (viq0_xx_ex1_srcv0_type       ),
  .viq0_xx_ex1_srcv1             (viq0_xx_ex1_srcv1            ),
  .viq0_xx_ex1_srcv1_type        (viq0_xx_ex1_srcv1_type       ),
  .viq0_xx_ex1_srcv2             (viq0_xx_ex1_srcv2            ),
  .viq0_xx_ex1_srcv2_type        (viq0_xx_ex1_srcv2_type       ),
  .viq0_xx_ex2_eu_sel            (viq0_xx_ex2_eu_sel           ),
  .viq0_xx_ex2_func              (viq0_xx_ex2_func             ),
  .viq0_xx_ex2_gp_sel            (viq0_xx_ex2_gp_sel           ),
  .viq0_xx_ex2_rm                (viq0_xx_ex2_rm               ),
  .viq0_xx_ex2_stall             (viq0_xx_ex2_stall            ),
  .viq0_xx_ex3_eu_sel            (viq0_xx_ex3_eu_sel           ),
  .viq0_xx_ex3_func              (viq0_xx_ex3_func             ),
  .viq0_xx_ex3_gp_sel            (viq0_xx_ex3_gp_sel           ),
  .viq0_xx_ex3_rm                (viq0_xx_ex3_rm               ),
  .viq0_xx_ex3_stall             (viq0_xx_ex3_stall            ),
  .viq0_xx_ex4_eu_sel            (viq0_xx_ex4_eu_sel           ),
  .viq0_xx_ex4_func              (viq0_xx_ex4_func             ),
  .viq0_xx_ex4_gp_sel            (viq0_xx_ex4_gp_sel           ),
  .viq0_xx_ex4_rm                (viq0_xx_ex4_rm               ),
  .viq0_xx_ex4_stall             (viq0_xx_ex4_stall            ),
  .vpu_group_x_xx_ex1_eu_sel     (vpu_group_1_xx_ex1_eu_sel    ),
  .vpu_group_x_xx_ex1_func       (vpu_group_1_xx_ex1_func      ),
  .vpu_group_x_xx_ex1_id_reg     (vpu_group_1_xx_ex1_id_reg    ),
  .vpu_group_x_xx_ex1_rm         (vpu_group_1_xx_ex1_rm        ),
  .vpu_group_x_xx_ex1_sel        (vpu_group_1_xx_ex1_sel       ),
  .vpu_group_x_xx_ex1_srcv0      (vpu_group_1_xx_ex1_srcv0     ),
  .vpu_group_x_xx_ex1_srcv0_type (vpu_group_1_xx_ex1_srcv0_type),
  .vpu_group_x_xx_ex1_srcv1      (vpu_group_1_xx_ex1_srcv1     ),
  .vpu_group_x_xx_ex1_srcv1_type (vpu_group_1_xx_ex1_srcv1_type),
  .vpu_group_x_xx_ex1_srcv2      (vpu_group_1_xx_ex1_srcv2     ),
  .vpu_group_x_xx_ex1_srcv2_type (vpu_group_1_xx_ex1_srcv2_type),
  .vpu_group_x_xx_ex2_eu_sel     (vpu_group_1_xx_ex2_eu_sel    ),
  .vpu_group_x_xx_ex2_func       (vpu_group_1_xx_ex2_func      ),
  .vpu_group_x_xx_ex2_rm         (vpu_group_1_xx_ex2_rm        ),
  .vpu_group_x_xx_ex2_sel        (vpu_group_1_xx_ex2_sel       ),
  .vpu_group_x_xx_ex2_stall      (vpu_group_1_xx_ex2_stall     ),
  .vpu_group_x_xx_ex3_eu_sel     (vpu_group_1_xx_ex3_eu_sel    ),
  .vpu_group_x_xx_ex3_func       (vpu_group_1_xx_ex3_func      ),
  .vpu_group_x_xx_ex3_rm         (vpu_group_1_xx_ex3_rm        ),
  .vpu_group_x_xx_ex3_sel        (vpu_group_1_xx_ex3_sel       ),
  .vpu_group_x_xx_ex3_stall      (vpu_group_1_xx_ex3_stall     ),
  .vpu_group_x_xx_ex4_eu_sel     (vpu_group_1_xx_ex4_eu_sel    ),
  .vpu_group_x_xx_ex4_func       (vpu_group_1_xx_ex4_func      ),
  .vpu_group_x_xx_ex4_rm         (vpu_group_1_xx_ex4_rm        ),
  .vpu_group_x_xx_ex4_sel        (vpu_group_1_xx_ex4_sel       ),
  .vpu_group_x_xx_ex4_stall      (vpu_group_1_xx_ex4_stall     )
);

// &Connect (.group_index (4'b0010)); @131

// &ConnRule(s/group_x_/group_2_/); @133
// &Instance("aq_vpu_group_unit", "x_aq_vpu_group_2"); @134
aq_vpu_group_unit  x_aq_vpu_group_2 (
  .group_index                   (4'b0100                      ),
  .viq0_xx_ex1_eu_sel            (viq0_xx_ex1_eu_sel           ),
  .viq0_xx_ex1_func              (viq0_xx_ex1_func             ),
  .viq0_xx_ex1_gp_sel            (viq0_xx_ex1_gp_sel           ),
  .viq0_xx_ex1_id_reg            (viq0_xx_ex1_id_reg           ),
  .viq0_xx_ex1_rm                (viq0_xx_ex1_rm               ),
  .viq0_xx_ex1_srcv0             (viq0_xx_ex1_srcv0            ),
  .viq0_xx_ex1_srcv0_type        (viq0_xx_ex1_srcv0_type       ),
  .viq0_xx_ex1_srcv1             (viq0_xx_ex1_srcv1            ),
  .viq0_xx_ex1_srcv1_type        (viq0_xx_ex1_srcv1_type       ),
  .viq0_xx_ex1_srcv2             (viq0_xx_ex1_srcv2            ),
  .viq0_xx_ex1_srcv2_type        (viq0_xx_ex1_srcv2_type       ),
  .viq0_xx_ex2_eu_sel            (viq0_xx_ex2_eu_sel           ),
  .viq0_xx_ex2_func              (viq0_xx_ex2_func             ),
  .viq0_xx_ex2_gp_sel            (viq0_xx_ex2_gp_sel           ),
  .viq0_xx_ex2_rm                (viq0_xx_ex2_rm               ),
  .viq0_xx_ex2_stall             (viq0_xx_ex2_stall            ),
  .viq0_xx_ex3_eu_sel            (viq0_xx_ex3_eu_sel           ),
  .viq0_xx_ex3_func              (viq0_xx_ex3_func             ),
  .viq0_xx_ex3_gp_sel            (viq0_xx_ex3_gp_sel           ),
  .viq0_xx_ex3_rm                (viq0_xx_ex3_rm               ),
  .viq0_xx_ex3_stall             (viq0_xx_ex3_stall            ),
  .viq0_xx_ex4_eu_sel            (viq0_xx_ex4_eu_sel           ),
  .viq0_xx_ex4_func              (viq0_xx_ex4_func             ),
  .viq0_xx_ex4_gp_sel            (viq0_xx_ex4_gp_sel           ),
  .viq0_xx_ex4_rm                (viq0_xx_ex4_rm               ),
  .viq0_xx_ex4_stall             (viq0_xx_ex4_stall            ),
  .vpu_group_x_xx_ex1_eu_sel     (vpu_group_2_xx_ex1_eu_sel    ),
  .vpu_group_x_xx_ex1_func       (vpu_group_2_xx_ex1_func      ),
  .vpu_group_x_xx_ex1_id_reg     (vpu_group_2_xx_ex1_id_reg    ),
  .vpu_group_x_xx_ex1_rm         (vpu_group_2_xx_ex1_rm        ),
  .vpu_group_x_xx_ex1_sel        (vpu_group_2_xx_ex1_sel       ),
  .vpu_group_x_xx_ex1_srcv0      (vpu_group_2_xx_ex1_srcv0     ),
  .vpu_group_x_xx_ex1_srcv0_type (vpu_group_2_xx_ex1_srcv0_type),
  .vpu_group_x_xx_ex1_srcv1      (vpu_group_2_xx_ex1_srcv1     ),
  .vpu_group_x_xx_ex1_srcv1_type (vpu_group_2_xx_ex1_srcv1_type),
  .vpu_group_x_xx_ex1_srcv2      (vpu_group_2_xx_ex1_srcv2     ),
  .vpu_group_x_xx_ex1_srcv2_type (vpu_group_2_xx_ex1_srcv2_type),
  .vpu_group_x_xx_ex2_eu_sel     (vpu_group_2_xx_ex2_eu_sel    ),
  .vpu_group_x_xx_ex2_func       (vpu_group_2_xx_ex2_func      ),
  .vpu_group_x_xx_ex2_rm         (vpu_group_2_xx_ex2_rm        ),
  .vpu_group_x_xx_ex2_sel        (vpu_group_2_xx_ex2_sel       ),
  .vpu_group_x_xx_ex2_stall      (vpu_group_2_xx_ex2_stall     ),
  .vpu_group_x_xx_ex3_eu_sel     (vpu_group_2_xx_ex3_eu_sel    ),
  .vpu_group_x_xx_ex3_func       (vpu_group_2_xx_ex3_func      ),
  .vpu_group_x_xx_ex3_rm         (vpu_group_2_xx_ex3_rm        ),
  .vpu_group_x_xx_ex3_sel        (vpu_group_2_xx_ex3_sel       ),
  .vpu_group_x_xx_ex3_stall      (vpu_group_2_xx_ex3_stall     ),
  .vpu_group_x_xx_ex4_eu_sel     (vpu_group_2_xx_ex4_eu_sel    ),
  .vpu_group_x_xx_ex4_func       (vpu_group_2_xx_ex4_func      ),
  .vpu_group_x_xx_ex4_rm         (vpu_group_2_xx_ex4_rm        ),
  .vpu_group_x_xx_ex4_sel        (vpu_group_2_xx_ex4_sel       ),
  .vpu_group_x_xx_ex4_stall      (vpu_group_2_xx_ex4_stall     )
);

// &Connect (.group_index (4'b0100)); @135

// &ConnRule(s/group_x_/group_3_/); @137
// &Instance("aq_vpu_group_unit", "x_aq_vpu_group_3"); @138
aq_vpu_group_unit  x_aq_vpu_group_3 (
  .group_index                   (4'b1000                      ),
  .viq0_xx_ex1_eu_sel            (viq0_xx_ex1_eu_sel           ),
  .viq0_xx_ex1_func              (viq0_xx_ex1_func             ),
  .viq0_xx_ex1_gp_sel            (viq0_xx_ex1_gp_sel           ),
  .viq0_xx_ex1_id_reg            (viq0_xx_ex1_id_reg           ),
  .viq0_xx_ex1_rm                (viq0_xx_ex1_rm               ),
  .viq0_xx_ex1_srcv0             (viq0_xx_ex1_srcv0            ),
  .viq0_xx_ex1_srcv0_type        (viq0_xx_ex1_srcv0_type       ),
  .viq0_xx_ex1_srcv1             (viq0_xx_ex1_srcv1            ),
  .viq0_xx_ex1_srcv1_type        (viq0_xx_ex1_srcv1_type       ),
  .viq0_xx_ex1_srcv2             (viq0_xx_ex1_srcv2            ),
  .viq0_xx_ex1_srcv2_type        (viq0_xx_ex1_srcv2_type       ),
  .viq0_xx_ex2_eu_sel            (viq0_xx_ex2_eu_sel           ),
  .viq0_xx_ex2_func              (viq0_xx_ex2_func             ),
  .viq0_xx_ex2_gp_sel            (viq0_xx_ex2_gp_sel           ),
  .viq0_xx_ex2_rm                (viq0_xx_ex2_rm               ),
  .viq0_xx_ex2_stall             (viq0_xx_ex2_stall            ),
  .viq0_xx_ex3_eu_sel            (viq0_xx_ex3_eu_sel           ),
  .viq0_xx_ex3_func              (viq0_xx_ex3_func             ),
  .viq0_xx_ex3_gp_sel            (viq0_xx_ex3_gp_sel           ),
  .viq0_xx_ex3_rm                (viq0_xx_ex3_rm               ),
  .viq0_xx_ex3_stall             (viq0_xx_ex3_stall            ),
  .viq0_xx_ex4_eu_sel            (viq0_xx_ex4_eu_sel           ),
  .viq0_xx_ex4_func              (viq0_xx_ex4_func             ),
  .viq0_xx_ex4_gp_sel            (viq0_xx_ex4_gp_sel           ),
  .viq0_xx_ex4_rm                (viq0_xx_ex4_rm               ),
  .viq0_xx_ex4_stall             (viq0_xx_ex4_stall            ),
  .vpu_group_x_xx_ex1_eu_sel     (vpu_group_3_xx_ex1_eu_sel    ),
  .vpu_group_x_xx_ex1_func       (vpu_group_3_xx_ex1_func      ),
  .vpu_group_x_xx_ex1_id_reg     (vpu_group_3_xx_ex1_id_reg    ),
  .vpu_group_x_xx_ex1_rm         (vpu_group_3_xx_ex1_rm        ),
  .vpu_group_x_xx_ex1_sel        (vpu_group_3_xx_ex1_sel       ),
  .vpu_group_x_xx_ex1_srcv0      (vpu_group_3_xx_ex1_srcv0     ),
  .vpu_group_x_xx_ex1_srcv0_type (vpu_group_3_xx_ex1_srcv0_type),
  .vpu_group_x_xx_ex1_srcv1      (vpu_group_3_xx_ex1_srcv1     ),
  .vpu_group_x_xx_ex1_srcv1_type (vpu_group_3_xx_ex1_srcv1_type),
  .vpu_group_x_xx_ex1_srcv2      (vpu_group_3_xx_ex1_srcv2     ),
  .vpu_group_x_xx_ex1_srcv2_type (vpu_group_3_xx_ex1_srcv2_type),
  .vpu_group_x_xx_ex2_eu_sel     (vpu_group_3_xx_ex2_eu_sel    ),
  .vpu_group_x_xx_ex2_func       (vpu_group_3_xx_ex2_func      ),
  .vpu_group_x_xx_ex2_rm         (vpu_group_3_xx_ex2_rm        ),
  .vpu_group_x_xx_ex2_sel        (vpu_group_3_xx_ex2_sel       ),
  .vpu_group_x_xx_ex2_stall      (vpu_group_3_xx_ex2_stall     ),
  .vpu_group_x_xx_ex3_eu_sel     (vpu_group_3_xx_ex3_eu_sel    ),
  .vpu_group_x_xx_ex3_func       (vpu_group_3_xx_ex3_func      ),
  .vpu_group_x_xx_ex3_rm         (vpu_group_3_xx_ex3_rm        ),
  .vpu_group_x_xx_ex3_sel        (vpu_group_3_xx_ex3_sel       ),
  .vpu_group_x_xx_ex3_stall      (vpu_group_3_xx_ex3_stall     ),
  .vpu_group_x_xx_ex4_eu_sel     (vpu_group_3_xx_ex4_eu_sel    ),
  .vpu_group_x_xx_ex4_func       (vpu_group_3_xx_ex4_func      ),
  .vpu_group_x_xx_ex4_rm         (vpu_group_3_xx_ex4_rm        ),
  .vpu_group_x_xx_ex4_sel        (vpu_group_3_xx_ex4_sel       ),
  .vpu_group_x_xx_ex4_stall      (vpu_group_3_xx_ex4_stall     )
);

// &Connect (.group_index (4'b1000)); @139

// &Force("nonport","viq1_rbus_ex5_fflags_vld"); @142
// &Force("nonport","viq1_rbus_ex5_fflags"); @143
// &Force("nonport","viq1_rbus_ex5_fpr_wb_req"); @145
// &Force("nonport","viq1_rbus_ex4_fpr_wb_req"); @146
// &Force("nonport","viq1_rbus_ex5_fpr_wb_data"); @147
// &Force("nonport","viq1_rbus_ex4_fpr_wb_data"); @148
// &Force("nonport","viq1_rbus_ex5_fpr_wb_index"); @149
// &Force("nonport","viq1_rbus_ex4_fpr_wb_index"); @150
// &Force("nonport","viq1_xx_ex5_stall"); @154
// &Force("nonport","viq1_xx_ex5_vld"); @156

// &Force("nonport","vpu_group_0_xx_ex1_imm"); @160
// &Force("nonport","vpu_group_0_xx_ex2_imm"); @161
// &Force("nonport","vpu_group_0_xx_ex1_imm_vld"); @162
// &Force("nonport","vpu_group_0_xx_ex2_imm_vld"); @163
// &Force("nonport","vpu_group_0_xx_ex1_lmul"); @164
// &Force("nonport","vpu_group_0_xx_ex2_lmul"); @165
// &Force("nonport","vpu_group_0_xx_ex3_lmul"); @166
// &Force("nonport","vpu_group_0_xx_ex4_lmul"); @167
// &Force("nonport","vpu_group_0_xx_ex1_srcvm"); @168
// &Force("nonport","vpu_group_0_xx_ex1_vl"); @169
// &Force("nonport","vpu_group_0_xx_ex1_byte_mask"); @170
// &Force("nonport","vpu_group_0_xx_ex1_vl_byte_mask"); @171
// &Force("nonport","vpu_group_0_xx_ex4_vl_byte_mask"); @172
// &Force("nonport","vpu_group_0_xx_ex1_vm_byte_mask"); @173
// &Force("nonport","vpu_group_0_xx_ex4_vm_byte_mask"); @174
// &Force("nonport","vpu_group_0_xx_ex3_split_count"); @175
// &Force("nonport","vpu_group_0_xx_ex4_split_count"); @176
// &Force("nonport","vpu_group_0_xx_ex3_sew"); @177
// &Force("nonport","vpu_group_0_xx_ex4_sew"); @178
// &Force("nonport","vpu_group_0_xx_ex4_srcv2"); @179
// &Force("nonport","vpu_group_0_xx_ex3_srcv2"); @181
// &Force("nonport","vpu_group_0_xx_ex2_rm"); @184
// &Force("nonport","vpu_group_0_xx_ex2_func"); @185
// &Force("nonport","vpu_group_0_xx_ex5_sel"); @187
// &Force("nonport","vpu_group_0_xx_ex3_func"); @188
// &Force("nonport","vpu_group_0_xx_ex4_func"); @189
// &Force("nonport","vpu_group_0_xx_ex3_rm"); @190
// &Force("nonport","vpu_group_0_xx_ex4_rm"); @191
//
// &Force("nonport","vpu_group_1_xx_ex1_imm"); @194
// &Force("nonport","vpu_group_1_xx_ex2_imm"); @195
// &Force("nonport","vpu_group_1_xx_ex1_imm_vld"); @196
// &Force("nonport","vpu_group_1_xx_ex2_imm_vld"); @197
// &Force("nonport","vpu_group_1_xx_ex1_lmul"); @198
// //&Force("nonport","vpu_group_1_xx_ex3_lmul"); @199
// &Force("nonport","vpu_group_1_xx_ex4_lmul"); @200
// &Force("nonport","vpu_group_1_xx_ex1_srcvm"); @201
// &Force("nonport","vpu_group_1_xx_ex1_vl"); @202
// &Force("nonport","vpu_group_1_xx_ex4_sew"); @203
// &Force("nonport","vpu_group_1_xx_ex4_split_count"); @204
// &Force("nonport","vpu_group_1_xx_ex4_vl_byte_mask"); @205
// &Force("nonport","vpu_group_1_xx_ex4_vm_byte_mask"); @206
// &Force("nonport","vpu_group_1_xx_ex4_srcv2"); @207
// &Force("nonport","vpu_group_1_xx_ex2_func"); @209
// &Force("nonport","vpu_group_1_xx_ex3_func"); @210

// &Force("nonport","vpu_group_1_xx_ex1_id_reg"); @213
// &Force("nonport","vpu_group_1_xx_ex1_srcv2"); @214
// &Force("nonport","vpu_group_1_xx_ex1_srcv2_type"); @215
// &Force("nonport","vpu_group_1_xx_ex3_sel"); @216
// &Force("nonport","vpu_group_1_xx_ex3_rm"); @217
// &Force("nonport","vpu_group_1_xx_ex4_sel"); @218
// &Force("nonport","vpu_group_1_xx_ex4_eu_sel"); @219
// &Force("nonport","vpu_group_1_xx_ex4_rm"); @220
// &Force("nonport","vpu_group_1_xx_ex4_func"); @221

// &Force("nonport","vpu_group_2_xx_ex1_byte_mask"); @224
// &Force("nonport","vpu_group_2_xx_ex3_vl_byte_mask"); @225
// &Force("nonport","vpu_group_2_xx_ex4_vl_byte_mask"); @226
// &Force("nonport","vpu_group_2_xx_ex3_vm_byte_mask"); @227
// &Force("nonport","vpu_group_2_xx_ex4_vm_byte_mask"); @228
// &Force("nonport","vpu_group_2_xx_ex2_imm"); @229
// &Force("nonport","vpu_group_2_xx_ex2_imm_vld"); @230
// &Force("nonport","vpu_group_2_xx_ex3_lmul"); @231
// &Force("nonport","vpu_group_2_xx_ex4_lmul"); @232
// &Force("nonport","vpu_group_2_xx_ex3_sew"); @233
// &Force("nonport","vpu_group_2_xx_ex4_sew"); @234
// &Force("nonport","vpu_group_2_xx_ex3_split_count"); @235
// &Force("nonport","vpu_group_2_xx_ex4_split_count"); @236
// &Force("nonport","vpu_group_2_xx_ex2_srcv2"); @237
// &Force("nonport","vpu_group_2_xx_ex3_srcv2"); @238
// &Force("nonport","vpu_group_2_xx_ex4_srcv2"); @239
// &Force("nonport","vpu_group_2_xx_ex1_srcv2"); @241
// &Force("nonport","vpu_group_2_xx_ex2_func"); @242

// &Force("nonport","vpu_group_2_xx_ex1_id_reg"); @245
// &Force("nonport","vpu_group_2_xx_ex1_rm"); @246
// &Force("nonport","vpu_group_2_xx_ex1_srcv2_type"); @247
// &Force("nonport","vpu_group_2_xx_ex3_eu_sel"); @248
// &Force("nonport","vpu_group_2_xx_ex4_eu_sel"); @249
// &Force("nonport","vpu_group_2_xx_ex3_rm"); @250
// &Force("nonport","vpu_group_2_xx_ex4_rm"); @251
// &Force("nonport","vpu_group_2_xx_ex3_sel"); @252
// &Force("nonport","vpu_group_2_xx_ex4_sel"); @253
// &Force("nonport","vpu_group_2_xx_ex3_func"); @254
// &Force("nonport","vpu_group_2_xx_ex4_func"); @255
// &Force("nonport","vpu_group_2_xx_ex4_stall"); @256

// &Force("nonport","vpu_group_3_xx_ex1_imm"); @259
// &Force("nonport","vpu_group_3_xx_ex2_imm"); @260
// &Force("nonport","vpu_group_3_xx_ex1_imm_vld"); @261
// &Force("nonport","vpu_group_3_xx_ex2_imm_vld"); @262
// &Force("nonport","vpu_group_3_xx_ex1_lmul"); @263
// &Force("nonport","vpu_group_3_xx_ex2_lmul"); @264
// &Force("nonport","vpu_group_3_xx_ex3_lmul"); @265
// &Force("nonport","vpu_group_3_xx_ex4_lmul"); @266
// &Force("nonport","vpu_group_3_xx_ex1_split_count"); @267
// &Force("nonport","vpu_group_3_xx_ex2_split_count"); @268
// &Force("nonport","vpu_group_3_xx_ex4_split_count"); @269
// &Force("nonport","vpu_group_3_xx_ex3_split_count"); @270
// &Force("nonport","vpu_group_3_xx_ex1_srcvm"); @271
// &Force("nonport","vpu_group_3_xx_ex2_sew"); @272
// &Force("nonport","vpu_group_3_xx_ex3_sew"); @273
// &Force("nonport","vpu_group_3_xx_ex4_sew"); @274
// &Force("nonport","vpu_group_3_xx_ex1_vl"); @275
// &Force("nonport","vpu_group_3_xx_ex1_vl_index"); @276
// &Force("nonport","vpu_group_3_xx_ex1_byte_mask"); @277
// &Force("nonport","vpu_group_3_xx_ex2_vl_byte_mask"); @278
// &Force("nonport","vpu_group_3_xx_ex3_vl_byte_mask"); @279
// &Force("nonport","vpu_group_3_xx_ex4_vl_byte_mask"); @280
// &Force("nonport","vpu_group_3_xx_ex2_vm_byte_mask"); @281
// &Force("nonport","vpu_group_3_xx_ex3_vm_byte_mask"); @282
// &Force("nonport","vpu_group_3_xx_ex4_vm_byte_mask"); @283
// &Force("nonport","vpu_group_3_xx_ex3_srcv2"); @284
// &Force("nonport","vpu_group_3_xx_ex4_srcv2"); @285

// &Force("nonport","vpu_group_3_xx_ex1_id_reg"); @288
// &Force("nonport","vpu_group_3_xx_ex1_srcv2_type"); @289
// &Force("nonport","vpu_group_3_xx_ex2_rm"); @290
// &Force("nonport","vpu_group_3_xx_ex3_rm"); @291
// &Force("nonport","vpu_group_3_xx_ex4_rm"); @292
// &Force("nonport","vpu_group_3_xx_ex2_sel"); @293
// &Force("nonport","vpu_group_3_xx_ex3_sel"); @294
// &Force("nonport","vpu_group_3_xx_ex4_sel"); @295
// &Force("nonport","vpu_group_3_xx_ex2_eu_sel"); @296
// &Force("nonport","vpu_group_3_xx_ex3_eu_sel"); @297
// &Force("nonport","vpu_group_3_xx_ex4_eu_sel"); @298
// &Force("nonport","vpu_group_3_xx_ex2_func"); @299
// &Force("nonport","vpu_group_3_xx_ex3_func"); @300
// &Force("nonport","vpu_group_3_xx_ex4_func"); @301
// &Force("nonport","vpu_group_3_xx_ex2_srcv2"); @302
// &Force("nonport","vpu_group_3_xx_ex2_stall"); @303
// &Force("nonport","vpu_group_3_xx_ex3_stall"); @304
// &Force("nonport","vpu_group_3_xx_ex4_stall"); @305

// &Force("input","rtu_vpu_gpr_wb_grnt"); @320
// &Force("input","ifu_vpu_warm_up"); @321
// &Force("nonport","viq0_ex1_inst_vld"); @330
// &Force("nonport","viq0_ex2_inst_vld"); @331
// &Force("nonport","viq0_ex3_inst_vld"); @332
// &Force("nonport","viq0_ex4_inst_vld"); @333
// &Force("nonport","viq0_ex1_gp_sel"); @334
// &Force("nonport","viq0_ex2_gp_sel"); @335
// &Force("nonport","viq0_ex3_gp_sel"); @336
// &Force("nonport","viq0_ex4_gp_sel"); @337
// &Force("nonport","viq1_ex1_inst_vld"); @338
// &Force("nonport","viq1_ex2_inst_vld"); @339
// &Force("nonport","viq1_ex3_inst_vld"); @340
// &Force("nonport","viq1_ex4_inst_vld"); @341
// &Force("nonport","viq1_ex1_gp_sel"); @342
// &Force("nonport","viq1_ex2_gp_sel"); @343
// &Force("nonport","viq1_ex3_gp_sel"); @344
// &Force("nonport","viq1_ex4_gp_sel"); @345
// &Force("nonport","vec0_vint_inst"); @437
// &Force("nonport","vec1_vint_inst"); @438

// &ModuleEnd; @704
endmodule


