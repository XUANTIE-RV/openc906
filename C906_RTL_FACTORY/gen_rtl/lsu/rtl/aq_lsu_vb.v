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

// &Depend("cpu_cfig.h"); @19

// &ModuleBeg; @21
module aq_lsu_vb(
  biu_lsu_no_op,
  biu_lsu_vb_awready,
  biu_lsu_vb_wready,
  cp0_lsu_icg_en,
  cpurst_b,
  dc_xx_pa,
  forever_cpuclk,
  icc_vb_addr,
  icc_vb_data,
  icc_vb_data_vld,
  icc_vb_req,
  ifu_lsu_warm_up,
  lfb_vb_araddr_5_4,
  lfb_vb_arid,
  lfb_vb_arvalid,
  lfb_vb_rready,
  lsu_biu_vb_awaddr,
  lsu_biu_vb_awburst,
  lsu_biu_vb_awcache,
  lsu_biu_vb_awid,
  lsu_biu_vb_awlen,
  lsu_biu_vb_awprot,
  lsu_biu_vb_awsize,
  lsu_biu_vb_awvalid,
  lsu_biu_vb_wdata,
  lsu_biu_vb_wlast,
  lsu_biu_vb_wstrb,
  lsu_biu_vb_wvalid,
  pad_yy_icg_scan_en,
  pfb_xx_pa,
  rdl_vb_addr,
  rdl_vb_alias,
  rdl_vb_alias_dirty,
  rdl_vb_data,
  rdl_vb_data_vld,
  rdl_vb_ld,
  rdl_vb_ld_id,
  rdl_vb_pf,
  rdl_vb_req,
  vb_dbginfo,
  vb_dc_hit_idx,
  vb_dc_pop_en,
  vb_icc_empty,
  vb_icc_grant,
  vb_lfb_arready,
  vb_lfb_dirty,
  vb_lfb_rdata,
  vb_lfb_rid,
  vb_lfb_rlast,
  vb_lfb_rvalid,
  vb_pfb_hit_idx,
  vb_rdl_grant,
  vb_rdl_ld_alias_hit,
  vb_stb_clr_vld,
  vb_xx_idle
);

// &Ports; @22
input            biu_lsu_no_op;      
input            biu_lsu_vb_awready; 
input            biu_lsu_vb_wready;  
input            cp0_lsu_icg_en;     
input            cpurst_b;           
input   [39 :0]  dc_xx_pa;           
input            forever_cpuclk;     
input   [33 :0]  icc_vb_addr;        
input   [127:0]  icc_vb_data;        
input            icc_vb_data_vld;    
input            icc_vb_req;         
input            ifu_lsu_warm_up;    
input   [1  :0]  lfb_vb_araddr_5_4;  
input   [2  :0]  lfb_vb_arid;        
input            lfb_vb_arvalid;     
input            lfb_vb_rready;      
input            pad_yy_icg_scan_en; 
input   [39 :0]  pfb_xx_pa;          
input   [33 :0]  rdl_vb_addr;        
input            rdl_vb_alias;       
input            rdl_vb_alias_dirty; 
input   [127:0]  rdl_vb_data;        
input            rdl_vb_data_vld;    
input            rdl_vb_ld;          
input   [2  :0]  rdl_vb_ld_id;       
input            rdl_vb_pf;          
input            rdl_vb_req;         
output  [39 :0]  lsu_biu_vb_awaddr;  
output  [1  :0]  lsu_biu_vb_awburst; 
output  [3  :0]  lsu_biu_vb_awcache; 
output  [3  :0]  lsu_biu_vb_awid;    
output  [1  :0]  lsu_biu_vb_awlen;   
output  [2  :0]  lsu_biu_vb_awprot;  
output  [2  :0]  lsu_biu_vb_awsize;  
output           lsu_biu_vb_awvalid; 
output  [127:0]  lsu_biu_vb_wdata;   
output           lsu_biu_vb_wlast;   
output  [15 :0]  lsu_biu_vb_wstrb;   
output           lsu_biu_vb_wvalid;  
output  [3  :0]  vb_dbginfo;         
output           vb_dc_hit_idx;      
output           vb_dc_pop_en;       
output           vb_icc_empty;       
output           vb_icc_grant;       
output           vb_lfb_arready;     
output           vb_lfb_dirty;       
output  [127:0]  vb_lfb_rdata;       
output  [3  :0]  vb_lfb_rid;         
output           vb_lfb_rlast;       
output           vb_lfb_rvalid;      
output           vb_pfb_hit_idx;     
output           vb_rdl_grant;       
output           vb_rdl_ld_alias_hit; 
output           vb_stb_clr_vld;     
output           vb_xx_idle;         

// &Regs; @23
reg     [1  :0]  alias_addr_5_4;     
reg     [1  :0]  data_cnt;           
reg     [33 :0]  vb_addr;            
reg              vb_alias;           
reg     [2  :0]  vb_arid;            
reg     [3  :0]  vb_cur_state;       
reg     [127:0]  vb_data0;           
reg     [127:0]  vb_data1;           
reg     [127:0]  vb_data2;           
reg     [127:0]  vb_data3;           
reg              vb_dirty;           
reg              vb_ld;              
reg     [3  :0]  vb_next_state;      
reg              vb_pf;              

// &Wires; @24
wire    [3  :0]  alias_data_sel;     
wire             biu_lsu_no_op;      
wire             biu_lsu_vb_awready; 
wire             biu_lsu_vb_wready;  
wire             cp0_lsu_icg_en;     
wire             cpurst_b;           
wire             data_cnt_last;      
wire    [39 :0]  dc_xx_pa;           
wire             forever_cpuclk;     
wire    [33 :0]  icc_vb_addr;        
wire    [127:0]  icc_vb_data;        
wire             icc_vb_data_vld;    
wire             icc_vb_req;         
wire             ifu_lsu_warm_up;    
wire    [1  :0]  lfb_vb_araddr_5_4;  
wire    [2  :0]  lfb_vb_arid;        
wire             lfb_vb_arvalid;     
wire             lfb_vb_rready;      
wire    [39 :0]  lsu_biu_vb_awaddr;  
wire    [1  :0]  lsu_biu_vb_awburst; 
wire    [3  :0]  lsu_biu_vb_awcache; 
wire    [3  :0]  lsu_biu_vb_awid;    
wire    [1  :0]  lsu_biu_vb_awlen;   
wire    [2  :0]  lsu_biu_vb_awprot;  
wire    [2  :0]  lsu_biu_vb_awsize;  
wire             lsu_biu_vb_awvalid; 
wire    [127:0]  lsu_biu_vb_wdata;   
wire             lsu_biu_vb_wlast;   
wire    [15 :0]  lsu_biu_vb_wstrb;   
wire             lsu_biu_vb_wvalid;  
wire             pad_yy_icg_scan_en; 
wire    [39 :0]  pfb_xx_pa;          
wire             rdl_data_sel;       
wire             rdl_req_sel;        
wire    [33 :0]  rdl_vb_addr;        
wire             rdl_vb_alias;       
wire             rdl_vb_alias_dirty; 
wire    [127:0]  rdl_vb_data;        
wire             rdl_vb_data_vld;    
wire             rdl_vb_ld;          
wire    [2  :0]  rdl_vb_ld_id;       
wire             rdl_vb_pf;          
wire             rdl_vb_req;         
wire             vb_addr_clk;        
wire             vb_addr_clk_en;     
wire             vb_clk;             
wire             vb_clk_en;          
wire    [127:0]  vb_create_data;     
wire             vb_cur_alias_req;   
wire             vb_cur_alias_wfc;   
wire             vb_cur_bus_req;     
wire             vb_cur_bus_wfc;     
wire             vb_cur_idle;        
wire             vb_data0_clk;       
wire             vb_data0_clk_en;    
wire             vb_data1_clk;       
wire             vb_data1_clk_en;    
wire             vb_data2_clk;       
wire             vb_data2_clk_en;    
wire             vb_data3_clk;       
wire             vb_data3_clk_en;    
wire    [3  :0]  vb_data_create_en;  
wire             vb_data_dirty;      
wire             vb_data_vld;        
wire    [3  :0]  vb_dbginfo;         
wire             vb_dc_hit_idx;      
wire             vb_dc_pop_en;       
wire             vb_icc_empty;       
wire             vb_icc_grant;       
wire             vb_lfb_arready;     
wire             vb_lfb_dirty;       
wire    [127:0]  vb_lfb_rdata;       
wire    [3  :0]  vb_lfb_rid;         
wire             vb_lfb_rlast;       
wire             vb_lfb_rvalid;      
wire             vb_pfb_hit_idx;     
wire             vb_rdl_grant;       
wire             vb_rdl_ld_alias_hit; 
wire    [33 :0]  vb_req_addr;        
wire             vb_req_alias;       
wire             vb_req_create_en;   
wire             vb_req_ld;          
wire    [2  :0]  vb_req_ld_id;       
wire             vb_req_pf;          
wire             vb_req_vld;         
wire             vb_stb_clr_vld;     
wire             vb_vld;             
wire             vb_xx_idle;         
wire    [3  :0]  wdata_sel;          


//==============================================================================
//  RDL and ICC request arbit
//==============================================================================

assign rdl_req_sel       = rdl_vb_req;
assign vb_req_vld        = rdl_req_sel ? rdl_vb_req        : icc_vb_req;
assign vb_req_addr[33:0] = rdl_req_sel ? rdl_vb_addr[33:0] : icc_vb_addr[33:0];
assign vb_req_alias      = rdl_req_sel ? rdl_vb_alias      : 1'b0;
assign vb_req_ld_id[2:0] = rdl_req_sel ? rdl_vb_ld_id[2:0] : 3'b0;
assign vb_req_ld         = rdl_req_sel ? rdl_vb_ld         : 1'b0;
assign vb_req_pf         = rdl_req_sel ? rdl_vb_pf         : 1'b0;

assign rdl_data_sel          = rdl_vb_data_vld;
assign vb_data_vld           = rdl_data_sel ? rdl_vb_data_vld      : icc_vb_data_vld;
assign vb_data_dirty         = rdl_data_sel ? rdl_vb_alias_dirty   : 1'b1;
assign vb_create_data[127:0] = rdl_data_sel ? rdl_vb_data[127:0]   : icc_vb_data[127:0];

assign vb_rdl_grant = vb_cur_idle;
assign vb_icc_grant = vb_cur_idle & !rdl_req_sel;

assign vb_icc_empty = !vb_vld & biu_lsu_no_op;

//==============================================================================
//  VB FSM
//==============================================================================
parameter VB_IDLE      = 4'b0000;
parameter VB_BUS_REQ   = 4'b0001;
parameter VB_BUS_WFC   = 4'b0010;
parameter VB_ALIAS_REQ = 4'b0011;
parameter VB_ALIAS_WFC = 4'b0100;
parameter VB_DATA_0    = 4'b1000;
parameter VB_DATA_1    = 4'b1001;
parameter VB_DATA_2    = 4'b1010;
parameter VB_DATA_3    = 4'b1011;

always@(posedge vb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    vb_cur_state[3:0] <= VB_IDLE;
  else
    vb_cur_state[3:0] <= vb_next_state[3:0];
end

// &CombBeg; @69
always @( vb_arid[2:0]
       or vb_req_vld
       or lfb_vb_arid[2:0]
       or vb_cur_state
       or vb_data_vld
       or biu_lsu_vb_awready
       or lfb_vb_rready
       or data_cnt_last
       or lfb_vb_arvalid
       or vb_alias
       or biu_lsu_vb_wready)
begin
  case(vb_cur_state)
    VB_IDLE: begin
      if (vb_req_vld)
        vb_next_state = VB_DATA_0;
      else
        vb_next_state = VB_IDLE;
    end
    VB_DATA_0: begin
      if (vb_data_vld)
        vb_next_state = VB_DATA_1;
      else
        vb_next_state = VB_DATA_0;
    end
    VB_DATA_1: begin
      if (vb_data_vld)
        vb_next_state = VB_DATA_2;
      else
        vb_next_state = VB_DATA_1;
    end
    VB_DATA_2: begin
      if (vb_data_vld)
        vb_next_state = VB_DATA_3;
      else
        vb_next_state = VB_DATA_2;
    end
    VB_DATA_3: begin
      if (vb_data_vld)
        vb_next_state = vb_alias ? VB_ALIAS_REQ : VB_BUS_REQ;
      else
        vb_next_state = VB_DATA_3;
    end
    VB_ALIAS_REQ: begin
      if (lfb_vb_arvalid & (lfb_vb_arid[2:0] == vb_arid[2:0]))
        vb_next_state = VB_ALIAS_WFC;
      else
        vb_next_state = VB_ALIAS_REQ;
    end
    VB_ALIAS_WFC: begin
      if (lfb_vb_rready & data_cnt_last)
        vb_next_state = VB_IDLE;
      else
        vb_next_state = VB_ALIAS_WFC;
    end
    VB_BUS_REQ: begin
      if (biu_lsu_vb_awready)
        vb_next_state = VB_BUS_WFC;
      else
        vb_next_state = VB_BUS_REQ;
    end
    VB_BUS_WFC: begin
      if (biu_lsu_vb_wready & data_cnt_last)
        vb_next_state = VB_IDLE;
      else
        vb_next_state = VB_BUS_WFC;
    end
    default: vb_next_state = VB_IDLE;
  endcase
// &CombEnd; @127
end

assign vb_cur_idle      = vb_cur_state == VB_IDLE;
assign vb_cur_bus_req   = vb_cur_state == VB_BUS_REQ;
assign vb_cur_bus_wfc   = vb_cur_state == VB_BUS_WFC;
assign vb_cur_alias_req = vb_cur_state == VB_ALIAS_REQ;
assign vb_cur_alias_wfc = vb_cur_state == VB_ALIAS_WFC;

assign vb_vld = !vb_cur_idle;
assign vb_xx_idle = vb_cur_idle;

//==============================================================================
//  VB content
//==============================================================================
assign vb_req_create_en = vb_req_vld & vb_cur_idle;

always@(posedge vb_addr_clk)
begin
  if (vb_req_create_en | ifu_lsu_warm_up) begin
    vb_addr[33:0] <= vb_req_addr[33:0];
    vb_alias      <= vb_req_alias;
    vb_ld         <= vb_req_ld;
    vb_pf         <= vb_req_pf;
    vb_arid[2:0]  <= vb_req_ld_id[2:0];
  end
end

assign vb_data_create_en[3:0] = 4'b1 << vb_cur_state[1:0] & {4{vb_data_vld}};

always@(posedge vb_data0_clk)
begin
  if (vb_data_create_en[0] | ifu_lsu_warm_up) begin
    vb_dirty        <= vb_data_dirty;
    vb_data0[127:0] <= vb_create_data[127:0];
  end
end

always@(posedge vb_data1_clk)
begin
  if (vb_data_create_en[1] | ifu_lsu_warm_up)
    vb_data1[127:0] <= vb_create_data[127:0];
end

always@(posedge vb_data2_clk)
begin
  if (vb_data_create_en[2] | ifu_lsu_warm_up)
    vb_data2[127:0] <= vb_create_data[127:0];
end

always@(posedge vb_data3_clk)
begin
  if (vb_data_create_en[3] | ifu_lsu_warm_up)
    vb_data3[127:0] <= vb_create_data[127:0];
end

//================================================
// alias address to support critical word first
//================================================
always@(posedge vb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    alias_addr_5_4[1:0] <= 2'b0;
  else if (lfb_vb_arvalid & vb_cur_alias_req)
    alias_addr_5_4[1:0] <= lfb_vb_araddr_5_4[1:0];
  else if (lfb_vb_rready)
    alias_addr_5_4[1:0] <= alias_addr_5_4[1:0] + 2'b1;
end

assign alias_data_sel[3:0] = 4'b1 << alias_addr_5_4[1:0];

//================================================
// data counter
//================================================
always@(posedge vb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    data_cnt[1:0] <= 2'b0;
  else if (vb_cur_bus_wfc & biu_lsu_vb_wready | 
           vb_cur_alias_wfc & lfb_vb_rready)
    data_cnt[1:0] <= data_cnt[1:0] + 2'b1;
end

assign data_cnt_last = data_cnt[1:0] == 2'b11;
assign wdata_sel[3:0] = 4'b1 << data_cnt[1:0];

//================================================
// interface to LFB
//================================================
assign vb_rdl_ld_alias_hit = vb_vld & vb_ld & vb_alias;
assign vb_lfb_arready      = vb_cur_alias_req & (lfb_vb_arid[2:0] == vb_arid[2:0]);
assign vb_lfb_rvalid       = vb_cur_alias_wfc;
assign vb_lfb_rid[3:0]     = (vb_ld & !vb_pf) ? 4'b0100 : {1'b1,vb_arid[2:0]};
assign vb_lfb_rlast        = data_cnt_last;
assign vb_lfb_dirty        = vb_dirty;

assign vb_lfb_rdata[127:0] = {128{alias_data_sel[0]}} & vb_data0[127:0] |
                             {128{alias_data_sel[1]}} & vb_data1[127:0] |
                             {128{alias_data_sel[2]}} & vb_data2[127:0] |
                             {128{alias_data_sel[3]}} & vb_data3[127:0]; 

//================================================
// interface to BIU
//================================================
// //&Force("bus","cp0_yy_priv_mode",1,0); @230
assign vb_stb_clr_vld          = vb_cur_bus_req;

assign lsu_biu_vb_awvalid      = vb_cur_bus_req;
assign lsu_biu_vb_awaddr[39:0] = {vb_addr[33:0], 6'b0};
assign lsu_biu_vb_awid[3:0]    = 4'b0100;
assign lsu_biu_vb_awcache[3:0] = {1'b1,1'b1,1'b1,1'b1};
assign lsu_biu_vb_awprot[2:0]  = {1'b0,1'b1,1'b1};
assign lsu_biu_vb_awsize[2:0]  = 3'b100;
assign lsu_biu_vb_awlen[1:0]   = 2'b11;
assign lsu_biu_vb_awburst[1:0] = 2'b01;

assign lsu_biu_vb_wvalid       = vb_cur_bus_wfc;
assign lsu_biu_vb_wlast        = data_cnt_last;
assign lsu_biu_vb_wstrb[15:0]  = {16{1'b1}};
assign lsu_biu_vb_wdata[127:0] = {128{wdata_sel[0]}} & vb_data0[127:0] |
                                 {128{wdata_sel[1]}} & vb_data1[127:0] |
                                 {128{wdata_sel[2]}} & vb_data2[127:0] |
                                 {128{wdata_sel[3]}} & vb_data3[127:0]; 


//================================================
// interface to DC
//================================================
// &Force("bus","dc_xx_pa",39,0); @254
// &Force("bus","pfb_xx_pa",39,0); @255

assign vb_dc_hit_idx = dc_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == vb_addr[`D_TAG_INDEX_WIDTH-1:0] & vb_vld;
assign vb_dc_pop_en  = vb_cur_alias_wfc & lfb_vb_rready & data_cnt_last |
                       vb_cur_bus_wfc & biu_lsu_vb_wready & data_cnt_last;

assign vb_pfb_hit_idx = pfb_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == vb_addr[`D_TAG_INDEX_WIDTH-1:0] & vb_vld;

//================================================
// ICG
//================================================

assign vb_clk_en = vb_req_vld | vb_vld;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_gated_clk"); @268
gated_clk_cell  x_pa_lsu_vb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_clk_en         ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @269
//          .external_en (1'b0), @270
//          .global_en   (1'b1), @271
//          .module_en   (cp0_lsu_icg_en), @272
//          .local_en    (vb_clk_en), @273
//          .clk_out     (vb_clk)); @274

assign vb_addr_clk_en = vb_req_create_en | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_addr_gated_clk"); @277
gated_clk_cell  x_pa_lsu_vb_addr_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_addr_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_addr_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @278
//          .external_en (1'b0), @279
//          .global_en   (1'b1), @280
//          .module_en   (cp0_lsu_icg_en), @281
//          .local_en    (vb_addr_clk_en), @282
//          .clk_out     (vb_addr_clk)); @283

assign vb_data3_clk_en = vb_data_create_en[3] | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_data3_gated_clk"); @286
gated_clk_cell  x_pa_lsu_vb_data3_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_data3_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_data3_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @287
//          .external_en (1'b0), @288
//          .global_en   (1'b1), @289
//          .module_en   (cp0_lsu_icg_en), @290
//          .local_en    (vb_data3_clk_en), @291
//          .clk_out     (vb_data3_clk)); @292

assign vb_data2_clk_en = vb_data_create_en[2] | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_data2_gated_clk"); @295
gated_clk_cell  x_pa_lsu_vb_data2_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_data2_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_data2_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @296
//          .external_en (1'b0), @297
//          .global_en   (1'b1), @298
//          .module_en   (cp0_lsu_icg_en), @299
//          .local_en    (vb_data2_clk_en), @300
//          .clk_out     (vb_data2_clk)); @301

assign vb_data1_clk_en = vb_data_create_en[1] | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_data1_gated_clk"); @304
gated_clk_cell  x_pa_lsu_vb_data1_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_data1_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_data1_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @305
//          .external_en (1'b0), @306
//          .global_en   (1'b1), @307
//          .module_en   (cp0_lsu_icg_en), @308
//          .local_en    (vb_data1_clk_en), @309
//          .clk_out     (vb_data1_clk)); @310

assign vb_data0_clk_en = vb_data_create_en[0] | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_vb_data0_gated_clk"); @313
gated_clk_cell  x_pa_lsu_vb_data0_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_data0_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_data0_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @314
//          .external_en (1'b0), @315
//          .global_en   (1'b1), @316
//          .module_en   (cp0_lsu_icg_en), @317
//          .local_en    (vb_data0_clk_en), @318
//          .clk_out     (vb_data0_clk)); @319

assign vb_dbginfo[3:0] = vb_cur_state[3:0];

// &ModuleEnd; @323
endmodule


