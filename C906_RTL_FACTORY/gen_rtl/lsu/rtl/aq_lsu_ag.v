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

// &Depend("aq_dtu_cfig.h"); @18
// &Depend("cpu_cfig.h"); @19
// &Depend("aq_lsu_cfig.h"); @20

// &ModuleBeg; @22
module aq_lsu_ag(
  ag_arb_data_idx,
  ag_arb_data_req,
  ag_arb_data_way,
  ag_arb_tag_idx,
  ag_arb_tag_req,
  ag_arb_tag_sel,
  ag_arb_tag_way,
  ag_dbginfo,
  ag_dc_addr,
  ag_dc_amo_func,
  ag_dc_buf,
  ag_dc_bytes_vld,
  ag_dc_ca,
  ag_dc_data_shift,
  ag_dc_dest_reg,
  ag_dc_expt_vld,
  ag_dc_func,
  ag_dc_hint_size,
  ag_dc_inst_pc,
  ag_dc_inst_vld,
  ag_dc_inst_vld_dp,
  ag_dc_inst_vld_gate,
  ag_dc_pf_amr_mask,
  ag_dc_priv_mode,
  ag_dc_sec,
  ag_dc_sew,
  ag_dc_sh,
  ag_dc_so,
  ag_dc_src2_depd,
  ag_dc_src2_reg,
  ag_dc_st_data,
  ag_dc_unalign,
  ag_dc_unalign_last,
  ag_dc_vec_nop,
  ag_dc_virt_idx,
  ag_dc_vlsu_split_cnt,
  ag_dc_vlsu_split_last,
  ag_dc_vlsu_sseg_first,
  ag_dc_vlsu_vl_update,
  ag_dc_vlsu_vl_upval,
  ag_dc_vlsu_wdata_shift,
  ag_dtu_addr,
  ag_dtu_addr_ready,
  ag_dtu_amo_type,
  ag_dtu_bytes_vld,
  ag_dtu_data,
  ag_dtu_data_chk_mask,
  ag_dtu_data_vld,
  ag_dtu_halt_info,
  ag_dtu_mem_access_size,
  ag_dtu_pipe_down,
  ag_dtu_req,
  ag_dtu_req_gate,
  ag_dtu_split_last,
  ag_dtu_st_type,
  ag_inst_store,
  ag_xx_no_op,
  arb_ag_grant,
  cp0_lsu_icg_en,
  cp0_lsu_mm,
  cp0_lsu_mpp,
  cp0_lsu_mprv,
  cp0_yy_priv_mode,
  cpurst_b,
  da_xx_fwd_data,
  da_xx_fwd_dst_reg,
  da_xx_fwd_vld,
  dc_ag_stall,
  dc_xx_dcache_req_mask,
  dtif_ag_cmplt_ready,
  dtif_ag_fsm_idle,
  dtif_ag_halt_info,
  dtif_ag_halt_info_up,
  dtif_ag_pipedown_mask,
  dtif_ag_stall,
  dtif_ag_trig_en,
  forever_cpuclk,
  idu_lsu_ex1_dp_sel,
  idu_lsu_ex1_dst0_reg,
  idu_lsu_ex1_dst1_reg,
  idu_lsu_ex1_func,
  idu_lsu_ex1_gateclk_sel,
  idu_lsu_ex1_halt_info,
  idu_lsu_ex1_length,
  idu_lsu_ex1_sel,
  idu_lsu_ex1_split,
  idu_lsu_ex1_src0_data,
  idu_lsu_ex1_src1_data,
  idu_lsu_ex1_src2_data,
  idu_lsu_ex1_src2_ready,
  idu_lsu_ex1_src2_reg,
  idu_lsu_ex1_vlmul,
  idu_lsu_ex1_vsew,
  ifu_lsu_warm_up,
  iu_lsu_ex1_cur_pc,
  lsu_idu_full,
  lsu_idu_global_full,
  lsu_mmu_abort,
  lsu_mmu_priv_mode,
  lsu_mmu_st_inst,
  lsu_mmu_va,
  lsu_mmu_va_vld,
  lsu_rtu_ex1_buffer_vld,
  lsu_rtu_ex1_cmplt,
  lsu_rtu_ex1_cmplt_dp,
  lsu_rtu_ex1_cmplt_for_pcgen,
  lsu_rtu_ex1_data,
  lsu_rtu_ex1_dest_reg,
  lsu_rtu_ex1_expt_tval,
  lsu_rtu_ex1_expt_vec,
  lsu_rtu_ex1_expt_vld,
  lsu_rtu_ex1_fs_dirty,
  lsu_rtu_ex1_halt_info,
  lsu_rtu_ex1_inst_len,
  lsu_rtu_ex1_inst_split,
  lsu_rtu_ex1_tval2_vld,
  lsu_rtu_ex1_vs_dirty,
  lsu_rtu_ex1_vstart,
  lsu_rtu_ex1_vstart_vld,
  lsu_rtu_ex1_wb_dp,
  lsu_rtu_ex1_wb_vld,
  lsu_rtu_ex2_tval2,
  mcic_ag_stall,
  mmu_lsu_access_fault,
  mmu_lsu_buf,
  mmu_lsu_ca,
  mmu_lsu_pa,
  mmu_lsu_pa_vld,
  mmu_lsu_page_fault,
  mmu_lsu_sec,
  mmu_lsu_sh,
  mmu_lsu_so,
  pad_yy_icg_scan_en,
  rtu_yy_xx_flush
);

// &Ports; @23
input           arb_ag_grant;                  
input           cp0_lsu_icg_en;                
input           cp0_lsu_mm;                    
input   [1 :0]  cp0_lsu_mpp;                   
input           cp0_lsu_mprv;                  
input   [1 :0]  cp0_yy_priv_mode;              
input           cpurst_b;                      
input   [63:0]  da_xx_fwd_data;                
input   [5 :0]  da_xx_fwd_dst_reg;             
input           da_xx_fwd_vld;                 
input           dc_ag_stall;                   
input           dc_xx_dcache_req_mask;         
input           dtif_ag_cmplt_ready;           
input           dtif_ag_fsm_idle;              
input   [21:0]  dtif_ag_halt_info;             
input           dtif_ag_halt_info_up;          
input           dtif_ag_pipedown_mask;         
input           dtif_ag_stall;                 
input           dtif_ag_trig_en;               
input           forever_cpuclk;                
input           idu_lsu_ex1_dp_sel;            
input   [5 :0]  idu_lsu_ex1_dst0_reg;          
input   [5 :0]  idu_lsu_ex1_dst1_reg;          
input   [19:0]  idu_lsu_ex1_func;              
input           idu_lsu_ex1_gateclk_sel;       
input   [21:0]  idu_lsu_ex1_halt_info;         
input           idu_lsu_ex1_length;            
input           idu_lsu_ex1_sel;               
input           idu_lsu_ex1_split;             
input   [63:0]  idu_lsu_ex1_src0_data;         
input   [63:0]  idu_lsu_ex1_src1_data;         
input   [63:0]  idu_lsu_ex1_src2_data;         
input           idu_lsu_ex1_src2_ready;        
input   [5 :0]  idu_lsu_ex1_src2_reg;          
input   [1 :0]  idu_lsu_ex1_vlmul;             
input   [1 :0]  idu_lsu_ex1_vsew;              
input           ifu_lsu_warm_up;               
input   [15:0]  iu_lsu_ex1_cur_pc;             
input           mcic_ag_stall;                 
input           mmu_lsu_access_fault;          
input           mmu_lsu_buf;                   
input           mmu_lsu_ca;                    
input   [27:0]  mmu_lsu_pa;                    
input           mmu_lsu_pa_vld;                
input           mmu_lsu_page_fault;            
input           mmu_lsu_sec;                   
input           mmu_lsu_sh;                    
input           mmu_lsu_so;                    
input           pad_yy_icg_scan_en;            
input           rtu_yy_xx_flush;               
output  [13:0]  ag_arb_data_idx;               
output          ag_arb_data_req;               
output  [3 :0]  ag_arb_data_way;               
output  [11:0]  ag_arb_tag_idx;                
output          ag_arb_tag_req;                
output  [3 :0]  ag_arb_tag_sel;                
output  [3 :0]  ag_arb_tag_way;                
output  [7 :0]  ag_dbginfo;                    
output  [39:0]  ag_dc_addr;                    
output  [4 :0]  ag_dc_amo_func;                
output          ag_dc_buf;                     
output  [7 :0]  ag_dc_bytes_vld;               
output          ag_dc_ca;                      
output  [3 :0]  ag_dc_data_shift;              
output  [5 :0]  ag_dc_dest_reg;                
output          ag_dc_expt_vld;                
output  [19:0]  ag_dc_func;                    
output  [4 :0]  ag_dc_hint_size;               
output  [15:0]  ag_dc_inst_pc;                 
output          ag_dc_inst_vld;                
output          ag_dc_inst_vld_dp;             
output          ag_dc_inst_vld_gate;           
output          ag_dc_pf_amr_mask;             
output  [1 :0]  ag_dc_priv_mode;               
output          ag_dc_sec;                     
output  [1 :0]  ag_dc_sew;                     
output          ag_dc_sh;                      
output          ag_dc_so;                      
output          ag_dc_src2_depd;               
output  [5 :0]  ag_dc_src2_reg;                
output  [63:0]  ag_dc_st_data;                 
output          ag_dc_unalign;                 
output          ag_dc_unalign_last;            
output          ag_dc_vec_nop;                 
output  [1 :0]  ag_dc_virt_idx;                
output  [9 :0]  ag_dc_vlsu_split_cnt;          
output          ag_dc_vlsu_split_last;         
output          ag_dc_vlsu_sseg_first;         
output          ag_dc_vlsu_vl_update;          
output  [6 :0]  ag_dc_vlsu_vl_upval;           
output  [3 :0]  ag_dc_vlsu_wdata_shift;        
output  [39:0]  ag_dtu_addr;                   
output          ag_dtu_addr_ready;             
output          ag_dtu_amo_type;               
output  [15:0]  ag_dtu_bytes_vld;              
output  [63:0]  ag_dtu_data;                   
output          ag_dtu_data_chk_mask;          
output          ag_dtu_data_vld;               
output  [21:0]  ag_dtu_halt_info;              
output  [2 :0]  ag_dtu_mem_access_size;        
output          ag_dtu_pipe_down;              
output          ag_dtu_req;                    
output          ag_dtu_req_gate;               
output          ag_dtu_split_last;             
output          ag_dtu_st_type;                
output          ag_inst_store;                 
output          ag_xx_no_op;                   
output          lsu_idu_full;                  
output          lsu_idu_global_full;           
output          lsu_mmu_abort;                 
output  [1 :0]  lsu_mmu_priv_mode;             
output          lsu_mmu_st_inst;               
output  [51:0]  lsu_mmu_va;                    
output          lsu_mmu_va_vld;                
output          lsu_rtu_ex1_buffer_vld;        
output          lsu_rtu_ex1_cmplt;             
output          lsu_rtu_ex1_cmplt_dp;          
output          lsu_rtu_ex1_cmplt_for_pcgen;   
output  [63:0]  lsu_rtu_ex1_data;              
output  [5 :0]  lsu_rtu_ex1_dest_reg;          
output  [39:0]  lsu_rtu_ex1_expt_tval;         
output  [4 :0]  lsu_rtu_ex1_expt_vec;          
output          lsu_rtu_ex1_expt_vld;          
output          lsu_rtu_ex1_fs_dirty;          
output  [21:0]  lsu_rtu_ex1_halt_info;         
output          lsu_rtu_ex1_inst_len;          
output          lsu_rtu_ex1_inst_split;        
output          lsu_rtu_ex1_tval2_vld;         
output          lsu_rtu_ex1_vs_dirty;          
output  [6 :0]  lsu_rtu_ex1_vstart;            
output          lsu_rtu_ex1_vstart_vld;        
output          lsu_rtu_ex1_wb_dp;             
output          lsu_rtu_ex1_wb_vld;            
output  [39:0]  lsu_rtu_ex2_tval2;             

// &Regs; @24
reg     [3 :0]  ag_addr_align;                 
reg     [63:0]  ag_offset_aft_shift;           
reg     [2 :0]  ag_pipe_access_size_ori;       
reg     [7 :0]  ag_pipe_bytes_vld_high;        
reg     [7 :0]  ag_pipe_bytes_vld_low;         
reg     [5 :0]  ag_pipe_dst0_reg;              
reg     [5 :0]  ag_pipe_dst1_reg;              
reg     [4 :0]  ag_pipe_expt_vec;              
reg     [21:0]  ag_pipe_halt_info;             
reg             ag_pipe_id_split;              
reg             ag_pipe_inst_len;              
reg     [1 :0]  ag_pipe_lmul;                  
reg             ag_pipe_misalign_unmask;       
reg     [15:0]  ag_pipe_pc;                    
reg     [1 :0]  ag_pipe_priv_mode;             
reg     [1 :0]  ag_pipe_sew;                   
reg     [7 :0]  ag_pipe_src1_imm;              
reg     [63:0]  ag_pipe_src2_data;             
reg             ag_pipe_src2_depd;             
reg     [5 :0]  ag_pipe_src2_reg;              
reg     [5 :0]  ag_req_buffer_dst0_reg;        
reg     [5 :0]  ag_req_buffer_dst1_reg;        
reg             ag_req_buffer_expt_ff;         
reg     [19:0]  ag_req_buffer_func;            
reg     [21:0]  ag_req_buffer_halt_info;       
reg             ag_req_buffer_id_split;        
reg             ag_req_buffer_inst_len;        
reg     [1 :0]  ag_req_buffer_lmul;            
reg     [15:0]  ag_req_buffer_pc;              
reg     [1 :0]  ag_req_buffer_priv_mode;       
reg     [1 :0]  ag_req_buffer_sew;             
reg     [63:0]  ag_req_buffer_src0_data;       
reg     [63:0]  ag_req_buffer_src1_data;       
reg     [7 :0]  ag_req_buffer_src1_imm;        
reg     [63:0]  ag_req_buffer_src2_data_ori;   
reg             ag_req_buffer_src2_depd;       
reg     [5 :0]  ag_req_buffer_src2_reg;        
reg     [39:0]  ag_req_buffer_tval2;           
reg             ag_req_buffer_vld;             
reg             ag_req_buffer_vld_rep1;        
reg             ag_req_buffer_vld_rep2;        
reg     [3 :0]  hint_addr_low;                 
reg     [2 :0]  max_access_size;               
reg             target_ca_ff;                  
reg             unalign_cur_state;             
reg             unalign_next_state;            
reg             vls_unalign;                   
reg     [3 :0]  wdata_shift_for_vlsu;          

// &Wires; @25
wire    [7 :0]  access_bytes_vld;              
wire    [63:0]  ag_addr;                       
wire    [13:0]  ag_arb_data_idx;               
wire            ag_arb_data_req;               
wire    [3 :0]  ag_arb_data_way;               
wire    [11:0]  ag_arb_tag_idx;                
wire            ag_arb_tag_req;                
wire    [3 :0]  ag_arb_tag_sel;                
wire    [3 :0]  ag_arb_tag_way;                
wire            ag_clk;                        
wire            ag_clk_en;                     
wire    [63:0]  ag_create_offset;              
wire    [7 :0]  ag_dbginfo;                    
wire    [39:0]  ag_dc_addr;                    
wire    [4 :0]  ag_dc_amo_func;                
wire            ag_dc_buf;                     
wire    [7 :0]  ag_dc_bytes_vld;               
wire            ag_dc_ca;                      
wire    [3 :0]  ag_dc_data_shift;              
wire    [5 :0]  ag_dc_dest_reg;                
wire            ag_dc_expt_vld;                
wire    [19:0]  ag_dc_func;                    
wire    [4 :0]  ag_dc_hint_size;               
wire    [15:0]  ag_dc_inst_pc;                 
wire            ag_dc_inst_vld;                
wire            ag_dc_inst_vld_dp;             
wire            ag_dc_inst_vld_gate;           
wire            ag_dc_pf_amr_mask;             
wire            ag_dc_pipe_mask;               
wire    [1 :0]  ag_dc_priv_mode;               
wire            ag_dc_sec;                     
wire    [1 :0]  ag_dc_sew;                     
wire            ag_dc_sh;                      
wire            ag_dc_so;                      
wire            ag_dc_src2_depd;               
wire    [5 :0]  ag_dc_src2_reg;                
wire    [63:0]  ag_dc_st_data;                 
wire            ag_dc_unalign;                 
wire            ag_dc_unalign_last;            
wire            ag_dc_vec_nop;                 
wire    [1 :0]  ag_dc_virt_idx;                
wire    [9 :0]  ag_dc_vlsu_split_cnt;          
wire            ag_dc_vlsu_split_last;         
wire            ag_dc_vlsu_sseg_first;         
wire            ag_dc_vlsu_vl_update;          
wire    [6 :0]  ag_dc_vlsu_vl_upval;           
wire    [3 :0]  ag_dc_vlsu_wdata_shift;        
wire            ag_dcache_grnt;                
wire            ag_dp_sel;                     
wire    [5 :0]  ag_dst0_reg;                   
wire    [5 :0]  ag_dst1_reg;                   
wire    [39:0]  ag_dtu_addr;                   
wire            ag_dtu_addr_ready;             
wire            ag_dtu_amo_type;               
wire    [15:0]  ag_dtu_bytes_vld;              
wire    [63:0]  ag_dtu_data;                   
wire            ag_dtu_data_chk_mask;          
wire            ag_dtu_data_vld;               
wire    [21:0]  ag_dtu_halt_info;              
wire    [2 :0]  ag_dtu_mem_access_size;        
wire            ag_dtu_pipe_down;              
wire            ag_dtu_req;                    
wire            ag_dtu_req_gate;               
wire            ag_dtu_split_last;             
wire            ag_dtu_st_type;                
wire    [19:0]  ag_func;                       
wire            ag_fwd_da;                     
wire            ag_gateclk_sel;                
wire    [21:0]  ag_halt_info;                  
wire            ag_id_split;                   
wire            ag_inst_len;                   
wire            ag_inst_store;                 
wire            ag_inst_vld;                   
wire    [1 :0]  ag_lmul;                       
wire    [1 :0]  ag_offset_shift;               
wire    [15:0]  ag_pc;                         
wire    [15:0]  ag_pipe_access_bytes_vld;      
wire            ag_pipe_access_fault;          
wire            ag_pipe_access_fault_with_page; 
wire    [3 :0]  ag_pipe_access_size;           
wire    [63:0]  ag_pipe_addr;                  
wire    [63:0]  ag_pipe_addr_offset;           
wire            ag_pipe_amo;                   
wire            ag_pipe_atomic;                
wire            ag_pipe_base_sel;              
wire            ag_pipe_boundary_unmask;       
wire    [7 :0]  ag_pipe_bytes_vld;             
wire    [7 :0]  ag_pipe_bytes_vld_cross;       
wire    [7 :0]  ag_pipe_bytes_vld_unalign;     
wire            ag_pipe_ca;                    
wire            ag_pipe_clk;                   
wire            ag_pipe_clk_en;                
wire            ag_pipe_cmplt_dp;              
wire            ag_pipe_cmplt_normal;          
wire            ag_pipe_cmplt_req;             
wire            ag_pipe_dca_pa;                
wire            ag_pipe_dca_st;                
wire            ag_pipe_dp_sel;                
wire            ag_pipe_dt_cancel;             
wire    [39:0]  ag_pipe_expt_tval;             
wire            ag_pipe_expt_vld;              
wire            ag_pipe_expt_vld_ori;          
wire            ag_pipe_fls;                   
wire            ag_pipe_fof_not_first;         
wire    [19:0]  ag_pipe_func;                  
wire            ag_pipe_inst_dca;              
wire            ag_pipe_inst_fof;              
wire            ag_pipe_inst_ld;               
wire            ag_pipe_inst_lsi;              
wire            ag_pipe_inst_st;               
wire            ag_pipe_inst_unalign;          
wire            ag_pipe_inst_vld;              
wire            ag_pipe_last_inst;             
wire            ag_pipe_lsi_offset_mask;       
wire            ag_pipe_misalign_no_page;      
wire            ag_pipe_misalign_with_page;    
wire            ag_pipe_mmu_expt;              
wire            ag_pipe_mmu_req;               
wire    [39:0]  ag_pipe_pa;                    
wire            ag_pipe_page_fault;            
wire            ag_pipe_sel;                   
wire    [1 :0]  ag_pipe_size;                  
wire    [63:0]  ag_pipe_src0_data;             
wire    [7 :0]  ag_pipe_src1_imm_aft_mask;     
wire            ag_pipe_tlb_miss;              
wire            ag_pipe_unalign;               
wire            ag_pipe_unalign_fsm_start;     
wire            ag_pipe_unalign_last;          
wire            ag_pipe_unalign_permit;        
wire            ag_pipe_unalign_req;           
wire            ag_pipe_unalign_req_dp;        
wire            ag_pipe_unit_stride;           
wire    [3 :0]  ag_pipe_va_add_access_size;    
wire    [3 :0]  ag_pipe_va_add_unalign;        
wire            ag_pipe_vls;                   
wire            ag_pipe_vls_cmplt;             
wire            ag_pipe_vls_cmplt_dp;          
wire    [1 :0]  ag_priv_mode;                  
wire            ag_req_buffer_create_dp;       
wire            ag_req_buffer_create_vld;      
wire            ag_req_buffer_fwd_da;          
wire            ag_req_buffer_pop_vld;         
wire    [63:0]  ag_req_buffer_src2_data;       
wire    [63:0]  ag_req_buffer_st_fwd_data;     
wire            ag_req_buffer_st_fwd_vld;      
wire            ag_self_stall;                 
wire    [1 :0]  ag_sew;                        
wire    [63:0]  ag_src0_data;                  
wire    [63:0]  ag_src1_aft_mask;              
wire    [63:0]  ag_src1_data;                  
wire    [63:0]  ag_src2_data;                  
wire    [63:0]  ag_src2_data_ori;              
wire            ag_src2_depd;                  
wire            ag_src2_depd_aft_fwd;          
wire    [5 :0]  ag_src2_reg;                   
wire    [63:0]  ag_st_fwd_data;                
wire            ag_st_fwd_vld;                 
wire            ag_stall;                      
wire            ag_vsplit_start;               
wire            ag_warm_up;                    
wire            ag_xx_no_op;                   
wire            arb_ag_grant;                  
wire    [7 :0]  bytes_vld_vmask;               
wire            cp0_lsu_icg_en;                
wire            cp0_lsu_mm;                    
wire    [1 :0]  cp0_lsu_mpp;                   
wire            cp0_lsu_mprv;                  
wire    [1 :0]  cp0_yy_priv_mode;              
wire            cpurst_b;                      
wire    [63:0]  da_fwd_data;                   
wire    [5 :0]  da_fwd_reg;                    
wire            da_fwd_vld;                    
wire    [63:0]  da_xx_fwd_data;                
wire    [5 :0]  da_xx_fwd_dst_reg;             
wire            da_xx_fwd_vld;                 
wire            dc_ag_stall;                   
wire            dc_xx_dcache_req_mask;         
wire            dcache_data_req;               
wire            dcache_req_mask;               
wire            dcache_tag_req;                
wire            dt_cmplt_ready;                
wire            dt_fsm_idle;                   
wire    [21:0]  dt_halt_info;                  
wire            dt_halt_info_up;               
wire            dt_pipedown_mask;              
wire            dt_stall;                      
wire            dt_trig_en;                    
wire            dtif_ag_cmplt_ready;           
wire            dtif_ag_fsm_idle;              
wire    [21:0]  dtif_ag_halt_info;             
wire            dtif_ag_halt_info_up;          
wire            dtif_ag_pipedown_mask;         
wire            dtif_ag_stall;                 
wire            dtif_ag_trig_en;               
wire            first_element_active;          
wire    [6 :0]  first_no_mask_cnt;             
wire            forever_cpuclk;                
wire            idu_lsu_ex1_dp_sel;            
wire    [5 :0]  idu_lsu_ex1_dst0_reg;          
wire    [5 :0]  idu_lsu_ex1_dst1_reg;          
wire    [19:0]  idu_lsu_ex1_func;              
wire            idu_lsu_ex1_gateclk_sel;       
wire    [21:0]  idu_lsu_ex1_halt_info;         
wire            idu_lsu_ex1_length;            
wire            idu_lsu_ex1_sel;               
wire            idu_lsu_ex1_split;             
wire    [63:0]  idu_lsu_ex1_src0_data;         
wire    [63:0]  idu_lsu_ex1_src1_data;         
wire    [63:0]  idu_lsu_ex1_src2_data;         
wire            idu_lsu_ex1_src2_ready;        
wire    [5 :0]  idu_lsu_ex1_src2_reg;          
wire    [1 :0]  idu_lsu_ex1_vlmul;             
wire    [1 :0]  idu_lsu_ex1_vsew;              
wire            ifu_lsu_warm_up;               
wire    [15:0]  iu_lsu_ex1_cur_pc;             
wire            lsu_full_stall;                
wire            lsu_idu_full;                  
wire            lsu_idu_global_full;           
wire            lsu_iu_ex1_lsi_dp;             
wire    [5 :0]  lsu_iu_ex1_lsi_dst_reg;        
wire    [63:0]  lsu_iu_ex1_lsi_imm;            
wire            lsu_iu_ex1_lsi_sel;            
wire    [63:0]  lsu_iu_ex1_lsi_src0;           
wire            lsu_mmu_abort;                 
wire    [1 :0]  lsu_mmu_priv_mode;             
wire            lsu_mmu_st_inst;               
wire    [51:0]  lsu_mmu_va;                    
wire            lsu_mmu_va_vld;                
wire            lsu_rtu_ex1_buffer_vld;        
wire            lsu_rtu_ex1_cmplt;             
wire            lsu_rtu_ex1_cmplt_dp;          
wire            lsu_rtu_ex1_cmplt_for_pcgen;   
wire    [63:0]  lsu_rtu_ex1_data;              
wire    [5 :0]  lsu_rtu_ex1_dest_reg;          
wire    [39:0]  lsu_rtu_ex1_expt_tval;         
wire    [4 :0]  lsu_rtu_ex1_expt_vec;          
wire            lsu_rtu_ex1_expt_vld;          
wire            lsu_rtu_ex1_fs_dirty;          
wire    [21:0]  lsu_rtu_ex1_halt_info;         
wire            lsu_rtu_ex1_inst_len;          
wire            lsu_rtu_ex1_inst_split;        
wire            lsu_rtu_ex1_tval2_vld;         
wire            lsu_rtu_ex1_vs_dirty;          
wire    [6 :0]  lsu_rtu_ex1_vstart;            
wire            lsu_rtu_ex1_vstart_vld;        
wire            lsu_rtu_ex1_wb_dp;             
wire            lsu_rtu_ex1_wb_vld;            
wire    [39:0]  lsu_rtu_ex2_tval2;             
wire            mcic_ag_stall;                 
wire            mmu_access_fault;              
wire            mmu_buf;                       
wire            mmu_ca;                        
wire            mmu_lsu_access_fault;          
wire            mmu_lsu_buf;                   
wire            mmu_lsu_ca;                    
wire    [27:0]  mmu_lsu_pa;                    
wire            mmu_lsu_pa_vld;                
wire            mmu_lsu_page_fault;            
wire            mmu_lsu_sec;                   
wire            mmu_lsu_sh;                    
wire            mmu_lsu_so;                    
wire    [27:0]  mmu_pa;                        
wire            mmu_pa_vld;                    
wire            mmu_page_fault;                
wire            mmu_sec;                       
wire            mmu_sh;                        
wire            mmu_so;                        
wire            normal_cmplt_inst;             
wire            pad_yy_icg_scan_en;            
wire            rtu_yy_xx_flush;               
wire    [63:0]  split_update_base;             
wire            split_update_base_en;          
wire    [63:0]  split_update_offset;           
wire            split_update_offset_en;        
wire            target_ca;                     
wire            target_up;                     
wire            unalign_src_up;                
wire    [63:0]  unalign_up_offset;             
wire            vector_nop;                    
wire    [3 :0]  vsplit_acc_cnt;                
wire    [3 :0]  vsplit_access_size;            
wire    [4 :0]  vsplit_amr_hint_size;          
wire            vsplit_base_up;                
wire    [7 :0]  vsplit_ele_next_align;         
wire            vsplit_finish_once;            
wire            vsplit_last;                   
wire            vsplit_mmu_req_mask;           
wire            vsplit_no_inst;                
wire            vsplit_no_op;                  
wire            vsplit_offset_up;              
wire            vsplit_on;                     
wire            vsplit_part_fwd;               
wire            vsplit_pf_mask;                
wire    [1 :0]  vsplit_round_bit;              
wire            vsplit_sseg_first;             
wire            vsplit_stall;                  
wire    [63:0]  vsplit_up_offset;              


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

//================================================
//        input interface
//================================================
//--------- from idu-------------------------
//control
assign ag_gateclk_sel = idu_lsu_ex1_gateclk_sel;
assign ag_dp_sel      = idu_lsu_ex1_dp_sel;
assign ag_inst_vld    = idu_lsu_ex1_sel;
assign ag_id_split    = idu_lsu_ex1_split;

//data path
assign ag_src0_data[63:0]     = idu_lsu_ex1_src0_data[63:0]; 
assign ag_src1_data[63:0]     = idu_lsu_ex1_src1_data[63:0];
assign ag_src2_data_ori[63:0] = idu_lsu_ex1_src2_data[63:0];

assign ag_dst0_reg[5:0] =  idu_lsu_ex1_dst0_reg[5:0];
assign ag_dst1_reg[5:0] =  idu_lsu_ex1_dst1_reg[5:0];
assign ag_src2_reg[5:0] =  idu_lsu_ex1_src2_reg[5:0];
assign ag_src2_depd     =  !idu_lsu_ex1_src2_ready;

assign ag_func[`FUNC_WIDTH-1:0] = idu_lsu_ex1_func[`FUNC_WIDTH-1:0];

assign ag_sew[1:0]  = idu_lsu_ex1_vsew[1:0];
assign ag_lmul[1:0] = idu_lsu_ex1_vlmul[1:0];

assign ag_priv_mode[1:0] = cp0_lsu_mprv 
                           ? cp0_lsu_mpp[1:0]
                           : cp0_yy_priv_mode[1:0];

//other info
assign ag_inst_len       = idu_lsu_ex1_length;

assign ag_halt_info[`TDT_HINFO_WIDTH-1:0] = idu_lsu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];

assign ag_offset_shift[1:0] = {idu_lsu_ex1_func[15],idu_lsu_ex1_func[4]};

assign ag_pc[15:0] = iu_lsu_ex1_cur_pc[15:0];
 
//--------- from mmu-------------------------
assign mmu_pa_vld = mmu_lsu_pa_vld;
assign mmu_ca     = mmu_lsu_ca;
assign mmu_so     = mmu_lsu_so;
assign mmu_buf    = mmu_lsu_buf;
assign mmu_sec    = mmu_lsu_sec;
assign mmu_sh     = mmu_lsu_sh;

assign mmu_page_fault   = mmu_lsu_page_fault;
assign mmu_access_fault = mmu_lsu_access_fault;

assign mmu_pa[`PA_WIDTH-13:0] = mmu_lsu_pa[`PA_WIDTH-13:0];
//--------- from dtif-------------------------
//cmplt/pipe stall
assign dt_stall         = dtif_ag_stall; 
assign dt_cmplt_ready   = dtif_ag_cmplt_ready;
assign dt_fsm_idle      = dtif_ag_fsm_idle;
assign dt_pipedown_mask = dtif_ag_pipedown_mask;

//half info
assign dt_halt_info_up                    = dtif_ag_halt_info_up;
assign dt_halt_info[`TDT_HINFO_WIDTH-1:0] = dtif_ag_halt_info[`TDT_HINFO_WIDTH-1:0];

//other
// &Force("nonport", "dt_trig_en"); @94
assign dt_trig_en = dtif_ag_trig_en;

//--------- from others-------------------------
//from arb
assign ag_dcache_grnt = arb_ag_grant;
//from fwd data
//assign rtu_fwd_vld        = rtu_lsu_wb_fwd_vld;
//assign rtu_fwd_reg[5:0]   = rtu_lsu_wb_fwd_reg[5:0];
//assign rtu_fwd_fls        = rtu_lsu_wb_fwd_fls;
//assign rtu_fwd_data[63:0] = rtu_lsu_wb_fwd_data[63:0];

//other
assign ag_warm_up = ifu_lsu_warm_up;

assign dcache_req_mask = dc_xx_dcache_req_mask;

//internal fwd
assign da_fwd_vld        = da_xx_fwd_vld;
assign da_fwd_reg[5:0]   = da_xx_fwd_dst_reg[5:0];
assign da_fwd_data[63:0] = da_xx_fwd_data[63:0];
//================================================
//        ag_req_buffer
//================================================
//to cut timing,use ag_req_buffer to save request
assign ag_clk_en = ag_gateclk_sel || ag_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_ag_gated_clk"); @121
gated_clk_cell  x_aq_lsu_ag_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ag_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ag_clk_en         ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @122
//          .external_en (1'b0), @123
//          .global_en   (1'b1), @124
//          .module_en   (cp0_lsu_icg_en), @125
//          .local_en    (ag_clk_en), @126
//          .clk_out     (ag_clk)); @127

assign ag_pipe_clk_en = ag_gateclk_sel
                        || ag_warm_up 
                        || ag_req_buffer_expt_ff
                        || ag_req_buffer_vld
                        || ag_req_buffer_vld_rep1;

// &Instance("gated_clk_cell", "x_aq_lsu_ag_pipe_gated_clk"); @135
gated_clk_cell  x_aq_lsu_ag_pipe_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ag_pipe_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ag_pipe_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @136
//          .external_en (1'b0), @137
//          .global_en   (1'b1), @138
//          .module_en   (cp0_lsu_icg_en), @139
//          .local_en    (ag_pipe_clk_en), @140
//          .clk_out     (ag_pipe_clk)); @141

assign ag_req_buffer_create_vld = ag_inst_vld 
                                     && ag_stall
                                  || ag_pipe_unalign_req
                                     && !unalign_cur_state 
                                  || ag_vsplit_start
                                     && !vsplit_finish_once
                                     && !vsplit_on; 

assign ag_req_buffer_create_dp  = ag_dp_sel;

assign ag_pipe_last_inst     = !ag_pipe_vls
                                   && (!ag_pipe_unalign
                                       || ag_pipe_unalign_last)
                               || vsplit_last;

assign ag_req_buffer_pop_vld = ag_req_buffer_vld
                               && !ag_stall
                               && (dt_fsm_idle || dt_cmplt_ready) 
                               && ag_pipe_last_inst;

//for expt flush,should mask cmplt until flush
always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ag_req_buffer_expt_ff <= 1'b0;
  else if (rtu_yy_xx_flush) 
    ag_req_buffer_expt_ff <= 1'b0;
  else if (ag_pipe_cmplt_req && ag_pipe_expt_vld) 
    ag_req_buffer_expt_ff <= 1'b1;
end

always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ag_req_buffer_vld <= 1'b0;
  else if (rtu_yy_xx_flush) 
    ag_req_buffer_vld <= 1'b0;
  else if (ag_req_buffer_create_vld) 
    ag_req_buffer_vld <= 1'b1;
  else if(ag_req_buffer_pop_vld)
    ag_req_buffer_vld <= 1'b0;
end

always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ag_req_buffer_vld_rep1 <= 1'b0;
  else if (rtu_yy_xx_flush) 
    ag_req_buffer_vld_rep1 <= 1'b0;
  else if (ag_req_buffer_create_vld) 
    ag_req_buffer_vld_rep1 <= 1'b1;
  else if(ag_req_buffer_pop_vld)
    ag_req_buffer_vld_rep1 <= 1'b0;
end

always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ag_req_buffer_vld_rep2 <= 1'b0;
  else if (rtu_yy_xx_flush) 
    ag_req_buffer_vld_rep2 <= 1'b0;
  else if (ag_req_buffer_create_vld) 
    ag_req_buffer_vld_rep2 <= 1'b1;
  else if(ag_req_buffer_pop_vld)
    ag_req_buffer_vld_rep2 <= 1'b0;
end

always@(posedge ag_clk)
begin
  if (ag_req_buffer_create_dp || ag_warm_up) begin
     ag_req_buffer_dst0_reg[5:0]    <= ag_dst0_reg[5:0];
     ag_req_buffer_dst1_reg[5:0]    <= ag_dst1_reg[5:0];
     ag_req_buffer_src2_reg[5:0]    <= ag_src2_reg[5:0];
     ag_req_buffer_func[`FUNC_WIDTH-1:0]   <= ag_func[`FUNC_WIDTH-1:0];
     ag_req_buffer_id_split         <= ag_id_split;
     ag_req_buffer_inst_len         <= ag_inst_len;
     ag_req_buffer_src1_imm[7:0]    <= ag_src1_data[7:0];
     ag_req_buffer_pc[15:0]         <= ag_pc[15:0];
     ag_req_buffer_sew[1:0]         <= ag_sew[1:0];
     ag_req_buffer_lmul[1:0]        <= ag_lmul[1:0];
     ag_req_buffer_priv_mode[1:0]   <= ag_priv_mode[1:0];
  end
end
//for src0/src1, address should be unpdated for split
always@(posedge ag_pipe_clk)
begin
  if(split_update_base_en)
     ag_req_buffer_src0_data[63:0]  <= split_update_base[63:0];
  else if(ag_req_buffer_create_dp || ag_warm_up)
     ag_req_buffer_src0_data[63:0]  <= ag_src0_data[63:0];
end

always@(posedge ag_pipe_clk)
begin
  if(split_update_offset_en)
     ag_req_buffer_src1_data[63:0]   <= split_update_offset[63:0];
  else if(ag_req_buffer_create_dp || ag_warm_up) 
     ag_req_buffer_src1_data[63:0]   <= ag_create_offset[63:0];
end

//for st wdata,fwd logic should also be implemented
always@(posedge ag_pipe_clk)
begin
  if (ag_req_buffer_create_dp || ag_warm_up)
  begin
    ag_req_buffer_src2_depd           <= ag_src2_depd_aft_fwd;
    ag_req_buffer_src2_data_ori[63:0] <= ag_src2_data[63:0];
  end
  else if(ag_req_buffer_st_fwd_vld) 
  begin
    ag_req_buffer_src2_depd           <= 1'b0;
    ag_req_buffer_src2_data_ori[63:0] <= ag_req_buffer_st_fwd_data[63:0];
  end
end

//for bkpt trigger, halt info will update
always@(posedge ag_pipe_clk)
begin
  if(ag_req_buffer_create_dp || ag_warm_up) 
     ag_req_buffer_halt_info[`TDT_HINFO_WIDTH-1:0]  <= ag_halt_info[`TDT_HINFO_WIDTH-1:0];
  else if(dt_halt_info_up)
     ag_req_buffer_halt_info[`TDT_HINFO_WIDTH-1:0]  <= dt_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//for t1 trigger
always@(posedge ag_pipe_clk)
begin
  if(dt_halt_info_up && dt_halt_info[`TDT_HINFO_MATCH] && !ag_req_buffer_halt_info[`TDT_HINFO_MATCH] || ag_warm_up)
     ag_req_buffer_tval2[`PA_WIDTH-1:0]  <= ag_pipe_expt_tval[`PA_WIDTH-1:0];
end

//-----------------------------------------------
//  st fwd logic 
//-----------------------------------------------
//ag req fwd data
//assign ag_fwd_rtu = rtu_fwd_vld 
//                    && (ag_src2_reg[5:0] == rtu_fwd_reg[5:0]);

assign ag_fwd_da  = da_fwd_vld
                    && (ag_src2_reg[5:0] == da_fwd_reg[5:0]); 

assign ag_st_fwd_vld  = ag_src2_depd 
                        && ag_fwd_da;

assign ag_st_fwd_data[63:0] =  da_fwd_data[63:0]; 

assign ag_src2_data[63:0] = ag_st_fwd_vld
                            ? ag_st_fwd_data[63:0]
                            : ag_src2_data_ori[63:0];

assign ag_src2_depd_aft_fwd = ag_src2_depd && !ag_st_fwd_vld;  

//ag req buffer fwd data
assign ag_req_buffer_fwd_da  = da_fwd_vld 
                               && (ag_req_buffer_src2_reg[5:0] == da_fwd_reg[5:0]);

assign ag_req_buffer_st_fwd_vld  = ag_req_buffer_vld
                                   && ag_req_buffer_src2_depd 
                                   && ag_req_buffer_fwd_da;

assign ag_req_buffer_st_fwd_data[63:0] = da_fwd_data[63:0]; 

assign ag_req_buffer_src2_data[63:0] = ag_req_buffer_st_fwd_vld
                                       ? ag_req_buffer_st_fwd_data[63:0]
                                       : ag_req_buffer_src2_data_ori[63:0]; 
//-----------------------------------------------
//        pipe arbiter
//-----------------------------------------------
assign ag_pipe_sel = ag_gateclk_sel || ag_req_buffer_vld;

assign ag_pipe_dp_sel = ag_dp_sel || ag_req_buffer_vld;

assign ag_pipe_inst_vld = ag_inst_vld || ag_req_buffer_vld;

// &CombBeg; @317
always @( ag_pc[15:0]
       or ag_req_buffer_inst_len
       or ag_src2_reg[5:0]
       or ag_req_buffer_src1_imm[7:0]
       or ag_src1_data[7:0]
       or ag_sew[1:0]
       or ag_req_buffer_lmul[1:0]
       or ag_lmul[1:0]
       or ag_req_buffer_pc[15:0]
       or ag_src2_data[63:0]
       or ag_req_buffer_id_split
       or ag_req_buffer_dst0_reg[5:0]
       or ag_req_buffer_vld
       or ag_req_buffer_sew[1:0]
       or ag_req_buffer_src2_depd
       or ag_dst0_reg[5:0]
       or ag_req_buffer_src2_reg[5:0]
       or ag_req_buffer_st_fwd_vld
       or ag_halt_info[21:0]
       or ag_req_buffer_src2_data[63:0]
       or ag_req_buffer_dst1_reg[5:0]
       or ag_req_buffer_halt_info[21:0]
       or ag_src2_depd_aft_fwd
       or ag_inst_len
       or ag_priv_mode[1:0]
       or ag_req_buffer_priv_mode[1:0]
       or ag_dst1_reg[5:0]
       or ag_id_split)
begin
  if(ag_req_buffer_vld)
  begin
  ag_pipe_src2_data[63:0]       = ag_req_buffer_src2_data[63:0];
  ag_pipe_dst0_reg[5:0]         = ag_req_buffer_dst0_reg[5:0];
  ag_pipe_dst1_reg[5:0]         = ag_req_buffer_dst1_reg[5:0];
  ag_pipe_src2_reg[5:0]         = ag_req_buffer_src2_reg[5:0];
  ag_pipe_src2_depd             = ag_req_buffer_src2_depd && !ag_req_buffer_st_fwd_vld;
  ag_pipe_id_split              = ag_req_buffer_id_split;
  ag_pipe_inst_len              = ag_req_buffer_inst_len;
  ag_pipe_src1_imm[7:0]         = ag_req_buffer_src1_imm[7:0];
  ag_pipe_halt_info[`TDT_HINFO_WIDTH-1:0] = ag_req_buffer_halt_info[`TDT_HINFO_WIDTH-1:0];
  ag_pipe_pc[15:0]              = ag_req_buffer_pc[15:0];
  ag_pipe_sew[1:0]              = ag_req_buffer_sew[1:0];
  ag_pipe_lmul[1:0]             = ag_req_buffer_lmul[1:0];
  ag_pipe_priv_mode[1:0]        = ag_req_buffer_priv_mode[1:0];
  end
  else
  begin
  ag_pipe_src2_data[63:0]       = ag_src2_data[63:0];
  ag_pipe_dst0_reg[5:0]         = ag_dst0_reg[5:0];
  ag_pipe_dst1_reg[5:0]         = ag_dst1_reg[5:0];
  ag_pipe_src2_reg[5:0]         = ag_src2_reg[5:0];
  ag_pipe_src2_depd             = ag_src2_depd_aft_fwd;
  ag_pipe_id_split              = ag_id_split;
  ag_pipe_inst_len              = ag_inst_len;
  ag_pipe_src1_imm[7:0]         = ag_src1_data[7:0];
  ag_pipe_halt_info[`TDT_HINFO_WIDTH-1:0] = ag_halt_info[`TDT_HINFO_WIDTH-1:0];
  ag_pipe_pc[15:0]              = ag_pc[15:0];
  ag_pipe_sew[1:0]              = ag_sew[1:0];
  ag_pipe_lmul[1:0]             = ag_lmul[1:0];
  ag_pipe_priv_mode[1:0]        = ag_priv_mode[1:0];
  end
// &CombEnd; @350
end

assign ag_pipe_src0_data[63:0]   = ag_req_buffer_vld_rep1
                                   ? ag_req_buffer_src0_data[63:0]
                                   : ag_src0_data[63:0];

assign ag_pipe_func[`FUNC_WIDTH-1:0] = ag_req_buffer_vld_rep1
                                       ? ag_req_buffer_func[`FUNC_WIDTH-1:0]
                                       : ag_func[`FUNC_WIDTH-1:0];

assign ag_pipe_addr_offset[63:0] = ag_req_buffer_vld_rep2
                                   ? ag_req_buffer_src1_data[63:0]
                                   : ag_offset_aft_shift[63:0];

//================================================
//        ag control
//================================================
//-----------------------------------------------
//   decode
//-----------------------------------------------
assign ag_pipe_base_sel        = ag_pipe_sel;

assign ag_pipe_size[1:0]   = ag_pipe_func[3:2];
assign ag_pipe_vls         = 1'b0;
assign ag_pipe_fls         = ag_pipe_func[10];
assign ag_pipe_vls_cmplt   = 1'b0;
assign ag_pipe_vls_cmplt_dp= 1'b0;

//-----------------------------------------------
//   stall 
//-----------------------------------------------
//to cut timing,use different stall here
//for id/ex1 pipe and unalign/vsplit
assign lsu_full_stall = ag_req_buffer_vld;

//ag self stall
assign ag_pipe_tlb_miss = ag_pipe_mmu_req
                          && !mmu_pa_vld;

assign ag_self_stall = ag_pipe_tlb_miss
                       || mcic_ag_stall
                       || dt_stall
                       || vsplit_stall
                       || !ag_dcache_grnt
                       || ag_pipe_ca 
                          && !target_ca_ff;

//for ag pipedown
assign ag_stall = dc_ag_stall
                  || ag_self_stall; 
//-----------------------------------------------
// unalign load/store 
//-----------------------------------------------
//--------------prepare--------------------------
//misalign check
// &CombBeg; @426
always @( ag_addr[2:0]
       or ag_pipe_size[1:0])
begin
  case(ag_pipe_size[1:0])
    HALF : ag_pipe_misalign_unmask = ag_addr[0];
    WORD : ag_pipe_misalign_unmask = |ag_addr[1:0];
    DWORD: ag_pipe_misalign_unmask = |ag_addr[2:0];
    default : ag_pipe_misalign_unmask = 1'b0;
  endcase
// &CombEnd; @433
end

//unalign check,only cross boundary will split
// &CombBeg; @436
always @( ag_pipe_size[1:0])
begin
case(ag_pipe_size[1:0])
  BYTE: ag_pipe_access_size_ori[2:0] = 3'b000;
  HALF: ag_pipe_access_size_ori[2:0] = 3'b001;
  WORD: ag_pipe_access_size_ori[2:0] = 3'b011;
  DWORD:ag_pipe_access_size_ori[2:0] = 3'b111;
  default:ag_pipe_access_size_ori[2:0] = 3'b0;
endcase
// &CombEnd; @444
end

//for timing,use original size judge
assign ag_pipe_va_add_unalign[3:0] = {1'b0,ag_addr[2:0]} + {1'b0,ag_pipe_access_size_ori[2:0]};
assign ag_pipe_boundary_unmask     = ag_pipe_va_add_unalign[3];

assign ag_pipe_unalign_permit = cp0_lsu_mm
                                && ag_pipe_inst_unalign
                                && !ag_pipe_vls;

assign ag_pipe_unalign_req = ag_pipe_inst_vld 
                             && ag_pipe_unalign_permit
                             && ag_pipe_boundary_unmask; 

assign ag_pipe_unalign_req_dp  = ag_pipe_dp_sel
                                 && ag_pipe_unalign_permit 
                                 && ag_pipe_boundary_unmask; 

assign ag_pipe_unalign_fsm_start = ag_pipe_unalign_req
                                   && !ag_stall;

assign ag_pipe_misalign_no_page = ag_pipe_misalign_unmask
                                  && !ag_pipe_inst_dca
                                  && !ag_pipe_unalign_permit;
//--------------FSM--------------------------
parameter UNALIGN_IDLE  = 1'b0;
parameter UNALIGN_SECD  = 1'b1;

always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    unalign_cur_state <= UNALIGN_IDLE;
  else if (rtu_yy_xx_flush)
    unalign_cur_state <= UNALIGN_IDLE;
  else
    unalign_cur_state <= unalign_next_state;
end

// &CombBeg; @487
always @( unalign_cur_state
       or ag_req_buffer_pop_vld
       or ag_pipe_unalign_fsm_start)
begin
  case(unalign_cur_state)
  UNALIGN_IDLE:begin
    if (ag_pipe_unalign_fsm_start)
      unalign_next_state = UNALIGN_SECD;
    else
      unalign_next_state = UNALIGN_IDLE;
  end
  UNALIGN_SECD:begin
    if (ag_req_buffer_pop_vld)
      unalign_next_state = UNALIGN_IDLE;
    else
      unalign_next_state = UNALIGN_SECD;
  end
  default:unalign_next_state = UNALIGN_IDLE;
  endcase
// &CombEnd; @503
end

//for src update

assign unalign_src_up      = ag_pipe_unalign_fsm_start;
//assign unalign_src_up_gate = ag_pipe_unalign_req;

assign unalign_up_offset[63:0] = 64'h8;

assign ag_pipe_unalign      = ag_pipe_unalign_req_dp  || unalign_cur_state;
assign ag_pipe_unalign_last = unalign_cur_state;

//for lsi,when base update,should use 0 as imm
assign ag_pipe_lsi_offset_mask = !(unalign_cur_state
                                   && ag_pipe_func[8]);

assign ag_pipe_src1_imm_aft_mask[7:0] = {8{ag_pipe_lsi_offset_mask}}
                                         & ag_pipe_src1_imm[7:0];
//-----------------------------------------------
// cmplt req 
//-----------------------------------------------
assign normal_cmplt_inst = dt_fsm_idle
                              && (!ag_pipe_unalign
                                    && (!ag_pipe_vls 
                                         || ag_pipe_vls_cmplt)
                                  || ag_pipe_unalign_last)
                           || dt_cmplt_ready;

assign ag_pipe_cmplt_req = ag_pipe_inst_vld 
                           && !ag_stall 
                           && !vsplit_no_inst 
                           && !ag_req_buffer_expt_ff 
                           && (normal_cmplt_inst
                               || ag_pipe_expt_vld);

assign ag_pipe_cmplt_normal = ag_pipe_inst_vld 
                              && !ag_stall 
                              && !vsplit_no_inst 
                              && !ag_req_buffer_expt_ff 
                              && normal_cmplt_inst;

assign ag_pipe_cmplt_dp = ag_pipe_dp_sel
                          && !vsplit_no_inst 
                          && !ag_req_buffer_expt_ff 
                          && (!ag_pipe_vls
                              || ag_pipe_vls_cmplt_dp); 

//================================================
//        ag data path
//================================================
//-----------------------------------------------
// inst decode
//-----------------------------------------------
assign ag_pipe_atomic   = ag_pipe_func[5];
assign ag_pipe_amo      = &ag_pipe_func[5:4];
assign ag_pipe_inst_dca = ag_pipe_func[6];
assign ag_pipe_inst_ld  = !ag_pipe_func[0] && !ag_pipe_inst_dca; 
assign ag_pipe_inst_st  = ag_pipe_func[0];
assign ag_pipe_dca_st   = ag_pipe_inst_dca || ag_pipe_inst_st;
assign ag_pipe_dca_pa   = ag_pipe_inst_dca && ag_pipe_func[3];

assign ag_pipe_unit_stride  = ag_pipe_vls && (ag_pipe_func[13:12] == 2'b0);

assign ag_pipe_inst_unalign = !(ag_pipe_inst_dca || ag_pipe_atomic);

assign ag_pipe_inst_lsi = ag_pipe_func[7];
assign ag_pipe_inst_fof = ag_pipe_func[14];
//-----------------------------------------------
// address generator
//-----------------------------------------------
//for timing,mask src1 before enter request buffer
assign ag_src1_aft_mask[63:0] = {{32{ag_func[9]}} & ag_src1_data[63:32],
                                 {32{ag_func[8]}} & ag_src1_data[31:0]};

// &CombBeg; @581
always @( ag_offset_shift[1:0]
       or ag_src1_aft_mask[63:0])
begin
  case(ag_offset_shift[1:0])
  2'h0: ag_offset_aft_shift[63:0] = ag_src1_aft_mask[63:0]; 
  2'h1: ag_offset_aft_shift[63:0] = {ag_src1_aft_mask[62:0],1'b0}; 
  2'h2: ag_offset_aft_shift[63:0] = {ag_src1_aft_mask[61:0],2'b0}; 
  2'h3: ag_offset_aft_shift[63:0] = {ag_src1_aft_mask[60:0],3'b0}; 
  default: ag_offset_aft_shift[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @589
end

assign ag_create_offset[63:0] = ag_func[11] && ag_func[12]
                                ? ag_src1_data[63:0]
                                : ag_offset_aft_shift[63:0];

assign ag_addr[63:0]   = ({64{ag_pipe_base_sel}} & ag_pipe_src0_data[63:0])
                         + ag_pipe_addr_offset[63:0];

assign ag_pipe_addr[63:0] = unalign_cur_state
                            ? {ag_addr[63:3],3'b0}
                            : ag_addr[63:0];

// &CombBeg; @608
always @( ag_pipe_vls
       or ag_addr[3:0]
       or ag_pipe_size[1:0])
begin
  case({ag_pipe_vls,ag_pipe_size[1:0]})
  {1'b1,HALF}: ag_addr_align[3:0] = {ag_addr[3:1],1'b0}; 
  {1'b1,WORD}: ag_addr_align[3:0] = {ag_addr[3:2],2'b0};
  default:  ag_addr_align[3:0] = ag_addr[3:0];
  endcase
// &CombEnd; @617
end
//-----------------------------------------------
// src update
//-----------------------------------------------
assign split_update_base_en            = unalign_src_up || vsplit_base_up;
assign split_update_offset_en          = unalign_src_up || vsplit_offset_up;
assign split_update_base[63:0]         = ag_addr[63:0];
assign split_update_offset[63:0]       = unalign_src_up
                                         ? unalign_up_offset[63:0]
                                         : vsplit_up_offset[63:0];
//-----------------------------------------------
// cacheable attribute prediction 
//-----------------------------------------------
assign target_ca = ag_pipe_ca;
assign target_up = ag_pipe_dp_sel  
                   && (mmu_pa_vld
                       || !ag_pipe_mmu_req
                           && ag_pipe_ca);
always@(posedge ag_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    target_ca_ff <= 1'b0;
  else if (target_up)
    target_ca_ff <= target_ca;
end
//-----------------------------------------------
// bytes_vld generator 
//-----------------------------------------------
assign ag_pipe_access_size[3:0] = ag_pipe_vls
                                 ? vsplit_access_size[3:0]
                                 : {1'b0,ag_pipe_access_size_ori[2:0]};

// &CombBeg; @652
// &CombEnd; @672
// &CombBeg; @674
// &CombEnd; @694
assign ag_pipe_va_add_access_size[3:0] = {1'b0,ag_addr_align[2:0]} + {1'b0,ag_pipe_access_size[2:0]};

// &CombBeg; @698
always @( ag_addr_align[2:0])
begin
case(ag_addr_align[2:0])
  3'h0:ag_pipe_bytes_vld_high[7:0] = 8'hff;
  3'h1:ag_pipe_bytes_vld_high[7:0] = 8'hfe;
  3'h2:ag_pipe_bytes_vld_high[7:0] = 8'hfc;
  3'h3:ag_pipe_bytes_vld_high[7:0] = 8'hf8;
  3'h4:ag_pipe_bytes_vld_high[7:0] = 8'hf0;
  3'h5:ag_pipe_bytes_vld_high[7:0] = 8'he0;
  3'h6:ag_pipe_bytes_vld_high[7:0] = 8'hc0;
  3'h7:ag_pipe_bytes_vld_high[7:0] = 8'h80;
  default:ag_pipe_bytes_vld_high[7:0] = {8{1'bx}};
endcase
// &CombEnd; @710
end

// &CombBeg; @712
always @( ag_pipe_va_add_access_size[2:0])
begin
case(ag_pipe_va_add_access_size[2:0])
  3'h0:ag_pipe_bytes_vld_low[7:0] = 8'h01;
  3'h1:ag_pipe_bytes_vld_low[7:0] = 8'h03;
  3'h2:ag_pipe_bytes_vld_low[7:0] = 8'h07;
  3'h3:ag_pipe_bytes_vld_low[7:0] = 8'h0f;
  3'h4:ag_pipe_bytes_vld_low[7:0] = 8'h1f;
  3'h5:ag_pipe_bytes_vld_low[7:0] = 8'h3f;
  3'h6:ag_pipe_bytes_vld_low[7:0] = 8'h7f;
  3'h7:ag_pipe_bytes_vld_low[7:0] = 8'hff;
  default:ag_pipe_bytes_vld_low[7:0] = {8{1'bx}};
endcase
// &CombEnd; @724
end

assign ag_pipe_bytes_vld_cross[`LSU_BYTEW-1:0] = ag_pipe_bytes_vld_low[`LSU_BYTEW-1:0]
                                                 & ag_pipe_bytes_vld_high[`LSU_BYTEW-1:0];

assign ag_pipe_bytes_vld_unalign[`LSU_BYTEW-1:0] = ag_pipe_unalign_last
                                                   ? ag_pipe_bytes_vld_low[`LSU_BYTEW-1:0]
                                                   : ag_pipe_bytes_vld_high[`LSU_BYTEW-1:0];

assign ag_pipe_bytes_vld[`LSU_BYTEW-1:0] = ag_pipe_boundary_unmask
                                           ? ag_pipe_bytes_vld_unalign[`LSU_BYTEW-1:0]
                                           : ag_pipe_bytes_vld_cross[`LSU_BYTEW-1:0];
//-----------------------------------------------
// expt and vec generator 
//-----------------------------------------------
assign ag_pipe_misalign_with_page = ag_pipe_inst_vld
                                    && ag_pipe_misalign_unmask
                                    && !ag_pipe_inst_dca
                                    && mmu_pa_vld 
                                    && mmu_so;

assign ag_pipe_access_fault_with_page = ag_pipe_inst_vld
                                        && mmu_pa_vld 
                                        && (mmu_so
                                               && ag_pipe_vls
                                            || !mmu_ca
                                               && ag_pipe_amo);

assign ag_pipe_page_fault   = mmu_pa_vld
                              && mmu_page_fault;
assign ag_pipe_access_fault = mmu_pa_vld
                              && !ag_pipe_inst_dca
                              && mmu_access_fault;

assign ag_pipe_mmu_expt = ag_pipe_page_fault || ag_pipe_access_fault;  

assign ag_pipe_expt_vld_ori = ag_pipe_misalign_no_page
                              ||  ag_pipe_mmu_expt
                              ||  ag_pipe_dt_cancel
                              ||  ag_pipe_misalign_with_page
                              ||  ag_pipe_access_fault_with_page;

assign ag_pipe_fof_not_first = ag_pipe_inst_fof
                               && !ag_pipe_dt_cancel
                               && !first_element_active; 

assign ag_pipe_expt_vld = ag_pipe_expt_vld_ori
                          && !vector_nop
                          && !ag_pipe_fof_not_first;

// &CombBeg; @775
always @( ag_pipe_inst_st
       or ag_pipe_page_fault
       or ag_pipe_access_fault_with_page
       or ag_pipe_access_fault
       or ag_pipe_misalign_no_page
       or ag_pipe_misalign_with_page
       or ag_pipe_atomic)
begin
if(ag_pipe_misalign_no_page && (ag_pipe_atomic || ag_pipe_inst_st))
  ag_pipe_expt_vec[4:0]   = 5'd6;
else if(ag_pipe_misalign_no_page)
  ag_pipe_expt_vec[4:0]   = 5'd4;
else if(ag_pipe_page_fault && (ag_pipe_inst_st || ag_pipe_atomic))
  ag_pipe_expt_vec[4:0]   = 5'd15;
else if(ag_pipe_page_fault)
  ag_pipe_expt_vec[4:0]   = 5'd13;
else if(ag_pipe_access_fault && (ag_pipe_inst_st || ag_pipe_atomic))
  ag_pipe_expt_vec[4:0]   = 5'd7;
else if(ag_pipe_access_fault)
  ag_pipe_expt_vec[4:0]   = 5'd5;
else if(ag_pipe_misalign_with_page && ag_pipe_inst_st)
  ag_pipe_expt_vec[4:0]   = 5'd6;
else if(ag_pipe_misalign_with_page)
  ag_pipe_expt_vec[4:0]   = 5'd4;
else if(ag_pipe_access_fault_with_page && (ag_pipe_inst_st || ag_pipe_atomic))
  ag_pipe_expt_vec[4:0]   = 5'd7;
else if(ag_pipe_access_fault_with_page)
  ag_pipe_expt_vec[4:0]   = 5'd5;
else
  ag_pipe_expt_vec[4:0]   = 5'd0;
// &CombEnd; @798
end
//-----------------------------------------------
//  memory data bkpt 
//-----------------------------------------------
//for simplicity,always use 16 bit bytes_vld
assign access_bytes_vld[7:0] = ag_pipe_vls
                               ? ag_pipe_bytes_vld[7:0] & bytes_vld_vmask[7:0]
                               : ag_pipe_bytes_vld[7:0];

assign ag_pipe_access_bytes_vld[15:0] = ag_pipe_addr[3]
                                        ? {access_bytes_vld[7:0],8'b0}
                                        : {8'b0,access_bytes_vld[7:0]};

//dtu cancel
assign ag_pipe_dt_cancel = ag_pipe_halt_info[`TDT_HINFO_CANCEL];

//tval select
assign ag_pipe_expt_tval[`PA_WIDTH-1:0] = ag_pipe_dt_cancel && ag_pipe_id_split
                                          ? {`PA_WIDTH{1'b0}}
                                          : ag_pipe_addr[`PA_WIDTH-1:0];

//================================================
//        MMU translate
//================================================
//dcache.pa will not request mmu
assign ag_pipe_mmu_req = !ag_pipe_dca_pa && !vsplit_mmu_req_mask;
assign ag_pipe_ca      = mmu_ca || ag_pipe_dca_pa; 

assign ag_pipe_pa[`PA_WIDTH-1:0] = {mmu_pa[`PA_WIDTH-13:0],ag_pipe_addr[11:0]};
//================================================
//        local monitor
//================================================
//assign ag_pipe_sc_pass = ag_pipe_inst_sc
//                         && ag_pipe_ex_pass;
//================================================
//        vector split
//================================================
// &Instance("aq_lsu_vsplit", "x_aq_lsu_vsplit"); @860
// &Instance("aq_lsu_vmask_extract", "x_aq_lsu_vmask_extract"); @862
// &Force("nonport", "ag_pipe_lmul"); @864
assign vsplit_access_size[3:0] = 4'b0;
assign vsplit_no_op   = 1'b1;
assign vsplit_on      = 1'b0;
assign vsplit_stall   = 1'b0;
assign vsplit_no_inst = 1'b0;
assign vsplit_mmu_req_mask = 1'b0;
assign vsplit_part_fwd     = 1'b0;
assign vsplit_acc_cnt[3:0] = 4'b0;
assign vector_nop = 1'b0;

assign ag_vsplit_start       = 1'b0;
assign bytes_vld_vmask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b1}};
assign first_element_active   = 1'b1;
assign first_no_mask_cnt[6:0] = 7'b0;

assign vsplit_base_up   = 1'b0;
assign vsplit_offset_up = 1'b0;
assign vsplit_ele_next_align[7:0] = 8'b0;
assign vsplit_last      = 1'b0;
assign vsplit_round_bit[1:0] = 2'b0;
assign vsplit_sseg_first= 1'b0;
assign vsplit_up_offset[63:0] = 64'b0;
assign vsplit_finish_once = 1'b0;
assign vsplit_pf_mask     = 1'b0;
assign vsplit_amr_hint_size[4:0] = 5'b0;


//-----------------vls st data shift---------------------
// &CombBeg; @894
always @( ag_pipe_vls
       or ag_pipe_sew[1:0]
       or vsplit_part_fwd
       or vsplit_acc_cnt[3:0])
begin
  case({ag_pipe_vls && vsplit_part_fwd,ag_pipe_sew[1:0]})
  {1'b1,BYTE}: wdata_shift_for_vlsu[3:0] = vsplit_acc_cnt[3:0]; 
  {1'b1,HALF}: wdata_shift_for_vlsu[3:0] = {vsplit_acc_cnt[2:0],1'b0};
  {1'b1,WORD}: wdata_shift_for_vlsu[3:0] = {vsplit_acc_cnt[1:0],2'b0};
  default:     wdata_shift_for_vlsu[3:0] = 4'b0;
  endcase
// &CombEnd;  @904
end

//-----------------for pfu/amr--------------------
// &CombBeg; @907
always @( ag_pipe_sew[1:0]
       or ag_pipe_size[1:0])
begin
  case({ag_pipe_size[1:0],ag_pipe_sew[1:0]})
  {BYTE,HALF}: max_access_size[2:0] = 3'b010;
  {BYTE,WORD}: max_access_size[2:0] = 3'b001;
  {HALF,WORD}: max_access_size[2:0] = 3'b010;
  default:     max_access_size[2:0] = 3'b011;
  endcase
// &CombEnd; @923
end

// &CombBeg; @925
always @( ag_addr[3:0]
       or max_access_size[2:0])
begin
  case(max_access_size[2:0])
  3'b001: hint_addr_low[3:0] = {ag_addr[3:1],1'b0};
  3'b010: hint_addr_low[3:0] = {ag_addr[3:2],2'b0};
  3'b011: hint_addr_low[3:0] = {ag_addr[3],3'b0};
  3'b100: hint_addr_low[3:0] = 4'b0;
  default:hint_addr_low[3:0] = ag_addr[3:0];
  endcase
// &CombEnd; @933
end

// &CombBeg; @935
always @( ag_addr[3:0]
       or max_access_size[2:0])
begin
  case(max_access_size[2:0])
  3'b001: vls_unalign = ag_addr[0];
  3'b010: vls_unalign = |ag_addr[1:0];
  3'b011: vls_unalign = |ag_addr[2:0];
  3'b100: vls_unalign = |ag_addr[3:0];
  default:vls_unalign = 1'b0;
  endcase
// &CombEnd; @943
end

//================================================
//        dcache arb
//================================================
assign dcache_tag_req  = ag_pipe_sel && target_ca_ff && !dcache_req_mask;
assign dcache_data_req = ag_pipe_sel && target_ca_ff && (!ag_pipe_dca_st || ag_pipe_amo) && !dcache_req_mask;
//================================================
//        pipedown ctrl
//================================================
assign ag_dc_pipe_mask = ag_pipe_expt_vld
                            && !ag_pipe_vls
                            && !(ag_pipe_inst_ld && ag_pipe_unalign_last)
                         || ag_req_buffer_expt_ff
                            && ag_pipe_unalign_last
                         || dt_pipedown_mask;

//================================================
//        output interface
//================================================
//-----------------------------------------------
// Output to mmu
//-----------------------------------------------
assign lsu_mmu_va_vld   = ag_pipe_dp_sel 
                          && ag_pipe_mmu_req;
assign lsu_mmu_va[51:0] = ag_pipe_addr[63:12];
assign lsu_mmu_st_inst  = ag_pipe_inst_st;
assign lsu_mmu_abort    = rtu_yy_xx_flush;

assign lsu_mmu_priv_mode[1:0] = ag_pipe_priv_mode[1:0];
//-----------------------------------------------
// dcache interface
//-----------------------------------------------
assign ag_arb_tag_req       = dcache_tag_req; 
assign ag_arb_tag_idx[11:0] = ag_pipe_addr[11:0];
assign ag_arb_tag_way[3:0]  = 4'b1111;
assign ag_arb_tag_sel[3:0]  = 4'b1111;

assign ag_arb_data_req       = dcache_data_req;
assign ag_arb_data_way[3:0]  = 4'b1111;
assign ag_arb_data_idx[13:0] = ag_pipe_addr[13:0];

//&Instance("aq_lsu_arb", "x_aq_lsu_arb");

//-----------------------------------------------
// dc pipedown signal
//-----------------------------------------------
//ag info
assign ag_dc_inst_vld            = ag_pipe_inst_vld
                                   && !ag_self_stall
                                   && !vsplit_no_inst
                                   && !ag_dc_pipe_mask;
assign ag_dc_inst_vld_dp         = ag_pipe_dp_sel
                                   && !vsplit_no_inst; 
assign ag_dc_inst_vld_gate       = ag_pipe_sel;
assign ag_dc_addr[`PA_WIDTH-1:4] = ag_pipe_mmu_req
                                   ? ag_pipe_pa[`PA_WIDTH-1:4]
                                   : ag_pipe_addr[`PA_WIDTH-1:4];
assign ag_dc_addr[3:0]           = ag_pipe_unit_stride
                                   ? hint_addr_low[3:0]
                                   : ag_pipe_addr[3:0];
assign ag_dc_bytes_vld[`LSU_BYTEW-1:0] = ag_pipe_vls && ag_pipe_inst_st && !ag_pipe_amo
                                         ? ag_pipe_bytes_vld[`LSU_BYTEW-1:0] & bytes_vld_vmask[`LSU_BYTEW-1:0]
                                         : ag_pipe_bytes_vld[`LSU_BYTEW-1:0];
assign ag_dc_hint_size[4:0]      = ag_pipe_unalign & !ag_pipe_unalign_last
                                   ? 5'h0
                                   : ag_pipe_vls
                                     ? vsplit_amr_hint_size[4:0]
                                     : {1'b0,ag_pipe_access_size[3:0]} + 5'h1;
assign ag_dc_unalign             = ag_pipe_unalign;
assign ag_dc_unalign_last        = ag_pipe_unalign_last;
assign ag_dc_src2_depd           = ag_pipe_src2_depd;
assign ag_dc_virt_idx[1:0]       = ag_pipe_addr[13:12];

//for prefetch
assign ag_dc_inst_pc[15:0]       = ag_pipe_pc[15:0];
assign ag_dc_pf_amr_mask         = ag_pipe_unit_stride && vls_unalign
                                   || ag_pipe_vls && vsplit_pf_mask
                                   || ag_pipe_id_split
                                   || ag_pipe_unalign && !ag_pipe_unalign_last;

//page info
assign ag_dc_buf = mmu_buf || ag_pipe_dca_pa;
assign ag_dc_ca  = ag_pipe_ca;
assign ag_dc_so  = mmu_so  && !ag_pipe_dca_pa;
assign ag_dc_sh  = mmu_sh  || ag_pipe_dca_pa; 
assign ag_dc_sec = mmu_sec && !ag_pipe_dca_pa;

assign ag_dc_priv_mode[1:0] = ag_pipe_priv_mode[1:0];

//decd info
assign ag_dc_func[`FUNC_WIDTH-1:0] = ag_pipe_func[`FUNC_WIDTH-1:0];
assign ag_dc_dest_reg[5:0] = ag_pipe_dst0_reg[5:0];
assign ag_dc_src2_reg[5:0] = ag_pipe_src2_reg[5:0];
assign ag_dc_st_data[63:0] = ag_pipe_src2_data[63:0];

assign ag_dc_data_shift[3:0] = ag_addr[3:0];

//-----------------vector--------------------------------------- 
assign ag_dc_sew[1:0] = ag_pipe_sew[1:0];
assign ag_dc_vec_nop  = vector_nop || ag_pipe_expt_vld_ori || ag_req_buffer_expt_ff;

assign ag_dc_vlsu_wdata_shift[3:0] = wdata_shift_for_vlsu[3:0];

//for fof or expt
// &Force("output", "ag_dc_expt_vld"); @1071
assign ag_dc_expt_vld  = ag_pipe_vls 
                            && !ag_req_buffer_expt_ff 
                            && ag_pipe_expt_vld
                         || ag_pipe_unalign_last
                            && ag_pipe_inst_ld
                            && ag_pipe_expt_vld;
assign ag_dc_vlsu_vl_update = ag_pipe_expt_vld_ori
                              && !ag_req_buffer_expt_ff 
                              && ag_pipe_fof_not_first
                              && !vector_nop;

assign ag_dc_vlsu_vl_upval[6:0] = first_no_mask_cnt[6:0];

assign ag_dc_vlsu_split_last = vsplit_last;

//for check vlsu buffer
assign ag_dc_vlsu_split_cnt[9:0] = {vsplit_round_bit[1:0],vsplit_ele_next_align[7:0]}; 
assign ag_dc_vlsu_sseg_first     = vsplit_sseg_first; 


//for zvamo
assign ag_dc_amo_func[4:0] = ag_pipe_src1_imm[4:0];

//-----------------------------------------------
// output to rtu
//-----------------------------------------------
//----------fast cmplt to rtu----------
assign lsu_rtu_ex1_cmplt         = ag_pipe_cmplt_req;
assign lsu_rtu_ex1_cmplt_for_pcgen = ag_pipe_cmplt_normal;
assign lsu_rtu_ex1_cmplt_dp      = ag_pipe_cmplt_dp;
assign lsu_rtu_ex1_inst_split    = ag_pipe_id_split;
assign lsu_rtu_ex1_inst_len      = ag_pipe_inst_len;

assign lsu_rtu_ex1_expt_vld      = ag_pipe_expt_vld;
assign lsu_rtu_ex1_expt_vec[4:0] = ag_pipe_expt_vec[4:0];

//assign lsu_rtu_ex1_inst_ld                  = ag_pipe_inst_ld;
assign lsu_rtu_ex1_expt_tval[`PA_WIDTH-1:0] = ag_pipe_expt_tval[`PA_WIDTH-1:0];

//for timing,t1 mtval will select in ex2
assign lsu_rtu_ex1_tval2_vld            = !ag_pipe_expt_vld;
assign lsu_rtu_ex2_tval2[`PA_WIDTH-1:0] = ag_req_buffer_tval2[`PA_WIDTH-1:0]; 

//for fence
assign lsu_rtu_ex1_buffer_vld    = ag_req_buffer_vld;

//vector
assign lsu_rtu_ex1_vstart_vld  = ag_pipe_dp_sel && ag_pipe_vls;
assign lsu_rtu_ex1_vstart[6:0] = first_no_mask_cnt[6:0];

//bkpt
assign lsu_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] = ag_pipe_halt_info[`TDT_HINFO_WIDTH-1:0];

//fs/vs
assign lsu_rtu_ex1_fs_dirty = ag_pipe_func[10]
                              && !ag_pipe_func[0];

assign lsu_rtu_ex1_vs_dirty = ag_pipe_func[11]
                              && (ag_pipe_amo
                                     && !ag_pipe_func[15] //zvamo with wd=1
                                  || !ag_pipe_func[0]);

//-----------------------------------------------
// feed back to idu
//-----------------------------------------------
//id stall
assign lsu_idu_full = lsu_full_stall; 

//global stall,when not commit
assign lsu_idu_global_full = ag_req_buffer_vld
                             && vsplit_no_op;
//-----------------------------------------------
//  lsi iu control
//-----------------------------------------------
assign lsu_iu_ex1_lsi_sel = ag_pipe_inst_vld
                            && !ag_req_buffer_expt_ff
                            && !ag_stall
                            && (!ag_pipe_unalign
                                || ag_pipe_unalign_last)
                            && ag_pipe_inst_lsi;

assign lsu_iu_ex1_lsi_dp  = ag_pipe_dp_sel
                            && !ag_req_buffer_expt_ff
                            && ag_pipe_inst_lsi;

assign lsu_iu_ex1_lsi_src0[63:0]   = ag_pipe_src0_data[63:0];
assign lsu_iu_ex1_lsi_imm[63:0]    = {{56{ag_pipe_src1_imm_aft_mask[7]}},ag_pipe_src1_imm_aft_mask[7:0]};
assign lsu_iu_ex1_lsi_dst_reg[5:0] = ag_pipe_dst1_reg[5:0];

//for timing,add another adder for lsi
assign lsu_rtu_ex1_wb_dp         = lsu_iu_ex1_lsi_dp;
assign lsu_rtu_ex1_wb_vld        = lsu_iu_ex1_lsi_sel && !ag_pipe_expt_vld_ori;
assign lsu_rtu_ex1_dest_reg[5:0] = lsu_iu_ex1_lsi_dst_reg[5:0];
assign lsu_rtu_ex1_data[63:0]    = lsu_iu_ex1_lsi_src0[63:0] + lsu_iu_ex1_lsi_imm[63:0];

//-----------------------------------------------
// Output to DT interface
//-----------------------------------------------
//req info
assign ag_dtu_req                 = ag_pipe_inst_vld
                                    && !vsplit_no_inst 
                                    && !ag_req_buffer_expt_ff 
                                    && !ag_pipe_inst_dca; 
assign ag_dtu_req_gate            = ag_pipe_sel
                                    && !vsplit_no_inst 
                                    && !ag_req_buffer_expt_ff 
                                    && !ag_pipe_inst_dca; 
assign ag_dtu_addr_ready          = !vsplit_stall;
assign ag_dtu_data_vld            = ag_pipe_inst_vld
                                    && ag_pipe_inst_st
                                    && !ag_pipe_amo
                                    && !(ag_pipe_vls || ag_pipe_fls)
                                    && !ag_pipe_src2_depd;
assign ag_dtu_addr[`PA_WIDTH-1:0] = ag_pipe_addr[`PA_WIDTH-1:0];
assign ag_dtu_bytes_vld[15:0]     = ag_pipe_access_bytes_vld[15:0];
assign ag_dtu_data[63:0]          = ag_pipe_src2_data[63:0];

assign ag_dtu_halt_info[`TDT_HINFO_WIDTH-1:0] = ag_pipe_halt_info[`TDT_HINFO_WIDTH-1:0];

//lsu inst info
assign ag_dtu_st_type              = ag_pipe_inst_st && !ag_pipe_amo;
assign ag_dtu_amo_type             = 1'b0;
assign ag_dtu_mem_access_size[2:0] = ag_pipe_vls
                                     ? 3'b100
                                     : {1'b0,ag_pipe_size[1:0]};
assign ag_dtu_split_last           = ag_pipe_last_inst;
assign ag_dtu_data_chk_mask        = ag_pipe_vls 
                                     || ag_pipe_unalign && ag_pipe_inst_ld && !ag_pipe_unalign_last
                                     || ag_pipe_unalign_last && ag_pipe_inst_st;
                                     
//cmplt and pipe info
assign ag_dtu_pipe_down  = ag_req_buffer_vld
                           && !ag_self_stall
                           && !dc_ag_stall;

//-----------------------------------------------
// Output to others
//-----------------------------------------------
//----------lsu top----------
//for vector split
assign ag_xx_no_op = !vsplit_on;
//----------pmu----------
assign ag_inst_store = ag_pipe_cmplt_normal && ag_pipe_inst_st;
//----------debug info----------
assign ag_dbginfo[7:0] = {ag_req_buffer_src2_depd,ag_pipe_func[3:0],vsplit_no_op,unalign_cur_state,ag_req_buffer_vld};


// &ModuleEnd; @1246
endmodule


