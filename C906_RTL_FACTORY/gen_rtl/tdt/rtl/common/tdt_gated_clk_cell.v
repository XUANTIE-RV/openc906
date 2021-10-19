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

module tdt_gated_clk_cell(
  clk_in,
  global_en,
  module_en,
  local_en,
  external_en,
  pad_yy_icg_scan_en,
  clk_out
);

input  clk_in;
input  global_en;
input  module_en;
input  local_en;
input  external_en;
input  pad_yy_icg_scan_en;
output clk_out;

wire   clk_en_bf_latch;
wire   SE;

assign clk_en_bf_latch = (global_en && (module_en || local_en)) || external_en ;

// SE driven from primary input, held constant
assign SE       = pad_yy_icg_scan_en;

`ifdef TDT_GATED_CELL  
tdt_gated_cell x_tdt_gated_cell(
  .clk_in        (clk_in),
  .external_en   (clk_en_bf_latch),
  .SE            (SE),
  .clk_out       (clk_out)
  );
//`ifdef TDT_SMIC
//  `ifdef TDT_PROCESS55LL
//HVT_CLKLANQHDV8 x_gated_clk_cell(
//.CK(clk_in),
//  `endif
//.TE(SE),
//.E(clk_en_bf_latch),
//.Q(clk_out));
//`endif
//`ifdef TDT_TSMC
//  `ifdef TDT_PROCESS40LP
//CKLNQD1BWP x_gated_clk_cell(
//.CP(clk_in),
//.TE(SE),
//.E(clk_en_bf_latch),
//.Q(clk_out));
//  `endif
//  `ifdef TDT_PROCESS28HPC
//    CKLNQD8BWP35P140  x_gated_clk_cell (
//                .CP     (clk_in),
//                .TE     (SE),
//                .E      (clk_en_bf_latch),
//                .Q      (clk_out)
//                );
//  `endif
//`endif
//`ifdef TDT_GSMC
//  `ifdef TDT_PROCESS130
//CLKGTPHD8X x_gated_clk_cell(
//.CK(clk_in),
//  `endif
//.TE(SE),
//.E(clk_en_bf_latch),
//.Z(clk_out));
//`endif
//
//`ifdef TDT_UMC
//  `ifdef TDT_PROCESS28HDE
//    PREICG_X4B_A9PP140ZTR_C30 x_gated_clk_cell (
//    .CK(clk_in),
//    .SE(SE),
//    .E(clk_en_bf_latch),
//    .ECK(clk_out)
//  );
//    `endif 
//   `ifdef TDT_PROCESS22HDE
//    PREICG_X4B_A9PP140ZTS_C30 x_gated_clk_cell (
//    .CK(clk_in),
//    .SE(SE),
//    .E(clk_en_bf_latch),
//    .ECK(clk_out)
//  );
//  
//  `endif
//`endif
`else
//STN_CKGTPLT_V5_1  x_gated_clk_cell (
//  .CK           (clk_in),
//  .SE               (SE),
//  .EN      (clk_en_bf_latch),
//  .Q          (clk_out)
//);
assign clk_out = clk_in;
`endif


endmodule   
