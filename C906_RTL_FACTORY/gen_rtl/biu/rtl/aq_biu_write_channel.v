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
module aq_biu_write_channel(
  ar_hit_wtable,
  araddr,
  arcache,
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
  axim_clk_en,
  biu_clk,
  biu_pad_awaddr,
  biu_pad_awburst,
  biu_pad_awcache,
  biu_pad_awid,
  biu_pad_awlen,
  biu_pad_awlock,
  biu_pad_awprot,
  biu_pad_awsize,
  biu_pad_awvalid,
  biu_pad_bready,
  biu_pad_wdata,
  biu_pad_wlast,
  biu_pad_wstrb,
  biu_pad_wvalid,
  cp0_biu_icg_en,
  cpurst_b,
  forever_cpuclk,
  pad_biu_awready,
  pad_biu_bid,
  pad_biu_bresp,
  pad_biu_bvalid,
  pad_biu_wready,
  pad_yy_icg_scan_en,
  wdata,
  wlast,
  wready,
  write_channel_clk_en,
  wstrb,
  wtable_no_op,
  wvalid
);

// &Ports; @20
input   [39 :0]  araddr;              
input   [3  :0]  arcache;             
input   [39 :0]  awaddr;              
input   [1  :0]  awburst;             
input   [3  :0]  awcache;             
input   [1  :0]  awlen;               
input            awlock;              
input   [2  :0]  awprot;              
input   [2  :0]  awsize;              
input            awvalid;             
input            axim_clk_en;         
input            biu_clk;             
input            cp0_biu_icg_en;      
input            cpurst_b;            
input            forever_cpuclk;      
input            pad_biu_awready;     
input   [7  :0]  pad_biu_bid;         
input   [1  :0]  pad_biu_bresp;       
input            pad_biu_bvalid;      
input            pad_biu_wready;      
input            pad_yy_icg_scan_en;  
input   [127:0]  wdata;               
input            wlast;               
input   [15 :0]  wstrb;               
input            wvalid;              
output           ar_hit_wtable;       
output           aw_hit_wtable;       
output           awready;             
output  [39 :0]  biu_pad_awaddr;      
output  [1  :0]  biu_pad_awburst;     
output  [3  :0]  biu_pad_awcache;     
output  [7  :0]  biu_pad_awid;        
output  [7  :0]  biu_pad_awlen;       
output           biu_pad_awlock;      
output  [2  :0]  biu_pad_awprot;      
output  [2  :0]  biu_pad_awsize;      
output           biu_pad_awvalid;     
output           biu_pad_bready;      
output  [127:0]  biu_pad_wdata;       
output           biu_pad_wlast;       
output  [15 :0]  biu_pad_wstrb;       
output           biu_pad_wvalid;      
output           wready;              
output           write_channel_clk_en; 
output           wtable_no_op;        

// &Regs; @21
reg              awbuf_vld;           
reg              bbuf_vld;            
reg     [3  :0]  bid;                 
reg     [39 :0]  biu_pad_awaddr;      
reg     [1  :0]  biu_pad_awburst;     
reg     [3  :0]  biu_pad_awcache;     
reg     [7  :0]  biu_pad_awid;        
reg     [7  :0]  biu_pad_awlen;       
reg              biu_pad_awlock;      
reg     [2  :0]  biu_pad_awprot;      
reg     [2  :0]  biu_pad_awsize;      
reg     [127:0]  biu_pad_wdata;       
reg              biu_pad_wlast;       
reg     [15 :0]  biu_pad_wstrb;       
reg              wbuf_vld;            
reg     [3  :0]  wtable_create_ptr;   

// &Wires; @22
wire             ar_hit_wtable;       
wire    [15 :0]  ar_hit_wtable_addr;  
wire    [15 :0]  ar_hit_wtable_so;    
wire    [39 :0]  araddr;              
wire    [3  :0]  arcache;             
wire             aw_hit_wtable;       
wire    [15 :0]  aw_hit_wtable_addr;  
wire    [15 :0]  aw_hit_wtable_so;    
wire    [39 :0]  awaddr;              
wire             awbuf_create_en;     
wire             awbuf_pop_en;        
wire    [1  :0]  awburst;             
wire    [3  :0]  awcache;             
wire             awclk;               
wire    [1  :0]  awlen;               
wire             awlock;              
wire    [2  :0]  awprot;              
wire             awready;             
wire    [2  :0]  awsize;              
wire             awvalid;             
wire             axim_clk_en;         
wire             bbuf_create_en;      
wire             bbuf_pop_en;         
wire             biu_clk;             
wire             biu_pad_awvalid;     
wire             biu_pad_bready;      
wire             biu_pad_wvalid;      
wire             cp0_biu_icg_en;      
wire             cpurst_b;            
wire             forever_cpuclk;      
wire             pad_biu_awready;     
wire    [7  :0]  pad_biu_bid;         
wire             pad_biu_bvalid;      
wire             pad_biu_wready;      
wire             pad_yy_icg_scan_en;  
wire             wbuf_create_en;      
wire             wbuf_pop_en;         
wire             wclk;                
wire    [127:0]  wdata;               
wire             wlast;               
wire             wready;              
wire             write_channel_clk_en; 
wire    [15 :0]  wstrb;               
wire    [9  :0]  wtable_create_addr;  
wire             wtable_create_burst; 
wire    [15 :0]  wtable_create_en;    
wire    [15 :0]  wtable_create_sel;   
wire             wtable_create_so;    
wire    [15 :0]  wtable_entry_vld;    
wire             wtable_full;         
wire             wtable_no_op;        
wire    [15 :0]  wtable_pop_en;       
wire             wvalid;              


parameter PADDR = 40;
parameter DEPTH = 16;

//==========================================================
//  address and so check
//==========================================================

assign ar_hit_wtable = (|ar_hit_wtable_addr[DEPTH-1:0]) |
                       (|ar_hit_wtable_so[DEPTH-1:0]);

assign aw_hit_wtable = (|aw_hit_wtable_addr[DEPTH-1:0]) |
                       (|aw_hit_wtable_so[DEPTH-1:0]);

//==============================================================================
//     AW channel
//==============================================================================
// &Force("bus","awid",3,0); @40
// &Force("output","awready"); @41

assign awready         = (!awbuf_vld | pad_biu_awready) & !wtable_full & axim_clk_en;

assign awbuf_create_en = awvalid & awready;
assign awbuf_pop_en    = awbuf_vld & pad_biu_awready & axim_clk_en;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    awbuf_vld <= 1'b0;
  else if (axim_clk_en) begin
    if (awbuf_create_en)
      awbuf_vld <= 1'b1;
    else if (awbuf_pop_en)
      awbuf_vld <= 1'b0;
    else
      awbuf_vld <= awbuf_vld;
  end
end

assign biu_pad_awvalid = awbuf_vld;

always @(posedge awclk or negedge cpurst_b)
begin
  if (!cpurst_b)begin
    biu_pad_awaddr[PADDR-1:0] <= {PADDR{1'b0}};
    biu_pad_awsize[2:0]       <= 3'b0; 
    biu_pad_awlen[7:0]        <= 8'b0;        
    biu_pad_awburst[1:0]      <= 2'b0;  
    biu_pad_awcache[3:0]      <= 4'b0;  
    biu_pad_awprot[2:0]       <= 3'b0; 
    biu_pad_awlock            <= 1'b0;
    biu_pad_awid[7:0]         <= 8'b0;

  end
  else if (awbuf_create_en & axim_clk_en) begin
    biu_pad_awaddr[PADDR-1:0] <= awaddr[PADDR-1:0];
    biu_pad_awsize[2:0]       <= awsize[2:0];
    biu_pad_awlen[7:0]        <= {6'b0, awlen[1:0]};
    biu_pad_awburst[1:0]      <= awburst[1:0];
    biu_pad_awcache[3:0]      <= awcache[3:0];
    biu_pad_awprot[2:0]       <= awprot[2:0];
    biu_pad_awlock            <= awlock;
    biu_pad_awid[7:0]         <= {4'b0,wtable_create_ptr[3:0]};
  end
end


//==============================================================================
//     W channel
//==============================================================================
assign wready         = (!wbuf_vld | pad_biu_wready) & axim_clk_en;

assign wbuf_create_en = wvalid & (!wbuf_vld | pad_biu_wready);
assign wbuf_pop_en    = wbuf_vld & pad_biu_wready & axim_clk_en;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wbuf_vld <= 1'b0;
  else if (axim_clk_en) begin
    if (wbuf_create_en)
      wbuf_vld <= 1'b1;
    else if (wbuf_pop_en)
      wbuf_vld <= 1'b0;
    else
      wbuf_vld <= wbuf_vld;
  end
end

assign biu_pad_wvalid = wbuf_vld;

always @(posedge wclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    biu_pad_wstrb[15:0]  <= 16'b0;
    biu_pad_wdata[127:0] <= 128'b0;
    biu_pad_wlast        <= 1'b0;
  end
  else if (wbuf_create_en & axim_clk_en) begin
    biu_pad_wstrb[15:0]  <= wstrb[15:0];
    biu_pad_wdata[127:0] <= wdata[127:0];
    biu_pad_wlast        <= wlast;
  end
end

//==============================================================================
//     B channel
//==============================================================================
// &Force("bus", "pad_biu_bid",7,0); @131
// &Force("input","pad_biu_bresp"); @132
// &Force("bus","pad_biu_bresp",1,0); @133

assign biu_pad_bready = 1'b1;

assign bbuf_create_en = axim_clk_en & pad_biu_bvalid;
assign bbuf_pop_en    = bbuf_vld;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bbuf_vld <= 1'b0;
  else if (bbuf_create_en)
    bbuf_vld <= 1'b1;
  else if (bbuf_pop_en)
    bbuf_vld <= 1'b0;
end

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    bid[3:0] <= 4'b0;
  else if (bbuf_create_en) 
    bid[3:0] <= pad_biu_bid[3:0];
end

assign wtable_pop_en[DEPTH-1:0] = (16'b1 << bid[3:0]) & {DEPTH{bbuf_vld}};

//==============================================================================
//     write table 
//==============================================================================

always @(posedge awclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wtable_create_ptr[3:0] <= 4'b0;
  else if (awbuf_create_en)
    wtable_create_ptr[3:0] <= wtable_create_ptr[3:0] + 4'b1;
end

assign wtable_full = wtable_entry_vld[wtable_create_ptr[3:0]];

assign wtable_create_sel[DEPTH-1:0] = 16'b1 << wtable_create_ptr[3:0] ;
assign wtable_create_en[DEPTH-1:0]  = wtable_create_sel[DEPTH-1:0] & {16{awbuf_create_en}};
assign wtable_create_addr[9:0]      = awaddr[13:4];
assign wtable_create_so             = !awcache[1];
assign wtable_create_burst          = awlen[1:0] == 2'b11;
//no_op
assign wtable_no_op = ~(|wtable_entry_vld[DEPTH-1:0]);

//==============================================================================
//  ICG
//==============================================================================
assign write_channel_clk_en = bbuf_create_en | bbuf_pop_en |
                              wbuf_create_en | wbuf_pop_en |
                              awbuf_create_en | awbuf_pop_en;

// &Instance("gated_clk_cell", "x_aq_biu_aw_gated_clk"); @189
gated_clk_cell  x_aq_biu_aw_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (awclk             ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (awbuf_create_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @190
//          .external_en (1'b0), @191
//          .global_en   (1'b1), @192
//          .module_en   (cp0_biu_icg_en), @193
//          .local_en    (awbuf_create_en), @194
//          .clk_out     (awclk)); @195

// &Instance("gated_clk_cell", "x_aq_biu_w_gated_clk"); @197
gated_clk_cell  x_aq_biu_w_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (wclk              ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (wbuf_create_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @198
//          .external_en (1'b0), @199
//          .global_en   (1'b1), @200
//          .module_en   (cp0_biu_icg_en), @201
//          .local_en    (wbuf_create_en), @202
//          .clk_out     (wclk)); @203
//==============================================================================
//     write table Instance
//==============================================================================
// &ConnRule(s/_x$/[0]/); @207
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_0"); @208
aq_biu_wt_entry  x_aq_biu_wt_entry_0 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[0]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[0]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[0]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[0]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[0]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[0]  ),
  .wtable_pop_en_x       (wtable_pop_en[0]     )
);


// &ConnRule(s/_x$/[1]/); @210
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_1"); @211
aq_biu_wt_entry  x_aq_biu_wt_entry_1 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[1]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[1]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[1]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[1]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[1]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[1]  ),
  .wtable_pop_en_x       (wtable_pop_en[1]     )
);


// &ConnRule(s/_x$/[2]/); @213
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_2"); @214
aq_biu_wt_entry  x_aq_biu_wt_entry_2 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[2]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[2]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[2]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[2]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[2]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[2]  ),
  .wtable_pop_en_x       (wtable_pop_en[2]     )
);


// &ConnRule(s/_x$/[3]/); @216
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_3"); @217
aq_biu_wt_entry  x_aq_biu_wt_entry_3 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[3]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[3]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[3]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[3]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[3]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[3]  ),
  .wtable_pop_en_x       (wtable_pop_en[3]     )
);


// &ConnRule(s/_x$/[4]/); @219
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_4"); @220
aq_biu_wt_entry  x_aq_biu_wt_entry_4 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[4]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[4]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[4]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[4]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[4]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[4]  ),
  .wtable_pop_en_x       (wtable_pop_en[4]     )
);


// &ConnRule(s/_x$/[5]/); @222
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_5"); @223
aq_biu_wt_entry  x_aq_biu_wt_entry_5 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[5]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[5]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[5]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[5]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[5]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[5]  ),
  .wtable_pop_en_x       (wtable_pop_en[5]     )
);


// &ConnRule(s/_x$/[6]/); @225
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_6"); @226
aq_biu_wt_entry  x_aq_biu_wt_entry_6 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[6]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[6]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[6]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[6]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[6]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[6]  ),
  .wtable_pop_en_x       (wtable_pop_en[6]     )
);


// &ConnRule(s/_x$/[7]/); @228
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_7"); @229
aq_biu_wt_entry  x_aq_biu_wt_entry_7 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[7]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[7]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[7]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[7]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[7]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[7]  ),
  .wtable_pop_en_x       (wtable_pop_en[7]     )
);


// &ConnRule(s/_x$/[8]/); @231
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_8"); @232
aq_biu_wt_entry  x_aq_biu_wt_entry_8 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[8]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[8]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[8]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[8]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[8]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[8]  ),
  .wtable_pop_en_x       (wtable_pop_en[8]     )
);


// &ConnRule(s/_x$/[9]/); @234
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_9"); @235
aq_biu_wt_entry  x_aq_biu_wt_entry_9 (
  .ar_hit_wtable_addr_x  (ar_hit_wtable_addr[9]),
  .ar_hit_wtable_so_x    (ar_hit_wtable_so[9]  ),
  .araddr                (araddr               ),
  .arcache               (arcache              ),
  .aw_hit_wtable_addr_x  (aw_hit_wtable_addr[9]),
  .aw_hit_wtable_so_x    (aw_hit_wtable_so[9]  ),
  .awaddr                (awaddr               ),
  .awcache               (awcache              ),
  .awlen                 (awlen                ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .wtable_create_addr    (wtable_create_addr   ),
  .wtable_create_burst   (wtable_create_burst  ),
  .wtable_create_en_x    (wtable_create_en[9]  ),
  .wtable_create_so      (wtable_create_so     ),
  .wtable_entry_vld_x    (wtable_entry_vld[9]  ),
  .wtable_pop_en_x       (wtable_pop_en[9]     )
);


// &ConnRule(s/_x$/[10]/); @237
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_10"); @238
aq_biu_wt_entry  x_aq_biu_wt_entry_10 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[10]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[10]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[10]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[10]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[10]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[10]  ),
  .wtable_pop_en_x        (wtable_pop_en[10]     )
);


// &ConnRule(s/_x$/[11]/); @240
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_11"); @241
aq_biu_wt_entry  x_aq_biu_wt_entry_11 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[11]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[11]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[11]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[11]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[11]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[11]  ),
  .wtable_pop_en_x        (wtable_pop_en[11]     )
);


// &ConnRule(s/_x$/[12]/); @243
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_12"); @244
aq_biu_wt_entry  x_aq_biu_wt_entry_12 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[12]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[12]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[12]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[12]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[12]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[12]  ),
  .wtable_pop_en_x        (wtable_pop_en[12]     )
);


// &ConnRule(s/_x$/[13]/); @246
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_13"); @247
aq_biu_wt_entry  x_aq_biu_wt_entry_13 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[13]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[13]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[13]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[13]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[13]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[13]  ),
  .wtable_pop_en_x        (wtable_pop_en[13]     )
);


// &ConnRule(s/_x$/[14]/); @249
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_14"); @250
aq_biu_wt_entry  x_aq_biu_wt_entry_14 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[14]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[14]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[14]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[14]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[14]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[14]  ),
  .wtable_pop_en_x        (wtable_pop_en[14]     )
);


// &ConnRule(s/_x$/[15]/); @252
// &Instance("aq_biu_wt_entry","x_aq_biu_wt_entry_15"); @253
aq_biu_wt_entry  x_aq_biu_wt_entry_15 (
  .ar_hit_wtable_addr_x   (ar_hit_wtable_addr[15]),
  .ar_hit_wtable_so_x     (ar_hit_wtable_so[15]  ),
  .araddr                 (araddr                ),
  .arcache                (arcache               ),
  .aw_hit_wtable_addr_x   (aw_hit_wtable_addr[15]),
  .aw_hit_wtable_so_x     (aw_hit_wtable_so[15]  ),
  .awaddr                 (awaddr                ),
  .awcache                (awcache               ),
  .awlen                  (awlen                 ),
  .cp0_biu_icg_en         (cp0_biu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .wtable_create_addr     (wtable_create_addr    ),
  .wtable_create_burst    (wtable_create_burst   ),
  .wtable_create_en_x     (wtable_create_en[15]  ),
  .wtable_create_so       (wtable_create_so      ),
  .wtable_entry_vld_x     (wtable_entry_vld[15]  ),
  .wtable_pop_en_x        (wtable_pop_en[15]     )
);


// &ModuleEnd; @255
endmodule


