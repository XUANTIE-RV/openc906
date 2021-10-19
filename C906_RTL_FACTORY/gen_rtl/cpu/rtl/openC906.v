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

// &Depend("cpu_cfig.h"); @24
// &Depend("mp_top_golden_port.vp"); @25
// &Depend("plic_top.v"); @26
// &Depend("plic_hart_arb.v"); @27
// &Depend("plic_hreg_busif.v"); @28
// &Depend("plic_kid_busif.v"); @29
// &Depend("csky_apb_1tox_matrix.v"); @30
// &Depend("plic_arb_ctrl.v"); @31
// &Depend("plic_ctrl.v"); @32
// &Depend("plic_32to1_arb.v"); @33
// &Depend("plic_int_kid.v"); @34
// &Depend("plic_granu_arb.v"); @35
// &Depend("plic_granu2_arb.v"); @36
// &Depend("sync_level2level.v"); @37
// DM
// &Depend("tdt_define.h"); @39
// //&Depend("cpu_cfig_c906.h") @40
// //&Depend("tdt_rst.v"); @41
// &Depend("tdt_dm.v"); @42
// &Depend("tdt_sba_axi.v"); @44
// &Depend("tdt_sba_ahb.v"); @47

// &ModuleBeg; @50
module openC906(
  axim_clk_en,
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
  core0_pad_halted,
  core0_pad_lpmd_b,
  core0_pad_retire,
  core0_pad_retire_pc,
  cpu_debug_port,
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
  pad_cpu_apb_base,
  pad_cpu_rst_b,
  pad_cpu_rvba,
  pad_cpu_sys_cnt,
  pad_plic_int_cfg,
  pad_plic_int_vld,
  pad_tdt_dm_arready,
  pad_tdt_dm_awready,
  pad_tdt_dm_bid,
  pad_tdt_dm_bresp,
  pad_tdt_dm_bvalid,
  pad_tdt_dm_core_unavail,
  pad_tdt_dm_rdata,
  pad_tdt_dm_rid,
  pad_tdt_dm_rlast,
  pad_tdt_dm_rresp,
  pad_tdt_dm_rvalid,
  pad_tdt_dm_wready,
  pad_yy_dft_clk_rst_b,
  pad_yy_icg_scan_en,
  pad_yy_mbist_mode,
  pad_yy_scan_enable,
  pad_yy_scan_mode,
  pad_yy_scan_rst_b,
  pll_core_cpuclk,
  sys_apb_clk,
  sys_apb_rst_b,
  tdt_dm_pad_araddr,
  tdt_dm_pad_arburst,
  tdt_dm_pad_arcache,
  tdt_dm_pad_arid,
  tdt_dm_pad_arlen,
  tdt_dm_pad_arlock,
  tdt_dm_pad_arprot,
  tdt_dm_pad_arsize,
  tdt_dm_pad_arvalid,
  tdt_dm_pad_awaddr,
  tdt_dm_pad_awburst,
  tdt_dm_pad_awcache,
  tdt_dm_pad_awid,
  tdt_dm_pad_awlen,
  tdt_dm_pad_awlock,
  tdt_dm_pad_awprot,
  tdt_dm_pad_awsize,
  tdt_dm_pad_awvalid,
  tdt_dm_pad_bready,
  tdt_dm_pad_hartreset_n,
  tdt_dm_pad_ndmreset_n,
  tdt_dm_pad_rready,
  tdt_dm_pad_wdata,
  tdt_dm_pad_wlast,
  tdt_dm_pad_wstrb,
  tdt_dm_pad_wvalid,
  tdt_dmi_paddr,
  tdt_dmi_penable,
  tdt_dmi_prdata,
  tdt_dmi_pready,
  tdt_dmi_psel,
  tdt_dmi_pslverr,
  tdt_dmi_pwdata,
  tdt_dmi_pwrite
);

// &Ports("compare", "../../../gen_rtl/cpu/rtl/mp_top_golden_port.v"); @51
input            axim_clk_en;                     
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
input   [39 :0]  pad_cpu_apb_base;                
input            pad_cpu_rst_b;                   
input   [39 :0]  pad_cpu_rvba;                    
input   [63 :0]  pad_cpu_sys_cnt;                 
input   [239:0]  pad_plic_int_cfg;                
input   [239:0]  pad_plic_int_vld;                
input            pad_tdt_dm_arready;              
input            pad_tdt_dm_awready;              
input   [3  :0]  pad_tdt_dm_bid;                  
input   [1  :0]  pad_tdt_dm_bresp;                
input            pad_tdt_dm_bvalid;               
input            pad_tdt_dm_core_unavail;         
input   [127:0]  pad_tdt_dm_rdata;                
input   [3  :0]  pad_tdt_dm_rid;                  
input            pad_tdt_dm_rlast;                
input   [1  :0]  pad_tdt_dm_rresp;                
input            pad_tdt_dm_rvalid;               
input            pad_tdt_dm_wready;               
input            pad_yy_dft_clk_rst_b;            
input            pad_yy_icg_scan_en;              
input            pad_yy_mbist_mode;               
input            pad_yy_scan_enable;              
input            pad_yy_scan_mode;                
input            pad_yy_scan_rst_b;               
input            pll_core_cpuclk;                 
input            sys_apb_clk;                     
input            sys_apb_rst_b;                   
input   [11 :0]  tdt_dmi_paddr;                   
input            tdt_dmi_penable;                 
input            tdt_dmi_psel;                    
input   [31 :0]  tdt_dmi_pwdata;                  
input            tdt_dmi_pwrite;                  
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
output           core0_pad_halted;                
output  [1  :0]  core0_pad_lpmd_b;                
output           core0_pad_retire;                
output  [39 :0]  core0_pad_retire_pc;             
output           cpu_debug_port;                  
output  [39 :0]  tdt_dm_pad_araddr;               
output  [1  :0]  tdt_dm_pad_arburst;              
output  [3  :0]  tdt_dm_pad_arcache;              
output  [3  :0]  tdt_dm_pad_arid;                 
output  [3  :0]  tdt_dm_pad_arlen;                
output           tdt_dm_pad_arlock;               
output  [2  :0]  tdt_dm_pad_arprot;               
output  [2  :0]  tdt_dm_pad_arsize;               
output           tdt_dm_pad_arvalid;              
output  [39 :0]  tdt_dm_pad_awaddr;               
output  [1  :0]  tdt_dm_pad_awburst;              
output  [3  :0]  tdt_dm_pad_awcache;              
output  [3  :0]  tdt_dm_pad_awid;                 
output  [3  :0]  tdt_dm_pad_awlen;                
output           tdt_dm_pad_awlock;               
output  [2  :0]  tdt_dm_pad_awprot;               
output  [2  :0]  tdt_dm_pad_awsize;               
output           tdt_dm_pad_awvalid;              
output           tdt_dm_pad_bready;               
output           tdt_dm_pad_hartreset_n;          
output           tdt_dm_pad_ndmreset_n;           
output           tdt_dm_pad_rready;               
output  [127:0]  tdt_dm_pad_wdata;                
output           tdt_dm_pad_wlast;                
output  [15 :0]  tdt_dm_pad_wstrb;                
output           tdt_dm_pad_wvalid;               
output  [31 :0]  tdt_dmi_prdata;                  
output           tdt_dmi_pready;                  
output           tdt_dmi_pslverr;                 

//&Ports;
// &Regs; @53

// &Wires; @54
wire             apb_clk;                         
wire             apb_clk_en;                      
wire             axim_clk_en;                     
wire             axim_clk_en_f;                   
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
wire             ciu_rst_b;                       
wire             clint_core0_ms_int;              
wire             clint_core0_mt_int;              
wire             clint_core0_ss_int;              
wire             clint_core0_st_int;              
wire    [63 :0]  clint_core0_time;                
wire             clkgen_rst_b;                    
wire             core0_cpu_no_retire;             
wire             core0_pad_halted;                
wire    [1  :0]  core0_pad_lpmd_b;                
wire             core0_pad_retire;                
wire    [39 :0]  core0_pad_retire_pc;             
wire             core0_rst_b;                     
wire    [1  :0]  core0_sysio_lpmd_b;              
wire             cp0_biu_icg_en;                  
wire             cpu_debug_port;                  
wire             dtu_tdt_dm_halted;               
wire             dtu_tdt_dm_havereset;            
wire             dtu_tdt_dm_itr_done;             
wire             dtu_tdt_dm_retire_debug_expt_vld; 
wire    [63 :0]  dtu_tdt_dm_rx_data;              
wire             dtu_tdt_dm_wr_ready;             
wire             forever_cpuclk;                  
wire    [39 :0]  ifu_biu_araddr;                  
wire    [1  :0]  ifu_biu_arburst;                 
wire    [3  :0]  ifu_biu_arcache;                 
wire             ifu_biu_arid;                    
wire    [1  :0]  ifu_biu_arlen;                   
wire    [2  :0]  ifu_biu_arprot;                  
wire    [2  :0]  ifu_biu_arsize;                  
wire             ifu_biu_arvalid;                 
wire             l2c_plic_ecc_int_vld;            
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
wire    [39 :0]  pad_cpu_apb_base;                
wire             pad_cpu_rst_b;                   
wire    [39 :0]  pad_cpu_rvba;                    
wire    [63 :0]  pad_cpu_sys_cnt;                 
wire    [239:0]  pad_plic_int_cfg;                
wire    [239:0]  pad_plic_int_vld;                
wire             pad_tdt_dm_arready;              
wire             pad_tdt_dm_awready;              
wire    [3  :0]  pad_tdt_dm_bid;                  
wire    [1  :0]  pad_tdt_dm_bresp;                
wire             pad_tdt_dm_bvalid;               
wire             pad_tdt_dm_core_unavail;         
wire    [127:0]  pad_tdt_dm_rdata;                
wire    [3  :0]  pad_tdt_dm_rid;                  
wire             pad_tdt_dm_rlast;                
wire    [1  :0]  pad_tdt_dm_rresp;                
wire             pad_tdt_dm_rvalid;               
wire             pad_tdt_dm_wready;               
wire             pad_yy_dft_clk_rst_b;            
wire             pad_yy_icg_scan_en;              
wire             pad_yy_mbist_mode;               
wire             pad_yy_scan_mode;                
wire             pad_yy_scan_rst_b;               
wire    [31 :0]  paddr;                           
wire             penable;                         
wire             perr_clint;                      
wire             perr_plic;                       
wire             plic_core0_me_int;               
wire             plic_core0_se_int;               
wire    [0  :0]  plic_hartx_mint_req;             
wire    [0  :0]  plic_hartx_sint_req;             
wire    [255:0]  plic_int_cfg;                    
wire    [255:0]  plic_int_vld;                    
wire             pll_core_cpuclk;                 
wire    [1  :0]  pprot;                           
wire    [31 :0]  prdata_clint;                    
wire    [31 :0]  prdata_plic;                     
wire             pready_clint;                    
wire             pready_plic;                     
wire             psel_clint;                      
wire             psel_plic;                       
wire    [31 :0]  pwdata;                          
wire             pwrite;                          
wire             sync_sys_apb_rst_b;              
wire             sys_apb_clk;                     
wire             sys_apb_rst_b;                   
wire    [39 :0]  sysio_biu_apb_base;              
wire    [63 :0]  sysio_clint_mtime;               
wire    [2  :0]  sysio_core0_hartid;              
wire             sysio_core0_me_int;              
wire             sysio_core0_ms_int;              
wire             sysio_core0_mt_int;              
wire             sysio_core0_se_int;              
wire             sysio_core0_ss_int;              
wire             sysio_core0_st_int;              
wire    [39 :0]  sysio_cp0_apb_base;              
wire    [39 :0]  sysio_xx_rvba;                   
wire             tdt_dm_dtu_ack_havereset;        
wire             tdt_dm_dtu_async_halt_req;       
wire             tdt_dm_dtu_halt_on_reset;        
wire             tdt_dm_dtu_halt_req;             
wire    [1  :0]  tdt_dm_dtu_halt_req_cause;       
wire    [31 :0]  tdt_dm_dtu_itr;                  
wire             tdt_dm_dtu_itr_vld;              
wire             tdt_dm_dtu_resume_req;           
wire    [63 :0]  tdt_dm_dtu_wdata;                
wire    [1  :0]  tdt_dm_dtu_wr_flg;               
wire             tdt_dm_dtu_wr_vld;               
wire    [39 :0]  tdt_dm_pad_araddr;               
wire    [1  :0]  tdt_dm_pad_arburst;              
wire    [3  :0]  tdt_dm_pad_arcache;              
wire    [3  :0]  tdt_dm_pad_arid;                 
wire    [3  :0]  tdt_dm_pad_arlen;                
wire             tdt_dm_pad_arlock;               
wire    [2  :0]  tdt_dm_pad_arprot;               
wire    [2  :0]  tdt_dm_pad_arsize;               
wire             tdt_dm_pad_arvalid;              
wire    [39 :0]  tdt_dm_pad_awaddr;               
wire    [1  :0]  tdt_dm_pad_awburst;              
wire    [3  :0]  tdt_dm_pad_awcache;              
wire    [3  :0]  tdt_dm_pad_awid;                 
wire    [3  :0]  tdt_dm_pad_awlen;                
wire             tdt_dm_pad_awlock;               
wire    [2  :0]  tdt_dm_pad_awprot;               
wire    [2  :0]  tdt_dm_pad_awsize;               
wire             tdt_dm_pad_awvalid;              
wire             tdt_dm_pad_bready;               
wire             tdt_dm_pad_hartreset_n;          
wire             tdt_dm_pad_ndmreset_n;           
wire             tdt_dm_pad_rready;               
wire    [127:0]  tdt_dm_pad_wdata;                
wire             tdt_dm_pad_wlast;                
wire    [15 :0]  tdt_dm_pad_wstrb;                
wire             tdt_dm_pad_wvalid;               
wire    [11 :0]  tdt_dmi_paddr;                   
wire             tdt_dmi_penable;                 
wire    [31 :0]  tdt_dmi_prdata;                  
wire             tdt_dmi_pready;                  
wire             tdt_dmi_psel;                    
wire             tdt_dmi_pslverr;                 
wire    [31 :0]  tdt_dmi_pwdata;                  
wire             tdt_dmi_pwrite;                  



//==========================================================
//  Instance top module
//==========================================================
// &Force("output", "core0_pad_lpmd_b"); @60
// &ConnRule(s/cpuio_/core0_/); @61
// &ConnRule(s/rtu_/core0_/); @62
// &ConnRule(s/vpu_/core0_/); @63
// //&ConnRule(s/^hpcp_/hpcp0_/); @64
// &ConnRule(s/^x_/core0_/); @65
// &Instance("aq_top", "x_aq_top_0"); @66
aq_top  x_aq_top_0 (
  .biu_ifu_arready                  (biu_ifu_arready                 ),
  .biu_ifu_rdata                    (biu_ifu_rdata                   ),
  .biu_ifu_rid                      (biu_ifu_rid                     ),
  .biu_ifu_rlast                    (biu_ifu_rlast                   ),
  .biu_ifu_rresp                    (biu_ifu_rresp                   ),
  .biu_ifu_rvalid                   (biu_ifu_rvalid                  ),
  .biu_lsu_arready                  (biu_lsu_arready                 ),
  .biu_lsu_no_op                    (biu_lsu_no_op                   ),
  .biu_lsu_rdata                    (biu_lsu_rdata                   ),
  .biu_lsu_rid                      (biu_lsu_rid                     ),
  .biu_lsu_rlast                    (biu_lsu_rlast                   ),
  .biu_lsu_rresp                    (biu_lsu_rresp                   ),
  .biu_lsu_rvalid                   (biu_lsu_rvalid                  ),
  .biu_lsu_stb_awready              (biu_lsu_stb_awready             ),
  .biu_lsu_stb_wready               (biu_lsu_stb_wready              ),
  .biu_lsu_vb_awready               (biu_lsu_vb_awready              ),
  .biu_lsu_vb_wready                (biu_lsu_vb_wready               ),
  .clint_cpuio_time                 (clint_core0_time                ),
  .cp0_biu_icg_en                   (cp0_biu_icg_en                  ),
  .cpuio_sysio_lpmd_b               (core0_sysio_lpmd_b              ),
  .cpurst_b                         (core0_rst_b                     ),
  .dtu_tdt_dm_halted                (dtu_tdt_dm_halted               ),
  .dtu_tdt_dm_havereset             (dtu_tdt_dm_havereset            ),
  .dtu_tdt_dm_itr_done              (dtu_tdt_dm_itr_done             ),
  .dtu_tdt_dm_retire_debug_expt_vld (dtu_tdt_dm_retire_debug_expt_vld),
  .dtu_tdt_dm_rx_data               (dtu_tdt_dm_rx_data              ),
  .dtu_tdt_dm_wr_ready              (dtu_tdt_dm_wr_ready             ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .ifu_biu_araddr                   (ifu_biu_araddr                  ),
  .ifu_biu_arburst                  (ifu_biu_arburst                 ),
  .ifu_biu_arcache                  (ifu_biu_arcache                 ),
  .ifu_biu_arid                     (ifu_biu_arid                    ),
  .ifu_biu_arlen                    (ifu_biu_arlen                   ),
  .ifu_biu_arprot                   (ifu_biu_arprot                  ),
  .ifu_biu_arsize                   (ifu_biu_arsize                  ),
  .ifu_biu_arvalid                  (ifu_biu_arvalid                 ),
  .lsu_biu_araddr                   (lsu_biu_araddr                  ),
  .lsu_biu_arburst                  (lsu_biu_arburst                 ),
  .lsu_biu_arcache                  (lsu_biu_arcache                 ),
  .lsu_biu_arid                     (lsu_biu_arid                    ),
  .lsu_biu_arlen                    (lsu_biu_arlen                   ),
  .lsu_biu_arprot                   (lsu_biu_arprot                  ),
  .lsu_biu_arsize                   (lsu_biu_arsize                  ),
  .lsu_biu_aruser                   (lsu_biu_aruser                  ),
  .lsu_biu_arvalid                  (lsu_biu_arvalid                 ),
  .lsu_biu_stb_awaddr               (lsu_biu_stb_awaddr              ),
  .lsu_biu_stb_awburst              (lsu_biu_stb_awburst             ),
  .lsu_biu_stb_awcache              (lsu_biu_stb_awcache             ),
  .lsu_biu_stb_awid                 (lsu_biu_stb_awid                ),
  .lsu_biu_stb_awlen                (lsu_biu_stb_awlen               ),
  .lsu_biu_stb_awprot               (lsu_biu_stb_awprot              ),
  .lsu_biu_stb_awsize               (lsu_biu_stb_awsize              ),
  .lsu_biu_stb_awuser               (lsu_biu_stb_awuser              ),
  .lsu_biu_stb_awvalid              (lsu_biu_stb_awvalid             ),
  .lsu_biu_stb_wdata                (lsu_biu_stb_wdata               ),
  .lsu_biu_stb_wlast                (lsu_biu_stb_wlast               ),
  .lsu_biu_stb_wstrb                (lsu_biu_stb_wstrb               ),
  .lsu_biu_stb_wvalid               (lsu_biu_stb_wvalid              ),
  .lsu_biu_vb_awaddr                (lsu_biu_vb_awaddr               ),
  .lsu_biu_vb_awburst               (lsu_biu_vb_awburst              ),
  .lsu_biu_vb_awcache               (lsu_biu_vb_awcache              ),
  .lsu_biu_vb_awid                  (lsu_biu_vb_awid                 ),
  .lsu_biu_vb_awlen                 (lsu_biu_vb_awlen                ),
  .lsu_biu_vb_awprot                (lsu_biu_vb_awprot               ),
  .lsu_biu_vb_awsize                (lsu_biu_vb_awsize               ),
  .lsu_biu_vb_awvalid               (lsu_biu_vb_awvalid              ),
  .lsu_biu_vb_wdata                 (lsu_biu_vb_wdata                ),
  .lsu_biu_vb_wlast                 (lsu_biu_vb_wlast                ),
  .lsu_biu_vb_wstrb                 (lsu_biu_vb_wstrb                ),
  .lsu_biu_vb_wvalid                (lsu_biu_vb_wvalid               ),
  .pad_biu_coreid                   (sysio_core0_hartid              ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .pad_yy_scan_mode                 (pad_yy_scan_mode                ),
  .rtu_cpu_no_retire                (core0_cpu_no_retire             ),
  .rtu_pad_halted                   (core0_pad_halted                ),
  .rtu_pad_retire                   (core0_pad_retire                ),
  .rtu_pad_retire_pc                (core0_pad_retire_pc             ),
  .sys_apb_clk                      (sys_apb_clk                     ),
  .sys_apb_rst_b                    (sync_sys_apb_rst_b              ),
  .sysio_cp0_apb_base               (sysio_cp0_apb_base              ),
  .sysio_cpuio_me_int               (sysio_core0_me_int              ),
  .sysio_cpuio_ms_int               (sysio_core0_ms_int              ),
  .sysio_cpuio_mt_int               (sysio_core0_mt_int              ),
  .sysio_cpuio_se_int               (sysio_core0_se_int              ),
  .sysio_cpuio_ss_int               (sysio_core0_ss_int              ),
  .sysio_cpuio_st_int               (sysio_core0_st_int              ),
  .sysio_xx_rvba                    (sysio_xx_rvba                   ),
  .tdt_dm_dtu_ack_havereset         (tdt_dm_dtu_ack_havereset        ),
  .tdt_dm_dtu_async_halt_req        (tdt_dm_dtu_async_halt_req       ),
  .tdt_dm_dtu_halt_on_reset         (tdt_dm_dtu_halt_on_reset        ),
  .tdt_dm_dtu_halt_req              (tdt_dm_dtu_halt_req             ),
  .tdt_dm_dtu_itr                   (tdt_dm_dtu_itr                  ),
  .tdt_dm_dtu_itr_vld               (tdt_dm_dtu_itr_vld              ),
  .tdt_dm_dtu_resume_req            (tdt_dm_dtu_resume_req           ),
  .tdt_dm_dtu_wdata                 (tdt_dm_dtu_wdata                ),
  .tdt_dm_dtu_wr_flg                (tdt_dm_dtu_wr_flg               ),
  .tdt_dm_dtu_wr_vld                (tdt_dm_dtu_wr_vld               )
);

// &Connect(.cpurst_b           (core0_rst_b )); @67
// &Connect(.sys_apb_rst_b      (sync_sys_apb_rst_b)); @68
// &Connect(.pad_biu_coreid     (sysio_core0_hartid)); @69
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @70

//==========================================================
//  Instance biu_top
//==========================================================
// &Instance("aq_biu_top"); @75
aq_biu_top  x_aq_biu_top (
  .apb_clk_en          (apb_clk_en         ),
  .axim_clk_en         (axim_clk_en_f      ),
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
  .biu_pad_araddr      (biu_pad_araddr     ),
  .biu_pad_arburst     (biu_pad_arburst    ),
  .biu_pad_arcache     (biu_pad_arcache    ),
  .biu_pad_arid        (biu_pad_arid       ),
  .biu_pad_arlen       (biu_pad_arlen      ),
  .biu_pad_arlock      (biu_pad_arlock     ),
  .biu_pad_arprot      (biu_pad_arprot     ),
  .biu_pad_arsize      (biu_pad_arsize     ),
  .biu_pad_arvalid     (biu_pad_arvalid    ),
  .biu_pad_awaddr      (biu_pad_awaddr     ),
  .biu_pad_awburst     (biu_pad_awburst    ),
  .biu_pad_awcache     (biu_pad_awcache    ),
  .biu_pad_awid        (biu_pad_awid       ),
  .biu_pad_awlen       (biu_pad_awlen      ),
  .biu_pad_awlock      (biu_pad_awlock     ),
  .biu_pad_awprot      (biu_pad_awprot     ),
  .biu_pad_awsize      (biu_pad_awsize     ),
  .biu_pad_awvalid     (biu_pad_awvalid    ),
  .biu_pad_bready      (biu_pad_bready     ),
  .biu_pad_rready      (biu_pad_rready     ),
  .biu_pad_wdata       (biu_pad_wdata      ),
  .biu_pad_wlast       (biu_pad_wlast      ),
  .biu_pad_wstrb       (biu_pad_wstrb      ),
  .biu_pad_wvalid      (biu_pad_wvalid     ),
  .cp0_biu_icg_en      (cp0_biu_icg_en     ),
  .cpurst_b            (ciu_rst_b          ),
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
  .pad_biu_arready     (pad_biu_arready    ),
  .pad_biu_awready     (pad_biu_awready    ),
  .pad_biu_bid         (pad_biu_bid        ),
  .pad_biu_bresp       (pad_biu_bresp      ),
  .pad_biu_bvalid      (pad_biu_bvalid     ),
  .pad_biu_rdata       (pad_biu_rdata      ),
  .pad_biu_rid         (pad_biu_rid        ),
  .pad_biu_rlast       (pad_biu_rlast      ),
  .pad_biu_rresp       (pad_biu_rresp      ),
  .pad_biu_rvalid      (pad_biu_rvalid     ),
  .pad_biu_wready      (pad_biu_wready     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .paddr               (paddr              ),
  .penable             (penable            ),
  .perr_clint          (perr_clint         ),
  .perr_plic           (perr_plic          ),
  .pprot               (pprot              ),
  .prdata_clint        (prdata_clint       ),
  .prdata_plic         (prdata_plic        ),
  .pready_clint        (pready_clint       ),
  .pready_plic         (pready_plic        ),
  .psel_clint          (psel_clint         ),
  .psel_plic           (psel_plic          ),
  .pwdata              (pwdata             ),
  .pwrite              (pwrite             ),
  .sysio_biu_apb_base  (sysio_biu_apb_base )
);

// &Connect(.axim_clk_en    (axim_clk_en_f)); @76
// &Connect(.cpurst_b       (ciu_rst_b )); @77
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @78

//==========================================================
//  Instance aq_reset_top sub module 
//==========================================================
// &Instance("aq_mp_rst_top"); @83
aq_mp_rst_top  x_aq_mp_rst_top (
  .ciu_rst_b            (ciu_rst_b           ),
  .clkgen_rst_b         (clkgen_rst_b        ),
  .core0_rst_b          (core0_rst_b         ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_cpu_rst_b        (pad_cpu_rst_b       ),
  .pad_yy_dft_clk_rst_b (pad_yy_dft_clk_rst_b),
  .pad_yy_mbist_mode    (pad_yy_mbist_mode   ),
  .pad_yy_scan_mode     (pad_yy_scan_mode    ),
  .pad_yy_scan_rst_b    (pad_yy_scan_rst_b   ),
  .sync_sys_apb_rst_b   (sync_sys_apb_rst_b  ),
  .sys_apb_clk          (sys_apb_clk         ),
  .sys_apb_rst_b        (sys_apb_rst_b       )
);


//==========================================================
//  Instance aq_clk_top sub module 
//==========================================================
// &Instance("aq_mp_clk_top"); @88
aq_mp_clk_top  x_aq_mp_clk_top (
  .apb_clk            (apb_clk           ),
  .apb_clk_en         (apb_clk_en        ),
  .axim_clk_en        (axim_clk_en       ),
  .axim_clk_en_f      (axim_clk_en_f     ),
  .clkgen_rst_b       (clkgen_rst_b      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_scan_mode   (pad_yy_scan_mode  ),
  .pll_core_cpuclk    (pll_core_cpuclk   )
);

// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @89

//==========================================================
//         sysio
//==========================================================
// &Instance("aq_sysio_top"); @94
aq_sysio_top  x_aq_sysio_top (
  .apb_clk_en           (apb_clk_en          ),
  .axim_clk_en          (axim_clk_en_f       ),
  .clint_core0_ms_int   (clint_core0_ms_int  ),
  .clint_core0_mt_int   (clint_core0_mt_int  ),
  .clint_core0_ss_int   (clint_core0_ss_int  ),
  .clint_core0_st_int   (clint_core0_st_int  ),
  .core0_pad_lpmd_b     (core0_pad_lpmd_b    ),
  .core0_sysio_lpmd_b   (core0_sysio_lpmd_b  ),
  .cpurst_b             (ciu_rst_b           ),
  .forever_cpuclk       (forever_cpuclk      ),
  .l2c_plic_ecc_int_vld (l2c_plic_ecc_int_vld),
  .pad_cpu_apb_base     (pad_cpu_apb_base    ),
  .pad_cpu_rvba         (pad_cpu_rvba        ),
  .pad_cpu_sys_cnt      (pad_cpu_sys_cnt     ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .plic_core0_me_int    (plic_core0_me_int   ),
  .plic_core0_se_int    (plic_core0_se_int   ),
  .sysio_biu_apb_base   (sysio_biu_apb_base  ),
  .sysio_clint_mtime    (sysio_clint_mtime   ),
  .sysio_core0_hartid   (sysio_core0_hartid  ),
  .sysio_core0_me_int   (sysio_core0_me_int  ),
  .sysio_core0_ms_int   (sysio_core0_ms_int  ),
  .sysio_core0_mt_int   (sysio_core0_mt_int  ),
  .sysio_core0_se_int   (sysio_core0_se_int  ),
  .sysio_core0_ss_int   (sysio_core0_ss_int  ),
  .sysio_core0_st_int   (sysio_core0_st_int  ),
  .sysio_cp0_apb_base   (sysio_cp0_apb_base  ),
  .sysio_xx_rvba        (sysio_xx_rvba       )
);

// &Connect(.axim_clk_en    (axim_clk_en_f)); @95
// &Connect(.cpurst_b       (ciu_rst_b )); @96
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @97

//==========================================================
//          TDT
//==========================================================
// &Instance("tdt_top"); @102
tdt_top  x_tdt_top (
  .ciu_rst_b                        (ciu_rst_b                       ),
  .dtu_tdt_dm_halted                (dtu_tdt_dm_halted               ),
  .dtu_tdt_dm_havereset             (dtu_tdt_dm_havereset            ),
  .dtu_tdt_dm_itr_done              (dtu_tdt_dm_itr_done             ),
  .dtu_tdt_dm_retire_debug_expt_vld (dtu_tdt_dm_retire_debug_expt_vld),
  .dtu_tdt_dm_rx_data               (dtu_tdt_dm_rx_data              ),
  .dtu_tdt_dm_wr_ready              (dtu_tdt_dm_wr_ready             ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .pad_tdt_dm_arready               (pad_tdt_dm_arready              ),
  .pad_tdt_dm_awready               (pad_tdt_dm_awready              ),
  .pad_tdt_dm_bid                   (pad_tdt_dm_bid                  ),
  .pad_tdt_dm_bresp                 (pad_tdt_dm_bresp                ),
  .pad_tdt_dm_bvalid                (pad_tdt_dm_bvalid               ),
  .pad_tdt_dm_core_unavail          (pad_tdt_dm_core_unavail         ),
  .pad_tdt_dm_rdata                 (pad_tdt_dm_rdata                ),
  .pad_tdt_dm_rid                   (pad_tdt_dm_rid                  ),
  .pad_tdt_dm_rlast                 (pad_tdt_dm_rlast                ),
  .pad_tdt_dm_rresp                 (pad_tdt_dm_rresp                ),
  .pad_tdt_dm_rvalid                (pad_tdt_dm_rvalid               ),
  .pad_tdt_dm_wready                (pad_tdt_dm_wready               ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .pad_yy_scan_mode                 (pad_yy_scan_mode                ),
  .pad_yy_scan_rst_b                (pad_yy_scan_rst_b               ),
  .sys_apb_clk                      (sys_apb_clk                     ),
  .sys_apb_rst_b                    (sync_sys_apb_rst_b              ),
  .sys_bus_clk_en                   (axim_clk_en_f                   ),
  .tdt_dm_dtu_ack_havereset         (tdt_dm_dtu_ack_havereset        ),
  .tdt_dm_dtu_async_halt_req        (tdt_dm_dtu_async_halt_req       ),
  .tdt_dm_dtu_halt_on_reset         (tdt_dm_dtu_halt_on_reset        ),
  .tdt_dm_dtu_halt_req              (tdt_dm_dtu_halt_req             ),
  .tdt_dm_dtu_halt_req_cause        (tdt_dm_dtu_halt_req_cause       ),
  .tdt_dm_dtu_itr                   (tdt_dm_dtu_itr                  ),
  .tdt_dm_dtu_itr_vld               (tdt_dm_dtu_itr_vld              ),
  .tdt_dm_dtu_resume_req            (tdt_dm_dtu_resume_req           ),
  .tdt_dm_dtu_wdata                 (tdt_dm_dtu_wdata                ),
  .tdt_dm_dtu_wr_flg                (tdt_dm_dtu_wr_flg               ),
  .tdt_dm_dtu_wr_vld                (tdt_dm_dtu_wr_vld               ),
  .tdt_dm_pad_araddr                (tdt_dm_pad_araddr               ),
  .tdt_dm_pad_arburst               (tdt_dm_pad_arburst              ),
  .tdt_dm_pad_arcache               (tdt_dm_pad_arcache              ),
  .tdt_dm_pad_arid                  (tdt_dm_pad_arid                 ),
  .tdt_dm_pad_arlen                 (tdt_dm_pad_arlen                ),
  .tdt_dm_pad_arlock                (tdt_dm_pad_arlock               ),
  .tdt_dm_pad_arprot                (tdt_dm_pad_arprot               ),
  .tdt_dm_pad_arsize                (tdt_dm_pad_arsize               ),
  .tdt_dm_pad_arvalid               (tdt_dm_pad_arvalid              ),
  .tdt_dm_pad_awaddr                (tdt_dm_pad_awaddr               ),
  .tdt_dm_pad_awburst               (tdt_dm_pad_awburst              ),
  .tdt_dm_pad_awcache               (tdt_dm_pad_awcache              ),
  .tdt_dm_pad_awid                  (tdt_dm_pad_awid                 ),
  .tdt_dm_pad_awlen                 (tdt_dm_pad_awlen                ),
  .tdt_dm_pad_awlock                (tdt_dm_pad_awlock               ),
  .tdt_dm_pad_awprot                (tdt_dm_pad_awprot               ),
  .tdt_dm_pad_awsize                (tdt_dm_pad_awsize               ),
  .tdt_dm_pad_awvalid               (tdt_dm_pad_awvalid              ),
  .tdt_dm_pad_bready                (tdt_dm_pad_bready               ),
  .tdt_dm_pad_hartreset_n           (tdt_dm_pad_hartreset_n          ),
  .tdt_dm_pad_ndmreset_n            (tdt_dm_pad_ndmreset_n           ),
  .tdt_dm_pad_rready                (tdt_dm_pad_rready               ),
  .tdt_dm_pad_wdata                 (tdt_dm_pad_wdata                ),
  .tdt_dm_pad_wlast                 (tdt_dm_pad_wlast                ),
  .tdt_dm_pad_wstrb                 (tdt_dm_pad_wstrb                ),
  .tdt_dm_pad_wvalid                (tdt_dm_pad_wvalid               ),
  .tdt_dmi_paddr                    (tdt_dmi_paddr                   ),
  .tdt_dmi_penable                  (tdt_dmi_penable                 ),
  .tdt_dmi_prdata                   (tdt_dmi_prdata                  ),
  .tdt_dmi_pready                   (tdt_dmi_pready                  ),
  .tdt_dmi_psel                     (tdt_dmi_psel                    ),
  .tdt_dmi_pslverr                  (tdt_dmi_pslverr                 ),
  .tdt_dmi_pwdata                   (tdt_dmi_pwdata                  ),
  .tdt_dmi_pwrite                   (tdt_dmi_pwrite                  )
);

// &Connect(.sys_apb_clk (sys_apb_clk)); @103
// &Connect(.sys_apb_rst_b (sync_sys_apb_rst_b)); @104
// &Connect(.sys_bus_clk_en    (axim_clk_en_f)); @105

// &Force("nonport", "tdt_dm_dtu_halt_req_cause"); @107
//scan chain
//TODO: make sure whether to delete this pin?!!
// &Force("input","pad_yy_scan_enable"); @110

//==========================================================
//  Instance clint_top
//==========================================================
// &Instance("clint_top"); @115
clint_top  x_clint_top (
  .apb_clk_en         (apb_clk_en        ),
  .ciu_clk            (forever_cpuclk    ),
  .clint_core0_ms_int (clint_core0_ms_int),
  .clint_core0_mt_int (clint_core0_mt_int),
  .clint_core0_ss_int (clint_core0_ss_int),
  .clint_core0_st_int (clint_core0_st_int),
  .clint_core0_time   (clint_core0_time  ),
  .cpurst_b           (ciu_rst_b         ),
  .forever_apbclk     (apb_clk           ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .paddr              (paddr             ),
  .penable            (penable           ),
  .perr_clint         (perr_clint        ),
  .pprot              (pprot             ),
  .prdata_clint       (prdata_clint      ),
  .pready_clint       (pready_clint      ),
  .psel_clint         (psel_clint        ),
  .pwdata             (pwdata            ),
  .pwrite             (pwrite            ),
  .sysio_clint_mtime  (sysio_clint_mtime )
);

// &Connect(.forever_apbclk (apb_clk )); @116
// &Connect(.cpurst_b       (ciu_rst_b )); @117
// &Connect(.ciu_clk        (forever_cpuclk)); @118

//==========================================================
//  Instance plic_top
//==========================================================
plic_top #(.INT_NUM(`PLIC_INT_NUM+16),
              .HART_NUM(`PLIC_HART_NUM),
              .ID_NUM(`PLIC_ID_NUM),
              .PRIO_BIT(`PLIC_PRIO_BIT),
              .MAX_HART_NUM(`MAX_HART_NUM)) x_aq_plic_top(
  .plic_hartx_mint_req    (plic_hartx_mint_req  ),
  .plic_hartx_sint_req    (plic_hartx_sint_req  ),
  .ciu_plic_paddr         (paddr[26:0]          ),
  .ciu_plic_penable       (penable              ),
  .ciu_plic_psel          (psel_plic            ),
  .ciu_plic_pprot         (pprot                ),
  .ciu_plic_pwdata        (pwdata               ),
  .ciu_plic_pwrite        (pwrite               ),
  .pad_plic_int_vld       (plic_int_vld         ),
  .pad_plic_int_cfg       (plic_int_cfg         ),
  .ciu_plic_icg_en        (1'b0                 ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en   ),
  .plic_ciu_prdata        (prdata_plic          ),
  .plic_ciu_pready        (pready_plic          ),
  .plic_ciu_pslverr       (perr_plic            ),
  .plic_clk               (apb_clk              ),
  .plicrst_b              (ciu_rst_b            )
);
// &Force("input","pad_plic_int_vld"); @147
// &Force("bus","pad_plic_int_vld",`PLIC_INT_NUM-1,0); @148
// &Force("input","pad_plic_int_cfg"); @149
// &Force("bus","pad_plic_int_cfg",`PLIC_INT_NUM-1,0); @150
// &Force("nonport","plic_hartx_mint_req"); @151
// &Force("nonport","plic_hartx_sint_req"); @152
// &Force("nonport","perr_plic"); @153
// &Force("nonport","prdata_plic"); @154
// &Force("nonport","pready_plic"); @155
// &Force("nonport","psel_plic"); @156
// &Force("nonport","plic_int_vld"); @157
// &Force("nonport","plic_int_cfg"); @158
assign plic_int_vld[`PLIC_INT_NUM+15:0] = {pad_plic_int_vld[`PLIC_INT_NUM-1:0],14'b0,l2c_plic_ecc_int_vld,1'b0};
assign plic_int_cfg[`PLIC_INT_NUM+15:0] = {pad_plic_int_cfg[`PLIC_INT_NUM-1:0],16'b0};
// &Depend("plic_top_dummy.v"); @162

assign plic_core0_me_int  = plic_hartx_mint_req[0];
assign plic_core0_se_int  = plic_hartx_sint_req[0];

//==========================================================
//          coverage
//==========================================================
// &Instance("aq_coverage"); @204


//assign core1_cpu_no_retire = 1'b0;
//assign core2_cpu_no_retire = 1'b0;
//assign core3_cpu_no_retire = 1'b0;
//assign cpu_debug_port = core0_cpu_no_retire
//                     || core1_cpu_no_retire
//                     || core2_cpu_no_retire
//                     || core3_cpu_no_retire;
assign cpu_debug_port = core0_cpu_no_retire;


// &ModuleEnd; @233
endmodule



