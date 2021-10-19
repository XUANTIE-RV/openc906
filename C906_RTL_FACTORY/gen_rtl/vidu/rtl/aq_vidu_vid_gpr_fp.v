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
module aq_vidu_vid_gpr_fp(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  dp_gpr_fp_src0_reg,
  dp_gpr_fp_src1_reg,
  dp_gpr_fp_src2_reg,
  forever_cpuclk,
  gpr_fp_dp_src0_data,
  gpr_fp_dp_src1_data,
  gpr_fp_dp_src2_data,
  pad_yy_icg_scan_en,
  vpu_vidu_fp_wb_data,
  vpu_vidu_fp_wb_reg,
  vpu_vidu_fp_wb_vld
);

// &Ports; @24
input           cp0_idu_icg_en;           
input           cp0_yy_clk_en;            
input   [4 :0]  dp_gpr_fp_src0_reg;       
input   [4 :0]  dp_gpr_fp_src1_reg;       
input   [4 :0]  dp_gpr_fp_src2_reg;       
input           forever_cpuclk;           
input           pad_yy_icg_scan_en;       
input   [63:0]  vpu_vidu_fp_wb_data;      
input   [4 :0]  vpu_vidu_fp_wb_reg;       
input           vpu_vidu_fp_wb_vld;       
output  [63:0]  gpr_fp_dp_src0_data;      
output  [63:0]  gpr_fp_dp_src1_data;      
output  [63:0]  gpr_fp_dp_src2_data;      

// &Regs; @25
reg     [63:0]  gpr_fp_dp_src0_data;      
reg     [63:0]  gpr_fp_dp_src1_data;      
reg     [63:0]  gpr_fp_dp_src2_data;      

// &Wires; @26
wire            cp0_idu_icg_en;           
wire            cp0_yy_clk_en;            
wire    [4 :0]  dp_gpr_fp_src0_reg;       
wire    [4 :0]  dp_gpr_fp_src1_reg;       
wire    [4 :0]  dp_gpr_fp_src2_reg;       
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
wire    [63:0]  vpu_vidu_fp_wb_data;      
wire    [4 :0]  vpu_vidu_fp_wb_reg;       
wire    [31:0]  vpu_vidu_fp_wb_reg_expand; 
wire            vpu_vidu_fp_wb_vld;       
wire    [31:0]  wb_vld;                   



//==========================================================
//                  Instance Entries
//==========================================================
//----------------------------------------------------------
//                      Entry 0~31
//----------------------------------------------------------
// &ConnRule(s/_x$/[0]/); @35
// &ConnRule(s/_y$/_0/); @36
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_0"); @37
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_0 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_0        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[0]          )
);

// &ConnRule(s/_x$/[1]/); @38
// &ConnRule(s/_y$/_1/); @39
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_1"); @40
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_1 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_1        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[1]          )
);

// &ConnRule(s/_x$/[2]/); @41
// &ConnRule(s/_y$/_2/); @42
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_2"); @43
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_2 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_2        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[2]          )
);

// &ConnRule(s/_x$/[3]/); @44
// &ConnRule(s/_y$/_3/); @45
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_3"); @46
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_3 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_3        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[3]          )
);

// &ConnRule(s/_x$/[4]/); @47
// &ConnRule(s/_y$/_4/); @48
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_4"); @49
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_4 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_4        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[4]          )
);

// &ConnRule(s/_x$/[5]/); @50
// &ConnRule(s/_y$/_5/); @51
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_5"); @52
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_5 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_5        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[5]          )
);

// &ConnRule(s/_x$/[6]/); @53
// &ConnRule(s/_y$/_6/); @54
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_6"); @55
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_6 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_6        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[6]          )
);

// &ConnRule(s/_x$/[7]/); @56
// &ConnRule(s/_y$/_7/); @57
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_7"); @58
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_7 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_7        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[7]          )
);

// &ConnRule(s/_x$/[8]/); @59
// &ConnRule(s/_y$/_8/); @60
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_8"); @61
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_8 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_8        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[8]          )
);

// &ConnRule(s/_x$/[9]/); @62
// &ConnRule(s/_y$/_9/); @63
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_9"); @64
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_9 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_9        ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[9]          )
);

// &ConnRule(s/_x$/[10]/); @65
// &ConnRule(s/_y$/_10/); @66
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_10"); @67
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_10 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_10       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[10]         )
);

// &ConnRule(s/_x$/[11]/); @68
// &ConnRule(s/_y$/_11/); @69
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_11"); @70
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_11 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_11       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[11]         )
);

// &ConnRule(s/_x$/[12]/); @71
// &ConnRule(s/_y$/_12/); @72
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_12"); @73
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_12 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_12       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[12]         )
);

// &ConnRule(s/_x$/[13]/); @74
// &ConnRule(s/_y$/_13/); @75
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_13"); @76
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_13 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_13       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[13]         )
);

// &ConnRule(s/_x$/[14]/); @77
// &ConnRule(s/_y$/_14/); @78
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_14"); @79
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_14 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_14       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[14]         )
);

// &ConnRule(s/_x$/[15]/); @80
// &ConnRule(s/_y$/_15/); @81
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_15"); @82
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_15 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_15       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[15]         )
);

// &ConnRule(s/_x$/[16]/); @83
// &ConnRule(s/_y$/_16/); @84
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_16"); @85
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_16 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_16       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[16]         )
);

// &ConnRule(s/_x$/[17]/); @86
// &ConnRule(s/_y$/_17/); @87
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_17"); @88
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_17 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_17       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[17]         )
);

// &ConnRule(s/_x$/[18]/); @89
// &ConnRule(s/_y$/_18/); @90
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_18"); @91
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_18 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_18       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[18]         )
);

// &ConnRule(s/_x$/[19]/); @92
// &ConnRule(s/_y$/_19/); @93
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_19"); @94
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_19 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_19       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[19]         )
);

// &ConnRule(s/_x$/[20]/); @95
// &ConnRule(s/_y$/_20/); @96
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_20"); @97
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_20 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_20       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[20]         )
);

// &ConnRule(s/_x$/[21]/); @98
// &ConnRule(s/_y$/_21/); @99
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_21"); @100
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_21 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_21       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[21]         )
);

// &ConnRule(s/_x$/[22]/); @101
// &ConnRule(s/_y$/_22/); @102
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_22"); @103
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_22 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_22       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[22]         )
);

// &ConnRule(s/_x$/[23]/); @104
// &ConnRule(s/_y$/_23/); @105
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_23"); @106
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_23 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_23       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[23]         )
);

// &ConnRule(s/_x$/[24]/); @107
// &ConnRule(s/_y$/_24/); @108
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_24"); @109
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_24 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_24       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[24]         )
);

// &ConnRule(s/_x$/[25]/); @110
// &ConnRule(s/_y$/_25/); @111
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_25"); @112
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_25 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_25       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[25]         )
);

// &ConnRule(s/_x$/[26]/); @113
// &ConnRule(s/_y$/_26/); @114
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_26"); @115
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_26 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_26       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[26]         )
);

// &ConnRule(s/_x$/[27]/); @116
// &ConnRule(s/_y$/_27/); @117
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_27"); @118
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_27 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_27       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[27]         )
);

// &ConnRule(s/_x$/[28]/); @119
// &ConnRule(s/_y$/_28/); @120
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_28"); @121
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_28 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_28       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[28]         )
);

// &ConnRule(s/_x$/[29]/); @122
// &ConnRule(s/_y$/_29/); @123
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_29"); @124
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_29 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_29       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[29]         )
);

// &ConnRule(s/_x$/[30]/); @125
// &ConnRule(s/_y$/_30/); @126
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_30"); @127
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_30 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_30       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[30]         )
);

// &ConnRule(s/_x$/[31]/); @128
// &ConnRule(s/_y$/_31/); @129
// &Instance("aq_vidu_vid_gpr_reg_fp","x_aq_vidu_vid_gpr_reg_fp_31"); @130
aq_vidu_vid_gpr_reg_fp  x_aq_vidu_vid_gpr_reg_fp_31 (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .read_data_y         (read_data_31       ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .wb_vld_x            (wb_vld[31]         )
);


//==========================================================
//                       Write Port
//==========================================================
// &ConnRule(s/^x_num/vpu_vidu_fp_wb_reg/); @135
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_vpu_vidu_fp_wb_reg"); @136
aq_idu_expand_32  x_aq_idu_expand_32_vpu_vidu_fp_wb_reg (
  .x_num                     (vpu_vidu_fp_wb_reg       ),
  .x_num_expand              (vpu_vidu_fp_wb_reg_expand)
);


assign wb_vld[31:0] = vpu_vidu_fp_wb_reg_expand[31:0] & {32{vpu_vidu_fp_wb_vld}};

//==========================================================
//                       Read Port
//==========================================================
//----------------------------------------------------------
//                     Source 0 Read
//----------------------------------------------------------
// &CombBeg; @146
always @( read_data_15[63:0]
       or read_data_27[63:0]
       or read_data_29[63:0]
       or read_data_25[63:0]
       or read_data_23[63:0]
       or read_data_30[63:0]
       or read_data_7[63:0]
       or read_data_14[63:0]
       or dp_gpr_fp_src0_reg[4:0]
       or read_data_28[63:0]
       or read_data_19[63:0]
       or read_data_21[63:0]
       or read_data_17[63:0]
       or read_data_24[63:0]
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
       or read_data_1[63:0])
begin
  case (dp_gpr_fp_src0_reg[4:0])
    5'd0   : gpr_fp_dp_src0_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_fp_dp_src0_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_fp_dp_src0_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_fp_dp_src0_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_fp_dp_src0_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_fp_dp_src0_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_fp_dp_src0_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_fp_dp_src0_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_fp_dp_src0_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_fp_dp_src0_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_fp_dp_src0_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_fp_dp_src0_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_fp_dp_src0_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_fp_dp_src0_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_fp_dp_src0_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_fp_dp_src0_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_fp_dp_src0_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_fp_dp_src0_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_fp_dp_src0_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_fp_dp_src0_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_fp_dp_src0_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_fp_dp_src0_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_fp_dp_src0_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_fp_dp_src0_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_fp_dp_src0_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_fp_dp_src0_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_fp_dp_src0_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_fp_dp_src0_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_fp_dp_src0_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_fp_dp_src0_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_fp_dp_src0_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_fp_dp_src0_data[63:0] = read_data_31[63:0];
    default: gpr_fp_dp_src0_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @182
end

//----------------------------------------------------------
//                     Source 1 Read
//----------------------------------------------------------
// &CombBeg; @187
always @( read_data_15[63:0]
       or read_data_27[63:0]
       or read_data_29[63:0]
       or read_data_25[63:0]
       or read_data_23[63:0]
       or read_data_30[63:0]
       or dp_gpr_fp_src1_reg[4:0]
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
       or read_data_1[63:0])
begin
  case (dp_gpr_fp_src1_reg[4:0])
    5'd0   : gpr_fp_dp_src1_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_fp_dp_src1_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_fp_dp_src1_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_fp_dp_src1_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_fp_dp_src1_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_fp_dp_src1_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_fp_dp_src1_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_fp_dp_src1_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_fp_dp_src1_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_fp_dp_src1_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_fp_dp_src1_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_fp_dp_src1_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_fp_dp_src1_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_fp_dp_src1_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_fp_dp_src1_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_fp_dp_src1_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_fp_dp_src1_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_fp_dp_src1_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_fp_dp_src1_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_fp_dp_src1_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_fp_dp_src1_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_fp_dp_src1_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_fp_dp_src1_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_fp_dp_src1_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_fp_dp_src1_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_fp_dp_src1_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_fp_dp_src1_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_fp_dp_src1_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_fp_dp_src1_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_fp_dp_src1_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_fp_dp_src1_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_fp_dp_src1_data[63:0] = read_data_31[63:0];
    default: gpr_fp_dp_src1_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @223
end

//----------------------------------------------------------
//                     Source 2 Read
//----------------------------------------------------------
// &CombBeg; @228
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
       or dp_gpr_fp_src2_reg[4:0]
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
       or read_data_1[63:0])
begin
  case (dp_gpr_fp_src2_reg[4:0])
    5'd0   : gpr_fp_dp_src2_data[63:0] = read_data_0[63:0];
    5'd1   : gpr_fp_dp_src2_data[63:0] = read_data_1[63:0];
    5'd2   : gpr_fp_dp_src2_data[63:0] = read_data_2[63:0];
    5'd3   : gpr_fp_dp_src2_data[63:0] = read_data_3[63:0];
    5'd4   : gpr_fp_dp_src2_data[63:0] = read_data_4[63:0];
    5'd5   : gpr_fp_dp_src2_data[63:0] = read_data_5[63:0];
    5'd6   : gpr_fp_dp_src2_data[63:0] = read_data_6[63:0];
    5'd7   : gpr_fp_dp_src2_data[63:0] = read_data_7[63:0];
    5'd8   : gpr_fp_dp_src2_data[63:0] = read_data_8[63:0];
    5'd9   : gpr_fp_dp_src2_data[63:0] = read_data_9[63:0];
    5'd10  : gpr_fp_dp_src2_data[63:0] = read_data_10[63:0];
    5'd11  : gpr_fp_dp_src2_data[63:0] = read_data_11[63:0];
    5'd12  : gpr_fp_dp_src2_data[63:0] = read_data_12[63:0];
    5'd13  : gpr_fp_dp_src2_data[63:0] = read_data_13[63:0];
    5'd14  : gpr_fp_dp_src2_data[63:0] = read_data_14[63:0];
    5'd15  : gpr_fp_dp_src2_data[63:0] = read_data_15[63:0];
    5'd16  : gpr_fp_dp_src2_data[63:0] = read_data_16[63:0];
    5'd17  : gpr_fp_dp_src2_data[63:0] = read_data_17[63:0];
    5'd18  : gpr_fp_dp_src2_data[63:0] = read_data_18[63:0];
    5'd19  : gpr_fp_dp_src2_data[63:0] = read_data_19[63:0];
    5'd20  : gpr_fp_dp_src2_data[63:0] = read_data_20[63:0];
    5'd21  : gpr_fp_dp_src2_data[63:0] = read_data_21[63:0];
    5'd22  : gpr_fp_dp_src2_data[63:0] = read_data_22[63:0];
    5'd23  : gpr_fp_dp_src2_data[63:0] = read_data_23[63:0];
    5'd24  : gpr_fp_dp_src2_data[63:0] = read_data_24[63:0];
    5'd25  : gpr_fp_dp_src2_data[63:0] = read_data_25[63:0];
    5'd26  : gpr_fp_dp_src2_data[63:0] = read_data_26[63:0];
    5'd27  : gpr_fp_dp_src2_data[63:0] = read_data_27[63:0];
    5'd28  : gpr_fp_dp_src2_data[63:0] = read_data_28[63:0];
    5'd29  : gpr_fp_dp_src2_data[63:0] = read_data_29[63:0];
    5'd30  : gpr_fp_dp_src2_data[63:0] = read_data_30[63:0];
    5'd31  : gpr_fp_dp_src2_data[63:0] = read_data_31[63:0];
    default: gpr_fp_dp_src2_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @264
end

// &ModuleEnd; @266
endmodule


