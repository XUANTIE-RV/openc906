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

// &Depend("cpu_cfig.h"); @23

// &ModuleBeg; @25
module aq_core(
  biu_cp0_coreid,
  biu_cp0_me_int,
  biu_cp0_ms_int,
  biu_cp0_mt_int,
  biu_cp0_rvba,
  biu_cp0_se_int,
  biu_cp0_ss_int,
  biu_cp0_st_int,
  biu_ifu_arready,
  biu_ifu_rdata,
  biu_ifu_rid,
  biu_ifu_rlast,
  biu_ifu_rresp,
  biu_ifu_rvalid,
  biu_lsu_arready,
  biu_lsu_no_op,
  biu_lsu_rdata,
  biu_lsu_rid,
  biu_lsu_rlast,
  biu_lsu_rresp,
  biu_lsu_rvalid,
  biu_lsu_stb_awready,
  biu_lsu_stb_wready,
  biu_lsu_vb_awready,
  biu_lsu_vb_wready,
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
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  dtu_cp0_dcsr_mprven,
  dtu_cp0_dcsr_prv,
  dtu_cp0_rdata,
  dtu_cp0_wake_up,
  dtu_ifu_debug_inst,
  dtu_ifu_debug_inst_vld,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  dtu_ifu_halt_info_vld,
  dtu_ifu_halt_on_reset,
  dtu_lsu_addr_trig_en,
  dtu_lsu_data_trig_en,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  dtu_rtu_async_halt_req,
  dtu_rtu_dpc,
  dtu_rtu_ebreak_action,
  dtu_rtu_int_mask,
  dtu_rtu_pending_tval,
  dtu_rtu_resume_req,
  dtu_rtu_step_en,
  dtu_rtu_sync_flush,
  dtu_rtu_sync_halt_req,
  forever_cpuclk,
  hpcp_cp0_data,
  hpcp_cp0_int_vld,
  hpcp_cp0_sce,
  hpcp_idu_cnt_en,
  hpcp_ifu_cnt_en,
  hpcp_iu_cnt_en,
  hpcp_lsu_cnt_en,
  hpcp_rtu_cnt_en,
  idu_dtu_debug_info,
  idu_hpcp_backend_stall,
  idu_hpcp_frontend_stall,
  idu_hpcp_inst_type,
  ifu_biu_araddr,
  ifu_biu_arburst,
  ifu_biu_arcache,
  ifu_biu_arid,
  ifu_biu_arlen,
  ifu_biu_arprot,
  ifu_biu_arsize,
  ifu_biu_arvalid,
  ifu_dtu_addr_vld0,
  ifu_dtu_addr_vld1,
  ifu_dtu_data_vld0,
  ifu_dtu_data_vld1,
  ifu_dtu_debug_info,
  ifu_dtu_exe_addr0,
  ifu_dtu_exe_addr1,
  ifu_dtu_exe_data0,
  ifu_dtu_exe_data1,
  ifu_hpcp_icache_access,
  ifu_hpcp_icache_miss,
  ifu_mmu_abort,
  ifu_mmu_va,
  ifu_mmu_va_vld,
  iu_dtu_debug_info,
  iu_hpcp_inst_bht_mispred,
  iu_hpcp_inst_condbr,
  iu_hpcp_jump_8m,
  lsu_biu_araddr,
  lsu_biu_arburst,
  lsu_biu_arcache,
  lsu_biu_arid,
  lsu_biu_arlen,
  lsu_biu_arprot,
  lsu_biu_arsize,
  lsu_biu_aruser,
  lsu_biu_arvalid,
  lsu_biu_stb_awaddr,
  lsu_biu_stb_awburst,
  lsu_biu_stb_awcache,
  lsu_biu_stb_awid,
  lsu_biu_stb_awlen,
  lsu_biu_stb_awprot,
  lsu_biu_stb_awsize,
  lsu_biu_stb_awuser,
  lsu_biu_stb_awvalid,
  lsu_biu_stb_wdata,
  lsu_biu_stb_wlast,
  lsu_biu_stb_wstrb,
  lsu_biu_stb_wvalid,
  lsu_biu_vb_awaddr,
  lsu_biu_vb_awburst,
  lsu_biu_vb_awcache,
  lsu_biu_vb_awid,
  lsu_biu_vb_awlen,
  lsu_biu_vb_awprot,
  lsu_biu_vb_awsize,
  lsu_biu_vb_awvalid,
  lsu_biu_vb_wdata,
  lsu_biu_vb_wlast,
  lsu_biu_vb_wstrb,
  lsu_biu_vb_wvalid,
  lsu_dtu_debug_info,
  lsu_dtu_halt_info,
  lsu_dtu_last_check,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  lsu_dtu_ldst_type,
  lsu_dtu_mem_access_size,
  lsu_hpcp_cache_read_access,
  lsu_hpcp_cache_read_miss,
  lsu_hpcp_cache_write_access,
  lsu_hpcp_cache_write_miss,
  lsu_hpcp_inst_store,
  lsu_hpcp_unalign_inst,
  lsu_mmu_abort,
  lsu_mmu_bus_error,
  lsu_mmu_data,
  lsu_mmu_data_vld,
  lsu_mmu_priv_mode,
  lsu_mmu_st_inst,
  lsu_mmu_va,
  lsu_mmu_va_vld,
  mmu_cp0_cmplt,
  mmu_cp0_data,
  mmu_cp0_tlb_inv_done,
  mmu_ifu_access_fault,
  mmu_ifu_pa,
  mmu_ifu_pa_vld,
  mmu_ifu_prot,
  mmu_lsu_access_fault,
  mmu_lsu_buf,
  mmu_lsu_ca,
  mmu_lsu_data_req,
  mmu_lsu_data_req_addr,
  mmu_lsu_data_req_size,
  mmu_lsu_pa,
  mmu_lsu_pa_vld,
  mmu_lsu_page_fault,
  mmu_lsu_sec,
  mmu_lsu_sh,
  mmu_lsu_so,
  mmu_xx_mmu_en,
  mmu_yy_xx_no_op,
  pad_yy_icg_scan_en,
  pad_yy_scan_mode,
  pmp_cp0_data,
  rtu_cpu_no_retire,
  rtu_dtu_debug_info,
  rtu_dtu_dpc,
  rtu_dtu_halt_ack,
  rtu_dtu_pending_ack,
  rtu_dtu_retire_chgflw,
  rtu_dtu_retire_debug_expt_vld,
  rtu_dtu_retire_halt_info,
  rtu_dtu_retire_mret,
  rtu_dtu_retire_next_pc,
  rtu_dtu_retire_sret,
  rtu_dtu_retire_vld,
  rtu_dtu_tval,
  rtu_hpcp_int_vld,
  rtu_hpcp_retire_inst_vld,
  rtu_hpcp_retire_pc,
  rtu_mmu_bad_vpn,
  rtu_mmu_expt_vld,
  rtu_pad_halted,
  rtu_pad_retire,
  rtu_pad_retire_pc,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  sysio_cp0_apb_base,
  vidu_dtu_debug_info,
  vpu_dtu_dbg_info
);

// &Ports; @26
input   [2  :0]  biu_cp0_coreid;                  
input            biu_cp0_me_int;                  
input            biu_cp0_ms_int;                  
input            biu_cp0_mt_int;                  
input   [39 :0]  biu_cp0_rvba;                    
input            biu_cp0_se_int;                  
input            biu_cp0_ss_int;                  
input            biu_cp0_st_int;                  
input            biu_ifu_arready;                 
input   [127:0]  biu_ifu_rdata;                   
input            biu_ifu_rid;                     
input            biu_ifu_rlast;                   
input   [1  :0]  biu_ifu_rresp;                   
input            biu_ifu_rvalid;                  
input            biu_lsu_arready;                 
input            biu_lsu_no_op;                   
input   [127:0]  biu_lsu_rdata;                   
input   [3  :0]  biu_lsu_rid;                     
input            biu_lsu_rlast;                   
input   [1  :0]  biu_lsu_rresp;                   
input            biu_lsu_rvalid;                  
input            biu_lsu_stb_awready;             
input            biu_lsu_stb_wready;              
input            biu_lsu_vb_awready;              
input            biu_lsu_vb_wready;               
input            cpurst_b;                        
input            dtu_cp0_dcsr_mprven;             
input   [1  :0]  dtu_cp0_dcsr_prv;                
input   [63 :0]  dtu_cp0_rdata;                   
input            dtu_cp0_wake_up;                 
input   [31 :0]  dtu_ifu_debug_inst;              
input            dtu_ifu_debug_inst_vld;          
input   [21 :0]  dtu_ifu_halt_info0;              
input   [21 :0]  dtu_ifu_halt_info1;              
input            dtu_ifu_halt_info_vld;           
input            dtu_ifu_halt_on_reset;           
input            dtu_lsu_addr_trig_en;            
input            dtu_lsu_data_trig_en;            
input   [21 :0]  dtu_lsu_halt_info;               
input            dtu_lsu_halt_info_vld;           
input            dtu_rtu_async_halt_req;          
input   [63 :0]  dtu_rtu_dpc;                     
input            dtu_rtu_ebreak_action;           
input            dtu_rtu_int_mask;                
input   [63 :0]  dtu_rtu_pending_tval;            
input            dtu_rtu_resume_req;              
input            dtu_rtu_step_en;                 
input            dtu_rtu_sync_flush;              
input            dtu_rtu_sync_halt_req;           
input            forever_cpuclk;                  
input   [63 :0]  hpcp_cp0_data;                   
input            hpcp_cp0_int_vld;                
input            hpcp_cp0_sce;                    
input            hpcp_idu_cnt_en;                 
input            hpcp_ifu_cnt_en;                 
input            hpcp_iu_cnt_en;                  
input            hpcp_lsu_cnt_en;                 
input            hpcp_rtu_cnt_en;                 
input            mmu_cp0_cmplt;                   
input   [63 :0]  mmu_cp0_data;                    
input            mmu_cp0_tlb_inv_done;            
input            mmu_ifu_access_fault;            
input   [27 :0]  mmu_ifu_pa;                      
input            mmu_ifu_pa_vld;                  
input   [4  :0]  mmu_ifu_prot;                    
input            mmu_lsu_access_fault;            
input            mmu_lsu_buf;                     
input            mmu_lsu_ca;                      
input            mmu_lsu_data_req;                
input   [39 :0]  mmu_lsu_data_req_addr;           
input            mmu_lsu_data_req_size;           
input   [27 :0]  mmu_lsu_pa;                      
input            mmu_lsu_pa_vld;                  
input            mmu_lsu_page_fault;              
input            mmu_lsu_sec;                     
input            mmu_lsu_sh;                      
input            mmu_lsu_so;                      
input            mmu_xx_mmu_en;                   
input            mmu_yy_xx_no_op;                 
input            pad_yy_icg_scan_en;              
input            pad_yy_scan_mode;                
input   [63 :0]  pmp_cp0_data;                    
input   [39 :0]  sysio_cp0_apb_base;              
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
output           cp0_yy_clk_en;                   
output  [1  :0]  cp0_yy_priv_mode;                
output  [14 :0]  idu_dtu_debug_info;              
output           idu_hpcp_backend_stall;          
output           idu_hpcp_frontend_stall;         
output  [6  :0]  idu_hpcp_inst_type;              
output  [39 :0]  ifu_biu_araddr;                  
output  [1  :0]  ifu_biu_arburst;                 
output  [3  :0]  ifu_biu_arcache;                 
output           ifu_biu_arid;                    
output  [1  :0]  ifu_biu_arlen;                   
output  [2  :0]  ifu_biu_arprot;                  
output  [2  :0]  ifu_biu_arsize;                  
output           ifu_biu_arvalid;                 
output           ifu_dtu_addr_vld0;               
output           ifu_dtu_addr_vld1;               
output           ifu_dtu_data_vld0;               
output           ifu_dtu_data_vld1;               
output  [20 :0]  ifu_dtu_debug_info;              
output  [39 :0]  ifu_dtu_exe_addr0;               
output  [39 :0]  ifu_dtu_exe_addr1;               
output  [31 :0]  ifu_dtu_exe_data0;               
output  [31 :0]  ifu_dtu_exe_data1;               
output           ifu_hpcp_icache_access;          
output           ifu_hpcp_icache_miss;            
output           ifu_mmu_abort;                   
output  [51 :0]  ifu_mmu_va;                      
output           ifu_mmu_va_vld;                  
output  [8  :0]  iu_dtu_debug_info;               
output           iu_hpcp_inst_bht_mispred;        
output           iu_hpcp_inst_condbr;             
output           iu_hpcp_jump_8m;                 
output  [39 :0]  lsu_biu_araddr;                  
output  [1  :0]  lsu_biu_arburst;                 
output  [3  :0]  lsu_biu_arcache;                 
output  [3  :0]  lsu_biu_arid;                    
output  [1  :0]  lsu_biu_arlen;                   
output  [2  :0]  lsu_biu_arprot;                  
output  [2  :0]  lsu_biu_arsize;                  
output           lsu_biu_aruser;                  
output           lsu_biu_arvalid;                 
output  [39 :0]  lsu_biu_stb_awaddr;              
output  [1  :0]  lsu_biu_stb_awburst;             
output  [3  :0]  lsu_biu_stb_awcache;             
output  [1  :0]  lsu_biu_stb_awid;                
output  [1  :0]  lsu_biu_stb_awlen;               
output  [2  :0]  lsu_biu_stb_awprot;              
output  [2  :0]  lsu_biu_stb_awsize;              
output           lsu_biu_stb_awuser;              
output           lsu_biu_stb_awvalid;             
output  [127:0]  lsu_biu_stb_wdata;               
output           lsu_biu_stb_wlast;               
output  [15 :0]  lsu_biu_stb_wstrb;               
output           lsu_biu_stb_wvalid;              
output  [39 :0]  lsu_biu_vb_awaddr;               
output  [1  :0]  lsu_biu_vb_awburst;              
output  [3  :0]  lsu_biu_vb_awcache;              
output  [3  :0]  lsu_biu_vb_awid;                 
output  [1  :0]  lsu_biu_vb_awlen;                
output  [2  :0]  lsu_biu_vb_awprot;               
output  [2  :0]  lsu_biu_vb_awsize;               
output           lsu_biu_vb_awvalid;              
output  [127:0]  lsu_biu_vb_wdata;                
output           lsu_biu_vb_wlast;                
output  [15 :0]  lsu_biu_vb_wstrb;                
output           lsu_biu_vb_wvalid;               
output  [93 :0]  lsu_dtu_debug_info;              
output  [21 :0]  lsu_dtu_halt_info;               
output           lsu_dtu_last_check;              
output  [39 :0]  lsu_dtu_ldst_addr;               
output           lsu_dtu_ldst_addr_vld;           
output  [15 :0]  lsu_dtu_ldst_bytes_vld;          
output  [63 :0]  lsu_dtu_ldst_data;               
output           lsu_dtu_ldst_data_vld;           
output  [1  :0]  lsu_dtu_ldst_type;               
output  [2  :0]  lsu_dtu_mem_access_size;         
output           lsu_hpcp_cache_read_access;      
output           lsu_hpcp_cache_read_miss;        
output           lsu_hpcp_cache_write_access;     
output           lsu_hpcp_cache_write_miss;       
output           lsu_hpcp_inst_store;             
output           lsu_hpcp_unalign_inst;           
output           lsu_mmu_abort;                   
output           lsu_mmu_bus_error;               
output  [63 :0]  lsu_mmu_data;                    
output           lsu_mmu_data_vld;                
output  [1  :0]  lsu_mmu_priv_mode;               
output           lsu_mmu_st_inst;                 
output  [51 :0]  lsu_mmu_va;                      
output           lsu_mmu_va_vld;                  
output           rtu_cpu_no_retire;               
output  [14 :0]  rtu_dtu_debug_info;              
output  [63 :0]  rtu_dtu_dpc;                     
output           rtu_dtu_halt_ack;                
output           rtu_dtu_pending_ack;             
output           rtu_dtu_retire_chgflw;           
output           rtu_dtu_retire_debug_expt_vld;   
output  [21 :0]  rtu_dtu_retire_halt_info;        
output           rtu_dtu_retire_mret;             
output  [39 :0]  rtu_dtu_retire_next_pc;          
output           rtu_dtu_retire_sret;             
output           rtu_dtu_retire_vld;              
output  [63 :0]  rtu_dtu_tval;                    
output           rtu_hpcp_int_vld;                
output           rtu_hpcp_retire_inst_vld;        
output  [39 :0]  rtu_hpcp_retire_pc;              
output  [26 :0]  rtu_mmu_bad_vpn;                 
output           rtu_mmu_expt_vld;                
output           rtu_pad_halted;                  
output           rtu_pad_retire;                  
output  [39 :0]  rtu_pad_retire_pc;               
output           rtu_yy_xx_dbgon;                 
output           rtu_yy_xx_expt_int;              
output  [4  :0]  rtu_yy_xx_expt_vec;              
output           rtu_yy_xx_expt_vld;              
output  [7  :0]  vidu_dtu_debug_info;             
output  [28 :0]  vpu_dtu_dbg_info;                

// &Regs; @27

// &Wires; @28
wire    [2  :0]  biu_cp0_coreid;                  
wire             biu_cp0_me_int;                  
wire             biu_cp0_ms_int;                  
wire             biu_cp0_mt_int;                  
wire    [39 :0]  biu_cp0_rvba;                    
wire             biu_cp0_se_int;                  
wire             biu_cp0_ss_int;                  
wire             biu_cp0_st_int;                  
wire             biu_ifu_arready;                 
wire    [127:0]  biu_ifu_rdata;                   
wire             biu_ifu_rid;                     
wire             biu_ifu_rlast;                   
wire    [1  :0]  biu_ifu_rresp;                   
wire             biu_ifu_rvalid;                  
wire             biu_lsu_arready;                 
wire             biu_lsu_no_op;                   
wire    [127:0]  biu_lsu_rdata;                   
wire    [3  :0]  biu_lsu_rid;                     
wire             biu_lsu_rlast;                   
wire    [1  :0]  biu_lsu_rresp;                   
wire             biu_lsu_rvalid;                  
wire             biu_lsu_stb_awready;             
wire             biu_lsu_stb_wready;              
wire             biu_lsu_vb_awready;              
wire             biu_lsu_vb_wready;               
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
wire    [63 :0]  da_xx_fwd_data;                  
wire    [5  :0]  da_xx_fwd_dst_reg;               
wire             da_xx_fwd_vld;                   
wire             dtu_cp0_dcsr_mprven;             
wire    [1  :0]  dtu_cp0_dcsr_prv;                
wire    [63 :0]  dtu_cp0_rdata;                   
wire             dtu_cp0_wake_up;                 
wire    [31 :0]  dtu_ifu_debug_inst;              
wire             dtu_ifu_debug_inst_vld;          
wire    [21 :0]  dtu_ifu_halt_info0;              
wire    [21 :0]  dtu_ifu_halt_info1;              
wire             dtu_ifu_halt_info_vld;           
wire             dtu_ifu_halt_on_reset;           
wire             dtu_lsu_addr_trig_en;            
wire             dtu_lsu_data_trig_en;            
wire    [21 :0]  dtu_lsu_halt_info;               
wire             dtu_lsu_halt_info_vld;           
wire             dtu_rtu_async_halt_req;          
wire    [63 :0]  dtu_rtu_dpc;                     
wire             dtu_rtu_ebreak_action;           
wire             dtu_rtu_int_mask;                
wire    [63 :0]  dtu_rtu_pending_tval;            
wire             dtu_rtu_resume_req;              
wire             dtu_rtu_step_en;                 
wire             dtu_rtu_sync_flush;              
wire             dtu_rtu_sync_halt_req;           
wire             forever_cpuclk;                  
wire    [63 :0]  hpcp_cp0_data;                   
wire             hpcp_cp0_int_vld;                
wire             hpcp_cp0_sce;                    
wire             hpcp_idu_cnt_en;                 
wire             hpcp_ifu_cnt_en;                 
wire             hpcp_iu_cnt_en;                  
wire             hpcp_lsu_cnt_en;                 
wire             hpcp_rtu_cnt_en;                 
wire             idu_alu_ex1_gateclk_sel;         
wire             idu_bju_ex1_gateclk_sel;         
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
wire             idu_div_ex1_gateclk_sel;         
wire    [14 :0]  idu_dtu_debug_info;              
wire             idu_hpcp_backend_stall;          
wire             idu_hpcp_frontend_stall;         
wire    [6  :0]  idu_hpcp_inst_type;              
wire             idu_ifu_id_stall;                
wire             idu_iu_ex1_alu_dp_sel;           
wire             idu_iu_ex1_alu_sel;              
wire    [1  :0]  idu_iu_ex1_bht_pred;             
wire             idu_iu_ex1_bju_br_sel;           
wire             idu_iu_ex1_bju_dp_sel;           
wire             idu_iu_ex1_bju_sel;              
wire             idu_iu_ex1_div_dp_sel;           
wire             idu_iu_ex1_div_sel;              
wire    [5  :0]  idu_iu_ex1_dst0_reg;             
wire    [19 :0]  idu_iu_ex1_func;                 
wire             idu_iu_ex1_inst_vld;             
wire             idu_iu_ex1_length;               
wire             idu_iu_ex1_mult_dp_sel;          
wire             idu_iu_ex1_mult_sel;             
wire             idu_iu_ex1_pipedown_vld;         
wire             idu_iu_ex1_split;                
wire    [63 :0]  idu_iu_ex1_src0_data;            
wire             idu_iu_ex1_src0_ready;           
wire    [5  :0]  idu_iu_ex1_src0_reg;             
wire    [63 :0]  idu_iu_ex1_src1_data;            
wire             idu_iu_ex1_src1_ready;           
wire    [5  :0]  idu_iu_ex1_src1_reg;             
wire    [63 :0]  idu_iu_ex1_src2_data;            
wire             idu_lsu_ex1_dp_sel;              
wire    [5  :0]  idu_lsu_ex1_dst0_reg;            
wire    [5  :0]  idu_lsu_ex1_dst1_reg;            
wire    [19 :0]  idu_lsu_ex1_func;                
wire             idu_lsu_ex1_gateclk_sel;         
wire    [21 :0]  idu_lsu_ex1_halt_info;           
wire             idu_lsu_ex1_length;              
wire             idu_lsu_ex1_sel;                 
wire             idu_lsu_ex1_split;               
wire    [63 :0]  idu_lsu_ex1_src0_data;           
wire    [63 :0]  idu_lsu_ex1_src1_data;           
wire    [63 :0]  idu_lsu_ex1_src2_data;           
wire             idu_lsu_ex1_src2_ready;          
wire    [5  :0]  idu_lsu_ex1_src2_reg;            
wire    [1  :0]  idu_lsu_ex1_vlmul;               
wire    [1  :0]  idu_lsu_ex1_vsew;                
wire             idu_mult_ex1_gateclk_sel;        
wire             idu_vidu_ex1_fp_dp_sel;          
wire             idu_vidu_ex1_fp_gateclk_sel;     
wire             idu_vidu_ex1_fp_sel;             
wire    [179:0]  idu_vidu_ex1_inst_data;          
wire             idu_vidu_ex1_vec_dp_sel;         
wire             idu_vidu_ex1_vec_gateclk_sel;    
wire             idu_vidu_ex1_vec_sel;            
wire    [39 :0]  ifu_biu_araddr;                  
wire    [1  :0]  ifu_biu_arburst;                 
wire    [3  :0]  ifu_biu_arcache;                 
wire             ifu_biu_arid;                    
wire    [1  :0]  ifu_biu_arlen;                   
wire    [2  :0]  ifu_biu_arprot;                  
wire    [2  :0]  ifu_biu_arsize;                  
wire             ifu_biu_arvalid;                 
wire             ifu_cp0_bht_inv_done;            
wire             ifu_cp0_icache_inv_done;         
wire    [127:0]  ifu_cp0_icache_read_data;        
wire             ifu_cp0_icache_read_data_vld;    
wire             ifu_cp0_rst_inv_req;             
wire             ifu_cp0_warm_up;                 
wire             ifu_dtu_addr_vld0;               
wire             ifu_dtu_addr_vld1;               
wire             ifu_dtu_data_vld0;               
wire             ifu_dtu_data_vld1;               
wire    [20 :0]  ifu_dtu_debug_info;              
wire    [39 :0]  ifu_dtu_exe_addr0;               
wire    [39 :0]  ifu_dtu_exe_addr1;               
wire    [31 :0]  ifu_dtu_exe_data0;               
wire    [31 :0]  ifu_dtu_exe_data1;               
wire             ifu_hpcp_icache_access;          
wire             ifu_hpcp_icache_miss;            
wire    [1  :0]  ifu_idu_id_bht_pred;             
wire             ifu_idu_id_expt_acc_error;       
wire             ifu_idu_id_expt_high;            
wire             ifu_idu_id_expt_page_fault;      
wire    [21 :0]  ifu_idu_id_halt_info;            
wire    [31 :0]  ifu_idu_id_inst;                 
wire             ifu_idu_id_inst_vld;             
wire             ifu_idu_warm_up;                 
wire    [39 :0]  ifu_iu_chgflw_pc;                
wire             ifu_iu_chgflw_vld;               
wire    [39 :0]  ifu_iu_ex1_pc_pred;              
wire             ifu_iu_reset_vld;                
wire             ifu_iu_warm_up;                  
wire             ifu_lsu_warm_up;                 
wire             ifu_mmu_abort;                   
wire    [51 :0]  ifu_mmu_va;                      
wire             ifu_mmu_va_vld;                  
wire             ifu_rtu_reset_halt_req;          
wire             ifu_rtu_warm_up;                 
wire             ifu_vidu_warm_up;                
wire             ifu_vpu_warm_up;                 
wire             ifu_yy_xx_no_op;                 
wire    [39 :0]  iu_cp0_ex1_cur_pc;               
wire    [8  :0]  iu_dtu_debug_info;               
wire             iu_hpcp_inst_bht_mispred;        
wire             iu_hpcp_inst_condbr;             
wire             iu_hpcp_jump_8m;                 
wire             iu_idu_bju_full;                 
wire             iu_idu_bju_global_full;          
wire             iu_idu_div_full;                 
wire             iu_idu_mult_full;                
wire             iu_idu_mult_issue_stall;         
wire    [39 :0]  iu_ifu_bht_cur_pc;               
wire             iu_ifu_bht_mispred;              
wire             iu_ifu_bht_mispred_gate;         
wire    [1  :0]  iu_ifu_bht_pred;                 
wire             iu_ifu_bht_taken;                
wire             iu_ifu_br_vld;                   
wire             iu_ifu_br_vld_gate;              
wire             iu_ifu_link_vld;                 
wire             iu_ifu_link_vld_gate;            
wire             iu_ifu_pc_mispred;               
wire             iu_ifu_pc_mispred_gate;          
wire             iu_ifu_ret_vld;                  
wire             iu_ifu_ret_vld_gate;             
wire    [63 :0]  iu_ifu_tar_pc;                   
wire             iu_ifu_tar_pc_vld;               
wire             iu_ifu_tar_pc_vld_gate;          
wire    [15 :0]  iu_lsu_ex1_cur_pc;               
wire             iu_rtu_depd_lsu_chgflow_vld;     
wire    [39 :0]  iu_rtu_depd_lsu_next_pc;         
wire    [63 :0]  iu_rtu_div_data;                 
wire    [5  :0]  iu_rtu_div_preg;                 
wire             iu_rtu_div_wb_dp;                
wire             iu_rtu_div_wb_vld;               
wire             iu_rtu_ex1_alu_cmplt;            
wire             iu_rtu_ex1_alu_cmplt_dp;         
wire    [63 :0]  iu_rtu_ex1_alu_data;             
wire             iu_rtu_ex1_alu_inst_len;         
wire             iu_rtu_ex1_alu_inst_split;       
wire    [5  :0]  iu_rtu_ex1_alu_preg;             
wire             iu_rtu_ex1_alu_wb_dp;            
wire             iu_rtu_ex1_alu_wb_vld;           
wire             iu_rtu_ex1_bju_cmplt;            
wire             iu_rtu_ex1_bju_cmplt_dp;         
wire    [63 :0]  iu_rtu_ex1_bju_data;             
wire             iu_rtu_ex1_bju_inst_len;         
wire    [5  :0]  iu_rtu_ex1_bju_preg;             
wire             iu_rtu_ex1_bju_wb_dp;            
wire             iu_rtu_ex1_bju_wb_vld;           
wire             iu_rtu_ex1_branch_inst;          
wire    [39 :0]  iu_rtu_ex1_cur_pc;               
wire             iu_rtu_ex1_div_cmplt;            
wire             iu_rtu_ex1_div_cmplt_dp;         
wire             iu_rtu_ex1_mul_cmplt;            
wire             iu_rtu_ex1_mul_cmplt_dp;         
wire    [39 :0]  iu_rtu_ex1_next_pc;              
wire             iu_rtu_ex2_bju_ras_mispred;      
wire    [63 :0]  iu_rtu_ex3_mul_data;             
wire    [5  :0]  iu_rtu_ex3_mul_preg;             
wire             iu_rtu_ex3_mul_wb_vld;           
wire             iu_xx_no_op;                     
wire             iu_yy_xx_cancel;                 
wire    [39 :0]  lsu_biu_araddr;                  
wire    [1  :0]  lsu_biu_arburst;                 
wire    [3  :0]  lsu_biu_arcache;                 
wire    [3  :0]  lsu_biu_arid;                    
wire    [1  :0]  lsu_biu_arlen;                   
wire    [2  :0]  lsu_biu_arprot;                  
wire    [2  :0]  lsu_biu_arsize;                  
wire             lsu_biu_aruser;                  
wire             lsu_biu_arvalid;                 
wire    [39 :0]  lsu_biu_stb_awaddr;              
wire    [1  :0]  lsu_biu_stb_awburst;             
wire    [3  :0]  lsu_biu_stb_awcache;             
wire    [1  :0]  lsu_biu_stb_awid;                
wire    [1  :0]  lsu_biu_stb_awlen;               
wire    [2  :0]  lsu_biu_stb_awprot;              
wire    [2  :0]  lsu_biu_stb_awsize;              
wire             lsu_biu_stb_awuser;              
wire             lsu_biu_stb_awvalid;             
wire    [127:0]  lsu_biu_stb_wdata;               
wire             lsu_biu_stb_wlast;               
wire    [15 :0]  lsu_biu_stb_wstrb;               
wire             lsu_biu_stb_wvalid;              
wire    [39 :0]  lsu_biu_vb_awaddr;               
wire    [1  :0]  lsu_biu_vb_awburst;              
wire    [3  :0]  lsu_biu_vb_awcache;              
wire    [3  :0]  lsu_biu_vb_awid;                 
wire    [1  :0]  lsu_biu_vb_awlen;                
wire    [2  :0]  lsu_biu_vb_awprot;               
wire    [2  :0]  lsu_biu_vb_awsize;               
wire             lsu_biu_vb_awvalid;              
wire    [127:0]  lsu_biu_vb_wdata;                
wire             lsu_biu_vb_wlast;                
wire    [15 :0]  lsu_biu_vb_wstrb;                
wire             lsu_biu_vb_wvalid;               
wire    [127:0]  lsu_cp0_dcache_read_data;        
wire             lsu_cp0_dcache_read_data_vld;    
wire             lsu_cp0_fence_ack;               
wire             lsu_cp0_icc_done;                
wire             lsu_cp0_sync_ack;                
wire    [93 :0]  lsu_dtu_debug_info;              
wire    [21 :0]  lsu_dtu_halt_info;               
wire             lsu_dtu_last_check;              
wire    [39 :0]  lsu_dtu_ldst_addr;               
wire             lsu_dtu_ldst_addr_vld;           
wire    [15 :0]  lsu_dtu_ldst_bytes_vld;          
wire    [63 :0]  lsu_dtu_ldst_data;               
wire             lsu_dtu_ldst_data_vld;           
wire    [1  :0]  lsu_dtu_ldst_type;               
wire    [2  :0]  lsu_dtu_mem_access_size;         
wire             lsu_hpcp_cache_read_access;      
wire             lsu_hpcp_cache_read_miss;        
wire             lsu_hpcp_cache_write_access;     
wire             lsu_hpcp_cache_write_miss;       
wire             lsu_hpcp_inst_store;             
wire             lsu_hpcp_unalign_inst;           
wire             lsu_idu_full;                    
wire             lsu_idu_global_full;             
wire    [63 :0]  lsu_iu_ex2_data;                 
wire             lsu_iu_ex2_data_vld;             
wire    [4  :0]  lsu_iu_ex2_dest_reg;             
wire             lsu_mmu_abort;                   
wire             lsu_mmu_bus_error;               
wire    [63 :0]  lsu_mmu_data;                    
wire             lsu_mmu_data_vld;                
wire    [1  :0]  lsu_mmu_priv_mode;               
wire             lsu_mmu_st_inst;                 
wire    [51 :0]  lsu_mmu_va;                      
wire             lsu_mmu_va_vld;                  
wire             lsu_rtu_async_expt_vld;          
wire             lsu_rtu_async_ld_inst;           
wire    [39 :0]  lsu_rtu_async_tval;              
wire             lsu_rtu_ex1_buffer_vld;          
wire             lsu_rtu_ex1_cmplt;               
wire             lsu_rtu_ex1_cmplt_dp;            
wire             lsu_rtu_ex1_cmplt_for_pcgen;     
wire    [63 :0]  lsu_rtu_ex1_data;                
wire    [5  :0]  lsu_rtu_ex1_dest_reg;            
wire    [39 :0]  lsu_rtu_ex1_expt_tval;           
wire    [4  :0]  lsu_rtu_ex1_expt_vec;            
wire             lsu_rtu_ex1_expt_vld;            
wire             lsu_rtu_ex1_fs_dirty;            
wire    [21 :0]  lsu_rtu_ex1_halt_info;           
wire             lsu_rtu_ex1_inst_len;            
wire             lsu_rtu_ex1_inst_split;          
wire             lsu_rtu_ex1_tval2_vld;           
wire             lsu_rtu_ex1_vs_dirty;            
wire    [6  :0]  lsu_rtu_ex1_vstart;              
wire             lsu_rtu_ex1_vstart_vld;          
wire             lsu_rtu_ex1_wb_dp;               
wire             lsu_rtu_ex1_wb_vld;              
wire    [63 :0]  lsu_rtu_ex2_data;                
wire             lsu_rtu_ex2_data_vld;            
wire    [5  :0]  lsu_rtu_ex2_dest_reg;            
wire    [39 :0]  lsu_rtu_ex2_tval2;               
wire             lsu_rtu_no_op;                   
wire    [63 :0]  lsu_rtu_wb_data;                 
wire    [5  :0]  lsu_rtu_wb_dest_reg;             
wire             lsu_rtu_wb_vld;                  
wire    [7  :0]  lsu_vlsu_bytes_vld;              
wire    [63 :0]  lsu_vlsu_data;                   
wire             lsu_vlsu_data_grant;             
wire             lsu_vlsu_data_vld;               
wire             lsu_vlsu_dc_create_vld;          
wire             lsu_vlsu_dc_fld_req;             
wire             lsu_vlsu_dc_fof;                 
wire    [2  :0]  lsu_vlsu_dc_nf;                  
wire    [1  :0]  lsu_vlsu_dc_sew;                 
wire    [9  :0]  lsu_vlsu_dc_split_cnt;           
wire             lsu_vlsu_dc_sseg_first;          
wire             lsu_vlsu_dc_stall;               
wire    [4  :0]  lsu_vlsu_dest_reg;               
wire             lsu_vlsu_expt_vld;               
wire    [19 :0]  lsu_vlsu_func;                   
wire    [1  :0]  lsu_vlsu_sew;                    
wire             lsu_vlsu_split_last;             
wire             lsu_vlsu_st_expt;                
wire    [3  :0]  lsu_vlsu_st_offset;              
wire    [1  :0]  lsu_vlsu_st_sew;                 
wire    [1  :0]  lsu_vlsu_st_size;                
wire             lsu_vlsu_vl_update;              
wire    [6  :0]  lsu_vlsu_vl_upval;               
wire             mmu_cp0_cmplt;                   
wire    [63 :0]  mmu_cp0_data;                    
wire             mmu_cp0_tlb_inv_done;            
wire             mmu_ifu_access_fault;            
wire    [27 :0]  mmu_ifu_pa;                      
wire             mmu_ifu_pa_vld;                  
wire    [4  :0]  mmu_ifu_prot;                    
wire             mmu_lsu_access_fault;            
wire             mmu_lsu_buf;                     
wire             mmu_lsu_ca;                      
wire             mmu_lsu_data_req;                
wire    [39 :0]  mmu_lsu_data_req_addr;           
wire             mmu_lsu_data_req_size;           
wire    [27 :0]  mmu_lsu_pa;                      
wire             mmu_lsu_pa_vld;                  
wire             mmu_lsu_page_fault;              
wire             mmu_lsu_sec;                     
wire             mmu_lsu_sh;                      
wire             mmu_lsu_so;                      
wire             mmu_xx_mmu_en;                   
wire             mmu_yy_xx_no_op;                 
wire             pad_yy_icg_scan_en;              
wire    [63 :0]  pmp_cp0_data;                    
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
wire             rtu_cpu_no_retire;               
wire    [14 :0]  rtu_dtu_debug_info;              
wire    [63 :0]  rtu_dtu_dpc;                     
wire             rtu_dtu_halt_ack;                
wire             rtu_dtu_pending_ack;             
wire             rtu_dtu_retire_chgflw;           
wire             rtu_dtu_retire_debug_expt_vld;   
wire    [21 :0]  rtu_dtu_retire_halt_info;        
wire             rtu_dtu_retire_mret;             
wire    [39 :0]  rtu_dtu_retire_next_pc;          
wire             rtu_dtu_retire_sret;             
wire             rtu_dtu_retire_vld;              
wire    [63 :0]  rtu_dtu_tval;                    
wire             rtu_hpcp_int_vld;                
wire             rtu_hpcp_retire_inst_vld;        
wire    [39 :0]  rtu_hpcp_retire_pc;              
wire             rtu_idu_commit;                  
wire             rtu_idu_commit_for_bju;          
wire             rtu_idu_flush_fe;                
wire             rtu_idu_flush_stall;             
wire             rtu_idu_flush_wbt;               
wire    [63 :0]  rtu_idu_fwd0_data;               
wire    [5  :0]  rtu_idu_fwd0_reg;                
wire             rtu_idu_fwd0_vld;                
wire    [63 :0]  rtu_idu_fwd1_data;               
wire    [5  :0]  rtu_idu_fwd1_reg;                
wire             rtu_idu_fwd1_vld;                
wire    [63 :0]  rtu_idu_fwd2_data;               
wire    [5  :0]  rtu_idu_fwd2_reg;                
wire             rtu_idu_fwd2_vld;                
wire             rtu_idu_pipeline_empty;          
wire    [63 :0]  rtu_idu_wb0_data;                
wire    [5  :0]  rtu_idu_wb0_reg;                 
wire             rtu_idu_wb0_vld;                 
wire    [63 :0]  rtu_idu_wb1_data;                
wire    [5  :0]  rtu_idu_wb1_reg;                 
wire             rtu_idu_wb1_vld;                 
wire    [39 :0]  rtu_ifu_chgflw_pc;               
wire             rtu_ifu_chgflw_vld;              
wire             rtu_ifu_dbg_mask;                
wire             rtu_ifu_flush_fe;                
wire             rtu_iu_div_wb_grant;             
wire             rtu_iu_div_wb_grant_for_full;    
wire             rtu_iu_ex1_cmplt;                
wire             rtu_iu_ex1_cmplt_dp;             
wire             rtu_iu_ex1_inst_len;             
wire             rtu_iu_ex1_inst_split;           
wire    [39 :0]  rtu_iu_ex2_cur_pc;               
wire    [39 :0]  rtu_iu_ex2_next_pc;              
wire             rtu_iu_mul_wb_grant;             
wire             rtu_iu_mul_wb_grant_for_full;    
wire             rtu_lsu_async_expt_ack;          
wire             rtu_lsu_expt_ack;                
wire             rtu_lsu_expt_exit;               
wire    [26 :0]  rtu_mmu_bad_vpn;                 
wire             rtu_mmu_expt_vld;                
wire             rtu_pad_halted;                  
wire             rtu_pad_retire;                  
wire    [39 :0]  rtu_pad_retire_pc;               
wire             rtu_vidu_flush_wbt;              
wire             rtu_vpu_gpr_wb_grnt;             
wire             rtu_yy_xx_async_flush;           
wire             rtu_yy_xx_dbgon;                 
wire             rtu_yy_xx_expt_int;              
wire    [4  :0]  rtu_yy_xx_expt_vec;              
wire             rtu_yy_xx_expt_vld;              
wire             rtu_yy_xx_flush;                 
wire             rtu_yy_xx_flush_fe;              
wire    [39 :0]  sysio_cp0_apb_base;              
wire             vidu_cp0_vid_fof_vld;            
wire    [7  :0]  vidu_dtu_debug_info;             
wire             vidu_idu_fp_full;                
wire             vidu_idu_vec_full;               
wire             vidu_rtu_no_op;                  
wire             vidu_vpu_vid_fp_inst_dp_vld;     
wire    [5  :0]  vidu_vpu_vid_fp_inst_dst_reg;    
wire             vidu_vpu_vid_fp_inst_dst_vld;    
wire             vidu_vpu_vid_fp_inst_dste_vld;   
wire    [4  :0]  vidu_vpu_vid_fp_inst_dstf_reg;   
wire             vidu_vpu_vid_fp_inst_dstf_vld;   
wire    [9  :0]  vidu_vpu_vid_fp_inst_eu;         
wire    [19 :0]  vidu_vpu_vid_fp_inst_func;       
wire             vidu_vpu_vid_fp_inst_gateclk_vld; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_src1_data;  
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf0_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf1_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf2_data; 
wire             vidu_vpu_vid_fp_inst_srcf2_rdy;  
wire             vidu_vpu_vid_fp_inst_srcf2_vld;  
wire             vidu_vpu_vid_fp_inst_vld;        
wire             vlsu_buf_stall;                  
wire    [63 :0]  vlsu_dtu_data;                   
wire             vlsu_dtu_data_vld;               
wire             vlsu_dtu_data_vld_gate;          
wire    [3  :0]  vlsu_lsu_data_shift;             
wire             vlsu_lsu_data_vld;               
wire    [63 :0]  vlsu_lsu_fwd_data;               
wire    [4  :0]  vlsu_lsu_fwd_dest_reg;           
wire             vlsu_lsu_fwd_vld;                
wire             vlsu_lsu_src2_depd;              
wire    [4  :0]  vlsu_lsu_src2_reg;               
wire    [63 :0]  vlsu_lsu_wdata;                  
wire    [7  :0]  vlsu_rtu_vl_updt_data;           
wire             vlsu_rtu_vl_updt_vld;            
wire             vlsu_xx_no_op;                   
wire    [28 :0]  vpu_dtu_dbg_info;                
wire             vpu_rtu_ex1_cmplt;               
wire             vpu_rtu_ex1_cmplt_dp;            
wire             vpu_rtu_ex1_fp_dirty;            
wire             vpu_rtu_ex1_vec_dirty;           
wire    [5  :0]  vpu_rtu_fflag;                   
wire             vpu_rtu_fflag_vld;               
wire    [63 :0]  vpu_rtu_gpr_wb_data;             
wire    [5  :0]  vpu_rtu_gpr_wb_index;            
wire             vpu_rtu_gpr_wb_req;              
wire             vpu_rtu_no_op;                   
wire    [63 :0]  vpu_vidu_fp_fwd_data;            
wire    [4  :0]  vpu_vidu_fp_fwd_reg;             
wire             vpu_vidu_fp_fwd_vld;             
wire    [63 :0]  vpu_vidu_fp_wb_data;             
wire    [4  :0]  vpu_vidu_fp_wb_reg;              
wire             vpu_vidu_fp_wb_vld;              
wire             vpu_vidu_vex1_fp_stall;          
wire    [4  :0]  vpu_vidu_wbt_fp_wb0_reg;         
wire             vpu_vidu_wbt_fp_wb0_vld;         
wire    [4  :0]  vpu_vidu_wbt_fp_wb1_reg;         
wire             vpu_vidu_wbt_fp_wb1_vld;         


// &Force("input", "pad_yy_scan_mode"); @30
// &Force("output","cp0_yy_priv_mode"); @31
// &Force("output","cp0_yy_clk_en"); @32
// &Force("output","rtu_yy_xx_dbgon"); @33
// &Force("output","rtu_yy_xx_expt_vld"); @34
// &Force("output","rtu_yy_xx_expt_int"); @35
// &Force("output","rtu_yy_xx_expt_vec"); @36

//==========================================================
//  Instance aq_ifu_top sub module 
//==========================================================
// &Instance("aq_ifu_top"); @41
aq_ifu_top  x_aq_ifu_top (
  .biu_ifu_arready              (biu_ifu_arready             ),
  .biu_ifu_rdata                (biu_ifu_rdata               ),
  .biu_ifu_rid                  (biu_ifu_rid                 ),
  .biu_ifu_rlast                (biu_ifu_rlast               ),
  .biu_ifu_rresp                (biu_ifu_rresp               ),
  .biu_ifu_rvalid               (biu_ifu_rvalid              ),
  .cp0_ifu_bht_en               (cp0_ifu_bht_en              ),
  .cp0_ifu_bht_inv              (cp0_ifu_bht_inv             ),
  .cp0_ifu_btb_clr              (cp0_ifu_btb_clr             ),
  .cp0_ifu_btb_en               (cp0_ifu_btb_en              ),
  .cp0_ifu_icache_en            (cp0_ifu_icache_en           ),
  .cp0_ifu_icache_inv_addr      (cp0_ifu_icache_inv_addr     ),
  .cp0_ifu_icache_inv_req       (cp0_ifu_icache_inv_req      ),
  .cp0_ifu_icache_inv_type      (cp0_ifu_icache_inv_type     ),
  .cp0_ifu_icache_pref_en       (cp0_ifu_icache_pref_en      ),
  .cp0_ifu_icache_read_index    (cp0_ifu_icache_read_index   ),
  .cp0_ifu_icache_read_req      (cp0_ifu_icache_read_req     ),
  .cp0_ifu_icache_read_tag      (cp0_ifu_icache_read_tag     ),
  .cp0_ifu_icache_read_way      (cp0_ifu_icache_read_way     ),
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_ifu_in_lpmd              (cp0_ifu_in_lpmd             ),
  .cp0_ifu_iwpe                 (cp0_ifu_iwpe                ),
  .cp0_ifu_lpmd_req             (cp0_ifu_lpmd_req            ),
  .cp0_ifu_ras_en               (cp0_ifu_ras_en              ),
  .cp0_ifu_rst_inv_done         (cp0_ifu_rst_inv_done        ),
  .cp0_xx_mrvbr                 (cp0_xx_mrvbr                ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .dtu_ifu_debug_inst           (dtu_ifu_debug_inst          ),
  .dtu_ifu_debug_inst_vld       (dtu_ifu_debug_inst_vld      ),
  .dtu_ifu_halt_info0           (dtu_ifu_halt_info0          ),
  .dtu_ifu_halt_info1           (dtu_ifu_halt_info1          ),
  .dtu_ifu_halt_info_vld        (dtu_ifu_halt_info_vld       ),
  .dtu_ifu_halt_on_reset        (dtu_ifu_halt_on_reset       ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_ifu_cnt_en              (hpcp_ifu_cnt_en             ),
  .idu_ifu_id_stall             (idu_ifu_id_stall            ),
  .ifu_biu_araddr               (ifu_biu_araddr              ),
  .ifu_biu_arburst              (ifu_biu_arburst             ),
  .ifu_biu_arcache              (ifu_biu_arcache             ),
  .ifu_biu_arid                 (ifu_biu_arid                ),
  .ifu_biu_arlen                (ifu_biu_arlen               ),
  .ifu_biu_arprot               (ifu_biu_arprot              ),
  .ifu_biu_arsize               (ifu_biu_arsize              ),
  .ifu_biu_arvalid              (ifu_biu_arvalid             ),
  .ifu_cp0_bht_inv_done         (ifu_cp0_bht_inv_done        ),
  .ifu_cp0_icache_inv_done      (ifu_cp0_icache_inv_done     ),
  .ifu_cp0_icache_read_data     (ifu_cp0_icache_read_data    ),
  .ifu_cp0_icache_read_data_vld (ifu_cp0_icache_read_data_vld),
  .ifu_cp0_rst_inv_req          (ifu_cp0_rst_inv_req         ),
  .ifu_cp0_warm_up              (ifu_cp0_warm_up             ),
  .ifu_dtu_addr_vld0            (ifu_dtu_addr_vld0           ),
  .ifu_dtu_addr_vld1            (ifu_dtu_addr_vld1           ),
  .ifu_dtu_data_vld0            (ifu_dtu_data_vld0           ),
  .ifu_dtu_data_vld1            (ifu_dtu_data_vld1           ),
  .ifu_dtu_debug_info           (ifu_dtu_debug_info          ),
  .ifu_dtu_exe_addr0            (ifu_dtu_exe_addr0           ),
  .ifu_dtu_exe_addr1            (ifu_dtu_exe_addr1           ),
  .ifu_dtu_exe_data0            (ifu_dtu_exe_data0           ),
  .ifu_dtu_exe_data1            (ifu_dtu_exe_data1           ),
  .ifu_hpcp_icache_access       (ifu_hpcp_icache_access      ),
  .ifu_hpcp_icache_miss         (ifu_hpcp_icache_miss        ),
  .ifu_idu_id_bht_pred          (ifu_idu_id_bht_pred         ),
  .ifu_idu_id_expt_acc_error    (ifu_idu_id_expt_acc_error   ),
  .ifu_idu_id_expt_high         (ifu_idu_id_expt_high        ),
  .ifu_idu_id_expt_page_fault   (ifu_idu_id_expt_page_fault  ),
  .ifu_idu_id_halt_info         (ifu_idu_id_halt_info        ),
  .ifu_idu_id_inst              (ifu_idu_id_inst             ),
  .ifu_idu_id_inst_vld          (ifu_idu_id_inst_vld         ),
  .ifu_idu_warm_up              (ifu_idu_warm_up             ),
  .ifu_iu_chgflw_pc             (ifu_iu_chgflw_pc            ),
  .ifu_iu_chgflw_vld            (ifu_iu_chgflw_vld           ),
  .ifu_iu_ex1_pc_pred           (ifu_iu_ex1_pc_pred          ),
  .ifu_iu_reset_vld             (ifu_iu_reset_vld            ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .ifu_lsu_warm_up              (ifu_lsu_warm_up             ),
  .ifu_mmu_abort                (ifu_mmu_abort               ),
  .ifu_mmu_va                   (ifu_mmu_va                  ),
  .ifu_mmu_va_vld               (ifu_mmu_va_vld              ),
  .ifu_rtu_reset_halt_req       (ifu_rtu_reset_halt_req      ),
  .ifu_rtu_warm_up              (ifu_rtu_warm_up             ),
  .ifu_vidu_warm_up             (ifu_vidu_warm_up            ),
  .ifu_vpu_warm_up              (ifu_vpu_warm_up             ),
  .ifu_yy_xx_no_op              (ifu_yy_xx_no_op             ),
  .iu_ifu_bht_cur_pc            (iu_ifu_bht_cur_pc           ),
  .iu_ifu_bht_mispred           (iu_ifu_bht_mispred          ),
  .iu_ifu_bht_mispred_gate      (iu_ifu_bht_mispred_gate     ),
  .iu_ifu_bht_pred              (iu_ifu_bht_pred             ),
  .iu_ifu_bht_taken             (iu_ifu_bht_taken            ),
  .iu_ifu_br_vld                (iu_ifu_br_vld               ),
  .iu_ifu_br_vld_gate           (iu_ifu_br_vld_gate          ),
  .iu_ifu_link_vld              (iu_ifu_link_vld             ),
  .iu_ifu_link_vld_gate         (iu_ifu_link_vld_gate        ),
  .iu_ifu_pc_mispred            (iu_ifu_pc_mispred           ),
  .iu_ifu_pc_mispred_gate       (iu_ifu_pc_mispred_gate      ),
  .iu_ifu_ret_vld               (iu_ifu_ret_vld              ),
  .iu_ifu_ret_vld_gate          (iu_ifu_ret_vld_gate         ),
  .iu_ifu_tar_pc                (iu_ifu_tar_pc               ),
  .iu_ifu_tar_pc_vld            (iu_ifu_tar_pc_vld           ),
  .iu_ifu_tar_pc_vld_gate       (iu_ifu_tar_pc_vld_gate      ),
  .mmu_ifu_access_fault         (mmu_ifu_access_fault        ),
  .mmu_ifu_pa                   (mmu_ifu_pa                  ),
  .mmu_ifu_pa_vld               (mmu_ifu_pa_vld              ),
  .mmu_ifu_prot                 (mmu_ifu_prot                ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_ifu_chgflw_pc            (rtu_ifu_chgflw_pc           ),
  .rtu_ifu_chgflw_vld           (rtu_ifu_chgflw_vld          ),
  .rtu_ifu_dbg_mask             (rtu_ifu_dbg_mask            ),
  .rtu_ifu_flush_fe             (rtu_ifu_flush_fe            ),
  .rtu_yy_xx_dbgon              (rtu_yy_xx_dbgon             )
);


//==========================================================
//  Instance aq_idu_top sub module 
//==========================================================
// &Instance("aq_idu_top"); @46
aq_idu_top  x_aq_idu_top (
  .cp0_idu_cskyee               (cp0_idu_cskyee              ),
  .cp0_idu_dis_fence_in_dbg     (cp0_idu_dis_fence_in_dbg    ),
  .cp0_idu_frm                  (cp0_idu_frm                 ),
  .cp0_idu_fs                   (cp0_idu_fs                  ),
  .cp0_idu_icg_en               (cp0_idu_icg_en              ),
  .cp0_idu_issue_stall          (cp0_idu_issue_stall         ),
  .cp0_idu_ucme                 (cp0_idu_ucme                ),
  .cp0_idu_vill                 (cp0_idu_vill                ),
  .cp0_idu_vl_zero              (cp0_idu_vl_zero             ),
  .cp0_idu_vlmul                (cp0_idu_vlmul               ),
  .cp0_idu_vs                   (cp0_idu_vs                  ),
  .cp0_idu_vsetvl_dis_stall     (cp0_idu_vsetvl_dis_stall    ),
  .cp0_idu_vsew                 (cp0_idu_vsew                ),
  .cp0_idu_vstart               (cp0_idu_vstart              ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cp0_yy_priv_mode             (cp0_yy_priv_mode            ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_idu_cnt_en              (hpcp_idu_cnt_en             ),
  .idu_alu_ex1_gateclk_sel      (idu_alu_ex1_gateclk_sel     ),
  .idu_bju_ex1_gateclk_sel      (idu_bju_ex1_gateclk_sel     ),
  .idu_cp0_ex1_dp_sel           (idu_cp0_ex1_dp_sel          ),
  .idu_cp0_ex1_dst0_reg         (idu_cp0_ex1_dst0_reg        ),
  .idu_cp0_ex1_expt_acc_error   (idu_cp0_ex1_expt_acc_error  ),
  .idu_cp0_ex1_expt_high        (idu_cp0_ex1_expt_high       ),
  .idu_cp0_ex1_expt_illegal     (idu_cp0_ex1_expt_illegal    ),
  .idu_cp0_ex1_expt_page_fault  (idu_cp0_ex1_expt_page_fault ),
  .idu_cp0_ex1_func             (idu_cp0_ex1_func            ),
  .idu_cp0_ex1_gateclk_sel      (idu_cp0_ex1_gateclk_sel     ),
  .idu_cp0_ex1_halt_info        (idu_cp0_ex1_halt_info       ),
  .idu_cp0_ex1_length           (idu_cp0_ex1_length          ),
  .idu_cp0_ex1_opcode           (idu_cp0_ex1_opcode          ),
  .idu_cp0_ex1_sel              (idu_cp0_ex1_sel             ),
  .idu_cp0_ex1_split            (idu_cp0_ex1_split           ),
  .idu_cp0_ex1_src0_data        (idu_cp0_ex1_src0_data       ),
  .idu_cp0_ex1_src1_data        (idu_cp0_ex1_src1_data       ),
  .idu_div_ex1_gateclk_sel      (idu_div_ex1_gateclk_sel     ),
  .idu_dtu_debug_info           (idu_dtu_debug_info          ),
  .idu_hpcp_backend_stall       (idu_hpcp_backend_stall      ),
  .idu_hpcp_frontend_stall      (idu_hpcp_frontend_stall     ),
  .idu_hpcp_inst_type           (idu_hpcp_inst_type          ),
  .idu_ifu_id_stall             (idu_ifu_id_stall            ),
  .idu_iu_ex1_alu_dp_sel        (idu_iu_ex1_alu_dp_sel       ),
  .idu_iu_ex1_alu_sel           (idu_iu_ex1_alu_sel          ),
  .idu_iu_ex1_bht_pred          (idu_iu_ex1_bht_pred         ),
  .idu_iu_ex1_bju_br_sel        (idu_iu_ex1_bju_br_sel       ),
  .idu_iu_ex1_bju_dp_sel        (idu_iu_ex1_bju_dp_sel       ),
  .idu_iu_ex1_bju_sel           (idu_iu_ex1_bju_sel          ),
  .idu_iu_ex1_div_dp_sel        (idu_iu_ex1_div_dp_sel       ),
  .idu_iu_ex1_div_sel           (idu_iu_ex1_div_sel          ),
  .idu_iu_ex1_dst0_reg          (idu_iu_ex1_dst0_reg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_inst_vld          (idu_iu_ex1_inst_vld         ),
  .idu_iu_ex1_length            (idu_iu_ex1_length           ),
  .idu_iu_ex1_mult_dp_sel       (idu_iu_ex1_mult_dp_sel      ),
  .idu_iu_ex1_mult_sel          (idu_iu_ex1_mult_sel         ),
  .idu_iu_ex1_pipedown_vld      (idu_iu_ex1_pipedown_vld     ),
  .idu_iu_ex1_split             (idu_iu_ex1_split            ),
  .idu_iu_ex1_src0_data         (idu_iu_ex1_src0_data        ),
  .idu_iu_ex1_src0_ready        (idu_iu_ex1_src0_ready       ),
  .idu_iu_ex1_src0_reg          (idu_iu_ex1_src0_reg         ),
  .idu_iu_ex1_src1_data         (idu_iu_ex1_src1_data        ),
  .idu_iu_ex1_src1_ready        (idu_iu_ex1_src1_ready       ),
  .idu_iu_ex1_src1_reg          (idu_iu_ex1_src1_reg         ),
  .idu_iu_ex1_src2_data         (idu_iu_ex1_src2_data        ),
  .idu_lsu_ex1_dp_sel           (idu_lsu_ex1_dp_sel          ),
  .idu_lsu_ex1_dst0_reg         (idu_lsu_ex1_dst0_reg        ),
  .idu_lsu_ex1_dst1_reg         (idu_lsu_ex1_dst1_reg        ),
  .idu_lsu_ex1_func             (idu_lsu_ex1_func            ),
  .idu_lsu_ex1_gateclk_sel      (idu_lsu_ex1_gateclk_sel     ),
  .idu_lsu_ex1_halt_info        (idu_lsu_ex1_halt_info       ),
  .idu_lsu_ex1_length           (idu_lsu_ex1_length          ),
  .idu_lsu_ex1_sel              (idu_lsu_ex1_sel             ),
  .idu_lsu_ex1_split            (idu_lsu_ex1_split           ),
  .idu_lsu_ex1_src0_data        (idu_lsu_ex1_src0_data       ),
  .idu_lsu_ex1_src1_data        (idu_lsu_ex1_src1_data       ),
  .idu_lsu_ex1_src2_data        (idu_lsu_ex1_src2_data       ),
  .idu_lsu_ex1_src2_ready       (idu_lsu_ex1_src2_ready      ),
  .idu_lsu_ex1_src2_reg         (idu_lsu_ex1_src2_reg        ),
  .idu_lsu_ex1_vlmul            (idu_lsu_ex1_vlmul           ),
  .idu_lsu_ex1_vsew             (idu_lsu_ex1_vsew            ),
  .idu_mult_ex1_gateclk_sel     (idu_mult_ex1_gateclk_sel    ),
  .idu_vidu_ex1_fp_dp_sel       (idu_vidu_ex1_fp_dp_sel      ),
  .idu_vidu_ex1_fp_gateclk_sel  (idu_vidu_ex1_fp_gateclk_sel ),
  .idu_vidu_ex1_fp_sel          (idu_vidu_ex1_fp_sel         ),
  .idu_vidu_ex1_inst_data       (idu_vidu_ex1_inst_data      ),
  .idu_vidu_ex1_vec_dp_sel      (idu_vidu_ex1_vec_dp_sel     ),
  .idu_vidu_ex1_vec_gateclk_sel (idu_vidu_ex1_vec_gateclk_sel),
  .idu_vidu_ex1_vec_sel         (idu_vidu_ex1_vec_sel        ),
  .ifu_idu_id_bht_pred          (ifu_idu_id_bht_pred         ),
  .ifu_idu_id_expt_acc_error    (ifu_idu_id_expt_acc_error   ),
  .ifu_idu_id_expt_high         (ifu_idu_id_expt_high        ),
  .ifu_idu_id_expt_page_fault   (ifu_idu_id_expt_page_fault  ),
  .ifu_idu_id_halt_info         (ifu_idu_id_halt_info        ),
  .ifu_idu_id_inst              (ifu_idu_id_inst             ),
  .ifu_idu_id_inst_vld          (ifu_idu_id_inst_vld         ),
  .ifu_idu_warm_up              (ifu_idu_warm_up             ),
  .iu_idu_bju_full              (iu_idu_bju_full             ),
  .iu_idu_bju_global_full       (iu_idu_bju_global_full      ),
  .iu_idu_div_full              (iu_idu_div_full             ),
  .iu_idu_mult_full             (iu_idu_mult_full            ),
  .iu_idu_mult_issue_stall      (iu_idu_mult_issue_stall     ),
  .iu_yy_xx_cancel              (iu_yy_xx_cancel             ),
  .lsu_idu_full                 (lsu_idu_full                ),
  .lsu_idu_global_full          (lsu_idu_global_full         ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_idu_commit               (rtu_idu_commit              ),
  .rtu_idu_commit_for_bju       (rtu_idu_commit_for_bju      ),
  .rtu_idu_flush_fe             (rtu_idu_flush_fe            ),
  .rtu_idu_flush_stall          (rtu_idu_flush_stall         ),
  .rtu_idu_flush_wbt            (rtu_idu_flush_wbt           ),
  .rtu_idu_fwd0_data            (rtu_idu_fwd0_data           ),
  .rtu_idu_fwd0_reg             (rtu_idu_fwd0_reg            ),
  .rtu_idu_fwd0_vld             (rtu_idu_fwd0_vld            ),
  .rtu_idu_fwd1_data            (rtu_idu_fwd1_data           ),
  .rtu_idu_fwd1_reg             (rtu_idu_fwd1_reg            ),
  .rtu_idu_fwd1_vld             (rtu_idu_fwd1_vld            ),
  .rtu_idu_fwd2_data            (rtu_idu_fwd2_data           ),
  .rtu_idu_fwd2_reg             (rtu_idu_fwd2_reg            ),
  .rtu_idu_fwd2_vld             (rtu_idu_fwd2_vld            ),
  .rtu_idu_pipeline_empty       (rtu_idu_pipeline_empty      ),
  .rtu_idu_wb0_data             (rtu_idu_wb0_data            ),
  .rtu_idu_wb0_reg              (rtu_idu_wb0_reg             ),
  .rtu_idu_wb0_vld              (rtu_idu_wb0_vld             ),
  .rtu_idu_wb1_data             (rtu_idu_wb1_data            ),
  .rtu_idu_wb1_reg              (rtu_idu_wb1_reg             ),
  .rtu_idu_wb1_vld              (rtu_idu_wb1_vld             ),
  .rtu_yy_xx_dbgon              (rtu_yy_xx_dbgon             ),
  .vidu_idu_fp_full             (vidu_idu_fp_full            ),
  .vidu_idu_vec_full            (vidu_idu_vec_full           )
);


//==========================================================
//  Instance aq_vidu_top sub module 
//==========================================================
// &Instance("aq_vidu_top"); @51
aq_vidu_top  x_aq_vidu_top (
  .cp0_idu_icg_en                   (cp0_idu_icg_en                  ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .idu_vidu_ex1_fp_dp_sel           (idu_vidu_ex1_fp_dp_sel          ),
  .idu_vidu_ex1_fp_gateclk_sel      (idu_vidu_ex1_fp_gateclk_sel     ),
  .idu_vidu_ex1_fp_sel              (idu_vidu_ex1_fp_sel             ),
  .idu_vidu_ex1_inst_data           (idu_vidu_ex1_inst_data          ),
  .idu_vidu_ex1_vec_dp_sel          (idu_vidu_ex1_vec_dp_sel         ),
  .idu_vidu_ex1_vec_gateclk_sel     (idu_vidu_ex1_vec_gateclk_sel    ),
  .idu_vidu_ex1_vec_sel             (idu_vidu_ex1_vec_sel            ),
  .ifu_vidu_warm_up                 (ifu_vidu_warm_up                ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_vidu_flush_wbt               (rtu_vidu_flush_wbt              ),
  .rtu_yy_xx_async_flush            (rtu_yy_xx_async_flush           ),
  .vidu_cp0_vid_fof_vld             (vidu_cp0_vid_fof_vld            ),
  .vidu_dtu_debug_info              (vidu_dtu_debug_info             ),
  .vidu_idu_fp_full                 (vidu_idu_fp_full                ),
  .vidu_idu_vec_full                (vidu_idu_vec_full               ),
  .vidu_rtu_no_op                   (vidu_rtu_no_op                  ),
  .vidu_vpu_vid_fp_inst_dp_vld      (vidu_vpu_vid_fp_inst_dp_vld     ),
  .vidu_vpu_vid_fp_inst_dst_reg     (vidu_vpu_vid_fp_inst_dst_reg    ),
  .vidu_vpu_vid_fp_inst_dst_vld     (vidu_vpu_vid_fp_inst_dst_vld    ),
  .vidu_vpu_vid_fp_inst_dste_vld    (vidu_vpu_vid_fp_inst_dste_vld   ),
  .vidu_vpu_vid_fp_inst_dstf_reg    (vidu_vpu_vid_fp_inst_dstf_reg   ),
  .vidu_vpu_vid_fp_inst_dstf_vld    (vidu_vpu_vid_fp_inst_dstf_vld   ),
  .vidu_vpu_vid_fp_inst_eu          (vidu_vpu_vid_fp_inst_eu         ),
  .vidu_vpu_vid_fp_inst_func        (vidu_vpu_vid_fp_inst_func       ),
  .vidu_vpu_vid_fp_inst_gateclk_vld (vidu_vpu_vid_fp_inst_gateclk_vld),
  .vidu_vpu_vid_fp_inst_src1_data   (vidu_vpu_vid_fp_inst_src1_data  ),
  .vidu_vpu_vid_fp_inst_srcf0_data  (vidu_vpu_vid_fp_inst_srcf0_data ),
  .vidu_vpu_vid_fp_inst_srcf1_data  (vidu_vpu_vid_fp_inst_srcf1_data ),
  .vidu_vpu_vid_fp_inst_srcf2_data  (vidu_vpu_vid_fp_inst_srcf2_data ),
  .vidu_vpu_vid_fp_inst_srcf2_rdy   (vidu_vpu_vid_fp_inst_srcf2_rdy  ),
  .vidu_vpu_vid_fp_inst_srcf2_vld   (vidu_vpu_vid_fp_inst_srcf2_vld  ),
  .vidu_vpu_vid_fp_inst_vld         (vidu_vpu_vid_fp_inst_vld        ),
  .vpu_rtu_ex1_cmplt                (vpu_rtu_ex1_cmplt               ),
  .vpu_rtu_ex1_cmplt_dp             (vpu_rtu_ex1_cmplt_dp            ),
  .vpu_rtu_ex1_fp_dirty             (vpu_rtu_ex1_fp_dirty            ),
  .vpu_rtu_ex1_vec_dirty            (vpu_rtu_ex1_vec_dirty           ),
  .vpu_vidu_fp_fwd_data             (vpu_vidu_fp_fwd_data            ),
  .vpu_vidu_fp_fwd_reg              (vpu_vidu_fp_fwd_reg             ),
  .vpu_vidu_fp_fwd_vld              (vpu_vidu_fp_fwd_vld             ),
  .vpu_vidu_fp_wb_data              (vpu_vidu_fp_wb_data             ),
  .vpu_vidu_fp_wb_reg               (vpu_vidu_fp_wb_reg              ),
  .vpu_vidu_fp_wb_vld               (vpu_vidu_fp_wb_vld              ),
  .vpu_vidu_vex1_fp_stall           (vpu_vidu_vex1_fp_stall          ),
  .vpu_vidu_wbt_fp_wb0_reg          (vpu_vidu_wbt_fp_wb0_reg         ),
  .vpu_vidu_wbt_fp_wb0_vld          (vpu_vidu_wbt_fp_wb0_vld         ),
  .vpu_vidu_wbt_fp_wb1_reg          (vpu_vidu_wbt_fp_wb1_reg         ),
  .vpu_vidu_wbt_fp_wb1_vld          (vpu_vidu_wbt_fp_wb1_vld         )
);


//==========================================================
//  Instance aq_iu_top sub module 
//==========================================================
// &Instance("aq_iu_top"); @56
aq_iu_top  x_aq_iu_top (
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_xx_mrvbr                 (cp0_xx_mrvbr                ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .da_xx_fwd_data               (da_xx_fwd_data              ),
  .da_xx_fwd_dst_reg            (da_xx_fwd_dst_reg           ),
  .da_xx_fwd_vld                (da_xx_fwd_vld               ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_iu_cnt_en               (hpcp_iu_cnt_en              ),
  .idu_alu_ex1_gateclk_sel      (idu_alu_ex1_gateclk_sel     ),
  .idu_bju_ex1_gateclk_sel      (idu_bju_ex1_gateclk_sel     ),
  .idu_div_ex1_gateclk_sel      (idu_div_ex1_gateclk_sel     ),
  .idu_iu_ex1_alu_dp_sel        (idu_iu_ex1_alu_dp_sel       ),
  .idu_iu_ex1_alu_sel           (idu_iu_ex1_alu_sel          ),
  .idu_iu_ex1_bht_pred          (idu_iu_ex1_bht_pred         ),
  .idu_iu_ex1_bju_br_sel        (idu_iu_ex1_bju_br_sel       ),
  .idu_iu_ex1_bju_dp_sel        (idu_iu_ex1_bju_dp_sel       ),
  .idu_iu_ex1_bju_sel           (idu_iu_ex1_bju_sel          ),
  .idu_iu_ex1_div_dp_sel        (idu_iu_ex1_div_dp_sel       ),
  .idu_iu_ex1_div_sel           (idu_iu_ex1_div_sel          ),
  .idu_iu_ex1_dst0_reg          (idu_iu_ex1_dst0_reg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_inst_vld          (idu_iu_ex1_inst_vld         ),
  .idu_iu_ex1_length            (idu_iu_ex1_length           ),
  .idu_iu_ex1_mult_dp_sel       (idu_iu_ex1_mult_dp_sel      ),
  .idu_iu_ex1_mult_sel          (idu_iu_ex1_mult_sel         ),
  .idu_iu_ex1_pipedown_vld      (idu_iu_ex1_pipedown_vld     ),
  .idu_iu_ex1_split             (idu_iu_ex1_split            ),
  .idu_iu_ex1_src0_data         (idu_iu_ex1_src0_data        ),
  .idu_iu_ex1_src0_ready        (idu_iu_ex1_src0_ready       ),
  .idu_iu_ex1_src0_reg          (idu_iu_ex1_src0_reg         ),
  .idu_iu_ex1_src1_data         (idu_iu_ex1_src1_data        ),
  .idu_iu_ex1_src1_ready        (idu_iu_ex1_src1_ready       ),
  .idu_iu_ex1_src1_reg          (idu_iu_ex1_src1_reg         ),
  .idu_iu_ex1_src2_data         (idu_iu_ex1_src2_data        ),
  .idu_mult_ex1_gateclk_sel     (idu_mult_ex1_gateclk_sel    ),
  .ifu_iu_chgflw_pc             (ifu_iu_chgflw_pc            ),
  .ifu_iu_chgflw_vld            (ifu_iu_chgflw_vld           ),
  .ifu_iu_ex1_pc_pred           (ifu_iu_ex1_pc_pred          ),
  .ifu_iu_reset_vld             (ifu_iu_reset_vld            ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .iu_cp0_ex1_cur_pc            (iu_cp0_ex1_cur_pc           ),
  .iu_dtu_debug_info            (iu_dtu_debug_info           ),
  .iu_hpcp_inst_bht_mispred     (iu_hpcp_inst_bht_mispred    ),
  .iu_hpcp_inst_condbr          (iu_hpcp_inst_condbr         ),
  .iu_hpcp_jump_8m              (iu_hpcp_jump_8m             ),
  .iu_idu_bju_full              (iu_idu_bju_full             ),
  .iu_idu_bju_global_full       (iu_idu_bju_global_full      ),
  .iu_idu_div_full              (iu_idu_div_full             ),
  .iu_idu_mult_full             (iu_idu_mult_full            ),
  .iu_idu_mult_issue_stall      (iu_idu_mult_issue_stall     ),
  .iu_ifu_bht_cur_pc            (iu_ifu_bht_cur_pc           ),
  .iu_ifu_bht_mispred           (iu_ifu_bht_mispred          ),
  .iu_ifu_bht_mispred_gate      (iu_ifu_bht_mispred_gate     ),
  .iu_ifu_bht_pred              (iu_ifu_bht_pred             ),
  .iu_ifu_bht_taken             (iu_ifu_bht_taken            ),
  .iu_ifu_br_vld                (iu_ifu_br_vld               ),
  .iu_ifu_br_vld_gate           (iu_ifu_br_vld_gate          ),
  .iu_ifu_link_vld              (iu_ifu_link_vld             ),
  .iu_ifu_link_vld_gate         (iu_ifu_link_vld_gate        ),
  .iu_ifu_pc_mispred            (iu_ifu_pc_mispred           ),
  .iu_ifu_pc_mispred_gate       (iu_ifu_pc_mispred_gate      ),
  .iu_ifu_ret_vld               (iu_ifu_ret_vld              ),
  .iu_ifu_ret_vld_gate          (iu_ifu_ret_vld_gate         ),
  .iu_ifu_tar_pc                (iu_ifu_tar_pc               ),
  .iu_ifu_tar_pc_vld            (iu_ifu_tar_pc_vld           ),
  .iu_ifu_tar_pc_vld_gate       (iu_ifu_tar_pc_vld_gate      ),
  .iu_lsu_ex1_cur_pc            (iu_lsu_ex1_cur_pc           ),
  .iu_rtu_depd_lsu_chgflow_vld  (iu_rtu_depd_lsu_chgflow_vld ),
  .iu_rtu_depd_lsu_next_pc      (iu_rtu_depd_lsu_next_pc     ),
  .iu_rtu_div_data              (iu_rtu_div_data             ),
  .iu_rtu_div_preg              (iu_rtu_div_preg             ),
  .iu_rtu_div_wb_dp             (iu_rtu_div_wb_dp            ),
  .iu_rtu_div_wb_vld            (iu_rtu_div_wb_vld           ),
  .iu_rtu_ex1_alu_cmplt         (iu_rtu_ex1_alu_cmplt        ),
  .iu_rtu_ex1_alu_cmplt_dp      (iu_rtu_ex1_alu_cmplt_dp     ),
  .iu_rtu_ex1_alu_data          (iu_rtu_ex1_alu_data         ),
  .iu_rtu_ex1_alu_inst_len      (iu_rtu_ex1_alu_inst_len     ),
  .iu_rtu_ex1_alu_inst_split    (iu_rtu_ex1_alu_inst_split   ),
  .iu_rtu_ex1_alu_preg          (iu_rtu_ex1_alu_preg         ),
  .iu_rtu_ex1_alu_wb_dp         (iu_rtu_ex1_alu_wb_dp        ),
  .iu_rtu_ex1_alu_wb_vld        (iu_rtu_ex1_alu_wb_vld       ),
  .iu_rtu_ex1_bju_cmplt         (iu_rtu_ex1_bju_cmplt        ),
  .iu_rtu_ex1_bju_cmplt_dp      (iu_rtu_ex1_bju_cmplt_dp     ),
  .iu_rtu_ex1_bju_data          (iu_rtu_ex1_bju_data         ),
  .iu_rtu_ex1_bju_inst_len      (iu_rtu_ex1_bju_inst_len     ),
  .iu_rtu_ex1_bju_preg          (iu_rtu_ex1_bju_preg         ),
  .iu_rtu_ex1_bju_wb_dp         (iu_rtu_ex1_bju_wb_dp        ),
  .iu_rtu_ex1_bju_wb_vld        (iu_rtu_ex1_bju_wb_vld       ),
  .iu_rtu_ex1_branch_inst       (iu_rtu_ex1_branch_inst      ),
  .iu_rtu_ex1_cur_pc            (iu_rtu_ex1_cur_pc           ),
  .iu_rtu_ex1_div_cmplt         (iu_rtu_ex1_div_cmplt        ),
  .iu_rtu_ex1_div_cmplt_dp      (iu_rtu_ex1_div_cmplt_dp     ),
  .iu_rtu_ex1_mul_cmplt         (iu_rtu_ex1_mul_cmplt        ),
  .iu_rtu_ex1_mul_cmplt_dp      (iu_rtu_ex1_mul_cmplt_dp     ),
  .iu_rtu_ex1_next_pc           (iu_rtu_ex1_next_pc          ),
  .iu_rtu_ex2_bju_ras_mispred   (iu_rtu_ex2_bju_ras_mispred  ),
  .iu_rtu_ex3_mul_data          (iu_rtu_ex3_mul_data         ),
  .iu_rtu_ex3_mul_preg          (iu_rtu_ex3_mul_preg         ),
  .iu_rtu_ex3_mul_wb_vld        (iu_rtu_ex3_mul_wb_vld       ),
  .iu_xx_no_op                  (iu_xx_no_op                 ),
  .iu_yy_xx_cancel              (iu_yy_xx_cancel             ),
  .lsu_iu_ex2_data              (lsu_iu_ex2_data             ),
  .lsu_iu_ex2_data_vld          (lsu_iu_ex2_data_vld         ),
  .lsu_iu_ex2_dest_reg          (lsu_iu_ex2_dest_reg         ),
  .mmu_xx_mmu_en                (mmu_xx_mmu_en               ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_iu_div_wb_grant          (rtu_iu_div_wb_grant         ),
  .rtu_iu_div_wb_grant_for_full (rtu_iu_div_wb_grant_for_full),
  .rtu_iu_ex1_cmplt             (rtu_iu_ex1_cmplt            ),
  .rtu_iu_ex1_cmplt_dp          (rtu_iu_ex1_cmplt_dp         ),
  .rtu_iu_ex1_inst_len          (rtu_iu_ex1_inst_len         ),
  .rtu_iu_ex1_inst_split        (rtu_iu_ex1_inst_split       ),
  .rtu_iu_ex2_cur_pc            (rtu_iu_ex2_cur_pc           ),
  .rtu_iu_ex2_next_pc           (rtu_iu_ex2_next_pc          ),
  .rtu_iu_mul_wb_grant          (rtu_iu_mul_wb_grant         ),
  .rtu_iu_mul_wb_grant_for_full (rtu_iu_mul_wb_grant_for_full),
  .rtu_yy_xx_flush_fe           (rtu_yy_xx_flush_fe          )
);


//==========================================================
//  Instance aq_vpu_top sub module 
//==========================================================
// &Instance("aq_vpu_top"); @61
aq_vpu_top  x_aq_vpu_top (
  .cp0_vpu_icg_en                   (cp0_vpu_icg_en                  ),
  .cp0_vpu_xx_bf16                  (cp0_vpu_xx_bf16                 ),
  .cp0_vpu_xx_dqnan                 (cp0_vpu_xx_dqnan                ),
  .cp0_vpu_xx_rm                    (cp0_vpu_xx_rm                   ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .ifu_vpu_warm_up                  (ifu_vpu_warm_up                 ),
  .lsu_vlsu_bytes_vld               (lsu_vlsu_bytes_vld              ),
  .lsu_vlsu_data                    (lsu_vlsu_data                   ),
  .lsu_vlsu_data_grant              (lsu_vlsu_data_grant             ),
  .lsu_vlsu_data_vld                (lsu_vlsu_data_vld               ),
  .lsu_vlsu_dc_create_vld           (lsu_vlsu_dc_create_vld          ),
  .lsu_vlsu_dc_fld_req              (lsu_vlsu_dc_fld_req             ),
  .lsu_vlsu_dc_fof                  (lsu_vlsu_dc_fof                 ),
  .lsu_vlsu_dc_nf                   (lsu_vlsu_dc_nf                  ),
  .lsu_vlsu_dc_sew                  (lsu_vlsu_dc_sew                 ),
  .lsu_vlsu_dc_split_cnt            (lsu_vlsu_dc_split_cnt           ),
  .lsu_vlsu_dc_sseg_first           (lsu_vlsu_dc_sseg_first          ),
  .lsu_vlsu_dc_stall                (lsu_vlsu_dc_stall               ),
  .lsu_vlsu_dest_reg                (lsu_vlsu_dest_reg               ),
  .lsu_vlsu_expt_vld                (lsu_vlsu_expt_vld               ),
  .lsu_vlsu_func                    (lsu_vlsu_func                   ),
  .lsu_vlsu_sew                     (lsu_vlsu_sew                    ),
  .lsu_vlsu_split_last              (lsu_vlsu_split_last             ),
  .lsu_vlsu_st_expt                 (lsu_vlsu_st_expt                ),
  .lsu_vlsu_st_offset               (lsu_vlsu_st_offset              ),
  .lsu_vlsu_st_sew                  (lsu_vlsu_st_sew                 ),
  .lsu_vlsu_st_size                 (lsu_vlsu_st_size                ),
  .lsu_vlsu_vl_update               (lsu_vlsu_vl_update              ),
  .lsu_vlsu_vl_upval                (lsu_vlsu_vl_upval               ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_vpu_gpr_wb_grnt              (rtu_vpu_gpr_wb_grnt             ),
  .rtu_yy_xx_async_flush            (rtu_yy_xx_async_flush           ),
  .rtu_yy_xx_flush                  (rtu_yy_xx_flush                 ),
  .vidu_vpu_vid_fp_inst_dp_vld      (vidu_vpu_vid_fp_inst_dp_vld     ),
  .vidu_vpu_vid_fp_inst_dst_reg     (vidu_vpu_vid_fp_inst_dst_reg    ),
  .vidu_vpu_vid_fp_inst_dst_vld     (vidu_vpu_vid_fp_inst_dst_vld    ),
  .vidu_vpu_vid_fp_inst_dste_vld    (vidu_vpu_vid_fp_inst_dste_vld   ),
  .vidu_vpu_vid_fp_inst_dstf_reg    (vidu_vpu_vid_fp_inst_dstf_reg   ),
  .vidu_vpu_vid_fp_inst_dstf_vld    (vidu_vpu_vid_fp_inst_dstf_vld   ),
  .vidu_vpu_vid_fp_inst_eu          (vidu_vpu_vid_fp_inst_eu         ),
  .vidu_vpu_vid_fp_inst_func        (vidu_vpu_vid_fp_inst_func       ),
  .vidu_vpu_vid_fp_inst_gateclk_vld (vidu_vpu_vid_fp_inst_gateclk_vld),
  .vidu_vpu_vid_fp_inst_src1_data   (vidu_vpu_vid_fp_inst_src1_data  ),
  .vidu_vpu_vid_fp_inst_srcf0_data  (vidu_vpu_vid_fp_inst_srcf0_data ),
  .vidu_vpu_vid_fp_inst_srcf1_data  (vidu_vpu_vid_fp_inst_srcf1_data ),
  .vidu_vpu_vid_fp_inst_srcf2_data  (vidu_vpu_vid_fp_inst_srcf2_data ),
  .vidu_vpu_vid_fp_inst_srcf2_rdy   (vidu_vpu_vid_fp_inst_srcf2_rdy  ),
  .vidu_vpu_vid_fp_inst_srcf2_vld   (vidu_vpu_vid_fp_inst_srcf2_vld  ),
  .vidu_vpu_vid_fp_inst_vld         (vidu_vpu_vid_fp_inst_vld        ),
  .vlsu_buf_stall                   (vlsu_buf_stall                  ),
  .vlsu_dtu_data                    (vlsu_dtu_data                   ),
  .vlsu_dtu_data_vld                (vlsu_dtu_data_vld               ),
  .vlsu_dtu_data_vld_gate           (vlsu_dtu_data_vld_gate          ),
  .vlsu_lsu_data_shift              (vlsu_lsu_data_shift             ),
  .vlsu_lsu_data_vld                (vlsu_lsu_data_vld               ),
  .vlsu_lsu_fwd_data                (vlsu_lsu_fwd_data               ),
  .vlsu_lsu_fwd_dest_reg            (vlsu_lsu_fwd_dest_reg           ),
  .vlsu_lsu_fwd_vld                 (vlsu_lsu_fwd_vld                ),
  .vlsu_lsu_src2_depd               (vlsu_lsu_src2_depd              ),
  .vlsu_lsu_src2_reg                (vlsu_lsu_src2_reg               ),
  .vlsu_lsu_wdata                   (vlsu_lsu_wdata                  ),
  .vlsu_rtu_vl_updt_data            (vlsu_rtu_vl_updt_data           ),
  .vlsu_rtu_vl_updt_vld             (vlsu_rtu_vl_updt_vld            ),
  .vlsu_xx_no_op                    (vlsu_xx_no_op                   ),
  .vpu_dtu_dbg_info                 (vpu_dtu_dbg_info                ),
  .vpu_rtu_fflag                    (vpu_rtu_fflag                   ),
  .vpu_rtu_fflag_vld                (vpu_rtu_fflag_vld               ),
  .vpu_rtu_gpr_wb_data              (vpu_rtu_gpr_wb_data             ),
  .vpu_rtu_gpr_wb_index             (vpu_rtu_gpr_wb_index            ),
  .vpu_rtu_gpr_wb_req               (vpu_rtu_gpr_wb_req              ),
  .vpu_rtu_no_op                    (vpu_rtu_no_op                   ),
  .vpu_vidu_fp_fwd_data             (vpu_vidu_fp_fwd_data            ),
  .vpu_vidu_fp_fwd_reg              (vpu_vidu_fp_fwd_reg             ),
  .vpu_vidu_fp_fwd_vld              (vpu_vidu_fp_fwd_vld             ),
  .vpu_vidu_fp_wb_data              (vpu_vidu_fp_wb_data             ),
  .vpu_vidu_fp_wb_reg               (vpu_vidu_fp_wb_reg              ),
  .vpu_vidu_fp_wb_vld               (vpu_vidu_fp_wb_vld              ),
  .vpu_vidu_vex1_fp_stall           (vpu_vidu_vex1_fp_stall          ),
  .vpu_vidu_wbt_fp_wb0_reg          (vpu_vidu_wbt_fp_wb0_reg         ),
  .vpu_vidu_wbt_fp_wb0_vld          (vpu_vidu_wbt_fp_wb0_vld         ),
  .vpu_vidu_wbt_fp_wb1_reg          (vpu_vidu_wbt_fp_wb1_reg         ),
  .vpu_vidu_wbt_fp_wb1_vld          (vpu_vidu_wbt_fp_wb1_vld         )
);


//==========================================================
//  Instance aq_lsu_top sub module 
//==========================================================
// &Instance("aq_lsu_top"); @66
aq_lsu_top  x_aq_lsu_top (
  .biu_lsu_arready              (biu_lsu_arready             ),
  .biu_lsu_no_op                (biu_lsu_no_op               ),
  .biu_lsu_rdata                (biu_lsu_rdata               ),
  .biu_lsu_rid                  (biu_lsu_rid                 ),
  .biu_lsu_rlast                (biu_lsu_rlast               ),
  .biu_lsu_rresp                (biu_lsu_rresp               ),
  .biu_lsu_rvalid               (biu_lsu_rvalid              ),
  .biu_lsu_stb_awready          (biu_lsu_stb_awready         ),
  .biu_lsu_stb_wready           (biu_lsu_stb_wready          ),
  .biu_lsu_vb_awready           (biu_lsu_vb_awready          ),
  .biu_lsu_vb_wready            (biu_lsu_vb_wready           ),
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
  .cp0_lsu_fence_req            (cp0_lsu_fence_req           ),
  .cp0_lsu_icc_addr             (cp0_lsu_icc_addr            ),
  .cp0_lsu_icc_op               (cp0_lsu_icc_op              ),
  .cp0_lsu_icc_req              (cp0_lsu_icc_req             ),
  .cp0_lsu_icc_type             (cp0_lsu_icc_type            ),
  .cp0_lsu_icg_en               (cp0_lsu_icg_en              ),
  .cp0_lsu_mm                   (cp0_lsu_mm                  ),
  .cp0_lsu_mpp                  (cp0_lsu_mpp                 ),
  .cp0_lsu_mprv                 (cp0_lsu_mprv                ),
  .cp0_lsu_sync_req             (cp0_lsu_sync_req            ),
  .cp0_lsu_we_en                (cp0_lsu_we_en               ),
  .cp0_yy_priv_mode             (cp0_yy_priv_mode            ),
  .cpurst_b                     (cpurst_b                    ),
  .da_xx_fwd_data               (da_xx_fwd_data              ),
  .da_xx_fwd_dst_reg            (da_xx_fwd_dst_reg           ),
  .da_xx_fwd_vld                (da_xx_fwd_vld               ),
  .dtu_lsu_addr_trig_en         (dtu_lsu_addr_trig_en        ),
  .dtu_lsu_data_trig_en         (dtu_lsu_data_trig_en        ),
  .dtu_lsu_halt_info            (dtu_lsu_halt_info           ),
  .dtu_lsu_halt_info_vld        (dtu_lsu_halt_info_vld       ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_lsu_cnt_en              (hpcp_lsu_cnt_en             ),
  .idu_lsu_ex1_dp_sel           (idu_lsu_ex1_dp_sel          ),
  .idu_lsu_ex1_dst0_reg         (idu_lsu_ex1_dst0_reg        ),
  .idu_lsu_ex1_dst1_reg         (idu_lsu_ex1_dst1_reg        ),
  .idu_lsu_ex1_func             (idu_lsu_ex1_func            ),
  .idu_lsu_ex1_gateclk_sel      (idu_lsu_ex1_gateclk_sel     ),
  .idu_lsu_ex1_halt_info        (idu_lsu_ex1_halt_info       ),
  .idu_lsu_ex1_length           (idu_lsu_ex1_length          ),
  .idu_lsu_ex1_sel              (idu_lsu_ex1_sel             ),
  .idu_lsu_ex1_split            (idu_lsu_ex1_split           ),
  .idu_lsu_ex1_src0_data        (idu_lsu_ex1_src0_data       ),
  .idu_lsu_ex1_src1_data        (idu_lsu_ex1_src1_data       ),
  .idu_lsu_ex1_src2_data        (idu_lsu_ex1_src2_data       ),
  .idu_lsu_ex1_src2_ready       (idu_lsu_ex1_src2_ready      ),
  .idu_lsu_ex1_src2_reg         (idu_lsu_ex1_src2_reg        ),
  .idu_lsu_ex1_vlmul            (idu_lsu_ex1_vlmul           ),
  .idu_lsu_ex1_vsew             (idu_lsu_ex1_vsew            ),
  .ifu_lsu_warm_up              (ifu_lsu_warm_up             ),
  .iu_lsu_ex1_cur_pc            (iu_lsu_ex1_cur_pc           ),
  .lsu_biu_araddr               (lsu_biu_araddr              ),
  .lsu_biu_arburst              (lsu_biu_arburst             ),
  .lsu_biu_arcache              (lsu_biu_arcache             ),
  .lsu_biu_arid                 (lsu_biu_arid                ),
  .lsu_biu_arlen                (lsu_biu_arlen               ),
  .lsu_biu_arprot               (lsu_biu_arprot              ),
  .lsu_biu_arsize               (lsu_biu_arsize              ),
  .lsu_biu_aruser               (lsu_biu_aruser              ),
  .lsu_biu_arvalid              (lsu_biu_arvalid             ),
  .lsu_biu_stb_awaddr           (lsu_biu_stb_awaddr          ),
  .lsu_biu_stb_awburst          (lsu_biu_stb_awburst         ),
  .lsu_biu_stb_awcache          (lsu_biu_stb_awcache         ),
  .lsu_biu_stb_awid             (lsu_biu_stb_awid            ),
  .lsu_biu_stb_awlen            (lsu_biu_stb_awlen           ),
  .lsu_biu_stb_awprot           (lsu_biu_stb_awprot          ),
  .lsu_biu_stb_awsize           (lsu_biu_stb_awsize          ),
  .lsu_biu_stb_awuser           (lsu_biu_stb_awuser          ),
  .lsu_biu_stb_awvalid          (lsu_biu_stb_awvalid         ),
  .lsu_biu_stb_wdata            (lsu_biu_stb_wdata           ),
  .lsu_biu_stb_wlast            (lsu_biu_stb_wlast           ),
  .lsu_biu_stb_wstrb            (lsu_biu_stb_wstrb           ),
  .lsu_biu_stb_wvalid           (lsu_biu_stb_wvalid          ),
  .lsu_biu_vb_awaddr            (lsu_biu_vb_awaddr           ),
  .lsu_biu_vb_awburst           (lsu_biu_vb_awburst          ),
  .lsu_biu_vb_awcache           (lsu_biu_vb_awcache          ),
  .lsu_biu_vb_awid              (lsu_biu_vb_awid             ),
  .lsu_biu_vb_awlen             (lsu_biu_vb_awlen            ),
  .lsu_biu_vb_awprot            (lsu_biu_vb_awprot           ),
  .lsu_biu_vb_awsize            (lsu_biu_vb_awsize           ),
  .lsu_biu_vb_awvalid           (lsu_biu_vb_awvalid          ),
  .lsu_biu_vb_wdata             (lsu_biu_vb_wdata            ),
  .lsu_biu_vb_wlast             (lsu_biu_vb_wlast            ),
  .lsu_biu_vb_wstrb             (lsu_biu_vb_wstrb            ),
  .lsu_biu_vb_wvalid            (lsu_biu_vb_wvalid           ),
  .lsu_cp0_dcache_read_data     (lsu_cp0_dcache_read_data    ),
  .lsu_cp0_dcache_read_data_vld (lsu_cp0_dcache_read_data_vld),
  .lsu_cp0_fence_ack            (lsu_cp0_fence_ack           ),
  .lsu_cp0_icc_done             (lsu_cp0_icc_done            ),
  .lsu_cp0_sync_ack             (lsu_cp0_sync_ack            ),
  .lsu_dtu_debug_info           (lsu_dtu_debug_info          ),
  .lsu_dtu_halt_info            (lsu_dtu_halt_info           ),
  .lsu_dtu_last_check           (lsu_dtu_last_check          ),
  .lsu_dtu_ldst_addr            (lsu_dtu_ldst_addr           ),
  .lsu_dtu_ldst_addr_vld        (lsu_dtu_ldst_addr_vld       ),
  .lsu_dtu_ldst_bytes_vld       (lsu_dtu_ldst_bytes_vld      ),
  .lsu_dtu_ldst_data            (lsu_dtu_ldst_data           ),
  .lsu_dtu_ldst_data_vld        (lsu_dtu_ldst_data_vld       ),
  .lsu_dtu_ldst_type            (lsu_dtu_ldst_type           ),
  .lsu_dtu_mem_access_size      (lsu_dtu_mem_access_size     ),
  .lsu_hpcp_cache_read_access   (lsu_hpcp_cache_read_access  ),
  .lsu_hpcp_cache_read_miss     (lsu_hpcp_cache_read_miss    ),
  .lsu_hpcp_cache_write_access  (lsu_hpcp_cache_write_access ),
  .lsu_hpcp_cache_write_miss    (lsu_hpcp_cache_write_miss   ),
  .lsu_hpcp_inst_store          (lsu_hpcp_inst_store         ),
  .lsu_hpcp_unalign_inst        (lsu_hpcp_unalign_inst       ),
  .lsu_idu_full                 (lsu_idu_full                ),
  .lsu_idu_global_full          (lsu_idu_global_full         ),
  .lsu_iu_ex2_data              (lsu_iu_ex2_data             ),
  .lsu_iu_ex2_data_vld          (lsu_iu_ex2_data_vld         ),
  .lsu_iu_ex2_dest_reg          (lsu_iu_ex2_dest_reg         ),
  .lsu_mmu_abort                (lsu_mmu_abort               ),
  .lsu_mmu_bus_error            (lsu_mmu_bus_error           ),
  .lsu_mmu_data                 (lsu_mmu_data                ),
  .lsu_mmu_data_vld             (lsu_mmu_data_vld            ),
  .lsu_mmu_priv_mode            (lsu_mmu_priv_mode           ),
  .lsu_mmu_st_inst              (lsu_mmu_st_inst             ),
  .lsu_mmu_va                   (lsu_mmu_va                  ),
  .lsu_mmu_va_vld               (lsu_mmu_va_vld              ),
  .lsu_rtu_async_expt_vld       (lsu_rtu_async_expt_vld      ),
  .lsu_rtu_async_ld_inst        (lsu_rtu_async_ld_inst       ),
  .lsu_rtu_async_tval           (lsu_rtu_async_tval          ),
  .lsu_rtu_ex1_buffer_vld       (lsu_rtu_ex1_buffer_vld      ),
  .lsu_rtu_ex1_cmplt            (lsu_rtu_ex1_cmplt           ),
  .lsu_rtu_ex1_cmplt_dp         (lsu_rtu_ex1_cmplt_dp        ),
  .lsu_rtu_ex1_cmplt_for_pcgen  (lsu_rtu_ex1_cmplt_for_pcgen ),
  .lsu_rtu_ex1_data             (lsu_rtu_ex1_data            ),
  .lsu_rtu_ex1_dest_reg         (lsu_rtu_ex1_dest_reg        ),
  .lsu_rtu_ex1_expt_tval        (lsu_rtu_ex1_expt_tval       ),
  .lsu_rtu_ex1_expt_vec         (lsu_rtu_ex1_expt_vec        ),
  .lsu_rtu_ex1_expt_vld         (lsu_rtu_ex1_expt_vld        ),
  .lsu_rtu_ex1_fs_dirty         (lsu_rtu_ex1_fs_dirty        ),
  .lsu_rtu_ex1_halt_info        (lsu_rtu_ex1_halt_info       ),
  .lsu_rtu_ex1_inst_len         (lsu_rtu_ex1_inst_len        ),
  .lsu_rtu_ex1_inst_split       (lsu_rtu_ex1_inst_split      ),
  .lsu_rtu_ex1_tval2_vld        (lsu_rtu_ex1_tval2_vld       ),
  .lsu_rtu_ex1_vs_dirty         (lsu_rtu_ex1_vs_dirty        ),
  .lsu_rtu_ex1_vstart           (lsu_rtu_ex1_vstart          ),
  .lsu_rtu_ex1_vstart_vld       (lsu_rtu_ex1_vstart_vld      ),
  .lsu_rtu_ex1_wb_dp            (lsu_rtu_ex1_wb_dp           ),
  .lsu_rtu_ex1_wb_vld           (lsu_rtu_ex1_wb_vld          ),
  .lsu_rtu_ex2_data             (lsu_rtu_ex2_data            ),
  .lsu_rtu_ex2_data_vld         (lsu_rtu_ex2_data_vld        ),
  .lsu_rtu_ex2_dest_reg         (lsu_rtu_ex2_dest_reg        ),
  .lsu_rtu_ex2_tval2            (lsu_rtu_ex2_tval2           ),
  .lsu_rtu_no_op                (lsu_rtu_no_op               ),
  .lsu_rtu_wb_data              (lsu_rtu_wb_data             ),
  .lsu_rtu_wb_dest_reg          (lsu_rtu_wb_dest_reg         ),
  .lsu_rtu_wb_vld               (lsu_rtu_wb_vld              ),
  .lsu_vlsu_bytes_vld           (lsu_vlsu_bytes_vld          ),
  .lsu_vlsu_data                (lsu_vlsu_data               ),
  .lsu_vlsu_data_grant          (lsu_vlsu_data_grant         ),
  .lsu_vlsu_data_vld            (lsu_vlsu_data_vld           ),
  .lsu_vlsu_dc_create_vld       (lsu_vlsu_dc_create_vld      ),
  .lsu_vlsu_dc_fld_req          (lsu_vlsu_dc_fld_req         ),
  .lsu_vlsu_dc_fof              (lsu_vlsu_dc_fof             ),
  .lsu_vlsu_dc_nf               (lsu_vlsu_dc_nf              ),
  .lsu_vlsu_dc_sew              (lsu_vlsu_dc_sew             ),
  .lsu_vlsu_dc_split_cnt        (lsu_vlsu_dc_split_cnt       ),
  .lsu_vlsu_dc_sseg_first       (lsu_vlsu_dc_sseg_first      ),
  .lsu_vlsu_dc_stall            (lsu_vlsu_dc_stall           ),
  .lsu_vlsu_dest_reg            (lsu_vlsu_dest_reg           ),
  .lsu_vlsu_expt_vld            (lsu_vlsu_expt_vld           ),
  .lsu_vlsu_func                (lsu_vlsu_func               ),
  .lsu_vlsu_sew                 (lsu_vlsu_sew                ),
  .lsu_vlsu_split_last          (lsu_vlsu_split_last         ),
  .lsu_vlsu_st_expt             (lsu_vlsu_st_expt            ),
  .lsu_vlsu_st_offset           (lsu_vlsu_st_offset          ),
  .lsu_vlsu_st_sew              (lsu_vlsu_st_sew             ),
  .lsu_vlsu_st_size             (lsu_vlsu_st_size            ),
  .lsu_vlsu_vl_update           (lsu_vlsu_vl_update          ),
  .lsu_vlsu_vl_upval            (lsu_vlsu_vl_upval           ),
  .mmu_lsu_access_fault         (mmu_lsu_access_fault        ),
  .mmu_lsu_buf                  (mmu_lsu_buf                 ),
  .mmu_lsu_ca                   (mmu_lsu_ca                  ),
  .mmu_lsu_data_req             (mmu_lsu_data_req            ),
  .mmu_lsu_data_req_addr        (mmu_lsu_data_req_addr       ),
  .mmu_lsu_data_req_size        (mmu_lsu_data_req_size       ),
  .mmu_lsu_pa                   (mmu_lsu_pa                  ),
  .mmu_lsu_pa_vld               (mmu_lsu_pa_vld              ),
  .mmu_lsu_page_fault           (mmu_lsu_page_fault          ),
  .mmu_lsu_sec                  (mmu_lsu_sec                 ),
  .mmu_lsu_sh                   (mmu_lsu_sh                  ),
  .mmu_lsu_so                   (mmu_lsu_so                  ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_lsu_async_expt_ack       (rtu_lsu_async_expt_ack      ),
  .rtu_lsu_expt_ack             (rtu_lsu_expt_ack            ),
  .rtu_lsu_expt_exit            (rtu_lsu_expt_exit           ),
  .rtu_yy_xx_async_flush        (rtu_yy_xx_async_flush       ),
  .rtu_yy_xx_dbgon              (rtu_yy_xx_dbgon             ),
  .rtu_yy_xx_flush              (rtu_yy_xx_flush             ),
  .vlsu_buf_stall               (vlsu_buf_stall              ),
  .vlsu_dtu_data                (vlsu_dtu_data               ),
  .vlsu_dtu_data_vld            (vlsu_dtu_data_vld           ),
  .vlsu_dtu_data_vld_gate       (vlsu_dtu_data_vld_gate      ),
  .vlsu_lsu_data_shift          (vlsu_lsu_data_shift         ),
  .vlsu_lsu_data_vld            (vlsu_lsu_data_vld           ),
  .vlsu_lsu_fwd_data            (vlsu_lsu_fwd_data           ),
  .vlsu_lsu_fwd_dest_reg        (vlsu_lsu_fwd_dest_reg       ),
  .vlsu_lsu_fwd_vld             (vlsu_lsu_fwd_vld            ),
  .vlsu_lsu_src2_depd           (vlsu_lsu_src2_depd          ),
  .vlsu_lsu_src2_reg            (vlsu_lsu_src2_reg           ),
  .vlsu_lsu_wdata               (vlsu_lsu_wdata              ),
  .vlsu_xx_no_op                (vlsu_xx_no_op               )
);


//==========================================================
//  Instance aq_cp0_top sub module 
//==========================================================
// &Instance("aq_cp0_top"); @71
aq_cp0_top  x_aq_cp0_top (
  .biu_cp0_coreid               (biu_cp0_coreid              ),
  .biu_cp0_me_int               (biu_cp0_me_int              ),
  .biu_cp0_ms_int               (biu_cp0_ms_int              ),
  .biu_cp0_mt_int               (biu_cp0_mt_int              ),
  .biu_cp0_rvba                 (biu_cp0_rvba                ),
  .biu_cp0_se_int               (biu_cp0_se_int              ),
  .biu_cp0_ss_int               (biu_cp0_ss_int              ),
  .biu_cp0_st_int               (biu_cp0_st_int              ),
  .cp0_biu_icg_en               (cp0_biu_icg_en              ),
  .cp0_biu_lpmd_b               (cp0_biu_lpmd_b              ),
  .cp0_dtu_addr                 (cp0_dtu_addr                ),
  .cp0_dtu_debug_info           (cp0_dtu_debug_info          ),
  .cp0_dtu_icg_en               (cp0_dtu_icg_en              ),
  .cp0_dtu_mexpt_vld            (cp0_dtu_mexpt_vld           ),
  .cp0_dtu_pcfifo_frz           (cp0_dtu_pcfifo_frz          ),
  .cp0_dtu_rreg                 (cp0_dtu_rreg                ),
  .cp0_dtu_satp                 (cp0_dtu_satp                ),
  .cp0_dtu_wdata                (cp0_dtu_wdata               ),
  .cp0_dtu_wreg                 (cp0_dtu_wreg                ),
  .cp0_hpcp_icg_en              (cp0_hpcp_icg_en             ),
  .cp0_hpcp_index               (cp0_hpcp_index              ),
  .cp0_hpcp_int_off_vld         (cp0_hpcp_int_off_vld        ),
  .cp0_hpcp_mcntwen             (cp0_hpcp_mcntwen            ),
  .cp0_hpcp_pmdm                (cp0_hpcp_pmdm               ),
  .cp0_hpcp_pmds                (cp0_hpcp_pmds               ),
  .cp0_hpcp_pmdu                (cp0_hpcp_pmdu               ),
  .cp0_hpcp_sync_stall_vld      (cp0_hpcp_sync_stall_vld     ),
  .cp0_hpcp_wdata               (cp0_hpcp_wdata              ),
  .cp0_hpcp_wreg                (cp0_hpcp_wreg               ),
  .cp0_idu_cskyee               (cp0_idu_cskyee              ),
  .cp0_idu_dis_fence_in_dbg     (cp0_idu_dis_fence_in_dbg    ),
  .cp0_idu_frm                  (cp0_idu_frm                 ),
  .cp0_idu_fs                   (cp0_idu_fs                  ),
  .cp0_idu_icg_en               (cp0_idu_icg_en              ),
  .cp0_idu_issue_stall          (cp0_idu_issue_stall         ),
  .cp0_idu_ucme                 (cp0_idu_ucme                ),
  .cp0_idu_vill                 (cp0_idu_vill                ),
  .cp0_idu_vl_zero              (cp0_idu_vl_zero             ),
  .cp0_idu_vlmul                (cp0_idu_vlmul               ),
  .cp0_idu_vs                   (cp0_idu_vs                  ),
  .cp0_idu_vsetvl_dis_stall     (cp0_idu_vsetvl_dis_stall    ),
  .cp0_idu_vsew                 (cp0_idu_vsew                ),
  .cp0_idu_vstart               (cp0_idu_vstart              ),
  .cp0_ifu_bht_en               (cp0_ifu_bht_en              ),
  .cp0_ifu_bht_inv              (cp0_ifu_bht_inv             ),
  .cp0_ifu_btb_clr              (cp0_ifu_btb_clr             ),
  .cp0_ifu_btb_en               (cp0_ifu_btb_en              ),
  .cp0_ifu_icache_en            (cp0_ifu_icache_en           ),
  .cp0_ifu_icache_inv_addr      (cp0_ifu_icache_inv_addr     ),
  .cp0_ifu_icache_inv_req       (cp0_ifu_icache_inv_req      ),
  .cp0_ifu_icache_inv_type      (cp0_ifu_icache_inv_type     ),
  .cp0_ifu_icache_pref_en       (cp0_ifu_icache_pref_en      ),
  .cp0_ifu_icache_read_index    (cp0_ifu_icache_read_index   ),
  .cp0_ifu_icache_read_req      (cp0_ifu_icache_read_req     ),
  .cp0_ifu_icache_read_tag      (cp0_ifu_icache_read_tag     ),
  .cp0_ifu_icache_read_way      (cp0_ifu_icache_read_way     ),
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_ifu_in_lpmd              (cp0_ifu_in_lpmd             ),
  .cp0_ifu_iwpe                 (cp0_ifu_iwpe                ),
  .cp0_ifu_lpmd_req             (cp0_ifu_lpmd_req            ),
  .cp0_ifu_ras_en               (cp0_ifu_ras_en              ),
  .cp0_ifu_rst_inv_done         (cp0_ifu_rst_inv_done        ),
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
  .cp0_lsu_fence_req            (cp0_lsu_fence_req           ),
  .cp0_lsu_icc_addr             (cp0_lsu_icc_addr            ),
  .cp0_lsu_icc_op               (cp0_lsu_icc_op              ),
  .cp0_lsu_icc_req              (cp0_lsu_icc_req             ),
  .cp0_lsu_icc_type             (cp0_lsu_icc_type            ),
  .cp0_lsu_icg_en               (cp0_lsu_icg_en              ),
  .cp0_lsu_mm                   (cp0_lsu_mm                  ),
  .cp0_lsu_mpp                  (cp0_lsu_mpp                 ),
  .cp0_lsu_mprv                 (cp0_lsu_mprv                ),
  .cp0_lsu_sync_req             (cp0_lsu_sync_req            ),
  .cp0_lsu_we_en                (cp0_lsu_we_en               ),
  .cp0_mmu_addr                 (cp0_mmu_addr                ),
  .cp0_mmu_icg_en               (cp0_mmu_icg_en              ),
  .cp0_mmu_lpmd_req             (cp0_mmu_lpmd_req            ),
  .cp0_mmu_maee                 (cp0_mmu_maee                ),
  .cp0_mmu_mxr                  (cp0_mmu_mxr                 ),
  .cp0_mmu_ptw_en               (cp0_mmu_ptw_en              ),
  .cp0_mmu_satp_data            (cp0_mmu_satp_data           ),
  .cp0_mmu_satp_wen             (cp0_mmu_satp_wen            ),
  .cp0_mmu_sum                  (cp0_mmu_sum                 ),
  .cp0_mmu_tlb_all_inv          (cp0_mmu_tlb_all_inv         ),
  .cp0_mmu_tlb_asid             (cp0_mmu_tlb_asid            ),
  .cp0_mmu_tlb_asid_all_inv     (cp0_mmu_tlb_asid_all_inv    ),
  .cp0_mmu_tlb_va               (cp0_mmu_tlb_va              ),
  .cp0_mmu_tlb_va_all_inv       (cp0_mmu_tlb_va_all_inv      ),
  .cp0_mmu_tlb_va_asid_inv      (cp0_mmu_tlb_va_asid_inv     ),
  .cp0_mmu_wdata                (cp0_mmu_wdata               ),
  .cp0_mmu_wreg                 (cp0_mmu_wreg                ),
  .cp0_pmp_addr                 (cp0_pmp_addr                ),
  .cp0_pmp_icg_en               (cp0_pmp_icg_en              ),
  .cp0_pmp_wdata                (cp0_pmp_wdata               ),
  .cp0_pmp_wreg                 (cp0_pmp_wreg                ),
  .cp0_rtu_ex1_chgflw           (cp0_rtu_ex1_chgflw          ),
  .cp0_rtu_ex1_chgflw_pc        (cp0_rtu_ex1_chgflw_pc       ),
  .cp0_rtu_ex1_cmplt            (cp0_rtu_ex1_cmplt           ),
  .cp0_rtu_ex1_cmplt_dp         (cp0_rtu_ex1_cmplt_dp        ),
  .cp0_rtu_ex1_expt_tval        (cp0_rtu_ex1_expt_tval       ),
  .cp0_rtu_ex1_expt_vec         (cp0_rtu_ex1_expt_vec        ),
  .cp0_rtu_ex1_expt_vld         (cp0_rtu_ex1_expt_vld        ),
  .cp0_rtu_ex1_flush            (cp0_rtu_ex1_flush           ),
  .cp0_rtu_ex1_halt_info        (cp0_rtu_ex1_halt_info       ),
  .cp0_rtu_ex1_inst_dret        (cp0_rtu_ex1_inst_dret       ),
  .cp0_rtu_ex1_inst_ebreak      (cp0_rtu_ex1_inst_ebreak     ),
  .cp0_rtu_ex1_inst_len         (cp0_rtu_ex1_inst_len        ),
  .cp0_rtu_ex1_inst_mret        (cp0_rtu_ex1_inst_mret       ),
  .cp0_rtu_ex1_inst_split       (cp0_rtu_ex1_inst_split      ),
  .cp0_rtu_ex1_inst_sret        (cp0_rtu_ex1_inst_sret       ),
  .cp0_rtu_ex1_vs_dirty         (cp0_rtu_ex1_vs_dirty        ),
  .cp0_rtu_ex1_vs_dirty_dp      (cp0_rtu_ex1_vs_dirty_dp     ),
  .cp0_rtu_ex1_wb_data          (cp0_rtu_ex1_wb_data         ),
  .cp0_rtu_ex1_wb_dp            (cp0_rtu_ex1_wb_dp           ),
  .cp0_rtu_ex1_wb_preg          (cp0_rtu_ex1_wb_preg         ),
  .cp0_rtu_ex1_wb_vld           (cp0_rtu_ex1_wb_vld          ),
  .cp0_rtu_fence_idle           (cp0_rtu_fence_idle          ),
  .cp0_rtu_icg_en               (cp0_rtu_icg_en              ),
  .cp0_rtu_in_lpmd              (cp0_rtu_in_lpmd             ),
  .cp0_rtu_int_vld              (cp0_rtu_int_vld             ),
  .cp0_rtu_trap_pc              (cp0_rtu_trap_pc             ),
  .cp0_rtu_vstart_eq_0          (cp0_rtu_vstart_eq_0         ),
  .cp0_vpu_icg_en               (cp0_vpu_icg_en              ),
  .cp0_vpu_xx_bf16              (cp0_vpu_xx_bf16             ),
  .cp0_vpu_xx_dqnan             (cp0_vpu_xx_dqnan            ),
  .cp0_vpu_xx_rm                (cp0_vpu_xx_rm               ),
  .cp0_xx_mrvbr                 (cp0_xx_mrvbr                ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cp0_yy_priv_mode             (cp0_yy_priv_mode            ),
  .cpurst_b                     (cpurst_b                    ),
  .dtu_cp0_dcsr_mprven          (dtu_cp0_dcsr_mprven         ),
  .dtu_cp0_dcsr_prv             (dtu_cp0_dcsr_prv            ),
  .dtu_cp0_rdata                (dtu_cp0_rdata               ),
  .dtu_cp0_wake_up              (dtu_cp0_wake_up             ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_cp0_data                (hpcp_cp0_data               ),
  .hpcp_cp0_int_vld             (hpcp_cp0_int_vld            ),
  .hpcp_cp0_sce                 (hpcp_cp0_sce                ),
  .idu_cp0_ex1_dp_sel           (idu_cp0_ex1_dp_sel          ),
  .idu_cp0_ex1_dst0_reg         (idu_cp0_ex1_dst0_reg        ),
  .idu_cp0_ex1_expt_acc_error   (idu_cp0_ex1_expt_acc_error  ),
  .idu_cp0_ex1_expt_high        (idu_cp0_ex1_expt_high       ),
  .idu_cp0_ex1_expt_illegal     (idu_cp0_ex1_expt_illegal    ),
  .idu_cp0_ex1_expt_page_fault  (idu_cp0_ex1_expt_page_fault ),
  .idu_cp0_ex1_func             (idu_cp0_ex1_func            ),
  .idu_cp0_ex1_gateclk_sel      (idu_cp0_ex1_gateclk_sel     ),
  .idu_cp0_ex1_halt_info        (idu_cp0_ex1_halt_info       ),
  .idu_cp0_ex1_length           (idu_cp0_ex1_length          ),
  .idu_cp0_ex1_opcode           (idu_cp0_ex1_opcode          ),
  .idu_cp0_ex1_sel              (idu_cp0_ex1_sel             ),
  .idu_cp0_ex1_split            (idu_cp0_ex1_split           ),
  .idu_cp0_ex1_src0_data        (idu_cp0_ex1_src0_data       ),
  .idu_cp0_ex1_src1_data        (idu_cp0_ex1_src1_data       ),
  .ifu_cp0_bht_inv_done         (ifu_cp0_bht_inv_done        ),
  .ifu_cp0_icache_inv_done      (ifu_cp0_icache_inv_done     ),
  .ifu_cp0_icache_read_data     (ifu_cp0_icache_read_data    ),
  .ifu_cp0_icache_read_data_vld (ifu_cp0_icache_read_data_vld),
  .ifu_cp0_rst_inv_req          (ifu_cp0_rst_inv_req         ),
  .ifu_cp0_warm_up              (ifu_cp0_warm_up             ),
  .ifu_yy_xx_no_op              (ifu_yy_xx_no_op             ),
  .iu_cp0_ex1_cur_pc            (iu_cp0_ex1_cur_pc           ),
  .lsu_cp0_dcache_read_data     (lsu_cp0_dcache_read_data    ),
  .lsu_cp0_dcache_read_data_vld (lsu_cp0_dcache_read_data_vld),
  .lsu_cp0_fence_ack            (lsu_cp0_fence_ack           ),
  .lsu_cp0_icc_done             (lsu_cp0_icc_done            ),
  .lsu_cp0_sync_ack             (lsu_cp0_sync_ack            ),
  .mmu_cp0_cmplt                (mmu_cp0_cmplt               ),
  .mmu_cp0_data                 (mmu_cp0_data                ),
  .mmu_cp0_tlb_inv_done         (mmu_cp0_tlb_inv_done        ),
  .mmu_yy_xx_no_op              (mmu_yy_xx_no_op             ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .pmp_cp0_data                 (pmp_cp0_data                ),
  .rtu_cp0_epc                  (rtu_cp0_epc                 ),
  .rtu_cp0_exit_debug           (rtu_cp0_exit_debug          ),
  .rtu_cp0_fflags               (rtu_cp0_fflags              ),
  .rtu_cp0_fflags_updt          (rtu_cp0_fflags_updt         ),
  .rtu_cp0_fs_dirty_updt        (rtu_cp0_fs_dirty_updt       ),
  .rtu_cp0_fs_dirty_updt_dp     (rtu_cp0_fs_dirty_updt_dp    ),
  .rtu_cp0_tval                 (rtu_cp0_tval                ),
  .rtu_cp0_vl                   (rtu_cp0_vl                  ),
  .rtu_cp0_vl_vld               (rtu_cp0_vl_vld              ),
  .rtu_cp0_vs_dirty_updt        (rtu_cp0_vs_dirty_updt       ),
  .rtu_cp0_vs_dirty_updt_dp     (rtu_cp0_vs_dirty_updt_dp    ),
  .rtu_cp0_vstart               (rtu_cp0_vstart              ),
  .rtu_cp0_vstart_vld           (rtu_cp0_vstart_vld          ),
  .rtu_cp0_vxsat                (rtu_cp0_vxsat               ),
  .rtu_cp0_vxsat_vld            (rtu_cp0_vxsat_vld           ),
  .rtu_yy_xx_dbgon              (rtu_yy_xx_dbgon             ),
  .rtu_yy_xx_expt_int           (rtu_yy_xx_expt_int          ),
  .rtu_yy_xx_expt_vec           (rtu_yy_xx_expt_vec          ),
  .rtu_yy_xx_expt_vld           (rtu_yy_xx_expt_vld          ),
  .rtu_yy_xx_flush              (rtu_yy_xx_flush             ),
  .sysio_cp0_apb_base           (sysio_cp0_apb_base          ),
  .vidu_cp0_vid_fof_vld         (vidu_cp0_vid_fof_vld        )
);


//==========================================================
//  Instance aq_rtu_top sub module 
//==========================================================
// &Instance("aq_rtu_top"); @76
aq_rtu_top  x_aq_rtu_top (
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
  .cp0_rtu_fence_idle            (cp0_rtu_fence_idle           ),
  .cp0_rtu_icg_en                (cp0_rtu_icg_en               ),
  .cp0_rtu_in_lpmd               (cp0_rtu_in_lpmd              ),
  .cp0_rtu_int_vld               (cp0_rtu_int_vld              ),
  .cp0_rtu_trap_pc               (cp0_rtu_trap_pc              ),
  .cp0_rtu_vstart_eq_0           (cp0_rtu_vstart_eq_0          ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .cpurst_b                      (cpurst_b                     ),
  .dtu_rtu_async_halt_req        (dtu_rtu_async_halt_req       ),
  .dtu_rtu_dpc                   (dtu_rtu_dpc                  ),
  .dtu_rtu_ebreak_action         (dtu_rtu_ebreak_action        ),
  .dtu_rtu_int_mask              (dtu_rtu_int_mask             ),
  .dtu_rtu_pending_tval          (dtu_rtu_pending_tval         ),
  .dtu_rtu_resume_req            (dtu_rtu_resume_req           ),
  .dtu_rtu_step_en               (dtu_rtu_step_en              ),
  .dtu_rtu_sync_flush            (dtu_rtu_sync_flush           ),
  .dtu_rtu_sync_halt_req         (dtu_rtu_sync_halt_req        ),
  .forever_cpuclk                (forever_cpuclk               ),
  .hpcp_rtu_cnt_en               (hpcp_rtu_cnt_en              ),
  .ifu_rtu_reset_halt_req        (ifu_rtu_reset_halt_req       ),
  .ifu_rtu_warm_up               (ifu_rtu_warm_up              ),
  .iu_rtu_depd_lsu_chgflow_vld   (iu_rtu_depd_lsu_chgflow_vld  ),
  .iu_rtu_depd_lsu_next_pc       (iu_rtu_depd_lsu_next_pc      ),
  .iu_rtu_div_data               (iu_rtu_div_data              ),
  .iu_rtu_div_preg               (iu_rtu_div_preg              ),
  .iu_rtu_div_wb_dp              (iu_rtu_div_wb_dp             ),
  .iu_rtu_div_wb_vld             (iu_rtu_div_wb_vld            ),
  .iu_rtu_ex1_alu_cmplt          (iu_rtu_ex1_alu_cmplt         ),
  .iu_rtu_ex1_alu_cmplt_dp       (iu_rtu_ex1_alu_cmplt_dp      ),
  .iu_rtu_ex1_alu_data           (iu_rtu_ex1_alu_data          ),
  .iu_rtu_ex1_alu_inst_len       (iu_rtu_ex1_alu_inst_len      ),
  .iu_rtu_ex1_alu_inst_split     (iu_rtu_ex1_alu_inst_split    ),
  .iu_rtu_ex1_alu_preg           (iu_rtu_ex1_alu_preg          ),
  .iu_rtu_ex1_alu_wb_dp          (iu_rtu_ex1_alu_wb_dp         ),
  .iu_rtu_ex1_alu_wb_vld         (iu_rtu_ex1_alu_wb_vld        ),
  .iu_rtu_ex1_bju_cmplt          (iu_rtu_ex1_bju_cmplt         ),
  .iu_rtu_ex1_bju_cmplt_dp       (iu_rtu_ex1_bju_cmplt_dp      ),
  .iu_rtu_ex1_bju_data           (iu_rtu_ex1_bju_data          ),
  .iu_rtu_ex1_bju_inst_len       (iu_rtu_ex1_bju_inst_len      ),
  .iu_rtu_ex1_bju_preg           (iu_rtu_ex1_bju_preg          ),
  .iu_rtu_ex1_bju_wb_dp          (iu_rtu_ex1_bju_wb_dp         ),
  .iu_rtu_ex1_bju_wb_vld         (iu_rtu_ex1_bju_wb_vld        ),
  .iu_rtu_ex1_branch_inst        (iu_rtu_ex1_branch_inst       ),
  .iu_rtu_ex1_cur_pc             (iu_rtu_ex1_cur_pc            ),
  .iu_rtu_ex1_div_cmplt          (iu_rtu_ex1_div_cmplt         ),
  .iu_rtu_ex1_div_cmplt_dp       (iu_rtu_ex1_div_cmplt_dp      ),
  .iu_rtu_ex1_mul_cmplt          (iu_rtu_ex1_mul_cmplt         ),
  .iu_rtu_ex1_mul_cmplt_dp       (iu_rtu_ex1_mul_cmplt_dp      ),
  .iu_rtu_ex1_next_pc            (iu_rtu_ex1_next_pc           ),
  .iu_rtu_ex2_bju_ras_mispred    (iu_rtu_ex2_bju_ras_mispred   ),
  .iu_rtu_ex3_mul_data           (iu_rtu_ex3_mul_data          ),
  .iu_rtu_ex3_mul_preg           (iu_rtu_ex3_mul_preg          ),
  .iu_rtu_ex3_mul_wb_vld         (iu_rtu_ex3_mul_wb_vld        ),
  .iu_xx_no_op                   (iu_xx_no_op                  ),
  .lsu_rtu_async_expt_vld        (lsu_rtu_async_expt_vld       ),
  .lsu_rtu_async_ld_inst         (lsu_rtu_async_ld_inst        ),
  .lsu_rtu_async_tval            (lsu_rtu_async_tval           ),
  .lsu_rtu_ex1_buffer_vld        (lsu_rtu_ex1_buffer_vld       ),
  .lsu_rtu_ex1_cmplt             (lsu_rtu_ex1_cmplt            ),
  .lsu_rtu_ex1_cmplt_dp          (lsu_rtu_ex1_cmplt_dp         ),
  .lsu_rtu_ex1_cmplt_for_pcgen   (lsu_rtu_ex1_cmplt_for_pcgen  ),
  .lsu_rtu_ex1_data              (lsu_rtu_ex1_data             ),
  .lsu_rtu_ex1_dest_reg          (lsu_rtu_ex1_dest_reg         ),
  .lsu_rtu_ex1_expt_tval         (lsu_rtu_ex1_expt_tval        ),
  .lsu_rtu_ex1_expt_vec          (lsu_rtu_ex1_expt_vec         ),
  .lsu_rtu_ex1_expt_vld          (lsu_rtu_ex1_expt_vld         ),
  .lsu_rtu_ex1_fs_dirty          (lsu_rtu_ex1_fs_dirty         ),
  .lsu_rtu_ex1_halt_info         (lsu_rtu_ex1_halt_info        ),
  .lsu_rtu_ex1_inst_len          (lsu_rtu_ex1_inst_len         ),
  .lsu_rtu_ex1_inst_split        (lsu_rtu_ex1_inst_split       ),
  .lsu_rtu_ex1_tval2_vld         (lsu_rtu_ex1_tval2_vld        ),
  .lsu_rtu_ex1_vs_dirty          (lsu_rtu_ex1_vs_dirty         ),
  .lsu_rtu_ex1_vstart            (lsu_rtu_ex1_vstart           ),
  .lsu_rtu_ex1_vstart_vld        (lsu_rtu_ex1_vstart_vld       ),
  .lsu_rtu_ex1_wb_dp             (lsu_rtu_ex1_wb_dp            ),
  .lsu_rtu_ex1_wb_vld            (lsu_rtu_ex1_wb_vld           ),
  .lsu_rtu_ex2_data              (lsu_rtu_ex2_data             ),
  .lsu_rtu_ex2_data_vld          (lsu_rtu_ex2_data_vld         ),
  .lsu_rtu_ex2_dest_reg          (lsu_rtu_ex2_dest_reg         ),
  .lsu_rtu_ex2_tval2             (lsu_rtu_ex2_tval2            ),
  .lsu_rtu_no_op                 (lsu_rtu_no_op                ),
  .lsu_rtu_wb_data               (lsu_rtu_wb_data              ),
  .lsu_rtu_wb_dest_reg           (lsu_rtu_wb_dest_reg          ),
  .lsu_rtu_wb_vld                (lsu_rtu_wb_vld               ),
  .mmu_xx_mmu_en                 (mmu_xx_mmu_en                ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
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
  .rtu_cpu_no_retire             (rtu_cpu_no_retire            ),
  .rtu_dtu_debug_info            (rtu_dtu_debug_info           ),
  .rtu_dtu_dpc                   (rtu_dtu_dpc                  ),
  .rtu_dtu_halt_ack              (rtu_dtu_halt_ack             ),
  .rtu_dtu_pending_ack           (rtu_dtu_pending_ack          ),
  .rtu_dtu_retire_chgflw         (rtu_dtu_retire_chgflw        ),
  .rtu_dtu_retire_debug_expt_vld (rtu_dtu_retire_debug_expt_vld),
  .rtu_dtu_retire_halt_info      (rtu_dtu_retire_halt_info     ),
  .rtu_dtu_retire_mret           (rtu_dtu_retire_mret          ),
  .rtu_dtu_retire_next_pc        (rtu_dtu_retire_next_pc       ),
  .rtu_dtu_retire_sret           (rtu_dtu_retire_sret          ),
  .rtu_dtu_retire_vld            (rtu_dtu_retire_vld           ),
  .rtu_dtu_tval                  (rtu_dtu_tval                 ),
  .rtu_hpcp_int_vld              (rtu_hpcp_int_vld             ),
  .rtu_hpcp_retire_inst_vld      (rtu_hpcp_retire_inst_vld     ),
  .rtu_hpcp_retire_pc            (rtu_hpcp_retire_pc           ),
  .rtu_idu_commit                (rtu_idu_commit               ),
  .rtu_idu_commit_for_bju        (rtu_idu_commit_for_bju       ),
  .rtu_idu_flush_fe              (rtu_idu_flush_fe             ),
  .rtu_idu_flush_stall           (rtu_idu_flush_stall          ),
  .rtu_idu_flush_wbt             (rtu_idu_flush_wbt            ),
  .rtu_idu_fwd0_data             (rtu_idu_fwd0_data            ),
  .rtu_idu_fwd0_reg              (rtu_idu_fwd0_reg             ),
  .rtu_idu_fwd0_vld              (rtu_idu_fwd0_vld             ),
  .rtu_idu_fwd1_data             (rtu_idu_fwd1_data            ),
  .rtu_idu_fwd1_reg              (rtu_idu_fwd1_reg             ),
  .rtu_idu_fwd1_vld              (rtu_idu_fwd1_vld             ),
  .rtu_idu_fwd2_data             (rtu_idu_fwd2_data            ),
  .rtu_idu_fwd2_reg              (rtu_idu_fwd2_reg             ),
  .rtu_idu_fwd2_vld              (rtu_idu_fwd2_vld             ),
  .rtu_idu_pipeline_empty        (rtu_idu_pipeline_empty       ),
  .rtu_idu_wb0_data              (rtu_idu_wb0_data             ),
  .rtu_idu_wb0_reg               (rtu_idu_wb0_reg              ),
  .rtu_idu_wb0_vld               (rtu_idu_wb0_vld              ),
  .rtu_idu_wb1_data              (rtu_idu_wb1_data             ),
  .rtu_idu_wb1_reg               (rtu_idu_wb1_reg              ),
  .rtu_idu_wb1_vld               (rtu_idu_wb1_vld              ),
  .rtu_ifu_chgflw_pc             (rtu_ifu_chgflw_pc            ),
  .rtu_ifu_chgflw_vld            (rtu_ifu_chgflw_vld           ),
  .rtu_ifu_dbg_mask              (rtu_ifu_dbg_mask             ),
  .rtu_ifu_flush_fe              (rtu_ifu_flush_fe             ),
  .rtu_iu_div_wb_grant           (rtu_iu_div_wb_grant          ),
  .rtu_iu_div_wb_grant_for_full  (rtu_iu_div_wb_grant_for_full ),
  .rtu_iu_ex1_cmplt              (rtu_iu_ex1_cmplt             ),
  .rtu_iu_ex1_cmplt_dp           (rtu_iu_ex1_cmplt_dp          ),
  .rtu_iu_ex1_inst_len           (rtu_iu_ex1_inst_len          ),
  .rtu_iu_ex1_inst_split         (rtu_iu_ex1_inst_split        ),
  .rtu_iu_ex2_cur_pc             (rtu_iu_ex2_cur_pc            ),
  .rtu_iu_ex2_next_pc            (rtu_iu_ex2_next_pc           ),
  .rtu_iu_mul_wb_grant           (rtu_iu_mul_wb_grant          ),
  .rtu_iu_mul_wb_grant_for_full  (rtu_iu_mul_wb_grant_for_full ),
  .rtu_lsu_async_expt_ack        (rtu_lsu_async_expt_ack       ),
  .rtu_lsu_expt_ack              (rtu_lsu_expt_ack             ),
  .rtu_lsu_expt_exit             (rtu_lsu_expt_exit            ),
  .rtu_mmu_bad_vpn               (rtu_mmu_bad_vpn              ),
  .rtu_mmu_expt_vld              (rtu_mmu_expt_vld             ),
  .rtu_pad_halted                (rtu_pad_halted               ),
  .rtu_pad_retire                (rtu_pad_retire               ),
  .rtu_pad_retire_pc             (rtu_pad_retire_pc            ),
  .rtu_vidu_flush_wbt            (rtu_vidu_flush_wbt           ),
  .rtu_vpu_gpr_wb_grnt           (rtu_vpu_gpr_wb_grnt          ),
  .rtu_yy_xx_async_flush         (rtu_yy_xx_async_flush        ),
  .rtu_yy_xx_dbgon               (rtu_yy_xx_dbgon              ),
  .rtu_yy_xx_expt_int            (rtu_yy_xx_expt_int           ),
  .rtu_yy_xx_expt_vec            (rtu_yy_xx_expt_vec           ),
  .rtu_yy_xx_expt_vld            (rtu_yy_xx_expt_vld           ),
  .rtu_yy_xx_flush               (rtu_yy_xx_flush              ),
  .rtu_yy_xx_flush_fe            (rtu_yy_xx_flush_fe           ),
  .vidu_rtu_no_op                (vidu_rtu_no_op               ),
  .vlsu_rtu_vl_updt_data         (vlsu_rtu_vl_updt_data        ),
  .vlsu_rtu_vl_updt_vld          (vlsu_rtu_vl_updt_vld         ),
  .vpu_rtu_ex1_cmplt             (vpu_rtu_ex1_cmplt            ),
  .vpu_rtu_ex1_cmplt_dp          (vpu_rtu_ex1_cmplt_dp         ),
  .vpu_rtu_ex1_fp_dirty          (vpu_rtu_ex1_fp_dirty         ),
  .vpu_rtu_ex1_vec_dirty         (vpu_rtu_ex1_vec_dirty        ),
  .vpu_rtu_fflag                 (vpu_rtu_fflag                ),
  .vpu_rtu_fflag_vld             (vpu_rtu_fflag_vld            ),
  .vpu_rtu_gpr_wb_data           (vpu_rtu_gpr_wb_data          ),
  .vpu_rtu_gpr_wb_index          (vpu_rtu_gpr_wb_index         ),
  .vpu_rtu_gpr_wb_req            (vpu_rtu_gpr_wb_req           ),
  .vpu_rtu_no_op                 (vpu_rtu_no_op                )
);


// &ModuleEnd; @78
endmodule


