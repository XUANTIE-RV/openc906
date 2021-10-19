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
module tdt_dmi (
    sys_apb_clk,
    sys_apb_rst_b,
    pad_tdt_dtm_tclk,
    pad_tdt_dtm_trst_b,
    pad_tdt_dtm_jtag2_sel,         
    pad_tdt_dtm_tap_en,        
    pad_tdt_dtm_tdi,           
    pad_tdt_dtm_tms_i,  
    tdt_dtm_pad_tdo,           
    tdt_dtm_pad_tdo_en,        
    tdt_dtm_pad_tms_o,         
    tdt_dtm_pad_tms_oe,

    pad_icg_scan_en,

`ifdef TDT_DMI_SYSAPB_EN
    pad_tdt_sysapb_en,
    pad_tdt_dmi_paddr,
    pad_tdt_dmi_pwrite,
    pad_tdt_dmi_psel,
    pad_tdt_dmi_penable,
    pad_tdt_dmi_pwdata,
    tdt_dmi_pad_prdata,
    tdt_dmi_pad_pready,
    tdt_dmi_pad_pslverr,

`endif

    tdt_dmi_paddr,
    tdt_dmi_pwrite,
    tdt_dmi_penable,
    tdt_dmi_pwdata,
    tdt_dmi_psel,
    tdt_dmi_prdata,
    tdt_dmi_pslverr,    
    tdt_dmi_pready
);


    input                                     sys_apb_clk;
    input                                     sys_apb_rst_b;
    input                                     pad_tdt_dtm_tclk;
    input                                     pad_tdt_dtm_trst_b;
    input                                     pad_tdt_dtm_jtag2_sel;         
    input                                     pad_tdt_dtm_tap_en;        
    input                                     pad_tdt_dtm_tdi;           
    input                                     pad_tdt_dtm_tms_i;  
    output                                    tdt_dtm_pad_tdo;           
    output                                    tdt_dtm_pad_tdo_en;        
    output                                    tdt_dtm_pad_tms_o;         
    output                                    tdt_dtm_pad_tms_oe;

    input                                     pad_icg_scan_en;

`ifdef TDT_DMI_SYSAPB_EN
    input                                     pad_tdt_sysapb_en;
    input  [12+`TDT_DMI_HIGH_ADDR_W-1:0]      pad_tdt_dmi_paddr;
    input                                     pad_tdt_dmi_pwrite;
    input                                     pad_tdt_dmi_psel;
    input                                     pad_tdt_dmi_penable;
    input  [31:0]                             pad_tdt_dmi_pwdata;
    output [31:0]                             tdt_dmi_pad_prdata;
    output                                    tdt_dmi_pad_pready;
    output                                    tdt_dmi_pad_pslverr;    
`endif

    output [11:0]                             tdt_dmi_paddr;
    output                                    tdt_dmi_pwrite;
    output                                    tdt_dmi_penable;
    output [31:0]                             tdt_dmi_pwdata;
`ifdef TDT_DMI_SINGLE_SLAVE
    output                                    tdt_dmi_psel;
`else
    output [`TDT_DMI_SLAVE_NUM-1:0]           tdt_dmi_psel;
`endif
    input  [32*`TDT_DMI_SLAVE_NUM-1:0]        tdt_dmi_prdata;
`ifdef TDT_DMI_SINGLE_SLAVE
    input                                     tdt_dmi_pready;
    input                                     tdt_dmi_pslverr;
`else
    input  [`TDT_DMI_SLAVE_NUM-1:0]           tdt_dmi_pready;
    input  [`TDT_DMI_SLAVE_NUM-1:0]           tdt_dmi_pslverr;
`endif

    wire                                      apbm_apbmux_psel;
    wire                                      apbm_apbmux_penable;
    wire                                      apbm_apbmux_pwrite;
    wire [12+`TDT_DMI_HIGH_ADDR_W-1:0]        apbm_apbmux_paddr;
    wire [31:0]                               apbm_apbmux_pwdata;
    wire                                      apbmux_apbm_pready;
    wire                                      apbmux_apbm_pslverr;    
    wire [31:0]                               apbmux_apbm_prdata;
`ifdef TDT_DMI_SYSAPB_EN
    wire                                      pre_apbmux_apbdec_psel;
    wire                                      pre_apbmux_apbdec_penable;
    wire                                      pre_apbmux_apbdec_pwrite;
    wire [12+`TDT_DMI_HIGH_ADDR_W-1:0]        pre_apbmux_apbdec_paddr;
    wire [31:0]                               pre_apbmux_apbdec_pwdata;
    wire                                      pre_apbdec_apbmux_pready;
    wire                                      pre_apbdec_apbmux_pslverr;    
    wire [31:0]                               pre_apbdec_apbmux_prdata;

`endif
    wire                                      apbmux_apbdec_psel;
    wire                                      apbmux_apbdec_penable;
    wire                                      apbmux_apbdec_pwrite;
    wire [12+`TDT_DMI_HIGH_ADDR_W-1:0]        apbmux_apbdec_paddr;
    wire [31:0]                               apbmux_apbdec_pwdata;
    wire                                      apbdec_apbmux_pready;
    wire                                      apbdec_apbmux_pslverr;    
    wire [31:0]                               apbdec_apbmux_prdata;

    wire                                      dtm_apbm_wr_vld;
    wire    [`TDT_DMI_HIGH_ADDR_W+10-1:0]     dtm_apbm_wr_addr;
    wire    [1:0]                             dtm_apbm_wr_flg;
    wire    [31:0]                            dtm_apbm_wdata;
    wire                                      dtm_apbm_dmihardreset;
    wire    [31:0]                            apbm_dtm_rdata;
    wire                                      apbm_dtm_wr_ready;

    wire                                      apb_icg_en;
    assign apb_icg_en = 1'b0;

tdt_dtm_top #(
    .DTM_ABITS                               (`TDT_DMI_HIGH_ADDR_W+10)
) x_tdt_dtm_top (
    .pad_dtm_tclk                            (pad_tdt_dtm_tclk),
    .pad_dtm_trst_b                          (pad_tdt_dtm_trst_b),
    .pad_dtm_jtag2_sel                       (pad_tdt_dtm_jtag2_sel),         
    .pad_dtm_tap_en                          (pad_tdt_dtm_tap_en),        
    .pad_dtm_tdi                             (pad_tdt_dtm_tdi),           
    .pad_dtm_tms_i                           (pad_tdt_dtm_tms_i),  
    .dtm_pad_tdo                             (tdt_dtm_pad_tdo),           
    .dtm_pad_tdo_en                          (tdt_dtm_pad_tdo_en),        
    .dtm_pad_tms_o                           (tdt_dtm_pad_tms_o),         
    .dtm_pad_tms_oe                          (tdt_dtm_pad_tms_oe),

    .dtm_apbm_wr_vld                         (dtm_apbm_wr_vld),
    .dtm_apbm_wr_addr                        (dtm_apbm_wr_addr),
    .dtm_apbm_wr_flg                         (dtm_apbm_wr_flg),
    .dtm_apbm_wdata                          (dtm_apbm_wdata),
    .dmihardreset                            (dtm_apbm_dmihardreset),
    .apbm_dtm_rdata                          (apbm_dtm_rdata),
    .apbm_dtm_wr_ready                       (apbm_dtm_wr_ready)
);

//==========================================================
//    apb master
//==========================================================

tdt_apb_master #(
    .PADDR_HIGH_WIDTH                 (`TDT_DMI_HIGH_ADDR_W),
    .PADDR_LOW_WIDTH                  (10),
    .SLAVE_NUM                        (`TDT_DMI_SLAVE_NUM)
) x_tdt_apb_master ( 
    .tck                              (pad_tdt_dtm_tclk),
    .trst_b                           (pad_tdt_dtm_trst_b),
    .cmd_vld                          (dtm_apbm_wr_vld),
    .addr                             (dtm_apbm_wr_addr),
    .wr_flg                           (dtm_apbm_wr_flg),
    .wdata                            (dtm_apbm_wdata),
    .dmihardreset                     (dtm_apbm_dmihardreset),
    .rdata                            (apbm_dtm_rdata),
    .apb_wr_ready                     (apbm_dtm_wr_ready),

    .pclk                             (sys_apb_clk),
    .preset_b                         (sys_apb_rst_b),
    .psel                             (apbm_apbmux_psel),
    .penable                          (apbm_apbmux_penable),
    .pwrite                           (apbm_apbmux_pwrite),
    .paddr                            (apbm_apbmux_paddr),
    .pwdata                           (apbm_apbmux_pwdata),
    .pready                           (apbmux_apbm_pready),
    .pslverr                          (apbmux_apbm_pslverr),    
    .prdata                           (apbmux_apbm_prdata),

    .dm_apb_clk_en                    (apb_icg_en),
    .pad_icg_scan_en                  (pad_icg_scan_en)
);

//==========================================================
//    apb mux
//==========================================================
`ifdef TDT_DMI_SYSAPB_EN

tdt_apb_mux #(
    .PADDR_HIGH_WIDTH                 (`TDT_DMI_HIGH_ADDR_W),
    .PADDR_LOW_WIDTH                  (10)
) x_tdt_apb_mux (
    .pclk                             (sys_apb_clk),
    .preset_b                          (sys_apb_rst_b),

    .psel_dtm                         (apbm_apbmux_psel),
    .penable_dtm                      (apbm_apbmux_penable),
    .pwrite_dtm                       (apbm_apbmux_pwrite),
    .paddr_dtm                        (apbm_apbmux_paddr),
    .pwdata_dtm                       (apbm_apbmux_pwdata),
    .pready_dtm                       (apbmux_apbm_pready),
    .pslverr_dtm                      (apbmux_apbm_pslverr),

    .prdata_dtm                       (apbmux_apbm_prdata),

    .sysapb_en                        (pad_tdt_sysapb_en),
    .psel_sys                         (pad_tdt_dmi_psel),
    .penable_sys                      (pad_tdt_dmi_penable),
    .pwrite_sys                       (pad_tdt_dmi_pwrite),
    .paddr_sys                        (pad_tdt_dmi_paddr),
    .pwdata_sys                       (pad_tdt_dmi_pwdata),
    .pready_sys                       (tdt_dmi_pad_pready),
    .prdata_sys                       (tdt_dmi_pad_prdata), 
    .pslverr_sys                      (tdt_dmi_pad_pslverr), 

    .psel                             (pre_apbmux_apbdec_psel),
    .penable                          (pre_apbmux_apbdec_penable),
    .pwrite                           (pre_apbmux_apbdec_pwrite),
    .paddr                            (pre_apbmux_apbdec_paddr),
    .pwdata                           (pre_apbmux_apbdec_pwdata),
    .pready                           (pre_apbdec_apbmux_pready),
    .pslverr                          (pre_apbdec_apbmux_pslverr),    
    .prdata                           (pre_apbdec_apbmux_prdata),

    .dm_apb_clk_en                    (apb_icg_en),
    .pad_icg_scan_en                  (pad_icg_scan_en)
);

tdt_apb_regslice
#(
    .PADDR_HIGH_WIDTH                 (`TDT_DMI_HIGH_ADDR_W),
    .PADDR_LOW_WIDTH                  (10)
) x_tdt_apb_regslice (
    .pclk                           (sys_apb_clk),
    .preset_b                        (sys_apb_rst_b),

    .psel                           (pre_apbmux_apbdec_psel),
    .penable                        (pre_apbmux_apbdec_penable),
    .pwrite                         (pre_apbmux_apbdec_pwrite),
    .paddr                          (pre_apbmux_apbdec_paddr),
    .pwdata                         (pre_apbmux_apbdec_pwdata),
    .pready                         (apbdec_apbmux_pready),
    .pslverr                        (apbdec_apbmux_pslverr),    
    .prdata                         (apbdec_apbmux_prdata),

    .psel_r                         (apbmux_apbdec_psel),
    .penable_r                      (apbmux_apbdec_penable),
    .pwrite_r                       (apbmux_apbdec_pwrite),
    .paddr_r                        (apbmux_apbdec_paddr),
    .pwdata_r                       (apbmux_apbdec_pwdata),
    .pready_r                       (pre_apbdec_apbmux_pready),
    .pslverr_r                      (pre_apbdec_apbmux_pslverr),    
    .prdata_r                       (pre_apbdec_apbmux_prdata),

    .dm_apb_clk_en                  (apb_icg_en),
    .pad_icg_scan_en                (pad_icg_scan_en)
);

`else 
    assign apbmux_apbdec_psel                                  = apbm_apbmux_psel;
    assign apbmux_apbdec_penable                               = apbm_apbmux_penable;
    assign apbmux_apbdec_pwrite                                = apbm_apbmux_pwrite;
    assign apbmux_apbdec_paddr[12+`TDT_DMI_HIGH_ADDR_W-1:0]    = apbm_apbmux_paddr[12+`TDT_DMI_HIGH_ADDR_W-1:0];
    assign apbmux_apbdec_pwdata[31:0]                          = apbm_apbmux_pwdata[31:0];
    assign apbmux_apbm_pready                                  = apbdec_apbmux_pready;
    assign apbmux_apbm_pslverr                                 = apbdec_apbmux_pslverr;    
    assign apbmux_apbm_prdata[31:0]                            = apbdec_apbmux_prdata[31:0];
`endif

//==========================================================
//    apb decoder
//==========================================================
`ifdef TDT_DMI_SINGLE_SLAVE
    assign tdt_dmi_psel                                 = apbmux_apbdec_psel;
    assign tdt_dmi_penable                              = apbmux_apbdec_penable;
    assign tdt_dmi_pwrite                               = apbmux_apbdec_pwrite;
    assign tdt_dmi_paddr[11:0]                          = apbmux_apbdec_paddr[12+`TDT_DMI_HIGH_ADDR_W-1:0];
    assign tdt_dmi_pwdata[31:0]                         = apbmux_apbdec_pwdata[31:0];
    assign apbdec_apbmux_pready                         = tdt_dmi_pready;
    assign apbdec_apbmux_pslverr                        = tdt_dmi_pslverr;    
    assign apbdec_apbmux_prdata[31:0]                   = tdt_dmi_prdata[32*`TDT_DMI_SLAVE_NUM-1:0];
`else
tdt_apb_decoder #(
`ifdef TDT_DMI_SLAVE_31
    .PSEL_31_ADDR                     (`TDT_DMI_SLAVE_31_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_30               
    .PSEL_30_ADDR                     (`TDT_DMI_SLAVE_30_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_29               
    .PSEL_29_ADDR                     (`TDT_DMI_SLAVE_29_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_28               
    .PSEL_28_ADDR                     (`TDT_DMI_SLAVE_28_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_27               
    .PSEL_27_ADDR                     (`TDT_DMI_SLAVE_27_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_26               
    .PSEL_26_ADDR                     (`TDT_DMI_SLAVE_26_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_25               
    .PSEL_25_ADDR                     (`TDT_DMI_SLAVE_25_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_24               
    .PSEL_24_ADDR                     (`TDT_DMI_SLAVE_24_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_23               
    .PSEL_23_ADDR                     (`TDT_DMI_SLAVE_23_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_22               
    .PSEL_22_ADDR                     (`TDT_DMI_SLAVE_22_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_21               
    .PSEL_21_ADDR                     (`TDT_DMI_SLAVE_21_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_20               
    .PSEL_20_ADDR                     (`TDT_DMI_SLAVE_20_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_19               
    .PSEL_19_ADDR                     (`TDT_DMI_SLAVE_19_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_18               
    .PSEL_18_ADDR                     (`TDT_DMI_SLAVE_18_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_17               
    .PSEL_17_ADDR                     (`TDT_DMI_SLAVE_17_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_16               
    .PSEL_16_ADDR                     (`TDT_DMI_SLAVE_16_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_15               
    .PSEL_15_ADDR                     (`TDT_DMI_SLAVE_15_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_14               
    .PSEL_14_ADDR                     (`TDT_DMI_SLAVE_14_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_13               
    .PSEL_13_ADDR                     (`TDT_DMI_SLAVE_13_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_12               
    .PSEL_12_ADDR                     (`TDT_DMI_SLAVE_12_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_11               
    .PSEL_11_ADDR                     (`TDT_DMI_SLAVE_11_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_10               
    .PSEL_10_ADDR                     (`TDT_DMI_SLAVE_10_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_9               
    .PSEL_9_ADDR                      (`TDT_DMI_SLAVE_9_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_8                
    .PSEL_8_ADDR                      (`TDT_DMI_SLAVE_8_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_7                
    .PSEL_7_ADDR                      (`TDT_DMI_SLAVE_7_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_6                
    .PSEL_6_ADDR                      (`TDT_DMI_SLAVE_6_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_5                
    .PSEL_5_ADDR                      (`TDT_DMI_SLAVE_5_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_4                
    .PSEL_4_ADDR                      (`TDT_DMI_SLAVE_4_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_3                
    .PSEL_3_ADDR                      (`TDT_DMI_SLAVE_3_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_2                
    .PSEL_2_ADDR                      (`TDT_DMI_SLAVE_2_BASEADDR),
`endif
`ifdef TDT_DMI_SLAVE_1                
    .PSEL_1_ADDR                      (`TDT_DMI_SLAVE_1_BASEADDR),
`endif
    .PSEL_0_ADDR                      ('d0),
    .NUM_APB_SLAVES                   (`TDT_DMI_SLAVE_NUM),
    .PADDR_HIGH_WIDTH                 (`TDT_DMI_HIGH_ADDR_W),
    .PADDR_LOW_WIDTH                  (10)
) x_tdt_apb_decoder (
    .pclk                             (sys_apb_clk),
    .preset_b                          (sys_apb_rst_b),

    .psel_m                           (apbmux_apbdec_psel),
    .penable_m                        (apbmux_apbdec_penable),
    .pwrite_m                         (apbmux_apbdec_pwrite),
    .paddr_m                          (apbmux_apbdec_paddr),
    .pwdata_m                         (apbmux_apbdec_pwdata),
    .pready_m                         (apbdec_apbmux_pready),
    .pslverr_m                        (apbdec_apbmux_pslverr),
    .prdata_m                         (apbdec_apbmux_prdata),

    .penable                          (tdt_dmi_penable),
    .pwrite                           (tdt_dmi_pwrite),
    .paddr                            (tdt_dmi_paddr),
    .pwdata                           (tdt_dmi_pwdata),
    .psel                             (tdt_dmi_psel),
    .pslverr                          (tdt_dmi_pslverr),
    .pready                           (tdt_dmi_pready),    
    .prdata                           (tdt_dmi_prdata)
);
`endif

endmodule
