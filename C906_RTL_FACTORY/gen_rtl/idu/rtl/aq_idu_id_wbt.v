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
module aq_idu_id_wbt(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_wbt_dis_inst_vld,
  ctrl_xx_dis_stall,
  dp_wbt_dst0_reg,
  dp_wbt_dst0_type,
  dp_wbt_dst1_reg,
  dp_wbt_dst1_type,
  dp_wbt_inst_dst0_vld,
  dp_wbt_inst_dst1_vld,
  dp_wbt_src0_reg,
  dp_wbt_src1_reg,
  dp_wbt_src2_reg,
  dp_wbt_wb_vld,
  forever_cpuclk,
  iu_yy_xx_cancel,
  pad_yy_icg_scan_en,
  rtu_idu_flush_wbt,
  rtu_idu_wb0_vld,
  rtu_idu_wb1_vld,
  wbt_ctrl_dst0_info,
  wbt_ctrl_dst1_info,
  wbt_ctrl_src0_info,
  wbt_ctrl_src1_info,
  wbt_ctrl_src2_info,
  wbt_top_gpr_not_wb
);

// &Ports; @25
input           cp0_idu_icg_en;       
input           cp0_yy_clk_en;        
input           cpurst_b;             
input           ctrl_wbt_dis_inst_vld; 
input           ctrl_xx_dis_stall;    
input   [5 :0]  dp_wbt_dst0_reg;      
input   [2 :0]  dp_wbt_dst0_type;     
input   [5 :0]  dp_wbt_dst1_reg;      
input   [2 :0]  dp_wbt_dst1_type;     
input           dp_wbt_inst_dst0_vld; 
input           dp_wbt_inst_dst1_vld; 
input   [5 :0]  dp_wbt_src0_reg;      
input   [5 :0]  dp_wbt_src1_reg;      
input   [5 :0]  dp_wbt_src2_reg;      
input   [31:0]  dp_wbt_wb_vld;        
input           forever_cpuclk;       
input           iu_yy_xx_cancel;      
input           pad_yy_icg_scan_en;   
input           rtu_idu_flush_wbt;    
input           rtu_idu_wb0_vld;      
input           rtu_idu_wb1_vld;      
output  [6 :0]  wbt_ctrl_dst0_info;   
output  [6 :0]  wbt_ctrl_dst1_info;   
output  [6 :0]  wbt_ctrl_src0_info;   
output  [6 :0]  wbt_ctrl_src1_info;   
output  [6 :0]  wbt_ctrl_src2_info;   
output          wbt_top_gpr_not_wb;   

// &Regs; @26
reg     [6 :0]  wbt_ctrl_dst0_info;   
reg     [6 :0]  wbt_ctrl_dst1_info;   
reg     [6 :0]  wbt_ctrl_src0_info;   
reg     [6 :0]  wbt_ctrl_src1_info;   
reg     [6 :0]  wbt_ctrl_src2_info;   

// &Wires; @27
wire            cp0_idu_icg_en;       
wire            cp0_yy_clk_en;        
wire            cpurst_b;             
wire    [31:0]  create0_en;           
wire    [31:0]  create1_en;           
wire            create_clk;           
wire            create_clk_en;        
wire            ctrl_wbt_dis_inst_vld; 
wire            ctrl_xx_dis_stall;    
wire    [5 :0]  dp_wbt_dst0_reg;      
wire    [2 :0]  dp_wbt_dst0_type;     
wire    [5 :0]  dp_wbt_dst1_reg;      
wire    [2 :0]  dp_wbt_dst1_type;     
wire            dp_wbt_inst_dst0_vld; 
wire            dp_wbt_inst_dst1_vld; 
wire    [5 :0]  dp_wbt_src0_reg;      
wire    [5 :0]  dp_wbt_src1_reg;      
wire    [5 :0]  dp_wbt_src2_reg;      
wire    [31:0]  dp_wbt_wb_vld;        
wire            forever_cpuclk;       
wire            inst_create_en;       
wire            iu_yy_xx_cancel;      
wire            pad_yy_icg_scan_en;   
wire    [6 :0]  read_data_0;          
wire    [6 :0]  read_data_1;          
wire    [6 :0]  read_data_10;         
wire    [6 :0]  read_data_11;         
wire    [6 :0]  read_data_12;         
wire    [6 :0]  read_data_13;         
wire    [6 :0]  read_data_14;         
wire    [6 :0]  read_data_15;         
wire    [6 :0]  read_data_16;         
wire    [6 :0]  read_data_17;         
wire    [6 :0]  read_data_18;         
wire    [6 :0]  read_data_19;         
wire    [6 :0]  read_data_2;          
wire    [6 :0]  read_data_20;         
wire    [6 :0]  read_data_21;         
wire    [6 :0]  read_data_22;         
wire    [6 :0]  read_data_23;         
wire    [6 :0]  read_data_24;         
wire    [6 :0]  read_data_25;         
wire    [6 :0]  read_data_26;         
wire    [6 :0]  read_data_27;         
wire    [6 :0]  read_data_28;         
wire    [6 :0]  read_data_29;         
wire    [6 :0]  read_data_3;          
wire    [6 :0]  read_data_30;         
wire    [6 :0]  read_data_31;         
wire    [6 :0]  read_data_4;          
wire    [6 :0]  read_data_5;          
wire    [6 :0]  read_data_6;          
wire    [6 :0]  read_data_7;          
wire    [6 :0]  read_data_8;          
wire    [6 :0]  read_data_9;          
wire            rtu_idu_flush_wbt;    
wire            rtu_idu_wb0_vld;      
wire            rtu_idu_wb1_vld;      
wire            wb_clk;               
wire            wb_clk_en;            
wire    [31:1]  wb_debug;             
wire    [31:0]  wb_en;                
wire    [31:0]  wbt_create_dst0_reg;  
wire    [31:0]  wbt_create_dst1_reg;  
wire    [4 :0]  wbt_dst0_reg;         
wire    [31:0]  wbt_dst0_reg_expand;  
wire    [4 :0]  wbt_dst1_reg;         
wire    [31:0]  wbt_dst1_reg_expand;  
wire            wbt_top_gpr_not_wb;   


//==========================================================
//                 Instance of Gated Cell
//==========================================================
assign create_clk_en = ctrl_wbt_dis_inst_vld
                       || rtu_idu_flush_wbt;
// &Instance("gated_clk_cell", "x_create_clk_gated_clk_cell"); @34
gated_clk_cell  x_create_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (create_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (create_clk_en     ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @35
//          .external_en (1'b0), @36
//          .global_en   (cp0_yy_clk_en), @37
//          .module_en   (cp0_idu_icg_en), @38
//          .local_en    (create_clk_en), @39
//          .clk_out     (create_clk)); @40

assign wb_clk_en = ctrl_wbt_dis_inst_vld
                   || rtu_idu_wb0_vld
                   || rtu_idu_wb1_vld
                   || rtu_idu_flush_wbt;
// &Instance("gated_clk_cell", "x_wb_clk_gated_clk_cell"); @46
gated_clk_cell  x_wb_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (wb_clk            ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (wb_clk_en         ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @47
//          .external_en (1'b0), @48
//          .global_en   (cp0_yy_clk_en), @49
//          .module_en   (cp0_idu_icg_en), @50
//          .local_en    (wb_clk_en), @51
//          .clk_out     (wb_clk)); @52

//==========================================================
//                  Instance Entries
//==========================================================
//----------------------------------------------------------
//                       Entry 0
//----------------------------------------------------------
//treat x0 always ready and wb
assign read_data_0[`WB_INT_WIDTH-1:0] = {{`WB_INT_WIDTH-1{1'b0}},1'b1};

//----------------------------------------------------------
//                      Entry 1~31
//----------------------------------------------------------
// &ConnRule(s/_x$/[1]/); @66
// &ConnRule(s/_y$/_1/); @67
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_1"); @68
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_1 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[1]    ),
  .create1_en_x      (create1_en[1]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_1      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[1]      ),
  .wb_en_x           (wb_en[1]         )
);

// &ConnRule(s/_x$/[2]/); @69
// &ConnRule(s/_y$/_2/); @70
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_2"); @71
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_2 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[2]    ),
  .create1_en_x      (create1_en[2]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_2      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[2]      ),
  .wb_en_x           (wb_en[2]         )
);

// &ConnRule(s/_x$/[3]/); @72
// &ConnRule(s/_y$/_3/); @73
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_3"); @74
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_3 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[3]    ),
  .create1_en_x      (create1_en[3]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_3      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[3]      ),
  .wb_en_x           (wb_en[3]         )
);

// &ConnRule(s/_x$/[4]/); @75
// &ConnRule(s/_y$/_4/); @76
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_4"); @77
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_4 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[4]    ),
  .create1_en_x      (create1_en[4]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_4      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[4]      ),
  .wb_en_x           (wb_en[4]         )
);

// &ConnRule(s/_x$/[5]/); @78
// &ConnRule(s/_y$/_5/); @79
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_5"); @80
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_5 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[5]    ),
  .create1_en_x      (create1_en[5]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_5      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[5]      ),
  .wb_en_x           (wb_en[5]         )
);

// &ConnRule(s/_x$/[6]/); @81
// &ConnRule(s/_y$/_6/); @82
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_6"); @83
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_6 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[6]    ),
  .create1_en_x      (create1_en[6]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_6      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[6]      ),
  .wb_en_x           (wb_en[6]         )
);

// &ConnRule(s/_x$/[7]/); @84
// &ConnRule(s/_y$/_7/); @85
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_7"); @86
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_7 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[7]    ),
  .create1_en_x      (create1_en[7]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_7      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[7]      ),
  .wb_en_x           (wb_en[7]         )
);

// &ConnRule(s/_x$/[8]/); @87
// &ConnRule(s/_y$/_8/); @88
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_8"); @89
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_8 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[8]    ),
  .create1_en_x      (create1_en[8]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_8      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[8]      ),
  .wb_en_x           (wb_en[8]         )
);

// &ConnRule(s/_x$/[9]/); @90
// &ConnRule(s/_y$/_9/); @91
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_9"); @92
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_9 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[9]    ),
  .create1_en_x      (create1_en[9]    ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_9      ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[9]      ),
  .wb_en_x           (wb_en[9]         )
);

// &ConnRule(s/_x$/[10]/); @93
// &ConnRule(s/_y$/_10/); @94
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_10"); @95
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_10 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[10]   ),
  .create1_en_x      (create1_en[10]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_10     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[10]     ),
  .wb_en_x           (wb_en[10]        )
);

// &ConnRule(s/_x$/[11]/); @96
// &ConnRule(s/_y$/_11/); @97
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_11"); @98
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_11 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[11]   ),
  .create1_en_x      (create1_en[11]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_11     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[11]     ),
  .wb_en_x           (wb_en[11]        )
);

// &ConnRule(s/_x$/[12]/); @99
// &ConnRule(s/_y$/_12/); @100
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_12"); @101
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_12 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[12]   ),
  .create1_en_x      (create1_en[12]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_12     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[12]     ),
  .wb_en_x           (wb_en[12]        )
);

// &ConnRule(s/_x$/[13]/); @102
// &ConnRule(s/_y$/_13/); @103
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_13"); @104
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_13 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[13]   ),
  .create1_en_x      (create1_en[13]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_13     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[13]     ),
  .wb_en_x           (wb_en[13]        )
);

// &ConnRule(s/_x$/[14]/); @105
// &ConnRule(s/_y$/_14/); @106
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_14"); @107
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_14 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[14]   ),
  .create1_en_x      (create1_en[14]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_14     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[14]     ),
  .wb_en_x           (wb_en[14]        )
);

// &ConnRule(s/_x$/[15]/); @108
// &ConnRule(s/_y$/_15/); @109
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_15"); @110
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_15 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[15]   ),
  .create1_en_x      (create1_en[15]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_15     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[15]     ),
  .wb_en_x           (wb_en[15]        )
);

// &ConnRule(s/_x$/[16]/); @111
// &ConnRule(s/_y$/_16/); @112
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_16"); @113
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_16 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[16]   ),
  .create1_en_x      (create1_en[16]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_16     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[16]     ),
  .wb_en_x           (wb_en[16]        )
);

// &ConnRule(s/_x$/[17]/); @114
// &ConnRule(s/_y$/_17/); @115
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_17"); @116
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_17 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[17]   ),
  .create1_en_x      (create1_en[17]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_17     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[17]     ),
  .wb_en_x           (wb_en[17]        )
);

// &ConnRule(s/_x$/[18]/); @117
// &ConnRule(s/_y$/_18/); @118
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_18"); @119
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_18 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[18]   ),
  .create1_en_x      (create1_en[18]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_18     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[18]     ),
  .wb_en_x           (wb_en[18]        )
);

// &ConnRule(s/_x$/[19]/); @120
// &ConnRule(s/_y$/_19/); @121
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_19"); @122
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_19 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[19]   ),
  .create1_en_x      (create1_en[19]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_19     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[19]     ),
  .wb_en_x           (wb_en[19]        )
);

// &ConnRule(s/_x$/[20]/); @123
// &ConnRule(s/_y$/_20/); @124
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_20"); @125
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_20 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[20]   ),
  .create1_en_x      (create1_en[20]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_20     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[20]     ),
  .wb_en_x           (wb_en[20]        )
);

// &ConnRule(s/_x$/[21]/); @126
// &ConnRule(s/_y$/_21/); @127
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_21"); @128
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_21 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[21]   ),
  .create1_en_x      (create1_en[21]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_21     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[21]     ),
  .wb_en_x           (wb_en[21]        )
);

// &ConnRule(s/_x$/[22]/); @129
// &ConnRule(s/_y$/_22/); @130
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_22"); @131
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_22 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[22]   ),
  .create1_en_x      (create1_en[22]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_22     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[22]     ),
  .wb_en_x           (wb_en[22]        )
);

// &ConnRule(s/_x$/[23]/); @132
// &ConnRule(s/_y$/_23/); @133
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_23"); @134
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_23 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[23]   ),
  .create1_en_x      (create1_en[23]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_23     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[23]     ),
  .wb_en_x           (wb_en[23]        )
);

// &ConnRule(s/_x$/[24]/); @135
// &ConnRule(s/_y$/_24/); @136
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_24"); @137
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_24 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[24]   ),
  .create1_en_x      (create1_en[24]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_24     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[24]     ),
  .wb_en_x           (wb_en[24]        )
);

// &ConnRule(s/_x$/[25]/); @138
// &ConnRule(s/_y$/_25/); @139
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_25"); @140
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_25 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[25]   ),
  .create1_en_x      (create1_en[25]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_25     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[25]     ),
  .wb_en_x           (wb_en[25]        )
);

// &ConnRule(s/_x$/[26]/); @141
// &ConnRule(s/_y$/_26/); @142
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_26"); @143
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_26 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[26]   ),
  .create1_en_x      (create1_en[26]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_26     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[26]     ),
  .wb_en_x           (wb_en[26]        )
);

// &ConnRule(s/_x$/[27]/); @144
// &ConnRule(s/_y$/_27/); @145
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_27"); @146
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_27 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[27]   ),
  .create1_en_x      (create1_en[27]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_27     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[27]     ),
  .wb_en_x           (wb_en[27]        )
);

// &ConnRule(s/_x$/[28]/); @147
// &ConnRule(s/_y$/_28/); @148
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_28"); @149
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_28 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[28]   ),
  .create1_en_x      (create1_en[28]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_28     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[28]     ),
  .wb_en_x           (wb_en[28]        )
);

// &ConnRule(s/_x$/[29]/); @150
// &ConnRule(s/_y$/_29/); @151
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_29"); @152
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_29 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[29]   ),
  .create1_en_x      (create1_en[29]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_29     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[29]     ),
  .wb_en_x           (wb_en[29]        )
);

// &ConnRule(s/_x$/[30]/); @153
// &ConnRule(s/_y$/_30/); @154
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_30"); @155
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_30 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[30]   ),
  .create1_en_x      (create1_en[30]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_30     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[30]     ),
  .wb_en_x           (wb_en[30]        )
);

// &ConnRule(s/_x$/[31]/); @156
// &ConnRule(s/_y$/_31/); @157
// &Instance("aq_idu_id_wbt_entry","x_aq_idu_id_wbt_entry_reg_31"); @158
aq_idu_id_wbt_entry  x_aq_idu_id_wbt_entry_reg_31 (
  .cpurst_b          (cpurst_b         ),
  .create0_en_x      (create0_en[31]   ),
  .create1_en_x      (create1_en[31]   ),
  .create_clk        (create_clk       ),
  .dp_wbt_dst0_type  (dp_wbt_dst0_type ),
  .dp_wbt_dst1_type  (dp_wbt_dst1_type ),
  .iu_yy_xx_cancel   (iu_yy_xx_cancel  ),
  .read_data_y       (read_data_31     ),
  .rtu_idu_flush_wbt (rtu_idu_flush_wbt),
  .wb_clk            (wb_clk           ),
  .wb_debug_x        (wb_debug[31]     ),
  .wb_en_x           (wb_en[31]        )
);


//==========================================================
//                       Create Port
//==========================================================
// &Force("bus","dp_wbt_dst0_reg",5,0); @163
// &Force("bus","dp_wbt_dst1_reg",5,0); @164
assign wbt_dst0_reg[4:0] = dp_wbt_dst0_reg[4:0];
assign wbt_dst1_reg[4:0] = dp_wbt_dst1_reg[4:0];
// &ConnRule(s/^x_num/wbt_dst0_reg/); @167
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_wbt_dst0_reg"); @168
aq_idu_expand_32  x_aq_idu_expand_32_wbt_dst0_reg (
  .x_num               (wbt_dst0_reg       ),
  .x_num_expand        (wbt_dst0_reg_expand)
);

// &ConnRule(s/^x_num/wbt_dst1_reg/); @169
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_wbt_dst1_reg"); @170
aq_idu_expand_32  x_aq_idu_expand_32_wbt_dst1_reg (
  .x_num               (wbt_dst1_reg       ),
  .x_num_expand        (wbt_dst1_reg_expand)
);


assign inst_create_en            = ctrl_wbt_dis_inst_vld
                                   && !ctrl_xx_dis_stall;
assign wbt_create_dst0_reg[31:0] = wbt_dst0_reg_expand[31:0]
                                   & {32{dp_wbt_inst_dst0_vld && inst_create_en}};
assign wbt_create_dst1_reg[31:0] = wbt_dst1_reg_expand[31:0]
                                   & {32{dp_wbt_inst_dst1_vld && inst_create_en}};
assign create0_en[31:0]          = wbt_create_dst0_reg[31:0];
assign create1_en[31:0]          = wbt_create_dst1_reg[31:0];

//==========================================================
//                       Read Port
//==========================================================
//----------------------------------------------------------
//                     Source 0 Read
//----------------------------------------------------------
// &Force("bus","dp_wbt_src0_reg",5,0); @187
// &CombBeg; @188
always @( read_data_13[6:0]
       or read_data_19[6:0]
       or read_data_10[6:0]
       or read_data_12[6:0]
       or dp_wbt_src0_reg[4:0]
       or read_data_18[6:0]
       or read_data_26[6:0]
       or read_data_23[6:0]
       or read_data_4[6:0]
       or read_data_17[6:0]
       or read_data_27[6:0]
       or read_data_6[6:0]
       or read_data_15[6:0]
       or read_data_16[6:0]
       or read_data_28[6:0]
       or read_data_14[6:0]
       or read_data_5[6:0]
       or read_data_11[6:0]
       or read_data_20[6:0]
       or read_data_9[6:0]
       or read_data_1[6:0]
       or read_data_24[6:0]
       or read_data_0[6:0]
       or read_data_25[6:0]
       or read_data_7[6:0]
       or read_data_3[6:0]
       or read_data_30[6:0]
       or read_data_22[6:0]
       or read_data_21[6:0]
       or read_data_2[6:0]
       or read_data_31[6:0]
       or read_data_8[6:0]
       or read_data_29[6:0])
begin
  case (dp_wbt_src0_reg[4:0])
    5'd0   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_0[`WB_INT_WIDTH-1:0];
    5'd1   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_1[`WB_INT_WIDTH-1:0];
    5'd2   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_2[`WB_INT_WIDTH-1:0];
    5'd3   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_3[`WB_INT_WIDTH-1:0];
    5'd4   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_4[`WB_INT_WIDTH-1:0];
    5'd5   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_5[`WB_INT_WIDTH-1:0];
    5'd6   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_6[`WB_INT_WIDTH-1:0];
    5'd7   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_7[`WB_INT_WIDTH-1:0];
    5'd8   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_8[`WB_INT_WIDTH-1:0];
    5'd9   : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_9[`WB_INT_WIDTH-1:0];
    5'd10  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_10[`WB_INT_WIDTH-1:0];
    5'd11  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_11[`WB_INT_WIDTH-1:0];
    5'd12  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_12[`WB_INT_WIDTH-1:0];
    5'd13  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_13[`WB_INT_WIDTH-1:0];
    5'd14  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_14[`WB_INT_WIDTH-1:0];
    5'd15  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_15[`WB_INT_WIDTH-1:0];
    5'd16  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_16[`WB_INT_WIDTH-1:0];
    5'd17  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_17[`WB_INT_WIDTH-1:0];
    5'd18  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_18[`WB_INT_WIDTH-1:0];
    5'd19  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_19[`WB_INT_WIDTH-1:0];
    5'd20  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_20[`WB_INT_WIDTH-1:0];
    5'd21  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_21[`WB_INT_WIDTH-1:0];
    5'd22  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_22[`WB_INT_WIDTH-1:0];
    5'd23  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_23[`WB_INT_WIDTH-1:0];
    5'd24  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_24[`WB_INT_WIDTH-1:0];
    5'd25  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_25[`WB_INT_WIDTH-1:0];
    5'd26  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_26[`WB_INT_WIDTH-1:0];
    5'd27  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_27[`WB_INT_WIDTH-1:0];
    5'd28  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_28[`WB_INT_WIDTH-1:0];
    5'd29  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_29[`WB_INT_WIDTH-1:0];
    5'd30  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_30[`WB_INT_WIDTH-1:0];
    5'd31  : wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = read_data_31[`WB_INT_WIDTH-1:0];
    default: wbt_ctrl_src0_info[`WB_INT_WIDTH-1:0] = {`WB_INT_WIDTH{1'bx}};
  endcase
// &CombEnd; @224
end

//----------------------------------------------------------
//                     Source 1 Read
//----------------------------------------------------------
// &Force("bus","dp_wbt_src1_reg",5,0); @229
// &CombBeg; @230
always @( read_data_13[6:0]
       or read_data_19[6:0]
       or read_data_10[6:0]
       or read_data_12[6:0]
       or read_data_26[6:0]
       or read_data_18[6:0]
       or read_data_23[6:0]
       or read_data_4[6:0]
       or read_data_17[6:0]
       or read_data_27[6:0]
       or dp_wbt_src1_reg[4:0]
       or read_data_15[6:0]
       or read_data_6[6:0]
       or read_data_28[6:0]
       or read_data_16[6:0]
       or read_data_14[6:0]
       or read_data_5[6:0]
       or read_data_11[6:0]
       or read_data_20[6:0]
       or read_data_9[6:0]
       or read_data_1[6:0]
       or read_data_24[6:0]
       or read_data_0[6:0]
       or read_data_25[6:0]
       or read_data_7[6:0]
       or read_data_3[6:0]
       or read_data_30[6:0]
       or read_data_22[6:0]
       or read_data_21[6:0]
       or read_data_31[6:0]
       or read_data_2[6:0]
       or read_data_8[6:0]
       or read_data_29[6:0])
begin
  case (dp_wbt_src1_reg[4:0])
    5'd0   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_0[`WB_INT_WIDTH-1:0];
    5'd1   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_1[`WB_INT_WIDTH-1:0];
    5'd2   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_2[`WB_INT_WIDTH-1:0];
    5'd3   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_3[`WB_INT_WIDTH-1:0];
    5'd4   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_4[`WB_INT_WIDTH-1:0];
    5'd5   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_5[`WB_INT_WIDTH-1:0];
    5'd6   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_6[`WB_INT_WIDTH-1:0];
    5'd7   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_7[`WB_INT_WIDTH-1:0];
    5'd8   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_8[`WB_INT_WIDTH-1:0];
    5'd9   : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_9[`WB_INT_WIDTH-1:0];
    5'd10  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_10[`WB_INT_WIDTH-1:0];
    5'd11  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_11[`WB_INT_WIDTH-1:0];
    5'd12  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_12[`WB_INT_WIDTH-1:0];
    5'd13  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_13[`WB_INT_WIDTH-1:0];
    5'd14  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_14[`WB_INT_WIDTH-1:0];
    5'd15  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_15[`WB_INT_WIDTH-1:0];
    5'd16  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_16[`WB_INT_WIDTH-1:0];
    5'd17  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_17[`WB_INT_WIDTH-1:0];
    5'd18  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_18[`WB_INT_WIDTH-1:0];
    5'd19  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_19[`WB_INT_WIDTH-1:0];
    5'd20  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_20[`WB_INT_WIDTH-1:0];
    5'd21  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_21[`WB_INT_WIDTH-1:0];
    5'd22  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_22[`WB_INT_WIDTH-1:0];
    5'd23  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_23[`WB_INT_WIDTH-1:0];
    5'd24  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_24[`WB_INT_WIDTH-1:0];
    5'd25  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_25[`WB_INT_WIDTH-1:0];
    5'd26  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_26[`WB_INT_WIDTH-1:0];
    5'd27  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_27[`WB_INT_WIDTH-1:0];
    5'd28  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_28[`WB_INT_WIDTH-1:0];
    5'd29  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_29[`WB_INT_WIDTH-1:0];
    5'd30  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_30[`WB_INT_WIDTH-1:0];
    5'd31  : wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = read_data_31[`WB_INT_WIDTH-1:0];
    default: wbt_ctrl_src1_info[`WB_INT_WIDTH-1:0] = {`WB_INT_WIDTH{1'bx}};
  endcase
// &CombEnd; @266
end

//----------------------------------------------------------
//                     Source 2 Read
//----------------------------------------------------------
// &Force("bus","dp_wbt_src2_reg",5,0); @271
// &CombBeg; @272
always @( read_data_13[6:0]
       or read_data_19[6:0]
       or dp_wbt_src2_reg[4:0]
       or read_data_10[6:0]
       or read_data_12[6:0]
       or read_data_26[6:0]
       or read_data_18[6:0]
       or read_data_23[6:0]
       or read_data_4[6:0]
       or read_data_17[6:0]
       or read_data_27[6:0]
       or read_data_15[6:0]
       or read_data_6[6:0]
       or read_data_28[6:0]
       or read_data_16[6:0]
       or read_data_14[6:0]
       or read_data_5[6:0]
       or read_data_11[6:0]
       or read_data_20[6:0]
       or read_data_9[6:0]
       or read_data_1[6:0]
       or read_data_24[6:0]
       or read_data_0[6:0]
       or read_data_25[6:0]
       or read_data_7[6:0]
       or read_data_3[6:0]
       or read_data_30[6:0]
       or read_data_22[6:0]
       or read_data_21[6:0]
       or read_data_31[6:0]
       or read_data_2[6:0]
       or read_data_8[6:0]
       or read_data_29[6:0])
begin
  case (dp_wbt_src2_reg[4:0])
    5'd0   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_0[`WB_INT_WIDTH-1:0];
    5'd1   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_1[`WB_INT_WIDTH-1:0];
    5'd2   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_2[`WB_INT_WIDTH-1:0];
    5'd3   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_3[`WB_INT_WIDTH-1:0];
    5'd4   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_4[`WB_INT_WIDTH-1:0];
    5'd5   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_5[`WB_INT_WIDTH-1:0];
    5'd6   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_6[`WB_INT_WIDTH-1:0];
    5'd7   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_7[`WB_INT_WIDTH-1:0];
    5'd8   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_8[`WB_INT_WIDTH-1:0];
    5'd9   : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_9[`WB_INT_WIDTH-1:0];
    5'd10  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_10[`WB_INT_WIDTH-1:0];
    5'd11  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_11[`WB_INT_WIDTH-1:0];
    5'd12  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_12[`WB_INT_WIDTH-1:0];
    5'd13  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_13[`WB_INT_WIDTH-1:0];
    5'd14  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_14[`WB_INT_WIDTH-1:0];
    5'd15  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_15[`WB_INT_WIDTH-1:0];
    5'd16  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_16[`WB_INT_WIDTH-1:0];
    5'd17  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_17[`WB_INT_WIDTH-1:0];
    5'd18  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_18[`WB_INT_WIDTH-1:0];
    5'd19  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_19[`WB_INT_WIDTH-1:0];
    5'd20  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_20[`WB_INT_WIDTH-1:0];
    5'd21  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_21[`WB_INT_WIDTH-1:0];
    5'd22  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_22[`WB_INT_WIDTH-1:0];
    5'd23  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_23[`WB_INT_WIDTH-1:0];
    5'd24  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_24[`WB_INT_WIDTH-1:0];
    5'd25  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_25[`WB_INT_WIDTH-1:0];
    5'd26  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_26[`WB_INT_WIDTH-1:0];
    5'd27  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_27[`WB_INT_WIDTH-1:0];
    5'd28  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_28[`WB_INT_WIDTH-1:0];
    5'd29  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_29[`WB_INT_WIDTH-1:0];
    5'd30  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_30[`WB_INT_WIDTH-1:0];
    5'd31  : wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = read_data_31[`WB_INT_WIDTH-1:0];
    default: wbt_ctrl_src2_info[`WB_INT_WIDTH-1:0] = {`WB_INT_WIDTH{1'bx}};
  endcase
// &CombEnd; @308
end

//----------------------------------------------------------
//                     Dest 0 Read
//----------------------------------------------------------
// &Force("bus","dp_wbt_dst0_reg",5,0); @313
// &CombBeg; @314
always @( read_data_13[6:0]
       or read_data_19[6:0]
       or read_data_10[6:0]
       or read_data_12[6:0]
       or read_data_26[6:0]
       or read_data_18[6:0]
       or read_data_23[6:0]
       or read_data_4[6:0]
       or read_data_17[6:0]
       or read_data_27[6:0]
       or read_data_15[6:0]
       or read_data_6[6:0]
       or read_data_28[6:0]
       or read_data_16[6:0]
       or read_data_14[6:0]
       or read_data_5[6:0]
       or read_data_11[6:0]
       or read_data_20[6:0]
       or read_data_9[6:0]
       or read_data_1[6:0]
       or read_data_24[6:0]
       or read_data_0[6:0]
       or read_data_25[6:0]
       or read_data_7[6:0]
       or read_data_3[6:0]
       or read_data_30[6:0]
       or read_data_22[6:0]
       or read_data_21[6:0]
       or read_data_31[6:0]
       or dp_wbt_dst0_reg[4:0]
       or read_data_2[6:0]
       or read_data_8[6:0]
       or read_data_29[6:0])
begin
  case (dp_wbt_dst0_reg[4:0])
    5'd0   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_0[`WB_INT_WIDTH-1:0];
    5'd1   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_1[`WB_INT_WIDTH-1:0];
    5'd2   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_2[`WB_INT_WIDTH-1:0];
    5'd3   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_3[`WB_INT_WIDTH-1:0];
    5'd4   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_4[`WB_INT_WIDTH-1:0];
    5'd5   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_5[`WB_INT_WIDTH-1:0];
    5'd6   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_6[`WB_INT_WIDTH-1:0];
    5'd7   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_7[`WB_INT_WIDTH-1:0];
    5'd8   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_8[`WB_INT_WIDTH-1:0];
    5'd9   : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_9[`WB_INT_WIDTH-1:0];
    5'd10  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_10[`WB_INT_WIDTH-1:0];
    5'd11  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_11[`WB_INT_WIDTH-1:0];
    5'd12  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_12[`WB_INT_WIDTH-1:0];
    5'd13  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_13[`WB_INT_WIDTH-1:0];
    5'd14  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_14[`WB_INT_WIDTH-1:0];
    5'd15  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_15[`WB_INT_WIDTH-1:0];
    5'd16  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_16[`WB_INT_WIDTH-1:0];
    5'd17  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_17[`WB_INT_WIDTH-1:0];
    5'd18  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_18[`WB_INT_WIDTH-1:0];
    5'd19  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_19[`WB_INT_WIDTH-1:0];
    5'd20  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_20[`WB_INT_WIDTH-1:0];
    5'd21  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_21[`WB_INT_WIDTH-1:0];
    5'd22  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_22[`WB_INT_WIDTH-1:0];
    5'd23  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_23[`WB_INT_WIDTH-1:0];
    5'd24  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_24[`WB_INT_WIDTH-1:0];
    5'd25  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_25[`WB_INT_WIDTH-1:0];
    5'd26  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_26[`WB_INT_WIDTH-1:0];
    5'd27  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_27[`WB_INT_WIDTH-1:0];
    5'd28  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_28[`WB_INT_WIDTH-1:0];
    5'd29  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_29[`WB_INT_WIDTH-1:0];
    5'd30  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_30[`WB_INT_WIDTH-1:0];
    5'd31  : wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = read_data_31[`WB_INT_WIDTH-1:0];
    default: wbt_ctrl_dst0_info[`WB_INT_WIDTH-1:0] = {`WB_INT_WIDTH{1'bx}};
  endcase
// &CombEnd; @350
end


//----------------------------------------------------------
//                     Dest 1 Read
//----------------------------------------------------------
// &Force("bus","dp_wbt_dst1_reg",5,0); @356
// &CombBeg; @357
always @( read_data_13[6:0]
       or read_data_19[6:0]
       or read_data_10[6:0]
       or read_data_12[6:0]
       or read_data_26[6:0]
       or read_data_18[6:0]
       or read_data_23[6:0]
       or read_data_4[6:0]
       or read_data_17[6:0]
       or read_data_27[6:0]
       or read_data_15[6:0]
       or read_data_6[6:0]
       or read_data_28[6:0]
       or read_data_16[6:0]
       or read_data_14[6:0]
       or read_data_5[6:0]
       or read_data_11[6:0]
       or read_data_20[6:0]
       or read_data_9[6:0]
       or read_data_1[6:0]
       or read_data_24[6:0]
       or read_data_0[6:0]
       or read_data_25[6:0]
       or read_data_7[6:0]
       or read_data_3[6:0]
       or read_data_30[6:0]
       or read_data_22[6:0]
       or read_data_21[6:0]
       or read_data_31[6:0]
       or dp_wbt_dst1_reg[4:0]
       or read_data_2[6:0]
       or read_data_8[6:0]
       or read_data_29[6:0])
begin
  case (dp_wbt_dst1_reg[4:0])
    5'd0   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_0[`WB_INT_WIDTH-1:0];
    5'd1   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_1[`WB_INT_WIDTH-1:0];
    5'd2   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_2[`WB_INT_WIDTH-1:0];
    5'd3   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_3[`WB_INT_WIDTH-1:0];
    5'd4   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_4[`WB_INT_WIDTH-1:0];
    5'd5   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_5[`WB_INT_WIDTH-1:0];
    5'd6   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_6[`WB_INT_WIDTH-1:0];
    5'd7   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_7[`WB_INT_WIDTH-1:0];
    5'd8   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_8[`WB_INT_WIDTH-1:0];
    5'd9   : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_9[`WB_INT_WIDTH-1:0];
    5'd10  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_10[`WB_INT_WIDTH-1:0];
    5'd11  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_11[`WB_INT_WIDTH-1:0];
    5'd12  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_12[`WB_INT_WIDTH-1:0];
    5'd13  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_13[`WB_INT_WIDTH-1:0];
    5'd14  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_14[`WB_INT_WIDTH-1:0];
    5'd15  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_15[`WB_INT_WIDTH-1:0];
    5'd16  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_16[`WB_INT_WIDTH-1:0];
    5'd17  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_17[`WB_INT_WIDTH-1:0];
    5'd18  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_18[`WB_INT_WIDTH-1:0];
    5'd19  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_19[`WB_INT_WIDTH-1:0];
    5'd20  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_20[`WB_INT_WIDTH-1:0];
    5'd21  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_21[`WB_INT_WIDTH-1:0];
    5'd22  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_22[`WB_INT_WIDTH-1:0];
    5'd23  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_23[`WB_INT_WIDTH-1:0];
    5'd24  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_24[`WB_INT_WIDTH-1:0];
    5'd25  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_25[`WB_INT_WIDTH-1:0];
    5'd26  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_26[`WB_INT_WIDTH-1:0];
    5'd27  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_27[`WB_INT_WIDTH-1:0];
    5'd28  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_28[`WB_INT_WIDTH-1:0];
    5'd29  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_29[`WB_INT_WIDTH-1:0];
    5'd30  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_30[`WB_INT_WIDTH-1:0];
    5'd31  : wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = read_data_31[`WB_INT_WIDTH-1:0];
    default: wbt_ctrl_dst1_info[`WB_INT_WIDTH-1:0] = {`WB_INT_WIDTH{1'bx}};
  endcase
// &CombEnd; @393
end

//==========================================================
//                    Write Back Port
//==========================================================
assign wb_en[31:0] = dp_wbt_wb_vld[31:0];

//==========================================================
//                      Debug Info
//==========================================================
assign wbt_top_gpr_not_wb = !(&wb_debug[31:1]);

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @418
// &Force("nonport","clk"); @419
// &Force("nonport","rst"); @420

// &ModuleEnd; @431
endmodule


