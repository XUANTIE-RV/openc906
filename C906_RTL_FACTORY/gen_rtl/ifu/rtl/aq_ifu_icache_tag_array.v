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

// &ModuleBeg; @24
module aq_ifu_icache_tag_array(
  cp0_yy_clk_en,
  forever_cpuclk,
  icache_tag_cen,
  icache_tag_din,
  icache_tag_dout,
  icache_tag_idx,
  icache_tag_wen,
  pad_yy_icg_scan_en
);

// &Ports; @25
input           cp0_yy_clk_en;     
input           forever_cpuclk;    
input           icache_tag_cen;    
input   [58:0]  icache_tag_din;    
input   [8 :0]  icache_tag_idx;    
input   [2 :0]  icache_tag_wen;    
input           pad_yy_icg_scan_en; 
output  [58:0]  icache_tag_dout;   

// &Regs; @26

// &Wires; @27
wire            cp0_yy_clk_en;     
wire            forever_cpuclk;    
wire    [58:0]  icache_tag_bwen_b; 
wire            icache_tag_cen;    
wire            icache_tag_cen_b;  
wire            icache_tag_clk;    
wire    [58:0]  icache_tag_din;    
wire    [58:0]  icache_tag_dout;   
wire            icache_tag_gwen_b; 
wire            icache_tag_icg_en; 
wire    [8 :0]  icache_tag_idx;    
wire    [7 :0]  icache_tag_index;  
wire    [2 :0]  icache_tag_wen;    
wire            pad_yy_icg_scan_en; 


parameter TAG_INDEX = `I_TAG_INDEX_WIDTH;

// &Force("bus", "icache_tag_idx", 8, 0); @31

//==========================================================
// Icache Tag Array Module
// 1. Instance ICG Cell
// 2. Transmit Port Signals
// 3. Instance Memory Cell 
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign icache_tag_icg_en = icache_tag_cen;
// &Instance("gated_clk_cell", "x_icache_tag_icg_cell"); @44
gated_clk_cell  x_icache_tag_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icache_tag_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (icache_tag_icg_en ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk   ), @45
//           .external_en(1'b0             ), @46
//           .global_en  (cp0_yy_clk_en    ), @47
//           .module_en  (1'b0             ), @48
//           .local_en   (icache_tag_icg_en), @49
//           .clk_out    (icache_tag_clk   ) @50
//          ); @51

//------------------------------------------------
// 2. Transmit Port Signals
//------------------------------------------------
// reverse the negtive effect signals
assign icache_tag_cen_b  = !icache_tag_cen;
assign icache_tag_gwen_b = !(|icache_tag_wen[2:0]);

assign icache_tag_bwen_b[58:0] = ~{icache_tag_wen[2],  //fifo
                                  {29{icache_tag_wen[1]}},  //way1
                                  {29{icache_tag_wen[0]}}   //way0
                                  };

assign icache_tag_index[TAG_INDEX-1:0] = icache_tag_idx[TAG_INDEX-1:0];

//------------------------------------------------
// 3. Instance Memory Cell 
//------------------------------------------------
// &Instance("aq_spsram_64x59", "x_aq_spsram_64x59"); @71
// &Instance("aq_spsram_128x59", "x_aq_spsram_128x59"); @74
// &Instance("aq_spsram_256x59", "x_aq_spsram_256x59"); @77
aq_spsram_256x59  x_aq_spsram_256x59 (
  .A                 (icache_tag_index ),
  .CEN               (icache_tag_cen_b ),
  .CLK               (icache_tag_clk   ),
  .D                 (icache_tag_din   ),
  .GWEN              (icache_tag_gwen_b),
  .Q                 (icache_tag_dout  ),
  .WEN               (icache_tag_bwen_b)
);

// &Instance("aq_spsram_512x59", "x_aq_spsram_512x59"); @80
// &Connect(.CLK    (icache_tag_clk   ), @82
//          .CEN    (icache_tag_cen_b ), @83
//          .GWEN   (icache_tag_gwen_b), @84
//          .WEN    (icache_tag_bwen_b), @85
//          .A      (icache_tag_index ), @86
//          .D      (icache_tag_din   ), @87
//          .Q      (icache_tag_dout  ) @88
// ); @89

// &ModuleEnd; @91
endmodule


