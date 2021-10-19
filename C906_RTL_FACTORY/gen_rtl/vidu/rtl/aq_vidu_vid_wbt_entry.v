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
module aq_vidu_vid_wbt_entry(
  cpurst_b,
  create_clk,
  create_en_x,
  dp_wbt_bankx_dstv_type,
  read_data_y,
  rtu_vidu_flush_wbt,
  rtu_yy_xx_async_flush,
  wb_clk,
  wb_debug_x,
  wb_en_x
);

// &Ports; @25
input          cpurst_b;              
input          create_clk;            
input          create_en_x;           
input          dp_wbt_bankx_dstv_type; 
input          rtu_vidu_flush_wbt;    
input          rtu_yy_xx_async_flush; 
input          wb_clk;                
input          wb_en_x;               
output  [2:0]  read_data_y;           
output         wb_debug_x;            

// &Regs; @26
reg            cnt;                   
reg            inst_type;             
reg            wb;                    

// &Wires; @27
wire           cnt_update_val;        
wire           cpurst_b;              
wire           create_clk;            
wire           create_en_x;           
wire           dp_wbt_bankx_dstv_type; 
wire    [2:0]  read_data_y;           
wire           rtu_vidu_flush_wbt;    
wire           rtu_yy_xx_async_flush; 
wire           wb_clk;                
wire           wb_debug_x;            
wire           wb_en_x;               


//==========================================================
//                     Entry Content
//==========================================================
//----------------------------------------------------------
//                      Write Back
//----------------------------------------------------------
always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb <= 1'b1;
  else if(rtu_vidu_flush_wbt || rtu_yy_xx_async_flush)
    wb <= 1'b1;
  else if(create_en_x)
    wb <= 1'b0;
  else if(wb_en_x && !cnt)
    wb <= 1'b1;
  else
    wb <= wb;
end
//treat writing back as same as wb
assign read_data_y[`WB_VEC_VLD] = wb || wb_en_x && !cnt;
assign wb_debug_x               = wb;

//----------------------------------------------------------
//                    Producer Type
//----------------------------------------------------------
always @(posedge create_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_type <= 1'b0;
  else if(rtu_vidu_flush_wbt || rtu_yy_xx_async_flush)
    inst_type <= 1'b0;
  else if(create_en_x)
    inst_type <= dp_wbt_bankx_dstv_type;
  else
    inst_type <= inst_type;
end

assign read_data_y[`WB_VEC_TYPE] = inst_type;

//----------------------------------------------------------
//                  Producer Counter
//----------------------------------------------------------
//indicates the number of un-wb producer:
//0: 1 producer left, 1: 2 producers left
always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cnt <= 1'b0;
  else if(rtu_vidu_flush_wbt || rtu_yy_xx_async_flush)
    cnt <= 1'b0;
  else if(create_en_x || wb_en_x)
    cnt <= cnt_update_val;
  else
    cnt <= cnt;
end
//increase cnt only when new lsu create to exist lsu entry
assign cnt_update_val = !wb && !wb_en_x
                            && create_en_x
                            && (dp_wbt_bankx_dstv_type == `WB_VEC_TYPE_VLSU);

assign read_data_y[`WB_VEC_CNT] = cnt;

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @114
// &Force("nonport","clk"); @115
// &Force("nonport","rst"); @116
// &Force("nonport","async_flush"); @117

// &ModuleEnd; @145
endmodule


