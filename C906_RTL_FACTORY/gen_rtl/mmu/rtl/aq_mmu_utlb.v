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

// &ModuleBeg; @27
module aq_mmu_utlb(
  arb_utlb_grant,
  cp0_mmu_icg_en,
  cp0_mmu_lpmd_req,
  cp0_mmu_mxr,
  cp0_mmu_satp_wen,
  cp0_mmu_sum,
  cp0_mmu_tlb_va,
  cp0_yy_priv_mode,
  cpurst_b,
  forever_cpuclk,
  hpcp_mmu_cnt_en,
  jtlb_utlb_acc_err,
  jtlb_utlb_pgflt,
  jtlb_utlb_ref_cmplt,
  jtlb_utlb_ref_pavld,
  jtlb_xx_mmu_on,
  jtlb_xx_ref_flg,
  jtlb_xx_ref_pgs,
  jtlb_xx_ref_ppn,
  jtlb_xx_ref_vpn,
  lsu_mmu_priv_mode,
  mmu_top_clk,
  mmu_xxu_access_fault,
  mmu_xxu_buf,
  mmu_xxu_ca,
  mmu_xxu_pa,
  mmu_xxu_pa_vld,
  mmu_xxu_page_fault,
  mmu_xxu_sec,
  mmu_xxu_sh,
  mmu_xxu_so,
  pad_yy_icg_scan_en,
  regs_mmu_en,
  regs_ptw_cur_asid,
  tlboper_xx_clr,
  tlboper_xx_inv_va_req,
  utlb_arb_asid,
  utlb_arb_cmplt,
  utlb_arb_mach,
  utlb_arb_mode,
  utlb_arb_read,
  utlb_arb_req,
  utlb_arb_vpn,
  utlb_hpcp_utlb_miss,
  utlb_top_ref_cur_st,
  xxu_mmu_abort,
  xxu_mmu_exec,
  xxu_mmu_read,
  xxu_mmu_va,
  xxu_mmu_va_vld
);

// &Ports; @28
input           arb_utlb_grant;        
input           cp0_mmu_icg_en;        
input           cp0_mmu_lpmd_req;      
input           cp0_mmu_mxr;           
input           cp0_mmu_satp_wen;      
input           cp0_mmu_sum;           
input   [26:0]  cp0_mmu_tlb_va;        
input   [1 :0]  cp0_yy_priv_mode;      
input           cpurst_b;              
input           forever_cpuclk;        
input           hpcp_mmu_cnt_en;       
input           jtlb_utlb_acc_err;     
input           jtlb_utlb_pgflt;       
input           jtlb_utlb_ref_cmplt;   
input           jtlb_utlb_ref_pavld;   
input           jtlb_xx_mmu_on;        
input   [14:0]  jtlb_xx_ref_flg;       
input   [2 :0]  jtlb_xx_ref_pgs;       
input   [27:0]  jtlb_xx_ref_ppn;       
input   [27:0]  jtlb_xx_ref_vpn;       
input   [1 :0]  lsu_mmu_priv_mode;     
input           mmu_top_clk;           
input           pad_yy_icg_scan_en;    
input           regs_mmu_en;           
input   [15:0]  regs_ptw_cur_asid;     
input           tlboper_xx_clr;        
input           tlboper_xx_inv_va_req; 
input           xxu_mmu_abort;         
input           xxu_mmu_exec;          
input           xxu_mmu_read;          
input   [51:0]  xxu_mmu_va;            
input           xxu_mmu_va_vld;        
output          mmu_xxu_access_fault;  
output          mmu_xxu_buf;           
output          mmu_xxu_ca;            
output  [27:0]  mmu_xxu_pa;            
output          mmu_xxu_pa_vld;        
output          mmu_xxu_page_fault;    
output          mmu_xxu_sec;           
output          mmu_xxu_sh;            
output          mmu_xxu_so;            
output  [15:0]  utlb_arb_asid;         
output          utlb_arb_cmplt;        
output          utlb_arb_mach;         
output  [1 :0]  utlb_arb_mode;         
output          utlb_arb_read;         
output          utlb_arb_req;          
output  [27:0]  utlb_arb_vpn;          
output          utlb_hpcp_utlb_miss;   
output  [1 :0]  utlb_top_ref_cur_st;   

// &Regs; @29
reg     [15:0]  ref_asid;              
reg     [1 :0]  ref_cur_st;            
reg     [1 :0]  ref_mode;              
reg     [1 :0]  ref_nxt_st;            
reg             ref_read;              
reg     [27:0]  ref_vpn;               
reg             utlb_miss;             
reg     [9 :0]  utlb_plru_read_hit;    

// &Wires; @30
wire            arb_utlb_grant;        
wire            cp0_mach_mode;         
wire            cp0_mmu_icg_en;        
wire            cp0_mmu_lpmd_req;      
wire            cp0_mmu_mxr;           
wire            cp0_mmu_satp_wen;      
wire            cp0_mmu_sum;           
wire    [26:0]  cp0_mmu_tlb_va;        
wire    [1 :0]  cp0_priv_mode;         
wire            cp0_supv_mode;         
wire            cp0_user_mode;         
wire    [1 :0]  cp0_yy_priv_mode;      
wire            cpurst_b;              
wire    [14:0]  entry0_flg;            
wire            entry0_hit;            
wire            entry0_hit_dp;         
wire    [2 :0]  entry0_pgs;            
wire    [27:0]  entry0_ppn;            
wire            entry0_upd;            
wire            entry0_vld;            
wire    [14:0]  entry1_flg;            
wire            entry1_hit;            
wire            entry1_hit_dp;         
wire    [2 :0]  entry1_pgs;            
wire    [27:0]  entry1_ppn;            
wire            entry1_upd;            
wire            entry1_vld;            
wire    [14:0]  entry2_flg;            
wire            entry2_hit;            
wire            entry2_hit_dp;         
wire    [2 :0]  entry2_pgs;            
wire    [27:0]  entry2_ppn;            
wire            entry2_upd;            
wire            entry2_vld;            
wire    [14:0]  entry3_flg;            
wire            entry3_hit;            
wire            entry3_hit_dp;         
wire    [2 :0]  entry3_pgs;            
wire    [27:0]  entry3_ppn;            
wire            entry3_upd;            
wire            entry3_vld;            
wire    [14:0]  entry4_flg;            
wire            entry4_hit;            
wire            entry4_hit_dp;         
wire    [2 :0]  entry4_pgs;            
wire    [27:0]  entry4_ppn;            
wire            entry4_upd;            
wire            entry4_vld;            
wire    [14:0]  entry5_flg;            
wire            entry5_hit;            
wire            entry5_hit_dp;         
wire    [2 :0]  entry5_pgs;            
wire    [27:0]  entry5_ppn;            
wire            entry5_upd;            
wire            entry5_vld;            
wire    [14:0]  entry6_flg;            
wire            entry6_hit;            
wire            entry6_hit_dp;         
wire    [2 :0]  entry6_pgs;            
wire    [27:0]  entry6_ppn;            
wire            entry6_upd;            
wire            entry6_vld;            
wire    [14:0]  entry7_flg;            
wire            entry7_hit;            
wire            entry7_hit_dp;         
wire    [2 :0]  entry7_pgs;            
wire    [27:0]  entry7_ppn;            
wire            entry7_upd;            
wire            entry7_vld;            
wire    [14:0]  entry8_flg;            
wire            entry8_hit;            
wire            entry8_hit_dp;         
wire    [2 :0]  entry8_pgs;            
wire    [27:0]  entry8_ppn;            
wire            entry8_upd;            
wire            entry8_vld;            
wire    [14:0]  entry9_flg;            
wire            entry9_hit;            
wire            entry9_hit_dp;         
wire    [2 :0]  entry9_pgs;            
wire    [27:0]  entry9_ppn;            
wire            entry9_upd;            
wire            entry9_vld;            
wire    [9 :0]  entry_hit;             
wire    [9 :0]  entry_hit_dp;          
wire            forever_cpuclk;        
wire            hpcp_mmu_cnt_en;       
wire            jtlb_utlb_acc_err;     
wire            jtlb_utlb_pgflt;       
wire            jtlb_utlb_ref_cmplt;   
wire            jtlb_utlb_ref_pavld;   
wire            jtlb_xx_mmu_on;        
wire    [14:0]  jtlb_xx_ref_flg;       
wire    [2 :0]  jtlb_xx_ref_pgs;       
wire    [27:0]  jtlb_xx_ref_ppn;       
wire    [27:0]  jtlb_xx_ref_vpn;       
wire    [1 :0]  lsu_mmu_priv_mode;     
wire            mmu_top_clk;           
wire            mmu_xxu_access_fault;  
wire            mmu_xxu_buf;           
wire            mmu_xxu_ca;            
wire    [27:0]  mmu_xxu_pa;            
wire            mmu_xxu_pa_vld;        
wire            mmu_xxu_page_fault;    
wire            mmu_xxu_sec;           
wire            mmu_xxu_sh;            
wire            mmu_xxu_so;            
wire            pad_yy_icg_scan_en;    
wire            plru_clk;              
wire            plru_upd_en;           
wire    [9 :0]  plru_utlb_ref_num;     
wire            regs_mmu_en;           
wire    [15:0]  regs_ptw_cur_asid;     
wire            tlboper_xx_clr;        
wire            tlboper_xx_inv_va_req; 
wire    [15:0]  utlb_arb_asid;         
wire            utlb_arb_cmplt;        
wire            utlb_arb_mach;         
wire    [1 :0]  utlb_arb_mode;         
wire            utlb_arb_read;         
wire            utlb_arb_req;          
wire    [27:0]  utlb_arb_vpn;          
wire            utlb_buf;              
wire            utlb_ca;               
wire            utlb_clk_en;           
wire            utlb_deny;             
wire    [27:0]  utlb_entry_pa;         
wire    [14:0]  utlb_hit_flg;          
wire    [27:0]  utlb_hit_pa;           
wire    [2 :0]  utlb_hit_pgs;          
wire            utlb_hit_vld;          
wire            utlb_hpcp_utlb_miss;   
wire            utlb_miss_clk;         
wire            utlb_miss_cnt;         
wire            utlb_miss_req;         
wire            utlb_miss_vld;         
wire    [27:0]  utlb_miss_vpn;         
wire            utlb_off;              
wire            utlb_page_fault;       
wire            utlb_pavld;            
wire            utlb_plru_read_hit_vld; 
wire            utlb_plru_refill_on;   
wire            utlb_plru_refill_vld;  
wire            utlb_ref_abt;          
wire            utlb_ref_acflt;        
wire            utlb_ref_cmplt;        
wire            utlb_ref_idle;         
wire            utlb_ref_pavld;        
wire            utlb_ref_pgflt;        
wire            utlb_ref_wfc;          
wire            utlb_ref_wfg;          
wire    [27:0]  utlb_req_vpn;          
wire            utlb_sec;              
wire            utlb_sh;               
wire            utlb_so;               
wire    [1 :0]  utlb_top_ref_cur_st;   
wire    [14:0]  utlb_upd_flg;          
wire            utlb_upd_mmu_on;       
wire    [2 :0]  utlb_upd_pgs;          
wire    [27:0]  utlb_upd_ppn;          
wire    [27:0]  utlb_upd_vpn;          
wire            utlb_va_illegal;       
wire            xxu_mmu_abort;         
wire            xxu_mmu_exec;          
wire            xxu_mmu_read;          
wire    [51:0]  xxu_mmu_va;            
wire            xxu_mmu_va_vld;        


//==========================================================
// parameters for value width
//==========================================================
parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 15;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter VPN_PERLEL = 9;
parameter ENTRY_NUM  = 10;

//==========================================================
// I-uTLB:
// 1. 10-entry utlb 
// 2. translate Va to PA
// 3. visit jTLB when uTLB miss
// 4. refill uTLB with PLRU algorithm
//==========================================================

//==========================================================
//                  Gate Cell
//==========================================================
// TODO: Power Warning
assign utlb_clk_en = xxu_mmu_va_vld //&& !utlb_hit_vld
                  || !utlb_ref_idle
                  || utlb_miss;
// &Instance("gated_clk_cell", "x_utlb_gateclk"); @57
gated_clk_cell  x_utlb_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (utlb_miss_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (utlb_clk_en       ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @58
//           .external_en(1'b0          ), @59
//           .global_en  (1'b1          ), @60
//           .module_en  (cp0_mmu_icg_en), @61
//           .local_en   (utlb_clk_en   ), @62
//           .clk_out    (utlb_miss_clk ) @63
//          ); @64

//==========================================================
// 1. 10-entry utlb 
//==========================================================
assign utlb_req_vpn[PPN_WIDTH-1:0] = xxu_mmu_va[PPN_WIDTH-1:0];

// &ConnRule(s/utlb_entry/entry0/); @71
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry0"); @72
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry0 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry0_flg           ),
  .utlb_entry_hit        (entry0_hit           ),
  .utlb_entry_hit_dp     (entry0_hit_dp        ),
  .utlb_entry_pgs        (entry0_pgs           ),
  .utlb_entry_ppn        (entry0_ppn           ),
  .utlb_entry_upd        (entry0_upd           ),
  .utlb_entry_vld        (entry0_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry1/); @74
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry1"); @75
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry1 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry1_flg           ),
  .utlb_entry_hit        (entry1_hit           ),
  .utlb_entry_hit_dp     (entry1_hit_dp        ),
  .utlb_entry_pgs        (entry1_pgs           ),
  .utlb_entry_ppn        (entry1_ppn           ),
  .utlb_entry_upd        (entry1_upd           ),
  .utlb_entry_vld        (entry1_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry2/); @77
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry2"); @78
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry2 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry2_flg           ),
  .utlb_entry_hit        (entry2_hit           ),
  .utlb_entry_hit_dp     (entry2_hit_dp        ),
  .utlb_entry_pgs        (entry2_pgs           ),
  .utlb_entry_ppn        (entry2_ppn           ),
  .utlb_entry_upd        (entry2_upd           ),
  .utlb_entry_vld        (entry2_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry3/); @80
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry3"); @81
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry3 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry3_flg           ),
  .utlb_entry_hit        (entry3_hit           ),
  .utlb_entry_hit_dp     (entry3_hit_dp        ),
  .utlb_entry_pgs        (entry3_pgs           ),
  .utlb_entry_ppn        (entry3_ppn           ),
  .utlb_entry_upd        (entry3_upd           ),
  .utlb_entry_vld        (entry3_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry4/); @83
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry4"); @84
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry4 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry4_flg           ),
  .utlb_entry_hit        (entry4_hit           ),
  .utlb_entry_hit_dp     (entry4_hit_dp        ),
  .utlb_entry_pgs        (entry4_pgs           ),
  .utlb_entry_ppn        (entry4_ppn           ),
  .utlb_entry_upd        (entry4_upd           ),
  .utlb_entry_vld        (entry4_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry5/); @86
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry5"); @87
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry5 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry5_flg           ),
  .utlb_entry_hit        (entry5_hit           ),
  .utlb_entry_hit_dp     (entry5_hit_dp        ),
  .utlb_entry_pgs        (entry5_pgs           ),
  .utlb_entry_ppn        (entry5_ppn           ),
  .utlb_entry_upd        (entry5_upd           ),
  .utlb_entry_vld        (entry5_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry6/); @89
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry6"); @90
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry6 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry6_flg           ),
  .utlb_entry_hit        (entry6_hit           ),
  .utlb_entry_hit_dp     (entry6_hit_dp        ),
  .utlb_entry_pgs        (entry6_pgs           ),
  .utlb_entry_ppn        (entry6_ppn           ),
  .utlb_entry_upd        (entry6_upd           ),
  .utlb_entry_vld        (entry6_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry7/); @92
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry7"); @93
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry7 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry7_flg           ),
  .utlb_entry_hit        (entry7_hit           ),
  .utlb_entry_hit_dp     (entry7_hit_dp        ),
  .utlb_entry_pgs        (entry7_pgs           ),
  .utlb_entry_ppn        (entry7_ppn           ),
  .utlb_entry_upd        (entry7_upd           ),
  .utlb_entry_vld        (entry7_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry8/); @95
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry8"); @96
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry8 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry8_flg           ),
  .utlb_entry_hit        (entry8_hit           ),
  .utlb_entry_hit_dp     (entry8_hit_dp        ),
  .utlb_entry_pgs        (entry8_pgs           ),
  .utlb_entry_ppn        (entry8_ppn           ),
  .utlb_entry_upd        (entry8_upd           ),
  .utlb_entry_vld        (entry8_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry9/); @98
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry9"); @99
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry9 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry9_flg           ),
  .utlb_entry_hit        (entry9_hit           ),
  .utlb_entry_hit_dp     (entry9_hit_dp        ),
  .utlb_entry_pgs        (entry9_pgs           ),
  .utlb_entry_ppn        (entry9_ppn           ),
  .utlb_entry_upd        (entry9_upd           ),
  .utlb_entry_vld        (entry9_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


//==========================================================
// 2. Access uTLB
// a. Read  Port: Entry hit infor
// b. Write Port: JTLB refill infor
// c. PLRU update for every access
//==========================================================

//==========================================================
// a. Read Port: entry hit infor
//==========================================================
assign entry_hit[9:0] = {entry9_hit, entry8_hit,
                         entry7_hit, entry6_hit, entry5_hit, entry4_hit,
                         entry3_hit, entry2_hit, entry1_hit, entry0_hit};

assign entry_hit_dp[9:0] = {entry9_hit_dp, entry8_hit_dp,
                            entry7_hit_dp, entry6_hit_dp, entry5_hit_dp, entry4_hit_dp,
                            entry3_hit_dp, entry2_hit_dp, entry1_hit_dp, entry0_hit_dp};

assign utlb_hit_vld  = |entry_hit[9:0];

//----------------------------------------------------------
// Physical Addr
//----------------------------------------------------------
assign utlb_entry_pa[PPN_WIDTH-1:0] = 
                  {PPN_WIDTH{entry_hit_dp[0]}} & entry0_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[1]}} & entry1_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[2]}} & entry2_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[3]}} & entry3_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[4]}} & entry4_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[5]}} & entry5_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[6]}} & entry6_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[7]}} & entry7_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[8]}} & entry8_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[9]}} & entry9_ppn[PPN_WIDTH-1:0];

assign utlb_hit_pa[PPN_WIDTH-1:0] =  
     {PPN_WIDTH{utlb_hit_pgs[2]}} & {utlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*2], xxu_mmu_va[VPN_PERLEL*2-1:0]}
   | {PPN_WIDTH{utlb_hit_pgs[1]}} & {utlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*1], xxu_mmu_va[VPN_PERLEL*1-1:0]}
   | {PPN_WIDTH{utlb_hit_pgs[0]}} &  utlb_entry_pa[PPN_WIDTH-1:0];

//----------------------------------------------------------
// Page Size
//----------------------------------------------------------
assign utlb_hit_pgs[PGS_WIDTH-1:0] =  
                  {PGS_WIDTH{entry_hit_dp[0]}} & entry0_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[1]}} & entry1_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[2]}} & entry2_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[3]}} & entry3_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[4]}} & entry4_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[5]}} & entry5_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[6]}} & entry6_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[7]}} & entry7_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[8]}} & entry8_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[9]}} & entry9_pgs[PGS_WIDTH-1:0];

//----------------------------------------------------------
// Flags
//----------------------------------------------------------
assign utlb_hit_flg[FLG_WIDTH-1:0] =  
                  {FLG_WIDTH{entry_hit_dp[0]}} & entry0_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[1]}} & entry1_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[2]}} & entry2_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[3]}} & entry3_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[4]}} & entry4_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[5]}} & entry5_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[6]}} & entry6_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[7]}} & entry7_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[8]}} & entry8_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[9]}} & entry9_flg[FLG_WIDTH-1:0];

//----------------------------------------------------------
// Page Fault Check
//----------------------------------------------------------
// current privlidged mode
assign cp0_priv_mode[1:0] = xxu_mmu_exec ? cp0_yy_priv_mode[1:0]
                          : lsu_mmu_priv_mode[1:0];
assign cp0_user_mode      = cp0_priv_mode[1:0] == 2'b00;
assign cp0_supv_mode      = cp0_priv_mode[1:0] == 2'b01;
assign cp0_mach_mode      = cp0_priv_mode[1:0] == 2'b11;

// utlb off when mmu off or machine mode
assign utlb_off  = !regs_mmu_en || cp0_mach_mode;

// Check VA legal: VA[63:39] should be sign-extend of VA[38]
assign utlb_va_illegal = (xxu_mmu_va[VPN_WIDTH-1] && !(&xxu_mmu_va[51:VPN_WIDTH])
                     ||  !xxu_mmu_va[VPN_WIDTH-1] &&  (|xxu_mmu_va[51:VPN_WIDTH]))
                          && !utlb_off && xxu_mmu_va_vld;

// page fault when not valid
// Flags: 14:10 XWRM are for PMP
// +===============================================================+
// | 14| 13| 12| 11| 10| 9  | 8 | 7 | 6  |  5  | 4 | 3 | 2 | 1 | 0 |
// |---+---+---+---+---+----+---+---+----+-----+---+---+---+---+---+
// | L | X | W | R | M | So | C | B | Sh | Sec | U | X | W | R | V |
// +===============================================================+

assign utlb_page_fault = (!utlb_hit_flg[0]
// page fault when writeable but not readable
                      || !utlb_hit_flg[1] && utlb_hit_flg[2]
// page fault when not readable nor executable with mxr
                      || !utlb_hit_flg[1] && !(utlb_hit_flg[3] && cp0_mmu_mxr)
                         && !xxu_mmu_exec && xxu_mmu_read
// page fault when not writeable
                      || !utlb_hit_flg[2] && !xxu_mmu_exec && !xxu_mmu_read
// page fault when not executable
                      || !utlb_hit_flg[3] && xxu_mmu_exec
// page fault when supv access user region and vise versa
                      ||  utlb_hit_flg[4] && cp0_supv_mode && !cp0_mmu_sum 
                      || !utlb_hit_flg[4] && cp0_user_mode && regs_mmu_en)
                         && utlb_hit_vld
// page fault when tfatal and tmiss from jTLB
                      ||  utlb_ref_pgflt
// page fault when ifu high va not legal
                      ||  utlb_va_illegal;

//----------------------------------------------------------
// I-UTLB Read Result
//----------------------------------------------------------
// Physical addr is valid when:
// 1. u-TLB hit 
assign utlb_pavld = xxu_mmu_va_vld && utlb_hit_vld
// 2. Refill Page fault
                 || utlb_ref_pgflt
// 3. Refill Access Fault
                 || utlb_ref_acflt
// 4. VA is illegal
                 || xxu_mmu_va_vld && utlb_va_illegal;

// T-Head Extend Flags
// pmas: strong order, cacheable, bufferable, shareable, security
assign utlb_so    = utlb_hit_flg[9];
assign utlb_ca    = utlb_hit_flg[8] && !utlb_hit_flg[9]; //when so, alway non-ca
assign utlb_buf   = utlb_hit_flg[7] || !utlb_hit_flg[9]; //when !so, always buf
assign utlb_sh    = utlb_hit_flg[6];
assign utlb_sec   = utlb_hit_flg[5];

// access deny when pmp check fail
assign utlb_deny  = utlb_ref_acflt // jtlb access fault
                  // ifu meets strong order
                 || (utlb_hit_flg[9] && xxu_mmu_exec
                  // Not Readable
                 || !utlb_hit_flg[11] 
                     && !(cp0_mach_mode && !utlb_hit_flg[14])  // L-bit for M-Mode
                     && !xxu_mmu_exec && xxu_mmu_read
                  // Npt Writeable
                 || !utlb_hit_flg[12]
                     && !(cp0_mach_mode && !utlb_hit_flg[14])  // L-bit for M-Mode
                     && !xxu_mmu_exec && !xxu_mmu_read
                  // Not Executeable
                 || !utlb_hit_flg[13]
                     && !(cp0_mach_mode && !utlb_hit_flg[14])  // L-bit for M-Mode
                     && xxu_mmu_exec) && utlb_hit_vld;

//==========================================================
// b. Write Port: JTLB refill infor
//==========================================================
//----------------------------------------------------------
// Update Info to Entry
//----------------------------------------------------------
// refill utlb entry when refill cmplt with no expt
assign {entry9_upd,  entry8_upd,
        entry7_upd,  entry6_upd,  entry5_upd,  entry4_upd,
        entry3_upd,  entry2_upd,  entry1_upd,  entry0_upd}
                           = plru_utlb_ref_num[9:0] & {10{utlb_ref_pavld}};

// entry updt info
assign utlb_upd_vpn[PPN_WIDTH-1:0] = jtlb_xx_ref_vpn[PPN_WIDTH-1:0];
assign utlb_upd_pgs[PGS_WIDTH-1:0] = jtlb_xx_ref_pgs[PGS_WIDTH-1:0];
assign utlb_upd_ppn[PPN_WIDTH-1:0] = jtlb_xx_ref_ppn[PPN_WIDTH-1:0];
assign utlb_upd_flg[FLG_WIDTH-1:0] = jtlb_xx_ref_flg[FLG_WIDTH-1:0];   // PMP
assign utlb_upd_mmu_on             = jtlb_xx_mmu_on;
                                     
//==========================================================
// c. PLRU update for every access
//==========================================================
//==========================================================
//                  uTLB Replacement Logic
//==========================================================
//----------------------------------------------------------
//                  uTLB Replacement Algorithm
//----------------------------------------------------------
// &ConnRule(s/^utlb/utlb/); @282
// &Instance("aq_mmu_plru","x_aq_mmu_plru"); @283
aq_mmu_plru  x_aq_mmu_plru (
  .cp0_mmu_icg_en         (cp0_mmu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .entry0_vld             (entry0_vld            ),
  .entry1_vld             (entry1_vld            ),
  .entry2_vld             (entry2_vld            ),
  .entry3_vld             (entry3_vld            ),
  .entry4_vld             (entry4_vld            ),
  .entry5_vld             (entry5_vld            ),
  .entry6_vld             (entry6_vld            ),
  .entry7_vld             (entry7_vld            ),
  .entry8_vld             (entry8_vld            ),
  .entry9_vld             (entry9_vld            ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .plru_utlb_ref_num      (plru_utlb_ref_num     ),
  .utlb_plru_read_hit     (utlb_plru_read_hit    ),
  .utlb_plru_read_hit_vld (utlb_plru_read_hit_vld),
  .utlb_plru_refill_on    (utlb_plru_refill_on   ),
  .utlb_plru_refill_vld   (utlb_plru_refill_vld  )
);


assign utlb_plru_refill_on  = utlb_ref_wfc;
assign utlb_plru_refill_vld = utlb_ref_pavld;

// TODO for icg timing : NOTE hurt power
assign plru_upd_en = xxu_mmu_va_vld; // && (utlb_plru_read_hit[9:0] != entry_hit[9:0]);
// &Instance("gated_clk_cell", "x_utlb_plru_gateclk"); @290
gated_clk_cell  x_utlb_plru_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (plru_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (plru_upd_en       ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @291
//           .external_en(1'b0          ), @292
//           .global_en  (1'b1          ), @293
//           .module_en  (cp0_mmu_icg_en), @294
//           .local_en   (plru_upd_en   ), @295
//           .clk_out    (plru_clk      ) @296
//          ); @297

always @(posedge plru_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    utlb_plru_read_hit[9:0] <= 10'b0;
  else if(plru_upd_en)
    utlb_plru_read_hit[9:0] <= entry_hit[9:0];
end
assign utlb_plru_read_hit_vld = |utlb_plru_read_hit[9:0];


//==========================================================
// 3. Visit jTLB when uTLB miss
// a. Refill FSM
// b. uTLB Miss Req
// c. HPCP Counter
//==========================================================
//----------------------------------------------------------
// a. Refill FSM
//----------------------------------------------------------
// IDLE: default state
// WFC : wait utlb refill req to be granted
// WFC : wait utlb refill cmplt to refill utlb
// ABT : wait utlb refill cmplt when abort happened
parameter IDLE  = 2'b00,
          WFG   = 2'b01,
          WFC   = 2'b10,
          ABT   = 2'b11;

//  When utlb miss and mmu is enabled, utlb refill SM will
//  be started
assign utlb_miss_vld = xxu_mmu_va_vld && !utlb_hit_vld
                                      && !utlb_va_illegal
                                      && !cp0_mmu_lpmd_req;

always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ref_cur_st[1:0] <= 2'b0;
  else
    ref_cur_st[1:0] <= ref_nxt_st[1:0];
end

// &CombBeg; @341
always @( ref_cur_st
       or utlb_miss_vld
       or xxu_mmu_abort
       or arb_utlb_grant
       or jtlb_utlb_ref_cmplt)
begin
case (ref_cur_st)
IDLE:
begin
  if(xxu_mmu_abort)
    ref_nxt_st[1:0] = IDLE;
  else if(utlb_miss_vld)
    ref_nxt_st[1:0] = WFG;
  else
    ref_nxt_st[1:0] = IDLE;
end
WFG:
begin
  if(arb_utlb_grant && xxu_mmu_abort)
    ref_nxt_st[1:0] = ABT;
  else if(xxu_mmu_abort)
    ref_nxt_st[1:0] = IDLE;
  else if(arb_utlb_grant)
    ref_nxt_st[1:0] = WFC;
  else
    ref_nxt_st[1:0] = WFG;
end
WFC:
begin
  if(jtlb_utlb_ref_cmplt)
    ref_nxt_st[1:0] = IDLE;
  else if(xxu_mmu_abort)
    ref_nxt_st[1:0] = ABT;
  else
    ref_nxt_st[1:0] = WFC;
end
ABT:
begin
  if(jtlb_utlb_ref_cmplt)
    ref_nxt_st[1:0] = IDLE;
  else
    ref_nxt_st[1:0] = ABT;
end
default:
begin
   ref_nxt_st[1:0] = IDLE;
end
endcase
// &CombEnd; @384
end

assign utlb_ref_idle   = ref_cur_st[1:0] == IDLE;
assign utlb_ref_wfg    = ref_cur_st[1:0] == WFG;
assign utlb_ref_wfc    = ref_cur_st[1:0] == WFC;
assign utlb_ref_abt    = ref_cur_st[1:0] == ABT;

assign utlb_ref_cmplt = utlb_ref_wfc && jtlb_utlb_ref_cmplt
                     || utlb_ref_abt && jtlb_utlb_ref_cmplt;
assign utlb_ref_pavld = utlb_ref_wfc && jtlb_utlb_ref_pavld;
assign utlb_ref_pgflt = utlb_ref_wfc && jtlb_utlb_pgflt;
assign utlb_ref_acflt = utlb_ref_wfc && jtlb_utlb_acc_err;

// miss vpn
always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ref_vpn[PPN_WIDTH-1:0] <= {PPN_WIDTH{1'b0}};
    ref_read               <= 1'b0;
    ref_mode[1:0]          <= 2'b0;
    ref_asid[15:0]         <= 16'b0;
  end
  else if(utlb_miss_vld && utlb_ref_idle)
  begin
    ref_vpn[PPN_WIDTH-1:0] <= xxu_mmu_va[PPN_WIDTH-1:0];
    ref_read               <= !xxu_mmu_exec && xxu_mmu_read;
    ref_mode[1:0]          <= cp0_priv_mode[1:0];
    ref_asid[15:0]         <= regs_ptw_cur_asid[15:0];
  end
end

//----------------------------------------------------------
// b. uTLB Miss Req
//----------------------------------------------------------
// req only in IDLE, so utlb refill is blocking
assign utlb_miss_req                = utlb_ref_wfg;
assign utlb_miss_vpn[PPN_WIDTH-1:0] = ref_vpn[PPN_WIDTH-1:0];

//----------------------------------------------------------
// c. HPCP Counter
//----------------------------------------------------------
assign utlb_miss_cnt = utlb_ref_pavld && hpcp_mmu_cnt_en;

always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    utlb_miss <= 1'b0;
  else if(utlb_miss_cnt)
    utlb_miss <= 1'b1;
  else if(utlb_miss)
    utlb_miss <= 1'b0;
end

//==========================================================
// Rename for Output
//==========================================================

// Output to Arbiter
assign utlb_arb_req                = utlb_miss_req;
assign utlb_arb_vpn[PPN_WIDTH-1:0] = utlb_miss_vpn[PPN_WIDTH-1:0];
assign utlb_arb_cmplt              = utlb_ref_cmplt;
assign utlb_arb_read               = ref_read;
assign utlb_arb_mach               = ref_mode[1:0] == 2'b11 || !regs_mmu_en;
assign utlb_arb_mode[1:0]          = ref_mode[1:0];
assign utlb_arb_asid[15:0]         = ref_asid[15:0];

// Output to top
assign utlb_top_ref_cur_st[1:0] = ref_cur_st[1:0];

// Output to XXU
assign mmu_xxu_pa_vld            = utlb_pavld;
assign mmu_xxu_pa[PPN_WIDTH-1:0] = utlb_hit_pa[PPN_WIDTH-1:0]; 
assign mmu_xxu_access_fault      = utlb_deny;
assign mmu_xxu_page_fault        = utlb_page_fault && !utlb_off;
assign mmu_xxu_so                = utlb_so;
assign mmu_xxu_ca                = utlb_ca;
assign mmu_xxu_buf               = utlb_buf; 
assign mmu_xxu_sh                = utlb_sh;
assign mmu_xxu_sec               = utlb_sec;

// Output to IFU
assign utlb_hpcp_utlb_miss = utlb_miss;


// &ModuleEnd; @483
endmodule


