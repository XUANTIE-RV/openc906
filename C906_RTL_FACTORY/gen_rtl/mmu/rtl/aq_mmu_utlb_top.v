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
module aq_mmu_utlb_top(
  arb_dutlb_grant,
  arb_iutlb_grant,
  cp0_mmu_icg_en,
  cp0_mmu_lpmd_req,
  cp0_mmu_mxr,
  cp0_mmu_satp_wen,
  cp0_mmu_sum,
  cp0_mmu_tlb_va,
  cp0_yy_priv_mode,
  cpurst_b,
  dutlb_arb_asid,
  dutlb_arb_cmplt,
  dutlb_arb_mach,
  dutlb_arb_mode,
  dutlb_arb_read,
  dutlb_arb_req,
  dutlb_arb_vpn,
  dutlb_top_ref_cur_st,
  forever_cpuclk,
  hpcp_mmu_cnt_en,
  ifu_mmu_abort,
  ifu_mmu_va,
  ifu_mmu_va_vld,
  iutlb_arb_asid,
  iutlb_arb_cmplt,
  iutlb_arb_mach,
  iutlb_arb_mode,
  iutlb_arb_req,
  iutlb_arb_vpn,
  iutlb_top_ref_cur_st,
  jtlb_dutlb_acc_err,
  jtlb_dutlb_pgflt,
  jtlb_dutlb_ref_cmplt,
  jtlb_dutlb_ref_pavld,
  jtlb_iutlb_acc_err,
  jtlb_iutlb_pgflt,
  jtlb_iutlb_ref_cmplt,
  jtlb_iutlb_ref_pavld,
  jtlb_xx_mmu_on,
  jtlb_xx_ref_flg,
  jtlb_xx_ref_pgs,
  jtlb_xx_ref_ppn,
  jtlb_xx_ref_vpn,
  lsu_mmu_abort,
  lsu_mmu_priv_mode,
  lsu_mmu_st_inst,
  lsu_mmu_va,
  lsu_mmu_va_vld,
  mmu_hpcp_dutlb_miss,
  mmu_hpcp_iutlb_miss,
  mmu_ifu_access_fault,
  mmu_ifu_pa,
  mmu_ifu_pa_vld,
  mmu_ifu_prot,
  mmu_lsu_access_fault,
  mmu_lsu_buf,
  mmu_lsu_ca,
  mmu_lsu_pa,
  mmu_lsu_pa_vld,
  mmu_lsu_page_fault,
  mmu_lsu_sec,
  mmu_lsu_sh,
  mmu_lsu_so,
  mmu_top_clk,
  pad_yy_icg_scan_en,
  regs_mmu_en,
  regs_ptw_cur_asid,
  tlboper_xx_clr,
  tlboper_xx_inv_va_req
);

// &Ports; @23
input           arb_dutlb_grant;      
input           arb_iutlb_grant;      
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
input           ifu_mmu_abort;        
input   [51:0]  ifu_mmu_va;           
input           ifu_mmu_va_vld;       
input           jtlb_dutlb_acc_err;   
input           jtlb_dutlb_pgflt;     
input           jtlb_dutlb_ref_cmplt; 
input           jtlb_dutlb_ref_pavld; 
input           jtlb_iutlb_acc_err;   
input           jtlb_iutlb_pgflt;     
input           jtlb_iutlb_ref_cmplt; 
input           jtlb_iutlb_ref_pavld; 
input           jtlb_xx_mmu_on;       
input   [14:0]  jtlb_xx_ref_flg;      
input   [2 :0]  jtlb_xx_ref_pgs;      
input   [27:0]  jtlb_xx_ref_ppn;      
input   [27:0]  jtlb_xx_ref_vpn;      
input           lsu_mmu_abort;        
input   [1 :0]  lsu_mmu_priv_mode;    
input           lsu_mmu_st_inst;      
input   [51:0]  lsu_mmu_va;           
input           lsu_mmu_va_vld;       
input           mmu_top_clk;          
input           pad_yy_icg_scan_en;   
input           regs_mmu_en;          
input   [15:0]  regs_ptw_cur_asid;    
input           tlboper_xx_clr;       
input           tlboper_xx_inv_va_req; 
output  [15:0]  dutlb_arb_asid;       
output          dutlb_arb_cmplt;      
output          dutlb_arb_mach;       
output  [1 :0]  dutlb_arb_mode;       
output          dutlb_arb_read;       
output          dutlb_arb_req;        
output  [27:0]  dutlb_arb_vpn;        
output  [1 :0]  dutlb_top_ref_cur_st; 
output  [15:0]  iutlb_arb_asid;       
output          iutlb_arb_cmplt;      
output          iutlb_arb_mach;       
output  [1 :0]  iutlb_arb_mode;       
output          iutlb_arb_req;        
output  [27:0]  iutlb_arb_vpn;        
output  [1 :0]  iutlb_top_ref_cur_st; 
output          mmu_hpcp_dutlb_miss;  
output          mmu_hpcp_iutlb_miss;  
output          mmu_ifu_access_fault; 
output  [27:0]  mmu_ifu_pa;           
output          mmu_ifu_pa_vld;       
output  [4 :0]  mmu_ifu_prot;         
output          mmu_lsu_access_fault; 
output          mmu_lsu_buf;          
output          mmu_lsu_ca;           
output  [27:0]  mmu_lsu_pa;           
output          mmu_lsu_pa_vld;       
output          mmu_lsu_page_fault;   
output          mmu_lsu_sec;          
output          mmu_lsu_sh;           
output          mmu_lsu_so;           

// &Regs; @24

// &Wires; @25
wire            arb_dutlb_grant;      
wire            arb_iutlb_grant;      
wire            cp0_mmu_icg_en;       
wire            cp0_mmu_lpmd_req;     
wire            cp0_mmu_mxr;          
wire            cp0_mmu_satp_wen;     
wire            cp0_mmu_sum;          
wire    [26:0]  cp0_mmu_tlb_va;       
wire    [1 :0]  cp0_yy_priv_mode;     
wire            cpurst_b;             
wire    [15:0]  dutlb_arb_asid;       
wire            dutlb_arb_cmplt;      
wire            dutlb_arb_mach;       
wire    [1 :0]  dutlb_arb_mode;       
wire            dutlb_arb_read;       
wire            dutlb_arb_req;        
wire    [27:0]  dutlb_arb_vpn;        
wire            dutlb_hpcp_utlb_miss; 
wire    [1 :0]  dutlb_top_ref_cur_st; 
wire            forever_cpuclk;       
wire            hpcp_mmu_cnt_en;      
wire            ifu_mmu_abort;        
wire            ifu_mmu_exec;         
wire            ifu_mmu_read;         
wire    [51:0]  ifu_mmu_va;           
wire            ifu_mmu_va_vld;       
wire    [15:0]  iutlb_arb_asid;       
wire            iutlb_arb_cmplt;      
wire            iutlb_arb_mach;       
wire    [1 :0]  iutlb_arb_mode;       
wire            iutlb_arb_read;       
wire            iutlb_arb_req;        
wire    [27:0]  iutlb_arb_vpn;        
wire            iutlb_hpcp_utlb_miss; 
wire    [1 :0]  iutlb_top_ref_cur_st; 
wire            jtlb_dutlb_acc_err;   
wire            jtlb_dutlb_pgflt;     
wire            jtlb_dutlb_ref_cmplt; 
wire            jtlb_dutlb_ref_pavld; 
wire            jtlb_iutlb_acc_err;   
wire            jtlb_iutlb_pgflt;     
wire            jtlb_iutlb_ref_cmplt; 
wire            jtlb_iutlb_ref_pavld; 
wire            jtlb_xx_mmu_on;       
wire    [14:0]  jtlb_xx_ref_flg;      
wire    [2 :0]  jtlb_xx_ref_pgs;      
wire    [27:0]  jtlb_xx_ref_ppn;      
wire    [27:0]  jtlb_xx_ref_vpn;      
wire            lsu_mmu_abort;        
wire            lsu_mmu_exec;         
wire    [1 :0]  lsu_mmu_priv_mode;    
wire            lsu_mmu_read;         
wire            lsu_mmu_st_inst;      
wire    [51:0]  lsu_mmu_va;           
wire            lsu_mmu_va_vld;       
wire            mmu_hpcp_dutlb_miss;  
wire            mmu_hpcp_iutlb_miss;  
wire            mmu_ifu_access_fault; 
wire            mmu_ifu_buf;          
wire            mmu_ifu_ca;           
wire    [27:0]  mmu_ifu_pa;           
wire            mmu_ifu_pa_vld;       
wire            mmu_ifu_page_fault;   
wire    [4 :0]  mmu_ifu_prot;         
wire            mmu_ifu_sec;          
wire            mmu_ifu_sh;           
wire            mmu_ifu_so;           
wire            mmu_lsu_access_fault; 
wire            mmu_lsu_buf;          
wire            mmu_lsu_ca;           
wire    [27:0]  mmu_lsu_pa;           
wire            mmu_lsu_pa_vld;       
wire            mmu_lsu_page_fault;   
wire            mmu_lsu_sec;          
wire            mmu_lsu_sh;           
wire            mmu_lsu_so;           
wire            mmu_top_clk;          
wire            pad_yy_icg_scan_en;   
wire            regs_mmu_en;          
wire    [15:0]  regs_ptw_cur_asid;    
wire            tlboper_xx_clr;       
wire            tlboper_xx_inv_va_req; 


//==========================================================
// Instance utlbs
//==========================================================

// &ConnRule(s/xxu/ifu/); @31
// &ConnRule(s/utlb/iutlb/); @32
// &Instance("aq_mmu_utlb","x_aq_mmu_iutlb"); @33
aq_mmu_utlb  x_aq_mmu_iutlb (
  .arb_utlb_grant        (arb_iutlb_grant      ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .jtlb_utlb_acc_err     (jtlb_iutlb_acc_err   ),
  .jtlb_utlb_pgflt       (jtlb_iutlb_pgflt     ),
  .jtlb_utlb_ref_cmplt   (jtlb_iutlb_ref_cmplt ),
  .jtlb_utlb_ref_pavld   (jtlb_iutlb_ref_pavld ),
  .jtlb_xx_mmu_on        (jtlb_xx_mmu_on       ),
  .jtlb_xx_ref_flg       (jtlb_xx_ref_flg      ),
  .jtlb_xx_ref_pgs       (jtlb_xx_ref_pgs      ),
  .jtlb_xx_ref_ppn       (jtlb_xx_ref_ppn      ),
  .jtlb_xx_ref_vpn       (jtlb_xx_ref_vpn      ),
  .lsu_mmu_priv_mode     (lsu_mmu_priv_mode    ),
  .mmu_top_clk           (mmu_top_clk          ),
  .mmu_xxu_access_fault  (mmu_ifu_access_fault ),
  .mmu_xxu_buf           (mmu_ifu_buf          ),
  .mmu_xxu_ca            (mmu_ifu_ca           ),
  .mmu_xxu_pa            (mmu_ifu_pa           ),
  .mmu_xxu_pa_vld        (mmu_ifu_pa_vld       ),
  .mmu_xxu_page_fault    (mmu_ifu_page_fault   ),
  .mmu_xxu_sec           (mmu_ifu_sec          ),
  .mmu_xxu_sh            (mmu_ifu_sh           ),
  .mmu_xxu_so            (mmu_ifu_so           ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .regs_ptw_cur_asid     (regs_ptw_cur_asid    ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_arb_asid         (iutlb_arb_asid       ),
  .utlb_arb_cmplt        (iutlb_arb_cmplt      ),
  .utlb_arb_mach         (iutlb_arb_mach       ),
  .utlb_arb_mode         (iutlb_arb_mode       ),
  .utlb_arb_read         (iutlb_arb_read       ),
  .utlb_arb_req          (iutlb_arb_req        ),
  .utlb_arb_vpn          (iutlb_arb_vpn        ),
  .utlb_hpcp_utlb_miss   (iutlb_hpcp_utlb_miss ),
  .utlb_top_ref_cur_st   (iutlb_top_ref_cur_st ),
  .xxu_mmu_abort         (ifu_mmu_abort        ),
  .xxu_mmu_exec          (ifu_mmu_exec         ),
  .xxu_mmu_read          (ifu_mmu_read         ),
  .xxu_mmu_va            (ifu_mmu_va           ),
  .xxu_mmu_va_vld        (ifu_mmu_va_vld       )
);


// &ConnRule(s/xxu/lsu/); @35
// &ConnRule(s/utlb/dutlb/); @36
// &Instance("aq_mmu_utlb","x_aq_mmu_dutlb"); @37
aq_mmu_utlb  x_aq_mmu_dutlb (
  .arb_utlb_grant        (arb_dutlb_grant      ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .jtlb_utlb_acc_err     (jtlb_dutlb_acc_err   ),
  .jtlb_utlb_pgflt       (jtlb_dutlb_pgflt     ),
  .jtlb_utlb_ref_cmplt   (jtlb_dutlb_ref_cmplt ),
  .jtlb_utlb_ref_pavld   (jtlb_dutlb_ref_pavld ),
  .jtlb_xx_mmu_on        (jtlb_xx_mmu_on       ),
  .jtlb_xx_ref_flg       (jtlb_xx_ref_flg      ),
  .jtlb_xx_ref_pgs       (jtlb_xx_ref_pgs      ),
  .jtlb_xx_ref_ppn       (jtlb_xx_ref_ppn      ),
  .jtlb_xx_ref_vpn       (jtlb_xx_ref_vpn      ),
  .lsu_mmu_priv_mode     (lsu_mmu_priv_mode    ),
  .mmu_top_clk           (mmu_top_clk          ),
  .mmu_xxu_access_fault  (mmu_lsu_access_fault ),
  .mmu_xxu_buf           (mmu_lsu_buf          ),
  .mmu_xxu_ca            (mmu_lsu_ca           ),
  .mmu_xxu_pa            (mmu_lsu_pa           ),
  .mmu_xxu_pa_vld        (mmu_lsu_pa_vld       ),
  .mmu_xxu_page_fault    (mmu_lsu_page_fault   ),
  .mmu_xxu_sec           (mmu_lsu_sec          ),
  .mmu_xxu_sh            (mmu_lsu_sh           ),
  .mmu_xxu_so            (mmu_lsu_so           ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .regs_ptw_cur_asid     (regs_ptw_cur_asid    ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_arb_asid         (dutlb_arb_asid       ),
  .utlb_arb_cmplt        (dutlb_arb_cmplt      ),
  .utlb_arb_mach         (dutlb_arb_mach       ),
  .utlb_arb_mode         (dutlb_arb_mode       ),
  .utlb_arb_read         (dutlb_arb_read       ),
  .utlb_arb_req          (dutlb_arb_req        ),
  .utlb_arb_vpn          (dutlb_arb_vpn        ),
  .utlb_hpcp_utlb_miss   (dutlb_hpcp_utlb_miss ),
  .utlb_top_ref_cur_st   (dutlb_top_ref_cur_st ),
  .xxu_mmu_abort         (lsu_mmu_abort        ),
  .xxu_mmu_exec          (lsu_mmu_exec         ),
  .xxu_mmu_read          (lsu_mmu_read         ),
  .xxu_mmu_va            (lsu_mmu_va           ),
  .xxu_mmu_va_vld        (lsu_mmu_va_vld       )
);


// I-uTLB related ports
// &Force("nonport", "mmu_ifu_so"); @40
// &Force("nonport", "mmu_ifu_sh"); @41
// &Force("nonport", "iutlb_arb_read"); @42
assign ifu_mmu_exec = 1'b1;
assign ifu_mmu_read = 1'b1;
assign mmu_hpcp_iutlb_miss = iutlb_hpcp_utlb_miss;
assign mmu_ifu_prot[4:0] = {mmu_ifu_page_fault, 
                            cp0_yy_priv_mode[1:0] == 2'b01,
                            mmu_ifu_ca, mmu_ifu_buf, mmu_ifu_sec};

// D-uTLB related ports
assign lsu_mmu_exec = 1'b0;
assign lsu_mmu_read = !lsu_mmu_st_inst;
assign mmu_hpcp_dutlb_miss = dutlb_hpcp_utlb_miss;

// &ModuleEnd; @55
endmodule


