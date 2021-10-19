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
module mp_top_golden_port(
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

// &Ports; @3
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


// &Force("input","pll_core_cpuclk");                 @5
// &Force("input","axim_clk_en");                     @6
// &Force("input","pad_cpu_rst_b");                   @7
// //&Force("input","pad_cpu0_hartid");                   &Force("bus","pad_cpu0_hartid",2,0); @8
//AXI master IF
// &Force("input","pad_biu_arready");                 @10
// &Force("input","pad_biu_awready");                 @11
// &Force("input","pad_biu_wready"); @12
// &Force("input","pad_biu_bid");                      &Force("bus","pad_biu_bid",7,0); @13
// &Force("input","pad_biu_bresp");                    &Force("bus","pad_biu_bresp", 1,0); @14
// &Force("input","pad_biu_bvalid");                  @15
// &Force("input","pad_biu_rdata");                    &Force("bus","pad_biu_rdata",127,0);               @16
// &Force("input","pad_biu_rvalid");                  @17
// &Force("input","pad_biu_rid");                      &Force("bus","pad_biu_rid",7,0);                  @18
// &Force("input","pad_biu_rlast");                                      @19
// &Force("input","pad_biu_rresp");                    &Force("bus","pad_biu_rresp",1,0); @20
// //&Force("input","pad_biu_csysreq");                 @21

// &Force("output", "biu_pad_araddr");                 &Force("bus","biu_pad_araddr",39,0);             @23
// &Force("output", "biu_pad_arburst");                &Force("bus","biu_pad_arburst",1,0);             @24
// &Force("output", "biu_pad_arcache");                &Force("bus","biu_pad_arcache",3,0); @25
// &Force("output", "biu_pad_arid");                   &Force("bus","biu_pad_arid",7,0); @26
// &Force("output", "biu_pad_arlen");                  &Force("bus","biu_pad_arlen",7,0); @27
// &Force("output", "biu_pad_arlock");                  @28
// &Force("output", "biu_pad_arprot");                 &Force("bus","biu_pad_arprot",2,0); @29
// &Force("output", "biu_pad_arsize");                 &Force("bus","biu_pad_arsize",2,0); @30
// &Force("output", "biu_pad_arvalid");                 @31
// &Force("output", "biu_pad_awaddr");                 &Force("bus","biu_pad_awaddr",39,0); @32
// &Force("output", "biu_pad_awburst");                &Force("bus","biu_pad_awburst",1,0); @33
// &Force("output", "biu_pad_awcache");                &Force("bus","biu_pad_awcache",3,0); @34
// &Force("output", "biu_pad_awid");                   &Force("bus","biu_pad_awid",7,0); @35
// &Force("output", "biu_pad_awlen");                  &Force("bus","biu_pad_awlen",7,0); @36
// &Force("output", "biu_pad_awlock");                  @37
// &Force("output", "biu_pad_awprot");                 &Force("bus","biu_pad_awprot",2,0); @38
// &Force("output", "biu_pad_awsize");                 &Force("bus","biu_pad_awsize",2,0); @39
// &Force("output", "biu_pad_awvalid");                 @40
// &Force("output", "biu_pad_bready");                  @41
// &Force("output", "biu_pad_rready");                  @42
// &Force("output", "biu_pad_wdata");                  &Force("bus","biu_pad_wdata",127,0); @43
// &Force("output", "biu_pad_wlast");                   @44
// &Force("output", "biu_pad_wstrb");                  &Force("bus","biu_pad_wstrb",15,0); @45
// &Force("output", "biu_pad_wvalid");                  @46

// &Force("input","tdt_dmi_paddr");                    &Force("bus","tdt_dmi_paddr",11,0); @48
// &Force("input","tdt_dmi_pwrite"); @49
// &Force("input","tdt_dmi_psel"); @51
// &Force("input","tdt_dmi_psel");                     &Force("bus","tdt_dmi_psel",`TDT_COMP_NUM-1,0); @53
// &Force("input","tdt_dmi_penable"); @55
// &Force("input","tdt_dmi_pwdata");                   &Force("bus","tdt_dmi_pwdata",31,0); @56
// &Force("output","tdt_dmi_prdata");                  &Force("bus","tdt_dmi_prdata",`TDT_COMP_NUM*32-1,0); @57
// &Force("output","tdt_dmi_pready"); @59
// &Force("output","tdt_dmi_pslverr"); @60
// &Force("output","tdt_dmi_pready");                  &Force("bus","tdt_dmi_pready",`TDT_COMP_NUM-1,0); @62
// &Force("output","tdt_dmi_pslverr");                 &Force("bus","tdt_dmi_pslverr",`TDT_COMP_NUM-1,0); @63

// &Force("output","tdt_dm_pad_ndmreset_n"); @66
// &Force("output","tdt_dm_pad_hartreset_n"); @68
// &Force("input","pad_tdt_dm_core_unavail"); @69
// &Force("output","tdt_dm_pad_hartreset_n");           &Force("bus","tdt_dm_pad_hartreset_n",`TDT_DM_CORE_NUM-1,0); @71
// &Force("input","pad_tdt_dm_core_unavail");          &Force("bus","pad_tdt_dm_core_unavail",`TDT_DM_CORE_NUM-1,0); @72

// &Force("input","sys_apb_rst_b"); @75

// &Force("input","sys_apb_clk"); @77
// &Force("input","sys_apb_clk_en"); @80

// &Force("input","pad_tdt_dm_halt_req");              &Force("bus","pad_tdt_dm_halt_req",`TDT_DM_EXTHALTTRI_NUM-1,0); @84
// &Force("input","pad_tdt_dm_resume_req");            &Force("bus","pad_tdt_dm_resume_req",`TDT_DM_EXTRESUMETRI_NUM-1,0); @85
// &Force("output","tdt_dm_pad_halt_req");             &Force("bus","tdt_dm_pad_halt_req",`TDT_DM_EXTHALTTRI_NUM-1,0); @86
// &Force("output","tdt_dm_pad_resume_req");           &Force("bus","tdt_dm_pad_resume_req",`TDT_DM_EXTRESUMETRI_NUM-1,0); @87

// &Force("output","tdt_dm_pad_awid");                 &Force("bus","tdt_dm_pad_awid",3,0); @91
// &Force("output","tdt_dm_pad_awaddr");               &Force("bus","tdt_dm_pad_awaddr",`TDT_DM_SBAW-1,0); @92
// &Force("output","tdt_dm_pad_awlen");                &Force("bus","tdt_dm_pad_awlen",3,0); @93
// &Force("output","tdt_dm_pad_awsize");               &Force("bus","tdt_dm_pad_awsize",2,0); @94
// &Force("output","tdt_dm_pad_awvalid"); @95
// &Force("input","pad_tdt_dm_awready"); @96
// &Force("output","tdt_dm_pad_wdata");                &Force("bus","tdt_dm_pad_wdata",`TDT_DM_SBA_DW-1,0); @97
// &Force("output","tdt_dm_pad_wvalid"); @98
// &Force("output","tdt_dm_pad_wlast"); @99
// &Force("output","tdt_dm_pad_wstrb");                &Force("bus","tdt_dm_pad_wstrb",`TDT_DM_SBA_BW-1,0); @100
// &Force("input","pad_tdt_dm_wready"); @101
// &Force("output","tdt_dm_pad_bready"); @102
// &Force("input","pad_tdt_dm_bid");                   &Force("bus","pad_tdt_dm_bid",3,0); @103
// &Force("input","pad_tdt_dm_bresp");                 &Force("bus","pad_tdt_dm_bresp",1,0); @104
// &Force("input","pad_tdt_dm_bvalid"); @105

// &Force("output","tdt_dm_pad_arid");                 &Force("bus","tdt_dm_pad_arid",3,0); @107
// &Force("output","tdt_dm_pad_araddr");               &Force("bus","tdt_dm_pad_araddr",`TDT_DM_SBAW-1,0); @108
// &Force("output","tdt_dm_pad_arlen");                &Force("bus","tdt_dm_pad_arlen",3,0); @109
// &Force("output","tdt_dm_pad_arsize");               &Force("bus","tdt_dm_pad_arsize",2,0); @110
// &Force("output","tdt_dm_pad_arvalid"); @111
// &Force("input","pad_tdt_dm_arready"); @112

// &Force("input","pad_tdt_dm_rid");                   &Force("bus","pad_tdt_dm_rid",3,0); @114
// &Force("input","pad_tdt_dm_rdata");                 &Force("bus","pad_tdt_dm_rdata",`TDT_DM_SBA_DW-1,0); @115
// &Force("input","pad_tdt_dm_rvalid"); @116
// &Force("input","pad_tdt_dm_rlast"); @117
// &Force("input","pad_tdt_dm_rresp");                 &Force("bus","pad_tdt_dm_rresp",1,0); @118

// &Force("output","tdt_dm_pad_rready"); @120

// &Force("output","tdt_dm_pad_awburst");              &Force("bus","tdt_dm_pad_awburst",1,0); @122
// &Force("output","tdt_dm_pad_awcache");              &Force("bus","tdt_dm_pad_awcache",3,0); @123
// &Force("output","tdt_dm_pad_awlock");                @124
// &Force("output","tdt_dm_pad_awprot");               &Force("bus","tdt_dm_pad_awprot",2,0); @125
// &Force("output","tdt_dm_pad_arburst");              &Force("bus","tdt_dm_pad_arburst",1,0); @126
// &Force("output","tdt_dm_pad_arcache");              &Force("bus","tdt_dm_pad_arcache",3,0); @127
// &Force("output","tdt_dm_pad_arlock");                @128
// &Force("output","tdt_dm_pad_arprot");               &Force("bus","tdt_dm_pad_arprot",2,0); @129
// &Force("output","tdt_dm_pad_htrans");               &Force("bus","tdt_dm_pad_htrans",1,0); @132
// &Force("output","tdt_dm_pad_haddr");                &Force("bus","tdt_dm_pad_haddr",`TDT_DM_SBAW-1,0); @133
// &Force("output","tdt_dm_pad_hwrite"); @134
// &Force("output","tdt_dm_pad_hburst");               &Force("bus","tdt_dm_pad_hburst",2,0); @135
// &Force("output","tdt_dm_pad_hsize");                &Force("bus","tdt_dm_pad_hsize",2,0); @136
// &Force("output","tdt_dm_pad_hwdata");               &Force("bus","tdt_dm_pad_hwdata",`TDT_DM_SBA_DW-1,0); @137
// &Force("output","tdt_dm_pad_hprot");                &Force("bus","tdt_dm_pad_hprot",3,0); @138
// &Force("output","tdt_dm_pad_hmastlock"); @139
// &Force("input","pad_tdt_dm_hrdata");                &Force("bus","pad_tdt_dm_hrdata",`TDT_DM_SBA_DW-1,0); @140
// &Force("input","pad_tdt_dm_hready"); @141
// &Force("input","pad_tdt_dm_hresp"); @142


// //&Force("output", "biu_pad_cactive");                 @146
// //&Force("output", "biu_pad_csysack");                 @147

// &Force("input", "pad_cpu_rvba");                    &Force("bus","pad_cpu_rvba",39,0);             @149
//mbist
// &Force("input", "pad_yy_mbist_mode");              @151
// &Force("input", "pad_yy_dft_clk_rst_b"); @152

//scan
// &Force("input", "pad_yy_icg_scan_en");            @155
// &Force("input", "pad_yy_scan_mode");                @156
// &Force("input", "pad_yy_scan_enable");                @157
// &Force("input", "pad_yy_scan_rst_b");                @158
// //&Force("output", "cpu_pad_no_op");                   @159

// &Force("output", "cpu_debug_port");                   @162

// //&Force("input", "pad_core0_rst_b");                 @166
// &Force("output", "core0_pad_lpmd_b");             &Force("bus","core0_pad_lpmd_b",1,0); @167
// &Force("output", "core0_pad_halted"); @168

// &Force("input","pad_cpu_apb_base");               &Force("bus","pad_cpu_apb_base",39,0); @171
// &Force("input","pad_cpu_sys_cnt");                &Force("bus","pad_cpu_sys_cnt",63,0);             @172

// &Force("input","pad_plic_int_vld");               &Force("bus","pad_plic_int_vld",`PLIC_INT_NUM-1,0); @175
// &Force("input","pad_plic_int_cfg");               &Force("bus","pad_plic_int_cfg",`PLIC_INT_NUM-1,0); @176
// &Force("input","pad_cpu_mint_req");               &Force("bus","pad_cpu_mint_req",`HART_NUM-1,0); @178
// &Force("input","pad_cpu_sint_req");               &Force("bus","pad_cpu_sint_req",`HART_NUM-1,0); @179

// &Force("output", "core0_pad_retire"); @182
// &Force("output", "core0_pad_retire_pc");          &Force("bus", "core0_pad_retire_pc",39,0); @183

// &Force("output", "core0_pad_retire_split");        @186
// &Force("output", "core0_pad_wb0_data");           &Force("bus", "core0_pad_wb0_data",63,0); @187
// &Force("output", "core0_pad_wb0_reg");            &Force("bus", "core0_pad_wb0_reg",5,0); @188
// &Force("output", "core0_pad_wb0_vld"); @189
// &Force("output", "core0_pad_wb1_data");           &Force("bus", "core0_pad_wb1_data",63,0); @190
// &Force("output", "core0_pad_wb1_reg");            &Force("bus", "core0_pad_wb1_reg",5,0); @191
// &Force("output", "core0_pad_wb1_vld"); @192
// &Force("output", "core0_pad_sc_pass"); @193
// &Force("output", "core0_pad_vpr_bank0_wb_data");  &Force("bus","core0_pad_vpr_bank0_wb_data",`BANK_WIDTH-1,0); @196
// &Force("output", "core0_pad_vpr_bank0_wb_reg");   &Force("bus","core0_pad_vpr_bank0_wb_reg",4,0); @197
// &Force("output", "core0_pad_vpr_bank0_wb_vld");    @198
// &Force("output", "core0_pad_vpr_bank1_wb_data");  &Force("bus","core0_pad_vpr_bank1_wb_data",`BANK_WIDTH-1,0); @199
// &Force("output", "core0_pad_vpr_bank1_wb_reg");   &Force("bus","core0_pad_vpr_bank1_wb_reg",4,0); @200
// &Force("output", "core0_pad_vpr_bank1_wb_vld"); @201
// &Force("output", "core0_pad_vpr_bank0_fflags");   &Force("bus","core0_pad_vpr_bank0_fflags",5,0); @203
// &Force("output", "core0_pad_vpr_bank0_fflags_vld");    @204
// &Force("output", "core0_pad_vpr_bank1_fflags");   &Force("bus","core0_pad_vpr_bank1_fflags",5,0); @206
// &Force("output", "core0_pad_vpr_bank1_fflags_vld"); @207
// &Force("output", "core0_pad_fpr_wb_data");        &Force("bus","core0_pad_fpr_wb_data",63,0); @209
// &Force("output", "core0_pad_fpr_wb_reg");         &Force("bus","core0_pad_fpr_wb_reg",4,0); @210
// &Force("output", "core0_pad_fpr_wb_vld");          @211
// &Force("output", "core0_pad_fpr_fflags");   &Force("bus","core0_pad_fpr_fflags",5,0); @213
// &Force("output", "core0_pad_fpr_fflags_vld");    @214
// &Force("output", "core0_pad_gpr_fflags");   &Force("bus","core0_pad_gpr_fflags",5,0); @216
// &Force("output", "core0_pad_gpr_fflags_vld"); @217
// &ModuleEnd; @221
endmodule



