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
module aq_lsu_stb(
  amo_alu_stb_id,
  amo_alu_stb_rst,
  amo_alu_stb_rst_vld,
  arb_stb_grant,
  biu_lsu_stb_awready,
  biu_lsu_stb_wready,
  cp0_lsu_dcache_wb,
  cp0_lsu_fence_req,
  cp0_lsu_icg_en,
  cp0_lsu_sync_req,
  cpurst_b,
  da_stb_amo_src_id,
  dc_stb_alct,
  dc_stb_alias_idx,
  dc_stb_amo_inst,
  dc_stb_attr,
  dc_stb_bytes_vld,
  dc_stb_cache_hit,
  dc_stb_clr_vld,
  dc_stb_data,
  dc_stb_data_shift,
  dc_stb_dca_inst,
  dc_stb_dca_type,
  dc_stb_hit_way,
  dc_stb_lock,
  dc_stb_pa,
  dc_stb_priv_mode,
  dc_stb_req,
  dc_stb_req_gate,
  dc_stb_size,
  dc_stb_src2_depd,
  dc_stb_src2_reg,
  dc_stb_virt_idx,
  dc_stb_wait_lfb,
  dc_xx_bytes_vld,
  dc_xx_pa,
  forever_cpuclk,
  icc_xx_sync_req,
  ifu_lsu_warm_up,
  lfb_stb_done,
  lfb_stb_err,
  lfb_stb_fifo,
  lfb_stb_id,
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
  pad_yy_icg_scan_en,
  pfb_xx_pa,
  rdl_stb_cmplt,
  rdl_stb_cmplt_id,
  rdl_stb_grant,
  stb_amo_alu_src1,
  stb_arb_data0_req,
  stb_arb_data1_req,
  stb_arb_data2_req,
  stb_arb_data3_req,
  stb_arb_data_din,
  stb_arb_data_idx,
  stb_arb_data_req,
  stb_arb_data_way,
  stb_arb_data_wen,
  stb_arb_dirty_idx,
  stb_arb_dirty_req,
  stb_arb_dirty_wen,
  stb_dbginfo,
  stb_dc_create_id,
  stb_dc_fwd_vld,
  stb_dc_hit_addr,
  stb_dc_hit_addr_wca,
  stb_dc_hit_dca,
  stb_dc_hit_idx,
  stb_dc_hit_not_ready,
  stb_dc_ld_data,
  stb_dc_ld_fwd_vld,
  stb_dc_merge_en,
  stb_dc_multi_or_part_hit,
  stb_dc_pop_en,
  stb_dc_ready,
  stb_dc_so_vld,
  stb_pfb_hit_idx,
  stb_rdl_id,
  stb_rdl_idx,
  stb_rdl_req,
  stb_rdl_tag,
  stb_rdl_type,
  stb_rdl_way,
  stb_xx_idle,
  vb_stb_clr_vld,
  vlsu_lsu_fwd_data,
  vlsu_lsu_fwd_dest_reg,
  vlsu_lsu_fwd_vld
);

// &Ports; @21
input   [1  :0]  amo_alu_stb_id;          
input   [63 :0]  amo_alu_stb_rst;         
input            amo_alu_stb_rst_vld;     
input            arb_stb_grant;           
input            biu_lsu_stb_awready;     
input            biu_lsu_stb_wready;      
input            cp0_lsu_dcache_wb;       
input            cp0_lsu_fence_req;       
input            cp0_lsu_icg_en;          
input            cp0_lsu_sync_req;        
input            cpurst_b;                
input   [1  :0]  da_stb_amo_src_id;       
input            dc_stb_alct;             
input   [1  :0]  dc_stb_alias_idx;        
input            dc_stb_amo_inst;         
input   [2  :0]  dc_stb_attr;             
input   [7  :0]  dc_stb_bytes_vld;        
input            dc_stb_cache_hit;        
input            dc_stb_clr_vld;          
input   [63 :0]  dc_stb_data;             
input   [3  :0]  dc_stb_data_shift;       
input            dc_stb_dca_inst;         
input   [1  :0]  dc_stb_dca_type;         
input   [3  :0]  dc_stb_hit_way;          
input            dc_stb_lock;             
input   [39 :0]  dc_stb_pa;               
input   [1  :0]  dc_stb_priv_mode;        
input            dc_stb_req;              
input            dc_stb_req_gate;         
input   [1  :0]  dc_stb_size;             
input            dc_stb_src2_depd;        
input   [4  :0]  dc_stb_src2_reg;         
input   [1  :0]  dc_stb_virt_idx;         
input            dc_stb_wait_lfb;         
input   [7  :0]  dc_xx_bytes_vld;         
input   [39 :0]  dc_xx_pa;                
input            forever_cpuclk;          
input            icc_xx_sync_req;         
input            ifu_lsu_warm_up;         
input            lfb_stb_done;            
input            lfb_stb_err;             
input   [3  :0]  lfb_stb_fifo;            
input   [1  :0]  lfb_stb_id;              
input            pad_yy_icg_scan_en;      
input   [39 :0]  pfb_xx_pa;               
input            rdl_stb_cmplt;           
input   [1  :0]  rdl_stb_cmplt_id;        
input            rdl_stb_grant;           
input            vb_stb_clr_vld;          
input   [63 :0]  vlsu_lsu_fwd_data;       
input   [4  :0]  vlsu_lsu_fwd_dest_reg;   
input            vlsu_lsu_fwd_vld;        
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
output  [63 :0]  stb_amo_alu_src1;        
output           stb_arb_data0_req;       
output           stb_arb_data1_req;       
output           stb_arb_data2_req;       
output           stb_arb_data3_req;       
output  [127:0]  stb_arb_data_din;        
output  [13 :0]  stb_arb_data_idx;        
output           stb_arb_data_req;        
output  [3  :0]  stb_arb_data_way;        
output  [7  :0]  stb_arb_data_wen;        
output  [13 :0]  stb_arb_dirty_idx;       
output           stb_arb_dirty_req;       
output  [7  :0]  stb_arb_dirty_wen;       
output  [15 :0]  stb_dbginfo;             
output  [1  :0]  stb_dc_create_id;        
output           stb_dc_fwd_vld;          
output           stb_dc_hit_addr;         
output           stb_dc_hit_addr_wca;     
output           stb_dc_hit_dca;          
output           stb_dc_hit_idx;          
output           stb_dc_hit_not_ready;    
output  [63 :0]  stb_dc_ld_data;          
output           stb_dc_ld_fwd_vld;       
output           stb_dc_merge_en;         
output           stb_dc_multi_or_part_hit; 
output           stb_dc_pop_en;           
output           stb_dc_ready;            
output           stb_dc_so_vld;           
output           stb_pfb_hit_idx;         
output  [1  :0]  stb_rdl_id;              
output  [13 :0]  stb_rdl_idx;             
output           stb_rdl_req;             
output  [27 :0]  stb_rdl_tag;             
output  [1  :0]  stb_rdl_type;            
output  [3  :0]  stb_rdl_way;             
output           stb_xx_idle;             

// &Regs; @22
reg     [33 :0]  burst_addr;              
reg     [3  :0]  burst_cur_state;         
reg     [3  :0]  burst_next_state;        
reg     [39 :0]  merge_awaddr;            
reg     [3  :0]  merge_awcache;           
reg     [2  :0]  merge_awprot;            
reg     [2  :0]  merge_awsize;            
reg              merge_awuser;            
reg     [2  :0]  merge_cur_state;         
reg     [2  :0]  merge_next_state;        
reg     [127:0]  merge_wdata;             
reg     [15 :0]  merge_wstrb;             
reg     [63 :0]  stb_amo_src1;            
reg     [63 :0]  stb_arb_data;            
reg     [13 :0]  stb_arb_idx;             
reg     [3  :0]  stb_arb_way;             
reg     [7  :0]  stb_arb_wen;             
reg     [39 :0]  stb_awaddr;              
reg     [3  :0]  stb_awcache;             
reg     [2  :0]  stb_awprot;              
reg     [2  :0]  stb_awsize;              
reg              stb_awuser;              
reg     [1  :0]  stb_create_ptr;          
reg     [1  :0]  stb_dca_idx;             
reg     [33 :0]  stb_dca_pa;              
reg     [1  :0]  stb_dca_type;            
reg     [3  :0]  stb_dca_way;             
reg     [1  :0]  stb_pop_ptr;             
reg     [63 :0]  stb_wdata;               
reg     [7  :0]  stb_wstrb;               
reg     [4  :0]  time_out;                

// &Wires; @23
wire    [1  :0]  amo_alu_stb_id;          
wire    [63 :0]  amo_alu_stb_rst;         
wire             amo_alu_stb_rst_vld;     
wire    [3  :0]  amo_data_ready;          
wire             arb_stb_grant;           
wire             biu_awready;             
wire             biu_lsu_stb_awready;     
wire             biu_lsu_stb_wready;      
wire    [3  :0]  biu_req_sel;             
wire             biu_wready;              
wire             burst_awready;           
wire             burst_clk;               
wire             burst_clk_en;            
wire    [1  :0]  burst_cnt;               
wire             burst_cur_data;          
wire             burst_cur_empty;         
wire             burst_cur_idle;          
wire             burst_cur_wfr;           
wire             burst_cur_wfr0;          
wire             burst_cur_wfr1;          
wire             burst_cur_wfr2;          
wire             burst_cur_wfr3;          
wire             burst_hit;               
wire             burst_last;              
wire             burst_start;             
wire             burst_wready;            
wire             cp0_lsu_dcache_wb;       
wire             cp0_lsu_fence_req;       
wire             cp0_lsu_icg_en;          
wire             cp0_lsu_sync_req;        
wire             cpurst_b;                
wire    [1  :0]  da_stb_amo_src_id;       
wire    [3  :0]  dc_hit_stb_addr;         
wire    [3  :0]  dc_hit_stb_addr_wca;     
wire    [3  :0]  dc_hit_stb_dca;          
wire    [3  :0]  dc_hit_stb_full;         
wire    [3  :0]  dc_hit_stb_idx;          
wire             dc_hit_stb_merge_addr;   
wire             dc_hit_stb_merge_idx;    
wire    [3  :0]  dc_hit_stb_part;         
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
wire             dc_stb_wo;               
wire    [7  :0]  dc_xx_bytes_vld;         
wire    [39 :0]  dc_xx_pa;                
wire    [3  :0]  dcache_req_sel;          
wire             forever_cpuclk;          
wire             icc_xx_sync_req;         
wire             ifu_lsu_warm_up;         
wire    [3  :0]  lfb_done;                
wire             lfb_err;                 
wire    [3  :0]  lfb_fifo;                
wire             lfb_stb_done;            
wire             lfb_stb_err;             
wire    [3  :0]  lfb_stb_fifo;            
wire    [1  :0]  lfb_stb_id;              
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
wire    [39 :0]  merge_addr_inc;          
wire    [39 :0]  merge_awaddr_f;          
wire             merge_awburst_inc;       
wire             merge_awvalid;           
wire             merge_clk;               
wire             merge_clk_en;            
wire             merge_cur_first;         
wire             merge_cur_idle;          
wire             merge_grant;             
wire             merge_hit;               
wire             merge_vld;               
wire             merge_wvalid;            
wire             pad_yy_icg_scan_en;      
wire    [3  :0]  pfb_hit_stb_idx;         
wire             pfb_hit_stb_merge_idx;   
wire    [39 :0]  pfb_xx_pa;               
wire    [3  :0]  rdl_sel;                 
wire             rdl_stb_cmplt;           
wire    [1  :0]  rdl_stb_cmplt_id;        
wire             rdl_stb_grant;           
wire             stb_all_merge_finish;    
wire    [63 :0]  stb_amo_alu_src1;        
wire    [1  :0]  stb_amo_src_id;          
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
wire             stb_arb_req;             
wire             stb_awvalid;             
wire             stb_clk;                 
wire             stb_clk_en;              
wire    [3  :0]  stb_create_age;          
wire             stb_create_alct;         
wire    [1  :0]  stb_create_alias_idx;    
wire             stb_create_amo_inst;     
wire    [2  :0]  stb_create_attr;         
wire    [7  :0]  stb_create_bytes_vld;    
wire             stb_create_cache_hit;    
wire    [63 :0]  stb_create_data;         
wire             stb_create_dca_inst;     
wire    [1  :0]  stb_create_dca_type;     
wire    [3  :0]  stb_create_en;           
wire    [3  :0]  stb_create_en_gate;      
wire             stb_create_lock;         
wire    [39 :0]  stb_create_pa;           
wire    [1  :0]  stb_create_priv_mode;    
wire    [1  :0]  stb_create_ptr_inc;      
wire    [3  :0]  stb_create_sel;          
wire    [3  :0]  stb_create_shift;        
wire    [1  :0]  stb_create_size;         
wire             stb_create_src2_depd;    
wire    [4  :0]  stb_create_src2_reg;     
wire    [1  :0]  stb_create_virt_idx;     
wire             stb_create_vld;          
wire             stb_create_vld_gate;     
wire             stb_create_wait_lfb;     
wire    [3  :0]  stb_create_way;          
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
wire    [3  :0]  stb_dca_done;            
wire    [3  :0]  stb_dca_grant;           
wire    [3  :0]  stb_entry0_age;          
wire    [7  :0]  stb_entry0_bytes_vld;    
wire    [3  :0]  stb_entry0_cache;        
wire    [63 :0]  stb_entry0_data;         
wire    [2  :0]  stb_entry0_dbginfo;      
wire    [1  :0]  stb_entry0_dca_idx;      
wire    [1  :0]  stb_entry0_dca_type;     
wire    [3  :0]  stb_entry0_dca_way;      
wire    [13 :0]  stb_entry0_idx;          
wire    [39 :0]  stb_entry0_pa;           
wire    [2  :0]  stb_entry0_prot;         
wire    [2  :0]  stb_entry0_size;         
wire             stb_entry0_user;         
wire    [3  :0]  stb_entry0_way;          
wire    [3  :0]  stb_entry1_age;          
wire    [7  :0]  stb_entry1_bytes_vld;    
wire    [3  :0]  stb_entry1_cache;        
wire    [63 :0]  stb_entry1_data;         
wire    [2  :0]  stb_entry1_dbginfo;      
wire    [1  :0]  stb_entry1_dca_idx;      
wire    [1  :0]  stb_entry1_dca_type;     
wire    [3  :0]  stb_entry1_dca_way;      
wire    [13 :0]  stb_entry1_idx;          
wire    [39 :0]  stb_entry1_pa;           
wire    [2  :0]  stb_entry1_prot;         
wire    [2  :0]  stb_entry1_size;         
wire             stb_entry1_user;         
wire    [3  :0]  stb_entry1_way;          
wire    [3  :0]  stb_entry2_age;          
wire    [7  :0]  stb_entry2_bytes_vld;    
wire    [3  :0]  stb_entry2_cache;        
wire    [63 :0]  stb_entry2_data;         
wire    [2  :0]  stb_entry2_dbginfo;      
wire    [1  :0]  stb_entry2_dca_idx;      
wire    [1  :0]  stb_entry2_dca_type;     
wire    [3  :0]  stb_entry2_dca_way;      
wire    [13 :0]  stb_entry2_idx;          
wire    [39 :0]  stb_entry2_pa;           
wire    [2  :0]  stb_entry2_prot;         
wire    [2  :0]  stb_entry2_size;         
wire             stb_entry2_user;         
wire    [3  :0]  stb_entry2_way;          
wire    [3  :0]  stb_entry3_age;          
wire    [7  :0]  stb_entry3_bytes_vld;    
wire    [3  :0]  stb_entry3_cache;        
wire    [63 :0]  stb_entry3_data;         
wire    [2  :0]  stb_entry3_dbginfo;      
wire    [1  :0]  stb_entry3_dca_idx;      
wire    [1  :0]  stb_entry3_dca_type;     
wire    [3  :0]  stb_entry3_dca_way;      
wire    [13 :0]  stb_entry3_idx;          
wire    [39 :0]  stb_entry3_pa;           
wire    [2  :0]  stb_entry3_prot;         
wire    [2  :0]  stb_entry3_size;         
wire             stb_entry3_user;         
wire    [3  :0]  stb_entry3_way;          
wire    [3  :0]  stb_entry_biu_req;       
wire    [3  :0]  stb_entry_dcache_req;    
wire    [3  :0]  stb_entry_fwd_vld;       
wire    [3  :0]  stb_entry_merge_en;      
wire    [3  :0]  stb_entry_pop_vld;       
wire    [3  :0]  stb_entry_rdl_req;       
wire    [3  :0]  stb_entry_so_vld;        
wire    [3  :0]  stb_entry_src2_depd;     
wire    [3  :0]  stb_entry_vld;           
wire             stb_full;                
wire             stb_merge_en;            
wire    [3  :0]  stb_merge_finish;        
wire             stb_merge_pop_vld;       
wire             stb_merge_req;           
wire             stb_merge_req_gate;      
wire             stb_merge_so_vld;        
wire             stb_one_entry_left;      
wire             stb_pfb_hit_idx;         
wire    [3  :0]  stb_pop_en;              
wire             stb_pop_merge_finish;    
wire    [3  :0]  stb_pop_sel;             
wire             stb_pop_vld;             
wire    [1  :0]  stb_rdl_id;              
wire    [13 :0]  stb_rdl_idx;             
wire             stb_rdl_req;             
wire    [27 :0]  stb_rdl_tag;             
wire    [1  :0]  stb_rdl_type;            
wire    [3  :0]  stb_rdl_way;             
wire    [3  :0]  stb_wbus_cmplt;          
wire    [3  :0]  stb_wca_grant;           
wire             stb_xx_idle;             
wire             time_done;               
wire             vb_stb_clr_vld;          
wire    [63 :0]  vlsu_lsu_fwd_data;       
wire    [4  :0]  vlsu_lsu_fwd_dest_reg;   
wire             vlsu_lsu_fwd_vld;        
wire    [127:0]  wdata;                   
wire    [15 :0]  wstrb;                   


parameter DEPTH = 4;

parameter PADDR = 40;

parameter CA = 0;
parameter SO = 1;
//================================================
//  stb merge check
//================================================
assign dc_stb_wo    = !dc_stb_attr[SO];

assign stb_dc_ready = stb_merge_en | 
                     !stb_full;

assign stb_merge_en = dc_stb_wo & 
                      !dc_stb_src2_depd &
                      !dc_stb_dca_inst & 
                      !dc_stb_lock & 
                      (|stb_entry_merge_en[DEPTH-1:0]);

assign stb_create_vld      = dc_stb_req & !stb_merge_en;
assign stb_create_vld_gate = dc_stb_req_gate & !stb_merge_en & !stb_full;

assign stb_merge_req = dc_stb_req & 
                      !dc_stb_src2_depd &
                       dc_stb_wo & 
                      !dc_stb_dca_inst & 
                      !dc_stb_lock;

assign stb_merge_req_gate = dc_stb_req_gate &
                           !dc_stb_src2_depd &
                            dc_stb_wo & 
                           !dc_stb_dca_inst & 
                           !dc_stb_lock;

assign stb_dc_merge_en = stb_merge_en;

//================================================
//    stb merge finish 
//================================================

assign stb_all_merge_finish = dc_stb_req & 
                             (dc_stb_dca_inst | dc_stb_lock | dc_stb_attr[SO]) |
                              cp0_lsu_sync_req | cp0_lsu_fence_req | icc_xx_sync_req | dc_stb_clr_vld;

assign stb_pop_merge_finish = stb_one_entry_left | stb_full;

assign stb_merge_finish[DEPTH-1:0] = {DEPTH{stb_all_merge_finish}} |
                                     {DEPTH{stb_pop_merge_finish}} & stb_pop_sel[DEPTH-1:0];

assign stb_one_entry_left = stb_create_ptr[1:0] == stb_pop_ptr[1:0];
assign stb_full           = stb_entry_vld[stb_create_ptr[1:0]]; 

assign stb_xx_idle = ~(|stb_entry_vld[DEPTH-1:0]) & merge_cur_idle & burst_cur_idle;

//================================================
//     load forward stb
//================================================
// &Force("output","stb_dc_hit_idx"); @87

// &CombBeg; @106
// &CombEnd; @119
assign stb_dc_ld_fwd_vld = |(dc_hit_stb_full[DEPTH-1:0]);
assign stb_dc_ld_data[`LSU_DATAW-1:0] = {`LSU_DATAW{dc_hit_stb_full[0]}} & stb_entry0_data[`LSU_DATAW-1:0] |
                                        {`LSU_DATAW{dc_hit_stb_full[1]}} & stb_entry1_data[`LSU_DATAW-1:0] |
                                        {`LSU_DATAW{dc_hit_stb_full[2]}} & stb_entry2_data[`LSU_DATAW-1:0] |
                                        {`LSU_DATAW{dc_hit_stb_full[3]}} & stb_entry3_data[`LSU_DATAW-1:0];

assign stb_dc_hit_idx = (|dc_hit_stb_idx[DEPTH-1:0]) | dc_hit_stb_merge_idx;
assign stb_dc_hit_dca = |dc_hit_stb_dca[DEPTH-1:0];
assign stb_dc_so_vld  = |stb_entry_so_vld[DEPTH-1:0] | stb_merge_so_vld;
assign stb_dc_multi_or_part_hit = (|(dc_hit_stb_part[DEPTH-1:0])) | 
                                  dc_hit_stb_merge_addr;

assign stb_dc_hit_not_ready = |(dc_hit_stb_full[DEPTH-1:0] & stb_entry_src2_depd[DEPTH-1:0]);

assign stb_dc_fwd_vld       = |stb_entry_fwd_vld[DEPTH-1:0];



assign stb_dc_pop_en  = |stb_entry_pop_vld[DEPTH-1:0] | stb_merge_pop_vld;

assign stb_dc_create_id[1:0] = stb_create_ptr[1:0];

assign stb_dc_hit_addr     = |(dc_hit_stb_addr[DEPTH-1:0]);
assign stb_dc_hit_addr_wca = |(dc_hit_stb_addr_wca[DEPTH-1:0]);

assign stb_pfb_hit_idx     = (|pfb_hit_stb_idx[DEPTH-1:0]) | pfb_hit_stb_merge_idx;

//================================================
//  stb create pointer
//================================================

always@(posedge stb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_create_ptr[1:0] <= 2'b0;
  else if (stb_create_vld)
    stb_create_ptr[1:0] <= stb_create_ptr_inc[1:0];
end

assign stb_create_ptr_inc[1:0] = stb_create_ptr[1:0] + 2'b1;

assign stb_create_sel[DEPTH-1:0]     = 4'b1 << stb_create_ptr[1:0];
assign stb_create_en[DEPTH-1:0]      = stb_create_sel[DEPTH-1:0] & {DEPTH{stb_create_vld}};
assign stb_create_en_gate[DEPTH-1:0] = stb_create_sel[DEPTH-1:0] & {DEPTH{stb_create_vld_gate}};

assign stb_create_dca_inst              = dc_stb_dca_inst;
assign stb_create_wait_lfb              = dc_stb_wait_lfb;
assign stb_create_cache_hit             = dc_stb_cache_hit;
assign stb_create_way[3:0]              = dc_stb_hit_way[3:0];
assign stb_create_virt_idx[1:0]         = dc_stb_virt_idx[1:0];
assign stb_create_alias_idx[1:0]        = dc_stb_alias_idx[1:0];
assign stb_create_lock                  = dc_stb_lock;
assign stb_create_alct                  = dc_stb_alct;
assign stb_create_pa[PADDR-1:0]         = dc_stb_pa[PADDR-1:0];
assign stb_create_dca_type[1:0]         = dc_stb_dca_type[1:0];
assign stb_create_bytes_vld[`LSU_BYTEW-1:0] = dc_stb_bytes_vld[`LSU_BYTEW-1:0];
assign stb_create_size[1:0]             = dc_stb_size[1:0];
assign stb_create_attr[2:0]             = dc_stb_attr[2:0];
assign stb_create_data[`LSU_DATAW-1:0]  = dc_stb_data[`LSU_DATAW-1:0];
assign stb_create_age[DEPTH-1:0]        = stb_entry_vld[DEPTH-1:0];
assign stb_create_shift[3:0]            = dc_stb_data_shift[3:0];
assign stb_create_src2_reg[4:0]         = dc_stb_src2_reg[4:0];
assign stb_create_src2_depd             = dc_stb_src2_depd;
assign stb_create_priv_mode[1:0]        = dc_stb_priv_mode[1:0];
assign stb_create_amo_inst              = dc_stb_amo_inst;

assign stb_pop_en[DEPTH-1:0]            = stb_entry_pop_vld[DEPTH-1:0];

//================================================
//  stb pop pointer
//================================================
assign stb_pop_vld = (stb_create_ptr[1:0] != stb_pop_ptr[1:0]) & !stb_entry_vld[stb_pop_ptr[1:0]] | 
                     stb_entry_pop_vld[stb_pop_ptr[1:0]];

always@(posedge stb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_pop_ptr[1:0] <= 2'b0;
  else if (stb_pop_vld)
    stb_pop_ptr[1:0] <= stb_pop_ptr[1:0] + 2'b1;
end

assign stb_pop_sel[DEPTH-1:0] = 4'b1 << stb_pop_ptr[1:0];

//================================================
//  lfb_done
//================================================
assign lfb_done[DEPTH-1:0] = {DEPTH{lfb_stb_done}} & (4'b1 << lfb_stb_id[1:0]);
assign lfb_err             = lfb_stb_err;
assign lfb_fifo[3:0]       = lfb_stb_fifo[3:0];

//================================================
//  amo data 
//================================================
assign stb_amo_src_id[1:0]  = da_stb_amo_src_id[1:0];

// &CombBeg; @241
always @( stb_amo_src_id[1:0]
       or stb_entry1_data[63:0]
       or stb_entry2_data[63:0]
       or stb_entry0_data[63:0]
       or stb_entry3_data[63:0])
begin
  case(stb_amo_src_id[1:0])
  2'b00:   stb_amo_src1[63:0] = stb_entry0_data[63:0]; 
  2'b01:   stb_amo_src1[63:0] = stb_entry1_data[63:0]; 
  2'b10:   stb_amo_src1[63:0] = stb_entry2_data[63:0]; 
  2'b11:   stb_amo_src1[63:0] = stb_entry3_data[63:0]; 
  default: stb_amo_src1[63:0] = {64{1'bx}}; 
  endcase
// &CombEnd; @249
end
assign stb_amo_alu_src1[63:0] = stb_amo_src1[63:0];

assign amo_data_ready[DEPTH-1:0] = {DEPTH{amo_alu_stb_rst_vld}} & (4'b1 << amo_alu_stb_id[1:0]);
//================================================
//  dca request to RDL
//================================================

assign rdl_sel[0] = stb_entry_rdl_req[0] & !(|(stb_entry_rdl_req[DEPTH-1:0] & stb_entry0_age[DEPTH-1:0]));
assign rdl_sel[1] = stb_entry_rdl_req[1] & !(|(stb_entry_rdl_req[DEPTH-1:0] & stb_entry1_age[DEPTH-1:0]));
assign rdl_sel[2] = stb_entry_rdl_req[2] & !(|(stb_entry_rdl_req[DEPTH-1:0] & stb_entry2_age[DEPTH-1:0]));
assign rdl_sel[3] = stb_entry_rdl_req[3] & !(|(stb_entry_rdl_req[DEPTH-1:0] & stb_entry3_age[DEPTH-1:0]));

// &CombBeg; @262
always @( stb_entry0_dca_way[3:0]
       or stb_entry0_dca_idx[1:0]
       or stb_entry0_pa[39:6]
       or stb_entry1_dca_type[1:0]
       or stb_entry1_dca_way[3:0]
       or stb_entry3_dca_type[1:0]
       or stb_entry3_pa[39:6]
       or stb_entry3_dca_idx[1:0]
       or stb_entry2_dca_way[3:0]
       or stb_entry2_dca_idx[1:0]
       or rdl_sel[3:0]
       or stb_entry3_dca_way[3:0]
       or stb_entry2_dca_type[1:0]
       or stb_entry0_dca_type[1:0]
       or stb_entry1_pa[39:6]
       or stb_entry1_dca_idx[1:0]
       or stb_entry2_pa[39:6])
begin
  case(rdl_sel[DEPTH-1:0])
  4'b0001: begin stb_dca_pa[33:0]  = stb_entry0_pa[PADDR-1:6];
                 stb_dca_idx[1:0]  = stb_entry0_dca_idx[1:0]; 
                 stb_dca_way[3:0]  = stb_entry0_dca_way[3:0]; 
                 stb_dca_type[1:0] = stb_entry0_dca_type[1:0]; 
           end
  4'b0010: begin stb_dca_pa[33:0]  = stb_entry1_pa[PADDR-1:6];
                 stb_dca_idx[1:0]  = stb_entry1_dca_idx[1:0]; 
                 stb_dca_way[3:0]  = stb_entry1_dca_way[3:0]; 
                 stb_dca_type[1:0] = stb_entry1_dca_type[1:0]; 
           end
  4'b0100: begin stb_dca_pa[33:0]  = stb_entry2_pa[PADDR-1:6];
                 stb_dca_idx[1:0]  = stb_entry2_dca_idx[1:0]; 
                 stb_dca_way[3:0]  = stb_entry2_dca_way[3:0]; 
                 stb_dca_type[1:0] = stb_entry2_dca_type[1:0]; 
           end
  4'b1000: begin stb_dca_pa[33:0]  = stb_entry3_pa[PADDR-1:6];
                 stb_dca_idx[1:0]  = stb_entry3_dca_idx[1:0]; 
                 stb_dca_way[3:0]  = stb_entry3_dca_way[3:0]; 
                 stb_dca_type[1:0] = stb_entry3_dca_type[1:0]; 
           end
  default: begin stb_dca_pa[33:0]  = 34'bx;
                 stb_dca_idx[1:0]  = 2'bx;
                 stb_dca_way[3:0]  = 4'bx;
                 stb_dca_type[1:0] = 2'bx;
           end
  endcase
// &CombEnd; @290
end

assign stb_rdl_req       = |stb_entry_rdl_req[DEPTH-1:0];
assign stb_rdl_tag[27:0] = stb_dca_pa[33:6];
assign stb_rdl_idx[13:0] = {stb_dca_idx[1:0],stb_dca_pa[5:0], 6'b0};
assign stb_rdl_way[3:0]  = stb_dca_way[3:0];
assign stb_rdl_type[1:0] = stb_dca_type[1:0];
assign stb_rdl_id[1:0]   = {rdl_sel[3] | rdl_sel[2],
                            rdl_sel[3] | rdl_sel[1]};

assign stb_dca_grant[DEPTH-1:0] = {DEPTH{rdl_stb_grant}} & rdl_sel[DEPTH-1:0];
assign stb_dca_done[DEPTH-1:0]  = {DEPTH{rdl_stb_cmplt}} & (4'b1 << rdl_stb_cmplt_id[1:0]);

//================================================
//  stb dcache request pointer
//================================================
assign dcache_req_sel[0] = stb_entry_dcache_req[0] & !(|(stb_entry_dcache_req[DEPTH-1:0] & stb_entry0_age[DEPTH-1:0]));
assign dcache_req_sel[1] = stb_entry_dcache_req[1] & !(|(stb_entry_dcache_req[DEPTH-1:0] & stb_entry1_age[DEPTH-1:0]));
assign dcache_req_sel[2] = stb_entry_dcache_req[2] & !(|(stb_entry_dcache_req[DEPTH-1:0] & stb_entry2_age[DEPTH-1:0]));
assign dcache_req_sel[3] = stb_entry_dcache_req[3] & !(|(stb_entry_dcache_req[DEPTH-1:0] & stb_entry3_age[DEPTH-1:0]));

assign stb_arb_req = |stb_entry_dcache_req[DEPTH-1:0];

// &CombBeg; @313
always @( stb_entry0_bytes_vld[7:0]
       or stb_entry3_idx[13:0]
       or stb_entry1_way[3:0]
       or dcache_req_sel[3:0]
       or stb_entry2_way[3:0]
       or stb_entry0_data[63:0]
       or stb_entry0_way[3:0]
       or stb_entry3_way[3:0]
       or stb_entry1_bytes_vld[7:0]
       or stb_entry2_data[63:0]
       or stb_entry3_bytes_vld[7:0]
       or stb_entry0_idx[13:0]
       or stb_entry1_data[63:0]
       or stb_entry3_data[63:0]
       or stb_entry2_idx[13:0]
       or stb_entry1_idx[13:0]
       or stb_entry2_bytes_vld[7:0])
begin
  case(dcache_req_sel[DEPTH-1:0])
  4'b0001: begin stb_arb_idx[13:0]            = stb_entry0_idx[13:0]; 
                 stb_arb_way[3:0]             = stb_entry0_way[3:0]; 
                 stb_arb_wen[`LSU_BYTEW-1:0]  = stb_entry0_bytes_vld[`LSU_BYTEW-1:0]; 
                 stb_arb_data[`LSU_DATAW-1:0] = stb_entry0_data[`LSU_DATAW-1:0]; 
           end
  4'b0010: begin stb_arb_idx[13:0]            = stb_entry1_idx[13:0]; 
                 stb_arb_way[3:0]             = stb_entry1_way[3:0]; 
                 stb_arb_wen[`LSU_BYTEW-1:0]  = stb_entry1_bytes_vld[`LSU_BYTEW-1:0]; 
                 stb_arb_data[`LSU_DATAW-1:0] = stb_entry1_data[`LSU_DATAW-1:0]; 
           end
  4'b0100: begin stb_arb_idx[13:0]            = stb_entry2_idx[13:0]; 
                 stb_arb_way[3:0]             = stb_entry2_way[3:0]; 
                 stb_arb_wen[`LSU_BYTEW-1:0]  = stb_entry2_bytes_vld[`LSU_BYTEW-1:0]; 
                 stb_arb_data[`LSU_DATAW-1:0] = stb_entry2_data[`LSU_DATAW-1:0]; 
           end
  4'b1000: begin stb_arb_idx[13:0]            = stb_entry3_idx[13:0]; 
                 stb_arb_way[3:0]             = stb_entry3_way[3:0]; 
                 stb_arb_wen[`LSU_BYTEW-1:0]  = stb_entry3_bytes_vld[`LSU_BYTEW-1:0]; 
                 stb_arb_data[`LSU_DATAW-1:0] = stb_entry3_data[`LSU_DATAW-1:0]; 
           end
  default: begin stb_arb_idx[13:0]            = 14'bx; 
                 stb_arb_way[3:0]             = 4'bx; 
                 stb_arb_wen[`LSU_BYTEW-1:0]  = {(`LSU_BYTEW-1+1){1'bx}}; 
                 stb_arb_data[`LSU_DATAW-1:0] = {`LSU_DATAW{1'bx}}; 
           end
  endcase
// &CombEnd; @341
end

assign stb_arb_data_req          = stb_arb_req;
assign stb_arb_data0_req       = stb_arb_req & (!stb_arb_idx[3] & stb_arb_way[0] | stb_arb_idx[3] & stb_arb_way[1]);
assign stb_arb_data1_req       = stb_arb_req & (!stb_arb_idx[3] & stb_arb_way[1] | stb_arb_idx[3] & stb_arb_way[0]);
assign stb_arb_data2_req       = stb_arb_req & (!stb_arb_idx[3] & stb_arb_way[2] | stb_arb_idx[3] & stb_arb_way[3]);
assign stb_arb_data3_req       = stb_arb_req & (!stb_arb_idx[3] & stb_arb_way[3] | stb_arb_idx[3] & stb_arb_way[2]);
assign stb_arb_data_din[127:0] = {stb_arb_data[`LSU_DATAW-1:0],stb_arb_data[`LSU_DATAW-1:0]};
assign stb_arb_data_way[3:0]   = stb_arb_way[3:0];
assign stb_arb_data_idx[13:0]           = stb_arb_idx[13:0];
assign stb_arb_data_wen[`LSU_BYTEW-1:0] = stb_arb_wen[`LSU_BYTEW-1:0];

assign stb_arb_dirty_req       = stb_arb_req & arb_stb_grant;
assign stb_arb_dirty_idx[13:0] = stb_arb_idx[13:0];
assign stb_arb_dirty_wen[7:0]  = {4'b0,stb_arb_way[3:0]};

assign stb_wca_grant[DEPTH-1:0] = {DEPTH{arb_stb_grant}} & dcache_req_sel[DEPTH-1:0];

//================================================
//  stb dcache request pointer
//================================================
assign biu_req_sel[0] = stb_entry_biu_req[0] & !(|(stb_entry_biu_req[DEPTH-1:0] & stb_entry0_age[DEPTH-1:0]));
assign biu_req_sel[1] = stb_entry_biu_req[1] & !(|(stb_entry_biu_req[DEPTH-1:0] & stb_entry1_age[DEPTH-1:0]));
assign biu_req_sel[2] = stb_entry_biu_req[2] & !(|(stb_entry_biu_req[DEPTH-1:0] & stb_entry2_age[DEPTH-1:0]));
assign biu_req_sel[3] = stb_entry_biu_req[3] & !(|(stb_entry_biu_req[DEPTH-1:0] & stb_entry3_age[DEPTH-1:0]));

assign stb_awvalid     = (|stb_entry_biu_req[DEPTH-1:0]);

// &CombBeg; @388
// &CombEnd; @406
// &CombBeg; @408
// &CombEnd; @441
// &CombBeg; @444
always @( stb_entry0_bytes_vld[7:0]
       or stb_entry2_cache[3:0]
       or stb_entry2_size[2:0]
       or stb_entry1_user
       or stb_entry1_size[2:0]
       or stb_entry0_prot[2:0]
       or stb_entry0_data[63:0]
       or stb_entry2_prot[2:0]
       or biu_req_sel[3:0]
       or stb_entry0_size[2:0]
       or stb_entry1_cache[3:0]
       or stb_entry1_pa[39:0]
       or stb_entry0_pa[39:0]
       or stb_entry2_pa[39:0]
       or stb_entry3_pa[39:0]
       or stb_entry1_bytes_vld[7:0]
       or stb_entry2_data[63:0]
       or stb_entry1_prot[2:0]
       or stb_entry0_user
       or stb_entry3_bytes_vld[7:0]
       or stb_entry0_cache[3:0]
       or stb_entry2_user
       or stb_entry3_user
       or stb_entry3_prot[2:0]
       or stb_entry3_cache[3:0]
       or stb_entry1_data[63:0]
       or stb_entry3_data[63:0]
       or stb_entry3_size[2:0]
       or stb_entry2_bytes_vld[7:0])
begin
  case(biu_req_sel[DEPTH-1:0])
  4'b0001: begin stb_awaddr[39:0]          = stb_entry0_pa[39:0]; 
                 stb_awcache[3:0]          = stb_entry0_cache[3:0]; 
                 stb_awprot[2:0]           = stb_entry0_prot[2:0]; 
                 stb_awsize[2:0]           = stb_entry0_size[2:0]; 
                 stb_awuser                = stb_entry0_user; 
                 stb_wstrb[`LSU_BYTEW-1:0] = stb_entry0_bytes_vld[`LSU_BYTEW-1:0];
                 stb_wdata[`LSU_DATAW-1:0] = stb_entry0_data[`LSU_DATAW-1:0]; 
           end
  4'b0010: begin stb_awaddr[39:0]          = stb_entry1_pa[39:0]; 
                 stb_awcache[3:0]          = stb_entry1_cache[3:0]; 
                 stb_awprot[2:0]           = stb_entry1_prot[2:0]; 
                 stb_awsize[2:0]           = stb_entry1_size[2:0]; 
                 stb_awuser                = stb_entry1_user; 
                 stb_wstrb[`LSU_BYTEW-1:0] = stb_entry1_bytes_vld[`LSU_BYTEW-1:0];
                 stb_wdata[`LSU_DATAW-1:0] = stb_entry1_data[`LSU_DATAW-1:0]; 
           end
  4'b0100: begin stb_awaddr[39:0]          = stb_entry2_pa[39:0]; 
                 stb_awcache[3:0]          = stb_entry2_cache[3:0]; 
                 stb_awprot[2:0]           = stb_entry2_prot[2:0]; 
                 stb_awsize[2:0]           = stb_entry2_size[2:0]; 
                 stb_awuser                = stb_entry2_user; 
                 stb_wstrb[`LSU_BYTEW-1:0] = stb_entry2_bytes_vld[`LSU_BYTEW-1:0];
                 stb_wdata[`LSU_DATAW-1:0] = stb_entry2_data[`LSU_DATAW-1:0]; 
           end
  4'b1000: begin stb_awaddr[39:0]          = stb_entry3_pa[39:0]; 
                 stb_awcache[3:0]          = stb_entry3_cache[3:0]; 
                 stb_awprot[2:0]           = stb_entry3_prot[2:0]; 
                 stb_awsize[2:0]           = stb_entry3_size[2:0]; 
                 stb_awuser                = stb_entry3_user; 
                 stb_wstrb[`LSU_BYTEW-1:0] = stb_entry3_bytes_vld[`LSU_BYTEW-1:0];
                 stb_wdata[`LSU_DATAW-1:0] = stb_entry3_data[`LSU_DATAW-1:0]; 
           end
  default: begin stb_awaddr[39:0]          = 40'b0; 
                 stb_awcache[3:0]          = 4'b0; 
                 stb_awprot[2:0]           = 3'b0; 
                 stb_awsize[2:0]           = 3'b0;
                 stb_awuser                = 1'b0;
                 stb_wstrb[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b0}};
                 stb_wdata[`LSU_DATAW-1:0] = {`LSU_DATAW{1'b0}}; 
           end
  endcase
// &CombEnd; @487
end


//==============================================================================
//        store merge
//==============================================================================
//================================================
//  merge two 64 request to one 128 request
//================================================
parameter MERGE_IDLE  = 3'b000;
parameter MERGE_FIRST = 3'b001;
parameter MERGE_SECND = 3'b010;
parameter MERGE_ABORT = 3'b011;
parameter MERGE_WFC   = 3'b100;

always@(posedge merge_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    merge_cur_state[2:0] <= MERGE_IDLE;
  else 
    merge_cur_state[2:0] <= merge_next_state[2:0];
end

assign merge_vld = stb_awvalid &
                   stb_awaddr[2:0] == 3'b0 &
                   stb_awcache[2] & 
                   (&stb_wstrb[7:0]);
assign merge_hit = stb_awvalid &
                   (stb_awaddr[PADDR-1:0] == merge_addr_inc[PADDR-1:0]) & 
                   stb_awcache[2] & 
                   (&stb_wstrb[7:0]);

// &CombBeg; @547
always @( stb_awvalid
       or burst_awready
       or burst_wready
       or stb_all_merge_finish
       or merge_hit
       or merge_cur_state
       or dc_stb_clr_vld
       or merge_vld)
begin
  case(merge_cur_state)
    MERGE_IDLE: begin
      if (merge_vld)
        merge_next_state = MERGE_FIRST;
      else if (stb_awvalid)
        merge_next_state = MERGE_ABORT;
      else
        merge_next_state = MERGE_IDLE;
    end
    MERGE_FIRST: begin
      if (merge_hit)  
        merge_next_state = MERGE_SECND;
      else if (stb_awvalid | stb_all_merge_finish | dc_stb_clr_vld)
        merge_next_state = MERGE_ABORT;
      else
        merge_next_state = MERGE_FIRST;
    end
    MERGE_SECND: begin
      if (burst_awready)
        merge_next_state = MERGE_WFC;
      else
        merge_next_state = MERGE_SECND;
    end
    MERGE_ABORT: begin
      if (burst_awready)
        merge_next_state = MERGE_WFC;
      else
        merge_next_state = MERGE_ABORT;
    end
    MERGE_WFC: begin
      if (burst_wready)
        merge_next_state = MERGE_IDLE;
      else
        merge_next_state = MERGE_WFC;
    end
    default: merge_next_state = MERGE_IDLE;
  endcase
// &CombEnd; @585
end

assign merge_cur_idle  = merge_cur_state == MERGE_IDLE;
assign merge_cur_first = merge_cur_state == MERGE_FIRST;

assign merge_grant               = merge_cur_idle | merge_cur_first & merge_hit;
assign stb_wbus_cmplt[DEPTH-1:0] = {DEPTH{merge_grant}} & biu_req_sel[DEPTH-1:0];
//================================================
//  merge buffer
//================================================
assign merge_awvalid   = merge_cur_state == MERGE_SECND | 
                         merge_cur_state == MERGE_ABORT;
assign merge_wvalid    = merge_cur_state == MERGE_WFC;

always@(posedge merge_clk)
begin
  if (stb_awvalid & merge_cur_idle | ifu_lsu_warm_up) begin
    merge_awaddr[PADDR-1:0] <= stb_awaddr[PADDR-1:0];
    merge_awcache[3:0]      <= stb_awcache[3:0];
    merge_awprot[2:0]       <= stb_awprot[2:0];
    merge_awuser            <= stb_awuser;
  end
end

assign merge_awburst_inc = !merge_awaddr[3];

assign merge_awaddr_f[PADDR-1:0] = merge_cur_state == MERGE_SECND
                                 ? {merge_awaddr[PADDR-1:4],4'b0}
                                 : merge_awaddr[PADDR-1:0];

assign merge_addr_inc[PADDR-1:0] = merge_awaddr[3] 
                                 ? {merge_awaddr[PADDR-1:4],1'b0,3'b0}
                                 : {merge_awaddr[PADDR-1:4],1'b1,3'b0};

assign wstrb[15:0]  = stb_awaddr[3] ? {stb_wstrb[7:0], 8'b0}  : {8'b0, stb_wstrb[7:0]};
assign wdata[127:0] = stb_awaddr[3] ? {stb_wdata[63:0],64'b0} : {64'b0,stb_wdata[63:0]};

always@(posedge merge_clk)
begin
  if (stb_awvalid & merge_cur_idle | ifu_lsu_warm_up) begin
    merge_awsize[2:0]  <= stb_awsize[2:0];
    merge_wstrb[15:0]  <= wstrb[15:0];
    merge_wdata[127:0] <= wdata[127:0];
  end
  else if (merge_cur_first & merge_hit) begin
    merge_awsize[2:0]  <= 3'b100;
    merge_wstrb[15:0]  <= {16{1'b1}};
    merge_wdata[127:0] <= merge_awaddr[3] 
                        ? {merge_wdata[127:64], stb_wdata[63:0]}
                        : {stb_wdata[63:0],   merge_wdata[63:0]};
  end
end 

//================================================
//  merge buffer dependency check
//================================================
// &Force("bus", "dc_xx_pa",PADDR-1,0); @641
// &Force("bus", "pfb_xx_pa",PADDR-1,0); @642

assign pfb_hit_stb_merge_idx = !merge_cur_idle & (pfb_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == merge_awaddr[`D_TAG_INDEX_WIDTH+6-1:6]);
assign dc_hit_stb_merge_idx  = !merge_cur_idle & (dc_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == merge_awaddr[`D_TAG_INDEX_WIDTH+6-1:6]);
assign dc_hit_stb_merge_addr = !merge_cur_idle & (dc_xx_pa[PADDR-1:4] == merge_awaddr[PADDR-1:4]);
assign stb_merge_pop_vld     = merge_cur_state == MERGE_WFC & burst_wready;
assign stb_merge_so_vld      = !merge_cur_idle & !merge_awcache[1];
//================================================
//  burst FSM
//================================================
parameter BURST_WFR0   = 4'b0000;
parameter BURST_WFR1   = 4'b0001;
parameter BURST_WFR2   = 4'b0010;
parameter BURST_WFR3   = 4'b0011;
parameter BURST_DATA0  = 4'b0100;
parameter BURST_DATA1  = 4'b0101;
parameter BURST_DATA2  = 4'b0110;
parameter BURST_DATA3  = 4'b0111;
parameter BURST_EMPTY1 = 4'b1001;
parameter BURST_EMPTY2 = 4'b1010;
parameter BURST_EMPTY3 = 4'b1011;

always@(posedge burst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    burst_cur_state[3:0] <= BURST_WFR0;
  else 
    burst_cur_state[3:0] <= burst_next_state[3:0];
end

assign burst_start = merge_awvalid & merge_awburst_inc &
                     merge_awaddr_f[5:0] == 6'b0 &
                     merge_awcache[2] &
                     (&merge_wstrb[15:0]);
assign burst_hit   = merge_awvalid & 
                     merge_awaddr_f[PADDR-1:6] == burst_addr[33:0] & 
                     merge_awaddr_f[5:4] == burst_cnt[1:0] &
                     merge_awaddr_f[3:0] == 4'b0 &
                     merge_awcache[2] & 
                     (&merge_wstrb[15:0]);

// &CombBeg; @697
always @( biu_awready
       or burst_start
       or burst_hit
       or time_done
       or merge_awvalid
       or biu_wready
       or vb_stb_clr_vld
       or burst_cur_state)
begin
  case(burst_cur_state)
    BURST_WFR0: begin
      if (burst_start & biu_awready)
        burst_next_state = BURST_DATA0;
      else 
        burst_next_state = BURST_WFR0;
    end
    BURST_DATA0: begin
      if (biu_wready)
        burst_next_state = BURST_WFR1;
      else 
        burst_next_state = BURST_DATA0;
    end
    BURST_WFR1: begin
      if (burst_hit)
        burst_next_state = BURST_DATA1;
      else if (merge_awvalid | vb_stb_clr_vld | time_done)
        burst_next_state = BURST_EMPTY1;
      else 
        burst_next_state = BURST_WFR1;
    end
    BURST_DATA1: begin
      if (biu_wready)
        burst_next_state = BURST_WFR2;
      else
        burst_next_state = BURST_DATA1;
    end
    BURST_WFR2: begin
      if (burst_hit)
        burst_next_state = BURST_DATA2;
      else if (merge_awvalid | vb_stb_clr_vld | time_done)
        burst_next_state = BURST_EMPTY2;
      else
        burst_next_state = BURST_WFR2;
    end
    BURST_DATA2: begin
      if (biu_wready)
        burst_next_state = BURST_WFR3;
      else
        burst_next_state = BURST_DATA2;
    end
    BURST_WFR3: begin
      if (burst_hit)
        burst_next_state = BURST_DATA3;
      else if (merge_awvalid | vb_stb_clr_vld | time_done)
        burst_next_state = BURST_EMPTY3;
      else 
        burst_next_state = BURST_WFR3;
    end
    BURST_DATA3: begin
      if (biu_wready)
        burst_next_state = BURST_WFR0;
      else
        burst_next_state = BURST_DATA3;
    end
    BURST_EMPTY1: begin
      if (biu_wready)
        burst_next_state = BURST_EMPTY2;
      else
        burst_next_state = BURST_EMPTY1;
    end
    BURST_EMPTY2: begin
      if (biu_wready)
        burst_next_state = BURST_EMPTY3;
      else
        burst_next_state = BURST_EMPTY2;
    end
    BURST_EMPTY3: begin
      if (biu_wready)
        burst_next_state = BURST_WFR0;
      else
        burst_next_state = BURST_EMPTY3;
    end
    default: burst_next_state = BURST_WFR0;
  endcase
// &CombEnd; @785
end

assign burst_cur_idle  = burst_cur_wfr0;
assign biu_awready     = biu_lsu_stb_awready;
assign biu_wready      = biu_lsu_stb_wready;



assign burst_cur_wfr   = burst_cur_state[3:2] == 2'b00;
assign burst_cur_data  = burst_cur_state[3:2] == 2'b01;
assign burst_cur_empty = burst_cur_state[3:2] == 2'b10;
assign burst_last      = (burst_cur_data | burst_cur_empty) & 
                         (burst_cur_state[1:0] == 2'b11);

assign burst_cur_wfr0                = burst_cur_state == BURST_WFR0;
assign burst_cur_wfr1                = burst_cur_state == BURST_WFR1;
assign burst_cur_wfr2                = burst_cur_state == BURST_WFR2;
assign burst_cur_wfr3                = burst_cur_state == BURST_WFR3;

assign burst_awready                 = burst_cur_wfr0 & biu_awready |
                                       (burst_cur_wfr1 | burst_cur_wfr2 | burst_cur_wfr3) & burst_hit;
assign burst_wready                  = (burst_cur_wfr0 | burst_cur_data) & biu_wready;
assign lsu_biu_stb_awvalid           = burst_cur_wfr0 & merge_awvalid;
assign lsu_biu_stb_awid[1:0]         = 2'b00;
assign lsu_biu_stb_awaddr[PADDR-1:0] = merge_awaddr_f[PADDR-1:0];
assign lsu_biu_stb_awcache[3:0]      = merge_awcache[3:0];
assign lsu_biu_stb_awprot[2:0]       = merge_awprot[2:0];
assign lsu_biu_stb_awsize[2:0]       = merge_awsize[2:0];
assign lsu_biu_stb_awuser            = merge_awuser;
assign lsu_biu_stb_awburst[1:0]      = 2'b01;
assign lsu_biu_stb_awlen[1:0]        = burst_start ? 2'b11 : 2'b00;

assign lsu_biu_stb_wvalid            = burst_cur_wfr0 & merge_wvalid |
                                       burst_cur_data & merge_wvalid |
                                       burst_cur_empty;
assign lsu_biu_stb_wdata[127:0]      = merge_wdata[127:0];
assign lsu_biu_stb_wstrb[15:0]       = burst_cur_empty ? 16'b0 : merge_wstrb[15:0]; 
assign lsu_biu_stb_wlast             = burst_cur_wfr0 | burst_last;



always@(posedge burst_clk)
begin
  if (burst_cur_wfr0 & burst_start & biu_awready | ifu_lsu_warm_up) 
    burst_addr[33:0] <= merge_awaddr_f[PADDR-1:6];
end

assign burst_cnt[1:0] = burst_cur_state[1:0];

always@(posedge burst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    time_out[4:0] <= 5'b0;
  else if (burst_cur_wfr0 & burst_start & biu_awready | burst_cur_data)
    time_out[4:0] <= 5'b0;
  else if (burst_cur_wfr)
    time_out[4:0] <= time_out[4:0] + 5'b1;
end
assign time_done = time_out[4:0] == 5'b11111;

//================================================
//  DBG_INFO
//================================================
assign stb_dbginfo[15:0] = {stb_pop_ptr[1:0],stb_create_ptr[1:0],
                            stb_entry3_dbginfo[2:0],
                            stb_entry2_dbginfo[2:0],
                            stb_entry1_dbginfo[2:0],
                            stb_entry0_dbginfo[2:0]};

//==============================================================================
//  ICG
//==============================================================================

assign stb_clk_en = dc_stb_req_gate | 
                    (|stb_entry_vld[DEPTH-1:0]) | 
                    (stb_create_ptr[1:0] != stb_pop_ptr[1:0]);
// &Instance("gated_clk_cell", "x_aq_lsu_stb_gated_clk"); @885
gated_clk_cell  x_aq_lsu_stb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (stb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (stb_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @886
//          .external_en (1'b0), @887
//          .global_en   (1'b1), @888
//          .module_en   (cp0_lsu_icg_en), @889
//          .local_en    (stb_clk_en), @890
//          .clk_out     (stb_clk)); @891

// &Instance("gated_clk_cell", "x_aq_lsu_stb_wbus_gated_clk"); @895
// &Connect(.clk_in      (forever_cpuclk), @896
//          .external_en (1'b0), @897
//          .global_en   (1'b1), @898
//          .module_en   (cp0_lsu_icg_en), @899
//          .local_en    (stb_wbus_clk_en), @900
//          .clk_out     (stb_wbus_clk)); @901
assign merge_clk_en = stb_awvalid | !merge_cur_idle | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_stb_merge_gated_clk"); @904
gated_clk_cell  x_aq_lsu_stb_merge_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (merge_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (merge_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @905
//          .external_en (1'b0), @906
//          .global_en   (1'b1), @907
//          .module_en   (cp0_lsu_icg_en), @908
//          .local_en    (merge_clk_en), @909
//          .clk_out     (merge_clk)); @910

assign burst_clk_en = burst_start | !burst_cur_wfr0 | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_stb_burst_gated_clk"); @914
gated_clk_cell  x_aq_lsu_stb_burst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (burst_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (burst_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @915
//          .external_en (1'b0), @916
//          .global_en   (1'b1), @917
//          .module_en   (cp0_lsu_icg_en), @918
//          .local_en    (burst_clk_en), @919
//          .clk_out     (burst_clk)); @920

//==============================================================================
//  STB ENTRY INSTANCE
//==============================================================================

// &ConnRule(s/_x$/[0]/); @926
// &ConnRule(s/entryx/entry0/); @927
// &Instance("aq_lsu_stb_entry","x_aq_lsu_stb_entry_0"); @928
aq_lsu_stb_entry  x_aq_lsu_stb_entry_0 (
  .amo_alu_stb_rst         (amo_alu_stb_rst        ),
  .amo_data_ready_x        (amo_data_ready[0]      ),
  .cp0_lsu_dcache_wb       (cp0_lsu_dcache_wb      ),
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .cpurst_b                (cpurst_b               ),
  .dc_hit_stb_addr_wca_x   (dc_hit_stb_addr_wca[0] ),
  .dc_hit_stb_addr_x       (dc_hit_stb_addr[0]     ),
  .dc_hit_stb_dca_x        (dc_hit_stb_dca[0]      ),
  .dc_hit_stb_full_x       (dc_hit_stb_full[0]     ),
  .dc_hit_stb_idx_x        (dc_hit_stb_idx[0]      ),
  .dc_hit_stb_part_x       (dc_hit_stb_part[0]     ),
  .dc_xx_bytes_vld         (dc_xx_bytes_vld        ),
  .dc_xx_pa                (dc_xx_pa               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_lsu_warm_up         (ifu_lsu_warm_up        ),
  .lfb_done_x              (lfb_done[0]            ),
  .lfb_err                 (lfb_err                ),
  .lfb_fifo                (lfb_fifo               ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pfb_hit_stb_idx_x       (pfb_hit_stb_idx[0]     ),
  .pfb_xx_pa               (pfb_xx_pa              ),
  .stb_create_age          (stb_create_age         ),
  .stb_create_alct         (stb_create_alct        ),
  .stb_create_alias_idx    (stb_create_alias_idx   ),
  .stb_create_amo_inst     (stb_create_amo_inst    ),
  .stb_create_attr         (stb_create_attr        ),
  .stb_create_bytes_vld    (stb_create_bytes_vld   ),
  .stb_create_cache_hit    (stb_create_cache_hit   ),
  .stb_create_data         (stb_create_data        ),
  .stb_create_dca_inst     (stb_create_dca_inst    ),
  .stb_create_dca_type     (stb_create_dca_type    ),
  .stb_create_en_gate_x    (stb_create_en_gate[0]  ),
  .stb_create_en_x         (stb_create_en[0]       ),
  .stb_create_lock         (stb_create_lock        ),
  .stb_create_pa           (stb_create_pa          ),
  .stb_create_priv_mode    (stb_create_priv_mode   ),
  .stb_create_shift        (stb_create_shift       ),
  .stb_create_size         (stb_create_size        ),
  .stb_create_src2_depd    (stb_create_src2_depd   ),
  .stb_create_src2_reg     (stb_create_src2_reg    ),
  .stb_create_virt_idx     (stb_create_virt_idx    ),
  .stb_create_wait_lfb     (stb_create_wait_lfb    ),
  .stb_create_way          (stb_create_way         ),
  .stb_dca_done_x          (stb_dca_done[0]        ),
  .stb_dca_grant_x         (stb_dca_grant[0]       ),
  .stb_entry_biu_req_x     (stb_entry_biu_req[0]   ),
  .stb_entry_dcache_req_x  (stb_entry_dcache_req[0]),
  .stb_entry_fwd_vld_x     (stb_entry_fwd_vld[0]   ),
  .stb_entry_merge_en_x    (stb_entry_merge_en[0]  ),
  .stb_entry_pop_vld_x     (stb_entry_pop_vld[0]   ),
  .stb_entry_rdl_req_x     (stb_entry_rdl_req[0]   ),
  .stb_entry_so_vld_x      (stb_entry_so_vld[0]    ),
  .stb_entry_src2_depd_x   (stb_entry_src2_depd[0] ),
  .stb_entry_vld_x         (stb_entry_vld[0]       ),
  .stb_entryx_age          (stb_entry0_age         ),
  .stb_entryx_bytes_vld    (stb_entry0_bytes_vld   ),
  .stb_entryx_cache        (stb_entry0_cache       ),
  .stb_entryx_data         (stb_entry0_data        ),
  .stb_entryx_dbginfo      (stb_entry0_dbginfo     ),
  .stb_entryx_dca_idx      (stb_entry0_dca_idx     ),
  .stb_entryx_dca_type     (stb_entry0_dca_type    ),
  .stb_entryx_dca_way      (stb_entry0_dca_way     ),
  .stb_entryx_idx          (stb_entry0_idx         ),
  .stb_entryx_pa           (stb_entry0_pa          ),
  .stb_entryx_prot         (stb_entry0_prot        ),
  .stb_entryx_size         (stb_entry0_size        ),
  .stb_entryx_user         (stb_entry0_user        ),
  .stb_entryx_way          (stb_entry0_way         ),
  .stb_merge_finish_x      (stb_merge_finish[0]    ),
  .stb_merge_req           (stb_merge_req          ),
  .stb_merge_req_gate      (stb_merge_req_gate     ),
  .stb_pop_en              (stb_pop_en             ),
  .stb_wbus_cmplt_x        (stb_wbus_cmplt[0]      ),
  .stb_wca_grant_x         (stb_wca_grant[0]       ),
  .vlsu_lsu_fwd_data       (vlsu_lsu_fwd_data      ),
  .vlsu_lsu_fwd_dest_reg   (vlsu_lsu_fwd_dest_reg  ),
  .vlsu_lsu_fwd_vld        (vlsu_lsu_fwd_vld       )
);


// &ConnRule(s/_x$/[1]/); @930
// &ConnRule(s/entryx/entry1/); @931
// &Instance("aq_lsu_stb_entry","x_aq_lsu_stb_entry_1"); @932
aq_lsu_stb_entry  x_aq_lsu_stb_entry_1 (
  .amo_alu_stb_rst         (amo_alu_stb_rst        ),
  .amo_data_ready_x        (amo_data_ready[1]      ),
  .cp0_lsu_dcache_wb       (cp0_lsu_dcache_wb      ),
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .cpurst_b                (cpurst_b               ),
  .dc_hit_stb_addr_wca_x   (dc_hit_stb_addr_wca[1] ),
  .dc_hit_stb_addr_x       (dc_hit_stb_addr[1]     ),
  .dc_hit_stb_dca_x        (dc_hit_stb_dca[1]      ),
  .dc_hit_stb_full_x       (dc_hit_stb_full[1]     ),
  .dc_hit_stb_idx_x        (dc_hit_stb_idx[1]      ),
  .dc_hit_stb_part_x       (dc_hit_stb_part[1]     ),
  .dc_xx_bytes_vld         (dc_xx_bytes_vld        ),
  .dc_xx_pa                (dc_xx_pa               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_lsu_warm_up         (ifu_lsu_warm_up        ),
  .lfb_done_x              (lfb_done[1]            ),
  .lfb_err                 (lfb_err                ),
  .lfb_fifo                (lfb_fifo               ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pfb_hit_stb_idx_x       (pfb_hit_stb_idx[1]     ),
  .pfb_xx_pa               (pfb_xx_pa              ),
  .stb_create_age          (stb_create_age         ),
  .stb_create_alct         (stb_create_alct        ),
  .stb_create_alias_idx    (stb_create_alias_idx   ),
  .stb_create_amo_inst     (stb_create_amo_inst    ),
  .stb_create_attr         (stb_create_attr        ),
  .stb_create_bytes_vld    (stb_create_bytes_vld   ),
  .stb_create_cache_hit    (stb_create_cache_hit   ),
  .stb_create_data         (stb_create_data        ),
  .stb_create_dca_inst     (stb_create_dca_inst    ),
  .stb_create_dca_type     (stb_create_dca_type    ),
  .stb_create_en_gate_x    (stb_create_en_gate[1]  ),
  .stb_create_en_x         (stb_create_en[1]       ),
  .stb_create_lock         (stb_create_lock        ),
  .stb_create_pa           (stb_create_pa          ),
  .stb_create_priv_mode    (stb_create_priv_mode   ),
  .stb_create_shift        (stb_create_shift       ),
  .stb_create_size         (stb_create_size        ),
  .stb_create_src2_depd    (stb_create_src2_depd   ),
  .stb_create_src2_reg     (stb_create_src2_reg    ),
  .stb_create_virt_idx     (stb_create_virt_idx    ),
  .stb_create_wait_lfb     (stb_create_wait_lfb    ),
  .stb_create_way          (stb_create_way         ),
  .stb_dca_done_x          (stb_dca_done[1]        ),
  .stb_dca_grant_x         (stb_dca_grant[1]       ),
  .stb_entry_biu_req_x     (stb_entry_biu_req[1]   ),
  .stb_entry_dcache_req_x  (stb_entry_dcache_req[1]),
  .stb_entry_fwd_vld_x     (stb_entry_fwd_vld[1]   ),
  .stb_entry_merge_en_x    (stb_entry_merge_en[1]  ),
  .stb_entry_pop_vld_x     (stb_entry_pop_vld[1]   ),
  .stb_entry_rdl_req_x     (stb_entry_rdl_req[1]   ),
  .stb_entry_so_vld_x      (stb_entry_so_vld[1]    ),
  .stb_entry_src2_depd_x   (stb_entry_src2_depd[1] ),
  .stb_entry_vld_x         (stb_entry_vld[1]       ),
  .stb_entryx_age          (stb_entry1_age         ),
  .stb_entryx_bytes_vld    (stb_entry1_bytes_vld   ),
  .stb_entryx_cache        (stb_entry1_cache       ),
  .stb_entryx_data         (stb_entry1_data        ),
  .stb_entryx_dbginfo      (stb_entry1_dbginfo     ),
  .stb_entryx_dca_idx      (stb_entry1_dca_idx     ),
  .stb_entryx_dca_type     (stb_entry1_dca_type    ),
  .stb_entryx_dca_way      (stb_entry1_dca_way     ),
  .stb_entryx_idx          (stb_entry1_idx         ),
  .stb_entryx_pa           (stb_entry1_pa          ),
  .stb_entryx_prot         (stb_entry1_prot        ),
  .stb_entryx_size         (stb_entry1_size        ),
  .stb_entryx_user         (stb_entry1_user        ),
  .stb_entryx_way          (stb_entry1_way         ),
  .stb_merge_finish_x      (stb_merge_finish[1]    ),
  .stb_merge_req           (stb_merge_req          ),
  .stb_merge_req_gate      (stb_merge_req_gate     ),
  .stb_pop_en              (stb_pop_en             ),
  .stb_wbus_cmplt_x        (stb_wbus_cmplt[1]      ),
  .stb_wca_grant_x         (stb_wca_grant[1]       ),
  .vlsu_lsu_fwd_data       (vlsu_lsu_fwd_data      ),
  .vlsu_lsu_fwd_dest_reg   (vlsu_lsu_fwd_dest_reg  ),
  .vlsu_lsu_fwd_vld        (vlsu_lsu_fwd_vld       )
);


// &ConnRule(s/_x$/[2]/); @934
// &ConnRule(s/entryx/entry2/); @935
// &Instance("aq_lsu_stb_entry","x_aq_lsu_stb_entry_2"); @936
aq_lsu_stb_entry  x_aq_lsu_stb_entry_2 (
  .amo_alu_stb_rst         (amo_alu_stb_rst        ),
  .amo_data_ready_x        (amo_data_ready[2]      ),
  .cp0_lsu_dcache_wb       (cp0_lsu_dcache_wb      ),
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .cpurst_b                (cpurst_b               ),
  .dc_hit_stb_addr_wca_x   (dc_hit_stb_addr_wca[2] ),
  .dc_hit_stb_addr_x       (dc_hit_stb_addr[2]     ),
  .dc_hit_stb_dca_x        (dc_hit_stb_dca[2]      ),
  .dc_hit_stb_full_x       (dc_hit_stb_full[2]     ),
  .dc_hit_stb_idx_x        (dc_hit_stb_idx[2]      ),
  .dc_hit_stb_part_x       (dc_hit_stb_part[2]     ),
  .dc_xx_bytes_vld         (dc_xx_bytes_vld        ),
  .dc_xx_pa                (dc_xx_pa               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_lsu_warm_up         (ifu_lsu_warm_up        ),
  .lfb_done_x              (lfb_done[2]            ),
  .lfb_err                 (lfb_err                ),
  .lfb_fifo                (lfb_fifo               ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pfb_hit_stb_idx_x       (pfb_hit_stb_idx[2]     ),
  .pfb_xx_pa               (pfb_xx_pa              ),
  .stb_create_age          (stb_create_age         ),
  .stb_create_alct         (stb_create_alct        ),
  .stb_create_alias_idx    (stb_create_alias_idx   ),
  .stb_create_amo_inst     (stb_create_amo_inst    ),
  .stb_create_attr         (stb_create_attr        ),
  .stb_create_bytes_vld    (stb_create_bytes_vld   ),
  .stb_create_cache_hit    (stb_create_cache_hit   ),
  .stb_create_data         (stb_create_data        ),
  .stb_create_dca_inst     (stb_create_dca_inst    ),
  .stb_create_dca_type     (stb_create_dca_type    ),
  .stb_create_en_gate_x    (stb_create_en_gate[2]  ),
  .stb_create_en_x         (stb_create_en[2]       ),
  .stb_create_lock         (stb_create_lock        ),
  .stb_create_pa           (stb_create_pa          ),
  .stb_create_priv_mode    (stb_create_priv_mode   ),
  .stb_create_shift        (stb_create_shift       ),
  .stb_create_size         (stb_create_size        ),
  .stb_create_src2_depd    (stb_create_src2_depd   ),
  .stb_create_src2_reg     (stb_create_src2_reg    ),
  .stb_create_virt_idx     (stb_create_virt_idx    ),
  .stb_create_wait_lfb     (stb_create_wait_lfb    ),
  .stb_create_way          (stb_create_way         ),
  .stb_dca_done_x          (stb_dca_done[2]        ),
  .stb_dca_grant_x         (stb_dca_grant[2]       ),
  .stb_entry_biu_req_x     (stb_entry_biu_req[2]   ),
  .stb_entry_dcache_req_x  (stb_entry_dcache_req[2]),
  .stb_entry_fwd_vld_x     (stb_entry_fwd_vld[2]   ),
  .stb_entry_merge_en_x    (stb_entry_merge_en[2]  ),
  .stb_entry_pop_vld_x     (stb_entry_pop_vld[2]   ),
  .stb_entry_rdl_req_x     (stb_entry_rdl_req[2]   ),
  .stb_entry_so_vld_x      (stb_entry_so_vld[2]    ),
  .stb_entry_src2_depd_x   (stb_entry_src2_depd[2] ),
  .stb_entry_vld_x         (stb_entry_vld[2]       ),
  .stb_entryx_age          (stb_entry2_age         ),
  .stb_entryx_bytes_vld    (stb_entry2_bytes_vld   ),
  .stb_entryx_cache        (stb_entry2_cache       ),
  .stb_entryx_data         (stb_entry2_data        ),
  .stb_entryx_dbginfo      (stb_entry2_dbginfo     ),
  .stb_entryx_dca_idx      (stb_entry2_dca_idx     ),
  .stb_entryx_dca_type     (stb_entry2_dca_type    ),
  .stb_entryx_dca_way      (stb_entry2_dca_way     ),
  .stb_entryx_idx          (stb_entry2_idx         ),
  .stb_entryx_pa           (stb_entry2_pa          ),
  .stb_entryx_prot         (stb_entry2_prot        ),
  .stb_entryx_size         (stb_entry2_size        ),
  .stb_entryx_user         (stb_entry2_user        ),
  .stb_entryx_way          (stb_entry2_way         ),
  .stb_merge_finish_x      (stb_merge_finish[2]    ),
  .stb_merge_req           (stb_merge_req          ),
  .stb_merge_req_gate      (stb_merge_req_gate     ),
  .stb_pop_en              (stb_pop_en             ),
  .stb_wbus_cmplt_x        (stb_wbus_cmplt[2]      ),
  .stb_wca_grant_x         (stb_wca_grant[2]       ),
  .vlsu_lsu_fwd_data       (vlsu_lsu_fwd_data      ),
  .vlsu_lsu_fwd_dest_reg   (vlsu_lsu_fwd_dest_reg  ),
  .vlsu_lsu_fwd_vld        (vlsu_lsu_fwd_vld       )
);


// &ConnRule(s/_x$/[3]/); @938
// &ConnRule(s/entryx/entry3/); @939
// &Instance("aq_lsu_stb_entry","x_aq_lsu_stb_entry_3"); @940
aq_lsu_stb_entry  x_aq_lsu_stb_entry_3 (
  .amo_alu_stb_rst         (amo_alu_stb_rst        ),
  .amo_data_ready_x        (amo_data_ready[3]      ),
  .cp0_lsu_dcache_wb       (cp0_lsu_dcache_wb      ),
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .cpurst_b                (cpurst_b               ),
  .dc_hit_stb_addr_wca_x   (dc_hit_stb_addr_wca[3] ),
  .dc_hit_stb_addr_x       (dc_hit_stb_addr[3]     ),
  .dc_hit_stb_dca_x        (dc_hit_stb_dca[3]      ),
  .dc_hit_stb_full_x       (dc_hit_stb_full[3]     ),
  .dc_hit_stb_idx_x        (dc_hit_stb_idx[3]      ),
  .dc_hit_stb_part_x       (dc_hit_stb_part[3]     ),
  .dc_xx_bytes_vld         (dc_xx_bytes_vld        ),
  .dc_xx_pa                (dc_xx_pa               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_lsu_warm_up         (ifu_lsu_warm_up        ),
  .lfb_done_x              (lfb_done[3]            ),
  .lfb_err                 (lfb_err                ),
  .lfb_fifo                (lfb_fifo               ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pfb_hit_stb_idx_x       (pfb_hit_stb_idx[3]     ),
  .pfb_xx_pa               (pfb_xx_pa              ),
  .stb_create_age          (stb_create_age         ),
  .stb_create_alct         (stb_create_alct        ),
  .stb_create_alias_idx    (stb_create_alias_idx   ),
  .stb_create_amo_inst     (stb_create_amo_inst    ),
  .stb_create_attr         (stb_create_attr        ),
  .stb_create_bytes_vld    (stb_create_bytes_vld   ),
  .stb_create_cache_hit    (stb_create_cache_hit   ),
  .stb_create_data         (stb_create_data        ),
  .stb_create_dca_inst     (stb_create_dca_inst    ),
  .stb_create_dca_type     (stb_create_dca_type    ),
  .stb_create_en_gate_x    (stb_create_en_gate[3]  ),
  .stb_create_en_x         (stb_create_en[3]       ),
  .stb_create_lock         (stb_create_lock        ),
  .stb_create_pa           (stb_create_pa          ),
  .stb_create_priv_mode    (stb_create_priv_mode   ),
  .stb_create_shift        (stb_create_shift       ),
  .stb_create_size         (stb_create_size        ),
  .stb_create_src2_depd    (stb_create_src2_depd   ),
  .stb_create_src2_reg     (stb_create_src2_reg    ),
  .stb_create_virt_idx     (stb_create_virt_idx    ),
  .stb_create_wait_lfb     (stb_create_wait_lfb    ),
  .stb_create_way          (stb_create_way         ),
  .stb_dca_done_x          (stb_dca_done[3]        ),
  .stb_dca_grant_x         (stb_dca_grant[3]       ),
  .stb_entry_biu_req_x     (stb_entry_biu_req[3]   ),
  .stb_entry_dcache_req_x  (stb_entry_dcache_req[3]),
  .stb_entry_fwd_vld_x     (stb_entry_fwd_vld[3]   ),
  .stb_entry_merge_en_x    (stb_entry_merge_en[3]  ),
  .stb_entry_pop_vld_x     (stb_entry_pop_vld[3]   ),
  .stb_entry_rdl_req_x     (stb_entry_rdl_req[3]   ),
  .stb_entry_so_vld_x      (stb_entry_so_vld[3]    ),
  .stb_entry_src2_depd_x   (stb_entry_src2_depd[3] ),
  .stb_entry_vld_x         (stb_entry_vld[3]       ),
  .stb_entryx_age          (stb_entry3_age         ),
  .stb_entryx_bytes_vld    (stb_entry3_bytes_vld   ),
  .stb_entryx_cache        (stb_entry3_cache       ),
  .stb_entryx_data         (stb_entry3_data        ),
  .stb_entryx_dbginfo      (stb_entry3_dbginfo     ),
  .stb_entryx_dca_idx      (stb_entry3_dca_idx     ),
  .stb_entryx_dca_type     (stb_entry3_dca_type    ),
  .stb_entryx_dca_way      (stb_entry3_dca_way     ),
  .stb_entryx_idx          (stb_entry3_idx         ),
  .stb_entryx_pa           (stb_entry3_pa          ),
  .stb_entryx_prot         (stb_entry3_prot        ),
  .stb_entryx_size         (stb_entry3_size        ),
  .stb_entryx_user         (stb_entry3_user        ),
  .stb_entryx_way          (stb_entry3_way         ),
  .stb_merge_finish_x      (stb_merge_finish[3]    ),
  .stb_merge_req           (stb_merge_req          ),
  .stb_merge_req_gate      (stb_merge_req_gate     ),
  .stb_pop_en              (stb_pop_en             ),
  .stb_wbus_cmplt_x        (stb_wbus_cmplt[3]      ),
  .stb_wca_grant_x         (stb_wca_grant[3]       ),
  .vlsu_lsu_fwd_data       (vlsu_lsu_fwd_data      ),
  .vlsu_lsu_fwd_dest_reg   (vlsu_lsu_fwd_dest_reg  ),
  .vlsu_lsu_fwd_vld        (vlsu_lsu_fwd_vld       )
);


//==============================================================================
//  ASSERTION
//==============================================================================
// &Force("nonport", "stb_empty"); @968
// &Force("nonport", "stb_merge_vld"); @976

// &ModuleEnd; @985
endmodule


