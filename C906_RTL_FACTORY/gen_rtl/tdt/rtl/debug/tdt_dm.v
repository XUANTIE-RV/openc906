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
module tdt_dm #(
    parameter                   APB_AW                = 12,
    parameter                   CORE_NUM              = `TDT_DM_CORE_NUM,
    parameter                   EXTHALTTRI_NUM        = 4,
    parameter                   EXTRESUMETRI_NUM      = 4,
    parameter                   PB_SIZE               = 15,
    parameter                   IMP_EBREAK            = 1,
    parameter                   CORE_MAX_XLEN         = `TDT_DM_CORE_MAX_XLEN,
    parameter  [31:0]           NEXTDM_BASEADDR       = 32'h0,
    parameter                   SBAW                  = 40,
    parameter  [CORE_NUM*4-1:0] ALLCORE_NSCRATCH      = `TDT_DM_ALLCORE_NSCRATCH,
    parameter  [CORE_NUM*4-1:0] ALLCORE_ISA           = `TDT_DM_ALLCORE_ISA
)(
    input                                       pclk,
    input                                       preset_b,
    input                                       forever_cpuclk,
    input                                       ciu_rst_b,
    input                                       sys_bus_clk_en,
    input                                       dm_pclk,
    input      [APB_AW-1:0]                     dm_paddr,
    input                                       dm_pwrite,
    input                                       dm_psel,
    input                                       dm_penable,
    input      [31:0]                           dm_pwdata,
    output reg [31:0]                           dm_prdata,
    output reg                                  dm_pready,
    output                                      dm_pslverr,

    input                                       pad_icg_scan_en,
 
    output                                      dm_pclk_en,
    output reg                                  ndmresetn,
`ifdef TDT_DM_SINGLE_CORE
    output reg                    dm_core_rstn,
    output reg                    dm_core_halt_req_o,
    output reg                    dm_core_async_halt_req_o,
    output reg                    dm_core_resume_req_o,
    output reg                    dm_core_halt_on_reset_o,
    output reg [1:0]              dm_core_halt_req_cause_o,
    
    input                         core_dm_halted_i,
    input                         core_dm_havereset_i,
    output reg                    dm_core_ack_havereset_o,
    input                         core_dm_unavail_i,
`else
    output reg [CORE_NUM-1:0]                   dm_core_rstn,
    output reg [CORE_NUM-1:0]                   dm_core_halt_req_o,
    output reg [CORE_NUM-1:0]                   dm_core_async_halt_req_o,
    output reg [CORE_NUM-1:0]                   dm_core_resume_req_o,
    output reg [CORE_NUM-1:0]                   dm_core_halt_on_reset_o,
    output reg [CORE_NUM*2-1:0]                 dm_core_halt_req_cause_o,
    
    input      [CORE_NUM-1:0]                   core_dm_halted_i,
    input      [CORE_NUM-1:0]                   core_dm_havereset_i,
    output reg [CORE_NUM-1:0]                   dm_core_ack_havereset_o,
    input      [CORE_NUM-1:0]                   core_dm_unavail_i,
`endif
    
`ifdef TDT_DM_EXT_TRIGGER_EN 
    input      [EXTHALTTRI_NUM-1:0]             pad_dm_halt_req_i,
    output reg [EXTHALTTRI_NUM-1:0]             dm_pad_halt_req_o,
    
    input      [EXTRESUMETRI_NUM-1:0]           pad_dm_resume_req_i,
    output reg [EXTRESUMETRI_NUM-1:0]           dm_pad_resume_req_o,
`endif 
    
    output     [31:0]                           dm_core_itr_o,
`ifdef TDT_DM_SINGLE_CORE
    output                        dm_core_itr_vld_o,
    input                         core_dm_itr_done_i,
    input                         core_dm_exce_retire_i,
`else
    output     [CORE_NUM-1:0]                   dm_core_itr_vld_o,
    input      [CORE_NUM-1:0]                   core_dm_itr_done_i,
    input      [CORE_NUM-1:0]                   core_dm_exce_retire_i,
`endif

`ifdef TDT_DM_SINGLE_CORE
    output reg                    dm_core_wr_vld,
`else
    output reg [CORE_NUM-1:0]                   dm_core_wr_vld,
`endif
    output reg [1:0]                            dm_core_wr_flg,
    output     [CORE_MAX_XLEN-1:0]              dm_core_wdata,
`ifdef TDT_DM_SINGLE_CORE
    input                         core_dm_wr_ready,
`else
    input      [CORE_NUM-1:0]                   core_dm_wr_ready,
`endif
    input      [CORE_MAX_XLEN*CORE_NUM-1:0]     core_dm_rx_data

`ifdef TDT_DM_SBA
`ifdef TDT_DM_SBA_AXI    
    ,
    output     [3:0]                            dm_pad_awid,
    output     [SBAW-1:0]                       dm_pad_awaddr,
    output     [3:0]                            dm_pad_awlen,
    output     [2:0]                            dm_pad_awsize,
    output                                      dm_pad_awvalid,
    input                                       pad_dm_awready,
    output     [`TDT_DM_SBA_DW-1:0]             dm_pad_wdata,
    output                                      dm_pad_wvalid,
    output                                      dm_pad_wlast,
    output     [`TDT_DM_SBA_BW-1:0]             dm_pad_wstrb,
    input                                       pad_dm_wready,
    output                                      dm_pad_bready,
    input      [3:0]                            pad_dm_bid,
    input      [1:0]                            pad_dm_bresp,
    input                                       pad_dm_bvalid,
    output     [3:0]                            dm_pad_arid,
    output     [SBAW-1:0]                       dm_pad_araddr,
    output     [3:0]                            dm_pad_arlen,
    output     [2:0]                            dm_pad_arsize,
    output                                      dm_pad_arvalid,
    input                                       pad_dm_arready,
    input      [3:0]                            pad_dm_rid,
    input      [`TDT_DM_SBA_DW-1:0]             pad_dm_rdata,
    input                                       pad_dm_rvalid,
    input                                       pad_dm_rlast,
    input      [1:0]                            pad_dm_rresp,
    output                                      dm_pad_rready,
    output     [1:0]                            dm_pad_awburst,
    output     [3:0]                            dm_pad_awcache,
    output                                      dm_pad_awlock,
    output     [2:0]                            dm_pad_awprot,
    output     [1:0]                            dm_pad_arburst,
    output     [3:0]                            dm_pad_arcache,
    output                                      dm_pad_arlock,
    output     [2:0]                            dm_pad_arprot
    //output     [3:0]                            dm_pad_wid
`endif
`ifdef TDT_DM_SBA_AHB
    ,
    output     [3:0]                            dm_pad_hprot,
    output                                      dm_pad_hmastlock,
    output     [1:0]                            dm_pad_htrans,
    output     [SBAW-1:0]                       dm_pad_haddr,
    output                                      dm_pad_hwrite,
    output     [2:0]                            dm_pad_hburst,
    output     [2:0]                            dm_pad_hsize,
    output     [`TDT_DM_SBA_DW-1:0]             dm_pad_hwdata,
    input      [`TDT_DM_SBA_DW-1:0]             pad_dm_hrdata,
    input                                       pad_dm_hready,
    input                                       pad_dm_hresp
`endif
`endif
);

    //==========================================================
    //    local parameter define
    //==========================================================
`ifdef TDT_DM_SINGLE_CORE
    localparam                 CORE_NUM_W               = 1;
`else
    localparam                 CORE_NUM_W               = $clog2(CORE_NUM);
`endif
    localparam [APB_AW-1-2:0]  OFFSET_DATA0             = 10'h04;
    localparam [APB_AW-1-2:0]  OFFSET_DATA1             = 10'h05;
    localparam [APB_AW-1-2:0]  OFFSET_DATA2             = 10'h06;
    localparam [APB_AW-1-2:0]  OFFSET_DATA3             = 10'h07;
    localparam [APB_AW-1-2:0]  OFFSET_DATA4             = 10'h08;
    localparam [APB_AW-1-2:0]  OFFSET_DATA5             = 10'h09;
    localparam [APB_AW-1-2:0]  OFFSET_DATA6             = 10'h0a;
    localparam [APB_AW-1-2:0]  OFFSET_DATA7             = 10'h0b;
    localparam [APB_AW-1-2:0]  OFFSET_DATA8             = 10'h0c;
    localparam [APB_AW-1-2:0]  OFFSET_DATA9             = 10'h0d;
    localparam [APB_AW-1-2:0]  OFFSET_DATA10            = 10'h0e;
    localparam [APB_AW-1-2:0]  OFFSET_DATA11            = 10'h0f;
    localparam [APB_AW-1-2:0]  OFFSET_DMCONTROL         = 10'h10;
    localparam [APB_AW-1-2:0]  OFFSET_DMSTATUS          = 10'h11;
    localparam [APB_AW-1-2:0]  OFFSET_HARTINFO          = 10'h12;
    localparam [APB_AW-1-2:0]  OFFSET_HAWINDOW          = 10'h15;
    localparam [APB_AW-1-2:0]  OFFSET_ABSTRACTCS        = 10'h16;
    localparam [APB_AW-1-2:0]  OFFSET_COMMAND           = 10'h17;
    localparam [APB_AW-1-2:0]  OFFSET_ABSTRACTAUTO      = 10'h18;
    localparam [APB_AW-1-2:0]  OFFSET_NEXTDM            = 10'h1d;
    localparam [APB_AW-1-2:0]  OFFSET_PB0               = 10'h20;
    localparam [APB_AW-1-2:0]  OFFSET_PB1               = 10'h21;
    localparam [APB_AW-1-2:0]  OFFSET_PB2               = 10'h22;
    localparam [APB_AW-1-2:0]  OFFSET_PB3               = 10'h23;
    localparam [APB_AW-1-2:0]  OFFSET_PB4               = 10'h24;
    localparam [APB_AW-1-2:0]  OFFSET_PB5               = 10'h25;
    localparam [APB_AW-1-2:0]  OFFSET_PB6               = 10'h26;
    localparam [APB_AW-1-2:0]  OFFSET_PB7               = 10'h27;
    localparam [APB_AW-1-2:0]  OFFSET_PB8               = 10'h28;
    localparam [APB_AW-1-2:0]  OFFSET_PB9               = 10'h29;
    localparam [APB_AW-1-2:0]  OFFSET_PB10              = 10'h2a;
    localparam [APB_AW-1-2:0]  OFFSET_PB11              = 10'h2b;
    localparam [APB_AW-1-2:0]  OFFSET_PB12              = 10'h2c;
    localparam [APB_AW-1-2:0]  OFFSET_PB13              = 10'h2d;
    localparam [APB_AW-1-2:0]  OFFSET_PB14              = 10'h2e;
    localparam [APB_AW-1-2:0]  OFFSET_PB15              = 10'h2f;
    localparam [APB_AW-1-2:0]  OFFSET_DMCS2             = 10'h32;
    localparam [APB_AW-1-2:0]  OFFSET_SBCS              = 10'h38;
    localparam [APB_AW-1-2:0]  OFFSET_SBADDR0           = 10'h39;
    localparam [APB_AW-1-2:0]  OFFSET_SBADDR1           = 10'h3a;
    localparam [APB_AW-1-2:0]  OFFSET_SBDATA0           = 10'h3c;
    localparam [APB_AW-1-2:0]  OFFSET_SBDATA1           = 10'h3d;
    localparam [APB_AW-1-2:0]  OFFSET_SBDATA2           = 10'h3e;
    localparam [APB_AW-1-2:0]  OFFSET_SBDATA3           = 10'h3f;
    localparam [APB_AW-1-2:0]  OFFSET_HARTSUM0          = 10'h40;
    localparam [APB_AW-1-2:0]  OFFSET_ITR               = 10'h1f;
    localparam [APB_AW-1-2:0]  OFFSET_CUSCS             = 10'h70;
    localparam [APB_AW-1-2:0]  OFFSET_CUSCMD            = 10'h71;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF0           = 10'h72;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF1           = 10'h73;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF2           = 10'h74;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF3           = 10'h75;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF4           = 10'h76;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF5           = 10'h77;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF6           = 10'h78;
    localparam [APB_AW-1-2:0]  OFFSET_CUSBUF7           = 10'h79;
    localparam [APB_AW-1-2:0]  OFFSET_COMPID            = 10'h7f;
    
    localparam [11:0]          TDT_DM_THEAD_JEP106_ID   = 12'b1011_011_0111_1;
    localparam [3:0]           TDT_DM_VERSION           = 4'h2;
    localparam [11:0]          TDT_DM_COMP_TYPE         = 12'h0;
    localparam [7:0]           TDT_DM_COMP_VERSION      = 8'h1;
    localparam [11:0]          TDT_DM_RV_DSCR0_ADDR     = 12'h7b2;
    localparam [11:0]          TDT_DM_RV_DSCR1_ADDR     = 12'h7b3;

    localparam [6:0]           TDT_DM_RV_SYSTEM_OPCODE  = 7'h73;
    localparam [2:0]           TDT_DM_RV_CSRRW_FUNC3    = 3'h1;
    localparam [2:0]           TDT_DM_RV_CSRRC_FUNC3    = 3'h3;    
    localparam [4:0]           TDT_DM_RV_ZERO_GPR       = 5'h0;
    localparam [31:0]          TDT_DM_RV_EBREAK         = 32'b000000000001_00000_000_00000_1110011;
    localparam [31:0]          TDT_DM_RV_CEBREAK         = 32'b000000000000_00001_001_00000_0000010;

    localparam [3:0]           REGACC_IDLE              = 4'h0;
    localparam [3:0]           REGACC_WDSC0             = 4'h1;
    localparam [3:0]           REGACC_RDSC0             = 4'h2;
    localparam [3:0]           REGACC_X6_2_DSC1         = 4'h3;
    localparam [3:0]           REGACC_DSC1_2_X6         = 4'h4;
    localparam [3:0]           REGACC_DSC0_2_G          = 4'h5;
    localparam [3:0]           REGACC_G_2_DSC0          = 4'h6;
    localparam [3:0]           REGACC_C_2_X6            = 4'h7;
    localparam [3:0]           REGACC_X6_2_C            = 4'h8;
    localparam [3:0]           REGACC_X6_2_DSC0         = 4'h9;
    localparam [3:0]           REGACC_DSC0_2_X6         = 4'ha; 
    //==========================================================
    //    wires and registers define
    //==========================================================
`ifdef TDT_DM_SINGLE_CORE
    wire                            core_dm_itr_done_pad;
    wire                            core_dm_exce_retire_pad;
    wire                            itr_vld_pad;
    wire                            core_dm_wr_ready_pad;
    reg                             core_dm_unavail_sync1;
    reg                             core_dm_unavail_sync2;
`else
    wire [CORE_NUM-1:0]                           core_dm_itr_done_pad;
    wire [CORE_NUM-1:0]                           core_dm_exce_retire_pad;
    wire [CORE_NUM-1:0]                           itr_vld_pad;
    wire [CORE_NUM-1:0]                           core_dm_wr_ready_pad;
    reg  [CORE_NUM-1:0]                           core_dm_unavail_sync1;
    reg  [CORE_NUM-1:0]                           core_dm_unavail_sync2;
`endif
    wire                                          core_dm_itr_done_mux_pre;
    wire                                          core_dm_exce_retire_mux_pre;
    reg                                           core_dm_itr_done_mux;
    reg                                           core_dm_exce_retire_mux;

    wire                                          itr_vld_mux;
    wire                                          core_dm_wr_ready_mux;
    reg [3:0]                                     sel_core_isa;
    wire [CORE_NUM*4-1:0]                         all_core_isa;
    wire [31:0]                                   compid;
    wire                                          pb_sel;
    wire                                          intra_sel;
    wire                                          apb_access;
    wire                                          dm_intra_psel;
    wire                                          dm_intra_access;
    wire                                          dm_intra_apbw;
    wire                                          dm_intra_apbr;
    wire                                          cmd_busy_set;
    wire                                          haltreq_raise;
    wire                                          haltreq_fall;
    wire                                          aarsize_err;

`ifdef TDT_DM_SINGLE_CORE
    reg                             core_dm_halted_d;
    wire                            core_dm_halted_req;
    wire                            core_dm_resume_req;
    wire                            core_dm_running;
`else
    reg  [CORE_NUM-1:0]                           core_dm_halted_d;
    wire [CORE_NUM-1:0]                           core_dm_halted_req;
    wire [CORE_NUM-1:0]                           core_dm_resume_req;
    wire [CORE_NUM-1:0]                           core_dm_running;
`endif
    wire [31:0]                                   abstractauto;
    wire [31:0]                                   nextdm;
    reg                                           resumereq;
    reg                                           hartreset;
    reg                                           ackhavereset;
    reg                                           hasel;
`ifdef TDT_DM_SINGLE_CORE
    reg                           hartsello;
`else
    reg  [CORE_NUM_W-1:0]                         hartsello;  
`endif
    wire [9:0]                                    hartselhi;
    reg                                           setresethaltreq;
    reg                                           clrresethaltreq;
    reg                                           ndmreset;
    wire [31:0]                                   dmcontrol;
    reg  [31:0]                                   hawindow;
`ifdef TDT_DM_SINGLE_CORE
    wire                            hart_sel;
`else
    wire [CORE_NUM-1:0]                           hart_sel;
`endif
    wire                                          impebreak;
    wire                                          allhavereset;
    wire                                          anyhavereset;
`ifdef TDT_DM_SINGLE_CORE
    reg                             resumeack; 
`else
    reg  [CORE_NUM-1:0]                           resumeack;
`endif
    wire                                          allresumeack;
    wire                                          anyresumeack;
    wire                                          allnonexistent;
    wire                                          anynonexistent;
    wire                                          allunavail;
    wire                                          anyunavail;
    wire                                          allrunning;
    wire                                          anyrunning;
    wire                                          allhalted;
    wire                                          anyhalted;
    wire                                          authenticated;
    wire                                          authbusy;
    wire                                          haresethaltreq;
    wire                                          confstrptrvalid;
    wire [3:0]                                    version;
    wire [31:0]                                   dmstatus;
    reg                                           grouptype;
    reg  [3:0]                                    exttrigger;
    reg  [3:0]                                    groups;
    wire [3:0]                                    read_group;

    reg                                           hgwrite;
    reg                                           hgselect;
    wire [31:0]                                   dmcs2;
    reg                                           itr_send_pb_r;
`ifdef TDT_DM_SINGLE_CORE
    wire                            nor_halt_req;
    wire                            nor_halt_req_clr;

    wire                            hart_halt_req_en;
    wire                            nor_resume_req;
`else
    wire [CORE_NUM-1:0]                           nor_halt_req;
    wire [CORE_NUM-1:0]                           nor_halt_req_clr;

    wire [CORE_NUM-1:0]                           hart_halt_req_en;
    wire [CORE_NUM-1:0]                           nor_resume_req;
`endif
`ifdef TDT_DM_GROUP_TRI_EN  
    wire [3:0]                                    core_read_group;
    wire [3:0]                                    ext_read_group;
    `ifdef TDT_DM_SINGLE_CORE
    reg  [3:0]                                    core_haltgp_info;
    reg  [3:0]                                    core_resumegp_info;
    wire                                          harthalt_2_harthalt;
    wire                                          hartresume_2_hartresume;
    wire                                          gp_hart2hart_halt_req;
    wire                                          gp_hart2hart_resume_req;
    `else
    reg  [3:0]                                    core_haltgp_info [0:CORE_NUM-1];
    reg  [3:0]                                    core_resumegp_info [0:CORE_NUM-1];
    wire [CORE_NUM*CORE_NUM-1:0]                  harthalt_2_harthalt;
    wire [CORE_NUM*CORE_NUM-1:0]                  hartresume_2_hartresume;
    wire [CORE_NUM-1:0]                           gp_hart2hart_halt_req;
    wire [CORE_NUM-1:0]                           gp_hart2hart_resume_req;
    `endif
    reg                                           sel_hart_pend_resume;
    reg                                           sel_hart_pend_resume_d;
    wire                                          sel_hart_pend_resume_req;
`endif
`ifdef TDT_DM_SINGLE_CORE
    wire                            hart_resume_req_en;
`else
    wire [CORE_NUM-1:0]                           hart_resume_req_en;
`endif
    reg  [7:0]                                    cmdtype;
    reg                                           aarpostincrement;
    reg                                           aarpostexec;
    reg                                           transfer;
    reg                                           write;
    reg  [15:0]                                   regno;
    reg  [11:0]                                   autoexecdata;
    reg  [15:0]                                   autoexecprogbuf;
    wire                                          apb_access_pb0;
    wire                                          apb_access_pb1;
    wire                                          apb_access_pb2;
    wire                                          apb_access_pb3;
    wire                                          apb_access_pb4;
    wire                                          apb_access_pb5;
    wire                                          apb_access_pb6;
    wire                                          apb_access_pb7;
    wire                                          apb_access_pb8;
    wire                                          apb_access_pb9;
    wire                                          apb_access_pb10;
    wire                                          apb_access_pb11;
    wire                                          apb_access_pb12;
    wire                                          apb_access_pb13;
    wire                                          apb_access_pb14;
    wire                                          apb_access_pb15;
    wire                                          apb_access_data0;
    wire                                          apb_access_data1;
    wire [15:0]                                   apb_access_pb;
    wire [15:0]                                   apb_access_pb_real;
    wire [11:0]                                   apb_access_data_real;
    wire                                          autoaccen;
    reg                                           cmd_start;
    reg                                           cmd_work;
    reg                                           cmd_done;
    reg                                           pb_work;
    wire                                          busy;
    wire [4:0]                                    progbufsize;
    reg  [2:0]                                    cmderr;
    wire [3:0]                                    datacount;
    wire [31:0]                                   abstractcs;
    wire                                          access_gpr;
    wire                                          access_csr;
    wire                                          access_dsc0;
    reg  [31:0]                                   itr;
`ifdef TDT_DM_SINGLE_CORE
    reg                             itr_vld;
`else
    reg  [CORE_NUM-1:0]                           itr_vld;
`endif
    reg                                           itr_work;
`ifdef TDT_DM_SINGLE_CORE
    reg  [CORE_MAX_XLEN-1:0]                      core_rdata_r;
`else
    reg  [CORE_MAX_XLEN-1:0]                      core_rdata_r [0:CORE_NUM-1];
`endif
    wire [CORE_MAX_XLEN-1:0]                      core_rdata_mux;
    reg                                           core_rdata_vld_r;
    reg  [31:0]                                   data0;
    reg  [31:0]                                   data1;
    wire [31:0]                                   hartsum0;
    reg  [2:0]                                    cuscmderr;
    reg                                           cuscmdbusy;
    wire [3:0]                                    cusbufcnt;
    wire [15:0]                                   coredebuginfo;
    wire [31:0]                                   customcs;
    reg [31:0]                                    hartinfo;
    wire [4*CORE_NUM-1:0]                         nscratch_all;
    reg                                           ebk_work;
    wire [31:0]                                   pb_mux;
    reg  [3:0]                                    pb_idx;
    wire [11:0]                                   vendorid;
    wire [11:0]                                   comptype;
    wire [7:0]                                    compversion;
    reg  [31:0]                                   prdata_pre;
    reg  [3:0]                                    regacc_cur_state;
    reg  [3:0]                                    regacc_nxt_state;
    wire                                          fsm_x6_2_dsc1;
    wire                                          fsm_x6_2_dsc0;
    wire                                          fsm_x6_2_c;
    wire                                          fsm_c_2_x6;
    wire                                          fsm_dsc0_2_x6;
    wire                                          fsm_dsc1_2_x6;
    reg  [31:0]                                   progbuf[15:0];
`ifdef TDT_DM_BUF_MOVE
    reg  [1:0]                                    src_type;
    reg  [1:0]                                    dst_type;
    reg  [3:0]                                    src_reg;
    reg  [3:0]                                    dst_reg;
    reg                                           internal_move_start;
    reg  [31:0]                                   src_data_mux;
    reg  [31:0]                                   cusbuf [0:`TDT_DM_CUSTOM_BUF_CNT-1];
    wire [31:0]                                   cusbuf_all [0:7];
`endif
`ifdef TDT_DM_SBA
    reg  [4:0]                                    sbaddrplus;
    wire [32:0]                                   sbaddr0_plus_pre;
    reg  [31:0]                                   sbaddr0;
    reg  [31:0]                                   sbaddr1;
    wire [2:0]                                    sbversion;
    reg                                           sbbusy;
    reg                                           sbbusyerror;
    reg                                           sberror_will_be_4;
    reg                                           sberror_will_be_3;
    reg  [2:0]                                    sberror;
    wire [6:0]                                    sbasize;
    wire [4:0]                                    sbaccess_info;
    reg                                           sbreadonaddr;
    reg  [2:0]                                    sbaccess;
    reg                                           sbautoincrement;
    reg                                           sbreadondata;
    wire [31:0]                                   sbcs;
    reg  [31:0]                                   sbdata0;
    reg  [31:0]                                   sbdata1;
    reg  [31:0]                                   sbdata2;
    reg  [31:0]                                   sbdata3;
    wire [`TDT_DM_SBA_DW-1:0]                     sba_w_data;
    reg                                           sba_wr_flg;
    reg                                           sba_wr_vld;
    wire [SBAW-1:0]                               sba_wr_addr;
    wire [63:0]                                   sba_wr_addr_pre;
    wire [2:0]                                    sba_wr_size;
    reg  [`TDT_DM_SBA_DW-1:0]                     sba_rd_data;
    reg                                           sba_wr_ready;
    wire                                          sba_write;
    wire                                          sba_read;
    wire                                          sba_write_ignore_unalign;
    wire                                          sba_read_ignore_unalign;
    reg                                           sba_write_ignore_unalign_f;
    reg                                           sba_read_ignore_unalign_f;
    reg                                          sba_error;
`endif
`ifdef TDT_DM_EXT_TRIGGER_EN 
    reg  [3:0]                                    exttriin_haltgp_info [EXTHALTTRI_NUM-1:0];
    reg  [3:0]                                    exttriin_resumegp_info [EXTRESUMETRI_NUM-1:0];
    reg  [3:0]                                    exttriout_haltgp_info [EXTHALTTRI_NUM-1:0];
    reg  [3:0]                                    exttriout_resumegp_info [EXTRESUMETRI_NUM-1:0];
    wire [3:0]                                    all_exttri_info [15:0];
    wire [CORE_NUM*EXTHALTTRI_NUM-1:0]            harthalt_2_exttrio;
    wire [CORE_NUM*EXTHALTTRI_NUM-1:0]            exttriihalt_2_hart;
    wire [EXTHALTTRI_NUM*EXTHALTTRI_NUM-1:0]      exttriihalt_2_exttrio;
    wire [CORE_NUM*EXTRESUMETRI_NUM-1:0]          hartresume_2_exttrio;
    wire [CORE_NUM*EXTRESUMETRI_NUM-1:0]          exttriiresume_2_hart;
    wire [EXTRESUMETRI_NUM*EXTRESUMETRI_NUM-1:0]  exttriiresume_2_exttrio;
  `ifdef TDT_DM_SINGLE_CORE
    wire                                          gp_exttrii2hart_resume_req;
    wire                                          gp_exttrii2hart_halt_req;
  `else
    wire [CORE_NUM-1:0]                           gp_exttrii2hart_resume_req;
    wire [CORE_NUM-1:0]                           gp_exttrii2hart_halt_req;
  `endif
    wire [EXTHALTTRI_NUM-1:0]                     gp_hart2exttrio_halt_req;
    wire [EXTHALTTRI_NUM-1:0]                     gp_exttrii2exttrio_halt_req;
    wire [EXTHALTTRI_NUM-1:0]                     ext_halt_req_en;
    wire [EXTRESUMETRI_NUM-1:0]                   gp_hart2exttrio_resume_req;
    wire [EXTRESUMETRI_NUM-1:0]                   gp_exttrii2exttrio_resume_req;
    wire [EXTRESUMETRI_NUM-1:0]                   ext_resume_req_en;
`endif
    wire                                          apbw_dmctrl;
    wire                                          apbw_dmcs2;
    wire                                          apbw_abscmd;
    wire                                          apbw_abscmdauto;
    wire                                          itr_send_pb;
`ifdef TDT_DM_SINGLE_CORE
    wire                            itr_vld_en;
`else
    wire [CORE_NUM-1:0]                           itr_vld_en;
`endif
    wire                                          apbw_cuscmd;
    wire                                          apbw_sbcs;
`ifdef TDT_DM_SINGLE_CORE
    wire                            dm_core_wr_vld_en;
`else
    wire [CORE_NUM-1:0]                           dm_core_wr_vld_en;
`endif

    wire                                          access_illegal_reg;
    wire                                          pb_work_start;

    wire                                          hg_sel_core;
    wire                                          hg_sel_exttri;
    reg                                           dmactive;
    reg                                           dmactive_d1;
    wire                                          sync_rst;
    //==========================================================
    //    core info
    //==========================================================
    
    assign all_core_isa[CORE_NUM*4-1:0] = ALLCORE_ISA;
    assign nscratch_all[4*CORE_NUM-1:0] = ALLCORE_NSCRATCH; 
    
    genvar i;
  `ifdef TDT_DM_GROUP_TRI_EN
    genvar j;
  `else
    `ifdef TDT_DM_EXT_TRIGGER_EN
    genvar j;
    `endif
  `endif
    //==========================================================
    //    apb mini decode
    //    if access programbuffer, send apb to pb
    //    if access other regs, send internal
    //==========================================================
    
    assign pb_sel          = dm_paddr[APB_AW-1:6] == {{APB_AW-8{1'b0}}, 2'b10};
    assign intra_sel       = !pb_sel;
    assign apb_access      = dm_psel & dm_penable;
    assign dm_intra_psel   = dm_psel && intra_sel;
    assign dm_intra_access = dm_intra_psel && dm_penable;
    assign dm_intra_apbw   = dm_intra_access && dm_pwrite;
    assign dm_intra_apbr   = dm_intra_access && !dm_pwrite;
  
    wire [31:0] pb_zero_value;
    assign pb_zero_value[31:0]   = 32'h0;

`ifdef TDT_DM_PB_EN
    generate
        for (i=0; i<PB_SIZE; i=i+1) begin : gen_progbuf
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b)
                    progbuf[i] <= 32'h0;
                else if (sync_rst)
                    progbuf[i] <= 32'h0;    
                else if (dm_psel && dm_penable && pb_sel && dm_pwrite && dm_paddr[5:2] == i[3:0] && ~busy) 
                    progbuf[i] <= dm_pwdata[31:0];
            end
        end
    endgenerate
    `ifdef TDT_DM_IEBREAK
    wire [31:0] implied_ebreak;
    assign implied_ebreak[31:0]  = 32'b000000000001_00000_000_00000_1110011;
    always @ (*) begin
            progbuf[PB_SIZE] = implied_ebreak[31:0];
    end
    generate
        for (i=PB_SIZE+1; i<16; i=i+1) begin : gen_zero_progbuf
            always @ (*) begin
                    progbuf[i] = pb_zero_value[31:0];
            end
        end
    endgenerate
    `else
    generate
        for (i=PB_SIZE; i<16; i=i+1) begin : gen_zero_progbuf
            always @ (*) begin
                    progbuf[i] = pb_zero_value[31:0];
            end
        end
    endgenerate
    `endif
`else
    generate
        for (i=0; i<16; i=i+1) begin : gen_zero_progbuf
            always @ (*) begin
                progbuf[i] = pb_zero_value[31:0];
            end
        end
    endgenerate
`endif
    

    //==========================================================
    //    dmcontrol
    //==========================================================
    assign apbw_dmctrl = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_DMCONTROL;
    assign haltreq_raise = apbw_dmctrl && dm_pwdata[31];
    assign haltreq_fall = apbw_dmctrl && ~dm_pwdata[31];
`ifdef TDT_DM_SINGLE_CORE
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_dm_halted_d <= 1'b0;
        else if (sync_rst)
            core_dm_halted_d <= 1'b0;
        else 
            core_dm_halted_d <= core_dm_halted_i;
    end
    
    assign core_dm_halted_req = ~core_dm_halted_d &&  core_dm_halted_i;
    assign core_dm_resume_req =  core_dm_halted_d && ~core_dm_halted_i;
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_halt_signal
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    core_dm_halted_d[i] <= 1'b0;
                else if (sync_rst)
                    core_dm_halted_d[i] <= 1'b0;
                else 
                    core_dm_halted_d[i] <= core_dm_halted_i[i];
            end
            
            assign core_dm_halted_req[i] = ~core_dm_halted_d[i] &&  core_dm_halted_i[i];
            assign core_dm_resume_req[i] =  core_dm_halted_d[i] && ~core_dm_halted_i[i];
        end
    endgenerate
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            resumereq <= 1'b0;
        else if (sync_rst)
            resumereq <= 1'b0;
        else if (apbw_dmctrl)
            resumereq <= !dm_pwdata[31] && dm_pwdata[30];
        else if (resumereq)
            resumereq <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hartreset <= 1'b0;
        else if (sync_rst)
            hartreset <= 1'b0;
        else if (apbw_dmctrl)
            hartreset <= dm_pwdata[29];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            ackhavereset <= 1'b0;
        else if (sync_rst)
            ackhavereset <= 1'b0;
        else if (apbw_dmctrl)
            ackhavereset <= dm_pwdata[28];
        else if (ackhavereset)
            ackhavereset <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hasel <= 1'b0;
        else if (sync_rst)
            hasel <= 1'b0;
        else if (apbw_dmctrl)
            hasel <= dm_pwdata[26];
    end
`ifdef TDT_DM_SINGLE_CORE
    wire   hartsello_zero_value;
    assign hartsello_zero_value = 1'b0;

    always @ (*) begin
      hartsello = hartsello_zero_value;
    end
`else
    wire [CORE_NUM_W-1:0]  hartsello_zero_value;
    assign hartsello_zero_value[CORE_NUM_W-1:0] = {CORE_NUM_W{1'b0}};

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hartsello[CORE_NUM_W-1:0] <= {CORE_NUM_W{1'b0}};
        else if (sync_rst)
            hartsello[CORE_NUM_W-1:0] <= {CORE_NUM_W{1'b0}};
        else if (apbw_dmctrl)
            hartsello[CORE_NUM_W-1:0] <= dm_pwdata[CORE_NUM_W+16-1:16];
    end
`endif

    assign hartselhi[9:0] = 10'h0;
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            setresethaltreq <= 1'b0;
        else if (sync_rst) 
            setresethaltreq <= 1'b0;    
        else if (apbw_dmctrl)
            setresethaltreq <= dm_pwdata[3];
        else if (setresethaltreq)
            setresethaltreq <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            clrresethaltreq <= 1'b0;
        else if (sync_rst) 
            clrresethaltreq <= 1'b0;
        else if (apbw_dmctrl)
            clrresethaltreq <= dm_pwdata[2];
        else if (clrresethaltreq)
            clrresethaltreq <= 1'b0;
    end

`ifdef TDT_DM_SINGLE_CORE
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            dm_core_halt_on_reset_o <= 1'b0;
        else if (sync_rst) 
            dm_core_halt_on_reset_o <= 1'b0;
        else if (clrresethaltreq)
            dm_core_halt_on_reset_o <= 1'b0;
        else if (setresethaltreq && hart_sel)
            dm_core_halt_on_reset_o <= 1'b1;  
    end
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hart_on_reset_o
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_halt_on_reset_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_halt_on_reset_o[i] <= 1'b0;
                else if (clrresethaltreq)
                    dm_core_halt_on_reset_o[i] <= 1'b0;
                else if (setresethaltreq && hart_sel[i])
                    dm_core_halt_on_reset_o[i] <= 1'b1;  
            end
        end
    endgenerate
`endif 

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            ndmreset <= 1'b0;
        else if (sync_rst) 
            ndmreset <= 1'b0;
        else if (apbw_dmctrl)
            ndmreset <= dm_pwdata[1];
    end
    
    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b) 
            dmactive <= 1'b0;
        else if (apbw_dmctrl)
            dmactive <= dm_pwdata[0];
    end

    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b) 
            dmactive_d1 <= 1'b0;
        else
            dmactive_d1 <= dmactive;
    end

    assign sync_rst = dmactive_d1 & ~dmactive;
    assign dm_pclk_en = dmactive | dmactive_d1;

    assign dmcontrol[31:0] = {1'b0, 1'b0, hartreset, ackhavereset, 1'b0, 
                        hasel, {10-CORE_NUM_W{1'b0}}, hartsello, hartselhi[9:0], 2'b0, 
                        setresethaltreq, clrresethaltreq, ndmreset, dmactive};
    
    //==========================================================
    //    hawindow and hart select
    //==========================================================
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hawindow[31:0] <= 32'b0;
        else if (sync_rst) 
            hawindow[31:0] <= 32'b0;
        else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_HAWINDOW)
            hawindow[31:0] <= dm_pwdata[31:0];
    end

`ifdef TDT_DM_SINGLE_CORE
    assign hart_sel = 1'b1;
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hart_sel
            assign hart_sel[i] = (hartsello[CORE_NUM_W-1:0] == i[CORE_NUM_W-1:0]) || (hasel && hawindow[i]);
        end
    endgenerate
`endif 

`ifdef TDT_DM_SINGLE_CORE
   always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b)
            core_dm_unavail_sync1 <= 1'b0;
        else 
            core_dm_unavail_sync1 <= core_dm_unavail_i;   
    end

    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b)
            core_dm_unavail_sync2 <= 1'b0;
        else 
            core_dm_unavail_sync2 <= core_dm_unavail_sync1;
    end  
`else
    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b)
            core_dm_unavail_sync1[CORE_NUM-1:0] <= {CORE_NUM{1'b0}};
        else 
            core_dm_unavail_sync1[CORE_NUM-1:0] <= core_dm_unavail_i[CORE_NUM-1:0];   
    end

    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b)
            core_dm_unavail_sync2[CORE_NUM-1:0] <= {CORE_NUM{1'b0}};
        else 
            core_dm_unavail_sync2[CORE_NUM-1:0] <= core_dm_unavail_sync1[CORE_NUM-1:0];
    end  
`endif
    //==========================================================
    //    dmstatus
    //==========================================================
    
    assign impebreak = `TDT_DM_IMPEBREAK; 
`ifdef TDT_DM_SINGLE_CORE
    assign allhavereset = (hart_sel & core_dm_havereset_i) == hart_sel;
    assign anyhavereset = hart_sel & core_dm_havereset_i;
`else
    assign allhavereset = (hart_sel[CORE_NUM-1:0] & core_dm_havereset_i[CORE_NUM-1:0]) == hart_sel[CORE_NUM-1:0];
    assign anyhavereset = |(hart_sel[CORE_NUM-1:0] & core_dm_havereset_i[CORE_NUM-1:0]);
`endif

`ifdef TDT_DM_SINGLE_CORE
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            resumeack <= 1'b0;
        else if (sync_rst) 
            resumeack <= 1'b0;
        else if (resumereq && hart_sel)
            resumeack <= 1'b0;
        else if (core_dm_resume_req && hart_sel)
            resumeack <= 1'b1;
    end

`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_resumeack
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    resumeack[i] <= 1'b0;
                else if (sync_rst) 
                    resumeack[i] <= 1'b0;
                else if (resumereq && hart_sel[i])
                    resumeack[i] <= 1'b0;
                else if (core_dm_resume_req[i] && hart_sel[i])
                    resumeack[i] <= 1'b1;
            end
        end
    endgenerate
`endif

`ifdef TDT_DM_SINGLE_CORE
    assign allresumeack    = (hart_sel & resumeack) == hart_sel;
    assign anynonexistent  = (hartsello >= CORE_NUM) || (hasel && (|hawindow[31:CORE_NUM]));
    assign allunavail      = (hart_sel & core_dm_unavail_sync2) == hart_sel;
    assign core_dm_running = ~core_dm_halted_i;
    assign allrunning      = (hart_sel & core_dm_running & ~core_dm_unavail_sync2) == hart_sel;
    assign allhalted       = (hart_sel & core_dm_halted_i & ~core_dm_unavail_sync2) == hart_sel;
    assign anyresumeack    = hart_sel & resumeack;
    assign allnonexistent  = (~hasel && (hartsello >= CORE_NUM)) || 
                             (hasel && ((hartsello >= CORE_NUM) && (!hawindow[CORE_NUM-1:0])));
    assign anyunavail      = hart_sel & core_dm_unavail_sync2;
    assign anyrunning      = hart_sel & core_dm_running & ~core_dm_unavail_sync2;
    assign anyhalted       = hart_sel & core_dm_halted_i & ~core_dm_unavail_sync2;
`else
    assign allresumeack    = (hart_sel[CORE_NUM-1:0] & resumeack[CORE_NUM-1:0]) == hart_sel[CORE_NUM-1:0];
    assign anynonexistent  = (hartsello[CORE_NUM_W-1:0] >= CORE_NUM) || (hasel && (|hawindow[31:CORE_NUM]));
    assign allunavail      = (hart_sel[CORE_NUM-1:0] & core_dm_unavail_sync2[CORE_NUM-1:0]) == hart_sel[CORE_NUM-1:0];
    assign core_dm_running[CORE_NUM-1:0] = ~core_dm_halted_i[CORE_NUM-1:0];
    assign allrunning      = (hart_sel[CORE_NUM-1:0] & core_dm_running[CORE_NUM-1:0] & ~core_dm_unavail_sync2[CORE_NUM-1:0]) == hart_sel[CORE_NUM-1:0];
    assign allhalted       = (hart_sel[CORE_NUM-1:0] & core_dm_halted_i[CORE_NUM-1:0] & ~core_dm_unavail_sync2[CORE_NUM-1:0]) == hart_sel[CORE_NUM-1:0];
    assign anyresumeack    = |(hart_sel[CORE_NUM-1:0] & resumeack[CORE_NUM-1:0]);
    assign allnonexistent  = (~hasel && (hartsello[CORE_NUM_W-1:0] >= CORE_NUM)) || 
                             (hasel && ((hartsello[CORE_NUM_W-1:0] >= CORE_NUM) && (!(|hawindow[CORE_NUM-1:0]))));
    assign anyunavail      = |(hart_sel[CORE_NUM-1:0] & core_dm_unavail_sync2[CORE_NUM-1:0]);
    assign anyrunning      = |(hart_sel[CORE_NUM-1:0] & core_dm_running[CORE_NUM-1:0] & ~core_dm_unavail_sync2[CORE_NUM-1:0]);
    assign anyhalted       = |(hart_sel[CORE_NUM-1:0] & core_dm_halted_i[CORE_NUM-1:0] & ~core_dm_unavail_sync2[CORE_NUM-1:0]);
`endif

    assign authenticated   = 1'b1;       //not support authenticated
    assign authbusy        = 1'b0;       //not support authenticated
    assign haresethaltreq  = 1'b1;       //support hart on reset
    assign confstrptrvalid = 1'b0;       //not support
    assign version[3:0]         = TDT_DM_VERSION;        
    
    assign dmstatus[31:0] = {9'h0, impebreak, 2'b0, allhavereset, anyhavereset,
                       allresumeack, anyresumeack, allnonexistent, anynonexistent,
                       allunavail, anyunavail, allrunning, anyrunning, allhalted,
                       anyhalted, authenticated, authbusy,haresethaltreq, 
                       confstrptrvalid, version[3:0]};
    
    //==========================================================
    //    dmcs2, groups halt and resume info
    //==========================================================
    assign apbw_dmcs2 = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_DMCS2;

    wire [3:0] dmcs2_4zero;
    wire       dmcs2_zero;

    assign dmcs2_4zero[3:0] = 4'h0;
    assign dmcs2_zero  = 1'b0;

`ifdef TDT_DM_GROUP_TRI_EN 
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            grouptype <= 1'b0;
        else if (sync_rst) 
            grouptype <= 1'b0;
        else if (apbw_dmcs2)
            grouptype <= dm_pwdata[11];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            exttrigger[3:0] <= 4'b0;
        else if (sync_rst) 
            exttrigger[3:0] <= 4'b0;
        else if (apbw_dmcs2)
            exttrigger[3:0] <= dm_pwdata[10:7];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            groups[3:0] <= 4'b0;
        else if (sync_rst) 
            groups[3:0] <= 4'b0;
        else if (apbw_dmcs2)
            groups[3:0] <= dm_pwdata[5:2];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hgwrite <= 1'b0;
        else if (sync_rst) 
            hgwrite <= 1'b0;
        else if (apbw_dmcs2)
            hgwrite <= dm_pwdata[1];
        else if (hgwrite)
            hgwrite <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            hgselect <= 1'b0;
        else if (sync_rst) 
            hgselect <= 1'b0;
        else if (apbw_dmcs2)
            hgselect <= dm_pwdata[0];
    end
`else
    always @ (*) begin
        grouptype = dmcs2_zero;
    end
    
    always @ (*) begin
        exttrigger[3:0] = dmcs2_4zero[3:0];
    end
    
    always @ (*) begin
        groups[3:0] = dmcs2_4zero[3:0];
    end
    
    always @ (*) begin
        hgwrite = dmcs2_zero;
    end
    
    always @ (*) begin
        hgselect = dmcs2_zero;
    end

`endif   
    assign dmcs2[31:0] = {20'h0, grouptype, exttrigger[3:0], 1'b0, read_group[3:0], hgwrite, hgselect};
    
    assign hg_sel_core = hgwrite & !hgselect;
    assign hg_sel_exttri = hgwrite & hgselect;


`ifdef TDT_DM_EXT_TRIGGER_EN
    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_all_exttri_info_1
            assign all_exttri_info[i] = exttriin_haltgp_info[i];
        end
        if (EXTHALTTRI_NUM[2:0]<4) begin : gen_all_exttri_info_2_no
            for (i=EXTHALTTRI_NUM; i<4; i=i+1) begin : gen_all_exttri_info_2
                assign all_exttri_info[i] = 4'h0;
            end
        end

        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_all_exttri_info_3
            assign all_exttri_info[i+4] = exttriout_haltgp_info[i];
        end
        if (EXTHALTTRI_NUM[2:0]<4) begin : gen_all_exttri_info_4_no
            for (i=EXTHALTTRI_NUM; i<4; i=i+1) begin : gen_all_exttri_info_4
                assign all_exttri_info[i+4] = 4'h0;
            end
        end

        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_all_exttri_info_5
            assign all_exttri_info[i+8] = exttriin_resumegp_info[i];
        end
        if (EXTRESUMETRI_NUM[2:0]<4) begin : gen_all_exttri_info_6_no
            for (i=EXTRESUMETRI_NUM; i<4; i=i+1) begin : gen_all_exttri_info_6
                assign all_exttri_info[i+8] = 4'h0;
            end
        end

        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_all_exttri_info_7
            assign all_exttri_info[i+12] = exttriout_resumegp_info[i];
        end
        `ifdef TDT_DM_EXTRESUMETRI_4
        `else
            for (i=EXTRESUMETRI_NUM; i<4; i=i+1) begin : gen_all_exttri_info_8
                assign all_exttri_info[i+12] = 4'h0;
            end
        `endif

    endgenerate    
`endif


`ifdef TDT_DM_GROUP_TRI_EN
  `ifdef TDT_DM_SINGLE_CORE
    assign core_read_group[3:0] = grouptype ? core_resumegp_info[3:0] :
                                              core_haltgp_info[3:0];
  `else
    assign core_read_group[3:0] = grouptype ? core_resumegp_info[hartsello[CORE_NUM_W-1:0]] :
                                              core_haltgp_info[hartsello[CORE_NUM_W-1:0]];
  `endif
  `ifdef TDT_DM_EXT_TRIGGER_EN
    assign ext_read_group[3:0] = all_exttri_info[exttrigger];
  `else
    assign ext_read_group[3:0] = 4'h0;  
  `endif
    assign read_group[3:0] = hgselect ? ext_read_group[3:0] : core_read_group[3:0];
`else
    assign read_group[3:0] = 4'h0;
`endif
    //==========================================================
    //    groups ctrl, updata groups infomation of core halt/
    //    resume,external trigger halt/resume
    //==========================================================
`ifdef TDT_DM_GROUP_TRI_EN
  `ifdef TDT_DM_SINGLE_CORE
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_haltgp_info[3:0] <= 4'b0;
        else if (sync_rst) 
            core_haltgp_info[3:0] <= 4'b0;
        else if (hg_sel_core && !grouptype && hart_sel)
            core_haltgp_info[3:0] <= groups[3:0];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_resumegp_info[3:0] <= 4'b0;
        else if (sync_rst) 
            core_resumegp_info[3:0] <= 4'b0;
        else if (hg_sel_core && grouptype && hart_sel)
            core_resumegp_info[3:0] <= groups[3:0];
    end
  `else 
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_core_gp_info
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    core_haltgp_info[i] <= 4'b0;
                else if (sync_rst) 
                    core_haltgp_info[i] <= 4'b0;
                else if (hg_sel_core && !grouptype && hart_sel[i])
                    core_haltgp_info[i] <= groups[3:0];
            end
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    core_resumegp_info[i] <= 4'b0;
                else if (sync_rst) 
                    core_resumegp_info[i] <= 4'b0;
                else if (hg_sel_core && grouptype && hart_sel[i])
                    core_resumegp_info[i] <= groups[3:0];
            end
        end
    endgenerate
  `endif
`endif
    //==========================================================
    // external trigger mapping:
    // num : 0 1 2 3 | 4 5 6 7 | 8 9 10 11 | 12 13 14 15
    // typ : haltin   haltout   resumein    resumeout
    //==========================================================
    
`ifdef TDT_DM_EXT_TRIGGER_EN
    wire [3:0] ext_halt_in_idx [EXTHALTTRI_NUM-1:0];
    wire [3:0] ext_halt_out_idx [EXTHALTTRI_NUM-1:0];
    wire [3:0] ext_resume_in_idx [EXTRESUMETRI_NUM-1:0];
    wire [3:0] ext_resume_out_idx [EXTRESUMETRI_NUM-1:0];

    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_exttri_haltgp_info
            assign ext_halt_in_idx[i] = i[3:0];
            assign ext_halt_out_idx[i] = i[3:0] + 4'h4;

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    exttriin_haltgp_info[i] <= 4'b0;
                else if (sync_rst) 
                    exttriin_haltgp_info[i] <= 4'b0;
                else if (hg_sel_exttri && !grouptype && exttrigger[3:0] == ext_halt_in_idx[i])
                    exttriin_haltgp_info[i] <= groups[3:0];
            end
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    exttriout_haltgp_info[i] <= 4'b0;
                else if (sync_rst) 
                    exttriout_haltgp_info[i] <= 4'b0;
                else if (hg_sel_exttri && !grouptype && exttrigger[3:0] == ext_halt_out_idx[i])
                    exttriout_haltgp_info[i] <= groups[3:0];
            end
        end
    endgenerate
    
    generate
        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_exttri_resumegp_info
            assign ext_resume_in_idx[i] = i[3:0] + 4'h8;
            assign ext_resume_out_idx[i] = i[3:0] + 4'hc;

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    exttriin_resumegp_info[i] <= 4'b0;
                else if (sync_rst) 
                    exttriin_resumegp_info[i] <= 4'b0;
                else if (hg_sel_exttri && grouptype && exttrigger[3:0] == ext_resume_in_idx[i])
                    exttriin_resumegp_info[i] <= groups[3:0];
            end
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    exttriout_resumegp_info[i] <= 4'b0;
                else if (sync_rst) 
                    exttriout_resumegp_info[i] <= 4'b0;
                else if (hg_sel_exttri && grouptype && exttrigger[3:0] == ext_resume_out_idx[i])
                    exttriout_resumegp_info[i] <= groups[3:0];
            end
        end
    endgenerate
`endif
    //==========================================================
    //    reset, output is low active
    //==========================================================
`ifdef TDT_DM_SINGLE_CORE  
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            dm_core_rstn <= 1'b1;
        else if (sync_rst) 
            dm_core_rstn <= 1'b1;
        else if (apbw_dmctrl && hart_sel)
            dm_core_rstn <= !dm_pwdata[29];
    end
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hart_rstn
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_rstn[i] <= 1'b1;
                else if (sync_rst) 
                    dm_core_rstn[i] <= 1'b1;
                else if (apbw_dmctrl && hart_sel[i])
                    dm_core_rstn[i] <= !dm_pwdata[29];
            end
        end 
    endgenerate
`endif

`ifdef TDT_DM_SINGLE_CORE  
   always @ (posedge dm_pclk or negedge preset_b) begin
       if (!preset_b) 
           dm_core_ack_havereset_o <= 1'b0;
       else if (sync_rst) 
           dm_core_ack_havereset_o <= 1'b0;
       else if (dm_core_ack_havereset_o)
           dm_core_ack_havereset_o <= 1'b0;
       else if (ackhavereset && hart_sel)
           dm_core_ack_havereset_o <= 1'b1;
   end
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hart_ack_havereset
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_ack_havereset_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_ack_havereset_o[i] <= 1'b0;
                else if (dm_core_ack_havereset_o[i])
                    dm_core_ack_havereset_o[i] <= 1'b0;
                else if (ackhavereset && hart_sel[i])
                    dm_core_ack_havereset_o[i] <= 1'b1;
            end
        end
    endgenerate
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            ndmresetn <= 1'b1;
        else if (sync_rst) 
            ndmresetn <= 1'b1;
        else if (apbw_dmctrl)
            ndmresetn <= !dm_pwdata[1];
    end
    
    //==========================================================
    //    halt and resume
    //==========================================================
`ifdef TDT_DM_GROUP_TRI_EN
  `ifdef TDT_DM_SINGLE_CORE
    assign harthalt_2_harthalt = 1'b0;
  `else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_harthalt_2_harthalt_h
            for (j=0; j<CORE_NUM; j=j+1) begin : gen_harthalt_2_harthalt_l
                if (i==j) begin : gen_equal_hartha //ban self halt req
                    assign harthalt_2_harthalt[i*CORE_NUM+j] = 1'b0; 
                end else begin : gen_nequal_hartha
                    assign harthalt_2_harthalt[i*CORE_NUM+j] = core_haltgp_info[i] == core_haltgp_info[j];
                end
            end
        end
    endgenerate
  `endif
`endif  
`ifdef TDT_DM_EXT_TRIGGER_EN
  `ifdef TDT_DM_SINGLE_CORE
    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_harthalt_2_exttrio_h
                assign harthalt_2_exttrio[i*CORE_NUM] = core_haltgp_info[3:0] == exttriout_haltgp_info[i];
        end
    endgenerate
  `else
    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_harthalt_2_exttrio_h
            for (j=0; j<CORE_NUM; j=j+1) begin : gen_harthalt_2_exttrio_l
                assign harthalt_2_exttrio[i*CORE_NUM+j] = core_haltgp_info[j] == exttriout_haltgp_info[i];
            end
        end
    endgenerate
  `endif
    
    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_exttriihalt_2_exttrio_h
            for (j=0; j<EXTHALTTRI_NUM; j=j+1) begin : gen_exttriihalt_2_exttrio_l
                assign exttriihalt_2_exttrio[i*EXTHALTTRI_NUM+j] = exttriin_haltgp_info[j] == exttriout_haltgp_info[i];
            end
        end
    endgenerate
  `ifdef TDT_DM_SINGLE_CORE
    generate
        for (j=0; j<EXTHALTTRI_NUM; j=j+1) begin : gen_exttriihalt_2_harthalt_l
            assign exttriihalt_2_hart[j] = exttriin_haltgp_info[j] == core_haltgp_info[3:0];
        end
    endgenerate
  `else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_exttriihalt_2_harthalt_h
            for (j=0; j<EXTHALTTRI_NUM; j=j+1) begin : gen_exttriihalt_2_harthalt_l
                assign exttriihalt_2_hart[i*EXTHALTTRI_NUM+j] = exttriin_haltgp_info[j] == core_haltgp_info[i];
            end
        end
    endgenerate
  `endif
`endif
`ifdef TDT_DM_GROUP_TRI_EN 
  `ifdef TDT_DM_SINGLE_CORE
    assign hartresume_2_hartresume = 1'b0;
  `else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hartresume_2_hartresume_h
            for (j=0; j<CORE_NUM; j=j+1) begin : gen_hartresume_2_hartresume_l
                if (i==j) begin : gen_equal_hartres
                    assign hartresume_2_hartresume[i*CORE_NUM+j] = 1'b0;
                end else begin : gen_nequal_hartres
                    assign hartresume_2_hartresume[i*CORE_NUM+j] = core_resumegp_info[i] == core_resumegp_info[j];
                end
            end
        end
    endgenerate
  `endif
`endif 
`ifdef TDT_DM_EXT_TRIGGER_EN
  `ifdef TDT_DM_SINGLE_CORE
    generate
        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_hartresume_2_exttrio_h
            assign hartresume_2_exttrio[i*CORE_NUM] = core_resumegp_info[3:0] == exttriout_resumegp_info[i];
        end
    endgenerate
  `else
    generate
        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_hartresume_2_exttrio_h
            for (j=0; j<CORE_NUM; j=j+1) begin : gen_hartresume_2_exttrio_l
                assign hartresume_2_exttrio[i*CORE_NUM+j] = core_resumegp_info[j] == exttriout_resumegp_info[i];
            end
        end
    endgenerate
  `endif
    
    generate
        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_exttriiresume_2_exttrio_h
            for (j=0; j<EXTRESUMETRI_NUM; j=j+1) begin : gen_exttriiresume_2_exttrio_l
                assign exttriiresume_2_exttrio[i*EXTHALTTRI_NUM+j] = exttriin_resumegp_info[j] == exttriout_resumegp_info[i];
            end
        end
    endgenerate
  `ifdef TDT_DM_SINGLE_CORE
    generate
        for (j=0; j<EXTHALTTRI_NUM; j=j+1) begin : gen_exttriiresume_2_hartresume_l
            assign exttriiresume_2_hart[j] = exttriin_resumegp_info[j] == core_resumegp_info[3:0];
        end
    endgenerate
  `else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_exttriiresume_2_hartresume_h
            for (j=0; j<EXTHALTTRI_NUM; j=j+1) begin : gen_exttriiresume_2_hartresume_l
                assign exttriiresume_2_hart[i*EXTHALTTRI_NUM+j] = exttriin_resumegp_info[j] == core_resumegp_info[i];
            end
        end
    endgenerate
  `endif
`endif


`ifdef TDT_DM_EXT_TRIGGER_EN
  `ifdef TDT_DM_SINGLE_CORE
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume <= 1'b0;
        else if ((gp_hart2hart_resume_req | gp_exttrii2hart_resume_req)
                 && core_resumegp_info[3:0] != 4'h0) 
            sel_hart_pend_resume <= 1'b1;
        else if (~busy)    
            sel_hart_pend_resume <= 1'b0;    
    end
  `else
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume <= 1'b0;
        else if ((gp_hart2hart_resume_req[hartsello[CORE_NUM_W-1:0]] | gp_exttrii2hart_resume_req[hartsello[CORE_NUM_W-1:0]])
                 && core_resumegp_info[hartsello[CORE_NUM_W-1:0]] != 4'h0) 
            sel_hart_pend_resume <= 1'b1;
        else if (~busy)    
            sel_hart_pend_resume <= 1'b0;    
    end
  `endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume_d <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume_d <= 1'b0;
        else     
            sel_hart_pend_resume_d <= sel_hart_pend_resume;    
    end

    assign sel_hart_pend_resume_req = sel_hart_pend_resume_d && ~sel_hart_pend_resume;
`else 
  `ifdef TDT_DM_GROUP_TRI_EN
    `ifdef TDT_DM_SINGLE_CORE
     always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume <= 1'b0;
        else if (gp_hart2hart_resume_req && core_resumegp_info[3:0] != 4'h0) 
            sel_hart_pend_resume <= 1'b1;
        else if (~busy)    
            sel_hart_pend_resume <= 1'b0;    
    end
   `else
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume <= 1'b0;
        else if (gp_hart2hart_resume_req[hartsello[CORE_NUM_W-1:0]] && core_resumegp_info[hartsello[CORE_NUM_W-1:0]] != 4'h0) 
            sel_hart_pend_resume <= 1'b1;
        else if (~busy)    
            sel_hart_pend_resume <= 1'b0;    
    end
   `endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)   
            sel_hart_pend_resume_d <= 1'b0;
        else if (sync_rst) 
            sel_hart_pend_resume_d <= 1'b0;
        else     
            sel_hart_pend_resume_d <= sel_hart_pend_resume;    
    end

    assign sel_hart_pend_resume_req = sel_hart_pend_resume_d && ~sel_hart_pend_resume;

  `endif
`endif

`ifdef TDT_DM_SINGLE_CORE
            assign nor_halt_req = hart_sel && haltreq_raise;
            assign nor_halt_req_clr = hart_sel && haltreq_fall;

  `ifdef TDT_DM_GROUP_TRI_EN    
            assign gp_hart2hart_halt_req = core_dm_halted_req & harthalt_2_harthalt;
  `endif

  `ifdef TDT_DM_EXT_TRIGGER_EN
            assign gp_exttrii2hart_halt_req = pad_dm_halt_req_i[EXTHALTTRI_NUM-1:0] & exttriihalt_2_hart[EXTHALTTRI_NUM-1: 0];
            assign hart_halt_req_en = nor_halt_req | 
                                         ((gp_hart2hart_halt_req | gp_exttrii2hart_halt_req) && core_haltgp_info[3:0] != 4'h0);
  `else
    `ifdef TDT_DM_GROUP_TRI_EN    
            assign hart_halt_req_en = nor_halt_req | (gp_hart2hart_halt_req && core_haltgp_info[3:0] != 4'h0);
    `else
            assign hart_halt_req_en = nor_halt_req;
    `endif
  `endif
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_halt_req_o <= 1'b0;
                else if (sync_rst) 
                    dm_core_halt_req_o <= 1'b0;
                else if (core_dm_halted_i | nor_halt_req_clr)
                    dm_core_halt_req_o <= 1'b0;
                else if (hart_halt_req_en)
                    dm_core_halt_req_o <= 1'b1;
            end
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_halt_req_cause_o[1:0] <= 2'b00;
                else if (sync_rst) 
                    dm_core_halt_req_cause_o[1:0] <= 2'b00;
  `ifdef TDT_DM_GROUP_TRI_EN    
                else if (gp_hart2hart_halt_req && core_haltgp_info[3:0] != 4'h0)
                    dm_core_halt_req_cause_o[1:0] <= 2'b01;
  `endif
  `ifdef TDT_DM_EXT_TRIGGER_EN
                else if (gp_exttrii2hart_halt_req && core_haltgp_info[3:0] != 4'h0)
                    dm_core_halt_req_cause_o[1:0] <= 2'b01;
  `endif
                else if (nor_halt_req)
                    dm_core_halt_req_cause_o[1:0] <= 2'b00;
            end 

            assign nor_resume_req = hart_sel && resumereq;
  `ifdef TDT_DM_GROUP_TRI_EN    
            assign gp_hart2hart_resume_req = core_dm_resume_req & hartresume_2_hartresume;
  `endif

  `ifdef TDT_DM_EXT_TRIGGER_EN
            assign gp_exttrii2hart_resume_req = pad_dm_resume_req_i[EXTRESUMETRI_NUM-1:0] & exttriiresume_2_hart[EXTRESUMETRI_NUM-1: 0];
            assign hart_resume_req_en = nor_resume_req | ((hartsello == 1'b0) ?
                                           sel_hart_pend_resume_req : 
                   ((gp_hart2hart_resume_req | gp_exttrii2hart_resume_req) && core_resumegp_info[3:0] != 4'h0));
  `else
    `ifdef TDT_DM_GROUP_TRI_EN
            assign hart_resume_req_en] = nor_resume_req | ((hartsello == 1'b0) ? 
                                           sel_hart_pend_resume_req : 
                   (gp_hart2hart_resume_req && core_resumegp_info[3:0] != 4'h0));
    `else
            assign hart_resume_req_en = nor_resume_req;
    `endif
  `endif
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_resume_req_o <= 1'b0;
                else if (sync_rst) 
                    dm_core_resume_req_o <= 1'b0;
                else if (dm_core_resume_req_o)
                    dm_core_resume_req_o <= 1'b0;
                else if (hart_resume_req_en && hartsum0[0])
                    dm_core_resume_req_o <= 1'b1;
            end
 `else//multi-core
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_hart_halt_resume_req
            assign nor_halt_req[i] = hart_sel[i] && haltreq_raise;
            assign nor_halt_req_clr[i] = hart_sel[i] && haltreq_fall;

  `ifdef TDT_DM_GROUP_TRI_EN    
            assign gp_hart2hart_halt_req[i] = |(core_dm_halted_req & harthalt_2_harthalt[i*CORE_NUM +: CORE_NUM]);
  `endif

  `ifdef TDT_DM_EXT_TRIGGER_EN
            assign gp_exttrii2hart_halt_req[i] = |(pad_dm_halt_req_i[EXTHALTTRI_NUM-1:0] & exttriihalt_2_hart[i*EXTHALTTRI_NUM +: EXTHALTTRI_NUM]);
            assign hart_halt_req_en[i] = nor_halt_req[i] | 
                                         ((gp_hart2hart_halt_req[i] | gp_exttrii2hart_halt_req[i]) && core_haltgp_info[i] != 4'h0);
  `else
    `ifdef TDT_DM_GROUP_TRI_EN    
            assign hart_halt_req_en[i] = nor_halt_req[i] | (gp_hart2hart_halt_req[i] && core_haltgp_info[i] != 4'h0);
    `else
            assign hart_halt_req_en[i] = nor_halt_req[i];
    `endif
  `endif
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_halt_req_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_halt_req_o[i] <= 1'b0;
                else if (core_dm_halted_i[i] | nor_halt_req_clr[i])
                    dm_core_halt_req_o[i] <= 1'b0;
                else if (hart_halt_req_en[i])
                    dm_core_halt_req_o[i] <= 1'b1;
            end
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_halt_req_cause_o[i*2 +: 2] <= 2'b00;
                else if (sync_rst) 
                    dm_core_halt_req_cause_o[i*2 +: 2] <= 2'b00;
  `ifdef TDT_DM_GROUP_TRI_EN    
                else if (gp_hart2hart_halt_req[i] && core_haltgp_info[i] != 4'h0)
                    dm_core_halt_req_cause_o[i*2 +: 2] <= 2'b01;
  `endif
  `ifdef TDT_DM_EXT_TRIGGER_EN
                else if (gp_exttrii2hart_halt_req[i] && core_haltgp_info[i] != 4'h0)
                    dm_core_halt_req_cause_o[i*2 +: 2] <= 2'b01;
  `endif
                else if (nor_halt_req[i])
                    dm_core_halt_req_cause_o[i*2 +: 2] <= 2'b00;
            end 

            assign nor_resume_req[i] = hart_sel[i] && resumereq;
  `ifdef TDT_DM_GROUP_TRI_EN    
            assign gp_hart2hart_resume_req[i] = |(core_dm_resume_req & hartresume_2_hartresume[i*CORE_NUM +: CORE_NUM]);
  `endif

  `ifdef TDT_DM_EXT_TRIGGER_EN
            assign gp_exttrii2hart_resume_req[i] = |(pad_dm_resume_req_i[EXTRESUMETRI_NUM-1:0] & exttriiresume_2_hart[i*EXTRESUMETRI_NUM +: EXTRESUMETRI_NUM]);
            assign hart_resume_req_en[i] = nor_resume_req[i] | ((hartsello[CORE_NUM_W-1:0] == i[CORE_NUM_W-1:0]) ?
                                           sel_hart_pend_resume_req : 
                   ((gp_hart2hart_resume_req[i] | gp_exttrii2hart_resume_req[i]) && core_resumegp_info[i] != 4'h0));
  `else
    `ifdef TDT_DM_GROUP_TRI_EN
            assign hart_resume_req_en[i] = nor_resume_req[i] | ((hartsello[CORE_NUM_W-1:0] == i[CORE_NUM_W-1:0]) ? 
                                           sel_hart_pend_resume_req : 
                   (gp_hart2hart_resume_req[i] && core_resumegp_info[i] != 4'h0));
    `else
            assign hart_resume_req_en[i] = nor_resume_req[i];
    `endif
  `endif
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_resume_req_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_resume_req_o[i] <= 1'b0;
                else if (dm_core_resume_req_o[i])
                    dm_core_resume_req_o[i] <= 1'b0;
                else if (hart_resume_req_en[i] && hartsum0[i])
                    dm_core_resume_req_o[i] <= 1'b1;
            end
        end
    endgenerate
`endif
    
`ifdef TDT_DM_EXT_TRIGGER_EN
    generate
        for (i=0; i<EXTHALTTRI_NUM; i=i+1) begin : gen_exttri_halt_req
            assign gp_hart2exttrio_halt_req[i] = |(core_dm_halted_req & harthalt_2_exttrio[i*CORE_NUM +: CORE_NUM]);
            assign gp_exttrii2exttrio_halt_req[i] = |(pad_dm_halt_req_i[EXTHALTTRI_NUM-1:0] & exttriihalt_2_exttrio[i*EXTHALTTRI_NUM +: EXTHALTTRI_NUM]);
            assign ext_halt_req_en[i] = (gp_hart2exttrio_halt_req[i] | gp_exttrii2exttrio_halt_req[i]) && 
                                        exttriout_haltgp_info[i] != 4'h0;
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_pad_halt_req_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_pad_halt_req_o[i] <= 1'b0;
                else if (dm_pad_halt_req_o[i])
                    dm_pad_halt_req_o[i] <= 1'b0;
                else if (ext_halt_req_en[i])
                    dm_pad_halt_req_o[i] <= 1'b1;
            end
        end
    endgenerate
    
    generate
        for (i=0; i<EXTRESUMETRI_NUM; i=i+1) begin : gen_exttri_resume_req
            assign gp_hart2exttrio_resume_req[i] = |(core_dm_resume_req & hartresume_2_exttrio[i*CORE_NUM +: CORE_NUM]);
            assign gp_exttrii2exttrio_resume_req[i] = |(pad_dm_resume_req_i[EXTRESUMETRI_NUM-1:0] & 
                                                        exttriiresume_2_exttrio[i*EXTRESUMETRI_NUM +: EXTRESUMETRI_NUM]);
            assign ext_resume_req_en[i] = (gp_hart2exttrio_resume_req[i] | gp_exttrii2exttrio_resume_req[i]) && 
                                          exttriout_resumegp_info[i] != 4'h0;
    
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_pad_resume_req_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_pad_resume_req_o[i] <= 1'b0;
                else if (dm_pad_resume_req_o[i])
                    dm_pad_resume_req_o[i] <= 1'b0;
                else if (ext_resume_req_en[i])
                    dm_pad_resume_req_o[i] <= 1'b1;
            end
        end
    endgenerate
`endif
    //==========================================================
    //    ABS CMD
    //==========================================================
    assign apbw_abscmd = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_COMMAND;
    assign apbw_abscmdauto = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_ABSTRACTAUTO;
    wire   apbw_accreg_cfg;
    assign apbw_accreg_cfg = apbw_abscmd && dm_pwdata[31:24] == 8'h0 && ~busy && cmderr[2:0] == 3'h0;
    wire   apbw_cuscmd_cfg;
    assign apbw_cuscmd_cfg = apbw_cuscmd && ~cuscmdbusy;
    wire   legal_cmd_sel;
    wire[4:0] hartsum0_idx;
    assign hartsum0_idx[4:0] = {{5-CORE_NUM_W{1'b0}},hartsello};
    assign legal_cmd_sel = ~busy && cmderr[2:0] == 3'h0 && hartsum0[hartsum0_idx[4:0]];

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cmdtype[7:0] <= 8'b0;
        else if (sync_rst) 
            cmdtype[7:0] <= 8'b0;
        else if (apbw_abscmd && ~busy && cmderr[2:0] == 3'h0)
            cmdtype[7:0] <= dm_pwdata[31:24];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            aarpostincrement <= 1'b0;
        else if (sync_rst) 
            aarpostincrement <= 1'b0;
        else if (apbw_accreg_cfg)
            aarpostincrement <= dm_pwdata[19];
    end
  
    wire  aarpostexec_zero;
    assign aarpostexec_zero = 1'b0;

`ifdef TDT_DM_PB_EN 
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            aarpostexec <= 1'b0;
        else if (sync_rst) 
            aarpostexec <= 1'b0;
        else if (apbw_accreg_cfg)
            aarpostexec <= dm_pwdata[18];
    end
`else
    always @ (*) begin
        aarpostexec = aarpostexec_zero;
    end
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            transfer <= 1'b0;
        else if (sync_rst) 
            transfer <= 1'b0;
        else if (apbw_accreg_cfg)
            transfer <= dm_pwdata[17];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            write <= 1'b0;
        else if (sync_rst) 
            write <= 1'b0;
        else if (apbw_accreg_cfg)
            write <= dm_pwdata[16];
    end
   
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            dm_core_wr_flg[1:0] <= 2'b0;
        else if (sync_rst) 
            dm_core_wr_flg[1:0] <= 2'b0;
        else if (apbw_accreg_cfg)
            dm_core_wr_flg[1:0] <= {1'b0, dm_pwdata[16]};
        else if (apbw_cuscmd_cfg && dm_pwdata[31:24] == 8'h2)
            dm_core_wr_flg[1:0] <= 2'b10;   
        else if (apbw_cuscmd_cfg && dm_pwdata[31:24] == 8'h3)
            dm_core_wr_flg[1:0] <= 2'b11;
    end

    `ifdef TDT_DM_CORE_RV64
       assign dm_core_wdata[CORE_MAX_XLEN-1:0] = {data1[31:0],data0[31:0]};  
    `else
       assign dm_core_wdata[CORE_MAX_XLEN-1:0] = data0[31:0];
    `endif
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            regno[15:0] <= 16'b0;
        else if (sync_rst) 
            regno[15:0] <= 16'b0;
        else if (apbw_accreg_cfg)
            regno[15:0] <= dm_pwdata[15:0];
        else if (aarpostincrement && cmd_done)
            regno[15:0] <= regno[15:0] + 1'b1;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            autoexecdata[11:0] <= 12'b0;
        else if (sync_rst) 
            autoexecdata[11:0] <= 12'b0;
        else if (apbw_abscmdauto && ~busy)
            autoexecdata[11:0] <= dm_pwdata[11:0];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            autoexecprogbuf[15:0] <= 16'b0;
        else if (sync_rst) 
            autoexecprogbuf[15:0] <= 16'b0;
        else if (apbw_abscmdauto && ~busy)
            autoexecprogbuf[15:0] <= dm_pwdata[31:16];
    end
    
    assign abstractauto[31:0] = {autoexecprogbuf[15:0], 4'b0, autoexecdata[11:0]};
    
    assign apb_access_pb0  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB0;
    assign apb_access_pb1  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB1;
    assign apb_access_pb2  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB2;
    assign apb_access_pb3  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB3;
    assign apb_access_pb4  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB4;
    assign apb_access_pb5  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB5;
    assign apb_access_pb6  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB6;
    assign apb_access_pb7  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB7;
    assign apb_access_pb8  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB8;
    assign apb_access_pb9  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB9;
    assign apb_access_pb10 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB10;
    assign apb_access_pb11 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB11;
    assign apb_access_pb12 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB12;
    assign apb_access_pb13 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB13;
    assign apb_access_pb14 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB14;
    assign apb_access_pb15 = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_PB15; 
    assign apb_access_data0  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_DATA0;
    assign apb_access_data1  = apb_access && dm_paddr[APB_AW-1:2] == OFFSET_DATA1;

    assign apb_access_pb[15:0] = {apb_access_pb15, apb_access_pb14, apb_access_pb13, apb_access_pb12,
                            apb_access_pb11, apb_access_pb10, apb_access_pb9, apb_access_pb8, 
                            apb_access_pb7, apb_access_pb6, apb_access_pb5, apb_access_pb4, 
                            apb_access_pb3, apb_access_pb2, apb_access_pb1, apb_access_pb0};

    assign cmd_busy_set = (|apb_access_pb_real[15:0]) | (|apb_access_data_real[11:0]) | ((dm_psel & dm_penable & dm_pwrite) & 
                          (dm_paddr[APB_AW-1:2] == OFFSET_ABSTRACTCS || 
                           dm_paddr[APB_AW-1:2] == OFFSET_COMMAND || 
                           dm_paddr[APB_AW-1:2] == OFFSET_ITR ||                            
                           dm_paddr[APB_AW-1:2] == OFFSET_ABSTRACTAUTO)) ;
`ifdef TDT_DM_SINGLE_CORE
    assign core_dm_itr_done_pad = core_dm_itr_done_i;
    assign core_dm_exce_retire_pad = core_dm_exce_retire_i;
    assign itr_vld_pad = itr_vld;
    assign core_dm_wr_ready_pad = core_dm_wr_ready;

    assign core_dm_itr_done_mux_pre = core_dm_itr_done_pad;
    assign core_dm_exce_retire_mux_pre = core_dm_exce_retire_pad;
`else
    assign core_dm_itr_done_pad[CORE_NUM-1:0] = core_dm_itr_done_i[CORE_NUM-1:0];
    assign core_dm_exce_retire_pad[CORE_NUM-1:0] = core_dm_exce_retire_i[CORE_NUM-1:0];
    assign itr_vld_pad[CORE_NUM-1:0] = itr_vld[CORE_NUM-1:0];
    assign core_dm_wr_ready_pad[CORE_NUM-1:0] = core_dm_wr_ready[CORE_NUM-1:0];

    assign core_dm_itr_done_mux_pre = core_dm_itr_done_pad[hartsello[CORE_NUM_W-1:0]];
    assign core_dm_exce_retire_mux_pre = core_dm_exce_retire_pad[hartsello[CORE_NUM_W-1:0]];
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_dm_itr_done_mux <= 1'b0;
        else if (sync_rst) 
            core_dm_itr_done_mux <= 1'b0;    
        else if (core_dm_itr_done_mux)
            core_dm_itr_done_mux <= 1'b0;    
        else if (core_dm_itr_done_mux_pre)
            core_dm_itr_done_mux <= 1'b1;    
    end
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_dm_exce_retire_mux <= 1'b0;
        else if (sync_rst) 
            core_dm_exce_retire_mux <= 1'b0;    
        else if (core_dm_exce_retire_mux)
            core_dm_exce_retire_mux <= 1'b0;    
        else if (core_dm_exce_retire_mux_pre)
            core_dm_exce_retire_mux <= 1'b1;    
    end

`ifdef TDT_DM_SINGLE_CORE
    assign itr_vld_mux = itr_vld_pad;
    assign core_dm_wr_ready_mux = core_dm_wr_ready_pad;
`else
    assign itr_vld_mux = itr_vld_pad[hartsello[CORE_NUM_W-1:0]];
    assign core_dm_wr_ready_mux = core_dm_wr_ready_pad[hartsello[CORE_NUM_W-1:0]];
`endif

`ifdef TDT_DM_PB_EN 
    generate 
        for (i=0; i<16; i=i+1) begin : gen_acc_pb_real
            if (i<PB_SIZE) begin : gen_acc_pb_real_0
                assign apb_access_pb_real[i] = apb_access_pb[i];
            end else begin : gen_acc_pb_real_1
                assign apb_access_pb_real[i] = 1'b0;
            end
        end
    endgenerate
`else
    assign apb_access_pb_real[15:0] = 16'h0;
`endif

    `ifdef TDT_DM_CORE_RV64
       assign apb_access_data_real[11:0] = {10'h0, apb_access_data1, apb_access_data0};
    `else
       assign apb_access_data_real[11:0] = {11'h0, apb_access_data0};
    `endif

    assign autoaccen = (|(apb_access_data_real[11:0] & autoexecdata[11:0])) ||
                       (|(apb_access_pb_real[15:0] & autoexecprogbuf[15:0]));
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cmd_start <= 1'b0;
        else if (sync_rst) 
            cmd_start <= 1'b0;
        else if (cmd_start)
            cmd_start <= 1'b0;
`ifdef TDT_ACC_CSR            
        else if ((transfer && autoaccen && cmdtype[7:0] == 8'h0 && regno[15:0] < 16'h1020)|| 
                 (apbw_abscmd && dm_pwdata[31:24] == 8'h0 && (dm_pwdata[15:0] < 16'h1020) && dm_pwdata[17] && ~aarsize_err))
`else
        else if ((transfer && autoaccen && cmdtype[7:0] == 8'h0 && regno[15:5] == 11'h080) || 
                 (apbw_abscmd && dm_pwdata[31:24] == 8'h0 && dm_pwdata[15:5] == 11'h080 && dm_pwdata[17] && ~aarsize_err))
`endif
            cmd_start <= 1'b1;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cmd_work <= 1'b0;
        else if (sync_rst) 
            cmd_work <= 1'b0;
        else if (cmd_done)
            cmd_work <= 1'b0;
        else if (cmd_start && transfer && legal_cmd_sel)
            cmd_work <= 1'b1;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cmd_done <= 1'b0;
        else if (sync_rst) 
            cmd_done <= 1'b0;
        else if (cmd_done)
            cmd_done <= 1'b0;
        else if (regacc_nxt_state[3:0] == REGACC_IDLE && regacc_cur_state[3:0] != REGACC_IDLE)
            cmd_done <= 1'b1;
    end
    
    assign pb_mux[31:0] = progbuf[pb_idx];

    wire [3:0] pb_4zero;
    wire       pb_work_zero;
    assign  pb_4zero[3:0] = 4'h0;
    assign  pb_work_zero = 1'b0;

`ifdef TDT_DM_PB_EN    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            pb_idx[3:0] <= 4'h0;
        else if (sync_rst) 
            pb_idx[3:0] <= 4'h0;
        else if (core_dm_itr_done_mux && core_dm_exce_retire_mux)
            pb_idx[3:0] <= 4'h0;
        else if (ebk_work && core_dm_itr_done_mux)
            pb_idx[3:0] <= 4'h0;
        else if (pb_work && core_dm_itr_done_mux)
            pb_idx[3:0] <= pb_idx[3:0] + 1'b1;
    end
     
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            ebk_work <= 1'b0;
        else if (sync_rst) 
            ebk_work <= 1'b0;
        else if (ebk_work && core_dm_itr_done_mux)
            ebk_work <= 1'b0;
        else if (pb_work && itr_vld_mux && (pb_mux[31:0] == TDT_DM_RV_EBREAK || pb_mux[31:0] == TDT_DM_RV_CEBREAK))
            ebk_work <= 1'b1;
    end
    
    assign pb_work_start = (apbw_abscmd && dm_pwdata[31:24] == 8'h0 && dm_pwdata[18] && !dm_pwdata[17] && ~busy) || 
                           (transfer && cmd_done && aarpostexec) || (autoaccen && aarpostexec && !transfer && ~busy);

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            pb_work <= 1'b0;
        else if (sync_rst) 
            pb_work <= 1'b0;
        else if (pb_work && (ebk_work || core_dm_exce_retire_mux) && core_dm_itr_done_mux)
            pb_work <= 1'b0;
        else if (pb_work_start && hartsum0[hartsum0_idx[4:0]] && cmderr[2:0] == 3'h0)
            pb_work <= 1'b1;
    end
`else
    always @ (*) begin
        pb_idx[3:0] = pb_4zero[3:0];
    end

    always @ (*) begin
        ebk_work = pb_work_zero;
    end

    assign pb_work_start = 1'b0;

    always @ (*) begin
        pb_work = pb_work_zero;
    end
`endif

    assign busy = pb_work | cmd_work | itr_work;

`ifdef TDT_DM_PB_EN
    assign progbufsize[4:0] = `PB_SIZE_WITH_WIDTH;
`else 
    assign progbufsize[4:0] = 5'h0;
`endif

    assign dm_core_itr_o[31:0] = itr[31:0];
    
    //wire  aarsize_err;
    `ifdef TDT_DM_CORE_RV64
       assign aarsize_err =  dm_pwdata[22:20] != 3'h3 && (dm_pwdata[16] || dm_pwdata[22:20] != 3'h2);
    `else
       assign aarsize_err = dm_pwdata[22:20] != 3'h2;
    `endif

    wire dm_paddr_is_itr;
    assign dm_paddr_is_itr = dm_paddr[APB_AW-1:2] == OFFSET_ITR;

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cmderr[2:0] <= 3'h0;
        else if (sync_rst) 
            cmderr[2:0] <= 3'h0;
        else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_ABSTRACTCS && (dm_pwdata[10:8] == 3'b111) && cmderr[2:0] != 0)
            cmderr[2:0] <= 3'h0;
`ifdef TDT_ACC_CSR
        else if ((apbw_abscmd && ((dm_pwdata[31:24] != 8'h0) || (dm_pwdata[17] && ((dm_pwdata[15:0] >= 16'h1020) || aarsize_err))) && ~busy) || 
                 (autoaccen && (cmdtype[7:0] != 8'h0 || (transfer && (regno[15:0] >= 16'h1020)))))
            cmderr[2:0] <= 3'h2;
`else
        else if ((apbw_abscmd && ((dm_pwdata[31:24] != 8'h0) || (dm_pwdata[17] && ((dm_pwdata[15:5] != 11'h080) || aarsize_err))) && ~busy) || 
                 (autoaccen && (cmdtype[7:0] != 8'h0 || (transfer && (regno[15:5] != 11'h080)))))        
            cmderr[2:0] <= 3'h2;
`endif
        else if (core_dm_itr_done_mux && core_dm_exce_retire_mux && busy)
            cmderr[2:0] <= 3'h3;
`ifdef TDT_DM_SINGLE_CORE
        else if ((((dm_intra_apbw && dm_paddr_is_itr) || cmd_start || pb_work_start) && 
                 (!hartsum0[hartsum0_idx[4:0]]) && ~busy) || (itr_vld_en && !hartsum0[hartsum0_idx[4:0]]))
`else
        else if ((((dm_intra_apbw && dm_paddr_is_itr) || cmd_start || pb_work_start) && 
                 (!hartsum0[hartsum0_idx[4:0]]) && ~busy) || (itr_vld_en[hartsello[CORE_NUM_W-1:0]] && !hartsum0[hartsum0_idx[4:0]]))
`endif
            cmderr[2:0] <= 3'h4;
        else if (busy && cmderr[2:0] == 3'h0 && cmd_busy_set)
            cmderr[2:0] <= 3'h1;
    end
   
    `ifdef TDT_DM_CORE_RV64
       assign datacount[3:0] = 4'h2;
    `else
       assign datacount[3:0] = 4'h1;
    `endif

    assign abstractcs[31:0] = {3'b0, progbufsize[4:0], 11'b0, busy, 1'b0, cmderr[2:0], 4'b0, datacount[3:0]};

 
    //==========================================================
    //    ABS_CMD FSM
    //==========================================================
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            regacc_cur_state[3:0] <= 4'h0;
        else if (sync_rst) 
            regacc_cur_state[3:0] <= 4'h0;
        else 
            regacc_cur_state[3:0] <= regacc_nxt_state[3:0];
    end

    wire not_acc_dsc0;
    assign not_acc_dsc0 = regno[15:0] != 16'h7b2;

    always @ (regacc_cur_state[3:0]
              or legal_cmd_sel
              or access_csr
              or core_dm_itr_done_mux
              or access_illegal_reg
              or access_dsc0
              or access_gpr
              or cmd_start
              or transfer
              or core_dm_wr_ready_mux
              or core_rdata_vld_r
              or write
              or not_acc_dsc0) 
    begin
        case (regacc_cur_state[3:0])
            REGACC_IDLE : if (transfer && cmd_start && (~access_illegal_reg) && legal_cmd_sel) begin
                              if (write) 
                                  regacc_nxt_state[3:0] = REGACC_WDSC0;
                              else if (access_gpr)
                                  regacc_nxt_state[3:0] = REGACC_G_2_DSC0; 
                              else if (access_dsc0)
                                  regacc_nxt_state[3:0] = REGACC_RDSC0; 
                              else if (access_csr)
                                  regacc_nxt_state[3:0] = REGACC_X6_2_DSC1;
                              else  
                                  regacc_nxt_state[3:0] = REGACC_IDLE;
                          end else begin
                                  regacc_nxt_state[3:0] = REGACC_IDLE;
                          end
            REGACC_WDSC0 : if (core_dm_wr_ready_mux) begin
                               if (access_gpr)
                                  regacc_nxt_state[3:0] = REGACC_DSC0_2_G;
                               else if (access_dsc0)
                                  regacc_nxt_state[3:0] = REGACC_IDLE;
                               else if (access_csr)
                                  regacc_nxt_state[3:0] = REGACC_X6_2_DSC1;
                               else  
                                  regacc_nxt_state[3:0] = REGACC_WDSC0;
                           end else begin
                                  regacc_nxt_state[3:0] = REGACC_WDSC0;
                           end
            REGACC_G_2_DSC0 : if (core_dm_itr_done_mux) begin
                                  regacc_nxt_state[3:0] = REGACC_RDSC0;
                              end else begin
                                  regacc_nxt_state[3:0] = REGACC_G_2_DSC0;
                              end
            REGACC_RDSC0 : if (core_rdata_vld_r) begin
                                  regacc_nxt_state[3:0] = REGACC_IDLE;
                           end else begin
                                  regacc_nxt_state[3:0] = REGACC_RDSC0;
                           end
            REGACC_X6_2_DSC1 : if (core_dm_itr_done_mux) begin
                                   if (access_csr && not_acc_dsc0) begin
                                       if (write)
                                           regacc_nxt_state[3:0] = REGACC_DSC0_2_X6;
                                       else 
                                           regacc_nxt_state[3:0] = REGACC_C_2_X6;           
                                   end else begin
                                           regacc_nxt_state[3:0] = REGACC_X6_2_DSC1; 
                                   end          
                               end else begin
                                           regacc_nxt_state[3:0] = REGACC_X6_2_DSC1;           
                               end
            REGACC_DSC0_2_G : if (core_dm_itr_done_mux) begin
                                  regacc_nxt_state[3:0] = REGACC_IDLE;
                              end else begin
                                  regacc_nxt_state[3:0] = REGACC_DSC0_2_G;           
                              end
            REGACC_DSC1_2_X6 : if (core_dm_itr_done_mux) begin
                                   if (access_csr && not_acc_dsc0) begin
                                       if (write)
                                           regacc_nxt_state[3:0] = REGACC_IDLE;
                                       else 
                                           regacc_nxt_state[3:0] = REGACC_RDSC0;           
                                   end else begin
                                           regacc_nxt_state[3:0] = REGACC_DSC1_2_X6;           
                                   end
                               end else begin
                                           regacc_nxt_state[3:0] = REGACC_DSC1_2_X6;           
                               end
            REGACC_DSC0_2_X6 : if (core_dm_itr_done_mux) begin
                                   regacc_nxt_state[3:0] = REGACC_X6_2_C;                                  
                               end else begin
                                   regacc_nxt_state[3:0] = REGACC_DSC0_2_X6;           
                               end
            REGACC_X6_2_DSC0 : if (core_dm_itr_done_mux) begin
                                   regacc_nxt_state[3:0] = REGACC_DSC1_2_X6;                                  
                               end else begin
                                   regacc_nxt_state[3:0] = REGACC_X6_2_DSC0;           
                               end
            REGACC_C_2_X6 : if (core_dm_itr_done_mux) begin
                                   regacc_nxt_state[3:0] = REGACC_X6_2_DSC0;                                  
                            end else begin
                                   regacc_nxt_state[3:0] = REGACC_C_2_X6;           
                            end
            REGACC_X6_2_C : if (core_dm_itr_done_mux) begin
                                   regacc_nxt_state[3:0] = REGACC_DSC1_2_X6;                                  
                            end else begin
                                   regacc_nxt_state[3:0] = REGACC_X6_2_C;           
                            end
            default : regacc_nxt_state[3:0] = REGACC_IDLE;
        endcase
    end
    //==========================================================
    //    ITR and DCC
    //==========================================================
    assign access_gpr  = (cmdtype[7:0] == 8'h0) && (regno[15:5] == 11'h080);
`ifdef TDT_ACC_CSR
    assign access_csr  = (cmdtype[7:0] == 8'h0) && (regno[15:12] == 4'h0);
`else
    assign access_csr  = 1'b0;
`endif
    assign access_dsc0 = (cmdtype[7:0] == 8'h0) && (regno[15:0] == 16'h7b2);

`ifdef TDT_ACC_CSR
    assign access_illegal_reg = (cmdtype[7:0] == 8'h0) && (regno[15:0] >= 16'h1020);
`else    
    assign access_illegal_reg = (cmdtype[7:0] == 8'h0) && (regno[15:5] != 11'h080);
`endif
 
`ifdef PROCESSOR_3
   always @ (*) begin
    case(hartsello[CORE_NUM_W-1:0])
        2'b00: sel_core_isa[3:0] = all_core_isa[3:0];
        2'b01: sel_core_isa[3:0] = all_core_isa[7:4];
        2'b10: sel_core_isa[3:0] = all_core_isa[11:8];
        2'b11: sel_core_isa[3:0] = all_core_isa[15:12];
        default:sel_core_isa[3:0] = {4{1'bx}};
     endcase
    end
`else
  `ifdef PROCESSOR_2
    always @ (*) begin
      case(hartsello[CORE_NUM_W-1:0])
          2'b00: sel_core_isa[3:0] = all_core_isa[3:0];
          2'b01: sel_core_isa[3:0] = all_core_isa[7:4];
          2'b10: sel_core_isa[3:0] = all_core_isa[11:8];
          2'b11: sel_core_isa[3:0] = 4'b0;
          default:sel_core_isa[3:0] = {4{1'bx}};
      endcase
    end
  `else
    `ifdef PROCESSOR_1
      always @ (*) begin
       case(hartsello[CORE_NUM_W-1:0])
          1'b0: sel_core_isa[3:0] = all_core_isa[3:0];
          1'b1: sel_core_isa[3:0] = all_core_isa[7:4];
          default:sel_core_isa[3:0] = {4{1'bx}};
      endcase
      end
    `else
      always @ (*) begin  
        sel_core_isa[3:0] = all_core_isa[3:0];
      end
    `endif
  `endif
`endif

    assign fsm_x6_2_dsc1 = regacc_nxt_state[3:0] == REGACC_X6_2_DSC1 && 
        ((regacc_cur_state[3:0] == REGACC_IDLE) || (regacc_cur_state[3:0] == REGACC_WDSC0));
    assign fsm_x6_2_dsc0 = regacc_nxt_state[3:0] == REGACC_X6_2_DSC0 && 
        regacc_cur_state[3:0] == REGACC_C_2_X6;
    assign fsm_dsc1_2_x6 = regacc_nxt_state[3:0] == REGACC_DSC1_2_X6 && 
        ((regacc_cur_state[3:0] == REGACC_X6_2_DSC0) || (regacc_cur_state[3:0] == REGACC_X6_2_C));
    assign fsm_dsc0_2_x6 = regacc_nxt_state[3:0] == REGACC_DSC0_2_X6 && 
        regacc_cur_state[3:0] == REGACC_X6_2_DSC1;
    assign fsm_c_2_x6 = regacc_nxt_state[3:0] == REGACC_C_2_X6 && 
        regacc_cur_state[3:0] == REGACC_X6_2_DSC1;
    assign fsm_x6_2_c = regacc_nxt_state[3:0] == REGACC_X6_2_C && 
        regacc_cur_state[3:0] == REGACC_DSC0_2_X6;

`ifdef TDT_DM_PB_EN
    assign itr_send_pb = (pb_work_start && hartsum0[hartsum0_idx[4:0]]) || 
                         (pb_work && !ebk_work && core_dm_itr_done_mux && !core_dm_exce_retire_mux);
`else
    assign itr_send_pb = 1'b0;
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            itr_send_pb_r <= 1'b0;
        else if (sync_rst) 
            itr_send_pb_r <= 1'b0;
        else if (itr_send_pb_r)
            itr_send_pb_r <= 1'b0;
        else if (itr_send_pb)
            itr_send_pb_r <= 1'b1;

    end

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            itr[31:0] <= 32'b0; 
        else if (sync_rst) 
            itr[31:0] <= 32'b0; 
        else if(dm_intra_apbw && dm_paddr_is_itr && legal_cmd_sel)
            itr[31:0] <= dm_pwdata[31:0];
`ifdef TDT_DM_PB_EN
        else if (pb_work)
                itr[31:0] <= pb_mux[31:0];
`endif
        else if (access_gpr) begin
            if (transfer && !write && cmd_start && legal_cmd_sel)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR0_ADDR, regno[4:0], 
                              TDT_DM_RV_CSRRW_FUNC3, TDT_DM_RV_ZERO_GPR, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (write && core_dm_wr_ready_mux)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR0_ADDR, TDT_DM_RV_ZERO_GPR, 
                              TDT_DM_RV_CSRRC_FUNC3, regno[4:0], TDT_DM_RV_SYSTEM_OPCODE};
                endcase
        end 
`ifdef TDT_ACC_CSR
        else if (access_csr && not_acc_dsc0) begin
            if (fsm_x6_2_dsc1) 
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR1_ADDR, 5'h6, 
                              TDT_DM_RV_CSRRW_FUNC3, TDT_DM_RV_ZERO_GPR, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (fsm_x6_2_dsc0)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR0_ADDR, 5'h6, 
                              TDT_DM_RV_CSRRW_FUNC3, TDT_DM_RV_ZERO_GPR, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (fsm_dsc1_2_x6)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR1_ADDR, TDT_DM_RV_ZERO_GPR, 
                              TDT_DM_RV_CSRRC_FUNC3, 5'h6, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (fsm_dsc0_2_x6)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {TDT_DM_RV_DSCR0_ADDR, TDT_DM_RV_ZERO_GPR, 
                              TDT_DM_RV_CSRRC_FUNC3, 5'h6, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (fsm_c_2_x6)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {regno[11:0],TDT_DM_RV_ZERO_GPR, 
                              TDT_DM_RV_CSRRC_FUNC3, 5'h6, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
            else if (fsm_x6_2_c)
                case (sel_core_isa[3:0]) 
                    default : itr[31:0] <= {regno[11:0], 5'h6, 
                              TDT_DM_RV_CSRRW_FUNC3, TDT_DM_RV_ZERO_GPR, TDT_DM_RV_SYSTEM_OPCODE};
                endcase
        end 
`endif
    end

`ifdef TDT_DM_SINGLE_CORE
            assign itr_vld_en =  (hartsello == 1'b0) && 
                                    ((dm_intra_apbw && dm_paddr_is_itr && ~busy && hartsum0[0]) ||
                                    (access_gpr && ((write && core_dm_wr_ready_pad) || 
                                    (!write && transfer && cmd_start && ~busy && hartsum0[0]))) 
  `ifdef TDT_ACC_CSR
                                    || 
                                    (access_csr && (regno[15:0] != 16'h7b2) && 
                                    (fsm_x6_2_c || fsm_c_2_x6 || fsm_dsc0_2_x6 || fsm_dsc1_2_x6 || fsm_x6_2_dsc1 || fsm_x6_2_dsc0)) 
  `endif 
  `ifdef TDT_DM_PB_EN
                                    || itr_send_pb_r
  `endif
                                    );

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    itr_vld <= 1'b0;
                else if (sync_rst) 
                    itr_vld <= 1'b0;
                else if (itr_vld)
                    itr_vld <= 1'b0;
                else if (itr_vld_en)
                    itr_vld <= 1'b1;
            end
    
    assign dm_core_itr_vld_o = itr_vld;
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            itr_work <= 1'b0;
        else if (sync_rst) 
            itr_work <= 1'b0;
        else if (core_dm_itr_done_mux)
            itr_work <= 1'b0;
        else if (dm_intra_apbw && dm_paddr_is_itr && ~busy && hartsum0[hartsum0_idx[4:0]])
            itr_work <= 1'b1;
    end

            assign dm_core_wr_vld_en = hartsello == 1'b0 && ((transfer && 
                                         ((regacc_cur_state[3:0] == REGACC_IDLE && regacc_nxt_state[3:0] == REGACC_WDSC0) || 
                                         (((regacc_cur_state[3:0] == REGACC_IDLE) || (regacc_cur_state[3:0] == REGACC_G_2_DSC0) || 
                                         (regacc_cur_state[3:0] == REGACC_DSC1_2_X6)) && regacc_nxt_state[3:0] == REGACC_RDSC0))) ||
                                         (~cuscmdbusy && apbw_cuscmd && (dm_pwdata[31:24] == 8'h2 || dm_pwdata[31:24] == 8'h3)));

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_wr_vld <= 1'b0;
                else if (sync_rst) 
                    dm_core_wr_vld <= 1'b0;
                else if (dm_core_wr_vld_en)
                    dm_core_wr_vld <= 1'b1;
                else if (dm_core_wr_vld)
                    dm_core_wr_vld <= 1'b0;
            end
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_itr_vld
            assign itr_vld_en[i] =  (hartsello[CORE_NUM_W-1:0] == i[CORE_NUM_W-1:0]) && 
                                    ((dm_intra_apbw && dm_paddr_is_itr && ~busy && hartsum0[i]) ||
                                    (access_gpr && ((write && core_dm_wr_ready_pad[i]) || 
                                    (!write && transfer && cmd_start && ~busy && hartsum0[i]))) 
  `ifdef TDT_ACC_CSR
                                    || 
                                    (access_csr && (regno[15:0] != 16'h7b2) && 
                                    (fsm_x6_2_c || fsm_c_2_x6 || fsm_dsc0_2_x6 || fsm_dsc1_2_x6 || fsm_x6_2_dsc1 || fsm_x6_2_dsc0)) 
  `endif 
  `ifdef TDT_DM_PB_EN
                                    || itr_send_pb_r
  `endif
                                    );

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    itr_vld[i] <= 1'b0;
                else if (sync_rst) 
                    itr_vld[i] <= 1'b0;
                else if (itr_vld[i])
                    itr_vld[i] <= 1'b0;
                else if (itr_vld_en[i])
                    itr_vld[i] <= 1'b1;
            end
        end
    endgenerate
    
    assign dm_core_itr_vld_o[CORE_NUM-1:0] = itr_vld[CORE_NUM-1:0];
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            itr_work <= 1'b0;
        else if (sync_rst) 
            itr_work <= 1'b0;
        else if (core_dm_itr_done_mux)
            itr_work <= 1'b0;
        else if (dm_intra_apbw && dm_paddr_is_itr && ~busy && hartsum0[hartsum0_idx[4:0]])
            itr_work <= 1'b1;
    end
    
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_dm_core_wr_vld
            assign dm_core_wr_vld_en[i] = hartsello[CORE_NUM_W-1:0] == i[CORE_NUM_W-1:0] && ((transfer && 
                                         ((regacc_cur_state[3:0] == REGACC_IDLE && regacc_nxt_state[3:0] == REGACC_WDSC0) || 
                                         (((regacc_cur_state[3:0] == REGACC_IDLE) || (regacc_cur_state[3:0] == REGACC_G_2_DSC0) || 
                                         (regacc_cur_state[3:0] == REGACC_DSC1_2_X6)) && regacc_nxt_state[3:0] == REGACC_RDSC0))) ||
                                         (~cuscmdbusy && apbw_cuscmd && (dm_pwdata[31:24] == 8'h2 || dm_pwdata[31:24] == 8'h3)));

            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_wr_vld[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_wr_vld[i] <= 1'b0;
                else if (dm_core_wr_vld_en[i])
                    dm_core_wr_vld[i] <= 1'b1;
                else if (dm_core_wr_vld[i])
                    dm_core_wr_vld[i] <= 1'b0;
            end
        end
    endgenerate
`endif
    
    //==========================================================
    //    data
    //==========================================================
`ifdef TDT_DM_SINGLE_CORE
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    core_rdata_r[CORE_MAX_XLEN-1:0] <= {CORE_MAX_XLEN{1'b0}};
                else if (sync_rst) 
                    core_rdata_r[CORE_MAX_XLEN-1:0] <= {CORE_MAX_XLEN{1'b0}};
                else if (core_dm_wr_ready_pad && dm_core_wr_flg != 2'b01)
                    core_rdata_r[CORE_MAX_XLEN-1:0] <= core_dm_rx_data[CORE_MAX_XLEN-1:0];
            end
            assign core_rdata_mux[CORE_MAX_XLEN-1:0] = core_rdata_r[CORE_MAX_XLEN-1:0];
`else
    generate
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_core_rdata_r
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    core_rdata_r[i] <= {CORE_MAX_XLEN{1'b0}};
                else if (sync_rst) 
                    core_rdata_r[i] <= {CORE_MAX_XLEN{1'b0}};
                else if (core_dm_wr_ready_pad[i] && dm_core_wr_flg != 2'b01)
                    core_rdata_r[i] <= core_dm_rx_data[CORE_MAX_XLEN*i +: CORE_MAX_XLEN];
            end
        end
    endgenerate
    assign core_rdata_mux[CORE_MAX_XLEN-1:0] = core_rdata_r[hartsello[CORE_NUM_W-1:0]];
`endif
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            core_rdata_vld_r <= 1'b0;
        else if (sync_rst) 
            core_rdata_vld_r <= 1'b0;
        else if (core_dm_wr_ready_mux)
            core_rdata_vld_r <= 1'b1;
        else if (core_rdata_vld_r)
            core_rdata_vld_r <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            data0[31:0] <= 32'b0;
        else if (sync_rst) 
            data0[31:0] <= 32'b0;
        else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_DATA0 && ~busy)
            data0[31:0] <= dm_pwdata[31:0];
        else if (core_rdata_vld_r && dm_core_wr_flg != 2'b01) 
            data0[31:0] <= core_rdata_mux[31:0];
`ifdef TDT_DM_BUF_MOVE        
        else if (internal_move_start && dst_type[1:0] == 2'b00 && dst_reg[3:0] == 4'h0) 
            data0[31:0] <= src_data_mux[31:0];
`endif
    end
   
    wire [31:0] data_zero32;
    assign data_zero32[31:0] = 32'h0;

`ifdef TDT_DM_CORE_RV64
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    data1[31:0] <= 32'b0;
                else if (sync_rst) 
                    data1[31:0] <= 32'b0;
                else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_DATA1 && ~busy)
                    data1[31:0] <= dm_pwdata[31:0];
                else if (core_rdata_vld_r && dm_core_wr_flg != 2'b01)
                    data1[31:0] <= core_rdata_mux[63:32];
               `ifdef TDT_DM_BUF_MOVE        
                else if (internal_move_start && dst_type[1:0] == 2'b00 && dst_reg[3:0] == 4'h1) 
                    data1[31:0] <= src_data_mux[31:0];
               `endif
            end
`else
            always @ (*) begin
                data1[31:0] = data_zero32[31:0];
            end
`endif
    
    //==========================================================
    //    hartsum
    //==========================================================
`ifdef TDT_DM_SINGLE_CORE
    assign hartsum0[31:0] = {{32-CORE_NUM{1'b0}}, core_dm_halted_i};
`else
    assign hartsum0[31:0] = {{32-CORE_NUM{1'b0}}, core_dm_halted_i[CORE_NUM-1:0]}; 
`endif

    //==========================================================
    //    custom feature
    //==========================================================
    assign apbw_cuscmd = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_CUSCMD;
    
`ifdef TDT_DM_BUF_MOVE        
    assign cusbufcnt[3:0] = `TDT_DM_CUSTOM_BUF_CNT;
`else
    assign cusbufcnt[3:0] = 4'h0;
`endif
    assign coredebuginfo[15:0] = 16'h3;
    
    
    assign customcs[31:0] = {cuscmderr[2:0], cusbufcnt[3:0], 7'h0, cuscmdbusy, 1'b0, coredebuginfo[15:0]};
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cuscmderr[2:0] <= 3'h0;
        else if (sync_rst) 
            cuscmderr[2:0] <= 3'h0;
        else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_CUSCS && dm_pwdata[31:29] == 3'b111)
            cuscmderr[2:0] <= 3'h0;        
        else if (apbw_cuscmd) begin
`ifdef TDT_DM_BUF_MOVE        
            if (dm_pwdata[31:24] > 8'h3)
`else 
            if (dm_pwdata[31:24] > 8'h3 || dm_pwdata[31:24] == 8'h1 )
`endif
                cuscmderr[2:0] <= 3'h2;
            else if (cuscmdbusy && apbw_cuscmd && (dm_pwdata[31:24] == 8'h2 || dm_pwdata[31:24] == 8'h3))
                cuscmderr[2:0] <= 3'h1;            
            else 
                cuscmderr[2:0] <= 3'h0;
        end
    end
    
`ifdef TDT_DM_BUF_MOVE  
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            src_type[1:0] <= 2'h0;
        else if (sync_rst) 
            src_type[1:0] <= 2'h0;
        else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h1)
            src_type[1:0] <= dm_pwdata[23:22];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            dst_type[1:0] <= 2'h0;
        else if (sync_rst) 
            dst_type[1:0] <= 2'h0;
        else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h1)
            dst_type[1:0] <= dm_pwdata[21:20];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            src_reg[3:0] <= 4'h0;
        else if (sync_rst) 
            src_reg[3:0] <= 4'h0;
        else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h1)
            src_reg[3:0] <= dm_pwdata[7:4];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            dst_reg[3:0] <= 4'h0;
        else if (sync_rst) 
            dst_reg[3:0] <= 4'h0;
        else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h1)
            dst_reg[3:0] <= dm_pwdata[3:0];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            internal_move_start <= 1'b0;
        else if (sync_rst) 
            internal_move_start <= 1'b0;
        else if (internal_move_start)
            internal_move_start <= 1'b0;
        else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h1)
            internal_move_start <= 1'b1; 
    end
   
    wire[31:0] datan_for_src_data;
    wire[31:0] cusbufn_for_src_data;
    
   always @ (*) begin
     case (src_reg[3:0])
          4'h0    : datan_for_src_data[31:0] = data0[31:0];
          4'h1    : datan_for_src_data[31:0] = data1[31:0];
          default : datan_for_src_data[31:0] = 32'd0;
      endcase
   end

`ifdef TDT_DM_SBA
   wire[31:0] sbdatan_for_src_data;
   always @ (*) begin
     case (src_reg[3:0])
         4'h0    : sbdatan_for_src_data[31:0] = sbdata0[31:0];
         4'h1    : sbdatan_for_src_data[31:0] = sbdata1[31:0];
         4'h2    : sbdatan_for_src_data[31:0] = sbdata2[31:0];
         4'h3    : sbdatan_for_src_data[31:0] = sbdata3[31:0];
         default : sbdatan_for_src_data[31:0] = 32'd0;
     endcase
   end
`endif

   always @ (*) begin
     case (src_reg[3:0])
         4'h0    : cusbufn_for_src_data[31:0] = cusbuf[0];
         4'h1    : cusbufn_for_src_data[31:0] = cusbuf[1];
         4'h2    : cusbufn_for_src_data[31:0] = cusbuf[2];
         4'h3    : cusbufn_for_src_data[31:0] = cusbuf[3];
         4'h4    : cusbufn_for_src_data[31:0] = cusbuf[4];
         4'h5    : cusbufn_for_src_data[31:0] = cusbuf[5];
         4'h6    : cusbufn_for_src_data[31:0] = cusbuf[6];
         4'h7    : cusbufn_for_src_data[31:0] = cusbuf[7];
         default : cusbufn_for_src_data[31:0] = 32'd0;
     endcase
   end

    always @ (*) begin
        case (src_type[1:0]) 
            2'b00   : src_data_mux[31:0] = datan_for_src_data[31:0];
`ifdef TDT_DM_SBA
            2'b01   : src_data_mux[31:0] = sbdatan_for_src_data[31:0];
`endif
            2'b10   : src_data_mux[31:0] = cusbufn_for_src_data[31:0];
            default : src_data_mux[31:0] = 32'd0;
        endcase 
    end
    
    generate
        for (i=0; i<`TDT_DM_CUSTOM_BUF_CNT; i=i+1) begin : gen_cusbuf
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    cusbuf[i] <= 32'h0;
                else if (sync_rst) 
                    cusbuf[i] <= 32'h0;
  
                else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == (OFFSET_CUSBUF0+i))
                    cusbuf[i] <= dm_pwdata;
                else if (internal_move_start && dst_type[1:0] == 2'b10 && dst_reg[3:0] == i[3:0]) 
                    cusbuf[i] <= src_data_mux[31:0];
            end
        end
    endgenerate
    
    generate
        for (i=0; i<8; i=i+1) begin : gen_cusbuf_all
            if (i >= `TDT_DM_CUSTOM_BUF_CNT) begin : gen_pend_cusbuf
                assign cusbuf_all[i] = 32'h0;
            end else begin : gen_nor_cusbuf_all   
                assign cusbuf_all[i] = cusbuf[i];
            end
        end
    endgenerate 
`endif
 
`ifdef TDT_DM_SINGLE_CORE
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_async_halt_req_o <= 1'b0;
                else if (sync_rst) 
                    dm_core_async_halt_req_o <= 1'b0;
                else if (core_dm_halted_i)
                    dm_core_async_halt_req_o <= 1'b0;
                else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h0 && hart_sel) 
                    dm_core_async_halt_req_o <= 1'b1;
            end
`else
    generate 
        for (i=0; i<CORE_NUM; i=i+1) begin : gen_async_halt
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    dm_core_async_halt_req_o[i] <= 1'b0;
                else if (sync_rst) 
                    dm_core_async_halt_req_o[i] <= 1'b0;
                else if (core_dm_halted_i[i])
                    dm_core_async_halt_req_o[i] <= 1'b0;
                else if (apbw_cuscmd && dm_pwdata[31:24] == 8'h0 && hart_sel[i]) 
                    dm_core_async_halt_req_o[i] <= 1'b1;
            end
        end
    endgenerate
`endif

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            cuscmdbusy <= 1'b0;
        else if (sync_rst) 
            cuscmdbusy <= 1'b0;
        else if (apbw_cuscmd && (dm_pwdata[31:24] == 8'h2 || dm_pwdata[31:24] == 8'h3))
            cuscmdbusy <= 1'b1;
        else if (core_rdata_vld_r)
            cuscmdbusy <= 1'b0;        
    end

    assign vendorid[11:0] = TDT_DM_THEAD_JEP106_ID;
    assign comptype[11:0] = TDT_DM_COMP_TYPE;
    assign compversion[7:0]  = TDT_DM_COMP_VERSION;
    
    assign compid[31:0] = {vendorid[11:0], comptype[11:0], compversion[7:0]};
    
    //=========================================================
    //    system bus access
    //==========================================================
    assign apbw_sbcs = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBCS;

`ifdef TDT_DM_SBA
    always @ (sbaccess[2:0]) begin
        case (sbaccess[2:0])
            3'h2    : sbaddrplus[4:0] = 5'd4;
            3'h3    : sbaddrplus[4:0] = 5'd8;
            3'h4    : sbaddrplus[4:0] = 5'd16;
            default : sbaddrplus[4:0] = 5'd0;
        endcase
    end
    
    assign sbaddr0_plus_pre[32:0] = {1'b0, sbaddr0[31:0]} + {28'b0, sbaddrplus[4:0]};
   
    wire sb_noerr;
    assign sb_noerr = ~sbbusy && ~sbbusyerror && sberror[2:0] == 3'h0;

    wire dm_paddr_is_sbaddr0;
    assign dm_paddr_is_sbaddr0 = dm_paddr[APB_AW-1:2] == OFFSET_SBADDR0;
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbaddr0[31:0] <= 32'h0;
        else if (sync_rst) 
            sbaddr0[31:0] <= 32'h0;
        else if (dm_intra_apbw && dm_paddr_is_sbaddr0 && sb_noerr)
            sbaddr0[31:0] <= dm_pwdata[31:0];
        else if (sbautoincrement && sba_wr_ready)
            sbaddr0[31:0] <= sbaddr0_plus_pre[31:0];
    end
    
    generate
        if (SBAW > 32) begin : gen_sbaddr1
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    sbaddr1[40-32-1:0] <= {40-32{1'b0}};
                else if (sync_rst) 
                    sbaddr1[40-32-1:0] <= {40-32{1'b0}};

                else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR1 && sb_noerr)
                    sbaddr1[40-32-1:0] <= dm_pwdata[40-32-1:0];
                else if (sbautoincrement && sba_wr_ready && sbaddr0_plus_pre[32])
                    sbaddr1[40-32-1:0] <= sbaddr1[40-32-1:0] + 1'b1;
            end

            always @ (*) begin
                sbaddr1[31:SBAW-32] = data_zero32[64-SBAW-1:0];            
            end
        end else begin : gen_dummy_sbaddr1
            always @ (*) begin
                sbaddr1[31:0] = data_zero32[31:0];
            end
        end
    endgenerate
    
    assign sbversion[2:0] = 3'h1;
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbbusy <= 1'b0;
        else if (sync_rst) 
            sbbusy <= 1'b0;
        else if (sba_wr_ready)
            sbbusy <= 1'b0;
        else if (sba_wr_vld)
            sbbusy <= 1'b1;
    end
   
    wire sbbusyerr_set;
    
    generate
        if (SBAW > 32) begin : gen_sbbusyerr_set_64
            assign sbbusyerr_set = (dm_intra_apbw   && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR1) || 
                                   (dm_intra_apbw   && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR0) ||
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA1) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA2) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA3);
        end else begin : gen_sbbusyerr_set_32
            assign sbbusyerr_set = (dm_intra_apbw   && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR0) ||
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA1) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA2) || 
                                   (dm_intra_access && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA3);
        end
    endgenerate
     
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbbusyerror <= 1'b0;
        else if (sync_rst) 
            sbbusyerror <= 1'b0;
        else if (sbbusyerr_set && sbbusy)
            sbbusyerror <= 1'b1;
        else if (apbw_sbcs && dm_pwdata[22])
            sbbusyerror <= 1'b0;
    end
    
    wire sbaccess_unalian;
`ifdef TDT_DM_SBA_DW_128
        assign sbaccess_unalian = ((sbaccess[2:0] == 3'h2) && (|dm_pwdata[1:0])) || 
                                  ((sbaccess[2:0] == 3'h3) && (|dm_pwdata[2:0])) || 
                                  ((sbaccess[2:0] == 3'h4) && (|dm_pwdata[3:0]));
`else 
    `ifdef TDT_DM_SBA_DW_64
        assign sbaccess_unalian = ((sbaccess[2:0] == 3'h2) && (|dm_pwdata[1:0])) || 
                                  ((sbaccess[2:0] == 3'h3) && (|dm_pwdata[2:0]));                                         
    `else
        assign sbaccess_unalian = ((sbaccess[2:0] == 3'h2) && (|dm_pwdata[1:0]));                       
    `endif
`endif
    //sba_error 4 must record,
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sberror_will_be_4 <= 1'b0;
        else if (sync_rst) 
            sberror_will_be_4 <= 1'b0;
        else if (apbw_sbcs && (&dm_pwdata[14:12]))
            sberror_will_be_4 <= 1'b0;
        `ifdef TDT_DM_SBA_DW_128
        else if (apbw_sbcs && ((dm_pwdata[19:17] < 3'h2) || (dm_pwdata[19:17] > 3'h4)) && ~sbbusy)    
`else 
    `ifdef TDT_DM_SBA_DW_64
        else if (apbw_sbcs && ((dm_pwdata[19:17] < 3'h2) || (dm_pwdata[19:17] > 3'h3)) && ~sbbusy)            
    `else
        else if (apbw_sbcs && (dm_pwdata[19:17] != 3'h2) && ~sbbusy)                     

    `endif
`endif
            sberror_will_be_4 <= 1'b1;
        `ifdef TDT_DM_SBA_DW_128
        else if (apbw_sbcs && !((dm_pwdata[19:17] < 3'h2) || (dm_pwdata[19:17] > 3'h4)) && ~sbbusy)    
`else 
    `ifdef TDT_DM_SBA_DW_64
        else if (apbw_sbcs && !((dm_pwdata[19:17] < 3'h2) || (dm_pwdata[19:17] > 3'h3)) && ~sbbusy)            
    `else
        else if (apbw_sbcs && (dm_pwdata[19:17] == 3'h2) && ~sbbusy)                     

    `endif
`endif
            sberror_will_be_4 <= 1'b0;
        end

//sba_error 3 must record, when sba_wr_vld, set sba_error to 3
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sberror_will_be_3 <= 1'b0;
        else if (sync_rst) 
            sberror_will_be_3 <= 1'b0;
        else if (apbw_sbcs && (&dm_pwdata[14:12]))
            sberror_will_be_3 <= 1'b0;
        else if (dm_intra_apbw && dm_paddr_is_sbaddr0 && sbaccess_unalian && ~sbbusy)
            sberror_will_be_3 <= 1'b1;
        else if (dm_intra_apbw && dm_paddr_is_sbaddr0 && !sbaccess_unalian && ~sbbusy)
            sberror_will_be_3 <= 1'b0;
      end

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sberror[2:0] <= 3'h0;
        else if (sync_rst) 
            sberror[2:0] <= 3'h0;
        else if (apbw_sbcs && (&dm_pwdata[14:12]))
            sberror[2:0] <= 3'h0;
        else if (sberror_will_be_4 && (sba_write_ignore_unalign_f || sba_read_ignore_unalign_f) && sb_noerr)                     
            sberror[2:0] <= 3'h4;
        else if (sberror_will_be_3 && (sba_write_ignore_unalign_f || sba_read_ignore_unalign_f) && sb_noerr)
            sberror[2:0] <= 3'h3;
        else if (sba_error && sba_wr_ready)
            sberror[2:0] <= 3'h7;    
    end

    assign sbasize[6:0] = `SBAW_WITH_WIDTH;
    
`ifdef TDT_DM_SBA_DW_128
    assign sbaccess_info[4:0] = 5'b11100;
`else 
    `ifdef TDT_DM_SBA_DW_64
        assign sbaccess_info[4:0] = 5'b01100;
    `else
        assign sbaccess_info[4:0] = 5'b00100;
    `endif
`endif
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbreadonaddr <= 1'b0;
        else if (sync_rst) 
            sbreadonaddr <= 1'b0;
        else if (apbw_sbcs)
            sbreadonaddr <= dm_pwdata[20];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbaccess[2:0] <= 3'h2;
        else if (sync_rst) 
            sbaccess[2:0] <= 3'h2;
        else if (apbw_sbcs)
            sbaccess[2:0] <= dm_pwdata[19:17];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbautoincrement <= 1'b0;
        else if (sync_rst) 
            sbautoincrement <= 1'b0;
        else if (apbw_sbcs)
            sbautoincrement <= dm_pwdata[16];
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbreadondata <= 1'b0;
        else if (sync_rst) 
            sbreadondata <= 1'b0;
        else if (apbw_sbcs)
            sbreadondata <= dm_pwdata[15];
    end
    
    assign sbcs[31:0] = {sbversion[2:0], 6'h0, sbbusyerror, sbbusy, sbreadonaddr, sbaccess[2:0], 
                   sbautoincrement, sbreadondata, sberror[2:0], sbasize[6:0], sbaccess_info[4:0]};

    assign sba_write = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0 && 
                       sbaddr0[1:0] == 2'b0 && !(sbreadonaddr || sbreadondata);
    assign sba_read  = (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR0 && dm_pwdata[1:0] == 2'b0 && sbreadonaddr) || 
                       (dm_intra_apbr && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0 && sbaddr0[1:0] == 2'b0 && sbreadondata);

    assign sba_write_ignore_unalign = dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0 && !(sbreadonaddr || sbreadondata);
    assign sba_read_ignore_unalign  = (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBADDR0 && sbreadonaddr) || 
                                      (dm_intra_apbr && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0 && sbreadondata);

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
          sba_write_ignore_unalign_f <= 1'b0;
        else if (sba_write_ignore_unalign_f) 
          sba_write_ignore_unalign_f <= 1'b0;
        else if (sba_write_ignore_unalign)
          sba_write_ignore_unalign_f <= 1'b1;
    end
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
          sba_read_ignore_unalign_f <= 1'b0;
        else if (sba_read_ignore_unalign_f) 
          sba_read_ignore_unalign_f <= 1'b0;
        else if (sba_read_ignore_unalign)
          sba_read_ignore_unalign_f <= 1'b1;
    end

    wire [31:0]  sbdata_zero_value;
    assign sbdata_zero_value[31:0] = 32'h0;

    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sba_wr_flg <= 1'b0;
        else if (sync_rst) 
            sba_wr_flg <= 1'b0;
        else if (sba_write)
            sba_wr_flg <= 1'b1;
        else if (sba_read)
            sba_wr_flg <= 1'b0;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sba_wr_vld <= 1'b0;
        else if (sync_rst) 
            sba_wr_vld <= 1'b0;
        else if (sba_wr_vld)
            sba_wr_vld <= 1'b0;
        else if ((sba_write || sba_read) && sb_noerr && !sberror_will_be_3 && !sberror_will_be_4)
            sba_wr_vld <= 1'b1;
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b) 
            sbdata0[31:0] <= 32'h0;
        else if (sync_rst) 
            sbdata0[31:0] <= 32'h0;
        else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA0 && sb_noerr)
            sbdata0[31:0] <= dm_pwdata[31:0];
        else if (sba_wr_ready && !sba_wr_flg)
            sbdata0[31:0] <= sba_rd_data[31:0];
`ifdef TDT_DM_BUF_MOVE        
        else if (internal_move_start && dst_type[1:0] == 2'b01 && dst_reg[3:0] == 4'h0) 
            sbdata0[31:0] <= src_data_mux[31:0];
`endif
    end
   
`ifdef TDT_DM_SBA_DW_128 
        always @ (posedge dm_pclk or negedge preset_b) begin
            if (!preset_b) 
                sbdata1[31:0] <= 32'h0;
            else if (sync_rst) 
                sbdata1[31:0] <= 32'h0;
            else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA1 && sb_noerr)
                sbdata1[31:0] <= dm_pwdata[31:0];
            else if (sba_wr_ready && !sba_wr_flg && sbaccess[2:0] > 3'h2)
                sbdata1[31:0] <= sba_rd_data[63:32];
    `ifdef TDT_DM_BUF_MOVE        
            else if (internal_move_start && dst_type[1:0] == 2'b01 && dst_reg[3:0] == 4'h1) 
                sbdata1[31:0] <= src_data_mux[31:0];
    `endif
        end
        
        always @ (posedge dm_pclk or negedge preset_b) begin
            if (!preset_b) 
                sbdata2[31:0] <= 32'h0;
            else if (sync_rst) 
                sbdata2[31:0] <= 32'h0;
            else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA2 && sb_noerr)
                sbdata2[31:0] <= dm_pwdata[31:0];
            else if (sba_wr_ready && !sba_wr_flg && sbaccess[2:0] > 3'h3)
                sbdata2[31:0] <= sba_rd_data[95:64];
    `ifdef TDT_DM_BUF_MOVE        
            else if (internal_move_start && dst_type[1:0] == 2'b01 && dst_reg[3:0] == 4'h2) 
                sbdata2[31:0] <= src_data_mux[31:0];
    `endif
        end
        
        always @ (posedge dm_pclk or negedge preset_b) begin
            if (!preset_b) 
                sbdata3[31:0] <= 32'h0;
            else if (sync_rst) 
                sbdata3[31:0] <= 32'h0;
            else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA3 && sb_noerr)
                sbdata3[31:0] <= dm_pwdata[31:0];
            else if (sba_wr_ready && !sba_wr_flg && sbaccess[2:0] > 3'h3)
                sbdata3[31:0] <= sba_rd_data[127:96];
    `ifdef TDT_DM_BUF_MOVE        
            else if (internal_move_start && dst_type[1:0] == 2'b01 && dst_reg[3:0] == 4'h3) 
                sbdata3[31:0] <= src_data_mux[31:0];
    `endif 
        end
`else 
    `ifdef TDT_DM_SBA_DW_64
            always @ (posedge dm_pclk or negedge preset_b) begin
                if (!preset_b) 
                    sbdata1[31:0] <= 32'h0;
                else if (sync_rst) 
                    sbdata1[31:0] <= 32'h0;

                else if (dm_intra_apbw && dm_paddr[APB_AW-1:2] == OFFSET_SBDATA1 && sb_noerr)
                    sbdata1[31:0] <= dm_pwdata[31:0];
                else if (sba_wr_ready && !sba_wr_flg && sbaccess[2:0] > 3'h2)
                    sbdata1[31:0] <= sba_rd_data[63:32];
        `ifdef TDT_DM_BUF_MOVE        
                else if (internal_move_start && dst_type[1:0] == 2'b01 && dst_reg[3:0] == 4'h1) 
                    sbdata1[31:0] <= src_data_mux[31:0];
        `endif
            end
            
            always @ (*) begin
                    sbdata2[31:0] = sbdata_zero_value[31:0];
            end

            always @ (*) begin
                    sbdata3[31:0] = sbdata_zero_value[31:0];
            end
    `else
            always @ (*) begin
                    sbdata1[31:0] = sbdata_zero_value[31:0];
            end

            always @ (*) begin
                    sbdata2[31:0] = sbdata_zero_value[31:0];
            end

            always @ (*) begin
                    sbdata3[31:0] = sbdata_zero_value[31:0];
            end

    `endif
`endif

`ifdef TDT_DM_SBA_DW_128
    assign sba_w_data[`TDT_DM_SBA_DW-1:0] = {sbdata3[31:0], sbdata2[31:0], sbdata1[31:0], sbdata0[31:0]};    
`else 
    `ifdef TDT_DM_SBA_DW_64
    assign sba_w_data[`TDT_DM_SBA_DW-1:0] = {sbdata1[31:0], sbdata0[31:0]};        
    `else
    assign sba_w_data[`TDT_DM_SBA_DW-1:0] = sbdata0[31:0];               
    `endif
`endif

    assign sba_wr_addr_pre[63:0] = {sbaddr1[31:0], sbaddr0[31:0]};
    assign sba_wr_addr[SBAW-1:0] = sba_wr_addr_pre[SBAW-1:0];
    assign sba_wr_size[2:0] = sbaccess[2:0]; 

    wire sba_wr_vld_cpuclk_sync;
    wire sba_wr_ready_async;
    wire sba_wr_ready_pulse;
    wire sba_error_async;
    wire[`TDT_DM_SBA_DW-1:0] sba_rd_data_async;
    reg  sba_wr_vld_sync;
    reg  sba_wr_vld_cpuclk_post_sync;
    reg  sba_wr_ready_cpuclk_sync;

//pclk to cpuclk cdc, async cdc
tdt_dm_pulse_sync u_tdt_dm_pulse_sync_cpuclk_vld(
    .src_clk           (pclk),
    .dst_clk           (forever_cpuclk),
    .src_rst_b         (preset_b),
    .dst_rst_b         (ciu_rst_b),
    .src_pulse         (sba_wr_vld),
    .dst_pulse         (sba_wr_vld_cpuclk_sync)
);
//cpuclk to axiclk cdc, sync cdc
always @(posedge forever_cpuclk or negedge ciu_rst_b)
begin
  if(!ciu_rst_b)
    sba_wr_vld_cpuclk_post_sync <= 1'b0;
  else if(sys_bus_clk_en)
    sba_wr_vld_cpuclk_post_sync <= 1'b0;
  else if(sba_wr_vld_cpuclk_sync)
    sba_wr_vld_cpuclk_post_sync <= 1'b1;
end

always @(posedge forever_cpuclk or negedge ciu_rst_b)
begin
  if(!ciu_rst_b)
    sba_wr_vld_sync <= 1'b0;
  else if(sys_bus_clk_en)
    begin
      if(sba_wr_vld_cpuclk_sync || sba_wr_vld_cpuclk_post_sync)
        sba_wr_vld_sync <= 1'b1; 
      else if(sba_wr_vld_sync)
        sba_wr_vld_sync <= 1'b0;
    end
end
//axiclk to cpuclk cdc, sync cdc
always @ (posedge forever_cpuclk or negedge ciu_rst_b) begin
   if (!ciu_rst_b)
     sba_wr_ready_cpuclk_sync <= 1'b0;
   else if (sys_bus_clk_en)
     sba_wr_ready_cpuclk_sync <= sba_wr_ready_async;
   else if(sba_wr_ready_cpuclk_sync)
     sba_wr_ready_cpuclk_sync <= 1'b0;
end

//cpuclk to pclk cdc, async cdc
tdt_dm_pulse_sync u_tdt_dm_pulse_sync_ready(
    .src_clk           (forever_cpuclk),
    .dst_clk           (pclk),
    .src_rst_b         (ciu_rst_b),
    .dst_rst_b         (preset_b),
    .src_pulse         (sba_wr_ready_cpuclk_sync),
    .dst_pulse         (sba_wr_ready_pulse)
);

always @ (posedge pclk or negedge preset_b) begin
    if (!preset_b)
        sba_wr_ready <= 1'b0;
    else
        sba_wr_ready <= sba_wr_ready_pulse;
end

always @ (posedge pclk or negedge preset_b) begin
    if (!preset_b)
        sba_error <= 1'b0;
    else if(sba_wr_ready_pulse)
        sba_error <= sba_error_async;
end

always @ (posedge pclk or negedge preset_b) begin
    if (!preset_b)
       sba_rd_data[`TDT_DM_SBA_DW-1:0] <= {`TDT_DM_SBA_DW{1'b0}};
    else if(sba_wr_ready_pulse)
       sba_rd_data[`TDT_DM_SBA_DW-1:0] <= sba_rd_data_async[`TDT_DM_SBA_DW-1:0];
end

`ifdef TDT_DM_SBA_AXI
tdt_sba_axi #(  
    .AXI_ADDR_WIDTH                 (SBAW)
) x_tdt_sba_axi (

    .mclk                           (forever_cpuclk),
    .mreset_b                        (ciu_rst_b),
    .pad_icg_scan_en                (pad_icg_scan_en),
    .axim_clk_en                    (sys_bus_clk_en), 
    
    .wr_data                        (sba_w_data),
    .wr_flg                         (sba_wr_flg), 
    .wr_addr                        (sba_wr_addr),
    .wr_vld                         (sba_wr_vld_sync),
    .wr_size                        (sba_wr_size),
    .rd_data                        (sba_rd_data_async),
    .axi_wr_ready                   (sba_wr_ready_async),
    .sba_error                      (sba_error_async),
    
    .awid                           (dm_pad_awid),
    .awaddr                         (dm_pad_awaddr),
    .awlen                          (dm_pad_awlen),
    .awsize                         (dm_pad_awsize),
    .awvalid                        (dm_pad_awvalid),
    .awready                        (pad_dm_awready),
    
    .wdata                          (dm_pad_wdata),
    .wstrb                          (dm_pad_wstrb),
    .wlast                          (dm_pad_wlast),
    .wvalid                         (dm_pad_wvalid),
    .wready                         (pad_dm_wready),
    
    .bid                            (pad_dm_bid),
    .bresp                          (pad_dm_bresp),
    .bvalid                         (pad_dm_bvalid),
    .bready                         (dm_pad_bready),
    
    .arid                           (dm_pad_arid),
    .araddr                         (dm_pad_araddr),
    .arlen                          (dm_pad_arlen),
    .arsize                         (dm_pad_arsize),
    .arvalid                        (dm_pad_arvalid),
    .arready                        (pad_dm_arready),
    
    .rid                            (pad_dm_rid),
    .rdata                          (pad_dm_rdata),
    .rlast                          (pad_dm_rlast),
    .rresp                          (pad_dm_rresp),
    .rvalid                         (pad_dm_rvalid),
    .rready                         (dm_pad_rready)

); 
    assign dm_pad_awburst[1:0] = 2'b01;
    assign dm_pad_awcache[3:0] = 4'h0;
    assign dm_pad_awlock       = 1'b0;
    assign dm_pad_awprot[2:0]  = 3'b010;
    assign dm_pad_arburst[1:0] = 2'b01;
    assign dm_pad_arcache[3:0] = 4'h0;
    assign dm_pad_arlock       = 1'b0;
    assign dm_pad_arprot[2:0]  = 3'b010;
    //assign dm_pad_wid[3:0]     = dm_pad_awid[3:0];
`endif
`ifdef TDT_DM_SBA_AHB
tdt_sba_ahb #(
    .AHB_ADDR_WIDTH                 (SBAW)
) x_tdt_sba_ahb (

    .mclk                           (forever_cpuclk),
    .mreset_b                        (ciu_rst_b),
    .pad_icg_scan_en                (pad_icg_scan_en),
    .ahbm_clk_en                    (sys_bus_clk_en),
    
    .wr_data                        (sba_w_data),
    .wr_flg                         (sba_wr_flg), 
    .wr_addr                        (sba_wr_addr),
    .wr_vld                         (sba_wr_vld_sync),
    .wr_size                        (sba_wr_size),
    .rd_data                        (sba_rd_data_async),
    .ahb_wr_ready                   (sba_wr_ready_async),
    .sba_error                      (sba_error_async),

    .haddr                          (dm_pad_haddr),
    .hburst                         (dm_pad_hburst),
    .hsize                          (dm_pad_hsize),
    .htrans                         (dm_pad_htrans),
    .hwrite                         (dm_pad_hwrite),
    .hwdata                         (dm_pad_hwdata),
    .hrdata                         (pad_dm_hrdata),
    .hready                         (pad_dm_hready),
    .hresp                          (pad_dm_hresp)
);
    assign dm_pad_hprot[3:0]     = 4'h1;
    assign dm_pad_hmastlock = 1'b0; 
`endif

`endif

    //==========================================================
    //    apb read
    //==========================================================
    
    always @ (posedge pclk or negedge preset_b) begin
        if (!preset_b)  
            dm_pready <= 1'b0;
        else if (dm_pready)
            dm_pready <= 1'b0;
        else if (dm_psel && !dm_penable) 
            dm_pready <= 1'b1;
    end
    
    assign nextdm[31:0] = NEXTDM_BASEADDR;

`ifdef PROCESSOR_3
  always @ (*) begin
    case(hartsello[CORE_NUM_W-1:0])
        2'b00: hartinfo[31:0] = {8'h0, nscratch_all[3:0], 20'h0};
        2'b01: hartinfo[31:0] = {8'h0, nscratch_all[7:4], 20'h0};
        2'b10: hartinfo[31:0] = {8'h0, nscratch_all[11:8], 20'h0};
        2'b11: hartinfo[31:0] = {8'h0, nscratch_all[15:12], 20'h0};
        default:hartinfo[31:0] = {32{1'bx}};
    endcase
  end
`else
  `ifdef PROCESSOR_2
    always @ (*) begin
      case(hartsello[CORE_NUM_W-1:0])
          2'b00: hartinfo[31:0] = {8'h0, nscratch_all[3:0], 20'h0};
          2'b01: hartinfo[31:0] = {8'h0, nscratch_all[7:4], 20'h0};
          2'b10: hartinfo[31:0] = {8'h0, nscratch_all[11:8], 20'h0};
          2'b11: hartinfo[31:0] = 32'b0;
          default:hartinfo[31:0] = {32{1'bx}};
      endcase
    end
  `else
    `ifdef PROCESSOR_1
     always @ (*) begin
       case(hartsello[CORE_NUM_W-1:0])
          1'b0: hartinfo[31:0] = {8'h0, nscratch_all[3:0], 20'h0};
          1'b1: hartinfo[31:0] = {8'h0, nscratch_all[7:4], 20'h0};
          default:hartinfo[31:0] = {32{1'bx}};
      endcase
    end
    `else
     always @ (*) begin
       hartinfo[31:0] = {8'h0, nscratch_all[3:0], 20'h0};
     end
    `endif
  `endif
`endif
  
    always @ (dm_paddr[APB_AW-1:2] or
              data0 or
              data1 or
              dmcontrol or
              dmstatus or
              hartinfo or
              hawindow or
              abstractcs or
              abstractauto or
              nextdm or
              hartsum0 or
              itr or
              customcs or
              compid
 `ifdef TDT_DM_PB_EN             
             or progbuf[0]
             or progbuf[1]
             or progbuf[2]
             or progbuf[3]
             or progbuf[4]
             or progbuf[5]
             or progbuf[6]
             or progbuf[7]
             or progbuf[8]
             or progbuf[9]
             or progbuf[10]
             or progbuf[11]
             or progbuf[12]
             or progbuf[13]
             or progbuf[14]
             or progbuf[15]
 `endif
 `ifdef TDT_DM_GROUP_TRI_EN
             or dmcs2          
 `endif
 `ifdef TDT_DM_SBA
             or sbcs
             or sbaddr0
             or sbaddr1
             or sbdata0
             or sbdata1
             or sbdata2
             or sbdata3
 `endif
 `ifdef TDT_DM_BUF_MOVE
            or cusbuf_all[7:0]
 `endif
             ) 
    begin
        case (dm_paddr[APB_AW-1:2]) 
            OFFSET_DATA0          : prdata_pre[31:0] = data0[31:0];
            OFFSET_DATA1          : prdata_pre[31:0] = data1[31:0];
            OFFSET_DMCONTROL      : prdata_pre[31:0] = dmcontrol[31:0];
            OFFSET_DMSTATUS       : prdata_pre[31:0] = dmstatus[31:0];
            OFFSET_HARTINFO       : prdata_pre[31:0] = hartinfo[31:0];
            OFFSET_HAWINDOW       : prdata_pre[31:0] = hawindow[31:0];
            OFFSET_ABSTRACTCS     : prdata_pre[31:0] = abstractcs[31:0];
            OFFSET_COMMAND        : prdata_pre[31:0] = 32'h0;
            OFFSET_ABSTRACTAUTO   : prdata_pre[31:0] = abstractauto[31:0];
            OFFSET_NEXTDM         : prdata_pre[31:0] = nextdm[31:0];
`ifdef TDT_DM_PB_EN
            OFFSET_PB0            : prdata_pre[31:0] = progbuf[0];
            OFFSET_PB1            : prdata_pre[31:0] = progbuf[1];
            OFFSET_PB2            : prdata_pre[31:0] = progbuf[2];
            OFFSET_PB3            : prdata_pre[31:0] = progbuf[3]; 
            OFFSET_PB4            : prdata_pre[31:0] = progbuf[4]; 
            OFFSET_PB5            : prdata_pre[31:0] = progbuf[5]; 
            OFFSET_PB6            : prdata_pre[31:0] = progbuf[6]; 
            OFFSET_PB7            : prdata_pre[31:0] = progbuf[7]; 
            OFFSET_PB8            : prdata_pre[31:0] = progbuf[8]; 
            OFFSET_PB9            : prdata_pre[31:0] = progbuf[9];
            OFFSET_PB10           : prdata_pre[31:0] = progbuf[10]; 
            OFFSET_PB11           : prdata_pre[31:0] = progbuf[11]; 
            OFFSET_PB12           : prdata_pre[31:0] = progbuf[12]; 
            OFFSET_PB13           : prdata_pre[31:0] = progbuf[13]; 
            OFFSET_PB14           : prdata_pre[31:0] = progbuf[14]; 
            OFFSET_PB15           : prdata_pre[31:0] = progbuf[15];
`endif
`ifdef TDT_DM_GROUP_TRI_EN 
            OFFSET_DMCS2          : prdata_pre[31:0] = dmcs2[31:0];
`endif
`ifdef TDT_DM_SBA
            OFFSET_SBCS           : prdata_pre[31:0] = sbcs[31:0];
            OFFSET_SBADDR0        : prdata_pre[31:0] = sbaddr0[31:0];
            OFFSET_SBADDR1        : prdata_pre[31:0] = sbaddr1[31:0];
            OFFSET_SBDATA0        : prdata_pre[31:0] = sbdata0[31:0];
            OFFSET_SBDATA1        : prdata_pre[31:0] = sbdata1[31:0];
            OFFSET_SBDATA2        : prdata_pre[31:0] = sbdata2[31:0];
            OFFSET_SBDATA3        : prdata_pre[31:0] = sbdata3[31:0];
`endif
            OFFSET_HARTSUM0       : prdata_pre[31:0] = hartsum0[31:0];
            OFFSET_ITR            : prdata_pre[31:0] = itr[31:0];
            OFFSET_CUSCS          : prdata_pre[31:0] = customcs[31:0];
            OFFSET_CUSCMD         : prdata_pre[31:0] = 32'h0;
`ifdef TDT_DM_BUF_MOVE
            OFFSET_CUSBUF0        : prdata_pre[31:0] = cusbuf_all[0]; 
            OFFSET_CUSBUF1        : prdata_pre[31:0] = cusbuf_all[1]; 
            OFFSET_CUSBUF2        : prdata_pre[31:0] = cusbuf_all[2]; 
            OFFSET_CUSBUF3        : prdata_pre[31:0] = cusbuf_all[3]; 
            OFFSET_CUSBUF4        : prdata_pre[31:0] = cusbuf_all[4]; 
            OFFSET_CUSBUF5        : prdata_pre[31:0] = cusbuf_all[5]; 
            OFFSET_CUSBUF6        : prdata_pre[31:0] = cusbuf_all[6]; 
            OFFSET_CUSBUF7        : prdata_pre[31:0] = cusbuf_all[7];
`endif
            OFFSET_COMPID         : prdata_pre[31:0] = compid[31:0];
            default               : prdata_pre[31:0] = 32'h0;
        endcase
    end
    
    always @ (posedge dm_pclk or negedge preset_b) begin
        if (!preset_b)  
            dm_prdata[31:0] <= 32'b0;
        else if (sync_rst) 
            dm_prdata[31:0] <= 32'b0;
        else if (dm_psel && !dm_penable) 
            dm_prdata[31:0] <= prdata_pre[31:0];
    end

    assign dm_pslverr = 1'b0;

`ifdef ASSERTION
  `ifdef TDT_DM_SINGLE_CORE
    property when_allunavail_is_high_allrunning_must_be_low;
      @(posedge dm_pclk) allunavail |-> !allrunning;
    endproperty
    assert property(when_allunavail_is_high_allrunning_must_be_low); 

    property when_allunavail_is_high_allhalted_must_be_low;
      @(posedge dm_pclk) allunavail |-> !allhalted;
    endproperty
    assert property(when_allunavail_is_high_allhalted_must_be_low);

    property when_anyunavail_is_high_anyrunning_must_be_low;
      @(posedge dm_pclk) anyunavail |-> !anyrunning;
    endproperty
    assert property(when_anyunavail_is_high_anyrunning_must_be_low); 

    property when_anyunavail_is_high_anyhalted_must_be_low;
      @(posedge dm_pclk) anyunavail |-> !anyhalted;
    endproperty
    assert property(when_anyunavail_is_high_anyhalted_must_be_low);
 `else
    property when_allunavail_is_high_allrunning_must_be_low;
      @(posedge dm_pclk) allunavail |-> !allrunning;
    endproperty
    assert property(when_allunavail_is_high_allrunning_must_be_low); 

     property when_allunavail_is_high_allhalted_must_be_low;
      @(posedge dm_pclk) allunavail |-> !allhalted;
    endproperty
    assert property(when_allunavail_is_high_allhalted_must_be_low);
 `endif
`endif
endmodule
