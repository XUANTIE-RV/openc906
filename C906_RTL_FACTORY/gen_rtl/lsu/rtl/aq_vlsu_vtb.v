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

// &Depend("cpu_cfig.h"); @18

// &ModuleBeg; @20
module aq_vlsu_vtb(
  cp0_vpu_icg_en,
  cpurst_b,
  forever_cpuclk,
  if_vlsu_fls_data,
  if_vlsu_fls_reg,
  if_vlsu_fls_wb_vld,
  if_vlsu_fwd_done,
  if_vlsu_merge_data,
  if_vlsu_merge_vld,
  if_vlsu_sel0,
  if_vlsu_sel1,
  if_vlsu_sel2,
  if_vlsu_sel3,
  if_vlsu_vl_update,
  if_vlsu_vl_upval,
  if_vlsu_vls_wb_abnormal,
  if_vlsu_vls_wb_bytes_vld,
  if_vlsu_vls_wb_data,
  if_vlsu_vls_wb_vld,
  index_stall,
  lsu_vlsu_dc_fld_req,
  lsu_vlsu_dc_stall,
  pad_yy_icg_scan_en,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_flush,
  sseg_abnormal_vld,
  sseg_fwd_last,
  sseg_fwd_vld,
  sseg_nf,
  sseg_split_pause,
  sseg_vld,
  sseg_vtb_all_vld,
  sseg_vtb_all_wb,
  sseg_vtb_fwd_pre,
  sseg_vtb_fwd_start,
  sseg_vtb_next_ready,
  sseg_wb_vld,
  vlsu_fld_stall,
  vlsu_if_fof_vld,
  vlsu_if_fwd_vld,
  vlsu_if_nf,
  vlsu_if_reg_data,
  vlsu_if_reg_fls,
  vlsu_if_reg_seq_last,
  vlsu_if_reg_src2_reg,
  vlsu_if_reg_wdata_ready,
  vlsu_if_sew,
  vlsu_if_split_cnt0,
  vlsu_if_split_cnt0_vld,
  vlsu_if_split_cnt1,
  vlsu_if_split_cnt1_vld,
  vlsu_if_sseg_reg_data,
  vlsu_if_vtb_round_bit,
  vlsu_index_stall,
  vlsu_index_up_mask,
  vlsu_rbus_fpr_wb_data,
  vlsu_rbus_fpr_wb_index,
  vlsu_rbus_fpr_wb_req,
  vlsu_rbus_vpr_wb_data,
  vlsu_rbus_vpr_wb_index,
  vlsu_rbus_vpr_wb_req,
  vlsu_rtu_vl_updt_data,
  vlsu_rtu_vl_updt_vld,
  vlsu_vex1_split_stall,
  vlsu_vidu_split_cancel,
  vlsu_vidu_split_pause,
  vlsu_warm_up,
  vlsu_xx_ex1_fp_stall,
  vlsu_xx_no_op,
  vpu_group_3_xx_ex1_func,
  vpu_group_3_xx_ex1_imm,
  vpu_group_3_xx_ex1_lmul,
  vpu_group_3_xx_ex1_sel,
  vpu_group_3_xx_ex1_sew,
  vpu_group_3_xx_ex1_split_count,
  vpu_group_3_xx_ex1_srcv1,
  vpu_group_3_xx_ex1_srcv2,
  vpu_group_3_xx_ex1_srcv2_ready,
  vpu_group_3_xx_ex1_vl,
  vpu_group_3_xx_ex1_vl_byte_mask,
  vpu_group_3_xx_ex1_vm_byte_mask,
  vpu_group_3_xx_ex1_vm_high,
  vpu_group_3_xx_ex1_vreg,
  vpu_group_3_xx_ex1_vstart,
  vpu_vlsu_ex1_lsu_inst_vld,
  vpu_vlsu_fp_wb_data,
  vpu_vlsu_fp_wb_reg,
  vpu_vlsu_fp_wb_vld
);

// &Ports; @21
input           cp0_vpu_icg_en;                 
input           cpurst_b;                       
input           forever_cpuclk;                 
input   [63:0]  if_vlsu_fls_data;               
input   [4 :0]  if_vlsu_fls_reg;                
input           if_vlsu_fls_wb_vld;             
input           if_vlsu_fwd_done;               
input   [63:0]  if_vlsu_merge_data;             
input           if_vlsu_merge_vld;              
input   [3 :0]  if_vlsu_sel0;                   
input   [3 :0]  if_vlsu_sel1;                   
input   [3 :0]  if_vlsu_sel2;                   
input   [3 :0]  if_vlsu_sel3;                   
input           if_vlsu_vl_update;              
input   [6 :0]  if_vlsu_vl_upval;               
input           if_vlsu_vls_wb_abnormal;        
input   [7 :0]  if_vlsu_vls_wb_bytes_vld;       
input   [63:0]  if_vlsu_vls_wb_data;            
input           if_vlsu_vls_wb_vld;             
input           index_stall;                    
input           lsu_vlsu_dc_fld_req;            
input           lsu_vlsu_dc_stall;              
input           pad_yy_icg_scan_en;             
input           rtu_yy_xx_async_flush;          
input           rtu_yy_xx_flush;                
input           sseg_abnormal_vld;              
input           sseg_fwd_last;                  
input           sseg_fwd_vld;                   
input   [2 :0]  sseg_nf;                        
input           sseg_split_pause;               
input           sseg_vld;                       
input           sseg_wb_vld;                    
input           vlsu_warm_up;                   
input   [19:0]  vpu_group_3_xx_ex1_func;        
input   [4 :0]  vpu_group_3_xx_ex1_imm;         
input   [1 :0]  vpu_group_3_xx_ex1_lmul;        
input           vpu_group_3_xx_ex1_sel;         
input   [1 :0]  vpu_group_3_xx_ex1_sew;         
input   [7 :0]  vpu_group_3_xx_ex1_split_count; 
input   [63:0]  vpu_group_3_xx_ex1_srcv1;       
input   [63:0]  vpu_group_3_xx_ex1_srcv2;       
input           vpu_group_3_xx_ex1_srcv2_ready; 
input   [7 :0]  vpu_group_3_xx_ex1_vl;          
input   [7 :0]  vpu_group_3_xx_ex1_vl_byte_mask; 
input   [7 :0]  vpu_group_3_xx_ex1_vm_byte_mask; 
input           vpu_group_3_xx_ex1_vm_high;     
input   [6 :0]  vpu_group_3_xx_ex1_vreg;        
input   [6 :0]  vpu_group_3_xx_ex1_vstart;      
input           vpu_vlsu_ex1_lsu_inst_vld;      
input   [63:0]  vpu_vlsu_fp_wb_data;            
input   [4 :0]  vpu_vlsu_fp_wb_reg;             
input           vpu_vlsu_fp_wb_vld;             
output          sseg_vtb_all_vld;               
output          sseg_vtb_all_wb;                
output          sseg_vtb_fwd_pre;               
output          sseg_vtb_fwd_start;             
output          sseg_vtb_next_ready;            
output          vlsu_fld_stall;                 
output          vlsu_if_fof_vld;                
output          vlsu_if_fwd_vld;                
output  [2 :0]  vlsu_if_nf;                     
output  [63:0]  vlsu_if_reg_data;               
output          vlsu_if_reg_fls;                
output          vlsu_if_reg_seq_last;           
output  [4 :0]  vlsu_if_reg_src2_reg;           
output          vlsu_if_reg_wdata_ready;        
output  [1 :0]  vlsu_if_sew;                    
output  [9 :0]  vlsu_if_split_cnt0;             
output          vlsu_if_split_cnt0_vld;         
output  [9 :0]  vlsu_if_split_cnt1;             
output          vlsu_if_split_cnt1_vld;         
output  [63:0]  vlsu_if_sseg_reg_data;          
output  [1 :0]  vlsu_if_vtb_round_bit;          
output          vlsu_index_stall;               
output          vlsu_index_up_mask;             
output  [63:0]  vlsu_rbus_fpr_wb_data;          
output  [4 :0]  vlsu_rbus_fpr_wb_index;         
output          vlsu_rbus_fpr_wb_req;           
output  [63:0]  vlsu_rbus_vpr_wb_data;          
output  [6 :0]  vlsu_rbus_vpr_wb_index;         
output          vlsu_rbus_vpr_wb_req;           
output  [7 :0]  vlsu_rtu_vl_updt_data;          
output          vlsu_rtu_vl_updt_vld;           
output          vlsu_vex1_split_stall;          
output          vlsu_vidu_split_cancel;         
output          vlsu_vidu_split_pause;          
output          vlsu_xx_ex1_fp_stall;           
output          vlsu_xx_no_op;                  

// &Regs; @22
reg     [7 :0]  active_bytes_with_vstart;       
reg     [7 :0]  active_with_vstart;             
reg             fld_next_wait_ff;               
reg             fld_wait_ff;                    
reg             last_reg_cnt;                   
reg             pop_ptr;                        
reg     [7 :0]  reg_cnt_mask;                   
reg     [7 :0]  reg_cnt_mask_ori;               
reg             split_last_reg;                 
reg     [3 :0]  sseg_create0_sel;               
reg     [63:0]  sseg_fwd_data;                  
reg     [3 :0]  sseg_wb_sel;                    
reg     [7 :0]  vm_byte_mask_ff;                
reg             vm_ff_vld;                      
reg             vm_high_ff;                     
reg     [8 :0]  vstart_byte_count;              
reg     [63:0]  wb_data;                        
reg     [7 :0]  wb_vl_mask;                     
reg     [7 :0]  wb_vm_mask;                     
reg     [6 :0]  wb_vreg;                        

// &Wires; @23
wire            all_active_for_vstart;          
wire            all_inactive_for_vstart;        
wire            cp0_vpu_icg_en;                 
wire            cpurst_b;                       
wire            create_vld;                     
wire            crt_ptr;                        
wire    [7 :0]  element_cnt;                    
wire            entry0_fwd_sel;                 
wire            entry1_fwd_sel;                 
wire            entry1_wb_sel;                  
wire            fld_wait_clear;                 
wire            forever_cpuclk;                 
wire            fst_create_bypass;              
wire            fst_create_prior;               
wire    [63:0]  fwd_data;                       
wire            fwd_fls;                        
wire            fwd_pop;                        
wire    [3 :0]  fwd_pop_sel;                    
wire            fwd_req;                        
wire    [3 :0]  fwd_sel;                        
wire            fwd_seq_last;                   
wire    [3 :0]  fwd_vld;                        
wire            fwd_wdata_ready;                
wire    [4 :0]  fwd_wdata_src2_reg;             
wire    [63:0]  if_vlsu_fls_data;               
wire    [63:0]  if_vlsu_fls_data_ext;           
wire    [4 :0]  if_vlsu_fls_reg;                
wire            if_vlsu_fls_wb_vld;             
wire            if_vlsu_fwd_done;               
wire    [63:0]  if_vlsu_merge_data;             
wire            if_vlsu_merge_vld;              
wire    [3 :0]  if_vlsu_sel0;                   
wire    [3 :0]  if_vlsu_sel1;                   
wire    [3 :0]  if_vlsu_sel2;                   
wire    [3 :0]  if_vlsu_sel3;                   
wire            if_vlsu_vl_update;              
wire    [6 :0]  if_vlsu_vl_upval;               
wire            if_vlsu_vls_wb_abnormal;        
wire    [7 :0]  if_vlsu_vls_wb_bytes_vld;       
wire    [63:0]  if_vlsu_vls_wb_data;            
wire            if_vlsu_vls_wb_vld;             
wire            index_stall;                    
wire            lsu_dc_stall;                   
wire            lsu_fld_req;                    
wire            lsu_fwd_done;                   
wire    [63:0]  lsu_merge_data;                 
wire            lsu_merge_vld;                  
wire    [3 :0]  lsu_sel0;                       
wire    [3 :0]  lsu_sel1;                       
wire    [3 :0]  lsu_sel2;                       
wire    [3 :0]  lsu_sel3;                       
wire            lsu_vlsu_dc_fld_req;            
wire            lsu_vlsu_dc_stall;              
wire            lsu_vtb_quick_pop;              
wire            lsu_wb_abnormal;                
wire    [7 :0]  lsu_wb_bytes_vld;               
wire    [63:0]  lsu_wb_data;                    
wire            lsu_wb_vld;                     
wire    [3 :0]  lsu_wen0;                       
wire    [3 :0]  lsu_wen1;                       
wire    [3 :0]  lsu_wen2;                       
wire    [3 :0]  lsu_wen3;                       
wire    [63:0]  lsu_wen_data_entry_0;           
wire    [63:0]  lsu_wen_data_entry_1;           
wire    [63:0]  lsu_wen_data_entry_2;           
wire    [63:0]  lsu_wen_data_entry_3;           
wire    [3 :0]  lsu_wen_entry_0;                
wire    [3 :0]  lsu_wen_entry_1;                
wire    [3 :0]  lsu_wen_entry_2;                
wire    [3 :0]  lsu_wen_entry_3;                
wire            pad_yy_icg_scan_en;             
wire            pop_empty_vld;                  
wire            pop_vld;                        
wire    [7 :0]  reg_cnt_mask_vld;               
wire    [1 :0]  round_bit;                      
wire            rtu_yy_xx_async_flush;          
wire            rtu_yy_xx_flush;                
wire    [9 :0]  split_cnt0;                     
wire            split_cnt0_vld;                 
wire    [9 :0]  split_cnt1;                     
wire            split_cnt1_vld;                 
wire    [7 :0]  split_cnt_next;                 
wire    [4 :0]  split_cnt_next_high;            
wire            sseg_abnormal_vld;              
wire    [3 :0]  sseg_create1_sel;               
wire    [3 :0]  sseg_create_sel;                
wire            sseg_create_stall;              
wire            sseg_fwd_last;                  
wire            sseg_fwd_vld;                   
wire    [2 :0]  sseg_nf;                        
wire            sseg_split_pause;               
wire            sseg_vld;                       
wire            sseg_vtb_all_vld;               
wire            sseg_vtb_all_wb;                
wire            sseg_vtb_fwd_pre;               
wire            sseg_vtb_fwd_start;             
wire            sseg_vtb_last;                  
wire            sseg_vtb_next_ready;            
wire            sseg_vtb_ready;                 
wire            sseg_wb_vld;                    
wire            vfst_create_bypass;             
wire            vfst_create_bypass_success;     
wire    [7 :0]  vl;                             
wire            vl_index_0_vld;                 
wire            vlsu_amo_create1;               
wire            vlsu_create_amo;                
wire    [63:0]  vlsu_create_data0;              
wire    [63:0]  vlsu_create_data0_ori;          
wire    [63:0]  vlsu_create_data1;              
wire    [63:0]  vlsu_create_data1_ori;          
wire    [63:0]  vlsu_create_data_0;             
wire    [63:0]  vlsu_create_data_1;             
wire    [63:0]  vlsu_create_data_2;             
wire    [63:0]  vlsu_create_data_3;             
wire    [7 :0]  vlsu_create_ele_cnt;            
wire            vlsu_create_fld_req;            
wire            vlsu_create_fls;                
wire            vlsu_create_fof_vld;            
wire            vlsu_create_fst_vld;            
wire            vlsu_create_fwd_lsu;            
wire            vlsu_create_fwd_vld;            
wire            vlsu_create_gate;               
wire    [1 :0]  vlsu_create_lmul;               
wire    [7 :0]  vlsu_create_mask;               
wire    [63:0]  vlsu_create_mask_ext;           
wire    [2 :0]  vlsu_create_nf;                 
wire    [2 :0]  vlsu_create_nf_cnt;             
wire            vlsu_create_no_wd;              
wire    [3 :0]  vlsu_create_reg_cnt;            
wire            vlsu_create_req;                
wire    [3 :0]  vlsu_create_sel;                
wire            vlsu_create_seq_last;           
wire    [1 :0]  vlsu_create_sew;                
wire    [7 :0]  vlsu_create_split_cnt;          
wire            vlsu_create_split_cnt_vld;      
wire            vlsu_create_split_last;         
wire            vlsu_create_st;                 
wire    [3 :0]  vlsu_create_st_type;            
wire    [7 :0]  vlsu_create_vl_mask;            
wire    [3 :0]  vlsu_create_vld;                
wire    [7 :0]  vlsu_create_vmask;              
wire    [6 :0]  vlsu_create_vreg;               
wire            vlsu_create_wdata_ready;        
wire            vlsu_create_wready;             
wire            vlsu_fld_stall;                 
wire    [63:0]  vlsu_fwd_data;                  
wire            vlsu_if_fof_vld;                
wire            vlsu_if_fwd_vld;                
wire    [2 :0]  vlsu_if_nf;                     
wire    [63:0]  vlsu_if_reg_data;               
wire            vlsu_if_reg_fls;                
wire            vlsu_if_reg_seq_last;           
wire    [4 :0]  vlsu_if_reg_src2_reg;           
wire            vlsu_if_reg_wdata_ready;        
wire    [1 :0]  vlsu_if_sew;                    
wire    [9 :0]  vlsu_if_split_cnt0;             
wire            vlsu_if_split_cnt0_vld;         
wire    [9 :0]  vlsu_if_split_cnt1;             
wire            vlsu_if_split_cnt1_vld;         
wire    [63:0]  vlsu_if_sseg_reg_data;          
wire    [1 :0]  vlsu_if_vtb_round_bit;          
wire            vlsu_index_stall;               
wire            vlsu_index_up_mask;             
wire    [63:0]  vlsu_rbus_fpr_wb_data;          
wire    [4 :0]  vlsu_rbus_fpr_wb_index;         
wire            vlsu_rbus_fpr_wb_req;           
wire    [63:0]  vlsu_rbus_vpr_wb_data;          
wire    [6 :0]  vlsu_rbus_vpr_wb_index;         
wire            vlsu_rbus_vpr_wb_req;           
wire    [7 :0]  vlsu_rtu_vl_updt_data;          
wire            vlsu_rtu_vl_updt_vld;           
wire            vlsu_sseg_create;               
wire            vlsu_sseg_vm_clr;               
wire            vlsu_sseg_vm_create;            
wire            vlsu_sseg_vm_ff_vld;            
wire            vlsu_stall;                     
wire            vlsu_vex1_split_stall;          
wire            vlsu_vidu_split_cancel;         
wire            vlsu_vidu_split_pause;          
wire            vlsu_warm_up;                   
wire            vlsu_xx_ex1_fp_stall;           
wire            vlsu_xx_no_op;                  
wire    [19:0]  vpu_group_3_xx_ex1_func;        
wire    [4 :0]  vpu_group_3_xx_ex1_imm;         
wire    [1 :0]  vpu_group_3_xx_ex1_lmul;        
wire            vpu_group_3_xx_ex1_sel;         
wire    [1 :0]  vpu_group_3_xx_ex1_sew;         
wire    [7 :0]  vpu_group_3_xx_ex1_split_count; 
wire    [63:0]  vpu_group_3_xx_ex1_srcv1;       
wire    [63:0]  vpu_group_3_xx_ex1_srcv2;       
wire            vpu_group_3_xx_ex1_srcv2_ready; 
wire    [7 :0]  vpu_group_3_xx_ex1_vl;          
wire    [7 :0]  vpu_group_3_xx_ex1_vl_byte_mask; 
wire    [7 :0]  vpu_group_3_xx_ex1_vm_byte_mask; 
wire            vpu_group_3_xx_ex1_vm_high;     
wire    [6 :0]  vpu_group_3_xx_ex1_vreg;        
wire    [6 :0]  vpu_group_3_xx_ex1_vstart;      
wire            vpu_vlsu_ex1_lsu_inst_vld;      
wire    [63:0]  vpu_vlsu_fp_wb_data;            
wire    [4 :0]  vpu_vlsu_fp_wb_reg;             
wire            vpu_vlsu_fp_wb_vld;             
wire            vst_create_bypass;              
wire    [6 :0]  vstart;                         
wire            vstart_byte_overflow;           
wire    [7 :0]  vstart_dis;                     
wire            vstart_ge_vl;                   
wire            vtb_all_wb;                     
wire            vtb_buffer_full;                
wire            vtb_clk;                        
wire            vtb_clk_en;                     
wire            vtb_create_full;                
wire            vtb_create_stall;               
wire    [3 :0]  vtb_entry_all_wb;               
wire    [63:0]  vtb_entry_data_0;               
wire    [63:0]  vtb_entry_data_1;               
wire    [63:0]  vtb_entry_data_2;               
wire    [63:0]  vtb_entry_data_3;               
wire    [3 :0]  vtb_entry_fls;                  
wire    [3 :0]  vtb_entry_fof_vld;              
wire    [63:0]  vtb_entry_fwd_data;             
wire    [3 :0]  vtb_entry_seq_last;             
wire    [9 :0]  vtb_entry_split_cnt_0;          
wire    [9 :0]  vtb_entry_split_cnt_1;          
wire    [9 :0]  vtb_entry_split_cnt_2;          
wire    [9 :0]  vtb_entry_split_cnt_3;          
wire    [3 :0]  vtb_entry_split_cnt_vld;        
wire    [3 :0]  vtb_entry_st_fwd_fp_bus;        
wire    [3 :0]  vtb_entry_st_fwd_vld;           
wire    [3 :0]  vtb_entry_st_vld;               
wire    [7 :0]  vtb_entry_vl_mask_0;            
wire    [7 :0]  vtb_entry_vl_mask_1;            
wire    [7 :0]  vtb_entry_vl_mask_2;            
wire    [7 :0]  vtb_entry_vl_mask_3;            
wire    [3 :0]  vtb_entry_vld;                  
wire    [3 :0]  vtb_entry_vload_vld;            
wire    [7 :0]  vtb_entry_vm_mask_0;            
wire    [7 :0]  vtb_entry_vm_mask_1;            
wire    [7 :0]  vtb_entry_vm_mask_2;            
wire    [7 :0]  vtb_entry_vm_mask_3;            
wire    [6 :0]  vtb_entry_vreg_0;               
wire    [6 :0]  vtb_entry_vreg_1;               
wire    [6 :0]  vtb_entry_vreg_2;               
wire    [6 :0]  vtb_entry_vreg_3;               
wire    [3 :0]  vtb_entry_wb_ready;             
wire    [3 :0]  vtb_entry_wb_vld;               
wire    [3 :0]  vtb_entry_wdata_ready;          
wire    [3 :0]  vtb_entry_wdata_vld;            
wire            vtb_full;                       
wire            vtb_full_for_fp;                
wire            vtb_fwd_bypass;                 
wire            vtb_fwd_fls;                    
wire            vtb_fwd_fp_bus;                 
wire            vtb_fwd_ready;                  
wire            vtb_fwd_req;                    
wire            vtb_fwd_seq_last;               
wire            vtb_fwd_success;                
wire    [4 :0]  vtb_fwd_vreg;                   
wire            vtb_fwd_wdata_ready;            
wire            vtb_no_pending_st;              
wire            vtb_pop_entry_vld;              
wire            vtb_wb_ready;                   
wire            vtb_wb_vld;                     
wire            vtb_wdata_vld;                  
wire    [63:0]  wb_data_aft_vl;                 
wire    [63:0]  wb_data_aft_vm;                 
wire    [63:0]  wb_data_bf_vl;                  
wire    [63:0]  wb_data_final;                  
wire            wb_pop;                         
wire            wb_req;                         
wire    [3 :0]  wb_sel;                         
wire    [63:0]  wb_vl_mask_ext;                 
wire    [3 :0]  wb_vld;                         
wire    [63:0]  wb_vm_mask_ext;                 
wire    [7 :0]  wb_vm_mask_final;               


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;
parameter DWORD= 2'b11;

//===============================================
//            Instance entry
//===============================================
// &Force("nonport","vtb_entry_vl_index_2"); @33
// &Force("nonport","vtb_entry_split_cnt_2"); @34
// &Force("nonport","vtb_entry_vl_index_3"); @35
// &Force("nonport","vtb_entry_split_cnt_3"); @36
// &ConnRule(s/_x$/[0]/); @37
// &ConnRule(s/_v$/_0/); @38
// &Instance("aq_vlsu_vtb_entry","x_aq_vlsu_vtb_entry_0"); @39
aq_vlsu_vtb_entry  x_aq_vlsu_vtb_entry_0 (
  .cp0_vpu_icg_en             (cp0_vpu_icg_en            ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .fwd_vld_x                  (fwd_vld[0]                ),
  .if_vlsu_fls_data           (if_vlsu_fls_data          ),
  .if_vlsu_fls_reg            (if_vlsu_fls_reg           ),
  .if_vlsu_fls_wb_vld         (if_vlsu_fls_wb_vld        ),
  .lsu_wen_data_entry_v       (lsu_wen_data_entry_0      ),
  .lsu_wen_entry_v            (lsu_wen_entry_0           ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .round_bit                  (round_bit                 ),
  .rtu_yy_xx_flush            (rtu_yy_xx_flush           ),
  .sseg_abnormal_vld          (sseg_abnormal_vld         ),
  .sseg_wb_vld                (sseg_wb_vld               ),
  .vlsu_create_data_v         (vlsu_create_data_0        ),
  .vlsu_create_ele_cnt        (vlsu_create_ele_cnt       ),
  .vlsu_create_fls            (vlsu_create_fls           ),
  .vlsu_create_fof_vld        (vlsu_create_fof_vld       ),
  .vlsu_create_mask           (vlsu_create_mask          ),
  .vlsu_create_mask_ext       (vlsu_create_mask_ext      ),
  .vlsu_create_seq_last       (vlsu_create_seq_last      ),
  .vlsu_create_st_type_x      (vlsu_create_st_type[0]    ),
  .vlsu_create_vl_mask        (vlsu_create_vl_mask       ),
  .vlsu_create_vld_x          (vlsu_create_vld[0]        ),
  .vlsu_create_vreg           (vlsu_create_vreg          ),
  .vlsu_create_wready         (vlsu_create_wready        ),
  .vlsu_sseg_create           (vlsu_sseg_create          ),
  .vlsu_warm_up               (vlsu_warm_up              ),
  .vpu_vlsu_fp_wb_data        (vpu_vlsu_fp_wb_data       ),
  .vpu_vlsu_fp_wb_reg         (vpu_vlsu_fp_wb_reg        ),
  .vpu_vlsu_fp_wb_vld         (vpu_vlsu_fp_wb_vld        ),
  .vtb_entry_all_wb_x         (vtb_entry_all_wb[0]       ),
  .vtb_entry_data_v           (vtb_entry_data_0          ),
  .vtb_entry_fls_x            (vtb_entry_fls[0]          ),
  .vtb_entry_fof_vld_x        (vtb_entry_fof_vld[0]      ),
  .vtb_entry_seq_last_x       (vtb_entry_seq_last[0]     ),
  .vtb_entry_split_cnt_v      (vtb_entry_split_cnt_0     ),
  .vtb_entry_split_cnt_vld_x  (vtb_entry_split_cnt_vld[0]),
  .vtb_entry_st_fwd_fp_bus_x  (vtb_entry_st_fwd_fp_bus[0]),
  .vtb_entry_st_fwd_vld_x     (vtb_entry_st_fwd_vld[0]   ),
  .vtb_entry_st_vld_x         (vtb_entry_st_vld[0]       ),
  .vtb_entry_vl_mask_v        (vtb_entry_vl_mask_0       ),
  .vtb_entry_vld_x            (vtb_entry_vld[0]          ),
  .vtb_entry_vload_vld_x      (vtb_entry_vload_vld[0]    ),
  .vtb_entry_vm_mask_v        (vtb_entry_vm_mask_0       ),
  .vtb_entry_vreg_v           (vtb_entry_vreg_0          ),
  .vtb_entry_wb_ready_x       (vtb_entry_wb_ready[0]     ),
  .vtb_entry_wb_vld_x         (vtb_entry_wb_vld[0]       ),
  .vtb_entry_wdata_ready_x    (vtb_entry_wdata_ready[0]  ),
  .vtb_entry_wdata_vld_x      (vtb_entry_wdata_vld[0]    ),
  .wb_vld_x                   (wb_vld[0]                 )
);


// &ConnRule(s/_x$/[1]/); @41
// &ConnRule(s/_v$/_1/); @42
// &Instance("aq_vlsu_vtb_entry","x_aq_vlsu_vtb_entry_1"); @43
aq_vlsu_vtb_entry  x_aq_vlsu_vtb_entry_1 (
  .cp0_vpu_icg_en             (cp0_vpu_icg_en            ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .fwd_vld_x                  (fwd_vld[1]                ),
  .if_vlsu_fls_data           (if_vlsu_fls_data          ),
  .if_vlsu_fls_reg            (if_vlsu_fls_reg           ),
  .if_vlsu_fls_wb_vld         (if_vlsu_fls_wb_vld        ),
  .lsu_wen_data_entry_v       (lsu_wen_data_entry_1      ),
  .lsu_wen_entry_v            (lsu_wen_entry_1           ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .round_bit                  (round_bit                 ),
  .rtu_yy_xx_flush            (rtu_yy_xx_flush           ),
  .sseg_abnormal_vld          (sseg_abnormal_vld         ),
  .sseg_wb_vld                (sseg_wb_vld               ),
  .vlsu_create_data_v         (vlsu_create_data_1        ),
  .vlsu_create_ele_cnt        (vlsu_create_ele_cnt       ),
  .vlsu_create_fls            (vlsu_create_fls           ),
  .vlsu_create_fof_vld        (vlsu_create_fof_vld       ),
  .vlsu_create_mask           (vlsu_create_mask          ),
  .vlsu_create_mask_ext       (vlsu_create_mask_ext      ),
  .vlsu_create_seq_last       (vlsu_create_seq_last      ),
  .vlsu_create_st_type_x      (vlsu_create_st_type[1]    ),
  .vlsu_create_vl_mask        (vlsu_create_vl_mask       ),
  .vlsu_create_vld_x          (vlsu_create_vld[1]        ),
  .vlsu_create_vreg           (vlsu_create_vreg          ),
  .vlsu_create_wready         (vlsu_create_wready        ),
  .vlsu_sseg_create           (vlsu_sseg_create          ),
  .vlsu_warm_up               (vlsu_warm_up              ),
  .vpu_vlsu_fp_wb_data        (vpu_vlsu_fp_wb_data       ),
  .vpu_vlsu_fp_wb_reg         (vpu_vlsu_fp_wb_reg        ),
  .vpu_vlsu_fp_wb_vld         (vpu_vlsu_fp_wb_vld        ),
  .vtb_entry_all_wb_x         (vtb_entry_all_wb[1]       ),
  .vtb_entry_data_v           (vtb_entry_data_1          ),
  .vtb_entry_fls_x            (vtb_entry_fls[1]          ),
  .vtb_entry_fof_vld_x        (vtb_entry_fof_vld[1]      ),
  .vtb_entry_seq_last_x       (vtb_entry_seq_last[1]     ),
  .vtb_entry_split_cnt_v      (vtb_entry_split_cnt_1     ),
  .vtb_entry_split_cnt_vld_x  (vtb_entry_split_cnt_vld[1]),
  .vtb_entry_st_fwd_fp_bus_x  (vtb_entry_st_fwd_fp_bus[1]),
  .vtb_entry_st_fwd_vld_x     (vtb_entry_st_fwd_vld[1]   ),
  .vtb_entry_st_vld_x         (vtb_entry_st_vld[1]       ),
  .vtb_entry_vl_mask_v        (vtb_entry_vl_mask_1       ),
  .vtb_entry_vld_x            (vtb_entry_vld[1]          ),
  .vtb_entry_vload_vld_x      (vtb_entry_vload_vld[1]    ),
  .vtb_entry_vm_mask_v        (vtb_entry_vm_mask_1       ),
  .vtb_entry_vreg_v           (vtb_entry_vreg_1          ),
  .vtb_entry_wb_ready_x       (vtb_entry_wb_ready[1]     ),
  .vtb_entry_wb_vld_x         (vtb_entry_wb_vld[1]       ),
  .vtb_entry_wdata_ready_x    (vtb_entry_wdata_ready[1]  ),
  .vtb_entry_wdata_vld_x      (vtb_entry_wdata_vld[1]    ),
  .wb_vld_x                   (wb_vld[1]                 )
);


// &ConnRule(s/_x$/[2]/); @45
// &ConnRule(s/_v$/_2/); @46
// &Instance("aq_vlsu_vtb_entry","x_aq_vlsu_vtb_entry_2"); @47
aq_vlsu_vtb_entry  x_aq_vlsu_vtb_entry_2 (
  .cp0_vpu_icg_en             (cp0_vpu_icg_en            ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .fwd_vld_x                  (fwd_vld[2]                ),
  .if_vlsu_fls_data           (if_vlsu_fls_data          ),
  .if_vlsu_fls_reg            (if_vlsu_fls_reg           ),
  .if_vlsu_fls_wb_vld         (if_vlsu_fls_wb_vld        ),
  .lsu_wen_data_entry_v       (lsu_wen_data_entry_2      ),
  .lsu_wen_entry_v            (lsu_wen_entry_2           ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .round_bit                  (round_bit                 ),
  .rtu_yy_xx_flush            (rtu_yy_xx_flush           ),
  .sseg_abnormal_vld          (sseg_abnormal_vld         ),
  .sseg_wb_vld                (sseg_wb_vld               ),
  .vlsu_create_data_v         (vlsu_create_data_2        ),
  .vlsu_create_ele_cnt        (vlsu_create_ele_cnt       ),
  .vlsu_create_fls            (vlsu_create_fls           ),
  .vlsu_create_fof_vld        (vlsu_create_fof_vld       ),
  .vlsu_create_mask           (vlsu_create_mask          ),
  .vlsu_create_mask_ext       (vlsu_create_mask_ext      ),
  .vlsu_create_seq_last       (vlsu_create_seq_last      ),
  .vlsu_create_st_type_x      (vlsu_create_st_type[2]    ),
  .vlsu_create_vl_mask        (vlsu_create_vl_mask       ),
  .vlsu_create_vld_x          (vlsu_create_vld[2]        ),
  .vlsu_create_vreg           (vlsu_create_vreg          ),
  .vlsu_create_wready         (vlsu_create_wready        ),
  .vlsu_sseg_create           (vlsu_sseg_create          ),
  .vlsu_warm_up               (vlsu_warm_up              ),
  .vpu_vlsu_fp_wb_data        (vpu_vlsu_fp_wb_data       ),
  .vpu_vlsu_fp_wb_reg         (vpu_vlsu_fp_wb_reg        ),
  .vpu_vlsu_fp_wb_vld         (vpu_vlsu_fp_wb_vld        ),
  .vtb_entry_all_wb_x         (vtb_entry_all_wb[2]       ),
  .vtb_entry_data_v           (vtb_entry_data_2          ),
  .vtb_entry_fls_x            (vtb_entry_fls[2]          ),
  .vtb_entry_fof_vld_x        (vtb_entry_fof_vld[2]      ),
  .vtb_entry_seq_last_x       (vtb_entry_seq_last[2]     ),
  .vtb_entry_split_cnt_v      (vtb_entry_split_cnt_2     ),
  .vtb_entry_split_cnt_vld_x  (vtb_entry_split_cnt_vld[2]),
  .vtb_entry_st_fwd_fp_bus_x  (vtb_entry_st_fwd_fp_bus[2]),
  .vtb_entry_st_fwd_vld_x     (vtb_entry_st_fwd_vld[2]   ),
  .vtb_entry_st_vld_x         (vtb_entry_st_vld[2]       ),
  .vtb_entry_vl_mask_v        (vtb_entry_vl_mask_2       ),
  .vtb_entry_vld_x            (vtb_entry_vld[2]          ),
  .vtb_entry_vload_vld_x      (vtb_entry_vload_vld[2]    ),
  .vtb_entry_vm_mask_v        (vtb_entry_vm_mask_2       ),
  .vtb_entry_vreg_v           (vtb_entry_vreg_2          ),
  .vtb_entry_wb_ready_x       (vtb_entry_wb_ready[2]     ),
  .vtb_entry_wb_vld_x         (vtb_entry_wb_vld[2]       ),
  .vtb_entry_wdata_ready_x    (vtb_entry_wdata_ready[2]  ),
  .vtb_entry_wdata_vld_x      (vtb_entry_wdata_vld[2]    ),
  .wb_vld_x                   (wb_vld[2]                 )
);


// &ConnRule(s/_x$/[3]/); @49
// &ConnRule(s/_v$/_3/); @50
// &Instance("aq_vlsu_vtb_entry","x_aq_vlsu_vtb_entry_3"); @51
aq_vlsu_vtb_entry  x_aq_vlsu_vtb_entry_3 (
  .cp0_vpu_icg_en             (cp0_vpu_icg_en            ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .fwd_vld_x                  (fwd_vld[3]                ),
  .if_vlsu_fls_data           (if_vlsu_fls_data          ),
  .if_vlsu_fls_reg            (if_vlsu_fls_reg           ),
  .if_vlsu_fls_wb_vld         (if_vlsu_fls_wb_vld        ),
  .lsu_wen_data_entry_v       (lsu_wen_data_entry_3      ),
  .lsu_wen_entry_v            (lsu_wen_entry_3           ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .round_bit                  (round_bit                 ),
  .rtu_yy_xx_flush            (rtu_yy_xx_flush           ),
  .sseg_abnormal_vld          (sseg_abnormal_vld         ),
  .sseg_wb_vld                (sseg_wb_vld               ),
  .vlsu_create_data_v         (vlsu_create_data_3        ),
  .vlsu_create_ele_cnt        (vlsu_create_ele_cnt       ),
  .vlsu_create_fls            (vlsu_create_fls           ),
  .vlsu_create_fof_vld        (vlsu_create_fof_vld       ),
  .vlsu_create_mask           (vlsu_create_mask          ),
  .vlsu_create_mask_ext       (vlsu_create_mask_ext      ),
  .vlsu_create_seq_last       (vlsu_create_seq_last      ),
  .vlsu_create_st_type_x      (vlsu_create_st_type[3]    ),
  .vlsu_create_vl_mask        (vlsu_create_vl_mask       ),
  .vlsu_create_vld_x          (vlsu_create_vld[3]        ),
  .vlsu_create_vreg           (vlsu_create_vreg          ),
  .vlsu_create_wready         (vlsu_create_wready        ),
  .vlsu_sseg_create           (vlsu_sseg_create          ),
  .vlsu_warm_up               (vlsu_warm_up              ),
  .vpu_vlsu_fp_wb_data        (vpu_vlsu_fp_wb_data       ),
  .vpu_vlsu_fp_wb_reg         (vpu_vlsu_fp_wb_reg        ),
  .vpu_vlsu_fp_wb_vld         (vpu_vlsu_fp_wb_vld        ),
  .vtb_entry_all_wb_x         (vtb_entry_all_wb[3]       ),
  .vtb_entry_data_v           (vtb_entry_data_3          ),
  .vtb_entry_fls_x            (vtb_entry_fls[3]          ),
  .vtb_entry_fof_vld_x        (vtb_entry_fof_vld[3]      ),
  .vtb_entry_seq_last_x       (vtb_entry_seq_last[3]     ),
  .vtb_entry_split_cnt_v      (vtb_entry_split_cnt_3     ),
  .vtb_entry_split_cnt_vld_x  (vtb_entry_split_cnt_vld[3]),
  .vtb_entry_st_fwd_fp_bus_x  (vtb_entry_st_fwd_fp_bus[3]),
  .vtb_entry_st_fwd_vld_x     (vtb_entry_st_fwd_vld[3]   ),
  .vtb_entry_st_vld_x         (vtb_entry_st_vld[3]       ),
  .vtb_entry_vl_mask_v        (vtb_entry_vl_mask_3       ),
  .vtb_entry_vld_x            (vtb_entry_vld[3]          ),
  .vtb_entry_vload_vld_x      (vtb_entry_vload_vld[3]    ),
  .vtb_entry_vm_mask_v        (vtb_entry_vm_mask_3       ),
  .vtb_entry_vreg_v           (vtb_entry_vreg_3          ),
  .vtb_entry_wb_ready_x       (vtb_entry_wb_ready[3]     ),
  .vtb_entry_wb_vld_x         (vtb_entry_wb_vld[3]       ),
  .vtb_entry_wdata_ready_x    (vtb_entry_wdata_ready[3]  ),
  .vtb_entry_wdata_vld_x      (vtb_entry_wdata_vld[3]    ),
  .wb_vld_x                   (wb_vld[3]                 )
);

//================================================
//        input interface
//================================================
// &Force("bus","sseg_nf",2,0); @55
//from lsu if
assign lsu_wb_vld            = if_vlsu_vls_wb_vld;
assign lsu_wb_abnormal       = if_vlsu_vls_wb_abnormal;
assign lsu_wb_data[`LSU_DATAW-1:0]      = if_vlsu_vls_wb_data[`LSU_DATAW-1:0];
assign lsu_wb_bytes_vld[`LSU_BYTEW-1:0] = if_vlsu_vls_wb_bytes_vld[`LSU_BYTEW-1:0];

assign lsu_merge_vld             = if_vlsu_merge_vld;
assign lsu_merge_data[`LSU_DATAW-1:0] = if_vlsu_merge_data[`LSU_DATAW-1:0];
//assign lsu_merge_vreg[5:0]  = if_vlsu_merge_vreg[5:0];

assign lsu_sel0[3:0] = if_vlsu_sel0[3:0];
assign lsu_sel1[3:0] = if_vlsu_sel1[3:0];
assign lsu_sel2[3:0] = if_vlsu_sel2[3:0];
assign lsu_sel3[3:0] = if_vlsu_sel3[3:0];

assign lsu_fwd_done    = if_vlsu_fwd_done;

//from vlsu if
// &Force("bus","vpu_group_3_xx_ex1_func",19,0); @74
// &Force("bus","vpu_group_3_xx_ex1_imm",4,0); @75
assign vlsu_create_nf[2:0]   = vpu_group_3_xx_ex1_func[18:16];
assign vlsu_create_sew[1:0]  = vpu_group_3_xx_ex1_sew[1:0];
assign vlsu_create_lmul[1:0] = vpu_group_3_xx_ex1_lmul[1:0];
assign vlsu_create_gate = vpu_vlsu_ex1_lsu_inst_vld;
assign vlsu_create_req  = vpu_vlsu_ex1_lsu_inst_vld
                          && !vlsu_stall 
                          && (!vlsu_create_fls || vlsu_create_st);
assign vlsu_create_st   = vpu_group_3_xx_ex1_func[0]; 
assign vlsu_create_amo  = &vpu_group_3_xx_ex1_func[5:4]; 
assign vlsu_create_no_wd= vpu_group_3_xx_ex1_func[15]; 
assign vlsu_create_fls  = vpu_group_3_xx_ex1_func[10]; 
assign vlsu_create_data0_ori[`LSU_DATAW-1:0]= vpu_group_3_xx_ex1_srcv2[`LSU_DATAW-1:0];
assign vlsu_create_data1_ori[`LSU_DATAW-1:0]= vpu_group_3_xx_ex1_srcv1[`LSU_DATAW-1:0];
assign vlsu_create_vmask[`LSU_BYTEW-1:0]    = vstart_ge_vl
                                         ? {`LSU_BYTEW{1'h0}}
                                         : vlsu_sseg_vm_ff_vld
                                           ? vm_byte_mask_ff[`LSU_BYTEW-1:0]
                                           : vpu_group_3_xx_ex1_vm_byte_mask[`LSU_BYTEW-1:0]; 
assign vlsu_create_vl_mask[`LSU_BYTEW-1:0]  = vstart_ge_vl 
                                         ? {`LSU_BYTEW{1'h1}}
                                         : vpu_group_3_xx_ex1_vl_byte_mask[`LSU_BYTEW-1:0] | ~reg_cnt_mask_vld[`LSU_BYTEW-1:0]; 
assign vlsu_create_vreg[6:0]     = vpu_group_3_xx_ex1_vreg[6:0];
assign vlsu_create_wdata_ready   = vpu_group_3_xx_ex1_srcv2_ready;
//for nf5/6/7/8
assign vlsu_create_split_cnt[7:0]= vpu_group_3_xx_ex1_split_count[7:0];
assign vlsu_create_reg_cnt[3:0]  = {1'b0,vpu_group_3_xx_ex1_split_count[6:4]};
assign vlsu_create_nf_cnt[2:0]   = vpu_group_3_xx_ex1_imm[3:1];

//for fof
assign vlsu_create_fof_vld       = vpu_group_3_xx_ex1_sel && vpu_group_3_xx_ex1_func[14];

//for fld sync
assign vlsu_create_fld_req = vpu_vlsu_ex1_lsu_inst_vld
                             && vlsu_create_fls
                             && !vlsu_create_st;

assign lsu_fld_req  = lsu_vlsu_dc_fld_req;
assign lsu_dc_stall = lsu_vlsu_dc_stall;

//for vstart/vl
assign vstart[6:0] =  vpu_group_3_xx_ex1_vstart[6:0];
assign vl[7:0]     =  vpu_group_3_xx_ex1_vl[7:0];

assign vstart_ge_vl = (vstart[6:0] >= vl[6:0]) && !vl[7];
//===============================================
//            vector buffer
//===============================================
assign create_vld = vlsu_create_req && !vfst_create_bypass_success;

assign crt_ptr = vtb_entry_vld[0];
//----------------pop ptr to indicate oldest entry---------------
assign wb_pop = wb_vld[1] && pop_ptr
                || wb_vld[0] && !pop_ptr;

assign fwd_pop = fwd_vld[1] && pop_ptr
                || fwd_vld[0] && !pop_ptr;  

assign pop_empty_vld = (crt_ptr ^ pop_ptr) && !vtb_pop_entry_vld;

assign pop_vld = wb_pop || fwd_pop || pop_empty_vld; 

assign vtb_clk_en = vlsu_create_gate || wb_req || fwd_req || pop_empty_vld  || vlsu_warm_up 
                    || fld_wait_ff   || fld_next_wait_ff  || vm_ff_vld || rtu_yy_xx_async_flush; 

// &Instance("gated_clk_cell", "x_aq_lsu_vlsu_gated_clk"); @147
gated_clk_cell  x_aq_lsu_vlsu_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vtb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vtb_clk_en        ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @148
//          .external_en (1'b0), @149
//          .global_en   (1'b1), @150
//          .module_en   (cp0_vpu_icg_en), @151
//          .local_en    (vtb_clk_en), @152
//          .clk_out     (vtb_clk)); @153

always@(posedge vtb_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    pop_ptr <= 1'b0;
  else if (create_vld && !vtb_pop_entry_vld) 
    pop_ptr <= crt_ptr;
  else if (pop_vld) 
    pop_ptr <= !pop_ptr;
end

//---------------create-------------------
//for sseg
// &CombBeg; @167
always @( vlsu_create_nf_cnt[1:0])
begin
  case(vlsu_create_nf_cnt[1:0])
  2'b00: sseg_create0_sel[3:0] = 4'h1; 
  2'b01: sseg_create0_sel[3:0] = 4'h2; 
  2'b10: sseg_create0_sel[3:0] = 4'h4; 
  2'b11: sseg_create0_sel[3:0] = 4'h8; 
  default: sseg_create0_sel[3:0] = {4{1'bx}};
  endcase
// &CombEnd; @175
end

//to acclr sseg st fwd, create two entry one time
assign sseg_create1_sel[3:0] = vlsu_create_st && !(vtb_entry_vld[1] && !vlsu_create_nf[0])
                               ? vtb_entry_vld[1]
                                 ? 4'h4
                                 : 4'h1
                               : 4'h0;

assign sseg_create_sel[3:0] =  sseg_create0_sel[3:0] | sseg_create1_sel[3:0]; 

assign vlsu_sseg_create = !vlsu_create_nf[2] && |vlsu_create_nf[1:0];

//for zvamo,when wd valid,create two entry simultaneously
assign vlsu_amo_create1 = vlsu_create_amo && !vlsu_create_no_wd;

assign vlsu_create_sel[3:0] = vlsu_sseg_create
                              ? sseg_create_sel[3:0] 
                              : {2'b0,(crt_ptr || vlsu_amo_create1),!crt_ptr};

assign vlsu_create_vld[3:0] = {4{create_vld}} & vlsu_create_sel[3:0];

//pop vld
assign vtb_pop_entry_vld = pop_ptr
                           ? vtb_entry_vld[1]
                           : vtb_entry_vld[0];

//split last
// &CombBeg; @204
// &CombEnd; @212
// &CombBeg; @214
// &CombEnd; @224
// &CombBeg; @226
always @( vlsu_create_lmul[1:0]
       or vlsu_create_split_cnt[3:0])
begin
  case(vlsu_create_lmul[1:0])
  2'b00: split_last_reg = vlsu_create_split_cnt[0]; 
  2'b01: split_last_reg = &vlsu_create_split_cnt[1:0]; 
  2'b10: split_last_reg = &vlsu_create_split_cnt[2:0]; 
  2'b11: split_last_reg = &vlsu_create_split_cnt[3:0]; 
  default: split_last_reg = 1'b0;
  endcase
// &CombEnd; @234
end

// &CombBeg; @236
always @( vlsu_create_reg_cnt[2:0]
       or vlsu_create_sew[1:0])
begin
  case(vlsu_create_sew[1:0])
  BYTE: last_reg_cnt = &vlsu_create_reg_cnt[2:0]; 
  HALF: last_reg_cnt = &vlsu_create_reg_cnt[2:1]; 
  WORD: last_reg_cnt = vlsu_create_reg_cnt[2];
  default: last_reg_cnt = 1'b0;
  endcase
// &CombEnd; @246
end

assign vlsu_create_split_last = |vlsu_create_nf[2:0]
                                ? vlsu_create_nf[2]
                                  ? split_last_reg 
                                    && (vlsu_create_nf_cnt[2:0] == vlsu_create_nf[2:0])
                                    && last_reg_cnt 
                                  : split_last_reg && sseg_vtb_last
                                : split_last_reg;

//for st align buffer, seq last will set fwd_vld when not bytes_vld full
assign vlsu_create_seq_last = vlsu_create_split_last 
                              || |vpu_group_3_xx_ex1_func[13:12] 
                              || vlsu_create_nf[2];

//element cnt
assign split_cnt_next_high[4:0] = {1'b0,vlsu_create_split_cnt[3:0]} + 5'h1;
assign split_cnt_next[7:0]      = {split_cnt_next_high[4:0],3'b0}; 

assign element_cnt[7:0] = vlsu_create_nf[2]
                          ? {vlsu_create_split_cnt[0],vlsu_create_reg_cnt[3:0],vlsu_create_nf_cnt[2:0]}
                          : split_cnt_next[7:0];

assign vlsu_create_ele_cnt[7:0] = element_cnt[7:0];

//for nf5/6/7/8
// &CombBeg; @280
// &CombEnd; @290
// &CombBeg; @292
always @( vlsu_create_sew[1:0])
begin
  case(vlsu_create_sew[1:0])
  BYTE: reg_cnt_mask_ori[7:0] = 8'h1; 
  HALF: reg_cnt_mask_ori[7:0] = 8'h3; 
  WORD: reg_cnt_mask_ori[7:0] = 8'hf; 
  default: reg_cnt_mask_ori[7:0] = {8{1'bx}};
  endcase
// &CombEnd; @302
end

// &CombBeg; @306
// &CombEnd; @326
// &CombBeg; @328
always @( reg_cnt_mask_ori[7:0]
       or vlsu_create_reg_cnt[2:0])
begin
  case(vlsu_create_reg_cnt[2:0])
  3'h0: reg_cnt_mask[7:0] = reg_cnt_mask_ori[7:0]; 
  3'h1: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[6:0],1'b0}; 
  3'h2: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[5:0],2'b0}; 
  3'h3: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[4:0],3'b0}; 
  3'h4: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[3:0],4'b0}; 
  3'h5: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[2:0],5'b0}; 
  3'h6: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[1:0],6'b0}; 
  3'h7: reg_cnt_mask[7:0] = {reg_cnt_mask_ori[0],7'b0}; 
  default: reg_cnt_mask[7:0] = {8{1'bx}};
  endcase
// &CombEnd; @340
end

assign reg_cnt_mask_vld[`LSU_BYTEW-1:0] = {`LSU_BYTEW{!vlsu_create_nf[2]}} | reg_cnt_mask[`LSU_BYTEW-1:0];

//------------------vstart mask----------------------------------------
// &CombBeg; @346
always @( vstart[6:0]
       or vlsu_create_sew[1:0])
begin
  case(vlsu_create_sew[1:0])
  BYTE: vstart_byte_count[8:0] = {2'b0,vstart[6:0]}; 
  HALF: vstart_byte_count[8:0] = {1'b0,vstart[6:0],1'b0}; 
  WORD: vstart_byte_count[8:0] = {vstart[6:0],2'b0}; 
  default: vstart_byte_count[8:0] = {9{1'bx}};
  endcase
// &CombEnd; @356
end
assign vstart_byte_overflow = |vstart_byte_count[8:7]; 

// &CombBeg; @365
// &CombEnd; @385
assign vstart_dis[7:0] = {1'b0,vstart_byte_count[6:0]} + {1'b0,~vlsu_create_split_cnt[3:0],3'b111} + 1'b1;

assign all_active_for_vstart   = !vstart_dis[7] && !vstart_byte_overflow;
assign all_inactive_for_vstart = vstart_dis[7] && (|vstart_dis[6:3]) || vstart_byte_overflow;

// &CombBeg; @392
always @( vstart_dis[2:0])
begin
case(vstart_dis[2:0])
  3'h0:active_with_vstart[7:0] = 8'hff;
  3'h1:active_with_vstart[7:0] = 8'hfe;
  3'h2:active_with_vstart[7:0] = 8'hfc;
  3'h3:active_with_vstart[7:0] = 8'hf8;
  3'h4:active_with_vstart[7:0] = 8'hf0;
  3'h5:active_with_vstart[7:0] = 8'he0;
  3'h6:active_with_vstart[7:0] = 8'hc0;
  3'h7:active_with_vstart[7:0] = 8'h80;
  default:active_with_vstart[7:0] = {8{1'bx}};
endcase
// &CombEnd; @404
end

// &CombBeg; @407
always @( active_with_vstart[7:0]
       or all_inactive_for_vstart
       or all_active_for_vstart)
begin
case({all_active_for_vstart,all_inactive_for_vstart})
  2'b10:active_bytes_with_vstart[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b1}};
  2'b01:active_bytes_with_vstart[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b0}};
  default:active_bytes_with_vstart[`LSU_BYTEW-1:0] = active_with_vstart[`LSU_BYTEW-1:0];
endcase
// &CombEnd; @413
end

//final create mask
assign vlsu_create_mask[`LSU_BYTEW-1:0] = vlsu_create_vmask[`LSU_BYTEW-1:0] 
                                     & active_bytes_with_vstart[`LSU_BYTEW-1:0]
                                     & reg_cnt_mask_vld[`LSU_BYTEW-1:0];

//--------------------------------------------------
//       data path
//--------------------------------------------------
assign vlsu_create_mask_ext[63:0] = {{8{vlsu_create_mask[7]}},{8{vlsu_create_mask[6]}},
                                     {8{vlsu_create_mask[5]}},{8{vlsu_create_mask[4]}},
                                     {8{vlsu_create_mask[3]}},{8{vlsu_create_mask[2]}},
                                     {8{vlsu_create_mask[1]}},{8{vlsu_create_mask[0]}}};

//--------------twist-------------------------
//for vtb entry
assign lsu_wen_entry_0[3:0] = {lsu_wen3[0],lsu_wen2[0],lsu_wen1[0],lsu_wen0[0]};
assign lsu_wen_entry_1[3:0] = {lsu_wen0[1],lsu_wen1[1],lsu_wen2[1],lsu_wen3[1]};
assign lsu_wen_entry_2[3:0] = {lsu_wen2[2],lsu_wen3[2],lsu_wen0[2],lsu_wen1[2]};
assign lsu_wen_entry_3[3:0] = {lsu_wen1[3],lsu_wen0[3],lsu_wen3[3],lsu_wen2[3]};

assign lsu_wen_data_entry_0[`LSU_DATAW-1:0] = lsu_merge_data[`LSU_DATAW-1:0];
assign lsu_wen_data_entry_1[`LSU_DATAW-1:0] = {lsu_merge_data[`VLSU_BLKW-1:0],
                                          lsu_merge_data[2*`VLSU_BLKW-1:`VLSU_BLKW],
                                          lsu_merge_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
                                          lsu_merge_data[`LSU_DATAW-1:3*`VLSU_BLKW]};
assign lsu_wen_data_entry_2[`LSU_DATAW-1:0] = {lsu_merge_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
                                          lsu_merge_data[`LSU_DATAW-1:3*`VLSU_BLKW],
                                          lsu_merge_data[`VLSU_BLKW-1:0],
                                          lsu_merge_data[2*`VLSU_BLKW-1:`VLSU_BLKW]};
assign lsu_wen_data_entry_3[`LSU_DATAW-1:0] = {lsu_merge_data[2*`VLSU_BLKW-1:`VLSU_BLKW],
                                          lsu_merge_data[`VLSU_BLKW-1:0],
                                          lsu_merge_data[`LSU_DATAW-1:3*`VLSU_BLKW],
                                          lsu_merge_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW]};

//================================================
//        round robin bit
//================================================
//use round robin bit to distinguish different vector load
assign round_bit[1:0] = 2'b0;
//================================================
//        vector load
//================================================
//to avoid v0 overlap,only first segment split will read v0
// &Force("nonport","vm_high_ff"); @488
assign vlsu_sseg_vm_create = vlsu_create_gate
                             && |vlsu_create_nf[2:0]
                             && (vlsu_create_lmul[1:0] == 2'b00)
                             && (!vm_ff_vld 
                                 || vpu_group_3_xx_ex1_vm_high ^ vm_high_ff);

assign vlsu_sseg_vm_clr = vlsu_create_gate
                          && |vlsu_create_nf[2:0]
                          && (vlsu_create_lmul[1:0] == 2'b00)
                          && !vlsu_stall
                          && vlsu_create_split_last;

always@(posedge vtb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    vm_ff_vld <= 1'b0;
  else if (rtu_yy_xx_flush || vlsu_sseg_vm_clr) 
    vm_ff_vld <= 1'b0;
  else if (vlsu_sseg_vm_create) 
    vm_ff_vld <= 1'b1;
end

always@(posedge vtb_clk)
begin
  if (vlsu_sseg_vm_create || vlsu_warm_up)
  begin 
    vm_byte_mask_ff[`LSU_BYTEW-1:0] <= vpu_group_3_xx_ex1_vm_byte_mask[`LSU_BYTEW-1:0];
    vm_high_ff                      <= vpu_group_3_xx_ex1_vm_high;
  end
end

assign vlsu_sseg_vm_ff_vld = vm_ff_vld
                             && |vlsu_create_nf[2:0]
                             && (vlsu_create_lmul[1:0] == 2'b00)
                             && (vpu_group_3_xx_ex1_vm_high == vm_high_ff);
//================================================
//        vector load
//================================================
assign lsu_wen0[3:0] = {4{lsu_merge_vld}} & lsu_sel0[3:0];
assign lsu_wen1[3:0] = {4{lsu_merge_vld}} & lsu_sel1[3:0];
assign lsu_wen2[3:0] = {4{lsu_merge_vld}} & lsu_sel2[3:0];
assign lsu_wen3[3:0] = {4{lsu_merge_vld}} & lsu_sel3[3:0];

//write back sel
//for sseg
// &CombBeg; @546
always @( vtb_entry_wb_vld[3:0])
begin
  casez(vtb_entry_wb_vld[3:0])
  4'b???1: sseg_wb_sel[3:0] = 4'h1; 
  4'b??10: sseg_wb_sel[3:0] = 4'h2; 
  4'b?100: sseg_wb_sel[3:0] = 4'h4; 
  4'b1000: sseg_wb_sel[3:0] = 4'h8; 
  default: sseg_wb_sel[3:0] = {4{1'bx}};
  endcase
// &CombEnd; @554
end

assign vtb_wb_ready = |vtb_entry_wb_ready[3:0];
assign vtb_wb_vld   = vtb_wb_ready || sseg_wb_vld;

assign entry1_wb_sel = pop_ptr && vtb_entry_vld[1] && !vtb_entry_st_vld[1]
                       || vtb_entry_st_vld[0] 
                       || !vtb_entry_vld[0];

assign wb_sel[3:0] = vtb_wb_vld
                     ? sseg_wb_sel[3:0] 
                     : {2'b0,entry1_wb_sel,!entry1_wb_sel};

// &CombBeg; @567
always @( vtb_entry_data_2[63:0]
       or vtb_entry_data_0[63:0]
       or vtb_entry_vm_mask_3[7:0]
       or vtb_entry_vreg_2[6:0]
       or vtb_entry_vl_mask_3[7:0]
       or vtb_entry_vreg_0[6:0]
       or vtb_entry_vl_mask_1[7:0]
       or vtb_entry_vreg_1[6:0]
       or vtb_entry_vm_mask_1[7:0]
       or vtb_entry_data_1[63:0]
       or vtb_entry_vm_mask_0[7:0]
       or vtb_entry_vl_mask_0[7:0]
       or vtb_entry_vreg_3[6:0]
       or vtb_entry_vm_mask_2[7:0]
       or vtb_entry_vl_mask_2[7:0]
       or vtb_entry_data_3[63:0]
       or wb_sel[3:0])
begin
  case(wb_sel[3:0])
  4'h1:
  begin 
  wb_data[`LSU_DATAW-1:0]   = vtb_entry_data_0[`LSU_DATAW-1:0];
  wb_vreg[6:0]          = vtb_entry_vreg_0[6:0];  
  wb_vm_mask[`LSU_BYTEW-1:0] = vtb_entry_vm_mask_0[`LSU_BYTEW-1:0];  
  wb_vl_mask[`LSU_BYTEW-1:0] = vtb_entry_vl_mask_0[`LSU_BYTEW-1:0];  
  end
  4'h2: 
  begin 
  wb_data[`LSU_DATAW-1:0]    = vtb_entry_data_1[`LSU_DATAW-1:0];
  wb_vreg[6:0]          = vtb_entry_vreg_1[6:0];  
  wb_vm_mask[`LSU_BYTEW-1:0] = vtb_entry_vm_mask_1[`LSU_BYTEW-1:0];  
  wb_vl_mask[`LSU_BYTEW-1:0] = vtb_entry_vl_mask_1[`LSU_BYTEW-1:0];  
  end
  4'h4: 
  begin 
  wb_data[`LSU_DATAW-1:0]    = vtb_entry_data_2[`LSU_DATAW-1:0];
  wb_vreg[6:0]          = vtb_entry_vreg_2[6:0];  
  wb_vm_mask[`LSU_BYTEW-1:0] = vtb_entry_vm_mask_2[`LSU_BYTEW-1:0];  
  wb_vl_mask[`LSU_BYTEW-1:0] = vtb_entry_vl_mask_2[`LSU_BYTEW-1:0];  
  end 
  4'h8: 
  begin 
  wb_data[`LSU_DATAW-1:0]    = vtb_entry_data_3[`LSU_DATAW-1:0];
  wb_vreg[6:0]          = vtb_entry_vreg_3[6:0];  
  wb_vm_mask[`LSU_BYTEW-1:0] = vtb_entry_vm_mask_3[`LSU_BYTEW-1:0];  
  wb_vl_mask[`LSU_BYTEW-1:0] = vtb_entry_vl_mask_3[`LSU_BYTEW-1:0];  
  end  
  default: 
  begin 
  wb_data[`LSU_DATAW-1:0]    = {`LSU_DATAW{1'bx}};
  wb_vreg[6:0]          = {7{1'bx}};  
  wb_vm_mask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'bx}}; 
  wb_vl_mask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'bx}}; 
  end  
  endcase
// &CombEnd; @605
end

assign wb_vm_mask_final[`LSU_BYTEW-1:0] = lsu_wb_abnormal
                                          ? lsu_wb_bytes_vld[`LSU_BYTEW-1:0] & wb_vm_mask[`LSU_BYTEW-1:0]
                                          : wb_vm_mask[`LSU_BYTEW-1:0]; 

assign wb_vm_mask_ext[63:0] = {{8{wb_vm_mask_final[7]}},{8{wb_vm_mask_final[6]}},
                               {8{wb_vm_mask_final[5]}},{8{wb_vm_mask_final[4]}},
                               {8{wb_vm_mask_final[3]}},{8{wb_vm_mask_final[2]}},
                               {8{wb_vm_mask_final[1]}},{8{wb_vm_mask_final[0]}}};

assign wb_vl_mask_ext[63:0] = {{8{wb_vl_mask[7]}},{8{wb_vl_mask[6]}},
                               {8{wb_vl_mask[5]}},{8{wb_vl_mask[4]}},
                               {8{wb_vl_mask[3]}},{8{wb_vl_mask[2]}},
                               {8{wb_vl_mask[1]}},{8{wb_vl_mask[0]}}};

assign wb_req = lsu_wb_vld || vtb_wb_vld;

assign wb_vld[3:0] = {4{wb_req}} & wb_sel[3:0];

//for direct wb
assign wb_data_aft_vm[`LSU_DATAW-1:0] = lsu_wb_data[`LSU_DATAW-1:0] & wb_vm_mask_ext[`LSU_DATAW-1:0]
                                        | wb_data[`LSU_DATAW-1:0] & ~wb_vm_mask_ext[`LSU_DATAW-1:0];

assign wb_data_bf_vl[`LSU_DATAW-1:0] = lsu_wb_vld
                                       ? wb_data_aft_vm[`LSU_DATAW-1:0]
                                       : wb_data[`LSU_DATAW-1:0];

assign wb_data_aft_vl[`LSU_DATAW-1:0] = wb_data_bf_vl[`LSU_DATAW-1:0] & wb_vl_mask_ext[`LSU_DATAW-1:0];

assign wb_data_final[`LSU_DATAW-1:0] =  lsu_wb_abnormal || sseg_abnormal_vld
                                        ? wb_data_bf_vl[`LSU_DATAW-1:0]
                                        : wb_data_aft_vl[`LSU_DATAW-1:0];

//================================================
//        vector store
//================================================
// &CombBeg; @662
always @( vtb_entry_data_0[15:0]
       or vtb_entry_data_1[63:48 ]
       or vtb_entry_data_2[31:16 ]
       or vtb_entry_data_3[47:32 ]
       or lsu_sel0[3:0])
begin
  case(lsu_sel0[3:0])
  4'h1: sseg_fwd_data[`VLSU_BLKW-1:0] = vtb_entry_data_0[`VLSU_BLKW-1:0]; 
  4'h2: sseg_fwd_data[`VLSU_BLKW-1:0] = vtb_entry_data_1[4*`VLSU_BLKW-1:3*`VLSU_BLKW]; 
  4'h4: sseg_fwd_data[`VLSU_BLKW-1:0] = vtb_entry_data_2[2*`VLSU_BLKW-1:`VLSU_BLKW]; 
  4'h8: sseg_fwd_data[`VLSU_BLKW-1:0] = vtb_entry_data_3[3*`VLSU_BLKW-1:2*`VLSU_BLKW]; 
  default: sseg_fwd_data[`VLSU_BLKW-1:0] = {`VLSU_BLKW{1'bx}};
  endcase
// &CombEnd; @670
end

// &CombBeg; @672
always @( vtb_entry_data_3[63:48 ]
       or vtb_entry_data_1[47:32 ]
       or vtb_entry_data_2[15:0]
       or lsu_sel1[3:0]
       or vtb_entry_data_0[31:16 ])
begin
  case(lsu_sel1[3:0])
  4'h1: sseg_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = vtb_entry_data_0[2*`VLSU_BLKW-1:`VLSU_BLKW]; 
  4'h2: sseg_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = vtb_entry_data_1[3*`VLSU_BLKW-1:2*`VLSU_BLKW]; 
  4'h4: sseg_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = vtb_entry_data_2[`VLSU_BLKW-1:0]; 
  4'h8: sseg_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = vtb_entry_data_3[4*`VLSU_BLKW-1:3*`VLSU_BLKW]; 
  default: sseg_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = {`VLSU_BLKW{1'bx}};
  endcase
// &CombEnd; @680
end

// &CombBeg; @682
always @( vtb_entry_data_0[47:32 ]
       or vtb_entry_data_3[15:0]
       or lsu_sel2[3:0]
       or vtb_entry_data_2[63:48 ]
       or vtb_entry_data_1[31:16 ])
begin
  case(lsu_sel2[3:0])
  4'h1: sseg_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = vtb_entry_data_0[3*`VLSU_BLKW-1:2*`VLSU_BLKW]; 
  4'h2: sseg_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = vtb_entry_data_1[2*`VLSU_BLKW-1:`VLSU_BLKW]; 
  4'h4: sseg_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = vtb_entry_data_2[4*`VLSU_BLKW-1:3*`VLSU_BLKW]; 
  4'h8: sseg_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = vtb_entry_data_3[`VLSU_BLKW-1:0]; 
  default: sseg_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = {`VLSU_BLKW{1'bx}};
  endcase
// &CombEnd; @690
end

// &CombBeg; @692
always @( lsu_sel3[3:0]
       or vtb_entry_data_3[31:16 ]
       or vtb_entry_data_2[47:32 ]
       or vtb_entry_data_0[63:48 ]
       or vtb_entry_data_1[15:0])
begin
  case(lsu_sel3[3:0])
  4'h1: sseg_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = vtb_entry_data_0[4*`VLSU_BLKW-1:3*`VLSU_BLKW]; 
  4'h2: sseg_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = vtb_entry_data_1[`VLSU_BLKW-1:0];
  4'h4: sseg_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = vtb_entry_data_2[3*`VLSU_BLKW-1:2*`VLSU_BLKW]; 
  4'h8: sseg_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = vtb_entry_data_3[2*`VLSU_BLKW-1:`VLSU_BLKW]; 
  default: sseg_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = {`VLSU_BLKW{1'bx}};
  endcase
// &CombEnd; @700
end

//--------------vtb reg fwd-----------------------------------------------
assign vtb_fwd_ready = entry1_fwd_sel && vtb_entry_st_vld[1]
                       || entry0_fwd_sel && vtb_entry_st_vld[0];

assign vtb_wdata_vld = entry1_fwd_sel && vtb_entry_wdata_vld[1]
                         || entry0_fwd_sel && vtb_entry_wdata_vld[0];  

assign entry1_fwd_sel = pop_ptr  && vtb_entry_st_vld[1] || !vtb_entry_st_vld[0];
assign entry0_fwd_sel = !pop_ptr && vtb_entry_st_vld[0] || !vtb_entry_st_vld[1];

assign vtb_entry_fwd_data[`LSU_DATAW-1:0] = entry1_fwd_sel
                                       ? vtb_entry_data_1[`LSU_DATAW-1:0]
                                       : vtb_entry_data_0[`LSU_DATAW-1:0];

assign vtb_fwd_bypass = entry1_fwd_sel && vtb_entry_st_fwd_vld[1]
                        || entry0_fwd_sel && vtb_entry_st_fwd_vld[0];

assign vtb_fwd_fp_bus = entry1_fwd_sel && vtb_entry_st_fwd_fp_bus[1]
                        || entry0_fwd_sel && vtb_entry_st_fwd_fp_bus[0];

assign vtb_fwd_seq_last = entry1_fwd_sel
                          ? vtb_entry_seq_last[1]
                          : vtb_entry_seq_last[0];

assign vtb_fwd_fls        = entry1_fwd_sel
                            ? vtb_entry_fls[1]
                            : vtb_entry_fls[0];

assign vtb_fwd_wdata_ready = entry1_fwd_sel
                            ? vtb_entry_wdata_ready[1]
                            : vtb_entry_wdata_ready[0];

assign vtb_fwd_vreg[4:0]   = entry1_fwd_sel
                             ? vtb_entry_vreg_1[6:2]
                             : vtb_entry_vreg_0[6:2];

assign vtb_fwd_req = vtb_fwd_ready && !sseg_vld || sseg_fwd_vld;

assign vtb_fwd_success = vtb_fwd_req && lsu_fwd_done && (sseg_fwd_last || !sseg_fwd_vld);

assign fwd_sel[3:0] = sseg_fwd_vld
                      ? 4'hf
                      : {2'b0,entry1_fwd_sel,!entry1_fwd_sel};

assign fwd_pop_sel[3:0] = fwd_sel[3:0];

assign fwd_vld[3:0] = {4{vtb_fwd_success}} & fwd_pop_sel[3:0];

//--------------final fwd req------------------
assign fwd_req = vtb_fwd_req || vfst_create_bypass;

//assign vlsu_fwd_data[63:0] = fst_create_prior && vlsu_create_fwd_fp_bus || vtb_fwd_bypass && vtb_fwd_fp_bus
//                             ? vpu_vlsu_fp_wb_data[63:0]
//                             : if_vlsu_fls_data[63:0];

assign vlsu_fwd_data[63:0] = vtb_fwd_bypass && vtb_fwd_fp_bus
                                  ? vpu_vlsu_fp_wb_data[63:0]
                                  : if_vlsu_fls_data[63:0];

assign fwd_data[63:0] = vtb_wdata_vld
                        ? vtb_entry_fwd_data[63:0]
                        : fst_create_prior && vlsu_create_wdata_ready || vst_create_bypass 
                          ? vlsu_create_data0_ori[63:0]
                          : vlsu_fwd_data[63:0];

assign fwd_seq_last = vtb_fwd_ready
                      ? vtb_fwd_seq_last
                      : vlsu_create_seq_last;

assign fwd_fls        = vtb_fwd_ready
                        ? vtb_fwd_fls
                        : vlsu_create_fls;

assign fwd_wdata_ready = vtb_fwd_ready
                        ? vtb_fwd_wdata_ready
                        : (vlsu_create_wdata_ready || vlsu_create_fwd_vld);

assign fwd_wdata_src2_reg[4:0] = vtb_fwd_ready
                                 ? vtb_fwd_vreg[4:0]
                                 : vlsu_create_vreg[6:2];
//================================================
//         fst data fwd and bypass 
//================================================
//for fst,data will internally fwded

//for fst create,since fst will not stall at vex1 
//and vidu can always forward data ahead wb
//hence no fp bus fwd when create 
assign vlsu_create_fst_vld = vlsu_create_gate
                             && vlsu_create_st
                             && vlsu_create_fls;

assign vlsu_create_fwd_lsu = if_vlsu_fls_wb_vld
                             && (if_vlsu_fls_reg[4:0] == vlsu_create_vreg[6:2]);

//assign vlsu_create_fwd_fp_bus = vpu_vlsu_fp_wb_vld
//                                && (vpu_vlsu_fp_wb_reg[4:0] == vlsu_create_vreg[5:1]);

//assign vlsu_create_fwd_vld = vlsu_create_fst_vld
//                             && !vlsu_create_wdata_ready
//                             && (vlsu_create_fwd_lsu || vlsu_create_fwd_fp_bus);

assign vlsu_create_fwd_vld = vlsu_create_fst_vld
                             && !vlsu_create_wdata_ready
                             && vlsu_create_fwd_lsu;

assign vlsu_create_wready = vlsu_create_st 
                            && (vlsu_create_wdata_ready || vlsu_create_fwd_vld);
//----------------- create data----------------
//assign vlsu_create_data0[`LSU_DATAW-1:0] = vlsu_create_fwd_vld
//                                      ? vlsu_create_fwd_fp_bus
//                                        ? vpu_vlsu_fp_wb_data[`LSU_DATAW-1:0]
//                                        : if_vlsu_fls_data[`LSU_DATAW-1:0]
//                                      : vlsu_create_data0_ori[`LSU_DATAW-1:0];
//
//assign vlsu_create_data1[`LSU_DATAW-1:0] = vlsu_create_fwd_vld
//                                      ? vlsu_create_fwd_fp_bus
//                                        ? vpu_vlsu_fp_wb_data[`LSU_DATAW-1:0]
//                                        : if_vlsu_fls_data[`LSU_DATAW-1:0]
//                                      : vlsu_sseg_create && vlsu_create_st
//                                        ? vlsu_create_data1_ori[`LSU_DATAW-1:0]
//                                        : vlsu_create_data0_ori[`LSU_DATAW-1:0];
assign if_vlsu_fls_data_ext[63:0]  = if_vlsu_fls_data[63:0];

assign vlsu_create_data0[`LSU_DATAW-1:0] = vlsu_create_fwd_vld
                                      ? if_vlsu_fls_data_ext[`LSU_DATAW-1:0]
                                      : vlsu_create_data0_ori[`LSU_DATAW-1:0];

assign vlsu_create_data1[`LSU_DATAW-1:0] = vlsu_create_fwd_vld
                                      ? if_vlsu_fls_data_ext[`LSU_DATAW-1:0]
                                      : vlsu_sseg_create && vlsu_create_st
                                        ? vlsu_create_data1_ori[`LSU_DATAW-1:0]
                                        : vlsu_create_data0_ori[`LSU_DATAW-1:0];

//to acclr sseg data create,entry1/entry3 will use another source
assign vlsu_create_data_0[`LSU_DATAW-1:0] = vlsu_create_data0[`LSU_DATAW-1:0];
assign vlsu_create_data_1[`LSU_DATAW-1:0] = vlsu_create_data1[`LSU_DATAW-1:0];
assign vlsu_create_data_2[`LSU_DATAW-1:0] = vlsu_create_data0_ori[`LSU_DATAW-1:0];
assign vlsu_create_data_3[`LSU_DATAW-1:0] = vlsu_create_st
                                       ? vlsu_create_data1_ori[`LSU_DATAW-1:0]
                                       : vlsu_create_data0_ori[`LSU_DATAW-1:0];
//----------------- create type----------------
//for zvamo,will create one type ld and one type st,otherwise will create ld or st
assign vlsu_create_st_type[3:0] = {{2{vlsu_create_st}},
                                   vlsu_create_st && !vlsu_amo_create1,
                                   vlsu_create_st};

//----------------- data bypass----------------
//for performance
assign vtb_no_pending_st = !(|vtb_entry_st_vld[3:0]);

assign fst_create_prior  = vlsu_create_fst_vld
                           && vtb_no_pending_st;

assign fst_create_bypass = fst_create_prior;
//                           && (vlsu_create_wdata_ready || vlsu_create_fwd_vld);

assign vst_create_bypass = vlsu_create_req
                           && vlsu_create_st
                           && !vlsu_create_fls
                           && !vlsu_create_amo
                           && !vlsu_sseg_create
                           && vtb_no_pending_st;

assign vfst_create_bypass = fst_create_bypass || vst_create_bypass;

assign vfst_create_bypass_success = vfst_create_bypass && lsu_fwd_done;
//================================================
//         fld dst dep sync 
//================================================
//to avoid WAW, sync lsu with vlsu here
assign fld_wait_clear = lsu_fld_req
                        && !lsu_dc_stall;

always@(posedge vtb_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    fld_wait_ff <= 1'b0;
  else if (rtu_yy_xx_flush) 
    fld_wait_ff <= 1'b0;
  else if (fld_next_wait_ff || fld_wait_ff && vlsu_create_fld_req) 
    fld_wait_ff <= 1'b1;
  else if (fld_wait_clear) 
    fld_wait_ff <= 1'b0;
  else if (vlsu_create_fld_req) 
    fld_wait_ff <= 1'b1;
end

always@(posedge vtb_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    fld_next_wait_ff <= 1'b0;
  else if (fld_wait_clear || rtu_yy_xx_flush) 
    fld_next_wait_ff <= 1'b0;
  else if (vlsu_create_fld_req && fld_wait_ff) 
    fld_next_wait_ff <= 1'b1;
end
//================================================
//        for flush
//================================================
assign vtb_all_wb = &vtb_entry_all_wb[3:0];
//================================================
//        for vidu split
//================================================
//----------------sseg full----------------------
assign sseg_vtb_ready  = &sseg_nf[1:0]
                         ? vtb_entry_vld[3]
                         : sseg_nf[1]
                           ? vtb_entry_vld[2]
                           : vtb_entry_vld[1]; 

assign sseg_vtb_last = (vlsu_create_nf_cnt[1:0] == vlsu_create_nf[1:0]);

//----------------normal full----------------------
//note zvamo and sseg st will both create two entry each cycle
//since sseg data will at least offer two split inst in dc stage
//hence no following fp inst when sseg st create,neglect it here 
assign vtb_full_for_fp = &vtb_entry_vld[1:0]
                         || vlsu_create_gate
                            && (|vtb_entry_vld[1:0] || vlsu_amo_create1);

assign vtb_create_full = vlsu_create_gate
                         && (vlsu_sseg_create
                                && sseg_vtb_last
                             || vlsu_amo_create1
                             || !vlsu_sseg_create
                                && |vtb_entry_vld[1:0]);

assign vtb_buffer_full = sseg_vld
                         ? sseg_vtb_ready
                         : &vtb_entry_vld[1:0]; 

assign vtb_full = vtb_create_full
                  || vtb_buffer_full;

//----------------vl dep and update---------------
assign vl_index_0_vld = 1'b0;

//----------------vtb quick bypass pop---------------
//for performance,lsu write back can cancel split pause immediately
//but for fof,for vl_depd simplicity,bypass is not supported
assign lsu_vtb_quick_pop = lsu_wb_vld
                              && !(|vtb_entry_fof_vld[1:0])
                           || vtb_wb_ready
                           || sseg_fwd_vld 
                              && sseg_fwd_last;
//================================================
//        for lsu sync
//================================================
assign vlsu_create_split_cnt_vld = vpu_vlsu_ex1_lsu_inst_vld
                                   && !vlsu_stall
                                   && !vlsu_sseg_create
                                   && !vlsu_create_fls
                                   && !vlsu_create_st; 

assign split_cnt0_vld  = vtb_entry_split_cnt_vld[0] || vlsu_create_split_cnt_vld;
assign split_cnt0[9:0] = vtb_entry_split_cnt_vld[0]
                         ? vtb_entry_split_cnt_0[9:0]
                         : {round_bit[1:0],vlsu_create_ele_cnt[7:0]};

assign split_cnt1_vld  = vtb_entry_split_cnt_vld[1] || vlsu_create_split_cnt_vld;
assign split_cnt1[9:0] = vtb_entry_split_cnt_vld[1]
                         ? vtb_entry_split_cnt_1[9:0]
                         : {round_bit[1:0],vlsu_create_ele_cnt[7:0]};  

//================================================
//        for vidu stall
//================================================
//----------------vtb create full----------------------
//in most situation,split pause will guarantee vtb not full when create
//but in some corner situation,still need vpu stall
//or for performance,split pause may release in advance
assign sseg_create_stall = vlsu_create_gate
                           && vlsu_sseg_create
                           && |(sseg_create_sel[3:0] & vtb_entry_vld[3:0]); 

assign vtb_create_stall = vlsu_create_gate
                          && !vlsu_create_fls
                          && !vlsu_sseg_create
                          && (crt_ptr && vtb_entry_vld[1]
                              || !crt_ptr && vtb_entry_vld[0]
                              || vlsu_amo_create1 && |vtb_entry_vld[1:0]
                              || |vtb_entry_vld[3:2]);
//----------------vlsu stall----------------------
assign vlsu_stall = sseg_create_stall
                    || vtb_create_stall
                    || vlsu_create_gate && !vlsu_create_fls && sseg_split_pause
                    || index_stall;
//================================================
//        output interface
//================================================
//for lsu fwd
assign vlsu_if_fwd_vld             = fwd_req;
assign vlsu_if_sseg_reg_data[`LSU_DATAW-1:0] = sseg_fwd_data[`LSU_DATAW-1:0];
assign vlsu_if_reg_data[`LSU_DATAW-1:0]      = fwd_data[`LSU_DATAW-1:0];
assign vlsu_if_reg_seq_last        = fwd_seq_last;
assign vlsu_if_reg_fls             = fwd_fls;
assign vlsu_if_reg_wdata_ready     = fwd_wdata_ready;
assign vlsu_if_reg_src2_reg[4:0]   = fwd_wdata_src2_reg[4:0];

assign vlsu_if_nf[2:0]        = vlsu_create_nf[2:0];
assign vlsu_if_sew[1:0]       = vlsu_create_sew[1:0];
assign vlsu_if_split_cnt0_vld = split_cnt0_vld;
assign vlsu_if_split_cnt1_vld = split_cnt1_vld;
assign vlsu_if_split_cnt0[9:0]= split_cnt0[9:0];
assign vlsu_if_split_cnt1[9:0]= split_cnt1[9:0];
assign vlsu_if_fof_vld        = vl_index_0_vld;
assign vlsu_if_vtb_round_bit[1:0] = round_bit[1:0];

//for vlsu write back
assign vlsu_rbus_vpr_wb_req             = wb_req;
assign vlsu_rbus_vpr_wb_data[`LSU_DATAW-1:0] = wb_data_final[`LSU_DATAW-1:0];
assign vlsu_rbus_vpr_wb_index[6:0]      = wb_vreg[6:0];

assign vlsu_rbus_fpr_wb_req             = if_vlsu_fls_wb_vld;
assign vlsu_rbus_fpr_wb_data[63:0]      = if_vlsu_fls_data[63:0];
assign vlsu_rbus_fpr_wb_index[4:0]      = if_vlsu_fls_reg[4:0];

//for sseg
assign sseg_vtb_fwd_pre  = vlsu_create_req
                           && vlsu_create_st
                           && vlsu_sseg_create
                           && !vtb_entry_vld[0]; 
assign sseg_vtb_fwd_start= vlsu_create_req
                           && vlsu_create_st
                           && vlsu_sseg_create
                           && sseg_vtb_last;

assign sseg_vtb_all_wb   = !(|vtb_entry_vload_vld[3:0]);
assign sseg_vtb_all_vld  = sseg_vtb_ready;

assign sseg_vtb_next_ready = &sseg_nf[1:0]
                             ? vtb_entry_vld[3]
                               && !vtb_entry_vld[0]
                             : sseg_nf[1]
                               ? vtb_entry_vld[2]
                               : vtb_entry_vld[1];


//for index update
assign vlsu_index_up_mask = vlsu_sseg_create
                               && vtb_entry_vld[0]
                            || vlsu_create_nf[2]
                               && (|vlsu_create_reg_cnt[3:0]
                                   || |vlsu_create_nf_cnt[2:0]);

assign vlsu_index_stall = vlsu_stall;


//for fld sync
assign vlsu_fld_stall = lsu_fld_req
                        && !(vlsu_create_fld_req || fld_wait_ff);

//--------------for rtu-----------------------------------------
assign vlsu_rtu_vl_updt_vld        = if_vlsu_vl_update;
assign vlsu_rtu_vl_updt_data[7:0]  = {1'b0,if_vlsu_vl_upval[6:0]};

//for flush
assign vlsu_xx_no_op = vtb_all_wb;

//for vpu split
assign vlsu_vidu_split_pause  = vtb_full && !lsu_vtb_quick_pop || sseg_split_pause; 
assign vlsu_vidu_split_cancel = 1'b0;
assign vlsu_vex1_split_stall  = vlsu_stall;

//for vpu stall
assign vlsu_xx_ex1_fp_stall = fld_wait_ff && (vlsu_create_fld_req || fld_next_wait_ff)
                              || sseg_split_pause
                              || vtb_full_for_fp; 


// &ModuleEnd; @1164
endmodule


