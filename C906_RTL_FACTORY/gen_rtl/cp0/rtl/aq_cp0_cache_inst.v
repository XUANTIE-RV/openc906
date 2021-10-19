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
module aq_cp0_cache_inst(
  iui_special_cache,
  iui_special_cache_func,
  special_cacheop_op,
  special_cacheop_type,
  special_dcacheop_req,
  special_icacheop_req
);


// &Ports; @25
input          iui_special_cache;     
input   [5:0]  iui_special_cache_func; 
output  [1:0]  special_cacheop_op;    
output  [1:0]  special_cacheop_type;  
output         special_dcacheop_req;  
output         special_icacheop_req;  

// &Regs; @26

// &Wires; @27
wire    [5:0]  cache_func;            
wire    [1:0]  inst_dst;              
wire    [1:0]  inst_op;               
wire    [1:0]  inst_type;             
wire           iui_special_cache;     
wire    [5:0]  iui_special_cache_func; 
wire    [1:0]  special_cacheop_op;    
wire    [1:0]  special_cacheop_type;  
wire           special_dcacheop_req;  
wire           special_icacheop_req;  


//==========================================================
//                    Cache Inst Decode
//==========================================================
parameter NOP    = 2'b00;
parameter DCHE   = 2'b01;
parameter ICHE   = 2'b10;

parameter ALL    = 2'b00;
parameter SW     = 2'b01;
parameter VA     = 2'b10;
parameter PA     = 2'b11;

parameter INV    = 2'b01;
parameter CLN    = 2'b10;
parameter CI     = 2'b11;

//==========================================================
//                   Cache Inst Decode
//==========================================================
assign cache_func[5:0] = iui_special_cache_func[5:0];
assign inst_dst[1:0]  = cache_func[1:0];
assign inst_op[1:0]   = cache_func[3:2];
assign inst_type[1:0] = cache_func[5:4];

assign special_dcacheop_req = iui_special_cache && inst_dst[0];
assign special_icacheop_req = iui_special_cache && inst_dst[1];

assign special_cacheop_type[1:0] = inst_type[1:0];
assign special_cacheop_op[1:0]   = inst_op[1:0];

// &ModuleEnd; @59
endmodule



