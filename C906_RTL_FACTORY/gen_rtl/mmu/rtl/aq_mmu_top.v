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

// &ModuleBeg; @24
module aq_mmu_top(
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
  cp0_yy_priv_mode,
  cpurst_b,
  forever_cpuclk,
  hpcp_mmu_cnt_en,
  ifu_mmu_abort,
  ifu_mmu_va,
  ifu_mmu_va_vld,
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
  mmu_dtu_debug_info,
  mmu_hpcp_dutlb_miss,
  mmu_hpcp_iutlb_miss,
  mmu_hpcp_jtlb_miss,
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
  mmu_pmp_chk1,
  mmu_pmp_pa,
  mmu_pmp_priv_mode,
  mmu_xx_mmu_en,
  mmu_yy_xx_no_op,
  pad_yy_icg_scan_en,
  pmp_mmu_flg,
  pmp_mmu_hit_num,
  pmp_mmu_napot_cross,
  rtu_mmu_bad_vpn,
  rtu_mmu_expt_vld
);

// &Ports; @25
input   [11:0]  cp0_mmu_addr;            
input           cp0_mmu_icg_en;          
input           cp0_mmu_lpmd_req;        
input           cp0_mmu_maee;            
input           cp0_mmu_mxr;             
input           cp0_mmu_ptw_en;          
input   [63:0]  cp0_mmu_satp_data;       
input           cp0_mmu_satp_wen;        
input           cp0_mmu_sum;             
input           cp0_mmu_tlb_all_inv;     
input   [15:0]  cp0_mmu_tlb_asid;        
input           cp0_mmu_tlb_asid_all_inv; 
input   [26:0]  cp0_mmu_tlb_va;          
input           cp0_mmu_tlb_va_all_inv;  
input           cp0_mmu_tlb_va_asid_inv; 
input   [63:0]  cp0_mmu_wdata;           
input           cp0_mmu_wreg;            
input   [1 :0]  cp0_yy_priv_mode;        
input           cpurst_b;                
input           forever_cpuclk;          
input           hpcp_mmu_cnt_en;         
input           ifu_mmu_abort;           
input   [51:0]  ifu_mmu_va;              
input           ifu_mmu_va_vld;          
input           lsu_mmu_abort;           
input           lsu_mmu_bus_error;       
input   [63:0]  lsu_mmu_data;            
input           lsu_mmu_data_vld;        
input   [1 :0]  lsu_mmu_priv_mode;       
input           lsu_mmu_st_inst;         
input   [51:0]  lsu_mmu_va;              
input           lsu_mmu_va_vld;          
input           pad_yy_icg_scan_en;      
input   [3 :0]  pmp_mmu_flg;             
input   [15:0]  pmp_mmu_hit_num;         
input           pmp_mmu_napot_cross;     
input   [26:0]  rtu_mmu_bad_vpn;         
input           rtu_mmu_expt_vld;        
output          mmu_cp0_cmplt;           
output  [63:0]  mmu_cp0_data;            
output          mmu_cp0_tlb_inv_done;    
output  [15:0]  mmu_dtu_debug_info;      
output          mmu_hpcp_dutlb_miss;     
output          mmu_hpcp_iutlb_miss;     
output          mmu_hpcp_jtlb_miss;      
output          mmu_ifu_access_fault;    
output  [27:0]  mmu_ifu_pa;              
output          mmu_ifu_pa_vld;          
output  [4 :0]  mmu_ifu_prot;            
output          mmu_lsu_access_fault;    
output          mmu_lsu_buf;             
output          mmu_lsu_ca;              
output          mmu_lsu_data_req;        
output  [39:0]  mmu_lsu_data_req_addr;   
output          mmu_lsu_data_req_size;   
output  [27:0]  mmu_lsu_pa;              
output          mmu_lsu_pa_vld;          
output          mmu_lsu_page_fault;      
output          mmu_lsu_sec;             
output          mmu_lsu_sh;              
output          mmu_lsu_so;              
output          mmu_pmp_chk1;            
output  [27:0]  mmu_pmp_pa;              
output  [1 :0]  mmu_pmp_priv_mode;       
output          mmu_xx_mmu_en;           
output          mmu_yy_xx_no_op;         

// &Regs; @26

// &Wires; @27
wire            arb_dutlb_grant;         
wire            arb_iutlb_grant;         
wire            arb_jtlb_cmp_va;         
wire    [43:0]  arb_jtlb_data_din;       
wire            arb_jtlb_dutlb_on;       
wire    [1 :0]  arb_jtlb_fifo_din;       
wire            arb_jtlb_fifo_write;     
wire    [8 :0]  arb_jtlb_idx;            
wire            arb_jtlb_iutlb_on;       
wire            arb_jtlb_mach;           
wire            arb_jtlb_oper_on;        
wire    [2 :0]  arb_jtlb_pgs;            
wire            arb_jtlb_ptw_req;        
wire            arb_jtlb_req;            
wire    [47:0]  arb_jtlb_tag_din;        
wire    [27:0]  arb_jtlb_vpn;            
wire    [1 :0]  arb_jtlb_way_sel;        
wire            arb_jtlb_write;          
wire    [15:0]  arb_ptw_asid;            
wire            arb_ptw_dutlb_rd;        
wire            arb_ptw_dutlb_wr;        
wire            arb_ptw_grant;           
wire            arb_ptw_iutlb_on;        
wire    [1 :0]  arb_ptw_priv_mode;       
wire            arb_tlboper_grant;       
wire            arb_tlboper_read_idle;   
wire    [1 :0]  arb_top_cur_st;          
wire    [1 :0]  arb_top_read_st;         
wire            arb_top_tlboper_on;      
wire    [11:0]  cp0_mmu_addr;            
wire            cp0_mmu_icg_en;          
wire            cp0_mmu_lpmd_req;        
wire            cp0_mmu_maee;            
wire            cp0_mmu_mxr;             
wire            cp0_mmu_ptw_en;          
wire    [63:0]  cp0_mmu_satp_data;       
wire            cp0_mmu_satp_wen;        
wire            cp0_mmu_sum;             
wire            cp0_mmu_tlb_all_inv;     
wire    [15:0]  cp0_mmu_tlb_asid;        
wire            cp0_mmu_tlb_asid_all_inv; 
wire    [26:0]  cp0_mmu_tlb_va;          
wire            cp0_mmu_tlb_va_all_inv;  
wire            cp0_mmu_tlb_va_asid_inv; 
wire    [63:0]  cp0_mmu_wdata;           
wire            cp0_mmu_wreg;            
wire    [1 :0]  cp0_yy_priv_mode;        
wire            cpurst_b;                
wire    [15:0]  dutlb_arb_asid;          
wire            dutlb_arb_cmplt;         
wire            dutlb_arb_mach;          
wire    [1 :0]  dutlb_arb_mode;          
wire            dutlb_arb_read;          
wire            dutlb_arb_req;           
wire    [27:0]  dutlb_arb_vpn;           
wire    [1 :0]  dutlb_top_ref_cur_st;    
wire            forever_cpuclk;          
wire            hpcp_mmu_cnt_en;         
wire            ifu_mmu_abort;           
wire    [51:0]  ifu_mmu_va;              
wire            ifu_mmu_va_vld;          
wire    [15:0]  iutlb_arb_asid;          
wire            iutlb_arb_cmplt;         
wire            iutlb_arb_mach;          
wire    [1 :0]  iutlb_arb_mode;          
wire            iutlb_arb_req;           
wire    [27:0]  iutlb_arb_vpn;           
wire    [1 :0]  iutlb_top_ref_cur_st;    
wire            jtlb_arb_mach;           
wire            jtlb_arb_tc_miss;        
wire            jtlb_arb_tc_vld;         
wire    [27:0]  jtlb_arb_vpn;            
wire            jtlb_dutlb_acc_err;      
wire            jtlb_dutlb_pgflt;        
wire            jtlb_dutlb_ref_cmplt;    
wire            jtlb_dutlb_ref_pavld;    
wire            jtlb_iutlb_acc_err;      
wire            jtlb_iutlb_pgflt;        
wire            jtlb_iutlb_ref_cmplt;    
wire            jtlb_iutlb_ref_pavld;    
wire            jtlb_ptw_mach;           
wire            jtlb_ptw_req;            
wire    [27:0]  jtlb_ptw_vpn;            
wire            jtlb_regs_hit;           
wire            jtlb_regs_hit_mult;      
wire    [8 :0]  jtlb_regs_tlbp_hit_index; 
wire            jtlb_tlboper_asid_hit;   
wire            jtlb_tlboper_cmplt;      
wire    [1 :0]  jtlb_tlboper_fifo;       
wire    [1 :0]  jtlb_tlboper_sel;        
wire            jtlb_tlboper_va_hit;     
wire    [15:0]  jtlb_tlbr_asid;          
wire    [15:0]  jtlb_tlbr_flg;           
wire            jtlb_tlbr_g;             
wire    [2 :0]  jtlb_tlbr_pgs;           
wire    [27:0]  jtlb_tlbr_ppn;           
wire    [26:0]  jtlb_tlbr_vpn;           
wire            jtlb_top_utlb_pavld;     
wire    [5 :0]  jtlb_xx_fifo;            
wire            jtlb_xx_mmu_on;          
wire    [14:0]  jtlb_xx_ref_flg;         
wire    [2 :0]  jtlb_xx_ref_pgs;         
wire    [27:0]  jtlb_xx_ref_ppn;         
wire    [27:0]  jtlb_xx_ref_vpn;         
wire            jtlb_xx_tc_read;         
wire            lsu_mmu_abort;           
wire            lsu_mmu_bus_error;       
wire    [63:0]  lsu_mmu_data;            
wire            lsu_mmu_data_vld;        
wire    [1 :0]  lsu_mmu_priv_mode;       
wire            lsu_mmu_st_inst;         
wire    [51:0]  lsu_mmu_va;              
wire            lsu_mmu_va_vld;          
wire            mmu_cp0_cmplt;           
wire    [63:0]  mmu_cp0_data;            
wire            mmu_cp0_tlb_inv_done;    
wire    [15:0]  mmu_dtu_debug_info;      
wire            mmu_hpcp_dutlb_miss;     
wire            mmu_hpcp_iutlb_miss;     
wire            mmu_hpcp_jtlb_miss;      
wire            mmu_ifu_access_fault;    
wire    [27:0]  mmu_ifu_pa;              
wire            mmu_ifu_pa_vld;          
wire    [4 :0]  mmu_ifu_prot;            
wire            mmu_lsu_access_fault;    
wire            mmu_lsu_buf;             
wire            mmu_lsu_ca;              
wire            mmu_lsu_data_req;        
wire    [39:0]  mmu_lsu_data_req_addr;   
wire            mmu_lsu_data_req_size;   
wire    [27:0]  mmu_lsu_pa;              
wire            mmu_lsu_pa_vld;          
wire            mmu_lsu_page_fault;      
wire            mmu_lsu_sec;             
wire            mmu_lsu_sh;              
wire            mmu_lsu_so;              
wire            mmu_pmp_chk1;            
wire    [27:0]  mmu_pmp_pa;              
wire    [1 :0]  mmu_pmp_priv_mode;       
wire    [27:0]  mmu_sysmap_pa;           
wire            mmu_top_clk;             
wire            mmu_top_clk_en;          
wire            mmu_xx_mmu_en;           
wire            mmu_yy_xx_no_op;         
wire            pad_yy_icg_scan_en;      
wire    [3 :0]  pmp_mmu_flg;             
wire    [15:0]  pmp_mmu_hit_num;         
wire            pmp_mmu_napot_cross;     
wire    [1 :0]  ptw_arb_bank_sel;        
wire    [43:0]  ptw_arb_data_din;        
wire    [1 :0]  ptw_arb_fifo_din;        
wire    [2 :0]  ptw_arb_pgs;             
wire            ptw_arb_req;             
wire    [47:0]  ptw_arb_tag_din;         
wire    [26:0]  ptw_arb_vpn;             
wire            ptw_jtlb_ref_acc_err;    
wire            ptw_jtlb_ref_cmplt;      
wire            ptw_jtlb_ref_data_vld;   
wire    [15:0]  ptw_jtlb_ref_flg;        
wire            ptw_jtlb_ref_mach;       
wire            ptw_jtlb_ref_mmu_on;     
wire            ptw_jtlb_ref_pgflt;      
wire    [2 :0]  ptw_jtlb_ref_pgs;        
wire    [27:0]  ptw_jtlb_ref_ppn;        
wire    [27:0]  ptw_jtlb_ref_vpn;        
wire    [4 :0]  ptw_top_cur_st;          
wire    [15:0]  regs_jtlb_cur_asid;      
wire    [15:0]  regs_jtlb_cur_flg;       
wire            regs_jtlb_cur_g;         
wire    [27:0]  regs_jtlb_cur_ppn;       
wire            regs_mmu_en;             
wire    [15:0]  regs_ptw_cur_asid;       
wire    [27:0]  regs_ptw_satp_ppn;       
wire    [15:0]  regs_tlboper_cur_asid;   
wire    [2 :0]  regs_tlboper_cur_pgs;    
wire    [26:0]  regs_tlboper_cur_vpn;    
wire    [15:0]  regs_tlboper_inv_asid;   
wire            regs_tlboper_invall;     
wire            regs_tlboper_invasid;    
wire    [8 :0]  regs_tlboper_mir;        
wire            regs_tlboper_tlbp;       
wire            regs_tlboper_tlbr;       
wire            regs_tlboper_tlbwi;      
wire            regs_tlboper_tlbwr;      
wire    [26:0]  rtu_mmu_bad_vpn;         
wire            rtu_mmu_expt_vld;        
wire    [4 :0]  sysmap_mmu_flg;          
wire    [1 :0]  tlboper_arb_bank_sel;    
wire            tlboper_arb_cmp_va;      
wire    [43:0]  tlboper_arb_data_din;    
wire    [1 :0]  tlboper_arb_fifo_din;    
wire            tlboper_arb_fifo_write;  
wire    [8 :0]  tlboper_arb_idx;         
wire            tlboper_arb_idx_not_va;  
wire            tlboper_arb_req;         
wire    [47:0]  tlboper_arb_tag_din;     
wire    [26:0]  tlboper_arb_vpn;         
wire            tlboper_arb_write;       
wire    [15:0]  tlboper_jtlb_asid;       
wire            tlboper_jtlb_asid_sel;   
wire            tlboper_jtlb_cmp_noasid; 
wire    [15:0]  tlboper_jtlb_inv_asid;   
wire            tlboper_jtlb_tlbwr_on;   
wire            tlboper_ptw_abort;       
wire            tlboper_regs_cmplt;      
wire            tlboper_regs_tlbp_cmplt; 
wire            tlboper_regs_tlbr_cmplt; 
wire            tlboper_top_cp0_cmplt;   
wire            tlboper_top_cp0_oper;    
wire            tlboper_xx_clr;          
wire            tlboper_xx_cmplt;        
wire            tlboper_xx_inv_va_req;   
wire    [2 :0]  tlboper_xx_pgs;          


assign mmu_top_clk_en = cp0_mmu_satp_wen
                     || tlboper_xx_clr
                     || tlboper_xx_inv_va_req
                     || !regs_mmu_en
                     || jtlb_top_utlb_pavld;
// &Force("bus", "ptw_arb_vpn", 26, 0); @34
// &Instance("gated_clk_cell", "x_utlb_gateclk"); @35
gated_clk_cell  x_utlb_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mmu_top_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (mmu_top_clk_en    ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @36
//           .external_en(1'b0          ), @37
//           .global_en  (1'b1          ), @38
//           .module_en  (cp0_mmu_icg_en), @39
//           .local_en   (mmu_top_clk_en), @40
//           .clk_out    (mmu_top_clk   ) @41
//          ); @42

//==========================================================
// Instance utlbs
//==========================================================
// &Instance("aq_mmu_utlb_top","x_aq_mmu_utlb_top"); @47
aq_mmu_utlb_top  x_aq_mmu_utlb_top (
  .arb_dutlb_grant       (arb_dutlb_grant      ),
  .arb_iutlb_grant       (arb_iutlb_grant      ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .dutlb_arb_asid        (dutlb_arb_asid       ),
  .dutlb_arb_cmplt       (dutlb_arb_cmplt      ),
  .dutlb_arb_mach        (dutlb_arb_mach       ),
  .dutlb_arb_mode        (dutlb_arb_mode       ),
  .dutlb_arb_read        (dutlb_arb_read       ),
  .dutlb_arb_req         (dutlb_arb_req        ),
  .dutlb_arb_vpn         (dutlb_arb_vpn        ),
  .dutlb_top_ref_cur_st  (dutlb_top_ref_cur_st ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .ifu_mmu_abort         (ifu_mmu_abort        ),
  .ifu_mmu_va            (ifu_mmu_va           ),
  .ifu_mmu_va_vld        (ifu_mmu_va_vld       ),
  .iutlb_arb_asid        (iutlb_arb_asid       ),
  .iutlb_arb_cmplt       (iutlb_arb_cmplt      ),
  .iutlb_arb_mach        (iutlb_arb_mach       ),
  .iutlb_arb_mode        (iutlb_arb_mode       ),
  .iutlb_arb_req         (iutlb_arb_req        ),
  .iutlb_arb_vpn         (iutlb_arb_vpn        ),
  .iutlb_top_ref_cur_st  (iutlb_top_ref_cur_st ),
  .jtlb_dutlb_acc_err    (jtlb_dutlb_acc_err   ),
  .jtlb_dutlb_pgflt      (jtlb_dutlb_pgflt     ),
  .jtlb_dutlb_ref_cmplt  (jtlb_dutlb_ref_cmplt ),
  .jtlb_dutlb_ref_pavld  (jtlb_dutlb_ref_pavld ),
  .jtlb_iutlb_acc_err    (jtlb_iutlb_acc_err   ),
  .jtlb_iutlb_pgflt      (jtlb_iutlb_pgflt     ),
  .jtlb_iutlb_ref_cmplt  (jtlb_iutlb_ref_cmplt ),
  .jtlb_iutlb_ref_pavld  (jtlb_iutlb_ref_pavld ),
  .jtlb_xx_mmu_on        (jtlb_xx_mmu_on       ),
  .jtlb_xx_ref_flg       (jtlb_xx_ref_flg      ),
  .jtlb_xx_ref_pgs       (jtlb_xx_ref_pgs      ),
  .jtlb_xx_ref_ppn       (jtlb_xx_ref_ppn      ),
  .jtlb_xx_ref_vpn       (jtlb_xx_ref_vpn      ),
  .lsu_mmu_abort         (lsu_mmu_abort        ),
  .lsu_mmu_priv_mode     (lsu_mmu_priv_mode    ),
  .lsu_mmu_st_inst       (lsu_mmu_st_inst      ),
  .lsu_mmu_va            (lsu_mmu_va           ),
  .lsu_mmu_va_vld        (lsu_mmu_va_vld       ),
  .mmu_hpcp_dutlb_miss   (mmu_hpcp_dutlb_miss  ),
  .mmu_hpcp_iutlb_miss   (mmu_hpcp_iutlb_miss  ),
  .mmu_ifu_access_fault  (mmu_ifu_access_fault ),
  .mmu_ifu_pa            (mmu_ifu_pa           ),
  .mmu_ifu_pa_vld        (mmu_ifu_pa_vld       ),
  .mmu_ifu_prot          (mmu_ifu_prot         ),
  .mmu_lsu_access_fault  (mmu_lsu_access_fault ),
  .mmu_lsu_buf           (mmu_lsu_buf          ),
  .mmu_lsu_ca            (mmu_lsu_ca           ),
  .mmu_lsu_pa            (mmu_lsu_pa           ),
  .mmu_lsu_pa_vld        (mmu_lsu_pa_vld       ),
  .mmu_lsu_page_fault    (mmu_lsu_page_fault   ),
  .mmu_lsu_sec           (mmu_lsu_sec          ),
  .mmu_lsu_sh            (mmu_lsu_sh           ),
  .mmu_lsu_so            (mmu_lsu_so           ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .regs_ptw_cur_asid     (regs_ptw_cur_asid    ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req)
);


//==========================================================
// Instance mmu regs
//==========================================================
// &Instance("aq_mmu_regs", "x_aq_mmu_regs"); @52
aq_mmu_regs  x_aq_mmu_regs (
  .cp0_mmu_addr             (cp0_mmu_addr            ),
  .cp0_mmu_icg_en           (cp0_mmu_icg_en          ),
  .cp0_mmu_satp_data        (cp0_mmu_satp_data       ),
  .cp0_mmu_wdata            (cp0_mmu_wdata           ),
  .cp0_mmu_wreg             (cp0_mmu_wreg            ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .jtlb_regs_hit            (jtlb_regs_hit           ),
  .jtlb_regs_hit_mult       (jtlb_regs_hit_mult      ),
  .jtlb_regs_tlbp_hit_index (jtlb_regs_tlbp_hit_index),
  .jtlb_tlbr_asid           (jtlb_tlbr_asid          ),
  .jtlb_tlbr_flg            (jtlb_tlbr_flg           ),
  .jtlb_tlbr_g              (jtlb_tlbr_g             ),
  .jtlb_tlbr_pgs            (jtlb_tlbr_pgs           ),
  .jtlb_tlbr_ppn            (jtlb_tlbr_ppn           ),
  .jtlb_tlbr_vpn            (jtlb_tlbr_vpn           ),
  .mmu_cp0_cmplt            (mmu_cp0_cmplt           ),
  .mmu_cp0_data             (mmu_cp0_data            ),
  .mmu_xx_mmu_en            (mmu_xx_mmu_en           ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .regs_jtlb_cur_asid       (regs_jtlb_cur_asid      ),
  .regs_jtlb_cur_flg        (regs_jtlb_cur_flg       ),
  .regs_jtlb_cur_g          (regs_jtlb_cur_g         ),
  .regs_jtlb_cur_ppn        (regs_jtlb_cur_ppn       ),
  .regs_mmu_en              (regs_mmu_en             ),
  .regs_ptw_cur_asid        (regs_ptw_cur_asid       ),
  .regs_ptw_satp_ppn        (regs_ptw_satp_ppn       ),
  .regs_tlboper_cur_asid    (regs_tlboper_cur_asid   ),
  .regs_tlboper_cur_pgs     (regs_tlboper_cur_pgs    ),
  .regs_tlboper_cur_vpn     (regs_tlboper_cur_vpn    ),
  .regs_tlboper_inv_asid    (regs_tlboper_inv_asid   ),
  .regs_tlboper_invall      (regs_tlboper_invall     ),
  .regs_tlboper_invasid     (regs_tlboper_invasid    ),
  .regs_tlboper_mir         (regs_tlboper_mir        ),
  .regs_tlboper_tlbp        (regs_tlboper_tlbp       ),
  .regs_tlboper_tlbr        (regs_tlboper_tlbr       ),
  .regs_tlboper_tlbwi       (regs_tlboper_tlbwi      ),
  .regs_tlboper_tlbwr       (regs_tlboper_tlbwr      ),
  .rtu_mmu_bad_vpn          (rtu_mmu_bad_vpn         ),
  .rtu_mmu_expt_vld         (rtu_mmu_expt_vld        ),
  .tlboper_regs_cmplt       (tlboper_regs_cmplt      ),
  .tlboper_regs_tlbp_cmplt  (tlboper_regs_tlbp_cmplt ),
  .tlboper_regs_tlbr_cmplt  (tlboper_regs_tlbr_cmplt )
);


//==========================================================
// Instance cp0 request module
//==========================================================
// &Instance("aq_mmu_tlboper", "x_aq_mmu_tlboper"); @57
aq_mmu_tlboper  x_aq_mmu_tlboper (
  .arb_tlboper_grant        (arb_tlboper_grant       ),
  .arb_tlboper_read_idle    (arb_tlboper_read_idle   ),
  .cp0_mmu_icg_en           (cp0_mmu_icg_en          ),
  .cp0_mmu_tlb_all_inv      (cp0_mmu_tlb_all_inv     ),
  .cp0_mmu_tlb_asid         (cp0_mmu_tlb_asid        ),
  .cp0_mmu_tlb_asid_all_inv (cp0_mmu_tlb_asid_all_inv),
  .cp0_mmu_tlb_va           (cp0_mmu_tlb_va          ),
  .cp0_mmu_tlb_va_all_inv   (cp0_mmu_tlb_va_all_inv  ),
  .cp0_mmu_tlb_va_asid_inv  (cp0_mmu_tlb_va_asid_inv ),
  .cpurst_b                 (cpurst_b                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .jtlb_tlboper_asid_hit    (jtlb_tlboper_asid_hit   ),
  .jtlb_tlboper_cmplt       (jtlb_tlboper_cmplt      ),
  .jtlb_tlboper_fifo        (jtlb_tlboper_fifo       ),
  .jtlb_tlboper_sel         (jtlb_tlboper_sel        ),
  .jtlb_tlboper_va_hit      (jtlb_tlboper_va_hit     ),
  .jtlb_xx_tc_read          (jtlb_xx_tc_read         ),
  .mmu_cp0_tlb_inv_done     (mmu_cp0_tlb_inv_done    ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .regs_jtlb_cur_flg        (regs_jtlb_cur_flg       ),
  .regs_jtlb_cur_g          (regs_jtlb_cur_g         ),
  .regs_jtlb_cur_ppn        (regs_jtlb_cur_ppn       ),
  .regs_tlboper_cur_asid    (regs_tlboper_cur_asid   ),
  .regs_tlboper_cur_pgs     (regs_tlboper_cur_pgs    ),
  .regs_tlboper_cur_vpn     (regs_tlboper_cur_vpn    ),
  .regs_tlboper_inv_asid    (regs_tlboper_inv_asid   ),
  .regs_tlboper_invall      (regs_tlboper_invall     ),
  .regs_tlboper_invasid     (regs_tlboper_invasid    ),
  .regs_tlboper_mir         (regs_tlboper_mir        ),
  .regs_tlboper_tlbp        (regs_tlboper_tlbp       ),
  .regs_tlboper_tlbr        (regs_tlboper_tlbr       ),
  .regs_tlboper_tlbwi       (regs_tlboper_tlbwi      ),
  .regs_tlboper_tlbwr       (regs_tlboper_tlbwr      ),
  .tlboper_arb_bank_sel     (tlboper_arb_bank_sel    ),
  .tlboper_arb_cmp_va       (tlboper_arb_cmp_va      ),
  .tlboper_arb_data_din     (tlboper_arb_data_din    ),
  .tlboper_arb_fifo_din     (tlboper_arb_fifo_din    ),
  .tlboper_arb_fifo_write   (tlboper_arb_fifo_write  ),
  .tlboper_arb_idx          (tlboper_arb_idx         ),
  .tlboper_arb_idx_not_va   (tlboper_arb_idx_not_va  ),
  .tlboper_arb_req          (tlboper_arb_req         ),
  .tlboper_arb_tag_din      (tlboper_arb_tag_din     ),
  .tlboper_arb_vpn          (tlboper_arb_vpn         ),
  .tlboper_arb_write        (tlboper_arb_write       ),
  .tlboper_jtlb_asid        (tlboper_jtlb_asid       ),
  .tlboper_jtlb_asid_sel    (tlboper_jtlb_asid_sel   ),
  .tlboper_jtlb_cmp_noasid  (tlboper_jtlb_cmp_noasid ),
  .tlboper_jtlb_inv_asid    (tlboper_jtlb_inv_asid   ),
  .tlboper_jtlb_tlbwr_on    (tlboper_jtlb_tlbwr_on   ),
  .tlboper_ptw_abort        (tlboper_ptw_abort       ),
  .tlboper_regs_cmplt       (tlboper_regs_cmplt      ),
  .tlboper_regs_tlbp_cmplt  (tlboper_regs_tlbp_cmplt ),
  .tlboper_regs_tlbr_cmplt  (tlboper_regs_tlbr_cmplt ),
  .tlboper_top_cp0_cmplt    (tlboper_top_cp0_cmplt   ),
  .tlboper_top_cp0_oper     (tlboper_top_cp0_oper    ),
  .tlboper_xx_clr           (tlboper_xx_clr          ),
  .tlboper_xx_cmplt         (tlboper_xx_cmplt        ),
  .tlboper_xx_inv_va_req    (tlboper_xx_inv_va_req   ),
  .tlboper_xx_pgs           (tlboper_xx_pgs          )
);


//==========================================================
// Instance jTLB request arbiter
//==========================================================
// &Instance("aq_mmu_arb", "x_aq_mmu_arb"); @62
aq_mmu_arb  x_aq_mmu_arb (
  .arb_dutlb_grant        (arb_dutlb_grant       ),
  .arb_iutlb_grant        (arb_iutlb_grant       ),
  .arb_jtlb_cmp_va        (arb_jtlb_cmp_va       ),
  .arb_jtlb_data_din      (arb_jtlb_data_din     ),
  .arb_jtlb_dutlb_on      (arb_jtlb_dutlb_on     ),
  .arb_jtlb_fifo_din      (arb_jtlb_fifo_din     ),
  .arb_jtlb_fifo_write    (arb_jtlb_fifo_write   ),
  .arb_jtlb_idx           (arb_jtlb_idx          ),
  .arb_jtlb_iutlb_on      (arb_jtlb_iutlb_on     ),
  .arb_jtlb_mach          (arb_jtlb_mach         ),
  .arb_jtlb_oper_on       (arb_jtlb_oper_on      ),
  .arb_jtlb_pgs           (arb_jtlb_pgs          ),
  .arb_jtlb_ptw_req       (arb_jtlb_ptw_req      ),
  .arb_jtlb_req           (arb_jtlb_req          ),
  .arb_jtlb_tag_din       (arb_jtlb_tag_din      ),
  .arb_jtlb_vpn           (arb_jtlb_vpn          ),
  .arb_jtlb_way_sel       (arb_jtlb_way_sel      ),
  .arb_jtlb_write         (arb_jtlb_write        ),
  .arb_ptw_asid           (arb_ptw_asid          ),
  .arb_ptw_dutlb_rd       (arb_ptw_dutlb_rd      ),
  .arb_ptw_dutlb_wr       (arb_ptw_dutlb_wr      ),
  .arb_ptw_grant          (arb_ptw_grant         ),
  .arb_ptw_iutlb_on       (arb_ptw_iutlb_on      ),
  .arb_ptw_priv_mode      (arb_ptw_priv_mode     ),
  .arb_tlboper_grant      (arb_tlboper_grant     ),
  .arb_tlboper_read_idle  (arb_tlboper_read_idle ),
  .arb_top_cur_st         (arb_top_cur_st        ),
  .arb_top_read_st        (arb_top_read_st       ),
  .arb_top_tlboper_on     (arb_top_tlboper_on    ),
  .cp0_mmu_icg_en         (cp0_mmu_icg_en        ),
  .cp0_mmu_lpmd_req       (cp0_mmu_lpmd_req      ),
  .cpurst_b               (cpurst_b              ),
  .dutlb_arb_asid         (dutlb_arb_asid        ),
  .dutlb_arb_cmplt        (dutlb_arb_cmplt       ),
  .dutlb_arb_mach         (dutlb_arb_mach        ),
  .dutlb_arb_mode         (dutlb_arb_mode        ),
  .dutlb_arb_read         (dutlb_arb_read        ),
  .dutlb_arb_req          (dutlb_arb_req         ),
  .dutlb_arb_vpn          (dutlb_arb_vpn         ),
  .forever_cpuclk         (forever_cpuclk        ),
  .iutlb_arb_asid         (iutlb_arb_asid        ),
  .iutlb_arb_cmplt        (iutlb_arb_cmplt       ),
  .iutlb_arb_mach         (iutlb_arb_mach        ),
  .iutlb_arb_mode         (iutlb_arb_mode        ),
  .iutlb_arb_req          (iutlb_arb_req         ),
  .iutlb_arb_vpn          (iutlb_arb_vpn         ),
  .jtlb_arb_mach          (jtlb_arb_mach         ),
  .jtlb_arb_tc_miss       (jtlb_arb_tc_miss      ),
  .jtlb_arb_tc_vld        (jtlb_arb_tc_vld       ),
  .jtlb_arb_vpn           (jtlb_arb_vpn          ),
  .mmu_yy_xx_no_op        (mmu_yy_xx_no_op       ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .ptw_arb_bank_sel       (ptw_arb_bank_sel      ),
  .ptw_arb_data_din       (ptw_arb_data_din      ),
  .ptw_arb_fifo_din       (ptw_arb_fifo_din      ),
  .ptw_arb_pgs            (ptw_arb_pgs           ),
  .ptw_arb_req            (ptw_arb_req           ),
  .ptw_arb_tag_din        (ptw_arb_tag_din       ),
  .ptw_arb_vpn            (ptw_arb_vpn           ),
  .tlboper_arb_bank_sel   (tlboper_arb_bank_sel  ),
  .tlboper_arb_cmp_va     (tlboper_arb_cmp_va    ),
  .tlboper_arb_data_din   (tlboper_arb_data_din  ),
  .tlboper_arb_fifo_din   (tlboper_arb_fifo_din  ),
  .tlboper_arb_fifo_write (tlboper_arb_fifo_write),
  .tlboper_arb_idx        (tlboper_arb_idx       ),
  .tlboper_arb_idx_not_va (tlboper_arb_idx_not_va),
  .tlboper_arb_req        (tlboper_arb_req       ),
  .tlboper_arb_tag_din    (tlboper_arb_tag_din   ),
  .tlboper_arb_vpn        (tlboper_arb_vpn       ),
  .tlboper_arb_write      (tlboper_arb_write     ),
  .tlboper_xx_cmplt       (tlboper_xx_cmplt      ),
  .tlboper_xx_pgs         (tlboper_xx_pgs        )
);


//==========================================================
// Instance jTLB pipeline module
//==========================================================
// &Instance("aq_mmu_jtlb", "x_aq_mmu_jtlb"); @67
aq_mmu_jtlb  x_aq_mmu_jtlb (
  .arb_jtlb_cmp_va          (arb_jtlb_cmp_va         ),
  .arb_jtlb_data_din        (arb_jtlb_data_din       ),
  .arb_jtlb_dutlb_on        (arb_jtlb_dutlb_on       ),
  .arb_jtlb_fifo_din        (arb_jtlb_fifo_din       ),
  .arb_jtlb_fifo_write      (arb_jtlb_fifo_write     ),
  .arb_jtlb_idx             (arb_jtlb_idx            ),
  .arb_jtlb_iutlb_on        (arb_jtlb_iutlb_on       ),
  .arb_jtlb_mach            (arb_jtlb_mach           ),
  .arb_jtlb_oper_on         (arb_jtlb_oper_on        ),
  .arb_jtlb_pgs             (arb_jtlb_pgs            ),
  .arb_jtlb_ptw_req         (arb_jtlb_ptw_req        ),
  .arb_jtlb_req             (arb_jtlb_req            ),
  .arb_jtlb_tag_din         (arb_jtlb_tag_din        ),
  .arb_jtlb_vpn             (arb_jtlb_vpn            ),
  .arb_jtlb_way_sel         (arb_jtlb_way_sel        ),
  .arb_jtlb_write           (arb_jtlb_write          ),
  .cp0_mmu_icg_en           (cp0_mmu_icg_en          ),
  .cp0_mmu_ptw_en           (cp0_mmu_ptw_en          ),
  .cpurst_b                 (cpurst_b                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .jtlb_arb_mach            (jtlb_arb_mach           ),
  .jtlb_arb_tc_miss         (jtlb_arb_tc_miss        ),
  .jtlb_arb_tc_vld          (jtlb_arb_tc_vld         ),
  .jtlb_arb_vpn             (jtlb_arb_vpn            ),
  .jtlb_dutlb_acc_err       (jtlb_dutlb_acc_err      ),
  .jtlb_dutlb_pgflt         (jtlb_dutlb_pgflt        ),
  .jtlb_dutlb_ref_cmplt     (jtlb_dutlb_ref_cmplt    ),
  .jtlb_dutlb_ref_pavld     (jtlb_dutlb_ref_pavld    ),
  .jtlb_iutlb_acc_err       (jtlb_iutlb_acc_err      ),
  .jtlb_iutlb_pgflt         (jtlb_iutlb_pgflt        ),
  .jtlb_iutlb_ref_cmplt     (jtlb_iutlb_ref_cmplt    ),
  .jtlb_iutlb_ref_pavld     (jtlb_iutlb_ref_pavld    ),
  .jtlb_ptw_mach            (jtlb_ptw_mach           ),
  .jtlb_ptw_req             (jtlb_ptw_req            ),
  .jtlb_ptw_vpn             (jtlb_ptw_vpn            ),
  .jtlb_regs_hit            (jtlb_regs_hit           ),
  .jtlb_regs_hit_mult       (jtlb_regs_hit_mult      ),
  .jtlb_regs_tlbp_hit_index (jtlb_regs_tlbp_hit_index),
  .jtlb_tlboper_asid_hit    (jtlb_tlboper_asid_hit   ),
  .jtlb_tlboper_cmplt       (jtlb_tlboper_cmplt      ),
  .jtlb_tlboper_fifo        (jtlb_tlboper_fifo       ),
  .jtlb_tlboper_sel         (jtlb_tlboper_sel        ),
  .jtlb_tlboper_va_hit      (jtlb_tlboper_va_hit     ),
  .jtlb_tlbr_asid           (jtlb_tlbr_asid          ),
  .jtlb_tlbr_flg            (jtlb_tlbr_flg           ),
  .jtlb_tlbr_g              (jtlb_tlbr_g             ),
  .jtlb_tlbr_pgs            (jtlb_tlbr_pgs           ),
  .jtlb_tlbr_ppn            (jtlb_tlbr_ppn           ),
  .jtlb_tlbr_vpn            (jtlb_tlbr_vpn           ),
  .jtlb_top_utlb_pavld      (jtlb_top_utlb_pavld     ),
  .jtlb_xx_fifo             (jtlb_xx_fifo            ),
  .jtlb_xx_mmu_on           (jtlb_xx_mmu_on          ),
  .jtlb_xx_ref_flg          (jtlb_xx_ref_flg         ),
  .jtlb_xx_ref_pgs          (jtlb_xx_ref_pgs         ),
  .jtlb_xx_ref_ppn          (jtlb_xx_ref_ppn         ),
  .jtlb_xx_ref_vpn          (jtlb_xx_ref_vpn         ),
  .jtlb_xx_tc_read          (jtlb_xx_tc_read         ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .ptw_jtlb_ref_acc_err     (ptw_jtlb_ref_acc_err    ),
  .ptw_jtlb_ref_cmplt       (ptw_jtlb_ref_cmplt      ),
  .ptw_jtlb_ref_data_vld    (ptw_jtlb_ref_data_vld   ),
  .ptw_jtlb_ref_flg         (ptw_jtlb_ref_flg        ),
  .ptw_jtlb_ref_mach        (ptw_jtlb_ref_mach       ),
  .ptw_jtlb_ref_mmu_on      (ptw_jtlb_ref_mmu_on     ),
  .ptw_jtlb_ref_pgflt       (ptw_jtlb_ref_pgflt      ),
  .ptw_jtlb_ref_pgs         (ptw_jtlb_ref_pgs        ),
  .ptw_jtlb_ref_ppn         (ptw_jtlb_ref_ppn        ),
  .ptw_jtlb_ref_vpn         (ptw_jtlb_ref_vpn        ),
  .regs_jtlb_cur_asid       (regs_jtlb_cur_asid      ),
  .tlboper_jtlb_asid        (tlboper_jtlb_asid       ),
  .tlboper_jtlb_asid_sel    (tlboper_jtlb_asid_sel   ),
  .tlboper_jtlb_cmp_noasid  (tlboper_jtlb_cmp_noasid ),
  .tlboper_jtlb_inv_asid    (tlboper_jtlb_inv_asid   ),
  .tlboper_jtlb_tlbwr_on    (tlboper_jtlb_tlbwr_on   )
);


//==========================================================
// Instance PTW
//==========================================================
// &Instance("aq_mmu_ptw", "x_aq_mmu_ptw"); @72
aq_mmu_ptw  x_aq_mmu_ptw (
  .arb_ptw_asid          (arb_ptw_asid         ),
  .arb_ptw_dutlb_rd      (arb_ptw_dutlb_rd     ),
  .arb_ptw_dutlb_wr      (arb_ptw_dutlb_wr     ),
  .arb_ptw_grant         (arb_ptw_grant        ),
  .arb_ptw_iutlb_on      (arb_ptw_iutlb_on     ),
  .arb_ptw_priv_mode     (arb_ptw_priv_mode    ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_maee          (cp0_mmu_maee         ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .jtlb_ptw_mach         (jtlb_ptw_mach        ),
  .jtlb_ptw_req          (jtlb_ptw_req         ),
  .jtlb_ptw_vpn          (jtlb_ptw_vpn         ),
  .jtlb_xx_fifo          (jtlb_xx_fifo         ),
  .lsu_mmu_bus_error     (lsu_mmu_bus_error    ),
  .lsu_mmu_data          (lsu_mmu_data         ),
  .lsu_mmu_data_vld      (lsu_mmu_data_vld     ),
  .mmu_hpcp_jtlb_miss    (mmu_hpcp_jtlb_miss   ),
  .mmu_lsu_data_req      (mmu_lsu_data_req     ),
  .mmu_lsu_data_req_addr (mmu_lsu_data_req_addr),
  .mmu_lsu_data_req_size (mmu_lsu_data_req_size),
  .mmu_pmp_chk1          (mmu_pmp_chk1         ),
  .mmu_pmp_pa            (mmu_pmp_pa           ),
  .mmu_pmp_priv_mode     (mmu_pmp_priv_mode    ),
  .mmu_sysmap_pa         (mmu_sysmap_pa        ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .pmp_mmu_flg           (pmp_mmu_flg          ),
  .pmp_mmu_hit_num       (pmp_mmu_hit_num      ),
  .pmp_mmu_napot_cross   (pmp_mmu_napot_cross  ),
  .ptw_arb_bank_sel      (ptw_arb_bank_sel     ),
  .ptw_arb_data_din      (ptw_arb_data_din     ),
  .ptw_arb_fifo_din      (ptw_arb_fifo_din     ),
  .ptw_arb_pgs           (ptw_arb_pgs          ),
  .ptw_arb_req           (ptw_arb_req          ),
  .ptw_arb_tag_din       (ptw_arb_tag_din      ),
  .ptw_arb_vpn           (ptw_arb_vpn          ),
  .ptw_jtlb_ref_acc_err  (ptw_jtlb_ref_acc_err ),
  .ptw_jtlb_ref_cmplt    (ptw_jtlb_ref_cmplt   ),
  .ptw_jtlb_ref_data_vld (ptw_jtlb_ref_data_vld),
  .ptw_jtlb_ref_flg      (ptw_jtlb_ref_flg     ),
  .ptw_jtlb_ref_mach     (ptw_jtlb_ref_mach    ),
  .ptw_jtlb_ref_mmu_on   (ptw_jtlb_ref_mmu_on  ),
  .ptw_jtlb_ref_pgflt    (ptw_jtlb_ref_pgflt   ),
  .ptw_jtlb_ref_pgs      (ptw_jtlb_ref_pgs     ),
  .ptw_jtlb_ref_ppn      (ptw_jtlb_ref_ppn     ),
  .ptw_jtlb_ref_vpn      (ptw_jtlb_ref_vpn     ),
  .ptw_top_cur_st        (ptw_top_cur_st       ),
  .regs_ptw_satp_ppn     (regs_ptw_satp_ppn    ),
  .sysmap_mmu_flg        (sysmap_mmu_flg       ),
  .tlboper_ptw_abort     (tlboper_ptw_abort    )
);


//==========================================================
// Instance System Map
//==========================================================
// &Instance("aq_mmu_sysmap", "x_aq_mmu_sysmap"); @77
aq_mmu_sysmap  x_aq_mmu_sysmap (
  .mmu_sysmap_pa  (mmu_sysmap_pa ),
  .sysmap_mmu_flg (sysmap_mmu_flg)
);


// for dbg
assign mmu_dtu_debug_info[15:0] = {iutlb_top_ref_cur_st[1:0],
                                   dutlb_top_ref_cur_st[1:0], 
                                   tlboper_top_cp0_oper,
                                   tlboper_top_cp0_cmplt,
                                   arb_top_cur_st[1:0], 
                                   arb_top_tlboper_on,
                                   arb_top_read_st[1:0],
                                   ptw_top_cur_st[4:0]};

// &ModuleEnd; @89
endmodule


