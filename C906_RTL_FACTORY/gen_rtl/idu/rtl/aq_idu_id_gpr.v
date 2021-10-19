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
module aq_idu_id_gpr(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  dp_gpr_src0_reg,
  dp_gpr_src1_reg,
  dp_gpr_src2_reg,
  dp_gpr_wb0_vld,
  dp_gpr_wb1_vld,
  forever_cpuclk,
  gpr_dp_src0_data,
  gpr_dp_src1_data,
  gpr_dp_src2_data,
  pad_yy_icg_scan_en,
  rtu_idu_wb0_data,
  rtu_idu_wb1_data
);

// &Ports; @24
input           cp0_idu_icg_en;    
input           cp0_yy_clk_en;     
input   [5 :0]  dp_gpr_src0_reg;   
input   [5 :0]  dp_gpr_src1_reg;   
input   [5 :0]  dp_gpr_src2_reg;   
input   [31:0]  dp_gpr_wb0_vld;    
input   [31:0]  dp_gpr_wb1_vld;    
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
input   [63:0]  rtu_idu_wb0_data;  
input   [63:0]  rtu_idu_wb1_data;  
output  [63:0]  gpr_dp_src0_data;  
output  [63:0]  gpr_dp_src1_data;  
output  [63:0]  gpr_dp_src2_data;  

// &Regs; @25
reg     [63:0]  gpr_dp_src0_data;  
reg     [63:0]  gpr_dp_src1_data;  
reg     [63:0]  gpr_dp_src2_data;  

// &Wires; @26
wire            cp0_idu_icg_en;    
wire            cp0_yy_clk_en;     
wire    [5 :0]  dp_gpr_src0_reg;   
wire    [5 :0]  dp_gpr_src1_reg;   
wire    [5 :0]  dp_gpr_src2_reg;   
wire    [31:0]  dp_gpr_wb0_vld;    
wire    [31:0]  dp_gpr_wb1_vld;    
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 
wire    [63:0]  read_data_0;       
wire    [63:0]  read_data_1;       
wire    [63:0]  read_data_10;      
wire    [63:0]  read_data_11;      
wire    [63:0]  read_data_12;      
wire    [63:0]  read_data_13;      
wire    [63:0]  read_data_14;      
wire    [63:0]  read_data_15;      
wire    [63:0]  read_data_16;      
wire    [63:0]  read_data_17;      
wire    [63:0]  read_data_18;      
wire    [63:0]  read_data_19;      
wire    [63:0]  read_data_2;       
wire    [63:0]  read_data_20;      
wire    [63:0]  read_data_21;      
wire    [63:0]  read_data_22;      
wire    [63:0]  read_data_23;      
wire    [63:0]  read_data_24;      
wire    [63:0]  read_data_25;      
wire    [63:0]  read_data_26;      
wire    [63:0]  read_data_27;      
wire    [63:0]  read_data_28;      
wire    [63:0]  read_data_29;      
wire    [63:0]  read_data_3;       
wire    [63:0]  read_data_30;      
wire    [63:0]  read_data_31;      
wire    [63:0]  read_data_4;       
wire    [63:0]  read_data_5;       
wire    [63:0]  read_data_6;       
wire    [63:0]  read_data_7;       
wire    [63:0]  read_data_8;       
wire    [63:0]  read_data_9;       
wire    [63:0]  rtu_idu_wb0_data;  
wire    [63:0]  rtu_idu_wb1_data;  
wire    [31:0]  wb0_vld;           
wire    [31:0]  wb1_vld;           



//==========================================================
//                  Instance Entries
//==========================================================
//----------------------------------------------------------
//                       Entry 0
//----------------------------------------------------------
assign read_data_0[63:0] = 64'b0;

//----------------------------------------------------------
//                      Entry 1~31
//----------------------------------------------------------
// &ConnRule(s/_x$/[1]/); @40
// &ConnRule(s/_y$/_1/); @41
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_1"); @42
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_1 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_1       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[1]        ),
  .wb1_vld_x          (wb1_vld[1]        )
);

// &ConnRule(s/_x$/[2]/); @43
// &ConnRule(s/_y$/_2/); @44
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_2"); @45
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_2 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_2       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[2]        ),
  .wb1_vld_x          (wb1_vld[2]        )
);

// &ConnRule(s/_x$/[3]/); @46
// &ConnRule(s/_y$/_3/); @47
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_3"); @48
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_3 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_3       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[3]        ),
  .wb1_vld_x          (wb1_vld[3]        )
);

// &ConnRule(s/_x$/[4]/); @49
// &ConnRule(s/_y$/_4/); @50
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_4"); @51
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_4 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_4       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[4]        ),
  .wb1_vld_x          (wb1_vld[4]        )
);

// &ConnRule(s/_x$/[5]/); @52
// &ConnRule(s/_y$/_5/); @53
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_5"); @54
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_5 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_5       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[5]        ),
  .wb1_vld_x          (wb1_vld[5]        )
);

// &ConnRule(s/_x$/[6]/); @55
// &ConnRule(s/_y$/_6/); @56
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_6"); @57
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_6 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_6       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[6]        ),
  .wb1_vld_x          (wb1_vld[6]        )
);

// &ConnRule(s/_x$/[7]/); @58
// &ConnRule(s/_y$/_7/); @59
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_7"); @60
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_7 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_7       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[7]        ),
  .wb1_vld_x          (wb1_vld[7]        )
);

// &ConnRule(s/_x$/[8]/); @61
// &ConnRule(s/_y$/_8/); @62
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_8"); @63
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_8 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_8       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[8]        ),
  .wb1_vld_x          (wb1_vld[8]        )
);

// &ConnRule(s/_x$/[9]/); @64
// &ConnRule(s/_y$/_9/); @65
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_9"); @66
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_9 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_9       ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[9]        ),
  .wb1_vld_x          (wb1_vld[9]        )
);

// &ConnRule(s/_x$/[10]/); @67
// &ConnRule(s/_y$/_10/); @68
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_10"); @69
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_10 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_10      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[10]       ),
  .wb1_vld_x          (wb1_vld[10]       )
);

// &ConnRule(s/_x$/[11]/); @70
// &ConnRule(s/_y$/_11/); @71
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_11"); @72
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_11 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_11      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[11]       ),
  .wb1_vld_x          (wb1_vld[11]       )
);

// &ConnRule(s/_x$/[12]/); @73
// &ConnRule(s/_y$/_12/); @74
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_12"); @75
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_12 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_12      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[12]       ),
  .wb1_vld_x          (wb1_vld[12]       )
);

// &ConnRule(s/_x$/[13]/); @76
// &ConnRule(s/_y$/_13/); @77
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_13"); @78
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_13 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_13      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[13]       ),
  .wb1_vld_x          (wb1_vld[13]       )
);

// &ConnRule(s/_x$/[14]/); @79
// &ConnRule(s/_y$/_14/); @80
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_14"); @81
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_14 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_14      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[14]       ),
  .wb1_vld_x          (wb1_vld[14]       )
);

// &ConnRule(s/_x$/[15]/); @82
// &ConnRule(s/_y$/_15/); @83
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_15"); @84
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_15 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_15      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[15]       ),
  .wb1_vld_x          (wb1_vld[15]       )
);

// &ConnRule(s/_x$/[16]/); @85
// &ConnRule(s/_y$/_16/); @86
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_16"); @87
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_16 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_16      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[16]       ),
  .wb1_vld_x          (wb1_vld[16]       )
);

// &ConnRule(s/_x$/[17]/); @88
// &ConnRule(s/_y$/_17/); @89
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_17"); @90
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_17 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_17      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[17]       ),
  .wb1_vld_x          (wb1_vld[17]       )
);

// &ConnRule(s/_x$/[18]/); @91
// &ConnRule(s/_y$/_18/); @92
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_18"); @93
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_18 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_18      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[18]       ),
  .wb1_vld_x          (wb1_vld[18]       )
);

// &ConnRule(s/_x$/[19]/); @94
// &ConnRule(s/_y$/_19/); @95
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_19"); @96
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_19 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_19      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[19]       ),
  .wb1_vld_x          (wb1_vld[19]       )
);

// &ConnRule(s/_x$/[20]/); @97
// &ConnRule(s/_y$/_20/); @98
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_20"); @99
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_20 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_20      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[20]       ),
  .wb1_vld_x          (wb1_vld[20]       )
);

// &ConnRule(s/_x$/[21]/); @100
// &ConnRule(s/_y$/_21/); @101
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_21"); @102
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_21 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_21      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[21]       ),
  .wb1_vld_x          (wb1_vld[21]       )
);

// &ConnRule(s/_x$/[22]/); @103
// &ConnRule(s/_y$/_22/); @104
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_22"); @105
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_22 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_22      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[22]       ),
  .wb1_vld_x          (wb1_vld[22]       )
);

// &ConnRule(s/_x$/[23]/); @106
// &ConnRule(s/_y$/_23/); @107
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_23"); @108
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_23 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_23      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[23]       ),
  .wb1_vld_x          (wb1_vld[23]       )
);

// &ConnRule(s/_x$/[24]/); @109
// &ConnRule(s/_y$/_24/); @110
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_24"); @111
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_24 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_24      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[24]       ),
  .wb1_vld_x          (wb1_vld[24]       )
);

// &ConnRule(s/_x$/[25]/); @112
// &ConnRule(s/_y$/_25/); @113
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_25"); @114
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_25 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_25      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[25]       ),
  .wb1_vld_x          (wb1_vld[25]       )
);

// &ConnRule(s/_x$/[26]/); @115
// &ConnRule(s/_y$/_26/); @116
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_26"); @117
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_26 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_26      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[26]       ),
  .wb1_vld_x          (wb1_vld[26]       )
);

// &ConnRule(s/_x$/[27]/); @118
// &ConnRule(s/_y$/_27/); @119
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_27"); @120
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_27 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_27      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[27]       ),
  .wb1_vld_x          (wb1_vld[27]       )
);

// &ConnRule(s/_x$/[28]/); @121
// &ConnRule(s/_y$/_28/); @122
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_28"); @123
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_28 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_28      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[28]       ),
  .wb1_vld_x          (wb1_vld[28]       )
);

// &ConnRule(s/_x$/[29]/); @124
// &ConnRule(s/_y$/_29/); @125
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_29"); @126
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_29 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_29      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[29]       ),
  .wb1_vld_x          (wb1_vld[29]       )
);

// &ConnRule(s/_x$/[30]/); @127
// &ConnRule(s/_y$/_30/); @128
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_30"); @129
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_30 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_30      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[30]       ),
  .wb1_vld_x          (wb1_vld[30]       )
);

// &ConnRule(s/_x$/[31]/); @130
// &ConnRule(s/_y$/_31/); @131
// &Instance("aq_idu_id_gpr_gated_reg","x_aq_idu_id_gpr_gated_reg_31"); @132
aq_idu_id_gpr_gated_reg  x_aq_idu_id_gpr_gated_reg_31 (
  .cp0_idu_icg_en     (cp0_idu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .read_data_y        (read_data_31      ),
  .rtu_idu_wb0_data   (rtu_idu_wb0_data  ),
  .rtu_idu_wb1_data   (rtu_idu_wb1_data  ),
  .wb0_vld_x          (wb0_vld[31]       ),
  .wb1_vld_x          (wb1_vld[31]       )
);


//==========================================================
//                      Create Port
//==========================================================
assign wb0_vld[31:0] = dp_gpr_wb0_vld[31:0];
assign wb1_vld[31:0] = dp_gpr_wb1_vld[31:0];

//==========================================================
//                       Read Port
//==========================================================
//----------------------------------------------------------
//                     Source 0 Read
//----------------------------------------------------------
// &Force("bus","dp_gpr_src0_reg",5,0); @146
// &CombBeg; @147
always @( read_data_15[63:0]
       or read_data_27[63:0]
       or read_data_29[63:0]
       or read_data_25[63:0]
       or read_data_23[63:0]
       or read_data_30[63:0]
       or read_data_7[63:0]
       or read_data_14[63:0]
       or read_data_28[63:0]
       or read_data_19[63:0]
       or read_data_21[63:0]
       or read_data_17[63:0]
       or read_data_24[63:0]
       or read_data_10[63:0]
       or read_data_3[63:0]
       or read_data_8[63:0]
       or read_data_16[63:0]
       or dp_gpr_src0_reg[4:0]
       or read_data_22[63:0]
       or read_data_26[63:0]
       or read_data_18[63:0]
       or read_data_20[63:0]
       or read_data_11[63:0]
       or read_data_6[63:0]
       or read_data_31[63:0]
       or read_data_2[63:0]
       or read_data_5[63:0]
       or read_data_13[63:0]
       or read_data_4[63:0]
       or read_data_12[63:0]
       or read_data_9[63:0]
       or read_data_0[63:0]
       or read_data_1[63:0])
begin
  case (dp_gpr_src0_reg[4:0])
    5'd0   : gpr_dp_src0_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_dp_src0_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_dp_src0_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_dp_src0_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_dp_src0_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_dp_src0_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_dp_src0_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_dp_src0_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_dp_src0_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_dp_src0_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_dp_src0_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_dp_src0_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_dp_src0_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_dp_src0_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_dp_src0_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_dp_src0_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_dp_src0_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_dp_src0_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_dp_src0_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_dp_src0_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_dp_src0_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_dp_src0_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_dp_src0_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_dp_src0_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_dp_src0_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_dp_src0_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_dp_src0_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_dp_src0_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_dp_src0_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_dp_src0_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_dp_src0_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_dp_src0_data[63:0] = read_data_31[63:0];
    default: gpr_dp_src0_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @183
end

//----------------------------------------------------------
//                     Source 1 Read
//----------------------------------------------------------
// &Force("bus","dp_gpr_src1_reg",5,0); @188
// &CombBeg; @189
always @( read_data_15[63:0]
       or read_data_27[63:0]
       or read_data_29[63:0]
       or read_data_25[63:0]
       or read_data_23[63:0]
       or read_data_30[63:0]
       or read_data_7[63:0]
       or read_data_14[63:0]
       or read_data_28[63:0]
       or read_data_21[63:0]
       or read_data_19[63:0]
       or read_data_24[63:0]
       or read_data_17[63:0]
       or read_data_10[63:0]
       or read_data_3[63:0]
       or read_data_8[63:0]
       or read_data_16[63:0]
       or read_data_22[63:0]
       or read_data_26[63:0]
       or read_data_18[63:0]
       or read_data_20[63:0]
       or read_data_11[63:0]
       or read_data_6[63:0]
       or read_data_31[63:0]
       or read_data_2[63:0]
       or read_data_5[63:0]
       or read_data_13[63:0]
       or read_data_4[63:0]
       or read_data_12[63:0]
       or read_data_9[63:0]
       or read_data_0[63:0]
       or read_data_1[63:0]
       or dp_gpr_src1_reg[4:0])
begin
  case (dp_gpr_src1_reg[4:0])
    5'd0   : gpr_dp_src1_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_dp_src1_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_dp_src1_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_dp_src1_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_dp_src1_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_dp_src1_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_dp_src1_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_dp_src1_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_dp_src1_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_dp_src1_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_dp_src1_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_dp_src1_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_dp_src1_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_dp_src1_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_dp_src1_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_dp_src1_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_dp_src1_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_dp_src1_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_dp_src1_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_dp_src1_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_dp_src1_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_dp_src1_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_dp_src1_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_dp_src1_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_dp_src1_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_dp_src1_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_dp_src1_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_dp_src1_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_dp_src1_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_dp_src1_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_dp_src1_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_dp_src1_data[63:0] = read_data_31[63:0];
    default: gpr_dp_src1_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @225
end

//----------------------------------------------------------
//                     Source 2 Read
//----------------------------------------------------------
// &Force("bus","dp_gpr_src2_reg",5,0); @230
// &CombBeg; @231
always @( read_data_15[63:0]
       or read_data_27[63:0]
       or read_data_29[63:0]
       or read_data_25[63:0]
       or read_data_23[63:0]
       or read_data_30[63:0]
       or read_data_7[63:0]
       or read_data_14[63:0]
       or read_data_28[63:0]
       or read_data_21[63:0]
       or read_data_19[63:0]
       or read_data_24[63:0]
       or read_data_17[63:0]
       or read_data_10[63:0]
       or read_data_3[63:0]
       or read_data_8[63:0]
       or read_data_16[63:0]
       or read_data_22[63:0]
       or read_data_26[63:0]
       or read_data_18[63:0]
       or read_data_20[63:0]
       or read_data_11[63:0]
       or read_data_6[63:0]
       or read_data_31[63:0]
       or read_data_2[63:0]
       or read_data_5[63:0]
       or read_data_13[63:0]
       or read_data_4[63:0]
       or read_data_12[63:0]
       or read_data_9[63:0]
       or read_data_0[63:0]
       or read_data_1[63:0]
       or dp_gpr_src2_reg[4:0])
begin
  case (dp_gpr_src2_reg[4:0])
    5'd0   : gpr_dp_src2_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_dp_src2_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_dp_src2_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_dp_src2_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_dp_src2_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_dp_src2_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_dp_src2_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_dp_src2_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_dp_src2_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_dp_src2_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_dp_src2_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_dp_src2_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_dp_src2_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_dp_src2_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_dp_src2_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_dp_src2_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_dp_src2_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_dp_src2_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_dp_src2_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_dp_src2_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_dp_src2_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_dp_src2_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_dp_src2_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_dp_src2_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_dp_src2_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_dp_src2_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_dp_src2_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_dp_src2_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_dp_src2_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_dp_src2_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_dp_src2_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_dp_src2_data[63:0] = read_data_31[63:0];
    default: gpr_dp_src2_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @267
end

// &ModuleEnd; @269
endmodule


