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
module aq_biu_top(
  apb_clk_en,
  axim_clk_en,
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
  biu_pad_araddr,
  biu_pad_arburst,
  biu_pad_arcache,
  biu_pad_arid,
  biu_pad_arlen,
  biu_pad_arlock,
  biu_pad_arprot,
  biu_pad_arsize,
  biu_pad_arvalid,
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
  biu_pad_rready,
  biu_pad_wdata,
  biu_pad_wlast,
  biu_pad_wstrb,
  biu_pad_wvalid,
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
  pad_biu_arready,
  pad_biu_awready,
  pad_biu_bid,
  pad_biu_bresp,
  pad_biu_bvalid,
  pad_biu_rdata,
  pad_biu_rid,
  pad_biu_rlast,
  pad_biu_rresp,
  pad_biu_rvalid,
  pad_biu_wready,
  pad_yy_icg_scan_en,
  paddr,
  penable,
  perr_clint,
  perr_plic,
  pprot,
  prdata_clint,
  prdata_plic,
  pready_clint,
  pready_plic,
  psel_clint,
  psel_plic,
  pwdata,
  pwrite,
  sysio_biu_apb_base
);

// &Ports; @20
input            apb_clk_en;          
input            axim_clk_en;         
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
input            pad_biu_arready;     
input            pad_biu_awready;     
input   [7  :0]  pad_biu_bid;         
input   [1  :0]  pad_biu_bresp;       
input            pad_biu_bvalid;      
input   [127:0]  pad_biu_rdata;       
input   [7  :0]  pad_biu_rid;         
input            pad_biu_rlast;       
input   [1  :0]  pad_biu_rresp;       
input            pad_biu_rvalid;      
input            pad_biu_wready;      
input            pad_yy_icg_scan_en;  
input            perr_clint;          
input            perr_plic;           
input   [31 :0]  prdata_clint;        
input   [31 :0]  prdata_plic;         
input            pready_clint;        
input            pready_plic;         
input   [39 :0]  sysio_biu_apb_base;  
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
output  [39 :0]  biu_pad_araddr;      
output  [1  :0]  biu_pad_arburst;     
output  [3  :0]  biu_pad_arcache;     
output  [7  :0]  biu_pad_arid;        
output  [7  :0]  biu_pad_arlen;       
output           biu_pad_arlock;      
output  [2  :0]  biu_pad_arprot;      
output  [2  :0]  biu_pad_arsize;      
output           biu_pad_arvalid;     
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
output           biu_pad_rready;      
output  [127:0]  biu_pad_wdata;       
output           biu_pad_wlast;       
output  [15 :0]  biu_pad_wstrb;       
output           biu_pad_wvalid;      
output  [31 :0]  paddr;               
output           penable;             
output  [1  :0]  pprot;               
output           psel_clint;          
output           psel_plic;           
output  [31 :0]  pwdata;              
output           pwrite;              

// &Regs; @21

// &Wires; @22
wire             apb_clk_en;          
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
wire    [2  :0]  awsize;              
wire             awvalid;             
wire             axim_clk_en;         
wire             biu_clk;             
wire             biu_clk_en;          
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
wire    [39 :0]  biu_pad_araddr;      
wire    [1  :0]  biu_pad_arburst;     
wire    [3  :0]  biu_pad_arcache;     
wire    [7  :0]  biu_pad_arid;        
wire    [7  :0]  biu_pad_arlen;       
wire             biu_pad_arlock;      
wire    [2  :0]  biu_pad_arprot;      
wire    [2  :0]  biu_pad_arsize;      
wire             biu_pad_arvalid;     
wire    [39 :0]  biu_pad_awaddr;      
wire    [1  :0]  biu_pad_awburst;     
wire    [3  :0]  biu_pad_awcache;     
wire    [7  :0]  biu_pad_awid;        
wire    [7  :0]  biu_pad_awlen;       
wire             biu_pad_awlock;      
wire    [2  :0]  biu_pad_awprot;      
wire    [2  :0]  biu_pad_awsize;      
wire             biu_pad_awvalid;     
wire             biu_pad_bready;      
wire             biu_pad_rready;      
wire    [127:0]  biu_pad_wdata;       
wire             biu_pad_wlast;       
wire    [15 :0]  biu_pad_wstrb;       
wire             biu_pad_wvalid;      
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
wire             pad_biu_arready;     
wire             pad_biu_awready;     
wire    [7  :0]  pad_biu_bid;         
wire    [1  :0]  pad_biu_bresp;       
wire             pad_biu_bvalid;      
wire    [127:0]  pad_biu_rdata;       
wire    [7  :0]  pad_biu_rid;         
wire             pad_biu_rlast;       
wire    [1  :0]  pad_biu_rresp;       
wire             pad_biu_rvalid;      
wire             pad_biu_wready;      
wire             pad_yy_icg_scan_en;  
wire    [31 :0]  paddr;               
wire             penable;             
wire             perr_clint;          
wire             perr_plic;           
wire    [1  :0]  pprot;               
wire    [31 :0]  prdata_clint;        
wire    [31 :0]  prdata_plic;         
wire             pready_clint;        
wire             pready_plic;         
wire             psel_clint;          
wire             psel_plic;           
wire    [31 :0]  pwdata;              
wire             pwrite;              
wire    [127:0]  rdata;               
wire             read_channel_clk_en; 
wire    [3  :0]  rid;                 
wire             rlast;               
wire    [1  :0]  rresp;               
wire             rvalid;              
wire    [39 :0]  sysio_biu_apb_base;  
wire    [127:0]  wdata;               
wire             wlast;               
wire             wready;              
wire             write_channel_clk_en; 
wire    [15 :0]  wstrb;               
wire             wtable_no_op;        
wire             wvalid;              


// &Instance("aq_biu_req_arbiter"); @24
aq_biu_req_arbiter  x_aq_biu_req_arbiter (
  .apbif_araddr        (apbif_araddr       ),
  .apbif_arid          (apbif_arid         ),
  .apbif_arprot        (apbif_arprot       ),
  .apbif_arready       (apbif_arready      ),
  .apbif_arvalid       (apbif_arvalid      ),
  .apbif_awaddr        (apbif_awaddr       ),
  .apbif_awid          (apbif_awid         ),
  .apbif_awprot        (apbif_awprot       ),
  .apbif_awready       (apbif_awready      ),
  .apbif_awvalid       (apbif_awvalid      ),
  .apbif_idle          (apbif_idle         ),
  .apbif_rdata         (apbif_rdata        ),
  .apbif_rid           (apbif_rid          ),
  .apbif_rready        (apbif_rready       ),
  .apbif_rresp         (apbif_rresp        ),
  .apbif_rvalid        (apbif_rvalid       ),
  .apbif_wdata         (apbif_wdata        ),
  .apbif_wready        (apbif_wready       ),
  .apbif_wvalid        (apbif_wvalid       ),
  .ar_hit_wtable       (ar_hit_wtable      ),
  .araddr              (araddr             ),
  .arburst             (arburst            ),
  .arcache             (arcache            ),
  .arid                (arid               ),
  .arlen               (arlen              ),
  .arlock              (arlock             ),
  .arprot              (arprot             ),
  .arready             (arready            ),
  .arsize              (arsize             ),
  .arvalid             (arvalid            ),
  .aw_hit_wtable       (aw_hit_wtable      ),
  .awaddr              (awaddr             ),
  .awburst             (awburst            ),
  .awcache             (awcache            ),
  .awlen               (awlen              ),
  .awlock              (awlock             ),
  .awprot              (awprot             ),
  .awready             (awready            ),
  .awsize              (awsize             ),
  .awvalid             (awvalid            ),
  .biu_ifu_arready     (biu_ifu_arready    ),
  .biu_ifu_rdata       (biu_ifu_rdata      ),
  .biu_ifu_rid         (biu_ifu_rid        ),
  .biu_ifu_rlast       (biu_ifu_rlast      ),
  .biu_ifu_rresp       (biu_ifu_rresp      ),
  .biu_ifu_rvalid      (biu_ifu_rvalid     ),
  .biu_lsu_arready     (biu_lsu_arready    ),
  .biu_lsu_no_op       (biu_lsu_no_op      ),
  .biu_lsu_rdata       (biu_lsu_rdata      ),
  .biu_lsu_rid         (biu_lsu_rid        ),
  .biu_lsu_rlast       (biu_lsu_rlast      ),
  .biu_lsu_rresp       (biu_lsu_rresp      ),
  .biu_lsu_rvalid      (biu_lsu_rvalid     ),
  .biu_lsu_stb_awready (biu_lsu_stb_awready),
  .biu_lsu_stb_wready  (biu_lsu_stb_wready ),
  .biu_lsu_vb_awready  (biu_lsu_vb_awready ),
  .biu_lsu_vb_wready   (biu_lsu_vb_wready  ),
  .cp0_biu_icg_en      (cp0_biu_icg_en     ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .ifu_biu_araddr      (ifu_biu_araddr     ),
  .ifu_biu_arburst     (ifu_biu_arburst    ),
  .ifu_biu_arcache     (ifu_biu_arcache    ),
  .ifu_biu_arid        (ifu_biu_arid       ),
  .ifu_biu_arlen       (ifu_biu_arlen      ),
  .ifu_biu_arprot      (ifu_biu_arprot     ),
  .ifu_biu_arsize      (ifu_biu_arsize     ),
  .ifu_biu_arvalid     (ifu_biu_arvalid    ),
  .lsu_biu_araddr      (lsu_biu_araddr     ),
  .lsu_biu_arburst     (lsu_biu_arburst    ),
  .lsu_biu_arcache     (lsu_biu_arcache    ),
  .lsu_biu_arid        (lsu_biu_arid       ),
  .lsu_biu_arlen       (lsu_biu_arlen      ),
  .lsu_biu_arprot      (lsu_biu_arprot     ),
  .lsu_biu_arsize      (lsu_biu_arsize     ),
  .lsu_biu_aruser      (lsu_biu_aruser     ),
  .lsu_biu_arvalid     (lsu_biu_arvalid    ),
  .lsu_biu_stb_awaddr  (lsu_biu_stb_awaddr ),
  .lsu_biu_stb_awburst (lsu_biu_stb_awburst),
  .lsu_biu_stb_awcache (lsu_biu_stb_awcache),
  .lsu_biu_stb_awid    (lsu_biu_stb_awid   ),
  .lsu_biu_stb_awlen   (lsu_biu_stb_awlen  ),
  .lsu_biu_stb_awprot  (lsu_biu_stb_awprot ),
  .lsu_biu_stb_awsize  (lsu_biu_stb_awsize ),
  .lsu_biu_stb_awuser  (lsu_biu_stb_awuser ),
  .lsu_biu_stb_awvalid (lsu_biu_stb_awvalid),
  .lsu_biu_stb_wdata   (lsu_biu_stb_wdata  ),
  .lsu_biu_stb_wlast   (lsu_biu_stb_wlast  ),
  .lsu_biu_stb_wstrb   (lsu_biu_stb_wstrb  ),
  .lsu_biu_stb_wvalid  (lsu_biu_stb_wvalid ),
  .lsu_biu_vb_awaddr   (lsu_biu_vb_awaddr  ),
  .lsu_biu_vb_awburst  (lsu_biu_vb_awburst ),
  .lsu_biu_vb_awcache  (lsu_biu_vb_awcache ),
  .lsu_biu_vb_awid     (lsu_biu_vb_awid    ),
  .lsu_biu_vb_awlen    (lsu_biu_vb_awlen   ),
  .lsu_biu_vb_awprot   (lsu_biu_vb_awprot  ),
  .lsu_biu_vb_awsize   (lsu_biu_vb_awsize  ),
  .lsu_biu_vb_awvalid  (lsu_biu_vb_awvalid ),
  .lsu_biu_vb_wdata    (lsu_biu_vb_wdata   ),
  .lsu_biu_vb_wlast    (lsu_biu_vb_wlast   ),
  .lsu_biu_vb_wstrb    (lsu_biu_vb_wstrb   ),
  .lsu_biu_vb_wvalid   (lsu_biu_vb_wvalid  ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .rdata               (rdata              ),
  .rid                 (rid                ),
  .rlast               (rlast              ),
  .rresp               (rresp              ),
  .rvalid              (rvalid             ),
  .sysio_biu_apb_base  (sysio_biu_apb_base ),
  .wdata               (wdata              ),
  .wlast               (wlast              ),
  .wready              (wready             ),
  .wstrb               (wstrb              ),
  .wtable_no_op        (wtable_no_op       ),
  .wvalid              (wvalid             )
);

// &Instance("aq_biu_read_channel"); @25
aq_biu_read_channel  x_aq_biu_read_channel (
  .araddr              (araddr             ),
  .arburst             (arburst            ),
  .arcache             (arcache            ),
  .arid                (arid               ),
  .arlen               (arlen              ),
  .arlock              (arlock             ),
  .arprot              (arprot             ),
  .arready             (arready            ),
  .arsize              (arsize             ),
  .arvalid             (arvalid            ),
  .axim_clk_en         (axim_clk_en        ),
  .biu_clk             (biu_clk            ),
  .biu_pad_araddr      (biu_pad_araddr     ),
  .biu_pad_arburst     (biu_pad_arburst    ),
  .biu_pad_arcache     (biu_pad_arcache    ),
  .biu_pad_arid        (biu_pad_arid       ),
  .biu_pad_arlen       (biu_pad_arlen      ),
  .biu_pad_arlock      (biu_pad_arlock     ),
  .biu_pad_arprot      (biu_pad_arprot     ),
  .biu_pad_arsize      (biu_pad_arsize     ),
  .biu_pad_arvalid     (biu_pad_arvalid    ),
  .biu_pad_rready      (biu_pad_rready     ),
  .cp0_biu_icg_en      (cp0_biu_icg_en     ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_biu_arready     (pad_biu_arready    ),
  .pad_biu_rdata       (pad_biu_rdata      ),
  .pad_biu_rid         (pad_biu_rid        ),
  .pad_biu_rlast       (pad_biu_rlast      ),
  .pad_biu_rresp       (pad_biu_rresp      ),
  .pad_biu_rvalid      (pad_biu_rvalid     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .rdata               (rdata              ),
  .read_channel_clk_en (read_channel_clk_en),
  .rid                 (rid                ),
  .rlast               (rlast              ),
  .rresp               (rresp              ),
  .rvalid              (rvalid             )
);

// &Instance("aq_biu_write_channel"); @26
aq_biu_write_channel  x_aq_biu_write_channel (
  .ar_hit_wtable        (ar_hit_wtable       ),
  .araddr               (araddr              ),
  .arcache              (arcache             ),
  .aw_hit_wtable        (aw_hit_wtable       ),
  .awaddr               (awaddr              ),
  .awburst              (awburst             ),
  .awcache              (awcache             ),
  .awlen                (awlen               ),
  .awlock               (awlock              ),
  .awprot               (awprot              ),
  .awready              (awready             ),
  .awsize               (awsize              ),
  .awvalid              (awvalid             ),
  .axim_clk_en          (axim_clk_en         ),
  .biu_clk              (biu_clk             ),
  .biu_pad_awaddr       (biu_pad_awaddr      ),
  .biu_pad_awburst      (biu_pad_awburst     ),
  .biu_pad_awcache      (biu_pad_awcache     ),
  .biu_pad_awid         (biu_pad_awid        ),
  .biu_pad_awlen        (biu_pad_awlen       ),
  .biu_pad_awlock       (biu_pad_awlock      ),
  .biu_pad_awprot       (biu_pad_awprot      ),
  .biu_pad_awsize       (biu_pad_awsize      ),
  .biu_pad_awvalid      (biu_pad_awvalid     ),
  .biu_pad_bready       (biu_pad_bready      ),
  .biu_pad_wdata        (biu_pad_wdata       ),
  .biu_pad_wlast        (biu_pad_wlast       ),
  .biu_pad_wstrb        (biu_pad_wstrb       ),
  .biu_pad_wvalid       (biu_pad_wvalid      ),
  .cp0_biu_icg_en       (cp0_biu_icg_en      ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_biu_awready      (pad_biu_awready     ),
  .pad_biu_bid          (pad_biu_bid         ),
  .pad_biu_bresp        (pad_biu_bresp       ),
  .pad_biu_bvalid       (pad_biu_bvalid      ),
  .pad_biu_wready       (pad_biu_wready      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .wdata                (wdata               ),
  .wlast                (wlast               ),
  .wready               (wready              ),
  .write_channel_clk_en (write_channel_clk_en),
  .wstrb                (wstrb               ),
  .wtable_no_op         (wtable_no_op        ),
  .wvalid               (wvalid              )
);

// &Instance("aq_biu_apbif"); @27
aq_biu_apbif  x_aq_biu_apbif (
  .apb_clk_en         (apb_clk_en        ),
  .apbif_araddr       (apbif_araddr      ),
  .apbif_arid         (apbif_arid        ),
  .apbif_arprot       (apbif_arprot      ),
  .apbif_arready      (apbif_arready     ),
  .apbif_arvalid      (apbif_arvalid     ),
  .apbif_awaddr       (apbif_awaddr      ),
  .apbif_awid         (apbif_awid        ),
  .apbif_awprot       (apbif_awprot      ),
  .apbif_awready      (apbif_awready     ),
  .apbif_awvalid      (apbif_awvalid     ),
  .apbif_idle         (apbif_idle        ),
  .apbif_rdata        (apbif_rdata       ),
  .apbif_rid          (apbif_rid         ),
  .apbif_rready       (apbif_rready      ),
  .apbif_rresp        (apbif_rresp       ),
  .apbif_rvalid       (apbif_rvalid      ),
  .apbif_wdata        (apbif_wdata       ),
  .apbif_wready       (apbif_wready      ),
  .apbif_wvalid       (apbif_wvalid      ),
  .cp0_biu_icg_en     (cp0_biu_icg_en    ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .paddr              (paddr             ),
  .penable            (penable           ),
  .perr_clint         (perr_clint        ),
  .perr_plic          (perr_plic         ),
  .pprot              (pprot             ),
  .prdata_clint       (prdata_clint      ),
  .prdata_plic        (prdata_plic       ),
  .pready_clint       (pready_clint      ),
  .pready_plic        (pready_plic       ),
  .psel_clint         (psel_clint        ),
  .psel_plic          (psel_plic         ),
  .pwdata             (pwdata            ),
  .pwrite             (pwrite            )
);


assign biu_clk_en = read_channel_clk_en | write_channel_clk_en;

// &Instance("gated_clk_cell", "x_aq_biu_gated_clk"); @31
gated_clk_cell  x_aq_biu_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (biu_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (biu_clk_en        ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @32
//          .external_en (1'b0), @33
//          .global_en   (1'b1), @34
//          .module_en   (cp0_biu_icg_en), @35
//          .local_en    (biu_clk_en), @36
//          .clk_out     (biu_clk)); @37

//==============================================================================
//  ASSERTION
//==============================================================================
// &Force("output","biu_pad_arvalid"); @43
// &Force("output","biu_pad_awvalid"); @44
// &Force("input", "cpu_in_lowpower"); @45
// &Force("nonport", "biu_no_req"); @46
// &Force("nonport", "biu_no_resp"); @47


// &ModuleEnd; @76
endmodule



