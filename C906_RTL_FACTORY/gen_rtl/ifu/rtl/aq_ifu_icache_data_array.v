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
module aq_ifu_icache_data_array(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  forever_cpuclk,
  icache_data0_dout,
  icache_data1_dout,
  icache_data2_dout,
  icache_data3_dout,
  icache_data_din,
  icache_data_idx,
  icache_data_ren,
  icache_data_wen,
  iop_rd_data,
  iop_rd_way,
  pad_yy_icg_scan_en
);

// &Ports; @25
input            cp0_ifu_icg_en;      
input            cp0_yy_clk_en;       
input            forever_cpuclk;      
input   [127:0]  icache_data_din;     
input   [13 :0]  icache_data_idx;     
input   [1  :0]  icache_data_ren;     
input   [1  :0]  icache_data_wen;     
input            iop_rd_data;         
input            iop_rd_way;          
input            pad_yy_icg_scan_en;  
output  [31 :0]  icache_data0_dout;   
output  [31 :0]  icache_data1_dout;   
output  [31 :0]  icache_data2_dout;   
output  [31 :0]  icache_data3_dout;   

// &Regs; @26

// &Wires; @27
wire             cp0_ifu_icg_en;      
wire             cp0_yy_clk_en;       
wire             forever_cpuclk;      
wire             icache_data0_cen_b;  
wire             icache_data0_clk;    
wire    [31 :0]  icache_data0_din;    
wire    [31 :0]  icache_data0_dout;   
wire             icache_data0_icg_en; 
wire    [10 :0]  icache_data0_idx;    
wire             icache_data1_cen_b;  
wire             icache_data1_clk;    
wire    [31 :0]  icache_data1_din;    
wire    [31 :0]  icache_data1_dout;   
wire             icache_data1_icg_en; 
wire    [10 :0]  icache_data1_idx;    
wire             icache_data2_cen_b;  
wire             icache_data2_clk;    
wire    [31 :0]  icache_data2_din;    
wire    [31 :0]  icache_data2_dout;   
wire             icache_data2_icg_en; 
wire    [10 :0]  icache_data2_idx;    
wire             icache_data3_cen_b;  
wire             icache_data3_clk;    
wire    [31 :0]  icache_data3_din;    
wire    [31 :0]  icache_data3_dout;   
wire             icache_data3_icg_en; 
wire    [10 :0]  icache_data3_idx;    
wire    [31 :0]  icache_data_bwen_b;  
wire    [127:0]  icache_data_din;     
wire             icache_data_gwen_b;  
wire    [13 :0]  icache_data_idx;     
wire    [10 :0]  icache_data_idx_high; 
wire    [10 :0]  icache_data_idx_low; 
wire    [1  :0]  icache_data_ren;     
wire    [1  :0]  icache_data_wen;     
wire             icache_data_wr;      
wire             iop_rd_data;         
wire             iop_rd_way;          
wire             pad_yy_icg_scan_en;  


parameter DATA_INDEX = `I_DATA_INDEX_WIDTH;

// &Force("bus", "icache_data_idx", 13, 0); @31

//==========================================================
// Icache Data Array Module
// 1. Instance ICG Cell
// 2. Transmit Port Signals
// 3. Instance Memory Cell 
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign icache_data3_icg_en = !icache_data3_cen_b;
assign icache_data2_icg_en = !icache_data2_cen_b;
assign icache_data1_icg_en = !icache_data1_cen_b;
assign icache_data0_icg_en = !icache_data0_cen_b;

// &Instance("gated_clk_cell", "x_icache_data3_icg_cell"); @48
gated_clk_cell  x_icache_data3_icg_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (icache_data3_clk    ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (icache_data3_icg_en ),
  .module_en            (cp0_ifu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect( @49
//   .clk_in               (forever_cpuclk      ), @50
//   .clk_out              (icache_data3_clk    ), @51
//   .external_en          (1'b0                ), @52
//   .global_en            (cp0_yy_clk_en       ), @53
//   .local_en             (icache_data3_icg_en ), @54
//   .module_en            (cp0_ifu_icg_en      ), @55
//   .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b) @56
// ); @57

// &Instance("gated_clk_cell", "x_icache_data2_icg_cell"); @59
gated_clk_cell  x_icache_data2_icg_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (icache_data2_clk    ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (icache_data2_icg_en ),
  .module_en            (cp0_ifu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect( @60
//   .clk_in               (forever_cpuclk      ), @61
//   .clk_out              (icache_data2_clk   ), @62
//   .external_en          (1'b0                ), @63
//   .global_en            (cp0_yy_clk_en       ), @64
//   .local_en             (icache_data2_icg_en), @65
//   .module_en            (cp0_ifu_icg_en      ), @66
//   .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b) @67
// ); @68

// &Instance("gated_clk_cell", "x_icache_data1_icg_cell"); @70
gated_clk_cell  x_icache_data1_icg_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (icache_data1_clk    ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (icache_data1_icg_en ),
  .module_en            (cp0_ifu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect( @71
//   .clk_in               (forever_cpuclk      ), @72
//   .clk_out              (icache_data1_clk   ), @73
//   .external_en          (1'b0                ), @74
//   .global_en            (cp0_yy_clk_en       ), @75
//   .local_en             (icache_data1_icg_en), @76
//   .module_en            (cp0_ifu_icg_en      ), @77
//   .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b) @78
// ); @79

// &Instance("gated_clk_cell", "x_icache_data0_icg_cell"); @81
gated_clk_cell  x_icache_data0_icg_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (icache_data0_clk    ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (icache_data0_icg_en ),
  .module_en            (cp0_ifu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect( @82
//   .clk_in               (forever_cpuclk      ), @83
//   .clk_out              (icache_data0_clk   ), @84
//   .external_en          (1'b0                ), @85
//   .global_en            (cp0_yy_clk_en       ), @86
//   .local_en             (icache_data0_icg_en), @87
//   .module_en            (cp0_ifu_icg_en      ), @88
//   .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b) @89
// ); @90

assign icache_data_wr                    = |icache_data_wen[1:0];
assign icache_data_gwen_b                = !icache_data_wr;
assign icache_data_bwen_b[31:0]          = ~{32{icache_data_wr}};
assign icache_data_idx_high[DATA_INDEX-1:0] = {icache_data_idx[DATA_INDEX:2],
                                              !icache_data_wen[1] && icache_data_idx[1] && !iop_rd_data
                                            || iop_rd_data && iop_rd_way
                                            || icache_data_wen[1]};
assign icache_data_idx_low[DATA_INDEX-1:0]  = {icache_data_idx[DATA_INDEX:2],
                                              !icache_data_wen[0] && icache_data_idx[1] && !iop_rd_data
                                            || iop_rd_data && !iop_rd_way
                                            || icache_data_wen[0]};

// data 3 2 1 0
assign icache_data3_cen_b  = !(icache_data_ren[1] && icache_data_idx[1:0] == 2'b11
                            || icache_data_ren[0] && icache_data_idx[1:0] == 2'b01
                            || icache_data_wr
                            || iop_rd_data);
assign icache_data3_idx[DATA_INDEX-1:0] = icache_data_idx_high[DATA_INDEX-1:0];
assign icache_data3_din[31:0] = icache_data_wen[1] ? icache_data_din[127:96]
                                                   : icache_data_din[63:32];

assign icache_data2_cen_b  = !(icache_data_ren[1] && icache_data_idx[1:0] == 2'b10
                            || icache_data_ren[0] && icache_data_idx[1:0] == 2'b00
                            || icache_data_wr
                            || iop_rd_data);
assign icache_data2_idx[DATA_INDEX-1:0] = icache_data_idx_high[DATA_INDEX-1:0];
assign icache_data2_din[31:0] = icache_data_wen[1] ? icache_data_din[95:64]
                                                   : icache_data_din[31:0];

assign icache_data1_cen_b  = !(icache_data_ren[1] && icache_data_idx[1:0] == 2'b01
                            || icache_data_ren[0] && icache_data_idx[1:0] == 2'b11
                            || icache_data_wr
                            || iop_rd_data);
assign icache_data1_idx[DATA_INDEX-1:0] = icache_data_idx_low[DATA_INDEX-1:0];
assign icache_data1_din[31:0] = icache_data_wen[0] ? icache_data_din[127:96]
                                                   : icache_data_din[63:32];

assign icache_data0_cen_b  = !(icache_data_ren[1] && icache_data_idx[1:0] == 2'b00
                            || icache_data_ren[0] && icache_data_idx[1:0] == 2'b10
                            || icache_data_wr
                            || iop_rd_data);
assign icache_data0_idx[DATA_INDEX-1:0] = icache_data_idx_low[DATA_INDEX-1:0];
assign icache_data0_din[31:0] = icache_data_wen[0] ? icache_data_din[95:64]
                                                   : icache_data_din[31:0];

// &Instance("aq_spsram_512x32", "x_aq_spsram_512x32_3"); @138
// &Instance("aq_spsram_1024x32", "x_aq_spsram_1024x32_3"); @141
// &Instance("aq_spsram_2048x32", "x_aq_spsram_2048x32_3"); @144
aq_spsram_2048x32  x_aq_spsram_2048x32_3 (
  .A                  (icache_data3_idx  ),
  .CEN                (icache_data3_cen_b),
  .CLK                (icache_data3_clk  ),
  .D                  (icache_data3_din  ),
  .GWEN               (icache_data_gwen_b),
  .Q                  (icache_data3_dout ),
  .WEN                (icache_data_bwen_b)
);

// &Instance("aq_spsram_4096x32", "x_aq_spsram_4096x32_3"); @147
// &Connect( @149
//   .A    (icache_data3_idx  ), @150
//   .CEN  (icache_data3_cen_b), @151
//   .CLK  (icache_data3_clk  ), @152
//   .D    (icache_data3_din  ), @153
//   .GWEN (icache_data_gwen_b), @154
//   .Q    (icache_data3_dout ), @155
//   .WEN  (icache_data_bwen_b) @156
// ); @157

// &Instance("aq_spsram_512x32", "x_aq_spsram_512x32_2"); @160
// &Instance("aq_spsram_1024x32", "x_aq_spsram_1024x32_2"); @163
// &Instance("aq_spsram_2048x32", "x_aq_spsram_2048x32_2"); @166
aq_spsram_2048x32  x_aq_spsram_2048x32_2 (
  .A                  (icache_data2_idx  ),
  .CEN                (icache_data2_cen_b),
  .CLK                (icache_data2_clk  ),
  .D                  (icache_data2_din  ),
  .GWEN               (icache_data_gwen_b),
  .Q                  (icache_data2_dout ),
  .WEN                (icache_data_bwen_b)
);

// &Instance("aq_spsram_4096x32", "x_aq_spsram_4096x32_2"); @169
// &Connect( @171
//   .A    (icache_data2_idx  ), @172
//   .CEN  (icache_data2_cen_b), @173
//   .CLK  (icache_data2_clk  ), @174
//   .D    (icache_data2_din  ), @175
//   .GWEN (icache_data_gwen_b), @176
//   .Q    (icache_data2_dout ), @177
//   .WEN  (icache_data_bwen_b) @178
// ); @179

// &Instance("aq_spsram_512x32", "x_aq_spsram_512x32_1"); @182
// &Instance("aq_spsram_1024x32", "x_aq_spsram_1024x32_1"); @185
// &Instance("aq_spsram_2048x32", "x_aq_spsram_2048x32_1"); @188
aq_spsram_2048x32  x_aq_spsram_2048x32_1 (
  .A                  (icache_data1_idx  ),
  .CEN                (icache_data1_cen_b),
  .CLK                (icache_data1_clk  ),
  .D                  (icache_data1_din  ),
  .GWEN               (icache_data_gwen_b),
  .Q                  (icache_data1_dout ),
  .WEN                (icache_data_bwen_b)
);

// &Instance("aq_spsram_4096x32", "x_aq_spsram_4096x32_1"); @191
// &Connect( @193
//   .A    (icache_data1_idx  ), @194
//   .CEN  (icache_data1_cen_b), @195
//   .CLK  (icache_data1_clk  ), @196
//   .D    (icache_data1_din  ), @197
//   .GWEN (icache_data_gwen_b), @198
//   .Q    (icache_data1_dout ), @199
//   .WEN  (icache_data_bwen_b) @200
// ); @201

// &Instance("aq_spsram_512x32", "x_aq_spsram_512x32_0"); @204
// &Instance("aq_spsram_1024x32", "x_aq_spsram_1024x32_0"); @207
// &Instance("aq_spsram_2048x32", "x_aq_spsram_2048x32_0"); @210
aq_spsram_2048x32  x_aq_spsram_2048x32_0 (
  .A                  (icache_data0_idx  ),
  .CEN                (icache_data0_cen_b),
  .CLK                (icache_data0_clk  ),
  .D                  (icache_data0_din  ),
  .GWEN               (icache_data_gwen_b),
  .Q                  (icache_data0_dout ),
  .WEN                (icache_data_bwen_b)
);

// &Instance("aq_spsram_4096x32", "x_aq_spsram_4096x32_0"); @213
// &Connect( @215
//   .A    (icache_data0_idx  ), @216
//   .CEN  (icache_data0_cen_b), @217
//   .CLK  (icache_data0_clk  ), @218
//   .D    (icache_data0_din  ), @219
//   .GWEN (icache_data_gwen_b), @220
//   .Q    (icache_data0_dout ), @221
//   .WEN  (icache_data_bwen_b) @222
// ); @223

endmodule
