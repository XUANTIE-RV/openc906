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
module tdt_dm_top (
    sys_apb_clk,
    sys_apb_rst_b,
    forever_cpuclk,
    ciu_rst_b,
    sys_bus_clk_en,

    pad_yy_icg_scan_en,
    pad_yy_scan_mode,
    pad_yy_scan_rst_b,

    tdt_dmi_paddr,
    tdt_dmi_pwrite,
    tdt_dmi_psel,
    tdt_dmi_penable,
    tdt_dmi_pwdata,
    tdt_dmi_prdata,
    tdt_dmi_pready,
    tdt_dmi_pslverr,


    tdt_dm_pad_ndmreset_n,
    tdt_dm_pad_hartreset_n,

    tdt_dm_dtu_halt_req,
    tdt_dm_dtu_async_halt_req,
    tdt_dm_dtu_resume_req,
    tdt_dm_dtu_halt_on_reset,
    tdt_dm_dtu_halt_req_cause,
    dtu_tdt_dm_halted,
    dtu_tdt_dm_havereset,
    tdt_dm_dtu_ack_havereset,
    pad_tdt_dm_core_unavail,
    tdt_dm_dtu_itr,
    tdt_dm_dtu_itr_vld,
    dtu_tdt_dm_itr_done,
    dtu_tdt_dm_retire_debug_expt_vld,
    tdt_dm_dtu_wr_vld,
    tdt_dm_dtu_wr_flg,
    tdt_dm_dtu_wdata,
    dtu_tdt_dm_wr_ready,
    dtu_tdt_dm_rx_data

`ifdef TDT_DM_EXT_TRIGGER_EN
    , 
    pad_tdt_dm_halt_req,
    tdt_dm_pad_halt_req,
    pad_tdt_dm_resume_req,
    tdt_dm_pad_resume_req
`endif 

`ifdef TDT_DM_SBA
`ifdef TDT_DM_SBA_AXI
    ,
    tdt_dm_pad_awid,
    tdt_dm_pad_awaddr,
    tdt_dm_pad_awlen,
    tdt_dm_pad_awsize,
    tdt_dm_pad_awvalid,
    pad_tdt_dm_awready,
    tdt_dm_pad_wdata,
    tdt_dm_pad_wvalid,
    tdt_dm_pad_wlast,
    tdt_dm_pad_wstrb,
    pad_tdt_dm_wready,
    tdt_dm_pad_bready,
    pad_tdt_dm_bid,
    pad_tdt_dm_bresp,
    pad_tdt_dm_bvalid,
    tdt_dm_pad_arid,
    tdt_dm_pad_araddr,
    tdt_dm_pad_arlen,
    tdt_dm_pad_arsize,
    tdt_dm_pad_arvalid,
    pad_tdt_dm_arready,
    pad_tdt_dm_rid,
    pad_tdt_dm_rdata,
    pad_tdt_dm_rvalid,
    pad_tdt_dm_rlast,
    pad_tdt_dm_rresp,
    tdt_dm_pad_rready,
    tdt_dm_pad_awburst,
    tdt_dm_pad_awcache,
    tdt_dm_pad_awlock,
    tdt_dm_pad_awprot,
    tdt_dm_pad_arburst,
    tdt_dm_pad_arcache,
    tdt_dm_pad_arlock,
    tdt_dm_pad_arprot
`endif
`ifdef TDT_DM_SBA_AHB
    ,
    tdt_dm_pad_hprot,
    tdt_dm_pad_hmastlock,
    tdt_dm_pad_htrans,
    tdt_dm_pad_haddr,
    tdt_dm_pad_hwrite,
    tdt_dm_pad_hburst,
    tdt_dm_pad_hsize,
    tdt_dm_pad_hwdata,
    pad_tdt_dm_hrdata,
    pad_tdt_dm_hready,
    pad_tdt_dm_hresp
`endif
`endif
);

    parameter [31:0] TDT_NEXT_DM_BA = `TDT_DM_NEXTDM_BA;


    input                                                sys_apb_clk;
    input                                                sys_apb_rst_b;
    input                                                forever_cpuclk;
    input                                                ciu_rst_b;
    input                                                sys_bus_clk_en;
    input                                                pad_yy_icg_scan_en;
    input                                                pad_yy_scan_mode;
    input                                                pad_yy_scan_rst_b;

    input  [11:0]                                        tdt_dmi_paddr;
    input                                                tdt_dmi_pwrite;
`ifdef TDT_SINGLE_COMP
    input                             tdt_dmi_psel;
`else
    input  [`TDT_COMP_NUM-1:0]                           tdt_dmi_psel;
`endif
    input                                                tdt_dmi_penable;
    input  [31:0]                                        tdt_dmi_pwdata;
    output [`TDT_COMP_NUM*32-1:0]                        tdt_dmi_prdata;
`ifdef TDT_SINGLE_COMP
    output                            tdt_dmi_pready;
    output                            tdt_dmi_pslverr;
`else
    output [`TDT_COMP_NUM-1:0]                           tdt_dmi_pready;
    output [`TDT_COMP_NUM-1:0]                           tdt_dmi_pslverr;
`endif

//==========================================================
//    tdt to ciu reset 
//==========================================================
    output                                               tdt_dm_pad_ndmreset_n;
`ifdef TDT_DM_SINGLE_CORE
    output                         tdt_dm_pad_hartreset_n;
`else
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_pad_hartreset_n;
`endif

//==========================================================
//    interface between tdt and core 
//==========================================================
`ifdef TDT_DM_SINGLE_CORE
    output                         tdt_dm_dtu_halt_req;
    output                         tdt_dm_dtu_async_halt_req;
    output                         tdt_dm_dtu_resume_req;
    output                         tdt_dm_dtu_halt_on_reset;
    output [1:0]                   tdt_dm_dtu_halt_req_cause;
    input                          dtu_tdt_dm_halted;
    input                          dtu_tdt_dm_havereset;
    output                         tdt_dm_dtu_ack_havereset;
    input                          pad_tdt_dm_core_unavail;
    output [31:0]                                        tdt_dm_dtu_itr;
    output                         tdt_dm_dtu_itr_vld;
    input                          dtu_tdt_dm_itr_done; 
    input                          dtu_tdt_dm_retire_debug_expt_vld;
    output                         tdt_dm_dtu_wr_vld;
    output [1:0]                                         tdt_dm_dtu_wr_flg;
    output [`TDT_DM_CORE_MAX_XLEN-1:0]                   tdt_dm_dtu_wdata;
    input                          dtu_tdt_dm_wr_ready;
    input  [`TDT_DM_CORE_MAX_XLEN*`TDT_DM_CORE_NUM-1:0]  dtu_tdt_dm_rx_data;
`else
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_halt_req;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_async_halt_req;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_resume_req;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_halt_on_reset;
    output [`TDT_DM_CORE_NUM*2-1:0]                      tdt_dm_dtu_halt_req_cause;
    input  [`TDT_DM_CORE_NUM-1:0]                        dtu_tdt_dm_halted;
    input  [`TDT_DM_CORE_NUM-1:0]                        dtu_tdt_dm_havereset;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_ack_havereset;
    input  [`TDT_DM_CORE_NUM-1:0]                        pad_tdt_dm_core_unavail;
    output [31:0]                                        tdt_dm_dtu_itr;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_itr_vld;
    input  [`TDT_DM_CORE_NUM-1:0]                        dtu_tdt_dm_itr_done;
    input  [`TDT_DM_CORE_NUM-1:0]                        dtu_tdt_dm_retire_debug_expt_vld;
    output [`TDT_DM_CORE_NUM-1:0]                        tdt_dm_dtu_wr_vld;
    output [1:0]                                         tdt_dm_dtu_wr_flg;
    output [`TDT_DM_CORE_MAX_XLEN-1:0]                   tdt_dm_dtu_wdata;
    input  [`TDT_DM_CORE_NUM-1:0]                        dtu_tdt_dm_wr_ready;
    input  [`TDT_DM_CORE_MAX_XLEN*`TDT_DM_CORE_NUM-1:0]  dtu_tdt_dm_rx_data;
`endif

//==========================================================
//    halt/resume trigger interface between tdt and other 
//    cluster 
//==========================================================
`ifdef TDT_DM_EXT_TRIGGER_EN
    
    input  [`TDT_DM_EXTHALTTRI_NUM-1:0]                  pad_tdt_dm_halt_req;
    output [`TDT_DM_EXTHALTTRI_NUM-1:0]                  tdt_dm_pad_halt_req;
    input  [`TDT_DM_EXTRESUMETRI_NUM-1:0]                pad_tdt_dm_resume_req;
    output [`TDT_DM_EXTRESUMETRI_NUM-1:0]                tdt_dm_pad_resume_req;
`endif 

//==========================================================
//    dm system bus access axi master   
//==========================================================
`ifdef TDT_DM_SBA
`ifdef TDT_DM_SBA_AXI
    
    output [3:0]                                         tdt_dm_pad_awid;
    output [`TDT_DM_SBAW-1:0]                            tdt_dm_pad_awaddr;
    output [3:0]                                         tdt_dm_pad_awlen;
    output [2:0]                                         tdt_dm_pad_awsize;
    output                                               tdt_dm_pad_awvalid;
    input                                                pad_tdt_dm_awready;
    output [`TDT_DM_SBA_DW-1:0]                          tdt_dm_pad_wdata;
    output                                               tdt_dm_pad_wvalid;
    output                                               tdt_dm_pad_wlast;
    output [`TDT_DM_SBA_BW-1:0]                          tdt_dm_pad_wstrb;
    input                                                pad_tdt_dm_wready;
    output                                               tdt_dm_pad_bready;
    input  [3:0]                                         pad_tdt_dm_bid;
    input  [1:0]                                         pad_tdt_dm_bresp;
    input                                                pad_tdt_dm_bvalid;
    output [3:0]                                         tdt_dm_pad_arid;
    output [`TDT_DM_SBAW-1:0]                            tdt_dm_pad_araddr;
    output [3:0]                                         tdt_dm_pad_arlen;
    output [2:0]                                         tdt_dm_pad_arsize;
    output                                               tdt_dm_pad_arvalid;
    input                                                pad_tdt_dm_arready;
    input  [3:0]                                         pad_tdt_dm_rid;
    input  [`TDT_DM_SBA_DW-1:0]                          pad_tdt_dm_rdata;
    input                                                pad_tdt_dm_rvalid;
    input                                                pad_tdt_dm_rlast;
    input  [1:0]                                         pad_tdt_dm_rresp;
    output                                               tdt_dm_pad_rready;
    output [1:0]                                         tdt_dm_pad_awburst;
    output [3:0]                                         tdt_dm_pad_awcache;
    output                                               tdt_dm_pad_awlock;
    output [2:0]                                         tdt_dm_pad_awprot;
    output [1:0]                                         tdt_dm_pad_arburst;
    output [3:0]                                         tdt_dm_pad_arcache;
    output                                               tdt_dm_pad_arlock;
    output [2:0]                                         tdt_dm_pad_arprot;

`elsif TDT_DM_SBA_AHB
    output [3:0]                                         tdt_dm_pad_hprot;
    output                                               tdt_dm_pad_hmastlock;
    output [1:0]                                         tdt_dm_pad_htrans;
    output [`TDT_DM_SBAW-1:0]                            tdt_dm_pad_haddr;
    output                                               tdt_dm_pad_hwrite;
    output [2:0]                                         tdt_dm_pad_hburst;
    output [2:0]                                         tdt_dm_pad_hsize;
    output [`TDT_DM_SBA_DW-1:0]                          tdt_dm_pad_hwdata;
    input  [`TDT_DM_SBA_DW-1:0]                          pad_tdt_dm_hrdata;
    input                                                pad_tdt_dm_hready;
    input                                                pad_tdt_dm_hresp;
`endif
`endif


    wire                                                 dm_pclk_en;
    wire                                                 dm_pclk;
    //wire[3:0]                                            tdt_dm_pad_wid;//axi3 only port, axi4 nouse


gated_clk_cell x_gated_clk_cell(
    .clk_in                     (sys_apb_clk),
    .global_en                  (1'b1),
    .module_en                  (1'b0),
    .local_en                   (dm_pclk_en),
    .external_en                (1'b0),
    .pad_yy_icg_scan_en         (pad_yy_icg_scan_en),
    .clk_out                    (dm_pclk)
);

tdt_dm #(
    .APB_AW                                              (12),                
    .CORE_NUM                                            (`TDT_DM_CORE_NUM),
`ifdef TDT_DM_EXT_TRIGGER_EN            
    .EXTHALTTRI_NUM                                      (`TDT_DM_EXTHALTTRI_NUM),
    .EXTRESUMETRI_NUM                                    (`TDT_DM_EXTRESUMETRI_NUM),
`endif
`ifdef TDT_DM_PB_EN
    .PB_SIZE                                             (`TDT_DM_PB_SIZE),
`endif
    .IMP_EBREAK                                          (`TDT_DM_IMPEBREAK),
    .CORE_MAX_XLEN                                       (`TDT_DM_CORE_MAX_XLEN),
    .NEXTDM_BASEADDR                                     (TDT_NEXT_DM_BA),
`ifdef TDT_DM_SBA
    .SBAW                                                (`TDT_DM_SBAW),
`endif
    .ALLCORE_NSCRATCH                                    (`TDT_DM_ALLCORE_NSCRATCH),
    .ALLCORE_ISA                                         (`TDT_DM_ALLCORE_ISA)
) x_tdt_dm (
    .pclk                                                (sys_apb_clk),
    .preset_b                                             (sys_apb_rst_b),
    .forever_cpuclk                                      (forever_cpuclk),
    .ciu_rst_b                                           (ciu_rst_b),
    .sys_bus_clk_en                                         (sys_bus_clk_en),
    .dm_pclk                                             (dm_pclk),
    .dm_paddr                                            (tdt_dmi_paddr),
    .dm_pwrite                                           (tdt_dmi_pwrite),
    .dm_psel                                             (tdt_dmi_psel),
    .dm_penable                                          (tdt_dmi_penable),
    .dm_pwdata                                           (tdt_dmi_pwdata),
    .dm_prdata                                           (tdt_dmi_prdata[31:0]),
    .dm_pready                                           (tdt_dmi_pready),
    .dm_pslverr                                          (tdt_dmi_pslverr),
  
    .pad_icg_scan_en                                     (pad_yy_icg_scan_en), 
 
    .dm_pclk_en                                          (dm_pclk_en),
    .ndmresetn                                           (tdt_dm_pad_ndmreset_n),
    .dm_core_rstn                                        (tdt_dm_pad_hartreset_n),
    .dm_core_halt_req_o                                  (tdt_dm_dtu_halt_req),
    .dm_core_async_halt_req_o                            (tdt_dm_dtu_async_halt_req),
    .dm_core_resume_req_o                                (tdt_dm_dtu_resume_req),
    .dm_core_halt_on_reset_o                             (tdt_dm_dtu_halt_on_reset),
    .dm_core_halt_req_cause_o                            (tdt_dm_dtu_halt_req_cause),
    .core_dm_halted_i                                    (dtu_tdt_dm_halted),
    .core_dm_havereset_i                                 (dtu_tdt_dm_havereset),
    .dm_core_ack_havereset_o                             (tdt_dm_dtu_ack_havereset),
    .core_dm_unavail_i                                   (pad_tdt_dm_core_unavail),
   
`ifdef TDT_DM_EXT_TRIGGER_EN 
    .pad_dm_halt_req_i                                   (pad_tdt_dm_halt_req),
    .dm_pad_halt_req_o                                   (tdt_dm_pad_halt_req),
    
    .pad_dm_resume_req_i                                 (pad_tdt_dm_resume_req),
    .dm_pad_resume_req_o                                 (tdt_dm_pad_resume_req),
`endif 
    
    .dm_core_itr_o                                       (tdt_dm_dtu_itr),
    .dm_core_itr_vld_o                                   (tdt_dm_dtu_itr_vld),
    .core_dm_itr_done_i                                  (dtu_tdt_dm_itr_done),
    .core_dm_exce_retire_i                               (dtu_tdt_dm_retire_debug_expt_vld), 
    .dm_core_wr_vld                                      (tdt_dm_dtu_wr_vld),
    .dm_core_wr_flg                                      (tdt_dm_dtu_wr_flg),
    .dm_core_wdata                                       (tdt_dm_dtu_wdata),
    .core_dm_wr_ready                                    (dtu_tdt_dm_wr_ready),
    .core_dm_rx_data                                     (dtu_tdt_dm_rx_data)

`ifdef TDT_DM_SBA
`ifdef TDT_DM_SBA_AXI    
    ,
    .dm_pad_awid                                         (tdt_dm_pad_awid),
    .dm_pad_awaddr                                       (tdt_dm_pad_awaddr),
    .dm_pad_awlen                                        (tdt_dm_pad_awlen),
    .dm_pad_awsize                                       (tdt_dm_pad_awsize),
    .dm_pad_awvalid                                      (tdt_dm_pad_awvalid),
    .pad_dm_awready                                      (pad_tdt_dm_awready),
    .dm_pad_wdata                                        (tdt_dm_pad_wdata),
    .dm_pad_wvalid                                       (tdt_dm_pad_wvalid),
    .dm_pad_wlast                                        (tdt_dm_pad_wlast),
    .dm_pad_wstrb                                        (tdt_dm_pad_wstrb),
    .pad_dm_wready                                       (pad_tdt_dm_wready),
    .dm_pad_bready                                       (tdt_dm_pad_bready),
    .pad_dm_bid                                          (pad_tdt_dm_bid),
    .pad_dm_bresp                                        (pad_tdt_dm_bresp),
    .pad_dm_bvalid                                       (pad_tdt_dm_bvalid),
    .dm_pad_arid                                         (tdt_dm_pad_arid),
    .dm_pad_araddr                                       (tdt_dm_pad_araddr),
    .dm_pad_arlen                                        (tdt_dm_pad_arlen),
    .dm_pad_arsize                                       (tdt_dm_pad_arsize),
    .dm_pad_arvalid                                      (tdt_dm_pad_arvalid),
    .pad_dm_arready                                      (pad_tdt_dm_arready),
    .pad_dm_rid                                          (pad_tdt_dm_rid),
    .pad_dm_rdata                                        (pad_tdt_dm_rdata),
    .pad_dm_rvalid                                       (pad_tdt_dm_rvalid),
    .pad_dm_rlast                                        (pad_tdt_dm_rlast),
    .pad_dm_rresp                                        (pad_tdt_dm_rresp),
    .dm_pad_rready                                       (tdt_dm_pad_rready),
    .dm_pad_awburst                                      (tdt_dm_pad_awburst),
    .dm_pad_awcache                                      (tdt_dm_pad_awcache),
    .dm_pad_awlock                                       (tdt_dm_pad_awlock),
    .dm_pad_awprot                                       (tdt_dm_pad_awprot),
    .dm_pad_arburst                                      (tdt_dm_pad_arburst),
    .dm_pad_arcache                                      (tdt_dm_pad_arcache),
    .dm_pad_arlock                                       (tdt_dm_pad_arlock),
    .dm_pad_arprot                                       (tdt_dm_pad_arprot)
    //.dm_pad_wid                                          (tdt_dm_pad_wid)
`endif
`ifdef TDT_DM_SBA_AHB
    ,
    .dm_pad_hprot                                        (tdt_dm_pad_hprot),
    .dm_pad_hmastlock                                    (tdt_dm_pad_hmastlock),
    .dm_pad_htrans                                       (tdt_dm_pad_htrans),
    .dm_pad_haddr                                        (tdt_dm_pad_haddr),
    .dm_pad_hwrite                                       (tdt_dm_pad_hwrite),
    .dm_pad_hburst                                       (tdt_dm_pad_hburst),
    .dm_pad_hsize                                        (tdt_dm_pad_hsize),
    .dm_pad_hwdata                                       (tdt_dm_pad_hwdata),
    .pad_dm_hrdata                                       (pad_tdt_dm_hrdata),
    .pad_dm_hready                                       (pad_tdt_dm_hready),
    .pad_dm_hresp                                        (pad_tdt_dm_hresp)
`endif
`endif


);
endmodule
