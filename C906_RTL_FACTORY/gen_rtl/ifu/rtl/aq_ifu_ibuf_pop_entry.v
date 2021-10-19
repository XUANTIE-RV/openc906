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

// &Depend("aq_dtu_cfig.h"); @23
// &ModuleBeg; @24
module aq_ifu_ibuf_pop_entry(
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ibuf_cpuclk,
  ibuf_entry_acc_err,
  ibuf_entry_create_acc_err,
  ibuf_entry_create_data_en,
  ibuf_entry_create_en,
  ibuf_entry_create_halt_info,
  ibuf_entry_create_inst,
  ibuf_entry_create_pgflt,
  ibuf_entry_create_pred_taken,
  ibuf_entry_halt_info,
  ibuf_entry_inst,
  ibuf_entry_pgflt,
  ibuf_entry_pred_taken,
  ibuf_entry_retire_en,
  ibuf_entry_vld,
  ibuf_flush_en,
  pad_yy_icg_scan_en,
  vec_ibuf_warm_up
);

// &Ports; @25
input           cp0_ifu_icg_en;              
input           cp0_yy_clk_en;               
input           cpurst_b;                    
input           forever_cpuclk;              
input           ibuf_cpuclk;                 
input           ibuf_entry_create_acc_err;   
input           ibuf_entry_create_data_en;   
input           ibuf_entry_create_en;        
input   [21:0]  ibuf_entry_create_halt_info; 
input   [15:0]  ibuf_entry_create_inst;      
input           ibuf_entry_create_pgflt;     
input   [1 :0]  ibuf_entry_create_pred_taken; 
input           ibuf_entry_retire_en;        
input           ibuf_flush_en;               
input           pad_yy_icg_scan_en;          
input           vec_ibuf_warm_up;            
output          ibuf_entry_acc_err;          
output  [21:0]  ibuf_entry_halt_info;        
output  [15:0]  ibuf_entry_inst;             
output          ibuf_entry_pgflt;            
output  [1 :0]  ibuf_entry_pred_taken;       
output          ibuf_entry_vld;              

// &Regs; @26
reg             entry_acc_err;               
reg     [21:0]  entry_halt_info;             
reg     [15:0]  entry_inst;                  
reg             entry_pgflt;                 
reg     [1 :0]  entry_pred_taken;            
reg             entry_vld;                   

// &Wires; @27
wire            cp0_ifu_icg_en;              
wire            cp0_yy_clk_en;               
wire            cpurst_b;                    
wire            entry_acc_err_upd;           
wire            entry_cpuclk;                
wire            entry_create;                
wire            entry_data_create;           
wire    [21:0]  entry_halt_info_upd;         
wire            entry_icg_en;                
wire    [15:0]  entry_inst_upd;              
wire            entry_pgflt_upd;             
wire    [1 :0]  entry_pred_taken_upd;        
wire            entry_retire;                
wire            forever_cpuclk;              
wire            ibuf_cpuclk;                 
wire            ibuf_entry_acc_err;          
wire            ibuf_entry_create_acc_err;   
wire            ibuf_entry_create_data_en;   
wire            ibuf_entry_create_en;        
wire    [21:0]  ibuf_entry_create_halt_info; 
wire    [15:0]  ibuf_entry_create_inst;      
wire            ibuf_entry_create_pgflt;     
wire    [1 :0]  ibuf_entry_create_pred_taken; 
wire    [21:0]  ibuf_entry_halt_info;        
wire    [15:0]  ibuf_entry_inst;             
wire            ibuf_entry_pgflt;            
wire    [1 :0]  ibuf_entry_pred_taken;       
wire            ibuf_entry_retire_en;        
wire            ibuf_entry_vld;              
wire            ibuf_flush_en;               
wire            pad_yy_icg_scan_en;          
wire            vec_ibuf_warm_up;            


//==========================================================
// Instruction Buffer Entry Module
// 1. Instance ICG cell 
// 2. Entry Content
//==========================================================

//------------------------------------------------
// 1. Instace ICG cell
//------------------------------------------------
assign entry_icg_en = ibuf_entry_create_data_en || vec_ibuf_warm_up;
// &Instance("gated_clk_cell", "x_ibuf_data_icg_cell"); @39
gated_clk_cell  x_ibuf_data_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @40
//          .external_en (1'b0), @41
//          .global_en   (cp0_yy_clk_en), @42
//          .module_en ( cp0_ifu_icg_en), @43
//          .local_en    (entry_icg_en), @44
//          .clk_out     (entry_cpuclk)); @45

//------------------------------------------------
// 2. Entry Content
// a. Entry Create and Retire Signal
// b. Entry Valid Signal
// c. Entry Instruction
//------------------------------------------------
// a. Entry Create and Retire Signal
assign entry_create  = ibuf_entry_create_en;
assign entry_data_create = ibuf_entry_create_en;
assign entry_retire  = ibuf_entry_retire_en;

// b. Entry Valid Signal
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_vld <= 1'b0;
  else if(ibuf_flush_en)
    entry_vld <= 1'b0;
  else if(entry_create)
    entry_vld <= 1'b1;
  else if(entry_retire)
    entry_vld <= 1'b0;
  else
    entry_vld <= entry_vld;
end

// c. Entry Instruction
assign entry_inst_upd[15:0] = ibuf_entry_create_inst[15:0];

always @(posedge entry_cpuclk)
begin
  if(entry_data_create || vec_ibuf_warm_up)
    entry_inst[15:0] <= entry_inst_upd[15:0];
  else
    entry_inst[15:0] <= entry_inst[15:0];
end

//==========================================================
// Instruction Predict Taken
//==========================================================
assign entry_pred_taken_upd[1:0] = ibuf_entry_create_pred_taken[1:0];

assign entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0] = ibuf_entry_create_halt_info[`TDT_HINFO_WIDTH-1:0];

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_pred_taken[1:0] <= 2'b0;
  else if(entry_data_create)
    entry_pred_taken[1:0] <= entry_pred_taken_upd[1:0];
  else
    entry_pred_taken[1:0] <= entry_pred_taken[1:0];
end

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if(entry_data_create)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0];
  else
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//==========================================================
// Instruction Bus Access Error
//==========================================================
assign entry_acc_err_upd = ibuf_entry_create_acc_err;

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_acc_err <= 1'b0;
  else if(entry_data_create)
    entry_acc_err <= entry_acc_err_upd;
  else
    entry_acc_err <= entry_acc_err;
end

assign entry_pgflt_upd = ibuf_entry_create_pgflt;

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_pgflt <= 1'b0;
  else if(entry_data_create)
    entry_pgflt <= entry_pgflt_upd;
  else
    entry_pgflt <= entry_pgflt;
end

//==========================================================
// Rename for Output
//==========================================================

assign ibuf_entry_vld             = entry_vld;
assign ibuf_entry_inst[15:0]      = entry_inst[15:0];
assign ibuf_entry_pred_taken[1:0] = entry_pred_taken[1:0];
assign ibuf_entry_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry_halt_info[`TDT_HINFO_WIDTH-1:0];
assign ibuf_entry_acc_err         = entry_acc_err;
assign ibuf_entry_pgflt           = entry_pgflt;


// &ModuleEnd; @150
endmodule


