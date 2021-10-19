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
// &Depend("aq_prio.v"); @18

// &ModuleBeg; @20
module aq_lsu_pfb_top(
  cp0_lsu_dcache_en,
  cp0_lsu_dcache_pref_dist,
  cp0_lsu_dcache_pref_en,
  cp0_lsu_dcache_wb,
  cp0_lsu_icg_en,
  cp0_lsu_sync_req,
  cpurst_b,
  dc_pfb_dca_vld,
  dc_pfb_hit_idx,
  dc_pfb_ld_chk_pa,
  dc_pfb_ld_chk_virt_idx,
  dc_pfb_ld_init_pa,
  dc_pfb_ld_init_virt_idx,
  dc_pfb_ld_mask,
  dc_pfb_ld_miss,
  dc_pfb_ld_pc,
  dc_pfb_ld_vld,
  dc_pfb_ld_vld_gate,
  dc_pfb_priv_mode,
  forever_cpuclk,
  icc_xx_sync_req,
  ifu_lsu_warm_up,
  lfb_pfb_cache_hit,
  lfb_pfb_cache_miss,
  lfb_pfb_grant,
  lfb_pfb_hit_idx,
  pad_yy_icg_scan_en,
  pfb_lfb_id,
  pfb_lfb_pa,
  pfb_lfb_priv_mode,
  pfb_lfb_req,
  pfb_lfb_req_gate,
  pfb_lfb_virt_idx,
  pfb_lfb_wb,
  pfb_xx_pa,
  stb_pfb_hit_idx,
  vb_pfb_hit_idx
);

// &Ports; @21
input           cp0_lsu_dcache_en;       
input   [1 :0]  cp0_lsu_dcache_pref_dist; 
input           cp0_lsu_dcache_pref_en;  
input           cp0_lsu_dcache_wb;       
input           cp0_lsu_icg_en;          
input           cp0_lsu_sync_req;        
input           cpurst_b;                
input           dc_pfb_dca_vld;          
input           dc_pfb_hit_idx;          
input   [39:0]  dc_pfb_ld_chk_pa;        
input   [1 :0]  dc_pfb_ld_chk_virt_idx;  
input   [39:0]  dc_pfb_ld_init_pa;       
input   [1 :0]  dc_pfb_ld_init_virt_idx; 
input           dc_pfb_ld_mask;          
input           dc_pfb_ld_miss;          
input   [15:0]  dc_pfb_ld_pc;            
input           dc_pfb_ld_vld;           
input           dc_pfb_ld_vld_gate;      
input   [1 :0]  dc_pfb_priv_mode;        
input           forever_cpuclk;          
input           icc_xx_sync_req;         
input           ifu_lsu_warm_up;         
input   [4 :0]  lfb_pfb_cache_hit;       
input   [4 :0]  lfb_pfb_cache_miss;      
input           lfb_pfb_grant;           
input           lfb_pfb_hit_idx;         
input           pad_yy_icg_scan_en;      
input           stb_pfb_hit_idx;         
input           vb_pfb_hit_idx;          
output  [4 :0]  pfb_lfb_id;              
output  [39:0]  pfb_lfb_pa;              
output  [1 :0]  pfb_lfb_priv_mode;       
output          pfb_lfb_req;             
output          pfb_lfb_req_gate;        
output  [1 :0]  pfb_lfb_virt_idx;        
output          pfb_lfb_wb;              
output  [39:0]  pfb_xx_pa;               

// &Regs; @22
reg             pfb_ld_miss_ff;          
reg             pfb_ld_req_mask;         
reg     [3 :0]  ppfb_create_ptr;         
reg     [3 :0]  ppfb_evict_ptr;          

// &Wires; @23
wire            cp0_lsu_dcache_en;       
wire    [1 :0]  cp0_lsu_dcache_pref_dist; 
wire            cp0_lsu_dcache_pref_en;  
wire            cp0_lsu_dcache_wb;       
wire            cp0_lsu_icg_en;          
wire            cp0_lsu_sync_req;        
wire            cpurst_b;                
wire            create_clk_en;           
wire            dc_hit_idx;              
wire    [4 :0]  dc_hit_pfb_pc;           
wire    [3 :0]  dc_hit_ppfb_pc;          
wire            dc_pfb_dca_vld;          
wire            dc_pfb_hit_idx;          
wire    [39:0]  dc_pfb_ld_chk_pa;        
wire    [1 :0]  dc_pfb_ld_chk_virt_idx;  
wire    [39:0]  dc_pfb_ld_init_pa;       
wire    [1 :0]  dc_pfb_ld_init_virt_idx; 
wire            dc_pfb_ld_mask;          
wire            dc_pfb_ld_miss;          
wire    [15:0]  dc_pfb_ld_pc;            
wire            dc_pfb_ld_vld;           
wire            dc_pfb_ld_vld_gate;      
wire    [1 :0]  dc_pfb_priv_mode;        
wire            forever_cpuclk;          
wire            gpfb_create_en;          
wire            gpfb_create_en_dp;       
wire            gpfb_create_en_gate;     
wire            gpfb_entry_in_pf;        
wire            gpfb_grant;              
wire            gpfb_req_mask;           
wire            icc_xx_sync_req;         
wire            ifu_lsu_warm_up;         
wire    [4 :0]  lfb_cache_hit;           
wire    [4 :0]  lfb_cache_miss;          
wire            lfb_grant;               
wire            lfb_hit_idx;             
wire    [4 :0]  lfb_pfb_cache_hit;       
wire    [4 :0]  lfb_pfb_cache_miss;      
wire            lfb_pfb_grant;           
wire            lfb_pfb_hit_idx;         
wire            pad_yy_icg_scan_en;      
wire    [38:0]  pfb_arbus;               
wire            pfb_create_clk;          
wire    [4 :0]  pfb_create_en;           
wire    [4 :0]  pfb_create_en_dp;        
wire    [4 :0]  pfb_create_en_gate;      
wire            pfb_dca_vld;             
wire    [38:0]  pfb_entry0_arbus;        
wire    [38:0]  pfb_entry1_arbus;        
wire    [38:0]  pfb_entry2_arbus;        
wire    [38:0]  pfb_entry3_arbus;        
wire    [38:0]  pfb_entry4_arbus;        
wire    [4 :0]  pfb_entry_evict;         
wire    [4 :0]  pfb_entry_in_pf;         
wire    [4 :0]  pfb_entry_req;           
wire    [4 :0]  pfb_entry_req_dp;        
wire    [4 :0]  pfb_entry_vld;           
wire    [4 :0]  pfb_grant;               
wire    [39:0]  pfb_ld_chk_pa;           
wire    [1 :0]  pfb_ld_chk_virt_idx;     
wire    [39:0]  pfb_ld_init_pa;          
wire    [1 :0]  pfb_ld_init_virt_idx;    
wire            pfb_ld_mask;             
wire            pfb_ld_miss;             
wire            pfb_ld_miss_clr;         
wire            pfb_ld_miss_save;        
wire    [15:0]  pfb_ld_pc;               
wire            pfb_ld_req;              
wire            pfb_ld_req_miss;         
wire            pfb_ld_req_vld;          
wire            pfb_ld_req_vld_gate;     
wire            pfb_ld_vld;              
wire            pfb_ld_vld_gate;         
wire    [4 :0]  pfb_lfb_id;              
wire    [39:0]  pfb_lfb_pa;              
wire    [1 :0]  pfb_lfb_priv_mode;       
wire            pfb_lfb_req;             
wire            pfb_lfb_req_gate;        
wire    [1 :0]  pfb_lfb_virt_idx;        
wire            pfb_lfb_wb;              
wire    [1 :0]  pfb_priv_mode;           
wire            pfb_req_grant;           
wire    [4 :0]  pfb_req_sel;             
wire    [4 :0]  pfb_req_valid;           
wire    [4 :0]  pfb_req_valid_dp;        
wire    [39:0]  pfb_xx_pa;               
wire    [3 :0]  ppfb_create_en;          
wire    [3 :0]  ppfb_create_en_dp;       
wire    [3 :0]  ppfb_create_en_gate;     
wire    [3 :0]  ppfb_create_sel;         
wire            ppfb_create_vld;         
wire            ppfb_create_vld_dp;      
wire            ppfb_create_vld_gate;    
wire    [3 :0]  ppfb_entry_evict;        
wire    [3 :0]  ppfb_entry_in_pf;        
wire    [3 :0]  ppfb_entry_vld;          
wire    [3 :0]  ppfb_grant;              
wire            ppfb_hit_pc;             
wire            ppfb_req_mask;           
wire            prio_clk;                
wire            prio_clk_en;             
wire            stb_hit_idx;             
wire            stb_pfb_hit_idx;         
wire            vb_hit_idx;              
wire            vb_pfb_hit_idx;          
wire    [39:0]  xx_create_chk_pa;        
wire    [39:0]  xx_create_init_pa;       
wire            xx_create_ld_miss;       
wire            xx_create_ld_req;        
wire    [14:0]  xx_create_pc;            
wire    [1 :0]  xx_create_priv_mode;     
wire    [1 :0]  xx_create_virt_idx;      
wire            xx_flush;                


parameter DEPTH = 4;
parameter PADDR = 40;

//==========================================================
//      input interface
//==========================================================
//---------------from dc--------------------------
// &Force("bus","dc_pfb_ld_pc",15,0); @32
assign pfb_ld_vld                = dc_pfb_ld_vld;
assign pfb_ld_vld_gate           = dc_pfb_ld_vld_gate;
assign pfb_ld_mask               = dc_pfb_ld_mask;
assign pfb_ld_miss               = dc_pfb_ld_miss;
assign pfb_ld_chk_pa[PADDR-1:0]  = dc_pfb_ld_chk_pa[PADDR-1:0];
assign pfb_ld_chk_virt_idx[1:0]  = dc_pfb_ld_chk_virt_idx[1:0];
assign pfb_ld_init_pa[PADDR-1:0] = dc_pfb_ld_init_pa[PADDR-1:0];
assign pfb_ld_init_virt_idx[1:0] = dc_pfb_ld_init_virt_idx[1:0];
assign pfb_dca_vld               = dc_pfb_dca_vld;
assign pfb_ld_pc[15:0]           = dc_pfb_ld_pc[15:0];
assign pfb_priv_mode[1:0]        = dc_pfb_priv_mode[1:0];
assign dc_hit_idx                = dc_pfb_hit_idx;
//---------------from lfb--------------------------
assign lfb_grant           = lfb_pfb_grant;
assign lfb_hit_idx         = lfb_pfb_hit_idx;
assign lfb_cache_hit[4:0]  = lfb_pfb_cache_hit[4:0];
assign lfb_cache_miss[4:0] = lfb_pfb_cache_miss[4:0];
//---------------from others-----------------------
assign stb_hit_idx = stb_pfb_hit_idx;
assign vb_hit_idx  = vb_pfb_hit_idx;

//==========================================================
//      pfb create control
//==========================================================
//---------------create mask merge-----------------------
//for pfb create mask inst,cache miss should be recorded
assign pfb_ld_miss_save = pfb_ld_vld & pfb_ld_miss & cp0_lsu_dcache_pref_en & pfb_ld_mask;

always@(posedge pfb_create_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    pfb_ld_miss_ff       <= 1'b0;
  else if (pfb_ld_miss_save) 
    pfb_ld_miss_ff       <= 1'b1;
  else if (pfb_ld_miss_clr | xx_flush) 
    pfb_ld_miss_ff       <= 1'b0;
end

//when pfb has a new inst with no mask effective,cache miss should be carried
assign pfb_ld_miss_clr = pfb_ld_req_vld;

//for performance,when ld_miss_ff valid,next no mask inst will init quickly
//init pfb without dc replay,then mask following redundant req
assign pfb_ld_req = pfb_ld_vld | pfb_ld_vld_gate & pfb_ld_miss_ff;

always@(posedge pfb_create_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    pfb_ld_req_mask <= 1'b0;
  else if (pfb_ld_vld && cp0_lsu_dcache_pref_en)
    pfb_ld_req_mask <= 1'b0;
  else if (pfb_ld_req_vld) 
    pfb_ld_req_mask <= 1'b1;
end

//new pfb create signal with cache miss merge
assign pfb_ld_req_vld      = pfb_ld_req & !pfb_ld_req_mask & !pfb_ld_mask & cp0_lsu_dcache_pref_en;
assign pfb_ld_req_vld_gate = pfb_ld_vld_gate & !pfb_ld_mask & cp0_lsu_dcache_pref_en;
assign pfb_ld_req_miss     = pfb_ld_miss | pfb_ld_miss_ff;

//---------------create ctrl------------------------------
assign gpfb_entry_in_pf            = pfb_entry_in_pf[0];
assign ppfb_entry_in_pf[DEPTH-1:0] = pfb_entry_in_pf[DEPTH:1];
assign dc_hit_ppfb_pc[DEPTH-1:0]   = dc_hit_pfb_pc[DEPTH:1];
assign ppfb_entry_vld[DEPTH-1:0]   = pfb_entry_vld[DEPTH:1];
assign ppfb_entry_evict[DEPTH-1:0] = pfb_entry_evict[DEPTH:1];

assign ppfb_hit_pc = |dc_hit_ppfb_pc[DEPTH-1:0];

assign ppfb_req_mask        = gpfb_entry_in_pf;
assign ppfb_create_vld      = pfb_ld_req_vld      & pfb_ld_req_miss & !ppfb_req_mask & !ppfb_hit_pc;
assign ppfb_create_vld_dp   = pfb_ld_req_vld_gate & pfb_ld_req_miss & !ppfb_req_mask & !ppfb_hit_pc;
assign ppfb_create_vld_gate = pfb_ld_req_vld_gate & !ppfb_req_mask & !ppfb_hit_pc;

assign gpfb_req_mask        = |(dc_hit_ppfb_pc[DEPTH-1:0] & ppfb_entry_in_pf[DEPTH-1:0]);
assign gpfb_create_en       = pfb_ld_req_vld      & pfb_ld_req_miss & !gpfb_req_mask;
assign gpfb_create_en_dp    = pfb_ld_req_vld_gate & pfb_ld_req_miss & !gpfb_req_mask;
assign gpfb_create_en_gate  = pfb_ld_req_vld_gate & !gpfb_req_mask;

// &CombBeg; @112
always @( ppfb_entry_vld[3:0])
begin
  casez(ppfb_entry_vld[DEPTH-1:0])
  4'b???0 : ppfb_create_ptr[DEPTH-1:0] = 4'b0001;
  4'b??01 : ppfb_create_ptr[DEPTH-1:0] = 4'b0010;
  4'b?011 : ppfb_create_ptr[DEPTH-1:0] = 4'b0100;
  4'b0111 : ppfb_create_ptr[DEPTH-1:0] = 4'b1000;
  default : ppfb_create_ptr[DEPTH-1:0] = 4'b0000;
  endcase
// &CombEnd; @120
end

// &CombBeg; @122
always @( ppfb_entry_evict[3:0])
begin
  casez(ppfb_entry_evict[DEPTH-1:0])
  4'b???1 : ppfb_evict_ptr[DEPTH-1:0] = 4'b0001;
  4'b??10 : ppfb_evict_ptr[DEPTH-1:0] = 4'b0010;
  4'b?100 : ppfb_evict_ptr[DEPTH-1:0] = 4'b0100;
  4'b1000 : ppfb_evict_ptr[DEPTH-1:0] = 4'b1000;
  default : ppfb_evict_ptr[DEPTH-1:0] = 4'b0000;
  endcase
// &CombEnd; @130
end

assign ppfb_create_sel[DEPTH-1:0] = &ppfb_entry_vld[DEPTH-1:0]
                                    ? ppfb_evict_ptr[DEPTH-1:0]
                                    : ppfb_create_ptr[DEPTH-1:0]; 

assign ppfb_create_en[DEPTH-1:0]      = {DEPTH{ppfb_create_vld}} & ppfb_create_sel[DEPTH-1:0];
assign ppfb_create_en_dp[DEPTH-1:0]   = {DEPTH{ppfb_create_vld_dp}} & ppfb_create_sel[DEPTH-1:0];
assign ppfb_create_en_gate[DEPTH-1:0] = {DEPTH{ppfb_create_vld_gate}} & ppfb_create_sel[DEPTH-1:0];

//==========================================================
//      pfb entry create signal
//==========================================================
assign xx_create_ld_req             = pfb_ld_req_vld;
assign xx_create_ld_miss            = pfb_ld_req_miss;
assign xx_create_pc[14:0]           = pfb_ld_pc[15:1];
assign xx_create_chk_pa[PADDR-1:0]  = pfb_ld_chk_pa[PADDR-1:0];
assign xx_create_init_pa[PADDR-1:0] = pfb_ld_miss_ff
                                      ? pfb_ld_chk_pa[PADDR-1:0] 
                                      : pfb_ld_init_pa[PADDR-1:0];
assign xx_create_virt_idx[1:0]      = pfb_ld_miss_ff
                                      ? pfb_ld_chk_virt_idx[1:0]
                                      : pfb_ld_init_virt_idx[1:0];
assign xx_create_priv_mode[1:0]     = pfb_priv_mode[1:0];

assign pfb_create_en[DEPTH:0]      = {ppfb_create_en[DEPTH-1:0],     gpfb_create_en};
assign pfb_create_en_dp[DEPTH:0]   = {ppfb_create_en_dp[DEPTH-1:0],  gpfb_create_en_dp};
assign pfb_create_en_gate[DEPTH:0] = {ppfb_create_en_gate[DEPTH-1:0],gpfb_create_en_gate};
//==========================================================
//      other control signal 
//==========================================================
assign xx_flush = !cp0_lsu_dcache_pref_en | 
                  !cp0_lsu_dcache_en | 
                   cp0_lsu_sync_req | 
                   pfb_dca_vld | 
                   icc_xx_sync_req;

//==========================================================
//      pfb bus req
//==========================================================
parameter WB        = 0;
parameter VIRT_0    = 1;
parameter VIRT_1    = 2;
parameter PRIV_0    = 3;
parameter PRIV_1    = 4;
parameter ADDR_0    = 5;
parameter ADDR_33   = 38;
parameter PFB_WIDTH = 39;

// &Force("nonport", "pfb_req_sel"); @179
// &Force("nonport", "prio_clk"); @180

assign pfb_req_valid[4:0]    = pfb_entry_req[DEPTH:0];
assign pfb_req_valid_dp[4:0] = pfb_entry_req_dp[DEPTH:0];

aq_prio #(.NUM(5)) x_aq_lsu_pfb_prio(
  .clk                 (prio_clk          ),
  .rst_b               (cpurst_b          ),
  .valid               (pfb_req_valid_dp  ),
  .clr                 (lfb_grant     ),
  .sel                 (pfb_req_sel       )
);

assign pfb_req_grant = lfb_grant &
                      !lfb_hit_idx & !stb_hit_idx & !dc_hit_idx & !vb_hit_idx;

assign gpfb_grant            = pfb_req_grant & pfb_req_sel[0];
assign ppfb_grant[DEPTH-1:0] = {DEPTH{pfb_req_grant}} & pfb_req_sel[DEPTH:1];
assign pfb_grant[DEPTH:0]    = {ppfb_grant[DEPTH-1:0],gpfb_grant};

assign pfb_arbus[PFB_WIDTH-1:0] = 
       {PFB_WIDTH{pfb_req_sel[0]}} & pfb_entry0_arbus[PFB_WIDTH-1:0] |
       {PFB_WIDTH{pfb_req_sel[1]}} & pfb_entry1_arbus[PFB_WIDTH-1:0] |
       {PFB_WIDTH{pfb_req_sel[2]}} & pfb_entry2_arbus[PFB_WIDTH-1:0] |
       {PFB_WIDTH{pfb_req_sel[3]}} & pfb_entry3_arbus[PFB_WIDTH-1:0] |
       {PFB_WIDTH{pfb_req_sel[4]}} & pfb_entry4_arbus[PFB_WIDTH-1:0];


//==========================================================
//      output interface
//==========================================================
//------------------for lfb---------------------------
assign pfb_lfb_req            = (|(pfb_req_sel[4:0] & pfb_req_valid[4:0])) & !xx_flush;
assign pfb_lfb_req_gate       = (|pfb_req_sel[4:0]) & !xx_flush;

assign pfb_lfb_pa[PADDR-1:0]  = {pfb_arbus[ADDR_33:ADDR_0], 6'b0};
assign pfb_lfb_priv_mode[1:0] = pfb_arbus[PRIV_1:PRIV_0];
assign pfb_lfb_virt_idx[1:0]  = pfb_arbus[VIRT_1:VIRT_0]; 
assign pfb_lfb_wb             = pfb_arbus[WB];
assign pfb_lfb_id[4:0]        = pfb_req_sel[4:0];

//------------------for others---------------------------
assign pfb_xx_pa[PADDR-1:0] = {pfb_arbus[ADDR_33:ADDR_0], 6'b0};

//==========================================================
//      ICG
//==========================================================
assign prio_clk_en = lfb_grant & (|pfb_req_valid_dp[DEPTH:0]);
// &Instance("gated_clk_cell", "x_aq_lsu_pfb_prio_gated_clk"); @228
gated_clk_cell  x_aq_lsu_pfb_prio_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (prio_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (prio_clk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @229
//          .external_en (1'b0), @230
//          .global_en   (1'b1), @231
//          .module_en   (cp0_lsu_icg_en), @232
//          .local_en    (prio_clk_en), @233
//          .clk_out     (prio_clk)); @234

assign create_clk_en = pfb_ld_vld_gate & cp0_lsu_dcache_pref_en | pfb_ld_miss_ff;
// &Instance("gated_clk_cell", "x_aq_lsu_pfb_create_gated_clk"); @237
gated_clk_cell  x_aq_lsu_pfb_create_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pfb_create_clk    ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (create_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @238
//          .external_en (1'b0), @239
//          .global_en   (1'b1), @240
//          .module_en   (cp0_lsu_icg_en), @241
//          .local_en    (create_clk_en), @242
//          .clk_out     (pfb_create_clk)); @243
//==========================================================
//      Instance
//==========================================================
// &ConnRule(s/_x$/[0]/); @247
// &ConnRule(s/entryx/entry0/); @248
// &Instance("aq_lsu_pfb","x_aq_lsu_gpfb"); @249
aq_lsu_pfb  x_aq_lsu_gpfb (
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_pfb_pc_x          (dc_hit_pfb_pc[0]        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_cache_hit_x          (lfb_cache_hit[0]        ),
  .lfb_cache_miss_x         (lfb_cache_miss[0]       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_create_en_dp_x       (pfb_create_en_dp[0]     ),
  .pfb_create_en_gate_x     (pfb_create_en_gate[0]   ),
  .pfb_create_en_x          (pfb_create_en[0]        ),
  .pfb_entry_evict_x        (pfb_entry_evict[0]      ),
  .pfb_entry_in_pf_x        (pfb_entry_in_pf[0]      ),
  .pfb_entry_req_dp_x       (pfb_entry_req_dp[0]     ),
  .pfb_entry_req_x          (pfb_entry_req[0]        ),
  .pfb_entry_vld_x          (pfb_entry_vld[0]        ),
  .pfb_entryx_arbus         (pfb_entry0_arbus        ),
  .pfb_flush_by_gpfb        (1'b0                    ),
  .pfb_grant_x              (pfb_grant[0]            ),
  .pfb_hit_cnt_max          (4'hf                    ),
  .pfb_pc_mode              (1'b0                    ),
  .xx_create_chk_pa         (xx_create_chk_pa        ),
  .xx_create_init_pa        (xx_create_init_pa       ),
  .xx_create_ld_miss        (xx_create_ld_miss       ),
  .xx_create_ld_req         (xx_create_ld_req        ),
  .xx_create_pc             (xx_create_pc            ),
  .xx_create_priv_mode      (xx_create_priv_mode     ),
  .xx_create_virt_idx       (xx_create_virt_idx      ),
  .xx_flush                 (xx_flush                )
);

// &Connect(.pfb_pc_mode (1'b0)); @250
// &Connect(.pfb_flush_by_gpfb (1'b0)); @251
// &Connect(.pfb_hit_cnt_max (4'hf)); @252

// &ConnRule(s/_x$/[1]/); @254
// &ConnRule(s/entryx/entry1/); @255
// &Instance("aq_lsu_pfb","x_aq_lsu_ppfb_0"); @256
aq_lsu_pfb  x_aq_lsu_ppfb_0 (
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_pfb_pc_x          (dc_hit_pfb_pc[1]        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_cache_hit_x          (lfb_cache_hit[1]        ),
  .lfb_cache_miss_x         (lfb_cache_miss[1]       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_create_en_dp_x       (pfb_create_en_dp[1]     ),
  .pfb_create_en_gate_x     (pfb_create_en_gate[1]   ),
  .pfb_create_en_x          (pfb_create_en[1]        ),
  .pfb_entry_evict_x        (pfb_entry_evict[1]      ),
  .pfb_entry_in_pf_x        (pfb_entry_in_pf[1]      ),
  .pfb_entry_req_dp_x       (pfb_entry_req_dp[1]     ),
  .pfb_entry_req_x          (pfb_entry_req[1]        ),
  .pfb_entry_vld_x          (pfb_entry_vld[1]        ),
  .pfb_entryx_arbus         (pfb_entry1_arbus        ),
  .pfb_flush_by_gpfb        (gpfb_entry_in_pf        ),
  .pfb_grant_x              (pfb_grant[1]            ),
  .pfb_hit_cnt_max          (4'h3                    ),
  .pfb_pc_mode              (1'b1                    ),
  .xx_create_chk_pa         (xx_create_chk_pa        ),
  .xx_create_init_pa        (xx_create_init_pa       ),
  .xx_create_ld_miss        (xx_create_ld_miss       ),
  .xx_create_ld_req         (xx_create_ld_req        ),
  .xx_create_pc             (xx_create_pc            ),
  .xx_create_priv_mode      (xx_create_priv_mode     ),
  .xx_create_virt_idx       (xx_create_virt_idx      ),
  .xx_flush                 (xx_flush                )
);

// &Connect(.pfb_pc_mode (1'b1)); @257
// &Connect(.pfb_flush_by_gpfb (gpfb_entry_in_pf)); @258
// &Connect(.pfb_hit_cnt_max (4'h3)); @259

// &ConnRule(s/_x$/[2]/); @261
// &ConnRule(s/entryx/entry2/); @262
// &Instance("aq_lsu_pfb","x_aq_lsu_ppfb_1"); @263
aq_lsu_pfb  x_aq_lsu_ppfb_1 (
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_pfb_pc_x          (dc_hit_pfb_pc[2]        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_cache_hit_x          (lfb_cache_hit[2]        ),
  .lfb_cache_miss_x         (lfb_cache_miss[2]       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_create_en_dp_x       (pfb_create_en_dp[2]     ),
  .pfb_create_en_gate_x     (pfb_create_en_gate[2]   ),
  .pfb_create_en_x          (pfb_create_en[2]        ),
  .pfb_entry_evict_x        (pfb_entry_evict[2]      ),
  .pfb_entry_in_pf_x        (pfb_entry_in_pf[2]      ),
  .pfb_entry_req_dp_x       (pfb_entry_req_dp[2]     ),
  .pfb_entry_req_x          (pfb_entry_req[2]        ),
  .pfb_entry_vld_x          (pfb_entry_vld[2]        ),
  .pfb_entryx_arbus         (pfb_entry2_arbus        ),
  .pfb_flush_by_gpfb        (gpfb_entry_in_pf        ),
  .pfb_grant_x              (pfb_grant[2]            ),
  .pfb_hit_cnt_max          (4'h3                    ),
  .pfb_pc_mode              (1'b1                    ),
  .xx_create_chk_pa         (xx_create_chk_pa        ),
  .xx_create_init_pa        (xx_create_init_pa       ),
  .xx_create_ld_miss        (xx_create_ld_miss       ),
  .xx_create_ld_req         (xx_create_ld_req        ),
  .xx_create_pc             (xx_create_pc            ),
  .xx_create_priv_mode      (xx_create_priv_mode     ),
  .xx_create_virt_idx       (xx_create_virt_idx      ),
  .xx_flush                 (xx_flush                )
);

// &Connect(.pfb_pc_mode (1'b1)); @264
// &Connect(.pfb_flush_by_gpfb (gpfb_entry_in_pf)); @265
// &Connect(.pfb_hit_cnt_max (4'h3)); @266

// &ConnRule(s/_x$/[3]/); @268
// &ConnRule(s/entryx/entry3/); @269
// &Instance("aq_lsu_pfb","x_aq_lsu_ppfb_2"); @270
aq_lsu_pfb  x_aq_lsu_ppfb_2 (
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_pfb_pc_x          (dc_hit_pfb_pc[3]        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_cache_hit_x          (lfb_cache_hit[3]        ),
  .lfb_cache_miss_x         (lfb_cache_miss[3]       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_create_en_dp_x       (pfb_create_en_dp[3]     ),
  .pfb_create_en_gate_x     (pfb_create_en_gate[3]   ),
  .pfb_create_en_x          (pfb_create_en[3]        ),
  .pfb_entry_evict_x        (pfb_entry_evict[3]      ),
  .pfb_entry_in_pf_x        (pfb_entry_in_pf[3]      ),
  .pfb_entry_req_dp_x       (pfb_entry_req_dp[3]     ),
  .pfb_entry_req_x          (pfb_entry_req[3]        ),
  .pfb_entry_vld_x          (pfb_entry_vld[3]        ),
  .pfb_entryx_arbus         (pfb_entry3_arbus        ),
  .pfb_flush_by_gpfb        (gpfb_entry_in_pf        ),
  .pfb_grant_x              (pfb_grant[3]            ),
  .pfb_hit_cnt_max          (4'h3                    ),
  .pfb_pc_mode              (1'b1                    ),
  .xx_create_chk_pa         (xx_create_chk_pa        ),
  .xx_create_init_pa        (xx_create_init_pa       ),
  .xx_create_ld_miss        (xx_create_ld_miss       ),
  .xx_create_ld_req         (xx_create_ld_req        ),
  .xx_create_pc             (xx_create_pc            ),
  .xx_create_priv_mode      (xx_create_priv_mode     ),
  .xx_create_virt_idx       (xx_create_virt_idx      ),
  .xx_flush                 (xx_flush                )
);

// &Connect(.pfb_pc_mode (1'b1)); @271
// &Connect(.pfb_flush_by_gpfb (gpfb_entry_in_pf)); @272
// &Connect(.pfb_hit_cnt_max (4'h3)); @273

// &ConnRule(s/_x$/[4]/); @275
// &ConnRule(s/entryx/entry4/); @276
// &Instance("aq_lsu_pfb","x_aq_lsu_ppfb_3"); @277
aq_lsu_pfb  x_aq_lsu_ppfb_3 (
  .cp0_lsu_dcache_pref_dist (cp0_lsu_dcache_pref_dist),
  .cp0_lsu_dcache_wb        (cp0_lsu_dcache_wb       ),
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .dc_hit_pfb_pc_x          (dc_hit_pfb_pc[4]        ),
  .forever_cpuclk           (forever_cpuclk          ),
  .ifu_lsu_warm_up          (ifu_lsu_warm_up         ),
  .lfb_cache_hit_x          (lfb_cache_hit[4]        ),
  .lfb_cache_miss_x         (lfb_cache_miss[4]       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pfb_create_en_dp_x       (pfb_create_en_dp[4]     ),
  .pfb_create_en_gate_x     (pfb_create_en_gate[4]   ),
  .pfb_create_en_x          (pfb_create_en[4]        ),
  .pfb_entry_evict_x        (pfb_entry_evict[4]      ),
  .pfb_entry_in_pf_x        (pfb_entry_in_pf[4]      ),
  .pfb_entry_req_dp_x       (pfb_entry_req_dp[4]     ),
  .pfb_entry_req_x          (pfb_entry_req[4]        ),
  .pfb_entry_vld_x          (pfb_entry_vld[4]        ),
  .pfb_entryx_arbus         (pfb_entry4_arbus        ),
  .pfb_flush_by_gpfb        (gpfb_entry_in_pf        ),
  .pfb_grant_x              (pfb_grant[4]            ),
  .pfb_hit_cnt_max          (4'h3                    ),
  .pfb_pc_mode              (1'b1                    ),
  .xx_create_chk_pa         (xx_create_chk_pa        ),
  .xx_create_init_pa        (xx_create_init_pa       ),
  .xx_create_ld_miss        (xx_create_ld_miss       ),
  .xx_create_ld_req         (xx_create_ld_req        ),
  .xx_create_pc             (xx_create_pc            ),
  .xx_create_priv_mode      (xx_create_priv_mode     ),
  .xx_create_virt_idx       (xx_create_virt_idx      ),
  .xx_flush                 (xx_flush                )
);

// &Connect(.pfb_pc_mode (1'b1)); @278
// &Connect(.pfb_flush_by_gpfb (gpfb_entry_in_pf)); @279
// &Connect(.pfb_hit_cnt_max (4'h3)); @280


//==========================================================
//      ASSERTION
//==========================================================

// &Force("nonport","icc_req_vld"); @288
// &ModuleEnd; @296
endmodule


