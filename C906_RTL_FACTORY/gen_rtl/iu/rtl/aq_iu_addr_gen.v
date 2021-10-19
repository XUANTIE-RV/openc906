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
module aq_iu_addr_gen(
  ag_bju_pc,
  bju_ag_cur_pc,
  bju_ag_offset,
  bju_ag_offset_sel,
  bju_ag_use_pc,
  idu_bju_ex1_gateclk_sel,
  idu_iu_ex1_src0,
  idu_iu_ex1_src2,
  mmu_xx_mmu_en
);

// &Ports; @24
input   [39:0]  bju_ag_cur_pc;          
input   [63:0]  bju_ag_offset;          
input           bju_ag_offset_sel;      
input           bju_ag_use_pc;          
input           idu_bju_ex1_gateclk_sel; 
input   [63:0]  idu_iu_ex1_src0;        
input   [63:0]  idu_iu_ex1_src2;        
input           mmu_xx_mmu_en;          
output  [63:0]  ag_bju_pc;              

// &Regs; @25

// &Wires; @26
wire    [63:0]  ag_adder_res;           
wire    [63:0]  ag_adder_rs1;           
wire    [63:0]  ag_adder_rs1_raw;       
wire    [63:0]  ag_adder_rs2;           
wire    [63:0]  ag_bju_pc;              
wire            ag_rs1_use_pc;          
wire            ag_src_operand_mux;     
wire    [39:0]  bju_ag_cur_pc;          
wire    [63:0]  bju_ag_offset;          
wire            bju_ag_offset_sel;      
wire            bju_ag_use_pc;          
wire            idu_bju_ex1_gateclk_sel; 
wire    [63:0]  idu_iu_ex1_src0;        
wire    [63:0]  idu_iu_ex1_src2;        
wire            mmu_xx_mmu_en;          


// &Force("bus", "bju_ag_cur_pc", 39, 0); @28
//==========================================================
//                   Address Generator
//==========================================================
// Address Generator generate address for:
//   1. jump, branch inst;
//   2. auipc inst;

//----------------------------------------------------------
//                  BJU Address Generator
//----------------------------------------------------------
//----------- Oper Prepare -------------
// branch inst, auipc inst use pc as rs1.
assign ag_src_operand_mux     = idu_bju_ex1_gateclk_sel;
assign ag_rs1_use_pc          = bju_ag_use_pc;

assign ag_adder_rs1_raw[63:0] = {64{ag_src_operand_mux}} & idu_iu_ex1_src0[63:0];
assign ag_adder_rs1[63:0]     = ag_rs1_use_pc ? {{24{mmu_xx_mmu_en & bju_ag_cur_pc[39]}}, bju_ag_cur_pc[39:1], 1'b0}
                                              : ag_adder_rs1_raw[63:0];

// bju entry inst, calculate tar pc
assign ag_adder_rs2[63:0]     = bju_ag_offset_sel ? bju_ag_offset[63:0] : {64{ag_src_operand_mux}} & idu_iu_ex1_src2[63:0];

//-------------- Adder -----------------
assign ag_adder_res[63:0]     = ag_adder_rs2[63:0] + ag_adder_rs1[63:0];

//---------- Rename for output ---------
assign ag_bju_pc[63:0]    = ag_adder_res[63:0];



// &ModuleEnd; @59
endmodule


