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

// &ModuleBeg; @19
module aq_lsu_pfb(
  cp0_lsu_dcache_pref_dist,
  cp0_lsu_dcache_wb,
  cp0_lsu_icg_en,
  cpurst_b,
  dc_hit_pfb_pc_x,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lfb_cache_hit_x,
  lfb_cache_miss_x,
  pad_yy_icg_scan_en,
  pfb_create_en_dp_x,
  pfb_create_en_gate_x,
  pfb_create_en_x,
  pfb_entry_evict_x,
  pfb_entry_in_pf_x,
  pfb_entry_req_dp_x,
  pfb_entry_req_x,
  pfb_entry_vld_x,
  pfb_entryx_arbus,
  pfb_flush_by_gpfb,
  pfb_grant_x,
  pfb_hit_cnt_max,
  pfb_pc_mode,
  xx_create_chk_pa,
  xx_create_init_pa,
  xx_create_ld_miss,
  xx_create_ld_req,
  xx_create_pc,
  xx_create_priv_mode,
  xx_create_virt_idx,
  xx_flush
);

// &Ports; @20
input   [1 :0]  cp0_lsu_dcache_pref_dist; 
input           cp0_lsu_dcache_wb;       
input           cp0_lsu_icg_en;          
input           cpurst_b;                
input           forever_cpuclk;          
input           ifu_lsu_warm_up;         
input           lfb_cache_hit_x;         
input           lfb_cache_miss_x;        
input           pad_yy_icg_scan_en;      
input           pfb_create_en_dp_x;      
input           pfb_create_en_gate_x;    
input           pfb_create_en_x;         
input           pfb_flush_by_gpfb;       
input           pfb_grant_x;             
input   [3 :0]  pfb_hit_cnt_max;         
input           pfb_pc_mode;             
input   [39:0]  xx_create_chk_pa;        
input   [39:0]  xx_create_init_pa;       
input           xx_create_ld_miss;       
input           xx_create_ld_req;        
input   [14:0]  xx_create_pc;            
input   [1 :0]  xx_create_priv_mode;     
input   [1 :0]  xx_create_virt_idx;      
input           xx_flush;                
output          dc_hit_pfb_pc_x;         
output          pfb_entry_evict_x;       
output          pfb_entry_in_pf_x;       
output          pfb_entry_req_dp_x;      
output          pfb_entry_req_x;         
output          pfb_entry_vld_x;         
output  [38:0]  pfb_entryx_arbus;        

// &Regs; @21
reg     [2 :0]  confidence;              
reg     [3 :0]  hit_cnt;                 
reg             pf_cache_hit;            
reg     [3 :0]  pfb_cur_state;           
reg     [39:0]  pfb_ld_addr;             
reg             pfb_ld_dcache_wb;        
reg     [14:0]  pfb_ld_pc;               
reg     [1 :0]  pfb_ld_priv_mode;        
reg     [1 :0]  pfb_ld_virt_idx;         
reg     [3 :0]  pfb_next_state;          
reg     [5 :0]  pfb_req_addr_11to6;      
reg     [27:0]  pfb_req_ppn;             
reg     [4 :0]  pfb_req_stride;          
reg     [10:0]  stride_val;              
reg     [5 :0]  time_out_cnt0;           

// &Wires; @22
wire            confidence_close;        
wire    [2 :0]  confidence_dec;          
wire    [2 :0]  confidence_inc;          
wire            confidence_pop;          
wire    [1 :0]  cp0_lsu_dcache_pref_dist; 
wire            cp0_lsu_dcache_wb;       
wire            cp0_lsu_icg_en;          
wire            cpurst_b;                
wire            dc_hit_pfb_pc_x;         
wire    [39:0]  dc_ld_pa;                
wire            dc_ld_pc_hit;            
wire            dc_ld_vld;               
wire            distance_cross_page;     
wire    [3 :0]  distance_sel;            
wire            forever_cpuclk;          
wire            hit_cnt_full;            
wire            ifu_lsu_warm_up;         
wire            ld_addr_update_en;       
wire            lfb_cache_hit_x;         
wire            lfb_cache_miss_x;        
wire            pad_yy_icg_scan_en;      
wire            pf_addr_cross_4k;        
wire            pf_cache_hit_pop;        
wire    [6 :0]  pf_init_addr;            
wire            pf_reach_max_distance;   
wire            pf_start;                
wire            pf_start_gate;           
wire            pfb_create_en_dp;        
wire            pfb_create_en_dp_x;      
wire            pfb_create_en_gate_x;    
wire            pfb_create_en_x;         
wire            pfb_cur_cals;            
wire            pfb_cur_chks;            
wire            pfb_cur_evict;           
wire            pfb_cur_idle;            
wire            pfb_cur_init;            
wire            pfb_cur_req;             
wire            pfb_cur_susp;            
wire            pfb_entry_evict_x;       
wire            pfb_entry_in_pf_x;       
wire            pfb_entry_req_dp_x;      
wire            pfb_entry_req_x;         
wire            pfb_entry_vld_x;         
wire    [38:0]  pfb_entryx_arbus;        
wire            pfb_flush;               
wire            pfb_flush_by_gpfb;       
wire            pfb_fsm_clk;             
wire            pfb_fsm_clk_en;          
wire            pfb_grant_x;             
wire    [3 :0]  pfb_hit_cnt_max;         
wire            pfb_ld_clk;              
wire            pfb_ld_clk_en;           
wire            pfb_next_chks;           
wire            pfb_next_init;           
wire            pfb_next_req;            
wire            pfb_pc_mode;             
wire    [33:0]  pfb_req_addr;            
wire    [6 :0]  pfb_req_addr_next;       
wire            pfb_req_clk;             
wire            pfb_req_clk_en;          
wire    [5 :0]  pfb_req_distance;        
wire    [4 :0]  req_stride;              
wire    [39:0]  stride_cal;              
wire    [7 :0]  stride_ext;              
wire    [8 :0]  stride_ext_dist;         
wire            stride_hit;              
wire            stride_less_line;        
wire            stride_less_than_1k;     
wire    [4 :0]  stride_line;             
wire            time_out0;               
wire    [5 :0]  time_out_cnt0_inc;       
wire            train_addr_cross_4k;     
wire    [39:0]  xx_create_chk_pa;        
wire    [39:0]  xx_create_init_pa;       
wire            xx_create_ld_miss;       
wire            xx_create_ld_req;        
wire    [14:0]  xx_create_pc;            
wire    [1 :0]  xx_create_priv_mode;     
wire    [1 :0]  xx_create_virt_idx;      
wire            xx_flush;                


parameter PADDR = 40;

//==============================================================================
//  PFB FSM
//==============================================================================
parameter PF_IDLE = 4'b0000;
//parameter PF_WFS  = 4'b0001;
//parameter PF_WFF  = 4'b0010;
parameter PF_CALS = 4'b0011;
//parameter PF_UPDT = 4'b0100;
parameter PF_CHKS = 4'b0101;
parameter PF_INIT = 4'b1000;
parameter PF_REQ  = 4'b1001;
parameter PF_SUSP = 4'b1010;
parameter PF_EVICT= 4'b1011;

assign pfb_flush = xx_flush | pfb_flush_by_gpfb |
                   pfb_pc_mode & !pfb_cur_idle & !pfb_cur_state[3] & time_out0;// | pfb_pc_mode & pfb_cur_init & time_out1;

always@(posedge pfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    pfb_cur_state[3:0] <= PF_IDLE;
  else if(pfb_flush)
    pfb_cur_state[3:0] <= PF_IDLE;
  else if(pfb_pc_mode & pfb_cur_state[3] & time_out0)
    pfb_cur_state[3:0] <= PF_EVICT;
  else
    pfb_cur_state[3:0] <= pfb_next_state[3:0];
end

assign pf_start      = pfb_create_en_x;
assign dc_ld_vld     = xx_create_ld_req & (!pfb_pc_mode | dc_ld_pc_hit);


// &CombBeg; @59
always @( pfb_cur_state
       or train_addr_cross_4k
       or pf_reach_max_distance
       or pfb_grant_x
       or pf_start
       or stride_hit
       or confidence_pop
       or xx_create_ld_miss
       or dc_ld_vld
       or stride_less_than_1k
       or distance_cross_page
       or hit_cnt_full
       or pf_addr_cross_4k)
begin
  case(pfb_cur_state)
  PF_IDLE:begin
    if (pf_start)
      pfb_next_state = PF_CALS; 
    else
      pfb_next_state = PF_IDLE;
  end
  PF_CALS: begin
    if (dc_ld_vld & stride_less_than_1k)
      pfb_next_state = PF_CHKS;
    else if (dc_ld_vld)
      pfb_next_state = PF_IDLE;
    else
      pfb_next_state = PF_CALS;
  end
  PF_CHKS: begin
    if (dc_ld_vld) begin
      if (stride_hit & hit_cnt_full)
        pfb_next_state = PF_INIT;
      else if (!stride_hit)
        pfb_next_state = PF_IDLE;
      else
        pfb_next_state = PF_CHKS;
    end
    else 
      pfb_next_state = PF_CHKS;
  end
  PF_INIT: begin
    if (dc_ld_vld & stride_hit & !train_addr_cross_4k & xx_create_ld_miss) 
      pfb_next_state = PF_REQ;
    else if (confidence_pop)
      pfb_next_state = PF_IDLE;
    else
      pfb_next_state = PF_INIT;
  end
  PF_REQ: begin
    if (pf_addr_cross_4k & pfb_grant_x)
      pfb_next_state = PF_INIT;
    else if (pf_reach_max_distance)
      pfb_next_state = PF_SUSP;
    else if (confidence_pop)
      pfb_next_state = PF_IDLE;
    else
      pfb_next_state = PF_REQ;
  end
  PF_SUSP: begin
    if (!pf_reach_max_distance)
      pfb_next_state = PF_REQ;
    else if (confidence_pop | distance_cross_page)
      pfb_next_state = PF_IDLE;
    else
      pfb_next_state = PF_SUSP;
  end
  PF_EVICT: begin
    if (dc_ld_vld) 
      pfb_next_state = PF_INIT;
    else if (pf_start)
      pfb_next_state = PF_CALS;
    else
      pfb_next_state = PF_EVICT;
  end
  default: pfb_next_state = PF_IDLE;
  endcase
// &CombEnd; @123
end

assign pfb_cur_idle       = pfb_cur_state == PF_IDLE;
assign pfb_cur_cals       = pfb_cur_state == PF_CALS;
assign pfb_cur_chks       = pfb_cur_state == PF_CHKS;
assign pfb_cur_init       = pfb_cur_state == PF_INIT;
assign pfb_cur_req        = pfb_cur_state == PF_REQ;
assign pfb_cur_susp       = pfb_cur_state == PF_SUSP;
assign pfb_cur_evict      = pfb_cur_state == PF_EVICT;
assign pfb_next_init      = pfb_next_state == PF_INIT;
assign pfb_next_req       = pfb_next_state == PF_REQ;
assign pfb_next_chks      = pfb_next_state == PF_CHKS;

assign pfb_entry_vld_x    = !pfb_cur_idle;
assign pfb_entry_evict_x  = pfb_cur_evict;
assign pfb_entry_in_pf_x  = pfb_cur_state[3] & !pfb_cur_evict;

//================================================
//  update pfb_ld information
//================================================
assign pfb_create_en_dp  =  (pfb_cur_idle | pfb_cur_evict) & pfb_create_en_dp_x;
assign ld_addr_update_en =  pfb_cur_cals & pfb_next_chks |
                            (pfb_cur_chks | pfb_cur_state[3]) & dc_ld_vld;

always@(posedge pfb_fsm_clk)
begin
  if (pfb_create_en_dp | ld_addr_update_en | ifu_lsu_warm_up)
    pfb_ld_addr[PADDR-1:0] <= xx_create_chk_pa[PADDR-1:0];
end

always@(posedge pfb_fsm_clk)
begin
  if (pfb_create_en_dp | 
      pfb_cur_chks & dc_ld_vld | 
      pfb_cur_init & pfb_next_req | ifu_lsu_warm_up) begin
    pfb_ld_priv_mode[1:0] <= xx_create_priv_mode[1:0];
    pfb_ld_virt_idx[1:0]  <= xx_create_virt_idx[1:0];
    pfb_ld_dcache_wb      <= cp0_lsu_dcache_wb;
  end
end

//================================================
//  update pfb_ld_pc
//================================================

always@(posedge pfb_ld_clk)
begin
  if (pfb_create_en_dp & pfb_pc_mode | ifu_lsu_warm_up)
    pfb_ld_pc[14:0] <= xx_create_pc[14:0];
end

assign dc_ld_pc_hit = pfb_ld_pc[14:0] == xx_create_pc[14:0];

assign dc_hit_pfb_pc_x = dc_ld_pc_hit & !pfb_cur_idle;

//================================================
//  time out cnt
//================================================
always@(posedge pfb_fsm_clk)
begin
  if (pfb_create_en_dp & pfb_pc_mode | ifu_lsu_warm_up)
    time_out_cnt0[5:0] <= 6'b0;
  else if (xx_create_ld_req & !pfb_cur_idle & pfb_pc_mode)
    time_out_cnt0[5:0] <= dc_ld_pc_hit ? 6'b0 : time_out_cnt0_inc[5:0] ;
end

assign time_out_cnt0_inc[5:0] = time_out_cnt0[5:0] + 6'b1;

assign time_out0 = time_out_cnt0[5:0] == 6'b111111;

//always@(posedge pfb_fsm_clk)
//begin
//  if (pfb_create_en_dp_x & pfb_pc_mode | ifu_lsu_warm_up)
//    time_out_cnt1[5:0] <= 6'b0;
//  else if (dc_ld_vld & pfb_cur_init & pfb_pc_mode )
//    time_out_cnt1[5:0] <= pfb_next_req ? 6'b0 : time_out_cnt1_inc[5:0] ;
//end
//
//assign time_out_cnt1_inc[5:0] = time_out_cnt1[5:0] + 6'b1;
//assign time_out1 = time_out_cnt1[5:0] == 6'b111111;

//================================================
//  stride calculation 
//================================================
assign dc_ld_pa[PADDR-1:0]  = pfb_cur_idle ? {PADDR{1'b0}} : xx_create_chk_pa[PADDR-1:0];

assign stride_cal[PADDR-1:0] = dc_ld_pa[PADDR-1:0] - pfb_ld_addr[PADDR-1:0];
assign stride_less_than_1k   = (stride_cal[PADDR-1:10] == 30'b0) & |stride_cal[9:0] |
                               (stride_cal[PADDR-1:10] == {30{1'b1}});

always@(posedge pfb_ld_clk)
begin
  if (pfb_cur_cals & dc_ld_vld & stride_less_than_1k | ifu_lsu_warm_up) 
    stride_val[10:0] <= {stride_cal[PADDR-1], stride_cal[9:0]};
end

//================================================
// check stride 
//================================================
assign stride_hit = stride_less_than_1k & (stride_val[10:0] == {stride_cal[PADDR-1], stride_cal[9:0]});

always@(posedge pfb_ld_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    hit_cnt[3:0] <= 4'b0;
  else if (pfb_create_en_dp)
    hit_cnt[3:0] <= 4'b0;
  else if (pfb_cur_chks & dc_ld_vld & stride_hit) 
    hit_cnt[3:0] <= hit_cnt[3:0] + 4'h1;
end

assign hit_cnt_full = (hit_cnt[3:0] == pfb_hit_cnt_max[3:0]);

//================================================
// confidence
//================================================
always@(posedge pfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    confidence[2:0] <= 3'b111;
  else if (pfb_cur_chks & pfb_next_init)
    confidence[2:0] <= 3'b111;
  else if ((pfb_cur_init | pfb_cur_req | pfb_cur_susp) & dc_ld_vld & !confidence_close)
    confidence[2:0] <= stride_hit ? confidence_inc[2:0] : confidence_dec[2:0];
end

assign confidence_inc[2:0] = (confidence[2:0] == 3'b111) ? 3'b111 : confidence[2:0] + 3'b1;
assign confidence_dec[2:0] = confidence[2:0] - 3'b1;

assign confidence_close = confidence[2:0] == 3'b0;

assign confidence_pop = dc_ld_vld & confidence_close | pf_cache_hit_pop; 
//================================================
// lfb feedback 
//================================================
//record cache hit here,and it will also pop entry
always@(posedge pfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    pf_cache_hit <= 1'b0;
  else if (pfb_cur_chks & pfb_next_init | lfb_cache_miss_x)
    pf_cache_hit <= 1'b0;
  else if (lfb_cache_hit_x)
    pf_cache_hit <= 1'b1;
end

//two sequential cache hit will pop entry
assign pf_cache_hit_pop = pf_cache_hit & lfb_cache_hit_x;

//================================================
// request stride
//================================================
assign stride_line[4:0] = stride_val[10] ? 5'b11111 : 5'b00001;
assign stride_less_line = stride_val[10] ? (&stride_val[9:6]) : (~|stride_val[9:6]);

assign req_stride[4:0]  = stride_less_line ? stride_line[4:0] : stride_val[10:6];

always@(posedge pfb_req_clk)
begin
  if (pfb_cur_init & pfb_next_req | ifu_lsu_warm_up)
    pfb_req_stride[4:0] <= req_stride[4:0];
end

//================================================
// request address
//================================================
// &Force("bus", "xx_create_init_pa",39,0); @289
assign pf_init_addr[6:0]      = {1'b0,xx_create_init_pa[11:6]} + {{2{req_stride[4]}},req_stride[4:0]};
assign pfb_req_addr_next[6:0] = {1'b0,pfb_req_addr[5:0]} + {{2{pfb_req_stride[4]}},pfb_req_stride[4:0]};

always@(posedge pfb_req_clk)
begin
  if (pfb_cur_init & pfb_next_req | ifu_lsu_warm_up)
    pfb_req_ppn[27:0] <= xx_create_init_pa[39:12];
end

//addr 11:6
always@(posedge pfb_req_clk)
begin
  if (pfb_cur_init & pfb_next_req | ifu_lsu_warm_up)
    pfb_req_addr_11to6[5:0] <= pf_init_addr[5:0];
  else if (pfb_cur_req & pfb_grant_x)
    pfb_req_addr_11to6[5:0] <= pfb_req_addr_next[5:0];
end

assign pfb_req_addr[33:0] = {pfb_req_ppn[27:0],pfb_req_addr_11to6[5:0]};

assign train_addr_cross_4k = pf_init_addr[6];

assign pf_addr_cross_4k = pfb_req_addr_next[6];

//================================================
// reach max distance
//================================================
assign distance_sel[3:0]     = 4'b1 << cp0_lsu_dcache_pref_dist[1:0]; 
assign stride_ext[7:0]       = {{3{pfb_req_stride[4]}}, pfb_req_stride[4:0]};
assign stride_ext_dist[8:0]  = {9{distance_sel[0]}} & {stride_ext[7:0],1'b0} |
                               {9{distance_sel[1]}} & {stride_ext[6:0],2'b0} |
                               {9{distance_sel[2]}} & {stride_ext[5:0],3'b0} |
                               {9{distance_sel[3]}} & {stride_ext[4:0],4'b0};

assign pfb_req_distance[5:0] = pfb_req_addr[5:0] - pfb_ld_addr[11:6];
assign pf_reach_max_distance = pfb_req_stride[4] 
                             ? ({{3{pfb_req_distance[5]}},pfb_req_distance[5:0]} <= stride_ext_dist[8:0])
                             : ({{3{pfb_req_distance[5]}},pfb_req_distance[5:0]} >= stride_ext_dist[8:0]);

assign distance_cross_page = pfb_req_addr[33:6] != pfb_ld_addr[PADDR-1:12];

//==============================================================================
//  request to LFB
//==============================================================================
parameter PFB_WIDTH = 39;

assign pfb_entry_req_x    = pfb_cur_req & pfb_grant_x;

assign pfb_entry_req_dp_x = pfb_cur_req;

assign pfb_entryx_arbus[PFB_WIDTH-1:0] = {pfb_req_addr[33:0],
                                          pfb_ld_priv_mode[1:0],
                                          pfb_ld_virt_idx[1:0],
                                          pfb_ld_dcache_wb};

//==============================================================================
//  ICG
//==============================================================================
assign pf_start_gate  = pfb_create_en_gate_x;

assign pfb_fsm_clk_en = pf_start_gate | !pfb_cur_idle | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_pfb_fsm_gated_clk"); @351
gated_clk_cell  x_aq_lsu_pfb_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pfb_fsm_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (pfb_fsm_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @352
//          .external_en (1'b0), @353
//          .global_en   (1'b1), @354
//          .module_en   (cp0_lsu_icg_en), @355
//          .local_en    (pfb_fsm_clk_en), @356
//          .clk_out     (pfb_fsm_clk)); @357

assign pfb_ld_clk_en = pf_start_gate | pfb_cur_cals | pfb_cur_chks | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_pfb_ld_gated_clk"); @360
gated_clk_cell  x_aq_lsu_pfb_ld_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pfb_ld_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (pfb_ld_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @361
//          .external_en (1'b0), @362
//          .global_en   (1'b1), @363
//          .module_en   (cp0_lsu_icg_en), @364
//          .local_en    (pfb_ld_clk_en), @365
//          .clk_out     (pfb_ld_clk)); @366

assign pfb_req_clk_en = pfb_cur_req | pfb_cur_init | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_pfb_req_gated_clk"); @369
gated_clk_cell  x_aq_lsu_pfb_req_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pfb_req_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (pfb_req_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @370
//          .external_en (1'b0), @371
//          .global_en   (1'b1), @372
//          .module_en   (cp0_lsu_icg_en), @373
//          .local_en    (pfb_req_clk_en), @374
//          .clk_out     (pfb_req_clk)); @375

//==============================================================================
// ASSERTION
//==============================================================================
// &Force("output", "pfb_entry_req_x"); @381
// &Force("nonport","pf_req_not_cross_4k"); @397
// &Force("nonport","pfb_req_vld_last"); @398

// &ModuleEnd; @410
endmodule



