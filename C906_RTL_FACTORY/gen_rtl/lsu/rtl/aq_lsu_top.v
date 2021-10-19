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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_top(
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
  cp0_yy_priv_mode,
  cpurst_b,
  da_xx_fwd_data,
  da_xx_fwd_dst_reg,
  da_xx_fwd_vld,
  dtu_lsu_addr_trig_en,
  dtu_lsu_data_trig_en,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  forever_cpuclk,
  hpcp_lsu_cnt_en,
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
  lsu_cp0_dcache_read_data,
  lsu_cp0_dcache_read_data_vld,
  lsu_cp0_fence_ack,
  lsu_cp0_icc_done,
  lsu_cp0_sync_ack,
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
  lsu_idu_full,
  lsu_idu_global_full,
  lsu_iu_ex2_data,
  lsu_iu_ex2_data_vld,
  lsu_iu_ex2_dest_reg,
  lsu_mmu_abort,
  lsu_mmu_bus_error,
  lsu_mmu_data,
  lsu_mmu_data_vld,
  lsu_mmu_priv_mode,
  lsu_mmu_st_inst,
  lsu_mmu_va,
  lsu_mmu_va_vld,
  lsu_rtu_async_expt_vld,
  lsu_rtu_async_ld_inst,
  lsu_rtu_async_tval,
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
  lsu_rtu_ex2_data,
  lsu_rtu_ex2_data_vld,
  lsu_rtu_ex2_dest_reg,
  lsu_rtu_ex2_tval2,
  lsu_rtu_no_op,
  lsu_rtu_wb_data,
  lsu_rtu_wb_dest_reg,
  lsu_rtu_wb_vld,
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
  pad_yy_icg_scan_en,
  rtu_lsu_async_expt_ack,
  rtu_lsu_expt_ack,
  rtu_lsu_expt_exit,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_flush,
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
  vlsu_xx_no_op
);

// &Ports; @21
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
input   [1  :0]  cp0_lsu_amr;                 
input            cp0_lsu_dcache_en;           
input   [1  :0]  cp0_lsu_dcache_pref_dist;    
input            cp0_lsu_dcache_pref_en;      
input   [16 :0]  cp0_lsu_dcache_read_idx;     
input            cp0_lsu_dcache_read_req;     
input            cp0_lsu_dcache_read_type;    
input   [1  :0]  cp0_lsu_dcache_read_way;     
input            cp0_lsu_dcache_wa;           
input            cp0_lsu_dcache_wb;           
input            cp0_lsu_fence_req;           
input   [63 :0]  cp0_lsu_icc_addr;            
input   [1  :0]  cp0_lsu_icc_op;              
input            cp0_lsu_icc_req;             
input   [1  :0]  cp0_lsu_icc_type;            
input            cp0_lsu_icg_en;              
input            cp0_lsu_mm;                  
input   [1  :0]  cp0_lsu_mpp;                 
input            cp0_lsu_mprv;                
input            cp0_lsu_sync_req;            
input            cp0_lsu_we_en;               
input   [1  :0]  cp0_yy_priv_mode;            
input            cpurst_b;                    
input            dtu_lsu_addr_trig_en;        
input            dtu_lsu_data_trig_en;        
input   [21 :0]  dtu_lsu_halt_info;           
input            dtu_lsu_halt_info_vld;       
input            forever_cpuclk;              
input            hpcp_lsu_cnt_en;             
input            idu_lsu_ex1_dp_sel;          
input   [5  :0]  idu_lsu_ex1_dst0_reg;        
input   [5  :0]  idu_lsu_ex1_dst1_reg;        
input   [19 :0]  idu_lsu_ex1_func;            
input            idu_lsu_ex1_gateclk_sel;     
input   [21 :0]  idu_lsu_ex1_halt_info;       
input            idu_lsu_ex1_length;          
input            idu_lsu_ex1_sel;             
input            idu_lsu_ex1_split;           
input   [63 :0]  idu_lsu_ex1_src0_data;       
input   [63 :0]  idu_lsu_ex1_src1_data;       
input   [63 :0]  idu_lsu_ex1_src2_data;       
input            idu_lsu_ex1_src2_ready;      
input   [5  :0]  idu_lsu_ex1_src2_reg;        
input   [1  :0]  idu_lsu_ex1_vlmul;           
input   [1  :0]  idu_lsu_ex1_vsew;            
input            ifu_lsu_warm_up;             
input   [15 :0]  iu_lsu_ex1_cur_pc;           
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
input            pad_yy_icg_scan_en;          
input            rtu_lsu_async_expt_ack;      
input            rtu_lsu_expt_ack;            
input            rtu_lsu_expt_exit;           
input            rtu_yy_xx_async_flush;       
input            rtu_yy_xx_dbgon;             
input            rtu_yy_xx_flush;             
input            vlsu_buf_stall;              
input   [63 :0]  vlsu_dtu_data;               
input            vlsu_dtu_data_vld;           
input            vlsu_dtu_data_vld_gate;      
input   [3  :0]  vlsu_lsu_data_shift;         
input            vlsu_lsu_data_vld;           
input   [63 :0]  vlsu_lsu_fwd_data;           
input   [4  :0]  vlsu_lsu_fwd_dest_reg;       
input            vlsu_lsu_fwd_vld;            
input            vlsu_lsu_src2_depd;          
input   [4  :0]  vlsu_lsu_src2_reg;           
input   [63 :0]  vlsu_lsu_wdata;              
input            vlsu_xx_no_op;               
output  [63 :0]  da_xx_fwd_data;              
output  [5  :0]  da_xx_fwd_dst_reg;           
output           da_xx_fwd_vld;               
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
output  [127:0]  lsu_cp0_dcache_read_data;    
output           lsu_cp0_dcache_read_data_vld; 
output           lsu_cp0_fence_ack;           
output           lsu_cp0_icc_done;            
output           lsu_cp0_sync_ack;            
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
output           lsu_idu_full;                
output           lsu_idu_global_full;         
output  [63 :0]  lsu_iu_ex2_data;             
output           lsu_iu_ex2_data_vld;         
output  [4  :0]  lsu_iu_ex2_dest_reg;         
output           lsu_mmu_abort;               
output           lsu_mmu_bus_error;           
output  [63 :0]  lsu_mmu_data;                
output           lsu_mmu_data_vld;            
output  [1  :0]  lsu_mmu_priv_mode;           
output           lsu_mmu_st_inst;             
output  [51 :0]  lsu_mmu_va;                  
output           lsu_mmu_va_vld;              
output           lsu_rtu_async_expt_vld;      
output           lsu_rtu_async_ld_inst;       
output  [39 :0]  lsu_rtu_async_tval;          
output           lsu_rtu_ex1_buffer_vld;      
output           lsu_rtu_ex1_cmplt;           
output           lsu_rtu_ex1_cmplt_dp;        
output           lsu_rtu_ex1_cmplt_for_pcgen; 
output  [63 :0]  lsu_rtu_ex1_data;            
output  [5  :0]  lsu_rtu_ex1_dest_reg;        
output  [39 :0]  lsu_rtu_ex1_expt_tval;       
output  [4  :0]  lsu_rtu_ex1_expt_vec;        
output           lsu_rtu_ex1_expt_vld;        
output           lsu_rtu_ex1_fs_dirty;        
output  [21 :0]  lsu_rtu_ex1_halt_info;       
output           lsu_rtu_ex1_inst_len;        
output           lsu_rtu_ex1_inst_split;      
output           lsu_rtu_ex1_tval2_vld;       
output           lsu_rtu_ex1_vs_dirty;        
output  [6  :0]  lsu_rtu_ex1_vstart;          
output           lsu_rtu_ex1_vstart_vld;      
output           lsu_rtu_ex1_wb_dp;           
output           lsu_rtu_ex1_wb_vld;          
output  [63 :0]  lsu_rtu_ex2_data;            
output           lsu_rtu_ex2_data_vld;        
output  [5  :0]  lsu_rtu_ex2_dest_reg;        
output  [39 :0]  lsu_rtu_ex2_tval2;           
output           lsu_rtu_no_op;               
output  [63 :0]  lsu_rtu_wb_data;             
output  [5  :0]  lsu_rtu_wb_dest_reg;         
output           lsu_rtu_wb_vld;              
output  [7  :0]  lsu_vlsu_bytes_vld;          
output  [63 :0]  lsu_vlsu_data;               
output           lsu_vlsu_data_grant;         
output           lsu_vlsu_data_vld;           
output           lsu_vlsu_dc_create_vld;      
output           lsu_vlsu_dc_fld_req;         
output           lsu_vlsu_dc_fof;             
output  [2  :0]  lsu_vlsu_dc_nf;              
output  [1  :0]  lsu_vlsu_dc_sew;             
output  [9  :0]  lsu_vlsu_dc_split_cnt;       
output           lsu_vlsu_dc_sseg_first;      
output           lsu_vlsu_dc_stall;           
output  [4  :0]  lsu_vlsu_dest_reg;           
output           lsu_vlsu_expt_vld;           
output  [19 :0]  lsu_vlsu_func;               
output  [1  :0]  lsu_vlsu_sew;                
output           lsu_vlsu_split_last;         
output           lsu_vlsu_st_expt;            
output  [3  :0]  lsu_vlsu_st_offset;          
output  [1  :0]  lsu_vlsu_st_sew;             
output  [1  :0]  lsu_vlsu_st_size;            
output           lsu_vlsu_vl_update;          
output  [6  :0]  lsu_vlsu_vl_upval;           

// &Regs; @22

// &Wires; @23
wire    [13 :0]  ag_arb_data_idx;             
wire             ag_arb_data_req;             
wire    [3  :0]  ag_arb_data_way;             
wire    [11 :0]  ag_arb_tag_idx;              
wire             ag_arb_tag_req;              
wire    [3  :0]  ag_arb_tag_sel;              
wire    [3  :0]  ag_arb_tag_way;              
wire    [7  :0]  ag_dbginfo;                  
wire    [39 :0]  ag_dc_addr;                  
wire    [4  :0]  ag_dc_amo_func;              
wire             ag_dc_buf;                   
wire    [7  :0]  ag_dc_bytes_vld;             
wire             ag_dc_ca;                    
wire    [3  :0]  ag_dc_data_shift;            
wire    [5  :0]  ag_dc_dest_reg;              
wire             ag_dc_expt_vld;              
wire    [19 :0]  ag_dc_func;                  
wire    [4  :0]  ag_dc_hint_size;             
wire    [15 :0]  ag_dc_inst_pc;               
wire             ag_dc_inst_vld;              
wire             ag_dc_inst_vld_dp;           
wire             ag_dc_inst_vld_gate;         
wire             ag_dc_pf_amr_mask;           
wire    [1  :0]  ag_dc_priv_mode;             
wire             ag_dc_sec;                   
wire    [1  :0]  ag_dc_sew;                   
wire             ag_dc_sh;                    
wire             ag_dc_so;                    
wire             ag_dc_src2_depd;             
wire    [5  :0]  ag_dc_src2_reg;              
wire    [63 :0]  ag_dc_st_data;               
wire             ag_dc_unalign;               
wire             ag_dc_unalign_last;          
wire             ag_dc_vec_nop;               
wire    [1  :0]  ag_dc_virt_idx;              
wire    [9  :0]  ag_dc_vlsu_split_cnt;        
wire             ag_dc_vlsu_split_last;       
wire             ag_dc_vlsu_sseg_first;       
wire             ag_dc_vlsu_vl_update;        
wire    [6  :0]  ag_dc_vlsu_vl_upval;         
wire    [3  :0]  ag_dc_vlsu_wdata_shift;      
wire    [39 :0]  ag_dtu_addr;                 
wire             ag_dtu_addr_ready;           
wire             ag_dtu_amo_type;             
wire    [15 :0]  ag_dtu_bytes_vld;            
wire    [63 :0]  ag_dtu_data;                 
wire             ag_dtu_data_chk_mask;        
wire             ag_dtu_data_vld;             
wire    [21 :0]  ag_dtu_halt_info;            
wire    [2  :0]  ag_dtu_mem_access_size;      
wire             ag_dtu_pipe_down;            
wire             ag_dtu_req;                  
wire             ag_dtu_req_gate;             
wire             ag_dtu_split_last;           
wire             ag_dtu_st_type;              
wire             ag_inst_store;               
wire             ag_xx_no_op;                 
wire    [1  :0]  amo_alu_stb_id;              
wire    [63 :0]  amo_alu_stb_rst;             
wire             amo_alu_stb_rst_vld;         
wire             amr_dc_wa_dis;               
wire             arb_ag_grant;                
wire             arb_dc_grant;                
wire             arb_mcic_grant;              
wire             arb_rdl_grant;               
wire             arb_stb_grant;               
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
wire    [1  :0]  cp0_yy_priv_mode;            
wire             cpurst_b;                    
wire    [4  :0]  da_amo_alu_func;             
wire    [1  :0]  da_amo_alu_size;             
wire    [63 :0]  da_amo_alu_src0;             
wire             da_amo_src_vld;              
wire    [1  :0]  da_amo_stb_id;               
wire    [63 :0]  da_dtu_data;                 
wire             da_dtu_data_vld;             
wire    [1  :0]  da_stb_amo_src_id;           
wire    [63 :0]  da_xx_fwd_data;              
wire    [5  :0]  da_xx_fwd_dst_reg;           
wire             da_xx_fwd_vld;               
wire             da_xx_no_op;                 
wire             dc_ag_stall;                 
wire             dc_amr_cancel;               
wire    [39 :0]  dc_amr_st_addr;              
wire             dc_amr_st_mask;              
wire             dc_amr_st_miss;              
wire             dc_amr_st_req;               
wire             dc_amr_st_req_gate;          
wire    [4  :0]  dc_amr_st_size;              
wire    [13 :0]  dc_arb_data_idx;             
wire             dc_arb_data_req;             
wire    [3  :0]  dc_arb_data_way;             
wire    [11 :0]  dc_arb_tag_idx;              
wire             dc_arb_tag_req;              
wire    [3  :0]  dc_arb_tag_sel;              
wire    [3  :0]  dc_arb_tag_way;              
wire    [9  :0]  dc_dbginfo;                  
wire    [127:0]  dc_icc_dcache_data;          
wire    [3  :0]  dc_icc_dcache_dirty;         
wire    [27 :0]  dc_icc_dcache_tag;           
wire             dc_icc_dcache_tagvld;        
wire             dc_lfb_alias_hit;            
wire    [1  :0]  dc_lfb_alias_idx;            
wire    [4  :0]  dc_lfb_amo_func;             
wire             dc_lfb_amo_inst;             
wire    [2  :0]  dc_lfb_attr;                 
wire    [7  :0]  dc_lfb_bytes_vld;            
wire             dc_lfb_ca;                   
wire             dc_lfb_create_en;            
wire             dc_lfb_create_en_gate;       
wire    [5  :0]  dc_lfb_dest_reg;             
wire    [1  :0]  dc_lfb_ele_size;             
wire             dc_lfb_fls;                  
wire    [3  :0]  dc_lfb_hit_way;              
wire             dc_lfb_inst_ld;              
wire             dc_lfb_lock;                 
wire    [39 :0]  dc_lfb_pa;                   
wire    [1  :0]  dc_lfb_priv_mode;            
wire             dc_lfb_ptw;                  
wire    [1  :0]  dc_lfb_sew;                  
wire    [3  :0]  dc_lfb_shift;                
wire             dc_lfb_sign_ext;             
wire    [1  :0]  dc_lfb_size;                 
wire             dc_lfb_split;                
wire             dc_lfb_split_last;           
wire    [1  :0]  dc_lfb_st_id;                
wire    [7  :0]  dc_lfb_vfunc;                
wire    [1  :0]  dc_lfb_virt_idx;             
wire    [6  :0]  dc_lfb_vl_val;               
wire             dc_lfb_vls;                  
wire             dc_lfb_vsplit_last;          
wire             dc_mcic_bus_err;             
wire    [63 :0]  dc_mcic_data;                
wire             dc_mcic_data_vld;            
wire             dc_pfb_dca_vld;              
wire             dc_pfb_hit_idx;              
wire    [39 :0]  dc_pfb_ld_chk_pa;            
wire    [1  :0]  dc_pfb_ld_chk_virt_idx;      
wire    [39 :0]  dc_pfb_ld_init_pa;           
wire    [1  :0]  dc_pfb_ld_init_virt_idx;     
wire             dc_pfb_ld_mask;              
wire             dc_pfb_ld_miss;              
wire    [15 :0]  dc_pfb_ld_pc;                
wire             dc_pfb_ld_vld;               
wire             dc_pfb_ld_vld_gate;          
wire    [1  :0]  dc_pfb_priv_mode;            
wire             dc_rdl_alias_hit;            
wire    [1  :0]  dc_rdl_alias_idx;            
wire    [3  :0]  dc_rdl_alias_way;            
wire             dc_rdl_cache_hit;            
wire    [127:0]  dc_rdl_dcache_data;          
wire    [3  :0]  dc_rdl_dcache_dirty;         
wire    [3  :0]  dc_rdl_dcache_fifo;          
wire    [27 :0]  dc_rdl_dcache_tag;           
wire             dc_rdl_dcache_vld;           
wire             dc_stb_alct;                 
wire    [1  :0]  dc_stb_alias_idx;            
wire             dc_stb_amo_inst;             
wire    [2  :0]  dc_stb_attr;                 
wire    [7  :0]  dc_stb_bytes_vld;            
wire             dc_stb_cache_hit;            
wire             dc_stb_clr_vld;              
wire    [63 :0]  dc_stb_data;                 
wire    [3  :0]  dc_stb_data_shift;           
wire             dc_stb_dca_inst;             
wire    [1  :0]  dc_stb_dca_type;             
wire    [3  :0]  dc_stb_hit_way;              
wire             dc_stb_lock;                 
wire    [39 :0]  dc_stb_pa;                   
wire    [1  :0]  dc_stb_priv_mode;            
wire             dc_stb_req;                  
wire             dc_stb_req_gate;             
wire    [1  :0]  dc_stb_size;                 
wire             dc_stb_src2_depd;            
wire    [4  :0]  dc_stb_src2_reg;             
wire    [1  :0]  dc_stb_virt_idx;             
wire             dc_stb_wait_lfb;             
wire    [7  :0]  dc_xx_bytes_vld;             
wire             dc_xx_dcache_req_mask;       
wire    [5  :0]  dc_xx_dest_preg;             
wire             dc_xx_no_op;                 
wire    [39 :0]  dc_xx_pa;                    
wire    [13 :0]  dcache_data02_idx;           
wire    [13 :0]  dcache_data13_idx;           
wire             dcache_data_cen_bank0;       
wire             dcache_data_cen_bank1;       
wire             dcache_data_cen_bank2;       
wire             dcache_data_cen_bank3;       
wire    [63 :0]  dcache_data_din_bank0;       
wire    [63 :0]  dcache_data_din_bank1;       
wire    [63 :0]  dcache_data_din_bank2;       
wire    [63 :0]  dcache_data_din_bank3;       
wire    [63 :0]  dcache_data_dout_bank0;      
wire    [63 :0]  dcache_data_dout_bank1;      
wire    [63 :0]  dcache_data_dout_bank2;      
wire    [63 :0]  dcache_data_dout_bank3;      
wire    [7  :0]  dcache_data_wen;             
wire             dcache_dirty_cen;            
wire    [7  :0]  dcache_dirty_din;            
wire    [7  :0]  dcache_dirty_dout;           
wire    [13 :0]  dcache_dirty_idx;            
wire    [7  :0]  dcache_dirty_wen;            
wire    [29 :0]  dcache_tag_din;              
wire    [119:0]  dcache_tag_dout_bank0;       
wire    [119:0]  dcache_tag_dout_bank1;       
wire    [11 :0]  dcache_tag_idx;              
wire             dcache_tag_req;              
wire    [3  :0]  dcache_tag_sel;              
wire    [3  :0]  dcache_tag_way;              
wire             dcache_tag_wen;              
wire             dtif_ag_cmplt_ready;         
wire             dtif_ag_fsm_idle;            
wire    [21 :0]  dtif_ag_halt_info;           
wire             dtif_ag_halt_info_up;        
wire             dtif_ag_pipedown_mask;       
wire             dtif_ag_stall;               
wire             dtif_ag_trig_en;             
wire             dtu_lsu_addr_trig_en;        
wire             dtu_lsu_data_trig_en;        
wire    [21 :0]  dtu_lsu_halt_info;           
wire             dtu_lsu_halt_info_vld;       
wire             forever_cpuclk;              
wire             hpcp_lsu_cnt_en;             
wire    [13 :0]  icc_arb_data02_idx;          
wire             icc_arb_data0_req;           
wire    [13 :0]  icc_arb_data13_idx;          
wire             icc_arb_data1_req;           
wire             icc_arb_data2_req;           
wire             icc_arb_data3_req;           
wire    [3  :0]  icc_arb_data_way;            
wire    [7  :0]  icc_arb_dirty_din;           
wire    [13 :0]  icc_arb_dirty_idx;           
wire             icc_arb_dirty_req;           
wire    [7  :0]  icc_arb_dirty_wen;           
wire    [11 :0]  icc_arb_tag_idx;             
wire             icc_arb_tag_req;             
wire    [3  :0]  icc_arb_tag_sel;             
wire    [3  :0]  icc_arb_tag_way;             
wire             icc_arb_tag_wen;             
wire    [3  :0]  icc_dc_acc_fifo;             
wire    [1  :0]  icc_dc_acc_idx;              
wire             icc_dc_sel;                  
wire    [33 :0]  icc_vb_addr;                 
wire    [127:0]  icc_vb_data;                 
wire             icc_vb_data_vld;             
wire             icc_vb_req;                  
wire             icc_xx_idle;                 
wire             icc_xx_sync_req;             
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
wire             ifu_lsu_warm_up;             
wire    [15 :0]  iu_lsu_ex1_cur_pc;           
wire    [13 :0]  lfb_arb_data02_idx;          
wire             lfb_arb_data0_req;           
wire    [13 :0]  lfb_arb_data13_idx;          
wire             lfb_arb_data1_req;           
wire             lfb_arb_data2_req;           
wire             lfb_arb_data3_req;           
wire    [127:0]  lfb_arb_data_din;            
wire    [3  :0]  lfb_arb_data_way;            
wire    [7  :0]  lfb_arb_data_wen;            
wire             lfb_arb_dcache_sel;          
wire    [7  :0]  lfb_arb_dirty_din;           
wire    [13 :0]  lfb_arb_dirty_idx;           
wire             lfb_arb_dirty_req;           
wire    [7  :0]  lfb_arb_dirty_wen;           
wire    [29 :0]  lfb_arb_tag_din;             
wire    [11 :0]  lfb_arb_tag_idx;             
wire             lfb_arb_tag_req;             
wire    [3  :0]  lfb_arb_tag_sel;             
wire    [3  :0]  lfb_arb_tag_way;             
wire             lfb_arb_tag_wen;             
wire    [55 :0]  lfb_dbginfo;                 
wire    [4  :0]  lfb_dc_amo_func;             
wire             lfb_dc_amo_inst;             
wire             lfb_dc_bus_err;              
wire    [7  :0]  lfb_dc_bytes_vld;            
wire    [63 :0]  lfb_dc_data;                 
wire    [3  :0]  lfb_dc_data_shift;           
wire             lfb_dc_data_vld;             
wire    [5  :0]  lfb_dc_dest_reg;             
wire    [1  :0]  lfb_dc_ele_size;             
wire             lfb_dc_fls;                  
wire             lfb_dc_full;                 
wire             lfb_dc_hit_addr;             
wire             lfb_dc_hit_idx;              
wire             lfb_dc_hit_preg;             
wire             lfb_dc_lock;                 
wire    [39 :0]  lfb_dc_mtval;                
wire             lfb_dc_pop_en;               
wire             lfb_dc_ptw;                  
wire    [1  :0]  lfb_dc_sew;                  
wire             lfb_dc_sign_ext;             
wire    [1  :0]  lfb_dc_size;                 
wire             lfb_dc_so_vld;               
wire             lfb_dc_split;                
wire             lfb_dc_split_first;          
wire             lfb_dc_split_second;         
wire    [1  :0]  lfb_dc_stb_id;               
wire             lfb_dc_uncmplt_vreg;         
wire    [7  :0]  lfb_dc_vfunc;                
wire             lfb_dc_vl_update;            
wire    [6  :0]  lfb_dc_vl_val;               
wire             lfb_dc_vls;                  
wire             lfb_dc_vsplit_last;          
wire    [4  :0]  lfb_pfb_cache_hit;           
wire    [4  :0]  lfb_pfb_cache_miss;          
wire             lfb_pfb_grant;               
wire             lfb_pfb_hit_idx;             
wire             lfb_rdl_alias_hit;           
wire    [1  :0]  lfb_rdl_alias_idx;           
wire             lfb_rdl_ca;                  
wire    [2  :0]  lfb_rdl_id;                  
wire    [13 :0]  lfb_rdl_idx;                 
wire             lfb_rdl_no_ld;               
wire             lfb_rdl_req;                 
wire    [27 :0]  lfb_rdl_tag;                 
wire    [1  :0]  lfb_rdl_type;                
wire    [3  :0]  lfb_rdl_way;                 
wire             lfb_stb_done;                
wire             lfb_stb_err;                 
wire    [3  :0]  lfb_stb_fifo;                
wire    [1  :0]  lfb_stb_id;                  
wire    [1  :0]  lfb_vb_araddr_5_4;           
wire    [2  :0]  lfb_vb_arid;                 
wire             lfb_vb_arvalid;              
wire             lfb_vb_rready;               
wire             lfb_xx_idle;                 
wire             lfb_xx_no_op;                
wire             lm_clr;                      
wire             lm_pass;                     
wire    [39 :0]  lm_req_addr;                 
wire    [1  :0]  lm_req_size;                 
wire             lm_set;                      
wire             lm_set_gate;                 
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
wire             lsu_no_op;                   
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
wire             mcic_ag_stall;               
wire    [13 :0]  mcic_arb_data_idx;           
wire             mcic_arb_data_req;           
wire    [3  :0]  mcic_arb_data_way;           
wire    [11 :0]  mcic_arb_tag_idx;            
wire             mcic_arb_tag_req;            
wire    [3  :0]  mcic_arb_tag_sel;            
wire    [3  :0]  mcic_arb_tag_way;            
wire    [39 :0]  mcic_dc_addr;                
wire    [7  :0]  mcic_dc_bytes_vld;           
wire    [1  :0]  mcic_dc_priv_mode;           
wire             mcic_dc_req;                 
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
wire             pad_yy_icg_scan_en;          
wire    [4  :0]  pfb_lfb_id;                  
wire    [39 :0]  pfb_lfb_pa;                  
wire    [1  :0]  pfb_lfb_priv_mode;           
wire             pfb_lfb_req;                 
wire             pfb_lfb_req_gate;            
wire    [1  :0]  pfb_lfb_virt_idx;            
wire             pfb_lfb_wb;                  
wire    [39 :0]  pfb_xx_pa;                   
wire    [13 :0]  rdl_arb_data02_idx;          
wire             rdl_arb_data0_req;           
wire    [13 :0]  rdl_arb_data13_idx;          
wire             rdl_arb_data1_req;           
wire             rdl_arb_data2_req;           
wire             rdl_arb_data3_req;           
wire    [3  :0]  rdl_arb_data_way;            
wire             rdl_arb_dcache_sel;          
wire    [7  :0]  rdl_arb_dirty_din;           
wire    [13 :0]  rdl_arb_dirty_idx;           
wire             rdl_arb_dirty_req;           
wire    [7  :0]  rdl_arb_dirty_wen;           
wire    [11 :0]  rdl_arb_tag_idx;             
wire             rdl_arb_tag_req;             
wire    [3  :0]  rdl_arb_tag_sel;             
wire    [3  :0]  rdl_arb_tag_way;             
wire             rdl_arb_tag_wen;             
wire    [3  :0]  rdl_dc_acc_fifo;             
wire    [1  :0]  rdl_dc_acc_idx;              
wire    [39 :0]  rdl_dc_acc_tag;              
wire             rdl_dc_sel;                  
wire             rdl_lfb_alias_hit;           
wire             rdl_lfb_cache_hit;           
wire             rdl_lfb_cmplt;               
wire             rdl_lfb_grant;               
wire    [3  :0]  rdl_lfb_ref_fifo;            
wire             rdl_stb_cmplt;               
wire    [1  :0]  rdl_stb_cmplt_id;            
wire             rdl_stb_grant;               
wire    [33 :0]  rdl_vb_addr;                 
wire             rdl_vb_alias;                
wire             rdl_vb_alias_dirty;          
wire    [127:0]  rdl_vb_data;                 
wire             rdl_vb_data_vld;             
wire             rdl_vb_ld;                   
wire    [2  :0]  rdl_vb_ld_id;                
wire             rdl_vb_pf;                   
wire             rdl_vb_req;                  
wire             rtu_lsu_async_expt_ack;      
wire             rtu_lsu_expt_ack;            
wire             rtu_lsu_expt_exit;           
wire             rtu_yy_xx_async_flush;       
wire             rtu_yy_xx_dbgon;             
wire             rtu_yy_xx_flush;             
wire    [63 :0]  stb_amo_alu_src1;            
wire             stb_arb_data0_req;           
wire             stb_arb_data1_req;           
wire             stb_arb_data2_req;           
wire             stb_arb_data3_req;           
wire    [127:0]  stb_arb_data_din;            
wire    [13 :0]  stb_arb_data_idx;            
wire             stb_arb_data_req;            
wire    [3  :0]  stb_arb_data_way;            
wire    [7  :0]  stb_arb_data_wen;            
wire    [13 :0]  stb_arb_dirty_idx;           
wire             stb_arb_dirty_req;           
wire    [7  :0]  stb_arb_dirty_wen;           
wire    [15 :0]  stb_dbginfo;                 
wire    [1  :0]  stb_dc_create_id;            
wire             stb_dc_fwd_vld;              
wire             stb_dc_hit_addr;             
wire             stb_dc_hit_addr_wca;         
wire             stb_dc_hit_dca;              
wire             stb_dc_hit_idx;              
wire             stb_dc_hit_not_ready;        
wire    [63 :0]  stb_dc_ld_data;              
wire             stb_dc_ld_fwd_vld;           
wire             stb_dc_merge_en;             
wire             stb_dc_multi_or_part_hit;    
wire             stb_dc_pop_en;               
wire             stb_dc_ready;                
wire             stb_dc_so_vld;               
wire             stb_pfb_hit_idx;             
wire    [1  :0]  stb_rdl_id;                  
wire    [13 :0]  stb_rdl_idx;                 
wire             stb_rdl_req;                 
wire    [27 :0]  stb_rdl_tag;                 
wire    [1  :0]  stb_rdl_type;                
wire    [3  :0]  stb_rdl_way;                 
wire             stb_xx_idle;                 
wire    [3  :0]  vb_dbginfo;                  
wire             vb_dc_hit_idx;               
wire             vb_dc_pop_en;                
wire             vb_icc_empty;                
wire             vb_icc_grant;                
wire             vb_lfb_arready;              
wire             vb_lfb_dirty;                
wire    [127:0]  vb_lfb_rdata;                
wire    [3  :0]  vb_lfb_rid;                  
wire             vb_lfb_rlast;                
wire             vb_lfb_rvalid;               
wire             vb_pfb_hit_idx;              
wire             vb_rdl_grant;                
wire             vb_rdl_ld_alias_hit;         
wire             vb_stb_clr_vld;              
wire             vb_xx_idle;                  
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
wire             vlsu_xx_no_op;               


// &Instance("aq_lsu_ag"); @25
aq_lsu_ag  x_aq_lsu_ag (
  .ag_arb_data_idx             (ag_arb_data_idx            ),
  .ag_arb_data_req             (ag_arb_data_req            ),
  .ag_arb_data_way             (ag_arb_data_way            ),
  .ag_arb_tag_idx              (ag_arb_tag_idx             ),
  .ag_arb_tag_req              (ag_arb_tag_req             ),
  .ag_arb_tag_sel              (ag_arb_tag_sel             ),
  .ag_arb_tag_way              (ag_arb_tag_way             ),
  .ag_dbginfo                  (ag_dbginfo                 ),
  .ag_dc_addr                  (ag_dc_addr                 ),
  .ag_dc_amo_func              (ag_dc_amo_func             ),
  .ag_dc_buf                   (ag_dc_buf                  ),
  .ag_dc_bytes_vld             (ag_dc_bytes_vld            ),
  .ag_dc_ca                    (ag_dc_ca                   ),
  .ag_dc_data_shift            (ag_dc_data_shift           ),
  .ag_dc_dest_reg              (ag_dc_dest_reg             ),
  .ag_dc_expt_vld              (ag_dc_expt_vld             ),
  .ag_dc_func                  (ag_dc_func                 ),
  .ag_dc_hint_size             (ag_dc_hint_size            ),
  .ag_dc_inst_pc               (ag_dc_inst_pc              ),
  .ag_dc_inst_vld              (ag_dc_inst_vld             ),
  .ag_dc_inst_vld_dp           (ag_dc_inst_vld_dp          ),
  .ag_dc_inst_vld_gate         (ag_dc_inst_vld_gate        ),
  .ag_dc_pf_amr_mask           (ag_dc_pf_amr_mask          ),
  .ag_dc_priv_mode             (ag_dc_priv_mode            ),
  .ag_dc_sec                   (ag_dc_sec                  ),
  .ag_dc_sew                   (ag_dc_sew                  ),
  .ag_dc_sh                    (ag_dc_sh                   ),
  .ag_dc_so                    (ag_dc_so                   ),
  .ag_dc_src2_depd             (ag_dc_src2_depd            ),
  .ag_dc_src2_reg              (ag_dc_src2_reg             ),
  .ag_dc_st_data               (ag_dc_st_data              ),
  .ag_dc_unalign               (ag_dc_unalign              ),
  .ag_dc_unalign_last          (ag_dc_unalign_last         ),
  .ag_dc_vec_nop               (ag_dc_vec_nop              ),
  .ag_dc_virt_idx              (ag_dc_virt_idx             ),
  .ag_dc_vlsu_split_cnt        (ag_dc_vlsu_split_cnt       ),
  .ag_dc_vlsu_split_last       (ag_dc_vlsu_split_last      ),
  .ag_dc_vlsu_sseg_first       (ag_dc_vlsu_sseg_first      ),
  .ag_dc_vlsu_vl_update        (ag_dc_vlsu_vl_update       ),
  .ag_dc_vlsu_vl_upval         (ag_dc_vlsu_vl_upval        ),
  .ag_dc_vlsu_wdata_shift      (ag_dc_vlsu_wdata_shift     ),
  .ag_dtu_addr                 (ag_dtu_addr                ),
  .ag_dtu_addr_ready           (ag_dtu_addr_ready          ),
  .ag_dtu_amo_type             (ag_dtu_amo_type            ),
  .ag_dtu_bytes_vld            (ag_dtu_bytes_vld           ),
  .ag_dtu_data                 (ag_dtu_data                ),
  .ag_dtu_data_chk_mask        (ag_dtu_data_chk_mask       ),
  .ag_dtu_data_vld             (ag_dtu_data_vld            ),
  .ag_dtu_halt_info            (ag_dtu_halt_info           ),
  .ag_dtu_mem_access_size      (ag_dtu_mem_access_size     ),
  .ag_dtu_pipe_down            (ag_dtu_pipe_down           ),
  .ag_dtu_req                  (ag_dtu_req                 ),
  .ag_dtu_req_gate             (ag_dtu_req_gate            ),
  .ag_dtu_split_last           (ag_dtu_split_last          ),
  .ag_dtu_st_type              (ag_dtu_st_type             ),
  .ag_inst_store               (ag_inst_store              ),
  .ag_xx_no_op                 (ag_xx_no_op                ),
  .arb_ag_grant                (arb_ag_grant               ),
  .cp0_lsu_icg_en              (cp0_lsu_icg_en             ),
  .cp0_lsu_mm                  (cp0_lsu_mm                 ),
  .cp0_lsu_mpp                 (cp0_lsu_mpp                ),
  .cp0_lsu_mprv                (cp0_lsu_mprv               ),
  .cp0_yy_priv_mode            (cp0_yy_priv_mode           ),
  .cpurst_b                    (cpurst_b                   ),
  .da_xx_fwd_data              (da_xx_fwd_data             ),
  .da_xx_fwd_dst_reg           (da_xx_fwd_dst_reg          ),
  .da_xx_fwd_vld               (da_xx_fwd_vld              ),
  .dc_ag_stall                 (dc_ag_stall                ),
  .dc_xx_dcache_req_mask       (dc_xx_dcache_req_mask      ),
  .dtif_ag_cmplt_ready         (dtif_ag_cmplt_ready        ),
  .dtif_ag_fsm_idle            (dtif_ag_fsm_idle           ),
  .dtif_ag_halt_info           (dtif_ag_halt_info          ),
  .dtif_ag_halt_info_up        (dtif_ag_halt_info_up       ),
  .dtif_ag_pipedown_mask       (dtif_ag_pipedown_mask      ),
  .dtif_ag_stall               (dtif_ag_stall              ),
  .dtif_ag_trig_en             (dtif_ag_trig_en            ),
  .forever_cpuclk              (forever_cpuclk             ),
  .idu_lsu_ex1_dp_sel          (idu_lsu_ex1_dp_sel         ),
  .idu_lsu_ex1_dst0_reg        (idu_lsu_ex1_dst0_reg       ),
  .idu_lsu_ex1_dst1_reg        (idu_lsu_ex1_dst1_reg       ),
  .idu_lsu_ex1_func            (idu_lsu_ex1_func           ),
  .idu_lsu_ex1_gateclk_sel     (idu_lsu_ex1_gateclk_sel    ),
  .idu_lsu_ex1_halt_info       (idu_lsu_ex1_halt_info      ),
  .idu_lsu_ex1_length          (idu_lsu_ex1_length         ),
  .idu_lsu_ex1_sel             (idu_lsu_ex1_sel            ),
  .idu_lsu_ex1_split           (idu_lsu_ex1_split          ),
  .idu_lsu_ex1_src0_data       (idu_lsu_ex1_src0_data      ),
  .idu_lsu_ex1_src1_data       (idu_lsu_ex1_src1_data      ),
  .idu_lsu_ex1_src2_data       (idu_lsu_ex1_src2_data      ),
  .idu_lsu_ex1_src2_ready      (idu_lsu_ex1_src2_ready     ),
  .idu_lsu_ex1_src2_reg        (idu_lsu_ex1_src2_reg       ),
  .idu_lsu_ex1_vlmul           (idu_lsu_ex1_vlmul          ),
  .idu_lsu_ex1_vsew            (idu_lsu_ex1_vsew           ),
  .ifu_lsu_warm_up             (ifu_lsu_warm_up            ),
  .iu_lsu_ex1_cur_pc           (iu_lsu_ex1_cur_pc          ),
  .lsu_idu_full                (lsu_idu_full               ),
  .lsu_idu_global_full         (lsu_idu_global_full        ),
  .lsu_mmu_abort               (lsu_mmu_abort              ),
  .lsu_mmu_priv_mode           (lsu_mmu_priv_mode          ),
  .lsu_mmu_st_inst             (lsu_mmu_st_inst            ),
  .lsu_mmu_va                  (lsu_mmu_va                 ),
  .lsu_mmu_va_vld              (lsu_mmu_va_vld             ),
  .lsu_rtu_ex1_buffer_vld      (lsu_rtu_ex1_buffer_vld     ),
  .lsu_rtu_ex1_cmplt           (lsu_rtu_ex1_cmplt          ),
  .lsu_rtu_ex1_cmplt_dp        (lsu_rtu_ex1_cmplt_dp       ),
  .lsu_rtu_ex1_cmplt_for_pcgen (lsu_rtu_ex1_cmplt_for_pcgen),
  .lsu_rtu_ex1_data            (lsu_rtu_ex1_data           ),
  .lsu_rtu_ex1_dest_reg        (lsu_rtu_ex1_dest_reg       ),
  .lsu_rtu_ex1_expt_tval       (lsu_rtu_ex1_expt_tval      ),
  .lsu_rtu_ex1_expt_vec        (lsu_rtu_ex1_expt_vec       ),
  .lsu_rtu_ex1_expt_vld        (lsu_rtu_ex1_expt_vld       ),
  .lsu_rtu_ex1_fs_dirty        (lsu_rtu_ex1_fs_dirty       ),
  .lsu_rtu_ex1_halt_info       (lsu_rtu_ex1_halt_info      ),
  .lsu_rtu_ex1_inst_len        (lsu_rtu_ex1_inst_len       ),
  .lsu_rtu_ex1_inst_split      (lsu_rtu_ex1_inst_split     ),
  .lsu_rtu_ex1_tval2_vld       (lsu_rtu_ex1_tval2_vld      ),
  .lsu_rtu_ex1_vs_dirty        (lsu_rtu_ex1_vs_dirty       ),
  .lsu_rtu_ex1_vstart          (lsu_rtu_ex1_vstart         ),
  .lsu_rtu_ex1_vstart_vld      (lsu_rtu_ex1_vstart_vld     ),
  .lsu_rtu_ex1_wb_dp           (lsu_rtu_ex1_wb_dp          ),
  .lsu_rtu_ex1_wb_vld          (lsu_rtu_ex1_wb_vld         ),
  .lsu_rtu_ex2_tval2           (lsu_rtu_ex2_tval2          ),
  .mcic_ag_stall               (mcic_ag_stall              ),
  .mmu_lsu_access_fault        (mmu_lsu_access_fault       ),
  .mmu_lsu_buf                 (mmu_lsu_buf                ),
  .mmu_lsu_ca                  (mmu_lsu_ca                 ),
  .mmu_lsu_pa                  (mmu_lsu_pa                 ),
  .mmu_lsu_pa_vld              (mmu_lsu_pa_vld             ),
  .mmu_lsu_page_fault          (mmu_lsu_page_fault         ),
  .mmu_lsu_sec                 (mmu_lsu_sec                ),
  .mmu_lsu_sh                  (mmu_lsu_sh                 ),
  .mmu_lsu_so                  (mmu_lsu_so                 ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_yy_xx_flush             (rtu_yy_xx_flush            )
);

// &Instance("aq_lsu_dc"); @26
aq_lsu_dc  x_aq_lsu_dc (
  .ag_dc_addr                  (ag_dc_addr                 ),
  .ag_dc_amo_func              (ag_dc_amo_func             ),
  .ag_dc_buf                   (ag_dc_buf                  ),
  .ag_dc_bytes_vld             (ag_dc_bytes_vld            ),
  .ag_dc_ca                    (ag_dc_ca                   ),
  .ag_dc_data_shift            (ag_dc_data_shift           ),
  .ag_dc_dest_reg              (ag_dc_dest_reg             ),
  .ag_dc_expt_vld              (ag_dc_expt_vld             ),
  .ag_dc_func                  (ag_dc_func                 ),
  .ag_dc_hint_size             (ag_dc_hint_size            ),
  .ag_dc_inst_pc               (ag_dc_inst_pc              ),
  .ag_dc_inst_vld              (ag_dc_inst_vld             ),
  .ag_dc_inst_vld_dp           (ag_dc_inst_vld_dp          ),
  .ag_dc_inst_vld_gate         (ag_dc_inst_vld_gate        ),
  .ag_dc_pf_amr_mask           (ag_dc_pf_amr_mask          ),
  .ag_dc_priv_mode             (ag_dc_priv_mode            ),
  .ag_dc_sec                   (ag_dc_sec                  ),
  .ag_dc_sew                   (ag_dc_sew                  ),
  .ag_dc_sh                    (ag_dc_sh                   ),
  .ag_dc_so                    (ag_dc_so                   ),
  .ag_dc_src2_depd             (ag_dc_src2_depd            ),
  .ag_dc_src2_reg              (ag_dc_src2_reg             ),
  .ag_dc_st_data               (ag_dc_st_data              ),
  .ag_dc_unalign               (ag_dc_unalign              ),
  .ag_dc_unalign_last          (ag_dc_unalign_last         ),
  .ag_dc_vec_nop               (ag_dc_vec_nop              ),
  .ag_dc_virt_idx              (ag_dc_virt_idx             ),
  .ag_dc_vlsu_split_cnt        (ag_dc_vlsu_split_cnt       ),
  .ag_dc_vlsu_split_last       (ag_dc_vlsu_split_last      ),
  .ag_dc_vlsu_sseg_first       (ag_dc_vlsu_sseg_first      ),
  .ag_dc_vlsu_vl_update        (ag_dc_vlsu_vl_update       ),
  .ag_dc_vlsu_vl_upval         (ag_dc_vlsu_vl_upval        ),
  .ag_dc_vlsu_wdata_shift      (ag_dc_vlsu_wdata_shift     ),
  .ag_inst_store               (ag_inst_store              ),
  .amr_dc_wa_dis               (amr_dc_wa_dis              ),
  .arb_dc_grant                (arb_dc_grant               ),
  .cp0_lsu_dcache_en           (cp0_lsu_dcache_en          ),
  .cp0_lsu_dcache_wa           (cp0_lsu_dcache_wa          ),
  .cp0_lsu_icg_en              (cp0_lsu_icg_en             ),
  .cpurst_b                    (cpurst_b                   ),
  .da_amo_alu_func             (da_amo_alu_func            ),
  .da_amo_alu_size             (da_amo_alu_size            ),
  .da_amo_alu_src0             (da_amo_alu_src0            ),
  .da_amo_src_vld              (da_amo_src_vld             ),
  .da_amo_stb_id               (da_amo_stb_id              ),
  .da_dtu_data                 (da_dtu_data                ),
  .da_dtu_data_vld             (da_dtu_data_vld            ),
  .da_stb_amo_src_id           (da_stb_amo_src_id          ),
  .da_xx_fwd_data              (da_xx_fwd_data             ),
  .da_xx_fwd_dst_reg           (da_xx_fwd_dst_reg          ),
  .da_xx_fwd_vld               (da_xx_fwd_vld              ),
  .da_xx_no_op                 (da_xx_no_op                ),
  .dc_ag_stall                 (dc_ag_stall                ),
  .dc_amr_cancel               (dc_amr_cancel              ),
  .dc_amr_st_addr              (dc_amr_st_addr             ),
  .dc_amr_st_mask              (dc_amr_st_mask             ),
  .dc_amr_st_miss              (dc_amr_st_miss             ),
  .dc_amr_st_req               (dc_amr_st_req              ),
  .dc_amr_st_req_gate          (dc_amr_st_req_gate         ),
  .dc_amr_st_size              (dc_amr_st_size             ),
  .dc_arb_data_idx             (dc_arb_data_idx            ),
  .dc_arb_data_req             (dc_arb_data_req            ),
  .dc_arb_data_way             (dc_arb_data_way            ),
  .dc_arb_tag_idx              (dc_arb_tag_idx             ),
  .dc_arb_tag_req              (dc_arb_tag_req             ),
  .dc_arb_tag_sel              (dc_arb_tag_sel             ),
  .dc_arb_tag_way              (dc_arb_tag_way             ),
  .dc_dbginfo                  (dc_dbginfo                 ),
  .dc_icc_dcache_data          (dc_icc_dcache_data         ),
  .dc_icc_dcache_dirty         (dc_icc_dcache_dirty        ),
  .dc_icc_dcache_tag           (dc_icc_dcache_tag          ),
  .dc_icc_dcache_tagvld        (dc_icc_dcache_tagvld       ),
  .dc_lfb_alias_hit            (dc_lfb_alias_hit           ),
  .dc_lfb_alias_idx            (dc_lfb_alias_idx           ),
  .dc_lfb_amo_func             (dc_lfb_amo_func            ),
  .dc_lfb_amo_inst             (dc_lfb_amo_inst            ),
  .dc_lfb_attr                 (dc_lfb_attr                ),
  .dc_lfb_bytes_vld            (dc_lfb_bytes_vld           ),
  .dc_lfb_ca                   (dc_lfb_ca                  ),
  .dc_lfb_create_en            (dc_lfb_create_en           ),
  .dc_lfb_create_en_gate       (dc_lfb_create_en_gate      ),
  .dc_lfb_dest_reg             (dc_lfb_dest_reg            ),
  .dc_lfb_ele_size             (dc_lfb_ele_size            ),
  .dc_lfb_fls                  (dc_lfb_fls                 ),
  .dc_lfb_hit_way              (dc_lfb_hit_way             ),
  .dc_lfb_inst_ld              (dc_lfb_inst_ld             ),
  .dc_lfb_lock                 (dc_lfb_lock                ),
  .dc_lfb_pa                   (dc_lfb_pa                  ),
  .dc_lfb_priv_mode            (dc_lfb_priv_mode           ),
  .dc_lfb_ptw                  (dc_lfb_ptw                 ),
  .dc_lfb_sew                  (dc_lfb_sew                 ),
  .dc_lfb_shift                (dc_lfb_shift               ),
  .dc_lfb_sign_ext             (dc_lfb_sign_ext            ),
  .dc_lfb_size                 (dc_lfb_size                ),
  .dc_lfb_split                (dc_lfb_split               ),
  .dc_lfb_split_last           (dc_lfb_split_last          ),
  .dc_lfb_st_id                (dc_lfb_st_id               ),
  .dc_lfb_vfunc                (dc_lfb_vfunc               ),
  .dc_lfb_virt_idx             (dc_lfb_virt_idx            ),
  .dc_lfb_vl_val               (dc_lfb_vl_val              ),
  .dc_lfb_vls                  (dc_lfb_vls                 ),
  .dc_lfb_vsplit_last          (dc_lfb_vsplit_last         ),
  .dc_mcic_bus_err             (dc_mcic_bus_err            ),
  .dc_mcic_data                (dc_mcic_data               ),
  .dc_mcic_data_vld            (dc_mcic_data_vld           ),
  .dc_pfb_dca_vld              (dc_pfb_dca_vld             ),
  .dc_pfb_hit_idx              (dc_pfb_hit_idx             ),
  .dc_pfb_ld_chk_pa            (dc_pfb_ld_chk_pa           ),
  .dc_pfb_ld_chk_virt_idx      (dc_pfb_ld_chk_virt_idx     ),
  .dc_pfb_ld_init_pa           (dc_pfb_ld_init_pa          ),
  .dc_pfb_ld_init_virt_idx     (dc_pfb_ld_init_virt_idx    ),
  .dc_pfb_ld_mask              (dc_pfb_ld_mask             ),
  .dc_pfb_ld_miss              (dc_pfb_ld_miss             ),
  .dc_pfb_ld_pc                (dc_pfb_ld_pc               ),
  .dc_pfb_ld_vld               (dc_pfb_ld_vld              ),
  .dc_pfb_ld_vld_gate          (dc_pfb_ld_vld_gate         ),
  .dc_pfb_priv_mode            (dc_pfb_priv_mode           ),
  .dc_rdl_alias_hit            (dc_rdl_alias_hit           ),
  .dc_rdl_alias_idx            (dc_rdl_alias_idx           ),
  .dc_rdl_alias_way            (dc_rdl_alias_way           ),
  .dc_rdl_cache_hit            (dc_rdl_cache_hit           ),
  .dc_rdl_dcache_data          (dc_rdl_dcache_data         ),
  .dc_rdl_dcache_dirty         (dc_rdl_dcache_dirty        ),
  .dc_rdl_dcache_fifo          (dc_rdl_dcache_fifo         ),
  .dc_rdl_dcache_tag           (dc_rdl_dcache_tag          ),
  .dc_rdl_dcache_vld           (dc_rdl_dcache_vld          ),
  .dc_stb_alct                 (dc_stb_alct                ),
  .dc_stb_alias_idx            (dc_stb_alias_idx           ),
  .dc_stb_amo_inst             (dc_stb_amo_inst            ),
  .dc_stb_attr                 (dc_stb_attr                ),
  .dc_stb_bytes_vld            (dc_stb_bytes_vld           ),
  .dc_stb_cache_hit            (dc_stb_cache_hit           ),
  .dc_stb_clr_vld              (dc_stb_clr_vld             ),
  .dc_stb_data                 (dc_stb_data                ),
  .dc_stb_data_shift           (dc_stb_data_shift          ),
  .dc_stb_dca_inst             (dc_stb_dca_inst            ),
  .dc_stb_dca_type             (dc_stb_dca_type            ),
  .dc_stb_hit_way              (dc_stb_hit_way             ),
  .dc_stb_lock                 (dc_stb_lock                ),
  .dc_stb_pa                   (dc_stb_pa                  ),
  .dc_stb_priv_mode            (dc_stb_priv_mode           ),
  .dc_stb_req                  (dc_stb_req                 ),
  .dc_stb_req_gate             (dc_stb_req_gate            ),
  .dc_stb_size                 (dc_stb_size                ),
  .dc_stb_src2_depd            (dc_stb_src2_depd           ),
  .dc_stb_src2_reg             (dc_stb_src2_reg            ),
  .dc_stb_virt_idx             (dc_stb_virt_idx            ),
  .dc_stb_wait_lfb             (dc_stb_wait_lfb            ),
  .dc_xx_bytes_vld             (dc_xx_bytes_vld            ),
  .dc_xx_dcache_req_mask       (dc_xx_dcache_req_mask      ),
  .dc_xx_dest_preg             (dc_xx_dest_preg            ),
  .dc_xx_no_op                 (dc_xx_no_op                ),
  .dc_xx_pa                    (dc_xx_pa                   ),
  .dcache_data_dout_bank0      (dcache_data_dout_bank0     ),
  .dcache_data_dout_bank1      (dcache_data_dout_bank1     ),
  .dcache_data_dout_bank2      (dcache_data_dout_bank2     ),
  .dcache_data_dout_bank3      (dcache_data_dout_bank3     ),
  .dcache_dirty_dout           (dcache_dirty_dout          ),
  .dcache_tag_dout_bank0       (dcache_tag_dout_bank0      ),
  .dcache_tag_dout_bank1       (dcache_tag_dout_bank1      ),
  .forever_cpuclk              (forever_cpuclk             ),
  .hpcp_lsu_cnt_en             (hpcp_lsu_cnt_en            ),
  .icc_dc_acc_fifo             (icc_dc_acc_fifo            ),
  .icc_dc_acc_idx              (icc_dc_acc_idx             ),
  .icc_dc_sel                  (icc_dc_sel                 ),
  .ifu_lsu_warm_up             (ifu_lsu_warm_up            ),
  .lfb_dc_amo_func             (lfb_dc_amo_func            ),
  .lfb_dc_amo_inst             (lfb_dc_amo_inst            ),
  .lfb_dc_bus_err              (lfb_dc_bus_err             ),
  .lfb_dc_bytes_vld            (lfb_dc_bytes_vld           ),
  .lfb_dc_data                 (lfb_dc_data                ),
  .lfb_dc_data_shift           (lfb_dc_data_shift          ),
  .lfb_dc_data_vld             (lfb_dc_data_vld            ),
  .lfb_dc_dest_reg             (lfb_dc_dest_reg            ),
  .lfb_dc_ele_size             (lfb_dc_ele_size            ),
  .lfb_dc_fls                  (lfb_dc_fls                 ),
  .lfb_dc_full                 (lfb_dc_full                ),
  .lfb_dc_hit_addr             (lfb_dc_hit_addr            ),
  .lfb_dc_hit_idx              (lfb_dc_hit_idx             ),
  .lfb_dc_hit_preg             (lfb_dc_hit_preg            ),
  .lfb_dc_lock                 (lfb_dc_lock                ),
  .lfb_dc_mtval                (lfb_dc_mtval               ),
  .lfb_dc_pop_en               (lfb_dc_pop_en              ),
  .lfb_dc_ptw                  (lfb_dc_ptw                 ),
  .lfb_dc_sew                  (lfb_dc_sew                 ),
  .lfb_dc_sign_ext             (lfb_dc_sign_ext            ),
  .lfb_dc_size                 (lfb_dc_size                ),
  .lfb_dc_so_vld               (lfb_dc_so_vld              ),
  .lfb_dc_split                (lfb_dc_split               ),
  .lfb_dc_split_first          (lfb_dc_split_first         ),
  .lfb_dc_split_second         (lfb_dc_split_second        ),
  .lfb_dc_stb_id               (lfb_dc_stb_id              ),
  .lfb_dc_uncmplt_vreg         (lfb_dc_uncmplt_vreg        ),
  .lfb_dc_vfunc                (lfb_dc_vfunc               ),
  .lfb_dc_vl_update            (lfb_dc_vl_update           ),
  .lfb_dc_vl_val               (lfb_dc_vl_val              ),
  .lfb_dc_vls                  (lfb_dc_vls                 ),
  .lfb_dc_vsplit_last          (lfb_dc_vsplit_last         ),
  .lm_clr                      (lm_clr                     ),
  .lm_pass                     (lm_pass                    ),
  .lm_req_addr                 (lm_req_addr                ),
  .lm_req_size                 (lm_req_size                ),
  .lm_set                      (lm_set                     ),
  .lm_set_gate                 (lm_set_gate                ),
  .lsu_hpcp_cache_read_access  (lsu_hpcp_cache_read_access ),
  .lsu_hpcp_cache_read_miss    (lsu_hpcp_cache_read_miss   ),
  .lsu_hpcp_cache_write_access (lsu_hpcp_cache_write_access),
  .lsu_hpcp_cache_write_miss   (lsu_hpcp_cache_write_miss  ),
  .lsu_hpcp_inst_store         (lsu_hpcp_inst_store        ),
  .lsu_hpcp_unalign_inst       (lsu_hpcp_unalign_inst      ),
  .lsu_iu_ex2_data             (lsu_iu_ex2_data            ),
  .lsu_iu_ex2_data_vld         (lsu_iu_ex2_data_vld        ),
  .lsu_iu_ex2_dest_reg         (lsu_iu_ex2_dest_reg        ),
  .lsu_rtu_async_expt_vld      (lsu_rtu_async_expt_vld     ),
  .lsu_rtu_async_ld_inst       (lsu_rtu_async_ld_inst      ),
  .lsu_rtu_async_tval          (lsu_rtu_async_tval         ),
  .lsu_rtu_ex2_data            (lsu_rtu_ex2_data           ),
  .lsu_rtu_ex2_data_vld        (lsu_rtu_ex2_data_vld       ),
  .lsu_rtu_ex2_dest_reg        (lsu_rtu_ex2_dest_reg       ),
  .lsu_rtu_wb_data             (lsu_rtu_wb_data            ),
  .lsu_rtu_wb_dest_reg         (lsu_rtu_wb_dest_reg        ),
  .lsu_rtu_wb_vld              (lsu_rtu_wb_vld             ),
  .lsu_vlsu_bytes_vld          (lsu_vlsu_bytes_vld         ),
  .lsu_vlsu_data               (lsu_vlsu_data              ),
  .lsu_vlsu_data_grant         (lsu_vlsu_data_grant        ),
  .lsu_vlsu_data_vld           (lsu_vlsu_data_vld          ),
  .lsu_vlsu_dc_create_vld      (lsu_vlsu_dc_create_vld     ),
  .lsu_vlsu_dc_fld_req         (lsu_vlsu_dc_fld_req        ),
  .lsu_vlsu_dc_fof             (lsu_vlsu_dc_fof            ),
  .lsu_vlsu_dc_nf              (lsu_vlsu_dc_nf             ),
  .lsu_vlsu_dc_sew             (lsu_vlsu_dc_sew            ),
  .lsu_vlsu_dc_split_cnt       (lsu_vlsu_dc_split_cnt      ),
  .lsu_vlsu_dc_sseg_first      (lsu_vlsu_dc_sseg_first     ),
  .lsu_vlsu_dc_stall           (lsu_vlsu_dc_stall          ),
  .lsu_vlsu_dest_reg           (lsu_vlsu_dest_reg          ),
  .lsu_vlsu_expt_vld           (lsu_vlsu_expt_vld          ),
  .lsu_vlsu_func               (lsu_vlsu_func              ),
  .lsu_vlsu_sew                (lsu_vlsu_sew               ),
  .lsu_vlsu_split_last         (lsu_vlsu_split_last        ),
  .lsu_vlsu_st_expt            (lsu_vlsu_st_expt           ),
  .lsu_vlsu_st_offset          (lsu_vlsu_st_offset         ),
  .lsu_vlsu_st_sew             (lsu_vlsu_st_sew            ),
  .lsu_vlsu_st_size            (lsu_vlsu_st_size           ),
  .lsu_vlsu_vl_update          (lsu_vlsu_vl_update         ),
  .lsu_vlsu_vl_upval           (lsu_vlsu_vl_upval          ),
  .mcic_dc_addr                (mcic_dc_addr               ),
  .mcic_dc_bytes_vld           (mcic_dc_bytes_vld          ),
  .mcic_dc_priv_mode           (mcic_dc_priv_mode          ),
  .mcic_dc_req                 (mcic_dc_req                ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .pfb_xx_pa                   (pfb_xx_pa                  ),
  .rdl_dc_acc_fifo             (rdl_dc_acc_fifo            ),
  .rdl_dc_acc_idx              (rdl_dc_acc_idx             ),
  .rdl_dc_acc_tag              (rdl_dc_acc_tag             ),
  .rdl_dc_sel                  (rdl_dc_sel                 ),
  .rtu_lsu_async_expt_ack      (rtu_lsu_async_expt_ack     ),
  .rtu_yy_xx_async_flush       (rtu_yy_xx_async_flush      ),
  .rtu_yy_xx_dbgon             (rtu_yy_xx_dbgon            ),
  .stb_dc_create_id            (stb_dc_create_id           ),
  .stb_dc_fwd_vld              (stb_dc_fwd_vld             ),
  .stb_dc_hit_addr             (stb_dc_hit_addr            ),
  .stb_dc_hit_addr_wca         (stb_dc_hit_addr_wca        ),
  .stb_dc_hit_dca              (stb_dc_hit_dca             ),
  .stb_dc_hit_idx              (stb_dc_hit_idx             ),
  .stb_dc_hit_not_ready        (stb_dc_hit_not_ready       ),
  .stb_dc_ld_data              (stb_dc_ld_data             ),
  .stb_dc_ld_fwd_vld           (stb_dc_ld_fwd_vld          ),
  .stb_dc_merge_en             (stb_dc_merge_en            ),
  .stb_dc_multi_or_part_hit    (stb_dc_multi_or_part_hit   ),
  .stb_dc_pop_en               (stb_dc_pop_en              ),
  .stb_dc_ready                (stb_dc_ready               ),
  .stb_dc_so_vld               (stb_dc_so_vld              ),
  .vb_dc_hit_idx               (vb_dc_hit_idx              ),
  .vb_dc_pop_en                (vb_dc_pop_en               ),
  .vlsu_buf_stall              (vlsu_buf_stall             ),
  .vlsu_lsu_data_shift         (vlsu_lsu_data_shift        ),
  .vlsu_lsu_data_vld           (vlsu_lsu_data_vld          ),
  .vlsu_lsu_fwd_data           (vlsu_lsu_fwd_data          ),
  .vlsu_lsu_fwd_dest_reg       (vlsu_lsu_fwd_dest_reg      ),
  .vlsu_lsu_fwd_vld            (vlsu_lsu_fwd_vld           ),
  .vlsu_lsu_src2_depd          (vlsu_lsu_src2_depd         ),
  .vlsu_lsu_src2_reg           (vlsu_lsu_src2_reg          ),
  .vlsu_lsu_wdata              (vlsu_lsu_wdata             )
);

// &Instance("aq_lsu_lfb"); @27
aq_lsu_lfb  x_aq_lsu_lfb (
  .biu_lsu_arready       (biu_lsu_arready      ),
  .biu_lsu_rdata         (biu_lsu_rdata        ),
  .biu_lsu_rid           (biu_lsu_rid          ),
  .biu_lsu_rlast         (biu_lsu_rlast        ),
  .biu_lsu_rresp         (biu_lsu_rresp        ),
  .biu_lsu_rvalid        (biu_lsu_rvalid       ),
  .cp0_lsu_dcache_wb     (cp0_lsu_dcache_wb    ),
  .cp0_lsu_icg_en        (cp0_lsu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .dc_lfb_alias_hit      (dc_lfb_alias_hit     ),
  .dc_lfb_alias_idx      (dc_lfb_alias_idx     ),
  .dc_lfb_amo_func       (dc_lfb_amo_func      ),
  .dc_lfb_amo_inst       (dc_lfb_amo_inst      ),
  .dc_lfb_attr           (dc_lfb_attr          ),
  .dc_lfb_bytes_vld      (dc_lfb_bytes_vld     ),
  .dc_lfb_ca             (dc_lfb_ca            ),
  .dc_lfb_create_en      (dc_lfb_create_en     ),
  .dc_lfb_create_en_gate (dc_lfb_create_en_gate),
  .dc_lfb_dest_reg       (dc_lfb_dest_reg      ),
  .dc_lfb_ele_size       (dc_lfb_ele_size      ),
  .dc_lfb_fls            (dc_lfb_fls           ),
  .dc_lfb_hit_way        (dc_lfb_hit_way       ),
  .dc_lfb_inst_ld        (dc_lfb_inst_ld       ),
  .dc_lfb_lock           (dc_lfb_lock          ),
  .dc_lfb_pa             (dc_lfb_pa            ),
  .dc_lfb_priv_mode      (dc_lfb_priv_mode     ),
  .dc_lfb_ptw            (dc_lfb_ptw           ),
  .dc_lfb_sew            (dc_lfb_sew           ),
  .dc_lfb_shift          (dc_lfb_shift         ),
  .dc_lfb_sign_ext       (dc_lfb_sign_ext      ),
  .dc_lfb_size           (dc_lfb_size          ),
  .dc_lfb_split          (dc_lfb_split         ),
  .dc_lfb_split_last     (dc_lfb_split_last    ),
  .dc_lfb_st_id          (dc_lfb_st_id         ),
  .dc_lfb_vfunc          (dc_lfb_vfunc         ),
  .dc_lfb_virt_idx       (dc_lfb_virt_idx      ),
  .dc_lfb_vl_val         (dc_lfb_vl_val        ),
  .dc_lfb_vls            (dc_lfb_vls           ),
  .dc_lfb_vsplit_last    (dc_lfb_vsplit_last   ),
  .dc_xx_dest_preg       (dc_xx_dest_preg      ),
  .dc_xx_pa              (dc_xx_pa             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .ifu_lsu_warm_up       (ifu_lsu_warm_up      ),
  .lfb_arb_data02_idx    (lfb_arb_data02_idx   ),
  .lfb_arb_data0_req     (lfb_arb_data0_req    ),
  .lfb_arb_data13_idx    (lfb_arb_data13_idx   ),
  .lfb_arb_data1_req     (lfb_arb_data1_req    ),
  .lfb_arb_data2_req     (lfb_arb_data2_req    ),
  .lfb_arb_data3_req     (lfb_arb_data3_req    ),
  .lfb_arb_data_din      (lfb_arb_data_din     ),
  .lfb_arb_data_way      (lfb_arb_data_way     ),
  .lfb_arb_data_wen      (lfb_arb_data_wen     ),
  .lfb_arb_dcache_sel    (lfb_arb_dcache_sel   ),
  .lfb_arb_dirty_din     (lfb_arb_dirty_din    ),
  .lfb_arb_dirty_idx     (lfb_arb_dirty_idx    ),
  .lfb_arb_dirty_req     (lfb_arb_dirty_req    ),
  .lfb_arb_dirty_wen     (lfb_arb_dirty_wen    ),
  .lfb_arb_tag_din       (lfb_arb_tag_din      ),
  .lfb_arb_tag_idx       (lfb_arb_tag_idx      ),
  .lfb_arb_tag_req       (lfb_arb_tag_req      ),
  .lfb_arb_tag_sel       (lfb_arb_tag_sel      ),
  .lfb_arb_tag_way       (lfb_arb_tag_way      ),
  .lfb_arb_tag_wen       (lfb_arb_tag_wen      ),
  .lfb_dbginfo           (lfb_dbginfo          ),
  .lfb_dc_amo_func       (lfb_dc_amo_func      ),
  .lfb_dc_amo_inst       (lfb_dc_amo_inst      ),
  .lfb_dc_bus_err        (lfb_dc_bus_err       ),
  .lfb_dc_bytes_vld      (lfb_dc_bytes_vld     ),
  .lfb_dc_data           (lfb_dc_data          ),
  .lfb_dc_data_shift     (lfb_dc_data_shift    ),
  .lfb_dc_data_vld       (lfb_dc_data_vld      ),
  .lfb_dc_dest_reg       (lfb_dc_dest_reg      ),
  .lfb_dc_ele_size       (lfb_dc_ele_size      ),
  .lfb_dc_fls            (lfb_dc_fls           ),
  .lfb_dc_full           (lfb_dc_full          ),
  .lfb_dc_hit_addr       (lfb_dc_hit_addr      ),
  .lfb_dc_hit_idx        (lfb_dc_hit_idx       ),
  .lfb_dc_hit_preg       (lfb_dc_hit_preg      ),
  .lfb_dc_lock           (lfb_dc_lock          ),
  .lfb_dc_mtval          (lfb_dc_mtval         ),
  .lfb_dc_pop_en         (lfb_dc_pop_en        ),
  .lfb_dc_ptw            (lfb_dc_ptw           ),
  .lfb_dc_sew            (lfb_dc_sew           ),
  .lfb_dc_sign_ext       (lfb_dc_sign_ext      ),
  .lfb_dc_size           (lfb_dc_size          ),
  .lfb_dc_so_vld         (lfb_dc_so_vld        ),
  .lfb_dc_split          (lfb_dc_split         ),
  .lfb_dc_split_first    (lfb_dc_split_first   ),
  .lfb_dc_split_second   (lfb_dc_split_second  ),
  .lfb_dc_stb_id         (lfb_dc_stb_id        ),
  .lfb_dc_uncmplt_vreg   (lfb_dc_uncmplt_vreg  ),
  .lfb_dc_vfunc          (lfb_dc_vfunc         ),
  .lfb_dc_vl_update      (lfb_dc_vl_update     ),
  .lfb_dc_vl_val         (lfb_dc_vl_val        ),
  .lfb_dc_vls            (lfb_dc_vls           ),
  .lfb_dc_vsplit_last    (lfb_dc_vsplit_last   ),
  .lfb_pfb_cache_hit     (lfb_pfb_cache_hit    ),
  .lfb_pfb_cache_miss    (lfb_pfb_cache_miss   ),
  .lfb_pfb_grant         (lfb_pfb_grant        ),
  .lfb_pfb_hit_idx       (lfb_pfb_hit_idx      ),
  .lfb_rdl_alias_hit     (lfb_rdl_alias_hit    ),
  .lfb_rdl_alias_idx     (lfb_rdl_alias_idx    ),
  .lfb_rdl_ca            (lfb_rdl_ca           ),
  .lfb_rdl_id            (lfb_rdl_id           ),
  .lfb_rdl_idx           (lfb_rdl_idx          ),
  .lfb_rdl_no_ld         (lfb_rdl_no_ld        ),
  .lfb_rdl_req           (lfb_rdl_req          ),
  .lfb_rdl_tag           (lfb_rdl_tag          ),
  .lfb_rdl_type          (lfb_rdl_type         ),
  .lfb_rdl_way           (lfb_rdl_way          ),
  .lfb_stb_done          (lfb_stb_done         ),
  .lfb_stb_err           (lfb_stb_err          ),
  .lfb_stb_fifo          (lfb_stb_fifo         ),
  .lfb_stb_id            (lfb_stb_id           ),
  .lfb_vb_araddr_5_4     (lfb_vb_araddr_5_4    ),
  .lfb_vb_arid           (lfb_vb_arid          ),
  .lfb_vb_arvalid        (lfb_vb_arvalid       ),
  .lfb_vb_rready         (lfb_vb_rready        ),
  .lfb_xx_idle           (lfb_xx_idle          ),
  .lfb_xx_no_op          (lfb_xx_no_op         ),
  .lsu_biu_araddr        (lsu_biu_araddr       ),
  .lsu_biu_arburst       (lsu_biu_arburst      ),
  .lsu_biu_arcache       (lsu_biu_arcache      ),
  .lsu_biu_arid          (lsu_biu_arid         ),
  .lsu_biu_arlen         (lsu_biu_arlen        ),
  .lsu_biu_arprot        (lsu_biu_arprot       ),
  .lsu_biu_arsize        (lsu_biu_arsize       ),
  .lsu_biu_aruser        (lsu_biu_aruser       ),
  .lsu_biu_arvalid       (lsu_biu_arvalid      ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .pfb_lfb_id            (pfb_lfb_id           ),
  .pfb_lfb_pa            (pfb_lfb_pa           ),
  .pfb_lfb_priv_mode     (pfb_lfb_priv_mode    ),
  .pfb_lfb_req           (pfb_lfb_req          ),
  .pfb_lfb_req_gate      (pfb_lfb_req_gate     ),
  .pfb_lfb_virt_idx      (pfb_lfb_virt_idx     ),
  .pfb_lfb_wb            (pfb_lfb_wb           ),
  .pfb_xx_pa             (pfb_xx_pa            ),
  .rdl_lfb_alias_hit     (rdl_lfb_alias_hit    ),
  .rdl_lfb_cache_hit     (rdl_lfb_cache_hit    ),
  .rdl_lfb_cmplt         (rdl_lfb_cmplt        ),
  .rdl_lfb_grant         (rdl_lfb_grant        ),
  .rdl_lfb_ref_fifo      (rdl_lfb_ref_fifo     ),
  .rtu_yy_xx_async_flush (rtu_yy_xx_async_flush),
  .vb_lfb_arready        (vb_lfb_arready       ),
  .vb_lfb_dirty          (vb_lfb_dirty         ),
  .vb_lfb_rdata          (vb_lfb_rdata         ),
  .vb_lfb_rid            (vb_lfb_rid           ),
  .vb_lfb_rlast          (vb_lfb_rlast         ),
  .vb_lfb_rvalid         (vb_lfb_rvalid        )
);

// &Instance("aq_lsu_stb"); @28
aq_lsu_stb  x_aq_lsu_stb (
  .amo_alu_stb_id           (amo_alu_stb_id          ),
  .amo_alu_stb_rst          (amo_alu_stb_rst         ),
  .amo_alu_stb_rst_vld      (amo_alu_stb_rst_vld     ),
  .arb_stb_grant            (arb_stb_grant           ),
  .biu_lsu_stb_awready      (biu_lsu_stb_awready     ),
  .biu_lsu_stb_wready       (biu_lsu_stb_wready      ),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_fence_req        (cp0_lsu_fence_req       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cp0_lsu_sync_req         (cp0_lsu_sync_req        ),
  .cpurst_b                 (cpurst_b                ),
  .da_stb_amo_src_id        (da_stb_amo_src_id       ),
  .dc_stb_alct              (dc_stb_alct             ),
  .dc_stb_alias_idx         (dc_stb_alias_idx        ),
  .dc_stb_amo_inst          (dc_stb_amo_inst         ),
  .dc_stb_attr              (dc_stb_attr             ),
  .dc_stb_bytes_vld         (dc_stb_bytes_vld        ),
  .dc_stb_cache_hit         (dc_stb_cache_hit        ),
  .dc_stb_clr_vld           (dc_stb_clr_vld          ),
  .dc_stb_data              (dc_stb_data             ),
  .dc_stb_data_shift        (dc_stb_data_shift       ),
  .dc_stb_dca_inst          (dc_stb_dca_inst         ),
  .dc_stb_dca_type          (dc_stb_dca_type         ),
  .dc_stb_hit_way           (dc_stb_hit_way          ),
  .dc_stb_lock              (dc_stb_lock             ),
  .dc_stb_pa                (dc_stb_pa               ),
  .dc_stb_priv_mode         (dc_stb_priv_mode        ),
  .dc_stb_req               (dc_stb_req              ),
  .dc_stb_req_gate          (dc_stb_req_gate         ),
  .dc_stb_size              (dc_stb_size             ),
  .dc_stb_src2_depd         (dc_stb_src2_depd        ),
  .dc_stb_src2_reg          (dc_stb_src2_reg         ),
  .dc_stb_virt_idx          (dc_stb_virt_idx         ),
  .dc_stb_wait_lfb          (dc_stb_wait_lfb         ),
  .dc_xx_bytes_vld          (dc_xx_bytes_vld         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .icc_xx_sync_req          (icc_xx_sync_req         ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_stb_done             (lfb_stb_done            ),
  .lfb_stb_err              (lfb_stb_err             ),
  .lfb_stb_fifo             (lfb_stb_fifo            ),
  .lfb_stb_id               (lfb_stb_id              ),
  .lsu_biu_stb_awaddr       (lsu_biu_stb_awaddr      ),
  .lsu_biu_stb_awburst      (lsu_biu_stb_awburst     ),
  .lsu_biu_stb_awcache      (lsu_biu_stb_awcache     ),
  .lsu_biu_stb_awid         (lsu_biu_stb_awid        ),
  .lsu_biu_stb_awlen        (lsu_biu_stb_awlen       ),
  .lsu_biu_stb_awprot       (lsu_biu_stb_awprot      ),
  .lsu_biu_stb_awsize       (lsu_biu_stb_awsize      ),
  .lsu_biu_stb_awuser       (lsu_biu_stb_awuser      ),
  .lsu_biu_stb_awvalid      (lsu_biu_stb_awvalid     ),
  .lsu_biu_stb_wdata        (lsu_biu_stb_wdata       ),
  .lsu_biu_stb_wlast        (lsu_biu_stb_wlast       ),
  .lsu_biu_stb_wstrb        (lsu_biu_stb_wstrb       ),
  .lsu_biu_stb_wvalid       (lsu_biu_stb_wvalid      ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_stb_cmplt            (rdl_stb_cmplt           ),
  .rdl_stb_cmplt_id         (rdl_stb_cmplt_id        ),
  .rdl_stb_grant            (rdl_stb_grant           ),
  .stb_amo_alu_src1         (stb_amo_alu_src1        ),
  .stb_arb_data0_req        (stb_arb_data0_req       ),
  .stb_arb_data1_req        (stb_arb_data1_req       ),
  .stb_arb_data2_req        (stb_arb_data2_req       ),
  .stb_arb_data3_req        (stb_arb_data3_req       ),
  .stb_arb_data_din         (stb_arb_data_din        ),
  .stb_arb_data_idx         (stb_arb_data_idx        ),
  .stb_arb_data_req         (stb_arb_data_req        ),
  .stb_arb_data_way         (stb_arb_data_way        ),
  .stb_arb_data_wen         (stb_arb_data_wen        ),
  .stb_arb_dirty_idx        (stb_arb_dirty_idx       ),
  .stb_arb_dirty_req        (stb_arb_dirty_req       ),
  .stb_arb_dirty_wen        (stb_arb_dirty_wen       ),
  .stb_dbginfo              (stb_dbginfo             ),
  .stb_dc_create_id         (stb_dc_create_id        ),
  .stb_dc_fwd_vld           (stb_dc_fwd_vld          ),
  .stb_dc_hit_addr          (stb_dc_hit_addr         ),
  .stb_dc_hit_addr_wca      (stb_dc_hit_addr_wca     ),
  .stb_dc_hit_dca           (stb_dc_hit_dca          ),
  .stb_dc_hit_idx           (stb_dc_hit_idx          ),
  .stb_dc_hit_not_ready     (stb_dc_hit_not_ready    ),
  .stb_dc_ld_data           (stb_dc_ld_data          ),
  .stb_dc_ld_fwd_vld        (stb_dc_ld_fwd_vld       ),
  .stb_dc_merge_en          (stb_dc_merge_en         ),
  .stb_dc_multi_or_part_hit (stb_dc_multi_or_part_hit),
  .stb_dc_pop_en            (stb_dc_pop_en           ),
  .stb_dc_ready             (stb_dc_ready            ),
  .stb_dc_so_vld            (stb_dc_so_vld           ),
  .stb_pfb_hit_idx          (stb_pfb_hit_idx         ),
  .stb_rdl_id               (stb_rdl_id              ),
  .stb_rdl_idx              (stb_rdl_idx             ),
  .stb_rdl_req              (stb_rdl_req             ),
  .stb_rdl_tag              (stb_rdl_tag             ),
  .stb_rdl_type             (stb_rdl_type            ),
  .stb_rdl_way              (stb_rdl_way             ),
  .stb_xx_idle              (stb_xx_idle             ),
  .vb_stb_clr_vld           (vb_stb_clr_vld          ),
  .vlsu_lsu_fwd_data        (vlsu_lsu_fwd_data       ),
  .vlsu_lsu_fwd_dest_reg    (vlsu_lsu_fwd_dest_reg   ),
  .vlsu_lsu_fwd_vld         (vlsu_lsu_fwd_vld        )
);

// &Instance("aq_lsu_rdl"); @29
aq_lsu_rdl  x_aq_lsu_rdl (
  .arb_rdl_grant       (arb_rdl_grant      ),
  .cp0_lsu_icg_en      (cp0_lsu_icg_en     ),
  .cp0_lsu_we_en       (cp0_lsu_we_en      ),
  .cpurst_b            (cpurst_b           ),
  .dc_rdl_alias_hit    (dc_rdl_alias_hit   ),
  .dc_rdl_alias_idx    (dc_rdl_alias_idx   ),
  .dc_rdl_alias_way    (dc_rdl_alias_way   ),
  .dc_rdl_cache_hit    (dc_rdl_cache_hit   ),
  .dc_rdl_dcache_data  (dc_rdl_dcache_data ),
  .dc_rdl_dcache_dirty (dc_rdl_dcache_dirty),
  .dc_rdl_dcache_fifo  (dc_rdl_dcache_fifo ),
  .dc_rdl_dcache_tag   (dc_rdl_dcache_tag  ),
  .dc_rdl_dcache_vld   (dc_rdl_dcache_vld  ),
  .forever_cpuclk      (forever_cpuclk     ),
  .ifu_lsu_warm_up     (ifu_lsu_warm_up    ),
  .lfb_rdl_alias_hit   (lfb_rdl_alias_hit  ),
  .lfb_rdl_alias_idx   (lfb_rdl_alias_idx  ),
  .lfb_rdl_ca          (lfb_rdl_ca         ),
  .lfb_rdl_id          (lfb_rdl_id         ),
  .lfb_rdl_idx         (lfb_rdl_idx        ),
  .lfb_rdl_no_ld       (lfb_rdl_no_ld      ),
  .lfb_rdl_req         (lfb_rdl_req        ),
  .lfb_rdl_tag         (lfb_rdl_tag        ),
  .lfb_rdl_type        (lfb_rdl_type       ),
  .lfb_rdl_way         (lfb_rdl_way        ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .rdl_arb_data02_idx  (rdl_arb_data02_idx ),
  .rdl_arb_data0_req   (rdl_arb_data0_req  ),
  .rdl_arb_data13_idx  (rdl_arb_data13_idx ),
  .rdl_arb_data1_req   (rdl_arb_data1_req  ),
  .rdl_arb_data2_req   (rdl_arb_data2_req  ),
  .rdl_arb_data3_req   (rdl_arb_data3_req  ),
  .rdl_arb_data_way    (rdl_arb_data_way   ),
  .rdl_arb_dcache_sel  (rdl_arb_dcache_sel ),
  .rdl_arb_dirty_din   (rdl_arb_dirty_din  ),
  .rdl_arb_dirty_idx   (rdl_arb_dirty_idx  ),
  .rdl_arb_dirty_req   (rdl_arb_dirty_req  ),
  .rdl_arb_dirty_wen   (rdl_arb_dirty_wen  ),
  .rdl_arb_tag_idx     (rdl_arb_tag_idx    ),
  .rdl_arb_tag_req     (rdl_arb_tag_req    ),
  .rdl_arb_tag_sel     (rdl_arb_tag_sel    ),
  .rdl_arb_tag_way     (rdl_arb_tag_way    ),
  .rdl_arb_tag_wen     (rdl_arb_tag_wen    ),
  .rdl_dc_acc_fifo     (rdl_dc_acc_fifo    ),
  .rdl_dc_acc_idx      (rdl_dc_acc_idx     ),
  .rdl_dc_acc_tag      (rdl_dc_acc_tag     ),
  .rdl_dc_sel          (rdl_dc_sel         ),
  .rdl_lfb_alias_hit   (rdl_lfb_alias_hit  ),
  .rdl_lfb_cache_hit   (rdl_lfb_cache_hit  ),
  .rdl_lfb_cmplt       (rdl_lfb_cmplt      ),
  .rdl_lfb_grant       (rdl_lfb_grant      ),
  .rdl_lfb_ref_fifo    (rdl_lfb_ref_fifo   ),
  .rdl_stb_cmplt       (rdl_stb_cmplt      ),
  .rdl_stb_cmplt_id    (rdl_stb_cmplt_id   ),
  .rdl_stb_grant       (rdl_stb_grant      ),
  .rdl_vb_addr         (rdl_vb_addr        ),
  .rdl_vb_alias        (rdl_vb_alias       ),
  .rdl_vb_alias_dirty  (rdl_vb_alias_dirty ),
  .rdl_vb_data         (rdl_vb_data        ),
  .rdl_vb_data_vld     (rdl_vb_data_vld    ),
  .rdl_vb_ld           (rdl_vb_ld          ),
  .rdl_vb_ld_id        (rdl_vb_ld_id       ),
  .rdl_vb_pf           (rdl_vb_pf          ),
  .rdl_vb_req          (rdl_vb_req         ),
  .stb_rdl_id          (stb_rdl_id         ),
  .stb_rdl_idx         (stb_rdl_idx        ),
  .stb_rdl_req         (stb_rdl_req        ),
  .stb_rdl_tag         (stb_rdl_tag        ),
  .stb_rdl_type        (stb_rdl_type       ),
  .stb_rdl_way         (stb_rdl_way        ),
  .vb_rdl_grant        (vb_rdl_grant       ),
  .vb_rdl_ld_alias_hit (vb_rdl_ld_alias_hit)
);

// &Instance("aq_lsu_icc"); @30
aq_lsu_icc  x_aq_lsu_icc (
  .cp0_lsu_dcache_read_idx      (cp0_lsu_dcache_read_idx     ),
  .cp0_lsu_dcache_read_req      (cp0_lsu_dcache_read_req     ),
  .cp0_lsu_dcache_read_type     (cp0_lsu_dcache_read_type    ),
  .cp0_lsu_dcache_read_way      (cp0_lsu_dcache_read_way     ),
  .cp0_lsu_icc_addr             (cp0_lsu_icc_addr            ),
  .cp0_lsu_icc_op               (cp0_lsu_icc_op              ),
  .cp0_lsu_icc_req              (cp0_lsu_icc_req             ),
  .cp0_lsu_icc_type             (cp0_lsu_icc_type            ),
  .cp0_lsu_icg_en               (cp0_lsu_icg_en              ),
  .cpurst_b                     (cpurst_b                    ),
  .dc_icc_dcache_data           (dc_icc_dcache_data          ),
  .dc_icc_dcache_dirty          (dc_icc_dcache_dirty         ),
  .dc_icc_dcache_tag            (dc_icc_dcache_tag           ),
  .dc_icc_dcache_tagvld         (dc_icc_dcache_tagvld        ),
  .forever_cpuclk               (forever_cpuclk              ),
  .icc_arb_data02_idx           (icc_arb_data02_idx          ),
  .icc_arb_data0_req            (icc_arb_data0_req           ),
  .icc_arb_data13_idx           (icc_arb_data13_idx          ),
  .icc_arb_data1_req            (icc_arb_data1_req           ),
  .icc_arb_data2_req            (icc_arb_data2_req           ),
  .icc_arb_data3_req            (icc_arb_data3_req           ),
  .icc_arb_data_way             (icc_arb_data_way            ),
  .icc_arb_dirty_din            (icc_arb_dirty_din           ),
  .icc_arb_dirty_idx            (icc_arb_dirty_idx           ),
  .icc_arb_dirty_req            (icc_arb_dirty_req           ),
  .icc_arb_dirty_wen            (icc_arb_dirty_wen           ),
  .icc_arb_tag_idx              (icc_arb_tag_idx             ),
  .icc_arb_tag_req              (icc_arb_tag_req             ),
  .icc_arb_tag_sel              (icc_arb_tag_sel             ),
  .icc_arb_tag_way              (icc_arb_tag_way             ),
  .icc_arb_tag_wen              (icc_arb_tag_wen             ),
  .icc_dc_acc_fifo              (icc_dc_acc_fifo             ),
  .icc_dc_acc_idx               (icc_dc_acc_idx              ),
  .icc_dc_sel                   (icc_dc_sel                  ),
  .icc_vb_addr                  (icc_vb_addr                 ),
  .icc_vb_data                  (icc_vb_data                 ),
  .icc_vb_data_vld              (icc_vb_data_vld             ),
  .icc_vb_req                   (icc_vb_req                  ),
  .icc_xx_idle                  (icc_xx_idle                 ),
  .icc_xx_sync_req              (icc_xx_sync_req             ),
  .ifu_lsu_warm_up              (ifu_lsu_warm_up             ),
  .lsu_cp0_dcache_read_data     (lsu_cp0_dcache_read_data    ),
  .lsu_cp0_dcache_read_data_vld (lsu_cp0_dcache_read_data_vld),
  .lsu_cp0_icc_done             (lsu_cp0_icc_done            ),
  .lsu_no_op                    (lsu_no_op                   ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .vb_icc_empty                 (vb_icc_empty                ),
  .vb_icc_grant                 (vb_icc_grant                ),
  .vb_xx_idle                   (vb_xx_idle                  )
);

// &Instance("aq_lsu_vb"); @31
aq_lsu_vb  x_aq_lsu_vb (
  .biu_lsu_no_op       (biu_lsu_no_op      ),
  .biu_lsu_vb_awready  (biu_lsu_vb_awready ),
  .biu_lsu_vb_wready   (biu_lsu_vb_wready  ),
  .cp0_lsu_icg_en      (cp0_lsu_icg_en     ),
  .cpurst_b            (cpurst_b           ),
  .dc_xx_pa            (dc_xx_pa           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .icc_vb_addr         (icc_vb_addr        ),
  .icc_vb_data         (icc_vb_data        ),
  .icc_vb_data_vld     (icc_vb_data_vld    ),
  .icc_vb_req          (icc_vb_req         ),
  .ifu_lsu_warm_up     (ifu_lsu_warm_up    ),
  .lfb_vb_araddr_5_4   (lfb_vb_araddr_5_4  ),
  .lfb_vb_arid         (lfb_vb_arid        ),
  .lfb_vb_arvalid      (lfb_vb_arvalid     ),
  .lfb_vb_rready       (lfb_vb_rready      ),
  .lsu_biu_vb_awaddr   (lsu_biu_vb_awaddr  ),
  .lsu_biu_vb_awburst  (lsu_biu_vb_awburst ),
  .lsu_biu_vb_awcache  (lsu_biu_vb_awcache ),
  .lsu_biu_vb_awid     (lsu_biu_vb_awid    ),
  .lsu_biu_vb_awlen    (lsu_biu_vb_awlen   ),
  .lsu_biu_vb_awprot   (lsu_biu_vb_awprot  ),
  .lsu_biu_vb_awsize   (lsu_biu_vb_awsize  ),
  .lsu_biu_vb_awvalid  (lsu_biu_vb_awvalid ),
  .lsu_biu_vb_wdata    (lsu_biu_vb_wdata   ),
  .lsu_biu_vb_wlast    (lsu_biu_vb_wlast   ),
  .lsu_biu_vb_wstrb    (lsu_biu_vb_wstrb   ),
  .lsu_biu_vb_wvalid   (lsu_biu_vb_wvalid  ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .pfb_xx_pa           (pfb_xx_pa          ),
  .rdl_vb_addr         (rdl_vb_addr        ),
  .rdl_vb_alias        (rdl_vb_alias       ),
  .rdl_vb_alias_dirty  (rdl_vb_alias_dirty ),
  .rdl_vb_data         (rdl_vb_data        ),
  .rdl_vb_data_vld     (rdl_vb_data_vld    ),
  .rdl_vb_ld           (rdl_vb_ld          ),
  .rdl_vb_ld_id        (rdl_vb_ld_id       ),
  .rdl_vb_pf           (rdl_vb_pf          ),
  .rdl_vb_req          (rdl_vb_req         ),
  .vb_dbginfo          (vb_dbginfo         ),
  .vb_dc_hit_idx       (vb_dc_hit_idx      ),
  .vb_dc_pop_en        (vb_dc_pop_en       ),
  .vb_icc_empty        (vb_icc_empty       ),
  .vb_icc_grant        (vb_icc_grant       ),
  .vb_lfb_arready      (vb_lfb_arready     ),
  .vb_lfb_dirty        (vb_lfb_dirty       ),
  .vb_lfb_rdata        (vb_lfb_rdata       ),
  .vb_lfb_rid          (vb_lfb_rid         ),
  .vb_lfb_rlast        (vb_lfb_rlast       ),
  .vb_lfb_rvalid       (vb_lfb_rvalid      ),
  .vb_pfb_hit_idx      (vb_pfb_hit_idx     ),
  .vb_rdl_grant        (vb_rdl_grant       ),
  .vb_rdl_ld_alias_hit (vb_rdl_ld_alias_hit),
  .vb_stb_clr_vld      (vb_stb_clr_vld     ),
  .vb_xx_idle          (vb_xx_idle         )
);

// &Instance("aq_dcache_top"); @32
aq_dcache_top  x_aq_dcache_top (
  .cp0_lsu_icg_en         (cp0_lsu_icg_en        ),
  .dcache_data02_idx      (dcache_data02_idx     ),
  .dcache_data13_idx      (dcache_data13_idx     ),
  .dcache_data_cen_bank0  (dcache_data_cen_bank0 ),
  .dcache_data_cen_bank1  (dcache_data_cen_bank1 ),
  .dcache_data_cen_bank2  (dcache_data_cen_bank2 ),
  .dcache_data_cen_bank3  (dcache_data_cen_bank3 ),
  .dcache_data_din_bank0  (dcache_data_din_bank0 ),
  .dcache_data_din_bank1  (dcache_data_din_bank1 ),
  .dcache_data_din_bank2  (dcache_data_din_bank2 ),
  .dcache_data_din_bank3  (dcache_data_din_bank3 ),
  .dcache_data_dout_bank0 (dcache_data_dout_bank0),
  .dcache_data_dout_bank1 (dcache_data_dout_bank1),
  .dcache_data_dout_bank2 (dcache_data_dout_bank2),
  .dcache_data_dout_bank3 (dcache_data_dout_bank3),
  .dcache_data_wen        (dcache_data_wen       ),
  .dcache_dirty_cen       (dcache_dirty_cen      ),
  .dcache_dirty_din       (dcache_dirty_din      ),
  .dcache_dirty_dout      (dcache_dirty_dout     ),
  .dcache_dirty_idx       (dcache_dirty_idx      ),
  .dcache_dirty_wen       (dcache_dirty_wen      ),
  .dcache_tag_din         (dcache_tag_din        ),
  .dcache_tag_dout_bank0  (dcache_tag_dout_bank0 ),
  .dcache_tag_dout_bank1  (dcache_tag_dout_bank1 ),
  .dcache_tag_idx         (dcache_tag_idx        ),
  .dcache_tag_req         (dcache_tag_req        ),
  .dcache_tag_sel         (dcache_tag_sel        ),
  .dcache_tag_way         (dcache_tag_way        ),
  .dcache_tag_wen         (dcache_tag_wen        ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    )
);

// &Instance("aq_lsu_pfb_top"); @33
aq_lsu_pfb_top  x_aq_lsu_pfb_top (
  .cp0_lsu_dcache_en        (cp0_lsu_dcache_en       ),
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_pref_en   (cp0_lsu_dcache_pref_en  ),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cp0_lsu_sync_req         (cp0_lsu_sync_req        ),
  .cpurst_b                 (cpurst_b                ),
  .dc_pfb_dca_vld           (dc_pfb_dca_vld          ),
  .dc_pfb_hit_idx           (dc_pfb_hit_idx          ),
  .dc_pfb_ld_chk_pa         (dc_pfb_ld_chk_pa        ),
  .dc_pfb_ld_chk_virt_idx   (dc_pfb_ld_chk_virt_idx  ),
  .dc_pfb_ld_init_pa        (dc_pfb_ld_init_pa       ),
  .dc_pfb_ld_init_virt_idx  (dc_pfb_ld_init_virt_idx ),
  .dc_pfb_ld_mask           (dc_pfb_ld_mask          ),
  .dc_pfb_ld_miss           (dc_pfb_ld_miss          ),
  .dc_pfb_ld_pc             (dc_pfb_ld_pc            ),
  .dc_pfb_ld_vld            (dc_pfb_ld_vld           ),
  .dc_pfb_ld_vld_gate       (dc_pfb_ld_vld_gate      ),
  .dc_pfb_priv_mode         (dc_pfb_priv_mode        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .icc_xx_sync_req          (icc_xx_sync_req         ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_pfb_cache_hit        (lfb_pfb_cache_hit       ),
  .lfb_pfb_cache_miss       (lfb_pfb_cache_miss      ),
  .lfb_pfb_grant            (lfb_pfb_grant           ),
  .lfb_pfb_hit_idx          (lfb_pfb_hit_idx         ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_lfb_id               (pfb_lfb_id              ),
  .pfb_lfb_pa               (pfb_lfb_pa              ),
  .pfb_lfb_priv_mode        (pfb_lfb_priv_mode       ),
  .pfb_lfb_req              (pfb_lfb_req             ),
  .pfb_lfb_req_gate         (pfb_lfb_req_gate        ),
  .pfb_lfb_virt_idx         (pfb_lfb_virt_idx        ),
  .pfb_lfb_wb               (pfb_lfb_wb              ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .stb_pfb_hit_idx          (stb_pfb_hit_idx         ),
  .vb_pfb_hit_idx           (vb_pfb_hit_idx          )
);

// &Instance("aq_lsu_amr"); @34
aq_lsu_amr  x_aq_lsu_amr (
  .amr_dc_wa_dis      (amr_dc_wa_dis     ),
  .cp0_lsu_amr        (cp0_lsu_amr       ),
  .cp0_lsu_dcache_en  (cp0_lsu_dcache_en ),
  .cp0_lsu_icg_en     (cp0_lsu_icg_en    ),
  .cp0_lsu_sync_req   (cp0_lsu_sync_req  ),
  .cpurst_b           (cpurst_b          ),
  .dc_amr_cancel      (dc_amr_cancel     ),
  .dc_amr_st_addr     (dc_amr_st_addr    ),
  .dc_amr_st_mask     (dc_amr_st_mask    ),
  .dc_amr_st_miss     (dc_amr_st_miss    ),
  .dc_amr_st_req      (dc_amr_st_req     ),
  .dc_amr_st_req_gate (dc_amr_st_req_gate),
  .dc_amr_st_size     (dc_amr_st_size    ),
  .forever_cpuclk     (forever_cpuclk    ),
  .ifu_lsu_warm_up    (ifu_lsu_warm_up   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &Instance("aq_lsu_arb"); @36
aq_lsu_arb  x_aq_lsu_arb (
  .ag_arb_data_idx       (ag_arb_data_idx      ),
  .ag_arb_data_req       (ag_arb_data_req      ),
  .ag_arb_data_way       (ag_arb_data_way      ),
  .ag_arb_tag_idx        (ag_arb_tag_idx       ),
  .ag_arb_tag_req        (ag_arb_tag_req       ),
  .ag_arb_tag_sel        (ag_arb_tag_sel       ),
  .ag_arb_tag_way        (ag_arb_tag_way       ),
  .arb_ag_grant          (arb_ag_grant         ),
  .arb_dc_grant          (arb_dc_grant         ),
  .arb_mcic_grant        (arb_mcic_grant       ),
  .arb_rdl_grant         (arb_rdl_grant        ),
  .arb_stb_grant         (arb_stb_grant        ),
  .dc_arb_data_idx       (dc_arb_data_idx      ),
  .dc_arb_data_req       (dc_arb_data_req      ),
  .dc_arb_data_way       (dc_arb_data_way      ),
  .dc_arb_tag_idx        (dc_arb_tag_idx       ),
  .dc_arb_tag_req        (dc_arb_tag_req       ),
  .dc_arb_tag_sel        (dc_arb_tag_sel       ),
  .dc_arb_tag_way        (dc_arb_tag_way       ),
  .dcache_data02_idx     (dcache_data02_idx    ),
  .dcache_data13_idx     (dcache_data13_idx    ),
  .dcache_data_cen_bank0 (dcache_data_cen_bank0),
  .dcache_data_cen_bank1 (dcache_data_cen_bank1),
  .dcache_data_cen_bank2 (dcache_data_cen_bank2),
  .dcache_data_cen_bank3 (dcache_data_cen_bank3),
  .dcache_data_din_bank0 (dcache_data_din_bank0),
  .dcache_data_din_bank1 (dcache_data_din_bank1),
  .dcache_data_din_bank2 (dcache_data_din_bank2),
  .dcache_data_din_bank3 (dcache_data_din_bank3),
  .dcache_data_wen       (dcache_data_wen      ),
  .dcache_dirty_cen      (dcache_dirty_cen     ),
  .dcache_dirty_din      (dcache_dirty_din     ),
  .dcache_dirty_idx      (dcache_dirty_idx     ),
  .dcache_dirty_wen      (dcache_dirty_wen     ),
  .dcache_tag_din        (dcache_tag_din       ),
  .dcache_tag_idx        (dcache_tag_idx       ),
  .dcache_tag_req        (dcache_tag_req       ),
  .dcache_tag_sel        (dcache_tag_sel       ),
  .dcache_tag_way        (dcache_tag_way       ),
  .dcache_tag_wen        (dcache_tag_wen       ),
  .icc_arb_data02_idx    (icc_arb_data02_idx   ),
  .icc_arb_data0_req     (icc_arb_data0_req    ),
  .icc_arb_data13_idx    (icc_arb_data13_idx   ),
  .icc_arb_data1_req     (icc_arb_data1_req    ),
  .icc_arb_data2_req     (icc_arb_data2_req    ),
  .icc_arb_data3_req     (icc_arb_data3_req    ),
  .icc_arb_data_way      (icc_arb_data_way     ),
  .icc_arb_dirty_din     (icc_arb_dirty_din    ),
  .icc_arb_dirty_idx     (icc_arb_dirty_idx    ),
  .icc_arb_dirty_req     (icc_arb_dirty_req    ),
  .icc_arb_dirty_wen     (icc_arb_dirty_wen    ),
  .icc_arb_tag_idx       (icc_arb_tag_idx      ),
  .icc_arb_tag_req       (icc_arb_tag_req      ),
  .icc_arb_tag_sel       (icc_arb_tag_sel      ),
  .icc_arb_tag_way       (icc_arb_tag_way      ),
  .icc_arb_tag_wen       (icc_arb_tag_wen      ),
  .lfb_arb_data02_idx    (lfb_arb_data02_idx   ),
  .lfb_arb_data0_req     (lfb_arb_data0_req    ),
  .lfb_arb_data13_idx    (lfb_arb_data13_idx   ),
  .lfb_arb_data1_req     (lfb_arb_data1_req    ),
  .lfb_arb_data2_req     (lfb_arb_data2_req    ),
  .lfb_arb_data3_req     (lfb_arb_data3_req    ),
  .lfb_arb_data_din      (lfb_arb_data_din     ),
  .lfb_arb_data_way      (lfb_arb_data_way     ),
  .lfb_arb_data_wen      (lfb_arb_data_wen     ),
  .lfb_arb_dcache_sel    (lfb_arb_dcache_sel   ),
  .lfb_arb_dirty_din     (lfb_arb_dirty_din    ),
  .lfb_arb_dirty_idx     (lfb_arb_dirty_idx    ),
  .lfb_arb_dirty_req     (lfb_arb_dirty_req    ),
  .lfb_arb_dirty_wen     (lfb_arb_dirty_wen    ),
  .lfb_arb_tag_din       (lfb_arb_tag_din      ),
  .lfb_arb_tag_idx       (lfb_arb_tag_idx      ),
  .lfb_arb_tag_req       (lfb_arb_tag_req      ),
  .lfb_arb_tag_sel       (lfb_arb_tag_sel      ),
  .lfb_arb_tag_way       (lfb_arb_tag_way      ),
  .lfb_arb_tag_wen       (lfb_arb_tag_wen      ),
  .mcic_arb_data_idx     (mcic_arb_data_idx    ),
  .mcic_arb_data_req     (mcic_arb_data_req    ),
  .mcic_arb_data_way     (mcic_arb_data_way    ),
  .mcic_arb_tag_idx      (mcic_arb_tag_idx     ),
  .mcic_arb_tag_req      (mcic_arb_tag_req     ),
  .mcic_arb_tag_sel      (mcic_arb_tag_sel     ),
  .mcic_arb_tag_way      (mcic_arb_tag_way     ),
  .rdl_arb_data02_idx    (rdl_arb_data02_idx   ),
  .rdl_arb_data0_req     (rdl_arb_data0_req    ),
  .rdl_arb_data13_idx    (rdl_arb_data13_idx   ),
  .rdl_arb_data1_req     (rdl_arb_data1_req    ),
  .rdl_arb_data2_req     (rdl_arb_data2_req    ),
  .rdl_arb_data3_req     (rdl_arb_data3_req    ),
  .rdl_arb_data_way      (rdl_arb_data_way     ),
  .rdl_arb_dcache_sel    (rdl_arb_dcache_sel   ),
  .rdl_arb_dirty_din     (rdl_arb_dirty_din    ),
  .rdl_arb_dirty_idx     (rdl_arb_dirty_idx    ),
  .rdl_arb_dirty_req     (rdl_arb_dirty_req    ),
  .rdl_arb_dirty_wen     (rdl_arb_dirty_wen    ),
  .rdl_arb_tag_idx       (rdl_arb_tag_idx      ),
  .rdl_arb_tag_req       (rdl_arb_tag_req      ),
  .rdl_arb_tag_sel       (rdl_arb_tag_sel      ),
  .rdl_arb_tag_way       (rdl_arb_tag_way      ),
  .rdl_arb_tag_wen       (rdl_arb_tag_wen      ),
  .stb_arb_data0_req     (stb_arb_data0_req    ),
  .stb_arb_data1_req     (stb_arb_data1_req    ),
  .stb_arb_data2_req     (stb_arb_data2_req    ),
  .stb_arb_data3_req     (stb_arb_data3_req    ),
  .stb_arb_data_din      (stb_arb_data_din     ),
  .stb_arb_data_idx      (stb_arb_data_idx     ),
  .stb_arb_data_req      (stb_arb_data_req     ),
  .stb_arb_data_way      (stb_arb_data_way     ),
  .stb_arb_data_wen      (stb_arb_data_wen     ),
  .stb_arb_dirty_idx     (stb_arb_dirty_idx    ),
  .stb_arb_dirty_req     (stb_arb_dirty_req    ),
  .stb_arb_dirty_wen     (stb_arb_dirty_wen    )
);

// &Instance("aq_lsu_mcic"); @37
aq_lsu_mcic  x_aq_lsu_mcic (
  .arb_mcic_grant        (arb_mcic_grant       ),
  .cp0_lsu_icg_en        (cp0_lsu_icg_en       ),
  .cp0_lsu_mpp           (cp0_lsu_mpp          ),
  .cp0_lsu_mprv          (cp0_lsu_mprv         ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .dc_ag_stall           (dc_ag_stall          ),
  .dc_mcic_bus_err       (dc_mcic_bus_err      ),
  .dc_mcic_data          (dc_mcic_data         ),
  .dc_mcic_data_vld      (dc_mcic_data_vld     ),
  .dc_xx_dcache_req_mask (dc_xx_dcache_req_mask),
  .forever_cpuclk        (forever_cpuclk       ),
  .icc_xx_idle           (icc_xx_idle          ),
  .lsu_mmu_bus_error     (lsu_mmu_bus_error    ),
  .lsu_mmu_data          (lsu_mmu_data         ),
  .lsu_mmu_data_vld      (lsu_mmu_data_vld     ),
  .mcic_ag_stall         (mcic_ag_stall        ),
  .mcic_arb_data_idx     (mcic_arb_data_idx    ),
  .mcic_arb_data_req     (mcic_arb_data_req    ),
  .mcic_arb_data_way     (mcic_arb_data_way    ),
  .mcic_arb_tag_idx      (mcic_arb_tag_idx     ),
  .mcic_arb_tag_req      (mcic_arb_tag_req     ),
  .mcic_arb_tag_sel      (mcic_arb_tag_sel     ),
  .mcic_arb_tag_way      (mcic_arb_tag_way     ),
  .mcic_dc_addr          (mcic_dc_addr         ),
  .mcic_dc_bytes_vld     (mcic_dc_bytes_vld    ),
  .mcic_dc_priv_mode     (mcic_dc_priv_mode    ),
  .mcic_dc_req           (mcic_dc_req          ),
  .mmu_lsu_data_req      (mmu_lsu_data_req     ),
  .mmu_lsu_data_req_addr (mmu_lsu_data_req_addr),
  .mmu_lsu_data_req_size (mmu_lsu_data_req_size),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Instance("aq_lsu_lm"); @38
aq_lsu_lm  x_aq_lsu_lm (
  .cp0_lsu_icg_en     (cp0_lsu_icg_en    ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .ifu_lsu_warm_up    (ifu_lsu_warm_up   ),
  .lm_clr             (lm_clr            ),
  .lm_pass            (lm_pass           ),
  .lm_req_addr        (lm_req_addr       ),
  .lm_req_size        (lm_req_size       ),
  .lm_set             (lm_set            ),
  .lm_set_gate        (lm_set_gate       ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .rtu_lsu_expt_ack   (rtu_lsu_expt_ack  ),
  .rtu_lsu_expt_exit  (rtu_lsu_expt_exit )
);

// &Instance("aq_lsu_amo_alu"); @39
aq_lsu_amo_alu  x_aq_lsu_amo_alu (
  .amo_alu_stb_id      (amo_alu_stb_id     ),
  .amo_alu_stb_rst     (amo_alu_stb_rst    ),
  .amo_alu_stb_rst_vld (amo_alu_stb_rst_vld),
  .cp0_lsu_icg_en      (cp0_lsu_icg_en     ),
  .cpurst_b            (cpurst_b           ),
  .da_amo_alu_func     (da_amo_alu_func    ),
  .da_amo_alu_size     (da_amo_alu_size    ),
  .da_amo_alu_src0     (da_amo_alu_src0    ),
  .da_amo_src_vld      (da_amo_src_vld     ),
  .da_amo_stb_id       (da_amo_stb_id      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .ifu_lsu_warm_up     (ifu_lsu_warm_up    ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .stb_amo_alu_src1    (stb_amo_alu_src1   )
);

// &Instance("aq_lsu_dtif"); @40
aq_lsu_dtif  x_aq_lsu_dtif (
  .ag_dtu_addr             (ag_dtu_addr            ),
  .ag_dtu_addr_ready       (ag_dtu_addr_ready      ),
  .ag_dtu_amo_type         (ag_dtu_amo_type        ),
  .ag_dtu_bytes_vld        (ag_dtu_bytes_vld       ),
  .ag_dtu_data             (ag_dtu_data            ),
  .ag_dtu_data_chk_mask    (ag_dtu_data_chk_mask   ),
  .ag_dtu_data_vld         (ag_dtu_data_vld        ),
  .ag_dtu_halt_info        (ag_dtu_halt_info       ),
  .ag_dtu_mem_access_size  (ag_dtu_mem_access_size ),
  .ag_dtu_pipe_down        (ag_dtu_pipe_down       ),
  .ag_dtu_req              (ag_dtu_req             ),
  .ag_dtu_req_gate         (ag_dtu_req_gate        ),
  .ag_dtu_split_last       (ag_dtu_split_last      ),
  .ag_dtu_st_type          (ag_dtu_st_type         ),
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .cpurst_b                (cpurst_b               ),
  .da_dtu_data             (da_dtu_data            ),
  .da_dtu_data_vld         (da_dtu_data_vld        ),
  .dtif_ag_cmplt_ready     (dtif_ag_cmplt_ready    ),
  .dtif_ag_fsm_idle        (dtif_ag_fsm_idle       ),
  .dtif_ag_halt_info       (dtif_ag_halt_info      ),
  .dtif_ag_halt_info_up    (dtif_ag_halt_info_up   ),
  .dtif_ag_pipedown_mask   (dtif_ag_pipedown_mask  ),
  .dtif_ag_stall           (dtif_ag_stall          ),
  .dtif_ag_trig_en         (dtif_ag_trig_en        ),
  .dtu_lsu_addr_trig_en    (dtu_lsu_addr_trig_en   ),
  .dtu_lsu_data_trig_en    (dtu_lsu_data_trig_en   ),
  .dtu_lsu_halt_info       (dtu_lsu_halt_info      ),
  .dtu_lsu_halt_info_vld   (dtu_lsu_halt_info_vld  ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_lsu_warm_up         (ifu_lsu_warm_up        ),
  .lsu_dtu_halt_info       (lsu_dtu_halt_info      ),
  .lsu_dtu_last_check      (lsu_dtu_last_check     ),
  .lsu_dtu_ldst_addr       (lsu_dtu_ldst_addr      ),
  .lsu_dtu_ldst_addr_vld   (lsu_dtu_ldst_addr_vld  ),
  .lsu_dtu_ldst_bytes_vld  (lsu_dtu_ldst_bytes_vld ),
  .lsu_dtu_ldst_data       (lsu_dtu_ldst_data      ),
  .lsu_dtu_ldst_data_vld   (lsu_dtu_ldst_data_vld  ),
  .lsu_dtu_ldst_type       (lsu_dtu_ldst_type      ),
  .lsu_dtu_mem_access_size (lsu_dtu_mem_access_size),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .rtu_yy_xx_flush         (rtu_yy_xx_flush        ),
  .vlsu_dtu_data           (vlsu_dtu_data          ),
  .vlsu_dtu_data_vld       (vlsu_dtu_data_vld      ),
  .vlsu_dtu_data_vld_gate  (vlsu_dtu_data_vld_gate )
);


assign lsu_rtu_no_op    = ag_xx_no_op & vlsu_xx_no_op & dc_xx_no_op & lfb_xx_no_op & da_xx_no_op;
assign lsu_cp0_sync_ack = lfb_xx_idle & icc_xx_idle & stb_xx_idle & vb_xx_idle & biu_lsu_no_op;
assign lsu_cp0_fence_ack = lfb_xx_idle & icc_xx_idle & stb_xx_idle & vb_xx_idle;

assign lsu_no_op = dc_xx_no_op & lfb_xx_idle & stb_xx_idle;

assign lsu_dtu_debug_info[93:0] = {ag_dbginfo[7:0],dc_dbginfo[9:0],lfb_dbginfo[55:0],stb_dbginfo[15:0],vb_dbginfo[3:0]};

// &Force("output", "da_xx_fwd_data"); @50
// &Force("output", "da_xx_fwd_dst_reg"); @51
// &Force("output", "da_xx_fwd_vld"); @52

// &Force("nonport", "lsu_vlsu_data_vld"); @56
// &Force("nonport", "lsu_vlsu_bytes_vld"); @57
// &Force("nonport", "lsu_vlsu_data"); @58
// &Force("nonport", "lsu_vlsu_vl_update"); @59
// &Force("nonport", "lsu_vlsu_vl_upval"); @60
// &Force("nonport", "lsu_vlsu_split_last"); @61
// &Force("nonport", "lsu_vlsu_sew"); @62
// &Force("nonport", "lsu_vlsu_func"); @63
// &Force("nonport", "lsu_vlsu_expt_vld"); @64
// &Force("nonport", "lsu_vlsu_dest_reg"); @65
// &Force("nonport", "lsu_vlsu_data_grant"); @67
// &Force("nonport", "lsu_vlsu_st_size"); @68
// &Force("nonport", "lsu_vlsu_st_sew"); @69
// &Force("nonport", "lsu_vlsu_st_offset"); @70
// &Force("nonport", "lsu_vlsu_st_expt"); @71
// &Force("nonport", "lsu_vlsu_dc_create_vld"); @73
// &Force("nonport", "lsu_vlsu_dc_fld_req"); @74
// &Force("nonport", "lsu_vlsu_dc_nf"); @75
// &Force("nonport", "lsu_vlsu_dc_sew"); @76
// &Force("nonport", "lsu_vlsu_dc_fof"); @77
// &Force("nonport", "lsu_vlsu_dc_split_cnt"); @78
// &Force("nonport", "lsu_vlsu_dc_sseg_first"); @79
// &Force("nonport", "lsu_vlsu_dc_stall"); @80


// &ModuleEnd; @105
endmodule


