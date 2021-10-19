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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_dcache_top(
  cp0_lsu_icg_en,
  dcache_data02_idx,
  dcache_data13_idx,
  dcache_data_cen_bank0,
  dcache_data_cen_bank1,
  dcache_data_cen_bank2,
  dcache_data_cen_bank3,
  dcache_data_din_bank0,
  dcache_data_din_bank1,
  dcache_data_din_bank2,
  dcache_data_din_bank3,
  dcache_data_dout_bank0,
  dcache_data_dout_bank1,
  dcache_data_dout_bank2,
  dcache_data_dout_bank3,
  dcache_data_wen,
  dcache_dirty_cen,
  dcache_dirty_din,
  dcache_dirty_dout,
  dcache_dirty_idx,
  dcache_dirty_wen,
  dcache_tag_din,
  dcache_tag_dout_bank0,
  dcache_tag_dout_bank1,
  dcache_tag_idx,
  dcache_tag_req,
  dcache_tag_sel,
  dcache_tag_way,
  dcache_tag_wen,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @21
input            cp0_lsu_icg_en;          
input   [13 :0]  dcache_data02_idx;       
input   [13 :0]  dcache_data13_idx;       
input            dcache_data_cen_bank0;   
input            dcache_data_cen_bank1;   
input            dcache_data_cen_bank2;   
input            dcache_data_cen_bank3;   
input   [63 :0]  dcache_data_din_bank0;   
input   [63 :0]  dcache_data_din_bank1;   
input   [63 :0]  dcache_data_din_bank2;   
input   [63 :0]  dcache_data_din_bank3;   
input   [7  :0]  dcache_data_wen;         
input            dcache_dirty_cen;        
input   [7  :0]  dcache_dirty_din;        
input   [13 :0]  dcache_dirty_idx;        
input   [7  :0]  dcache_dirty_wen;        
input   [29 :0]  dcache_tag_din;          
input   [11 :0]  dcache_tag_idx;          
input            dcache_tag_req;          
input   [3  :0]  dcache_tag_sel;          
input   [3  :0]  dcache_tag_way;          
input            dcache_tag_wen;          
input            forever_cpuclk;          
input            pad_yy_icg_scan_en;      
output  [63 :0]  dcache_data_dout_bank0;  
output  [63 :0]  dcache_data_dout_bank1;  
output  [63 :0]  dcache_data_dout_bank2;  
output  [63 :0]  dcache_data_dout_bank3;  
output  [7  :0]  dcache_dirty_dout;       
output  [119:0]  dcache_tag_dout_bank0;   
output  [119:0]  dcache_tag_dout_bank1;   

// &Regs; @22

// &Wires; @23
wire             cp0_lsu_icg_en;          
wire    [13 :0]  dcache_data02_idx;       
wire    [13 :0]  dcache_data13_idx;       
wire             dcache_data_cen_bank0;   
wire             dcache_data_cen_bank1;   
wire             dcache_data_cen_bank2;   
wire             dcache_data_cen_bank3;   
wire             dcache_data_clk_en_bank0; 
wire             dcache_data_clk_en_bank1; 
wire             dcache_data_clk_en_bank2; 
wire             dcache_data_clk_en_bank3; 
wire    [63 :0]  dcache_data_din_bank0;   
wire    [63 :0]  dcache_data_din_bank1;   
wire    [63 :0]  dcache_data_din_bank2;   
wire    [63 :0]  dcache_data_din_bank3;   
wire    [63 :0]  dcache_data_dout_bank0;  
wire    [63 :0]  dcache_data_dout_bank1;  
wire    [63 :0]  dcache_data_dout_bank2;  
wire    [63 :0]  dcache_data_dout_bank3;  
wire             dcache_data_gwen;        
wire    [7  :0]  dcache_data_wen;         
wire    [63 :0]  dcache_data_wen_bankx;   
wire             dcache_dirty_cen;        
wire             dcache_dirty_clk_en;     
wire    [7  :0]  dcache_dirty_din;        
wire    [7  :0]  dcache_dirty_dout;       
wire             dcache_dirty_gwen;       
wire    [13 :0]  dcache_dirty_idx;        
wire    [7  :0]  dcache_dirty_wen;        
wire             dcache_tag_cen_bank0;    
wire             dcache_tag_cen_bank1;    
wire             dcache_tag_clk_en_bank0; 
wire             dcache_tag_clk_en_bank1; 
wire    [29 :0]  dcache_tag_din;          
wire    [119:0]  dcache_tag_din_bankx;    
wire    [119:0]  dcache_tag_dout_bank0;   
wire    [119:0]  dcache_tag_dout_bank1;   
wire             dcache_tag_gwen;         
wire    [11 :0]  dcache_tag_idx;          
wire             dcache_tag_req;          
wire    [3  :0]  dcache_tag_sel;          
wire    [3  :0]  dcache_tag_way;          
wire             dcache_tag_wen;          
wire    [119:0]  dcache_tag_wen_bankx;    
wire             forever_cpuclk;          
wire             pad_yy_icg_scan_en;      


// &Force("bus","dcache_tag_sel",3,0); @25

assign dcache_tag_clk_en_bank0     =  dcache_tag_req & dcache_tag_sel[0]; 
assign dcache_tag_cen_bank0        = ~(dcache_tag_req & dcache_tag_sel[0]);
assign dcache_tag_gwen             =  dcache_tag_wen;
assign dcache_tag_din_bankx[119:0] = {4{dcache_tag_din[29:0]}};
assign dcache_tag_wen_bankx[119:0] = {{30{~dcache_tag_way[3]}},
                                      {30{~dcache_tag_way[2]}},
                                      {30{~dcache_tag_way[1]}},
                                      {30{~dcache_tag_way[0]}}} | {120{dcache_tag_wen}};

// &Instance("aq_dcache_tag_array", "x_aq_dcache_tag_array_bank0"); @36
aq_dcache_tag_array  x_aq_dcache_tag_array_bank0 (
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .forever_cpuclk          (forever_cpuclk         ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .tag_cen                 (dcache_tag_cen_bank0   ),
  .tag_clk_en              (dcache_tag_clk_en_bank0),
  .tag_din                 (dcache_tag_din_bankx   ),
  .tag_dout                (dcache_tag_dout_bank0  ),
  .tag_gwen                (dcache_tag_gwen        ),
  .tag_idx                 (dcache_tag_idx         ),
  .tag_way                 (dcache_tag_way         ),
  .tag_wen                 (dcache_tag_wen_bankx   )
);

// &Connect( @37
//          .tag_clk_en             (dcache_tag_clk_en_bank0), @38
//          .tag_cen                (dcache_tag_cen_bank0   ), @39
//          .tag_wen                (dcache_tag_wen_bankx   ), @40
//          .tag_din                (dcache_tag_din_bankx   ), @41
//          .tag_idx                (dcache_tag_idx         ), @42
//          .tag_way                (dcache_tag_way         ), @43
//          .tag_gwen               (dcache_tag_gwen        ), @44
//          .tag_dout               (dcache_tag_dout_bank0  )); @45

// &Instance("aq_dcache_tag_array", "x_aq_dcache_tag_array_bank1"); @51
// &Connect( @52
//          .tag_clk_en             (dcache_tag_clk_en_bank1), @53
//          .tag_cen                (dcache_tag_cen_bank1   ), @54
//          .tag_wen                (dcache_tag_wen_bankx   ), @55
//          .tag_din                (dcache_tag_din_bankx   ), @56
//          .tag_idx                (dcache_tag_idx         ), @57
//          .tag_way                (dcache_tag_way         ), @58
//          .tag_gwen               (dcache_tag_gwen        ), @59
//          .tag_dout               (dcache_tag_dout_bank1  )); @60
// &Instance("aq_dcache_tag_array", "x_aq_dcache_tag_array_bank2"); @65
// &Connect( @66
//          .tag_clk_en             (dcache_tag_clk_en_bank2), @67
//          .tag_cen                (dcache_tag_cen_bank2   ), @68
//          .tag_wen                (dcache_tag_wen_bankx   ), @69
//          .tag_din                (dcache_tag_din_bankx   ), @70
//          .tag_idx                (dcache_tag_idx         ), @71
//          .tag_way                (dcache_tag_way         ), @72
//          .tag_gwen               (dcache_tag_gwen        ), @73
//          .tag_dout               (dcache_tag_dout_bank2  )); @74
// &Instance("aq_dcache_tag_array", "x_aq_dcache_tag_array_bank3"); @79
// &Connect( @80
//          .tag_clk_en             (dcache_tag_clk_en_bank3), @81
//          .tag_cen                (dcache_tag_cen_bank3   ), @82
//          .tag_wen                (dcache_tag_wen_bankx   ), @83
//          .tag_din                (dcache_tag_din_bankx   ), @84
//          .tag_idx                (dcache_tag_idx         ), @85
//          .tag_way                (dcache_tag_way         ), @86
//          .tag_gwen               (dcache_tag_gwen        ), @87
//          .tag_dout               (dcache_tag_dout_bank3  )); @88
assign dcache_tag_clk_en_bank1     =  dcache_tag_req & dcache_tag_sel[1]; 
assign dcache_tag_cen_bank1        = ~(dcache_tag_req & dcache_tag_sel[1]);

// &Instance("aq_dcache_tag_array", "x_aq_dcache_tag_array_bank1"); @94
aq_dcache_tag_array  x_aq_dcache_tag_array_bank1 (
  .cp0_lsu_icg_en          (cp0_lsu_icg_en         ),
  .forever_cpuclk          (forever_cpuclk         ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .tag_cen                 (dcache_tag_cen_bank1   ),
  .tag_clk_en              (dcache_tag_clk_en_bank1),
  .tag_din                 (dcache_tag_din_bankx   ),
  .tag_dout                (dcache_tag_dout_bank1  ),
  .tag_gwen                (dcache_tag_gwen        ),
  .tag_idx                 (dcache_tag_idx         ),
  .tag_way                 (dcache_tag_way         ),
  .tag_wen                 (dcache_tag_wen_bankx   )
);

// &Connect( @95
//          .tag_clk_en             (dcache_tag_clk_en_bank1), @96
//          .tag_cen                (dcache_tag_cen_bank1   ), @97
//          .tag_wen                (dcache_tag_wen_bankx   ), @98
//          .tag_din                (dcache_tag_din_bankx   ), @99
//          .tag_idx                (dcache_tag_idx         ), @100
//          .tag_way                (dcache_tag_way         ), @101
//          .tag_gwen               (dcache_tag_gwen        ), @102
//          .tag_dout               (dcache_tag_dout_bank1  )); @103


//================================================
// dirty array
//================================================
assign dcache_dirty_clk_en = !dcache_dirty_cen; 
assign dcache_dirty_gwen   = &dcache_dirty_wen[7:0];

// &Instance("aq_dcache_dirty_array", "x_aq_dcache_dirty_array"); @114
aq_dcache_dirty_array  x_aq_dcache_dirty_array (
  .cp0_lsu_icg_en      (cp0_lsu_icg_en     ),
  .dirty_cen           (dcache_dirty_cen   ),
  .dirty_clk_en        (dcache_dirty_clk_en),
  .dirty_din           (dcache_dirty_din   ),
  .dirty_dout          (dcache_dirty_dout  ),
  .dirty_gwen          (dcache_dirty_gwen  ),
  .dirty_idx           (dcache_dirty_idx   ),
  .dirty_wen           (dcache_dirty_wen   ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect( @115
//          .dirty_clk_en             (dcache_dirty_clk_en       ), @116
//          .dirty_cen                (dcache_dirty_cen          ), @117
//          .dirty_wen                (dcache_dirty_wen          ), @118
//          .dirty_din                (dcache_dirty_din          ), @119
//          .dirty_idx                (dcache_dirty_idx          ), @120
//          .dirty_gwen               (dcache_dirty_gwen         ), @121
//          .dirty_dout               (dcache_dirty_dout         )); @122

//================================================
//    data array
//================================================
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way0_bank0"); @149
// &Connect( @150
//          .data_clk_en             (dcache_data_clk_en_way0_bank0), @151
//          .data_cen                (dcache_data_cen_way0_bank0   ), @152
//          .data_wen                (dcache_data_wen_bank0        ), @153
//          .data_din                (dcache_data_din_way0_bank0   ), @154
//          .data_idx                (dcache_data_idx_wayx_bank0   ), @155
//          .data_gwen               (dcache_data_gwen_bank0       ), @156
//          .data_dout               (dcache_data_dout_way0_bank0  )); @157
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way0_bank1"); @160
// &Connect( @161
//          .data_clk_en             (dcache_data_clk_en_way0_bank1), @162
//          .data_cen                (dcache_data_cen_way0_bank1   ), @163
//          .data_wen                (dcache_data_wen_bank1        ), @164
//          .data_din                (dcache_data_din_way0_bank1   ), @165
//          .data_idx                (dcache_data_idx_wayx_bank1   ), @166
//          .data_gwen               (dcache_data_gwen_bank1       ), @167
//          .data_dout               (dcache_data_dout_way0_bank1  )); @168
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way1_bank0"); @171
// &Connect( @172
//          .data_clk_en             (dcache_data_clk_en_way1_bank0), @173
//          .data_cen                (dcache_data_cen_way1_bank0   ), @174
//          .data_wen                (dcache_data_wen_bank0        ), @175
//          .data_din                (dcache_data_din_way1_bank0   ), @176
//          .data_idx                (dcache_data_idx_wayx_bank0   ), @177
//          .data_gwen               (dcache_data_gwen_bank0       ), @178
//          .data_dout               (dcache_data_dout_way1_bank0  )); @179
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way1_bank1"); @182
// &Connect( @183
//          .data_clk_en             (dcache_data_clk_en_way1_bank1), @184
//          .data_cen                (dcache_data_cen_way1_bank1   ), @185
//          .data_wen                (dcache_data_wen_bank1        ), @186
//          .data_din                (dcache_data_din_way1_bank1   ), @187
//          .data_idx                (dcache_data_idx_wayx_bank1   ), @188
//          .data_gwen               (dcache_data_gwen_bank1       ), @189
//          .data_dout               (dcache_data_dout_way1_bank1  )); @190
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way2_bank0"); @193
// &Connect( @194
//          .data_clk_en             (dcache_data_clk_en_way2_bank0), @195
//          .data_cen                (dcache_data_cen_way2_bank0   ), @196
//          .data_wen                (dcache_data_wen_bank0        ), @197
//          .data_din                (dcache_data_din_way2_bank0   ), @198
//          .data_idx                (dcache_data_idx_wayx_bank0   ), @199
//          .data_gwen               (dcache_data_gwen_bank0       ), @200
//          .data_dout               (dcache_data_dout_way2_bank0  )); @201
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way2_bank1"); @204
// &Connect( @205
//          .data_clk_en             (dcache_data_clk_en_way2_bank1), @206
//          .data_cen                (dcache_data_cen_way2_bank1   ), @207
//          .data_wen                (dcache_data_wen_bank1        ), @208
//          .data_din                (dcache_data_din_way2_bank1   ), @209
//          .data_idx                (dcache_data_idx_wayx_bank1   ), @210
//          .data_gwen               (dcache_data_gwen_bank1       ), @211
//          .data_dout               (dcache_data_dout_way2_bank1  )); @212
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way3_bank0"); @215
// &Connect( @216
//          .data_clk_en             (dcache_data_clk_en_way3_bank0), @217
//          .data_cen                (dcache_data_cen_way3_bank0   ), @218
//          .data_wen                (dcache_data_wen_bank0        ), @219
//          .data_din                (dcache_data_din_way3_bank0   ), @220
//          .data_idx                (dcache_data_idx_wayx_bank0   ), @221
//          .data_gwen               (dcache_data_gwen_bank0       ), @222
//          .data_dout               (dcache_data_dout_way3_bank0  )); @223
// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_way3_bank1"); @226
// &Connect( @227
//          .data_clk_en             (dcache_data_clk_en_way3_bank1), @228
//          .data_cen                (dcache_data_cen_way3_bank1   ), @229
//          .data_wen                (dcache_data_wen_bank1        ), @230
//          .data_din                (dcache_data_din_way3_bank1   ), @231
//          .data_idx                (dcache_data_idx_wayx_bank1   ), @232
//          .data_gwen               (dcache_data_gwen_bank1       ), @233
//          .data_dout               (dcache_data_dout_way3_bank1  )); @234
assign dcache_data_gwen            = &dcache_data_wen[7:0];
assign dcache_data_wen_bankx[63:0] = {{8{dcache_data_wen[7]}},
                                      {8{dcache_data_wen[6]}},
                                      {8{dcache_data_wen[5]}},
                                      {8{dcache_data_wen[4]}},
                                      {8{dcache_data_wen[3]}},
                                      {8{dcache_data_wen[2]}},
                                      {8{dcache_data_wen[1]}},
                                      {8{dcache_data_wen[0]}}};

assign dcache_data_clk_en_bank0    = !dcache_data_cen_bank0;

// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_bank0"); @248
aq_dcache_data_array  x_aq_dcache_data_array_bank0 (
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .data_cen                 (dcache_data_cen_bank0   ),
  .data_clk_en              (dcache_data_clk_en_bank0),
  .data_din                 (dcache_data_din_bank0   ),
  .data_dout                (dcache_data_dout_bank0  ),
  .data_gwen                (dcache_data_gwen        ),
  .data_idx                 (dcache_data02_idx       ),
  .data_wen                 (dcache_data_wen_bankx   ),
  .forever_cpuclk           (forever_cpuclk          ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect( @249
//          .data_clk_en             (dcache_data_clk_en_bank0), @250
//          .data_cen                (dcache_data_cen_bank0   ), @251
//          .data_wen                (dcache_data_wen_bankx   ), @252
//          .data_din                (dcache_data_din_bank0   ), @253
//          .data_idx                (dcache_data02_idx       ), @254
//          .data_gwen               (dcache_data_gwen        ), @255
//          .data_dout               (dcache_data_dout_bank0  )); @256

assign dcache_data_clk_en_bank1    = !dcache_data_cen_bank1;

// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_bank1"); @260
aq_dcache_data_array  x_aq_dcache_data_array_bank1 (
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .data_cen                 (dcache_data_cen_bank1   ),
  .data_clk_en              (dcache_data_clk_en_bank1),
  .data_din                 (dcache_data_din_bank1   ),
  .data_dout                (dcache_data_dout_bank1  ),
  .data_gwen                (dcache_data_gwen        ),
  .data_idx                 (dcache_data13_idx       ),
  .data_wen                 (dcache_data_wen_bankx   ),
  .forever_cpuclk           (forever_cpuclk          ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect( @261
//          .data_clk_en             (dcache_data_clk_en_bank1), @262
//          .data_cen                (dcache_data_cen_bank1   ), @263
//          .data_wen                (dcache_data_wen_bankx   ), @264
//          .data_din                (dcache_data_din_bank1   ), @265
//          .data_idx                (dcache_data13_idx       ), @266
//          .data_gwen               (dcache_data_gwen        ), @267
//          .data_dout               (dcache_data_dout_bank1  )); @268


assign dcache_data_clk_en_bank2    = !dcache_data_cen_bank2;

// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_bank2"); @273
aq_dcache_data_array  x_aq_dcache_data_array_bank2 (
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .data_cen                 (dcache_data_cen_bank2   ),
  .data_clk_en              (dcache_data_clk_en_bank2),
  .data_din                 (dcache_data_din_bank2   ),
  .data_dout                (dcache_data_dout_bank2  ),
  .data_gwen                (dcache_data_gwen        ),
  .data_idx                 (dcache_data02_idx       ),
  .data_wen                 (dcache_data_wen_bankx   ),
  .forever_cpuclk           (forever_cpuclk          ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect( @274
//          .data_clk_en             (dcache_data_clk_en_bank2 ), @275
//          .data_cen                (dcache_data_cen_bank2    ), @276
//          .data_wen                (dcache_data_wen_bankx    ), @277
//          .data_din                (dcache_data_din_bank2    ), @278
//          .data_idx                (dcache_data02_idx        ), @279
//          .data_gwen               (dcache_data_gwen         ), @280
//          .data_dout               (dcache_data_dout_bank2   )); @281

assign dcache_data_clk_en_bank3    = !dcache_data_cen_bank3;

// &Instance("aq_dcache_data_array", "x_aq_dcache_data_array_bank3"); @285
aq_dcache_data_array  x_aq_dcache_data_array_bank3 (
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),
  .data_cen                 (dcache_data_cen_bank3   ),
  .data_clk_en              (dcache_data_clk_en_bank3),
  .data_din                 (dcache_data_din_bank3   ),
  .data_dout                (dcache_data_dout_bank3  ),
  .data_gwen                (dcache_data_gwen        ),
  .data_idx                 (dcache_data13_idx       ),
  .data_wen                 (dcache_data_wen_bankx   ),
  .forever_cpuclk           (forever_cpuclk          ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect( @286
//          .data_clk_en             (dcache_data_clk_en_bank3 ), @287
//          .data_cen                (dcache_data_cen_bank3    ), @288
//          .data_wen                (dcache_data_wen_bankx    ), @289
//          .data_din                (dcache_data_din_bank3    ), @290
//          .data_idx                (dcache_data13_idx        ), @291
//          .data_gwen               (dcache_data_gwen         ), @292
//          .data_dout               (dcache_data_dout_bank3   )); @293


// &ModuleEnd; @297
endmodule


