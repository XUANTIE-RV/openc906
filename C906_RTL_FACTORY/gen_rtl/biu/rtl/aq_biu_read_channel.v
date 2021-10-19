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
module aq_biu_read_channel(
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
  axim_clk_en,
  biu_clk,
  biu_pad_araddr,
  biu_pad_arburst,
  biu_pad_arcache,
  biu_pad_arid,
  biu_pad_arlen,
  biu_pad_arlock,
  biu_pad_arprot,
  biu_pad_arsize,
  biu_pad_arvalid,
  biu_pad_rready,
  cp0_biu_icg_en,
  cpurst_b,
  forever_cpuclk,
  pad_biu_arready,
  pad_biu_rdata,
  pad_biu_rid,
  pad_biu_rlast,
  pad_biu_rresp,
  pad_biu_rvalid,
  pad_yy_icg_scan_en,
  rdata,
  read_channel_clk_en,
  rid,
  rlast,
  rresp,
  rvalid
);

// &Ports; @20
input   [39 :0]  araddr;             
input   [1  :0]  arburst;            
input   [3  :0]  arcache;            
input   [3  :0]  arid;               
input   [1  :0]  arlen;              
input            arlock;             
input   [2  :0]  arprot;             
input   [2  :0]  arsize;             
input            arvalid;            
input            axim_clk_en;        
input            biu_clk;            
input            cp0_biu_icg_en;     
input            cpurst_b;           
input            forever_cpuclk;     
input            pad_biu_arready;    
input   [127:0]  pad_biu_rdata;      
input   [7  :0]  pad_biu_rid;        
input            pad_biu_rlast;      
input   [1  :0]  pad_biu_rresp;      
input            pad_biu_rvalid;     
input            pad_yy_icg_scan_en; 
output           arready;            
output  [39 :0]  biu_pad_araddr;     
output  [1  :0]  biu_pad_arburst;    
output  [3  :0]  biu_pad_arcache;    
output  [7  :0]  biu_pad_arid;       
output  [7  :0]  biu_pad_arlen;      
output           biu_pad_arlock;     
output  [2  :0]  biu_pad_arprot;     
output  [2  :0]  biu_pad_arsize;     
output           biu_pad_arvalid;    
output           biu_pad_rready;     
output  [127:0]  rdata;              
output           read_channel_clk_en; 
output  [3  :0]  rid;                
output           rlast;              
output  [1  :0]  rresp;              
output           rvalid;             

// &Regs; @21
reg              arbuf_vld;          
reg     [39 :0]  biu_pad_araddr;     
reg     [1  :0]  biu_pad_arburst;    
reg     [3  :0]  biu_pad_arcache;    
reg     [7  :0]  biu_pad_arid;       
reg     [7  :0]  biu_pad_arlen;      
reg              biu_pad_arlock;     
reg     [2  :0]  biu_pad_arprot;     
reg     [2  :0]  biu_pad_arsize;     
reg              rbuf_vld;           
reg     [127:0]  rdata;              
reg     [3  :0]  rid;                
reg              rlast;              
reg     [1  :0]  rresp;              

// &Wires; @22
wire    [39 :0]  araddr;             
wire             arbuf_create_en;    
wire             arbuf_pop_en;       
wire    [1  :0]  arburst;            
wire    [3  :0]  arcache;            
wire             arclk;              
wire    [3  :0]  arid;               
wire    [1  :0]  arlen;              
wire             arlock;             
wire    [2  :0]  arprot;             
wire             arready;            
wire    [2  :0]  arsize;             
wire             arvalid;            
wire             axim_clk_en;        
wire             biu_clk;            
wire             biu_pad_arvalid;    
wire             biu_pad_rready;     
wire             cp0_biu_icg_en;     
wire             cpurst_b;           
wire             forever_cpuclk;     
wire             pad_biu_arready;    
wire    [127:0]  pad_biu_rdata;      
wire    [7  :0]  pad_biu_rid;        
wire             pad_biu_rlast;      
wire    [1  :0]  pad_biu_rresp;      
wire             pad_biu_rvalid;     
wire             pad_yy_icg_scan_en; 
wire             rbuf_create_en;     
wire             rbuf_pop_en;        
wire             rclk;               
wire             read_channel_clk_en; 
wire             rvalid;             


parameter PADDR = 40;

//==============================================================================
//     AR channel
//==============================================================================
assign arready         = (!arbuf_vld | pad_biu_arready) & axim_clk_en;

assign arbuf_create_en = arvalid & (!arbuf_vld | pad_biu_arready);
assign arbuf_pop_en    = arbuf_vld & pad_biu_arready & axim_clk_en;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    arbuf_vld <= 1'b0;
  else if (axim_clk_en) begin
    if (arbuf_create_en)
      arbuf_vld <= 1'b1;
    else if (arbuf_pop_en)
      arbuf_vld <= 1'b0;
    else
      arbuf_vld <= arbuf_vld;
  end
end

assign biu_pad_arvalid = arbuf_vld;

always @(posedge arclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    biu_pad_arid[7:0]         <= 8'b0;
    biu_pad_araddr[PADDR-1:0] <= {PADDR{1'b0}};
    biu_pad_arsize[2:0]       <= 3'b0;
    biu_pad_arlen[7:0]        <= 8'b0;
    biu_pad_arburst[1:0]      <= 2'b0;
    biu_pad_arcache[3:0]      <= 4'b0;
    biu_pad_arprot[2:0]       <= 3'b0;
    biu_pad_arlock            <= 1'b0;
  end
  else if (arbuf_create_en & axim_clk_en) begin
    biu_pad_arid[7:0]         <= {4'b0,arid[3:0]};
    biu_pad_araddr[PADDR-1:0] <= araddr[PADDR-1:0];
    biu_pad_arsize[2:0]       <= arsize[2:0];
    biu_pad_arlen[7:0]        <= {6'b0, arlen[1:0]};
    biu_pad_arburst[1:0]      <= arburst[1:0];
    biu_pad_arcache[3:0]      <= arcache[3:0];
    biu_pad_arprot[2:0]       <= arprot[2:0];
    biu_pad_arlock            <= arlock;
  end
end

//==============================================================================
//     R channel
//==============================================================================
// &Force("bus", "pad_biu_rid",7,0); @77
// &Force("output", "rlast"); @78
// &Force("output", "rresp"); @79
// &Force("output", "rid"); @80

assign biu_pad_rready = 1'b1;

assign rbuf_create_en = axim_clk_en & pad_biu_rvalid;
assign rbuf_pop_en    = rbuf_vld;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rbuf_vld <= 1'b0;
  else if (rbuf_create_en)
    rbuf_vld <= 1'b1;
  else if (rbuf_pop_en)
    rbuf_vld <= 1'b0;
end

assign rvalid = rbuf_vld;

always @(posedge rclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    rid[3:0]     <= 4'b0;
    rdata[127:0] <= 128'b0;
    rlast        <= 1'b0;
    rresp[1:0]   <= 2'b0;
  end
  else if (rbuf_create_en) begin
    rid[3:0]     <= pad_biu_rid[3:0];
    rdata[127:0] <= pad_biu_rdata[127:0];
    rlast        <= pad_biu_rlast;
    rresp[1:0]   <= pad_biu_rresp[1:0];
  end
end

assign read_channel_clk_en = rbuf_create_en | rbuf_pop_en |
                             arbuf_create_en | arbuf_pop_en;

// &Instance("gated_clk_cell", "x_aq_biu_ar_gated_clk"); @118
gated_clk_cell  x_aq_biu_ar_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (arclk             ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (arbuf_create_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @119
//          .external_en (1'b0), @120
//          .global_en   (1'b1), @121
//          .module_en   (cp0_biu_icg_en), @122
//          .local_en    (arbuf_create_en), @123
//          .clk_out     (arclk)); @124

// &Instance("gated_clk_cell", "x_aq_biu_r_gated_clk"); @126
gated_clk_cell  x_aq_biu_r_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rclk              ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rbuf_create_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @127
//          .external_en (1'b0), @128
//          .global_en   (1'b1), @129
//          .module_en   (cp0_biu_icg_en), @130
//          .local_en    (rbuf_create_en), @131
//          .clk_out     (rclk)); @132

// &ModuleEnd; @134
endmodule


