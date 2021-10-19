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
module aq_ifu_ipack_entry(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ipack_buf_flush,
  ipack_cpuclk,
  ipack_entry_acc_err,
  ipack_entry_create_en,
  ipack_entry_create_icg_en,
  ipack_entry_inst,
  ipack_entry_pgflt,
  ipack_entry_retire_en,
  ipack_entry_upd_acc_err,
  ipack_entry_upd_inst,
  ipack_entry_upd_pgflt,
  ipack_entry_vld,
  pad_yy_icg_scan_en
);

// &Ports; @24
input           cp0_ifu_icg_en;           
input           cp0_yy_clk_en;            
input           cpurst_b;                 
input           forever_cpuclk;           
input           ipack_buf_flush;          
input           ipack_cpuclk;             
input           ipack_entry_create_en;    
input           ipack_entry_create_icg_en; 
input           ipack_entry_retire_en;    
input           ipack_entry_upd_acc_err;  
input   [15:0]  ipack_entry_upd_inst;     
input           ipack_entry_upd_pgflt;    
input           pad_yy_icg_scan_en;       
output          ipack_entry_acc_err;      
output  [15:0]  ipack_entry_inst;         
output          ipack_entry_pgflt;        
output          ipack_entry_vld;          

// &Regs; @25
reg             entry_acc_err;            
reg     [15:0]  entry_inst;               
reg             entry_pgflt;              
reg             entry_vld;                

// &Wires; @26
wire            cp0_ifu_icg_en;           
wire            cp0_yy_clk_en;            
wire            cpurst_b;                 
wire            entry_cpuclk;             
wire            entry_icg_en;             
wire            forever_cpuclk;           
wire            ipack_buf_flush;          
wire            ipack_cpuclk;             
wire            ipack_entry_acc_err;      
wire            ipack_entry_create_en;    
wire            ipack_entry_create_icg_en; 
wire    [15:0]  ipack_entry_inst;         
wire            ipack_entry_pgflt;        
wire            ipack_entry_retire_en;    
wire            ipack_entry_upd_acc_err;  
wire    [15:0]  ipack_entry_upd_inst;     
wire            ipack_entry_upd_pgflt;    
wire            ipack_entry_vld;          
wire            pad_yy_icg_scan_en;       


//==========================================================
// Instruction Package Buffer Entry Module
// 1. Instance ICG cell 
// 2. Entry Content
//==========================================================

//------------------------------------------------
// 1. Instace ICG cell
//------------------------------------------------
assign entry_icg_en = ipack_entry_create_icg_en;
// &Instance("gated_clk_cell", "x_ipack_data_icg_cell"); @38
gated_clk_cell  x_ipack_data_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @39
//          .external_en (1'b0), @40
//          .global_en   (cp0_yy_clk_en), @41
//          .module_en ( cp0_ifu_icg_en), @42
//          .local_en    (entry_icg_en), @43
//          .clk_out     (entry_cpuclk)); @44

//------------------------------------------------
// 2. Entry Content
// a. Entry Valid Signal
// b. Entry Instruction
//------------------------------------------------
// a. Entry Valid Signal
always @(posedge ipack_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_vld <= 1'b0;
  else if(ipack_buf_flush)
    entry_vld <= 1'b0;
  else if(ipack_entry_create_en)
    entry_vld <= 1'b1;
  else if(ipack_entry_retire_en)
    entry_vld <= 1'b0;
  else
    entry_vld <= entry_vld;
end

// b. Entry Instruction
always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    entry_inst[15:0] <= 16'b0;
    entry_acc_err    <= 1'b0;
    entry_pgflt      <= 1'b0;
  end
  else if(ipack_entry_create_en)
  begin
    entry_inst[15:0] <= ipack_entry_upd_inst[15:0];
    entry_acc_err    <= ipack_entry_upd_acc_err;
    entry_pgflt      <= ipack_entry_upd_pgflt;
  end
  else
  begin
    entry_inst[15:0] <= entry_inst[15:0];
    entry_acc_err    <= entry_acc_err;
    entry_pgflt      <= entry_pgflt;
  end
end

//==========================================================
// Rename for Output
//==========================================================

assign ipack_entry_vld        = entry_vld;
assign ipack_entry_inst[15:0] = entry_inst[15:0];
assign ipack_entry_acc_err    = entry_acc_err;
assign ipack_entry_pgflt      = entry_pgflt;

// &ModuleEnd; @98
endmodule


