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
// &Depend("aq_lsu_cfig.h"); @19

// &ModuleBeg; @21
module aq_dcache_tag_array(
  cp0_lsu_icg_en,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  tag_cen,
  tag_clk_en,
  tag_din,
  tag_dout,
  tag_gwen,
  tag_idx,
  tag_way,
  tag_wen
);

// &Ports; @22
input            cp0_lsu_icg_en;    
input            forever_cpuclk;    
input            pad_yy_icg_scan_en; 
input            tag_cen;           
input            tag_clk_en;        
input   [119:0]  tag_din;           
input            tag_gwen;          
input   [11 :0]  tag_idx;           
input   [3  :0]  tag_way;           
input   [119:0]  tag_wen;           
output  [119:0]  tag_dout;          

// &Regs; @23

// &Wires; @24
wire             cp0_lsu_icg_en;    
wire             forever_cpuclk;    
wire             pad_yy_icg_scan_en; 
wire             tag_cen;           
wire             tag_cen_bank0;     
wire             tag_cen_bank1;     
wire             tag_clk_bank0;     
wire             tag_clk_bank1;     
wire             tag_clk_en;        
wire             tag_clk_en_bank0;  
wire             tag_clk_en_bank1;  
wire    [119:0]  tag_din;           
wire    [115:0]  tag_din_raw;       
wire    [119:0]  tag_dout;          
wire    [115:0]  tag_dout_raw;      
wire             tag_gwen;          
wire    [11 :0]  tag_idx;           
wire    [3  :0]  tag_way;           
wire    [119:0]  tag_wen;           
wire    [115:0]  tag_wen_raw;       


parameter D_TAG_TAG_LEN   = `D_TAG_TAG_WIDTH;
parameter D_TAG_INDEX_LEN = `D_TAG_INDEX_WIDTH;

// &Force("bus","tag_wen",119,0); @29
// &Force("bus","tag_din",119,0); @30
// &Force("bus","tag_idx",11,0); @31

assign tag_wen_raw[4*D_TAG_TAG_LEN+3:0] = {tag_wen[119],tag_wen[90+D_TAG_TAG_LEN-1:90], 
                                           tag_wen[89], tag_wen[60+D_TAG_TAG_LEN-1:60],
                                           tag_wen[59], tag_wen[30+D_TAG_TAG_LEN-1:30], 
                                           tag_wen[29], tag_wen[D_TAG_TAG_LEN-1:0]};


assign tag_din_raw[4*D_TAG_TAG_LEN+3:0] = {tag_din[119],tag_din[90+D_TAG_TAG_LEN-1:90], 
                                           tag_din[89], tag_din[60+D_TAG_TAG_LEN-1:60],
                                           tag_din[59], tag_din[30+D_TAG_TAG_LEN-1:30], 
                                           tag_din[29], tag_din[D_TAG_TAG_LEN-1:0]};

assign tag_dout[119:0] = {tag_dout_raw[4*D_TAG_TAG_LEN+3], 1'b0, tag_dout_raw[4*D_TAG_TAG_LEN+2:3*D_TAG_TAG_LEN+3],
                          tag_dout_raw[3*D_TAG_TAG_LEN+2], 1'b0, tag_dout_raw[3*D_TAG_TAG_LEN+1:2*D_TAG_TAG_LEN+2],
                          tag_dout_raw[2*D_TAG_TAG_LEN+1], 1'b0, tag_dout_raw[2*D_TAG_TAG_LEN:D_TAG_TAG_LEN+1],  
                          tag_dout_raw[D_TAG_TAG_LEN],     1'b0, tag_dout_raw[D_TAG_TAG_LEN-1:0]};

assign tag_clk_en_bank0 = tag_clk_en & (|tag_way[1:0]);
assign tag_cen_bank0    = tag_cen | ~(|tag_way[1:0]);

assign tag_clk_en_bank1 = tag_clk_en & (|tag_way[3:2]);
assign tag_cen_bank1    = tag_cen | ~(|tag_way[3:2]);

 //==========================================================
//                 Instance of Gated Cell
//==========================================================
// &Instance("gated_clk_cell", "x_dcache_tag_gated_clk_bank0"); @65
gated_clk_cell  x_dcache_tag_gated_clk_bank0 (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (tag_clk_bank0     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (tag_clk_en_bank0  ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( @66
//   .clk_in               (forever_cpuclk      ), @67
//   .clk_out              (tag_clk_bank0       ), @68
//   .external_en          (1'b0                ), @69
//   .global_en            (1'b1                ), @70
//   .local_en             (tag_clk_en_bank0    ), @71
//   .module_en            (cp0_lsu_icg_en      ) @72
// ); @73

// &Instance("gated_clk_cell", "x_dcache_tag_gated_clk_bank1"); @75
gated_clk_cell  x_dcache_tag_gated_clk_bank1 (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (tag_clk_bank1     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (tag_clk_en_bank1  ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( @76
//   .clk_in               (forever_cpuclk      ), @77
//   .clk_out              (tag_clk_bank1       ), @78
//   .external_en          (1'b0                ), @79
//   .global_en            (1'b1                ), @80
//   .local_en             (tag_clk_en_bank1    ), @81
//   .module_en            (cp0_lsu_icg_en      ) @82
// ); @83

//==========================================================
//              Instance dcache array
//==========================================================
// &Instance("aq_spsram_32x60", "x_aq_spsram_32x60_bank0");  @89
// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank0");  @92
// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank0");  @95
aq_spsram_64x58  x_aq_spsram_64x58_bank0 (
  .A                  (tag_idx[11:6]     ),
  .CEN                (tag_cen_bank0     ),
  .CLK                (tag_clk_bank0     ),
  .D                  (tag_din_raw[57:0] ),
  .GWEN               (tag_gwen          ),
  .Q                  (tag_dout_raw[57:0]),
  .WEN                (tag_wen_raw[57:0] )
);

// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank0");  @98
// &Connect( @100
//   .A              (tag_idx[D_TAG_INDEX_LEN+5:6]), @101
//   .CEN            (tag_cen_bank0), @102
//   .CLK            (tag_clk_bank0), @103
//   .GWEN           (tag_gwen), @104
//   .D              (tag_din_raw[2*D_TAG_TAG_LEN+1:0]), @105
//   .Q              (tag_dout_raw[2*D_TAG_TAG_LEN+1:0]), @106
//   .WEN            (tag_wen_raw[2*D_TAG_TAG_LEN+1:0]) @107
// ); @108

// &Instance("aq_spsram_32x60", "x_aq_spsram_32x60_bank1"); @111
// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank1"); @114
// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank1"); @117
aq_spsram_64x58  x_aq_spsram_64x58_bank1 (
  .A                    (tag_idx[11:6]       ),
  .CEN                  (tag_cen_bank1       ),
  .CLK                  (tag_clk_bank1       ),
  .D                    (tag_din_raw[115:58] ),
  .GWEN                 (tag_gwen            ),
  .Q                    (tag_dout_raw[115:58]),
  .WEN                  (tag_wen_raw[115:58] )
);

// &Instance("aq_spsram_64x58", "x_aq_spsram_64x58_bank1");  @120
// &Connect( @122
//   .A              (tag_idx[D_TAG_INDEX_LEN+5:6]), @123
//   .CEN            (tag_cen_bank1), @124
//   .CLK            (tag_clk_bank1), @125
//   .GWEN           (tag_gwen), @126
//   .D              (tag_din_raw[4*D_TAG_TAG_LEN+3:2*D_TAG_TAG_LEN+2]), @127
//   .Q              (tag_dout_raw[4*D_TAG_TAG_LEN+3:2*D_TAG_TAG_LEN+2]), @128
//   .WEN            (tag_wen_raw[4*D_TAG_TAG_LEN+3:2*D_TAG_TAG_LEN+2]) @129
// ); @130

// &ModuleEnd; @132
endmodule



