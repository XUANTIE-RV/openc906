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

// &ModuleBeg; @22
module tdt_dmi_top(
  pad_tdt_dtm_jtag2_sel,
  pad_tdt_dtm_tap_en,
  pad_tdt_dtm_tclk,
  pad_tdt_dtm_tdi,
  pad_tdt_dtm_tms_i,
  pad_tdt_dtm_trst_b,
  pad_tdt_icg_scan_en,
  pad_yy_scan_mode,
  pad_yy_scan_rst_b,
  sys_apb_clk,
  sys_apb_rst_b,
  tdt_dmi_paddr,
  tdt_dmi_penable,
  tdt_dmi_prdata,
  tdt_dmi_pready,
  tdt_dmi_psel,
  tdt_dmi_pslverr,
  tdt_dmi_pwdata,
  tdt_dmi_pwrite,
  tdt_dtm_pad_tdo,
  tdt_dtm_pad_tdo_en,
  tdt_dtm_pad_tms_o,
  tdt_dtm_pad_tms_oe
);

// &Ports; @23
input           pad_tdt_dtm_jtag2_sel; 
input           pad_tdt_dtm_tap_en; 
input           pad_tdt_dtm_tclk; 
input           pad_tdt_dtm_tdi; 
input           pad_tdt_dtm_tms_i; 
input           pad_tdt_dtm_trst_b; 
input           pad_tdt_icg_scan_en; 
input           pad_yy_scan_mode; 
input           pad_yy_scan_rst_b; 
input           sys_apb_clk; 
input           sys_apb_rst_b; 
input   [31:0]  tdt_dmi_prdata; 
input           tdt_dmi_pready; 
input           tdt_dmi_pslverr; 
output  [11:0]  tdt_dmi_paddr; 
output          tdt_dmi_penable; 
output          tdt_dmi_psel; 
output  [31:0]  tdt_dmi_pwdata; 
output          tdt_dmi_pwrite; 
output          tdt_dtm_pad_tdo; 
output          tdt_dtm_pad_tdo_en; 
output          tdt_dtm_pad_tms_o; 
output          tdt_dtm_pad_tms_oe; 

// &Regs; @24

// &Wires; @25


tdt_dmi_rst_top x_tdt_dmi_rst_top (
    .sys_apb_clk(sys_apb_clk),
    .sys_apb_rst_b(sys_apb_rst_b),
    .pad_yy_scan_mode(pad_yy_scan_mode),
    .pad_yy_scan_rst_b(pad_yy_scan_rst_b),
    .sync_sys_apb_rst_b(sync_sys_apb_rst_b)
);

tdt_dmi x_tdt_dmi (
    .sys_apb_clk(sys_apb_clk),
    .sys_apb_rst_b(sync_sys_apb_rst_b),
    .pad_tdt_dtm_tclk(pad_tdt_dtm_tclk),
    .pad_tdt_dtm_trst_b(pad_tdt_dtm_trst_b),
    .pad_tdt_dtm_jtag2_sel(pad_tdt_dtm_jtag2_sel),         
    .pad_tdt_dtm_tap_en(pad_tdt_dtm_tap_en),        
    .pad_tdt_dtm_tdi(pad_tdt_dtm_tdi),           
    .pad_tdt_dtm_tms_i(pad_tdt_dtm_tms_i),  
    .tdt_dtm_pad_tdo(tdt_dtm_pad_tdo),           
    .tdt_dtm_pad_tdo_en(tdt_dtm_pad_tdo_en),        
    .tdt_dtm_pad_tms_o(tdt_dtm_pad_tms_o),         
    .tdt_dtm_pad_tms_oe(tdt_dtm_pad_tms_oe),

    .pad_icg_scan_en(pad_tdt_icg_scan_en),


    .tdt_dmi_paddr(tdt_dmi_paddr),
    .tdt_dmi_pwrite(tdt_dmi_pwrite),
    .tdt_dmi_penable(tdt_dmi_penable),
    .tdt_dmi_pwdata(tdt_dmi_pwdata),
    .tdt_dmi_psel(tdt_dmi_psel),
    .tdt_dmi_prdata(tdt_dmi_prdata),
    .tdt_dmi_pslverr(tdt_dmi_pslverr),
    .tdt_dmi_pready(tdt_dmi_pready)

);


// &Force("input", "sys_apb_clk"); @75
// &Force("input", "sys_apb_rst_b"); @76
// &Force("input", "pad_tdt_dtm_tclk"); @77
// &Force("input", "pad_tdt_dtm_trst_b"); @78
// &Force("input", "pad_tdt_dtm_jtag2_sel");          @79
// &Force("input", "pad_tdt_dtm_tap_en");         @80
// &Force("input", "pad_tdt_dtm_tdi");            @81
// &Force("input", "pad_tdt_dtm_tms_i");   @82
// &Force("output", "tdt_dtm_pad_tdo");            @83
// &Force("output", "tdt_dtm_pad_tdo_en");         @84
// &Force("output", "tdt_dtm_pad_tms_o");          @85
// &Force("output", "tdt_dtm_pad_tms_oe"); @86
// &Force("input", "pad_tdt_icg_scan_en");   @87
// &Force("input", "pad_yy_scan_mode"); @88
// &Force("input", "pad_yy_scan_rst_b"); @89

// &Force("input", "pad_tdt_sysapb_en"); @92
// &Force("input", "pad_tdt_dmi_paddr"); @93
// &Force("bus","pad_tdt_dmi_paddr",12+`TDT_DMI_HIGH_ADDR_W-1,0); @94
// &Force("input", "pad_tdt_dmi_pwrite"); @95
// &Force("input", "pad_tdt_dmi_psel"); @96
// &Force("input", "pad_tdt_dmi_penable"); @97
// &Force("input", "pad_tdt_dmi_pwdata"); @98
// &Force("bus","pad_tdt_dmi_pwdata",31,0); @99
// &Force("output", "tdt_dmi_pad_prdata"); @100
// &Force("bus","tdt_dmi_pad_prdata",31,0); @101
// &Force("output", "tdt_dmi_pad_pready"); @102
// &Force("output", "tdt_dmi_pad_pslverr"); @103

// &Force("output", "tdt_dmi_paddr"); @106
// &Force("bus","tdt_dmi_paddr",11,0); @107
// &Force("output", "tdt_dmi_pwrite"); @108
// &Force("output", "tdt_dmi_penable"); @109
// &Force("output", "tdt_dmi_pwdata"); @110
// &Force("bus","tdt_dmi_pwdata",31,0); @111
// &Force("output", "tdt_dmi_psel"); @113
// &Force("output", "tdt_dmi_psel");&Force("bus","tdt_dmi_psel",`TDT_DMI_SLAVE_NUM-1,0); @115
// &Force("input", "tdt_dmi_prdata"); @117
// &Force("bus","tdt_dmi_prdata",32*`TDT_DMI_SLAVE_NUM-1,0); @118
// &Force("input", "tdt_dmi_pready"); @120
// &Force("input", "tdt_dmi_pslverr"); @121
// &Force("input", "tdt_dmi_pready");&Force("bus","tdt_dmi_pready",`TDT_DMI_SLAVE_NUM-1,0); @123
// &Force("input", "tdt_dmi_pslverr");&Force("bus","tdt_dmi_pslverr",`TDT_DMI_SLAVE_NUM-1,0); @124

// &ModuleEnd; @127
endmodule


