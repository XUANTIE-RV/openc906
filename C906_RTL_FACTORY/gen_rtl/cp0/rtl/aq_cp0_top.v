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

// &ModuleBeg; @23
module aq_cp0_top(
  biu_cp0_coreid,
  biu_cp0_me_int,
  biu_cp0_ms_int,
  biu_cp0_mt_int,
  biu_cp0_rvba,
  biu_cp0_se_int,
  biu_cp0_ss_int,
  biu_cp0_st_int,
  cp0_biu_icg_en,
  cp0_biu_lpmd_b,
  cp0_dtu_addr,
  cp0_dtu_debug_info,
  cp0_dtu_icg_en,
  cp0_dtu_mexpt_vld,
  cp0_dtu_pcfifo_frz,
  cp0_dtu_rreg,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_dtu_wreg,
  cp0_hpcp_icg_en,
  cp0_hpcp_index,
  cp0_hpcp_int_off_vld,
  cp0_hpcp_mcntwen,
  cp0_hpcp_pmdm,
  cp0_hpcp_pmds,
  cp0_hpcp_pmdu,
  cp0_hpcp_sync_stall_vld,
  cp0_hpcp_wdata,
  cp0_hpcp_wreg,
  cp0_idu_cskyee,
  cp0_idu_dis_fence_in_dbg,
  cp0_idu_frm,
  cp0_idu_fs,
  cp0_idu_icg_en,
  cp0_idu_issue_stall,
  cp0_idu_ucme,
  cp0_idu_vill,
  cp0_idu_vl_zero,
  cp0_idu_vlmul,
  cp0_idu_vs,
  cp0_idu_vsetvl_dis_stall,
  cp0_idu_vsew,
  cp0_idu_vstart,
  cp0_ifu_bht_en,
  cp0_ifu_bht_inv,
  cp0_ifu_btb_clr,
  cp0_ifu_btb_en,
  cp0_ifu_icache_en,
  cp0_ifu_icache_inv_addr,
  cp0_ifu_icache_inv_req,
  cp0_ifu_icache_inv_type,
  cp0_ifu_icache_pref_en,
  cp0_ifu_icache_read_index,
  cp0_ifu_icache_read_req,
  cp0_ifu_icache_read_tag,
  cp0_ifu_icache_read_way,
  cp0_ifu_icg_en,
  cp0_ifu_in_lpmd,
  cp0_ifu_iwpe,
  cp0_ifu_lpmd_req,
  cp0_ifu_ras_en,
  cp0_ifu_rst_inv_done,
  cp0_iu_icg_en,
  cp0_lsu_amr,
  cp0_lsu_dcache_en,
  cp0_lsu_dcache_pref_dist,
  cp0_lsu_dcache_pref_en,
  cp0_lsu_dcache_read_idx,
  cp0_lsu_dcache_read_req,
  cp0_lsu_dcache_read_type,
  cp0_lsu_dcache_read_way,
  cp0_lsu_dcache_wa,
  cp0_lsu_dcache_wb,
  cp0_lsu_fence_req,
  cp0_lsu_icc_addr,
  cp0_lsu_icc_op,
  cp0_lsu_icc_req,
  cp0_lsu_icc_type,
  cp0_lsu_icg_en,
  cp0_lsu_mm,
  cp0_lsu_mpp,
  cp0_lsu_mprv,
  cp0_lsu_sync_req,
  cp0_lsu_we_en,
  cp0_mmu_addr,
  cp0_mmu_icg_en,
  cp0_mmu_lpmd_req,
  cp0_mmu_maee,
  cp0_mmu_mxr,
  cp0_mmu_ptw_en,
  cp0_mmu_satp_data,
  cp0_mmu_satp_wen,
  cp0_mmu_sum,
  cp0_mmu_tlb_all_inv,
  cp0_mmu_tlb_asid,
  cp0_mmu_tlb_asid_all_inv,
  cp0_mmu_tlb_va,
  cp0_mmu_tlb_va_all_inv,
  cp0_mmu_tlb_va_asid_inv,
  cp0_mmu_wdata,
  cp0_mmu_wreg,
  cp0_pmp_addr,
  cp0_pmp_icg_en,
  cp0_pmp_wdata,
  cp0_pmp_wreg,
  cp0_rtu_ex1_chgflw,
  cp0_rtu_ex1_chgflw_pc,
  cp0_rtu_ex1_cmplt,
  cp0_rtu_ex1_cmplt_dp,
  cp0_rtu_ex1_expt_tval,
  cp0_rtu_ex1_expt_vec,
  cp0_rtu_ex1_expt_vld,
  cp0_rtu_ex1_flush,
  cp0_rtu_ex1_halt_info,
  cp0_rtu_ex1_inst_dret,
  cp0_rtu_ex1_inst_ebreak,
  cp0_rtu_ex1_inst_len,
  cp0_rtu_ex1_inst_mret,
  cp0_rtu_ex1_inst_split,
  cp0_rtu_ex1_inst_sret,
  cp0_rtu_ex1_vs_dirty,
  cp0_rtu_ex1_vs_dirty_dp,
  cp0_rtu_ex1_wb_data,
  cp0_rtu_ex1_wb_dp,
  cp0_rtu_ex1_wb_preg,
  cp0_rtu_ex1_wb_vld,
  cp0_rtu_fence_idle,
  cp0_rtu_icg_en,
  cp0_rtu_in_lpmd,
  cp0_rtu_int_vld,
  cp0_rtu_trap_pc,
  cp0_rtu_vstart_eq_0,
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_vpu_xx_rm,
  cp0_xx_mrvbr,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  dtu_cp0_dcsr_mprven,
  dtu_cp0_dcsr_prv,
  dtu_cp0_rdata,
  dtu_cp0_wake_up,
  forever_cpuclk,
  hpcp_cp0_data,
  hpcp_cp0_int_vld,
  hpcp_cp0_sce,
  idu_cp0_ex1_dp_sel,
  idu_cp0_ex1_dst0_reg,
  idu_cp0_ex1_expt_acc_error,
  idu_cp0_ex1_expt_high,
  idu_cp0_ex1_expt_illegal,
  idu_cp0_ex1_expt_page_fault,
  idu_cp0_ex1_func,
  idu_cp0_ex1_gateclk_sel,
  idu_cp0_ex1_halt_info,
  idu_cp0_ex1_length,
  idu_cp0_ex1_opcode,
  idu_cp0_ex1_sel,
  idu_cp0_ex1_split,
  idu_cp0_ex1_src0_data,
  idu_cp0_ex1_src1_data,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_icache_read_data,
  ifu_cp0_icache_read_data_vld,
  ifu_cp0_rst_inv_req,
  ifu_cp0_warm_up,
  ifu_yy_xx_no_op,
  iu_cp0_ex1_cur_pc,
  lsu_cp0_dcache_read_data,
  lsu_cp0_dcache_read_data_vld,
  lsu_cp0_fence_ack,
  lsu_cp0_icc_done,
  lsu_cp0_sync_ack,
  mmu_cp0_cmplt,
  mmu_cp0_data,
  mmu_cp0_tlb_inv_done,
  mmu_yy_xx_no_op,
  pad_yy_icg_scan_en,
  pmp_cp0_data,
  rtu_cp0_epc,
  rtu_cp0_exit_debug,
  rtu_cp0_fflags,
  rtu_cp0_fflags_updt,
  rtu_cp0_fs_dirty_updt,
  rtu_cp0_fs_dirty_updt_dp,
  rtu_cp0_tval,
  rtu_cp0_vl,
  rtu_cp0_vl_vld,
  rtu_cp0_vs_dirty_updt,
  rtu_cp0_vs_dirty_updt_dp,
  rtu_cp0_vstart,
  rtu_cp0_vstart_vld,
  rtu_cp0_vxsat,
  rtu_cp0_vxsat_vld,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  rtu_yy_xx_flush,
  sysio_cp0_apb_base,
  vidu_cp0_vid_fof_vld
);


// &Ports; @25
input   [2  :0]  biu_cp0_coreid;               
input            biu_cp0_me_int;               
input            biu_cp0_ms_int;               
input            biu_cp0_mt_int;               
input   [39 :0]  biu_cp0_rvba;                 
input            biu_cp0_se_int;               
input            biu_cp0_ss_int;               
input            biu_cp0_st_int;               
input            cpurst_b;                     
input            dtu_cp0_dcsr_mprven;          
input   [1  :0]  dtu_cp0_dcsr_prv;             
input   [63 :0]  dtu_cp0_rdata;                
input            dtu_cp0_wake_up;              
input            forever_cpuclk;               
input   [63 :0]  hpcp_cp0_data;                
input            hpcp_cp0_int_vld;             
input            hpcp_cp0_sce;                 
input            idu_cp0_ex1_dp_sel;           
input   [5  :0]  idu_cp0_ex1_dst0_reg;         
input            idu_cp0_ex1_expt_acc_error;   
input            idu_cp0_ex1_expt_high;        
input            idu_cp0_ex1_expt_illegal;     
input            idu_cp0_ex1_expt_page_fault;  
input   [19 :0]  idu_cp0_ex1_func;             
input            idu_cp0_ex1_gateclk_sel;      
input   [21 :0]  idu_cp0_ex1_halt_info;        
input            idu_cp0_ex1_length;           
input   [31 :0]  idu_cp0_ex1_opcode;           
input            idu_cp0_ex1_sel;              
input            idu_cp0_ex1_split;            
input   [63 :0]  idu_cp0_ex1_src0_data;        
input   [63 :0]  idu_cp0_ex1_src1_data;        
input            ifu_cp0_bht_inv_done;         
input            ifu_cp0_icache_inv_done;      
input   [127:0]  ifu_cp0_icache_read_data;     
input            ifu_cp0_icache_read_data_vld; 
input            ifu_cp0_rst_inv_req;          
input            ifu_cp0_warm_up;              
input            ifu_yy_xx_no_op;              
input   [39 :0]  iu_cp0_ex1_cur_pc;            
input   [127:0]  lsu_cp0_dcache_read_data;     
input            lsu_cp0_dcache_read_data_vld; 
input            lsu_cp0_fence_ack;            
input            lsu_cp0_icc_done;             
input            lsu_cp0_sync_ack;             
input            mmu_cp0_cmplt;                
input   [63 :0]  mmu_cp0_data;                 
input            mmu_cp0_tlb_inv_done;         
input            mmu_yy_xx_no_op;              
input            pad_yy_icg_scan_en;           
input   [63 :0]  pmp_cp0_data;                 
input   [63 :0]  rtu_cp0_epc;                  
input            rtu_cp0_exit_debug;           
input   [4  :0]  rtu_cp0_fflags;               
input            rtu_cp0_fflags_updt;          
input            rtu_cp0_fs_dirty_updt;        
input            rtu_cp0_fs_dirty_updt_dp;     
input   [63 :0]  rtu_cp0_tval;                 
input   [7  :0]  rtu_cp0_vl;                   
input            rtu_cp0_vl_vld;               
input            rtu_cp0_vs_dirty_updt;        
input            rtu_cp0_vs_dirty_updt_dp;     
input   [6  :0]  rtu_cp0_vstart;               
input            rtu_cp0_vstart_vld;           
input            rtu_cp0_vxsat;                
input            rtu_cp0_vxsat_vld;            
input            rtu_yy_xx_dbgon;              
input            rtu_yy_xx_expt_int;           
input   [4  :0]  rtu_yy_xx_expt_vec;           
input            rtu_yy_xx_expt_vld;           
input            rtu_yy_xx_flush;              
input   [39 :0]  sysio_cp0_apb_base;           
input            vidu_cp0_vid_fof_vld;         
output           cp0_biu_icg_en;               
output  [1  :0]  cp0_biu_lpmd_b;               
output  [11 :0]  cp0_dtu_addr;                 
output  [5  :0]  cp0_dtu_debug_info;           
output           cp0_dtu_icg_en;               
output           cp0_dtu_mexpt_vld;            
output           cp0_dtu_pcfifo_frz;           
output           cp0_dtu_rreg;                 
output  [63 :0]  cp0_dtu_satp;                 
output  [63 :0]  cp0_dtu_wdata;                
output           cp0_dtu_wreg;                 
output           cp0_hpcp_icg_en;              
output  [11 :0]  cp0_hpcp_index;               
output           cp0_hpcp_int_off_vld;         
output  [31 :0]  cp0_hpcp_mcntwen;             
output           cp0_hpcp_pmdm;                
output           cp0_hpcp_pmds;                
output           cp0_hpcp_pmdu;                
output           cp0_hpcp_sync_stall_vld;      
output  [63 :0]  cp0_hpcp_wdata;               
output           cp0_hpcp_wreg;                
output           cp0_idu_cskyee;               
output           cp0_idu_dis_fence_in_dbg;     
output  [2  :0]  cp0_idu_frm;                  
output  [1  :0]  cp0_idu_fs;                   
output           cp0_idu_icg_en;               
output           cp0_idu_issue_stall;          
output           cp0_idu_ucme;                 
output           cp0_idu_vill;                 
output           cp0_idu_vl_zero;              
output  [1  :0]  cp0_idu_vlmul;                
output  [1  :0]  cp0_idu_vs;                   
output           cp0_idu_vsetvl_dis_stall;     
output  [1  :0]  cp0_idu_vsew;                 
output  [6  :0]  cp0_idu_vstart;               
output           cp0_ifu_bht_en;               
output           cp0_ifu_bht_inv;              
output           cp0_ifu_btb_clr;              
output           cp0_ifu_btb_en;               
output           cp0_ifu_icache_en;            
output  [63 :0]  cp0_ifu_icache_inv_addr;      
output           cp0_ifu_icache_inv_req;       
output  [1  :0]  cp0_ifu_icache_inv_type;      
output           cp0_ifu_icache_pref_en;       
output  [13 :0]  cp0_ifu_icache_read_index;    
output           cp0_ifu_icache_read_req;      
output           cp0_ifu_icache_read_tag;      
output           cp0_ifu_icache_read_way;      
output           cp0_ifu_icg_en;               
output           cp0_ifu_in_lpmd;              
output           cp0_ifu_iwpe;                 
output           cp0_ifu_lpmd_req;             
output           cp0_ifu_ras_en;               
output           cp0_ifu_rst_inv_done;         
output           cp0_iu_icg_en;                
output  [1  :0]  cp0_lsu_amr;                  
output           cp0_lsu_dcache_en;            
output  [1  :0]  cp0_lsu_dcache_pref_dist;     
output           cp0_lsu_dcache_pref_en;       
output  [16 :0]  cp0_lsu_dcache_read_idx;      
output           cp0_lsu_dcache_read_req;      
output           cp0_lsu_dcache_read_type;     
output  [1  :0]  cp0_lsu_dcache_read_way;      
output           cp0_lsu_dcache_wa;            
output           cp0_lsu_dcache_wb;            
output           cp0_lsu_fence_req;            
output  [63 :0]  cp0_lsu_icc_addr;             
output  [1  :0]  cp0_lsu_icc_op;               
output           cp0_lsu_icc_req;              
output  [1  :0]  cp0_lsu_icc_type;             
output           cp0_lsu_icg_en;               
output           cp0_lsu_mm;                   
output  [1  :0]  cp0_lsu_mpp;                  
output           cp0_lsu_mprv;                 
output           cp0_lsu_sync_req;             
output           cp0_lsu_we_en;                
output  [11 :0]  cp0_mmu_addr;                 
output           cp0_mmu_icg_en;               
output           cp0_mmu_lpmd_req;             
output           cp0_mmu_maee;                 
output           cp0_mmu_mxr;                  
output           cp0_mmu_ptw_en;               
output  [63 :0]  cp0_mmu_satp_data;            
output           cp0_mmu_satp_wen;             
output           cp0_mmu_sum;                  
output           cp0_mmu_tlb_all_inv;          
output  [15 :0]  cp0_mmu_tlb_asid;             
output           cp0_mmu_tlb_asid_all_inv;     
output  [26 :0]  cp0_mmu_tlb_va;               
output           cp0_mmu_tlb_va_all_inv;       
output           cp0_mmu_tlb_va_asid_inv;      
output  [63 :0]  cp0_mmu_wdata;                
output           cp0_mmu_wreg;                 
output  [11 :0]  cp0_pmp_addr;                 
output           cp0_pmp_icg_en;               
output  [63 :0]  cp0_pmp_wdata;                
output           cp0_pmp_wreg;                 
output           cp0_rtu_ex1_chgflw;           
output  [39 :0]  cp0_rtu_ex1_chgflw_pc;        
output           cp0_rtu_ex1_cmplt;            
output           cp0_rtu_ex1_cmplt_dp;         
output  [39 :0]  cp0_rtu_ex1_expt_tval;        
output  [4  :0]  cp0_rtu_ex1_expt_vec;         
output           cp0_rtu_ex1_expt_vld;         
output           cp0_rtu_ex1_flush;            
output  [21 :0]  cp0_rtu_ex1_halt_info;        
output           cp0_rtu_ex1_inst_dret;        
output           cp0_rtu_ex1_inst_ebreak;      
output           cp0_rtu_ex1_inst_len;         
output           cp0_rtu_ex1_inst_mret;        
output           cp0_rtu_ex1_inst_split;       
output           cp0_rtu_ex1_inst_sret;        
output           cp0_rtu_ex1_vs_dirty;         
output           cp0_rtu_ex1_vs_dirty_dp;      
output  [63 :0]  cp0_rtu_ex1_wb_data;          
output           cp0_rtu_ex1_wb_dp;            
output  [5  :0]  cp0_rtu_ex1_wb_preg;          
output           cp0_rtu_ex1_wb_vld;           
output           cp0_rtu_fence_idle;           
output           cp0_rtu_icg_en;               
output           cp0_rtu_in_lpmd;              
output  [14 :0]  cp0_rtu_int_vld;              
output  [39 :0]  cp0_rtu_trap_pc;              
output           cp0_rtu_vstart_eq_0;          
output           cp0_vpu_icg_en;               
output           cp0_vpu_xx_bf16;              
output           cp0_vpu_xx_dqnan;             
output  [2  :0]  cp0_vpu_xx_rm;                
output  [39 :0]  cp0_xx_mrvbr;                 
output           cp0_yy_clk_en;                
output  [1  :0]  cp0_yy_priv_mode;             

// &Regs; @26

// &Wires; @27
wire    [2  :0]  biu_cp0_coreid;               
wire             biu_cp0_me_int;               
wire             biu_cp0_ms_int;               
wire             biu_cp0_mt_int;               
wire    [39 :0]  biu_cp0_rvba;                 
wire             biu_cp0_se_int;               
wire             biu_cp0_ss_int;               
wire             biu_cp0_st_int;               
wire             cp0_biu_icg_en;               
wire    [1  :0]  cp0_biu_lpmd_b;               
wire    [11 :0]  cp0_dtu_addr;                 
wire    [5  :0]  cp0_dtu_debug_info;           
wire             cp0_dtu_icg_en;               
wire             cp0_dtu_mexpt_vld;            
wire             cp0_dtu_pcfifo_frz;           
wire             cp0_dtu_rreg;                 
wire    [63 :0]  cp0_dtu_satp;                 
wire    [63 :0]  cp0_dtu_wdata;                
wire             cp0_dtu_wreg;                 
wire             cp0_hpcp_icg_en;              
wire    [11 :0]  cp0_hpcp_index;               
wire             cp0_hpcp_int_off_vld;         
wire    [31 :0]  cp0_hpcp_mcntwen;             
wire             cp0_hpcp_pmdm;                
wire             cp0_hpcp_pmds;                
wire             cp0_hpcp_pmdu;                
wire             cp0_hpcp_sync_stall_vld;      
wire    [63 :0]  cp0_hpcp_wdata;               
wire             cp0_hpcp_wreg;                
wire             cp0_idu_cskyee;               
wire             cp0_idu_dis_fence_in_dbg;     
wire    [2  :0]  cp0_idu_frm;                  
wire    [1  :0]  cp0_idu_fs;                   
wire             cp0_idu_icg_en;               
wire             cp0_idu_issue_stall;          
wire             cp0_idu_ucme;                 
wire             cp0_idu_vill;                 
wire             cp0_idu_vl_zero;              
wire    [1  :0]  cp0_idu_vlmul;                
wire    [1  :0]  cp0_idu_vs;                   
wire             cp0_idu_vsetvl_dis_stall;     
wire    [1  :0]  cp0_idu_vsew;                 
wire    [6  :0]  cp0_idu_vstart;               
wire             cp0_ifu_bht_en;               
wire             cp0_ifu_bht_inv;              
wire             cp0_ifu_btb_clr;              
wire             cp0_ifu_btb_en;               
wire             cp0_ifu_icache_en;            
wire    [63 :0]  cp0_ifu_icache_inv_addr;      
wire             cp0_ifu_icache_inv_req;       
wire    [1  :0]  cp0_ifu_icache_inv_type;      
wire             cp0_ifu_icache_pref_en;       
wire    [13 :0]  cp0_ifu_icache_read_index;    
wire             cp0_ifu_icache_read_req;      
wire             cp0_ifu_icache_read_tag;      
wire             cp0_ifu_icache_read_way;      
wire             cp0_ifu_icg_en;               
wire             cp0_ifu_in_lpmd;              
wire             cp0_ifu_iwpe;                 
wire             cp0_ifu_lpmd_req;             
wire             cp0_ifu_ras_en;               
wire             cp0_ifu_rst_inv_done;         
wire             cp0_iu_icg_en;                
wire    [1  :0]  cp0_lsu_amr;                  
wire             cp0_lsu_dcache_en;            
wire    [1  :0]  cp0_lsu_dcache_pref_dist;     
wire             cp0_lsu_dcache_pref_en;       
wire    [16 :0]  cp0_lsu_dcache_read_idx;      
wire             cp0_lsu_dcache_read_req;      
wire             cp0_lsu_dcache_read_type;     
wire    [1  :0]  cp0_lsu_dcache_read_way;      
wire             cp0_lsu_dcache_wa;            
wire             cp0_lsu_dcache_wb;            
wire             cp0_lsu_fence_req;            
wire    [63 :0]  cp0_lsu_icc_addr;             
wire    [1  :0]  cp0_lsu_icc_op;               
wire             cp0_lsu_icc_req;              
wire    [1  :0]  cp0_lsu_icc_type;             
wire             cp0_lsu_icg_en;               
wire             cp0_lsu_mm;                   
wire    [1  :0]  cp0_lsu_mpp;                  
wire             cp0_lsu_mprv;                 
wire             cp0_lsu_sync_req;             
wire             cp0_lsu_we_en;                
wire    [11 :0]  cp0_mmu_addr;                 
wire             cp0_mmu_icg_en;               
wire             cp0_mmu_lpmd_req;             
wire             cp0_mmu_maee;                 
wire             cp0_mmu_mxr;                  
wire             cp0_mmu_ptw_en;               
wire    [63 :0]  cp0_mmu_satp_data;            
wire             cp0_mmu_satp_wen;             
wire             cp0_mmu_sum;                  
wire             cp0_mmu_tlb_all_inv;          
wire    [15 :0]  cp0_mmu_tlb_asid;             
wire             cp0_mmu_tlb_asid_all_inv;     
wire    [26 :0]  cp0_mmu_tlb_va;               
wire             cp0_mmu_tlb_va_all_inv;       
wire             cp0_mmu_tlb_va_asid_inv;      
wire    [63 :0]  cp0_mmu_wdata;                
wire             cp0_mmu_wreg;                 
wire    [11 :0]  cp0_pmp_addr;                 
wire             cp0_pmp_icg_en;               
wire    [63 :0]  cp0_pmp_wdata;                
wire             cp0_pmp_wreg;                 
wire             cp0_rtu_ex1_chgflw;           
wire    [39 :0]  cp0_rtu_ex1_chgflw_pc;        
wire             cp0_rtu_ex1_cmplt;            
wire             cp0_rtu_ex1_cmplt_dp;         
wire    [39 :0]  cp0_rtu_ex1_expt_tval;        
wire    [4  :0]  cp0_rtu_ex1_expt_vec;         
wire             cp0_rtu_ex1_expt_vld;         
wire             cp0_rtu_ex1_flush;            
wire    [21 :0]  cp0_rtu_ex1_halt_info;        
wire             cp0_rtu_ex1_inst_dret;        
wire             cp0_rtu_ex1_inst_ebreak;      
wire             cp0_rtu_ex1_inst_len;         
wire             cp0_rtu_ex1_inst_mret;        
wire             cp0_rtu_ex1_inst_split;       
wire             cp0_rtu_ex1_inst_sret;        
wire             cp0_rtu_ex1_vs_dirty;         
wire             cp0_rtu_ex1_vs_dirty_dp;      
wire    [63 :0]  cp0_rtu_ex1_wb_data;          
wire             cp0_rtu_ex1_wb_dp;            
wire    [5  :0]  cp0_rtu_ex1_wb_preg;          
wire             cp0_rtu_ex1_wb_vld;           
wire             cp0_rtu_fence_idle;           
wire             cp0_rtu_icg_en;               
wire             cp0_rtu_in_lpmd;              
wire    [14 :0]  cp0_rtu_int_vld;              
wire    [39 :0]  cp0_rtu_trap_pc;              
wire             cp0_rtu_vstart_eq_0;          
wire             cp0_vpu_icg_en;               
wire             cp0_vpu_xx_bf16;              
wire             cp0_vpu_xx_dqnan;             
wire    [2  :0]  cp0_vpu_xx_rm;                
wire    [39 :0]  cp0_xx_mrvbr;                 
wire             cp0_yy_clk_en;                
wire    [1  :0]  cp0_yy_priv_mode;             
wire             cpurst_b;                     
wire             dtu_cp0_dcsr_mprven;          
wire    [1  :0]  dtu_cp0_dcsr_prv;             
wire    [63 :0]  dtu_cp0_rdata;                
wire             dtu_cp0_wake_up;              
wire    [2  :0]  fence_top_cur_state;          
wire             forever_cpuclk;               
wire    [63 :0]  hpcp_cp0_data;                
wire             hpcp_cp0_int_vld;             
wire             hpcp_cp0_sce;                 
wire             idu_cp0_ex1_dp_sel;           
wire    [5  :0]  idu_cp0_ex1_dst0_reg;         
wire             idu_cp0_ex1_expt_acc_error;   
wire             idu_cp0_ex1_expt_high;        
wire             idu_cp0_ex1_expt_illegal;     
wire             idu_cp0_ex1_expt_page_fault;  
wire    [19 :0]  idu_cp0_ex1_func;             
wire             idu_cp0_ex1_gateclk_sel;      
wire    [21 :0]  idu_cp0_ex1_halt_info;        
wire             idu_cp0_ex1_length;           
wire    [31 :0]  idu_cp0_ex1_opcode;           
wire             idu_cp0_ex1_sel;              
wire             idu_cp0_ex1_split;            
wire    [63 :0]  idu_cp0_ex1_src0_data;        
wire    [63 :0]  idu_cp0_ex1_src1_data;        
wire             ifu_cp0_bht_inv_done;         
wire             ifu_cp0_icache_inv_done;      
wire    [127:0]  ifu_cp0_icache_read_data;     
wire             ifu_cp0_icache_read_data_vld; 
wire             ifu_cp0_rst_inv_req;          
wire             ifu_cp0_warm_up;              
wire             ifu_yy_xx_no_op;              
wire    [39 :0]  iu_cp0_ex1_cur_pc;            
wire    [63 :0]  iui_inst_rs2;                 
wire             iui_inst_vsetvl_decd;         
wire             iui_regs_csr_en;              
wire             iui_regs_csr_wen;             
wire             iui_regs_csr_wen_no_imm_ill;  
wire             iui_regs_csr_write;           
wire             iui_regs_csr_write_no_imm_ill; 
wire    [11 :0]  iui_regs_imm;                 
wire             iui_regs_inst_mret;           
wire             iui_regs_inst_sret;           
wire    [63 :0]  iui_regs_wdata;               
wire             iui_special_cache;            
wire    [5  :0]  iui_special_cache_func;       
wire             iui_special_fence;            
wire             iui_special_fencei;           
wire    [63 :0]  iui_special_rs1;              
wire             iui_special_rs1_x0;           
wire    [63 :0]  iui_special_rs2;              
wire             iui_special_rs2_x0;           
wire             iui_special_sfence;           
wire             iui_special_sync;             
wire             iui_special_synci;            
wire             iui_special_vsetvl;           
wire             iui_special_vsetvl_dp;        
wire    [63 :0]  iui_special_vsetvl_rs1;       
wire    [11 :0]  iui_special_vsetvl_rs2;       
wire             iui_special_wfi;              
wire             iui_vsetvl_bypass;            
wire    [4  :0]  iui_vsetvl_data;              
wire    [1  :0]  lpmd_top_cur_state;           
wire    [127:0]  lsu_cp0_dcache_read_data;     
wire             lsu_cp0_dcache_read_data_vld; 
wire             lsu_cp0_fence_ack;            
wire             lsu_cp0_icc_done;             
wire             lsu_cp0_sync_ack;             
wire             mmu_cp0_cmplt;                
wire    [63 :0]  mmu_cp0_data;                 
wire             mmu_cp0_tlb_inv_done;         
wire             mmu_yy_xx_no_op;              
wire             pad_yy_icg_scan_en;           
wire    [63 :0]  pmp_cp0_data;                 
wire             regs_clk;                     
wire             regs_iui_csr_inv;             
wire             regs_iui_mcins_stall;         
wire             regs_iui_mcor_stall;          
wire    [39 :0]  regs_iui_mepc;                
wire    [1  :0]  regs_iui_pm;                  
wire    [63 :0]  regs_iui_rdata;               
wire    [63 :0]  regs_iui_rdata_for_w;         
wire    [39 :0]  regs_iui_sepc;                
wire             regs_iui_smcir_stall;         
wire             regs_iui_trigger_mro;         
wire             regs_iui_trigger_smode;       
wire             regs_iui_tsr;                 
wire             regs_iui_tvm;                 
wire             regs_iui_tw;                  
wire             regs_lpmd_int_vld;            
wire             regs_special_bht_inv;         
wire             regs_special_dcache_clr;      
wire             regs_special_dcache_inv;      
wire             regs_special_dcache_req;      
wire             regs_special_icache_inv;      
wire             regs_xx_icg_en;               
wire             rst_top_op_done;              
wire    [63 :0]  rtu_cp0_epc;                  
wire             rtu_cp0_exit_debug;           
wire    [4  :0]  rtu_cp0_fflags;               
wire             rtu_cp0_fflags_updt;          
wire             rtu_cp0_fs_dirty_updt;        
wire             rtu_cp0_fs_dirty_updt_dp;     
wire    [63 :0]  rtu_cp0_tval;                 
wire    [7  :0]  rtu_cp0_vl;                   
wire             rtu_cp0_vl_vld;               
wire             rtu_cp0_vs_dirty_updt;        
wire             rtu_cp0_vs_dirty_updt_dp;     
wire    [6  :0]  rtu_cp0_vstart;               
wire             rtu_cp0_vstart_vld;           
wire             rtu_cp0_vxsat;                
wire             rtu_cp0_vxsat_vld;            
wire             rtu_yy_xx_dbgon;              
wire             rtu_yy_xx_expt_int;           
wire    [4  :0]  rtu_yy_xx_expt_vec;           
wire             rtu_yy_xx_expt_vld;           
wire             rtu_yy_xx_flush;              
wire             special_iui_stall;            
wire    [63 :0]  special_iui_vsetvl_wdata;     
wire             special_regs_vill;            
wire             special_regs_vsetvl_dp;       
wire             special_vsetvl_illegal;       
wire    [39 :0]  sysio_cp0_apb_base;           
wire             vidu_cp0_vid_fof_vld;         


// &Instance("aq_cp0_iui"); @29
aq_cp0_iui  x_aq_cp0_iui (
  .cp0_dtu_addr                  (cp0_dtu_addr                 ),
  .cp0_dtu_rreg                  (cp0_dtu_rreg                 ),
  .cp0_dtu_wdata                 (cp0_dtu_wdata                ),
  .cp0_dtu_wreg                  (cp0_dtu_wreg                 ),
  .cp0_hpcp_index                (cp0_hpcp_index               ),
  .cp0_hpcp_wdata                (cp0_hpcp_wdata               ),
  .cp0_hpcp_wreg                 (cp0_hpcp_wreg                ),
  .cp0_idu_issue_stall           (cp0_idu_issue_stall          ),
  .cp0_idu_vsetvl_dis_stall      (cp0_idu_vsetvl_dis_stall     ),
  .cp0_mmu_addr                  (cp0_mmu_addr                 ),
  .cp0_mmu_wdata                 (cp0_mmu_wdata                ),
  .cp0_mmu_wreg                  (cp0_mmu_wreg                 ),
  .cp0_pmp_addr                  (cp0_pmp_addr                 ),
  .cp0_pmp_wdata                 (cp0_pmp_wdata                ),
  .cp0_pmp_wreg                  (cp0_pmp_wreg                 ),
  .cp0_rtu_ex1_chgflw            (cp0_rtu_ex1_chgflw           ),
  .cp0_rtu_ex1_chgflw_pc         (cp0_rtu_ex1_chgflw_pc        ),
  .cp0_rtu_ex1_cmplt             (cp0_rtu_ex1_cmplt            ),
  .cp0_rtu_ex1_cmplt_dp          (cp0_rtu_ex1_cmplt_dp         ),
  .cp0_rtu_ex1_expt_tval         (cp0_rtu_ex1_expt_tval        ),
  .cp0_rtu_ex1_expt_vec          (cp0_rtu_ex1_expt_vec         ),
  .cp0_rtu_ex1_expt_vld          (cp0_rtu_ex1_expt_vld         ),
  .cp0_rtu_ex1_flush             (cp0_rtu_ex1_flush            ),
  .cp0_rtu_ex1_halt_info         (cp0_rtu_ex1_halt_info        ),
  .cp0_rtu_ex1_inst_dret         (cp0_rtu_ex1_inst_dret        ),
  .cp0_rtu_ex1_inst_ebreak       (cp0_rtu_ex1_inst_ebreak      ),
  .cp0_rtu_ex1_inst_len          (cp0_rtu_ex1_inst_len         ),
  .cp0_rtu_ex1_inst_mret         (cp0_rtu_ex1_inst_mret        ),
  .cp0_rtu_ex1_inst_split        (cp0_rtu_ex1_inst_split       ),
  .cp0_rtu_ex1_inst_sret         (cp0_rtu_ex1_inst_sret        ),
  .cp0_rtu_ex1_vs_dirty          (cp0_rtu_ex1_vs_dirty         ),
  .cp0_rtu_ex1_vs_dirty_dp       (cp0_rtu_ex1_vs_dirty_dp      ),
  .cp0_rtu_ex1_wb_data           (cp0_rtu_ex1_wb_data          ),
  .cp0_rtu_ex1_wb_dp             (cp0_rtu_ex1_wb_dp            ),
  .cp0_rtu_ex1_wb_preg           (cp0_rtu_ex1_wb_preg          ),
  .cp0_rtu_ex1_wb_vld            (cp0_rtu_ex1_wb_vld           ),
  .cpurst_b                      (cpurst_b                     ),
  .idu_cp0_ex1_dp_sel            (idu_cp0_ex1_dp_sel           ),
  .idu_cp0_ex1_dst0_reg          (idu_cp0_ex1_dst0_reg         ),
  .idu_cp0_ex1_expt_acc_error    (idu_cp0_ex1_expt_acc_error   ),
  .idu_cp0_ex1_expt_high         (idu_cp0_ex1_expt_high        ),
  .idu_cp0_ex1_expt_illegal      (idu_cp0_ex1_expt_illegal     ),
  .idu_cp0_ex1_expt_page_fault   (idu_cp0_ex1_expt_page_fault  ),
  .idu_cp0_ex1_func              (idu_cp0_ex1_func             ),
  .idu_cp0_ex1_gateclk_sel       (idu_cp0_ex1_gateclk_sel      ),
  .idu_cp0_ex1_halt_info         (idu_cp0_ex1_halt_info        ),
  .idu_cp0_ex1_length            (idu_cp0_ex1_length           ),
  .idu_cp0_ex1_opcode            (idu_cp0_ex1_opcode           ),
  .idu_cp0_ex1_sel               (idu_cp0_ex1_sel              ),
  .idu_cp0_ex1_split             (idu_cp0_ex1_split            ),
  .idu_cp0_ex1_src0_data         (idu_cp0_ex1_src0_data        ),
  .idu_cp0_ex1_src1_data         (idu_cp0_ex1_src1_data        ),
  .ifu_cp0_warm_up               (ifu_cp0_warm_up              ),
  .iu_cp0_ex1_cur_pc             (iu_cp0_ex1_cur_pc            ),
  .iui_inst_rs2                  (iui_inst_rs2                 ),
  .iui_inst_vsetvl_decd          (iui_inst_vsetvl_decd         ),
  .iui_regs_csr_en               (iui_regs_csr_en              ),
  .iui_regs_csr_wen              (iui_regs_csr_wen             ),
  .iui_regs_csr_wen_no_imm_ill   (iui_regs_csr_wen_no_imm_ill  ),
  .iui_regs_csr_write            (iui_regs_csr_write           ),
  .iui_regs_csr_write_no_imm_ill (iui_regs_csr_write_no_imm_ill),
  .iui_regs_imm                  (iui_regs_imm                 ),
  .iui_regs_inst_mret            (iui_regs_inst_mret           ),
  .iui_regs_inst_sret            (iui_regs_inst_sret           ),
  .iui_regs_wdata                (iui_regs_wdata               ),
  .iui_special_cache             (iui_special_cache            ),
  .iui_special_cache_func        (iui_special_cache_func       ),
  .iui_special_fence             (iui_special_fence            ),
  .iui_special_fencei            (iui_special_fencei           ),
  .iui_special_rs1               (iui_special_rs1              ),
  .iui_special_rs1_x0            (iui_special_rs1_x0           ),
  .iui_special_rs2               (iui_special_rs2              ),
  .iui_special_rs2_x0            (iui_special_rs2_x0           ),
  .iui_special_sfence            (iui_special_sfence           ),
  .iui_special_sync              (iui_special_sync             ),
  .iui_special_synci             (iui_special_synci            ),
  .iui_special_vsetvl            (iui_special_vsetvl           ),
  .iui_special_vsetvl_dp         (iui_special_vsetvl_dp        ),
  .iui_special_vsetvl_rs1        (iui_special_vsetvl_rs1       ),
  .iui_special_vsetvl_rs2        (iui_special_vsetvl_rs2       ),
  .iui_special_wfi               (iui_special_wfi              ),
  .iui_vsetvl_bypass             (iui_vsetvl_bypass            ),
  .iui_vsetvl_data               (iui_vsetvl_data              ),
  .regs_clk                      (regs_clk                     ),
  .regs_iui_csr_inv              (regs_iui_csr_inv             ),
  .regs_iui_mcins_stall          (regs_iui_mcins_stall         ),
  .regs_iui_mcor_stall           (regs_iui_mcor_stall          ),
  .regs_iui_mepc                 (regs_iui_mepc                ),
  .regs_iui_pm                   (regs_iui_pm                  ),
  .regs_iui_rdata                (regs_iui_rdata               ),
  .regs_iui_rdata_for_w          (regs_iui_rdata_for_w         ),
  .regs_iui_sepc                 (regs_iui_sepc                ),
  .regs_iui_smcir_stall          (regs_iui_smcir_stall         ),
  .regs_iui_trigger_mro          (regs_iui_trigger_mro         ),
  .regs_iui_trigger_smode        (regs_iui_trigger_smode       ),
  .regs_iui_tsr                  (regs_iui_tsr                 ),
  .regs_iui_tvm                  (regs_iui_tvm                 ),
  .regs_iui_tw                   (regs_iui_tw                  ),
  .rtu_yy_xx_dbgon               (rtu_yy_xx_dbgon              ),
  .special_iui_stall             (special_iui_stall            ),
  .special_iui_vsetvl_wdata      (special_iui_vsetvl_wdata     ),
  .vidu_cp0_vid_fof_vld          (vidu_cp0_vid_fof_vld         )
);


// &Instance("aq_cp0_regs"); @31
aq_cp0_regs  x_aq_cp0_regs (
  .biu_cp0_coreid                (biu_cp0_coreid               ),
  .biu_cp0_me_int                (biu_cp0_me_int               ),
  .biu_cp0_ms_int                (biu_cp0_ms_int               ),
  .biu_cp0_mt_int                (biu_cp0_mt_int               ),
  .biu_cp0_rvba                  (biu_cp0_rvba                 ),
  .biu_cp0_se_int                (biu_cp0_se_int               ),
  .biu_cp0_ss_int                (biu_cp0_ss_int               ),
  .biu_cp0_st_int                (biu_cp0_st_int               ),
  .cp0_biu_icg_en                (cp0_biu_icg_en               ),
  .cp0_dtu_icg_en                (cp0_dtu_icg_en               ),
  .cp0_dtu_mexpt_vld             (cp0_dtu_mexpt_vld            ),
  .cp0_dtu_pcfifo_frz            (cp0_dtu_pcfifo_frz           ),
  .cp0_dtu_satp                  (cp0_dtu_satp                 ),
  .cp0_hpcp_icg_en               (cp0_hpcp_icg_en              ),
  .cp0_hpcp_int_off_vld          (cp0_hpcp_int_off_vld         ),
  .cp0_hpcp_mcntwen              (cp0_hpcp_mcntwen             ),
  .cp0_hpcp_pmdm                 (cp0_hpcp_pmdm                ),
  .cp0_hpcp_pmds                 (cp0_hpcp_pmds                ),
  .cp0_hpcp_pmdu                 (cp0_hpcp_pmdu                ),
  .cp0_idu_cskyee                (cp0_idu_cskyee               ),
  .cp0_idu_dis_fence_in_dbg      (cp0_idu_dis_fence_in_dbg     ),
  .cp0_idu_frm                   (cp0_idu_frm                  ),
  .cp0_idu_fs                    (cp0_idu_fs                   ),
  .cp0_idu_icg_en                (cp0_idu_icg_en               ),
  .cp0_idu_ucme                  (cp0_idu_ucme                 ),
  .cp0_idu_vill                  (cp0_idu_vill                 ),
  .cp0_idu_vl_zero               (cp0_idu_vl_zero              ),
  .cp0_idu_vlmul                 (cp0_idu_vlmul                ),
  .cp0_idu_vs                    (cp0_idu_vs                   ),
  .cp0_idu_vsew                  (cp0_idu_vsew                 ),
  .cp0_idu_vstart                (cp0_idu_vstart               ),
  .cp0_ifu_bht_en                (cp0_ifu_bht_en               ),
  .cp0_ifu_btb_clr               (cp0_ifu_btb_clr              ),
  .cp0_ifu_btb_en                (cp0_ifu_btb_en               ),
  .cp0_ifu_icache_en             (cp0_ifu_icache_en            ),
  .cp0_ifu_icache_pref_en        (cp0_ifu_icache_pref_en       ),
  .cp0_ifu_icache_read_index     (cp0_ifu_icache_read_index    ),
  .cp0_ifu_icache_read_req       (cp0_ifu_icache_read_req      ),
  .cp0_ifu_icache_read_tag       (cp0_ifu_icache_read_tag      ),
  .cp0_ifu_icache_read_way       (cp0_ifu_icache_read_way      ),
  .cp0_ifu_icg_en                (cp0_ifu_icg_en               ),
  .cp0_ifu_iwpe                  (cp0_ifu_iwpe                 ),
  .cp0_ifu_ras_en                (cp0_ifu_ras_en               ),
  .cp0_iu_icg_en                 (cp0_iu_icg_en                ),
  .cp0_lsu_amr                   (cp0_lsu_amr                  ),
  .cp0_lsu_dcache_en             (cp0_lsu_dcache_en            ),
  .cp0_lsu_dcache_pref_dist      (cp0_lsu_dcache_pref_dist     ),
  .cp0_lsu_dcache_pref_en        (cp0_lsu_dcache_pref_en       ),
  .cp0_lsu_dcache_read_idx       (cp0_lsu_dcache_read_idx      ),
  .cp0_lsu_dcache_read_req       (cp0_lsu_dcache_read_req      ),
  .cp0_lsu_dcache_read_type      (cp0_lsu_dcache_read_type     ),
  .cp0_lsu_dcache_read_way       (cp0_lsu_dcache_read_way      ),
  .cp0_lsu_dcache_wa             (cp0_lsu_dcache_wa            ),
  .cp0_lsu_dcache_wb             (cp0_lsu_dcache_wb            ),
  .cp0_lsu_icg_en                (cp0_lsu_icg_en               ),
  .cp0_lsu_mm                    (cp0_lsu_mm                   ),
  .cp0_lsu_mpp                   (cp0_lsu_mpp                  ),
  .cp0_lsu_mprv                  (cp0_lsu_mprv                 ),
  .cp0_lsu_we_en                 (cp0_lsu_we_en                ),
  .cp0_mmu_icg_en                (cp0_mmu_icg_en               ),
  .cp0_mmu_maee                  (cp0_mmu_maee                 ),
  .cp0_mmu_mxr                   (cp0_mmu_mxr                  ),
  .cp0_mmu_ptw_en                (cp0_mmu_ptw_en               ),
  .cp0_mmu_satp_data             (cp0_mmu_satp_data            ),
  .cp0_mmu_satp_wen              (cp0_mmu_satp_wen             ),
  .cp0_mmu_sum                   (cp0_mmu_sum                  ),
  .cp0_pmp_icg_en                (cp0_pmp_icg_en               ),
  .cp0_rtu_icg_en                (cp0_rtu_icg_en               ),
  .cp0_rtu_int_vld               (cp0_rtu_int_vld              ),
  .cp0_rtu_trap_pc               (cp0_rtu_trap_pc              ),
  .cp0_rtu_vstart_eq_0           (cp0_rtu_vstart_eq_0          ),
  .cp0_vpu_icg_en                (cp0_vpu_icg_en               ),
  .cp0_vpu_xx_bf16               (cp0_vpu_xx_bf16              ),
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .cp0_vpu_xx_rm                 (cp0_vpu_xx_rm                ),
  .cp0_xx_mrvbr                  (cp0_xx_mrvbr                 ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .cp0_yy_priv_mode              (cp0_yy_priv_mode             ),
  .cpurst_b                      (cpurst_b                     ),
  .dtu_cp0_dcsr_mprven           (dtu_cp0_dcsr_mprven          ),
  .dtu_cp0_dcsr_prv              (dtu_cp0_dcsr_prv             ),
  .dtu_cp0_rdata                 (dtu_cp0_rdata                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .hpcp_cp0_data                 (hpcp_cp0_data                ),
  .hpcp_cp0_int_vld              (hpcp_cp0_int_vld             ),
  .hpcp_cp0_sce                  (hpcp_cp0_sce                 ),
  .ifu_cp0_bht_inv_done          (ifu_cp0_bht_inv_done         ),
  .ifu_cp0_icache_inv_done       (ifu_cp0_icache_inv_done      ),
  .ifu_cp0_icache_read_data      (ifu_cp0_icache_read_data     ),
  .ifu_cp0_icache_read_data_vld  (ifu_cp0_icache_read_data_vld ),
  .iui_inst_rs2                  (iui_inst_rs2                 ),
  .iui_regs_csr_en               (iui_regs_csr_en              ),
  .iui_regs_csr_wen              (iui_regs_csr_wen             ),
  .iui_regs_csr_wen_no_imm_ill   (iui_regs_csr_wen_no_imm_ill  ),
  .iui_regs_csr_write            (iui_regs_csr_write           ),
  .iui_regs_csr_write_no_imm_ill (iui_regs_csr_write_no_imm_ill),
  .iui_regs_imm                  (iui_regs_imm                 ),
  .iui_regs_inst_mret            (iui_regs_inst_mret           ),
  .iui_regs_inst_sret            (iui_regs_inst_sret           ),
  .iui_regs_wdata                (iui_regs_wdata               ),
  .iui_vsetvl_bypass             (iui_vsetvl_bypass            ),
  .iui_vsetvl_data               (iui_vsetvl_data              ),
  .lsu_cp0_dcache_read_data      (lsu_cp0_dcache_read_data     ),
  .lsu_cp0_dcache_read_data_vld  (lsu_cp0_dcache_read_data_vld ),
  .lsu_cp0_icc_done              (lsu_cp0_icc_done             ),
  .mmu_cp0_cmplt                 (mmu_cp0_cmplt                ),
  .mmu_cp0_data                  (mmu_cp0_data                 ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .pmp_cp0_data                  (pmp_cp0_data                 ),
  .regs_clk                      (regs_clk                     ),
  .regs_iui_csr_inv              (regs_iui_csr_inv             ),
  .regs_iui_mcins_stall          (regs_iui_mcins_stall         ),
  .regs_iui_mcor_stall           (regs_iui_mcor_stall          ),
  .regs_iui_mepc                 (regs_iui_mepc                ),
  .regs_iui_pm                   (regs_iui_pm                  ),
  .regs_iui_rdata                (regs_iui_rdata               ),
  .regs_iui_rdata_for_w          (regs_iui_rdata_for_w         ),
  .regs_iui_sepc                 (regs_iui_sepc                ),
  .regs_iui_smcir_stall          (regs_iui_smcir_stall         ),
  .regs_iui_trigger_mro          (regs_iui_trigger_mro         ),
  .regs_iui_trigger_smode        (regs_iui_trigger_smode       ),
  .regs_iui_tsr                  (regs_iui_tsr                 ),
  .regs_iui_tvm                  (regs_iui_tvm                 ),
  .regs_iui_tw                   (regs_iui_tw                  ),
  .regs_lpmd_int_vld             (regs_lpmd_int_vld            ),
  .regs_special_bht_inv          (regs_special_bht_inv         ),
  .regs_special_dcache_clr       (regs_special_dcache_clr      ),
  .regs_special_dcache_inv       (regs_special_dcache_inv      ),
  .regs_special_dcache_req       (regs_special_dcache_req      ),
  .regs_special_icache_inv       (regs_special_icache_inv      ),
  .regs_xx_icg_en                (regs_xx_icg_en               ),
  .rtu_cp0_epc                   (rtu_cp0_epc                  ),
  .rtu_cp0_exit_debug            (rtu_cp0_exit_debug           ),
  .rtu_cp0_fflags                (rtu_cp0_fflags               ),
  .rtu_cp0_fflags_updt           (rtu_cp0_fflags_updt          ),
  .rtu_cp0_fs_dirty_updt         (rtu_cp0_fs_dirty_updt        ),
  .rtu_cp0_fs_dirty_updt_dp      (rtu_cp0_fs_dirty_updt_dp     ),
  .rtu_cp0_tval                  (rtu_cp0_tval                 ),
  .rtu_cp0_vl                    (rtu_cp0_vl                   ),
  .rtu_cp0_vl_vld                (rtu_cp0_vl_vld               ),
  .rtu_cp0_vs_dirty_updt         (rtu_cp0_vs_dirty_updt        ),
  .rtu_cp0_vs_dirty_updt_dp      (rtu_cp0_vs_dirty_updt_dp     ),
  .rtu_cp0_vstart                (rtu_cp0_vstart               ),
  .rtu_cp0_vstart_vld            (rtu_cp0_vstart_vld           ),
  .rtu_cp0_vxsat                 (rtu_cp0_vxsat                ),
  .rtu_cp0_vxsat_vld             (rtu_cp0_vxsat_vld            ),
  .rtu_yy_xx_dbgon               (rtu_yy_xx_dbgon              ),
  .rtu_yy_xx_expt_int            (rtu_yy_xx_expt_int           ),
  .rtu_yy_xx_expt_vec            (rtu_yy_xx_expt_vec           ),
  .rtu_yy_xx_expt_vld            (rtu_yy_xx_expt_vld           ),
  .rtu_yy_xx_flush               (rtu_yy_xx_flush              ),
  .special_regs_vill             (special_regs_vill            ),
  .special_regs_vsetvl_dp        (special_regs_vsetvl_dp       ),
  .special_vsetvl_illegal        (special_vsetvl_illegal       ),
  .sysio_cp0_apb_base            (sysio_cp0_apb_base           )
);


// &Instance("aq_cp0_special"); @33
aq_cp0_special  x_aq_cp0_special (
  .cp0_biu_lpmd_b           (cp0_biu_lpmd_b          ),
  .cp0_hpcp_sync_stall_vld  (cp0_hpcp_sync_stall_vld ),
  .cp0_ifu_bht_inv          (cp0_ifu_bht_inv         ),
  .cp0_ifu_icache_inv_addr  (cp0_ifu_icache_inv_addr ),
  .cp0_ifu_icache_inv_req   (cp0_ifu_icache_inv_req  ),
  .cp0_ifu_icache_inv_type  (cp0_ifu_icache_inv_type ),
  .cp0_ifu_in_lpmd          (cp0_ifu_in_lpmd         ),
  .cp0_ifu_lpmd_req         (cp0_ifu_lpmd_req        ),
  .cp0_ifu_rst_inv_done     (cp0_ifu_rst_inv_done    ),
  .cp0_lsu_fence_req        (cp0_lsu_fence_req       ),
  .cp0_lsu_icc_addr         (cp0_lsu_icc_addr        ),
  .cp0_lsu_icc_op           (cp0_lsu_icc_op          ),
  .cp0_lsu_icc_req          (cp0_lsu_icc_req         ),
  .cp0_lsu_icc_type         (cp0_lsu_icc_type        ),
  .cp0_lsu_sync_req         (cp0_lsu_sync_req        ),
  .cp0_mmu_lpmd_req         (cp0_mmu_lpmd_req        ),
  .cp0_mmu_tlb_all_inv      (cp0_mmu_tlb_all_inv     ),
  .cp0_mmu_tlb_asid         (cp0_mmu_tlb_asid        ),
  .cp0_mmu_tlb_asid_all_inv (cp0_mmu_tlb_asid_all_inv),
  .cp0_mmu_tlb_va           (cp0_mmu_tlb_va          ),
  .cp0_mmu_tlb_va_all_inv   (cp0_mmu_tlb_va_all_inv  ),
  .cp0_mmu_tlb_va_asid_inv  (cp0_mmu_tlb_va_asid_inv ),
  .cp0_rtu_fence_idle       (cp0_rtu_fence_idle      ),
  .cp0_rtu_in_lpmd          (cp0_rtu_in_lpmd         ),
  .cp0_yy_clk_en            (cp0_yy_clk_en           ),
  .cpurst_b                 (cpurst_b                ),
  .dtu_cp0_wake_up          (dtu_cp0_wake_up         ),
  .fence_top_cur_state      (fence_top_cur_state     ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_cp0_bht_inv_done     (ifu_cp0_bht_inv_done    ),
  .ifu_cp0_icache_inv_done  (ifu_cp0_icache_inv_done ),
  .ifu_cp0_rst_inv_req      (ifu_cp0_rst_inv_req     ),
  .ifu_yy_xx_no_op          (ifu_yy_xx_no_op         ),
  .iui_special_cache        (iui_special_cache       ),
  .iui_special_cache_func   (iui_special_cache_func  ),
  .iui_special_fence        (iui_special_fence       ),
  .iui_special_fencei       (iui_special_fencei      ),
  .iui_special_rs1          (iui_special_rs1         ),
  .iui_special_rs1_x0       (iui_special_rs1_x0      ),
  .iui_special_rs2          (iui_special_rs2         ),
  .iui_special_rs2_x0       (iui_special_rs2_x0      ),
  .iui_special_sfence       (iui_special_sfence      ),
  .iui_special_sync         (iui_special_sync        ),
  .iui_special_synci        (iui_special_synci       ),
  .iui_special_vsetvl       (iui_special_vsetvl      ),
  .iui_special_vsetvl_dp    (iui_special_vsetvl_dp   ),
  .iui_special_vsetvl_rs1   (iui_special_vsetvl_rs1  ),
  .iui_special_vsetvl_rs2   (iui_special_vsetvl_rs2  ),
  .iui_special_wfi          (iui_special_wfi         ),
  .lpmd_top_cur_state       (lpmd_top_cur_state      ),
  .lsu_cp0_fence_ack        (lsu_cp0_fence_ack       ),
  .lsu_cp0_icc_done         (lsu_cp0_icc_done        ),
  .lsu_cp0_sync_ack         (lsu_cp0_sync_ack        ),
  .mmu_cp0_tlb_inv_done     (mmu_cp0_tlb_inv_done    ),
  .mmu_yy_xx_no_op          (mmu_yy_xx_no_op         ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .regs_lpmd_int_vld        (regs_lpmd_int_vld       ),
  .regs_special_bht_inv     (regs_special_bht_inv    ),
  .regs_special_dcache_clr  (regs_special_dcache_clr ),
  .regs_special_dcache_inv  (regs_special_dcache_inv ),
  .regs_special_dcache_req  (regs_special_dcache_req ),
  .regs_special_icache_inv  (regs_special_icache_inv ),
  .regs_xx_icg_en           (regs_xx_icg_en          ),
  .rst_top_op_done          (rst_top_op_done         ),
  .rtu_yy_xx_dbgon          (rtu_yy_xx_dbgon         ),
  .rtu_yy_xx_flush          (rtu_yy_xx_flush         ),
  .special_iui_stall        (special_iui_stall       ),
  .special_iui_vsetvl_wdata (special_iui_vsetvl_wdata),
  .special_regs_vsetvl_dp   (special_regs_vsetvl_dp  )
);


// &Force("output", "cp0_yy_clk_en"); @35

assign cp0_dtu_debug_info[5:0] = {lpmd_top_cur_state[1:0],
                                  fence_top_cur_state[2:0],
                                  rst_top_op_done};

assign special_regs_vill      = 1'b0;
assign special_vsetvl_illegal = 1'b0;
assign iui_inst_vsetvl_decd   = 1'b0;

// &ModuleEnd; @54
endmodule



