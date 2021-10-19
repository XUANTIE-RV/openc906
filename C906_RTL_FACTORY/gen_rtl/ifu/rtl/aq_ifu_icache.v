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
module aq_ifu_icache(
  biu_ifu_arready,
  biu_ifu_rdata,
  biu_ifu_rid,
  biu_ifu_rlast,
  biu_ifu_rresp,
  biu_ifu_rvalid,
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
  cp0_ifu_iwpe,
  cp0_ifu_lpmd_req,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_icache_abort,
  ctrl_icache_req_vld,
  forever_cpuclk,
  hpcp_ifu_cnt_en,
  icache_btb_grant,
  icache_ctrl_stall,
  icache_ipack_acc_err,
  icache_ipack_inst,
  icache_ipack_inst_vld,
  icache_ipack_inst_vld_gate,
  icache_ipack_pgflt,
  icache_ipack_unalign,
  icache_pcgen_addr,
  icache_pcgen_grant,
  icache_pcgen_grant_gate,
  icache_pcgen_inst_vld,
  icache_pcgen_inst_vld_gate,
  icache_pred_inst_vld,
  icache_pred_inst_vld_gate,
  icache_top_abort,
  icache_top_inv_st,
  icache_top_rd_vld,
  icache_top_ref_st,
  ifu_biu_araddr,
  ifu_biu_arburst,
  ifu_biu_arcache,
  ifu_biu_arid,
  ifu_biu_arlen,
  ifu_biu_arprot,
  ifu_biu_arsize,
  ifu_biu_arvalid,
  ifu_cp0_icache_inv_done,
  ifu_cp0_icache_read_data,
  ifu_cp0_icache_read_data_vld,
  ifu_hpcp_icache_access,
  ifu_hpcp_icache_miss,
  ifu_mmu_abort,
  ifu_mmu_va,
  ifu_mmu_va_vld,
  ifu_yy_xx_no_op,
  mmu_ifu_access_fault,
  mmu_ifu_pa,
  mmu_ifu_pa_vld,
  mmu_ifu_prot,
  pad_yy_icg_scan_en,
  pcgen_icache_chgflw_vld,
  pcgen_icache_seq_tag,
  pcgen_icache_va
);

// &Ports; @24
input            biu_ifu_arready;             
input   [127:0]  biu_ifu_rdata;               
input            biu_ifu_rid;                 
input            biu_ifu_rlast;               
input   [1  :0]  biu_ifu_rresp;               
input            biu_ifu_rvalid;              
input            cp0_ifu_icache_en;           
input   [63 :0]  cp0_ifu_icache_inv_addr;     
input            cp0_ifu_icache_inv_req;      
input   [1  :0]  cp0_ifu_icache_inv_type;     
input            cp0_ifu_icache_pref_en;      
input   [13 :0]  cp0_ifu_icache_read_index;   
input            cp0_ifu_icache_read_req;     
input            cp0_ifu_icache_read_tag;     
input            cp0_ifu_icache_read_way;     
input            cp0_ifu_icg_en;              
input            cp0_ifu_iwpe;                
input            cp0_ifu_lpmd_req;            
input            cp0_yy_clk_en;               
input            cpurst_b;                    
input            ctrl_icache_abort;           
input            ctrl_icache_req_vld;         
input            forever_cpuclk;              
input            hpcp_ifu_cnt_en;             
input            mmu_ifu_access_fault;        
input   [27 :0]  mmu_ifu_pa;                  
input            mmu_ifu_pa_vld;              
input   [4  :0]  mmu_ifu_prot;                
input            pad_yy_icg_scan_en;          
input            pcgen_icache_chgflw_vld;     
input   [33 :0]  pcgen_icache_seq_tag;        
input   [63 :0]  pcgen_icache_va;             
output           icache_btb_grant;            
output           icache_ctrl_stall;           
output           icache_ipack_acc_err;        
output  [31 :0]  icache_ipack_inst;           
output           icache_ipack_inst_vld;       
output           icache_ipack_inst_vld_gate;  
output           icache_ipack_pgflt;          
output           icache_ipack_unalign;        
output  [39 :0]  icache_pcgen_addr;           
output           icache_pcgen_grant;          
output           icache_pcgen_grant_gate;     
output           icache_pcgen_inst_vld;       
output           icache_pcgen_inst_vld_gate;  
output           icache_pred_inst_vld;        
output           icache_pred_inst_vld_gate;   
output           icache_top_abort;            
output  [1  :0]  icache_top_inv_st;           
output           icache_top_rd_vld;           
output  [1  :0]  icache_top_ref_st;           
output  [39 :0]  ifu_biu_araddr;              
output  [1  :0]  ifu_biu_arburst;             
output  [3  :0]  ifu_biu_arcache;             
output           ifu_biu_arid;                
output  [1  :0]  ifu_biu_arlen;               
output  [2  :0]  ifu_biu_arprot;              
output  [2  :0]  ifu_biu_arsize;              
output           ifu_biu_arvalid;             
output           ifu_cp0_icache_inv_done;     
output  [127:0]  ifu_cp0_icache_read_data;    
output           ifu_cp0_icache_read_data_vld; 
output           ifu_hpcp_icache_access;      
output           ifu_hpcp_icache_miss;        
output           ifu_mmu_abort;               
output  [51 :0]  ifu_mmu_va;                  
output           ifu_mmu_va_vld;              
output           ifu_yy_xx_no_op;             

// &Regs; @25
reg     [33 :0]  buf_hit_tag;                 
reg              buf_hit_way;                 
reg              direct_sel;                  
reg              direct_sel_way;              
reg     [1  :0]  iaq_way_sel;                 
reg              icache_access_ff;            
reg              icache_en;                   
reg              icache_en_f;                 
reg              icache_miss_ff;              
reg     [63 :0]  icache_rd_addr;              
reg              icache_rd_vld;               
reg     [39 :0]  icache_refill_addr;          
reg              icache_refill_fifo;          
reg     [4  :0]  icache_refill_prot;          
reg     [8  :0]  inv_cnt;                     
reg     [1  :0]  iop_cur_st;                  
reg     [1  :0]  iop_nxt_st;                  
reg     [2  :0]  pf_cur_st;                   
reg              pf_err_ff;                   
reg              pf_fifo;                     
reg     [2  :0]  pf_nxt_st;                   
reg     [2  :0]  ref_cur_st;                  
reg     [2  :0]  ref_nxt_st;                  
reg              refill_data_abort;           
reg              refill_error;                
reg     [1  :0]  req_cnt;                     
reg              tag_hit_vld;                 

// &Wires; @26
wire             addr_equal;                  
wire    [8  :0]  als_cnt_max;                 
wire             biu_icache_grant;            
wire             biu_icache_pf_cmplt;         
wire             biu_icache_pf_err;           
wire             biu_icache_pf_vld;           
wire             biu_icache_ref_cmplt;        
wire             biu_icache_ref_err;          
wire             biu_icache_ref_vld;          
wire             biu_ifu_arready;             
wire    [127:0]  biu_ifu_rdata;               
wire             biu_ifu_rid;                 
wire             biu_ifu_rlast;               
wire    [1  :0]  biu_ifu_rresp;               
wire             biu_ifu_rvalid;              
wire             buf_clr_en;                  
wire             buf_hit_upd;                 
wire             buf_rfl_upd;                 
wire             buf_upd_en;                  
wire             cen_mask_vld;                
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
wire             cp0_ifu_iwpe;                
wire             cp0_ifu_lpmd_req;            
wire             cp0_yy_clk_en;               
wire             cpurst_b;                    
wire             ctrl_icache_abort;           
wire             ctrl_icache_req_vld;         
wire    [1  :0]  data_cen_masked;             
wire             forever_cpuclk;              
wire             hit_clk;                     
wire    [33 :0]  hit_tag;                     
wire             hit_way;                     
wire             hpcp_ifu_cnt_en;             
wire             icache_btb_grant;            
wire    [31 :0]  icache_bypass_inst;          
wire             icache_bypass_vld;           
wire    [27 :0]  icache_cmp_pa;               
wire             icache_ctrl_stall;           
wire    [31 :0]  icache_data0_dout;           
wire    [31 :0]  icache_data1_dout;           
wire    [31 :0]  icache_data2_dout;           
wire    [31 :0]  icache_data3_dout;           
wire    [31 :0]  icache_data_10;              
wire    [31 :0]  icache_data_32;              
wire    [127:0]  icache_data_din;             
wire    [13 :0]  icache_data_idx;             
wire    [1  :0]  icache_data_ren;             
wire    [1  :0]  icache_data_wen;             
wire             icache_deny;                 
wire             icache_hit;                  
wire             icache_hit0;                 
wire             icache_hit1;                 
wire    [31 :0]  icache_hit_inst;             
wire             icache_hit_vld;              
wire             icache_inv_clk;              
wire    [58 :0]  icache_inv_din;              
wire             icache_inv_done;             
wire             icache_inv_err;              
wire             icache_inv_icg_en;           
wire    [8  :0]  icache_inv_idx;              
wire    [2  :0]  icache_inv_idx_high;         
wire    [8  :0]  icache_inv_pa_idx;           
wire             icache_inv_req;              
wire    [2  :0]  icache_inv_wen;              
wire             icache_inv_wt;               
wire             icache_ipack_acc_err;        
wire    [31 :0]  icache_ipack_inst;           
wire             icache_ipack_inst_vld;       
wire             icache_ipack_inst_vld_gate;  
wire             icache_ipack_pgflt;          
wire             icache_ipack_unalign;        
wire    [39 :0]  icache_miss_addr;            
wire    [4  :0]  icache_miss_prot;            
wire             icache_miss_req;             
wire    [39 :0]  icache_pa;                   
wire             icache_pa_vld;               
wire    [39 :0]  icache_pcgen_addr;           
wire             icache_pcgen_grant;          
wire             icache_pcgen_grant_gate;     
wire             icache_pcgen_inst_vld;       
wire             icache_pcgen_inst_vld_gate;  
wire             icache_pred_inst_vld;        
wire             icache_pred_inst_vld_gate;   
wire    [4  :0]  icache_prot;                 
wire             icache_rd_cen;               
wire             icache_rd_clk;               
wire    [13 :0]  icache_rd_data_idx;          
wire             icache_rd_icg_en;            
wire             icache_rd_req;               
wire    [8  :0]  icache_rd_tag_idx;           
wire             icache_refdp_clk;            
wire             icache_refdp_icg_en;         
wire             icache_reffsm_clk;           
wire             icache_reffsm_icg_en;        
wire             icache_refill_ba;            
wire             icache_refill_ca;            
wire             icache_refill_supv;          
wire             icache_req;                  
wire             icache_stall;                
wire             icache_tag_cen;              
wire    [58 :0]  icache_tag_din;              
wire    [58 :0]  icache_tag_dout;             
wire             icache_tag_fifo;             
wire    [8  :0]  icache_tag_idx;              
wire    [27 :0]  icache_tag_way0_dout;        
wire             icache_tag_way0_vld;         
wire    [27 :0]  icache_tag_way1_dout;        
wire             icache_tag_way1_vld;         
wire    [2  :0]  icache_tag_wen;              
wire             icache_top_abort;            
wire    [1  :0]  icache_top_inv_st;           
wire             icache_top_rd_vld;           
wire    [1  :0]  icache_top_ref_st;           
wire    [63 :0]  icache_va;                   
wire             icache_way0_hit;             
wire    [31 :0]  icache_way0_inst;            
wire             icache_way1_hit;             
wire    [31 :0]  icache_way1_inst;            
wire             icache_wr_data_cen;          
wire    [127:0]  icache_wr_data_din;          
wire    [13 :0]  icache_wr_data_idx;          
wire             icache_wr_tag_cen;           
wire    [58 :0]  icache_wr_tag_din;           
wire    [8  :0]  icache_wr_tag_idx;           
wire    [2  :0]  icache_wr_tag_wen;           
wire    [39 :0]  ifu_biu_araddr;              
wire    [1  :0]  ifu_biu_arburst;             
wire    [3  :0]  ifu_biu_arcache;             
wire             ifu_biu_arid;                
wire    [1  :0]  ifu_biu_arlen;               
wire    [2  :0]  ifu_biu_arprot;              
wire    [2  :0]  ifu_biu_arsize;              
wire             ifu_biu_arvalid;             
wire             ifu_cp0_icache_inv_done;     
wire    [127:0]  ifu_cp0_icache_read_data;    
wire             ifu_cp0_icache_read_data_vld; 
wire             ifu_hpcp_icache_access;      
wire             ifu_hpcp_icache_miss;        
wire             ifu_mmu_abort;               
wire    [51 :0]  ifu_mmu_va;                  
wire             ifu_mmu_va_vld;              
wire             ifu_yy_xx_no_op;             
wire             inv_cnt_en;                  
wire    [8  :0]  inv_cnt_max;                 
wire             inv_fsm_flop;                
wire             inv_fsm_idle;                
wire             inv_fsm_read;                
wire             inv_fsm_write;               
wire             inv_idx_alias;               
wire             inv_type_addr;               
wire             inv_type_pa;                 
wire             inv_type_va;                 
wire    [1  :0]  inv_way_sel;                 
wire    [63 :0]  iop_inv_rd_addr;             
wire             iop_inv_req;                 
wire             iop_inv_sel;                 
wire             iop_rd_data;                 
wire    [127:0]  iop_rd_data_out;             
wire    [13 :0]  iop_rd_idx;                  
wire             iop_rd_req;                  
wire    [127:0]  iop_rd_rslt;                 
wire             iop_rd_tag;                  
wire    [127:0]  iop_rd_tag_out;              
wire             iop_rd_way;                  
wire             mmu_ifu_access_fault;        
wire    [27 :0]  mmu_ifu_pa;                  
wire             mmu_ifu_pa_vld;              
wire    [4  :0]  mmu_ifu_prot;                
wire             pad_yy_icg_scan_en;          
wire             pcgen_icache_chgflw_vld;     
wire    [33 :0]  pcgen_icache_seq_tag;        
wire    [63 :0]  pcgen_icache_va;             
wire             pf_biu_req;                  
wire    [63 :0]  pf_chk_addr;                 
wire             pf_chk_pass;                 
wire             pf_chk_req;                  
wire             pf_chk_vld;                  
wire             pf_fsm_chk;                  
wire             pf_fsm_idle;                 
wire             pf_fsm_req;                  
wire             pf_fsm_wfc0;                 
wire             pf_fsm_wfc3;                 
wire    [39 :0]  pf_icache_addr;              
wire    [127:0]  pf_icache_data;              
wire             pf_icache_done;              
wire             pf_icache_fifo;              
wire             pf_icache_init;              
wire             pf_icache_req;               
wire    [39 :0]  pf_req_addr;                 
wire    [39 :0]  pf_req_va;                   
wire             ref_fsm_idle;                
wire             ref_fsm_init;                
wire             ref_fsm_req;                 
wire             ref_fsm_wfc;                 
wire             ref_fsm_wfpa;                
wire             ref_rdy;                     
wire             refill_bank0_sel;            
wire             refill_bank1_sel;            
wire             refill_bank2_sel;            
wire             refill_bank3_sel;            
wire    [39 :0]  refill_icache_addr;          
wire    [127:0]  refill_icache_data;          
wire             refill_icache_done;          
wire             refill_icache_fifo;          
wire             refill_icache_init;          
wire             refill_icache_req;           
wire    [58 :0]  refill_tag_din;              
wire    [8  :0]  refill_tag_idx;              
wire    [2  :0]  refill_tag_wen;              
wire             refill_tag_wr;               
wire             tag_hit_clk_en;              


//==========================================================
// Instruction Cache Module
// 1. Instance ICG cell
// 2. I-Cache Request Generation
// 3. Instance I-Cache Array
// 4. I-utlb Access
// 5. I-Cache Hit Judge and Data Select
// 6. I-Cache Refill Control
// 7. I-Cache Operation Control
//==========================================================

//------------------------------------------------
// 1. Instance ICG cell
//------------------------------------------------
assign icache_rd_icg_en = icache_rd_req && ref_fsm_idle 
                       || direct_sel;
// &Instance("gated_clk_cell", "x_ifu_icache_rd_icg_cell"); @44
gated_clk_cell  x_ifu_icache_rd_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icache_rd_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (icache_rd_icg_en  ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @45
//          .external_en (1'b0), @46
//          .global_en   (cp0_yy_clk_en), @47
//          .module_en   (cp0_ifu_icg_en), @48
//          .local_en    (icache_rd_icg_en), @49
//          .clk_out     (icache_rd_clk) @50
//        ); @51
assign icache_refdp_icg_en = icache_rd_vld && (ref_fsm_idle || ref_fsm_wfpa);
// &Instance("gated_clk_cell", "x_ifu_icache_refdp_icg_cell"); @53
gated_clk_cell  x_ifu_icache_refdp_icg_cell (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (icache_refdp_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (icache_refdp_icg_en),
  .module_en           (cp0_ifu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @54
//          .external_en (1'b0), @55
//          .global_en   (cp0_yy_clk_en), @56
//          .module_en   (cp0_ifu_icg_en), @57
//          .local_en    (icache_refdp_icg_en), @58
//          .clk_out     (icache_refdp_clk) @59
//        ); @60

assign icache_reffsm_icg_en = icache_rd_vld || !ref_fsm_idle || !pf_fsm_idle
                           || refill_data_abort || refill_error || pf_err_ff
                           || icache_access_ff || icache_miss_ff;
// &Instance("gated_clk_cell", "x_ifu_icache_reffsm_icg_cell"); @65
gated_clk_cell  x_ifu_icache_reffsm_icg_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (icache_reffsm_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (icache_reffsm_icg_en),
  .module_en            (cp0_ifu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect(.clk_in      (forever_cpuclk), @66
//          .external_en (1'b0), @67
//          .global_en   (cp0_yy_clk_en), @68
//          .module_en   (cp0_ifu_icg_en), @69
//          .local_en    (icache_reffsm_icg_en), @70
//          .clk_out     (icache_reffsm_clk) @71
//        ); @72

assign icache_inv_icg_en = !inv_fsm_idle;
// &Instance("gated_clk_cell", "x_ifu_icache_inv_icg_cell"); @75
gated_clk_cell  x_ifu_icache_inv_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icache_inv_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (icache_inv_icg_en ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @76
//          .external_en (1'b0), @77
//          .global_en   (cp0_yy_clk_en), @78
//          .module_en   (cp0_ifu_icg_en), @79
//          .local_en    (icache_inv_icg_en), @80
//          .clk_out     (icache_inv_clk) @81
//        ); @82

//------------------------------------------------
// 2. I-Cache Request Generation
// a. I-Cache Read Request
// b. I-Cache Write Request
// c. I-Cache Tag hit buffer
// d. I-Cache Request
//------------------------------------------------

// a. I-Cache Read Request
// Generate Chip Enable and Index

// Read Chip Enable
// request valid when i-cache enable and sysmap cacheable
assign icache_va[63:0] = iop_inv_sel ? iop_inv_rd_addr[63:0]
                       : pf_chk_req  ? pf_chk_addr[63:0]
                                     : pcgen_icache_va[63:0];
assign icache_rd_req   = ctrl_icache_req_vld && inv_fsm_idle && ref_fsm_idle && pf_fsm_idle
                      || inv_fsm_read
                      || pf_chk_req;
assign icache_rd_cen   = icache_rd_req && !icache_stall;

// Read Index
// calculate icache read index depending on cache capcity
// cache line size: 64-Bytes
//  8KB: tag index: addr[11:6], data index: addr[12:2]
// 16KB: tag index: addr[12:6], data index: addr[13:2]
// 32KB: tag index: addr[13:6], data index: addr[14:2]
// 64KB: tag index: addr[14:6], data index: addr[15:2]
assign icache_rd_tag_idx[8:0]   = iop_rd_req && inv_fsm_read ? iop_rd_idx[12:4] : icache_va[14:6];
assign icache_rd_data_idx[13:0] = iop_rd_req && inv_fsm_read ? iop_rd_idx[13:0] : icache_va[15:2];

// b. I-Cache Write Request
// Generate Chip Enable, Index

// Write Chip Enable
// request valid when invalid request or refill/pf request
assign refill_tag_wr = refill_icache_req && (refill_icache_init || refill_icache_done)
                    || pf_icache_req && (pf_icache_init || pf_icache_done);
assign refill_tag_wen[2:0] = {3{refill_icache_req}} & {refill_icache_init, icache_refill_fifo, !icache_refill_fifo}
                           | {3{pf_icache_req}} & {pf_icache_init, pf_icache_fifo, !pf_icache_fifo};
assign refill_tag_idx[8:0] =  biu_ifu_rid ? pf_req_va[14:6] : icache_rd_addr[14:6];
assign refill_tag_din[58:0] = {refill_icache_init ? !refill_icache_fifo : !pf_icache_fifo,
                               pf_icache_done || refill_icache_done,
                               biu_ifu_rid ? pf_icache_addr[39:12] : refill_icache_addr[39:12],
                               pf_icache_done || refill_icache_done,
                               biu_ifu_rid ? pf_icache_addr[39:12] : refill_icache_addr[39:12]};

assign icache_wr_tag_cen      = refill_tag_wr || icache_inv_req;
assign icache_wr_tag_wen[2:0] = icache_inv_req ? icache_inv_wen[2:0]
                                               : refill_tag_wen[2:0];
assign icache_wr_tag_idx[8:0] = icache_inv_req ? icache_inv_idx[8:0]
                                               : refill_tag_idx[8:0];
assign icache_wr_tag_din[58:0] = icache_inv_req ? icache_inv_din[58:0]
                                                : refill_tag_din[58:0];

assign icache_wr_data_cen       = refill_icache_req || pf_icache_req;
assign icache_wr_data_idx[13:0] = biu_ifu_rid ? {pf_req_va[15:6], pf_cur_st[1:0], 2'b0}
                                              : {icache_rd_addr[15:6], req_cnt[1:0], 2'b0};
assign icache_wr_data_din[127:0] = biu_ifu_rid ? pf_icache_data[127:0] : refill_icache_data[127:0];

//// c. I-Cache Tag hit buffer
// Tag Hit Buffer for cache memory low power
// including buffer valid, hit tag, hit way
// Instance ICG
assign tag_hit_clk_en = buf_upd_en || buf_clr_en;
// &Instance("gated_clk_cell","x_gated_hit_clk_cell"); @149
gated_clk_cell  x_gated_hit_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (hit_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (tag_hit_clk_en    ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in     (forever_cpuclk), @150
//          .global_en  (cp0_yy_clk_en ), @151
//          .module_en  (cp0_ifu_icg_en), @152
//          .local_en   (tag_hit_clk_en), @153
//          .external_en(1'b0          ), @154
//          .clk_out    (hit_clk       )); @155

// buffer update:
// update when refill final or read hit
assign buf_rfl_upd = refill_icache_req && refill_icache_done;
assign buf_hit_upd = icache_rd_vld && icache_pa_vld && !direct_sel 
                 && (icache_way1_hit || icache_way0_hit);

// buf update when refill last or hit valid
assign buf_upd_en = (buf_rfl_upd || buf_hit_upd) && cp0_ifu_iwpe;

// buf clear when refill first req or invalid one req or invalid all last
assign buf_clr_en = refill_icache_req && refill_icache_init && cp0_ifu_iwpe
                 || pf_icache_req && pf_icache_init && cp0_ifu_iwpe
                 || iop_inv_req && cp0_ifu_iwpe
                 || pcgen_icache_chgflw_vld && cp0_ifu_iwpe;


always @ (posedge hit_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tag_hit_vld <= 1'b0;
  else if(buf_clr_en)
    tag_hit_vld <= 1'b0;
  else if(buf_upd_en)
    tag_hit_vld <= 1'b1;
  else
    tag_hit_vld <= tag_hit_vld;
end

assign hit_tag[33:0] = icache_rd_addr[39:6];
assign hit_way       = buf_rfl_upd ? icache_data_wen[1] : icache_way1_hit;
always @ (posedge hit_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    buf_hit_tag[33:0] <= 34'b0;
    buf_hit_way       <= 1'b0;
  end
  else if(buf_upd_en)
  begin
    buf_hit_tag[33:0] <= hit_tag[33:0];
    buf_hit_way       <= hit_way;
  end
  else
  begin
    buf_hit_tag[33:0] <= buf_hit_tag[33:0];
    buf_hit_way       <= buf_hit_way;
  end
end
always @ (posedge icache_rd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    direct_sel <= 1'b0;
  else if(icache_rd_cen)
    direct_sel <= cen_mask_vld;
  else if(icache_rd_vld && direct_sel)
    direct_sel <= 1'b0;
  else
    direct_sel <= direct_sel;
end
always @ (posedge icache_rd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    direct_sel_way <= 1'b0;
  else if(icache_rd_cen && cen_mask_vld)
    direct_sel_way <= buf_hit_way;
  else
    direct_sel_way <= direct_sel_way;
end


assign addr_equal   = pcgen_icache_seq_tag[33:0] == buf_hit_tag[33:0];
//assign addr_equal   = 1'b0;

assign cen_mask_vld = tag_hit_vld && addr_equal && !pcgen_icache_chgflw_vld
                   && !buf_rfl_upd && !pf_chk_req && inv_fsm_idle;
assign data_cen_masked[1:0] = {2{icache_rd_cen}} & {buf_hit_way, !buf_hit_way};

// d. I-Cache Request
// Generate Chip Enable, Write Enable, Index, Tag In and Data In
// request priority : refill > inv > cache_rd

assign icache_tag_cen       = icache_rd_cen && !cen_mask_vld
                           || icache_wr_tag_cen
                           || inv_fsm_read && iop_rd_tag;
assign icache_tag_wen[2:0]  = icache_wr_tag_wen[2:0];
assign icache_tag_idx[8:0]  = icache_wr_tag_cen ? icache_wr_tag_idx[8:0]
                                                : icache_rd_tag_idx[8:0];
assign icache_tag_din[58:0] = icache_wr_tag_din[58:0];

//data ram access
assign icache_data_ren[1:0] = cen_mask_vld ? data_cen_masked[1:0] : {2{icache_rd_cen}};
assign icache_data_wen[1:0] = {icache_wr_data_cen && (biu_ifu_rid ?  pf_icache_fifo :  icache_refill_fifo),
                               icache_wr_data_cen && (biu_ifu_rid ? !pf_icache_fifo : !icache_refill_fifo)};
assign icache_data_idx[13:0] = icache_wr_data_cen ? icache_wr_data_idx[13:0]
                                                  : icache_rd_data_idx[13:0];
assign icache_data_din[127:0] = icache_wr_data_din[127:0];

//------------------------------------------------
// 3. Instance I-Cache Array
//------------------------------------------------
// &Instance("aq_ifu_icache_tag_array", "x_aq_ifu_icache_tag_array"); @257
aq_ifu_icache_tag_array  x_aq_ifu_icache_tag_array (
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .icache_tag_cen     (icache_tag_cen    ),
  .icache_tag_din     (icache_tag_din    ),
  .icache_tag_dout    (icache_tag_dout   ),
  .icache_tag_idx     (icache_tag_idx    ),
  .icache_tag_wen     (icache_tag_wen    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Instance("aq_ifu_icache_data_array", "x_aq_ifu_icache_data_array"); @258
aq_ifu_icache_data_array  x_aq_ifu_icache_data_array (
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .icache_data0_dout  (icache_data0_dout ),
  .icache_data1_dout  (icache_data1_dout ),
  .icache_data2_dout  (icache_data2_dout ),
  .icache_data3_dout  (icache_data3_dout ),
  .icache_data_din    (icache_data_din   ),
  .icache_data_idx    (icache_data_idx   ),
  .icache_data_ren    (icache_data_ren   ),
  .icache_data_wen    (icache_data_wen   ),
  .iop_rd_data        (iop_rd_data       ),
  .iop_rd_way         (iop_rd_way        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


//------------------------------------------------
// 4. I-utlb Access
//------------------------------------------------
assign ifu_mmu_va[51:0] = icache_rd_addr[63:12];
assign ifu_mmu_va_vld   = icache_rd_vld || inv_fsm_flop && inv_type_va;
assign ifu_mmu_abort    = (ctrl_icache_abort || cp0_ifu_lpmd_req)
                       && !(inv_fsm_flop && inv_type_va);

assign icache_pa_vld    = mmu_ifu_pa_vld;
assign icache_pa[39:0]  = {mmu_ifu_pa[27:0], icache_rd_addr[11:0]};
assign icache_prot[4:0] = mmu_ifu_prot[4:0];
assign icache_deny      = mmu_ifu_pa_vld && mmu_ifu_access_fault;

//------------------------------------------------
// 5. I-Cache Hit Judge and Data Select
// a. Cache Tag and Data output
// b. Cache Tag Compare
// c. Cache Data Select
// d. Cache Miss Generation
//------------------------------------------------

// a. Cache Tag and Data output
assign icache_tag_fifo            = icache_tag_dout[58];
assign icache_tag_way1_vld        = icache_tag_dout[57];
assign icache_tag_way1_dout[27:0] = icache_tag_dout[56:29];
assign icache_tag_way0_vld        = icache_tag_dout[28];
assign icache_tag_way0_dout[27:0] = icache_tag_dout[27:0];

// b. Cache Tag Compare
always @ (posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    icache_rd_vld <= 1'b0;
  else if(icache_rd_cen && ref_rdy && inv_fsm_idle)
    icache_rd_vld <= 1'b1;
  else if(icache_pa_vld || direct_sel || ctrl_icache_abort)
    icache_rd_vld <= 1'b0;
end

always @ (posedge icache_rd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    icache_rd_addr[63:0] <= 64'b0;
    icache_en            <= 1'b0;
  end
  else if(icache_rd_cen && ref_rdy)
  begin
    icache_rd_addr[63:0] <= icache_va[63:0];
    icache_en            <= cp0_ifu_icache_en;
  end
  else
  begin
    icache_rd_addr[63:0] <= icache_rd_addr[63:0];
    icache_en            <= icache_en;
  end
end

assign icache_cmp_pa[27:0] = iop_inv_req && inv_type_pa && inv_fsm_flop ? cp0_ifu_icache_inv_addr[39:12]
                                                           : pf_fsm_chk ? icache_refill_addr[39:12]
                                                                        : icache_pa[39:12];
assign icache_way1_hit = {icache_tag_way1_vld, icache_tag_way1_dout[27:0]}
                      == {1'b1,  icache_cmp_pa[27:0]};
assign icache_way0_hit = {icache_tag_way0_vld, icache_tag_way0_dout[27:0]}
                      == {1'b1,  icache_cmp_pa[27:0]};

assign icache_hit      = (icache_way1_hit || icache_way0_hit) && icache_en
                       || icache_deny || icache_prot[4] || direct_sel;

assign icache_hit_vld  = icache_hit && icache_rd_vld && icache_pa_vld
                      || direct_sel && icache_rd_vld;

assign icache_hit1     = direct_sel ?  direct_sel_way : icache_way1_hit;
assign icache_hit0     = direct_sel ? !direct_sel_way : icache_way0_hit;

assign icache_data_32[31:0] = icache_pa[2] ? icache_data3_dout[31:0]
                                           : icache_data2_dout[31:0];
assign icache_data_10[31:0] = icache_pa[2] ? icache_data1_dout[31:0]
                                           : icache_data0_dout[31:0];

assign icache_way1_inst[31:0] = icache_pa[3] ? icache_data_32[31:0]
                                             : icache_data_10[31:0];
assign icache_way0_inst[31:0] = icache_pa[3] ? icache_data_10[31:0]
                                             : icache_data_32[31:0];

assign icache_hit_inst[31:0] = {32{icache_hit1}} & icache_way1_inst[31:0]
                             | {32{icache_hit0}} & icache_way0_inst[31:0];

// d. Cache Miss Generation
assign icache_miss_req        = !icache_hit && icache_rd_vld && icache_pa_vld && !ctrl_icache_abort
                             && !cp0_ifu_lpmd_req;
assign icache_miss_addr[39:0] = icache_pa[39:0];
assign icache_miss_prot[4:0]  = icache_prot[4:0];

//------------------------------------------------
// 5. I-Cache Refill Control
// a. Refill control to ibus
// b. Refill Request to icache
//------------------------------------------------

// a. Refill control to ibus
always @ (posedge icache_refdp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    icache_refill_addr[39:0]   <= 40'b0;
    icache_refill_fifo         <= 1'b0;
    icache_refill_prot[4:0]    <= 5'b0;
    icache_en_f                <= 1'b0;
  end
  else if(icache_miss_req && (ref_fsm_idle || ref_fsm_wfpa))
  begin
    icache_refill_addr[39:0]   <= {icache_miss_addr[39:1], 1'b0};
    icache_refill_fifo         <= icache_tag_fifo;
    icache_refill_prot[4:0]    <= icache_miss_prot[4:0];
    icache_en_f                <= icache_en;
  end
end

assign icache_refill_supv = icache_refill_prot[3];
assign icache_refill_ca   = icache_refill_prot[2] & icache_en_f;
assign icache_refill_ba   = icache_refill_prot[1];
//assign icache_refill_sec  = icache_refill_prot[0];

// Refill FSM
parameter IDLE = 3'b000,
          WFPA = 3'b100,
          REQ  = 3'b001,
          INIT = 3'b010,
          WFC  = 3'b011;

always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ref_cur_st[2:0] <= IDLE;
  else
    ref_cur_st[2:0] <= ref_nxt_st[2:0];
end

// &Force("bus", "biu_ifu_rresp", 1, 0); @399
assign biu_icache_grant     = biu_ifu_arready;
assign biu_icache_ref_cmplt = biu_ifu_rvalid && !biu_ifu_rid;
assign biu_icache_ref_vld   = biu_ifu_rvalid && !biu_ifu_rid && !biu_ifu_rresp[1];
assign biu_icache_ref_err   = biu_ifu_rvalid && !biu_ifu_rid &&  biu_ifu_rresp[1];

// &CombBeg; @405
always @( biu_ifu_rlast
       or biu_icache_ref_cmplt
       or ref_cur_st[2:0]
       or ctrl_icache_abort
       or biu_icache_grant
       or icache_pa_vld
       or icache_miss_req
       or icache_stall
       or cp0_ifu_lpmd_req
       or direct_sel)
begin
case(ref_cur_st[2:0])
  IDLE:
  begin
    if(icache_miss_req)
      ref_nxt_st[2:0] = REQ;
    else if(icache_stall)
      ref_nxt_st[2:0] = WFPA;
    else
      ref_nxt_st[2:0] = IDLE;
  end
  WFPA:
  begin
    if(icache_miss_req)
      ref_nxt_st[2:0] = REQ;
    else if(icache_pa_vld || direct_sel || ctrl_icache_abort || cp0_ifu_lpmd_req)
      ref_nxt_st[2:0] = IDLE;
    else
      ref_nxt_st[2:0] = WFPA;
  end
  REQ: 
  begin
    if (biu_icache_grant)
      ref_nxt_st[2:0] = INIT;
    else
      ref_nxt_st[2:0] = REQ;
  end
  INIT: 
  begin
    if(biu_icache_ref_cmplt)
      if(biu_ifu_rlast)
        ref_nxt_st[2:0] = IDLE;
      else
        ref_nxt_st[2:0] = WFC;
    else
      ref_nxt_st[2:0] = INIT;
  end
  WFC:
  begin
    if(biu_icache_ref_cmplt)
      if(biu_ifu_rlast)
        ref_nxt_st[2:0] = IDLE;
      else
        ref_nxt_st[2:0] = WFC;
    else
      ref_nxt_st[2:0] = WFC;
  end
  default:
  begin
    ref_nxt_st[2:0] = IDLE;
  end
endcase
// &CombEnd; @457
end

// state information 
assign ref_fsm_idle = ref_cur_st[2:0] == IDLE;
assign ref_fsm_wfpa = ref_cur_st[2:0] == WFPA;
assign ref_fsm_req  = ref_cur_st[2:0] == REQ;
assign ref_fsm_init = ref_cur_st[2:0] == INIT;
assign ref_fsm_wfc  = ref_cur_st[2:0] == WFC;

assign icache_stall = icache_rd_vld && !direct_sel && !icache_pa_vld && !ctrl_icache_abort;
assign ref_rdy      = ref_fsm_idle && pf_fsm_idle && !icache_miss_req && !icache_stall;

// refill ibus request 
assign icache_req   = ref_fsm_req;
assign icache_bypass_inst[31:0] = {32{refill_bank3_sel}} & biu_ifu_rdata[127:96]
                                | {32{refill_bank2_sel}} & biu_ifu_rdata[95:64]
                                | {32{refill_bank1_sel}} & biu_ifu_rdata[63:32]
                                | {32{refill_bank0_sel}} & biu_ifu_rdata[31:0];

//refill abort
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    refill_data_abort <= 1'b0;
  else if (ctrl_icache_abort && !ref_fsm_idle && !ref_fsm_wfpa)
    refill_data_abort <= 1'b1;
  else if (ref_fsm_idle)
    refill_data_abort <= 1'b0;
end

//refill error
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    refill_error <= 1'b0;
  else if ((ref_fsm_init || ref_fsm_wfc) && biu_icache_ref_err)
    refill_error <= 1'b1;
  else if (ref_fsm_idle)
    refill_error <= 1'b0;
end

// request counter
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    req_cnt[1:0] <= 2'b00;
  else if((ref_fsm_idle || ref_fsm_wfpa) && icache_miss_req)
    req_cnt[1:0] <= icache_miss_addr[5:4];
  else if(refill_icache_req)
    req_cnt[1:0] <= req_cnt[1:0] + 2'b01;
  else
    req_cnt[1:0] <= req_cnt[1:0];
end

// icache miss 
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    icache_access_ff <= 1'b0;
  else if(icache_rd_vld && ref_fsm_idle && hpcp_ifu_cnt_en && icache_en)
    icache_access_ff <= 1'b1;
  else
    icache_access_ff <= 1'b0;
end
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    icache_miss_ff <= 1'b0;
  else if(icache_miss_req && hpcp_ifu_cnt_en && icache_en)
    icache_miss_ff <= 1'b1;
  else
    icache_miss_ff <= 1'b0;
end

// refill icache request 
assign refill_bank3_sel         = icache_refill_addr[3:2] == 2'b11;
assign refill_bank2_sel         = icache_refill_addr[3:2] == 2'b10;
assign refill_bank1_sel         = icache_refill_addr[3:2] == 2'b01;
assign refill_bank0_sel         = icache_refill_addr[3:2] == 2'b00;

assign refill_icache_req        = biu_icache_ref_vld
                               && icache_refill_ca && !refill_error;
assign refill_icache_init       = ref_fsm_init && biu_icache_ref_cmplt;
assign refill_icache_done       = ref_fsm_wfc && biu_icache_ref_cmplt && biu_ifu_rlast;
assign refill_icache_addr[39:0] = {icache_refill_addr[39:6], req_cnt[1:0], 4'b0};
assign refill_icache_fifo       = icache_refill_fifo;
assign refill_icache_data[127:0] = biu_ifu_rdata[127:0];


//------------------------------------------------
// 5. I-Cache Pre-Fetch Control
// a. Pref control to ibus
// b. Pref Request to icache
//------------------------------------------------
// a. Pref control to ibus
// Prefetch FSM
parameter PF_IDLE = 3'b000,
          PF_READ = 3'b001,
          PF_CHK  = 3'b010,
          PF_REQ  = 3'b011,
          PF_WFC0 = 3'b100,
          PF_WFC1 = 3'b101,
          PF_WFC2 = 3'b110,
          PF_WFC3 = 3'b111;

always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pf_cur_st[2:0] <= PF_IDLE;
  else
    pf_cur_st[2:0] <= pf_nxt_st[2:0];
end

assign pf_chk_vld  = icache_req && biu_icache_grant && cp0_ifu_icache_pref_en
                  && icache_refill_ca;

// tag is the same, so pf uses refill icache hit result
assign pf_chk_pass = !icache_hit && !ctrl_icache_abort;

assign biu_icache_pf_cmplt = biu_ifu_rvalid && biu_ifu_rid;
assign biu_icache_pf_vld   = biu_ifu_rvalid && biu_ifu_rid && !biu_ifu_rresp[1];
assign biu_icache_pf_err   = biu_ifu_rvalid && biu_ifu_rid &&  biu_ifu_rresp[1];

// &CombBeg; @580
always @( biu_icache_grant
       or pf_cur_st[2:0]
       or pf_chk_vld
       or biu_icache_pf_cmplt
       or pf_chk_pass)
begin
case(pf_cur_st[2:0])
  IDLE:
  begin
    if(pf_chk_vld)
      pf_nxt_st[2:0] = PF_READ;
    else
      pf_nxt_st[2:0] = PF_IDLE;
  end
  PF_READ: 
  begin
    pf_nxt_st[2:0] = PF_CHK;
  end
  PF_CHK:
  begin
    if(pf_chk_pass)
      pf_nxt_st[2:0] = PF_REQ;
    else
      pf_nxt_st[2:0] = IDLE;
  end
  PF_REQ: 
  begin
    if (biu_icache_grant)
      pf_nxt_st[2:0] = PF_WFC0;
    else
      pf_nxt_st[2:0] = PF_REQ;
  end
  PF_WFC0:
  begin
    if(biu_icache_pf_cmplt)
      pf_nxt_st[2:0] = PF_WFC1;
    else
      pf_nxt_st[2:0] = PF_WFC0;
  end
  PF_WFC1:
  begin
    if(biu_icache_pf_cmplt)
      pf_nxt_st[2:0] = PF_WFC2;
    else
      pf_nxt_st[2:0] = PF_WFC1;
  end
  PF_WFC2:
  begin
    if(biu_icache_pf_cmplt)
      pf_nxt_st[2:0] = PF_WFC3;
    else
      pf_nxt_st[2:0] = PF_WFC2;
  end
  PF_WFC3:
  begin
    if(biu_icache_pf_cmplt)
      pf_nxt_st[2:0] = IDLE;
    else
      pf_nxt_st[2:0] = PF_WFC3;
  end
  default:
  begin
    pf_nxt_st[2:0] = IDLE;
  end
endcase
// &CombEnd; @640
end

// state information 
assign pf_fsm_idle = pf_cur_st[2:0] == PF_IDLE;
assign pf_fsm_chk  = pf_cur_st[2:0] == PF_CHK;
assign pf_fsm_req  = pf_cur_st[2:0] == PF_REQ;
assign pf_fsm_wfc0 = pf_cur_st[2:0] == PF_WFC0;
//assign pf_fsm_wfc1 = pf_cur_st[2:0] == PF_WFC1;
//assign pf_fsm_wfc2 = pf_cur_st[2:0] == PF_WFC2;
assign pf_fsm_wfc3 = pf_cur_st[2:0] == PF_WFC3;

assign pf_chk_req  = pf_cur_st[2:0] == PF_READ;
assign pf_chk_addr[63:0] = {icache_rd_addr[63:12], icache_rd_addr[11:6] + 6'b1, 6'b0};

assign pf_biu_req        = pf_fsm_req;
assign pf_req_addr[39:0] = {icache_refill_addr[39:12], icache_refill_addr[11:6] + 6'b1, 6'b0};
assign pf_req_va[39:0]   = {icache_rd_addr[39:12], icache_rd_addr[11:6] + 6'b1, 6'b0};

// prefetch error
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pf_err_ff <= 1'b0;
  else if (pf_cur_st[2] && biu_icache_pf_err)
    pf_err_ff <= 1'b1;
  else if (pf_fsm_idle)
    pf_err_ff <= 1'b0;
end

// b. Pref Request to icache
// prefetch fifo
always @ (posedge icache_reffsm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    pf_fifo <= 1'b0;
  end
  else if(pf_fsm_chk)
  begin
    pf_fifo <= icache_tag_fifo;
  end
end

// refill icache request 
assign pf_icache_req         = biu_icache_pf_vld && !pf_err_ff;
assign pf_icache_init        = pf_fsm_wfc0 && biu_icache_pf_cmplt;
assign pf_icache_done        = pf_fsm_wfc3 && biu_icache_pf_cmplt && biu_ifu_rlast;
assign pf_icache_addr[39:0]  = {pf_req_addr[39:6], pf_cur_st[1:0], 4'b0};
assign pf_icache_fifo        = pf_fifo;
assign pf_icache_data[127:0] = biu_ifu_rdata[127:0];

//------------------------------------------------
// 7. I-Cache Operation Control
// a. Icache-OP FSM
// b. ICache Invalid Request
// c. ICache Read Line Request
//------------------------------------------------
parameter IOP_IDLE = 2'b00;
parameter IOP_WRTE = 2'b10;
parameter IOP_READ = 2'b01;
parameter IOP_FLOP = 2'b11;

// a. Icache-OP FSM
// for I-Cache Invalid and Read I-Cache Line
always @ (posedge icache_inv_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iop_cur_st[1:0] <= IOP_IDLE;
  else
    iop_cur_st[1:0] <= iop_nxt_st[1:0];
end

assign iop_inv_req   = cp0_ifu_icache_inv_req;
assign iop_inv_sel   = iop_inv_req && inv_fsm_read;
assign inv_type_addr = cp0_ifu_icache_inv_type[1];
assign inv_type_va   = inv_type_addr && !cp0_ifu_icache_inv_type[0];
assign inv_type_pa   = inv_type_addr && cp0_ifu_icache_inv_type[0];
assign iop_rd_req    = cp0_ifu_icache_read_req;

// &CombBeg; @719
always @( inv_type_addr
       or inv_type_pa
       or iop_cur_st[1:0]
       or iop_inv_req
       or iop_rd_req
       or inv_type_va
       or icache_pa_vld
       or ref_rdy
       or icache_prot[4]
       or icache_inv_done
       or icache_deny)
begin
case(iop_cur_st[1:0])
  IOP_IDLE: begin
    if(iop_inv_req && ref_rdy)
      iop_nxt_st[1:0] = inv_type_addr ? IOP_READ : IOP_WRTE;
    else if(iop_rd_req && ref_rdy)
      iop_nxt_st[1:0] = IOP_READ;
    else
      iop_nxt_st[1:0] = IOP_IDLE;
  end
  IOP_WRTE: begin
    if(icache_inv_done)
      iop_nxt_st[1:0] = IOP_IDLE;
    else if(inv_type_pa)
      iop_nxt_st[1:0] = IOP_READ;
    else
      iop_nxt_st[1:0] = IOP_WRTE;
  end
  IOP_READ: 
      iop_nxt_st[1:0] = IOP_FLOP;
  IOP_FLOP: 
    if(iop_rd_req)
      iop_nxt_st[1:0] = IOP_IDLE;
    else if(inv_type_va && icache_pa_vld)
      if(icache_deny || icache_prot[4])
        iop_nxt_st[1:0] = IOP_IDLE;
      else
        iop_nxt_st[1:0] = IOP_WRTE;
    else if(inv_type_va && !icache_pa_vld)
      iop_nxt_st[1:0] = IOP_FLOP;
    else
      iop_nxt_st[1:0] = IOP_WRTE;
  default: iop_nxt_st[1:0] = IOP_IDLE;
endcase
// &CombEnd; @753
end

assign inv_fsm_idle  = iop_cur_st[1:0] == IOP_IDLE && !iop_inv_req && !iop_rd_req;
assign inv_fsm_write = iop_cur_st[1:0] == IOP_WRTE;
assign inv_fsm_read  = iop_cur_st[1:0] == IOP_READ;
assign inv_fsm_flop  = iop_cur_st[1:0] == IOP_FLOP;

always @ (posedge icache_inv_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iaq_way_sel[1:0] <= 2'b0;
  else if (inv_fsm_flop)
    iaq_way_sel[1:0] <= {icache_way1_hit,icache_way0_hit};
end

// b. ICache Invalid Request
assign inv_way_sel[1:0] = inv_type_addr ? iaq_way_sel[1:0] : 2'b11;

assign icache_inv_wt   = inv_fsm_write && (|inv_way_sel[1:0]);

assign icache_inv_req  = icache_inv_wt;
assign icache_inv_wen[2:0]  = {3{icache_inv_wt}}
                            & {!inv_type_addr, inv_way_sel[1:0]};
assign icache_inv_din[58:0] = 59'b0;
assign icache_inv_pa_idx[8:0] = {icache_inv_idx_high[2:0], cp0_ifu_icache_inv_addr[11:6]};
assign icache_inv_idx[8:0]  = inv_type_addr ? icache_inv_pa_idx[8:0]
                                            : inv_cnt[8:0];
assign iop_inv_rd_addr[63:0] = inv_type_pa ? {cp0_ifu_icache_inv_addr[63:15], icache_inv_idx[8:0], 
                                              cp0_ifu_icache_inv_addr[5:0]}
                                            : cp0_ifu_icache_inv_addr[63:0];

assign inv_cnt_en = inv_fsm_write && !inv_type_addr
                 || inv_fsm_write && inv_type_pa && inv_idx_alias;

assign inv_cnt_max[8:0] = 9'hff;
assign inv_idx_alias    = 1'b1;
assign als_cnt_max[8:0] = 9'h3;
assign icache_inv_idx_high[2:0] = {cp0_ifu_icache_inv_addr[14],
                                   cp0_ifu_icache_inv_addr[13:12] + inv_cnt[1:0]};

always @ (posedge icache_inv_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inv_cnt[8:0] <= {9{1'b0}};
  else if(inv_fsm_write && icache_inv_done)
    inv_cnt[8:0] <= {9{1'b0}};
  else if(inv_cnt_en)
    inv_cnt[8:0] <= inv_cnt[8:0] + 9'b1;
  else
    inv_cnt[8:0] <= inv_cnt[8:0];
end
assign icache_inv_done = inv_type_pa && !inv_idx_alias
                     ||  inv_type_pa && inv_cnt[8:0] == als_cnt_max[8:0] && inv_idx_alias
                     ||  inv_type_va
                     || !inv_type_addr && inv_cnt[8:0] == inv_cnt_max[8:0];

assign icache_inv_err  = inv_fsm_flop && inv_type_va && icache_pa_vld && (icache_deny || icache_prot[4]);

// c. ICache Read Line Request
assign iop_rd_idx[13:0] = cp0_ifu_icache_read_index[13:0];
assign iop_rd_tag       = cp0_ifu_icache_read_tag;
assign iop_rd_way       = cp0_ifu_icache_read_way;
assign iop_rd_data      = inv_fsm_read && iop_rd_req && !cp0_ifu_icache_read_tag;

// result sel for iop read cache line
assign iop_rd_tag_out[127:0] = 
          {88'b0, iop_rd_way ? icache_tag_way1_dout[27:0] : icache_tag_way0_dout[27:0],
           11'b0, iop_rd_way ? icache_tag_way1_vld        : icache_tag_way0_vld};
assign iop_rd_data_out[127:0] = iop_rd_way  
                              ? {icache_data1_dout[31:0], icache_data0_dout[31:0],
                                 icache_data3_dout[31:0], icache_data2_dout[31:0]}
                              : {icache_data3_dout[31:0], icache_data2_dout[31:0],
                                 icache_data1_dout[31:0], icache_data0_dout[31:0]};
assign iop_rd_rslt[127:0] = iop_rd_tag ? iop_rd_tag_out[127:0] :  iop_rd_data_out[127:0];

//==========================================================
// Rename for Output
//==========================================================
// Output to I-Pack
assign icache_bypass_vld          = refill_icache_init && !refill_data_abort;
assign icache_ipack_inst_vld      = icache_bypass_vld || icache_hit_vld;
assign icache_ipack_inst_vld_gate = icache_bypass_vld || icache_rd_vld;
assign icache_ipack_inst[31:0]    = icache_bypass_vld ? icache_bypass_inst[31:0]
                                                      : icache_hit_inst[31:0];
assign icache_ipack_acc_err       = icache_bypass_vld ? biu_icache_ref_err
                                                      : icache_deny;
assign icache_ipack_unalign       = icache_bypass_vld ? icache_refill_addr[1]
                                                      : icache_pa[1];
assign icache_ipack_pgflt         = icache_prot[4];

// Output to top
assign icache_ctrl_stall          = !icache_pa_vld;

// Output to pred
assign icache_pred_inst_vld       = icache_bypass_vld || icache_hit_vld;
assign icache_pred_inst_vld_gate  = icache_bypass_vld || icache_rd_vld;

// Output to BTB
assign icache_btb_grant           = ref_rdy;

// Output to pcgen
assign icache_pcgen_grant         = ref_rdy && ctrl_icache_req_vld;
assign icache_pcgen_grant_gate    = ref_rdy;
assign icache_pcgen_inst_vld      = icache_bypass_vld || icache_hit_vld;
assign icache_pcgen_inst_vld_gate = icache_bypass_vld || icache_rd_vld;
assign icache_pcgen_addr[39:0]    = icache_rd_addr[39:0];

// Output to top
assign icache_top_rd_vld      = icache_rd_vld;
assign icache_top_ref_st[1:0] = ref_cur_st[1:0];
assign icache_top_inv_st[1:0] = iop_cur_st[1:0];
assign icache_top_abort       = refill_data_abort;

// Output to BIU
assign ifu_biu_arvalid       = icache_req || pf_biu_req;
assign ifu_biu_araddr[39:0]  = pf_biu_req ? pf_req_addr[39:0]
                                          : {icache_refill_addr[39:4], 4'b0};
assign ifu_biu_arid          = !icache_req;
assign ifu_biu_arlen[1:0]    = icache_refill_ca ? 2'b11 : 2'b00;
assign ifu_biu_arsize[2:0]   = 3'b100;
assign ifu_biu_arburst[1:0]  = icache_refill_ca ? 2'b10 : 2'b01;
assign ifu_biu_arcache[3:0]  = {icache_refill_prot[2], icache_refill_prot[2], 1'b1, icache_refill_ba};
assign ifu_biu_arprot[2:0]   = {1'b1, 1'b1, icache_refill_supv};
//assign ifu_biu_ardomain[1:0] = 2'b01;
//assign ifu_biu_aruser[1:0]   = {icache_refill_supv, 1'b0};

// Output to CP0
assign ifu_cp0_icache_inv_done         = inv_fsm_write && icache_inv_done || icache_inv_err;
assign ifu_cp0_icache_read_data_vld    = inv_fsm_flop && iop_rd_req;
assign ifu_cp0_icache_read_data[127:0] = iop_rd_rslt[127:0];

// Output to HPCP
assign ifu_hpcp_icache_access = icache_access_ff;
assign ifu_hpcp_icache_miss   = icache_miss_ff;

// Output to had
//assign ifu_had_no_op          = ref_fsm_idle && pf_fsm_idle;

// Output to Broadcast
assign ifu_yy_xx_no_op        = ref_fsm_idle && pf_fsm_idle;

// &Force("nonport", "tag_cen_src"); @916
// &Force("nonport", "data_cen_src"); @917
// &Force("nonport", "icache_wfpa"); @918

// &ModuleEnd; @996
endmodule


