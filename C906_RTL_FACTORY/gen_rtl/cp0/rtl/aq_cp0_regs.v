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
module aq_cp0_regs(
  biu_cp0_coreid,
  biu_cp0_me_int,
  biu_cp0_ms_int,
  biu_cp0_mt_int,
  biu_cp0_rvba,
  biu_cp0_se_int,
  biu_cp0_ss_int,
  biu_cp0_st_int,
  cp0_biu_icg_en,
  cp0_dtu_icg_en,
  cp0_dtu_mexpt_vld,
  cp0_dtu_pcfifo_frz,
  cp0_dtu_satp,
  cp0_hpcp_icg_en,
  cp0_hpcp_int_off_vld,
  cp0_hpcp_mcntwen,
  cp0_hpcp_pmdm,
  cp0_hpcp_pmds,
  cp0_hpcp_pmdu,
  cp0_idu_cskyee,
  cp0_idu_dis_fence_in_dbg,
  cp0_idu_frm,
  cp0_idu_fs,
  cp0_idu_icg_en,
  cp0_idu_ucme,
  cp0_idu_vill,
  cp0_idu_vl_zero,
  cp0_idu_vlmul,
  cp0_idu_vs,
  cp0_idu_vsew,
  cp0_idu_vstart,
  cp0_ifu_bht_en,
  cp0_ifu_btb_clr,
  cp0_ifu_btb_en,
  cp0_ifu_icache_en,
  cp0_ifu_icache_pref_en,
  cp0_ifu_icache_read_index,
  cp0_ifu_icache_read_req,
  cp0_ifu_icache_read_tag,
  cp0_ifu_icache_read_way,
  cp0_ifu_icg_en,
  cp0_ifu_iwpe,
  cp0_ifu_ras_en,
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
  cp0_lsu_icg_en,
  cp0_lsu_mm,
  cp0_lsu_mpp,
  cp0_lsu_mprv,
  cp0_lsu_we_en,
  cp0_mmu_icg_en,
  cp0_mmu_maee,
  cp0_mmu_mxr,
  cp0_mmu_ptw_en,
  cp0_mmu_satp_data,
  cp0_mmu_satp_wen,
  cp0_mmu_sum,
  cp0_pmp_icg_en,
  cp0_rtu_icg_en,
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
  forever_cpuclk,
  hpcp_cp0_data,
  hpcp_cp0_int_vld,
  hpcp_cp0_sce,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_icache_read_data,
  ifu_cp0_icache_read_data_vld,
  iui_inst_rs2,
  iui_regs_csr_en,
  iui_regs_csr_wen,
  iui_regs_csr_wen_no_imm_ill,
  iui_regs_csr_write,
  iui_regs_csr_write_no_imm_ill,
  iui_regs_imm,
  iui_regs_inst_mret,
  iui_regs_inst_sret,
  iui_regs_wdata,
  iui_vsetvl_bypass,
  iui_vsetvl_data,
  lsu_cp0_dcache_read_data,
  lsu_cp0_dcache_read_data_vld,
  lsu_cp0_icc_done,
  mmu_cp0_cmplt,
  mmu_cp0_data,
  pad_yy_icg_scan_en,
  pmp_cp0_data,
  regs_clk,
  regs_iui_csr_inv,
  regs_iui_mcins_stall,
  regs_iui_mcor_stall,
  regs_iui_mepc,
  regs_iui_pm,
  regs_iui_rdata,
  regs_iui_rdata_for_w,
  regs_iui_sepc,
  regs_iui_smcir_stall,
  regs_iui_trigger_mro,
  regs_iui_trigger_smode,
  regs_iui_tsr,
  regs_iui_tvm,
  regs_iui_tw,
  regs_lpmd_int_vld,
  regs_special_bht_inv,
  regs_special_dcache_clr,
  regs_special_dcache_inv,
  regs_special_dcache_req,
  regs_special_icache_inv,
  regs_xx_icg_en,
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
  special_regs_vill,
  special_regs_vsetvl_dp,
  special_vsetvl_illegal,
  sysio_cp0_apb_base
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
input            cp0_yy_clk_en;                
input            cpurst_b;                     
input            dtu_cp0_dcsr_mprven;          
input   [1  :0]  dtu_cp0_dcsr_prv;             
input   [63 :0]  dtu_cp0_rdata;                
input            forever_cpuclk;               
input   [63 :0]  hpcp_cp0_data;                
input            hpcp_cp0_int_vld;             
input            hpcp_cp0_sce;                 
input            ifu_cp0_bht_inv_done;         
input            ifu_cp0_icache_inv_done;      
input   [127:0]  ifu_cp0_icache_read_data;     
input            ifu_cp0_icache_read_data_vld; 
input   [63 :0]  iui_inst_rs2;                 
input            iui_regs_csr_en;              
input            iui_regs_csr_wen;             
input            iui_regs_csr_wen_no_imm_ill;  
input            iui_regs_csr_write;           
input            iui_regs_csr_write_no_imm_ill; 
input   [11 :0]  iui_regs_imm;                 
input            iui_regs_inst_mret;           
input            iui_regs_inst_sret;           
input   [63 :0]  iui_regs_wdata;               
input            iui_vsetvl_bypass;            
input   [4  :0]  iui_vsetvl_data;              
input   [127:0]  lsu_cp0_dcache_read_data;     
input            lsu_cp0_dcache_read_data_vld; 
input            lsu_cp0_icc_done;             
input            mmu_cp0_cmplt;                
input   [63 :0]  mmu_cp0_data;                 
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
input            special_regs_vill;            
input            special_regs_vsetvl_dp;       
input            special_vsetvl_illegal;       
input   [39 :0]  sysio_cp0_apb_base;           
output           cp0_biu_icg_en;               
output           cp0_dtu_icg_en;               
output           cp0_dtu_mexpt_vld;            
output           cp0_dtu_pcfifo_frz;           
output  [63 :0]  cp0_dtu_satp;                 
output           cp0_hpcp_icg_en;              
output           cp0_hpcp_int_off_vld;         
output  [31 :0]  cp0_hpcp_mcntwen;             
output           cp0_hpcp_pmdm;                
output           cp0_hpcp_pmds;                
output           cp0_hpcp_pmdu;                
output           cp0_idu_cskyee;               
output           cp0_idu_dis_fence_in_dbg;     
output  [2  :0]  cp0_idu_frm;                  
output  [1  :0]  cp0_idu_fs;                   
output           cp0_idu_icg_en;               
output           cp0_idu_ucme;                 
output           cp0_idu_vill;                 
output           cp0_idu_vl_zero;              
output  [1  :0]  cp0_idu_vlmul;                
output  [1  :0]  cp0_idu_vs;                   
output  [1  :0]  cp0_idu_vsew;                 
output  [6  :0]  cp0_idu_vstart;               
output           cp0_ifu_bht_en;               
output           cp0_ifu_btb_clr;              
output           cp0_ifu_btb_en;               
output           cp0_ifu_icache_en;            
output           cp0_ifu_icache_pref_en;       
output  [13 :0]  cp0_ifu_icache_read_index;    
output           cp0_ifu_icache_read_req;      
output           cp0_ifu_icache_read_tag;      
output           cp0_ifu_icache_read_way;      
output           cp0_ifu_icg_en;               
output           cp0_ifu_iwpe;                 
output           cp0_ifu_ras_en;               
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
output           cp0_lsu_icg_en;               
output           cp0_lsu_mm;                   
output  [1  :0]  cp0_lsu_mpp;                  
output           cp0_lsu_mprv;                 
output           cp0_lsu_we_en;                
output           cp0_mmu_icg_en;               
output           cp0_mmu_maee;                 
output           cp0_mmu_mxr;                  
output           cp0_mmu_ptw_en;               
output  [63 :0]  cp0_mmu_satp_data;            
output           cp0_mmu_satp_wen;             
output           cp0_mmu_sum;                  
output           cp0_pmp_icg_en;               
output           cp0_rtu_icg_en;               
output  [14 :0]  cp0_rtu_int_vld;              
output  [39 :0]  cp0_rtu_trap_pc;              
output           cp0_rtu_vstart_eq_0;          
output           cp0_vpu_icg_en;               
output           cp0_vpu_xx_bf16;              
output           cp0_vpu_xx_dqnan;             
output  [2  :0]  cp0_vpu_xx_rm;                
output  [39 :0]  cp0_xx_mrvbr;                 
output  [1  :0]  cp0_yy_priv_mode;             
output           regs_clk;                     
output           regs_iui_csr_inv;             
output           regs_iui_mcins_stall;         
output           regs_iui_mcor_stall;          
output  [39 :0]  regs_iui_mepc;                
output  [1  :0]  regs_iui_pm;                  
output  [63 :0]  regs_iui_rdata;               
output  [63 :0]  regs_iui_rdata_for_w;         
output  [39 :0]  regs_iui_sepc;                
output           regs_iui_smcir_stall;         
output           regs_iui_trigger_mro;         
output           regs_iui_trigger_smode;       
output           regs_iui_tsr;                 
output           regs_iui_tvm;                 
output           regs_iui_tw;                  
output           regs_lpmd_int_vld;            
output           regs_special_bht_inv;         
output           regs_special_dcache_clr;      
output           regs_special_dcache_inv;      
output           regs_special_dcache_req;      
output           regs_special_icache_inv;      
output           regs_xx_icg_en;               

// &Regs; @26
reg     [63 :0]  regs_csr_rdata;               
reg     [63 :0]  regs_csr_rdata_for_w;         
reg              regs_ext_imm_inv;             
reg              regs_imm_inv;                 

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
wire             cp0_dtu_icg_en;               
wire             cp0_dtu_mexpt_vld;            
wire             cp0_dtu_pcfifo_frz;           
wire    [63 :0]  cp0_dtu_satp;                 
wire             cp0_hpcp_icg_en;              
wire             cp0_hpcp_int_off_vld;         
wire    [31 :0]  cp0_hpcp_mcntwen;             
wire             cp0_hpcp_pmdm;                
wire             cp0_hpcp_pmds;                
wire             cp0_hpcp_pmdu;                
wire             cp0_idu_cskyee;               
wire             cp0_idu_dis_fence_in_dbg;     
wire    [2  :0]  cp0_idu_frm;                  
wire    [1  :0]  cp0_idu_fs;                   
wire             cp0_idu_icg_en;               
wire             cp0_idu_ucme;                 
wire             cp0_idu_vill;                 
wire             cp0_idu_vl_zero;              
wire    [1  :0]  cp0_idu_vlmul;                
wire    [1  :0]  cp0_idu_vs;                   
wire    [1  :0]  cp0_idu_vsew;                 
wire    [6  :0]  cp0_idu_vstart;               
wire             cp0_ifu_bht_en;               
wire             cp0_ifu_btb_clr;              
wire             cp0_ifu_btb_en;               
wire             cp0_ifu_icache_en;            
wire             cp0_ifu_icache_pref_en;       
wire    [13 :0]  cp0_ifu_icache_read_index;    
wire             cp0_ifu_icache_read_req;      
wire             cp0_ifu_icache_read_tag;      
wire             cp0_ifu_icache_read_way;      
wire             cp0_ifu_icg_en;               
wire             cp0_ifu_iwpe;                 
wire             cp0_ifu_ras_en;               
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
wire             cp0_lsu_icg_en;               
wire             cp0_lsu_mm;                   
wire    [1  :0]  cp0_lsu_mpp;                  
wire             cp0_lsu_mprv;                 
wire             cp0_lsu_we_en;                
wire             cp0_mmu_icg_en;               
wire             cp0_mmu_maee;                 
wire             cp0_mmu_mxr;                  
wire             cp0_mmu_ptw_en;               
wire    [63 :0]  cp0_mmu_satp_data;            
wire             cp0_mmu_satp_wen;             
wire             cp0_mmu_sum;                  
wire             cp0_pmp_icg_en;               
wire             cp0_rtu_icg_en;               
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
wire             fcsr_local_en;                
wire    [63 :0]  fcsr_value;                   
wire             fflags_local_en;              
wire    [63 :0]  fflags_value;                 
wire             float_clk;                    
wire             forever_cpuclk;               
wire             frm_local_en;                 
wire    [63 :0]  frm_value;                    
wire             fs_dirty_upd_gate;            
wire             fxcr_local_en;                
wire    [63 :0]  fxcr_value;                   
wire    [63 :0]  hpcp_cp0_data;                
wire             hpcp_cp0_int_vld;             
wire             hpcp_cp0_sce;                 
wire    [63 :0]  hpcp_value;                   
wire             ifu_cp0_bht_inv_done;         
wire             ifu_cp0_icache_inv_done;      
wire    [127:0]  ifu_cp0_icache_read_data;     
wire             ifu_cp0_icache_read_data_vld; 
wire    [63 :0]  iui_inst_rs2;                 
wire             iui_regs_csr_en;              
wire             iui_regs_csr_wen;             
wire             iui_regs_csr_wen_no_imm_ill;  
wire             iui_regs_csr_write;           
wire             iui_regs_csr_write_no_imm_ill; 
wire    [11 :0]  iui_regs_imm;                 
wire             iui_regs_inst_mret;           
wire             iui_regs_inst_sret;           
wire    [63 :0]  iui_regs_wdata;               
wire             iui_vsetvl_bypass;            
wire    [4  :0]  iui_vsetvl_data;              
wire    [127:0]  lsu_cp0_dcache_read_data;     
wire             lsu_cp0_dcache_read_data_vld; 
wire             lsu_cp0_icc_done;             
wire    [63 :0]  mapbaddr_value;               
wire    [63 :0]  marchid_value;                
wire             mcause_local_en;              
wire    [63 :0]  mcause_value;                 
wire    [63 :0]  mccr2_value;                  
wire    [63 :0]  mcdata0_value;                
wire    [63 :0]  mcdata1_value;                
wire    [63 :0]  mcer2_value;                  
wire    [63 :0]  mcer_value;                   
wire             mcindex_local_en;             
wire    [63 :0]  mcindex_value;                
wire             mcins_local_en;               
wire    [63 :0]  mcins_value;                  
wire             mcnten_local_en;              
wire    [63 :0]  mcnten_value;                 
wire             mcntwen_local_en;             
wire    [63 :0]  mcntwen_value;                
wire             mcor_local_en;                
wire    [63 :0]  mcor_value;                   
wire             mcpuid_local_en;              
wire    [63 :0]  mcpuid_value;                 
wire             medeleg_local_en;             
wire    [63 :0]  medeleg_value;                
wire    [63 :0]  meicr2_value;                 
wire    [63 :0]  meicr_value;                  
wire             mepc_local_en;                
wire    [63 :0]  mepc_value;                   
wire    [63 :0]  mhartid_value;                
wire             mhcr_local_en;                
wire    [63 :0]  mhcr_value;                   
wire             mhint2_local_en;              
wire    [63 :0]  mhint2_value;                 
wire    [63 :0]  mhint3_value;                 
wire    [63 :0]  mhint4_value;                 
wire             mhint_local_en;               
wire    [63 :0]  mhint_value;                  
wire             mhpmcr_local_en;              
wire             mideleg_local_en;             
wire    [63 :0]  mideleg_value;                
wire             mie_local_en;                 
wire    [63 :0]  mie_value;                    
wire    [63 :0]  mimpid_value;                 
wire             mip_local_en;                 
wire    [63 :0]  mip_value;                    
wire    [63 :0]  misa_value;                   
wire             mmu_cp0_cmplt;                
wire    [63 :0]  mmu_cp0_data;                 
wire    [63 :0]  mmu_value;                    
wire    [63 :0]  mrmr_value;                   
wire    [63 :0]  mrvbr_value;                  
wire             mscratch_local_en;            
wire    [63 :0]  mscratch_value;               
wire             mstatus_local_en;             
wire    [63 :0]  mstatus_value;                
wire             mtval_local_en;               
wire    [63 :0]  mtval_value;                  
wire             mtvec_local_en;               
wire    [63 :0]  mtvec_value;                  
wire    [63 :0]  mvendorid_value;              
wire             mxstatus_local_en;            
wire    [63 :0]  mxstatus_value;               
wire             pad_yy_icg_scan_en;           
wire    [63 :0]  pmp_cp0_data;                 
wire    [63 :0]  pmp_value;                    
wire             regs_clintee;                 
wire             regs_clk;                     
wire             regs_clk_en;                  
wire    [11 :0]  regs_csr_imm;                 
wire             regs_csr_wen;                 
wire             regs_csr_wen_no_imm_ill;      
wire             regs_csr_write_no_imm_ill;    
wire             regs_flush_clk;               
wire             regs_flush_clk_en;            
wire             regs_fs_off;                  
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
wire             regs_mcins_busy;              
wire             regs_mcor_busy;               
wire    [1  :0]  regs_mxl;                     
wire    [1  :0]  regs_pm;                      
wire             regs_scnt_inv;                
wire             regs_smode;                   
wire             regs_special_bht_inv;         
wire             regs_special_dcache_clr;      
wire             regs_special_dcache_inv;      
wire             regs_special_dcache_req;      
wire             regs_special_icache_inv;      
wire             regs_tvm;                     
wire             regs_ucnt_inv;                
wire             regs_umode;                   
wire             regs_xx_icg_en;               
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
wire             satp_local_en;                
wire    [63 :0]  satp_value;                   
wire             scause_local_en;              
wire    [63 :0]  scause_value;                 
wire    [63 :0]  scer2_value;                  
wire    [63 :0]  scer_value;                   
wire             scnten_local_en;              
wire    [63 :0]  scnten_value;                 
wire             sepc_local_en;                
wire    [63 :0]  sepc_value;                   
wire    [63 :0]  shcr_value;                   
wire    [63 :0]  shint2_value;                 
wire    [63 :0]  shint_value;                  
wire             shpmcr_local_en;              
wire             sie_local_en;                 
wire    [63 :0]  sie_value;                    
wire             sip_local_en;                 
wire    [63 :0]  sip_raw;                      
wire    [63 :0]  sip_value;                    
wire             smcir_local_en;               
wire             smcir_local_en_raw;           
wire             special_regs_vill;            
wire             special_regs_vsetvl_dp;       
wire             special_vsetvl_illegal;       
wire             sscratch_local_en;            
wire    [63 :0]  sscratch_value;               
wire             sstatus_local_en;             
wire    [63 :0]  sstatus_value;                
wire             stval_local_en;               
wire    [63 :0]  stval_value;                  
wire             stvec_local_en;               
wire    [63 :0]  stvec_value;                  
wire             sxstatus_local_en;            
wire    [63 :0]  sxstatus_value;               
wire    [39 :0]  sysio_cp0_apb_base;           
wire    [63 :0]  vl_value;                     
wire    [63 :0]  vlenb_value;                  
wire             vs_dirty_upd_gate;            
wire    [63 :0]  vstart_value;                 
wire    [63 :0]  vtype_value;                  
wire    [63 :0]  vxrm_value;                   
wire    [63 :0]  vxsat_value;                  


//==========================================================
//                       CSR Address
//==========================================================
// 1. Machine Level CSRs
// 2. Supervisor Level CSRs
// 3. User Level CSRs
// 4. C-SKY Extension CSRs
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
//--- Machine Information Registers ----
parameter MVENDORID = 12'hF11;
parameter MARCHID   = 12'hF12;
parameter MIMPID    = 12'hF13;
parameter MHARTID   = 12'hF14;

//--------- Machine Trap Setup ---------
parameter MSTATUS   = 12'h300;
parameter MISA      = 12'h301;
parameter MEDELEG   = 12'h302;
parameter MIDELEG   = 12'h303;
parameter MIE       = 12'h304;
parameter MTVEC     = 12'h305;
parameter MCNTEN    = 12'h306;

//------- Machine Trap Handling --------
parameter MSCRATCH  = 12'h340;
parameter MEPC      = 12'h341;
parameter MCAUSE    = 12'h342;
parameter MTVAL     = 12'h343;
parameter MIP       = 12'h344;

//- Machine Protection and Translation -
parameter PMPCFG0   = 12'h3A0;
parameter PMPCFG2   = 12'h3A2;
parameter PMPADDR0  = 12'h3B0;
parameter PMPADDR1  = 12'h3B1;
parameter PMPADDR2  = 12'h3B2;
parameter PMPADDR3  = 12'h3B3;
parameter PMPADDR4  = 12'h3B4;
parameter PMPADDR5  = 12'h3B5;
parameter PMPADDR6  = 12'h3B6;
parameter PMPADDR7  = 12'h3B7;
parameter PMPADDR8  = 12'h3B8;
parameter PMPADDR9  = 12'h3B9;
parameter PMPADDR10 = 12'h3BA;
parameter PMPADDR11 = 12'h3BB;
parameter PMPADDR12 = 12'h3BC;
parameter PMPADDR13 = 12'h3BD;
parameter PMPADDR14 = 12'h3BE;
parameter PMPADDR15 = 12'h3BF;

//------ Machine Counters/Timers -------
parameter MCYCLE    = 12'hB00;
parameter MINSTRET  = 12'hB02;
parameter MHPMCNT3  = 12'hB03;
parameter MHPMCNT4  = 12'hB04;
parameter MHPMCNT5  = 12'hB05;
parameter MHPMCNT6  = 12'hB06;
parameter MHPMCNT7  = 12'hB07;
parameter MHPMCNT8  = 12'hB08;
parameter MHPMCNT9  = 12'hB09;
parameter MHPMCNT10 = 12'hB0A;
parameter MHPMCNT11 = 12'hB0B;
parameter MHPMCNT12 = 12'hB0C;
parameter MHPMCNT13 = 12'hB0D;
parameter MHPMCNT14 = 12'hB0E;
parameter MHPMCNT15 = 12'hB0F;
parameter MHPMCNT16 = 12'hB10;
parameter MHPMCNT17 = 12'hB11;
parameter MHPMCNT18 = 12'hB12;
parameter MHPMCNT19 = 12'hB13;
parameter MHPMCNT20 = 12'hB14;
parameter MHPMCNT21 = 12'hB15;
parameter MHPMCNT22 = 12'hB16;
parameter MHPMCNT23 = 12'hB17;
parameter MHPMCNT24 = 12'hB18;
parameter MHPMCNT25 = 12'hB19;
parameter MHPMCNT26 = 12'hB1A;
parameter MHPMCNT27 = 12'hB1B;
parameter MHPMCNT28 = 12'hB1C;
parameter MHPMCNT29 = 12'hB1D;
parameter MHPMCNT30 = 12'hB1E;
parameter MHPMCNT31 = 12'hB1F;

//------- Machine Counter Setup --------
parameter MHPMCR    = 12'h7F0;
parameter MHPMSP    = 12'h7F1;
parameter MHPMEP    = 12'h7F2;
parameter MCNTIHBT  = 12'h320;
parameter MHPMEVT3  = 12'h323;
parameter MHPMEVT4  = 12'h324;
parameter MHPMEVT5  = 12'h325;
parameter MHPMEVT6  = 12'h326;
parameter MHPMEVT7  = 12'h327;
parameter MHPMEVT8  = 12'h328;
parameter MHPMEVT9  = 12'h329;
parameter MHPMEVT10 = 12'h32A;
parameter MHPMEVT11 = 12'h32B;
parameter MHPMEVT12 = 12'h32C;
parameter MHPMEVT13 = 12'h32D;
parameter MHPMEVT14 = 12'h32E;
parameter MHPMEVT15 = 12'h32F;
parameter MHPMEVT16 = 12'h330;
parameter MHPMEVT17 = 12'h331;
parameter MHPMEVT18 = 12'h332;
parameter MHPMEVT19 = 12'h333;
parameter MHPMEVT20 = 12'h334;
parameter MHPMEVT21 = 12'h335;
parameter MHPMEVT22 = 12'h336;
parameter MHPMEVT23 = 12'h337;
parameter MHPMEVT24 = 12'h338;
parameter MHPMEVT25 = 12'h339;
parameter MHPMEVT26 = 12'h33A;
parameter MHPMEVT27 = 12'h33B;
parameter MHPMEVT28 = 12'h33C;
parameter MHPMEVT29 = 12'h33D;
parameter MHPMEVT30 = 12'h33E;
parameter MHPMEVT31 = 12'h33F;


//----------------------------------------------------------
//                  Supervisor Level CSRs
//----------------------------------------------------------
//------- Supervisor Trap Setup --------
parameter SSTATUS   = 12'h100;
parameter SIE       = 12'h104;
parameter STVEC     = 12'h105;
parameter SCNTEN    = 12'h106;

//------ Supervisor Trap Handling ------
parameter SSCRATCH  = 12'h140;
parameter SEPC      = 12'h141;
parameter SCAUSE    = 12'h142;
parameter STVAL     = 12'h143;
parameter SIP       = 12'h144;

// Supervisor Protection and Translation 
parameter SATP      = 12'h180;


//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
parameter FFLAGS    = 12'h001;
parameter FRM       = 12'h002;
parameter FCSR      = 12'h003;

//---------- User Vector CSRs ----------
parameter VSTART    = 12'h008;
parameter VXSAT     = 12'h009;
parameter VXRM      = 12'h00A;
parameter VL        = 12'hC20;
parameter VTYPE     = 12'hC21;
parameter VLENB     = 12'hC22;

//-------- User Counter/Timers ---------
parameter CYCLE    = 12'hC00;
parameter TIME     = 12'hC01;
parameter INSTRET  = 12'hC02;
parameter HPMCNT3  = 12'hC03;
parameter HPMCNT4  = 12'hC04;
parameter HPMCNT5  = 12'hC05;
parameter HPMCNT6  = 12'hC06;
parameter HPMCNT7  = 12'hC07;
parameter HPMCNT8  = 12'hC08;
parameter HPMCNT9  = 12'hC09;
parameter HPMCNT10 = 12'hC0A;
parameter HPMCNT11 = 12'hC0B;
parameter HPMCNT12 = 12'hC0C;
parameter HPMCNT13 = 12'hC0D;
parameter HPMCNT14 = 12'hC0E;
parameter HPMCNT15 = 12'hC0F;
parameter HPMCNT16 = 12'hC10;
parameter HPMCNT17 = 12'hC11;
parameter HPMCNT18 = 12'hC12;
parameter HPMCNT19 = 12'hC13;
parameter HPMCNT20 = 12'hC14;
parameter HPMCNT21 = 12'hC15;
parameter HPMCNT22 = 12'hC16;
parameter HPMCNT23 = 12'hC17;
parameter HPMCNT24 = 12'hC18;
parameter HPMCNT25 = 12'hC19;
parameter HPMCNT26 = 12'hC1A;
parameter HPMCNT27 = 12'hC1B;
parameter HPMCNT28 = 12'hC1C;
parameter HPMCNT29 = 12'hC1D;
parameter HPMCNT30 = 12'hC1E;
parameter HPMCNT31 = 12'hC1F;

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
parameter DCSR       = 12'h7B0;
parameter DPC        = 12'h7B1;
parameter DSCRATCH0  = 12'h7B2;
parameter DSCRATCH1  = 12'h7B3;

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
parameter TSELECT    = 12'h7A0;
parameter TDATA1     = 12'h7A1;
parameter TDATA2     = 12'h7A2;
parameter TDATA3     = 12'h7A3;
parameter TINFO      = 12'h7A4;
parameter TCONTROL   = 12'h7A5;
parameter MCONTEXT   = 12'h7A8;
parameter SCONTEXT   = 12'h7AA;

//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// 0x7C0-0x7FF
// parameter M_EXT_CSR0 = 12'b0111_11??_????;
// 0xBC0-0xBFF
// parameter M_EXT_CSR1 = 12'b1011_11??_????;
// 0xFC0-0xFFF
// parameter M_EXT_CSR2 = 12'b1111_11??_????;

// Processor Control and Status Extension 
parameter MXSTATUS   = 12'h7C0;
parameter MHCR       = 12'h7C1;
parameter MCOR       = 12'h7C2;
parameter MCCR2      = 12'h7C3;
parameter MCER2      = 12'h7C4;
parameter MHINT      = 12'h7C5;
parameter MRMR       = 12'h7C6;
parameter MRVBR      = 12'h7C7;
parameter MCER       = 12'h7C8;
parameter MCNTWEN    = 12'h7C9;
parameter MCNTINTEN  = 12'h7CA;
parameter MCNTOF     = 12'h7CB;
parameter MHINT2     = 12'h7CC;
parameter MHINT3     = 12'h7CD;
parameter MHINT4     = 12'h7CE;

//------ Processor Data Extension ------
parameter MCINS      = 12'h7D2;
parameter MCINDEX    = 12'h7D3;
parameter MCDATA0    = 12'h7D4;
parameter MCDATA1    = 12'h7D5;
parameter MEICR      = 12'h7D6;
parameter MEICR2     = 12'h7D7;

//------- Processor ID Extension -------
parameter MCPUID     = 12'hFC0;
parameter MAPBADDR   = 12'hFC1;

//-----------Debug Extension -----------
parameter MHALTCAUSE = 12'hFE0;
parameter MDBGINFO   = 12'hFE1;
parameter MPCFIFO    = 12'hFE2;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
parameter SXSTATUS   = 12'h5C0;
parameter SHCR       = 12'h5C1;
parameter SCER2      = 12'h5C2;
parameter SCER       = 12'h5C3;
parameter SCNTINTEN  = 12'h5C4;
parameter SCNTOF     = 12'h5C5;
parameter SHINT      = 12'h5C6;
parameter SHINT2     = 12'h5C7;
parameter SCNTIHBT   = 12'h5C8;
parameter SHPMCR     = 12'h5C9;
parameter SHPMSP     = 12'h5CA;
parameter SHPMEP     = 12'h5CB;

//----- Supervisor Counters/Timers -----
parameter SCYCLE     = 12'h5E0;
parameter SINSTRET   = 12'h5E2;
parameter SHPMCNT3   = 12'h5E3;
parameter SHPMCNT4   = 12'h5E4;
parameter SHPMCNT5   = 12'h5E5;
parameter SHPMCNT6   = 12'h5E6;
parameter SHPMCNT7   = 12'h5E7;
parameter SHPMCNT8   = 12'h5E8;
parameter SHPMCNT9   = 12'h5E9;
parameter SHPMCNT10  = 12'h5EA;
parameter SHPMCNT11  = 12'h5EB;
parameter SHPMCNT12  = 12'h5EC;
parameter SHPMCNT13  = 12'h5ED;
parameter SHPMCNT14  = 12'h5EE;
parameter SHPMCNT15  = 12'h5EF;
parameter SHPMCNT16  = 12'h5F0;
parameter SHPMCNT17  = 12'h5F1;
parameter SHPMCNT18  = 12'h5F2;
parameter SHPMCNT19  = 12'h5F3;
parameter SHPMCNT20  = 12'h5F4;
parameter SHPMCNT21  = 12'h5F5;
parameter SHPMCNT22  = 12'h5F6;
parameter SHPMCNT23  = 12'h5F7;
parameter SHPMCNT24  = 12'h5F8;
parameter SHPMCNT25  = 12'h5F9;
parameter SHPMCNT26  = 12'h5FA;
parameter SHPMCNT27  = 12'h5FB;
parameter SHPMCNT28  = 12'h5FC;
parameter SHPMCNT29  = 12'h5FD;
parameter SHPMCNT30  = 12'h5FE;
parameter SHPMCNT31  = 12'h5FF;

//------ TLB Operation Extension -------
parameter SMIR       = 12'h9C0;
parameter SMEL       = 12'h9C1;
parameter SMEH       = 12'h9C2;
parameter SMCIR      = 12'h9C3;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
parameter FXCR       = 12'h800;


//==========================================================
//                 CSRs Illegal Instruction
//==========================================================
// 1. Addr Illegal
// 2. access SATP in S mode && tvm
// 3. scounteren inhibit
// 4. mcounteren inhibit
// 5. !FS && float CSRs
// 6. !FS && vector CSRs
// assign regs_mmode = regs_pm[1:0] == 2'b11;
assign regs_smode = regs_pm[1:0] == 2'b01;
assign regs_umode = regs_pm[1:0] == 2'b00;
assign regs_csr_imm[11:0]   = iui_regs_imm[11:0];

assign regs_iui_trigger_mro   = regs_csr_imm[11:0] == TINFO;
assign regs_iui_trigger_smode = regs_csr_imm[11:0] == SCONTEXT;

// &CombBeg; @364
always @( regs_ext_imm_inv
       or regs_smode
       or regs_fs_off
       or rtu_yy_xx_dbgon
       or regs_csr_imm[11:0]
       or regs_ucnt_inv
       or regs_tvm)
begin
  casez(regs_csr_imm[11:0])
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
//--- Machine Information Registers ----
    MVENDORID,
    MARCHID,
    MIMPID,
    MHARTID   : regs_imm_inv = 1'b0;

//--------- Machine Trap Setup ---------
    MSTATUS,
    MISA,
    MEDELEG,
    MIDELEG,
    MIE,
    MTVEC,
    MCNTEN    : regs_imm_inv = 1'b0;

//------- Machine Trap Handling --------
    MSCRATCH,
    MEPC,
    MCAUSE,
    MTVAL,
    MIP       : regs_imm_inv = 1'b0;

//- Machine Protection and Translation -
    PMPCFG0,
    PMPCFG2,
    PMPADDR0,
    PMPADDR1,
    PMPADDR2,
    PMPADDR3,
    PMPADDR4,
    PMPADDR5,
    PMPADDR6,
    PMPADDR7,
    PMPADDR8,
    PMPADDR9,
    PMPADDR10,
    PMPADDR11,
    PMPADDR12,
    PMPADDR13,
    PMPADDR14,
    PMPADDR15 : regs_imm_inv = 1'b0;

//------ Machine Counters/Timers -------
    MCYCLE,
    MINSTRET,
    MHPMCNT3,
    MHPMCNT4,
    MHPMCNT5,
    MHPMCNT6,
    MHPMCNT7,
    MHPMCNT8,
    MHPMCNT9,
    MHPMCNT10,
    MHPMCNT11,
    MHPMCNT12,
    MHPMCNT13,
    MHPMCNT14,
    MHPMCNT15,
    MHPMCNT16,
    MHPMCNT17,
    MHPMCNT18,
    MHPMCNT19,
    MHPMCNT20,
    MHPMCNT21,
    MHPMCNT22,
    MHPMCNT23,
    MHPMCNT24,
    MHPMCNT25,
    MHPMCNT26,
    MHPMCNT27,
    MHPMCNT28,
    MHPMCNT29,
    MHPMCNT30,
    MHPMCNT31 : regs_imm_inv = 1'b0;

//------- Machine Counter Setup --------
    MCNTIHBT,
    MHPMEVT3,
    MHPMEVT4,
    MHPMEVT5,
    MHPMEVT6,
    MHPMEVT7,
    MHPMEVT8,
    MHPMEVT9,
    MHPMEVT10,
    MHPMEVT11,
    MHPMEVT12,
    MHPMEVT13,
    MHPMEVT14,
    MHPMEVT15,
    MHPMEVT16,
    MHPMEVT17,
    MHPMEVT18,
    MHPMEVT19,
    MHPMEVT20,
    MHPMEVT21,
    MHPMEVT22,
    MHPMEVT23,
    MHPMEVT24,
    MHPMEVT25,
    MHPMEVT26,
    MHPMEVT27,
    MHPMEVT28,
    MHPMEVT29,
    MHPMEVT30,
    MHPMEVT31 : regs_imm_inv = 1'b0;

//----------------------------------------------------------
//                  Supervisor Level CSRs
//----------------------------------------------------------
//------- Supervisor Trap Setup --------
    SSTATUS,
    SIE,
    STVEC,
    SCNTEN    : regs_imm_inv = 1'b0;

//------ Supervisor Trap Handling ------
    SSCRATCH,
    SEPC,
    SCAUSE,
    STVAL,
    SIP       : regs_imm_inv = 1'b0;

// Supervisor Protection and Translation 
    SATP      : regs_imm_inv = regs_smode && regs_tvm;

//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
    FFLAGS,
    FRM,
    FCSR      : regs_imm_inv = regs_fs_off;


//-------- User Counter/Timers ---------
    CYCLE,
    TIME,
    INSTRET,
    HPMCNT3,
    HPMCNT4,
    HPMCNT5,
    HPMCNT6,
    HPMCNT7,
    HPMCNT8,
    HPMCNT9,
    HPMCNT10,
    HPMCNT11,
    HPMCNT12,
    HPMCNT13,
    HPMCNT14,
    HPMCNT15,
    HPMCNT16,
    HPMCNT17,
    HPMCNT18,
    HPMCNT19,
    HPMCNT20,
    HPMCNT21,
    HPMCNT22,
    HPMCNT23,
    HPMCNT24,
    HPMCNT25,
    HPMCNT26,
    HPMCNT27,
    HPMCNT28,
    HPMCNT29,
    HPMCNT30,
    HPMCNT31 : regs_imm_inv = regs_ucnt_inv;

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
    DCSR,
    DPC,
    DSCRATCH0,
    DSCRATCH1 : regs_imm_inv = !rtu_yy_xx_dbgon;

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
    TSELECT,
    TDATA1,
    TDATA2,
    TDATA3,
    TINFO,
    TCONTROL,
    MCONTEXT,
    SCONTEXT :  regs_imm_inv = 1'b0;

//----------------------------------------------------------
//                  M-Mode Extension CSRs
//----------------------------------------------------------
// 0x7C0-0x7FF
    12'b0111_11??_????,
// 0xBC0-0xBFF
    12'b1011_11??_????,
// 0xFC0-0xFFF
    12'b1111_11??_????: regs_imm_inv = regs_ext_imm_inv;

//----------------------------------------------------------
//                  S-Mode Extension CSRs
//----------------------------------------------------------
// 0x5C0-0x5FF
    12'b0101_11??_????,
// 0x9C0-0x9FF
    12'b1001_11??_????,
// 0xDC0-0xDFF
    12'b1101_11??_????: regs_imm_inv = regs_ext_imm_inv;

//----------------------------------------------------------
//                  U-Mode Extension CSRs
//----------------------------------------------------------
// 0x800-0x8FF
    12'b1000_????_????,
// 0xCC0-0xCFF
    12'b1100_11??_????: regs_imm_inv = regs_ext_imm_inv;

    default   : regs_imm_inv = 1'b1;
  endcase
// &CombEnd; @599
end

//==========================================================
//                  Extension CSRs Invalid
//==========================================================
// &CombBeg; @604
always @( hpcp_cp0_sce
       or regs_smode
       or regs_fs_off
       or regs_csr_imm[11:0]
       or regs_scnt_inv)
begin
  case(regs_csr_imm[11:0])
//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    MXSTATUS,
    MHCR,
    MCOR,
    MCCR2,
    MCER2,
    MHINT,
    MRMR,
    MRVBR,
    MCER,
    MCNTWEN,
    MCNTINTEN,
    MCNTOF,
    MHINT2,
    MHINT3,
    MHINT4    : regs_ext_imm_inv = 1'b0;

//---------------- HPCP ----------------
    MHPMCR,
    MHPMSP,
    MHPMEP    : regs_ext_imm_inv = 1'b0;

//------ Processor Data Extension ------
    MCINS,
    MCINDEX,
    MCDATA0,
    MCDATA1,
    MEICR,
    MEICR2    : regs_ext_imm_inv = 1'b0;

//------- Processor ID Extension -------
    MCPUID,
    MAPBADDR  : regs_ext_imm_inv = 1'b0;

//------- Processor ID Extension -------
    MHALTCAUSE,
    MDBGINFO,
    MPCFIFO : regs_ext_imm_inv = 1'b0;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    SXSTATUS,
    SHCR,
    SCER2,
    SCER,
    SCNTINTEN,
    SCNTOF,
    SHINT,
    SHINT2,
    SCNTIHBT   : regs_ext_imm_inv = 1'b0;
    SHPMCR,
    SHPMSP,
    SHPMEP     : regs_ext_imm_inv = regs_smode && !hpcp_cp0_sce; 

//----- Supervisor Counters/Timers -----
    SCYCLE,
    SINSTRET,
    SHPMCNT3,
    SHPMCNT4,
    SHPMCNT5,
    SHPMCNT6,
    SHPMCNT7,
    SHPMCNT8,
    SHPMCNT9,
    SHPMCNT10,
    SHPMCNT11,
    SHPMCNT12,
    SHPMCNT13,
    SHPMCNT14,
    SHPMCNT15,
    SHPMCNT16,
    SHPMCNT17,
    SHPMCNT18,
    SHPMCNT19,
    SHPMCNT20,
    SHPMCNT21,
    SHPMCNT22,
    SHPMCNT23,
    SHPMCNT24,
    SHPMCNT25,
    SHPMCNT26,
    SHPMCNT27,
    SHPMCNT28,
    SHPMCNT29,
    SHPMCNT30,
    SHPMCNT31 : regs_ext_imm_inv = regs_scnt_inv;

//------ TLB Operation Extension -------
    SMIR,
    SMEL,
    SMEH,
    SMCIR     : regs_ext_imm_inv = 1'b0;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
    FXCR      : regs_ext_imm_inv = regs_fs_off;
    default   : regs_ext_imm_inv = 1'b0;
  endcase
// &CombEnd; @713
end

//==========================================================
//                    CSRs Write Decode
//==========================================================
assign regs_csr_wen = iui_regs_csr_wen;
assign regs_csr_wen_no_imm_ill = iui_regs_csr_wen_no_imm_ill;
assign regs_csr_write_no_imm_ill = iui_regs_csr_write_no_imm_ill;
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
//--- Machine Information Registers ----
// MVENDORID RO
// MARCHID   RO
// MIMPID    RO
// MHARTID   RO

//--------- Machine Trap Setup ---------
assign mstatus_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MSTATUS;
// MISA      Implement RO
assign medeleg_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MEDELEG;
assign mideleg_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MIDELEG;
assign mie_local_en       = regs_csr_wen && regs_csr_imm[11:0] == MIE;
assign mtvec_local_en     = regs_csr_wen && regs_csr_imm[11:0] == MTVEC;
assign mcnten_local_en    = regs_csr_wen && regs_csr_imm[11:0] == MCNTEN;

//------- Machine Trap Handling --------
assign mscratch_local_en  = regs_csr_wen && regs_csr_imm[11:0] == MSCRATCH;
assign mepc_local_en      = regs_csr_wen && regs_csr_imm[11:0] == MEPC;
assign mcause_local_en    = regs_csr_wen && regs_csr_imm[11:0] == MCAUSE;
assign mtval_local_en     = regs_csr_wen && regs_csr_imm[11:0] == MTVAL;
assign mip_local_en       = regs_csr_wen && regs_csr_imm[11:0] == MIP;

//- Machine Protection and Translation -
// PMPCFGx PMPADDRx in PMP

//------ Machine Counters/Timers -------
// MHPMCNTx in HPCP

//------- Machine Counter Setup --------
// MCNTIHBT, MHPMEVT in HPCP


//----------------------------------------------------------
//                  Supervisor Level CSRs
//----------------------------------------------------------
//------- Supervisor Trap Setup --------
assign sstatus_local_en   = regs_csr_wen && regs_csr_imm[11:0] == SSTATUS;
assign sie_local_en       = regs_csr_wen && regs_csr_imm[11:0] == SIE;
assign stvec_local_en     = regs_csr_wen && regs_csr_imm[11:0] == STVEC;
assign scnten_local_en    = regs_csr_wen && regs_csr_imm[11:0] == SCNTEN;

//------ Supervisor Trap Handling ------
assign sscratch_local_en  = regs_csr_wen && regs_csr_imm[11:0] == SSCRATCH;
assign sepc_local_en      = regs_csr_wen && regs_csr_imm[11:0] == SEPC;
assign scause_local_en    = regs_csr_wen && regs_csr_imm[11:0] == SCAUSE;
assign stval_local_en     = regs_csr_wen && regs_csr_imm[11:0] == STVAL;
assign sip_local_en       = regs_csr_wen && regs_csr_imm[11:0] == SIP;

// Supervisor Protection and Translation 
assign satp_local_en      = regs_csr_wen && regs_csr_imm[11:0] == SATP;


//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
assign fflags_local_en    = regs_csr_wen && regs_csr_imm[11:0] == FFLAGS;
assign frm_local_en       = regs_csr_wen && regs_csr_imm[11:0] == FRM;
assign fcsr_local_en      = regs_csr_wen && regs_csr_imm[11:0] == FCSR;

//---------- User Vector CSRs ----------
// VL        RO
// VTYPE     RO
// VLENB     RO

//-------- User Counter/Timers ---------
// HPMCNTx in HPCP


//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
assign mxstatus_local_en  = regs_csr_wen && regs_csr_imm[11:0] == MXSTATUS;
assign mhcr_local_en      = regs_csr_wen && regs_csr_imm[11:0] == MHCR;
assign mcor_local_en      = regs_csr_wen_no_imm_ill && regs_csr_imm[11:0] == MCOR;
// parameter MCCR2     = 12'h7C3;
// parameter MCER2     = 12'h7C4;
assign mhint_local_en     = regs_csr_wen && regs_csr_imm[11:0] == MHINT;
// parameter MRMR      = 12'h7C6;
// parameter MRVBR     = 12'h7C7;
// parameter MCER      = 12'h7C8;
assign mcntwen_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MCNTWEN;
// MCNTINTEN in HPCP
// MCNTOF    in HPCP
assign mhint2_local_en    = regs_csr_wen && regs_csr_imm[11:0] == MHINT2;
// parameter MHINT3    = 12'h7CD;
// parameter MHINT4    = 12'h7CE;
assign mhpmcr_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MHPMCR;

//------ Processor Data Extension ------
assign mcins_local_en     = regs_csr_wen_no_imm_ill && regs_csr_imm[11:0] == MCINS;
assign mcindex_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MCINDEX;
// parameter MCDATA0   = 12'h7D4;
// parameter MCDATA1   = 12'h7D5;
// parameter MEICR     = 12'h7D6;
// parameter MEICR2    = 12'h7D7;

//------- Processor ID Extension -------
assign mcpuid_local_en    = regs_csr_imm[11:0] == MCPUID;
// parameter MAPBADDR  = 12'hFC1;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
assign sxstatus_local_en  = regs_csr_wen && regs_csr_imm[11:0] == SXSTATUS;
// SHCR RO
// parameter SCER2     = 12'h5C2;
// parameter SCER      = 12'h5C3;
// SCNTINTEN in HPCP
// SCNTOF    in HPCP
// parameter SHINT     = 12'h5C6;
// parameter SHINT2    = 12'h5C7;

//----- Supervisor Counters/Timers -----
// SHPMCNTx in HPCP

//------ TLB Operation Extension -------
assign smcir_local_en     = regs_csr_wen && regs_csr_imm[11:0] == SMCIR;
assign smcir_local_en_raw = regs_csr_write_no_imm_ill && regs_csr_imm[11:0] == SMCIR;
// SMXX in MMU
//
assign shpmcr_local_en   = regs_csr_wen && regs_csr_imm[11:0] == SHPMCR;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
assign fxcr_local_en      = regs_csr_wen && regs_csr_imm[11:0] == FXCR;

//==========================================================
//                      CSRs Read Port
//==========================================================
// &CombBeg; @875
always @( scer2_value[63:0]
       or mhint3_value[63:0]
       or satp_value[63:0]
       or shint2_value[63:0]
       or sepc_value[63:0]
       or mxstatus_value[63:0]
       or mrvbr_value[63:0]
       or vxrm_value[63:0]
       or sip_value[63:0]
       or mip_value[63:0]
       or stvec_value[63:0]
       or mhartid_value[63:0]
       or mtvec_value[63:0]
       or hpcp_value[63:0]
       or mhint_value[63:0]
       or mcpuid_value[63:0]
       or vxsat_value[63:0]
       or mccr2_value[63:0]
       or mcindex_value[63:0]
       or mhint4_value[63:0]
       or mvendorid_value[63:0]
       or sxstatus_value[63:0]
       or frm_value[63:0]
       or scause_value[63:0]
       or meicr2_value[63:0]
       or mcause_value[63:0]
       or mcntwen_value[63:0]
       or sstatus_value[63:0]
       or scer_value[63:0]
       or mcer2_value[63:0]
       or mtval_value[63:0]
       or scnten_value[63:0]
       or mimpid_value[63:0]
       or vl_value[63:0]
       or marchid_value[63:0]
       or fxcr_value[63:0]
       or vlenb_value[63:0]
       or mmu_value[63:0]
       or mepc_value[63:0]
       or mideleg_value[63:0]
       or meicr_value[63:0]
       or mcdata1_value[63:0]
       or sie_value[63:0]
       or fflags_value[63:0]
       or mhcr_value[63:0]
       or fcsr_value[63:0]
       or mcer_value[63:0]
       or mscratch_value[63:0]
       or mcins_value[63:0]
       or mstatus_value[63:0]
       or shint_value[63:0]
       or medeleg_value[63:0]
       or pmp_value[63:0]
       or misa_value[63:0]
       or sscratch_value[63:0]
       or mie_value[63:0]
       or mrmr_value[63:0]
       or stval_value[63:0]
       or mcdata0_value[63:0]
       or regs_csr_imm[11:0]
       or mcnten_value[63:0]
       or mapbaddr_value[63:0]
       or shcr_value[63:0]
       or mhint2_value[63:0]
       or vtype_value[63:0]
       or dtu_cp0_rdata[63:0]
       or mcor_value[63:0]
       or vstart_value[63:0])
begin
  case (regs_csr_imm[11:0])
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
//--- Machine Information Registers ----
    MVENDORID : regs_csr_rdata[63:0] = mvendorid_value[63:0];
    MARCHID   : regs_csr_rdata[63:0] = marchid_value[63:0];
    MIMPID    : regs_csr_rdata[63:0] = mimpid_value[63:0];
    MHARTID   : regs_csr_rdata[63:0] = mhartid_value[63:0];

//--------- Machine Trap Setup ---------
    MSTATUS   : regs_csr_rdata[63:0] = mstatus_value[63:0];
    MISA      : regs_csr_rdata[63:0] = misa_value[63:0];
    MEDELEG   : regs_csr_rdata[63:0] = medeleg_value[63:0];
    MIDELEG   : regs_csr_rdata[63:0] = mideleg_value[63:0];
    MIE       : regs_csr_rdata[63:0] = mie_value[63:0];
    MTVEC     : regs_csr_rdata[63:0] = mtvec_value[63:0];
    MCNTEN    : regs_csr_rdata[63:0] = mcnten_value[63:0];

//------- Machine Trap Handling --------
    MSCRATCH  : regs_csr_rdata[63:0] = mscratch_value[63:0];
    MEPC      : regs_csr_rdata[63:0] = mepc_value[63:0];
    MCAUSE    : regs_csr_rdata[63:0] = mcause_value[63:0];
    MTVAL     : regs_csr_rdata[63:0] = mtval_value[63:0];
    MIP       : regs_csr_rdata[63:0] = mip_value[63:0];

//- Machine Protection and Translation -
    PMPCFG0,
    PMPCFG2,
    PMPADDR0,
    PMPADDR1,
    PMPADDR2,
    PMPADDR3,
    PMPADDR4,
    PMPADDR5,
    PMPADDR6,
    PMPADDR7,
    PMPADDR8,
    PMPADDR9,
    PMPADDR10,
    PMPADDR11,
    PMPADDR12,
    PMPADDR13,
    PMPADDR14,
    PMPADDR15 : regs_csr_rdata[63:0] = pmp_value[63:0];

//------ Machine Counters/Timers -------
    MCYCLE,
    MINSTRET,
    MHPMCNT3,
    MHPMCNT4,
    MHPMCNT5,
    MHPMCNT6,
    MHPMCNT7,
    MHPMCNT8,
    MHPMCNT9,
    MHPMCNT10,
    MHPMCNT11,
    MHPMCNT12,
    MHPMCNT13,
    MHPMCNT14,
    MHPMCNT15,
    MHPMCNT16,
    MHPMCNT17,
    MHPMCNT18,
    MHPMCNT19,
    MHPMCNT20,
    MHPMCNT21,
    MHPMCNT22,
    MHPMCNT23,
    MHPMCNT24,
    MHPMCNT25,
    MHPMCNT26,
    MHPMCNT27,
    MHPMCNT28,
    MHPMCNT29,
    MHPMCNT30,
    MHPMCNT31 : regs_csr_rdata[63:0] = hpcp_value[63:0];

//------- Machine Counter Setup --------
    MHPMCR,
    MHPMSP,
    MHPMEP,
    MCNTIHBT,
    MHPMEVT3,
    MHPMEVT4,
    MHPMEVT5,
    MHPMEVT6,
    MHPMEVT7,
    MHPMEVT8,
    MHPMEVT9,
    MHPMEVT10,
    MHPMEVT11,
    MHPMEVT12,
    MHPMEVT13,
    MHPMEVT14,
    MHPMEVT15,
    MHPMEVT16,
    MHPMEVT17,
    MHPMEVT18,
    MHPMEVT19,
    MHPMEVT20,
    MHPMEVT21,
    MHPMEVT22,
    MHPMEVT23,
    MHPMEVT24,
    MHPMEVT25,
    MHPMEVT26,
    MHPMEVT27,
    MHPMEVT28,
    MHPMEVT29,
    MHPMEVT30,
    MHPMEVT31 : regs_csr_rdata[63:0] = hpcp_value[63:0];

//----------------------------------------------------------
//                  Supervisor Level CSRs
//----------------------------------------------------------
//------- Supervisor Trap Setup --------
    SSTATUS   : regs_csr_rdata[63:0] = sstatus_value[63:0];
    SIE       : regs_csr_rdata[63:0] = sie_value[63:0];
    STVEC     : regs_csr_rdata[63:0] = stvec_value[63:0];
    SCNTEN    : regs_csr_rdata[63:0] = scnten_value[63:0];

//------ Supervisor Trap Handling ------
    SSCRATCH  : regs_csr_rdata[63:0] = sscratch_value[63:0];
    SEPC      : regs_csr_rdata[63:0] = sepc_value[63:0];
    SCAUSE    : regs_csr_rdata[63:0] = scause_value[63:0];
    STVAL     : regs_csr_rdata[63:0] = stval_value[63:0];
    SIP       : regs_csr_rdata[63:0] = sip_value[63:0];

// Supervisor Protection and Translation 
    SATP      : regs_csr_rdata[63:0] = satp_value[63:0];

//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
    FFLAGS    : regs_csr_rdata[63:0] = fflags_value[63:0];
    FRM       : regs_csr_rdata[63:0] = frm_value[63:0];
    FCSR      : regs_csr_rdata[63:0] = fcsr_value[63:0];

//---------- User Vector CSRs ----------
    VSTART    : regs_csr_rdata[63:0] = vstart_value[63:0];
    VXSAT     : regs_csr_rdata[63:0] = vxsat_value[63:0];
    VXRM      : regs_csr_rdata[63:0] = vxrm_value[63:0];
    VL        : regs_csr_rdata[63:0] = vl_value[63:0];
    VTYPE     : regs_csr_rdata[63:0] = vtype_value[63:0];
    VLENB     : regs_csr_rdata[63:0] = vlenb_value[63:0];

//-------- User Counter/Timers ---------
    CYCLE,
    TIME,
    INSTRET,
    HPMCNT3,
    HPMCNT4,
    HPMCNT5,
    HPMCNT6,
    HPMCNT7,
    HPMCNT8,
    HPMCNT9,
    HPMCNT10,
    HPMCNT11,
    HPMCNT12,
    HPMCNT13,
    HPMCNT14,
    HPMCNT15,
    HPMCNT16,
    HPMCNT17,
    HPMCNT18,
    HPMCNT19,
    HPMCNT20,
    HPMCNT21,
    HPMCNT22,
    HPMCNT23,
    HPMCNT24,
    HPMCNT25,
    HPMCNT26,
    HPMCNT27,
    HPMCNT28,
    HPMCNT29,
    HPMCNT30,
    HPMCNT31 : regs_csr_rdata[63:0] = hpcp_value[63:0];

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
    DCSR,
    DPC,
    DSCRATCH0,
    DSCRATCH1 : regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
    TSELECT,
    TDATA1,
    TDATA2,
    TDATA3,
    TINFO,
    TCONTROL,
    MCONTEXT,
    SCONTEXT :  regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    MXSTATUS  : regs_csr_rdata[63:0] = mxstatus_value[63:0];
    MHCR      : regs_csr_rdata[63:0] = mhcr_value[63:0];
    MCOR      : regs_csr_rdata[63:0] = mcor_value[63:0];
    MCCR2     : regs_csr_rdata[63:0] = mccr2_value[63:0];
    MCER2     : regs_csr_rdata[63:0] = mcer2_value[63:0];
    MHINT     : regs_csr_rdata[63:0] = mhint_value[63:0];
    MRMR      : regs_csr_rdata[63:0] = mrmr_value[63:0];
    MRVBR     : regs_csr_rdata[63:0] = mrvbr_value[63:0];
    MCER      : regs_csr_rdata[63:0] = mcer_value[63:0];
    MCNTWEN   : regs_csr_rdata[63:0] = mcntwen_value[63:0];
    MCNTINTEN : regs_csr_rdata[63:0] = hpcp_value[63:0];
    MCNTOF    : regs_csr_rdata[63:0] = hpcp_value[63:0];
    MHINT2    : regs_csr_rdata[63:0] = mhint2_value[63:0];
    MHINT3    : regs_csr_rdata[63:0] = mhint3_value[63:0];
    MHINT4    : regs_csr_rdata[63:0] = mhint4_value[63:0];

//------ Processor Data Extension ------
    MCINS     : regs_csr_rdata[63:0] = mcins_value[63:0];
    MCINDEX   : regs_csr_rdata[63:0] = mcindex_value[63:0];
    MCDATA0   : regs_csr_rdata[63:0] = mcdata0_value[63:0];
    MCDATA1   : regs_csr_rdata[63:0] = mcdata1_value[63:0];
    MEICR     : regs_csr_rdata[63:0] = meicr_value[63:0];
    MEICR2    : regs_csr_rdata[63:0] = meicr2_value[63:0];

//------- Processor ID Extension -------
    MCPUID    : regs_csr_rdata[63:0] = mcpuid_value[63:0];
    MAPBADDR  : regs_csr_rdata[63:0] = mapbaddr_value[63:0];

//------------Debug Extension-----------
    MHALTCAUSE,
    MDBGINFO,
    MPCFIFO   : regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    SXSTATUS  : regs_csr_rdata[63:0] = sxstatus_value[63:0];
    SHCR      : regs_csr_rdata[63:0] = shcr_value[63:0];
    SCER2     : regs_csr_rdata[63:0] = scer2_value[63:0];
    SCER      : regs_csr_rdata[63:0] = scer_value[63:0];
    SCNTINTEN : regs_csr_rdata[63:0] = hpcp_value[63:0];
    SCNTOF    : regs_csr_rdata[63:0] = hpcp_value[63:0];
    SHINT     : regs_csr_rdata[63:0] = shint_value[63:0];
    SHINT2    : regs_csr_rdata[63:0] = shint2_value[63:0];
    SCNTIHBT,       
    SHPMCR,
    SHPMSP,
    SHPMEP    : regs_csr_rdata[63:0] = hpcp_value[63:0];


//----- Supervisor Counters/Timers -----
    SCYCLE,
    SINSTRET,
    SHPMCNT3,
    SHPMCNT4,
    SHPMCNT5,
    SHPMCNT6,
    SHPMCNT7,
    SHPMCNT8,
    SHPMCNT9,
    SHPMCNT10,
    SHPMCNT11,
    SHPMCNT12,
    SHPMCNT13,
    SHPMCNT14,
    SHPMCNT15,
    SHPMCNT16,
    SHPMCNT17,
    SHPMCNT18,
    SHPMCNT19,
    SHPMCNT20,
    SHPMCNT21,
    SHPMCNT22,
    SHPMCNT23,
    SHPMCNT24,
    SHPMCNT25,
    SHPMCNT26,
    SHPMCNT27,
    SHPMCNT28,
    SHPMCNT29,
    SHPMCNT30,
    SHPMCNT31 : regs_csr_rdata[63:0] = hpcp_value[63:0];

//------ TLB Operation Extension -------
    SMIR,
    SMEL,
    SMEH,
    SMCIR : regs_csr_rdata[63:0] = mmu_value[63:0];

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
    FXCR      : regs_csr_rdata[63:0] = fxcr_value[63:0];

    default   : regs_csr_rdata[63:0] = 64'b0; 
  endcase
// &CombEnd; @1181
end


//==========================================================
//                 Regs Read Data For Write
//==========================================================

// &CombBeg; @1188
always @( sip_raw[63:0]
       or regs_csr_rdata[63:0]
       or regs_csr_imm[11:0])
begin
  case (regs_csr_imm[11:0])
    MIP, SIP: regs_csr_rdata_for_w[63:0] = sip_raw[63:0];
    default : regs_csr_rdata_for_w[63:0] = regs_csr_rdata[63:0]; 
  endcase
// &CombEnd; @1193
end

//==========================================================
//                      CSRs Instance
//==========================================================
// &Instance("aq_cp0_info_csr"); @1198
aq_cp0_info_csr  x_aq_cp0_info_csr (
  .biu_cp0_coreid  (biu_cp0_coreid ),
  .cpurst_b        (cpurst_b       ),
  .iui_regs_csr_en (iui_regs_csr_en),
  .marchid_value   (marchid_value  ),
  .mcpuid_local_en (mcpuid_local_en),
  .mcpuid_value    (mcpuid_value   ),
  .mhartid_value   (mhartid_value  ),
  .mimpid_value    (mimpid_value   ),
  .misa_value      (misa_value     ),
  .mvendorid_value (mvendorid_value),
  .regs_clk        (regs_clk       ),
  .regs_mxl        (regs_mxl       )
);


// &Instance("aq_cp0_trap_csr"); @1200
aq_cp0_trap_csr  x_aq_cp0_trap_csr (
  .biu_cp0_me_int           (biu_cp0_me_int          ),
  .biu_cp0_ms_int           (biu_cp0_ms_int          ),
  .biu_cp0_mt_int           (biu_cp0_mt_int          ),
  .biu_cp0_se_int           (biu_cp0_se_int          ),
  .biu_cp0_ss_int           (biu_cp0_ss_int          ),
  .biu_cp0_st_int           (biu_cp0_st_int          ),
  .cp0_dtu_mexpt_vld        (cp0_dtu_mexpt_vld       ),
  .cp0_hpcp_int_off_vld     (cp0_hpcp_int_off_vld    ),
  .cp0_idu_fs               (cp0_idu_fs              ),
  .cp0_idu_vs               (cp0_idu_vs              ),
  .cp0_lsu_mpp              (cp0_lsu_mpp             ),
  .cp0_lsu_mprv             (cp0_lsu_mprv            ),
  .cp0_mmu_mxr              (cp0_mmu_mxr             ),
  .cp0_mmu_sum              (cp0_mmu_sum             ),
  .cp0_rtu_int_vld          (cp0_rtu_int_vld         ),
  .cp0_rtu_trap_pc          (cp0_rtu_trap_pc         ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .dtu_cp0_dcsr_mprven      (dtu_cp0_dcsr_mprven     ),
  .dtu_cp0_dcsr_prv         (dtu_cp0_dcsr_prv        ),
  .fcsr_local_en            (fcsr_local_en           ),
  .fflags_local_en          (fflags_local_en         ),
  .float_clk                (float_clk               ),
  .frm_local_en             (frm_local_en            ),
  .fs_dirty_upd_gate        (fs_dirty_upd_gate       ),
  .fxcr_local_en            (fxcr_local_en           ),
  .hpcp_cp0_int_vld         (hpcp_cp0_int_vld        ),
  .iui_regs_inst_mret       (iui_regs_inst_mret      ),
  .iui_regs_inst_sret       (iui_regs_inst_sret      ),
  .iui_regs_wdata           (iui_regs_wdata          ),
  .mcause_local_en          (mcause_local_en         ),
  .mcause_value             (mcause_value            ),
  .medeleg_local_en         (medeleg_local_en        ),
  .medeleg_value            (medeleg_value           ),
  .mepc_local_en            (mepc_local_en           ),
  .mepc_value               (mepc_value              ),
  .mideleg_local_en         (mideleg_local_en        ),
  .mideleg_value            (mideleg_value           ),
  .mie_local_en             (mie_local_en            ),
  .mie_value                (mie_value               ),
  .mip_local_en             (mip_local_en            ),
  .mip_value                (mip_value               ),
  .mscratch_local_en        (mscratch_local_en       ),
  .mscratch_value           (mscratch_value          ),
  .mstatus_local_en         (mstatus_local_en        ),
  .mstatus_value            (mstatus_value           ),
  .mtval_local_en           (mtval_local_en          ),
  .mtval_value              (mtval_value             ),
  .mtvec_local_en           (mtvec_local_en          ),
  .mtvec_value              (mtvec_value             ),
  .regs_clintee             (regs_clintee            ),
  .regs_clk                 (regs_clk                ),
  .regs_flush_clk           (regs_flush_clk          ),
  .regs_fs_off              (regs_fs_off             ),
  .regs_iui_mepc            (regs_iui_mepc           ),
  .regs_iui_pm              (regs_iui_pm             ),
  .regs_iui_sepc            (regs_iui_sepc           ),
  .regs_iui_tsr             (regs_iui_tsr            ),
  .regs_iui_tvm             (regs_iui_tvm            ),
  .regs_iui_tw              (regs_iui_tw             ),
  .regs_lpmd_int_vld        (regs_lpmd_int_vld       ),
  .regs_mxl                 (regs_mxl                ),
  .regs_pm                  (regs_pm                 ),
  .regs_tvm                 (regs_tvm                ),
  .rtu_cp0_epc              (rtu_cp0_epc             ),
  .rtu_cp0_exit_debug       (rtu_cp0_exit_debug      ),
  .rtu_cp0_fs_dirty_updt    (rtu_cp0_fs_dirty_updt   ),
  .rtu_cp0_fs_dirty_updt_dp (rtu_cp0_fs_dirty_updt_dp),
  .rtu_cp0_tval             (rtu_cp0_tval            ),
  .rtu_cp0_vs_dirty_updt    (rtu_cp0_vs_dirty_updt   ),
  .rtu_cp0_vs_dirty_updt_dp (rtu_cp0_vs_dirty_updt_dp),
  .rtu_yy_xx_dbgon          (rtu_yy_xx_dbgon         ),
  .rtu_yy_xx_expt_int       (rtu_yy_xx_expt_int      ),
  .rtu_yy_xx_expt_vec       (rtu_yy_xx_expt_vec      ),
  .rtu_yy_xx_expt_vld       (rtu_yy_xx_expt_vld      ),
  .scause_local_en          (scause_local_en         ),
  .scause_value             (scause_value            ),
  .sepc_local_en            (sepc_local_en           ),
  .sepc_value               (sepc_value              ),
  .sie_local_en             (sie_local_en            ),
  .sie_value                (sie_value               ),
  .sip_local_en             (sip_local_en            ),
  .sip_raw                  (sip_raw                 ),
  .sip_value                (sip_value               ),
  .sscratch_local_en        (sscratch_local_en       ),
  .sscratch_value           (sscratch_value          ),
  .sstatus_local_en         (sstatus_local_en        ),
  .sstatus_value            (sstatus_value           ),
  .stval_local_en           (stval_local_en          ),
  .stval_value              (stval_value             ),
  .stvec_local_en           (stvec_local_en          ),
  .stvec_value              (stvec_value             ),
  .vs_dirty_upd_gate        (vs_dirty_upd_gate       )
);


// &Instance("aq_cp0_prtc_csr"); @1202
aq_cp0_prtc_csr  x_aq_cp0_prtc_csr (
  .cp0_dtu_satp         (cp0_dtu_satp        ),
  .cp0_mmu_satp_data    (cp0_mmu_satp_data   ),
  .cp0_mmu_satp_wen     (cp0_mmu_satp_wen    ),
  .cpurst_b             (cpurst_b            ),
  .iui_regs_wdata       (iui_regs_wdata      ),
  .mmu_cp0_cmplt        (mmu_cp0_cmplt       ),
  .mmu_cp0_data         (mmu_cp0_data        ),
  .mmu_value            (mmu_value           ),
  .pmp_cp0_data         (pmp_cp0_data        ),
  .pmp_value            (pmp_value           ),
  .regs_clk             (regs_clk            ),
  .regs_iui_smcir_stall (regs_iui_smcir_stall),
  .satp_local_en        (satp_local_en       ),
  .satp_value           (satp_value          ),
  .smcir_local_en       (smcir_local_en      ),
  .smcir_local_en_raw   (smcir_local_en_raw  )
);


// &Instance("aq_cp0_hpcp_csr"); @1204
aq_cp0_hpcp_csr  x_aq_cp0_hpcp_csr (
  .cp0_hpcp_mcntwen   (cp0_hpcp_mcntwen  ),
  .cpurst_b           (cpurst_b          ),
  .hpcp_cp0_data      (hpcp_cp0_data     ),
  .hpcp_value         (hpcp_value        ),
  .iui_regs_csr_write (iui_regs_csr_write),
  .iui_regs_imm       (iui_regs_imm      ),
  .iui_regs_wdata     (iui_regs_wdata    ),
  .mcnten_local_en    (mcnten_local_en   ),
  .mcnten_value       (mcnten_value      ),
  .mcntwen_local_en   (mcntwen_local_en  ),
  .mcntwen_value      (mcntwen_value     ),
  .regs_clk           (regs_clk          ),
  .regs_scnt_inv      (regs_scnt_inv     ),
  .regs_smode         (regs_smode        ),
  .regs_ucnt_inv      (regs_ucnt_inv     ),
  .regs_umode         (regs_umode        ),
  .scnten_local_en    (scnten_local_en   ),
  .scnten_value       (scnten_value      )
);


// &Instance("aq_cp0_float_csr"); @1206
aq_cp0_float_csr  x_aq_cp0_float_csr (
  .cp0_idu_frm            (cp0_idu_frm           ),
  .cp0_idu_vill           (cp0_idu_vill          ),
  .cp0_idu_vl_zero        (cp0_idu_vl_zero       ),
  .cp0_idu_vlmul          (cp0_idu_vlmul         ),
  .cp0_idu_vsew           (cp0_idu_vsew          ),
  .cp0_idu_vstart         (cp0_idu_vstart        ),
  .cp0_rtu_vstart_eq_0    (cp0_rtu_vstart_eq_0   ),
  .cp0_vpu_xx_bf16        (cp0_vpu_xx_bf16       ),
  .cp0_vpu_xx_dqnan       (cp0_vpu_xx_dqnan      ),
  .cp0_vpu_xx_rm          (cp0_vpu_xx_rm         ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .fcsr_local_en          (fcsr_local_en         ),
  .fcsr_value             (fcsr_value            ),
  .fflags_local_en        (fflags_local_en       ),
  .fflags_value           (fflags_value          ),
  .float_clk              (float_clk             ),
  .forever_cpuclk         (forever_cpuclk        ),
  .frm_local_en           (frm_local_en          ),
  .frm_value              (frm_value             ),
  .fs_dirty_upd_gate      (fs_dirty_upd_gate     ),
  .fxcr_local_en          (fxcr_local_en         ),
  .fxcr_value             (fxcr_value            ),
  .iui_inst_rs2           (iui_inst_rs2          ),
  .iui_regs_csr_wen       (iui_regs_csr_wen      ),
  .iui_regs_wdata         (iui_regs_wdata        ),
  .iui_vsetvl_bypass      (iui_vsetvl_bypass     ),
  .iui_vsetvl_data        (iui_vsetvl_data       ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .regs_clk               (regs_clk              ),
  .regs_xx_icg_en         (regs_xx_icg_en        ),
  .rtu_cp0_fflags         (rtu_cp0_fflags        ),
  .rtu_cp0_fflags_updt    (rtu_cp0_fflags_updt   ),
  .rtu_cp0_vl             (rtu_cp0_vl            ),
  .rtu_cp0_vl_vld         (rtu_cp0_vl_vld        ),
  .rtu_cp0_vstart         (rtu_cp0_vstart        ),
  .rtu_cp0_vstart_vld     (rtu_cp0_vstart_vld    ),
  .rtu_cp0_vxsat          (rtu_cp0_vxsat         ),
  .rtu_cp0_vxsat_vld      (rtu_cp0_vxsat_vld     ),
  .special_regs_vill      (special_regs_vill     ),
  .special_regs_vsetvl_dp (special_regs_vsetvl_dp),
  .special_vsetvl_illegal (special_vsetvl_illegal),
  .vl_value               (vl_value              ),
  .vlenb_value            (vlenb_value           ),
  .vs_dirty_upd_gate      (vs_dirty_upd_gate     ),
  .vstart_value           (vstart_value          ),
  .vtype_value            (vtype_value           ),
  .vxrm_value             (vxrm_value            ),
  .vxsat_value            (vxsat_value           )
);


// &Instance("aq_cp0_ext_csr"); @1208
aq_cp0_ext_csr  x_aq_cp0_ext_csr (
  .biu_cp0_rvba                 (biu_cp0_rvba                ),
  .cp0_biu_icg_en               (cp0_biu_icg_en              ),
  .cp0_dtu_icg_en               (cp0_dtu_icg_en              ),
  .cp0_dtu_pcfifo_frz           (cp0_dtu_pcfifo_frz          ),
  .cp0_hpcp_icg_en              (cp0_hpcp_icg_en             ),
  .cp0_hpcp_pmdm                (cp0_hpcp_pmdm               ),
  .cp0_hpcp_pmds                (cp0_hpcp_pmds               ),
  .cp0_hpcp_pmdu                (cp0_hpcp_pmdu               ),
  .cp0_idu_cskyee               (cp0_idu_cskyee              ),
  .cp0_idu_dis_fence_in_dbg     (cp0_idu_dis_fence_in_dbg    ),
  .cp0_idu_icg_en               (cp0_idu_icg_en              ),
  .cp0_idu_ucme                 (cp0_idu_ucme                ),
  .cp0_ifu_bht_en               (cp0_ifu_bht_en              ),
  .cp0_ifu_btb_clr              (cp0_ifu_btb_clr             ),
  .cp0_ifu_btb_en               (cp0_ifu_btb_en              ),
  .cp0_ifu_icache_en            (cp0_ifu_icache_en           ),
  .cp0_ifu_icache_pref_en       (cp0_ifu_icache_pref_en      ),
  .cp0_ifu_icache_read_index    (cp0_ifu_icache_read_index   ),
  .cp0_ifu_icache_read_req      (cp0_ifu_icache_read_req     ),
  .cp0_ifu_icache_read_tag      (cp0_ifu_icache_read_tag     ),
  .cp0_ifu_icache_read_way      (cp0_ifu_icache_read_way     ),
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_ifu_iwpe                 (cp0_ifu_iwpe                ),
  .cp0_ifu_ras_en               (cp0_ifu_ras_en              ),
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_lsu_amr                  (cp0_lsu_amr                 ),
  .cp0_lsu_dcache_en            (cp0_lsu_dcache_en           ),
  .cp0_lsu_dcache_pref_dist     (cp0_lsu_dcache_pref_dist    ),
  .cp0_lsu_dcache_pref_en       (cp0_lsu_dcache_pref_en      ),
  .cp0_lsu_dcache_read_idx      (cp0_lsu_dcache_read_idx     ),
  .cp0_lsu_dcache_read_req      (cp0_lsu_dcache_read_req     ),
  .cp0_lsu_dcache_read_type     (cp0_lsu_dcache_read_type    ),
  .cp0_lsu_dcache_read_way      (cp0_lsu_dcache_read_way     ),
  .cp0_lsu_dcache_wa            (cp0_lsu_dcache_wa           ),
  .cp0_lsu_dcache_wb            (cp0_lsu_dcache_wb           ),
  .cp0_lsu_icg_en               (cp0_lsu_icg_en              ),
  .cp0_lsu_mm                   (cp0_lsu_mm                  ),
  .cp0_lsu_we_en                (cp0_lsu_we_en               ),
  .cp0_mmu_icg_en               (cp0_mmu_icg_en              ),
  .cp0_mmu_maee                 (cp0_mmu_maee                ),
  .cp0_mmu_ptw_en               (cp0_mmu_ptw_en              ),
  .cp0_pmp_icg_en               (cp0_pmp_icg_en              ),
  .cp0_rtu_icg_en               (cp0_rtu_icg_en              ),
  .cp0_vpu_icg_en               (cp0_vpu_icg_en              ),
  .cp0_xx_mrvbr                 (cp0_xx_mrvbr                ),
  .cpurst_b                     (cpurst_b                    ),
  .ifu_cp0_bht_inv_done         (ifu_cp0_bht_inv_done        ),
  .ifu_cp0_icache_inv_done      (ifu_cp0_icache_inv_done     ),
  .ifu_cp0_icache_read_data     (ifu_cp0_icache_read_data    ),
  .ifu_cp0_icache_read_data_vld (ifu_cp0_icache_read_data_vld),
  .iui_regs_wdata               (iui_regs_wdata              ),
  .lsu_cp0_dcache_read_data     (lsu_cp0_dcache_read_data    ),
  .lsu_cp0_dcache_read_data_vld (lsu_cp0_dcache_read_data_vld),
  .lsu_cp0_icc_done             (lsu_cp0_icc_done            ),
  .mapbaddr_value               (mapbaddr_value              ),
  .mccr2_value                  (mccr2_value                 ),
  .mcdata0_value                (mcdata0_value               ),
  .mcdata1_value                (mcdata1_value               ),
  .mcer2_value                  (mcer2_value                 ),
  .mcer_value                   (mcer_value                  ),
  .mcindex_local_en             (mcindex_local_en            ),
  .mcindex_value                (mcindex_value               ),
  .mcins_local_en               (mcins_local_en              ),
  .mcins_value                  (mcins_value                 ),
  .mcor_local_en                (mcor_local_en               ),
  .mcor_value                   (mcor_value                  ),
  .meicr2_value                 (meicr2_value                ),
  .meicr_value                  (meicr_value                 ),
  .mhcr_local_en                (mhcr_local_en               ),
  .mhcr_value                   (mhcr_value                  ),
  .mhint2_local_en              (mhint2_local_en             ),
  .mhint2_value                 (mhint2_value                ),
  .mhint3_value                 (mhint3_value                ),
  .mhint4_value                 (mhint4_value                ),
  .mhint_local_en               (mhint_local_en              ),
  .mhint_value                  (mhint_value                 ),
  .mhpmcr_local_en              (mhpmcr_local_en             ),
  .mrmr_value                   (mrmr_value                  ),
  .mrvbr_value                  (mrvbr_value                 ),
  .mxstatus_local_en            (mxstatus_local_en           ),
  .mxstatus_value               (mxstatus_value              ),
  .regs_clintee                 (regs_clintee                ),
  .regs_clk                     (regs_clk                    ),
  .regs_flush_clk               (regs_flush_clk              ),
  .regs_iui_mcins_stall         (regs_iui_mcins_stall        ),
  .regs_iui_mcor_stall          (regs_iui_mcor_stall         ),
  .regs_mcins_busy              (regs_mcins_busy             ),
  .regs_mcor_busy               (regs_mcor_busy              ),
  .regs_pm                      (regs_pm                     ),
  .regs_special_bht_inv         (regs_special_bht_inv        ),
  .regs_special_dcache_clr      (regs_special_dcache_clr     ),
  .regs_special_dcache_inv      (regs_special_dcache_inv     ),
  .regs_special_dcache_req      (regs_special_dcache_req     ),
  .regs_special_icache_inv      (regs_special_icache_inv     ),
  .regs_xx_icg_en               (regs_xx_icg_en              ),
  .rtu_yy_xx_flush              (rtu_yy_xx_flush             ),
  .scer2_value                  (scer2_value                 ),
  .scer_value                   (scer_value                  ),
  .shcr_value                   (shcr_value                  ),
  .shint2_value                 (shint2_value                ),
  .shint_value                  (shint_value                 ),
  .shpmcr_local_en              (shpmcr_local_en             ),
  .sxstatus_local_en            (sxstatus_local_en           ),
  .sxstatus_value               (sxstatus_value              ),
  .sysio_cp0_apb_base           (sysio_cp0_apb_base          )
);


//==========================================================
//                           ICG
//==========================================================
assign regs_clk_en = iui_regs_csr_write
                  || iui_regs_csr_en && mcpuid_local_en;
// &Instance("gated_clk_cell", "x_regs_clk"); @1215
gated_clk_cell  x_regs_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_clk_en       ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1216
//          .external_en (1'b0), @1217
//          .global_en   (cp0_yy_clk_en), @1218
//          .module_en   (regs_xx_icg_en), @1219
//          .local_en    (regs_clk_en), @1220
//          .clk_out     (regs_clk)); @1221

assign regs_flush_clk_en = rtu_cp0_exit_debug
                        || iui_regs_csr_wen
                        || iui_regs_inst_mret
                        || iui_regs_inst_sret
                        || rtu_yy_xx_expt_vld
                        || regs_mcor_busy
                        || regs_mcins_busy;
// &Instance("gated_clk_cell", "x_regs_flush_clk"); @1230
gated_clk_cell  x_regs_flush_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_flush_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_flush_clk_en ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1231
//          .external_en (1'b0), @1232
//          .global_en   (cp0_yy_clk_en), @1233
//          .module_en   (regs_xx_icg_en), @1234
//          .local_en    (regs_flush_clk_en), @1235
//          .clk_out     (regs_flush_clk)); @1236

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_iui_csr_inv           = regs_imm_inv;
assign regs_iui_rdata[63:0]       = regs_csr_rdata[63:0];
assign regs_iui_rdata_for_w[63:0] = regs_csr_rdata_for_w[63:0];

// &Force("output", "regs_xx_icg_en"); @1248
// &Force("output", "regs_clk"); @1249

// &ModuleEnd; @1251
endmodule



