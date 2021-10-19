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
module aq_dtu_cdc_lvl(
  clk,
  dst_lvl,
  rst_n,
  src_lvl
);

// &Ports; @21
input        clk;    
input        rst_n;  
input        src_lvl; 
output       dst_lvl; 

// &Regs; @22
reg          sync1;  
reg          sync2;  
reg          sync3;  

// &Wires; @23
wire         clk;    
wire         dst_lvl; 
wire         rst_n;  
wire         src_lvl; 


always @(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      sync1 <= 1'b0;
      sync2 <= 1'b0;
      sync3 <= 1'b0;
    end
  else 
    begin
      sync1 <= src_lvl;
      sync2 <= sync1;  
      sync3 <= sync2;
    end
end
assign dst_lvl = sync3;

// &ModuleEnd; @42
endmodule


