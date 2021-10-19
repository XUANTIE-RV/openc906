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











module cpu_sub_system_axi(
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
  biu_pad_lpmd_b,
  biu_pad_retire_0,
  biu_pad_retire_pc_0,
  biu_pad_rready,
  biu_pad_wdata,
  biu_pad_wid,
  biu_pad_wlast,
  biu_pad_wstrb,
  biu_pad_wvalid,
  clk_en,
  dtm_pad_jtg_tdo,
  i_pad_jtg_tms,
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
  pad_core0_dbgrq_b,
  pad_cpu_rst_b,
  pad_dtm_jtg_tclk,
  pad_dtm_jtg_tdi,
  pad_dtm_jtg_trst_b,
  pad_yy_scan_enable,
  pad_yy_scan_mode,
  per_clk,
  pll_core_cpuclk,
  xx_intc_vld
);


input            clk_en;                 
input            i_pad_jtg_tms;          
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
input            pad_core0_dbgrq_b;      
input            pad_cpu_rst_b;          
input            pad_dtm_jtg_tclk;       
input            pad_dtm_jtg_tdi;        
input            pad_dtm_jtg_trst_b;     
input            pad_yy_scan_enable;     
input            pad_yy_scan_mode;       
input            per_clk;                
input            pll_core_cpuclk;        
input   [39 :0]  xx_intc_vld;            
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
output  [1  :0]  biu_pad_lpmd_b;         
output           biu_pad_retire_0;       
output  [39 :0]  biu_pad_retire_pc_0;    
output           biu_pad_rready;         
output  [127:0]  biu_pad_wdata;          
output  [7  :0]  biu_pad_wid;            
output           biu_pad_wlast;          
output  [15 :0]  biu_pad_wstrb;          
output           biu_pad_wvalid;         
output           dtm_pad_jtg_tdo;        




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
wire    [1  :0]  biu_pad_lpmd_b;         
wire             biu_pad_retire_0;       
wire    [39 :0]  biu_pad_retire_pc_0;    
wire             biu_pad_rready;         
wire    [127:0]  biu_pad_wdata;          
wire    [7  :0]  biu_pad_wid;            
wire             biu_pad_wlast;          
wire    [15 :0]  biu_pad_wstrb;          
wire             biu_pad_wvalid;         
wire             clk_en;                 
wire             dtm_pad_jtg_tdo;        
wire             dtm_pad_jtg_tdo_en;     
wire             i_pad_jtg_tms;          
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
wire             pad_core0_dbgrq_b;      
wire             pad_cpu_rst_b;          
wire             pad_dtm_jtg_tclk;       
wire             pad_dtm_jtg_tdi;        
wire             pad_dtm_jtg_tms;        
wire             pad_dtm_jtg_trst_b;     
wire             pad_yy_scan_enable;     
wire             pad_yy_scan_mode;       
wire             per_clk;                
wire             pll_core_cpuclk;        
wire    [39 :0]  xx_intc_int;            
wire    [39 :0]  xx_intc_vld;            


tr_axi_interconnect  x_c906_wrapper (
  .axim_clk_en             (clk_en                 ),
  .biu_pad_araddr          (biu_pad_araddr         ),
  .biu_pad_arburst         (biu_pad_arburst        ),
  .biu_pad_arcache         (biu_pad_arcache        ),
  .biu_pad_arid            (biu_pad_arid           ),
  .biu_pad_arlen           (biu_pad_arlen          ),
  .biu_pad_arlock          (biu_pad_arlock         ),
  .biu_pad_arprot          (biu_pad_arprot         ),
  .biu_pad_arsize          (biu_pad_arsize         ),
  .biu_pad_arvalid         (biu_pad_arvalid        ),
  .biu_pad_awaddr          (biu_pad_awaddr         ),
  .biu_pad_awburst         (biu_pad_awburst        ),
  .biu_pad_awcache         (biu_pad_awcache        ),
  .biu_pad_awid            (biu_pad_awid           ),
  .biu_pad_awlen           (biu_pad_awlen          ),
  .biu_pad_awlock          (biu_pad_awlock         ),
  .biu_pad_awprot          (biu_pad_awprot         ),
  .biu_pad_awsize          (biu_pad_awsize         ),
  .biu_pad_awvalid         (biu_pad_awvalid        ),
  .biu_pad_bready          (biu_pad_bready         ),
  .biu_pad_rready          (biu_pad_rready         ),
  .biu_pad_wdata           (biu_pad_wdata          ),
  .biu_pad_wid             (biu_pad_wid            ),
  .biu_pad_wlast           (biu_pad_wlast          ),
  .biu_pad_wstrb           (biu_pad_wstrb          ),
  .biu_pad_wvalid          (biu_pad_wvalid         ),
  .core0_pad_lpmd_b        (biu_pad_lpmd_b         ),
  .core0_pad_retire0       (biu_pad_retire_0       ),
  .core0_pad_retire0_pc    (biu_pad_retire_pc_0    ),
  .dtm_pad_jtg_tdo         (dtm_pad_jtg_tdo        ),
  .dtm_pad_jtg_tdo_en      (dtm_pad_jtg_tdo_en     ),
  .pad_biu_arready         (pad_biu_arready        ),
  .pad_biu_awready         (pad_biu_awready        ),
  .pad_biu_bid             (pad_biu_bid            ),
  .pad_biu_bresp           (pad_biu_bresp          ),
  .pad_biu_bvalid          (pad_biu_bvalid         ),
  .pad_biu_rdata           (pad_biu_rdata          ),
  .pad_biu_rid             (pad_biu_rid            ),
  .pad_biu_rlast           (pad_biu_rlast          ),
  .pad_biu_rresp           (pad_biu_rresp          ),
  .pad_biu_rvalid          (pad_biu_rvalid         ),
  .pad_biu_wready          (pad_biu_wready         ),
  .pad_core0_dbgrq_b       (pad_core0_dbgrq_b      ),
  .pad_core0_rst_b         (pad_cpu_rst_b          ),
  .pad_cpu_rst_b           (pad_cpu_rst_b          ),
  .pad_dtm_jtg_tclk        (pad_dtm_jtg_tclk       ),
  .pad_dtm_jtg_tdi         (pad_dtm_jtg_tdi        ),
  .pad_dtm_jtg_tms         (pad_dtm_jtg_tms        ),
  .pad_dtm_jtg_trst_b      (pad_dtm_jtg_trst_b     ),
  .pad_yy_scan_enable      (pad_yy_scan_enable     ),
  .pad_yy_scan_mode        (pad_yy_scan_mode       ),
  .per_clk                 (per_clk                ),
  .pll_core_cpuclk         (pll_core_cpuclk        ),
  .xx_intc_int             (xx_intc_int            )
);

assign xx_intc_int = xx_intc_vld;

assign pad_dtm_jtg_tms = i_pad_jtg_tms;

endmodule


