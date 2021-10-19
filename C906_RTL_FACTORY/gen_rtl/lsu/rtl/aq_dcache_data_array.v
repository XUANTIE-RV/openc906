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

// &ModuleBeg; @20
module aq_dcache_data_array(
  cp0_lsu_icg_en,
  data_cen,
  data_clk_en,
  data_din,
  data_dout,
  data_gwen,
  data_idx,
  data_wen,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @21
input           cp0_lsu_icg_en;    
input           data_cen;          
input           data_clk_en;       
input   [63:0]  data_din;          
input           data_gwen;         
input   [13:0]  data_idx;          
input   [63:0]  data_wen;          
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
output  [63:0]  data_dout;         

// &Regs; @22

// &Wires; @23
wire            cp0_lsu_icg_en;    
wire            data_cen;          
wire            data_clk;          
wire            data_clk_en;       
wire    [63:0]  data_din;          
wire    [63:0]  data_dout;         
wire            data_gwen;         
wire    [13:0]  data_idx;          
wire    [63:0]  data_wen;          
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 


// &Force("bus", "data_idx",13,0); @25

//==========================================================
//                 Instance of Gated Cell
//==========================================================
// &Instance("gated_clk_cell", "x_dcache_data_gated_clk"); @30
gated_clk_cell  x_dcache_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_clk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( @31
//   .clk_in               (forever_cpuclk       ), @32
//   .clk_out              (data_clk             ), @33
//   .external_en          (1'b0                 ), @34
//   .global_en            (1'b1                 ), @35
//   .local_en             (data_clk_en          ), @36
//   .module_en            (cp0_lsu_icg_en       ) @37
// ); @38

//==========================================================
//              Instance dcache array
//==========================================================
// 	&Instance("aq_spsram_128x64", "x_aq_spsram_128x64"); @45
// 	&Instance("aq_spsram_256x64", "x_aq_spsram_256x64"); @48
// 	&Instance("aq_spsram_512x64", "x_aq_spsram_512x64"); @51
// 	&Instance("aq_spsram_1024x64", "x_aq_spsram_1024x64");  @54
// 	&Connect( @56
// 	  .A              (data_idx[`D_DATA_INDEX_WIDTH+2:4]), @57
// 	  .CEN            (data_cen            ), @58
// 	  .CLK            (data_clk            ), @59
// 	  .GWEN           (data_gwen           ), @60
// 	  .D              (data_din            ), @61
// 	  .Q              (data_dout           ), @62
// 	  .WEN            (data_wen            ) @63
// 	); @64
// 	&Instance("aq_spsram_256x64", "x_aq_spsram_256x64"); @67
// 	&Instance("aq_spsram_512x64", "x_aq_spsram_512x64"); @70
// 	&Instance("aq_spsram_1024x64", "x_aq_spsram_1024x64");  @73
aq_spsram_1024x64  x_aq_spsram_1024x64 (
  .A              (data_idx[12:3]),
  .CEN            (data_cen      ),
  .CLK            (data_clk      ),
  .D              (data_din      ),
  .GWEN           (data_gwen     ),
  .Q              (data_dout     ),
  .WEN            (data_wen      )
);

// 	&Instance("aq_spsram_2048x64", "x_aq_spsram_2048x64"); @76
// 	&Connect( @78
// 	  .A              (data_idx[`D_DATA_INDEX_WIDTH+2:3]), @79
// 	  .CEN            (data_cen            ), @80
// 	  .CLK            (data_clk            ), @81
// 	  .GWEN           (data_gwen           ), @82
// 	  .D              (data_din            ), @83
// 	  .Q              (data_dout           ), @84
// 	  .WEN            (data_wen            ) @85
// 	); @86

// &ModuleEnd; @89
endmodule


