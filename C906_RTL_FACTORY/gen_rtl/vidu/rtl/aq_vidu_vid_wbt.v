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

// &Depend("aq_idu_cfig.h"); @23
// &ModuleBeg; @24
module aq_vidu_vid_wbt(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_wbt_bankx_dis_inst_gateclk_vld,
  ctrl_wbt_bankx_dis_inst_vld,
  dp_wbt_bankx_dstv_reg,
  dp_wbt_bankx_dstv_type,
  dp_wbt_bankx_dstv_vld,
  dp_wbt_bankx_srcv0_reg,
  dp_wbt_bankx_srcv1_reg,
  dp_wbt_bankx_srcv2_reg,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  rtu_vidu_flush_wbt,
  rtu_yy_xx_async_flush,
  vpu_vidu_wbt_bankx_wb0_reg,
  vpu_vidu_wbt_bankx_wb0_vld,
  vpu_vidu_wbt_bankx_wb1_reg,
  vpu_vidu_wbt_bankx_wb1_vld,
  wbt_ctrl_bankx_dstv_info,
  wbt_ctrl_bankx_srcv0_info,
  wbt_ctrl_bankx_srcv1_info,
  wbt_ctrl_bankx_srcv2_info,
  wbt_ctrl_bankx_srcvm_info,
  wbt_top_bankx_gpr_no_wb
);

// &Ports; @25
input           cp0_idu_icg_en;                     
input           cp0_yy_clk_en;                      
input           cpurst_b;                           
input           ctrl_wbt_bankx_dis_inst_gateclk_vld; 
input           ctrl_wbt_bankx_dis_inst_vld;        
input   [4 :0]  dp_wbt_bankx_dstv_reg;              
input           dp_wbt_bankx_dstv_type;             
input           dp_wbt_bankx_dstv_vld;              
input   [4 :0]  dp_wbt_bankx_srcv0_reg;             
input   [4 :0]  dp_wbt_bankx_srcv1_reg;             
input   [4 :0]  dp_wbt_bankx_srcv2_reg;             
input           forever_cpuclk;                     
input           pad_yy_icg_scan_en;                 
input           rtu_vidu_flush_wbt;                 
input           rtu_yy_xx_async_flush;              
input   [4 :0]  vpu_vidu_wbt_bankx_wb0_reg;         
input           vpu_vidu_wbt_bankx_wb0_vld;         
input   [4 :0]  vpu_vidu_wbt_bankx_wb1_reg;         
input           vpu_vidu_wbt_bankx_wb1_vld;         
output  [2 :0]  wbt_ctrl_bankx_dstv_info;           
output  [2 :0]  wbt_ctrl_bankx_srcv0_info;          
output  [2 :0]  wbt_ctrl_bankx_srcv1_info;          
output  [2 :0]  wbt_ctrl_bankx_srcv2_info;          
output  [2 :0]  wbt_ctrl_bankx_srcvm_info;          
output          wbt_top_bankx_gpr_no_wb;            

// &Regs; @26
reg     [2 :0]  wbt_ctrl_bankx_dstv_info;           
reg     [2 :0]  wbt_ctrl_bankx_srcv0_info;          
reg     [2 :0]  wbt_ctrl_bankx_srcv1_info;          
reg     [2 :0]  wbt_ctrl_bankx_srcv2_info;          

// &Wires; @27
wire            cp0_idu_icg_en;                     
wire            cp0_yy_clk_en;                      
wire            cpurst_b;                           
wire            create_clk;                         
wire            create_clk_en;                      
wire    [31:0]  create_en;                          
wire            ctrl_wbt_bankx_dis_inst_gateclk_vld; 
wire            ctrl_wbt_bankx_dis_inst_vld;        
wire    [4 :0]  dp_wbt_bankx_dstv_reg;              
wire    [31:0]  dp_wbt_bankx_dstv_reg_expand;       
wire            dp_wbt_bankx_dstv_type;             
wire            dp_wbt_bankx_dstv_vld;              
wire    [4 :0]  dp_wbt_bankx_srcv0_reg;             
wire    [4 :0]  dp_wbt_bankx_srcv1_reg;             
wire    [4 :0]  dp_wbt_bankx_srcv2_reg;             
wire            forever_cpuclk;                     
wire            pad_yy_icg_scan_en;                 
wire    [2 :0]  read_data_0;                        
wire    [2 :0]  read_data_1;                        
wire    [2 :0]  read_data_10;                       
wire    [2 :0]  read_data_11;                       
wire    [2 :0]  read_data_12;                       
wire    [2 :0]  read_data_13;                       
wire    [2 :0]  read_data_14;                       
wire    [2 :0]  read_data_15;                       
wire    [2 :0]  read_data_16;                       
wire    [2 :0]  read_data_17;                       
wire    [2 :0]  read_data_18;                       
wire    [2 :0]  read_data_19;                       
wire    [2 :0]  read_data_2;                        
wire    [2 :0]  read_data_20;                       
wire    [2 :0]  read_data_21;                       
wire    [2 :0]  read_data_22;                       
wire    [2 :0]  read_data_23;                       
wire    [2 :0]  read_data_24;                       
wire    [2 :0]  read_data_25;                       
wire    [2 :0]  read_data_26;                       
wire    [2 :0]  read_data_27;                       
wire    [2 :0]  read_data_28;                       
wire    [2 :0]  read_data_29;                       
wire    [2 :0]  read_data_3;                        
wire    [2 :0]  read_data_30;                       
wire    [2 :0]  read_data_31;                       
wire    [2 :0]  read_data_4;                        
wire    [2 :0]  read_data_5;                        
wire    [2 :0]  read_data_6;                        
wire    [2 :0]  read_data_7;                        
wire    [2 :0]  read_data_8;                        
wire    [2 :0]  read_data_9;                        
wire            rtu_vidu_flush_wbt;                 
wire            rtu_yy_xx_async_flush;              
wire    [4 :0]  vpu_vidu_wbt_bankx_wb0_reg;         
wire    [31:0]  vpu_vidu_wbt_bankx_wb0_reg_expand;  
wire            vpu_vidu_wbt_bankx_wb0_vld;         
wire    [4 :0]  vpu_vidu_wbt_bankx_wb1_reg;         
wire    [31:0]  vpu_vidu_wbt_bankx_wb1_reg_expand;  
wire            vpu_vidu_wbt_bankx_wb1_vld;         
wire            wb_clk;                             
wire            wb_clk_en;                          
wire    [31:0]  wb_debug;                           
wire    [31:0]  wb_en;                              
wire    [31:0]  wbt_create_dstv_reg;                
wire    [2 :0]  wbt_ctrl_bankx_srcvm_info;          
wire            wbt_top_bankx_gpr_no_wb;            


//==========================================================
//                 Instance of Gated Cell
//==========================================================
assign create_clk_en = ctrl_wbt_bankx_dis_inst_gateclk_vld
                       || rtu_vidu_flush_wbt
                       || rtu_yy_xx_async_flush;
// &Instance("gated_clk_cell", "x_create_clk_gated_clk_cell"); @35
gated_clk_cell  x_create_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (create_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (create_clk_en     ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @36
//          .external_en (1'b0), @37
//          .global_en   (cp0_yy_clk_en), @38
//          .module_en   (cp0_idu_icg_en), @39
//          .local_en    (create_clk_en), @40
//          .clk_out     (create_clk)); @41

assign wb_clk_en = ctrl_wbt_bankx_dis_inst_gateclk_vld
                   || vpu_vidu_wbt_bankx_wb0_vld
                   || vpu_vidu_wbt_bankx_wb1_vld
                   || rtu_vidu_flush_wbt
                   || rtu_yy_xx_async_flush;
// &Instance("gated_clk_cell", "x_wb_clk_gated_clk_cell"); @48
gated_clk_cell  x_wb_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (wb_clk            ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (wb_clk_en         ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @49
//          .external_en (1'b0), @50
//          .global_en   (cp0_yy_clk_en), @51
//          .module_en   (cp0_idu_icg_en), @52
//          .local_en    (wb_clk_en), @53
//          .clk_out     (wb_clk)); @54

//==========================================================
//                  Instance Entries
//==========================================================
//----------------------------------------------------------
//                      Entry 0~31
//----------------------------------------------------------
// &ConnRule(s/_x$/[0]/); @62
// &ConnRule(s/_y$/_0/); @63
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_0"); @64
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_0 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[0]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_0           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[0]           ),
  .wb_en_x                (wb_en[0]              )
);

// &ConnRule(s/_x$/[1]/); @65
// &ConnRule(s/_y$/_1/); @66
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_1"); @67
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_1 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[1]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_1           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[1]           ),
  .wb_en_x                (wb_en[1]              )
);

// &ConnRule(s/_x$/[2]/); @68
// &ConnRule(s/_y$/_2/); @69
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_2"); @70
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_2 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[2]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_2           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[2]           ),
  .wb_en_x                (wb_en[2]              )
);

// &ConnRule(s/_x$/[3]/); @71
// &ConnRule(s/_y$/_3/); @72
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_3"); @73
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_3 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[3]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_3           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[3]           ),
  .wb_en_x                (wb_en[3]              )
);

// &ConnRule(s/_x$/[4]/); @74
// &ConnRule(s/_y$/_4/); @75
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_4"); @76
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_4 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[4]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_4           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[4]           ),
  .wb_en_x                (wb_en[4]              )
);

// &ConnRule(s/_x$/[5]/); @77
// &ConnRule(s/_y$/_5/); @78
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_5"); @79
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_5 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[5]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_5           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[5]           ),
  .wb_en_x                (wb_en[5]              )
);

// &ConnRule(s/_x$/[6]/); @80
// &ConnRule(s/_y$/_6/); @81
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_6"); @82
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_6 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[6]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_6           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[6]           ),
  .wb_en_x                (wb_en[6]              )
);

// &ConnRule(s/_x$/[7]/); @83
// &ConnRule(s/_y$/_7/); @84
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_7"); @85
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_7 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[7]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_7           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[7]           ),
  .wb_en_x                (wb_en[7]              )
);

// &ConnRule(s/_x$/[8]/); @86
// &ConnRule(s/_y$/_8/); @87
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_8"); @88
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_8 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[8]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_8           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[8]           ),
  .wb_en_x                (wb_en[8]              )
);

// &ConnRule(s/_x$/[9]/); @89
// &ConnRule(s/_y$/_9/); @90
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_9"); @91
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_9 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[9]          ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_9           ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[9]           ),
  .wb_en_x                (wb_en[9]              )
);

// &ConnRule(s/_x$/[10]/); @92
// &ConnRule(s/_y$/_10/); @93
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_10"); @94
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_10 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[10]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_10          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[10]          ),
  .wb_en_x                (wb_en[10]             )
);

// &ConnRule(s/_x$/[11]/); @95
// &ConnRule(s/_y$/_11/); @96
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_11"); @97
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_11 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[11]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_11          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[11]          ),
  .wb_en_x                (wb_en[11]             )
);

// &ConnRule(s/_x$/[12]/); @98
// &ConnRule(s/_y$/_12/); @99
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_12"); @100
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_12 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[12]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_12          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[12]          ),
  .wb_en_x                (wb_en[12]             )
);

// &ConnRule(s/_x$/[13]/); @101
// &ConnRule(s/_y$/_13/); @102
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_13"); @103
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_13 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[13]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_13          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[13]          ),
  .wb_en_x                (wb_en[13]             )
);

// &ConnRule(s/_x$/[14]/); @104
// &ConnRule(s/_y$/_14/); @105
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_14"); @106
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_14 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[14]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_14          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[14]          ),
  .wb_en_x                (wb_en[14]             )
);

// &ConnRule(s/_x$/[15]/); @107
// &ConnRule(s/_y$/_15/); @108
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_15"); @109
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_15 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[15]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_15          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[15]          ),
  .wb_en_x                (wb_en[15]             )
);

// &ConnRule(s/_x$/[16]/); @110
// &ConnRule(s/_y$/_16/); @111
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_16"); @112
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_16 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[16]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_16          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[16]          ),
  .wb_en_x                (wb_en[16]             )
);

// &ConnRule(s/_x$/[17]/); @113
// &ConnRule(s/_y$/_17/); @114
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_17"); @115
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_17 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[17]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_17          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[17]          ),
  .wb_en_x                (wb_en[17]             )
);

// &ConnRule(s/_x$/[18]/); @116
// &ConnRule(s/_y$/_18/); @117
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_18"); @118
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_18 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[18]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_18          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[18]          ),
  .wb_en_x                (wb_en[18]             )
);

// &ConnRule(s/_x$/[19]/); @119
// &ConnRule(s/_y$/_19/); @120
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_19"); @121
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_19 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[19]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_19          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[19]          ),
  .wb_en_x                (wb_en[19]             )
);

// &ConnRule(s/_x$/[20]/); @122
// &ConnRule(s/_y$/_20/); @123
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_20"); @124
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_20 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[20]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_20          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[20]          ),
  .wb_en_x                (wb_en[20]             )
);

// &ConnRule(s/_x$/[21]/); @125
// &ConnRule(s/_y$/_21/); @126
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_21"); @127
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_21 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[21]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_21          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[21]          ),
  .wb_en_x                (wb_en[21]             )
);

// &ConnRule(s/_x$/[22]/); @128
// &ConnRule(s/_y$/_22/); @129
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_22"); @130
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_22 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[22]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_22          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[22]          ),
  .wb_en_x                (wb_en[22]             )
);

// &ConnRule(s/_x$/[23]/); @131
// &ConnRule(s/_y$/_23/); @132
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_23"); @133
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_23 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[23]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_23          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[23]          ),
  .wb_en_x                (wb_en[23]             )
);

// &ConnRule(s/_x$/[24]/); @134
// &ConnRule(s/_y$/_24/); @135
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_24"); @136
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_24 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[24]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_24          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[24]          ),
  .wb_en_x                (wb_en[24]             )
);

// &ConnRule(s/_x$/[25]/); @137
// &ConnRule(s/_y$/_25/); @138
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_25"); @139
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_25 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[25]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_25          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[25]          ),
  .wb_en_x                (wb_en[25]             )
);

// &ConnRule(s/_x$/[26]/); @140
// &ConnRule(s/_y$/_26/); @141
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_26"); @142
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_26 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[26]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_26          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[26]          ),
  .wb_en_x                (wb_en[26]             )
);

// &ConnRule(s/_x$/[27]/); @143
// &ConnRule(s/_y$/_27/); @144
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_27"); @145
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_27 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[27]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_27          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[27]          ),
  .wb_en_x                (wb_en[27]             )
);

// &ConnRule(s/_x$/[28]/); @146
// &ConnRule(s/_y$/_28/); @147
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_28"); @148
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_28 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[28]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_28          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[28]          ),
  .wb_en_x                (wb_en[28]             )
);

// &ConnRule(s/_x$/[29]/); @149
// &ConnRule(s/_y$/_29/); @150
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_29"); @151
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_29 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[29]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_29          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[29]          ),
  .wb_en_x                (wb_en[29]             )
);

// &ConnRule(s/_x$/[30]/); @152
// &ConnRule(s/_y$/_30/); @153
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_30"); @154
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_30 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[30]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_30          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[30]          ),
  .wb_en_x                (wb_en[30]             )
);

// &ConnRule(s/_x$/[31]/); @155
// &ConnRule(s/_y$/_31/); @156
// &Instance("aq_vidu_vid_wbt_entry","x_aq_vidu_vid_wbt_entry_reg_31"); @157
aq_vidu_vid_wbt_entry  x_aq_vidu_vid_wbt_entry_reg_31 (
  .cpurst_b               (cpurst_b              ),
  .create_clk             (create_clk            ),
  .create_en_x            (create_en[31]         ),
  .dp_wbt_bankx_dstv_type (dp_wbt_bankx_dstv_type),
  .read_data_y            (read_data_31          ),
  .rtu_vidu_flush_wbt     (rtu_vidu_flush_wbt    ),
  .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush ),
  .wb_clk                 (wb_clk                ),
  .wb_debug_x             (wb_debug[31]          ),
  .wb_en_x                (wb_en[31]             )
);


//==========================================================
//                       Create Port
//==========================================================
// &ConnRule(s/^x_num/dp_wbt_bankx_dstv_reg/); @162
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_dp_wbt_bankx_dstv_reg"); @163
aq_idu_expand_32  x_aq_idu_expand_32_dp_wbt_bankx_dstv_reg (
  .x_num                        (dp_wbt_bankx_dstv_reg       ),
  .x_num_expand                 (dp_wbt_bankx_dstv_reg_expand)
);


assign wbt_create_dstv_reg[31:0] = {32{dp_wbt_bankx_dstv_vld && ctrl_wbt_bankx_dis_inst_vld}}
                                  & dp_wbt_bankx_dstv_reg_expand[31:0];
assign create_en[31:0]          = wbt_create_dstv_reg[31:0];

//==========================================================
//                       Read Port
//==========================================================
//----------------------------------------------------------
//                     Source 0 Read
//----------------------------------------------------------
// &CombBeg; @175
always @( read_data_22[2:0]
       or read_data_8[2:0]
       or read_data_12[2:0]
       or dp_wbt_bankx_srcv0_reg[4:0]
       or read_data_14[2:0]
       or read_data_2[2:0]
       or read_data_20[2:0]
       or read_data_17[2:0]
       or read_data_15[2:0]
       or read_data_28[2:0]
       or read_data_9[2:0]
       or read_data_31[2:0]
       or read_data_30[2:0]
       or read_data_29[2:0]
       or read_data_27[2:0]
       or read_data_19[2:0]
       or read_data_25[2:0]
       or read_data_21[2:0]
       or read_data_26[2:0]
       or read_data_24[2:0]
       or read_data_7[2:0]
       or read_data_11[2:0]
       or read_data_18[2:0]
       or read_data_1[2:0]
       or read_data_0[2:0]
       or read_data_16[2:0]
       or read_data_5[2:0]
       or read_data_23[2:0]
       or read_data_6[2:0]
       or read_data_4[2:0]
       or read_data_10[2:0]
       or read_data_13[2:0]
       or read_data_3[2:0])
begin
  case (dp_wbt_bankx_srcv0_reg[4:0])
    5'd0   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_0[`WB_VEC_WIDTH-1:0];
    5'd1   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_1[`WB_VEC_WIDTH-1:0];
    5'd2   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_2[`WB_VEC_WIDTH-1:0];
    5'd3   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_3[`WB_VEC_WIDTH-1:0];
    5'd4   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_4[`WB_VEC_WIDTH-1:0];
    5'd5   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_5[`WB_VEC_WIDTH-1:0];
    5'd6   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_6[`WB_VEC_WIDTH-1:0];
    5'd7   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_7[`WB_VEC_WIDTH-1:0];
    5'd8   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_8[`WB_VEC_WIDTH-1:0];
    5'd9   : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_9[`WB_VEC_WIDTH-1:0];
    5'd10  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_10[`WB_VEC_WIDTH-1:0];
    5'd11  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_11[`WB_VEC_WIDTH-1:0];
    5'd12  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_12[`WB_VEC_WIDTH-1:0];
    5'd13  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_13[`WB_VEC_WIDTH-1:0];
    5'd14  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_14[`WB_VEC_WIDTH-1:0];
    5'd15  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_15[`WB_VEC_WIDTH-1:0];
    5'd16  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_16[`WB_VEC_WIDTH-1:0];
    5'd17  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_17[`WB_VEC_WIDTH-1:0];
    5'd18  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_18[`WB_VEC_WIDTH-1:0];
    5'd19  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_19[`WB_VEC_WIDTH-1:0];
    5'd20  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_20[`WB_VEC_WIDTH-1:0];
    5'd21  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_21[`WB_VEC_WIDTH-1:0];
    5'd22  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_22[`WB_VEC_WIDTH-1:0];
    5'd23  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_23[`WB_VEC_WIDTH-1:0];
    5'd24  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_24[`WB_VEC_WIDTH-1:0];
    5'd25  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_25[`WB_VEC_WIDTH-1:0];
    5'd26  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_26[`WB_VEC_WIDTH-1:0];
    5'd27  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_27[`WB_VEC_WIDTH-1:0];
    5'd28  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_28[`WB_VEC_WIDTH-1:0];
    5'd29  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_29[`WB_VEC_WIDTH-1:0];
    5'd30  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_30[`WB_VEC_WIDTH-1:0];
    5'd31  : wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = read_data_31[`WB_VEC_WIDTH-1:0];
    default: wbt_ctrl_bankx_srcv0_info[`WB_VEC_WIDTH-1:0] = {`WB_VEC_WIDTH{1'bx}};
  endcase
// &CombEnd; @211
end

//----------------------------------------------------------
//                     Source 1 Read
//----------------------------------------------------------
// &CombBeg; @216
always @( read_data_22[2:0]
       or read_data_8[2:0]
       or read_data_12[2:0]
       or read_data_14[2:0]
       or read_data_2[2:0]
       or read_data_20[2:0]
       or read_data_17[2:0]
       or read_data_15[2:0]
       or read_data_28[2:0]
       or read_data_31[2:0]
       or read_data_9[2:0]
       or read_data_30[2:0]
       or read_data_29[2:0]
       or read_data_27[2:0]
       or read_data_19[2:0]
       or read_data_25[2:0]
       or read_data_21[2:0]
       or read_data_24[2:0]
       or read_data_26[2:0]
       or dp_wbt_bankx_srcv1_reg[4:0]
       or read_data_7[2:0]
       or read_data_11[2:0]
       or read_data_18[2:0]
       or read_data_1[2:0]
       or read_data_0[2:0]
       or read_data_16[2:0]
       or read_data_5[2:0]
       or read_data_23[2:0]
       or read_data_10[2:0]
       or read_data_4[2:0]
       or read_data_6[2:0]
       or read_data_13[2:0]
       or read_data_3[2:0])
begin
  case (dp_wbt_bankx_srcv1_reg[4:0])
    5'd0   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_0[`WB_VEC_WIDTH-1:0];
    5'd1   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_1[`WB_VEC_WIDTH-1:0];
    5'd2   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_2[`WB_VEC_WIDTH-1:0];
    5'd3   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_3[`WB_VEC_WIDTH-1:0];
    5'd4   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_4[`WB_VEC_WIDTH-1:0];
    5'd5   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_5[`WB_VEC_WIDTH-1:0];
    5'd6   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_6[`WB_VEC_WIDTH-1:0];
    5'd7   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_7[`WB_VEC_WIDTH-1:0];
    5'd8   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_8[`WB_VEC_WIDTH-1:0];
    5'd9   : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_9[`WB_VEC_WIDTH-1:0];
    5'd10  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_10[`WB_VEC_WIDTH-1:0];
    5'd11  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_11[`WB_VEC_WIDTH-1:0];
    5'd12  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_12[`WB_VEC_WIDTH-1:0];
    5'd13  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_13[`WB_VEC_WIDTH-1:0];
    5'd14  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_14[`WB_VEC_WIDTH-1:0];
    5'd15  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_15[`WB_VEC_WIDTH-1:0];
    5'd16  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_16[`WB_VEC_WIDTH-1:0];
    5'd17  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_17[`WB_VEC_WIDTH-1:0];
    5'd18  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_18[`WB_VEC_WIDTH-1:0];
    5'd19  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_19[`WB_VEC_WIDTH-1:0];
    5'd20  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_20[`WB_VEC_WIDTH-1:0];
    5'd21  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_21[`WB_VEC_WIDTH-1:0];
    5'd22  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_22[`WB_VEC_WIDTH-1:0];
    5'd23  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_23[`WB_VEC_WIDTH-1:0];
    5'd24  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_24[`WB_VEC_WIDTH-1:0];
    5'd25  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_25[`WB_VEC_WIDTH-1:0];
    5'd26  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_26[`WB_VEC_WIDTH-1:0];
    5'd27  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_27[`WB_VEC_WIDTH-1:0];
    5'd28  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_28[`WB_VEC_WIDTH-1:0];
    5'd29  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_29[`WB_VEC_WIDTH-1:0];
    5'd30  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_30[`WB_VEC_WIDTH-1:0];
    5'd31  : wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = read_data_31[`WB_VEC_WIDTH-1:0];
    default: wbt_ctrl_bankx_srcv1_info[`WB_VEC_WIDTH-1:0] = {`WB_VEC_WIDTH{1'bx}};
  endcase
// &CombEnd; @252
end

//----------------------------------------------------------
//                     Source 2 Read
//----------------------------------------------------------
// &CombBeg; @257
always @( read_data_22[2:0]
       or read_data_8[2:0]
       or read_data_12[2:0]
       or read_data_14[2:0]
       or read_data_2[2:0]
       or read_data_20[2:0]
       or read_data_17[2:0]
       or read_data_15[2:0]
       or read_data_28[2:0]
       or read_data_31[2:0]
       or read_data_9[2:0]
       or read_data_30[2:0]
       or read_data_29[2:0]
       or read_data_27[2:0]
       or read_data_19[2:0]
       or read_data_25[2:0]
       or read_data_21[2:0]
       or read_data_24[2:0]
       or read_data_26[2:0]
       or read_data_7[2:0]
       or read_data_11[2:0]
       or read_data_18[2:0]
       or read_data_1[2:0]
       or read_data_0[2:0]
       or read_data_16[2:0]
       or dp_wbt_bankx_srcv2_reg[4:0]
       or read_data_5[2:0]
       or read_data_23[2:0]
       or read_data_10[2:0]
       or read_data_4[2:0]
       or read_data_6[2:0]
       or read_data_13[2:0]
       or read_data_3[2:0])
begin
  case (dp_wbt_bankx_srcv2_reg[4:0])
    5'd0   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_0[`WB_VEC_WIDTH-1:0];
    5'd1   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_1[`WB_VEC_WIDTH-1:0];
    5'd2   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_2[`WB_VEC_WIDTH-1:0];
    5'd3   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_3[`WB_VEC_WIDTH-1:0];
    5'd4   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_4[`WB_VEC_WIDTH-1:0];
    5'd5   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_5[`WB_VEC_WIDTH-1:0];
    5'd6   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_6[`WB_VEC_WIDTH-1:0];
    5'd7   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_7[`WB_VEC_WIDTH-1:0];
    5'd8   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_8[`WB_VEC_WIDTH-1:0];
    5'd9   : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_9[`WB_VEC_WIDTH-1:0];
    5'd10  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_10[`WB_VEC_WIDTH-1:0];
    5'd11  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_11[`WB_VEC_WIDTH-1:0];
    5'd12  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_12[`WB_VEC_WIDTH-1:0];
    5'd13  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_13[`WB_VEC_WIDTH-1:0];
    5'd14  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_14[`WB_VEC_WIDTH-1:0];
    5'd15  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_15[`WB_VEC_WIDTH-1:0];
    5'd16  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_16[`WB_VEC_WIDTH-1:0];
    5'd17  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_17[`WB_VEC_WIDTH-1:0];
    5'd18  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_18[`WB_VEC_WIDTH-1:0];
    5'd19  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_19[`WB_VEC_WIDTH-1:0];
    5'd20  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_20[`WB_VEC_WIDTH-1:0];
    5'd21  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_21[`WB_VEC_WIDTH-1:0];
    5'd22  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_22[`WB_VEC_WIDTH-1:0];
    5'd23  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_23[`WB_VEC_WIDTH-1:0];
    5'd24  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_24[`WB_VEC_WIDTH-1:0];
    5'd25  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_25[`WB_VEC_WIDTH-1:0];
    5'd26  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_26[`WB_VEC_WIDTH-1:0];
    5'd27  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_27[`WB_VEC_WIDTH-1:0];
    5'd28  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_28[`WB_VEC_WIDTH-1:0];
    5'd29  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_29[`WB_VEC_WIDTH-1:0];
    5'd30  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_30[`WB_VEC_WIDTH-1:0];
    5'd31  : wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = read_data_31[`WB_VEC_WIDTH-1:0];
    default: wbt_ctrl_bankx_srcv2_info[`WB_VEC_WIDTH-1:0] = {`WB_VEC_WIDTH{1'bx}};
  endcase
// &CombEnd; @293
end

//----------------------------------------------------------
//                     Source M Read
//----------------------------------------------------------
assign wbt_ctrl_bankx_srcvm_info[`WB_VEC_WIDTH-1:0] = read_data_0[`WB_VEC_WIDTH-1:0];

//----------------------------------------------------------
//                      Dest Read
//----------------------------------------------------------
// &CombBeg; @303
always @( read_data_22[2:0]
       or read_data_8[2:0]
       or read_data_12[2:0]
       or read_data_14[2:0]
       or read_data_2[2:0]
       or read_data_20[2:0]
       or read_data_17[2:0]
       or read_data_15[2:0]
       or read_data_28[2:0]
       or read_data_31[2:0]
       or read_data_9[2:0]
       or read_data_30[2:0]
       or read_data_29[2:0]
       or read_data_27[2:0]
       or read_data_19[2:0]
       or read_data_25[2:0]
       or read_data_21[2:0]
       or read_data_24[2:0]
       or read_data_26[2:0]
       or read_data_7[2:0]
       or read_data_11[2:0]
       or read_data_18[2:0]
       or read_data_1[2:0]
       or read_data_0[2:0]
       or dp_wbt_bankx_dstv_reg[4:0]
       or read_data_16[2:0]
       or read_data_5[2:0]
       or read_data_23[2:0]
       or read_data_10[2:0]
       or read_data_4[2:0]
       or read_data_6[2:0]
       or read_data_13[2:0]
       or read_data_3[2:0])
begin
  case (dp_wbt_bankx_dstv_reg[4:0])
    5'd0   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_0[`WB_VEC_WIDTH-1:0];
    5'd1   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_1[`WB_VEC_WIDTH-1:0];
    5'd2   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_2[`WB_VEC_WIDTH-1:0];
    5'd3   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_3[`WB_VEC_WIDTH-1:0];
    5'd4   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_4[`WB_VEC_WIDTH-1:0];
    5'd5   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_5[`WB_VEC_WIDTH-1:0];
    5'd6   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_6[`WB_VEC_WIDTH-1:0];
    5'd7   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_7[`WB_VEC_WIDTH-1:0];
    5'd8   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_8[`WB_VEC_WIDTH-1:0];
    5'd9   : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_9[`WB_VEC_WIDTH-1:0];
    5'd10  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_10[`WB_VEC_WIDTH-1:0];
    5'd11  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_11[`WB_VEC_WIDTH-1:0];
    5'd12  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_12[`WB_VEC_WIDTH-1:0];
    5'd13  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_13[`WB_VEC_WIDTH-1:0];
    5'd14  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_14[`WB_VEC_WIDTH-1:0];
    5'd15  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_15[`WB_VEC_WIDTH-1:0];
    5'd16  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_16[`WB_VEC_WIDTH-1:0];
    5'd17  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_17[`WB_VEC_WIDTH-1:0];
    5'd18  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_18[`WB_VEC_WIDTH-1:0];
    5'd19  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_19[`WB_VEC_WIDTH-1:0];
    5'd20  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_20[`WB_VEC_WIDTH-1:0];
    5'd21  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_21[`WB_VEC_WIDTH-1:0];
    5'd22  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_22[`WB_VEC_WIDTH-1:0];
    5'd23  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_23[`WB_VEC_WIDTH-1:0];
    5'd24  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_24[`WB_VEC_WIDTH-1:0];
    5'd25  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_25[`WB_VEC_WIDTH-1:0];
    5'd26  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_26[`WB_VEC_WIDTH-1:0];
    5'd27  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_27[`WB_VEC_WIDTH-1:0];
    5'd28  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_28[`WB_VEC_WIDTH-1:0];
    5'd29  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_29[`WB_VEC_WIDTH-1:0];
    5'd30  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_30[`WB_VEC_WIDTH-1:0];
    5'd31  : wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = read_data_31[`WB_VEC_WIDTH-1:0];
    default: wbt_ctrl_bankx_dstv_info[`WB_VEC_WIDTH-1:0] = {`WB_VEC_WIDTH{1'bx}};
  endcase
// &CombEnd; @339
end

//==========================================================
//                    Write Back Port
//==========================================================
// &ConnRule(s/^x_num/vpu_vidu_wbt_bankx_wb0_reg/); @344
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_vpu_vidu_wbt_bankx_wb0_reg"); @345
aq_idu_expand_32  x_aq_idu_expand_32_vpu_vidu_wbt_bankx_wb0_reg (
  .x_num                             (vpu_vidu_wbt_bankx_wb0_reg       ),
  .x_num_expand                      (vpu_vidu_wbt_bankx_wb0_reg_expand)
);

// &ConnRule(s/^x_num/vpu_vidu_wbt_bankx_wb1_reg/); @346
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_vpu_vidu_wbt_bankx_wb1_reg"); @347
aq_idu_expand_32  x_aq_idu_expand_32_vpu_vidu_wbt_bankx_wb1_reg (
  .x_num                             (vpu_vidu_wbt_bankx_wb1_reg       ),
  .x_num_expand                      (vpu_vidu_wbt_bankx_wb1_reg_expand)
);


assign wb_en[31:0] = {32{vpu_vidu_wbt_bankx_wb0_vld}} & vpu_vidu_wbt_bankx_wb0_reg_expand
                   | {32{vpu_vidu_wbt_bankx_wb1_vld}} & vpu_vidu_wbt_bankx_wb1_reg_expand;

//==========================================================
//                     Debug Info
//==========================================================
assign wbt_top_bankx_gpr_no_wb = !(&wb_debug[31:0]);

// &ModuleEnd; @357
endmodule


