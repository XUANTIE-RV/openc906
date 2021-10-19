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

// &ModuleBeg; @16
module tdt_top(
  ciu_rst_b,
  dtu_tdt_dm_halted,
  dtu_tdt_dm_havereset,
  dtu_tdt_dm_itr_done,
  dtu_tdt_dm_retire_debug_expt_vld,
  dtu_tdt_dm_rx_data,
  dtu_tdt_dm_wr_ready,
  forever_cpuclk,
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
  pad_yy_icg_scan_en,
  pad_yy_scan_mode,
  pad_yy_scan_rst_b,
  sys_apb_clk,
  sys_apb_rst_b,
  sys_bus_clk_en,
  tdt_dm_dtu_ack_havereset,
  tdt_dm_dtu_async_halt_req,
  tdt_dm_dtu_halt_on_reset,
  tdt_dm_dtu_halt_req,
  tdt_dm_dtu_halt_req_cause,
  tdt_dm_dtu_itr,
  tdt_dm_dtu_itr_vld,
  tdt_dm_dtu_resume_req,
  tdt_dm_dtu_wdata,
  tdt_dm_dtu_wr_flg,
  tdt_dm_dtu_wr_vld,
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

// &Ports; @17
input            ciu_rst_b; 
input            dtu_tdt_dm_halted; 
input            dtu_tdt_dm_havereset; 
input            dtu_tdt_dm_itr_done; 
input            dtu_tdt_dm_retire_debug_expt_vld; 
input   [63 :0]  dtu_tdt_dm_rx_data; 
input            dtu_tdt_dm_wr_ready; 
input            forever_cpuclk; 
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
input            pad_yy_icg_scan_en; 
input            pad_yy_scan_mode; 
input            pad_yy_scan_rst_b; 
input            sys_apb_clk; 
input            sys_apb_rst_b; 
input            sys_bus_clk_en; 
input   [11 :0]  tdt_dmi_paddr; 
input            tdt_dmi_penable; 
input            tdt_dmi_psel; 
input   [31 :0]  tdt_dmi_pwdata; 
input            tdt_dmi_pwrite; 
output           tdt_dm_dtu_ack_havereset; 
output           tdt_dm_dtu_async_halt_req; 
output           tdt_dm_dtu_halt_on_reset; 
output           tdt_dm_dtu_halt_req; 
output  [1  :0]  tdt_dm_dtu_halt_req_cause; 
output  [31 :0]  tdt_dm_dtu_itr; 
output           tdt_dm_dtu_itr_vld; 
output           tdt_dm_dtu_resume_req; 
output  [63 :0]  tdt_dm_dtu_wdata; 
output  [1  :0]  tdt_dm_dtu_wr_flg; 
output           tdt_dm_dtu_wr_vld; 
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

// &Regs; @18

// &Wires; @19


tdt_dm_top x_tdt_dm_top(
    .sys_apb_clk(sys_apb_clk),
    .sys_apb_rst_b(sys_apb_rst_b),
    .forever_cpuclk(forever_cpuclk),
    .ciu_rst_b(ciu_rst_b),
    .sys_bus_clk_en(sys_bus_clk_en),
    .pad_yy_icg_scan_en(pad_yy_icg_scan_en),
    .pad_yy_scan_mode(pad_yy_scan_mode),
    .pad_yy_scan_rst_b(pad_yy_scan_rst_b),

    .tdt_dmi_paddr(tdt_dmi_paddr),
    .tdt_dmi_pwrite(tdt_dmi_pwrite),
    .tdt_dmi_psel(tdt_dmi_psel),
    .tdt_dmi_penable(tdt_dmi_penable),
    .tdt_dmi_pwdata(tdt_dmi_pwdata),
    .tdt_dmi_prdata(tdt_dmi_prdata),
    .tdt_dmi_pready(tdt_dmi_pready),
    .tdt_dmi_pslverr(tdt_dmi_pslverr),

    .tdt_dm_pad_ndmreset_n(tdt_dm_pad_ndmreset_n),
    .tdt_dm_pad_hartreset_n(tdt_dm_pad_hartreset_n),

    .tdt_dm_dtu_halt_req(tdt_dm_dtu_halt_req),
    .tdt_dm_dtu_async_halt_req(tdt_dm_dtu_async_halt_req),
    .tdt_dm_dtu_resume_req(tdt_dm_dtu_resume_req),
    .tdt_dm_dtu_halt_on_reset(tdt_dm_dtu_halt_on_reset),
    .tdt_dm_dtu_halt_req_cause(tdt_dm_dtu_halt_req_cause),
    .dtu_tdt_dm_halted(dtu_tdt_dm_halted),
    .dtu_tdt_dm_havereset(dtu_tdt_dm_havereset),
    .tdt_dm_dtu_ack_havereset(tdt_dm_dtu_ack_havereset),
    .pad_tdt_dm_core_unavail(pad_tdt_dm_core_unavail),
    .tdt_dm_dtu_itr(tdt_dm_dtu_itr),
    .tdt_dm_dtu_itr_vld(tdt_dm_dtu_itr_vld),
    .dtu_tdt_dm_itr_done(dtu_tdt_dm_itr_done),
    .dtu_tdt_dm_retire_debug_expt_vld(dtu_tdt_dm_retire_debug_expt_vld),
    .tdt_dm_dtu_wr_vld(tdt_dm_dtu_wr_vld),
    .tdt_dm_dtu_wr_flg(tdt_dm_dtu_wr_flg),
    .tdt_dm_dtu_wdata(tdt_dm_dtu_wdata),
    .dtu_tdt_dm_wr_ready(dtu_tdt_dm_wr_ready),
    .dtu_tdt_dm_rx_data(dtu_tdt_dm_rx_data)


    ,
    .tdt_dm_pad_awid(tdt_dm_pad_awid),
    .tdt_dm_pad_awaddr(tdt_dm_pad_awaddr),
    .tdt_dm_pad_awlen(tdt_dm_pad_awlen),
    .tdt_dm_pad_awsize(tdt_dm_pad_awsize),
    .tdt_dm_pad_awvalid(tdt_dm_pad_awvalid),
    .pad_tdt_dm_awready(pad_tdt_dm_awready),
    .tdt_dm_pad_wdata(tdt_dm_pad_wdata),
    .tdt_dm_pad_wvalid(tdt_dm_pad_wvalid),
    .tdt_dm_pad_wlast(tdt_dm_pad_wlast),
    .tdt_dm_pad_wstrb(tdt_dm_pad_wstrb),
    .pad_tdt_dm_wready(pad_tdt_dm_wready),
    .tdt_dm_pad_bready(tdt_dm_pad_bready),
    .pad_tdt_dm_bid(pad_tdt_dm_bid),
    .pad_tdt_dm_bresp(pad_tdt_dm_bresp),
    .pad_tdt_dm_bvalid(pad_tdt_dm_bvalid),
    .tdt_dm_pad_arid(tdt_dm_pad_arid),
    .tdt_dm_pad_araddr(tdt_dm_pad_araddr),
    .tdt_dm_pad_arlen(tdt_dm_pad_arlen),
    .tdt_dm_pad_arsize(tdt_dm_pad_arsize),
    .tdt_dm_pad_arvalid(tdt_dm_pad_arvalid),
    .pad_tdt_dm_arready(pad_tdt_dm_arready),
    .pad_tdt_dm_rid(pad_tdt_dm_rid),
    .pad_tdt_dm_rdata(pad_tdt_dm_rdata),
    .pad_tdt_dm_rvalid(pad_tdt_dm_rvalid),
    .pad_tdt_dm_rlast(pad_tdt_dm_rlast),
    .pad_tdt_dm_rresp(pad_tdt_dm_rresp),
    .tdt_dm_pad_rready(tdt_dm_pad_rready),
    .tdt_dm_pad_awburst(tdt_dm_pad_awburst),
    .tdt_dm_pad_awcache(tdt_dm_pad_awcache),
    .tdt_dm_pad_awlock(tdt_dm_pad_awlock),
    .tdt_dm_pad_awprot(tdt_dm_pad_awprot),
    .tdt_dm_pad_arburst(tdt_dm_pad_arburst),
    .tdt_dm_pad_arcache(tdt_dm_pad_arcache),
    .tdt_dm_pad_arlock(tdt_dm_pad_arlock),
    .tdt_dm_pad_arprot(tdt_dm_pad_arprot)


);


// &Force("input","sys_apb_clk"); @127
// &Force("input","sys_apb_rst_b"); @128
// &Force("input","forever_cpuclk"); @129
// &Force("input","ciu_rst_b"); @130
// &Force("input","sys_bus_clk_en"); @131
// &Force("input","pad_yy_icg_scan_en"); @132
// &Force("input","pad_yy_scan_mode"); @133
// &Force("input","pad_yy_scan_rst_b"); @134
// &Force("input","tdt_dmi_paddr"); @135
// &Force("bus","tdt_dmi_paddr",11,0); @136
// &Force("input","tdt_dmi_pwrite"); @137
// &Force("input","tdt_dmi_psel"); @139
// &Force("input","tdt_dmi_psel");&Force("bus","tdt_dmi_psel",`TDT_COMP_NUM-1,0); @141
// &Force("input","tdt_dmi_penable"); @143
// &Force("input","tdt_dmi_pwdata"); @144
// &Force("bus","tdt_dmi_pwdata",31,0); @145
// &Force("output","tdt_dmi_prdata"); @146
// &Force("bus","tdt_dmi_prdata",`TDT_COMP_NUM*32-1,0); @147
// &Force("output","tdt_dmi_pready"); @149
// &Force("output","tdt_dmi_pslverr"); @150
// &Force("output","tdt_dmi_pready");&Force("bus","tdt_dmi_pready",`TDT_COMP_NUM-1,0); @152
// &Force("output","tdt_dmi_pslverr");&Force("bus","tdt_dmi_pslverr",`TDT_COMP_NUM-1,0); @153

// &Force("output","tdt_dm_pad_ndmreset_n"); @156
// &Force("output","tdt_dm_pad_hartreset_n"); @158
// &Force("output","tdt_dm_dtu_halt_req"); @159
// &Force("output","tdt_dm_dtu_async_halt_req"); @160
// &Force("output","tdt_dm_dtu_resume_req"); @161
// &Force("output","tdt_dm_dtu_halt_on_reset") @162
// &Force("output","tdt_dm_dtu_halt_req_cause");&Force("bus","tdt_dm_dtu_halt_req_cause",`TDT_DM_CORE_NUM*2-1,0); @163
// &Force("input","dtu_tdt_dm_halted"); @164
// &Force("input","dtu_tdt_dm_havereset") @165
// &Force("output","tdt_dm_dtu_ack_havereset"); @166
// &Force("input","pad_tdt_dm_core_unavail"); @167
// &Force("output","tdt_dm_dtu_itr");&Force("bus","tdt_dm_dtu_itr",31,0); @168
// &Force("output","tdt_dm_dtu_itr_vld"); @169
// &Force("input","dtu_tdt_dm_itr_done"); @170
// &Force("input","dtu_tdt_dm_retire_debug_expt_vld"); @171
// &Force("output","tdt_dm_dtu_wr_vld"); @172
// &Force("output","tdt_dm_pad_hartreset_n");&Force("bus","tdt_dm_pad_hartreset_n",`TDT_DM_CORE_NUM-1,0); @174
// &Force("output","tdt_dm_dtu_halt_req");&Force("bus","tdt_dm_dtu_halt_req",`TDT_DM_CORE_NUM-1,0); @175
// &Force("output","tdt_dm_dtu_async_halt_req");&Force("bus","tdt_dm_dtu_async_halt_req",`TDT_DM_CORE_NUM-1,0); @176
// &Force("output","tdt_dm_dtu_resume_req");&Force("bus","tdt_dm_dtu_resume_req",`TDT_DM_CORE_NUM-1,0); @177
// &Force("output","tdt_dm_dtu_halt_on_reset");&Force("bus","tdt_dm_dtu_halt_on_reset",`TDT_DM_CORE_NUM-1,0); @178
// &Force("output","tdt_dm_dtu_halt_req_cause");&Force("bus","tdt_dm_dtu_halt_req_cause",`TDT_DM_CORE_NUM*2-1,0); @179
// &Force("input","dtu_tdt_dm_halted");&Force("bus","dtu_tdt_dm_halted",`TDT_DM_CORE_NUM-1,0); @180
// &Force("input","dtu_tdt_dm_havereset");&Force("bus","dtu_tdt_dm_havereset",`TDT_DM_CORE_NUM-1,0); @181
// &Force("output","tdt_dm_dtu_ack_havereset");&Force("bus","tdt_dm_dtu_ack_havereset",`TDT_DM_CORE_NUM-1,0); @182
// &Force("input","pad_tdt_dm_core_unavail");&Force("bus","pad_tdt_dm_core_unavail",`TDT_DM_CORE_NUM-1,0); @183
// &Force("output","tdt_dm_dtu_itr");&Force("bus","tdt_dm_dtu_itr",31,0); @184
// &Force("output","tdt_dm_dtu_itr_vld");&Force("bus","tdt_dm_dtu_itr_vld",`TDT_DM_CORE_NUM-1,0); @185
// &Force("input","dtu_tdt_dm_itr_done");&Force("bus","dtu_tdt_dm_itr_done",`TDT_DM_CORE_NUM-1,0); @186
// &Force("input","dtu_tdt_dm_retire_debug_expt_vld");&Force("bus","dtu_tdt_dm_retire_debug_expt_vld",`TDT_DM_CORE_NUM-1,0); @187
// &Force("output","tdt_dm_dtu_wr_vld");&Force("bus","tdt_dm_dtu_wr_vld",`TDT_DM_CORE_NUM-1,0); @188
// &Force("output","tdt_dm_dtu_wr_flg"); @190
// &Force("bus","tdt_dm_dtu_wr_flg",1,0); @191
// &Force("output","tdt_dm_dtu_wdata"); @192
// &Force("bus","tdt_dm_dtu_wdata",`TDT_DM_CORE_MAX_XLEN-1,0); @193
// &Force("input","dtu_tdt_dm_wr_ready"); @195
// &Force("input","dtu_tdt_dm_wr_ready");&Force("bus","dtu_tdt_dm_wr_ready",`TDT_DM_CORE_NUM-1,0); @197

// &Force("input","dtu_tdt_dm_rx_data"); @200
// &Force("bus","dtu_tdt_dm_rx_data",`TDT_DM_CORE_MAX_XLEN * `TDT_DM_CORE_NUM - 1,0); @201

// &Force("input","pad_tdt_dm_halt_req"); @204
// &Force("bus","pad_tdt_dm_halt_req",`TDT_DM_EXTHALTTRI_NUM-1,0); @205
// &Force("input","pad_tdt_dm_resume_req"); @206
// &Force("bus","pad_tdt_dm_resume_req",`TDT_DM_EXTRESUMETRI_NUM-1,0); @207
// &Force("output","tdt_dm_pad_halt_req"); @208
// &Force("bus","tdt_dm_pad_halt_req",`TDT_DM_EXTHALTTRI_NUM-1,0); @209
// &Force("output","tdt_dm_pad_resume_req"); @210
// &Force("bus","tdt_dm_pad_resume_req",`TDT_DM_EXTRESUMETRI_NUM-1,0); @211

// &Force("output","tdt_dm_pad_awid"); @215
// &Force("bus","tdt_dm_pad_awid",3,0); @216
// &Force("output","tdt_dm_pad_awaddr"); @217
// &Force("bus","tdt_dm_pad_awaddr",`TDT_DM_SBAW-1,0); @218
// &Force("output","tdt_dm_pad_awlen"); @219
// &Force("bus","tdt_dm_pad_awlen",3,0); @220
// &Force("output","tdt_dm_pad_awsize"); @221
// &Force("bus","tdt_dm_pad_awsize",2,0); @222
// &Force("output","tdt_dm_pad_awvalid"); @223
// &Force("input","pad_tdt_dm_awready"); @224
// &Force("output","tdt_dm_pad_wdata"); @225
// &Force("bus","tdt_dm_pad_wdata",`TDT_DM_SBA_DW-1,0); @226
// &Force("output","tdt_dm_pad_wvalid"); @227
// &Force("output","tdt_dm_pad_wlast"); @228
// &Force("output","tdt_dm_pad_wstrb"); @229
// &Force("bus","tdt_dm_pad_wstrb",`TDT_DM_SBA_BW-1,0); @230
// &Force("input","pad_tdt_dm_wready"); @231
// &Force("output","tdt_dm_pad_bready"); @232
// &Force("input","pad_tdt_dm_bid"); @233
// &Force("bus","pad_tdt_dm_bid",3,0); @234
// &Force("input","pad_tdt_dm_bresp"); @235
// &Force("bus","pad_tdt_dm_bresp",1,0); @236
// &Force("input","pad_tdt_dm_bvalid"); @237

// &Force("output","tdt_dm_pad_arid"); @239
// &Force("bus","tdt_dm_pad_arid",3,0); @240
// &Force("output","tdt_dm_pad_araddr"); @241
// &Force("bus","tdt_dm_pad_araddr",`TDT_DM_SBAW-1,0); @242
// &Force("output","tdt_dm_pad_arlen"); @243
// &Force("bus","tdt_dm_pad_arlen",3,0); @244
// &Force("output","tdt_dm_pad_arsize"); @245
// &Force("bus","tdt_dm_pad_arsize",2,0); @246
// &Force("output","tdt_dm_pad_arvalid"); @247
// &Force("input","pad_tdt_dm_arready"); @248

// &Force("input","pad_tdt_dm_rid"); @250
// &Force("bus","pad_tdt_dm_rid",3,0); @251
// &Force("input","pad_tdt_dm_rdata"); @252
// &Force("bus","pad_tdt_dm_rdata",`TDT_DM_SBA_DW-1,0); @253
// &Force("input","pad_tdt_dm_rvalid"); @254
// &Force("input","pad_tdt_dm_rlast"); @255
// &Force("input","pad_tdt_dm_rresp"); @256
// &Force("bus","pad_tdt_dm_rresp",1,0); @257

// &Force("output","tdt_dm_pad_rready"); @259

// &Force("output","tdt_dm_pad_awburst"); @261
// &Force("bus","tdt_dm_pad_awburst",1,0); @262
// &Force("output","tdt_dm_pad_awcache"); @263
// &Force("bus","tdt_dm_pad_awcache",3,0); @264
// &Force("output","tdt_dm_pad_awlock"); @265
// //&Force("bus","tdt_dm_pad_awlock",1,0); @266
// &Force("output","tdt_dm_pad_awprot"); @267
// &Force("bus","tdt_dm_pad_awprot",2,0); @268
// &Force("output","tdt_dm_pad_arburst"); @269
// &Force("bus","tdt_dm_pad_arburst",1,0); @270
// &Force("output","tdt_dm_pad_arcache"); @271
// &Force("bus","tdt_dm_pad_arcache",3,0); @272
// &Force("output","tdt_dm_pad_arlock"); @273
// //&Force("bus","tdt_dm_pad_arlock",1,0); @274
// &Force("output","tdt_dm_pad_arprot"); @275
// &Force("bus","tdt_dm_pad_arprot",2,0); @276
// &Force("output","tdt_dm_pad_htrans"); @279
// &Force("bus","tdt_dm_pad_htrans",1,0); @280
// &Force("output","tdt_dm_pad_hprot"); @281
// &Force("bus","tdt_dm_pad_hprot",3,0); @282
// &Force("output","tdt_dm_pad_hmastlock"); @283
// &Force("output","tdt_dm_pad_haddr"); @285
// &Force("bus","tdt_dm_pad_haddr",`TDT_DM_SBAW-1,0); @286
// &Force("output","tdt_dm_pad_hwrite"); @287
// &Force("output","tdt_dm_pad_hburst"); @288
// &Force("bus","tdt_dm_pad_hburst",2,0); @289
// &Force("output","tdt_dm_pad_hsize"); @290
// &Force("bus","tdt_dm_pad_hsize",2,0); @291
// &Force("output","tdt_dm_pad_hwdata"); @292
// &Force("bus","tdt_dm_pad_hwdata",`TDT_DM_SBA_DW-1,0); @293
// &Force("input","pad_tdt_dm_hrdata"); @294
// &Force("bus","pad_tdt_dm_hrdata",`TDT_DM_SBA_DW-1,0); @295
// &Force("input","pad_tdt_dm_hready"); @296
// &Force("input","pad_tdt_dm_hresp"); @297


// &ModuleEnd; @301
endmodule



