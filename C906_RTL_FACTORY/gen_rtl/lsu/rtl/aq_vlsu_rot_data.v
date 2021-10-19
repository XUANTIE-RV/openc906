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
module aq_vlsu_rot_data(
  data_in,
  data_out,
  rot_sel
);

// &Ports; @24
input   [63:0]  data_in;    
input   [7 :0]  rot_sel;    
output  [63:0]  data_out;   

// &Regs; @25
reg     [63:0]  data_settle; 

// &Wires; @26
wire    [63:0]  data;       
wire    [63:0]  data_in;    
wire    [63:0]  data_out;   
wire    [63:0]  data_rot0;  
wire    [63:0]  data_rot1;  
wire    [63:0]  data_rot2;  
wire    [63:0]  data_rot3;  
wire    [63:0]  data_rot4;  
wire    [63:0]  data_rot5;  
wire    [63:0]  data_rot6;  
wire    [63:0]  data_rot7;  
wire    [7 :0]  rot_sel;    


//================================================
//        input interface
//================================================
assign data[`LSU_DATAW-1:0]       = data_in[`LSU_DATAW-1:0];

//================================================
//        rot_sel
//================================================
assign data_rot0[`LSU_DATAW-1:0]  = data[`LSU_DATAW-1:0];
assign data_rot1[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-9:0],data[`LSU_DATAW-1:`LSU_DATAW-8]};
assign data_rot2[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-17:0],data[`LSU_DATAW-1:`LSU_DATAW-16]};
assign data_rot3[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-25:0],data[`LSU_DATAW-1:`LSU_DATAW-24]};
assign data_rot4[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-33:0],data[`LSU_DATAW-1:`LSU_DATAW-32]};
assign data_rot5[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-41:0],data[`LSU_DATAW-1:`LSU_DATAW-40]};
assign data_rot6[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-49:0],data[`LSU_DATAW-1:`LSU_DATAW-48]};
assign data_rot7[`LSU_DATAW-1:0]  = {data[`LSU_DATAW-57:0],data[`LSU_DATAW-1:`LSU_DATAW-56]};


// &CombBeg; @56
// &CombEnd; @76
// &CombBeg; @79
always @( data_rot5[63:0]
       or rot_sel[7:0]
       or data_rot0[63:0]
       or data_rot3[63:0]
       or data_rot6[63:0]
       or data_rot4[63:0]
       or data_rot1[63:0]
       or data_rot7[63:0]
       or data_rot2[63:0])
begin
case(rot_sel[7:0])
  8'h01:data_settle[`LSU_DATAW-1:0] = data_rot0[`LSU_DATAW-1:0];
  8'h02:data_settle[`LSU_DATAW-1:0] = data_rot1[`LSU_DATAW-1:0];
  8'h04:data_settle[`LSU_DATAW-1:0] = data_rot2[`LSU_DATAW-1:0];
  8'h08:data_settle[`LSU_DATAW-1:0] = data_rot3[`LSU_DATAW-1:0];
  8'h10:data_settle[`LSU_DATAW-1:0] = data_rot4[`LSU_DATAW-1:0];
  8'h20:data_settle[`LSU_DATAW-1:0] = data_rot5[`LSU_DATAW-1:0];
  8'h40:data_settle[`LSU_DATAW-1:0] = data_rot6[`LSU_DATAW-1:0];
  8'h80:data_settle[`LSU_DATAW-1:0] = data_rot7[`LSU_DATAW-1:0];
  default: data_settle[`LSU_DATAW-1:0] = {`LSU_DATAW{1'bx}};
endcase
// &CombEnd; @91
end
//================================================
//        output interface
//================================================
assign data_out[`LSU_DATAW-1:0] = data_settle[`LSU_DATAW-1:0];

// &ModuleEnd; @98
endmodule


