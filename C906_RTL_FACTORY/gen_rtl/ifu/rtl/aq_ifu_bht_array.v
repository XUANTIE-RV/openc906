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

// &ModuleBeg; @23
module aq_ifu_bht_array(
  bht_cen,
  bht_cen_gate,
  bht_din,
  bht_dout,
  bht_idx,
  bht_wen,
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @24
input           bht_cen;           
input           bht_cen_gate;      
input   [15:0]  bht_din;           
input   [9 :0]  bht_idx;           
input   [15:0]  bht_wen;           
input           cp0_ifu_icg_en;    
input           cp0_yy_clk_en;     
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
output  [15:0]  bht_dout;          

// &Regs; @25

// &Wires; @26
wire    [15:0]  bht_bwen_b;        
wire            bht_cen;           
wire            bht_cen_b;         
wire            bht_cen_gate;      
wire            bht_clk;           
wire    [15:0]  bht_din;           
wire    [15:0]  bht_dout;          
wire            bht_gwen_b;        
wire            bht_icg_en;        
wire    [9 :0]  bht_idx;           
wire    [15:0]  bht_wen;           
wire            cp0_ifu_icg_en;    
wire            cp0_yy_clk_en;     
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 


//==========================================================
// BHT Array Module
// 1. Instance ICG Cell
// 2. Instance Memory Cell
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign bht_icg_en = bht_cen_gate;
// &Instance("gated_clk_cell", "x_bht_icg_cell"); @38
gated_clk_cell  x_bht_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bht_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bht_icg_en        ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in      (forever_cpuclk), @39
//           .external_en (1'b0          ), @40
//           .global_en   (cp0_yy_clk_en ), @41
//           .module_en   (cp0_ifu_icg_en), @42
//           .local_en    (bht_icg_en    ), @43
//           .clk_out     (bht_clk       ) @44
//          ); @45

//------------------------------------------------
// 2. Instance Memory Cell
//------------------------------------------------
assign bht_cen_b       = !bht_cen;
assign bht_gwen_b      = !(|bht_wen[15:0]);
assign bht_bwen_b[15:0] = ~bht_wen[15:0];

// &Instance("aq_spsram_128x16","x_aq_spsram_128x16"); @55
// &Instance("aq_spsram_256x16","x_aq_spsram_256x16"); @58
// &Instance("aq_spsram_512x16","x_aq_spsram_512x16"); @61
// &Instance("aq_spsram_1024x16","x_aq_spsram_1024x16"); @64
aq_spsram_1024x16  x_aq_spsram_1024x16 (
  .A          (bht_idx   ),
  .CEN        (bht_cen_b ),
  .CLK        (bht_clk   ),
  .D          (bht_din   ),
  .GWEN       (bht_gwen_b),
  .Q          (bht_dout  ),
  .WEN        (bht_bwen_b)
);

// &Connect( @66
//          .CLK    (bht_clk   ), @67
//          .CEN    (bht_cen_b ), @68
//          .GWEN   (bht_gwen_b), @69
//          .WEN    (bht_bwen_b), @70
//          .A      (bht_idx   ), @71
//          .D      (bht_din   ), @72
//          .Q      (bht_dout  ) @73
//        ); @74

// &ModuleEnd; @76
endmodule


