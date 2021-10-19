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
module aq_ifu_btb(
  btb_pcgen_tar_pc,
  btb_pred_tar_pc,
  btb_pred_tar_vld,
  btb_xx_chgflw_vld,
  cp0_ifu_btb_clr,
  cp0_ifu_btb_en,
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_btb_chgflw_vld,
  ctrl_btb_inst_fetch,
  ctrl_btb_stall,
  forever_cpuclk,
  icache_btb_grant,
  iu_ifu_tar_pc_vld,
  iu_ifu_tar_pc_vld_gate,
  pad_yy_icg_scan_en,
  pcgen_btb_ifpc,
  pred_btb_chgflw_vld,
  pred_btb_cur_pc,
  pred_btb_inst_vld,
  pred_btb_mis_pred,
  pred_btb_mis_predg,
  pred_btb_stall,
  pred_btb_tar_pc,
  pred_btb_upd_vld,
  pred_btb_upd_vldg
);

// &Ports; @24
input           cp0_ifu_btb_clr;       
input           cp0_ifu_btb_en;        
input           cp0_ifu_icg_en;        
input           cp0_yy_clk_en;         
input           cpurst_b;              
input           ctrl_btb_chgflw_vld;   
input           ctrl_btb_inst_fetch;   
input           ctrl_btb_stall;        
input           forever_cpuclk;        
input           icache_btb_grant;      
input           iu_ifu_tar_pc_vld;     
input           iu_ifu_tar_pc_vld_gate; 
input           pad_yy_icg_scan_en;    
input   [39:0]  pcgen_btb_ifpc;        
input           pred_btb_chgflw_vld;   
input   [39:0]  pred_btb_cur_pc;       
input           pred_btb_inst_vld;     
input           pred_btb_mis_pred;     
input           pred_btb_mis_predg;    
input           pred_btb_stall;        
input   [39:0]  pred_btb_tar_pc;       
input           pred_btb_upd_vld;      
input           pred_btb_upd_vldg;     
output  [39:0]  btb_pcgen_tar_pc;      
output  [39:0]  btb_pred_tar_pc;       
output          btb_pred_tar_vld;      
output          btb_xx_chgflw_vld;     

// &Regs; @25
reg     [15:0]  btb_entry_hit_flop;    
reg     [15:0]  btb_fifo;              
reg     [15:0]  btb_hit_tgt;           
reg             btb_pred_flop;         
reg     [39:0]  btb_tar_pc;            
reg             btb_tar_vld;           

// &Wires; @26
wire            btb_chgflw_vld;        
wire            btb_clk;               
wire            btb_clr_one;           
wire            btb_clr_oneg;          
wire    [15:0]  btb_entry_clr;         
wire    [15:0]  btb_entry_clrg;        
wire    [15:0]  btb_entry_rd_hit;      
wire            btb_entry_replace;     
wire            btb_entry_replaceg;    
wire    [15:0]  btb_entry_tgt_0;       
wire    [15:0]  btb_entry_tgt_1;       
wire    [15:0]  btb_entry_tgt_10;      
wire    [15:0]  btb_entry_tgt_11;      
wire    [15:0]  btb_entry_tgt_12;      
wire    [15:0]  btb_entry_tgt_13;      
wire    [15:0]  btb_entry_tgt_14;      
wire    [15:0]  btb_entry_tgt_15;      
wire    [15:0]  btb_entry_tgt_2;       
wire    [15:0]  btb_entry_tgt_3;       
wire    [15:0]  btb_entry_tgt_4;       
wire    [15:0]  btb_entry_tgt_5;       
wire    [15:0]  btb_entry_tgt_6;       
wire    [15:0]  btb_entry_tgt_7;       
wire    [15:0]  btb_entry_tgt_8;       
wire    [15:0]  btb_entry_tgt_9;       
wire    [15:0]  btb_entry_upd;         
wire            btb_entry_upd_vld;     
wire            btb_entry_upd_vldg;    
wire    [15:0]  btb_entry_updg;        
wire    [15:0]  btb_entry_wr_hit;      
wire            btb_flop_vld;          
wire            btb_icg_en;            
wire    [39:0]  btb_pcgen_tar_pc;      
wire    [39:0]  btb_pred_tar_pc;       
wire            btb_pred_tar_vld;      
wire    [15:0]  btb_rd_acc_tag;        
wire            btb_rd_hit_vld;        
wire            btb_tar_clk;           
wire            btb_tar_icg_en;        
wire    [15:0]  btb_upd_tag;           
wire    [15:0]  btb_upd_tgt;           
wire    [15:0]  btb_wr_acc_tag;        
wire            btb_wr_hit_vld;        
wire            btb_xx_chgflw_vld;     
wire            cp0_ifu_btb_clr;       
wire            cp0_ifu_btb_en;        
wire            cp0_ifu_icg_en;        
wire            cp0_yy_clk_en;         
wire            cpurst_b;              
wire            ctrl_btb_chgflw_vld;   
wire            ctrl_btb_inst_fetch;   
wire            ctrl_btb_stall;        
wire            forever_cpuclk;        
wire            icache_btb_grant;      
wire            iu_ifu_tar_pc_vld;     
wire            iu_ifu_tar_pc_vld_gate; 
wire            pad_yy_icg_scan_en;    
wire    [39:0]  pcgen_btb_ifpc;        
wire            pred_btb_chgflw_vld;   
wire    [39:0]  pred_btb_cur_pc;       
wire            pred_btb_inst_vld;     
wire            pred_btb_mis_pred;     
wire            pred_btb_mis_predg;    
wire            pred_btb_stall;        
wire    [39:0]  pred_btb_tar_pc;       
wire            pred_btb_upd_vld;      
wire            pred_btb_upd_vldg;     


parameter BTB_ADDR_WIDTH = 16;
//==========================================================
// Branch Target Buffer Module
// Register Structure
// 1. Instance ICG Cells
// 2. Instance Buffer Entries
// 3. BTB Write Port
// 4. BTB Read Port
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cells
//------------------------------------------------
assign btb_icg_en = btb_entry_upd_vldg
                 //|| btb_flop_vld
                 || ctrl_btb_inst_fetch
                 || iu_ifu_tar_pc_vld_gate
                 || btb_clr_oneg
                 || btb_pred_flop;

// &Instance("gated_clk_cell", "x_btb_icg_cell"); @48
gated_clk_cell  x_btb_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (btb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (btb_icg_en        ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @49
//           .external_en(1'b0          ), @50
//           .global_en  (cp0_yy_clk_en ), @51
//           .module_en  (1'b0          ), @52
//           .local_en   (btb_icg_en    ), @53
//           .clk_out    (btb_clk       ) @54
//          ); @55

assign btb_tar_icg_en = btb_tar_vld || btb_pred_flop;
// &Instance("gated_clk_cell", "x_ifu_btb_tar_icg_cell"); @58
gated_clk_cell  x_ifu_btb_tar_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (btb_tar_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (btb_tar_icg_en    ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @59
//          .external_en (1'b0), @60
//          .global_en   (cp0_yy_clk_en), @61
//          .module_en   (cp0_ifu_icg_en), @62
//          .local_en    (btb_tar_icg_en), @63
//          .clk_out     (btb_tar_clk) @64
//        ); @65

//------------------------------------------------
// 2. Instance Buffer Entries
//------------------------------------------------
parameter ENTRY_NUM = 16;

// &ConnRule(s/_x$/[0]/); @72
// &ConnRule(s/_y$/_0/); @73
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry0"); @74
aq_ifu_btb_entry  x_aq_ifu_btb_entry0 (
  .btb_entry_clr_x     (btb_entry_clr[0]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[0]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[0]),
  .btb_entry_tgt_y     (btb_entry_tgt_0    ),
  .btb_entry_upd_x     (btb_entry_upd[0]   ),
  .btb_entry_updg_x    (btb_entry_updg[0]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[0]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[1]/); @76
// &ConnRule(s/_y$/_1/); @77
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry1"); @78
aq_ifu_btb_entry  x_aq_ifu_btb_entry1 (
  .btb_entry_clr_x     (btb_entry_clr[1]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[1]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[1]),
  .btb_entry_tgt_y     (btb_entry_tgt_1    ),
  .btb_entry_upd_x     (btb_entry_upd[1]   ),
  .btb_entry_updg_x    (btb_entry_updg[1]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[1]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[2]/); @80
// &ConnRule(s/_y$/_2/); @81
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry2"); @82
aq_ifu_btb_entry  x_aq_ifu_btb_entry2 (
  .btb_entry_clr_x     (btb_entry_clr[2]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[2]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[2]),
  .btb_entry_tgt_y     (btb_entry_tgt_2    ),
  .btb_entry_upd_x     (btb_entry_upd[2]   ),
  .btb_entry_updg_x    (btb_entry_updg[2]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[2]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[3]/); @84
// &ConnRule(s/_y$/_3/); @85
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry3"); @86
aq_ifu_btb_entry  x_aq_ifu_btb_entry3 (
  .btb_entry_clr_x     (btb_entry_clr[3]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[3]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[3]),
  .btb_entry_tgt_y     (btb_entry_tgt_3    ),
  .btb_entry_upd_x     (btb_entry_upd[3]   ),
  .btb_entry_updg_x    (btb_entry_updg[3]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[3]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[4]/); @88
// &ConnRule(s/_y$/_4/); @89
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry4"); @90
aq_ifu_btb_entry  x_aq_ifu_btb_entry4 (
  .btb_entry_clr_x     (btb_entry_clr[4]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[4]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[4]),
  .btb_entry_tgt_y     (btb_entry_tgt_4    ),
  .btb_entry_upd_x     (btb_entry_upd[4]   ),
  .btb_entry_updg_x    (btb_entry_updg[4]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[4]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[5]/); @92
// &ConnRule(s/_y$/_5/); @93
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry5"); @94
aq_ifu_btb_entry  x_aq_ifu_btb_entry5 (
  .btb_entry_clr_x     (btb_entry_clr[5]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[5]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[5]),
  .btb_entry_tgt_y     (btb_entry_tgt_5    ),
  .btb_entry_upd_x     (btb_entry_upd[5]   ),
  .btb_entry_updg_x    (btb_entry_updg[5]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[5]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[6]/); @96
// &ConnRule(s/_y$/_6/); @97
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry6"); @98
aq_ifu_btb_entry  x_aq_ifu_btb_entry6 (
  .btb_entry_clr_x     (btb_entry_clr[6]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[6]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[6]),
  .btb_entry_tgt_y     (btb_entry_tgt_6    ),
  .btb_entry_upd_x     (btb_entry_upd[6]   ),
  .btb_entry_updg_x    (btb_entry_updg[6]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[6]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[7]/); @100
// &ConnRule(s/_y$/_7/); @101
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry7"); @102
aq_ifu_btb_entry  x_aq_ifu_btb_entry7 (
  .btb_entry_clr_x     (btb_entry_clr[7]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[7]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[7]),
  .btb_entry_tgt_y     (btb_entry_tgt_7    ),
  .btb_entry_upd_x     (btb_entry_upd[7]   ),
  .btb_entry_updg_x    (btb_entry_updg[7]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[7]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[8]/); @104
// &ConnRule(s/_y$/_8/); @105
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry8"); @106
aq_ifu_btb_entry  x_aq_ifu_btb_entry8 (
  .btb_entry_clr_x     (btb_entry_clr[8]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[8]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[8]),
  .btb_entry_tgt_y     (btb_entry_tgt_8    ),
  .btb_entry_upd_x     (btb_entry_upd[8]   ),
  .btb_entry_updg_x    (btb_entry_updg[8]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[8]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[9]/); @108
// &ConnRule(s/_y$/_9/); @109
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry9"); @110
aq_ifu_btb_entry  x_aq_ifu_btb_entry9 (
  .btb_entry_clr_x     (btb_entry_clr[9]   ),
  .btb_entry_clrg_x    (btb_entry_clrg[9]  ),
  .btb_entry_rd_hit_x  (btb_entry_rd_hit[9]),
  .btb_entry_tgt_y     (btb_entry_tgt_9    ),
  .btb_entry_upd_x     (btb_entry_upd[9]   ),
  .btb_entry_updg_x    (btb_entry_updg[9]  ),
  .btb_entry_wr_hit_x  (btb_entry_wr_hit[9]),
  .btb_rd_acc_tag      (btb_rd_acc_tag     ),
  .btb_upd_tag         (btb_upd_tag        ),
  .btb_upd_tgt         (btb_upd_tgt        ),
  .btb_wr_acc_tag      (btb_wr_acc_tag     ),
  .cp0_ifu_icg_en      (cp0_ifu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .cpurst_b            (cpurst_b           ),
  .forever_cpuclk      (forever_cpuclk     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);


// &ConnRule(s/_x$/[10]/); @112
// &ConnRule(s/_y$/_10/); @113
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry10"); @114
aq_ifu_btb_entry  x_aq_ifu_btb_entry10 (
  .btb_entry_clr_x      (btb_entry_clr[10]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[10]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[10]),
  .btb_entry_tgt_y      (btb_entry_tgt_10    ),
  .btb_entry_upd_x      (btb_entry_upd[10]   ),
  .btb_entry_updg_x     (btb_entry_updg[10]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[10]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


// &ConnRule(s/_x$/[11]/); @116
// &ConnRule(s/_y$/_11/); @117
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry11"); @118
aq_ifu_btb_entry  x_aq_ifu_btb_entry11 (
  .btb_entry_clr_x      (btb_entry_clr[11]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[11]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[11]),
  .btb_entry_tgt_y      (btb_entry_tgt_11    ),
  .btb_entry_upd_x      (btb_entry_upd[11]   ),
  .btb_entry_updg_x     (btb_entry_updg[11]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[11]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


// &ConnRule(s/_x$/[12]/); @120
// &ConnRule(s/_y$/_12/); @121
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry12"); @122
aq_ifu_btb_entry  x_aq_ifu_btb_entry12 (
  .btb_entry_clr_x      (btb_entry_clr[12]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[12]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[12]),
  .btb_entry_tgt_y      (btb_entry_tgt_12    ),
  .btb_entry_upd_x      (btb_entry_upd[12]   ),
  .btb_entry_updg_x     (btb_entry_updg[12]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[12]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


// &ConnRule(s/_x$/[13]/); @124
// &ConnRule(s/_y$/_13/); @125
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry13"); @126
aq_ifu_btb_entry  x_aq_ifu_btb_entry13 (
  .btb_entry_clr_x      (btb_entry_clr[13]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[13]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[13]),
  .btb_entry_tgt_y      (btb_entry_tgt_13    ),
  .btb_entry_upd_x      (btb_entry_upd[13]   ),
  .btb_entry_updg_x     (btb_entry_updg[13]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[13]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


// &ConnRule(s/_x$/[14]/); @128
// &ConnRule(s/_y$/_14/); @129
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry14"); @130
aq_ifu_btb_entry  x_aq_ifu_btb_entry14 (
  .btb_entry_clr_x      (btb_entry_clr[14]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[14]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[14]),
  .btb_entry_tgt_y      (btb_entry_tgt_14    ),
  .btb_entry_upd_x      (btb_entry_upd[14]   ),
  .btb_entry_updg_x     (btb_entry_updg[14]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[14]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


// &ConnRule(s/_x$/[15]/); @132
// &ConnRule(s/_y$/_15/); @133
// &Instance("aq_ifu_btb_entry","x_aq_ifu_btb_entry15"); @134
aq_ifu_btb_entry  x_aq_ifu_btb_entry15 (
  .btb_entry_clr_x      (btb_entry_clr[15]   ),
  .btb_entry_clrg_x     (btb_entry_clrg[15]  ),
  .btb_entry_rd_hit_x   (btb_entry_rd_hit[15]),
  .btb_entry_tgt_y      (btb_entry_tgt_15    ),
  .btb_entry_upd_x      (btb_entry_upd[15]   ),
  .btb_entry_updg_x     (btb_entry_updg[15]  ),
  .btb_entry_wr_hit_x   (btb_entry_wr_hit[15]),
  .btb_rd_acc_tag       (btb_rd_acc_tag      ),
  .btb_upd_tag          (btb_upd_tag         ),
  .btb_upd_tgt          (btb_upd_tgt         ),
  .btb_wr_acc_tag       (btb_wr_acc_tag      ),
  .cp0_ifu_icg_en       (cp0_ifu_icg_en      ),
  .cp0_yy_clk_en        (cp0_yy_clk_en       ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


//------------------------------------------------
// 3. BTB Write Port
// a. Clear all entries on btb clr request
// b. Update entry depending on fifo bit
//------------------------------------------------
// a. Clear all entries on btb clr request
//    Clear Corresponding entry on mis-pred
assign btb_clr_one = pred_btb_mis_pred && cp0_ifu_btb_en && btb_wr_hit_vld;
assign btb_clr_oneg = pred_btb_mis_predg && cp0_ifu_btb_en && btb_wr_hit_vld;
assign btb_entry_clr[15:0] = {16{btb_clr_one}} & btb_entry_wr_hit[15:0]
                           | {16{cp0_ifu_btb_clr}};
assign btb_entry_clrg[15:0] = {16{btb_clr_oneg}} & btb_entry_wr_hit[15:0]
                           | {16{cp0_ifu_btb_clr}};

// b. Update entry depending on fifo bit
assign btb_entry_upd_vld = pred_btb_upd_vld && cp0_ifu_btb_en;
assign btb_entry_upd_vldg = pred_btb_upd_vldg && cp0_ifu_btb_en;

always @(posedge btb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_fifo[15:0] <= 16'b1;
  else if(btb_entry_upd_vld && !btb_wr_hit_vld)
    btb_fifo[15:0] <= {btb_fifo[14:0], btb_fifo[15]};
  else if(btb_clr_one)
    btb_fifo[15:0] <= btb_entry_wr_hit[15:0];
  else
    btb_fifo[15:0] <= btb_fifo[15:0];
end
// &Force("bus", "idu_iu_ex1_cur_pc", 31, 0); @165
assign btb_entry_replace   = btb_entry_upd_vld && btb_wr_hit_vld;
assign btb_entry_replaceg  = btb_entry_upd_vldg && btb_wr_hit_vld;
assign btb_entry_upd[15:0] = btb_entry_replace
                           ? btb_entry_wr_hit[15:0]
                           : {16{btb_entry_upd_vld}} & btb_fifo[15:0];
assign btb_entry_updg[15:0] = btb_entry_replaceg
                           ? btb_entry_wr_hit[15:0]
                           : {16{btb_entry_upd_vldg}} & btb_fifo[15:0];

// update next word when unaligned 32-bit inst
// &Force("bus", "pred_btb_cur_pc", 39, 0); @176
// &Force("bus", "pred_btb_tar_pc", 39, 0); @177
assign btb_upd_tag[BTB_ADDR_WIDTH-1:0]   = pred_btb_cur_pc[BTB_ADDR_WIDTH-1:0];

assign btb_upd_tgt[BTB_ADDR_WIDTH-1:0]   = pred_btb_tar_pc[BTB_ADDR_WIDTH-1:0];

//------------------------------------------------
// 3. BTB Read Port
//------------------------------------------------
//assign btb_acc_tag[BTB_ADDR_WIDTH-1:0] = btb_entry_upd_vld || pred_btb_mis_pred
//                         ? btb_upd_tag[BTB_ADDR_WIDTH-1:0] : pcgen_btb_ifpc[BTB_ADDR_WIDTH-1:0];
assign btb_rd_acc_tag[BTB_ADDR_WIDTH-1:0] = pcgen_btb_ifpc[BTB_ADDR_WIDTH-1:0];
assign btb_wr_acc_tag[BTB_ADDR_WIDTH-1:0] = btb_upd_tag[BTB_ADDR_WIDTH-1:0];

assign btb_rd_hit_vld       = |btb_entry_rd_hit[15:0];
assign btb_wr_hit_vld       = |btb_entry_wr_hit[15:0];
assign btb_flop_vld         = ctrl_btb_inst_fetch && icache_btb_grant 
                           && btb_rd_hit_vld
                          // && !pred_btb_upd_vld
                           && !pred_btb_mis_pred;

always @ (posedge btb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_entry_hit_flop[15:0] <= 16'b0;
  else if(btb_flop_vld && !ctrl_btb_stall)
    btb_entry_hit_flop[15:0] <= btb_entry_rd_hit[15:0];
end

// &CombBeg; @205
always @( btb_entry_tgt_10[15:0]
       or btb_entry_tgt_2[15:0]
       or btb_entry_tgt_9[15:0]
       or btb_entry_tgt_5[15:0]
       or btb_entry_tgt_3[15:0]
       or btb_entry_tgt_14[15:0]
       or btb_entry_tgt_13[15:0]
       or btb_entry_tgt_7[15:0]
       or btb_entry_tgt_0[15:0]
       or btb_entry_tgt_4[15:0]
       or btb_entry_tgt_8[15:0]
       or btb_entry_tgt_12[15:0]
       or btb_entry_tgt_6[15:0]
       or btb_entry_tgt_11[15:0]
       or btb_entry_tgt_1[15:0]
       or btb_entry_tgt_15[15:0]
       or btb_entry_hit_flop[15:0])
begin
case(btb_entry_hit_flop[15:0])
  16'b0000000000000001: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_0[BTB_ADDR_WIDTH-1:0];
  16'b0000000000000010: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_1[BTB_ADDR_WIDTH-1:0];
  16'b0000000000000100: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_2[BTB_ADDR_WIDTH-1:0];
  16'b0000000000001000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_3[BTB_ADDR_WIDTH-1:0];
  16'b0000000000010000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_4[BTB_ADDR_WIDTH-1:0];
  16'b0000000000100000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_5[BTB_ADDR_WIDTH-1:0];
  16'b0000000001000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_6[BTB_ADDR_WIDTH-1:0];
  16'b0000000010000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_7[BTB_ADDR_WIDTH-1:0];
  16'b0000000100000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_8[BTB_ADDR_WIDTH-1:0];
  16'b0000001000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_9[BTB_ADDR_WIDTH-1:0];
  16'b0000010000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_10[BTB_ADDR_WIDTH-1:0];
  16'b0000100000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_11[BTB_ADDR_WIDTH-1:0];
  16'b0001000000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_12[BTB_ADDR_WIDTH-1:0];
  16'b0010000000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_13[BTB_ADDR_WIDTH-1:0];
  16'b0100000000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_14[BTB_ADDR_WIDTH-1:0];
  16'b1000000000000000: btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = btb_entry_tgt_15[BTB_ADDR_WIDTH-1:0];
  default:              btb_hit_tgt[BTB_ADDR_WIDTH-1:0] = {BTB_ADDR_WIDTH{1'bx}};
endcase
// &CombEnd; @225
end

always @(posedge btb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_pred_flop <= 1'b0;
  else if(iu_ifu_tar_pc_vld && cp0_ifu_btb_en)
    btb_pred_flop <= 1'b0;
  else if(btb_flop_vld && !ctrl_btb_stall && cp0_ifu_btb_en)
    btb_pred_flop <= 1'b1;
  else
    btb_pred_flop <= 1'b0;
end

assign btb_chgflw_vld = !pred_btb_chgflw_vld && !ctrl_btb_chgflw_vld
                     && btb_pred_flop;
always @ (posedge btb_tar_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    btb_tar_vld      <= 1'b0;
    btb_tar_pc[39:0] <= 40'b0;
  end
  else if(ctrl_btb_chgflw_vld)
  begin
    btb_tar_vld      <= 1'b0;
    btb_tar_pc[39:0] <= btb_tar_pc[39:0];
  end
  else if(btb_chgflw_vld)
  begin
    btb_tar_vld      <= 1'b1;
    btb_tar_pc[39:0] <= {pcgen_btb_ifpc[39:BTB_ADDR_WIDTH], btb_hit_tgt[BTB_ADDR_WIDTH-1:0]};
  end
  else if(btb_tar_vld && pred_btb_inst_vld && !pred_btb_stall)
  begin
    btb_tar_vld      <= 1'b0;
    btb_tar_pc[39:0] <= btb_tar_pc[39:0];
  end
end


//==========================================================
// Rename for Output
//==========================================================

// Output to pcgen
assign btb_pcgen_tar_pc[39:0] = {pcgen_btb_ifpc[39:BTB_ADDR_WIDTH], btb_hit_tgt[BTB_ADDR_WIDTH-1:0]};

// Output to pcgen
assign btb_pred_tar_vld      = btb_tar_vld;
assign btb_pred_tar_pc[39:0] = btb_tar_pc[39:0];

// Output to xx
assign btb_xx_chgflw_vld     = btb_pred_flop;


// &ModuleEnd; @304
endmodule


