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

// &Depend("aq_idu_cfig.h"); @23
// &ModuleBeg; @24
module aq_idu_id_wbt_entry(
  cpurst_b,
  create0_en_x,
  create1_en_x,
  create_clk,
  dp_wbt_dst0_type,
  dp_wbt_dst1_type,
  iu_yy_xx_cancel,
  read_data_y,
  rtu_idu_flush_wbt,
  wb_clk,
  wb_debug_x,
  wb_en_x
);

// &Ports; @25
input          cpurst_b;         
input          create0_en_x;     
input          create1_en_x;     
input          create_clk;       
input   [2:0]  dp_wbt_dst0_type; 
input   [2:0]  dp_wbt_dst1_type; 
input          iu_yy_xx_cancel;  
input          rtu_idu_flush_wbt; 
input          wb_clk;           
input          wb_en_x;          
output  [6:0]  read_data_y;      
output         wb_debug_x;       

// &Regs; @26
reg     [1:0]  cnt;              
reg     [1:0]  cnt_update_val;   
reg     [2:0]  inst_type;        
reg            wb;               

// &Wires; @27
wire           cnt_is_1;         
wire           cnt_is_2;         
wire           cpurst_b;         
wire           create0_en_x;     
wire           create1_en_x;     
wire           create_clk;       
wire           create_en;        
wire    [2:0]  create_inst_type; 
wire    [2:0]  dp_wbt_dst0_type; 
wire    [2:0]  dp_wbt_dst1_type; 
wire           iu_yy_xx_cancel;  
wire    [6:0]  read_data_y;      
wire           rtu_idu_flush_wbt; 
wire           wb_clk;           
wire           wb_debug_x;       
wire           wb_en_x;          


//==========================================================
//                     Entry Content
//==========================================================
assign create_en = (create0_en_x || create1_en_x) && !iu_yy_xx_cancel;

assign create_inst_type[2:0] = {3{create0_en_x}} & dp_wbt_dst0_type[2:0]
                             | {3{create1_en_x}} & dp_wbt_dst1_type[2:0];

//----------------------------------------------------------
//                      Write Back
//----------------------------------------------------------
always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb <= 1'b1;
  else if(rtu_idu_flush_wbt)
    wb <= 1'b1;
  else if(create_en)
    wb <= 1'b0;
  else if(wb_en_x && cnt_is_1)
    wb <= 1'b1;
  else
    wb <= wb;
end
//treat writing back as same as wb
assign read_data_y[`WB_INT_VLD]     = wb || wb_en_x && cnt_is_1;
assign read_data_y[`WB_INT_WB_CNT2] = wb_en_x && cnt_is_2;
assign wb_debug_x                   = wb;

//----------------------------------------------------------
//                    Producer Type
//----------------------------------------------------------
always @(posedge create_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_type[2:0] <= 3'b0;
  else if(rtu_idu_flush_wbt)
    inst_type[2:0] <= 3'b0;
  else if(create_en)
    inst_type[2:0] <= create_inst_type[2:0];
  else
    inst_type[2:0] <= inst_type[2:0];
end

assign read_data_y[`WB_INT_TYPE:`WB_INT_TYPE-2] = inst_type[2:0];

//----------------------------------------------------------
//                  Producer Counter
//----------------------------------------------------------
//indicates the number of un-wb producer:
//0: 1 producer left, 1: 2 producers left 2: 3 producers left
always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cnt[1:0] <= 2'b0;
  else if(rtu_idu_flush_wbt)
    cnt[1:0] <= 2'b0;
  else if(create_en || wb_en_x)
    cnt[1:0] <= cnt_update_val[1:0];
  else
    cnt[1:0] <= cnt[1:0];
end

assign cnt_is_1 = (cnt[1:0] == 2'd1);
assign cnt_is_2 = (cnt[1:0] == 2'd2);

// &CombBeg; @95
always @( wb_en_x
       or cnt[1:0]
       or create_en)
begin
  case({wb_en_x,create_en})
    2'b00:   cnt_update_val[1:0] = cnt[1:0];
    2'b01:   cnt_update_val[1:0] = cnt[1:0] + 2'b1;
    2'b10:   cnt_update_val[1:0] = cnt[1:0] - 2'b1;
    2'b11:   cnt_update_val[1:0] = cnt[1:0];
    default: cnt_update_val[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @103
end

assign read_data_y[`WB_INT_CNT:`WB_INT_CNT-1] = cnt[1:0];

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @130
// &Force("nonport","clk"); @131
// &Force("nonport","rst"); @132
// &Force("nonport","flush_idle"); @133
// &Force("nonport","async_flush"); @134

// &ModuleEnd; @170
endmodule


