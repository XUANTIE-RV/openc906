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
module aq_cp0_special(
  cp0_biu_lpmd_b,
  cp0_hpcp_sync_stall_vld,
  cp0_ifu_bht_inv,
  cp0_ifu_icache_inv_addr,
  cp0_ifu_icache_inv_req,
  cp0_ifu_icache_inv_type,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_ifu_rst_inv_done,
  cp0_lsu_fence_req,
  cp0_lsu_icc_addr,
  cp0_lsu_icc_op,
  cp0_lsu_icc_req,
  cp0_lsu_icc_type,
  cp0_lsu_sync_req,
  cp0_mmu_lpmd_req,
  cp0_mmu_tlb_all_inv,
  cp0_mmu_tlb_asid,
  cp0_mmu_tlb_asid_all_inv,
  cp0_mmu_tlb_va,
  cp0_mmu_tlb_va_all_inv,
  cp0_mmu_tlb_va_asid_inv,
  cp0_rtu_fence_idle,
  cp0_rtu_in_lpmd,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_cp0_wake_up,
  fence_top_cur_state,
  forever_cpuclk,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_rst_inv_req,
  ifu_yy_xx_no_op,
  iui_special_cache,
  iui_special_cache_func,
  iui_special_fence,
  iui_special_fencei,
  iui_special_rs1,
  iui_special_rs1_x0,
  iui_special_rs2,
  iui_special_rs2_x0,
  iui_special_sfence,
  iui_special_sync,
  iui_special_synci,
  iui_special_vsetvl,
  iui_special_vsetvl_dp,
  iui_special_vsetvl_rs1,
  iui_special_vsetvl_rs2,
  iui_special_wfi,
  lpmd_top_cur_state,
  lsu_cp0_fence_ack,
  lsu_cp0_icc_done,
  lsu_cp0_sync_ack,
  mmu_cp0_tlb_inv_done,
  mmu_yy_xx_no_op,
  pad_yy_icg_scan_en,
  regs_lpmd_int_vld,
  regs_special_bht_inv,
  regs_special_dcache_clr,
  regs_special_dcache_inv,
  regs_special_dcache_req,
  regs_special_icache_inv,
  regs_xx_icg_en,
  rst_top_op_done,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_flush,
  special_iui_stall,
  special_iui_vsetvl_wdata,
  special_regs_vsetvl_dp
);


// &Ports; @25
input           cpurst_b;                       
input           dtu_cp0_wake_up;                
input           forever_cpuclk;                 
input           ifu_cp0_bht_inv_done;           
input           ifu_cp0_icache_inv_done;        
input           ifu_cp0_rst_inv_req;            
input           ifu_yy_xx_no_op;                
input           iui_special_cache;              
input   [5 :0]  iui_special_cache_func;         
input           iui_special_fence;              
input           iui_special_fencei;             
input   [63:0]  iui_special_rs1;                
input           iui_special_rs1_x0;             
input   [63:0]  iui_special_rs2;                
input           iui_special_rs2_x0;             
input           iui_special_sfence;             
input           iui_special_sync;               
input           iui_special_synci;              
input           iui_special_vsetvl;             
input           iui_special_vsetvl_dp;          
input   [63:0]  iui_special_vsetvl_rs1;         
input   [11:0]  iui_special_vsetvl_rs2;         
input           iui_special_wfi;                
input           lsu_cp0_fence_ack;              
input           lsu_cp0_icc_done;               
input           lsu_cp0_sync_ack;               
input           mmu_cp0_tlb_inv_done;           
input           mmu_yy_xx_no_op;                
input           pad_yy_icg_scan_en;             
input           regs_lpmd_int_vld;              
input           regs_special_bht_inv;           
input           regs_special_dcache_clr;        
input           regs_special_dcache_inv;        
input           regs_special_dcache_req;        
input           regs_special_icache_inv;        
input           regs_xx_icg_en;                 
input           rtu_yy_xx_dbgon;                
input           rtu_yy_xx_flush;                
output  [1 :0]  cp0_biu_lpmd_b;                 
output          cp0_hpcp_sync_stall_vld;        
output          cp0_ifu_bht_inv;                
output  [63:0]  cp0_ifu_icache_inv_addr;        
output          cp0_ifu_icache_inv_req;         
output  [1 :0]  cp0_ifu_icache_inv_type;        
output          cp0_ifu_in_lpmd;                
output          cp0_ifu_lpmd_req;               
output          cp0_ifu_rst_inv_done;           
output          cp0_lsu_fence_req;              
output  [63:0]  cp0_lsu_icc_addr;               
output  [1 :0]  cp0_lsu_icc_op;                 
output          cp0_lsu_icc_req;                
output  [1 :0]  cp0_lsu_icc_type;               
output          cp0_lsu_sync_req;               
output          cp0_mmu_lpmd_req;               
output          cp0_mmu_tlb_all_inv;            
output  [15:0]  cp0_mmu_tlb_asid;               
output          cp0_mmu_tlb_asid_all_inv;       
output  [26:0]  cp0_mmu_tlb_va;                 
output          cp0_mmu_tlb_va_all_inv;         
output          cp0_mmu_tlb_va_asid_inv;        
output          cp0_rtu_fence_idle;             
output          cp0_rtu_in_lpmd;                
output          cp0_yy_clk_en;                  
output  [2 :0]  fence_top_cur_state;            
output  [1 :0]  lpmd_top_cur_state;             
output          rst_top_op_done;                
output          special_iui_stall;              
output  [63:0]  special_iui_vsetvl_wdata;       
output          special_regs_vsetvl_dp;         

// &Regs; @26
reg             special_sync_stall_cnt_vld_flop; 

// &Wires; @27
wire    [1 :0]  cp0_biu_lpmd_b;                 
wire            cp0_hpcp_sync_stall_vld;        
wire            cp0_ifu_bht_inv;                
wire    [63:0]  cp0_ifu_icache_inv_addr;        
wire            cp0_ifu_icache_inv_req;         
wire    [1 :0]  cp0_ifu_icache_inv_type;        
wire            cp0_ifu_in_lpmd;                
wire            cp0_ifu_lpmd_req;               
wire            cp0_ifu_rst_inv_done;           
wire            cp0_lsu_fence_req;              
wire    [63:0]  cp0_lsu_icc_addr;               
wire    [1 :0]  cp0_lsu_icc_op;                 
wire            cp0_lsu_icc_req;                
wire    [1 :0]  cp0_lsu_icc_type;               
wire            cp0_lsu_sync_req;               
wire            cp0_mmu_lpmd_req;               
wire            cp0_mmu_tlb_all_inv;            
wire    [15:0]  cp0_mmu_tlb_asid;               
wire            cp0_mmu_tlb_asid_all_inv;       
wire    [26:0]  cp0_mmu_tlb_va;                 
wire            cp0_mmu_tlb_va_all_inv;         
wire            cp0_mmu_tlb_va_asid_inv;        
wire            cp0_rtu_fence_idle;             
wire            cp0_rtu_in_lpmd;                
wire            cp0_yy_clk_en;                  
wire            cpurst_b;                       
wire            dtu_cp0_wake_up;                
wire            fence_clk;                      
wire            fence_clk_en;                   
wire    [2 :0]  fence_top_cur_state;            
wire            forever_cpuclk;                 
wire            ifu_cp0_bht_inv_done;           
wire            ifu_cp0_icache_inv_done;        
wire            ifu_cp0_rst_inv_req;            
wire            ifu_yy_xx_no_op;                
wire            inv_sm_clk;                     
wire            inv_sm_clk_en;                  
wire            iui_special_cache;              
wire    [5 :0]  iui_special_cache_func;         
wire            iui_special_fence;              
wire            iui_special_fencei;             
wire    [63:0]  iui_special_rs1;                
wire            iui_special_rs1_x0;             
wire    [63:0]  iui_special_rs2;                
wire            iui_special_rs2_x0;             
wire            iui_special_sfence;             
wire            iui_special_sync;               
wire            iui_special_synci;              
wire            iui_special_vsetvl;             
wire            iui_special_vsetvl_dp;          
wire    [63:0]  iui_special_vsetvl_rs1;         
wire    [11:0]  iui_special_vsetvl_rs2;         
wire            iui_special_wfi;                
wire            lpmd_clk;                       
wire            lpmd_clk_en;                    
wire    [1 :0]  lpmd_top_cur_state;             
wire            lsu_cp0_fence_ack;              
wire            lsu_cp0_icc_done;               
wire            lsu_cp0_sync_ack;               
wire            mmu_cp0_tlb_inv_done;           
wire            mmu_yy_xx_no_op;                
wire            pad_yy_icg_scan_en;             
wire            regs_lpmd_int_vld;              
wire            regs_special_bht_inv;           
wire            regs_special_dcache_clr;        
wire            regs_special_dcache_inv;        
wire            regs_special_dcache_req;        
wire            regs_special_icache_inv;        
wire            regs_xx_icg_en;                 
wire            rst_top_op_done;                
wire            rtu_yy_xx_dbgon;                
wire            rtu_yy_xx_flush;                
wire            sfence_clr_asid_all;            
wire            sfence_clr_va_all;              
wire            sfence_clr_va_asid;             
wire    [1 :0]  special_cacheop_op;             
wire    [1 :0]  special_cacheop_type;           
wire            special_clk;                    
wire            special_clk_en;                 
wire            special_dcacheop_req;           
wire            special_fence_dcache_req;       
wire            special_fence_icache_req;       
wire            special_fence_mmu_req;          
wire            special_fence_req;              
wire            special_fence_stall;            
wire            special_icacheop_req;           
wire            special_inst_fence_req;         
wire            special_inst_sync_req;          
wire            special_iui_stall;              
wire    [63:0]  special_iui_vsetvl_wdata;       
wire            special_lpmd_stall;             
wire            special_lpmd_sync_req;          
wire            special_op_done;                
wire            special_regs_vsetvl_dp;         
wire            special_sync_req;               
wire            special_sync_stall_cnt_vld;     


//==========================================================
//                          Stall
//==========================================================
// 1. lpmd_stall
// 2. cache inst stall
// 3. fence inst stall

assign special_iui_stall = special_lpmd_stall
                        || special_fence_stall;

//==========================================================
//                        Fence Req
//==========================================================
// 1. inst fence req
assign special_fence_req = special_inst_fence_req;

//==========================================================
//                         Sync Req
//==========================================================
// 1. inst sync req
// 2. lpmd sync req

assign special_sync_req = special_lpmd_sync_req
                       || special_inst_sync_req;


// &Instance("aq_cp0_lpmd"); @55
aq_cp0_lpmd  x_aq_cp0_lpmd (
  .cp0_biu_lpmd_b        (cp0_biu_lpmd_b       ),
  .cp0_ifu_in_lpmd       (cp0_ifu_in_lpmd      ),
  .cp0_ifu_lpmd_req      (cp0_ifu_lpmd_req     ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_rtu_in_lpmd       (cp0_rtu_in_lpmd      ),
  .cp0_yy_clk_en         (cp0_yy_clk_en        ),
  .cpurst_b              (cpurst_b             ),
  .dtu_cp0_wake_up       (dtu_cp0_wake_up      ),
  .forever_cpuclk        (forever_cpuclk       ),
  .ifu_yy_xx_no_op       (ifu_yy_xx_no_op      ),
  .iui_special_wfi       (iui_special_wfi      ),
  .lpmd_clk              (lpmd_clk             ),
  .lpmd_clk_en           (lpmd_clk_en          ),
  .lpmd_top_cur_state    (lpmd_top_cur_state   ),
  .lsu_cp0_sync_ack      (lsu_cp0_sync_ack     ),
  .mmu_yy_xx_no_op       (mmu_yy_xx_no_op      ),
  .regs_lpmd_int_vld     (regs_lpmd_int_vld    ),
  .rtu_yy_xx_dbgon       (rtu_yy_xx_dbgon      ),
  .rtu_yy_xx_flush       (rtu_yy_xx_flush      ),
  .special_lpmd_stall    (special_lpmd_stall   ),
  .special_lpmd_sync_req (special_lpmd_sync_req)
);


// &Instance("aq_cp0_rst_ctrl"); @57
aq_cp0_rst_ctrl  x_aq_cp0_rst_ctrl (
  .cp0_ifu_bht_inv          (cp0_ifu_bht_inv         ),
  .cp0_ifu_icache_inv_addr  (cp0_ifu_icache_inv_addr ),
  .cp0_ifu_icache_inv_req   (cp0_ifu_icache_inv_req  ),
  .cp0_ifu_icache_inv_type  (cp0_ifu_icache_inv_type ),
  .cp0_ifu_rst_inv_done     (cp0_ifu_rst_inv_done    ),
  .cp0_lsu_icc_addr         (cp0_lsu_icc_addr        ),
  .cp0_lsu_icc_op           (cp0_lsu_icc_op          ),
  .cp0_lsu_icc_req          (cp0_lsu_icc_req         ),
  .cp0_lsu_icc_type         (cp0_lsu_icc_type        ),
  .cp0_mmu_tlb_all_inv      (cp0_mmu_tlb_all_inv     ),
  .cp0_mmu_tlb_asid         (cp0_mmu_tlb_asid        ),
  .cp0_mmu_tlb_asid_all_inv (cp0_mmu_tlb_asid_all_inv),
  .cp0_mmu_tlb_va           (cp0_mmu_tlb_va          ),
  .cp0_mmu_tlb_va_all_inv   (cp0_mmu_tlb_va_all_inv  ),
  .cp0_mmu_tlb_va_asid_inv  (cp0_mmu_tlb_va_asid_inv ),
  .cp0_rtu_fence_idle       (cp0_rtu_fence_idle      ),
  .cpurst_b                 (cpurst_b                ),
  .ifu_cp0_bht_inv_done     (ifu_cp0_bht_inv_done    ),
  .ifu_cp0_icache_inv_done  (ifu_cp0_icache_inv_done ),
  .ifu_cp0_rst_inv_req      (ifu_cp0_rst_inv_req     ),
  .inv_sm_clk               (inv_sm_clk              ),
  .inv_sm_clk_en            (inv_sm_clk_en           ),
  .iui_special_rs1          (iui_special_rs1         ),
  .iui_special_rs2          (iui_special_rs2         ),
  .lsu_cp0_icc_done         (lsu_cp0_icc_done        ),
  .mmu_cp0_tlb_inv_done     (mmu_cp0_tlb_inv_done    ),
  .regs_special_bht_inv     (regs_special_bht_inv    ),
  .regs_special_dcache_clr  (regs_special_dcache_clr ),
  .regs_special_dcache_inv  (regs_special_dcache_inv ),
  .regs_special_dcache_req  (regs_special_dcache_req ),
  .regs_special_icache_inv  (regs_special_icache_inv ),
  .rst_top_op_done          (rst_top_op_done         ),
  .sfence_clr_asid_all      (sfence_clr_asid_all     ),
  .sfence_clr_va_all        (sfence_clr_va_all       ),
  .sfence_clr_va_asid       (sfence_clr_va_asid      ),
  .special_cacheop_op       (special_cacheop_op      ),
  .special_cacheop_type     (special_cacheop_type    ),
  .special_dcacheop_req     (special_dcacheop_req    ),
  .special_fence_dcache_req (special_fence_dcache_req),
  .special_fence_icache_req (special_fence_icache_req),
  .special_fence_mmu_req    (special_fence_mmu_req   ),
  .special_icacheop_req     (special_icacheop_req    ),
  .special_op_done          (special_op_done         )
);


// &Instance("aq_cp0_cache_inst"); @59
aq_cp0_cache_inst  x_aq_cp0_cache_inst (
  .iui_special_cache      (iui_special_cache     ),
  .iui_special_cache_func (iui_special_cache_func),
  .special_cacheop_op     (special_cacheop_op    ),
  .special_cacheop_type   (special_cacheop_type  ),
  .special_dcacheop_req   (special_dcacheop_req  ),
  .special_icacheop_req   (special_icacheop_req  )
);


// &Instance("aq_cp0_fence_inst"); @61
aq_cp0_fence_inst  x_aq_cp0_fence_inst (
  .cpurst_b                 (cpurst_b                ),
  .fence_clk                (fence_clk               ),
  .fence_clk_en             (fence_clk_en            ),
  .fence_top_cur_state      (fence_top_cur_state     ),
  .iui_special_fence        (iui_special_fence       ),
  .iui_special_fencei       (iui_special_fencei      ),
  .iui_special_rs1_x0       (iui_special_rs1_x0      ),
  .iui_special_rs2_x0       (iui_special_rs2_x0      ),
  .iui_special_sfence       (iui_special_sfence      ),
  .iui_special_sync         (iui_special_sync        ),
  .iui_special_synci        (iui_special_synci       ),
  .lsu_cp0_fence_ack        (lsu_cp0_fence_ack       ),
  .lsu_cp0_sync_ack         (lsu_cp0_sync_ack        ),
  .sfence_clr_asid_all      (sfence_clr_asid_all     ),
  .sfence_clr_va_all        (sfence_clr_va_all       ),
  .sfence_clr_va_asid       (sfence_clr_va_asid      ),
  .special_dcacheop_req     (special_dcacheop_req    ),
  .special_fence_dcache_req (special_fence_dcache_req),
  .special_fence_icache_req (special_fence_icache_req),
  .special_fence_mmu_req    (special_fence_mmu_req   ),
  .special_fence_stall      (special_fence_stall     ),
  .special_icacheop_req     (special_icacheop_req    ),
  .special_inst_fence_req   (special_inst_fence_req  ),
  .special_inst_sync_req    (special_inst_sync_req   ),
  .special_op_done          (special_op_done         )
);


// &Instance("aq_cp0_vector_inst"); @63
aq_cp0_vector_inst  x_aq_cp0_vector_inst (
  .iui_special_rs1_x0       (iui_special_rs1_x0      ),
  .iui_special_vsetvl       (iui_special_vsetvl      ),
  .iui_special_vsetvl_dp    (iui_special_vsetvl_dp   ),
  .iui_special_vsetvl_rs1   (iui_special_vsetvl_rs1  ),
  .iui_special_vsetvl_rs2   (iui_special_vsetvl_rs2  ),
  .special_iui_vsetvl_wdata (special_iui_vsetvl_wdata),
  .special_regs_vsetvl_dp   (special_regs_vsetvl_dp  )
);


// &Instance("gated_clk_cell", "x_special_clk"); @65
gated_clk_cell  x_special_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (special_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (special_clk_en    ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


//==========================================================
//                     HPCP Information
//==========================================================
assign special_sync_stall_cnt_vld = special_fence_stall && (iui_special_fence
                                                         || iui_special_fencei
                                                         || iui_special_sfence
                                                         || iui_special_sync
                                                         || iui_special_synci);

always @ (posedge special_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    special_sync_stall_cnt_vld_flop <= 1'b0;
  else
    special_sync_stall_cnt_vld_flop <= special_sync_stall_cnt_vld;
end

//==========================================================
//                           ICG
//==========================================================
assign special_clk_en = fence_clk_en
                     || lpmd_clk_en
                     || inv_sm_clk_en;

// &Connect(.clk_in      (forever_cpuclk), @91
//          .external_en (1'b0), @92
//          .global_en   (cp0_yy_clk_en), @93
//          .module_en   (regs_xx_icg_en), @94
//          .local_en    (special_clk_en), @95
//          .clk_out     (special_clk)); @96

assign inv_sm_clk = special_clk;
assign fence_clk  = special_clk;
assign lpmd_clk   = special_clk;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                          For xx
//----------------------------------------------------------
// &Force("output", "cp0_yy_clk_en"); @108

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign cp0_lsu_sync_req = special_sync_req;
assign cp0_lsu_fence_req = special_fence_req;

//==========================================================
//                         For HPCP
//==========================================================
assign cp0_hpcp_sync_stall_vld = special_sync_stall_cnt_vld_flop;

// &ModuleEnd; @121
endmodule



