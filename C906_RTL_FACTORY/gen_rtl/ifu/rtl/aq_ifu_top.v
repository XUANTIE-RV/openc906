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
module aq_ifu_top(
  biu_ifu_arready,
  biu_ifu_rdata,
  biu_ifu_rid,
  biu_ifu_rlast,
  biu_ifu_rresp,
  biu_ifu_rvalid,
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
  cp0_xx_mrvbr,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_ifu_debug_inst,
  dtu_ifu_debug_inst_vld,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  dtu_ifu_halt_info_vld,
  dtu_ifu_halt_on_reset,
  forever_cpuclk,
  hpcp_ifu_cnt_en,
  idu_ifu_id_stall,
  ifu_biu_araddr,
  ifu_biu_arburst,
  ifu_biu_arcache,
  ifu_biu_arid,
  ifu_biu_arlen,
  ifu_biu_arprot,
  ifu_biu_arsize,
  ifu_biu_arvalid,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_icache_read_data,
  ifu_cp0_icache_read_data_vld,
  ifu_cp0_rst_inv_req,
  ifu_cp0_warm_up,
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
  ifu_idu_id_bht_pred,
  ifu_idu_id_expt_acc_error,
  ifu_idu_id_expt_high,
  ifu_idu_id_expt_page_fault,
  ifu_idu_id_halt_info,
  ifu_idu_id_inst,
  ifu_idu_id_inst_vld,
  ifu_idu_warm_up,
  ifu_iu_chgflw_pc,
  ifu_iu_chgflw_vld,
  ifu_iu_ex1_pc_pred,
  ifu_iu_reset_vld,
  ifu_iu_warm_up,
  ifu_lsu_warm_up,
  ifu_mmu_abort,
  ifu_mmu_va,
  ifu_mmu_va_vld,
  ifu_rtu_reset_halt_req,
  ifu_rtu_warm_up,
  ifu_vidu_warm_up,
  ifu_vpu_warm_up,
  ifu_yy_xx_no_op,
  iu_ifu_bht_cur_pc,
  iu_ifu_bht_mispred,
  iu_ifu_bht_mispred_gate,
  iu_ifu_bht_pred,
  iu_ifu_bht_taken,
  iu_ifu_br_vld,
  iu_ifu_br_vld_gate,
  iu_ifu_link_vld,
  iu_ifu_link_vld_gate,
  iu_ifu_pc_mispred,
  iu_ifu_pc_mispred_gate,
  iu_ifu_ret_vld,
  iu_ifu_ret_vld_gate,
  iu_ifu_tar_pc,
  iu_ifu_tar_pc_vld,
  iu_ifu_tar_pc_vld_gate,
  mmu_ifu_access_fault,
  mmu_ifu_pa,
  mmu_ifu_pa_vld,
  mmu_ifu_prot,
  pad_yy_icg_scan_en,
  rtu_ifu_chgflw_pc,
  rtu_ifu_chgflw_vld,
  rtu_ifu_dbg_mask,
  rtu_ifu_flush_fe,
  rtu_yy_xx_dbgon
);

// &Ports; @24
input            biu_ifu_arready;             
input   [127:0]  biu_ifu_rdata;               
input            biu_ifu_rid;                 
input            biu_ifu_rlast;               
input   [1  :0]  biu_ifu_rresp;               
input            biu_ifu_rvalid;              
input            cp0_ifu_bht_en;              
input            cp0_ifu_bht_inv;             
input            cp0_ifu_btb_clr;             
input            cp0_ifu_btb_en;              
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
input            cp0_ifu_in_lpmd;             
input            cp0_ifu_iwpe;                
input            cp0_ifu_lpmd_req;            
input            cp0_ifu_ras_en;              
input            cp0_ifu_rst_inv_done;        
input   [39 :0]  cp0_xx_mrvbr;                
input            cp0_yy_clk_en;               
input            cpurst_b;                    
input   [31 :0]  dtu_ifu_debug_inst;          
input            dtu_ifu_debug_inst_vld;      
input   [21 :0]  dtu_ifu_halt_info0;          
input   [21 :0]  dtu_ifu_halt_info1;          
input            dtu_ifu_halt_info_vld;       
input            dtu_ifu_halt_on_reset;       
input            forever_cpuclk;              
input            hpcp_ifu_cnt_en;             
input            idu_ifu_id_stall;            
input   [39 :0]  iu_ifu_bht_cur_pc;           
input            iu_ifu_bht_mispred;          
input            iu_ifu_bht_mispred_gate;     
input   [1  :0]  iu_ifu_bht_pred;             
input            iu_ifu_bht_taken;            
input            iu_ifu_br_vld;               
input            iu_ifu_br_vld_gate;          
input            iu_ifu_link_vld;             
input            iu_ifu_link_vld_gate;        
input            iu_ifu_pc_mispred;           
input            iu_ifu_pc_mispred_gate;      
input            iu_ifu_ret_vld;              
input            iu_ifu_ret_vld_gate;         
input   [63 :0]  iu_ifu_tar_pc;               
input            iu_ifu_tar_pc_vld;           
input            iu_ifu_tar_pc_vld_gate;      
input            mmu_ifu_access_fault;        
input   [27 :0]  mmu_ifu_pa;                  
input            mmu_ifu_pa_vld;              
input   [4  :0]  mmu_ifu_prot;                
input            pad_yy_icg_scan_en;          
input   [39 :0]  rtu_ifu_chgflw_pc;           
input            rtu_ifu_chgflw_vld;          
input            rtu_ifu_dbg_mask;            
input            rtu_ifu_flush_fe;            
input            rtu_yy_xx_dbgon;             
output  [39 :0]  ifu_biu_araddr;              
output  [1  :0]  ifu_biu_arburst;             
output  [3  :0]  ifu_biu_arcache;             
output           ifu_biu_arid;                
output  [1  :0]  ifu_biu_arlen;               
output  [2  :0]  ifu_biu_arprot;              
output  [2  :0]  ifu_biu_arsize;              
output           ifu_biu_arvalid;             
output           ifu_cp0_bht_inv_done;        
output           ifu_cp0_icache_inv_done;     
output  [127:0]  ifu_cp0_icache_read_data;    
output           ifu_cp0_icache_read_data_vld; 
output           ifu_cp0_rst_inv_req;         
output           ifu_cp0_warm_up;             
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
output  [1  :0]  ifu_idu_id_bht_pred;         
output           ifu_idu_id_expt_acc_error;   
output           ifu_idu_id_expt_high;        
output           ifu_idu_id_expt_page_fault;  
output  [21 :0]  ifu_idu_id_halt_info;        
output  [31 :0]  ifu_idu_id_inst;             
output           ifu_idu_id_inst_vld;         
output           ifu_idu_warm_up;             
output  [39 :0]  ifu_iu_chgflw_pc;            
output           ifu_iu_chgflw_vld;           
output  [39 :0]  ifu_iu_ex1_pc_pred;          
output           ifu_iu_reset_vld;            
output           ifu_iu_warm_up;              
output           ifu_lsu_warm_up;             
output           ifu_mmu_abort;               
output  [51 :0]  ifu_mmu_va;                  
output           ifu_mmu_va_vld;              
output           ifu_rtu_reset_halt_req;      
output           ifu_rtu_warm_up;             
output           ifu_vidu_warm_up;            
output           ifu_vpu_warm_up;             
output           ifu_yy_xx_no_op;             

// &Regs; @25

// &Wires; @26
wire    [1  :0]  bht_top_cur_st;              
wire             biu_ifu_arready;             
wire    [127:0]  biu_ifu_rdata;               
wire             biu_ifu_rid;                 
wire             biu_ifu_rlast;               
wire    [1  :0]  biu_ifu_rresp;               
wire             biu_ifu_rvalid;              
wire    [39 :0]  btb_pcgen_tar_pc;            
wire    [39 :0]  btb_pred_tar_pc;             
wire             btb_pred_tar_vld;            
wire             btb_xx_chgflw_vld;           
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
wire    [39 :0]  cp0_xx_mrvbr;                
wire             cp0_yy_clk_en;               
wire             cpurst_b;                    
wire             ctrl_btb_chgflw_vld;         
wire             ctrl_btb_inst_fetch;         
wire             ctrl_btb_stall;              
wire             ctrl_ibuf_pop_en;            
wire             ctrl_icache_abort;           
wire             ctrl_icache_req_vld;         
wire             ctrl_ipack_cancel;           
wire    [31 :0]  dtu_ifu_debug_inst;          
wire             dtu_ifu_debug_inst_vld;      
wire    [21 :0]  dtu_ifu_halt_info0;          
wire    [21 :0]  dtu_ifu_halt_info1;          
wire             dtu_ifu_halt_info_vld;       
wire             dtu_ifu_halt_on_reset;       
wire             forever_cpuclk;              
wire             hpcp_ifu_cnt_en;             
wire             ibuf_ctrl_inst_fetch;        
wire             ibuf_ipack_stall;            
wire             ibuf_pred_hungry;            
wire             ibuf_pred_stall;             
wire             ibuf_top_id_stall;           
wire             ibuf_top_pop_entry_vld;      
wire    [2  :0]  ibuf_top_vld_num;            
wire             icache_btb_grant;            
wire             icache_ctrl_stall;           
wire             icache_ipack_acc_err;        
wire    [31 :0]  icache_ipack_inst;           
wire             icache_ipack_inst_vld;       
wire             icache_ipack_inst_vld_gate;  
wire             icache_ipack_pgflt;          
wire             icache_ipack_unalign;        
wire    [39 :0]  icache_pcgen_addr;           
wire             icache_pcgen_grant;          
wire             icache_pcgen_grant_gate;     
wire             icache_pcgen_inst_vld;       
wire             icache_pcgen_inst_vld_gate;  
wire             icache_pred_inst_vld;        
wire             icache_pred_inst_vld_gate;   
wire             icache_top_abort;            
wire    [1  :0]  icache_top_inv_st;           
wire             icache_top_rd_vld;           
wire    [1  :0]  icache_top_ref_st;           
wire             idu_ifu_id_stall;            
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
wire    [2  :0]  ipack_ibuf_acc_err;          
wire    [47 :0]  ipack_ibuf_inst;             
wire             ipack_ibuf_inst_all;         
wire             ipack_ibuf_inst_full;        
wire             ipack_ibuf_inst_one;         
wire             ipack_ibuf_inst_two;         
wire             ipack_ibuf_inst_vld;         
wire             ipack_ibuf_inst_vld_raw;     
wire    [2  :0]  ipack_ibuf_pgflt;            
wire             ipack_pcgen_reissue;         
wire             ipack_pred_h0_create;        
wire             ipack_pred_h0_vld;           
wire    [31 :0]  ipack_pred_inst0;            
wire             ipack_pred_inst0_expt;       
wire             ipack_pred_inst0_vld;        
wire    [15 :0]  ipack_pred_inst1;            
wire             ipack_pred_inst1_expt;       
wire             ipack_pred_inst1_vld;        
wire             ipack_pred_unalign;          
wire             ipack_top_entry0_vld;        
wire             ipack_top_entry1_vld;        
wire             ipack_top_entry2_vld;        
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
wire             mmu_ifu_access_fault;        
wire    [27 :0]  mmu_ifu_pa;                  
wire             mmu_ifu_pa_vld;              
wire    [4  :0]  mmu_ifu_prot;                
wire             pad_yy_icg_scan_en;          
wire    [39 :0]  pcgen_btb_ifpc;              
wire             pcgen_ctrl_chgflw_vld;       
wire             pcgen_ibuf_chgflw_vld;       
wire             pcgen_icache_chgflw_vld;     
wire    [33 :0]  pcgen_icache_seq_tag;        
wire    [63 :0]  pcgen_icache_va;             
wire             pcgen_pred_flush_vld;        
wire    [39 :0]  pcgen_pred_ifpc;             
wire             pcgen_top_buf_chgflw;        
wire             pred_btb_chgflw_vld;         
wire    [39 :0]  pred_btb_cur_pc;             
wire             pred_btb_inst_vld;           
wire             pred_btb_mis_pred;           
wire             pred_btb_mis_predg;          
wire             pred_btb_stall;              
wire    [39 :0]  pred_btb_tar_pc;             
wire             pred_btb_upd_vld;            
wire             pred_btb_upd_vldg;           
wire             pred_ctrl_stall;             
wire    [1  :0]  pred_ibuf_br_taken0;         
wire    [1  :0]  pred_ibuf_br_taken1;         
wire             pred_ibuf_chgflw_vld0;       
wire    [21 :0]  pred_ibuf_halt_info0;        
wire    [21 :0]  pred_ibuf_halt_info1;        
wire             pred_ipack_chgflw_vld0;      
wire             pred_ipack_delay_stall;      
wire             pred_ipack_mask;             
wire             pred_ipack_ret_stall;        
wire    [39 :0]  pred_pcgen_chgflw_pc;        
wire             pred_pcgen_chgflw_vld;       
wire             pred_pcgen_chgflw_vld_gate;  
wire    [39 :0]  pred_pcgen_curflw_pc;        
wire             pred_pcgen_curflw_vld;       
wire             pred_pcgen_curflw_vld_gate;  
wire             pred_top_delay_chgflw;       
wire             pred_top_ras_st;             
wire    [39 :0]  rtu_ifu_chgflw_pc;           
wire             rtu_ifu_chgflw_vld;          
wire             rtu_ifu_dbg_mask;            
wire             rtu_ifu_flush_fe;            
wire             rtu_yy_xx_dbgon;             
wire             vec_ctrl_reset_mask;         
wire             vec_ibuf_warm_up;            
wire             vec_pcgen_idle;              
wire             vec_pcgen_rst_vld;           
wire    [1  :0]  vec_top_cur_st;              


// PC-Generation Module
// &Instance("aq_ifu_pcgen"); @29
aq_ifu_pcgen  x_aq_ifu_pcgen (
  .btb_pcgen_tar_pc           (btb_pcgen_tar_pc          ),
  .btb_xx_chgflw_vld          (btb_xx_chgflw_vld         ),
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_xx_mrvbr               (cp0_xx_mrvbr              ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .icache_pcgen_addr          (icache_pcgen_addr         ),
  .icache_pcgen_grant         (icache_pcgen_grant        ),
  .icache_pcgen_grant_gate    (icache_pcgen_grant_gate   ),
  .icache_pcgen_inst_vld      (icache_pcgen_inst_vld     ),
  .icache_pcgen_inst_vld_gate (icache_pcgen_inst_vld_gate),
  .ifu_iu_chgflw_pc           (ifu_iu_chgflw_pc          ),
  .ifu_iu_chgflw_vld          (ifu_iu_chgflw_vld         ),
  .ipack_pcgen_reissue        (ipack_pcgen_reissue       ),
  .iu_ifu_tar_pc              (iu_ifu_tar_pc             ),
  .iu_ifu_tar_pc_vld          (iu_ifu_tar_pc_vld         ),
  .iu_ifu_tar_pc_vld_gate     (iu_ifu_tar_pc_vld_gate    ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .pcgen_btb_ifpc             (pcgen_btb_ifpc            ),
  .pcgen_ctrl_chgflw_vld      (pcgen_ctrl_chgflw_vld     ),
  .pcgen_ibuf_chgflw_vld      (pcgen_ibuf_chgflw_vld     ),
  .pcgen_icache_chgflw_vld    (pcgen_icache_chgflw_vld   ),
  .pcgen_icache_seq_tag       (pcgen_icache_seq_tag      ),
  .pcgen_icache_va            (pcgen_icache_va           ),
  .pcgen_pred_flush_vld       (pcgen_pred_flush_vld      ),
  .pcgen_pred_ifpc            (pcgen_pred_ifpc           ),
  .pcgen_top_buf_chgflw       (pcgen_top_buf_chgflw      ),
  .pred_pcgen_chgflw_pc       (pred_pcgen_chgflw_pc      ),
  .pred_pcgen_chgflw_vld      (pred_pcgen_chgflw_vld     ),
  .pred_pcgen_chgflw_vld_gate (pred_pcgen_chgflw_vld_gate),
  .pred_pcgen_curflw_pc       (pred_pcgen_curflw_pc      ),
  .pred_pcgen_curflw_vld      (pred_pcgen_curflw_vld     ),
  .pred_pcgen_curflw_vld_gate (pred_pcgen_curflw_vld_gate),
  .rtu_ifu_chgflw_pc          (rtu_ifu_chgflw_pc         ),
  .rtu_ifu_chgflw_vld         (rtu_ifu_chgflw_vld        ),
  .vec_pcgen_idle             (vec_pcgen_idle            ),
  .vec_pcgen_rst_vld          (vec_pcgen_rst_vld         )
);


// Control Module
// &Instance("aq_ifu_ctrl"); @32
aq_ifu_ctrl  x_aq_ifu_ctrl (
  .cp0_ifu_in_lpmd       (cp0_ifu_in_lpmd      ),
  .cp0_ifu_lpmd_req      (cp0_ifu_lpmd_req     ),
  .ctrl_btb_chgflw_vld   (ctrl_btb_chgflw_vld  ),
  .ctrl_btb_inst_fetch   (ctrl_btb_inst_fetch  ),
  .ctrl_btb_stall        (ctrl_btb_stall       ),
  .ctrl_ibuf_pop_en      (ctrl_ibuf_pop_en     ),
  .ctrl_icache_abort     (ctrl_icache_abort    ),
  .ctrl_icache_req_vld   (ctrl_icache_req_vld  ),
  .ctrl_ipack_cancel     (ctrl_ipack_cancel    ),
  .ibuf_ctrl_inst_fetch  (ibuf_ctrl_inst_fetch ),
  .icache_ctrl_stall     (icache_ctrl_stall    ),
  .idu_ifu_id_stall      (idu_ifu_id_stall     ),
  .pcgen_ctrl_chgflw_vld (pcgen_ctrl_chgflw_vld),
  .pred_ctrl_stall       (pred_ctrl_stall      ),
  .rtu_ifu_dbg_mask      (rtu_ifu_dbg_mask     ),
  .rtu_ifu_flush_fe      (rtu_ifu_flush_fe     ),
  .vec_ctrl_reset_mask   (vec_ctrl_reset_mask  )
);


// Instruction-Fetch Module
// &Instance("aq_ifu_icache"); @35
aq_ifu_icache  x_aq_ifu_icache (
  .biu_ifu_arready              (biu_ifu_arready             ),
  .biu_ifu_rdata                (biu_ifu_rdata               ),
  .biu_ifu_rid                  (biu_ifu_rid                 ),
  .biu_ifu_rlast                (biu_ifu_rlast               ),
  .biu_ifu_rresp                (biu_ifu_rresp               ),
  .biu_ifu_rvalid               (biu_ifu_rvalid              ),
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
  .cp0_ifu_iwpe                 (cp0_ifu_iwpe                ),
  .cp0_ifu_lpmd_req             (cp0_ifu_lpmd_req            ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .ctrl_icache_abort            (ctrl_icache_abort           ),
  .ctrl_icache_req_vld          (ctrl_icache_req_vld         ),
  .forever_cpuclk               (forever_cpuclk              ),
  .hpcp_ifu_cnt_en              (hpcp_ifu_cnt_en             ),
  .icache_btb_grant             (icache_btb_grant            ),
  .icache_ctrl_stall            (icache_ctrl_stall           ),
  .icache_ipack_acc_err         (icache_ipack_acc_err        ),
  .icache_ipack_inst            (icache_ipack_inst           ),
  .icache_ipack_inst_vld        (icache_ipack_inst_vld       ),
  .icache_ipack_inst_vld_gate   (icache_ipack_inst_vld_gate  ),
  .icache_ipack_pgflt           (icache_ipack_pgflt          ),
  .icache_ipack_unalign         (icache_ipack_unalign        ),
  .icache_pcgen_addr            (icache_pcgen_addr           ),
  .icache_pcgen_grant           (icache_pcgen_grant          ),
  .icache_pcgen_grant_gate      (icache_pcgen_grant_gate     ),
  .icache_pcgen_inst_vld        (icache_pcgen_inst_vld       ),
  .icache_pcgen_inst_vld_gate   (icache_pcgen_inst_vld_gate  ),
  .icache_pred_inst_vld         (icache_pred_inst_vld        ),
  .icache_pred_inst_vld_gate    (icache_pred_inst_vld_gate   ),
  .icache_top_abort             (icache_top_abort            ),
  .icache_top_inv_st            (icache_top_inv_st           ),
  .icache_top_rd_vld            (icache_top_rd_vld           ),
  .icache_top_ref_st            (icache_top_ref_st           ),
  .ifu_biu_araddr               (ifu_biu_araddr              ),
  .ifu_biu_arburst              (ifu_biu_arburst             ),
  .ifu_biu_arcache              (ifu_biu_arcache             ),
  .ifu_biu_arid                 (ifu_biu_arid                ),
  .ifu_biu_arlen                (ifu_biu_arlen               ),
  .ifu_biu_arprot               (ifu_biu_arprot              ),
  .ifu_biu_arsize               (ifu_biu_arsize              ),
  .ifu_biu_arvalid              (ifu_biu_arvalid             ),
  .ifu_cp0_icache_inv_done      (ifu_cp0_icache_inv_done     ),
  .ifu_cp0_icache_read_data     (ifu_cp0_icache_read_data    ),
  .ifu_cp0_icache_read_data_vld (ifu_cp0_icache_read_data_vld),
  .ifu_hpcp_icache_access       (ifu_hpcp_icache_access      ),
  .ifu_hpcp_icache_miss         (ifu_hpcp_icache_miss        ),
  .ifu_mmu_abort                (ifu_mmu_abort               ),
  .ifu_mmu_va                   (ifu_mmu_va                  ),
  .ifu_mmu_va_vld               (ifu_mmu_va_vld              ),
  .ifu_yy_xx_no_op              (ifu_yy_xx_no_op             ),
  .mmu_ifu_access_fault         (mmu_ifu_access_fault        ),
  .mmu_ifu_pa                   (mmu_ifu_pa                  ),
  .mmu_ifu_pa_vld               (mmu_ifu_pa_vld              ),
  .mmu_ifu_prot                 (mmu_ifu_prot                ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .pcgen_icache_chgflw_vld      (pcgen_icache_chgflw_vld     ),
  .pcgen_icache_seq_tag         (pcgen_icache_seq_tag        ),
  .pcgen_icache_va              (pcgen_icache_va             )
);


// L0-BTB Module
// &Instance("aq_ifu_btb"); @38
aq_ifu_btb  x_aq_ifu_btb (
  .btb_pcgen_tar_pc       (btb_pcgen_tar_pc      ),
  .btb_pred_tar_pc        (btb_pred_tar_pc       ),
  .btb_pred_tar_vld       (btb_pred_tar_vld      ),
  .btb_xx_chgflw_vld      (btb_xx_chgflw_vld     ),
  .cp0_ifu_btb_clr        (cp0_ifu_btb_clr       ),
  .cp0_ifu_btb_en         (cp0_ifu_btb_en        ),
  .cp0_ifu_icg_en         (cp0_ifu_icg_en        ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .ctrl_btb_chgflw_vld    (ctrl_btb_chgflw_vld   ),
  .ctrl_btb_inst_fetch    (ctrl_btb_inst_fetch   ),
  .ctrl_btb_stall         (ctrl_btb_stall        ),
  .forever_cpuclk         (forever_cpuclk        ),
  .icache_btb_grant       (icache_btb_grant      ),
  .iu_ifu_tar_pc_vld      (iu_ifu_tar_pc_vld     ),
  .iu_ifu_tar_pc_vld_gate (iu_ifu_tar_pc_vld_gate),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .pcgen_btb_ifpc         (pcgen_btb_ifpc        ),
  .pred_btb_chgflw_vld    (pred_btb_chgflw_vld   ),
  .pred_btb_cur_pc        (pred_btb_cur_pc       ),
  .pred_btb_inst_vld      (pred_btb_inst_vld     ),
  .pred_btb_mis_pred      (pred_btb_mis_pred     ),
  .pred_btb_mis_predg     (pred_btb_mis_predg    ),
  .pred_btb_stall         (pred_btb_stall        ),
  .pred_btb_tar_pc        (pred_btb_tar_pc       ),
  .pred_btb_upd_vld       (pred_btb_upd_vld      ),
  .pred_btb_upd_vldg      (pred_btb_upd_vldg     )
);


// Instruction Package Module
// &Instance("aq_ifu_ipack"); @41
aq_ifu_ipack  x_aq_ifu_ipack (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .ctrl_ipack_cancel          (ctrl_ipack_cancel         ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_ipack_stall           (ibuf_ipack_stall          ),
  .icache_ipack_acc_err       (icache_ipack_acc_err      ),
  .icache_ipack_inst          (icache_ipack_inst         ),
  .icache_ipack_inst_vld      (icache_ipack_inst_vld     ),
  .icache_ipack_inst_vld_gate (icache_ipack_inst_vld_gate),
  .icache_ipack_pgflt         (icache_ipack_pgflt        ),
  .icache_ipack_unalign       (icache_ipack_unalign      ),
  .ipack_ibuf_acc_err         (ipack_ibuf_acc_err        ),
  .ipack_ibuf_inst            (ipack_ibuf_inst           ),
  .ipack_ibuf_inst_all        (ipack_ibuf_inst_all       ),
  .ipack_ibuf_inst_full       (ipack_ibuf_inst_full      ),
  .ipack_ibuf_inst_one        (ipack_ibuf_inst_one       ),
  .ipack_ibuf_inst_two        (ipack_ibuf_inst_two       ),
  .ipack_ibuf_inst_vld        (ipack_ibuf_inst_vld       ),
  .ipack_ibuf_inst_vld_raw    (ipack_ibuf_inst_vld_raw   ),
  .ipack_ibuf_pgflt           (ipack_ibuf_pgflt          ),
  .ipack_pcgen_reissue        (ipack_pcgen_reissue       ),
  .ipack_pred_h0_create       (ipack_pred_h0_create      ),
  .ipack_pred_h0_vld          (ipack_pred_h0_vld         ),
  .ipack_pred_inst0           (ipack_pred_inst0          ),
  .ipack_pred_inst0_expt      (ipack_pred_inst0_expt     ),
  .ipack_pred_inst0_vld       (ipack_pred_inst0_vld      ),
  .ipack_pred_inst1           (ipack_pred_inst1          ),
  .ipack_pred_inst1_expt      (ipack_pred_inst1_expt     ),
  .ipack_pred_inst1_vld       (ipack_pred_inst1_vld      ),
  .ipack_pred_unalign         (ipack_pred_unalign        ),
  .ipack_top_entry0_vld       (ipack_top_entry0_vld      ),
  .ipack_top_entry1_vld       (ipack_top_entry1_vld      ),
  .ipack_top_entry2_vld       (ipack_top_entry2_vld      ),
  .iu_ifu_tar_pc_vld          (iu_ifu_tar_pc_vld         ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .pred_ipack_chgflw_vld0     (pred_ipack_chgflw_vld0    ),
  .pred_ipack_delay_stall     (pred_ipack_delay_stall    ),
  .pred_ipack_mask            (pred_ipack_mask           ),
  .pred_ipack_ret_stall       (pred_ipack_ret_stall      ),
  .rtu_ifu_chgflw_vld         (rtu_ifu_chgflw_vld        ),
  .rtu_ifu_flush_fe           (rtu_ifu_flush_fe          )
);


// Instruction Buffer Module
// &Instance("aq_ifu_ibuf"); @44
aq_ifu_ibuf  x_aq_ifu_ibuf (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .ctrl_ibuf_pop_en           (ctrl_ibuf_pop_en          ),
  .dtu_ifu_debug_inst         (dtu_ifu_debug_inst        ),
  .dtu_ifu_debug_inst_vld     (dtu_ifu_debug_inst_vld    ),
  .dtu_ifu_halt_info_vld      (dtu_ifu_halt_info_vld     ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_ctrl_inst_fetch       (ibuf_ctrl_inst_fetch      ),
  .ibuf_ipack_stall           (ibuf_ipack_stall          ),
  .ibuf_pred_hungry           (ibuf_pred_hungry          ),
  .ibuf_pred_stall            (ibuf_pred_stall           ),
  .ibuf_top_id_stall          (ibuf_top_id_stall         ),
  .ibuf_top_pop_entry_vld     (ibuf_top_pop_entry_vld    ),
  .ibuf_top_vld_num           (ibuf_top_vld_num          ),
  .idu_ifu_id_stall           (idu_ifu_id_stall          ),
  .ifu_idu_id_bht_pred        (ifu_idu_id_bht_pred       ),
  .ifu_idu_id_expt_acc_error  (ifu_idu_id_expt_acc_error ),
  .ifu_idu_id_expt_high       (ifu_idu_id_expt_high      ),
  .ifu_idu_id_expt_page_fault (ifu_idu_id_expt_page_fault),
  .ifu_idu_id_halt_info       (ifu_idu_id_halt_info      ),
  .ifu_idu_id_inst            (ifu_idu_id_inst           ),
  .ifu_idu_id_inst_vld        (ifu_idu_id_inst_vld       ),
  .ipack_ibuf_acc_err         (ipack_ibuf_acc_err        ),
  .ipack_ibuf_inst            (ipack_ibuf_inst           ),
  .ipack_ibuf_inst_all        (ipack_ibuf_inst_all       ),
  .ipack_ibuf_inst_full       (ipack_ibuf_inst_full      ),
  .ipack_ibuf_inst_one        (ipack_ibuf_inst_one       ),
  .ipack_ibuf_inst_two        (ipack_ibuf_inst_two       ),
  .ipack_ibuf_inst_vld        (ipack_ibuf_inst_vld       ),
  .ipack_ibuf_inst_vld_raw    (ipack_ibuf_inst_vld_raw   ),
  .ipack_ibuf_pgflt           (ipack_ibuf_pgflt          ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .pcgen_ibuf_chgflw_vld      (pcgen_ibuf_chgflw_vld     ),
  .pred_ibuf_br_taken0        (pred_ibuf_br_taken0       ),
  .pred_ibuf_br_taken1        (pred_ibuf_br_taken1       ),
  .pred_ibuf_chgflw_vld0      (pred_ibuf_chgflw_vld0     ),
  .pred_ibuf_halt_info0       (pred_ibuf_halt_info0      ),
  .pred_ibuf_halt_info1       (pred_ibuf_halt_info1      ),
  .rtu_ifu_flush_fe           (rtu_ifu_flush_fe          ),
  .rtu_yy_xx_dbgon            (rtu_yy_xx_dbgon           ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// Branch Prediction Module
// &Instance("aq_ifu_pred"); @47
aq_ifu_pred  x_aq_ifu_pred (
  .bht_top_cur_st             (bht_top_cur_st            ),
  .btb_pred_tar_pc            (btb_pred_tar_pc           ),
  .btb_pred_tar_vld           (btb_pred_tar_vld          ),
  .cp0_ifu_bht_en             (cp0_ifu_bht_en            ),
  .cp0_ifu_bht_inv            (cp0_ifu_bht_inv           ),
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_ifu_ras_en             (cp0_ifu_ras_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .dtu_ifu_halt_info0         (dtu_ifu_halt_info0        ),
  .dtu_ifu_halt_info1         (dtu_ifu_halt_info1        ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_ipack_stall           (ibuf_ipack_stall          ),
  .ibuf_pred_hungry           (ibuf_pred_hungry          ),
  .ibuf_pred_stall            (ibuf_pred_stall           ),
  .icache_pred_inst_vld       (icache_pred_inst_vld      ),
  .icache_pred_inst_vld_gate  (icache_pred_inst_vld_gate ),
  .ifu_cp0_bht_inv_done       (ifu_cp0_bht_inv_done      ),
  .ifu_dtu_addr_vld0          (ifu_dtu_addr_vld0         ),
  .ifu_dtu_addr_vld1          (ifu_dtu_addr_vld1         ),
  .ifu_dtu_data_vld0          (ifu_dtu_data_vld0         ),
  .ifu_dtu_data_vld1          (ifu_dtu_data_vld1         ),
  .ifu_dtu_exe_addr0          (ifu_dtu_exe_addr0         ),
  .ifu_dtu_exe_addr1          (ifu_dtu_exe_addr1         ),
  .ifu_dtu_exe_data0          (ifu_dtu_exe_data0         ),
  .ifu_dtu_exe_data1          (ifu_dtu_exe_data1         ),
  .ifu_iu_ex1_pc_pred         (ifu_iu_ex1_pc_pred        ),
  .ipack_pred_h0_create       (ipack_pred_h0_create      ),
  .ipack_pred_h0_vld          (ipack_pred_h0_vld         ),
  .ipack_pred_inst0           (ipack_pred_inst0          ),
  .ipack_pred_inst0_expt      (ipack_pred_inst0_expt     ),
  .ipack_pred_inst0_vld       (ipack_pred_inst0_vld      ),
  .ipack_pred_inst1           (ipack_pred_inst1          ),
  .ipack_pred_inst1_expt      (ipack_pred_inst1_expt     ),
  .ipack_pred_inst1_vld       (ipack_pred_inst1_vld      ),
  .ipack_pred_unalign         (ipack_pred_unalign        ),
  .iu_ifu_bht_cur_pc          (iu_ifu_bht_cur_pc         ),
  .iu_ifu_bht_mispred         (iu_ifu_bht_mispred        ),
  .iu_ifu_bht_mispred_gate    (iu_ifu_bht_mispred_gate   ),
  .iu_ifu_bht_pred            (iu_ifu_bht_pred           ),
  .iu_ifu_bht_taken           (iu_ifu_bht_taken          ),
  .iu_ifu_br_vld              (iu_ifu_br_vld             ),
  .iu_ifu_br_vld_gate         (iu_ifu_br_vld_gate        ),
  .iu_ifu_link_vld            (iu_ifu_link_vld           ),
  .iu_ifu_link_vld_gate       (iu_ifu_link_vld_gate      ),
  .iu_ifu_pc_mispred          (iu_ifu_pc_mispred         ),
  .iu_ifu_pc_mispred_gate     (iu_ifu_pc_mispred_gate    ),
  .iu_ifu_ret_vld             (iu_ifu_ret_vld            ),
  .iu_ifu_ret_vld_gate        (iu_ifu_ret_vld_gate       ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .pcgen_pred_flush_vld       (pcgen_pred_flush_vld      ),
  .pcgen_pred_ifpc            (pcgen_pred_ifpc           ),
  .pred_btb_chgflw_vld        (pred_btb_chgflw_vld       ),
  .pred_btb_cur_pc            (pred_btb_cur_pc           ),
  .pred_btb_inst_vld          (pred_btb_inst_vld         ),
  .pred_btb_mis_pred          (pred_btb_mis_pred         ),
  .pred_btb_mis_predg         (pred_btb_mis_predg        ),
  .pred_btb_stall             (pred_btb_stall            ),
  .pred_btb_tar_pc            (pred_btb_tar_pc           ),
  .pred_btb_upd_vld           (pred_btb_upd_vld          ),
  .pred_btb_upd_vldg          (pred_btb_upd_vldg         ),
  .pred_ctrl_stall            (pred_ctrl_stall           ),
  .pred_ibuf_br_taken0        (pred_ibuf_br_taken0       ),
  .pred_ibuf_br_taken1        (pred_ibuf_br_taken1       ),
  .pred_ibuf_chgflw_vld0      (pred_ibuf_chgflw_vld0     ),
  .pred_ibuf_halt_info0       (pred_ibuf_halt_info0      ),
  .pred_ibuf_halt_info1       (pred_ibuf_halt_info1      ),
  .pred_ipack_chgflw_vld0     (pred_ipack_chgflw_vld0    ),
  .pred_ipack_delay_stall     (pred_ipack_delay_stall    ),
  .pred_ipack_mask            (pred_ipack_mask           ),
  .pred_ipack_ret_stall       (pred_ipack_ret_stall      ),
  .pred_pcgen_chgflw_pc       (pred_pcgen_chgflw_pc      ),
  .pred_pcgen_chgflw_vld      (pred_pcgen_chgflw_vld     ),
  .pred_pcgen_chgflw_vld_gate (pred_pcgen_chgflw_vld_gate),
  .pred_pcgen_curflw_pc       (pred_pcgen_curflw_pc      ),
  .pred_pcgen_curflw_vld      (pred_pcgen_curflw_vld     ),
  .pred_pcgen_curflw_vld_gate (pred_pcgen_curflw_vld_gate),
  .pred_top_delay_chgflw      (pred_top_delay_chgflw     ),
  .pred_top_ras_st            (pred_top_ras_st           ),
  .rtu_ifu_flush_fe           (rtu_ifu_flush_fe          )
);


// Vector Module
// &Instance("aq_ifu_vec"); @50
aq_ifu_vec  x_aq_ifu_vec (
  .cp0_ifu_icg_en         (cp0_ifu_icg_en        ),
  .cp0_ifu_rst_inv_done   (cp0_ifu_rst_inv_done  ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .dtu_ifu_halt_on_reset  (dtu_ifu_halt_on_reset ),
  .forever_cpuclk         (forever_cpuclk        ),
  .ifu_cp0_rst_inv_req    (ifu_cp0_rst_inv_req   ),
  .ifu_cp0_warm_up        (ifu_cp0_warm_up       ),
  .ifu_idu_warm_up        (ifu_idu_warm_up       ),
  .ifu_iu_reset_vld       (ifu_iu_reset_vld      ),
  .ifu_iu_warm_up         (ifu_iu_warm_up        ),
  .ifu_lsu_warm_up        (ifu_lsu_warm_up       ),
  .ifu_rtu_reset_halt_req (ifu_rtu_reset_halt_req),
  .ifu_rtu_warm_up        (ifu_rtu_warm_up       ),
  .ifu_vidu_warm_up       (ifu_vidu_warm_up      ),
  .ifu_vpu_warm_up        (ifu_vpu_warm_up       ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .rtu_yy_xx_dbgon        (rtu_yy_xx_dbgon       ),
  .vec_ctrl_reset_mask    (vec_ctrl_reset_mask   ),
  .vec_ibuf_warm_up       (vec_ibuf_warm_up      ),
  .vec_pcgen_idle         (vec_pcgen_idle        ),
  .vec_pcgen_rst_vld      (vec_pcgen_rst_vld     ),
  .vec_top_cur_st         (vec_top_cur_st        )
);


assign ifu_dtu_debug_info[20:0] = {
                                   bht_top_cur_st[1:0],
                                   pred_top_ras_st,
                                   pred_top_delay_chgflw,
                                   ibuf_top_pop_entry_vld,
                                   ibuf_top_id_stall,
                                   ibuf_top_vld_num[2:0],
                                   ipack_top_entry2_vld,
                                   ipack_top_entry1_vld,
                                   ipack_top_entry0_vld,
                                   icache_top_abort,
                                   icache_top_inv_st[1:0],
                                   icache_top_ref_st[1:0],
                                   icache_top_rd_vld,
                                   pcgen_top_buf_chgflw,
                                   vec_top_cur_st[1:0]
                                   };


// &ModuleEnd; @75
endmodule


