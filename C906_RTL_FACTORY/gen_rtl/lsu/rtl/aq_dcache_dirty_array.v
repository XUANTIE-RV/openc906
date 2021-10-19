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

// &Depend("cpu_cfig.h"); @18

// &ModuleBeg; @20
module aq_dcache_dirty_array(
  cp0_lsu_icg_en,
  dirty_cen,
  dirty_clk_en,
  dirty_din,
  dirty_dout,
  dirty_gwen,
  dirty_idx,
  dirty_wen,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @21
input           cp0_lsu_icg_en;    
input           dirty_cen;         
input           dirty_clk_en;      
input   [7 :0]  dirty_din;         
input           dirty_gwen;        
input   [13:0]  dirty_idx;         
input   [7 :0]  dirty_wen;         
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
output  [7 :0]  dirty_dout;        

// &Regs; @22

// &Wires; @23
wire            cp0_lsu_icg_en;    
wire            dirty_cen;         
wire            dirty_clk;         
wire            dirty_clk_en;      
wire    [7 :0]  dirty_din;         
wire    [7 :0]  dirty_dout;        
wire            dirty_gwen;        
wire    [13:0]  dirty_idx;         
wire    [7 :0]  dirty_wen;         
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 


// &Force("bus", "dirty_idx",13,0); @25

//==========================================================
//                 Instance of Gated Cell
//==========================================================
// &Instance("gated_clk_cell","x_dcache_dirty_gated_clk"); @30
gated_clk_cell  x_dcache_dirty_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dirty_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dirty_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( @31
//   .clk_in               (forever_cpuclk      ), @32
//   .clk_out              (dirty_clk           ), @33
//   .external_en          (1'b0                ), @34
//   .global_en            (1'b1                ), @35
//   .local_en             (dirty_clk_en        ), @36
//   .module_en            (cp0_lsu_icg_en      ) @37
// ); @38

//==========================================================
//              Instance dcache array
//==========================================================
// &Instance("aq_spsram_32x8","x_aq_spsram_32x8"); @44
// &Instance("aq_spsram_64x8","x_aq_spsram_64x8"); @47
// &Instance("aq_spsram_128x8","x_aq_spsram_128x8"); @50
aq_spsram_128x8  x_aq_spsram_128x8 (
  .A               (dirty_idx[12:6]),
  .CEN             (dirty_cen      ),
  .CLK             (dirty_clk      ),
  .D               (dirty_din      ),
  .GWEN            (dirty_gwen     ),
  .Q               (dirty_dout     ),
  .WEN             (dirty_wen      )
);

// &Instance("aq_spsram_256x8","x_aq_spsram_256x8");  @53
// &Connect( @55
//   .A              (dirty_idx[`D_DATA_INDEX_WIDTH+2:6]), @56
//   .CEN            (dirty_cen            ), @57
//   .CLK            (dirty_clk            ), @58
//   .GWEN           (dirty_gwen           ), @59
//   .D              (dirty_din            ), @60
//   .Q              (dirty_dout           ), @61
//   .WEN            (dirty_wen            ) @62
// ); @63

// &ModuleEnd; @65
endmodule


