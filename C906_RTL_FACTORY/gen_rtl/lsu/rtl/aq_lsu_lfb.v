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
module aq_lsu_lfb(
  biu_lsu_arready,
  biu_lsu_rdata,
  biu_lsu_rid,
  biu_lsu_rlast,
  biu_lsu_rresp,
  biu_lsu_rvalid,
  cp0_lsu_dcache_wb,
  cp0_lsu_icg_en,
  cpurst_b,
  dc_lfb_alias_hit,
  dc_lfb_alias_idx,
  dc_lfb_amo_func,
  dc_lfb_amo_inst,
  dc_lfb_attr,
  dc_lfb_bytes_vld,
  dc_lfb_ca,
  dc_lfb_create_en,
  dc_lfb_create_en_gate,
  dc_lfb_dest_reg,
  dc_lfb_ele_size,
  dc_lfb_fls,
  dc_lfb_hit_way,
  dc_lfb_inst_ld,
  dc_lfb_lock,
  dc_lfb_pa,
  dc_lfb_priv_mode,
  dc_lfb_ptw,
  dc_lfb_sew,
  dc_lfb_shift,
  dc_lfb_sign_ext,
  dc_lfb_size,
  dc_lfb_split,
  dc_lfb_split_last,
  dc_lfb_st_id,
  dc_lfb_vfunc,
  dc_lfb_virt_idx,
  dc_lfb_vl_val,
  dc_lfb_vls,
  dc_lfb_vsplit_last,
  dc_xx_dest_preg,
  dc_xx_pa,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lfb_arb_data02_idx,
  lfb_arb_data0_req,
  lfb_arb_data13_idx,
  lfb_arb_data1_req,
  lfb_arb_data2_req,
  lfb_arb_data3_req,
  lfb_arb_data_din,
  lfb_arb_data_way,
  lfb_arb_data_wen,
  lfb_arb_dcache_sel,
  lfb_arb_dirty_din,
  lfb_arb_dirty_idx,
  lfb_arb_dirty_req,
  lfb_arb_dirty_wen,
  lfb_arb_tag_din,
  lfb_arb_tag_idx,
  lfb_arb_tag_req,
  lfb_arb_tag_sel,
  lfb_arb_tag_way,
  lfb_arb_tag_wen,
  lfb_dbginfo,
  lfb_dc_amo_func,
  lfb_dc_amo_inst,
  lfb_dc_bus_err,
  lfb_dc_bytes_vld,
  lfb_dc_data,
  lfb_dc_data_shift,
  lfb_dc_data_vld,
  lfb_dc_dest_reg,
  lfb_dc_ele_size,
  lfb_dc_fls,
  lfb_dc_full,
  lfb_dc_hit_addr,
  lfb_dc_hit_idx,
  lfb_dc_hit_preg,
  lfb_dc_lock,
  lfb_dc_mtval,
  lfb_dc_pop_en,
  lfb_dc_ptw,
  lfb_dc_sew,
  lfb_dc_sign_ext,
  lfb_dc_size,
  lfb_dc_so_vld,
  lfb_dc_split,
  lfb_dc_split_first,
  lfb_dc_split_second,
  lfb_dc_stb_id,
  lfb_dc_uncmplt_vreg,
  lfb_dc_vfunc,
  lfb_dc_vl_update,
  lfb_dc_vl_val,
  lfb_dc_vls,
  lfb_dc_vsplit_last,
  lfb_pfb_cache_hit,
  lfb_pfb_cache_miss,
  lfb_pfb_grant,
  lfb_pfb_hit_idx,
  lfb_rdl_alias_hit,
  lfb_rdl_alias_idx,
  lfb_rdl_ca,
  lfb_rdl_id,
  lfb_rdl_idx,
  lfb_rdl_no_ld,
  lfb_rdl_req,
  lfb_rdl_tag,
  lfb_rdl_type,
  lfb_rdl_way,
  lfb_stb_done,
  lfb_stb_err,
  lfb_stb_fifo,
  lfb_stb_id,
  lfb_vb_araddr_5_4,
  lfb_vb_arid,
  lfb_vb_arvalid,
  lfb_vb_rready,
  lfb_xx_idle,
  lfb_xx_no_op,
  lsu_biu_araddr,
  lsu_biu_arburst,
  lsu_biu_arcache,
  lsu_biu_arid,
  lsu_biu_arlen,
  lsu_biu_arprot,
  lsu_biu_arsize,
  lsu_biu_aruser,
  lsu_biu_arvalid,
  pad_yy_icg_scan_en,
  pfb_lfb_id,
  pfb_lfb_pa,
  pfb_lfb_priv_mode,
  pfb_lfb_req,
  pfb_lfb_req_gate,
  pfb_lfb_virt_idx,
  pfb_lfb_wb,
  pfb_xx_pa,
  rdl_lfb_alias_hit,
  rdl_lfb_cache_hit,
  rdl_lfb_cmplt,
  rdl_lfb_grant,
  rdl_lfb_ref_fifo,
  rtu_yy_xx_async_flush,
  vb_lfb_arready,
  vb_lfb_dirty,
  vb_lfb_rdata,
  vb_lfb_rid,
  vb_lfb_rlast,
  vb_lfb_rvalid
);

// &Ports; @21
input            biu_lsu_arready;       
input   [127:0]  biu_lsu_rdata;         
input   [3  :0]  biu_lsu_rid;           
input            biu_lsu_rlast;         
input   [1  :0]  biu_lsu_rresp;         
input            biu_lsu_rvalid;        
input            cp0_lsu_dcache_wb;     
input            cp0_lsu_icg_en;        
input            cpurst_b;              
input            dc_lfb_alias_hit;      
input   [1  :0]  dc_lfb_alias_idx;      
input   [4  :0]  dc_lfb_amo_func;       
input            dc_lfb_amo_inst;       
input   [2  :0]  dc_lfb_attr;           
input   [7  :0]  dc_lfb_bytes_vld;      
input            dc_lfb_ca;             
input            dc_lfb_create_en;      
input            dc_lfb_create_en_gate; 
input   [5  :0]  dc_lfb_dest_reg;       
input   [1  :0]  dc_lfb_ele_size;       
input            dc_lfb_fls;            
input   [3  :0]  dc_lfb_hit_way;        
input            dc_lfb_inst_ld;        
input            dc_lfb_lock;           
input   [39 :0]  dc_lfb_pa;             
input   [1  :0]  dc_lfb_priv_mode;      
input            dc_lfb_ptw;            
input   [1  :0]  dc_lfb_sew;            
input   [3  :0]  dc_lfb_shift;          
input            dc_lfb_sign_ext;       
input   [1  :0]  dc_lfb_size;           
input            dc_lfb_split;          
input            dc_lfb_split_last;     
input   [1  :0]  dc_lfb_st_id;          
input   [7  :0]  dc_lfb_vfunc;          
input   [1  :0]  dc_lfb_virt_idx;       
input   [6  :0]  dc_lfb_vl_val;         
input            dc_lfb_vls;            
input            dc_lfb_vsplit_last;    
input   [5  :0]  dc_xx_dest_preg;       
input   [39 :0]  dc_xx_pa;              
input            forever_cpuclk;        
input            ifu_lsu_warm_up;       
input            pad_yy_icg_scan_en;    
input   [4  :0]  pfb_lfb_id;            
input   [39 :0]  pfb_lfb_pa;            
input   [1  :0]  pfb_lfb_priv_mode;     
input            pfb_lfb_req;           
input            pfb_lfb_req_gate;      
input   [1  :0]  pfb_lfb_virt_idx;      
input            pfb_lfb_wb;            
input   [39 :0]  pfb_xx_pa;             
input            rdl_lfb_alias_hit;     
input            rdl_lfb_cache_hit;     
input            rdl_lfb_cmplt;         
input            rdl_lfb_grant;         
input   [3  :0]  rdl_lfb_ref_fifo;      
input            rtu_yy_xx_async_flush; 
input            vb_lfb_arready;        
input            vb_lfb_dirty;          
input   [127:0]  vb_lfb_rdata;          
input   [3  :0]  vb_lfb_rid;            
input            vb_lfb_rlast;          
input            vb_lfb_rvalid;         
output  [13 :0]  lfb_arb_data02_idx;    
output           lfb_arb_data0_req;     
output  [13 :0]  lfb_arb_data13_idx;    
output           lfb_arb_data1_req;     
output           lfb_arb_data2_req;     
output           lfb_arb_data3_req;     
output  [127:0]  lfb_arb_data_din;      
output  [3  :0]  lfb_arb_data_way;      
output  [7  :0]  lfb_arb_data_wen;      
output           lfb_arb_dcache_sel;    
output  [7  :0]  lfb_arb_dirty_din;     
output  [13 :0]  lfb_arb_dirty_idx;     
output           lfb_arb_dirty_req;     
output  [7  :0]  lfb_arb_dirty_wen;     
output  [29 :0]  lfb_arb_tag_din;       
output  [11 :0]  lfb_arb_tag_idx;       
output           lfb_arb_tag_req;       
output  [3  :0]  lfb_arb_tag_sel;       
output  [3  :0]  lfb_arb_tag_way;       
output           lfb_arb_tag_wen;       
output  [55 :0]  lfb_dbginfo;           
output  [4  :0]  lfb_dc_amo_func;       
output           lfb_dc_amo_inst;       
output           lfb_dc_bus_err;        
output  [7  :0]  lfb_dc_bytes_vld;      
output  [63 :0]  lfb_dc_data;           
output  [3  :0]  lfb_dc_data_shift;     
output           lfb_dc_data_vld;       
output  [5  :0]  lfb_dc_dest_reg;       
output  [1  :0]  lfb_dc_ele_size;       
output           lfb_dc_fls;            
output           lfb_dc_full;           
output           lfb_dc_hit_addr;       
output           lfb_dc_hit_idx;        
output           lfb_dc_hit_preg;       
output           lfb_dc_lock;           
output  [39 :0]  lfb_dc_mtval;          
output           lfb_dc_pop_en;         
output           lfb_dc_ptw;            
output  [1  :0]  lfb_dc_sew;            
output           lfb_dc_sign_ext;       
output  [1  :0]  lfb_dc_size;           
output           lfb_dc_so_vld;         
output           lfb_dc_split;          
output           lfb_dc_split_first;    
output           lfb_dc_split_second;   
output  [1  :0]  lfb_dc_stb_id;         
output           lfb_dc_uncmplt_vreg;   
output  [7  :0]  lfb_dc_vfunc;          
output           lfb_dc_vl_update;      
output  [6  :0]  lfb_dc_vl_val;         
output           lfb_dc_vls;            
output           lfb_dc_vsplit_last;    
output  [4  :0]  lfb_pfb_cache_hit;     
output  [4  :0]  lfb_pfb_cache_miss;    
output           lfb_pfb_grant;         
output           lfb_pfb_hit_idx;       
output           lfb_rdl_alias_hit;     
output  [1  :0]  lfb_rdl_alias_idx;     
output           lfb_rdl_ca;            
output  [2  :0]  lfb_rdl_id;            
output  [13 :0]  lfb_rdl_idx;           
output           lfb_rdl_no_ld;         
output           lfb_rdl_req;           
output  [27 :0]  lfb_rdl_tag;           
output  [1  :0]  lfb_rdl_type;          
output  [3  :0]  lfb_rdl_way;           
output           lfb_stb_done;          
output           lfb_stb_err;           
output  [3  :0]  lfb_stb_fifo;          
output  [1  :0]  lfb_stb_id;            
output  [1  :0]  lfb_vb_araddr_5_4;     
output  [2  :0]  lfb_vb_arid;           
output           lfb_vb_arvalid;        
output           lfb_vb_rready;         
output           lfb_xx_idle;           
output           lfb_xx_no_op;          
output  [39 :0]  lsu_biu_araddr;        
output  [1  :0]  lsu_biu_arburst;       
output  [3  :0]  lsu_biu_arcache;       
output  [3  :0]  lsu_biu_arid;          
output  [1  :0]  lsu_biu_arlen;         
output  [2  :0]  lsu_biu_arprot;        
output  [2  :0]  lsu_biu_arsize;        
output           lsu_biu_aruser;        
output           lsu_biu_arvalid;       

// &Regs; @22
reg     [54 :0]  arbus;                 
reg     [36 :0]  ldbus;                 
reg     [3  :0]  lfb_bus_ptr;           
reg     [3  :0]  lfb_create_ptr;        
reg     [3  :0]  lfb_pop_ptr;           
reg     [2  :0]  lfb_rdl_ptr;           
reg     [39 :0]  mtval;                 
reg     [127:0]  rdata;                 
reg              rdirty;                
reg     [50 :0]  rdl_bus;               
reg     [44 :0]  refbus;                
reg     [2:0]  rid_fifo  [7:0]; 
reg     [2  :0]  rid_fifo_create_ptr;   
reg     [2  :0]  rid_fifo_pop_ptr;      
reg     [7  :0]  rid_final;             
reg     [1  :0]  rresp;                 
reg              rvalid;                
reg     [2  :0]  so_rid;                
reg     [6  :0]  stbus;                 
reg     [20 :0]  vldbus;                

// &Wires; @23
wire             ar_ld;                 
wire             ar_wo;                 
wire    [127:0]  arb_rdata;             
wire             arb_rdirty;            
wire    [3  :0]  arb_rid;               
wire             arb_rlast;             
wire    [1  :0]  arb_rresp;             
wire             arb_rvalid;            
wire    [3  :0]  arid_ld;               
wire             arready;               
wire             biu_ld_wo;             
wire             biu_lsu_arready;       
wire    [127:0]  biu_lsu_rdata;         
wire    [3  :0]  biu_lsu_rid;           
wire             biu_lsu_rlast;         
wire    [1  :0]  biu_lsu_rresp;         
wire             biu_lsu_rvalid;        
wire             bus_acc_err;           
wire    [7  :0]  bus_cmplt;             
wire    [7  :0]  bus_grant;             
wire             bus_ptr_inc;           
wire             bus_req;               
wire             cp0_lsu_dcache_wb;     
wire             cp0_lsu_icg_en;        
wire             cpurst_b;              
wire             data02_addr_3;         
wire             data13_addr_3;         
wire    [1  :0]  data_sel;              
wire    [7  :0]  dc_hit_lfb_addr;       
wire    [7  :0]  dc_hit_lfb_idx;        
wire    [7  :0]  dc_hit_lfb_preg;       
wire    [7  :0]  dc_hit_lfb_so;         
wire    [7  :0]  dc_hit_lfb_vreg;       
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
wire             dc_sel;                
wire    [5  :0]  dc_xx_dest_preg;       
wire    [39 :0]  dc_xx_pa;              
wire             forever_cpuclk;        
wire             ifu_lsu_warm_up;       
wire    [7  :0]  ld_sel;                
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
wire             lfb_clk;               
wire             lfb_clk_en;            
wire             lfb_create_alias_hit;  
wire    [1  :0]  lfb_create_alias_idx;  
wire    [3  :0]  lfb_create_alias_way;  
wire    [4  :0]  lfb_create_amo_func;   
wire             lfb_create_amo_inst;   
wire    [2  :0]  lfb_create_attr;       
wire    [7  :0]  lfb_create_bytes_vld;  
wire             lfb_create_ca;         
wire    [5  :0]  lfb_create_dest_reg;   
wire    [1  :0]  lfb_create_ele_size;   
wire    [7  :0]  lfb_create_en;         
wire    [7  :0]  lfb_create_en_gate;    
wire             lfb_create_fls;        
wire             lfb_create_ld;         
wire             lfb_create_lock;       
wire    [39 :0]  lfb_create_pa;         
wire             lfb_create_pf;         
wire    [4  :0]  lfb_create_pfb_id;     
wire    [1  :0]  lfb_create_priv_mode;  
wire             lfb_create_ptw;        
wire    [7  :0]  lfb_create_sel;        
wire    [1  :0]  lfb_create_sew;        
wire    [3  :0]  lfb_create_shift;      
wire             lfb_create_sign_ext;   
wire    [1  :0]  lfb_create_size;       
wire             lfb_create_split;      
wire             lfb_create_split_last; 
wire    [1  :0]  lfb_create_stbid;      
wire    [7  :0]  lfb_create_vfunc;      
wire    [1  :0]  lfb_create_virt_idx;   
wire    [6  :0]  lfb_create_vl_val;     
wire             lfb_create_vld;        
wire             lfb_create_vld_gate;   
wire             lfb_create_vls;        
wire             lfb_create_vsplit_last; 
wire             lfb_create_wb;         
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
wire    [54 :0]  lfb_entry0_arbus;      
wire    [6  :0]  lfb_entry0_dbginfo;    
wire    [36 :0]  lfb_entry0_ldbus;      
wire    [39 :0]  lfb_entry0_mtval;      
wire    [50 :0]  lfb_entry0_rdl_bus;    
wire    [44 :0]  lfb_entry0_refbus;     
wire    [6  :0]  lfb_entry0_stbus;      
wire    [20 :0]  lfb_entry0_vldbus;     
wire    [54 :0]  lfb_entry1_arbus;      
wire    [6  :0]  lfb_entry1_dbginfo;    
wire    [36 :0]  lfb_entry1_ldbus;      
wire    [39 :0]  lfb_entry1_mtval;      
wire    [50 :0]  lfb_entry1_rdl_bus;    
wire    [44 :0]  lfb_entry1_refbus;     
wire    [6  :0]  lfb_entry1_stbus;      
wire    [20 :0]  lfb_entry1_vldbus;     
wire    [54 :0]  lfb_entry2_arbus;      
wire    [6  :0]  lfb_entry2_dbginfo;    
wire    [36 :0]  lfb_entry2_ldbus;      
wire    [39 :0]  lfb_entry2_mtval;      
wire    [50 :0]  lfb_entry2_rdl_bus;    
wire    [44 :0]  lfb_entry2_refbus;     
wire    [6  :0]  lfb_entry2_stbus;      
wire    [20 :0]  lfb_entry2_vldbus;     
wire    [54 :0]  lfb_entry3_arbus;      
wire    [6  :0]  lfb_entry3_dbginfo;    
wire    [36 :0]  lfb_entry3_ldbus;      
wire    [39 :0]  lfb_entry3_mtval;      
wire    [50 :0]  lfb_entry3_rdl_bus;    
wire    [44 :0]  lfb_entry3_refbus;     
wire    [6  :0]  lfb_entry3_stbus;      
wire    [20 :0]  lfb_entry3_vldbus;     
wire    [54 :0]  lfb_entry4_arbus;      
wire    [6  :0]  lfb_entry4_dbginfo;    
wire    [36 :0]  lfb_entry4_ldbus;      
wire    [39 :0]  lfb_entry4_mtval;      
wire    [50 :0]  lfb_entry4_rdl_bus;    
wire    [44 :0]  lfb_entry4_refbus;     
wire    [6  :0]  lfb_entry4_stbus;      
wire    [20 :0]  lfb_entry4_vldbus;     
wire    [54 :0]  lfb_entry5_arbus;      
wire    [6  :0]  lfb_entry5_dbginfo;    
wire    [36 :0]  lfb_entry5_ldbus;      
wire    [39 :0]  lfb_entry5_mtval;      
wire    [50 :0]  lfb_entry5_rdl_bus;    
wire    [44 :0]  lfb_entry5_refbus;     
wire    [6  :0]  lfb_entry5_stbus;      
wire    [20 :0]  lfb_entry5_vldbus;     
wire    [54 :0]  lfb_entry6_arbus;      
wire    [6  :0]  lfb_entry6_dbginfo;    
wire    [36 :0]  lfb_entry6_ldbus;      
wire    [39 :0]  lfb_entry6_mtval;      
wire    [50 :0]  lfb_entry6_rdl_bus;    
wire    [44 :0]  lfb_entry6_refbus;     
wire    [6  :0]  lfb_entry6_stbus;      
wire    [20 :0]  lfb_entry6_vldbus;     
wire    [54 :0]  lfb_entry7_arbus;      
wire    [6  :0]  lfb_entry7_dbginfo;    
wire    [36 :0]  lfb_entry7_ldbus;      
wire    [39 :0]  lfb_entry7_mtval;      
wire    [50 :0]  lfb_entry7_rdl_bus;    
wire    [44 :0]  lfb_entry7_refbus;     
wire    [6  :0]  lfb_entry7_stbus;      
wire    [20 :0]  lfb_entry7_vldbus;     
wire    [7  :0]  lfb_entry_arvalid;     
wire    [7  :0]  lfb_entry_bus_rdy;     
wire    [7  :0]  lfb_entry_ld_wo_stall; 
wire    [7  :0]  lfb_entry_pop_en;      
wire    [7  :0]  lfb_entry_rdl_req;     
wire    [7  :0]  lfb_entry_ref_done;    
wire    [7  :0]  lfb_entry_vld;         
wire    [7  :0]  lfb_entry_wb_en;       
wire             lfb_fof_not_first;     
wire             lfb_full;              
wire    [4  :0]  lfb_pfb_cache_hit;     
wire    [4  :0]  lfb_pfb_cache_miss;    
wire             lfb_pfb_grant;         
wire             lfb_pfb_hit_idx;       
wire    [4  :0]  lfb_pfb_id;            
wire             lfb_pop_vld;           
wire             lfb_rclk;              
wire             lfb_rclk_en;           
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
wire             lfb_rid_clk;           
wire             lfb_rid_clk_en;        
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
wire    [39 :0]  lsu_biu_araddr;        
wire    [1  :0]  lsu_biu_arburst;       
wire    [3  :0]  lsu_biu_arcache;       
wire    [3  :0]  lsu_biu_arid;          
wire    [1  :0]  lsu_biu_arlen;         
wire    [2  :0]  lsu_biu_arprot;        
wire    [2  :0]  lsu_biu_arsize;        
wire             lsu_biu_aruser;        
wire             lsu_biu_arvalid;       
wire             pad_yy_icg_scan_en;    
wire    [7  :0]  pfb_hit_lfb_idx;       
wire    [4  :0]  pfb_lfb_id;            
wire    [39 :0]  pfb_lfb_pa;            
wire    [1  :0]  pfb_lfb_priv_mode;     
wire             pfb_lfb_req;           
wire             pfb_lfb_req_gate;      
wire    [1  :0]  pfb_lfb_virt_idx;      
wire             pfb_lfb_wb;            
wire    [39 :0]  pfb_xx_pa;             
wire             rd_req;                
wire    [7  :0]  rdl_cmplt;             
wire    [7  :0]  rdl_grant;             
wire             rdl_lfb_alias_hit;     
wire             rdl_lfb_cache_hit;     
wire             rdl_lfb_cmplt;         
wire             rdl_lfb_grant;         
wire             rdl_lfb_pf_vld;        
wire    [3  :0]  rdl_lfb_ref_fifo;      
wire    [7  :0]  rdl_lfb_sel;           
wire             rdl_ptr_inc;           
wire    [1  :0]  ref_cnt;               
wire             ref_dirty;             
wire             ref_first;             
wire             ref_fourth;            
wire    [1  :0]  ref_offset;            
wire    [7  :0]  ref_sel;               
wire    [39 :0]  ref_tag;               
wire             ref_vld;               
wire             rid_fifo_create_en;    
wire             rid_fifo_pop_en;       
wire    [2  :0]  rid_pf_so;             
wire    [2  :0]  rid_sel;               
wire             rtu_yy_xx_async_flush; 
wire             vb_lfb_arready;        
wire             vb_lfb_dirty;          
wire    [127:0]  vb_lfb_rdata;          
wire    [3  :0]  vb_lfb_rid;            
wire             vb_lfb_rlast;          
wire             vb_lfb_rvalid;         
wire             vb_req;                
wire             way0_way2_sel;         


parameter PADDR = 40;
parameter DEPTH = 8;

//================================================
//  DC and prefetch request arbit  
//================================================
assign dc_sel  = dc_lfb_create_en_gate;

assign lfb_create_vld            = dc_sel ? dc_lfb_create_en : pfb_lfb_req;
assign lfb_create_vld_gate       = dc_sel ? dc_lfb_create_en_gate : pfb_lfb_req_gate;
assign lfb_create_pa[PADDR-1:0]  = dc_sel ? dc_lfb_pa[PADDR-1:0] : pfb_lfb_pa[PADDR-1:0];
assign lfb_create_virt_idx[1:0]  = dc_sel ? dc_lfb_virt_idx[1:0] : pfb_lfb_virt_idx[1:0];
assign lfb_create_wb             = dc_sel ? cp0_lsu_dcache_wb : pfb_lfb_wb;
assign lfb_create_priv_mode[1:0] = dc_sel ? dc_lfb_priv_mode[1:0] : pfb_lfb_priv_mode[1:0];
assign lfb_create_attr[2:0]      = dc_sel ? dc_lfb_attr[2:0] : 3'b101; //bufable+weak order+cacheable
assign lfb_create_ca             = dc_sel ? dc_lfb_ca : 1'b1;
//for wb to RF
assign lfb_create_sign_ext       = dc_lfb_sign_ext;
assign lfb_create_dest_reg[5:0]  = dc_lfb_dest_reg[5:0];
assign lfb_create_bytes_vld[`LSU_BYTEW-1:0] = dc_lfb_bytes_vld[`LSU_BYTEW-1:0];
assign lfb_create_vls            = dc_lfb_vls;
assign lfb_create_fls            = dc_lfb_fls;
assign lfb_create_lock           = dc_lfb_lock;
assign lfb_create_ptw            = dc_lfb_ptw;
assign lfb_create_split          = dc_lfb_split;
assign lfb_create_split_last     = dc_lfb_split_last;
assign lfb_create_size[1:0]      = dc_lfb_size[1:0];
assign lfb_create_shift[3:0]     = dc_lfb_shift[3:0];
assign lfb_create_amo_inst       = dc_lfb_amo_inst;
assign lfb_create_amo_func[4:0]  = dc_lfb_amo_func[4:0];
//for stb
assign lfb_create_ld             = dc_lfb_inst_ld;
assign lfb_create_stbid[1:0]     = dc_lfb_st_id[1:0];
//for alias
assign lfb_create_alias_hit      = dc_lfb_alias_hit;
assign lfb_create_alias_idx[1:0] = dc_lfb_alias_idx[1:0];
assign lfb_create_alias_way[3:0] = dc_lfb_hit_way[3:0];
//indicate prefetch
assign lfb_create_pf             = !dc_sel;

assign lfb_create_sew[1:0]       = dc_lfb_sew[1:0];
assign lfb_create_ele_size[1:0]  = dc_lfb_ele_size[1:0];
assign lfb_create_vfunc[7:0]     = dc_lfb_vfunc[7:0];
assign lfb_create_vl_val[6:0]    = dc_lfb_vl_val[6:0];
assign lfb_create_vsplit_last    = dc_lfb_vsplit_last;

//for pfb feedback
assign lfb_create_pfb_id[4:0]    = pfb_lfb_id[4:0];

//================================================
//  dependency check
//================================================

assign lfb_full            = (lfb_pop_ptr[2:0] == lfb_create_ptr[2:0]) & 
                             (lfb_pop_ptr[3] ^ lfb_create_ptr[3]);

assign lfb_dc_full         = lfb_full;
assign lfb_dc_hit_idx      = |dc_hit_lfb_idx[DEPTH-1:0];
assign lfb_dc_hit_addr     = |dc_hit_lfb_addr[DEPTH-1:0];
assign lfb_dc_so_vld       = |dc_hit_lfb_so[DEPTH-1:0];
assign lfb_dc_hit_preg     = |dc_hit_lfb_preg[DEPTH-1:0];
assign lfb_dc_uncmplt_vreg = |dc_hit_lfb_vreg[DEPTH-1:0];
assign lfb_dc_pop_en       = |lfb_entry_pop_en[DEPTH-1:0];

assign lfb_pfb_hit_idx     = |pfb_hit_lfb_idx[DEPTH-1:0];
assign lfb_pfb_grant       = !lfb_full & !dc_sel;

assign lfb_xx_no_op        = ~(|(lfb_entry_vld[DEPTH-1:0] & lfb_entry_wb_en[DEPTH-1:0]));
assign lfb_xx_idle         = ~(|lfb_entry_vld[DEPTH-1:0]);

//================================================
//  lfb create pointer
//================================================

always@(posedge lfb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_create_ptr[3:0] <= 4'b0;
  else if (lfb_create_vld)
    lfb_create_ptr[3:0] <= lfb_create_ptr[3:0] + 4'b001; 
end

assign lfb_create_sel[DEPTH-1:0]     = 8'b1 << lfb_create_ptr[2:0];
assign lfb_create_en[DEPTH-1:0]      = lfb_create_sel[DEPTH-1:0] & {DEPTH{lfb_create_vld}};
assign lfb_create_en_gate[DEPTH-1:0] = lfb_create_sel[DEPTH-1:0] & {DEPTH{lfb_create_vld_gate & !lfb_full}};

assign lfb_pop_vld = lfb_entry_pop_en[lfb_pop_ptr[2:0]] |
                     (lfb_pop_ptr[3:0] != lfb_create_ptr[3:0]) & !lfb_entry_vld[lfb_pop_ptr[2:0]];

always@(posedge lfb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_pop_ptr[3:0] <= 4'b0;
  else if (lfb_pop_vld)
    lfb_pop_ptr[3:0] <= lfb_pop_ptr[3:0] + 4'b001;
end

//================================================
//  lfb_rdl_request 
//================================================
parameter RDL_PF     = 0;
parameter RDL_LD     = 1;
parameter RDL_AIDX_0 = 2;
parameter RDL_AIDX_1 = 3;
parameter RDL_VIDX_0 = 4;
parameter RDL_VIDX_1 = 5;
parameter RDL_PA_6   = 6;
parameter RDL_PA_11  = 11;
parameter RDL_PA_12  = 12;
parameter RDL_PA_39  = 39;
parameter RDL_AHIT   = 40;
parameter RDL_WAY_0  = 41;
parameter RDL_WAY_3  = 44;
parameter RDL_CA     = 45;
parameter RDL_PFB_ID = 46;
parameter RDL_WIDTH  = 51;

assign rdl_ptr_inc = rdl_lfb_cmplt;

always@(posedge lfb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_rdl_ptr[2:0] <= 3'b0;
  else if (rdl_ptr_inc)
    lfb_rdl_ptr[2:0] <= lfb_rdl_ptr[2:0] + 3'b1;
end

// &CombBeg; @152
always @( lfb_entry5_rdl_bus[50:0]
       or lfb_entry2_rdl_bus[50:0]
       or lfb_entry3_rdl_bus[50:0]
       or lfb_entry1_rdl_bus[50:0]
       or lfb_entry0_rdl_bus[50:0]
       or lfb_entry7_rdl_bus[50:0]
       or lfb_entry4_rdl_bus[50:0]
       or lfb_rdl_ptr[2:0]
       or lfb_entry6_rdl_bus[50:0])
begin
  casez(lfb_rdl_ptr[2:0])
  3'b000 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry0_rdl_bus[RDL_WIDTH-1:0];
  3'b001 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry1_rdl_bus[RDL_WIDTH-1:0];
  3'b010 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry2_rdl_bus[RDL_WIDTH-1:0];
  3'b011 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry3_rdl_bus[RDL_WIDTH-1:0];
  3'b100 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry4_rdl_bus[RDL_WIDTH-1:0];
  3'b101 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry5_rdl_bus[RDL_WIDTH-1:0];
  3'b110 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry6_rdl_bus[RDL_WIDTH-1:0];
  3'b111 : rdl_bus[RDL_WIDTH-1:0] = lfb_entry7_rdl_bus[RDL_WIDTH-1:0];
  default: rdl_bus[RDL_WIDTH-1:0] = {RDL_WIDTH{1'b0}};
  endcase
// &CombEnd; @164
end

assign lfb_rdl_req            = lfb_entry_rdl_req[lfb_rdl_ptr[2:0]];
assign lfb_rdl_id[2:0]        = lfb_rdl_ptr[2:0];
assign lfb_rdl_type[1:0]      = {rdl_bus[RDL_LD],rdl_bus[RDL_PF]};
assign lfb_rdl_idx[13:0]      = {rdl_bus[RDL_VIDX_1:RDL_VIDX_0],rdl_bus[RDL_PA_11:RDL_PA_6], 6'b0};
assign lfb_rdl_way[3:0]       = rdl_bus[RDL_WAY_3:RDL_WAY_0];
assign lfb_rdl_tag[27:0]      = rdl_bus[RDL_PA_39:RDL_PA_12];
assign lfb_rdl_alias_hit      = rdl_bus[RDL_AHIT];
assign lfb_rdl_alias_idx[1:0] = rdl_bus[RDL_AIDX_1:RDL_AIDX_0];
assign lfb_rdl_ca             = rdl_bus[RDL_CA];

assign lfb_rdl_no_ld          = ~(|lfb_entry_ld_wo_stall[DEPTH-1:0]);

//================================================
//  lfb_rdl_response
//================================================
assign rdl_lfb_sel[DEPTH-1:0] = 8'b1 << lfb_rdl_ptr[2:0];
assign rdl_grant[DEPTH-1:0]   = {DEPTH{rdl_lfb_grant}} & rdl_lfb_sel[DEPTH-1:0];
assign rdl_cmplt[DEPTH-1:0]   = {DEPTH{rdl_lfb_cmplt}} & rdl_lfb_sel[DEPTH-1:0];

//================================================
//  lfb_pfb_response
//================================================
assign rdl_lfb_pf_vld  = rdl_lfb_cmplt & rdl_bus[RDL_PF]; 
assign lfb_pfb_id[4:0] = rdl_bus[RDL_PFB_ID+4:RDL_PFB_ID];

assign lfb_pfb_cache_hit[4:0]  = {5{rdl_lfb_pf_vld & rdl_lfb_cache_hit}} & lfb_pfb_id[4:0];
assign lfb_pfb_cache_miss[4:0] = {5{rdl_lfb_pf_vld & !rdl_lfb_cache_hit}} & lfb_pfb_id[4:0];

//================================================
//  bus request
//================================================
parameter BUS_ADDR_0  = 0;
parameter BUS_ADDR_4  = 4;
parameter BUS_ADDR_5  = 5;
parameter BUS_ADDR_39 = 39;
parameter BUS_PROT_0  = 40;
parameter BUS_PROT_2  = 42;
parameter BUS_CACHE_0 = 43;
parameter BUS_CACHE_1 = 44;
parameter BUS_CACHE_3 = 46;
parameter BUS_LEN_0   = 47;
parameter BUS_LEN_1   = 48;
parameter BUS_SIZE_0  = 49;
parameter BUS_SIZE_2  = 51;
parameter BUS_LD      = 52;
parameter BUS_AHIT    = 53;
parameter BUS_USER    = 54;
parameter BUS_WIDTH   = 55;

assign rd_req  = bus_req | vb_req;
assign bus_req = lfb_entry_arvalid[lfb_bus_ptr[2:0]] & !arbus[BUS_AHIT];
assign vb_req  = lfb_entry_arvalid[lfb_bus_ptr[2:0]] &  arbus[BUS_AHIT];

assign bus_ptr_inc = lfb_entry_bus_rdy[lfb_bus_ptr[2:0]] |
                     (lfb_create_ptr[3:0] != lfb_bus_ptr[3:0]) & !lfb_entry_vld[lfb_bus_ptr[2:0]];

always@(posedge lfb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_bus_ptr[3:0] <= 4'b0;
  else if (bus_ptr_inc)
    lfb_bus_ptr[3:0] <= lfb_bus_ptr[3:0] + 4'b1;
end

// &CombBeg; @230
always @( lfb_bus_ptr[2:0]
       or lfb_entry5_arbus[54:0]
       or lfb_entry7_arbus[54:0]
       or lfb_entry2_arbus[54:0]
       or lfb_entry3_arbus[54:0]
       or lfb_entry4_arbus[54:0]
       or lfb_entry0_arbus[54:0]
       or lfb_entry6_arbus[54:0]
       or lfb_entry1_arbus[54:0])
begin
  case(lfb_bus_ptr[2:0])
  3'b000 : arbus[BUS_WIDTH-1:0] = lfb_entry0_arbus[BUS_WIDTH-1:0];
  3'b001 : arbus[BUS_WIDTH-1:0] = lfb_entry1_arbus[BUS_WIDTH-1:0];
  3'b010 : arbus[BUS_WIDTH-1:0] = lfb_entry2_arbus[BUS_WIDTH-1:0];
  3'b011 : arbus[BUS_WIDTH-1:0] = lfb_entry3_arbus[BUS_WIDTH-1:0];
  3'b100 : arbus[BUS_WIDTH-1:0] = lfb_entry4_arbus[BUS_WIDTH-1:0];
  3'b101 : arbus[BUS_WIDTH-1:0] = lfb_entry5_arbus[BUS_WIDTH-1:0];
  3'b110 : arbus[BUS_WIDTH-1:0] = lfb_entry6_arbus[BUS_WIDTH-1:0];
  3'b111 : arbus[BUS_WIDTH-1:0] = lfb_entry7_arbus[BUS_WIDTH-1:0];
  default: arbus[BUS_WIDTH-1:0] = {BUS_WIDTH{1'b0}};
  endcase
// &CombEnd; @242
end

assign ar_wo = arbus[BUS_CACHE_1];
assign ar_ld = arbus[BUS_LD];
assign arid_ld[3:0] = ar_wo ? 4'b0100 : 4'b0111;

assign lsu_biu_arvalid           = bus_req;
assign lsu_biu_araddr[PADDR-1:0] = arbus[BUS_ADDR_39:BUS_ADDR_0];
assign lsu_biu_arid[3:0]         = ar_ld ? arid_ld[3:0] : {1'b1,lfb_bus_ptr[2:0]};
assign lsu_biu_arlen[1:0]        = arbus[BUS_LEN_1:BUS_LEN_0];
assign lsu_biu_arsize[2:0]       = arbus[BUS_SIZE_2:BUS_SIZE_0];
assign lsu_biu_arcache[3:0]      = arbus[BUS_CACHE_3:BUS_CACHE_0];
assign lsu_biu_arprot[2:0]       = arbus[BUS_PROT_2:BUS_PROT_0];
assign lsu_biu_aruser            = arbus[BUS_USER];
assign lsu_biu_arburst[1:0]      = arbus[BUS_LEN_1] ? 2'b10 : 2'b01;

//================================================
// bus response
//================================================
assign lfb_vb_arvalid         = vb_req;
assign lfb_vb_araddr_5_4[1:0] = arbus[BUS_ADDR_5:BUS_ADDR_4];
assign lfb_vb_arid[2:0]       = lfb_bus_ptr[2:0];

assign arready = bus_req & biu_lsu_arready |
                 vb_req & vb_lfb_arready;

assign arb_rvalid       = vb_lfb_rvalid | biu_lsu_rvalid;
assign arb_rid[3:0]     = biu_lsu_rvalid ? biu_lsu_rid[3:0]     : vb_lfb_rid[3:0];
assign arb_rdata[127:0] = biu_lsu_rvalid ? biu_lsu_rdata[127:0] : vb_lfb_rdata[127:0];
assign arb_rlast        = biu_lsu_rvalid ? biu_lsu_rlast        : vb_lfb_rlast;
assign arb_rresp[1:0]   = biu_lsu_rvalid ? biu_lsu_rresp[1:0]   : 2'b0;
assign arb_rdirty       = biu_lsu_rvalid ? 1'b0                 : vb_lfb_dirty;

assign lfb_vb_rready = !biu_lsu_rvalid;

always@(posedge lfb_rclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rvalid <= 1'b0;
  else if (arb_rvalid)
    rvalid <= 1'b1;
  else
    rvalid <= 1'b0;
end

always@(posedge lfb_rclk)
begin
  if (arb_rvalid | ifu_lsu_warm_up) begin
    rid_final[7:0] <= 8'b1 << rid_sel[2:0];
    rdata[127:0]   <= arb_rdata[127:0];
    rresp[1:0]     <= arb_rresp[1:0];
    rdirty         <= arb_rdirty;
  end
end

assign rid_pf_so[2:0] = arb_rid[3] ? arb_rid[2:0] : so_rid[2:0];
assign biu_ld_wo      = arb_rid[3:0] == 4'b0100;
assign rid_sel[2:0]   = biu_ld_wo ? rid_fifo[rid_fifo_pop_ptr[2:0]] : rid_pf_so[2:0];

//================================================
//  grant to lfb
//================================================
assign bus_grant[DEPTH-1:0] = (8'b1 << lfb_bus_ptr[2:0]) & {DEPTH{arready}};
assign bus_cmplt[DEPTH-1:0] = rid_final[DEPTH-1:0]  & {DEPTH{rvalid}};
assign bus_acc_err          = rresp[1];

//================================================
//rid_fifo : 
//transfer load weak order bus_id 4 to lfb_entry_num
//================================================
assign rid_fifo_create_en = rd_req & arready & ar_ld & ar_wo;
assign rid_fifo_pop_en    = arb_rvalid & biu_ld_wo & arb_rlast;

always @(posedge lfb_rid_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rid_fifo_create_ptr[2:0] <= 3'b0;
  else if (rid_fifo_create_en)
    rid_fifo_create_ptr[2:0] <= rid_fifo_create_ptr[2:0] + 3'b001;
end

always @(posedge lfb_rclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rid_fifo_pop_ptr[2:0] <= 3'b0;
  else if (rid_fifo_pop_en)
    rid_fifo_pop_ptr[2:0] <= rid_fifo_pop_ptr[2:0] + 3'b001;
end

// &Force("mem","rid_fifo",2,0,7,0); @331

integer i;
always @(posedge lfb_rid_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    for(i=0;i<8;i=i+1)
      rid_fifo[i] <= 3'b0;
  else begin
    for(i=0;i<8;i=i+1) 
    begin
      if (rid_fifo_create_en & rid_fifo_create_ptr[2:0] == i) 
        rid_fifo[i] <= lfb_bus_ptr[2:0];
      else
        rid_fifo[i] <= rid_fifo[i];
    end
  end
end

always @(posedge lfb_rid_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    so_rid[2:0] <= 3'b0;
  else if (rd_req & arready & ar_ld & !ar_wo)
    so_rid[2:0] <= lfb_bus_ptr[2:0];
end

//================================================
//  refill
//================================================
parameter REF_IDX_0  = 0;
parameter REF_IDX_5  = 5;
parameter REF_IDX_6  = 6;
parameter REF_IDX_7  = 7;
parameter REF_TAG_0  = 8;
parameter REF_TAG_27 = 35;
parameter REF_FIFO_0 = 36;
parameter REF_FIFO_1 = 37;
parameter REF_FIFO_2 = 38;
parameter REF_FIFO_3 = 39;
parameter REF_CNT_0  = 40;
parameter REF_CNT_1  = 41;
parameter REF_OFF_0  = 42;
parameter REF_OFF_1  = 43;
parameter REF_EN     = 44;
parameter REF_WIDTH  = 45;

assign ref_sel[DEPTH-1:0] = rid_final[DEPTH-1:0];
assign ld_sel[DEPTH-1:0]  = rid_final[DEPTH-1:0];

// &CombBeg; @381
always @( lfb_entry6_refbus[44:0]
       or lfb_entry5_refbus[44:0]
       or lfb_entry1_refbus[44:0]
       or ref_sel[7:0]
       or lfb_entry3_refbus[44:0]
       or lfb_entry2_refbus[44:0]
       or lfb_entry7_refbus[44:0]
       or lfb_entry4_refbus[44:0]
       or lfb_entry0_refbus[44:0])
begin
  case(ref_sel[DEPTH-1:0])
  8'b00000001 : refbus[REF_WIDTH-1:0] = lfb_entry0_refbus[REF_WIDTH-1:0];
  8'b00000010 : refbus[REF_WIDTH-1:0] = lfb_entry1_refbus[REF_WIDTH-1:0];
  8'b00000100 : refbus[REF_WIDTH-1:0] = lfb_entry2_refbus[REF_WIDTH-1:0];
  8'b00001000 : refbus[REF_WIDTH-1:0] = lfb_entry3_refbus[REF_WIDTH-1:0];
  8'b00010000 : refbus[REF_WIDTH-1:0] = lfb_entry4_refbus[REF_WIDTH-1:0];
  8'b00100000 : refbus[REF_WIDTH-1:0] = lfb_entry5_refbus[REF_WIDTH-1:0];
  8'b01000000 : refbus[REF_WIDTH-1:0] = lfb_entry6_refbus[REF_WIDTH-1:0];
  8'b10000000 : refbus[REF_WIDTH-1:0] = lfb_entry7_refbus[REF_WIDTH-1:0];
  default     : refbus[REF_WIDTH-1:0] = {REF_WIDTH{1'bx}};
  endcase
// &CombEnd; @393
end

assign ref_vld       = rvalid & !bus_acc_err & refbus[REF_EN];
assign ref_dirty     = rdirty;
assign ref_cnt[1:0]  = refbus[REF_CNT_1:REF_CNT_0];
assign ref_first     = ref_cnt[1:0] == 2'b00;
assign ref_fourth    = ref_cnt[1:0] == 2'b11;
assign ref_tag[39:0] = {refbus[REF_TAG_27:REF_TAG_0],refbus[REF_IDX_5],11'b0};

assign lfb_arb_dcache_sel      = ref_vld;
assign lfb_arb_tag_req         = ref_vld & (ref_first | ref_fourth);
assign lfb_arb_tag_way[3:0]    = refbus[REF_FIFO_3:REF_FIFO_0];
assign lfb_arb_tag_wen         = ref_first | ref_fourth;
assign lfb_arb_tag_idx[11:0]   = {refbus[REF_IDX_5:REF_IDX_0], 6'b0};
assign lfb_arb_tag_din[29:0]   = {ref_fourth, 1'b0, ref_tag[39:12]};

assign lfb_arb_tag_sel[3:0]  = {2'b00,2'b1<<refbus[REF_IDX_6]};

assign lfb_arb_dirty_req       = ref_vld & ref_fourth;
assign lfb_arb_dirty_wen[7:0]  = {4'b1111, refbus[REF_FIFO_3:REF_FIFO_0]};
assign lfb_arb_dirty_idx[13:0] = {refbus[REF_IDX_7:REF_IDX_0], 6'b0};
assign lfb_arb_dirty_din[7:0]  = {refbus[REF_FIFO_2:REF_FIFO_0],refbus[REF_FIFO_3], {4{ref_dirty}}};

assign data_sel[1:0] = {refbus[REF_FIFO_3] | refbus[REF_FIFO_2],
                        refbus[REF_FIFO_1] | refbus[REF_FIFO_0]};

assign lfb_arb_data0_req       = ref_vld & data_sel[0];
assign lfb_arb_data1_req       = ref_vld & data_sel[0];
assign lfb_arb_data2_req       = ref_vld & data_sel[1];
assign lfb_arb_data3_req       = ref_vld & data_sel[1];
assign lfb_arb_data_way[3:0]   = refbus[REF_FIFO_3:REF_FIFO_0];
assign lfb_arb_data_wen[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b1}};
assign lfb_arb_data_din[127:0] = rdata[127:0];


assign ref_offset[1:0] = ref_cnt[1:0] + refbus[REF_OFF_1:REF_OFF_0];

assign way0_way2_sel = refbus[REF_FIFO_0] | refbus[REF_FIFO_2];
assign data02_addr_3 = way0_way2_sel ? 1'b0 : 1'b1;
assign data13_addr_3 = way0_way2_sel ? 1'b1 : 1'b0;

assign lfb_arb_data02_idx[13:0]= {refbus[REF_IDX_7:REF_IDX_0],ref_offset[1:0],data02_addr_3,3'b000};
assign lfb_arb_data13_idx[13:0]= {refbus[REF_IDX_7:REF_IDX_0],ref_offset[1:0],data13_addr_3,3'b000};

//================================================
//  return ld data to DC
//================================================

parameter VLD_SEW_0   = 0;
parameter VLD_SEW_1   = 1;
parameter VLD_ESIZE_0 = 2;
parameter VLD_ESIZE_1 = 3;
parameter VLD_FUNC_0  = 4;
parameter VLD_FUNC_7  = 11;
parameter VLD_VL      = 12;
parameter VLD_VL_0    = 13;
parameter VLD_VL_6    = 19;
parameter VLD_SPLIT   = 20;
parameter VLD_WIDTH   = 21;

// &CombBeg; @477
always @( lfb_entry1_ldbus[36:0]
       or lfb_entry0_ldbus[36:0]
       or lfb_entry4_ldbus[36:0]
       or lfb_entry3_ldbus[36:0]
       or lfb_entry5_ldbus[36:0]
       or lfb_entry6_ldbus[36:0]
       or lfb_entry7_ldbus[36:0]
       or ld_sel[7:0]
       or lfb_entry2_ldbus[36:0])
begin
  case(ld_sel[DEPTH-1:0])
  8'b00000001 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry0_ldbus[`LSU_LD_WIDTH-1:0];
  8'b00000010 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry1_ldbus[`LSU_LD_WIDTH-1:0];
  8'b00000100 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry2_ldbus[`LSU_LD_WIDTH-1:0];
  8'b00001000 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry3_ldbus[`LSU_LD_WIDTH-1:0];
  8'b00010000 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry4_ldbus[`LSU_LD_WIDTH-1:0];
  8'b00100000 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry5_ldbus[`LSU_LD_WIDTH-1:0];
  8'b01000000 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry6_ldbus[`LSU_LD_WIDTH-1:0];
  8'b10000000 : ldbus[`LSU_LD_WIDTH-1:0] = lfb_entry7_ldbus[`LSU_LD_WIDTH-1:0];
  default     : ldbus[`LSU_LD_WIDTH-1:0] = {`LSU_LD_WIDTH{1'bx}};
  endcase
// &CombEnd; @489
end

// &CombBeg; @491
always @( lfb_entry6_vldbus[20:0]
       or lfb_entry1_vldbus[20:0]
       or lfb_entry5_vldbus[20:0]
       or lfb_entry0_vldbus[20:0]
       or lfb_entry2_vldbus[20:0]
       or lfb_entry7_vldbus[20:0]
       or lfb_entry3_vldbus[20:0]
       or lfb_entry4_vldbus[20:0]
       or ld_sel[7:0])
begin
  case(ld_sel[DEPTH-1:0])
  8'b00000001 : vldbus[VLD_WIDTH-1:0] = lfb_entry0_vldbus[VLD_WIDTH-1:0];
  8'b00000010 : vldbus[VLD_WIDTH-1:0] = lfb_entry1_vldbus[VLD_WIDTH-1:0];
  8'b00000100 : vldbus[VLD_WIDTH-1:0] = lfb_entry2_vldbus[VLD_WIDTH-1:0];
  8'b00001000 : vldbus[VLD_WIDTH-1:0] = lfb_entry3_vldbus[VLD_WIDTH-1:0];
  8'b00010000 : vldbus[VLD_WIDTH-1:0] = lfb_entry4_vldbus[VLD_WIDTH-1:0];
  8'b00100000 : vldbus[VLD_WIDTH-1:0] = lfb_entry5_vldbus[VLD_WIDTH-1:0];
  8'b01000000 : vldbus[VLD_WIDTH-1:0] = lfb_entry6_vldbus[VLD_WIDTH-1:0];
  8'b10000000 : vldbus[VLD_WIDTH-1:0] = lfb_entry7_vldbus[VLD_WIDTH-1:0];
  default     : vldbus[VLD_WIDTH-1:0] = {VLD_WIDTH{1'bx}};
  endcase
// &CombEnd; @503
end

// &CombBeg; @505
always @( lfb_entry5_mtval[39:0]
       or lfb_entry4_mtval[39:0]
       or lfb_entry6_mtval[39:0]
       or lfb_entry0_mtval[39:0]
       or lfb_entry7_mtval[39:0]
       or lfb_entry1_mtval[39:0]
       or lfb_entry2_mtval[39:0]
       or lfb_entry3_mtval[39:0]
       or ld_sel[7:0])
begin
  case(ld_sel[DEPTH-1:0])
  8'b00000001 : mtval[PADDR-1:0] = lfb_entry0_mtval[PADDR-1:0];
  8'b00000010 : mtval[PADDR-1:0] = lfb_entry1_mtval[PADDR-1:0];
  8'b00000100 : mtval[PADDR-1:0] = lfb_entry2_mtval[PADDR-1:0];
  8'b00001000 : mtval[PADDR-1:0] = lfb_entry3_mtval[PADDR-1:0];
  8'b00010000 : mtval[PADDR-1:0] = lfb_entry4_mtval[PADDR-1:0];
  8'b00100000 : mtval[PADDR-1:0] = lfb_entry5_mtval[PADDR-1:0];
  8'b01000000 : mtval[PADDR-1:0] = lfb_entry6_mtval[PADDR-1:0];
  8'b10000000 : mtval[PADDR-1:0] = lfb_entry7_mtval[PADDR-1:0];
  default     : mtval[PADDR-1:0] = {PADDR{1'bx}};
  endcase
// &CombEnd; @517
end

//assign lfb_dc_ld_inst              = |(ld_sel[DEPTH-1:0] & lfb_entry_ld_inst[DEPTH-1:0]);

assign lfb_dc_data_vld             = rvalid & ldbus[`LSU_LD_WB_EN];
assign lfb_dc_bus_err              = rresp[1] & ldbus[`LSU_LD_WB_EN] & !lfb_fof_not_first;
assign lfb_dc_data[`LSU_DATAW-1:0] = rresp[1] 
                                   ? {`LSU_DATAW{1'b1}} 
                                   : (ldbus[`LSU_LD_ADDR_3] ? rdata[127:64] : rdata[63:0]);
assign lfb_dc_sign_ext             = ldbus[`LSU_LD_SEXT];
assign lfb_dc_size[1:0]            = ldbus[`LSU_LD_SIZE_1:`LSU_LD_SIZE_0];
assign lfb_dc_bytes_vld[7:0]       = ldbus[`LSU_LD_BYTE_7:`LSU_LD_BYTE_0];
assign lfb_dc_data_shift[3:0]      = ldbus[`LSU_LD_SHIFT_3:`LSU_LD_SHIFT_0];
assign lfb_dc_split_second         = ldbus[`LSU_LD_SPLIT] & ldbus[`LSU_LD_SLAST];
assign lfb_dc_split_first          = ldbus[`LSU_LD_SPLIT] & !ldbus[`LSU_LD_SLAST];
assign lfb_dc_split                = ldbus[`LSU_LD_SPLIT];
assign lfb_dc_vls                  = ldbus[`LSU_LD_VLS];
assign lfb_dc_fls                  = ldbus[`LSU_LD_FLS];
assign lfb_dc_ptw                  = ldbus[`LSU_LD_PTW];
assign lfb_dc_dest_reg[5:0]        = ldbus[`LSU_LD_REG_5:`LSU_LD_REG_0];
assign lfb_dc_lock                 = ldbus[`LSU_LD_LOCK];
assign lfb_dc_amo_inst             = ldbus[`LSU_LD_AMO_INST];
assign lfb_dc_amo_func[4:0]        = ldbus[`LSU_LD_AMO_FUNC_4:`LSU_LD_AMO_FUNC_0];
assign lfb_dc_stb_id[1:0]          = ldbus[`LSU_LD_STB_ID_1:`LSU_LD_STB_ID_0];
assign lfb_dc_mtval[PADDR-1:0]     = mtval[PADDR-1:0];

assign lfb_dc_sew[1:0]        = vldbus[VLD_SEW_1:VLD_SEW_0];
assign lfb_dc_ele_size[1:0]   = vldbus[VLD_ESIZE_1:VLD_ESIZE_0];
assign lfb_dc_vfunc[7:0]      = vldbus[VLD_FUNC_7:VLD_FUNC_0];
assign lfb_dc_vl_update       = rresp[1] & lfb_fof_not_first;
assign lfb_dc_vl_val[6:0]     = vldbus[VLD_VL_6:VLD_VL_0];
assign lfb_dc_vsplit_last     = vldbus[VLD_SPLIT];
//================================================
//  FOF BUS ERR HANDLE
//================================================
// &Force("output","lfb_dc_ptw"); @560
// &Force("output","lfb_dc_vfunc"); @561
// &Force("output","lfb_dc_vl_val"); @562
// &Force("output","lfb_dc_vls"); @563
assign lfb_fof_not_first = lfb_dc_vls
                           && lfb_dc_vfunc[2]
                           && !lfb_dc_ptw
                           && |lfb_dc_vl_val[6:0]; 

//================================================
//  LFB_DONE TO STB
//================================================
parameter ST_ID_0   = 0;
parameter ST_ID_1   = 1;
parameter ST_ERR    = 2;
parameter ST_FIFO_0 = 3;
parameter ST_FIFO_3 = 6; 
parameter ST_WIDTH  = 7;

// &CombBeg; @579
always @( lfb_entry5_stbus[6:0]
       or lfb_entry2_stbus[6:0]
       or lfb_entry7_stbus[6:0]
       or lfb_entry4_stbus[6:0]
       or lfb_entry3_stbus[6:0]
       or lfb_entry1_stbus[6:0]
       or lfb_entry6_stbus[6:0]
       or lfb_entry_ref_done[7:0]
       or lfb_entry0_stbus[6:0])
begin
  case(lfb_entry_ref_done[DEPTH-1:0])
  8'b00000001 : stbus[ST_WIDTH-1:0] = lfb_entry0_stbus[ST_WIDTH-1:0];
  8'b00000010 : stbus[ST_WIDTH-1:0] = lfb_entry1_stbus[ST_WIDTH-1:0];
  8'b00000100 : stbus[ST_WIDTH-1:0] = lfb_entry2_stbus[ST_WIDTH-1:0];
  8'b00001000 : stbus[ST_WIDTH-1:0] = lfb_entry3_stbus[ST_WIDTH-1:0];
  8'b00010000 : stbus[ST_WIDTH-1:0] = lfb_entry4_stbus[ST_WIDTH-1:0];
  8'b00100000 : stbus[ST_WIDTH-1:0] = lfb_entry5_stbus[ST_WIDTH-1:0];
  8'b01000000 : stbus[ST_WIDTH-1:0] = lfb_entry6_stbus[ST_WIDTH-1:0];
  8'b10000000 : stbus[ST_WIDTH-1:0] = lfb_entry7_stbus[ST_WIDTH-1:0];
  default     : stbus[ST_WIDTH-1:0] = {ST_WIDTH{1'bx}};
  endcase
// &CombEnd; @591
end

assign lfb_stb_done      = |lfb_entry_ref_done[DEPTH-1:0];
assign lfb_stb_err       = stbus[ST_ERR];
assign lfb_stb_id[1:0]   = stbus[ST_ID_1:ST_ID_0];
assign lfb_stb_fifo[3:0] = stbus[ST_FIFO_3:ST_FIFO_0];

//==============================================================================
//   ICG
//============================================================================
assign lfb_clk_en = lfb_create_vld_gate | (|lfb_entry_vld[DEPTH-1:0]) |
                    (lfb_pop_ptr[3:0] != lfb_create_ptr[3:0]) |
                    (lfb_bus_ptr[3:0] != lfb_create_ptr[3:0]);

// &Instance("gated_clk_cell", "x_pa_lsu_lfb_gated_clk"); @605
gated_clk_cell  x_pa_lsu_lfb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lfb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lfb_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @606
//          .external_en (1'b0), @607
//          .global_en   (1'b1), @608
//          .module_en   (cp0_lsu_icg_en), @609
//          .local_en    (lfb_clk_en), @610
//          .clk_out     (lfb_clk)); @611

assign lfb_rid_clk_en = rd_req & ar_ld;
// &Instance("gated_clk_cell", "x_pa_lsu_lfb_rid_gated_clk"); @614
gated_clk_cell  x_pa_lsu_lfb_rid_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lfb_rid_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lfb_rid_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @615
//          .external_en (1'b0), @616
//          .global_en   (1'b1), @617
//          .module_en   (cp0_lsu_icg_en), @618
//          .local_en    (lfb_rid_clk_en), @619
//          .clk_out     (lfb_rid_clk)); @620

assign lfb_rclk_en = arb_rvalid | rvalid | ifu_lsu_warm_up; 
// &Instance("gated_clk_cell", "x_pa_lsu_lfb_rdata_gated_clk"); @623
gated_clk_cell  x_pa_lsu_lfb_rdata_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lfb_rclk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lfb_rclk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @624
//          .external_en (1'b0), @625
//          .global_en   (1'b1), @626
//          .module_en   (cp0_lsu_icg_en), @627
//          .local_en    (lfb_rclk_en), @628
//          .clk_out     (lfb_rclk)); @629

//================================================
// DBG
//================================================
assign lfb_dbginfo[55:0] = {lfb_entry7_dbginfo[6:0],
                            lfb_entry6_dbginfo[6:0],
                            lfb_entry5_dbginfo[6:0],
                            lfb_entry4_dbginfo[6:0],
                            lfb_entry3_dbginfo[6:0],
                            lfb_entry2_dbginfo[6:0],
                            lfb_entry1_dbginfo[6:0],
                            lfb_entry0_dbginfo[6:0]};
//==============================================================================
//   LFB entry Instance
//==============================================================================

// &ConnRule(s/_x$/[0]/); @646
// &ConnRule(s/entryx/entry0/); @647
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_0"); @648
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_0 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[0]            ),
  .bus_grant_x              (bus_grant[0]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[0]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[0]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[0]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[0]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[0]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[0]   ),
  .lfb_create_en_x          (lfb_create_en[0]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[0]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[0]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[0]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[0]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[0]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[0]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[0]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[0]      ),
  .lfb_entryx_arbus         (lfb_entry0_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry0_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry0_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry0_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry0_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry0_refbus       ),
  .lfb_entryx_stbus         (lfb_entry0_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry0_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[0]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[0]            ),
  .rdl_grant_x              (rdl_grant[0]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[1]/); @650
// &ConnRule(s/entryx/entry1/); @651
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_1"); @652
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_1 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[1]            ),
  .bus_grant_x              (bus_grant[1]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[1]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[1]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[1]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[1]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[1]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[1]   ),
  .lfb_create_en_x          (lfb_create_en[1]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[1]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[1]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[1]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[1]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[1]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[1]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[1]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[1]      ),
  .lfb_entryx_arbus         (lfb_entry1_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry1_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry1_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry1_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry1_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry1_refbus       ),
  .lfb_entryx_stbus         (lfb_entry1_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry1_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[1]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[1]            ),
  .rdl_grant_x              (rdl_grant[1]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[2]/); @654
// &ConnRule(s/entryx/entry2/); @655
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_2"); @656
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_2 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[2]            ),
  .bus_grant_x              (bus_grant[2]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[2]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[2]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[2]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[2]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[2]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[2]   ),
  .lfb_create_en_x          (lfb_create_en[2]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[2]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[2]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[2]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[2]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[2]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[2]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[2]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[2]      ),
  .lfb_entryx_arbus         (lfb_entry2_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry2_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry2_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry2_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry2_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry2_refbus       ),
  .lfb_entryx_stbus         (lfb_entry2_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry2_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[2]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[2]            ),
  .rdl_grant_x              (rdl_grant[2]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[3]/); @658
// &ConnRule(s/entryx/entry3/); @659
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_3"); @660
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_3 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[3]            ),
  .bus_grant_x              (bus_grant[3]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[3]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[3]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[3]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[3]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[3]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[3]   ),
  .lfb_create_en_x          (lfb_create_en[3]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[3]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[3]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[3]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[3]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[3]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[3]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[3]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[3]      ),
  .lfb_entryx_arbus         (lfb_entry3_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry3_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry3_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry3_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry3_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry3_refbus       ),
  .lfb_entryx_stbus         (lfb_entry3_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry3_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[3]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[3]            ),
  .rdl_grant_x              (rdl_grant[3]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[4]/); @662
// &ConnRule(s/entryx/entry4/); @663
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_4"); @664
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_4 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[4]            ),
  .bus_grant_x              (bus_grant[4]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[4]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[4]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[4]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[4]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[4]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[4]   ),
  .lfb_create_en_x          (lfb_create_en[4]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[4]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[4]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[4]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[4]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[4]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[4]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[4]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[4]      ),
  .lfb_entryx_arbus         (lfb_entry4_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry4_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry4_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry4_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry4_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry4_refbus       ),
  .lfb_entryx_stbus         (lfb_entry4_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry4_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[4]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[4]            ),
  .rdl_grant_x              (rdl_grant[4]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[5]/); @666
// &ConnRule(s/entryx/entry5/); @667
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_5"); @668
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_5 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[5]            ),
  .bus_grant_x              (bus_grant[5]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[5]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[5]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[5]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[5]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[5]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[5]   ),
  .lfb_create_en_x          (lfb_create_en[5]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[5]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[5]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[5]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[5]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[5]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[5]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[5]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[5]      ),
  .lfb_entryx_arbus         (lfb_entry5_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry5_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry5_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry5_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry5_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry5_refbus       ),
  .lfb_entryx_stbus         (lfb_entry5_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry5_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[5]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[5]            ),
  .rdl_grant_x              (rdl_grant[5]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[6]/); @670
// &ConnRule(s/entryx/entry6/); @671
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_6"); @672
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_6 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[6]            ),
  .bus_grant_x              (bus_grant[6]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[6]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[6]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[6]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[6]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[6]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[6]   ),
  .lfb_create_en_x          (lfb_create_en[6]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[6]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[6]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[6]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[6]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[6]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[6]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[6]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[6]      ),
  .lfb_entryx_arbus         (lfb_entry6_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry6_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry6_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry6_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry6_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry6_refbus       ),
  .lfb_entryx_stbus         (lfb_entry6_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry6_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[6]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[6]            ),
  .rdl_grant_x              (rdl_grant[6]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


// &ConnRule(s/_x$/[7]/); @674
// &ConnRule(s/entryx/entry7/); @675
// &Instance("aq_lsu_lfb_entry","x_aq_lsu_lfb_entry_7"); @676
aq_lsu_lfb_entry  x_aq_lsu_lfb_entry_7 (
  .bus_acc_err              (bus_acc_err             ),
  .bus_cmplt_x              (bus_cmplt[7]            ),
  .bus_grant_x              (bus_grant[7]            ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_lfb_addr_x        (dc_hit_lfb_addr[7]      ),
  .dc_hit_lfb_idx_x         (dc_hit_lfb_idx[7]       ),
  .dc_hit_lfb_preg_x        (dc_hit_lfb_preg[7]      ),
  .dc_hit_lfb_so_x          (dc_hit_lfb_so[7]        ),
  .dc_hit_lfb_vreg_x        (dc_hit_lfb_vreg[7]      ),
  .dc_xx_dest_preg          (dc_xx_dest_preg         ),
  .dc_xx_pa                 (dc_xx_pa                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_create_alias_hit     (lfb_create_alias_hit    ),
  .lfb_create_alias_idx     (lfb_create_alias_idx    ),
  .lfb_create_alias_way     (lfb_create_alias_way    ),
  .lfb_create_amo_func      (lfb_create_amo_func     ),
  .lfb_create_amo_inst      (lfb_create_amo_inst     ),
  .lfb_create_attr          (lfb_create_attr         ),
  .lfb_create_bytes_vld     (lfb_create_bytes_vld    ),
  .lfb_create_ca            (lfb_create_ca           ),
  .lfb_create_dest_reg      (lfb_create_dest_reg     ),
  .lfb_create_ele_size      (lfb_create_ele_size     ),
  .lfb_create_en_gate_x     (lfb_create_en_gate[7]   ),
  .lfb_create_en_x          (lfb_create_en[7]        ),
  .lfb_create_fls           (lfb_create_fls          ),
  .lfb_create_ld            (lfb_create_ld           ),
  .lfb_create_lock          (lfb_create_lock         ),
  .lfb_create_pa            (lfb_create_pa           ),
  .lfb_create_pf            (lfb_create_pf           ),
  .lfb_create_pfb_id        (lfb_create_pfb_id       ),
  .lfb_create_priv_mode     (lfb_create_priv_mode    ),
  .lfb_create_ptw           (lfb_create_ptw          ),
  .lfb_create_sew           (lfb_create_sew          ),
  .lfb_create_shift         (lfb_create_shift        ),
  .lfb_create_sign_ext      (lfb_create_sign_ext     ),
  .lfb_create_size          (lfb_create_size         ),
  .lfb_create_split         (lfb_create_split        ),
  .lfb_create_split_last    (lfb_create_split_last   ),
  .lfb_create_stbid         (lfb_create_stbid        ),
  .lfb_create_vfunc         (lfb_create_vfunc        ),
  .lfb_create_virt_idx      (lfb_create_virt_idx     ),
  .lfb_create_vl_val        (lfb_create_vl_val       ),
  .lfb_create_vls           (lfb_create_vls          ),
  .lfb_create_vsplit_last   (lfb_create_vsplit_last  ),
  .lfb_create_wb            (lfb_create_wb           ),
  .lfb_entry_arvalid_x      (lfb_entry_arvalid[7]    ),
  .lfb_entry_bus_rdy_x      (lfb_entry_bus_rdy[7]    ),
  .lfb_entry_ld_wo_stall_x  (lfb_entry_ld_wo_stall[7]),
  .lfb_entry_pop_en_x       (lfb_entry_pop_en[7]     ),
  .lfb_entry_rdl_req_x      (lfb_entry_rdl_req[7]    ),
  .lfb_entry_ref_done_x     (lfb_entry_ref_done[7]   ),
  .lfb_entry_vld_x          (lfb_entry_vld[7]        ),
  .lfb_entry_wb_en_x        (lfb_entry_wb_en[7]      ),
  .lfb_entryx_arbus         (lfb_entry7_arbus        ),
  .lfb_entryx_dbginfo       (lfb_entry7_dbginfo      ),
  .lfb_entryx_ldbus         (lfb_entry7_ldbus        ),
  .lfb_entryx_mtval         (lfb_entry7_mtval        ),
  .lfb_entryx_rdl_bus       (lfb_entry7_rdl_bus      ),
  .lfb_entryx_refbus        (lfb_entry7_refbus       ),
  .lfb_entryx_stbus         (lfb_entry7_stbus        ),
  .lfb_entryx_vldbus        (lfb_entry7_vldbus       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_hit_lfb_idx_x        (pfb_hit_lfb_idx[7]      ),
  .pfb_xx_pa                (pfb_xx_pa               ),
  .rdl_cmplt_x              (rdl_cmplt[7]            ),
  .rdl_grant_x              (rdl_grant[7]            ),
  .rdl_lfb_alias_hit        (rdl_lfb_alias_hit       ),
  .rdl_lfb_cache_hit        (rdl_lfb_cache_hit       ),
  .rdl_lfb_ref_fifo         (rdl_lfb_ref_fifo        ),
  .rtu_yy_xx_async_flush    (rtu_yy_xx_async_flush   )
);


//==============================================================================
//  ASSERTION
//==============================================================================

// &ModuleEnd; @697
endmodule


