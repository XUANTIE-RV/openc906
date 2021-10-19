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
module aq_biu_req_arbiter(
  apbif_araddr,
  apbif_arid,
  apbif_arprot,
  apbif_arready,
  apbif_arvalid,
  apbif_awaddr,
  apbif_awid,
  apbif_awprot,
  apbif_awready,
  apbif_awvalid,
  apbif_idle,
  apbif_rdata,
  apbif_rid,
  apbif_rready,
  apbif_rresp,
  apbif_rvalid,
  apbif_wdata,
  apbif_wready,
  apbif_wvalid,
  ar_hit_wtable,
  araddr,
  arburst,
  arcache,
  arid,
  arlen,
  arlock,
  arprot,
  arready,
  arsize,
  arvalid,
  aw_hit_wtable,
  awaddr,
  awburst,
  awcache,
  awlen,
  awlock,
  awprot,
  awready,
  awsize,
  awvalid,
  biu_ifu_arready,
  biu_ifu_rdata,
  biu_ifu_rid,
  biu_ifu_rlast,
  biu_ifu_rresp,
  biu_ifu_rvalid,
  biu_lsu_arready,
  biu_lsu_no_op,
  biu_lsu_rdata,
  biu_lsu_rid,
  biu_lsu_rlast,
  biu_lsu_rresp,
  biu_lsu_rvalid,
  biu_lsu_stb_awready,
  biu_lsu_stb_wready,
  biu_lsu_vb_awready,
  biu_lsu_vb_wready,
  cp0_biu_icg_en,
  cpurst_b,
  forever_cpuclk,
  ifu_biu_araddr,
  ifu_biu_arburst,
  ifu_biu_arcache,
  ifu_biu_arid,
  ifu_biu_arlen,
  ifu_biu_arprot,
  ifu_biu_arsize,
  ifu_biu_arvalid,
  lsu_biu_araddr,
  lsu_biu_arburst,
  lsu_biu_arcache,
  lsu_biu_arid,
  lsu_biu_arlen,
  lsu_biu_arprot,
  lsu_biu_arsize,
  lsu_biu_aruser,
  lsu_biu_arvalid,
  lsu_biu_stb_awaddr,
  lsu_biu_stb_awburst,
  lsu_biu_stb_awcache,
  lsu_biu_stb_awid,
  lsu_biu_stb_awlen,
  lsu_biu_stb_awprot,
  lsu_biu_stb_awsize,
  lsu_biu_stb_awuser,
  lsu_biu_stb_awvalid,
  lsu_biu_stb_wdata,
  lsu_biu_stb_wlast,
  lsu_biu_stb_wstrb,
  lsu_biu_stb_wvalid,
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
  rdata,
  rid,
  rlast,
  rresp,
  rvalid,
  sysio_biu_apb_base,
  wdata,
  wlast,
  wready,
  wstrb,
  wtable_no_op,
  wvalid
);

// &Ports; @20
input            apbif_arready;       
input            apbif_awready;       
input            apbif_idle;          
input   [127:0]  apbif_rdata;         
input   [3  :0]  apbif_rid;           
input   [1  :0]  apbif_rresp;         
input            apbif_rvalid;        
input            apbif_wready;        
input            ar_hit_wtable;       
input            arready;             
input            aw_hit_wtable;       
input            awready;             
input            cp0_biu_icg_en;      
input            cpurst_b;            
input            forever_cpuclk;      
input   [39 :0]  ifu_biu_araddr;      
input   [1  :0]  ifu_biu_arburst;     
input   [3  :0]  ifu_biu_arcache;     
input            ifu_biu_arid;        
input   [1  :0]  ifu_biu_arlen;       
input   [2  :0]  ifu_biu_arprot;      
input   [2  :0]  ifu_biu_arsize;      
input            ifu_biu_arvalid;     
input   [39 :0]  lsu_biu_araddr;      
input   [1  :0]  lsu_biu_arburst;     
input   [3  :0]  lsu_biu_arcache;     
input   [3  :0]  lsu_biu_arid;        
input   [1  :0]  lsu_biu_arlen;       
input   [2  :0]  lsu_biu_arprot;      
input   [2  :0]  lsu_biu_arsize;      
input            lsu_biu_aruser;      
input            lsu_biu_arvalid;     
input   [39 :0]  lsu_biu_stb_awaddr;  
input   [1  :0]  lsu_biu_stb_awburst; 
input   [3  :0]  lsu_biu_stb_awcache; 
input   [1  :0]  lsu_biu_stb_awid;    
input   [1  :0]  lsu_biu_stb_awlen;   
input   [2  :0]  lsu_biu_stb_awprot;  
input   [2  :0]  lsu_biu_stb_awsize;  
input            lsu_biu_stb_awuser;  
input            lsu_biu_stb_awvalid; 
input   [127:0]  lsu_biu_stb_wdata;   
input            lsu_biu_stb_wlast;   
input   [15 :0]  lsu_biu_stb_wstrb;   
input            lsu_biu_stb_wvalid;  
input   [39 :0]  lsu_biu_vb_awaddr;   
input   [1  :0]  lsu_biu_vb_awburst;  
input   [3  :0]  lsu_biu_vb_awcache;  
input   [3  :0]  lsu_biu_vb_awid;     
input   [1  :0]  lsu_biu_vb_awlen;    
input   [2  :0]  lsu_biu_vb_awprot;   
input   [2  :0]  lsu_biu_vb_awsize;   
input            lsu_biu_vb_awvalid;  
input   [127:0]  lsu_biu_vb_wdata;    
input            lsu_biu_vb_wlast;    
input   [15 :0]  lsu_biu_vb_wstrb;    
input            lsu_biu_vb_wvalid;   
input            pad_yy_icg_scan_en;  
input   [127:0]  rdata;               
input   [3  :0]  rid;                 
input            rlast;               
input   [1  :0]  rresp;               
input            rvalid;              
input   [39 :0]  sysio_biu_apb_base;  
input            wready;              
input            wtable_no_op;        
output  [39 :0]  apbif_araddr;        
output  [3  :0]  apbif_arid;          
output  [1  :0]  apbif_arprot;        
output           apbif_arvalid;       
output  [39 :0]  apbif_awaddr;        
output  [3  :0]  apbif_awid;          
output  [1  :0]  apbif_awprot;        
output           apbif_awvalid;       
output           apbif_rready;        
output  [127:0]  apbif_wdata;         
output           apbif_wvalid;        
output  [39 :0]  araddr;              
output  [1  :0]  arburst;             
output  [3  :0]  arcache;             
output  [3  :0]  arid;                
output  [1  :0]  arlen;               
output           arlock;              
output  [2  :0]  arprot;              
output  [2  :0]  arsize;              
output           arvalid;             
output  [39 :0]  awaddr;              
output  [1  :0]  awburst;             
output  [3  :0]  awcache;             
output  [1  :0]  awlen;               
output           awlock;              
output  [2  :0]  awprot;              
output  [2  :0]  awsize;              
output           awvalid;             
output           biu_ifu_arready;     
output  [127:0]  biu_ifu_rdata;       
output           biu_ifu_rid;         
output           biu_ifu_rlast;       
output  [1  :0]  biu_ifu_rresp;       
output           biu_ifu_rvalid;      
output           biu_lsu_arready;     
output           biu_lsu_no_op;       
output  [127:0]  biu_lsu_rdata;       
output  [3  :0]  biu_lsu_rid;         
output           biu_lsu_rlast;       
output  [1  :0]  biu_lsu_rresp;       
output           biu_lsu_rvalid;      
output           biu_lsu_stb_awready; 
output           biu_lsu_stb_wready;  
output           biu_lsu_vb_awready;  
output           biu_lsu_vb_wready;   
output  [127:0]  wdata;               
output           wlast;               
output  [15 :0]  wstrb;               
output           wvalid;              

// &Regs; @21
reg     [7  :0]  apbif_sel;           
reg     [7  :0]  wsel_fifo;           
reg     [3  :0]  wsel_fifo_create_ptr; 
reg     [3  :0]  wsel_fifo_pop_ptr;   

// &Wires; @22
wire             apb_ar_hit;          
wire             apb_aw_hit;          
wire    [39 :0]  apbif_araddr;        
wire    [3  :0]  apbif_arid;          
wire    [1  :0]  apbif_arprot;        
wire             apbif_arready;       
wire             apbif_arvalid;       
wire    [39 :0]  apbif_awaddr;        
wire    [3  :0]  apbif_awid;          
wire    [1  :0]  apbif_awprot;        
wire             apbif_awready;       
wire             apbif_awvalid;       
wire             apbif_idle;          
wire    [127:0]  apbif_rdata;         
wire    [3  :0]  apbif_rid;           
wire             apbif_rready;        
wire    [1  :0]  apbif_rresp;         
wire             apbif_rvalid;        
wire    [127:0]  apbif_wdata;         
wire             apbif_wready;        
wire             apbif_wvalid;        
wire             ar_hit_wtable;       
wire    [39 :0]  araddr;              
wire    [39 :0]  arb_araddr;          
wire    [1  :0]  arb_arburst;         
wire    [3  :0]  arb_arcache;         
wire    [3  :0]  arb_arid;            
wire    [1  :0]  arb_arlen;           
wire    [2  :0]  arb_arprot;          
wire             arb_arready;         
wire    [2  :0]  arb_arsize;          
wire             arb_aruser;          
wire             arb_arvalid;         
wire    [39 :0]  arb_awaddr;          
wire    [1  :0]  arb_awburst;         
wire    [3  :0]  arb_awcache;         
wire    [3  :0]  arb_awid;            
wire    [1  :0]  arb_awlen;           
wire    [2  :0]  arb_awprot;          
wire    [2  :0]  arb_awsize;          
wire             arb_awuser;          
wire             arb_awvalid;         
wire             arb_clk;             
wire             arb_clk_en;          
wire    [127:0]  arb_wdata;           
wire             arb_wlast;           
wire    [15 :0]  arb_wstrb;           
wire             arb_wvalid;          
wire    [1  :0]  arburst;             
wire    [3  :0]  arcache;             
wire    [3  :0]  arid;                
wire    [1  :0]  arlen;               
wire             arlock;              
wire    [2  :0]  arprot;              
wire             arready;             
wire    [2  :0]  arsize;              
wire             arvalid;             
wire             aw_hit_wtable;       
wire    [39 :0]  awaddr;              
wire    [1  :0]  awburst;             
wire    [3  :0]  awcache;             
wire    [1  :0]  awlen;               
wire             awlock;              
wire    [2  :0]  awprot;              
wire             awready;             
wire             awready_final;       
wire    [2  :0]  awsize;              
wire             awvalid;             
wire             axi_arready;         
wire             axi_awready;         
wire             axi_lsu_rvalid;      
wire             biu_ifu_arready;     
wire    [127:0]  biu_ifu_rdata;       
wire             biu_ifu_rid;         
wire             biu_ifu_rlast;       
wire    [1  :0]  biu_ifu_rresp;       
wire             biu_ifu_rvalid;      
wire             biu_lsu_arready;     
wire             biu_lsu_no_op;       
wire    [127:0]  biu_lsu_rdata;       
wire    [3  :0]  biu_lsu_rid;         
wire             biu_lsu_rlast;       
wire    [1  :0]  biu_lsu_rresp;       
wire             biu_lsu_rvalid;      
wire             biu_lsu_stb_awready; 
wire             biu_lsu_stb_wready;  
wire             biu_lsu_vb_awready;  
wire             biu_lsu_vb_wready;   
wire             cp0_biu_icg_en;      
wire             cpurst_b;            
wire             forever_cpuclk;      
wire    [39 :0]  ifu_biu_araddr;      
wire    [1  :0]  ifu_biu_arburst;     
wire    [3  :0]  ifu_biu_arcache;     
wire             ifu_biu_arid;        
wire    [1  :0]  ifu_biu_arlen;       
wire    [2  :0]  ifu_biu_arprot;      
wire    [2  :0]  ifu_biu_arsize;      
wire             ifu_biu_arvalid;     
wire    [39 :0]  lsu_biu_araddr;      
wire    [1  :0]  lsu_biu_arburst;     
wire    [3  :0]  lsu_biu_arcache;     
wire    [3  :0]  lsu_biu_arid;        
wire    [1  :0]  lsu_biu_arlen;       
wire    [2  :0]  lsu_biu_arprot;      
wire    [2  :0]  lsu_biu_arsize;      
wire             lsu_biu_aruser;      
wire             lsu_biu_arvalid;     
wire    [39 :0]  lsu_biu_stb_awaddr;  
wire    [1  :0]  lsu_biu_stb_awburst; 
wire    [3  :0]  lsu_biu_stb_awcache; 
wire    [1  :0]  lsu_biu_stb_awid;    
wire    [1  :0]  lsu_biu_stb_awlen;   
wire    [2  :0]  lsu_biu_stb_awprot;  
wire    [2  :0]  lsu_biu_stb_awsize;  
wire             lsu_biu_stb_awuser;  
wire             lsu_biu_stb_awvalid; 
wire    [127:0]  lsu_biu_stb_wdata;   
wire             lsu_biu_stb_wlast;   
wire    [15 :0]  lsu_biu_stb_wstrb;   
wire             lsu_biu_stb_wvalid;  
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
wire             lsu_sel;             
wire             pad_yy_icg_scan_en;  
wire             r_ifu_sel;           
wire    [127:0]  rdata;               
wire    [3  :0]  rid;                 
wire             rlast;               
wire    [1  :0]  rresp;               
wire             rvalid;              
wire    [39 :0]  sysio_biu_apb_base;  
wire             vb_sel;              
wire    [127:0]  wdata;               
wire             wlast;               
wire             wready;              
wire             wready_final;        
wire             wsel_apbif;          
wire             wsel_full;           
wire             wsel_vb;             
wire    [15 :0]  wstrb;               
wire             wtable_no_op;        
wire             wvalid;              


parameter PADDR = 40;

assign biu_lsu_no_op = wtable_no_op & apbif_idle;

//================================================
//   read address channel
//================================================ 
assign lsu_sel               = lsu_biu_arvalid;
assign arb_arvalid           = lsu_sel ? lsu_biu_arvalid           : ifu_biu_arvalid;
assign arb_arid[3:0]         = lsu_sel ? lsu_biu_arid[3:0]         : {3'b0,ifu_biu_arid};
assign arb_araddr[PADDR-1:0] = lsu_sel ? lsu_biu_araddr[PADDR-1:0] : ifu_biu_araddr[PADDR-1:0];
assign arb_arsize[2:0]       = lsu_sel ? lsu_biu_arsize[2:0]       : ifu_biu_arsize[2:0];
assign arb_arlen[1:0]        = lsu_sel ? lsu_biu_arlen[1:0]        : ifu_biu_arlen[1:0];
assign arb_arburst[1:0]      = lsu_sel ? lsu_biu_arburst[1:0]      : ifu_biu_arburst[1:0];
assign arb_arcache[3:0]      = lsu_sel ? lsu_biu_arcache[3:0]      : ifu_biu_arcache[3:0];
assign arb_arprot[2:0]       = lsu_sel ? lsu_biu_arprot[2:0]       : ifu_biu_arprot[2:0];
assign arb_aruser            = lsu_sel & lsu_biu_aruser;

//================================================
//  APB AR decode
//================================================
// &Force("bus", "sysio_biu_apb_base",PADDR-1,0); @45
assign apb_ar_hit = arb_araddr[PADDR-1:27] == sysio_biu_apb_base[PADDR-1:27];

assign apbif_arvalid           = arb_arvalid & apb_ar_hit;
assign apbif_araddr[PADDR-1:0] = arb_araddr[PADDR-1:0];
assign apbif_arprot[1:0]       = {arb_aruser,arb_arprot[0]};
assign apbif_arid[3:0]         =  arb_arid[3:0];

assign arvalid                 = arb_arvalid & !apb_ar_hit & !ar_hit_wtable;
assign arid[3:0]               = arb_arid[3:0];         
assign araddr[PADDR-1:0]       = arb_araddr[PADDR-1:0];
assign arsize[2:0]             = arb_arsize[2:0];       
assign arlen[1:0]              = arb_arlen[1:0];        
assign arburst[1:0]            = arb_arburst[1:0];      
assign arcache[3:0]            = arb_arcache[3:0];      
assign arprot[2:0]             = arb_arprot[2:0];       
assign arlock                  = 1'b0;

assign axi_arready             = arready & !ar_hit_wtable;
assign arb_arready             = apb_ar_hit ? apbif_arready : axi_arready;
assign biu_lsu_arready         = arb_arready;
assign biu_ifu_arready         = arb_arready & !lsu_sel;

//================================================
//   read data channel
//================================================ 
assign r_ifu_sel            = rid[3:1] == 3'b000;
assign biu_ifu_rvalid       = rvalid & r_ifu_sel;
assign biu_ifu_rdata[127:0] = rdata[127:0];
assign biu_ifu_rid          = rid[0];
assign biu_ifu_rresp[1:0]   = rresp[1:0];
assign biu_ifu_rlast        = rlast;

assign axi_lsu_rvalid       = rvalid & !r_ifu_sel;
assign biu_lsu_rvalid       = axi_lsu_rvalid | apbif_rvalid;
assign biu_lsu_rdata[127:0] = axi_lsu_rvalid ? rdata[127:0] : apbif_rdata[127:0];
assign biu_lsu_rid[3:0]     = axi_lsu_rvalid ? rid[3:0]     : apbif_rid[3:0];
assign biu_lsu_rlast        = axi_lsu_rvalid ? rlast        : 1'b1;
assign biu_lsu_rresp[1:0]   = axi_lsu_rvalid ? rresp[1:0]   : apbif_rresp[1:0];

assign apbif_rready         = !axi_lsu_rvalid;

//================================================
//  write address channel
//================================================
// &Force("output","awaddr"); @90
// &Force("output","awprot"); @91

assign vb_sel                = lsu_biu_vb_awvalid;
assign arb_awvalid           = vb_sel ? lsu_biu_vb_awvalid           : lsu_biu_stb_awvalid;
assign arb_awaddr[PADDR-1:0] = vb_sel ? lsu_biu_vb_awaddr[PADDR-1:0] : lsu_biu_stb_awaddr[PADDR-1:0];
assign arb_awid[3:0]         = vb_sel ? lsu_biu_vb_awid[3:0]         : {2'b00,lsu_biu_stb_awid[1:0]};
assign arb_awsize[2:0]       = vb_sel ? lsu_biu_vb_awsize[2:0]       : lsu_biu_stb_awsize[2:0];
assign arb_awlen[1:0]        = vb_sel ? lsu_biu_vb_awlen[1:0]        : lsu_biu_stb_awlen[1:0];
assign arb_awburst[1:0]      = vb_sel ? lsu_biu_vb_awburst[1:0]      : lsu_biu_stb_awburst[1:0];
assign arb_awcache[3:0]      = vb_sel ? lsu_biu_vb_awcache[3:0]      : lsu_biu_stb_awcache[3:0];
assign arb_awprot[2:0]       = vb_sel ? lsu_biu_vb_awprot[2:0]       : lsu_biu_stb_awprot[2:0];
assign arb_awuser            = !vb_sel & lsu_biu_stb_awuser;

//================================================
//  APB write decode
//================================================
assign apb_aw_hit = arb_awaddr[PADDR-1:27] == sysio_biu_apb_base[PADDR-1:27];

assign apbif_awvalid           = arb_awvalid & apb_aw_hit;
assign apbif_awaddr[PADDR-1:0] = arb_awaddr[PADDR-1:0];
assign apbif_awprot[1:0]       = {arb_awuser,arb_awprot[0]};
assign apbif_awid[3:0]         = arb_awid[3:0];

assign awvalid                 = arb_awvalid & !apb_aw_hit & !aw_hit_wtable & !wsel_full;
assign awaddr[PADDR-1:0]       = arb_awaddr[PADDR-1:0];
assign awsize[2:0]             = arb_awsize[2:0];      
assign awlen[1:0]              = arb_awlen[1:0];     
assign awburst[1:0]            = arb_awburst[1:0];     
assign awcache[3:0]            = arb_awcache[3:0];     
assign awprot[2:0]             = arb_awprot[2:0];    
assign awlock                  = 1'b0;

assign axi_awready             = awready & !aw_hit_wtable & !wsel_full;
assign awready_final           = apb_aw_hit ? apbif_awready : axi_awready;
assign biu_lsu_vb_awready      = awready_final;
assign biu_lsu_stb_awready     = awready_final & !vb_sel;

//================================================
//  write sel fifo
//================================================

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wsel_fifo_create_ptr[3:0] <= 4'b0;
  else if (arb_awvalid & awready_final)
    wsel_fifo_create_ptr[3:0] <= wsel_fifo_create_ptr[3:0] + 4'b1;
end

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wsel_fifo_pop_ptr[3:0] <= 4'b0;
  else if (arb_wvalid & wready_final & arb_wlast)
    wsel_fifo_pop_ptr[3:0] <= wsel_fifo_pop_ptr[3:0] + 4'b1;
end

integer i;
always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    for(i=0;i<8;i=i+1)
      wsel_fifo[i] <= 1'b0;
  else begin
    for(i=0;i<8;i=i+1) 
    begin
      if (arb_awvalid & awready_final & wsel_fifo_create_ptr[2:0] == i) 
        wsel_fifo[i] <= vb_sel;
      else
        wsel_fifo[i] <= wsel_fifo[i];
    end
  end
end

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    for(i=0;i<8;i=i+1)
      apbif_sel[i] <= 1'b0;
  else begin
    for(i=0;i<8;i=i+1) 
    begin
      if (arb_awvalid & awready_final & wsel_fifo_create_ptr[2:0] == i) 
        apbif_sel[i] <= apb_aw_hit;
      else
        apbif_sel[i] <= apbif_sel[i];
    end
  end
end

assign wsel_full     = (wsel_fifo_pop_ptr[2:0] == wsel_fifo_create_ptr[2:0]) & 
                       (wsel_fifo_pop_ptr[3] ^ wsel_fifo_create_ptr[3]);

//================================================
//  write data channel
//================================================
assign wsel_vb            = wsel_fifo[wsel_fifo_pop_ptr[2:0]];
assign arb_wvalid         = wsel_vb ? lsu_biu_vb_wvalid       : lsu_biu_stb_wvalid;
assign arb_wdata[127:0]   = wsel_vb ? lsu_biu_vb_wdata[127:0] : lsu_biu_stb_wdata[127:0];
assign arb_wstrb[15:0]    = wsel_vb ? lsu_biu_vb_wstrb[15:0]  : lsu_biu_stb_wstrb[15:0];
assign arb_wlast          = wsel_vb ? lsu_biu_vb_wlast        : lsu_biu_stb_wlast;

assign wsel_apbif         = apbif_sel[wsel_fifo_pop_ptr[2:0]];
assign apbif_wvalid       = arb_wvalid & wsel_apbif;
assign apbif_wdata[127:0] = arb_wdata[127:0];

assign wvalid             = arb_wvalid & !wsel_apbif;
assign wdata[127:0]       = arb_wdata[127:0]; 
assign wstrb[15:0]        = arb_wstrb[15:0];
assign wlast              = arb_wlast; 

assign wready_final       = wsel_apbif ? apbif_wready : wready;
assign biu_lsu_vb_wready  = wready_final & wsel_vb;
assign biu_lsu_stb_wready = wready_final & !wsel_vb;

assign arb_clk_en = arb_awvalid | arb_wvalid & arb_wlast;

// &Instance("gated_clk_cell", "x_aq_biu_arb_gated_clk"); @208
gated_clk_cell  x_aq_biu_arb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (arb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (arb_clk_en        ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @209
//          .external_en (1'b0), @210
//          .global_en   (1'b1), @211
//          .module_en   (cp0_biu_icg_en), @212
//          .local_en    (arb_clk_en), @213
//          .clk_out     (arb_clk)); @214

// &ModuleEnd; @216
endmodule


