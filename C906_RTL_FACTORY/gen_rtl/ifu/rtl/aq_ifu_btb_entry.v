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
module aq_ifu_btb_entry(
  btb_entry_clr_x,
  btb_entry_clrg_x,
  btb_entry_rd_hit_x,
  btb_entry_tgt_y,
  btb_entry_upd_x,
  btb_entry_updg_x,
  btb_entry_wr_hit_x,
  btb_rd_acc_tag,
  btb_upd_tag,
  btb_upd_tgt,
  btb_wr_acc_tag,
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @24
input           btb_entry_clr_x;   
input           btb_entry_clrg_x;  
input           btb_entry_upd_x;   
input           btb_entry_updg_x;  
input   [15:0]  btb_rd_acc_tag;    
input   [15:0]  btb_upd_tag;       
input   [15:0]  btb_upd_tgt;       
input   [15:0]  btb_wr_acc_tag;    
input           cp0_ifu_icg_en;    
input           cp0_yy_clk_en;     
input           cpurst_b;          
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
output          btb_entry_rd_hit_x; 
output  [15:0]  btb_entry_tgt_y;   
output          btb_entry_wr_hit_x; 

// &Regs; @25
reg     [15:0]  btb_tag;           
reg     [15:0]  btb_tgt;           
reg             btb_vld;           

// &Wires; @26
wire            btb_entry_clk;     
wire            btb_entry_clr_x;   
wire            btb_entry_clrg_x;  
wire            btb_entry_rd_hit_x; 
wire    [15:0]  btb_entry_tgt_y;   
wire            btb_entry_upd_x;   
wire            btb_entry_updg_x;  
wire            btb_entry_wr_hit_x; 
wire    [15:0]  btb_rd_acc_tag;    
wire            btb_rd_hit;        
wire    [15:0]  btb_upd_tag;       
wire    [15:0]  btb_upd_tgt;       
wire    [15:0]  btb_wr_acc_tag;    
wire            btb_wr_hit;        
wire            cp0_ifu_icg_en;    
wire            cp0_yy_clk_en;     
wire            cpurst_b;          
wire            entry_clk_en;      
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 


//==========================================================
// BTB Entry Module
// 1. Instance ICG Cell
// 2. Entry Valid
// 3. Entry Content
// 4. Entry Hit
//==========================================================
parameter BTB_ADDR_WIDTH = 16;
//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign entry_clk_en = btb_entry_clrg_x
                   || btb_entry_updg_x;
// &Instance("gated_clk_cell", "x_btb_entry_icg_cell"); @41
gated_clk_cell  x_btb_entry_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (btb_entry_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @42
//           .external_en(1'b0          ), @43
//           .global_en  (cp0_yy_clk_en ), @44
//           .module_en  (cp0_ifu_icg_en), @45
//           .local_en   (entry_clk_en  ), @46
//           .clk_out    (btb_entry_clk ) @47
//          ); @48

//------------------------------------------------
// 2. Entry Valid
//------------------------------------------------
always @(posedge btb_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_vld <= 1'b0;
  else if(btb_entry_clr_x) 
    btb_vld <= 1'b0;
  else if(btb_entry_upd_x)
    btb_vld <= 1'b1;
end

//------------------------------------------------
// 3. Entry Content
//------------------------------------------------
always @(posedge btb_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    btb_tag[BTB_ADDR_WIDTH-1:0] <= {BTB_ADDR_WIDTH{1'b0}};
    btb_tgt[BTB_ADDR_WIDTH-1:0] <= {BTB_ADDR_WIDTH{1'b0}};
  end
  else if(btb_entry_upd_x)
  begin
    btb_tag[BTB_ADDR_WIDTH-1:0] <= btb_upd_tag[BTB_ADDR_WIDTH-1:0];
    btb_tgt[BTB_ADDR_WIDTH-1:0] <= btb_upd_tgt[BTB_ADDR_WIDTH-1:0];
  end
end

//------------------------------------------------
// 4. Entry Hit
//------------------------------------------------
assign btb_rd_hit = btb_tag[BTB_ADDR_WIDTH-1:0] == btb_rd_acc_tag[BTB_ADDR_WIDTH-1:0]
                 && btb_vld;
assign btb_wr_hit = btb_tag[BTB_ADDR_WIDTH-1:0] == btb_wr_acc_tag[BTB_ADDR_WIDTH-1:0]
                 && btb_vld;

//==========================================================
// Rename for Output
//==========================================================

assign btb_entry_rd_hit_x    = btb_rd_hit;
assign btb_entry_wr_hit_x    = btb_wr_hit;
assign btb_entry_tgt_y[BTB_ADDR_WIDTH-1:0] = btb_tgt[BTB_ADDR_WIDTH-1:0];

// &ModuleEnd; @96
endmodule


