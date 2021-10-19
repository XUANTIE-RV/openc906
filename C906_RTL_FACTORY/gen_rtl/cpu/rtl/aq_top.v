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

// &Depend("cpu_cfig.h"); @24
// //&Depend("top_golden_port.vp"); @25

// &ModuleBeg; @27
module aq_top(
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
  clint_cpuio_time,
  cp0_biu_icg_en,
  cpuio_sysio_lpmd_b,
  cpurst_b,
  dtu_tdt_dm_halted,
  dtu_tdt_dm_havereset,
  dtu_tdt_dm_itr_done,
  dtu_tdt_dm_retire_debug_expt_vld,
  dtu_tdt_dm_rx_data,
  dtu_tdt_dm_wr_ready,
  forever_cpuclk,
  ifu_biu_araddr,
  ifu_biu_arburst,
  ifu_biu_arcache,
  ifu_biu_arid,
  ifu_biu_arlen,
  ifu_biu_arprot,
  ifu_biu_arsize,
  ifu_biu_arvalid,
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
  pad_biu_coreid,
  pad_yy_icg_scan_en,
  pad_yy_scan_mode,
  rtu_cpu_no_retire,
  rtu_pad_halted,
  rtu_pad_retire,
  rtu_pad_retire_pc,
  sys_apb_clk,
  sys_apb_rst_b,
  sysio_cp0_apb_base,
  sysio_cpuio_me_int,
  sysio_cpuio_ms_int,
  sysio_cpuio_mt_int,
  sysio_cpuio_se_int,
  sysio_cpuio_ss_int,
  sysio_cpuio_st_int,
  sysio_xx_rvba,
  tdt_dm_dtu_ack_havereset,
  tdt_dm_dtu_async_halt_req,
  tdt_dm_dtu_halt_on_reset,
  tdt_dm_dtu_halt_req,
  tdt_dm_dtu_itr,
  tdt_dm_dtu_itr_vld,
  tdt_dm_dtu_resume_req,
  tdt_dm_dtu_wdata,
  tdt_dm_dtu_wr_flg,
  tdt_dm_dtu_wr_vld
);

//&Ports("compare", "../../../gen_rtl/cpu/rtl/top_golden_port.v");
// &Ports; @29
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
input   [63 :0]  clint_cpuio_time;                
input            cpurst_b;                        
input            forever_cpuclk;                  
input   [2  :0]  pad_biu_coreid;                  
input            pad_yy_icg_scan_en;              
input            pad_yy_scan_mode;                
input            sys_apb_clk;                     
input            sys_apb_rst_b;                   
input   [39 :0]  sysio_cp0_apb_base;              
input            sysio_cpuio_me_int;              
input            sysio_cpuio_ms_int;              
input            sysio_cpuio_mt_int;              
input            sysio_cpuio_se_int;              
input            sysio_cpuio_ss_int;              
input            sysio_cpuio_st_int;              
input   [39 :0]  sysio_xx_rvba;                   
input            tdt_dm_dtu_ack_havereset;        
input            tdt_dm_dtu_async_halt_req;       
input            tdt_dm_dtu_halt_on_reset;        
input            tdt_dm_dtu_halt_req;             
input   [31 :0]  tdt_dm_dtu_itr;                  
input            tdt_dm_dtu_itr_vld;              
input            tdt_dm_dtu_resume_req;           
input   [63 :0]  tdt_dm_dtu_wdata;                
input   [1  :0]  tdt_dm_dtu_wr_flg;               
input            tdt_dm_dtu_wr_vld;               
output           cp0_biu_icg_en;                  
output  [1  :0]  cpuio_sysio_lpmd_b;              
output           dtu_tdt_dm_halted;               
output           dtu_tdt_dm_havereset;            
output           dtu_tdt_dm_itr_done;             
output           dtu_tdt_dm_retire_debug_expt_vld; 
output  [63 :0]  dtu_tdt_dm_rx_data;              
output           dtu_tdt_dm_wr_ready;             
output  [39 :0]  ifu_biu_araddr;                  
output  [1  :0]  ifu_biu_arburst;                 
output  [3  :0]  ifu_biu_arcache;                 
output           ifu_biu_arid;                    
output  [1  :0]  ifu_biu_arlen;                   
output  [2  :0]  ifu_biu_arprot;                  
output  [2  :0]  ifu_biu_arsize;                  
output           ifu_biu_arvalid;                 
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
output           rtu_cpu_no_retire;               
output           rtu_pad_halted;                  
output           rtu_pad_retire;                  
output  [39 :0]  rtu_pad_retire_pc;               

// &Regs; @30

// &Wires; @31
wire    [2  :0]  biu_cp0_coreid;                  
wire             biu_cp0_me_int;                  
wire             biu_cp0_ms_int;                  
wire             biu_cp0_mt_int;                  
wire    [39 :0]  biu_cp0_rvba;                    
wire             biu_cp0_se_int;                  
wire             biu_cp0_ss_int;                  
wire             biu_cp0_st_int;                  
wire    [63 :0]  biu_hpcp_time;                   
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
wire    [63 :0]  clint_cpuio_time;                
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
wire             cp0_yy_clk_en;                   
wire    [1  :0]  cp0_yy_priv_mode;                
wire    [1  :0]  cpuio_sysio_lpmd_b;              
wire             cpurst_b;                        
wire             dtu_cp0_dcsr_mprven;             
wire    [1  :0]  dtu_cp0_dcsr_prv;                
wire    [63 :0]  dtu_cp0_rdata;                   
wire             dtu_cp0_wake_up;                 
wire             dtu_hpcp_dcsr_stopcount;         
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
wire             dtu_tdt_dm_halted;               
wire             dtu_tdt_dm_havereset;            
wire             dtu_tdt_dm_itr_done;             
wire             dtu_tdt_dm_retire_debug_expt_vld; 
wire    [63 :0]  dtu_tdt_dm_rx_data;              
wire             dtu_tdt_dm_wr_ready;             
wire             forever_cpuclk;                  
wire    [63 :0]  hpcp_cp0_data;                   
wire             hpcp_cp0_int_vld;                
wire             hpcp_cp0_sce;                    
wire             hpcp_idu_cnt_en;                 
wire             hpcp_ifu_cnt_en;                 
wire             hpcp_iu_cnt_en;                  
wire             hpcp_lsu_cnt_en;                 
wire             hpcp_mmu_cnt_en;                 
wire             hpcp_rtu_cnt_en;                 
wire    [14 :0]  idu_dtu_debug_info;              
wire             idu_hpcp_backend_stall;          
wire             idu_hpcp_frontend_stall;         
wire    [6  :0]  idu_hpcp_inst_type;              
wire    [39 :0]  ifu_biu_araddr;                  
wire    [1  :0]  ifu_biu_arburst;                 
wire    [3  :0]  ifu_biu_arcache;                 
wire             ifu_biu_arid;                    
wire    [1  :0]  ifu_biu_arlen;                   
wire    [2  :0]  ifu_biu_arprot;                  
wire    [2  :0]  ifu_biu_arsize;                  
wire             ifu_biu_arvalid;                 
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
wire             ifu_mmu_abort;                   
wire    [51 :0]  ifu_mmu_va;                      
wire             ifu_mmu_va_vld;                  
wire    [8  :0]  iu_dtu_debug_info;               
wire             iu_hpcp_inst_bht_mispred;        
wire             iu_hpcp_inst_condbr;             
wire             iu_hpcp_jump_8m;                 
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
wire             lsu_mmu_abort;                   
wire             lsu_mmu_bus_error;               
wire    [63 :0]  lsu_mmu_data;                    
wire             lsu_mmu_data_vld;                
wire    [1  :0]  lsu_mmu_priv_mode;               
wire             lsu_mmu_st_inst;                 
wire    [51 :0]  lsu_mmu_va;                      
wire             lsu_mmu_va_vld;                  
wire             mmu_cp0_cmplt;                   
wire    [63 :0]  mmu_cp0_data;                    
wire             mmu_cp0_tlb_inv_done;            
wire    [15 :0]  mmu_dtu_debug_info;              
wire             mmu_hpcp_dutlb_miss;             
wire             mmu_hpcp_iutlb_miss;             
wire             mmu_hpcp_jtlb_miss;              
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
wire             mmu_pmp_chk1;                    
wire    [27 :0]  mmu_pmp_pa;                      
wire    [1  :0]  mmu_pmp_priv_mode;               
wire             mmu_xx_mmu_en;                   
wire             mmu_yy_xx_no_op;                 
wire    [2  :0]  pad_biu_coreid;                  
wire             pad_yy_icg_scan_en;              
wire             pad_yy_scan_mode;                
wire    [63 :0]  pmp_cp0_data;                    
wire    [3  :0]  pmp_mmu_flg;                     
wire    [15 :0]  pmp_mmu_hit_num;                 
wire             pmp_mmu_napot_cross;             
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
wire    [26 :0]  rtu_mmu_bad_vpn;                 
wire             rtu_mmu_expt_vld;                
wire             rtu_pad_halted;                  
wire             rtu_pad_retire;                  
wire    [39 :0]  rtu_pad_retire_pc;               
wire             rtu_yy_xx_dbgon;                 
wire             rtu_yy_xx_expt_int;              
wire    [4  :0]  rtu_yy_xx_expt_vec;              
wire             rtu_yy_xx_expt_vld;              
wire             sys_apb_clk;                     
wire             sys_apb_rst_b;                   
wire    [39 :0]  sysio_cp0_apb_base;              
wire             sysio_cpuio_me_int;              
wire             sysio_cpuio_ms_int;              
wire             sysio_cpuio_mt_int;              
wire             sysio_cpuio_se_int;              
wire             sysio_cpuio_ss_int;              
wire             sysio_cpuio_st_int;              
wire    [39 :0]  sysio_xx_rvba;                   
wire             tdt_dm_dtu_ack_havereset;        
wire             tdt_dm_dtu_async_halt_req;       
wire             tdt_dm_dtu_halt_on_reset;        
wire             tdt_dm_dtu_halt_req;             
wire    [31 :0]  tdt_dm_dtu_itr;                  
wire             tdt_dm_dtu_itr_vld;              
wire             tdt_dm_dtu_resume_req;           
wire    [63 :0]  tdt_dm_dtu_wdata;                
wire    [1  :0]  tdt_dm_dtu_wr_flg;               
wire             tdt_dm_dtu_wr_vld;               
wire    [7  :0]  vidu_dtu_debug_info;             
wire    [28 :0]  vpu_dtu_dbg_info;                



//==========================================================
//  Instance core module
//==========================================================
// &Instance("aq_core"); @37
aq_core  x_aq_core (
  .biu_cp0_coreid                (biu_cp0_coreid               ),
  .biu_cp0_me_int                (biu_cp0_me_int               ),
  .biu_cp0_ms_int                (biu_cp0_ms_int               ),
  .biu_cp0_mt_int                (biu_cp0_mt_int               ),
  .biu_cp0_rvba                  (biu_cp0_rvba                 ),
  .biu_cp0_se_int                (biu_cp0_se_int               ),
  .biu_cp0_ss_int                (biu_cp0_ss_int               ),
  .biu_cp0_st_int                (biu_cp0_st_int               ),
  .biu_ifu_arready               (biu_ifu_arready              ),
  .biu_ifu_rdata                 (biu_ifu_rdata                ),
  .biu_ifu_rid                   (biu_ifu_rid                  ),
  .biu_ifu_rlast                 (biu_ifu_rlast                ),
  .biu_ifu_rresp                 (biu_ifu_rresp                ),
  .biu_ifu_rvalid                (biu_ifu_rvalid               ),
  .biu_lsu_arready               (biu_lsu_arready              ),
  .biu_lsu_no_op                 (biu_lsu_no_op                ),
  .biu_lsu_rdata                 (biu_lsu_rdata                ),
  .biu_lsu_rid                   (biu_lsu_rid                  ),
  .biu_lsu_rlast                 (biu_lsu_rlast                ),
  .biu_lsu_rresp                 (biu_lsu_rresp                ),
  .biu_lsu_rvalid                (biu_lsu_rvalid               ),
  .biu_lsu_stb_awready           (biu_lsu_stb_awready          ),
  .biu_lsu_stb_wready            (biu_lsu_stb_wready           ),
  .biu_lsu_vb_awready            (biu_lsu_vb_awready           ),
  .biu_lsu_vb_wready             (biu_lsu_vb_wready            ),
  .cp0_biu_icg_en                (cp0_biu_icg_en               ),
  .cp0_biu_lpmd_b                (cp0_biu_lpmd_b               ),
  .cp0_dtu_addr                  (cp0_dtu_addr                 ),
  .cp0_dtu_debug_info            (cp0_dtu_debug_info           ),
  .cp0_dtu_icg_en                (cp0_dtu_icg_en               ),
  .cp0_dtu_mexpt_vld             (cp0_dtu_mexpt_vld            ),
  .cp0_dtu_pcfifo_frz            (cp0_dtu_pcfifo_frz           ),
  .cp0_dtu_rreg                  (cp0_dtu_rreg                 ),
  .cp0_dtu_satp                  (cp0_dtu_satp                 ),
  .cp0_dtu_wdata                 (cp0_dtu_wdata                ),
  .cp0_dtu_wreg                  (cp0_dtu_wreg                 ),
  .cp0_hpcp_icg_en               (cp0_hpcp_icg_en              ),
  .cp0_hpcp_index                (cp0_hpcp_index               ),
  .cp0_hpcp_int_off_vld          (cp0_hpcp_int_off_vld         ),
  .cp0_hpcp_mcntwen              (cp0_hpcp_mcntwen             ),
  .cp0_hpcp_pmdm                 (cp0_hpcp_pmdm                ),
  .cp0_hpcp_pmds                 (cp0_hpcp_pmds                ),
  .cp0_hpcp_pmdu                 (cp0_hpcp_pmdu                ),
  .cp0_hpcp_sync_stall_vld       (cp0_hpcp_sync_stall_vld      ),
  .cp0_hpcp_wdata                (cp0_hpcp_wdata               ),
  .cp0_hpcp_wreg                 (cp0_hpcp_wreg                ),
  .cp0_mmu_addr                  (cp0_mmu_addr                 ),
  .cp0_mmu_icg_en                (cp0_mmu_icg_en               ),
  .cp0_mmu_lpmd_req              (cp0_mmu_lpmd_req             ),
  .cp0_mmu_maee                  (cp0_mmu_maee                 ),
  .cp0_mmu_mxr                   (cp0_mmu_mxr                  ),
  .cp0_mmu_ptw_en                (cp0_mmu_ptw_en               ),
  .cp0_mmu_satp_data             (cp0_mmu_satp_data            ),
  .cp0_mmu_satp_wen              (cp0_mmu_satp_wen             ),
  .cp0_mmu_sum                   (cp0_mmu_sum                  ),
  .cp0_mmu_tlb_all_inv           (cp0_mmu_tlb_all_inv          ),
  .cp0_mmu_tlb_asid              (cp0_mmu_tlb_asid             ),
  .cp0_mmu_tlb_asid_all_inv      (cp0_mmu_tlb_asid_all_inv     ),
  .cp0_mmu_tlb_va                (cp0_mmu_tlb_va               ),
  .cp0_mmu_tlb_va_all_inv        (cp0_mmu_tlb_va_all_inv       ),
  .cp0_mmu_tlb_va_asid_inv       (cp0_mmu_tlb_va_asid_inv      ),
  .cp0_mmu_wdata                 (cp0_mmu_wdata                ),
  .cp0_mmu_wreg                  (cp0_mmu_wreg                 ),
  .cp0_pmp_addr                  (cp0_pmp_addr                 ),
  .cp0_pmp_icg_en                (cp0_pmp_icg_en               ),
  .cp0_pmp_wdata                 (cp0_pmp_wdata                ),
  .cp0_pmp_wreg                  (cp0_pmp_wreg                 ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .cp0_yy_priv_mode              (cp0_yy_priv_mode             ),
  .cpurst_b                      (cpurst_b                     ),
  .dtu_cp0_dcsr_mprven           (dtu_cp0_dcsr_mprven          ),
  .dtu_cp0_dcsr_prv              (dtu_cp0_dcsr_prv             ),
  .dtu_cp0_rdata                 (dtu_cp0_rdata                ),
  .dtu_cp0_wake_up               (dtu_cp0_wake_up              ),
  .dtu_ifu_debug_inst            (dtu_ifu_debug_inst           ),
  .dtu_ifu_debug_inst_vld        (dtu_ifu_debug_inst_vld       ),
  .dtu_ifu_halt_info0            (dtu_ifu_halt_info0           ),
  .dtu_ifu_halt_info1            (dtu_ifu_halt_info1           ),
  .dtu_ifu_halt_info_vld         (dtu_ifu_halt_info_vld        ),
  .dtu_ifu_halt_on_reset         (dtu_ifu_halt_on_reset        ),
  .dtu_lsu_addr_trig_en          (dtu_lsu_addr_trig_en         ),
  .dtu_lsu_data_trig_en          (dtu_lsu_data_trig_en         ),
  .dtu_lsu_halt_info             (dtu_lsu_halt_info            ),
  .dtu_lsu_halt_info_vld         (dtu_lsu_halt_info_vld        ),
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
  .hpcp_cp0_data                 (hpcp_cp0_data                ),
  .hpcp_cp0_int_vld              (hpcp_cp0_int_vld             ),
  .hpcp_cp0_sce                  (hpcp_cp0_sce                 ),
  .hpcp_idu_cnt_en               (hpcp_idu_cnt_en              ),
  .hpcp_ifu_cnt_en               (hpcp_ifu_cnt_en              ),
  .hpcp_iu_cnt_en                (hpcp_iu_cnt_en               ),
  .hpcp_lsu_cnt_en               (hpcp_lsu_cnt_en              ),
  .hpcp_rtu_cnt_en               (hpcp_rtu_cnt_en              ),
  .idu_dtu_debug_info            (idu_dtu_debug_info           ),
  .idu_hpcp_backend_stall        (idu_hpcp_backend_stall       ),
  .idu_hpcp_frontend_stall       (idu_hpcp_frontend_stall      ),
  .idu_hpcp_inst_type            (idu_hpcp_inst_type           ),
  .ifu_biu_araddr                (ifu_biu_araddr               ),
  .ifu_biu_arburst               (ifu_biu_arburst              ),
  .ifu_biu_arcache               (ifu_biu_arcache              ),
  .ifu_biu_arid                  (ifu_biu_arid                 ),
  .ifu_biu_arlen                 (ifu_biu_arlen                ),
  .ifu_biu_arprot                (ifu_biu_arprot               ),
  .ifu_biu_arsize                (ifu_biu_arsize               ),
  .ifu_biu_arvalid               (ifu_biu_arvalid              ),
  .ifu_dtu_addr_vld0             (ifu_dtu_addr_vld0            ),
  .ifu_dtu_addr_vld1             (ifu_dtu_addr_vld1            ),
  .ifu_dtu_data_vld0             (ifu_dtu_data_vld0            ),
  .ifu_dtu_data_vld1             (ifu_dtu_data_vld1            ),
  .ifu_dtu_debug_info            (ifu_dtu_debug_info           ),
  .ifu_dtu_exe_addr0             (ifu_dtu_exe_addr0            ),
  .ifu_dtu_exe_addr1             (ifu_dtu_exe_addr1            ),
  .ifu_dtu_exe_data0             (ifu_dtu_exe_data0            ),
  .ifu_dtu_exe_data1             (ifu_dtu_exe_data1            ),
  .ifu_hpcp_icache_access        (ifu_hpcp_icache_access       ),
  .ifu_hpcp_icache_miss          (ifu_hpcp_icache_miss         ),
  .ifu_mmu_abort                 (ifu_mmu_abort                ),
  .ifu_mmu_va                    (ifu_mmu_va                   ),
  .ifu_mmu_va_vld                (ifu_mmu_va_vld               ),
  .iu_dtu_debug_info             (iu_dtu_debug_info            ),
  .iu_hpcp_inst_bht_mispred      (iu_hpcp_inst_bht_mispred     ),
  .iu_hpcp_inst_condbr           (iu_hpcp_inst_condbr          ),
  .iu_hpcp_jump_8m               (iu_hpcp_jump_8m              ),
  .lsu_biu_araddr                (lsu_biu_araddr               ),
  .lsu_biu_arburst               (lsu_biu_arburst              ),
  .lsu_biu_arcache               (lsu_biu_arcache              ),
  .lsu_biu_arid                  (lsu_biu_arid                 ),
  .lsu_biu_arlen                 (lsu_biu_arlen                ),
  .lsu_biu_arprot                (lsu_biu_arprot               ),
  .lsu_biu_arsize                (lsu_biu_arsize               ),
  .lsu_biu_aruser                (lsu_biu_aruser               ),
  .lsu_biu_arvalid               (lsu_biu_arvalid              ),
  .lsu_biu_stb_awaddr            (lsu_biu_stb_awaddr           ),
  .lsu_biu_stb_awburst           (lsu_biu_stb_awburst          ),
  .lsu_biu_stb_awcache           (lsu_biu_stb_awcache          ),
  .lsu_biu_stb_awid              (lsu_biu_stb_awid             ),
  .lsu_biu_stb_awlen             (lsu_biu_stb_awlen            ),
  .lsu_biu_stb_awprot            (lsu_biu_stb_awprot           ),
  .lsu_biu_stb_awsize            (lsu_biu_stb_awsize           ),
  .lsu_biu_stb_awuser            (lsu_biu_stb_awuser           ),
  .lsu_biu_stb_awvalid           (lsu_biu_stb_awvalid          ),
  .lsu_biu_stb_wdata             (lsu_biu_stb_wdata            ),
  .lsu_biu_stb_wlast             (lsu_biu_stb_wlast            ),
  .lsu_biu_stb_wstrb             (lsu_biu_stb_wstrb            ),
  .lsu_biu_stb_wvalid            (lsu_biu_stb_wvalid           ),
  .lsu_biu_vb_awaddr             (lsu_biu_vb_awaddr            ),
  .lsu_biu_vb_awburst            (lsu_biu_vb_awburst           ),
  .lsu_biu_vb_awcache            (lsu_biu_vb_awcache           ),
  .lsu_biu_vb_awid               (lsu_biu_vb_awid              ),
  .lsu_biu_vb_awlen              (lsu_biu_vb_awlen             ),
  .lsu_biu_vb_awprot             (lsu_biu_vb_awprot            ),
  .lsu_biu_vb_awsize             (lsu_biu_vb_awsize            ),
  .lsu_biu_vb_awvalid            (lsu_biu_vb_awvalid           ),
  .lsu_biu_vb_wdata              (lsu_biu_vb_wdata             ),
  .lsu_biu_vb_wlast              (lsu_biu_vb_wlast             ),
  .lsu_biu_vb_wstrb              (lsu_biu_vb_wstrb             ),
  .lsu_biu_vb_wvalid             (lsu_biu_vb_wvalid            ),
  .lsu_dtu_debug_info            (lsu_dtu_debug_info           ),
  .lsu_dtu_halt_info             (lsu_dtu_halt_info            ),
  .lsu_dtu_last_check            (lsu_dtu_last_check           ),
  .lsu_dtu_ldst_addr             (lsu_dtu_ldst_addr            ),
  .lsu_dtu_ldst_addr_vld         (lsu_dtu_ldst_addr_vld        ),
  .lsu_dtu_ldst_bytes_vld        (lsu_dtu_ldst_bytes_vld       ),
  .lsu_dtu_ldst_data             (lsu_dtu_ldst_data            ),
  .lsu_dtu_ldst_data_vld         (lsu_dtu_ldst_data_vld        ),
  .lsu_dtu_ldst_type             (lsu_dtu_ldst_type            ),
  .lsu_dtu_mem_access_size       (lsu_dtu_mem_access_size      ),
  .lsu_hpcp_cache_read_access    (lsu_hpcp_cache_read_access   ),
  .lsu_hpcp_cache_read_miss      (lsu_hpcp_cache_read_miss     ),
  .lsu_hpcp_cache_write_access   (lsu_hpcp_cache_write_access  ),
  .lsu_hpcp_cache_write_miss     (lsu_hpcp_cache_write_miss    ),
  .lsu_hpcp_inst_store           (lsu_hpcp_inst_store          ),
  .lsu_hpcp_unalign_inst         (lsu_hpcp_unalign_inst        ),
  .lsu_mmu_abort                 (lsu_mmu_abort                ),
  .lsu_mmu_bus_error             (lsu_mmu_bus_error            ),
  .lsu_mmu_data                  (lsu_mmu_data                 ),
  .lsu_mmu_data_vld              (lsu_mmu_data_vld             ),
  .lsu_mmu_priv_mode             (lsu_mmu_priv_mode            ),
  .lsu_mmu_st_inst               (lsu_mmu_st_inst              ),
  .lsu_mmu_va                    (lsu_mmu_va                   ),
  .lsu_mmu_va_vld                (lsu_mmu_va_vld               ),
  .mmu_cp0_cmplt                 (mmu_cp0_cmplt                ),
  .mmu_cp0_data                  (mmu_cp0_data                 ),
  .mmu_cp0_tlb_inv_done          (mmu_cp0_tlb_inv_done         ),
  .mmu_ifu_access_fault          (mmu_ifu_access_fault         ),
  .mmu_ifu_pa                    (mmu_ifu_pa                   ),
  .mmu_ifu_pa_vld                (mmu_ifu_pa_vld               ),
  .mmu_ifu_prot                  (mmu_ifu_prot                 ),
  .mmu_lsu_access_fault          (mmu_lsu_access_fault         ),
  .mmu_lsu_buf                   (mmu_lsu_buf                  ),
  .mmu_lsu_ca                    (mmu_lsu_ca                   ),
  .mmu_lsu_data_req              (mmu_lsu_data_req             ),
  .mmu_lsu_data_req_addr         (mmu_lsu_data_req_addr        ),
  .mmu_lsu_data_req_size         (mmu_lsu_data_req_size        ),
  .mmu_lsu_pa                    (mmu_lsu_pa                   ),
  .mmu_lsu_pa_vld                (mmu_lsu_pa_vld               ),
  .mmu_lsu_page_fault            (mmu_lsu_page_fault           ),
  .mmu_lsu_sec                   (mmu_lsu_sec                  ),
  .mmu_lsu_sh                    (mmu_lsu_sh                   ),
  .mmu_lsu_so                    (mmu_lsu_so                   ),
  .mmu_xx_mmu_en                 (mmu_xx_mmu_en                ),
  .mmu_yy_xx_no_op               (mmu_yy_xx_no_op              ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .pad_yy_scan_mode              (pad_yy_scan_mode             ),
  .pmp_cp0_data                  (pmp_cp0_data                 ),
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
  .rtu_mmu_bad_vpn               (rtu_mmu_bad_vpn              ),
  .rtu_mmu_expt_vld              (rtu_mmu_expt_vld             ),
  .rtu_pad_halted                (rtu_pad_halted               ),
  .rtu_pad_retire                (rtu_pad_retire               ),
  .rtu_pad_retire_pc             (rtu_pad_retire_pc            ),
  .rtu_yy_xx_dbgon               (rtu_yy_xx_dbgon              ),
  .rtu_yy_xx_expt_int            (rtu_yy_xx_expt_int           ),
  .rtu_yy_xx_expt_vec            (rtu_yy_xx_expt_vec           ),
  .rtu_yy_xx_expt_vld            (rtu_yy_xx_expt_vld           ),
  .sysio_cp0_apb_base            (sysio_cp0_apb_base           ),
  .vidu_dtu_debug_info           (vidu_dtu_debug_info          ),
  .vpu_dtu_dbg_info              (vpu_dtu_dbg_info             )
);


//==========================================================
//  Instance aq_mmu_top sub module 
//==========================================================
// &Instance("aq_mmu_top"); @42
aq_mmu_top  x_aq_mmu_top (
  .cp0_mmu_addr             (cp0_mmu_addr            ),
  .cp0_mmu_icg_en           (cp0_mmu_icg_en          ),
  .cp0_mmu_lpmd_req         (cp0_mmu_lpmd_req        ),
  .cp0_mmu_maee             (cp0_mmu_maee            ),
  .cp0_mmu_mxr              (cp0_mmu_mxr             ),
  .cp0_mmu_ptw_en           (cp0_mmu_ptw_en          ),
  .cp0_mmu_satp_data        (cp0_mmu_satp_data       ),
  .cp0_mmu_satp_wen         (cp0_mmu_satp_wen        ),
  .cp0_mmu_sum              (cp0_mmu_sum             ),
  .cp0_mmu_tlb_all_inv      (cp0_mmu_tlb_all_inv     ),
  .cp0_mmu_tlb_asid         (cp0_mmu_tlb_asid        ),
  .cp0_mmu_tlb_asid_all_inv (cp0_mmu_tlb_asid_all_inv),
  .cp0_mmu_tlb_va           (cp0_mmu_tlb_va          ),
  .cp0_mmu_tlb_va_all_inv   (cp0_mmu_tlb_va_all_inv  ),
  .cp0_mmu_tlb_va_asid_inv  (cp0_mmu_tlb_va_asid_inv ),
  .cp0_mmu_wdata            (cp0_mmu_wdata           ),
  .cp0_mmu_wreg             (cp0_mmu_wreg            ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .hpcp_mmu_cnt_en          (hpcp_mmu_cnt_en         ),
  .ifu_mmu_abort            (ifu_mmu_abort           ),
  .ifu_mmu_va               (ifu_mmu_va              ),
  .ifu_mmu_va_vld           (ifu_mmu_va_vld          ),
  .lsu_mmu_abort            (lsu_mmu_abort           ),
  .lsu_mmu_bus_error        (lsu_mmu_bus_error       ),
  .lsu_mmu_data             (lsu_mmu_data            ),
  .lsu_mmu_data_vld         (lsu_mmu_data_vld        ),
  .lsu_mmu_priv_mode        (lsu_mmu_priv_mode       ),
  .lsu_mmu_st_inst          (lsu_mmu_st_inst         ),
  .lsu_mmu_va               (lsu_mmu_va              ),
  .lsu_mmu_va_vld           (lsu_mmu_va_vld          ),
  .mmu_cp0_cmplt            (mmu_cp0_cmplt           ),
  .mmu_cp0_data             (mmu_cp0_data            ),
  .mmu_cp0_tlb_inv_done     (mmu_cp0_tlb_inv_done    ),
  .mmu_dtu_debug_info       (mmu_dtu_debug_info      ),
  .mmu_hpcp_dutlb_miss      (mmu_hpcp_dutlb_miss     ),
  .mmu_hpcp_iutlb_miss      (mmu_hpcp_iutlb_miss     ),
  .mmu_hpcp_jtlb_miss       (mmu_hpcp_jtlb_miss      ),
  .mmu_ifu_access_fault     (mmu_ifu_access_fault    ),
  .mmu_ifu_pa               (mmu_ifu_pa              ),
  .mmu_ifu_pa_vld           (mmu_ifu_pa_vld          ),
  .mmu_ifu_prot             (mmu_ifu_prot            ),
  .mmu_lsu_access_fault     (mmu_lsu_access_fault    ),
  .mmu_lsu_buf              (mmu_lsu_buf             ),
  .mmu_lsu_ca               (mmu_lsu_ca              ),
  .mmu_lsu_data_req         (mmu_lsu_data_req        ),
  .mmu_lsu_data_req_addr    (mmu_lsu_data_req_addr   ),
  .mmu_lsu_data_req_size    (mmu_lsu_data_req_size   ),
  .mmu_lsu_pa               (mmu_lsu_pa              ),
  .mmu_lsu_pa_vld           (mmu_lsu_pa_vld          ),
  .mmu_lsu_page_fault       (mmu_lsu_page_fault      ),
  .mmu_lsu_sec              (mmu_lsu_sec             ),
  .mmu_lsu_sh               (mmu_lsu_sh              ),
  .mmu_lsu_so               (mmu_lsu_so              ),
  .mmu_pmp_chk1             (mmu_pmp_chk1            ),
  .mmu_pmp_pa               (mmu_pmp_pa              ),
  .mmu_pmp_priv_mode        (mmu_pmp_priv_mode       ),
  .mmu_xx_mmu_en            (mmu_xx_mmu_en           ),
  .mmu_yy_xx_no_op          (mmu_yy_xx_no_op         ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pmp_mmu_flg              (pmp_mmu_flg             ),
  .pmp_mmu_hit_num          (pmp_mmu_hit_num         ),
  .pmp_mmu_napot_cross      (pmp_mmu_napot_cross     ),
  .rtu_mmu_bad_vpn          (rtu_mmu_bad_vpn         ),
  .rtu_mmu_expt_vld         (rtu_mmu_expt_vld        )
);


//==========================================================
//  Instance aq_pmp_top sub module 
//==========================================================
// &Instance("aq_pmp_top"); @47
aq_pmp_top  x_aq_pmp_top (
  .cp0_pmp_addr        (cp0_pmp_addr       ),
  .cp0_pmp_icg_en      (cp0_pmp_icg_en     ),
  .cp0_pmp_wdata       (cp0_pmp_wdata      ),
  .cp0_pmp_wreg        (cp0_pmp_wreg       ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .mmu_pmp_chk1        (mmu_pmp_chk1       ),
  .mmu_pmp_pa          (mmu_pmp_pa         ),
  .mmu_pmp_priv_mode   (mmu_pmp_priv_mode  ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .pmp_cp0_data        (pmp_cp0_data       ),
  .pmp_mmu_flg         (pmp_mmu_flg        ),
  .pmp_mmu_hit_num     (pmp_mmu_hit_num    ),
  .pmp_mmu_napot_cross (pmp_mmu_napot_cross)
);


//==========================================================
//  Instance aq_pmp_top sub module 
//==========================================================
// &Instance("aq_cpuio_top"); @52
aq_cpuio_top  x_aq_cpuio_top (
  .biu_cp0_coreid     (biu_cp0_coreid    ),
  .biu_cp0_me_int     (biu_cp0_me_int    ),
  .biu_cp0_ms_int     (biu_cp0_ms_int    ),
  .biu_cp0_mt_int     (biu_cp0_mt_int    ),
  .biu_cp0_rvba       (biu_cp0_rvba      ),
  .biu_cp0_se_int     (biu_cp0_se_int    ),
  .biu_cp0_ss_int     (biu_cp0_ss_int    ),
  .biu_cp0_st_int     (biu_cp0_st_int    ),
  .biu_hpcp_time      (biu_hpcp_time     ),
  .clint_cpuio_time   (clint_cpuio_time  ),
  .cp0_biu_lpmd_b     (cp0_biu_lpmd_b    ),
  .cpuio_sysio_lpmd_b (cpuio_sysio_lpmd_b),
  .pad_biu_coreid     (pad_biu_coreid    ),
  .sysio_cpuio_me_int (sysio_cpuio_me_int),
  .sysio_cpuio_ms_int (sysio_cpuio_ms_int),
  .sysio_cpuio_mt_int (sysio_cpuio_mt_int),
  .sysio_cpuio_se_int (sysio_cpuio_se_int),
  .sysio_cpuio_ss_int (sysio_cpuio_ss_int),
  .sysio_cpuio_st_int (sysio_cpuio_st_int),
  .sysio_xx_rvba      (sysio_xx_rvba     )
);


//==========================================================
//  Instance aq_dtu_top sub module 
//==========================================================
// &Instance("aq_dtu_top"); @57
aq_dtu_top  x_aq_dtu_top (
  .cp0_dtu_addr                     (cp0_dtu_addr                    ),
  .cp0_dtu_debug_info               (cp0_dtu_debug_info              ),
  .cp0_dtu_icg_en                   (cp0_dtu_icg_en                  ),
  .cp0_dtu_mexpt_vld                (cp0_dtu_mexpt_vld               ),
  .cp0_dtu_pcfifo_frz               (cp0_dtu_pcfifo_frz              ),
  .cp0_dtu_rreg                     (cp0_dtu_rreg                    ),
  .cp0_dtu_satp                     (cp0_dtu_satp                    ),
  .cp0_dtu_wdata                    (cp0_dtu_wdata                   ),
  .cp0_dtu_wreg                     (cp0_dtu_wreg                    ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cp0_yy_priv_mode                 (cp0_yy_priv_mode                ),
  .cpurst_b                         (cpurst_b                        ),
  .dtu_cp0_dcsr_mprven              (dtu_cp0_dcsr_mprven             ),
  .dtu_cp0_dcsr_prv                 (dtu_cp0_dcsr_prv                ),
  .dtu_cp0_rdata                    (dtu_cp0_rdata                   ),
  .dtu_cp0_wake_up                  (dtu_cp0_wake_up                 ),
  .dtu_hpcp_dcsr_stopcount          (dtu_hpcp_dcsr_stopcount         ),
  .dtu_ifu_debug_inst               (dtu_ifu_debug_inst              ),
  .dtu_ifu_debug_inst_vld           (dtu_ifu_debug_inst_vld          ),
  .dtu_ifu_halt_info0               (dtu_ifu_halt_info0              ),
  .dtu_ifu_halt_info1               (dtu_ifu_halt_info1              ),
  .dtu_ifu_halt_info_vld            (dtu_ifu_halt_info_vld           ),
  .dtu_ifu_halt_on_reset            (dtu_ifu_halt_on_reset           ),
  .dtu_lsu_addr_trig_en             (dtu_lsu_addr_trig_en            ),
  .dtu_lsu_data_trig_en             (dtu_lsu_data_trig_en            ),
  .dtu_lsu_halt_info                (dtu_lsu_halt_info               ),
  .dtu_lsu_halt_info_vld            (dtu_lsu_halt_info_vld           ),
  .dtu_rtu_async_halt_req           (dtu_rtu_async_halt_req          ),
  .dtu_rtu_dpc                      (dtu_rtu_dpc                     ),
  .dtu_rtu_ebreak_action            (dtu_rtu_ebreak_action           ),
  .dtu_rtu_int_mask                 (dtu_rtu_int_mask                ),
  .dtu_rtu_pending_tval             (dtu_rtu_pending_tval            ),
  .dtu_rtu_resume_req               (dtu_rtu_resume_req              ),
  .dtu_rtu_step_en                  (dtu_rtu_step_en                 ),
  .dtu_rtu_sync_flush               (dtu_rtu_sync_flush              ),
  .dtu_rtu_sync_halt_req            (dtu_rtu_sync_halt_req           ),
  .dtu_tdt_dm_halted                (dtu_tdt_dm_halted               ),
  .dtu_tdt_dm_havereset             (dtu_tdt_dm_havereset            ),
  .dtu_tdt_dm_itr_done              (dtu_tdt_dm_itr_done             ),
  .dtu_tdt_dm_retire_debug_expt_vld (dtu_tdt_dm_retire_debug_expt_vld),
  .dtu_tdt_dm_rx_data               (dtu_tdt_dm_rx_data              ),
  .dtu_tdt_dm_wr_ready              (dtu_tdt_dm_wr_ready             ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .idu_dtu_debug_info               (idu_dtu_debug_info              ),
  .ifu_dtu_addr_vld0                (ifu_dtu_addr_vld0               ),
  .ifu_dtu_addr_vld1                (ifu_dtu_addr_vld1               ),
  .ifu_dtu_data_vld0                (ifu_dtu_data_vld0               ),
  .ifu_dtu_data_vld1                (ifu_dtu_data_vld1               ),
  .ifu_dtu_debug_info               (ifu_dtu_debug_info              ),
  .ifu_dtu_exe_addr0                (ifu_dtu_exe_addr0               ),
  .ifu_dtu_exe_addr1                (ifu_dtu_exe_addr1               ),
  .ifu_dtu_exe_data0                (ifu_dtu_exe_data0               ),
  .ifu_dtu_exe_data1                (ifu_dtu_exe_data1               ),
  .iu_dtu_debug_info                (iu_dtu_debug_info               ),
  .lsu_dtu_debug_info               (lsu_dtu_debug_info              ),
  .lsu_dtu_halt_info                (lsu_dtu_halt_info               ),
  .lsu_dtu_last_check               (lsu_dtu_last_check              ),
  .lsu_dtu_ldst_addr                (lsu_dtu_ldst_addr               ),
  .lsu_dtu_ldst_addr_vld            (lsu_dtu_ldst_addr_vld           ),
  .lsu_dtu_ldst_bytes_vld           (lsu_dtu_ldst_bytes_vld          ),
  .lsu_dtu_ldst_data                (lsu_dtu_ldst_data               ),
  .lsu_dtu_ldst_data_vld            (lsu_dtu_ldst_data_vld           ),
  .lsu_dtu_ldst_type                (lsu_dtu_ldst_type               ),
  .lsu_dtu_mem_access_size          (lsu_dtu_mem_access_size         ),
  .mmu_dtu_debug_info               (mmu_dtu_debug_info              ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_dtu_debug_info               (rtu_dtu_debug_info              ),
  .rtu_dtu_dpc                      (rtu_dtu_dpc                     ),
  .rtu_dtu_halt_ack                 (rtu_dtu_halt_ack                ),
  .rtu_dtu_pending_ack              (rtu_dtu_pending_ack             ),
  .rtu_dtu_retire_chgflw            (rtu_dtu_retire_chgflw           ),
  .rtu_dtu_retire_debug_expt_vld    (rtu_dtu_retire_debug_expt_vld   ),
  .rtu_dtu_retire_halt_info         (rtu_dtu_retire_halt_info        ),
  .rtu_dtu_retire_mret              (rtu_dtu_retire_mret             ),
  .rtu_dtu_retire_next_pc           (rtu_dtu_retire_next_pc          ),
  .rtu_dtu_retire_sret              (rtu_dtu_retire_sret             ),
  .rtu_dtu_retire_vld               (rtu_dtu_retire_vld              ),
  .rtu_dtu_tval                     (rtu_dtu_tval                    ),
  .rtu_yy_xx_dbgon                  (rtu_yy_xx_dbgon                 ),
  .rtu_yy_xx_expt_int               (rtu_yy_xx_expt_int              ),
  .rtu_yy_xx_expt_vec               (rtu_yy_xx_expt_vec              ),
  .rtu_yy_xx_expt_vld               (rtu_yy_xx_expt_vld              ),
  .sys_apb_clk                      (sys_apb_clk                     ),
  .sys_apb_rst_b                    (sys_apb_rst_b                   ),
  .tdt_dm_dtu_ack_havereset         (tdt_dm_dtu_ack_havereset        ),
  .tdt_dm_dtu_async_halt_req        (tdt_dm_dtu_async_halt_req       ),
  .tdt_dm_dtu_halt_on_reset         (tdt_dm_dtu_halt_on_reset        ),
  .tdt_dm_dtu_halt_req              (tdt_dm_dtu_halt_req             ),
  .tdt_dm_dtu_itr                   (tdt_dm_dtu_itr                  ),
  .tdt_dm_dtu_itr_vld               (tdt_dm_dtu_itr_vld              ),
  .tdt_dm_dtu_resume_req            (tdt_dm_dtu_resume_req           ),
  .tdt_dm_dtu_wdata                 (tdt_dm_dtu_wdata                ),
  .tdt_dm_dtu_wr_flg                (tdt_dm_dtu_wr_flg               ),
  .tdt_dm_dtu_wr_vld                (tdt_dm_dtu_wr_vld               ),
  .vidu_dtu_debug_info              (vidu_dtu_debug_info             ),
  .vpu_dtu_dbg_info                 (vpu_dtu_dbg_info                )
);


//==========================================================
//   Instance aq_hpcp_top
//==========================================================
// &Instance("aq_hpcp_top"); @63
aq_hpcp_top  x_aq_hpcp_top (
  .biu_hpcp_time               (biu_hpcp_time              ),
  .cp0_hpcp_icg_en             (cp0_hpcp_icg_en            ),
  .cp0_hpcp_index              (cp0_hpcp_index             ),
  .cp0_hpcp_int_off_vld        (cp0_hpcp_int_off_vld       ),
  .cp0_hpcp_mcntwen            (cp0_hpcp_mcntwen           ),
  .cp0_hpcp_pmdm               (cp0_hpcp_pmdm              ),
  .cp0_hpcp_pmds               (cp0_hpcp_pmds              ),
  .cp0_hpcp_pmdu               (cp0_hpcp_pmdu              ),
  .cp0_hpcp_sync_stall_vld     (cp0_hpcp_sync_stall_vld    ),
  .cp0_hpcp_wdata              (cp0_hpcp_wdata             ),
  .cp0_hpcp_wreg               (cp0_hpcp_wreg              ),
  .cp0_yy_priv_mode            (cp0_yy_priv_mode           ),
  .cpurst_b                    (cpurst_b                   ),
  .dtu_hpcp_dcsr_stopcount     (dtu_hpcp_dcsr_stopcount    ),
  .forever_cpuclk              (forever_cpuclk             ),
  .hpcp_cp0_data               (hpcp_cp0_data              ),
  .hpcp_cp0_int_vld            (hpcp_cp0_int_vld           ),
  .hpcp_cp0_sce                (hpcp_cp0_sce               ),
  .hpcp_idu_cnt_en             (hpcp_idu_cnt_en            ),
  .hpcp_ifu_cnt_en             (hpcp_ifu_cnt_en            ),
  .hpcp_iu_cnt_en              (hpcp_iu_cnt_en             ),
  .hpcp_lsu_cnt_en             (hpcp_lsu_cnt_en            ),
  .hpcp_mmu_cnt_en             (hpcp_mmu_cnt_en            ),
  .hpcp_rtu_cnt_en             (hpcp_rtu_cnt_en            ),
  .idu_hpcp_backend_stall      (idu_hpcp_backend_stall     ),
  .idu_hpcp_frontend_stall     (idu_hpcp_frontend_stall    ),
  .idu_hpcp_inst_type          (idu_hpcp_inst_type         ),
  .ifu_hpcp_icache_access      (ifu_hpcp_icache_access     ),
  .ifu_hpcp_icache_miss        (ifu_hpcp_icache_miss       ),
  .iu_hpcp_inst_bht_mispred    (iu_hpcp_inst_bht_mispred   ),
  .iu_hpcp_inst_condbr         (iu_hpcp_inst_condbr        ),
  .iu_hpcp_jump_8m             (iu_hpcp_jump_8m            ),
  .lsu_hpcp_cache_read_access  (lsu_hpcp_cache_read_access ),
  .lsu_hpcp_cache_read_miss    (lsu_hpcp_cache_read_miss   ),
  .lsu_hpcp_cache_write_access (lsu_hpcp_cache_write_access),
  .lsu_hpcp_cache_write_miss   (lsu_hpcp_cache_write_miss  ),
  .lsu_hpcp_inst_store         (lsu_hpcp_inst_store        ),
  .lsu_hpcp_unalign_inst       (lsu_hpcp_unalign_inst      ),
  .mmu_hpcp_dutlb_miss         (mmu_hpcp_dutlb_miss        ),
  .mmu_hpcp_iutlb_miss         (mmu_hpcp_iutlb_miss        ),
  .mmu_hpcp_jtlb_miss          (mmu_hpcp_jtlb_miss         ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_hpcp_int_vld            (rtu_hpcp_int_vld           ),
  .rtu_hpcp_retire_inst_vld    (rtu_hpcp_retire_inst_vld   ),
  .rtu_hpcp_retire_pc          (rtu_hpcp_retire_pc         ),
  .rtu_yy_xx_dbgon             (rtu_yy_xx_dbgon            )
);

// //&Force("output","hpcp_ciu_cnt_en"); @64

// &ModuleEnd; @67
endmodule



