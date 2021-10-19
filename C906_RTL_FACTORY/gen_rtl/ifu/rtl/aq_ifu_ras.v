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
module aq_ifu_ras(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  iu_ifu_bht_mispred,
  iu_ifu_bht_mispred_gate,
  iu_ifu_link_vld,
  iu_ifu_link_vld_gate,
  iu_ifu_pc_mispred,
  iu_ifu_pc_mispred_gate,
  iu_ifu_ret_vld,
  iu_ifu_ret_vld_gate,
  pad_yy_icg_scan_en,
  pred_ras_link_pc,
  pred_ras_link_vld,
  pred_ras_ret_vld,
  ras_cur_st,
  ras_pred_tar_pc,
  rtu_ifu_flush_fe
);

// &Ports; @24
input           cp0_ifu_icg_en;         
input           cp0_yy_clk_en;          
input           cpurst_b;               
input           forever_cpuclk;         
input           iu_ifu_bht_mispred;     
input           iu_ifu_bht_mispred_gate; 
input           iu_ifu_link_vld;        
input           iu_ifu_link_vld_gate;   
input           iu_ifu_pc_mispred;      
input           iu_ifu_pc_mispred_gate; 
input           iu_ifu_ret_vld;         
input           iu_ifu_ret_vld_gate;    
input           pad_yy_icg_scan_en;     
input   [23:0]  pred_ras_link_pc;       
input           pred_ras_link_vld;      
input           pred_ras_ret_vld;       
input           ras_cur_st;             
input           rtu_ifu_flush_fe;       
output  [23:0]  ras_pred_tar_pc;        

// &Regs; @25
reg     [3 :0]  ras_bju;                
reg     [3 :0]  ras_pop;                
reg     [23:0]  ras_tar_pc;             

// &Wires; @26
wire            cp0_ifu_icg_en;         
wire            cp0_yy_clk_en;          
wire            cpurst_b;               
wire    [23:0]  entry0_pc;              
wire            entry0_upd;             
wire    [23:0]  entry1_pc;              
wire            entry1_upd;             
wire    [23:0]  entry2_pc;              
wire            entry2_upd;             
wire    [23:0]  entry3_pc;              
wire            entry3_upd;             
wire            forever_cpuclk;         
wire            iu_ifu_bht_mispred;     
wire            iu_ifu_bht_mispred_gate; 
wire            iu_ifu_link_vld;        
wire            iu_ifu_link_vld_gate;   
wire            iu_ifu_pc_mispred;      
wire            iu_ifu_pc_mispred_gate; 
wire            iu_ifu_ret_vld;         
wire            iu_ifu_ret_vld_gate;    
wire            pad_yy_icg_scan_en;     
wire    [23:0]  pred_ras_link_pc;       
wire            pred_ras_link_vld;      
wire            pred_ras_ret_vld;       
wire            ras_cpuclk;             
wire            ras_cur_st;             
wire            ras_icg_en;             
wire    [23:0]  ras_pred_tar_pc;        
wire    [23:0]  ras_upd_pc;             
wire            rtu_ifu_flush_fe;       


//==========================================================
// Return Address Stack Module
// 1. Instance ICG Cell
// 2. Instance RAS Entries
// 3. RAS Read Port
// 4. RAS Write Port
// 5. Generate Change Flow
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign ras_icg_en = pred_ras_ret_vld 
                  | pred_ras_link_vld
                  | rtu_ifu_flush_fe | iu_ifu_bht_mispred_gate 
                  | iu_ifu_pc_mispred_gate
                  | iu_ifu_link_vld_gate | iu_ifu_ret_vld_gate;
// &Instance("gated_clk_cell", "x_aq_ifu_ras_icg_cell"); @45
gated_clk_cell  x_aq_ifu_ras_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ras_cpuclk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ras_icg_en        ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @46
//          .external_en (1'b0), @47
//          .global_en   (cp0_yy_clk_en), @48
//          .module_en   (cp0_ifu_icg_en), @49
//          .local_en    (ras_icg_en), @50
//          .clk_out     (ras_cpuclk) @51
//         ); @52

//------------------------------------------------
// 2. Instance RAS Entries
//------------------------------------------------
parameter ENTRY_NUM = 4;

// &ConnRule(s/ras_entry/entry0/); @59
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry0"); @60
aq_ifu_ras_entry  x_aq_ifu_ras_entry0 (
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .ras_entry_pc       (entry0_pc         ),
  .ras_entry_upd      (entry0_upd        ),
  .ras_upd_pc         (ras_upd_pc        )
);


// &ConnRule(s/ras_entry/entry1/); @62
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry1"); @63
aq_ifu_ras_entry  x_aq_ifu_ras_entry1 (
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .ras_entry_pc       (entry1_pc         ),
  .ras_entry_upd      (entry1_upd        ),
  .ras_upd_pc         (ras_upd_pc        )
);


// &ConnRule(s/ras_entry/entry2/); @65
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry2"); @66
aq_ifu_ras_entry  x_aq_ifu_ras_entry2 (
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .ras_entry_pc       (entry2_pc         ),
  .ras_entry_upd      (entry2_upd        ),
  .ras_upd_pc         (ras_upd_pc        )
);


// &ConnRule(s/ras_entry/entry3/); @68
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry3"); @69
aq_ifu_ras_entry  x_aq_ifu_ras_entry3 (
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .ras_entry_pc       (entry3_pc         ),
  .ras_entry_upd      (entry3_upd        ),
  .ras_upd_pc         (ras_upd_pc        )
);


// &ConnRule(s/ras_entry/entry4/); @72
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry4"); @73
// &ConnRule(s/ras_entry/entry5/); @75
// &Instance("aq_ifu_ras_entry","x_aq_ifu_ras_entry5"); @76

//------------------------------------------------
// 3. RAS Read Port
//------------------------------------------------
always@(posedge ras_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_pop[ENTRY_NUM-1:0] <= {{ENTRY_NUM-1{1'b0}}, 1'b1};
  else if(rtu_ifu_flush_fe || iu_ifu_bht_mispred || iu_ifu_pc_mispred && !iu_ifu_link_vld)
    ras_pop[ENTRY_NUM-1:0] <= ras_bju[ENTRY_NUM-1:0];
  else if(pred_ras_link_vld)
    ras_pop[ENTRY_NUM-1:0] <= {ras_pop[0], ras_pop[ENTRY_NUM-1:1]};
  else if(pred_ras_ret_vld && !ras_cur_st)
    ras_pop[ENTRY_NUM-1:0] <= {ras_pop[ENTRY_NUM-2:0], ras_pop[ENTRY_NUM-1]};
  else
    ras_pop[ENTRY_NUM-1:0] <= ras_pop[ENTRY_NUM-1:0];
end

always@(posedge ras_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_bju[ENTRY_NUM-1:0] <= {{ENTRY_NUM-1{1'b0}}, 1'b1};
  else if(iu_ifu_link_vld && !rtu_ifu_flush_fe)
    ras_bju[ENTRY_NUM-1:0] <= {ras_bju[0], ras_bju[ENTRY_NUM-1:1]};
  else if(iu_ifu_ret_vld && !rtu_ifu_flush_fe)
    ras_bju[ENTRY_NUM-1:0] <= {ras_bju[ENTRY_NUM-2:0], ras_bju[ENTRY_NUM-1]};
  else
    ras_bju[ENTRY_NUM-1:0] <= ras_bju[ENTRY_NUM-1:0];
end

// &CombBeg; @109
// &CombEnd; @119
// &CombBeg; @121
always @( entry0_pc[23:0]
       or ras_pop[3:0]
       or entry3_pc[23:0]
       or entry2_pc[23:0]
       or entry1_pc[23:0])
begin
case(ras_pop[3:0])
  4'b0001: ras_tar_pc[23:0] = entry0_pc[23:0];
  4'b0010: ras_tar_pc[23:0] = entry1_pc[23:0];
  4'b0100: ras_tar_pc[23:0] = entry2_pc[23:0];
  4'b1000: ras_tar_pc[23:0] = entry3_pc[23:0];
  default: ras_tar_pc[23:0] = 24'bx;
endcase
// &CombEnd; @129
end

//------------------------------------------------
// 4. RAS Write Port
//------------------------------------------------
assign entry3_upd = pred_ras_link_vld && ras_pop[0];
assign entry2_upd = pred_ras_link_vld && ras_pop[3];
assign entry1_upd = pred_ras_link_vld && ras_pop[2];
assign entry0_upd = pred_ras_link_vld && ras_pop[1];
assign ras_upd_pc[23:0] = pred_ras_link_pc[23:0];

//==========================================================
// Rename for Output
//==========================================================

// Output to id prediction
assign ras_pred_tar_pc[23:0] = ras_tar_pc[23:0];

// &ModuleEnd; @154
endmodule


