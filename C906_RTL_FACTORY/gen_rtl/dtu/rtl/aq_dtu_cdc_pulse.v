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
module aq_dtu_cdc_pulse(
  dst_clk,
  dst_pulse,
  dst_rstn,
  src_clk,
  src_pulse,
  src_rstn
);

// &Ports; @21
input        dst_clk;      
input        dst_rstn;     
input        src_clk;      
input        src_pulse;    
input        src_rstn;     
output       dst_pulse;    

// &Regs; @22
reg          dst_sync1;    
reg          dst_sync2;    
reg          dst_sync3;    
reg          dst_sync4;    
reg          src_lvl;      
reg          src_sync1;    
reg          src_sync2;    
reg          src_sync3;    
reg          src_sync4;    

// &Wires; @23
wire         clear_src_lvl; 
wire         dst_clk;      
wire         dst_pulse;    
wire         dst_rstn;     
wire         src_clk;      
wire         src_pulse;    
wire         src_rstn;     


always @(posedge src_clk or negedge src_rstn)
begin
  if(!src_rstn)
    src_lvl <= 1'b0;
  else if(src_pulse)
    src_lvl <= 1'b1;
  else if(clear_src_lvl)
    src_lvl <= 1'b0;
end

always @(posedge dst_clk or negedge dst_rstn)
begin
  if(!dst_rstn)
    begin
      dst_sync1 <= 1'b0;
      dst_sync2 <= 1'b0;
      dst_sync3 <= 1'b0;
      dst_sync4 <= 1'b0;
    end
  else
    begin
      dst_sync1 <= src_lvl;
      dst_sync2 <= dst_sync1;
      dst_sync3 <= dst_sync2;
      dst_sync4 <= dst_sync3;
    end
end

always @(posedge src_clk or negedge src_rstn)
begin
  if(!src_rstn)
    begin
      src_sync1 <= 1'b0;
      src_sync2 <= 1'b0;
      src_sync3 <= 1'b0;
      src_sync4 <= 1'b0;
    end
  else
    begin
      src_sync1 <= dst_sync3;
      src_sync2 <= src_sync1;
      src_sync3 <= src_sync2;
      src_sync4 <= src_sync3;
    end
end
assign clear_src_lvl = src_sync3 && !src_sync4;

assign dst_pulse = dst_sync3 && !dst_sync4;

// &ModuleEnd; @74
endmodule


