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

// &ModuleBeg; @24
module aq_vpu_group_unit(
  group_index,
  viq0_xx_ex1_eu_sel,
  viq0_xx_ex1_func,
  viq0_xx_ex1_gp_sel,
  viq0_xx_ex1_id_reg,
  viq0_xx_ex1_rm,
  viq0_xx_ex1_srcv0,
  viq0_xx_ex1_srcv0_type,
  viq0_xx_ex1_srcv1,
  viq0_xx_ex1_srcv1_type,
  viq0_xx_ex1_srcv2,
  viq0_xx_ex1_srcv2_type,
  viq0_xx_ex2_eu_sel,
  viq0_xx_ex2_func,
  viq0_xx_ex2_gp_sel,
  viq0_xx_ex2_rm,
  viq0_xx_ex2_stall,
  viq0_xx_ex3_eu_sel,
  viq0_xx_ex3_func,
  viq0_xx_ex3_gp_sel,
  viq0_xx_ex3_rm,
  viq0_xx_ex3_stall,
  viq0_xx_ex4_eu_sel,
  viq0_xx_ex4_func,
  viq0_xx_ex4_gp_sel,
  viq0_xx_ex4_rm,
  viq0_xx_ex4_stall,
  vpu_group_x_xx_ex1_eu_sel,
  vpu_group_x_xx_ex1_func,
  vpu_group_x_xx_ex1_id_reg,
  vpu_group_x_xx_ex1_rm,
  vpu_group_x_xx_ex1_sel,
  vpu_group_x_xx_ex1_srcv0,
  vpu_group_x_xx_ex1_srcv0_type,
  vpu_group_x_xx_ex1_srcv1,
  vpu_group_x_xx_ex1_srcv1_type,
  vpu_group_x_xx_ex1_srcv2,
  vpu_group_x_xx_ex1_srcv2_type,
  vpu_group_x_xx_ex2_eu_sel,
  vpu_group_x_xx_ex2_func,
  vpu_group_x_xx_ex2_rm,
  vpu_group_x_xx_ex2_sel,
  vpu_group_x_xx_ex2_stall,
  vpu_group_x_xx_ex3_eu_sel,
  vpu_group_x_xx_ex3_func,
  vpu_group_x_xx_ex3_rm,
  vpu_group_x_xx_ex3_sel,
  vpu_group_x_xx_ex3_stall,
  vpu_group_x_xx_ex4_eu_sel,
  vpu_group_x_xx_ex4_func,
  vpu_group_x_xx_ex4_rm,
  vpu_group_x_xx_ex4_sel,
  vpu_group_x_xx_ex4_stall
);

// &Ports; @25
input   [3 :0]  group_index;                  
input   [9 :0]  viq0_xx_ex1_eu_sel;           
input   [19:0]  viq0_xx_ex1_func;             
input   [3 :0]  viq0_xx_ex1_gp_sel;           
input   [1 :0]  viq0_xx_ex1_id_reg;           
input   [2 :0]  viq0_xx_ex1_rm;               
input   [63:0]  viq0_xx_ex1_srcv0;            
input   [47:0]  viq0_xx_ex1_srcv0_type;       
input   [63:0]  viq0_xx_ex1_srcv1;            
input   [47:0]  viq0_xx_ex1_srcv1_type;       
input   [63:0]  viq0_xx_ex1_srcv2;            
input   [47:0]  viq0_xx_ex1_srcv2_type;       
input   [9 :0]  viq0_xx_ex2_eu_sel;           
input   [19:0]  viq0_xx_ex2_func;             
input   [3 :0]  viq0_xx_ex2_gp_sel;           
input   [2 :0]  viq0_xx_ex2_rm;               
input           viq0_xx_ex2_stall;            
input   [9 :0]  viq0_xx_ex3_eu_sel;           
input   [19:0]  viq0_xx_ex3_func;             
input   [3 :0]  viq0_xx_ex3_gp_sel;           
input   [2 :0]  viq0_xx_ex3_rm;               
input           viq0_xx_ex3_stall;            
input   [9 :0]  viq0_xx_ex4_eu_sel;           
input   [19:0]  viq0_xx_ex4_func;             
input   [3 :0]  viq0_xx_ex4_gp_sel;           
input   [2 :0]  viq0_xx_ex4_rm;               
input           viq0_xx_ex4_stall;            
output  [9 :0]  vpu_group_x_xx_ex1_eu_sel;    
output  [19:0]  vpu_group_x_xx_ex1_func;      
output  [1 :0]  vpu_group_x_xx_ex1_id_reg;    
output  [2 :0]  vpu_group_x_xx_ex1_rm;        
output          vpu_group_x_xx_ex1_sel;       
output  [63:0]  vpu_group_x_xx_ex1_srcv0;     
output  [47:0]  vpu_group_x_xx_ex1_srcv0_type; 
output  [63:0]  vpu_group_x_xx_ex1_srcv1;     
output  [47:0]  vpu_group_x_xx_ex1_srcv1_type; 
output  [63:0]  vpu_group_x_xx_ex1_srcv2;     
output  [47:0]  vpu_group_x_xx_ex1_srcv2_type; 
output  [9 :0]  vpu_group_x_xx_ex2_eu_sel;    
output  [19:0]  vpu_group_x_xx_ex2_func;      
output  [2 :0]  vpu_group_x_xx_ex2_rm;        
output          vpu_group_x_xx_ex2_sel;       
output          vpu_group_x_xx_ex2_stall;     
output  [9 :0]  vpu_group_x_xx_ex3_eu_sel;    
output  [19:0]  vpu_group_x_xx_ex3_func;      
output  [2 :0]  vpu_group_x_xx_ex3_rm;        
output          vpu_group_x_xx_ex3_sel;       
output          vpu_group_x_xx_ex3_stall;     
output  [9 :0]  vpu_group_x_xx_ex4_eu_sel;    
output  [19:0]  vpu_group_x_xx_ex4_func;      
output  [2 :0]  vpu_group_x_xx_ex4_rm;        
output          vpu_group_x_xx_ex4_sel;       
output          vpu_group_x_xx_ex4_stall;     

// &Regs; @26

// &Wires; @27
wire    [3 :0]  group_index;                  
wire            group_x_viq0_ex1_sel;         
wire            group_x_viq0_ex2_sel;         
wire            group_x_viq0_ex3_sel;         
wire            group_x_viq0_ex4_sel;         
wire    [9 :0]  viq0_xx_ex1_eu_sel;           
wire    [19:0]  viq0_xx_ex1_func;             
wire    [3 :0]  viq0_xx_ex1_gp_sel;           
wire    [1 :0]  viq0_xx_ex1_id_reg;           
wire    [2 :0]  viq0_xx_ex1_rm;               
wire    [63:0]  viq0_xx_ex1_srcv0;            
wire    [47:0]  viq0_xx_ex1_srcv0_type;       
wire    [63:0]  viq0_xx_ex1_srcv1;            
wire    [47:0]  viq0_xx_ex1_srcv1_type;       
wire    [63:0]  viq0_xx_ex1_srcv2;            
wire    [47:0]  viq0_xx_ex1_srcv2_type;       
wire    [9 :0]  viq0_xx_ex2_eu_sel;           
wire    [19:0]  viq0_xx_ex2_func;             
wire    [3 :0]  viq0_xx_ex2_gp_sel;           
wire    [2 :0]  viq0_xx_ex2_rm;               
wire            viq0_xx_ex2_stall;            
wire    [9 :0]  viq0_xx_ex3_eu_sel;           
wire    [19:0]  viq0_xx_ex3_func;             
wire    [3 :0]  viq0_xx_ex3_gp_sel;           
wire    [2 :0]  viq0_xx_ex3_rm;               
wire            viq0_xx_ex3_stall;            
wire    [9 :0]  viq0_xx_ex4_eu_sel;           
wire    [19:0]  viq0_xx_ex4_func;             
wire    [3 :0]  viq0_xx_ex4_gp_sel;           
wire    [2 :0]  viq0_xx_ex4_rm;               
wire            viq0_xx_ex4_stall;            
wire    [9 :0]  vpu_group_x_xx_ex1_eu_sel;    
wire    [19:0]  vpu_group_x_xx_ex1_func;      
wire    [1 :0]  vpu_group_x_xx_ex1_id_reg;    
wire    [2 :0]  vpu_group_x_xx_ex1_rm;        
wire            vpu_group_x_xx_ex1_sel;       
wire    [63:0]  vpu_group_x_xx_ex1_srcv0;     
wire    [47:0]  vpu_group_x_xx_ex1_srcv0_type; 
wire    [63:0]  vpu_group_x_xx_ex1_srcv1;     
wire    [47:0]  vpu_group_x_xx_ex1_srcv1_type; 
wire    [63:0]  vpu_group_x_xx_ex1_srcv2;     
wire    [47:0]  vpu_group_x_xx_ex1_srcv2_type; 
wire    [9 :0]  vpu_group_x_xx_ex2_eu_sel;    
wire    [19:0]  vpu_group_x_xx_ex2_func;      
wire    [2 :0]  vpu_group_x_xx_ex2_rm;        
wire            vpu_group_x_xx_ex2_sel;       
wire            vpu_group_x_xx_ex2_stall;     
wire    [9 :0]  vpu_group_x_xx_ex3_eu_sel;    
wire    [19:0]  vpu_group_x_xx_ex3_func;      
wire    [2 :0]  vpu_group_x_xx_ex3_rm;        
wire            vpu_group_x_xx_ex3_sel;       
wire            vpu_group_x_xx_ex3_stall;     
wire    [9 :0]  vpu_group_x_xx_ex4_eu_sel;    
wire    [19:0]  vpu_group_x_xx_ex4_func;      
wire    [2 :0]  vpu_group_x_xx_ex4_rm;        
wire            vpu_group_x_xx_ex4_sel;       
wire            vpu_group_x_xx_ex4_stall;     

//=======================================================================
//                           VID_EU_SEL
// VFMAU: 8'B00_0000_01;
// VMULU: 8'B00_0000_10;
// VFALU: 8'B01_0000_01;
// VALU : 8'B01_0000_10;
//
parameter GP_WIDTH   = 4;
parameter FLEN       = 64;
parameter SILEN      = 32;
parameter VREG       = 6;

// &CombBeg; @49
// &CombEnd; @118
// &Force("output","vpu_group_x_xx_ex1_vfp_srcv0"); @126
// &Force("output","vpu_group_x_xx_ex1_vfp_srcv1"); @127
// &CombBeg; @138
// &CombEnd; @180
// &CombBeg; @193
// &CombEnd; @229
// &CombBeg; @241
// &CombEnd; @277
//==========================================================
//         EX1 information
//==========================================================
assign group_x_viq0_ex1_sel                    = |(viq0_xx_ex1_gp_sel[GP_WIDTH-1:0] & group_index[3:0]);

assign vpu_group_x_xx_ex1_sel                  = group_x_viq0_ex1_sel;

assign vpu_group_x_xx_ex1_eu_sel[`EU_WIDTH-1:0]= viq0_xx_ex1_eu_sel[`EU_WIDTH-1:0];
assign vpu_group_x_xx_ex1_func[`FUNC_WIDTH-1:0]= viq0_xx_ex1_func[`FUNC_WIDTH-1:0];

assign vpu_group_x_xx_ex1_rm[2:0]              = viq0_xx_ex1_rm[2:0];

assign vpu_group_x_xx_ex1_srcv0[FLEN-1:0]      = viq0_xx_ex1_srcv0[FLEN-1:0];
assign vpu_group_x_xx_ex1_srcv1[FLEN-1:0]      = viq0_xx_ex1_srcv1[FLEN-1:0];
assign vpu_group_x_xx_ex1_srcv2[FLEN-1:0]      = viq0_xx_ex1_srcv2[FLEN-1:0];

assign vpu_group_x_xx_ex1_srcv0_type[47:0]     = viq0_xx_ex1_srcv0_type[47:0];
assign vpu_group_x_xx_ex1_srcv1_type[47:0]     = viq0_xx_ex1_srcv1_type[47:0];
assign vpu_group_x_xx_ex1_srcv2_type[47:0]     = viq0_xx_ex1_srcv2_type[47:0];

assign vpu_group_x_xx_ex1_id_reg[1:0]          = viq0_xx_ex1_id_reg[1:0];
//==========================================================
//         EX2 information
//==========================================================
assign group_x_viq0_ex2_sel                    = |(viq0_xx_ex2_gp_sel[GP_WIDTH-1:0] & group_index[3:0]);

assign vpu_group_x_xx_ex2_sel                  = group_x_viq0_ex2_sel;

assign vpu_group_x_xx_ex2_eu_sel[`EU_WIDTH-1:0]= viq0_xx_ex2_eu_sel[`EU_WIDTH-1:0];
assign vpu_group_x_xx_ex2_func[`FUNC_WIDTH-1:0]= viq0_xx_ex2_func[`FUNC_WIDTH-1:0];

assign vpu_group_x_xx_ex2_rm[2:0]              = viq0_xx_ex2_rm[2:0];

assign vpu_group_x_xx_ex2_stall                = viq0_xx_ex2_stall;

//==========================================================
//         EX3 information
//==========================================================
assign group_x_viq0_ex3_sel                    = |(viq0_xx_ex3_gp_sel[GP_WIDTH-1:0] & group_index[3:0]);

assign vpu_group_x_xx_ex3_sel                  = group_x_viq0_ex3_sel;

assign vpu_group_x_xx_ex3_eu_sel[`EU_WIDTH-1:0]= viq0_xx_ex3_eu_sel[`EU_WIDTH-1:0];
assign vpu_group_x_xx_ex3_func[`FUNC_WIDTH-1:0]= viq0_xx_ex3_func[`FUNC_WIDTH-1:0];

assign vpu_group_x_xx_ex3_rm[2:0]              = viq0_xx_ex3_rm[2:0];

assign vpu_group_x_xx_ex3_stall                = viq0_xx_ex3_stall;

//==========================================================
//         EX4 information
//==========================================================
assign group_x_viq0_ex4_sel                    = |(viq0_xx_ex4_gp_sel[GP_WIDTH-1:0] & group_index[3:0]);

assign vpu_group_x_xx_ex4_sel                  = group_x_viq0_ex4_sel;

assign vpu_group_x_xx_ex4_eu_sel[`EU_WIDTH-1:0]= viq0_xx_ex4_eu_sel[`EU_WIDTH-1:0];
assign vpu_group_x_xx_ex4_func[`FUNC_WIDTH-1:0]= viq0_xx_ex4_func[`FUNC_WIDTH-1:0];

assign vpu_group_x_xx_ex4_rm[2:0]              = viq0_xx_ex4_rm[2:0];

assign vpu_group_x_xx_ex4_stall                = viq0_xx_ex4_stall;

// &ModuleEnd; @346
endmodule




